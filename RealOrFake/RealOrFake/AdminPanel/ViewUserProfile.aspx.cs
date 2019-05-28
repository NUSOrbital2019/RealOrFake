using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace RealOrFake.AdminPanel
{
    public partial class ViewUserProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HtmlControl control = Master.FindControl("navUserProfile") as HtmlControl;
            control.Attributes.Add("class", "nav-item active");
        }
}
}