HA$PBExportHeader$u_cs_sp_sinistre.sru
forward
global type u_cs_sp_sinistre from u_cs_sp_ancetre
end type
end forward

global type u_cs_sp_sinistre from u_cs_sp_ancetre
end type
global u_cs_sp_sinistre u_cs_sp_sinistre

type variables
datastore idsBoutique // [DCMP090585]Datastore contenant les boutiques pour le produit
end variables

forward prototypes
public function boolean uf_preparer_consulter (ref s_pass astpass)
private function boolean uf_initialiser_dddw ()
public function string uf_titre ()
private subroutine uf_charger_revision ()
private function boolean uf_verif_travail (long alsin)
private function boolean uf_gestionboitearchive ()
private subroutine uf_gestong_divers ()
public subroutine uf_init_sinistre (ref u_transaction atrtrans, ref u_datawindow adw_si_sin, ref u_datawindow_detail adw_si_gti, ref u_datawindow_detail adw_si_inter, ref u_datawindow_detail adw_si_reglement, ref datawindow adw_si_produit, ref datawindow adw_si_frais, ref datawindow adw_si_detail, datawindow adw_si_reggti, ref datawindow adw_si_codegti, ref datawindow adw_si_codecond, ref datawindow adw_si_codecar, ref datawindow adw_si_refus, ref datawindow adw_si_motif, ref u_datawindow_detail adw_lstcontact, ref datawindow adw_corb, ref u_onglets auo_si_onglet, ref u_datawindow adw_dossuivipar, ref u_datawindow_detail adw_lstcmde, ref u_datawindow adw_btearch, ref u_datawindow adw_detpro, ref u_datawindow adw_divsin, ref u_datawindow adw_divdet, ref datawindow adddw_code_divsin_charg_tempo, ref datawindow adddw_codecar_divsin_charg_tempo)
end prototypes

public function boolean uf_preparer_consulter (ref s_pass astpass);//*-----------------------------------------------------------------
//* Objet			:	u_Cs_Sp_sinistre
//* Fonction		:	uf_preparer_Consulter
//* Auteur			:	PLJ
//* Date				:	18/07/1998
//*               :	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Pr$$HEX1$$e900$$ENDHEX$$paration pour l'instruction des dossiers
//* Commentaires	:	
//*
//* Arguments		:	s_Pass	astPass		(Ref)
//*                  
//*
//* Retourne		:	True / False
//*-----------------------------------------------------------------
//* #2		   JFF		05/09/2002 Gestion de la gestion de contact uniquement pour Sherpa
//* #3			JCA		22/08/2006 Mise en place du retrieve de DET_PRO avec pour param$$HEX1$$e800$$ENDHEX$$tre l'identifiant produit
//* #4			PHG		08/10/2009 Affichage Libelle Boutique suivant option DP 122
//				FPI		02/02/2011	[PC364]
//          JFF   05/02/2018 [PM360-2]
//*-----------------------------------------------------------------

Boolean 				bRet
DataWindowChild	dwChild, dwChild1									// Child temporaire pour g$$HEX1$$e900$$ENDHEX$$rer les DropDown
Long 					lIdProd, lIdRev, lIdSin, lCodTel, lDeb, lFin
String 				sOnglet
n_cst_string		lnvString // #4 [DCMP090585]
String sValCar

bRet = True

