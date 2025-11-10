HA$PBExportHeader$w_ae_sp_edition_dcmp060589.srw
$PBExportComments$Fen$$HEX1$$ea00$$ENDHEX$$tre des $$HEX1$$e900$$ENDHEX$$ditions SVE.~r~nPrise en compte du N$$HEX2$$b0002000$$ENDHEX$$Chrono
forward
global type w_ae_sp_edition_dcmp060589 from w_accueil_edition_2000
end type
type pb_charger from picturebutton within w_ae_sp_edition_dcmp060589
end type
type st_charger from statictext within w_ae_sp_edition_dcmp060589
end type
type st_lot from statictext within w_ae_sp_edition_dcmp060589
end type
type st_4 from statictext within w_ae_sp_edition_dcmp060589
end type
type dw_acc_type_courrier from datawindow within w_ae_sp_edition_dcmp060589
end type
type dw_progressbar from datawindow within w_ae_sp_edition_dcmp060589
end type
type dw_pagetitre from datawindow within w_ae_sp_edition_dcmp060589
end type
type st_encours from statictext within w_ae_sp_edition_dcmp060589
end type
type cb_partiel_haut from commandbutton within w_ae_sp_edition_dcmp060589
end type
type cb_partiel_bas from commandbutton within w_ae_sp_edition_dcmp060589
end type
type cb_partiel from commandbutton within w_ae_sp_edition_dcmp060589
end type
type cb_chargertout from commandbutton within w_ae_sp_edition_dcmp060589
end type
end forward

global type w_ae_sp_edition_dcmp060589 from w_accueil_edition_2000
integer width = 5079
integer height = 2440
event ue_saisieautomatique pbm_custom04
pb_charger pb_charger
st_charger st_charger
st_lot st_lot
st_4 st_4
dw_acc_type_courrier dw_acc_type_courrier
dw_progressbar dw_progressbar
dw_pagetitre dw_pagetitre
st_encours st_encours
cb_partiel_haut cb_partiel_haut
cb_partiel_bas cb_partiel_bas
cb_partiel cb_partiel
cb_chargertout cb_chargertout
end type
global w_ae_sp_edition_dcmp060589 w_ae_sp_edition_dcmp060589

type variables
String	isMajPar
Long		ilIdSin, ilIdProdInterro, ilIdDept
DateTime		idMajLe

String	isDateTime
String	isRepCourrier

Long		ilNbCour
Long		ilNbSelect

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
public function integer wf_lire_blob (long alidarch, long alidsin, long alidinter, ref string asnomfic)
public function boolean wf_ecrire_fichier (string as_filename, blob ablb_data, boolean ab_append)
public subroutine wf_positionnerobjets ()
private function boolean wf_purger ()
private function boolean wf_affecter_lot ()
private function boolean wf_archiver (ref string asmess)
private function boolean wf_departementaveccodebarre (long aliddept)
protected subroutine wf_selectionner (long alrowdeb, long alrowfin)
public function boolean wf_verifecrexternalisation ()
end prototypes

on ue_saisieautomatique;call w_accueil_edition_2000::ue_saisieautomatique;//*-----------------------------------------------------------------
//*
//* Objet			: Fen d'acc Edt
//* Evenement 		: ue_SaisieAutomatique
//* Auteur			: FABRY JF
//* Date				: 14/04/2004 14:02:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Overture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil d'edition
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

pb_Interro.TriggerEvent ("clicked")

end on

public function integer wf_lire_blob (long alidarch, long alidsin, long alidinter, ref string asnomfic);//*-----------------------------------------------------------------
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
sRep	  = stGLB.sRepTempo + String ( alIdSin, "0000000000" ) // [PI062]

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
If Len ( blBlob ) <= 0 Or IsNull ( blBlob )  Then 

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
		stMessage.sVar[1] = stGLB.sWinDir + "\TEMP\"
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

public function boolean wf_ecrire_fichier (string as_filename, blob ablb_data, boolean ab_append);//*-----------------------------------------------------------------
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

public subroutine wf_positionnerobjets ();// Ne fait rien
end subroutine

private function boolean wf_purger ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_purger
//* Auteur			: PLJ
//* Date				: 24/10/2001 11:31:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Purge glissante
//* Commentaires	: 
//*
//* Retourne		:	boolean
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Boolean			bRet
Date				dDteMax
Long 				lDelai
String			sUnt, sSQL


bRet = True

/*------------------------------------------------------------------*/
/* Purge des anciens courriers.                                     */
/* - S'il n'y a pas de d$$HEX1$$e900$$ENDHEX$$lai au niveau du fichier INI               */
/*   on prends 6 mois                                               */
/* - Sinon on applique le d$$HEX1$$e900$$ENDHEX$$lai pr$$HEX1$$e900$$ENDHEX$$sent dans le fichier INI         */
/*------------------------------------------------------------------*/

sUnt = ProfileString ( stGlb.sFichierIni, "EDITION", "DELAI_PURGE", "" )
	
If sUnt = "" Then
	stMessage.sTitre = "Gestion des courriers"
	stMessage.sVar[1] = "6 mois"
   stMessage.Icon   = Information!
	stMessage.scode  = "EDIT003"
	stMessage.bErreurG= False
	f_Message ( stMessage )

	sUnt 	 = "M"
	lDelai = 6
Else
	lDelai = Long ( Left ( sUnt, Len ( sUnt ) - 1 ) )
	sUnt	 = Upper ( Right ( sUnt, 1 ) )
End If
	
/*---------------------------------*/
/* Le d$$HEX1$$e900$$ENDHEX$$lai est valide.            */
/*---------------------------------*/
If IsNumber ( String ( lDelai ) ) And lDelai > 0 And ( sUnt = "M" Or sUnt = "J" Or sUnt = "A" ) Then

	dDteMax = Today ()
	dDteMax = f_Plus_Date ( dDteMax, lDelai * (-1), sUnt )

	If IsDate ( String ( dDteMax ) ) And Not IsNull ( dDteMax ) And dDteMax <> 1900-01-01 Then

		sSql = "EXEC sysadm.PS_D01_W_COUR_BLOB_ARCH '" + String ( dDteMax, "dd/mm/yyyy" ) + " 23:59:59'"
		F_Execute ( sSQL, SQLCA )
			
		If SQLCA.SQLCode <> 0 Or SQLCA.SQLDBCode <> 0 Then
			bRet = False
			f_Commit ( SQLCA, False )
		Else
			f_Commit ( SQLCA, True )
		End If
		
	/*------------------------*/
	/* Date invalide.         */
	/*--------------- --------*/
	Else			
		bRet = False
	End If	

