HA$PBExportHeader$sepa_isbiccodeexistresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_isBicCodeExistResponse from nonvisualobject
    end type
end forward

global type sepa_isBicCodeExistResponse from nonvisualobject
end type

type variables
    boolean ws_return
    boolean returnSpecified
end variables

on sepa_isBicCodeExistResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_isBicCodeExistResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

