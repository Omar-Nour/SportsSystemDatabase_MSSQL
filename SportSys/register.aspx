<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="SportSys.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="height: 543px">
    <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="X-Large" Text="Sports System Register"></asp:Label>
        <br />
        <br />
        &nbsp;User Type :<asp:RadioButtonList ID="RadioList" runat="server" BackColor="White" Height="16px" RepeatDirection="Horizontal" Width="742px" OnSelectedIndexChanged="RadioList_SelectedIndexChanged" AutoPostBack="True">
            <asp:ListItem>Stadium Manager</asp:ListItem>
            <asp:ListItem>Fan</asp:ListItem>
            <asp:ListItem>Sports Association Manager</asp:ListItem>
            <asp:ListItem>Club Representative</asp:ListItem>
        </asp:RadioButtonList>
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
            Name :
        </p>
        <p>
            <asp:TextBox ID="name" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="292px"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="club_l" runat="server" Text="Club :"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="club" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="294px"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="std_l" runat="server" Text="Stadium :"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="stadium" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="292px"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="nid_l" runat="server" Text="National ID Number :"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="nid" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="292px"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="phone_l" runat="server" Text="Phone Number :"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="phone" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="292px" TextMode="Phone"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="birth_l" runat="server" Text="Birthdate :"></asp:Label>
        <p>
            <asp:TextBox ID="birth_d" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="292px" TextMode="Date"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="addrs_l" runat="server" Text="Address :"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="address" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="292px"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="reg_b" runat="server" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="41px" OnClick="register_b" Text="Register" Width="135px" />
        </p>
        <p>
            <asp:Label ID="error_lbl" runat="server" Font-Bold="True" ForeColor="#CC6600" Text="Label" Visible="False"></asp:Label>
        </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
