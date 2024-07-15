HA$PBExportHeader$sepa_ibantoribresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_ibanToRibResponse from nonvisualobject
    end type
end forward

global type sepa_ibanToRibResponse from nonvisualobject
end type

type variables
    sepa_rib ws_return
end variables

on sepa_ibanToRibResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_ibanToRibResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

