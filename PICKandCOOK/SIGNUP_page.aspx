<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SIGNUP_page.aspx.cs" Inherits="PICKandCOOK.SIGNUP_page" Async="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
       <meta charset="utf-8" />
    <title>PICK and COOK</title>
    <meta name="description" content="PICK and COOK Website"/>
    <link rel="shortcut icon" href="img/logo.ico"/>
    <link rel="stylesheet" href="style/style_signuppage.css"/>

</head>
<body>      
     <div class="content">
              <div class="background">
                        <div class="shape"></div>
                        <div class="shape"></div>
              </div>
     <form id="form1" runat="server">
            <h3> Ready to Dive In? <br/> Create Your Account! </h3>
            <asp:Label ID="Label1" runat="server" Text="Username :"></asp:Label>
                    <asp:TextBox ID="TextBox1" placeholder="Email or Phone" runat="server"></asp:TextBox> 
            <asp:Label ID="Label2" runat="server" Text="Password :"></asp:Label>
                          <asp:TextBox ID="TextBox2" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
            <asp:Label ID="lblErrorMessage" runat="server" ForeColor="red" Visible="false"></asp:Label>
            <asp:Button ID="Button1" runat="server" Text="Sign Up" OnClick="btn1Submit_Click" />
            <div class="social">
            <asp:Button ID="Button2" runat="server" Text="Google" OnClick="btn2Submit_Click" />
            <asp:Button ID="Button3" runat="server" Text="Facebook" OnClick="btn3Submit_Click" />
            </div>  
     </form>
       </div>

</body>
</html>

