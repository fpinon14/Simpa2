HA$PBExportHeader$w_ae_sp_reedition_dcmp060589.srw
$PBExportComments$-- } Fen$$HEX1$$ea00$$ENDHEX$$tre de r$$HEX2$$e900e900$$ENDHEX$$dition
forward
global type w_ae_sp_reedition_dcmp060589 from w_accueil_edition_2000
end type
type pb_charger from picturebutton within w_ae_sp_reedition_dcmp060589
end type
type st_charger from statictext within w_ae_sp_reedition_dcmp060589
end type
type dw_progressbar from datawindow within w_ae_sp_reedition_dcmp060589
end type
type dw_pagetitre from datawindow within w_ae_sp_reedition_dcmp060589
end type
type st_encours from statictext within w_ae_sp_reedition_dcmp060589
end type
type dw_acc_type_courrier from datawindow within w_ae_sp_reedition_dcmp060589
end type
type cb_partiel_haut from commandbutton within w_ae_sp_reedition_dcmp060589
end type
type cb_partiel_bas from commandbutton within w_ae_sp_reedition_dcmp060589
end type
type cb_partiel from commandbutton within w_ae_sp_reedition_dcmp060589
end type
end forward

global type w_ae_sp_reedition_dcmp060589 from w_accueil_edition_2000
integer width = 3570
integer height = 1980
pb_charger pb_charger
st_charger st_charger
dw_progressbar dw_progressbar
dw_pagetitre dw_pagetitre
st_encours st_encours
dw_acc_type_courrier dw_acc_type_courrier
cb_partiel_haut cb_partiel_haut
cb_partiel_bas cb_partiel_bas
cb_partiel cb_partiel
end type
global w_ae_sp_reedition_dcmp060589 w_ae_sp_reedition_dcmp060589

type prototypes
Function Long iPusheMail ( String asMailServer, String asMailBox, String asId_Seq, String asId_Appli, String asId_Sin, String asId_Prod, String asLibProd, String asId_Ets, String asFrom, String asSend, String asSubject, String asAlt_Quarantaine, String asBody ) Library "EMAILPSH.DLL" alias for "iPusheMail;Ansi"
end prototypes

type variables
String	isMajPar
Long	ilIdSin
DateTime	idEditeLe
Long	ilIdLot

string	isRepCourrier
long	ilNbCour, ilNbSelect

Private :
/*------------------------------------------------------------------*/
/* Le 03/09/2006. Modification Mise sous pli                        */
/* D$$HEX1$$e900$$ENDHEX$$claration de deux constantes pour l'$$HEX1$$e900$$ENDHEX$$ditique.                  */
/* D$$HEX1$$e900$$ENDHEX$$claration du compteur de contr$$HEX1$$f400$$ENDHEX$$le pour la mise sous pli.       */
/*------------------------------------------------------------------*/
CONSTANT	String	K_EDT_PROGRAMME 	= "042"
CONSTANT	String	K_EDT_APPLICATIF	= "1"
Long					ilMsp_Compteur
String				isCodeBarreDept[]

end variables

forward prototypes
private function integer wf_lire_blob (long alidarch, long alidsin, long alidinter, ref string asnomfic)
private function boolean wf_ecrire_fichier (string as_filename, blob ablb_data, boolean ab_append)
private function boolean wf_archiver (ref string asmess)
public subroutine wf_positionnerobjets ()
private function boolean wf_departementaveccodebarre (long aliddept)
public subroutine wf_selectionner (long alrowdeb, long alrowfin)
end prototypes

private function integer wf_lire_blob (long alidarch, long alidsin, long alidinter, ref string asnomfic);//*-----------------------------------------------------------------
//*
//* Fonction		: wf_lire_blob
//* Auteur			: PLJ
//* Date				: 24/10/2001 11:31:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 	value long 		alidarch
//* 						value long 		alidsin	 
//* 						value long 		alidinter	 
//* 						ref   string 	asnomfic	 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//  #1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//*    JFF   11/01/2011    [DECIMAL_PAPILLON]
//*-----------------------------------------------------------------


Int	iRet
Blob	blBlob
Long	lCpt
String	sRep, sText
Boolean	bFileDelete, bAbandon, bFicOk
Decimal {2} dcIdsin

iRet 	  = 1
lCpt	  = 50

//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
sRep	  = stGLB.sRepTempo + String ( alIdSin, "0000000000" )  // [PI062]

dcIdsin = dec (alIdSin)
/*------------------------------------------------------------------*/
/* S$$HEX1$$e900$$ENDHEX$$lection du Blob.                                               */
/*------------------------------------------------------------------*/
SELECTBLOB	txt_blob
INTO			:blBlob
FROM			sysadm.w_cour_blob_arch
WHERE			id_arch		= :alIdArch
AND			id_sin		= :dcIdsin
AND			id_typ_blob = 'DO'
USING			SQLCA ;

/*------------------------------------------------------------------*/
/* Le blob peut ne pas $$HEX1$$ea00$$ENDHEX$$tre valide, on passe au blob suivant.       */
/*------------------------------------------------------------------*/
If Len ( blBlob ) <= 0 Or IsNull ( blBlob ) Then 

	sText = "~t"																	+ &
			  " Erreur Lecture " + String ( SQLCA.SqlCode )				+ &
			  " Type  : DO" 														+ &
			  " Sin.  : " + String ( alIdSin )								+ &
  			  " Arch	 : " + String ( alIdArch )								+ &
			  " .... Traitement stopp$$HEX1$$e900$$ENDHEX$$.~r~n"
				 
	Mle_Msg.Uf_AjouterText ( sText )
	
	iRet = -1
	
End If

/*-------------------------------------------------------------------*/
/* 6 Premiers chiffres pour le sinistre, 7$$HEX1$$e800$$ENDHEX$$me et 8$$HEX1$$e800$$ENDHEX$$me pour l'ID_INTER*/
/*-------------------------------------------------------------------*/
asNomFic = sRep + String ( alIdInter ) + ".DOC"

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
	
	bFicOk = wf_Ecrire_Fichier ( asNomFic, blBlob, FALSE )

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

private function boolean wf_ecrire_fichier (string as_filename, blob ablb_data, boolean ab_append);//*-----------------------------------------------------------------
//*
//* Fonction		: wf_ecrire_fichier
//* Auteur			: PLJ
//* Date				: 24/10/2001 11:31:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//	Arguments:		as_FileName				The name of the file to write to.
//						ablb_Data				The text to be written to the file.
//						ab_Append				True - append to the end of the file,
//													False - overwrite the existing file.
//	Returns:			Boolean
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

