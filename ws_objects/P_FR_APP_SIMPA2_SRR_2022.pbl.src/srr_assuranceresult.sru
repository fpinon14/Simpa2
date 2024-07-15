HA$PBExportHeader$srr_assuranceresult.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
global type srr_assuranceresult from nonvisualobject
end type
end forward

global type srr_assuranceresult from nonvisualobject
end type
global srr_assuranceresult srr_assuranceresult

type variables
    string ReturnCode // OK ou KO
    string ws_Message
end variables

forward prototypes
public function string uf_getxmlvalue (string asxml, string astag)
public subroutine uf_fillfromxml (string asxml)
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

sVal=uf_getxmlvalue( asxml, "ReturnCode")
if not isnull(sVal) Then
	ReturnCode =sVal
End if

sVal=uf_getxmlvalue( asxml, "Message")
if not isnull(sVal) Then
	ws_Message =sVal
End if
end subroutine

on srr_assuranceresult.create
call super::create
TriggerEvent( this, "constructor" )
end on

on srr_assuranceresult.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

