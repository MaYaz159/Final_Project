using System;
using System.Data.SqlClient;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.IO;
using System.Net.Http;
using System.Text;
using System.Security.Cryptography;
using System.Threading.Tasks;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using Microsoft.Owin.Security.Google;
using Microsoft.Owin.Security.Facebook;
using System.Security.Policy;
using System.Web.Security;

namespace PICKandCOOK
{
    public partial class LOGIN_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }

        private void LogError(string message)
        {
            try
            {
                string logPath = Server.MapPath("~/logs/Log2.txt");
                using (StreamWriter writer = new StreamWriter(logPath, true))
                {
                    writer.WriteLine($"{DateTime.Now}: {message}");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error :" + ex.Message);
            }
        }

        private static string HashPassword(string password)
        {
            using (var sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(bytes); // Use Base64 for efficient storage
            }
        }

        protected void btn1Submit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(TextBox1.Text) || string.IsNullOrEmpty(TextBox2.Text))
            {
                TextBox1.Text = "";
                TextBox2.Text = "";
                lblErrorMessage.Text = "Both Username and Password must be filled.";
                lblErrorMessage.Visible = true; // Show the error message label.
            }
            else
            {
                string username = TextBox1.Text;
                string pass = HashPassword(TextBox2.Text);

                string query = "SELECT * FROM Login WHERE username = @username AND password = @password"; // Use parameterized query to prevent SQL injection
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDatabaseConnectionString"].ConnectionString))
                {
                    SqlDataAdapter sda = new SqlDataAdapter(query, conn);
                    sda.SelectCommand.Parameters.AddWithValue("@username", username);
                    sda.SelectCommand.Parameters.AddWithValue("@password", pass);

                    DataTable dtable = new DataTable();
                    sda.Fill(dtable);

                    if (dtable.Rows.Count > 0)
                    {
                        Response.Redirect("HOME_page.aspx"); // Redirect to the home page or dashboard.
                    }
                    else
                    {
                        // Invalid credentials
                        TextBox1.Text = "";
                        TextBox2.Text = "";
                        lblErrorMessage.Text = "Invalid Username or Password. Please try again.";
                        lblErrorMessage.Visible = true; // Show the error message label.
                    }
                }
            }
        }

        protected void btn2Submit_Click(object sender, EventArgs e)
        {
            Response.Redirect("SIGNUP_page.aspx"); // Redirect to the sign_up page.
        }

    }
}



