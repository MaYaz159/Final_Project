<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HOME_page.aspx.cs" Inherits="PICKandCOOK.HOME_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8" />
    <title>PICK and COOK</title>
    <meta name="description" content="PICK and COOK Website"/>
    <link rel="shortcut icon" href="img/logo.ico"/>
    <link rel="stylesheet" href="style/style_homepage.css"/>

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
                        <li><a href="planner.html">Planner</a></li>
                        <li><a href="services.html">Pantry</a></li>
                        <li><a href="shop.html">Shop</a></li>
                        <li><a href="favorites.html">Favorites</a></li>
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
                        <div class="text-content">
                                <h1 id="headertext1">Discover, Plan, <br/> and Shop with Ease!</h1>
                                <h2 id="headertext2">Bringing Flavours to Your Kitchen</h2>
                                <p id="firstp">
                                        Welcome to Pick N' Cook, your go-to website for discovering and creating endless meal possibilities! 
                                        Whether you're cooking for yourself, your family, <br/> or hosting a dinner party, we've got you covered 
                                        with easy-to-follow recipes, meal planning tools, <br/> and grocery shopping assistance.
                                </p>
                                <asp:ScriptManager ID="ScriptManager1" runat="server" />
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="Button1" runat="server" Text="🔊 Tap Me, I Talk!" OnClick="Button1_Click" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                        </div>
                        <div class="image-content">
                                <img id="img1" src="img/img5.png" alt="Cooking Image" />
                        </div>
                </div>
           <div id="big2">
               <div class="container2">
                     <div class="image-container">
                     <img id="image2" src="img/bg.png" alt="Pick n' Cook" />
                     </div>
                     <div class="text-container">
                     <h2 id="h2">" From Pick to Plate, We've Got You Covered. "</h2>
                     <p id="p">Sign Up for Free. <br/> Unlock Your Culinary Potential!</p>
                     <asp:Button class="logbutton" ID="Button2" runat="server" Text="GET STARTED TODAY!" OnClick="Button2_Click" />
                    </div>
               </div>
           </div>
           <div id="big3">
               <div class="container3">
                   <div class="text">
                        <h1 id="h1text">DISCOVER <br/> OUR <br/> AMAZING <br/> FEATURES</h1>
                        <p id="ptext">explore mouthwatering recipes, <br/> effortlessly plan your meals, <br/> and shop for groceries <br/> — all with just a single click!</p>
                   </div>
                   <div class="images">
                            <div class="feature">
                                <img id="imgs" src="img/img8.png" alt="Plan Feature" />
                                <h2 id="h2text">PLAN</h2>
                            </div>
                            <div class="feature">
                                <img id="imgs" src="img/img2.png" alt="Cook Feature" />
                                <h2 id="h2text">COOK</h2>
                            </div>
                            <div class="feature">
                                <img id="imgs" src="img/img6.png" alt="Enjoy Feature" />
                                <h2 id="h2text">ENJOY</h2>
                            </div>
                   </div>
               </div>
           </div>
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