integer li_FileNo, li_Writes, li_Cnt
long ll_BlobLen, ll_CurrentPos
blob lblb_Data
writemode lwm_Mode

If ab_Append Then
	lwm_Mode = Append!
Else
	lwm_Mode = Replace!
End if

li_FileNo = FileOpen(as_FileName, StreamMode!, Write!, LockReadWrite!, lwm_Mode)
If li_FileNo < 0 Then Return False

ll_BlobLen = Len(ablb_Data)

// Determine the number of writes required to write the entire blob
If ll_BlobLen > 32765 Then
	If Mod(ll_BlobLen, 32765) = 0 Then
		li_Writes = ll_BlobLen / 32765
	Else
		li_Writes = (ll_BlobLen / 32765) + 1
	End if
Else
	li_Writes = 1
End if

ll_CurrentPos = 1

For li_Cnt = 1 To li_Writes
	lblb_Data = BlobMid(ablb_Data, ll_CurrentPos, 32765)
	ll_CurrentPos += 32765
	If FileWrite(li_FileNo, lblb_Data) = -1 Then
		Return False
	End if
Next

FileClose(li_FileNo)

Return True


end function

private function boolean wf_archiver (ref string asmess);//*-----------------------------------------------------------------
//*
//* Fonction		: wf_archiver
//* Auteur			: PLJ
//* Date				: 24/10/2001 11:31:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String	asMess	
//*
//* Retourne		: boolean
//*
//*-----------------------------------------------------------------
//* MAJ  PAR      Date	     Modification
//* #1	DGA		03/09/2006	Modification pour la mise sous pli. [DCMP-060589]
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------


Boolean 	bOk 
Long		lRet, lIdLot

bOk = True

/*------------------------------------------------------------------*/
/* Mise $$HEX2$$e0002000$$ENDHEX$$jour sur archive du lot                                   */
/* SELECTION SIMPLE, pour r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le n$$HEX2$$b0002000$$ENDHEX$$de lot on se sert de      */
/* la variable ilNbSelect                 								  */
/*------------------------------------------------------------------*/
//asMess = Space (60)
//lIdLot = dw_acc_type_courrier.GetItemNumber ( ilNbSelect, "ID_LOT" )
//lRet = SQLCA.PS_I02_ARCHIVE_BLOB_VAL( lIdLot, asMess )
//
//If lRet <> 0 Or SQLCA.SQLCODE <> 0 Or SQLCA.SQLDBCODE <> 0 Then 
//	bOk = False
//End If
//
//f_Commit (SqlCa, bOk )

/*------------------------------------------------------------------*/
/* #1. Le 03/09/2006 Modification DGA.                              */
/*------------------------------------------------------------------*/
/* [DCMP-060589]                                                    */
/*------------------------------------------------------------------*/
/* L'update de la zone DTE_EDIT sur la table ARCHIVE n'est plus     */
/* effectu$$HEX2$$e9002000$$ENDHEX$$maintenant. Voir l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ment SPB_Preparer_Impression.   */
/*------------------------------------------------------------------*/

pb_retour.Enabled = True
pb_interro.Enabled = True
If dw_acc_type_courrier.RowCount () > 0 Then
	If dw_acc_type_courrier.GetSelectedRow ( 0 ) > 0 Then 
		pb_charger.Enabled = True 
	End If
End If

If dw_1.RowCount () > 0 Then
	If dw_1.GetSelectedRow ( 0 ) > 0 Then 
		pb_editer.Enabled = True 
	End If
End If

st_EnCours.Hide ()

stMessage.sTitre = "Fin de traitement"
stMessage.Icon   = information!
stMessage.scode  = "EDIT030"
stMessage.bErreurG= False
f_Message ( stMessage )


Return bOk
end function

public subroutine wf_positionnerobjets ();// ne fait rien
end subroutine

private function boolean wf_departementaveccodebarre (long aliddept);//*-----------------------------------------------------------------
//*
//* Objet			: W_Ae_Sp_ReEdition_Dga
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

public subroutine wf_selectionner (long alrowdeb, long alrowfin);//*-----------------------------------------------------------------
//*
//* Fonction		: W_ae_sp_reedition_dcmp060589::wf_Selectionner			(PRIVATE)
//* Auteur			: FPI
//* Date				: 26/09/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [VDoc12249]
//* Commentaires	: On active la s$$HEX1$$e900$$ENDHEX$$lection des lignes dans dw_1
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long lRow

dw_1.SetRedraw ( FALSE )

dw_1.SelectRow ( 0, FALSE )

For lRow=alRowDeb to alRowFin	
	dw_1.SelectRow ( lRow, TRUE)
next 

dw_1.SetRedraw ( TRUE )

ilNbrDossierSelection = alRowFin - alRowDeb + 1

wf_Actualiser ( ilNbrDossierSelection )

end subroutine

event spb_imprimerdossier;call super::spb_imprimerdossier;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_ReEdition
//* Evenement 		: Spb_ImprimerDossier					(EXTEND)
//* Auteur			: PLJ
//* Date				: 30/10/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ  PAR      Date			Modification
//* #1   FS      	06/02/2002 : Pas de marquage de mise sous pli pour SAVANE
//* #2	DGA		03/09/2006	Modification pour la mise sous pli. [DCMP-060589]
//*-----------------------------------------------------------------

Long		lIdSin, lIdArch, lDocPrincipal, lIdInter, lIdLigne, lIdDept
String	sNomFic, sText, sNom, sIdDocEdt, sIdCompteurPage
Int		iRet, iNbPage
Boolean	bCodeBarre

//On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re la ligne en cours de traitement
lIdLigne		= Message.WordParm

iRet			= 1
lIdInter		= dw_1.GetItemNumber ( lIdLigne, "ID_INTER"	)
lIdArch		= dw_1.GetItemNumber ( lIdLigne, "ID_ARCH" 	)
lIdSin		= dw_1.GetItemNumber ( lIdLigne, "ID_SIN" 	)
sNom			= dw_1.GetItemString ( lIdLigne, "LIB" 		)
lIdDept		= dw_1.GetItemNumber ( lIdLigne, "ID_DEPT"   )

bCodeBarre	= Wf_DepartementAvecCodeBarre ( lIdDept )

