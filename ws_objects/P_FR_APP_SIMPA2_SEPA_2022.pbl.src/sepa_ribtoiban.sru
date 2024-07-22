HA$PBExportHeader$sepa_ribtoiban.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_ribToIban from nonvisualobject
    end type
end forward

global type sepa_ribToIban from nonvisualobject
end type

type variables
    sepa_rib rib
end variables

on sepa_ribToIban.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_ribToIban.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

