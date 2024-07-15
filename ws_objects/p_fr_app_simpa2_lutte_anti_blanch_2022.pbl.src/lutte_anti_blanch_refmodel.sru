HA$PBExportHeader$lutte_anti_blanch_refmodel.sru
forward
global type lutte_anti_blanch_refmodel from nonvisualobject
end type
end forward

global type lutte_anti_blanch_refmodel from nonvisualobject
end type
global lutte_anti_blanch_refmodel lutte_anti_blanch_refmodel

type variables
Int iiMaxMatchingScore

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

iiMaxMatchingScore=iSailjson.getattribute( "maxMatchingScore")
If IsNull ( iiMaxMatchingScore ) Then iiMaxMatchingScore = 0

end subroutine

public subroutine uf_fillfromjson (u_sailjson aojson);
iiMaxMatchingScore=aojson.getattribute( "maxMatchingScore")
If IsNull ( iiMaxMatchingScore ) Then iiMaxMatchingScore = 0

end subroutine

public function string uf_get_jsonstring (ref u_sailjson au_sailjson, string as_attribute);String sRet=""
Any laRet

laRet=au_sailjson.getAttribute(as_attribute)

if not isnull(laRet) Then sRet=laRet

Return sRet


end function

on lutte_anti_blanch_refmodel.create
call super::create
TriggerEvent( this, "constructor" )
end on

on lutte_anti_blanch_refmodel.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;iSailJson=CREATE u_sailjson

iiMaxMatchingScore=0

end event

