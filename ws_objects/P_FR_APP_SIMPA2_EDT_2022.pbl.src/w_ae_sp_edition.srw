HA$PBExportHeader$w_ae_sp_edition.srw
$PBExportComments$Fen$$HEX1$$ea00$$ENDHEX$$tre des $$HEX1$$e900$$ENDHEX$$ditions SVE
forward
global type w_ae_sp_edition from w_accueil_edition_2000
end type
type pb_charger from picturebutton within w_ae_sp_edition
end type
type st_charger from statictext within w_ae_sp_edition
end type
type st_lot from statictext within w_ae_sp_edition
end type
type st_4 from statictext within w_ae_sp_edition
end type
type dw_acc_type_courrier from datawindow within w_ae_sp_edition
end type
type dw_progressbar from datawindow within w_ae_sp_edition
end type
type st_encours from statictext within w_ae_sp_edition
end type
end forward

global type w_ae_sp_edition from w_accueil_edition_2000
integer width = 3351
integer height = 1992
event ue_saisieautomatique pbm_custom04
pb_charger pb_charger
st_charger st_charger
st_lot st_lot
st_4 st_4
dw_acc_type_courrier dw_acc_type_courrier
dw_progressbar dw_progressbar
st_encours st_encours
end type
global w_ae_sp_edition w_ae_sp_edition

type variables
String	isMajPar
Long	ilIdSin, ilIdProdInterro, ilIdDept
DateTime	idMajLe

String	isDateTime
String	isRepCourrier

Long	ilNbCour
Long	ilNbSelect


end variables

forward prototypes
public function integer wf_lire_blob (long alidarch, long alidsin, long alidinter, ref string asnomfic)
public function boolean wf_ecrire_fichier (string as_filename, blob ablb_data, boolean ab_append)
public subroutine wf_positionnerobjets ()
private function boolean wf_purger ()
private function boolean wf_affecter_lot ()
private function boolean wf_archiver (ref string asmess)
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

// [DECIMAL_PAPILLON]
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
//*-----------------------------------------------------------------

Long		lIdLot, lCpt, lTotLig, lNbTrouve, lNbTrouveTot
Date		dNow
DateTime	dtMaxMajLe
long		lIdTypDoc

String	sMajPar
Long		lIdSin  


Boolean bOk

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

		bOk= False

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
			dtMaxMajLe = dw_Acc_Type_courrier.GetItemDateTime ( lCpt, "MAX_MAJ_LE" )
			lIdTypDoc  = dw_Acc_Type_courrier.GetItemNumber   ( lCpt, "ID_TYP_DOC" )

			SQLCA.PS_S01_W_COUR_BLOB_ARCH ( 	smajpar, lidsin, dtMaxMajLe, lIdTypDoc, lNbTrouve )
			lnbTrouveTot += lNbTrouve
		End If		
	Next

											  
	If lNbTrouveTot < Dw_1.RowCount () Then

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
If bOk Then

	If dw_1.Update () < 0 Then
		f_Commit ( SQLCA, FALSE )
		stMessage.sTitre = "Gestion des courriers"
  		stMessage.Icon   = Exclamation!
		stMessage.scode  = "EDIT007"
		stMessage.bErreurG= False
		f_Message ( stMessage )

		bOk= False
	Else
		f_Commit ( SQLCA, TRUE )
	End If

End If

/*------------------------------------------------------------------*/
/* Maj Zone de texte                                                */
/*------------------------------------------------------------------*/
If bOk Then
	st_Lot.Text = String ( lIdLot )
End If

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
dw_acc_type_courrier.Retrieve ( isMajPar, ilIdSin, idMajLe , ilIdProdInterro, ilIdDept  )

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
stMessage.scode  = "EDIT020"
stMessage.bErreurG= False
f_Message ( stMessage )


Return bOk
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
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

/*-----------------------------------------------------------------------------------------*/
/* Si tous les crit$$HEX1$$e800$$ENDHEX$$res sont d'interrogations sont nulls alors on n'envoie pas de retrieve */
/*-----------------------------------------------------------------------------------------*/

