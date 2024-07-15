HA$PBExportHeader$n_cst_saisie_validation_interlocuteur.sru
$PBExportComments$------} NVUO servant $$HEX2$$e0002000$$ENDHEX$$la m$$HEX1$$e900$$ENDHEX$$thode Saisie/Validation/Edition pour la gestion de l'interlocuteur.
forward
global type n_cst_saisie_validation_interlocuteur from nonvisualobject
end type
end forward

global type n_cst_saisie_validation_interlocuteur from nonvisualobject
end type
global n_cst_saisie_validation_interlocuteur n_cst_saisie_validation_interlocuteur

type variables
Private :
	ListBox			ilb_Fichier

	U_DeclarationWindows	invWin

	String			isIdSin
	String			isTypeTrt
	String			isIdAppli
	String			isZn_IdInter
	String			isZn_CodInter
	String			isFicEntete

	U_DataWindow		idw_wInter

	DataWindow		idw_Compo
	DataWindow		idw_GenCourrier
	DataWindow		idwDetPro // [PC363][LOGO_AUCHAN]


	DataWindow		iidw_WSin // #2

	CommandButton		icbCourPart
	CommandButton		icbEffacer

	Boolean			ibCpPresent
end variables

forward prototypes
private subroutine uf_majboutoncp ()
public subroutine uf_preparer (string asidsin, ref u_datawindow adw_winter, string astypetrt)
public function boolean uf_get_cppresent ()
public subroutine uf_btsupcpart (integer aitypetrt)
public function integer uf_btcpart_savane (string astxtdata)
public function integer uf_btcpart_simpa2 (string astxtdata)
public function integer uf_initialiser (string asidappli, ref listbox albfichier, ref commandbutton acbcourpart, ref commandbutton acbeffacer, ref datawindow adwcompo, ref datawindow adwgencourrier, ref datawindow aidw_wsin, ref datawindow adwdetpro)
end prototypes

private subroutine uf_majboutoncp ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Interlocuteur::uf_MajBoutonCP		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR     Date	  		Modification
//* #1 		 DGA     19/09/2006  Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire DCMP-060643
//*-----------------------------------------------------------------

String sRepTmp, sJoker, sNomFic, sNomFicComplet
Date dDateFic
Time tHeureFic
Long lIdInter, lTotFichier
Boolean bContinuer, bCourPart

bContinuer	= TRUE
ibCpPresent	= FALSE

idw_wInter.Modify ( "p_cpart.Visible = 0" )
idw_wInter.Modify ( "t_cpart.Text = ''" )

/*------------------------------------------------------------------*/
/* Nous sommes en cr$$HEX1$$e900$$ENDHEX$$ation, pas de CP possible.                     */
/*------------------------------------------------------------------*/
If	isTypeTrt = "C"	Then
	icbCourPart.Visible	= False
	icbEffacer.Visible	= False

	idw_wInter.Modify ( "p_cpart.Visible = 0" )
	idw_wInter.Modify ( "t_cpart.Text = ''" )
	bContinuer = FALSE
End If

If	bContinuer	Then
	lIdInter = idw_wInter.GetItemNumber  ( 1, isZn_IdInter ) 
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re tous les fichiers du type                            */
/* C:\WINNT\TEMP\XXXX99_X*.*.                                       */
/*------------------------------------------------------------------*/
/* XXXX = Code de l'application sur 4 caract$$HEX1$$e800$$ENDHEX$$res obligatoires.      */
/* 99   = ID_INTER sur deux positions obligatoires (Ex:02,12).      */
/* 9    = COD_INTER.                                                */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//	sRepTmp	= stGLB.sWinDir + "\TEMP\" 
	sRepTmp	= stGLB.sRepTempo
	sJoker	= sRepTmp + stGLB.sCodAppli + String ( lIdInter, "00" ) + "*.*"

	ilb_Fichier.Reset ()
	ilb_Fichier.DirList ( sJoker, 0 )

	lTotFichier = ilb_Fichier.TotalItems ()
/*------------------------------------------------------------------*/
/* Il y a plus d'un fichier pour l'interlocuteur. On rend le        */
/* bouton invisible, mais on affiche un avertissement dans la zone  */
/* Text.                                                            */
/*------------------------------------------------------------------*/
	If	lTotFichier > 1	Then
		icbCourPart.Visible	= False
		icbEffacer.Visible	= False

		idw_wInter.Modify ( "p_cpart.Visible = 0" )
		idw_wInter.Modify ( "t_cpart.Text = 'Probl$$HEX1$$e800$$ENDHEX$$me!!, il y a deux CP sur le disque'" )
		bContinuer = FALSE
	End If
End If
/*------------------------------------------------------------------*/
/* Il n'y a pas de courrier particulier.                            */
/*------------------------------------------------------------------*/
If	bContinuer And lTotFichier < 1	Then
	icbCourPart.Visible	= TRUE
	icbEffacer.Visible	= False

	idw_wInter.Modify ( "p_cpart.Visible = 0" )
	idw_wInter.Modify ( "t_cpart.Text = ''" )
	bContinuer = FALSE
End If
/*------------------------------------------------------------------*/
/* Il y a un courrier particulier. On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la date et l'heure   */
/* de cr$$HEX1$$e900$$ENDHEX$$ation du fichier.                                          */
/*------------------------------------------------------------------*/
If	bContinuer	Then
	ilb_Fichier.SelectItem ( 1 )
	sNomFic			= ilb_Fichier.SelectedItem ()
	sNomFicComplet = sRepTmp + sNomFic

	invWin.uf_GetLastWriteDateTime ( sNomFicComplet, dDateFic, tHeureFic )
