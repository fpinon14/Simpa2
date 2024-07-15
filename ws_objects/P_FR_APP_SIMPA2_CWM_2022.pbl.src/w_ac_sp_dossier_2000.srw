HA$PBExportHeader$w_ac_sp_dossier_2000.srw
$PBExportComments$-- } Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil de consultation d'un dossier
forward
global type w_ac_sp_dossier_2000 from w_ac_spb_archive_2000
end type
type dw_produit from datawindow within w_ac_sp_dossier_2000
end type
type pb_saisie from picturebutton within w_ac_sp_dossier_2000
end type
type pb_tel from picturebutton within w_ac_sp_dossier_2000
end type
type pb_workflow from picturebutton within w_ac_sp_dossier_2000
end type
type pb_edition from picturebutton within w_ac_sp_dossier_2000
end type
type pb_validation from picturebutton within w_ac_sp_dossier_2000
end type
end forward

global type w_ac_sp_dossier_2000 from w_ac_spb_archive_2000
string title = "Consultation d~'un dossier"
event ue_saisie_automatique pbm_custom34
dw_produit dw_produit
pb_saisie pb_saisie
pb_tel pb_tel
pb_workflow pb_workflow
pb_edition pb_edition
pb_validation pb_validation
end type
global w_ac_sp_dossier_2000 w_ac_sp_dossier_2000

type prototypes
Function Ulong FindWindowA ( Long lClassName, Ref String sWindowName ) Library "USER32.DLL" alias for "FindWindowA;Ansi"
Function Ulong FindWindowA ( Ref string sClassName, Long sNull ) Library "USER32.DLL" alias for "FindWindowA;Ansi"
Function Ulong FindWindowA ( Ref string sClassName, Ref String sWindowName ) Library "USER32.DLL" alias for "FindWindowA;Ansi"
Function Ulong FindWindowA ( Long lClassName, Long lWindowName ) Library "USER32.DLL" alias for "FindWindowA;Ansi"

Function Ulong MoveWindow ( ULong ulWin, Long lX, Long lY, Long lWidth, Long lHeight, Long lRepaint ) Library "USER32.DLL"
Function Ulong SetWindowPos(long hwnd, long hmode, int ix, int iy, int cx,int cy, ulong flags) LIBRARY "USER32.DLL"

end prototypes

type variables
PRIVATE :

	W_Tm_Sp_Sinistre	iw_W_Tm_Sp_Sinistre

	String 		isRepCourrierSimpa1
	String 		isModeleSimpa1
	String 		isEnteteSimpa1
	String 		isEnteteSimpa1_Anc
	String		isRepCourrierSimpa2
	String 		isModeleSimpa2
	String 		isEnteteSimpa2

//JFF 	13/04/04 DCMP 040020 SVE				  
	String 		isEnteteSimpa2_Anc1
	Date		idDateSVE    // Changement fichier enete .DAT et mise en prod SVE

	String		isBoutonRac
	
   Long ilPos[] = { 850,10,1014,740 } // [PI052] Coordonn$$HEX1$$e900$$ENDHEX$$es AcrobatReader  
	
	Long ilIdentityTraceTsCourrier
end variables

forward prototypes
private subroutine wf_consultercourrier_sve (string asrepcourrier, string asmodele)
public subroutine wf_pi052_consulter_pdf ()
public subroutine wf_pi052_consulter_doc ()
public subroutine wf_anonymationensim (long adcidsin)
public subroutine wf_courword_tracetscourrier (string ascas, long alidsin, long alidinter, long aliddoc)
end prototypes

event ue_saisie_automatique;//*-----------------------------------------------------------------
//*
//* Objet			: Fen$$HEX1$$ea00$$ENDHEX$$tre
//* Evenement 		: ue_SaisieAutomatique
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Overture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil dce saisie de sinistre
//* Commentaires	: 
//*				 
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    FS      12/01/2002 Traitement des ordres de saisie automatique
//*                          ( transmis par sherpa grc )
//* #1    FS      11/09/2002 En consultation depuis sherpa on ouvre en priorit$$HEX2$$e9002000$$ENDHEX$$l'instruction
//*-----------------------------------------------------------------

Boolean bFenEnCoursOuv, bFenPermOuv 

/*------------------------------------------------------------------*/
/* #1                                                               */
/* ue_saisie_automatique aussi utilis$$HEX2$$e9002000$$ENDHEX$$pour les ordres SHERPA       */
/* Ce morceau de code n'est pas ex$$HEX1$$e900$$ENDHEX$$cut$$HEX2$$e9002000$$ENDHEX$$si ordre transmis par SHERPA*/
/*------------------------------------------------------------------*/

If gsAction <> "CONSULTER" And gsAction <> "TEST_CONSULTER" Then

	If IsValid ( iw_W_Tm_Sp_Sinistre ) Then bFenEnCoursOuv = iw_W_Tm_Sp_Sinistre.visible
	If IsValid ( W_Cm_Sp_Sinistre ) Then bFenPermOuv = W_Cm_Sp_Sinistre.visible

	If Not bFenEnCoursOuv And Not bFenPermOuv Then
		pb_Interro.TriggerEvent ("clicked")
	ENd If 

End If


CHOOSE CASE gsaction

   CASE "TEST_CONSULTER"

	/*----------------------------------------------------------------------------*/
	/* la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation est-elle ouverte en instruction/sinistre ?      */
	/*----------------------------------------------------------------------------*/

     gsParam = "FERME"

     If isValid( w_cm_sp_sinistre ) Then
	  	  If w_cm_sp_sinistre.visible Then gsParam = "OUVERT"
     End If

	  If isValid( iw_W_Tm_Sp_Sinistre  ) Then
	     If iw_W_Tm_Sp_Sinistre.visible Then gsParam = "OUVERT"
     End If
			
	CASE "CONSULTER"

	/*----------------------------------------------------------------------------*/
	/* Simulation automatique de consultation sur simpa                           */
	/*----------------------------------------------------------------------------*/

		SetPointer ( HourGlass! )

		// ... Si une des fen$$HEX1$$ea00$$ENDHEX$$tres de consultation est ouverte + visible on la cache

		If IsValid (  w_cm_sp_sinistre ) Then
			IF  w_cm_sp_sinistre.visible then w_cm_sp_sinistre.visible = False
      End If

		If IsValid (  iw_W_Tm_Sp_Sinistre ) Then
			IF  iw_W_Tm_Sp_Sinistre.visible then iw_W_Tm_Sp_Sinistre.visible = False
      End If


	/*--------------------------------------------------------------------------*/
	/* (1) Chargement  dw_1 instruction, dw_2 sinistre, dw_3 archive            */
	/*--------------------------------------------------------------------------*/


		istPass.sTab[1] =   " WHERE sysadm.w_sin.id_sin = "    + gsParam +&
                       "~t WHERE sysadm.sinistre.id_sin = " + gsParam +&
                       "~t WHERE sysadm.archive.id_sin ="   + gsParam + "~t"

		istPass.STab[2] = "Automatique"

		Message.PowerObjectParm = istPass
		This.TriggerEvent ( "ue_Fin_Interro" )

	uo_onglet.uf_changerOnglet ("01") // Par d$$HEX1$$e900$$ENDHEX$$faut onglet 01

	/*--------------------------------------------------------------------------*/
	/* (2) Si le dossier existe en base instruction: Affichage $$HEX2$$e0002000$$ENDHEX$$partir de dw_1 */
	/*--------------------------------------------------------------------------*/

		If dw_1.RowCount () > 0 Then
			uo_onglet.uf_changerOnglet ("01")
			dw_1.ilLigneClick = 1
			dw_1.SelectRow (1, TRUE )
			dw_1.ScrollToRow ( 1 )
			dw_1.SetRow ( 1 )
         iuAccueilCourrant = dw_1
			This.TriggerEvent ( "ue_Modifier" )

	/*--------------------------------------------------------------------------*/
	/* (3) Si le dossier existe en base permanente: Affichage $$HEX2$$e0002000$$ENDHEX$$partir de dw_2  */
	/*--------------------------------------------------------------------------*/

      ElseIf dw_2.Rowcount() > 0 Then
			uo_onglet.uf_changerOnglet ("02")
			dw_2.ilLigneClick = 1
			dw_2.SelectRow (1, TRUE )
			dw_2.ScrollToRow ( 1 )
			dw_2.SetRow ( 1 )
         iuAccueilCourrant = dw_2
			This.TriggerEvent ( "ue_Modifier" )

		End If

  
      gsAction = ""
      gsParam  = ""

  	SetPointer ( Arrow! )

//  Ancien code Qui ouvrait excusivement le dossier dans la base permanente
    
//		istPass.lTab[1] 	= Long ( gsParam ) // ... Le param$$HEX1$$e900$$ENDHEX$$tre ( id_sin ) est sp$$HEX1$$e900$$ENDHEX$$cifi$$HEX1$$e900$$ENDHEX$$
//
//      gsAction = ""
//      gsParam  = ""
//
//		// ... Si la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation est ouverte + visible on la cache
//      //     ( cas d'un consultation pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente )
//
//		If IsValid (  w_cm_sp_sinistre ) Then
//			IF  w_cm_sp_sinistre.visible then w_cm_sp_sinistre.visible = False
//      End If
//
//		f_OuvreConsultation (  w_cm_sp_sinistre, "", istPass )
//
//		SetPointer ( Arrow! )

END CHOOSE

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

private subroutine wf_consultercourrier_sve (string asrepcourrier, string asmodele);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Ac_Sp_Dossier::wf_ConsulterCourrier_Sve (PRIVATE)
//* Auteur			: Fabry JF (Reprise int$$HEX1$$e900$$ENDHEX$$grale de la fonction de PLJ en SAVANE)
//* Date				: 13/04/2004 16:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va visualiser le courrier (M$$HEX1$$e900$$ENDHEX$$thode Saisie/Validation/Edition )
//*
//* Arguments		: Aucun
//*
//* Retourne		: Aucun
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//*
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//*    JFF   11/01/2011    [DECIMAL_PAPILLON]
//       JFF   23/01/2018 [PM407-1]
//       JFF   11/02/2019 [PM473-1]
//       JFF     03/12/2019 [TRACE_TS_COURRIER]
//*-----------------------------------------------------------------

String		sFicConsult, sFicConsultFinal, sRepWin, sFicWinIni, sDteEdit, sRepCourrier, sModele
Long			lNumLig, lIdSin, lIdInter, lIdDoc, lRet, lCpt
Blob			blFicConsult
Integer		iRet
N_Cst_Word	nvWord
OleObject	OleWord
Date			dDteEdit
Decimal {2} dcIdsin, dcIdInter, dcIdDoc
Boolean     bRet2

