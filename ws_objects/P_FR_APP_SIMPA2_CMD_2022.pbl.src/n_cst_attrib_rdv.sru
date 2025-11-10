HA$PBExportHeader$n_cst_attrib_rdv.sru
$PBExportComments$[FNAC_PROD_ECH_TECH] Objet attribut pour la prise de rendez-vous. Utilis$$HEX2$$e9002000$$ENDHEX$$par :
forward
global type n_cst_attrib_rdv from nonvisualobject
end type
end forward

global type n_cst_attrib_rdv from nonvisualobject
end type
global n_cst_attrib_rdv n_cst_attrib_rdv

type variables
// [FNAC_PROD_ECH_TECH] Objet attribut de passage de parametre pour prise de rendez-vous.
public:
// Donn$$HEX1$$e900$$ENDHEX$$e de plannification, au niveau jour
Datetime	dtDteHeuRef					// Date/heure de r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence
integer	iNbreRdvADemander			// Nombre de rdv obligatoire $$HEX2$$e0002000$$ENDHEX$$faire saisir par l'utilisateur
integer 	iAjoutNbHeuPremierRDV	// Nbre d'heure $$HEX2$$e0002000$$ENDHEX$$ajouter $$HEX2$$e0002000$$ENDHEX$$la date de r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour proposer le 1er RDV
string		sMsg							// message $$HEX2$$e0002000$$ENDHEX$$afficher dans la fenetre. ( Optionnel )
Boolean	bAnnulerAutorise			// True ( default) Bouton annuler et menu system autoris$$HEX1$$e900$$ENDHEX$$.
Boolean	bJFerie						// True : Propose les rdv les jours f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$s; False : Ne Propose les rdv les jours f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$s
integer	iRdvAutoriseMemeJournee	// Nombre de rdv autoris$$HEX1$$e900$$ENDHEX$$s dans la m$$HEX1$$ea00$$ENDHEX$$me journ$$HEX1$$e900$$ENDHEX$$e.
Integer	iNbreJourCalendaireMax	// Permet de calculer la date de fin maxi propos$$HEX2$$e9002000$$ENDHEX$$: Dte_Ref + iNbreJourCalendaireMax

// Donn$$HEX1$$e900$$ENDHEX$$es de plannification, au niveau heure : [MSS_DIAG]
// Soient pr$$HEX1$$e900$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$finie :
boolean 	bGenerationForcee			// Indique que la d$$HEX1$$e900$$ENDHEX$$finiton des plage est celle indiqu$$HEX1$$e900$$ENDHEX$$e dans le tableau sTbDefinitionGenforcee
string		sTbDefinitionGenforcee[7]   //Chaque $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment de tableu indique un jour : Element 1 = Lundi.
												// forme de chaque chaine"plage1;plage2...." avec plage = hh:mm-hh-mm

// Soient Calcul$$HEX1$$e900$$ENDHEX$$e : 
time		tHeuMiniRdv				// Heure minimum pour RDV
time		tHeuMaxiRdv				// Heure maximum pour RDV
Integer	iIncrRdvMinute				// Pas d'incr$$HEX1$$e900$$ENDHEX$$mentation en minute pour proposer les rdv : pas 60mn sur 08-12 donne 09-13
Integer	iIncrRdvDate				// Pas d'incr$$HEX1$$e900$$ENDHEX$$mentation en jour pour proposer les rdv : pas 3 sur 17/10 donne 20/10
Integer  iNbMinuteParPlageHoraire// Nombre de minutes par plage horaire : 4h donne 08-12.
Boolean	bJourOuvrable				// True : Propose les rdv en jours ouvrables; False : Propose les rdv en jour ouvr$$HEX1$$e900$$ENDHEX$$s; 
time		tJourOuvrableMaxRdvSamedi	// Heure Maximum ouvrable le Samedi, par defaut si non pr$$HEX1$$e900$$ENDHEX$$cis$$HEX1$$e900$$ENDHEX$$e = tHeuMaxiRdv [MSS_DIAG]
Boolean	bDimanche					// True : Propose les rdv les jours f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$s; False : Ne Propose les rdv les jours f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$s

protected:
String 	sRetourRdvSaisi			// Chaine de retour au format [15/10/2008 14H00-18H00][16/10/2008 12H00-16H00]

end variables
forward prototypes
public function integer uf_ajoutrdv (string asrdv)
public subroutine uf_razrdv ()
public function string uf_getrdv ()
end prototypes

public function integer uf_ajoutrdv (string asrdv);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_attrib_rdv::uf_ajoutrdv
//* Auteur			: PHG
//* Date				: 23/10/2008 14:13:57
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ajoute un RDV dans la chaine de retour des RDV (sRetourRdvSaisi)
//*
//* Arguments		: value string asrdv	 */
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

n_cst_string	lnvstring
if lnvstring.of_IsEmpty(asRDV) then return -1
sRetourRdvSaisi+=asRDV
return 1



end function

public subroutine uf_razrdv ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_attrib_rdv::uf_razrdv
//* Auteur			: PHG
//* Date				: 23/10/2008 14:16:27
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Remise $$HEX2$$e0002000$$ENDHEX$$Vide des rdv saisis
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

sRetourRdvSaisi=''



end subroutine

public function string uf_getrdv ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_attrib_rdv::uf_getrdv
//* Auteur			: PHG
//* Date				: 23/10/2008 14:20:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Lis les RDV enregistr$$HEX2$$e9002000$$ENDHEX$$dans l'attribut.
//*
//* Arguments		: 
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------


return sRetourRdvSaisi


end function

on n_cst_attrib_rdv.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_attrib_rdv.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

