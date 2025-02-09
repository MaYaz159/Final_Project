<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DELETE_page.aspx.cs" Inherits="PICKandCOOK.DELETE_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Delete Account :</h2>
            <p>Are you sure you want to delete your account? This action cannot be undone.</p>
            <asp:Button ID="btnConfirmDelete" runat="server" Text="Yes, Delete My Account" OnClick="btnConfirmDelete_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
            <asp:Label ID="lblStatus" runat="server" Text="" ForeColor="Red"></asp:Label>
        </div>
    </form>
</body>
</html>
