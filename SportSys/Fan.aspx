﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan.aspx.cs" Inherits="SportSys.Fan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        </div>
        <asp:GridView ID="MatchesGridView" runat="server">
        </asp:GridView>
    </form>
</body>
</html>