/*------------------------------------------------------------------*/
/* Si le document $$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$modifi$$HEX2$$e9002000$$ENDHEX$$par l'utilisateur alors c'est un    */
/* CP.                                                              */
/*------------------------------------------------------------------*/
	If	dDateFic <> 2000-01-01 Or Left ( String ( tHeureFic ), 5 ) <> "23:59"	Then
		icbCourPart.Visible	= TRUE
		icbEffacer.Visible	= TRUE

		idw_wInter.Modify ( "p_cpart.Visible = 1" )
		idw_wInter.Modify ( "t_cpart.Text = 'Modifi$$HEX2$$e9002000$$ENDHEX$$le " + String ( dDateFic, "dd/mm/yyyy" ) + " $$HEX2$$e0002000$$ENDHEX$$" 										+ &
																			 String ( Long ( Left ( String ( tHeureFic ), 2 ) ), "00" ) + "H"			+ &
																			 String ( Long ( Mid  ( String ( tHeureFic ), 4, 2 ) ), "00" ) + "'" )
		ibCpPresent	= TRUE

		idw_wInter.SetItem ( 1, "ALT_PART", "O" )
		idw_wInter.SetItem ( 1, "ID_COUR", "APART1" )

	Else
		icbCourPart.Visible	= TRUE
		icbEffacer.Visible	= FALSE

		idw_wInter.Modify ( "p_cpart.Visible = 0" )		
		idw_wInter.Modify ( "t_cpart.Text = ''" )
	End If
End If

end subroutine

public subroutine uf_preparer (string asidsin, ref u_datawindow adw_winter, string astypetrt);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Interlocuteur::uf_Preparer		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Pr$$HEX1$$e900$$ENDHEX$$paration des variables d'instances
//*
//* Arguments		: (Val)		String					asIdSin			N$$HEX2$$b0002000$$ENDHEX$$de la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence sinistre en cours de traitement
//*					  (R$$HEX1$$e900$$ENDHEX$$f)		U_DataWindow			adw_wInter		FreeForm sur les interlocuteurs
//*					  (Val)		String					asTypeTrt		Type de traitement sur la fen$$HEX1$$ea00$$ENDHEX$$tre (C)r$$HEX1$$e900$$ENDHEX$$ation/(M)odification
//*
//* Retourne		: Aucun
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On arme les instances n$$HEX1$$e900$$ENDHEX$$cessaires au traitement des courriers.   */
/*------------------------------------------------------------------*/
/* Cette fonction est appel$$HEX1$$e900$$ENDHEX$$e sur le Wf_PreparerModifier () et      */
/* Wf_PreparerInserer () de la fen$$HEX1$$ea00$$ENDHEX$$tre des interlocuteurs.          */
/*------------------------------------------------------------------*/
isIdSin		= asIdSin
idw_wInter	= adw_wInter
isTypeTrt	= asTypeTrt

/*------------------------------------------------------------------*/
/* Mise $$HEX2$$e0002000$$ENDHEX$$jour des Boutons.                                         */
/*------------------------------------------------------------------*/
This.uf_MajBoutonCP ()



end subroutine

public function boolean uf_get_cppresent ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Interlocuteur::uf_Get_CpPresent			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de la variables d'instance ibCpPresent (Arm$$HEX1$$e900$$ENDHEX$$e sur uf_MajBoutonCp ())
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		ibCpPresent
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Return ( ibCpPresent )
end function

public subroutine uf_btsupcpart (integer aitypetrt);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Interlocuteur::uf_BtSupCPart			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va supprimer le courrier particulier
//*
//* Arguments		: (Val)		Integer				aiTypeTrt			Type de traitement demand$$HEX1$$e900$$ENDHEX$$
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ     PAR      Date	  		Modification
//* #1 		DGA      19/09/2006  Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire DCMP-060643
//*-----------------------------------------------------------------

String sRepTmp, sJoker, sNomFic, sNomFicComplet, sNull
Long lIdInter, lTotFichier, lCpt

SetNull ( sNull )

/*------------------------------------------------------------------*/
/* Cette fonction est appel$$HEX1$$e900$$ENDHEX$$e en appuyant sur le bouton Effacer de  */
/* la fen$$HEX1$$ea00$$ENDHEX$$tre des Interlocuteurs. Elle est aussi appel$$HEX1$$e900$$ENDHEX$$e dans la    */
/* fonction Uf_Supprimer de cette m$$HEX1$$ea00$$ENDHEX$$me fen$$HEX1$$ea00$$ENDHEX$$tre.                     */
/*------------------------------------------------------------------*/
lIdInter = idw_wInter.GetItemNumber  ( 1, isZn_IdInter )
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re tous les fichiers du type                            */
/* C:\WINNT\TEMP\XXXX99_X*.*.                                       */
/*------------------------------------------------------------------*/
/* XXXX = Code de l'application sur 4 caract$$HEX1$$e800$$ENDHEX$$res obligatoires.      */
/* 99   = ID_INTER sur deux positions obligatoires (Ex:02,12).      */
/* 9    = COD_INTER.                                                */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sRepTmp	= stGLB.sWinDir + "\TEMP\" 
sRepTmp	= stGLB.sRepTempo
sJoker	= sRepTmp + stGLB.sCodAppli + String ( lIdInter, "00" ) + "*.*"

ilb_Fichier.Reset ()
ilb_Fichier.DirList ( sJoker, 0 )

lTotFichier = ilb_Fichier.TotalItems ()
/*------------------------------------------------------------------*/
/* Normalement, il doit y avoir un seul fichier.                    */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTotFichier
		ilb_Fichier.SelectItem ( lCpt )
		sNomFic			= ilb_Fichier.SelectedItem ()
		sNomFicComplet = Upper ( sRepTmp + sNomFic )