/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$lai non valide.                                                */
/*------------------------------------------------------------------*/
Else
		bRet = False
End If


If bRet = False Then 
	stMessage.sTitre = "Gestion des courriers"
   stMessage.Icon   = StopSign!
	stMessage.scode  = "EDIT004"
	stMessage.bErreurG= False
	f_Message ( stMessage )
End If

Return bRet
end function

private function boolean wf_affecter_lot ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_affecter_lot
//* Auteur			: PLJ
//* Date				: 24/10/2001 11:31:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 	 
//*
//* Retourne		: Boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	JFF      07/04/2006 Migration PB8-SPB-04/2006 - On laisse sMarPar $$HEX2$$e0002000$$ENDHEX$$null 
//*								  pour le bon fonctionnement de la requ$$HEX1$$ea00$$ENDHEX$$te derri$$HEX1$$e800$$ENDHEX$$re.
//* #2	DGA		03/09/2006	Gestion de la nouvelle mise sous pli. Avec N$$HEX3$$b0002000e900$$ENDHEX$$ditique. [DCMP-060589]
//*-----------------------------------------------------------------

Long		lIdLot, lCpt, lTotLig, lNbTrouve, lNbTrouveTot, lLig, lVal, lIdSin
Date		dNow
DateTime	dtMaxMajLe
long		lIdTypDoc

String	sMajPar, sVal

Boolean	bOk

bOk = True

/*------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du prochain ID_LOT                            */
/* On ne fait pas tout de suite le commit                     */
/* Il se fera $$HEX2$$e0002000$$ENDHEX$$la fin de cette fonction une fois OK          */
/*------------------------------------------------------------*/
SQLCA.PS_X_INCREMENTER ( "ID_LOT_EDT", lIdLot )
	
If SQLCA.SQLCODE <> 0 Or SQLCA.SQLDBCODE <> 0 Or IsNull ( lIdLot ) Or lIdLot <= 0 Then 

		f_Commit ( SQLCA, FALSE )

		stMessage.sTitre = "Gestion des courriers"
   	stMessage.Icon   = StopSign!
		stMessage.scode  = "EDIT001"
		stMessage.bErreurG= False
		f_Message ( stMessage )

		bOk = False
End IF

// [ITSM178659]
If SQLCA.SQLCODE = 0 And SQLCA.SQLDBCODE = 0 And Not IsNull ( lIdLot ) And lIdLot > 0 Then
	F_COMMIT ( SQLCA, TRUE  ) 
End If

/*------------------------------------------------------------*/
/* Affectation de l'ID_LOT et Date Edition                    */
/*------------------------------------------------------------*/
If bOk Then 
	lTotLig 	= dw_1.RowCount ()
	dNow 		= Today ()
	For lCpt = 1 To lTotLig
		If dw_1.IsSelected ( lCpt ) Then 
			dw_1.SetItem ( lCpt, "ID_LOT", 	lIdLot 	)
			dw_1.SetItem ( lCpt, "DTE_EDIT", dNow 		)
		End If
	Next
End If

/*------------------------------------------------------------------*/
/* Depuis le dernier retrieve est-ce qu'il y a eu des               */
/* enregistrements de mis $$HEX2$$e0002000$$ENDHEX$$jour par une autre personne             */
/* Les lignes de dw_1 correspondent au chargement des lignes        */
/* s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$s dw_acc_type_courrier                                */
/* Pour chaque ligne de dw_Acc_Type_courrier, il suffit de v$$HEX1$$e900$$ENDHEX$$rifier */
/* qu'il n'y a pas moins de ligne par rapport au moment du          */
/* chargement                                                       */ 
/*------------------------------------------------------------------*/
If bOK Then

	lTotLig = dw_Acc_Type_courrier.RowCount ()
	lNbTrouveTot = 0

	sMajPar 	= ismajpar 
	lIdSin	= ilidsin

	If isNull ( lIdSin  ) Then lIdSin  = 0
//	If isNull ( sMajPar ) Then sMajPar = ''  #1

	/*---------------------------------------------------------------*/
   /* On recompte le nombre total de dossiers que l'on doit trouver */
	/*---------------------------------------------------------------*/
	For lCpt = 1 To lTotLig
		If dw_Acc_Type_courrier.IsSelected ( lCpt ) Then
			lNbTrouve = 0
			dtMaxMajLe =dw_Acc_Type_courrier.GetItemDateTime ( lCpt, "MAX_MAJ_LE" )
			lIdTypDoc  = dw_Acc_Type_courrier.GetItemNumber   ( lCpt, "ID_TYP_DOC" )

			SQLCA.PS_S01_W_COUR_BLOB_ARCH ( 	smajpar, lidsin, dtMaxMajLe, lIdTypDoc, lNbTrouve )
			lnbTrouveTot += lNbTrouve
		End If		
	Next

											  
	If lNbTrouveTot < Dw_1.RowCount () Then
/*------------------------------------------------------------------*/
/* #2. Je corrige un BUG qui existait auparavant. J'effectue le     */
/* ROLLBACK imm$$HEX1$$e900$$ENDHEX$$diatement.                                          */
/*------------------------------------------------------------------*/
/* [DCMP-060589]                                                    */
/*------------------------------------------------------------------*/
		f_Commit ( SQLCA, FALSE )

		stMessage.sTitre = "Gestion des courriers"
   	stMessage.Icon   = Exclamation!
		stMessage.scode  = "EDIT002"
		stMessage.bErreurG= False
		f_Message ( stMessage )

		dw_1.Reset ()
		bOk = False
	End If
End If

/*------------------------------------------------------------------*/
/* Update de dw_1                                                   */
/*------------------------------------------------------------------*/
/* [DCMP-060589]                                                    */
/*------------------------------------------------------------------*/
/* Le 03/09/2006. Modification Mise sous pli.                       */
/* #2. DGA                                                          */
/* Mise $$HEX2$$e0002000$$ENDHEX$$jour en base du N$$HEX2$$b0002000$$ENDHEX$$de lot, et de la date d'$$HEX1$$e900$$ENDHEX$$dition sur    */
/* tous les enregistrements                                         */
/*------------------------------------------------------------------*/
/* Utilisation de la proc$$HEX1$$e900$$ENDHEX$$dure stock$$HEX1$$e900$$ENDHEX$$e PS_U01_MAJ_ID_DOC_EDT sur    */
/* le SqlPreview de la DW.                                          */
/*------------------------------------------------------------------*/
If bOk Then
	If	dw_1.Update ( TRUE, FALSE ) > 0	Then
