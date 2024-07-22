HA$PBExportHeader$w_a_sp_rel_sold_2000.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre des Relances et du Soldage.
forward
global type w_a_sp_rel_sold_2000 from w_accueil_edition_2000
end type
type uo_defil from u_barredefil within w_a_sp_rel_sold_2000
end type
type dw_taillelot from u_datawindow within w_a_sp_rel_sold_2000
end type
type dw_saisiesin from u_datawindow within w_a_sp_rel_sold_2000
end type
type dw_produit from u_datawindow within w_a_sp_rel_sold_2000
end type
type dw_para_prod from datawindow within w_a_sp_rel_sold_2000
end type
type dw_police from datawindow within w_a_sp_rel_sold_2000
end type
type uo_libelle from u_libelle_dga within w_a_sp_rel_sold_2000
end type
type dw_civilite from datawindow within w_a_sp_rel_sold_2000
end type
type pb_lancer from picturebutton within w_a_sp_rel_sold_2000
end type
type dw_boitearchive from datawindow within w_a_sp_rel_sold_2000
end type
type dw_detpro from datawindow within w_a_sp_rel_sold_2000
end type
type dw_page_blanche from datawindow within w_a_sp_rel_sold_2000
end type
type pb_pageblanche from picturebutton within w_a_sp_rel_sold_2000
end type
type dw_gencourrier from datawindow within w_a_sp_rel_sold_2000
end type
type dw_autorisation from datawindow within w_a_sp_rel_sold_2000
end type
end forward

global type w_a_sp_rel_sold_2000 from w_accueil_edition_2000
integer width = 3662
integer height = 1928
event spb_imprimerdossier_pi052 pbm_custom02
event ue_fermerword ( )
uo_defil uo_defil
dw_taillelot dw_taillelot
dw_saisiesin dw_saisiesin
dw_produit dw_produit
dw_para_prod dw_para_prod
dw_police dw_police
uo_libelle uo_libelle
dw_civilite dw_civilite
pb_lancer pb_lancer
dw_boitearchive dw_boitearchive
dw_detpro dw_detpro
dw_page_blanche dw_page_blanche
pb_pageblanche pb_pageblanche
dw_gencourrier dw_gencourrier
dw_autorisation dw_autorisation
end type
global w_a_sp_rel_sold_2000 w_a_sp_rel_sold_2000

type variables
Private :
/*------------------------------------------------------------------*/
/* [PM_107_REL]. Modification Mise sous pli                         */
/* D$$HEX1$$e900$$ENDHEX$$claration de deux constantes pour l'$$HEX1$$e900$$ENDHEX$$ditique.                  */
/* D$$HEX1$$e900$$ENDHEX$$claration du compteur de contr$$HEX1$$f400$$ENDHEX$$le pour la mise sous pli.       */
/*------------------------------------------------------------------*/
CONSTANT	String	K_EDT_PROGRAMME 	= "042"
CONSTANT	String	K_EDT_APPLICATIF	= "1"
Long					ilMsp_Compteur
String				isCodeBarreDept[]

Protected :

	u_Gs_Sp_Rel_Anc	iuo_Rel

	Boolean		ibInit = False	// A true, la fen$$HEX1$$ea00$$ENDHEX$$tre $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$j$$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$initialis$$HEX1$$e900$$ENDHEX$$e.

	String		isNbrCourrier
	String		isTypTrtWord   // C ou E
	String		isFicCourrierIni // Fichier INI pour Edition
	String		isTypTrt	// Type de Traitement
	String		isFicEntete, isFicEnteteAnc, isFicEnteteNouv, isRepCourrier

	Date		idDteProdSve

	Long		ilNumCourrier
	Long		ilDossier

	Long		ilSin = 0	// ... pour rupture sur Id_Sin

	Int		iiTailleLot  // Taille du lot d'$$HEX1$$e900$$ENDHEX$$dition
	Int		iiNumLot  // Num$$HEX1$$e900$$ENDHEX$$ro du lot en cours

	Boolean	ib2EmeTourPI052 = False // [PI052]	
	Boolean	ibErreurArret = False // [PI052]	
end variables

forward prototypes
public subroutine wf_initialiser (string atyptrt)
public subroutine wf_retaillerobjet ()
protected function boolean wf_lire_blob (long adcidsin, long adcidinter, long adciddoc, string astype, ref blob asblob)
public subroutine wf_actualiseredition (long alNumCourrier)
public subroutine wf_positionnerobjet_relance ()
protected function long wf_editer_relance ()
private subroutine wf_modifierentete (date aDteEditDocOrig)
private subroutine wf_renommerfichieriniedition (string ascas)
protected function integer wf_lireecrire_blob (long adcidsin, long adcidinter, long adciddoc, string astype, ref string asnomfic)
private function boolean wf_departementaveccodebarre (long aliddept)
public function integer wf_getiddocedt (ref string sliddocedt)
end prototypes

event spb_imprimerdossier_pi052;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Rel_Sold
//* Evenement 		: SPB_ImprimerDossier_PI052
//* Auteur			: Fabry JF
//* Date				: 17/06/1999
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: imprime le courrier de relance et le courrier original.
//* Commentaires	: [PI052]
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JFF   16/04/2010	DCMP 040020 SVE : Selon la methode, on change l'entete
//* 		PHG	26/11/2010	[PM_107_REL] : Gestion des mises sous plis et $$HEX1$$e900$$ENDHEX$$liminantion
//*								du mode SEV
//*-----------------------------------------------------------------

String	sIdCourTyp		// Identifiant du courrier compos$$HEX1$$e900$$ENDHEX$$.
String	sAltPart			// Indique s'il s'agit d'un courrier divers ou particulier.
//String	sAltPce			// Indique s'il y a une autre piece. // [PM_107_REL] plus utilis$$HEX2$$e9002000$$ENDHEX$$?
//String	sAltPs			// Indique s'il y a un post scriptum. // [PM_107_REL] plus utilis$$HEX2$$e9002000$$ENDHEX$$?
String	sNomFic			
Long	   lIdSin			// Identifiant du sinistre
Long	   lIdInter  		// Identifiant interlocuteur
Long		lIdDoc			// Identifiant du courrier pour l'interlocuteur
String	sNom				// Nom du destinataire du courrier.
String	sTypCour			// Type du courrier $$HEX2$$e0002000$$ENDHEX$$imprimer.
//String	sTxtCompo		// Premi$$HEX1$$e800$$ENDHEX$$re de la composition. // [PM_107_REL] plus utilis$$HEX2$$e9002000$$ENDHEX$$?
String	sBac				// Bac $$HEX2$$e0002000$$ENDHEX$$partir duquel on souhaite imprimer le courrier
String	sDateEdit		// Date d'edition du courrier original
String	sRepWinTemp, sFicSauve
String	sMacro
Date		dDteEditCourOrig
long		lProdIdDept		// [PM_107_REL] : Code d$$HEX1$$e900$$ENDHEX$$partement du courrier a relancer
long 		lIdDocIdt		// [PM_107_REL] : N$$HEX2$$b0002000$$ENDHEX$$Editique.
String	sIdDocEdt		// [PM_107_REL] : Transcription en chaine du N$$HEX2$$b0002000$$ENDHEX$$editique.
String	sIdCompteurPage// [PM_107_REL] : Transcription en chaine du compteur de page.
integer	iNbPage			// [PM_107_REL] : Nb de page du document imprim$$HEX1$$e900$$ENDHEX$$
String 	sSQL  // [PM251-2]

Boolean	bOk = True
Boolean	bContinuer = True 
Boolean	bCodeBarre			// [PM_107_REL] : Indique si le code de Mise sous plis doit $$HEX1$$ea00$$ENDHEX$$tre position pour le courrier en cours d'edition

//Blob		bTxtblob				// Blob contenant le texte des variables. // [PM_107_REL] plus utilis$$HEX2$$e9002000$$ENDHEX$$?

Long		lDocOriginal		// N$$HEX2$$b0002000$$ENDHEX$$de poign$$HEX1$$e900$$ENDHEX$$e pour doc Original, c'est $$HEX2$$e0002000$$ENDHEX$$dire le courrier original
//Long		lDocRelance			// N$$HEX2$$b0002000$$ENDHEX$$de poign$$HEX1$$e900$$ENDHEX$$e pour doc de relance. // [PM_107_REL] plus utilis$$HEX2$$e9002000$$ENDHEX$$?
Long		lIdLigne				// Ligne en cours de traitement
int		iRet

/*------------------------------------------------------------------*/
/* Variable du courrier de relance.                                 */
/*------------------------------------------------------------------*/
String		sIdCourRel		// Identifiant du courrier de relance.
String		sTxtCompRel		// Composition du courrier de relance.
Blob			blBlobDataRel  // Blob data des relances

String sTypFormat 

/*------------------------------------------------------------------*/
/* Construction du courrier de relance, et $$HEX1$$e900$$ENDHEX$$criture en base.        */
/*------------------------------------------------------------------*/
lIdLigne		= Message.WordParm

//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//sRepWinTemp = stGLB.sWinDir + "\TEMP\"
sRepWinTemp = stGLB.sRepTempo

/*------------------------------------------------------------------*/
/* Si on est en SVE, on casse le fichier dans lequel on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$rera  */
/* le courrier de REL fusionn$$HEX1$$e900$$ENDHEX$$.                                     */
/*------------------------------------------------------------------*/
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//FileDelete ( stGlb.sWinDir + "\TEMP\SIM2_REL.DOC" )

FileDelete ( stGlb.sRepTempo + "SIM2_REL.DOC" )
	
// [PI052] This.Wf_RenommerFichierIniEdition ( "SUPPRIMER" )
bOk = iuo_rel.uf_CreerCourrierRelance ( lIdLigne, sIdCourRel, sTxtCompRel, blBlobDataRel, ib2EmeTourPI052 )
// [PI052] This.Wf_RenommerFichierIniEdition ( "RESTAURER" )

// On s'arrete ll$$HEX2$$e0002000$$ENDHEX$$pour le 1er tout
// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	If iuo_rel.ibPI052_GenEdtKsl And Not ib2EmeTourPI052 Then
		Return
	End If
End If
*/

sAltPart	= Dw_1.GetITemString ( lIdLigne, "ALT_PART"  )
sNom		= Dw_1.GetItemString ( lIdLigne, "NOM_INTER" )
lIdSin 	= Dw_1.GetitemNumber ( lIdLigne, "ID_SIN" )
lIdInter	= Dw_1.GetItemNumber ( lIdLigne, "ID_I" )
lIdDoc	= Dw_1.GetItemNumber ( lIdLigne, "ID_DOC" )
dDteEditCourOrig = Dw_1.GetItemDate ( lIdLigne, "DTE_EDIT" )

// [PM_107_REL]
lProdIdDept = Dw_1.GetItemNumber ( lIdLigne, "PROD_ID_DEPT" )
bCodeBarre	= Wf_DepartementAvecCodeBarre ( lProdIdDept )

/*------------------------------------------------------------------*/
/*             C O U R R I E R   D E   R E L A N C E.               */
/*------------------------------------------------------------------*/
/* C O U R R I E R   D E   R E L A N C E   M E T H O D E	   S V E	  */
/* Edition du courrier de relance $$HEX2$$e0002000$$ENDHEX$$la nouvelle m$$HEX1$$e900$$ENDHEX$$thode (SVE)       */
/*------------------------------------------------------------------*/

iRet = 1

/*------------------------------------------------------------------*/
/* On affiche un message dans la MLE pour donner des informations   */
/* sur le dossier en cours de traitement.                           */
/*------------------------------------------------------------------*/
Wf_ActualiserEdition ( ilNumCourrier )
ilNumCourrier ++
// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	If iuo_rel.ibPI052_GenEdtKsl Then
		Mle_Msg.Uf_AjouterText ( "Dossier : " + String ( lIdSin ) + " G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration par KSL du courrier " + sIdCourRel + " adress$$HEX4$$e9002000e0002000$$ENDHEX$$" + sNom + "~r~n" )
	Else
		Mle_Msg.Uf_AjouterText ( "Dossier : " + String ( lIdSin ) + " Impression du courrier " + sIdCourRel + " adress$$HEX4$$e9002000e0002000$$ENDHEX$$" + sNom + "~r~n" )		
	End If
Else
*/	
	Mle_Msg.Uf_AjouterText ( "Dossier : " + String ( lIdSin ) + " Impression du courrier " + sIdCourRel + " adress$$HEX4$$e9002000e0002000$$ENDHEX$$" + sNom + "~r~n" )
//End If 

/*------------------------------------------------------------------*/
/* On s'occupe des param$$HEX1$$e800$$ENDHEX$$tres particuliers du courrier. Faut-il     */
/* $$HEX1$$e900$$ENDHEX$$diter le courrier ?. Faut-il sauvegarder le courrier et sous    */
/* quel nom ?. Faut-il mettre les marques de mise sous pli ?.       */
/*------------------------------------------------------------------*/
sFicSauve = sRepWinTemp + String ( lIdSin ) + "_" + String ( lIdInter )
// invEditionCourrier.uf_InscrireParamCourrier ( sFicSauve, "0", "O", "O" )