lNumLig = Dw_3.GetRow ( )

If lNumLig >  0 And Dw_3.RowCount ( ) > 0 Then
/*------------------------------------------------------------------*/
/* On initialise une variable d'instance pour indiquer le nom du    */
/* fichier que l'on va construire pour la consultation.             */
/*------------------------------------------------------------------*/

	lIdSin 	= Dw_3.GetitemNumber  ( lNumLig, "ID_SIN"   )
	lIdInter	= Dw_3.GetitemNumber  ( lNumLig, "ID_INTER" )
	lIdDoc	= Dw_3.GetitemNumber  ( lNumLig, "ID_DOC"   )

	// [TRACE_TS_COURRIER]
	If F_CLE_A_TRUE ( "TRACE_TS_COURRIER" ) Then
		This.wf_CourWord_TraceTsCourrier ( "DEBUT_GENERATION", lIdSin, lIdInter, lIdDoc )
	End If 


//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//	sFicConsult			= stGLB.sWinDir + "\TEMP\CONSCOUR.DOC"
//	sFicConsultFinal	= stGLB.sWinDir + "\TEMP\CONSULT.DOC"
	sFicConsult			= stGLB.sRepTempo + "CONSCOUR.DOC"
	sFicConsultFinal	= stGLB.sRepTempo + "CONSULT.DOC"
/*------------------------------------------------------------------*/
/* On positionne une cha$$HEX1$$ee00$$ENDHEX$$ne dans le fichier WIN.INI pour indiquer   */
/* $$HEX2$$e0002000$$ENDHEX$$WORD ou se trouve le document $$HEX2$$e0002000$$ENDHEX$$modifier. De plus, on          */
/* positionnne la date d'$$HEX1$$e900$$ENDHEX$$dition de ce courrier dans une CLE. La    */
/* modification de DATE sera effectu$$HEX1$$e900$$ENDHEX$$e dans la macro.               */
/*------------------------------------------------------------------*/
	sFicWinIni	= stGLB.sWinDir + "\WIN.INI"
/*------------------------------------------------------------------*/
/* On supprime le dernier fichier consult$$HEX1$$e900$$ENDHEX$$.                         */
/*------------------------------------------------------------------*/
	FileDelete ( sFicConsult )
/*------------------------------------------------------------------*/
/* Si le dernier fichier consult$$HEX2$$e9002000$$ENDHEX$$existe toujours, on arr$$HEX1$$ea00$$ENDHEX$$te tout.  */
/*------------------------------------------------------------------*/
	If	f_FileExists ( sFicConsult ) Then 
		RUN ( "taskkill /F  /IM WINWORD.EXE /T" , minimized! )
		Yield ()
		Do While f_FileExists ( sFicConsult )
			FileDelete ( sFicConsult )
			Yield ()			
		Loop
	End If 


	If	f_FileExists ( sFicConsult ) Then 

		// [TRACE_TS_COURRIER]
		If F_CLE_A_TRUE ( "TRACE_TS_COURRIER" ) Then
			This.wf_CourWord_TraceTsCourrier ( "FIN_GENERATION_ERREUR", lIdSin, lIdInter, lIdDoc )
		End If 
		
		Return
	End If
/*------------------------------------------------------------------*/
/* La premi$$HEX1$$e800$$ENDHEX$$re chose $$HEX2$$e0002000$$ENDHEX$$faire est de r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le courrier dans      */
/* ARCHIVE_BLOB 																	  */
/*------------------------------------------------------------------*/

	// [CONSULT_RESTREINTE]
	lRet = SQLCA.PS_S_CONSULT_RESTREINTE ( stGlb.sCodOper, lIdSin, "" )
	If lRet < 0 Then
		stMessage.sTitre		= "Consultation restreinte"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "GENE174"
		stMessage.bTrace  	= False

		F_Message ( stMessage )				
		Return
	End If 

	// [CONS_REST_CARDIF]
	If SQLCA.PS_S_CONS_RESTR_EXCL( lIdSin, stGlb.sCodOper, "P" ) < 0 Then
		stMessage.sTitre		= "Acc$$HEX1$$e800$$ENDHEX$$s interdit"
		stMessage.Icon		   = Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "GENE180"
		F_Message ( stMessage )
		Return 				
	End If 

	// [PM473-1]
	If Upper(SQLCA.Database) <> "SIMPA2_PRO" &
		And Not F_CLE_A_TRUE ( "PM473-1_SPECIAL_TEST" ) Then

				Choose Case stGlb.sCodOper 
					Case "JFF", "FPI"
						If F_CLE_A_TRUE ( "BASE_SIM_ANONYME" ) Then
							If SQLCA.PS_CTLE_DOS_CREE_EN_SIM ( lIdSin ) < 0 Then
								stMessage.sTitre		= "Acc$$HEX1$$e800$$ENDHEX$$s interdit hors production"
								stMessage.Icon		   = Exclamation!
								stMessage.bErreurG	= FALSE
								stMessage.Bouton		= OK!
								stMessage.sCode		= "GENE182"
								F_Message ( stMessage )
								Return 
							End If 
						End If
					Case Else
						If SQLCA.PS_CTLE_DOS_CREE_EN_SIM ( lIdSin ) < 0 Then
							stMessage.sTitre		= "Acc$$HEX1$$e800$$ENDHEX$$s interdit hors production"
							stMessage.Icon		   = Exclamation!
							stMessage.bErreurG	= FALSE
							stMessage.Bouton		= OK!
							stMessage.sCode		= "GENE182"
							F_Message ( stMessage )
							Return 
						End If 
				End Choose 
	End If 

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la date d'$$HEX1$$e900$$ENDHEX$$dition, et on la formate correctement.    */
/*------------------------------------------------------------------*/
	dDteEdit = Date(Dw_3.GetItemDateTime ( Dw_3.ilLigneClick, "DTE_EDIT" )) // [PI056] - GetItemDate => GetItemDateTime
	sDteEDit	= String ( Day ( dDteEdit ) ) + " " + F_Txt_Mois ( Month ( dDteEdit ) ) + " " + String ( Year ( dDteEdit ) )

	// [DECIMAL_PAPILLON]
	dcIdsin = dec ( lIdSin )
	dcIdinter = dec ( lIdInter )
	dcIdDoc = dec ( lIdDoc )
	SELECTBLOB	txt_blob
	INTO			:blFicConsult
	FROM			sysadm.archive_blob
	WHERE			sysadm.archive_blob.id_sin			= :dcIdsin			AND
					sysadm.archive_blob.id_inter		= :dcIdinter		AND
					sysadm.archive_blob.id_doc			= :dcIdDoc			AND
					sysadm.archive_blob.id_typ_blob	= 'DO'
	USING	itrtrans ;

// [PM407-1]
If iTrTrans.SQLCode = 0 And SQLCA.PS_S_PM407_CONSULT_KSL (dcIdsin, dcIdInter, dcIdDoc ) > 0 Then
	stMessage.sTitre		= "wf_ConsulterCourrier_Sve"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "GENE178 "
	stMessage.bTrace  	= False
	F_Message ( stMessage )
	Return
End If 		


/*------------------------------------------------------------------*/
/* La r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du courrier ne marche pas.                       */
/*------------------------------------------------------------------*/
	If iTrTrans.SQLCode <> 0 Then
		stMessage.sTitre		= "wf_ConsulterCourrier_Sve"
		stMessage.sVar[1]		= String ( lIdSin ) + "," + String ( lIdInter ) + "," + String ( lIdDoc )
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "SVAL90"
		stMessage.bTrace  	= False

		// [TRACE_TS_COURRIER]
		If F_CLE_A_TRUE ( "TRACE_TS_COURRIER" ) Then
			This.wf_CourWord_TraceTsCourrier ( "FIN_GENERATION_ERREUR", lIdSin, lIdInter, lIdDoc )
		End If 

		F_Message ( stMessage )
		Return			
	End If
/*------------------------------------------------------------------*/
/* La taille du blob est incorrecte.                                */
/*------------------------------------------------------------------*/
// [MIGPB11] [EMD] : Debut Migration : Report migration Suisse
//	If	Len ( Trim ( String ( blFicConsult ) ) ) < 5	Then
	If	Len ( blFicConsult ) < 5	Then
// [MIGPB11] [EMD] : Fin Migration

		// [PM407-1]
		stMessage.sTitre		= "wf_ConsulterCourrier_Sve"
		stMessage.sVar[1]		= String ( lIdSin ) + "," + String ( lIdInter ) + "," + String ( lIdDoc )
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "SVAL90"
		stMessage.bTrace  	= False

		// [TRACE_TS_COURRIER]
		If F_CLE_A_TRUE ( "TRACE_TS_COURRIER" ) Then
			This.wf_CourWord_TraceTsCourrier ( "FIN_GENERATION_ERREUR", lIdSin, lIdInter, lIdDoc )
		End If 

		F_Message ( stMessage )
		Return			
	End If
/*------------------------------------------------------------------*/
/* On va $$HEX1$$e900$$ENDHEX$$crire le BLOB dans un fichier.                            */
/*------------------------------------------------------------------*/
	If Not F_EcrireFichierBlob ( blFicConsult, sFicConsult )	Then
		// [TRACE_TS_COURRIER]
		If F_CLE_A_TRUE ( "TRACE_TS_COURRIER" ) Then
			This.wf_CourWord_TraceTsCourrier ( "FIN_GENERATION_ERREUR", lIdSin, lIdInter, lIdDoc )
		End If 
		
		Return
	End If 
	
/*------------------------------------------------------------------*/
/* On positionne une cha$$HEX1$$ee00$$ENDHEX$$ne dans le fichier WIN.INI pour indiquer   */
/* $$HEX2$$e0002000$$ENDHEX$$WORD ou se trouve le document $$HEX2$$e0002000$$ENDHEX$$modifier. De plus, on          */
/* positionnne la date d'$$HEX1$$e900$$ENDHEX$$dition de ce courrier dans une CLE. La    */
/* modification de DATE sera effectu$$HEX1$$e900$$ENDHEX$$e dans la macro.               */
/*------------------------------------------------------------------*/
	SetProfileString ( sFicWinIni, "SIMPA2", "Nouveau Courrier", sFicConsult )
	SetProfileString ( sFicWinIni, "SIMPA2", "Dte Edition Nouveau Courrier", sDteEdit )
/*------------------------------------------------------------------*/
/* On va cr$$HEX1$$e900$$ENDHEX$$er un Objet de Type OLE.                                */
/*------------------------------------------------------------------*/
	oleWord = CREATE OleObject
/*------------------------------------------------------------------*/
/* On se connecte $$HEX2$$e0002000$$ENDHEX$$WORD.                                           */
/*------------------------------------------------------------------*/
	F_SetVersionWord ( nvWord, TRUE )
	iRet = nvWord.uf_CreerOleObject_Word ( oleWord )
