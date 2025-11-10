HA$PBExportHeader$chrono_pointchrresult.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type chrono_pointCHRResult from nonvisualobject
    end type
end forward

global type chrono_pointCHRResult from nonvisualobject
end type

type variables
    long errorCode
    string errorMessage
    chrono_pointCHR listePointRelais[]
    long qualiteReponse
    string wsRequestId
end variables

on chrono_pointCHRResult.create
call super::create
TriggerEvent( this, "constructor" )
end on

on chrono_pointCHRResult.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