/*------------------------------------------------------------------*/
/* [PM_107_REL] Modification Mise sous pli.                         */
/* #1. Modif DGA                                                    */
/* Je positionne la valeur du param$$HEX1$$e800$$ENDHEX$$tre MISE SOUS PLI avec          */
/* NouvelleMethode.                                                 */
/*------------------------------------------------------------------*/
/* [PI052] 
if bCodeBarre Then
	iRet = wf_getiddocedt(sIdDocEdt)
End If
*/

/* [PI052] 
If	IsNull ( sIdDocEdt ) Or Len ( Trim  ( sIdDocEdt ) ) = 0 Or bCodeBarre = False Then
	invEditionCourrier.uf_InscrireParamCourrier ( sFicSauve, "0", "O", "N" )  // ... #1 pas de mise sous pli
Else
	invEditionCourrier.uf_InscrireParamCourrier ( sFicSauve, "0", "O", "NouvelleMethode" )
	sIdCompteurPage	= String ( ilMsp_Compteur )
	invEditionCourrier.uf_InscrireParamMiseSousPli ( sIdDocEdt, sIdCompteurPage )
End If
*/
// ...[PM_107_REL]

/*------------------------------------------------------------------*/
/* Ouverture du document se trouvant maintenant sur disque.         */
/*------------------------------------------------------------------*/
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//lDocOriginal 	= invEditionCourrier.uf_OuvrirDocument_2 ( stGlb.sWinDir + "\TEMP\SIM2_REL.DOC" )
// [PI052] lDocOriginal 	= invEditionCourrier.uf_OuvrirDocument_2 ( stGlb.sRepTempo +"SIM2_REL.DOC" )

/*
If iRet < 0 Then 
	wf_SetStopTraitement ( TRUE )
End If
*/

bOk = iRet > 0


/*------------------------------------------------------------------*/
/*  			   I M P R E S S I O N	  R E L A N C E		  			  */
/*------------------------------------------------------------------*/
If bOk Then
	/*  [PI052]
	sMacro = "EditerCourrierNouvMethode"

	If invEditionCourrier.uf_Imprimer ( sMacro ) < 0	Then
		wf_SetStopTraitement ( TRUE )
	Else
	
		invEditionCourrier.Uf_FermerDocument_2 ( )
		/*------------------------------------------------------------------*/
		//[PM_107_REL] R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du compteru de page.
		/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nombre de pages du courrier que l'on vient de     */
		/* mettre sous pli.                                                 */
		/*------------------------------------------------------------------*/
		If	bCodeBarre	Then
			iNbPage			= invEditionCourrier.uf_RecupererParamMiseSousPli ()
		Else
			iNbPage = 0
		End If
		
		If	iNbPage > 0	Then
			ilMsp_Compteur = ilMsp_Compteur + iNbPage
			ilMsp_Compteur = Mod(ilMsp_Compteur, 10)
		End If
	End If	

	/*------------------------------------------------------------------*/
	/* Suppression du fichier toujours pr$$HEX1$$e900$$ENDHEX$$sent sur disque si SVE.       */
	/*------------------------------------------------------------------*/
	//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
	//FileDelete ( stGlb.sWinDir + "\TEMP\SIM2_REL.DOC" ) 
*/
	

	FileDelete ( stGlb.sRepTempo + "SIM2_REL.DOC" ) 
End If

/*------------------------------------------------------------------*/
/*               C O U R R I E R   O R I G I N A L                  */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/*  on ne r$$HEX2$$e900e900$$ENDHEX$$dite pas l'original :                                  */
/*  - Si le courrier original est un questionnaire                  */
/*  - Si le traitement est "R2" (Deuxi$$HEX1$$e800$$ENDHEX$$me relances).                */
/*------------------------------------------------------------------*/

sIdCourTyp 	= Dw_1.GetitemString ( lIdLigne, "ID_COUR" )

bContinuer = ( Left ( sIdCourTyp, 1 ) <> "Q" ) And	( isTypTrt <> "R2" ) 

/*------------------------------------------------------------------*/
/* O R I G I N A L  M E T H O D E	S V E					 				  */
/* Edition du courrier original $$HEX2$$e0002000$$ENDHEX$$la nouvelle m$$HEX1$$e900$$ENDHEX$$thode (SVE)         */
/*------------------------------------------------------------------*/
If bContinuer And bOk Then

	iRet			= 1

	/*------------------------------------------------------------------*/
	/* On affiche un message dans la MLE pour donner des informations   */
	/* sur le dossier en cours de traitement.                           */
	/*------------------------------------------------------------------*/
	// [PI052]
	/*
	If F_CLE_A_TRUE ( "PI052" ) Then
		If iuo_rel.ibPI052_GenEdtKsl Then
			Mle_Msg.Uf_AjouterText ( "Dossier : " + String ( lIdSin ) + " G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration par KSL du courrier " + sTypCour + " adress$$HEX4$$e9002000e0002000$$ENDHEX$$" + sNom + "~r~n" )			
		Else
			Mle_Msg.Uf_AjouterText ( "Dossier : " + String ( lIdSin ) + " Impression du courrier " + sTypCour + " adress$$HEX4$$e9002000e0002000$$ENDHEX$$" + sNom + "~r~n" )
		End If
	Else */
		Mle_Msg.Uf_AjouterText ( "Dossier : " + String ( lIdSin ) + " Impression du courrier " + sTypCour + " adress$$HEX4$$e9002000e0002000$$ENDHEX$$" + sNom + "~r~n" )
//	End If 

// Ici $$HEX1$$e900$$ENDHEX$$crire ligne dans table edt KSL

	// [PI052] Ecrire ici l'enreg sur table $$HEX1$$e900$$ENDHEX$$dition
	sTypFormat = Space ( 10 )
	SQLCA.PS_S_TYPE_DOC_PI052 ( lIdSin, lIdInter, lIdDoc, sTypFormat ) 
	
	sSQL  = "Exec sysadm.PS_I_WCBA_KSL_COUR_RELANCE "
	sSQL += String ( lIdSin ) + "., "
	sSQL += String ( lIdInter ) + "., "
	sSQL += String ( lIdDoc ) + "., "
	sSQL += "'" + sTypFormat + "',"
	sSQL += "null,"
	sSQL += "'RELANCE_ORIG', "	
	sSQL += String ( iuo_Rel.ilIdRelKSL )
	
	F_Execute ( sSql, SQLCA )
	F_Commit ( SQLCA, SqlCa.Sqldbcode = 0 And Sqlca.SQLCode = 0 )


/* [PI052]

	/*------------------------------------------------------------------*/
	/* Lecture du Blob et $$HEX1$$e900$$ENDHEX$$criture du fichier.                          */
	/*------------------------------------------------------------------*/
	iRet = wf_LireEcrire_Blob ( lIdSin, lIdInter, lIdDoc, "DO", sNomFic )

	If iRet < 0 Then 
		wf_SetStopTraitement ( TRUE )
	End If

	/*------------------------------------------------------------------*/
	/* [PM_107_REL]                                                     */
	/* On s'occupe des param$$HEX1$$e800$$ENDHEX$$tres particuliers du courrier. Faut-il     */
	/* $$HEX1$$e900$$ENDHEX$$diter le courrier ?. Faut-il sauvegarder le courrier et sous    */
	/* quel nom ?. Faut-il mettre les marques de mise sous pli ?.       */
	/*------------------------------------------------------------------*/
	If	IsNull ( sIdDocEdt ) Or Len ( Trim  ( sIdDocEdt ) ) = 0 Or bCodeBarre = False Then
		invEditionCourrier.uf_InscrireParamCourrier ( sFicSauve, "0", "O", "N" )  // ... #1 pas de mise sous pli
	Else
		invEditionCourrier.uf_InscrireParamCourrier ( sFicSauve, "0", "O", "NouvelleMethode" )
		sIdCompteurPage	= String ( ilMsp_Compteur )
		invEditionCourrier.uf_InscrireParamMiseSousPli ( sIdDocEdt, sIdCompteurPage )
	End If
	//invEditionCourrier.uf_InscrireParamCourrier ( sFicSauve, "0", "O", "O" )

	/*------------------------------------------------------------------*/
	/* Ouverture du document se trouvant maintenant sur disque.         */
	/*------------------------------------------------------------------*/
	lDocOriginal 	= invEditionCourrier.uf_OuvrirDocument_2 ( sNomFic )

	/*------------------------------------------------------------------*/
	/* Gestion du bac pour les $$HEX1$$e900$$ENDHEX$$ditions                                 */
	/*------------------------------------------------------------------*/
	Choose Case Left ( sIdCourTyp, 1 )
	Case 'Q' // Questionnaire
		sBac = "MILIEU"
	Case 'B' // Courrier Banque
		sBac = "HAUT"
	Case Else	// Courrier Assur$$HEX2$$e9002000$$ENDHEX$$+ autres
		sBac = "BAS"
	End Choose	

//	invEditionCourrier.uf_InscrireBac ( lDocOriginal, sBac, 1 )
	invEditionCourrier.uf_InscrireBac ( lDocOriginal, sBac ) // [SUPPORT_MFP]

	/*------------------------------------------------------------------*/
	/* On $$HEX1$$e900$$ENDHEX$$crit dans le fichier Ini la Dte_Edit du courrier original.   */
	/*------------------------------------------------------------------*/
	sDateEdit = String ( Dw_1.GetItemDate ( lIdLigne, "DTE_EDIT" ), "dd/mm/yyyy" )
	sDateEdit = Left ( sDateEdit, 2 ) + " " + Lower ( F_Mois_En_Lettre ( Integer ( Mid ( sDateEdit, 4, 2 ) ) ) ) + " " + Right ( sDateEdit, 4 )

	invEditionCourrier.Uf_Inscrire_DteEdition_Document_2 ( sDateEdit )

	If iRet < 0 Then 
		wf_SetStopTraitement ( TRUE )
	End If

	bOk = iRet > 0
*/
End If

/*------------------------------------------------------------------*/
/*  			             I M P R E S S I O N								  */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On imprime le courrier, c'est  $$HEX2$$e0002000$$ENDHEX$$dire l'original et la relance.  */
/*------------------------------------------------------------------*/
If bContinuer And bOk Then

	/* [PI052]
	sMacro = "EditerCourrierNouvMethode"

	If invEditionCourrier.uf_Imprimer ( sMacro ) < 0	Then
		wf_SetStopTraitement ( TRUE )
	Else
		invEditionCourrier.Uf_FermerDocument_2 ( )
		/*------------------------------------------------------------------*/
		//[PM_107_REL] R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du compteru de page.
		/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nombre de pages du courrier que l'on vient de     */
		/* mettre sous pli.                                                 */
		/*------------------------------------------------------------------*/
		If	bCodeBarre	Then
			iNbPage			= invEditionCourrier.uf_RecupererParamMiseSousPli ()
		Else
			iNbPage = 0
		End If
		
		If	iNbPage > 0	Then
			ilMsp_Compteur = ilMsp_Compteur + iNbPage
			ilMsp_Compteur = Mod(ilMsp_Compteur, 10)
		End If
	End If
	*/
	
	// [PI052] Ecrire ici l'enreg sur table $$HEX1$$e900$$ENDHEX$$dition	
	
End If

/*------------------------------------------------------------------*/
/* Suppression du fichier toujours pr$$HEX1$$e900$$ENDHEX$$sent sur disque.              */
/*------------------------------------------------------------------*/
FileDelete ( sNomFic ) 

ib2EmeTourPI052 = False
end event

event ue_fermerword();//*-----------------------------------------------------------------
//*
//* Objet			: Dw_1
//* Evenement 		: ue_FermerWord
//* Auteur			: FABRY JF
//* Date				: 21/11/2023
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ferme Word
//* Commentaires	: 
//*				 
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	      Modification
//* 
//*-----------------------------------------------------------------

Long lCpt, lDelai, lDelai2

lDelai = Long ( ProfileString ( stGlb.sFichierIni, "DELAI FERMETURE WORD", "DELAI_FERM_WORD", "5000" ) )

For lCpt = 1 To lDelai
	Yield ()
Next 

RUN ( "taskkill /F  /IM WINWORD.EXE /T", minimized! )

lDelai2 = lDelai / 2

For lCpt = 1 To lDelai2
	Yield ()
Next 

RUN ( "Del " + stGLB.sRepTempo + "*.doc /Q /F", minimized! )	


end event

