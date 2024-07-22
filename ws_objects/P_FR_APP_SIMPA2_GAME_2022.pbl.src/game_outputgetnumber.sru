HA$PBExportHeader$game_outputgetnumber.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type game_OutPutGetNumber from nonvisualobject
    end type
end forward

global type game_OutPutGetNumber from nonvisualobject
end type

type variables
    string NumPolicy
    string NumBon
    string Operation
    string RetourMsg
end variables

on game_OutPutGetNumber.create
call super::create
TriggerEvent( this, "constructor" )
end on

on game_OutPutGetNumber.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

