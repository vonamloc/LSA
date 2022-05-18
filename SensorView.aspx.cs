using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json.Serialization;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using FireSharp.Config;
using FireSharp.Response;
using FireSharp.Interfaces;
using Xceed.Wpf.Toolkit;

namespace LSA
{
    public partial class SensorView : System.Web.UI.Page
    {
        Label lblTitle;
        Label lblError;

        static string BEARERTOKEN;
        static string REQTYPE;
        static string DEVICEID;
        static string SOUNDLEVEL;
        static string TEMPERATURE;
        static string HUMIDITY;
        static string MOTION;

        readonly SensorReadingBL SRBL = new SensorReadingBL();
        readonly SensorDeviceBL SDBL = new SensorDeviceBL();
        readonly FacilityBL FABL = new FacilityBL();
        readonly ParameterBL PABL = new ParameterBL();
        readonly LessonBL LSBL = new LessonBL();

       
        protected void Page_Load(object sender, EventArgs e)
        {
            lblTitle = (Label)Master.FindControl("lblTitle");
            lblTitle.Text = "Sensors";
            lblError = (Label)Master.FindControl("lblError");
            lblError.Text = "";

            TabName.Value = Request.Form[TabName.UniqueID];

            if (!Page.IsPostBack)
            {
                if (Session["BEARERTOKEN"] != null)
                    BEARERTOKEN = (string)Session["BEARERTOKEN"];

                REQTYPE = Request.QueryString["RequestType"];
                if (REQTYPE == null)
                    Response.Redirect("SensorSelect.aspx");
                else
                {
                    DEVICEID = Request.QueryString["DeviceID"];

                    if (Session["APIrequest"] != null)
                    {
                        string APIREQUEST = (string)Session["APIrequest"];
                        Session["APIrequest"] = null;
                        if (APIREQUEST == CommonBL.ConstantAPIendpoint_customGETALLREADINGS)
                        {
                            //Ensure user have attained bearer token
                            if (!string.IsNullOrEmpty(BEARERTOKEN))
                            {
                                GetAndSaveAPIData();
                            }
                        }
                    }

                    ExcRequest();
                    GetAndSaveAPIData();
                }
            }
        }

        protected void DdlFacilityID_SelectedIndexChanged(object sender, EventArgs e)
        {
            Facility FaciObj = FABL.SelectByFacilityID(DdlFacilityID.SelectedValue);
            TbFacilityCodeName.Text = FaciObj.FacilityCode + " - " + ((FaciObj.FacilityCode == CommonBL.ConstantParameter_AutoGen) ? PABL.SelectByAllParaCode("FACILITY", "", "").Desc2 : PABL.SelectByAllParaCode("FACILITY", FaciObj.FacilityCode.Substring(0, 1), FaciObj.FacilityCode.Substring(1)).Desc2);

        }

