using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Text;
using Microsoft.Owin.Security.Google;
using Microsoft.Owin.Security.Facebook;

namespace PICKandCOOK
{

    public partial class HOME_page : System.Web.UI.Page
    {

        protected string googleplus_client_id = "211479189020-u437rpi3t79pd7pvoagfv0boqd78o3af.apps.googleusercontent.com";  // Replace this with your Client ID.
        protected string googleplus_client_secret = "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";  // Replace this with your Client Secret.
        protected string googleplus_redirect_url = "https://localhost:44381/HOME_page.aspx";  // Replace this with your Redirect URL; Your Redirect URL from your developer.google application should match this URL.
        protected string Parameters;

        // Google
        public class GooglePlusAccessToken
        {
            public string access_token { get; set; }
            public string token_type { get; set; }
            public int expires_in { get; set; }
            public string id_token { get; set; }
            public string refresh_token { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if ((Session.Contents.Count > 0) && (Session["loginWith"] != null) && (Session["loginWith"].ToString() == "google"))
            {
                try
                {
                    var url = Request.Url.Query;
                    if (url != "")
                    {
                        string queryString = url.ToString();
                        char[] delimiterChars = { '=' };
                        string[] words = queryString.Split(delimiterChars);
                        string code = words[1];

                        if (code != null)
                        {
                            //get the access token 
                            HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create("https://accounts.google.com/o/oauth2/token");
                            webRequest.Method = "POST";
                            Parameters = "code=" + code + "&client_id=" + googleplus_client_id + "&client_secret=" + googleplus_client_secret + "&redirect_uri=" + googleplus_redirect_url + "&grant_type=authorization_code";
                            byte[] byteArray = Encoding.UTF8.GetBytes(Parameters);
                            webRequest.ContentType = "application/x-www-form-urlencoded";
                            webRequest.ContentLength = byteArray.Length;
                            Stream postStream = webRequest.GetRequestStream();
                            // Add the post data to the web request
                            postStream.Write(byteArray, 0, byteArray.Length);
                            postStream.Close();

                            WebResponse response = webRequest.GetResponse();
                            postStream = response.GetResponseStream();
                            StreamReader reader = new StreamReader(postStream);
                            string responseFromServer = reader.ReadToEnd();

                            GooglePlusAccessToken serStatus = JsonConvert.DeserializeObject<GooglePlusAccessToken>(responseFromServer);

                            if (serStatus != null)
                            {
                                string accessToken = string.Empty;
                                accessToken = serStatus.access_token;

                                if (!string.IsNullOrEmpty(accessToken))
                                {
                                    // This is where you want to add the code if login is successful.
                                    // getgoogleplususerdataSer(accessToken);
                                }
                            }

                        }
                    }
                }
                catch (Exception ex)
                {
                    //throw new Exception(ex.Message, ex);
                    Response.Redirect("HOME_page.html");
                }
            }

            if (!IsPostBack)
            {
                string code = Request.QueryString["code"];
                if (!string.IsNullOrEmpty(code))
                {
                    // Exchange code for access token
                    string appId = "642382241696796"; // Your Facebook App ID
                    string appSecret = "cd418b88499fa4337ae8c2f2258ad863"; // Your Facebook App Secret
                    string redirectUri = "https://localhost:44381/LOGIN_page.aspx"; // Your redirect URL

                    string tokenUrl = $"https://graph.facebook.com/v12.0/oauth/access_token?client_id={appId}&redirect_uri={HttpUtility.UrlEncode(redirectUri)}&client_secret={appSecret}&code={code}";

                    using (WebClient client = new WebClient())
                    {
                        string json = client.DownloadString(tokenUrl);
                        dynamic tokenData = JsonConvert.DeserializeObject(json);
                        string accessToken = tokenData.access_token;

                        // Use the access token to get user info
                        var fbClient = new Facebook.FacebookClient(accessToken);
                        dynamic me = fbClient.Get("me?fields=id,name,email");
                        string userId = me.id;
                        string userName = me.name;
                        string userEmail = me.email;

                        // Now you can use the user information as needed
                        // For example, store it in session or display it
                        Session["User Id"] = userId;
                        Session["User Name"] = userName;
                        Session["User Email"] = userEmail;

                        // Redirect to a welcome page or display user info
                        Response.Redirect("HOME_page.aspx");
                    }
                }
            }

        }

        private static readonly HttpClient client = new HttpClient(); // Use a static HttpClient

        private async void GetGooglePlusUserData(string access_token)
        {
            try
            {
                var urlProfile = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + access_token;

                HttpResponseMessage response = await client.GetAsync(urlProfile);

                if (response.IsSuccessStatusCode)
                {
                    string outputData = await response.Content.ReadAsStringAsync();
                    GoogleUserOutputData userData = JsonConvert.DeserializeObject<GoogleUserOutputData>(outputData);

                    if (userData != null)
                    {
                        // You will get the user information here
                        // Example:
                        Console.WriteLine("User ID: userData.id");
                        Console.WriteLine("Name: {userData.name}");
                        Console.WriteLine("Email: userData.email");
                        Console.WriteLine("Profile Picture: {userData.picture}");
                    }
                }
                else
                {
                    // Handle unsuccessful response (e.g., log the error)
                    Console.WriteLine("Failed to retrieve user data");
                }
            }
            catch (Exception ex)
            {
                // Log the exception for debugging purposes
                Console.WriteLine("An error occurred: " + ex.Message);
            }
        }

        public class GoogleUserOutputData
        {
            public string id { get; set; }
            public string name { get; set; }
            public string given_name { get; set; }
            public string email { get; set; }
            public string picture { get; set; }
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

                String querry = "SELECT * FROM Login WHERE username= '" + username + "' AND password = '" + pass + "'";
                SqlDataAdapter sda = new SqlDataAdapter(querry, conn);

                DataTable dtable = new DataTable();
                sda.Fill(dtable);

                if (dtable.Rows.Count > 0)
                {
                    Response.Redirect("HOME_page.aspx"); // Redirect to the home page or dashboard.
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

        protected void btn2Submit_Click(object sender, EventArgs e)
        {
            var Googleurl = "https://accounts.google.com/o/oauth2/auth?response_type=code&redirect_uri=" + googleplus_redirect_url + "&scope=https://www.googleapis.com/auth/userinfo.email%20https://www.googleapis.com/auth/userinfo.profile&client_id=" + googleplus_client_id;
            Session["loginWith"] = "google";
            Response.Redirect(Googleurl);
        }

        protected void btn3Submit_Click(object sender, EventArgs e)
        {
            // Redirect to Facebook login page
            string appId = "642382241696796";
            string redirectUri = "https://localhost:44381/LOGIN_page.aspx"; // Your redirect URL
            string scope = "email, public_profile"; // Requested permissions

            string loginUrl = $"https://www.facebook.com/v12.0/dialog/oauth?client_id={appId}&redirect_uri={HttpUtility.UrlEncode(redirectUri)}&scope={scope}";
            Response.Redirect(loginUrl);
        }

        protected void btn4Submit_Click(object sender, EventArgs e)
        {
            Response.Redirect("SIGNUP_page.aspx"); // Redirect to the home page or dashboard.
        }

    }

}


