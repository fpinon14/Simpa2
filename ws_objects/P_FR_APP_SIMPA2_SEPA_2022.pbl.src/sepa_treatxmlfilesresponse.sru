HA$PBExportHeader$sepa_treatxmlfilesresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_treatXmlFilesResponse from nonvisualobject
    end type
end forward

global type sepa_treatXmlFilesResponse from nonvisualobject
end type

type variables
end variables

on sepa_treatXmlFilesResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_treatXmlFilesResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

