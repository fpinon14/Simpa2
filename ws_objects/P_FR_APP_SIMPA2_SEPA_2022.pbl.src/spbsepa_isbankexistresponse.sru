HA$PBExportHeader$spbsepa_isbankexistresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type spbsepa_isBankExistResponse from nonvisualobject
    end type
end forward

global type spbsepa_isBankExistResponse from nonvisualobject
end type

type variables
    boolean isExist
    boolean isExistSpecified
end variables

on spbsepa_isBankExistResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on spbsepa_isBankExistResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

