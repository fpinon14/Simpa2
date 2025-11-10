HA$PBExportHeader$chrono_tourneecomplete.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type chrono_tourneeComplete from nonvisualobject
    end type
end forward

global type chrono_tourneeComplete from nonvisualobject
end type

type variables
    string codeTourneeMaitre
    string codeTypeTournee
    string coutMensuelBatiment
    string cubage
    string cubageDistri
    string detailPrestation
    string heureTheoriqueRetour
    string idMoyenPropre
    string idSecteur
    string idSousTraitant
    string idVehicule
    string picking
    string planDistri
    string posteComptable
    string pourcentageCoChargement
    string qualification
    string spot
    string trigrammeAgence
    string typeTournee
    string zone
    string code
    boolean localise
    string ws_type
end variables

on chrono_tourneeComplete.create
call super::create
TriggerEvent( this, "constructor" )
end on

on chrono_tourneeComplete.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