/*------------------------------------------------------------------*/
/* On affiche un message dans la MLE pour donner des informations   */
/* sur le dossier en cours de traitement.                           */
/*------------------------------------------------------------------*/
sText = "Dossier : " + String ( lIdSin ) + " Impression du courrier (R$$HEX1$$e900$$ENDHEX$$f Sin " + String ( lIdSin ) + &
		  ", inter " + String ( lIdInter ) + ") adress$$HEX4$$e9002000e0002000$$ENDHEX$$" + sNom + "~r~n"

Mle_Msg.uf_AjouterText ( sText )

/*------------------------------------------------------------------*/
/* Lecture du Blob et $$HEX1$$e900$$ENDHEX$$criture du fichier.                          */
/*------------------------------------------------------------------*/
iRet = wf_Lire_Blob ( lIdArch, lIdSin, lIdInter, sNomFic )

If iRet < 0 Then 
	wf_SetStopTraitement ( TRUE )
	Return
End If

/*------------------------------------------------------------------*/
/* On s'occupe des param$$HEX1$$e800$$ENDHEX$$tres particuliers du courrier. Faut-il     */
/* $$HEX1$$e900$$ENDHEX$$diter le courrier ?. Faut-il sauvegarder le courrier et sous    */
/* quel nom ?. Faut-il mettre les marques de mise sous pli ?.       */
/*------------------------------------------------------------------*/
/* [DCMP-060589]                                                    */
/*------------------------------------------------------------------*/
/* Le 03/09/2006. Modification Mise sous pli.                       */
/* #2. Modif DGA                                                    */
/* Je positionne la valeur du param$$HEX1$$e800$$ENDHEX$$tre MISE SOUS PLI avec          */
/* NouvelleMethode.                                                 */
/*------------------------------------------------------------------*/
/* J'effectue ce test pour que les r$$HEX2$$e900e900$$ENDHEX$$ditions qui ne poss$$HEX1$$e900$$ENDHEX$$dent pas  */
/* de ID_DOC_EDT continuent $$HEX2$$e0002000$$ENDHEX$$fonctionner suivant l'ancienne        */
/* m$$HEX1$$e900$$ENDHEX$$thode.                                                         */
/*------------------------------------------------------------------*/
sIdDocEdt 			= dw_1.GetItemString ( lIdLigne, "ID_DOC_EDT" )
If	IsNull ( sIdDocEdt ) Or Len ( Trim  ( sIdDocEdt ) ) = 0 Or bCodeBarre = False Then
	invEditionCourrier.uf_InscrireParamCourrier ( sNomFic, "0", "O", "N" )  // ... #1 pas de mise sous pli
Else
	invEditionCourrier.uf_InscrireParamCourrier ( sNomFic, "0", "O", "NouvelleMethode" )
	sIdCompteurPage	= String ( ilMsp_Compteur )
	invEditionCourrier.uf_InscrireParamMiseSousPli ( sIdDocEdt, sIdCompteurPage )
End If

//invEditionCourrier.uf_InscrireParamCourrier ( sNomFic, "0", "O", "N" )  // ... #1 pas de mise sous pli
/*------------------------------------------------------------------*/
/* Ouverture du document se trouvant maintenant sur disque.         */
/*------------------------------------------------------------------*/
lDocPrincipal 	= invEditionCourrier.uf_OuvrirDocument_2 ( sNomFic )

/*------------------------------------------------------------------*/
/* Impression du courrier dans un fichier SPOOL, pour l'instant     */
/* rien ne s'$$HEX1$$e900$$ENDHEX$$dite.                                                 */
/* On v$$HEX1$$e900$$ENDHEX$$rifie que l'$$HEX1$$e900$$ENDHEX$$dition se passe bien. Si ce n'est pas le cas,  */
/* on arr$$HEX1$$ea00$$ENDHEX$$te tout.                                                  */
/*------------------------------------------------------------------*/
If	invEditionCourrier.uf_Imprimer ( "EditerCourrierNouvMethode" ) < 0	Then
	wf_SetStopTraitement ( TRUE )
	Return
End If

/*------------------------------------------------------------------*/
/* On referme le document principal 										  */
/*------------------------------------------------------------------*/
invEditionCourrier.uf_FermerDocument ( lDocPrincipal )

/*------------------------------------------------------------------*/
/* [DCMP-060589]                                                    */
/*------------------------------------------------------------------*/
/* Le 03/09/2006. Modification Mise sous pli. #2                    */
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
End If
	
Choose Case ilMsp_Compteur
Case 10 To 19
	ilMsp_Compteur = ilMsp_Compteur - 10
/*------------------------------------------------------------------*/	
/* Modification suite d$$HEX1$$e900$$ENDHEX$$calage du Nbr de pages pour les courriers   */
/* qui font plus de 18 pages.                                       */
/*------------------------------------------------------------------*/	
Case 20 To 29
	ilMsp_Compteur = ilMsp_Compteur - 20
Case 30 To 39
	ilMsp_Compteur = ilMsp_Compteur - 30
End Choose

/*------------------------------------------------------------------*/
/* J'incremente le nombre de courrier qui permettra d'envoyer ou    */
/* non, le fichier spool                                            */
/*------------------------------------------------------------------*/
ilNbCour ++

st_Edit.Text = String ( ilNbCour )
dw_ProgressBar.SetItem ( 1, "Indice", ilNbCour )
dw_ProgressBar.SetRedraw ( True )
st_EnCours.SetRedraw ( True )


If iRet < 0 Then 
	wf_SetStopTraitement ( TRUE )
	Return
End If


/*------------------------------------------------------------------*/
/* On va maintenant enlever les dossiers de la DW d'accueil.        */
/*------------------------------------------------------------------*/
dw_1.RowsDiscard ( lIdLigne, lIdLigne, Primary! )

/*------------------------------------------------------------------*/
/* On affiche un message indiquant que l'$$HEX1$$e900$$ENDHEX$$dition du courrier se     */
/* passe bien.                                                      */
/*------------------------------------------------------------------*/
sText = "Dossier : " + String ( lIdSin ) + " (Inter " + String ( lIdInter ) + ") Impression du courrier " + &
		  "adress$$HEX4$$e9002000e0002000$$ENDHEX$$" + sNom + " (OK) ~r~n" 
Mle_Msg.uf_RemplacerText ( sText )

