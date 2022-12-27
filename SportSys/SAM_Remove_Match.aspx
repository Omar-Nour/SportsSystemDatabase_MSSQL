<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SAM_Remove_Match.aspx.cs" Inherits="SportSys.SAM_Remove_Match" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="Remove_Matches" runat="server">
        <div>
            REMOVING MATCHES AS <asp:Label ID="User_name" runat="server" Text=""></asp:Label></div>
         <p>
            HOST CLUB :
        </p>
        <p>
            <asp:TextBox ID="Host_Club" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="294px"></asp:TextBox>
        </p>

          <p>
            GUEST CLUB :
        </p>
        <p>
            <asp:TextBox ID="Guest_Club" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="294px"></asp:TextBox>
        </p>

          <p>
            START TIME :
        </p>
        <p>
            <asp:TextBox ID="Start_Time" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="294px"></asp:TextBox>
        </p>

          <p>
            END TIME :
        </p>
        <p>
            <asp:TextBox ID="End_Time" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="294px"></asp:TextBox>
        </p>

        <p>
            &nbsp;</p>

          <p>
          <asp:Button ID="REMOVE_MATCH" style="text-align:center" Font-Underline="false" BackColor="Red" BorderStyle="Double" ForeColor="White" OnClick="remove_match" runat="server" Width="325px" Text="DELETE MATCH" />
       </p>


          <p>
          <asp:LinkButton ID="Back_to_main" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="BACK TO MAIN MENU" PostBackUrl="~/SAM View.aspx"/>
       </p>

        <p>
            <asp:Label ID="indicator" runat="server" Font-Bold="True" ForeColor="#CC6600" Text="Label" Visible="False"></asp:Label>
        </p>

    </form>
</body>
</html>
