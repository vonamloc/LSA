using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA
{
    public partial class DashboardAdmin : System.Web.UI.Page
    {
        Label lblTitle;
        Label lblError;


        protected void Page_Load(object sender, EventArgs e)
        {
            lblTitle = (Label)Master.FindControl("lblTitle");
            lblTitle.Text = "Dashboard (Admin)";
            lblError = (Label)Master.FindControl("lblError");
            lblError.Text = "";
            GetBearerToken();
        }
        
        protected void GetBearerToken()
        {
            Response.Redirect(string.Format("https://api.minut.com/v5/oauth/authorize?response_type=code&client_id={0}&redirect_uri={1}", ConfigurationManager.AppSettings["OAuth2ClientID"], "https://learning-space-analytics.azurewebsites.net")); // ConfigurationManager.AppSettings["RedirectURI"]
        }
        
    }
}