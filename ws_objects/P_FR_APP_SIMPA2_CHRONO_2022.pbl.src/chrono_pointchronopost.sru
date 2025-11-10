HA$PBExportHeader$chrono_pointchronopost.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type chrono_pointChronopost from nonvisualobject
    end type
end forward

global type chrono_pointChronopost from nonvisualobject
end type

type variables
    string adresse1
    string adresse2
    string adresse3
    string codePostal
    datetime dateArriveColis
    boolean dateArriveColisSpecified
    string horairesOuvertureDimanche
    string horairesOuvertureJeudi
    string horairesOuvertureLundi
    string horairesOuvertureMardi
    string horairesOuvertureMercredi
    string horairesOuvertureSamedi
    string horairesOuvertureVendredi
    string horairesOuverturesFormates
    string identifiantChronopost
    string localite
    string nomEnseigne
    string typeDePoint
end variables

on chrono_pointChronopost.create
call super::create
TriggerEvent( this, "constructor" )
end on

on chrono_pointChronopost.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

