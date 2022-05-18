using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA
{
    public partial class AppUserView : System.Web.UI.Page
    {
        Label lblTitle;
        Label lblError;

        static string REQTYPE;
        static string LOGINID;

        readonly AppUserBL AUBL = new AppUserBL();
        readonly ParameterBL PABL = new ParameterBL();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblTitle = (Label)Page.Master.FindControl("lblTitle");
            lblTitle.Text = "App User";
            lblError = (Label)Page.Master.FindControl("lblError");
            lblError.Text = "";

            TabName.Value = Request.Form[TabName.UniqueID];

            if (!Page.IsPostBack)
            {
                REQTYPE = Request.QueryString["RequestType"];
                if (REQTYPE == null)
                    Response.Redirect("AppUserSelect.aspx");
                else
                {
                    LOGINID = Request.QueryString["LoginID"];
                    ExcRequest();
                }
            }
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            AppUser UserObj = new AppUser()
            {
                LoginID = TbLoginID.Text,
                Email = DdlUsrType.SelectedValue == "G" ? "" : TbEmail.Text,
                UsrName = TbUsrName.Text,
                UsrShtName = TbUsrShtName.Text,
                UsrType = DdlUsrType.SelectedValue,
                UsrRole = DdlUsrRole.SelectedValue,
                UsrStatus = DdlUsrStatus.SelectedValue,
                LockStatus = DdlLockStatus.SelectedValue,
                AccessRgt = DdlAccessRgt.SelectedValue,
                AccessRgtGrp = DdlAccessRgt.SelectedValue == "I" ? "" : DdlAccessRgtGrp.SelectedValue
            };

            string errorMsg = AUBL.Validate(UserObj, REQTYPE);
            if (errorMsg.Length > 0)
            {
                lblError.Text = errorMsg;
            }
            else
            {
                if (REQTYPE.Equals(CommonBL.ConstantType_Add))
                {
                    string pwd = PABL.SelectByAllParaCode("PASSWORD","DEFAULT", "").Desc1; 
                    
                    //Generate random "salt"
                    RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
                    byte[] saltByte = new byte[8];
                    //Fills array of bytes with a cryptographically strong sequence of random values.
                    rng.GetBytes(saltByte);
                    string salt = Convert.ToBase64String(saltByte);
                    SHA512Managed hashing = new SHA512Managed();
                    byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd + salt));
                    string finalHash = Convert.ToBase64String(hashWithSalt);
                    RijndaelManaged cipher = new RijndaelManaged();
                    cipher.GenerateKey();

                    UserObj.PasswordSalt = salt;
                    UserObj.PasswordHash = finalHash;
                    UserObj.IV = Convert.ToBase64String(cipher.IV);
                    UserObj.Key = Convert.ToBase64String(cipher.Key);
                    UserObj.CreateBy = (string)Session["LOGINUSER"];
                }
                else
                {
                    AppUser UserObj2 = AUBL.SelectByLoginID(LOGINID);
                    UserObj.PasswordSalt = UserObj2.PasswordSalt;
                    UserObj.PasswordHash = UserObj2.PasswordHash;
                    UserObj.IV = UserObj2.IV;
                    UserObj.Key = UserObj2.Key;
                    UserObj.LockUntil = UserObj2.LockUntil;
                    UserObj.LastLogin = UserObj2.LastLogin;
                    UserObj.LastPwdSet = UserObj2.LastPwdSet;
                    UserObj.AmendBy = (string)Session["LOGINUSER"];
                }


                int result = REQTYPE.Equals(CommonBL.ConstantType_Add) ? AUBL.Create(UserObj) : AUBL.Update(UserObj);
                
                switch (result)
                {
                    case 0:
                        Response.Redirect("AppUserSelect.aspx");
                        break;
                    case 1:
                        lblError.Text = "An error occured.";
                        break;
                    case 2:
                        lblError.Text = "A fatal error occured.";
                        break;
                }
            }
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            //TODO
        }

        protected void DdlUsrType_SelectedIndexChanged(object sender, EventArgs e)
        {
            SetControlProperties(REQTYPE);
        }

        protected void DdlUsrRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            //TODO
        }


        protected void DdlAccessRgt_SelectedIndexChanged(object sender, EventArgs e)
        {
            SetControlProperties(REQTYPE);
        }

        protected void ExcRequest()
        {
            PopulateUsrRole();
            PopulateAccessRgtGrp();

            if (!REQTYPE.Equals(CommonBL.ConstantType_Add))
            {
                GetDetails(LOGINID);
            }

            SetControlProperties(REQTYPE);
        }

        protected void SetControlProperties(string reqtype)
        {
            TbLoginID.Enabled = reqtype.Equals(CommonBL.ConstantType_Add);
            TbEmail.Enabled = !reqtype.Equals(CommonBL.ConstantType_View);
            TbUsrName.Enabled = !reqtype.Equals(CommonBL.ConstantType_View);
            TbUsrShtName.Enabled = !reqtype.Equals(CommonBL.ConstantType_View);
            DdlUsrType.Enabled = !reqtype.Equals(CommonBL.ConstantType_View);
            DdlUsrRole.Enabled = !reqtype.Equals(CommonBL.ConstantType_View);
            DdlUsrStatus.Enabled = !reqtype.Equals(CommonBL.ConstantType_View);
            DdlLockStatus.Enabled = !reqtype.Equals(CommonBL.ConstantType_View);
            DdlAccessRgt.Enabled = !reqtype.Equals(CommonBL.ConstantType_View);
            DdlAccessRgtGrp.Enabled = !reqtype.Equals(CommonBL.ConstantType_View);

            ucViewFooter.Visible = !reqtype.Equals(CommonBL.ConstantType_Add);
            BtnSubmit.Visible = !reqtype.Equals(CommonBL.ConstantType_View);
            BtnReset.Visible = reqtype.Equals(CommonBL.ConstantType_Update);

            divEmail.Visible = DdlUsrType.SelectedValue == "I";
            divAccessRgtGrp.Visible = DdlAccessRgt.SelectedValue == "G";
        }

        protected void GetDetails(string loginid)
        {
            AppUser UserObj = AUBL.SelectByLoginID(loginid);

            TbLoginID.Text = UserObj.LoginID;
            TbEmail.Text = UserObj.Email;
            TbUsrName.Text = UserObj.UsrName;
            TbUsrShtName.Text = UserObj.UsrShtName;
            DdlUsrType.SelectedValue = UserObj.UsrType;
            DdlUsrRole.SelectedValue = UserObj.UsrRole;
            DdlUsrStatus.SelectedValue = UserObj.UsrStatus;
            DdlLockStatus.SelectedValue = UserObj.LockStatus;
            DdlAccessRgt.SelectedValue = UserObj.AccessRgt;
            DdlAccessRgtGrp.SelectedValue = UserObj.AccessRgtGrp;

            ucViewFooter.CreateBy = UserObj.CreateBy;
            ucViewFooter.CreateDate = UserObj.CreateDate.ToString();
            ucViewFooter.AmendBy = UserObj.AmendBy;
            ucViewFooter.AmendDate = UserObj.AmendDate.ToString();
        }

        protected void PopulateUsrRole()
        {
            try
            {
                List<Parameter> ParamList = PABL.SelectByParaCode1("USRROLE");

                DdlUsrRole.DataSource = ParamList;
                DdlUsrRole.DataTextField = "Desc1";
                DdlUsrRole.DataValueField = "ParaCode2";
                DdlUsrRole.DataBind();
            }
            catch (Exception e)
            {
                CommonBL.LogError(this.GetType(), "PopulateUsrRole", e.Message);
            }
        }

        protected void PopulateAccessRgtGrp()
        {
            try
            {
                List<Parameter> ParamList = PABL.SelectByParaCode1("ACCESSRGTGRP");

                DdlAccessRgtGrp.DataSource = ParamList;
                DdlAccessRgtGrp.DataTextField = "Desc1";
                DdlAccessRgtGrp.DataValueField = "ParaCode2";
                DdlAccessRgtGrp.DataBind();
            }
            catch (Exception e)
            {
                CommonBL.LogError(this.GetType(), "PopulateAccessRgtGrp", e.Message);
            }
        }
    }
}