/*------------------------------------------------------------------*/
/* Dans tous les autres cas, on supprime le fichier WORD.           */
/*------------------------------------------------------------------*/
		If Not FileDelete ( sNomFicComplet ) Then
			stMessage.sTitre		= "N_Cst_Saisie_Validation_Interlocuteur - uf_BtSupCPart ()"
			stMessage.sVar[1]		= sNomFicComplet
			stMessage.Icon			= StopSign!
			stMessage.bErreurG	= TRUE
			stMessage.sCode		= "SVAL20"
			stMessage.bTrace  	= False

			F_Message ( stMessage )

			Exit
		Else
			idw_wInter.SetItem ( 1, "ALT_PART", "N" )
			idw_wInter.SetItem ( 1, "ID_COUR", sNull )
			idw_wInter.SetItem ( 1, "ID_NAT_COUR", sNull )
		End If
Next

If aiTypeTrt = 1	Then
/*------------------------------------------------------------------*/
/* Mise $$HEX2$$e0002000$$ENDHEX$$jour du bouton CP.                                        */
/*------------------------------------------------------------------*/
	This.uf_MajBoutonCp ()
End If
end subroutine

public function integer uf_btcpart_savane (string astxtdata);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Interlocuteur::uf_BtCPart_Savane			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va ins$$HEX1$$e900$$ENDHEX$$rer le courrier particulier pour l'application SAVANE
//*
//* Arguments		: (Val)		String			asTxtData		Data de l'interlocuteur
//*
//* Retourne		: Integer							 1 = Tout est  OK
//*															-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1       FS       02/11/2001 : Gestion des mod$$HEX1$$e800$$ENDHEX$$les ?C0000 pour les
//*                                courriers particuliers
//*-----------------------------------------------------------------

N_Cst_Edition_Courrier		nvGenCourrier
String							sCodInter, sIdCourType, sTxtCompo, sIdPara, sCptVer
String							sTitre, sCodBAc, sAltGen
Long								lCpt, lTotLigne, lLig, lIdSin, lIdInter
Integer							iRet

iRet = 1
/*------------------------------------------------------------------*/
/* On lance le rafraichissement des diverses informations.          */
/*------------------------------------------------------------------*/
This.uf_MajBoutonCp ()

nvGenCourrier	= CREATE N_Cst_Edition_Courrier
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le type de l'interlocuteur.                          */
/*------------------------------------------------------------------*/
sCodInter		= idw_wInter.GetItemString ( 1, isZn_CodInter )

/*------------------------------------------------------------------*/
/* En fonction du type de l'interlocuteur, on positionne une        */
/* valeur de courrier type. Cette valeur devra $$HEX1$$ea00$$ENDHEX$$tre positionn$$HEX1$$e900$$ENDHEX$$e     */
/* dans COUR_TYPE.                                                  */
/* #1 FS le 02/11/2001                                              */
/*    les mod$$HEX1$$e800$$ENDHEX$$les utilis$$HEX1$$e900$$ENDHEX$$s sont code inter + "C0000"                */
/* AC0000     COURRIER ASSURE INFO                                  */
/* BC0000     COURRIER INFO BANQUE                                  */
/* CC0000     COURRIER INFO CIE AERIENNE                            */
/* DC0000     EXPERTISE MEDICALE                                    */
/* GC0000     Courrier Info Gie CB                                  */
/* LC0000     COURRIER INFO LOUEUR                                  */
/* SC0000     COURRIER INFO ASSUREUR                                */
/* TC0000     COURRIER INFO INTERLOCUTEUR                           */
/*------------------------------------------------------------------*/

sIdCourType = sCodInter + "C0000"

/*------------------------------------------------------------------*/
/* Une fois la nature de courrier positionn$$HEX1$$e900$$ENDHEX$$e, on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la       */
/* composition.                                                     */
/*------------------------------------------------------------------*/
idw_Compo.Reset ()
idw_Compo.Retrieve ( sIdCourType )
idw_Compo.Sort ()

lTotLigne = idw_Compo.RowCount ()
sTxtCompo = ""
For	lCpt = 1 To lTotLigne
		sIdPara = idw_Compo.GetItemString ( lCpt, "ID_PARA" )
		If	sIdPara = "POST" Or sIdPara = "MACI" Then Continue

		sCptVer = idw_Compo.GetItemString ( lCpt, "CPT_VER" )
		sTxtCompo = sTxtCompo + sIdPara + "." + sCptVer
Next

lIdSin	= Long ( isIdSin )
lIdInter	= Long ( idw_wInter.GetItemString ( 1, isZn_IdInter ) )
			
/*------------------------------------------------------------------*/
/* On positionne la DW permettannt de g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer le courrier           */
/* particulier.                                                     */
/*------------------------------------------------------------------*/
idw_GenCourrier.Reset ()
lLig = idw_GenCourrier.InsertRow ( 0 )
/*------------------------------------------------------------------*/
/* On donne un titre $$HEX2$$e0002000$$ENDHEX$$la fen$$HEX1$$ea00$$ENDHEX$$tre. (XXXX99_X*.*)                    */
/*------------------------------------------------------------------*/
/* XXXX = Code de l'application sur 4 caract$$HEX1$$e800$$ENDHEX$$res obligatoires.      */
/* 99   = ID_INTER sur deux positions obligatoires (Ex:02,12).      */
/* 9    = COD_INTER.                                                */
/*------------------------------------------------------------------*/
sTitre		= stGLB.sCodAppli + String ( lIdInter, "00" ) + "_" + sCodInter + ".DOC"
/*------------------------------------------------------------------*/
/* Tous les courriers sont $$HEX1$$e900$$ENDHEX$$dit$$HEX1$$e900$$ENDHEX$$s sur le bac du BAS.                */
/*------------------------------------------------------------------*/
sCodBac		= "BAS"
/*------------------------------------------------------------------*/
/* Si un courrier particulier est d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$pr$$HEX1$$e900$$ENDHEX$$sent sur disque, il faut  */
/* l'ouvrir et non l'$$HEX1$$e900$$ENDHEX$$craser.                                       */
/*------------------------------------------------------------------*/
If	This.uf_Get_CpPresent ()	Then
	sAltGen = "N"
