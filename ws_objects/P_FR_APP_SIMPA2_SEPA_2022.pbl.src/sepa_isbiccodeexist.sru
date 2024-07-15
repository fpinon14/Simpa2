HA$PBExportHeader$sepa_isbiccodeexist.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_isBicCodeExist from nonvisualobject
    end type
end forward

global type sepa_isBicCodeExist from nonvisualobject
end type

type variables
    string bic
end variables

on sepa_isBicCodeExist.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_isBicCodeExist.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

