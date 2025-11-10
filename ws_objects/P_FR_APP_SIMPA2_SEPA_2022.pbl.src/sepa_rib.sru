HA$PBExportHeader$sepa_rib.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_rib from nonvisualobject
    end type
end forward

global type sepa_rib from nonvisualobject
end type

type variables
    string cle
    string codeEtablissement
    string codeGuichet
    string numeroCompte
end variables

on sepa_rib.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_rib.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

