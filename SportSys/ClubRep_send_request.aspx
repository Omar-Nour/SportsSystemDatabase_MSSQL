<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClubRep_send_request.aspx.cs" Inherits="SportSys.ClubRep_send_request" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Sys_User_name" runat="server" Text="Sending requests as "></asp:Label>
            <br />
            <br />
            <br />
            <asp:Label ID="Name" runat="server" Text="Requesting club name: "></asp:Label>
        </div>
        <p>
            <asp:TextBox ID="Club_name" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="294px"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Stadium_field" runat="server" Text="Requested stadium name: "></asp:Label>
        </p>
         <p>
            <asp:TextBox ID="Stadium_name" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="294px"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Date" runat="server" Text="Date and time: "></asp:Label>
        </p>
         <p>
            <asp:TextBox ID="date_time" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="294px"></asp:TextBox>
        </p>
        
        <p>
            <asp:Label ID="status" runat="server" Text="Label"  Visible = "false"></asp:Label>
        </p>

         <p>
          <asp:LinkButton ID="Send_request" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="Send request" OnClick = "send_request"/>
       </p>

        <p>
          <asp:LinkButton ID="Back_to_main" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="BACK TO MAIN MENU" PostBackUrl="~/ClubRep.aspx"/>
       </p>

    </form>
</body>
</html>
