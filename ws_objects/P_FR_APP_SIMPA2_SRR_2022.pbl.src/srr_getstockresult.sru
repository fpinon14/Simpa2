HA$PBExportHeader$srr_getstockresult.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
global type srr_getstockresult from srr_assuranceresult
end type
end forward

global type srr_getstockresult from srr_assuranceresult
end type
global srr_getstockresult srr_getstockresult

type variables
    string IdExterne
    srr_GetStockResponseItem Items[]
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

// TODO : chaque item
end subroutine

on srr_getstockresult.create
call super::create
end on

on srr_getstockresult.destroy
call super::destroy
end on