/*------------------------------------------------------------------*/
/* Commit ou Rollback de ID_LOT, DTE_EDIT et ID_DOC_EDT.            */
/*------------------------------------------------------------------*/
		f_Commit ( SQLCA, TRUE )
	Else
		f_Commit ( SQLCA, FALSE )
		bOk= False
	End If
End If

/*------------------------------------------------------------------*/
/* Maj Zone de texte                                                */
/*------------------------------------------------------------------*/
If bOk Then
	st_Lot.Text = String ( lIdLot )
End If

/*------------------------------------------------------------------*/
/* On supprime les lignes non utilis$$HEX1$$e900$$ENDHEX$$es de la DataWindow dw_1.      */
/*------------------------------------------------------------------*/
lTotLig = dw_1.RowCount ()
For	lCpt	 = lTotLig To 1 Step -1
		If	Not dw_1.IsSelected ( lCpt ) Then dw_1.RowsDiscard ( lCpt, lCpt, Primary! )
Next

/*------------------------------------------------------------------*/
/* #2. Le 03/09/2006 Modification DGA.                              */
/* Ajout d'un N$$HEX2$$b0002000$$ENDHEX$$chrono pour edition chez AOC. On ajoute l'$$HEX1$$e900$$ENDHEX$$dition  */
/* d'une page de garde.                                             */
/*------------------------------------------------------------------*/
/* [DCMP-060589]                                                    */
/*------------------------------------------------------------------*/

Dw_pagetitre.DataObject = "d_trt_sp_ed_pagetitre"
Dw_pagetitre.Reset ()
Dw_pagetitre.InsertRow ( 0 )

lLig = Dw_Acc_Type_Courrier.GetSelectedRow ( 0 )
sVal = Dw_Acc_Type_Courrier.GetItemString ( lLig, "LIB_CODE" )
lVal = Pos ( sVal, "(", 1)
If lVal > 0 Then sVal = Left ( sVal, lVal - 1 )
Dw_pagetitre.SetItem ( 1, "TYPE_DOC", sVal )  
         
Dw_pagetitre.InsertRow ( 0 )
Dw_pagetitre.SetItem ( 2, "TYPE_DOC", "Lot n$$HEX1$$b000$$ENDHEX$$" + String ( lIdLot )  )
        
Dw_pagetitre.InsertRow ( 0 )
Dw_pagetitre.SetItem ( 3, "TYPE_DOC", String ( dw_1.RowCount () ) + " Courrier(s)" )  
Dw_PageTitre.Object.DataWindow.Print.DocumentName = "Edt.-Lot " + String ( lIdLot ) + "-" + sVal
Dw_pagetitre.Print ()

Dw_1.Object.DataWindow.Print.DocumentName = "Edt.-Lot " + String ( lIdLot ) + "-Liste dossiers" 
Dw_1.Print ()

Return bOk
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
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------


Boolean 	bOk 
Long		lRet, lIdLot

bOk = True


/*------------------------------------------------------------------*/
/* Mise $$HEX2$$e0002000$$ENDHEX$$jour sur archive du lot                                   */
/*------------------------------------------------------------------*/
asMess = Space (60)
lIdLot = long ( st_lot.Text )
lRet = SQLCA.PS_I02_ARCHIVE_BLOB_VAL( lIdLot, asMess )

If lRet <> 0 Or SQLCA.SQLCODE <> 0 Or SQLCA.SQLDBCODE <> 0 Then 
	bOk = False
End If

f_Commit (SqlCa, bOk )

/*------------------------------------------------------------------*/
/* On remet $$HEX2$$e0002000$$ENDHEX$$jour la petite liste indiquant le nombre de courrier. */
/*------------------------------------------------------------------*/
// CAG 05/08/2004 : ilIdProd est utilis$$HEX2$$e9002000$$ENDHEX$$dans w_accueil_edition_2000
If ilIdProdInterro <= 0 Then SetNull ( ilIdProdInterro )
dw_acc_type_courrier.Retrieve ( isMajPar, ilIdSin,  idMajLe, ilIdProdInterro, ilIdDept  )

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

// [OPTIM_MENU_EDT]
Mle_Msg.Uf_AjouterText ( "Fin de l'$$HEX1$$e900$$ENDHEX$$dition et archivage.~r~n" )

Return bOk
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

protected subroutine wf_selectionner (long alrowdeb, long alrowfin);//*-----------------------------------------------------------------
//*
//* Fonction		: W_ae_sp_edition_dcmp060589::wf_Selectionner			(PRIVATE)
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

public function boolean wf_verifecrexternalisation ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_VerifEcrExternalisation
//* Auteur			: JFF
//* Date				: 06/03/2020 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PM425]
//* Commentaires	: 
//*
//	Returns:			Boolean
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

DataStore Ds
Long lTot, lCpt
Int  iiFicTrc, iWrite, iRet
String sChem, sChemRep, sMes
Boolean bFileDelete

iRet = 1

ds = Create DataStore
ds.dataobject = "d_trt_chemin_extern_edition"
ds.setTransObject (SQLCA)
ds.Retrieve()

lTot = ds.RowCount()

For lCpt = 1 To lTot
	sChem = ds.GetItemString ( lCpt, "CHEMIN" ) 
	sChemRep = sChem 
	sChem += "testecr.txt"
	
	// Test Ouverture/Ecriture/Fermeture/Suppression
	iiFicTrc = FileOpen ( sChem, LineMode!, Write!, Shared!, Append! )

	If iiFicTrc <= 0 Then iRet = -1

	sMes = Fill( "*", 80 )
	iWrite = FileWrite ( iiFicTrc, sMes )

	If iiFicTrc <= 0 Then iRet = -1		
	
	iWrite = FileClose ( iiFicTrc )
	If iiFicTrc <= 0 Then iRet = -1

	If IRet = -1 Then
		stMessage.sTitre = "PM425 : Test Ecriture fichier" 
		stMessage.Icon	  = Exclamation!
		stMessage.sVar[1] = sChemRep 
		stMessage.sVar[2] = "d'$$HEX1$$e900$$ENDHEX$$crire"
		stMessage.bErreurG = FALSE
		stMessage.Bouton	 = OK!

		If Upper(SQLCA.Database) = "SIMPA2_PRO" Then 
			stMessage.sCode	 = "EDIT065"			
		Else 
			stMessage.sCode	 = "EDIT066"			
		End If 
		
		F_Message ( stMessage )
		Destroy ds
		Return FALSE
	End If 

	bFileDelete = FileDelete ( schem ) 

	If Not bFileDelete Then
		stMessage.sTitre = "PM425 : Test suppression fichier" 
		stMessage.Icon	  = Exclamation!
		stMessage.sVar[1] = sChemRep 
		stMessage.sVar[2] = "de supprimer"
		stMessage.bErreurG = FALSE
		stMessage.Bouton	 = OK!

		If Upper(SQLCA.Database) = "SIMPA2_PRO" Then 
			stMessage.sCode	 = "EDIT065"			
		Else 
			stMessage.sCode	 = "EDIT066"			
		End If 
		
		F_Message ( stMessage )
		Destroy ds
		Return FALSE
	End If 

	
