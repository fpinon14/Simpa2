HA$PBExportHeader$sepa_treatxmlfileresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_treatXmlFileResponse from nonvisualobject
    end type
end forward

global type sepa_treatXmlFileResponse from nonvisualobject
end type

type variables
end variables

on sepa_treatXmlFileResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_treatXmlFileResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

