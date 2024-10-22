$PBExportHeader$w_a_sp_relance.srw
$PBExportComments$---} Fenêtre des Relances/Soldage.
forward
global type w_a_sp_relance from w_accueil_edition_2000
end type
type uo_defil from u_barredefil within w_a_sp_relance
end type
type dw_produit from u_datawindow within w_a_sp_relance
end type
type dw_para_prod from datawindow within w_a_sp_relance
end type
type dw_police from datawindow within w_a_sp_relance
end type
type uo_libelle from u_libelle_dga within w_a_sp_relance
end type
type dw_civilite from datawindow within w_a_sp_relance
end type
type pb_lancer from picturebutton within w_a_sp_relance
end type
type dw_boitearchive from datawindow within w_a_sp_relance
end type
type dw_detpro from datawindow within w_a_sp_relance
end type
type dw_page_blanche from datawindow within w_a_sp_relance
end type
type pb_pageblanche from picturebutton within w_a_sp_relance
end type
type dw_gencourrier from datawindow within w_a_sp_relance
end type
type dw_autorisation from datawindow within w_a_sp_relance
end type
type dw_saisiesin from u_datawindow within w_a_sp_relance
end type
type dw_courrier_relance from datawindow within w_a_sp_relance
end type
end forward

global type w_a_sp_relance from w_accueil_edition_2000
integer width = 3662
integer height = 1928
uo_defil uo_defil
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
dw_saisiesin dw_saisiesin
dw_courrier_relance dw_courrier_relance
end type
global w_a_sp_relance w_a_sp_relance

type variables
Protected :

	u_Gs_Sp_Relance	iuo_Rel

	Boolean	ibInit = False	// A true, la fenêtre à déjà été initialisée.
	String	isNbrCourrier
	String	isTypTrtWord   // C ou E
	String	isFicCourrierIni // Fichier INI pour Edition
	String	isTypTrt	// Type de Traitement
	String	isFicEntete, isFicEnteteAnc, isFicEnteteNouv, isRepCourrier
	Date		idDteProdSve
	Long		ilNumCourrier
	Long		ilSin = 0	// ... pour rupture sur Id_Sin
	Long		ilDossier

end variables

forward prototypes
public subroutine wf_initialiser (string atyptrt)
public subroutine wf_retaillerobjet ()
protected function boolean wf_lire_blob (long adcidsin, long adcidinter, long adciddoc, string astype, ref blob asblob)
public subroutine wf_actualiseredition (long alnumcourrier)
public subroutine wf_positionnerobjet_relance ()
protected function long wf_editer_relance ()
private subroutine wf_modifierentete (date aDteEditDocOrig)
private subroutine wf_renommerfichieriniedition (string ascas)
protected function integer wf_lireecrire_blob (long adcidsin, long adcidinter, long adciddoc, string astype, ref string asnomfic)
public subroutine wf_discard_row ()
end prototypes

public subroutine wf_initialiser (string atyptrt);//*-----------------------------------------------------------------
//*
//* Fonction		: wf_Initialiser (Public)
//* Auteur			: Fabry JF
//* Date				: 23/06/1999 12:25:34
//* Libellé			: Initialisation de la fenêtre.
//* Commentaires	: Cette initialisation vient en complèment du ue_Initialiser
//*					  et est déclenché après l'ouverture de la fenêtre sur le menu
//*					  après le F_OuvreAccueil.
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
/* On initialise une seule fois la fenêtre (ibInit).                */
/*------------------------------------------------------------------*/
If Not ibInit Then

	ibInit = True

	isTypTrt = aTypTrt

	This.wf_RetaillerObjet ()

	CHOOSE CASE isTypTrt

		CASE "R1A"
			This.Title = "Premières Relances Normales."

		CASE "R1U"
			This.Title = "Premières Relances Automatiques pour les garanties UF avec Dem. Pces. à la banque."

		CASE "R1T"
			This.Title = "Premières Relances Particulières."

		CASE "R1P"
			This.Title = "Premières Relances Ponctuelles."

		CASE "R2"
			This.Title = "Deuxièmes Relances."

		CASE "DR1"
			This.Title = "Annulation d'une Première Relance."

	END CHOOSE

	iuo_Rel.uf_Initialiser_Anc ( 	Dw_Produit			,&
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
											dw_autorisation   ,&
											dw_courrier_relance    )

End If



end subroutine

public subroutine wf_retaillerobjet ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_RetaillerObjet (Public)
//* Auteur			: Fabry JF
//* Date				: 25/06/1999 15:16:48
//* Libellé			: Retaille les objets pour certains cas de traitement.
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

	CASE "DR1"

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

END CHOOSE


/*------------------------------------------------------------------*/
/* Certains Bitmap peuvent changer.											  */
/*------------------------------------------------------------------*/
CHOOSE CASE isTypTrt

	CASE "DR1"

		Pb_Lancer.PictureName = "K:\PB4OBJ\BMP\8_SUPPR.BMP"
		Pb_Lancer.Text			 = "&Détruire"

END CHOOSE


end subroutine

protected function boolean wf_lire_blob (long adcidsin, long adcidinter, long adciddoc, string astype, ref blob asblob);//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_Lire_Blob() ( Protected )
//* Auteur			:	Fabry Jf
//* Date				:	17/06/1999
//* Libellé			:	
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

Decimal {2} dcIdsin2, dcIdInter2, dcIdDoc2

// [DECIMAL_PAPILLON]
	dcIdsin2 = Dec ( adcIdSin )
	dcIdInter2 = Dec ( adcIdInter )
	dcIdDoc2 = Dec ( adcIdDoc )

Boolean bOk = True

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
											" .... Impression stoppée.~r~n" )		
		bOk = False

	End If

Return bOk

end function

