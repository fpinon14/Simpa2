HA$PBExportHeader$u_gs_sp_sinistre_gestion_rdv.sru
$PBExportComments$[FNAC_PROD_ECH_TECH] User Object de Gestion de prise de Rendez-Vous. Utilise n_cst_attrib_rdv.
forward
global type u_gs_sp_sinistre_gestion_rdv from nonvisualobject
end type
end forward

global type u_gs_sp_sinistre_gestion_rdv from nonvisualobject
end type
global u_gs_sp_sinistre_gestion_rdv u_gs_sp_sinistre_gestion_rdv

type variables
public:
constant string K_ERREUR = "[ERREUR]"
constant integer K_IMPORT_ERR = -10
constant integer K_NB_RDV_NON_ATTEINT = -30
constant integer K_NB_RDVJOUR_DEPASSE = -31

private:
datastore idsStkRdv
end variables

forward prototypes
public function string uf_buildlistrdv (n_cst_attrib_rdv anvattribrdv)
private function datetime uf_addtime (datetime adt, long lnbunit, string sunit)
private function boolean uf_isferie (date adate)
public function integer uf_valider (string aslistrdv, ref n_cst_attrib_rdv anvrdv)
public function integer uf_controlerrdv (ref n_cst_attrib_rdv anvrdv)
private function date uf_jourautorise (date adplage, n_cst_attrib_rdv anvrdv)
private function string uf_buildplage_calc (ref date adplage, ref time atdebplage, ref time atfinplage, n_cst_attrib_rdv anvattribrdv)
private function integer uf_numerojour (date djour)
public function string uf_buildplage_forcee (date adplage, string astbdefinitiongenforcee[])
end prototypes

public function string uf_buildlistrdv (n_cst_attrib_rdv anvattribrdv);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_gestion_rdv::uf_buildlistrdv
//* Auteur			: PHG
//* Date				: 23/10/2008 14:44:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Construit un liste tab-separated de RDV, importable dans une DW
//* 					  ou dans toute autre interface...
//*
//* Arguments		: value n_cst_attrib_rdv anvattribrdv	 */
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 PHG	 04/12/2009   [MSS_DIAG] Prise en compte d'une heure limite de RDV
//*								  pour les jours ouvrable et
//*								  Ajout d'une parametre de generation par modele de la list de rdv
//*-----------------------------------------------------------------

/* rappel des variables
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
*/

integer iNbBuildDay
datetime dtDtRef
date		dPlage, dFin
time		tDebPlage, tFinPlage, tHMax // #1 [MSS_DIAG] 
string	sPlageHoraire

// Controle des Arguments
// Si Argument non ok, retour "[ERREUR]"

// Construction de la liste

// 1/ D$$HEX1$$e900$$ENDHEX$$termination de l'heure du premier rendez-vous
// Prise en compte du parametre de premier RDV.
//Les jours suppl$$HEX1$$e900$$ENDHEX$$mentaire impos$$HEX1$$e900$$ENDHEX$$e par ce parametre sont g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$s.
dtDtRef = uf_AddTime( anvAttribRDV.dtDteHeuRef , anvAttribRDV.iAjoutNbHeuPremierRDV, 'H')

// Ajustement en fonction de l'heure min, si Generation Calcul$$HEX1$$e900$$ENDHEX$$e
if Not anvattribrdv.bGenerationForcee Then
	if time (dtDtRef) < anvAttribRDV.tHeuMiniRdv Then dtDtRef = datetime(date(dtDtRef), anvAttribRDV.tHeuMiniRdv)
End If

// Initialisation des variable de travail
dPlage = date (dtDtRef)
dPlage = uf_jourautorise(dPlage, anvAttribRDV) 							// On G$$HEX1$$e800$$ENDHEX$$re le param$$HEX1$$e900$$ENDHEX$$trage 
																						// JF$$HEX1$$e900$$ENDHEX$$rie/ouvrable/dimanche
tDebPlage = time (dtDtRef) 													// debut de plage
dFin = RelativeDate(dPlage, anvAttribRDV.iNbreJourCalendaireMax) 	// Fin de plage 

// #1 [MSS_DIAG] On g$$HEX1$$e800$$ENDHEX$$re l'initialisation de l'heure de fin en cas
// de jour ouvrable.
if anvAttribRDV.bJourOuvrable and isnull(anvAttribRDV.tJourOuvrableMaxRdvSamedi) then
	anvAttribRDV.tJourOuvrableMaxRdvSamedi = anvAttribRDV.tHeuMaxiRdv
End If

