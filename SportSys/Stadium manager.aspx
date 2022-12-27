<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Stadium manager.aspx.cs" Inherits="SportSys.Stadium_manager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
                <asp:Label runat="server" Text="welcome"></asp:Label>
            </br>
                        <asp:Label ID="UsernameLabel" runat="server" Text="Label" Font-Bold="True"></asp:Label>
            </br>
            <asp:Label runat="server" Text="view stadium info"></asp:Label>

             </br>
              <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>
                         </br>

            
                        <asp:Button ID="View" runat="server" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="41px" Text="VIEW" Width="135px" OnClick="Viewstad" />
             </br>
            <asp:Label runat="server" Text="view host requests"></asp:Label>
            </br>
            <asp:Button ID="hostreq" runat="server" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="41px" Text="VIEW Host request" Width="135px" OnClick="Viewhost" />
        </div>
        
    </form>
</body>
</html>
