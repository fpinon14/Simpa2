HA$PBExportHeader$srr_identifymobileresult.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
global type srr_identifymobileresult from srr_assuranceresult
end type
end forward

global type srr_identifymobileresult from srr_assuranceresult
end type
global srr_identifymobileresult srr_identifymobileresult

type variables
    string Marque
    string Modele
    string CodeSAP
    real PrixNuTTC
    string ws_Type // "TerminalMobile" ou "Tablette"
    datetime DateAchat
end variables
forward prototypes
public subroutine uf_fillfromxml (string asxml)
end prototypes

public subroutine uf_fillfromxml (string asxml);String sVal

super::uf_fillfromxml(asXml)

sVal=uf_getxmlvalue( asxml, "CodeSAP")
if not isnull(sVal) Then
	CodeSAP =sVal
End if

sVal=uf_getxmlvalue( asxml, "Marque")
if not isnull(sVal) Then
	Marque =sVal
End if

sVal=uf_getxmlvalue( asxml, "Modele")
if not isnull(sVal) Then
	Modele =sVal
End if

sVal=uf_getxmlvalue( asxml, "Type")
if not isnull(sVal) Then
	ws_Type =sVal
End if

sVal=uf_getxmlvalue( asxml, "PrixNuTTC")
if not isnull(sVal) Then
	PrixNuTTC =Dec(sVal)
End if

/* DateAchat : YYYY-MM-DDThh:mm:ss*/
sVal=uf_getxmlvalue( asxml, "DateAchat")
if not isnull(sVal) Then	
	DateAchat =DateTime( Date(Left(sVal,10)) , Time(Right(sVal,8)) )
End if

end subroutine

on srr_identifymobileresult.create
call super::create
end on

on srr_identifymobileresult.destroy
call super::destroy
end on