public subroutine wf_actualiseredition (long alnumcourrier);//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_ActualiserEdition ()
////* Auteur			:	N°6
//* Date				:	07/05/97 11:05:49
//* Libellé			:	
//* Commentaires	:	Met à jour la zone indiquant le nombre de courriers édités.
//*
//* Arguments		:	Long			alNumCourrier			
//*
//* Retourne		:	Aucun
//*
//*-----------------------------------------------------------------


If alNumCourrier > 0 Then

	St_Edit.Text 		= String ( alNumCourrier, "0000" ) +  " / " + isNbrCourrier
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
//* Libellé			: 
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

Dw_1.x					= 33
Dw_1.y					= 729
Dw_1.Width				= 3530
Dw_1.Height				= 1000

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

Dw_Produit.x			= 1943
Dw_Produit.y			= 61
Dw_Produit.Width		= 1578
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
//* Libellé			:	Impression des dossiers selectionnés
//* Commentaires	:	
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


String sText
String sK_RETOUR	= "~r"
String sK_NEWLINE	= "~n"
Long lRet

Int		iCptLot			// Compteur de courrier dans un lot
Long		lRowDw1			// Nbre de row dans Dw1

SetPointer( HourGlass! )
Mle_Msg.Uf_EffacerText()

wf_SetStopTraitement ( FALSE )

/*------------------------------------------------------------------*/
/* Initialisation de la communication avec Word                     */
/*------------------------------------------------------------------*/
lRet = invEditionCourrier.uf_Initialiser ( isTypTrtWord )

If	lRet <> 1	Then
	sText = "L'initialisation du fichier INI vient d'échouer. "							+ & 
			  "(Erreur : " + String ( lRet ) + ")"												+ &
			  sK_RETOUR + sK_NEWLINE

	Mle_Msg.uf_RemplacerText ( sText )
	Return ( lRet )
End If

/*------------------------------------------------------------------*/
/* On essaye de démarrer WORD.                                      */
/*------------------------------------------------------------------*/
lRet = invEditionCourrier.uf_InitialiserWord ( FALSE )

If	lRet <> 1 Then
	sText = "L'initialisation de la communication avec WORD vient d'échouer. "		+ & 
			  "(Erreur : " + String ( lRet ) + ")"												+ &
			  sK_RETOUR + sK_NEWLINE
			  
	Mle_Msg.uf_RemplacerText ( sText )
	Return ( lRet )
End If


/*------------------------------------------------------------------*/
/* Traitement des dossiers                                          */
/*------------------------------------------------------------------*/
This.TriggerEvent ( "SPB_PreparerImpression" )

// // // // // // // // // // // // // // // // // // // // // // // // // // //
// Nombre de dossiers qui seront traités
iuo_rel.iCptTraite = 0

ilDossier = dw_1.Rowcount ()

/*------------------------------------------------------------------*/
/* Boucle de génération des courriers de relance.                   */
/*------------------------------------------------------------------*/
Do While ( ilDossier > 0 ) And ( Not wf_GetStopTraitement () )

	If Not wf_GetStopTraitement () Then
		This.TriggerEvent ( "SPB_ImprimerDossier", ilDossier, ilDossier )

	End If

	If Not wf_GetStopTraitement () Then

		If ( wf_GetSupprimerLigne () ) Then 

			/*-------------------------------------------------------------------*/
			/* MOD-0021 : On supprime la ligne si ibSupprimeligne = True         */
			/*-------------------------------------------------------------------*/
			Dw_1.Visible = False
			Dw_1.DeleteRow ( ilDossier )
			Dw_1.TriggerEvent ( "Ue_TaillerHauteur" )
			Dw_1.Visible = True
			ilDossier --			
			iuo_rel.iCptTraite += 1

		End If
		
	End If

Loop

wf_SetSupprimerLigne ( FALSE )

invEditionCourrier.uf_TerminerSession ()

/*------------------------------------------------------------------*/
/* Ecriture trace																	  */
/*------------------------------------------------------------------*/
iuo_rel.uf_ecriretrace (0, 3)

Return ( 1 )

end function

private subroutine wf_modifierentete (date aDteEditDocOrig);//*-----------------------------------------------------------------
//*
//* Fonction      : wf_ModifierEntete
//* Auteur        : Fabry JF
//* Date          : 16/04/2004 11:00:45
//* Libellé       : Choix de l'entete selon la date de l'edition du courrier d'origirine
//* Commentaires  : 
//*
//* Arguments     : Date		aDteEditDocOrig			Val		// Date d'édition du doc original
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
/* #1 : Si la Date d'édition est strictement avant le premier jour  */
/* de mise en production de la SVE alors c'est une edition à        */
/* l'ancienne méthode (fusion avec DT) ET avec l'ancien fichier     */
/* d'entete.                                                        */
/*------------------------------------------------------------------*/
If aDteEditDocOrig < idDteProdSve Then
	sEntete = isFicEnteteAnc

/*------------------------------------------------------------------*/
/* #1 : Si la Date d'édition est supérieure ou égale à la date de   */
/* mise en prod de la SVE, c'est donc un nouveau courrier à la      */
/* méthode SVE, créé avec le nouvel entete. Pour mémoire on         */
/* mémorise le nouvel entête, mais il ne servira pas à la           */
/* reconstruction du courrier qui est déjà fusionné (DO).           */
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
//* Libellé       : Copie ou Restaure le fichier INI d'édition
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

		If Not f_FileExists ( isFicCourrierIni ) Then Return

		/*------------------------------------------------------------------*/
		/* On supprime le fichier C:\SPB\SIM2_E2.INI		                    */
		/*------------------------------------------------------------------*/
		FileDelete ( F_Remplace ( isFicCourrierIni, ".INI", "2.INI" ) )

		/*------------------------------------------------------------------*/
		/* On copie le fichier actuel C:\SPB\SIM2_E.INI en                  */
		/* C:\SPB\SIM2_E2.INI                                               */
		/*------------------------------------------------------------------*/
		FileCopy (isFicCourrierIni, &
					F_Remplace ( isFicCourrierIni, ".INI", "2.INI" ) &
				 )

		/*------------------------------------------------------------------*/
		/* On supprime le fichier actuel C:\SPB\SIM2_E.INI				              */
		/*------------------------------------------------------------------*/
		FileDelete ( isFicCourrierIni )

	Case "RESTAURER"

		If Not f_FileExists ( F_Remplace ( isFicCourrierIni, ".INI", "2.INI" ) ) Then Return

		/*------------------------------------------------------------------*/
		/* On supprime le fichier C:\SPB\SIM2_E.INI		                    */
		/*------------------------------------------------------------------*/
		FileDelete ( isFicCourrierIni )

		/*------------------------------------------------------------------*/
		/* On restaure le fichier actuel C:\SPB\SIM2_E2.INI en              */
		/* C:\SPB\SIM2_E.INI                                                */
		/*------------------------------------------------------------------*/
		FileCopy (F_Remplace ( isFicCourrierIni, ".INI", "2.INI" ), &
					isFicCourrierIni )

	Case "SUPPRIMER"
		/*------------------------------------------------------------------*/
		/* On supprime le fichier C:\SPB\SIM2_E.INI		                    */
		/*------------------------------------------------------------------*/
		FileDelete ( isFicCourrierIni )


