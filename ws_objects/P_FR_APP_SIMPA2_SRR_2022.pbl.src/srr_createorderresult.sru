HA$PBExportHeader$srr_createorderresult.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
global type srr_createorderresult from srr_assuranceresult
end type
end forward

global type srr_createorderresult from srr_assuranceresult
end type
global srr_createorderresult srr_createorderresult

type variables
    string IdExterne
    string IdCommande
end variables

forward prototypes
public subroutine uf_fillfromxml (string asxml)
end prototypes

public subroutine uf_fillfromxml (string asxml);String sVal

super::uf_fillfromxml(asXml)

sVal=uf_getxmlvalue( asxml, "IdExterne")
if not isnull(sVal) Then
	IdExterne =sVal
End if

sVal=uf_getxmlvalue( asxml, "IdCommande")
if not isnull(sVal) Then
	IdCommande =sVal
End if


	

end subroutine

on srr_createorderresult.create
call super::create
end on

on srr_createorderresult.destroy
call super::destroy
end on

