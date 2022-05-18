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
    public partial class Login : System.Web.UI.Page
    {
        int attempt;
        readonly AppUserBL AUBL = new AppUserBL();
        readonly ParameterBL PABL = new ParameterBL();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.Text = "";
        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            /* User authentication flow:
 
                @Check if both fields are empty.
                - If yes, output error mesg.
                - #If no, check if loginid is valid.
                    - #If yes, check if account is locked
                        - if yes, output error msg
                        - #if no, check if loginid has previously been entered before. (i.e. stored in session)
                            -#if yes, *** check if password has expired
                                -if yes: error msg.
                                -#if no: check if password is valid.
                                 - #If yes, logs in user successfully
                                 - If no, output error msg. decrement attempt by 1. Check if attempt = 0.
                                    - If yes, lock account.
                                    - If no, repeat @ on btn event.
                            - If no, store new loginid in session with attempt counter. then go to ***.
                    - If no, output error msg

                Implementation:
                - Refreshing the page will not restart the attempt counter. Only closing the tab/application will do so.
                - Any valid loginid that is entered with the wrong password will be stored as session data to keep track of the no. of attempts for that account.
                - If account is locked out, don't bother checking for password.
                - Invalid loginid is not counted as a login attempt.
                - No password but valid loginid is also not considered login attempt.
                - If user did not change expired password before logout, user will have to forget and reset password in next login.

            */
            string pwd = HttpUtility.HtmlEncode(TbPassword.Text.ToString().Trim());
            string loginid = HttpUtility.HtmlEncode(TbLoginID.Text.ToString().Trim());
            bool loginSuccess = false;
            string errorMsg = null;

            if (string.IsNullOrEmpty(pwd) || string.IsNullOrEmpty(loginid))
            {
                errorMsg = "Please fill up both fields.";
            }
            else
            {
                AppUser UserObj = AUBL.SelectByLoginID(loginid);
                if (UserObj == null)
                {
                    errorMsg = "Account does not exist. Please contact Administrator.";
                }
                else
                {
                    if (Session[loginid] == null)
                        Session[loginid] = 5;

                    int distance = DateTime.Compare(DateTime.Now, UserObj.LockUntil);
                    if (distance < 0)
                    {
                        errorMsg = "Account is temporarily locked.";
                    }
                    else
                    {
                        bool unlockFail = false;
                        //Unlock account if it was previously locked
                        if (UserObj.LockStatus == "L")
                        {
                            Session[loginid] = 5;
                            int result = UnlockAccount(UserObj);
                            if (result != 0)
                            {
                                //Failed to unlock Account
                                unlockFail = true;
                            }
                        }

                        if (unlockFail)
                        {
                            errorMsg += "<br/>Something went wrong. Please contact Administrator.";
                        }
                        else
                        {
                            Parameter PasswordMaxLifeSpan = PABL.SelectByAllParaCode("PASSWORD", "AGE", "MAXIMUM");
                            distance = DateTime.Compare(DateTime.Now, UserObj.LastPwdSet.AddDays(int.Parse(PasswordMaxLifeSpan.Desc1)));
                            if (distance > 0)
                            {
                                errorMsg = "Your password has expired. Please select <strong>Forget Password</strong> to reset your password.";
                            }
                            else
                            {
                                SHA512Managed hashing = new SHA512Managed();
                                string dbHash = UserObj.PasswordHash;
                                string dbSalt = UserObj.PasswordSalt;
                                if (!string.IsNullOrEmpty(dbHash) && !string.IsNullOrEmpty(dbSalt))
                                {
                                    byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd + dbSalt));
                                    string userHash = Convert.ToBase64String(hashWithSalt);

                                    if (!userHash.Equals(dbHash))
                                    {
                                        attempt = (int)Session[loginid];
                                        attempt -= 1;
                                        Session[loginid] = attempt;
                                        if (attempt <= 0)
                                        {
                                            errorMsg = "You have reached your attempt limit.<br/>Your account has been locked temporarily.";
                                            int result = LockAccount(UserObj);
                                            if (result != 0)
                                            {
                                                //Failed to lock account
                                                errorMsg += "<br/>Something went wrong. Please contact Administrator.";
                                            }
                                        }
                                        else
                                            errorMsg = "Invalid password. Please try again.";
                                    }
                                    else
                                    {
                                        //if (ValidateCaptcha())
                                        loginSuccess = true;
                                        //else
                                        //    errorMsg = "Captcha unsuccessful";
                                    }
                                }
                                else
                                {
                                    //Account exists but has no password
                                    errorMsg = "Something went wrong. Please contact Administrator.";
                                }

                            }
                        }

                    }
                }
            }

            if (loginSuccess)
            {
                //Implement Session Fixation Prevention
                Session["LOGINUSER"] = loginid;
                //create a new GUID and save into the session
                string guid = Guid.NewGuid().ToString();
                Session["AuthToken"] = guid;

                //now create a new cookie with this guid value
                Response.Cookies.Add(new HttpCookie("AuthToken", guid));
                
                string redirectPage = "DashboardAdmin.aspx";
                AppUser UserObj = AUBL.SelectByLoginID(loginid);
                //TODO: Implement Reset Password
                //if(UserObj.LastLogin.Equals(new DateTime()))
                //{
                //    redirectPage = "ResetPassword.aspx";
                //}

                //Regardless of first time login or not, update LastLogin
                int result = UpdateLastLogin(UserObj);
                if (result == 0)
                {
                    Response.Redirect(redirectPage, false);
                }
                else
                {
                    //Failed to update LastLogin.
                    errorMsg += "<br/>Something went wrong. Please contact Administrator.";
                }
            }

            lblError.Text = errorMsg;
            lblError.Visible = lblError.Text.Length > 0;
        }

        protected int LockAccount(AppUser UserObj)
        {
            UserObj.LockStatus = "L";
            UserObj.LockUntil = DateTime.Now.AddMinutes(10);
            int result = AUBL.Update(UserObj);
            return result;
        }

        protected int UnlockAccount(AppUser UserObj)
        {
            UserObj.LockStatus = "U";
            UserObj.LockUntil = new DateTime();
            int result = AUBL.Update(UserObj);
            return result;
        }

        protected int UpdateLastLogin(AppUser UserObj)
        {
            UserObj.LastLogin = DateTime.Now;
            int result = AUBL.Update(UserObj);
            return result;
        }
    }
}