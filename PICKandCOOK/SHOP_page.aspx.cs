using System;
using QRCoder;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Drawing.Imaging;

namespace PICKandCOOK
{
    public partial class SHOP_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadIngredients();
                qrImage.ImageUrl = "~/img/qr_img.png";
            }
        }

        private void LoadIngredients()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyDatabaseConnectionString"].ConnectionString;
            string query = "SELECT DISTINCT name FROM Ingredients";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                DataTable ingredientsTable = new DataTable();

                using (SqlDataAdapter adapter = new SqlDataAdapter(query, conn))
                {
                    adapter.Fill(ingredientsTable);
                }

                ingredientCheckBoxList.DataSource = ingredientsTable;
                ingredientCheckBoxList.DataTextField = "name";
                ingredientCheckBoxList.DataValueField = "name";
                ingredientCheckBoxList.DataBind();
            }
        }

        protected void ShoppingList(object sender, EventArgs e)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyDatabaseConnectionString"].ConnectionString;
            decimal totalPrice = 0;
            string username = Session["Username"] as string;
            int deliveryId = 0;

            if (string.IsNullOrEmpty(username))
            {
                totalPriceLabel.Text = "You need to LOGIN or SIGNUP first!!";
                string message = "need to LOGIN or SIGNUP first!!";
                string script = "showFloatingMessage('You " + message.Replace("'", "\\'") + "', 'error');";
                ClientScript.RegisterStartupScript(this.GetType(), "FloatingMessage", script, true);
                qrImage.ImageUrl = "~/img/qr_img.png";
                ScriptManager.RegisterStartupScript(this, GetType(), "scrollToShop2", "scrollToShop2();", true);
                return;
            }

            // Calculate total price from selected ingredients
            foreach (ListItem item in ingredientCheckBoxList.Items)
            {
                if (item.Selected)
                {
                    string ingredientName = item.Value;
                    string query = "SELECT price FROM IngredientPrice WHERE name = @name";

                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@name", ingredientName);
                        conn.Open();
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            totalPrice += Convert.ToDecimal(result);
                        }
                    }
                }
            }

            if (totalPrice == 0)
            {
                totalPriceLabel.Text = "Error: No items selected.";
                string message = "No items selected.";
                string script = "showFloatingMessage('Error : " + message.Replace("'", "\\'") + "', 'error');";
                ClientScript.RegisterStartupScript(this.GetType(), "FloatingMessage", script, true);
                qrImage.ImageUrl = "~/img/qr_img.png";
                ScriptManager.RegisterStartupScript(this, GetType(), "scrollToShop2", "scrollToShop2();", true);
                return;
            }

            // Insert into Delivery table
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string insertQuery = "INSERT INTO Delivery (username, total_price) OUTPUT INSERTED.del_id VALUES (@username, @totalPrice)";

                using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@username", username);
                    cmd.Parameters.AddWithValue("@totalPrice", totalPrice);
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                }
            }

            // Display total price
            totalPriceLabel.Text = "Total Price: $" + totalPrice.ToString("F2");

            // Generate QR Code
            string qrData = "Delivery ID: " + deliveryId + "\nUsername: " + username + "\nTotal Price: $" + totalPrice.ToString("F2");
            GenerateQRCode(qrData);
        }

        private void GenerateQRCode(string qrData)
        {
            using (QRCodeGenerator qrGenerator = new QRCodeGenerator())
            {
                using (QRCodeData qrCodeData = qrGenerator.CreateQrCode(qrData, QRCodeGenerator.ECCLevel.Q))
                {
                    using (QRCode qrCode = new QRCode(qrCodeData))
                    {
                        using (Bitmap qrBitmap = qrCode.GetGraphic(20))
                        {
                            using (MemoryStream ms = new MemoryStream())
                            {
                                qrBitmap.Save(ms, ImageFormat.Png);
                                byte[] byteImage = ms.ToArray();
                                string base64Image = Convert.ToBase64String(byteImage);
                                qrImage.ImageUrl = "data:image/png;base64," + base64Image;
                            }
                        }
                    }
                }
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "scrollToShop2", "scrollToShop2();", true);
            return;

        }

    }
}
