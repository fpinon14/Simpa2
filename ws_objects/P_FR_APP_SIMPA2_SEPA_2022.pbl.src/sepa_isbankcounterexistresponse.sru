HA$PBExportHeader$sepa_isbankcounterexistresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_isBankCounterExistResponse from nonvisualobject
    end type
end forward

global type sepa_isBankCounterExistResponse from nonvisualobject
end type

type variables
    boolean ws_return
    boolean returnSpecified
end variables

on sepa_isBankCounterExistResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_isBankCounterExistResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

