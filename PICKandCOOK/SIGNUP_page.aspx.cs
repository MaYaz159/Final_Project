using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using Newtonsoft.Json;
using System.Configuration;
using System.Net.Http;
using System.Net;
using System.Threading.Tasks;
using System.IO;

namespace PICKandCOOK
{
    public partial class SIGNUP_page : System.Web.UI.Page
    {
        protected string googleplus_client_id = ConfigurationManager.AppSettings["GoogleClientID"];
        protected string googleplus_client_secret = ConfigurationManager.AppSettings["GoogleClientSecret"];
        protected string googleplus_redirect_url = ConfigurationManager.AppSettings["GoogleRedirectURL"];

        public class GooglePlusAccessToken
        {
            public string access_token { get; set; }
            public string token_type { get; set; }
            public int expires_in { get; set; }
            public string id_token { get; set; }
            public string refresh_token { get; set; }

        }

        public class GooglePlusUserData
        {
            public string id { get; set; }
            public string email { get; set; }

            public string password = Guid.NewGuid().ToString().Substring(0, 4);
            public string verified_email { get; set; }
            public string picture { get; set; }
            public string given_name { get; set; }
            public string family_name { get; set; }
            public string locale { get; set; }

        }

        protected async void Page_Load(object sender, EventArgs e)
        {
            if (Session["loginWith"] != null && Session["loginWith"].ToString() == "google")
            {
                await HandleGoogleResponse();
            }
        }

        private async Task HandleGoogleResponse()
        {
            try
            {
                // Check if the OAuth response was already handled
                if (Session["OAuthHandled"] != null && (bool)Session["OAuthHandled"])
                {
                    LogError("OAuth response already handled, skipping.");
                    return;
                }

                var url = Request.Url.Query;
                LogError($"Query URL: {url}");

                string code = HttpUtility.ParseQueryString(Request.Url.Query).Get("code");
                LogError($"Code URL: {code}");

                string error = HttpUtility.ParseQueryString(Request.Url.Query).Get("error");
                if (!string.IsNullOrEmpty(error))
                {
                    LogError($"OAuth Error: {error}");
                    Response.Redirect("SIGNUP_page.aspx?error=" + HttpUtility.UrlEncode(error));
                    return;
                }

                if (!string.IsNullOrEmpty(code))
                {
                    using (var client = new HttpClient())
                    {
                        var requestContent = new StringContent(
                            $"code={code}&client_id={googleplus_client_id}&client_secret={googleplus_client_secret}&redirect_uri={googleplus_redirect_url}&grant_type=authorization_code",
                            Encoding.UTF8,
                            "application/x-www-form-urlencoded"
                        );
                        var response = await client.PostAsync("https://accounts.google.com/o/oauth2/token", requestContent);
                        LogError($"Response Status Code: {response.StatusCode}");

                        if (!response.IsSuccessStatusCode)
                        {
                            string errorResponse = await response.Content.ReadAsStringAsync();
                            LogError($"Token request failed with status code {response.StatusCode}. Response: {errorResponse}");
                            Response.Redirect("SIGNUP_page.aspx?error=token_request_failed");
                            return;
                        }

                        string responseBody = await response.Content.ReadAsStringAsync();
                        GooglePlusAccessToken accessTokenData = JsonConvert.DeserializeObject<GooglePlusAccessToken>(responseBody);

                        if (accessTokenData != null)
                        {
                            string accessToken = accessTokenData.access_token;
                            if (!string.IsNullOrEmpty(accessToken))
                            {
                                using (var client2 = new HttpClient())
                                {
                                    var response2 = await client2.GetAsync($"https://www.googleapis.com/userinfo/v2/me?access_token={accessToken}");
                                    if (!response2.IsSuccessStatusCode)
                                    {
                                        LogError($"User info request failed with status code {response2.StatusCode}");
                                        Response.Redirect("SIGNUP_page.aspx?error=userinfo_request_failed");
                                        return;
                                    }

                                    string responseBody2 = await response2.Content.ReadAsStringAsync();
                                    GooglePlusUserData userData = JsonConvert.DeserializeObject<GooglePlusUserData>(responseBody2);

                                    if (userData != null)
                                    {
                                        // Store user data in session
                                        Session["User Email"] = userData.email;
                                        Session["User Picture"] = userData.picture;

                                        Session["GeneratedPassword"] = userData.password;

                                        LogError($"Generated Password : {Session["GeneratedPassword"]}"); // Log the generated password

                                        string pass = Session["GeneratedPassword"].ToString();

                                        LogError($"Password : {pass}"); // Log the password

                                        string email = Session["User Email"].ToString();
                                        string pictureUrl = Session["User Picture"]?.ToString();
                                       
                                        // Convert the image URL to byte array if it's not null or empty
                                        byte[] imageBytes = null;
                                        if (!string.IsNullOrEmpty(pictureUrl))
                                        {
                                            using (WebClient client3 = new WebClient())
                                            {
                                                imageBytes = client3.DownloadData(pictureUrl);  // Download the image as a byte array
                                            }
                                        }

                                        // Insert user data into the database
                                        InsertUserIntoDatabase(email, imageBytes, pass);

                                        // Mark OAuth as handled and redirect to HOME_page
                                        Session["OAuthHandled"] = true;

                                        // Redirect to LOGIN_page with username and password as query parameters
                                        Response.Redirect("HOME_page.aspx");
                                        return;
                                    }
                                    else
                                    {
                                        LogError("Failed to deserialize Google Plus User Data");
                                    }
                                }
                            }
                            else
                            {
                                LogError("Access token is null or empty");
                            }
                        }
                        else
                        {
                            LogError("Failed to deserialize Google Plus Access Token");
                        }
                    }
                }
                else
                {
                    LogError("No 'code' received in the query parameters.");
                    Response.Redirect("SIGNUP_page.aspx?error=missing_code");
                }
            }
            catch (Exception ex)
            {
                LogError($"Unhandled exception: {ex.Message}");
                Response.Redirect("SIGNUP_page.aspx?error=unhandled_exception");
            }
        }