/*------------------------------------------------------------------*/
/* Suppression du fichier toujours pr$$HEX1$$e900$$ENDHEX$$sent sur disque.              */
/*------------------------------------------------------------------*/
FileDelete ( sNomFic ) 


end event

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_ReEdition
//* Evenement 		: Open					(EXTEND)
//* Auteur			: PLJ
//* Date				: 12/11/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 			FPI	25/09/2015	[PI056]
//*-----------------------------------------------------------------


//dw_Acc_Type_Courrier.SetTransObject ( SqlCa )
dw_1.SetTransObject ( SqlCa )
dw_Acc_Type_Courrier.SetTransObject ( SqlCa )

/*------------------------------------------------------------------*/
/* Description  la fen$$HEX1$$ea00$$ENDHEX$$tre d'interrogation.                         */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche des Travaux"
pb_Interro.istInterro.sDataObject			= "d_int_reedition"
pb_Interro.istInterro.sCodeDw					= "TRAVAUX"

pb_Interro.istInterro.sData[1].sNom			= "id_lot"
pb_Interro.istInterro.sData[1].sDbName		= "sysadm.w_cour_blob_arch.id_lot"
pb_Interro.istInterro.sData[1].sType		= "NUMBER"
pb_Interro.istInterro.sData[1].sOperande	= "="

pb_Interro.istInterro.sData[1].sNom			= "maj_par"
pb_Interro.istInterro.sData[1].sDbName		= "sysadm.w_cour_blob_arch.maj_par"
pb_Interro.istInterro.sData[1].sType		= "STRING"
pb_Interro.istInterro.sData[1].sOperande	= "="

pb_Interro.istInterro.sData[3].sNom			= "id_sin"
pb_Interro.istInterro.sData[3].sDbName		= "sysadm.w_cour_blob_arch.id_sin"
pb_Interro.istInterro.sData[3].sType		= "NUMBER"
pb_Interro.istInterro.sData[3].sOperande	= "="

pb_Interro.istInterro.sData[5].sNom			= "edite_le"
//pb_Interro.istInterro.sData[5].sDbName		= "Convert ( Datetime, Convert ( Varchar(10), sysadm.w_cour_blob_arch.maj_le, 103 ) )"
pb_Interro.istInterro.sData[5].sDbName		= "sysadm.w_cour_blob_arch.edite_le"
pb_Interro.istInterro.sData[5].sType		= "DATETIME" // [PI056] Date-> Datetime
pb_Interro.istInterro.sData[5].sOperande	= "<="


/*-----------------------------------------------------------------*/
/* Preparation de la progresse Barre, l'initialisation est faite   */
/* sur le ue_initialiser                                           */ 
/*-----------------------------------------------------------------*/
dw_ProgressBar.InsertRow ( 0 )
end event

event spb_preparerimpression;call super::spb_preparerimpression;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_ReEdition
//* Evenement 		: spb_PreparerImpression					(EXTEND)
//* Auteur			: PLJ
//* Date				: 30/10/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR      Date			Modification
//* #1	DGA		03/09/2006	Modification pour la mise sous pli. [DCMP-060589]
//*-----------------------------------------------------------------

Boolean 		bOk
String 		sText, sFicIniApp, sVal, sIdDocEdt, sErreur
Long 			lCpt, lTotLig, lLig, lIdLot, lVal, lIdSin, lIdArch, lRet



/*------------------------------------------------------------------*/
/* [DCMP-060589]                                                    */
/*------------------------------------------------------------------*/
/* #1. Le 03/09/2006 Modification DGA.                              */
/* On supprime les lignes non utilis$$HEX1$$e900$$ENDHEX$$es de la DataWindow dw_1.      */
/*------------------------------------------------------------------*/
lTotLig = dw_1.RowCount ()
For	lCpt	 = lTotLig To 1 Step -1
		If	Not dw_1.IsSelected ( lCpt ) Then dw_1.RowsDiscard ( lCpt, lCpt, Primary! )
Next

/*------------------------------------------------------------------*/
/* [DCMP-060589]                                                    */
/*------------------------------------------------------------------*/
/* #1. Le 03/09/2006 Modification DGA.                              */
/* Dans les anc$$HEX1$$ea00$$ENDHEX$$tres, le SORT est r$$HEX1$$e900$$ENDHEX$$initialis$$HEX1$$e900$$ENDHEX$$. Il faut donc le     */
/* positionner manuellement.                                        */
/*------------------------------------------------------------------*/
dw_1.SetSort ( "ID_DOC_EDT A" )
dw_1.Sort ()

/*------------------------------------------------------------------*/
/* [DCMP-060589]                                                    */
/*------------------------------------------------------------------*/
/* #1. Le 03/09/2006 Modification DGA.                              */
/* Ajout d'un N$$HEX2$$b0002000$$ENDHEX$$chrono pour edition chez AOC. On ajoute l'$$HEX1$$e900$$ENDHEX$$dition  */
/* d'une page de garde.                                             */
/*------------------------------------------------------------------*/
dw_pagetitre.Reset ()
Dw_pagetitre.DataObject = "d_trt_sp_ed_pagetitre"
Dw_pagetitre.Reset ()
Dw_pagetitre.InsertRow ( 0 )

lLig = Dw_Acc_Type_Courrier.GetSelectedRow ( 0 )
sVal		= Dw_Acc_Type_Courrier.GetItemString ( lLig, "LIB_CODE" )
lIdLot 	= Dw_Acc_Type_Courrier.GetItemNumber ( lLig, "ID_LOT" )

lVal = Pos ( sVal, "(", 1)
If lVal > 0 Then sVal = Left ( sVal, lVal - 1 )

dw_pagetitre.Modify ( "type_doc_t.text = 'R$$HEX2$$e900e900$$ENDHEX$$dition du'" ) 
Dw_pagetitre.InsertRow ( 0 )
Dw_pagetitre.SetItem ( 1, "TYPE_DOC", "Lot n$$HEX1$$b000$$ENDHEX$$" + String ( lIdLot )  )

Dw_pagetitre.InsertRow ( 0 )
Dw_pagetitre.SetItem ( 2, "TYPE_DOC", sVal ) 
        
Dw_pagetitre.InsertRow ( 0 )
Dw_pagetitre.SetItem ( 3, "TYPE_DOC", String ( dw_1.RowCount () ) + " Courrier(s)" )  
Dw_PageTitre.Object.DataWindow.Print.DocumentName = "R$$HEX1$$e900$$ENDHEX$$dt.-Lot " + String ( lIdLot ) + "-" + sVal
Dw_pagetitre.Print ()

