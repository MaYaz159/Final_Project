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

        // Method to validate email format
        private bool IsValidEmail(string email)
        {
            try
            {
                var mailAddress = new System.Net.Mail.MailAddress(email);
                return true;  // Valid email
            }
            catch
            {
                return false;  // Invalid email
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            string firstName = txtFirstName.Text;
            string lastName = txtLastName.Text;
            string email = txtEmail.Text;
            string message = txtMessage.Text;

            if (IsValidEmail(email))
            {

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

                            // JavaScript to show floating message
                            string script = "showFloatingMessage('Your message has been successfully sent!', 'success');";
                            ClientScript.RegisterStartupScript(this.GetType(), "FloatingMessage", script, true);

                            txtFirstName.Text = "";
                            txtLastName.Text = "";
                            txtEmail.Text = "";
                            txtMessage.Text = "";
                        }
                        catch (Exception ex)
                        {
                            string script = "showFloatingMessage('Error: " + ex.Message.Replace("'", "\\'") + "', 'error');";
                            ClientScript.RegisterStartupScript(this.GetType(), "FloatingMessage", script, true);
                        }
                        finally
                        {
                            // Ensure the connection is closed even if an exception occurs
                            conn.Close();
                        }
                    }
                }
            }

            else
            {
                lblemail.Text = "Please enter a valid email address.";
                lblemail.Visible = true;
                string script = "showFloatingMessage('Error: " + lblemail.Text.Replace("'", "\\'") + "', 'error');";
                ClientScript.RegisterStartupScript(this.GetType(), "FloatingMessage", script, true);
            }

        }

    }

}
