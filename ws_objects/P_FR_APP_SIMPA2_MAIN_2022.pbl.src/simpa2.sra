$PBExportHeader$simpa2.sra
forward
global type simpa2 from application
end type
global u_transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
s_GLB		stGlb

s_Message	stMessage

s_Nul		stNul

s_SPB		stSPB

u_spb_gs_trace	uoGsTrace

String                    gsAction	// FS action automatique à effectuer
String                    gsParam	// FS paramétre pour action automatique
String		gsCasGestion   // JFF récupération sur la grille de sinistre du cas de gestion fixé sur le détail

Boolean		ibRaccActif
Boolean		gbOpCon  // JFF Gestion automatique des commandes

w_mdi_sp		gWMdi    // Instance de réference globale afin q'OpCon puisse fermer SIMPA2 (Utiliser uniquement si user = OPCO)

//[BUG_STRUCTPB11] .DEBUG  - A virer une fois le bug trouvé.
//s_plafond_pec gstPPecDebug

String gsBinDroit // [VDOC4684]

Long glIdSinMemPM72  // [PM72]

u_DataWindow_Detail gdwlstdetail // [201204181055][PROBLEME_PLAF_MARYSE]

Boolean gbModeReprise_223 //      JFF   23/05/2012 [PM103][1]

Boolean gProcessTempoOrangeV3 // [PC938_ORANGE_V3]
Boolean gProcessTempoOrangeV3Action // [PC938_ORANGE_V3]

Boolean gAutoriseDiag, gAutoriseRempl // [PM246]

String gsAdrCivPickUp, gsAdrNomPickUp, gsAdrPreNomPickUp, gsAdr1PickUp, gsAdr2PickUp, gsAdrCpltPickUp, gsAdrVillePickUp, gsAdrCpPickUp, gsCodePickUp, gsHorairePickUp

DateTime gdtCnx

// [VDOC27557]
// [ISM365847] Vdoc-384 - Christelle Soret le 24/05
Constant String gsDroitDosBloqueDR = "#MEB#TRL#MHI#NBM#MF#CMA#DDC#MDH#ASM#FAT#CCH#CAM#JCH#SAB#SSA#ACS#CLN#"

// [PC192290] JFF 03/01/2020
DataStore gdsPieceSherpa

// [RS2980]
String gsCodeRetPrixIfr

// [RS_4166_PND_CORUS]
Boolean gbLstAffAutoConsultCourrier

Int gTInterCP [] // [RS5045_REF_MATP]
String gTModeleCP [] // [RS5045_REF_MATP]

String gsSeriaTransfert // [PMO268_MIG48]

end variables

global type simpa2 from application
string appname = "simpa2"
string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 22.0\IDE\theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 5
long richtexteditx64type = 5
long richtexteditversion = 3
string richtexteditkey = ""
string appicon = "K:\PB4OBJ\BMP\simpa2.ICO"
string appruntimeversion = "22.2.0.3356"
boolean manualsession = false
boolean unsupportedapierror = false
boolean ultrafast = false
boolean bignoreservercertificate = false
uint ignoreservercertificate = 0
long webview2distribution = 0
boolean webview2checkx86 = false
boolean webview2checkx64 = false
string webview2url = "https://developer.microsoft.com/en-us/microsoft-edge/webview2/"
end type
global simpa2 simpa2

type prototypes
// JFF 03/09/2013
Function boolean MoveFileA (ref string oldfile, ref string newfile) library "KERNEL32.DLL" alias for "MoveFileA;Ansi"

// JFF 11/02/2020
Function Ulong FindWindowA ( Long lClassName, Ref String sWindowName ) Library "USER32.DLL" alias for "FindWindowA;Ansi"
Function Ulong FindWindowA ( Ref string sClassName, Long sNull ) Library "USER32.DLL" alias for "FindWindowA;Ansi"
Function Ulong FindWindowA ( Ref string sClassName, Ref String sWindowName ) Library "USER32.DLL" alias for "FindWindowA;Ansi"
Function Ulong FindWindowA ( Long lClassName, Long lWindowName ) Library "USER32.DLL" alias for "FindWindowA;Ansi"

end prototypes

forward prototypes
protected subroutine af_fermeapplication ()
private subroutine af_fermeture_opcon ()
private subroutine af_gestion_opcon ()
end prototypes

protected subroutine af_fermeapplication ();//*-----------------------------------------------------------------
//*
//* Fonction		: af_FermeApplication
//* Auteur			: DBI
//* Date				: 04/08/1997 10:32:55
//* Libellé			: Fermeture de l'application et destruction des objets ouverts
//* Commentaires	: Appel de f_FermeMdi pour MAJ datetime de deconnexion
//*					  Destruction des objets ouverts
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*						
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Pour OpCon, on ne lance pas cette partie, après plusieurs test   */
/* il y a rien de plantage et donc d'apparation de Box (génant      */
/* pour pour OPCON).                                                */
/*------------------------------------------------------------------*/
If Not gbOpCon Then f_FermeMdi ( stGLB )

