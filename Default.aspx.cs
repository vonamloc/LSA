using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA
{
    public partial class _Default : Page
    {
        static string CODE;

        protected void Page_Load(object sender, EventArgs e)
        {
            Label lblTitle = (Label)Page.Master.FindControl("lblTitle");
            lblTitle.Text = "Home";

            if (!Page.IsPostBack)
            {
                CODE = Request.QueryString["CODE"];
                if (CODE != null)
                {
                    ExchangeTokenByAuthCode();
                    if (Session["TransferTo"] != null)
                    {
                        string TRANSFERTO = Session["TransferTo"].ToString();
                        Session["TransferTo"] = null;
                        Response.Redirect(TRANSFERTO);
                    }

                }
            }
        }

        //By authorization code grant
        protected void ExchangeTokenByAuthCode()
        {
            var client = new RestClient("https://api.minut.com/v5/oauth/token");
            var request = new RestRequest(Method.POST);
            request.AddHeader("cache-control", "no-cache");
            request.AddHeader("content-type", "application/x-www-form-urlencoded");
            request.AddHeader("authorization", "Bearer <access_token>");
            request.AddParameter("application/x-www-form-urlencoded", string.Format("grant_type=authorization_code&client_id={0}&client_secret={1}&code={2}&response_type=token", ConfigurationManager.AppSettings["OAuth2ClientID"], ConfigurationManager.AppSettings["OAuth2ClientSecret"], CODE), ParameterType.RequestBody);
            IRestResponse response = client.Execute(request);
            System.Diagnostics.Trace.WriteLine($"Bearer token here: {response.Content}");
            Session["BEARERTOKEN"] = response.Content;
        }
    }
}