/*------------------------------------------------------------------*/
/* La connexion $$HEX1$$e900$$ENDHEX$$choue, on arr$$HEX1$$ea00$$ENDHEX$$te tout.                             */
/*------------------------------------------------------------------*/
	If	iRet <> 0	Then
		F_SetVersionWord ( nvWord, FALSE )
		Destroy oleWord
		
		// [TRACE_TS_COURRIER]
		If F_CLE_A_TRUE ( "TRACE_TS_COURRIER" ) Then
			This.wf_CourWord_TraceTsCourrier ( "FIN_GENERATION_ERREUR", lIdSin, lIdInter, lIdDoc )
		End If 		
		
		Return
	End If
/*------------------------------------------------------------------*/
/* Si Word est d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$ouvert, on v$$HEX1$$e900$$ENDHEX$$rifie s'il existe des documents    */
/* non sauvegard$$HEX1$$e900$$ENDHEX$$s. Si c'est le cas, on arr$$HEX1$$ea00$$ENDHEX$$te tout.                */
/*------------------------------------------------------------------*/
	iRet = nvWord.uf_FichierOuvertDansWord ( oleWord, TRUE, FALSE )
	If	iRet <> 1 Then
		F_SetVersionWord ( nvWord, FALSE )
		Destroy oleWord
		
		// [TRACE_TS_COURRIER]
		If F_CLE_A_TRUE ( "TRACE_TS_COURRIER" ) Then
			This.wf_CourWord_TraceTsCourrier ( "FIN_GENERATION_ERREUR", lIdSin, lIdInter, lIdDoc )
		End If 		
		
		Return
	End If
/*------------------------------------------------------------------*/
/* On ouvre le fichier mod$$HEX1$$e900$$ENDHEX$$le par d$$HEX1$$e900$$ENDHEX$$faut, et on ex$$HEX1$$e900$$ENDHEX$$cute la macro    */
/* DUPLICATA.                                                       */
/*------------------------------------------------------------------*/
	sRepCourrier	= ProfileString ( stGLB.sFichierIni, "EDITION", "REP_COURRIER", "" )
	sModele			= ProfileString ( stGLB.sFichierIni, "EDITION", "MODELE", "" )
	sModele			= sRepCourrier + sModele
	nvWord.uf_CommandeWord ( 1, sModele, oleWord )
	nvWord.uf_CommandeWord ( 2, "DUPLICATA", oleWord )

	F_SetVersionWord ( nvWord, FALSE )
	Destroy oleWord
	
	
	// Gestion de la trace de consultation (d'encours) ici ET je Commit. 
	lRet = SQLCA.PS_I_PI087_TRACE_DOSSIER_V01 ( lIdSin, "CONSULTATION", stGLB.sCodOper, lIdInter, lIdDoc )
	
	bRet2 = SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0 And lRet > 0
	
	F_Commit ( SQLCA, bRet2 ) 
	
	If Not bRet2 Then
		stMessage.sTitre		= "Consultation d'un courrier"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= False
		stMessage.sVar[1] 	= "PS_I_PI087_TRACE_DOSSIER"
		stMessage.sVar[2] 	= String ( SQLCA.SqlDbCode )
		stMessage.sVar[3] 	= SQLCA.SqlErrText
		stMessage.sCode		= "WSIN850"
		F_Message ( stMessage )

	End If 
	
	// [TRACE_TS_COURRIER]
	If F_CLE_A_TRUE ( "TRACE_TS_COURRIER" ) Then
		This.wf_CourWord_TraceTsCourrier ( "FIN_GENERATION_SUCCES", lIdSin, lIdInter, lIdDoc )
	End If 
	
End If

end subroutine

public subroutine wf_pi052_consulter_pdf ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Ac_Sp_Dossier::wf_pi052_consulter_PDF (PRIVATE)
//* Auteur			: Fabry JF 
//* Date				: 27/08/2014 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Aucun
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//*
//*-----------------------------------------------------------------

Long			lNumLig, lIdSin, lIdInter, lIdDoc
Decimal {2} 	dcIdsin, dcIdInter, dcIdDoc
Blob			blFicConsult
String		sFicConsult

// Affichage
Integer iRet, iCnt
Long    lTot, lCpt
String  sPathExeFix, sPathExeFic, sClassePdf
String sWindowClass
Ulong ulWnd

lNumLig = Dw_3.GetRow ( )

lIdSin 	= Dw_3.GetitemNumber  ( lNumLig, "ID_SIN"   )
lIdInter	= Dw_3.GetitemNumber  ( lNumLig, "ID_INTER" )
lIdDoc	= Dw_3.GetitemNumber  ( lNumLig, "ID_DOC"   )

sFicConsult			= stGLB.sRepTempo + "CONSCOUR.PDF"

FileDelete ( sFicConsult )

//Migration PB8-WYNIWYG-03/2006 CP
//	If	FileExists ( sFicConsult ) Then 
If	f_FileExists ( sFicConsult ) Then 
//Fin Migration PB8-WYNIWYG-03/2006 CP		
	Return
End If


// [DECIMAL_PAPILLON]
dcIdsin = dec ( lIdSin )
dcIdinter = dec ( lIdInter )
dcIdDoc = dec ( lIdDoc )
SELECTBLOB	txt_blob
INTO			:blFicConsult
FROM			sysadm.archive_blob
WHERE			sysadm.archive_blob.id_sin			= :dcIdsin			AND
				sysadm.archive_blob.id_inter		= :dcIdinter		AND
				sysadm.archive_blob.id_doc			= :dcIdDoc			AND
				sysadm.archive_blob.id_typ_blob	= 'DO'
USING	itrtrans ;

/*------------------------------------------------------------------*/
/* La r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du courrier ne marche pas.                       */
/*------------------------------------------------------------------*/
If iTrTrans.SQLCode <> 0 Then
	stMessage.sTitre		= "wf_pi052_consulter_PDF"
	stMessage.sVar[1]		= String ( lIdSin ) + "," + String ( lIdInter ) + "," + String ( lIdDoc )
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "SVAL90"
	stMessage.bTrace  	= False

	F_Message ( stMessage )
	Return
End If

/*------------------------------------------------------------------*/
/* La taille du blob est incorrecte.                                */
/*------------------------------------------------------------------*/
// [MIGPB11] [EMD] : Debut Migration : Report migration Suisse
//	If	Len ( Trim ( String ( blFicConsult ) ) ) < 5	Then
If	Len ( blFicConsult ) < 5	Then
// [MIGPB11] [EMD] : Fin Migration
	stMessage.sTitre		= "wf_pi052_consulter_PDF"
	stMessage.sVar[1]		= String ( lIdSin ) + "," + String ( lIdInter ) + "," + String ( lIdDoc )
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "SVAL90"
	stMessage.bTrace  	= False

	F_Message ( stMessage )
	Return
End If
/*------------------------------------------------------------------*/
/* On va $$HEX1$$e900$$ENDHEX$$crire le BLOB dans un fichier.                            */
/*------------------------------------------------------------------*/
If Not F_EcrireFichierBlob ( blFicConsult, sFicConsult )	Then Return


// Affichage

sPathExeFix = F_GetPathAcrobatReader ()
sPathExeFic = F_Remplace ( sPathExeFix, "%1", sFicConsult  )
Run ( sPathExeFic, Normal! )

// Redimension
RegistryGet( "HKEY_CLASSES_ROOT\.pdf", "", sClassePdf ) 
// Nom r$$HEX2$$e900e900$$ENDHEX$$l actuellement sous version 11  => sClassePdf = AcroExch.Document.11

sWindowClass=""
				 
For iCnt=1 to 2
	 if Pos ( Upper ( sClassePdf ),"ACRO") > 0 Then 
		  if iCnt=1 Then sWindowClass="AdobeAcrobat"
		  if iCnt=2 Then sWindowClass="AcrobatSDIWindow"
	 End if
	 
	 if Pos(Upper(sClassePdf),"FOX") > 0 Then sWindowClass="classFoxitReader"

	 ulWnd= FindWindowA(sWindowClass,0) 

	 If ulWnd > 0 Then
		  MoveWindow(ulWnd,ilPos[1],ilPos[2],ilPos[4],ilPos[3],1)
//			  SetwindowPos(ulWnd,0,ilPos[1],ilPos[2],ilPos[4],ilPos[3],0)
		  exit
	 End if
Next
	
	





end subroutine

public subroutine wf_pi052_consulter_doc ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Ac_Sp_Dossier::wf_pi052_consulter_DOC (PRIVATE)
//* Auteur			: Fabry JF 
//* Date				: 27/08/2014 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Aucun
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//*
//*-----------------------------------------------------------------

Long			lNumLig, lIdSin, lIdInter, lIdDoc
Decimal {2} 	dcIdsin, dcIdInter, dcIdDoc
Blob			blFicConsult
String		sFicConsult

// Affichage
Integer iRet, iCnt
Long    lTot, lCpt
String  sPathExeFix, sPathExeFic, sClasseWord 
String sWindowClass
Ulong ulWnd

lNumLig = Dw_3.GetRow ( )

lIdSin 	= Dw_3.GetitemNumber  ( lNumLig, "ID_SIN"   )
lIdInter	= Dw_3.GetitemNumber  ( lNumLig, "ID_INTER" )
lIdDoc	= Dw_3.GetitemNumber  ( lNumLig, "ID_DOC"   )

sFicConsult			= stGLB.sRepTempo + "CONSCOUR.DOC"

FileDelete ( sFicConsult )

//Migration PB8-WYNIWYG-03/2006 CP
//	If	FileExists ( sFicConsult ) Then 
If	f_FileExists ( sFicConsult ) Then 
//Fin Migration PB8-WYNIWYG-03/2006 CP		
	Return
End If


// [DECIMAL_PAPILLON]
dcIdsin = dec ( lIdSin )
dcIdinter = dec ( lIdInter )
dcIdDoc = dec ( lIdDoc )
SELECTBLOB	txt_blob
INTO			:blFicConsult
FROM			sysadm.archive_blob
WHERE			sysadm.archive_blob.id_sin			= :dcIdsin			AND
				sysadm.archive_blob.id_inter		= :dcIdinter		AND
				sysadm.archive_blob.id_doc			= :dcIdDoc			AND
				sysadm.archive_blob.id_typ_blob	= 'DO'
USING	itrtrans ;

