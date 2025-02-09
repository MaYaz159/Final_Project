using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PICKandCOOK
{
    public partial class SIGNUP_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //SqlConnection conn = new SqlConnection(@"desktop-2kv1u92\sqlexpress.Yessir.dbo");
        SqlConnection conn = new SqlConnection(@"Server=DESKTOP-F2QBQRN\MSSQLSERVER01;Database=MyWebsite;Integrated Security=True;TRUSTSERVERCERTIFICATE=True;");

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
                String username, pass;

                username = TextBox1.Text;
                pass = TextBox2.Text;

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                // Insert query
                string query = "INSERT INTO Login (username, password) VALUES (@username, @password)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Add parameters to prevent SQL injection
                    cmd.Parameters.AddWithValue("@username", username);
                    cmd.Parameters.AddWithValue("@password", pass);

                    // Execute the query
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        Response.Redirect("LOGIN_page.aspx"); // Redirect to the login page or dashboard.
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
            String username, pass;

            username = TextBox1.Text;
            pass = TextBox2.Text;


        }

        protected void btn3Submit_Click(object sender, EventArgs e)
        {
            String username, pass;

            username = TextBox1.Text;
            pass = TextBox2.Text;


        }

    }

}
