HA$PBExportHeader$sepa_verifyiban.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_verifyIban from nonvisualobject
    end type
end forward

global type sepa_verifyIban from nonvisualobject
end type

type variables
    string iban
end variables

on sepa_verifyIban.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_verifyIban.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

