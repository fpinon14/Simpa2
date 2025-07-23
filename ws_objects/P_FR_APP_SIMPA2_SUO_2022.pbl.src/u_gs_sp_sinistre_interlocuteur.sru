$PBExportHeader$u_gs_sp_sinistre_interlocuteur.sru
$PBExportComments$---} User Object pour la gestion des interlocuteurs. (W_INTER)
forward
global type u_gs_sp_sinistre_interlocuteur from u_gs_sp_sinistre_anc
end type
end forward

global type u_gs_sp_sinistre_interlocuteur from u_gs_sp_sinistre_anc
end type
global u_gs_sp_sinistre_interlocuteur u_gs_sp_sinistre_interlocuteur

type variables
Private :
	U_DataWindow		idw_wInter

	U_DataWindow_Detail	idw_LstFrais

	DataWindow		idw_ParaProd
	DataWindow		idw_wParaInfo
	DataWindow		idw_wPiece
	DataWindow		idw_wRefus
	DataWindow		idw_wFrais
	DataWindow		idw_wFraisSupp
	DataWindow		idw_wDetail
	DataWindow		idw_Commune

	Datawindow 		idw_wDivSin
	
	U_Spb_Ajout_CourTyp	iUoAjout

	U_Spb_Cp_2000		iUoCourrierWord

	Boolean			ibAltCommune   // DCMP 030362 Gestion des commune O/N

	String			isCodRecu	// correction DCMP 030390

	CommandButton		icbCommune

	N_Cst_Saisie_Validation_Interlocuteur	invSaisieValInter

	Boolean 			ibSaisieValidation 
	Boolean			ibCpPresentAvant
	
	string			isListEnvZ0[] = {'Z040','Z041','Z042','Z043'} // [DCMP050251]
	
	// soapconnection isoapcnx  // [MIG_PB2022] soapconnection obsolète

end variables

forward prototypes
public subroutine uf_traitement (integer aitype, ref s_pass astpass)
private subroutine uf_preparermodifier (ref s_pass astpass)
private subroutine uf_preparerinserer (ref s_pass astpass)
private subroutine uf_tb_coordonnees ()
private subroutine uf_tb_questionnaire ()
private subroutine uf_controlersaisie (ref s_pass astpass)
private subroutine uf_zn_codinter ()
private subroutine uf_gestionuajout (integer aitype)
private subroutine uf_changerproduit ()
private subroutine uf_gestion_frais (integer aitype)
private subroutine uf_preparervalider (ref s_pass astpass)
private subroutine uf_preparervalider_paragraphe (ref s_pass astpass)
private subroutine uf_preparervalider_frais (ref s_pass astpass)
private subroutine uf_preparersupprimer (ref s_pass astpass)
private subroutine uf_gestion_double_inter ()
private subroutine uf_initialiser_fichier_word ()
private subroutine uf_preparerabandonner (ref s_pass astpass)
public subroutine uf_gestion_onglet (integer aitype)
private subroutine uf_gestion_str2nul ()
private subroutine uf_initialiserfenetre (ref s_pass astpassdga)
private subroutine uf_controlersaisie_commune (ref string astext, ref string aspos)
private subroutine uf_epuration_zonecommune (ref string asville, ref integer aicode)
public subroutine uf_initialiser_objets (ref u_spb_ajout_courtyp auajout, ref u_spb_cp_2000 aucourrierword, ref commandbutton acbcommune, ref N_Cst_Saisie_Validation_Interlocuteur anvSaisieValInter)
private function boolean uf_presencecp (integer aiidinter, string ascodinter)
private function long uf_zn_rib ()
private function long uf_zn_altquest ()
private function long uf_zn_ordrecheque ()
private function long uf_zn_codmodreg ()
public subroutine uf_initialiser_dw_desc (ref u_datawindow_detail adw_lstfrais, ref u_datawindow adw_winter, ref datawindow adw_norm[])
public function long uf_zn_trt (ref s_pass astpass)
protected function string uf_buildstringlist (string asstringarray[])
public function long uf_decompo_adr_mail ()
private subroutine uf_tb_validation ()
private function long uf_zn_altsuivimail ()
public function boolean uf_controler_sepa (string ascodebq, string ascodeag)
private function long uf_zn_idnatcour ()
private function integer uf_zn_codciv ()
private function integer uf_zn_altcourgest (string ascas)
private function long uf_zn_adr_mail_name ()
private function long uf_zn_adr_mail_domain ()
public subroutine uf_controle_dp344 (ref integer aiaction, ref integer aierreur)
private subroutine uf_controlergestion (ref s_pass astpass)
end prototypes

public subroutine uf_traitement (integer aitype, ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Traitement (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:29:33
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: Integer		aiType			(Val)	Type de traitement
//*					  s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//       JFF   20/06/2025 [MIG147_KRYS]
//*-----------------------------------------------------------------

Choose Case aiType
Case 1					// INITIALISATION		(Ue_Initialiser de la fenêtre)
	Uf_InitialiserFenetre ( astPass )

Case 2					// MODIFICATION		(Wf_PreparerModifier)
	Uf_PreparerModifier ( astPass )

Case 3					// INSERTION			(Wf_PreparerInserer)
	Uf_PreparerInserer ( astPass )

Case 4					// CONTROLE SAISIE	(Wf_ControlerSaisie) + (Wf_ControlerGestion)
	Uf_ControlerSaisie ( astPass )

Case 5					// CONTROLE GESTION	(Wf_ControlerGestion) [MIG147_KRYS]
	Uf_ControlerGestion ( astPass )

Case 6					// PREPARER VALIDER	(Wf_PreparerValider)
	Uf_PreparerValider ( astPass )

Case 7					// PREPARER ABANDONNER	(Wf_PreparerAbandonner)
	Uf_PreparerAbandonner ( astPass )

Case 9					// CAS PARTICULIER	(Appel sur l'événement Ue_Banque)
	Uf_Tb_Coordonnees ()

Case 10					// SUPPRESSION			(Wf_PreparerSupprimer)
	Uf_PreparerSupprimer ( astPass )

End Choose



end subroutine

private subroutine uf_preparermodifier (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerModifier (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la modification d'un interlocuteur
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG 15/09/2003	correction DCMP 030390 : ce n'est pas la décl. du sin qu'il faut
//*								prendre en compte, mais le média du travail
//*								(cod_recu de w_queue au lieu de cod_decl de w_sin)
//* #2 JFF  22/03/2004  DCMP 040020 SVE
//     JFF  23/05/2012  [PM103][1]
// 		FPI 27/04/2016		[FPI.20160427] Protection de la zone cod_inter en modif (pour éviter de changer l'inter assuré)
//       JFF   05/02/2018 [PM360-2]
//       JFF   18/08/2020 [PM497-1]
//       JFF   30/05/2023 [PMO89_RS4822]
//       JFF   19/12/2024 [MIG1_COUR_EMAILING]
//       JFF   27/03/2025 [PMO32_SPB175]
//       JFF   22/07/2025 [MIG165_BOUYGUES]
//*-----------------------------------------------------------------
Boolean	bSupprime
n_cst_string	lnvString 
DataWindowChild dwChild
String sFind, sValCar, sCodInter, sVal, sLibInter

Long lTotPiece, lTotRefus, lLig, lTotInter, lTotDetail, lIdSin, lDeb, lFin, lVal, lRowDS
Long lGtDuDR, lIdProd 

bSupprime = True

/*------------------------------------------------------------------*/
/* #1 CAG 15/09/2003                                                */
/*------------------------------------------------------------------*/
isCodRecu = astPass.sTab [ 4 ]

lIdSin  = idw_wSin.GetItemNumber ( 1, "ID_SIN" )
lIdProd = idw_wsin.GetItemNumBer ( 1,"ID_PROD")

/*------------------------------------------------------------------*/
/* On recopie la ligne du détail de la fenêtre parent dans dw_wInter de  */
/* INTERLOCUTEUR.                                                   */
/*------------------------------------------------------------------*/
idw_wInter.Uf_CopierLigne ()

/*------------------------------------------------------------------*/
/* Le produit a t-il changé ?                                       */
/*------------------------------------------------------------------*/
Uf_ChangerProduit ()

/*------------------------------------------------------------------*/
/* #2 Gestion Saisie/Validation.                                    */
/*------------------------------------------------------------------*/
If	ibSaisieValidation Then
	invSaisieValInter.uf_Preparer ( String ( lIdSin ), idw_wInter, "M" )
End If

/*------------------------------------------------------------------*/
/* On autorise ou non l'utilisation du bouton SUPPRIMER de la       */
/* fenêtre.                                                         */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Si l'interlocuteur a déjà été validé, ou si le montant à régler  */
/* est supérieur à 0, on interdit la suppression.                   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Si l'interlocuteur existe dans la table W_PIECE ou W_REFUS, on   */
/* ne peut pas supprimer cet interlocuteur.                         */
/*------------------------------------------------------------------*/
If	idw_wInter.GetItemNumber ( 1, "CPT_VALIDE" ) > 0 Or idw_wInter.GetItemNumber ( 1, "MT_A_REG" ) > 0 Then
	bSupprime = False
Else
/*------------------------------------------------------------------*/
/* Recherche sur W_PIECE.                                           */
/*------------------------------------------------------------------*/
	sFind = "ID_I = " + String ( idw_wInter.GetItemNumber ( 1, "ID_I" ) )
	lTotPiece = idw_wPiece.RowCount ()
	lLig = idw_wPiece.Find ( sFind, 1, lTotPiece )
	If	lLig > 0 Then
		bSupprime = False
	Else
/*------------------------------------------------------------------*/
/* Recherche sur W_REFUS.                                           */
/*------------------------------------------------------------------*/
		lTotRefus = idw_wRefus.RowCount ()
		lLig = idw_wRefus.Find ( sFind, 1, lTotRefus )
		If	lLig > 0 Then
			bSupprime = False
		End If
	End If	
End If

/*------------------------------------------------------------------*/
/* Si le code de l'interlocuteur est positionné pour l'envoi d'un   */
/* double, on ne peut pas supprimer cet interlocuteur.              */
/*------------------------------------------------------------------*/
If	bSupprime	Then
	sFind			= "ID_I_DB = " + String ( idw_wInter.GetItemNumber ( 1, "ID_I" ) )
	lTotInter	= idw_wInter.iudwDetailSource.RowCount ()
	lLig = idw_wInter.iudwDetailSource.Find ( sFind, 1, lTotInter )
	If	lLig > 0 Then
		bSupprime = False
	End If
End If

/*------------------------------------------------------------------*/
/* Si l'interlocuteur est positionné dans un détail A REGLER, on    */
/* ne peut pas supprimer cet interlocuteur.                         */
/*------------------------------------------------------------------*/
If	bSupprime	Then
	sFind			= "ID_I_REG = " + String ( idw_wInter.GetItemNumber ( 1, "ID_I" ) )
	lTotDetail	= idw_wDetail.RowCount ()
	lLig = idw_wDetail.Find ( sFind, 1, lTotDetail )
	If	lLig > 0 Then
		bSupprime = False
	End If
End If

/*------------------------------------------------------------------*/
/* On gére les paragraphes d'informations en Modification.          */
/*------------------------------------------------------------------*/
Uf_GestionuAjout ( 2 )

/*------------------------------------------------------------------*/
/* On gére la liste des interlocuteurs à qui l'on peut envoyer un   */
/* double.                                                          */
/*------------------------------------------------------------------*/
Uf_Gestion_Double_Inter ()

/*------------------------------------------------------------------*/
/* On gére les frais en Modification.                               */
/*------------------------------------------------------------------*/
Uf_Gestion_Frais ( 2 )

/*------------------------------------------------------------------*/
/* On gére le nom des documents Word en insertion.                  */
/*------------------------------------------------------------------*/
Uf_Initialiser_Fichier_Word ()

/*------------------------------------------------------------------*/
/* On gére les TabOrder uniquement en saisie.                       */
/*------------------------------------------------------------------*/
If	isTypeTrt = "S"	Then
	Uf_Tb_Coordonnees ()				// Coordonnées assuré
	Uf_Tb_Questionnaire ()			// ALT_QUEST, ALT_COURGEST, ID_NAT_COUR, ID_I_DB, ID_COURJ
End If

/*------------------------------------------------------------------*/
/* On gére l'onglet sur les paragraphes.                            */
/*------------------------------------------------------------------*/
Uf_Gestion_Onglet ( 2 )

If	iuoOng.Uf_RecupererOngletCourant () <> "01" Then
	iuoOng.Uf_ChangerOnglet ( "01" ) 
	icbCommune.Show ()
End If

ibCpPresentAvant = This.uf_PresenceCP ( idw_wInter.GetItemNumber ( 1, "ID_I" ), idw_wInter.GetItemString ( 1, "COD_INTER" ))



astPass.bSupprime	= bSupprime		
astPass.bRetour	= True

// [PM103][1]
If gbModeReprise_223 Then
	If idw_wInter.GetItemString ( 1, "COD_INTER" ) <> "F" Then
		idw_wInter.SetItem ( 1, "COD_MODE_REG", "XX" )
	End If
End If

// [FPI.20160427]
idw_wInter.uf_proteger( {"COD_INTER"}, "1")


// [PM360-2]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 324 )
If lDeb <= 0 Then	
	idw_wInter.Modify ( "rib_cpt.format='[GENERAL]~tfill (~~'XX~~', 9) + right (rib_cpt, 2)'" )
Else 
	idw_wInter.Modify ( "rib_cpt.format='[GENERAL]'" )		
End If

// [PM497-1]
This.Uf_Zn_AltCourGest ( "INIT" )

// [PMO89_RS4822]
lVal = idw_wInter.GetItemNumber ( 1, "COD_ETAT_CTRLE_INTER" ) 
If IsNull ( lVal ) Then idw_wInter.SetItem ( 1, "COD_ETAT_CTRLE_INTER", 0 ) 

idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 365 )
If lDeb > 0 And isTypeTrt = "S" Then
	sValCar = lnvString.of_getkeyvalue(idw_DetPro.GetItemString(lDeb,"VAL_CAR" ), "TYP_INTER", ";") 
	sCodInter = idw_wInter.GetItemString ( 1, "COD_INTER" ) 
	
	If Not IsNull ( sCodInter ) And Pos ( sValCar, "#" + sCodInter + "#" ) > 0 Then
		idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "0")
	Else
		idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")
	End If 
	
	lVal = idw_wInter.GetItemNumber ( 1, "COD_ETAT_CTRLE_INTER" ) 
	If lVal > 0 Then
		idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")			
	End If 
	
Else 
	// [PMO32_SPB175]
	If F_CLE_A_TRUE ( "PMO32_SPB175" ) Then
		lRowDS = idw_wDivSin.Find ( "Upper ( NOM_ZONE ) = 'PM506_ETAT_APPEL_APIREST_LAB'", 1, idw_wDivSin.RowCount () ) 
		If lRowDS > 0 Then
			sVal = idw_wDivSin.GetItemString ( lRowDs, "VAL_CAR" ) 
			If IsNull ( sVal ) Then sVal = ""
			If sVal = "" Then
				idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "0")
			Else 
				idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")				
			End If 
		End If 
	Else 
		idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")
	End If
End If 

// [MIG1_COUR_EMAILING]
If F_CLE_A_TRUE ( "MIG1_COUR_EMAILING" ) Then
	// [MIG1_COUR_EMAILING]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 390 )
	If lDeb > 0 Then
		idw_wInter.modify ("b_typo_courrier.text = 'Courrier Emailing KSL'" )
		idw_wInter.SetItem ( 1, "ALT_COURGEST", "R" )
		This.Uf_Tb_Questionnaire ()

		SQLCA.PS_S01_AUTORISATION ( 9, stGlb.sCodOper, lIdprod, lGtDuDR )
		
		If lGtDuDR <= 0 Then
			idw_wInter.GetChild ( "ID_NAT_COUR", dwChild )
			dwChild.RowsDiscard ( 1, dwChild.RowCount(), Primary! )
			idw_wInter.Uf_Proteger ( { "ID_NAT_COUR", "ALT_QUEST", "ID_I_DB", "ID_COURJ" }, "1" )		
		End IF 
		uf_zn_altcourgest ( "INIT" ) 
	Else 
		idw_wInter.modify ("b_typo_courrier.text = 'Typologie courrier'" )
	End If 
End If 
	
// [MIG147_KRYS]
If F_CLE_A_TRUE ( "MIG147_KRYS" ) Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 404 )
	If lDeb > 0 Then
		sValCar = idw_DetPro.GetItemString(lDeb,"VAL_CAR" )
		sValCar = F_CLE_VAL ("TYP_INTER", sValCar, ";") 
		sCodInter = idw_wInter.GetItemString ( 1, "COD_INTER" ) 
		
		If sValCar = "" Then
			stMessage.berreurg=FALSE
			stMessage.bouton=Ok!
			stMessage.icon=Information!
			stMessage.stitre="Gestion des interlocuteurs"
			stMessage.scode ="WINT324"
			F_Message ( stMessage )
		End If 
		
		
		If sValCar <> "" And Not IsNull ( sCodInter ) And Pos ( sValCar, "#" + sCodInter + "#" ) > 0 Then
			
			sLibInter = SQLCA.FN_CODE_CAR ( sCodInter, "-IN" )
	
			stMessage.berreurg=FALSE
			stMessage.bouton=Ok!
			stMessage.icon=Information!
			stMessage.stitre="Gestion des interlocuteurs"
			stMessage.sVar[1] = sLibInter
			stMessage.scode ="WINT325"
			F_Message ( stMessage )		
	
		End If 

	End If 
End If 

// [MIG165_BOUYGUES]
If F_CLE_A_TRUE ( "MIG165_BOUYGUES" ) Then
	idw_wInter.uf_proteger( {"V_REF1" }, "1")
End If


end subroutine

private subroutine uf_preparerinserer (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerInserer (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de l'insertion d'un interlocuteur
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    22/03/2004  DCMP 040020 SVE
//        JFF    05/02/2018  [PM360-2]
//        JFF    18/08/2020  [PM497-1]
//        JFF    19/12/2024  [MIG1_COUR_EMAILING]
//        JFF    27/03/2025  [PMO32_SPB175]
//        JFF    22/07/2025  [MIG165_BOUYGUES]
//*-----------------------------------------------------------------

Long lIdSin, lIdInter, lTotInter, lDeb, lFin, lRowDs
n_cst_string	lnvString 
String sValCar, sCodInter, sVal
DataWindowChild dwChild
Long lGtDuDR, lIdProd 


/*------------------------------------------------------------------*/
/* Le produit a t-il changé ?                                       */
/*------------------------------------------------------------------*/
Uf_ChangerProduit ()

/*------------------------------------------------------------------*/
/* On récupére l'ID_SIN et le N° de l'interlocuteur. Le test sur    */
/* les 10 interlocuteurs est réalisé sur UE_CREER de                */
/* W_Tm_sp_Sinistre.                                                */
/*------------------------------------------------------------------*/
lIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
lIdProd = idw_wsin.GetItemNumBer ( 1,"ID_PROD")


lTotInter	= idw_wInter.iudwDetailSource.RowCount ()
If	lTotInter > 0 Then
	lIdInter = idw_wInter.iudwDetailSource.GetItemNumber ( lTotInter, "ID_I" )
	lIdInter ++
Else
	lIdInter = lTotInter
End If

idw_wInter.SetItem ( 1, "ID_SIN", lIdSin )
idw_wInter.SetItem ( 1, "ID_I", lIdInter )

/*------------------------------------------------------------------*/
/* On gére les paragraphes d'informations en Insertion.             */
/*------------------------------------------------------------------*/
Uf_GestionuAjout ( 1 )

/*------------------------------------------------------------------*/
/* On gére la liste des interlocuteurs à qui l'on peut envoyer un   */
/* double.                                                          */
/*------------------------------------------------------------------*/
Uf_Gestion_Double_Inter ()

/*------------------------------------------------------------------*/
/* On gére les frais en insertion.                                  */
/*------------------------------------------------------------------*/
Uf_Gestion_Frais ( 1 )

/*------------------------------------------------------------------*/
/* On gére le nom des documents Word en insertion.                  */
/*------------------------------------------------------------------*/
Uf_Initialiser_Fichier_Word ()

/*------------------------------------------------------------------*/
/* On gére les TabOrder.                                            */
/*------------------------------------------------------------------*/
Uf_Tb_Coordonnees ()				// Coordonnées assuré
Uf_Tb_Questionnaire ()			// ALT_QUEST, ALT_COURGEST, ID_NAT_COUR, ID_I_DB, ID_COURJ

/*------------------------------------------------------------------*/
/* On gére l'onglet sur les paragraphes.                            */
/*------------------------------------------------------------------*/
Uf_Gestion_Onglet ( 1 )

If	iuoOng.Uf_RecupererOngletCourant () <> "01" Then
	iuoOng.Uf_ChangerOnglet ( "01" ) 
	icbCommune.Show ()
End If

/*------------------------------------------------------------------*/
/* #1 Gestion Saisie/Validation.                                    */
/*------------------------------------------------------------------*/
If	ibSaisieValidation Then
	invSaisieValInter.uf_Preparer ( String ( lIdSin ), idw_wInter, "C" )
End If

ibCpPresentAvant = This.uf_PresenceCP ( idw_wInter.GetItemNumber ( 1, "ID_I" ), idw_wInter.GetItemString ( 1, "COD_INTER" ))

// [PM360-2]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 324 )
If lDeb <= 0 Then	
	idw_wInter.Modify ( "rib_cpt.format='[GENERAL]~tfill (~~'XX~~', 9) + right (rib_cpt, 2)'" )
Else 
	idw_wInter.Modify ( "rib_cpt.format='[GENERAL]'" )		
End If
		
// [PM497-1]
This.Uf_Zn_AltCourGest ( "INIT" )
		
astPass.bRetour = True

// [PMO89_RS4822]

idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 365 )
If lDeb > 0 Then
	sValCar = lnvString.of_getkeyvalue(idw_DetPro.GetItemString(lDeb,"VAL_CAR" ), "TYP_INTER", ";") 
	sCodInter = idw_wInter.GetItemString ( 1, "COD_INTER" ) 
	
	If Not IsNull ( sCodInter ) And Pos ( sValCar, "#" + sCodInter + "#" ) > 0 Then
		idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "0")
	Else
		idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")
	End If 
Else 
	// [PMO32_SPB175]
	If F_CLE_A_TRUE ( "PMO32_SPB175" ) Then
		lRowDS = idw_wDivSin.Find ( "Upper ( NOM_ZONE ) = 'PM506_ETAT_APPEL_APIREST_LAB'", 1, idw_wDivSin.RowCount () ) 
		If lRowDS > 0 Then
			sVal = idw_wDivSin.GetItemString ( lRowDs, "VAL_CAR" ) 
			If IsNull ( sVal ) Then sVal = ""
			If sVal = "" Then
				idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "0")
			Else 
				idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")				
			End If 
		End If 
	Else 
		idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")
	End If
