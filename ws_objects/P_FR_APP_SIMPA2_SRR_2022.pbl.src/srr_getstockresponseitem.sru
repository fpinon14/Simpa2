HA$PBExportHeader$srr_getstockresponseitem.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
global type srr_getstockresponseitem from srr_item
end type
end forward

global type srr_getstockresponseitem from srr_item
end type
global srr_getstockresponseitem srr_getstockresponseitem

type variables
    string Dispo  // OK ou KO
    string Marque
    string Modele
end variables

forward prototypes
public subroutine uf_fillfromxml (string asxml)
end prototypes

public subroutine uf_fillfromxml (string asxml);String sVal

super::uf_fillfromxml(asXml)

sVal=uf_getxmlvalue( asxml, "Dispo")
if not isnull(sVal) Then
	Dispo =sVal
End if

sVal=uf_getxmlvalue( asxml, "Marque")
if not isnull(sVal) Then
	Marque =sVal
End if

sVal=uf_getxmlvalue( asxml, "Modele")
if not isnull(sVal) Then
	Modele =sVal
End if
end subroutine

on srr_getstockresponseitem.create
call super::create
end on

on srr_getstockresponseitem.destroy
call super::destroy
end on

