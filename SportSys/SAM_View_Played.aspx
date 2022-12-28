<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SAM_View_Played.aspx.cs" Inherits="SportSys.SAM_View_Played" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="View_Past" runat="server">
        <div>

        <div>
            VIEWING PLAYED MATCHES AS <asp:Label ID="Played_Sys_User_name" runat="server" Text=""></asp:Label>
            <br />
              </div>

            <p>
            <asp:GridView ID="PurchaseHistoryGridView" runat="server" BorderStyle="Solid">
            <HeaderStyle BackColor="Black" BorderStyle="Solid" ForeColor="White" />
            <RowStyle BorderStyle="Solid" />
        </asp:GridView>
                </p>

            <p>
          <asp:LinkButton ID="Back_to_main" style="text-align:center" Font-Underline="false" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" runat="server" Width="325px" Text="BACK TO MAIN MENU" PostBackUrl="~/SAM View.aspx"/>
       </p>


        </div>
    </form>
</body>
</html>