public subroutine wf_initialiser (string atyptrt);//*-----------------------------------------------------------------
//*
//* Fonction		: wf_Initialiser (Public)
//* Auteur			: Fabry JF
//* Date				: 23/06/1999 12:25:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre.
//* Commentaires	: Cette initialisation vient en compl$$HEX1$$e800$$ENDHEX$$ment du ue_Initialiser
//*					  et est d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$apr$$HEX1$$e800$$ENDHEX$$s l'ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre sur le menu
//*					  apr$$HEX1$$e800$$ENDHEX$$s le F_OuvreAccueil.
//*
//* Arguments		: String			asTypTrt			(Val) 		Type de traitement
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On initialise une seule fois la fen$$HEX1$$ea00$$ENDHEX$$tre (ibInit).                */
/*------------------------------------------------------------------*/
If Not ibInit Then

	ibInit = True

	isTypTrt = aTypTrt

	This.wf_RetaillerObjet ()

	CHOOSE CASE isTypTrt

		CASE "R1A"
			This.Title = "Premi$$HEX1$$e800$$ENDHEX$$res Relances Automatiques."

		CASE "R1U"
			This.Title = "Premi$$HEX1$$e800$$ENDHEX$$res Relances Automatiques pour les garanties UF avec Dem. Pces. $$HEX2$$e0002000$$ENDHEX$$la banque."

		CASE "R1T"
			This.Title = "Premi$$HEX1$$e800$$ENDHEX$$res Relances Particuli$$HEX1$$e800$$ENDHEX$$res."

		CASE "R1P"
			This.Title = "Premi$$HEX1$$e800$$ENDHEX$$res Relances Ponctuelles."

		CASE "R2"
			This.Title = "Deuxi$$HEX1$$e800$$ENDHEX$$mes Relances."

		CASE "DR1"
			This.Title = "Annulation d'une Premi$$HEX1$$e800$$ENDHEX$$re Relance."

		CASE "SOL"
			This.Title = "Soldage des Dossiers."

	END CHOOSE

	iuo_Rel.uf_Initialiser_Anc ( 	Dw_Produit			,&
											Dw_TailleLot		,&
											Dw_SaisieSin		,&
											Dw_1					,&
											Dw_Para_Prod		,&
											Dw_Police			,&
											Dw_Civilite			,&
											isTypTrt				,&
											uo_Libelle			,&
											iTrTrans				,&
											uo_Defil 			,&
											dw_BoiteArchive	,&
											dw_DetPro			,&
											dw_gencourrier		,&
											dw_autorisation    &
										)

End If



end subroutine

public subroutine wf_retaillerobjet ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_RetaillerObjet (Public)
//* Auteur			: Fabry JF
//* Date				: 25/06/1999 15:16:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Retaille les objets pour certains cas de traitement.
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* On retaille les objets.                                          */
/*------------------------------------------------------------------*/
CHOOSE CASE isTypTrt

	CASE "DR1", "R1T"

		Dw_1.x					= 33
		Dw_1.y					= 340
		Dw_1.Width				= 3530
		Dw_1.Height				= 1388

		Dw_SaisieSin.x			= 33
		Dw_SaisieSin.y			= 230
		Dw_SaisieSin.Width	= 782
		Dw_SaisieSin.Height	= 105

		st_1.Hide()
		st_Nombre.Hide()
		st_2.Hide()
		st_Edit.Hide()
		mle_Msg.Hide()
		uo_defil.Hide()


	CASE "SOL"

		Dw_1.x					= 33
		Dw_1.y					= 340
		Dw_1.Width				= 3530
		Dw_1.Height				= 1388

		Dw_SaisieSin.x			= 33
		Dw_SaisieSin.y			= 230
		Dw_SaisieSin.Width	= 782
		Dw_SaisieSin.Height	= 105

		uo_Defil.x				= 1000
		uo_Defil.y				= 65

		st_1.Hide()
		st_Nombre.Hide()
		st_2.Hide()
		st_Edit.Hide()
		mle_Msg.Hide()


END CHOOSE


/*------------------------------------------------------------------*/
/* Certains Bitmap peuvent changer.											  */
/*------------------------------------------------------------------*/
CHOOSE CASE isTypTrt

	CASE "DR1"

		Pb_Lancer.PictureName = "K:\PB4OBJ\BMP\8_SUPPR.BMP"
		Pb_Lancer.Text			 = "&D$$HEX1$$e900$$ENDHEX$$truire"


	CASE "R1T"

		Pb_Lancer.PictureName = "K:\PB4OBJ\BMP\8_IMP.BMP"
		Pb_Lancer.Text			 = "&Imp. Liste"


	CASE "SOL"

		Pb_Lancer.PictureName = "K:\PB4OBJ\BMP\8_SOLDER.BMP"
		Pb_Lancer.Text			 = "&Solder"




END CHOOSE


end subroutine

protected function boolean wf_lire_blob (long adcidsin, long adcidinter, long adciddoc, string astype, ref blob asblob);//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_Lire_Blob() ( Protected )
//* Auteur			:	Fabry Jf
//* Date				:	17/06/1999
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	Lecture du blob sur ARCHIVE_BLOB
//*
//* Arguments		:	
//*                  adcIdSin			Long				Identifiant du sinistre
//*                  adcIdInter		Long				Identifiant interlocuteur
//*						adcIdDoc			Long				Identifiant du courrier
//*                  astype			String			Type de blob
//*                  asblob			Blob (*)			Retour du blob
//*
//* Retourne		:	True / False si echec lecture
//*             
//*    JFF   11/01/2011    [DECIMAL_PAPILLON]
//*-----------------------------------------------------------------


Boolean bOk = True
Decimal {2} dcIdsin2, dcIdInter2, dcIdDoc2
	
	// [DECIMAL_PAPILLON]
	dcIdsin2 = Dec ( adcIdSin )
	dcIdInter2 = Dec ( adcIdInter )
	dcIdDoc2 = Dec ( adcIdDoc )
	
	SELECTBLOB	txt_blob
			INTO	:asBlob
			FROM	sysadm.archive_blob
		  WHERE  sysadm.archive_blob.id_sin         = :dcIdsin2
			 AND  sysadm.archive_blob.id_inter       = :dcIdInter2
			 AND  sysadm.archive_blob.id_doc         = :dcIdDoc2
			 AND	sysadm.archive_blob.id_typ_blob    = :asType
 		  USING	iTrTrans	;	

	If iTrTrans.SQLCODE <> 0 or iTrTrans.SQLDBCODE <> 0 Then

		Mle_Msg.Uf_AjouterText ( 	"~tErreur lecture " + String ( iTrTrans.SQLCODE ) + &
											" Typ " + astype                + &
											" Sin " + String ( adcidsin   ) + &
											" Int " + String ( adcIdInter ) + &
											" Doc " + String ( adcIdDoc   ) + &
											" .... Impression stopp$$HEX1$$e900$$ENDHEX$$e.~r~n" )		
		bOk = False

	End If

Return bOk

end function

public subroutine wf_actualiseredition (long alNumCourrier);//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_ActualiserEdition ()
////* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	07/05/97 11:05:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	Met $$HEX2$$e0002000$$ENDHEX$$jour la zone indiquant le nombre de courriers $$HEX1$$e900$$ENDHEX$$dit$$HEX1$$e900$$ENDHEX$$s.
//*
//* Arguments		:	Long			alNumCourrier			
//*
//* Retourne		:	Aucun
//*
//*-----------------------------------------------------------------


If ( alNumCourrier > 0 ) and ( iiNumLot > 0 ) Then

	St_Edit.Text 		= String ( alNumCourrier, "0000" ) +  " / " + isNbrCourrier
	st_Nombre.Text		= String ( iiNumLot, "0000" ) 
	uo_Defil.uf_Progression ( alNumcourrier ) 
Else

	St_Edit.Text		= ""
	st_Nombre.Text 	= ""

End If


end subroutine

public subroutine wf_positionnerobjet_relance ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PostionnerObjet (Public)
//* Auteur			: Fabry JF
//* Date				: 21/06/1999 14:10:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	FPI	27/01/2009	[DCMP080728] Agrandissement de lib_long de la table produits				  
//*-----------------------------------------------------------------

Dw_1.x					= 33
Dw_1.y					= 729
Dw_1.Width				= 3530
Dw_1.Height				= 1000

Dw_TailleLot.x			= 37
Dw_TailleLot.y			= 609
Dw_TailleLot.Width	= 1075
Dw_TailleLot.Height	= 89

Dw_SaisieSin.x			= 33
Dw_SaisieSin.y			= 601
Dw_SaisieSin.Width	= 782
Dw_SaisieSin.Height	= 105

uo_Defil.x				= 1189
uo_Defil.y				= 613

st_1.x					= 2113
st_1.y					= 621
st_1.Width				= 293
st_1.Height				= 69

st_Nombre.x				= 2414
st_Nombre.y				= 617
st_Nombre.Width		= 183
st_Nombre.Height		= 73

st_2.x					= 2721
st_2.y					= 621
st_2.Width				= 403
st_2.Height				= 73

st_Edit.x				= 3132
st_Edit.y				= 617
st_Edit.Width			= 426
st_Edit.Height			= 73

mle_Msg.x				= 28
mle_Msg.y				= 217
mle_Msg.Width			= 3530
mle_Msg.Height			= 361

Dw_Produit.x			= 1500 // #1 - 1943
Dw_Produit.y			= 61
Dw_Produit.Width		= 1990 // #1 - 1578
Dw_Produit.Height		= 97

pb_Lancer.x				= 531
pb_Lancer.y				= 17
pb_Lancer.Width		= 234
pb_Lancer.Height		= 137

pb_Creer.x				= 275
pb_Creer.y				= 17
pb_Creer.Width			= 234
pb_Creer.Height		= 137

pb_Retour.x				= 19
pb_Retour.y				= 17
pb_Retour.Width		= 234
pb_Retour.Height		= 137


end subroutine

protected function long wf_editer_relance ();//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_Sp_Rel_Sold::wf_Editer_Relance		(PRIVATE)
//* Auteur			:	Fabry JF
//* Date				:	17/06/1999 11:00:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Impression des dossiers selectionn$$HEX1$$e900$$ENDHEX$$s
//* Commentaires	:	Attention, cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement est en OVERRIDE, en effet je ne peux
//*						utiliser le ue_Word de l'anc$$HEX1$$ea00$$ENDHEX$$tre w_Accueil_Edition car la boucle
//*						prend tous les dossiers de Dw_1 et envoie une seule fois un fichier
//*						Spool. Dans mon cas le fichier Spool sera envoy$$HEX4$$e9002000e0002000$$ENDHEX$$l'impression plusieurs
//*						fois, en fait Dw_1.RowCount()/iiTailleLot fois.
//*				      J'ai donc besoin de r$$HEX2$$e900e900$$ENDHEX$$crire l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement pour ce cas de bouclage.
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//       JFF   12/06/2014 [PI052]
//*-----------------------------------------------------------------


String sText
String sK_RETOUR	= "~r"
String sK_NEWLINE	= "~n"
Long lRet

Int		iCptLot			// Compteur de courrier dans un lot
Long		lRowDw1			// Nbre de row dans Dw1

SetPointer( HourGlass! )
Mle_Msg.Uf_EffacerText()

ib2EmeTourPI052 = False
ibErreurArret = False

wf_SetStopTraitement ( FALSE )

/*------------------------------------------------------------------*/
/* J'arme ici la taille du lot d'$$HEX1$$e900$$ENDHEX$$dition, si la zone est nulle ou   */
/* <=0, c'est que la zone n'est pas saisissable pour le type de     */
/* traitement pr$$HEX1$$e900$$ENDHEX$$sent, on la fice donc $$HEX2$$e0002000$$ENDHEX$$1.                         */
/*------------------------------------------------------------------*/
iiTailleLot = Dw_TailleLot.GetItemNumber ( 1, "TAILLELOT" )
If IsNull ( iiTailleLot ) Or iiTailleLot <= 0 Then
	iiTailleLot = 1
End If

// [PI052]
If Not iuo_rel.ibPI052_GenEdtKsl Then
	/*------------------------------------------------------------------*/
	/* Initialisation de la communication avec Word                     */
	/*------------------------------------------------------------------*/
	sText = "Initialisation du fichier INI ..." + sK_RETOUR + sK_NEWLINE
	Mle_Msg.Uf_AjouterText ( sText )
	
	lRet = invEditionCourrier.uf_Initialiser ( isTypTrtWord )
	
	If	lRet <> 1	Then
		sText = "L'initialisation du fichier INI vient d'$$HEX1$$e900$$ENDHEX$$chouer. "							+ & 
				  "(Erreur : " + String ( lRet ) + ")"												+ &
				  sK_RETOUR + sK_NEWLINE
	
		Mle_Msg.uf_RemplacerText ( sText )
		Return ( lRet )
	Else
		sText = "Initialisation du fichier INI OK" + sK_RETOUR + sK_NEWLINE
		Mle_Msg.Uf_RemplacerText ( sText )
	End If
	
	/*------------------------------------------------------------------*/
	/* On essaye de d$$HEX1$$e900$$ENDHEX$$marrer WORD.                                      */
	/*------------------------------------------------------------------*/
	sText = "Initialisation de la communication avec WORD ..." + sK_RETOUR + sK_NEWLINE
	Mle_Msg.Uf_AjouterText ( sText )
	
	lRet = invEditionCourrier.uf_InitialiserWord ( FALSE )
	
	If	lRet <> 1 Then
		sText = "L'initialisation de la communication avec WORD vient d'$$HEX1$$e900$$ENDHEX$$chouer. "		+ & 
				  "(Erreur : " + String ( lRet ) + ")"												+ &
				  sK_RETOUR + sK_NEWLINE
				  
		Mle_Msg.uf_RemplacerText ( sText )
		Return ( lRet )
	Else
		sText = "Initialisation de la communication avec WORD OK." + sK_RETOUR + sK_NEWLINE
		Mle_Msg.Uf_RemplacerText ( sText )
	End If
