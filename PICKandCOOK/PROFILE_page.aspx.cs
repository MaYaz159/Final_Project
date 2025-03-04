using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace PICKandCOOK
{
    public partial class PROFILE_page : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("LOGIN_page.aspx");
            }
            else
            {

                lblUsername.Text = Session["username"].ToString();
                if (Session["GeneratedPassword"] != null && Session["User Email"] == Session["username"])
                {
                    lblPassword.Text = Session["GeneratedPassword"].ToString();
                }
                else
                {
                    lblPassword.Text = Session["password"].ToString();
                }
                LoadUserPictureFromDatabase();
                
                LoadFavorites();
                LoadMealPlans();

            }
        }

        private void LoadUserPictureFromDatabase()
        {
            string query = "SELECT Profile_Picture FROM Login WHERE username = @username";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["MyDatabaseConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
                conn.Open();

                object profilePicture = cmd.ExecuteScalar();

                if (profilePicture != DBNull.Value && profilePicture != null)
                {
                    byte[] imageBytes = (byte[])profilePicture;
                    Session["User Picture"] = imageBytes; // Store in session for faster access
                    imgProfile.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(imageBytes);
                }
                else
                {
                    // Set default local image if no image is found
                    imgProfile.ImageUrl = "img/default-profile.png";
                }
            }
        }

        private void LoadFavorites()
        {
            string query = "SELECT f.recipe_id, r.title FROM Favorites f INNER JOIN Recipes r ON f.recipe_id = r.recipe_id WHERE f.username = @username";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["MyDatabaseConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
                conn.Open();
                rptFavorites.DataSource = cmd.ExecuteReader();
                rptFavorites.DataBind();
            }
        }

        private void LoadMealPlans()
        {
            string query = "SELECT week_number, week_day, recipe_name FROM AllTables WHERE username = @username;";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["MyDatabaseConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.Add("@username", SqlDbType.NVarChar).Value = Session["username"].ToString();

                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    // Create a DataTable and load the data
                    DataTable dt = new DataTable();
                    dt.Load(reader);

                    // Group by week_number, making sure each week has unique days
                    var weeks = dt.AsEnumerable()
                                  .GroupBy(r => r["week_number"])
                                  .Select(g => new
                                  {
                                      WeekNumber = g.Key,
                                      // Select unique days for each week, avoiding duplicates
                                      Days = g.GroupBy(d => d["week_day"]) // Ensure we only select unique days
                                              .Select(d => new
                                              {
                                                  WeekDay = d.Key,
                                                  RecipeName = d.FirstOrDefault()?["recipe_name"]
                                              }).ToList()
                                  }).ToList();

                    // Bind the grouped data to the Repeater
                    rptMealPlans.DataSource = weeks;
                    rptMealPlans.DataBind();
                }
            }
        }

        protected void btnDeleteFav_Click(object sender, EventArgs e)
        {
            // Get the CommandArgument which is the recipe_id
            int recipeId = Convert.ToInt32(((System.Web.UI.WebControls.Button)sender).CommandArgument);

            // Prepare the delete query
            string query = "DELETE FROM Favorites WHERE username = @username AND recipe_id = @recipeId";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["MyDatabaseConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                // Add parameters for username and recipeId
                cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
                cmd.Parameters.AddWithValue("@recipeId", recipeId);

                conn.Open();
                cmd.ExecuteNonQuery();  // Execute the delete query
            }

            // Reload the favorites list
            LoadFavorites();
        }

        protected void btnDeletePlan_Click(object sender, EventArgs e)
        {
            // Get the week_number from the CommandArgument
            int weekNumber = Convert.ToInt32(((System.Web.UI.WebControls.Button)sender).CommandArgument);

            // Write the delete query to delete the corresponding meal plan
            string query = "DELETE FROM MealPlans WHERE username = @username AND meal_plan_id IN (SELECT meal_plan_id FROM AllTables WHERE week_number = @weekNumber)";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["MyDatabaseConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                // Add parameters for username and weekNumber
                cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
                cmd.Parameters.AddWithValue("@weekNumber", weekNumber);

                conn.Open();
                cmd.ExecuteNonQuery();  // Execute the delete query
            }

            // Reload the meal plans to reflect the deletion
            LoadMealPlans();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("HOME.html");
        }

    }
}