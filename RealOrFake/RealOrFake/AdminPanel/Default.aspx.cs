using System;
using System.Web.UI.HtmlControls;

namespace RealOrFake.AdminPanel
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HtmlControl control = Master.FindControl("navUserSubmission") as HtmlControl;
            control.Attributes.Add("class", "nav-item active");

            if (Context.User.Identity.Name == "admin")
            {
                HtmlControl control2 = Master.FindControl("navAdminList") as HtmlControl;
                control2.Attributes.CssStyle.Add("display", "none");
            }

        }
    }
}