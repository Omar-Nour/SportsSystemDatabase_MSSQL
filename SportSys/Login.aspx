<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SportSys.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="height: 543px">
    <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Large" Text="Sports System Login"></asp:Label>
        <p>
            Username :
        </p>
        <p>
            <asp:TextBox ID="username" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="294px"></asp:TextBox>
        </p>
        <p>
            Password :</p>
        <p>
            <asp:TextBox ID="password" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="292px" TextMode="Password"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="login_b" runat="server" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="41px" OnClick="login" Text="Login" Width="135px" />
        </p>
        <p>
            or register <asp:LinkButton ID="reg_hyper" runat="server" OnClick="redirect_registraion">here</asp:LinkButton>
        </p>
        <p>
            <asp:Label ID="error_lbl" runat="server" Font-Bold="True" ForeColor="#CC6600" Text="Label" Visible="False"></asp:Label>
        </p>
    </form>
</body>
</html>