        protected void DdlModuleCodeName_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateLesson();
        }
        protected void DdlOption_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateWeeks();
            SetControlProperties(REQTYPE);
        }

        protected void DdlLesson_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateWeeks();
        }

        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            //TODO: Delete sensor device from Minut Account and server
            //For more information on how to delete device from Minut Account: https://api.minut.com/latest/docs/#tag/Devices/paths/~1devices~1{device_id}/delete
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            SensorDevice DeviceObj = new SensorDevice()
            {
                DeviceID = TbDeviceID.Text,
                DeviceMAC = TbDeviceMAC.Text,
                DeviceName = TbDeviceName.Text,
                FacilityID = DdlFacilityID.SelectedValue,
                DevicePosition = DdlDevPosition.SelectedValue
            };

            if (REQTYPE.Equals(CommonBL.ConstantType_Add))
            {
                DeviceObj.FirstSeen = DateTime.Now;
                DeviceObj.LastHeard = DateTime.Now;
                DeviceObj.LastHeartBeat = DateTime.Now;
                DeviceObj.AlarmRecognition = "off";
                DeviceObj.PowerSaveMode = "off";
                DeviceObj.ListeningMode = "interval";
                DeviceObj.ActiveStatus = false;
                DeviceObj.CreateBy = (string)Session["LOGINUSER"];
                int result = SDBL.Create(DeviceObj);
                if (result == 0)
                {
                    Response.Redirect("SensorSelect.aspx");
                }
                else
                {
                    lblError.Text = "Oops! Something went wrong...Please contact Administrator.";
                }
            }
            if (REQTYPE.Equals(CommonBL.ConstantType_Update))
            {
                DeviceObj.FirstSeen = CommonBL.DateTimeMapper(TbActivateDate.Text);
                DeviceObj.LastHeard = CommonBL.DateTimeMapper(TbLastHeard.Text);
                DeviceObj.LastHeartBeat = CommonBL.DateTimeMapper(TbLastBeat.Text);
                DeviceObj.AlarmRecognition = DdlAlarmRecog.SelectedValue;
                DeviceObj.PowerSaveMode = DdlPowerSaveMode.SelectedValue;
                DeviceObj.ListeningMode = DdlListenMode.SelectedValue;
                DeviceObj.ActiveStatus = CommonBL.BoolMapper(DdlActiveStatus.SelectedValue);
                DeviceObj.AmendBy = (string)Session["LOGINUSER"];
                int result = SDBL.Update(DeviceObj);
                if (result == 0)
                {
                    Response.Redirect("SensorSelect.aspx");
                }
                else
                {
                    lblError.Text = "Oops! Something went wrong...Please contact Administrator.";
                }
            }

            lblError.Visible = !string.IsNullOrEmpty(lblError.Text);
        }

        protected void BtnSearchReadingByWeek_ServerClick(object sender, EventArgs e)
        {
            DisplayChart();
        }

        protected void BtnGetLatestReading_Click(object sender, EventArgs e)
        {
            if (Session["BEARERTOKEN"] == null)
            {
                //Acquire BearerToken first
                Session["APIrequest"] = CommonBL.ConstantAPIendpoint_customGETALLREADINGS;
                Session["TransferTo"] = $"SensorView.aspx?RequestType={REQTYPE}&DeviceID={DEVICEID}";
                GetBearerToken();
            }
            else
            {
                GetAndSaveAPIData();
            }
        }

        protected void BtnGenerateChart_ServerClick(object sender, EventArgs e)
        {
            DisplayChart();
        }

        protected void ExcRequest()
        {
            PopulateFacilityID();
            PopulateWeeks();
            PopulateDevicePosition();

            if (!REQTYPE.Equals(CommonBL.ConstantType_Add))
            {
                PopulateModuleCode();
                PopulateLesson();
                GetDetails(DEVICEID);
            }

            SetControlProperties(REQTYPE);
        }

        protected void SetControlProperties(string reqtype)
        {
            TbDeviceID.Enabled = reqtype.Equals(CommonBL.ConstantType_Add);
            TbDeviceMAC.Enabled = reqtype.Equals(CommonBL.ConstantType_Add);
            TbDeviceName.Enabled = !reqtype.Equals(CommonBL.ConstantType_View);
            DdlFacilityID.Enabled = reqtype.Equals(CommonBL.ConstantType_Add);
            TbFacilityCodeName.Enabled = false;
            DdlDevPosition.Enabled = !reqtype.Equals(CommonBL.ConstantType_View);
            TbActivateDate.Enabled = false;
            TbLastHeard.Enabled = false;
            TbLastBeat.Enabled = false;

            if (!reqtype.Equals(CommonBL.ConstantType_Add))
            {
                DdlLesson.Enabled = DdlModuleCodeName.Enabled = DdlModuleCodeName.Items[0].Value != CommonBL.ConstantParameter_AutoGen;
            }


            DdlListenMode.Enabled = !reqtype.Equals(CommonBL.ConstantType_View);
            DdlPowerSaveMode.Enabled = !reqtype.Equals(CommonBL.ConstantType_View);
            DdlAlarmRecog.Enabled = !reqtype.Equals(CommonBL.ConstantType_View);
            DdlActiveStatus.Enabled = !reqtype.Equals(CommonBL.ConstantType_View);

            divActivateDate.Visible = !reqtype.Equals(CommonBL.ConstantType_Add);
            divLastHeard.Visible = !reqtype.Equals(CommonBL.ConstantType_Add);
            divLastBeat.Visible = !reqtype.Equals(CommonBL.ConstantType_Add);
            ucViewFooter.Visible = !reqtype.Equals(CommonBL.ConstantType_Add);
            BtnSubmit.Visible = !reqtype.Equals(CommonBL.ConstantType_View);
            BtnDelete.Visible = reqtype.Equals(CommonBL.ConstantType_Update);
            readings_tab.Visible = !reqtype.Equals(CommonBL.ConstantType_Add);
            settings_tab.Visible = !reqtype.Equals(CommonBL.ConstantType_Add);
        }

        protected void GetDetails(string deviceid)
        {
            SensorDevice DeviceObj = SDBL.SelectByDeviceID(deviceid);
            List<string> DeviceIDList = new List<string>() { deviceid };
            SensorReading LastReading = SRBL.SelectByDeviceID(DeviceIDList).OrderByDescending(obj => obj.DateTimeStamp).FirstOrDefault();
            Facility FaciObj = FABL.SelectByFacilityID(DeviceObj.FacilityID);

            TbDeviceID.Text = DeviceObj.DeviceID;
            TbDeviceMAC.Text = DeviceObj.DeviceMAC;
            TbDeviceName.Text = DeviceObj.DeviceName;
            DdlFacilityID.SelectedValue = DeviceObj.FacilityID;
            TbFacilityCodeName.Text = FaciObj.FacilityCode + " - " + ((FaciObj.FacilityCode == CommonBL.ConstantParameter_AutoGen) ? PABL.SelectByAllParaCode("FACILITY", "", "").Desc2 : PABL.SelectByAllParaCode("FACILITY", FaciObj.FacilityCode.Substring(0, 1), FaciObj.FacilityCode.Substring(1)).Desc2);
            DdlDevPosition.SelectedValue = DeviceObj.DevicePosition;
            TbActivateDate.Text = DeviceObj.FirstSeen.ToString();
            TbLastHeard.Text = DeviceObj.LastHeard.ToString();
            TbLastBeat.Text = DeviceObj.LastHeartBeat.ToString();
            lblLastReadingUpdate.Text = (LastReading != null) ? $"Last Updated on {LastReading.DateTimeStamp}" : "No readings have been stored in the server previously. Click \"Get Latest Readings\" to download new sensor readings.";
            DdlAlarmRecog.SelectedValue = DeviceObj.AlarmRecognition;
            DdlPowerSaveMode.SelectedValue = DeviceObj.PowerSaveMode;
            DdlListenMode.SelectedValue = DeviceObj.ListeningMode;
            DdlActiveStatus.SelectedValue = DeviceObj.ActiveStatus.ToString();
            ucViewFooter.CreateBy = DeviceObj.CreateBy;
            ucViewFooter.CreateDate = DeviceObj.CreateDate.ToString();
            ucViewFooter.AmendBy = DeviceObj.AmendBy;
            ucViewFooter.AmendDate = DeviceObj.AmendDate.ToString();

            DisplayChart();
        }

        protected void PopulateLesson()
        {
            List<DisplayLesson> displayList = new List<DisplayLesson>();
            List<Lesson> LessonList = LSBL.SelectByFacilityID(DdlFacilityID.SelectedValue).Where(obj => obj.ModuleCode.Equals(DdlModuleCodeName.SelectedValue)).ToList();
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
                    LessonDetails = $"{PABL.SelectByAllParaCode("LESSON", "TYPE", LesObj.LessonType).Desc1}, Every {LesObj.DayOfWeek} From {LesObj.TimeStart:h:mm tt} To {LesObj.TimeEnd:h:mm tt} (Module Grps: {string.Join(", ", ModGrpList.Where(obj => !string.IsNullOrEmpty(obj)).ToList())})"
                };

                displayList.Add(DispObj);
            }

            DdlLesson.DataSource = displayList;
            DdlLesson.DataTextField = "LessonDetails";
            DdlLesson.DataValueField = "LessonID";
            DdlLesson.DataBind();
        }

        protected void PopulateModuleCode()
        {
            List<DisplayModule> displayList = new List<DisplayModule>();
            SensorDevice DeviceObj = SDBL.SelectByDeviceID(DEVICEID);
            List<Lesson> LessonList = LSBL.SelectDistinctModulesByFacilityID(DeviceObj.FacilityID);
            foreach (Lesson LesObj in LessonList)
            {
                Parameter ParamObj = PABL.SelectByAllParaCode("MODULE", "SIT", LesObj.ModuleCode);
                DisplayModule DispObj = new DisplayModule()
                {
                    ModuleCode = ParamObj.ParaCode3,
                    ModuleCodeName = $"{ParamObj.ParaCode3} - {ParamObj.Desc1}"
                };
                displayList.Add(DispObj);
            }

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
            }

            DdlModuleCodeName.DataSource = displayList;
            DdlModuleCodeName.DataTextField = "ModuleCodeName";
            DdlModuleCodeName.DataValueField = "ModuleCode";
            DdlModuleCodeName.DataBind();
        }

        protected void PopulateFacilityID()
        {
            List<Facility> FaciList = FABL.Retrieve();
            DdlFacilityID.DataSource = FaciList;
            DdlFacilityID.DataTextField = "FacilityID";
            DdlFacilityID.DataValueField = "FacilityID";
            DdlFacilityID.DataBind();
        }

        protected void PopulateWeeks()
        {
            List<DisplayWeek> ListOfWeeks = Enumerable.Range(1, 18).Select(obj => new DisplayWeek() { WeekNo = obj }).ToList();

            DdlWeekFrom.DataSource = ListOfWeeks;
            DdlWeekFrom.DataTextField = "WeekNo";
            DdlWeekFrom.DataValueField = "WeekNo";
            DdlWeekFrom.DataBind();
            DdlWeekFrom.SelectedValue = "1";
            DdlWeekTo.DataSource = ListOfWeeks;
            DdlWeekTo.DataTextField = "WeekNo";
            DdlWeekTo.DataValueField = "WeekNo";
            DdlWeekTo.DataBind();
            DdlWeekTo.SelectedValue = "1";
        }

        protected void PopulateDevicePosition()
        {
            List<DisplayDevicePosition> displayList = new List<DisplayDevicePosition>();
            List<Parameter> ParamList = PABL.SelectByParaCode1And2("SENSOR", "POSITION");

            if (REQTYPE.Equals(CommonBL.ConstantType_Add))
            {
                ParamList = ParamList.Where(obj => !string.IsNullOrEmpty(obj.ParaCode3)).ToList();
            }
            else
            {
                SensorDevice DeviceObj = SDBL.SelectByDeviceID(DEVICEID);
                if (DeviceObj.DevicePosition != CommonBL.ConstantParameter_AutoGen)
                {
                    ParamList = ParamList.Where(obj => obj.Desc1 != CommonBL.ConstantParameter_AutoGen).ToList();
                }
            }

            foreach (Parameter ParamObj in ParamList)
            {
                DisplayDevicePosition DispObj = new DisplayDevicePosition()
                {
                    PositionID = string.IsNullOrEmpty(ParamObj.ParaCode3) ? CommonBL.ConstantParameter_AutoGen : ParamObj.ParaCode3,
                    PositionDesc = ParamObj.Desc1 + (string.IsNullOrEmpty(ParamObj.Desc2) ? "" : $"- {ParamObj.Desc2}")
                };

                displayList.Add(DispObj);
            }

            DdlDevPosition.DataSource = displayList;
            DdlDevPosition.DataTextField = "PositionDesc";
            DdlDevPosition.DataValueField = "PositionID";
            DdlDevPosition.DataBind();
        }

        protected void DisplayChart()
        {
            int interval = CommonBL.IntegerMapper(DdlInterval.SelectedValue);
            int startweek = CommonBL.IntegerMapper(DdlWeekFrom.SelectedValue);
            int endweek = CommonBL.IntegerMapper(DdlWeekTo.SelectedValue);
            int numOfWeeks = startweek - endweek;
            if (startweek > endweek)
            {
                SoundData.Value = TempData.Value = HumidData.Value = "";
                lblError.Text = "Please select an appropriate week range.";
            }
            else
            {
                //Get the time range
                TimeSpan STARTHOUR = TimeSpan.Parse("08:00");
                TimeSpan ENDHOUR = TimeSpan.Parse("21:00");
                List<string> AllTimes = CommonBL.GetDayTimeIntervalInRange(STARTHOUR, ENDHOUR, interval);

                //Get the date range
                List<DateTime> AllDates = new List<DateTime>();

                Parameter ParamObj = PABL.SelectByAllParaCode("SEMESTER", "StartToEndDate", "2021S1");
                DateTime semesterStart = CommonBL.DateTimeMapper(ParamObj.Desc1);
                DateTime semesterEnd = CommonBL.DateTimeMapper(ParamObj.Desc2);
                DateTime StartDateRange = semesterStart.AddDays((startweek * 7) - 7);
                DateTime EndDateRange = semesterEnd.AddDays((18 - endweek) * -7);

                AllDates = CommonBL.EachDay(StartDateRange, EndDateRange).ToList();
                AllDates = AllDates.Where(obj => obj.DayOfWeek != DayOfWeek.Saturday && obj.DayOfWeek != DayOfWeek.Sunday).ToList();

                //Get readings from each device installed in the selected facility
                List<string> DeviceIDList = new List<string>() { DEVICEID };

                List<ChartJs.Dataset> SoundDatasetList = new List<ChartJs.Dataset>();
                List<ChartJs.Dataset> TempDatasetList = new List<ChartJs.Dataset>();
                List<ChartJs.Dataset> HumidDatasetList = new List<ChartJs.Dataset>();
                List<ChartJs.Dataset> MotionDatasetList = new List<ChartJs.Dataset>();

                var jsonSerializerSettings = new JsonSerializerSettings
                {
                    ContractResolver = new CamelCasePropertyNamesContractResolver()
                };

                foreach (DateTime DateObj in AllDates)
                {
                    List<float> SoundData = new List<float>();
                    List<float> TempData = new List<float>();
                    List<float> HumidData = new List<float>();
                    List<float> MotionData = new List<float>();

                    foreach (string TimeString in AllTimes)
                    {
                        var startDT = CommonBL.DateTimeMapper(DateObj.ToString("dd-MM-yyyy") + " " + TimeString);
                        var endDT = startDT.AddSeconds(59);
                        List<SensorReading> ThisDateTimeReadingList = SRBL.SelectByDeviceIDAndDateTimeStamp(DEVICEID, startDT, endDT);
                        if (ThisDateTimeReadingList.Count > 0)
                        {
                            //Reading for this date-time stamp exists.
                            var readList = ThisDateTimeReadingList.Where(obj => obj.Sound != 0).ToList();
                            if (readList.Count > 0) SoundData.Add(readList.Average(obj => obj.Sound)); else SoundData.Add(0);
                            readList = ThisDateTimeReadingList.Where(obj => obj.Temperature != 0).ToList();

                            if (readList.Count > 0) TempData.Add(readList.Average(obj => obj.Temperature)); else TempData.Add(0);
                            readList = ThisDateTimeReadingList.Where(obj => obj.Motion != 0).ToList();

                            if (readList.Count > 0) MotionData.Add(readList.Average(obj => obj.Motion)); else MotionData.Add(0);
                            readList = ThisDateTimeReadingList.Where(obj => obj.Humidity != 0).ToList();

                            if (readList.Count > 0) HumidData.Add(readList.Average(obj => obj.Humidity)); else HumidData.Add(0);
                        }
                        else
                        {
                            //Reading for this date-time stamp does not exist in DB (most likely because the sensor(s) did not record it). Set average reading to default values (i.e. 0)
                            SoundData.Add(0);
                            TempData.Add(0);
                            HumidData.Add(0);
                            MotionData.Add(0);
                        }
                    }

                    //Chart Label should reflect WeekNo if displayOption was "Module/Lesson". Otherwise, show the individual daily dates.
                    ChartJs.Dataset SoundDataset = new ChartJs.Dataset()
                    {
                        Label = DateObj.ToString("dd/MM/yyyy"),
                        Data = SoundData
                    };
                    SoundDatasetList.Add(SoundDataset);

                    ChartJs.Dataset TempDataset = new ChartJs.Dataset()
                    {
                        Label = DateObj.ToString("dd/MM/yyyy"),
                        Data = TempData
                    };
                    TempDatasetList.Add(TempDataset);

                    ChartJs.Dataset HumidDataset = new ChartJs.Dataset()
                    {
                        Label = DateObj.ToString("dd/MM/yyyy"),
                        Data = HumidData
                    };
                    HumidDatasetList.Add(HumidDataset);

                    ChartJs.Dataset MotionDataset = new ChartJs.Dataset()
                    {
                        Label = DateObj.ToString("dd/MM/yyyy"),
                        Data = MotionData
                    };
                    HumidDatasetList.Add(MotionDataset);
                }

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

                ChartJs MotionChart = new ChartJs()
                {
                    Labels = AllTimes,
                    Datasets = MotionDatasetList
                };

                SoundData.Value = JsonConvert.SerializeObject(SoundChart, jsonSerializerSettings);
                TempData.Value = JsonConvert.SerializeObject(TempChart, jsonSerializerSettings);
                HumidData.Value = JsonConvert.SerializeObject(HumidChart, jsonSerializerSettings);
                MotionData.Value = JsonConvert.SerializeObject(MotionChart, jsonSerializerSettings);
            }

        }

        protected void GetAndSaveAPIData()
        {
            string startDate;
            string endDate = string.Format("{0:u}", DateTime.Now);
            float time = 600;
            List<string> DeviceIDList = new List<string>() { DEVICEID };
            SensorReading LastReading = SRBL.SelectByDeviceID(DeviceIDList).OrderBy(obj => obj.DateTimeStamp).LastOrDefault();
            if (LastReading == null)
            {
                //User is downloading readings from the API for the first time. Set start date as: from beginning of time when sensor was activated.
                SensorDevice DeviceObj = SDBL.SelectByDeviceID(DEVICEID);
                startDate = string.Format("{0:u}", DeviceObj.FirstSeen);
            }
            else
            {
                //User have downloaded sensor readings previously. Set start date as: 1 min after last reading downloaded.
                //Important to add 1 minute as we want to start at the next immediate minute, since data is stored at 1 minute intervals
                startDate = string.Format("{0:u}", LastReading.DateTimeStamp.AddMinutes(10)); //(changes were made, data updates every 10 minutes instead of 1 minute intervals)
            }


            SOUNDLEVEL = GetReading(CommonBL.ConstantAPIendpoint_GETSOUNDLEVEL, startDate, endDate, time);
            TEMPERATURE = GetReading(CommonBL.ConstantAPIendpoint_GETTEMPERATURE, startDate, endDate, time);
            HUMIDITY = GetReading(CommonBL.ConstantAPIendpoint_GETHUMIDITY, startDate, endDate, time);
            MOTION = GetReading(CommonBL.ConstantAPIendpoint_GETMOTION, startDate, endDate, time);
            System.Diagnostics.Debug.WriteLine("This is motionevents  -->  ", MOTION);
            System.Diagnostics.Debug.WriteLine("This is temperature  -->  ", TEMPERATURE);
            System.Diagnostics.Debug.WriteLine("This is humididty  -->  ", HUMIDITY);

            /*dynamic respo = JObject.Parse(MOTION);
            string deserializes = respo.values.ToString();*/

            /*dynamic jsonArray = JArray.Parse(MOTION);
            dynamic data = JObject.Parse(jsonArray[0].ToString());*/

            /*MOTIONEVENTS = JsonConvert.DeserializeObject<SensorView>(MOTIONEVENTS).ToString();*/

            List<SensorReading.API_CustomEntity> SoundLevelReadings = JsonConvert.DeserializeObject<List<SensorReading.API_CustomEntity>>(DeserializeAPIObj(SOUNDLEVEL));
            /*List<SensorReading.API_CustomEntity> MotionReadings = JsonConvert.DeserializeObject<List<SensorReading.API_CustomEntity>>(DeserializeAPIObj(MOTION));*/
            List<SensorReading.API_CustomEntity> TemperatureReadings = JsonConvert.DeserializeObject<List<SensorReading.API_CustomEntity>>(DeserializeAPIObj(TEMPERATURE));
            List<SensorReading.API_CustomEntity> HumidityReadings = JsonConvert.DeserializeObject<List<SensorReading.API_CustomEntity>>(DeserializeAPIObj(HUMIDITY));

            HumidityReadings.ForEach(i => System.Diagnostics.Debug.WriteLine("This is humidity  -->  ", i));

            SoundLevelReadings.ForEach(obj => obj.ReadingType = CommonBL.ConstantSensorReadingType_Sound);
            //MotionReadings.ForEach(obj => obj.ReadingType = CommonBL.ConstantSensorReadingType_Motion);

            TemperatureReadings.ForEach(obj => obj.ReadingType = CommonBL.ConstantSensorReadingType_Temp);
            HumidityReadings.ForEach(obj => obj.ReadingType = CommonBL.ConstantSensorReadingType_Humid);

            //Bind all readings that share the same DateTimeStamp
            List<SensorReading> AllReadings = SoundLevelReadings.Union(TemperatureReadings).Union(HumidityReadings).GroupBy(dt => new DateTime(dt.Datetime.Year, dt.Datetime.Month, dt.Datetime.Day, dt.Datetime.Hour, dt.Datetime.Minute, 0))
                .Select(newObj => new SensorReading()
                {
                    DateTimeStamp = newObj.Key,
                    DeviceID = DEVICEID,
                    Sound = newObj.Where(x => x.ReadingType == CommonBL.ConstantSensorReadingType_Sound && x.Value != 0).ToList().Count > 0 ? newObj.Where(x => x.ReadingType == CommonBL.ConstantSensorReadingType_Sound && x.Value != 0).ToList().Average(r => r.Value) : 0,
                   // Motion = newObj.Where(x => x.ReadingType == CommonBL.ConstantSensorReadingType_Motion && x.Value != 0).ToList().Count > 0 ? newObj.Where(x => x.ReadingType == CommonBL.ConstantSensorReadingType_Motion && x.Value != 0).ToList().Average(r => r.Value) : 0,


                    Temperature = newObj.Where(x => x.ReadingType == CommonBL.ConstantSensorReadingType_Temp && x.Value != 0).ToList().Count > 0 ? newObj.Where(x => x.ReadingType == CommonBL.ConstantSensorReadingType_Temp && x.Value != 0).ToList().Average(r => r.Value) : 0,
                    Humidity = newObj.Where(x => x.ReadingType == CommonBL.ConstantSensorReadingType_Humid && x.Value != 0).ToList().Count > 0 ? newObj.Where(x => x.ReadingType == CommonBL.ConstantSensorReadingType_Humid && x.Value != 0).ToList().Average(r => r.Value) : 0,
                }).ToList();

            foreach (SensorReading ReadObj in AllReadings)
            {
                ReadObj.CreateBy = (string)Session["LOGINUSER"];
                int result = SRBL.Create(ReadObj);
                if (result == 0)
                {
                    continue;
                }
                else
                {
                    lblError.Text = $"Failed to update readings from {ReadObj.DateTimeStamp} onwards.";
                    break;
                }
            }

            lblError.Visible = !string.IsNullOrEmpty(lblError.Text);
            GetDetails(DEVICEID);
        }

        protected void GetBearerToken()
        {
            Response.Redirect(string.Format("https://api.minut.com/v5/oauth/authorize?response_type=code&client_id={0}&redirect_uri={1}", ConfigurationManager.AppSettings["OAuth2ClientID"], ConfigurationManager.AppSettings["RedirectURI"]));
        }

        protected string GetReading(string readingType, string startDate, string endDate, float time)
        {
            dynamic resp = JObject.Parse(BEARERTOKEN);

            time = 600;
            var client = new RestClient(string.Format("https://api.minut.com/v5/devices/{0}/{1}?start_at={2}&end_at={3}&time_resolution={4}", DEVICEID, readingType, startDate, endDate, time));
            var request = new RestRequest(Method.GET);
            request.AddHeader("cache-control", "no-cache");
            request.AddHeader("content-type", "application/x-www-form-urlencoded");
            request.AddHeader("authorization", "Bearer " + resp.access_token);
            IRestResponse response = client.Execute(request);
            return response.Content;
        }

        protected string DeserializeAPIObj(string APIObj)
        {
            /*Read API documentation for more info on types of response keys and values: 
             - https://api.minut.com/v5/docs/#operation/getDevice
             - https://api.minut.com/v5/docs/#operation/getTemperature
             - https://api.minut.com/v5/docs/#operation/getHumidity
             - https://api.minut.com/v6/devices/{device_id}/motion_events
            */

            dynamic resp = JObject.Parse(APIObj);
            string deserialize = resp.values.ToString();
            return deserialize;
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

        public class DisplayFacility
        {
            public string FacilityID { get; set; }
            public string FacilityCodeName { get; set; }

            public DisplayFacility()
            {

            }
        }

        public class DisplayDevicePosition
        {
            public string PositionID { get; set; }
            public string PositionDesc { get; set; }
            public DisplayDevicePosition()
            {

            }
        }

        public class DateTimeObj
        {
            public DateTime Datetime { get; set; }
            public DateTimeObj()
            {

            }
        }


    }

    

}