Next 

Destroy ds

Return TRUE
end function

event ue_fin_interro;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_Edition
//* Evenement 		: ue_fin_interro
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
//* MAJ      PAR      Date	  	  Modification
//*          JFF   28/04/2021   [OPTIM_MENU_EDT]
//*-----------------------------------------------------------------

/*-----------------------------------------------------------------------------------------*/
/* Si tous les crit$$HEX1$$e800$$ENDHEX$$res sont d'interrogations sont nulls alors on n'envoie pas de retrieve */
/*-----------------------------------------------------------------------------------------*/

// CAG 05/08/2004 : ilIdProd $$HEX1$$e900$$ENDHEX$$tait utilis$$HEX1$$e900$$ENDHEX$$e dans l'anc$$HEX1$$ea00$$ENDHEX$$tre w_accueil_edition_2000
If Not ( isNull ( isMajPar ) AND isNull ( ilIdSin ) AND isNull ( idMajLe ) And IsNull ( ilIdProdInterro ) And IsNull ( ilIdDept ) ) Then

	// [OPTIM_MENU_EDT]
	If ilIdDept = -1 Then SetNull ( ilIdDept )
	
	dw_acc_type_courrier.Retrieve ( isMajPar, ilIdSin,  idMajLe , ilIdProdInterro, ilIdDept  )
	dw_1.Reset ()
	ilNbSelect = 0
	pb_charger.Enabled	= False
	pb_editer.Enabled 	= False
	dw_ProgressBar.SetItem ( 1, "INDICE", 0 )
	dw_ProgressBar.SetItem ( 1, "MAXVALUE", 0 )
	dw_ProgressBar.SetRedraw ( TRUE )

	Wf_Actualiser ( 0 )
	
End If


end event

event ue_fermer_interro;call super::ue_fermer_interro;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_Edition
//* Evenement 		: ue_fermer_interro					(EXTEND)
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
//* 			FPI	25/09/2015	[PI056]
//*-----------------------------------------------------------------


/*-------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des crit$$HEX1$$e800$$ENDHEX$$res d'interrogation       */
/*-------------------------------------------------*/

isMajPar				= w_ae_sp_interro.dw_1.GetItemString ( 1, "MAJ_PAR" )
ilIdSin				= w_ae_sp_interro.dw_1.GetItemNumber ( 1, "ID_SIN"  )
idMajLe				=  w_ae_sp_interro.dw_1.GetItemDateTime   ( 1, "MAJ_LE"  ) // [PI056] GetItemDate -> GetItemDateTime
// CAG 05/08/2004 : ilIdProd $$HEX1$$e900$$ENDHEX$$tait utilis$$HEX1$$e900$$ENDHEX$$e dans l'anc$$HEX1$$ea00$$ENDHEX$$tre w_accueil_edition_2000
ilIdProdInterro	= w_ae_sp_interro.dw_1.GetItemNumber ( 1, "ID_PROD"  )
ilIdDept 			= w_ae_sp_interro.dw_1.GetItemNumber ( 1, "ID_DEPT"  )


end event

event spb_imprimerdossier;call super::spb_imprimerdossier;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_Edition
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
//* MAJ	PAR	Date	  		Modification
//* #1	DGA	03/09/2006	Modification pour la mise sous pli. [DCMP-060589]
//       JFF   11/06/2019 [PM425-1]
//*-----------------------------------------------------------------

Long		lIdSin, lIdArch, lDocPrincipal, lIdInter, lIdLigne, lIdDept, lIdLot, lIdTypDoc  
String	sNomFic, sText, sNom, sIdDocEdt, sIdCompteurPage, sIdCour
Integer	iRet, iNbPage
Boolean	bCodeBarre

//On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re la ligne en cours de traitement
lIdLigne		= Message.WordParm


iRet			= 1
lIdInter		= dw_1.GetItemNumber ( lIdLigne, "ID_INTER"	)
lIdArch		= dw_1.GetItemNumber ( lIdLigne, "ID_ARCH" 	)
lIdSin		= dw_1.GetItemNumber ( lIdLigne, "ID_SIN" 	)
sNom			= dw_1.GetItemString ( lIdLigne, "LIB" 		)
lIdDept		= dw_1.GetItemNumber ( lIdLigne, "ID_DEPT"   )
sIdCour	   = dw_1.GetItemString ( lIdLigne, "ID_COUR"   )
lIdLot      = dw_1.GetItemNumber ( lIdLigne, "ID_LOT" 	)
lIdTypDoc   = dw_1.GetItemNumber ( lIdLigne, "ID_TYP_DOC" )

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
/* #1. Modif DGA                                                    */
/* Je positionne la valeur du param$$HEX1$$e800$$ENDHEX$$tre MISE SOUS PLI avec          */
/* NouvelleMethode.                                                 */
/*------------------------------------------------------------------*/
sIdDocEdt			= dw_1.GetItemString ( lIdLigne, "ID_DOC_EDT" )
If	bCodeBarre	Then
	invEditionCourrier.uf_InscrireParamCourrier ( sNomFic, "0", "O", "NouvelleMethode" )
	sIdCompteurPage	= String ( ilMsp_Compteur )
	invEditionCourrier.uf_InscrireParamMiseSousPli ( sIdDocEdt, sIdCompteurPage )
Else
   invEditionCourrier.uf_InscrireParamCourrier ( sNomFic, "0", "O", "N" )
End If

