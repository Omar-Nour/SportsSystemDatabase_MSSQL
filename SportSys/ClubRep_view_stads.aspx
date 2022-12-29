<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClubRep_view_stads.aspx.cs" Inherits="SportSys.ClubRep_view_stads" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:Label ID="Sys_User_name" runat="server" Text="Viewing available stadiums as "></asp:Label>
            <br />
            <br />
            <br />

               <asp:TextBox ID="DateTimeBox" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="294px" TextMode="Date"></asp:TextBox>
        <asp:Button ID="userIn" runat="server" Text="Choose Date Time" OnClick="userInFunc" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="41px"   Width="135px"/>
        <asp:Button ID="currTimeStamp" runat="server" Text="From Current Time" OnClick="currTimeFunc" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="41px"   Width="135px"/>
        <p>

            <p>
            <asp:GridView ID="View_stads_view" runat="server" BorderStyle="Solid">
            <HeaderStyle BackColor="Black" BorderStyle="Solid" ForeColor="White" />
            <RowStyle BorderStyle="Solid" />
        </asp:GridView>
                </p>
            <p>
                <asp:Label ID="status" runat="server" Text="Label" Visible="false"></asp:Label>
                </p>
             <p>
          <asp:LinkButton ID="Back_to_main" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="BACK TO MAIN MENU" PostBackUrl="~/ClubRep.aspx"/>
       </p>


        </div>
    </form>
</body>
</html>
