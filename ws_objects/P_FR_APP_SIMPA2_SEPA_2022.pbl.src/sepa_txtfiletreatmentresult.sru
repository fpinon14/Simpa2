HA$PBExportHeader$sepa_txtfiletreatmentresult.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_txtFileTreatmentResult from nonvisualobject
    end type
end forward

global type sepa_txtFileTreatmentResult from nonvisualobject
end type

type variables
end variables

on sepa_txtFileTreatmentResult.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_txtFileTreatmentResult.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

