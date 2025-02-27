<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LOGIN_page.aspx.cs" Inherits="PICKandCOOK.LOGIN_page" Async="true" %>

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
                  <div style="position: relative;">
                        <asp:TextBox ID="TextBox2" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:Button ID="btnTogglePassword" runat="server" CssClass="eye-icon" OnClientClick="togglePasswordVisibility(); return false;" />
                  </div>
            <asp:Label ID="lblErrorMessage" runat="server" ForeColor="red" Visible="true" Text = "Your password will be securely hashed for protection. <br> Please remember it, or use a password manager to store it safely."></asp:Label>
            <asp:Button ID="Button1" runat="server" Text="Log In" OnClick="btn1Submit_Click" />
            <div id ="sign_up">
            <asp:Label ID="Label3" runat="server" Text="Don't have an account?"></asp:Label>
            <asp:Button ID="Button2" runat="server" Text="Sign Up" OnClick="btn2Submit_Click" /> 
            </div>
            </form>
       </div>
       <script>
                function togglePasswordVisibility() {
                var passwordField = document.getElementById('<%= TextBox2.ClientID %>');
                var eyeIcon = document.getElementById('<%= btnTogglePassword.ClientID %>');

                    if (passwordField.type === "password") {
                    passwordField.type = "text";  // Make the password visible
                    eyeIcon.classList.add("show-password");
                    }
                    else {
                    passwordField.type = "password";  // Hide the password
                    eyeIcon.classList.remove("show-password");
                    }
                }
       </script>

</body>
</html>

