HA$PBExportHeader$generatemail_refmodel.sru
$PBExportComments$ReferentialModel
forward
global type generatemail_refmodel from nonvisualobject
end type
end forward

global type generatemail_refmodel from nonvisualobject
end type
global generatemail_refmodel generatemail_refmodel

type variables
String businessId
String longLabel
String localizedLongLabel
String specialAttributes

u_sailjson iSailJson
end variables

forward prototypes
public subroutine uf_fillfromjson (string asjson)
public subroutine uf_fillfromjson (u_sailjson aojson)
public function string uf_get_jsonstring (ref u_sailjson au_sailjson, string as_attribute)
end prototypes

public subroutine uf_fillfromjson (string asjson);String sVal
Integer i
Any iaRet
u_sailjson uParam

iSailjson=CREATE u_sailjson

iSailjson.parse(asjson)

businessId=uf_get_jsonstring( iSailJson, "businessId")
longLabel=uf_get_jsonstring( iSailJson, "longLabel")
localizedlonglabel=uf_get_jsonstring( iSailJson, "localizedlonglabel")
specialAttributes=uf_get_jsonstring( iSailJson, "specialAttributes")



end subroutine

public subroutine uf_fillfromjson (u_sailjson aojson);businessId=aojson.getattribute( "businessId")
longLabel=aojson.getattribute( "longLabel")
localizedLongLabel=aojson.getattribute( "localizedLongLabel")
specialAttributes=aojson.getattribute( "specialAttributes")
end subroutine

public function string uf_get_jsonstring (ref u_sailjson au_sailjson, string as_attribute);String sRet=""
Any laRet

laRet=au_sailjson.getAttribute(as_attribute)

if not isnull(laRet) Then sRet=laRet

Return sRet


end function

on generatemail_refmodel.create
call super::create
TriggerEvent( this, "constructor" )
end on

on generatemail_refmodel.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;iSailJson=CREATE u_sailjson

businessid=""
longLabel=""
localizedLongLabel=""
specialAttributes=""
end event

