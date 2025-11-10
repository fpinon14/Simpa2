HA$PBExportHeader$sepa_iban.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_iban from nonvisualobject
    end type
end forward

global type sepa_iban from nonvisualobject
end type

type variables
    string bic
    string iban1
end variables

on sepa_iban.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_iban.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