End If 

// [MIG1_COUR_EMAILING]
If F_CLE_A_TRUE ( "MIG1_COUR_EMAILING" ) Then
	// [MIG1_COUR_EMAILING]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 390 )
	If lDeb > 0 Then
		idw_wInter.modify ("b_typo_courrier.text = 'Courrier Emailing KSL'" )
		idw_wInter.SetItem ( 1, "ALT_COURGEST", "R" )
		This.Uf_Tb_Questionnaire ()

		SQLCA.PS_S01_AUTORISATION ( 9, stGlb.sCodOper, lIdprod, lGtDuDR )
		
		If lGtDuDR <= 0 Then
			idw_wInter.GetChild ( "ID_NAT_COUR", dwChild )
			dwChild.RowsDiscard ( 1, dwChild.RowCount(), Primary! )
			idw_wInter.Uf_Proteger ( { "ID_NAT_COUR", "ALT_QUEST", "ID_I_DB", "ID_COURJ" }, "1" )		
		End IF 
		uf_zn_altcourgest ( "INIT" ) 
	Else 
		idw_wInter.modify ("b_typo_courrier.text = 'Typologie courrier'" )
	End If 
End If 

// [MIG165_BOUYGUES]
If F_CLE_A_TRUE ( "MIG165_BOUYGUES" ) Then
	idw_wInter.uf_proteger( {"V_REF1" }, "1")
End If


end subroutine

private subroutine uf_tb_coordonnees ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Tb_Coordonnees (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 17:35:30
//* Libellé			: 
//* Commentaires	: Gestion des TabOrder les coordonnées de l'interlocuteur.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1	JCA	29/05/2006	DntMail - ajout gestion des colonnes adr_mail_name et adr_mail_domain
//       JFF   30/07/2014 [PM234-4_V1]
//       JFF   20/01/2020 [PM421-8]
//*-----------------------------------------------------------------

Long lLig, lTotInter

/*------------------------------------------------------------------*/
/* Cette fonction concerne les zones suivantes :                    */
/* COD_INTER, COD_CIV, NOM, ADR_1, ADR_2, ADR_CP, ADR_VILLE,        */
/* NUM_TELD, NUM_TELB, NUM_FAX.                                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* L'ordre est important, en effet on peut avoir validé un          */
/* interlocuteur de type BANQUE.                                    */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Si le dossier est déjà validé, on ne peut plus toucher au nom    */
/* de la personne.                                                  */
/*------------------------------------------------------------------*/
If	idw_wInter.GetItemNumber ( 1, "CPT_VALIDE" ) > 0 Then
	idw_wInter.ClearValues ( "COD_INTER" )
	idw_wInter.SetValue ( "COD_INTER", 1, "Autre ~tT" )
	idw_wInter.SetValue ( "COD_INTER", 2, "Assuré ~tA" )
	idw_wInter.SetValue ( "COD_INTER", 3, "Banque ~tB" )
	idw_wInter.SetValue ( "COD_INTER", 4, "Fourn. ~tF" )
	// [PM234-4_V1]
	idw_wInter.SetValue ( "COD_INTER", 6, "Livraison. ~tL" )

	// #1
	idw_wInter.Uf_Proteger ( { "COD_INTER", "COD_CIV", "NOM" }, "1" )
	idw_wInter.Uf_Proteger ( { "ADR_1", "ADR_2", "ADR_CP", "ADR_VILLE", "NUM_TELD", "NUM_TELB", "NUM_FAX", "ADR_MAIL_NAME", "ADR_MAIL_DOMAIN", "NUM_PORT_SMS", "ALT_SUIVI_SMS" }, "0" )
	idw_wInter.ilPremCol = 6			// ADR_1
	idw_wInter.isNomCol	= "ADR_1"
Else

	lTotInter	= idw_wInter.iudwDetailSource.RowCount ()

	idw_wInter.ClearValues ( "COD_INTER" )
	idw_wInter.SetValue ( "COD_INTER", 1, "Autre ~tT" )

/*------------------------------------------------------------------*/
/* Si on est en train de modifier un interlocuteur de type          */
/* 'ASSURE', on ajoute la DataValue. Si on insére un                */
/* interlocuteur, on vérifie qu'il n'existe pas un enregistrement   */
/* de type 'ASSURE'.                                                */
/*------------------------------------------------------------------*/
	If	idw_wInter.GetItemString ( 1, "COD_INTER" ) = "A"	Then
		idw_wInter.SetValue ( "COD_INTER", 2, "Assuré ~tA" )
	Else
		lLig = idw_wInter.iudwDetailSource.Find ( "COD_INTER = 'A'", 1, lTotInter )
		If	lLig = 0 Then
			idw_wInter.SetValue ( "COD_INTER", 2, "Assuré ~tA" )
		End If
	End If

	// #1 
	idw_wInter.Uf_Proteger ( { "COD_INTER", "COD_CIV", "NOM", "ADR_1", "ADR_2", "ADR_CP", "ADR_VILLE", "NUM_TELD", "NUM_TELB", "NUM_FAX", "ADR_MAIL_NAME", "ADR_MAIL_DOMAIN", "NUM_PORT_SMS", "ALT_SUIVI_SMS" }, "0" )
	idw_wInter.ilPremCol = 3			// COD_INTER
	idw_wInter.isNomCol	= "COD_INTER"
End If

/*------------------------------------------------------------------*/
/* Si le code interlocuteur correspond à une BANQUE les zones       */
/* deviennent non saisissables.                                     */
/*------------------------------------------------------------------*/
If	idw_wInter.GetItemString ( 1, "COD_INTER" ) = "B" Then
	idw_wInter.ClearValues ( "COD_INTER" )
	idw_wInter.SetValue ( "COD_INTER", 1, "Banque ~tB" )

	// #1
	// [PM421-8]
	idw_wInter.Uf_Proteger ( { "COD_INTER", "COD_CIV", "NOM", "ADR_1", "ADR_2", "ADR_CP", "ADR_VILLE", "NUM_TELD", "NUM_TELB", "NUM_FAX" }, "1" )	

	idw_wInter.ilPremCol = 10			// ADR_ATT
	idw_wInter.isNomCol	= "ADR_ATT"
End If

/*------------------------------------------------------------------*/
/* Si le code interlocuteur correspond à un FOURNISSEUR les zones   */
/* deviennent non saisissables.                                     */
/*------------------------------------------------------------------*/
If	idw_wInter.GetItemString ( 1, "COD_INTER" ) = "F" Then
	idw_wInter.ClearValues ( "COD_INTER" )
	idw_wInter.SetValue ( "COD_INTER", 1, "Fourn. ~tF" )

	// #1
	idw_wInter.Uf_Proteger ( { "COD_INTER", "COD_CIV", "NOM", "ADR_1", "ADR_2", "ADR_CP", "ADR_VILLE", "NUM_TELD", "NUM_TELB", "NUM_FAX", "ADR_MAIL_NAME", "ADR_MAIL_DOMAIN", "NUM_PORT_SMS", "ALT_SUIVI_SMS" }, "1" )
	idw_wInter.ilPremCol = 10			// ADR_ATT
	idw_wInter.isNomCol	= "ADR_ATT"
End If

	// [PM234-4_V1]
If	idw_wInter.GetItemString ( 1, "COD_INTER" ) = "L" Then
	idw_wInter.ClearValues ( "COD_INTER" )
	idw_wInter.SetValue ( "COD_INTER", 6, "Livraison. ~tL" )

	idw_wInter.ilPremCol = 10			// ADR_ATT
	idw_wInter.isNomCol	= "ADR_ATT"
End If



end subroutine

private subroutine uf_tb_questionnaire ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Tb_Questionnaire (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 17:35:30
//* Libellé			: 
//* Commentaires	: Gestion des TabOrder pour le questionnaire et le courrier gestionnaire
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Cette fonction concerne les zones suivantes :                    */
/* ALT_QUEST, ALT_COURGEST, ID_NAT_COUR.                            */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Si ALT_QUEST est à OUI, la zone ID_NAT_COUR est positionnée à    */
/* Q+ID_PROD, elle est non saisissable. La zone ALT_COURGEST est    */
/* protégée.                                                        */
/*------------------------------------------------------------------*/
If	idw_wInter.GetItemString ( 1, "ALT_QUEST" ) = "O" Then
	idw_wInter.Uf_Proteger ( { "ALT_QUEST" }, "0" )
	idw_wInter.Uf_Proteger ( { "ID_NAT_COUR", "ALT_COURGEST", "ID_I_DB", "ID_COURJ" }, "1" )

	idw_wInter.ilDernCol	= 30		// ALT_QUEST
End If

If	idw_wInter.GetItemString ( 1, "ALT_COURGEST" ) = "R" Then
	idw_wInter.Uf_Proteger ( { "ID_NAT_COUR" }, "0" )
	idw_wInter.Uf_Proteger ( { "ALT_QUEST", "ID_I_DB", "ID_COURJ" }, "1" )

	idw_wInter.ilDernCol	= 32		// ID_NAT_COUR
End If

If	idw_wInter.GetItemString ( 1, "ALT_COURGEST" ) = "D" Then
	idw_wInter.Uf_Proteger ( { "ID_I_DB" }, "0" )
	idw_wInter.Uf_Proteger ( { "ID_NAT_COUR", "ALT_QUEST", "ID_COURJ" }, "1" )

	idw_wInter.ilDernCol	= 34		// ID_I_DB
End If

If	idw_wInter.GetItemString ( 1, "ALT_COURGEST" ) = "J" Then
	idw_wInter.Uf_Proteger ( { "ID_COURJ" }, "0" )
	idw_wInter.Uf_Proteger ( { "ID_NAT_COUR", "ALT_QUEST", "ID_I_DB" }, "1" )

	idw_wInter.ilDernCol	= 35		// ID_COURJ
End If

If idw_wInter.GetItemString ( 1, "ALT_COURGEST" ) = "N" And idw_wInter.GetItemString ( 1, "ALT_QUEST" ) = "N" Then
	idw_wInter.Uf_Proteger ( { "ALT_COURGEST", "ALT_QUEST" }, "0" )
	idw_wInter.Uf_Proteger ( { "ID_NAT_COUR", "ID_I_DB", "ID_COURJ" }, "1" )

	idw_wInter.ilDernCol	= 30		// ALT_QUEST
End If
end subroutine

private subroutine uf_controlersaisie (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerSaisie (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Contrôle de saisie d'un interlocuteur
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1 FS 	le 28/05/2001 : Utilisation de u_spb_cp_2000
//* #2 JFF 	le 20/08/2003 : Contrôle des communes DCMP 030362
//* #3 JCA 	le 29/05/2006 : DntMail
//* #4 JCA  11/06/2007		DCMP 070399 - Correction contrôle de validité du RIB
//* #5 JFF	20/10/2008	   [FNAC_PROD_ECH_TECH]
//*    JFF  07/04/2010	   [DCMP100177]
//*    JFF  04/10/2011     [PM159].[Controle_mail]
//		 FPI	30/04/2012	   [PT_BALANCE_LDE] Saisie obligatoire pt balance LDE
//     JFF  11/01/2017     [VDOC22845]
//     JFF  01/04/2022     [RS2194_SUPDBLEBQ]
//     JFF  30/05/2023     [PMO89_RS4822]
//     JFF  19/12/2024 		[MIG1_COUR_EMAILING]
//     JFF  27/03/2025     [PMO32_SPB175]
//*-----------------------------------------------------------------

//String sCol [ 14 ], sErr [ 14 ], sVal [ 14 ] // #3
String sCol [ 19 ], sErr [ 19 ], sVal [ 19 ]   //  [PMO89_RS4822]
String sAdr_Col[ 8 ], sAdr_Val[ 8 ], sAdr_Prec[ 8 ] // #3
//String sAdr_Col[ 10 ], sAdr_Val[ 10 ], sAdr_Prec[ 10 ]
String sVal2
Long lRowDs

String 		sNouvelleLigne, sText, sPos, sOng, sCodInterDouble, sCodInter, sRech, sNumPortSms, sMailName, sMaildomaine, sMail, sValDp361
Long 			lCpt, lNbrCol, lLig, lTotInter
Long 			lDeb, lFin, lIdProd, lCptValide
Boolean bModifAdr, bModifCoor, bMail, bCasPMO89_RS4822_DP365, bFin
Integer iRet
Datetime dt, dt2, dtToday 

bCasPMO89_RS4822_DP365 = FALSE
n_cst_string	lnvString  
String sValCar, sNom, sPrenom, sNomComplet

string sRibBq, sRibGui, sRibCpt, sRibCle // #4
String sRetour
n_cst_string nvString

lCptValide = idw_winter.GetItemNumber ( 1, "CPT_VALIDE" )

sNouvelleLigne		= "~r~n"
lNbrCol				= UpperBound ( sCol )
sPos					= ""
sText					= sNouvelleLigne
sOng					= "01"

sCol[  1 ] = "COD_INTER"
sCol[  2 ] = "COD_CIV"
sCol[  3 ] = "NOM"
sCol[  4 ] = "ADR_1"
sCol[  5 ] = "ADR_CP"
sCol[  6 ] = "ADR_VILLE"
sCol[  7 ] = "COD_MODE_REG"
sCol[  8 ] = "RIB_BQ"
sCol[  9 ] = "RIB_GUI"
sCol[ 10 ] = "RIB_CPT"
sCol[ 11 ] = "RIB_CLE"
sCol[ 12 ] = "ID_NAT_COUR"
sCol[ 13 ] = "ID_COURJ"
// #3
sCol[ 14 ] = "ADR_MAIL_NAME"
sCol[ 15 ] = "ADR_MAIL_DOMAIN"
// #3 FIN
sCol[ 16 ] = "ID_I_DB"

// [PMO89_RS4822]
sCol[ 17 ] = "DTE_NAISS"
sCol[ 18 ] = "VILLE_NAISS"
sCol[ 19 ] = "PAYS_NAISS"
// /[PMO89_RS4822]

sErr[  1 ] = " - Le code de l'interlocuteur"
sErr[  2 ] = " - La civilité"
sErr[  3 ] = " - Le nom"
sErr[  4 ] = " - La première ligne d'adresse"
sErr[  5 ] = " - Le code postal"
sErr[  6 ] = " - La ville"
sErr[  7 ] = " - Le mode de règlement"
sErr[  8 ] = " - Le code banque"
sErr[  9 ] = " - Le code guichet"
sErr[ 10 ] = " - Le numéro de compte"
sErr[ 11 ] = " - La clé RIB"
sErr[ 12 ] = " - Le code courrier"
sErr[ 13 ] = " - Le code du courrier joint"
// #3
sErr[ 14 ] = " - L'identifiant de l'email avant l'arobase (@)"
sErr[ 15 ] = " - Le domaine de l'email après l'arobase (@)"
// #3 FIN
sErr[ 16 ] = " - L'interlocuteur pour le double du courrier"

// [PMO89_RS4822]
sErr[ 17 ] = " - La date de naissance de l'interlocuteur"
sErr[ 18 ] = " - La ville de naissance de l'interlocuteur"
sErr[ 19 ] = " - Le pays de naissance de l'interlocuteur"
// /[PMO89_RS4822]


/*------------------------------------------------------------------*/
/* #1 : On vérifie que tous les doc word sont fermés                */
/*      ( remplacement de evt save pour office 2000                 */
/*------------------------------------------------------------------*/
If Not ibsaisievalidation Then 
	If Not iUoCourrierWord.uf_Tester_Doc ( 0 ) Then
		astPass.sTab [ 1 ] = sCol[ 3 ]
	   Return
	End If
End If

/*------------------------------------------------------------------*/
/* On transforme toutes les chaines vides en NULL avant de          */
/* commencer.                                                       */
/*------------------------------------------------------------------*/
Uf_Gestion_Str2Nul ()

/*------------------------------------------------------------------*/
/* On positionne la zone ALT_VALIDE de l'interlocuteur à OUI.       */
/*------------------------------------------------------------------*/
idw_wInter.SetItem ( 1, "ALT_VALIDE", "O" )

For	lCpt = 1 To 15
		sVal[ lCpt ] = Trim ( idw_wInter.GetItemString ( 1, sCol[ lCpt ] ) )
Next

/*------------------------------------------------------------------*/
/* On recupére la zone pour "ID_I_DB".                              */
/*------------------------------------------------------------------*/
//sVal[ 14 ] = String ( idw_wInter.GetItemNumber ( 1, sCol[ 14 ] ) ) // #3
sVal[ 16 ] = String ( idw_wInter.GetItemNumber ( 1, sCol[ 16 ] ) )
sVal[ 17 ] = String ( idw_wInter.GetItemDateTime ( 1, sCol[ 17 ] ) ) // [PMO89_RS4822]
sVal[ 18 ] = idw_wInter.GetItemString ( 1, sCol[ 18 ] )  // [PMO89_RS4822]
sVal[ 19 ] = idw_wInter.GetItemString ( 1, sCol[ 19 ] )  // [PMO89_RS4822]

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/
For	lCpt = 1 To 6
		If IsNull ( sVal[ lCpt ] ) or sVal[ lCpt ] = ""	Then
			If sPos = "" Then sPos = sCol[ lCpt ]
			sText = sText + sErr[ lCpt ] + sNouvelleLigne
		End If
Next

/*------------------------------------------------------------------*/
/* Si on commence à saisir un élément du RIB, il faut aller         */
/* jusqu'au bout.                                                   */
/*------------------------------------------------------------------*/
If	sVal [ 8 ] <> "" Or sVal [ 9 ] <> "" Or sVal [ 10 ] <> "" Or sVal [ 11 ] <> "" Then
	For	lCpt = 8 To 11
			If IsNull ( sVal[ lCpt ] ) or sVal[ lCpt ] = ""	Then
				If sPos = "" Then sPos = sCol[ lCpt ]
				sText = sText + sErr[ lCpt ] + sNouvelleLigne
			End If
	Next
End If

/*------------------------------------------------------------------*/
/* Si ALT_COURGEST est à R (Remplacer), alors ID_NAT_COUR ne doit   */
/* pas être NULL.                                                   */
/*------------------------------------------------------------------*/
// [MIG1_COUR_EMAILING]
If F_CLE_A_TRUE ( "MIG1_COUR_EMAILING" ) Then
	// [MIG1_COUR_EMAILING]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 390 )
	If lDeb <= 0 Then
		If	idw_wInter.GetItemString ( 1, "ALT_COURGEST" ) = "R" Then
			If IsNull ( sVal[ 12 ] ) or sVal[ 12 ] = ""	Then
				If sPos = "" Then sPos = sCol[ 12 ]
				sText = sText + sErr[ 12 ] + sNouvelleLigne
			End If
		End If
	End IF 
Else 
	If	idw_wInter.GetItemString ( 1, "ALT_COURGEST" ) = "R" Then
		If IsNull ( sVal[ 12 ] ) or sVal[ 12 ] = ""	Then
			If sPos = "" Then sPos = sCol[ 12 ]
			sText = sText + sErr[ 12 ] + sNouvelleLigne
		End If
	End If
End If 
/*------------------------------------------------------------------*/
/* Si ALT_COURGEST est à J (Joindre), alors ID_COURJ ne doit pas    */
/* être NULL.                                                       */
/*------------------------------------------------------------------*/
If	idw_wInter.GetItemString ( 1, "ALT_COURGEST" ) = "J" Then
	If IsNull ( sVal[ 13 ] ) or sVal[ 13 ] = ""	Then
		If sPos = "" Then sPos = sCol[ 13 ]
		sText = sText + sErr[ 13 ] + sNouvelleLigne
	End If
End If

/*------------------------------------------------------------------*/
/* #3 Saisie des deux contituant l'email									  */
/*------------------------------------------------------------------*/
If	sVal [ 14 ] <> "" Or sVal [ 15 ] <> "" Then
	For	lCpt = 14 To 15
			If IsNull ( sVal[ lCpt ] ) or sVal[ lCpt ] = ""	Then
				If sPos = "" Then sPos = sCol[ lCpt ]
				sText = sText + sErr[ lCpt ] + sNouvelleLigne
			End If
	Next
End If

/*------------------------------------------------------------------*/
/* Si ALT_COURGEST est à D (Double), alors ID_I_DB ne doit pas être */
/* NULL.                                                            */
/*------------------------------------------------------------------*/
If	idw_wInter.GetItemString ( 1, "ALT_COURGEST" ) = "D" Then
//	If IsNull ( sVal[ 14 ] ) or sVal[ 14 ] = ""	Then	// #3
//		If sPos = "" Then sPos = sCol[ 14 ]					// #3
//		sText = sText + sErr[ 14 ] + sNouvelleLigne		// #3
	If IsNull ( sVal[ 16 ] ) or sVal[ 16 ] = ""	Then
		If sPos = "" Then sPos = sCol[ 16 ]
		sText = sText + sErr[ 16 ] + sNouvelleLigne
	End If
End If

/*------------------------------------------------------------------*/
/* #2 : DCMP 030362                                                 */
/*------------------------------------------------------------------*/
This.uf_ControlerSaisie_Commune ( sText, sPos )


// [PMO89_RS4822]
idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 365 )
If lDeb > 0 Then
	sValCar = lnvString.of_getkeyvalue(idw_DetPro.GetItemString(lDeb,"VAL_CAR" ), "TYP_INTER", ";") 
	sCodInter = idw_wInter.GetItemString ( 1, "COD_INTER" ) 
	
	If Not IsNull ( sCodInter ) And Pos ( sValCar, "#" + sCodInter + "#" ) > 0 Then
		
		bCasPMO89_RS4822_DP365 = TRUE
		
		idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "0")

		For	lCpt = 17 To 19
				If IsNull ( sVal[ lCpt ] ) or sVal[ lCpt ] = ""	Then
					If sPos = "" Then sPos = sCol[ lCpt ]
					sText = sText + sErr[ lCpt ] + sNouvelleLigne
				End If
		Next

		dt = DateTime ( Date ( sVal[ 17 ] ) )
		dt2 = DateTime ( Date ("01/01/1913") )
		dtToday = Datetime ( Today(), now())
		IF dt < dt2 Or dt > dtToday Then
			If sPos = "" Then sPos = sCol[ 17 ]				
			sText = sText + sErr[ 17 ] + " postérieure au 01/01/1913" + sNouvelleLigne
		End If 
		
	Else
		idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")
	End If 
Else 
	// [PMO32_SPB175]
	If F_CLE_A_TRUE ( "PMO32_SPB175" ) Then
		lRowDS = idw_wDivSin.Find ( "Upper ( NOM_ZONE ) = 'PM506_ETAT_APPEL_APIREST_LAB'", 1, idw_wDivSin.RowCount () ) 
		If lRowDS > 0 Then
			sVal2 = idw_wDivSin.GetItemString ( lRowDs, "VAL_CAR" ) 
			If IsNull ( sVal2 ) Then sVal2 = ""
			If sVal2 = "" Then
				idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "0")
			Else 
				idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")				
			End If 
		End If 
	Else 
		idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")
	End If
End If 


/*------------------------------------------------------------------*/
/* Affichage de la chaîne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/
If	sPos <> "" Then

	stMessage.sTitre		= "Contrôle de saisie d'un interlocuteur"
	stMessage.Icon			= Information!
	stMessage.sVar[1] 	= sText
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )

	If	Not IsNull ( sOng ) And iuoOng.Uf_RecupererOngletCourant () <> sOng Then
		iuoOng.Uf_ChangerOnglet ( sOng )
		Choose Case Integer ( sOng )
			Case 1
				icbCommune.Show ()
			Case Else
				icbCommune.Hide ()
		End Choose
	End If
End If

/*------------------------------------------------------------------*/
/* Controle de gestion sur la zone ALT_COURGEST.                    */
/*------------------------------------------------------------------*/
If sPos = "" Then
/*------------------------------------------------------------------*/
/* Si ALT_COURGEST est à D (Double), on vérifie la validité de      */
/* ID_I_DB.                                                         */
/* Un interlocuteur de type 'Autre' ne peut pas envoyer un double.  */
/* Un interlocuteur de type 'Assuré' ne peut envoyer un double      */
/* qu'a un interlocuteur de type 'Banque'.                          */
/* Un interlocuteur de type 'Banque' ne peut envoyer un double      */
/* qu'a un interlocuteur de type 'Assuré'.                          */
/*------------------------------------------------------------------*/
	If	sVal[ 1 ] = "T" And idw_wInter.GetItemString ( 1, "ALT_COURGEST" ) = "D" Then
		sPos = sCol[ 14 ]
		stMessage.sCode		= "WINT110"		

	Else
		lTotInter = idw_wInter.iuDwDetailSource.RowCount ()
		lLig = idw_wInter.iuDwDetailSource.Find ( "ID_I = " + String ( idw_wInter.GetItemNumber ( 1, "ID_I_DB" ) ), 1, lTotInter )
		sCodInterDouble = idw_wInter.iuDwDetailSource.GetItemString ( lLig, "COD_INTER" )
		If			sVal[ 1 ] = "A"	And sCodInterDouble <> "B"	Then
					sPos = sCol[ 14 ]
					stMessage.sCode		= "WINT120"
		ElseIf	sVal[ 1 ] = "B"	And sCodInterDouble <> "A"	Then
					sPos = sCol[ 14 ]
					stMessage.sCode		= "WINT130"
		End If
	End If

/*------------------------------------------------------------------*/
/* Si ALT_COURGEST est à R (Remplacer), alors il faut vérifier que  */
/* l'on ne réclame pas un courrier particulier, ou un               */
/* post-scriptum ou une autre pièce. Je fais ce test ici, car il    */
/* est trés difficlie de l'insérer dans les ItemChanged.            */
/* (Plusieurs actions possibles).                                   */
/*------------------------------------------------------------------*/
	If	sPos = ""	Then
		If	idw_wInter.GetItemString ( 1, "ALT_COURGEST" ) = "R"	Then

			If	idw_wInter.GetItemString ( 1, "ALT_PART" ) = "O"	Then
				stMessage.sVar[1] = "un COURRIER GESTIONNAIRE"
				stMessage.sVar[2] = "un COURRIER PARTICULIER"
				sPos 					= "ALT_COURGEST"
				stMessage.sCode	= "WINT150"
			End If

			If	idw_wInter.GetItemString ( 1, "ALT_PS" ) = "O"	Then
				stMessage.sVar[1] = "un COURRIER GESTIONNAIRE"
				stMessage.sVar[2] = "un POST_SCRIPTUM"
				sPos 					= "ALT_COURGEST"
				stMessage.sCode	= "WINT150"
			End If

			If	idw_wInter.GetItemString ( 1, "ALT_PCE" ) = "O"	Then
				stMessage.sVar[1] = "un COURRIER GESTIONNAIRE"
				stMessage.sVar[2] = "une AUTRE PIECE"
				sPos 					= "ALT_COURGEST"
				stMessage.sCode	= "WINT150"
			End If
		End If
	End If

/*------------------------------------------------------------------*/
/* Il est impossible de saisir plusieur fois le même interlocuteur  */
/* BANQUE (même code AGENCE, code BANQUE).                          */
/*------------------------------------------------------------------*/
	If	sPos = ""	Then
		sCodInter = idw_wInter.GetItemString ( 1, "COD_INTER" )
		If	sCodInter = "B"	Then
			lTotInter	= idw_wInter.iuDwDetailSource.RowCount ()
			sRech			= "ID_I <> " + String ( idw_wInter.GetItemNumber ( 1, "ID_I" ) ) 								+ &
							  " And COD_AG = '" + String ( idw_wInter.GetItemString ( 1, "COD_AG" ) )		+ "'"		+ &
							  " And COD_BQ = '" + String ( idw_wInter.GetItemString ( 1, "COD_BQ" ) )		+ "'"

			lLig = idw_wInter.iuDwDetailSource.Find ( sRech, 1, lTotInter )
			If	lLig > 0 Then
				sPos 					= "COD_MODE_REG"
				stMessage.sCode	= "WINT160"
			End If
		End If
	End If

/*------------------------------------------------------------------*/
/* Le 19/01/1999.                                                   */
/* On vérifie si les coordonnées de l'(A)ssuré change. Si c'est le  */
/* cas, on affiche un message pour demander au gestionnaire s'il    */
/* veut 'recopier' la nouvelle adresse de l'assuré sur les          */
/* coordonnées du sinistre. S'il répond (O)ui, on positionne la     */
/* variable ALT_ADR de W_SIN pour permettre l'écriture d'une trace. */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 17/08/1999                                   */
/* On gère également la modification de la civilité. En effet,      */
/* elle                                                             */
/* n'intervient pas dans la recherche homonymique et n'est donc     */
/* pas                                                              */
/* plus importante que l'adresse.                                   */
/* De plus, les civilités récupérées de manière automatique auprès  */
/* des                                                              */
/* banques sont souvent Mr ou Mme. Ce qui ne fait pas terrible sur  */
/*                                                                  */
/* les courriers.                                                   */
/*------------------------------------------------------------------*/


	If	sPos = ""	And idw_wInter.GetItemString ( 1, "COD_INTER" ) = "A"	Then
		bModifCoor	= False
		bModifAdr 	= False
		
		sAdr_Col[ 1 ]	= "ADR_1"
		sAdr_Col[ 2 ]	= "ADR_2"
		sAdr_Col[ 3 ]	= "ADR_CP"
		sAdr_Col[ 4 ]	= "COD_CIV"
		sAdr_Col[ 5 ]	= "ADR_VILLE"
		sAdr_Col[ 6 ]	= "NUM_TELD"
		sAdr_Col[ 7 ]	= "NUM_TELB"
		sAdr_Col[ 8 ]	= "NUM_FAX"

		// #3
//		sAdr_Col[ 9 ]	= "ADR_MAIL_NAME"
//		sAdr_Col[10 ]	= "ADR_MAIL_DOMAIN"

		For	lCpt = 1 To 8  // #3
//		For	lCpt = 1 To 10
				sAdr_Val[ lCpt ] = Trim ( idw_wInter.GetItemString ( 1, sAdr_Col[ lCpt ] ) )
				sAdr_Prec[ lCpt ] = Trim ( idw_wInter.GetItemString ( 1, sAdr_Col[ lCpt ], Primary!, True ) )

				If IsNull ( sAdr_Val[ lCpt ] )	Then sAdr_Val[ lCpt ] = ""
				If IsNull ( sAdr_Prec[ lCpt ] )	Then sAdr_Prec[ lCpt ] = ""			

		Next

		For	lCpt = 1	To 8  // #3
//		For	lCpt = 1 To 10
			If	sAdr_Val[ lCpt ] <> sAdr_Prec[ lCpt ]	Then
					bModifCoor = True
					Exit
				End If
		Next

		If	bModifCoor	Then

			stMessage.sTitre		= "Contrôle de gestion d'un interlocuteur"
			stMessage.Icon			= Question!
			stMessage.Bouton		= YesNo!
			stMessage.bErreurG	= False
			stMessage.sCode		= "WINT170"
	
			iRet = F_Message ( stMessage )

			If	iRet = 1	Then
				For	lCpt = 1 To 8 // #3
//				For	lCpt = 1 To 10
						idw_wSin.SetItem ( 1, sAdr_Col[ lCpt ], sAdr_Val[ lCpt ] )
				Next

/*------------------------------------------------------------------*/
/* Si on ne change que les numéros de téléphone, on ne trace pas    */
/* cette information.                                               */
/*------------------------------------------------------------------*/
				For	lCpt = 1 To 5
					If	sAdr_Val[ lCpt ] <> sAdr_Prec[ lCpt ]	Then
						bModifAdr = True
						Exit
					End If
				Next

				If	bModifAdr	Then
					idw_wSin.SetItem ( 1, "MODIF_ADR", "O" )
				End If

			End If
		End If
	End If


	If	sPos <> "" Then

		stMessage.sTitre		= "Contrôle de gestion d'un interlocuteur"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= False
	
		f_Message ( stMessage )

	End If
End If

/*------------------------------------------------------------------*/
/* Il est interdit de passer des frais sur un interlocuteur de      */
/* type fournisseur                                                 */
/*------------------------------------------------------------------*/
If sPos = "" then
	If idw_LstFrais.RowCount () > 0 and idw_wInter.GetItemString ( 1, "COD_INTER" ) = "F" Then
		sPos = "NOM"
		stMessage.sTitre		= "Pas de frais pour les fournisseur"
		stMessage.Icon			= Information!
		stMessage.Bouton		= Ok!
		stMessage.bErreurG	= False
		stMessage.sCode		= "WINT180"
	
		f_Message ( stMessage )

	End If
End If


//* #1 [FNAC_PROD_ECH_TECH]
If sPos = "" then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 104 )	// Gestion suivi par SMS
	If lDeb <= 0 Then 
		If idw_wInter.GetItemString ( 1, "ALT_SUIVI_SMS" ) = "O" Then
			sPos = "ALT_SUIVI_SMS"
			stMessage.sTitre		= "Gestion suivi par SMS"
			stMessage.Icon			= Information!
			stMessage.Bouton		= Ok!
			stMessage.bErreurG	= False
			stMessage.sCode		= "WINT210"
		
			f_Message ( stMessage )			
		End If
	End If
