<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PLANNER_page.aspx.cs" Inherits="PICKandCOOK.PLANNER_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8" />
    <title>PICK and COOK</title>
    <meta name="description" content="PICK and COOK Website"/>
    <link rel="shortcut icon" href="img/logo.ico"/>
    <link rel="stylesheet" href="style/style_plannerpage.css"/>

</head>
<body>
    <form id="form1" runat="server">
        <div id ="homepage">
             <section id="planner1">
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

                        <div id="big1">
                                <div class="text-container">
                                <h1 id="headertext1">Find Recipes Tailored to Your Dietary Requirements!</h1>
                                <h2 id="notice"> Notice: You can select multiple week planners and they will be saved in your profile. </h2>
                                <asp:DropDownList ID="ddlDietaryRestrictions" runat="server">
                                    <asp:ListItem Text="Select Dietary Restriction" Value=""></asp:ListItem>
                                </asp:DropDownList>
                                        <asp:Button ID="btn" runat="server" Text="Tailored Meals for You! 🍴✅" OnClick="Button1_Click" />
                                </div>
                                <div class="image-content"> 
                                     <img id="img1" src="img/meal.png" alt="Recipe Image"/>
                                </div>
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
                                         var element = document.getElementById("planner2");
                                         if (element) {
                                             element.scrollIntoView({ behavior: "smooth" });
                                         }
                                     }
                                </script>
                        </div>
              </section>

                <section id="planner2">
                <div id="big2">
                      <div class="image-container"> 
                                <asp:Image ID="imgBreakfast" runat="server" />
                                <asp:Image ID="imgLunch" runat="server" />
                                <asp:Image ID="imgDinner" runat="server" />
                      </div>

                      <div class="text-content">
                      <asp:Repeater ID="mealRepeater" runat="server">
                            <ItemTemplate>
                                <table>
                                <h3 id="headertext2"><%# Eval("Day") %></h3>
                                    <tr>
                                            <asp:DropDownList ID="ddlBreakfast" runat="server" 
                                                CssClass="ddlBreakfast" DataSource='<%# Eval("BreakfastRecipes") %>'
                                                DataTextField="RecipeName" DataValueField="RecipeID">
                                                <asp:ListItem Text="Select Breakfast" Value=""></asp:ListItem>
                                            </asp:DropDownList>
                                    </tr>
                                    <tr>
                                            <asp:DropDownList ID="ddlLunch" runat="server" 
                                                CssClass="ddlLunch" DataSource='<%# Eval("LunchRecipes") %>'
                                                DataTextField="RecipeName" DataValueField="RecipeID">
                                                <asp:ListItem Text="Select Lunch" Value=""></asp:ListItem>
                                            </asp:DropDownList>
                                    </tr>
                                    <tr>
                                            <asp:DropDownList ID="ddlDinner" runat="server" 
                                                CssClass="ddlDinner" DataSource='<%# Eval("DinnerRecipes") %>'
                                                DataTextField="RecipeName" DataValueField="RecipeID">
                                                <asp:ListItem Text="Select Dinner" Value=""></asp:ListItem>
                                            </asp:DropDownList>
                                    </tr>
                                </table>
                            </ItemTemplate>
                      </asp:Repeater>
                            <asp:Button ID="btnSave" runat="server" Text="Save Meal Plan" OnClick="SaveMealPlan" />
                      </div>
                </div>
                </section>

                       <div id="big3">
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

        </div>
    </form>
</body>
</html>