/*------------------------------------------------------------------*/
/* Ouverture du document se trouvant maintenant sur disque.         */
/*------------------------------------------------------------------*/
lDocPrincipal 	= invEditionCourrier.uf_OuvrirDocument_2 ( sNomFic )

// [PM425-1]
invEditionCourrier.uf_SetPM425 ( "INIT", lIdSin, lIdInter, sIdCour, lIdArch, lIdLot, lIdTypDoc, -1, Mle_Msg, "", TRUE ) 

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
/* Le 03/09/2006. Modification Mise sous pli.                       */
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
st_EnCours.SetReDraw ( True )

/*------------------------------------------------------------------*/
/* Avant de supprimer la ligne de la Dw, j'update le nouveau        */
/* courrier sauvegard$$HEX1$$e900$$ENDHEX$$.                                             */
/*------------------------------------------------------------------*/
//iRet = invGnEdt.uf_Ecrire_Blob ( lIdArch, lIdSin, sNomFic )

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

event spb_preparerimpression;call super::spb_preparerimpression;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_Edition
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
//* MAJ	PAR	Date			Modification
//* #1	DGA	03/09/2006	Modification pour la mise sous pli. [DCMP-060589]
 //* 			FPI	15/09/2014	[OPTIM_SQL]
//*-----------------------------------------------------------------

Boolean 		bOk
String 		sText, sFicIniApp, sRepCourrier	
Long 			lLigne, lCpt, lTotLig, lIdLot
Date			dNow
DateTime		dtDatetime

sText = "D$$HEX1$$e900$$ENDHEX$$but de l'impression ...~r~n"
Mle_Msg.Uf_AjouterText ( sText )

bOk = True

pb_retour.Enabled = False
pb_interro.Enabled = False
pb_charger.Enabled = False
pb_editer.Enabled = False
st_EnCours.Show ()

/*------------------------------------------------------------------*/
/* Purge des vieux courriers                                        */
/*------------------------------------------------------------------*/
bOk = wf_Purger () 

/*------------------------------------------------------------------*/
/* Affectation d'un nouveau num$$HEX1$$e900$$ENDHEX$$ro de lot ,                         */
/* $$HEX2$$e0002000$$ENDHEX$$tous les enregistrements s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$s.                         */
/*------------------------------------------------------------------*/
If bOk Then
	bOk = wf_Affecter_Lot ()
End If


/*------------------------------------------------------------------*/
/* Initialisation de la progressbar                                 */
/*------------------------------------------------------------------*/
If bOk Then
	dw_ProgressBar.SetItem ( 1, "INDICE", 0 )
	dw_ProgressBar.SetItem ( 1, "MAXVALUE", wf_GetNbrDossierSelection() )
	dw_ProgressBar.SetRedraw ( TRUE )
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
If bOk Then

	ilnbcour 	= 0

	SetNull ( dtDatetime )

 	// [OPTIM_SQL]
	dtDatetime=Datetime( Today(), Now() )
	// :[OPTIM_SQL]
	
	If	IsNull ( dtDatetime )	Then
		stMessage.sTitre = "Gestion des courriers"
   	stMessage.Icon   = StopSign!
		stMessage.scode  = "EDIT006"
		stMessage.bErreurG= False
		f_Message ( stMessage )

		bOk = False
	Else
		isDateTime	= "'" + String ( dtDateTime, 'dd/mm/yyyy hh:mm:ss' ) + "'"
	End If

End If


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
//* MAJ      PAR      Date	   Modification
//           JFF   11/06/2019 [PM425-1]
//*-----------------------------------------------------------------

String 	sText, sErreur, sMessArchive
Long 		lRet = 1
Int      iAMUEditionDecentralisee

sText = "Fin de l'impression ...~r~n"
Mle_Msg.Uf_AjouterText ( sText )

/*------------------------------------------------------------------*/
/* On envoie le SPOOL $$HEX2$$e0002000$$ENDHEX$$l'impression.                               */
/* S'il y a eu une erreur lors de la constitution des impression    */
/* on ne l'envoi pas.                                               */
/*                                                                  */
/* De plus si tous les dossiers $$HEX1$$e900$$ENDHEX$$tait en alt_edit 'N', il ne faut   */
/* pas envoyer le fichier spool, qui ne contient rien. Pour cela    */
/* il suffit de tester la valeur de ilNbCour. Mais il faudra tout   */
/* de m$$HEX1$$ea00$$ENDHEX$$me valider les dossiers.                                    */
/*------------------------------------------------------------------*/

If wf_GetStopTraitement () Then
	Return
End If


If ilNbCour > 0 Then

	sText = "Envoi du fichier SPOOL ...      ~r~n"
	Mle_Msg.Uf_AjouterText ( sText )

	// [PM425-1]
	iAMUEditionDecentralisee = invEditionCourrier.uf_GetPM425_EtatEdtEtDecent ()
	invEditionCourrier.uf_SetPM425_EtatEdtEtDecent ( FALSE, FALSE )
	// /[PM425-1]

	lRet = invEditionCourrier.uf_EnvoyerImpressionAuSpool ()
									  
	If	lRet = 1	Then
		sText = "Envoi du fichier SPOOL ... (OK) ~r~n"
	Else
		// [PM425-1]
		If iAMUEditionDecentralisee = 2 Then 
			sText = "Envoi du fichier SPOOL ... (Probl$$HEX1$$e800$$ENDHEX$$me " + String ( lRet ) + " ) " + sErreur + "~r~n"				
		End If 

		If iAMUEditionDecentralisee = 1 Then 
			sText = "Fichiers d$$HEX1$$e900$$ENDHEX$$centralis$$HEX1$$e900$$ENDHEX$$s mis $$HEX2$$e0002000$$ENDHEX$$disposition de CORUS (OK)." + sErreur + "~r~n"				
		End If 

		If iAMUEditionDecentralisee = 3 Then 
			sText = "Envoi du fichier SPOOL pour les $$HEX1$$e900$$ENDHEX$$ditions ET fichiers d$$HEX1$$e900$$ENDHEX$$centralis$$HEX1$$e900$$ENDHEX$$s mis $$HEX2$$e0002000$$ENDHEX$$disposition de CORUS (OK)." + sErreur + "~r~n"				
		End If 
		// /[PM425-1]
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

	/*------------------------------------------------------------------*/
	/* Archivage des courrier                                           */
	/*------------------------------------------------------------------*/
	If wf_Archiver ( sMessArchive ) = False Then

		sText = "Erreur lors de l'archivage : " + sMessArchive
		Mle_Msg.uf_RemplacerText ( sText )
		wf_SetStopTraitement ( TRUE )

		/*---------------------------------------------------------------*/
		/* Important en cas d'erreur le service informatique doit $$HEX1$$ea00$$ENDHEX$$tre   */
      /* pr$$HEX1$$e900$$ENDHEX$$venu.                                                      */
		/*---------------------------------------------------------------*/
		stMessage.sTitre = "Gestion des courriers"
		stMessage.sVar[1] = st_lot.Text
   	stMessage.Icon   = StopSign!
		stMessage.scode  = "EDIT008"
		stMessage.bErreurG= False
		f_Message ( stMessage )
		Return

	End If