End If

If sPos = "" then
	If idw_wInter.GetItemString ( 1, "ALT_SUIVI_SMS" ) = "O" Then
		sNumPortSms = Trim ( idw_wInter.GetItemString ( 1, "NUM_PORT_SMS" ) )
		
		If IsNull ( sNumPortSms ) Or sNumPortSms = "" Then
		
			sPos = "NUM_PORT_SMS"
			stMessage.sTitre		= "Gestion suivi par SMS"
			stMessage.Icon			= Information!
			stMessage.Bouton		= Ok!
			stMessage.bErreurG	= False
			stMessage.sCode		= "WINT220"
			f_Message ( stMessage )			
		End If
		
		//[NUM_TEL_07]
		If sPos = "" And ( Not IsNumber ( sNumPortSms ) Or Len ( sNumPortSms ) <> 10 Or ( Left ( sNumPortSms, 2 ) <> "06" And Left ( sNumPortSms, 2 ) <> "07"  ) ) Then
			sPos = "NUM_PORT_SMS"
			stMessage.sTitre		= "Gestion suivi par SMS"
			stMessage.Icon			= Information!
			stMessage.Bouton		= Ok!
			stMessage.bErreurG	= False
			stMessage.sCode		= "WINT225"
			f_Message ( stMessage )			
		End If
		
	End If
End If
//* :#1 [FNAC_PROD_ECH_TECH]

// [PM159].[Controle_mail]
If sPos = "" Then
	bMail = False
	sMailName = Trim ( idw_wInter.GetItemString ( 1, "ADR_MAIL_NAME" ) ) 
   sMaildomaine = Trim ( idw_wInter.GetItemString ( 1, "ADR_MAIL_DOMAIN" ) )
	sMail = sMailName + "@" + sMaildomaine 
	
	bMail = IsNull ( sMailName + sMaildomaine )
	
	If Not bMail Then
		bMail = Len ( sMailName + sMaildomaine ) <= 0 
	End If	

	If Not bMail Then
		bMail = F_Mail_Valide ( sMail )
	End If
	
	If Not bMail Then
			sPos = "ADR_MAIL_NAME"
			stMessage.sTitre		= "Contrôle de l'adresse mail"
			stMessage.Icon			= Information!
			stMessage.Bouton		= Ok!
			stMessage.bErreurG	= False
			stMessage.sCode		= "WINT301"
			f_Message ( stMessage )					
	End If	

End If

// [PT_BALANCE_LDE] 
If sPos="" Then
	
	lIdProd=idw_wsin.GetItemNumBer( 1,"ID_PROD")
	f_rechdetpro(lDeb, lFin, idw_Detpro,lIdProd,"-DP",185)
	
	If lDeb > 0 and idw_winter.getitemString( 1, "cod_inter") = "T" Then
	
		If isNull(idw_winter.getitemString( 1, "cod_bq")) Then
			
			stMessage.sTitre		= "Contrôle du code agence"
			stMessage.Icon			= Information!
			stMessage.Bouton		= YesNo!
			stMessage.bErreurG	= False
			stMessage.sCode		= "WINT302"
			If f_Message ( stMessage ) = 1	 Then
				Do
					OpenWithParm(w_sp_trt_saisie_pt_balance, lIdProd)
					sRetour=Message.StringParm
				Loop While sRetour="[RETOUR]"
				
				 idw_winter.SetItem( 1, "COD_BQ", nvString.of_getkeyvalue( sRetour,"COD_MAG",";"))  
				 
				 idw_winter.SetItem( 1, "COD_CIV", '5')  // Sté
 				 idw_winter.SetItem( 1, "NOM", nvString.of_getkeyvalue( sRetour,"ADR_NOM",";"))  
 				 idw_winter.SetItem( 1, "ADR_1", nvString.of_getkeyvalue( sRetour,"ADR_1",";"))  
 				 idw_winter.SetItem( 1, "ADR_2", nvString.of_getkeyvalue( sRetour,"ADR_2",";"))  
 				 idw_winter.SetItem( 1, "ADR_VILLE", nvString.of_getkeyvalue( sRetour,"ADR_VILLE",";"))  
   				 idw_winter.SetItem( 1, "ADR_CP", nvString.of_getkeyvalue( sRetour,"ADR_CP",";"))  
 				 idw_winter.SetItem( 1, "ADR_MAIL", nvString.of_getkeyvalue( sRetour,"ADR_MAIL",";"))  

				 idw_winter.SetItem( 1, "RIB_BQ", nvString.of_getkeyvalue( sRetour,"RIB_BQ",";"))  
  				 idw_winter.SetItem( 1, "RIB_GUI", nvString.of_getkeyvalue( sRetour,"RIB_GUI",";"))  
  				 idw_winter.SetItem( 1, "RIB_CPT", nvString.of_getkeyvalue( sRetour,"RIB_CPT",";"))  
  				 idw_winter.SetItem( 1, "RIB_CLE", nvString.of_getkeyvalue( sRetour,"RIB_CLE",";"))  
			End if
		End if
	End if
End if


// [RS2194_SUPDBLEBQ]
F_rechdetpro(lDeb, lFin, idw_Detpro,lIdProd,"-DP",361)

If lDeb > 0 And idw_wInter.GetItemString ( 1, "ALT_COURGEST" ) = "D" Then

	sValDp361 = nvString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "INTER", ";")		
	sCodInter = idw_wInter.GetItemString ( 1, "COD_INTER" )

	Choose Case sCodInter
		Case "A"
			If sValDp361 = "ASSURE" Then
				sPos = "ADR_MAIL_NAME"
				stMessage.sTitre		= "Double de courrier interdit (RS2194)"
				stMessage.Icon			= Information!
				stMessage.Bouton		= Ok!
				stMessage.bErreurG	= False
				stMessage.sCode		= "WINT309"
				stMessage.sVar[1]    = "assuré"
				f_Message ( stMessage ) 							
			End If 

		Case "B"
			If sValDp361 = "BANQUE" Then
				sPos = "ADR_MAIL_NAME"
				stMessage.sTitre		= "Double de courrier interdit (RS2194)"
				stMessage.Icon			= Information!
				stMessage.Bouton		= Ok!
				stMessage.bErreurG	= False
				stMessage.sCode		= "WINT309"
				stMessage.sVar[1]    = "banque"
				f_Message ( stMessage ) 
			End If 				
			
	End CHoose 
End If 

// A toujours laisser à la fin
// [PMO89_RS4822]
If bCasPMO89_RS4822_DP365 and sPos = "" and lCptValide <=0 Then
	sNomComplet = idw_winter.GetItemString ( 1, "NOM" )
	sNom = SQLCA.FN_GET_NOM_PRENOM ( sNomComplet, "N" ) 
	sPrenom = SQLCA.FN_GET_NOM_PRENOM ( sNomComplet, "P" ) 

	stMessage.sTitre		= "Découpage Prénom et Nom"
	stMessage.Icon			= Question!
	stMessage.Bouton		= YesNo!
	stMessage.bErreurG	= False
	stMessage.sCode		= "WINT312"
	stMessage.sVar[1]    = sNom
	stMessage.sVar[2]    = sPrenom

	If F_Message ( stMessage ) = 2 Then 
		sPos = "NOM"
	End IF 

End If 

astPass.sTab [ 1 ] = sPos

end subroutine

private subroutine uf_zn_codinter ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_CodInter (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/01/1998 18:23:41
//* Libellé			: 
//* Commentaires	: Vérification de la zone COD_INTER
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//       JFF   30/05/2023 [PMO89_RS4822]
//       JFF   27/03/2025 [PMO32_SPB175]
//*-----------------------------------------------------------------

String sCodInter, sCodModeReg, sValCar, sVal
Long lDeb, lFin, lRowDs
n_cst_string	lnvString 
Boolean bFin

sCodInter = idw_wInter.GetText ()

If	sCodinter = idw_Produit.GetItemString ( 1, "COD_DEST_REG" ) And IsNull ( idw_wInter.GetItemString ( 1, "COD_MODE_REG" ) ) Then
	sCodModeReg = idw_Produit.GetItemString ( 1, "COD_MODE_REG" )
	idw_wInter.SetItem ( 1, "COD_MODE_REG", sCodModeReg )
End If

// [PMO89_RS4822]
idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 365 )
If lDeb > 0 Then
	sValCar = lnvString.of_getkeyvalue(idw_DetPro.GetItemString(lDeb,"VAL_CAR" ), "TYP_INTER", ";") 
	
	If Pos ( sValCar, "#" + sCodInter + "#" ) > 0 Then
		idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "0")

		
		Do While Not bFin
			stMessage.sTitre		= "Contrôle d'interlocuteur par l'assureur"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YesNo!
			stMessage.sCode		= "WINT311"

			If F_Message ( stMessage ) = 1 Then bFin = True
		Loop
		
	Else
		idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")
	End If 
Else 
	// [PMO32_SPB175]
	If F_CLE_A_TRUE ( "PMO32_SPB175" ) Then
		lRowDS = idw_wDivSin.Find ( "Upper ( NOM_ZONE ) = 'PM506_ETAT_APPEL_APIREST_LAB'", 1, idw_wDivSin.RowCount () ) 
		If lRowDS > 0 Then
			sVal = idw_wDivSin.GetItemString ( lRowDs, "VAL_CAR" ) 
			If IsNull ( sVal ) Then sVal = ""
			If sVal = "" Then
				idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "0")
			Else 
				idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")				
			End If 
		End If 
	Else 
		idw_wInter.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")
	End If
End If 



end subroutine

