using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace PICKandCOOK
{
    public partial class PLANNER_page : System.Web.UI.Page
    {
        // Database connection string
        private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyDatabaseConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set default images for Monday (fixed)
                imgBreakfast.ImageUrl = "~/Recipes/Pancakes.jpeg";
                imgLunch.ImageUrl = "~/Recipes/Beef Quesadilla.jpeg";
                imgDinner.ImageUrl = "~/Recipes/Kung Pao Chicken.jpeg";

                // Populate the dietary restrictions drop_down
                PopulateDietaryRestrictions();
            }
        }

        // Populate the Dietary Restrictions drop_down list
        private void PopulateDietaryRestrictions()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT DISTINCT restriction_title FROM DietaryRestrictions";
                SqlCommand command = new SqlCommand(query, connection);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                ddlDietaryRestrictions.Items.Clear();
                ddlDietaryRestrictions.Items.Add(new ListItem("Select Dietary Restriction", ""));

                while (reader.Read())
                {
                    string restriction = reader.GetString(0);
                    ddlDietaryRestrictions.Items.Add(new ListItem(restriction, restriction));
                }

                reader.Close();
            }
        }

        // Fetch recipes by meal type and dietary restriction
        private List<Recipe> GetRecipesByMealTypeAndRestriction(int mealTypeId, string dietaryRestriction)
        {
            List<Recipe> recipes = new List<Recipe>();
            string query = "SELECT r.recipe_id, r.title FROM Recipes r " +
                           "JOIN MealTypes mt ON r.meal_type_id = mt.meal_type_id " +
                           "LEFT JOIN DietaryRestrictions dr ON r.recipe_id = dr.recipe_id " +
                           "WHERE r.meal_type_id = @MealTypeId ";

            // Add dietary restriction filter if one is provided
            if (!string.IsNullOrEmpty(dietaryRestriction))
            {
                query += "AND dr.restriction_title = @RestrictionTitle";
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@MealTypeId", mealTypeId);

                if (!string.IsNullOrEmpty(dietaryRestriction))
                {
                    command.Parameters.AddWithValue("@RestrictionTitle", dietaryRestriction);
                }

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    recipes.Add(new Recipe
                    {
                        RecipeID = reader.GetInt32(0),
                        RecipeName = reader.GetString(1)
                    });
                }

                reader.Close();
            }

            return recipes;
        }

        // When the user selects a dietary restriction and clicks on the button
        protected void Button1_Click(object sender, EventArgs e)
        {
            string username = Session["Username"] as string;

            if (username != null)
            {

                string selectedRestriction = ddlDietaryRestrictions.SelectedValue;

                if (!string.IsNullOrEmpty(selectedRestriction))
                {
                    // Fetch recipes based on selected restriction
                    int breakfastId = 1; // Example breakfast meal type ID
                    int lunchId = 2;     // Example lunch meal type ID
                    int dinnerId = 3;    // Example dinner meal type ID

                    // Dynamically fetch recipes for Tuesday to Sunday based on dietary restriction
                    List<Recipe> breakfastRecipes = GetRecipesByMealTypeAndRestriction(breakfastId, selectedRestriction);
                    List<Recipe> lunchRecipes = GetRecipesByMealTypeAndRestriction(lunchId, selectedRestriction);
                    List<Recipe> dinnerRecipes = GetRecipesByMealTypeAndRestriction(dinnerId, selectedRestriction);

                    // Create meal plan data for each day of the week
                    var days = new List<DayMeal>
                    {

                        new DayMeal { Day = "Monday", BreakfastRecipes = breakfastRecipes, LunchRecipes = lunchRecipes, DinnerRecipes = dinnerRecipes },
                        new DayMeal { Day = "Tuesday", BreakfastRecipes = breakfastRecipes, LunchRecipes = lunchRecipes, DinnerRecipes = dinnerRecipes },
                        new DayMeal { Day = "Wednesday", BreakfastRecipes = breakfastRecipes, LunchRecipes = lunchRecipes, DinnerRecipes = dinnerRecipes },
                        new DayMeal { Day = "Thursday", BreakfastRecipes = breakfastRecipes, LunchRecipes = lunchRecipes, DinnerRecipes = dinnerRecipes },
                        new DayMeal { Day = "Friday", BreakfastRecipes = breakfastRecipes, LunchRecipes = lunchRecipes, DinnerRecipes = dinnerRecipes },
                        new DayMeal { Day = "Saturday", BreakfastRecipes = breakfastRecipes, LunchRecipes = lunchRecipes, DinnerRecipes = dinnerRecipes },
                        new DayMeal { Day = "Sunday", BreakfastRecipes = breakfastRecipes, LunchRecipes = lunchRecipes, DinnerRecipes = dinnerRecipes }

                    };

                    // Bind the meal plan data to the Repeater control
                    mealRepeater.DataSource = days;
                    mealRepeater.DataBind();

                    ScriptManager.RegisterStartupScript(this, GetType(), "scrollToShop2", "scrollToShop2();", true);

                }
                else
                {
                    string message = "Please select a dietary restriction!";
                    string script = "showFloatingMessage('Error: " + message.Replace("'", "\\'") + "', 'error');";
                    ClientScript.RegisterStartupScript(this.GetType(), "FloatingMessage", script, true);
                    btn.PostBackUrl = "~/PLANNER_page.aspx#planner1";
                }

            }

            else
            {
                string message = "need to LOGIN or SIGNUP first!!";
                string script = "showFloatingMessage('You " + message.Replace("'", "\\'") + "', 'error');";
                ClientScript.RegisterStartupScript(this.GetType(), "FloatingMessage", script, true);
                btnSave.PostBackUrl = "~/PLANNER_page.aspx#planner1";
            }

        }

        // Helper classes for meal planning
        public class Recipe
        {
            public int RecipeID { get; set; }
            public string RecipeName { get; set; }
        }

        public class DayMeal
        {
            public string Day { get; set; }
            public List<Recipe> BreakfastRecipes { get; set; }
            public List<Recipe> LunchRecipes { get; set; }
            public List<Recipe> DinnerRecipes { get; set; }
        }

        // Save meal plan selections
        protected void SaveMealPlan(object sender, EventArgs e)
        {
            string dietaryRestriction = ddlDietaryRestrictions.SelectedValue;

            foreach (RepeaterItem item in mealRepeater.Items)
            {
                var ddlBreakfast = (DropDownList)item.FindControl("ddlBreakfast");
                var ddlLunch = (DropDownList)item.FindControl("ddlLunch");
                var ddlDinner = (DropDownList)item.FindControl("ddlDinner");

                string breakfastRecipe = ddlBreakfast.SelectedValue;
                string lunchRecipe = ddlLunch.SelectedValue;
                string dinnerRecipe = ddlDinner.SelectedValue;

                SaveMealPlanToDatabase(breakfastRecipe, lunchRecipe, dinnerRecipe, dietaryRestriction);
            }

            SaveNbrMealPlanToDatabase();

            string message = "Meal plan saved successfully!!";
            string script = "showFloatingMessage('Your " + message.Replace("'", "\\'") + "', 'success');";
            ClientScript.RegisterStartupScript(this.GetType(), "FloatingMessage", script, true);
            btnSave.PostBackUrl = "~/PLANNER_page.aspx#planner1";

        }

        private void SaveMealPlanToDatabase(string breakfastRecipe, string lunchRecipe, string dinnerRecipe, string dietaryRestrictions)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO MealPlans (username, breakfast_recipe_id, lunch_recipe_id, dinner_recipe_id, dietary_restrictions) " +
                               "VALUES (@username, @BreakfastRecipeID, @LunchRecipeID, @DinnerRecipeID, @DietaryRestrictions)";

                string username = Session["Username"] as string;
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@username", username);
                command.Parameters.AddWithValue("@BreakfastRecipeID", breakfastRecipe);
                command.Parameters.AddWithValue("@LunchRecipeID", lunchRecipe);
                command.Parameters.AddWithValue("@DinnerRecipeID", dinnerRecipe);
                command.Parameters.AddWithValue("@DietaryRestrictions", dietaryRestrictions);

                connection.Open();
                if (username != null)
                {
                    command.ExecuteNonQuery();
                }
                else
                {
                    string message = "need to LOGIN or SIGNUP first!!";
                    string script = "showFloatingMessage('You " + message.Replace("'", "\\'") + "', 'error');";
                    ClientScript.RegisterStartupScript(this.GetType(), "FloatingMessage", script, true);
                    btnSave.PostBackUrl = "~/PLANNER_page.aspx#planner1";
                }

            }

        }

        private void SaveNbrMealPlanToDatabase()
        {

            string username = Session["Username"] as string;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Insert into NbrofMealPlans to track the number of meal plans for the user
                string insertUserQuery = "INSERT INTO NbrofMealPlans (username) VALUES (@username)";
                using (SqlCommand insertUserCommand = new SqlCommand(insertUserQuery, connection))
                {

                    insertUserCommand.Parameters.AddWithValue("@username", username);
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }

                    if (username != null)
                    {
                        insertUserCommand.ExecuteNonQuery();
                    }
                    else
                    {
                        string message = "need to LOGIN or SIGNUP first!!";
                        string script = "showFloatingMessage('You " + message.Replace("'", "\\'") + "', 'error');";
                        ClientScript.RegisterStartupScript(this.GetType(), "FloatingMessage", script, true);
                        btnSave.PostBackUrl = "~/PLANNER_page.aspx#planner1";
                    }

                }

            }

        }

    }
}