Else
	sAltGen = "O"
End If

idw_GenCourrier.SetItem ( lLig, "ID_SIN", lIdSin )
idw_GenCourrier.SetItem ( lLig, "ID_INTER", lIdInter )
idw_GenCourrier.SetItem ( lLig, "ID_SEQ", 1 )
idw_GenCourrier.SetItem ( lLig, "ID_COUR", sIdCourType )
idw_GenCourrier.SetItem ( lLig, "TXT_COMPO", sTxtCompo )
idw_GenCourrier.SetItem ( lLig, "TXT_DATA", asTxtData )
idw_GenCourrier.SetItem ( lLig, "TITRE", sTitre )
idw_GenCourrier.SetItem ( lLig, "COD_BAC", sCodBac )
idw_GenCourrier.SetItem ( lLig, "FIC_ENTETE", isFicEntete )
idw_GenCourrier.SetItem ( lLig, "ALT_GEN", sAltGen )

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie s'il faut fermer des courriers ouverts et non         */
/* enregistr$$HEX1$$e900$$ENDHEX$$s.                                                     */
/*------------------------------------------------------------------*/
iRet = nvGenCourrier.uf_Verifier_Word_AvantGeneration ( FALSE )
/*------------------------------------------------------------------*/
/* On affiche le courrier particulier.                              */
/*------------------------------------------------------------------*/
If	iRet > 0	Then
	nvGenCourrier.uf_Initialiser ( "E" )

	If	nvGenCourrier.uf_InitialiserWord ( FALSE ) = 1	Then
		iRet = nvGenCourrier.uf_Generer_Courrier ( idw_GenCourrier, TRUE )
	End If
End If

DESTROY	nvGenCourrier

Return ( iRet )
end function