End If


dw_1.Reset ()
st_Lot.Text = ""
st_Nombre.Text = "0 / 0"
st_Edit.Text = ""
end event

on ue_interro;//*-----------------------------------------------------------------
//*
//* Objet         : w_ae_sp_Edition  ( !! OVERRIDE !! )
//* Evenement     : ue_interro
//* Auteur        : Fabry JF
//* Date          : 08/04/2004 17:14:59
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
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

SetPointer( HourGlass! )

pb_interro.Enabled = False
OpenWithParm( w_ae_sp_Interro, pb_Interro.istInterro )
pb_interro.Enabled = True

This.TriggerEvent( "UE_FIN_INTERRO" )


end on

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_Edition
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

dw_ProgressBar.SetItem ( 1, "INDICE", 0 )
dw_ProgressBar.SetItem ( 1, "MAXVALUE", 0 )

This.Title = "Editions centralis$$HEX1$$e900$$ENDHEX$$es et d$$HEX1$$e900$$ENDHEX$$centralis$$HEX1$$e900$$ENDHEX$$e SIMPA2"

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

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_Edition
//* Evenement 		: Open					(EXTEND)
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
//* MAJ      PAR      Date	   Modification
//* 			FPI	 01/08/2014	[VDoc15000] chgt dw_1.dataObject
//* 			FPI	 25/09/2015	[PI056]
//          JFF    11/06/2019 [PM425-1]
//*-----------------------------------------------------------------

dw_Acc_Type_Courrier.SetTransObject ( SqlCa )
dw_1.SetTransObject ( SqlCa )

/*------------------------------------------------------------------*/
/* Description  la fen$$HEX1$$ea00$$ENDHEX$$tre d'interrogation.                         */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche des Travaux"
pb_Interro.istInterro.sDataObject			= "d_int_w_cour_blob_arch"
pb_Interro.istInterro.sCodeDw					= "TRAVAUX"

pb_Interro.istInterro.sData[1].sNom			= "maj_par"
pb_Interro.istInterro.sData[1].sDbName		= "sysadm.w_cour_blob_arch.maj_par"
pb_Interro.istInterro.sData[1].sType		= "STRING"
pb_Interro.istInterro.sData[1].sOperande	= "="

pb_Interro.istInterro.sData[3].sNom			= "id_sin"
pb_Interro.istInterro.sData[3].sDbName		= "sysadm.w_cour_blob_arch.id_sin"
pb_Interro.istInterro.sData[3].sType		= "NUMBER"
pb_Interro.istInterro.sData[3].sOperande	= "="

pb_Interro.istInterro.sData[5].sNom			= "maj_le"
pb_Interro.istInterro.sData[5].sDbName		= "Convert ( Datetime, Convert ( Varchar(10), sysadm.w_cour_blob_arch.maj_le, 103 ) )"
pb_Interro.istInterro.sData[5].sType		= "DATETIME" // [PI056] Date-> Datetime
pb_Interro.istInterro.sData[5].sOperande	= "<="


/*-----------------------------------------------------------------*/
/* Preparation de la progresse Barre, l'initialisation est faite   */
/* sur le ue_initialiser                                           */ 
/*-----------------------------------------------------------------*/
dw_ProgressBar.InsertRow ( 0 )


end event

on w_ae_sp_edition_dcmp060589.create
int iCurrent
call super::create
this.pb_charger=create pb_charger
this.st_charger=create st_charger
this.st_lot=create st_lot
this.st_4=create st_4
this.dw_acc_type_courrier=create dw_acc_type_courrier
this.dw_progressbar=create dw_progressbar
this.dw_pagetitre=create dw_pagetitre
this.st_encours=create st_encours
this.cb_partiel_haut=create cb_partiel_haut
this.cb_partiel_bas=create cb_partiel_bas
this.cb_partiel=create cb_partiel
this.cb_chargertout=create cb_chargertout
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_charger
this.Control[iCurrent+2]=this.st_charger
this.Control[iCurrent+3]=this.st_lot
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.dw_acc_type_courrier
this.Control[iCurrent+6]=this.dw_progressbar
this.Control[iCurrent+7]=this.dw_pagetitre
this.Control[iCurrent+8]=this.st_encours
this.Control[iCurrent+9]=this.cb_partiel_haut
this.Control[iCurrent+10]=this.cb_partiel_bas
this.Control[iCurrent+11]=this.cb_partiel
this.Control[iCurrent+12]=this.cb_chargertout
end on

on w_ae_sp_edition_dcmp060589.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_charger)
destroy(this.st_charger)
destroy(this.st_lot)
destroy(this.st_4)
destroy(this.dw_acc_type_courrier)
destroy(this.dw_progressbar)
destroy(this.dw_pagetitre)
destroy(this.st_encours)
destroy(this.cb_partiel_haut)
destroy(this.cb_partiel_bas)
destroy(this.cb_partiel)
destroy(this.cb_chargertout)
end on

event show;call super::show;
//*-----------------------------------------------------------------
//          JFF    28/04/2021 [OPTIM_MENU_EDT]
//*-----------------------------------------------------------------

// [OPTIM_MENU_EDT]
	gWMdi.Width +=1250
//	gWMdi.Height +=1070
//	iwparent.Height=3000

cb_ChargerTout.TriggerEvent(Clicked!)


end event

event hide;call super::hide;
//*-----------------------------------------------------------------
//          JFF    28/04/2021 [OPTIM_MENU_EDT]
//*-----------------------------------------------------------------

// [OPTIM_MENU_EDT]
	gWMdi.Width -=1250
//	gWMdi.Height +=1070
//	iwparent.Height=3000

end event

type cb_debug from w_accueil_edition_2000`cb_debug within w_ae_sp_edition_dcmp060589
end type

type pb_retour from w_accueil_edition_2000`pb_retour within w_ae_sp_edition_dcmp060589
integer width = 242
integer height = 144
end type

