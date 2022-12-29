<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pendingrequesttest.aspx.cs" Inherits="SportSys.pendingrequesttest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
      
            

            <asp:Label runat="server" Text="Pending Requests"></asp:Label>

            </br>
            <asp:GridView ID="MatchesGridView" runat="server" OnRowCommand="MatchesGridView_OnRowCommand" BorderStyle="Solid">
            <Columns>
                <asp:TemplateField ShowHeader="true" HeaderText="Purchase Ticket">
                    <ItemTemplate>
                        <asp:Button ID="Reject2" runat="server" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" CommandName="Reject" 
                            Text="Reject" CommandArgument='<%#Eval("Host ID") %>'/>

                        <asp:Button ID="Accept2" runat="server" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" CommandName="Accept"
                            Text="Accept" CommandArgument='<%#Eval("Stadium manager")+";"+Eval("Host ID")%>'/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <HeaderStyle BackColor="Black" BorderStyle="Solid" ForeColor="White" />
            <RowStyle BorderStyle="Solid" />
        </asp:GridView>

        </div>
    </form>
</body>
</html>
