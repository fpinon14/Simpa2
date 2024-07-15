HA$PBExportHeader$sepa_getbankcounterresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_getBankCounterResponse from nonvisualobject
    end type
end forward

global type sepa_getBankCounterResponse from nonvisualobject
end type

type variables
    sepa_bankCounter ws_return
end variables

on sepa_getBankCounterResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_getBankCounterResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