public function integer uf_btcpart_simpa2 (string astxtdata);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Interlocuteur::uf_BtCPart_Simpa2			(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 22/03/2004 16:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va ins$$HEX1$$e900$$ENDHEX$$rer le courrier particulier pour l'application SIMPA2
//*
//* Arguments		: (Val)		String			asTxtData		Data de l'interlocuteur
//*
//* Retourne		: Integer							 1 = Tout est  OK
//*															-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1       FS       02/11/2001 : Gestion des mod$$HEX1$$e800$$ENDHEX$$les ?C0000 pour les
//*                                courriers particuliers
//* DCMP030483 JFF  #2  07/01/04 Ajout d'une nouvelle fonctionnalit$$HEX2$$e9002000$$ENDHEX$$permettant
//*										de choisir son mod$$HEX1$$e800$$ENDHEX$$le de CP parmi toutes les natures
//* 										dispo pour le produit.
//* #3		 PHG		 15/11/2006 [DNTMAIL1-2] Prise en compte du canal pour la composition
//* #4	    JCA	16/05/2007	DCMP 070051 - Fusion des tables [courrier] et composition] en [cour_prod]
//*          JFF  18/07/2010  [PM159]
//* 		    JFF     25/10/2011  [PC363][LOGO_AUCHAN]
//*			 JFF  09/12/2012 [VDOC5983]
//       JFF  26/04/2023 [RS5045_REF_MATP]
//*-----------------------------------------------------------------

N_Cst_Edition_Courrier		nvGenCourrier
String							sCodInter, sIdCourType, sTxtCompo, sIdPara, sCptVer, sIdParaBase
String							sTitre, sCodBAc, sAltGen, sParaTempo[], sVersion
Long								lCpt, lTotLigne, lLig, lIdSin, lIdInter, lRowInter
Integer							iRet, iTot, iCpt
s_Choix_Modele_CP stModCour
DataWindowChild dwChild
String sAltSuiviMail			// #3 [DNTMAIL1-2]
String sAdrMail				// #3 [DNTMAIL1-2]
String sId_canal				// #3 [DNTMAIL1-2]
Long   lDeb, lFin, lDebDp188
String sModele
n_cst_string lnvPFCString
Long lCptIdCie, dcIdSin, dcIdRev, dcIdGti, lIdCie
String sIdCie, sIdCanal, sIdCanalDetPro, sIdCieDetPro 
Boolean bIdCieTrouve, bgTInterCP_Trouve
Int iTot_idwGenCourrier, iCpt_idwGenCourrier, dcIdI, iCptDetPro 	// [RS5045_REF_MATP]
Int TInter []
String TModele []
String sAdrMailName, sAdrMailDomain
Int iTot_gTInterCP, iCpt_gTInterCP, iTot_TInter, iCpt_TInter

Long lIdProd // #4
lIdProd  = iidw_WSin.GetItemNumber ( 1, "ID_PROD" ) // #4

bgTInterCP_Trouve = False

iRet = 1
sTxtCompo = ""
/*------------------------------------------------------------------*/
/* On lance le rafraichissement des diverses informations.          */
/*------------------------------------------------------------------*/
This.uf_MajBoutonCp ()

nvGenCourrier	= CREATE N_Cst_Edition_Courrier
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le type de l'interlocuteur.                          */
/*------------------------------------------------------------------*/
sCodInter		= idw_wInter.GetItemString ( 1, isZn_CodInter )

/*------------------------------------------------------------------*/
/* #2 DCMP030483 JFF le 07/01/2004                                  */
/*------------------------------------------------------------------*/
/* Ouverture d'une Response.                                        */
/*------------------------------------------------------------------*/
Choose Case This.uf_Get_CpPresent ()	

	Case FALSE
		idw_wInter.GetChild ( "ID_NAT_COUR", dwChild )
		stModCour.dwNatCour = dwChild

		OpenWithParm ( w_t_sp_choix_courrier_cp, stModCour )
		stModCour = Message.PowerObjectParm

		If stModCour.sIdCour = "RETOUR" Then
			Return 1
		End If

	Case TRUE
		stModCour.sIdCour = "" 		
End Choose 

sIdCourType = stModCour.sIdCour 

/*------------------------------------------------------------------*/
/* Si la compo revient vide, le gestionnaire a choisi le CP         */
/* standard SPB																	  */
/*------------------------------------------------------------------*/
If stModCour.sIdCour = "" And Not This.uf_Get_CpPresent ()	Then 

	Choose Case idw_wInter.GetItemString ( 1, "COD_INTER" )
		Case "B"						// Interlocuteur type banque
			sParaTempo[1]	=	"IB01"
			sParaTempo[2]	=	"FP02"
			sParaTempo[3]	=	"CR01"

		Case Else					// tous les autres cas ( assur$$HEX2$$e9002000$$ENDHEX$$inclus )


			// [VDOC5983]
			sIdParaBase = Space ( 4 )
			SQLCA.PS_S_COUR_PROD_PARA_APART1 (lIdProd, 1, sIdParaBase) 
			
			If Trim ( sIdParaBase ) = "PART" Or IsNull ( sIdParaBase ) Or Trim ( sIdParaBase ) = "" Then
				sParaTempo[1] = "IA01"
				sParaTempo[2] = "FP01"
				sParaTempo[3] = "CR01"
			Else
				sParaTempo[1] = sIdParaBase
	
				SQLCA.PS_S_COUR_PROD_PARA_APART1 (lIdProd, 2, sIdParaBase ) 			
				sParaTempo[2] = sIdParaBase
				SQLCA.PS_S_COUR_PROD_PARA_APART1 (lIdProd, 3, sIdParaBase ) 			
				sParaTempo[3] = sIdParaBase
			End If
			
	End Choose

/*------------------------------------------------------------------*/
/* Lecture de la version actuelle du paragraphe                     */
/*------------------------------------------------------------------*/
	iTot  = UpperBound ( sParaTempo )
	For iCpt = 1 to iTot  

		sVersion = "   "

		SQLCA.IM_S02_PARAGRAPHE ( sParaTempo [ iCpt ], sVersion )
		If	Not F_Procedure ( stMessage, SQLCA, "IM_S02_PARAGRAPHE" )	Then 

/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la proc$$HEX1$$e900$$ENDHEX$$dure, la structure     */
/* stMessage vient d'$$HEX1$$ea00$$ENDHEX$$tre arm$$HEX1$$e900$$ENDHEX$$e, on affiche le message.             */
/*------------------------------------------------------------------*/

			f_Message ( stMessage )
			sParaTempo [ iCpt ]	= ""
		Else

			sParaTempo [ iCpt ] += "." + sVersion

		End If

	   sTxtCompo += sParaTempo [ iCpt ]
	Next
End If

/*------------------------------------------------------------------*/
/* Sinon il a choisi un mod$$HEX1$$e800$$ENDHEX$$le de courrier auto							  */
/*------------------------------------------------------------------*/
If stModCour.sIdCour <> "" And Not This.uf_Get_CpPresent ()	Then 

	/*------------------------------------------------------------------*/
	/* Une fois la nature de courrier positionn$$HEX1$$e900$$ENDHEX$$e, on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la       */
	/* composition.                                                     */
	/*------------------------------------------------------------------*/
	idw_Compo.Reset ()
	// #4
	//idw_Compo.Retrieve ( sIdCourType )
	idw_Compo.Retrieve ( sIdCourType, lIdProd )
	// #4 - FIN
	idw_Compo.Sort ()

	lTotLigne = idw_Compo.RowCount ()
	For	lCpt = 1 To lTotLigne
			sIdPara = idw_Compo.GetItemString ( lCpt, "ID_PARA" )

			// On supprime tout ce qui ne servira pas
			Choose Case sIdPara
				Case "MACP", "PIEC", "MACI", "POST"	
					Continue
			End Choose

			sCptVer = idw_Compo.GetItemString ( lCpt, "CPT_VER" )
			sTxtCompo = sTxtCompo + sIdPara + "." + sCptVer
	Next
End If

lIdSin	= Long ( isIdSin )
lIdInter	= idw_wInter.GetItemNumber ( 1, isZn_IdInter ) 
			
/*------------------------------------------------------------------*/
/* On positionne la DW permettannt de g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer le courrier           */
/* particulier.                                                     */
/*------------------------------------------------------------------*/
idw_GenCourrier.Reset ()
lLig = idw_GenCourrier.InsertRow ( 0 )
/*------------------------------------------------------------------*/
/* On donne un titre $$HEX2$$e0002000$$ENDHEX$$la fen$$HEX1$$ea00$$ENDHEX$$tre. (XXXX99_X*.*)                    */
/*------------------------------------------------------------------*/
/* XXXX = Code de l'application sur 4 caract$$HEX1$$e800$$ENDHEX$$res obligatoires.      */
/* 99   = ID_INTER sur deux positions obligatoires (Ex:02,12).      */
/* 9    = COD_INTER.                                                */
/*------------------------------------------------------------------*/
sTitre		= stGLB.sCodAppli + String ( lIdInter, "00" ) + "_" + sCodInter + ".DOC"
/*------------------------------------------------------------------*/
/* Tous les courriers sont $$HEX1$$e900$$ENDHEX$$dit$$HEX1$$e900$$ENDHEX$$s sur le bac du BAS.                */
/*------------------------------------------------------------------*/
sCodBac		= "BAS"

/*------------------------------------------------------------------*/
/* Si un courrier particulier est d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$pr$$HEX1$$e900$$ENDHEX$$sent sur disque, il faut  */
/* l'ouvrir et non l'$$HEX1$$e900$$ENDHEX$$craser.                                       */
/*------------------------------------------------------------------*/
If	This.uf_Get_CpPresent ()	Then
	sAltGen = "N"
Else
	sAltGen = "O"
End If

idw_GenCourrier.SetItem ( lLig, "ID_SIN", lIdSin )
idw_GenCourrier.SetItem ( lLig, "ID_INTER", lIdInter )
idw_GenCourrier.SetItem ( lLig, "ID_SEQ", 1 )
idw_GenCourrier.SetItem ( lLig, "ID_COUR", sIdCourType )
idw_GenCourrier.SetItem ( lLig, "TXT_COMPO", sTxtCompo )
idw_GenCourrier.SetItem ( lLig, "TXT_DATA", asTxtData )
idw_GenCourrier.SetItem ( lLig, "TITRE", sTitre )
idw_GenCourrier.SetItem ( lLig, "COD_BAC", sCodBac )
idw_GenCourrier.SetItem ( lLig, "FIC_ENTETE", isFicEntete )
idw_GenCourrier.SetItem ( lLig, "ALT_GEN", sAltGen )

/*--------------------------------------------------------------------------------------------------*/
/* #3 15/11/2006 [DNTMAIL1-2] PHG                                                                   */
/* Report code de l'open de la fenetre appelante suivante point 4.4.1 sp$$HEX1$$e900$$ENDHEX$$cification DNTMAIL1/2      */ 
/* Initialisation du canal selon la r$$HEX1$$e900$$ENDHEX$$gle suivante : Si champ ADR_MAIL est renseign$$HEX17$$e9002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
/* et que la zone ALT_SUIVI_MAIL est coch$$HEX2$$e9002000$$ENDHEX$$alors c'est un envoi par MAIL SINON envoi par COURRIER   */
/*--------------------------------------------------------------------------------------------------*/

sAltSuiviMail = idw_wInter.GetItemString (1 , "ALT_SUIVI_MAIL")

// [PM159]
sAltSuiviMail = "O" // [PM159]	

// [RS5045_REF_MATP]
If F_CLE_NUMERIQUE ( "RS5045_REF_MATP" ) >= 3 Then
	sAdrMail = idw_wInter.GetItemString (1 , "ADR_MAIL")
	sAdrMailName = idw_wInter.GetItemString (1 , "ADR_MAIL_NAME")
	sAdrMailDomain = idw_wInter.GetItemString (1 , "ADR_MAIL_DOMAIN")
	
	If IsNull ( sAdrMailName ) Or Trim ( sAdrMailName ) = "" Or IsNull ( sAdrMailDomain ) Or Trim ( sAdrMailDomain ) = "" Then
		sAdrMail = ""
	End IF 
	
	If Not ( IsNull ( sAdrMailName ) Or Trim ( sAdrMailName ) = "" Or IsNull ( sAdrMailDomain ) Or Trim ( sAdrMailDomain ) = "" ) Then
		sAdrMail = sAdrMailName + "@" + sAdrMailDomain
	End IF 

	
Else 
	sAdrMail = idw_wInter.GetItemString (1 , "ADR_MAIL")
End If 


IF sAltSuiviMail = "O" And NOT (Isnull (sAdrMail) OR Trim ( sAdrMail ) = "" ) THEN
	sId_canal = "MA"
Else
	sId_canal = "CO"
End If
idw_GenCourrier.SetItem ( lLig, "ID_CANAL", sId_Canal )
// Fin [DNTMAIL1-2] PHG 30/10/2006

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie s'il faut fermer des courriers ouverts et non         */
/* enregistr$$HEX1$$e900$$ENDHEX$$s.                                                     */
/*------------------------------------------------------------------*/
iRet = nvGenCourrier.uf_Verifier_Word_AvantGeneration ( FALSE )
/*------------------------------------------------------------------*/
/* On affiche le courrier particulier.                              */
/*------------------------------------------------------------------*/
If	iRet > 0	Then
	nvGenCourrier.uf_Initialiser ( "E" )

	If	nvGenCourrier.uf_InitialiserWord ( FALSE ) = 1	Then

		// [RS5045_REF_MATP]
		// Gestion des mod$$HEX1$$e800$$ENDHEX$$les pour le m$$HEX1$$e900$$ENDHEX$$dia MAIL
		// R$$HEX1$$e800$$ENDHEX$$gles :
		// Si M$$HEX1$$e900$$ENDHEX$$dia "Par mail" Et absence de DP368 Alors Mod$$HEX1$$e800$$ENDHEX$$le par d$$HEX1$$e900$$ENDHEX$$faut COURRIER_SPB.DOT pour A et T
		// Si M$$HEX1$$e900$$ENDHEX$$dia "Par mail" Et pr$$HEX1$$e900$$ENDHEX$$sence de DP368 Alors Mod$$HEX1$$e800$$ENDHEX$$le de la DP368 pour l'Inter donn$$HEX1$$e900$$ENDHEX$$
		// On n'emp$$HEX1$$ea00$$ENDHEX$$che l'armement plus g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ral et existant de la DP188, mais la DP/368 l'emportera dans le traitement sur n_cst_edition_courrier

		F_RechDetPro ( lDebDp188, lFin, idwDetPro, lIdProd, "-DP", 188 )
		
		
		If F_CLE_NUMERIQUE ( "RS5045_REF_MATP" ) >= 3 Then

			iTot_idwGenCourrier = idw_GenCourrier.RowCount ()	
	
			// LA boucle ne sert $$HEX2$$e0002000$$ENDHEX$$rien car il n'y a qu'un inter dans notre cas, mais code repris d'autre part
			For iCpt_idwGenCourrier = 1 To iTot_idwGenCourrier
				dcIdI = idw_GenCourrier.GetItemNumber ( iCpt_idwGenCourrier, "ID_INTER" ) 
				sIdCanal = idw_GenCourrier.GetItemString ( iCpt_idwGenCourrier, "ID_CANAL" ) 


				If F_CLE_NUMERIQUE ( "RS5045_REF_MATP" ) >= 4 Then
					If lDebDp188 <= 0 Then
						// Par d$$HEX1$$e900$$ENDHEX$$faut, si le canal est mail, on mets au moins le mod$$HEX1$$e800$$ENDHEX$$le courrier_spb.dot qui pourrai $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$cras$$HEX2$$e9002000$$ENDHEX$$ensuite
						TInter [iCpt_idwGenCourrier] = dcIdI
						
						Choose Case sIdCanal 
							Case "MA"
								TModele [iCpt_idwGenCourrier] = ProfileString ( stGLB.sFichierIni, "EDITION", "MODELE_MAIL",  "" )
							Case Else // CO d$$HEX1$$e900$$ENDHEX$$faut
								TModele [iCpt_idwGenCourrier] = ProfileString ( stGLB.sFichierIni, "EDITION", "MODELE",  "" )
						End Choose 
					End If 
				Else
					If sIdCanal = "MA" And lDebDp188 <= 0 Then
						// Par d$$HEX1$$e900$$ENDHEX$$faut, si le canal est mail, on mets au moins le mod$$HEX1$$e800$$ENDHEX$$le courrier_spb.dot qui pourrai $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$cras$$HEX2$$e9002000$$ENDHEX$$ensuite
						TInter [iCpt_idwGenCourrier] = dcIdI
						TModele [iCpt_idwGenCourrier] = ProfileString ( stGLB.sFichierIni, "EDITION", "MODELE_MAIL",  "" )
					End If 
				End If 

	
	
				// Mais si l'option 368 dit autre chose en fonction du contexte..., on $$HEX1$$e900$$ENDHEX$$crase alors.
				F_RechDetPro ( lDeb, lFin, idwDetPro, lIdProd, "-DP", 368 )
				If lDeb > 0 Then
	
					sCodInter = idw_wInter.GetItemString ( 1, "COD_INTER" )
		
					For iCptDetPro = lDeb To lFin
						If idwDetPro.GetItemString ( iCptDetPro, "ID_CODE_CAR" ) = sCodInter Then
							sIdCanalDetPro = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( iCptDetPro, "VAL_CAR" ), "CANAL", ";")
							sIdCieDetPro = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( iCptDetPro, "VAL_CAR" ), "ID_CIE", ";")							
	
							SQLCA.PS_S_ID_CIE ( dcIdSin, dcIdRev, dcIdGti, lIdCie )
							
							bIdCieTrouve = False
							If sIdCieDetPro <> "" Then
								dcIdSin = iidw_WSin.GetItemNumber ( 1, "ID_SIN" ) 
								dcIdRev = iidw_WSin.GetItemNumber ( 1, "ID_REV" ) 
								SetNull ( dcIdGti )
								
								If lIdCie = Long ( sIdCieDetPro ) Then
									bIdCieTrouve = True
								End IF 
								
							End If 
							
							If sIdCanalDetPro = sIdCanal And ( bIdCieTrouve Or sIdCieDetPro = "" ) Then	
								TInter [iCpt_idwGenCourrier] = dcIdI
								TModele [iCpt_idwGenCourrier] = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( iCptDetPro, "VAL_CAR" ), "MODELE", ";")
							End IF 
						End If 
					Next 
				End If 
			Next 
			
			nvGenCourrier.uf_SetModeleParMediaEtInter ( TInter, TModele)
			
		End If	



		// [RS848_RS908]
		F_RechDetPro ( lDeb, lFin, idwDetPro, lIdProd, "-DP", 188 )
		If lDeb > 0 Then
			sIdCie = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "ID_CIE", ";")
			If sIdCie = "" Then 
				lFin = lDeb // Si pas de param IdCir sur la premi$$HEX1$$e800$$ENDHEX$$re, on ne va pas plus loin
				bIdCieTrouve = TRUE
			End If 
			
			If lFin > lDeb Then
				dcIdSin = iidw_WSin.GetItemNumber ( 1, "ID_SIN" ) 
				dcIdRev = iidw_WSin.GetItemNumber ( 1, "ID_REV" ) 
				SetNull ( dcIdGti )
				SQLCA.PS_S_ID_CIE ( dcIdSin, dcIdRev, dcIdGti, lIdCie )
				
				bIdCieTrouve = False
				For lCptIdCie = lDeb To lFin
					sIdCie = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lCptIdCie, "VAL_CAR" ), "ID_CIE", ";")
					
					If lIdCie = Long ( sIdCie ) Then
						lDeb = lCptIdCie 
						bIdCieTrouve = TRUE
						Exit
					End If 
				Next 
			End If 
			
			// Si pr$$HEX1$$e900$$ENDHEX$$sence de dp/188 avec "des" mod$$HEX1$$e800$$ENDHEX$$les mais aucune correspondance id_cie, alors on garde courrier.dot.
			If bIdCieTrouve Then
				sModele = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "MODELE", ";")
		
				If Trim ( sModele ) <> "" And Not IsNull ( sModele ) Then 
					nvGenCourrier.uf_changerModele ( sModele )
				End If
			End IF 			
			
		End If 

		// [RS5045_REF_MATP]
		If F_CLE_NUMERIQUE ( "RS5045_REF_MATP" ) >= 3 Then
			iTot_gTInterCP = UpperBound ( gTInterCP )

			For iCpt_gTInterCP = 1 To iTot_gTInterCP 
				If gTInterCP [ iCpt_gTInterCP ] = dcIdI Then
					gTModeleCP [ iCpt_gTInterCP ] = sModele 
					
					iTot_TInter = UpperBound ( TInter ) 
					For iCpt_TInter = 1 To iTot_TInter 
						If TInter [ iCpt_TInter ] = dcIdI Then
							gTModeleCP [ iCpt_gTInterCP ] = TModele [ iCpt_TInter ] 
						End IF 
					Next 
					bgTInterCP_Trouve = True
					Exit
				End If 
			Next 
			
			IF iTot_gTInterCP = 0 Or Not bgTInterCP_Trouve Then
				iTot_TInter = UpperBound ( TInter ) 
				gTInterCP  [ iTot_gTInterCP + 1 ] = dcIdI
				gTModeleCP [ iTot_gTInterCP + 1 ] = sModele 
				
				For iCpt_TInter = 1 To iTot_TInter 
					If TInter [ iCpt_TInter ] = dcIdI Then
						gTModeleCP [ iTot_gTInterCP + 1 ] = TModele [ iCpt_TInter ] 
					End IF 
				Next 
			End If 
			
			
		End If 
		
		iRet = nvGenCourrier.uf_Generer_Courrier ( idw_GenCourrier, TRUE )
	End If