End If
// [PI052]

/*------------------------------------------------------------------*/
/* Traitement des dossiers                                          */
/*------------------------------------------------------------------*/
sText = "Traitement des dossiers en cours." + sK_RETOUR + sK_NEWLINE
mle_Msg.Uf_AjouterText ( sText )

This.TriggerEvent ( "SPB_PreparerImpression" )

ilDossier = 0

ilDossier = dw_1.GetSelectedRow( ilDossier )

iCptLot   = 1
iiNumLot	 = 0

/*------------------------------------------------------------------*/
/* Boucle d'$$HEX1$$e900$$ENDHEX$$dition.                                                */
/*------------------------------------------------------------------*/
Do While ( ilDossier > 0 ) And ( Not wf_GetStopTraitement () ) And Not ibErreurArret 

	/*------------------------------------------------------------------*/
	/* Ce test permet de d$$HEX1$$e900$$ENDHEX$$finir si un nouveau fichier spool doit $$HEX1$$ea00$$ENDHEX$$tre  */
	/* initialiser.                                                     */
	/*------------------------------------------------------------------*/
	If ( iCptLot > iiTailleLot ) or ( iCptLot = 1 ) Then

		//.. On imprime le lot en cours (qui est plein)
		// [PI052]
		If iCptLot <> 1 And Not iuo_rel.ibPI052_GenEdtKsl Then
			This.TriggerEvent( "SPB_TerminerImpression" )
		End If

		// A ce moment ibStop peut avoir chang$$HEX1$$e900$$ENDHEX$$...
		If Not wf_GetStopTraitement () Then

			// On vide le rapport toutes les 150 lignes

			If mle_Msg.LineCount () > 150 Then 
				mle_Msg.uf_EffacerText ()
			End If

			iCptLot = 1

			lRowDw1 = Dw_1.RowCount()

			If lRowDw1 > iiTailleLot Then
				ilNbrDossierSelection = iiTailleLot
			Else 
				ilNbrDossierSelection = lRowDw1
			End If

			//.. On cr$$HEX3$$e900e9002000$$ENDHEX$$un nouveau lot d'$$HEX1$$e900$$ENDHEX$$dition.
			// [PI052]
			If Not iuo_rel.ibPI052_GenEdtKsl Then
				invEditionCourrier.uf_InitialiserFichierSpool ()
				This.Wf_RenommerFichierIniEdition ( "COPIER" )
			End If			
			iiNumLot ++

		End If

	End If

	If Not wf_GetStopTraitement () Then
		This.TriggerEvent ( "SPB_ImprimerDossier", ilDossier, ilDossier )
		
		// [PI052]
		/*
		If F_CLE_A_TRUE ( "PI052" ) Then
			If iuo_Rel.ibPI052_GenEdtKsl Then

				Do While Not ib2EmeTourPI052 And Not ibErreurArret
					Yield ()
					// On tourne en attendant le 2$$HEX1$$e800$$ENDHEX$$me tour
				Loop 

				If ib2EmeTourPI052 And Not ibErreurArret Then
					This.TriggerEvent ( "SPB_ImprimerDossier", ilDossier, ilDossier )
				End If 

			End If
		End If
		*/
		
	End If

	If Not wf_GetStopTraitement () And Not ibErreurArret Then

		If ( wf_GetSupprimerLigne () ) Then 

		/*-------------------------------------------------------------------*/
		/* MOD-0021 : On supprime la ligne si ibSupprimeligne = True         */
		/*-------------------------------------------------------------------*/
			Dw_1.Visible = False
			Dw_1.DeleteRow ( ilDossier )
			Dw_1.TriggerEvent ( "Ue_TaillerHauteur" )
			Dw_1.Visible = True
			ilDossier --			

		End If

		ilDossier = dw_1.GetSelectedRow( ilDossier )

		iCptLot ++
		
		
	End If


Loop

//.. NE pas oublier d'imprimer le dernier Lot.
//.. Seulement si le traitement s'est normalement termin$$HEX1$$e900$$ENDHEX$$.
//.. et que le traitement a eu lieu.
// [PI052]
If Not wf_GetStopTraitement () And iiNumLot > 0 And Not iuo_rel.ibPI052_GenEdtKsl Then
	This.TriggerEvent( "SPB_TerminerImpression" )
End If

/*------------------------------------------------------------------*/
/* Trace de l'$$HEX1$$e900$$ENDHEX$$dition                                               */
/*------------------------------------------------------------------*/
//iuocourrier.Uf_Trace ( stGlb, isTypeEdition )

wf_SetSupprimerLigne ( FALSE )

// [PI052]
If Not iuo_rel.ibPI052_GenEdtKsl Then
	invEditionCourrier.uf_TerminerSession ()
End If

Return ( 1 )



end function

private subroutine wf_modifierentete (date aDteEditDocOrig);//*-----------------------------------------------------------------
//*
//* Fonction      : wf_ModifierEntete
//* Auteur        : Fabry JF
//* Date          : 16/04/2004 11:00:45
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Choix de l'entete selon la date de l'edition du courrier d'origirine
//* Commentaires  : 
//*
//* Arguments     : Date		aDteEditDocOrig			Val		// Date d'$$HEX1$$e900$$ENDHEX$$dition du doc original
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String sEntete

/*------------------------------------------------------------------*/
/* #1 : Si la Date d'$$HEX1$$e900$$ENDHEX$$dition est strictement avant le premier jour  */
/* de mise en production de la SVE alors c'est une edition $$HEX9$$e00020002000200020002000200020002000$$ENDHEX$$*/
/* l'ancienne m$$HEX1$$e900$$ENDHEX$$thode (fusion avec DT) ET avec l'ancien fichier     */
/* d'entete.                                                        */
/*------------------------------------------------------------------*/
If aDteEditDocOrig < idDteProdSve Then
	sEntete = isFicEnteteAnc

/*------------------------------------------------------------------*/
/* #1 : Si la Date d'$$HEX1$$e900$$ENDHEX$$dition est sup$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gale $$HEX2$$e0002000$$ENDHEX$$la date de   */
/* mise en prod de la SVE, c'est donc un nouveau courrier $$HEX2$$e0002000$$ENDHEX$$la      */
/* m$$HEX1$$e900$$ENDHEX$$thode SVE, cr$$HEX3$$e900e9002000$$ENDHEX$$avec le nouvel entete. Pour m$$HEX1$$e900$$ENDHEX$$moire on         */
/* m$$HEX1$$e900$$ENDHEX$$morise le nouvel ent$$HEX1$$ea00$$ENDHEX$$te, mais il ne servira pas $$HEX2$$e0002000$$ENDHEX$$la           */
/* reconstruction du courrier qui est d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$fusionn$$HEX2$$e9002000$$ENDHEX$$(DO).           */
/*------------------------------------------------------------------*/
ELse 
	sEntete = isFicEnteteNouv

End If 

isFicEntete		= isRepCourrier + sEntete


end subroutine

private subroutine wf_renommerfichieriniedition (string ascas);//*-----------------------------------------------------------------
//*
//* Fonction      : dw_regle_coherence::wf_RenommerFichierIniEdition (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 16/04/2004 16:19:27
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Copie ou Restaure le fichier INI d'$$HEX1$$e900$$ENDHEX$$dition
//* Commentaires  : Cas : COPIER    > Copie le fichier SIM2_E.INI en un autre fichier SIM2_ESV.INI
//*					  Cas : RESTAURER > Restaure le fichier SIM2_ESV en SIM2.INI
//*
//* Arguments     : String		asCas			Val   // Voir commentaire
//*	
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Choose Case Upper ( asCas ) 

	Case "COPIER"

//Migration PB8-WYNIWYG-03/2006 FM
//		If Not FileExists ( isFicCourrierIni ) Then Return
		If Not f_FileExists ( isFicCourrierIni ) Then Return
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* On supprime le fichier C:\SPB\SIM2_E2.INI		                    */
/*------------------------------------------------------------------*/
		FileDelete ( F_Remplace ( isFicCourrierIni, ".INI", "2.INI" ) )

/*------------------------------------------------------------------*/
/* On copie le fichier actuel C:\SPB\SIM2_E.INI en                  */
/* C:\SPB\SIM2_E2.INI                                               */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//		F_COPY ( stGlb.uoWin, &
//					isFicCourrierIni, &
//					F_Remplace ( isFicCourrierIni, ".INI", "2.INI" ) &
//				 )
		FileCopy (isFicCourrierIni, &
					F_Remplace ( isFicCourrierIni, ".INI", "2.INI" ) &
				 )
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* On supprime le fichier actuel C:\SPB\SIM2_E.INI				              */
/*------------------------------------------------------------------*/
		FileDelete ( isFicCourrierIni )

	Case "RESTAURER"

//Migration PB8-WYNIWYG-03/2006 FM
//		If Not FileExists ( F_Remplace ( isFicCourrierIni, ".INI", "2.INI" ) ) Then Return
		If Not f_FileExists ( F_Remplace ( isFicCourrierIni, ".INI", "2.INI" ) ) Then Return
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* On supprime le fichier C:\SPB\SIM2_E.INI		                    */
/*------------------------------------------------------------------*/
		FileDelete ( isFicCourrierIni )

/*------------------------------------------------------------------*/
/* On restaure le fichier actuel C:\SPB\SIM2_E2.INI en              */
/* C:\SPB\SIM2_E.INI                                                */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//		F_COPY ( stGlb.uoWin, &
//					F_Remplace ( isFicCourrierIni, ".INI", "2.INI" ), &
//					isFicCourrierIni &
//				 )
		FileCopy (F_Remplace ( isFicCourrierIni, ".INI", "2.INI" ), &
					isFicCourrierIni )
//Fin Migration PB8-WYNIWYG-03/2006 FM

	Case "SUPPRIMER"
/*------------------------------------------------------------------*/
/* On supprime le fichier C:\SPB\SIM2_E.INI		                    */
/*------------------------------------------------------------------*/
		FileDelete ( isFicCourrierIni )


End Choose

//Migration PB8-WYNIWYG-03/2006 FM
//If FileExists ( isFicCourrierIni ) Then
If f_FileExists ( isFicCourrierIni ) Then
//Fin Migration PB8-WYNIWYG-03/2006 FM
	SetProfileString ( isFicCourrierIni, "COURRIER", "DTE_EDIT_DOCUMENT", "" )
End If

end subroutine

protected function integer wf_lireecrire_blob (long adcidsin, long adcidinter, long adciddoc, string astype, ref string asnomfic);//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_LireEcrire_Blob () 
//* Auteur			:	Fabry Jf
//* Date				:	27/04/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	Lecture du blob sur ARCHIVE_BLOB
//*
//* Arguments		:	
//*                  adcIdSin			Long				Identifiant du sinistre
//*                  adcIdInter		Long				Identifiant interlocuteur
//*						adcIdDoc			Long				Identifiant du courrier
//*                  astype			String			Type de blob
//*						asNomFic			String			
//*
//* Retourne		:	True / False si echec lecture
//*                  
//  #1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//*-----------------------------------------------------------------

Int	iRet
Blob	blBlob
Long	lCpt
String	sRep, sText
Boolean	bFileDelete, bAbandon, bFicOk

iRet 	  = 1
lCpt	  = 50

//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
sRep	  = stGLB.sRepTempo + String ( adcIdSin, "0000000000" ) // [PI062]


This.wf_Lire_Blob ( adcIdSin, adcIdInter, adcIdDoc, asType, blBlob )

/*------------------------------------------------------------------*/
/* Le blob peut ne pas $$HEX1$$ea00$$ENDHEX$$tre valide, on passe au blob suivant.       */
/*------------------------------------------------------------------*/
If Len ( blBlob ) <= 0 Or IsNull ( blBlob )  Then 

	sText = "~t"																	+ &
			  " Erreur Lecture " + String ( SQLCA.SqlCode )				+ &
			  " Type  : " + string ( asType )								+ &
			  " Sin.  : " + String ( adcIdSin )								+ &
			  " inter : " + String ( adcIdinter )							+ &
			  " Doc   : " + String ( adcIdDoc )								+ &
			  " .... Traitement stopp$$HEX1$$e900$$ENDHEX$$.~r~n"
				 
	Mle_Msg.Uf_AjouterText ( sText )
	
	iRet = -1
	
End If

/*-------------------------------------------------------------------*/
/* 6 Premiers chiffres pour le sinistre, 7$$HEX1$$e800$$ENDHEX$$me et 8$$HEX1$$e800$$ENDHEX$$me pour l'ID_INTER*/
/*-------------------------------------------------------------------*/
asNomFic = sRep + String ( adcIdInter ) + ".DOC"

/*------------------------------------------------------------------*/
/* Suppression du disque d'un $$HEX1$$e900$$ENDHEX$$ventuel fichier portant le m$$HEX1$$ea00$$ENDHEX$$me nom. */
/*------------------------------------------------------------------*/
bFileDelete = False
DO While Not bFileDelete

//Migration PB8-WYNIWYG-03/2006 FM
//	If FileExists ( asNomFic ) Then 
	If f_FileExists ( asNomFic ) Then 
