using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA
{
    public partial class FacilityView : System.Web.UI.Page
    {
        Label lblTitle;
        Label lblError;

        static string REQTYPE;
        static string FACIID;

        readonly FacilityBL FABL = new FacilityBL();
        readonly ParameterBL PABL = new ParameterBL();
        readonly SensorDeviceBL SDBL = new SensorDeviceBL();
        readonly LessonBL LSBL = new LessonBL();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblTitle = (Label)Master.FindControl("lblTitle");
            lblTitle.Text = "Facility";
            lblError = (Label)Master.FindControl("lblError");
            lblError.Text = "";

            TabName.Value = Request.Form[TabName.UniqueID];

            if (!Page.IsPostBack)
            {
                REQTYPE = Request.QueryString["RequestType"];
                if (REQTYPE == null)
                    Response.Redirect("FacilitySelect.aspx");
                else
                {
                    FACIID = Request.QueryString["FacilityID"];
                    ExcRequest();
                }
            }
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            Facility FaciObj = new Facility()
            {
                FacilityID = TbFacilityID.Text,
                FacilityCode = DdlFacilityCodeName.SelectedValue,
                ProjPhaseID = 1
            };

            string errorMsg = FABL.Validate(FaciObj, REQTYPE);
            if (errorMsg.Length > 0)
            {
                lblError.Text = errorMsg;
            }
            else
            {
                if (REQTYPE.Equals(CommonBL.ConstantType_Add))
                    FaciObj.CreateBy = (string)Session["LOGINUSER"];
                else
                    FaciObj.AmendBy = (string)Session["LOGINUSER"];

                int result = REQTYPE.Equals(CommonBL.ConstantType_Add) ? FABL.Create(FaciObj) : FABL.Update(FaciObj);
                switch (result)
                {
                    case 0:
                        Response.Redirect("FacilitySelect.aspx");
                        break;
                    case 1:
                        lblError.Text = "Oops! Something went wrong...Please contact Administrator. ";
                        break;
                    case 2:
                        lblError.Text = "Oops! Something went wrong...Please contact Administrator. ";
                        break;
                }
            }
        }

        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            int result = FABL.Delete(FACIID);
            switch (result)
            {
                case 0:
                    Response.Redirect("FacilitySelect.aspx");
                    break;
                case 1:
                    lblError.Text = "Oops! Something went wrong...Please contact Administrator. ";
                    break;
                case 2:
                    lblError.Text = "Oops! Something went wrong...Please contact Administrator. ";
                    break;
            }
        }

        protected void BtnSaveLesson_Click(object sender, EventArgs e)
        {
            Lesson LesObj = new Lesson()
            {
                LessonType = DdlLessonType.SelectedValue,
                ModuleCode = DdlModuleCode.SelectedValue,
                ModuleGrp1 = TbModuleGrp1.Text,
                ModuleGrp2 = TbModuleGrp2.Text,
                ModuleGrp3 = TbModuleGrp3.Text,
                ModuleGrp4 = TbModuleGrp4.Text,
                ModuleGrp5 = TbModuleGrp5.Text,
                ModuleGrp6 = TbModuleGrp6.Text,
                ModuleGrp7 = TbModuleGrp7.Text,
                ModuleGrp8 = TbModuleGrp8.Text,
                FacilityID = FACIID,
                DayOfWeek = DdlDayOfWeek.SelectedValue,
                TimeStart = CommonBL.DateTimeMapper(TbTimeFrom.Text),
                TimeEnd = CommonBL.DateTimeMapper(TbTimeTo.Text),
                Semester = DdlSemester.SelectedValue
            };

            string errorMsg = LSBL.Validate(LesObj);
            if (errorMsg.Length > 0)
            {
                lblError.Text = errorMsg;
            }
            else
            {
                LesObj.CreateBy = (string)Session["LOGINUSER"];
                int result = LSBL.Create(LesObj);
                switch (result)
                {
                    case 0:
                        PopulateLesson(FACIID);
                        lblTotalLessons.Text = $"Total Lessons conducted in {(DdlFacilityCodeName.SelectedValue == CommonBL.ConstantParameter_AutoGen ? DdlFacilityCodeName.SelectedValue + " Facility" : DdlFacilityCodeName.SelectedValue)}: {GvLesson.Rows.Count}";
                        break;
                    case 1:
                        lblError.Text = "Oops! Something went wrong...Please contact Administrator. ";
                        break;
                    case 2:
                        lblError.Text = "Oops! Something went wrong...Please contact Administrator. ";
                        break;
                }
            }
        }

        protected void Gv_PreRender(object sender, EventArgs e)
        {
            GridView Gv = (GridView)sender;
            if (Gv.HeaderRow != null)
            {
                Gv.HeaderRow.CssClass = "bg-dark text-white";
                Gv.UseAccessibleHeader = true;
                Gv.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void GvLesson_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int result = LSBL.Delete(int.Parse(e.CommandArgument.ToString()));
            if (result == 0)
            {
                PopulateLesson(FACIID);
                lblTotalLessons.Text = $"Total Lessons conducted in {(DdlFacilityCodeName.SelectedValue == CommonBL.ConstantParameter_AutoGen ? DdlFacilityCodeName.SelectedValue + " Facility" : DdlFacilityCodeName.SelectedValue)}: {GvLesson.Rows.Count}";
            }
            else
            {
                lblError.Text = "Oops! Something went wrong...Please contact Administrator. ";
            }
        }

        protected void ExcRequest()
        {
            PopulateFacilityCode(REQTYPE);
            PopulateLessonType();
            PopulateModuleCode();
            PopulateDayOfWeek();
            PopulateSemester();

            if (!REQTYPE.Equals(CommonBL.ConstantType_Add))
            {
                GetDetails(FACIID);
            }

            SetControlProperties(REQTYPE);
        }

        public void SetControlProperties(string reqtype)
        {
            TbFacilityID.Enabled = reqtype.Equals(CommonBL.ConstantType_Add);
            DdlFacilityCodeName.Enabled = !reqtype.Equals(CommonBL.ConstantType_View);

            ucViewFooter.Visible = !reqtype.Equals(CommonBL.ConstantType_Add);
            BtnSubmit.Visible = !reqtype.Equals(CommonBL.ConstantType_View);
            BtnDelete.Visible = reqtype.Equals(CommonBL.ConstantType_Update);
            sensors_tab.Visible = !reqtype.Equals(CommonBL.ConstantType_Add);
            lessons_tab.Visible = !reqtype.Equals(CommonBL.ConstantType_Add);

            if (lessons_tab.Visible)
            {
                divAddNew.Visible = DdlFacilityCodeName.SelectedValue != CommonBL.ConstantParameter_AutoGen;
                lblLessonWarning.Visible = !divAddNew.Visible;
            }
        }

        protected void GetDetails(string faciid)
        {
            Facility FaciObj = FABL.SelectByFacilityID(faciid);
            TbFacilityID.Text = FaciObj.FacilityID;
            DdlFacilityCodeName.SelectedValue = FaciObj.FacilityCode;
            ucViewFooter.CreateBy = FaciObj.CreateBy;
            ucViewFooter.CreateDate = FaciObj.CreateDate.ToString();
            ucViewFooter.AmendBy = FaciObj.AmendBy;
            ucViewFooter.AmendDate = FaciObj.AmendDate.ToString();

            PopulateSensorDevice(faciid);
            lblTotalSensors.Text = $"Total Sensors installed in {(DdlFacilityCodeName.SelectedValue == CommonBL.ConstantParameter_AutoGen ? DdlFacilityCodeName.SelectedValue + " Facility" : DdlFacilityCodeName.SelectedValue)}: {GvSensorDevice.Rows.Count}";

            PopulateLesson(faciid);
            lblTotalLessons.Text = $"Total Lessons conducted in {(DdlFacilityCodeName.SelectedValue == CommonBL.ConstantParameter_AutoGen ? DdlFacilityCodeName.SelectedValue + " Facility" : DdlFacilityCodeName.SelectedValue)}: {GvLesson.Rows.Count}";
        }

        protected void PopulateLesson(string faciid)
        {
            try
            {
                List<DisplayLesson> displayList = new List<DisplayLesson>();
                List<Lesson> LessonList = LSBL.SelectByFacilityID(faciid);
                foreach(Lesson LesObj in LessonList)
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

                    List<string> TICList = new List<string>()
                    {
                        LesObj.TIC1,
                        LesObj.TIC2,
                        LesObj.TIC3,
                        LesObj.TIC4
                    };

                    DisplayLesson DispObj = new DisplayLesson()
                    {
                        LessonID = LesObj.LessonID,
                        LessonType = LesObj.LessonType,
                        ModuleCodeName = $"{LesObj.ModuleCode} - {PABL.SelectByAllParaCode("MODULE", "SIT", LesObj.ModuleCode).Desc1}",
                        ModuleGrps = string.Join(", ", ModGrpList.Where(obj => !string.IsNullOrEmpty(obj)).ToList()),
                        TICs = string.Join(", ", TICList.Where(obj => !string.IsNullOrEmpty(obj)).ToList()),
                        DayOfWeek = LesObj.DayOfWeek,
                        TimeStart = LesObj.TimeStart.ToString("h:mm tt"),
                        TimeEnd = LesObj.TimeEnd.ToString("h:mm tt"),
                        WeekStart = LesObj.WeekStart,
                        WeekEnd = LesObj.WeekEnd,
                        Semester = LesObj.Semester
                    };

                    displayList.Add(DispObj);
                }

                displayList = displayList.OrderBy(obj => obj.Semester).ToList();
                GvLesson.DataSource = displayList;
                GvLesson.DataBind();

                
            }
            catch (Exception e)
            {
                CommonBL.LogError(this.GetType(), "PopulateLesson", e.Message);
            };
        }

        protected void PopulateSensorDevice(string faciid)
        {
            try
            {
                List<SensorDevice> DeviceList = SDBL.SelectByFacilityID(faciid);
                GvSensorDevice.DataSource = DeviceList;
                GvSensorDevice.DataBind();
            }
            catch (Exception e)
            {
                CommonBL.LogError(this.GetType(), "PopulateSensorDevice", e.Message);
            };

        }

        protected void PopulateFacilityCode(string reqtype)
        {
            List<DisplayFacility> displayList = new List<DisplayFacility>();
            List<Parameter> ParaList = PABL.SelectByParaCode1("FACILITY");
            if (reqtype.Equals(CommonBL.ConstantType_Add))
            {
                //Populate only non-existing facilities. Exclude auto-generated Facility Code.
                ParaList = ParaList.Where(obj => obj.Desc1 != CommonBL.ConstantParameter_AutoGen).ToList();
                foreach (Parameter ParaObj in ParaList)
                {
                    Facility FaciObj = FABL.SelectByFacilityCode(ParaObj.Desc1);
                    if (FaciObj == null)
                    {
                        DisplayFacility DispObj = new DisplayFacility()
                        {
                            FacilityCode = ParaObj.Desc1,
                            FacilityCodeName = $"{ParaObj.Desc1} - {ParaObj.Desc2}"
                        };

                        displayList.Add(DispObj);
                    }
                }
            }
            else
            {
                //Populate all facilities. Include auto-generated Facility Code only if that is its current value.
                Facility FaciObj = FABL.SelectByFacilityID(FACIID);
                if (FaciObj.FacilityCode != CommonBL.ConstantParameter_AutoGen)
                {
                    ParaList = ParaList.Where(obj => obj.Desc1 != CommonBL.ConstantParameter_AutoGen).ToList();
                }

                foreach (Parameter ParaObj in ParaList)
                {
                    DisplayFacility DispObj = new DisplayFacility()
                    {
                        FacilityCode = ParaObj.Desc1,
                        FacilityCodeName = $"{ParaObj.Desc1} - {ParaObj.Desc2}"
                    };

                    displayList.Add(DispObj);
                }
            }

            DdlFacilityCodeName.DataSource = displayList;
            DdlFacilityCodeName.DataTextField = "FacilityCodeName";
            DdlFacilityCodeName.DataValueField = "FacilityCode";
            DdlFacilityCodeName.DataBind();
        }

        protected void PopulateLessonType()
        {
            List<Parameter> ParamList = PABL.SelectByParaCode1("LESSON").Where(obj => obj.ParaCode2.Equals("TYPE")).ToList();
            DdlLessonType.DataSource = ParamList;
            DdlLessonType.DataTextField = "Desc1";
            DdlLessonType.DataValueField = "ParaCode3";
            DdlLessonType.DataBind();
        }

        protected void PopulateModuleCode()
        {
            List<DisplayModule> displayList = new List<DisplayModule>();
            List<Parameter> ParamList = PABL.SelectByParaCode1("MODULE").Where(obj => obj.ParaCode2.Equals("SIT")).ToList();
            foreach (Parameter ParamObj in ParamList)
            {
                DisplayModule DispObj = new DisplayModule()
                {
                    ModuleCode = ParamObj.ParaCode3,
                    ModuleCodeName = $"{ParamObj.ParaCode3} - {ParamObj.Desc1}"
                };
                displayList.Add(DispObj);
            }

            DdlModuleCode.DataSource = displayList;
            DdlModuleCode.DataTextField = "ModuleCodeName";
            DdlModuleCode.DataValueField = "ModuleCode";
            DdlModuleCode.DataBind();
        }

        protected void PopulateDayOfWeek()
        {
            List<Parameter> ParamList = PABL.SelectByParaCode1("CALENDAR").Where(obj => obj.ParaCode2.Equals("DAY")).ToList();
            DdlDayOfWeek.DataSource = ParamList;
            DdlDayOfWeek.DataTextField = "Desc1";
            DdlDayOfWeek.DataValueField = "ParaCode3";
            DdlDayOfWeek.DataBind();
        }

        protected void PopulateSemester()
        {
            List<Parameter> ParamList = PABL.SelectByParaCode1("SEMESTER");
            DdlSemester.DataSource = ParamList;
            DdlSemester.DataTextField = "Paracode3";
            DdlSemester.DataValueField = "Paracode3";
            DdlSemester.DataBind();
        }

        public class DisplayFacility
        {
            public string FacilityCode { get; set; }
            public string FacilityCodeName { get; set; }

            public DisplayFacility()
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
            public string LessonType { get; set; }
            public string ModuleCodeName { get; set; }
            public string ModuleGrps { get; set; }
            public string TICs { get; set; }
            public string DayOfWeek { get; set; }
            public string TimeStart { get; set; }
            public string TimeEnd { get; set; }
            public int WeekStart { get; set; }
            public int WeekEnd { get; set; }
            public string Semester { get; set; }

            public DisplayLesson()
            {

            }
        }
    }
}