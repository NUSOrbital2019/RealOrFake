using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace RealOrFake.AdminPanel
{
    public partial class ViewAdminList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Context.User.Identity.Name != "master")
            {
                HtmlControl control2 = Master.FindControl("navAdminList") as HtmlControl;
                control2.Attributes.CssStyle.Add("display", "none");
                
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Access Denied.'); window.location = 'LoginPanel.aspx' ", true);
            }
            else
            {
                HtmlControl control = Master.FindControl("navAdminList") as HtmlControl;
                control.Attributes.Add("class", "nav-item active");
            }
        }

        protected void CreateButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateNewAdmin.aspx");
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Control control = e.Row.Cells[2].Controls[0];
                if (control is LinkButton)
                {
                    ((LinkButton)control).OnClientClick = "return confirm('Are you sure you want to delete? This cannot undone.')";
                }
            }
        }

        private static string ValidateBase64EncodedString(string inputText)
        {
            string stringToValidate = inputText;
            stringToValidate = stringToValidate.Replace('-', '+'); // 62nd char of encoding
            stringToValidate = stringToValidate.Replace('_', '/'); // 63rd char of encoding
            switch (stringToValidate.Length % 4) // Pad with trailing '='s
            {
                case 0: break; // No pad chars in this case
                case 2: stringToValidate += "=="; break; // Two pad chars
                case 3: stringToValidate += "="; break; // One pad char
                default:
                    throw new System.Exception(
             "Illegal base64url string!");
            }

            return stringToValidate;
        }

        public static String ComputeHash(string input, HashAlgorithm algorithm, Byte[] salt)
        {
            Byte[] inputBytes = Encoding.UTF8.GetBytes(input);

            Byte[] saltedInput = new Byte[salt.Length + inputBytes.Length];
            salt.CopyTo(saltedInput, 0);
            inputBytes.CopyTo(saltedInput, salt.Length);

            Byte[] hashedBytes = algorithm.ComputeHash(saltedInput);

            return BitConverter.ToString(hashedBytes);
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            //Retrieve username and password from Gridview
            Label lbl_AdminUserName = (Label)GridView1.Rows[e.RowIndex].FindControl("lbl_AdminUserName");
            String username = lbl_AdminUserName.Text;
            TextBox txt_AdminPassword = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txt_AdminPassword");
            String password = txt_AdminPassword.Text;

            //Retrieve SALT from database
            string dbSalt = "";

            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["FileDatabaseConnectionString1"].ConnectionString);

            connection.Open();
            SqlCommand myCommand = new SqlCommand("SELECT Salt FROM Admin", connection);
            SqlDataReader myReader = myCommand.ExecuteReader();
            while (myReader.Read())
            {
                dbSalt = (myReader["Salt"].ToString());
            }
            connection.Close();
            dbSalt = ValidateBase64EncodedString(dbSalt);

            string inputPasswordHash = ComputeHash(password, new SHA512CryptoServiceProvider(), Convert.FromBase64String(dbSalt));

            AdminData.UpdateCommand = "UPDATE [Admin] SET [AdminPassword] = '" + inputPasswordHash + "' WHERE AdminUsername = '" + username + "'";

            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('User [" + username + "] password has been updated.');", true);
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //Retrieve username and password from Gridview
            Label lbl_AdminUserName = (Label)GridView1.Rows[e.RowIndex].FindControl("lbl_AdminUserName");
            String username = lbl_AdminUserName.Text;

            AdminData.DeleteCommand = "DELETE FROM [Admin] WHERE [AdminUsername] = '" + username + "'";

            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('User [" + username + "] has been deleted.');", true);
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
        }

        protected void btnAuthenticate_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string inputUsername = Context.User.Identity.Name;
                string inputPassword = txtPasswordAuthenticate.Text;

                //var dbSalt = "PHBheW1lbnRSZXNwb25zZT48cmVzcG9uc2VDb2RlPjAwMDA8L3Jlc3BvbnNlQ29kZT48cmVzcG9uc2VDb2RlVGV4dD4wLVN1Y2Nlc3NmdWw8L3Jlc3BvbnNlQ29kZVRleHQ+PHJlc3BvbnNlU3VtbWFyeT5HUkVFTjwvcmVzcG9uc2VTdW1tYXJ5PjxwYXltZW50RXZlbnRJZGVudGlmaWVyPlRYTiAzNjM5PC9wYXltZW50RXZlbnRJZGVudGlmaWVyPjxMaXN0Pjxjb21wb25lbnRJRD5UWE4gMzYzOTwvY29tcG9uZW50SUQ+PGNsaWVudElEPkdPVERJU0UwNjwvY2xpZW50SUQ+PGJhbmtBdXRoQ29kZT5UOjEyMzQ8L2JhbmtBdXRoQ29kZT48YnV5bmV0VHhuSUQ+Mzc1PC9idXluZXRUeG5JRD48L0xpc3Q+PHBheW1lbnRJbnN0cnVtZW50UmVmPjwvcGF5bWVudEluc3RydW1lbnRSZWY+PG1hc2tlZENhcmROdW1iZXI+KioqKioqKioqKioqOTY4NjwvbWFza2VkQ2FyZE51bWJlcj48Y2FyZFR5cGU+TUFTVEVSQ0FSRDwvY2FyZFR5cGU+PGV4cGlyeURhdGU+MDMvMjAxNzwvZXhwaXJ5RGF0ZT48Y3VzdG9tRGF0YT4mbHQ7IVtDREFUQVsmbHQ7P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPSJVVEYtOCI_Jmd0Ow0KJmx0O1RoaXN0bGVDdXN0b21EYXRhIHhtbG5zOnhzZD0iaHR0cDovL3d3dy53My5vcmcvMjAwMS9YTUxTY2hlbWEiIHhtbG5zOnhzaT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS9YTUxTY2hlbWEtaW5zdGFuY2UiJmd0Ow0KICAmbHQ7T3JkZXJJZCZndDtCVFBQMzYzOSZsdDsvT3JkZXJJZCZndDsNCiAgJmx0O0Ftb3VudCZndDsxMjAmbHQ7L0Ftb3VudCZndDsNCiZsdDsvVGhpc3RsZUN1c3RvbURhdGEmZ3Q7XV0mZ3Q7PC9jdXN0b21EYXRhPjwvcGF5bWVudFJlc3BvbnNlPg";
                //dbSalt = ValidateBase64EncodedString(dbSalt);

                string dbUsername = "";
                string dbPasswordHash = "";
                string dbSalt = "";

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["FileDatabaseConnectionString1"].ConnectionString);
                connection.Open();
                SqlCommand myCommand = new SqlCommand("SELECT AdminUsername, AdminPassword, Salt FROM Admin WHERE AdminUsername = @AdminUsername", connection);
                myCommand.Parameters.AddWithValue("@AdminUsername", inputUsername);

                SqlDataReader myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    dbUsername = (myReader["AdminUsername"].ToString());
                    dbPasswordHash = (myReader["AdminPassword"].ToString());
                    dbSalt = (myReader["Salt"].ToString());
                }
                connection.Close();

                dbSalt = ValidateBase64EncodedString(dbSalt);

                string inputPasswordHash = ComputeHash(inputPassword, new SHA512CryptoServiceProvider(), Convert.FromBase64String(dbSalt));


                //if (IsValid)
                //{
                if (dbUsername.Equals(inputUsername.Trim()))
                {
                    if (dbPasswordHash.Equals(inputPasswordHash))
                    {
                        Page.ClientScript.RegisterStartupScript(GetType(), "alert", "$('#myModal').modal('hide')", true);
                        errormsgPasswordAuthenticate.Visible = false;
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(GetType(), "alert", "$('#myModal').modal('show')", true);
                        errormsgPasswordAuthenticate.Visible = true;
                    }
                }


                //}
            }
        }
    }
}