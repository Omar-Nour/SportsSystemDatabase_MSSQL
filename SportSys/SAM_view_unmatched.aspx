<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SAM_view_unmatched.aspx.cs" Inherits="SportSys.SAM_view_unmatched" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

                   VIEWING UNMATCHED CLUBS AS <asp:Label ID="Unmatched_User_name" runat="server" Text=""></asp:Label>
            <br />
            <br />

             <p>
            <asp:GridView ID="View_played_view" runat="server" BorderStyle="Solid">
            <HeaderStyle BackColor="Black" BorderStyle="Solid" ForeColor="White" />
            <RowStyle BorderStyle="Solid" />
        </asp:GridView>
                </p>


            <p>
          <asp:LinkButton ID="Back_to_main" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="BACK TO MAIN MENU" PostBackUrl="~/SAM View.aspx"/>
       </p>
                 <asp:Label ID="Status" runat="server" Text="Label" Visible = "false" ></asp:Label>

        </div>
    </form>
</body>
</html>
