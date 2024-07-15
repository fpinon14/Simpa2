HA$PBExportHeader$chrono_tourneeresult.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type chrono_tourneeResult from nonvisualobject
    end type
end forward

global type chrono_tourneeResult from nonvisualobject
end type

type variables
    long errorCode
    string errorMessage
    chrono_tournee tournee
end variables

on chrono_tourneeResult.create
call super::create
TriggerEvent( this, "constructor" )
end on

on chrono_tourneeResult.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