//Fin Migration PB8-WYNIWYG-03/2006 FM
		
		bFileDelete = FileDelete (asNomFic )	
	
		If IsNull ( bFileDelete ) Or Not bFileDelete Then 

			// Compteur au del$$HEX2$$e0002000$$ENDHEX$$de 50, car on n'arrive pas $$HEX2$$e0002000$$ENDHEX$$effacer le fichier.
			lCpt ++
			asNomFic = sRep + String ( lCpt ) + ".DOC"
			
		End If
	
	Else
		bFileDelete = True
	End If
Loop	

/*------------------------------------------------------------------*/	
/* Ecriture du fichier en Local, si probl$$HEX1$$e800$$ENDHEX$$me on ne s'arr$$HEX1$$ea00$$ENDHEX$$te pas,    */
/* il suffit peut-$$HEX1$$ea00$$ENDHEX$$tre de faire de la place sur le disque en        */
/* local, on laisse le choix $$HEX2$$e0002000$$ENDHEX$$l'utilisateur pour r$$HEX1$$e900$$ENDHEX$$essayer via la  */
/* box d'erreur..                                                   */
/*------------------------------------------------------------------*/
bFicOk 	= FALSE
bAbanDon	= FALSE

DO WHILE Not bFicOk And Not bAbandon

	bFicOk = F_EcrireFichierBlob ( blBlob, asNomFic )

	/*------------------------------------------------------------------*/
	/* Probl$$HEX1$$e800$$ENDHEX$$me d'$$HEX1$$e900$$ENDHEX$$criture ou manque de place sur disque dur.           */
	/*------------------------------------------------------------------*/
	If bFicOk = False Then
		stMessage.sTitre = "Gestion des courriers"
		//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
		//stMessage.sVar[1] = stGLB.sWinDir + "\TEMP\"
		stMessage.sVar[1] = stGLB.sRepTempo
	   stMessage.Icon   = Exclamation!
		stMessage.scode  = "EDIT005"
		stMessage.bErreurG= False
		stMessage.Bouton = RetryCancel!
		If	f_Message ( stMessage ) = 2 Then
			bAbandon = TRUE
			iRet = -1
		End If
	End If
	
LOOP

Return iRet 
end function

private function boolean wf_departementaveccodebarre (long aliddept);//*-----------------------------------------------------------------
//*
//* Objet			: W_Ae_Sp_Edition_Dga
//* Fonction		: Wf_DepartementAvecCodeBarre		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 19/09/2006 10:35:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Le courrier que l'on est en train de traiter doit-il sortir avec un code barre ?
//*
//* Arguments		: (Val)		Long		alIdDept				Id d$$HEX1$$e900$$ENDHEX$$partement du courrier en cours d'$$HEX1$$e900$$ENDHEX$$dition
//*
//* Retourne		: Boolean						
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//*
//*----------------------------------------------------------------

Long lTotDept, lCpt

lTotDept = UpperBound ( isCodeBarreDept )

If	lTotDept = 0 Then Return ( FALSE )

For	lCpt = 1 To lTotDept
		If	alIdDept = Long ( isCodeBarreDept[ lCpt ]	) Then Return ( TRUE )
Next

Return ( FALSE )
end function

public function integer wf_getiddocedt (ref string sliddocedt);//[PM_107_REL]

long		lIdDocEdt
integer  iRet
boolean	bError

/*------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du prochain ID_DOC_EDT                        */
/* Cet Id_Doc_Edt NE SERA PAS enregistr$$HEX2$$e9002000$$ENDHEX$$dans archive dans le */
/* courrier de relance													  */
/*------------------------------------------------------------*/
SQLCA.PS_X_INCREMENTER ( "ID_DOC_EDT", lIdDocEdt )
	
bError = &
	( SQLCA.SQLCODE <> 0 Or SQLCA.SQLDBCODE <> 0 Or IsNull ( lIdDocEdt ) Or lIdDocEdt <= 0 )

If Not bError Then 
	
		f_Commit ( SQLCA, TRUE )
		//Formule de la composition de l'id_doc_edt dans PS_U01_MAJ_ID_EDT
		// => @asEdtProgramme + @asEdtApplicatif + REPLICATE ( '0', 7 - LEN ( @iIdDocEdt ) ) + CONVERT ( VARCHAR, @iIdDocEdt )
		slIdDocEdt = k_edt_programme + k_edt_applicatif  + RIGHT(Fill('0',7)+string(lIdDocEdt),7)
		iRet = 1
		
	Else
		f_Commit ( SQLCA, FALSE )

		stMessage.sTitre = "Gestion des courriers"
   	stMessage.Icon   = StopSign!
		stMessage.scode  = "[TODO]"
		stMessage.bErreurG= False
		f_Message ( stMessage )
		iRet = -1
End IF

return iRet

end function

event spb_imprimerdossier;call super::spb_imprimerdossier;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Rel_Sold
//* Evenement 		: SPB_ImprimerDossier
//* Auteur			: Fabry JF
//* Date				: 17/06/1999
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: imprime le courrier de relance et le courrier original.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JFF   16/04/2010	DCMP 040020 SVE : Selon la methode, on change l'entete
//* 		PHG	26/11/2010	[PM_107_REL] : Gestion des mises sous plis et $$HEX1$$e900$$ENDHEX$$liminantion
//*								du mode SEV
//       JFF   11/06/2019  [PM425-1]
//       JFF   18/10/2023 [RS6044_REL_MAIL]
//*-----------------------------------------------------------------

String	sIdCourTyp		// Identifiant du courrier compos$$HEX1$$e900$$ENDHEX$$.
String	sAltPart			// Indique s'il s'agit d'un courrier divers ou particulier.
//String	sAltPce			// Indique s'il y a une autre piece. // [PM_107_REL] plus utilis$$HEX2$$e9002000$$ENDHEX$$?
//String	sAltPs			// Indique s'il y a un post scriptum. // [PM_107_REL] plus utilis$$HEX2$$e9002000$$ENDHEX$$?
String	sNomFic			
Long	   lIdSin			// Identifiant du sinistre
Long	   lIdInter  		// Identifiant interlocuteur
Long		lIdDoc			// Identifiant du courrier pour l'interlocuteur
String	sNom				// Nom du destinataire du courrier.
String	sTypCour			// Type du courrier $$HEX2$$e0002000$$ENDHEX$$imprimer.
//String	sTxtCompo		// Premi$$HEX1$$e800$$ENDHEX$$re de la composition. // [PM_107_REL] plus utilis$$HEX2$$e9002000$$ENDHEX$$?
String	sBac				// Bac $$HEX2$$e0002000$$ENDHEX$$partir duquel on souhaite imprimer le courrier
String	sDateEdit		// Date d'edition du courrier original
String	sRepWinTemp, sFicSauve
String	sMacro
Date		dDteEditCourOrig
long		lProdIdDept		// [PM_107_REL] : Code d$$HEX1$$e900$$ENDHEX$$partement du courrier a relancer
long 		lIdDocIdt		// [PM_107_REL] : N$$HEX2$$b0002000$$ENDHEX$$Editique.
String	sIdDocEdt		// [PM_107_REL] : Transcription en chaine du N$$HEX2$$b0002000$$ENDHEX$$editique.
String	sIdCompteurPage// [PM_107_REL] : Transcription en chaine du compteur de page.
integer	iNbPage			// [PM_107_REL] : Nb de page du document imprim$$HEX1$$e900$$ENDHEX$$
Long     lIdArch, lIdLot, lIdTypDoc  // [PM425-1]
Long     lIdDocRel  // [PM425-1] l'id Doc de la relance cr$$HEX3$$e900e9002000$$ENDHEX$$(pas de l'original qui est lIdDoc)
String   sIdCour    // [PM425-1] IdCour du courrier original

Boolean	bOk = True
Boolean	bContinuer = True 
Boolean	bCodeBarre			// [PM_107_REL] : Indique si le code de Mise sous plis doit $$HEX1$$ea00$$ENDHEX$$tre position pour le courrier en cours d'edition

//Blob		bTxtblob				// Blob contenant le texte des variables. // [PM_107_REL] plus utilis$$HEX2$$e9002000$$ENDHEX$$?

Long		lDocOriginal		// N$$HEX2$$b0002000$$ENDHEX$$de poign$$HEX1$$e900$$ENDHEX$$e pour doc Original, c'est $$HEX2$$e0002000$$ENDHEX$$dire le courrier original
//Long		lDocRelance			// N$$HEX2$$b0002000$$ENDHEX$$de poign$$HEX1$$e900$$ENDHEX$$e pour doc de relance. // [PM_107_REL] plus utilis$$HEX2$$e9002000$$ENDHEX$$?
Long		lIdLigne				// Ligne en cours de traitement
int		iRet

/*------------------------------------------------------------------*/
/* Variable du courrier de relance.                                 */
/*------------------------------------------------------------------*/
String		sIdCourRel		// Identifiant du courrier de relance.
String		sTxtCompRel		// Composition du courrier de relance.
Blob			blBlobDataRel  // Blob data des relances


// [PM425-1] Valeur non connue pour les relances
lIdArch = -100 
lIdLot  = -100 
lIdTypDoc = -100


/*------------------------------------------------------------------*/
/* Construction du courrier de relance, et $$HEX1$$e900$$ENDHEX$$criture en base.        */
/*------------------------------------------------------------------*/
lIdLigne		= Message.WordParm

// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	If iuo_Rel.ibPI052_GenEdtKsl Then
		This.TriggerEvent ( "SPB_ImprimerDossier_PI052", lIdLigne, lIdLigne )
		Return		
	End If
End If
*/

//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//sRepWinTemp = stGLB.sWinDir + "\TEMP\"
sRepWinTemp = stGLB.sRepTempo

/*------------------------------------------------------------------*/
/* Si on est en SVE, on casse le fichier dans lequel on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$rera  */
/* le courrier de REL fusionn$$HEX1$$e900$$ENDHEX$$.                                     */
/*------------------------------------------------------------------*/
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//FileDelete ( stGlb.sWinDir + "\TEMP\SIM2_REL.DOC" )
FileDelete ( stGlb.sRepTempo + "SIM2_REL.DOC" )

This.Wf_RenommerFichierIniEdition ( "SUPPRIMER" )
bOk = iuo_rel.uf_CreerCourrierRelance ( lIdLigne, sIdCourRel, sTxtCompRel, blBlobDataRel, ib2EmeTourPI052 )

// [PM425-1]
lIdDocRel = iuo_rel.uf_Get_IdDoc()
// /[PM425-1]

This.Wf_RenommerFichierIniEdition ( "RESTAURER" )

sAltPart	= Dw_1.GetITemString ( lIdLigne, "ALT_PART"  )
//sAltPce	= Dw_1.GetITemString ( lIdLigne, "ALT_PCE"   ) // [PM_107_REL] plus utilis$$HEX1$$e900$$ENDHEX$$
//sAltPs	= Dw_1.GetITemString ( lIdLigne, "ALT_PS"    ) // [PM_107_REL] plus utilis$$HEX1$$e900$$ENDHEX$$
sNom		= Dw_1.GetItemString ( lIdLigne, "NOM_INTER" )
lIdSin 	= Dw_1.GetitemNumber ( lIdLigne, "ID_SIN" )
lIdInter	= Dw_1.GetItemNumber ( lIdLigne, "ID_I" )
lIdDoc	= Dw_1.GetItemNumber ( lIdLigne, "ID_DOC" )
sIdCour  = Dw_1.GetItemString ( lIdLigne, "ID_COUR" ) // [PM425-1]
dDteEditCourOrig = Dw_1.GetItemDate ( lIdLigne, "DTE_EDIT" )

// [RS6044_REL_MAIL]
If F_CLE_A_TRUE ( "RS6044_REL_MAIL" ) Then
	If Not bOk  then
		Wf_ActualiserEdition ( ilNumCourrier )
		ilNumCourrier ++
		Mle_Msg.Uf_AjouterText ( "Dossier : " + String ( lIdSin ) + " Envoi par mail du courrier " + sIdCourRel + " adress$$HEX4$$e9002000e0002000$$ENDHEX$$" + sNom + "~r~n" )
		FileDelete ( stGlb.sRepTempo + "SIM2_REL.DOC" )
		Return
	End If 
End If

// [PM_107_REL]
lProdIdDept = Dw_1.GetItemNumber ( lIdLigne, "PROD_ID_DEPT" )
bCodeBarre	= Wf_DepartementAvecCodeBarre ( lProdIdDept )

/*------------------------------------------------------------------*/
/*             C O U R R I E R   D E   R E L A N C E.               */
/*------------------------------------------------------------------*/
/* C O U R R I E R   D E   R E L A N C E   M E T H O D E	   S V E	  */
/* Edition du courrier de relance $$HEX2$$e0002000$$ENDHEX$$la nouvelle m$$HEX1$$e900$$ENDHEX$$thode (SVE)       */
/*------------------------------------------------------------------*/

iRet = 1

/*------------------------------------------------------------------*/
/* On affiche un message dans la MLE pour donner des informations   */
/* sur le dossier en cours de traitement.                           */
/*------------------------------------------------------------------*/
Wf_ActualiserEdition ( ilNumCourrier )
ilNumCourrier ++
Mle_Msg.Uf_AjouterText ( "Dossier : " + String ( lIdSin ) + " Impression du courrier " + sIdCourRel + " adress$$HEX4$$e9002000e0002000$$ENDHEX$$" + sNom + "~r~n" )

