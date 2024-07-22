HA$PBExportHeader$u_gs_sp_sinistre_contact_trace.sru
$PBExportComments$---} User Object pour la gestion de la trace des contacts
forward
global type u_gs_sp_sinistre_contact_trace from nonvisualobject
end type
end forward

global type u_gs_sp_sinistre_contact_trace from nonvisualobject
end type
global u_gs_sp_sinistre_contact_trace u_gs_sp_sinistre_contact_trace

type variables
Private:

u_DataWindow		iDwSin
u_DataWindow_Detail	iDwContact
DataWindow		iDwProduit
u_DataWindow		iDwDosSuiviPar

u_Transaction		iTrTrans

String	isFicTraceCont, isFicEssaiTrcCont
String	isFicTraceTrv, isFicEssaiTrcTrv
String	isNomMachine
String	isCodTravail, isAltQueue

DateTime			idtDteFinGti
Boolean			ibComplementOk
end variables

forward prototypes
public subroutine uf_ecriretrace (integer aimode)
private function boolean uf_verif_ecrituretrace ()
public subroutine uf_set_dtefingti (datetime adtdtefingti, Boolean abComplOk)
private subroutine uf_ecriretracetrv (long allignelst)
public subroutine uf_initialiser (ref u_datawindow adwsin, ref u_datawindow_detail adwcontact, ref datawindow adwproduit, ref u_datawindow adwdossuivipar, ref u_transaction atrtrans)
public function integer uf_retour_gestiontrace (ref boolean abokpourfermer, string asatraiterpar)
private function boolean uf_insertion_travail (long alligne, string asatraiterpar)
public subroutine uf_retour_gestionsherpa (boolean abokpourfermer)
end prototypes

public subroutine uf_ecriretrace (integer aimode);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_ecriretrace
//* Auteur			: DBI
//* Date				: 20/12/2000 11:06:52
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Enregistrement de la trace d'un contact
//* Commentaires	: 
//*
//* Arguments		: aiMode		1 : Consult ( on ne traite que les contacts alt_valide=N )
//*									2 : Validation ( on traite tous les contacts )
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String sTrace[], sTraceDeb[13]
String sTab, sLigne, sAltValide
Long lTot, lCpt, lCpt1, lNbContact
DwItemStatus	dwStatus
Boolean	bTrace

sTab = "~t"

sTraceDeb[ 1 ]  = String ( iDwSin.GetItemNumber ( 1, "ID_SIN"  ) )
sTraceDeb[ 2 ]  = String ( iDwSin.GetItemNumber ( 1, "ID_PROD" ) )
sTraceDeb[ 3 ]  = stGLB.sCodServ
sTraceDeb[ 4 ]  = String ( Datetime ( Today(), Now() ), "dd/mm/yyyy hh:mm:ss.ffff" )
sTraceDeb[ 5 ]  = stGLB.sCodOper
sTraceDeb[ 6 ]  = ""
sTraceDeb[ 7 ]  = ""
sTraceDeb[ 8 ]  = ""
sTraceDeb[ 9 ]  = ""
sTraceDeb[ 10]  = ""
sTraceDeb[ 11]  = ""
sTraceDeb[ 12]  = ""
sTraceDeb[ 13]  = ""

lNbContact	 =	idwContact.RowCount ()

/*------------------------------------------------------------------*/
/* Je fais une boucle mais logiquement aujourd'hui, il ne peut y    */
/* avoir qu'un seul contact.                                        */
/*------------------------------------------------------------------*/


For lCpt = 1 To lNbContact

	sAltValide	=	idwContact.GetItemString            ( lCpt, "ALT_VALIDE" )
	bTrace = False

	Choose Case aiMode

		Case 1 			// Consult

			dwStatus	=	idwContact.GetItemStatus ( lCpt, 0, primary! )

/*------------------------------------------------------------------*/
/* Je recherche les nouvelles lignes                                */
/* Attention, l'update sur contact doit se faire                    */
/* avec le flag resetupdate = false                                 */
/* sinon le statut des lignes change.                               */
/*------------------------------------------------------------------*/

			If (( dwStatus   = New! ) Or ( dwStatus = NewModified! ) Or ( dwStatus = DataModified! )) And &
				( sAltValide = "N"  ) Then

				bTrace = True
			End If


		Case 2			// Validation

			If ( sAltValide = "O"  ) Then

				bTrace = True
			End If

	End Choose

	If Not bTrace Then		

		Continue		// On passe au contact suivant
	End If

	sTrace		=	sTraceDeb

	sTrace [6]	=	String ( idwContact.GetItemDatetime ( lCpt, "CREE_LE"   ), "dd/mm/yyyy hh:mm:ss.ffff" )
	sTrace [7]	=	String ( idwContact.GetItemDatetime ( lCpt, "MAJ_LE"    ), "dd/mm/yyyy hh:mm:ss.ffff" )
	sTrace [8]	=	idwContact.GetItemString            ( lCpt, "MAJ_PAR"   )
	sTrace [9]	=	idwContact.GetItemString            ( lCpt, "ID_CANAL"  )
	sTrace [10]	=	idwContact.GetItemString            ( lCpt, "COD_I_PROV")
	sTrace [11]	=	idwContact.GetItemString            ( lCpt, "ID_TYP_MSG")
	sTrace [12]	=	String ( idwContact.GetItemNumber   ( lCpt, "ID_NAT_MSG") )
	sTrace [13]	=	idwContact.GetItemString            ( lCpt, "ALT_VALIDE")

