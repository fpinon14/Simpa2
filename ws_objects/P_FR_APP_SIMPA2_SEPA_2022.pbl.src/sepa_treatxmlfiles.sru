HA$PBExportHeader$sepa_treatxmlfiles.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_treatXmlFiles from nonvisualobject
    end type
end forward

global type sepa_treatXmlFiles from nonvisualobject
end type

type variables
    string filesPath[]
    long treatmentType
    boolean treatmentTypeSpecified
end variables

on sepa_treatXmlFiles.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_treatXmlFiles.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

