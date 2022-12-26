<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_club.aspx.cs" Inherits="SportSys.admin_match" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="club_n" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="31px" Width="175px" placeholder="Club Name"></asp:TextBox>
            <asp:TextBox ID="club_l" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="31px" Width="175px" placeholder="Club Location"></asp:TextBox>
            <asp:Button ID="addclub_b" runat="server" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="37px" OnClick="Addclub" Text="Add Club" Width="135px" />
            <br />
            <p>
            <asp:TextBox ID="d_club_n" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="31px" Width="175px" placeholder="Club Name"></asp:TextBox>
                <asp:Button ID="deleteclub_b" runat="server" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="37px" OnClick="deleteClub" Text="Delete Club" Width="135px" />
            </p>
            <p>
                <asp:Label ID="error_lbl" runat="server" Font-Bold="True" ForeColor="#CC0000" Text="Label" Visible="False"></asp:Label>
            </p>
        </div>
        <asp:GridView ID="ClubsGridView" runat="server" BorderStyle="Solid">
            <HeaderStyle BackColor="Black" BorderStyle="Solid" ForeColor="White" />
            <RowStyle BorderStyle="Solid" />
        </asp:GridView>
        <p>
          <asp:LinkButton ID="back" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="Back To Main Menu <" PostBackUrl="~/admin.aspx"/>
       </p>
    </form>
</body>
</html>