/*------------------------------------------------------------------*/
/* La r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du courrier ne marche pas.                       */
/*------------------------------------------------------------------*/
If iTrTrans.SQLCode <> 0 Then
	stMessage.sTitre		= "wf_pi052_consulter_DOC"
	stMessage.sVar[1]		= String ( lIdSin ) + "," + String ( lIdInter ) + "," + String ( lIdDoc )
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "SVAL90"
	stMessage.bTrace  	= False

	F_Message ( stMessage )
	Return
End If

/*------------------------------------------------------------------*/
/* La taille du blob est incorrecte.                                */
/*------------------------------------------------------------------*/
// [MIGPB11] [EMD] : Debut Migration : Report migration Suisse
//	If	Len ( Trim ( String ( blFicConsult ) ) ) < 5	Then
If	Len ( blFicConsult ) < 5	Then
// [MIGPB11] [EMD] : Fin Migration
	stMessage.sTitre		= "wf_pi052_consulter_DOC"
	stMessage.sVar[1]		= String ( lIdSin ) + "," + String ( lIdInter ) + "," + String ( lIdDoc )
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "SVAL90"
	stMessage.bTrace  	= False

	F_Message ( stMessage )
	Return
End If
/*------------------------------------------------------------------*/
/* On va $$HEX1$$e900$$ENDHEX$$crire le BLOB dans un fichier.                            */
/*------------------------------------------------------------------*/
If Not F_EcrireFichierBlob ( blFicConsult, sFicConsult )	Then Return


// Affichage
sPathExeFix =  F_GetPathWord ()
sPathExeFic = F_Remplace ( sPathExeFix, "%1", sFicConsult  )
Run ( sPathExeFic, Normal! )

// Redimension
RegistryGet( "HKEY_CLASSES_ROOT\.doc", "", sClasseWord ) 
// Nom r$$HEX2$$e900e900$$ENDHEX$$l actuellement sous version 11  => sClasseWord = AcroExch.Document.11

sWindowClass=""

For iCnt=1 to 1
	 if Pos ( Upper ( sClasseWord ),"WORD") > 0 Then 
		  if iCnt=1 Then sWindowClass="OpusApp"
	 End if

	 ulWnd= FindWindowA(sWindowClass,0) 

	 If ulWnd > 0 Then
		  MoveWindow(ulWnd,ilPos[1],ilPos[2],ilPos[4],ilPos[3],1)
//			  SetwindowPos(ulWnd,0,ilPos[1],ilPos[2],ilPos[4],ilPos[3],0)
		  exit
	 End if
Next

	
	





end subroutine

public subroutine wf_anonymationensim (long adcidsin);//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Cree_Wkf::wf_AnonymationEnSim (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 13/02/2019
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PM473-1]
//*
//* Arguments		: adcidsin
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//*-----------------------------------------------------------------

String sSql
Boolean bRet 
Long lRet

lRet = SQLCA.PS_U_TRT_PM260 ( adcIdSin, "SIM" )

If lRet > 0 Then
	F_Execute ( sSql, SQLCA )
	
	bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0
	
	F_Commit ( SQLCA, bRet )  // Commit/Rollback
End If 

end subroutine

public subroutine wf_courword_tracetscourrier (string ascas, long alidsin, long alidinter, long aliddoc);//*-----------------------------------------------------------------
//*
//* Fonction		: w_ac_sp_dossier_2000::wf_CourWord_TraceTsCourrier			(PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 03/12/2019
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion de la trace des courriers sur TS
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//*-----------------------------------------------------------------

String	sRepCourrierIni, sFicCourrierIni, sStatus, sErreurWord, sFinChaine, sIdCour, sSql, sFicConsult	
Long lCpt 

sFicConsult	= stGLB.sRepTempo + "CONSCOUR.DOC"

Choose Case asCas
	Case "DEBUT_GENERATION"
		ilIdentityTraceTsCourrier  = 0
		SQLCA.PS_I_TRACE_TS_COURRIER (alIdSin, SQLCA.uf_GetIdSql(), "C", stNul.str, alIdInter, alIdDoc, stGlb.sCodOper, 0, ilIdentityTraceTsCourrier   )
		
		F_Commit ( SQLCA, SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0 )

	Case "FIN_GENERATION_SUCCES"		
	
		
		If	f_FileExists ( sFicConsult ) And FileLength64 ( sFicConsult ) > 0 Then 
			sSql = "Exec sysadm.PS_U_TRACE_TS_COURRIER " + String ( ilIdentityTraceTsCourrier ) + ", 1, null"
			F_Execute ( sSql, SQLCA )
			F_Commit ( SQLCA, SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0 )
			
		Else 
			sSql = "Exec sysadm.PS_U_TRACE_TS_COURRIER " + String ( ilIdentityTraceTsCourrier ) + ", -1, null"
			F_Execute ( sSql, SQLCA )
			F_Commit ( SQLCA, SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0 )			
			
			Yield ()
			RUN ( "taskkill /F  /IM WINWORD.EXE /T" , minimized! )
			Yield ()
			
		End If 

	Case "FIN_GENERATION_ERREUR"		
		
		sSql = "Exec sysadm.PS_U_TRACE_TS_COURRIER " + String ( ilIdentityTraceTsCourrier ) + ", -1, null"
		F_Execute ( sSql, SQLCA )
		F_Commit ( SQLCA, SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0 )			

		Yield ()
		RUN ( "taskkill /F  /IM WINWORD.EXE /T" , minimized! )
		Yield ()
	
		
End Choose 





end subroutine

event ue_item6;call super::ue_item6;//*-----------------------------------------------------------------
//*
//* Objet			: Fen$$HEX1$$ea00$$ENDHEX$$tre
//* Evenement 		: ue_item6
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture fen$$HEX1$$ea00$$ENDHEX$$tre en raccourci.
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

/*----------------------------------------------------------------------------*/
/* Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil de saisie de sinistre.                   */
/*----------------------------------------------------------------------------*/
SetPointer ( HourGlass! )

Choose Case isBoutonRac

	Case "TEL","COURRIER"

		stGlb.sMessageErreur = isBoutonRac

		If IsValid ( W_a_Sp_Cree_Travail ) Then 
			W_a_Sp_Cree_Travail.Show()
		Else
			OpenSheetWithParm ( W_a_Sp_Cree_Travail, stGLB, W_Mdi_Sp, 0, Layered! )
		End If

		W_a_Sp_Cree_Travail.BringToTop = True
		W_a_Sp_Cree_Travail.TriggerEvent ("ue_Saisie_Automatique")

	Case "SAISIESIN"

		stGlb.sMessageErreur = isBoutonRac

		If IsValid ( W_a_Sp_Wkf_Saisie ) Then 
			W_a_Sp_Wkf_Saisie.Show()
		Else
			OpenSheetWithParm ( W_a_Sp_Wkf_Saisie, stGLB, W_Mdi_Sp, 0, Layered! )
		End If

		W_a_Sp_Wkf_Saisie.BringToTop = True
		W_a_Sp_Wkf_Saisie.TriggerEvent ("ue_Saisie_Automatique")

	Case "EDTSIN"

		/*------------------------------------------------------------------*/
		/* Si on est en SVE                                                 */
		/*------------------------------------------------------------------*/
		If stGLB.bSaiValEdt Then
			If IsValid ( W_Ae_Sp_Edition_Dcmp060589 ) Then 
				W_Ae_Sp_Edition_Dcmp060589.Show()
			Else
				OpenSheetWithParm ( W_Ae_Sp_Edition_Dcmp060589, stGLB, W_Mdi_Sp, 0, Layered! )
			End If

			W_Ae_Sp_Edition_Dcmp060589.BringToTop = True
			W_Ae_Sp_Edition_Dcmp060589.TriggerEvent ("ue_Saisie_Automatique")

		Else 
			If IsValid ( w_ae_sp_edit_sinistre_wkf_2000 ) Then 
				w_ae_sp_edit_sinistre_wkf_2000.Show()
			Else
				OpenSheetWithParm ( w_ae_sp_edit_sinistre_wkf_2000 , stGLB, W_Mdi_Sp, 0, Layered! )
			End If

			w_ae_sp_edit_sinistre_wkf_2000.BringToTop = True
			w_ae_sp_edit_sinistre_wkf_2000.TriggerEvent ("ue_Saisie_Automatique")

		End If

	Case "VALSIN"

		stGlb.sMessageErreur = isBoutonRac

		If IsValid ( w_a_sp_wkf_validation ) Then 
			w_a_sp_wkf_validation.Show()
		Else
			OpenSheetWithParm ( w_a_sp_wkf_validation , stGLB, W_Mdi_Sp, 0, Layered! )
		End If

		w_a_sp_wkf_validation.BringToTop = True
		w_a_sp_wkf_validation.TriggerEvent ("ue_Saisie_Automatique")

End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_word;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_spb_archive
//* Evenement 		: Ue_Word
//* Auteur			: PLJ
//* Date				: 09/06/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$clenche la consultation du courrier s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF   13/04/04  DCMP 040020 SVE : Gestion d'une ancienne entete SIMPA2 et 
//*							Mise en prod de la SVE
//      JFF   12/06/14  [PI052]
//*-----------------------------------------------------------------

Long		lNumlig			// N$$HEX2$$b0002000$$ENDHEX$$de ligne s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e.
Long     lIdSin, lIdInter, lIdDoc
String sRepCourrier, sModele, sEntete, sCleEdition
String sFormatDoc 
Date	dDteEdit

lNumLig = Dw_3.GetRow ( )

If lNumLig >  0 And Dw_3.RowCount ( ) > 0 Then

	SetPointer ( HourGlass! )

End If

// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	If lNumLig >  0 And Dw_3.RowCount ( ) > 0 Then
		lIdSin 	= Dw_3.GetitemNumber  ( lNumLig, "ID_SIN"   )
		lIdInter	= Dw_3.GetitemNumber  ( lNumLig, "ID_INTER" )
		lIdDoc	= Dw_3.GetitemNumber  ( lNumLig, "ID_DOC"   )
		
		sFormatDoc = Space ( 10 )
		
		SQLCA.PS_S_WCBA_KSL_FORMAT ( lIdSin, lIdInter, lIdDoc, sFormatDoc ) 
		
		Choose Case sFormatDoc 
			Case "PDF"
				This.wf_pi052_consulter_PDF ()
			Case "DOC"							
				This.wf_pi052_consulter_DOC ()
			Case "ANCIEN_DOC"											
				// On ne fait, le code ci-dessous d'origine prend le relai 				
			Case Else
				// On ne fait, le code ci-dessous d'origine prend le relai 
		End Choose				
		
		If sFormatDoc <> "ANCIEN_DOC" Then
			Return 0
		End If
		
	End If
End If
*/
// [PI052]


dDteEdit = Date(Dw_3.GetItemDateTime ( Dw_3.ilLigneClick, "DTE_EDIT" )) // [PI056] - GetItemDate => GetItemDateTime

