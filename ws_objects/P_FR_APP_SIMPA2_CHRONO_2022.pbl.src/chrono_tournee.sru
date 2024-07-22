HA$PBExportHeader$chrono_tournee.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type chrono_tournee from nonvisualobject
    end type
end forward

global type chrono_tournee from nonvisualobject
end type

type variables
    string code
    boolean localise
    string ws_type
end variables

on chrono_tournee.create
call super::create
TriggerEvent( this, "constructor" )
end on

on chrono_tournee.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

