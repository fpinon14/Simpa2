HA$PBExportHeader$chrono_tourneecompleteresult.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type chrono_tourneeCompleteResult from nonvisualobject
    end type
end forward

global type chrono_tourneeCompleteResult from nonvisualobject
end type

type variables
    long errorCode
    string errorMessage
    chrono_tourneeComplete tourneeComplete
end variables

on chrono_tourneeCompleteResult.create
call super::create
TriggerEvent( this, "constructor" )
end on

on chrono_tourneeCompleteResult.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