type pb_interro from w_accueil_edition_2000`pb_interro within w_ae_sp_edition_dcmp060589
integer width = 242
integer height = 144
integer taborder = 60
end type

on pb_interro::clicked;//*-----------------------------------------------------------------
//*
//* Objet         : pb_Interro
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 03/06/2004 17:43:38
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
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

/*------------------------------------------------------------------*/
/* Le gestionnaire a-t-il le droit d'$$HEX1$$e900$$ENDHEX$$diter ?						  	  */
/*------------------------------------------------------------------*/
If Not stGlb.bEdtSin Then

	stMessage.sTitre		= "Vous n'$$HEX1$$ea00$$ENDHEX$$tes pas autoris$$HEX1$$e900$$ENDHEX$$."
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= False
	stMessage.sCode		= "EDIT060"

	F_Message ( stMessage )

Else

	Call Super::Clicked

End If
end on

type pb_creer from w_accueil_edition_2000`pb_creer within w_ae_sp_edition_dcmp060589
integer x = 2446
integer y = 16
end type

type dw_1 from w_accueil_edition_2000`dw_1 within w_ae_sp_edition_dcmp060589
boolean visible = true
integer x = 9
integer y = 1040
integer width = 3506
integer height = 720
integer taborder = 80
string dataobject = "d_acc_liste_courrier_v02"
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

event dw_1::sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			: W_Ae_Sp_Edition::dw_1
//* Evenement 		: SqlPreview
//* Auteur			: Erick John Stark
//* Date				: 03/09/2006 23:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:
//* Commentaires	: On va mettre $$HEX2$$e0002000$$ENDHEX$$jour la DW
//*
//* Arguments		: 	Value		SqlPreviewFunction			request
//* 						Value 	SqlPreviewType 				sqltype
//*						Value 	String 							sqlsyntax
//*						Value 	DwBuffer							buffer
//*						Value 	Long								row
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Le 03/09/2006. Modification Mise sous pli.                       */
/* Modif DGA.                                                       */
/* On vient de la fonction Wf_Affecter_Lot. On va effectuer un      */
/* UPDATE via une PS dans les tables W_COUR_BLOB_ARCH, ARCHIVE et   */
/* PARAMETRE.                                                       */
/*------------------------------------------------------------------*/
Long lIdSin, lIdArch, lIdLot
String sDteEdit, sErreur, sIdDocEdt

Long lRet

If	Request = PreviewFunctionUpdate!		Then
	If	Row > 0	Then

		lIdSin		= This.GetItemNumber ( row, "ID_SIN", 		buffer, TRUE  )
		lIdArch		= This.GetItemNumber ( row, "ID_ARCH", 	buffer, TRUE  )
		lIdLot		= This.GetItemNumber ( row, "ID_LOT", 		buffer, FALSE )
		sDteEdit		= String ( This.GetItemDateTime  ( row, "DTE_EDIT", 	buffer, FALSE ), "dd/mm/yyyy" )

		sErreur		= Fill ( " ", 50 )
		sIdDocEdt	= K_EDT_PROGRAMME + K_EDT_APPLICATIF + Space ( 7 - Len ( sIdDocEdt ) )

		lRet = SQLCA.PS_U01_MAJ_ID_EDT ( sErreur, sIdDocEdt, K_EDT_PROGRAMME, K_EDT_APPLICATIF, lIdSin, lIdArch, lIdLot, sDteEdit )

		If	lRet = 1 And sErreur = "OK" And Len ( Trim ( sIdDocEdt ) ) = 11 Then
			This.SetItem ( row, "ID_DOC_EDT", sIdDocEdt )
			Return 2
		Else
			Return 1
		End If
	End If
End If
end event

event dw_1::constructor;call super::constructor;ilMaxLig=75 // [VDOC12249]
end event

type pb_tri from w_accueil_edition_2000`pb_tri within w_ae_sp_edition_dcmp060589
boolean visible = false
integer x = 3205
integer y = 28
integer taborder = 90
boolean enabled = false
end type

type pb_imprimer from w_accueil_edition_2000`pb_imprimer within w_ae_sp_edition_dcmp060589
integer x = 2615
integer y = 16
end type

type cb_tout from w_accueil_edition_2000`cb_tout within w_ae_sp_edition_dcmp060589
integer x = 521
integer y = 836
integer width = 265
integer height = 96
integer taborder = 50
end type

type cb_aucun from w_accueil_edition_2000`cb_aucun within w_ae_sp_edition_dcmp060589
integer x = 521
integer y = 932
integer width = 265
integer height = 96
integer taborder = 70
end type

type st_1 from w_accueil_edition_2000`st_1 within w_ae_sp_edition_dcmp060589
integer x = 1225
integer y = 864
integer width = 439
integer height = 64
string text = "Nb dossiers $$HEX2$$e0002000$$ENDHEX$$traiter"
end type

type st_2 from w_accueil_edition_2000`st_2 within w_ae_sp_edition_dcmp060589
integer x = 2066
integer y = 864
integer width = 421
string text = "Nb dossiers $$HEX1$$e900$$ENDHEX$$dit$$HEX1$$e900$$ENDHEX$$s"
end type

type st_nombre from w_accueil_edition_2000`st_nombre within w_ae_sp_edition_dcmp060589
integer x = 1723
integer y = 852
integer width = 334
integer height = 76
end type

type st_edit from w_accueil_edition_2000`st_edit within w_ae_sp_edition_dcmp060589
integer x = 2510
integer y = 852
integer width = 334
integer height = 76
end type

type mle_msg from w_accueil_edition_2000`mle_msg within w_ae_sp_edition_dcmp060589
integer x = 9
integer y = 308
integer width = 3506
integer height = 516
integer textsize = -8
fontcharset fontcharset = ansi!
end type

