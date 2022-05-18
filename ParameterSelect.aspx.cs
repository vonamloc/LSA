using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA
{
    public partial class ParameterSelect : System.Web.UI.Page
    {
        readonly ParameterBL PABL = new ParameterBL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Label lblTitle = (Label)Page.Master.FindControl("lblTitle");
                lblTitle.Text = "Parameter";
                ExcRequest();
            }
        }

        protected void GvParameter_PreRender(object sender, EventArgs e)
        {
            GvParameter.HeaderRow.CssClass = "bg-dark text-white";
        }

        protected void GvParameter_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //Check if the row is the header row
            if (e.Row.RowType == DataControlRowType.Header)
            {
                //Add the thead and tbody section programatically
                e.Row.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void GvParameter_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Response.Redirect($"ParameterView.aspx?RequestType={e.CommandName}&ParaCode1={e.CommandArgument}");
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("ParameterView.aspx?RequestType=Add");
        }

        protected void ExcRequest()
        {
            try
            {
                List<Parameter> ParamList = PABL.SelectParaCode1();
                GvParameter.DataSource = ParamList;
                GvParameter.DataBind();
            }
            catch (Exception e)
            {
                CommonBL.LogError(this.GetType(), "ExcRequest", e.Message);
            }
        }
    }
}