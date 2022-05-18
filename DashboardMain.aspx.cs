using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA
{
    public partial class DashboardMain : System.Web.UI.Page
    {
        readonly SensorDeviceBL SDBL = new SensorDeviceBL();
        readonly SensorReadingBL SRBL = new SensorReadingBL();
        readonly ParameterBL PABL = new ParameterBL();
        readonly LessonBL LSBL = new LessonBL();
        readonly FacilityBL FABL = new FacilityBL();
        readonly QuestionnaireBL QUBL = new QuestionnaireBL();
        readonly QuestionnaireGroupBL QGBL = new QuestionnaireGroupBL();
        readonly ResponseBL REBL = new ResponseBL();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.Text = "";
            if (!Page.IsPostBack)
            {
                ExcRequest();
            }
        }

        protected void DdlOption_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateWeeks();
            SetControlProperties();
        }

        protected void DdlFacilityCodeName_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateModule();
            PopulateLesson();
            PopulateWeeks();
            SetControlProperties();
        }

        protected void DdlModuleCodeName_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateLesson();
            PopulateWeeks();
        }

        protected void DdlLesson_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateWeeks();
        }

        protected void DdlSubmittedBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateQuestionnaire();
            SetControlProperties();
        }

        protected void DdlQuestionnaire_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateSurveyChart();
        }

        protected void BtnGenerateChart_ServerClick(object sender, EventArgs e)
        {
            int numOfWeeks = int.Parse(DdlWeekTo.SelectedValue) - int.Parse(DdlWeekFrom.SelectedValue);
            if (numOfWeeks < 0)
                lblError.Text = "Please select an appropriate week range.";
            else
            {
                if (DdlOption.SelectedValue == "DAILYREADINGS")
                    DisplayCharts(0, DdlInterval.SelectedValue, DdlWeekFrom.SelectedValue, DdlWeekTo.SelectedValue);
                else if (DdlOption.SelectedValue == "MODULELESSON")
                {
                    if (DdlModuleCodeName.SelectedValue != CommonBL.ConstantParameter_AutoGen)
                        DisplayCharts(int.Parse(DdlLesson.SelectedValue), DdlInterval.SelectedValue, DdlWeekFrom.SelectedValue, DdlWeekTo.SelectedValue);
                    else
                        lblError.Text = "This facility currently has no lessons/modules conducted in it. Please select \"Daily Readings\" option instead.";
                }
            }
        }

        protected void ExcRequest()
        {
            PopulateFacilityCode();
            PopulateQuestionnaire();
            PopulateModule();
            PopulateLesson();
            PopulateWeeks();
            PopulateYears();
            SetControlProperties();
            DisplayCharts(0, DdlInterval.SelectedValue, DdlWeekFrom.SelectedValue, DdlWeekTo.SelectedValue);
        }

        protected void SetControlProperties()
        {
            DdlLesson.Enabled = DdlModuleCodeName.Enabled = DdlModuleCodeName.Items[0].Value != CommonBL.ConstantParameter_AutoGen;
            DdlQuestionnaire.Enabled = DdlQuestionnaire.Items[0].Value != CommonBL.ConstantParameter_AutoGen;
            divLessonDetails.Visible = divLecturers.Visible = divModule.Visible = divLesson.Visible = DdlOption.SelectedValue == "MODULELESSON";
            litModules.Visible = divModules.Visible = DdlOption.SelectedValue == "DAILYREADINGS";
            lblMainQns.Text = litSurveyResponses.Text = "";

            ChartJs SoundChart = new ChartJs()
            {
                Labels = new List<string>(),
                Datasets = new List<ChartJs.Dataset>()
            };

            ChartJs TempChart = new ChartJs()
            {
                Labels = new List<string>(),
                Datasets = new List<ChartJs.Dataset>()
            };

            ChartJs HumidChart = new ChartJs()
            {
                Labels = new List<string>(),
                Datasets = new List<ChartJs.Dataset>()
            };

            
            var jsonSerializerSettings = new JsonSerializerSettings
            {
                ContractResolver = new CamelCasePropertyNamesContractResolver()
            };

            SoundData.Value = JsonConvert.SerializeObject(SoundChart, jsonSerializerSettings);
            TempData.Value = JsonConvert.SerializeObject(TempChart, jsonSerializerSettings);
            HumidData.Value = JsonConvert.SerializeObject(HumidChart, jsonSerializerSettings);

        }

        protected void PopulateFacilityCode()
        {
            List<DisplayFacility> displayList = new List<DisplayFacility>();

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

        protected void PopulateWeeks()
        {
            int WeekStart = 1;
            int Count = 18;
            if (DdlOption.SelectedValue == "MODULELESSON")
            {
                //Overwrite weekStart and WeekEnd
                Lesson LesObj = LSBL.SelectByLessonID(CommonBL.IntegerMapper(DdlLesson.SelectedValue));
                if (LesObj != null)
                {
                    WeekStart = LesObj.WeekStart;
                    Count = LesObj.WeekEnd - LesObj.WeekStart + 1;
                }
            }

            List<DisplayWeek> ListOfWeeks = Enumerable.Range(WeekStart, Count).Select(obj => new DisplayWeek() { WeekNo = obj }).ToList();

            DdlWeekFrom.DataSource = ListOfWeeks;
            DdlWeekFrom.DataTextField = "WeekNo";
            DdlWeekFrom.DataValueField = "WeekNo";
            DdlWeekFrom.DataBind();

            DdlWeekTo.DataSource = ListOfWeeks;
            DdlWeekTo.DataTextField = "WeekNo";
            DdlWeekTo.DataValueField = "WeekNo";
            DdlWeekTo.DataBind();
        }

        protected void PopulateModule()
        {
            List<DisplayModule> displayList = new List<DisplayModule>();
            List<Lesson> LessonList = LSBL.SelectDistinctModulesByFacilityID(DdlFacilityCodeName.SelectedValue);
            foreach (Lesson LesObj in LessonList)
            {
                Parameter ParamObj = PABL.SelectByAllParaCode("MODULE", "SIT", LesObj.ModuleCode);
                DisplayModule DispObj = new DisplayModule()
                {
                    ModuleCode = ParamObj.ParaCode3,
                    ModuleCodeName = $"{ParamObj.ParaCode3} - {ParamObj.Desc2} ({ParamObj.Desc1})"
                };
                displayList.Add(DispObj);
            }
            StringBuilder sbModules = new StringBuilder();
            if (displayList.Count == 0)
            {
                //This Facility has no modules added yet.
                //Clear the list and disable this list later.
                DisplayModule DispObj = new DisplayModule()
                {
                    ModuleCode = CommonBL.ConstantParameter_AutoGen,
                    ModuleCodeName = "(This Facility is currently not in use for any module.)"
                };

                displayList.Add(DispObj);
                sbModules.Append($"<div>{DispObj.ModuleCodeName}<div>");
            }
            else
            {
                sbModules.Append("<h4 class=\"small font-weight-bold\">Module/Lessons conducted in this facility:</h4>");
                sbModules.Append("<ol class=\"text-dark font-weight-bold\">");
                foreach (DisplayModule DispObj in displayList)
                {
                    sbModules.Append($"<li>{DispObj.ModuleCodeName}</li>");
                }
                sbModules.Append("</ol>");
            }
            litModules.Text = sbModules.ToString();
            DdlModuleCodeName.DataSource = displayList;
            DdlModuleCodeName.DataTextField = "ModuleCodeName";
            DdlModuleCodeName.DataValueField = "ModuleCode";
            DdlModuleCodeName.DataBind();


        }

        protected void PopulateLesson()
        {
            List<DisplayLesson> displayList = new List<DisplayLesson>();
            List<Lesson> LessonList = LSBL.SelectByFacilityID(DdlFacilityCodeName.SelectedValue).Where(obj => obj.ModuleCode.Equals(DdlModuleCodeName.SelectedValue)).ToList();
            foreach (Lesson LesObj in LessonList)
            {
                List<string> ModGrpList = new List<string>()
                {
                    LesObj.ModuleGrp1,
                    LesObj.ModuleGrp2,
                    LesObj.ModuleGrp3,
                    LesObj.ModuleGrp4,
                    LesObj.ModuleGrp5,
                    LesObj.ModuleGrp6,
                    LesObj.ModuleGrp7,
                    LesObj.ModuleGrp8
                };

                DisplayLesson DispObj = new DisplayLesson()
                {
                    LessonID = LesObj.LessonID,
                    LessonDetails = $"WEEK {LesObj.WeekStart}-{LesObj.WeekEnd} {PABL.SelectByAllParaCode("LESSON", "TYPE", LesObj.LessonType).Desc1}, Every {LesObj.DayOfWeek}, {LesObj.TimeStart:h:mm tt} - {LesObj.TimeEnd:h:mm tt} (Module Grps: {string.Join(", ", ModGrpList.Where(obj => !string.IsNullOrEmpty(obj)).ToList())})"
                };

                displayList.Add(DispObj);
            }

            DdlLesson.DataSource = displayList;
            DdlLesson.DataTextField = "LessonDetails";
            DdlLesson.DataValueField = "LessonID";
            DdlLesson.DataBind();
        }

        protected void PopulateQuestionnaire()
        {
            List<DisplayQuestion> displayList = new List<DisplayQuestion>();
            List<QuestionnaireGroup> QnsGrpList = QGBL.Retrieve().Where(obj => obj.Category.Equals(DdlSubmittedBy.SelectedValue)).ToList();
            foreach (QuestionnaireGroup QnsGrpObj in QnsGrpList)
            {
                DisplayQuestion DispObj = new DisplayQuestion()
                {
                    ID = QnsGrpObj.QnsGroupID.ToString(),
                    Desc = $"{QnsGrpObj.Desc} {CommonBL.ConstantParameter_SubQns}",
                    Category = QnsGrpObj.Category
                };

                displayList.Add(DispObj);
            }

            List<Questionnaire> QnsList = QUBL.Retrieve().Where(obj => obj.HasQnsGroup == false && obj.Category.Equals(DdlSubmittedBy.SelectedValue)).ToList();
            foreach (Questionnaire QnsObj in QnsList)
            {
                DisplayQuestion DispObj = new DisplayQuestion()
                {
                    ID = QnsObj.QnsID.ToString(),
                    Desc = $"{QnsObj.Desc}",
                    Category = QnsObj.Category
                };

                displayList.Add(DispObj);
            }

            if (displayList.Count == 0)
            {
                //This Facility has no modules added yet.
                //Clear the list and disable this list later.
                DisplayQuestion DispObj = new DisplayQuestion()
                {
                    ID = CommonBL.ConstantParameter_AutoGen,
                    Desc = "There are currently no survey questions created by Administrator.",
                    Category = CommonBL.ConstantParameter_AutoGen
                };

                displayList.Add(DispObj);
            }
            DdlQuestionnaire.DataSource = displayList.OrderBy(obj => obj.Category).ToList();
            DdlQuestionnaire.DataTextField = "Desc";
            DdlQuestionnaire.DataValueField = "ID";
            DdlQuestionnaire.DataBind();
        }

        protected void PopulateYears()
        {
            int FROMYEAR = CommonBL.IntegerMapper(PABL.SelectByAllParaCode("ACADEMICYEAR", "PROJECTSTART", "").Desc1);
            int TOYEAR = CommonBL.IntegerMapper(PABL.SelectByAllParaCode("ACADEMICYEAR", "PROJECTEND", "").Desc1);

            List<DisplayYear> displayList = CommonBL.EachYear(new DateTime(FROMYEAR, 1, 1), new DateTime(TOYEAR, 1, 1)).Select(obj => new DisplayYear() { Year = obj.Year }).ToList();

            DdlFromYear.DataSource = displayList;
            DdlFromYear.DataTextField = "Year";
            DdlFromYear.DataValueField = "Year";
            DdlFromYear.DataBind();

            DdlToYear.DataSource = displayList;
            DdlToYear.DataTextField = "Year";
            DdlToYear.DataValueField = "Year";
            DdlToYear.DataBind();
        }

        protected void PopulateSurveyChart()
        {
            litSurveyResponses.Text = "";

            var jsonSerializerSettings = new JsonSerializerSettings
            {
                ContractResolver = new CamelCasePropertyNamesContractResolver()
            };

            //Get Semesters
            int FROMYEAR = CommonBL.IntegerMapper(DdlFromYear.SelectedValue);
            int TOYEAR = CommonBL.IntegerMapper(DdlToYear.SelectedValue);

            List<DateTime> YearList = CommonBL.EachYear(new DateTime(FROMYEAR, 1, 1), new DateTime(TOYEAR, 1, 1)).ToList();
            List<string> SurveyDataLabels = new List<string>();
            bool ShowSem1 = DdlSemester.SelectedValue == "1" || DdlSemester.SelectedValue == "Both";
            bool ShowSem2 = DdlSemester.SelectedValue == "2" || DdlSemester.SelectedValue == "Both";

            foreach (DateTime DateObj in YearList)
            {
                if (ShowSem1)
                    SurveyDataLabels.Add(DateObj.Year.ToString() + "S1");
                if (ShowSem2)
                    SurveyDataLabels.Add(DateObj.Year.ToString() + "S2");
            }
            //--------------Get the Survey Questions based on Category (All, Lecturer, Student)
            List<Questionnaire> QuestionnaireList = QUBL.Retrieve().Where(obj => obj.Category.Equals(DdlSubmittedBy.SelectedValue)).OrderBy(obj => obj.Category).ToList();
            //Further breakdown the list of questions based on whether Qns Has Sub Qns
            if (DdlQuestionnaire.SelectedItem.Text.Contains(CommonBL.ConstantParameter_SubQns))
            {
                //ID is from QuestionnaireGroup Table. May return 1 or more sub questions.
                QuestionnaireList = QuestionnaireList.Where(obj => obj.HasQnsGroup && obj.QnsGroupID == int.Parse(DdlQuestionnaire.SelectedValue)).ToList();
            }
            else
            {
                //ID is from Questionnaire Table. Should only return 1 question.
                QuestionnaireList = QuestionnaireList.Where(obj => !obj.HasQnsGroup && obj.QnsID == int.Parse(DdlQuestionnaire.SelectedValue)).ToList();
            }

            List<Response> ResponseList = REBL.Retrieve().Where(obj => obj.FacilityID.Equals(DdlFacilityCodeName.SelectedValue)).ToList();
            //Reduce calls to the DB server by using values already populated in the DropDownList.
            string ShowQnsOnly = DdlQuestionnaire.SelectedItem.Text.Replace(" " + CommonBL.ConstantParameter_SubQns, "");
            lblMainQns.Text = ShowQnsOnly;
            StringBuilder sbSurveyResults = new StringBuilder();
            //Set the response variables for each question type and their respective values
            foreach (Questionnaire QnsObj in QuestionnaireList)
            {
                if (QnsObj.Type.Equals("OPEN"))
                {
                    sbSurveyResults.Append($"<div class=\"bg-primary carousel-item{(QuestionnaireList.IndexOf(QnsObj) == 0 ? " active" : "")}\">");
                    sbSurveyResults.Append("<div class=\"h6 font-weight-bold\" style=\"color:black;\">");
                    sbSurveyResults.Append($"Qns {QnsObj.QnsNo}) {QnsObj.Desc}");
                    sbSurveyResults.Append("</div>");

                    sbSurveyResults.Append("<div class=\"position-relative\">");
                    sbSurveyResults.Append($"<canvas id=\"{QnsObj.Type}_SurveyChartCanvas_{QnsObj.QnsID}\"></canvas>");
                    sbSurveyResults.Append("</div>");

                    var ResponseList2 = ResponseList.Where(obj => obj.QnsID.Equals(QnsObj.QnsID)).ToList();
                    List<string> FactorLabels = new List<string>();
                    List<float> FactorData = new List<float>();
                    foreach (Response FeedObj in ResponseList2)
                    {
                        FactorLabels.Add(FeedObj.RespDesc);
                        FactorData.Add(1);
                    }

                    List<ChartJs.Dataset> FactorDatasetList = new List<ChartJs.Dataset>();
                    ChartJs.Dataset FactorDataset = new ChartJs.Dataset()
                    {
                        Label = "",
                        Data = FactorData
                    };
                    FactorDatasetList.Add(FactorDataset);
                    ChartJs FactorChart = new ChartJs()
                    {
                        Labels = FactorLabels,
                        Datasets = FactorDatasetList
                    };

                    var SurveyDataValue = JsonConvert.SerializeObject(FactorChart, jsonSerializerSettings);

                    sbSurveyResults.Append($"<input type=\"hidden\" id=\"{QnsObj.Type}_MainSurveyChartData_{QnsObj.QnsID}\" name=\"{QnsObj.Type}_MainSurveyChartData{QnsObj.QnsID}\" value=\'{SurveyDataValue}\'>");
                    sbSurveyResults.Append("</div>");
                }
                else if (QnsObj.Type.Equals("QUAL") || QnsObj.Type.Equals("QUAN") || QnsObj.Type.Equals("FACTORLEC") || QnsObj.Type.Equals("FACTORSTU") || QnsObj.Type.Equals("CUSTOMEVER") || QnsObj.Type.Equals("CUSTOMWILL"))
                {
                    sbSurveyResults.Append($"<div class=\"carousel-item{(QuestionnaireList.IndexOf(QnsObj) == 0 ? " active" : "")}\">");
                    sbSurveyResults.Append("<div class=\"h6 font-weight-bold\" style=\"color:black;\">");
                    sbSurveyResults.Append($"Qns {QnsObj.QnsNo}) {QnsObj.Desc}");
                    sbSurveyResults.Append("</div>");

                    sbSurveyResults.Append("<div class=\"position-relative\">");
                    sbSurveyResults.Append($"<canvas id=\"{QnsObj.Type}_SurveyChartCanvas_{QnsObj.QnsID}\"></canvas>");
                    sbSurveyResults.Append("</div>");

                    List<Parameter> ParamList = PABL.SelectByParaCode1And2("SURVEY", QnsObj.Type).ToList(); //For Chart Labels
                    List<ChartJs.Dataset> FactorDatasetList = new List<ChartJs.Dataset>();
                    foreach (Parameter ParamObj in ParamList)
                    {
                        List<float> FactorData = new List<float>();
                        foreach (string semester in SurveyDataLabels)
                        {
                            Parameter StartToEndDateObj = PABL.SelectByAllParaCode("SEMESTER", "StartToEndDate", semester);
                            if (StartToEndDateObj != null)
                            {
                                DateTime StartDate = CommonBL.DateTimeMapper(StartToEndDateObj.Desc1);
                                DateTime EndDate = CommonBL.DateTimeMapper(StartToEndDateObj.Desc2);

                                List<Response> temporaryRespList;
                                //Count for each survey option
                                if (QnsObj.Type == "FACTORSTU" || QnsObj.Type == "FACTORLEC")
                                    temporaryRespList = ResponseList.Where(RespObj => RespObj.QnsID.Equals(QnsObj.QnsID) && RespObj.RespDesc.Contains(ParamObj.Desc1) && RespObj.DateTimeStamp >= StartDate && RespObj.DateTimeStamp <= EndDate).ToList();
                                else
                                    temporaryRespList = ResponseList.Where(RespObj => RespObj.QnsID.Equals(QnsObj.QnsID) && RespObj.RespDesc == ParamObj.Desc1 && RespObj.DateTimeStamp >= StartDate && RespObj.DateTimeStamp <= EndDate).ToList();

                                FactorData.Add(temporaryRespList.Count);
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
                                sbSurveyResults.Append($"<input type=\"hidden\" id=\"{thisSurveyOption}_{QnsObj.Type}_SubSurveyChartData_{QnsObj.QnsID}\" name=\"{thisSurveyOption}_{QnsObj.Type}_SubSurveyChartData_{QnsObj.QnsID}\" value=\'{SubSurveyDataValue}\'>");
                            }
                            else
                            {
                                FactorData.Add(0);
                            }
                        }

                        ChartJs.Dataset FactorDataset = new ChartJs.Dataset()
                        {
                            Label = ParamObj.Desc1,
                            Data = FactorData
                        };
                        FactorDatasetList.Add(FactorDataset);
                    }

                    ChartJs FactorChart = new ChartJs()
                    {
                        Labels = SurveyDataLabels.ToList(),
                        Datasets = FactorDatasetList
                    };

                    var SurveyDataValue = JsonConvert.SerializeObject(FactorChart, jsonSerializerSettings);

                    sbSurveyResults.Append($"<input type=\"hidden\" id=\"{QnsObj.Type}_MainSurveyChartData_{QnsObj.QnsID}\" name=\"{QnsObj.Type}_MainSurveyChartData{QnsObj.QnsID}\" value=\'{SurveyDataValue}\'>");
                    sbSurveyResults.Append("</div>");
                }
            }

            litSurveyResponses.Text = sbSurveyResults.ToString();
        }

        protected string PopulateAvgChartData(string chartName, string readingType)
        {
            //Get YEARS, SEMESTERS, TERMS, WEEKS to be displayed. JSON data structure is set according to chartjs-plugin-hierarchical V.3.1.0 in addition to the basic ChartJs JSON data structure.
            //Read API documentation for more info on types of response keys and values: https://github.com/sgratzl/chartjs-plugin-hierarchical

            //For Average readings, Exclude outliers (i.e. Days with no or zero-value readings)
            bool excludeOutliers = true;

            StringBuilder hiddenFieldValue = new StringBuilder();

            List<Hierarchical_ChartJs.HierarchicalChartLabel> ChartLabels = new List<Hierarchical_ChartJs.HierarchicalChartLabel>();
            List<Hierarchical_ChartJs.HierarchicalChartData> Tree = new List<Hierarchical_ChartJs.HierarchicalChartData>();

            int FROMYEAR = CommonBL.IntegerMapper(DdlFromYear.SelectedValue);
            int TOYEAR = CommonBL.IntegerMapper(DdlToYear.SelectedValue);
            List<DateTime> YearList = CommonBL.EachYear(new DateTime(FROMYEAR, 1, 1), new DateTime(TOYEAR, 1, 1)).ToList();

            List<string> SemList = new List<string>();
            if (DdlSemester.SelectedValue == "1" || DdlSemester.SelectedValue == "Both")
                SemList.Add("S1");
            if (DdlSemester.SelectedValue == "2" || DdlSemester.SelectedValue == "Both")
                SemList.Add("S2");

            List<string> TermList = new List<string>() { "T1", "T2" };

            foreach (DateTime YEAR in YearList)
            {
                var YEAR_Label_Obj_Child = new List<object>();
                var YEAR_Data_Obj_Child = new List<object>();

                foreach (string SEMESTER in SemList)
                {
                    Parameter ParamObj = PABL.SelectByAllParaCode("SEMESTER", "StartToEndDate", YEAR.Year + SEMESTER);

                    var SEMESTER_Label_Obj_Child = new List<object>();
                    var SEMESTER_Data_Obj_Child = new List<object>();

                    foreach (string TERM in TermList)
                    {
                        var TERM_Label_Obj_Child = new List<object>();
                        var TERM_Data_Obj_Child = new List<object>();

                        List<double> WeeklyAvgReading = new List<double>();

                        List<int> WeekList = new List<int>();
                        if (TERM.Equals("T1"))
                            WeekList = Enumerable.Range(1, 8).ToList();
                        else if (TERM.Equals("T2"))
                            WeekList = Enumerable.Range(11, 8).ToList();
                        foreach (int WEEK in WeekList)
                        {
                            List<DateTime> AllDates = new List<DateTime>();
                            DateTime semesterStart = CommonBL.DateTimeMapper(ParamObj.Desc1);
                            DateTime semesterEnd = CommonBL.DateTimeMapper(ParamObj.Desc2);
                            DateTime StartDateRange = semesterStart.AddDays((WEEK * 7) - 7); //Note: Time should be 08:00
                            DateTime EndDateRange = CommonBL.DateTimeMapper(StartDateRange.AddDays(4 + (WEEK - 1) * 7).ToShortDateString()).AddHours(21); //Note: Time should be 21:00 

                            List<SensorReading> DeviceAvgList = new List<SensorReading>();
                            List<SensorDevice> DeviceList = SDBL.SelectByFacilityID(DdlFacilityCodeName.SelectedValue);
                            float ReadingTotal = 0;
                            int countSensorDevicesWithZeroAvg = 0;
                            foreach (SensorDevice DeviceObj in DeviceList)
                            {
                                //Linq is never quicker than pure foreach. Use it only in convenient, non-time-critical places. 
                                //This block of code, however, is retrieving 60*24 records per day, *7 of that per week, *16 of that per semester, *2 of that per year
                                //Thus we should use a custom Select() method that performs the query directly on the DB server instead

                                //Get Average Reading for ONE device
                                float DeviceAvgReading = SRBL.SelectAvgReadingByDeviceIDAndDateTimeStamp(readingType, DeviceObj.DeviceID, StartDateRange, EndDateRange, excludeOutliers);
                                if (DeviceAvgReading == 0 && excludeOutliers)
                                    countSensorDevicesWithZeroAvg += 1;
                                else
                                    ReadingTotal += DeviceAvgReading;
                            }

                            //Get Average Reading of ALL devices
                            double AvgReading = 0;
                            var countDeviceList = DeviceList.Count() - countSensorDevicesWithZeroAvg;
                            AvgReading = countDeviceList != 0 ? Math.Round(ReadingTotal / countDeviceList, 1) : 0;
                            //For Humidity Multiply by 100 as it was stored as percentage
                            if (readingType == CommonBL.ConstantSensorReadingType_Humid)
                                AvgReading *= 100;

                            WeeklyAvgReading.Add(AvgReading);
                        }
                        foreach (int WEEK in WeekList)
                        {
                            var WEEK_Label_Obj = new Hierarchical_ChartJs.HierarchicalChartLabel()
                            {
                                Label = $"WK {WEEK}"
                            };
                            TERM_Label_Obj_Child.Add(WEEK_Label_Obj);

                            if (ParamObj != null)
                                TERM_Data_Obj_Child.Add(WeeklyAvgReading[WeekList.IndexOf(WEEK)]);
                            else
                                TERM_Data_Obj_Child.Add(0);
                        }

                        var TERM_Label_Obj = new Hierarchical_ChartJs.HierarchicalChartLabel()
                        {
                            Label = TERM,
                            Children = TERM_Label_Obj_Child
                        };
                        SEMESTER_Label_Obj_Child.Add(TERM_Label_Obj);

                        var TERM_Data_Obj = new Hierarchical_ChartJs.HierarchicalChartData()
                        {
                            Value = TERM_Data_Obj_Child.Count > 0 ? Math.Round(TERM_Data_Obj_Child.Cast<double>().ToList().Average(), 1) : 0,
                            Children = TERM_Data_Obj_Child
                        };
                        SEMESTER_Data_Obj_Child.Add(TERM_Data_Obj);
                    }

                    Hierarchical_ChartJs.HierarchicalChartLabel SEMESTER_Label_Obj = new Hierarchical_ChartJs.HierarchicalChartLabel()
                    {
                        Label = SEMESTER,
                        Expand = false,
                        Children = SEMESTER_Label_Obj_Child
                    };

                    Hierarchical_ChartJs.HierarchicalChartData SEMESTER_Data_Obj = new Hierarchical_ChartJs.HierarchicalChartData()
                    {
                        Value = Math.Round(SEMESTER_Data_Obj_Child.Cast<Hierarchical_ChartJs.HierarchicalChartData>().Sum(obj => obj.Value) / 2, 1),
                        Children = SEMESTER_Data_Obj_Child
                    };

                    YEAR_Label_Obj_Child.Add(SEMESTER_Label_Obj);
                    YEAR_Data_Obj_Child.Add(SEMESTER_Data_Obj);
                }

                Hierarchical_ChartJs.HierarchicalChartLabel YEAR_Label_Obj = new Hierarchical_ChartJs.HierarchicalChartLabel()
                {
                    Label = YEAR.Year.ToString(),
                    Expand = true,
                    Children = YEAR_Label_Obj_Child
                };
                ChartLabels.Add(YEAR_Label_Obj);

                Hierarchical_ChartJs.HierarchicalChartData YEAR_Data_Obj = new Hierarchical_ChartJs.HierarchicalChartData()
                {
                    Value = Math.Round(YEAR_Data_Obj_Child.Cast<Hierarchical_ChartJs.HierarchicalChartData>().Sum(obj => obj.Value) / 2, 1),
                    Children = YEAR_Data_Obj_Child
                };
                Tree.Add(YEAR_Data_Obj);
            }

            Hierarchical_ChartJs.Dataset ChartDataset = new Hierarchical_ChartJs.Dataset()
            {
                Tree = Tree
            };
            List<Hierarchical_ChartJs.Dataset> ChartDatasets = new List<Hierarchical_ChartJs.Dataset>() { ChartDataset };


            Hierarchical_ChartJs DataObj = new Hierarchical_ChartJs()
            {
                Labels = ChartLabels,
                Datasets = ChartDatasets
            };

            var jsonSerializerSettings = new JsonSerializerSettings
            {
                ContractResolver = new CamelCasePropertyNamesContractResolver()
            };

            var DataValue = JsonConvert.SerializeObject(DataObj, jsonSerializerSettings);

            hiddenFieldValue.Append($"<input type=\"hidden\" id=\"{chartName}Data\" name=\"{chartName}Data\" value=\'{DataValue}\'>");

            return hiddenFieldValue.ToString();
        }

        protected void DisplayCharts(int lessonid, string interval, string startweek, string endweek)
        {
            //In this method, we will attempt to get the sensor readings and survey responses based on the filters that the user have selected. 
            //At the same time, we are going to create the JSON string that is equivalent to a ChartJS data object. Doing this enables us to set the chart data iteratively.
            //Note: If lessonid == "0", it simply means that we are going to get daily readings. Else, we get readings per selected module/lesson.

            // -------------------- PART 1: Get sensor readings based on whether displayOption is "Daily Readings" or "Per Selected Module/Lesson" --------------------
            //Get the time range
            Lesson LesObj = LSBL.SelectByLessonID(lessonid);
            TimeSpan STARTHOUR = (lessonid != 0) ? LesObj.TimeStart.TimeOfDay : TimeSpan.Parse("08:00");
            TimeSpan ENDHOUR = (lessonid != 0) ? LesObj.TimeEnd.TimeOfDay : TimeSpan.Parse("21:00");
            List<string> AllTimes = CommonBL.GetDayTimeIntervalInRange(STARTHOUR, ENDHOUR, int.Parse(interval));

            //Get the date range
            List<DateTime> AllDates = new List<DateTime>();
            if (lessonid != 0)
            {
                DayOfWeek DayOfWeek = CommonBL.DayOfWeekMapper(PABL.SelectByAllParaCode("CALENDAR", "DAY", LesObj.DayOfWeek).Desc1);
                Parameter ParamObj = PABL.SelectByAllParaCode("SEMESTER", "StartToEndDate", LesObj.Semester);
                DateTime semesterStart = CommonBL.DateTimeMapper(ParamObj.Desc1);
                DateTime semesterEnd = CommonBL.DateTimeMapper(ParamObj.Desc2);
                DateTime StartDateRange = semesterStart.AddDays((CommonBL.IntegerMapper(startweek) * 7) - 7);
                DateTime EndDateRange = semesterEnd.AddDays((18 - CommonBL.IntegerMapper(endweek)) * -7);
                AllDates = CommonBL.GetWeekdayInRange(StartDateRange, EndDateRange, DayOfWeek);
            }
            else
            {
                Parameter ParamObj = PABL.SelectByAllParaCode("SEMESTER", "StartToEndDate", "2021S1");
                DateTime semesterStart = CommonBL.DateTimeMapper(ParamObj.Desc1);
                DateTime semesterEnd = CommonBL.DateTimeMapper(ParamObj.Desc2);
                DateTime StartDateRange = semesterStart.AddDays((CommonBL.IntegerMapper(startweek) * 7) - 7);
                DateTime EndDateRange = semesterEnd.AddDays((18 - CommonBL.IntegerMapper(endweek)) * -7);
                AllDates = CommonBL.EachDay(StartDateRange, EndDateRange).ToList();
                AllDates = AllDates.Where(obj => obj.DayOfWeek != DayOfWeek.Saturday && obj.DayOfWeek != DayOfWeek.Sunday).ToList();
            }

            //Get the corresponding academic week for all dates in date range
            List<DisplayDate> DispDateList = new List<DisplayDate>();
            int WeekStartCount = CommonBL.IntegerMapper(DdlWeekFrom.SelectedValue);
            foreach (DateTime DateObj in AllDates)
            {
                DisplayDate DispObj = new DisplayDate()
                {
                    DateObj = DateObj,
                    CorrespondingWeekNo = WeekStartCount
                };

                DispDateList.Add(DispObj);
                WeekStartCount++;
            }

            //Get readings from each device installed in the selected facility
            List<SensorDevice> DeviceList = SDBL.SelectByFacilityID(DdlFacilityCodeName.SelectedValue);

            List<string> DeviceIDList = DeviceList.Select(obj => obj.DeviceID).ToList();
            List<SensorReading> ReadingList = SRBL.SelectByDeviceID(DeviceIDList);
            SensorReading LastReading = ReadingList.OrderByDescending(obj => obj.DateTimeStamp).FirstOrDefault();
            lblLastUpdate.Text = (LastReading != null) ? LastReading.DateTimeStamp.ToString("dd/MM/yyyy hh:mm tt") : "-";

            List<ChartJs.Dataset> SoundDatasetList = new List<ChartJs.Dataset>();
            List<ChartJs.Dataset> TempDatasetList = new List<ChartJs.Dataset>();
            List<ChartJs.Dataset> HumidDatasetList = new List<ChartJs.Dataset>();

            var jsonSerializerSettings = new JsonSerializerSettings
            {
                ContractResolver = new CamelCasePropertyNamesContractResolver()
            };

            spanAverageNoise.InnerText = "";
            List<float> SoundDataEachDispDate = new List<float>();
            List<float> TempDataEachDispDate = new List<float>();
            List<float> HumidDataEachDispDate = new List<float>();
            foreach (DisplayDate DispDateObj in DispDateList)
            {
                List<float> SoundData = new List<float>();
                List<float> TempData = new List<float>();
                List<float> HumidData = new List<float>();

                foreach (string TimeString in AllTimes)
                {
                    //Since devices are installed in the same facility and are active during the same period of time, despite ther physical positions, they should have a reading that was taken synchronously.
                    //Find the average of these readings to display as the overall reading of that facility at a given date-time stamp.
                    List<SensorReading> ThisDateTimeReadingList = ReadingList.Where(obj => obj.DateTimeStamp.ToString("dd/MM/yyyy").Equals(DispDateObj.DateObj.Date.ToString("dd/MM/yyyy")) && obj.DateTimeStamp.ToString("HH:mm").Equals(TimeString)).ToList();
                    if (ThisDateTimeReadingList.Count > 0)
                    {
                        //Reading for this date-time stamp exists.
                        SoundData.Add(ThisDateTimeReadingList.Average(obj => obj.Sound));
                        TempData.Add(ThisDateTimeReadingList.Average(obj => obj.Temperature));
                        HumidData.Add(ThisDateTimeReadingList.Average(obj => obj.Humidity));
                    }
                    else
                    {
                        //Reading for this date-time stamp does not exist in DB (most likely because the sensor(s) did not record it). Set average reading to default values (i.e. 0)
                        SoundData.Add(0);
                        TempData.Add(0);
                        HumidData.Add(0);
                    }
                }

                SoundDataEachDispDate.Add(SoundData.Average());
                TempDataEachDispDate.Add(TempData.Average());
                HumidDataEachDispDate.Add(HumidData.Average());

                //Chart Label should reflect WeekNo if displayOption was "Module/Lesson". Otherwise, show the individual daily dates.
                ChartJs.Dataset SoundDataset = new ChartJs.Dataset()
                {
                    Label = DdlOption.SelectedValue == "MODULELESSON" ? $"Week {DispDateObj.CorrespondingWeekNo}" : DispDateObj.DateObj.ToString("dd/MM/yyyy"),
                    Data = SoundData
                };
                SoundDatasetList.Add(SoundDataset);

                ChartJs.Dataset TempDataset = new ChartJs.Dataset()
                {
                    Label = DdlOption.SelectedValue == "MODULELESSON" ? $"Week {DispDateObj.CorrespondingWeekNo}" : DispDateObj.DateObj.ToString("dd/MM/yyyy"),
                    Data = TempData
                };
                TempDatasetList.Add(TempDataset);

                ChartJs.Dataset HumidDataset = new ChartJs.Dataset()
                {
                    Label = DdlOption.SelectedValue == "MODULELESSON" ? $"Week {DispDateObj.CorrespondingWeekNo}" : DispDateObj.DateObj.ToString("dd/MM/yyyy"),
                    Data = HumidData
                };
                HumidDatasetList.Add(HumidDataset);
            }

            spanAverageNoise.InnerText = Math.Round(SoundDataEachDispDate.Average(), 1).ToString();
            spanAverageTemp.InnerText = Math.Round(TempDataEachDispDate.Average(), 1).ToString();
            spanAverageHumid.InnerText = Math.Round(HumidDataEachDispDate.Average(), 1).ToString();
            //Get Lesson Details (if applicable)
            StringBuilder sbLessonDetails = new StringBuilder();
            Dictionary<int, DisplayLessonDetails> Dict = new Dictionary<int, DisplayLessonDetails>();
            if (LesObj != null)
            {
                //TODO: Implement feature that shows attendance rate per lesson. Show lesson details (e.g. topic difficulty)
            }
            var LessonDetailsDataValue = JsonConvert.SerializeObject(Dict, jsonSerializerSettings);
            sbLessonDetails.Append($"<input type=\"hidden\" id=\"LessonDetailsData\" name=\"LessonDetailsData\" value=\'{LessonDetailsDataValue}\'>");
            litLessonDetails.Text = sbLessonDetails.ToString();

            StringBuilder sbLecturers = new StringBuilder();
            sbLecturers.Append("<h4 class=\"small font-weight-bold\">Lecturer(s) in Charge:</h4>");
            if (LesObj != null)
            {
                sbLecturers.Append("<ul>");
                if (LesObj.TIC1 != "")
                    sbLecturers.Append($"<li>{LesObj.TIC1}</li>");
                if (LesObj.TIC2 != "")
                    sbLecturers.Append($"<li>{LesObj.TIC2}</li>");
                if (LesObj.TIC3 != "")
                    sbLecturers.Append($"<li>{LesObj.TIC3}</li>");
                if (LesObj.TIC4 != "")
                    sbLecturers.Append($"<li>{LesObj.TIC4}</li>");
                sbLecturers.Append("</ul>");
            }
            else
            {
                sbLecturers.Append("<div>Info Unavailable<div>");
            }
            litLecturers.Text = sbLecturers.ToString();

            ChartJs SoundChart = new ChartJs()
            {
                Labels = AllTimes,
                Datasets = SoundDatasetList
            };

            ChartJs TempChart = new ChartJs()
            {
                Labels = AllTimes,
                Datasets = TempDatasetList
            };

            ChartJs HumidChart = new ChartJs()
            {
                Labels = AllTimes,
                Datasets = HumidDatasetList
            };

            SoundData.Value = JsonConvert.SerializeObject(SoundChart, jsonSerializerSettings);
            TempData.Value = JsonConvert.SerializeObject(TempChart, jsonSerializerSettings);
            HumidData.Value = JsonConvert.SerializeObject(HumidChart, jsonSerializerSettings);

            //-------------------- PART 2: Get survey responses per Academic Year/Sem --------------------
            PopulateSurveyChart();
            //-------------------- PART 3: Get average sensor readings per Academic Year/Sem to compliment Survey Responses Chart --------------------
            litSoundAvgChartData.Text = PopulateAvgChartData("SoundAvgChart", CommonBL.ConstantSensorReadingType_Sound);
            litTempAvgChartData.Text = PopulateAvgChartData("TempAvgChart", CommonBL.ConstantSensorReadingType_Temp);
            litHumidAvgChartData.Text = PopulateAvgChartData("HumidAvgChart", CommonBL.ConstantSensorReadingType_Humid);
        }

        public class DisplayFacility
        {
            public string FacilityID { get; set; }
            public string FacilityCodeName { get; set; }

            public DisplayFacility()
            {

            }
        }

        public class DisplayWeek
        {
            public int WeekNo { get; set; }
            public DisplayWeek()
            {

            }
        }

        public class DisplayModule
        {
            public string ModuleCode { get; set; }
            public string ModuleCodeName { get; set; }
            public DisplayModule()
            {

            }
        }

        public class DisplayLesson
        {
            public int LessonID { get; set; }
            public string LessonDetails { get; set; }
            public DisplayLesson()
            {

            }
        }

        public class DisplayDate
        {
            public DateTime DateObj { get; set; }
            public int CorrespondingWeekNo { get; set; }
            public DisplayDate()
            {

            }
        }

        public class DisplayLessonDetails
        {
            public string Topic { get; set; }
            public string Remark { get; set; }
            public string Difficulty { get; set; }
            public float AttendanceRate { get; set; }
            public float AverageNoise { get; set; }
            public DisplayLessonDetails()
            {

            }
        }

        public class DisplayQuestion
        {
            //This ID could represent QnsGroupID (For Group Qns) or Qns ID (For Ungrouped Qns). Use string datatype so it can store #Auto Gen value
            public string ID { get; set; }
            //To distinguish whether ID is representing QnsGroupID or QnsID, Desc will be extended with a variable stating whether this DisplayQuestion obj has sub qns
            public string Desc { get; set; }
            public string Category { get; set; }
            public DisplayQuestion()
            {

            }
        }

        public class DisplayYear
        {
            public int Year { get; set; }
            public DisplayYear()
            {

            }
        }
    }
}