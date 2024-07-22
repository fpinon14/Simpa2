HA$PBExportHeader$sepa_treatxmlfile.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_treatXmlFile from nonvisualobject
    end type
end forward

global type sepa_treatXmlFile from nonvisualobject
end type

type variables
    string filePath
end variables

on sepa_treatXmlFile.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_treatXmlFile.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

