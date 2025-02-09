<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HOME_page.aspx.cs" Inherits="PICKandCOOK.HOME_page1" %>

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
   <div id="container">

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
                        <li><a href="recipes.html">Recipes</a></li>
                        <li><a href="planner.html">Planner</a></li>
                        <li><a href="services.html">Pantry</a></li>
                        <li><a href="shop.html">Shop</a></li>
                        <li><a href="favorites.html">Favorites</a></li>
                        <li><a href="LOGIN_page.aspx">Log In</a></li>
                    </ul>
                    <div class="social_buttons">
                        <a class="button" href="contact.html"> Contact Us </a>
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
        
       <div class="content">
            <form id="form2" runat="server">

            </form>
       </div>
   </div>
</body>
</html>