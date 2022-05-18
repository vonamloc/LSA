using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA
{
    public partial class FacilitySelect : System.Web.UI.Page
    {
        readonly FacilityBL FBL = new FacilityBL();
        readonly ParameterBL PABL = new ParameterBL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Label lblTitle = (Label)Page.Master.FindControl("lblTitle");
                lblTitle.Text = "Facilities";
                ExcRequest();
            }
        }

        protected void GvFacility_PreRender(object sender, EventArgs e)
        {
            if(GvFacility.HeaderRow != null)
            {
                GvFacility.HeaderRow.CssClass = "bg-dark text-white";
            }
        }

        protected void GvFacility_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //Check if the row is the header row
            if (e.Row.RowType == DataControlRowType.Header)
            {
                //Add the thead and tbody section programatically
                e.Row.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void GvFacility_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Response.Redirect($"FacilityView.aspx?RequestType={e.CommandName}&FacilityID={e.CommandArgument}");
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("FacilityView.aspx?RequestType=Add");
        }

        protected void ExcRequest()
        {
            try
            {
                //Get only those facilities and their details that are used as project runs in the current project phase
                List<DisplayFacility> displayList = new List<DisplayFacility>();
                List<Facility> FaciList = FBL.Retrieve().Where(obj => obj.ProjPhaseID.Equals(1)).ToList();
                foreach(Facility FaciObj in FaciList)
                {
                    Parameter ParaObj = FaciObj.FacilityCode == CommonBL.ConstantParameter_AutoGen? PABL.SelectByAllParaCode("FACILITY", "", "") :
                        PABL.SelectByAllParaCode("FACILITY", FaciObj.FacilityCode.Substring(0, 1), FaciObj.FacilityCode.Substring(1));
                    DisplayFacility DispObj = new DisplayFacility
                    {
                        FacilityID = FaciObj.FacilityID,
                        FacilityCode = FaciObj.FacilityCode,
                        FacilityName = ParaObj.Desc2
                    };

                    displayList.Add(DispObj);
                }
                GvFacility.DataSource = displayList;
                GvFacility.DataBind();
            }
            catch (Exception e)
            {
                CommonBL.LogError(this.GetType(), "ExcRequest", e.Message);
            }
        }

        public class DisplayFacility
        {
            public string FacilityID { get; set; }
            public string FacilityCode { get; set; }
            public string FacilityName { get; set; }

            public DisplayFacility()
            {

            }
        }
    }
}