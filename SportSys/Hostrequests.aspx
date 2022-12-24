<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Hostrequests.aspx.cs" Inherits="SportSys.Stadium_manager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form3" runat="server">
        <div>
                <asp:Label runat="server" Text="Host requests"></asp:Label>
            </br>
            <asp:Label runat="server" Text="Pending requests"></asp:Label>
            </br>
                        <asp:Button ID="pendreq" runat="server" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="41px" Text="VIEW pending request" Width="135px" OnClick="Viewpend" />

            

        </div>
        
    </form>
</body>
</html>
