using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace RealOrFake.AdminPanel
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HtmlControl control = Master.FindControl("navUserSubmission") as HtmlControl;
            control.Attributes.Add("class", "nav-item active");

            if (Context.User.Identity.Name != "master")
            {
                HtmlControl control2 = Master.FindControl("navAdminList") as HtmlControl;
                control2.Attributes.CssStyle.Add("display", "none");
            }
        }

        protected void dropdown_status_SelectedIndexChanged(object sender, EventArgs e)
        {
            String submissionStatus = "";
            GridViewRow gvr = (GridViewRow)(((Control)sender).NamingContainer);
            DropDownList ddl_status = (DropDownList)gvr.FindControl("dropdown_status");
            submissionStatus = ddl_status.SelectedItem.Text;

            String name = gvr.Cells[0].Text;
            String email = gvr.Cells[1].Text;
            String imagePath = gvr.Cells[2].Text;
            updateSubmissionStatus(submissionStatus, imagePath);
            //sendEmail();
        }

        private void updateSubmissionStatus(String submissionStatus, String imagePath)
        {
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["FileDatabaseConnectionString1"].ConnectionString);

            connection.Open();

            SqlCommand updateSubmissionStatusCommand = new SqlCommand("UPDATE Customer SET SubmissionStatus = @submissionStatus WHERE imagePath = @imagePath", connection);
            updateSubmissionStatusCommand.Parameters.AddWithValue("@submissionStatus", submissionStatus);
            updateSubmissionStatusCommand.Parameters.AddWithValue("@imagePath", imagePath);

            updateSubmissionStatusCommand.ExecuteNonQuery();
            connection.Close();
        }
        

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteSubmission")
            {
                string imagePath = e.CommandArgument.ToString();
                deleteSubmission(imagePath);
            }
        }

        private void deleteSubmission(String imagePath)
        {
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["FileDatabaseConnectionString1"].ConnectionString);

            connection.Open();

            SqlCommand updateSubmissionStatusCommand = new SqlCommand("DELETE FROM Customer WHERE imagePath = @imagePath", connection);
            updateSubmissionStatusCommand.Parameters.AddWithValue("@imagePath", imagePath);

            updateSubmissionStatusCommand.ExecuteNonQuery();
            connection.Close();
        }
    }
}