Dw_1.Object.DataWindow.Print.DocumentName = "R$$HEX1$$e900$$ENDHEX$$dt.-Lot " + String ( lIdLot ) + "-Liste dossiers" 
Dw_1.Print ()

sText = "D$$HEX1$$e900$$ENDHEX$$but de l'impression ...~r~n"
Mle_Msg.Uf_AjouterText ( sText )

bOk = True

pb_retour.Enabled = False
pb_interro.Enabled = False
pb_charger.Enabled = False
pb_editer.Enabled = False
st_EnCours.Show ()

/*------------------------------------------------------------------*/
/* Initialisation de la progressbar                                 */
/*------------------------------------------------------------------*/
If bOk Then
	dw_ProgressBar.SetItem ( 1, "INDICE", 0 )
	dw_ProgressBar.SetItem ( 1, "MAXVALUE", wf_GetNbrDossierSelection() )
	dw_ProgressBar.SetRedraw ( TRUE )
End If


/*------------------------------------------------------------*/
/* Affectation de la nouvelle date d'$$HEX1$$e900$$ENDHEX$$dition                  */
/*------------------------------------------------------------*/
If bOk Then 
/*------------------------------------------------------------------*/
/* [DCMP-060589]                                                    */
/*------------------------------------------------------------------*/
/* #1. Le 03/09/2006 Modification DGA.                              */
/* On effectue un UPDATE sur la table ARCHIVE.                      */
/*------------------------------------------------------------------*/
	lTotLig 	= dw_1.RowCount ()

	For lCpt = 1 To lTotLig
	
		If dw_1.IsSelected ( lCpt ) Then 
			sIdDocEdt	= dw_1.GetItemString ( lCpt, "ID_DOC_EDT" )
			lIdSin		= dw_1.GetItemNumber ( lCpt, "ID_SIN" )
			lIdArch		= dw_1.GetItemNumber ( lCpt, "ID_ARCH" )
			sErreur		= Fill ( " ", 50 )

			lRet = SQLCA.PS_U01_MAJ_REEDITION ( lIdSin, lIdArch, sIdDocEdt, sErreur )

			If	lRet = 1 And sErreur = "OK" Then			
				f_Commit ( SQLCA, TRUE )
			Else
				f_Commit ( SQLCA, FALSE )
				stMessage.sTitre = "Gestion des courriers"
		  		stMessage.Icon   = Exclamation!
				stMessage.scode  = "EDIT007"
				stMessage.bErreurG= False
				f_Message ( stMessage )
				bOk = False
				Exit
			End If
		End If
	Next

///*------------------------------------------------------------------*/
///* On positionne la zone DTE_EDIT dans la TABLE W_COUR_BLOB_ARCH.   */
///* Cette zone sera updat$$HEX2$$e9002000$$ENDHEX$$avec un vrai DATETIME. Dans l'edition,    */
///* on effectue l'update avec un DATETIME (mais 00:00:00 au niveau   */
///* du time). Je laisse cette possibilit$$HEX2$$e9002000$$ENDHEX$$qui existe afin de faire   */
///* la diff$$HEX1$$e900$$ENDHEX$$rence entre une EDITION et une REEDITION.                */
///*------------------------------------------------------------------*/
/* La zone DTE_EDIT de la table ARCHIVE sera updat$$HEX2$$e9002000$$ENDHEX$$dans la         */
/* fonction Wf_Archiver.                                            */
/*------------------------------------------------------------------*/
/* On fait comme en PEGASE, on effectue un UPDATE sur la tabel      */
/* ARCHIVE mais pas sur la table W_COUR_BLOB_ARCH                   */
/* Avant, on faisait un UPDATE sur tous les courriers du lot de la  */
/* table W_COUR_BLOB_ARCH et un UPDATE sur la table ARCHIVE.        */
/*------------------------------------------------------------------*/
//	If dw_1.Update () < 0 Then
//		f_Commit ( SQLCA, FALSE )
//		stMessage.sTitre = "Gestion des courriers"
//  		stMessage.Icon   = Exclamation!
//		stMessage.scode  = "EDIT007"
//		stMessage.bErreurG= False
//		f_Message ( stMessage )
//		bOk= False
//	Else
//		f_Commit ( SQLCA, TRUE )
//	End If

End If


/*------------------------------------------------------------------*/
/* On laisse le client s'occuper de mettre $$HEX2$$e0002000$$ENDHEX$$jour la liste          */
/* d'accueil.                                                       */
/*------------------------------------------------------------------*/
If bOk Then
	wf_SetSupprimerLigne ( FALSE )
End If


/*------------------------------------------------------------------*/
/* On arme la variable d'instance qui correspond au fichier         */
/* d'entete des questionnaires. Ce fichier est identique quel que   */
/* soit les questionnaires.                                         */
/*------------------------------------------------------------------*/
If bOk Then
	sFicIniApp			= stGlb.sFichierIni
	isRepCourrier		= ProfileString ( sFicIniApp, "EDITION", "REP_COURRIER", "" )
End If


/*------------------------------------------------------------------*/
/* Je r$$HEX1$$e900$$ENDHEX$$initialise le nombre de courrier edit$$HEX4$$e9002000e0002000$$ENDHEX$$0 pour cette vague */
/* d'impression                                                     */
/*------------------------------------------------------------------*/
If bOk Then	ilNbCour 	= 0


If bOk = False Then
	wf_SetStopTraitement ( TRUE )
End If

/*------------------------------------------------------------------*/
/* [DCMP-060589]                                                    */
/*------------------------------------------------------------------*/
/* Le 03/09/2006. Modification Mise sous pli.                       */
/* #1. Modif DGA.                                                   */
/* Je positionne la valeur d'instance ilMsp_Compteur $$HEX2$$e0002000$$ENDHEX$$0. Ce        */
/* param$$HEX1$$e800$$ENDHEX$$tre sera positionn$$HEX2$$e9002000$$ENDHEX$$dans l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement SPB_ImprimerDossier.  */
/*------------------------------------------------------------------*/
ilMsp_Compteur = 0
end event

event spb_terminerimpression;call super::spb_terminerimpression;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_Edition
//* Evenement 		: Spb_TerminerImpression					(EXTEND)
//* Auteur			: PLJ
//* Date				: 30/10/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String 	sText, sErreur, sMessArchive
Long 		lRet = 1

