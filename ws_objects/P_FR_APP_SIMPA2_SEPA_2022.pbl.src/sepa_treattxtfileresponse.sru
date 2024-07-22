HA$PBExportHeader$sepa_treattxtfileresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_treatTxtFileResponse from nonvisualobject
    end type
end forward

global type sepa_treatTxtFileResponse from nonvisualobject
end type

type variables
    sepa_txtFileTreatmentResult txtFileTreatmentResult
end variables

on sepa_treatTxtFileResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_treatTxtFileResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

