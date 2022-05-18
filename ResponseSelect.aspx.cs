using ClosedXML.Excel;
using MoreLinq;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA
{
    public partial class ResponseSelect : System.Web.UI.Page
    {
        Label lblTitle;
        Label lblError;

        readonly ResponseBL REBL = new ResponseBL();
        readonly QuestionnaireBL QUBL = new QuestionnaireBL();
        readonly ParameterBL PABL = new ParameterBL();
        readonly FacilityBL FABL = new FacilityBL();

        static List<Questionnaire> SurveyQnsList = new List<Questionnaire>();
        static List<Questionnaire> NewQnsList = new List<Questionnaire>();
        static List<Response> NewResponseList = new List<Response>();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblTitle = (Label)Page.Master.FindControl("lblTitle");
            lblTitle.Text = "Response";
            lblError = (Label)Page.Master.FindControl("lblError");
            lblError.Text = "";

            if (!Page.IsPostBack)
            {
                ExcRequest();
            }
        }

        protected void ExcRequest()
        {
            NewQnsList.Clear();
            NewResponseList.Clear();
            SetControlProperties();
            PopulateSemester();
            GetDetails(DdlSemester.SelectedValue);
            PopulateFacilityCode();
        }

        protected void DdlSemester_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetDetails(DdlSemester.SelectedValue);
        }

        protected void SetControlProperties()
        {
            divUploadCard.Visible = true;
            divNewQns.Visible = false;
            divAddRemarks.Visible = false;
            divFormButtons.Visible = false;

            lblTotalQns.Text = lblTotalResp.Text = lblSuccessCount.Text = lblErrorCount.Text = lblUnverifiedCount.Text = "0";
            lblChartsSummary.Text = litCharts.Text = "";
        }

        protected void PopulateSemester()
        {
            List<Parameter> ParamList = PABL.SelectByParaCode1And2("SEMESTER", "StartToEndDate");
            DdlSemester.DataSource = ParamList;
            DdlSemester.DataTextField = "ParaCode3";
            DdlSemester.DataValueField = "ParaCode3";
            DdlSemester.DataBind();
        }

        protected void PopulateFacilityCode()
        {
            List<DisplayFacility> displayList = new List<DisplayFacility>();

            //Populate only created facilities. Exclude auto-generated Facility
            List<Facility> FaciList = FABL.Retrieve().Where(obj => obj.FacilityCode != CommonBL.ConstantParameter_AutoGen).ToList();
            foreach (Facility FaciObj in FaciList)
            {
                Parameter ParaObj = PABL.SelectByAllParaCode("FACILITY", FaciObj.FacilityCode.Substring(0, 1), FaciObj.FacilityCode.Substring(1));
                DisplayFacility DispObj = new DisplayFacility()
                {
                    FacilityID = FaciObj.FacilityID,
                    FacilityCodeName = $"{ParaObj.Desc1} - {ParaObj.Desc2}"
                };

                displayList.Add(DispObj);
            }

            DdlFacilityCodeName.DataSource = displayList;
            DdlFacilityCodeName.DataTextField = "FacilityCodeName";
            DdlFacilityCodeName.DataValueField = "FacilityID";
            DdlFacilityCodeName.DataBind();
        }

        protected void GetDetails(string semester)
        {
            Parameter ParamObj = PABL.SelectByAllParaCode("SEMESTER", "StartToEndDate", semester);
            lblSemester.Text = $"{CommonBL.DateTimeMapper(ParamObj.Desc1).ToShortDateString()} - {CommonBL.DateTimeMapper(ParamObj.Desc2).ToShortDateString()}";
        }

        protected void BtnUpload_Click(object sender, EventArgs e)
        {
            lblTotalQns.Text = "0";
            lblTotalResp.Text = "0";
            //Save the uploaded Excel file.
            try
            {
                if (fuResponse.HasFile)
                {
                    if (CommonBL.CheckValidExcelFile(fuResponse.PostedFile.FileName))
                    {
                        string filePath = Server.MapPath("~/SurveyResponse/") + Path.GetFileName(fuResponse.PostedFile.FileName);
                        fuResponse.SaveAs(filePath);

                        //Open the Excel file using ClosedXML.
                        using (XLWorkbook workBook = new XLWorkbook(filePath))
                        {
                            //Read the first Sheet from Excel file.
                            IXLWorksheet workSheet = workBook.Worksheet(1);

                            int EXPECTEDTOTAL = CommonBL.IntegerMapper(workSheet.Cell("B1").Value.ToString());
                            int SUCCESSCOUNT = CommonBL.IntegerMapper(workSheet.Cell("B2").Value.ToString());
                            int ERRORCOUNT = CommonBL.IntegerMapper(workSheet.Cell("B3").Value.ToString());
                            int UNVERIFIEDRESPONSECOUNT = CommonBL.IntegerMapper(workSheet.Cell("B4").Value.ToString());

                            List<Questionnaire> SurveyQuestionnaire = new List<Questionnaire>();
                            List<ResponseFromExcel> RespList = new List<ResponseFromExcel>();
                            //Loop through the Worksheet rows.
                            bool firstRow = true;
                            int LastRow = workSheet.Rows().Last().RowNumber();
                            foreach (IXLRow row in workSheet.Rows(6, LastRow))
                            {
                                //Use the first row to get list of Survey Questions and determine their type
                                if (firstRow)
                                {
                                    int i = 1;
                                    foreach (IXLCell cell in row.Cells())
                                    {
                                        string qnstype = cell.CellAbove().Value.ToString();
                                        string desc = cell.Value.ToString();
                                        //Since auto-create qns function is checking if survey qns match qns already stored in server character by character, make sure to get rid of trailing spaces, extra spaces in between as well as other formats of apostrophes
                                        desc = CommonBL.CleanText(desc);

                                        if (desc != "Response ID" && desc != "Timestamp" && desc != "Download Status" && desc != "Group" && desc != "My ID")
                                        {
                                            Questionnaire SurveyQnsObj = new Questionnaire()
                                            {
                                                QnsID = i, //We use the qnsNo as a temporary unique identifier to match the responses to their respective questions from the SURVEY, not the server
                                                QnsNo = i,
                                                Type = qnstype,
                                                Desc = desc
                                            };

                                            SurveyQuestionnaire.Add(SurveyQnsObj);
                                            i++;
                                        }
                                    }

                                    firstRow = false;
                                    SurveyQnsList = SurveyQuestionnaire;
                                }
                                else
                                {
                                    int i = 1;
                                    IXLCells responses = row.Cells($"{(hiddenRadioFieldValue.Value == "Student" ? 6 : 4)}:{SurveyQuestionnaire.Count + (hiddenRadioFieldValue.Value == "Student" ? 5 : 3)}");
                                    foreach (IXLCell response in responses)
                                    {
                                        ResponseFromExcel RespFromExcObj = new ResponseFromExcel()
                                        {
                                            ResponseID = row.Cell("1").Value.ToString(),
                                            Timestamp = row.Cell("2").Value.ToString(),
                                            DownloadStatus = row.Cell("3").Value.ToString(),
                                            RespondentGrp = hiddenRadioFieldValue.Value == "Student" ? row.Cell("4").Value.ToString() : "",
                                            RespondentID = hiddenRadioFieldValue.Value == "Student" ? row.Cell("5").Value.ToString() : "",
                                            QnsID = i,
                                            RespDesc = response.Value.ToString()
                                        };

                                        RespList.Add(RespFromExcObj);
                                        i++;
                                    }
                                }
                            }

                            //Delete file from solution folder afterwards
                            FileInfo file = new FileInfo(filePath);
                            if (file.Exists)//Should exist but just check 
                            {
                                file.Delete();
                            }
                            UploadSuccess(RespList, SurveyQuestionnaire, EXPECTEDTOTAL, SUCCESSCOUNT, ERRORCOUNT, UNVERIFIEDRESPONSECOUNT);
                        }
                    }
                    else
                    {
                        lblError.Text = "Extension 'csv' is not supported. Supported extensions are '.xlsx', '.xlsm', '.xltx' and '.xltm'.";
                    }
                }
                else
                {
                    lblError.Text = "No files uploaded.";
                }
            }
            catch (Exception exc)
            {
                CommonBL.LogError(this.GetType(), "btnUpload_Click", exc.Message);
                lblError.Text = "Failed to upload file. " + (exc.Message.Contains("The process cannot access the file") ? "Please ensure file is closed before uploading." : exc.Message.Contains("Cannot find") ? "Ensure sheet is in correct format." : "Unknown Error");
            }
        }

        public void UploadSuccess(List<ResponseFromExcel> RespList, List<Questionnaire> SurveyQns, int expectedtotal, int successcount, int errorcount, int unverifiedresponsecount)
        {
            divUploadCard.Visible = false;
            divFormButtons.Visible = true;

            lblChartsSummary.Text = $"{hiddenRadioFieldValue.Value}s' Responses on Facility {DdlFacilityCodeName.SelectedItem.Text} in Academic Year/Sem {DdlSemester.SelectedValue}: {lblSemester.Text})";

            lblTotalQns.Text = SurveyQns.Count.ToString();

            lblTotalResp.Text = expectedtotal.ToString();
            lblSuccessCount.Text = successcount.ToString();
            lblErrorCount.Text = errorcount.ToString();
            lblUnverifiedCount.Text = unverifiedresponsecount.ToString();

            //Store static object
            NewResponseList.Clear();
            foreach (ResponseFromExcel RespFromExcObj in RespList)
            {
                if (RespFromExcObj.DownloadStatus.Equals("Success"))
                {
                    Response RespObj = new Response()
                    {
                        ResponseID = RespFromExcObj.ResponseID,
                        DateTimeStamp = CommonBL.DateTimeMapper(RespFromExcObj.Timestamp),
                        FacilityID = DdlFacilityCodeName.SelectedValue,
                        //TODO: Add new column RespondentGroup in DB
                        RespondentID = RespFromExcObj.RespondentID,
                        //Note: This QnsID represents the temporary qnsNo associated with the qns found in SURVEY, not the QnsID in server.
                        QnsID = RespFromExcObj.QnsID,
                        RespDesc = RespFromExcObj.RespDesc
                    };
                    NewResponseList.Add(RespObj);
                }
            }

            StringBuilder sbNewQnsList = new StringBuilder();
            NewQnsList.Clear();
            foreach (Questionnaire SurveyQnsObj in SurveyQns)
            {
                //Check if qns already exists. 
                //Should NOT be determined by QnsNo as it may return ambiguous results. Note: DB allows duplicate of QnsNo as it may come from different survey forms with varying qns no.
                //Should also NOT be determined by QnsID as they do not hold the same meaning. (ID from SurveyQnsObj is actually based off QnsNo)
                Questionnaire DBQnsObj = QUBL.SelectByQnsDesc(SurveyQnsObj.Desc);
                if (DBQnsObj == null)
                {
                    //Only start appending string if a new qns was identitied.
                    if (sbNewQnsList.Length == 0)
                    {
                        sbNewQnsList.Append("<ul>");
                    }
                    sbNewQnsList.Append($"<li>{SurveyQnsObj.QnsNo}){SurveyQnsObj.Desc}</li>");
                    //Append to static array of NEW questions so it may be accessed again later when submitting form
                    NewQnsList.Add(SurveyQnsObj);
                }
            }
            if (sbNewQnsList.Length != 0)
            {
                sbNewQnsList.Append("</ul>");
            }
            litNewQns.Text = sbNewQnsList.ToString();
            divNewQns.Visible = !string.IsNullOrEmpty(litNewQns.Text);

            divAddRemarks.Visible = errorcount > 0 || unverifiedresponsecount > 0;

            StringBuilder sbSurveyResults = new StringBuilder();
            var jsonSerializerSettings = new JsonSerializerSettings
            {
                ContractResolver = new CamelCasePropertyNamesContractResolver()
            };
            Parameter SemesterParamObj = PABL.SelectByAllParaCode("SEMESTER", "StartToEndDate", DdlSemester.SelectedValue);
            DateTime StartDate = CommonBL.DateTimeMapper(SemesterParamObj.Desc1);
            DateTime EndDate = CommonBL.DateTimeMapper(SemesterParamObj.Desc2);
            sbSurveyResults.Append("<div class=\"row no-gutters align-items-stretch\">");
            foreach (Questionnaire SurveyQnsObj in SurveyQns)
            {
                if (SurveyQnsObj.Type.Equals("QUAL") || SurveyQnsObj.Type.Equals("QUAN") || SurveyQnsObj.Type.Equals("FACTORLEC") || SurveyQnsObj.Type.Equals("FACTORSTU") || SurveyQnsObj.Type.Equals("CUSTOMEVER") || SurveyQnsObj.Type.Equals("CUSTOMWILL"))
                {
                    sbSurveyResults.Append($"<div class=\"{(SurveyQnsObj.Type.Equals("FACTORLEC") || SurveyQnsObj.Type.Equals("FACTORSTU") ? "col-lg-8" : "col-lg-4")} mt-5 border shadow p-3\">");
                    sbSurveyResults.Append("<div class=\"h6 text-dark font-weight-bold\">");
                    sbSurveyResults.Append($"{SurveyQnsObj.QnsNo}) {SurveyQnsObj.Desc}");
                    sbSurveyResults.Append("</div>");
                    sbSurveyResults.Append($"<canvas id=\"{SurveyQnsObj.Type}_SurveyChartCanvas_{SurveyQnsObj.QnsID}\"></canvas>");
                    //Get a list of survey options based on this question type
                    List<Parameter> ParamList = PABL.SelectByParaCode1And2("SURVEY", SurveyQnsObj.Type).ToList();
                    List<string> MainPieLabels = new List<string>();
                    List<float> MainPieData = new List<float>();
                    //Count the number of responses for a specific survey option while creating the list of survey options and counting the number of students from each module group who answered that Survey Option
                    foreach (Parameter ParamObj in ParamList)
                    {
                        MainPieLabels.Add(ParamObj.Desc1);

                        List<Response> temporaryRespList;
                        //Count for each survey option
                        if (SurveyQnsObj.Type == "FACTORSTU" || SurveyQnsObj.Type == "FACTORLEC")
                            temporaryRespList = NewResponseList.Where(RespObj => RespObj.QnsID.Equals(SurveyQnsObj.QnsID) && RespObj.RespDesc.Contains(ParamObj.Desc1) && RespObj.DateTimeStamp >= StartDate && RespObj.DateTimeStamp <= EndDate).ToList();
                        else
                            temporaryRespList = NewResponseList.Where(RespObj => RespObj.QnsID.Equals(SurveyQnsObj.QnsID) && RespObj.RespDesc == ParamObj.Desc1 && RespObj.DateTimeStamp >= StartDate && RespObj.DateTimeStamp <= EndDate).ToList();

                        MainPieData.Add(temporaryRespList.Count);
                        //Each survey option has a sub pie which shows the number of students from each PEM Group who answered that survey option
                        //TODO: List of PEM Groups to be populated from the current batch of students occupying the Facility
                        List<string> SubPieLabels = new List<string>() { "Grp 1", "Grp 2", "Grp 3" };
                        List<float> SubPieData = new List<float>() {
                        temporaryRespList.Count(obj => obj.RespondentID.Contains("A")),
                        temporaryRespList.Count(obj => obj.RespondentID.Contains("B")),
                        temporaryRespList.Count(obj => obj.RespondentID.Contains("C"))
                        };

                        ChartJs.Dataset SubDataset = new ChartJs.Dataset()
                        {
                            //For pie chart, not necessary to define dataset label
                            Label = "",
                            Data = SubPieData
                        };

                        List<ChartJs.Dataset> SubDatasetList = new List<ChartJs.Dataset>() { SubDataset };

                        ChartJs SubChart = new ChartJs()
                        {
                            Labels = SubPieLabels.ToList(),
                            Datasets = SubDatasetList
                        };

                        var SubSurveyDataValue = JsonConvert.SerializeObject(SubChart, jsonSerializerSettings);

                        string thisSurveyOption = CommonBL.ReplaceWhitespace(ParamObj.Desc1, "");
                        sbSurveyResults.Append($"<input type=\"hidden\" id=\"{thisSurveyOption}_{SurveyQnsObj.Type}_SubSurveyChartData_{SurveyQnsObj.QnsID}\" name=\"{thisSurveyOption}_{SurveyQnsObj.Type}_SubSurveyChartData_{SurveyQnsObj.QnsID}\" value=\'{SubSurveyDataValue}\'>");
                    }

                    ChartJs.Dataset MainDataset = new ChartJs.Dataset()
                    {
                        //For pie chart, not necessary to define dataset label
                        Label = "",
                        Data = MainPieData
                    };

                    List<ChartJs.Dataset> MainDatasetList = new List<ChartJs.Dataset>() { MainDataset };

                    ChartJs MainChart = new ChartJs()
                    {
                        Labels = MainPieLabels.ToList(),
                        Datasets = MainDatasetList
                    };

                    var MainSurveyDataValue = JsonConvert.SerializeObject(MainChart, jsonSerializerSettings);

                    sbSurveyResults.Append($"<input type=\"hidden\" id=\"{SurveyQnsObj.Type}_MainSurveyChartData_{SurveyQnsObj.QnsID}\" name=\"{SurveyQnsObj.Type}_MainSurveyChartData_{SurveyQnsObj.QnsID}\" value=\'{MainSurveyDataValue}\'>");
                    sbSurveyResults.Append("</div>");
                }
                else if (SurveyQnsObj.Type.Equals("OPEN"))
                {
                    sbSurveyResults.Append("<div class=\"col-lg-8 mt-5 border shadow p-3\">");
                    sbSurveyResults.Append("<div class=\"h6 text-dark font-weight-bold\">");
                    sbSurveyResults.Append($"{SurveyQnsObj.QnsNo}) {SurveyQnsObj.Desc}");
                    sbSurveyResults.Append("</div>");
                    sbSurveyResults.Append($"<canvas id=\"{SurveyQnsObj.Type}_SurveyChartCanvas_{SurveyQnsObj.QnsID}\"></canvas>");
                    var temporaryRespList = NewResponseList.Where(obj => obj.QnsID.Equals(SurveyQnsObj.QnsID)).ToList();
                    List<string> MainPieLabels = new List<string>();
                    List<float> MainPieData = new List<float>();
                    int countBlank = 0;
                    foreach (Response RespObj in temporaryRespList)
                    {
                        if (!string.IsNullOrEmpty(RespObj.RespDesc) && RespObj.RespDesc != "-" && RespObj.RespDesc != "NIL")
                        {
                            MainPieLabels.Add(RespObj.RespDesc);
                            //Different respondents are unlikely to have entered the same input word for word hence we can consider each open feedback as an entity itself
                            MainPieData.Add(1);
                        }
                        else
                            countBlank += 1;

                        if(countBlank > 0)
                        {
                            MainPieLabels.Add("Blank Response");
                            //Different respondents are unlikely to have entered the same input word for word hence we can consider each open feedback as an entity itself
                            MainPieData.Add(countBlank);
                        }

                    }

                    List<ChartJs.Dataset> MainDatasetList = new List<ChartJs.Dataset>();
                    ChartJs.Dataset MainDataset = new ChartJs.Dataset()
                    {
                        Label = "",
                        Data = MainPieData
                    };
                    MainDatasetList.Add(MainDataset);
                    ChartJs MainChart = new ChartJs()
                    {
                        Labels = MainPieLabels,
                        Datasets = MainDatasetList
                    };

                    var SurveyDataValue = JsonConvert.SerializeObject(MainChart, jsonSerializerSettings);

                    sbSurveyResults.Append($"<input type=\"hidden\" id=\"{SurveyQnsObj.Type}_MainSurveyChartData_{SurveyQnsObj.QnsID}\" name=\"{SurveyQnsObj.Type}_MainSurveyChartData_{SurveyQnsObj.QnsID}\" value=\'{SurveyDataValue}\'>");
                    sbSurveyResults.Append("</div>");
                }
            }
            sbSurveyResults.Append("</div>");
            int CountResponses = RespList.Where(obj => obj.DownloadStatus.Equals("Success")).DistinctBy(obj => obj.ResponseID).ToList().Count;
            sbSurveyResults.Append($"<input type=\"hidden\" id=\"totalResponses\" name=\"totalResponses\" value=\"{CountResponses}\">");

            litCharts.Text = sbSurveyResults.ToString();
        }

        public void SweetAlert(string errorMsg)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "SweetAlert(\'" + errorMsg + "\')", true);
        }

        public class ResponseFromExcel
        {
            public string ResponseID { get; set; }
            public string Timestamp { get; set; }
            public string DownloadStatus { get; set; }
            public string RespondentGrp { get; set; }
            public string RespondentID { get; set; }
            public int QnsID { get; set; }
            public string RespDesc { get; set; }

            public ResponseFromExcel()
            {

            }
        }

        public class DisplayFacility
        {
            public string FacilityID { get; set; }
            public string FacilityCodeName { get; set; }

            public DisplayFacility()
            {

            }
        }

        protected void BtnUploadNew_Click(object sender, EventArgs e)
        {
            SetControlProperties();
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            //Create new questions first
            foreach (Questionnaire QnsObj in NewQnsList)
            {
                QnsObj.CreateBy = (string)Session["LOGINUSER"];
                int result = QUBL.Create(QnsObj);
                if (result == 0)
                    continue;
                else
                {
                    lblError.Text = "Failed to auto-create new Questions";
                    break;
                }
            }
            if (lblError.Text.Length == 0)
            {
                //Then create Response
                foreach (Response RespObj in NewResponseList)
                {
                    RespObj.CreateBy = (string)Session["LOGINUSER"];
                    //Need to overwrite QnsID as previously it represented the QnsNo of that survey question. Now that all questions have been confirmed to exist in the DB, use the actual QnsID
                    string qnsdesc = SurveyQnsList.Where(obj => obj.QnsID.Equals(RespObj.QnsID)).First().Desc;
                    //Get the actual id from server
                    Questionnaire QnsObj = QUBL.SelectByQnsDesc(qnsdesc);
                    RespObj.QnsID = QnsObj.QnsID;
                    //TODO: Prevent duplicate by checking if a student/lecturer's responses were previously uploaded. Must check upload batch. 
                    //Cannot solely depend on ResponseID as it can be duplicated
                    int result = REBL.Create(RespObj);
                    if (result == 0)
                        continue;
                    else
                    {
                        lblError.Text = "Failed to save Response";
                        break;
                    }
                }
            }
            //TODO: Show success message

            NewQnsList.Clear();
            NewResponseList.Clear();
            SetControlProperties();
        }
    }
}