using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PICKandCOOK
{
    public partial class CONTACT_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text;
            string lastName = txtLastName.Text;
            string email = txtEmail.Text;
            string message = txtMessage.Text;

            // Retrieve the connection string from web.config
            string connectionString = ConfigurationManager.ConnectionStrings["MyDatabaseConnectionString"].ConnectionString;

            // SQL query to insert data into the Messages table
            string query = "INSERT INTO Messages (firstName, lastName, email, message) VALUES (@FirstName, @LastName, @Email, @Message)";

            // Use a SqlConnection and SqlCommand to execute the query
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Add parameters to prevent SQL injection
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
                    cmd.Parameters.AddWithValue("@LastName", lastName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Message", message);

                    try
                    {
                        // Open the connection and execute the query
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        Response.Write("<div class='message'>Your message has been successfully sent!");
                        Visible = true;
                        txtFirstName.Text = "";
                        txtLastName.Text = "";
                        txtEmail.Text = "";
                        txtMessage.Text = "";
                    }
                    catch (Exception ex)
                    {
                        // Handle errors (e.g., log them)
                        Response.Write("<div class='message'>Error: " + ex.Message);
                        Visible = true;
                    }
                    finally
                    {
                        // Ensure the connection is closed even if an exception occurs
                        conn.Close();
                    }
                }
            }
        }

    }

}
