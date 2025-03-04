<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RECIPES_page.aspx.cs" Inherits="PICKandCOOK.RECIPES_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8" />
    <title>PICK and COOK</title>
    <meta name="description" content="PICK and COOK Website"/>
    <link rel="shortcut icon" href="img/logo.ico"/>
    <link rel="stylesheet" href="style/style_recipespage.css"/>

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
                        <div class="text-content">
                                <h1 id="headertext1"> Cook What You Love <br/> – Search Recipes by <br/> Meal Type or Cuisine! </h1>
                                <h2 id="headertext2"> Get Inspired: Your Next Favorite Recipe Awaits! </h2>
                                <div id="but">
                                <a href="#recipes" class="btn"> 🔍 Browse Recipes </a>
                                </div>
                        </div>
                        <div class="video-content"> 
                                <div class="slideshow-container">
                                    <video class="mySlides" autoplay="autoplay" muted="muted" loop="loop">
                                        <source src="videos/video2.mp4" type="video/mp4" controls="false" />
                                        Your browser does not support the video tag.
                                    </video>
                                    <video class="mySlides" autoplay="autoplay" muted="muted" loop="loop">
                                        <source src="videos/video3.mp4" type="video/mp4" controls="false" />
                                        Your browser does not support the video tag.
                                    </video>
                                    <video class="mySlides" autoplay="autoplay" muted="muted" loop="loop">
                                        <source src="videos/video4.mp4" type="video/mp4" />
                                        Your browser does not support the video tag.
                                    </video>
                                    <video class="mySlides" autoplay="autoplay" muted="muted" loop="loop">
                                        <source src="videos/video5.mp4" type="video/mp4" />
                                        Your browser does not support the video tag.
                                    </video>
                                </div>
                                      <script>
                                          let slides = document.querySelectorAll('.mySlides');
                                          let currentIndex = 0;

                                          function showSlides() {
                                              slides.forEach(slide => slide.classList.remove('active'));
                                              slides[currentIndex].classList.add('active');
                                              currentIndex = (currentIndex + 1) % slides.length;
                                          }

                                          setInterval(showSlides, 10000); // Change every 10 seconds
                                          showSlides(); // Initialize the first video
                                      </script>
                                      <script>
                                          const videos = document.querySelectorAll('video');
                                          videos.forEach(video => {
                                              video.disablePictureInPicture = true; // Disable PiP
                                          });
                                      </script>
                        </div>
                </div>
           <section id="recipes">
           <div style = "height:57px; width:100%; background-color: #F4E1D1;"></div>
           <div id="big2">
                  <div class="image-content"> 
                      <img id="img1" src="img/bg3.png" alt="Recipe Image"/>
                 </div> 
                 <div class="text-container">
                 <h3 id="headertext3"> Meal Type: </h3>
                 <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="false"></asp:DropDownList>
                 <h4 id="headertext4"> Cuisine Name: </h4>
                 <asp:DropDownList ID="DropDownList2" runat="server" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" AutoPostBack="false"></asp:DropDownList>
                 <asp:ScriptManager ID="ScriptManager1" runat="server" />
                 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                      <ContentTemplate>
                           <asp:Button ID="Button1" runat="server" Text="👉 Load" OnClick="Button1_Click" OnClientClick="clearTextBox()" PostBackUrl="~/RECIPES_page.aspx#recipes2" />
                      </ContentTemplate>
                 </asp:UpdatePanel>
                 </div>
                 <script>
                     function clearTextBox() {
                         // Clear the TextBox
                         document.getElementById('<%= TextBox1.ClientID %>').value = '';
                     }
                 </script>
           </div>
           </section>
           <section id="recipes2">
           <div style = "height:55px; width:100%; background-color: #F4E1D1;"></div>
           <div id="big3">
                <div class="text">
                    <h5 id="headertext5"> Cook Like a Pro with These Amazing Recipes </h5>
                    <div id="textbox">
                    <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" ReadOnly="True" Disabled="True"></asp:TextBox>
                    </div>
                </div>
                 <div class="image-container"> 
                     <img id="img2" src="img/recipe.png" alt="Recipe Image" />
                </div> 
           </div>
           </section>
           <div style = "height:57px; width:100%; background-color: #F4E1D1;"></div>
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
