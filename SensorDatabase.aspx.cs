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
using System.IO;
using System.Drawing;

namespace LSA
{
    public partial class SensorDatabase : System.Web.UI.Page
    {
        Label lblTitle;
        Label lblError;

        readonly SensorReadingBL SRBL = new SensorReadingBL();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblTitle = (Label)Master.FindControl("lblTitle");
            lblTitle.Text = "Sensor Database";
            lblError = (Label)Master.FindControl("lblError");
            lblError.Text = "";
            ExcRequest();
        }

        protected void BtnGenerateExcel_Click(object sender, EventArgs e)
        {
            try
            {
                ExportGridToExcel();
            }
            catch (Exception ex)
            {
                display_lbl.Text = ex.ToString();
            }
        }

        protected void ExcRequest()
        {
            PopulateGvSensorReadingFromDB();
        }

        protected void PopulateGvSensorReadingFromDB()  

        {
            List<DisplaySensorReading> displayList = new List<DisplaySensorReading>();
            List<SensorReading> DeviceList = SRBL.Retrieve();
            foreach (SensorReading DeviceObj in DeviceList)
            {
                DisplaySensorReading DispObj = new DisplaySensorReading()
                {
                    DateTimeStamp = DeviceObj.DateTimeStamp.ToString(),
                    Sound = DeviceObj.Sound.ToString(),
                    Motion = DeviceObj.Motion.ToString(),
                    Humidity = DeviceObj.Humidity.ToString(),
                    Temperature = DeviceObj.Temperature.ToString(),
                    DeviceID = DeviceObj.DeviceID
                };
                displayList.Add(DispObj);
            }

            GvSensorReadingFromDB.DataSource = displayList;
            GvSensorReadingFromDB.DataBind();
        }

        protected void ExportGridToExcel()
        {
            
            Response.Clear();
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "";
            string FileName = "SensorReading Database - " + DateTime.Now + ".xls";
            StringWriter strwritter = new StringWriter();
            HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
            GvSensorReadingFromDB.GridLines = GridLines.Both;
            GvSensorReadingFromDB.HeaderStyle.Font.Bold = true;
            GvSensorReadingFromDB.RenderControl(htmltextwrtter);
            Response.Write(strwritter.ToString());
            Response.End();
            

            /*
            string attachment = "Sensor Database" + DateTime.Now + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + attachment);
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            GvSensorReadingFromDB.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();
            */
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            // Verifies that the control is rendered
        }
        
        public class DisplaySensorReading
        {
            public string DateTimeStamp { get; set; }
            public string Sound { get; set; }
            public string Motion { get; set; }
            public string Humidity { get; set; }
            public string Temperature { get; set; }
            public string DeviceID { get; set; }

            public DisplaySensorReading() { }
        }
    }
}
