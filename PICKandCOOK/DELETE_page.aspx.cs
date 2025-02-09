using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PICKandCOOK
{
    public partial class DELETE_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        SqlConnection conn = new SqlConnection(@"Server=DESKTOP-F2QBQRN\MSSQLSERVER01;Database=MyWebsite;Integrated Security=True;TRUSTSERVERCERTIFICATE=True;");

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            try
            {
                // Assuming you store the user's email or a unique identifier in the session
                if (Session["UserEmail"] != null)
                {
                    string userEmail = Session["UserEmail"].ToString();
                    DeleteUserAccount(userEmail);
                    lblStatus.Text = "Your account has been successfully deleted.";
                    // Optionally, clear the session and redirect to the home page
                    Session.Clear();
                    Response.Redirect("HOME_page.aspx");
                }
                else
                {
                    lblStatus.Text = "Error: Unable to identify the user account.";
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text = "An error occurred: " + ex.Message;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("HOME_page.aspx");
        }

        private void DeleteUserAccount(string email)
        {
            using (SqlCommand cmd = new SqlCommand("DELETE FROM Login WHERE email = @Email", conn))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
    }
}