/*------------------------------------------------------------------*/
/* Si la transaction sur la base a bien été créée et qu'elle est    */
/* connectée (DBHandle <> 0) ALORS on la déconnecte.                */
/*------------------------------------------------------------------*/

If IsValid ( SQLCA ) Then

	If SQLCA.DBHandle ( )  <> 0 Then

		DISCONNECT USING SQLCA;

	End If

End If


//If IsValid ( gTrArchive ) Then
//
//	If gTrArchive.DBHandle ( )  <> 0 Then
//
//		DISCONNECT USING gTrArchive;
//
//	End If
//
//	Destroy gTrArchive
//
//End If

If IsValid ( UoGsTrace ) Then

	If IsValid ( UoGsTrace.itrTrans ) Then

		If UoGsTrace.itrTrans.DBHandle ( )  <> 0 Then

			DISCONNECT USING UoGsTrace.itrTrans;

		End If
	End If

	Destroy uoGsTrace

End If

/*------------------------------------------------------------------*/
/* Destruction des objets ouverts                                   */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Destroy stGLB.uoWin
// PHG [DETECTEAPPLI] On tue le Mutex
stGLB.uoWin.uf_CloseHandle ( stGLB.uoWin.uf_GetMutexRef() )

If IsValid(stGLB.uoWin) Then Destroy stGLB.uoWin
//Destroy stGLB.stEnv
//
//Destroy stGLB
//Destroy stMessage
//Destroy stSPB
//Destroy stNul
//Fin Migration PB8-WYNIWYG-03/2006 FM

end subroutine

private subroutine af_fermeture_opcon ();//*-----------------------------------------------------------------
//*
//* Fonction      : Simpa2::af_Fermeture_Opcon 
//* Auteur        : Fabry JF
//* Date          : 17/12/2002 14:19:15
//* Libellé       : Ecriture d'un dernier fichier pour preuve du fonctionnement
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Int iFicPreuveOpCon

iFicPreuveOpCon = FileOpen ( "C:\PB_OPCON\SIM2_CMD\LAST_OUT", LineMode!, Write!, Shared!, Replace! )
FileClose ( iFicPreuveOpCon )

end subroutine

private subroutine af_gestion_opcon ();//*-----------------------------------------------------------------
//*
//* Fonction      : Simpa2::af_Gestion_Opcon
//* Auteur        : Fabry JF
//* Date          : 19/12/2002 14:11:36
//* Libellé       : 
//* Commentaires  : 

//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------


gbOpCon = Trim ( Upper ( stGlb.sCodOper ) ) = "OPCO"
If gbOpCon then

	/*------------------------------------------------------------------*/
	/* On teste la présence de la clé de sécurité, si cette clé n'est   */
	/* pas présente, on ne lance pas SIMPA2.                            */
	/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//	If Not FileExists ( "C:\PB_OPCON\SIM2_CMD\OPCONKEY" ) Then
	If Not f_FileExists ( "C:\PB_OPCON\SIM2_CMD\OPCONKEY" ) Then	
//Fin Migration PB8-WYNIWYG-03/2006 CP	
	
		f_FermeMdi ( stGLB )
		HALT
	End If
End If

end subroutine

event open;//*-----------------------------------------------------------------
//*
//* Objet			:	Application SIMPA 2.
//* Evenement 		:	Open
//* Auteur			:	Y. Picard
//* Date				:	28/07/97 15:22:27
//* Libellé			:	Lancement de l'application SIMPA 2.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR				  Date			Modification
//* [DETECTEAPPLI.001] 12/05/2006 	Correction double messagebox			
//*-----------------------------------------------------------------

Boolean	bOk		// Booléen pour la vérification du bon déroulement du script.

SetPointer ( HourGlass! )

stGLB.uoEnvSpb	=	CREATE u_Sesame

bOk = stGLB.uoEnvSpb.uf_Initialisation ( This, stGLB, stMessage )

f_LireSPB ( stGlb, stSPB )

/*------------------------------------------------------------------*/
/* JFF Le 22/06/2004 : A partir de maintenant, par sûreté, je ne    */
/* lis plus ce paramètre, je force toujours en SVE. (ProfileString  */
/* ( stGlb.sFichierIni, "EDITION", "METHODE", "" ) = "SVE")         */
/*------------------------------------------------------------------*/
stGLB.bSaiValEdt = TRUE