sText = "Fin de l'impression ...~r~n"
Mle_Msg.Uf_AjouterText ( sText )

/*------------------------------------------------------------------*/
/* On envoie le SPOOL $$HEX2$$e0002000$$ENDHEX$$l'impression.                               */
/* S'il y a eu une erreur lors de la constitution des impression    */
/* on ne l'envoi pas.                                               */
/*------------------------------------------------------------------*/

If wf_GetStopTraitement () Then
	Return
End If


If ilNbCour > 0 Then

	sText = "Envoi du fichier SPOOL ...      ~r~n"
	Mle_Msg.Uf_AjouterText ( sText )
	

	lRet = invEditionCourrier.uf_EnvoyerImpressionAuSpool ()
									  
	If	lRet = 1	Then
		sText = "Envoi du fichier SPOOL ... (OK) ~r~n" 
	Else
		sText = "Envoi du fichier SPOOL ... (Probl$$HEX1$$e800$$ENDHEX$$me " + String ( lRet ) + " ) " + sErreur + "~r~n"
	End If
	
	Mle_Msg.Uf_RemplacerText ( sText )
	
	
	/*------------------------------------------------------------------*/
	/* Si la session d'impression se termine bien :                     */
	/*		- on d$$HEX1$$e900$$ENDHEX$$truit l'objet OLE                                      */
	/*		- on supprime le fichier INI de communication                 */
	/*------------------------------------------------------------------*/
	If	Not wf_GetStopTraitement () And lRet = 1 Then
		invEditionCourrier.uf_TerminerSession ()
	End If
	

	If wf_Archiver ( sMessArchive ) = False Then

		sText = "Erreur lors de l'archivage : " + sMessArchive
		Mle_Msg.uf_RemplacerText ( sText )
		wf_SetStopTraitement     ( TRUE  )

		/*---------------------------------------------------------------*/
		/* Important en cas d'erreur le service informatique doit $$HEX1$$ea00$$ENDHEX$$tre   */
      /* pr$$HEX1$$e900$$ENDHEX$$venu.                                                      */
		/*---------------------------------------------------------------*/
		stMessage.sTitre  = "Gestion des courriers"
		stMessage.sVar[1] = String ( dw_acc_type_courrier.GetItemNumber ( ilnbselect, "ID_LOT" ) )
   	stMessage.Icon    = StopSign!
		stMessage.scode   = "EDIT008"
		stMessage.bErreurG= False
		f_Message ( stMessage )
		Return

	End If

End If
end event

event ue_fin_interro;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_ReEdition (OverRide)
//* Evenement 		: ue_fin_interro
//* Auteur			: PLJ
//* Date				: 12/11/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

/*-----------------------------------------------------------------------------------------*/
/* Si tous les crit$$HEX1$$e800$$ENDHEX$$res sont d'interrogations sont nulls alors on n'envoie pas de retrieve */
/*-----------------------------------------------------------------------------------------*/

If Not ( isNull ( isMajPar ) AND isNull ( ilIdSin ) AND isNull ( idEditeLe ) AND isNull ( ilIdLot ) ) Then
	dw_Acc_Type_Courrier.Retrieve ( isMajPar, ilIdSin, Datetime(Date(idEditeLe)) , ilIdLot )
	dw_1.Reset ()
	ilNbSelect = 0
	pb_charger.Enabled	= False
	pb_editer.Enabled 	= False
	dw_ProgressBar.SetItem ( 1, "INDICE", 0 )
	dw_ProgressBar.SetItem ( 1, "MAXVALUE", 0 )
	dw_ProgressBar.SetRedraw ( TRUE )
End If
end event

event ue_fermer_interro;call super::ue_fermer_interro;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_ReEdition
//* Evenement 		: ue_fermer_interro					(EXTEND)
//* Auteur			: PLJ
//* Date				: 12/11/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 			FPI	25/09/2015	[PI056]
//*-----------------------------------------------------------------


/*-------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des crit$$HEX1$$e800$$ENDHEX$$res d'interrogation       */
/*-------------------------------------------------*/

isMajPar		= w_interro.dw_1.GetItemString ( 1, "MAJ_PAR"  )
ilIdSin		= w_interro.dw_1.GetItemNumber ( 1, "ID_SIN"   )
idEditeLe	= w_interro.dw_1.GetItemDateTime   ( 1, "EDITE_LE" ) // [PI056] GetItemDate -> GetItemDateTime
ilIdLot		= w_interro.dw_1.GetItemNumber ( 1, "ID_LOT"   )
end event

on w_ae_sp_reedition_dcmp060589.create
int iCurrent
call super::create
this.pb_charger=create pb_charger
this.st_charger=create st_charger
this.dw_progressbar=create dw_progressbar
this.dw_pagetitre=create dw_pagetitre
this.st_encours=create st_encours
this.dw_acc_type_courrier=create dw_acc_type_courrier
this.cb_partiel_haut=create cb_partiel_haut
this.cb_partiel_bas=create cb_partiel_bas
this.cb_partiel=create cb_partiel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_charger
this.Control[iCurrent+2]=this.st_charger
this.Control[iCurrent+3]=this.dw_progressbar
this.Control[iCurrent+4]=this.dw_pagetitre
this.Control[iCurrent+5]=this.st_encours
this.Control[iCurrent+6]=this.dw_acc_type_courrier
this.Control[iCurrent+7]=this.cb_partiel_haut
this.Control[iCurrent+8]=this.cb_partiel_bas
this.Control[iCurrent+9]=this.cb_partiel
end on

on w_ae_sp_reedition_dcmp060589.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_charger)
destroy(this.st_charger)
destroy(this.dw_progressbar)
destroy(this.dw_pagetitre)
destroy(this.st_encours)
destroy(this.dw_acc_type_courrier)
destroy(this.cb_partiel_haut)
destroy(this.cb_partiel_bas)
destroy(this.cb_partiel)
end on

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_ReEdition
//* Evenement 		: ue_initialiser					(EXTEND)
//* Auteur			: PLJ
//* Date				: 30/10/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1	DGA	03/09/2006	Modification pour la mise sous pli. [DCMP-060589]
//* 
//*-----------------------------------------------------------------

String sListeDept

This.Title = "R$$HEX1$$e900$$ENDHEX$$Editions centralis$$HEX1$$e900$$ENDHEX$$es SIMPA2"

