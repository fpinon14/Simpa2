HA$PBExportHeader$spbsepa_verifybbanresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type spbsepa_verifyBbanResponse from nonvisualobject
    end type
end forward

global type spbsepa_verifyBbanResponse from nonvisualobject
end type

type variables
    boolean isValid
    boolean isValidSpecified
end variables

on spbsepa_verifyBbanResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on spbsepa_verifyBbanResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

