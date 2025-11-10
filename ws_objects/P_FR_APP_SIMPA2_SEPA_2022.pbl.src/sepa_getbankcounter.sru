HA$PBExportHeader$sepa_getbankcounter.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_getBankCounter from nonvisualobject
    end type
end forward

global type sepa_getBankCounter from nonvisualobject
end type

type variables
    string bankCode
    string counterCode
end variables

on sepa_getBankCounter.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_getBankCounter.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

