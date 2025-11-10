HA$PBExportHeader$srr_item.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
global type srr_item from nonvisualobject
end type
end forward

global type srr_item from nonvisualobject
end type
global srr_item srr_item

type variables
    string CodeSAP
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

sVal=uf_getxmlvalue( asxml, "CodeSAP")
if not isnull(sVal) Then
	CodeSAP =sVal
End if


end subroutine

on srr_item.create
call super::create
TriggerEvent( this, "constructor" )
end on

on srr_item.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

