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
                        int submissionId;

                        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["FileDatabaseConnectionString1"].ConnectionString);

                        //Retrieve the next running submissionId from database
                        connection.Open();
                        SqlCommand selectCommand = new SqlCommand("SELECT count(submissionId) FROM Customer ", connection);
                        submissionId = (int)selectCommand.ExecuteScalar();
                        connection.Close();

                        if (submissionId == -1)
                            submissionId = 0;

                        //Upload image into server
                        string imagePath = HttpContext.Current.Server.MapPath(@"~/Resources/ImagesForAuthentication/" + (submissionId + 1) + "-" + textbox_email.Text + ".jpg");
                        FileUpload1.SaveAs(imagePath);

                        //Insert to database
                        connection.Open();
                        SqlCommand insertCommand = new SqlCommand("INSERT INTO [Customer] (Email, Name, ImagePath)" +
                            " VALUES (@email, @name, @imagePath)");
                        //insertCommand.Parameters.AddWithValue("@submissionId", submissionId);
                        insertCommand.Parameters.AddWithValue("@email", textbox_email.Text);
                        insertCommand.Parameters.AddWithValue("@name", textbox_name.Text);
                        insertCommand.Parameters.AddWithValue("@imagePath", imagePath);
                        //insertCommand.Parameters.AddWithValue("@submissionStatus", "Pending");
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