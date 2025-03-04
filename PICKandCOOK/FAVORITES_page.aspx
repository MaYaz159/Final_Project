<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FAVORITES_page.aspx.cs" Inherits="PICKandCOOK.FAVORITES_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>PICK and COOK</title>
    <meta name="description" content="PICK and COOK Website"/>
    <link rel="shortcut icon" href="img/logo.ico"/>
    <link rel="stylesheet" href="style/style_favoritespage.css"/>
</head>
<body>
   <div id ="homepage">
        <form id="form2" runat="server">
                <header id="header">
                    <div class="logoandimage">
                        <div class="logo_image">
                            <img id="imglogo" src="img/logo.ico" alt="logo" draggable="false" />
                        </div>
                    <div class="title">
                        <p class="font-p">PICK N' COOK</p>
                    </div>
                </div>
                <div class="list_items">
                    <ul class="items">
                        <li><a href="HOME_page.aspx">Home</a></li>
                        <li><a href="RECIPES_page.aspx">Recipes</a></li>
                        <li><a href="PLANNER_page.aspx">Planner</a></li>
                        <li><a href="SHOP_page.aspx">Shop</a></li>
                        <li><a href="FAVORITES_page.aspx">Favorites</a></li>
                        <li><a href="PROFILE_page.aspx"> Account </a></li>
                        <li><a href="LOGIN_page.aspx">Log In</a></li>
                    </ul>
                    <div class="social_buttons">
                        <a class="button" href="CONTACT_page.aspx"> Contact Us </a>
                    </div>
                    <div class="s">
                        <a href="https://facebook.com/">
                            <img src="img/ff.png" alt="SVG Image" style="width: 30px; height: 30px;" />
                        </a>
                        <a href="https://twitter.com/">
                            <img src="img/t.png" alt="SVG Image" style="width: 30px; height: 30px;" />
                        </a>
                        <a href="https://www.instagram.com/">
                            <img src="img/bi.svg" alt="SVG Image" style="width: 30px; height: 30px;" />
                        </a>
                    </div>
                </div>
            </header>
        
                <div class="container">

                             <asp:GridView ID="RecipeGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="recipe_id">
                             <Columns>
                                 <asp:TemplateField HeaderText="Image">
                                     <ItemTemplate>
                                         <img src='<%# Eval("image_url") %>' alt="Recipe Image" />
                                     </ItemTemplate>
                                 </asp:TemplateField>
                                 <asp:BoundField DataField="title" HeaderText="Recipe Name" />
                                 <asp:BoundField DataField="cuisine_name" HeaderText="Cuisine" />
                                 <asp:BoundField DataField="meal_type_name" HeaderText="Meal Type" />
                                 <asp:TemplateField HeaderText="Add to Favorites">
                                     <ItemTemplate>
                                         <asp:Button ID="AddToFavorites" runat="server" Text="Add to Favorites ❤️" OnClick="AddToFavorites_Click" CssClass="aspNet-AddToFavorites" />
                                     </ItemTemplate>
                                 </asp:TemplateField>
                             </Columns>
                             </asp:GridView>
                           <script>
                                   function showFloatingMessage(message, type) {
                                       var msgDiv = document.createElement("div");
                                       msgDiv.className = "floating-message " + type;
                                       msgDiv.innerHTML = message;
                                       document.body.appendChild(msgDiv);
                                       msgDiv.style.display = "block";

                                       setTimeout(function () {
                                           msgDiv.style.opacity = "0";
                                           setTimeout(function () {
                                               document.body.removeChild(msgDiv);
                                           }, 500);
                                       }, 6000);
                                   }
                           </script>

                </div>

                 <div id="big">

                              <footer class="custom-footer">
                                      <div class="footer-left">
                                          <div class="name">
                                              <img class="footer-logo" src="img/logo.ico" alt="Pick N' Cook Logo" />
                                              <span class="brand-name">PICK N' COOK</span>
                                          </div>
                                              <p class="credits">Done By : Malak Yazbek ...</p>
                                      </div>
                                      <div class="footer-right">
                                          <div class="contact-info">
                                              <p class="address"><i class="icon-location"></i> 2677+FX7 Baalbek, Lebanon</p>
                                              <p class="phone"><i class="icon-phone"></i> 961-81859108</p>
                                              <p class="email"><i class="icon-email"></i> ma159yaz@gmail.com</p>
                                          </div>
                                      </div>
                              </footer>

                 </div>

        </form>
    </div>
</body>
</html>