/*------------------------------------------------------------------*/
/* On s'occupe des param$$HEX1$$e800$$ENDHEX$$tres particuliers du courrier. Faut-il     */
/* $$HEX1$$e900$$ENDHEX$$diter le courrier ?. Faut-il sauvegarder le courrier et sous    */
/* quel nom ?. Faut-il mettre les marques de mise sous pli ?.       */
/*------------------------------------------------------------------*/
sFicSauve = sRepWinTemp + String ( lIdSin ) + "_" + String ( lIdInter )
invEditionCourrier.uf_InscrireParamCourrier ( sFicSauve, "0", "O", "O" )

/*------------------------------------------------------------------*/
/* [PM_107_REL] Modification Mise sous pli.                         */
/* #1. Modif DGA                                                    */
/* Je positionne la valeur du param$$HEX1$$e800$$ENDHEX$$tre MISE SOUS PLI avec          */
/* NouvelleMethode.                                                 */
/*------------------------------------------------------------------*/
if bCodeBarre Then
	iRet = wf_getiddocedt(sIdDocEdt)
End If

If	IsNull ( sIdDocEdt ) Or Len ( Trim  ( sIdDocEdt ) ) = 0 Or bCodeBarre = False Then
	invEditionCourrier.uf_InscrireParamCourrier ( sFicSauve, "0", "O", "N" )  // ... #1 pas de mise sous pli
Else
	invEditionCourrier.uf_InscrireParamCourrier ( sFicSauve, "0", "O", "NouvelleMethode" )
	sIdCompteurPage	= String ( ilMsp_Compteur )
	invEditionCourrier.uf_InscrireParamMiseSousPli ( sIdDocEdt, sIdCompteurPage )
End If
// ...[PM_107_REL]

/*------------------------------------------------------------------*/
/* Ouverture du document se trouvant maintenant sur disque.         */
/*------------------------------------------------------------------*/
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//lDocOriginal 	= invEditionCourrier.uf_OuvrirDocument_2 ( stGlb.sWinDir + "\TEMP\SIM2_REL.DOC" )
lDocOriginal 	= invEditionCourrier.uf_OuvrirDocument_2 ( stGlb.sRepTempo +"SIM2_REL.DOC" )

// [PM425-1]
invEditionCourrier.uf_SetPM425 ( "INIT", lIdSin, lIdInter, sIdCourRel, lIdArch, lIdLot, lIdTypDoc, lIdDocRel, Mle_Msg, "REGROUPEMENT", TRUE ) 
// /[PM425-1]

If iRet < 0 Then 
	wf_SetStopTraitement ( TRUE )
End If

bOk = iRet > 0


/*------------------------------------------------------------------*/
/*  			   I M P R E S S I O N	  R E L A N C E		  			  */
/*------------------------------------------------------------------*/
If bOk Then
	sMacro = "EditerCourrierNouvMethode"

	If invEditionCourrier.uf_Imprimer ( sMacro ) < 0	Then
		wf_SetStopTraitement ( TRUE )
	Else
	
		invEditionCourrier.Uf_FermerDocument_2 ( )
		/*------------------------------------------------------------------*/
		//[PM_107_REL] R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du compteru de page.
		/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nombre de pages du courrier que l'on vient de     */
		/* mettre sous pli.                                                 */
		/*------------------------------------------------------------------*/
		If	bCodeBarre	Then
			iNbPage			= invEditionCourrier.uf_RecupererParamMiseSousPli ()
		Else
			iNbPage = 0
		End If
		
		If	iNbPage > 0	Then
			ilMsp_Compteur = ilMsp_Compteur + iNbPage
			ilMsp_Compteur = Mod(ilMsp_Compteur, 10)
		End If
	End If	

	/*------------------------------------------------------------------*/
	/* Suppression du fichier toujours pr$$HEX1$$e900$$ENDHEX$$sent sur disque si SVE.       */
	/*------------------------------------------------------------------*/
	//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
	//FileDelete ( stGlb.sWinDir + "\TEMP\SIM2_REL.DOC" ) 
	FileDelete ( stGlb.sRepTempo + "SIM2_REL.DOC" ) 
End If

/*------------------------------------------------------------------*/
/*               C O U R R I E R   O R I G I N A L                  */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/*  on ne r$$HEX2$$e900e900$$ENDHEX$$dite pas l'original :                                  */
/*  - Si le courrier original est un questionnaire                  */
/*  - Si le traitement est "R2" (Deuxi$$HEX1$$e800$$ENDHEX$$me relances).                */
/*------------------------------------------------------------------*/

sIdCourTyp 	= Dw_1.GetitemString ( lIdLigne, "ID_COUR" )

bContinuer = ( Left ( sIdCourTyp, 1 ) <> "Q" ) And	( isTypTrt <> "R2" ) 

// [PM425-1]
If Not bContinuer Then
	invEditionCourrier.uf_SetPM425 ( "FIN_REGROUPEMENT", lIdSin, lIdInter, sIdCour, lIdArch, lIdLot, lIdTypDoc, lIdDoc, Mle_Msg, "", TRUE ) 
End If 
// /[PM425-1]

/*------------------------------------------------------------------*/
/* O R I G I N A L  M E T H O D E	S V E					 				  */
/* Edition du courrier original $$HEX2$$e0002000$$ENDHEX$$la nouvelle m$$HEX1$$e900$$ENDHEX$$thode (SVE)         */
/*------------------------------------------------------------------*/
If bContinuer And bOk Then

	iRet			= 1

	/*------------------------------------------------------------------*/
	/* On affiche un message dans la MLE pour donner des informations   */
	/* sur le dossier en cours de traitement.                           */
	/*------------------------------------------------------------------*/
	Mle_Msg.Uf_AjouterText ( "Dossier : " + String ( lIdSin ) + " Impression du courrier " + sIdCour + " adress$$HEX4$$e9002000e0002000$$ENDHEX$$" + sNom + "~r~n" )

	/*------------------------------------------------------------------*/
	/* Lecture du Blob et $$HEX1$$e900$$ENDHEX$$criture du fichier.                          */
	/*------------------------------------------------------------------*/
	iRet = wf_LireEcrire_Blob ( lIdSin, lIdInter, lIdDoc, "DO", sNomFic )

	If iRet < 0 Then 
		wf_SetStopTraitement ( TRUE )
	End If

	/*------------------------------------------------------------------*/
	/* [PM_107_REL]                                                     */
	/* On s'occupe des param$$HEX1$$e800$$ENDHEX$$tres particuliers du courrier. Faut-il     */
	/* $$HEX1$$e900$$ENDHEX$$diter le courrier ?. Faut-il sauvegarder le courrier et sous    */
	/* quel nom ?. Faut-il mettre les marques de mise sous pli ?.       */
	/*------------------------------------------------------------------*/
	If	IsNull ( sIdDocEdt ) Or Len ( Trim  ( sIdDocEdt ) ) = 0 Or bCodeBarre = False Then
		invEditionCourrier.uf_InscrireParamCourrier ( sFicSauve, "0", "O", "N" )  // ... #1 pas de mise sous pli
	Else
		invEditionCourrier.uf_InscrireParamCourrier ( sFicSauve, "0", "O", "NouvelleMethode" )
		sIdCompteurPage	= String ( ilMsp_Compteur )
		invEditionCourrier.uf_InscrireParamMiseSousPli ( sIdDocEdt, sIdCompteurPage )
	End If
	//invEditionCourrier.uf_InscrireParamCourrier ( sFicSauve, "0", "O", "O" )

	/*------------------------------------------------------------------*/
	/* Ouverture du document se trouvant maintenant sur disque.         */
	/*------------------------------------------------------------------*/
	lDocOriginal 	= invEditionCourrier.uf_OuvrirDocument_2 ( sNomFic )

	// [PM425-1]
	invEditionCourrier.uf_SetPM425 ( "INIT", lIdSin, lIdInter, sIdCour, lIdArch, lIdLot, lIdTypDoc, lIdDoc, Mle_Msg, "REGROUPEMENT", TRUE ) 
	// /[PM425-1]


	/*------------------------------------------------------------------*/
	/* Gestion du bac pour les $$HEX1$$e900$$ENDHEX$$ditions                                 */
	/*------------------------------------------------------------------*/
	Choose Case Left ( sIdCourTyp, 1 )
	Case 'Q' // Questionnaire
		sBac = "MILIEU"
	Case 'B' // Courrier Banque
		sBac = "HAUT"
	Case Else	// Courrier Assur$$HEX2$$e9002000$$ENDHEX$$+ autres
		sBac = "BAS"
	End Choose	

//	invEditionCourrier.uf_InscrireBac ( lDocOriginal, sBac, 1 )
	invEditionCourrier.uf_InscrireBac ( lDocOriginal, sBac ) // [SUPPORT_MFP]

	/*------------------------------------------------------------------*/
	/* On $$HEX1$$e900$$ENDHEX$$crit dans le fichier Ini la Dte_Edit du courrier original.   */
	/*------------------------------------------------------------------*/
	sDateEdit = String ( Dw_1.GetItemDate ( lIdLigne, "DTE_EDIT" ), "dd/mm/yyyy" )
	sDateEdit = Left ( sDateEdit, 2 ) + " " + Lower ( F_Mois_En_Lettre ( Integer ( Mid ( sDateEdit, 4, 2 ) ) ) ) + " " + Right ( sDateEdit, 4 )

	invEditionCourrier.Uf_Inscrire_DteEdition_Document_2 ( sDateEdit )

	If iRet < 0 Then 
		wf_SetStopTraitement ( TRUE )
	End If

	bOk = iRet > 0

End If

/*------------------------------------------------------------------*/
/*  			             I M P R E S S I O N								  */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On imprime le courrier, c'est  $$HEX2$$e0002000$$ENDHEX$$dire l'original et la relance.  */
/*------------------------------------------------------------------*/
If bContinuer And bOk Then

	sMacro = "EditerCourrierNouvMethode"

	If invEditionCourrier.uf_Imprimer ( sMacro ) < 0	Then
		wf_SetStopTraitement ( TRUE )
	Else
		invEditionCourrier.Uf_FermerDocument_2 ( )
		/*------------------------------------------------------------------*/
		//[PM_107_REL] R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du compteru de page.
		/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nombre de pages du courrier que l'on vient de     */
		/* mettre sous pli.                                                 */
		/*------------------------------------------------------------------*/
		If	bCodeBarre	Then
			iNbPage			= invEditionCourrier.uf_RecupererParamMiseSousPli ()
		Else
			iNbPage = 0
		End If
		
		If	iNbPage > 0	Then
			ilMsp_Compteur = ilMsp_Compteur + iNbPage
			ilMsp_Compteur = Mod(ilMsp_Compteur, 10)
		End If
	End If
	
	// [PM425-1]
	invEditionCourrier.uf_SetPM425 ( "FIN_REGROUPEMENT", lIdSin, lIdInter, sIdCour, lIdArch, lIdLot, lIdTypDoc, lIdDoc, Mle_Msg, "", TRUE ) 
	// /[PM425-1]
	
End If

/*------------------------------------------------------------------*/
/* Suppression du fichier toujours pr$$HEX1$$e900$$ENDHEX$$sent sur disque.              */
/*------------------------------------------------------------------*/
FileDelete ( sNomFic ) 

end event

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_sold
//* Evenement 		: ue_Initialiser
//* Auteur			: Fabry JF
//* Date				: 23/06/1999 13:56:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre
//* Commentaires	: wf_Initialiser sera lanc$$HEX2$$e9002000$$ENDHEX$$par la suite 
//*					  $$HEX2$$e0002000$$ENDHEX$$partir du menu.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  PLJ  06/05/2004 Gestion du bouton pb_pageblanche				  
//  #2 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//      JFF  11/06/2019 [PM425-1]
//*-----------------------------------------------------------------

String	sTypeTrt
String sFicIniApp, sRepCourrierIni
String sListeDept // [PM_107_REL]
sTypeTrt = stGlb.sMessageErreur

istPass.trTrans	= SQLCA
iTrTrans = istPass.trTrans

sFicIniApp 			= stGLB.sFichierIni
//#2 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//sRepCourrierIni	= ProfileString ( sFicIniApp, "EDITION", "COURRIER_INI", &
//						  ProfileString ( stGlb.sWinDir + "\MAJPOST.INI", "PARAM", "DESTINATION", "C:" ) + "\" )
sRepCourrierIni	= stGlb.sRepTempo

isTypTrtWord = "E"
isFicCourrierIni	= sRepCourrierIni + Left ( stGLB.sCodAppli, 6 ) + "_" + isTypTrtWord + ".INI"


iuo_Rel	= Create u_Gs_Sp_Rel_Anc

/*------------------------------------------------------------------*/
/* On ne d$$HEX1$$e900$$ENDHEX$$sire pas positionner les objets comme la fen$$HEX1$$ea00$$ENDHEX$$tre         */
/* anc$$HEX1$$ea00$$ENDHEX$$tre. On laisse une fonction 'locale' pour le positionnement. */
/*------------------------------------------------------------------*/
ibPositionnerObjet = FALSE
This.wf_PositionnerObjet_Relance ()