// 2/ On commence $$HEX2$$e0002000$$ENDHEX$$construire
Do while dPlage <= dFin // Tant qu'il reste des jours $$HEX2$$e0002000$$ENDHEX$$construire
	
	if anvattribrdv.bGenerationForcee Then // #1 [MSS_DIAG] 
		sPlageHoraire += uf_buildplage_forcee( dPlage,anvAttribrdv.sTbDefinitiongenForcee)
	Else
		sPlageHoraire += uf_buildplage_calc( dPlage, tDebPlage, tFinPlage, anvattribrdv) // #1 [MSS_DIAG] La g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration calcul$$HEX1$$e900$$ENDHEX$$e a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$port$$HEX1$$e900$$ENDHEX$$e.
	End If

	//Calcul du jour suivant avec gestion si ( jour f$$HEX1$$e900$$ENDHEX$$rie autoris$$HEX2$$e9002000$$ENDHEX$$et/ou Jour Ouvrable et cas rencontr$$HEX1$$e900$$ENDHEX$$) ou Dimanche )
	dPlage= RelativeDate(dPlage,anvAttribRDV.iIncrRdvDate)
	dPlage = uf_jourautorise(dPlage, anvAttribRDV)
Loop

return sPlageHoraire
end function

private function datetime uf_addtime (datetime adt, long lnbunit, string sunit);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_gestion_rdv::uf_addtime
//* Auteur			: PHG
//* Date				: 23/10/2008 15:12:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value datetime adt	 */
//* 	value long lnbunit	 */
//* 	value string sunit	 */
//*
//* Retourne		: datetime	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
date dWork
time tWork
long lNbDay
if IsNull(aDt) or date(aDt) = 1900-01-01 Then return aDt

choose case upper(sUnit)
	case 'H'
		lNbUnit *= 3600
	case 'M'
		lNbUnit *= 60
	case else
		if upper(sUnit) <> 'S' then return aDt
End Choose

// Gestion des jours
dWork = date(aDt)
lNbDay = Truncate(lNbUnit/(3600*24), 0)
If lNbDay > 0 Then dWork = RelativeDate(dWork, lNbDay)

// Gestion du Temps
tWork = Time(aDt)
if lNbDay > 0 Then // Si des jours sont d$$HEX1$$e900$$ENDHEX$$ja compt$$HEX1$$e900$$ENDHEX$$, on doit les enlever de la du$$HEX1$$e900$$ENDHEX$$er en seconde
						 // qui est $$HEX2$$e0002000$$ENDHEX$$ajouter
	choose case lNbUnit
		CASE IS>0
			lNbUnit -= ( lNbDay*3600*24) // On retire le temps d$$HEX1$$e900$$ENDHEX$$ja converti en jour
		CASE IS<0
			lNbUnit += ( lNbDay*3600*24) // On retire le temps d$$HEX1$$e900$$ENDHEX$$ja converti en jour
	End choose
End If
tWork 	= RelativeTime(tWork, lNbUnit)

return datetime(dWork, tWork)


end function

private function boolean uf_isferie (date adate);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_gestion_rdv::uf_isferie
//* Auteur			: PHG
//* Date				: 23/10/2008 16:53:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value date adate	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
integer 	iAnnee
date		dFerie[]
n_cst_datetime	nvDateTime
integer iIFin, iIdx

// Lecture de l'ann$$HEX1$$e900$$ENDHEX$$e
iAnnee = year(adate)

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des jours f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$s sur l'ann$$HEX1$$e900$$ENDHEX$$e en cours					  */
/*------------------------------------------------------------------*/
nvDateTime	= CREATE N_CSt_DateTime
dFerie[ 1]	= Date ( iAnnee, 01, 01 )								// Jour de l'An
dFerie[ 2]	= Date ( iAnnee, 05, 01 )								// F$$HEX1$$ea00$$ENDHEX$$te du Travail
dFerie[ 3]	= Date ( iAnnee, 05, 08 )								// Victoire 1945
dFerie[ 4]	= Date ( iAnnee, 07, 14 )								// F$$HEX1$$ea00$$ENDHEX$$te Nationale
dFerie[ 5]	= Date ( iAnnee, 08, 15 )								// Assomption
dFerie[ 6]	= Date ( iAnnee, 11, 01 )								// Toussaint
dFerie[ 7]	= Date ( iAnnee, 11, 11 )								// Armistice 1918
dFerie[ 8]	= Date ( iAnnee, 12, 25 )								// No$$HEX1$$eb00$$ENDHEX$$l
dFerie[ 9]	= nvDateTime.uf_GetPaques ( iAnnee )				// Lundi de P$$HEX1$$e200$$ENDHEX$$ques
dFerie[10]	= nvDateTime.uf_GetAscension ( dFerie[9] )		// Ascension
dFerie[11]	= nvDateTime.uf_GetPentecote ( dFerie[9] )		// Lundi de Pentec$$HEX1$$f400$$ENDHEX$$te
DESTROY nvDateTime

