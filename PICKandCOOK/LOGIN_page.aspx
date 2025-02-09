<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LOGIN_page.aspx.cs" Inherits="PICKandCOOK.HOME_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8" />
    <title>PICK and COOK</title>
    <meta name="description" content="PICK and COOK Website"/>
    <link rel="shortcut icon" href="img/logo.ico"/>
    <link rel="stylesheet" href="style/style_loginpage.css"/>

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
              <div class="background">
                        <div class="shape"></div>
                        <div class="shape"></div>
              </div>
     <form id="form1" runat="server">
            <h3> Welcome Back! </h3>
            <asp:Label ID="Label1" runat="server" Text="Username :"></asp:Label>
                    <asp:TextBox ID="TextBox1" placeholder="Email or Phone" runat="server"></asp:TextBox> 
            <asp:Label ID="Label2" runat="server" Text="Password :"></asp:Label>
                    <asp:TextBox ID="TextBox2" TextMode="Password" placeholder="Password" runat="server"></asp:TextBox>
            <asp:Label ID="lblErrorMessage" runat="server" ForeColor="#d63d0f" Visible="false"></asp:Label>
            <asp:Button ID="Button1" runat="server" Text="Log In" OnClick="btn1Submit_Click" />
            <div class="social">
             <asp:Button ID="Button2" runat="server" Text="Google" OnClick="btn2Submit_Click" />
             <asp:Button ID="Button3" runat="server" Text="Facebook" OnClick="btn3Submit_Click" />
            
            </div>  
            <div id ="sign_up">
            <asp:Label ID="Label3" runat="server" Text="Don't have an account? :"></asp:Label>
            <asp:Button ID="Button4" runat="server" Text="Sign Up" OnClick="btn4Submit_Click" /> 
            </div>
            </form>
       </div>

   </div>
</body>
</html>

