using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PICKandCOOK
{
    public partial class RECIPES_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)  // Ensure the drop_down is only populated on the first page load
            {
                BindMealTypes();
                BindCuisineName();
            }
        }

        private void LogError(string message)
        {
            try
            {
                string logPath = Server.MapPath("~/logs/Log4.txt");
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

        //SqlConnection conn = new SqlConnection(@"desktop-2kv1u92\sqlexpress.Yessir.dbo");
        SqlConnection conn = new SqlConnection(@"Server=DESKTOP-F2QBQRN\MSSQLSERVER01;Database=MyWebsite;Integrated Security=True;TRUSTSERVERCERTIFICATE=True;");

        private void BindMealTypes()
        {
            string connectionString = "Server=DESKTOP-F2QBQRN\\MSSQLSERVER01;Database=MyWebsite;Integrated Security=True;TRUSTSERVERCERTIFICATE=True;";
            string query = "SELECT DISTINCT meal_type_name FROM TablesTogether";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Clear any existing items in the DropDownList to ensure it's reset
                DropDownList1.Items.Clear();

                // Bind the data from the database to the DropDownList
                DropDownList1.DataSource = dt;
                DropDownList1.DataTextField = "meal_type_name";  // Column to display in the drop_down
                DropDownList1.DataValueField = "meal_type_name"; // Column to use as value
                DropDownList1.DataBind();

                // Add the default "Select Meal Type" item as the first item
                DropDownList1.Items.Insert(0, new ListItem("Select Meal Type", ""));

            }

        }

        private void BindCuisineName()
        {
            string connectionString = "Server=DESKTOP-F2QBQRN\\MSSQLSERVER01;Database=MyWebsite;Integrated Security=True;TRUSTSERVERCERTIFICATE=True;";
            string query = "SELECT DISTINCT cuisine_name FROM TablesTogether";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Clear any existing items in the DropDownList to ensure it's reset
                DropDownList2.Items.Clear();

                // Bind the data from the database to the DropDownList
                DropDownList2.DataSource = dt;
                DropDownList2.DataTextField = "cuisine_name";  // Column to display in the drop_down
                DropDownList2.DataValueField = "cuisine_name"; // Column to use as value
                DropDownList2.DataBind();

                // Add the default "Select Cuisine Name" item as the first item
                DropDownList2.Items.Insert(0, new ListItem("Select Cuisine Name", ""));

            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string selectedTitle1 = DropDownList1.SelectedValue?.Trim(); // Meal type
            string selectedTitle2 = DropDownList2.SelectedValue?.Trim(); // Cuisine
            string connectionString = ConfigurationManager.ConnectionStrings["MyDatabaseConnectionString"].ConnectionString;

            // Ensure at least one drop_down is selected
            if (string.IsNullOrEmpty(selectedTitle1) && string.IsNullOrEmpty(selectedTitle2))
            {
                TextBox1.Text = "⭐ You need to choose either a meal type, a cuisine, or both.";
                return;
            }

            string query = "SELECT DISTINCT title, instructions, cooking_time, servings, nutrition_info, image_url FROM TablesTogether WHERE ";
            List<SqlParameter> parameters = new List<SqlParameter>();

            if (!string.IsNullOrEmpty(selectedTitle1) && !string.IsNullOrEmpty(selectedTitle2))
            {
                query += "meal_type_name = @SelectedTitle1 AND cuisine_name = @SelectedTitle2";
                parameters.Add(new SqlParameter("@SelectedTitle1", SqlDbType.NVarChar) { Value = selectedTitle1 });
                parameters.Add(new SqlParameter("@SelectedTitle2", SqlDbType.NVarChar) { Value = selectedTitle2 });
            }
            else if (!string.IsNullOrEmpty(selectedTitle1))
            {
                query += "meal_type_name = @SelectedTitle1";
                parameters.Add(new SqlParameter("@SelectedTitle1", SqlDbType.NVarChar) { Value = selectedTitle1 });
            }
            else
            {
                query += "cuisine_name = @SelectedTitle2";
                parameters.Add(new SqlParameter("@SelectedTitle2", SqlDbType.NVarChar) { Value = selectedTitle2 });
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddRange(parameters.ToArray());
                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {

                    StringBuilder resultText = new StringBuilder();

                    // Loop through all rows in the reader
                    while (reader.Read()) // Reads each row until no more rows exist
                    {

                        resultText.AppendLine($"⭐ Title: {reader["title"]}");
                        resultText.AppendLine($"Instructions: {reader["instructions"]}");
                        resultText.AppendLine($"Cooking Time: {reader["cooking_time"]} minutes");
                        resultText.AppendLine($"Servings: {reader["servings"]}");
                        resultText.AppendLine($"Nutrition Info: {reader["nutrition_info"]}");

                        resultText.AppendLine(); // Adds an empty line between records

                    }

                    // If no rows were found, display this message
                    if (resultText.Length == 0)
                    {
                        resultText.AppendLine("No data found.");
                    }

                    // Set the TextBox text to the result of all rows
                    TextBox1.Text = resultText.ToString();

                }

            }

            DropDownList1.SelectedIndex = 0;
            DropDownList2.SelectedIndex = 0;

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // You can add any additional logic here if needed.
            // For example, clear the TextBox when a new option is selected.
            TextBox1.Text = string.Empty;
        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Clear TextBox when DropDownList2 selection changes
            TextBox1.Text = string.Empty;
        }

    }

}
