HA$PBExportHeader$sepa_treattxtfile.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_treatTxtFile from nonvisualobject
    end type
end forward

global type sepa_treatTxtFile from nonvisualobject
end type

type variables
    string filePath
end variables

on sepa_treatTxtFile.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_treatTxtFile.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