/*------------------------------------------------------------------*/
/* On traite les N-1 valeurs, puis la derni$$HEX1$$e800$$ENDHEX$$re. Pour terminer, on   */
/* ecrit la ligne                                                   */
/*------------------------------------------------------------------*/

	lTot 		= UpperBound ( sTrace[] )
	sLigne	= ""

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie qu'il n'y ait plus de cha$$HEX1$$ee00$$ENDHEX$$ne nulle.                   */
/*------------------------------------------------------------------*/

	For	lCpt1 = 1 To lTot
		If	IsNull ( sTrace[ lCpt1 ] ) Or sTrace[ lCpt1 ] = "''" Then
			sTrace[ lCpt1 ] = ""
		End If
	Next

/*------------------------------------------------------------------*/
/* On traite les N-1 valeurs, puis la derni$$HEX1$$e800$$ENDHEX$$re. Pour terminer, on   */
/* ecrit la ligne                                                   */
/*------------------------------------------------------------------*/

	For	lCpt1 = 1 To lTot - 1
		sLigne = sLigne + sTrace[ lCpt1 ] + sTab
	Next

	sLigne = sLigne + sTrace[ lTot ]

	f_EcrireFichierText ( isFicTraceCont, sLigne )

Next

end subroutine

private function boolean uf_verif_ecrituretrace ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Verif_EcritureTrace (PRIVATE)
//* Auteur			: FABRY
//* Date				: 02/05/2001 15:13:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Test d'$$HEX1$$e900$$ENDHEX$$criture de la trace
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Vrai si test Ok
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Boolean	bOk = True

If	f_Verifier_Ecriture_Trace ( isFicEssaiTrcCont ) < 0	Then

/*------------------------------------------------------------------*/
/* On affiche un message d'erreur que l'on ne peut tracer. On sort  */
/* ensuite imm$$HEX1$$e900$$ENDHEX$$diatement de la fonction.                            */
/*------------------------------------------------------------------*/
	stMessage.sTitre		= "Cr$$HEX1$$e900$$ENDHEX$$ation d'un contact"
	stMessage.Icon			= StopSign!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "APPLI09"
   stMessage.bTrace  	= False

	F_Message ( stMessage )
	bOk = False

End If

Return bOk
end function

public subroutine uf_set_dtefingti (datetime adtdtefingti, Boolean abComplOk);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Set_DteFinGti (PUBLIC)
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 15:50:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: NotFound	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

idtDteFinGti = adtDteFinGti

ibComplementOk = abComplOk

end subroutine

private subroutine uf_ecriretracetrv (long allignelst);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_EcrireTraceTrv ( Private )
//* Auteur			: Erick John Stark
//* Date				: 04/28/97 14:57:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lTot, lCpt

String sTrace[26]
String sLigne, sTab, sCodTravail, sAltQueue
DateTime dtNow

dtNow = DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* On va ecrire une trace dans le fichier.                          */
/* Cette trace contient dans l'ordre                                */
/*                                                                  */
/* COD_APPLI						01                                    */
/* N$$HEX2$$b0002000$$ENDHEX$$Machine						02                                    */
/* COD_SERVICE						03                                    */
/* ID_SIN							04                                    */
/* ID_CORB 							05                                    */
/* NOM + PRENOM					06                                    */
/* COD_ETAT 						07  1 Par d$$HEX1$$e900$$ENDHEX$$faut                      */
/* COD_ACTION 						08                                    */
/* ALT_BLOC 						09  N Par d$$HEX1$$e900$$ENDHEX$$faut                      */
/* TRV_CREE_LE (D$$HEX1$$e900$$ENDHEX$$part)			10                                    */
/* TRV_MAJ_LE (D$$HEX1$$e900$$ENDHEX$$part)			11                                    */
/* TRV_MAJ_LE (Fin)				12                                    */
/* TRV_MAJ_PAR (Fin)				13                                    */
/* TRV_ROUTE_LE (Fin)			14  Vide                              */
/* TRV_ROUTE_PAR (Fin)			15  Vide                              */
/* TRV_EDITE_LE (Fin)			16  Vide                              */
/* TRV_EDITE_PAR (Fin)			17  Vide                              */
/* DOS_MAJ_LE (Fin)				18                                    */
/* DOS_MAJ_PAR (Fin)				19                                    */
/* DOS_MAJ_PAR (Fin)				20                                    */
/* ID_PROD							21                                    */
/* DTE_RECU							22                                    */
/* COD_TYP_RECU					23                                    */
/* COD_RECU							24                                    */
/* COD_I_PROV						25                                    */
/* DTE_COUR_CLI					26                                    */
/*------------------------------------------------------------------*/

sTab = "~t"
lTot = UpperBound ( sTrace )

