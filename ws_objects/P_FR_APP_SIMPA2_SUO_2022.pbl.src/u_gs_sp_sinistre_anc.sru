HA$PBExportHeader$u_gs_sp_sinistre_anc.sru
$PBExportComments$---} User Object anc$$HEX1$$ea00$$ENDHEX$$tre pour la gestion permettant d'armer iTrTrans et dw_1 en instance.
forward
global type u_gs_sp_sinistre_anc from nonvisualobject
end type
end forward

global type u_gs_sp_sinistre_anc from nonvisualobject
end type
global u_gs_sp_sinistre_anc u_gs_sp_sinistre_anc

type variables
Protected :
	u_Transaction		itrTrans
	u_DataWindow		idw_wSin

	String			isSysadm = "sysadm."
	String			isTypeTrt = ""
//	String			isRepWin

	DataWindow		idw_Produit
	DataWindow		idw_HoraireRdv
	DataWindow		idw_ZoneFournisseur
	DataWindow		idw_Det_Article
	DataWindow		idw_Det_Hlr
	DataWindow		idw_LstGamme

	DataWindow		idw_DetPro	// CAG 12/02/03, suite DCMP 030027

	u_Onglets		iUoOng

	Long			ilDernierIdProd  = -9
	Long			ilDernierIdRev   = -9


	Boolean			ibAujourdhuiFerie 
end variables

forward prototypes
public subroutine uf_generer_horairerdv ()
public subroutine uf_initialiser_dw_sfr (ref datawindow adw_horairerdv, ref datawindow adw_zonefournisseur, ref datawindow adw_det_article, ref datawindow adw_det_hlr, ref datawindow adw_lstgamme, boolean abinit)
protected function string uf_filtrer_horairerdv (string asidzone)
public subroutine uf_initialiser_dw (ref datawindow adw_produit, ref datawindow adw_detpro, boolean aibinit)
private subroutine uf_generer_horairerdv_arvato ()
private function string uf_filtrer_horairerdv_arvato (string asidzone)
public subroutine uf_initialisation (ref u_datawindow adw_sin, ref u_transaction atrtrans, ref u_onglets auonglet, string astypetrt)
end prototypes

