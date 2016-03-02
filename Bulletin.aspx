<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Bulletin.aspx.vb" Inherits="Bulletin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Guardian Public Bulletins</title>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7/leaflet.css" />
    <script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
    <script src="http://cdn.leafletjs.com/leaflet-0.7/leaflet.js"></script>
    <script src="http://maps.google.com/maps/api/js?v=3.2&sensor=false"></script>
     <!--<script src="//cdn.jsdelivr.net/leaflet.esri/2.0.0-beta.7/esri-leaflet.js"></script>
    <script src="includes/js/leaflet-google.js"></script>
	<!--https://github.com/shramov/leaflet-plugins/blob/master/layer/tile/Google.js -->
    <link rel="stylesheet" href="includes/css/style.css" />
    <script src="includes/js/esri-leaflet.js"></script>
    <script src="includes/js/leaflet-google.js"></script>
    <script src="includes/js/utilities.js"></script>
    <script src="includes/js/map-manager.js"></script>
    <script src="includes/js/map.js"></script>


</head>


<body>
    <form id="form1" runat="server">
    <div>
    
        <br />
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="5" CellSpacing="5" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" HeaderText="Guardian Command Public Bulletins" Height="50px" HorizontalAlign="Left" style="margin-right: 22px" Width="1000px" DataKeyNames="Councilid,id">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="DateAdded" HeaderText="Date Added" SortExpression="DateAdded" />
                <asp:BoundField DataField="BulletnTitle" HeaderText="Bulletin Title" SortExpression="BulletnTitle" />
                <asp:TemplateField HeaderText="Full Description" SortExpression="FullDescription">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FullDescription") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FullDescription") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("FullDescription") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="BulletinType" HeaderText="Bulletin Type" SortExpression="BulletinType" />
                <asp:BoundField DataField="ShortDesc" HeaderText="Short Description" SortExpression="ShortDesc" />
                <asp:BoundField DataField="DocDes" HeaderText="File Name" SortExpression="DocDes" />

                <asp:TemplateField ItemStyle-HorizontalAlign = "Left">
                    <ItemTemplate>
                     <asp:LinkButton ID="lnkDownload" runat="server" Text="Download" OnClick="DownloadFile"
                        CommandArgument='<%# Eval("idattachment")%>'></asp:LinkButton>
                    </ItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:TemplateField>

                <asp:BoundField DataField="X_Long" HeaderText="X_Long" SortExpression="X_Long" Visible="False" />
                <asp:BoundField DataField="Y_Lat" HeaderText="Y_Lat" SortExpression="Y_Lat" Visible="False" />
                <asp:BoundField DataField="idattachment" HeaderText="idattachment" SortExpression="idattachment" Visible="False" />

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
         <div id="map"></div>
    </form>
       
</body>
</html>
