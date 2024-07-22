HA$PBExportHeader$spbsepa_verifybban.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type spbsepa_verifyBban from nonvisualobject
    end type
end forward

global type spbsepa_verifyBban from nonvisualobject
end type

type variables
    spbsepa_bban bban
end variables

on spbsepa_verifyBban.create
call super::create
TriggerEvent( this, "constructor" )
end on

on spbsepa_verifyBban.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

