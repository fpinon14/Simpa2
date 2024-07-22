HA$PBExportHeader$chrono_bureaudetabacavecpf.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type chrono_bureauDeTabacAvecPF from nonvisualobject
    end type
end forward

global type chrono_bureauDeTabacAvecPF from nonvisualobject
end type

type variables
    datetime periodeDeFermeture1Debut
    boolean periodeDeFermeture1DebutSpecified
    datetime periodeDeFermeture1Fin
    boolean periodeDeFermeture1FinSpecified
    datetime periodeDeFermeture2Debut
    boolean periodeDeFermeture2DebutSpecified
    datetime periodeDeFermeture2Fin
    boolean periodeDeFermeture2FinSpecified
    datetime periodeDeFermeture3Debut
    boolean periodeDeFermeture3DebutSpecified
    datetime periodeDeFermeture3Fin
    boolean periodeDeFermeture3FinSpecified
    double coordGeoLatitude
    double coordGeoLongitude
    string urlGoogleMaps
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

on chrono_bureauDeTabacAvecPF.create
call super::create
TriggerEvent( this, "constructor" )
end on

on chrono_bureauDeTabacAvecPF.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