End If

DESTROY	nvGenCourrier

Return ( iRet )
end function

public function integer uf_initialiser (string asidappli, ref listbox albfichier, ref commandbutton acbcourpart, ref commandbutton acbeffacer, ref datawindow adwcompo, ref datawindow adwgencourrier, ref datawindow aidw_wsin, ref datawindow adwdetpro);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Interlocuteur::uf_Initialiser			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On pr$$HEX1$$e900$$ENDHEX$$pare toutes les variables dont on va avoir besoin
//*
//* Arguments		: (Val)		String					asIdAppli				Nom de l'application
//*					  (R$$HEX1$$e900$$ENDHEX$$f)		ListBox					albFichier				ListBox pos$$HEX2$$e9002000$$ENDHEX$$sur la fen$$HEX1$$ea00$$ENDHEX$$tre
//*					  (R$$HEX1$$e900$$ENDHEX$$f)		CommandButton			acbCourPart				Bouton permettant de cr$$HEX1$$e900$$ENDHEX$$er un courrier particulier
//*					  (R$$HEX1$$e900$$ENDHEX$$f)		CommandButton			acbEffacer				Bouton permettant d'effacer un courrier particulier
//*					  (R$$HEX1$$e900$$ENDHEX$$f)		DataWindow				adwCompo					DataWindow permettant de r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer la composition
//*					  (R$$HEX1$$e900$$ENDHEX$$f)		DataWindow				adwGenCourrier			DataWindow permettant de g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer le courrier particulier
//*					  (R$$HEX1$$e900$$ENDHEX$$f)		DataWindow				aidw_wsin				DataWindow permettant de r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le produit
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  		Modification
//* #1		JCA		19/05/2006	DntMail - Deplacement des boutons dans wm_tm_sp_interlocuteur.wf_positionnerobject
//* #2		JCA		16/05/2007	DCMP 070051 - Fusion des tables [courrier] et composition] en [cour_prod]
//* 		   JFF      25/10/2011  [PC363][LOGO_AUCHAN]
//*-----------------------------------------------------------------

