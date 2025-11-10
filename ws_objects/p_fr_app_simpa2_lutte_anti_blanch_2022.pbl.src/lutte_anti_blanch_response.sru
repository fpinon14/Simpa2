HA$PBExportHeader$lutte_anti_blanch_response.sru
forward
global type lutte_anti_blanch_response from nonvisualobject
end type
end forward

global type lutte_anti_blanch_response from nonvisualobject
end type
global lutte_anti_blanch_response lutte_anti_blanch_response

type variables


lutte_anti_blanch_refmodel uoRefRisk

u_sailjson iSailJson
end variables

forward prototypes
public subroutine uf_fillfromjson (string asjson)
public function string uf_get_jsonstring (ref u_sailjson au_sailjson, string as_attribute)
end prototypes

public subroutine uf_fillfromjson (string asjson);
String sVal
Integer i
Any iaRet[]
u_sailjson uParam

iSailjson=CREATE u_sailjson

iSailjson.parse(asjson)

iaRet = iSailjson.getattribute("risks")


if Upperbound (iaRet) > 0 Then
	uoRefRisk = CREATE lutte_anti_blanch_refmodel
	uParam=iaRet[1]
	uoRefRisk.uf_fillfromjson ( uParam )
End if



end subroutine

public function string uf_get_jsonstring (ref u_sailjson au_sailjson, string as_attribute);String sRet=""
Any laRet

laRet=au_sailjson.getAttribute(as_attribute)

if not isnull(laRet) Then sRet=laRet

Return sRet


end function

on lutte_anti_blanch_response.create
call super::create
TriggerEvent( this, "constructor" )
end on

on lutte_anti_blanch_response.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;

SetNull(uoRefRisk)
end event