End Choose

If f_FileExists ( isFicCourrierIni ) Then
	SetProfileString ( isFicCourrierIni, "COURRIER", "DTE_EDIT_DOCUMENT", "" )
End If

end subroutine

protected function integer wf_lireecrire_blob (long adcidsin, long adcidinter, long adciddoc, string astype, ref string asnomfic);//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_LireEcrire_Blob () 
//* Auteur			:	Fabry Jf
//* Date				:	27/04/2004
//* Libellé			:	
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

/*-------------------------------------------------------------------*/
/* Nom de fichier : PARTORI_[ID_INTER]												*/
/*-------------------------------------------------------------------*/
asNomFic = stGLB.sRepTempo + "PARTORI_" + string(adcIdInter) + ".DOC"

This.wf_Lire_Blob ( adcIdSin, adcIdInter, adcIdDoc, asType, blBlob )

/*------------------------------------------------------------------*/
/* Le blob peut ne pas être valide, on passe au blob suivant.       */
/*------------------------------------------------------------------*/
If Len ( blBlob ) <= 0 Or IsNull ( blBlob )  Then 

	sText = "~t"																	+ &
			  " Erreur Lecture " + String ( SQLCA.SqlCode )				+ &
			  " Type  : " + string ( asType )								+ &
			  " Sin.  : " + String ( adcIdSin )								+ &
			  " inter : " + String ( adcIdinter )							+ &
			  " Doc   : " + String ( adcIdDoc )								+ &
			  " .... Traitement stoppé.~r~n"
				 
	Mle_Msg.Uf_AjouterText ( sText )
	
	iRet = -1
	
End If

/*------------------------------------------------------------------*/
/* Suppression du disque d'un éventuel fichier portant le même nom. */
/*------------------------------------------------------------------*/
bFileDelete = False
DO While Not bFileDelete

	If f_FileExists ( asNomFic ) Then 
		
		bFileDelete = FileDelete (asNomFic )	
	
		If IsNull ( bFileDelete ) Or Not bFileDelete Then 

			// Compteur au delà de 50, car on n'arrive pas à effacer le fichier.
			lCpt ++
			asNomFic = sRep + String ( lCpt ) + ".DOC"
			
		End If
	
	Else
		bFileDelete = True
	End If
Loop	

/*------------------------------------------------------------------*/	
/* Ecriture du fichier en Local, si problème on ne s'arrête pas,    */
/* il suffit peut-être de faire de la place sur le disque en        */
/* local, on laisse le choix à l'utilisateur pour réessayer via la  */
/* box d'erreur..                                                   */
/*------------------------------------------------------------------*/
bFicOk 	= FALSE
bAbanDon	= FALSE

DO WHILE Not bFicOk And Not bAbandon

	bFicOk = F_EcrireFichierBlob ( blBlob, asNomFic )

	/*------------------------------------------------------------------*/
	/* Problème d'écriture ou manque de place sur disque dur.           */
	/*------------------------------------------------------------------*/
	If bFicOk = False Then
		stMessage.sTitre = "Gestion des courriers"
		//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
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

public subroutine wf_discard_row ();// JCA


integer i, iTotRow

iTotRow = dw_1.rowcount ()

for i = iTotRow to 1 step -1
	integer test
	test = dw_1.object.selection[i]
	if dw_1.object.selection[i] = 0 or isnull(dw_1.object.selection[i]) then // La ligne n'est pas sélectionnée
		dw_1.rowsdiscard( i, i, PRIMARY!)
		
	end if
	
end for
end subroutine

event spb_imprimerdossier;call super::spb_imprimerdossier;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Rel_Sold
//* Evenement 		: SPB_ImprimerDossier
//* Auteur			: Fabry JF
//* Date				: 17/06/1999
//* Libellé			: imprime le courrier de relance et le courrier original.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF   16/04/04  DCMP 040020 SVE : Selon la methode, on change l'entete	 			  
//*-----------------------------------------------------------------

String		sIdCourTyp		// Identifiant du courrier composé.
String		sAltPart			// Indique s'il s'agit d'un courrier divers ou particulier.
Long	      lIdSin			// Identifiant du sinistre
Long	      lIdInter  		// Identifiant interlocuteur
Long			lIdDoc			// Identifiant du courrier pour l'interlocuteur
String		sNom				// Nom du destinataire du courrier.

Boolean		bOk 				= True
Boolean		bContinuer		= True
Boolean		bAddOriginal	= True

Blob		bTxtblob				// Blob contenant le texte des variables.

Long		lIdLigne				// Ligne en cours de traitement

Integer	i, iRet = 1

Long 		lIdProd, lDeb, lFin

/*------------------------------------------------------------------*/
/* Courrier de relance en cours.										        */
/*------------------------------------------------------------------*/
lIdLigne		= Message.WordParm

