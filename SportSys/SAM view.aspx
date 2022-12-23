<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SAM view.aspx.cs" Inherits="SportSys.SAM_view" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Welcome, [SAM name]<br />
            <br />
        </div>

        <p>
          <asp:Button ID="Add_Match"  BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="ADD NEW MATCH" />
       </p>

         <p>
          <asp:Button ID="Remove_Match"  BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="DELETE MATCHE(S)" />
       </p>

         <p>
          <asp:Button ID="View_Upcoming"  BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="VIEW UPCOMING MATCHES" />
       </p>

         <p>
          <asp:Button ID="View_Past"  BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="VIEW OLD MATCHES" />
       </p>

         <p>
          <asp:Button ID="View_Unmatched"  BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="VIEW UNMATCHED CLUBS" />
       </p>
     
</body>
</html>
