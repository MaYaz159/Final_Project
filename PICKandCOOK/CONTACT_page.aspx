<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CONTACT_page.aspx.cs" Inherits="PICKandCOOK.CONTACT_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
      <meta charset="utf-8" />
      <title>PICK and COOK</title>
      <meta name="description" content="PICK and COOK Website"/>
      <link rel="shortcut icon" href="img/logo.ico"/>
      <link rel="stylesheet" href="style/style_contactpage.css"/>
</head>

<body>
       <div id ="homepage">
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
               <div id="container">
               <form id="contactForm" runat="server" class="form-container">
                            <asp:Literal ID="ltMessage" runat="server"></asp:Literal>
                            <div class="form-header">Contact Form</div>
                            <div class="form-group">
                                <label for="firstName">First Name :</label>
                                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" MaxLength="20" Required="true"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="lastName">Last Name :</label>
                                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" MaxLength="20" Required="true"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="email">Email :</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Required="true"></asp:TextBox>
                            </div>
                            <div id="emaildiv">
                            <asp:Label ID="lblemail" runat="server" Text="" Visible="false"></asp:Label>
                            </div>
                            <div class="form-group">
                                <label for="message">Message :</label>
                                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" Required="true"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                 <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"  />
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
               </form>
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
       </div>
</body>
</html>

