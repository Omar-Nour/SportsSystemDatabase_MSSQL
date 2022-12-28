<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_fan.aspx.cs" Inherits="SportSys.admin_fan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <p>
            <asp:TextBox ID="block_f_n" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="31px" Width="175px" placeholder="Fan National ID"></asp:TextBox>
                <asp:Button ID="block_f_b" runat="server" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="37px" OnClick="blockFan" Text="block Fan" Width="135px" />
            </p>
            <p>
            <asp:TextBox ID="unblock_f_n" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="31px" Width="175px" placeholder="Fan National ID"></asp:TextBox>
                <asp:Button ID="unblock_f_b" runat="server" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="37px" OnClick="unblockFan" Text="unblock Fan" Width="135px" />
            </p>
            <p>
                <asp:Label ID="error_lbl" runat="server" Font-Bold="True" ForeColor="#CC0000" Text="Label" Visible="False"></asp:Label>
            </p>
        </div>
        <asp:GridView ID="FansGridView" runat="server" BorderStyle="Solid">
            <HeaderStyle BackColor="Black" BorderStyle="Solid" ForeColor="White" />
            <RowStyle BorderStyle="Solid" />
        </asp:GridView>
        <p>
          <asp:LinkButton ID="back" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="Back To Main Menu <" PostBackUrl="~/admin.aspx"/>
       </p>
    </form>
</body>
</html>