/*------------------------------------------------------------------*/
/* JFF Le 13/12/2002 : Sommes-nous en mode automatique pour         */
/* générer les commandes ?                                          */
/* L'utilisateur est-il OPCON/XPS(SMA) ?  								  */
/* si oui--> mémorisation en variable globale, passage en mode auto */
/*------------------------------------------------------------------*/
This.af_Gestion_OpCon ()

/*------------------------------------------------------------------*/
/* Vérification que l'initialisation de uoEnvSpb s'est bien passée  */
/*------------------------------------------------------------------*/
If Not bOk Then

// [DETECTEAPPLI.001]
	if len(stGLB.sMessageErreur)>0 then
		MessageBox ( "Erreur", stGLB.sMessageErreur )
	End If

Else

	/*------------------------------------------------------------------*/
	/* Vérification de la connexion à la base                           */
	/*------------------------------------------------------------------*/
	If Not f_ConnectSqlServer ( stGLB.sFichierIni   , &
                               "SIMPA BASE"        , &
                               SQLCA               , &
                               stGLB.sMessageErreur, &
										 stGlb.slibcourtappli, &
										 stGlb.sCodOper          ) Then

		MessageBox ( "Erreur", stGLB.sMessageErreur )
		bOk = False

	Else

		/*----------------------------------------------------------------------------*/
		/* JFF le 02/07/01 : Cohenrence entre la monnaie de la base et de             */
		/* l'application.                                                             */
		/*----------------------------------------------------------------------------*/
		bOk = F_Coherence_Monnaie () 

		If bOk Then 

			If Not gbOpcon Then 
				OpenWithParm ( w_LogoApp_SoldeTrv, stGLB )
			End If

			f_OuvreMDI ( W_Mdi_Sp, stGLB )		// Ouverture de la fenetre MDI

			If Not gbOpcon Then 
				w_LogoApp_SoldeTrv.BringToTop = True
			End If

			W_Mdi_Sp.Title = SQLCA.Database + " - " + W_Mdi_Sp.Title		

			f_SetNul ( stNul ) 

			stGLB.uoEnvSpb.Uf_Charger_Corb_Oper ( SQLCA )

		End If


	End If
End If

//Migration PB8-WYNIWYG-03/2006 FM
//DESTROY stGLB.uoEnvSpb						// Fermeture de l'Objet de connexion ENVSPB
If IsValid(stGLB.uoEnvSpb) Then DESTROY stGLB.uoEnvSpb
//Fin Migration PB8-WYNIWYG-03/2006 FM

If IsValid ( w_LogoApp_SoldeTrv ) Then
	Close ( w_LogoApp_SoldeTrv )					// Fermeture de la fenêtre d'attente
End If

/*------------------------------------------------------------------*/
/* Fermeture de l'application si problème lors du script            */
/*------------------------------------------------------------------*/
If Not bOk Then 

	f_FermeMdi ( stGLB )
	HALT

End If


end event

on close;//*-----------------------------------------------------------------
//*
//* Objet			:	Application SIMPA2
//* Evenement 		:	Close
//* Auteur			:	YP
//* Date				:	03/09/97 10:42:29
//* Libellé			:	
//* Commentaires	:	Destruction de tous les objets
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

af_FermeApplication ( )

SetNull ( Message.PowerObjectParm )

/*------------------------------------------------------------------*/
/* Ecriture d'un dernier fichier indiquant une sortie normale du    */
/* logiciel.                                                        */
/*------------------------------------------------------------------*/
If gbOpCon Then af_Fermeture_Opcon ()
end on

event systemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: SIMPA2
//* Evenement 		: SystemError
//* Auteur			: YP
//* Date				: 03/09/1997 10:42:30
//* Libellé			: 
//* Commentaires	: Gestion des erreurs système.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*	DBI	04/08/1997	  Rollback avant appel f_erreur
//*							  Création et appel af_FermeApplication à la place
//*							  de Halt Close
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Rollback des objets de transactions en cours                     */
/*------------------------------------------------------------------*/
If isValid ( SQLCA ) Then

	f_Commit ( SQLCA, False )
End If

If isValid ( uoGsTrace ) Then

	If isValid ( uoGsTrace.itrTrans ) Then

		f_Commit ( uoGsTrace.itrTrans, False )
	End If
End If

/*------------------------------------------------------------------*/
/* Appel fonction de trace et affichage erreur                      */
/*------------------------------------------------------------------*/

f_Trace_Erreur ( "1", stGLB )

/*------------------------------------------------------------------*/
/* Fermeture de l'application et destruction des objets ouverts     */
/*------------------------------------------------------------------*/

af_FermeApplication ( )

Halt
end event

on simpa2.create
appname="simpa2"
message=create message
sqlca=create u_transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on simpa2.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

