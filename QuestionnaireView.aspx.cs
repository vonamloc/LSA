using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA
{
    public partial class QuestionnaireView : System.Web.UI.Page
    {
        Label lblTitle;
        Label lblError;

        static string REQTYPE;
        static string QNSID;

        readonly QuestionnaireBL QUBL = new QuestionnaireBL();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblTitle = (Label)Page.Master.FindControl("lblTitle");
            lblTitle.Text = "Questionnaire";
            lblError = (Label)Page.Master.FindControl("lblError");
            lblError.Text = "";

            TabName.Value = Request.Form[TabName.UniqueID];

            if (!Page.IsPostBack)
            {
                REQTYPE = Request.QueryString["RequestType"];
                if (REQTYPE == null)
                    Response.Redirect("QuestionnaireSelect.aspx");
                else
                {
                    QNSID = Request.QueryString["QnsID"];
                    ExcRequest(REQTYPE);
                }
            }
        }
        
        protected void ExcRequest(string REQTYPE)
        {
            if (REQTYPE.Equals(CommonBL.ConstantType_Add))
            {
                TbQnsNo.Enabled = true;
                DdlType.Enabled = true;
                TbDesc.Enabled = true;
                BtnDelete.Visible = false;
                TbQnsNo.Text = (QUBL.Retrieve().Max(obj => obj.QnsID) + 1).ToString();
            }
            else if (REQTYPE.Equals(CommonBL.ConstantType_View))
            {
                TbQnsNo.Enabled = false;
                DdlType.Enabled = false;
                TbDesc.Enabled = false;
                BtnDelete.Visible = false;

                Questionnaire Qns = QUBL.Retrieve().Where(obj => obj.QnsID.ToString().Equals(QNSID)).FirstOrDefault();
                TbQnsNo.Text = Qns.QnsNo.ToString();
                DdlType.SelectedValue = Qns.Type;
                TbDesc.Text = Qns.Desc;
            }
            else if (REQTYPE.Equals(CommonBL.ConstantType_Update))
            {
                TbQnsNo.Enabled = true;
                DdlType.Enabled = true;
                TbDesc.Enabled = true;
                BtnDelete.Visible = true;

                Questionnaire Qns = QUBL.Retrieve().Where(obj => obj.QnsID.ToString().Equals(QNSID)).FirstOrDefault();
                TbQnsNo.Text = Qns.QnsNo.ToString();
                DdlType.SelectedValue = Qns.Type;
                TbDesc.Text = Qns.Desc;
            }
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            Questionnaire QnsObj = new Questionnaire()
            {
                QnsID = CommonBL.IntegerMapper(QNSID),
                QnsNo = CommonBL.IntegerMapper(TbQnsNo.Text),
                Type = DdlType.SelectedValue,
                Desc = TbDesc.Text
            };

            string errorMsg = QUBL.Validate(QnsObj, REQTYPE);
            if (errorMsg.Length > 0)
            {
                lblError.Text = errorMsg;
            }
            else
            {
                if (REQTYPE.Equals(CommonBL.ConstantType_Add))
                    QnsObj.CreateBy = (string)Session["LOGINUSER"];
                else
                    QnsObj.AmendBy = (string)Session["LOGINUSER"];

                int result = REQTYPE.Equals(CommonBL.ConstantType_Add) ? QUBL.Create(QnsObj) : QUBL.Update(QnsObj);
                switch (result)
                {
                    case 0:
                        Response.Redirect("QuestionnaireSelect.aspx");
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
            int result = QUBL.Delete(CommonBL.IntegerMapper(QNSID));
            switch (result)
            {
                case 0:
                    Response.Redirect("QuestionnaireSelect.aspx");
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
}