/*------------------------------------------------------------------*/
/* On arme un tableau d'instance qui correspond $$HEX2$$e0002000$$ENDHEX$$la liste des      */
/* d$$HEX1$$e900$$ENDHEX$$partements pour lequels il faut positionner le code barre sur  */
/* le courrier.                                                     */
/*------------------------------------------------------------------*/
sListeDept = ProfileString ( stGLB.sFichierIni, "EDITION", "CODE_BARRE_DEPT", "" )
If	sListeDept <> ""	Then
	F_DecomposerChaine ( sListeDept, "-", isCodeBarreDept[] )
End If




end event

type cb_debug from w_accueil_edition_2000`cb_debug within w_ae_sp_reedition_dcmp060589
end type

type pb_retour from w_accueil_edition_2000`pb_retour within w_ae_sp_reedition_dcmp060589
integer width = 242
integer height = 144
end type

type pb_interro from w_accueil_edition_2000`pb_interro within w_ae_sp_reedition_dcmp060589
integer width = 242
integer height = 144
end type

type pb_creer from w_accueil_edition_2000`pb_creer within w_ae_sp_reedition_dcmp060589
end type

type dw_1 from w_accueil_edition_2000`dw_1 within w_ae_sp_reedition_dcmp060589
boolean visible = true
integer x = 9
integer y = 1036
integer width = 3506
integer height = 720
string dataobject = "d_acc_liste_courrier_reedition_v01"
end type

event dw_1::retrievestart;call super::retrievestart;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_Edition::dw_1
//* Evenement 		: RetrieveStart
//* Auteur			: PLJ
//* Date				: 30/10/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

// Pour Retrieves Successifs.
//Migration PB8-WYNIWYG-03/2006 FM
//SetActionCode ( 2 )
Return 2
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::constructor;call super::constructor;ilMaxLig=75 // [VDOC12249]
end event

type pb_tri from w_accueil_edition_2000`pb_tri within w_ae_sp_reedition_dcmp060589
boolean visible = false
integer x = 3154
integer y = 172
integer taborder = 90
boolean enabled = false
end type

type pb_imprimer from w_accueil_edition_2000`pb_imprimer within w_ae_sp_reedition_dcmp060589
end type

type cb_tout from w_accueil_edition_2000`cb_tout within w_ae_sp_reedition_dcmp060589
integer x = 521
integer y = 836
integer width = 265
integer height = 96
end type

type cb_aucun from w_accueil_edition_2000`cb_aucun within w_ae_sp_reedition_dcmp060589
integer x = 521
integer y = 932
integer width = 265
integer height = 96
end type

type st_1 from w_accueil_edition_2000`st_1 within w_ae_sp_reedition_dcmp060589
integer x = 1422
integer y = 864
integer width = 462
integer height = 76
string text = "Nb dossiers $$HEX2$$e0002000$$ENDHEX$$traiter"
end type

type st_2 from w_accueil_edition_2000`st_2 within w_ae_sp_reedition_dcmp060589
integer x = 2322
integer y = 864
integer width = 411
integer height = 76
string text = "Nb dossiers $$HEX1$$e900$$ENDHEX$$dit$$HEX1$$e900$$ENDHEX$$s"
alignment alignment = left!
end type

type st_nombre from w_accueil_edition_2000`st_nombre within w_ae_sp_reedition_dcmp060589
integer x = 1906
integer y = 864
integer width = 334
integer height = 76
end type

type st_edit from w_accueil_edition_2000`st_edit within w_ae_sp_reedition_dcmp060589
integer x = 2757
integer y = 864
integer width = 334
integer height = 76
end type

type mle_msg from w_accueil_edition_2000`mle_msg within w_ae_sp_reedition_dcmp060589
integer x = 9
integer y = 460
integer width = 3506
integer height = 364
integer textsize = -8
fontcharset fontcharset = ansi!
end type

