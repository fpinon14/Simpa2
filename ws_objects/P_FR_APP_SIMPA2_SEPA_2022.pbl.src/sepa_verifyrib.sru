HA$PBExportHeader$sepa_verifyrib.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_verifyRib from nonvisualobject
    end type
end forward

global type sepa_verifyRib from nonvisualobject
end type

type variables
    sepa_rib rib
end variables

on sepa_verifyRib.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_verifyRib.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

