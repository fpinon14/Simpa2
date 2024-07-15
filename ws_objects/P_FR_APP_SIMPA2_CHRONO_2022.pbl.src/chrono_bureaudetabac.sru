HA$PBExportHeader$chrono_bureaudetabac.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type chrono_bureauDeTabac from nonvisualobject
    end type
end forward

global type chrono_bureauDeTabac from nonvisualobject
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
    string identifiantChronopostPointA2PAS
    string localite
    string nomEnseigne
end variables

on chrono_bureauDeTabac.create
call super::create
TriggerEvent( this, "constructor" )
end on

on chrono_bureauDeTabac.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