type pb_editer from w_accueil_edition_2000`pb_editer within w_ae_sp_reedition_dcmp060589
integer x = 265
integer y = 864
boolean enabled = false
boolean originalsize = false
string disabledname = "k:\pb4obj\bmp\word_off.bmp"
end type

type pb_charger from picturebutton within w_ae_sp_reedition_dcmp060589
integer x = 9
integer y = 864
integer width = 242
integer height = 144
integer taborder = 80
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Charger"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\comp_on.bmp"
string disabledname = "k:\pb4obj\bmp\comp_off.bmp"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_ReEdition::pb_Charger
//* Evenement 		: Clicked					(EXTEND)
//* Auteur			: PLJ
//* Date				: 14/11/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR      Date			Modification
//* #1	DGA		03/09/2006	Modification pour la mise sous pli
//*-----------------------------------------------------------------

Long 		lTot, lCpt, lIdLot


st_Charger.Visible = True

lTot = dw_acc_type_courrier.RowCount ()
dw_1.Reset ()
dw_ProgressBar.SetItem ( 1, "INDICE", 0 )
dw_ProgressBar.SetItem ( 1, "MAXVALUE", 0 )
dw_ProgressBar.SetRedraw ( TRUE )

For lCpt = 1 To lTot

	If dw_acc_type_courrier.GetItemString ( lCpt, "ALT_SELECT" ) = 'O' Then
		lIdLot	= dw_acc_type_courrier.GetItemNumber ( lCpt, "ID_LOT" ) 
		dw_1.SetRedraw ( False )
		dw_1.Retrieve ( lIdLot )
/*------------------------------------------------------------------*/
/* #1. Le 03/09/2006 Modification DGA.                              */
/* Dans les anc$$HEX1$$ea00$$ENDHEX$$tres, le SORT est r$$HEX1$$e900$$ENDHEX$$initialis$$HEX1$$e900$$ENDHEX$$. Il faut donc le     */
/* positionner manuellement.                                        */
/*------------------------------------------------------------------*/
		dw_1.SetSort ( "ID_DOC_EDT A" )
		dw_1.Sort ()
		dw_1.SetRedraw ( True )
	End If

Next

pb_editer.Enabled  = False
st_Charger.Visible = False

SetPointer ( Arrow! )
end event

type st_charger from statictext within w_ae_sp_reedition_dcmp060589
boolean visible = false
integer x = 1239
integer y = 1392
integer width = 933
integer height = 100
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 14005600
boolean enabled = false
string text = "Chargement en cours ..."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_progressbar from datawindow within w_ae_sp_reedition_dcmp060589
integer x = 1426
integer y = 944
integer width = 1678
integer height = 72
boolean bringtotop = true
string dataobject = "d_trt_progressbar"
boolean border = false
boolean livescroll = true
end type

type dw_pagetitre from datawindow within w_ae_sp_reedition_dcmp060589
boolean visible = false
integer x = 3131
integer y = 12
integer width = 293
integer height = 152
boolean bringtotop = true
boolean enabled = false
string title = "none"
boolean livescroll = true
end type

type st_encours from statictext within w_ae_sp_reedition_dcmp060589
boolean visible = false
integer x = 27
integer y = 168
integer width = 928
integer height = 280
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Veuillez patienter, Traitement en cours..."
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_acc_type_courrier from datawindow within w_ae_sp_reedition_dcmp060589
integer x = 974
integer y = 20
integer width = 2382
integer height = 420
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_acc_type_courrier_reedition_v01"
boolean vscrollbar = true
boolean livescroll = true
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_ReEdition::dw_Acc_Type_Courrier
//* Evenement 		: Clicked
//* Auteur			: PLJ
//* Date				: 13/11/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------


Long		lLigne, lTot, lCpt


// r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de la ligne courante

lLigne = This.GetClickedRow () 
lTot   = This.RowCount ()


/*----------------------------------------------------------------*/
/* Ce code comment$$HEX2$$e9002000$$ENDHEX$$est utile $$HEX2$$e0002000$$ENDHEX$$la multiselection, pour le moment */
/* on g$$HEX1$$e800$$ENDHEX$$re la s$$HEX1$$e900$$ENDHEX$$lection d'une seule ligne.                        */
/*----------------------------------------------------------------*/

//If lLigne = 0 Then										
//
//   this.SelectRow ( lLigne, False )
//	For lCpt = 1 To lTot
//		this.SetItem   ( lCpt, "Alt_Select", 'N' )
//	Next
//
//	ilNbSelect = 0
//
//Else
//
//	If this.IsSelected ( lLigne ) Then
//		this.SelectRow ( lLigne, False )
//		this.SetItem   ( lLigne, "Alt_Select", 'N' )
//		ilNbSelect --
//	Else
//		this.SelectRow ( lLigne, True )
//		this.SetItem   ( lLigne, "Alt_Select", 'O' )
//		ilNbSelect ++
//	End IF
//
//End If

/*------------------------------------------------------------------*/
/* S$$HEX1$$e900$$ENDHEX$$lection de la ligne cliqu$$HEX1$$e900$$ENDHEX$$e                                    */
/* Dans ce cas je me sert ilNbSelect pour stocker cette ligne       */ 
/* Ceci me sera utile au niveau de l'archivage pour r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer id_lot*/
/*------------------------------------------------------------------*/
If lLigne > 0 Then
	this.SelectRow ( 0, False )
	For lCpt = 1 To lTot
		this.SetItem   ( lCpt, "Alt_Select", 'N' )
	Next

	this.SelectRow ( lLigne, True )
	this.SetItem   ( lLigne, "Alt_Select", 'O' )

	ilNbSelect = lLigne

	If ilNbSelect > 0 Then pb_charger.Enabled = True Else pb_charger.Enabled = False

End If


/*------------------------------------------------------------------------*/
/* Je dois effacer le contenu de dw_1.                                    */
/* On vient de cliquer sur une ligne de dw_Acc_Type_Courrier.             */
/* Donc les lignes s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es de dw_Acc_Type_Courrier ne correspondent */
/* plus aux lignes de dw_1 ayant pu $$HEX1$$ea00$$ENDHEX$$tre charg$$HEX1$$e900$$ENDHEX$$es pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$demment.           */
/* On doit imp$$HEX1$$e900$$ENDHEX$$rativement avoir la correspondance pour la fonction        */
/* wf_affecter_lot, qui v$$HEX1$$e900$$ENDHEX$$rifie qu'il n'y a pas eu de maj de courriers    */
/* entre le chargement et l'$$HEX1$$e900$$ENDHEX$$dition des courriers.                        */
/*------------------------------------------------------------------------*/
dw_1.Reset ()
pb_editer.Enabled = False
end on

type cb_partiel_haut from commandbutton within w_ae_sp_reedition_dcmp060589
integer x = 818
integer y = 836
integer width = 379
integer height = 68
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Partiel Haut"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_sp_reedition_dcmp060589::cb_partiel_haut
//* Evenement 		: Clicked
//* Auteur			: FPI
//* Date				: 26/09/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [VDoc12249]
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Long
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------
Long lRow, lRow1, lTotRow

lTotRow = Dw_1.RowCount()

lRow = Dw_1.GetSelectedRow (0)
If lRow <= 0 Then Return

lRow1 = Dw_1.GetSelectedRow ( lRow )	
If lRow1 > 0 Then Return

wf_selectionner( 1,lRow )

end event

type cb_partiel_bas from commandbutton within w_ae_sp_reedition_dcmp060589
integer x = 818
integer y = 900
integer width = 379
integer height = 68
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Partiel Bas"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_sp_reedition_dcmp060589::cb_partiel_bas
//* Evenement 		: Clicked
//* Auteur			: FPI
//* Date				: 26/09/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [VDoc12249]
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Long
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------
Long lRow, lRow1, lTotRow

lTotRow = Dw_1.RowCount()

lRow = Dw_1.GetSelectedRow (0)
If lRow <= 0 Then Return

lRow1 = Dw_1.GetSelectedRow ( lRow )	
If lRow1 > 0 Then Return

wf_selectionner( lRow, lTotRow )
end event

type cb_partiel from commandbutton within w_ae_sp_reedition_dcmp060589
integer x = 818
integer y = 964
integer width = 379
integer height = 68
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Partiel Haut/bas"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_sp_reedition_dcmp060589::cb_partiel_haut_bas
//* Evenement 		: Clicked
//* Auteur			: FPI
//* Date				: 26/09/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [VDoc12249]
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Long
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------
Long lRow, lRow1, lTotRow, lCpt, lRowSav

lTotRow = Dw_1.RowCount()

lRow = Dw_1.GetSelectedRow (0)
If lRow <= 0 Then Return

lRowSav = 0
For lCpt = lRow To lTotRow 
	lRow1 = Dw_1.GetSelectedRow ( lCpt )	
	If lRow1 > 0 Then lRowSav = lRow1
Next
lRow1 = lRowSav

If lRow1 <= 0 Then lRow1 = lTotRow


wf_selectionner( lRow, lRow1)
end event

