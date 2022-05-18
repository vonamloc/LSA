using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.Http;
//using Hangfire;
//using Hangfire.SqlServer;
//using System.Diagnostics;

namespace LSA
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            AreaRegistration.RegisterAllAreas();
            System.Web.Http.GlobalConfiguration.Configure(WebApiConfig.Register);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            //AreaRegistration.RegisterAllAreas();
            //HangfireAspNet.Use(GetHangfireServers);
            //BackgroundJob.Enqueue(() => Debug.WriteLine("test"));
        }

        /*
        private IEnumerable<IDisposable> GetHangfireServers()
        {
            Hangfire.GlobalConfiguration.Configuration
                .SetDataCompatibilityLevel(CompatibilityLevel.Version_170)
                .UseSimpleAssemblyNameTypeSerializer()
                .UseRecommendedSerializerSettings()
                .UseSqlServerStorage("Server=LAPTOP-6R39QOG4; Database=HangfireServer; Integrated Security=True;", new SqlServerStorageOptions
                {
                    CommandBatchMaxTimeout = TimeSpan.FromMinutes(3),
                    SlidingInvisibilityTimeout = TimeSpan.FromMinutes(3),
                    QueuePollInterval = TimeSpan.Zero,
                    UseRecommendedIsolationLevel = true,
                    DisableGlobalLocks = true

                });
            yield return new BackgroundJobServer();
        }
        */

    }
}