// Initialisation des variables pour inforamtion
// 	et génération du courrier original
sNom			= Dw_1.GetItemString ( lIdLigne, "NOM_INTER" )
lIdSin 		= Dw_1.GetitemNumber ( lIdLigne, "ID_SIN" )
lIdInter		= Dw_1.GetItemNumber ( lIdLigne, "ID_I" )
lIdDoc		= Dw_1.GetItemNumber ( lIdLigne, "ID_DOC" )
sIdCourTyp 	= Dw_1.GetitemString ( lIdLigne, "ID_COUR" )
//lIdProd		= dw_produit.object.id_prod[1]
lIdProd		= Dw_1.object.id_prod[1]

bOk = iuo_rel.uf_ChargerDwPolice (lIdProd)

/*------------------------------------------------------------------*/
/* informations sur le dossier en cours de traitement.				  */
/*------------------------------------------------------------------*/
Mle_Msg.Uf_AjouterText ( "Dossier : " + String ( lIdSin ) + " Génération du courrier de relance adressé à " + sNom + "~r~n" )

// Nettoyage de la datawindows de génération des courriers avant chaque traitement de relance
dw_gencourrier.reset()

/*------------------------------------------------------------------*/
/*               C O U R R I E R   R E L A N C E                    */
/*------------------------------------------------------------------*/
// Génération du courrier de relance
bOk = iuo_rel.uf_CreerCourrierRelance ( lIdLigne )

/*------------------------------------------------------------------*/
/*               C O U R R I E R   O R I G I N A L                  */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On vérifie le paramétrage de réédition de l'original				  */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, dw_DetPro, lIdProd, "-DP", 96 )

if lDeb > 0 then
	for i = lDeb to lFin
		bAddOriginal = dw_DetPro.object.val_num[i] > 0
	next
end if

/*------------------------------------------------------------------*/
/*  on ne réédite pas l'original :                                  */
/*  - Si le courrier original est un questionnaire                  */
/*  - Si le traitement est "R2" (Deuxième relances).                */
/*	 - Si le paramétrage l'autorise											  */
/*------------------------------------------------------------------*/
bContinuer = ( Left ( sIdCourTyp, 1 ) <> "Q" ) And	( isTypTrt <> "R2" ) and bAddOriginal

/*------------------------------------------------------------------*/
/* O R I G I N A L  												 				  */
/*------------------------------------------------------------------*/
If bOk And bContinuer Then

	/*------------------------------------------------------------------*/
	/* Lecture du Blob et écriture du fichier.                          */
	/*------------------------------------------------------------------*/
	iRet = wf_LireEcrire_Blob ( lIdSin, lIdInter, lIdDoc, "DO", iuo_rel.isTxtCompoOri )
	
	If iRet < 0 Then 
		bOk = false
		iuo_rel.ismess = "Erreur lors de la lecture/ecriture du courrier original"

	else
		/*------------------------------------------------------------------*/
		/* Ecriture du courrier dans datawindow de generation des courriers.*/
		/*------------------------------------------------------------------*/
		bOk = iuo_rel.uf_EcrireDwGenCourrier ( lIdLigne, "O" )
		
	End If

End If

/*------------------------------------------------------------------*/
/* Generation des courriers à partir de datawindow.					  */
/*------------------------------------------------------------------*/
if bOk then
	bOk = iuo_rel.uf_Generer_Courrier (lIdLigne)
end if

/*------------------------------------------------------------------*/
/* Arrêt du traitement.															  */
/*------------------------------------------------------------------*/
if not bOk then wf_SetStopTraitement ( TRUE )
	
/*------------------------------------------------------------------*/
/* Ecriture trace																	  */
/*------------------------------------------------------------------*/
iuo_rel.uf_ecriretrace (lIdLigne, 2)

/*------------------------------------------------------------------*/
/* Suppression du fichier fusionné toujours présent sur disque.     */
/*------------------------------------------------------------------*/
if bOk then
	FileDelete ( "RELANCE.DOC" ) 
end if


end event

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_sold
//* Evenement 		: ue_Initialiser
//* Auteur			: Fabry JF
//* Date				: 23/06/1999 13:56:16
//* Libellé			: Initialisation de la fenêtre
//* Commentaires	: wf_Initialiser sera lancé par la suite 
//*					  à partir du menu.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  PLJ  06/05/2004 Gestion du bouton pb_pageblanche				  
//  #2 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//*-----------------------------------------------------------------

String	sTypeTrt
String 	sFicIniApp, sRepCourrierIni

sTypeTrt = stGlb.sMessageErreur

istPass.trTrans	= SQLCA
iTrTrans = istPass.trTrans

sFicIniApp 			= stGLB.sFichierIni
//#2 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
sRepCourrierIni	= stGlb.sRepTempo

isTypTrtWord = "E"
isFicCourrierIni	= sRepCourrierIni + Left ( stGLB.sCodAppli, 6 ) + "_" + isTypTrtWord + ".INI"

iuo_Rel	= Create u_Gs_Sp_Relance

/*------------------------------------------------------------------*/
/* On ne désire pas positionner les objets comme la fenêtre         */
/* ancêtre. On laisse une fonction 'locale' pour le positionnement. */
/*------------------------------------------------------------------*/
ibPositionnerObjet = FALSE
This.wf_PositionnerObjet_Relance ()

This.wf_Initialiser ( sTypeTrt )

end event

event spb_preparerimpression;call super::spb_preparerimpression;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Rel_Sold
//* Evenement 		: SPB_PreparerImpression
//* Auteur			: Fabry JF
//* Date				: 14/06/1999
//* Libellé			: Début impression des courriers.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
Long	l1erSin
Long  lCpt, lTotRow, lNbRow

/*------------------------------------------------------------------*/
/* On compte le nombre de Row selectionnés.                         */
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

