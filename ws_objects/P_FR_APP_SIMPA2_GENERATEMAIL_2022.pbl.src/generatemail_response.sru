HA$PBExportHeader$generatemail_response.sru
forward
global type generatemail_response from nonvisualobject
end type
end forward

global type generatemail_response from nonvisualobject
end type
global generatemail_response generatemail_response

type variables
Long status
string smessage
string technicalCode

Long businessId
string keyMessageType
string idPli
string blobCode
string idKslDocument
string comment
string description
string direction
string requestDate


generatemail_refmodel refSwapTransport
generatemail_refmodel refDocumentReceptionStatus
generatemail_refmodel refLabelMail

u_sailjson iSailJson
end variables

forward prototypes
public subroutine uf_fillfromjson (string asjson)
public function string uf_get_jsonstring (ref u_sailjson au_sailjson, string as_attribute)
end prototypes

public subroutine uf_fillfromjson (string asjson);
String sVal
Integer i
Any iaRet
u_sailjson uParam

iSailjson=CREATE u_sailjson

iSailjson.parse(asjson)

iaRet=iSailjson.getattribute("status")
if not isnull(iaRet) Then status=iaRet

smessage=uf_get_jsonstring(iSailjson, "message")

technicalCode=uf_get_jsonstring(iSailjson, "technicalCode")

iaRet=iSailjson.getattribute("businessId")
if not isnull(iaRet) Then businessId=iaRet

keyMessageType=uf_get_jsonstring(iSailjson, "keyMessageType")

idPli=uf_get_jsonstring(iSailjson, "idPli")
blobCode=uf_get_jsonstring(iSailjson, "blobCode")
idKslDocument=uf_get_jsonstring(iSailjson, "idKslDocument")

comment=uf_get_jsonstring(iSailjson, "comment")

description=uf_get_jsonstring(iSailjson, "description")
direction=uf_get_jsonstring(iSailjson, "direction")
requestDate=uf_get_jsonstring(iSailjson, "requestDate")

iaRet = iSailjson.getattribute("refSwapTransport")
if not isNull(iaRet) Then
	refSwapTransport=CREATE generatemail_refmodel
	uParam=iaRet
	refSwapTransport.uf_fillfromjson( uParam)
End if

iaRet = iSailjson.getattribute("refDocumentReceptionStatus")
if not isNull(iaRet) Then
	refDocumentReceptionStatus=CREATE generatemail_refmodel
	uParam=iaRet
	refDocumentReceptionStatus.uf_fillfromjson( uParam)
End if

iaRet = iSailjson.getattribute("refLabelMail")
if not isNull(iaRet) Then
	refLabelMail=CREATE generatemail_refmodel
	uParam=iaRet
	refLabelMail.uf_fillfromjson( uParam)
End if

end subroutine

public function string uf_get_jsonstring (ref u_sailjson au_sailjson, string as_attribute);String sRet=""
Any laRet

laRet=au_sailjson.getAttribute(as_attribute)

if not isnull(laRet) Then sRet=laRet

Return sRet


end function

on generatemail_response.create
call super::create
TriggerEvent( this, "constructor" )
end on

on generatemail_response.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;status=0
smessage=""
technicalCode=""

businessId=0
keyMessageType=""
idPli=""
blobCode=""
idKslDocument=""
comment=""
description=""
direction=""
requestDate=""


SetNull(refSwapTransport)
SetNull(refDocumentReceptionStatus)
SetNull(refLabelMail)
end event