isIdAppli = asIdAppli

/*------------------------------------------------------------------*/
/* En fonction de l'application SAVANE, SIMPA2, SINDI les noms de   */
/* colonnes sont diff$$HEX1$$e900$$ENDHEX$$rents. Il faut donc armer une constante pour  */
/* que cette fen$$HEX1$$ea00$$ENDHEX$$tre puisse fonctionner dans tous les cas de        */
/* figure.                                                          */
/*------------------------------------------------------------------*/
Choose Case isIdAppli
Case "SAVANE"
	isZn_IdInter	= "ID_I"
	isZn_CodInter	= "COD_I"
	isFicEntete		= ProfileString ( stGLB.sFichierIni, "EDITION", "ENTETE", "" )

Case "SIMPA2"
	isZn_IdInter	= "ID_I"
	isZn_CodInter	= "COD_INTER"
Case "SINDI"
	isZn_IdInter	= "ID_INTER"
	isZn_CodInter	= "COD_I"
End Choose

/*------------------------------------------------------------------*/
/* On positionne une instance pour la ListBox. Cet objet sert dans  */
/* la fonction uf_CourWord_PurgerCourriersLocal ().                 */
/*------------------------------------------------------------------*/
ilb_Fichier = albFichier

/*------------------------------------------------------------------*/
/* On positionne une instance pour le NVUO sur les fonctions        */
/* Windows.                                                         */
/*------------------------------------------------------------------*/
invWin = stGLB.uoWin