/*------------------------------------------------------------------*/
/* Chargement ilSin avec la valeur du premier sinistre à éditer     */
/* pour que la rupture dans UE_IMPRIMERDOSSIER soit effectuée       */
/* correctement                                                     */
/*------------------------------------------------------------------*/
l1erSin	=	Dw_1.GetSelectedRow ( 0 )

If l1erSin > 0 Then
	ilSin			=  Dw_1.GetItemNumber ( l1erSin, "ID_SIN" )
End If

/*------------------------------------------------------------------*/
/* On arme une variable d'instance pour indiquer le fichier des     */
/* DATAS à utiliser pour les impressions.                           */
/*------------------------------------------------------------------*/
isRepCourrier	 = ProfileString ( stGLB.sFichierIni, "EDITION", "REP_COURRIER", "" )
isFicEnteteAnc  = ProfileString ( stGLB.sFichierIni, "EDITION", "ENTETE_ANC1", "" )
isFicEnteteNouv = ProfileString ( stGLB.sFichierIni, "EDITION", "ENTETE", "" )
idDteProdSve	 = Date ( ProfileString ( stGLB.sFichierIni, "EDITION", "DTE_PROD_SVE", "01/01/1900" ) )


end event

event ue_enablefenetre;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Rel_Sold (OVERRIDE)
//* Evenement 		: ue_EnableFenetre
//* Auteur			: Fabry JF
//* Date				: 18/06/1999 13:50:49
//* Libellé			: On rend Enabled certains objets après la fin traitement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Dw_Produit.Enabled	 	 = True
Dw_SaisieSin.Enabled		 = True
Pb_Creer.Enabled	 	  	 = True
Pb_Lancer.Enabled	 	  	 = False
Pb_Retour.Enabled	 	 	 = True

end event

event ue_item7;call super::ue_item7;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Relances (OVERRIDE)
//* Evenement 		: ue_Item7
//* Auteur			: Fabry JF
//* Date				: 11/06/1999 10:15:39
//* Libellé			: Lancement du Traitement
//* Commentaires	: A ce Moment Dw_1 est déjà Chargée
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean	bOk     = True
Boolean	bTrace  = False
Boolean	bSaisie = True       // A false en retour, indique qu'une saisie contrôlée par l'objet
										// est invalide.
String 	sMes						// Message d'erreur
String	sCodeMes 				// Code du message à afficher
Icon		icIcon   				// Icon

/*------------------------------------------------------------------*/
/* Lancement du traitement (une partie sur l'objet, l'autre sur la  */
/* la fenêtre).                                                 	  */
/*------------------------------------------------------------------*/
If bOk then
	bOk = iuo_Rel.uf_LancerTrt ( bSaisie )

	If Not bOk Then
		TriggerEvent ("ue_enablefenetre")

		// Ce n'est pas le traitement qui s'est planté
		// Mais la saisie qui n'est pas valide.
		If not bSaisie Then
			pb_Creer.enabled  = False
			pb_Lancer.enabled = True
			
		End IF 
	End If
End If

If bSaisie Then
	/*------------------------------------------------------------------*/
	/* Ecriture trace	dans [trace_recap_relance]							     */
	/*------------------------------------------------------------------*/
	iuo_rel.uf_ecriretrace (0, 1)
		
	CHOOSE CASE isTypTrt

		CASE "R1A", "R1T", "R1U", "R1P", "R2"
	
			If bOk Then
				
				if isTypTrt = "R1T" then
					// Supprimer lignes non sélectionné avant lancement de relance
					wf_discard_row()
					
				end if
	
				This.wf_Editer_Relance ()
	
				If wf_GetStopTraitement () Then
					sMes				 	= "Problème lors de l'édition. Le traitement se termine anormalement : prévenir le service informatique."
					sCodeMes				= "GENE012"
					icIcon				= Exclamation!
					bTrace				= True
					
				Else
					sMes				 	= "Le traitement s'est terminé normalement."
					sCodeMes				= "RELA140"
					icIcon				= Information!
					bTrace				= False
					
				End If
	
				stMessage.sCode    = sCodeMes
				stMessage.Icon	    = icIcon
				stMessage.sTitre   = "SIMPA2 - Relances"
				stMessage.sVar[1]  = sMes				 	
				stMessage.bTrace	 = bTrace
				F_Message ( stMessage )
	
			End If
	
		CASE "DR1"
	
				If Not bOk Then
					sMes				 	= "Problème lors de l'annulation de la relance. Le traitement se termine anormalement : prévenir le service informatique."
					sCodeMes				= "GENE012"
					icIcon				= Exclamation!
					bTrace				= True
					
				Else
					sMes				 	= "Première relance annulée. Le traitement s'est terminé normalement."
					sCodeMes				= "RELA140"
					icIcon				= Information!
					bTrace				= False
					
				End If
	
				stMessage.sCode    = sCodeMes
				stMessage.Icon	    = icIcon
				stMessage.sTitre   = "SIMPA2 - Relances"
				stMessage.sVar[1]  = sMes				 	
				stMessage.bTrace	 = bTrace
				F_Message ( stMessage )

	END CHOOSE

	stMessage.bTrace = False
	TriggerEvent ("ue_enablefenetre")

End If

end event

event spb_terminerimpression;call super::spb_terminerimpression;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Rel_Sold
//* Evenement 		: SPB_TerminerImpression
//* Auteur			: Fabry JF
//* Date				: 17/06/99 15:52:00
//* Libellé			: Termine impression d'un lot.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lRet

stMessage.bErreurG  = False
stMessage.sCode	  = "GENE012"
stMessage.sTitre    = "SIMPA2 - Relances"
stMessage.Icon	  	  = Exclamation!
stMessage.Bouton    = Ok!

If Not Wf_GetStopTraitement () Then
	
	If	lRet = 1	Then
		Mle_Msg.Uf_AjouterText ( "Fin de génération des courriers de relance.~r~n" )

	Else
		wf_SetStopTraitement ( FALSE )

		stMessage.sVar[1]   = " Le traitement est arrêté."	
		f_Message ( stMessage )
	End If