iIFin = UpperBound(dFerie)

For iIdx = 1 to iIFin
	if dFerie[iIdx]= aDate then return TRUE
Next
return FALSE
end function

public function integer uf_valider (string aslistrdv, ref n_cst_attrib_rdv anvrdv);integer iRet, lCpt
string sretour, sRdv


idsStkRdv = create datastore
if not isvalid(idsStkRdv) then return -1

idsStkRdv.dataobject = 'd_lst_rdv_choisi'
iRet = idsStkRdv.ImportString(aslistrdv) 

if iRet < -1 then return iRet*abs(K_IMPORT_ERR)

// 1/ Controle de Validation
iRet = uf_ControlerRDV(anvrdv) 
if iRet < 0 then return iRet

// 2/ Serialisation des RDV et Affection dans l'objet de communication
For lCpt = 1 to idsStkRdv.RowCount()
	sRdv =	"["+&
					string(idsStkRdv.object.date_rdv[lCpt], "dd/mm/yyyy")+ " " + &
				 	string(idsStkRdv.object.heure_deb[lCpt], "hh:mm") + "-" + &
				 	string(idsStkRdv.object.heure_fin[lCpt], "hh:mm") + &
				 "]"
	anvrdv.uf_ajoutrdv(sRdv)
Next

if isvalid(idsStkRdv) then destroy(idsStkRdv)

return 1

end function

public function integer uf_controlerrdv (ref n_cst_attrib_rdv anvrdv);long lCpt
integer iNbJ=1
//1/ Controle Nb de RDV obligatoire :

If (idsstkrdv.rowCount() <> anvRdv.iNbreRdvADemander) and &
	 anvRdv.iNbreRdvADemander>0 then return K_Nb_rdv_non_atteint

//2/ Controle de Nb Max de rdv par journ$$HEX1$$e900$$ENDHEX$$e
if anvRdv.iRdvAutoriseMemeJournee > 0 then
	idsstkrdv.SetSort ("date_rdv A, heure_deb A")
	idsstkrdv.Sort()
	
	For lCpt = 1 to idsStkrdv.RowCount()
		if lCpt = 1 then continue
		if idsstkrdv.object.date_rdv[lCpt] = idsstkrdv.object.date_rdv[lCpt - 1] Then
				iNbJ++
			if iNbj > anvRdv.iRdvAutoriseMemeJournee then 
				anvrdv.uf_ajoutrdv(string(idsstkrdv.object.date_rdv[lCpt],"dd/mm/yyyy")+ " " +K_ERREUR)
				return K_Nb_rdvjour_depasse
			End If
		else
			iNbj=1
		End If
	Next
End If

return 1


end function

private function date uf_jourautorise (date adplage, n_cst_attrib_rdv anvrdv);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_gestion_rdv::uf_jourautorise
//* Auteur			: PHG
//* Date				: 28/10/2008 15:49:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: retourne un jour autoris$$HEX1$$e900$$ENDHEX$$
//*
//* Arguments		: value n_cst_attrib_rdv anvrdv	 */
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
date dPlage

dPlage = adPlage
// Si ( jour f$$HEX1$$e900$$ENDHEX$$rie autoris$$HEX2$$e9002000$$ENDHEX$$et/ou Jour Ouvrable et cas rencontr$$HEX1$$e900$$ENDHEX$$) ou Dimanche )
Do While 																										&
	( uf_IsFerie(dPlage) and (Not anvrdv.bJFerie ) ) /* Jour F$$HEX1$$e900$$ENDHEX$$ri$$HEX2$$e9002000$$ENDHEX$$*/ 				&
	OR 																											&
	( DayNumber(dPlage)=7 and (Not anvrdv.bJourOuvrable ) ) /* Jour Ouvrable */ 	&
	OR ( DayNumber(dPlage)=1 and (Not anvrdv.bDimanche ) ) /* Dimanche */
	// Alors :
	dPlage = RelativeDate(dPlage, 1) // on decale la date de 1
Loop

return dPlage



end function

private function string uf_buildplage_calc (ref date adplage, ref time atdebplage, ref time atfinplage, n_cst_attrib_rdv anvattribrdv);

time tHmax
string sPlageHoraire
//Calcul des plages
do
	// Plage Calcul$$HEX1$$e900$$ENDHEX$$e
	atFinPlage = RelativeTime(atDebPlage, anvAttribRDV.iNbMinuteParPlageHoraire*60) // On defini la plage Horaire
