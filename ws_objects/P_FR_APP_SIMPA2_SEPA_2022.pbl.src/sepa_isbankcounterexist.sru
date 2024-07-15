HA$PBExportHeader$sepa_isbankcounterexist.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_isBankCounterExist from nonvisualobject
    end type
end forward

global type sepa_isBankCounterExist from nonvisualobject
end type

type variables
    string bankCode
    string counterCode
end variables

on sepa_isBankCounterExist.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_isBankCounterExist.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