End If
end event

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Relances
//* Evenement 		: ue_Creer
//* Auteur			: Fabry JF
//* Date				: 08/06/1999 16:10:27
//* Libellé			: Chargement des Données
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean	bOk = True

/*------------------------------------------------------------------*/
/* On prepare le lancement du traitement.                           */
/*------------------------------------------------------------------*/
SetPointer ( HourGlass! )
bOk = iuo_Rel.uf_PreparerLancer ( ) 

If Not bOk Then
	TriggerEvent ("ue_EnableFenetre")

End If


If bOk Then

	CHOOSE CASE isTypTrt

		CASE "R1A", "R1U", "R2"

			This.pb_Retour.Enabled	= True
			This.pb_Creer.enabled	= False
			This.pb_Lancer.Enabled	= True

		CASE "R1P", "DR1", "R1T", "SOL"

			This.pb_Retour.Enabled	= True
			This.pb_Creer.Enabled	= False
			This.pb_Lancer.Enabled	= True

	END CHOOSE

End If

SetPointer ( Arrow! )

end event

on w_a_sp_relance.create
int iCurrent
call super::create
this.uo_defil=create uo_defil
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
this.dw_saisiesin=create dw_saisiesin
this.dw_courrier_relance=create dw_courrier_relance
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_defil
this.Control[iCurrent+2]=this.dw_produit
this.Control[iCurrent+3]=this.dw_para_prod
this.Control[iCurrent+4]=this.dw_police
this.Control[iCurrent+5]=this.uo_libelle
this.Control[iCurrent+6]=this.dw_civilite
this.Control[iCurrent+7]=this.pb_lancer
this.Control[iCurrent+8]=this.dw_boitearchive
this.Control[iCurrent+9]=this.dw_detpro
this.Control[iCurrent+10]=this.dw_page_blanche
this.Control[iCurrent+11]=this.pb_pageblanche
this.Control[iCurrent+12]=this.dw_gencourrier
this.Control[iCurrent+13]=this.dw_autorisation
this.Control[iCurrent+14]=this.dw_saisiesin
this.Control[iCurrent+15]=this.dw_courrier_relance
end on

on w_a_sp_relance.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_defil)
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
destroy(this.dw_saisiesin)
destroy(this.dw_courrier_relance)
end on

on close;call w_accueil_edition_2000::close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Rel_Sold
//* Evenement 		: Close
//* Auteur			: Fabry JF
//* Date				: 08/06/1999 14:27:13
//* Libellé			: Fermeture de la fenêtre
//* Commentaires	: Destruction des objets.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DESTROY iuo_Rel

end on

event ue_disablefenetre;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Rel_Sold (OVERRIDE)
//* Evenement 		: ue_DisableFenetre
//* Auteur			: Fabry JF
//* Date				: 18/06/1999 13:50:49
//* Libellé			: On rend disabled certains objets avant le lancement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Dw_Produit.Enabled	 	 = False
Dw_SaisieSin.Enabled		 = False
Pb_Creer.Enabled	 	  	 = False
Pb_Lancer.Enabled		 	 = False
Pb_Retour.Enabled	 	 	 = False

end event

event ue_retour;call super::ue_retour;
//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_relance
//* Evenement 		: ue_retour
//* Auteur			: JCA
//* Date				: 22/02/2008
//* Libellé			: 
//* Commentaires	: Fermeture du word et suppression du ficher word de consultation.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


string sNomFic
long lHandleWord

n_cst_word	nvWord
F_SetVersionWord ( nvWord, TRUE )

lHandleWord = w_mdi_sp.Wf_Browse_Fenetre ( "Microsoft Word", {"OpusApp"} )
sNomFic = stGLB.sRepTempo + "CONSCOUR.DOC"

If	lHandleWord > 0	Then Post ( lHandleWord, 274, 61536, 0 )

if f_FileExists (sNomFic) then FileDelete (sNomFic)

end event

type cb_debug from w_accueil_edition_2000`cb_debug within w_a_sp_relance
end type

type pb_retour from w_accueil_edition_2000`pb_retour within w_a_sp_relance
integer width = 242
integer height = 144
integer taborder = 90
end type

type pb_interro from w_accueil_edition_2000`pb_interro within w_a_sp_relance
boolean visible = false
integer x = 4229
integer y = 72
integer width = 146
integer height = 100
integer taborder = 0
boolean enabled = false
string picturename = ""
end type

type pb_creer from w_accueil_edition_2000`pb_creer within w_a_sp_relance
boolean visible = true
integer x = 279
integer y = 16
integer width = 242
integer height = 144
boolean enabled = true
string text = "&Charger"
string picturename = "k:\pb4obj\bmp\8_liste.bmp"
end type

