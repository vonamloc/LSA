using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA
{
    public partial class SensorSelect : System.Web.UI.Page
    {
        Label lblTitle;
        Label lblError;

        static string BEARERTOKEN;
        static string DEVICES;
        static DataTable dtAPIdata;

        readonly SensorDeviceBL SDBL = new SensorDeviceBL();
        readonly FacilityBL FABL = new FacilityBL();
        readonly ParameterBL PABL = new ParameterBL();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblTitle = (Label)Master.FindControl("lblTitle");
            lblTitle.Text = "Sensors";
            lblError = (Label)Master.FindControl("lblError");
            lblError.Text = "";

            if (!Page.IsPostBack)
            {
                if (Session["BEARERTOKEN"] != null)
                    BEARERTOKEN = (string)Session["BEARERTOKEN"];

                BtnGetSensorsFromDB.Enabled = false;
                divAPIData.Visible = false;
                ExcRequest();
                if (Session["APIrequest"] != null)
                {
                    string APIREQUEST = Session["APIrequest"].ToString();
                    Session["APIrequest"] = null;
                    if (APIREQUEST == CommonBL.ConstantAPIendpoint_GETDEVICES)
                    {
                        //Ensure user have attained bearer token
                        if (!string.IsNullOrEmpty(BEARERTOKEN))
                        {
                            SetControlProperties();
                            GetDevices();
                            PopulateGvSensorDeviceFromAPI();
                        }
                    }
                }
            }
        }

        protected void Gv_PreRender(object sender, EventArgs e)
        {
            GridView Gv = (GridView)sender;
            if (Gv.HeaderRow != null)
            {
                Gv.HeaderRow.CssClass = "bg-dark text-white";
            }
        }
        protected void Gv_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //Check if the row is the header row
            if (e.Row.RowType == DataControlRowType.Header)
            {
                //Add the thead and tbody section programatically
                e.Row.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void GvSensorDeviceFromDB_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Response.Redirect($"SensorView.aspx?RequestType={e.CommandName}&DeviceID={e.CommandArgument}");
        }

        protected void GvSensorUpdates_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridViewRow Gvr = (GridViewRow)((Button)e.CommandSource).NamingContainer;
            SensorDevice DeviceObj = JsonConvert.DeserializeObject<SensorDevice>(e.CommandArgument.ToString());
            int result = CommitChanges(DeviceObj, e.CommandName);
            if (result == 0)
            {
                dtAPIdata.Rows.RemoveAt(Gvr.RowIndex);
                GvSensorUpdates.DataSource = dtAPIdata;
                GvSensorUpdates.DataBind();

                lblCountUpdates.Text = dtAPIdata.Rows.Count == 0 ? $"All sensors updated." : $"There { (dtAPIdata.Rows.Count == 1 ? "is" : "are") } { dtAPIdata.Rows.Count } pending update{ (dtAPIdata.Rows.Count == 1 ? "" : "s") }.";
            }
            else
            {
                lblCountUpdates.Text = $"Failed to commit for all changes. There { (dtAPIdata.Rows.Count == 1 ? "is" : "are") } { dtAPIdata.Rows.Count } pending update{ (dtAPIdata.Rows.Count == 1 ? "" : "s") }.";
            }
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect($"SensorView.aspx?RequestType=Add");
        }

        protected void BtnCommitAll_Click(object sender, EventArgs e)
        {
            DataTable dtFailedCommits = new DataTable();
            foreach (DataRow dtr in dtAPIdata.Rows)
            {
                object[] objArray = dtr.ItemArray;
                SensorDevice DeviceObj = JsonConvert.DeserializeObject<SensorDevice>((string)objArray[0]);
                int result = CommitChanges(DeviceObj, objArray[2].ToString());
                if (result != 0)
                {
                    dtFailedCommits.Rows.Add(dtr.ItemArray);
                }
            }

            GvSensorUpdates.DataSource = dtFailedCommits;
            GvSensorUpdates.DataBind();

            lblCountUpdates.Text = dtFailedCommits.Rows.Count == 0 ? "All sensors updated." : $"Failed to commit for all changes. There { (dtFailedCommits.Rows.Count == 1 ? "is" : "are") } { dtFailedCommits.Rows.Count } pending update{ (dtFailedCommits.Rows.Count == 1 ? "" : "s") }.";
            BtnCommitAll.Enabled = dtFailedCommits.Rows.Count > 0;
        }

        protected void BtnGetSensorsFromDB_Click(object sender, EventArgs e)
        {
            SetControlProperties();
            ExcRequest();
        }

        protected void BtnGetSensorsFromAPI_Click(object sender, EventArgs e)
        {
            if (Session["BEARERTOKEN"] == null)
            {
                //Acquire BearerToken first
                Session["APIrequest"] = CommonBL.ConstantAPIendpoint_GETDEVICES;
                Session["TransferTo"] = "SensorSelect.aspx";
                GetBearerToken();
            }
            else
            {
                SetControlProperties();
                GetDevices();
                PopulateGvSensorDeviceFromAPI();
            }
        }

        protected void ExcRequest()
        {
            PopulateGvSensorDeviceFromDB();
        }

        protected void SetControlProperties()
        {
            BtnGetSensorsFromDB.Enabled = BtnGetSensorsFromAPI.Enabled;
            BtnGetSensorsFromAPI.Enabled = !BtnGetSensorsFromDB.Enabled;

            divAPIData.Visible = divDBData.Visible;
            divDBData.Visible = !divAPIData.Visible;

            BtnGetSensorsFromAPI.CssClass = divAPIData.Visible ? "btn btn-primary col-sm-12 mt-1 mb-1" : "btn btn-outline-primary col-sm-12 mt-1 mb-1";
            BtnGetSensorsFromDB.CssClass = divDBData.Visible ? "btn btn-primary col-sm-12 mt-1 mb-1" : "btn btn-outline-primary col-sm-12 mt-1 mb-1";
        }

        protected void GetBearerToken()
        {
            Response.Redirect(string.Format("https://api.minut.com/v5/oauth/authorize?response_type=code&client_id={0}&redirect_uri={1}", ConfigurationManager.AppSettings["OAuth2ClientID"], ConfigurationManager.AppSettings["RedirectURI"]));
        }

        protected void GetDevices()
        {
            dynamic resp = JObject.Parse(BEARERTOKEN);

            var client = new RestClient("https://api.minut.com/v5/devices");
            var request = new RestRequest(Method.GET);
            request.AddHeader("cache-control", "no-cache");
            request.AddHeader("authorization", "Bearer " + resp.access_token);
            IRestResponse response = client.Execute(request);
            DEVICES = response.Content;
            //Note: This will retrieve all active AND inactive devices from Minut Dashboard. Active != Offline btw. Active = Registered under that Minut Account.
            //We can use this active param to check if it was deactivated in Minut Dashboard and if it was found in server we deactivate that too.
            //If it wasn't found in our server means that we haven't added it to server before but have already removed from Minut dashbord. In this case, we ignore the SensorDevice.
        }

        protected string GetFacilityName(string home_id)
        {
            dynamic resp = JObject.Parse(BEARERTOKEN);

            var client = new RestClient(string.Format("https://api.minut.com/v5/homes/{0}", home_id));
            var request = new RestRequest(Method.GET);
            request.AddHeader("cache-control", "no-cache");
            request.AddHeader("authorization", "Bearer " + resp.access_token);
            IRestResponse response = client.Execute(request);

            resp = JObject.Parse(response.Content);
            return resp.name;
        }

        protected void PopulateGvSensorDeviceFromDB()
        {
            List<DisplaySensorDevices> displayList = new List<DisplaySensorDevices>();
            List<SensorDevice> DeviceList = SDBL.Retrieve();
            foreach (SensorDevice DeviceObj in DeviceList)
            {
                Facility FaciObj = FABL.SelectByFacilityID(DeviceObj.FacilityID);
                string FacilityCodeNameID = "";
                if (FaciObj.FacilityCode != CommonBL.ConstantParameter_AutoGen)
                {
                    Parameter ParamObj = PABL.SelectByAllParaCode("FACILITY", FaciObj.FacilityCode.Substring(0, 1), FaciObj.FacilityCode.Substring(1));
                    FacilityCodeNameID = $"{ParamObj.Desc1} - {ParamObj.Desc2} (ID: {DeviceObj.FacilityID})";
                }
                else
                    FacilityCodeNameID = $"{CommonBL.ConstantParameter_AutoGen} (ID: {DeviceObj.FacilityID})";

                DisplaySensorDevices DispObj = new DisplaySensorDevices()
                {
                    DeviceID = DeviceObj.DeviceID,
                    DeviceName = DeviceObj.DeviceName,
                    DevicePosition = DeviceObj.DevicePosition == CommonBL.ConstantParameter_AutoGen ? DeviceObj.DevicePosition : PABL.SelectByAllParaCode("SENSOR", "POSITION", DeviceObj.DevicePosition).Desc1,
                    FacilityCodeNameID = FacilityCodeNameID,
                    ActiveStatus = DeviceObj.ActiveStatus ? "Active" : "Deactivated"
                };
                displayList.Add(DispObj);
            }

            displayList = displayList.OrderBy(obj => obj.ActiveStatus).ToList();
            GvSensorDeviceFromDB.DataSource = displayList;
            GvSensorDeviceFromDB.DataBind();
        }
        protected void PopulateGvSensorDeviceFromAPI()
        {
            List<DisplaySensorUpdates> displayList = new List<DisplaySensorUpdates>();
            try
            {
                //Read API documentation for more info on types of response keys and values: https://api.minut.com/v5/docs/#operation/getDevice
                List<SensorDevice> DeviceListFromAPI = new List<SensorDevice>();
                dynamic resp = JObject.Parse(DEVICES);
                string deserialize = resp.devices.ToString();
                List<SensorDevice.API_CustomEntity> customList = JsonConvert.DeserializeObject<List<SensorDevice.API_CustomEntity>>(deserialize);
                foreach (SensorDevice.API_CustomEntity item in customList)
                {
                    SensorDevice DeviceObj = new SensorDevice
                    {
                        DeviceID = item.Device_id,
                        DeviceMAC = item.Device_mac,
                        DeviceName = item.Description,
                        FacilityID = item.Home,
                        DevicePosition = CommonBL.ConstantParameter_AutoGen, //This value is hard-coded as it is not an official paramter in the API
                        FirstSeen = DateTime.Parse(item.First_seen_at),
                        LastHeard = DateTime.Parse(item.Last_heard_from_at),
                        LastHeartBeat = DateTime.Parse(item.Last_heartbeat_at),
                        AlarmRecognition = item.Alarm_recognition,
                        PowerSaveMode = item.Power_saving_mode,
                        ListeningMode = item.Listening_mode,
                        ActiveStatus = item.Active
                    };

                    DeviceListFromAPI.Add(DeviceObj);
                }

                //Check 1: API data match DB data? >> This helps to identify sensors that were newly added/updated in Minut Dashboard and has not been updated in the Database
                // >> This also helps to identify sensors have been deleted in Minut Dashboard but was NOT previously saved in the Database, therefore we exclude it from the displayList
                foreach (SensorDevice APIObj in DeviceListFromAPI)
                {
                    //Check if device already stored in db
                    SensorDevice DBObj = SDBL.SelectByDeviceID(APIObj.DeviceID);
                    if (DBObj == null)
                    {
                        //If no, prompt user to add device only IF active = true
                        if (APIObj.ActiveStatus == true)
                        {
                            DisplaySensorUpdates DispObj = new DisplaySensorUpdates
                            {
                                DeviceObjJSON = JsonConvert.SerializeObject(APIObj),
                                UpdateMsg = string.Format("New Sensor device '{0}' (ID: {1}) detected on Minut Dashboard! Device was activated on {2} and installed in {3}. Add sensor to DB?", APIObj.DeviceName, APIObj.DeviceID, APIObj.FirstSeen, GetFacilityName(APIObj.FacilityID)),
                                CRUDoperation = CommonBL.ConstantCRUD_Create
                            };

                            displayList.Add(DispObj);
                        }
                    }
                    else
                    {
                        //If yes, check if there were any updates made outside this client app. (ie. directly on Minut Dashboard)
                        //Exclude check for ActiveStatus and DevicePosition as they are not parameters from the API but defined in our own server
                        bool FirstSeenUpdated = DateTime.Compare(CommonBL.DateTimeMapper(APIObj.FirstSeen.ToString()), CommonBL.DateTimeMapper(DBObj.FirstSeen.ToString())) != 0;
                        bool LastHeardUpdated = DateTime.Compare(CommonBL.DateTimeMapper(APIObj.LastHeard.ToString()), CommonBL.DateTimeMapper(DBObj.LastHeard.ToString())) != 0;
                        bool LastHeartBeatUpdated = DateTime.Compare(CommonBL.DateTimeMapper(APIObj.LastHeartBeat.ToString()), CommonBL.DateTimeMapper(DBObj.LastHeartBeat.ToString())) != 0;
                        if (APIObj.DeviceMAC != DBObj.DeviceMAC || APIObj.DeviceName != DBObj.DeviceName || APIObj.FacilityID != DBObj.FacilityID ||
                            FirstSeenUpdated || LastHeardUpdated || LastHeartBeatUpdated ||
                            APIObj.AlarmRecognition != DBObj.AlarmRecognition || APIObj.PowerSaveMode != DBObj.PowerSaveMode || APIObj.ListeningMode != DBObj.ListeningMode)
                        {
                            //Overwrite ActiveStatus and DevicePosition values as they were previously hardcoded
                            APIObj.DevicePosition = DBObj.DevicePosition;
                            APIObj.ActiveStatus = DBObj.ActiveStatus;
                            DisplaySensorUpdates DispObj = new DisplaySensorUpdates
                            {
                                DeviceObjJSON = JsonConvert.SerializeObject(APIObj),
                                UpdateMsg = string.Format("There are 1 or more changes made to Sensor Device '{0}' (ID:{1}). Update sensor information?", APIObj.DeviceName, APIObj.DeviceID),
                                CRUDoperation = CommonBL.ConstantCRUD_Update
                            };

                            displayList.Add(DispObj);
                        }
                    }
                }
                //Check 2: DB data match API data? >> This helps to identify sensors that have been deleted in Minut Dashboard but was previously saved in the Database
                // We could have passed in the active=true parameter earlier but bcoz of this function here we didn't.
                List<SensorDevice> DeviceListFromDB = SDBL.Retrieve();
                foreach (SensorDevice DBObj in DeviceListFromDB)
                {
                    SensorDevice APIObj = DeviceListFromAPI.Where(obj => obj.DeviceID.Equals(DBObj.DeviceID)).FirstOrDefault();
                    if (APIObj != null && APIObj.ActiveStatus == false)
                    {
                        //If Device has not been deactivated by Administrator...
                        if (DBObj.ActiveStatus == true)
                        {
                            //Set the Active Status to 'Deactivated' so that once user click on the commit changes button, the value would've already been set
                            DBObj.ActiveStatus = false;
                            DisplaySensorUpdates DispObj = new DisplaySensorUpdates
                            {
                                DeviceObjJSON = JsonConvert.SerializeObject(DBObj),
                                UpdateMsg = string.Format("Existing Sensor Device '{0}' (ID:{1}) was not found from API request. It could have been removed from Minut Dashboard. Update sensor status to 'Deactivated'? Note this will not remove the device record from server.", DBObj.DeviceName, DBObj.DeviceID),
                                CRUDoperation = CommonBL.ConstantCRUD_Update
                            };

                            displayList.Add(DispObj);
                        }
                    }
                    //else if (APIObj == null)
                    //{
                        //TODO: Alert Administrator
                        //Administrator have added sensor to own server but have not activate it on Minut Dashboard. API endpoint cannot perform post.
                    //}
                }


                dtAPIdata = CommonBL.CreateDataTable(displayList);

                lblCountUpdates.Text = dtAPIdata.Rows.Count == 0 ? $"All sensors updated." : $"There { (dtAPIdata.Rows.Count == 1 ? "is" : "are") } { dtAPIdata.Rows.Count } pending update{ (dtAPIdata.Rows.Count == 1 ? "" : "s") }.";
                BtnCommitAll.Enabled = dtAPIdata.Rows.Count > 0;
                GvSensorUpdates.DataSource = dtAPIdata;
                GvSensorUpdates.DataBind();
            }
            catch (Exception e)
            {
                CommonBL.LogError(this.GetType(), "PopulateGvSensorDeviceFromAPI", e.Message);
            }
        }

        protected int CommitChanges(SensorDevice DeviceObj, string CRUDoperation)
        {
            int result;

            if (CRUDoperation == CommonBL.ConstantCRUD_Create)
                DeviceObj.CreateBy = (string)Session["LOGINUSER"];
            else if (CRUDoperation == CommonBL.ConstantCRUD_Update)
                DeviceObj.AmendBy = (string)Session["LOGINUSER"];


            Facility FaciObj = FABL.SelectByFacilityID(DeviceObj.FacilityID);

            if (FaciObj == null)
                result = AutoCreateFacility(DeviceObj.FacilityID);
            else
                result = 0;

            if (result == 0)
                result = CRUDoperation == CommonBL.ConstantCRUD_Update ? SDBL.Update(DeviceObj) : SDBL.Create(DeviceObj);

            return result;
        }

        protected int AutoCreateFacility(string faciid)
        {
            Facility FaciObj = new Facility
            {
                FacilityID = faciid,
                FacilityCode = CommonBL.ConstantParameter_AutoGen,
                //TODO: Don't hardcode projphase
                ProjPhaseID = 1,
                CreateBy = (string)Session["LOGINUSER"]
            };

            int result = FABL.Create(FaciObj);
            return result;
        }

        public class DisplaySensorUpdates
        {
            public string DeviceObjJSON { get; set; }
            public string UpdateMsg { get; set; }
            public string CRUDoperation { get; set; }

            public DisplaySensorUpdates() { }
        }

        public class DisplaySensorDevices
        {
            public string DeviceID { get; set; }
            public string DeviceName { get; set; }
            public string DevicePosition { get; set; }
            public string FacilityCodeNameID { get; set; }
            public string ActiveStatus { get; set; }

            public DisplaySensorDevices() { }
        }


    }
}