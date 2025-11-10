HA$PBExportHeader$psm_psmdataresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
global type psm_psmdataresponse from nonvisualobject
end type
end forward

global type psm_psmdataresponse from nonvisualobject
end type
global psm_psmdataresponse psm_psmdataresponse

type variables
    string centralisation
    string proximity1
    string proximity2
	 psm_shopInformation shopInfos[]
end variables

forward prototypes
public function string uf_getxmlvalue (string asxml, string astag)
public subroutine uf_fillfromxml (string asxml)
public function psm_shopinformation uf_getshopinformation (string asshopid)
public function string uf_getproximites ()
public function integer uf_parse (oleobject asxmldoc)
end prototypes

public function string uf_getxmlvalue (string asxml, string astag);String sVal
String sNull

SetNull(sNull)

If Pos(asXml,"<" + asTag + ">" ) <= 0 Then return sNull

asXml=Mid(asXml, Pos(asXml,"<" + asTag + ">" ) + Len(asTag) + 2)

/*If Pos(asXml,">") <= 0 Then return sNull

asXml=Mid(asXml, Pos(asXml,">") + 1)
*/

If Pos(asXml,"</" + asTag + ">") <= 0 Then return sNull

sVal=Left(asXml, Pos(asXml,"</" + asTag + ">") -1)

Return sVal
end function

public subroutine uf_fillfromxml (string asxml);String sVal
Integer i

sVal=uf_getxmlvalue( asxml, "centralisation")
if not isnull(sVal) Then
	centralisation =sVal
End if

sVal=uf_getxmlvalue( asxml, "proximity1")
if not isnull(sVal) Then
	proximity1 =sVal
End if

sVal=uf_getxmlvalue( asxml, "proximity2")
if not isnull(sVal) Then
	proximity2 =sVal
End if

i=1
Do While Pos(asXml,"<shopInformation>") > 0
	sVal=uf_getxmlvalue( asxml, "shopInformation")
	shopInfos[i]=CREATE psm_shopinformation
	shopInfos[i].uf_fillfromxml(sVal)
	asXml=Mid(asXml, Pos(asXml,"</shopInformation>") -1 + Len("</shopInformation>"))
	i++
Loop

end subroutine

public function psm_shopinformation uf_getshopinformation (string asshopid);psm_shopinformation shopInfo
Long lIndex

SetNull(shopInfo)

if UpperBound(shopInfos) > 0 Then
	for lIndex=1 To UpperBound(shopInfos)
		if asShopId=shopInfos[lIndex].shopId Then
			shopInfo=shopInfos[lIndex]
		End if
	Next
End if

return shopInfo

end function

public function string uf_getproximites ();String sRet=""

If not isnull(proximity1) and proximity1 <> "" Then
	sRet="#" + proximity1
End if

If not isnull(proximity2) and proximity2 <> "" Then
	sRet+="#" + proximity2
End if

if sRet <> "" Then sRet+="#"

Return sRet
end function

public function integer uf_parse (oleobject asxmldoc);OleObject xmlNode, xmlChildNode
Long lIndex
psm_shopInformation shop

xmlNode=asXmlDoc.getElementsByTagName("centralisation")
if not isValid(xmlNode) Then Return -1

centralisation=xmlNode.Item(0).Text

xmlNode=asXmlDoc.getElementsByTagName("proximity1")
if isValid(xmlNode) Then 
	proximity1=xmlNode.Item(0).Text
End if

xmlNode=asXmlDoc.getElementsByTagName("proximity2")
if isValid(xmlNode) Then 
	proximity1=xmlNode.Item(0).Text
End if

xmlNode=asXmlDoc.getElementsByTagName("shopInformation")

If isValid(xmlNode) Then
	For lIndex=0 to  xmlNode.length - 1
		shop=CREATE psm_shopinformation
		xmlChildNode=xmlNode.item(lIndex)
		shop.uf_parse(xmlChildNode) 
		shopInfos[lIndex + 1]=shop
	Next
End if

Return 1

end function

on psm_psmdataresponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on psm_psmdataresponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

