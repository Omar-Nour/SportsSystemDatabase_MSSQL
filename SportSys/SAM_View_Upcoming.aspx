<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SAM_View_Upcoming.aspx.cs" Inherits="SportSys.SAM_Add_Match" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="View_Upcoming" runat="server">
        <div>
            VIEWING UPCOMING MATCHES AS <asp:Label ID="Upcoming_Sys_User_name" runat="server" Text=""></asp:Label></div>
        
        <div>

        </div>

          <p>
          <asp:LinkButton ID="Back_to_main" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="BACK TO MAIN MENU" PostBackUrl="~/SAM View.aspx"/>
       </p>
    </form>
</body>
</html>