uf_Initialiser_DdDw ()										// Initialisation des DDDW pour idw_Si_Sinistre

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re l'enregistrement Sinistre                            */
/*------------------------------------------------------------------*/
If	idw_si_Sinistre.Retrieve ( astPass.lTab [ 1 ]  ) <= 0 Then bRet = False

	idw_DivSin.Retrieve ( astPass.lTab [ 1 ] )
	idw_DivSin.SetSort ( "CPT_TRI A" )
	idw_DivSin.Sort ()

	idw_DivDet.Retrieve ( astPass.lTab [ 1 ] )
	idw_DivDet.Sort ()

	/*------------------------------------------------------------------*/
	/* On garde le dernier N$$HEX2$$b0002000$$ENDHEX$$de produit en m$$HEX1$$e900$$ENDHEX$$moire pour $$HEX1$$e900$$ENDHEX$$viter de le   */
	/* recharger si besoin.                                             */
	/*------------------------------------------------------------------*/
	If	bRet Then
		lIdProd	= idw_Si_Sinistre.GetItemNumber ( 1, "ID_PROD" )
		If	lIdProd <> ilDernierIdProd Then

		/*------------------------------------------------------------------*/
		/* On charge les informations des colonnes ID_NAT_SIN, ID_TERRIT,   */
		/* ID_DETSIN.                                                       */
		/*------------------------------------------------------------------*/
	
		idw_Si_Sinistre.GetChild ( "ID_NATSIN", dwChild )
		dwChild.SetTransObject ( This.itrTrans )
		dwChild.Retrieve ( lIdProd, "+NS" )

		idw_Si_Sinistre.GetChild ( "ID_TERRIT", dwChild )
		dwChild.SetTransObject ( This.itrTrans )
		dwChild.Retrieve ( lIdProd, "+TR" )

		idw_Si_Sinistre.GetChild ( "ID_DETSIN", dwChild )
		dwChild.SetTransObject ( This.itrTrans )
		dwChild.Retrieve ( lIdProd, "+DT" )
		
		//* #3
		idw_DetPro.Retrieve ( lIdProd )
		idw_DetPro.Sort ()

		If	idw_Si_Produit.Retrieve ( lIdProd ) <= 0 Then 
			bRet = False
		Else
			/*------------------------------------------------------------------*/
			/* Chargement des colonnes ID_ETS, ID_GTI 						        */
			/*------------------------------------------------------------------*/

			/*------------------------------------------------------------------*/
			/* On m$$HEX1$$e900$$ENDHEX$$morise la Gestion Contact.									  		  */
			/*------------------------------------------------------------------*/
			ibAltContact = idw_Si_Produit.GetItemString ( 1, "ALT_CONTACT" ) = "O"
			ibAltContactSherpa = False

			/*------------------------------------------------------------------*/
			/* #2 : JFF le 04/09/2002														  */
			/*------------------------------------------------------------------*/
			If Not ibAltContact Then
				ibAltContactSherpa = idw_Si_Produit.GetItemString ( 1, "ALT_CONTACT" ) = "S"
			End If
			ibAltCmdeMobile = idw_Si_Produit.GetItemString ( 1, "ALT_CMD_MOBILE" ) = "O"


			/*------------------------------------------------------------------*/
			/* On m$$HEX1$$e900$$ENDHEX$$morise la Gestion de la t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie.								  */
			/*------------------------------------------------------------------*/
			lCodTel = idw_Si_Produit.GetItemNumber ( 1, "COD_TEL" )
			ibAltTelephonie = lCodTel > 0 				

			
			idw_Si_Sinistre.GetChild ( "ID_ETS", dwChild )
			dwChild.SetTransObject ( This.itrTrans )
			dwChild.Retrieve ( lIdProd, -1 )

			idw_Si_CodeGarantie.Retrieve ( lIdProd )
			idw_Si_Gti.GetChild ( "ID_GTI", dwChild )
			idw_Si_CodeGarantie.ShareData ( dwChild )


			/*------------------------------------------------------------------*/
			/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la liste des conditions pour les $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nements. (+EV)   */
			/*------------------------------------------------------------------*/
			idw_Si_CodeCondition.Retrieve ( lIdProd, "+EV" )

			/*--------------------------------------------------------------------*/
			/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la liste des type de cartes de la table CODE_CAR (-TC) */
			/*--------------------------------------------------------------------*/
			idw_Si_CodeCarTC.Retrieve ( "-TC" )


			/*----------------------------------------------------------------*/
			/* On charge les informations relatives $$HEX2$$e0002000$$ENDHEX$$la r$$HEX1$$e900$$ENDHEX$$vision ( MOTIF )   */
			/*----------------------------------------------------------------*/
			
			Uf_Charger_Revision ()

			ilDernierIdProd	= lIdProd
			ilDernierIdRev		= idw_Si_Sinistre.GetItemNumber ( 1, "ID_REV" )
			
			// #4 [DCMP090585] On intialise les boutique les boutiques pour le produit
			if idw_Si_Produit.GetItemString ( 1, "ALT_COD_BOUTIQUE" ) = "O" then
				// On charge les boutique dans le datastore de ref$$HEX1$$e900$$ENDHEX$$rence.
				if not isvalid(idsBoutique) then idsBoutique= create datastore
				idsBoutique.Dataobject = "d_lst_boutique"
				idsBoutique.SetTransObject(SQLCA)
				if idsBoutique.Retrieve(lIdProd) > 0 then
					
					F_RechDetPro ( lDeb, lFin, idw_DetPro, lIdProd, "-DP", 122 ) // D$$HEX1$$e900$$ENDHEX$$termination via option 122 de la colonne a afficher
					If lDeb > 0 Then
						choose case upper(lnvString.of_getkeyvalue( idw_DetPro.object.val_car[lDeb], "AFF", ";"))
							case "VILLE"
								idw_Si_Sinistre.object.id_orian_boutique.dddw.displaycolumn = "c_aff_adrville"
							case "NOM"
								idw_Si_Sinistre.object.id_orian_boutique.dddw.displaycolumn = "c_aff_adrnom"
							case else
								idw_Si_Sinistre.object.id_orian_boutique.dddw.displaycolumn = "id_boutique"
						End Choose
					Else
						idw_Si_Sinistre.object.id_orian_boutique.dddw.displaycolumn = "id_boutique"
					End IF

					idw_Si_Sinistre.GetChild ( "ID_ORIAN_BOUTIQUE", dwChild )
					idsBoutique.ShareData(dwChild)
				End IF
			End IF
			// Fin [DCMP090585]
		End If
	Else
		/*------------------------------------------------------------------*/
		/* On est dans le m$$HEX1$$ea00$$ENDHEX$$me produit, mais pour la r$$HEX1$$e900$$ENDHEX$$vision il faut       */
		/* faire le test.                                                   */
		/*------------------------------------------------------------------*/
		lIdRev = idw_Si_Sinistre.GetItemNumber ( 1, "ID_REV" )
		If	lIdRev <> ilDernierIdRev	Then
			Uf_Charger_Revision ()
			ilDernierIdRev		= lIdRev
		End If

	End If

End If

