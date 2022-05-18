using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA
{
    public partial class QuestionnaireSelect : System.Web.UI.Page
    {
        Label lblTitle;
        Label lblError;

        readonly QuestionnaireBL QUBL = new QuestionnaireBL();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblTitle = (Label)Page.Master.FindControl("lblTitle");
            lblTitle.Text = "Questionnaire";
            lblError = (Label)Page.Master.FindControl("lblError");
            lblError.Text = "";

            if (!Page.IsPostBack)
            {
                ExcRequest();
            }
        }
        protected void GvQuestionnaire_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //Check if the row is the header row
            if (e.Row.RowType == DataControlRowType.Header)
            {
                //Add the thead and tbody section programatically
                e.Row.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void GvQuestionnaire_PreRender(object sender, EventArgs e)
        {
            GvQuestionnaire.HeaderRow.CssClass = "bg-dark text-white";
        }

        protected void GvQuestionnaire_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Response.Redirect($"QuestionnaireView.aspx?RequestType={e.CommandName}&QnsID={e.CommandArgument}");
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("QuestionnaireView.aspx?RequestType=Add");
        }

        protected void ExcRequest()
        {
            try
            {
                List<Questionnaire> QnsList = QUBL.Retrieve();
                GvQuestionnaire.DataSource = QnsList;
                GvQuestionnaire.DataBind();
            }
            catch (Exception e)
            {
                CommonBL.LogError(this.GetType(), "ExcRequest", e.Message);
            }
        }


    }
}