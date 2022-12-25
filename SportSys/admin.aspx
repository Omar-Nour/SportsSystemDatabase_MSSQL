<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="SportSys.admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Welcome, <asp:Label ID="admin_l" runat="server" Text=""></asp:Label>
          
        </div>

        <p>
          <asp:LinkButton ID="mngClubs" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="Manage Clubs" PostBackUrl="~/admin_club.aspx"/>
       </p>

        <p>
          <asp:LinkButton ID="mngStads" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="Manage Stadiums" PostBackUrl="~/admin_stadium.aspx"/>
       </p>

        <p>
          <asp:LinkButton ID="mngFans" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="Manage Fans" PostBackUrl="~/admin_fan.aspx"/>
       </p>

         
    </form>
</body>
</html>
