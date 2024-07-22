HA$PBExportHeader$sepa_treatrepositoryfileresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_treatRepositoryFileResponse from nonvisualobject
    end type
end forward

global type sepa_treatRepositoryFileResponse from nonvisualobject
end type

type variables
    boolean processSuccess
end variables

on sepa_treatRepositoryFileResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_treatRepositoryFileResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

