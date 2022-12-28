<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClubRep.aspx.cs" Inherits="SportSys.REP_view" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="REP_view" runat="server">
        <div>

            <div>
            Welcome, <asp:Label ID="Sys_User_name" runat="server" Text=""></asp:Label>
                <br />
                <br />
        </div>



        </div>
        <asp:Label ID="Rep_club" runat="server" Text="CLUB NAME:"></asp:Label>
        <br />
        <br />
        <asp:Label ID="club_id" runat="server" Text="CLUB ID:"></asp:Label>
        <br />
        <br />
        <asp:Label ID="club_loc" runat="server" Text="CLUB LOCATION:"></asp:Label>
        <br />
        <br />
        <br />
        <br />
        <asp:Label ID="upcoming" runat="server" Text="UPCOMING MATCHES: "></asp:Label>
        <br />


        <asp:GridView ID="Upcoming_matches_view"  runat="server" BorderStyle="Solid">
            <HeaderStyle BackColor="Black" BorderStyle="Solid" ForeColor="White" />
            <RowStyle BorderStyle="Solid" />
        </asp:GridView>

        <br />
         <p>
          <asp:LinkButton ID="View_available_stadiums" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="View available stadiums" PostBackUrl="~/ClubRep_view_stads.aspx"/>
       </p>
        <p>
          <asp:LinkButton ID="Send_request" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="Send request to stadium manager" PostBackUrl="~/ClubRep_send_request.aspx"/>
       </p>

    </form>
</body>
</html>