// #1 [MSS_DIAG] REmplac$$HEX2$$e9002000$$ENDHEX$$par ci-dessous, on int$$HEX1$$e900$$ENDHEX$$gre l'heure maxi de RDV du jour ouvrable
	// Calcul de l'Heure Limite $$HEX2$$e0002000$$ENDHEX$$tester
	If anvAttribRDV.bJourOuvrable Then // Si Gestion Jour ouvrable activ$$HEX1$$e900$$ENDHEX$$e
		if uf_NumeroJour(adPlage)=6 THen // Cas du samedi, jour ouvrable.
			tHmax = anvAttribRDV.tJourOuvrableMaxRdvSamedi
		Else
			tHmax = anvAttribRDV.tHeuMaxiRdv
		End If
	Else
		tHmax = anvAttribRDV.tHeuMaxiRdv
	End If

	if ( atFinPlage <= tHmax ) Then // Rentre-t'elle dans les heure Min max de RDV ?
		sPlageHoraire += string(adPlage, "dd/mm/yyyy")+"~t"+string(atDebPlage,"hh:mm:ss")+"~t"+string(atFinPlage,"hh:mm:ss")+"~r~n"
	End If
	atDebPlage = RelativeTime( atDebPlage, anvAttribRDV.iIncrRdvMinute*60 ) // Calcul du debut la plage Horaire suivante
Loop Until atFinPlage > anvAttribRDV.tHeuMaxiRdv

atDebPlage = anvAttribRDV.tHeuMiniRdv

return sPlageHoraire

/*
	Do
		// Plage Calcul$$HEX1$$e900$$ENDHEX$$e
		tFinPlage = RelativeTime(tDebPlage, anvAttribRDV.iNbMinuteParPlageHoraire*60) // On defini la plage Horaire
//		if tFinPlage <= anvAttribRDV.tHeuMaxiRdv Then // Rentre-t'elle dans les heure Min max de RDV ?
// #1 [MSS_DIAG] REmplac$$HEX2$$e9002000$$ENDHEX$$par ci-dessous, on int$$HEX1$$e900$$ENDHEX$$gre l'heure maxi de RDV du jour ouvrable
		// Calcul de l'Heure Limite $$HEX2$$e0002000$$ENDHEX$$tester
		If anvAttribRDV.bJourOuvrable Then // Si Gestion Jour ouvrable activ$$HEX1$$e900$$ENDHEX$$e
			if DayNumber(dPlage)=7 THen // Cas du samedi, jour ouvrable.
				tHmax = anvAttribRDV.tJourOuvrableMaxRdvSamedi
			Else
				tHmax = anvAttribRDV.tHeuMaxiRdv
			End If
		Else
			tHmax = anvAttribRDV.tHeuMaxiRdv
		End If

		if ( tFinPlage <= tHmax ) Then // Rentre-t'elle dans les heure Min max de RDV ?
			sPlageHoraire += string(dPlage, "dd/mm/yyyy")+"~t"+string(tDebPlage,"hh:mm:ss")+"~t"+string(tFinPlage,"hh:mm:ss")+"~r~n"
		End If
		tDebPlage = RelativeTime( tDebPlage, anvAttribRDV.iIncrRdvMinute*60 ) // Calcul du debut la plage Horaire suivante
	Loop Until tFinPlage > anvAttribRDV.tHeuMaxiRdv
	
	tDebPlage = anvAttribRDV.tHeuMiniRdv
	*/
	

end function

private function integer uf_numerojour (date djour);
// Retourne un Numero de jour Correspondant au calendrier Francais:
// Anglais : 1 = dimanche
// Francais : 1= Lundi
integer iNumJour

iNumJour = DayNumber(djour)
if not isnull(iNumJour) then
	iNumJour --
	if iNumJour = 0 then iNumJour = 7
End If

return iNumJour
end function

public function string uf_buildplage_forcee (date adplage, string astbdefinitiongenforcee[]);n_cst_string lnvString
string sPlageHoraire= ""
string sPlageDef, sPlage
time	tDebPlage, tFinPlage
integer iNumJour
boolean bOkToBuild = FALSE

iNumJour = uf_numerojour( adplage )
sPlageDef = asTbDefinitionGenForcee[iNumJour]

sPlage = lnvString.of_gettoken(sPlageDef, ";")

do until  sPlage = ""
	tDebPlage = time(left(sPlage, 5))
	tFinPlage = time(right(sPlage, 5))
	
	sPlageHoraire += string(adPlage, "dd/mm/yyyy")+"~t"+string(tDebPlage,"hh:mm:ss")+"~t"+string(tFinPlage,"hh:mm:ss")+"~r~n"

	sPlage = lnvString.of_gettoken(sPlageDef, ";")
loop 

return sPlageHoraire

end function

on u_gs_sp_sinistre_gestion_rdv.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_sinistre_gestion_rdv.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

