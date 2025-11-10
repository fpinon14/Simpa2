HA$PBExportHeader$cordon_inforesponse.sru
$PBExportComments$[DT288-1]
forward
global type cordon_inforesponse from nonvisualobject
end type
end forward

global type cordon_inforesponse from nonvisualobject
end type
global cordon_inforesponse cordon_inforesponse

type variables
string is_OK
string is_error
string is_operateur
string is_statut_garantie
boolean ib_isFmip
string is_statutFmip
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
Integer i

sVal=uf_getxmlvalue( asxml, "is_ok")
if not isnull(sVal) Then
	is_ok =sVal
End if

sVal=uf_getxmlvalue( asxml, "error")
if not isnull(sVal) Then
	is_error =sVal
End if

sVal=uf_getxmlvalue( asxml, "operateur")
if not isnull(sVal) Then
	is_operateur =sVal
End if

sVal=uf_getxmlvalue( asxml, "statut_garantie")
if not isnull(sVal) Then
	is_statut_garantie =sVal
End if

sVal=uf_getxmlvalue( asxml, "statut_fmip")
if not isnull(sVal) Then
	is_statutfmip =sVal
End if

sVal=uf_getxmlvalue( asxml, "is_fmip")
if not isnull(sVal) Then
	ib_isFmip=(sVal="true")
End if

end subroutine

on cordon_inforesponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on cordon_inforesponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

