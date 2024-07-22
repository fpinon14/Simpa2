HA$PBExportHeader$sepa_getcountryofrib.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_getCountryOfRib from nonvisualobject
    end type
end forward

global type sepa_getCountryOfRib from nonvisualobject
end type

type variables
    sepa_rib rib
end variables

on sepa_getCountryOfRib.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_getCountryOfRib.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

