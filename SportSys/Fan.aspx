<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan.aspx.cs" Inherits="SportSys.Fan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="UsernameLabel" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="NIDLabel" runat="server" Text="Label"></asp:Label>
        </div>
        <asp:TextBox ID="DateTimeBox" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="294px" TextMode="Date"></asp:TextBox>
        <asp:Button ID="userIn" runat="server" Text="Choose Date Time" OnClick="userInFunc" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="41px"   Width="135px"/>
        <asp:Button ID="currTimeStamp" runat="server" Text="From Current Time" OnClick="currTimeFunc" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="41px"   Width="135px"/>
        <asp:GridView ID="MatchesGridView" runat="server"></asp:GridView>
        <p>
        <asp:Label ID="PurchaseTicketLabel" runat="server" Text="Label" Font-Bold="True" ForeColor="#00FF00"></asp:Label>
        </p>
    </form>
</body>
</html>
