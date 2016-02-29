Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Text
Imports System.Web
Imports System.Xml

Partial Class rssFeed
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Response.Clear()
        Response.ContentType = "text/xml"
        Dim objX As New XmlTextWriter(Response.OutputStream, Encoding.UTF8)
        Dim cid As String = Request.QueryString("Councilid")

        objX.WriteStartDocument()
        objX.WriteStartElement("rss")
        objX.WriteAttributeString("version", "2.0")
        objX.WriteStartElement("channel")
        objX.WriteElementString("title", "Guardian Public Bulletins")
        objX.WriteElementString("link", "http://www.training.guardiancommand.com")
        objX.WriteElementString("description", "The latest Public Bulletins from Guardian Command.")
        objX.WriteElementString("ttl", "5")


        Dim objConnection As New SqlConnection(ConfigurationManager.ConnectionStrings("ReplicationT").ToString)
        objConnection.Open()
        Dim sql As String = "SELECT  CD_Attachments_R.BulletnTitle as title,CD_Attachments_R.FullDescription as description, CD_Attachments_R.id as ArticleID, CD_Attachments_R.Date_ST as pubDate,CD_Attachments_R.Authorised,CD_Attachments_R.Councilid, CD_Attachments_R.X_Long, CD_Attachments_R.Y_Lat, CD_Attachments_R.BulletinType, CD_Attachments_R.ShortDesc,CD_DocumentStorage_R.DocDes,CD_DocumentStorage_R.DocImage, CD_DocumentStorage_R.FileDate FROM CD_DocumentStorage_R INNER JOIN CD_Attachments_R ON CD_DocumentStorage_R.idattachment = CD_Attachments_R.idb WHERE(CD_Attachments_R.Authorised = 1) and CD_Attachments_R.councilid=" & cid
        'Dim sql As String = "SELECT * FROM tblArticles"
        Dim objCommand As New SqlCommand(sql, objConnection)
        Dim objReader As SqlDataReader = objCommand.ExecuteReader()


        While objReader.Read()
            objX.WriteStartElement("item")
            objX.WriteElementString("title", objReader.GetString(0))
            objX.WriteElementString("description", objReader.GetString(1))
            objX.WriteElementString("link", "http://training.qitplus.com/rss/Bulletin.aspx?Councilid=" & cid & "&ArticleID=" & CStr(objReader.GetInt32(2)))
            objX.WriteElementString("pubDate", objReader.GetDateTime(3).ToString("R"))
            objX.WriteEndElement()
        End While


        objReader.Close()
        objConnection.Close()

        objX.WriteEndElement()
        objX.WriteEndElement()
        objX.WriteEndDocument()
        objX.Flush()
        objX.Close()
        Response.End()

    End Sub
End Class
