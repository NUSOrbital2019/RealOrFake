using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace RealOrFake.AdminPanel
{
	public partial class ViewAdminList : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            HtmlControl control = Master.FindControl("navAdminList") as HtmlControl;
            control.Attributes.Add("class", "nav-item active");
        }

		protected void CreateButton_Click(object sender, EventArgs e)
		{

		}

		protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
		{

		}

		protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
		{

		}
	}
}