type dw_1 from w_accueil_edition_2000`dw_1 within w_a_sp_relance
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
//* Libellé			: On ne tient plus compte du script ancêtre 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------



end on

event dw_1::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_accueil_edition::dw_1 (OverRide)
//* Evenement 		: Clicked
//* Auteur			: Fabry JF
//* Date				: 09/06/1999 16:52:12
//* Libellé			: On ne tient plus compte du script ancêtre
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

CHOOSE CASE isTypTrt

	CASE "R1P", "DR1"

		If row > 0 Then
			SelectRow ( 0, False   )
			SelectRow ( row, True )
		End If
		
END CHOOSE


end event

event dw_1::rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_accueil_edition::dw_1 (OVERRIDE)
//* Evenement 		: rButtonDown
//* Auteur			: JCA
//* Date				: 31/01/2008
//* Libellé			: On ne tient pas compte du script de l'ancêtre
//* Commentaires	: Permets d'afficher le courrier original pour la relance
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

string sNomFic, sRepCourrier, sModele, sDteEdit, sFicWinIni
decimal dcIdSin, dcIdInter, dcIdDoc
integer iRet
blob blBlob
Date dDteEdit

n_cst_word	nvWord
OleObject	OleWord

if isTypTrt = "R1T" then
	
	If row > 0 Then
		
		SetPointer ( HourGlass! )

		SelectRow ( 0, False   )
		SelectRow ( row, True )
	
		setnull(blBlob)
		
		// [DBG20241015131529340][CS_USPR_ALD_WINDIR] 
		If F_CLE_NUMERIQUE ( "CS_USPR_ALD_WINDIR" ) >= 2 Then
			sFicWinIni	= stGlb.uoWin.uf_getenvironment("USERPROFILE") + "\Windows\WIN.INI"
		Else
			sFicWinIni	= stGLB.sWinDir + "\WIN.INI"
		End If 
		// /[DBG20241015131529340] 
		
		sNomFic = stGLB.sRepTempo + "CONSCOUR.DOC"

		if f_FileExists (sNomFic) then FileDelete (sNomFic)
		
		dDteEdit = this.getitemdate ( row, "DTE_EDIT" )
		sDteEDit	= String ( Day ( dDteEdit ) ) + " " + F_Txt_Mois ( Month ( dDteEdit ) ) + " " + String ( Year ( dDteEdit ) )

		SetProfileString ( sFicWinIni, "SIMPA2", "Nouveau Courrier", sNomFic )
		SetProfileString ( sFicWinIni, "SIMPA2", "Dte Edition Nouveau Courrier", sDteEdit )
				
		/*------------------------------------------------------------------*/
		/* On va créer un Objet de Type OLE.                                */
		/*------------------------------------------------------------------*/
		oleWord = CREATE OleObject
	
		/*------------------------------------------------------------------*/
		/* On se connecte à WORD.                                           */
		/*------------------------------------------------------------------*/
		F_SetVersionWord ( nvWord, TRUE )
		iRet = nvWord.uf_CreerOleObject_Word ( oleWord )
	
		/*------------------------------------------------------------------*/
		/* La connexion échoue, on arrête tout.                             */
		/*------------------------------------------------------------------*/
		If	iRet <> 0	Then
			F_SetVersionWord ( nvWord, FALSE )
			Destroy oleWord
			Return
		End If
	
		/*------------------------------------------------------------------*/
		/* Si Word est déjà ouvert, on vérifie s'il existe des documents    */
		/* non sauvegardés. Si c'est le cas, on arrête tout.                */
		/*------------------------------------------------------------------*/
		iRet = nvWord.uf_FichierOuvertDansWord ( oleWord, TRUE, FALSE )
		If	iRet <> 1 Then
			F_SetVersionWord ( nvWord, FALSE )
			Destroy oleWord
			Return
			
		else
			nvWord.uf_fermerword( )
			if f_FileExists (sNomFic) then FileDelete (sNomFic)
			
		End If	

		dcIdSin = this.getitemnumber (row, "ID_SIN")
		dcIdInter = this.getitemnumber (row, "ID_I")
		dcIdDoc = this.getitemnumber (row, "ID_DOC")

		wf_Lire_Blob ( dcIdSin, dcIdInter, dcIdDoc, "DO", blBlob )
		F_EcrireFichierBlob ( blBlob, sNomFic )
		
		/*------------------------------------------------------------------*/
		/* On ouvre le fichier modéle par défaut, et on exécute la macro    */
		/* DUPLICATA.                                                       */
		/*------------------------------------------------------------------*/
		sRepCourrier	= ProfileString ( stGLB.sFichierIni, "EDITION", "REP_COURRIER", "" )
		sModele			= ProfileString ( stGLB.sFichierIni, "EDITION", "MODELE", "" )
		sModele			= sRepCourrier + sModele
		nvWord.uf_CommandeWord ( 1, sModele, oleWord )
		nvWord.uf_CommandeWord ( 2, "DUPLICATA", oleWord )
	
		F_SetVersionWord ( nvWord, FALSE )
		Destroy oleWord
		
		SetPointer ( Arrow! )
		
	end if	
	
end if

end event

type pb_tri from w_accueil_edition_2000`pb_tri within w_a_sp_relance
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

type pb_imprimer from w_accueil_edition_2000`pb_imprimer within w_a_sp_relance
integer x = 4233
integer y = 196
end type

type cb_tout from w_accueil_edition_2000`cb_tout within w_a_sp_relance
boolean visible = false
integer x = 3936
integer y = 80
integer taborder = 0
boolean enabled = false
end type

type cb_aucun from w_accueil_edition_2000`cb_aucun within w_a_sp_relance
boolean visible = false
integer x = 3936
integer y = 200
integer taborder = 0
boolean enabled = false
end type

type st_1 from w_accueil_edition_2000`st_1 within w_a_sp_relance
boolean visible = false
integer x = 539
integer y = 336
integer width = 325
integer height = 88
string text = "Lot en cours"
end type

type st_2 from w_accueil_edition_2000`st_2 within w_a_sp_relance
boolean visible = false
integer x = 544
integer y = 452
integer width = 325
integer height = 132
string text = "Edition du dossier"
end type

type st_nombre from w_accueil_edition_2000`st_nombre within w_a_sp_relance
boolean visible = false
integer x = 910
integer y = 336
integer width = 325
integer height = 88
end type

type st_edit from w_accueil_edition_2000`st_edit within w_a_sp_relance
boolean visible = false
integer x = 910
integer y = 452
integer width = 325
integer height = 88
end type

type mle_msg from w_accueil_edition_2000`mle_msg within w_a_sp_relance
integer x = 46
integer y = 328
integer width = 416
integer height = 360
end type

