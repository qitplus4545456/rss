Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Partial Class Bulletin
    Inherits System.Web.UI.Page

    Protected Sub DownloadFile(sender As Object, e As EventArgs)
        Dim idattachment As Integer = Integer.Parse(TryCast(sender, LinkButton).CommandArgument)
        Dim bytes As Byte()
        Dim fileName As String, contentType As String
        ' Dim constr As String
        Dim constr = ConfigurationManager.ConnectionStrings("ReplicationTConnectionString").ConnectionString
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand()
                cmd.CommandText = "select DocDes, DocImage,CASE WHEN documentst LIKE '%.%' THEN case when  RIGHT (DocumentSt , CHARINDEX('.' , REVERSE(DocumentSt)) - 1) like 'doc%' then 'application/msword' else  'application/' + RIGHT (DocumentSt , CHARINDEX('.' , REVERSE(DocumentSt)) - 1) end ELSE 'No Attachment' END as ContentType from CD_DocumentStorage_R  where idattachment=@Id"
                cmd.Parameters.AddWithValue("@Id", idattachment)
                cmd.Connection = con
                con.Open()
                Using sdr As SqlDataReader = cmd.ExecuteReader()
                    sdr.Read()
                    bytes = DirectCast(sdr("DocImage"), Byte())
                    contentType = sdr("ContentType").ToString()
                    fileName = sdr("DocDes").ToString()
                End Using
                con.Close()
            End Using
        End Using
        Response.Clear()
        Response.Buffer = True
        Response.Charset = ""
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.ContentType = contentType
        Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName)
        Response.BinaryWrite(bytes)
        Response.Flush()
        Response.End()
    End Sub
End Class
