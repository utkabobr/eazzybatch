Option Explicit
'On Error Resume Next
 
Dim sIP
 
Sub XMLRequest(sQuery, objRemXML)
    Set objRemXML = CreateObject("Microsoft.XMLDOM")
    objRemXML.async = False
    objRemXML.Load (sQuery)
End Sub
 
 
Sub XMLParse(objRemXML, sNode, sRet)
    Dim objXMLret
    Set objXMLret = objRemXML.SelectSingleNode(sNode)
    If Err.Number <> 0 Then
        'MsgBox "Error of IPRange"
      Else
        If Not objXMLret Is Nothing Then sRet = objXMLret.Text
    End If
End Sub
 
 
Sub GetMyIP(sIP)
    Dim sQuery, objRemXML
 
    sQuery = "http://ip2country.sourceforge.net/ip2c.php?format=XML"
    Call XMLRequest(sQuery, objRemXML)
 
    'Get your IP-address
    Call XMLParse(objRemXML, "/lookup/ip", sIP)
    
    'if Sourceforge is Down
    If Len(sIP) = 0 Then
        Set objRemXML = Nothing
        
        sQuery = "http://wtfismyip.com/xml"
        Call XMLRequest(sQuery, objRemXML)
        
        Call XMLParse(objRemXML, "/wtf/your-fucking-ip-address", sIP) ':)
    End If
    
    Set objRemXML = Nothing
End Sub
 
'Here we go
Call GetMyIP(sIP)
 
WScript.Echo sIP