/*------------------------------------------------------------------*/
/* On positionne les boutons en les laissant invisibles.            */
/*------------------------------------------------------------------*/
icbEffacer	= acbEffacer
icbCourPart	= acbCourPart

// #1
//icbCourPart.X			=   89
//icbCourPart.Y			= 1410
//icbCourPart.Width		=  394
//icbCourPart.Height	=   77
//
//icbEffacer.X			= 2190
//icbEffacer.Y			= icbCourPart.Y
//icbEffacer.Width		=  284
//icbEffacer.Height		= icbCourPart.Height
// #1 FIN

/*------------------------------------------------------------------*/
/* DataWindow permettant de g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer une composition pour un         */
/* courrier particulier.                                            */
/*------------------------------------------------------------------*/
idw_Compo = adwCompo
idw_Compo.SetTransObject ( SQLCA )
idw_Compo.SetSort ( "ID_ORDRE" )
/*------------------------------------------------------------------*/
/* DataWindow external permettant de g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer le courrier            */
/* particulier poir l'interlocuteur en cours de traitement.         */
/*------------------------------------------------------------------*/
idw_GenCourrier = adwGenCourrier

iidw_WSin = aidw_wsin // #2

// [PC363][LOGO_AUCHAN]
idwDetPro = adwDetPro


Return ( 1 )

end function

on n_cst_saisie_validation_interlocuteur.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_saisie_validation_interlocuteur.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

