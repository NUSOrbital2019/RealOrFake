using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;

namespace RealOrFake.UserPanel
{
    public partial class AuthenticateImage : System.Web.UI.Page
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["FileDatabaseConnectionString1"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String timeNow = DateTime.Now.ToLongTimeString();

            using (MemoryStream memory = new MemoryStream())
            {
                string imagePath = HttpContext.Current.Server.MapPath(@"~/Resources/ImagesForAuthentication/" + DateTime.Now.Millisecond + ".jpg");

                FileUpload1.SaveAs(imagePath); // Upload image to server

                SqlCommand insertCommand = new SqlCommand("INSERT INTO User (Email, FirstName, LastName, AuthenticationId, ImagePath)" +
                    " VALUES (@email, @firstName, @lastName, @authenticationId, @imagePath)");
                insertCommand.Parameters.AddWithValue("@email", Session["email"].ToString());
                insertCommand.Parameters.AddWithValue("@firstName", Session["firstName"].ToString());
                insertCommand.Parameters.AddWithValue("@lastName", Session["lastName"].ToString());
                insertCommand.Parameters.AddWithValue("@authenticationId", Session["authenticationId"].ToString());
                insertCommand.Parameters.AddWithValue("@imagePath", Session["imagePath"].ToString());


                insertCommand.Connection = connection;
                insertCommand.ExecuteNonQuery();
                connection.Close();
            }
        }


    }
}