/*----------------------------------------------------------------------------*/
/* Les variables d'instances suivantes sont arm$$HEX1$$e900$$ENDHEX$$es dans ue_initialiser			*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* Si le courrier est un courrier SIMPA1 alors...										*/
/*----------------------------------------------------------------------------*/
If Dw_3.GetItemNumber ( Dw_3.ilLigneClick, "COD_VERSION" ) = 1 Then
/*----------------------------------------------------------------------------*/
/* En Fonction du 04-09-1995 on affecte le fichier d'ent$$HEX1$$ea00$$ENDHEX$$te. (Avant cette date*/
/* , le fichier d'ent$$HEX1$$ea00$$ENDHEX$$te $$HEX1$$e900$$ENDHEX$$tait diff$$HEX1$$e900$$ENDHEX$$rent de celui utilis$$HEX2$$e9002000$$ENDHEX$$aujourd'hui)			*/
/*----------------------------------------------------------------------------*/
	If dDteEdit > 1995-09-04 Then
		sRepCourrier 	= isRepCourrierSimpa1
		sModele			= isModeleSimpa1
		sEntete			= isEnteteSimpa1
		isFicEntete		= isRepCourrierSimpa1 + isEnteteSimpa1
		sCleEdition		= "EDITION_SIMPA1"
	Else
		sRepCourrier 	= isRepCourrierSimpa1
		sModele			= isModeleSimpa1
		sEntete			= isEnteteSimpa1_Anc
		isFicEntete 	= isRepCourrierSimpa1 + isEnteteSimpa1_Anc
		sCleEdition		= "EDITION_SIMPA1"
	End If
/*----------------------------------------------------------------------------*/
/* Si le courrier est un courrier SIMPA2 alors...										*/
/*----------------------------------------------------------------------------*/
Else

/*------------------------------------------------------------------*/
/* #1 : Si la date d'$$HEX1$$e900$$ENDHEX$$dition est 01/01/1900 Alors le courrier est   */
/* bien issu de la SVE mais n'a pas encore $$HEX1$$e900$$ENDHEX$$tait $$HEX1$$e900$$ENDHEX$$dit$$HEX1$$e900$$ENDHEX$$. Il est      */
/* toujours en std by d'$$HEX1$$e900$$ENDHEX$$dition sur w_cour_blob_arch. La valeur     */
/* 01/01/1900 est un r$$HEX1$$e900$$ENDHEX$$p$$HEX1$$e800$$ENDHEX$$re pour d$$HEX1$$e900$$ENDHEX$$celer cela, car cette date est   */
/* obligatoire (non nulle).                                         */
/*------------------------------------------------------------------*/
	If dDteEdit = 1900-01-01 Then
		stMessage.sTitre = "Courrier non encore $$HEX1$$e900$$ENDHEX$$dit$$HEX1$$e900$$ENDHEX$$"
		stMessage.Icon   = information!
		stMessage.scode  = "EDIT040"
		stMessage.bErreurG= False
		f_Message ( stMessage )
		SetPointer ( Arrow! )
		Return
	End If

/*------------------------------------------------------------------*/
/* #1 : Si la Date d'$$HEX1$$e900$$ENDHEX$$dition est strictement avant le premier jour  */
/* de mise en production de la SVE alors c'est une edition $$HEX9$$e00020002000200020002000200020002000$$ENDHEX$$*/
/* l'ancienne m$$HEX1$$e900$$ENDHEX$$thode (fusion avec DT) ET avec l'ancien fichier     */
/* d'entete.                                                        */
/*------------------------------------------------------------------*/
	If dDteEdit < idDateSVE Then
		sRepCourrier 	= isRepCourrierSimpa2
		sModele			= isModeleSimpa2
		sEntete			= isEnteteSimpa2_Anc1
		isFicEntete		= isRepCourrierSimpa2 + isEnteteSimpa2_Anc1
		sCleEdition		= "EDITION"

/*------------------------------------------------------------------*/
/* #1 : Si la Date d'$$HEX1$$e900$$ENDHEX$$dition est sup$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gale $$HEX2$$e0002000$$ENDHEX$$la date de   */
/* mise en prod de la SVE, c'est donc un nouveau courrier $$HEX2$$e0002000$$ENDHEX$$la      */
/* m$$HEX1$$e900$$ENDHEX$$thode SVE, cr$$HEX3$$e900e9002000$$ENDHEX$$avec le nouvel entete. Pour m$$HEX1$$e900$$ENDHEX$$moire on         */
/* m$$HEX1$$e900$$ENDHEX$$morise le nouvel ent$$HEX1$$ea00$$ENDHEX$$te, mais il ne servira pas $$HEX2$$e0002000$$ENDHEX$$la           */
/* reconstruction du courrier qui est d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$fusionn$$HEX2$$e9002000$$ENDHEX$$(DO).           */
/*------------------------------------------------------------------*/
	ELse 
		sRepCourrier 	= isRepCourrierSimpa2
		sModele			= isModeleSimpa2
		sEntete			= isEnteteSimpa2
		isFicEntete		= isRepCourrierSimpa2 + isEnteteSimpa2
		sCleEdition		= "EDITION"
	End If 

End If

/*------------------------------------------------------------------*/
/* #1 : Selon la m$$HEX1$$e900$$ENDHEX$$thode, on bascule une des deux fonctions.        */
/*------------------------------------------------------------------*/
If	Not IsNull ( dDteEdit )	And dDteEdit <> 1900-01-01 And idDateSVE <> 1900-01-01 Then
	If dDteEdit < idDateSVE Then
		Wf_ConsulterCourrier ( sRepCourrier, sModele, sEntete, sCleEdition )
	Else
		Wf_ConsulterCourrier_Sve ( sRepCourrier, sModele )
	End If
Else
	stMessage.sTitre		= "M$$HEX1$$e900$$ENDHEX$$thode d'$$HEX1$$e900$$ENDHEX$$dition"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= False
	stMessage.sCode		= "EDIT040"

	F_Message ( stMessage )
End If

SetPointer ( Arrow! )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			: Dw_1
//* Evenement 		: Open
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
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
//* #2		   JFF		05/09/2002 Gestion de la gestion de contact uniquement pour Sherpa
//*-----------------------------------------------------------------

Boolean	bAff

/*------------------------------------------------------------------*/
/* Initialisation des boutons de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie.                        */
/*------------------------------------------------------------------*/
/* #2 : JFF le 04/09/2002														  */
/*------------------------------------------------------------------*/
bAff = ProfileString ( stGlb.sFichierIni, "BOUTONS RACCOURCIS", "BoutonRac", "" ) = "O"

pb_Edition.Visible 		= stGlb.bEdtSin

pb_Tel.Visible 		= bAff And stGlb.bCreationTrv
pb_Workflow.Visible 	= bAff And stGlb.bCreationTrv
pb_Saisie.Visible 		= bAff And stGlb.bSaisieSin
pb_Validation.Visible 	= bAff And stGlb.bValSin

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_sp_dossier
//* Evenement 		: ue_modifier
//* Auteur			: PLJ
//* Date				: 15/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Appel des fen$$HEX1$$ea00$$ENDHEX$$tres de consultation
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//       JFF   16/02/2015 [CONSULT_RESTREINTE]
//       JFF   11/02/2019 [PM473-1]
//*-----------------------------------------------------------------

s_Pass stPass
Long lRet, lIdSin

stPass = istpass

Choose Case iuAccueilCourrant

	Case dw_1		// .... Consultation dossiers en instruction

		SetPointer( HourGlass! )

		stPass.bSupprime = False
		stPass.bControl  = False
		stPass.bInsert   = False

		stPass.sTab[1]   = String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_SIN" ) )

		stPass.sTab[2]   = "C"								// Nous sommes en consultation

		stPass.sTab[3]   = "" 								// zone devant $$HEX1$$ea00$$ENDHEX$$tre aliment$$HEX1$$e900$$ENDHEX$$e par des cha$$HEX1$$ee00$$ENDHEX$$nes vides  pour 
		stPass.sTab[4]   = ""								// que les indices 3, 4, 5 du tableau sTab soient valides
		stPass.sTab[5]   = ""								

		// [CONSULT_RESTREINTE]
		SetNull ( lIdSin )
		lRet = SQLCA.PS_S_CONSULT_RESTREINTE ( stGlb.sCodOper, lIdSin, "" )
		If lRet < 0 Then
			stMessage.sTitre		= "Consultation restreinte"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "GENE175"
			stMessage.bTrace  	= False
	
			F_Message ( stMessage )				
			Return 0
		End If 

		// [CONS_REST_CARDIF]
		If SQLCA.PS_S_CONS_RESTR_EXCL( long ( stPass.sTab[1] ), stGlb.sCodOper, "W" ) < 0 Then
			stMessage.sTitre		= "Acc$$HEX1$$e800$$ENDHEX$$s interdit"
			stMessage.Icon		   = Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "GENE180"
			F_Message ( stMessage )
			Return 0				
		End If 

		// [PM473-1]
		If Upper(SQLCA.Database) <> "SIMPA2_PRO" &
			And Not F_CLE_A_TRUE ( "PM473-1_SPECIAL_TEST" )	Then
			
				Choose Case stGlb.sCodOper 
					Case "JFF", "FPI"
						If F_CLE_A_TRUE ( "BASE_SIM_ANONYME" ) Then
							This.wf_AnonymationEnSim ( Long ( stPass.sTab[1]))
						End If
					Case Else
						This.wf_AnonymationEnSim ( Long ( stPass.sTab[1]))
				End Choose 
		End If 

		/*-----------------------------------------------------------------------------*/
		/* Pour F_OuvreTraitement, on passe une instance de fen$$HEX1$$ea00$$ENDHEX$$tre et non une fen$$HEX1$$ea00$$ENDHEX$$tre */
		/* Cela pour permettre d'ouvrir W_Tm_Sp_Sinistre $$HEX2$$e0002000$$ENDHEX$$la fois en consultation  et */
		/* en saisie de gestion.																		 */
		/*-----------------------------------------------------------------------------*/ 
		F_OuvreTraitement ( iw_W_Tm_Sp_Sinistre, stpass )	// ouverture d'une instance de l

		SetPointer ( Arrow! )


	Case dw_2		// .... Consultation dossiers dans la base sinistre

		SetPointer ( HourGlass! )
															  															  
		stPass.lTab[1] 	= dw_2.GetItemNumber ( dw_2.ilLigneClick, "ID_SIN" )

		// [CONSULT_RESTREINTE]
		lRet = SQLCA.PS_S_CONSULT_RESTREINTE ( stGlb.sCodOper, stPass.lTab[1], "" )
		If lRet < 0 Then
			stMessage.sTitre		= "Consultation restreinte"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "GENE174"
			stMessage.bTrace  	= False
	
			F_Message ( stMessage )				
			Return 0
		End If 

		// [CONS_REST_CARDIF]
		If SQLCA.PS_S_CONS_RESTR_EXCL( stPass.lTab[1], stGlb.sCodOper, "P" ) < 0 Then
			stMessage.sTitre		= "Acc$$HEX1$$e800$$ENDHEX$$s interdit"
			stMessage.Icon		   = Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "GENE180"
			F_Message ( stMessage )
			Return 0				
		End If 

		// [PM473-1]
		If Upper(SQLCA.Database) <> "SIMPA2_PRO" &
			And Not F_CLE_A_TRUE ( "PM473-1_SPECIAL_TEST" )	Then
				Choose Case stGlb.sCodOper 
					Case "JFF", "FPI"
						If F_CLE_A_TRUE ( "BASE_SIM_ANONYME" ) Then
							This.wf_AnonymationEnSim ( stPass.lTab[1] )
						End If
					Case Else
						This.wf_AnonymationEnSim ( stPass.lTab[1] )
				End Choose 				
		End If 

		f_OuvreConsultation ( w_cm_sp_sinistre, "", stPass )

		SetPointer ( Arrow! )

