<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SHOP_page.aspx.cs" Inherits="PICKandCOOK.SHOP_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8" />
    <title>PICK and COOK</title>
    <meta name="description" content="PICK and COOK Website"/>
    <link rel="shortcut icon" href="img/logo.ico"/>
    <link rel="stylesheet" href="style/style_shoppage.css"/>

</head>
<body>
   <div id ="homepage">
        <form id="form1" runat="server">
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

                                    <div class = "shopcontainer">
                                            <h2 class = "shopheader">Shopping List</h2>
                                            <div id ="ingredients">
                                                    <asp:CheckBoxList ID="ingredientCheckBoxList" runat="server">
                                                    </asp:CheckBoxList>
                                            </div>
                                            <div id="btn">
                                                    <!-- Sync Button -->
                                                    <asp:Button id="btnSubmit" runat="server" type="button" onclick="ShoppingList" Text="Checkout & Deliver"></asp:Button>
                                            </div>
                                    </div>
                    </div>

                            <section id="shop2">
                                  
                                  <div style = "height:60px; width:100%; background-color: #F4E1D1;"></div>

                            <div class = "checkoutdelivery">
                                        <div id="text-content">
                                        <asp:Label ID="totalPriceLabel" runat="server" Text=""></asp:Label>
                                        </div>
                                        <div id="image-content">
                                        <asp:Image ID="qrImage" runat="server" />   
                                        </div>
                            </div>
                            </section>
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
                            <script type="text/javascript">
                               function scrollToShop2() {
                                   var element = document.getElementById("shop2");
                                   if (element) {
                                       element.scrollIntoView({ behavior: "smooth" });
                                   }
                               }
                            </script>

                   <div id="big4">
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
