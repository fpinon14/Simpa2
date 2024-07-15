HA$PBExportHeader$sepa_treatrepositoryfile.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_treatRepositoryFile from nonvisualobject
    end type
end forward

global type sepa_treatRepositoryFile from nonvisualobject
end type

type variables
    string filePath
end variables

on sepa_treatRepositoryFile.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_treatRepositoryFile.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