type pb_editer from w_accueil_edition_2000`pb_editer within w_ae_sp_edition_dcmp060589
integer x = 274
integer y = 864
integer taborder = 40
boolean enabled = false
boolean originalsize = false
string disabledname = "k:\pb4obj\bmp\word_off.bmp"
end type

type pb_charger from picturebutton within w_ae_sp_edition_dcmp060589
integer x = 18
integer y = 864
integer width = 233
integer height = 136
integer taborder = 30
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Charger"
string picturename = "k:\pb4obj\bmp\comp_on.bmp"
string disabledname = "k:\pb4obj\bmp\comp_off.bmp"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_Edition::pb_Charger
//* Evenement 		: Clicked					(EXTEND)
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
//* MAJ      PAR      Date	    Modification
//*          JFF   06/03/2020  [PM425]
//*-----------------------------------------------------------------

Long 		lTot, lCpt, lIdTypDoc
Datetime	dtMaxMajLe
String	sTime

st_Charger.Visible = True
This.Enabled = False

// [PM425-1]
If Not Parent.wf_verifecrexternalisation () Then 
	st_Charger.Visible = False
	This.Enabled = True
	Return
End If 

lTot = dw_acc_type_courrier.RowCount ()
dw_1.Reset ()
dw_ProgressBar.SetItem ( 1, "INDICE", 0 )
dw_ProgressBar.SetItem ( 1, "MAXVALUE", 0 )
dw_ProgressBar.SetRedraw ( TRUE )

/*--------------------------------------------------------------*/
/* Sql-Server stocke les 'datetime' au 1 milli$$HEX1$$e800$$ENDHEX$$me de seconde.   */
/* Les calculs pour la comparaison de valeur s'effectue par     */
/* contre avec pour niveau de pr$$HEX1$$e900$$ENDHEX$$cision le centi$$HEX1$$e800$$ENDHEX$$me de seconde  */
/*--------------------------------------------------------------*/
For lCpt = 1 To lTot

	If dw_acc_type_courrier.GetItemString ( lCpt, "ALT_SELECT" ) = 'O' Then
		dtMaxMajLe 	= dw_acc_type_courrier.GetItemDateTime ( lCpt, "MAX_MAJ_LE" )
		sTime = String ( Time ( dtMaxMajLe ), "hh:mm:ss" )
		dtMaxMajLe = DateTime ( Date ( dtMaxMajLe ), RelativeTime ( Time ( sTime ), 1 ) ) 		

		lIdTypDoc	= dw_acc_type_courrier.GetItemNumber ( lCpt, "ID_TYP_DOC" ) 
		dw_1.SetRedraw ( False )
		// CAG 05/08/2004 : ilIdProd est utilis$$HEX2$$e9002000$$ENDHEX$$dans w_accueil_edition_2000
		dw_1.Retrieve ( isMajPar, ilIdSin, dtMaxMajLe, lIdTypDoc, ilIdProdInterro, ilIdDept )
		dw_1.SetSort ( "ID_SIN A, ID_INTER A, MAJ_LE A" )
		dw_1.Sort ()
		dw_1.SetRedraw ( True )
	End If

Next

pb_editer.Enabled  = False
st_Charger.Visible = False
This.Enabled = True

SetPointer ( Arrow! )

end event

type st_charger from statictext within w_ae_sp_edition_dcmp060589
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

type st_lot from statictext within w_ae_sp_edition_dcmp060589
integer x = 3077
integer y = 872
integer width = 434
integer height = 136
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_ae_sp_edition_dcmp060589
integer x = 2930
integer y = 904
integer width = 142
integer height = 76
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Lot"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_acc_type_courrier from datawindow within w_ae_sp_edition_dcmp060589
integer x = 3529
integer y = 304
integer width = 1262
integer height = 1456
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_acc_type_courrier_v01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_Edition::dw_Acc_Type_Courrier
//* Evenement 		: Clicked
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


Long		lLigne, lTot, lCpt


// r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de la ligne courante

This.SelectRow ( 0, False )
lTot   = This.RowCount ()
For lCpt = 1 To lTot
	this.SetItem   ( lCpt, "Alt_Select", 'N' )
Next
ilNbSelect = 0

lLigne = This.GetClickedRow () 

If lLigne = 0 Then										

   this.SelectRow ( lLigne, False )

Else

	If this.IsSelected ( lLigne ) Then
		this.SelectRow ( lLigne, False )
		this.SetItem   ( lLigne, "Alt_Select", 'N' )
		ilNbSelect --
	Else
		this.SelectRow ( lLigne, True )
		this.SetItem   ( lLigne, "Alt_Select", 'O' )
		ilNbSelect ++
	End IF

End If


If ilNbSelect > 0 Then pb_charger.Enabled = True Else pb_charger.Enabled = False


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

type dw_progressbar from datawindow within w_ae_sp_edition_dcmp060589
integer x = 1179
integer y = 932
integer width = 1669
integer height = 72
string dataobject = "d_trt_progressbar"
boolean border = false
boolean livescroll = true
end type

type dw_pagetitre from datawindow within w_ae_sp_edition_dcmp060589
boolean visible = false
integer x = 2798
integer y = 20
integer width = 293
integer height = 152
boolean bringtotop = true
boolean enabled = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_encours from statictext within w_ae_sp_edition_dcmp060589
boolean visible = false
integer x = 27
integer y = 168
integer width = 4763
integer height = 112
boolean bringtotop = true
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

type cb_partiel_haut from commandbutton within w_ae_sp_edition_dcmp060589
integer x = 791
integer y = 836
integer width = 379
integer height = 68
integer taborder = 50
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
//* Objet			: W_ae_sp_edition_dcmp060589::cb_partiel_haut
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

wf_selectionner( 1, lRow)


end event

type cb_partiel_bas from commandbutton within w_ae_sp_edition_dcmp060589
integer x = 791
integer y = 900
integer width = 379
integer height = 68
integer taborder = 60
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
//* Objet			: W_ae_sp_edition_dcmp060589::cb_partiel_bas
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

type cb_partiel from commandbutton within w_ae_sp_edition_dcmp060589
integer x = 791
integer y = 964
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
string text = "Partiel Haut/bas"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_sp_edition_dcmp060589::cb_partiel_haut_bas
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

type cb_chargertout from commandbutton within w_ae_sp_edition_dcmp060589
integer x = 530
integer y = 20
integer width = 1033
integer height = 140
integer taborder = 100
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Charger toutes les $$HEX1$$e900$$ENDHEX$$ditions"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_ae_Sa_Edition
//* Evenement 		: ue_fin_interro
//* Auteur			: JFF
//* Date				: 28/04/2021
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  	  Modification
//*          JFF   28/04/2021   [OPTIM_MENU_EDT]
//*-----------------------------------------------------------------

// [OPTIM_MENU_EDT]
SetNull ( isMajPar ) 
SetNull ( ilIdSin ) 
SetNull ( idMajLe ) 
SetNull ( ilIdProdInterro ) 
ilIdDept = -1 

Parent.TriggerEvent ( "ue_fin_interro" )


end event