This.wf_Initialiser ( sTypeTrt )

/*------------------------------------------------------------------*/
/* #1                                                               */
/* Affichage du bouton pour "impression page pour bo$$HEX1$$ee00$$ENDHEX$$te $$HEX2$$e0002000$$ENDHEX$$archive"  */
/* uniquement dans le cas du soldage                                */
/*------------------------------------------------------------------*/
If sTypeTrt = "SOL" Then
	pb_pageblanche.Visible = True
Else
	pb_pageblanche.Visible = False
End If


/*------------------------------------------------------------------*/
/* (PM_107_REL]                                                     */
/* On arme un tableau d'instance qui correspond $$HEX2$$e0002000$$ENDHEX$$la liste des      */
/* d$$HEX1$$e900$$ENDHEX$$partements pour lequels il faut positionner le code barre sur  */
/* le courrier.                                                     */
/*------------------------------------------------------------------*/

sListeDept = ProfileString ( stGLB.sFichierIni, "EDITION", "CODE_BARRE_DEPT", "" )
If	sListeDept <> ""	Then
	F_DecomposerChaine ( sListeDept, "-", isCodeBarreDept[] )
End If


end event

event spb_preparerimpression;call super::spb_preparerimpression;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Rel_Sold
//* Evenement 		: SPB_PreparerImpression
//* Auteur			: Fabry JF
//* Date				: 14/06/1999
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$but impression des courriers.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date			Modification
//       JFF   12/06/2014 	[PI052]
//*-----------------------------------------------------------------

Long	l1erSin
Long  lCpt, lTotRow, lNbRow

// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	If iuo_rel.ibPI052_GenEdtKsl Then
		Mle_Msg.Uf_AjouterText ( "D$$HEX1$$e900$$ENDHEX$$but de g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration des courriers vers KSL ...~r~n" )
	Else
		Mle_Msg.Uf_AjouterText ( "D$$HEX1$$e900$$ENDHEX$$but d'impression ...~r~n" )
	End If

Else */
	Mle_Msg.Uf_AjouterText ( "D$$HEX1$$e900$$ENDHEX$$but d'impression ...~r~n" )
// End If

/*------------------------------------------------------------------*/
/* On compte le nombre de Row selectionn$$HEX1$$e900$$ENDHEX$$s.                         */
/*------------------------------------------------------------------*/
lTotRow  = Dw_1.RowCount ()
lNbRow   = 0

For lCpt = 1 to lTotRow
	If Dw_1.IsSelected ( lCpt ) Then lNbRow++
Next

isNbrCourrier = String ( lNbRow , "0000" )

uo_Defil.uf_Init ( Integer ( isNbrCourrier ) )

ilnumCourrier = 1

wf_SetSupprimerLigne ( TRUE )
//isTypeEdition    = "1"

/*------------------------------------------------------------------*/
/* Chargement ilSin avec la valeur du premier sinistre $$HEX3$$e0002000e900$$ENDHEX$$diter     */
/* pour que la rupture dans UE_IMPRIMERDOSSIER soit effectu$$HEX1$$e900$$ENDHEX$$e       */
/* correctement                                                     */
/*------------------------------------------------------------------*/

l1erSin			=	Dw_1.GetSelectedRow ( 0 )

If l1erSin > 0 Then
	ilSin			=  Dw_1.GetItemNumber ( l1erSin, "ID_SIN" )
End If

/*------------------------------------------------------------------*/
/* On arme une variable d'instance pour indiquer le fichier des     */
/* DATAS $$HEX2$$e0002000$$ENDHEX$$utiliser pour les impressions.                           */
/*------------------------------------------------------------------*/
isRepCourrier	 = ProfileString ( stGLB.sFichierIni, "EDITION", "REP_COURRIER", "" )
isFicEnteteAnc  = ProfileString ( stGLB.sFichierIni, "EDITION", "ENTETE_ANC1", "" )
isFicEnteteNouv = ProfileString ( stGLB.sFichierIni, "EDITION", "ENTETE", "" )
idDteProdSve	 = Date ( ProfileString ( stGLB.sFichierIni, "EDITION", "DTE_PROD_SVE", "01/01/1900" ) )

// [PM_107_REL] R$$HEX1$$e900$$ENDHEX$$init du compteur de page.
ilmsp_compteur = 0
end event

on ue_enablefenetre;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Rel_Sold (OVERRIDE)
//* Evenement 		: ue_EnableFenetre
//* Auteur			: Fabry JF
//* Date				: 18/06/1999 13:50:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: On rend Enabled certains objets apr$$HEX1$$e800$$ENDHEX$$s la fin traitement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Dw_Produit.Enabled	 	 = True
Dw_TailleLot.Enabled	 	 = True
Dw_SaisieSin.Enabled		 = True
Pb_Creer.Enabled	 	  	 = True
Pb_Lancer.Enabled	 	  	 = False
Pb_Retour.Enabled	 	 	 = True

end on

on ue_item7;call w_accueil_edition_2000::ue_item7;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_anc
//* Evenement 		: ue_Item7
//* Auteur			: Fabry JF
//* Date				: 18/06/1999 13:54:47
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lancement du traitement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

TriggerEvent ( "ue_DisableFenetre" )

end on

event spb_terminerimpression;call super::spb_terminerimpression;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Rel_Sold
//* Evenement 		: SPB_TerminerImpression
//* Auteur			: Fabry JF
//* Date				: 17/06/99 15:52:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Termine impression d'un lot.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*	JFF     28/04/21  Supp du message car si que du CORUS et pas UNE $$HEX1$$e900$$ENDHEX$$dition, pas de spool et erreur intempestive qui n'existe pas.
//*-----------------------------------------------------------------

Long lRet

stMessage.bErreurG  = False
stMessage.sCode	  = "GENE012"
stMessage.sTitre    = "SIMPA2 - Relances"
stMessage.Icon	  	  = Exclamation!
stMessage.Bouton    = Ok!

/*------------------------------------------------------------------*/
/* Si l'impression est OK, on envoit le fichier spool $$HEX14$$e0002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
/* l'imprimante.                                                    */
/*------------------------------------------------------------------*/

If Not Wf_GetStopTraitement () Then
	
	lRet = invEditionCourrier.uf_EnvoyerImpressionAuSpool ()

	If	lRet = 1	Then
		Mle_Msg.Uf_AjouterText ( "Fin d'impression du lot " + string ( iiNumLot ) + "...~r~n" )
	Else

		wf_SetStopTraitement ( FALSE )
/*
		stMessage.sVar[1]   = "Impossible d'imprimer"
		stMessage.sVar[1]  += " Le traitement est arr$$HEX1$$ea00$$ENDHEX$$t$$HEX1$$e900$$ENDHEX$$."
	
		f_Message ( stMessage )
*/		
	End If
End If
end event

on ue_creer;call w_accueil_edition_2000::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Rel_Sold
//* Evenement 		: ue_Creer
//* Auteur			: Fabry JF
//* Date				: 21/06/1999 12:31:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: On disable la fen$$HEX1$$ea00$$ENDHEX$$tre
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

TriggerEvent ( "ue_DisableFenetre" )

uo_Defil.uf_Init ( 0 )
st_Nombre.Text 	= ""
st_Edit.Text		= ""

mle_Msg.uf_EffacerText ()


end on

on w_a_sp_rel_sold_2000.create
int iCurrent
call super::create
this.uo_defil=create uo_defil
this.dw_taillelot=create dw_taillelot
this.dw_saisiesin=create dw_saisiesin
this.dw_produit=create dw_produit
this.dw_para_prod=create dw_para_prod
this.dw_police=create dw_police
this.uo_libelle=create uo_libelle
this.dw_civilite=create dw_civilite
this.pb_lancer=create pb_lancer
this.dw_boitearchive=create dw_boitearchive
this.dw_detpro=create dw_detpro
this.dw_page_blanche=create dw_page_blanche
this.pb_pageblanche=create pb_pageblanche
this.dw_gencourrier=create dw_gencourrier
this.dw_autorisation=create dw_autorisation
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_defil
this.Control[iCurrent+2]=this.dw_taillelot
this.Control[iCurrent+3]=this.dw_saisiesin
this.Control[iCurrent+4]=this.dw_produit
this.Control[iCurrent+5]=this.dw_para_prod
this.Control[iCurrent+6]=this.dw_police
this.Control[iCurrent+7]=this.uo_libelle
this.Control[iCurrent+8]=this.dw_civilite
this.Control[iCurrent+9]=this.pb_lancer
this.Control[iCurrent+10]=this.dw_boitearchive
this.Control[iCurrent+11]=this.dw_detpro
this.Control[iCurrent+12]=this.dw_page_blanche
this.Control[iCurrent+13]=this.pb_pageblanche
this.Control[iCurrent+14]=this.dw_gencourrier
this.Control[iCurrent+15]=this.dw_autorisation
end on

on w_a_sp_rel_sold_2000.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_defil)
destroy(this.dw_taillelot)
destroy(this.dw_saisiesin)
destroy(this.dw_produit)
destroy(this.dw_para_prod)
destroy(this.dw_police)
destroy(this.uo_libelle)
destroy(this.dw_civilite)
destroy(this.pb_lancer)
destroy(this.dw_boitearchive)
destroy(this.dw_detpro)
destroy(this.dw_page_blanche)
destroy(this.pb_pageblanche)
destroy(this.dw_gencourrier)
destroy(this.dw_autorisation)
end on

on close;call w_accueil_edition_2000::close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Rel_Sold
//* Evenement 		: Close
//* Auteur			: Fabry JF
//* Date				: 08/06/1999 14:27:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre
//* Commentaires	: Destruction des objets.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DESTROY iuo_Rel

end on

on ue_disablefenetre;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Rel_Sold (OVERRIDE)
//* Evenement 		: ue_DisableFenetre
//* Auteur			: Fabry JF
//* Date				: 18/06/1999 13:50:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: On rend disabled certains objets avant le lancement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Dw_Produit.Enabled	 	 = False
Dw_TailleLot.Enabled	 	 = False
Dw_SaisieSin.Enabled		 = False
Pb_Creer.Enabled	 	  	 = False
Pb_Lancer.Enabled		 	 = False
Pb_Retour.Enabled	 	 	 = False

end on

event timer;call super::timer;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Timer
//* Evenement 		: Item5
//* Auteur			: FABRY JF
//* Date				: 25/06/2014
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PI052]
//* Commentaires	: Evenement d$$HEX1$$e900$$ENDHEX$$clench$$HEX4$$e9002000e0002000$$ENDHEX$$partir de la fen$$HEX1$$ea00$$ENDHEX$$tre contacts
//*					  en consultation pour r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer les init de la personne
//*					  qui va traiter le travail.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass stPass

// Test d'un boolean de fa$$HEX1$$e700$$ENDHEX$$on $$HEX2$$e0002000$$ENDHEX$$pouvoir d$$HEX1$$e900$$ENDHEX$$clencher le Timer pour d'autres traitement
// est pas pour le PI052.

// SI timer du PI052 Allum$$HEX1$$e900$$ENDHEX$$
If iuo_Rel.ibTimerPI052 Then

	// Si fin PDF pas encore g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$
	If Not iuo_Rel.ibFinGenerationPDFOk Then

		// Alors on srute toujours le r$$HEX1$$e900$$ENDHEX$$pertoire
		If iuo_Rel.uf_PI052_GestionTimer ( "SCRUTER", 0 ) <= 0 Then
		
			//... Et si d$$HEX1$$e900$$ENDHEX$$lai d$$HEX1$$e900$$ENDHEX$$pass$$HEX2$$e9002000$$ENDHEX$$Alors...
			iuo_Rel.uf_PI052_GestionTimer ( "ARRETER_TIMER", 0 )

			ibErreurArret = True
			Mle_Msg.Uf_AjouterText ( "Dossier : Impossible de r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le courrier KSL, KSL ne l'a pas g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX2$$e9002000$$ENDHEX$$" + "~r~n" )			
			Mle_Msg.Uf_AjouterText ( "! ARRET DU TRAITEMENT EN ERREUR !" + "~r~n" )			
			
			stMessage.sTitre		= "G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration des courriers"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "P234021"
			F_Message ( stMessage )  
			
//			pb_Controler.Enabled = True			

		End If

	Else // ...Sinon succ$$HEX1$$e800$$ENDHEX$$s, courrier r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$s.
		iuo_Rel.uf_PI052_GestionTimer ( "ARRETER_TIMER", 0 )
		dw_1.TriggerEvent ( "ue_ibScriptClientFocus" )  // Affectation $$HEX2$$e0002000$$ENDHEX$$TRUE
		This.ib2EmeTourPI052 = True
//		This.TriggerEvent ( "SPB_ImprimerDossier_PI052" )  
	End If
End If

end event

type cb_debug from w_accueil_edition_2000`cb_debug within w_a_sp_rel_sold_2000
end type

type pb_retour from w_accueil_edition_2000`pb_retour within w_a_sp_rel_sold_2000
integer width = 242
integer height = 144
integer taborder = 90
end type

