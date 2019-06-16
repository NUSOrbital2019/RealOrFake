using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

namespace RealOrFake.AdminPanel
{
    public partial class CreateNewAdmin : System.Web.UI.Page
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["FileDatabaseConnectionString1"].ConnectionString);

        protected void SubmitButton_Click(object sender, EventArgs e)
        {

            connection.Open();
            SqlCommand insertAdminDetailsCommand = new SqlCommand();
            insertAdminDetailsCommand.CommandText = "INSERT INTO Admin (AdminUserName, AdminPassword)" +
                " VALUES (@AdminUserName, @AdminPassword)";
            insertAdminDetailsCommand.Parameters.AddWithValue("@AdminUserName", TextBox1.Text);
            insertAdminDetailsCommand.Parameters.AddWithValue("@AdminPassword", TextBox2.Text);

            insertAdminDetailsCommand.Connection = connection;
            insertAdminDetailsCommand.ExecuteNonQuery();
            connection.Close();
            Response.Write("Admin has been added succeesfully");
        }


        protected void resetBtn_Click(object sender, EventArgs e)
        {
            TextBox1.Text = String.Empty;
            TextBox2.Text = String.Empty;
        }
    }
}