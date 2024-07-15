HA$PBExportHeader$srr_cancelorderresult.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
global type srr_cancelorderresult from srr_assuranceresult
end type
end forward

global type srr_cancelorderresult from srr_assuranceresult
end type
global srr_cancelorderresult srr_cancelorderresult

type variables
 
end variables

on srr_cancelorderresult.create
call super::create
TriggerEvent( this, "constructor" )
end on

on srr_cancelorderresult.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

