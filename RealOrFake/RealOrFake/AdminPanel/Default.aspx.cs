using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Web;
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

            String submissionId = gvr.Cells[1].Text;
            String name = gvr.Cells[2].Text;
            String email = gvr.Cells[3].Text;

            var imgBtn = (ImageButton)gvr.FindControl("ImageBtn_ImagePath");
            String imagePath = imgBtn.CommandArgument;

            updateSubmissionStatus(submissionStatus, imagePath);
            sendEmail(submissionId, name, email, submissionStatus, imagePath);
            Response.Redirect(Request.RawUrl);
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
                Response.Redirect(Request.RawUrl);
            }
            else if (e.CommandName == "SelectImage")
            {
                string imagePath = e.CommandArgument.ToString();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Open", "window.open('" + imagePath + "');", true);
            }
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

        private void sendEmail(string id, string name, string email, string submissionStatus, string imagePath)
        {
            name = name.Trim();
            email = email.Trim();

            using (MailMessage mm = new MailMessage("realorfakegoodsauthenticator@gmail.com", email))
            {
                mm.Subject = "Submission #" + id + " for Photo Authentication Status Updated";

                string body = "Hello " + name + ",";
                body += "<br /><br />Thank you for using our service.";
                body += "<br /><br />We have verified your request on this attached product with the submission ID " + id + ".";
                body += "<br /><br />Based on our evaluation, we have came to a conclusion that your item is <b>" + submissionStatus + "</b>.";
                body += "<br /><br />Please take note that we are not liable for any losses or hold responsibilities with our evaluation.";
                body += "<br /><br />Best regards,";
                body += "<br />RealOrFake";
                mm.Body = body;
                mm.IsBodyHtml = true;

                //Add photo attachment
                string attachmentPath = HttpContext.Current.Server.MapPath(@"~/Resources/ImagesForAuthentication/" + id + "-" + email + ".jpg");
                Attachment inline = new Attachment(attachmentPath);
                inline.ContentDisposition.Inline = true;
                inline.ContentDisposition.DispositionType = DispositionTypeNames.Inline;
                //inline.ContentId = contentID;
                inline.ContentType.MediaType = "image/jpg";
                inline.ContentType.Name = Path.GetFileName(attachmentPath);
                mm.Attachments.Add(inline);

                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true;
                NetworkCredential NetworkCred = new NetworkCredential("realorfakegoodsauthenticator@gmail.com", "realorfake123");
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Port = 587;
                smtp.Send(mm);
            }

        }

    }
}