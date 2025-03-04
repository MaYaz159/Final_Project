using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace PICKandCOOK
{
    public partial class FAVORITES_page : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                LoadRecipes();
            }

        }

        private void LoadRecipes()
        {

            // Retrieve the connection string from web.config
            string connectionString = ConfigurationManager.ConnectionStrings["MyDatabaseConnectionString"].ConnectionString;

            string query = "SELECT DISTINCT title, image_url, meal_type_name, cuisine_name, recipe_id FROM TablesTogether";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                RecipeGridView.DataSource = dt;
                RecipeGridView.DataBind();
            }

        }

        protected void AddToFavorites_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            int recipeId = Convert.ToInt32(RecipeGridView.DataKeys[row.RowIndex].Value);

            string username = Session["Username"] as string;

            if (username != null)
            {
                // Retrieve the connection string from web.config
                string connectionString = ConfigurationManager.ConnectionStrings["MyDatabaseConnectionString"].ConnectionString;

                // Query to check if the recipe is already in favorites
                string checkQuery = "SELECT COUNT(*) FROM Favorites WHERE username = @username AND recipe_id = @recipeId";
                // Query to insert into favorites
                string insertQuery = "INSERT INTO Favorites (username, recipe_id) VALUES (@username, @recipeId)";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Check if the recipe is already in favorites
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@username", username);
                        checkCmd.Parameters.AddWithValue("@recipeId", recipeId);

                        int count = Convert.ToInt32(checkCmd.ExecuteScalar());
                        if (count > 0)
                        {
                            // Recipe already in favorites
                            string message = "is already in your favorites!";
                            string script = "showFloatingMessage('Recipe " + message.Replace("'", "\\'") + "', 'info');";
                            ClientScript.RegisterStartupScript(this.GetType(), "FloatingMessage", script, true);
                            return;
                        }
                    }

                    // Insert into favorites if not already there
                    using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                    {
                        insertCmd.Parameters.AddWithValue("@username", username);
                        insertCmd.Parameters.AddWithValue("@recipeId", recipeId);
                        insertCmd.ExecuteNonQuery();
                    }
                }

                string successMessage = "added to favorites!";
                string successScript = "showFloatingMessage('Recipe " + successMessage.Replace("'", "\\'") + "', 'success');";
                ClientScript.RegisterStartupScript(this.GetType(), "FloatingMessage", successScript, true);

            }
            else
            {
                // User is not logged in
                string message = "need to LOGIN or SIGNUP first!!";
                string script = "showFloatingMessage('You " + message.Replace("'", "\\'") + "', 'error');";
                ClientScript.RegisterStartupScript(this.GetType(), "FloatingMessage", script, true);
            }

        }

    }
}

