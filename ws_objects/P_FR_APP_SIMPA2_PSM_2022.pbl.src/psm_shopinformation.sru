HA$PBExportHeader$psm_shopinformation.sru
$PBExportComments$[VDOC18634]
forward
global type psm_shopinformation from nonvisualobject
end type
end forward

global type psm_shopinformation from nonvisualobject
end type
global psm_shopinformation psm_shopinformation

type variables
string shopId
String shopName
String address1
String address2
String zipCode
String city
String email
String longitude
String latitude
end variables

forward prototypes
public function string uf_getxmlvalue (string asxml, string astag)
public subroutine uf_fillfromxml (string asxml)
public function integer uf_parse (oleobject asxmldoc)
public subroutine uf_transforme_en_boutique_simpa2 ()
public function boolean splitchaine (ref string adresse1, ref string adresse2, string car)
end prototypes

public function string uf_getxmlvalue (string asxml, string astag);String sVal
String sNull

SetNull(sNull)

If Pos(asXml,"<" + asTag) <= 0 Then return sNull

asXml=Mid(asXml, Pos(asXml,"<" + asTag) + Len(asTag) + 1)

If Pos(asXml,">") <= 0 Then return sNull

asXml=Mid(asXml, Pos(asXml,">") + 1)

If Pos(asXml,"</" + asTag + ">") <= 0 Then return sNull

sVal=Left(asXml, Pos(asXml,"</" + asTag + ">") -1)

Return sVal
end function

public subroutine uf_fillfromxml (string asxml);String sVal

sVal=uf_getxmlvalue( asxml, "shopId")
if not isnull(sVal) Then
	shopId =sVal
End if

sVal=uf_getxmlvalue( asxml, "shopName")
if not isnull(sVal) Then
	shopName =sVal
End if

sVal=uf_getxmlvalue( asxml, "address1")
if not isnull(sVal) Then
	address1 =sVal
End if

sVal=uf_getxmlvalue( asxml, "address2")
if not isnull(sVal) Then
	address2 =sVal
End if

sVal=uf_getxmlvalue( asxml, "zipCode")
if not isnull(sVal) Then
	zipCode =sVal
End if

sVal=uf_getxmlvalue( asxml, "city")
if not isnull(sVal) Then
	city =sVal
End if

sVal=uf_getxmlvalue( asxml, "email")
if not isnull(sVal) Then
	email =sVal
End if

sVal=uf_getxmlvalue( asxml, "longitude")
if not isnull(sVal) Then
	longitude =sVal
End if

sVal=uf_getxmlvalue( asxml, "latitude")
if not isnull(sVal) Then
	latitude =sVal
End if

end subroutine

public function integer uf_parse (oleobject asxmldoc);OleObject xmlNode, xmlChildNode
Long lIndex
psm_shopInformation shop

xmlNode=asXmlDoc.getElementsByTagName("shopId")
if not isValid(xmlNode) Then Return -1

shopId=xmlNode.Item(0).Text

xmlNode=asXmlDoc.getElementsByTagName("shopName")
if isValid(xmlNode) Then 
	shopName=xmlNode.Item(0).Text
End if

xmlNode=asXmlDoc.getElementsByTagName("address1")
if isValid(xmlNode) Then 
	address1=xmlNode.Item(0).Text
End if

xmlNode=asXmlDoc.getElementsByTagName("address2")
if isValid(xmlNode) Then 
	address2=xmlNode.Item(0).Text
End if

xmlNode=asXmlDoc.getElementsByTagName("zipCode")
if isValid(xmlNode) Then 
	zipCode=xmlNode.Item(0).Text
End if

xmlNode=asXmlDoc.getElementsByTagName("city")
if isValid(xmlNode) Then 
	city=xmlNode.Item(0).Text
End if

xmlNode=asXmlDoc.getElementsByTagName("email")
if isValid(xmlNode) Then 
	email=xmlNode.Item(0).Text
End if

xmlNode=asXmlDoc.getElementsByTagName("longitude")
if isValid(xmlNode) Then 
	longitude=xmlNode.Item(0).Text
End if

xmlNode=asXmlDoc.getElementsByTagName("latitude")
if isValid(xmlNode) Then 
	latitude=xmlNode.Item(0).Text
End if

Return 1
end function

public subroutine uf_transforme_en_boutique_simpa2 ();n_cst_string nvString
string adresse1, adresse2
Boolean bOk

// shopId
if Left(shopId,2) = "FR" Then shopId=Mid(shopId,3)

// shopName
shopName=nvString.of_globalreplace(shopName,"Shop in shop PSM Welcom", "PSM")

if Left(Upper(shopName),21) ="POINT SERVICE MOBILES" Then shopName="PSM" + Mid(shopName,22)

// address1
if Len(address1) > 40 Then
	address1=nvString.of_globalreplace( address1, "Centre Commercial", "CC")
End if

If Left(address2,5) = "M$$HEX1$$e900$$ENDHEX$$tro" Then address2=""

if Len(address1) > 40 Then
		adresse1=address1
		bOk=false
		
		if Pos(adresse1,"-") > 0 Then bOk=splitChaine(adresse1, adresse2,"-")
		
		If (Not bOk) and  Pos(adresse1,",") > 0 And Pos(adresse1,",") < 10  Then bOk=splitChaine(adresse1, adresse2,",")
			
		If (Not bOk) and  Pos(adresse1," ") > 0  Then bOk=splitChaine(adresse1, adresse2," ")

		address1=Trim(adresse1)
		address2=Trim(adresse2) + " " + address2
End if

address2=Left(address2,40)
end subroutine

public function boolean splitchaine (ref string adresse1, ref string adresse2, string car);string adresses[]
string adr1tmp="",adr2tmp=""
int index=2
int i
n_cst_string nvstring


nvstring.of_parsetoarray ( adresse1, car, adresses)

adr1tmp = adresses[1];

Do  while (index <= UpperBound(adresses) and Len(Trim(adr1tmp + car + adresses[index])) <= 40)
  
		adr1tmp+= car + adresses[index]
		index++
	Loop

i=index
for  i = index to UpperBound(adresses)

	if (i > index) Then adr2tmp += car
	adr2tmp += adresses[i]
Next


if (Len(Trim(adr1tmp)) > 40 or Len(Trim(adr2tmp)) > 40) Then return false

adresse1 = Trim(adr1tmp)
adresse2 = Trim(adr2tmp)
  
  return true;
end function

on psm_shopinformation.create
call super::create
TriggerEvent( this, "constructor" )
end on

on psm_shopinformation.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