type pb_interro from w_accueil_edition_2000`pb_interro within w_a_sp_rel_sold_2000
boolean visible = false
integer x = 4229
integer y = 72
integer width = 146
integer height = 100
integer taborder = 0
boolean enabled = false
string picturename = ""
end type

type pb_creer from w_accueil_edition_2000`pb_creer within w_a_sp_rel_sold_2000
boolean visible = true
integer x = 279
integer y = 16
integer width = 242
integer height = 144
boolean enabled = true
string text = "&Charger"
string picturename = "k:\pb4obj\bmp\8_liste.bmp"
end type

type dw_1 from w_accueil_edition_2000`dw_1 within w_a_sp_rel_sold_2000
integer x = 2981
integer y = 1388
integer width = 581
integer height = 320
integer taborder = 120
end type

on dw_1::ue_trier;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_accueil_edition::dw_1
//* Evenement 		: ue_Trier
//* Auteur			: Fabry JF
//* Date				: 09/06/1999 16:06:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: On ne tient plus compte du script anc$$HEX1$$ea00$$ENDHEX$$tre 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------



end on

on dw_1::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_accueil_edition::dw_1 (OverRide)
//* Evenement 		: Clicked
//* Auteur			: Fabry JF
//* Date				: 09/06/1999 16:52:12
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: On ne tient plus compte du script anc$$HEX1$$ea00$$ENDHEX$$tre
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long		lRow

lRow = This.GetClickedRow ()



CHOOSE CASE isTypTrt

	CASE "R1P", "DR1"

		If  lRow > 0 Then
			SelectRow ( 0, False   )
			SelectRow ( lRow, True )
		End If
		
END CHOOSE


end on

on dw_1::rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_accueil_edition::dw_1 (OVERRIDE)
//* Evenement 		: rButtonDown
//* Auteur			: Fabry JF
//* Date				: 09/06/1999 16:50:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: On ne tient pas compte du script de l'anc$$HEX1$$ea00$$ENDHEX$$tre
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------



end on

type pb_tri from w_accueil_edition_2000`pb_tri within w_a_sp_rel_sold_2000
boolean visible = false
integer x = 4247
integer y = 320
integer width = 146
integer height = 100
integer taborder = 0
boolean enabled = false
boolean originalsize = false
string picturename = ""
end type

type pb_imprimer from w_accueil_edition_2000`pb_imprimer within w_a_sp_rel_sold_2000
integer x = 4233
integer y = 196
end type

type cb_tout from w_accueil_edition_2000`cb_tout within w_a_sp_rel_sold_2000
integer x = 3936
integer y = 80
integer taborder = 0
end type

type cb_aucun from w_accueil_edition_2000`cb_aucun within w_a_sp_rel_sold_2000
integer x = 3936
integer y = 200
integer taborder = 0
end type

type st_1 from w_accueil_edition_2000`st_1 within w_a_sp_rel_sold_2000
integer x = 539
integer y = 336
integer width = 325
integer height = 88
string text = "Lot en cours"
end type

type st_2 from w_accueil_edition_2000`st_2 within w_a_sp_rel_sold_2000
integer x = 544
integer y = 452
integer width = 325
integer height = 132
string text = "Edition du dossier"
end type

type st_nombre from w_accueil_edition_2000`st_nombre within w_a_sp_rel_sold_2000
integer x = 910
integer y = 336
integer width = 325
integer height = 88
end type

type st_edit from w_accueil_edition_2000`st_edit within w_a_sp_rel_sold_2000
integer x = 910
integer y = 452
integer width = 325
integer height = 88
end type

type mle_msg from w_accueil_edition_2000`mle_msg within w_a_sp_rel_sold_2000
integer x = 46
integer y = 328
integer width = 416
integer height = 360
end type

type pb_editer from w_accueil_edition_2000`pb_editer within w_a_sp_rel_sold_2000
boolean visible = false
integer x = 3959
integer y = 348
integer taborder = 0
boolean enabled = false
end type

type uo_defil from u_barredefil within w_a_sp_rel_sold_2000
integer x = 507
integer y = 616
integer width = 809
integer height = 76
integer taborder = 0
end type

type dw_taillelot from u_datawindow within w_a_sp_rel_sold_2000
boolean visible = false
integer x = 1906
integer y = 216
integer width = 992
integer height = 88
integer taborder = 10
boolean enabled = false
string dataobject = "d_sp_rel_taille_lot"
boolean border = false
end type

on itemerror;call u_datawindow::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_anc::dw_taillelot
//* Evenement 		: ItemError
//* Auteur			: Fabry JF
//* Date				: 11/06/1999 16:11:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion de l'erreur
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iuo_Rel.uf_Zn_TailleLot ( 2 )
end on

on constructor;call u_datawindow::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_taillelot
//* Evenement 		: Constructeur
//* Auteur			: Fabry JF
//* Date				: 11/06/1999 16:56:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: On ne g$$HEX1$$e800$$ENDHEX$$re pas le bouclage, car il n'y a qu'un champs
//*					  et cela pose quelques probl$$HEX1$$e800$$ENDHEX$$mes.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


ibGestionTouche = False
end on

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_anc::dw_taillelot
//* Evenement 		: ItemChanged
//* Auteur			: Fabry JF
//* Date				: 11/06/1999 16:11:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de la zone
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

// [MIGPB8COR] PHG
//iuo_Rel.uf_Zn_TailleLot ( 1 )
return iuo_Rel.uf_Zn_TailleLot ( 1 )



end event

type dw_saisiesin from u_datawindow within w_a_sp_rel_sold_2000
boolean visible = false
integer x = 1920
integer y = 348
integer width = 425
integer height = 88
integer taborder = 80
string dataobject = "d_sp_rel_sin"
boolean border = false
end type

on itemerror;call u_datawindow::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_anc::dw_SaisieSin
//* Evenement 		: ItemError
//* Auteur			: Fabry JF
//* Date				: 23/06/1999 16:11:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de la zone
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iuo_Rel.uf_Zn_RefSin ( 2 )


end on

on constructor;call u_datawindow::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Saisiesin
//* Evenement 		: Constructeur
//* Auteur			: Fabry JF
//* Date				: 11/06/1999 16:56:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: On ne g$$HEX1$$e800$$ENDHEX$$re pas le bouclage, car il n'y a qu'un champs
//*					  et cela pose quelques probl$$HEX1$$e800$$ENDHEX$$mes.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


ibGestionTouche = False
end on

on getfocus;call u_datawindow::getfocus;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_anc::dw_SaisieSin
//* Evenement 		: GetFocus
//* Auteur			: Fabry JF
//* Date				: 25/06/1999 14:19:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Changement de Ref Sin
//* Commentaires	: Une r$$HEX1$$e900$$ENDHEX$$initialisation de certain objet est n$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$ssaire
//*					  Lorsque la Ref Sin change.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.Dw_TailleLot.Hide ()
Parent.Dw_TailleLot.Enabled = False
Parent.pb_Creer.Enabled 	 = True
Parent.pb_Lancer.Enabled 	 = False
Parent.uo_Defil.uf_Init ( 0 )
Parent.st_Nombre.Text = ""
Parent.st_Edit.Text = ""

Dw_1.Reset ()
iuo_Rel.uf_CacherTextDw1 ( "OUI" )



end on

on itemchanged;call u_datawindow::itemchanged;////*-----------------------------------------------------------------
////*
////* Objet 			: w_a_sp_rel_anc::dw_SaisieSin
////* Evenement 		: ItemChanged
////* Auteur			: Fabry JF
////* Date				: 23/06/1999 16:11:04
////* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de la zone
////* Commentaires	: 
////*				  
////*-----------------------------------------------------------------
////* MAJ PAR		Date		Modification
////*				  
////*-----------------------------------------------------------------
//
//iuo_Rel.uf_Zn_RefSin ( 1 )
//
//
end on

type dw_produit from u_datawindow within w_a_sp_rel_sold_2000
boolean visible = false
integer x = 1925
integer y = 456
integer width = 1577
integer height = 88
integer taborder = 20
string dataobject = "d_sp_rel_produit"
boolean border = false
end type

on itemchanged;call u_datawindow::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_anc::dw_produit
//* Evenement 		: ItemChanged
//* Auteur			: Fabry JF
//* Date				: 09/06/1999 14:19:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Changement de produit.
//* Commentaires	: Une r$$HEX1$$e900$$ENDHEX$$initialisation de certain objet est n$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$ssaire
//*					  Lorsque le produit change.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.Dw_TailleLot.Hide ()
Parent.Dw_TailleLot.Enabled = False
Parent.pb_Creer.Enabled 	 = True
Parent.pb_Lancer.Enabled 	 = False
Parent.uo_Defil.uf_Init ( 0 )
Parent.st_Nombre.Text = ""
Parent.st_Edit.Text = ""

Dw_1.Reset ()
iuo_Rel.uf_CacherTextDw1 ( "OUI" )



end on

type dw_para_prod from datawindow within w_a_sp_rel_sold_2000
boolean visible = false
integer x = 251
integer y = 1540
integer width = 347
integer height = 148
boolean bringtotop = true
string dataobject = "d_sp_rel_prod_para"
end type

type dw_police from datawindow within w_a_sp_rel_sold_2000
boolean visible = false
integer x = 626
integer y = 1540
integer width = 347
integer height = 148
boolean bringtotop = true
string dataobject = "d_sp_rel_police"
end type

type uo_libelle from u_libelle_dga within w_a_sp_rel_sold_2000
boolean visible = false
integer x = 1376
integer y = 1540
integer width = 347
integer height = 148
end type

on uo_libelle.destroy
call u_libelle_dga::destroy
end on

type dw_civilite from datawindow within w_a_sp_rel_sold_2000
boolean visible = false
integer x = 1001
integer y = 1540
integer width = 347
integer height = 148
boolean bringtotop = true
string dataobject = "dddw_spb_code_civilite"
boolean livescroll = true
end type

type pb_lancer from picturebutton within w_a_sp_rel_sold_2000
integer x = 539
integer y = 16
integer width = 233
integer height = 136
integer taborder = 100
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Lancer"
string picturename = "k:\pb4obj\bmp\8_lancer.bmp"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: pb_Lancer
//* Evenement 		: Cliked
//* Auteur			: Fabry JF
//* Date				: 11/06/1999 10:12:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.TriggerEvent ( "ue_fermerword" ) 

Parent.TriggerEvent ( "ue_Item7" )
end event

type dw_boitearchive from datawindow within w_a_sp_rel_sold_2000
boolean visible = false
integer x = 1751
integer y = 1540
integer width = 224
integer height = 140
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_boite_archive"
boolean livescroll = true
end type

type dw_detpro from datawindow within w_a_sp_rel_sold_2000
boolean visible = false
integer x = 2016
integer y = 1540
integer width = 224
integer height = 140
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_lst_det_pro"
boolean livescroll = true
end type

type dw_page_blanche from datawindow within w_a_sp_rel_sold_2000
boolean visible = false
integer x = 2281
integer y = 1540
integer width = 242
integer height = 152
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_sp_rel_page_blanche"
boolean livescroll = true
end type

type pb_pageblanche from picturebutton within w_a_sp_rel_sold_2000
integer x = 18
integer y = 164
integer width = 233
integer height = 140
integer taborder = 110
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Page Arch"
string picturename = "k:\pb4obj\bmp\8_imp.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_sold::pb_pageblanche
//* Evenement 		: CLICKED
//* Auteur			: PLJ
//* Date				: 26/03/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Impression des pages blanches pour ligne coch$$HEX1$$e900$$ENDHEX$$e dans la liste
//* Commentaires	: 
//*					  
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long		lCpt, lTot, lIdSin
String	sNom, sPrenom, sAltPapier 

If dw_Page_Blanche.RowCount () = 0 Then
	dw_page_Blanche.InsertRow (0)	
End If


If dw_1.RowCount() > 0 Then

	dw_page_blanche.SetItem ( 1, "LIB_PROD", iuo_Rel.uf_Get_LibProd () )

	lTot = dw_1.RowCount ()

	For lCpt = 1 To lTot

		sAltPapier = dw_1.GetItemString ( lCpt, "ALT_PAPIER" )
		If sAltPapier = 'O' Then
			sNom    = dw_1.GetItemString ( lCpt, "PERS_NOM"    )
			sPreNom = dw_1.GetItemString ( lCpt, "PERS_PRENOM" )
			lIdSin  = dw_1.GetItemNumber ( lCpt, "ID_SIN"      )

			dw_Page_Blanche.SetItem ( 1, "NOM",    RightTrim (sNom) + ' ' + RightTrim ( sPrenom ) )
			dw_Page_Blanche.SetItem ( 1, "ID_SIN", lIdSin )

			dw_Page_Blanche.Print ( FALSE )
		End IF

   Next

End IF



end on

type dw_gencourrier from datawindow within w_a_sp_rel_sold_2000
boolean visible = false
integer x = 256
integer y = 1404
integer width = 242
integer height = 100
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_stk_generation_courrier"
end type

type dw_autorisation from datawindow within w_a_sp_rel_sold_2000
boolean visible = false
integer x = 539
integer y = 1404
integer width = 242
integer height = 100
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_lst_autorisation"
end type