// CAG 05/08/2004 : ilIdProd $$HEX1$$e900$$ENDHEX$$tait utilis$$HEX1$$e900$$ENDHEX$$e dans l'anc$$HEX1$$ea00$$ENDHEX$$tre w_accueil_edition_2000
If Not ( isNull ( isMajPar ) AND isNull ( ilIdSin ) AND isNull ( idMajLe ) And IsNull ( ilIdProdInterro ) And IsNull ( ilIdDept ) ) Then
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
idMajLe				= w_ae_sp_interro.dw_1.GetItemDateTime   ( 1, "MAJ_LE"  ) // [PI056] GetItemDate -> GetItemDateTime
// CAG 05/08/2004 : ilIdProd $$HEX1$$e900$$ENDHEX$$tait utilis$$HEX1$$e900$$ENDHEX$$e dans l'anc$$HEX1$$ea00$$ENDHEX$$tre w_accueil_edition_2000
ilIdProdInterro	= w_ae_sp_interro.dw_1.GetItemNumber ( 1, "ID_PROD"  )
ilIdDept 			= w_ae_sp_interro.dw_1.GetItemNumber ( 1, "ID_DEPT"  )


end event

on spb_imprimerdossier;call w_accueil_edition_2000::spb_imprimerdossier;//*-----------------------------------------------------------------
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
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long		lIdSin, lIdArch, lDocPrincipal, lIdInter, lIdLigne , toto
String	sNomFic, sText, sNom
Int		iRet

//On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re la ligne en cours de traitement
lIdLigne		= Message.WordParm


iRet			= 1
lIdInter		= dw_1.GetItemNumber ( lIdLigne, "ID_INTER"	)
lIdArch		= dw_1.GetItemNumber ( lIdLigne, "ID_ARCH" 	)
lIdSin		= dw_1.GetItemNumber ( lIdLigne, "ID_SIN" 	)
sNom			= dw_1.GetItemString ( lIdLigne, "LIB" 		)

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
invEditionCourrier.uf_InscrireParamCourrier ( sNomFic, "0", "O", "O" )

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


end on

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
//* MAJ      PAR      Date	  Modification
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
end event

on spb_terminerimpression;call w_accueil_edition_2000::spb_terminerimpression;//*-----------------------------------------------------------------
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

	sText = "Envoi du fichier SPOOL ...~r~n"
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
end on

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

on ue_initialiser;call w_accueil_edition_2000::ue_initialiser;//*-----------------------------------------------------------------
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
//* 
//*-----------------------------------------------------------------

dw_ProgressBar.SetItem ( 1, "INDICE", 0 )
dw_ProgressBar.SetItem ( 1, "MAXVALUE", 0 )

This.Title = "Editions centralis$$HEX1$$e900$$ENDHEX$$es SIMPA2"
end on

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
//* MAJ      PAR      Date	  Modification
//* 			FPI	25/09/2015	[PI056]
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

on w_ae_sp_edition.create
int iCurrent
call super::create
this.pb_charger=create pb_charger
this.st_charger=create st_charger
this.st_lot=create st_lot
this.st_4=create st_4
this.dw_acc_type_courrier=create dw_acc_type_courrier
this.dw_progressbar=create dw_progressbar
this.st_encours=create st_encours
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_charger
this.Control[iCurrent+2]=this.st_charger
this.Control[iCurrent+3]=this.st_lot
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.dw_acc_type_courrier
this.Control[iCurrent+6]=this.dw_progressbar
this.Control[iCurrent+7]=this.st_encours
end on

on w_ae_sp_edition.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_charger)
destroy(this.st_charger)
destroy(this.st_lot)
destroy(this.st_4)
destroy(this.dw_acc_type_courrier)
destroy(this.dw_progressbar)
destroy(this.st_encours)
end on