End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on close;call w_ac_spb_archive_2000::close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_sp_dossier
//* Evenement 		: CLOSE
//* Auteur			: JFF
//* Date				: 15/05/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

end on

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_sp_dossier
//* Evenement 		: Ue_initialiser - Extend
//* Auteur			: PLJ
//* Date				: 25/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation des datawindows plac$$HEX1$$e900$$ENDHEX$$es sur la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF 	13/04/04 DCMP 040020 SVE				  
//*-----------------------------------------------------------------

String sTables [ ]			// Tables du SELECT

/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil des dossiers en constitution    */
/*------------------------------------------------------------------*/

iTrTrans = SQLCA


dw_1.istCol[1].sDbName		=	"sysadm.produit.lib_court"
dw_1.istCol[1].sResultSet	=	"lib_court"
dw_1.istCol[1].sType			=	"Char(20)"
dw_1.istCol[1].sHeaderName	=	"Produit"
dw_1.istCol[1].ilargeur		=	20
dw_1.istCol[1].sAlignement	=	"0"
dw_1.istCol[1].sInvisible	= 	"N"

dw_1.istCol[2].sDbName		=	"sysadm.w_sin.id_sin"
dw_1.istCol[2].sResultSet	=	"id_sin"
dw_1.istCol[2].sType			=	"number"
dw_1.istCol[2].sHeaderName	=	"Sinistre"
dw_1.istCol[2].ilargeur		=	10   // [PI062]
dw_1.istCol[2].sAlignement	=	"2"
dw_1.istCol[2].sInvisible	= 	"N"

dw_1.istCol[3].sDbName		=	"sysadm.w_sin.nom"
dw_1.istCol[3].sResultSet	=	"nom"
dw_1.istCol[3].sType			=	"char(35)"
dw_1.istCol[3].sHeaderName	=	"Nom"
dw_1.istCol[3].ilargeur		=	15
dw_1.istCol[3].sAlignement	=	"0"
dw_1.istCol[3].sInvisible	= 	"N"

dw_1.istCol[4].sDbName		=	"sysadm.w_sin.prenom"
dw_1.istCol[4].sResultSet	=	"prenom"
dw_1.istCol[4].sType			=	"char(35)"
dw_1.istCol[4].sHeaderName	=	"Pr$$HEX1$$e900$$ENDHEX$$nom"
dw_1.istCol[4].ilargeur		=	15
dw_1.istCol[4].sAlignement	=	"0"
dw_1.istCol[4].sInvisible	= 	"N"

dw_1.istCol[5].sDbName		=	"sysadm.code.lib_code"
dw_1.istCol[5].sResultSet	=	"lib_code"
dw_1.istCol[5].sType			=	"CHAR(35)"
dw_1.istCol[5].sHeaderName	=	"Code Etat"
dw_1.istCol[5].ilargeur		=	25
dw_1.istCol[5].sAlignement	=	"0"
dw_1.istCol[5].sInvisible	= 	"N"

dw_1.istCol[6].sDbName		=	"sysadm.routage.alt_queue"
dw_1.istCol[6].sResultSet	=	"alt_queue"
dw_1.istCol[6].sType			=	"CHAR(1)"
dw_1.istCol[6].sHeaderName	=	"Trv"
dw_1.istCol[6].ilargeur		=	1
dw_1.istCol[6].sAlignement	=	"2"
dw_1.istCol[6].sInvisible	= 	"N"
dw_1.istCol[6].sValues     =  "$$HEX2$$fc000900$$ENDHEX$$O/ 	N/"

sTables [ 1 ] = "w_sin"
sTables [ 2 ] = "produit"
sTables [ 3 ] = "code"
sTables [ 4 ] = "routage"

Dw_1.isJointure = " And sysadm.w_sin.id_prod  = sysadm.produit.id_prod "  +&
                  " And sysadm.code.id_typ_code = '-ET' " +&
                  " And sysadm.w_sin.cod_etat = sysadm.code.id_code" +&
                  " And sysadm.routage.id_sin = sysadm.w_sin.id_sin"


/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut de la Data Window d'accueil.                      */
/*------------------------------------------------------------------*/
Dw_1.isTri = "#3 A"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
Dw_1.Uf_Creer_Tout( dw_1.istCol, sTables, iTrTrans )