sTrace[ 1 ]  = stGLB.sCodAppli
sTrace[ 2 ]  = isNomMachine
sTrace[ 3 ]  = stGLB.sCodServ
sTrace[ 4 ]  = String ( idwSin.GetItemNumber ( 1, "ID_SIN" ) )
sTrace[ 5 ]  = String ( idwProduit.GetItemNumber ( 1, "ID_CORB" ) )
sTrace[ 6 ]  = Trim ( idwSin.GetItemString ( 1, "NOM" ) ) + " " + Trim ( idwSin.GetItemString ( 1, "PRENOM" ) )
sTrace[ 7 ]  = "1"
sTrace[ 8 ]  = ""
sTrace[ 9 ]		= "N"
sTrace[ 10 ]	= String ( dtNow, "dd/mm/yyyy hh:mm:ss.ff" )
sTrace[ 11 ]	= String ( dtNow, "dd/mm/yyyy hh:mm:ss.ff" )

sTrace[ 12 ]	= String ( dtNow, "dd/mm/yyyy hh:mm:ss.ff" )
sTrace[ 13 ]	= stGLB.sCodOper
sTrace[ 14 ]	= ""
sTrace[ 15 ]	= ""
sTrace[ 16 ]	= ""
sTrace[ 17 ]	= ""
sTrace[ 18 ]	= sTrace[ 12 ]
sTrace[ 19 ]	= "CREE"
sTrace[ 20 ]	= "0"

sTrace[ 21 ]	= String ( idwSin.GetItemNumber ( 1, "ID_PROD" 	) )
sTrace[ 22 ]	= String ( Date ( dtNow) , "dd/mm/yyyy"  )

sCodTravail = isCodTravail
sAltQueue	= isAltqueue

Choose Case sCodTravail
	Case "CPL"
		If sAltQueue = "N"	Then
			sTrace[ 23 ]  = "1"
		Else
			sTrace[ 23 ]  = "4"
		End If

	Case "CAS"
		sTrace[ 23 ]  = "2"

	Case "DEC"
		sTrace[ 23 ]  = "3"

End Choose

sTrace[ 24 ]	= idwContact.GetItemString ( alLigneLst, "ID_CANAL" )
sTrace[ 25 ]	= iDwContact.GetItemString ( alLigneLst, "COD_I_PROV" )
sTrace[ 26 ]	= String ( Date ( dtNow) , "dd/mm/yyyy"  )

sLigne	= ""
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie qu'il n'y ait plus de cha$$HEX1$$ee00$$ENDHEX$$ne nulle.                   */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot
		If	IsNull ( sTrace[ lCpt ] ) Or sTrace[ lCpt ] = "''" Then
			sTrace[ lCpt ] = ""
		End If
Next

/*------------------------------------------------------------------*/
/* On traite les N-1 valeurs, puis la derni$$HEX1$$e800$$ENDHEX$$re. Pour terminer, on   */
/* ecrit la ligne                                                   */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot - 1
		sLigne = sLigne + sTrace[ lCpt ] + sTab
Next

sLigne = sLigne + sTrace[ lTot ]

f_EcrireFichierText ( isFicTraceTrv, sLigne )

end subroutine