        private void InsertUserIntoDatabase(string email, byte[] imageBytes, string password)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDatabaseConnectionString"].ConnectionString))
                {
                    conn.Open();

                    // Check if the user already exists
                    string checkUserQuery = "SELECT COUNT(*) FROM Login WHERE username = @username";
                    using (SqlCommand cmd = new SqlCommand(checkUserQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@username", email);
                        int userCount = (int)cmd.ExecuteScalar();

                        if (userCount == 0)
                        {
                            // Insert new user
                            string insertQuery = "INSERT INTO Login (username, password, Profile_Picture) VALUES (@username, @password, @Profile_Picture)";
                            using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                            {
                                insertCmd.Parameters.AddWithValue("@username", email);
                                insertCmd.Parameters.AddWithValue("@password", HashPassword(password));
                                insertCmd.Parameters.AddWithValue("@Profile_Picture", imageBytes ?? (object)DBNull.Value); // Store byte[] directly
                                insertCmd.ExecuteNonQuery();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions (e.g., log the error)
                LogError($"Database operation failed: {ex.Message}");
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
                pass = HashPassword(TextBox2.Text);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                // Check if the user already exists
                string checkUserQuery = "SELECT COUNT(*) FROM Login WHERE username = @username";

                using (SqlCommand cmd = new SqlCommand(checkUserQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@username", username);
                    int userCount = (int)cmd.ExecuteScalar();

                    if (userCount == 0)
                    {
                        // Insert query
                        string query = "INSERT INTO Login (username, password) VALUES (@username, @password)";
                        using (SqlCommand sda = new SqlCommand(query, conn))
                        {
                            // Add parameters to prevent SQL injection
                            sda.Parameters.AddWithValue("@username", username);
                            sda.Parameters.AddWithValue("@password", pass);

                            // Insert new user
                            // Execute the query
                            int rowsAffected = sda.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {
                                Response.Redirect("LOGIN_page.aspx"); // Redirect to the login page or dashboard.
                            }
                        }
                    }

                    else
                    {
                        // Invalid credentials
                        TextBox1.Text = "";
                        TextBox2.Text = "";

                        lblErrorMessage.Text = "Username already used. Please try a different one.";
                        lblErrorMessage.Visible = true; // Show the error message label.
                    }
                }
            }
        }

        private void LogError(string message)
        {
            try
            {
                string logPath = Server.MapPath("~/logs/Log1.txt");
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

        protected void btn2Submit_Click(object sender, EventArgs e)
        {
            var GoogleUrl = "https://accounts.google.com/o/oauth2/auth?" +
                            "response_type=code" +
                            "&redirect_uri=" + HttpUtility.UrlEncode("https://localhost:44381/SIGNUP_page.aspx") +
                            "&scope=" + HttpUtility.UrlEncode("https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile") +
                            "&client_id=" + googleplus_client_id;
            Session["loginWith"] = "google";
            Response.Redirect(GoogleUrl);
        }

        protected void btn3Submit_Click(object sender, EventArgs e)
        {
            Response.Redirect("https://www.facebook.com/");
        }

    }
}
