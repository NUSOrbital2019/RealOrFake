using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Security;

namespace RealOrFake.AdminPanel
{
    public partial class LoginPanel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            string inputUsername = txtUsername.Text;
            string inputPassword = txtPassword.Text;

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

            if (IsValid)
            {
                if (dbUsername.Equals(inputUsername.Trim()))
                {
                    if (dbPasswordHash.Equals(inputPasswordHash))
                    {
                        FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(1, txtUsername.Text, DateTime.Now, DateTime.Now.AddMinutes(10), false, txtUsername.Text);
                        String encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                        HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                        Response.Cookies.Add(authCookie);

                        Response.Redirect("~/AdminPanel/Default.aspx");
                    }
                    else
                    {
                        IncorrectInputLabel.Text = "Incorrect username/password";
                    }
                }
                else
                {
                    IncorrectInputLabel.Text = "Incorrect username/password";
                }
            }
            //else
            //{
            //    IncorrectInputLabel.Text = "Incorrect username/password";
            //}
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
    }
}