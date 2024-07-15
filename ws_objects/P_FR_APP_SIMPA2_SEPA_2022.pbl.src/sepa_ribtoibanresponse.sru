HA$PBExportHeader$sepa_ribtoibanresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_ribToIbanResponse from nonvisualobject
    end type
end forward

global type sepa_ribToIbanResponse from nonvisualobject
end type

type variables
    sepa_iban ws_return
end variables

on sepa_ribToIbanResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_ribToIbanResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

