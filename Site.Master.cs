using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LOGINUSER"] != null && Session["AuthToken"] != null && Request.Cookies["AuthToken"] != null)
            {
                if (Session["AuthToken"].ToString() != Request.Cookies["AuthToken"].Value)
                    Response.Redirect("Login.aspx", false);
            }
            else
                Response.Redirect("Login.aspx", false);
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Session.RemoveAll();

            Response.Redirect("Login.aspx", false);

            if (Request.Cookies["AuthToken"] != null)
            {
                Response.Cookies["AuthToken"].Value = string.Empty;
                Response.Cookies["AuthToken"].Expires = DateTime.Now.AddMonths(-20);
            }
        }
    }
}