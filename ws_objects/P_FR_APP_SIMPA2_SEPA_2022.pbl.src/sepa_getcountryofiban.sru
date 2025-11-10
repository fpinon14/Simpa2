HA$PBExportHeader$sepa_getcountryofiban.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_getCountryOfIban from nonvisualobject
    end type
end forward

global type sepa_getCountryOfIban from nonvisualobject
end type

type variables
    sepa_iban iban
end variables

on sepa_getCountryOfIban.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_getCountryOfIban.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