private subroutine uf_gestionuajout (integer aitype);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GestionuAjout (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/01/1998 16:31:31
//* Libellé			: 
//* Commentaires	: Gestion des paragraphes d'informations
//*
//* Arguments		: Integer		aiType			(Val)	Type d'action
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG 12/02/2003  DCMP 030078 : Edition automatique d'une enveloppe
//* #2  CAG 10/09/2003	DCMP 030390 : Si déclar par téléphone, Z017 au lieu
//*						   de Z014 suite DCMP 030078
//* #3  CAG 15/09/2003	correction DCMP 030390 : ce n'est pas la décl. du sin qu'il faut
//*								prendre en compte, mais le média du travail
//*								(cod_recu de w_queue au lieu de cod_decl de w_sin)
//
//* [DCMP050251]	PHG	19/04/2006 :
//*								Application des regle de gestion 
//*								du paragraphe Z014 aux paragraphes Z040, Z041, Z042, Z043 
//*------------------------------------------------------------------


//*-----------------------------------------------------------------

String sTab, sNew, sLigne, sFiltre, sType, sName, sTabDw [ 10, 3 ]
Long lCpt, lTotParaProd, lTotParaAffecte, lNbCol, lRowZSource
String sSearchString // DCMP050251

sTab		= "~t"
sNew		= "~r~n"
sLigne	= ""

Choose Case aiType
Case 0					// On a changé de produit, on initialise les lignes de dw_Recherche
	
	iuoAjout.dw_Recherche.Reset ()
	idw_ParaProd.RowsCopy ( 1, 999, Primary!, iuoAjout.dw_Recherche, 1, Primary! )

Case 1					// On est en insertion d'un interlocuteur

	iuoAjout.dw_Source.Reset ()
	iuoAjout.dw_Cible.Reset ()

	lTotParaProd = iuoAjout.dw_Recherche.RowCount ()
/*------------------------------------------------------------------*/
/* Les zones à insérer sont les suivantes :                         */
/* ID_SIN                                                           */
/* ID_I                                                             */
/* ID_PARA                                                          */
/* CPT_TRI	: La valeur est incrémentée automatiquement             */
/* CREE_LE	: Cette valeur sera positionnée sur l'update de la DW   */
/* MAJ_LE	: Cette valeur sera positionnée sur l'update de la DW   */
/* MAJ_PAR                                                          */
/* LIB_PARA                                                         */
/* CPT_VER                                                          */
/*------------------------------------------------------------------*/

	If	lTotParaProd > 0	Then
		For	lCpt = 1 To lTotParaProd
				sLigne = sLigne 																				+ &
							String ( idw_wInter.GetItemNumber ( 1, "ID_SIN" ) )		+ sTab	+ &
							String ( idw_wInter.GetItemNumber ( 1, "ID_I" ) )			+ sTab	+ &
							iuoAjout.dw_Recherche.GetItemString ( lCpt, "ID_PARA" )	+ sTab	+ &
							"500"																		+ sTab	+ &
																										+ sTab	+ &
																										+ sTab	+ &
							stGLB.sCodOper															+ sTab	+ &
							iuoAjout.dw_Recherche.GetItemString ( lCpt, "LIB_PARA" )	+ sTab	+ &
							iuoAjout.dw_Recherche.GetItemString ( lCpt, "CPT_VER" )	+ sNew

		Next
		iuoAjout.dw_Cible.ImportString ( sLigne )
	End If

	/*------------------------------------------------------------------*/
	/* #2 CAG 10/09/2003                                                */
	/*------------------------------------------------------------------*/
	/* #3 CAG 15/09/2003 sCodDecl remp par isCodRecu                    */
	/*------------------------------------------------------------------*/
	/* [DCMP050251]-PHG-10/05/2006 : 											  */
	/* - Ajout de commentaire pour mieux comprendre        				  */
	/* le mecanisme d'exclusion des paragraphe enveloppe					  */
	/*------------------------------------------------------------------*/
	If isCodRecu = "T" Then  // Si media = telephone (T)
		sFiltre = "ID_PARA <> 'Z014'" // On exclus l'enveloppe Z014 Non anonyme
	Else
		sFiltre = "ID_PARA <> 'Z017'" // On exclus l'enveloppe Z017 anonyme
	End If
	iuoAjout.dw_Cible.SetFilter ( sFiltre )
	iuoAjout.dw_Cible.Filter ()

Case 2					// On est en modification d'un interlocuteur

	iuoAjout.dw_Source.Reset ()
	iuoAjout.dw_Cible.Reset ()

/*------------------------------------------------------------------*/
/* La DW idw_wParaInfo est triée sur ID_SIN, ID_I, CPT_TRI. On      */
/* recherche l'existence de paragraphes préalablement affectés.     */
/*------------------------------------------------------------------*/
	sFiltre = "ID_I = " + String ( idw_wInter.GetItemNumber ( 1, "ID_I" ) )

	idw_wParaInfo.SetFilter ( sFiltre )
	idw_wParaInfo.Filter ()
	idw_wParaInfo.Sort ()
	lTotParaAffecte = idw_wParaInfo.RowCount ()
	sFiltre = ""

	If	lTotParaAffecte	> 0 Then
/*------------------------------------------------------------------*/
/* On trouve des paragraphes. On les insére dans dw_Source. Au      */
/* passage, on récupéré le CODE_PARA pour filtrer dw_Recherche.     */
/*------------------------------------------------------------------*/
		idw_wParaInfo.RowsCopy ( 1, 999, Primary!, iuoAjout.dw_Source, 1, Primary! )

		For	lCpt = 1 To lTotParaAffecte
				sFiltre = sFiltre + "ID_PARA <> '" + idw_wParaInfo.GetItemString ( lCpt, "ID_PARA" ) + "' AND "
		Next
/*------------------------------------------------------------------*/
/* On enléve le dernier AND généré dans la boucle.                  */
/*------------------------------------------------------------------*/
		sFiltre = Left ( sFiltre, Len ( sFiltre ) - 5 )
	End If

/*------------------------------------------------------------------*/
/* On positionne un filtre sur recherche pour enlever les           */
/* paragraphes déjà présents (Eventuellement aucun).                */
/*------------------------------------------------------------------*/
	iuoAjout.dw_Recherche.SetFilter ( sFiltre )
	iuoAjout.dw_Recherche.Filter ()
	iuoAjout.dw_Recherche.Sort ()

	lTotParaProd = iuoAjout.dw_Recherche.RowCount ()

	If	lTotParaProd > 0	Then
		For	lCpt = 1 To lTotParaProd
				sLigne = sLigne 																				+ &
							String ( idw_wInter.GetItemNumber ( 1, "ID_SIN" ) )		+ sTab	+ &
							String ( idw_wInter.GetItemNumber ( 1, "ID_I" ) )			+ sTab	+ &
							iuoAjout.dw_Recherche.GetItemString ( lCpt, "ID_PARA" )	+ sTab	+ &
							"500"																		+ sTab	+ &
																										+ sTab	+ &
																										+ sTab	+ &
							stGLB.sCodOper															+ sTab	+ &
							iuoAjout.dw_Recherche.GetItemString ( lCpt, "LIB_PARA" )	+ sTab	+ &
							iuoAjout.dw_Recherche.GetItemString ( lCpt, "CPT_VER" )	+ sNew
		Next
		iuoAjout.dw_Cible.ImportString ( sLigne )
	End If

	sFiltre = ""
	idw_wParaInfo.SetFilter ( sFiltre )
	idw_wParaInfo.Filter ()
	idw_wParaInfo.Sort ()

	iuoAjout.dw_Recherche.SetFilter ( sFiltre )
	iuoAjout.dw_Recherche.Filter ()
	iuoAjout.dw_Recherche.Sort ()

	/*------------------------------------------------------------------*/
	/* #2 CAG 10/09/2003                                                */
	/*------------------------------------------------------------------*/
	/* #3 CAG 15/09/2003 sCodDecl remp par isCodRecu                    */
	/*------------------------------------------------------------------*/
	/* [DCMP050251]-PHG-10/05/2006 : 											  */
	/* - Ajout de commentaire pour mieux comprendre        				  */
	/* le mecanisme d'exclusion des paragraphe enveloppe					  */
	/*------------------------------------------------------------------*/
	If isCodRecu = "T" Then // Si media = telephone (T)
		sFiltre = "ID_PARA <> 'Z014'" // On exclus l'enveloppe Z014 Non anonyme
	Else
		sFiltre = "ID_PARA <> 'Z017'" // On exclus l'enveloppe Z017 anonyme
	End If
	iuoAjout.dw_Cible.SetFilter ( sFiltre )
	iuoAjout.dw_Cible.Filter ()

Case 3					// On vient de cocher ALT_QUEST, on supprime tous les paragraphes affectés
	
	/*------------------------------------------------------------------*/
	/* #1                                                               */
	/*------------------------------------------------------------------*/
	/* Suppression de tout sauf de l'enveloppe 								  */
	/*------------------------------------------------------------------*/

	/*------------------------------------------------------------------*/
	/* #2 CAG 10/09/2003                                                */
	/*------------------------------------------------------------------*/
	/* #3 CAG 15/09/2003 sCodDecl remp par isCodRecu                    */
	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/
	/* [DCMP050251]-PHG-10/05/2006 : 											  */
	/* - On teste en plus la présence d'autre enveloppe listée dans la  */
	/*   Variable d'instance  														  */
	/* - Optimisation du code de suppression des lignes					  */
	/*------------------------------------------------------------------*/
	If isCodRecu = "T" Then
		lRowZSource = iuoAjout.dw_Source.Find ( "ID_PARA = 'Z017'", 1, iuoAjout.dw_Source.RowCount () )
	Else
		lRowZSource = iuoAjout.dw_Source.Find ( "ID_PARA = 'Z014'", 1, iuoAjout.dw_Source.RowCount () )
	End If
	
	// [DCMP050251]-PHG-10/05/2006 : Recherche des enveloppes z040 a z043
	// On s'arrete sur la première trouvée si on a pas trouvé de Z017 ou de Z014
	IF lRowZSource = 0 Then
		lRowZSource  = &
			iuoAjout.dw_Source.Find &
				( 	"ID_PARA IN ("+uf_BuildStringList(isListEnvZ0)+")", &
					1, &
					iuoAjout.dw_Source.RowCount () &
				)
	End If
	
	If lRowZSource > 0 Then
		// [DCMP050251]-PHG-10/05/2006 : Optimisation
		// Le code ci-dessous est remplacé par les deux rowsdiscard situé apres ce script mis en commentaire
//		lNbCol = Long ( iuoAjout.dw_Source.Describe ( "DATAWINDOW.COLUMN.COUNT") )
//		For lCpt = 1 To lNbCol
//			sName = iuoAjout.dw_Source.Describe ( "#" + String ( lCpt ) + ".NAME" )
//			sType = Left ( iuoAjout.dw_Source.Describe ( sName + ".COLTYPE" ), 5 )
//			Choose Case sType
//			Case "char("
//				sTabDw [ lCpt, 1 ] = iuoAjout.dw_Source.GetItemString ( lRowZSource, sName )
//			Case "decim", "numbe"
//				sTabDw [ lCpt, 1 ] = String ( iuoAjout.dw_Source.GetItemNumber ( lRowZSource, sName ) )
//			Case "date"
//				sTabDw [ lCpt, 1 ] = String ( iuoAjout.dw_Source.GetItemDate ( lRowZSource, sName ), "yyyy-mm-dd" )
//			Case "datet"
//				sTabDw [ lCpt, 1 ] = String ( iuoAjout.dw_Source.GetItemDateTime ( lRowZSource, sName ), "yyyy-mm-dd hh:mm:ss.ff" )
//			Case "time"
//				sTabDw [ lCpt, 1 ] = String ( iuoAjout.dw_Source.GetItemTime ( lRowZSource, sName ), "hh:mm:ss.ffffff" )
//			End Choose
//			sTabDw [ lCpt, 2 ] = sName
//			sTabDw [ lCpt, 3 ] = sType
//		Next
//
//		iuoAjout.dw_Source.Reset ()
//		iuoAjout.dw_Source.InsertRow ( 0 )
//
//		For lCpt = 1 To lNbcol
//			If sTabDw [ lCpt, 1 ] <> "" Then
//				Choose Case sTabDw [ lCpt, 3 ]
//					Case "char("
//						iuoAjout.dw_Source.SetItem ( 1, sTabDw [ lCpt, 2 ], sTabDw [ lCpt, 1 ] )
//					Case "decim", "numbe"
//						iuoAjout.dw_Source.SetItem ( 1, sTabDw [ lCpt, 2 ], Dec ( sTabDw [ lCpt, 1 ] ) )
//					Case "date"
//						iuoAjout.dw_Source.SetItem ( 1, sTabDw [ lCpt, 2 ], Date ( sTabDw [ lCpt, 1 ] ) )
//					Case "datet"
//						iuoAjout.dw_Source.SetItem ( 1, sTabDw [ lCpt, 2 ], DateTime ( Date ( sTabDw [ lCpt, 1 ] ), Time ( sTabDw [ lCpt, 1 ] ) ) )
//					Case "time"
//						iuoAjout.dw_Source.SetItem ( 1, sTabDw [ lCpt, 2 ], Time ( sTabDw [ lCpt, 1 ] ) )
//				End Choose
//			End If
//		Next
		if lRowZSource < iuoAjout.dw_Source.rowcount() then
			iuoAjout.dw_Source.RowsDiscard(lRowZSource+1,iuoAjout.dw_Source.rowcount(), Primary!) 	
		end If
		if lRowZSource > 1 then
			iuoAjout.dw_Source.RowsDiscard(1,lRowZSource - 1, Primary!) 	
		End If
		iuoAjout.dw_Source.ResetUpdate() 	
	Else
		iuoAjout.dw_Source.Reset ()
	End If

End Choose
end subroutine

private subroutine uf_changerproduit ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ChangerProduit (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 23/01/1998 17:40:41
//* Libellé			: 
//* Commentaires	: A t-on changé de produit ?
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//		FPI	25/05/2012	[PC292] Modif de la dddw des courriers
/*------------------------------------------------------------------*/
/* L'événement Ue_Initialisation n'est déclenchée qu'une seule      */
/* fois. Or la fenêtre de traitement détail a besoin de savoir si   */
/* le produit a changé. Il faut donc faire le test sur              */
/* Uf_PreparerModifier et Uf_PreparerInserer.                       */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Les initialisations relatives au Produit/Révision auront lieu    */
/* ici.                                                             */
/*------------------------------------------------------------------*/
Long lIdProd

DataWindowChild		dwChild, dwChild1

lIdProd	= idw_Produit.GetItemNumber ( 1, "ID_PROD" )

If	lIdProd <> ilDernierIdProd Then

/*------------------------------------------------------------------*/
/* On réinitialise les paragraphes de PARA_PROD.                    */
/*------------------------------------------------------------------*/
	Uf_GestionuAjout ( 0 )

/*------------------------------------------------------------------*/
/* Les natures de courrier sont fonctions du code produit.          */
/*------------------------------------------------------------------*/
	idw_wInter.iudwDetailSource.GetChild ( "ID_NAT_COUR", dwChild )
	idw_wInter.GetChild ( "ID_NAT_COUR", dwChild1 )
	dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* On s'occupe de la colonne ID_COURJ, qui demande la populisation  */
/* des courriers que l'on peut joindre.                             */
/*------------------------------------------------------------------*/
	idw_wInter.GetChild ( "ID_COURJ", dwChild )
	dwChild.SetTransObject ( This.itrTrans )
	dwChild.Retrieve ( lIdProd )

	ilDernierIdProd = lIdProd
End If



end subroutine

private subroutine uf_gestion_frais (integer aitype);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Gestion_Frais (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/01/1998 16:31:31
//* Libellé			: 
//* Commentaires	: Gestion des frais pour l'interlocuteur
//*
//* Arguments		: Integer		aiType			(Val)	Type d'action
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sFiltre
Long lTotFrais, lCpt

Choose Case aiType

Case 1					// On est en insertion d'un interlocuteur

	idw_LstFrais.Reset ()

Case 2					// On est en modification d'un interlocuteur
/*------------------------------------------------------------------*/
/* Important, il ne faut pas oublier de positionner le statut des   */
/* lignes récupérées à NotModified!.                                */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Les lignes sont positionnées à NewModified! et il faut les       */
/* mettre à NotModified! (Obligatoire pour la gestion du niveau 2). */
/* On passe donc les lignes d'abord en DataModified! puis en        */
/* NotModified!                                                     */
/*------------------------------------------------------------------*/

	idw_LstFrais.Reset ()

	sFiltre = "ID_I = " + String ( idw_wInter.GetItemNumber ( 1, "ID_I" ) ) 

	idw_wFrais.SetFilter ( sFiltre )
	idw_wFrais.Filter ()
	idw_wFrais.Sort ()	
	lTotFrais = idw_wFrais.RowCount ()
	
	idw_wFrais.RowsCopy ( 1, lTotFrais, Primary!, idw_LstFrais, 1, Primary! )
	idw_LstFrais.Sort ()

/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_wFrais.                               */
/*------------------------------------------------------------------*/
	sFiltre = ""
	idw_wFrais.SetFilter ( sFiltre )
	idw_wFrais.Filter ()
	idw_wFrais.Sort ()

/*------------------------------------------------------------------*/
/* On positionne le statut des lignes de frais.                     */
/*------------------------------------------------------------------*/
	For	lCpt = 1 To lTotFrais
			idw_LstFrais.SetItemStatus ( lCpt, 0, Primary!, DataModified! )
			idw_LstFrais.SetItemStatus ( lCpt, 0, Primary!, NotModified! )
	Next

End Choose

end subroutine

private subroutine uf_preparervalider (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerValider (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la validation d'un interlocuteur
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
String sIdNatCour, sIdCour, sNull
Boolean	bCpPresentApres
Long lDeb, lFin

SetNull ( sNull )
bCpPresentApres = This.uf_PresenceCP ( idw_wInter.GetItemNumber ( 1, "ID_I" ), idw_wInter.GetItemString ( 1, "COD_INTER" ))

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des paragraphes de l'interlocuteur.     */
/*------------------------------------------------------------------*/
Uf_PreparerValider_Paragraphe ( astPass )

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des frais de l'interlocuteur.           */
/*------------------------------------------------------------------*/
Uf_PreparerValider_Frais ( astPass )

If Not ibCpPresentAvant And bCpPresentApres  Then
	idw_wInter.SetItem ( 1, "ID_NAT_COUR", "APART1"  )
	idw_wInter.SetItem ( 1, "ID_COUR", "APART1"  )
	idw_wInter.SetItem ( 1, "ALT_PART", "O" )
Else

	sIdNatCour = idw_wInter.GetItemString ( 1, "ID_NAT_COUR" )
	If IsNull ( sIdNatCour ) Then sIdNatCour = "" 

	If sIdCour = "" And This.uf_PresenceCP ( idw_wInter.GetItemNumber ( 1, "ID_I" ), idw_wInter.GetItemString ( 1, "COD_INTER" )) Then
		idw_wInter.SetItem ( 1, "ID_COUR", "APART1"  )
		idw_wInter.SetItem ( 1, "ALT_PART", "O" )
	End If

	sIdCour    = idw_wInter.GetItemString ( 1, "ID_COUR" )
	If IsNull ( sIdCour ) Then sIdCour = "" 

	If sIdNatCour = "" And ( Not IsNull ( sIdCour ) ) Then
		idw_wInter.SetItem ( 1, "ID_NAT_COUR", sIdCour  )
	End If
ENd If

/*------------------------------------------------------------------*/
/* On supprime le controle OLE de type WORD. (Dans le cas ou il     */
/* existe).                                                         */
/*------------------------------------------------------------------*/
If Not ibsaisievalidation Then 
	iUoCourrierWord.Uf_Deconnecter ()
End If

end subroutine

private subroutine uf_preparervalider_paragraphe (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerValider_Paragraphe (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Validation des paragraphes pour l'interlocuteur
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lTotParaAffecte, lCpt, lTotwParaInfo, lTotSupp, lIdI
String sFiltre

Boolean bMove

bMove						= True

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des paragraphes.                        */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* En insertion, on recopie les lignes simplement. La variable      */
/* bInsert est armée sur la fonction Wf_ControlerSaisie de la       */
/* fenêtre des Interlocuteurs.                                      */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* En modification, on supprime les lignes existantes et on insére  */
/* les autres sans se poser de questions d'optimisation.(Voir St    */
/* Denis)                                                           */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Pour optimiser le DELETE, on va supprimer avec une seule         */
/* commande tous les paragraphes. Il faut donc positionner une      */
/* seule ligne dans le buffer Delete! et faire un RowsDiscard sur   */
/* toutes les autres.                                               */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On supprime toutes les lignes de dw_wParaInfo pour               */
/* l'interlocuteur en cours.                                        */
/*------------------------------------------------------------------*/

If	Not astPass.bInsert Then
	sFiltre = "ID_I = " + String ( idw_wInter.GetItemNumber ( 1, "ID_I" ) )

	idw_wParaInfo.SetFilter ( sFiltre )
	idw_wParaInfo.Filter ()
	lTotwParaInfo = idw_wParaInfo.RowCount ()

	lTotSupp = idw_wParaInfo.DeletedCount ()
	For	lCpt = 1 To lTotSupp
			lIdI = idw_wParaInfo.GetItemNumber ( lCpt, "ID_I", Delete!, False )
			If	lIdI = idw_wInter.GetItemNumber ( 1, "ID_I" )	Then
				bMove = False
				Exit
			End If
	Next

	If	bMove	Then
		If	idw_wInter.iudwDetailSource.GetItemStatus ( idw_wInter.ilLigneDetailSource, 0, Primary! ) = NewModified!	Then
			idw_wParaInfo.RowsDiscard ( 1, lTotwParaInfo, Primary! )
		Else
			idw_wParaInfo.RowsDiscard ( 2, lTotwParaInfo, Primary! )
			idw_wParaInfo.RowsMove ( 1, 1, Primary!, idw_wParaInfo, 1, Delete! )
		End If
	Else
		idw_wParaInfo.RowsDiscard ( 1, lTotwParaInfo, Primary! )
	End If

	sFiltre = ""
	idw_wParaInfo.SetFilter ( sFiltre )
	idw_wParaInfo.Filter ()
End If

/*------------------------------------------------------------------*/
/* On insére les nouvelles lignes.                                  */
/*------------------------------------------------------------------*/
lTotParaAffecte = iuoAjout.dw_Source.RowCount ()

If	lTotParaAffecte > 0 Then
/*------------------------------------------------------------------*/
/* On positionne de manière fiable le Compteur de Tri (CPT_TRI).    */
/*------------------------------------------------------------------*/
	For	lCpt = 1 To lTotParaAffecte
			iuoAjout.dw_Source.SetItem ( lCpt, "CPT_TRI", lCpt )
	Next

	iuoAjout.dw_Source.RowsMove ( 1, lTotParaAffecte, Primary!, idw_wParaInfo, 1, Primary! )
End If
	

end subroutine

private subroutine uf_preparervalider_frais (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerValider_Frais (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la validation des frais
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long 				lTotFrais, lCptFrais, lTotSupp
Long				lCptCol, lTotCol

String			sFiltreNull, sFiltreFrais

Boolean			bMove

dwItemStatus	Status, StatuswFrais

/*------------------------------------------------------------------*/
/* Si on est en insertion d'un interlocuteur, on peut balancer tous */
/* les frais danw W_FRAIS.                                          */
/*------------------------------------------------------------------*/
lTotFrais 		= idw_LstFrais.RowCount ()
sFiltreNull		= ""

If	idw_wInter.iudwDetailSource.GetItemStatus ( idw_wInter.ilLigneDetailSource, 0, Primary! ) = NewModified!	Or &
	astPass.bInsert = True Then

	sFiltreFrais = "ID_I = " + String ( idw_wInter.GetItemNumber ( 1, "ID_I" ) )

	idw_wFrais.SetFilter ( sFiltreFrais )
	idw_wFrais.Filter ()
	lTotSupp = idw_wFrais.RowCount ()
	idw_wFrais.RowsDiscard ( 1, lTotSupp, Primary! )
	idw_wFrais.SetFilter ( sFiltreNull )
	idw_wFrais.Filter ()
	idw_LstFrais.RowsMove ( 1, lTotFrais, Primary!, idw_wFrais, 1, Primary! )

Else
/*------------------------------------------------------------------*/
/* On s'occupe d'abord des frais qui ont été supprimés. On va       */
/* optimiser les DELETE.                                            */
/*------------------------------------------------------------------*/
	lTotSupp = idw_wFraisSupp.RowCount ()

	For	lCptFrais	= lTotSupp	To 1	Step -1
			sFiltreFrais = "ID_I = " + String ( idw_wInter.GetItemNumber ( 1, "ID_I" ) ) + &
						 		 " AND ID_FRAIS = " + String ( idw_wFraisSupp.GetItemNumber ( lCptFrais, "ID_FRAIS" ) )

			idw_wFrais.SetFilter ( sFiltreFrais )
			idw_wFrais.Filter ()
			lTotFrais = idw_wFrais.RowCount ()

			If	lTotFrais > 0	Then
/*------------------------------------------------------------------*/
/* On supprime maintenant le frais en passant la ligne              */
/* sélectionnée dans la buffer Delete.                              */
/*------------------------------------------------------------------*/
				idw_wFrais.RowsMove ( 1, 1, Primary!, idw_wFrais, 1, Delete! )

				idw_wFrais.SetFilter ( sFiltreNull )
				idw_wFrais.Filter ()
			End If
	Next

/*------------------------------------------------------------------*/
/* On est en modification d'un interlocuteur. On va parcourir la    */ 
/* liste  des frais.                                                */
/*------------------------------------------------------------------*/
	lTotFrais	= idw_LstFrais.RowCount ()
	For	lCptFrais = lTotFrais To 1 Step -1
			bMove		= True
			Status	= idw_LstFrais.GetItemStatus ( lCptFrais, 0, Primary! )
/*------------------------------------------------------------------*/
/* Si le frais est en insertion, on insére la ligne dans  W_FRAIS.  */
/*------------------------------------------------------------------*/
			sFiltreFrais = "ID_I = " + String ( idw_wInter.GetItemNumber ( 1, "ID_I" ) ) + &
						 		 " AND ID_FRAIS = " + String ( idw_LstFrais.GetItemNumber ( lCptFrais, "ID_FRAIS" ) )

			Choose Case Status
			Case	NewModified!
/*------------------------------------------------------------------*/
/* Le Frais courant.                                                */
/*------------------------------------------------------------------*/
				idw_LstFrais.RowsMove ( lCptFrais, lCptFrais, Primary!, idw_wFrais, 1, Primary! )

			Case DataModified!
/*------------------------------------------------------------------*/
/* Le frais est en modification. on va supprimer la ligne de        */
/* W_FRAIS ( faire un RowsDiscard sur cette ligne ). Ensuite,       */
/* on recopie la ligne de W_LSTFRAIS dans W_FRAIS avec un statut    */
/* à Modified! pour envoyer un UPDATE.                              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le Frais courant.                                                */
/*------------------------------------------------------------------*/
				idw_wFrais.SetFilter ( sFiltreFrais )
				idw_wFrais.Filter ()

/*------------------------------------------------------------------*/
/* Le 25/08/1998                                                    */
/* Le gestionnaire insére un frais (CTL+VAL), valide                */
/* l'interlocuteur, puis revient modifier le frais (CTL+VAL),       */
/* revalide l'interlocuteur sans rien toucher d'autre.              */
/* Problème sur la validation. Normal, car le frais passe en        */
/* DataModified!, or il n'a jamais été enregistré sur le moteur.    */
/*------------------------------------------------------------------*/
				StatuswFrais	= idw_wFrais.GetItemStatus ( 1, 0, Primary! )

				If	StatuswFrais = NewModified!	Then
					idw_wFrais.RowsDiscard ( 1, 1, Primary! )

					idw_LstFrais.RowsMove ( lCptFrais, lCptFrais, Primary!, idw_wFrais, 1, Primary! )
					idw_wFrais.SetItemStatus ( 1, 0, Primary!, NewModified! )
				Else

					idw_wFrais.RowsDiscard ( 1, 1, Primary! )

					idw_LstFrais.RowsMove ( lCptFrais, lCptFrais, Primary!, idw_wFrais, 1, Primary! )
					idw_wFrais.SetItemStatus ( 1, 0, Primary!, DataModified! )
/*------------------------------------------------------------------*/
/* !! Important, pour que l'update puisse partir, il faut les       */
/* colonnes possédent le statut DataModified!.                      */
/*------------------------------------------------------------------*/
					lTotCol = Long ( idw_wFrais.Describe ( "DataWindow.Column.Count" ) )
					For	lCptCol = 1 To lTotCol
						idw_wFrais.SetItemStatus ( 1, lCptCol, Primary!, DataModified! )
					Next
				End If

				idw_wFrais.SetFilter ( sFiltreNull )
				idw_wFrais.Filter ()
				
			End Choose
	Next
End If


end subroutine

private subroutine uf_preparersupprimer (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_Interlocuteur::Uf_PreparerSupprimer
//* Auteur			: Erick John Stark
//* Date				: 28/01/1998 09:42:07
//* Libellé			: 
//* Commentaires	: On veut supprimer un interlocuteur
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF 22/03/2004  DCMP 040020 SVE
//* #2	FPI	26/01/2010	[201001261350] Empêcher la suppr de l'inter assuré
//*-----------------------------------------------------------------

String sFiltre, sCodInter, sValCar, sPos, sLibInter
Long lTotwParaInfo, lCpt, lTotSupp, lIdI, lTotwFrais, lDeb, lFin
Integer iRet

sCodInter = idw_wInter.GetItemString ( 1, "COD_INTER" ) 

/*------------------------------------------------------------------*/
/* On vérifie si on se trouve sur l'onglet N° 01. (Onglet           */
/* Interlocuteur). On affiche un message qui demande si on veut     */
/* supprimer l'interlocuteur courant.                               */
/*------------------------------------------------------------------*/
If	iuoOng.Uf_RecupererOngletCourant () <> "01" Then
	iuoOng.Uf_ChangerOnglet ( "01" )
	icbCommune.Show ()
End If

stMessage.sTitre		= "Suppression d'un interlocuteur"
stMessage.Icon			= Information!
stMessage.sVar[1] 	= "l'interlocuteur "
stMessage.bErreurG	= FALSE

// #2
If idw_winter.GetItemString(1,"COD_INTER") = "A" Then
	stMessage.sCode		= "WINT300"
	stMessage.bouton	 	= Ok!
	F_Message ( stMessage )
	iRet = 2
Else
// Fin #2

	// [MIG147_KRYS]
	If F_CLE_A_TRUE ( "MIG147_KRYS" ) Then
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 401 )
		If lDeb > 0 Then
			sValCar = idw_DetPro.GetItemString(lDeb,"VAL_CAR" )
			sValCar = F_CLE_VAL ("TYP_INTER", sValCar, ";") 
			
			If sValCar = "" Then
				iRet = 2
				stMessage.berreurg=FALSE
				stMessage.bouton=Ok!
				stMessage.icon=Information!
				stMessage.stitre="Gestion des interlocuteurs"
				stMessage.scode ="WINT321"
				F_Message ( stMessage )
			End If 
			
			
			If sValCar <> "" And Not IsNull ( sCodInter ) And Pos ( sValCar, "#" + sCodInter + "#" ) > 0 Then
				
				sLibInter = SQLCA.FN_CODE_CAR ( sCodInter, "-IN" )
		
				iRet = 2		
				stMessage.berreurg=FALSE
				stMessage.bouton=Ok!
				stMessage.icon=Information!
				stMessage.stitre="Gestion des interlocuteurs"
				stMessage.sVar[1] = sLibInter
				stMessage.scode ="WINT322"
				F_Message ( stMessage )		
		
			End If 

		Else
			stMessage.bouton	 	= YesNo!
			stMessage.sCode		= "GENE020"
		
			iRet = F_Message ( stMessage )

		End If 
	Else
		stMessage.bouton	 	= YesNo!
		stMessage.sCode		= "GENE020"
	
		iRet = F_Message ( stMessage )
		
	End If

End if // #2

/*------------------------------------------------------------------*/
/* Si on ne veut pas supprimer l'enregistrement, on s'arrete.       */
/*------------------------------------------------------------------*/
If	iRet = 2 Then
	astPass.bRetour = False
Else
/*------------------------------------------------------------------*/
/* GESTION DES PARAGRAPHES POUR UN INTERLOCUTEUR.                   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Il faut maintenant enlever les lignes du buffer DELETE! qui      */
/* peuvent être impactées.                                          */
/* L'utilisateur a changé une première fois les lignes avant de     */
/* vouloir supprimer l'interlocuteur.                               */
/*------------------------------------------------------------------*/

	lTotSupp = idw_wParaInfo.DeletedCount ()

	For	lCpt = lTotSupp To 1 Step -1
			lIdI = idw_wParaInfo.GetItemNumber ( lCpt, "ID_I", Delete!, False )

			If	lIdI = idw_wInter.GetItemNumber ( 1, "ID_I" ) Then
				idw_wParaInfo.RowsDiscard ( lCpt, lCpt, Delete! )
			End If
	Next

/*------------------------------------------------------------------*/
/* On veut supprimer un interlocuteur, il faut optimiser les        */
/* commandes DELETE qui partent sur le moteur.                      */
/* La commande DELETE sur les interlocuteurs supprime aussi les     */
/* tables dépendantes (W_PARA_INFO, W_INTER_BLOB, W_FRAIS), donc    */
/* il ne faut pas envoyer de DELETE par la suite sur ces tables.    */
/*------------------------------------------------------------------*/

	sFiltre = "ID_I = " + String ( idw_wInter.GetItemNumber ( 1, "ID_I" ) )

	idw_wParaInfo.SetFilter ( sFiltre )
	idw_wParaInfo.Filter ()
	lTotwParaInfo = idw_wParaInfo.RowCount ()

	idw_wParaInfo.RowsDiscard ( 1, lTotwParaInfo, Primary! )

	sFiltre = ""
	idw_wParaInfo.SetFilter ( sFiltre )
	idw_wParaInfo.Filter ()

/*------------------------------------------------------------------*/
/* GESTION DES FRAIS POUR UN INTERLOCUTEUR.                         */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Il faut maintenant enlever les lignes du buffer DELETE! qui      */
/* peuvent être impactées.                                          */
/* L'utilisateur a changé une première fois les lignes avant de     */
/* vouloir supprimer l'interlocuteur.                               */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On s'occupe des frais.                                           */
/*------------------------------------------------------------------*/
	lTotSupp = idw_wFrais.DeletedCount ()

	For	lCpt = lTotSupp To 1 Step -1
			lIdI = idw_wFrais.GetItemNumber ( lCpt, "ID_I", Delete!, False )

			If	lIdI = idw_wInter.GetItemNumber ( 1, "ID_I" ) Then
				idw_wFrais.RowsDiscard ( lCpt, lCpt, Delete! )
			End If
	Next

/*------------------------------------------------------------------*/
/* On veut supprimer un interlocuteur, il faut optimiser les        */
/* commandes DELETE qui partent sur le moteur.                      */
/* La commande DELETE sur les interlocuteurs supprime aussi les     */
/* tables dépendantes (W_PARA_INFO, W_INTER_BLOB, W_FRAIS), donc    */
/* il ne faut pas envoyer de DELETE par la suite sur ces tables.    */
/*------------------------------------------------------------------*/

	sFiltre = "ID_I = " + String ( idw_wInter.GetItemNumber ( 1, "ID_I" ) )

	idw_wFrais.SetFilter ( sFiltre )
	idw_wFrais.Filter ()
	lTotwFrais = idw_wFrais.RowCount ()

	idw_wFrais.RowsDiscard ( 1, lTotwFrais, Primary! )

	sFiltre = ""
	idw_wFrais.SetFilter ( sFiltre )
	idw_wFrais.Filter ()

	astPass.bRetour = True
End If

/*------------------------------------------------------------------*/
/* On supprime le controle OLE de type WORD. (Dans le cas ou il     */
/* existe).                                                         */
/*------------------------------------------------------------------*/
If Not ibsaisievalidation Then 
	iUoCourrierWord.Uf_Deconnecter ()
End If

/*------------------------------------------------------------------*/
/* #1 Gestion Saisie/Validation.                                    */
/*------------------------------------------------------------------*/
If	ibSaisieValidation Then
	invSaisieValInter.uf_btSupCPart ( 0 )
End If


end subroutine

private subroutine uf_gestion_double_inter ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_Interlocuteur::Uf_Gestion_Double_Inter (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 12/06/1998 15:00:59
//* Libellé			: 
//* Commentaires	: Gestion de la DDLB ppour la liste des interlocuteurs
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lTotInter, lCpt, lIdInter, lIdILu
Integer iIndex
String sVal, sCodInterLu

lTotInter	= idw_wInter.iudwDetailSource.RowCount ()
lIdInter		= idw_wInter.GetItemNumber ( 1, "ID_I" )
iIndex		= 1

idw_wInter.ClearValues ( "ID_I_DB" )

/*------------------------------------------------------------------*/
/* Le 15/06/1998. Selon St Denis(!!); on ne gére pas de double      */
/* pour le type d'assuré AUTRE. Il faut donc les exclure de la      */
/* construction de la ListBox.                                      */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le test sur le ID_I_DB est réalisé sur le controle de saisie     */
/* des interlocuteurs. Vraisemblance de la zone (Assuré<->Banque).  */
/*------------------------------------------------------------------*/

For	lCpt = 1 To lTotInter
		lIdILu		= idw_wInter.iudwDetailSource.GetItemNumber ( lCpt, "ID_I" )
		sCodInterLu	= idw_wInter.iudwDetailSource.GetItemString ( lCpt, "COD_INTER" )

		If	sCodInterLu <> "T" And lIdILu <> lIdInter	Then
			sVal = idw_wInter.iudwDetailSource.GetItemString ( lCpt, "NOM" )					+ "~t" 	+ &
					 String ( idw_wInter.iudwDetailSource.GetItemNumber ( lCpt, "ID_I" ) )

			idw_wInter.SetValue ( "ID_I_DB", iIndex, sVal )
			iIndex ++
		End If
Next


end subroutine

private subroutine uf_initialiser_fichier_word ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_Interlocuteur::Uf_InitialiserFichier_Word (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 18:29:19
//* Libellé			: 
//* Commentaires	: Initialisation des fichiers Words pour les courriers particuliers,
//*					  le paragraphe AUTRE PIECE et le POST-SCRIPTUM
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sPce, sPs, sPart
Long lIdInter

If ibsaisievalidation Then Return

lIdInter = idw_wInter.GetItemNumber ( 1, "ID_I" )

/*------------------------------------------------------------------*/
/* On initialise le nom des trois fichiers, que l'on passe au       */
/* UserObjet.                                                       */
/*------------------------------------------------------------------*/

sPce	= stGlb.sCodAppli + String ( lIdInter, "0000" ) + ".PC"
sPs	= stGlb.sCodAppli + String ( lIdInter, "0000" ) + ".PS"
sPart	= stGlb.sCodAppli + String ( lIdInter, "0000" ) + ".CP"

iUoCourrierWord.Uf_Init_Inter ( { sPce, sPs, sPart } )



end subroutine

private subroutine uf_preparerabandonner (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerAbandonner (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: On adandonne la saisie de l'interlocuteur
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On supprime le controle OLE de type WORD. (Dans le cas ou il     */
/* existe).                                                         */
/*------------------------------------------------------------------*/
If Not ibsaisievalidation Then 
	iUoCourrierWord.Uf_Deconnecter ()
End If 
		
astPass.bRetour = True

end subroutine

public subroutine uf_gestion_onglet (integer aitype);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_Interlocuteur::Uf_Gestion_Onglet (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 15/07/1998 14:19:02
//* Libellé			: 
//* Commentaires	: Gestion de l'onglet Paragraphes d'informations 
//*
//* Arguments		: Integer		aiType			(Val)	Type de traitement
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sBitmap1, sBitmap2

sBitmap1 = "K:\PB4OBJ\BMP\8_REF.BMP"
sBitmap2 = "K:\PB4OBJ\BMP\8_ALPCE.BMP"

Choose Case aiType
Case 1
/*------------------------------------------------------------------*/
/* On est en insertion d'un interlocuteur, on active l'accés aux    */
/* paragraphes ainsi que le bitmap.                                 */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On vient de modifier ALT_QUEST, (ALT_QUEST=N) Accés AUTORISE.    */
/*------------------------------------------------------------------*/
	iuoOng.Uf_ActiverOnglet ( "02", True )
	iuoOng.Uf_ChangerBitmap ( "02", "" )


Case 2
/*------------------------------------------------------------------*/
/* On est en modification d'un interlocuteur. On vérifie si la      */
/* personne peut avoir accés à l'onglet des paragraphes.            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le courrier est un questionnaire, accés INTERDIT.                */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Il existe un courrier particulier, accés INTERDIT.               */
/*------------------------------------------------------------------*/
	If			idw_wInter.GetItemString ( 1, "ALT_QUEST" )	= "O"	Or &
				idw_wInter.GetItemString ( 1, "ALT_PART" )	= "O"	Then
				iuoOng.Uf_ActiverOnglet ( "02", False )
				iuoOng.Uf_ChangerBitmap ( "02", sBitmap1 )
/*------------------------------------------------------------------*/
/* Il existe des paragraphes de sélectionnés dans Uo_Ajout, Accés   */
/* AUTORISE.                                                        */
/*------------------------------------------------------------------*/
	ElseIf	iuoAjout.dw_Source.RowCount () > 0 Then
				iuoOng.Uf_ActiverOnglet ( "02", True )
				iuoOng.Uf_ChangerBitmap ( "02", sBitmap2 )
	Else
				iuoOng.Uf_ActiverOnglet ( "02", True )
				iuoOng.Uf_ChangerBitmap ( "02", "" )
	End If

Case 3
/*------------------------------------------------------------------*/
/* On vient de modifier ALT_QUEST, (ALT_QUEST=O) Accés INTERDIT.    */
/*------------------------------------------------------------------*/
	iuoOng.Uf_ActiverOnglet ( "02", False )
	iuoOng.Uf_ChangerBitmap ( "02", sBitmap1 )

Case 4
/*------------------------------------------------------------------*/
/* On vient de supprimer le courrier particulier.                   */
/*------------------------------------------------------------------*/
	If	idw_wInter.GetItemString ( 1, "ALT_QUEST" )	= "N"	And iuoAjout.dw_Source.RowCount () = 0	Then
		iuoOng.Uf_ActiverOnglet ( "02", True )
		iuoOng.Uf_ChangerBitmap ( "02", "" )
	End If

End Choose


end subroutine

private subroutine uf_gestion_str2nul ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_Interlocuteur::Uf_Gestion_Str2Nul (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 17/10/1998 18:05:58
//* Libellé			: 
//* Commentaires	: Cette fonction transforme les chaines vides en NULL
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sCol[ 11 ]
String sVal
Long lCpt, lNbrCol

/*------------------------------------------------------------------*/
/* Le but de cette fonction est de transformer toutes les zones au  */
/* format STRING dans la DW courante en NULL. Cela évitera d'avoir  */
/* sur le moteurs des zones avec des blancs. Cette fonction doit    */
/* être appelée avant la fonction Uf_ControlerSaisie ().            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* De plus si le gestionnaire saisi des blancs DEVANT la zone,      */
/* ces caractères sont automatiquement enlevés.                     */
/*------------------------------------------------------------------*/

lNbrCol				= UpperBound ( sCol )

sCol[  1 ] = "NOM"
sCol[  2 ] = "ADR_1"
sCol[  3 ] = "ADR_2"
sCol[  4 ] = "ADR_CP"
sCol[  5 ] = "ADR_VILLE"
sCol[  6 ] = "ADR_ATT"
sCol[  7 ] = "NUM_TELD"
sCol[  8 ] = "NUM_TELB"
sCol[  9 ] = "NUM_FAX"
sCol[ 10 ] = "V_REF1"
sCol[ 11 ] = "V_REF2"

For	lCpt = 1 To lNbrCol
		sVal = Trim ( idw_wInter.GetItemString ( 1, sCol[ lCpt ] ) )
		If Len ( sVal ) = 0 Then
			idw_wInter.SetItem ( 1, sCol[ lCpt ], stNul.str )
		Else
			idw_wInter.SetItem ( 1, sCol[ lCpt ], sVal )
		End If
Next
end subroutine

private subroutine uf_initialiserfenetre (ref s_pass astpassdga);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_InitialiserFenetre (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Initialisation de la fenêtre des interlocuteurs
//*
//* Arguments		: Ref		s_Pass		astPassDga		
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ 	PAR		Date		Modification
//* #1  	CAG	05/08/2003  Ajout de la zone Ordre_cheque
//* #2	JCA	24/05/2006	DntMail
//       JFF   30/05/2023  [PMO89_RS4822]
//*-----------------------------------------------------------------

DataWindowChild		dwChild, dwChild1

// #2
String sCol[27]

/*------------------------------------------------------------------*/
/* SVE DCMP 040020                                                  */
/*------------------------------------------------------------------*/
ibSaisieValidation = astPassDga.bTab[2]

/*------------------------------------------------------------------*/
/* On récupére les DDDW qui ne changent jamais.                     */
/* Colonnes COD_CIV, COD_MOD_REG.                                   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On peut faire un ShareData pour toutes les DDDW avec             */
/* idw_wInter.iudwDetailSource                                      */
/*------------------------------------------------------------------*/
idw_wInter.iudwDetailSource.GetChild ( "COD_CIV", dwChild )
idw_wInter.GetChild ( "COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_wInter.iudwDetailSource.GetChild ( "COD_MODE_REG", dwChild )
idw_wInter.GetChild ( "COD_MODE_REG", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* #2 - ShareData sur la DDDW des noms de domaine et adresse mail   */
/*------------------------------------------------------------------*/
uf_decompo_adr_mail()

idw_wInter.iudwDetailSource.GetChild ( "ADR_MAIL_DOMAIN", dwChild )
idw_wInter.GetChild ( "ADR_MAIL_DOMAIN", dwChild1 )
dwChild.ShareData ( dwChild1 )

// JCA - en test - résidu de code lors du développement ...

//idw_wInter.iudwDetailSource.GetChild ( "ADR_MAIL_NAME", dwChild )
//idw_wInter.GetChild ( "ADR_MAIL_NAME", dwChild1 )
//dwChild.ShareData ( dwChild1 )
//
//idw_wInter.iudwDetailSource.GetChild ( "ADR_MAIL", dwChild )
//idw_wInter.GetChild ( "ADR_MAIL", dwChild1 )
//dwChild.ShareData ( dwChild1 )

// JCA - en test - FIN

/*------------------------------------------------------------------*/
/* On initialise la DDDW sur ID_COURJ à vide. Le retrieve sera      */
/* effectué sur la fonction Uf_ChangerProduit ().                   */
/*------------------------------------------------------------------*/
idw_wInter.GetChild ( "ID_COURJ", dwChild )
dwChild.InsertRow ( 0 )

/*------------------------------------------------------------------*/
/* On s'occupe de la colonne ID_TYP_FRAIS pour la liste des frais.  */
/* La populisation de la colonne de W_FRAIS est faite dans          */
/* UF_Initialiser_Fenetre de Sinistre.                              */
/*------------------------------------------------------------------*/
idw_wFrais.GetChild ( "ID_TYP_FRAIS", dwChild )
idw_LstFrais.GetChild ( "ID_TYP_FRAIS", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* On s'occupe de la colonne COD_ETAT pour la liste des frais.      */
/*------------------------------------------------------------------*/
idw_wSin.GetChild ( "COD_ETAT", dwChild )
idw_LstFrais.GetChild ( "COD_ETAT", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* Partage pour les communes													  */
/*------------------------------------------------------------------*/
idw_wInter.GetChild ( "ADR_VILLE", dwChild )
idw_Commune.ShareData ( dwChild )


/*------------------------------------------------------------------*/
/* Initialisation de l'objet pour les courriers sous Word.          */
/*------------------------------------------------------------------*/
If Not ibSaisieValidation Then
	iUoCourrierWord.Uf_Init_Cp ( { "ALT_PCE", "ALT_PS", "ALT_PART" }, idw_wInter )
End If

/*------------------------------------------------------------------*/
/* On s'occupe des colonnes qui peuvent changer de couleur, en      */
/* fonction de la saisie.                                           */
/*------------------------------------------------------------------*/
sCol [  1 ] = "COD_INTER"
sCol [  2 ] = "COD_CIV"
sCol [  3 ] = "NOM"
sCol [  4 ] = "ADR_1"
sCol [  5 ] = "ADR_2"
sCol [  6 ] = "ADR_CP"
sCol [  7 ] = "ADR_VILLE"
sCol [  8 ] = "NUM_TELD"
sCol [  9 ] = "NUM_TELB"
sCol [ 10 ] = "NUM_FAX"
sCol [ 11 ] = "ADR_ATT"
sCol [ 12 ] = "V_REF1"
sCol [ 13 ] = "V_REF2"
sCol [ 14 ] = "COD_MODE_REG"
sCol [ 15 ] = "RIB_BQ"
sCol [ 16 ] = "RIB_GUI"
sCol [ 17 ] = "RIB_CPT"
sCol [ 18 ] = "RIB_CLE"
sCol [ 19 ] = "ID_NAT_COUR"
sCol [ 20 ] = "ALT_COURGEST"
sCol [ 21 ] = "ORDRE_CHEQUE"

// #2
sCol [ 22 ] = "ADR_MAIL_NAME"
sCol [ 23 ] = "ADR_MAIL_DOMAIN"
sCol [ 24 ] = "NUM_PORT_SMS"
sCol [ 25 ] = "DTE_NAISS"   // [PMO89_RS4822] 
sCol [ 26 ] = "VILLE_NAISS"   // [PMO89_RS4822] 
sCol [ 27 ] = "PAYS_NAISS"   // [PMO89_RS4822] 

idw_wInter.Uf_InitialiserCouleur ( sCol )

/*------------------------------------------------------------------*/
/* Si on est en Consultation/Validation, on va initialiser les      */
/* zones en protect une seule fois.                                 */
/*------------------------------------------------------------------*/
If	isTypeTrt = "C" Or isTypeTrt = "V" Then
	Uf_Tb_Validation ()
End If

ibAltCommune = astPassDga.bTab[1]  // DCMP 030362 Gestion Communes O/N
end subroutine

private subroutine uf_controlersaisie_commune (ref string astext, ref string aspos);//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_interlocuteur::uf_ControlerSaisie_Commune (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 25/08/2003 16:34:05
//* Libellé       : DCMP 030362 Contrôle des communes.
//* Commentaires  : 
//*
//* Arguments     : 	String		réf		asText
//*						String		réf		asPos
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF	  08/10/2003  Le fichier INSEE.TXT ne contient que les 25 premiers 
//*								  caractères de la ville.
//* #2	 JFF	  27/01/2004  DCMP 030581 : On prévoit un shunt pour le contrôle des communes.
//*-----------------------------------------------------------------

Integer		iCode
Long 			lTotRow, lCpt, lDeb, lFin
String 		sVille, sCP, sCodInter, sDept
Boolean		bCommuneTrouve, bCodePostalTrouve

If asPos <> "" Or Not ibAltCommune Then Return

/*------------------------------------------------------------------*/
/* #2 : OPTION 16 : Si Option, on déconnecte tout le contrôle des   */
/* communes                                                         */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 16 )
If lDeb > 0 Then Return

sCP	  	 = Upper ( Trim ( idw_wInter.GetItemString ( 1, "ADR_CP" )	) ) 
sCodInter = idw_wInter.GetItemString ( 1, "COD_INTER" )

/*------------------------------------------------------------------*/
/* Si ce n'est pas un pays étranger, ni une banque on traite le cas */
/*------------------------------------------------------------------*/
If sCP <> "00000" And sCodInter <> "B" Then
	sVille  = Upper ( Trim ( idw_wInter.GetItemString ( 1, "ADR_VILLE" )	 ) )
	
	/*------------------------------------------------------------------*/
	/* On épure la chaine de façon à ne garder que la ville.            */
	/*------------------------------------------------------------------*/
	This.uf_Epuration_ZoneCommune ( sVille, iCode )

	/*------------------------------------------------------------------*/
	/* #1                                                               */
	/*------------------------------------------------------------------*/
	sVille = Left ( sVille, 25 )

	idw_Commune.SetFilter ( "UPPER ( LEFT ( COMMUNE, 25 ) ) = '" + Upper ( sVille ) + "'" )
	idw_Commune.Filter ( )

	lTotRow = idw_Commune.RowCount ()
	bCommuneTrouve = lTotRow > 0
	bCodePostalTrouve = False

	/*------------------------------------------------------------------*/
	/* Traitement des cas particulier : Méthode LUC                     */
	/* LR 2.2 Si présence du terme CEDEX ou BP, le contrôle de          */
	/* croisement Commune-CodePostal est limité au département (les     */
	/* deux premiers chiffres du code postal), sinon SIMPA2 contrôle    */
	/* la cohérence complète CodePostal-Commune                         */
	/*                                                                  */
	/*------------------------------------------------------------------*/
	Choose Case iCode
		// Il y a la présence d'un CEDEX, BP ou autre, donc controle uniquement sur le Dept.
		Case 1
			sDept = Left ( sCP, 2 ) 

		// Sinon contrôle sur le CP entièrement.
		Case Else
			sDept = sCP

	End Choose

	For lCpt = 1 To lTotRow
		If sDept = Left ( idw_Commune.GetItemString ( lCpt, "CP" ), Len ( sDept ) ) And Not bCodePostalTrouve Then
			bCodePostalTrouve = True
			Exit
		End If
	Next

	/*------------------------------------------------------------------*/
	/* La commune n'existe pas                                          */
	/*------------------------------------------------------------------*/
	If Not bCommuneTrouve Then
			stMessage.sTitre		= "Contrôle de saisie d'un interlocuteur (Communes)"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= TRUE
			stMessage.sCode		= "COMM03"
			f_Message ( stMessage )
			asPos = "ADR_VILLE"
	End If


	/*------------------------------------------------------------------*/
	/* La commune existe mais pas le CP                                 */
	/*------------------------------------------------------------------*/
	If bCommuneTrouve And Not bCodePostalTrouve Then

		stMessage.sTitre		= "Contrôle de saisie d'un interlocuteur (Communes)"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "COMM02"
		f_Message ( stMessage )
		asPos = "ADR_CP"

	End If

	idw_Commune.SetFilter ( "" )
	idw_Commune.Filter ( )

End If	

If asPos <> "" Then
	asText = asText + " - Un binôme Commune/CodePostal valide" + "~n~r"
End If

end subroutine

private subroutine uf_epuration_zonecommune (ref string asville, ref integer aicode);//*-----------------------------------------------------------------
//*
//* Fonction      : uf_gs_sp_sinistre::uf_Epuration_ZoneCommune ( PRIVATE )
//* Auteur        : Fabry JF
//* Date          : 12/09/2003 10:48:04
//* Libellé       : Supprime tout ce qui est gênant dans la chaine de 
//*					  la ville afin de ne garder que la ville.
//* Commentaires  : 
//*
//* Arguments     : String 	asVille 		aRef
//*					  Integer	aiCode		aRef	 1 : Présence d'un CEDEX, BP, etc 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//* #1	FPI	18/03/2010	[Bug.Incident.9415] Correction si ville ne contient que des caractères à supprimer
//*-----------------------------------------------------------------
String sVille, sCar, sMot, sMotSubst
String sTbMotCle []   // Mots Clé à ne pas tenir Compte
Integer iTotMotCle, iCpt, iPos
Boolean bCarTrouve

sTbMotCle = { " BP", "CEDEX", "CÉDEX", "CEDÉX", "CÉDÉX" }
sVille = Upper ( asVille )
aiCode = 0

/*------------------------------------------------------------------*/
/* 1 : Suppression des mots clés                                    */
/*------------------------------------------------------------------*/
iTotMotCle = UpperBound ( sTbMotCle )
For iCpt = 1 To iTotMotCle
	iPos = 1
	Do While iPos > 0 
		iPos = Pos ( sVille, sTbMotCle [iCpt], 1 )
		If iPos > 0 Then
			sVille = Replace ( sVille , iPos, Len ( sTbMotCle [iCpt]), "" ) 
			aiCode = 1
		End If
	Loop
Next

/*------------------------------------------------------------------*/
/* 2 : Par la gauche, suppression de tout caractère non compris     */
/* entre 65 et 90 (ASCII).                                          */
/*------------------------------------------------------------------*/
bCarTrouve = TRUE
//Do While bCarTrouve 
Do While bCarTrouve and Len(sVille) > 0	// #1 - [Bug.Incident.9415] 
	sCar = Left ( sVille, 1 )

	Choose Case asc ( sCar ) 
		Case 65 To 90
			bCarTrouve = False

		Case Else
			bCarTrouve = TRUE
				sVille = Right ( sVille, Len ( sVille ) - 1 )
	End Choose 
Loop

/*------------------------------------------------------------------*/
/* 3 : Par la Droite, suppression de tout caractère non compris     */
/* entre 65 et 90 (ASCII).                                          */
/*------------------------------------------------------------------*/
bCarTrouve = TRUE
//Do While bCarTrouve 
Do While bCarTrouve and Len(sVille) > 0	// #1 - [Bug.Incident.9415] 
	sCar = Right ( sVille, 1 )
	Choose Case asc ( sCar ) 
		Case 65 To 90
			bCarTrouve = False

		Case Else
			bCarTrouve = TRUE
				sVille = Left ( sVille, Len ( sVille ) - 1 )

	End Choose 
Loop


/*------------------------------------------------------------------*/
/* 4 : Si _SAINT_ Ou _SAINTE_ trouvé en début de chaine remplacer   */
/* par ST ou STE                                                    */

/*------------------------------------------------------------------*/
For iCpt = 1 To 4
	Choose Case iCpt
		Case 1
			sMot = " SAINT "
			sMotSubst = " ST "
		Case 2
			sMot = " SAINTE "
			sMotSubst = " STE "
		Case 3
			sMot = "SAINT "
			sMotSubst = "ST "
		Case 4
			sMot = "SAINTE "
			sMotSubst = "STE "
			
	End Choose

	iPos = Pos ( sVille, sMot, 1 )

	Choose Case iCpt
		Case 1, 2
			If iPos > 0 Then
				sVille = Replace ( sVille, iPos, Len ( sMot ), sMotSubst ) 
			End If

		Case 3, 4
			If iPos = 1 Then
				sVille = Replace ( sVille, iPos, Len ( sMot ), sMotSubst ) 
			End If
	End Choose 
Next

/*------------------------------------------------------------------*/
/* 5 : Si la ville est composée, il ne doit y avoir qu'un espace 	  */
/* entre les mots.																  */
/*------------------------------------------------------------------*/
iPos = 1 
Do While iPos > 0 
	iPos = Pos ( sVille, "  ", 1 )
	If iPos > 0 Then
		sVille = Replace ( sVille , iPos, 2, " " ) 
	End If
Loop


asVille = sVille


end subroutine

public subroutine uf_initialiser_objets (ref u_spb_ajout_courtyp auajout, ref u_spb_cp_2000 aucourrierword, ref commandbutton acbcommune, ref N_Cst_Saisie_Validation_Interlocuteur anvSaisieValInter);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser_Objets (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 22/01/1998 15:23:57
//* Libellé			: 
//* Commentaires	: Initialisation des objets de la fenêtre W_Td_Sp_Interlocuteur
//*
//* Arguments		: U_Spb_Ajout_CourTyp		auAjout				(Réf)	User Objet 
//*					  U_Spb_Cp						auCourrierWord		(Réf)	User Objet 
//*					  CommandButton				acbCommune			(Réf) 
//*					  N_Cst_Saisie_Validation_Interlocuteur	invSaisieValInter (Réf)  SVE DCMP040020
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

iUoAjout	= auAjout

/*------------------------------------------------------------------*/
/* On initialise les DW Source, Cible maintenant. On n'utilise pas  */
/* la fonction Uf_Initialiser () car elle affecte à nouveau le      */
/* itrTrans. Ce qui est inutile.                                    */
/*------------------------------------------------------------------*/
iuoAjout.dw_Source.DataObject 	= "d_Lst_Sin_W_Inter_Para_Affecte"
iuoAjout.dw_Cible.DataObject 		= "d_Lst_Sin_W_Inter_Para_Non_Affecte"
iuoAjout.dw_Recherche.DataObject	= idw_ParaProd.DataObject


/*------------------------------------------------------------------*/
/* On initialise l'objet pour les courriers sous WORD.              */
/*------------------------------------------------------------------*/
iuoCourrierWord						= auCourrierWord

invSaisieValInter = 	anvSaisieValInter

icbCommune = acbCommune


end subroutine

private function boolean uf_presencecp (integer aiidinter, string ascodinter);//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre::uf_PresenceCP (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 22/03/2004 11:20:04
//* Libellé       : Utilisé pour la méthode SVE (DCMP 040020)
//* Commentaires  : y a-t-il une CP présent sur le disque pour l'inter
//*
//* Arguments     : Int		aiIdInter		Val
//*					  String asCodInter		Val
//*
//* Retourne      : Boolean
//*
//*-----------------------------------------------------------------
//* MAJ		PAR      Date	     Modification
//* #1 		DGA      19/09/2006 Gestion d'un répertoire temporaire DCMP-060643
//*
//*-----------------------------------------------------------------

Long lCpt, lTotInter, lTotFichier, lIdInter, lTotwCour, lLig, lLigInter
String sRepTmp, sNomFic
Date dDateFic
Time tHeureFic
Boolean bAuMoinsUnCp

/*------------------------------------------------------------------*/
/* On vérifie s'il existe au moins un CP sur le disque.             */
/*------------------------------------------------------------------*/
/* On récupére tous les fichiers du type                            */
/* C:\WINNT\TEMP\XXXX*.*.                                           */
/*------------------------------------------------------------------*/
/* XXXX = Code de l'application sur 4 caractères obligatoires.      */
/* 99   = ID_INTER sur deux positions obligatoires (Ex:02,12).      */
/* 9    = COD_INTER.                                                */
/* ex : SIM200_A.DOC																  */
/*------------------------------------------------------------------*/
bAuMoinsUnCp	= FALSE
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sRepTmp			= stGLB.sWinDir + "\TEMP\"
sRepTmp			= stGLB.sRepTempo
sNomFic			= sRepTmp + stGLB.sCodAppli + String ( aiIdInter, "00") + "_" + Upper ( asCodInter ) + ".DOC"

//Migration PB8-WYNIWYG-03/2006 FM
//If	FileExists ( sNomFic ) Then
If	f_FileExists ( sNomFic ) Then
//Fin Migration PB8-WYNIWYG-03/2006 FM

	stGlb.uoWin.uf_GetLastWriteDateTime ( sNomFic, dDateFic, tHeureFic )
	bAuMoinsUnCp =	dDateFic <> 2000-01-01 Or Left ( String ( tHeureFic ), 5 ) <> "23:59"

End If

Return bAuMoinsUnCp


end function

private function long uf_zn_rib ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_Rib (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/01/1998 18:23:41
//* Libellé			: 
//* Commentaires	: Vérification du RIB de l'interlocuteur
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//		FPI	11/10/2013	[VDoc12394]
//	   JFF - 10/01/2018  [SHUNT_WS_SEPA]
//		JFF   31/10/2019	[VDOC28559]
//    JFF   14/03/2024  [DP344_MODIF]
//    JFF   26/03/2025  [20250326111126190] Modif contrôle IBAN avec dp/344
//*-----------------------------------------------------------------
Integer iAction, iIdCie, iRet, iErreur
String sRibBq, sRibGui, sRibCpt, sRibCle, sIdCie
n_cst_string lnvPFCString
Long lDeb, lFin, lIdCie, dcIdSin, dcIdRev, dcIdGti


iAction	= 2

Choose Case idw_wInter.isNomCol
Case "RIB_BQ"
	sRibBq	= String (  Dec ( idw_wInter.GetText () ), "00000" )
	idw_wInter.SetItem ( 1, "RIB_BQ", sRibBq )
	idw_wInter.SetItem ( 1, "RIB_CLE", stNul.str )

Case "RIB_GUI"
	sRibGui	= String ( Dec ( idw_wInter.GetText () ), "00000" )
	idw_wInter.SetItem ( 1, "RIB_GUI", sRibGui )
	idw_wInter.SetItem ( 1, "RIB_CLE", stNul.str )

Case "RIB_CPT"
	sRibCpt = Fill ( "0", 11 - Len ( idw_wInter.GetText () ) ) + idw_wInter.GetText ()
	idw_wInter.SetItem ( 1, "RIB_CPT", sRibCpt )
	idw_wInter.SetItem ( 1, "RIB_CLE", stNul.str )

Case "RIB_CLE"
	sRibBq	= idw_wInter.GetItemString ( 1, "RIB_BQ" )
	sRibGui	= idw_wInter.GetItemString ( 1, "RIB_GUI" )
	sRibCpt	= idw_wInter.GetItemString ( 1, "RIB_CPT" )

	sRibCle	= idw_wInter.GetText ()

	// [20250326111126190]
	This.uf_controle_dp344 ( iAction, iErreur ) 
	If iAction = 1 Then idw_wInter.iiErreur = iErreur

/*  Dans uf_controle_dp344 donc à supprimer plus tard [20250326111126190]
	// [VDOC28559]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 344 )
	If lDeb > 0 Then
		sIdCie = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "ID_CIE", ";")
		dcIdSin = idw_wSin.GetItemNumber ( 1, "ID_SIN" ) 
		dcIdRev = idw_wSin.GetItemNumber ( 1, "ID_REV" ) 
		SetNull ( dcIdGti )
		SQLCA.PS_S_ID_CIE ( dcIdSin, dcIdRev, dcIdGti, lIdCie )

		If Upper ( SQLCA.DataBase ) <> "SIMPA2_PRO" Then
			
			stMessage.sTitre		= "MESSAGE DE RECETTE UNIQUEMENT"
			stMessage.Icon			= Question!
			stMessage.Bouton		= YesNo!
			stMessage.bErreurG	= False
			stMessage.sCode		= "WINT310"
	
			iRet = F_Message ( stMessage )
		Else 
			iRet = 1 
		End IF 

		// [PMO268_MIG25]
		// [DP344_MODIF]
		If F_CLE_A_TRUE ( "DP344_MODIF" ) Then
			If iRet = 1 And ( sIdCie = "" Or Pos ( sIdCie, "#" + String ( lIdCie ) + "#" ) > 0 Or IsNull ( lIdCie ) Or lIdCie = 0 ) Then
				iAction	= 1
				idw_wInter.iiErreur = 3	
				
				If sIdCie = "" Then
					idw_wInter.iiErreur = 4
				End If 
			End If 
		Else		
			If iRet = 1 And Pos ( sIdCie, "#" + String ( lIdCie ) + "#" ) > 0 Or IsNull ( lIdCie ) Or lIdCie = 0 Then
				iAction	= 1
				idw_wInter.iiErreur = 3	
			End If 
		End If		
	End If 
*/	
	
	If	iAction = 2 And Not IsNull ( sRibBq + sRibGui + sRibCpt + sRibCle ) Then
		If	Not F_Rib ( sRibBq, sRibGui, sRibCpt, sRibCle ) Then
			iAction			= 1
			idw_wInter.iiErreur = 1
		End If
		
		// [VDoc12394]
		If iAction=2 Then
			if not uf_controler_sepa( sRibBq, sRibGui) Then
				iAction			= 1
				idw_wInter.iiErreur = 2
			End if
		End if
		// :[VDoc12394]
	
	End If



	If iAction <> 1 Then
		idw_wInter.SetItem ( 1, "RIB_CLE", sRibCle )
	End If

End Choose

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wInter.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_altquest ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_AltQuest (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/01/1998 18:23:41
//* Libellé			: 
//* Commentaires	: Vérification des zones ALT_QUEST, ALT_COURGEST.
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG 12/02/2003  DCMP 030078
//* #2  CAG 18/02/2003  Lors du positionnement d'un questionnaire s'il y
//*							avait déjà un paragraphe, après confirmation de
//*							la suppression de celui-ci, lors du ctrl valider
//*							du dossier, msg : pas de courrier, valid direct ...
//* #3  CAG 10/09/2003	DCMP 030390 : Si déclar par téléphone, Z017 au lieu
//*						   de Z014 suite DCMP 030078
//* #4  CAG 15/09/2003	correction DCMP 030390 : ce n'est pas la décl. du sin qu'il faut
//*								prendre en compte, mais le média du travail
//*								(cod_recu de w_queue au lieu de cod_decl de w_sin)
//*
//* [DCMP050251]	PHG	10/05/2006
//*	- Integration de la gestion de 4 enveloppes supplémentaire
//*-----------------------------------------------------------------
//       JFF   12/06/2014 [PI052]
//		FPI	15/06/2015 [BLOC_COUR_FRN]
//*-----------------------------------------------------------------

String	sAltQuest, sAltCourGest, sIdNatCour, sAltPart, sVal
Long		lRowZSource, lRowZCible, lDeb, lFin, lRowZSource1, lRowZCible1
String	sListEnvZ // DCMP050251
Boolean  bPI052_GenEdtKsl 
n_cst_string lnvPFCString

Integer iAction

iAction	= 2

sListEnvZ = uf_BuildStringList(isListEnvZ0) 	// DCMP050251 On construit l'eventuelle 
															// liste d'enveloppe a tester
bPI052_GenEdtKsl = False

// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 262 )
	If lDeb > 0 Then
		
		sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "PHASE_RECETTE", ";")
		
		If Len ( Trim ( sVal ) ) = 0 Then
			bPI052_GenEdtKsl = TRUE
		End If
		
		If Len ( Trim ( sVal ) ) > 0 Then
			If Pos ( sVal, "#" + stGlb.sCodOper + "#" ) > 0 Then
				bPI052_GenEdtKsl = TRUE
			End If
		End If
		
	End If 
End If	
*/

Choose Case idw_wInter.isNomCol
Case "ALT_QUEST"
	sAltQuest		= idw_wInter.GetText ()
	sAltCourGest	= idw_wInter.GetItemString ( 1, "ALT_COURGEST" )

	// [PI052]
	/*
	If F_CLE_A_TRUE ( "PI052" ) Then
		If bPI052_GenEdtKsl And sAltQuest = "O" Then
			Return 1
		End If
	End If
	*/

/*------------------------------------------------------------------*/
/* Si le gestionnaire veut un questionnaire, il ne doit pas y       */
/* avoir de courrier particulier, ou de post-Scriptum ou de         */
/* paragraphe autre pièce.                                          */
/*------------------------------------------------------------------*/
	If sAltQuest = "O" And ( idw_wInter.GetItemString ( 1, "ALT_PART" )	= "O"	Or &
								  	 idw_wInter.GetItemString ( 1, "ALT_PS" ) 	= "O"	Or & 
									 idw_wInter.GetItemString ( 1, "ALT_PCE" ) 	= "O"	) Then

		stMessage.sTitre		= "Gestion des interlocuteurs - SIMPA2"
		stMessage.bErreurG	= False
		stMessage.Icon			= Information!
		stMessage.sCode		= "WINT150"
		stMessage.bouton		= Ok!

		If	idw_wInter.GetItemString ( 1, "ALT_PART" ) = "O"	Then
			stMessage.sVar[1] = "un COURRIER PARTICULIER"
			stMessage.sVar[2] = "un QUESTIONNAIRE"
		End If

		If	idw_wInter.GetItemString ( 1, "ALT_PS" ) = "O"	Then
			stMessage.sVar[1] = "un POST-SCRIPTUM"
			stMessage.sVar[2] = "un QUESTIONNAIRE"
		End If

		If	idw_wInter.GetItemString ( 1, "ALT_PCE" ) = "O"	Then
			stMessage.sVar[1] = "un paragraphe AUTRE PIECE"
			stMessage.sVar[2] = "un QUESTIONNAIRE"
		End If

		F_Message ( stMessage )

	/*------------------------------------------------------------------*/
	/* Si la personne veut un questionnaire, alors qu'il existe des     */
	/* paragraphes d'informations, on va les supprimer avec son accord. */
	/*------------------------------------------------------------------*/
	/* #1                                                               */
	/*------------------------------------------------------------------*/
	/* Affichage du message sans tenir compte du paragraphe Z014		  */
	/*------------------------------------------------------------------*/
	/* #3 CAG 10/09/2003                                                */
	/*------------------------------------------------------------------*/
	/* #4 CAG 15/09/2003 : remp de sCodDecl par isCodRecu               */
	/*------------------------------------------------------------------*/

/* Ancien CAG non valide (JFF le 06/05/04) 
	ElseIf	sAltQuest = "O" And iuoAjout.dw_Source.RowCount () > 0 &
				And ( iuoAjout.dw_Source.RowCount () = 1 And ( isCodRecu <> "T" And iuoAjout.dw_Source.Find ( "ID_PARA = 'Z014'", 1, iuoAjout.dw_Source.RowCount () ) = 0 &
																		  Or isCodRecu = "T" And iuoAjout.dw_Source.Find ( "ID_PARA = 'Z017'", 1, iuoAjout.dw_Source.RowCount () ) = 0 ) ) &
				Or iuoAjout.dw_Source.RowCount () > 1 Then
*/

/* Remplacé par nouveau Code JFF valide le 06/05/2004 */

/* [DCMP050251]-PHG-10/05/2006							   */
/* - Ajout de commentaire sur le script ci-dessous		*/
/* - Ajout de la gestion des enveloppes Z040-Z043		*/

	ElseIf	sAltQuest = "O" /* ALTQUEST  Coché */ &
		And iuoAjout.dw_Source.RowCount () > 0 /* ET Il y a au moins UNE ligne */ &
		And /* ET */ &
		 (  /* Il n'y a pas le cas ci-dessous */ & 
		  Not  ( iuoAjout.dw_Source.RowCount () = 1 /* Il n'y a qu'une seule ligne */ & 
			  And /* ET ( */&
			     (	/*  Media = autre ET Source contient l'enveloppe Z014 */&
			      ( isCodRecu <> "T" And iuoAjout.dw_Source.Find ( "ID_PARA = 'Z014'", 1, iuoAjout.dw_Source.RowCount () ) = 0 )&
			       Or /* OU Media = tel ET Source contient l'enveloppe Z017 */&
			      ( isCodRecu = "T" And iuoAjout.dw_Source.Find ( "ID_PARA = 'Z017'", 1, iuoAjout.dw_Source.RowCount () ) = 0 )&
					 Or /* [DCMP050251] - OU source contient les enveloppes Z040--Z043 */ & 
					( iuoAjout.dw_Source.Find ( "ID_PARA IN ("+sListEnvZ+")", 1, iuoAjout.dw_Source.RowCount () ) = 0 )&
			     ) &
		       ) &
		  Or  /* OU ( */ & 
		  iuoAjout.dw_Source.RowCount () > 1 /* Plusieurs Para dispo */ &
		 ) &
		  Then

		stMessage.sTitre		= "Gestion des interlocuteurs - SIMPA2"
		stMessage.bErreurG	= False
		stMessage.Icon			= Question!
		stMessage.sCode		= "WINT100"
		stMessage.bouton		= YesNo!
		
		If	F_Message ( stMessage ) = 1 Then	
			/*------------------------------------------------------------------*/
			/* On supprime tous les paragraphes positionnés précédemment.       */
			/*------------------------------------------------------------------*/
			Uf_GestionuAjout ( 3 )
			idw_wInter.SetItem ( 1, "ALT_QUEST", "O" )

			sIdNatCour	= "Q" + String ( idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "00000" )
			idw_wInter.SetItem ( 1, "ID_NAT_COUR", sIdNatCour )
			idw_wInter.SetItem ( 1, "ID_COUR", sIdNatCour )

			Uf_Gestion_Onglet ( 3 )
		End If
		
	Else

		If	sAltCourGest = "R" And sAltQuest = "O" Then
			iAction = 1
		Else
			If	sAltQuest = "O" Then
/*------------------------------------------------------------------*/
/* Selon St DENIS, dans le cas d'un questionnaire, on peut          */
/* positionner ID_COUR avec ID_NAT_COUR.                            */
/*------------------------------------------------------------------*/
				sIdNatCour	= "Q" + String ( idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "00000" )

				Uf_Gestion_Onglet ( 3 )
			Else
				sIdNatCour	= stNul.str

				Uf_Gestion_Onglet ( 1 )
			End If
			idw_wInter.SetItem ( 1, "ID_NAT_COUR", sIdNatCour )
			idw_wInter.SetItem ( 1, "ID_COUR", sIdNatCour )
			idw_wInter.SetItem ( 1, "ALT_QUEST", sAltQuest )

		End If
	End If

	/*------------------------------------------------------------------*/
	/* #1                                                               */
	/*------------------------------------------------------------------*/
	/* Insertion automatique de l'enveloppe si elle n'y est pas		     */
	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/
	/* #3 CAG 10/09/2003                                                */
	/*------------------------------------------------------------------*/
	/* #4 CAG 15/09/2003 : remp de sCodDecl par isCodRecu               */
	/*------------------------------------------------------------------*/
	/* [DCMP050251]-PHG-10/05/2006							   				  */
	/*	- On teste sur TOUTE les enveloppes Z014,Z017,Z040--Z041   		  */
	/*	  independament du media utilisé.										  */
	/*	  Ensuite, on s'occupe de savoir si c'est Z014 ou Z017			  */
	/*   qu'il faut inserer au cas ou.											  */
	/*------------------------------------------------------------------*/

	lRowZSource = iuoAjout.dw_Source.Find ( "ID_PARA IN ("+sListEnvZ+",'Z014','Z017')", 1, iuoAjout.dw_Source.RowCount () )

	If lRowZsource = 0 then // Si pas d'enveloppe deja insérée
		// On regarde les enveloppes dispo
		lRowZCible = iuoAjout.dw_Cible.Find ( "ID_PARA IN ("+sListEnvZ+",'Z014','Z017')", 1, iuoAjout.dw_Cible.RowCount () )
		If lRowZCible > 0 then // si on a des enveloppes, on l'inserera, mais le cas des Z014/17 doit etre traité
			Choose case trim(iuoAjout.dw_Cible.object.id_para[lRowZCible]) // Selon l'enveloppe
				Case 'Z014', 'Z017' // On a trouvé Z014 ou Z017
					If isCodRecu <> "T" Then // Media <> telephone ? => On tente d'inserer l'Enveloppe Z014
						lRowZCible = iuoAjout.dw_Cible.Find ( "ID_PARA = 'Z014'", 1, iuoAjout.dw_Cible.RowCount () )
					Else // Sinon => On tente d'inserer l'Enveloppe Z017
						lRowZCible = iuoAjout.dw_Cible.Find ( "ID_PARA = 'Z017'", 1, iuoAjout.dw_Cible.RowCount () )
					End If
			End Choose
		End If
	End If
	
	if lRowZCible > 0 then // On Insere l'nveloppe selectionnée SI on a le droit ( Option 2 sur le produit )
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 2 )
		if lDeb > 0 then
			iuoAjout.dw_Cible.SetRow ( lRowZCible )
			iuoAjout.pb_ajouter_1.TriggerEvent ( CLICKED! )
		End If
	End If
	
	// [DCMP050251] Ancien code, remplacé par ci-dessus
//	lRowZSource = iuoAjout.dw_Source.Find ( "ID_PARA = 'Z014'", 1, iuoAjout.dw_Source.RowCount () )
//	lRowZSource1 = iuoAjout.dw_Source.Find ( "ID_PARA = 'Z017'", 1, iuoAjout.dw_Source.RowCount () )
//	If ( isCodRecu <> "T" And lRowZSource = 0 ) Or ( isCodRecu = "T" And lRowZSource1 = 0 ) Then
//		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 2 )
//		lRowZCible = iuoAjout.dw_Cible.Find ( "ID_PARA = 'Z014'", 1, iuoAjout.dw_Cible.RowCount () )
//		lRowZCible1 = iuoAjout.dw_Cible.Find ( "ID_PARA = 'Z017'", 1, iuoAjout.dw_Cible.RowCount () )
//		If ( isCodRecu <> "T" And lRowZCible > 0 And lDeb > 0 ) Or ( isCodRecu = "T" And lRowZCible1 > 0 And lDeb > 0 )  Then
//			If isCodRecu = "T" Then
//				iuoAjout.dw_Cible.SetRow ( lRowZCible1 )
//			Else
//				iuoAjout.dw_Cible.SetRow ( lRowZCible )
//			End If
//			iuoAjout.pb_ajouter_1.TriggerEvent ( CLICKED! )
//		End If
//	End If

Case "ALT_COURGEST"

	sAltQuest		= idw_wInter.GetItemString ( 1, "ALT_QUEST" )
	sAltCourGest	= idw_wInter.GetText ()
	sAltPart			= idw_wInter.GetItemString ( 1, "ALT_PART" )

	// [BLOC_COUR_FRN]
	If sAltCourGest <> "N" and idw_wInter.GetItemString(1, "COD_INTER") = "F" Then
		iAction=1	
		idw_wInter.iiErreur=2
	End if
	// :[BLOC_COUR_FRN]
	
	If iAction=2 Then // [BLOC_COUR_FRN]
		If	sAltCourGest = "R" And ( sAltQuest = "O" Or sAltPart = "O" )Then
			iAction = 1
			idw_wInter.iiErreur=1
		Else
			idw_wInter.SetItem ( 1, "ID_COURJ", stNul.str )
			idw_wInter.SetItem ( 1, "ID_I_DB", stNul.iNum )
			idw_wInter.SetItem ( 1, "ALT_COURGEST", sAltCourGest )
		End If
	End if
	
End Choose

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wInter.SetActionCode ( iAction )
Uf_Tb_Questionnaire ()
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_ordrecheque ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_OrdreCheque (PRIVATE)
//* Auteur			: PLJ
//* Date				: 12/05/2004
//* Libellé			: 
//* Commentaires	: Suppression des blancs devant l'ordre pour traitement sage
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------

Integer 	iAction
String	sOrdreCheque

iAction	= 0

sOrdreCheque	= idw_wInter.GetText ()

If Not isNUll ( sOrdreCheque ) Then
	If Left ( sOrdreCheque, 1 ) = ' ' Then
		sOrdreCheque = LeftTrim (sOrdreCheque) 
		idw_wInter.SetItem ( 1, "ORDRE_CHEQUE", sOrdreCheque )
		iAction = 2
	End If
End If

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wInter.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_codmodreg ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_CodModReg (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 12/05/2004
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*-----------------------------------------------------------------
//* #1  JFF  21/05/2008 [3SUISSE].COD_MODE_REG
//      JFF  23/05/2012 [PM103][1]
//      JFF  07/08/2019 [PM462-1][V3]
//*-----------------------------------------------------------------

Integer 	iAction
String	sCodModReg

// #1 [3SUISSE].COD_MODE_REG 
Long lDeb, lFin, lCpt
n_cst_string lnvPFCString
String sCodInterAutorise, sCodInter
Boolean bAutorise

bAutorise = FALSE
sCodInter = idw_wInter.GetItemString ( 1, "COD_INTER" )
// :#1 [3SUISSE].COD_MODE_REG 

iAction	= 0
sCodModReg = idw_wInter.GetText ()

// #1 [3SUISSE].COD_MODE_REG 
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 100 )
For lCpt = lDeb To lFin
	If Trim ( Upper ( idw_DetPro.GetItemString ( lCpt, "ID_CODE_CAR" ) ) ) = Trim ( Upper ( sCodModReg ) ) Then
		sCodInterAutorise = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lCpt, "VAL_CAR" ), "COD_INTER", ";")
		bAutorise = sCodInter = sCodInterAutorise 
		If bAutorise Then Exit
	End If
Next

// [PM462-1][V3]
/*
If F_CLE_A_TRUE ( "PM462-1" ) Then
	// Même si le Param l'autorise, J'interdit en dur le mode CB.
	If sCodModReg = "CB" Then 
		bAutorise = False
	End If 
End If
*/

If Not bAutorise Then 
	iAction = 1
	idw_wInter.iiErreur = 1
End If

// [PM103][1]
If gbModeReprise_223 And iAction = 0 Then
	iAction = 1
	idw_wInter.iiErreur = 2
End If
// :[PM103][1]

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wInter.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

public subroutine uf_initialiser_dw_desc (ref u_datawindow_detail adw_lstfrais, ref u_datawindow adw_winter, ref datawindow adw_norm[]);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser_Dw_Desc (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libellé			: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow_Detail	adw_LstFrais		(Réf)	DataWindow sur les Frais (Liste)
//*					  U_DataWindow				adw_wInter			(Réf)	DataWindow sur les interlocuteurs
//*					  DataWindow				adw_Norm[8]			(Réf)	Tableau de DataWindow 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* DataWindow sur les Frais.        Liste => U_DataWindow_Detail.   */
/*------------------------------------------------------------------*/
idw_LstFrais	= adw_LstFrais

/*------------------------------------------------------------------*/
/* DataWindow sur les INTERLOCUTEURS. Master	=> U_DataWindow.       */
/*------------------------------------------------------------------*/
idw_wInter	= adw_wInter

/*------------------------------------------------------------------*/
/* On va utiliser un tableau de DW pour armer les instances du      */
/* NVUO, il faut les charger dans le bon ordre.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* DataWindow sur la table PARA_PROD                                */
/*------------------------------------------------------------------*/
idw_ParaProd= adw_Norm[1]

/*------------------------------------------------------------------*/
/* DataWindow sur la table W_PARA_INFO                              */
/*------------------------------------------------------------------*/
idw_wParaInfo	= adw_Norm[2]

/*------------------------------------------------------------------*/
/* DataWindow sur la table W_PIECE                                  */
/*------------------------------------------------------------------*/
idw_wPiece	= adw_Norm[3]

/*------------------------------------------------------------------*/
/* DataWindow sur la table W_REFUS                                  */
/*------------------------------------------------------------------*/
idw_wRefus	= adw_Norm[4]

/*------------------------------------------------------------------*/
/* DataWindow sur la table W_FRAIS                                  */
/*------------------------------------------------------------------*/
idw_wFrais	= adw_Norm[5]

/*------------------------------------------------------------------*/
/* DataWindow external permettant de garder les frais supprimés     */
/*------------------------------------------------------------------*/
idw_wFraisSupp	= adw_Norm[6]

/*------------------------------------------------------------------*/
/* DataWindow sur la table W_DETAIL                                 */
/*------------------------------------------------------------------*/
idw_wDetail	= adw_Norm[7]

/*------------------------------------------------------------------*/
/* DataWindow sur les communes												  */
/*------------------------------------------------------------------*/
idw_Commune	= adw_Norm[8]

idw_wdivsin = adw_Norm[11] // [VDoc12394]
end subroutine

public function long uf_zn_trt (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_Trt (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:27:01
//* Libellé			: 
//* Commentaires	: Traitement sur les zones de dw_wInter
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1  PLJ  12/05/2004  Suppression des blancs devant ordre_cheque pour traitement sage
//* #2  JFF  18/05/2005  contrôle sur COD_MODE_REG
//* [MIGPB8COR] Changement du code retour pour prise en compte returncode
//* #3  PHG	 15/11/2006  [DNTMAIL1-2] Blocage pour modifier AltSuiviMail
//*							 si un courrier PArticulier Existe
//*    JFF   18/08/2020 [PM497-1]
//     JFF  26/04/2023 [RS5045_REF_MATP]
//*-----------------------------------------------------------------

long ll_ret = 0 // [MIGPB8COR] PHG

Choose Case idw_wInter.isNomCol
	Case "COD_INTER"
		Uf_Zn_CodInter ()

	Case "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE"
		ll_ret = Uf_Zn_Rib () // [MIGPB8COR] PHG

	Case "ALT_QUEST"
		ll_ret = Uf_Zn_AltQuest () // [MIGPB8COR] PHG

	Case "ID_NAT_COUR"
		ll_ret= Uf_Zn_IdNatCour () 
		
	Case "ORDRE_CHEQUE"			// #1
		ll_ret = uf_zn_OrdreCheque() // [MIGPB8COR] PHG

	Case "COD_MODE_REG"			
		ll_ret = Uf_Zn_CodModReg() // [MIGPB8COR] PHG
	
	Case "ALT_SUIVI_MAIL"
		ll_ret = Uf_Zn_AltSuiviMail() // #3 [DNTMAIL1-2]
		
	Case "COD_CIV"
		ll_ret = Uf_Zn_CodCiv() // [PM452-1]		
		
	Case "ALT_COURGEST"
		// [PM497-1]
		ll_ret = Uf_Zn_AltQuest () // [MIGPB8COR] PHG		
		ll_ret = Uf_Zn_AltCourGest ( "" ) // [PM497-1]					

	// [RS5045_REF_MATP]
	Case "ADR_MAIL_NAME"
		ll_ret = uf_zn_adr_mail_name ()
	
	// [RS5045_REF_MATP]
	Case "ADR_MAIL_DOMAIN"
		ll_ret = uf_zn_adr_mail_domain ()		
		
End Choose

return ll_ret // [MIGPB8COR] PHG

end function

protected function string uf_buildstringlist (string asstringarray[]);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_BuildStringList (PRIVATE)
//* Auteur			: PHG
//* Date				: 23/01/1998 17:40:41
//* Libellé			: Construit une liste de chaine de type
//*					: 'chaine1','chaine2','chaine3'
//*					: a partir d'un tableau de chaine.
//* Commentaires	: 
//*
//* Arguments		: asStringArray[], comme son nom l'indique, tableau de chaine d
//*
//* Retourne		: une chaine construite, vide si tableau vide
//*
//*-----------------------------------------------------------------
string sSearchString
long lCpt, lUBArray

sSearchString=""

lUBarray = upperbound(asstringarray)
For lCpt = 1 to lUBArray
	sSearchString += "'"+asstringarray[lCpt]+"'"
	if lCpt <> lUBArray then sSearchString += ","
Next 


return sSearchString
end function

public function long uf_decompo_adr_mail ();//*-----------------------------------------------------------------
//*
//* Fonction      : uf_gs_sp_sinistre::uf_decompo_adr_mail ( PUBLIC )
//* Auteur        : JCA
//* Date          : 29/05/2006
//* Commentaires  : Decompose le champ en base adr_mail en adr_mail_name et adr_mail_domain
//* Arguments     : Aucun
//* Retourne      : long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    10/01/2007  On ne lance le trt que si l'inter "1" existe !
//			FPI	28/07/2011	[VDoc4913] Correction
//*-----------------------------------------------------------------

long iRet, lCpt, lTot
boolean bArobase
string sAdrMail
string sAdrMailDecompo[]

//iRet=0 Ok, iRet=-1 Nok
iRet=0

If idw_winter.iudwdetailsource.Rowcount() > 0 then  // #1
	sAdrMail = idw_winter.iudwdetailsource.GetItemString(1, "ADR_MAIL")
	bArobase = match(sAdrMail, "@")
	
	if bArobase then
		if not (isnull(sAdrMail) or sAdrMail="@") then
			f_decomposerchaine(sAdrMail, "@", sAdrMailDecompo[])
		
			idw_winter.iudwdetailsource.SetItem(1, "ADR_MAIL_NAME", sAdrMailDecompo[1])
			
			If UpperBound(sAdrMailDecompo) > 1 Then		//	[VDoc4913]
				idw_winter.iudwdetailsource.SetItem(1, "ADR_MAIL_DOMAIN", sAdrMailDecompo[2])
			End if
		else
			idw_winter.iudwdetailsource.SetItem(1, "ALT_SUIVI_MAIL", "N")
		end if
	else
		idw_winter.iudwdetailsource.SetItem(1, "ALT_SUIVI_MAIL", "N")
	end if
End If // #1

return iRet

end function

private subroutine uf_tb_validation ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Tb_Adhesion (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 17:35:30
//* Libellé			: 
//* Commentaires	: Gestion des TabOrder en Consultaion/Validation.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG	05/08/2003  Ajout de la zone Ordre_cheque
//* #2  JCA	29/05/2006  Ajout des zones adr_mail_name, adr_mail_domain et alt_suivi_mail
//      JFF 30/07/2014  [PM234-4_V1]
//      JFF   30/05/2023 [PMO89_RS4822]
// 
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Cette fonction concerne les zones suivantes :                    */
/* COD_INTER, COD_CIV, NOM, ADR_1, ADR_2, ADR_CP, ADR_VILLE,        */
/* NUM_TELD, NUM_TELB, NUM_FAX.                                     */
/* NUM_TELD, NUM_TELB, NUM_FAX, ADR_ATT, V_REF1, V_REF2,            */
/* COD_MODE_REG, RIB_BQ, RIB_GUI, RIB_CPT, RIB_CLE, ID_NAT_COUR,    */
/* ALT_COURGEST, ID_I_DB, ID_COURJ, ALT_QUEST.                      */
/*------------------------------------------------------------------*/

// #2
String sCol[32]

/*------------------------------------------------------------------*/
/* Cette fonction concerne toutes les zones.                        */
/*------------------------------------------------------------------*/
sCol [  1 ] = "COD_INTER"
sCol [  2 ] = "COD_CIV"
sCol [  3 ] = "NOM"
sCol [  4 ] = "ADR_1"
sCol [  5 ] = "ADR_2"
sCol [  6 ] = "ADR_CP"
sCol [  7 ] = "ADR_VILLE"
sCol [  8 ] = "NUM_TELD"
sCol [  9 ] = "NUM_TELB"
sCol [ 10 ] = "NUM_FAX"
sCol [ 11 ] = "ADR_ATT"
sCol [ 12 ] = "V_REF1"
sCol [ 13 ] = "V_REF2"
sCol [ 14 ] = "COD_MODE_REG"
sCol [ 15 ] = "RIB_BQ"
sCol [ 16 ] = "RIB_GUI"
sCol [ 17 ] = "RIB_CPT"
sCol [ 18 ] = "RIB_CLE"
sCol [ 19 ] = "ID_NAT_COUR"
sCol [ 20 ] = "ALT_COURGEST"
sCol [ 21 ] = "ID_I_DB"
sCol [ 22 ] = "ID_COURJ"
sCol [ 23 ] = "ALT_QUEST"
sCol [ 24 ] = "ORDRE_CHEQUE"

// #2
sCol [ 25 ] = "ALT_SUIVI_MAIL"
sCol [ 26 ] = "ADR_MAIL_NAME"
sCol [ 27 ] = "ADR_MAIL_DOMAIN"
sCol [ 28 ] = "NUM_PORT_SMS"
sCol [ 29 ] = "ALT_SUIVI_SMS"
sCol [ 30 ] = "DTE_NAISS"  // [PMO89_RS4822]
sCol [ 31 ] = "VILLE_NAISS"  // [PMO89_RS4822]
sCol [ 32 ] = "PAYS_NAISS"  // [PMO89_RS4822]

idw_wInter.Uf_Proteger ( sCol, "1" )


/*------------------------------------------------------------------*/
/* Il faut récupérer les valeurs pour les types d'interlocuteurs.   */
/*------------------------------------------------------------------*/
idw_wInter.ClearValues ( "COD_INTER" )
idw_wInter.SetValue ( "COD_INTER", 1, "Autre ~tT" )
idw_wInter.SetValue ( "COD_INTER", 2, "Assuré ~tA" )
idw_wInter.SetValue ( "COD_INTER", 3, "Banque ~tB" )
idw_wInter.SetValue ( "COD_INTER", 4, "Fourn. ~tF" )

// [PM234-4_V1]
idw_wInter.SetValue ( "COD_INTER", 6, "Livraison. ~tL" )

/*------------------------------------------------------------------*/
/* On positionne la gestion des paragraphes en mode (C)onsultation. */
/*------------------------------------------------------------------*/
iuoAjout.Uf_Consulter ( True )

end subroutine

private function long uf_zn_altsuivimail ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_zn_AltSuiviMail (PRIVATE)
//* Auteur			: PHG
//* Date				: 15/11/2006
//* Libellé			: [DNTMAIL1-2]
//* Commentaires	: Blocage de AltSuviMail si un courrier existe
//*
//* Arguments		: Aucun
//*
//* Retourne		: long
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

Integer iAction
Boolean bPresenceCP
iAction	= 2

bPresenceCP = This.uf_PresenceCP ( idw_wInter.object.id_i[1], idw_wInter.object.cod_inter[1] )

If bPresenceCP then
	iAction = 2
	stMessage.sTitre		= "Contrôle de saisie d'un interlocuteur"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "WINT190"

	f_Message ( stMessage )
else
	iAction = 0
End If

Return iAction

end function

public function boolean uf_controler_sepa (string ascodebq, string ascodeag);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_controler_sepa (PRIVATE)
//* Auteur			: FPI
//* Date				: 11/10/2013	
//* Libellé			: [VDoc12394]
//* Commentaires	: 	
//*
//* Arguments		: Aucun
//*
//*-----------------------------------------------------------------
//	FPI - 01/03/2016 - [VDoc20041] changement de webservice
//*-----------------------------------------------------------------
Boolean bRet
Long lRet, lRowDS
n_cst_sp_ws_sepa_caller uoWsCaller
n_cst_sp_ws_spbsepa_caller uoWsSpbCaller  //  [VDoc20041]
String sVal, sValSepaOK
datawindowchild dwChild

bRet=TRUE

//  [VDoc20041]
// Appel du WebService
/* Défintivement shunté par JF le 22/01/2019
	// bRet = SQLCA.PS_S02_AGENCE ( asCodeBq, asCodeAg) > 0 

	uoWsSpbCaller=CREATE n_cst_sp_ws_spbsepa_caller
	If not isValid (isoapcnx) Then isoapcnx = CREATE soapconnection
	
	lRet=uoWsSpbCaller.createproxy(isoapcnx )
	
	if lRet<>-1 Then	
		bRet=uoWsSpbCaller.isbankcounterexist( asCodeBq, asCodeAg)
	End if
	
	destroy uoWsSpbCaller
*/

bRet = TRUE

// :[VDoc20041]

sValSepaOK=String(idw_winter.GetItemNumber(1,"ID_I")) + "#"

lRowDS = idw_wDivSin.Find ( "Upper ( NOM_ZONE ) = 'CTL_SEPA'", 1, idw_wDivSin.RowCount () ) 
	
if lRowDS <=0 Then
	If bRet Then
		// Ajout dans div_sin uniqt si OK
		if idw_wDivSin.RowCount()=0 Then
			idw_wDivSin.GetChild ( "VAL_LST_CAR", dwChild )
			dwChild.Retrieve("-AR")
			idw_wDivSin.GetChild ( "VAL_LST_NBRE", dwChild )
			dwChild.Retrieve("-MB")
		End if
		
		lRowDS = idw_wDivSin.InsertRow (0)
	
		idw_wDivSin.SetItem ( lRowDS, "ID_SIN", idw_wSin.GetItemNumber ( 1, "ID_SIN" ) )
		idw_wDivSin.SetItem ( lRowDS, "NOM_ZONE", "ctl_sepa" )
		idw_wDivSin.SetItem ( lRowDS, "LIB_LABEL", "Contrôle Banque/Agence SEPA" )
		idw_wDivSin.SetItem ( lRowDS, "ID_TYP_LISTE", "-XX" )
		idw_wDivSin.SetItem ( lRowDS, "ALT_LISTE_CODECAR", "N" )
		idw_wDivSin.SetItem ( lRowDS, "ID_TYP_ZONE", "C" )
		idw_wDivSin.SetItem ( lRowDS, "ALT_OBLIG", "N" )
		idw_wDivSin.SetItem ( lRowDS, "ALT_PROT", "O" )
		idw_wDivSin.SetItem ( lRowDS, "CPT_TRI", 1000 )
		idw_wDivSin.SetItem ( lRowDS, "VAL_DTE", stNul.dtm )	// [PI056].20190926
		idw_wDivSin.SetItem ( lRowDS, "VAL_CAR","#" +  sValSepaOK)
		idw_wDivSin.SetItem ( lRowDS, "VAL_NBRE", stNul.lng)
		idw_wDivSin.SetItem ( lRowDS, "VAL_MT", stNul.dcm )
		idw_wDivSin.SetItem ( lRowDS, "ALT_SUPP", "N" )
		idw_wDivSin.SetItem ( lRowDS, "CREE_LE", DateTime ( Today (), Now () ) )
		idw_wDivSin.SetItem ( lRowDS, "MAJ_LE", DateTime ( Today (), Now () ) )
		idw_wDivSin.SetItem ( lRowDS, "MAJ_PAR", stGlb.sCodOper )
	End if
Else
	// Mise à jour dans div_sin
	sVal=idw_wDivSin.GetItemString(lRowDS,"VAL_CAR")
	
	If bRet Then
		if pos(sVal, sValSepaOK) <=0 Then 
			If sVal ="" Then sVal="#"
			sVal+=sValSepaOK
		End if
	Else
		if pos(sVal, sValSepaOK) > 0 Then 
			
			sVal=f_remplace(sVal,"#" +sValSepaOK,"#")
			If sVal="#" Then sVal=""
		End if
	End if
	
	idw_wDivSin.SetItem ( lRowDS, "VAL_CAR",sVal)
	
End If


Return bRet
end function

private function long uf_zn_idnatcour ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_IdNatCour (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/01/1998 18:23:41
//* Libellé			: 
//* Commentaires	: Vérification de la zone ID_NAT_COUR
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//	FPI	22/06/2015	[DT158]
//*-----------------------------------------------------------------

DataWindowChild dwChild
String sIdCour,sNul, sValCar, sListeBtq, sListeCour
Long lLig, lIdBoutique
Integer iAction
Long  lDeb, lFin
n_cst_string nvString

iAction	= 0

idw_wInter.GetChild ( "ID_NAT_COUR", dwChild )
lLig = dwChild.GetRow ()

sIdCour = dwChild.GetItemString ( lLig, "ID_COUR" )

If sIdCour="APART1" Then
	iAction=1
	idw_wInter.iiErreur=1
	
	/*stMessage.scode="COUR008"
	stMessage.berreurg=FALSE
	stMessage.stitre="Saisie d'interlocuteur"
	stmessage.bouton=Ok!
	f_message(stMessage)
	idw_wInter.SetItem ( 1, "ID_COUR",stNul.str)
	idw_wInter.SetItem ( 1, "ID_NAT_COUR",stNul.str)
	Return 0*/

End if

// [DT158]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 281 )
If lDeb > 0 And iAction=0 Then
	lIdBoutique=idw_wsin.GetItemNumber(1,"ID_ORIAN_BOUTIQUE")

	sValCar=idw_DetPro.GetItemString(lDeb,"VAL_CAR")
	sListeBtq=nvString.of_getkeyvalue( sValCar, "ID_BOUTIQUE",";")
	sListeCour=nvString.of_getkeyvalue( sValCar, "ID_COUR",";")
	
	if Pos(sListeCour,"#" + sIdCour + "#") > 0 And Pos(sListeBtq,"#" + String(lIdBoutique) + "#") <= 0 Then
		// Sélection d'un courrier non-utilisable pour cette btq
		iAction=1
		idw_wInter.iiErreur=2
	End if
End if
// :[DT158]

idw_wInter.SetItem ( 1, "ID_COUR", sIdCour )

Return iAction

end function

private function integer uf_zn_codciv ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_CodCiv (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 15/01/1998 18:23:41
//* Libellé			: [PM452-1]
//* Commentaires	: Vérification de la zone COD_INTER
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sCodCiv 
Integer iAction

iAction	= 0

sCodCiv = idw_wInter.GetText ()

If sCodCiv = "3" Then
	idw_wInter.iiErreur=0
	iAction=1	
End If 


Return iAction
end function

private function integer uf_zn_altcourgest (string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_AltCourGest (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 20/08/2020 
//* Libellé			: [PM497-1]
//* Commentaires	: Vérification de la zone ALT_COURGEST
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* JFF  09/07/2025  [20250709161727060]
//* JFF  09/07/2025  [20250716182457933]
//*-----------------------------------------------------------------

String sAltCourGest
Integer iAction
Long lDeb, lFin
Long lGtDuDR
Long lIdProd // #4
Boolean bCaseDp390_EmailingKSL

iAction	= 0
bCaseDp390_EmailingKSL = False

lIdProd  = idw_wsin.GetItemNumBer( 1,"ID_PROD")

// [MIG1_COUR_EMAILING]
If F_CLE_A_TRUE ( "MIG1_COUR_EMAILING" ) Then
	// [MIG1_COUR_EMAILING]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 390 )
	If lDeb > 0 Then
		bCaseDp390_EmailingKSL =True
		iAction = 1
		idw_wInter.iiErreur = 3
		idw_wInter.SetItem ( 1, "ALT_COURGEST", "R" )

		SQLCA.PS_S01_AUTORISATION ( 9, stGlb.sCodOper, lIdprod, lGtDuDR )

		If lGtDuDR > 0 Then This.Uf_Tb_Questionnaire ()
		
		idw_wInter.Modify ( "b_typo_courrier.enabled = yes" )  // [20250716182457933]
		
	End If 
End If 
	
If iAction = 0 Then 
	Choose Case asCas
		Case "INIT"
			sAltCourGest = idw_wInter.GetItemString ( 1, "ALT_COURGEST" ) 
		Case Else
			sAltCourGest = idw_wInter.GetText ()
			
			// [20250709161727060]
			If bCaseDp390_EmailingKSL Then
				sAltCourGest = idw_wInter.GetItemString ( 1, "ALT_COURGEST" ) 
			End If 
			
	End CHoose 	
	
	Choose Case sAltCourGest
		Case "R", "J"
			idw_wInter.Modify ( "b_typo_courrier.enabled = yes" )
		Case Else 
			idw_wInter.Modify ( "b_typo_courrier.enabled = no" )		
	End Choose
End If 

Return iAction
end function

private function long uf_zn_adr_mail_name ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_zn_adr_mail_name (PRIVATE)
//* Auteur			: JFF
//* Date				: 04/08/2023
//* Libellé			: // [RS5045_REF_MATP]
//* Commentaires	: Blocage de AltSuviMail si un courrier existe
//*
//* Arguments		: Aucun
//*
//* Retourne		: long
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//      JFF   07/07/2025 	[LGY86]
//*-----------------------------------------------------------------

Integer iAction
Boolean bPresenceCP
iAction	= 0
String sCodInter, sGetText, sValItem
Long lDebDp368, lFinDp368


// [LGY86] Interdiction de supprimer
/* Couper car gêne la DGRC pour les BA Physique et les adresse mails erronées
If F_CLE_A_TRUE ( "LGY86" ) Then
	
	sGetText = Trim ( idw_wInter.GetText ())
	sValItem = Trim ( idw_wInter.GetItemString ( 1, "ADR_MAIL_NAME" ) )
	
	If  Not IsNull ( sValItem ) And sValItem <> ""  And ( IsNull ( sGetText ) Or sGetText = "" ) Then
		iAction = 2

		stMessage.sTitre 		= "LGY86 / Suppression adresse mail"
		stMessage.bErreurG	= False
		stMessage.Icon			= Exclamation!		
		stMessage.sCode	= "WINT323"
		F_Message ( stMessage ) 

		idw_wInter.SetItem ( 1, "ADR_MAIL_NAME", sValItem )
	
		Return iAction 
	End If 
	
End If
*/

F_RechDetPro ( lDebDp368, lFinDp368, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 368 )	

sGetText = Trim ( idw_wInter.GetText ())
If IsNull (sGetText) Then sGetText = ""
	
If sGetText = "" And F_CLE_NUMERIQUE ( "RS5045_REF_MATP" ) >= 3 Then

	sCodInter = idw_wInter.GetItemString ( 1, "COD_INTER" ) 
	bPresenceCP = This.uf_PresenceCP ( idw_wInter.object.id_i[1], idw_wInter.object.cod_inter[1] )

	If bPresenceCP And idw_DetPro.Find ( "ID_CODE_CAR = '" + sCodInter + "' AND POS ( VAL_CAR, 'CANAL=MA' ) > 0", lDebDp368, lFinDp368 ) > 0 Then
		iAction = 2

		sGetText = idw_wInter.GetItemString ( 1, "ADR_MAIL_NAME" ) 

		stMessage.bErreurG	= False
		stMessage.Icon			= Exclamation!		
		stMessage.sCode	= "WINT313"
		F_Message ( stMessage ) 

		idw_wInter.SetItem ( 1, "ADR_MAIL_NAME", sGetText )
	End If 
End If 

Return iAction

end function

private function long uf_zn_adr_mail_domain ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_zn_adr_mail_domain (PRIVATE)
//* Auteur			: JFF
//* Date				: 04/08/2023
//* Libellé			: // [RS5045_REF_MATP]
//* Commentaires	: Blocage de AltSuviMail si un courrier existe
//*
//* Arguments		: Aucun
//*
//* Retourne		: long
//*-----------------------------------------------------------------
//* MAJ PAR		Date			Modification
//      JFF   07/07/2025 	[LGY86]
//*-----------------------------------------------------------------

Integer iAction
Boolean bPresenceCP
iAction	= 0
String sCodInter, sGetText, sValItem
Long lDebDp368, lFinDp368


// [LGY86] Interdiction de supprimer
/*
If F_CLE_A_TRUE ( "LGY86" ) Then
	
	sGetText = Trim ( idw_wInter.GetText ())
	sValItem = Trim ( idw_wInter.GetItemString ( 1, "ADR_MAIL_DOMAIN" ) )
	
	If  Not IsNull ( sValItem ) And sValItem <> ""  And ( IsNull ( sGetText ) Or sGetText = "" ) Then
		iAction = 2

		stMessage.sTitre 		= "LGY86 / Suppression adresse mail"
		stMessage.bErreurG	= False
		stMessage.Icon			= Exclamation!		
		stMessage.sCode	= "WINT323"
		F_Message ( stMessage ) 

		idw_wInter.SetItem ( 1, "ADR_MAIL_DOMAIN", sValItem )
	
		Return iAction 
	End If 
	
End If
*/

F_RechDetPro ( lDebDp368, lFinDp368, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 368 )	

sGetText = Trim ( idw_wInter.GetText ())
If IsNull (sGetText) Then sGetText = ""
	
If sGetText = "" And F_CLE_NUMERIQUE ( "RS5045_REF_MATP" ) >= 3 Then

	sCodInter = idw_wInter.GetItemString ( 1, "COD_INTER" ) 
	bPresenceCP = This.uf_PresenceCP ( idw_wInter.object.id_i[1], idw_wInter.object.cod_inter[1] )

	If bPresenceCP And idw_DetPro.Find ( "ID_CODE_CAR = '" + sCodInter + "' AND POS ( VAL_CAR, 'CANAL=MA' ) > 0", lDebDp368, lFinDp368 ) > 0 Then
		iAction = 2

		sGetText = idw_wInter.GetItemString ( 1, "ADR_MAIL_DOMAIN" ) 

		stMessage.bErreurG	= False
		stMessage.Icon			= Exclamation!		
		stMessage.sCode	= "WINT313"
		F_Message ( stMessage ) 

		idw_wInter.SetItem ( 1, "ADR_MAIL_DOMAIN", sGetText )
	End If 
End If 


Return iAction

end function

public subroutine uf_controle_dp344 (ref integer aiaction, ref integer aierreur);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_controle_dp344 (PRIVATE)
//* Auteur			: JFF
//* Date				: 26/03/2025
//* Libellé			: [20250326111126190]
//* Commentaires	: 	
//*
//* Arguments		: Aucun
//*
//*-----------------------------------------------------------------

Long lDeb, lFin
String sIdCie 
Long dcIdSin, dcIdRev, dcIdGti, lIdCie
Int iRet
n_cst_string lnvPFCString
	
// [VDOC28559]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 344 )
If lDeb > 0 Then
	sIdCie = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "ID_CIE", ";")
	dcIdSin = idw_wSin.GetItemNumber ( 1, "ID_SIN" ) 
	dcIdRev = idw_wSin.GetItemNumber ( 1, "ID_REV" ) 
	SetNull ( dcIdGti )
	SQLCA.PS_S_ID_CIE ( dcIdSin, dcIdRev, dcIdGti, lIdCie )

	If Upper ( SQLCA.DataBase ) <> "SIMPA2_PRO" Then
		
		stMessage.sTitre		= "MESSAGE DE RECETTE UNIQUEMENT"
		stMessage.Icon			= Question!
		stMessage.Bouton		= YesNo!
		stMessage.bErreurG	= False
		stMessage.sCode		= "WINT310"

		iRet = F_Message ( stMessage )
	Else 
		iRet = 1 
	End IF 

	// [PMO268_MIG25]
	// [DP344_MODIF]
	If F_CLE_A_TRUE ( "DP344_MODIF" ) Then
		If iRet = 1 And ( sIdCie = "" Or Pos ( sIdCie, "#" + String ( lIdCie ) + "#" ) > 0 Or IsNull ( lIdCie ) Or lIdCie = 0 ) Then
			aiAction	= 1
			aiErreur = 3	
			
			If sIdCie = "" Then
				aiErreur = 4
			End If 
		End If 
	Else		
		If iRet = 1 And Pos ( sIdCie, "#" + String ( lIdCie ) + "#" ) > 0 Or IsNull ( lIdCie ) Or lIdCie = 0 Then
			aiAction	= 1
			aiErreur = 3	
		End If 
	End If		
End If 


end subroutine

private subroutine uf_controlergestion (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerGestion (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 25/06/2025
//* Libellé			: 
//* Commentaires	: Contrôle de gestion d'un interlocuteur
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sPos, sCodInter, sValCar, sLibInter 
Long lDeb, lFin 

sPos = ""

sCodInter = idw_wInter.GetItemString ( 1, "COD_INTER" ) 

// [MIG147_KRYS]
If F_CLE_A_TRUE ( "MIG147_KRYS" ) Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 400 )
	If lDeb > 0 And astPass.bInsert Then
		sValCar = idw_DetPro.GetItemString(lDeb,"VAL_CAR" )
		sValCar = F_CLE_VAL ("TYP_INTER", sValCar, ";") 
		
		If sValCar = "" Then
			sPos = "NOM"
			stMessage.berreurg=FALSE
			stMessage.bouton=Ok!
			stMessage.icon=Information!
			stMessage.stitre="Gestion des interlocuteurs"
			stMessage.scode ="WINT319"
			F_Message ( stMessage )
		End If 
		
		
		If sValCar <> "" And Not IsNull ( sCodInter ) And Pos ( sValCar, "#" + sCodInter + "#" ) > 0 Then
			
			sLibInter = SQLCA.FN_CODE_CAR ( sCodInter, "-IN" )
	
			sPos = "NOM"
			stMessage.berreurg=FALSE
			stMessage.bouton=Ok!
			stMessage.icon=Information!
			stMessage.stitre="Gestion des interlocuteurs"
			stMessage.sVar[1] = sLibInter
			stMessage.scode ="WINT320"
			F_Message ( stMessage )		
	
		End If 
	
	End If 

	If sPos = "" Then 
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 404 )
		If lDeb > 0 Then
			sValCar = idw_DetPro.GetItemString(lDeb,"VAL_CAR" )
			sValCar = F_CLE_VAL ("TYP_INTER", sValCar, ";") 
			
			If sValCar = "" Then
				sPos = "NOM"				
				stMessage.berreurg=FALSE
				stMessage.bouton=Ok!
				stMessage.icon=Information!
				stMessage.stitre="Gestion des interlocuteurs"
				stMessage.scode ="WINT324"
				F_Message ( stMessage )
			End If 
			
			
			If sValCar <> "" And Not IsNull ( sCodInter ) And Pos ( sValCar, "#" + sCodInter + "#" ) > 0 Then
				
				sLibInter = SQLCA.FN_CODE_CAR ( sCodInter, "-IN" )
		
				stMessage.berreurg=FALSE
				sPos = "NOM"				
				stMessage.bouton=Ok!
				stMessage.icon=Information!
				stMessage.stitre="Gestion des interlocuteurs"
				stMessage.sVar[1] = sLibInter
				stMessage.scode ="WINT325"
				F_Message ( stMessage )		
		
			End If 
		End If 
	End If 
End If 



astPass.sTab [ 1 ] = sPos



end subroutine

on u_gs_sp_sinistre_interlocuteur.create
call super::create
end on

on u_gs_sp_sinistre_interlocuteur.destroy
call super::destroy
end on

