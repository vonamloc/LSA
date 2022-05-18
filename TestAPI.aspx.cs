using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA
{
    public partial class TestAPI : System.Web.UI.Page
    {
        Label lblTitle;
        Label lblError;

        static string BEARERTOKEN;
        static string RESTREQUEST;
        static string JSON;

        protected void Page_Load(object sender, EventArgs e)
        {
            lblTitle = (Label)Page.Master.FindControl("lblTitle");
            lblTitle.Text = "Test API";
            lblError = (Label)Master.FindControl("lblError");
            lblError.Text = "";

            if (!Page.IsPostBack)
            {
                if (Session["BEARERTOKEN"] != null)
                    BEARERTOKEN = (string)Session["BEARERTOKEN"];

                if (Session["APIrequest"] != null)
                {
                    Session["APIrequest"] = null;
                    SendAPICall();
                }
            }
        }

        protected void GetBearerToken()
        {
            Response.Redirect(string.Format("https://api.minut.com/v5/oauth/authorize?response_type=code&client_id={0}&redirect_uri={1}", ConfigurationManager.AppSettings["OAuth2ClientID"], ConfigurationManager.AppSettings["RedirectURI"]));
        }

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            RESTREQUEST = TbRestRequest.Text;
            if (Session["BEARERTOKEN"] == null)
            {
                //Acquire BearerToken first
                Session["APIrequest"] = true;
                Session["TransferTo"] = $"TestAPI.aspx";
                GetBearerToken();
            }
            else
            {
                SendAPICall();
        }
    }

        protected void SendAPICall()
        {
            dynamic resp = JObject.Parse(BEARERTOKEN);

            if (string.IsNullOrEmpty(RESTREQUEST))
                lblError.Text = "REST Request is empty.";
            else
            {
                var client = new RestClient(RESTREQUEST);

                RestRequest restRequest = new RestRequest();
                if (DdlHTTPMethod.SelectedValue == "GET") restRequest = new RestRequest(Method.GET);
                if (DdlHTTPMethod.SelectedValue == "POST") restRequest = new RestRequest(Method.POST);
                if (DdlHTTPMethod.SelectedValue == "PUT") restRequest = new RestRequest(Method.PUT);
                if (DdlHTTPMethod.SelectedValue == "DEL") restRequest = new RestRequest(Method.DELETE);

                restRequest.AddHeader("cache-control", "no-cache");
                restRequest.AddHeader("content-type", "application/x-www-form-urlencoded");
                restRequest.AddHeader("authorization", "Bearer " + resp.access_token);
                IRestResponse response = client.Execute(restRequest);
                JSON = response.Content;
                TbReadingJSON.Text = CommonBL.PrettyPrintJson(JSON);
            }

            RESTREQUEST = "";
        }
    }
}