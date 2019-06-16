using System;
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

		protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
		{

		}

        private void deleteSubmission(String imagePath)
        {
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["FileDatabaseConnectionString1"].ConnectionString);

            connection.Open();

            SqlCommand updateSubmissionStatusCommand = new SqlCommand("DELETE FROM Customer WHERE imagePath = @imagePath;", connection);
            updateSubmissionStatusCommand.Parameters.AddWithValue("@imagePath", imagePath);

            updateSubmissionStatusCommand.ExecuteNonQuery();
            connection.Close();
        }

    }
}