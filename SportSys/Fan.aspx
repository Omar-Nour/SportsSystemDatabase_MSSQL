<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan.aspx.cs" Inherits="SportSys.Fan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="UsernameLabel" runat="server" Text="Label" Font-Bold="True"></asp:Label>
            <br />
            <asp:Label ID="NIDLabel" runat="server" Text="Label" Font-Bold="True"></asp:Label>
        </div>
        <asp:TextBox ID="DateTimeBox" runat="server" BackColor="#CCCCCC" BorderStyle="Solid" Height="26px" Width="294px" TextMode="Date"></asp:TextBox>
        <asp:Button ID="userIn" runat="server" Text="Choose Date Time" OnClick="userInFunc" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="41px"   Width="135px"/>
        <asp:Button ID="currTimeStamp" runat="server" Text="From Current Time" OnClick="currTimeFunc" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" Height="41px"   Width="135px"/>
        <p>

        </p>
        <asp:GridView ID="MatchesGridView" runat="server" OnRowCommand="MatchesGridView_OnRowCommand" BorderStyle="Solid">
            <Columns>
                <asp:TemplateField ShowHeader="true" HeaderText="Purchase Ticket">
                <ItemTemplate>
                    <asp:Button ID="PurchaseTicket" runat="server" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" CommandName="getTicket"
                        Text="Purchase Ticket" CommandArgument='<%#Eval("Host Club") + ";" +Eval("Guest Club")+ ";" +Eval("Kick-Off Time")%>'/>
                </ItemTemplate>
        </asp:TemplateField>
            </Columns>
            <HeaderStyle BackColor="Black" BorderStyle="Solid" ForeColor="White" />
            <RowStyle BorderStyle="Solid" />
        </asp:GridView>
        <p>
        <asp:Label ID="PurchaseTicketLabel" runat="server" Text="Label" Font-Bold="True" ForeColor="#00FF00"></asp:Label>
        </p>
        <asp:Label ID="PurchaseHistoryLabel" runat="server" Text="Previously Purchased Tickets:" Font-Bold="True"></asp:Label>
        <asp:GridView ID="PurchaseHistoryGridView" runat="server" BorderStyle="Solid">
            <HeaderStyle BackColor="Black" BorderStyle="Solid" ForeColor="White" />
            <RowStyle BorderStyle="Solid" />
        </asp:GridView>
        <asp:Label ID="PurchaseHistoryExistsLabel" runat="server" Text="Label" Font-Bold="True" ForeColor="#FF0000"></asp:Label>
    </form>
</body>
</html>
