HA$PBExportHeader$sepa_verifyribresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_verifyRibResponse from nonvisualobject
    end type
end forward

global type sepa_verifyRibResponse from nonvisualobject
end type

type variables
    boolean ws_return
    boolean returnSpecified
end variables

on sepa_verifyRibResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_verifyRibResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

