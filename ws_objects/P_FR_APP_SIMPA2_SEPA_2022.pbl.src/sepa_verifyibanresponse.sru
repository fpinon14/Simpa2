HA$PBExportHeader$sepa_verifyibanresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_verifyIbanResponse from nonvisualobject
    end type
end forward

global type sepa_verifyIbanResponse from nonvisualobject
end type

type variables
    boolean ws_return
    boolean returnSpecified
end variables

on sepa_verifyIbanResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_verifyIbanResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

