using Microsoft.Owin;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.Cookies;
using Owin;
using System;
using System.Web;
using Microsoft.AspNet.Identity;

[assembly: OwinStartupAttribute(typeof(RealOrFake.Startup))]
namespace RealOrFake
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            app.UseCookieAuthentication(new CookieAuthenticationOptions
            {
                AuthenticationType = DefaultAuthenticationTypes.ApplicationCookie,
                LoginPath = new PathString("/Login")
            });
            //ConfigureAuth(app);
        }
    }
}
