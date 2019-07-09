using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;

namespace RealOrFake.UserPanel
{
    public partial class AuthenticateImage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                String fileExtension = System.IO.Path.GetExtension(FileUpload1.FileName);
                if (!(fileExtension.Equals(".jpg") || fileExtension.Equals(".jpeg") || fileExtension.Equals(".bmp") || fileExtension.Equals(".png")))
                {
                    String message = "The extension of the file is: " + fileExtension;
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + message + ". \\nPlease upload an image with the extension of .png, .jpg, .jpeg, .bmp." + "');", true);
                }
                else
                {
                    using (MemoryStream memory = new MemoryStream())
                    {
                        //Image path shorten for Admin Panel retrieval and displaying
                        int submissionId = DateTime.Now.Millisecond;

                        string imagePathShortened = "/Resources/ImagesForAuthentication/" + submissionId + "-" + textbox_email.Text + ".jpg";

                        //Upload image into server
                        string imagePath = HttpContext.Current.Server.MapPath(@"~/Resources/ImagesForAuthentication/" + submissionId + "-" + textbox_email.Text + ".jpg");
                        FileUpload1.SaveAs(imagePath);

                        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["FileDatabaseConnectionString1"].ConnectionString);

                        //Insert to database
                        connection.Open();
                        SqlCommand insertCommand = new SqlCommand("INSERT INTO [Customer] (SubmissionId, Email, Name, ImagePath, SubmissionDate, Notes)" +
                            " VALUES (@submissionId, @email, @name, @imagePath, @submissionDate, @notes)");
                        insertCommand.Parameters.AddWithValue("@submissionId", submissionId);
                        insertCommand.Parameters.AddWithValue("@email", textbox_email.Text);
                        insertCommand.Parameters.AddWithValue("@name", textbox_name.Text);
                        insertCommand.Parameters.AddWithValue("@imagePath", imagePathShortened);
                        insertCommand.Parameters.AddWithValue("@submissionDate", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                        insertCommand.Parameters.AddWithValue("@notes", textbox_notes.Text);
                        insertCommand.Connection = connection;
                        insertCommand.ExecuteNonQuery();
                        connection.Close();

                        ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "We have received your request. \\nWe will contact you via email as soon as possible." + "');", true);
                    }

                }
            }
            else
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Please upload an image." + "');", true);
        }

    }
}