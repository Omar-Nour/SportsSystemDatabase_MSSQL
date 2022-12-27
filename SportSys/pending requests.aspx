<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pending requests.aspx.cs" Inherits="SportSys.pending_requests" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    
    <form id="form1" runat="server">
        <div>
                            <asp:Label runat="server" Text="Pending requests"></asp:Label>
            </br>
            
        

             <asp:GridView ID="Pendingreq2" runat="server" OnRowCommand="Pendingreq2_OnRowCommand" BorderStyle="Solid">
            <Columns>
                <asp:TemplateField ShowHeader="true" HeaderText="Reject">
                <ItemTemplate>
                    <asp:Button ID="Reject2" runat="server" BackColor="#CC3300" BorderStyle="Double" ForeColor="White" CommandName="reject"
                        Text="Reject" CommandArgument='<%#Eval("Host id")%>'/>
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
