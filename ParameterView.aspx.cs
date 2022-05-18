using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA
{
    public partial class ParameterView : System.Web.UI.Page
    {
        Label lblTitle;
        Label lblError;

        static string REQTYPE;
        static string PARACODE1;

        readonly ParameterBL PABL = new ParameterBL();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblTitle = (Label)Master.FindControl("lblTitle");
            lblTitle.Text = "Parameter";
            lblError = (Label)Master.FindControl("lblError");
            lblError.Text = "";

            if (!Page.IsPostBack)
            {
                REQTYPE = Request.QueryString["RequestType"];
                if (REQTYPE == null)
                    Response.Redirect("ParameterSelect.aspx");
                else
                {
                    PARACODE1 = Request.QueryString["ParaCode1"];
                    ExcRequest(REQTYPE);
                }
            }
        }

        protected void ExcRequest(string REQTYPE)
        {
            PopulateParaCode1();
            if (!REQTYPE.Equals(CommonBL.ConstantType_Add))
            {
                DdlParaCode1.SelectedValue = PARACODE1;
            }

            PopulateParaCode2();
            PopulateParaCode3();

            SetControlPropertiesDefault(REQTYPE);
        }

        protected void DdlParaCode1_SelectedIndexChanged(object sender, EventArgs e)
        {
            SetControlPropertiesDefault(REQTYPE);
            PopulateParaCode2();
            PopulateParaCode3();
            if (DdlParaCode1.SelectedIndex != 0)
            {
                SetControlPropertiesAfterP1SelectExisting(REQTYPE);
            }
        }

        protected void DdlParaCode2_SelectedIndexChanged(object sender, EventArgs e)
        {
            SetControlPropertiesDefault(REQTYPE);
            SetControlPropertiesAfterP1SelectExisting(REQTYPE);
            PopulateParaCode3();
            if (DdlParaCode2.SelectedIndex != 0)
            {
                SetControlPropertiesAfterP2SelectExisting(REQTYPE);
            }
        }

        protected void DdlParaCode3_SelectedIndexChanged(object sender, EventArgs e)
        {
            SetControlPropertiesDefault(REQTYPE);
            SetControlPropertiesAfterP1SelectExisting(REQTYPE);
            SetControlPropertiesAfterP2SelectExisting(REQTYPE);
            GetDetails();
            if (DdlParaCode3.SelectedIndex != 0)
            {
                SetControlPropertiesAfterP3SelectExisting(REQTYPE);
            }
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            Parameter ParamObj = new Parameter()
            {
                ParaCode1 = DdlParaCode1.SelectedIndex != 0 ? DdlParaCode1.SelectedValue : TbParaCode1.Text,
                ParaCode2 = DdlParaCode2.SelectedIndex != 0 ? DdlParaCode2.SelectedValue : TbParaCode2.Text,
                ParaCode3 = DdlParaCode3.SelectedIndex != 0 ? DdlParaCode3.SelectedValue : TbParaCode3.Text,
                Desc1 = TbDesc1.Text,
                Desc2 = TbDesc2.Text
            };

            string errorMsg = PABL.Validate(ParamObj, REQTYPE);
            if(errorMsg.Length > 0)
            {
                lblError.Text = errorMsg;
            }
            else
            {
                if (REQTYPE.Equals(CommonBL.ConstantType_Add))
                    ParamObj.CreateBy = (string)Session["LOGINUSER"];
                else
                    ParamObj.AmendBy = (string)Session["LOGINUSER"];

                int result = REQTYPE.Equals(CommonBL.ConstantType_Add) ? PABL.Create(ParamObj) : PABL.Update(ParamObj);
                switch (result)
                {
                    case 0:
                        Response.Redirect($"ParameterView.aspx?RequestType={REQTYPE}{(REQTYPE.Equals(CommonBL.ConstantType_Add)? "" : " &ParaCode1=" + PARACODE1)}");
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
            Parameter ParamObj = PABL.SelectByAllParaCode(DdlParaCode1.SelectedValue, DdlParaCode2.SelectedValue, DdlParaCode3.SelectedValue);
            int result = PABL.Delete(ParamObj);
            if (result == 0)
            {
                List<Parameter> ParamList = PABL.SelectByParaCode1(PARACODE1);
                if (ParamList.Count > 0)
                {
                    Response.Redirect($"ParameterView.aspx?RequestType={REQTYPE}&ParaCode1={PARACODE1}");
                }
                else
                {
                    Response.Redirect("ParameterSelect.aspx");
                }
                
            }
            else
            {
                lblError.Text = "Oops! Something went wrong...Please contact Administrator";
            }
        }

        protected void BtnDeleteAll_Click(object sender, EventArgs e)
        {
            List<Parameter> ParamList = PABL.SelectByParaCode1(PARACODE1);
            foreach(Parameter ParamObj in ParamList)
            {
                int result = PABL.Delete(ParamObj);
                if(result == 0)
                {
                    continue;
                }
                else
                {
                    break;
                }
            }
            ParamList = PABL.SelectByParaCode1(PARACODE1);
            if(ParamList.Count > 0)
            {
                lblError.Text = "Oops! Something went wrong...Please contact Administrator";
            }
            else
            {
                Response.Redirect("ParameterSelect.aspx");
            }
        }

        protected void SetControlPropertiesDefault(string reqtype)
        {
            if (reqtype.Equals(CommonBL.ConstantType_View))
            {
                TbParaCode1.Visible = false;
                DdlParaCode2.Enabled = DdlParaCode1.SelectedIndex != 0;
                TbParaCode2.Visible = false;
                DdlParaCode3.Enabled = false;
                TbParaCode3.Visible = false;

                TbDesc1.Enabled = TbDesc2.Enabled = false;
                TbParaCode1.Text = TbParaCode2.Text = TbDesc1.Text = TbDesc2.Text = "";

                ucViewFooter.Visible = false;
                BtnDelete.Visible = BtnDeleteAll.Visible = BtnSubmit.Visible = false;
            }
            else if (reqtype.Equals(CommonBL.ConstantType_Add))
            {
                TbParaCode1.Attributes.Add("placeholder", "Add New...");
                TbParaCode2.Attributes.Add("placeholder", "Add New...");
                TbParaCode3.Attributes.Add("placeholder", "Add New...");
                TbParaCode1.Enabled = TbParaCode1.Visible = TbParaCode2.Visible = TbParaCode3.Visible = true;
                DdlParaCode2.Enabled = TbParaCode2.Enabled = false;
                DdlParaCode3.Enabled = TbParaCode3.Enabled = false;
                DdlParaCode3.Visible = false;

                TbDesc1.Attributes.Add("placeholder", "Add New...");
                TbDesc2.Attributes.Add("placeholder", "Add New...");
                TbDesc1.Enabled = TbDesc2.Enabled = false;
                TbParaCode1.Text = TbParaCode2.Text = TbDesc1.Text = TbDesc2.Text = "";

                ucViewFooter.Visible = false;
                BtnDelete.Visible = BtnDeleteAll.Visible = BtnSubmit.Enabled = false;
            }
            else if (reqtype.Equals(CommonBL.ConstantType_Update))
            {
                TbParaCode1.Visible = false;
                DdlParaCode2.Enabled = DdlParaCode1.SelectedIndex != 0;
                TbParaCode2.Visible = false;
                DdlParaCode3.Enabled = false;
                TbParaCode3.Visible = false;

                TbDesc1.Enabled = TbDesc2.Enabled = false;
                TbParaCode1.Text = TbParaCode2.Text = TbDesc1.Text = TbDesc2.Text = "";

                ucViewFooter.Visible = false;
                BtnDelete.Enabled = BtnSubmit.Enabled = false;
                BtnDeleteAll.Enabled = DdlParaCode1.SelectedIndex != 0;
            }
        }

        protected void SetControlPropertiesAfterP1SelectExisting(string reqtype)
        {
            if (reqtype.Equals(CommonBL.ConstantType_Add))
            {
                DdlParaCode2.Enabled = TbParaCode2.Enabled = TbParaCode3.Enabled = TbDesc1.Enabled = TbDesc2.Enabled = true;
                TbParaCode1.Visible = false;
            }
            else if (reqtype.Equals(CommonBL.ConstantType_View))
            {
                DdlParaCode2.Enabled = true;
            }
            else if (reqtype.Equals(CommonBL.ConstantType_Update))
            {
                DdlParaCode2.Enabled = true;
            }
        }

        protected void SetControlPropertiesAfterP2SelectExisting(string reqtype)
        {
            if (reqtype.Equals(CommonBL.ConstantType_Add))
            {
                TbParaCode3.Enabled = TbDesc1.Enabled = TbDesc2.Enabled = BtnSubmit.Enabled = true;
                TbParaCode2.Visible = false;
            }
            else if (reqtype.Equals(CommonBL.ConstantType_View))
            {
                DdlParaCode3.Enabled = true;
            }
            else if (reqtype.Equals(CommonBL.ConstantType_Update))
            {
                DdlParaCode3.Enabled = true;
            }
        }

        protected void SetControlPropertiesAfterP3SelectExisting(string reqtype)
        {
            if (reqtype.Equals(CommonBL.ConstantType_Add))
            {
                TbDesc1.Enabled = TbDesc2.Enabled = BtnSubmit.Enabled = true;
            }
            else if (reqtype.Equals(CommonBL.ConstantType_View))
            {
                ucViewFooter.Visible = true;

            }
            else if (reqtype.Equals(CommonBL.ConstantType_Update))
            {
                TbDesc1.Enabled = TbDesc2.Enabled = BtnDelete.Enabled = BtnSubmit.Enabled = ucViewFooter.Visible = true;

            }
        }

        public void PopulateParaCode1()
        {
            List<Parameter> ParamList = PABL.SelectParaCode1();
            DdlParaCode1.DataSource = ParamList;
            DdlParaCode1.DataTextField = "ParaCode1";
            DdlParaCode1.DataValueField = "ParaCode1";
            DdlParaCode1.DataBind();
            DdlParaCode1.Items.Insert(0, new ListItem(REQTYPE.Equals(CommonBL.ConstantType_Add) ? "<Add New>" : "<Select ParaCode>", "None"));
        }

        public void PopulateParaCode2()
        {
            List<Parameter> ParamList = PABL.SelectParaCode2(DdlParaCode1.SelectedValue);
            DdlParaCode2.DataSource = ParamList;
            DdlParaCode2.DataTextField = "ParaCode2";
            DdlParaCode2.DataValueField = "ParaCode2";
            DdlParaCode2.DataBind();
            DdlParaCode2.Items.Insert(0, new ListItem(REQTYPE.Equals(CommonBL.ConstantType_Add) ? "<Add New>" : "<Select ParaCode>", "None"));
        }

        public void PopulateParaCode3()
        {
            List<Parameter> ParamList = PABL.SelectByParaCode1And2(DdlParaCode1.SelectedValue, DdlParaCode2.SelectedValue);
            DdlParaCode3.DataSource = ParamList;
            DdlParaCode3.DataTextField = "ParaCode3";
            DdlParaCode3.DataValueField = "ParaCode3";
            DdlParaCode3.DataBind();
            DdlParaCode3.Items.Insert(0, new ListItem(REQTYPE.Equals(CommonBL.ConstantType_Add) ? "<Add New>" : "<Select ParaCode>", "None"));
        }

        public void GetDetails()
        {
            Parameter ParamObj = PABL.SelectByAllParaCode(DdlParaCode1.SelectedValue, DdlParaCode2.SelectedValue, DdlParaCode3.SelectedValue);
            if (ParamObj != null)
            {
                TbDesc1.Text = ParamObj.Desc1;
                TbDesc2.Text = ParamObj.Desc2;
                ucViewFooter.CreateBy = ParamObj.CreateBy;
                ucViewFooter.CreateDate = ParamObj.CreateDate.ToString();
                ucViewFooter.AmendBy = ParamObj.AmendBy;
                ucViewFooter.AmendDate = ParamObj.AmendDate.ToString();
            }
        }
    }
}