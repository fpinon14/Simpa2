HA$PBExportHeader$sepa_ibantorib.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_ibanToRib from nonvisualobject
    end type
end forward

global type sepa_ibanToRib from nonvisualobject
end type

type variables
    sepa_iban iban
end variables

on sepa_ibanToRib.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_ibanToRib.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

