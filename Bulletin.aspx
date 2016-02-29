<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Bulletin.aspx.vb" Inherits="Bulletin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Guardian Public Bulletins</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <br />
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="5" CellSpacing="5" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" HeaderText="Guardian Command Public Bulletins" Height="50px" HorizontalAlign="Left" style="margin-right: 22px" Width="1000px">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="ShortDesc" HeaderText="Short Desc" SortExpression="ShortDesc" />
                <asp:BoundField DataField="BulletnTitle" HeaderText="BulletinTitle" SortExpression="BulletnTitle" />
                <asp:BoundField DataField="FullDescription" HeaderText="Full Description" SortExpression="FullDescription" />
                <asp:BoundField DataField="DateAdded" HeaderText="Date Added" SortExpression="DateAdded" />
                <asp:BoundField DataField="BulletinType" HeaderText="Bulletin Type" SortExpression="BulletinType" />
                <asp:BoundField DataField="DocDes" HeaderText="Doc Des" SortExpression="DocDes" />
                <asp:BoundField DataField="DocImage" HeaderText="DocImage" SortExpression="DocImage" />
                <asp:BoundField DataField="FileDate" HeaderText="File Date" SortExpression="FileDate" />
                <asp:BoundField DataField="X_Long" HeaderText="X_Long" SortExpression="X_Long" />
                <asp:BoundField DataField="Y_Lat" HeaderText="Y_Lat" SortExpression="Y_Lat" />

                <asp:TemplateField HeaderText="DocImage" SortExpression="DocImage">
                    <ItemTemplate>
                        <asp:ImageButton ID="ibDownload" runat="server" CommandName="Download" CommandArgument='<%# Bind("path") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ReplicationTConnectionString %>" SelectCommand="A_RSS_BulletinFeed" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="0" Name="Councilid" QueryStringField="councilid" Type="Int32" />
                <asp:QueryStringParameter DefaultValue="0" Name="ArticleID" QueryStringField="ArticleID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
