﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

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
            Response.Redirect("CreateNewAdmin.aspx");
		}

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow) {
                Control control = e.Row.Cells[2].Controls[0];
                if (control is LinkButton) {
                    ((LinkButton)control).OnClientClick = "return confirm('Are you sure you want to delete? This cannot undone.')";

                }

            }
        }
    }
}