public subroutine uf_generer_horairerdv ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_Anc::uf_Generer_HoraireRdv (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 21/07/2002 09:31:39 CAG 12/09/2002
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration des horaires de Rendez-vous pour la zone A et la zone B
//*					  Chargement des dw des tables det_article, det_hlr, gamme
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF		06/06/2003 G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration des horaires pour ARVATO.                        
//* #2 	 JFF		04/12/2004 Je courCircuite tous les chargement li$$HEX4$$e9002000e0002000$$ENDHEX$$MUST uniquement
//*								  afin de soulagement l'ouverture en saisie (MUST $$HEX1$$e900$$ENDHEX$$tant termin$$HEX1$$e900$$ENDHEX$$).
//*-----------------------------------------------------------------

// #2
Return

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
Date dToday
String sZoneA[20], sZoneB[2]
String sAltFerie
Integer iAnnee1, iAnnee2
Long lCpt, lTotZoneA, lCptZoneA, lCptZoneB, lTotZoneB, lJour, lCptFerie, lLig
N_Cst_DateTime		nvDateTime
Date dFerie[22]

/*------------------------------------------------------------------*/
/* Si les lignes n'ont pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on s'en occupe maintenant.   */
/* Les valeurs d'instances sont initialis$$HEX1$$e900$$ENDHEX$$es dans la fonction       */
/* uf_Initialiser_Sfr().                                            */
/*------------------------------------------------------------------*/
If	idw_HoraireRdv.RowCount () > 0	Then Return
/*------------------------------------------------------------------*/
/* On va r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer la table ZONE_FOURNISSEUR.                           */
/*------------------------------------------------------------------*/
idw_ZoneFournisseur.Retrieve ()

/*------------------------------------------------------------------*/
/* # CAG : Chargement des tables DET_HLR et GAMME                   */
/*------------------------------------------------------------------*/
idw_Det_Hlr.Retrieve ()
idw_LstGamme.Retrieve ()
idw_Det_Article.Retrieve ()

/*------------------------------------------------------------------*/
/* Initialisation des horaires pour la tranche A.                   */
/*------------------------------------------------------------------*/
sZoneA[ 1] = "09:15-10:15"
sZoneA[ 2] = "09:30-10:30"
sZoneA[ 3] = "09:45-10:45"
sZoneA[ 4] = "10:00-11:00"
sZoneA[ 5] = "10:15-11:15"
sZoneA[ 6] = "10:30-11:30"
sZoneA[ 7] = "10:45-11:45"
sZoneA[ 8] = "11:00-12:00"
sZoneA[ 9] = "14:15-15:15"
sZoneA[10] = "14:30-15:30"
sZoneA[11] = "14:45-15:45"
sZoneA[12] = "15:00-16:00"
sZoneA[13] = "15:15-16:15"
sZoneA[14] = "15:30-16:30"
sZoneA[15] = "15:45-16:45"
sZoneA[16] = "16:00-17:00"
sZoneA[17] = "16:15-17:15"
sZoneA[18] = "16:30-17:30"
sZoneA[19] = "16:45-17:45"
sZoneA[20] = "17:00-18:00"
/*------------------------------------------------------------------*/
/* Initialisation des horaires pour la tranche B.                   */
/*------------------------------------------------------------------*/
sZoneB[ 1] = "08:00-12:00"
sZoneB[ 2] = "14:00-18:00"

dToday		= Today ()
lTotZoneA	= UpperBound ( sZoneA )
lTotZoneB	= UpperBound ( sZoneB )
iAnnee1		= Year ( dToday )
iAnnee2		= iAnnee1 + 1

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des jours f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$s sur l'ann$$HEX1$$e900$$ENDHEX$$e en cours et l'ann$$HEX1$$e900$$ENDHEX$$e    */
/* suivante.                                                        */
/*------------------------------------------------------------------*/
nvDateTime	= CREATE N_CSt_DateTime

dFerie[ 1]	= Date ( iAnnee1, 01, 01 )								// Jour de l'An
dFerie[ 2]	= Date ( iAnnee1, 05, 01 )								// F$$HEX1$$ea00$$ENDHEX$$te du Travail
dFerie[ 3]	= Date ( iAnnee1, 05, 08 )								// Victoire 1945
dFerie[ 4]	= Date ( iAnnee1, 07, 14 )								// F$$HEX1$$ea00$$ENDHEX$$te Nationale
dFerie[ 5]	= Date ( iAnnee1, 08, 15 )								// Assomption
dFerie[ 6]	= Date ( iAnnee1, 11, 01 )								// Toussaint
dFerie[ 7]	= Date ( iAnnee1, 11, 11 )								// Armistice 1918
dFerie[ 8]	= Date ( iAnnee1, 12, 25 )								// No$$HEX1$$eb00$$ENDHEX$$l
dFerie[ 9]	= nvDateTime.uf_GetPaques ( iAnnee1 )				// Lundi de P$$HEX1$$e200$$ENDHEX$$ques
dFerie[10]	= nvDateTime.uf_GetAscension ( dFerie[9] )		// Ascension
dFerie[11]	= nvDateTime.uf_GetPentecote ( dFerie[9] )		// Lundi de Pentec$$HEX1$$f400$$ENDHEX$$te

dFerie[12]	= Date ( iAnnee2, 01, 01 )								// Jour de l'An
dFerie[13]	= Date ( iAnnee2, 05, 01 )								// F$$HEX1$$ea00$$ENDHEX$$te du Travail
dFerie[14]	= Date ( iAnnee2, 05, 08 )								// Victoire 1945
dFerie[15]	= Date ( iAnnee2, 07, 14 )								// F$$HEX1$$ea00$$ENDHEX$$te Nationale
dFerie[16]	= Date ( iAnnee2, 08, 15 )								// Assomption
dFerie[17]	= Date ( iAnnee2, 11, 01 )								// Toussaint
dFerie[18]	= Date ( iAnnee2, 11, 11 )								// Armistice 1918
dFerie[19]	= Date ( iAnnee2, 12, 25 )								// No$$HEX1$$eb00$$ENDHEX$$l
dFerie[20]	= nvDateTime.uf_GetPaques ( iAnnee2 )				// Lundi de P$$HEX1$$e200$$ENDHEX$$ques
dFerie[21]	= nvDateTime.uf_GetAscension ( dFerie[20] )		// Ascension
dFerie[22]	= nvDateTime.uf_GetPentecote ( dFerie[20] )		// Lundi de Pentec$$HEX1$$f400$$ENDHEX$$te

DESTROY nvDateTime

lCpt = 0
/*------------------------------------------------------------------*/
/* On g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$re simplement les 60 premi$$HEX1$$e800$$ENDHEX$$res journ$$HEX1$$e900$$ENDHEX$$es.                  */
/*------------------------------------------------------------------*/
Do	While lCpt < 60
		lCpt ++
		sAltFerie = "N"
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le N$$HEX2$$b0002000$$ENDHEX$$du JOUR ( 1=Dimanche, 2=Lundi, 3=Mardi,        */
/* 4=Mercredi, 5=Jeudi, 6=Vendredi, 7=Samedi ).                     */
/*------------------------------------------------------------------*/
		lJour = DayNumber ( dToday )
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si le jour en cours de traitement est un jour f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$.  */
/*------------------------------------------------------------------*/
		For	lCptFerie = 1 To 22
				If	dToday = dFerie[ lCptFerie ]	Then 
					sAltFerie = "O"
					Exit
				End If
		Next
/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re les valeurs pour la zone A.                            */
/*------------------------------------------------------------------*/
		If		lJour <> 1 And sAltFerie = "N"	Then
				Choose Case lJour
/*------------------------------------------------------------------*/
/* Toutes les heures du LUNDI au VENDREDI.                          */
/*------------------------------------------------------------------*/
				Case 2,3,4,5,6
					For	lCptZoneA = 1 To lTotZoneA
						lLig = idw_HoraireRdv.InsertRow ( 0 )
						idw_HoraireRdv.SetItem ( lLig, "INDEX", lCpt )
						idw_HoraireRdv.SetItem ( lLig, "JOUR", dToday )
						idw_HoraireRdv.SetItem ( lLig, "HORAIRE", sZoneA[ lCptZoneA ] )
						idw_HoraireRdv.SetItem ( lLig, "TYP_JOUR", lJour )
						idw_HoraireRdv.SetItem ( lLig, "ALT_FERIE", sAltFerie )
						idw_HoraireRdv.SetItem ( lLig, "ZONE", "A" )
						idw_HoraireRdv.SetItem ( lLig, "IDX_LIG", lLig )
					Next
/*------------------------------------------------------------------*/
/* Que les heures du MATIN pour le SAMEDI.                          */
/*------------------------------------------------------------------*/
				Case 7
					For	lCptZoneA = 1 To 8
						lLig = idw_HoraireRdv.InsertRow ( 0 )
						idw_HoraireRdv.SetItem ( lLig, "INDEX", lCpt )
						idw_HoraireRdv.SetItem ( lLig, "JOUR", dToday )
						idw_HoraireRdv.SetItem ( lLig, "HORAIRE", sZoneA[ lCptZoneA ] )
						idw_HoraireRdv.SetItem ( lLig, "TYP_JOUR", lJour )
						idw_HoraireRdv.SetItem ( lLig, "ALT_FERIE", sAltFerie )
						idw_HoraireRdv.SetItem ( lLig, "ZONE", "A" )
						idw_HoraireRdv.SetItem ( lLig, "IDX_LIG", lLig )
					Next
				End Choose

		Else
				lLig = idw_HoraireRdv.InsertRow ( 0 )
				idw_HoraireRdv.SetItem ( lLig, "INDEX", lCpt )
				idw_HoraireRdv.SetItem ( lLig, "JOUR", dToday )
				idw_HoraireRdv.SetItem ( lLig, "HORAIRE", "00:00-00:00" )
				idw_HoraireRdv.SetItem ( lLig, "TYP_JOUR", lJour )
				idw_HoraireRdv.SetItem ( lLig, "ALT_FERIE", sAltFerie )
				idw_HoraireRdv.SetItem ( lLig, "ZONE", "A" )
				idw_HoraireRdv.SetItem ( lLig, "IDX_LIG", lLig )
		End If

/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re les valeurs pour la zone B.                            */
/*------------------------------------------------------------------*/
		If		lJour <> 1 And sAltFerie = "N"	Then

				For	lCptZoneB = 1 To lTotZoneB
					lLig = idw_HoraireRdv.InsertRow ( 0 )
					idw_HoraireRdv.SetItem ( lLig, "INDEX", lCpt )
					idw_HoraireRdv.SetItem ( lLig, "JOUR", dToday )
					idw_HoraireRdv.SetItem ( lLig, "HORAIRE", sZoneB[ lCptZoneB ] )
					idw_HoraireRdv.SetItem ( lLig, "TYP_JOUR", lJour )
					idw_HoraireRdv.SetItem ( lLig, "ALT_FERIE", sAltFerie )
					idw_HoraireRdv.SetItem ( lLig, "ZONE", "B" )
					idw_HoraireRdv.SetItem ( lLig, "IDX_LIG", lLig )
/*------------------------------------------------------------------*/
/* On ne g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$re rien pour le Samedi Apr$$HEX1$$e900$$ENDHEX$$sMidi.                      */
/*------------------------------------------------------------------*/
					If	lJour = 7	Then Exit
				Next
		Else
				lLig = idw_HoraireRdv.InsertRow ( 0 )
				idw_HoraireRdv.SetItem ( lLig, "INDEX", lCpt )
				idw_HoraireRdv.SetItem ( lLig, "JOUR", dToday )
				idw_HoraireRdv.SetItem ( lLig, "HORAIRE", "00:00-00:00" )
				idw_HoraireRdv.SetItem ( lLig, "TYP_JOUR", lJour )
				idw_HoraireRdv.SetItem ( lLig, "ALT_FERIE", sAltFerie )
				idw_HoraireRdv.SetItem ( lLig, "ZONE", "B" )
				idw_HoraireRdv.SetItem ( lLig, "IDX_LIG", lLig )
		End If

		dToday = RelativeDate ( dToday, 1 )
Loop
/*------------------------------------------------------------------*/
/* On arme une valeur d'instance pour pr$$HEX1$$e900$$ENDHEX$$ciser si TODAY est         */
/* actuellement un jour f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$. Cette information sera importante    */
/* dans la gestion des rendez-vous.                                 */
/*------------------------------------------------------------------*/
If idw_HoraireRdv.GetItemString ( 1, "ALT_FERIE" ) = "O"	Then
	ibAujourdhuiFerie = TRUE
End If

/*------------------------------------------------------------------*/
/* #1 : G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration des horaires pour ARVATO.                        */
/*------------------------------------------------------------------*/
This.uf_Generer_HoraireRdv_Arvato ()

end subroutine

public subroutine uf_initialiser_dw_sfr (ref datawindow adw_horairerdv, ref datawindow adw_zonefournisseur, ref datawindow adw_det_article, ref datawindow adw_det_hlr, ref datawindow adw_lstgamme, boolean abinit);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_Anc::uf_Initialiser_Dw_Sfr (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 21/07/2002 09:31:39 modif CAG 12/09/02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On initialise la DW qui contiendra les horaires de rendez-vous, ainsi que la DW sur la table
//*					  ZONE_FOURNISSEUR.
//*					  Initialisation des DWs de gestion de commandes
//*
//* Arguments		: (R$$HEX1$$e900$$ENDHEX$$f)		DataWindow		adw_HoraireRdv
//*					  (R$$HEX1$$e900$$ENDHEX$$f)		DataWindow		adw_zonefournisseur
//*					  (R$$HEX1$$e900$$ENDHEX$$f)		DataWindow		adw_Det_Article
//*					  (R$$HEX1$$e900$$ENDHEX$$f)		DataWindow		adw_Det_Hlr
//*					  (R$$HEX1$$e900$$ENDHEX$$f)		DataWindow		adw_LstGamme
//*					  (Val)		Boolean			abInit
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #2 	 JFF		04/12/2004 Je courCircuite tous les chargement li$$HEX4$$e9002000e0002000$$ENDHEX$$MUST uniquement
//*								  afin de soulagement l'ouverture en saisie (MUST $$HEX1$$e900$$ENDHEX$$tant termin$$HEX1$$e900$$ENDHEX$$).
//*-----------------------------------------------------------------

DataWindowChild	dwChild

/*------------------------------------------------------------------*/
/* DataWindow pour les horaires de rendez-vous.                     */
/*------------------------------------------------------------------*/
idw_HoraireRdv		= adw_HoraireRdv

If abInit Then
	idw_Det_Article	= adw_Det_Article
	idw_Det_Hlr			= adw_Det_Hlr
	idw_LstGamme		= adw_LstGamme

   /*
	#2
	idw_Det_Article.SetTransObject ( This.itrTrans )
	idw_Det_Hlr.SetTransObject ( This.itrTrans )
	idw_LstGamme.SetTransObject ( This.itrTrans )
	idw_LstGamme.Getchild ( "ID_GAMME", dwChild )
	dwChild.SetTransObject ( This.itrTrans )
	dwChild.Retrieve ( "-GM" )
	*/
End If

/*------------------------------------------------------------------*/
/* DataWindow sur la table ZONE_FOURNISSEUR                             */
/*------------------------------------------------------------------*/
idw_ZoneFournisseur	= adw_zonefournisseur
If	abInit Then idw_ZoneFournisseur.SetTransObject ( This.itrTrans )

end subroutine

protected function string uf_filtrer_horairerdv (string asidzone);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_Anc::uf_Filtrer_HoraireRdv (PROTECTED)
//* Auteur			: Erick John Stark
//* Date				: 10/11/2002 09:31:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va filtrer la DW pour les Horaires de RV
//*
//* Arguments		: (Val)		asIdZone		String
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF     04/03/2003 Suite demande d'A.Leroux le 04/03/03, il faut d$$HEX1$$e900$$ENDHEX$$caler l'horaire
//*								  charni$$HEX1$$e800$$ENDHEX$$re de la B de 17H00 $$HEX2$$e0002000$$ENDHEX$$16H45. En effet la g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration se 
//*								  fait $$HEX2$$e0002000$$ENDHEX$$17H00 et cela pose un soucis.   
//* 
//* #2	 JFF		06/06/2003 Traitement de la zone Nord (N) et Sud (S) pour ARVATO
//* #3 	 JFF		04/12/2004 Je courCircuite tous les chargement li$$HEX4$$e9002000e0002000$$ENDHEX$$MUST uniquement
//*								  afin de soulagement l'ouverture en saisie (MUST $$HEX1$$e900$$ENDHEX$$tant termin$$HEX1$$e900$$ENDHEX$$).
//*-----------------------------------------------------------------

// #3
Return ""

Boolean bEnleverSamedi
Long lJour, lIndex, lLig, lTotHoraire, lIdxLig
Integer iMax, iCpt
Time tNow
String sFiltreDep, sOperande, sHeure, sRech, sFiltreFin

tNow			= Time ( DateTime ( Today (), Now () ) )
lJour			= DayNumber ( Today () )
sFiltreFin	= ""

/*------------------------------------------------------------------*/
/* #2                                                               */
/*------------------------------------------------------------------*/
Choose Case asIdZone 

	Case "1", "2", "3", "4"
		sFiltreFin = This.uf_Filtrer_HoraireRdv_ARVATO ( asIdZone )


	Case  "A"	
/*------------------------------------------------------------------*/
/* Pour la zone A, on commence par exclure les dimanches.           */
/*------------------------------------------------------------------*/
			sFiltreDep = "ZONE = '" + asIdZone + "' And TYP_JOUR <> 1"

			idw_HoraireRdv.SetFilter ( sFiltreDep )
			idw_HoraireRdv.Filter ()
			idw_HoraireRdv.Sort ()

/*------------------------------------------------------------------*/
/* Si le jour d'appel est diff$$HEX1$$e900$$ENDHEX$$rent du Samedi, du Dimanche, et      */
/* qu'il ne s'agit pas d'un jour f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$.                             */
/*------------------------------------------------------------------*/
			If	lJour <> 7 And lJour <> 1 And Not ibAujourdhuiFerie	Then
				lIndex		= 1
				lLig			= 1
				iMax			= 1
				sOperande	= ">"
/*------------------------------------------------------------------*/
/* Heure d'appel inf$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$10H30 -> Heure de RV = 14H15 et Jour  */
/* de RV = Jour d'appel.                                            */
/*------------------------------------------------------------------*/
				If			tNow < Time ( "10:30" )	Then
							sHeure = "14:15"
							sOperande = ">="
/*------------------------------------------------------------------*/
/* Heure d'appel comprise entre 10H30 et 11H30 -> Heure de RV =     */
/* 15H30 et Jour de RV = Jour d'appel.                              */
/*------------------------------------------------------------------*/
				ElseIf	tNow >= Time ( "10:30" ) And tNow < Time ( "11:30" )	Then
							sHeure = "15:30"
							sOperande = ">="
/*------------------------------------------------------------------*/
/* Heure d'appel comprise entre 11H30 et 17H00 -> Heure de RV =     */
/* 09H15 et Jour de RV = Premier jour valable suivant le jour       */
/* d'appel.                                                         */
/*------------------------------------------------------------------*/
				ElseIf	tNow >= Time ( "11:30" ) And tNow < Time ( "17:00" )	Then
							sHeure = "09:15"
/*------------------------------------------------------------------*/
/* Heure d'appel sup$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$17H00 -> Heure de RV = 14H15 et Jour  */
/* de RV = Premier jour valable suivant le jour d'appel.            */
/*------------------------------------------------------------------*/
				ElseIf	tNow >= Time ( "17:00" )	Then
							sHeure = "14:15"
				End If
/*------------------------------------------------------------------*/
/* Jour de d$$HEX1$$e900$$ENDHEX$$claration est $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$un Samedi, un Dimanche ou un      */
/* Jour F$$HEX1$$e900$$ENDHEX$$rie.                                                      */
/*------------------------------------------------------------------*/
			Else
				If	lJour = 1 Then lIndex = 2
				If	lJour = 7 Then lIndex = 1

				lLig = 1
				iMax = 2
				sHeure = "09:15"
				sOperande = ">"
			End If

			iCpt = 0
			lTotHoraire = idw_HoraireRdv.RowCount ()

			Do While iCpt <> iMax
				sRech = "INDEX " + sOperande + " " + String ( lIndex ) + " And Left ( HORAIRE, 5 ) >= '" + sHeure + "'"
				lLig	= idw_HoraireRdv.Find ( sRech, lLig, lTotHoraire )

				lIndex = idw_HoraireRdv.GetItemNumber ( lLig, "INDEX" )
				If	idw_HoraireRdv.GetItemString ( lLig, "ALT_FERIE" ) = "N"	Then iCpt ++
			Loop

			lIdxLig = idw_HoraireRdv.GetItemNumber ( lLig, "IDX_LIG" )
			sFiltreFin = sFiltreDep + " And ALT_FERIE = 'N' And IDX_LIG >= " + String ( lIdxLig )

	Case Else // B
/*------------------------------------------------------------------*/
/* Pour la zone B, on commence par exclure les dimanches.           */
/*------------------------------------------------------------------*/
			sFiltreDep = "ZONE = '" + asIdZone + "' And TYP_JOUR <> 1"

			idw_HoraireRdv.SetFilter ( sFiltreDep )
			idw_HoraireRdv.Filter ()
			idw_HoraireRdv.Sort ()

/*------------------------------------------------------------------*/
/* Si le jour d'appel est diff$$HEX1$$e900$$ENDHEX$$rent du Samedi, du Dimanche, et      */
/* qu'il ne s'agit pas d'un jour f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$.                             */
/*------------------------------------------------------------------*/
			If	lJour <> 7 And lJour <> 1 And Not ibAujourdhuiFerie	Then
				lIndex		= 1
				lLig			= 1
				sOperande	= ">"
				sHeure = "08:00"
/*------------------------------------------------------------------*/
/* Heure d'appel inf$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$17H00 -> Heure de RV = 08H00 et Jour  */
/* de RV = Premier jour valable suivant le Jour d'appel.            */
/*------------------------------------------------------------------*/
/* #1	16H45 $$HEX1$$e000$$ENDHEX$$lp 17H00 															  */
/*------------------------------------------------------------------*/
				If			tNow < Time ( "16:45" )	Then
							iMax			= 1
/*------------------------------------------------------------------*/
/* Heure d'appel sup$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$17H00 -> Heure de RV = 08H00 et Jour  */
/* de RV = Lendemain valable du premier jour valable suivant le     */
/* jour d'appel.                                                    */
/*------------------------------------------------------------------*/
				Else
							iMax				= 2
							bEnleverSamedi = TRUE
				End If
			Else
/*------------------------------------------------------------------*/
/* Jour de d$$HEX1$$e900$$ENDHEX$$claration est $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$un Samedi, un Dimanche ou un      */
/* Jour F$$HEX1$$e900$$ENDHEX$$rie.                                                      */
/*------------------------------------------------------------------*/
				If	lJour = 1 Then lIndex = 2
				If	lJour = 7 Then lIndex = 1

				lLig = 1
				iMax = 2
				sHeure = "08:00"
				sOperande = ">"
			End If

			iCpt = 0
			lTotHoraire = idw_HoraireRdv.RowCount ()

			Do While iCpt <> iMax
				sRech = "INDEX " + sOperande + " " + String ( lIndex ) + " And Left ( HORAIRE, 5 ) >= '" + sHeure + "'"
				lLig	= idw_HoraireRdv.Find ( sRech, lLig, lTotHoraire )
				lIndex = idw_HoraireRdv.GetItemNumber ( lLig, "INDEX" )
				
				If	bEnleverSamedi = TRUE And idw_HoraireRdv.GetItemNumber ( lLig, "TYP_JOUR" ) = 7 And iCpt <= iMax - 2 Then 
					Continue
				End If
				If	idw_HoraireRdv.GetItemString ( lLig, "ALT_FERIE" ) = "N"	Then iCpt ++
			Loop

			lIdxLig = idw_HoraireRdv.GetItemNumber ( lLig, "IDX_LIG" )
			sFiltreFin = sFiltreDep + " And ALT_FERIE = 'N' And IDX_LIG >= " + String ( lIdxLig )

End choose

Return ( sFiltreFin )

end function

public subroutine uf_initialiser_dw (ref datawindow adw_produit, ref datawindow adw_detpro, boolean aibinit);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser_Dw (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: DataWindow				adw_Produit			(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow sur la table PRODUIT
//*					  DataWindow			   adw_DetPro			(R$$HEX1$$e900$$ENDHEX$$f) DataWindow sur la table DET_PRO (suite DCMP 030027)
//*					  Boolean					abInit				(Val)	Faut-il initialiser l'objet de Transaction de la DW ?
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* DataWindow sur la table PRODUIT                                  */
/*------------------------------------------------------------------*/
idw_Produit	= adw_Produit
If	aibInit Then idw_Produit.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la table DET_PRO                                  */
/*------------------------------------------------------------------*/
idw_DetPro	= adw_DetPro
If	aibInit Then idw_DetPro.SetTransObject ( This.itrTrans )


end subroutine

private subroutine uf_generer_horairerdv_arvato ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_Anc::uf_Generer_HoraireRdv_Arvato (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 21/07/2002 09:31:39 CAG 12/09/2002
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Copie de la fonction par JFF le 06/06/2003 pour Arvato
//* Commentaires	: G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration des horaires de Rendez-vous pour la zone N (Nord eqB) et la zone S (Sud eqA)
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 
//*-----------------------------------------------------------------

Date dToday
String sZone2[2], sZone1[2], sZone3[2], sZone4[2]
String sAltFerie
Integer iAnnee1, iAnnee2
Long lCpt, lTotZone2, lCptZone2, lCptZone1, lTotZone1, lJour, lCptFerie, lLig
Long lTotZone3, lCptZone3, lCptZone4, lTotZone4
N_Cst_DateTime		nvDateTime
Date dFerie[22]

/*------------------------------------------------------------------*/
/* Initialisation des horaires pour la tranche (2) Sud.             */
/*------------------------------------------------------------------*/
sZone2[ 1] = "08:00-12:00"
sZone2[ 2] = "14:00-18:00"

/*------------------------------------------------------------------*/
/* Initialisation des horaires pour la tranche (1) Nord.            */
/*------------------------------------------------------------------*/
sZone1[ 1] = "08:00-12:00"
sZone1[ 2] = "14:00-18:00"

/*------------------------------------------------------------------*/
/* Initialisation des horaires pour la tranche (3) Corse.           */
/*------------------------------------------------------------------*/
sZone3[ 1] = "08:00-12:00"
sZone3[ 2] = "14:00-18:00"

/*------------------------------------------------------------------*/
/* Initialisation des horaires pour la tranche (4) R.Parisienne.    */
/*------------------------------------------------------------------*/
sZone4[ 1] = "09:00-13:00"
sZone4[ 2] = "14:00-18:00"


dToday		= Today ()
lTotZone2	= UpperBound ( sZone2 )
lTotZone1	= UpperBound ( sZone1 )
lTotZone3	= UpperBound ( sZone3 )
lTotZone4	= UpperBound ( sZone4 )
iAnnee1		= Year ( dToday )
iAnnee2		= iAnnee1 + 1

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des jours f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$s sur l'ann$$HEX1$$e900$$ENDHEX$$e en cours et l'ann$$HEX1$$e900$$ENDHEX$$e    */
/* suivante.                                                        */
/*------------------------------------------------------------------*/
nvDateTime	= CREATE N_CSt_DateTime

dFerie[ 1]	= Date ( iAnnee1, 01, 01 )								// Jour de l'An
dFerie[ 2]	= Date ( iAnnee1, 05, 01 )								// F$$HEX1$$ea00$$ENDHEX$$te du Travail
dFerie[ 3]	= Date ( iAnnee1, 05, 08 )								// Victoire 1945
dFerie[ 4]	= Date ( iAnnee1, 07, 14 )								// F$$HEX1$$ea00$$ENDHEX$$te Nationale
dFerie[ 5]	= Date ( iAnnee1, 08, 15 )								// Assomption
dFerie[ 6]	= Date ( iAnnee1, 11, 01 )								// Toussaint
dFerie[ 7]	= Date ( iAnnee1, 11, 11 )								// Armistice 1918
dFerie[ 8]	= Date ( iAnnee1, 12, 25 )								// No$$HEX1$$eb00$$ENDHEX$$l
dFerie[ 9]	= nvDateTime.uf_GetPaques ( iAnnee1 )				// Lundi de P$$HEX1$$e200$$ENDHEX$$ques
dFerie[10]	= nvDateTime.uf_GetAscension ( dFerie[9] )		// Ascension
dFerie[11]	= nvDateTime.uf_GetPentecote ( dFerie[9] )		// Lundi de Pentec$$HEX1$$f400$$ENDHEX$$te

dFerie[12]	= Date ( iAnnee2, 01, 01 )								// Jour de l'An
dFerie[13]	= Date ( iAnnee2, 05, 01 )								// F$$HEX1$$ea00$$ENDHEX$$te du Travail
dFerie[14]	= Date ( iAnnee2, 05, 08 )								// Victoire 1945
dFerie[15]	= Date ( iAnnee2, 07, 14 )								// F$$HEX1$$ea00$$ENDHEX$$te Nationale
dFerie[16]	= Date ( iAnnee2, 08, 15 )								// Assomption
dFerie[17]	= Date ( iAnnee2, 11, 01 )								// Toussaint
dFerie[18]	= Date ( iAnnee2, 11, 11 )								// Armistice 1918
dFerie[19]	= Date ( iAnnee2, 12, 25 )								// No$$HEX1$$eb00$$ENDHEX$$l
dFerie[20]	= nvDateTime.uf_GetPaques ( iAnnee2 )				// Lundi de P$$HEX1$$e200$$ENDHEX$$ques
dFerie[21]	= nvDateTime.uf_GetAscension ( dFerie[20] )		// Ascension
dFerie[22]	= nvDateTime.uf_GetPentecote ( dFerie[20] )		// Lundi de Pentec$$HEX1$$f400$$ENDHEX$$te

DESTROY nvDateTime

lCpt = 0
/*------------------------------------------------------------------*/
/* On g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$re simplement les 60 premi$$HEX1$$e800$$ENDHEX$$res journ$$HEX1$$e900$$ENDHEX$$es.                  */
/*------------------------------------------------------------------*/
Do	While lCpt < 60
		lCpt ++
		sAltFerie = "N"
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le N$$HEX2$$b0002000$$ENDHEX$$du JOUR ( 1=Dimanche, 2=Lundi, 3=Mardi,        */
/* 4=Mercredi, 5=Jeudi, 6=Vendredi, 7=Samedi ).                     */
/*------------------------------------------------------------------*/
		lJour = DayNumber ( dToday )
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si le jour en cours de traitement est un jour f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$.  */
/*------------------------------------------------------------------*/
		For	lCptFerie = 1 To 22
				If	dToday = dFerie[ lCptFerie ]	Then 
					sAltFerie = "O"
					Exit
				End If
		Next
/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re les valeurs pour la zone 2 (Sud).                      */
/*------------------------------------------------------------------*/
		If		lJour <> 1 And sAltFerie = "N"	Then

				For	lCptZone2 = 1 To lTotZone2
					lLig = idw_HoraireRdv.InsertRow ( 0 )
					idw_HoraireRdv.SetItem ( lLig, "INDEX", lCpt )
					idw_HoraireRdv.SetItem ( lLig, "JOUR", dToday )
					idw_HoraireRdv.SetItem ( lLig, "HORAIRE", sZone2[ lCptZone2 ] )
					idw_HoraireRdv.SetItem ( lLig, "TYP_JOUR", lJour )
					idw_HoraireRdv.SetItem ( lLig, "ALT_FERIE", sAltFerie )
					idw_HoraireRdv.SetItem ( lLig, "ZONE", "2" )
					idw_HoraireRdv.SetItem ( lLig, "IDX_LIG", lLig )
/*------------------------------------------------------------------*/
/* On ne g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$re rien pour le Samedi Apr$$HEX1$$e900$$ENDHEX$$sMidi.                      */
/*------------------------------------------------------------------*/
					If	lJour = 7	Then Exit
				Next
		Else
				lLig = idw_HoraireRdv.InsertRow ( 0 )
				idw_HoraireRdv.SetItem ( lLig, "INDEX", lCpt )
				idw_HoraireRdv.SetItem ( lLig, "JOUR", dToday )
				idw_HoraireRdv.SetItem ( lLig, "HORAIRE", "00:00-00:00" )
				idw_HoraireRdv.SetItem ( lLig, "TYP_JOUR", lJour )
				idw_HoraireRdv.SetItem ( lLig, "ALT_FERIE", sAltFerie )
				idw_HoraireRdv.SetItem ( lLig, "ZONE", "2" )
				idw_HoraireRdv.SetItem ( lLig, "IDX_LIG", lLig )
		End If

/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re les valeurs pour la zone (1) Nord.                     */
/*------------------------------------------------------------------*/
		If		lJour <> 1 And sAltFerie = "N"	Then

				For	lCptZone1 = 1 To lTotZone1
					lLig = idw_HoraireRdv.InsertRow ( 0 )
					idw_HoraireRdv.SetItem ( lLig, "INDEX", lCpt )
					idw_HoraireRdv.SetItem ( lLig, "JOUR", dToday )
					idw_HoraireRdv.SetItem ( lLig, "HORAIRE", sZone1[ lCptZone1 ] )
					idw_HoraireRdv.SetItem ( lLig, "TYP_JOUR", lJour )
					idw_HoraireRdv.SetItem ( lLig, "ALT_FERIE", sAltFerie )
					idw_HoraireRdv.SetItem ( lLig, "ZONE", "1" )
					idw_HoraireRdv.SetItem ( lLig, "IDX_LIG", lLig )
/*------------------------------------------------------------------*/
/* On ne g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$re rien pour le Samedi Apr$$HEX1$$e900$$ENDHEX$$sMidi.                      */
/*------------------------------------------------------------------*/
					If	lJour = 7	Then Exit
				Next
		Else
				lLig = idw_HoraireRdv.InsertRow ( 0 )
				idw_HoraireRdv.SetItem ( lLig, "INDEX", lCpt )
				idw_HoraireRdv.SetItem ( lLig, "JOUR", dToday )
				idw_HoraireRdv.SetItem ( lLig, "HORAIRE", "00:00-00:00" )
				idw_HoraireRdv.SetItem ( lLig, "TYP_JOUR", lJour )
				idw_HoraireRdv.SetItem ( lLig, "ALT_FERIE", sAltFerie )
				idw_HoraireRdv.SetItem ( lLig, "ZONE", "1" )
				idw_HoraireRdv.SetItem ( lLig, "IDX_LIG", lLig )
		End If


/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re les valeurs pour la zone (3) Corse.                     */
/*------------------------------------------------------------------*/
		If		lJour <> 1 And sAltFerie = "N"	Then

				For	lCptZone3 = 1 To lTotZone3
					lLig = idw_HoraireRdv.InsertRow ( 0 )
					idw_HoraireRdv.SetItem ( lLig, "INDEX", lCpt )
					idw_HoraireRdv.SetItem ( lLig, "JOUR", dToday )
					idw_HoraireRdv.SetItem ( lLig, "HORAIRE", sZone3[ lCptZone3 ] )
					idw_HoraireRdv.SetItem ( lLig, "TYP_JOUR", lJour )
					idw_HoraireRdv.SetItem ( lLig, "ALT_FERIE", sAltFerie )
					idw_HoraireRdv.SetItem ( lLig, "ZONE", "3" )
					idw_HoraireRdv.SetItem ( lLig, "IDX_LIG", lLig )
/*------------------------------------------------------------------*/
/* On ne g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$re rien pour le Samedi Apr$$HEX1$$e900$$ENDHEX$$sMidi.                      */
/*------------------------------------------------------------------*/
					If	lJour = 7	Then Exit
				Next
		Else
				lLig = idw_HoraireRdv.InsertRow ( 0 )
				idw_HoraireRdv.SetItem ( lLig, "INDEX", lCpt )
				idw_HoraireRdv.SetItem ( lLig, "JOUR", dToday )
				idw_HoraireRdv.SetItem ( lLig, "HORAIRE", "00:00-00:00" )
				idw_HoraireRdv.SetItem ( lLig, "TYP_JOUR", lJour )
				idw_HoraireRdv.SetItem ( lLig, "ALT_FERIE", sAltFerie )
				idw_HoraireRdv.SetItem ( lLig, "ZONE", "3" )
				idw_HoraireRdv.SetItem ( lLig, "IDX_LIG", lLig )
		End If

/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re les valeurs pour la zone (4) R.Parisienne.             */
/*------------------------------------------------------------------*/
		If		lJour <> 1 And sAltFerie = "N"	Then

				For	lCptZone4 = 1 To lTotZone4
					lLig = idw_HoraireRdv.InsertRow ( 0 )
					idw_HoraireRdv.SetItem ( lLig, "INDEX", lCpt )
					idw_HoraireRdv.SetItem ( lLig, "JOUR", dToday )
					idw_HoraireRdv.SetItem ( lLig, "HORAIRE", sZone4[ lCptZone4 ] )
					idw_HoraireRdv.SetItem ( lLig, "TYP_JOUR", lJour )
					idw_HoraireRdv.SetItem ( lLig, "ALT_FERIE", sAltFerie )
					idw_HoraireRdv.SetItem ( lLig, "ZONE", "4" )
					idw_HoraireRdv.SetItem ( lLig, "IDX_LIG", lLig )
/*------------------------------------------------------------------*/
/* On ne g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$re rien pour le Samedi Apr$$HEX1$$e900$$ENDHEX$$sMidi.                      */
/*------------------------------------------------------------------*/
					If	lJour = 7	Then Exit
				Next
		Else
				lLig = idw_HoraireRdv.InsertRow ( 0 )
				idw_HoraireRdv.SetItem ( lLig, "INDEX", lCpt )
				idw_HoraireRdv.SetItem ( lLig, "JOUR", dToday )
				idw_HoraireRdv.SetItem ( lLig, "HORAIRE", "00:00-00:00" )
				idw_HoraireRdv.SetItem ( lLig, "TYP_JOUR", lJour )
				idw_HoraireRdv.SetItem ( lLig, "ALT_FERIE", sAltFerie )
				idw_HoraireRdv.SetItem ( lLig, "ZONE", "4" )
				idw_HoraireRdv.SetItem ( lLig, "IDX_LIG", lLig )
		End If




		dToday = RelativeDate ( dToday, 1 )
Loop
/*------------------------------------------------------------------*/
/* On arme une valeur d'instance pour pr$$HEX1$$e900$$ENDHEX$$ciser si TODAY est         */
/* actuellement un jour f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$. Cette information sera importante    */
/* dans la gestion des rendez-vous.                                 */
/*------------------------------------------------------------------*/
If idw_HoraireRdv.GetItemString ( 1, "ALT_FERIE" ) = "O"	Then
	ibAujourdhuiFerie = TRUE
End If


end subroutine

private function string uf_filtrer_horairerdv_arvato (string asidzone);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_Anc::uf_Filtrer_HoraireRdv_ARVATO (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 10/11/2002 09:31:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Copie de la fonction pour ARVATO par JFF le 06/06/2003
//* Commentaires	: On va filtrer la DW pour les Horaires de RV
//*
//* Arguments		: (Val)		asIdZone		String
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 
//*-----------------------------------------------------------------

Boolean bEnleverSamedi
Long lJour, lIndex, lLig, lTotHoraire, lIdxLig
Integer iMax, iCpt
Time tNow
String sFiltreDep, sOperande, sHeure, sRech, sFiltreFin

tNow			= Time ( DateTime ( Today (), Now () ) )
lJour			= DayNumber ( Today () )
sFiltreFin	= ""


/*------------------------------------------------------------------*/
/* Pour les deux zones, on commence par exclure les dimanches.      */
/*------------------------------------------------------------------*/
sFiltreDep = "ZONE = '" + asIdZone + "' And TYP_JOUR <> 1"

idw_HoraireRdv.SetFilter ( sFiltreDep )
idw_HoraireRdv.Filter ()
idw_HoraireRdv.Sort ()


/*------------------------------------------------------------------*/
/* Si le jour d'appel est diff$$HEX1$$e900$$ENDHEX$$rent du Samedi, du Dimanche, et      */
/* qu'il ne s'agit pas d'un jour f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$.                             */
/*------------------------------------------------------------------*/
If	lJour <> 7 And lJour <> 1 And Not ibAujourdhuiFerie	Then
	lIndex		= 1
	lLig			= 1
	iMax			= 1
	sOperande	= ">"
/*------------------------------------------------------------------*/
/* Heure d'appel inf$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$14H55 -> Heure de RV = 08H00 et Jour  */
/* de RV = Premier jour valable suivant le Jour d'appel.            */
/*------------------------------------------------------------------*/
	If	tNow < Time ( "14:55" )	Then
		sHeure = "08:00"

/*------------------------------------------------------------------*/
/* En fonction de la zone                                           */
/*------------------------------------------------------------------*/
		Choose Case asIdZone
			
			Case "3"  // Corse
				iMax = 2
				If lJour = 6 Then
					iMax = 3
				End If

			Case "4"  // Paris et R$$HEX1$$e900$$ENDHEX$$gion parisienne
				sHeure = "09:00"				

		End Choose


/*------------------------------------------------------------------*/
/* Heure d'appel sup$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$14H55 est inf$$HEX1$$e900$$ENDHEX$$rieur strc $$HEX5$$e0002000200020002000$$ENDHEX$$*/
/* 17H10 Heure de RV = 08H00 pour le Sud, 14H00 pour le Nord et Jour*/
/* de RV = Premier jour valable suivant le Jour d'appel.            */
/*------------------------------------------------------------------*/
	ElseIf tNow >= Time ( "14:55" ) And tNow < Time ( "17:10" )	Then

/*------------------------------------------------------------------*/
/* En fonction de la zone                                           */
/*------------------------------------------------------------------*/
		Choose Case asIdZone
			
			Case "2"  // Sud

				sHeure = "14:00"
				/*------------------------------------------------------------------*/
				/* Cas particulier du Vendredi : Dans tous les cas l'heure de d$$HEX1$$e900$$ENDHEX$$but */
				/* sera 08H00, que ce soit le Samedi, ou le Lundi.                  */
				/*------------------------------------------------------------------*/
				If lJour = 6 Then
					sHeure = "08:00"
					lIndex = 2
				End If

			Case "1"  // Nord
				sHeure = "08:00"

			Case "3"  // Corse
				iMax = 2
				If lJour = 6 Then
					iMax = 3
				End If

			Case "4"  // Paris et R$$HEX1$$e900$$ENDHEX$$gion parisienne
				sHeure = "09:00"				

		End Choose

/*------------------------------------------------------------------*/
/* Heure d'appel sup$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$17H10 -> Heure de RV = 08H00 et Jour  */
/* de RV = Lendemain valable du premier jour valable suivant le     */
/* jour d'appel. 																	  */
/*------------------------------------------------------------------*/
	ElseIf tNow >= Time ( "17:10" )	Then

		sHeure = "08:00"
		iMax = 2
		bEnleverSamedi = TRUE
/*------------------------------------------------------------------*/
/* En fonction de la zone                                           */
/*------------------------------------------------------------------*/
		Choose Case asIdZone

			Case "3"  // Corse
				iMax = 3

			Case "4"  // Paris et R$$HEX1$$e900$$ENDHEX$$gion parisienne
				sHeure = "09:00"				

		End Choose
	End If
Else
/*------------------------------------------------------------------*/
/* Jour de d$$HEX1$$e900$$ENDHEX$$claration est $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$un Samedi, un Dimanche ou un      */
/* Jour F$$HEX1$$e900$$ENDHEX$$rie.                                                      */
/*------------------------------------------------------------------*/
	If	lJour = 1 Then lIndex = 2
	If	lJour = 7 Then lIndex = 1

	lLig = 1
	iMax = 2
	sHeure = "08:00"
	sOperande = ">"

/*------------------------------------------------------------------*/
/* En fonction de la zone                                           */
/*------------------------------------------------------------------*/
		Choose Case asIdZone

			Case "3"  // Corse
				iMax = 3

			Case "4"  // Paris et R$$HEX1$$e900$$ENDHEX$$gion parisienne
				sHeure = "09:00"				

		End Choose

End If


iCpt = 0
lTotHoraire = idw_HoraireRdv.RowCount ()

Do While iCpt <> iMax
	sRech = "INDEX " + sOperande + " " + String ( lIndex ) + " And Left ( HORAIRE, 5 ) >= '" + sHeure + "'"
	lLig	= idw_HoraireRdv.Find ( sRech, lLig, lTotHoraire )
	lIndex = idw_HoraireRdv.GetItemNumber ( lLig, "INDEX" )

	If	bEnleverSamedi = TRUE And idw_HoraireRdv.GetItemNumber ( lLig, "TYP_JOUR" ) = 7 And iCpt <= iMax - 2 Then 
		Continue
	End If
	If	idw_HoraireRdv.GetItemString ( lLig, "ALT_FERIE" ) = "N"	Then iCpt ++
Loop

lIdxLig = idw_HoraireRdv.GetItemNumber ( lLig, "IDX_LIG" )
sFiltreFin = sFiltreDep + " And ALT_FERIE = 'N' And IDX_LIG >= " + String ( lIdxLig )


Return ( sFiltreFin )

end function

public subroutine uf_initialisation (ref u_datawindow adw_sin, ref u_transaction atrtrans, ref u_onglets auonglet, string astypetrt);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialisation (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow				adw_Sin			(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow de traitement du sinistre
//*					  u_Transaction			atrTrans			(R$$HEX1$$e900$$ENDHEX$$f)	Objet de transaction
//*					  u_Onglets					auOnglet			(R$$HEX1$$e900$$ENDHEX$$f)	Onglet
//*					  String						asTypeTrt		(Val)	Type de traitement (Saisie/Consultation/Validation)
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

//String sRepWin
//u_DeclarationFuncky uoDeclarationFuncky //[I037] Migration FUNCKy

idw_wSin		= adw_Sin
itrTrans		= atrTrans
iuoOng		= auOnglet
isTypeTrt	= asTypeTrt

//uoDeclarationFuncky = Create u_DeclarationFuncky
//sRepWin = uoDeclarationFuncky.Uf_WinDir ()
//Destroy uoDeclarationFuncky

/*------------------------------------------------------------------*/
/* On initialise aussi une variable d'instance qui contient le      */
/* r$$HEX1$$e900$$ENDHEX$$pertoire de Windows. Cette variable sera utilis$$HEX1$$e900$$ENDHEX$$e pour la      */
/* gestion des courriers Word. (PC, PS, CP).                        */
/*------------------------------------------------------------------*/
//isRepWin			= sRepWin

end subroutine

on u_gs_sp_sinistre_anc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_sinistre_anc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