/*------------------------------------------------------------------*/
/* Pour la colonne ALT_QUEUE (TRV) de DW_1, on change la police     */
/* afin de faire appara$$HEX1$$ee00$$ENDHEX$$tre un coche, si le un travail existe sur   */
/* le sinistre en cours															  */
/*------------------------------------------------------------------*/
Dw_1.Modify("alt_queue.Font.Face    = 'Wingdings'   &
				 alt_queue.Font.Family  = '0' 			 &
				 alt_queue.Font.Charset = '2' 			 &
 				 alt_queue.Font.Height  = '-12' 			 &
				 alt_queue.color			= '255' 			 ")

/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil des dossiers en constitution    */
/*------------------------------------------------------------------*/

dw_2.istCol[1].sDbName		=	"sysadm.produit.lib_court"
dw_2.istCol[1].sResultSet	=	"lib_court"
dw_2.istCol[1].sType			=	"Char(20)"
dw_2.istCol[1].sHeaderName	=	"Produit"
dw_2.istCol[1].ilargeur		=	20
dw_2.istCol[1].sAlignement	=	"0"
dw_2.istCol[1].sInvisible	= 	"N"

dw_2.istCol[2].sDbName		=	"sysadm.sinistre.id_sin"
dw_2.istCol[2].sResultSet	=	"id_sin"
dw_2.istCol[2].sType			=	"number"
dw_2.istCol[2].sHeaderName	=	"Sinistre"
dw_2.istCol[2].ilargeur		=	10 // [PI062]
dw_2.istCol[2].sAlignement	=	"2"
dw_2.istCol[2].sInvisible	= 	"N"

dw_2.istCol[3].sDbName		=	"sysadm.personne.nom"
dw_2.istCol[3].sResultSet	=	"nom"
dw_2.istCol[3].sType			=	"char(35)"
dw_2.istCol[3].sHeaderName	=	"Nom"
dw_2.istCol[3].ilargeur		=	15
dw_2.istCol[3].sAlignement	=	"0"
dw_2.istCol[3].sInvisible	= 	"N"

dw_2.istCol[4].sDbName		=	"sysadm.personne.prenom"
dw_2.istCol[4].sResultSet	=	"prenom"
dw_2.istCol[4].sType			=	"char(35)"
dw_2.istCol[4].sHeaderName	=	"Pr$$HEX1$$e900$$ENDHEX$$nom"
dw_2.istCol[4].ilargeur		=	15
dw_2.istCol[4].sAlignement	=	"0"
dw_2.istCol[4].sInvisible	= 	"N"

dw_2.istCol[5].sDbName		=	"sysadm.code.lib_code"
dw_2.istCol[5].sResultSet	=	"lib_code"
//Migration PB8-WYNIWYG-03/2006 FM
//dw_2.istCol[5].sType			=	"CHAR(20)"
dw_2.istCol[5].sType			=	"CHAR(35)"
//Fin Migration PB8-WYNIWYG-03/2006 FM
dw_2.istCol[5].sHeaderName	=	"Code Etat"
dw_2.istCol[5].ilargeur		=	25
dw_2.istCol[5].sAlignement	=	"0"
dw_2.istCol[5].sInvisible	= 	"N"


sTables [ 1 ] = "sinistre"
sTables [ 2 ] = "produit"
sTables [ 3 ] = "personne"
sTables [ 4 ] = "code"


/*------------------------------------------------------------------*/
/* Jointure de la Data Window d'accueil.                            */
/*------------------------------------------------------------------*/
Dw_2.isJointure = " And sysadm.sinistre.id_prod  = sysadm.produit.id_prod "  +&
                  " And sysadm.sinistre.id_ordre = sysadm.personne.id_ordre" +& 
                  " And sysadm.code.id_typ_code = '-ET' " +&
						" And sysadm.sinistre.cod_etat = sysadm.code.id_code"


/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut de la Data Window d'accueil.                      */
/*------------------------------------------------------------------*/
Dw_2.isTri = "#3 A"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_2.Uf_Creer_Tout( dw_2.istCol, sTables, iTrTrans )



/*------------------------------------------------------------------*/
/* ... La Description de dw_3, liste pour Archive se situe sur      */
/*     W_Ac_Spb_Archive															  */	
/*------------------------------------------------------------------*/


/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche pour Instruction / Sinistre / Archive       */
/*------------------------------------------------------------------*/

pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Consultation [Recherche]"
pb_Interro.istInterro.sDataObject			= "d_sp_c_int_dossier"
pb_Interro.istInterro.sCodeDw					= "CONSULTATION"


pb_Interro.istInterro.sData[1].sNom					= "nom"
pb_Interro.istInterro.sData[1].sDbNameConsult	= { 	"sysadm.w_sin.nom"   , "sysadm.personne.nom"   , "sysadm.personne.nom", "", "", ""  } 
pb_Interro.istInterro.sData[1].sType				= "STRING"
pb_Interro.istInterro.sData[1].sOperande			= "="

pb_Interro.istInterro.sData[2].sNom					= "prenom"
pb_Interro.istInterro.sData[2].sDbNameConsult	= { 	"sysadm.w_sin.prenom", "sysadm.personne.prenom", "sysadm.personne.prenom", "", "", ""  } 
pb_Interro.istInterro.sData[2].sType				= "STRING"
pb_Interro.istInterro.sData[2].sOperande			= "="

pb_Interro.istInterro.sData[3].sNom					= "id_sin"
pb_Interro.istInterro.sData[3].sDbNameConsult	= { 	"sysadm.w_sin.id_sin", "sysadm.sinistre.id_sin", "sysadm.archive.id_sin", "",  "", ""  } 
pb_Interro.istInterro.sData[3].sType				= "NUMBER"
pb_Interro.istInterro.sData[3].sOperande			= "="
pb_Interro.istInterro.sData[3].sMoteur				= "MSS"		

pb_Interro.istInterro.sData[4].sNom					= "id_prod"
pb_Interro.istInterro.sData[4].sDbNameConsult	= { 	"sysadm.w_sin.id_prod", "sysadm.sinistre.id_prod", "sysadm.archive.id_prod", "","", ""  } 
pb_Interro.istInterro.sData[4].sType				= "STRING"
pb_Interro.istInterro.sData[4].sOperande			= "="
pb_Interro.istInterro.sData[4].sMoteur				= "MSS"		

pb_Interro.istInterro.sData[5].sNom					= "adr_cp"
pb_Interro.istInterro.sData[5].sDbNameConsult	= { 	"sysadm.w_sin.adr_cp", "sysadm.personne.adr_cp", "sysadm.personne.adr_cp", "", "", ""  }
pb_Interro.istInterro.sData[5].sType				= "STRING"
pb_Interro.istInterro.sData[5].sOperande			= "="

pb_Interro.istInterro.sData[6].sNom					= "id_adh"
pb_Interro.istInterro.sData[6].sDbNameConsult	= { 	"sysadm.w_sin.id_adh", "sysadm.sinistre.id_adh", "sysadm.archive.id_adh", "", ""  }
pb_Interro.istInterro.sData[6].sType				= "STRING"
pb_Interro.istInterro.sData[6].sOperande			= "="


/*------------------------------------------------------------------*/
/* Desactive le Reset sur les DW qui ne portent pas sur la          */
/* consultation, ainsi elles gardent leur contenu.                  */
/*------------------------------------------------------------------*/
Wf_Activer_ResetDw ( False )


/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= iTrTrans
istPass.bControl	= TRUE		// Utilisation du bouton CONTROLER


/*-----------------------------------------------------------------*/
/* Passage de l'objet de transaction $$HEX2$$e0002000$$ENDHEX$$dw_produit (invisible)      */
/* Chargement des produits                                         */
/*-----------------------------------------------------------------*/

dw_produit.SetTransObject (iTrTrans)
dw_produit.Retrieve ()


/*-----------------------------------------------------------------*/
/* JFF & DBI le 27/10/1998														 */
/* Armement des variables d'instance, pour :							    */
/* 	- Le repertoire courrier											    */
/* 	- Le fichier d'entete												    */
/* 	- LE fichier mod$$HEX1$$e800$$ENDHEX$$le													    */
/* Ensuite, dans Ue_Word, en fonction du COD_VERSION					 */
/* Les bonnes variables seront initialis$$HEX1$$e900$$ENDHEX$$es.								 */
/*-----------------------------------------------------------------*/

isRepCourrierSimpa1	=	ProfileString ( stGlb.sFichierIni, "EDITION_SIMPA1", "REP_COURRIER", "ERREUR" )
isRepCourrierSimpa2	=	ProfileString ( stGlb.sFichierIni, "EDITION", 		  "REP_COURRIER", "ERREUR" )

isEnteteSimpa1			=	ProfileString ( stGlb.sFichierIni, "EDITION_SIMPA1", "ENTETE", 		"ERREUR" )
isEnteteSimpa1_Anc	=	ProfileString ( stGlb.sFichierIni, "EDITION_SIMPA1", "ENTETE_ANC",	"ERREUR" )
isEnteteSimpa2			=	ProfileString ( stGlb.sFichierIni, "EDITION", 		  "ENTETE", 		"ERREUR" )

// #1
isEnteteSimpa2_Anc1	=	ProfileString ( stGlb.sFichierIni, "EDITION", 		  "ENTETE_ANC1", 	"ERREUR" )
idDateSVE    			=  Date ( ProfileString ( stGlb.sFichierIni, "EDITION", 		  "DTE_PROD_SVE", "01/01/1900" ) )

isModeleSimpa1			=	ProfileString ( stGlb.sFichierIni, "EDITION_SIMPA1", "MODELE", 		"ERREUR" )
isModeleSimpa2			=	ProfileString ( stGlb.sFichierIni, "EDITION", 		  "MODELE", 		"ERREUR" )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_ac_sp_dossier_2000.create
int iCurrent
call super::create
this.dw_produit=create dw_produit
this.pb_saisie=create pb_saisie
this.pb_tel=create pb_tel
this.pb_workflow=create pb_workflow
this.pb_edition=create pb_edition
this.pb_validation=create pb_validation
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_produit
this.Control[iCurrent+2]=this.pb_saisie
this.Control[iCurrent+3]=this.pb_tel
this.Control[iCurrent+4]=this.pb_workflow
this.Control[iCurrent+5]=this.pb_edition
this.Control[iCurrent+6]=this.pb_validation
end on

on w_ac_sp_dossier_2000.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_produit)
destroy(this.pb_saisie)
destroy(this.pb_tel)
destroy(this.pb_workflow)
destroy(this.pb_edition)
destroy(this.pb_validation)
end on

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_sp_dossier
//* Evenement 		: ue_creer
//* Auteur			: JFF
//* Date				: 15/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Codage du click sur le menu contextuel "Consulter le travail"
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass stPass

stPass = istpass

//*-----------------------------------------------------------------
//* Je pr$$HEX1$$e900$$ENDHEX$$vois un Choose Case en cas d'utilisation du menu contextuel
//* sur d'autres Dw de la fen$$HEX1$$ea00$$ENDHEX$$tre				  
//*-----------------------------------------------------------------
Choose Case iuAccueilCourrant

	Case dw_1		// .... Consultation Travail


		SetPointer ( HourGlass! )
															  
		stPass.lTab [ 1 ] = dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_SIN" )

		f_OuvreConsultation ( w_cm_sp_travail, "", stPass )

		SetPointer ( Arrow! )
	
End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_fin_interro;call super::ue_fin_interro;// ----------------------------------------------------------------------------
//
// Objet 		: w_ac_sp_dossier
// Evenement 	: Ue_Fin_Interro   ( Extend )
//	Auteur		: PLJ
//	Date			: 15/07/1998
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Retour de la fen$$HEX1$$ea00$$ENDHEX$$tre d'interrogation. : positionnement du focus
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
//      JFF  11/02/2019 [PM473-1]
//*-----------------------------------------------------------------

String sOnglet
Long lTot, lCpt, lIdSin, lTot1, lTot2, lTot3

SetPointer( arrow! )

sOnglet = uo_onglet.Uf_RecupererOngletCourant()

Choose Case sOnglet

	Case "01"

		dw_1.SetFocus()

	Case "02"

		dw_2.SetFocus()

	Case "03"

		dw_3.SetFocus()

End Choose


// [PM473-1]
If Upper(SQLCA.Database) <> "SIMPA2_PRO" &
	And Not F_CLE_A_TRUE ( "PM473-1_SPECIAL_TEST" ) &
	Then

	lTot1 = Dw_1.RowCount ()
	lTot2 = Dw_2.RowCount ()		
	lTot3 = Dw_3.RowCount ()		

	Choose Case stGlb.sCodOper 
		Case "JFF", "FPI"
			If Not F_CLE_A_TRUE ( "BASE_SIM_ANONYME" ) Then
				lTot1 = 0 
				lTot2 = 0 					
				lTot3 = 0 					
			End If
	End Choose 			
	
	For lCpt = 1 To lTot1
	
		lIdSin = dw_1.GetItemNumber ( lCpt, "ID_SIN" )
	
		If SQLCA.PS_CTLE_DOS_CREE_EN_SIM ( lIdSin ) < 0 Then
			dw_1.SetItem ( lCpt, "NOM", "XXANONYMEXX XXA" )
			dw_1.SetItem ( lCpt, "PRENOM", "XXANONYMEXX XXA" )				
		End If 
	
	Next

	For lCpt = 1 To lTot2
	
		lIdSin = dw_2.GetItemNumber ( lCpt, "ID_SIN" )
	
		If SQLCA.PS_CTLE_DOS_CREE_EN_SIM ( lIdSin ) < 0 Then
			dw_2.SetItem ( lCpt, "NOM", "XXANONYMEXX XXA" )
			dw_2.SetItem ( lCpt, "PRENOM", "XXANONYMEXX XXA" )	
		End If 
	
	Next

	For lCpt = 1 To lTot3
	
		lIdSin = dw_3.GetItemNumber ( lCpt, "ID_SIN" )
	
		If SQLCA.PS_CTLE_DOS_CREE_EN_SIM ( lIdSin ) < 0 Then
			dw_3.SetItem ( lCpt, "NOM", "XXANONYMEXX XXA" )
			dw_3.SetItem ( lCpt, "ASSURE", "XXANONYMEXX XXA" )	
		End If 
	
	Next	
	
	
Else 

	lTot = Dw_1.RowCount ()
	
	For lCpt = 1 To lTot
	
		lIdSin = dw_1.GetItemNumber ( lCpt, "ID_SIN" )
	
		If SQLCA.PS_S_CONS_RESTR_EXCL ( lIdSin, stGlb.sCodOper, "W" ) < 0 Then
			dw_1.SetItem ( lCpt, "NOM", "!INT. PAR ASS.!" )
			dw_1.SetItem ( lCpt, "PRENOM", "!INT. PAR ASS.!" )		
		End If 
	
	Next

	lTot = Dw_2.RowCount ()
	
	For lCpt = 1 To lTot
	
		lIdSin = dw_2.GetItemNumber ( lCpt, "ID_SIN" )
	
		If SQLCA.PS_S_CONS_RESTR_EXCL ( lIdSin, stGlb.sCodOper, "P" ) < 0 Then
			dw_2.SetItem ( lCpt, "NOM", "!INT. PAR ASS.!" )
			dw_2.SetItem ( lCpt, "PRENOM", "!INT. PAR ASS.!" )		
		End If 
	
	Next

	lTot = Dw_3.RowCount ()
	
	For lCpt = 1 To lTot
	
		lIdSin = dw_3.GetItemNumber ( lCpt, "ID_SIN" )
	
		If SQLCA.PS_S_CONS_RESTR_EXCL ( lIdSin, stGlb.sCodOper, "P" ) < 0 Then
			dw_3.SetItem ( lCpt, "NOM", "!INT. PAR ASS.!" )
			dw_3.SetItem ( lCpt, "ASSURE", "!INT. PAR ASS.!" )		
		End If 
	
	Next
