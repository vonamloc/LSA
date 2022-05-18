using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA
{
    public partial class Profile : System.Web.UI.Page
    {
        Label lblTitle;
        Label lblError;

        static string LOGINUSER;
        static AppUser UserObj;

        readonly AppUserBL AUBL = new AppUserBL();
        readonly ParameterBL PABL = new ParameterBL();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblTitle = (Label)Master.FindControl("lblTitle");
            lblTitle.Text = "My Profile";
            lblError = (Label)Master.FindControl("lblError");
            lblError.Text = "";

            if (!Page.IsPostBack)
            {
                LOGINUSER = (string)Session["LOGINUSER"];
                ExcRequest();
            }
        }

        protected void ExcRequest()
        {
            GetDetails(LOGINUSER);
            SetControlProperties();
        }

        protected void GetDetails(string loginid)
        {
            UserObj = AUBL.SelectByLoginID(loginid);
            TbLoginID.Text = UserObj.LoginID;
            TbEmail.Text = UserObj.Email;
        }

        protected void SetControlProperties()
        {
            TbLoginID.Enabled = TbEmail.Enabled = false;
            TbOldPwd.Enabled = TbNewPwd.Enabled = TbCfmPwd.Enabled = true;
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            string old_p = HttpUtility.HtmlEncode(TbOldPwd.Text.ToString().Trim());
            string new_p = HttpUtility.HtmlEncode(TbNewPwd.Text.ToString().Trim());
            string cfm_p = HttpUtility.HtmlEncode(TbCfmPwd.Text.ToString().Trim());
            string errorMsg = "";

            Parameter PasswordMinLifeSpan = PABL.SelectByAllParaCode("PASSWORD", "AGE", "MINIMUM");
            int days = CommonBL.IntegerMapper(PasswordMinLifeSpan.Desc1);
            int distance = DateTime.Compare(DateTime.Now, UserObj.LastPwdSet.AddDays(days));
            if (distance < 0)
                errorMsg = $"You are not allowed to change your password now.<br/>Password needs to have a minimum age of {days} day(s).";
            else
            {
                if (string.IsNullOrEmpty(old_p) || string.IsNullOrEmpty(new_p) || string.IsNullOrEmpty(cfm_p))
                {
                    errorMsg = "Please fill up all input fields";
                }
                else
                {
                    SHA512Managed hashing = new SHA512Managed();
                    string dbHash = UserObj.PasswordHash;
                    string dbSalt = UserObj.PasswordSalt;
                    if (dbSalt != null && dbSalt.Length > 0 && dbHash != null && dbHash.Length > 0)
                    {
                        string pwdWithSalt = old_p + dbSalt;
                        byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                        string userHash = Convert.ToBase64String(hashWithSalt);
                        if (userHash.Equals(dbHash))
                        {
                            //Old password Valid OK
                            //Password Complexity (Server Side) Validation
                            if (Regex.IsMatch(new_p, "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[A-Za-z0-9!@#$%^&*]{8,}$"))
                            {
                                //New Password Complexity OK
                                if (cfm_p == new_p)
                                {
                                    //Password Re-enter OK
                                    if (new_p != old_p)
                                        UpdateSuccess(new_p);
                                    else
                                        errorMsg = "Action not allowed. Old password cannot be reused.";
                                }
                                else
                                    errorMsg = "New passwords do not match. Please try again.";
                            }
                            else
                                errorMsg = "Failed to meet password criteria! <br/> Must be at least 8 characters and contain uppercase and lowercase letters, digits and special characters.";
                        }
                        else
                            errorMsg = "Old password is invalid. Please try again";
                    }
                }

            }

            lblError.Text = errorMsg;
        }

        protected void UpdateSuccess(string newPwd)
        {
            //Generate random "salt"
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            byte[] saltByte = new byte[8];
            //Fills array of bytes with a cryptographically strong sequence of random values.
            rng.GetBytes(saltByte);
            string salt = Convert.ToBase64String(saltByte);
            SHA512Managed hashing = new SHA512Managed();
            byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(newPwd + salt));
            string finalHash = Convert.ToBase64String(hashWithSalt);

            UserObj.LastPwdSet = DateTime.Now;
            UserObj.PasswordSalt = salt;
            UserObj.PasswordHash = finalHash;

            int result = AUBL.Update(UserObj);

            switch (result)
            {
                case 0:
                    Response.Redirect("Home.aspx");
                    break;
                case 1:
                    lblError.Text = "An error occured. Failed to updated password.";
                    break;
                case 2:
                    lblError.Text = "A fatal error occured. Failed to updated password.";
                    break;
            }

        }
    }
}