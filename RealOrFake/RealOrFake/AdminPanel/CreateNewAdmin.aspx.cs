using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace RealOrFake.AdminPanel
{
    public partial class CreateNewAdmin : System.Web.UI.Page
    {
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["FileDatabaseConnectionString1"].ConnectionString);

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            //Retrieve SALT from database
            string dbSalt = "";

            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["FileDatabaseConnectionString1"].ConnectionString);
            connection.Open();
            SqlCommand myCommand = new SqlCommand("SELECT Salt FROM Admin", connection);
            //myCommand.Parameters.AddWithValue("@AdminUsername", TextBox1.Text);

            SqlDataReader myReader = myCommand.ExecuteReader();
            while (myReader.Read())
            {
                dbSalt = (myReader["Salt"].ToString());
            }
            connection.Close();

            dbSalt = ValidateBase64EncodedString(dbSalt);

            string inputPasswordHash = ComputeHash(TextBox2.Text, new SHA512CryptoServiceProvider(), Convert.FromBase64String(dbSalt));
            
            //Insert into database
            connection.Open();
            SqlCommand insertAdminDetailsCommand = new SqlCommand();
            insertAdminDetailsCommand.CommandText = "INSERT INTO Admin (AdminUserName, AdminPassword)" +
                " VALUES (@AdminUserName, @AdminPassword)";
            insertAdminDetailsCommand.Parameters.AddWithValue("@AdminUserName", TextBox1.Text);
            insertAdminDetailsCommand.Parameters.AddWithValue("@AdminPassword", inputPasswordHash);

            insertAdminDetailsCommand.Connection = connection;
            insertAdminDetailsCommand.ExecuteNonQuery();
            connection.Close();
            
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Admin has been added successfully.');", true);
        }


        protected void resetBtn_Click(object sender, EventArgs e)
        {
            TextBox1.Text = String.Empty;
            TextBox2.Text = String.Empty;
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