If	bRet Then

	lIdSin = idw_Si_Sinistre.GetItemNumber ( 1, "ID_SIN" ) 

	idw_Si_Inter.Retrieve  		( lIdSin )										// Chargement liste des interlocuteurs
	idw_Si_Gti.Retrieve    		( lIdSin )										//     "        "    "  garanties
	idw_Si_Reglement.Retrieve	( lIdSin )										//     "        "    "  reglement
	idw_Si_Frais.Retrieve  		( lIdSin )										//     "      des frais
	idw_Si_Detail.Retrieve 		( lIdSin )										//     "      des d$$HEX1$$e900$$ENDHEX$$tails
	idw_Si_Refus.Retrieve  		( lIdSin )										//		 "      des refus
	idw_Si_RegGti.Retrieve  	( lIdSin )										//		 "      des Reglements Par Garantie


	/*------------------------------------------------------------------*/
	/* #1 : si la gestion contacts est $$HEX2$$e0002000$$ENDHEX$$'O' alors on les charge.		  */
	/*------------------------------------------------------------------*/
	If ibAltContact Then
		If idw_LstContact.Retrieve ( lIdSin ) > 0 Then
			idw_LstContact.SetSort ( "CREE_LE D") 
			idw_LstContact.Sort () 
			idw_LstContact.SelectRow ( 0, False )
			idw_LstContact.SelectRow ( 1, True )
		End If
	End If

/*------------------------------------------------------------------*/
/* #2 : JFF le 04/09/2002														  */
/*------------------------------------------------------------------*/
	If ibAltContact Or ibAltContactSherpa Then
		idw_DosSuiviPar.Reset () 
		idw_DosSuiviPar.Retrieve ( lIdSin )
		If idw_DosSuiviPar.RowCount () <= 0 Then idw_DosSuiviPar.InsertRow ( 0 )

		idw_DosSuiviPar.GetChild ( "DOS_SUIVI_PAR", dwChild1 )
		dwChild1.SetFilter ( "ID_CORB = " + String ( idw_Si_Produit.GetItemNumber ( 1, "ID_CORB") ) )
		dwChild1.Filter ()
		idw_DosSuiviPar.Show ()

	Else
		idw_DosSuiviPar.Hide ()
		idw_DosSuiviPar.SetItem ( 1, "DOS_SUIVI_PAR", stNul.Str )
	End If

	If ibAltCMdeMobile Then
		If idw_LstCmde.Retrieve ( lIdSin ) > 0 Then
			idw_LstCmde.SetSort ( "ID_SEQ D") 
			idw_LstCmde.Sort () 
			If idw_LstCmde.RowCount () > 0 Then 
				idw_LstCmde.ScrollToRow ( 1 )
				idw_LstCmde.SetRow ( 1 )
			End If
		End If
	End If

	/*------------------------------------------------------------------*/
	/* On bascule le focus sur le 1er Onglet (DataWindow de SINISTRE)   */
	/* par d$$HEX1$$e900$$ENDHEX$$faut.                                                      */
	/*------------------------------------------------------------------*/

	sOnglet = iUo_Onglet.Uf_RecupererOngletCourant ()			
	If sOnglet <> "01" Then											
  		iUo_Onglet.Uf_ChangerOnglet ("01")						
	End If

/*------------------------------------------------------------------*/
/* DGA. Le 21/08/2003.                                              */
/* Gestion des boites archives.                                     */
/*------------------------------------------------------------------*/
	This.uf_GestionBoiteArchive ()

End If

astPass.bRetour = bRet

/*------------------------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification si un travail existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$pour le dossier           */
/* s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$, et le signale 												  */
/*------------------------------------------------------------------*/
Uf_Verif_Travail ( lIdSin )

/*------------------------------------------------------------------*/
/* Gestion de l'oglet Divers.                                       */
/*------------------------------------------------------------------*/
uf_GestOng_Divers ()

// [PC364]
idw_si_sinistre.Modify( "t_14.Text='N$$HEX2$$b0002000$$ENDHEX$$Contrat'" )

F_RechDetPro ( lDeb, lFin, idw_DetPro,lIdProd, "-DP", 161 )
If lDeb > 0 Then
	sValCar=idw_DetPro.GetItemString(lDeb,"VAL_CAR")
	sValCar=lnvString.of_getkeyvalue( sValCar, "NOUVEAU_LIBELLE_11_car_max", ";")
	If not (isNull(sValCar) or sValCar = "") Then
		idw_si_sinistre.Modify( "t_14.Text='" + Left(sValCar,11) + "'" )
	End if
End If
// :[PC364]

// [PM360-2]
F_RechDetPro ( lDeb, lFin, idw_DetPro,  idw_Si_Sinistre.GetItemNumber ( 1, "ID_PROD" ), '-DP', 324 )
If lDeb <= 0 Then	
	idw_Si_Inter.Modify ( "rib_cpt.format='[GENERAL]~tfill (~~'XX~~', 9) + right (rib_cpt, 2)'" )
Else 
	idw_Si_Inter.Modify ( "rib_cpt.format='[GENERAL]'" )		
End If

return bRet

end function

private function boolean uf_initialiser_dddw ();//*-----------------------------------------------------------------
//* Objet			:	u_Cs_Sp_sinistre
//* Fonction		:	uf_Initialiser_DdDw	(Private)
//* Auteur			:	PLJ
//* Date				:	17/05/1998
//*               :	
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation des DropDownDataWindows ind$$HEX1$$e900$$ENDHEX$$pendantes
//*						de idw_Si_Sinistre
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*                  
//*
//* Retourne		:	True / False
//*
//*-----------------------------------------------------------------


