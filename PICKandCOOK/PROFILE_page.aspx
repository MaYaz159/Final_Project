<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PROFILE_page.aspx.cs" Inherits="PICKandCOOK.PROFILE_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8" />
    <title>PICK and COOK</title>
    <meta name="description" content="PICK and COOK Website"/>
    <link rel="shortcut icon" href="img/logo.ico"/>
    <link rel="stylesheet" href="style/style_profilepage.css"/>

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
                        <div class="all">
                            <h2>My Account</h2>
                                <div class="section">
                                     <!-- Profile Image -->
                                        <div class="profile-image">
                                            <asp:Image ID="imgProfile" runat="server" CssClass="profile-pic" />
                                        </div>

                                    <h3>Account Information</h3>
                                    <p><strong>Username:</strong> <asp:Label ID="lblUsername" runat="server" /></p>
                                    <p><strong>Password:</strong> <asp:Label ID="lblPassword" runat="server" Text="**********" /></p>
                                    <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" OnClick="btnChangePassword_Click" />
                                </div>

                                <div class="section">
                                    <h3>Favorite Recipes</h3>
                                    <asp:Repeater ID="rptFavorites" runat="server">
                                        <ItemTemplate>
                                            <p>
                                                <strong><%# Eval("title") %></strong> 
                                                <asp:Button ID="btnDeleteFav" runat="server" Text="Remove" CommandArgument='<%# Eval("recipe_id") %>' OnClick="btnDeleteFav_Click" />
                                            </p>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>

                                <div class="section">
                                    <h3>Meal Plans</h3>
                                    <asp:Repeater ID="rptMealPlans" runat="server">
                                        <ItemTemplate>
                                            <p>
                                                <strong>Meal Plan ID:</strong> <%# Eval("meal_plan_id") %> (Created: <%# Eval("date_created") %>)
                                                <asp:Button ID="btnDeletePlan" runat="server" Text="Delete" CommandArgument='<%# Eval("meal_plan_id") %>' OnClick="btnDeletePlan_Click" />
                                            </p>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>

                                <div class="section">
                                    <asp:Button ID="btnLogout" runat="server" Text="Log Out" OnClick="btnLogout_Click" />
                                </div>
                        </div>
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