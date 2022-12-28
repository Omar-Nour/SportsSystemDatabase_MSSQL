<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_stadium.aspx.cs" Inherits="SportSys.admin_stadium" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="stadium_n" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="31px" Width="175px" placeholder="Stadium Name"></asp:TextBox>
            <asp:TextBox ID="stadium_l" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="31px" Width="175px" placeholder="Stadium Location"></asp:TextBox>
            <asp:TextBox ID="stadium_c" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="31px" Width="175px" placeholder="Stadium Capacity" TextMode="Number"></asp:TextBox>
            <asp:Button ID="addstadium_b" runat="server" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="37px" OnClick="AddStadium" Text="Add Stadium" Width="135px" />
            <br />
            <p>
            <asp:TextBox ID="d_stadium_n" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="31px" Width="175px" placeholder="Stadium Name"></asp:TextBox>
                <asp:Button ID="deleteStadium_b" runat="server" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="37px" OnClick="deleteStadium" Text="Delete Stadium" Width="135px" />
            </p>
            <p>
                <asp:Label ID="error_lbl" runat="server" Font-Bold="True" ForeColor="#CC0000" Text="Label" Visible="False"></asp:Label>
            </p>
        </div>
        <asp:GridView ID="StadiumsGridView" runat="server" BorderStyle="Solid">
            <HeaderStyle BackColor="Black" BorderStyle="Solid" ForeColor="White" />
            <RowStyle BorderStyle="Solid" />
        </asp:GridView>
        <p>
          <asp:LinkButton ID="back" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="Back To Main Menu <" PostBackUrl="~/admin.aspx"/>
       </p>
    </form>
</body>
</html>