type pb_editer from w_accueil_edition_2000`pb_editer within w_a_sp_relance
boolean visible = false
integer x = 3959
integer y = 348
integer taborder = 0
boolean enabled = false
end type

type uo_defil from u_barredefil within w_a_sp_relance
integer x = 507
integer y = 616
integer width = 809
integer height = 76
integer taborder = 0
end type

type dw_produit from u_datawindow within w_a_sp_relance
boolean visible = false
integer x = 1925
integer y = 456
integer width = 1577
integer height = 88
integer taborder = 20
string dataobject = "d_sp_relance_pole"
boolean border = false
end type

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_anc::dw_produit
//* Evenement 		: ItemChanged
//* Auteur			: Fabry JF
//* Date				: 09/06/1999 14:19:34
//* Libellé			: Changement de produit.
//* Commentaires	: Une réinitialisation de certain objet est nécéssaire
//*					  Lorsque le produit change.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//       JFF   23/01/2018 [PM407-1]
//*-----------------------------------------------------------------

Parent.pb_Creer.Enabled 	 = True
Parent.pb_Lancer.Enabled 	 = False
Parent.uo_Defil.uf_Init ( 0 )
Parent.st_Nombre.Text = ""
Parent.st_Edit.Text = ""

Dw_1.Reset ()
iuo_Rel.uf_CacherTextDw1 ( "OUI" )




end event

event itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_anc::dw_produit
//* Evenement 		: ItemError
//* Auteur			: Fabry JF
//* Date				: 09/06/1999 14:19:34
//* Libellé			: Changement de produit.
//* Commentaires	: Une réinitialisation de certain objet est nécéssaire
//*					  Lorsque le produit change.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//       JFF   23/01/2018 [PM407-1]
//*-----------------------------------------------------------------


stMessage.sTitre		= "Relances automatisées"
stMessage.Icon			= Information!
stMessage.Bouton		= Ok!
stMessage.bErreurG	= False
stMessage.sCode		= "GENE179"
f_Message ( stMessage )	

Return 1
end event

type dw_para_prod from datawindow within w_a_sp_relance
boolean visible = false
integer x = 251
integer y = 1540
integer width = 347
integer height = 148
boolean bringtotop = true
string dataobject = "d_sp_relance_prod_para_pole"
end type

type dw_police from datawindow within w_a_sp_relance
boolean visible = false
integer x = 626
integer y = 1540
integer width = 347
integer height = 148
boolean bringtotop = true
string dataobject = "d_sp_rel_police"
end type

type uo_libelle from u_libelle_dga within w_a_sp_relance
boolean visible = false
integer x = 1376
integer y = 1540
integer width = 347
integer height = 148
end type

on uo_libelle.destroy
call u_libelle_dga::destroy
end on

type dw_civilite from datawindow within w_a_sp_relance
boolean visible = false
integer x = 1001
integer y = 1540
integer width = 347
integer height = 148
boolean bringtotop = true
string dataobject = "dddw_spb_code_civilite"
boolean livescroll = true
end type

type pb_lancer from picturebutton within w_a_sp_relance
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

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: pb_Lancer
//* Evenement 		: Cliked
//* Auteur			: Fabry JF
//* Date				: 11/06/1999 10:12:26
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.TriggerEvent ( "ue_Item7" )
end on

type dw_boitearchive from datawindow within w_a_sp_relance
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

type dw_detpro from datawindow within w_a_sp_relance
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

type dw_page_blanche from datawindow within w_a_sp_relance
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

type pb_pageblanche from picturebutton within w_a_sp_relance
boolean visible = false
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
boolean enabled = false
string text = "Page Arch"
string picturename = "k:\pb4obj\bmp\8_imp.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_sold::pb_pageblanche
//* Evenement 		: CLICKED
//* Auteur			: PLJ
//* Date				: 26/03/2004
//* Libellé			: Impression des pages blanches pour ligne cochée dans la liste
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

type dw_gencourrier from datawindow within w_a_sp_relance
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

type dw_autorisation from datawindow within w_a_sp_relance
boolean visible = false
integer x = 539
integer y = 1404
integer width = 242
integer height = 100
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_lst_autorisation"
boolean border = false
end type

type dw_saisiesin from u_datawindow within w_a_sp_relance
boolean visible = false
integer x = 1943
integer y = 324
integer width = 425
integer height = 88
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_sp_rel_sin"
boolean border = false
end type

on constructor;call u_datawindow::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Saisiesin
//* Evenement 		: Constructeur
//* Auteur			: Fabry JF
//* Date				: 11/06/1999 16:56:09
//* Libellé			: On ne gère pas le bouclage, car il n'y a qu'un champs
//*					  et cela pose quelques problèmes.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


ibGestionTouche = False
end on

event getfocus;call super::getfocus;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_anc::dw_SaisieSin
//* Evenement 		: GetFocus
//* Auteur			: Fabry JF
//* Date				: 25/06/1999 14:19:34
//* Libellé			: Changement de Ref Sin
//* Commentaires	: Une réinitialisation de certain objet est nécéssaire
//*					  Lorsque la Ref Sin change.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.pb_Creer.Enabled 	 = True
Parent.pb_Lancer.Enabled 	 = False
Parent.uo_Defil.uf_Init ( 0 )
Parent.st_Nombre.Text = ""
Parent.st_Edit.Text = ""

Dw_1.Reset ()
iuo_Rel.uf_CacherTextDw1 ( "OUI" )



end event

event itemchanged;call super::itemchanged;////*-----------------------------------------------------------------
////*
////* Objet 			: w_a_sp_rel_anc::dw_SaisieSin
////* Evenement 		: ItemChanged
////* Auteur			: Fabry JF
////* Date				: 23/06/1999 16:11:04
////* Libellé			: Contrôle de la zone
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


end event

event itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_rel_anc::dw_SaisieSin
//* Evenement 		: ItemError
//* Auteur			: Fabry JF
//* Date				: 23/06/1999 16:11:04
//* Libellé			: Contrôle de la zone
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iuo_Rel.uf_Zn_RefSin ( 2 )

Return 1
end event

type dw_courrier_relance from datawindow within w_a_sp_relance
boolean visible = false
integer x = 837
integer y = 1404
integer width = 242
integer height = 100
integer taborder = 130
boolean bringtotop = true
string title = "none"
string dataobject = "d_sp_courrier_relance"
boolean border = false
boolean livescroll = true
end type

