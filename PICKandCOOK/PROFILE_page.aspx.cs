using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            string query = "SELECT meal_plan_id, date_created FROM MealPlans WHERE username = @username";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["MyDatabaseConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
                conn.Open();
                rptMealPlans.DataSource = cmd.ExecuteReader();
                rptMealPlans.DataBind();
            }
        }

        protected void btnDeleteFav_Click(object sender, EventArgs e)
        {
            int recipeId = Convert.ToInt32(((System.Web.UI.WebControls.Button)sender).CommandArgument);
            string query = "DELETE FROM Favorites WHERE username = @username AND recipe_id = @recipeId";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["MyWebsiteDB"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
                cmd.Parameters.AddWithValue("@recipeId", recipeId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            LoadFavorites();
        }

        protected void btnDeletePlan_Click(object sender, EventArgs e)
        {
            int mealPlanId = Convert.ToInt32(((System.Web.UI.WebControls.Button)sender).CommandArgument);
            string query = "DELETE FROM MealPlans WHERE meal_plan_id = @mealPlanId AND username = @username";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["MyDatabaseConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
                cmd.Parameters.AddWithValue("@mealPlanId", mealPlanId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            LoadMealPlans();
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            Response.Redirect("ChangePassword.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("HOME.html");
        }

    }
}