public subroutine uf_initialiser (ref u_datawindow adwsin, ref u_datawindow_detail adwcontact, ref datawindow adwproduit, ref u_datawindow adwdossuivipar, ref u_transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Initialiser (PUBLIC)
//* Auteur			: FABRY JF
//* Date				: 02/05/2001 11:08:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation des Dw pour gestion de contact
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String		sRep, sFic
//u_DeclarationFuncky uoDeclarationFuncky //[I037] Migration FUNCKy

idwSin		=	adwSin	
idwContact	=	adwContact
idwProduit	=	adwProduit
iTrTrans 	= aTrTrans
iDwDosSuiviPar = aDwDosSuiviPar

/*------------------------------------------------------------------*/
/* Le nom du fichier de trace pour les contacts							  */
/*------------------------------------------------------------------*/
sRep = ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE_CN", "ERREUR" )
isFicTraceCont = sRep + String (Today (), "ddmmyyyy" ) + "." + Left ( stGLB.sCodAppli, 3 )

/*------------------------------------------------------------------*/
/* Le nom du fichier de trace pour l'essai d'$$HEX1$$e900$$ENDHEX$$criture des contacts. */
/*------------------------------------------------------------------*/
isFicEssaiTrcCont	= sRep + stGLB.sCodOper + String ( Today (), "ddmm" ) + ".TMP"


/*------------------------------------------------------------------*/
/* Le nom du fichier de trace pour le travail							  */
/*------------------------------------------------------------------*/
sRep = ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE_C", "Erreur" )
isFicTraceTrv = sRep + String (Today (), "ddmmyyyy" ) + "." + Left ( stGLB.sCodAppli, 3 )

/*------------------------------------------------------------------*/
/* Le nom du fichier de trace pour l'essai d'$$HEX1$$e900$$ENDHEX$$criture du travail.   */
/*------------------------------------------------------------------*/
isFicEssaiTrcTrv	= sRep + stGLB.sCodOper + String ( Today (), "ddmm" ) + ".TMP"

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re maintenant le nom de la machine. On part du principe */
/* que ce nom est positionn$$HEX2$$e9002000$$ENDHEX$$dans la valeur Dos (SQL=XXX)           */
/*------------------------------------------------------------------*/
//uoDeclarationFuncky = Create u_DeclarationFuncky
//isNomMachine = uoDeclarationFuncky.Uf_GetEnv ( "SQL" )
isNomMachine = stGLB.uoWin.uf_getenvironment( "SQL" )
//Destroy uoDeclarationFuncky


end subroutine

public function integer uf_retour_gestiontrace (ref boolean abokpourfermer, string asatraiterpar);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Retour_GestionTrace (PUBLIC)
//* Auteur			: FABRY JF
//* Date				: 02/05/2001 14:30:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion de la trace sur le bouton retour
//* Commentaires	: 
//*
//* Arguments		: ref	Boolean	abOkPourFermer
//*					  Val	String 	asATraiterPar	
//*
//* Retourne		: NotFound	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
Long		lTotLig, lCpt, lLig, lCpt1, lNbContact, lNbNat
Boolean	bModif, bRet, bCreeTrv, bOuvre, bDosSuivi
Boolean	ibATraiterPar 
String	sIdNat, sIdMsg, sIdCanal, sRech, sTab = "~t"
String	sMess = "", sVar[3], sDosSuiviPar, sMesErr
Long 		lCodAdh, lLigneLst
Int 		iRet

DataWindowChild	dwcTemp, ddwcNatMsg

SetNull ( idtDteFinGti )
ibComplementOk = False
bCreeTrv	= False
bModif	= False
bRet 		= False
bOuvre 	= True
bDosSuivi= False
lLigneLst=-1
iRet		= 1

/*------------------------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification du positionnement DOS_SUIVI_PAR                     */
/*------------------------------------------------------------------*/
sDosSuiviPar	=	idwDosSuiviPar.GetItemString ( 1, "DOS_SUIVI_PAR" )

If ( isNull ( sDosSuiviPar ) Or ( sDosSuiviPar = "" ) ) Then

	lNbContact 	= iDwContact.RowCount ()
	iDwContact.GetChild ( "ID_NAT_MSG", ddwcNatMsg )

	lNbNat		= ddwcNatMsg.RowCount ()

/*------------------------------------------------------------------*/
/* Si il existe un contact qui necessite affectation dossier/personn*/
/*------------------------------------------------------------------*/

	For lCpt = 1 To lNbContact

		sRech	=	"ID_CANAL	= '" + iDwContact.GetItemString ( lCpt, "ID_CANAL" )   + "' AND " + &
					"ID_TYP_MSG = '" + iDwContact.GetItemString ( lCpt, "ID_TYP_MSG" ) + "' AND " + &
					"ID_NAT_MSG = " + String ( iDwContact.GetItemNumber ( lCpt, "ID_NAT_MSG" ) ) + " AND " + &
					"ALT_AFFECTE= 'O'" 

		lLig	=	ddwcNatMsg.Find ( sRech, 1, lNbNat )

		If iDwContact.GetItemStatus ( lCpt, 0, Primary! ) <> NotModified! And lLig	> 0 Then 

			stMessage.sTitre 	= "Dossier affect$$HEX1$$e900$$ENDHEX$$"
			stMessage.Icon 	= Information!
			stMessage.sCode 	= "CONT020"
			stMessage.bErreurG	= FALSE
			f_Message ( stMessage )

			bDosSuivi = True
			idwDosSuiviPar.SetItem ( 1, "DOS_SUIVI_PAR", stGLB.sCodOper )
			Exit
		End If

	Next

End If

/*------------------------------------------------------------------*/
/* Mise $$HEX2$$e0002000$$ENDHEX$$jour par gestionnaire de la personne qui traite le        */
/* dossier                                                          */
/*------------------------------------------------------------------*/
If iDwDosSuiviPar.GetItemStatus ( 1, 0, Primary! ) = NewModified!  Or &
	iDwDosSuiviPar.GetItemStatus ( 1, 0, Primary! ) = DataModified! Then

	bDosSuivi = True
End If

/*----------------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie que le user est acc$$HEX1$$e800$$ENDHEX$$s au rep de trace workflow.                 */
/*----------------------------------------------------------------------------*/
If	F_Verifier_Ecriture_Trace ( isFicEssaiTrcTrv ) < 0	Then
		stMessage.sTitre		= "Cr$$HEX1$$e900$$ENDHEX$$ation d'un travail en consultation"
		stMessage.Icon			= StopSign!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "APPLI09"
	   stMessage.bTrace  	= False
		F_Message ( stMessage )

		// Aucune Modification ne sera sauvegard$$HEX1$$e900$$ENDHEX$$e.
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "CONT017"
		F_Message ( stMessage )

		iRet = -1
End If


/*------------------------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification possibilit$$HEX2$$e9002000$$ENDHEX$$d'enregistrement de la trace du contact */
/*------------------------------------------------------------------*/
If iRet > 0 Then
	If Not This.uf_Verif_EcritureTrace ( ) Then	

		stMessage.sTitre = "Enregistrement des donn$$HEX1$$e900$$ENDHEX$$es"
		stMessage.Bouton = OK!
		stMessage.sCode = "CONT010"
		stMessage.sCode  = "PROC003"
		stMessage.bErreurG = False
		f_Message ( stMessage )
	
		// Aucune Modification ne sera sauvegard$$HEX1$$e900$$ENDHEX$$e.
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "CONT017"
		F_Message ( stMessage )

		iRet = -1
	End If
End If

If iRet > 0 Then
	/*------------------------------------------------------------------*/
	/* Enregistrements des contacts.												  */
	/*------------------------------------------------------------------*/
	lTotLig = iDwContact.RowCount ()
	bModif = False
	For lCpt = 1 To lTotLig

		CHOOSE CASE iDwContact.GetItemStatus ( lCpt, 0, Primary! )

			CASE NewModified!, New!, DataModified!

				lLigneLst = lCpt

		/*------------------------------------------------------------------*/
		/* V$$HEX1$$e900$$ENDHEX$$rification si necessit$$HEX2$$e9002000$$ENDHEX$$de cr$$HEX1$$e900$$ENDHEX$$ation automatique d'un travail   */
		/*------------------------------------------------------------------*/
				sIdNat		=	String ( idwContact.GetItemNumber ( lCpt, "ID_NAT_MSG" ) )
				sIdMsg		=	iDwContact.GetItemString ( lCpt, "ID_TYP_MSG" )
				sIdCanal		=	iDwContact.GetItemString ( lCpt, "ID_CANAL"   )

				If Long ( sIdNat ) = 5 Then ibATraiterPar = TRUE

				iDwContact.GetChild ( "ID_NAT_MSG", dwcTemp )

				dwcTemp.SetFilter ( "" )
				dwcTemp.Filter 	( )

				lLig			=	dwcTemp.RowCount ()

				For lCpt1 = 1 To lLig

					If	sIdNat		=	String ( dwcTemp.GetItemNumber ( lCpt1, "ID_NAT_MSG" ) ) AND &
						sIdMsg		=	dwcTemp.GetItemString ( lCpt1, "ID_TYP_MSG" ) AND &
						sIdCanal		=	dwcTemp.GetItemString ( lCpt1, "ID_CANAL"   ) THEN

						bCreeTrv	=	dwcTemp.GetItemString ( lCpt1, "ALT_CREE_TRV" ) = "O"

	/*------------------------------------------------------------------*/
	/* Demande de confirmation si continuit$$HEX2$$e9002000$$ENDHEX$$sur travail en cours       */
	/*------------------------------------------------------------------*/

						If bCreeTrv Then 

							stMessage.sTitre = "Enregistrement des contacts"
							stMessage.Bouton = OKCancel!
							stMessage.bErreurG = False
							stMessage.sCode = "CONT013"

							If f_Message ( stMessage ) = 2 Then 			// Stop

								// Aucune Modification ne sera sauvegard$$HEX1$$e900$$ENDHEX$$e.
								stMessage.Icon			= Information!
								stMessage.Bouton		= OK!
								stMessage.bErreurG	= FALSE
								stMessage.sCode		= "CONT017"
								stMessage.bErreurG 	= False
								F_Message ( stMessage )

								iRet = -1
							End If					

						End If

						Exit						
					End If

				Next

				bModif 		= 	True
				Exit
		END CHOOSE

	Next

End If

/*----------------------------------------------------------------------------*/
/* On ouvre la fen$$HEX1$$ea00$$ENDHEX$$tre de workflow en invisible ce qui permet de d$$HEX1$$e900$$ENDHEX$$clencher   */
/* toutes la batterie de contr$$HEX1$$f400$$ENDHEX$$le li$$HEX4$$e9002000e0002000$$ENDHEX$$la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail,             */
/* de plus cela permet aussi de mettre $$HEX2$$e0002000$$ENDHEX$$jour la date de fin de gti.          */
/*----------------------------------------------------------------------------*/
If iRet > 0 and bModif And bCreeTrv Then
	
	// Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre.
	idwSin.TriggerEvent ("ue_Ouvrir_FenTrv")

	If Not ibComplementOk Then
		stMessage.sTitre		= "Cr$$HEX1$$e900$$ENDHEX$$ation d'un travail en consultation"
		stMessage.Icon			= Information!
		stMessage.Bouton		= YesNo!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "CONT016"
	   stMessage.bTrace  	= False

		// On sort 
		If F_Message ( stMessage ) = 2 Then

			stMessage.sTitre		= "Cr$$HEX1$$e900$$ENDHEX$$ation d'un travail en consultation"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "CONT017"
		   stMessage.bTrace  	= False
			F_Message ( stMessage )

			abOkPourFermer = True
			iRet = -1

		// On r$$HEX1$$e900$$ENDHEX$$essaie.
		Else
			stMessage.sTitre		= "Cr$$HEX1$$e900$$ENDHEX$$ation d'un travail en consultation"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "CONT018"
		   stMessage.bTrace  	= False
			F_Message ( stMessage )

			abOkPourFermer = False
			iRet = -1
		End If
	End If
End If


/*------------------------------------------------------------------*/
/* On ecrit en base $$HEX2$$e0002000$$ENDHEX$$partir de maintenant !!                       */
/*------------------------------------------------------------------*/
If iRet > 0 and bModif And bCreeTrv Then

	// On ins$$HEX1$$e800$$ENDHEX$$re le travail 
	If Not ibATraiterPar Then asATraiterPar = ""
	bRet = This.uf_Insertion_Travail ( lLigneLst, asATraiterPar )

	If Not bRet Then

		F_Commit ( itrTrans, FALSE )
		iRet = -1

		stMessage.sVar[1] = sVar[1]
		stMessage.sVar[2] = sVar[2]
		stMessage.sVar[3] = sVar[3]
		stMessage.bErreurG = True
		stMessage.sTitre = "Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour"
		stMessage.sCode  = "PROC003"
		f_Message ( stMessage )
	End If

End If

If iRet > 0 Then
	If Not bModif Then bModif = iDwContact.DeletedCount () > 0

	If bModif Then 

			stMessage.sTitre = "Enregistrement des donn$$HEX1$$e900$$ENDHEX$$es"
			stMessage.Bouton = OKCancel!
			stMessage.sCode = "CONT012"

			If f_Message ( stMessage ) = 1 Then 
				bRet	  = iDwContact.Update ( True, False ) > 0

				If Not bRet Then 
					F_Commit ( itrTrans, FALSE )
					iRet = -1
				End If

				sVar[1] = "Dw_Lst_Contact"
				sVar[2] = String ( itrTrans.SQLDbCode  )
				sVar[3] = String ( itrTrans.SQLErrText )

			Else
				// Aucune Modification ne sera sauvegard$$HEX1$$e900$$ENDHEX$$e.
				stMessage.Icon			= Information!
				stMessage.Bouton		= OK!
				stMessage.bErreurG	= FALSE
				stMessage.sCode		= "CONT017"
				stMessage.bErreurG 	= False
				F_Message ( stMessage )

				iRet = -1
			End If
	End If
End If

/*----------------------------------------------------------------------------*/
/* On Update Dw_DosSuiviPar.                                                  */
/*----------------------------------------------------------------------------*/
If iRet > 0 and bDosSuivi then 
	bRet = idwDosSuiviPar.Update ( True, False ) > 0

	If Not bRet Then 
		F_Commit ( itrTrans, FALSE )
		iRet = -1
	End If

	sVar[1] = "Dw_DosSuiviPar"
	sVar[2] = String ( itrTrans.SQLDbCode  )
	sVar[3] = String ( itrTrans.SQLErrText )
End If

/*----------------------------------------------------------------------------*/
/* On Commit (ou RollBack) La mise $$HEX2$$e0002000$$ENDHEX$$jour des contacts et l'insertion du 		*/
/*	WorkFlow.          																			*/
/*----------------------------------------------------------------------------*/
If bModif Or bDosSuivi Then 
	If iRet < 0 Then bRet = False
	F_Commit ( itrTrans, bRet )
	If Not bRet Then iRet = -1
End If

/*------------------------------------------------------------------*/
/* Enregistrement de la trace du contact                            */
/*------------------------------------------------------------------*/
If iRet > 0 And bModif Then

	This.uf_EcrireTrace ( 1 )		// Enregistrement de la trace du contact
	iDwContact.ResetUpdate ()				// RAZ des status de la Dw

End If

/*------------------------------------------------------------------*/
/* Enregistrement de la trace du workflow									  */
/*------------------------------------------------------------------*/
If iRet > 0 and bModif and bCreeTrv Then

	This.uf_EcrireTraceTrv ( lLigneLst )		// Enregistrement de la trace du contact

End If

/*----------------------------------------------------------------------------*/
/* Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil de saisie de sinistre.                   */
/* Seulement si l'utilisateur $$HEX2$$e0002000$$ENDHEX$$l'acc$$HEX1$$e800$$ENDHEX$$s.													*/
/* Dans le cas contraire on n'affichage pas de box pour ne pas perturber.		*/
/*----------------------------------------------------------------------------*/
If iRet > 0 and stGlb.bSaisieSin and bCreeTrv And Not ibATraiterPar Then

	sMesErr = stGlb.sMessageErreur
	stGlb.sMessageErreur = String ( iDwSin.GetItemNumber ( 1, "ID_SIN" ) )
	idwSin.TriggerEvent ("ue_ouvrir_fensaisie")
	stGlb.sMessageErreur = sMesErr 

End If

Return iRet 
end function

private function boolean uf_insertion_travail (long alligne, string asatraiterpar);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Insertion_Travail (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 02/05/2001 14:30:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Insertion du travail.
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: -1/1
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* Ajout des colonnes ID_CONTRAT_ABONNE, ID_HLR, ID_ORIAN_MARQUE,   */
/* ID_ORIAN_MODELE, ID_ORIAN_BOUTIQUE.                              */
/*------------------------------------------------------------------*/
Boolean bRet

String sCodTypeRecu, sCodRecu, sCodIProv, sIdAdh, sDosMajPar
String sCodCiv, sNom, sPrenom, sAdr1, sAdr2, sAdrCp, sAdrVille, sNumTelD, sNumTelB, sNumFax, sTxtMess1, sCodOper
String sCodTravail, sAltQueue, sIdTypeCarte, sCodProvPers, sProc
String sCodModeRegA, sRibBq, sRibGui, sRibCpt, sRibCle
String sCodBq_B, sCodAg_B, sNom_B, sAdr1_B, sAdr2_B, sAdrCp_B, sAdrVille_B, sCodModeRegB, sAltCreBqDms, sNumTelD_B
String sNumPort, sNumIMEiPort, sMarqPort, sModlPort, sIdContratAbonne

DateTime dtDteCourCli, dtDteRecu, dtDteAdh, dtDteFinGti, dtDteResil, dtDteDecl, dtDteSurv, dtMajLe, dtCreeLe
DateTime dtDteSous, dtDteOpt
DateTime	dtNow, dtNull
Datetime dtDteAchPort, dtDteOuvLigPort

Decimal dcNbPage, dcIdSin, dcIdI, dcIdProd, dcIdEts, dcIdsDos, dcOption, dcIdCarte, dcIdOrdre

Long lIdHlr, lIdOrianMarque, lIdOrianModele, lIdOrianBoutique

Long lLig

Decimal dcIdCorb
String  sNvIdSin

DataWindowChild dwChild

bRet = True

sProc			= Space ( 60 )
sNvIdSin		= Space ( 10 ) // [PI062]
isCodTravail = Space ( 3 )
isAltQueue = Space ( 1 )

dtNow = DateTime ( Today (), Now () )
SetNull ( dtNull )

/*------------------------------------------------------------------*/
/* On arme les variables dont on a besoin dans la proc$$HEX1$$e900$$ENDHEX$$dure.        */
/*------------------------------------------------------------------*/

sCodTypeRecu	= "C"
sCodRecu			= iDwContact.GetItemString ( alligne, "ID_CANAL"   )
dtDteCourCli	= dtNow
dtDteRecu		= dtNow

dcNbPage			= 0
dcIdSin			= iDwSin.GetItemNumber ( 1, "ID_SIN" )
dcIdI				= -1 // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
sCodIProv		= iDwContact.GetItemString ( alLigne, "COD_I_PROV" )

dcIdProd			= iDwSin.GetItemNumber ( 1, "ID_PROD" )
dcIdEts			= -1 // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
sIdAdh			= "" // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
dcIdsDos			= -1 // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
dcOption			= -1 // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment

dtDteAdh			= dtNull // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment

If IsNull ( idtDteFinGti ) Or Date ( idtDteFinGti ) = 1900-01-01 Then 
	//dtDteFinGti		= DateTime ( idwSin.GetItemDate ( 1, "DTE_FIN_GTI" ),00:00:00 )
	dtDteFinGti		= idwSin.GetItemDateTime ( 1, "DTE_FIN_GTI" ) // [PI056]
Else
	// La dteFinGti est mise $$HEX2$$e0002000$$ENDHEX$$jour
	dtDteFinGti		= idtDteFinGti
End If

dtDteResil		= dtNull // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment

dcIdCorb			= iDwProduit.GetItemNumber ( 1, "ID_CORB" )

dtDteDecl		= dtNull // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
dtDteSurv		= dtNull // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment

sCodCiv			= "" // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
sNom				= Trim ( idwSin.GetItemString ( 1, "NOM" ) )
sPrenom			= Trim ( idwSin.GetItemString ( 1, "PRENOM" ) )
sAdr1				= "" // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
sAdr2				= "" // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
sAdrCp			= "" // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
sAdrVille		= "" // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
sNumTelD			= "" // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
sNumTelB			= "" // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
sNumFax			= "" // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
sTxtMess1		= "Compl$$HEX1$$e900$$ENDHEX$$ment cr$$HEX3$$e900e9002000$$ENDHEX$$en Consultation suite contact."

sCodOper			= stGLB.sCodOper
dtMajLe			= dtNull // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
dtCreeLe			= dtNow

// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration sur routage
itrTrans.PS_S01_ROUTAGE ( dcIdSin, isCodTravail, isAltQueue )
sCodTravail = isCodTravail  
sAltqueue = isAltqueue

dtDteSous		= dtNull // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
dtDteOpt			= dtNull // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
dcIdCarte 		= -1 // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
sIdTypeCarte	= "" // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment

dcIdOrdre		= -1 // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
sCodProvPers	= "" // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment

sCodModeRegA	= "" // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment

sRibBq			= "" // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
sRibGui			= "" // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
sRibCpt			= "" // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment
sRibCle			= "" // Non utilis$$HEX2$$e9002000$$ENDHEX$$en compl$$HEX1$$e900$$ENDHEX$$ment

sAltCreBqDms = "N"

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* Armement des valeurs par d$$HEX1$$e900$$ENDHEX$$faut. Cette gestion doit $$HEX1$$ea00$$ENDHEX$$tre         */
/* r$$HEX1$$e900$$ENDHEX$$alis$$HEX1$$e900$$ENDHEX$$e en ActiveLinc Via SHERPA.                               */
/*------------------------------------------------------------------*/
sIdContratAbonne	= "123456AA987654"
lIdHlr				= 99
lIdOrianMarque		= 10
lIdOrianModele		= 20
lIdOrianBoutique	= 1234567

If asATraiterPar <> "" And Not IsNull ( asATraiterPar ) Then
	sDosMajPar		= asATraiterPar 
Else
	sDosMajPar		= "CREE"
End If

	itrTrans.PS_VAL_W_QUEUE		 (	sCodTypeRecu,		&
											sCodRecu,			&
											dtDteCourCli,		&
											dtDteRecu,			&
											dcIdSin,				&
											dcIdI,				&
											sCodIProv,			&
											dcIdProd,			&
											dcIdEts,				&
											sIdAdh,				&
											dcIdsDos,			&
											dcOption,			&
											dtDteAdh,			&
											dtDteFinGti,		&
											dtDteResil,			&
											dcIdCorb,			&
											dtDteDecl,			&
											dtDteSurv,			&
											sCodCiv,				&
											sNom,					&
											sPrenom,				&
											sAdr1,				&
											sAdr2,				&
											sAdrCp,				&
											sAdrVille,			&
											sNumTelD,			&
											sNumTelB,			&
											sNumFax,				&
											sTxtMess1,			&
											dtCreeLe,			&
											dtMajLe,				&
											sCodOper,			&
											sCodTravail,		&
											sAltQueue, 			&
											dtDteSous, 			&
											dtDteOpt, 			&
											dcIdCarte, 			&
											sIdTypeCarte, 		&
											dcIdOrdre, 			&
											sCodProvPers, 		&
											sCodModeRegA, 		&
											sRibBq,		 		&
											sRibGui,		 		&
											sRibCpt,		 		&
											sRibCle,		 		&
											sAltCreBqDms,		&
											sCodBq_B,			&
											sCodAg_B,		 	&
											sNom_B,		 		&
											sAdr1_B,		 		&
											sAdr2_B,		 		&
											sAdrCp_B,		 	&
											sAdrVille_B,		&
											sCodModeRegB, 		&
											sNumTelD_B,			&
											sDosMajPar,			&
											sNumPort,			&
											sNumImeiPort,		&
											sMarqPort,			&
											sModlPort,			&
											dtDteAchPort,		&
											dtDteOuvLigPort,	&
											sIdContratAbonne,	&
											lIdHlr,				&
											lIdOrianMarque,	&
											lIdOrianModele,	&
											lIdOrianBoutique,	&
											sProc,				&
											sNvIdSin )

/*------------------------------------------------------------------*/
/* La zone sProc est pass$$HEX1$$e900$$ENDHEX$$e par r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence. Elle est arm$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$''      */
/* dans la proc$$HEX1$$e900$$ENDHEX$$dure. Si une erreur survient, on arme cette cha$$HEX1$$ee00$$ENDHEX$$ne  */
/* pour expliquer ou est survenue l'erreur.                         */
/*------------------------------------------------------------------*/
sProc = Trim ( sProc )
bRet  = sProc = "" 

/*------------------------------------------------------------------*/
/* Si SqlDbCode est arm$$HEX1$$e900$$ENDHEX$$, on part du principe qu'il y a eu une      */
/* erreur, et ce quel que soit la valeur de sProc.                  */
/*------------------------------------------------------------------*/
If bRet then bRet = itrTrans.SqlCode = 0 And itrTrans.SqlDBCode = 0

Return bRet



end function

public subroutine uf_retour_gestionsherpa (boolean abokpourfermer);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Retour_GestionSherpa (PUBLIC)
//* Auteur			: FABRY JF
//* Date				: 05/09/2002 17:30:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion pour Sherpa, uniquement le traitement du DosSuiviPar
//* Commentaires	: 
//*
//* Arguments		: ref	Boolean	abOkPourFermer
//*
//* Retourne		: NotFound	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF		05/09/2002 Gestion de la gestion de contact uniquement pour Sherpa
//*       JFF   	29/08/2023 [RS5666_DOS_SUIVI_PAR]
//*-----------------------------------------------------------------

Boolean bRet

abOkPourFermer = True

/*------------------------------------------------------------------*/
/* Mise $$HEX2$$e0002000$$ENDHEX$$jour par gestionnaire de la personne qui traite le        */
/* dossier                                                          */
/*------------------------------------------------------------------*/
// [RS5666_DOS_SUIVI_PAR]
If Not F_CLE_A_TRUE ( "RS5666_DOS_SUIVI_PAR" ) Then

	If iDwDosSuiviPar.GetItemStatus ( 1, 0, Primary! ) = NewModified!  Or &
		iDwDosSuiviPar.GetItemStatus ( 1, 0, Primary! ) = DataModified! Then
	
		stMessage.sTitre = "Enregistrement des donn$$HEX1$$e900$$ENDHEX$$es"
		stMessage.Bouton = YesNo!
		stMessage.sCode = "CONT012"
	
	/*----------------------------------------------------------------------------*/
	/* On Update Dw_DosSuiviPar.                                                  */
	/*----------------------------------------------------------------------------*/
		If f_Message ( stMessage ) = 1 Then 
			bRet = idwDosSuiviPar.Update ( True, False ) > 0
			F_Commit ( itrTrans, bRet )
		End If
	End If

End If 


end subroutine

on u_gs_sp_sinistre_contact_trace.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_sinistre_contact_trace.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