End If 

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_preparer_interro;call super::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_sp_dossier
//* Evenement 		: ue_preparer_interro- Extend
//* Auteur			: PLJ
//* Date				: 15/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Charge la datawindow d'interrogation des dossiers 
//*                 Chargement de la DDDW des produits
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild	DwcProduit		// DDDW des produits

w_Interro_consultation.dw_1.GetChild ("ID_PROD", DwcProduit)

dw_produit.ShareData(DwcProduit)

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_item7;call super::ue_item7;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_sp_dossier
//* Evenement 		: ue_Item7
//* Auteur			: JFF
//* Date				: 05/01/2023
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [RS_4166_PND_CORUS]
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

s_Pass stPassData1	
Long lIdSin, lIdInter, lIdDoc, lRow
dwobject dwoNull

If dw_3.RowCount () > 0 Then
	lIdSin = dw_3.GetItemNumber ( 1, "ID_SIN" )
Else 
	Return 0
End If

stPassData1.lTab[1] = lIdSin

OpenWithParm ( w_cpup_sp_detail_lst_courrier, stPassData1 ) 
stPassData1 = Message.PowerObjectParm
If Isvalid ( w_cpup_sp_detail_lst_courrier ) Then Destroy w_cpup_sp_detail_lst_courrier

If stPassData1.sTab[1] = "RETOUR" Then Return 0

lIdSin = stPassData1.lTab[1]
lIdInter = stPassData1.lTab[2]
lIdDoc = stPassData1.lTab[3]

lRow = dw_3.Find ( "ID_SIN = " + String ( lIdSin ) + " AND ID_INTER = " + String ( lIdInter ) + " AND ID_DOC = " + String ( lIdDoc ), 1, dw_3.RowCount ())

If lRow > 0 Then
	dw_3.SelectRow ( 0, False)
	dw_3.SelectRow ( lRow, True)
	dw_3.SetRow ( lRow )	
	dw_3.SCrollToRow ( lRow )		
//	dw_3.Event DoubleClicked (0, 0, lRow, dwoNull ) 

	SetPointer( HourGlass! )
	
	TriggerEvent ( "ue_Modifier" )

End if 

Return 0

end event

event ue_item8;call super::ue_item8;gbLstAffAutoConsultCourrier = Not gbLstAffAutoConsultCourrier 

Return 0


end event

type cb_debug from w_ac_spb_archive_2000`cb_debug within w_ac_sp_dossier_2000
end type

type pb_retour from w_ac_spb_archive_2000`pb_retour within w_ac_sp_dossier_2000
integer taborder = 170
end type

type pb_interro from w_ac_spb_archive_2000`pb_interro within w_ac_sp_dossier_2000
integer taborder = 180
end type

type pb_tri from w_ac_spb_archive_2000`pb_tri within w_ac_sp_dossier_2000
integer taborder = 160
end type

type uo_onglet from w_ac_spb_archive_2000`uo_onglet within w_ac_sp_dossier_2000
integer taborder = 30
end type

event uo_onglet::clicked;call super::clicked;
String sObjet, sOnglet, sCouleur, sText

sObjet = This.GetObjectAtPointer ()

/*------------------------------------------------------------------*/
/* Quel est l'onglet sur lequel on vient de clicker                 */
/* S'il s'agit de l'onglet courant, on ne fait rien                 */
/* De plus, si l'onglet est d$$HEX1$$e900$$ENDHEX$$sactiv$$HEX1$$e900$$ENDHEX$$e ( Couleur Rouge ), on ne     */
/* fait rien                                                        */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* La codification des onglets ( Texte + BitMap ) est la suivante   */
/*		TEXTE			BITMAP                                            */
/* 	ong01_st		ong01_p                                           */
/* 	ong02_st    ong02_p                                           */
/* 	ong03_st    ong03_p                                           */
/* 	ong04_st    ong04_p                                           */
/* 	ong05_st    ong05_p                                           */
/* 	ong06_st    ong06_p                                           */
/*------------------------------------------------------------------*/

If	Mid ( sObjet, 1, 3 ) = "ong" Then
	sOnglet = Mid ( sObjet, 4, 2 )
	If Integer ( sOnglet ) = 3 And gbLstAffAutoConsultCourrier Then 
		Parent.Event ue_Item7 (0,0)
	End If 

End If



	
end event

type dw_1 from w_ac_spb_archive_2000`dw_1 within w_ac_sp_dossier_2000
integer taborder = 100
end type

event dw_1::ue_modifiermenu;call super::ue_modifiermenu;//*****************************************************************************
//
// Objet 		: W_AC_SP_DOSSIER::dw_1 (EXTEND)
// Evenement 	: ue_ModifierMenu
//	Auteur		: JFF
//	Date			: 15/12/1998
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Extend sur le menu contextuel, afin de pouvoir consulter le travail.
// Commentaires: Le click sur "CONSULTER LE TRAVAIL" est cod$$HEX2$$e9002000$$ENDHEX$$sur 'ue_creer' de la fen$$HEX1$$ea00$$ENDHEX$$tre parent
//
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Long t

t=ilLigneClick

//----------------------------------------------------------------------------
// Je modifie le "Consulter" d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$pr$$HEX1$$e900$$ENDHEX$$sent afin que l'utilisateur s'y retrouve
//----------------------------------------------------------------------------
uf_Mnu_ChangerText ( 2, "Consulter le sinistre" )


//----------------------------------------------------------------------------
// S'il y a un travail sur la ligne click$$HEX1$$e900$$ENDHEX$$e, on ajoute la ligne sur le menu
// contextuel.
//----------------------------------------------------------------------------
If ( ilLigneClick > 0 ) Then
	If GetItemString (ilLigneClick, "ALT_QUEUE") = "O" Then
		uf_Mnu_AjouterItem ( 1, "Consulter le travail")
	End If
End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type dw_2 from w_ac_spb_archive_2000`dw_2 within w_ac_sp_dossier_2000
integer taborder = 90
end type

event dw_2::ue_modifiermenu;call super::ue_modifiermenu;
//----------------------------------------------------------------------------
// Je modifie le "Consulter" d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$pr$$HEX1$$e900$$ENDHEX$$sent afin que l'utilisateur s'y retrouve
//----------------------------------------------------------------------------
uf_Mnu_ChangerText ( 2, "Consulter le sinistre" )

end event

type dw_3 from w_ac_spb_archive_2000`dw_3 within w_ac_sp_dossier_2000
integer taborder = 80
end type

event dw_3::ue_modifiermenu;call super::ue_modifiermenu;//----------------------------------------------------------------------------
// Je modifie le "Consulter" d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$pr$$HEX1$$e900$$ENDHEX$$sent afin que l'utilisateur s'y retrouve
//----------------------------------------------------------------------------
uf_Mnu_ChangerText ( 2, "Consulter le courrier s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$" )
uf_Mnu_AjouterItem ( 7, "Voir la liste d$$HEX1$$e900$$ENDHEX$$taill$$HEX1$$e900$$ENDHEX$$e des courriers")

If Not gbLstAffAutoConsultCourrier Then 
	uf_Mnu_AjouterItem ( 8, "Activer affichage liste automatique (actuellement d$$HEX1$$e900$$ENDHEX$$sactiv$$HEX1$$e900$$ENDHEX$$)")
Else 
	uf_Mnu_AjouterItem ( 8, "D$$HEX1$$e900$$ENDHEX$$sactiver affichage liste automatique (actuellement activ$$HEX1$$e900$$ENDHEX$$)")
End If 

If dw_3.RowCount () > 0 Then
	uf_Mnu_AutoriserItem ( 7 )
Else
	uf_Mnu_InterdirItem ( 7 )	
End If 



end event

type dw_4 from w_ac_spb_archive_2000`dw_4 within w_ac_sp_dossier_2000
integer taborder = 70
end type

type dw_5 from w_ac_spb_archive_2000`dw_5 within w_ac_sp_dossier_2000
integer taborder = 60
end type

type dw_6 from w_ac_spb_archive_2000`dw_6 within w_ac_sp_dossier_2000
integer taborder = 50
end type

type uo_1 from w_ac_spb_archive_2000`uo_1 within w_ac_sp_dossier_2000
integer x = 1856
integer y = 36
integer taborder = 150
end type

type pb_imprimer from w_ac_spb_archive_2000`pb_imprimer within w_ac_sp_dossier_2000
integer x = 901
end type

type dw_produit from datawindow within w_ac_sp_dossier_2000
boolean visible = false
integer x = 1874
integer y = 32
integer width = 507
integer height = 160
integer taborder = 40
boolean bringtotop = true
string dataobject = "dddw_sp_produit"
boolean livescroll = true
end type

type pb_saisie from picturebutton within w_ac_sp_dossier_2000
integer x = 1385
integer y = 16
integer width = 242
integer height = 144
integer taborder = 20
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Saisie Sin"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_saisie.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: pb_Saisie
//* Evenement 		: Clicked
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
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

isBoutonRac = "SAISIESIN"
Parent.TriggerEvent ( "ue_Item6" )
end on

type pb_tel from picturebutton within w_ac_sp_dossier_2000
integer x = 901
integer y = 16
integer width = 242
integer height = 144
integer taborder = 140
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "D$$HEX1$$e900$$ENDHEX$$cl.T$$HEX1$$e900$$ENDHEX$$l."
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_tel.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: pb_Tel
//* Evenement 		: Clicked
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
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

isBoutonRac = "TEL"
Parent.TriggerEvent ( "ue_Item6" )
end on

type pb_workflow from picturebutton within w_ac_sp_dossier_2000
integer x = 1143
integer y = 16
integer width = 242
integer height = 144
integer taborder = 130
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Courrier"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_trv.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: pb_Tel
//* Evenement 		: Clicked
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
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

isBoutonRac = "COURRIER"
Parent.TriggerEvent ( "ue_Item6" )

end on

type pb_edition from picturebutton within w_ac_sp_dossier_2000
integer x = 1627
integer y = 16
integer width = 242
integer height = 144
integer taborder = 110
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Edt. Sin."
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_edtsin.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: pb_edition
//* Evenement 		: Clicked
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
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

isBoutonRac = "EDTSIN"
Parent.TriggerEvent ( "ue_Item6" )

end on

type pb_validation from picturebutton within w_ac_sp_dossier_2000
integer x = 1870
integer y = 16
integer width = 242
integer height = 144
integer taborder = 120
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Val. Sin"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_valsin.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: pb_Tel
//* Evenement 		: Clicked
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
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

isBoutonRac = "VALSIN"
Parent.TriggerEvent ( "ue_Item6" )

end on