type cb_debug from w_accueil_edition_2000`cb_debug within w_ae_sp_edition
end type

type pb_retour from w_accueil_edition_2000`pb_retour within w_ae_sp_edition
integer width = 242
integer height = 144
end type

type pb_interro from w_accueil_edition_2000`pb_interro within w_ae_sp_edition
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

type pb_creer from w_accueil_edition_2000`pb_creer within w_ae_sp_edition
end type

type dw_1 from w_accueil_edition_2000`dw_1 within w_ae_sp_edition
boolean visible = true
integer x = 46
integer y = 936
integer width = 3227
integer height = 824
integer taborder = 90
string dataobject = "d_acc_liste_courrier"
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

type pb_tri from w_accueil_edition_2000`pb_tri within w_ae_sp_edition
boolean visible = false
integer width = 242
integer height = 144
integer taborder = 100
end type

type pb_imprimer from w_accueil_edition_2000`pb_imprimer within w_ae_sp_edition
end type

type cb_tout from w_accueil_edition_2000`cb_tout within w_ae_sp_edition
integer x = 37
integer y = 788
integer width = 233
integer height = 136
integer taborder = 50
end type

type cb_aucun from w_accueil_edition_2000`cb_aucun within w_ae_sp_edition
integer x = 288
integer y = 788
integer width = 233
integer height = 136
integer taborder = 70
end type

type st_1 from w_accueil_edition_2000`st_1 within w_ae_sp_edition
integer x = 1024
integer y = 788
integer width = 439
integer height = 64
string text = "Nb dossiers $$HEX2$$e0002000$$ENDHEX$$traiter"
end type

type st_2 from w_accueil_edition_2000`st_2 within w_ae_sp_edition
integer x = 1865
integer y = 788
integer width = 421
string text = "Nb dossiers $$HEX1$$e900$$ENDHEX$$dit$$HEX1$$e900$$ENDHEX$$s"
end type

type st_nombre from w_accueil_edition_2000`st_nombre within w_ae_sp_edition
integer x = 1522
integer y = 776
integer width = 334
integer height = 76
end type

type st_edit from w_accueil_edition_2000`st_edit within w_ae_sp_edition
integer x = 2295
integer y = 776
integer width = 334
integer height = 76
end type

type mle_msg from w_accueil_edition_2000`mle_msg within w_ae_sp_edition
integer x = 1047
integer y = 224
integer width = 2226
integer height = 484
end type

type pb_editer from w_accueil_edition_2000`pb_editer within w_ae_sp_edition
integer x = 288
integer y = 604
integer width = 242
integer height = 144
integer taborder = 40
boolean enabled = false
string disabledname = "k:\pb4obj\bmp\word_off.bmp"
end type

type pb_charger from picturebutton within w_ae_sp_edition
integer x = 37
integer y = 604
integer width = 242
integer height = 144
integer taborder = 30
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

on clicked;//*-----------------------------------------------------------------
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
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long 		lTot, lCpt, lIdTypDoc
Datetime	dtMaxMajLe
String	sTime

st_Charger.Visible = True
This.Enabled = False

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

end on

type st_charger from statictext within w_ae_sp_edition
boolean visible = false
integer x = 1134
integer y = 1240
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

type st_lot from statictext within w_ae_sp_edition
integer x = 2834
integer y = 788
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

type st_4 from statictext within w_ae_sp_edition
integer x = 2688
integer y = 820
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

type dw_acc_type_courrier from datawindow within w_ae_sp_edition
integer x = 37
integer y = 228
integer width = 992
integer height = 356
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_acc_type_courrier"
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

type dw_progressbar from datawindow within w_ae_sp_edition
integer x = 978
integer y = 856
integer width = 1669
integer height = 72
integer taborder = 80
string dataobject = "d_trt_progressbar"
boolean border = false
boolean livescroll = true
end type

type st_encours from statictext within w_ae_sp_edition
boolean visible = false
integer x = 946
integer y = 64
integer width = 1422
integer height = 72
boolean bringtotop = true
integer textsize = -11
integer weight = 700
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

