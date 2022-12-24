<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SAM view.aspx.cs" Inherits="SportSys.SAM_view" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="SAM_View" runat="server">

        <div>
            Welcome, <asp:Label ID="Sys_User_name" runat="server" Text=""></asp:Label>
          
        </div>

        <p>
          <asp:LinkButton ID="Add_Match" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="ADD NEW MATCH" PostBackUrl="~/SAM_Add_Match.aspx"/>
       </p>

         <p>
          <asp:LinkButton ID="Remove_Match" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="DELETE MATCHE(S)" PostBackUrl="~/SAM_Remove_Match.aspx"/>
       </p>

         <p>
          <asp:LinkButton ID="View_Upcoming" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="VIEW UPCOMING MATCHES" PostBackUrl="~/SAM_View_Upcoming.aspx"/>
       </p>

         <p>
          <asp:LinkButton ID="View_Past" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="VIEW OLD MATCHES" PostBackUrl="~/SAM_View_Upcoming.aspx"/>
       </p>

         <p>
          <asp:LinkButton ID="View_Unmatched" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="VIEW UNMATCHED CLUBS" />
       </p>
     </form>
</body>
</html>