DataWindowChild		dwChild, dwChild1


/*------------------------------------------------------------------*/
/* Chargement des DdDw ne d$$HEX1$$e900$$ENDHEX$$pendant d'aucun champ de Sinistre.      */
/* COD_I_DECL, COD_CIV, COD_DEC_MAC, COD_DEC_OPE, COD_ETAT,         */
/* COD_MOT_SSUI, COD_MOD_REG.                              			  */
/*------------------------------------------------------------------*/

idw_Si_Sinistre.GetChild ( "COD_I_DECL", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-IN" )

idw_Si_Sinistre.GetChild ( "COD_CIV", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-CI", "-CL" )

idw_Si_Sinistre.GetChild ( "COD_DEC_MAC", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-ET" )

idw_Si_Sinistre.GetChild ( "COD_DEC_OPE", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Si_Sinistre.GetChild ( "COD_ETAT", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Si_Sinistre.GetChild ( "COD_MOT_SSUI", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-SS" )

idw_Si_Inter.GetChild ( "COD_MODE_REG", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-MR" )

idw_LstContact.GetChild ( "ID_CANAL", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-CR" )

/*------------------------------------------------------------------*/
/* Les deux retrieve ci-dessous ne servent en fait $$HEX2$$e0002000$$ENDHEX$$rien. Il       */
/* s'agit juste de mettre quelquechose dans la DDDW afin qu'elle    */
/* soit initialis$$HEX1$$e900$$ENDHEX$$e. Le contenu sera r$$HEX2$$e900e900$$ENDHEX$$lement arm$$HEX2$$e9002000$$ENDHEX$$dans            */
/* uf_GestOng_Divers                                                */
/*------------------------------------------------------------------*/
idw_DivSin.GetChild ( "VAL_LST_CAR", dwChild  )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-FR" )
idw_DivSin.GetChild ( "VAL_LST_NBRE", dwChild  )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-FR" )

idw_DivDet.GetChild ( "VAL_LST_CAR", dwChild  )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-FR" )
idw_DivDet.GetChild ( "VAL_LST_NBRE", dwChild  )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-FR" )

/*-------------------------------------------------------------------*/
/* On initialise les autres DDDW $$HEX2$$e0002000$$ENDHEX$$vide. Le retrieve sera effectu$$HEX4$$e900200020002000$$ENDHEX$$*/
/* sur le uf_preparer_consulter apr$$HEX1$$e800$$ENDHEX$$s le retrieve de idw_Si_Sinistre */
/*-------------------------------------------------------------------*/
idw_Si_Sinistre.GetChild ( "ID_NATSIN", dwChild )
dwChild.InsertRow ( 0 )

idw_Si_Sinistre.GetChild ( "ID_TERRIT", dwChild )
dwChild.InsertRow ( 0 )

idw_Si_Sinistre.GetChild ( "ID_DETSIN", dwChild )
dwChild.InsertRow ( 0 )

idw_Si_Sinistre.GetChild ( "ID_ETS", dwChild )
dwChild.InsertRow ( 0 )


/*------------------------------------------------------------------*/
/* Initialisation des datawindows n$$HEX1$$e900$$ENDHEX$$cessitant qu'un ShareData       */
/*------------------------------------------------------------------*/
idw_Si_Sinistre.GetChild ( "COD_I_DECL", dwChild )
idw_Si_Inter.GetChild ( "COD_INTER", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Si_Sinistre.GetChild ( "COD_CIV", dwChild )
idw_Si_Inter.GetChild ( "COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_Si_Reglement.GetChild ( "ID_I", dwChild)
idw_Si_Inter.ShareData ( dwChild )

/*------------------------------------------------------------------*/
/* Chargement des codes pour les commandes.                         */
/*------------------------------------------------------------------*/
idw_LstCmde.GetChild ( "ID_TYP_ART", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-AR" )

idw_LstCmde.GetChild ( "COD_ETAT", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-EC" )

idw_LstCmde.GetChild ( "ID_FOUR", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-FR" )

/*------------------------------------------------------------------*/
/* # CAG : Modification SFR # Le 06/09/2002.                        */
/*------------------------------------------------------------------*/
idw_LstCmde.GetChild ( "ID_BSP", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-BR" )

idw_Si_Sinistre.GetChild ( "COD_CIV", dwChild )
idw_LstCmde.GetChild ( "ADR_COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )

return true
end function

public function string uf_titre ();//*-----------------------------------------------------------------
//*
//* Objet			: U_Cs_Sp_Sinistre
//* Fonction		: Uf_Titre (PUBLIC)
//* Auteur			: PLJ
//* Date				: 17/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Reourne titre pour la fen$$HEX1$$ea00$$ENDHEX$$tre CONSULTATION SINISTRE
//*
//* Arguments		: Aucun
//*
//* Retourne		: String			Titre de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//*-----------------------------------------------------------------


String sRet, sCodCiv, sNom, sPrenom, sLibCourt
Long   lIdSin, lIdProd, lIdRev

sCodCiv		= idw_Si_Sinistre.Describe ( "Evaluate ( 'LookUpDisplay ( COD_CIV )', 1 ) " )
sNom			= idw_Si_Sinistre.GetItemString ( 1, "NOM" )
sPrenom		= idw_Si_Sinistre.GetItemString ( 1, "PRENOM" )
sLibCourt	= idw_Si_Produit.GetItemString  ( 1, "LIB_COURT" )

lIdSin   	= idw_Si_Sinistre.GetItemNumber ( 1, "ID_SIN" )
lIdProd		= idw_Si_Sinistre.GetItemNumber ( 1, "ID_PROD" )
lIdRev		= idw_Si_Sinistre.GetItemNumber ( 1, "ID_REV" )

sRet =	sLIbCourt								+ " ("					+ &
			String ( lIdProd )					+ ") (R$$HEX1$$e900$$ENDHEX$$v : "			+ &
			String ( lIdRev )						+ ") / Sinistre N$$HEX2$$b0002000$$ENDHEX$$"	+ &
			String ( lIdSin )						+ "/"  					+ &
			sCodCiv									+ " "						+ &
			sNom										+ " "						+ &
			sPrenom



Return ( sRet )

end function

private subroutine uf_charger_revision ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Charger_Revision (PRIVATE)
//* Auteur			: PLJ
//* Date				: 29/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Retrieve sur motif suivant la r$$HEX1$$e900$$ENDHEX$$vision
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long dcIdProd, dcIdRev

dcIdRev	= idw_Si_Sinistre.GetItemNumber ( 1, "ID_REV" )
dcIdProd	= idw_Si_Sinistre.GetItemNumber ( 1, "ID_PROD" )

If	dcIdRev = -1	Then
	
	idw_Si_Motif.Retrieve ( dcIdProd, dcIdProd )

Else

	idw_Si_Motif.Retrieve ( dcIdProd, dcIdRev )

End If

end subroutine

private function boolean uf_verif_travail (long alsin);////*-----------------------------------------------------------------
////*
////* Fonction		:	uf_Verif_Travail : Private
////* Auteur			:	PLJ
////* Date				:	31/08/98
////* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	V$$HEX1$$e900$$ENDHEX$$rification si travail en cours
////* Commentaires	:	
////*
////* Arguments		:	alsin : Num$$HEX1$$e900$$ENDHEX$$ro de sinistre
////*
////* Retourne		:	True si aucun travail n'est en cours
////*
////*-----------------------------------------------------------------
//
//Boolean bOk = True
//String  sEtat
//
//String sCodTable
//String sAltQueue
//Long   lNbSinistre
//String sMsg
//String sCOdEtat
//String sAltOccupe
//String sMajPAr
//
//
//sAltQueue  = Space ( 1 )
//sAltOccupe = Space ( 1 )
//sCodEtat   = Space ( 1 )
//sMsg	     = Space ( 254 )
//sMajPar    = space ( 4 )
//
//itrTrans.IM_V01_TRVEXIST ( alSin      , &
//                           sCodTable  , &
//                           sAltQueue  , &
//                           lNbSinistre, &
//                           sMsg  , &
//                           sCodEtat   , &
//                           sALtOccupe , &
//                           sMajPar     )
//
//// .... Il existe un travail pour ce dossier : Avertissement
//
//If sAltQueue = "O" And sCodTable = "W" Then
//
//	Choose Case sCodEtat						// .... Quelle phase ?
//	Case "1"
//		stMessage.sVar[1] = "de saisie"
//	Case "3"
//		stMessage.sVar[1] = "d'$$HEX1$$e900$$ENDHEX$$dition"
//	Case "5"
//		stMessage.sVar[1] = "de validation"
//	End Choose
//
//	If sAltOccupe = "O" Then				// .... Le travail est-il en cours ?
//
//		stMessage.sVar[1] += "~r~n( actuellement trait$$HEX2$$e9002000$$ENDHEX$$par " + sMajPar + " )"
//
//	End If
//
//	stMessage.sTitre 	= "Consultation du dossier " + String( alSin )
//	stMessage.Bouton	= Ok!
//	stMessage.Icon		= Exclamation!
//	stMessage.sCode	= "WKF0012"
//
//	f_message ( stMessage )
//
// 	Return False
//
//End If

Return True

end function

private function boolean uf_gestionboitearchive ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Cs_Sp_Sinistre::uf_GestionBoiteArchive			(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/08/2003 10:03:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On s'occupe de la gestion des boites $$HEX2$$e0002000$$ENDHEX$$archive
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean			TRUE 	= Tout se passe bien
//*										 	FALSE	= Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1		 JFF	08/01/2007 On doit pouvoir consulter dans ts les cas.
//*          JFF  23/05/2019 Je rends invisible la lignes de BAC.
//*-----------------------------------------------------------------

Long lDeb, lFin, lIdProd
Boolean bRet

bRet = TRUE

/*------------------------------------------------------------------*/
/* DGA. Le 21/08/2003.                                              */
/* Gestion des boites archives.                                     */
/*------------------------------------------------------------------*/
idw_BoiteArchive.Reset ()
idw_BoiteArchive.Visible	= FALSE
idw_BoiteArchive.Enabled	= FALSE

lIdProd		= idw_Si_Sinistre.GetItemNumber ( 1, "ID_PROD" )

// F_RechDetPro ( lDeb, lFin, idw_DetPro, lIdProd, "-DP", 4 ) #1
lDeb = 1  // #1

If	lDeb > 0	Then
/*------------------------------------------------------------------*/
/* On va armer toutes les valeurs n$$HEX1$$e900$$ENDHEX$$cessaires dans la DW            */
/* (PROCEDURE PS_S01_BOITE_ARCHIVE).                                */
/*------------------------------------------------------------------*/
	idw_BoiteArchive.Retrieve ( idw_Si_Sinistre.GetItemNumber ( 1, "ID_SIN" ), stGLB.sCodOper )
//	idw_BoiteArchive.SaveAs   ( "c:\aaa\bte_arch.xls", Excel!, True )
//	idw_BoiteArchive.Visible	= TRUE
	idw_BoiteArchive.Visible	= False 
End If
		
Return ( bRet )

end function

private subroutine uf_gestong_divers ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_cs_sp_sinistre::uf_GestOng_Divers (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 16/06/2004 11:13:57
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Gestion de l'onglet DIVERS
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*		FPI	27/02/2013	[PC856] Mantis 6873 -  correction affichage dans onglet "divers"
//*      JFF	02/11/2017  [MODIF_THIBAULT]
//*-----------------------------------------------------------------
Long lTotParam, lCptParam, lCptDivS, lRowDS, lRowDP, lTotDivS, lNull, lTotVal, lCptVal, lRowChild 
String	sNomZoneP, sNomZoneS, sIdTypListe, sNull, sAltLstCodeCar, sNomZone, sData
Decimal  dcNull
Date		dNull
DataWindowChild	dwChildCodeCar, dwChildCode 

SetNull ( dNull )
SetNull ( lNull )
SetNull ( sNull )
SetNull ( dcNull )

lTotDivS  = idw_DivSin.RowCount ()

idw_DivSin.GetChild ( "VAL_LST_CAR", dwChildCodeCar )
dwChildCodeCar.Reset ()

idw_DivSin.GetChild ( "VAL_LST_NBRE", dwChildCode )
dwChildCode.Reset ()

For lCptDivS = 1 To lTotDivS
	sIdTypListe = idw_DivSin.GetItemString ( lCptDivS, "ID_TYP_LISTE" ) 

/*---------------------------------------------------------------------*/
/* Liste $$HEX2$$e0002000$$ENDHEX$$charger (on ne peut en charger qu'une seule de chaque type!)*/
/*---------------------------------------------------------------------*/
	If sIdTypListe <> "-1" Then
		Choose Case idw_DivSin.GetItemString ( lCptDivS, "ALT_LISTE_CODECAR" ) 

			// Retrieve sur Code_Car
			Case "O"

				idddw_CodeCar_DivSin_Charg_Tempo.Retrieve ( sIdTypListe )

				lTotVal = idddw_CodeCar_DivSin_Charg_Tempo.RowCount ()
							
				For lCptVal = 1 To lTotVal
					lRowChild = dwChildCodeCar.InsertRow ( 0 )
 					dwChildCodeCar.SetItem ( lRowChild, "ID_CODE", idddw_CodeCar_DivSin_Charg_Tempo.GetItemString ( lCptVal, "ID_CODE" ) )
					dwChildCodeCar.SetItem ( lRowChild, "LIB_CODE", idddw_CodeCar_DivSin_Charg_Tempo.GetItemString ( lCptVal, "LIB_CODE" ) )
					dwChildCodeCar.SetItem ( lRowChild, "NOM_ZONE", idw_DivSin.GetItemString ( lCptDivS, "NOM_ZONE" ) )
					dwChildCodeCar.SetItem ( lRowChild, "ALT_VISIBLE", 2 ) 
					
					//	[PC856]
					if idddw_CodeCar_DivSin_Charg_Tempo.GetItemString ( lCptVal, "ID_CODE" ) = idw_DivSin.GetItemString(lCptDivS,"VAL_CAR") Then
						 idw_DivSin.SetItem(lCptDivS,"VAL_CAR", idddw_CodeCar_DivSin_Charg_Tempo.GetItemString ( lCptVal, "LIB_CODE" ))
						  idw_DivSin.SetItem(lCptDivS,"ALT_LISTE_CODECAR","N")
						  idw_DivSin.SetItem(lCptDivS,"ID_TYP_ZONE","C")
					End if				
					
				Next


			// Retrieve sur Code
			Case "N"			
				idddw_Code_DivSin_Charg_Tempo.Retrieve ( sIdTypListe )

				lTotVal = idddw_Code_DivSin_Charg_Tempo.RowCount ()

				For lCptVal = 1 To lTotVal
					lRowChild = dwChildCode.InsertRow ( 0 )
					dwChildCode.SetItem ( lRowChild, "ID_CODE", idddw_Code_DivSin_Charg_Tempo.GetItemNumber ( lCptVal, "ID_CODE" ) )
					dwChildCode.SetItem ( lRowChild, "LIB_CODE", idddw_Code_DivSin_Charg_Tempo.GetItemString ( lCptVal, "LIB_CODE" ) )
					dwChildCode.SetItem ( lRowChild, "NOM_ZONE", idw_DivSin.GetItemString ( lCptDivS, "NOM_ZONE" ) )
					dwChildCode.SetItem ( lRowChild, "ALT_VISIBLE", 2 ) 
					
					//	[PC856]
					if idddw_Code_DivSin_Charg_Tempo.GetItemString ( lCptVal, "ID_CODE" ) = idw_DivSin.GetItemString(lCptDivS,"VAL_CAR") Then
						 idw_DivSin.SetItem(lCptDivS,"VAL_CAR", idddw_Code_DivSin_Charg_Tempo.GetItemString ( lCptVal, "LIB_CODE" ))
						  idw_DivSin.SetItem(lCptDivS,"ALT_LISTE_CODECAR","N")
						  idw_DivSin.SetItem(lCptDivS,"ID_TYP_ZONE","C")
					End if				
					
				Next


		End Choose
	End If
	
	// [MODIF_THIBAULT]
	sNomZone = Upper ( idw_DivSin.GetItemString ( lCptDivS, "NOM_ZONE" ) )	
	
	Choose Case sNomZone	
		Case "ETAT_VU_ASSURE"
			sData = String ( idw_DivSin.GetItemNumber ( lCptDivS, "VAL_NBRE" ) )
			
			If sData = "100" Then 
				idw_DivSin.SetItem ( lCptDivS, "VAL_NBRE", 101 )	
			End If
	End Choose 
Next

idw_DivSin.Sort ()

end subroutine

public subroutine uf_init_sinistre (ref u_transaction atrtrans, ref u_datawindow adw_si_sin, ref u_datawindow_detail adw_si_gti, ref u_datawindow_detail adw_si_inter, ref u_datawindow_detail adw_si_reglement, ref datawindow adw_si_produit, ref datawindow adw_si_frais, ref datawindow adw_si_detail, datawindow adw_si_reggti, ref datawindow adw_si_codegti, ref datawindow adw_si_codecond, ref datawindow adw_si_codecar, ref datawindow adw_si_refus, ref datawindow adw_si_motif, ref u_datawindow_detail adw_lstcontact, ref datawindow adw_corb, ref u_onglets auo_si_onglet, ref u_datawindow adw_dossuivipar, ref u_datawindow_detail adw_lstcmde, ref u_datawindow adw_btearch, ref u_datawindow adw_detpro, ref u_datawindow adw_divsin, ref u_datawindow adw_divdet, ref datawindow adddw_code_divsin_charg_tempo, ref datawindow adddw_codecar_divsin_charg_tempo);

//*
//* Objet         :  u_Cs_Sp_Sinistre
//* Fonction		:	uf_Init_Sinistre
//* Auteur			:	PLJ
//* Date				:	16/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences aux objets de 
//*                  de  la  fen$$HEX1$$ea00$$ENDHEX$$tre  de  consultation  SINISTRE
//*						+ affectation de l'objet de transaction sur
//*						les datawindows n$$HEX1$$e900$$ENDHEX$$cessitant un Retrieve. 
//* Commentaires	:	
//*
//* Arguments		:	u_Transaction					atrTrans
//*						u_DataWindow					idw_Si_Sinistre			
//*						u_DataWinDow_Detail			adw_Si_Gti	
//*						u_DataWinDow_Detail			adw_Si_Inter
//*						u_DataWindow_Detail			adw_Si_Reglement
//*						DataWindow						adw_Si_Produit
//*						DataWindow						adw_Si_Frais
//*						DataWindow						adw_Si_Detail
//*						DataWindow						adw_si_reggti
//*						DataWindow						adw_Si_CodeGarantie
//*						DataWindow						adw_Si_CodeCondition
//*						DataWindow						adw_si_codecar
//*						DataWindow						adw_Si_Refus
//*						DataWindow						adw_Si_Motif
//*						u_Onglets						auo_Si_Onglet
//*						...
//*						U_DataWindow					adw_BoiteArchive
//*						U_DataWindow					adw_DetPro
//*						U_DataWindow					adw_DivSin
//*						U_DataWindow					adw_DivDet
//*						DataWindow						adddw_code_divsin_charg_tempo
//*						DataWindow						adddw_codecar_divsin_charg_tempo
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------
//* #1 	 JCA   22/08/2006   Suppression chargement DetPro d$$HEX1$$e900$$ENDHEX$$port$$HEX2$$e9002000$$ENDHEX$$sur uf_preparer_consulter
//* #2 DGA      19/09/2006   Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire DCMP-060643
//*-----------------------------------------------------------------

String sFic
DataWindowChild dwChild

itrTrans     			= atrTrans						// ... Transaction

idw_Si_Sinistre   	= adw_Si_Sin					// ... Dw en-t$$HEX1$$ea00$$ENDHEX$$te de Sinistre			
idw_Si_Gti		   	= adw_Si_Gti			  		// ... Dw liste des garanties
idw_Si_Inter 			= adw_Si_Inter					// ... Dw liste des interlocuteurs
idw_Si_Reglement		= adw_Si_Reglement			// ... Dw liste des d$$HEX1$$e900$$ENDHEX$$tails
idw_Si_Detail			= adw_Si_Detail				// ... Dw liste des d$$HEX1$$e900$$ENDHEX$$tails
idw_Si_RegGti			= adw_Si_RegGti				// ... Dw liste des d$$HEX1$$e900$$ENDHEX$$tails

idw_Si_Produit			= adw_Si_Produit				// ... DW des produits
idw_Si_Frais			= adw_Si_Frais					// ... Dw des frais
idw_Si_CodeGarantie	= adw_Si_CodeGti				// ... Dw des codes garantie
idw_Si_CodeCondition	= adw_Si_CodeCond				// ... Dw des conditions
idw_Si_CodeCarTc		= adw_Si_CodeCar				// ... Dw des Codes Caract$$HEX1$$e800$$ENDHEX$$res

idw_Si_Refus			= adw_Si_Refus					// ... Dw des refus
idw_Si_Motif			= adw_si_Motif					// ... Dw des motifs

iuo_onglet				= auo_Si_Onglet				// ... Onglet

idw_LstContact			= adw_LstContact
idw_Si_Corb				= adw_Corb

idw_LstCmde 			= adw_LstCmde

/*------------------------------------------------------------------*/
/* Initialisation des objets de transaction                         */
/*------------------------------------------------------------------*/

idw_Si_Sinistre.Uf_SetTransObject	( itrTrans )				// Datawindows li$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$un onglet
idw_Si_Gti.Uf_SetTransObject			( itrTrans )				//
iDw_Si_Inter.Uf_SetTransObject		( itrTrans )				//
iDw_Si_Reglement.Uf_SetTransObject	( itrTrans )				//

idw_Si_Produit.SetTransObject			( itrTrans )				// DataWindows pour alimentation des DDDW

idw_Si_Frais.SetTransObject			( itrTrans )				// DataWindows de Stockage 
idw_Si_CodeGarantie.SetTransObject	( itrTrans )
idw_Si_CodeCondition.SetTransObject	( itrTrans )
idw_Si_CodeCarTc.SetTransObject		( itrTrans )
idw_Si_Detail.SetTransObject			( itrTrans )
idw_Si_RegGti.SetTransObject			( itrTrans )
idw_Si_Refus.SetTransObject			( itrTrans )
idw_Si_Motif.SetTransObject			( itrTrans )
idw_LstContact.SetTransObject			( itrTrans )
idw_lstcmde.SetTransObject				( itrTrans )

idw_LstContact.uf_Activer_Selection ( True )
/*------------------------------------------------------------------*/
/* Positionnement des tris														  */
/*------------------------------------------------------------------*/

idw_Si_Inter.isTri 		= "#2 A"
idw_Si_Reglement.isTri 	= "#2 A"
idw_Si_Gti.isTri 			= "ID_GTI A"

/*----------------------------------------------------------------------------*/
/* Chargement des corbeilles accessible par le user courant.                  */
/*----------------------------------------------------------------------------*/
/*------------------------------------------------------------------*/  
/* #2. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sFic = isRepWin + "\TEMP\CORB" + stGlb.sCodAppli + ".TXT"
sFic = stGLB.sRepTempo + "CORB" + stGlb.sCodAppli + ".TXT"
//Migration PB8-WYNIWYG-03/2006 FM
//If FileExists ( sFic ) Then 
If f_FileExists ( sFic ) Then 
//Fin Migration PB8-WYNIWYG-03/2006 FM
	idw_Si_Corb.Reset ()
	idw_Si_Corb.ImportFile ( sFic )
End If

/*------------------------------------------------------------------*/
/* DataWindow sur la table W_REG_GTI                                */
/*------------------------------------------------------------------*/
idw_DosSuiviPar = adw_DosSuiviPar
idw_DosSuiviPar.SetTransObject ( itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la table DET_PRO                                  */
/*------------------------------------------------------------------*/
idw_DetPro = adw_DetPro
idw_DetPro.SetTransObject ( itrTrans )

//* #1
//idw_DetPro.Retrieve ()
//idw_DetPro.Sort ()

/*------------------------------------------------------------------*/
/* DataWindow sur la table DIV_SIN                                  */
/*------------------------------------------------------------------*/
idw_DivSin = adw_DivSin
idw_DivSin.SetTransObject ( itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la table DIV_DET                                  */
/*------------------------------------------------------------------*/
idw_DivDet = adw_DivDet
idw_DivDet.SetTransObject ( SQLCA )

idddw_code_divsin_charg_tempo = adddw_code_divsin_charg_tempo
idddw_code_divsin_charg_tempo.SetTransObject ( itrTrans )
idddw_codecar_divsin_charg_tempo = adddw_codecar_divsin_charg_tempo
idddw_codecar_divsin_charg_tempo.SetTransObject ( itrTrans )

/*------------------------------------------------------------------*/
/* DGA. Le 21/08/2003.                                              */
/* Gestion des boites archives.                                     */
/*------------------------------------------------------------------*/
idw_BoiteArchive = adw_BteArch
idw_BoiteArchive.SetTransObject ( itrTrans )

/*----------------------------------------------------------------------------*/
/* Populisation de la DDDW des utilisateurs.                                  */
/*----------------------------------------------------------------------------*/
idw_DosSuiviPar.GetChild ( "DOS_SUIVI_PAR", dwChild )
/*------------------------------------------------------------------*/  
/* #2. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sFic = isRepWin + "\TEMP\OPER" + stGlb.sCodAppli + ".TXT"
sFic = stGLB.sRepTempo + "OPER" + stGlb.sCodAppli + ".TXT"

//Migration PB8-WYNIWYG-03/2006 FM
//If FileExists ( sFic ) Then 
If f_FileExists ( sFic ) Then 
//Fin Migration PB8-WYNIWYG-03/2006 FM
	dwChild.Reset ()
	dwChild.ImportFile ( sFic )
End If
idw_DosSuiviPar.Modify ( "dos_suivi_par_t.text = 'Dossier suivi par'" )

Return

end subroutine

on u_cs_sp_sinistre.create
call super::create
end on

on u_cs_sp_sinistre.destroy
call super::destroy
end on

