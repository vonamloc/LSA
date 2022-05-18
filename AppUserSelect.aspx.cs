using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA
{
    public partial class AppUserSelect : System.Web.UI.Page
    {
        readonly AppUserBL AUBL = new AppUserBL();
        readonly ParameterBL PABL = new ParameterBL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Label lblTitle = (Label)Page.Master.FindControl("lblTitle");
                lblTitle.Text = "App User";
                ExcRequest();
            }
        }

        protected void GvAppUser_PreRender(object sender, EventArgs e)
        {
            GvAppUser.HeaderRow.CssClass = "bg-dark text-white";
        }

        protected void GvAppUser_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //Check if the row is the header row
            if (e.Row.RowType == DataControlRowType.Header)
            {
                //Add the thead and tbody section programatically
                e.Row.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void GvAppUser_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Response.Redirect($"AppUserView.aspx?RequestType={e.CommandName}&LoginID={e.CommandArgument}");
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AppUserView.aspx?RequestType=Add");
        }

        protected void ExcRequest()
        {
            try
            {
                List<DisplayAppUser> displayList = new List<DisplayAppUser>();
                List<AppUser> UserList = AUBL.Retrieve();

                foreach (AppUser UserObj in UserList)
                {
                    Parameter ParaObj1 = PABL.SelectByAllParaCode("USRROLE", UserObj.UsrRole, "");
                    Parameter ParaObj2 = PABL.SelectByAllParaCode("USRSTATUS", UserObj.UsrStatus, "");
                    DisplayAppUser DispObj = new DisplayAppUser
                    {
                        LoginID = UserObj.LoginID,
                        UsrShtName = UserObj.UsrShtName,
                        UsrRole = ParaObj1.Desc1,
                        USrStatus = ParaObj2.Desc1
                    };

                    displayList.Add(DispObj);
                }

                displayList = displayList.OrderBy(obj => obj.USrStatus).ThenBy(obj => obj.UsrRole).ToList();
                GvAppUser.DataSource = displayList;
                GvAppUser.DataBind();
            }
            catch (Exception e)
            {
                CommonBL.LogError(this.GetType(), "ExcRequest", e.Message);
            }
        }

        public class DisplayAppUser
        {
            public string LoginID { get; set; }
            public string UsrShtName { get; set; }
            public string UsrRole { get; set; }
            public string USrStatus { get; set; }

            public DisplayAppUser()
            {

            }
        }
    }
}