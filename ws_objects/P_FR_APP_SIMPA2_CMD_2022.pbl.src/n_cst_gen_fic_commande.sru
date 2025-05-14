$PBExportHeader$n_cst_gen_fic_commande.sru
$PBExportComments$Objet pour la génération du fichier de commande
forward
global type n_cst_gen_fic_commande from nonvisualobject
end type
end forward

global type n_cst_gen_fic_commande from nonvisualobject
end type
global n_cst_gen_fic_commande n_cst_gen_fic_commande

type variables
Private :

Datawindow	idwFourn
Datawindow	idwFicCharg
Datawindow	idwFicCharg2 // [BLCODE]
Datawindow	idwFicGenCmde
Datawindow	idwSuiviTrt
Datawindow	idwLstLots
Datawindow	idwStkRepFourn
Datawindow	idwFicChargArt
Datawindow	idwFicChargHlr

ListBox		ilbListeFic

String		K_FIC1 = "CMD"
String		K_FIC2 = "PRS"
String		K_FIC3 = "ACD"
String		K_FIC4 = "APR"
String		K_FIC5 = "SAP"
String		K_FIC6 = "SIN"
String		K_FIC7 = "BGE" // [FNAC_PROD_ECH_TECH].[BGE].[20091109173744030]
String		K_FIC8 = "BCD" // [PC363_AUCHAN]
String		K_FIC9 = "PRS_OX" // MANTIS3743
String		K_FIC10 = "PRS_BLC"
String		K_FIC11 = "PRS_HORS_TEL" // [PC877]
String		K_FIC12 = "PRS_TEL"
String		K_FIC13 = "PRS_TEL_OX" // MANTIS3743
String		K_FIC14 = "PRS_RELAI" // [PC938_ORANGE_V3]
String		K_FIC15 = "IPHONE_O2M" // [DT57_CMDE_IPHONE_SFR]
String		K_FIC16 = "CTRLE_IMEI_OMT_" // [PC874_2_V1]
String		K_FIC17 = "DEM_CTRLE_IMEI_[FOUR]_" // [DT424]
String		K_FIC18 = "REFERENTIEL_SPB_1" // [RS-5297-HP-178]

String		K_FICLOG = "LOGCMD\FIC_CMD.LOG"
String		K_FIC_SORTIE_OPCON = "ERRSP2.DAT"
//String		K_FIC_FIN_OPCO = "\TEMP\FINOPCO"
String		K_FICFINTRT = "FIN_TRT"

String  		isRepFicOpCon	
String 		isTabFrIntGen[]   

String		isTypTrt

Int		iiFicTrc
Long		ilIdLotCeg, ilIdLotFNC // [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]

Datawindow idwDetPro // [FNAC_EPT.BGE].FPI
end variables

forward prototypes
public subroutine uf_preparer ()
public function integer uf_controler_saisie ()
public function integer uf_lancer_trt ()
private function integer uf_trace (string ascas, string astexte)
private function integer uf_purge_fichier_auto (string aidfourn)
public subroutine uf_initialiser (ref s_pass astpass, ref listbox alblistefic)
private function long uf_charger_commandes ()
private function integer uf_generer_fichier (long alidlotcmd)
private function integer uf_flaguer_commandes_cegetel ()
private function integer uf_generer_fichier_cegetel ()
private subroutine uf_charger_cegetel ()
private function string uf_calcnumcmde (long alidprod, string asidcontrabon, long alcptcmd)
private function string uf_formatchamps (integer ainbcar, string aschamp)
private function integer uf_flaguer_commandes (ref long alidlotcmd, string asidfourn)
private subroutine uf_nom_fichier (ref string asnomfic, long alcas)
private function integer uf_sortie_opcon (string ascas, integer aicodeerreur, string astexte, boolean abbox)
public function integer uf_trt_opcon (string ascas)
private function integer uf_flaguer_commandes_standard (ref long alidlotcmd)
private function integer uf_generer_fichier_dme (long alidlotcmd)
private function integer uf_generer_fichier_sbe (long alidlotcmd)
private function integer uf_generer_fichier_mss (long alidlotcmd)
private function integer uf_flaguer_commandes_cegetel2 ()
private function string uf_calcnumcmde2 (long alidprod, string asidcontrabon, string asnumcmdspb)
private function integer uf_generer_fichier_cegetel2 (long alidlotcmd)
private function integer uf_generer_fichier_cdiscount (long alidlotcmd)
private subroutine uf_formatchaine (ref string asval, long alcas)
private subroutine uf_charger_o2m ()
private function integer uf_generer_fichier_micromania (long alidlotcmd)
private subroutine uf_charger_cdiscountpro ()
private function integer uf_generer_fichier_cdiscountpro (long alidlotcmd)
private function integer uf_generer_fichier_phoneandphone (long alidlotcmd)
private function integer uf_generer_fichier_rueducommerce (long alidlotcmd)
private function integer uf_generer_fichier_sbetv (long alidlotcmd)
private function integer uf_generer_fichier_fnac (long alidlotcmd)
private function string uf_formatchamps (integer ainbcar, string aschamp, string ascar, boolean abdebut)
private function integer uf_flaguer_commandes_fnac ()
private function integer uf_generer_fichier_mss_diag (long alidlotcmd)
private function integer uf_generer_fichier_auchan (long alidlotcmd)
private function integer uf_generer_fichier_carrefour (long alidlotcmd)
private function integer uf_generer_fichier_carma (long alidlotcmd)
private function integer uf_generer_fichier_carma_xml (string asnomfic, long alidlotcmd)
private function integer uf_generer_fichier_auchan_xml (string asnomfic, long alidlotcmd)
private function integer uf_generer_fichier_coriolis (long alidlotcmd)
private function integer uf_generer_fichier_psm (long alidlotcmd)
private function integer uf_generer_fichier_ore (long alidlotcmd)
private function integer uf_generer_fichier_o2m_blcode (long alidlotcmd)
private function integer uf_generer_fichier_lbe (long alidlotcmd)
private function integer uf_generer_fichier_omt (long alidlotcmd)
private function integer uf_generer_fichier_vipp (long alidlotcmd)
private function integer uf_generer_fichier_mtt (long alidlotcmd)
public function integer uf_generer_fichier_srr (long alidtotcmd)
private function integer uf_generer_fichier_vipp2 (long alidlotcmd)
private function integer uf_generer_fichier_electrodepot (long alidlotcmd)
private function integer uf_generer_fichier_tamet (long alidlotcmd)
private function integer uf_generer_fichier_cdiscountpro_new (long alidlotcmd)
private function integer uf_generer_fichier_bak2 (long alidlotcmd)
private function integer uf_generer_fichier_cordon (long alidlotcmd)
private function integer uf_flaguer_commandes_carma (ref long alidlotcmd)
public subroutine uf_maj_nom_fichier_ds_presta (string asnomficentier)
private function integer uf_generer_fichier_ceat (long alidlotcmd)
private function integer uf_generer_fichier_agora_place (long alidlotcmd)
private function integer uf_generer_fichier_orangeopenpro (long alidlotcmd)
private function integer uf_generer_fichier_orangegrandpublic (long alidlotcmd)
private subroutine uf_charger_standard ()
public subroutine uf_maj_nom_spb_frn_cplt (string ascle, string asval)
private function integer uf_generer_fichier_telstore (long alidlotcmd)
private function integer uf_generer_fichier_cardif (long alidlotcmd)
private function integer uf_generer_fichier_ifr ()
end prototypes

public subroutine uf_preparer ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Preparer (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libellé			: Preparer avant traitement
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

DatawindowChild 	dwChild


CHOOSE CASE isTypTrt

	// Génération
	CASE "G"
		/*------------------------------------------------------------------*/
		/* Préparation dw fournisseur.                                      */
		/*------------------------------------------------------------------*/
		idwFourn.Reset ()
		idwFourn.InsertRow ( 0 )
		idwFourn.GetChild ( "ID_FOURN", dwChild )

		If dwChild.Rowcount () = 1 Then 
			idwFourn.SetItem ( 1, "ID_FOURN", dwChild.GetItemString ( 1, "ID_CODE" ) )
		End If

	// ReGénération
	CASE "R"
		If idwLstLots.Retrieve () > 0 Then idwLstLots.SelectRow ( 1, TRUE )

END CHOOSE


end subroutine

public function integer uf_controler_saisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Controler_Saisie (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libellé			: Controler de la saisie
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Int iRet
String	sIdFourn, sNomFic

iRet = 1

CHOOSE CASE isTypTrt
	CASE "G"
		/*------------------------------------------------------------------*/
		/* 1 : Le fournisseur est-il renseigné ?                            */
		/*------------------------------------------------------------------*/
		sIdfourn = idwFourn.GetItemString ( 1, "ID_FOURN" ) 
		If IsNull ( sIdFourn ) Then 
			stMessage.sTitre = "Controle de saisie"
			stMessage.sCode = "COMD002"
			stMessage.icon = Information!
			This.uf_Sortie_OpCon ( "ECR", 500, "ERR500/CTRLSAI/1", TRUE )
			iRet = -1
		End If

	CASE "R"
		/*------------------------------------------------------------------*/
		/* 1 : Un row est-il sélectionné.											  */
		/*------------------------------------------------------------------*/
		If idwLstLots.GetSelectedRow ( 0 ) <= 0 Then 
			stMessage.sTitre = "Controle de saisie"
			stMessage.sCode = "COMD024"
			stMessage.icon = Information!
			This.uf_Sortie_OpCon ( "ECR", 510, "ERR510/CTRLSAI/2", TRUE )
			iRet = -1
		End If

END CHOOSE

return iRet
end function

public function integer uf_lancer_trt ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Lancer_Trt (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 31/08/2001
//* Libellé			: Lancement du Traitement
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 CAG	 06/05/03	  Génération d'un fichier vide qd pas de cmdes
//*								  pour des fournisseurs autres que CEGETEL et CETELEC
//* #2    JFF   28/10/09     [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
//*-----------------------------------------------------------------

Int		iRet
String	sNomFic, sIdFourn
Long		lTotLig, lIdLotCmd

iRet = 1

/*------------------------------------------------------------------*/
/* Initialisation de la trace.                                      */
/*------------------------------------------------------------------*/
If uf_Trace ( "INIT", "") <= 0 Then iRet = -1

CHOOSE CASE isTypTrt

	// Génération d'un fichier
	CASE "G"
		This.uf_Trace ( "ECR", "TRAITEMENT DE GENERATION DE COMMANDES" )

		/*------------------------------------------------------------------*/
		/* Purge des fichiers du mois précédent.                            */
		/*------------------------------------------------------------------*/
		sIdFourn = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
		This.uf_Purge_Fichier_Auto ( sIdFourn )

		/*------------------------------------------------------------------*/
		/* Chargement des commandes de la table dans la dw                  */
		/* si iRet = 2, aucune ligne à générer.									  */
		/*------------------------------------------------------------------*/
		If iRet > 0 Then
			iRet = This.uf_Charger_Commandes () 
		End If

		/*------------------------------------------------------------------*/
		/* Marquage des commandes chargées comme étant générées.				  */
		/*------------------------------------------------------------------*/
		// #2  [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
//		If iRet = 1 Then
		If iRet > 0 Then			
			If uf_Flaguer_Commandes ( lIdLotCmd, sIdFourn ) < 0 Then iRet = -1
		End If

		/*--------------------------------------------------------------------*/
		/* Génération du fichier de commandes pour le fournisseur sélectionné */
		/*--------------------------------------------------------------------*/
		/* #1 : CAG 06/05/2003																 */
		/*--------------------------------------------------------------------*/
		If iRet = 1 Or ( iRet = 2 And sIdFourn <> 'CEG' ) Then
			If uf_Generer_Fichier ( lIdLotCmd ) < 0 Then iRet = -1

		End If

		If iRet <= 0 Then 
			This.uf_Trace ( "ECR", "Le traitement se termine anormalement, le fichier n'a pas été généré !!!." )
		ElseIf iRet = 1 then
			This.uf_Trace ( "ECR", "Le traitement se termine normalement, le fichier a été généré." )
		Else
			This.uf_Trace ( "ECR", "Le traitement se termine normalement, Aucune à ligne à générer." )
		End If

	// ReGénération d'un fichier à partir d'un lot
	CASE "R"

		This.uf_Trace ( "ECR", "TRAITEMENT DE REGENERATION D'UN LOT" )

		/*------------------------------------------------------------------*/
		/* Chargement des commandes de la table dans la dw                  */
		/* si iRet = 2, aucune ligne à générer.									  */
		/*------------------------------------------------------------------*/
		If iRet > 0 Then
			iRet = This.uf_Charger_Commandes () 
		End If

		/*-------------------------------------------------------------------*/
		/* Génération du fichier de commandes pour le fournisseur sélectionné*/
		/*-------------------------------------------------------------------*/
		/* #1 : CAG 06/05/03																	*/
		/*-------------------------------------------------------------------*/
		If iRet = 1 Or iRet = 2 Then
			If uf_Generer_Fichier ( lIdLotCmd ) <= 0 Then iRet = -1
		End If

		If iRet <= 0 Then 
			This.uf_Trace ( "ECR", "Le traitement se termine anormalement, le fichier (Lot " &
			+ String ( idwLstLots.GetItemNumber ( idwLstLots.GetSelectedRow ( 0 ), "ID_LOT_CMD" ) ) + ") n'a pas été regénéré !!!." )
		ElseIf iRet = 1 then
			This.uf_Trace ( "ECR", "Le traitement se termine normalement, le fichier (Lot " &
			+ String ( idwLstLots.GetItemNumber ( idwLstLots.GetSelectedRow ( 0 ), "ID_LOT_CMD" ) ) + ") a été regénéré." )
		Else
			This.uf_Trace ( "ECR", "Le traitement se termine normalement, Aucune à ligne à regénérer pour ce lot." )
		End If

END CHOOSE

idwSuiviTrt.ScrollToRow ( idwSuiviTrt.RowCount () )


Return iRet
end function

private function integer uf_trace (string ascas, string astexte);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Trace (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libellé			: Trace des opérations
//* Commentaires	: 
//*
//* Arguments		: asCas			String		Val
//*					  asTexte		String		Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Int	iRet
String sRepFicGen, sMes
Long	lRow

sRepFicGen =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_GEN", "" ) + K_FICLOG
iRet = 1

CHOOSE CASE Upper ( asCas )

	CASE "INIT"
		iiFicTrc = FileOpen ( sRepFicGen, LineMode!, Write!, Shared!, Append! )

		If iiFicTrc <= 0 Then 
			iRet = -1
			stMessage.sTitre = "Fichier Trace"
			stMessage.sCode = "COMD005"
			stMessage.icon = StopSign!
			This.uf_Sortie_OpCon ( "ECR", 520, "ERR520/TRACE/INIT", TRUE )
		Else
			sMes = Fill( "*", 80 )
			FileWrite ( iiFicTrc, sMes )
			FileClose ( iiFicTrc )
		End If

	CASE "ECR"

			iiFicTrc = FileOpen ( sRepFicGen, LineMode!, Write!, Shared!, Append! )

			sMes = String ( Today() ) + "~t" + String ( Now () ) + "~t" + Upper ( stGlb.sCodOper ) + "~t" + asTexte
			FileWrite ( iiFicTrc, sMes )
			lRow = idwSuiviTrt.InsertRow ( 0 )
			idwSuiviTrt.SetItem ( lRow,  "TEXTE", String ( Today() ) + " " + String ( Now () ) + "   " + asTexte )

			FileClose ( iiFicTrc )

END CHOOSE



Return iRet
end function

private function integer uf_purge_fichier_auto (string aidfourn);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Purge_Fichier_Auto (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 05/09/2001
//* Libellé			: Purge Automatique des fichier traité après 6 mois
//* Commentaires	: 
//*
//* Arguments		: String		aIdfourn		Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    30/08/2002  Le nom du répertoire de génération n'est plus le code
//*								  du fournisseur -FR mais le nom complet (<8 car) -FL
//* 
//*-----------------------------------------------------------------

Int	iRet
String sJoker, sRepFic, sMoisPrec, sVar, sRepFourn
Long	lTotLig, lCpt, lErreur, lCptCas, lTotGen, lRow

/*------------------------------------------------------------------*/
/* JFF le 28/02/2002 : Je shunte pour le moment la purge            */
/* (Problème avec le CETELEC)                                       */
/*------------------------------------------------------------------*/
Return 1

iRet = 1

sMoisPrec = Trim ( String ( Month ( Today () ) - 6, "00" ) )
If Long ( sMoisPrec ) <= 0 Then sMoisPrec = String ( Long ( sMoisPrec ) + 12, "00" )

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
lRow = idwStkRepFourn.Find ( "ID_CODE = '" + aIdFourn + "'", 1, idwStkRepFourn.RowCount () )
If lRow > 0 Then
	sRepFourn = Upper ( idwStkRepFourn.GetItemString ( lRow, "LIB_CODE" ) )
Else
	Return -1
End If

sRepFic =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_GEN", "" ) + &
				  sRepFourn + &
				  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_FIC_CMD", "" )
lTotGen = 0
lErreur = 0

For lCptCas = 1 To 4

	CHOOSE CASE lCptCas
		CASE 1
			sVar = K_FIC1  // Fichier CMD*.*
		CASE 2
			sVar = K_FIC2  // Fichier PRS*.*
		CASE 3
			sVar = K_FIC3  // Fichier ACD*.*
		CASE 4
			sVar = K_FIC4  // Fichier APR*.*

	END CHOOSE

	sJoker = sRepFic + sVar + "??" + sMoisPrec + "?.X*"

	ilbListeFic.DirList ( sJoker, 0 )

	lTotLig = ilbListeFic.TotalItems ()

	lTotGen += lTotLig

	For lCpt = 1 To lTotLig
		ilbListeFic.SelectItem ( lCpt )
		If Not FileDelete ( sRepFic + ilbListeFic.SelectedItem ( ) ) Then lErreur++
	Next

Next

If lErreur > 0 Then
	This.Uf_Trace ( "ECR", "ERREUR lors de la purge de fichiers, " + String ( lErreur ) + " fichiers non purgés" )
End If
This.Uf_Trace ( "ECR", String ( lTotGen - lErreur ) + " fichiers sur " + String ( lTotGen ) + " ont été purgés" )


Return iRet
end function

public subroutine uf_initialiser (ref s_pass astpass, ref listbox alblistefic);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Initialiser (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libellé			: Initialisation de l'objet
//* Commentaires	: 
//*
//* Arguments		: astPass		s_Pass		Ref
//*					  aLbListeFic  ListBox		Ref					
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 08/10/02 :   Modification SFR
//* #2	 FPI	 28/10/2009		[FNAC_EPT.BGE].FPI Ajout de la var d'instance idwDetPro [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
//        JFF    06/08/2012  [BLCODE]
//*-----------------------------------------------------------------

DatawindowChild 	dwChild

isTypTrt 		= astPass.sTab [1]

idwFourn 		= astPass.dwNorm [1]
idwFicCharg		= astPass.dwNorm [2]
idwSuiviTrt 	= astPass.dwNorm [3]
idwFicGenCmde 	= astPass.dwNorm [4]
idwLstLots		= astPass.dwNorm [5]
idwStkRepFourn = astPass.dwNorm [6]

/*------------------------------------------------------------------*/
/* #1 									                                   */
/*------------------------------------------------------------------*/
idwFicChargArt = astPass.dwNorm [7]
idwFicChargHlr = astPass.dwNorm [8]

// #2 [FNAC_EPT.BGE].FPI [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
idwDetPro 		= astPass.dwNorm [9]
idwDetPro.SetTransObject( SQLCA )
// Fin #2

// [BLCODE]
idwFicCharg2	= astPass.dwNorm [10]

ilbListeFic		= albListeFic
idwLstLots.SetTransObject ( SQLCA )

/*------------------------------------------------------------------*/
/* Chargement liste fourns.                                         */
/*------------------------------------------------------------------*/
idwFourn .GetChild ( "ID_FOURN", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-FR" )

/*------------------------------------------------------------------*/
/* Chargement liste Rep fourns.                                     */
/*------------------------------------------------------------------*/
idwStkRepFourn.SetTransObject ( SQLCA )
idwStkRepFourn.Retrieve ( "-FL" )

/*------------------------------------------------------------------*/
/* Tableau des fournisseurs à traiter par OpCon/XPS.                */
/*------------------------------------------------------------------*/
isTabFrIntGen = stGlb.sTab_OpCon_XPS

/*------------------------------------------------------------------*/
/* Initialisation du fichier de Sortie OpCon                        */
/*------------------------------------------------------------------*/
If This.uf_Sortie_OpCon ( "INIT", 0, "", FALSE ) < 0 Then Halt
end subroutine

private function long uf_charger_commandes ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Charger_Commandes (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 31/08/2001
//* Libellé			: Chargement des commandes
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 08/10/02	  Modification SFR : en fonction du fournisseur
//*								  la dw change d'objet. Pour Cegetel, on génère
//*								  quand même un fichier si aucune commande
//*
//* #2	 CAG   16/10/02     Modification y compris pour Cetelec : si au moins
//*							     une annul, on ne regénére pas
//*								  cf doc d'analyse des traitements pour intégration
//*								  SFR préférence annexe 12
//*
//* #3	 CAG	 10/09/04	  DCMP 040381 : Ajout du frn MSS
//* #4    MADM  06/02/06     [DCMP060119]: Ajout du frn AVM
//* #5    MADM  07/03/06     [DCMP060198]: Ajout du frn BRIGHTPOINT/BTP
//* #6    MADM  09/05/06     [DCMP060356]: Repmlacement du frn AEVUM/AVM par CORDON/COR
//* #7	 JFF   18/09/07     [ALAPAGE]
//* #8	 PHG	 27/11/07	  [O2M]		  : Processe de gestion O2M
//* #9    JFF   05/09/08 	  [MICROMANIA]
//* #10   JFF   16/04/2009   [DCMP090102]
//* #11   JFF   16/04/2009   [DCMP090140]
//* #12   JFF   05/05/2009   [RUEDUCOMMERCE]
//* #13   JFF   05/05/2009   [DCMP090327].[SBETV]
//* #14   JFF   20/05/2009   [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
//* #15   JFF   25/11/2009   [MSS_DIAG]
//*       JFF   30/06/2010   [PC363_AUCHAN]
//* 		 JFF   04/11/2010   [PC301].[LOT2]
//* 		 JFF   03/05/2011   [PM178][CORIOLIS]
//* 		 JFF   13/02/2012   [PM200][PSM]
//        JFF    06/08/2012  [BLCODE]
//			FPI	22/08/2012	[PC767] Ajout de ORE
//			FPI	16/10/2012	 [PC884] Ajout LBE
//			FPI	22/11/2012	[PC874] Ajout OMT
//       JFF  02/04/2013   [PC929_CDISCOUNT]
//			FPI	24/07/2013	[PC767-1]
//       JFF   30/12/2013  [PC13348&13408]
//       JFF   21/02/2014  [PC925]
//			JFF   08/12/2014  [vDoc16241]
//       JFF   12/12/2014  [PC13321]
//       JFF   02/01/2015 [PC801_6_TAMET]
//       JFF   11/10/2016 [DT076-2]
//       JFF   24/01/2017 [PM234-7]
//       JFF   03/09/2018 [DT361]
//       JFF   02/09/2019 [DT424]
//       JFF   30/05/2023 [PMO89_RS4822]
//       JFF   12/06/2023 [RS-5297-HP-178]
//*-----------------------------------------------------------------

Int		iRet
String	sIdFourn
Long		lTotLig, lLot, lTotLigArt, lTotLig2, lCpt

iRet = 1

CHOOSE CASE isTypTrt

	// Génération d'un fichier
	CASE "G"
		sIdFourn = Upper (idwFourn.GetItemString ( 1, "ID_FOURN" ))

		This.uf_Trace ( "ECR", "Révision SVN : " + stGLB.sRevisionSvn )

		This.uf_Trace ( "ECR", "Fournisseur sélectionné : (" + sIdFourn + ") " + &
										Upper ( idwFourn.Describe ( "Evaluate ( 'LookUpDisplay ( ID_FOURN )', 1 )" ) ) )

		/*------------------------------------------------------------------*/
		/* #1                                                               */
		/*------------------------------------------------------------------*/
		Choose Case sIdFourn

			/*------------------------------------------------------------------*/
			/* Fournisseur : CEGETEL                                            */
			/* Fournisseur : ARVATO/ASF                                         */
			/*------------------------------------------------------------------*/
			Case "CEG"
				idwFicCharg.Reset ()
				idwFicCharg.DataObject = "d_trt_charg_cmde_agen_cegetel"
				idwFicCharg.SetTransObject ( SQLCA )

				/*------------------------------------------------------------------*/
				/* Chargement des commandes avec un ID_LOT_CMD à 0 (jamais générées)*/
				/*------------------------------------------------------------------*/
				lTotLig = idwFicCharg.Retrieve ( 0, sIdFourn )
				idwFicCharg.Sort ()

				If lTotLig < 0 Then
					iRet = -1
					This.uf_Sortie_OpCon ( "ECR", 530, "ERR530/CHGCMDCEG", FALSE )
					This.uf_Trace ( "ECR", "Chargement des commandes : ERREUR DE CHARGEMENT (" + String ( lTotLig ) + ")"  )
				Else
					/*------------------------------------------------------------------*/
					/* S'il n'y a pas de commande, on génère quand même le fichier      */
					/*------------------------------------------------------------------*/
					This.uf_Trace ( "ECR", "Chargement des commandes : " + String ( lTotLig ) + " ligne(s)"  )
				End If

			/*------------------------------------------------------------------*/
			/* Fournisseur : ORANGE/DME                                         */
         /* Fournisseur : AEVUM   #4 	[DCMP060119]                          */
			/* Fournisseur : BRIGHTPOINT/BTP  #5 [DCMP060198]						  */
			/* Remplacement du Fournisseur : AEVUM par CORDON  #6 [DCMP060356]  */
			/*------------------------------------------------------------------*/

			/*------------------------------------------------------------------*/
			/* #4    MADM  06/02/06  [DCMP060119]: Ajout du frn AVM             */
			/* #5    MADM  07/03/06  [DCMP060198]: Ajout du frn BRIGHTPOINT/BTP */
			/* #6    MADM  09/05/06  [DCMP060356]: Repml du frn AEVUM/AVM par CORDON/COR */
			/* #8		PHG	27/11/07  [O2M]		 : Ajout du frn O2M				  */
			/* #9    JFF   05/09/08  [MICROMANIA]										  */
			/* #10   JFF   16/04/2009 [DCMP090102]										  */
			/* #11   JFF   16/04/2009 [DCMP090140]										  */			
			/* #12   JFF   05/05/2009 [RUEDUCOMMERCE]                           */
			/* #13   JFF   05/05/2009 [DCMP090327].[SBETV]							  */
			/* #14   JFF   20/05/2009   [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]*/
			/* #15   JFF   25/11/2009   [MSS_DIAG]										 */
			/* [PC363_AUCHAN]																	 */
			// [PC301].[LOT2]
			// [PC884] Ajout LBE
			 // [PC874] Fournisseur : Outremer Telecom
			 // [PC767_1]  Ajout ORE
			 // [PC925]  Ajout SRR
			 // [PC13321] ajout ELD
			 // [PC801_6_TAMET] ajout TMT
			 // [DT076-2] BK2
         /*------------------------------------------------------------------*/
			Case "DME", "SBE", "MSS", "CDS" , "COR" , "O2M", &
					"MCM", "CDP", "PAP", "RDC", "SB1", "FNC", "MS1", "AUC", "CAR", "CMA", "CIS", "PSM", "LBE", "OMT",&
					"VPP","ORE", "MTT","SRR", "ELD", "TMT", "BK2", "CEA", "AGP", "OOP", "OGP", "TLS", "CDF"
				idwFicCharg.Reset ()
				idwFicCharg.DataObject = "d_trt_charg_cmde_agen_standard"
				idwFicCharg.SetTransObject ( SQLCA )

				// [PM234-7]
				Choose Case sIdFourn
					Case "O2M", "PSM", "COR"
						F_Execute ( "Exec sysadm.PS_D_PM234_7_CTRLE_PRESTA '" + sIdFourn + "'", SQLCA )
						F_commit ( SQLCA, SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0) // COMMIT/ROLLBACK
				End Choose 

				/*------------------------------------------------------------------*/
				/* Chargement des commandes avec un ID_LOT_CMDE à 0 (jamais générée)*/
				/*------------------------------------------------------------------*/
				lTotLig = idwFicCharg.Retrieve ( 0, sIdFourn )

				// [BLCODE] On génère BLCODE 	avec O2M
				If sIdFourn	= "O2M" Then
					idwFicCharg2.Reset ()
					idwFicCharg2.DataObject = "d_trt_charg_cmde_agen_standard"
					idwFicCharg2.SetTransObject ( SQLCA )
					lTotLig2 = idwFicCharg2.Retrieve ( 0, "BLC" )
					idwFicCharg2.RowsCopy ( 1, idwFicCharg2.Rowcount(), Primary!, idwFicCharg, 1, Primary! )
				
					For lCpt = 1 To lTotLig2 
						idwFicCharg.SetItemStatus ( lCpt, 0, Primary!, NewModified! )							
						idwFicCharg.SetItemStatus ( lCpt, 0, Primary!, DataModified! )														
						idwFicCharg.SetItemStatus ( lCpt, 0, Primary!, NotModified! )																					
					Next

				End If
				lTotLig += lTotLig2
				
				idwFicCharg.Sort ()


				If lTotLig < 0 Then
					This.uf_Sortie_OpCon ( "ECR", 540, "ERR540/CHGCMDSTD", FALSE )
					iRet = -1
					This.uf_Trace ( "ECR", "Chargement des commandes : ERREUR DE CHARGEMENT (" + String ( lTotLig ) + ")"  )
				Else
					If lTotLig = 0 Then iRet = 2
					This.uf_Trace ( "ECR", "Chargement des commandes : " + String ( lTotLig ) + " ligne(s)"  )
				End If

			/*------------------------------------------------------------------*/
			/*  Fournisseur virtuel IFR // [RS-5297-HP-178]							  */
			/*------------------------------------------------------------------*/			
			Case "IFR"
				idwFicCharg.Reset ()
				idwFicCharg.DataObject = "d_trt_fichier_cmde_IFR_1"
				idwFicCharg.SetTransObject ( SQLCA )

				lTotLig = idwFicCharg.Retrieve ( "#BYG#FRE#", "PAR_FOURN" )  // sinon DISTINCT mais modif DObj
			
				idwFicCharg.Sort ()

				If lTotLig < 0 Then
					This.uf_Sortie_OpCon ( "ECR", 550, "ERR550/CHGREFIFR", FALSE )
					iRet = -1
					This.uf_Trace ( "ECR", "Chargement du référentiel IFR : ERREUR DE CHARGEMENT (" + String ( lTotLig ) + ")"  )
				Else
					If lTotLig = 0 Then iRet = 2
					This.uf_Trace ( "ECR", "Chargement du référentiel IFR : " + String ( lTotLig ) + " ligne(s)"  )
				End If

			
			/*------------------------------------------------------------------*/
			/* Pas de fournisseur déclaré pour généré le fichier.					  */
			/*------------------------------------------------------------------*/
			Case ELSE
				iRet = -1
				This.Uf_Trace ( "ECR", "ERREUR : Pas de fournisseur déclaré pour la génération du fichier de commande !!" )

		End Choose

	// ReGénération d'un fichier à partir d'un lot
	CASE "R"
				iRet = 1
				// Récupération du fournisseur dans la liste des lots
				sIdFourn = Upper ( idwLstLots.GetItemString ( idwLstLots.GetRow (), "ID_FOUR" ) )
				idwFicCharg.Reset ()

				Choose Case sIdFourn
					
					/*------------------------------------------------------------------*/
					/* #4    MADM  06/02/06  [DCMP060119]: Ajout du frn AVM             */
					/* #5    MADM  07/03/06  [DCMP060198]: Ajout du frn BRIGHTPOINT/BTP */
					/* #6    MADM  09/05/06  [DCMP060356]: Repml du frn AEVUM/AVM par CORDON/COR*/
					/* #8		PHG	27/11/07  [O2M]		 : Ajout du frn O2M				  */
					/* #9    JFF   05/09/08  [MICROMANIA]										  */
					/* #10   JFF   16/04/2009 [DCMP090102]										  */
					/* #11   JFF   16/04/2009 [DCMP090140]										  */			
					/* #12   JFF   05/05/2009 [RUEDUCOMMERCE]                           */
					/* #13   JFF   05/05/2009 [DCMP090327].[SBETV]						     */
					/* #14   JFF   20/05/2009   [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]*/
				   /* #15   JFF   25/11/2009   [MSS_DIAG]										 */
					/* [PC363_AUCHAN]																	 */
					// [PC301].[LOT2]
					// [PC874]
					// [PC767_1] ORE
					// [PC13321] ajout ELD
					// [PC801_6_TAMET] ajout TMT					
               /*------------------------------------------------------------------*/
					Case "DME", "SBE", "MSS", "CDS" , "COR" , "O2M", &
						  "MCM", "CDP", "PAP", "RDC", "SB1", "FNC", "MS1", "AUC", "CAR", "CMA", "CIS", "PSM", "LBE", "OMT",&
						  "VPP","ORE", "MTT", "ELD", "TMT", "CEA", "AGP", "TLS", "CDF"
						idwFicCharg.DataObject = "d_trt_charg_cmde_agen_standard"

					Case "CEG"
						idwFicCharg.DataObject = "d_trt_charg_cmde_agen_cegetel"
			
				End Choose
				idwFicCharg.SetTransObject ( SQLCA )


		lLot = idwLstLots.GetItemNumber ( idwLstLots.GetSelectedRow ( 0 ), "ID_LOT_CMD" ) 

		This.uf_Trace ( "ECR", "Lot sélectionné : " + String ( lLot ) )

		/*------------------------------------------------------------------*/
		/* Chargement des commandes avec l'ID_LOT_CMDE sélectionné.			  */
		/*------------------------------------------------------------------*/
		lTotLig = idwFicCharg.Retrieve ( lLot, sIdFourn )
		idwFicCharg.Sort ()

		If lTotLig < 0 Then
			iRet = -1
			This.uf_Trace ( "ECR", "Chargement du lot de commandes : ERREUR DE CHARGEMENT (" + String ( lTotLig ) + ")"  )
		Else
			If lTotLig = 0 Then iRet = 2
			This.uf_Trace ( "ECR", "Chargement du lot de commandes : " + String ( lTotLig ) + " ligne(s)"  )
		End If

		/*------------------------------------------------------------------*/
		/* #2                                                               */
		/*------------------------------------------------------------------*/
		If idwFicCharg.Find ( "COD_ETAT = 'ANN'", 1, lTotLig) > 0 Then
			iRet = -1
			This.uf_Trace ( "ECR", "Chargement du lot de commandes : il y a au moins une commande d'annulée dans ce lot !"  )
		End If

END CHOOSE


CHOOSE CASE sIdFourn

	/*------------------------------------------------------------------*/
	/* Cas particulier à traiter pour CEGETEL, avant génération du      */
	/* fichier.                                                         */
	/*------------------------------------------------------------------*/
	CASE "CEG"

		/*------------------------------------------------------------------*/
		/* Chargement des tables det_article et det_hlr                     */
		/*------------------------------------------------------------------*/
		idwFicChargArt.Reset ()
		idwFicChargArt.DataObject = "d_det_article"
		idwFicChargArt.SetTransObject ( SQLCA )

		lTotLigArt = idwFicChargArt.Retrieve ( sIdFourn )
		idwFicChargArt.Sort ()

		If lTotLigArt < 0 Then
			iRet = -1
			This.uf_Trace ( "ECR", "Chargement des articles : ERREUR DE CHARGEMENT (" + String ( lTotLig ) + ")"  )
		Else
			This.uf_Trace ( "ECR", "Chargement des articles : " + String ( lTotLigArt ) + " ligne(s)"  )
		End If

		This.uf_charger_CEGETEL ()
		
		
	// #8 [O2M]	Chargement O2M 
	CASE "O2M"
		This.uf_Charger_O2M ()
		
	// #10 [DCMP090102]
	CASE "CDP"
		This.uf_Charger_CDISCOUNTPRO ()

	/*------------------------------------------------------------------*/
	/*  Fournisseur virtuel IFR // [RS-5297-HP-178]							  */
	/*------------------------------------------------------------------*/			
	CASE "IFR"
		// Aucun traitement pour ce cas.

	CASE ELSE 
		uf_Charger_Standard ()	
		
END CHOOSE



Return iRet

end function

private function integer uf_generer_fichier (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 31/08/2001
//* Libellé			: Génération du fichier de commandes pour le fournisseur
//* Commentaires	: 
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*
//* #1	 CAG	 15/10/02	Modification SFR : Ajout de la fonction de
//*								génération pour Cegetel
//* #2	 CAG	 14/09/04	DCMP 040381 : Ajout du frn MSS
//* #3    MADM  06/02/06	[DCMP060119]: Ajout du frn AVM
//* #4    MADM  07/03/06	[DCMP060198]: Ajout du frn BRIGHTPOINT/BTP
//* #5    MADM  09/05/06	[DCMP060356]: Rempl du frn AEVUM/AVM par CORDON/COR
//* #6	 JFF   18/09/07	[ALAPAGE]
//* #7	 PHG	 27/11/07	[O2M]
//* #8    JFF   05/09/08 	[MICROMANIA]
//* #9    JFF   16/04/2009 [DCMP090102]
//* #10   JFF   16/04/2009 [DCMP090140]
//* #11   JFF   09/06/2009 [RUEDUCOMMERCE]
//* #12   JFF   02/09/2009 [DCMP090327].[SBETV]
//* #13   JFF   28/10/2009 [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
//* #14   JFF   25/11/2009 [MSS_DIAG]
//*       JFF   30/06/2010 [PC363_AUCHAN]
//* 		 JFF   04/11/2010 [PC301].[LOT2]
//* 		 JFF   03/05/2011 [PM178][CORIOLIS]
// 		 JFF   13/02/2012 [PM200][PSM]
//			FPI	16/10/2012	 [PC884] Ajout LBE
//			FPI	16/10/2012	 [PC874] Ajout OMT
//			FPI	24/07/2013	[PC767-1]
// 			FPI	21/02/2014	[PC925]
//       JFF   12/12/2014 [PC13321]
//       JFF   02/01/2015 [PC801_6_TAMET]
//       JFF   17/09/2018 [PM444-1]
//       JFF   02/09/2019 [DT424]
//       JFF   30/05/2023 [PMO89_RS4822]
//       JFF   12/06/2023 [RS-5297-HP-178]
//*-----------------------------------------------------------------

Int iRet 
String	sIdFourn, sNomFicOrig, sNomFicRen
Long		lNbInsert, lNbLig
Boolean	bRet
Blob		blBlob
iRet = 1

CHOOSE CASE isTypTrt
	CASE "G"
		sIdFourn = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
	CASE "R"
		sIdFourn = idwFicCharg.GetItemString ( 1, "ID_FOUR" )
		ilIdLotCeg = idwFicCharg.GetItemNumber ( 1, "ID_LOT_CMD" )
END CHOOSE

CHOOSE CASE Upper ( sIdFourn )

	/*------------------------------------------------------------------*/
	/* Fournisseur : CEGETEL                                            */
	/*------------------------------------------------------------------*/
	CASE "CEG"
		iRet = This.uf_Generer_Fichier_CEGETEL2 ( alIdLotCmd )
		
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 590, "ERR590/GENFICCEG", FALSE )
		End If

	/*------------------------------------------------------------------*/
	/* Fournisseur : ORANGE/DME                                         */
	/*------------------------------------------------------------------*/
	CASE "DME"
		iRet = This.uf_Generer_Fichier_DME ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 592, "ERR592/GENFICDME", FALSE )
		End If

	/*------------------------------------------------------------------*/
	/* Fournisseur : SBE                                     			  */
	/*------------------------------------------------------------------*/
	CASE "SBE"
		iRet = This.uf_Generer_Fichier_SBE ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 596, "ERR596/GENFICSBE", FALSE )
		End If

	/*------------------------------------------------------------------*/
	/* #2 CAG : 14/09/2004                                              */
	/*------------------------------------------------------------------*/
	/* Fournisseur : MSS                                     			  */
	/*------------------------------------------------------------------*/
	CASE "MSS"
		iRet = This.uf_Generer_Fichier_MSS ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 597, "ERR597/GENFICMSS", FALSE )
		End If

	/*------------------------------------------------------------------*/
	/* #3    MADM  06/02/06  [DCMP060119]                               */
	/* #5    MADM  09/05/06  [DCMP060356]: Rempl du frn AEVUM/AVM par CORDON/COR */
	/*------------------------------------------------------------------*/
	/* Fournisseur : AEVUM/AVM                                     	  */
	/* Fournisseur : CORDON/COR 													  */
	/*------------------------------------------------------------------*/
	CASE "COR"	
		iRet = This.uf_Generer_Fichier_CORDON ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 601, "ERR601/GENFICAVM", FALSE )
		End If

	/*------------------------------------------------------------------*/
	/* Fournisseur : CDS                                     			  */
	/*------------------------------------------------------------------*/
	CASE "CDS"
		iRet = This.uf_Generer_Fichier_CDiscount ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 599, "ERR599/GENFICCDS", FALSE )
		End If


	CASE "O2M"
		iRet = This.uf_Generer_Fichier_O2M_BLCODE ( alIdLotCmd )			
		
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 605, "ERR605/GENFICGOM", FALSE )
		End If

	//* #8 [MICROMANIA]
	CASE "MCM"
		iRet = This.uf_Generer_Fichier_Micromania ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 606, "ERR606/GENFICMCM", FALSE )
		End If

	//* #9 [DCMP090102]
	CASE "CDP"
		// [PM289_CDP]
		iRet = This.uf_Generer_Fichier_CDiscountPRO_New ( alIdLotCmd )			
		
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 607, "ERR607/GENFICCDP", FALSE )
		End If

	//* #10 [DCMP090140]
	CASE "PAP"
		iRet = This.uf_Generer_Fichier_PhoneAndPhone ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 608, "ERR608/GENFICPAP", FALSE )
		End If

	//* #11 [RUEDUCOMMERCE]
	CASE "RDC"
		iRet = This.uf_Generer_Fichier_RueDuCommerce ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 609, "ERR609/GENFICRDC", FALSE )
		End If

//* #12   JFF   02/09/2009 [DCMP090327].[SBETV]
	CASE "SB1"
		iRet = This.uf_Generer_Fichier_SBETV ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 610, "ERR610/GENFICSB1", FALSE )
		End If

//* #13   JFF   28/10/2009 [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
	CASE "FNC"
		iRet = This.uf_Generer_Fichier_Fnac ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 611, "ERR611/GENFICFNC", FALSE )
		End If

//* #14   JFF   25/11/2009 [MSS_DIAG]
	CASE "MS1"
		iRet = This.uf_Generer_Fichier_MSS_DIAG ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 612, "ERR612/GENFICMS1", FALSE )
		End If

// [PC363_AUCHAN]
	CASE "AUC"
		iRet = This.uf_Generer_Fichier_Auchan ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 613, "ERR613/GENFICAUC", FALSE )
		End If

// [PC301].[LOT2]
	CASE "CAR"
		iRet = This.uf_Generer_Fichier_Carrefour ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 614, "ERR614/GENFICCAR", FALSE )
		End If

// [PC301].[LOT2]
	CASE "CMA"
		iRet = This.uf_Generer_Fichier_CARMA ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 615, "ERR615/GENFICCMA", FALSE )
		End If

// [PM178][CORIOLIS]
	CASE "CIS"
		iRet = This.uf_Generer_Fichier_Coriolis ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 616, "ERR616/GENFICCIS", FALSE )
		End If

// [PM178][CORIOLIS]
	CASE "PSM"
		iRet = This.uf_Generer_Fichier_PSM ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 617, "ERR617/GENFICPSM", FALSE )
		End If

	// [PC767]
	CASE "ORE"
		iRet = This.uf_Generer_Fichier_ORE ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 618, "ERR618/GENFICORE", FALSE )
		End If

	// [PC884]
	CASE "LBE"
		iRet = This.uf_Generer_Fichier_LBE ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 619, "ERR619/GENFICLBE", FALSE )
		End If

	// [PC874]
	CASE "OMT"
		iRet = This.uf_Generer_Fichier_OMT ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 620, "ERR620/GENFICOMT", FALSE )
		End If

	// [PC929_CDISCOUNT]
	CASE "VPP"
		iRet = This.uf_Generer_Fichier_VIPP2 ( alIdLotCmd ) // [PC13448]
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 621, "ERR621/GENFICVPP", FALSE )
		End If

	// [PC13348&13408]
	CASE "MTT"
		iRet = This.uf_Generer_Fichier_MTT ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 622, "ERR622/GENFICMTT", FALSE )
		End If

	// [PC925]
	CASE "SRR"
		iRet = This.uf_Generer_Fichier_SRR ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 623, "ERR623/GENFICSRR", FALSE )
		End If

	// [PC13321]
	CASE "ELD"
		iRet = This.uf_Generer_Fichier_ElectroDepot ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 624, "ERR623/GENFICELD", FALSE )
		End If

	// [PC801_6_TAMET]
	CASE "TMT"
		iRet = This.uf_Generer_Fichier_TAMET ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 625, "ERR625/GENFICTMT", FALSE )
		End If

	// [DT076-2]
	CASE "BK2"
		iRet = This.uf_Generer_Fichier_BAK2 ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 626, "ERR626/GENFICBK2", FALSE )
		End If
		
	// [DT361]
	CASE "CEA"
		iRet = This.uf_Generer_Fichier_CEAT ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 627, "ERR627/GENFICCEA", FALSE )
		End If
		
	// [PM444-1]
	CASE "AGP"
		iRet = This.uf_Generer_Fichier_AGORA_PLACE ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 628, "ERR628/GENFICAGP", FALSE )
		End If

	// [DT424]
	CASE "OGP"
		iRet = This.uf_Generer_Fichier_OrangeGrandPublic ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 629, "ERR629/GENFICOGP", FALSE )
		End If

	// [DT424]
	CASE "OOP"
		iRet = This.uf_Generer_Fichier_OrangeOpenPro ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 630, "ERR630/GENFICOOP", FALSE )
		End If

	// [RS3200]
	CASE "TLS"
		iRet = This.uf_Generer_Fichier_TelStore ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 631, "ERR631/GENFICTLS", FALSE )
		End If

	// [PMO89_RS4822]
	CASE "CDF"
		iRet = This.uf_Generer_Fichier_cardif ( alIdLotCmd )
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 632, "ERR632/GENFICCDF", FALSE )
		End If

	// [RS-5297-HP-178]
	CASE "IFR"
		iRet = This.uf_Generer_Fichier_IFR ()
		If iRet < 0 Then
			This.uf_Sortie_OpCon ( "ECR", 633, "ERR633/GENFICIFR", FALSE )
		End If


	/*------------------------------------------------------------------*/
	/* Pas de fournisseur déclaré pour généré le fichier.					  */
	/*------------------------------------------------------------------*/
	CASE ELSE
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR : Pas de fournisseur déclaré pour la génération du fichier de commande !!" )
		This.uf_Sortie_OpCon ( "ECR", 600, "ERR600/GENFICINC", FALSE )

END CHOOSE

idwFicCharg.SetFilter ( "" )
idwFicCharg.Filter ( )
idwFicCharg.Reset()

Return iRet
end function

private function integer uf_flaguer_commandes_cegetel ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Flaguer_Commandes_Cegetel ( PRIVATE )
//* Auteur			: Abdmeziem Catherine
//* Date				: 08/10/02
//* Libellé			: On marque en base les commandes chargées comme étant générées
//*					  elle ne pourraient être par la suite que regénérées avant la fonction adéquat.
//* Commentaires	: Modification SFR
//*
//* Arguments		: Aucun
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Int 			iRet
DateTime		dtNow
String 		sFiltre, sIdCmdFrn, sIdContrAbon
Long			lTotFilt, lCptFilt, lIdProd, lCptCmdMax, lCptCmd, lCpt

iRet = 1
dtNow = DateTime ( Today (), Now () )

ilIdLotCeg = -1
SQLCA.PS_S05_COMMANDE ( "ID_LOT_CEG", ilIdLotCeg )

If ilIdLotCeg <= 0 Or IsNull ( ilIdLotCeg ) Then
	// RollBack immédiat.
	F_Commit ( SQLCA, False )
	iRet = -1
	This.Uf_Trace ( "ECR", "ERREUR lors de la récupération de l'ID_LOT_CEG, " + String ( ilIdLotCeg ) )
Else
	This.Uf_Trace ( "ECR", "Attribution du n° de fichier de commandes : " + String ( ilIdLotCeg ) )
End If

// [ITSM178659]
F_COMMIT ( SQLCA, SQLCA.SQLCODE = 0 Or SQLCA.SQLDBCODE = 0  ) 

For lCpt = 1 To 2

	Choose Case lCpt

		/*------------------------------------------------------------------*/
		/* Flague des commandes pour le produit 5712 ( SFR Preference )     */
		/*------------------------------------------------------------------*/
		Case 1
			lIdProd = 5712

		/*------------------------------------------------------------------*/
		/* Flague des commandes pour le produit 5707 ( [MOBILE PROTECT] )   */
		/*------------------------------------------------------------------*/
		Case 2
			lIdProd = 5707

	End Choose

	sFiltre = "ID_PROD = " + String ( lIdProd )
	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTotFilt = idwFicCharg.RowCount ()

	If lTotFilt > 0 Then

	/*------------------------------------------------------------------*/
	/* Récupération d'un n° max de cmde par produit                     */
	/*------------------------------------------------------------------*/
		SQLCA.PS_S04_COMMANDE ( lIdProd, lTotFilt, lCptCmdMax )
		If lCptCmdMax <= 0 Or IsNull ( lCptCmdMax ) Then
			// RollBack immédiat.
			F_Commit ( SQLCA, False )
			iRet = -1
			This.Uf_Trace ( "ECR", "ERREUR lors de la récupération de CPT_CMD, " + String ( lCptCmdMax ) )
		Else
			This.Uf_Trace ( "ECR", "Attribution des n° de commandes : " + String ( lCptCmdMax - lTotFilt + 1 ) + " à " + String ( lCptCmdMax ) )
		End If

		/*------------------------------------------------------------------*/
		/* Attribution d'un n° de cmde à toutes les lignes chargées pour    */
		/* le produit en cours de traitement                                */
		/*------------------------------------------------------------------*/
		If iRet > 0 Then
			For lCptFilt = 1 To lTotFilt
				lCptCmd = lCptCmdMax - lTotFilt + lCptFilt
				sIdContrAbon = idwFicCharg.GetItemString ( lCptFilt, "ID_CONTRAT_ABONNE" )
				sIdCmdFrn = uf_CalcNumCmde ( lIdProd, sIdContrAbon, lCptCmd )
				idwFicCharg.SetItem ( lCptFilt, "ID_CMD_FRN", sIdCmdFrn )
				idwFicCharg.SetItem ( lCptFilt, "ID_LOT_CMD", ilIdLotCeg )
				idwFicCharg.SetItem ( lCptFilt, "CMD_GEN_LE", dtNow )
				idwFicCharg.SetItem ( lCptFilt, "CMD_GEN_PAR", stGlb.sCodOper )
			Next
		End If

		/*------------------------------------------------------------------*/
		/* Update en base.                                                  */
		/* Les lignes vont être marquées en bases.								  */
		/*------------------------------------------------------------------*/
		If iRet > 0 Then
			If idwFicCharg.Update () > 0 Then
				F_Commit ( SQLCA, True )
				This.Uf_Trace ( "ECR", "Update du marquage réussi, les commandes pour le produit " + String ( lIdProd ) + " sont flaguées en base." )
			Else
				iRet = -1
				F_Commit ( SQLCA, False )
				This.Uf_Trace ( "ECR", "ERREUR, Update du marquage en base a échoué sur le produit " + String ( lIdProd ) + "." )
			End If
		End If
	End If

Next

idwFicCharg.SetFilter ( "" )
idwFicCharg.Filter ()
idwFicCharg.SetSort ( "" )
idwFicCharg.Sort ()

Return iRet

end function

private function integer uf_generer_fichier_cegetel ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_CEGETEL ( PRIVATE )
//* Auteur			: Abdmeziem Catherine
//* Date				: 09/10/02
//* Libellé			: Génération du fichier de commande pour CEGETEL
//* Commentaires	: Un fichier sera généré SAPjjmmi.txt (SAP25101.txt)
//*					  N'EST PLUS UTILISE !!!! FONCTION POUR SAV SI REPRISE DE MUST
//*					  VOIR A PRESENT : uf_Generer_Fichier_CEGETEL2
//* Arguments		: Aucun
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Int		iRet, iNbEnrCeg
String	sEnr, sNbEnr, sChZeros, sSep, sFiltre, sNomFic, sIdLotCeg
Long		lIdLotCeg, lTot, lCpt, lCptArt, lNewRow

iRet = 1
sSep = " "
iNbEnrCeg = 0

/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le CEGETEL                   */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_cegetel"

idwFicGenCmde.Reset ()

/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Ecriture des enregistrements des commandes : chaque ligne        */
/* d'entête de commande est suivie des articles correspondants.     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
lTot = idwFicCharg.RowCount ()

For lCpt = 1 To lTot

	/*------------------------------------------------------------------*/
	/* Ecriture de l'entête de commande                                 */
	/*------------------------------------------------------------------*/
	sEnr = "$"																										  + sSep + &
			 This.uf_FormatChamps ( 10, idwFicCharg.GetItemString ( lCpt, "ID_PROD_CLIENT" ) ) + sSep + &
			 This.uf_FormatChamps ( 30, "SPB"	)							  								  + sSep + &
			 This.uf_FormatChamps ( 30, "AU NOM ET POUR LE CPTE DU GAN"	)							  + sSep + &
			 This.uf_FormatChamps ( 30, "16 RUE MARAIS" )												  + sSep + &
			 This.uf_FormatChamps ( 25, "LE HAVRE CEDEX" )												  + sSep + &
			 This.uf_FormatChamps ( 10, "76095" )															  + sSep + &
			 This.uf_FormatChamps ( 16, "02.32.74.20.67" )												  + sSep + &
			 This.uf_FormatChamps ( 20, idwFicCharg.GetItemString ( lCpt, "ID_CMD_FRN" ) )	  + sSep + &
			 This.uf_FormatChamps ( 10, idwFicCharg.GetItemString ( lCpt, "ID_PROD_CLIENT" ) ) + sSep + &
			 This.uf_FormatChamps ( 30, idwFicCharg.GetItemString ( lCpt, "LIB_COD_CIV" ) + sSep + &
					 	                   idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" )  + sSep + &
			 									 idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) )		  + sSep + &
			 This.uf_FormatChamps ( 30, idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )	  + sSep + &
			 This.uf_FormatChamps ( 30, idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" )	+ sSep + &
			 									 idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		  + sSep + &
			 This.uf_FormatChamps ( 25, idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		  + sSep + &
			 This.uf_FormatChamps ( 10, idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )			  + sSep + &
			 String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "yyyymmdd" )			  + sSep + &
			 This.uf_FormatChamps ( 16, idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" )	)		  + sSep
		 
			 
	lNewRow = idwFicGenCmde.InsertRow ( 0 )
	idwFicGenCmde.SetItem ( lNewRow, "LIGNE", sEnr )

	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/
	/* Ecriture des lignes d'articles                                   */
	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/

	/*------------------------------------------------------------------*/
	/* 1 - écriture de la ligne de l'article de base                    */
	/*------------------------------------------------------------------*/
	sEnr = "*" + sSep + uf_FormatChamps ( 18, idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" ) ) + sSep + "1"
	lNewRow = idwFicGenCmde.InsertRow ( 0 )
	idwFicGenCmde.SetItem ( lNewRow, "LIGNE", sEnr )

	/*------------------------------------------------------------------*/
	/* 2 - Ecriture de l'article lié au code hlr                        */
	/*------------------------------------------------------------------*/
	If Not ( IsNull ( idwFicCharg.GetItemNumber ( lCpt, "ID_HLR" ) ) ) Then
		// Récupération du kit dans det_article
		sFiltre = "ID_FOUR = '" + idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) 		  + "' AND " + &
					 "ID_REF_FOUR = '" + idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" ) + "' AND " + &
					 "ID_TYP_ART = 'KIT' AND " 														  + &
					 "ID_PROD = " + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) )
		idwFicChargArt.SetFilter ( sFiltre )
		idwFicChargArt.Filter ()
		idwFicChargArt.Sort ()
		If idwFicChargArt.RowCount () = 0 Then
			/*------------------------------------------------------------------*/
			/* On n'a pas trouvé le kit avec le produit => on le cherche pour   */
			/* id_prod = -1                                                     */
			/*------------------------------------------------------------------*/
			sFiltre = "ID_FOUR = '" + idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) 		  + "' AND " + &
						 "ID_REF_FOUR = '" + idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" ) + "' AND " + &
						 "ID_TYP_ART = 'KIT' AND " 														  + &
						 "ID_PROD = -1"
			idwFicChargArt.SetFilter ( sFiltre )
			idwFicChargArt.Filter ()
			idwFicChargArt.Sort ()
			If idwFicChargArt.RowCount () <> 0 Then
				/*------------------------------------------------------------------*/
				/* On cherche maintenant l'article lié au kit trouvé                */
				/*------------------------------------------------------------------*/
				sFiltre = "ID_FOUR = '" + idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) 		  + "' AND " + &
							 "ID_HLR = " + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_HLR" ) ) + " AND " + &
							 "ID_KIT = '" + idwFicChargArt.GetItemString ( 1, "ID_ARTICLE") 		  + "'"
				idwFicChargHlr.SetFilter ( sFiltre )
				idwFicChargHlr.Filter ()
				idwFicChargHlr.Sort ()
				If idwFicChargHlr.RowCount () <> 0 Then
					sEnr = "*" + sSep + uf_FormatChamps ( 18, idwFicChargHlr.GetItemString ( 1, "ID_ARTICLE" ) ) + sSep + "1"
					lNewRow = idwFicGenCmde.InsertRow ( 0 )
					idwFicGenCmde.SetItem ( lNewRow, "LIGNE", sEnr )
				End If
			End If
		Else
			/*------------------------------------------------------------------*/
			/* On cherche maintenant l'article lié au kit trouvé                */
			/*------------------------------------------------------------------*/
			sFiltre = "ID_FOUR = '" + idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) 		  + "' AND " + &
						 "ID_HLR = " + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_HLR" ) ) + " AND " + &
						 "ID_KIT = '" + idwFicChargArt.GetItemString ( 1, "ID_ARTICLE") 		  + "'"
			idwFicChargHlr.SetFilter ( sFiltre )
			idwFicChargHlr.Filter ()
			idwFicChargHlr.Sort ()
			If idwFicChargHlr.RowCount () <> 0 Then
				sEnr = "*" + sSep + uf_FormatChamps ( 18, idwFicChargHlr.GetItemString ( 1, "ID_ARTICLE" ) ) + sSep + "1"
				lNewRow = idwFicGenCmde.InsertRow ( 0 )
				idwFicGenCmde.SetItem ( lNewRow, "LIGNE", sEnr )
			End If
		End If
	End If

	/*------------------------------------------------------------------*/
	/* 3 - Ecriture de l'article lié au produit                         */
	/*------------------------------------------------------------------*/
	sFiltre = "ID_FOUR = '" + idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) 		  + "' AND " + &
				 "ID_REF_FOUR = '" + idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" ) + "' AND " + &
				 "ID_TYP_ART = 'ART' AND " 														  + &
				 "ID_PROD = " + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) )
	idwFicChargArt.SetFilter ( sFiltre )
	idwFicChargArt.Filter ()
	idwFicChargArt.Sort ()
	If idwFicChargArt.RowCount () <> 0 Then
		sEnr = "*" + sSep + uf_FormatChamps ( 18, idwFicChargArt.GetItemString ( 1, "ID_ARTICLE" ) ) + sSep + "1"
		lNewRow = idwFicGenCmde.InsertRow ( 0 )
		idwFicGenCmde.SetItem ( lNewRow, "LIGNE", sEnr )
	End If

	/*------------------------------------------------------------------*/
	/* 4 - Ecriture du (ou des) article(s) lié(s) au mobile             */
	/*------------------------------------------------------------------*/
	sFiltre = "ID_FOUR = '" + idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) 		  + "' AND " + &
				 "ID_REF_FOUR = '" + idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" ) + "' AND " + &
				 "ID_TYP_ART = 'ART' AND " 														  + &
				 "ID_PROD = -1"
	idwFicChargArt.SetFilter ( sFiltre )
	idwFicChargArt.Filter ()
	idwFicChargArt.Sort ()
	For lCptArt = 1 To idwFicChargArt.RowCount () 
		sEnr = "*" + sSep + uf_FormatChamps ( 18, idwFicChargArt.GetItemString ( lCptArt, "ID_ARTICLE" ) ) + sSep + "1"
		lNewRow = idwFicGenCmde.InsertRow ( 0 )
		idwFicGenCmde.SetItem ( lNewRow, "LIGNE", sEnr )
	Next

Next

/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Ecriture de l'enregistrement de l'entête de fichier              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
sNbEnr = String ( idwFicGenCmde.RowCount () )
sChZeros = Fill ( "0", 6 - Len ( sNbEnr ) )
sNbEnr = sChZeros + sNbEnr
sIdLotCeg = String ( ilIdLotCeg )
sChZeros = Fill ( "0", 3 - Len ( sIdLotCeg ) )
sEnr = "!SPB " + sNbEnr + sChZeros + sIdLotCeg

lNewRow = idwFicGenCmde.InsertRow ( 1 )
idwFicGenCmde.SetItem ( lNewRow, "LIGNE", sEnr )

/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Récupération du nom de fichier, et génération                    */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
sNomFic = K_FIC5
This.uf_nom_fichier ( sNomFic , 0 )
If sNomFic = "" Then
	iRet = -1
	This.Uf_Trace ( "ECR", "Il y a déjà eu 10 générations aujourd'hui !!" )
Else
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, False )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des commandes généré avec succès sur : " + Upper ( sNomFic ) )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des commandes, le fichier n'est pas généré !!" )
	End If
End If

Return iRet

end function

private subroutine uf_charger_cegetel ();//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gen_Fic_Commande::uf_Charger_Cegetel ( PRIVATE )
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 10/10/2002 12:07:44
//* Libellé       : Formate différentes zones pour que la longueur de la concaténation soit correcte ou cplmt avec des "0"
//* Commentaires  : Modification SFR
//*
//* Arguments     : Aucun
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//* #1	 CAG	 25/11/2002	  Les champs à null deviennent vides
//*-----------------------------------------------------------------

Long			lTot, lCpt, lCptCar, lLongMCiv
String		sAdrCp, sAdrLivrCpl, sAdrTel1, sAdrTelForm
String		sCiv, sNom, sPrenom, sAdrLivr1, sAdrLivr2, sAdrVille

lTot = idwFicCharg.RowCount ()

For lCpt = 1 To lTot


	/*------------------------------------------------------------------*/
	/* Zone civilité + nom + prénom <= 30 caractères                    */
	/*------------------------------------------------------------------*/
	sCiv = idwFicCharg.GetItemString ( lCpt, "LIB_COD_CIV" )
	If IsNull ( sCiv ) Then
	   sCiv = ""
		idwFicCharg.SetItem ( lCpt, "LIB_COD_CIV", sCiv )
	End If
	sNom = idwFicCharg.GetItemString ( lCpt, "ADR_NOM" )
	sPrenom = idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" )
	lLongMCiv = 30 - Len ( sCiv ) - 1
	If ( Len ( sNom ) + Len ( sPrenom ) + 1 ) > lLongMCiv Then
		If Len ( sNom ) > lLongMCiv Then
			sNom = Left ( sNom, lLongMCiv )
			idwFicCharg.SetItem ( lCpt, "ADR_NOM", sNom )
			sPrenom = ""
		Else
			sPrenom = Left ( sPrenom, lLongMCiv - Len ( sNom ) - 1 )
		End If
		idwFicCharg.SetItem ( lCpt, "ADR_PRENOM", sPrenom )
	End If

	
	/*------------------------------------------------------------------*/
	/* Zone adr_livr_cpl <= 30 caractères                               */
	/*------------------------------------------------------------------*/
	sAdrLivrCpl = idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" )
	If IsNull ( sAdrLivrCpl ) Then sAdrLivrCpl = ""
	idwFicCharg.SetItem ( lCpt, "ADR_LIVR_CPL", Left ( sAdrLivrCpl, 30 ) )


	/*------------------------------------------------------------------*/
	/* Zone adr_livr1 + adr_livr2 < 30 caractères                       */
	/*------------------------------------------------------------------*/
	sAdrLivr1 = idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" )
	sAdrLivr2 = idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" )
	If IsNull ( sAdrLivr1 ) Then
	   sAdrLivr1 = ""
		idwFicCharg.SetItem ( lCpt, "ADR_LIVR1", sAdrLivr1 )
	End If
	If IsNull ( sAdrLivr2 ) Then
	   sAdrLivr2 = ""
		idwFicCharg.SetItem ( lCpt, "ADR_LIVR2", sAdrLivr2 )
	End If
	If ( Len ( sAdrLivr1 ) + Len ( sAdrLivr2 ) + 1 ) > 30 Then
		If Len ( sAdrLivr1 ) > 30 Then
			sAdrLivr1 = Left ( sAdrLivr1, 30 )
			idwFicCharg.SetItem ( lCpt, "ADR_LIVR1", sAdrLivr1 )
			sAdrLivr2 = ""
		Else
			sAdrLivr2 = Left ( sAdrLivr2, 30 - Len ( sAdrLivr1 ) - 1 )
		End If
		idwFicCharg.SetItem ( lCpt, "ADR_LIVR2", sAdrLivr2 )
	End If

	
	/*------------------------------------------------------------------*/
	/* Zone adr_ville : 35 car dans commande => tronqué à 25            */
	/*------------------------------------------------------------------*/
	sAdrVille = idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" )
	sAdrVille = Left ( sAdrVille, 25 )
	idwFicCharg.SetItem ( lCpt, "ADR_VILLE", sAdrVille )

	/*------------------------------------------------------------------*/
	/* Zone adr_cp : comblé avec un "0" si nécessaire                   */
	/*------------------------------------------------------------------*/
	sAdrCp = idwFicCharg.GetItemString ( lCpt, "ADR_CP" )
	If Len ( sAdrCp ) = 4 Then
		idwFicCharg.SetItem ( lCpt, "ADR_CP", "0" + sAdrCp )
	End If

	/*------------------------------------------------------------------*/
	/* Zone adr_tel1 : sans espace ni autre caractère que des chiffres  */
	/*                 20 car dans w_commande => tronqué à 16           */
	/*------------------------------------------------------------------*/
	sAdrTel1 = idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" )
	sAdrTelForm = sAdrTel1
	If Not Match ( sAdrTel1, "^[0-9]+$" ) Then
		sAdrTelForm = ""
		For lCptCar = 1 To Len ( sAdrTel1 )
			If Match ( Mid ( sAdrTel1, lCptCar, 1 ), "^[0-9]$" ) Then
				sAdrTelForm = sAdrTelForm + Mid ( sAdrTel1, lCptCar, 1 )
			End If
		Next
	End If
	sAdrTelForm = Left ( sAdrTelForm, 16 )
	idwFicCharg.SetItem ( lCpt, "ADR_TEL1", sAdrTelForm )
	
Next
end subroutine

private function string uf_calcnumcmde (long alidprod, string asidcontrabon, long alcptcmd);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gen_Fic_Commande::uf_CalcNumCmde ( PRIVATE )
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 09/10/2002 15:22:57
//* Libellé       : Calcul du numéro d'une commande CEGETEL
//* Commentaires  : Modification SFR
//*
//* Arguments     : ( Val )	Long		alIdProd			:	Id_prod
//*					  ( Val )	String	asIdContrAbon	:	Id_Contrat_Abonne		vient de w_sin/sinistre
//*					  ( Val )	Long		alCptCmd			:	CptCmd incrémenté dans produit
//*
//* Retourne      : String		Id_Cmd_Frn
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   30/06/2003   Suite mémo de D. Talmat et Marina Salvatore, 
//*								  le numéro de commande de MUST sera identique à celui
//*								  de M.Protect excepté le "FR00" et les compteurs qui restent 
//*								  différents.
//*
//*-----------------------------------------------------------------

String	sId_Cmd_Frn, sCptCmd, sChZeros

Choose Case alIdProd

	/*------------------------------------------------------------------*/
	/* Produit : 5712                                                   */
	/* #1																					  */
	/*------------------------------------------------------------------*/
	Case 5712
		sId_Cmd_Frn = asIdContrAbon + "FR00/"

	/*------------------------------------------------------------------*/
	/* Produits autres (en vue de Mobile Protect)                       */
	/* Le n° Scs est compris dans Id_Contrat_Abonne                     */
	/*------------------------------------------------------------------*/
	Case Else
		sId_Cmd_Frn = asIdContrAbon + "PR00/"

End Choose

sCptCmd = String ( alCptCmd )
sChZeros = Fill ( "0", 7 - Len ( sCptCmd ) )
sId_Cmd_Frn = sId_Cmd_Frn + sChZeros + sCptCmd

Return sId_Cmd_Frn

end function

private function string uf_formatchamps (integer ainbcar, string aschamp);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gen_Fic_Commande::uf_FormatChamps ( PRIVATE )
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 10/10/2002 17:06:05
//* Libellé       : Ajoute les espaces nécessaires pour que la chaîne retournée fasse la longueur voulue
//* Commentaires  : Modification SFR
//*
//* Arguments     : ( Val )	Integer	aiNbCar	:	Longueur de la chaîne à retourner
//*					  ( Val )	String	asChamp	:	Chaîne à traiter
//*
//* Retourne      : String	:	chaîne formatée à la longueur voulue
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String	sRet

If IsNull ( asChamp ) Then asChamp = ""

sRet = asChamp + Fill ( " ", aiNbCar - Len ( asChamp ) )

Return sRet
end function

private function integer uf_flaguer_commandes (ref long alidlotcmd, string asidfourn);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Flaguer_Commandes (PRIVATE)
//* Auteur			: Abdmeziem	Catherine
//* Date				: 15/10/02
//* Libellé			: En fonction du fournisseur, on lance la fonction uf_Flaguer_Commandes_FOURNISSEUR
//*					  
//* Commentaires	: 
//*
//* Arguments		: alIdLotCmd	long		Ref
//*					  asIdFourn		String	Val
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 10/09/04	  DCMP 040381 : Ajout du frn MSS
//* #2	 MADM	 06/02/06	  [DCMP060119]: Ajout du frn AEVUM/AVM
//* #3	 MADM	 07/03/06	  [DCMP060198]: Ajout du frn BRIGHTPOINT/BTP
//* #4	 MADM	 09/05/06	  [DCMP060356]: Rempl du frn AEVUM/AVM par CORDON/COR
//* #5	 JFF   18/09/2007   [ALAPAGE]
//* #6	 PHG	 27/11/2007	  [OM2]		  : Ajout du frn O2M
//* #7    JFF   05/09/08 	  [MICROMANIA]
//* #8    JFF   16/04/2009   [DCMP090102]
//* #9    JFF   16/04/2009   [DCMP090140]
//* #10   JFF   05/05/2009   [RUEDUCOMMERCE]
//* #11   JFF   02/09/2009   [DCMP090327].[SBETV]
//* #12   JFF   27/10/2009   [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
//* #13   JFF   25/11/2009   [MSS_DIAG]
//*       JFF   30/06/2010   [PC363_AUCHAN]
//* 		 JFF   04/11/2010   [PC301].[LOT2]
//* 		 JFF     03/05/2011 [PM178][CORIOLIS]
// 		 JFF   13/02/2012   [PM200][PSM]
//			FPI	22/08/2012	[PC767] Ajout de ORE
//			FPI	16/10/2012	 [PC884] Ajout LBE
//			FPI	24/07/2013	[PC767-1] ORE
//       JFF   30/12/2013 [PC13348&13408]
//			FPI	24/02/2014	[PC925]
//       JFF   12/12/2014 [PC13321]
//       JFF   11/10/2016 [DT076-2]
//		   FPI	28/03/2018	[DT339]
//       JFF   02/09/2019 [DT424]
//       JFF   30/05/2023 [PMO89_RS4822]
//       JFF   12/06/2023 [RS-5297-HP-178]
//*-----------------------------------------------------------------

Int iRet 

iRet = 1

	Choose Case asIdFourn
		/*------------------------------------------------------------------*/
		/* Fournisseur : CEGETEL                                            */
		/*------------------------------------------------------------------*/
		Case "CEG"
			// 2 compteur pour CEGETEL, un cpt CEG, un cpt SPB

			If uf_Flaguer_Commandes_Cegetel2 ( ) <= 0 Then 
				iRet = -1
				This.uf_Sortie_OpCon ( "ECR", 550, "ERR550/FLGCMDCEG", FALSE )
			End If

			If uf_Flaguer_Commandes_standard ( alIdLotCmd ) <= 0 Then
				iRet = -1
				This.uf_Sortie_OpCon ( "ECR", 551, "ERR5501FLGCMDCEG", FALSE )
			End If

		/*------------------------------------------------------------------*/
		/* Fournisseurs ORANGE/DME                                          */
		/* Fournisseurs FRANCE TEL/FTT                                      */
		/*------------------------------------------------------------------*/
		/* #1 CAG : 10/09/2004                                              */
		/* Fournisseurs MSS				                                      */
		/*------------------------------------------------------------------*/
      /* #2 MADM : 06/02/2006  [DCMP060119]										  */
      /* Fournisseurs AVM																  */
		/* #3	 MADM	 07/03/06	  [DCMP060198]										  */
		/* Fournisseur BRIGHTPOINT/BTP												  */
		/* #4 MADM : 09/05/2006 [DCMP060356]										  */
		/*	Remplacement du Fournisseurs AVM par CORDON/COR						  */
		/* #5 ALAPAGE																		  */
		/* #6 [O2M]																			  */
		/* #7 JFF 05/09/08  [MICROMANIA]												  */
		/* #8    JFF   16/04/2009   [DCMP090102]									  */
	   /* #9    JFF   16/04/2009   [DCMP090140]									  */
		/* #10   JFF   05/05/2009   [RUEDUCOMMERCE]								  */
		/* #11   JFF   02/09/2009   [DCMP090327].[SBETV]						  */
		/* #13   JFF   25/11/2009   [MSS_DIAG]										  */
		/* [PC363_AUCHAN]																	  */
		// [PC884] - LBE
   	// [PC874] - OMT
   	// [PC925] - SRR
		// [PC13321]
		// [DT076-2]
      /*------------------------------------------------------------------*/ 
		Case "DME", "SBE", "MSS", "CDS" , "COR" , &
			  "O2M", "MCM", "CDP", "PAP", "RDC", "SB1", "MS1", "AUC", "CAR",  "CIS", "PSM","ORE", "LBE",&
			  "OMT", "VPP", "MTT", "SRR", "ELD", "TMT", "BK2", "CEA", "AGP", "OGP", "OOP", "TLS", "CDF"

			If uf_Flaguer_Commandes_standard ( alIdLotCmd ) <= 0 Then
				iRet = -1
				This.uf_Sortie_OpCon ( "ECR", 560, "ERR560/FLGCMDSTD", FALSE )
			End If

		/*------------------------------------------------------------------*/
		/* Fournisseurs FNAC																  */
		/*------------------------------------------------------------------*/
		// #12 [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]		
		Case "FNC"
			If uf_Flaguer_Commandes_Fnac ( ) <= 0 Then
				iRet = -1
				This.uf_Sortie_OpCon ( "ECR", 562, "ERR562/FLGCMDFNC", FALSE )
			End If

		// [DT339]
		Case "CMA"
			If uf_Flaguer_Commandes_Carma ( alIdLotCmd ) <= 0 Then 
				iRet = -1
				This.uf_Sortie_OpCon ( "ECR", 560, "ERR560/FLGCMDCMA", FALSE )
			End if

		// [RS-5297-HP-178]
		Case "IFR"
			// Rien à faire pour ce cas

		/*------------------------------------------------------------------*/
		/* Pas de fournisseur déclaré pour généré le fichier.					  */
		/*------------------------------------------------------------------*/
		Case ELSE
			iRet = -1
			This.Uf_Trace ( "ECR", "ERREUR : Pas de fournisseur déclaré pour la génération du fichier de commande !!" )
			This.uf_Sortie_OpCon ( "ECR", 570, "ERR570/FLGCMDINC", FALSE )

	End Choose

Return iRet

end function

private subroutine uf_nom_fichier (ref string asnomfic, long alcas);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Nom_Fichier (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 09/10/2001
//* Libellé			: Génération d'un nom de fichier
//* Commentaires	: 
//*
//* Arguments		: asNomFic		String		(Ref)
//*					  alCas			Long			(Val)	:	distingue le cas du produit 5712 pour les prestations (cf MAJ ci-dessous)
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    30/08/2002  Le nom du répertoire de génération n'est plus le code
//*								  du fournisseur -FR mais le nom complet (<8 car) -FL
//*
//* #2	 CAG	  16/10/2002  Modif SFR Préférence : si le fournisseur est Cegetel, nom du fichier = "SAPJJMM.TXT"
//* #4	 CAG	  30/10/2002  								 suite aux tests de JFF, on ajoute un n° d'index
//*
//* #3	 CAG	  17/10/2002  Pour les prestations dont le produit est 5712 ( les cmds sont uniquement pour Cegetel)
//*								  on ajoute un répertoire entre le nom fournisseur et le répertoire fic_cmd du nom du produit
//*								  annexe 7 (6.7.2) dans l'analyse de l'intégration SFR pref
//*
//* #4	 CAG	  16/09/2004  DCMP 040381 : Ajout du frn MSS
//* #5    MADM   06/02/2006  [DCMP060119]: Ajout du frn AEVUM/AVM 
//* #6    MADM   07/03/2006  [DCMP060198]: Ajout du frn BRIGHTPOINT/BTP
//* #7    MADM   09/05/2006  [DCMP060356]: Rempl du frn AEVUM/AVM par CORDON/COR
//* #8	 JFF    18/09/2007  [ALAPAGE]
//* #9	 PHG	  27/11/2007  [O2M]		  : Ajout du Frn O2M
//* #10   JFF    05/09/08 	  [MICROMANIA]
//* #11   JFF    16/04/2009  [DCMP090102]
//* #12   JFF    16/04/2009  [DCMP090140]
//* #13   JFF    05/05/2009  [RUEDUCOMMERCE]
//* #14   JFF    05/05/2009  [DCMP090327].[SBETV]
//* #15   JFF    05/05/2009  [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
//* #16   JFF    25/11/2009  [MSS_DIAG]
//* #17   JFF    17/12/2009  [20091217104711950]
//*       JFF    30/06/2010  [PC363_AUCHAN]
//* 		 JFF    04/11/2010  [PC301].[LOT2]
//*       JFF    22/02/2011  [PC363_AUC].[ECL_FICH]
//* 		 JFF    03/05/2011  [PM178][CORIOLIS]
//* 		 JFF    13/02/2012  [PM200][PSM]
//			FPI	22/08/2012	[PC767] Ajout de ORE
//			FPI	16/10/2012	 [PC884] Ajout LBE
//			FPI	22/11/2012	 [PC874] Ajout OMT
//       JFF   02/04/2013   [PC929_CDISCOUNT] VPP
//			FPI	24/07/2013 [PC767-1]
//       JFF   26/08/2013 [DT57_CMDE_IPHONE_SFR]
//       JFF   30/12/2013 [PC13348&13408]
//       JFF   12/12/2014 [PC13321] "ELD"
//       JFF   02/03/2015 [PM289_CDP]
//       JFF   11/10/2016 [DT076-2]
//       JFF   03/09/2018 [DT361]
//       JFF   17/09/2018 [PM444-1]
//       JFF   26/11/2018 [PC874_2_V1]
//       JFF   02/09/2019 [DT424]
//       JFF   30/05/2023 [PMO89_RS4822]
//       JFF   07/05/2013 [RS5295_NOMFIC_OMT]
//       JFF   12/06/2023 [RS-5297-HP-178]
//       JFF   18/02/2025 [PMO268_MIG65]
//*-----------------------------------------------------------------

String	sRepFic, sFichier, sFichierRen, sInd, sIdFourn, sNomFic, sRepfourn, sNomVariable, sExt
Long		lInd, lRow
Boolean  bFicTrouve

sRepFourn = ""

CHOOSE CASE isTypTrt
	CASE "G"
		sIdFourn = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
	CASE "R"
		sIdFourn = idwFicCharg.GetItemString ( 1, "ID_FOUR" )
END CHOOSE

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
lRow = idwStkRepFourn.Find ( "ID_CODE = '" + sIdFourn + "'", 1, idwStkRepFourn.RowCount () )
If lRow > 0 Then
	sRepFourn = Upper ( idwStkRepFourn.GetItemString ( lRow, "LIB_CODE" ) )
Else
	// sRepFourn restera à vide et l'écriture du fichier renverra de génération
   // dans le log.
End If

sRepFic =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_GEN", "" ) + sRepFourn

/*------------------------------------------------------------------*/
/* #3                                                               */
/*------------------------------------------------------------------*/
sRepFic = sRepFic + ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_FIC_CMD", "" )

Choose Case sIdFourn
/*-------------------------------------------------------------------*/
/* #5    MADM  06/02/2006  [DCMP060119]: Ajout du frn AVM            */
/* #6    MADM  07/03/2006  [DCMP060198]: Ajout du frn BRIGHTPOINT/BTP*/
/* #7    MADM   09/05/2006  [DCMP060356]: Rempl du frn AEVUM/AVM par CORDON/COR*/
/* #8    ALPAGE																		*/
/* #9		PHG	27/11/2007	[O2M]			: Ajout du frn O2M            */
/* #10   JFF   05/09/08 	[MICROMANIA]										*/
/* #11   JFF   16/04/2009   [DCMP090102]										*/
/* #12   JFF    16/04/2009  [DCMP090140]										*/
/* #14   JFF    05/05/2009  [DCMP090327].[SBETV]							*/
/* #15   JFF    05/05/2009  [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767] */
/* #16   JFF    25/11/2009  [MSS_DIAG]                               */
/* [PC363_AUCHAN]																		*/
// [PC874]
// [DT076-2]
/*-------------------------------------------------------------------*/

	Case  "DME", "SBE", "MSS", "CDS" , "COR", "CEA", "AGP", &
			"O2M", "CDP", "PAP", "SB1", "FNC", "MS1", "CIS", "PSM", "BLC","OMT", "MTT", "TMT", "BK2",&
			"OOP", "OGP", "TLS", "CDF"

		Choose Case sIdFourn 
			Case "CDS" 
				sNomFic = asNomFic + &
					 Right  ( String ( Year  ( Today () ) ), 1 )+ &
					 String ( Month  ( Today () ), "00" ) + &
					 String ( Day    ( Today () ), "00" )

			// #16 JFF 25/11/2009  [MSS_DIAG]
			Case "MS1"
				
				// Attitude
				If alCas = 1 Then
					sNomFic = asNomFic + "_MSS_" + &
						 String ( Day    ( Today () ), "00" ) + &
						 String ( Month  ( Today () ), "00" ) + &
						 Right  ( String ( Year  ( Today () ) ), 1 )

				// MSS
				Else
					sNomFic = asNomFic + "_ATT_" + &
						 String ( Day    ( Today () ), "00" ) + &
						 String ( Month  ( Today () ), "00" ) + &
						 Right  ( String ( Year  ( Today () ) ), 1 )
				End If
		
			Case "CDP"
				// [PM289_CDP]
				sNomVariable = "Dropshipment" 
				sExt = ".xlsx"
				
				sFichier = sRepFic + sNomVariable + sExt

			// [PC874_2_V1]
			Case "OMT"
				
				// 1 = Cas des ctrle Imei
				If alCas = 1 Then
					sNomFic = asNomFic + &
						 String ( Year   ( Today () ) ) + &
						 String ( Month  ( Today () ), "00" ) + &
						 String ( Day    ( Today () ), "00" ) 
				Else
					
					// [RS5295_NOMFIC_OMT]
					sNomFic = asNomFic + &
						 String ( Day    ( Today () ), "00" ) + &
						 String ( Month  ( Today () ), "00" ) + &
						 String ( Year  ( Today () ) )
					
				End If 

			// [DT424]
			Case "OOP", "OGP"
					sNomFic = asNomFic + &
						 String ( Year   ( Today () ) ) + &
						 String ( Month  ( Today () ), "00" ) + &
						 String ( Day    ( Today () ), "00" ) 
						 
					sNomFic = F_Remplace ( sNomFic, "[FOUR]", sIdFourn ) 
				

			Case Else 
				sNomFic = asNomFic + &
					 String ( Day    ( Today () ), "00" ) + &
					 String ( Month  ( Today () ), "00" ) + &
					 Right  ( String ( Year  ( Today () ) ), 1 )

		End Choose
		
		lInd = 0				
		bFicTrouve = True

		// [PM289_CDP]
		If sIdFourn = "CDP" Then lInd = 60

		Do While bFicTrouve And lInd <= 50

			lInd++
			sFichier = sRepFic + sNomFic + "." + String ( lInd, "000" )

			//* #17 [20091217104711950]
			If sIdFourn = "FNC" Then
				sFichierRen = sRepFic + sNomFic + "." + String ( lInd, "000" )	+ "X"
			Else			
				sFichierRen = sRepFic + sNomFic + ".X" + String ( lInd, "00" )	
			End If
			//* :#17 [20091217104711950]			

			bFicTrouve = f_FileExists ( sFichier ) 
			
			If Not bFicTrouve Then bFicTrouve = f_FileExists ( sFichierRen ) 
			
		Loop

	Case "CEG"
		sNomFic = asNomFic + &
					 String ( Day    ( Today () ), "00" ) + &
					 String ( Month  ( Today () ), "00" )
		/*------------------------------------------------------------------*/
		/* #4                                                               */
		/*------------------------------------------------------------------*/
		
		lInd = 0
		
		bFicTrouve = TRUE
		Do While bFicTrouve And lInd <= 9
			sFichier = sRepFic + sNomFic + String ( lInd ) + ".TXT"

//Migration PB8-WYNIWYG-03/2006 CP			
//			bFicTrouve = FileExists ( sFichier ) 
			bFicTrouve = f_FileExists ( sFichier ) 
//Fin Migration PB8-WYNIWYG-03/2006 CP	

			lInd ++
		Loop
		If bFicTrouve And lInd = 10 Then
			sFichier = ""
		End If

//* #10 [MICROMANIA]
	Case "MCM"
		
		// Nom du fichier : sinistresAAAAMMJJ
		// Format du fichier : .txt avec comme séparateur de zone une tabulation
		
		sNomFic = "sinistres" + &
					  String ( year    ( Today () ), "0000" ) + &
					  String ( Month  ( Today () ), "00" ) + &
					  String ( Day    ( Today () ), "00" ) + ".TXT"
		
		sFichier = sRepFic + sNomFic

		
//* #13 [RUEDUCOMMERCE]
// [PC363_AUCHAN]
// [PC301].[LOT2]
	Case "RDC", "AUC", "CAR", "CMA", "VPP" // [PC13448].MEP : supprimer VPP
		
		Choose Case sIdFourn 
			Case "RDC"
				sNomVariable = "Commandes_" 
				sExt = ".XLS"
			Case "AUC"
				// [PC363_AUC].[ECL_FICH]
				// sNomVariable = "[PRODUIT]Bons_Cadeaux_" 

				// [PMO268_MIG65]				
				sNomVariable = "Remboursements_SPB_" 
				
				sExt = ".XLS"				
			Case "CAR"
				sNomVariable = "Commande_Carrefour_" 
				sExt = ".XLS"				
			Case "CMA"
				sNomVariable = "Commande_BA_Carma_" 				
				sExt = ".XLS"				

			Case "VPP"
				 // [PC13448]
				sNomVariable = "SER_SPB_" 				
				sExt = ".csv"
				 // :[PC13448]
				
		End choose
		
		bFicTrouve = TRUE
		
		Do While bFicTrouve 

			Choose Case sIdFourn 
					
				Case "AUC" 		// [PMO268_MIG65]				
					sNomFic = sNomVariable + &
					  String ( year    ( Today () ), "0000" ) + &
					  String ( Month  ( Today () ), "00" ) + &
					  String ( Day    ( Today () ), "00" ) + &
					  "_" + &
					  String ( Now(), "hhmmss")					
					  
				Case Else

					sNomFic = sNomVariable + &
					  String ( year    ( Today () ), "0000" ) + &
					  String ( Month  ( Today () ), "00" ) + &
					  String ( Day    ( Today () ), "00" ) + &
					  String ( Now(), "hhmmss")
			End Choose 			
			
			sFichier = sRepFic + sNomFic + sExt
			
			bFicTrouve = f_FileExists ( sFichier ) 
		Loop

	// [PC13321]
	Case "ELD"
		sNomVariable = "ED_SPB_GAR_BA_" 				
		sExt = ".csv"	
		
		bFicTrouve = TRUE
		
		Do While bFicTrouve 

			sNomFic = sNomVariable + &
			  String ( year    ( Today () ), "0000" ) + &
			  String ( Month  ( Today () ), "00" ) + &
			  String ( Day    ( Today () ), "00" ) + "_" + &
			  String ( Now(), "hhmmss")
			
			sFichier = sRepFic + sNomFic + sExt
			
			bFicTrouve = f_FileExists ( sFichier ) 
		Loop		

	// [PC884]
	Case "LBE"
		sNomFic = asNomFic + &
					 String ( Day    ( Today () ), "00" ) + &
					 String ( Month  ( Today () ), "00" ) + &
					 String ( Year  ( Today () ), "0000" )  + "_"
		/*------------------------------------------------------------------*/
		/* #4                                                               */
		/*------------------------------------------------------------------*/
		lInd = 0
		bFicTrouve = TRUE
		Do While bFicTrouve And lInd <= 9
			sFichier = sRepFic + sNomFic + String ( lInd ) + ".XML"

			bFicTrouve = f_FileExists ( sFichier ) 

			lInd ++
		Loop
		
		If bFicTrouve And lInd = 10 Then
			sFichier = ""
		End If
	
	// [PC767-1]
	CASE "ORE"
		sNomFic = asNomFic + &
					 String ( Day    ( Today () ), "00" ) + &
					 String ( Month  ( Today () ), "00" ) + &
					 String ( Year  ( Today () ), "0000" )  
		sFichier = sRepFic + sNomFic + ".XLS"

		bFicTrouve = f_FileExists ( sFichier ) 

		If bFicTrouve Then
			lInd = 0
			bFicTrouve = TRUE
			sNomFic+="_"
			Do While bFicTrouve And lInd <= 9
				sFichier = sRepFic + sNomFic + String ( lInd ) + ".XLS"

				bFicTrouve = f_FileExists ( sFichier ) 
	
				lInd ++
			Loop
		End if
		
		If bFicTrouve And lInd = 10 Then
			sFichier = ""
		End If

	// [RS-5297-HP-178]
	CASE "IFR"	

		sNomVariable = "REFENTIEL_SPB_1_"

		sNomFic = sNomVariable + &
		  String ( year    ( Today () ), "0000" ) + &
		  String ( Month  ( Today () ), "00" ) + &
		  String ( Day    ( Today () ), "00" ) + &
		  String ( Now(), "hhmmss")
		
		sFichier = sRepFic + sNomFic + ".TXT"
	
		
	/*------------------------------------------------------------------*/
	/* Pas de fournisseur déclaré pour généré le fichier.					  */
	/*------------------------------------------------------------------*/
	Case ELSE
		This.Uf_Trace ( "ECR", "ERREUR : Pas de fournisseur déclaré pour la génération du fichier de commande !!" )

End Choose


asNomFic = sFichier

end subroutine

private function integer uf_sortie_opcon (string ascas, integer aicodeerreur, string astexte, boolean abbox);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_in_fic_SuiviCmd::uf_Sortie_OpCon (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 16/12/2002
//* Libellé			: Fichier de sortie des erreurs pour OpCon
//* Commentaires	: 
//*
//* Arguments		: asCas			String		Val
//*					  aiCodeErreur	Integer		Val
//*					  asTexte		String		Val
//*					  abBox			Boolean		Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    JFF    05/04/2006  ajout du "+ K_FIC_SORTIE_OPCON" derrière isRepFicOpcon  
//* 
//*-----------------------------------------------------------------

Int	iRet, iFicOpcon
String sMes
Long	lRow


/*------------------------------------------------------------------*/
/* Fichier de sortie Erreur pour OpCon                              */
/*------------------------------------------------------------------*/

CHOOSE CASE Upper ( asCas )

	CASE "INIT"

		isRepFicOpcon =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "OPCON_OUT", &
							  ProfileString ( stGlb.sWinDir + "\MAJPOST.INI", "PARAM", "DESTINATION", "C:" ) + "\" )
		iRet = 1

//Migration PB8-WYNIWYG-03/2006 CP
//		If FileExists ( isRepFicOpcon ) Then 
		If f_FileExists ( isRepFicOpcon + K_FIC_SORTIE_OPCON) Then 			// #1
//Fin Migration PB8-WYNIWYG-03/2006 CP			
			
			If Not FileDelete ( isRepFicOpcon + K_FIC_SORTIE_OPCON) Then // #1
				iRet = -1
			End If 
		End If 

	CASE "ECR"

		/*------------------------------------------------------------------*/
		/* On est connecté avec OpCon, donc sortie en fichier Erreur.       */
		/*------------------------------------------------------------------*/
		If gbOpCon Then 

			iFicOpcon = FileOpen ( isRepFicOpCon  + K_FIC_SORTIE_OPCON, LineMode!, Write!, Shared!, Append! )
			FileWrite ( iFicOpcon, String ( aiCodeErreur ) + "|" + asTexte )
			FileClose ( iFicOpcon )

		/*------------------------------------------------------------------*/
		/* Sinon Mes Box sur Demande                                        */
		/*------------------------------------------------------------------*/
		ElseIf abBox Then
			
			F_Message ( stMessage )

		End If

			

END CHOOSE



Return iRet
end function

public function integer uf_trt_opcon (string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Trt_OpCon (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 16/12/2002
//* Libellé			: Traitement de certaines partie en Automatique
//* Commentaires	: 
//*
//* Arguments		: asCas			String		Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Int iRet, iFicFinTrt 
Long	lTotFour, lCptFour

iRet = 1

Choose Case Upper ( asCas )

	Case "LANCER"

		lTotFour = UpperBound ( isTabFrIntGen )

		/*------------------------------------------------------------------*/
		/* Compte de fournisseur                                            */
		/*------------------------------------------------------------------*/
		For lCptFour = 1 To lTotFour

			/*------------------------------------------------------------------*/
			/* On Force le fournisseur.                                         */
			/*------------------------------------------------------------------*/
			idwFourn.SetItem ( 1, "ID_FOURN", isTabFrIntGen [ lCptFour ] ) 
		
			iRet = This.uf_Lancer_Trt ()

			If iRet < 0 Then Exit

		Next

	Case "FIN_TRT"

			iFicFinTrt = FileOpen ( isRepFicOpCon + K_FICFINTRT, LineMode!, Write!, Shared!, Replace! )
			FileClose ( iFicFinTrt )

End Choose


Return iRet

end function

private function integer uf_flaguer_commandes_standard (ref long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Flaguer_Commandes_Standard (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libellé			: On marque en bases es commandes chargées commé étant générées
//*					  elle ne pouraient être par la suite que regénérées avant la fonction adéquat.
//* Commentaires	: Utilisé pour tout fournisseur standard SPB
//*
//* Arguments		: alIdLotCmd	long		Ref
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Int iRet 
Long	lIdLotCmde, lTot, lCpt
DateTime	dtNow

iRet = 1
dtNow = DateTime ( Today (), Now () )


/*------------------------------------------------------------------*/
/* Récupération d'un n° de lot de commandes.                        */
/*------------------------------------------------------------------*/
lIdLotCmde = -1
SQLCA.PS_S03_COMMANDE ( "ID_LOT_CMD", lIdLotCmde )

If lIdLotCmde <= 0 Or IsNull ( lIdLotCmde ) Then

	// RollBack immédiat.
	F_Commit ( SQLCA, False )
	iRet = -1
	This.Uf_Trace ( "ECR", "ERREUR lors de la récupération de l'ID_LOT_CMD, " + String ( lIdLotCmde ) )
Else
	This.Uf_Trace ( "ECR", "Attribution du n° de lot de commandes : " + String ( lIdLotCmde ) )
End If


// [ITSM178659]
F_COMMIT ( SQLCA, SQLCA.SQLCODE = 0 Or SQLCA.SQLDBCODE = 0  ) 

/*------------------------------------------------------------------*/
/* Attribution du n° de lot à toutes les lignes chargées.           */
/*------------------------------------------------------------------*/
If iRet > 0 Then
	lTot = idwFicCharg.RowCount ()
	For lCpt = 1 To lTot
		idwFicCharg.SetItem ( lCpt, "ID_LOT_CMD", lIdLotCmde )
		idwFicCharg.SetItem ( lCpt, "CMD_GEN_LE", dtNow )
		idwFicCharg.SetItem ( lCpt, "CMD_GEN_PAR", stGlb.sCodOper )
	Next

	/*------------------------------------------------------------------*/
	/* Update en base.                                                  */
	/* Les lignes vont être marquées en bases.								  */
	/*------------------------------------------------------------------*/
	If idwFicCharg.Update () > 0 Then
		F_Commit ( SQLCA, True )
		This.Uf_Trace ( "ECR", "Update du marquage réussi, les commandes sont flaguées en base." )
		alIdLotCmd = lIdLotCmde
	Else
		iRet = -1
		F_Commit ( SQLCA, False )
		This.Uf_Trace ( "ECR", "ERREUR, Update du marquage en base a échoué." )
		alIdLotCmd = -1
	End if
End If


Return iRet

end function

private function integer uf_generer_fichier_dme (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_DME (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/04/2003
//* Libellé			: Génération du fichier de commande pour le DME
//* Commentaires	: Trois fichiers seront générés dans le même répertoires :
//*					  un pour les commandes   : CMDjjmma.ind  (CMD10091.001)
//*					  un pour les prestations : PRSjjmma.ind  (PRS10091.001)
//*					  un pour les annulations : ANNjjmma.ind  (ANN10091.001)
//*
//*					DME souhaite avoir la ligne d'entete.
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 17/10/2002	  Modification SFR : Pour ce produit (5712), on
//*								  crée un fichier supplémentaire pour chaque type (cmd, prs, annul ...)
//*								  et on les écrit dans un répertoire spécifique
//*								  Annexe 7 (6.7.2) dans l'intégration de SFR, analyse des traitements
//* #2	 CAG	 06/05/2003	  Génération d'un fichier vide qd pas de cmdes
//*       JFF   22/06/2011   [VDOC4513]
//        JFF   15/09/2015   [DT169]
// 		 JFF   21/06/2018   [VDOC26276]
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sVal
Decimal {1} dcTvaParDefaut 

iRet = 1
dcTvaParDefaut = 20

/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le DME                   	  */
/*------------------------------------------------------------------*/
// [DT169]
/*
If F_C_L_E_A_TRUE ( "DT169" ) Then
	idwFicGenCmde.DataObject = "d_trt_fichier_cmde_DME_DT169"
Else */
	idwFicGenCmde.DataObject = "d_trt_fichier_cmde_DME"
// End If

For lCptCas = 1 To 4
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC1
			sTypArt = "commandes"
			sTypArtNul = "commande"
			sAction = "A_COMMANDER"
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )

		/*------------------------------------------------------------------*/
		/* Génération du fichier de PRESTATIONS (PRS)                       */
		/*------------------------------------------------------------------*/
		CASE 2
			sFiltre = "ID_TYP_ART = 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC2
			sTypArt = "prestations"
			sTypArtNul = "prestation"
			sAction = "A_REPARER"
			This.Uf_Trace ( "ECR", "Génération du fichier de PRESTATIONS en cours..." )

		/*------------------------------------------------------------------*/
		/* Génération du fichier des ANNULATION des COMMANDES (ACD)			  */
		/*------------------------------------------------------------------*/
		CASE 3
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT = 'ANN'"
			sNomFic = K_FIC3
			sTypArt = "annulations de commandes"
			sTypArtNul = "annulation de commandes"
			sAction = "A_ANNULER"
			This.Uf_Trace ( "ECR", "Génération du fichier d'ANNULATIONS DES COMMANDES en cours..." )

		/*------------------------------------------------------------------*/
		/* Génération du fichier des ANNULATION des COMMANDES (APR)			  */
		/*------------------------------------------------------------------*/
		CASE 4
			sFiltre = "ID_TYP_ART = 'PRS' AND COD_ETAT = 'ANN'"
			sNomFic = K_FIC4
			sTypArt = "annulations de prestations"
			sTypArtNul = "annulation de prestations"
			sAction = "A ANNULER"
			This.Uf_Trace ( "ECR", "Génération du fichier d'ANNULATIONS DES PRESTATIONS en cours..." )


	END CHOOSE

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* On ne génére un fichier vide que pour les commandes.             */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM",				idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) )
		idwFicGenCmde.SetItem ( lRow, "PRENOM",			idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) ) 
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR_CPL",	idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		

		// [VDOC4513]
		sVal = idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" )
		If IsNull ( sVal ) Or Len ( Trim ( sVal ) ) = 0 Then
			idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "NUM_PORT" ) )					
		Else
			idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			sVal )		
		End If

		sVal = idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" )
		If IsNull ( sVal ) Or Len ( Trim ( sVal ) ) = 0 Then
			idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "NUM_PORT" ) )					
		Else
			idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			sVal )		
		End If
		
		sVal = idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" )
		If IsNull ( sVal ) Or Len ( Trim ( sVal ) ) = 0 Then
			idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "NUM_PORT" ) )					
		Else
			idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			sVal )		
		End If
		// :[VDOC4513]		
		
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ) )			
		idwFicGenCmde.SetItem ( lRow, "TYP_ART",			idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" ) )			
		idwFicGenCmde.SetItem ( lRow, "MARQ_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "NOM_GEST" ) )						
		idwFicGenCmde.SetItem ( lRow, "ACTION",			sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "ID_GTI",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )				
		idwFicGenCmde.SetItem ( lRow, "ID_REF_FOUR",		idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" ) ) 				

		// [DT169]
/*		
		If F_C_L_E_A_TRUE ( "DT169" ) Then
			idwFicGenCmde.SetItem ( lRow, "MT_HT_CMDE",		String ( Dec(idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE"  )) / ( 1 + dcTvaParDefaut / 100 ), "#,##0.00" ) )
		End If
*/

	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, TRUE )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )

		// [VDOC26276]
		This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic ) 
		
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_sbe (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_SBE (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 25/06/2015
//* Libellé			: Génération du fichier de commande pour SBE
//* Commentaires	: JFF   07/04/2015 [PC13442-1]
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	PHG	31/03/2008 	[DCMP080162] AJout Valeur Publique d'achat et Date Achat
//* #2	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
//* #3   JFF   20/10/2008  [FNAC_PROD_ECH_TECH].[20090127140540720]
//* #4   JFF   20/10/2008  [FNAC_PROD_ECH_TECH].[20090225143455120]
//* #7	FPI	20/03/2009	[DCMP090109] SBE devient réparateur d'IPhone
//* #8   JFF   27/03/2009  [DCMP090152] Civ long pour SBE
//*  	   JFF	13/04/2010  [ADRESSE_SBE]
//			FPI	10/08/2010	[PM01] Process 4
//* 		JFF   03/05/2011  [PM166][SBE]
//*      JFF   12/12/2011  [VDOC4970]
//*      JFF   04/10/2012  [BLCODE]
//*      JFF   12/12/2011  [VDOC9043]
//       JFF   07/05/2013  [PC938_ORANGE_V3]
//       JFF   09/09/2013  [PM222-1]
//       JFF   13/01/2014  [PM246]
//       JFF   28/03/2014  [DT081_EVOL_PRET_BRIS]
//       JFF   04/11/2014  [PM280-1]
//       JFF   16/03/2015  [DT081-3]
//       JFF   12/05/2015  [DT141][MANTIS14455]
// 		JFF   21/06/2018  [VDOC26276]
//       JFF   23/06/2020  [PC202553_SELECTRA]
//*-----------------------------------------------------------------
Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sIdRefFour, sTypArt2, sInfoSpbFrnCplt
String sNomLigne1, sNomLigne2, sAdrLigne1, sAdrLigne2, sCP, sVille, sValCar, sVal, sInfoSpbFrn
n_cst_cmd_commun	lnvCmdCommun
Long lIdProd,  lDeb,lFin, lCptKey
n_cst_attrib_key	lnv_Key[]
n_cst_string lnvString

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour SBE 								  */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_SBE"

/*------------------------------------------------------------------*/
/* Génération du fichier de COMMANDES (CMD)                         */
/*------------------------------------------------------------------*/
//* #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
// sFiltre = "ID_TYP_ART = 'EDI' AND COD_ETAT <> 'ANN'"
sFiltre = "COD_ETAT <> 'ANN'"

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de PRESTATIONS (PRS)                       */
		/*------------------------------------------------------------------*/
		// [PM82][LOT1] Simplification
		// [MANTIS3743]
		CASE 1
			sFiltre = "ID_FOUR= 'SBE'"
			sNomFic = K_FIC2 // "PRS"
			sTypArt = "Ordre SBE"
			sTypArtNul = "Ordre SBE"
			This.Uf_Trace ( "ECR", "Génération du fichier de PRESTATION SBE en cours..." )

	End Choose

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()
	
	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
	
	For lCpt = 1 To lTot
		lRow = idwFicGenCmde.InsertRow ( 0 )
	
	//* #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
	
		sTypArt2 = idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" ) 
	
		// #7 [DCMP090109]
		sAction = idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )
	
		// [VDOC4970]
		sInfoSpbFrn = String ( idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) )
		sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))
	
		// [PM166][SBE]
		Choose Case sTypArt2
			Case "EDI", "PRS"
	
				// ON laisse tel quel
	
				// [PM82][LOT2]
				sVal = ""
				If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
					sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_REPARER_SAV", ";")
					If sVal = "OUI" Then
						sAction = "A_REPARER_SAV"
					End If
				End If
				// [PM82][LOT2]
				
				// [PM222-1]
				sVal = ""
				If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
					sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_CONTROLER_SAV", ";")
					If sVal = "OUI" Then
						sAction = "A_CONTROLER_SAV" 
					End If
				End If
				// [PM222-1]			
				
				// [PM280-1]
				sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_REP_GARANTIE", ";")
				If sVal = "OUI" Then
					sAction = "A_REP_GARANTIE"
				End If
	
		// [VDOC4970]
			Case "ALE", "BAM", "ACC"
				
				// [ITSM113805]
				sAction = "A_COMMANDER"
				
				//	[VDOC3537]				
				sInfoSpbFrn = "990"
	
		// [VDOC4970]
			Case "PCM"
				sInfoSpbFrn = "990"

		// [PC938_ORANGE_V3]
			Case "RST"
				sInfoSpbFrn = "990"
				sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "RST_INFO_SIMPLE", ";")
				If sVal = "OUI" Then
					sAction = "ALIMENTER_STOCK"
				Else 
					sAction = "RST_A_COMMANDER"					
				End If

		// [PC938_ORANGE_V3]
			Case "RES"
				sAction = "PRET_A_RESTITUER"

			Case "REA"
				sAction = "RECUP_APP_SIN"

			Case "PST"

				// [DT081_EVOL_PRET_BRIS]
				// [DT081-3]
				Choose Case sAction 
					Case "DEM_RESTIT", "INFO_CAUTION"
						// On laisse
					case Else 
						sAction = "A_COMMANDER"
				End Choose
				
			Case Else			
				sAction = "A_COMMANDER"
		End Choose
		
		Choose Case sTypArt2 
			Case "EDI", "PRS", "PCM", "CAF"
				sTypArt2 = idwFicCharg.GetItemString ( lCpt, "TYP_APP_SIN" )
				
			Case Else
				// On laisse tel quel
		End Choose
	//* :#6 [FNAC_PROD_ECH_TECH].[20090127140540720]
	
	// [PM246]
	sVal = ""
	If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
		sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "MAJ_ADRESSE", ";")
		If sVal = "OUI" Then
			sAction = "MAJ_ADRESSE"
		End If
	End If		
	// [PM246]	
		
		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_POLICE",		idwFicCharg.GetItemString ( lCpt, "LIB_POLICE" ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_ADH",			idwFicCharg.GetItemString ( lCpt, "ID_ADH" ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_DOSSIER",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )))
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "CODE_PROD", 		String (idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) + " " + idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_1",				idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_2",				idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CPL",			idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ) )			
		idwFicGenCmde.SetItem ( lRow, "TYP_ART",			sTypArt2 )			
		idwFicGenCmde.SetItem ( lRow, "PROBLEME",			idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) )					
		idwFicGenCmde.SetItem ( lRow, "NUM_IMEI_SERIE",	idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" ) )						
		idwFicGenCmde.SetItem ( lRow, "MARQ_APP",			idwFicCharg.GetItemString ( lCpt, "MARQ_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_APP",			idwFicCharg.GetItemString ( lCpt, "MODL_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "MAJ_PAR" ) )						
		idwFicGenCmde.SetItem ( lRow, "ACTION", sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "GARANTIE",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN",	sInfoSpbFrn  )		// [VDOC4970]
		idwFicGenCmde.SetItem ( lRow, "ASSUREUR",			idwFicCharg.GetItemString ( lCpt, "ASSUREUR" ) )
		// [DCMP080162] AJout Valeur Publique d'achat et Date Achat ( note : date stockée sous forme de chaine )
		idwFicGenCmde.SetItem ( lRow, "MT_VAL_ACHAT",	idwFicCharg.GetItemString ( lCpt, "MT_VAL_ACHAT" ))
		idwFicGenCmde.SetItem ( lRow, "DTE_ACHAT",		idwFicCharg.GetItemString ( lCpt, "DTE_ACHAT" ) )
		idwFicGenCmde.SetItem ( lRow, "MT_PEC",			idwFicCharg.GetItemString ( lCpt, "MT_PEC" ) )
	

		// [PM166][SBE]
		If sAction = "A_COMMANDER" Then
			// On réinitialise certaines zones inutiles pour la commande
/* [DT141][MANTIS14455]
			idwFicGenCmde.SetItem ( lRow, "PROBLEME",	"")							
			idwFicGenCmde.SetItem ( lRow, "NUM_IMEI_SERIE",	"" )								
*/			
/* Idem à la RST d'OV3, on laisse la marq/modl IFR, plus haut sur MARQ_APP et MODL_APP
			idwFicGenCmde.SetItem ( lRow, "MARQ_APP",			idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
			idwFicGenCmde.SetItem ( lRow, "MODL_APP",			idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )						
*/		End If
		// :[PM166][SBE]	

		// [REPAR_GTI]
		If sAction = "A_REP_GARANTIE" Then
			idwFicGenCmde.SetItem ( lRow, "MARQ_APP",			idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
			idwFicGenCmde.SetItem ( lRow, "MODL_APP",			idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )				
		End if
		// :[REPAR_GTI]
		
/*
		Choose Case sAction  
			Case "A_COMMANDER", "RST_A_COMMANDER"
				If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
				sInfoSpbFrnCplt += "ID_REF_FOUR=" + idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )
		
				If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
				sInfoSpbFrnCplt += "MT_TTC_CMDE=" + String ( idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) )
		End Choose
*/		
		// :[PM166][SBE]

		// [PC202553_SELECTRA]
		If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
		sInfoSpbFrnCplt += "DTE_ADH=" + String ( idwFicCharg.GetItemDateTime ( lCpt, "DTE_ADH" ), "dd/mm/yyyy" )
		
		If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
		sInfoSpbFrnCplt += "COD_CIV_COURTE=" + idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV" )
		
		If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
		sInfoSpbFrnCplt += "COD_CIV_LONGUE=" + idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV_LONG" )	
		
		
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	sInfoSpbFrnCplt  )
		//* :#2 [FNAC_PROD_ECH_TECH]
	
	Next
	
	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, TRue ) // True : On indique les en-tetes
	
	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
		
		// [VDOC26276]
		This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic ) 
		
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
	End If

	If iRet = -1 Then Exit
Next

Return iRet 

end function

private function integer uf_generer_fichier_mss (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_MSS (PRIVATE)
//* Auteur			: Catherine Abdmeziem
//* Date				: 13/09/2004
//* Libellé			: Génération du fichier de commande pour MSS
//* Commentaires	: DCMP 040381
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF		07/05/2004 DCMP 040134 D. Bizien A-NOVO souhaite l'ID_PROD plutot que le LIB_PROD
//* #2	 CAG	 	13/09/04	  DCMP 040381 : Ajout du frn MSS
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sLibCplt, sFiltreSFR, sNomFicSav

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le MSS                       */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_MSS"

For lCptCas = 1 To 4
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC1
			sTypArt = "commandes"
			sTypArtNul = "commande"
			sAction = "A_COMMANDER"
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )

		/*------------------------------------------------------------------*/
		/* Génération du fichier de PRESTATIONS (PRS)                       */
		/*------------------------------------------------------------------*/
		CASE 2
			sFiltre = "ID_TYP_ART = 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC2
			sTypArt = "prestations"
			sTypArtNul = "prestation"
			sAction = "A_REPARER"
			This.Uf_Trace ( "ECR", "Génération du fichier de PRESTATIONS en cours..." )

		/*------------------------------------------------------------------*/
		/* Génération du fichier des ANNULATION des COMMANDES (ACD)			  */
		/*------------------------------------------------------------------*/
		CASE 3
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT = 'ANN'"
			sNomFic = K_FIC3
			sTypArt = "annulations de commandes"
			sTypArtNul = "annulation de commandes"
			sAction = "A_ANNULER"
			This.Uf_Trace ( "ECR", "Génération du fichier d'ANNULATIONS DES COMMANDES en cours..." )

		/*------------------------------------------------------------------*/
		/* Génération du fichier des ANNULATION des COMMANDES (APR)			  */
		/*------------------------------------------------------------------*/
		CASE 4
			sFiltre = "ID_TYP_ART = 'PRS' AND COD_ETAT = 'ANN'"
			sNomFic = K_FIC4
			sTypArt = "annulations de prestations"
			sTypArtNul = "annulation de prestations"
			sAction = "A_ANNULER"
			This.Uf_Trace ( "ECR", "Génération du fichier d'ANNULATIONS DES PRESTATIONS en cours..." )


	END CHOOSE

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" + sLibCplt )
		Choose Case lCptCas
			Case 2
				// Pour le cas PRS on génère un fichier vide (s'il doit être vide).

			Case Else
				Continue
		End Choose
	End If

	For lCpt = 1 To lTot

		lRow = idwFicGenCmde.InsertRow ( 0 )

		/*------------------------------------------------------------------*/
		/* #2 CAG 13/09/2004 : identique à SBE + civilité - imei            */
		/*------------------------------------------------------------------*/
		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )

		If Today () >= 2005-03-22 Then 
			idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		Else
			idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		End If

		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_PROD", 		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) ) )
		idwFicGenCmde.SetItem ( lRow, "CIVILITE",			idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) + " " + idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR_CPL",	idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ) )			
		idwFicGenCmde.SetItem ( lRow, "TYP_ART",			idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" ) )			
		idwFicGenCmde.SetItem ( lRow, "PROBLEME",			idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) )					
		idwFicGenCmde.SetItem ( lRow, "MARQ_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "NOM_GEST" ) )						
		idwFicGenCmde.SetItem ( lRow, "ACTION",			sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "ID_GTI",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )				
	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, False )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic ) + " " + sLibCplt )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + ", " + sLibCplt + " : le fichier n'est pas généré !!" )
		Exit
	End If


	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_flaguer_commandes_cegetel2 ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Flaguer_Commandes_Cegetel2 ( PRIVATE )
//* Auteur			: Abdmeziem Catherine
//* Date				: 08/10/02
//* Libellé			: On marque en base les commandes chargées comme étant générées
//*					  elle ne pourraient être par la suite que regénérées avant la fonction adéquat.
//* Commentaires	: Modification SFR
//*
//* Arguments		: Aucun
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Int 			iRet
DateTime		dtNow
String 		sFiltre, sIdCmdFrn, sIdContrAbon, sNumCmdSPB
Long			lTotFilt, lCptFilt, lIdProd, lCptCmdMax, lCptCmd

iRet = 1
dtNow = DateTime ( Today (), Now () )

ilIdLotCeg = -1
SQLCA.PS_S05_COMMANDE ( "ID_LOT_CEG", ilIdLotCeg )

If ilIdLotCeg <= 0 Or IsNull ( ilIdLotCeg ) Then
	// RollBack immédiat.
	F_Commit ( SQLCA, False )
	iRet = -1
	This.Uf_Trace ( "ECR", "ERREUR lors de la récupération de l'ID_LOT_CEG, " + String ( ilIdLotCeg ) )
Else
	This.Uf_Trace ( "ECR", "Attribution du n° de fichier de commandes : " + String ( ilIdLotCeg ) )
End If

// [ITSM178659]
F_COMMIT ( SQLCA, SQLCA.SQLCODE = 0 Or SQLCA.SQLDBCODE = 0  ) 


idwFicCharg.Sort ()
lTotFilt = idwFicCharg.RowCount ()

If lTotFilt > 0 Then

		/*------------------------------------------------------------------*/
		/* Attribution d'un n° de cmde à toutes les lignes chargées pour    */
		/* le produit en cours de traitement                                */
		/*------------------------------------------------------------------*/
		If iRet > 0 Then
			For lCptFilt = 1 To lTotFilt
				sNumCmdSPB = String ( idwFicCharg.GetItemNumber ( lCptFilt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCptFilt, "ID_SEQ" ) )
				sIdContrAbon = idwFicCharg.GetItemString ( lCptFilt, "ID_CONTRAT_ABONNE" )
				sIdCmdFrn = uf_CalcNumCmde2 ( lIdProd, sIdContrAbon, sNumCmdSPB )
				idwFicCharg.SetItem ( lCptFilt, "ID_CMD_FRN", sIdCmdFrn )
				idwFicCharg.SetItem ( lCptFilt, "ID_LOT_CMD", ilIdLotCeg )
				idwFicCharg.SetItem ( lCptFilt, "CMD_GEN_LE", dtNow )
				idwFicCharg.SetItem ( lCptFilt, "CMD_GEN_PAR", stGlb.sCodOper )
			Next
		End If

		/*------------------------------------------------------------------*/
		/* Update en base.                                                  */
		/* Les lignes vont être marquées en bases.								  */
		/*------------------------------------------------------------------*/
		If iRet > 0 Then
			If idwFicCharg.Update () > 0 Then
				F_Commit ( SQLCA, True )
				This.Uf_Trace ( "ECR", "Update du marquage réussi, les commandes pour le produit " + String ( lIdProd ) + " sont flaguées en base." )
			Else
				iRet = -1
				F_Commit ( SQLCA, False )
				This.Uf_Trace ( "ECR", "ERREUR, Update du marquage en base a échoué sur le produit " + String ( lIdProd ) + "." )
			End If
		End If
End If

Return iRet

end function

private function string uf_calcnumcmde2 (long alidprod, string asidcontrabon, string asnumcmdspb);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gen_Fic_Commande::uf_CalcNumCmde2 ( PRIVATE )
//* Auteur        : FABRY JF ( reprise fonction Catherine ABDMEZIEM)
//* Date          : 09/10/2002 15:22:57
//* Libellé       : Calcul du numéro d'une commande CEGETEL (version 2004/2005)
//* Commentaires  : Modification SFR
//*
//* Arguments     : ( Val )	Long		alIdProd			:	Id_prod
//*					  ( Val )	String	asIdContrAbon	:	Id_Contrat_Abonne		vient de w_sin/sinistre
//*					  ( Val )	String	asNumCmdSPB		:	N° comande SPB
//*
//* Retourne      : String		Id_Cmd_Frn
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*
//*-----------------------------------------------------------------

String	sId_Cmd_Frn, sCptCmd, sChZeros

sId_Cmd_Frn = asIdContrAbon + "FR/"

sCptCmd = asNumCmdSPB
sChZeros = Fill ( "0", 9 - Len ( sCptCmd ) )
sId_Cmd_Frn = sId_Cmd_Frn + sChZeros + sCptCmd

Return sId_Cmd_Frn
end function

private function integer uf_generer_fichier_cegetel2 (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_CEGETEL2 ( PRIVATE )
//* Auteur			: FABRY JF (reprise avec quelques modif de la fonction de Abdmeziem Catherine)
//* Date				: 09/10/02
//* Libellé			: Génération du fichier de commande pour CEGETEL pour les nouvelles offres 2004/2005
//* Commentaires	: Un fichier sera généré SAPjjmmi.txt (SAP25101.txt)
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//       JFF   11/02/2014 [DT57_CMDE_IPHONE_SFR]
//*-----------------------------------------------------------------

Int		iRet, iNbEnrCeg
String	sEnr, sNbEnr, sChZeros, sSep, sFiltre, sNomFic, sIdLotCeg, sDonneurOrdre, sInfoSpbFrnCplt, sIdRefFour 
Long		lIdLotCeg, lTot, lCpt, lCptArt, lNewRow, lPosSlash 
n_cst_string lnvString

iRet = 1
sSep = " "
iNbEnrCeg = 0

/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le CEGETEL                   */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_cegetel"

idwFicGenCmde.Reset ()

/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Ecriture des enregistrements des commandes : chaque ligne        */
/* d'entête de commande est suivie des articles correspondants.     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
lTot = idwFicCharg.RowCount ()

For lCpt = 1 To lTot

	sIdRefFour = idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )

	If IsNull ( sDonneurOrdre ) Or Len ( Trim ( sDonneurOrdre ) ) = 0 Then
		sDonneurOrdre = idwFicCharg.GetItemString ( lCpt, "ID_PROD_CLIENT" )
	End If

	/*------------------------------------------------------------------*/
	/* Ecriture de l'entête de commande                                 */
	/*------------------------------------------------------------------*/
	sEnr = "$"																										  + sSep + &
			 This.uf_FormatChamps ( 10, sDonneurOrdre	)													  + sSep + &
			 This.uf_FormatChamps ( 30, "SPB"	)							  								  + sSep + &
			 This.uf_FormatChamps ( 30, ""	)						  		  								  + sSep + &
			 This.uf_FormatChamps ( 30, "71 QUAI COLBERT" )												  + sSep + &
			 This.uf_FormatChamps ( 25, "LE HAVRE CEDEX" )												  + sSep + &
			 This.uf_FormatChamps ( 10, "76095" )															  + sSep + &
			 This.uf_FormatChamps ( 16, "02.32.74.20.67" )												  + sSep + &
			 This.uf_FormatChamps ( 20, idwFicCharg.GetItemString ( lCpt, "ID_CMD_FRN" ) )	  + sSep + &
			 This.uf_FormatChamps ( 10, sDonneurOrdre	 )  												  + sSep + &
			 This.uf_FormatChamps ( 30, Left ( &
	  												   idwFicCharg.GetItemString ( lCpt, "LIB_COD_CIV" ) + sSep + &
					 	                        idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" )  + sSep + &
			 									      idwFicCharg.GetItemString ( lCpt, "ADR_NOM" )              &
												 ,30 ) )		                                            + sSep + &
			 This.uf_FormatChamps ( 30, Left ( &
														idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" )         &
												 ,30 ) )		                                            + sSep + &
			 This.uf_FormatChamps ( 30, Left ( &
														idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" )	  + sSep + &
			 									 		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" )            &
												 ,30 ) )		                                            + sSep + &
			 This.uf_FormatChamps ( 25, Left ( &																
														idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) 		     &
												 ,25 ) )		                                            + sSep + &
			 This.uf_FormatChamps ( 10, Left ( &
														idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) 			     &
												 ,10 ) )		                                            + sSep + &
			 String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "yyyymmdd" )			  + sSep + &
			 This.uf_FormatChamps ( 16, Left ( &
														idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" )			     &
												 ,16 ) )		                                            + sSep
		 
			 
	lNewRow = idwFicGenCmde.InsertRow ( 0 )
	idwFicGenCmde.SetItem ( lNewRow, "LIGNE", sEnr )

	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/
	/* Ecriture des lignes d'articles                                   */
	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/

	/*------------------------------------------------------------------*/
	/* 1 - écriture de la ligne de l'article de base                    */
	/*------------------------------------------------------------------*/
	sEnr = "*" + sSep + uf_FormatChamps ( 18, sIdRefFour ) + sSep + "1"
	lNewRow = idwFicGenCmde.InsertRow ( 0 )
	idwFicGenCmde.SetItem ( lNewRow, "LIGNE", sEnr )

	/*------------------------------------------------------------------*/
	/* 2 - Ecriture de l'article lié au code hlr                        */
	/*------------------------------------------------------------------*/
	// N'existe plus surl a nouvelle version du fichier

	/*------------------------------------------------------------------*/
	/* 3 - Ecriture de l'article lié au produit                         */
	/*------------------------------------------------------------------*/
	sFiltre = "ID_FOUR = '" + idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) 		  + "' AND " + &
				 "ID_REF_FOUR = '" + idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" ) + "' AND " + &
				 "ID_TYP_ART = 'ART' AND " 														  + &
				 "ID_PROD = " + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) )
	idwFicChargArt.SetFilter ( sFiltre )
	idwFicChargArt.Filter ()
	idwFicChargArt.Sort ()
	If idwFicChargArt.RowCount () <> 0 Then
		sEnr = "*" + sSep + uf_FormatChamps ( 18, idwFicChargArt.GetItemString ( 1, "ID_ARTICLE" ) ) + sSep + "1"
		lNewRow = idwFicGenCmde.InsertRow ( 0 )
		idwFicGenCmde.SetItem ( lNewRow, "LIGNE", sEnr )
	End If

	/*------------------------------------------------------------------*/
	/* 4 - Ecriture du (ou des) article(s) lié(s) au mobile             */
	/*------------------------------------------------------------------*/
	sFiltre = "ID_FOUR = '" + idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) 		  + "' AND " + &
				 "ID_REF_FOUR = '" + idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" ) + "' AND " + &
				 "ID_TYP_ART = 'ART' AND " 														  + &
				 "ID_PROD = -1"
	idwFicChargArt.SetFilter ( sFiltre )
	idwFicChargArt.Filter ()
	idwFicChargArt.Sort ()
	For lCptArt = 1 To idwFicChargArt.RowCount () 
		sEnr = "*" + sSep + uf_FormatChamps ( 18, idwFicChargArt.GetItemString ( lCptArt, "ID_ARTICLE" ) ) + sSep + "1"
		lNewRow = idwFicGenCmde.InsertRow ( 0 )
		idwFicGenCmde.SetItem ( lNewRow, "LIGNE", sEnr )
	Next

Next

/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Ecriture de l'enregistrement de l'entête de fichier              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
sNbEnr = String ( idwFicGenCmde.RowCount () )
sChZeros = Fill ( "0", 6 - Len ( sNbEnr ) )
sNbEnr = sChZeros + sNbEnr
sIdLotCeg = String ( ilIdLotCeg )
sChZeros = Fill ( "0", 3 - Len ( sIdLotCeg ) )
sEnr = "!SPB " + sNbEnr + sChZeros + sIdLotCeg + String (alIdLotCmd, Fill ( "0", 5 ) )

lNewRow = idwFicGenCmde.InsertRow ( 1 )
idwFicGenCmde.SetItem ( lNewRow, "LIGNE", sEnr )

/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Récupération du nom de fichier, et génération                    */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
sNomFic = K_FIC5

This.uf_nom_fichier ( sNomFic , 0 )
If sNomFic = "" Then
	iRet = -1
	This.Uf_Trace ( "ECR", "Il y a déjà eu 10 générations aujourd'hui !!" )
Else
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, False )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des commandes généré avec succès sur : " + Upper ( sNomFic ) )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des commandes, le fichier n'est pas généré !!" )
	End If
End If

Return iRet

end function

private function integer uf_generer_fichier_cdiscount (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_CDICOUNT (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 12/07/2005
//* Libellé			: Génération du fichier d'information pour C-DISCOUNT
//* Commentaires	: 
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	11/03/2013	[VDoc10441] Montant valeur d'achat devien montant de pec
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sIdRefFour

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le CDISCOUNT					  */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_CDISCOUNT"

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART = 'EDI' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC6
			sTypArt = "prises en charges"
			sTypArtNul = "prise en charge"
			sAction = "PRISE_EN_CHARGE"
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )


	END CHOOSE

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_ASSURANCE",	idwFicCharg.GetItemString ( lCpt, "ID_SERIE_NOUV" ) ) 
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "TYP_INF",			idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" ) )			
		idwFicGenCmde.SetItem ( lRow, "NOM_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "NOM_GEST" ) )						
		idwFicGenCmde.SetItem ( lRow, "ACTION",			sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "ID_GTI",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )				

		sIdRefFour = Upper ( idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" ) )
		Choose Case sIdRefFour 
			Case "MONTANT_VAL_ACHAT"
				idwFicGenCmde.SetItem ( lRow, "MT_VAL_ACHAT",	string ( idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) ) )				
			Case "MONTANT_FRAIS"
				idwFicGenCmde.SetItem ( lRow, "MT_FRAIS",	string ( idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) ) )
			// [VDoc10441]
			Case "MONTANT_PEC"
				idwFicGenCmde.SetItem ( lRow, "MT_VAL_ACHAT",	string ( idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) ) )				
		End Choose

		idwFicGenCmde.SetItem ( lRow, "DTE_SURV",	String ( idwFicCharg.GetItemDate ( lCpt, "DTE_ENV_BTE_FRN" ), "dd/mm/yyyy" ) )

	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, False )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private subroutine uf_formatchaine (ref string asval, long alcas);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_Gen_Fic_Commande::uf_FormatChaine
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 13/11/02
//* Libellé       : Remplace certains caractères dans une chaîne par des blancs
//* Commentaires  : 
//*
//* Arguments     : ( Ref )	String	asVal	:	chaîne à traiter
//*					  ( val )   Long		alCas
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #4	 JFF     18/09/2007 [ALAPAGE]
//*		FPI	04/10/2013	[VDoc12269]
//*-----------------------------------------------------------------

String	sCar, sTabCar [], sTabSubst [], sTabCar2[]
Long		lTotLet, lCpt, lTotSubst, lCptSubst

If isnull(asVal) Then return // [VDoc12269]

sTabCar		[1] = ";"
sTabSubst 	[1] = " "
sTabCar		[2] = ","
sTabSubst 	[2] = " "
sTabCar		[3] = "'"
sTabSubst 	[3] = " "
sTabCar		[4] = "."
sTabSubst 	[4] = " "

// [VDoc12269]
sTabCar2[1]=Char(10)
sTabCar2[2]=Char(9)
sTabCar2[3]=Char(11)
sTabCar2[4]=Char(13)
sTabCar2[5]="~""

lTotSubst = UpperBound ( sTabSubst )

/*------------------------------------------------------------------*/
/* On remplace les caractères voulus.										  */
/*------------------------------------------------------------------*/

Choose case alCas
	Case 1

		lTotLet = Len ( asVal )
		For lCpt = 1 To lTotLet
		
			sCar = Mid ( asVal, lCpt, 1 )	
		
			For lCptSubst = 1 To lTotSubst 
			
				If sCar = sTabCar	[ lCptSubst ] Then 
					asVal = Replace ( asVal, lCpt, 1, sTabSubst [ lCptSubst ] )			
					Exit
				End If
				
			Next
		Next

	// #1
	Case 2

		lTotLet = Len ( asVal )
		For lCpt = 1 To lTotLet
		
			sCar = Mid ( asVal, lCpt, 1 )	
		
			For lCptSubst = 1 To lTotSubst 
			
				Choose Case asc ( sCar ) 
					Case 32, 48 TO 57, 65 TO 90, 97 TO 122
						// OK 
					Case Else 
						
						sCar = "_"
						asVal = Replace ( asVal, lCpt, 1, sCar )									
				End Choose			
			Next
		Next

	Case 3 // [VDoc12269]
		For lCptSubst = 1 To UpperBound(stabCar2)
			asVal = f_remplace(asVal, stabCar2[lCptSubst], " ")
		Next
		
End Choose
end subroutine

private subroutine uf_charger_o2m ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Charger_O2M (PRIVATE)
//* Auteur			: PHG
//* Date				: 
//* Libellé			: Modif après chargement des commandes pour O2M
//* Commentaires	: [O2M]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*		FPI	04/10/2013	[VDoc12269]
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Pas d'espace pour les numéros de téléphone.                      */
/* Seulement dans la gêne du fichier, on laisse les espaces en base */
/*------------------------------------------------------------------*/
Long 	lTot, lCpt, lCptCas, lLen, lCptLen
String sVal

lTot = idwFicCharg.RowCount ()

For lCpt = 1 To lTot

	For lCptCas = 1 To 3
		sVal = idwFicCharg.GetItemString ( lCpt, "ADR_TEL" + String ( lCptCas )  )
		lLen = Len ( sVal )
		For lCptLen = lLen To 1 Step -1
			If Mid ( sVal, lCptLen, 1 ) = " " Then 
				sVal = Replace ( sVal, lCptLen, 1, "" )
			End If
		Next
		uf_FormatChaine ( sVal, 1 )
		idwFicCharg.SetItem ( lCpt, "ADR_TEL" + String ( lCptCas ), sVal  )
 
	Next

	sVal = idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) 
	uf_FormatChaine ( sVal, 1 )
	uf_FormatChaine ( sVal, 3 )	//[VDoc12269]
	idwFicCharg.SetItem ( lCpt, "PROBLEME", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_NOM" )
	uf_FormatChaine ( sVal, 1 )
	uf_FormatChaine ( sVal, 3 )	//[VDoc12269]
	idwFicCharg.SetItem ( lCpt, "ADR_NOM", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" )
	uf_FormatChaine ( sVal, 1 )
	uf_FormatChaine ( sVal, 3 )	//[VDoc12269]
	idwFicCharg.SetItem ( lCpt, "ADR_PRENOM", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" )
	uf_FormatChaine ( sVal, 1 )
	idwFicCharg.SetItem ( lCpt, "ADR_LIVR1", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" )
	uf_FormatChaine ( sVal, 1 )
	uf_FormatChaine ( sVal, 3 )	//[VDoc12269]
	idwFicCharg.SetItem ( lCpt, "ADR_LIVR2", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" )
	uf_FormatChaine ( sVal, 1 )
	uf_FormatChaine ( sVal, 3 )	//[VDoc12269]
	idwFicCharg.SetItem ( lCpt, "ADR_LIVR_CPL", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" )
	uf_FormatChaine ( sVal, 1 )
	uf_FormatChaine ( sVal, 3 )	//[VDoc12269]
	idwFicCharg.SetItem ( lCpt, "ADR_VILLE", sVal  )

	//[VDoc12269]
	sVal = idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" )
	uf_FormatChaine ( sVal, 3 )
	idwFicCharg.SetItem ( lCpt, "INFO_SPB_FRN_CPLT", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" )
	uf_FormatChaine ( sVal, 3 )
	idwFicCharg.SetItem ( lCpt, "ID_SERIE_ANC", sVal  )


	sVal = idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" )
	uf_FormatChaine ( sVal, 3 )
	idwFicCharg.SetItem ( lCpt, "ID_MODL_ART", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "PROBLEME" )
	uf_FormatChaine ( sVal, 3 )
	idwFicCharg.SetItem ( lCpt, "PROBLEME", sVal  )
Next

end subroutine

private function integer uf_generer_fichier_micromania (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_Micromania (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 05/09/2008
//* Libellé			: Génération du fichier de commande pour le Micromania
//* Commentaires	: [MICROMANIA]
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF		07/05/2004 DCMP 040134 D. Bizien A-NOVO souhaite l'ID_PROD plutot que le LIB_PROD
//* #2	 JCA		28/02/2008 DCMP 080158 - Changement de format du fichier
//* #3    JFF     02/12/2008 BUG remonté par David Ibersien
//*       JFF     10/06/2010 [PC419/440/418/439_MICROMANIA]
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sLibCplt, sFiltreSFR, sNomFicSav

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le A-NOVO                   */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_micromania"

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier spéciale pour MCM								  */
		/*------------------------------------------------------------------*/
		CASE 1
// [PC419/440/418/439_MICROMANIA]
			sFiltre = "COD_ETAT <> 'ANN'"
			sNomFic = ""
			sTypArt = "Appareil à Expertiser/Remplacer"
			sTypArtNul = "Appareil à Expertiser/Remplacer"
			sAction = "A EXPERTISER"
			This.Uf_Trace ( "ECR", "Génération du fichier d'APPAREILS A EXPERTISER/REMPLACER en cours..." )



	END CHOOSE

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" + sLibCplt )
/* #3
		Choose Case lCptCas
			Case 2
				// Pour le cas PRS on génére un fichier vide (s'il doit être vide).

			Case Else
				Continue
		End Choose
*/		
	End If

	For lCpt = 1 To lTot

		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )			
		idwFicGenCmde.SetItem ( lRow, "ID_MCM", 	idwFicCharg.GetItemString ( lCpt, "ID_CONTRAT_ABONNE" ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_PROD", 		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) ) )
		idwFicGenCmde.SetItem ( lRow, "COD_MAG", 		   idwFicCharg.GetItemstring ( lCpt, "COD_MAG" ) ) 
		idwFicGenCmde.SetItem ( lRow, "DTE_DECL",		String ( idwFicCharg.GetItemDateTime ( lCpt, "DTE_DECL" ), "yyyymmdd" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) )
		idwFicGenCmde.SetItem ( lRow, "PRENOM",			idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			// #2
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ) )			// #2
		idwFicGenCmde.SetItem ( lRow, "TYP_INFO",			idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" ) )			// #2
		idwFicGenCmde.SetItem ( lRow, "PROBLEME",			idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) )					
		idwFicGenCmde.SetItem ( lRow, "MARQ_APP",		idwFicCharg.GetItemString ( lCpt, "MARQ_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_APP",		idwFicCharg.GetItemString ( lCpt, "MODL_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "NUM_SERIE",	idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" ) )						
		idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "NOM_GEST" ) )						
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN",	String ( idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) ) )				
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "yyyymmddhhmmss" ) )
		idwFicGenCmde.SetItem ( lRow, "GARANTIE",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )				
	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, False )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic ) + " " + sLibCplt )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + ", " + sLibCplt + " : le fichier n'est pas généré !!" )
		Exit
	End If


	If iRet = -1 Then Exit

Next

Return iRet 
end function

private subroutine uf_charger_cdiscountpro ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Charger_CDiscountPRO (PRIVATE)
//* Auteur			: JFF
//* Date				: 21/04/2009
//* Libellé			: Modif après chargement des commandes pour CDiscountPRO
//* Commentaires	: [DCMP090102]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* [ITSM314090]	FPI	12/08/2015	M. remplacé par M dans la civilté
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Pas d'espace pour les numéros de téléphone.                      */
/* Seulement dans la gêne du fichier, on laisse les espaces en base */
/*------------------------------------------------------------------*/
Long 	lTot, lCpt, lCptCas, lLen, lCptLen
String sVal

lTot = idwFicCharg.RowCount ()

For lCpt = 1 To lTot

	For lCptCas = 1 To 3
		sVal = idwFicCharg.GetItemString ( lCpt, "ADR_TEL" + String ( lCptCas )  )
		lLen = Len ( sVal )
		For lCptLen = lLen To 1 Step -1
			If Mid ( sVal, lCptLen, 1 ) = " " Then 
				sVal = Replace ( sVal, lCptLen, 1, "" )
			End If
		Next
		/*------------------------------------------------------------------*/
		/* #2                                                               */
		/*------------------------------------------------------------------*/
		uf_FormatChaine ( sVal, 1 )
		idwFicCharg.SetItem ( lCpt, "ADR_TEL" + String ( lCptCas ), sVal  )
 
	Next

	/*------------------------------------------------------------------*/
	/* #1                                                               */
	/*------------------------------------------------------------------*/
	sVal = idwFicCharg.GetItemString ( lCpt, "PROBLEME" )
	uf_FormatChaine ( sVal, 1 )
	idwFicCharg.SetItem ( lCpt, "PROBLEME", sVal  )

	/*------------------------------------------------------------------*/
	/* #2                                                               */
	/*------------------------------------------------------------------*/
	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_NOM" )
	uf_FormatChaine ( sVal, 1 )
	idwFicCharg.SetItem ( lCpt, "ADR_NOM", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" )
	uf_FormatChaine ( sVal, 1 )
	idwFicCharg.SetItem ( lCpt, "ADR_PRENOM", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" )
	uf_FormatChaine ( sVal, 1 )
	idwFicCharg.SetItem ( lCpt, "ADR_LIVR1", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" )
	uf_FormatChaine ( sVal, 1 )
	idwFicCharg.SetItem ( lCpt, "ADR_LIVR2", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" )
	uf_FormatChaine ( sVal, 1 )
	idwFicCharg.SetItem ( lCpt, "ADR_LIVR_CPL", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" )
	uf_FormatChaine ( sVal, 1 )
	idwFicCharg.SetItem ( lCpt, "ADR_VILLE", sVal  )

	// [ITSM314090]
	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV" )
	if sVal="M." Then sVal="M"
	idwFicCharg.SetItem ( lCpt, "ADR_COD_CIV", sVal  )
Next

end subroutine

private function integer uf_generer_fichier_cdiscountpro (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_CDISCOUNTPRO (PRIVATE)
//* Auteur			: JFF
//* Date				: 21/04/2009
//* Libellé			: Génération du fichier de commande pour le fournisseur CDISCOUNTPRO
//* Commentaires	: Trois fichiers seront générés dans le même répertoires :
//*					  un pour les commandes   : CMDjjmma.ind  (CMD10091.001)
//*					  un pour les prestations : PRSjjmma.ind  (PRS10091.001)
//*					  un pour les annulations : ANNjjmma.ind  (ANN10091.001)
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 17/10/2002	  Modification SFR : Pour ce produit (5712), on
//*								  crée un fichier supplémentaire pour chaque type (cmd, prs, annul ...)
//*								  et on les écrit dans un répertoire spécifique
//*								  Annexe 7 (6.7.2) dans l'intégration de SFR, analyse des traitements
//*
//* #4	 JFF	 07/04/2003   Ajout de l'ID_REF_FOUR et MT_TTC_CMDE
//* #5	 CAG	 06/05/2003	  Génération d'un fichier vide de cmde qd pas de cmdes
//        JFF   12/04/2012   [VDOC7530]
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sInfoSpbFrnCplt 
n_cst_string lnvPFCString

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le BRIGHTPOINT               */
/*------------------------------------------------------------------*/

// [VDOC7530]
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_CDISCOUNTPRO"

For lCptCas = 1 To 4
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC1
			sTypArt = "commandes"
			sTypArtNul = "commande"
			sAction = "A COMMANDER"
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )

		/*------------------------------------------------------------------*/
		/* Génération du fichier de PRESTATIONS (PRS)                       */
		/*------------------------------------------------------------------*/
		CASE 2
			sFiltre = "ID_TYP_ART = 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC2
			sTypArt = "prestations"
			sTypArtNul = "prestation"
			sAction = "A REPARER"
			This.Uf_Trace ( "ECR", "Génération du fichier de PRESTATIONS en cours..." )

		/*------------------------------------------------------------------*/
		/* Génération du fichier des ANNULATION des COMMANDES (ACD)			  */
		/*------------------------------------------------------------------*/
		CASE 3
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT = 'ANN'"
			sNomFic = K_FIC3
			sTypArt = "annulations de commandes"
			sTypArtNul = "annulation de commandes"
			sAction = "A ANNULER"
			This.Uf_Trace ( "ECR", "Génération du fichier d'ANNULATIONS DES COMMANDES en cours..." )

		/*------------------------------------------------------------------*/
		/* Génération du fichier des ANNULATION des COMMANDES (APR)			  */
		/*------------------------------------------------------------------*/
		CASE 4
			sFiltre = "ID_TYP_ART = 'PRS' AND COD_ETAT = 'ANN'"
			sNomFic = K_FIC4
			sTypArt = "annulations de prestations"
			sTypArtNul = "annulation de prestations"
			sAction = "A ANNULER"
			This.Uf_Trace ( "ECR", "Génération du fichier d'ANNULATIONS DES PRESTATIONS en cours..." )


	END CHOOSE

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))
		If IsNull ( sInfoSpbFrnCplt ) Then sInfoSpbFrnCplt = "" 

		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )

		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )

		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) + " " + idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR_CPL",	idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ) )			
		idwFicGenCmde.SetItem ( lRow, "MARQ_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "NOM_GEST" ) )						
		idwFicGenCmde.SetItem ( lRow, "ACTION",			sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "ID_GTI",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )				
		idwFicGenCmde.SetItem ( lRow, "ID_REF_FOUR",			idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" ) ) 				
		idwFicGenCmde.SetItem ( lRow, "MT_TTC_CMDE",			String ( idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) ) )				

		// [VDOC7530]
		lnvPFCString.of_Setkeyvalue ( sInfoSpbFrnCplt, "COD_CIV_COURTE", idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV" ), ";")
		lnvPFCString.of_Setkeyvalue ( sInfoSpbFrnCplt, "COD_CIV_LONGUE", idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV_LONG" ), ";")
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	sInfoSpbFrnCplt  )				


	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, False )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_phoneandphone (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_PHONEANDPHONE (PRIVATE)
//* Auteur			: JFF
//* Date				: 21/04/2009
//* Libellé			: Génération du fichier de commande pour le fournisseur PHONEANDPHONE
//* Commentaires	: Trois fichiers seront générés dans le même répertoires :
//*					  un pour les commandes   : CMDjjmma.ind  (CMD10091.001)
//*					  un pour les prestations : PRSjjmma.ind  (PRS10091.001)
//*					  un pour les annulations : ANNjjmma.ind  (ANN10091.001)
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 17/10/2002	  Modification SFR : Pour ce produit (5712), on
//*								  crée un fichier supplémentaire pour chaque type (cmd, prs, annul ...)
//*								  et on les écrit dans un répertoire spécifique
//*								  Annexe 7 (6.7.2) dans l'intégration de SFR, analyse des traitements
//*
//* #4	 JFF	 07/04/2003   Ajout de l'ID_REF_FOUR et MT_TTC_CMDE
//* #5	 CAG	 06/05/2003	  Génération d'un fichier vide de cmde qd pas de cmdes
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sInfoSpbFrnCplt

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le BRIGHTPOINT               */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_PHONEANDPHONE"

sInfoSpbFrnCplt = ""

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC1
			sTypArt = "commandes"
			sTypArtNul = "commande"
			sAction = "A COMMANDER"
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )

	END CHOOSE

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )

		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )

		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) + " " + idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR_CPL",	idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ) )			
		idwFicGenCmde.SetItem ( lRow, "TYP_ART",			idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" ) )			
		idwFicGenCmde.SetItem ( lRow, "MARQ_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "NOM_GEST" ) )						
		idwFicGenCmde.SetItem ( lRow, "ACTION",			sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "ID_GTI",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )				
		idwFicGenCmde.SetItem ( lRow, "ID_REF_FOUR",			idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" ) ) 				
		idwFicGenCmde.SetItem ( lRow, "MT_TTC_CMDE",			String ( idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) ) )				
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN",	String ( idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) ) )
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT", sInfoSpbFrnCplt  )


	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, False )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_rueducommerce (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_RUEDUCOMMERCE (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 09/06/2009
//* Libellé			: Génération du fichier de commande pour le RUEDUCOMMERCE
//* Commentaires	: Trois fichiers seront générés dans le même répertoires :
//*					  un pour les commandes   : CMDjjmma.ind  (CMD10091.001)
//*					  un pour les prestations : PRSjjmma.ind  (PRS10091.001)
//*					  un pour les annulations : ANNjjmma.ind  (ANN10091.001)
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 17/10/2002	  Modification SFR : Pour ce produit (5712), on
//*								  crée un fichier supplémentaire pour chaque type (cmd, prs, annul ...)
//*								  et on les écrit dans un répertoire spécifique
//*								  Annexe 7 (6.7.2) dans l'intégration de SFR, analyse des traitements
//*
//* #4	 JFF	 07/04/2003   Ajout de l'ID_REF_FOUR et MT_TTC_CMDE
//* #5	 CAG	 06/05/2003	  Génération d'un fichier vide de cmde qd pas de cmdes
//* #6	 FPI	 23/07/2024	  [MIG_PB2022] Sauvegarde Excel! remplacée par Excel8!
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul
n_cst_string lnvPFCString

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le DEBITEL                   */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_rueducommerce"

For lCptCas = 1 To 4
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC1
			sTypArt = "commandes"
			sTypArtNul = "commande"
			sAction = "A COMMANDER"
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )

		/*------------------------------------------------------------------*/
		/* Génération du fichier de PRESTATIONS (PRS)                       */
		/*------------------------------------------------------------------*/
		CASE 2
			sFiltre = "ID_TYP_ART = 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC2
			sTypArt = "prestations"
			sTypArtNul = "prestation"
			sAction = "A REPARER"
			This.Uf_Trace ( "ECR", "Génération du fichier de PRESTATIONS en cours..." )

		/*------------------------------------------------------------------*/
		/* Génération du fichier des ANNULATION des COMMANDES (ACD)			  */
		/*------------------------------------------------------------------*/
		CASE 3
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT = 'ANN'"
			sNomFic = K_FIC3
			sTypArt = "annulations de commandes"
			sTypArtNul = "annulation de commandes"
			sAction = "A ANNULER"
			This.Uf_Trace ( "ECR", "Génération du fichier d'ANNULATIONS DES COMMANDES en cours..." )

		/*------------------------------------------------------------------*/
		/* Génération du fichier des ANNULATION des COMMANDES (APR)			  */
		/*------------------------------------------------------------------*/
		CASE 4
			sFiltre = "ID_TYP_ART = 'PRS' AND COD_ETAT = 'ANN'"
			sNomFic = K_FIC4
			sTypArt = "annulations de prestations"
			sTypArtNul = "annulation de prestations"
			sAction = "A ANNULER"
			This.Uf_Trace ( "ECR", "Génération du fichier d'ANNULATIONS DES PRESTATIONS en cours..." )


	END CHOOSE

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )

		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )

		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "IDENT", 			String ( lCpt ) )	
		idwFicGenCmde.SetItem ( lRow, "NOM_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) + " " + idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR_CPL",	idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "CODE_PAYS",		lnvPFCString.of_getkeyvalue (idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ), "CODE_PAYS", ";" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			
		idwFicGenCmde.SetItem ( lRow, "MESSAGE",			idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) )					
		idwFicGenCmde.SetItem ( lRow, "DESIGNATION",		idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) + " " + idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "NOM_GEST" ) )						
		idwFicGenCmde.SetItem ( lRow, "ACTION",			sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "ID_GTI",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )				
		idwFicGenCmde.SetItem ( lRow, "REF_PRODUIT",			idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" ) ) 				
		idwFicGenCmde.SetItem ( lRow, "MT_TTC_CMDE",			String ( idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) ) )				
		idwFicGenCmde.SetItem ( lRow, "REF_FDP",			lnvPFCString.of_getkeyvalue (idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ), "REF_FDP", ";" ) )
	
	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Excel8!, True ) // [MIG_PB2022]

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_sbetv (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_SBETV (PRIVATE)
//* Auteur			: PHG
//* Date				: 27/11/2007
//* Libellé			: Génération du fichier de commande pour O2M
//* Commentaires	: [DCMP090327].[SBETV]
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	PHG	31/03/2008 	[DCMP080162] AJout Valeur Publique d'achat et Date Achat
//* #2	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
//* #3   JFF   20/10/2008  [FNAC_PROD_ECH_TECH].[20090127140540720]
//* #4   JFF   20/10/2008  [FNAC_PROD_ECH_TECH].[20090225143455120]
//* #7	FPI	20/03/2009	[DCMP090109] O2M devient réparateur d'IPhone
//* #8   JFF   27/03/2009  [DCMP090152] Civ long pour O2M
//* #9   JFF   25/11/2009  [DCMP090327].[SBETV].[20091125155555450]
//*-----------------------------------------------------------------
Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sIdRefFour, sTypArt2, sInfoSpbFrnCplt
String sInfoSpbFrn, sVal
n_cst_string lnvPFCString


iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour O2M 								  */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_SBETV"

/*------------------------------------------------------------------*/
/* Génération du fichier de COMMANDES (CMD)                         */
/*------------------------------------------------------------------*/
//* #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
// sFiltre = "ID_TYP_ART = 'EDI' AND COD_ETAT <> 'ANN'"
sFiltre = "COD_ETAT <> 'ANN'"

sNomFic = K_FIC2 // "PRS"
sTypArt = "Ordre SBE TV"
sTypArtNul = "Ordre SBE TV"
This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )

idwFicCharg.SetFilter ( sFiltre )
idwFicCharg.Filter ()
idwFicCharg.Sort ()
lTot = idwFicCharg.RowCount ()			
idwFicGenCmde.Reset ()

/*------------------------------------------------------------------*/
/* On ne génère pas de fichier si pas de commandes ou pas de        */
/* prestations.                                                     */
/*------------------------------------------------------------------*/
If lTot = 0 Then This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )

For lCpt = 1 To lTot
	lRow = idwFicGenCmde.InsertRow ( 0 )

//* #6 [FNAC_PROD_ECH_TECH].[20090127140540720]

	sInfoSpbFrn = String ( idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) )
	sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))

	sTypArt2 = idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" ) 

	// #7 [DCMP090109]
	sAction = idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )
	If sTypArt2 = "PRS" then
		sAction = "A_REPARER"
	End If
	// :#7 [DCMP090109]
	
	Choose Case sTypArt2 
		Case "BAM", "ALE"
			// Ok, on ne fait rien
			
		Case Else
			sTypArt2 = idwFicCharg.GetItemString ( lCpt, "TYP_APP_SIN" )
		
	End Choose
//* :#6 [FNAC_PROD_ECH_TECH].[20090127140540720]

	// [PM246]
	sVal = ""
	If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
		sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "MAJ_ADRESSE", ";")
		If sVal = "OUI" Then
			sAction = "MAJ_ADRESSE"
		End If
	End If		
	// [PM246]	


	idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
	idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
	idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
	idwFicGenCmde.SetItem ( lRow, "CODE_PROD", 		String (idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) ) )
	idwFicGenCmde.SetItem ( lRow, "LIB_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
	idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) )
	idwFicGenCmde.SetItem ( lRow, "PRENOM_CLI",		idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
	idwFicGenCmde.SetItem ( lRow, "ADR_1",				idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
	idwFicGenCmde.SetItem ( lRow, "ADR_2",				idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
	idwFicGenCmde.SetItem ( lRow, "ADR_CPL",			idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
	idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
	idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
	idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
	idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
	idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			
	idwFicGenCmde.SetItem ( lRow, "TYP_ART",			sTypArt2 )			
	idwFicGenCmde.SetItem ( lRow, "PROBLEME",			idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) )					
	idwFicGenCmde.SetItem ( lRow, "NUM_IMEI_SERIE",	idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" ) )						
	idwFicGenCmde.SetItem ( lRow, "MARQ_APP",			idwFicCharg.GetItemString ( lCpt, "MARQ_APP" ) )						
	idwFicGenCmde.SetItem ( lRow, "MODL_APP",			idwFicCharg.GetItemString ( lCpt, "MODL_APP" ) )						
	idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "NOM_GEST" ) )						
	
	// #7 [DCMP090109] Déplacement de l'armement de sAction
	//sAction = idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )

	idwFicGenCmde.SetItem ( lRow, "ACTION", sAction )
	
	idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
	idwFicGenCmde.SetItem ( lRow, "GARANTIE",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )
	idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN",	String ( idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) ) )

	idwFicGenCmde.SetItem ( lRow, "MDE_RGLT",			'' ) 				
	idwFicGenCmde.SetItem ( lRow, "CDE_BANQUE",		'' ) 				
	idwFicGenCmde.SetItem ( lRow, "CDE_GUICHET",		'' ) 				
	idwFicGenCmde.SetItem ( lRow, "NUM_CPTE",			'' ) 				
	idwFicGenCmde.SetItem ( lRow, "CLE_RIB",			'' ) 	

	//* #2 [FNAC_PROD_ECH_TECH] 
	//* #7 [DCMP090109] 
	If sAction = "A_DIAGNOSTIQUER" Or sAction = "A_REPARER"Then
		Choose case idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) 
				
			Case 415, 905, 910, 915, 920, 936, 941, 1010 // On ne met le RIB que sur 'A_DIAGNOSTIQUER' et les process suivant
				idwFicGenCmde.SetItem ( lRow, "MDE_RGLT",			idwFicCharg.GetItemString ( lCpt, "COD_MODE_REG" ) ) 				
				idwFicGenCmde.SetItem ( lRow, "CDE_BANQUE",		idwFicCharg.GetItemString ( lCpt, "RIB_BQ" ) ) 				
				idwFicGenCmde.SetItem ( lRow, "CDE_GUICHET",		idwFicCharg.GetItemString ( lCpt, "RIB_GUI" ) ) 				
				idwFicGenCmde.SetItem ( lRow, "NUM_CPTE",			idwFicCharg.GetItemString ( lCpt, "RIB_CPT" ) ) 				
				idwFicGenCmde.SetItem ( lRow, "CLE_RIB",			idwFicCharg.GetItemString ( lCpt, "RIB_CLE" ) ) 	
		End Choose
	End If
	//* :#2 [FNAC_PROD_ECH_TECH] 
	
	idwFicGenCmde.SetItem ( lRow, "MT_FRAIS",			idwFicCharg.GetItemDecimal ( lCpt, "MT_DEVIS" ) )
	idwFicGenCmde.SetItem ( lRow, "ASSUREUR",			idwFicCharg.GetItemString ( lCpt, "ASSUREUR" ) )
	// [DCMP080162] AJout Valeur Publique d'achat et Date Achat ( note : date stockée sous forme de chaine )
	idwFicGenCmde.SetItem ( lRow, "DTE_ACHAT",		idwFicCharg.GetItemString ( lCpt, "DTE_ACHAT" ) )


	//* #2 [FNAC_PROD_ECH_TECH] 
	idwFicGenCmde.SetItem ( lRow, "COD_MAG",		"") 				
// #9 [DCMP090327].[SBETV].[20091125155555450]
//	idwFicGenCmde.SetItem ( lRow, "ADR_MAG",		"" ) 				
	idwFicGenCmde.SetItem ( lRow, "ADR_1_MAG",	"" )
	idwFicGenCmde.SetItem ( lRow, "ADR_2_MAG",	"" )
	idwFicGenCmde.SetItem ( lRow, "ADR_CP_MAG", "" )
	idwFicGenCmde.SetItem ( lRow, "ADR_VILLE_MAG", "" )	
// :#9 [DCMP090327].[SBETV].[20091125155555450]
	idwFicGenCmde.SetItem ( lRow, "CONTACT_MAG",	"" ) 				
	idwFicGenCmde.SetItem ( lRow, "NUM_TEL_MAG",	"" ) 				
	idwFicGenCmde.SetItem ( lRow, "NUM_FAX_MAG",	"" ) 					

	idwFicGenCmde.SetItem ( lRow, "ADR_MAIL_MAG",	"" ) 					
	
	If sAction = 'A_DIAGNOSTIQUER' Then
		Choose Case idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) 

			//* #4 [FNAC_PROD_ECH_TECH].[20090225143455120] ajout 906, 911
			Case 1115 // On ne mets les infos FNAC que pour les process suivants
				idwFicGenCmde.SetItem ( lRow, "COD_MAG",			idwFicCharg.GetItemString ( lCpt, "COD_MAG" ) ) 				
				idwFicGenCmde.SetItem ( lRow, "ADR_1_MAG",		idwFicCharg.GetItemString ( lCpt, "ADR_1_MAG" ) )
				idwFicGenCmde.SetItem ( lRow, "ADR_2_MAG",		idwFicCharg.GetItemString ( lCpt, "ADR_2_MAG" ) )
				idwFicGenCmde.SetItem ( lRow, "ADR_CP_MAG",		idwFicCharg.GetItemString ( lCpt, "ADR_CP_MAG" ) )
				idwFicGenCmde.SetItem ( lRow, "ADR_VILLE_MAG",	idwFicCharg.GetItemString ( lCpt, "ADR_VILLE_MAG" ) )
				idwFicGenCmde.SetItem ( lRow, "CONTACT_MAG",		idwFicCharg.GetItemString ( lCpt, "RESPONSABLE_MAG" ) ) 				
				idwFicGenCmde.SetItem ( lRow, "NUM_TEL_MAG",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL_MAG" ) ) 				
				idwFicGenCmde.SetItem ( lRow, "NUM_FAX_MAG",			idwFicCharg.GetItemString ( lCpt, "ADR_FAX_MAG" ) ) 				
				idwFicGenCmde.SetItem ( lRow, "ADR_MAIL_MAG",	idwFicCharg.GetItemString ( lCpt, "ADR_MAIL_MAG1" ) ) 				
	
		End Choose
	End If
	

	If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
	sInfoSpbFrnCplt += "COD_CIV_COURTE=" + idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV" )

	If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
	sInfoSpbFrnCplt += "COD_CIV_LONGUE=" + idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV_LONG" )	
	
	idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	sInfoSpbFrnCplt  )
	//* :#2 [FNAC_PROD_ECH_TECH]

Next

This.uf_nom_fichier ( sNomFic, lCptProd )
iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, TRue ) // True : On indique les en-tetes

If iRet > 0 Then
	This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
Else
	iRet = -1
	This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
End If

Return iRet 
end function

private function integer uf_generer_fichier_fnac (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_fnac (PRIVATE)
//* Auteur			: FPI
//* Date				: 27/10/2009
//* Libellé			: [FNAC_EPT.BGE].FPI Génération du fichier de commande pour le traitement BGE FNAC EPT
//* Commentaires	: [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    09/11/2009  [FNAC_PROD_ECH_TECH].[BGE].[20091109173744030]
// 		 FPI	  22/09/2010  [PC282] Ajout envoi de mail pour BGE
//        JFF    15/07/2011  [PC501][EVOLPC]
//*-----------------------------------------------------------------

Int		iRet
Long		lTot, lCpt, lCptCas, lRow, lCptProd, lNewRow
Long 		lIdProd,  lDelaiBGE, lMtCmde, lIdRev, lVal, lCptDp
String	sNomFic, sFiltre, sTypArtNul, sSep, sEnr, sCmdGenLeDate, sCmdGenLeHeure
String  	sValCar,sUniteBGE
Datetime dtValideLe
Date dtPeremptionBGE
Long lDeb, lFin
Long lTabIdSin[]
String sCasRetour

n_cst_string nvString
n_cst_attrib_key	lnv_Key[] 			

iRet = 1
sSep=";"
sNomFic = K_FIC7 // #1 [FNAC_PROD_ECH_TECH].[BGE].[20091109173744030]

/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour FNAC                         */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_FNAC"

For lCptCas = 1 To 2
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération des données de COMMANDES                              */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART = 'CAF' AND COD_ETAT <> 'ANN'"
			sTypArtNul = "commande"
			This.Uf_Trace ( "ECR", "Génération des BGE en cours..." )

		/*------------------------------------------------------------------*/
		/* Génération des données d'ANNULATION des COMMANDES          		  */
		/*------------------------------------------------------------------*/
		CASE 2
			sFiltre = "ID_TYP_ART = 'CAF' AND COD_ETAT = 'ANN'"
			sTypArtNul = "annulation de commandes"
			This.Uf_Trace ( "ECR", "Génération des ANNULATIONS de BGE en cours..." )

	END CHOOSE

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			

	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
	End If

	For lCpt = 1 To lTot

		/*------------------------------------------------------------------*/
		/* Ecriture du détail de commande                                 */
		/*------------------------------------------------------------------*/
		// [PC501][EVOLPC]
	   lIdRev = idwFicCharg.GetItemNumber ( lCpt, "ID_REV" )
		
		// -- TYP - C_PRES
		sEnr = "E " + sSep + &
				 "0100" + sSep 
		
		// -- C_OPE
		if lCptCas = 1 Then
			sEnr += "C" + sSep 
		Else
			sEnr += "S" + sSep 
		End if
		
		// -- N_DGE
		// [PI062] [A_REPRENDRE] mail envoyer à Hélène le 11/01/17
		sEnr += uf_formatchamps ( 7, String(idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )), "0", TRUE ) + &
			String(idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" )) + sSep
		
		// -- D_CRE_BGE
		dtValideLe = idwFicCharg.GetItemDateTime ( lCpt, "VALIDE_LE" )
		sEnr +=  String ( dtValideLe, "ddmmyyyy" )	+ sSep 
		
		// -- D_PER_BGE
		lIdProd = idwFicCharg.GetItemNumber( lCpt, "ID_PROD")
		idwDetPro.Retrieve( lIdProd )
		
		// Recherche de l'option 126 pour FNC
		/*
		lnv_Key[1].iskeyname	 ="ID_FOUR_BGE"
		lnv_Key[1].iakeyvalue = "FNC"
		F_RechDetPro_withkey( lRow, idwDetPro, lIdProd, "-DP", 126, lnv_Key )
		*/
		
		// [PC501][EVOLPC]
		lRow = 0
		F_rechdetpro( lDeb,lFin, idwDetPro, lIdProd,"-DP", 126 )
		For lCptDp = lDeb To lFin
			 sValCar = idwDetPro.GetItemString (lCptDp, "VAL_CAR")
			 If nvString.of_getkeyvalue( sValCar, "ID_FOUR_BGE", ";") = "FNC" Then
				 lVal = idwDetPro.GetItemNumber ( lCptDp, "VAL_NUM" )
				 If ( lVal = -1 And lRow = 0 ) Or ( lIdRev >= lVal and lVal <> -1 ) Then 
					lRow = lCptDp
				 End If
			 End If
		Next 
		// :[PC501][EVOLPC]
		
		sValCar=""
		if lRow > 0 Then sValCar = idwDetPro.GetItemString(lRow, "VAL_CAR")

		lDelaiBGE = Long(nvString.of_getkeyvalue( sValCar, "DELAI_PEREMPTION_BGE", ";"))
		sUniteBGE = nvString.of_getkeyvalue( sValCar, "UNITE_PEREMPTION_BGE", ";")
		
		If IsNull ( lDelaiBGE ) Then lDelaiBGE = 0
		If IsNull ( sUniteBGE ) Then sUniteBGE = ""
		If lDelaiBGE <= 0 Or ( sUniteBGE <> "M" and sUniteBGE <> "A" and sUniteBGE <> "J" ) Then
			iRet = -1
			This.Uf_Trace ( "ECR", "ERREUR dans la récupération du paramètre -DP/126 DELAI_PEREMPTION_BGE et UNITE_PEREMPTION_BGE : le fichier n'est pas généré !!" )
			Return iRet
		End If

		
		dtPeremptionBGE = f_plus_date(Date(dtValideLe), lDelaiBGE,sUniteBGE)
		sEnr +=  String ( dtPeremptionBGE, "ddmmyyyy" )	+ sSep 
				
		// -- C_DEV
		sEnr += "9" + sSep 
		
		// -- M_GAR_ECH
		// La lecture dans un Long est volontaire !! afin de perdre le .00 sur au *100
		lMtCmde = idwFicCharg.GetItemDecimal(lCpt,"MT_TTC_CMDE") * 100 // pour mettre en centimes
		
		sEnr += uf_formatchamps(16,String(lMtCmde), "0", TRUE) + sSep  
			 
		// -- N_BGE
		// [PI062] [A_REPRENDRE] mail envoyer à Hélène le 11/01/17
		sEnr += "0100" + &
			uf_formatchamps(7,String(idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )), "0", TRUE)	  + &
			String(idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" )) + &
			"9" + &
			uf_formatchamps(7,String(lMtCmde), "0", TRUE) + sSep 
				 
		lNewRow = idwFicGenCmde.InsertRow ( 0 )
		idwFicGenCmde.SetItem ( lNewRow, "LIGNE", sEnr )
	
		//	[PC282] 
		If lCptCas=1 Then // Génération de BGE
			F_RechDetPro ( lDeb, lFin, idwDetPro,lIdProd, "-DP", 105) // Gestion FNAC EPT
			If lDeb > 0 Then 
				F_RechDetPro ( lDeb, lFin, idwDetPro, lIdProd, "-DP",104 ) // Gestion suivi dossier par SMS 
				If lDeb > 0 Then 
					// On devra envoyer un SMS à l'assuré
					lTabIdSin[UpperBound(lTabIdSin) + 1] = idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )
				End if
			End if
		End if
		//	:[PC282] 
		
	Next
	
Next

idwFicCharg.SetFilter ( "" )
idwFicCharg.Filter ()
idwFicCharg.Sort ()

If idwFicCharg.RowCount () > 0 Then
	sCmdGenLeDate  = String ( idwFicCharg.GetItemDateTime ( 1, "CMD_GEN_LE" ), "yyyymmdd" )
	sCmdGenLeHeure	= String ( idwFicCharg.GetItemDateTime ( 1, "CMD_GEN_LE" ), "hh:mm:ss" )
Else 
	sCmdGenLeDate  = String ( Today (), "yyyymmdd" )
	sCmdGenLeHeure	= String ( Now (), "hh:mm:ss" )
End If


// Nbre Ligne total dans le fichier hors début et Fin
lTot = idwFicGenCmde.RowCount ()

/*------------------------------------------------------------------*/
/* Ecriture de l'entête de commande                                 */
/*------------------------------------------------------------------*/
sEnr = "D " 																							+ sSep + &
		 "BGE"							  								  								+ sSep + &
		 "FR0000"							  															+ sSep + &
		 "BGESPB  "												  										+ sSep + &
		 "1"												  												+ sSep + &
		 This.uf_formatchamps(5,String(ilIdLotFnc),"0",TRUE)								+ sSep + &
		 sCmdGenLeDate  																				+ sSep + &
		 sCmdGenLeHeure																				+ sSep 
		
lNewRow = idwFicGenCmde.InsertRow ( 1 )
idwFicGenCmde.SetItem ( lNewRow, "LIGNE", sEnr )
	
/*------------------------------------------------------------------*/
/* Ecriture de fin de commandes                                     */
/*------------------------------------------------------------------*/
sEnr = "F " 																							+ sSep + &
		 "BGE" 																							+ sSep + &
		 "FR0000" 																						+ sSep + &
		 "BGESPB  " 																					+ sSep + &
		 "1" 																								+ sSep + &
		 This.uf_formatchamps (5,String(ilIdLotFnc),"0",TRUE) 							+ sSep + &
		  This.uf_formatchamps (10,String(lTot), "0", TRUE)								+ sSep + &
		 sCmdGenLeDate  																				+ sSep + &
		 sCmdGenLeHeure																				+ sSep 
		
lNewRow = idwFicGenCmde.InsertRow ( 0 )
idwFicGenCmde.SetItem ( lNewRow, "LIGNE", sEnr )

// Enregistrement du fichier
This.uf_nom_fichier ( sNomFic, lCptProd )
If iRet > 0 then
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, False )
End If 

If iRet > 0 Then
	This.Uf_Trace ( "ECR", "Fichier des commandes généré avec succès sur : " + Upper ( sNomFic )  )
Else
	iRet = -1
	This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des BGE : le fichier n'est pas généré !!" )
End If

//	[PC282] : envoi des SMS à l'assuré
sCasRetour=Fill(" ",50)

For lDeb=1 to UpperBound(lTabIdSin)
	SQLCA.PS_S11_SMSPUSH_ENVOI_BGE( lTabIdSin[lDeb] , scasretour)
Next
//	:[PC282] 
				
Return iRet 
end function

private function string uf_formatchamps (integer ainbcar, string aschamp, string ascar, boolean abdebut);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_formatchamps ( PRIVATE )
//* Auteur			: F. Pinon
//* Date				: 28/10/2009 10:31:40
//* Libellé			: Ajoute les caractères nécessaires pour que la chaîne retournée fasse la longueur voulue
//* Commentaires	: 
//*
//* Arguments		: ( Val )	Integer	aiNbCar	:	Longueur de la chaîne à retourner
//*					  ( Val )	String	asChamp	:	Chaîne à traiter
//*					  ( Val )	String	asCar		:	Caractère à ajouter
//*					  ( Val )	String	abDebut	:	Caractère à ajouter à gauche ?
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String	sRet

If IsNull ( asChamp ) Then asChamp = ""
If IsNull ( asCar ) Then asCar=" "

if abDebut Then
	sRet = Fill ( asCar, aiNbCar - Len ( asChamp ) ) + asChamp
Else
	sRet = asChamp + Fill ( asCar, aiNbCar - Len ( asChamp ) )
End if

Return sRet
end function

private function integer uf_flaguer_commandes_fnac ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Flaguer_Commandes_Fnac (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 27/10/2009
//* Libellé			: On marque en bases es commandes chargées commé étant générées
//*					  elle ne pouraient être par la suite que regénérées avant la fonction adéquat.
//* Commentaires	: Utilisé pour tout fournisseur standard SPB
//* 					  [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Int iRet 
Long	lTot, lCpt
DateTime	dtNow

iRet = 1
dtNow = DateTime ( Today (), Now () )


/*------------------------------------------------------------------*/
/* Récupération d'un n° de lot de commandes.                        */
/*------------------------------------------------------------------*/
ilIdLotFNC = -1
SQLCA.PS_S03_COMMANDE ( "ID_LOT_FNC", ilIdLotFNC )

If ilIdLotFNC <= 0 Or IsNull ( ilIdLotFNC ) Then

	// RollBack immédiat.
	F_Commit ( SQLCA, False )
	iRet = -1
	This.Uf_Trace ( "ECR", "ERREUR lors de la récupération de l'ID_LOT_FNC, " + String ( ilIdLotFNC ) )
Else
	This.Uf_Trace ( "ECR", "Attribution du n° de lot de commandes : " + String ( ilIdLotFNC ) )
End If

// [ITSM178659]
F_COMMIT ( SQLCA, SQLCA.SQLCODE = 0 Or SQLCA.SQLDBCODE = 0  ) 

/*------------------------------------------------------------------*/
/* Attribution du n° de lot à toutes les lignes chargées.           */
/*------------------------------------------------------------------*/
If iRet > 0 Then
	lTot = idwFicCharg.RowCount ()
	For lCpt = 1 To lTot
		idwFicCharg.SetItem ( lCpt, "ID_LOT_CMD", ilIdLotFNC )
		idwFicCharg.SetItem ( lCpt, "CMD_GEN_LE", dtNow )
		idwFicCharg.SetItem ( lCpt, "CMD_GEN_PAR", stGlb.sCodOper )
	Next

	/*------------------------------------------------------------------*/
	/* Update en base.                                                  */
	/* Les lignes vont être marquées en bases.								  */
	/*------------------------------------------------------------------*/
	If idwFicCharg.Update () > 0 Then
		F_Commit ( SQLCA, True )
		This.Uf_Trace ( "ECR", "Update du marquage réussi, les commandes sont flaguées en base." )
	Else
		iRet = -1
		F_Commit ( SQLCA, False )
		This.Uf_Trace ( "ECR", "ERREUR, Update du marquage en base a échoué." )
	End if
End If


Return iRet

end function

private function integer uf_generer_fichier_mss_diag (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_MSS_DIAG (PRIVATE)
//* Auteur			: PHG
//* Date				: 27/11/2007
//* Libellé			: Génération du fichier de commande pour O2M
//* Commentaires	: [MSS_DIAG]
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	PHG	31/03/2008 	[DCMP080162] AJout Valeur Publique d'achat et Date Achat
//* #2	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
//* #3   JFF   20/10/2008  [FNAC_PROD_ECH_TECH].[20090127140540720]
//* #4   JFF   20/10/2008  [FNAC_PROD_ECH_TECH].[20090225143455120]
//* #7	FPI	20/03/2009	[DCMP090109] O2M devient réparateur d'IPhone
//* #8   JFF   27/03/2009  [DCMP090152] Civ long pour O2M
//* #9   JFF   02/03/2010  [MSS_LOT2]
//			PHG	30/06/2010	[DCMP100420] Le champ num_imei_anc est agrandi à 60, mais limité à 30
//			JFF   11/10/2010  [20101011144634403]
//			JFF	21/03/2010  [VDOC3537]
//*-----------------------------------------------------------------
Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCasNomFic, lCptFrn
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sIdRefFour, sTypArt2, sInfoSpbFrnCplt, sVal, sInfoSpbFrn
n_cst_string lnv_string

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour O2M 								  */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_MSS_DIAG"

/*------------------------------------------------------------------*/
/* Génération du fichier de COMMANDES (CMD)                         */
/*------------------------------------------------------------------*/
//* #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
// sFiltre = "ID_TYP_ART = 'EDI' AND COD_ETAT <> 'ANN'"

For lCptFrn = 1 To 2

	sNomFic = K_FIC2 // "PRS"

	Choose Case lCptFrn 

		Case 1 // Attitude
			This.Uf_Trace ( "ECR", "Génération ordres ATTITUDE en cours..." )
			sFiltre = "COD_ETAT <> 'ANN' AND AIGUI_MS1_ATT=1"
			sTypArt = "Ordre Attitude"
			sTypArtNul = "Ordre Attitude"
			lCasNomFic = 0
		
		Case 2 // MSS
			This.Uf_Trace ( "ECR", "Génération ordres MSS en cours..." )			
			sFiltre = "COD_ETAT <> 'ANN' AND AIGUI_MS1_ATT<>1"
			sTypArt = "Ordre MSS"
			sTypArtNul = "Ordre MSS"
			lCasNomFic = 1

	End Choose
		
	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()
	
	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then This.Uf_Trace ( "ECR", "Aucun " + sTypArtNul + " à générer" )
	
	For lCpt = 1 To lTot
		lRow = idwFicGenCmde.InsertRow ( 0 )
	
	//* #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
		sTypArt2 = idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" ) 

		sInfoSpbFrnCplt = idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" )

		//	[VDOC3537]				
		sInfoSpbFrn = String ( idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) )
	
		// #7 [DCMP090109]
		sAction = idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )
		If sTypArt2 = "PRS" then
			sAction = "A_REPARER"
		End If
		// :#7 [DCMP090109]
		
		Choose Case sTypArt2 
// #9 [MSS_LOT2]
//			Case "BAM", "ALE"
			Case "ACC"
				sAction = "A_COMMANDER"
				
				//	[VDOC3537]				
				sInfoSpbFrn = "1290"
				
// :#9 [MSS_LOT2]				

			Case Else
				sTypArt2 = idwFicCharg.GetItemString ( lCpt, "TYP_APP_SIN" )
			
		End Choose
	//* :#6 [FNAC_PROD_ECH_TECH].[20090127140540720]

		//	[VDOC3537]						
		Choose Case sAction
			Case "PAS_DE_COMMANDE", "PEC_A_RECYCLER", "REFUSE_A_REEXP"
				sInfoSpbFrn = "1290"			
		End Choose

// #9 [MSS_LOT2]
		sVal = Trim ( lnv_string.of_Getkeyvalue( sInfoSpbFrnCplt , "RETOUR_169", ";") )
		If IsNull ( sVal ) Then sVal = ""
		If sVal <> "" Then sAction = sVal
// :#9 [MSS_LOT2]
	
		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_FACTURE", 	idwFicCharg.GetItemString ( lCpt, "NUM_FACT" ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "CODE_PROD", 		String (idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "CIV_CLI", 			idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) + " " + idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_1",				idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_2",				idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CPL",			idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )
		idwFicGenCmde.SetItem ( lRow, "TYP_ART",			sTypArt2 )
		idwFicGenCmde.SetItem ( lRow, "PROBLEME",			idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) )					
		idwFicGenCmde.SetItem ( lRow, "NUM_IMEI_SERIE",	&
										left(trim(idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" ) ), 30 ) ) // [DCMP100420]
		idwFicGenCmde.SetItem ( lRow, "MARQ_APP",			idwFicCharg.GetItemString ( lCpt, "MARQ_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_APP",			idwFicCharg.GetItemString ( lCpt, "MODL_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "NOM_GEST" ) )						
		
		// #7 [DCMP090109] Déplacement de l'armement de sAction
		//sAction = idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )
	
		idwFicGenCmde.SetItem ( lRow, "ACTION", sAction )
		
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "GARANTIE",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN",	sInfoSpbFrn )
	
		
		// [DCMP080162] AJout Valeur Publique d'achat et Date Achat ( note : date stockée sous forme de chaine )
		idwFicGenCmde.SetItem ( lRow, "MT_VAL_ACHAT",	Dec(idwFicCharg.GetItemString ( lCpt, "MT_VAL_ACHAT" )) )
		idwFicGenCmde.SetItem ( lRow, "DTE_ACHAT",		idwFicCharg.GetItemString ( lCpt, "DTE_ACHAT" ) )
	
	
		//* #2 [FNAC_PROD_ECH_TECH] 
		idwFicGenCmde.SetItem ( lRow, "COD_MAG",		"") 				
		idwFicGenCmde.SetItem ( lRow, "ADR_1_MAG",	"" )
		idwFicGenCmde.SetItem ( lRow, "ADR_2_MAG",	"" )
		idwFicGenCmde.SetItem ( lRow, "ADR_CP_MAG", "" )
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE_MAG", "" )	
		idwFicGenCmde.SetItem ( lRow, "CONTACT_MAG",	"" ) 				
		idwFicGenCmde.SetItem ( lRow, "NUM_TEL_MAG",	"" ) 				
		idwFicGenCmde.SetItem ( lRow, "NUM_FAX_MAG",	"" ) 					
	
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL_MAG",	"" ) 					
		
		If sAction = "A_DIAGNOSTIQUER" Then
			Choose Case idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) 
	
				//* #4 [FNAC_PROD_ECH_TECH].[20090225143455120] ajout 906, 911
				//* 1261 annulé au profit de 1264
				Case 1240, 1260, 1264 // On ne mets les infos FNAC que pour les process suivants
					idwFicGenCmde.SetItem ( lRow, "COD_MAG",			idwFicCharg.GetItemString ( lCpt, "COD_MAG" ) ) 				
					idwFicGenCmde.SetItem ( lRow, "ADR_1_MAG",		idwFicCharg.GetItemString ( lCpt, "ADR_1_MAG" ) )
					idwFicGenCmde.SetItem ( lRow, "ADR_2_MAG",		idwFicCharg.GetItemString ( lCpt, "ADR_2_MAG" ) )
					idwFicGenCmde.SetItem ( lRow, "ADR_CP_MAG",		idwFicCharg.GetItemString ( lCpt, "ADR_CP_MAG" ) )
					idwFicGenCmde.SetItem ( lRow, "ADR_VILLE_MAG",	idwFicCharg.GetItemString ( lCpt, "ADR_VILLE_MAG" ) )
					idwFicGenCmde.SetItem ( lRow, "CONTACT_MAG",		idwFicCharg.GetItemString ( lCpt, "RESPONSABLE_MAG" ) ) 				
// [20101011144634403]
					idwFicGenCmde.SetItem ( lRow, "NUM_TEL_MAG",			Left ( F_REMPLACE ( idwFicCharg.GetItemString ( lCpt, "ADR_TEL_MAG" ), " ", "" ), 15 ) )
// [20101011144634403]					
					idwFicGenCmde.SetItem ( lRow, "NUM_FAX_MAG",			idwFicCharg.GetItemString ( lCpt, "ADR_FAX_MAG" ) ) 				
					idwFicGenCmde.SetItem ( lRow, "ADR_MAIL_MAG",	idwFicCharg.GetItemString ( lCpt, "ADR_MAIL_MAG1" ) ) 				
		
			End Choose
		End If
		
		//* #8 [DCMP090152] 
	/*
		If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
		sInfoSpbFrnCplt += "COD_CIV_COURTE=" + idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV" )
	
		If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
		sInfoSpbFrnCplt += "COD_CIV_LONGUE=" + idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV_LONG" )	
	*/	
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	sInfoSpbFrnCplt  )
		//* :#2 [FNAC_PROD_ECH_TECH]
	
	Next
	
	This.uf_nom_fichier ( sNomFic, lCasNomFic )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, FALSE ) // True : On indique les en-tetes
	
	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
	End If
Next

Return iRet 
end function

private function integer uf_generer_fichier_auchan (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_Auchan (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/07/2010
//* Libellé			: Génération du fichier de commande pour le Micromania
//* Commentaires	: [PC363_AUCHAN]
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF		07/05/2004 DCMP 040134 D. Bizien A-NOVO souhaite l'ID_PROD plutot que le LIB_PROD
//* #2	 JCA		28/02/2008 DCMP 080158 - Changement de format du fichier
//* #3    JFF     02/12/2008 BUG remonté par David Ibersien
//*       JFF     10/06/2010 [PC419/440/418/439_MICROMANIA]
//*       JFF     22/02/2011 [PC363_AUC].[ECL_FICH]
// 		FPI		05/10/2011	[VDoc5352] correction (déplacer)
//*		FPI	23/07/2024	[MIG_PB2022] Sauvegarde Excel! remplacée par Excel8!
//       JFF   18/02/2025 [PMO268_MIG65]
//			JFF 	14/05/2025 [AGM83][20250514174847937]
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd, lIdprodSav
String	sNomFic, sNomFicOrig, sTypArt, sAction, sFiltre, sTypArtNul, sLibCplt, sFiltreSFR, sNomFicSav, sInfoSpbFrnCplt, sVal
String sIdprodSav, sIdprodLu
n_cst_string lnvPFCString  

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le A-NOVO                   */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_auchan"

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier spéciale pour MCM								  */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "COD_ETAT <> 'ANN'"
			sNomFic = K_FIC8
			sTypArt = "Bon cadeau"
			sTypArtNul = "Bon cadeau"
			sAction = "CMDE_BON_CADEAU"
			This.Uf_Trace ( "ECR", "Génération du fichier des BON CADEAUX AUCHAN en cours..." )


	END CHOOSE

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucun " + sTypArtNul + " à générer" + sLibCplt )
		This.uf_nom_fichier ( sNomFic, lCptProd )
		sNomFic = F_Remplace ( sNomFic, "[PRODUIT]", "Aucun_" )
		iRet = idwFicGenCmde.SaveAs ( sNomFic, Excel8!, True ) // [MIG_PB2022]
/* #3
		Choose Case lCptCas
			Case 2
				// Pour le cas PRS on génére un fichier vide (s'il doit être vide).

			Case Else
				Continue
		End Choose
*/		
	End If

	For lCpt = 1 To lTot

		lRow = idwFicGenCmde.InsertRow ( 0 )
		
		idwFicGenCmde.SetItem ( lRow, "IDENT_ENRG",		"S00" )
		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )			
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_PART", 	"AUCHAN" )
		idwFicGenCmde.SetItem ( lRow, "NOM_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) ) 
		idwFicGenCmde.SetItem ( lRow, "NUM_CONTRAT", 	idwFicCharg.GetItemString ( lCpt, "LIB_POLICE" ) ) 
		idwFicGenCmde.SetItem ( lRow, "NUM_PROD", 		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ) ) // [AGM83][20250514174847937]
		idwFicGenCmde.SetItem ( lRow, "CIV_LONGUE",		idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV_LG" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) )
		idwFicGenCmde.SetItem ( lRow, "PRENOM",			idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CPL",	idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "MT_CC",			String ( idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) ) )				
		idwFicGenCmde.SetItem ( lRow, "LIB_APP_SIN",		idwFicCharg.GetItemString ( lCpt, "LIB_TYP_APP_SIN" ) )		
		
		sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))
		sVal = ""
		If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
			sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "DUR_VAL_CC", ";")
		End If
		idwFicGenCmde.SetItem ( lRow, "DUR_VAL_CC",	sVal )		

		idwFicGenCmde.SetItem ( lCpt, "DTE_ENV_CC_AUC", "jj/mm/aaaa"  ) // [VDoc5352]

	Next

	// [PC363_AUC].[ECL_FICH]
	This.uf_nom_fichier ( sNomFic, lCptProd )
	sNomFicOrig = sNomFic
	lTot = idwFicGenCmde.RowCount ()
	idwFicGenCmde.SetSort ( "NOM_PROD A" )
	idwFicGenCmde.Sort ()
	
	sIdprodSav = ""
	lRow = 1
		
	Do While lRow <= lTot
		
		sIdProdLu = Trim ( idwFicGenCmde.GetItemString ( lRow, "NUM_PROD" ))
		
		If sIdprodSav = sIdProdLu  Then 
			lRow ++
			Continue
		End If 

		sIdprodSav = sIdprodLu
		
		idwFicGenCmde.SetFilter ( "NUM_PROD = '" + sIdProdLu + "'" )
		idwFicGenCmde.Filter ()

		sNomFic = F_Remplace ( sNomFicOrig, "[PRODUIT]", sIdProdLu + "_" )
		iRet = idwFicGenCmde.SaveAs ( sNomFic, Excel8!, True ) // [MIG_PB2022]
		If iRet > 0 Then
			This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic ) + " " + sLibCplt )
		Else
			iRet = -1
			This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + ", " + sLibCplt + " : le fichier n'est pas généré !!" )
			Exit
		End If

		idwFicGenCmde.SetFilter ( "" )
		idwFicGenCmde.Filter ()
		idwFicGenCmde.Sort ()
		lRow ++
		
	Loop
	// :[PC363_AUC].[ECL_FICH]

	// ON continue en écrivant le fichier XML pour les courriers.
	/* [PMO268_MIG65]
	If iRet > 0 Then
		sNomFic = Left ( sNomFicOrig, Len ( sNomFicOrig ) - 4 ) + ".XML"
		iRet = This.uf_Generer_Fichier_Auchan_XML ( sNomFic, alIdLotCmd )
	End If
	*/

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_carrefour (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_CARREFOUR (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 08/11/2010
//* Libellé			: Génération du fichier de commande pour le fournisseur BRIGHTPOINT
//* Commentaires	: Trois fichiers seront générés dans le même répertoires :
//*					  un pour les commandes   : CMDjjmma.ind  (CMD10091.001)
//*					  un pour les prestations : PRSjjmma.ind  (PRS10091.001)
//*					  un pour les annulations : ANNjjmma.ind  (ANN10091.001)
//*					  [PC301].[LOT2]
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 17/10/2002	  Modification SFR : Pour ce produit (5712), on
//*								  crée un fichier supplémentaire pour chaque type (cmd, prs, annul ...)
//*								  et on les écrit dans un répertoire spécifique
//*								  Annexe 7 (6.7.2) dans l'intégration de SFR, analyse des traitements
//*
//* #4	 JFF	 07/04/2003   Ajout de l'ID_REF_FOUR et MT_TTC_CMDE
//* #5	 CAG	 06/05/2003	  Génération d'un fichier vide de cmde qd pas de cmdes
//			FPI	06/08/2014		[VDoc14815]
//			FPI	13/04/2016		[VDOC20517]
//			FPI	23/07/2024		[MIG_PB2022] Sauvegarde Excel! remplacée par Excel8!
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sIdRefFour 

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le BRIGHTPOINT               */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_CARREFOUR2" // [VDOC14815]

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC1
			sTypArt = "commandes"
			sTypArtNul = "commande"
			sAction = "A COMMANDER"
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )



	END CHOOSE

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) + " " + idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "REF_FOURN",		idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) + " " + idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )						

		sIdRefFour = idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )
		sIdRefFour = Mid (sIdRefFour, 5, Len ( sIdRefFour ) )
		idwFicGenCmde.SetItem ( lRow, "EAN", sIdRefFour  ) 				
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )			
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR",	F_GetItem3 ( idwFicCharg, lCpt, "ADR_LIVR1" ) + " " + F_GetItem3 ( idwFicCharg, lCpt, "ADR_LIVR2" ) + " " + F_GetItem3 ( idwFicCharg, lCpt, "ADR_LIVR_CPL" ) )

		idwFicGenCmde.SetItem ( lRow, "IMM_PAV",		idwFicCharg.GetItemString ( lCpt, "ADR_IMM_PAV" ) )		
		idwFicGenCmde.SetItem ( lRow, "ETAGE",	idwFicCharg.GetItemString ( lCpt, "ADR_IMM_ETG" ) )		

		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "COMMENTAIRE",			idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) )						

		idwFicGenCmde.SetItem ( lRow, "REPRISE",	idwFicCharg.GetItemString ( lCpt, "LIB_INFO_SPB_FRN" ) ) 

		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )

		// [VDOC14815]
		idwFicGenCmde.SetItem ( lRow, "MARQ_APP",			idwFicCharg.GetItemString ( lCpt, "MARQ_APP" ) )		
		idwFicGenCmde.SetItem ( lRow, "MODL_APP",			idwFicCharg.GetItemString ( lCpt, "MODL_APP" ) )		

		// [VDOC20517]
		idwFicGenCmde.SetItem ( lRow, "DTE_ADH",		String ( idwFicCharg.GetItemDateTime ( lCpt, "DTE_ADH" ), "dd/mm/yyyy" ) )
		idwFicGenCmde.SetItem ( lRow, "DTE_SURV",		String ( idwFicCharg.GetItemDateTime ( lCpt, "DTE_SURV" ), "dd/mm/yyyy" ) )
		
	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Excel8!, TRUE ) // [MIG_PB2022]

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_carma (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_CARMA (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 08/11/2010
//* Libellé			: Génération du fichier de commande pour le fournisseur BRIGHTPOINT
//* Commentaires	: Trois fichiers seront générés dans le même répertoires :
//*					  un pour les commandes   : CMDjjmma.ind  (CMD10091.001)
//*					  un pour les prestations : PRSjjmma.ind  (PRS10091.001)
//*					  un pour les annulations : ANNjjmma.ind  (ANN10091.001)
//*					  [PC301].[LOT2]
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 17/10/2002	  Modification SFR : Pour ce produit (5712), on
//*								  crée un fichier supplémentaire pour chaque type (cmd, prs, annul ...)
//*								  et on les écrit dans un répertoire spécifique
//*								  Annexe 7 (6.7.2) dans l'intégration de SFR, analyse des traitements
//*
//* #4	 JFF	 07/04/2003   Ajout de l'ID_REF_FOUR et MT_TTC_CMDE
//* #5	 CAG	 06/05/2003	  Génération d'un fichier vide de cmde qd pas de cmdes
// 			FPI	22/07/2013	[PC952]
// 			JFF	21/02/2014	[VDOC13683]
//			FPI	02/02/2015	[VDoc16699] Ajout colonne police
//			FPI 	08/04/2016	[DT176]
//			FPI 	08/04/2016	[VDOC20515]
//			FPI	23/07/2024	[MIG_PB2022] Sauvegarde Excel! remplacée par Excel8!
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sIdRefFour, sInfoSpbFrnCplt, sVal
n_cst_string lnvString

iRet = 1

/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le BRIGHTPOINT               */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_CARMA"

For lCptCas = 1 To 1
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1

			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC1
			sTypArt = "commandes"
			sTypArtNul = "commande"
			sAction = "BA_A_ENVOYER_A_L_ASSURE"
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )
	END CHOOSE

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		// [DT176]
		sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))
		sVal = ""
		If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
			sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "GESTION_ENVOI_BA", ";")
		End If
		
		if sVal="SPB" Then Continue // Cas où le BA est envoyé par SPB
		// :[DT176]
		
		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM",				idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) ) 
		idwFicGenCmde.SetItem ( lRow, "PRENOM",			idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_1",	F_GetItem3 ( idwFicCharg, lCpt, "ADR_LIVR1" ) + " " + F_GetItem3 ( idwFicCharg, lCpt, "ADR_LIVR2" ) + " " + F_GetItem3 ( idwFicCharg, lCpt, "ADR_LIVR_CPL" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )			
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "MT_PEC_BA",		idwFicCharg.GetItemString ( lCpt, "MT_PEC" ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_GTI",			idwFicCharg.GetItemString ( lCpt, "LIB_GTI" ) ) // [PC952]
		idwFicGenCmde.SetItem ( lRow, "DTE_ADH",			String ( idwFicCharg.GetItemDateTime ( lCpt, "DTE_ADH" ), "dd/mm/yyyy" ) ) // [VDOC13683]
		idwFicGenCmde.SetItem ( lRow, "LIB_POLICE",			idwFicCharg.GetItemString ( lCpt, "LIB_POLICE" ) ) // [VDoc16699]
		idwFicGenCmde.SetItem ( lRow, "DTE_SURV",			String ( idwFicCharg.GetItemDateTime ( lCpt, "DTE_SURV" ), "dd/mm/yyyy" ) )  //	[VDOC20515]
	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Excel8!, TRUE ) // [MIG_PB2022]

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

// ON continue en écrivant le fichier XML pour les courriers.
If iRet > 0 Then
	sNomFic = Left ( sNomFic, Len ( sNomFic ) - 4 ) + ".XML"
	iRet = This.uf_Generer_Fichier_carma_XML ( sNomFic, alIdLotCmd )
End If

Return iRet 
end function

private function integer uf_generer_fichier_carma_xml (string asnomfic, long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_carma_XML (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 23/11/2010
//* Libellé			: Génération du fichier des data pour les courriers KSL au format XML
//* Commentaires	: [PC301].[LOT2]
//*
//* Arguments		: String 	asNomFic		Val
//*					  Long 		alIdLotCmd	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Long lTot, iRet, lCpt, lRow
Integer iFic, iWrt, iFicSav, iWrtSav
Datetime dtDatetime
String sVal, sFind, sChaine, sNomFicSav

String sFin, sDeb, sFerm, sTGEnteteVersion, sEgaleGuill, FinGuill

String sTGS, sfTGS
String sTGDoc, sfTGDoc
String sTGSinistre, sfTGSinistre
String sTGC, sfTGC
String sTGCommun, sfTGCommun		
String sTGVirement, sfTGVirement

String sTGcod_produit
String sTGlibelle_produit
String sTGnom_assureur
String sTGnumero_police
String sTGadresse_postale_1
String sTGadresse_postale_2
String sTGadresse_postale_3
String sTGadresse_postale_4
String sTGadresse_postale_5
String sTGadresse_postale_6
String sTGedition_date
String sTGedition_lieu
String sTGcommun_id_sin
String sTGnum_dossier
String sTGciv_longue
String sTGmt_indemnisation
String sTGnom_contrat
String sTGrens_telephone
String sTGrens_fax
String sTGmail_exp
String sTGmail_add_dest
String sTGmail_copie_a_1
String sTGmail_copie_a_2
String sTGmail_canal
String sTGut_resp_edition
String sTGgeneration_doc_tstamp
String sTGannule_et_remplace
String sTGacte_gestion_code
String sTGmaq_code

String sDTCode_Produit, sDTNom_Produit, sDTNom_Assureur, sDTNum_Police
String sDTadresse_postale_1, sDTadresse_postale_2, sDTadresse_postale_3
String sDTadresse_postale_4, sDTadresse_postale_5, sDTadresse_postale_6
String sDTEdition_Date, sDTEdition_Lieu, sDTcommun_id_sin, sDTNum_Dossier
String sDTCivilite_Longue, sDTvirement_mt_reg, sDTNom_Produit_2, sDTRens_Telephone
String sDTRens_Fax, sDTMail_Exp, sDTMail_Add_Dest, sDTMail_Copie_a_1, sDTMail_Copie_a_2
String sDTMail_Canal, sDTUt_Resp_edition, sDTGeneration_Doc_Tstamp, sDTAnnule_et_Remplace
String sDTActe_Gestion_Code, sDTmaq_code

Datastore dsDonneeCourrier
dsDonneeCourrier = Create Datastore 
dsDonneeCourrier.DataObject = "d_trt_fichier_cmde_CARMA_courrier1_xml"
dsDonneeCourrier.SetTransObject ( SQLCA )
lTot = dsDonneeCourrier.Retrieve ( alIdLotCmd, "CMA" )

//dsDonneeCourrier.SaveAs ( "c:\temp\dwXml.xls", Excel!, True )

iRet = 1
iFic = FileOpen ( asNomFic, LineMode!, Write!, LockWrite!, Replace!, EncodingUTF8! )

sNomFicSav = asNomFic
sNomFicSav = F_Remplace ( Upper ( sNomFicSav), "FIC_CMD", "SAV_XML" ) 
iFicSav = FileOpen ( sNomFicSav, LineMode!, Write!, LockWrite!, Replace!, EncodingUTF8! )

If iFic < 0 Or iFicSav < 0 Then Return -1

//======================================= Param TAG =============================================

// Entête 
sTGEnteteVersion = '<?xml version="1.0" encoding="UTF-8" standalone="no" ?>'

// Symboles
sFin = "/" ; sDeb = "<" ; sFerm = ">" ; sEgaleGuill = '="' ; FinGuill = '"'

// Tag Bruts
sTGS				= "S"
sTGDoc			= "Doc"
sTGSinistre		= "Sinistre"
sTGC				= "C"
sTGCommun		= "commun"
sTGVirement		= "virement"

sTGcod_produit			= "Code_produit"
sTGlibelle_produit	= "Nom_produit"
sTGnom_assureur		= "Nom_assureur"
sTGnumero_police		= "Num_police"
sTGadresse_postale_1	= "Adresse_postale_1"
sTGadresse_postale_2	= "Adresse_postale_2"
sTGadresse_postale_3	= "Adresse_postale_3"
sTGadresse_postale_4	= "Adresse_postale_4"
sTGadresse_postale_5	= "Adresse_postale_5"
sTGadresse_postale_6	= "Adresse_postale_6"
sTGedition_date		= "Edition_date"
sTGedition_lieu		= "Edition_lieu"
sTGcommun_id_sin		= "id_sin"
sTGnum_dossier			= "Num_dossier"
sTGciv_longue			= "Civilite_longue"
sTGmt_indemnisation	= "mt_reg"
sTGnom_contrat			= "Nom_contrat"
sTGrens_telephone		= "Rens_telephone"
sTGrens_fax				= "Rens_fax"
sTGmail_exp				= "Mail_exp"
sTGmail_add_dest		= "Mail_Add_Dest"
sTGmail_copie_a_1		= "Mail_Copie_a_1"
sTGmail_copie_a_2		= "Mail_Copie_a_2"
sTGmail_canal			= "Mail_canal"
sTGut_resp_edition	= "Ut_Resp_edition"
sTGgeneration_doc_tstamp= "Generation_Doc_Tstamp"
sTGannule_et_remplace= "Annule_et_remplace"
sTGacte_gestion_code	= "Acte_gestion_code"
sTGmaq_code				= "Maq_code"


// Tag Formatés
sfTGS			 	= sDeb + sFin + sTGS + sFerm
sTGS				= sDeb + sTGS + ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' + sFerm

sfTGDoc			= sDeb + sFin + sTGDoc + sFerm
sTGDoc			= sDeb + sTGDoc + sFerm

sfTGSinistre	= sDeb + sFin + sTGSinistre + sFerm
sTGSinistre	   = sDeb + sTGSinistre + sFerm

sfTGC				= sFin + sFerm
sTGC				= sDeb + sTGC

sfTGVirement	= sFin + sFerm
sTGVirement		= sDeb + sTGVirement		

sfTGCommun		= sFin + sFerm
sTGCommun		= sDeb + sTGCommun

sTGcod_produit 			+= sEgaleGuill 
sTGlibelle_produit 		+= sEgaleGuill 
sTGnom_assureur 			+= sEgaleGuill 
sTGnumero_police 			+= sEgaleGuill 
sTGadresse_postale_1 	+= sEgaleGuill 
sTGadresse_postale_2 	+= sEgaleGuill 
sTGadresse_postale_3 	+= sEgaleGuill 
sTGadresse_postale_4 	+= sEgaleGuill 
sTGadresse_postale_5 	+= sEgaleGuill 
sTGadresse_postale_6 	+= sEgaleGuill 
sTGedition_date 			+= sEgaleGuill 
sTGedition_lieu 			+= sEgaleGuill 
sTGcommun_id_sin 			+= sEgaleGuill 
sTGnum_dossier 			+= sEgaleGuill 
sTGciv_longue 				+= sEgaleGuill 
sTGmt_indemnisation 		+= sEgaleGuill 
sTGnom_contrat 			+= sEgaleGuill 
sTGrens_telephone 		+= sEgaleGuill 
sTGrens_fax 				+= sEgaleGuill 
sTGmail_exp 				+= sEgaleGuill 
sTGmail_add_dest 			+= sEgaleGuill 
sTGmail_copie_a_1 		+= sEgaleGuill 
//sTGmail_copie_a_2 		+= sEgaleGuill 
sTGmail_canal 				+= sEgaleGuill 
sTGut_resp_edition 		+= sEgaleGuill 
sTGgeneration_doc_tstamp+= sEgaleGuill 
sTGannule_et_remplace	+= sEgaleGuill 
sTGacte_gestion_code		+= sEgaleGuill 
sTGmaq_code					+= sEgaleGuill 


//======================================= Param DATA FIXE ======================================

// Aucune

//======================================= ECRITURE =============================================

// Début construction fichier 
iWrt = FileWrite ( iFic, sTGEnteteVersion )
iWrtSav = FileWrite ( iFicSav, sTGEnteteVersion )
If iWrt < 0 Or iWrtSav < 0 Then Return -1

iWrt = FileWrite ( iFic, sTGS )
iWrtSav = FileWrite ( iFicSav, sTGS )
If iWrt < 0 Or iWrtSav < 0 Then Return -1

For lCpt = 1 To lTot

	iWrt = FileWrite ( iFic, sTGDoc )
	iWrtSav = FileWrite ( iFicSav, sTGDoc )
	If iWrt < 0 Or iWrtSav < 0 Then Return -1

// F_GetItem4

		sChaine  = Space (4) + sTGC + Space (1)
		sDTCode_Produit = F_GetItem4 ( dsDonneeCourrier, lCpt, "cod_produit" )
		sChaine += sTGcod_produit + sDTCode_Produit + FinGuill + Space (1)

		sDTNom_Produit = F_GetItem4 ( dsDonneeCourrier, lCpt, "libelle_produit")
		sChaine += sTGlibelle_produit  + sDTNom_Produit  + FinGuill + Space (1)
		
		sDTNom_Assureur = F_GetItem4 ( dsDonneeCourrier, lCpt, "nom_assureur")
		sChaine += sTGnom_assureur  + sDTNom_Assureur  + FinGuill + Space (1)
		
		sDTNum_Police = F_GetItem4 ( dsDonneeCourrier, lCpt, "numero_police")
		sChaine += sTGnumero_police  + sDTNum_Police  + FinGuill + Space (1)
		
		sDTadresse_postale_1 = F_GetItem4 ( dsDonneeCourrier, lCpt, "adresse_postale_1")
		sChaine += sTGadresse_postale_1  + sDTadresse_postale_1  + FinGuill + Space (1)
		
		sDTadresse_postale_2 = F_GetItem4 ( dsDonneeCourrier, lCpt, "adresse_postale_2")
		sChaine += sTGadresse_postale_2  + sDTadresse_postale_2  + FinGuill + Space (1)
		
		sDTadresse_postale_3 = F_GetItem4 ( dsDonneeCourrier, lCpt, "adresse_postale_3")
		sChaine += sTGadresse_postale_3  + sDTadresse_postale_3  + FinGuill + Space (1)
		
		sDTadresse_postale_4 = F_GetItem4 ( dsDonneeCourrier, lCpt, "adresse_postale_4")
		sChaine += sTGadresse_postale_4  + sDTadresse_postale_4  + FinGuill + Space (1)
		
		sDTadresse_postale_5 = F_GetItem4 ( dsDonneeCourrier, lCpt, "adresse_postale_5")
		sChaine += sTGadresse_postale_5  + sDTadresse_postale_5  + FinGuill + Space (1)
		
		sDTadresse_postale_6 = F_GetItem4 ( dsDonneeCourrier, lCpt, "adresse_postale_6")
		sChaine += sTGadresse_postale_6  + sDTadresse_postale_6  + FinGuill + Space (1)
		
		sDTEdition_Date =  F_GetItem4 ( dsDonneeCourrier, lCpt, "edition_date")
		dtDatetime = DateTime ( sDTEdition_Date )
		sDTEdition_Date = String ( dtDatetime, "yyyy-mm-dd hh:mm:ss" )
		sChaine += sTGedition_date  + sDTEdition_Date  + FinGuill + Space (1)
		
		sDTEdition_Lieu =  F_GetItem4 ( dsDonneeCourrier, lCpt, "edition_lieu")
		sChaine += sTGedition_lieu  + sDTEdition_Lieu  + FinGuill + Space (1)
		
		sDTNum_Dossier =  F_GetItem4 ( dsDonneeCourrier, lCpt, "num_dossier")
		sChaine += sTGnum_dossier  + sDTNum_Dossier  + FinGuill + Space (1)
		
		sDTCivilite_Longue = F_GetItem4 ( dsDonneeCourrier, lCpt, "civ_longue")
		sChaine += sTGciv_longue  + sDTCivilite_Longue  + FinGuill + Space (1)
		
		sDTNom_Produit_2 = F_GetItem4 ( dsDonneeCourrier, lCpt, "nom_contrat")
		sChaine += sTGnom_contrat  + sDTNom_Produit_2  + FinGuill + Space (1)
		
		sDTRens_Telephone =  F_GetItem4 ( dsDonneeCourrier, lCpt, "rens_telephone")
		sChaine += sTGrens_telephone  + sDTRens_Telephone  + FinGuill + Space (1)
		
		sDTRens_Fax =  F_GetItem4 ( dsDonneeCourrier, lCpt, "rens_fax")
		sChaine += sTGrens_fax  + sDTRens_Fax  + FinGuill + Space (1)
		
		sDTMail_Exp = F_GetItem4 ( dsDonneeCourrier, lCpt, "mail_exp")
		sChaine += sTGmail_exp  + sDTMail_Exp  + FinGuill + Space (1)
		
		sDTMail_Add_Dest = F_GetItem4 ( dsDonneeCourrier, lCpt, "mail_add_dest")
		sChaine += sTGmail_add_dest  + sDTMail_Add_Dest  + FinGuill + Space (1)
		
		sDTMail_Copie_a_1 =  F_GetItem4 ( dsDonneeCourrier, lCpt, "mail_copie_a_1")
		sChaine += sTGmail_copie_a_1  + sDTMail_Copie_a_1  + FinGuill + Space (1)

		/*
		sDTMail_Copie_a_2 = F_GetItem4 ( dsDonneeCourrier, lCpt, "mail_copie_a_2")
		sChaine += sTGmail_copie_a_2  + sDTMail_Copie_a_2  + Space (1)
		*/
		
		sDTMail_Canal = F_GetItem4 ( dsDonneeCourrier, lCpt, "mail_canal")
		sChaine += sTGmail_canal  + sDTMail_Canal  + FinGuill + Space (1)
		
		sDTUt_Resp_edition = F_GetItem4 ( dsDonneeCourrier, lCpt, "ut_resp_edition")
		sChaine += sTGut_resp_edition  + sDTUt_Resp_edition  + FinGuill + Space (1)
		
		sDTGeneration_Doc_Tstamp = F_GetItem4 ( dsDonneeCourrier, lCpt, "generation_doc_tstamp")
		dtDatetime = DateTime ( sDTGeneration_Doc_Tstamp )
		sDTGeneration_Doc_Tstamp = String ( dtDatetime, "yyyy-mm-dd hh:mm:ss" )
		sChaine += sTGgeneration_doc_tstamp + sDTGeneration_Doc_Tstamp  + FinGuill + Space (1)
		
		sDTAnnule_et_Remplace = F_GetItem4 ( dsDonneeCourrier, lCpt, "annule_et_remplace")
		sChaine += sTGannule_et_remplace + sDTAnnule_et_Remplace  + FinGuill + Space (1)
		
		sDTActe_Gestion_Code = F_GetItem4 ( dsDonneeCourrier, lCpt, "acte_gestion_code")
		sChaine += sTGacte_gestion_code + sDTActe_Gestion_Code  + FinGuill + Space (1)

		sDTMaq_code = F_GetItem4 ( dsDonneeCourrier, lCpt, "maq_code")
		sChaine += sTGMaq_code + sDTMaq_code  + FinGuill 

		sChaine += sfTGC

		iWrt = FileWrite ( iFic, sChaine  )
		iWrtSav = FileWrite ( iFicSav, sChaine  )		
		If iWrt < 0 Or iWrtSav < 0 Then Return -1


		iWrt = FileWrite ( iFic, Space (4) + sTGSinistre )
		iWrtSav = FileWrite ( iFicSav, Space (4) + sTGSinistre )		
		If iWrt < 0 Or iWrtSav < 0 Then Return -1

			sChaine  = Space (8) + sTGCommun + Space (1)
			sDTcommun_id_sin = F_GetItem4 ( dsDonneeCourrier, lCpt, "commun_id_sin")
			sChaine += sTGcommun_id_sin  + sDTcommun_id_sin  + FinGuill 
			sChaine += sfTGCommun 
			iWrt = FileWrite ( iFic, sChaine )
			iWrtSav = FileWrite ( iFicSav, sChaine )			
			If iWrt < 0 Or iWrtSav < 0 Then Return -1
			
			sChaine  = Space (8) + sTGVirement + Space (1)
			sDTvirement_mt_reg = String ( dsDonneeCourrier.GetItemDecimal ( lCpt, "mt_indemnisation" ), "#.00" )
			If IsNull ( sDTvirement_mt_reg ) Then sDTvirement_mt_reg = ""
			sChaine += sTGmt_indemnisation  + sDTvirement_mt_reg  + FinGuill 
			sChaine += sfTGVirement 
			iWrt = FileWrite ( iFic, sChaine )
			iWrtSav = FileWrite ( iFicSav, sChaine )			
			If iWrt < 0 Or iWrtSav < 0 Then Return -1			

		iWrt = FileWrite ( iFic, Space (4) + sfTGSinistre )
		iWrtSav = FileWrite ( iFicSav, Space (4) + sfTGSinistre )
		If iWrt < 0 Or iWrtSav < 0 Then Return -1
	
	iWrt = FileWrite ( iFic, sfTGDoc )
	iWrtSav = FileWrite ( iFicSav, sfTGDoc )	
	If iWrt < 0 Or iWrtSav < 0 Then Return -1
	
Next

iWrt = FileWrite ( iFic, sfTGS )
iWrtSav = FileWrite ( iFicSav, sfTGS )
If iWrt < 0 Or iWrtSav < 0 Then Return -1

iWrt = FileClose ( iFic )
iWrtSav = FileClose ( iFicSav )
If iWrt < 0 Or iWrtSav < 0 Then Return -1

If IsValid ( dsDonneeCourrier ) Then Destroy dsDonneeCourrier 

Return iRet 



end function

private function integer uf_generer_fichier_auchan_xml (string asnomfic, long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_Auchan_XML (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 23/11/2010
//* Libellé			: Génération du fichier des data pour les courriers KSL au format XML
//* Commentaires	: [PC363].[COURRIER]
//*
//* Arguments		: String 	asNomFic		Val
//*					  Long 		alIdLotCmd	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF     22/02/2011 [PC363_AUC].[ECL_FICH]
//        JFF     28/05/2014 [PC786-1_AUCHAN_GEM]
//*-----------------------------------------------------------------

Long lTot, lTotFiltre, iRet, lCpt, lRow, lIdprodSav, lIdProdLu
Integer iFic, iWrt, iFicSav, iWrtSav
Datetime dtDatetime
String sVal, sFind, sChaine, sNomFicOrig, sNomFicSav

String sFin, sDeb, sFerm, sTGEnteteVersion, sEgaleGuill, FinGuill

String sTGS, sfTGS
String sTGDoc, sfTGDoc
String sTGSinistre, sfTGSinistre
String sTGC, sfTGC
String sTGCommun, sfTGCommun		
String sTGVirement, sfTGVirement

String sTGcod_produit
String sTGlibelle_produit
String sTGnom_assureur
String sTGnumero_police
String sTGadresse_postale_1
String sTGadresse_postale_2
String sTGadresse_postale_3
String sTGadresse_postale_4
String sTGadresse_postale_5
String sTGadresse_postale_6
String sTGedition_date
String sTGedition_lieu
String sTGcommun_id_sin
String sTGnum_dossier
String sTGciv_longue
String sTGmt_indemnisation
String sTGnom_contrat
String sTGrens_telephone
String sTGrens_fax
String sTGmail_exp
String sTGmail_add_dest
String sTGmail_copie_a_1
String sTGmail_copie_a_2
String sTGmail_canal
String sTGut_resp_edition
String sTGgeneration_doc_tstamp
String sTGannule_et_remplace
String sTGacte_gestion_code
String sTGmt_franchise
String sTGmaq_code
String sTGnum_gtu			
String sTGgti_52_ouv

String sDTCode_Produit, sDTNom_Produit, sDTNom_Assureur, sDTNum_Police
String sDTadresse_postale_1, sDTadresse_postale_2, sDTadresse_postale_3
String sDTadresse_postale_4, sDTadresse_postale_5, sDTadresse_postale_6
String sDTEdition_Date, sDTEdition_Lieu, sDTcommun_id_sin, sDTNum_Dossier
String sDTCivilite_Longue, sDTvirement_mt_reg, sDTNom_Produit_2, sDTRens_Telephone
String sDTRens_Fax, sDTMail_Exp, sDTMail_Add_Dest, sDTMail_Copie_a_1, sDTMail_Copie_a_2
String sDTMail_Canal, sDTUt_Resp_edition, sDTGeneration_Doc_Tstamp, sDTAnnule_et_Remplace
String sDTActe_Gestion_Code, sDTmt_franchise, sDTmaq_code
String sDTnum_gtu			
String sDTgti_52_ouv

Datastore dsDonneeCourrier
dsDonneeCourrier = Create Datastore 
dsDonneeCourrier.DataObject = "d_trt_fichier_cmde_AUCHAN_courrier1_xml"
dsDonneeCourrier.SetTransObject ( SQLCA )
lTot = dsDonneeCourrier.Retrieve ( alIdLotCmd, "AUC" )

// [PC363_AUC].[ECL_FICH]
dsDonneeCourrier.SetSort ( "COD_PRODUIT A" )
dsDonneeCourrier.Sort () 
// :[PC363_AUC].[ECL_FICH]

// dsDonneeCourrier.SaveAs ( "c:\temp\dwXml.xls", Excel!, True )

//======================================= Param TAG =============================================

// Entête 
sTGEnteteVersion = '<?xml version="1.0" encoding="UTF-8"?>'

// Symboles
sFin = "/" ; sDeb = "<" ; sFerm = ">" ; sEgaleGuill = '="' ; FinGuill = '"'

// Tag Bruts
sTGS				= "S"
sTGDoc			= "Doc"
sTGSinistre		= "Sinistre"
sTGC				= "C"
sTGCommun		= "commun"
sTGVirement		= "virement"

sTGcod_produit			= "Code_produit"
sTGlibelle_produit	= "Nom_produit"
sTGnom_assureur		= "Nom_assureur"
sTGnumero_police		= "Num_police"
sTGadresse_postale_1	= "Adresse_postale_1"
sTGadresse_postale_2	= "Adresse_postale_2"
sTGadresse_postale_3	= "Adresse_postale_3"
sTGadresse_postale_4	= "Adresse_postale_4"
sTGadresse_postale_5	= "Adresse_postale_5"
sTGadresse_postale_6	= "Adresse_postale_6"
sTGedition_date		= "Edition_date"
sTGedition_lieu		= "Edition_lieu"
sTGcommun_id_sin		= "id_sin"
sTGnum_gtu				= "num_garantie"  // [PC786-1_AUCHAN_GEM]
sTGgti_52_ouv			= "gti_52_ouv" // [PC786-1_AUCHAN_GEM]
sTGnum_dossier			= "Num_dossier"
sTGciv_longue			= "Civilite_longue"
sTGmt_indemnisation	= "mt_reg"
sTGnom_contrat			= "Nom_contrat"
sTGrens_telephone		= "Rens_telephone"
sTGrens_fax				= "Rens_fax"
sTGmail_exp				= "Mail_exp"
sTGmail_add_dest		= "Mail_Add_Dest"
sTGmail_copie_a_1		= "Mail_Copie_a_1"
sTGmail_copie_a_2		= "Mail_Copie_a_2"
sTGmail_canal			= "Mail_canal"
sTGut_resp_edition	= "Ut_Resp_edition"
sTGgeneration_doc_tstamp= "Generation_Doc_Tstamp"
sTGannule_et_remplace= "Annule_et_remplace"
sTGacte_gestion_code	= "Acte_gestion_code"
sTGmt_franchise 		= "mt_franchise"
sTGmaq_code				= "Maq_code"

// Tag Formatés
sfTGS			 	= sDeb + sFin + sTGS + sFerm
sTGS				= sDeb + sTGS + ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' + sFerm

sfTGDoc			= sDeb + sFin + sTGDoc + sFerm
sTGDoc			= sDeb + sTGDoc + sFerm

sfTGSinistre	= sDeb + sFin + sTGSinistre + sFerm
sTGSinistre	   = sDeb + sTGSinistre + sFerm

sfTGC				= sFin + sFerm
sTGC				= sDeb + sTGC

sfTGVirement	= sFin + sFerm
sTGVirement		= sDeb + sTGVirement		

sfTGCommun		= sFin + sFerm
sTGCommun		= sDeb + sTGCommun

sTGcod_produit 			+= sEgaleGuill 
sTGlibelle_produit 		+= sEgaleGuill 
sTGnom_assureur 			+= sEgaleGuill 
sTGnumero_police 			+= sEgaleGuill 
sTGadresse_postale_1 	+= sEgaleGuill 
sTGadresse_postale_2 	+= sEgaleGuill 
sTGadresse_postale_3 	+= sEgaleGuill 
sTGadresse_postale_4 	+= sEgaleGuill 
sTGadresse_postale_5 	+= sEgaleGuill 
sTGadresse_postale_6 	+= sEgaleGuill 
sTGedition_date 			+= sEgaleGuill 
sTGedition_lieu 			+= sEgaleGuill 
sTGcommun_id_sin 			+= sEgaleGuill 
sTGnum_dossier 			+= sEgaleGuill 
sTGciv_longue 				+= sEgaleGuill 
sTGmt_indemnisation 		+= sEgaleGuill 
sTGnom_contrat 			+= sEgaleGuill 
sTGrens_telephone 		+= sEgaleGuill 
sTGrens_fax 				+= sEgaleGuill 
sTGmail_exp 				+= sEgaleGuill 
sTGmail_add_dest 			+= sEgaleGuill 
sTGmail_copie_a_1 		+= sEgaleGuill 
//sTGmail_copie_a_2 		+= sEgaleGuill 
sTGmail_canal 				+= sEgaleGuill 
sTGut_resp_edition 		+= sEgaleGuill 
sTGgeneration_doc_tstamp+= sEgaleGuill 
sTGannule_et_remplace	+= sEgaleGuill 
sTGacte_gestion_code		+= sEgaleGuill 
sTGmt_franchise			+= sEgaleGuill 
sTGmaq_code					+= sEgaleGuill 
sTGnum_gtu					+= sEgaleGuill  // [PC786-1_AUCHAN_GEM]
sTGgti_52_ouv				+= sEgaleGuill // [PC786-1_AUCHAN_GEM]

//======================================= Param DATA FIXE ======================================

// Aucune

//======================================= ECRITURE =============================================
// Début construction fichier 

// [PC363_AUC].[ECL_FICH]
lIdprodSav = 0
lRow = 1 
sNomFicOrig = asNomFic

Do While lRow <= lTot 
	
	lIdProdLu = dsDonneeCourrier.GetItemNumber ( lRow, "COD_PRODUIT" )

	If lIdprodSav = lIdProdLu  Then 
		lRow ++
		Continue
	End If 

	lIdprodSav = lIdprodLu
	
	dsDonneeCourrier.SetFilter ( "COD_PRODUIT = " + String ( lIdProdLu ) )
	dsDonneeCourrier.Filter ()
	lTotFiltre = dsDonneeCourrier.RowCount ()
	// [PC363_AUC].[ECL_FICH]
	
	iRet = 1
	asNomFic = F_Remplace ( sNomFicOrig, "[PRODUIT]", String (lIdProdLu) + "_" )	
	iFic = FileOpen ( asNomFic, LineMode!, Write!, LockWrite!, Replace!, EncodingUTF8! )

	sNomFicSav = asNomFic 
	sNomFicSav = F_Remplace ( Upper ( sNomFicSav ) , "FIC_CMD", "SAV_XML" )	
	iFicSav = FileOpen ( sNomFicSav, LineMode!, Write!, LockWrite!, Replace!, EncodingUTF8! )	
	
	If iFic < 0 Then Return -1
	
	iWrt = FileWrite ( iFic, sTGEnteteVersion )
	iWrtSav = FileWrite ( iFicSav, sTGEnteteVersion )
	
	If iWrt < 0 Or iWrtSav < 0 Then Return -1

	iWrt = FileWrite ( iFic, sTGS )
	iWrtSav = FileWrite ( iFicSav, sTGS )
	If iWrt < 0 Or iWrtSav < 0 Then Return -1
	
	For lCpt = 1 To lTotFiltre 
	
		iWrt = FileWrite ( iFic, sTGDoc )
		iWrtSav = FileWrite ( iFicSav, sTGDoc )
		If iWrt < 0 Or iWrtSav < 0  Then Return -1
	
	// F_GetItem4
	
			sChaine  = Space (4) + sTGC + Space (1)
			sDTCode_Produit = F_GetItem4 ( dsDonneeCourrier, lCpt, "cod_produit" )
			sChaine += sTGcod_produit + sDTCode_Produit + FinGuill + Space (1)
	
			sDTNom_Produit = F_GetItem4 ( dsDonneeCourrier, lCpt, "libelle_produit")
			sChaine += sTGlibelle_produit  + sDTNom_Produit  + FinGuill + Space (1)
			
			sDTNom_Assureur = F_GetItem4 ( dsDonneeCourrier, lCpt, "nom_assureur")
			sChaine += sTGnom_assureur  + sDTNom_Assureur  + FinGuill + Space (1)
			
			sDTNum_Police = F_GetItem4 ( dsDonneeCourrier, lCpt, "numero_police")
			sChaine += sTGnumero_police  + sDTNum_Police  + FinGuill + Space (1)
			
			sDTadresse_postale_1 = F_GetItem4 ( dsDonneeCourrier, lCpt, "adresse_postale_1")
			sChaine += sTGadresse_postale_1  + sDTadresse_postale_1  + FinGuill + Space (1)
			
			sDTadresse_postale_2 = F_GetItem4 ( dsDonneeCourrier, lCpt, "adresse_postale_2")
			sChaine += sTGadresse_postale_2  + sDTadresse_postale_2  + FinGuill + Space (1)
			
			sDTadresse_postale_3 = F_GetItem4 ( dsDonneeCourrier, lCpt, "adresse_postale_3")
			sChaine += sTGadresse_postale_3  + sDTadresse_postale_3  + FinGuill + Space (1)
			
			sDTadresse_postale_4 = F_GetItem4 ( dsDonneeCourrier, lCpt, "adresse_postale_4")
			sChaine += sTGadresse_postale_4  + sDTadresse_postale_4  + FinGuill + Space (1)
			
			sDTadresse_postale_5 = F_GetItem4 ( dsDonneeCourrier, lCpt, "adresse_postale_5")
			sChaine += sTGadresse_postale_5  + sDTadresse_postale_5  + FinGuill + Space (1)
			
			sDTadresse_postale_6 = F_GetItem4 ( dsDonneeCourrier, lCpt, "adresse_postale_6")
			sChaine += sTGadresse_postale_6  + sDTadresse_postale_6  + FinGuill + Space (1)
			
			sDTEdition_Date =  F_GetItem4 ( dsDonneeCourrier, lCpt, "edition_date")
			dtDatetime = DateTime ( sDTEdition_Date )
			sDTEdition_Date = String ( dtDatetime, "yyyy-mm-dd hh:mm:ss" )
			sChaine += sTGedition_date  + sDTEdition_Date  + FinGuill + Space (1)
			
			sDTEdition_Lieu =  F_GetItem4 ( dsDonneeCourrier, lCpt, "edition_lieu")
			sChaine += sTGedition_lieu  + sDTEdition_Lieu  + FinGuill + Space (1)
			
			sDTNum_Dossier =  F_GetItem4 ( dsDonneeCourrier, lCpt, "num_dossier")
			sChaine += sTGnum_dossier  + sDTNum_Dossier  + FinGuill + Space (1)
			
			sDTCivilite_Longue = F_GetItem4 ( dsDonneeCourrier, lCpt, "civ_longue")
			sChaine += sTGciv_longue  + sDTCivilite_Longue  + FinGuill + Space (1)
			
			sDTNom_Produit_2 = F_GetItem4 ( dsDonneeCourrier, lCpt, "nom_contrat")
			sChaine += sTGnom_contrat  + sDTNom_Produit_2  + FinGuill + Space (1)
			
			sDTRens_Telephone =  F_GetItem4 ( dsDonneeCourrier, lCpt, "rens_telephone")
			sChaine += sTGrens_telephone  + sDTRens_Telephone  + FinGuill + Space (1)
			
			sDTRens_Fax =  F_GetItem4 ( dsDonneeCourrier, lCpt, "rens_fax")
			sChaine += sTGrens_fax  + sDTRens_Fax  + FinGuill + Space (1)
			
			sDTMail_Exp = F_GetItem4 ( dsDonneeCourrier, lCpt, "mail_exp")
			sChaine += sTGmail_exp  + sDTMail_Exp  + FinGuill + Space (1)
			
			sDTMail_Add_Dest = F_GetItem4 ( dsDonneeCourrier, lCpt, "mail_add_dest")
			sChaine += sTGmail_add_dest  + sDTMail_Add_Dest  + FinGuill + Space (1)
			
			sDTMail_Copie_a_1 =  F_GetItem4 ( dsDonneeCourrier, lCpt, "mail_copie_a_1")
			sChaine += sTGmail_copie_a_1  + sDTMail_Copie_a_1  + FinGuill + Space (1)
	
			/*
			sDTMail_Copie_a_2 = F_GetItem4 ( dsDonneeCourrier, lCpt, "mail_copie_a_2")
			sChaine += sTGmail_copie_a_2  + sDTMail_Copie_a_2  + Space (1)
			*/
			
			sDTMail_Canal = F_GetItem4 ( dsDonneeCourrier, lCpt, "mail_canal")
			sChaine += sTGmail_canal  + sDTMail_Canal  + FinGuill + Space (1)
			
			sDTUt_Resp_edition = F_GetItem4 ( dsDonneeCourrier, lCpt, "ut_resp_edition")
			sChaine += sTGut_resp_edition  + sDTUt_Resp_edition  + FinGuill + Space (1)
			
			sDTGeneration_Doc_Tstamp = F_GetItem4 ( dsDonneeCourrier, lCpt, "generation_doc_tstamp")
			dtDatetime = DateTime ( sDTGeneration_Doc_Tstamp )
			sDTGeneration_Doc_Tstamp = String ( dtDatetime, "yyyy-mm-dd hh:mm:ss" )
			sChaine += sTGgeneration_doc_tstamp + sDTGeneration_Doc_Tstamp  + FinGuill + Space (1)
			
			sDTAnnule_et_Remplace = F_GetItem4 ( dsDonneeCourrier, lCpt, "annule_et_remplace")
			sChaine += sTGannule_et_remplace + sDTAnnule_et_Remplace  + FinGuill + Space (1)
			
			sDTActe_Gestion_Code = F_GetItem4 ( dsDonneeCourrier, lCpt, "acte_gestion_code")
			sChaine += sTGacte_gestion_code + sDTActe_Gestion_Code  + FinGuill + Space (1)
	
			sDTMaq_code = F_GetItem4 ( dsDonneeCourrier, lCpt, "maq_code")
			sChaine += sTGMaq_code + sDTMaq_code  + FinGuill 
	
			sChaine += sfTGC
	
			iWrt = FileWrite ( iFic, sChaine  )
			iWrtSav = FileWrite ( iFicSav, sChaine  )			
			If iWrt < 0 Or iWrtSav < 0 Then Return -1
	
	
			iWrt = FileWrite ( iFic, Space (4) + sTGSinistre )
			iWrtSav = FileWrite ( iFicSav, Space (4) + sTGSinistre )			
			If iWrt < 0 Or iWrtSav < 0 Then Return -1
	
				sChaine  = Space (8) + sTGCommun + Space (1)

				sDTcommun_id_sin = F_GetItem4 ( dsDonneeCourrier, lCpt, "commun_id_sin")
				sChaine += sTGcommun_id_sin  + sDTcommun_id_sin  + FinGuill 

				// [PC786-1_AUCHAN_GEM]
				sChaine += Space (1)

				sDTnum_gtu = F_GetItem4 ( dsDonneeCourrier, lCpt, "num_garantie")
				sChaine += sTGnum_gtu + sDTnum_gtu  + FinGuill + Space (1)
				
				sDTgti_52_ouv = F_GetItem4 ( dsDonneeCourrier, lCpt, "gti_52_ouv")
				sChaine += sTGgti_52_ouv + sDTgti_52_ouv + FinGuill 

				sChaine += sfTGCommun 
				iWrt = FileWrite ( iFic, sChaine )
				iWrtSav = FileWrite ( iFicSav, sChaine )				

				If iWrt < 0 Or iWrtSav < 0 Then Return -1				
				
				sChaine  = Space (8) + sTGVirement + Space (1)
				sDTvirement_mt_reg = String ( dsDonneeCourrier.GetItemDecimal ( lCpt, "mt_indemnisation" ), "#.00" )
				If IsNull ( sDTvirement_mt_reg ) Then sDTvirement_mt_reg = ""
				sChaine += sTGmt_indemnisation  + sDTvirement_mt_reg  + FinGuill + Space (1)
				
				sDTmt_franchise = F_GetItem4 ( dsDonneeCourrier, lCpt, "mt_franchise")
				sChaine += sTGmt_franchise + sDTmt_franchise + FinGuill 
	
				sChaine += sfTGVirement 
				
				iWrt = FileWrite ( iFic, sChaine )
				iWrtSav = FileWrite ( iFicSav, sChaine )

				If iWrt < 0 Or iWrtSav < 0 Then Return -1
	
			iWrt = FileWrite ( iFic, Space (4) + sfTGSinistre )
			iWrtSav  = FileWrite ( iFicSav, Space (4) + sfTGSinistre )			
			If iWrt < 0 Or iWrtSav < 0 Then Return -1
		
		iWrt = FileWrite ( iFic, sfTGDoc )
		iWrtSav = FileWrite ( iFicSav, sfTGDoc )		
		If iWrt < 0 Or iWrtSav < 0 Then Return -1
		
	Next
	
	iWrt = FileWrite ( iFic, sfTGS )
	iWrtSav = FileWrite ( iFicSav, sfTGS )	
	If iWrt < 0 Or iWrtSav < 0 Then Return -1
	
	iWrt = FileClose ( iFic )
	iWrtSav = FileClose ( iFicSav )	
	If iWrt < 0 Or iWrtSav < 0 Then Return -1

	// [PC363_AUC].[ECL_FICH]
	dsDonneeCourrier.SetFilter ( "" )
	dsDonneeCourrier.Filter ()
	dsDonneeCourrier.Sort ()
	lRow ++
	// [PC363_AUC].[ECL_FICH]
	
Loop

If IsValid ( dsDonneeCourrier ) Then Destroy dsDonneeCourrier 

Return iRet 



end function

private function integer uf_generer_fichier_coriolis (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_CORIOLIS (PRIVATE)
//* Auteur			: JFF
//* Date				: 03/05/2011
//* Libellé			: Génération du fichier de commande pour le fournisseur BRIGHTPOINT
//* Commentaires	: Trois fichiers seront générés dans le même répertoires :
//*					  un pour les commandes   : CMDjjmma.ind  (CMD10091.001)
//*					  un pour les prestations : PRSjjmma.ind  (PRS10091.001)
//*					  un pour les annulations : ANNjjmma.ind  (ANN10091.001)
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 17/10/2002	  Modification SFR : Pour ce produit (5712), on
//*								  crée un fichier supplémentaire pour chaque type (cmd, prs, annul ...)
//*								  et on les écrit dans un répertoire spécifique
//*								  Annexe 7 (6.7.2) dans l'intégration de SFR, analyse des traitements
//*
//* #4	 JFF	 07/04/2003   Ajout de l'ID_REF_FOUR et MT_TTC_CMDE
//* #5	 CAG	 06/05/2003	  Génération d'un fichier vide de cmde qd pas de cmdes
//        JFF   05/12/2017   [PM426-1]
// 		 JFF   03/01/2018   [VDOC25374]
// 		 JFF   21/06/2018   [VDOC26276]
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sInfoSpbFrnCplt, sVal, sInfoSpbFrn, sActionOrig
n_cst_string lnvPFCString
Boolean bPM426 // F_CLE_A_TRUE ( "PM426-1" )

iRet = 1
bPM426 = F_CLE_A_TRUE ( "PM426-1" )


/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le BRIGHTPOINT               */
/*------------------------------------------------------------------*/
// [PM426-1]  // F_CLE_A_TRUE ( "PM426-1" )
If bPM426 Then
	idwFicGenCmde.DataObject = "d_trt_fichier_cmde_CORIOLIS_PM426_1"	
Else
	idwFicGenCmde.DataObject = "d_trt_fichier_cmde_CORIOLIS"	
End If


For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC1
			sTypArt = "commandes"
			sTypArtNul = "commande"
			sAction = "A_COMMANDER"
			sActionOrig = sAction 
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )

	End Choose

/* code débile
	If Not bPM426 Then
		sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCptCas, "INFO_SPB_FRN_CPLT" ) ))
	
	
		// [PM246]
		sVal = ""
		If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
			sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "MAJ_ADRESSE", ";")
			If sVal = "OUI" Then
				sAction = "MAJ_ADRESSE"
			End If
		End If		
		// [PM246]	
	End If 
*/		

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		// [VDOC4970]
		// [PM426-1]  // F_CLE_A_TRUE ( "PM426-1" )
		If bPM426 Then
			sInfoSpbFrn = String ( idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) )
			sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))
			
			sAction = sActionOrig

			// [PM246]
			sVal = ""
			If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
				sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "MAJ_ADRESSE", ";")
				If sVal = "OUI" Then
					sAction = "MAJ_ADRESSE"
				End If
			End If		
			// [PM246]	
		End If 		
		

		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) + " " + idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR_CPL",	idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ) )			
		idwFicGenCmde.SetItem ( lRow, "TYP_ART",			idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" ) )			
		idwFicGenCmde.SetItem ( lRow, "MARQ_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "NOM_GEST" ) )						
		idwFicGenCmde.SetItem ( lRow, "ACTION",			sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "ID_GTI",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )				
		idwFicGenCmde.SetItem ( lRow, "ID_REF_FOUR",			idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" ) ) 				
		idwFicGenCmde.SetItem ( lRow, "MT_TTC_CMDE",			String ( idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) ) )				

		// [VDOC25374]
		lnvPFCString.of_Setkeyvalue ( sInfoSpbFrnCplt, "ASSUREUR", idwFicCharg.GetItemString ( lCpt, "ASSUREUR" ), ";")			

		// [PM426-1]  // F_CLE_A_TRUE ( "PM426-1" )
		If bPM426 Then
			idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN",	sInfoSpbFrn )						
			idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	sInfoSpbFrnCplt  )
		End If 

	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, False )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
		
		// [VDOC26276]
		This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic ) 
		
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_psm (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_PSM (PRIVATE)
//* Auteur			: JFF
//* Date				: 13/02/2012
//* Libellé			: Génération du fichier de commande pour le fourniseur CORDON
//* Commentaires	: 
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF		07/05/2004 DCMP 040134 D. Bizien A-NOVO souhaite l'ID_PROD plutot que le LIB_PROD
//* #2	 JFF 	 	12/12/2005 DCMP 050649 M. LEGAC, ajout Zone pour AEVUM
//* #3	 MADM 	09/05/2006 DCMP 060356 Remplacement du fournisseur AEVUM par CORDON
//* #4    MADM    19/06/2006 DCMP 060447 Ajout de la zone INFO_SPB_FRN
//*       JFF     19/09/2011   [PM82][LOT1]
//*       JFF     19/09/2011   [PM82][LOT2]
//        JFF     17/04/2012   [PM200][LOT2][DESOX]
// 		 JFF	   03/07/2012   [MANTIS3743]
// 		 JFF	   23/11/2012   [VDOC9111]
//        JFF     26/11/2012   [PC877]
//        JFF     07/05/2013   [PC929-1]
//        JFF     07/05/2013   [VDOC11610]
//        JFF     09/09/2013   [PM222-1]
//        JFF     13/01/2014   [PM246]
//        JFF     02/06/2014   [PC929_CDISCOUNT][PC929-2-V3]
//        JFF     30/11/2015   [DT150-1]
//        JFF     31/03/2016   [PM287-3]
// 		JFF   12/05/2016 [VDOC20847]
//       JFF   29/08/2016 [DT200-1]
// 		JFF   03/01/2018 [VDOC25374]
// 		JFF   21/06/2018 [VDOC26276]
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd, lIdEvt, lDebCpt, lFinCpt
String	sNomFic, sTypArt, sFiltre, sTypArtNul, sLibCplt, sFiltreSFR, sNomFicSav, sInfoSpbFrnCplt , sVal, sInfoFrnSpbCplt 
n_cst_string lnvPFCString
String sTypArt2, sAction

iRet = 1
/*------------------------------------------------------------------------------------*/
/* Format du fichier de commandes pour le frn AEVUM/AVM           						  */
/* #3	 MADM	 09/05/06	  [DCMP060356]: remplacement  du frn AEVUM/AVM par CORDON/COR */
/*------------------------------------------------------------------------------------*/
// [PM200][LOT2][DESOX]
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_PSM"

/* -- Retrait script quotidien le 03/07/2023
-- Début [VDOC11610] - JFF - A. Rault - 19/07/2013
	print 'Début [VDOC11610] - JFF - A. Rault - 19/07/2013'
	Update sysadm.cle Set valeur = 1, maj_le = getdate(), maj_par = 'JFF' Where id_cle = 'VDOC11610'
	print 'Fin [VDOC11610] - JFF - A. Rault - 19/07/2013'
-- Fin [VDOC11610] - JFF - A. Rault - 19/07/2013
*/

// [VDOC11610]
If F_CLE_A_TRUE ( "VDOC11610" ) Then
	lDebCpt = 5
	lFinCpt = 5
Else
	lDebCpt = 1
	lFinCpt = 4
End If	

For lCptCas = lDebCpt To lFinCpt
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de PRESTATIONS (PRS)                       */
		/*------------------------------------------------------------------*/
		// [PM82][LOT1] Simplification
		// [MANTIS3743]
		CASE 1
			sFiltre = "ID_TYP_ART IN ( 'PRS', 'EDI') AND COD_ETAT <> 'ANN' AND POS ( ID_REF_FOUR, 'A_DESOXYDER') = 0"
			sNomFic = K_FIC2				
			
			sTypArt = "prestations"
			sTypArtNul = "prestation"
			
			This.Uf_Trace ( "ECR", "Génération du fichier de REPARATION en cours..." )

		CASE 2
			sFiltre = "ID_TYP_ART IN ( 'PRS', 'EDI') AND COD_ETAT <> 'ANN' AND POS ( ID_REF_FOUR, 'A_DESOXYDER') > 0"
			sNomFic = K_FIC9 				
			
			sTypArt = "prestations"
			sTypArtNul = "prestation"

			This.Uf_Trace ( "ECR", "Génération du fichier de D'OXYDATION en cours..." )				


		CASE 3
			Continue

		CASE 4
			sFiltre = "ID_TYP_ART IN ( 'REL') AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC14
			sTypArt = "prestations relai"
			sTypArtNul = "prestation relai"
			This.Uf_Trace ( "ECR", "Génération du fichier des REPARATION RELAI en cours..." )

		CASE 5
				sFiltre = ""
				sNomFic = K_FIC2
				sTypArt = "prestations"
				sTypArtNul = "prestation"
				This.Uf_Trace ( "ECR", "Génération du fichier des prestations en cours..." )




	END CHOOSE

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" + sLibCplt )
		Choose Case lCptCas
			Case 2
				// Pour le cas PRS on génére un fichier vide (s'il doit être vide).

			Case Else
				Continue
		End Choose
	End If

	For lCpt = 1 To lTot

		lRow = idwFicGenCmde.InsertRow ( 0 )

		sTypArt2 = idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" )
		sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))
		// [DT150]
		sInfoFrnSpbCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_FRN_SPB_CPLT" ) ))		

		// [DT150-1]
		sAction = idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )

		// [DT150-1]
		/*
			sVal = lnvPFCString.of_Getkeyvalue ( sInfoFrnSpbCplt, "GEOLOC", ";")
			If sVal = "SUPP" Then
				sAction = "GEOLOC_SUPP"
			End If
		*/

		// [PM287-3]
		sVal = lnvPFCString.of_Getkeyvalue ( sInfoFrnSpbCplt, "IFDNMQ_ACT", ";")
		If sVal = "FAIT" Then
			sAction = "IFDNMQ_FAIT"
		End If

		// [DT200-1]
		sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt, "NE_PAS_REPARER", ";")
		If sVal = "OUI" Then
			sAction = "NE_PAS_REPARER"
		End If

		// [PM166][O2M]
		Choose Case sTypArt2
			Case "EDI", "PRS"
	
				sTypArt2 = idwFicCharg.GetItemString ( lCpt, "TYP_APP_SIN" )

		End Choose
		
		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )

		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )

		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_PROD", 		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) + " " + idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR_CPL",	idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			

		// [BUG_MAIL_PSM]
		sVal = Trim ( idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ))
		If sVal = "" Or IsNull ( sVal) Then
			sVal = Trim ( lnvPFCString.of_getkeyvalue (sInfoSpbFrnCplt, "MAIL_ASSURE", ";"))
			If sVal = "" Or IsNull ( sVal) Then sVal = ""
		End If
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			sVal  )									
		
		idwFicGenCmde.SetItem ( lRow, "TYP_ART",			sTypArt2 )			
		idwFicGenCmde.SetItem ( lRow, "PROBLEME",			idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) )					
		idwFicGenCmde.SetItem ( lRow, "NUM_IMEI_ANC",	idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" ) )						

		idwFicGenCmde.SetItem ( lRow, "MARQ_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )						
		
		idwFicGenCmde.SetItem ( lRow, "ACTION",			sAction  )

			
		// [PM82][LOT2]
		sVal = ""
		If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
			sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_REPARER_SAV", ";")
			If sVal = "OUI" Then
				idwFicGenCmde.SetItem ( lRow, "ACTION", "A_REPARER_SAV" )
			End If
		End If
		// [PM82][LOT2]	
		
		// [PM222-1]
		sVal = ""
		If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
			sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_CONTROLER_SAV", ";")
			If sVal = "OUI" Then
				idwFicGenCmde.SetItem ( lRow, "ACTION", "A_CONTROLER_SAV" )
			End If
		End If
		// [PM222-1]	
		

		// [PM200][LOT2][DESOX]
		sVal = ""
		If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
			sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_DESOXYDER_SAV", ";")
			If sVal = "OUI" Then
				idwFicGenCmde.SetItem ( lRow, "ACTION", "A_DESOXYDER_SAV" )
			End If
		End If		
		// [PM200][LOT2][DESOX]
		
		// [PM246]
		sVal = ""
		If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
			sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "MAJ_ADRESSE", ";")
			If sVal = "OUI" Then
				idwFicGenCmde.SetItem ( lRow, "ACTION", "MAJ_ADRESSE" )
			End If
		End If		
		// [PM246]
		
		// [VDOC9111]
		lnvPFCString.of_Setkeyvalue ( sInfoSpbFrnCplt, "LIB_PROD", idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ), ";")

		// [VDOC20847]
		lnvPFCString.of_Setkeyvalue ( sInfoSpbFrnCplt, "POLICE", idwFicCharg.GetItemString ( lCpt, "LIB_POLICE" ), ";")			
		
		// [VDOC25374]
		lnvPFCString.of_Setkeyvalue ( sInfoSpbFrnCplt, "ASSUREUR", idwFicCharg.GetItemString ( lCpt, "ASSUREUR" ), ";")			
		
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "ID_GTI",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )				
		// #4
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN",	String ( idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) ) )
		
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	sInfoSpbFrnCplt  )				

	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, False )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic ) + " " + sLibCplt )
		
		// [VDOC26276]
		This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic ) 
		
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + ", " + sLibCplt + " : le fichier n'est pas généré !!" )
		Exit
	End If


	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_ore (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_ORE (PRIVATE)
//* Auteur			: FPI
//* Date				: 22/08/2012
//* Libellé			: Génération du fichier de commande pour le ORE
//* Commentaires	: Trois fichiers seront générés dans le même répertoires :
//*					  un pour les commandes   : CMDjjmma.ind  (CMD10091.001)
//*					  un pour les prestations : PRSjjmma.ind  (PRS10091.001)
//*					  un pour les annulations : ANNjjmma.ind  (ANN10091.001)
//*					  [PC767]
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//		FPI	23/07/2024	[MIG_PB2022] Sauvegarde Excel! remplacée par Excel8!
//*-----------------------------------------------------------------

Int	iRet, iFic
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sEnrg, sSep, sVal

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le ORE                   */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_ORE"

For lCptCas = 1 To 4
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC1
			sTypArt = "commandes"
			sTypArtNul = "commande"
			sAction = "A_COMMANDER"
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )

		/*------------------------------------------------------------------*/
		/* Génération du fichier de PRESTATIONS (PRS)                       */
		/*------------------------------------------------------------------*/
		CASE 2
			sFiltre = "ID_TYP_ART = 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = "REP"
			sTypArt = "prestations"
			sTypArtNul = "prestation"
			sAction = "A_REPARER"
			This.Uf_Trace ( "ECR", "Génération du fichier de PRESTATIONS en cours..." )
			idwFicGenCmde.DataObject = "d_trt_fichier_cmde_ORE_PRS"
			
		/*------------------------------------------------------------------*/
		/* Génération du fichier des ANNULATION des COMMANDES (ACD)			  */
		/*------------------------------------------------------------------*/
		CASE 3
			/*sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT = 'ANN'"
			sNomFic = K_FIC3
			sTypArt = "annulations de commandes"
			sTypArtNul = "annulation de commandes"
			sAction = "A_ANNULER"
			This.Uf_Trace ( "ECR", "Génération du fichier d'ANNULATIONS DES COMMANDES en cours..." )
			*/
			Continue  // [PC767-1] - annulations par mail
		/*------------------------------------------------------------------*/
		/* Génération du fichier des ANNULATION des COMMANDES (APR)			  */
		/*------------------------------------------------------------------*/
		CASE 4
		/*	sFiltre = "ID_TYP_ART = 'PRS' AND COD_ETAT = 'ANN'"
			sNomFic = K_FIC4
			sTypArt = "annulations de prestations"
			sTypArtNul = "annulation de prestations"
			sAction = "A_ANNULER"
			This.Uf_Trace ( "ECR", "Génération du fichier d'ANNULATIONS DES PRESTATIONS en cours..." )
		*/	Continue // [PC767-1] - annulations par mail

	END CHOOSE

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "ID_SIN",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )))
		idwFicGenCmde.SetItem ( lRow, "NOM",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) )
		idwFicGenCmde.SetItem ( lRow, "PRENOM",			idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		
		idwFicGenCmde.SetItem ( lRow, "ADR_1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CPL",	idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )
		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		
		idwFicGenCmde.SetItem ( lRow, "num_teld",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "num_telb",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "num_port",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			
		
		If idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART") = "PRS" Then 
			sVal="Réparation" 
		Else 
			sVal="Remplacement"
		End if
		
		idwFicGenCmde.SetItem ( lRow, "ACTION",			sVal )
		
		If lCptCas = 2 Then
			idwFicGenCmde.SetItem ( lRow, "NUM_IMEI_PORT",			idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" )  )
			idwFicGenCmde.SetItem ( lRow, "MARQ_PORT",		idwFicCharg.GetItemString ( lCpt, "MARQ_APP" ) )						
			idwFicGenCmde.SetItem ( lRow, "MODL_PORT",		idwFicCharg.GetItemString ( lCpt, "MODL_APP" ) )	

			sVal="Non"
			If idwFicCharg.GetItemString ( lCpt, "DESIMLOCKE" ) = "O" Then sVal="Oui"
			idwFicGenCmde.SetItem ( lRow, "DESIMLOCKE",			sVal  )

			idwFicGenCmde.SetItem ( lRow, "PROBLEME",			idwFicCharg.GetItemString ( lCpt, "PROBLEME" )  )
			idwFicGenCmde.SetItem ( lRow, "CODE_VERROU",			idwFicCharg.GetItemString ( lCpt, "CODE_VERROU" )  )
				
		Else
			idwFicGenCmde.SetItem ( lRow, "MARQ_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
			idwFicGenCmde.SetItem ( lRow, "MODL_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )						
		End if
	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Excel8!, True ) // [MIG_PB2022]
	
	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit


Next

Return iRet 
end function

private function integer uf_generer_fichier_o2m_blcode (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_O2M (PRIVATE)
//* Auteur			: PHG
//* Date				: 27/11/2007
//* Libellé			: Génération du fichier de commande pour O2M
//* Commentaires	: [O2M]
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	PHG	31/03/2008 	[DCMP080162] AJout Valeur Publique d'achat et Date Achat
//* #2	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
//* #3   JFF   20/10/2008  [FNAC_PROD_ECH_TECH].[20090127140540720]
//* #4   JFF   20/10/2008  [FNAC_PROD_ECH_TECH].[20090225143455120]
//* #7	FPI	20/03/2009	[DCMP090109] O2M devient réparateur d'IPhone
//* #8   JFF   27/03/2009  [DCMP090152] Civ long pour O2M
//*  	   JFF	13/04/2010  [ADRESSE_O2M]
//			FPI	10/08/2010	[PM01] Process 4
//* 		JFF   03/05/2011  [PM166][O2M]
//*      JFF   12/12/2011  [VDOC4970]
//*      JFF   04/10/2012  [BLCODE]
//*      JFF   12/12/2011  [VDOC9043]
//       JFF   07/05/2013  [PC938_ORANGE_V3]
//       JFF   09/09/2013  [PM222-1]
//       JFF   13/01/2014  [PM246]
//       JFF   28/03/2014  [DT081_EVOL_PRET_BRIS]
//       JFF   04/11/2014  [PM280-1]
//       JFF   16/03/2015  [DT081-3]
// 		JFF	16/06/2015  [VDOC17908]
//       JFF   20/07/2015  [DT150]
//       JFF   29/03/2016  [DT200]
//       JFF   31/03/2016 [PM287-3]
// 		JFF   12/05/2016 [VDOC20847]
// 		JFF   03/01/2018 [VDOC25374]
// 		JFF   21/06/2018 [VDOC26276]
// 		JFF   12/12/2018 [VDOC27242]
//       JFF   25/09/2019 [DT386_EXTR_AXA_V8]
//       JFF   20/06/2022 [RS3220_MODDEGR_TELST]
//       JFF   20/06/2022 [RS3220_MODDEGR_TELST][CORRECTIF] suite bug
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd, lVal 
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sIdRefFour, sTypArt2, sInfoSpbFrnCplt, sInfoFrnSpbCplt, sValRS3220
String sNomLigne1, sNomLigne2, sAdrLigne1, sAdrLigne2, sCP, sVille, sValCar, sVal, sInfoSpbFrn, sFiltreTLS_RS3220, sNomFic_RS3220
n_cst_cmd_commun	lnvCmdCommun
Long lIdProd,  lDeb,lFin, lCptKey, lCptDeb, lCptFin, lTotRS3220, lCptRS3220
n_cst_attrib_key	lnv_Key[]
n_cst_string lnvString

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour O2M 								  */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_O2M"

/*------------------------------------------------------------------*/
/* Génération du fichier de COMMANDES (CMD)                         */
/*------------------------------------------------------------------*/
//* #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
// sFiltre = "ID_TYP_ART = 'EDI' AND COD_ETAT <> 'ANN'"
sFiltre = "COD_ETAT <> 'ANN'"

// [VDOC17908]
lCptDeb = 3
lCptFin = 3
// :[VDOC17908]

For lCptCas = lCptDeb To lCptFin
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de PRESTATIONS (PRS)                       */
		/*------------------------------------------------------------------*/
		// [PM82][LOT1] Simplification
		// [MANTIS3743]
		CASE 1
			sFiltre = "ID_FOUR= 'O2M'"
			sNomFic = K_FIC2 // "PRS"
			sTypArt = "Ordre O2M"
			sTypArtNul = "Ordre O2M"
			This.Uf_Trace ( "ECR", "Génération du fichier de PRESTATION O2M en cours..." )

		CASE 2
			sFiltre = "ID_FOUR= 'BLC'"
			sNomFic = K_FIC10 // "PRS"
			sTypArt = "Ordre BLCODE"
			sTypArtNul = "Ordre BLCODE"
			This.Uf_Trace ( "ECR", "Génération du fichier de PRESTATION BLCODE en cours..." )

		// [VDOC17908]
		CASE 3
			sFiltre = "ID_FOUR IN ('O2M', 'BLC')"
			sNomFic = K_FIC2 // "PRS"
			sTypArt = "Ordre O2M et BLCODE"
			sTypArtNul = "Ordre O2M et BLCODE"
			This.Uf_Trace ( "ECR", "Génération du fichier de PRESTATION O2M et BLCODE en cours..." )

	End Choose

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()
	
	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
	
	For lCpt = 1 To lTot
		lRow = idwFicGenCmde.InsertRow ( 0 )
	
	//* #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
	
		sTypArt2 = idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" ) 
	
		// #7 [DCMP090109]
		sAction = idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )
	
		// [VDOC4970]
		sInfoSpbFrn = String ( idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) )
		sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))
		// [DT150]
		sInfoFrnSpbCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_FRN_SPB_CPLT" ) ))		
	
		// [PM166][O2M]
		Choose Case sTypArt2
			Case "EDI", "PRS"
	
				// ON laisse tel quel
	
				// [PM82][LOT2]
				sVal = ""
				If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
					sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_REPARER_SAV", ";")
					If sVal = "OUI" Then
						sAction = "A_REPARER_SAV"
					End If
				End If
				// [PM82][LOT2]
				
				// [PM222-1]
				sVal = ""
				If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
					sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_CONTROLER_SAV", ";")
					If sVal = "OUI" Then
						sAction = "A_CONTROLER_SAV" 
					End If
				End If
				// [PM222-1]			
				
				// [PM280-1]
				sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_REP_GARANTIE", ";")
				If sVal = "OUI" Then
					sAction = "A_REP_GARANTIE"
				End If

				// [DT150]
				/*
					sVal = lnvString.of_Getkeyvalue ( sInfoFrnSpbCplt, "GEOLOC", ";")
					If sVal = "SUPP" Then
						sAction = "GEOLOC_SUPP"
					End If
				*/
				
				// [PM287-3]
				sVal = lnvString.of_Getkeyvalue ( sInfoFrnSpbCplt, "IFDNMQ_ACT", ";")
				If sVal = "FAIT" Then
					sAction = "IFDNMQ_FAIT"
				End If

				// [DT200]
				sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt, "NE_PAS_REPARER", ";")
				If sVal = "OUI" Then
					sAction = "NE_PAS_REPARER"
				End If
	
		// [VDOC4970]
			Case "ALE", "BAM", "ACC"
				
				// [ITSM113805]
				sAction = "A_COMMANDER"
				
				//	[VDOC3537]				
				sInfoSpbFrn = "990"
	
		// [VDOC4970]
			Case "PCM"
				sInfoSpbFrn = "990"

		// [PC938_ORANGE_V3]
			Case "RST"
				sInfoSpbFrn = "990"
				sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "RST_INFO_SIMPLE", ";")
				If sVal = "OUI" Then
					sAction = "ALIMENTER_STOCK"
				Else 
					sAction = "RST_A_COMMANDER"					
				End If

		// [PC938_ORANGE_V3]
			Case "RES"
				sAction = "PRET_A_RESTITUER"

			Case "REA"
				sAction = "RECUP_APP_SIN"

			Case "PST"

				// [DT081_EVOL_PRET_BRIS]
				// [DT081-3]
				Choose Case sAction 
					Case "DEM_RESTIT", "INFO_CAUTION"
						// On laisse
					case Else 
						sAction = "A_COMMANDER"
				End Choose
				
			Case Else			
				sAction = "A_COMMANDER"
		End Choose
		
		Choose Case sTypArt2 
			Case "EDI", "PRS", "PCM"
				sTypArt2 = idwFicCharg.GetItemString ( lCpt, "TYP_APP_SIN" )
				
			Case Else
				// On laisse tel quel
		End Choose
	//* :#6 [FNAC_PROD_ECH_TECH].[20090127140540720]
	
	// [PM246]
	sVal = ""
	If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
		sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "MAJ_ADRESSE", ";")
		If sVal = "OUI" Then
			sAction = "MAJ_ADRESSE"
		End If
	End If		
	// [PM246]	
	
	
	// [ADRESSE_O2M]
		lnvCmdCommun.uf_GetAdresseO2MBase ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" ), "GENERATION", sNomLigne1, sNomLigne2, sAdrLigne1, sAdrLigne2, sCP, sVille )
	
	
		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "CODE_PROD", 		String (idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) + " " + idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_1",				idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_2",				idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CPL",			idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			
		idwFicGenCmde.SetItem ( lRow, "TYP_ART",			sTypArt2 )			
		idwFicGenCmde.SetItem ( lRow, "PROBLEME",			idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) )					
		idwFicGenCmde.SetItem ( lRow, "NUM_IMEI_SERIE",	idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" ) )						
		idwFicGenCmde.SetItem ( lRow, "MARQ_APP",			idwFicCharg.GetItemString ( lCpt, "MARQ_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_APP",			idwFicCharg.GetItemString ( lCpt, "MODL_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "NOM_GEST" ) )						
		
		// #7 [DCMP090109] Déplacement de l'armement de sAction
		//sAction = idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )
	
		idwFicGenCmde.SetItem ( lRow, "ACTION", sAction )
		
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "GARANTIE",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN",	sInfoSpbFrn  )		// [VDOC4970]
	
		idwFicGenCmde.SetItem ( lRow, "MDE_RGLT",			'' ) 				
		idwFicGenCmde.SetItem ( lRow, "CDE_BANQUE",		'' ) 				
		idwFicGenCmde.SetItem ( lRow, "CDE_GUICHET",		'' ) 				
		idwFicGenCmde.SetItem ( lRow, "NUM_CPTE",			'' ) 				
		idwFicGenCmde.SetItem ( lRow, "CLE_RIB",			'' ) 	
	
		//* #2 [FNAC_PROD_ECH_TECH] 
		//* #7 [DCMP090109] 
		If sAction = "A_DIAGNOSTIQUER" Or sAction = "A_REPARER"Then
			Choose case idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) 
					
				Case 415, 905, 910, 915, 920, 936, 941, 1010 // On ne met le RIB que sur 'A_DIAGNOSTIQUER' et les process suivant
					idwFicGenCmde.SetItem ( lRow, "MDE_RGLT",			idwFicCharg.GetItemString ( lCpt, "COD_MODE_REG" ) ) 				
					idwFicGenCmde.SetItem ( lRow, "CDE_BANQUE",		idwFicCharg.GetItemString ( lCpt, "RIB_BQ" ) ) 				
					idwFicGenCmde.SetItem ( lRow, "CDE_GUICHET",		idwFicCharg.GetItemString ( lCpt, "RIB_GUI" ) ) 				
					idwFicGenCmde.SetItem ( lRow, "NUM_CPTE",			idwFicCharg.GetItemString ( lCpt, "RIB_CPT" ) ) 				
					idwFicGenCmde.SetItem ( lRow, "CLE_RIB",			idwFicCharg.GetItemString ( lCpt, "RIB_CLE" ) ) 	
			End Choose
		End If
		//* :#2 [FNAC_PROD_ECH_TECH] 
		
		idwFicGenCmde.SetItem ( lRow, "MT_FRAIS",			idwFicCharg.GetItemDecimal ( lCpt, "MT_DEVIS" ) )
		idwFicGenCmde.SetItem ( lRow, "ASSUREUR",			idwFicCharg.GetItemString ( lCpt, "ASSUREUR" ) )
		// [DCMP080162] AJout Valeur Publique d'achat et Date Achat ( note : date stockée sous forme de chaine )
		idwFicGenCmde.SetItem ( lRow, "MT_VAL_ACHAT",	Dec(idwFicCharg.GetItemString ( lCpt, "MT_VAL_ACHAT" )) )
		idwFicGenCmde.SetItem ( lRow, "DTE_ACHAT",		idwFicCharg.GetItemString ( lCpt, "DTE_ACHAT" ) )
	
	
		//* #2 [FNAC_PROD_ECH_TECH] 
		idwFicGenCmde.SetItem ( lRow, "COD_MAG",		"") 				
		idwFicGenCmde.SetItem ( lRow, "ADR_MAG",		"" ) 				
		idwFicGenCmde.SetItem ( lRow, "CONTACT_MAG",	"" ) 				
		idwFicGenCmde.SetItem ( lRow, "NUM_TEL_MAG",	"" ) 				
		idwFicGenCmde.SetItem ( lRow, "NUM_FAX_MAG",	"" ) 					
	
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL_MAG",	"" ) 					
		
		If sAction = 'A_DIAGNOSTIQUER' Then
			Choose Case idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) 
	
				//* #4 [FNAC_PROD_ECH_TECH].[20090225143455120] ajout 906, 911
				Case 945, 950, 960, 906, 911 // On ne mets les infos FNAC que pour les process suivants
					idwFicGenCmde.SetItem ( lRow, "COD_MAG",			idwFicCharg.GetItemString ( lCpt, "COD_MAG" ) ) 				
					idwFicGenCmde.SetItem ( lRow, "ADR_MAG",		idwFicCharg.GetItemString ( lCpt, "ADR_1_MAG" ) + " " + &
																				idwFicCharg.GetItemString ( lCpt, "ADR_2_MAG" ) + " " + &
																				idwFicCharg.GetItemString ( lCpt, "ADR_CP_MAG" ) + " " + &
																				idwFicCharg.GetItemString ( lCpt, "ADR_VILLE_MAG" ) )
					idwFicGenCmde.SetItem ( lRow, "CONTACT_MAG",		idwFicCharg.GetItemString ( lCpt, "RESPONSABLE_MAG" ) ) 				
					idwFicGenCmde.SetItem ( lRow, "NUM_TEL_MAG",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL_MAG" ) ) 				
					idwFicGenCmde.SetItem ( lRow, "NUM_FAX_MAG",			idwFicCharg.GetItemString ( lCpt, "ADR_FAX_MAG" ) ) 				
					idwFicGenCmde.SetItem ( lRow, "ADR_MAIL_MAG",	idwFicCharg.GetItemString ( lCpt, "ADR_MAIL_MAG1" ) ) 				
		
			End Choose
		End If
		
		// [PM01]
		If sAction = 'A_RECUP_A_RECYCLER' Then
			
			lIdProd= idwFicCharg.GetItemNumber( lCpt, "ID_PROD")
			F_rechdetpro( lDeb,lFin, idwDetPro, lIdProd,"-DP", 143 )
			
			lnv_Key[1]. iskeyname="COD_MAG"
			lnv_Key[2]. iskeyname="ADR_1_MAG"
			lnv_Key[3]. iskeyname="ADR_2_MAG"
			lnv_Key[4]. iskeyname="ADR_CP_MAG"
			lnv_Key[5]. iskeyname="ADR_VILLE_MAG"
			lnv_Key[6]. iskeyname="RESPONSABLE_MAG"
			lnv_Key[7]. iskeyname="ADR_TEL_MAG"
			lnv_Key[8]. iskeyname="ADR_FAX_MAG"
			lnv_Key[9]. iskeyname="ADR_MAIL_MAG1"
			
	
			Choose Case idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) 
	
				Case 1503, 1505
					
					if lDeb > 0 Then
						sValCar= idwDetPro.GetItemString(lDeb, "VAL_CAR")
						if not isNull(idwDetPro.GetItemString(lDeb, "VAL_CAR2")) Then sValCar+=idwDetPro.GetItemString(lDeb, "VAL_CAR2")
						
						For lCptKey=1 to UpperBound(lnv_Key)
							lnv_Key[lCptKey].iakeyvalue=lnvString.of_getkeyvalue( sValCar, lnv_Key[lCptKey].iskeyname,";")
						Next
					Else
						For lCptKey=1 to UpperBound(lnv_Key)
							lnv_Key[lCptKey].iakeyvalue=idwFicCharg.GetItemString ( lCpt,lnv_Key[lCptKey].iskeyname)
						Next
					End if
					
					idwFicGenCmde.SetItem ( lRow, "COD_MAG",			lnv_Key[1].iakeyvalue ) 				
					idwFicGenCmde.SetItem ( lRow, "ADR_MAG",		lnv_Key[2].iakeyvalue + " " + &
																				lnv_Key [3].iakeyvalue+ " " + &
																				lnv_Key[4].iakeyvalue + " " + &
																				lnv_Key[5].iakeyvalue )
					idwFicGenCmde.SetItem ( lRow, "CONTACT_MAG",	lnv_Key[6].iakeyvalue ) 				
					idwFicGenCmde.SetItem ( lRow, "NUM_TEL_MAG",	lnv_Key[7].iakeyvalue ) 				
					idwFicGenCmde.SetItem ( lRow, "NUM_FAX_MAG",	lnv_Key[8].iakeyvalue) 				
					idwFicGenCmde.SetItem ( lRow, "ADR_MAIL_MAG",	lnv_Key[9].iakeyvalue ) 				
		
			End Choose
		End If
		// :[PM01]
	
		// [PM166][O2M]
		If sAction = "A_COMMANDER" Then
			// On réinitialise certaines zones inutiles pour la commande
			idwFicGenCmde.SetItem ( lRow, "PROBLEME",	"")							
			idwFicGenCmde.SetItem ( lRow, "NUM_IMEI_SERIE",	"" )								
			idwFicGenCmde.SetItem ( lRow, "MARQ_APP",			idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
			idwFicGenCmde.SetItem ( lRow, "MODL_APP",			idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )						
			idwFicGenCmde.SetItem ( lRow, "MT_FRAIS",			0 )
			
			idwFicGenCmde.SetItem ( lRow, "MT_VAL_ACHAT",	"" )
			idwFicGenCmde.SetItem ( lRow, "DTE_ACHAT",		"" )
			
		End If
		// :[PM166][O2M]	
	
		// [REPAR_GTI]
		Choose Case sAction 
			Case "A_REP_GARANTIE", "CONTEST_SUR_REMPL"
				idwFicGenCmde.SetItem ( lRow, "MARQ_APP",			idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
				idwFicGenCmde.SetItem ( lRow, "MODL_APP",			idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )				
		End Choose 
		// :[REPAR_GTI]
		
		// [VDOC27242]
		Choose Case sAction 
			Case "A_REPARER_FORCE"
				sVal = idwFicCharg.GetItemString ( lCpt, "PRESENCE_A_REP_GARANTIE" ) 					
				If Len ( sVal) > 0 Then
					idwFicGenCmde.SetItem ( lRow, "MARQ_APP",			lnvString.of_Getkeyvalue ( sVal, "MARQ", ";" ) )
					idwFicGenCmde.SetItem ( lRow, "MODL_APP",			lnvString.of_Getkeyvalue ( sVal, "MODL", ";" ) )
					idwFicGenCmde.SetItem ( lRow, "NUM_IMEI_SERIE",			lnvString.of_Getkeyvalue ( sVal, "IMEI", ";" ) )						
				End If 
		End Choose 
		
		// [PM166][O2M]
		If sAction <> "A_COMMANDER" Then
			If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
			sInfoSpbFrnCplt += "COD_CIV_COURTE=" + idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV" )
		
			If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
			sInfoSpbFrnCplt += "COD_CIV_LONGUE=" + idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV_LONG" )	
		
			// [ADRESSE_O2M]
			// [VDOC9043]
			If sAction = "A_DIAGNOSTIQUER" Or sAction = "A_REPARER" Or sAction = "RECUP_APP_SIN" Then
				If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
				sInfoSpbFrnCplt += "ADRESSE_SPB_O2M=" + sNomLigne1	
			End If 
			// [ADRESSE_O2M]
		End If

		Choose Case sAction  
			Case "A_COMMANDER", "RST_A_COMMANDER"
				If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
				sInfoSpbFrnCplt += "ID_REF_FOUR=" + idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )
		
				If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
				sInfoSpbFrnCplt += "MT_TTC_CMDE=" + String ( idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) )
		End Choose
		
		// :[PM166][O2M]

		// [VDOC20847]
		If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
		sInfoSpbFrnCplt += "POLICE=" + idwFicCharg.GetItemString ( lCpt, "LIB_POLICE" ) 
		
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	sInfoSpbFrnCplt  )
		//* :#2 [FNAC_PROD_ECH_TECH]
	
	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )	
	
	// [RS3220_MODDEGR_TELST]
	// On sort les cmde de rempl Orange du flux O2M

/* le mode dégradé est terminé mais je ne casse pas le code, on ne sait jamais....
	If mode_dégradé Then
		sFiltreTLS_RS3220  = "CODE_PROD IN ( '9100','9101','19100','9600','9601','9610','9102','9103','9104','9105','9106','9122','9123','9124','9125','9126','46300','46301','9129','48200','9127','9128','9611','9620','9120','9121','28502','9131','9107','9108','9109','9110','9111','9112','25100','9130','9612','9613','28200','28500','28501','32700','9113','9114','9115','9148','9139','9140','9141','9142','9143','9134','9135','9136','9150','9152','9153','9154','96200','96201','9626','96204','96205','9623','9624','9625','9621','9116','9117','9118','9119','9622','9162','9163','9164','9159','9160','9161','9155','9156','9158','9157','32702','51600','51601','51602','51603','51604','9165','9166','9167','9168','9169','9170','51605','51606','51607','51608','51609','51610','51611','51612','51613','51614','51615','51616','51617','51618','51619','51620','51621','51622','51623','51624','51625','51626','51627','51628','51629','51630','51631','51632','51633','51634','51635','51636','51637','51638','51639','51640','51641','51642','51643','41600','41602','39102','39103','9630','41601','39101','44700','44800','9614','39104','39105','39106','80800','9132','9133','9147','9151','9146','9137','96202','9627','9138','32701','9149','9144','9145','96203','9628') AND "
		sFiltreTLS_RS3220 += "FOURNISSEUR = 'O2M' AND "
		sFiltreTLS_RS3220 += "TYP_ART IN ( 'TEL', 'TPC', 'RST') AND "		
//		sFiltreTLS_RS3220 += "ACTION IN ( 'A_COMMANDER', 'RST_A_COMMANDER', 'MAJ_ADRESSE' ) "   [RS3220_MODDEGR_TELST][CORRECTIF]

		//[RS3220_MODDEGR_TELST][CORRECTIF]
		sFiltreTLS_RS3220 += "( ACTION IN ( 'A_COMMANDER', 'RST_A_COMMANDER' ) OR "
		sFiltreTLS_RS3220 += "  ( POS ( INFO_SPB_FRN_CPLT, 'MAJ_ADRESSE=OUI' ) > 0 AND POS ( INFO_SPB_FRN_CPLT, 'RS3220=TLS' ) > 0 )"
		sFiltreTLS_RS3220 += ")"
		
		idwFicGenCmde.SetFilter ( sFiltreTLS_RS3220 )
		idwFicGenCmde.Filter ()

		// Marquage indiquant que ce sont des presta traitées par TLS
		lTotRS3220 = idwFicGenCmde.RowCount()
		For lCptRS3220 = 1 to lTotRS3220 
			sValRS3220 = idwFicGenCmde.GetItemString  ( lCptRS3220, "INFO_SPB_FRN_CPLT" )
			lnvString.of_SetKeyValue ( sValRS3220, "RS3220", "TLS", ";" )
			idwFicGenCmde.SetItem ( lCptRS3220, "INFO_SPB_FRN_CPLT",	sValRS3220  )			
		Next 
			
		sNomFic_RS3220 = sNomFic
		sNomFic_RS3220 = F_Remplace ( sNomFic_RS3220, "\O2M\", "\RS3220_TLS_MODDEGR\" ) 
		sNomFic_RS3220 = F_Remplace ( sNomFic_RS3220, "\PRS", "\RS3220_PRS" ) 

		iRet = idwFicGenCmde.SaveAs ( sNomFic_RS3220, Text!, TRue )

		If iRet > 0 Then
			This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic_RS3220 )  )
	
			// [VDOC26276]
			// This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic_RS3220 ) fait plus bas sur FLUX, contexte filtré
			This.uf_Maj_Nom_Spb_Frn_Cplt ( "RS3220", "TLS" ) 

			sValRS3220 = Reverse ( TRIM ( sNomFic_RS3220 ) )
			lVal = Pos ( sValRS3220, "\" ) 
			sValRS3220 = Left ( sValRS3220, lVal - 1 )
			sValRS3220 = Reverse ( sValRS3220 )
			This.uf_Maj_Nom_Spb_Frn_Cplt ( "FLUX", sValRS3220 ) 			
			
		Else
			iRet = -1
			This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		End If
	
		If iRet = -1 Then Exit
		
		If iRet <> -1 Then

			// Négation du filtre pour avoir l'autre partie
			sFiltreTLS_RS3220 = "NOT ( " + sFiltreTLS_RS3220 + " )"
			idwFicGenCmde.SetFilter ( sFiltreTLS_RS3220 )
			idwFicGenCmde.Filter ()
		
			// Vers le nom de fichier d'origine cette fois
			iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, True )
			If iRet > 0 Then
				This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
		
				// [VDOC26276]
				// This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic ) fait plus bas sur FLUX, contexte filtré
				sValRS3220 = Reverse ( TRIM ( sNomFic ) )
				lVal = Pos ( sValRS3220, "\" ) 
				sValRS3220 = Left ( sValRS3220, lVal - 1 )
				sValRS3220 = Reverse ( sValRS3220 )				
				This.uf_Maj_Nom_Spb_Frn_Cplt ( "FLUX", sValRS3220 )
			Else
				iRet = -1
				This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
			End If
			If iRet = -1 Then Exit			
			
		End If 
		idwFicGenCmde.SetFilter ( "" )
		idwFicGenCmde.Filter ()
		
   Else */ 
		iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, TRue ) // True : On indique les en-tetes
	
		If iRet > 0 Then
			This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
	
			// [VDOC26276]
			This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic ) 
			
		Else
			iRet = -1
			This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		End If
	
		If iRet = -1 Then Exit
//	End If	

Next

Return iRet 

end function

private function integer uf_generer_fichier_lbe (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_LBE (PRIVATE)
//* Auteur			: FPI
//* Date				: 16/10/2012
//* Libellé			: Génération du fichier de commande pour le LBE [PC884]
//* Commentaires	: un fichier sera générés dans le même répertoires :
//*					  un pour les commandes   : CMDjjmma.ind  (CMD10091.001)
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*		FPI	13/06/2013	[DT044_1]
//			FPI	21/01/2014	[20140121.FPI] Création du fichier de commande Edel même si aucune commande
//       JFF   12/01/2015 [DT125_LECLERC]
//       JFF   19/01/2015 [MANTIS14006] 
//		FPI	02/03/2015	[DT125_V3] Civilité longue
// 		JFF   21/06/2018 [VDOC26276]
//        JFF   05/08/2024  [MCO602_PNEU]
//*-----------------------------------------------------------------

Int	iRet, iFic
Long	lTot, lCpt, lCptCas, lRow
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sEnrg, sSep, sTel, sVal, sAdrMail, sTypCarte
Boolean bF_CLE_A_TRUE_MCO602_PNEU

// [MCO602_PNEU]
bF_CLE_A_TRUE_MCO602_PNEU = F_CLE_A_TRUE ( "MCO602_PNEU" ) 

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le LBE                   */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_edel"

idwFicGenCmde.Object.DataWindow.Export.XHTML.UseTemplate = "commande_edel2"
	
/*------------------------------------------------------------------*/
/* Génération du fichier de COMMANDES (CMD)                         */
/*------------------------------------------------------------------*/
sFiltre = "ID_TYP_ART ='CAF' AND COD_ETAT <> 'ANN'"
sNomFic = K_FIC1
sTypArt = "commandes"
sTypArtNul = "commande"
sAction = "A COMMANDER"
This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )

idwFicCharg.SetFilter ( sFiltre )
idwFicCharg.Filter ()
idwFicCharg.Sort ()
lTot = idwFicCharg.RowCount ()			
idwFicGenCmde.Reset ()

/*------------------------------------------------------------------*/
/* On ne génère pas de fichier si pas de commandes ou pas de        */
/* prestations.                                                     */
/*------------------------------------------------------------------*/
If lTot = 0 Then
	This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
End If

For lCpt = 1 To lTot

	lRow = idwFicGenCmde.InsertRow ( 0 )
	
	// [DT125_LECLERC]
	sAdrMail = idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" )

	// [MCO602_PNEU]
	If bF_CLE_A_TRUE_MCO602_PNEU Then
		sTypCarte = "PE27"
	Else 
		sTypCarte = "2027"		
	End If 
	
	// [DT125_LECLERC]
	/*	[MANTIS14006] le 19/01/2015 JF
	If Not IsNull ( sAdrMail ) And Len ( Trim ( sAdrMail ) ) > 0  Then
		sTypCarte = "2028"						
	End If
	*/
	
	idwFicGenCmde.SetItem ( lRow, "REFCMD",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
	idwFicGenCmde.SetItem ( lRow, "TYPECMD", 	"Contrat GRN" )
	
	idwFicGenCmde.SetItem ( lRow, "TYPECARTE", sTypCarte )
	idwFicGenCmde.SetItem ( lRow, "MTCARTE",	 idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) )	
	idwFicGenCmde.SetItem ( lRow, "QTE", 1 )
	
	// [DT125_V3] Civilité longue
	idwFicGenCmde.SetItem ( lRow, "CHAMP1",		idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV_LG" ) )	
	
	idwFicGenCmde.SetItem ( lRow, "CHAMP2",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) )
	idwFicGenCmde.SetItem ( lRow, "CHAMP3",				idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
	
	idwFicGenCmde.SetItem ( lRow, "CPMAGCMD", "9996" )
	// FPI/Maryline - Le code pannonceau doit être sur 4 chiffres
	idwFicGenCmde.SetItem ( lRow, "CPMAGLIV",				String(Long(idwFicCharg.GetItemString ( lCpt, "ID_ORIAN_BOUTIQUE" )),"0000") )

	// [DT125_V3] Civilité longue
	idwFicGenCmde.SetItem ( lRow, "RAISON",		idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV_LG" ) )	
	
	idwFicGenCmde.SetItem ( lRow, "CONTACT",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) + " " + f_getitem3(idwFicCharg, lCpt, "ADR_PRENOM" ) )
	
	idwFicGenCmde.SetItem ( lRow, "ADRESSE1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
	idwFicGenCmde.SetItem ( lRow, "ADRESSE2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
	idwFicGenCmde.SetItem ( lRow, "CODEPOSTAL",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
	idwFicGenCmde.SetItem ( lRow, "VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
	idwFicGenCmde.SetItem ( lRow, "EMAIL",			sAdrMail  )					
	
	// [DT044_1]
	sTel=idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" )
	If isnull(sTel) Then sTel=""

	If sTel="" Then
		sVal=idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" )
		If not isnull(sVal) Then sTel=sVal
	End if
		
	If sTel="" Then
		sVal=idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" )
		If not isnull(sVal) Then sTel=sVal
	End if

	idwFicGenCmde.SetItem ( lRow, "TEL",	sTel)
	// :[DT044_1]
	
Next

//If lTot > 0 Then // [20140121.FPI] 
	This.uf_nom_fichier ( sNomFic, 0 )
	
	iRet = idwFicGenCmde.SaveAs ( sNomFic, XML!, True, EncodingUTF8! )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )

		// [VDOC26276]
		This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic ) 
		
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
	End If
//End if

Return iRet 
end function

private function integer uf_generer_fichier_omt (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_OMT (PRIVATE)
//* Auteur			: FPI
//* Date				: 22/11/2012
//* Libellé			: Génération du fichier de commande pour le OMT
//* Commentaires	: Trois fichiers seront générés dans le même répertoires :
//*					  un pour les commandes   : CMDjjmma.ind  (CMD10091.001)
//*					  un pour les prestations : PRSjjmma.ind  (PRS10091.001)
//*					  un pour les annulations : ANNjjmma.ind  (ANN10091.001)
//*					  [PC874]
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//        JFF   26/11/2018   [PC874_2_V1]
//*-----------------------------------------------------------------

Int	iRet, iFic
Long	lTot, lCpt, lCptCas, lRow, lCas
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sEnrg, sSep, sVal, sInfoSpbFrnCplt  
n_cst_string nvString

iRet = 1

For lCptCas = 1 To 3
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1

			// [PC874_2_V1]
			idwFicGenCmde.DataObject = "d_trt_fichier_cmde_OMT"
			sFiltre = "ID_TYP_ART NOT IN ( 'PRS', 'EDI') AND COD_ETAT <> 'ANN'"
			lCas = 0
			
			sNomFic = K_FIC1
			sTypArt = "commandes"
			sTypArtNul = "commande"
			sAction = "A COMMANDER"
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )

		/*------------------------------------------------------------------*/
		/* Génération du fichier de PRESTATIONS (PRS)                       */
		/*------------------------------------------------------------------*/
		CASE 2
			// [PC874_2_V1]
			idwFicGenCmde.DataObject = "d_trt_fichier_cmde_omt_ctrle_imei"
			sFiltre = "ID_TYP_ART = 'EDI' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC16
			sTypArt = "demandes de contrôle IMEI"
			sTypArtNul = "demande de contrôle IMEI"
			sAction = "A_CONTROLER_IMEI"
			This.Uf_Trace ( "ECR", "Génération du fichier de demande de contrôle IMEI en cours..." )
			lCas = 1
		/*------------------------------------------------------------------*/
		/* Génération du fichier des ANNULATION des COMMANDES (ACD)			  */
		/*------------------------------------------------------------------*/
		CASE 3
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT = 'ANN'"
			sNomFic = K_FIC3
			sTypArt = "annulations de commandes"
			sTypArtNul = "annulation de commandes"
			sAction = "A ANNULER"
			This.Uf_Trace ( "ECR", "Génération du fichier d'ANNULATIONS DES COMMANDES en cours..." )

	END CHOOSE

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		Choose Case lCptCas 
			Case 1, 2
				// Ok génère un fichier vide
			Case Else 
				Continue
		End Choose 
		
	End If
	
	CHOOSE CASE lCptCas
		Case 1, 3
			For lCpt = 1 To lTot
		
				lRow = idwFicGenCmde.InsertRow ( 0 )
		
				idwFicGenCmde.SetItem ( lRow, "ID_SIN",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )))
				idwFicGenCmde.SetItem ( lRow, "NO_LIGNE", 	idwFicCharg.GetItemString ( lCpt, "NUM_PORT" ) )
				idwFicGenCmde.SetItem ( lRow, "NUM_IMEI", 		idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" ) )
		
				sVal=Left(String(idwFicCharg.getItemNumber(lCpt,"ID_PROD")) ,3)
				sVal+=Right(Fill("0",5) + String(idwFicCharg.getItemNumber ( lCpt, "ID_ETS" )) ,5)
				sVal+=Right(Fill("0",7) + String(idwFicCharg.GetItemString ( lCpt, "ID_ADH" )) ,7)
				sVal+=  string(idwFicCharg.getItemNumber ( lCpt, "ID_SDOS" ))
					
				idwFicGenCmde.SetItem ( lRow, "REF_SPB", 	sVal)
				
				idwFicGenCmde.SetItem ( lRow, "NOM",			Left(idwFicCharg.GetItemString ( lCpt, "NOM_ASS" ) + Space(30),30))
				idwFicGenCmde.SetItem ( lRow, "PRENOM",	Left(idwFicCharg.GetItemString ( lCpt, "PRENOM_ASS" )+ Space(30),30) )
				idwFicGenCmde.SetItem ( lRow, "MT_PEC",	 Right("0000000" + nvstring.of_globalreplace( idwFicCharg.GetItemString(lCpt,"MT_PEC" ),".","") ,7) 	)			
				idwFicGenCmde.SetItem ( lRow, "OPTION",			idwFicCharg.GetItemString ( lCpt, "OPTIONDP_218" ) )
				idwFicGenCmde.SetItem ( lRow, "DTE_PEC",			String(idwFicCharg.GetItemDateTime ( lCpt, "MAJ_LE" ),"YYYYMMDD") )
		
			Next
		
			This.uf_nom_fichier ( sNomFic, lCas )
		
			iRet = idwFicGenCmde.SaveAsFormattedText ( sNomFic, EncodingAnsi!,"","") // Fichier format fixe
		
			If iRet > 0 Then
				This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
			Else
				iRet = -1
				This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
				Exit
			End If
		
			If iRet = -1 Then Exit

		Case 2

			For lCpt = 1 To lTot

				sInfoSpbFrnCplt  = "" 
				lRow = idwFicGenCmde.InsertRow ( 0 )

				idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
				idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
				idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
				idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "NUM_PORT" ) )		
				idwFicGenCmde.SetItem ( lRow, "NUM_IMEI",	idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" ))
				idwFicGenCmde.SetItem ( lRow, "DTE_SURV",			String ( idwFicCharg.GetItemDateTime ( lCpt, "DTE_SURV" ), "dd/mm/yyyy" ) ) 		
				idwFicGenCmde.SetItem ( lRow, "ACTION", sAction )
				idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy" ) )
				idwFicGenCmde.SetItem ( lRow, "NUM_DOSS_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) )
				idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	sInfoSpbFrnCplt  )

			Next
		
			This.uf_nom_fichier ( sNomFic, lCas )
			iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, False ) // True : On indique les en-tetes
						
			If iRet > 0 Then
				This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
			Else
				iRet = -1
				This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
				Exit
			End If
		
			If iRet = -1 Then Exit
			
			
	End Choose 



Next

Return iRet 
end function

private function integer uf_generer_fichier_vipp (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_VIPP (PRIVATE)
//* Auteur			: JFF
//* Date				: 03/05/2011
//* Libellé			: Génération du fichier de commande pour le fournisseur BRIGHTPOINT
//* Commentaires	: Trois fichiers seront générés dans le même répertoires :
//*					  un pour les commandes   : CMDjjmma.ind  (CMD10091.001)
//*					  un pour les prestations : PRSjjmma.ind  (PRS10091.001)
//*					  un pour les annulations : ANNjjmma.ind  (ANN10091.001)
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 17/10/2002	  Modification SFR : Pour ce produit (5712), on
//*								  crée un fichier supplémentaire pour chaque type (cmd, prs, annul ...)
//*								  et on les écrit dans un répertoire spécifique
//*								  Annexe 7 (6.7.2) dans l'intégration de SFR, analyse des traitements
//*
//* #4	 JFF	 07/04/2003   Ajout de l'ID_REF_FOUR et MT_TTC_CMDE
//* #5	 CAG	 06/05/2003	  Génération d'un fichier vide de cmde qd pas de cmdes
//        JFF   19/11/2013   [DT_60_AUGM_TVA]
//        JFF   27/11/2013   [ITSM18204]
//		  FPI   23/07/2024   [MIG_PB2022] Sauvegarde Excel! remplacée par Excel8!
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul
Decimal {2}	dcTvaParDefaut, dcVal

iRet = 1
// [DT_60_AUGM_TVA] 1.196
dcTvaParDefaut = 20

/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le BRIGHTPOINT               */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_VIPP"

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC1
			sTypArt = "commandes"
			sTypArtNul = "commande"
			sAction = "A COMMANDER"
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )

	End Choose

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lrow, "NUM_ADH_CDS",    idwFicCharg.GetItemString ( lCpt, "ID_CONTRAT_ABONNE") )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )		
		idwFicGenCmde.SetItem ( lRow, "DTE_SURV",		   String ( idwFicCharg.GetItemDateTime ( lCpt, "DTE_SURV" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "DTE_DEB_GTI",		String ( idwFicCharg.GetItemDateTime ( lCpt, "DTE_DEB_GTI" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "DTE_FIN_GTI",		String ( idwFicCharg.GetItemDateTime ( lCpt, "DTE_FIN_GTI" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "CIV",				idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV" ) ) 
		idwFicGenCmde.SetItem ( lRow, "NOM",				idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) )
		idwFicGenCmde.SetItem ( lRow, "PRENOM",			idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR_CPL",	idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "TYP_ART",			idwFicCharg.GetItemString ( lCpt, "TYP_APP_SIN" ) )			
		idwFicGenCmde.SetItem ( lRow, "LIB_TYP_ART",		idwFicCharg.GetItemString ( lCpt, "LIB_TYP_APP_SIN" ) )	
		idwFicGenCmde.SetItem ( lRow, "MARQ_PORT",		idwFicCharg.GetItemString ( lCpt, "MARQ_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_PORT",		idwFicCharg.GetItemString ( lCpt, "MODL_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "NUM_SERIE",		idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" ) )						
		idwFicGenCmde.SetItem ( lRow, "DTE_LIVR",			String ( idwFicCharg.GetItemDateTime ( lCpt, "DTE_LIVRAISON" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "MT_VALACHAT_HT",	String ( Dec(idwFicCharg.GetItemString ( lCpt, "MT_VAL_ACHAT" )) / ( 1 + ( dcTvaParDefaut /100  ) ), "#,##0.00" ) )
		idwFicGenCmde.SetItem ( lRow, "MT_VALACHAT_TTC",	idwFicCharg.GetItemString ( lCpt, "MT_VAL_ACHAT" ) )
		idwFicGenCmde.SetItem ( lRow, "DTE_ACHAT",		idwFicCharg.GetItemString ( lCpt, "DTE_ACHAT" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ) )			
		idwFicGenCmde.SetItem ( lRow, "INFO_CPLT",		idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) )			
		
		Choose Case idwFicCharg.GetItemString ( lCpt, "APP_INCOMPLET" )
			Case "OUI" 
				idwFicGenCmde.SetItem ( lRow, "APP_COMPLET",	"NON" )					
			Case Else
				idwFicGenCmde.SetItem ( lRow, "APP_COMPLET",	"OUI" )					
		End Choose 

		// ITSM186204
		dcVal = Dec(idwFicCharg.GetItemString ( lCpt, "MT_PEC" )	)
		If dcVal = 0 Or IsNull ( dcVal ) Then
			idwFicGenCmde.SetItem ( lRow, "PRIX_DECT_HT",		String ( Dec(idwFicCharg.GetItemString ( lCpt, "MT_VAL_ACHAT" )) / ( 1 + ( dcTvaParDefaut /100  ) ), "#,##0.00" ) )
			idwFicGenCmde.SetItem ( lRow, "PRIC_DECT_TTC",		idwFicCharg.GetItemString ( lCpt, "MT_VAL_ACHAT" ) )
		Else
			idwFicGenCmde.SetItem ( lRow, "PRIX_DECT_HT",		String ( Dec(idwFicCharg.GetItemString ( lCpt, "MT_PEC" )) / ( 1 + ( dcTvaParDefaut /100  ) ), "#,##0.00" ) )
			idwFicGenCmde.SetItem ( lRow, "PRIC_DECT_TTC",		idwFicCharg.GetItemString ( lCpt, "MT_PEC" ) )
		End If
		
	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Excel8!, True ) // [MIG_PB2022]

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_mtt (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_O2M (PRIVATE)
//* Auteur			: PHG
//* Date				: 27/11/2007
//* Libellé			: Génération du fichier de commande pour O2M
//* Commentaires	: [O2M]
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	PHG	31/03/2008 	[DCMP080162] AJout Valeur Publique d'achat et Date Achat
//* #2	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
//* #3   JFF   20/10/2008  [FNAC_PROD_ECH_TECH].[20090127140540720]
//* #4   JFF   20/10/2008  [FNAC_PROD_ECH_TECH].[20090225143455120]
//* #7	FPI	20/03/2009	[DCMP090109] O2M devient réparateur d'IPhone
//* #8   JFF   27/03/2009  [DCMP090152] Civ long pour O2M
//*  	   JFF	13/04/2010  [ADRESSE_O2M]
//			FPI	10/08/2010	[PM01] Process 4
//* 		JFF   03/05/2011  [PM166][O2M]
//*      JFF   12/12/2011  [VDOC4970]
//*      JFF   04/10/2012  [BLCODE]
//*      JFF   12/12/2011  [VDOC9043]
//       JFF   07/05/2013  [PC938_ORANGE_V3]
//       JFF   09/09/2013  [PM222-1]
//*-----------------------------------------------------------------
Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sIdRefFour, sTypArt2, sInfoSpbFrnCplt
String sNomLigne1, sNomLigne2, sAdrLigne1, sAdrLigne2, sCP, sVille, sValCar, sVal, sInfoSpbFrn
n_cst_cmd_commun	lnvCmdCommun
Long lIdProd,  lDeb,lFin, lCptKey
n_cst_attrib_key	lnv_Key[]
n_cst_string lnvString

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour O2M 								  */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_MTT"

/*------------------------------------------------------------------*/
/* Génération du fichier de COMMANDES (CMD)                         */
/*------------------------------------------------------------------*/
//* #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
// sFiltre = "ID_TYP_ART = 'EDI' AND COD_ETAT <> 'ANN'"
sFiltre = "COD_ETAT <> 'ANN'"

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de PRESTATIONS (PRS)                       */
		/*------------------------------------------------------------------*/
		// [PM82][LOT1] Simplification
		// [MANTIS3743]
		CASE 1
			sFiltre = "ID_FOUR= 'MTT'"
			sNomFic = K_FIC2 // "PRS"
			sTypArt = "Ordre MTT"
			sTypArtNul = "Ordre MTT"
			This.Uf_Trace ( "ECR", "Génération du fichier de PRESTATION MTT en cours..." )


	End Choose

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()
	
	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
	
	For lCpt = 1 To lTot
		lRow = idwFicGenCmde.InsertRow ( 0 )
	
	//* #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
	
		sTypArt2 = idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" ) 
	
		// #7 [DCMP090109]
		sAction = idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )
	
		// [VDOC4970]
		sInfoSpbFrn = String ( idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) )
		sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))
	
		// [PM166][O2M]
		Choose Case sTypArt2
			Case "EDI", "PRS"
	
				// ON laisse tel quel
	
				// [PM82][LOT2]
				sVal = ""
				If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
					sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_REPARER_SAV", ";")
					If sVal = "OUI" Then
						sAction = "A_REPARER_SAV"
					End If
				End If
				// [PM82][LOT2]
				
				// [PM222-1]
				sVal = ""
				If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
					sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_CONTROLER_SAV", ";")
					If sVal = "OUI" Then
						sAction = "A_CONTROLER_SAV" 
					End If
				End If
				// [PM222-1]			
				
	
		// [VDOC4970]
			Case "ALE", "BAM", "ACC"
				
				// [ITSM113805]
				sAction = "A_COMMANDER"
				
				//	[VDOC3537]				
				sInfoSpbFrn = "990"
	
		// [VDOC4970]
			Case "PCM"
				sInfoSpbFrn = "990"

		// [PC938_ORANGE_V3]
			Case "RST"
				sInfoSpbFrn = "990"
				sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "RST_INFO_SIMPLE", ";")
				If sVal = "OUI" Then
					sAction = "ALIMENTER_STOCK"
				Else 
					sAction = "RST_A_COMMANDER"					
				End If

		// [PC938_ORANGE_V3]
			Case "RES"
				sAction = "PRET_A_RESTITUER"

			Case "REA"
				sAction = "RECUP_APP_SIN"
				
				
			Case Else			
				sAction = "A_COMMANDER"
		End Choose
		
		Choose Case sTypArt2 
			Case "EDI", "PRS", "PCM"
				sTypArt2 = idwFicCharg.GetItemString ( lCpt, "TYP_APP_SIN" )
				
			Case Else
				// On laisse tel quel
		End Choose
	//* :#6 [FNAC_PROD_ECH_TECH].[20090127140540720]
	
	// [ADRESSE_O2M]
		lnvCmdCommun.uf_GetAdresseO2MBase ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" ), "GENERATION", sNomLigne1, sNomLigne2, sAdrLigne1, sAdrLigne2, sCP, sVille )
	
	
		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "CODE_PROD", 		String (idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) + " " + idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_1",				idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_2",				idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CPL",			idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			
		idwFicGenCmde.SetItem ( lRow, "TYP_ART",			sTypArt2 )			
		idwFicGenCmde.SetItem ( lRow, "PROBLEME",			idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) )					
		idwFicGenCmde.SetItem ( lRow, "NUM_IMEI_SERIE",	idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" ) )						
		idwFicGenCmde.SetItem ( lRow, "MARQ_APP",			idwFicCharg.GetItemString ( lCpt, "MARQ_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_APP",			idwFicCharg.GetItemString ( lCpt, "MODL_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "NOM_GEST" ) )						
		idwFicGenCmde.SetItem ( lRow, "ACTION", sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "GARANTIE",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN",	sInfoSpbFrn  )		// [VDOC4970]
		idwFicGenCmde.SetItem ( lRow, "ASSUREUR",			idwFicCharg.GetItemString ( lCpt, "ASSUREUR" ) )
		idwFicGenCmde.SetItem ( lRow, "MT_VAL_ACHAT",	Dec(idwFicCharg.GetItemString ( lCpt, "MT_VAL_ACHAT" )) )
		idwFicGenCmde.SetItem ( lRow, "DTE_ACHAT",		idwFicCharg.GetItemString ( lCpt, "DTE_ACHAT" ) )
	
	
		// [PM166][O2M]
		If sAction = "A_COMMANDER" Then
			// On réinitialise certaines zones inutiles pour la commande
			idwFicGenCmde.SetItem ( lRow, "PROBLEME",	"")							
			idwFicGenCmde.SetItem ( lRow, "NUM_IMEI_SERIE",	"" )								
			idwFicGenCmde.SetItem ( lRow, "MARQ_APP",			idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
			idwFicGenCmde.SetItem ( lRow, "MODL_APP",			idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )						
//			idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN",	"0" )
			idwFicGenCmde.SetItem ( lRow, "ASSUREUR",			"" )
			idwFicGenCmde.SetItem ( lRow, "MT_VAL_ACHAT",	"" )
			idwFicGenCmde.SetItem ( lRow, "DTE_ACHAT",		"" )
			
		End If
		// :[PM166][O2M]	
	
		Choose Case sAction  
			Case "A_COMMANDER", "RST_A_COMMANDER"
				If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
				sInfoSpbFrnCplt += "ID_REF_FOUR=" + idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )
		
				If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
				sInfoSpbFrnCplt += "MT_TTC_CMDE=" + String ( idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) )
		End Choose
		
		// :[PM166][O2M]
		
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	sInfoSpbFrnCplt  )
		//* :#2 [FNAC_PROD_ECH_TECH]
	
	Next
	
	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, TRue ) // True : On indique les en-tetes
	
	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
	End If

	If iRet = -1 Then Exit

Next

Return iRet 

end function

public function integer uf_generer_fichier_srr (long alidtotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_SRR(PRIVATE)
//* Auteur			: FPI
//* Date				: 21/02/2014
//* Libellé			: Génération des commandes pour SFR La Réunion
//* Commentaires	: [PC925]
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*		FPI	15/10/2014	[PC14936]
//			FPI	25/07/2024  [MIG_PB2022] Soapconnection obsolète
//*-----------------------------------------------------------------

Int	iRet,  iRetFinal
Long	lTot, lCpt, lCptCas, lRow, lCptProd, lIdSin, lIdSeq
String	 sTypArt,  sFiltre, sTypArtNul, sEnrg, sSep, sVal, sNull
String sMess
n_cst_sp_ws_srr_caller wsCaller
Datetime dtNull
//SoapConnection uSoapCnx
srr_createorderresult uoResultWs
srr_validateorderresult uoResultValidWs

iRet = 1
SetNull(dtNull)
SetNull(sNull)

wsCaller= CREATE n_cst_sp_ws_srr_caller

/*uSoapCnx = CREATE soapconnection

iRet=wsCaller.createproxy(uSoapCnx )*/

wsCaller.uf_init( )

For lCptCas = 1 To 4
	
	iRet=1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
			sTypArt = "commandes"
			sTypArtNul = "commande"
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )

		/*------------------------------------------------------------------*/
		/* Génération du fichier de PRESTATIONS (PRS)                       */
		/*------------------------------------------------------------------*/
		CASE 2
		/*	sFiltre = "ID_TYP_ART = 'PRS' AND COD_ETAT <> 'ANN'"
			sTypArt = "prestations"
			sTypArtNul = "prestation"
			This.Uf_Trace ( "ECR", "Génération du fichier de PRESTATIONS en cours..." )
			idwFicGenCmde.DataObject = "d_trt_fichier_cmde_ORE_PRS"
			*/
			Continue
		/*------------------------------------------------------------------*/
		/* Génération du fichier des ANNULATION des COMMANDES (ACD)			  */
		/*------------------------------------------------------------------*/
		CASE 3
			/*sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT = 'ANN'"
			sNomFic = K_FIC3
			sTypArt = "annulations de commandes"
			sTypArtNul = "annulation de commandes"
			sAction = "A ANNULER"
			This.Uf_Trace ( "ECR", "Génération du fichier d'ANNULATIONS DES COMMANDES en cours..." )
			*/
			Continue  // [PC767-1] - annulations par mail
		/*------------------------------------------------------------------*/
		/* Génération du fichier des ANNULATION des COMMANDES (APR)			  */
		/*------------------------------------------------------------------*/
		CASE 4
		/*	sFiltre = "ID_TYP_ART = 'PRS' AND COD_ETAT = 'ANN'"
			sNomFic = K_FIC4
			sTypArt = "annulations de prestations"
			sTypArtNul = "annulation de prestations"
			sAction = "A ANNULER"
			This.Uf_Trace ( "ECR", "Génération du fichier d'ANNULATIONS DES PRESTATIONS en cours..." )
		*/	Continue // [PC767-1] - annulations par mail

	END CHOOSE

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	iRetFinal=1
	For lCpt = 1 To lTot

		// Création de la commande
		iRet=wsCaller.uf_createorder( idwFicCharg, lCpt, uoResultWs)
		
		If iRet<=0 Then 
			/*
				idwFicCharg.SetItem(lCpt,"ID_LOT_CMD",0)
				idwFicCharg.SetItem ( lCpt, "CMD_GEN_LE", dtNull )
				idwFicCharg.SetItem ( lCpt, "CMD_GEN_PAR", sNull )
			*/
			
			iRetFinal=-1
			
			sMess="Erreur de création de commande SRR : erreur " + String(iRet) // [BUG_GEN_CMD_SRR]
			
			If not isnull(uoResultWs) Then
			
				if isnull(uoResultWs.ws_message) Then uoResultWs.ws_message="Erreur de création de commande SRR : erreur inconnue (" + String(iRet) + ")" // [BUG_GEN_CMD_SRR]
				
				This.Uf_Trace ( "ECR", "Commande " + &
					f_getitem3(idwFicCharg, lCpt,"ID_SIN") + "-" + f_getitem3(idwFicCharg, lCpt,"ID_SEQ")  + &
							" erreur de création de commande : " + &
					uoResultWs.ws_message )
					
					sMess="Erreur de création de commande SRR : " + uoResultWs.ws_message
			End if
		End if

		// Validation de la commande
		If iRet > 0 Then
			iRet=wsCaller.uf_validateorder( idwFicCharg, lCpt, uoResultValidWs)
			
			If iRet<=0 Then 
				/*					
					idwFicCharg.SetItem(lCpt,"ID_LOT_CMD",0)
					idwFicCharg.SetItem ( lCpt, "CMD_GEN_LE", dtNull )
					idwFicCharg.SetItem ( lCpt, "CMD_GEN_PAR", sNull )
					idwFicCharg.SetItem(lCpt,"ID_CMD_FRN",sNull)
				*/
				
				iRetFinal=-1

				sMess="Erreur de validation de commande SRR : " 

				If not isnull(uoResultValidWs) Then
					This.Uf_Trace ( "ECR", "Commande " + &
						f_getitem3(idwFicCharg, lCpt,"ID_SIN") + "-" + f_getitem3(idwFicCharg, lCpt,"ID_SEQ") + &
							"Erreur de validation de la commande " +  f_getitem3(idwFicCharg, lCpt,"ID_CMD_FRN")  + " : " + &
						uoResultValidWs.ws_message )
						
						sMess+=uoResultValidWs.ws_message
				End if
			Else
				SetNull(sMess) // [PC14639]
			End if
		End if
		
		// [PC14936]
		lIdSin=idwFicCharg.GetItemNumber(lCpt,"ID_SIN")
		lIdSeq=idwFicCharg.GetItemNumber(lCpt,"ID_SEQ")
		
		SQLCA.PS_U01_COMMANDE_SRR_V01(lIdSin, lIdSeq, uoResultWs.idcommande, sMess,stGlb.sCodOper)		
		// :[PC14936]
		
	Next

	// Maj des commandes
	If idwFicCharg.Update () > 0 Then
		F_Commit ( SQLCA, True )
		This.Uf_Trace ( "ECR", "Update du marquage réussi, les commandes sont flaguées en base." )
	Else
		F_Commit ( SQLCA, False )
		This.Uf_Trace ( "ECR", "ERREUR, Update du marquage en base a échoué." )
	End if

	If iRetFinal > 0 Then
		This.Uf_Trace ( "ECR", "Commandes " + sTypArt + " générées avec succès")
	Else
		iRetFinal = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération des commandes des " + sTypArt  )
		Exit
	End if
	
Next

Destroy wsCaller

// [PC14936].V2 - ITSM 292174 - Vu avec SV - on renvoie toujours OK 
//Return iRetFinal 
Return 1
end function

private function integer uf_generer_fichier_vipp2 (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_VIPP2 (PRIVATE)
//* Auteur			: FPI
//* Date				: 14/05/2014	
//* Libellé			: Génération du fichier de commande pour le fournisseur VIPP [PC13448]
//* Commentaires	: Trois fichiers seront générés dans le même répertoires :
//*					  un pour les commandes   : CMDjjmma.ind  (CMD10091.001)
//*					  un pour les prestations : PRSjjmma.ind  (PRS10091.001)
//*					  un pour les annulations : ANNjjmma.ind  (ANN10091.001)
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   

//*-----------------------------------------------------------------

Int	iRet, iFic
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sVal, sChaine
Decimal {2}	dcTvaParDefaut, dcVal
String sSep, sEnrg

iRet = 1
// [DT_60_AUGM_TVA] 1.196
dcTvaParDefaut = 20

idwFicGenCmde.DataObject = "d_trt_fichier_cmde_VIPP2"

/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le BRIGHTPOINT               */
/*------------------------------------------------------------------*/
For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC1
			sTypArt = "commandes"
			sTypArtNul = "commande"
			sAction = "A COMMANDER"
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )

	End Choose

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	idwFicGenCmde.Reset()

	/*------------------------------------------------------------------*/
	/* ORANGE ne souhaite pas de tabulation, le séparateur doit être    */
	/* un point virgule. PB ne génère pas ce format (uniquement des     */
	/* virgule avec CSV). Je fais donc ici de l'épicerie pour gérer     */
	/* ces point virgules.                                              */
	/*------------------------------------------------------------------*/

	For lCpt = 1 To lTot

		lRow=idwFicGenCmde.InsertRow(0)
		
		/* scopus_id
		Si le n° d’adhésion Cdiscount comporte 17 caractères, on retire les 2 derniers caractères ;
		Si le n° d’adhésion Cdiscount comporte 18 caractères, on retire le 1er et les 2 derniers caractères. 
		*/
		sVal= idwFicCharg.GetItemString ( lCpt, "ID_CONTRAT_ABONNE") 
		If isNull(sVal) Then 
			sVal=""
		End if
		
		if Len(sVal) =17 Then
			sVal=Left(sVal,15)
		Else
			sVal=Mid(sVal,2,15)		
		End if
		
		idwFicGenCmde.SetItem(lRow,"SCOPUS_ID",sVal)
		
		// id_typo
		sVal= idwFicCharg.GetItemString ( lCpt, "VARIANTE_DP37") 
		If isNull(sVal) Then 
			sVal=""
		End if

		Choose Case sVal
			Case "GTI_SERENITE"
				idwFicGenCmde.SetItem(lRow,"ID_TYPO",47)
			Case "PRO"
				idwFicGenCmde.SetItem(lRow,"ID_TYPO",48)
		End Choose
		
		// sku
		sVal= idwFicCharg.GetItemString ( lCpt, "SKU_IDENT_APPAREIL") 
		If isNull(sVal) Then 
			sVal=""
		End if
		
		idwFicGenCmde.SetItem(lRow,"SKU",sVal)
		
		// decote
		dcVal = Dec(idwFicCharg.GetItemString ( lCpt, "MT_PEC" )	)
		If dcVal = 0 Or IsNull ( dcVal ) Then
			sVal=idwFicCharg.GetItemString ( lCpt, "MT_VAL_ACHAT" ) 
		Else
			sVal=idwFicCharg.GetItemString ( lCpt, "MT_PEC" ) 
		End If
		
		sVal=String( Dec(sVal) * 100 ) // Conversion en centimes
		sVal=Left(sVal,Len(sVal) - 3 )
		
		idwFicGenCmde.SetItem(lRow,"DECOTE",sVal)
		
		// indemnisation
		sVal=idwFicCharg.GetItemString ( lCpt, "CODE_INDEMN_DP37")
		If isNull(sVal) Then 
			sVal=""
		End if
		idwFicGenCmde.SetItem(lRow,"INDEMNISATION",sVal)
		
		// lot
		idwFicGenCmde.SetItem(lRow,"LOT",alidlotcmd)
		
		// n° dossier
		idwFicGenCmde.SetItem(lRow,"NO_DOSSIER",String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )))
		
		// code fournisseur
		idwFicGenCmde.SetItem(lRow,"CODE_FOURNISSEUR","CDS")
		
	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	
	// On supprime l'heure du nom de fichier
	sNomFic=Left(sNomFic,Len(sNomFic) - 10) + Right(sNomFic,4)
	
	// Sauvegarde - pas de ; en fin de ligne
	//iRet=idwFicGenCmde.SaveAsFormattedText(sNomFic,EncodingANSI! ,";","")
	iFic = FileOpen( sNomFic, LineMode!, Write!, Shared!, Replace! )

	lTot = idwFicGenCmde.RowCount ()
	sSep  = ";"
	
	sEnrg="Scopus Id;Id Typo;Sku;Decote;indemnisation;Lot;No Dossier;Code Fournisseur"
	iRet = FileWrite ( iFic, sEnrg ) 
	
	If iRet >=0 Then
		For lCpt = 1 To lTot
			sEnrg = ""
	
			sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "SCOPUS_ID" ) + sSep
			sEnrg +=String(idwFicGenCmde.GetItemNumber( lCpt, "ID_TYPO" )) + sSep
			sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "SKU" ) + sSep
			sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "DECOTE" ) + sSep
			sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "INDEMNISATION" ) + sSep
			sEnrg +=String(idwFicGenCmde.GetItemNumber( lCpt, "LOT" )) + sSep
			sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "NO_DOSSIER" ) + sSep
			sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "CODE_FOURNISSEUR" ) 
			
			iRet = FileWrite ( iFic, sEnrg ) 
	
			If iRet < 0 Then 
				iRet = -1
				Exit
			End If 
	
		Next
	End if
	
	Fileclose ( iFic ) 
	// Fin enregirstrement

	If iRet = -1 Then FileDelete ( sNomFic )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_electrodepot (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_ElectroDepot (PRIVATE)
//* Auteur			: Fabry 
//* Date				: 15/12/2014
//* Libellé			: Génération du fichier de commande pour ElectroDepot
//* Commentaires	: [PC13321]
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF		07/05/2004 DCMP 040134 D. Bizien A-NOVO souhaite l'ID_PROD plutot que le LIB_PROD
//* #2	 JCA		28/02/2008 DCMP 080158 - Changement de format du fichier
//* #3    JFF     02/12/2008 BUG remonté par David Ibersien
//*       JFF     10/06/2010 [PC419/440/418/439_MICROMANIA]
//*       JFF     22/02/2011 [PC363_AUC].[ECL_FICH]
// 		FPI		05/10/2011	[VDoc5352] correction (déplacer)
// 		JFF   21/06/2018 [VDOC26276]
//       JFF   19/12/2022 [RS4093_EVOL_ELD]
//*-----------------------------------------------------------------

Int	iRet, iFic
Long	lTot, lCpt, lCptCas, lRow, lCptProd, lIdprodSav
String	sNomFic, sNomFicOrig, sTypArt, sAction, sFiltre, sTypArtNul, sLibCplt, sFiltreSFR, sNomFicSav, sInfoSpbFrnCplt, sVal
String sIdprodSav, sIdprodLu, sSep, sEnrg
n_cst_string lnvPFCString  

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le A-NOVO                   */
/*------------------------------------------------------------------*/

// [RS4093_EVOL_ELD]
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_ElectroDepot_RS4093"

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier spéciale pour MCM								  */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "COD_ETAT <> 'ANN'"
			sNomFic = K_FIC8
			sTypArt = "Bon cadeau"
			sTypArtNul = "Bon cadeau"
			sAction = "CMDE_CARTE_CADEAU"
			This.Uf_Trace ( "ECR", "Génération du fichier des CARTE CADEAUX ELECTRO DEPOT en cours..." )


	END CHOOSE

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "IDENT_SPB", "SPB_FR_00001" )
		idwFicGenCmde.SetItem ( lRow, "LIB_IDENT_SPB", "SPB_FR_00001" )
		idwFicGenCmde.SetItem ( lRow, "NUM_TICKET", String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) )
		idwFicGenCmde.SetItem ( lRow, "CODE_EAN_ED", "3497679447590" )
		
		sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))
		sVal = ""
		If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
			sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "NUM_CC_ELD", ";")
		End If
		
		If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
			sVal = String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) 
		End If 
		
		idwFicGenCmde.SetItem ( lRow, "NUM_CARTE_ED", sVal )
		
		idwFicGenCmde.SetItem ( lRow, "DTE_EMISS", String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "yyyymmdd" ) )
		idwFicGenCmde.SetItem ( lRow, "HEU_EMISS", String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "hhmm" ) )
		//idwFicGenCmde.SetItem ( lRow, "MT_CARTE", F_Remplace ( String ( idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) * 100 ), ".00", "" ) )	
		idwFicGenCmde.SetItem ( lRow, "MT_CARTE", Right("000000" + F_Remplace ( String ( idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) * 100 ), ".00", "" ),6 ) )	
/*
		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD", String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "ID_SEQ", String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
*/		

		// [RS4093_EVOL_ELD]
		idwFicGenCmde.SetItem ( lRow, "TYP_DEM", "C" )
	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )

	iFic = FileOpen( sNomFic, LineMode!, Write!, Shared!, Replace! )
	lTot = idwFicGenCmde.RowCount ()
	sSep  = ";"
	
	For lCpt = 1 To lTot
		sEnrg = ""

		sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "IDENT_SPB" ) + sSep
		sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "LIB_IDENT_SPB" ) + sSep
		sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "NUM_TICKET" ) + sSep
		sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "CODE_EAN_ED" ) + sSep
		sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "NUM_CARTE_ED" ) + sSep
		sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "DTE_EMISS" ) + sSep
		sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "HEU_EMISS" ) + sSep
		sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "MT_CARTE" ) + sSep
		
		/*
		sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "NUM_LOT_CMD" ) + sSep
		sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "FOURNISSEUR" ) + sSep
		sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "ID_SEQ" ) */

		// [RS4093_EVOL_ELD]
		sEnrg +=idwFicGenCmde.GetItemString ( lCpt, "TYP_DEM" ) + sSep

		iRet = FileWrite ( iFic, sEnrg ) 

		If iRet < 0 Then 
			iRet = -1
			Exit
		End If 
		
	Next

	Fileclose ( iFic ) 

	If iRet = -1 Then FileDelete ( sNomFic )


	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
		
		// [VDOC26276]
		This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic ) 
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_tamet (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_TAMET (PRIVATE)
//* Auteur			: JFF
//* Date				: 13/02/2012
//* Libellé			: Génération du fichier de commande pour le fourniseur CORDON
//* Commentaires	: 
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF		07/05/2004 DCMP 040134 D. Bizien A-NOVO souhaite l'ID_PROD plutot que le LIB_PROD
//* #2	 JFF 	 	12/12/2005 DCMP 050649 M. LEGAC, ajout Zone pour AEVUM
//* #3	 MADM 	09/05/2006 DCMP 060356 Remplacement du fournisseur AEVUM par CORDON
//* #4    MADM    19/06/2006 DCMP 060447 Ajout de la zone INFO_SPB_FRN
//*       JFF     19/09/2011   [PM82][LOT1]
//*       JFF     19/09/2011   [PM82][LOT2]
//        JFF     17/04/2012   [PM200][LOT2][DESOX]
// 		 JFF	   03/07/2012   [MANTIS3743]
// 		 JFF	   23/11/2012   [VDOC9111]
//        JFF     26/11/2012   [PC877]
//        JFF     07/05/2013   [PC929-1]
//        JFF     07/05/2013   [VDOC11610]
//        JFF     09/09/2013   [PM222-1]
//        JFF     13/01/2014   [PM246]
//        JFF     02/06/2014   [PC929_CDISCOUNT][PC929-2-V3]
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd, lIdEvt, lDebCpt, lFinCpt
String	sNomFic, sTypArt, sFiltre, sTypArtNul, sLibCplt, sFiltreSFR, sNomFicSav, sInfoSpbFrnCplt , sVal
n_cst_string lnvPFCString
String sTypArt2, sAction

iRet = 1
/*------------------------------------------------------------------------------------*/
/* Format du fichier de commandes pour le frn AEVUM/AVM           						  */
/* #3	 MADM	 09/05/06	  [DCMP060356]: remplacement  du frn AEVUM/AVM par CORDON/COR */
/*------------------------------------------------------------------------------------*/
// [PM200][LOT2][DESOX]
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_TAMET"

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de PRESTATIONS (PRS)                       */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_FOUR= 'TMT'"
			sNomFic = K_FIC2 // "PRS"
			sTypArt = "Ordre TAMET"
			sTypArtNul = "Ordre TAMET"
			This.Uf_Trace ( "ECR", "Génération du fichier de PRESTATION TAMET en cours..." )

	END CHOOSE

	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" + sLibCplt )
		Choose Case lCptCas
			Case 2
				// Pour le cas PRS on génére un fichier vide (s'il doit être vide).

			Case Else
				Continue
		End Choose
	End If

	For lCpt = 1 To lTot

		lRow = idwFicGenCmde.InsertRow ( 0 )

		sTypArt2 = idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" )
		sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))


		// [PM166][O2M]
		Choose Case sTypArt2
			Case "EDI", "PRS"
	
				sTypArt2 = idwFicCharg.GetItemString ( lCpt, "TYP_APP_SIN" )

		End Choose
		
		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )

		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" ) ) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )

		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_PROD", 		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) + " " + idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR_CPL",	idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ) )			
		idwFicGenCmde.SetItem ( lRow, "TYP_ART",			sTypArt2 )			
		idwFicGenCmde.SetItem ( lRow, "PROBLEME",			idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) )					
		idwFicGenCmde.SetItem ( lRow, "NUM_IMEI_ANC",	idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" ) )						
		idwFicGenCmde.SetItem ( lRow, "MARQ_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "ACTION",			idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )  )

			
		// [PM82][LOT2]
		sVal = ""
		If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
			sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_REPARER_SAV", ";")
			If sVal = "OUI" Then
				idwFicGenCmde.SetItem ( lRow, "ACTION", "A_REPARER_SAV" )
			End If
		End If
		// [PM82][LOT2]	
		
		// [PM222-1]
		sVal = ""
		If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
			sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_CONTROLER_SAV", ";")
			If sVal = "OUI" Then
				idwFicGenCmde.SetItem ( lRow, "ACTION", "A_CONTROLER_SAV" )
			End If
		End If
		// [PM222-1]	
		

		// [PM200][LOT2][DESOX]
		sVal = ""
		If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
			sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_DESOXYDER_SAV", ";")
			If sVal = "OUI" Then
				idwFicGenCmde.SetItem ( lRow, "ACTION", "A_DESOXYDER_SAV" )
			End If
		End If		
		// [PM200][LOT2][DESOX]
		
		// [PM246]
		sVal = ""
		If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
			sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "MAJ_ADRESSE", ";")
			If sVal = "OUI" Then
				idwFicGenCmde.SetItem ( lRow, "ACTION", "MAJ_ADRESSE" )
			End If
		End If		
		// [PM246]
		
		// [VDOC9111]
		lnvPFCString.of_Setkeyvalue ( sInfoSpbFrnCplt, "LIB_PROD", idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ), ";")
		
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "ID_GTI",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )				
		// #4
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN",	String ( idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) ) )
		
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	sInfoSpbFrnCplt  )				

	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, False )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic ) + " " + sLibCplt )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + ", " + sLibCplt + " : le fichier n'est pas généré !!" )
		Exit
	End If


	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_cdiscountpro_new (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_CDISCOUNTPRO (PRIVATE)
//* Auteur			: JFF
//* Date				: 21/04/2009
//* Libellé			: Génération du fichier de commande pour le fournisseur CDISCOUNTPRO
//* Commentaires	: Trois fichiers seront générés dans le même répertoires :
//*					  un pour les commandes   : CMDjjmma.ind  (CMD10091.001)
//*					  un pour les prestations : PRSjjmma.ind  (PRS10091.001)
//*					  un pour les annulations : ANNjjmma.ind  (ANN10091.001)
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 17/10/2002	  Modification SFR : Pour ce produit (5712), on
//*								  crée un fichier supplémentaire pour chaque type (cmd, prs, annul ...)
//*								  et on les écrit dans un répertoire spécifique
//*								  Annexe 7 (6.7.2) dans l'intégration de SFR, analyse des traitements
//*
//* #4	 JFF	 07/04/2003   Ajout de l'ID_REF_FOUR et MT_TTC_CMDE
//* #5	 CAG	 06/05/2003	  Génération d'un fichier vide de cmde qd pas de cmdes
//        JFF   12/04/2012   [VDOC7530]
//        JFF   02/03/2015   [PM289_CDP]
//        JFF   08/12/2015   [PM289-2]
// 		 JFF	 26/02/2016   [VDOC20092]
//        JFF   21/03/2016   [PM289-3]
// 		 JFF   21/06/2018 [VDOC26276]
//*-----------------------------------------------------------------

Int	iRet, iFic, iPos
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sInfoSpbFrnCplt, sPays, sSep, sEnrg, sIdRefFour 
n_cst_string lnvPFCString
Decimal {2} dcMtTTCcmde, dcTvaParDefaut, dcPrixHTTrspFixePM289, dcMtHTcmde 

dcTvaParDefaut = 20 // 1.196
dcPrixHTTrspFixePM289 = 9

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le BRIGHTPOINT               */
/*------------------------------------------------------------------*/

// [VDOC7530]
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_CDISCOUNTPRO_new" // [PM289_CDP]

sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
sNomFic = K_FIC1
sTypArt = "commandes"
sTypArtNul = "commande"
sAction = "A COMMANDER"
This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )



idwFicCharg.SetFilter ( sFiltre )
idwFicCharg.Filter ()
idwFicCharg.Sort ()
lTot = idwFicCharg.RowCount ()			
idwFicGenCmde.Reset ()

/*------------------------------------------------------------------*/
/* On ne génère pas de fichier si pas de commandes ou pas de        */
/* prestations.                                                     */
/*------------------------------------------------------------------*/
If lTot = 0 Then
	This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
End If

For lCpt = 1 To lTot

	sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))
	If IsNull ( sInfoSpbFrnCplt ) Then sInfoSpbFrnCplt = "" 

	sPays = "FR"
	If idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) = "00000" Then
		sPays = ""
	End If 

	dcMtTTCcmde = idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" )
	dcMtTTCcmde = dcMtTTCcmde / ( 1 + dcTvaParDefaut / 100 )
	dcMtHTcmde  = dcMtTTCcmde - dcPrixHTTrspFixePM289

	sIdRefFour = idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" ) 

	// [PM289-3]
	iPos = Pos ( sIdRefFour, "_" ) 
	If iPos > 0 Then
		sIdRefFour = Left ( sIdRefFour, iPos - 1 )
	End If

	lRow = idwFicGenCmde.InsertRow ( 0 )

	idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
	idwFicGenCmde.SetItem ( lRow, "DTE_CMDE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "yyyymmdd" ) )
	idwFicGenCmde.SetItem ( lRow, "REF_CAMP",		"SPB" + String ( Year ( Date ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ))) ) ) 
	idwFicGenCmde.SetItem ( lRow, "ID_CDP", 	"0000000C3VZH" )
	idwFicGenCmde.SetItem ( lRow, "ADR_CIV", idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV" ) )
	idwFicGenCmde.SetItem ( lRow, "NOM", idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) )
	idwFicGenCmde.SetItem ( lRow, "PRENOM", idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
	idwFicGenCmde.SetItem ( lRow, "ADR_LIVR1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
	idwFicGenCmde.SetItem ( lRow, "ADR_LIVR2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
	idwFicGenCmde.SetItem ( lRow, "ADR_LIVR_CPL",	idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
	idwFicGenCmde.SetItem ( lRow, "RAISON_SOC",	"" )		
	idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
	idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
	idwFicGenCmde.SetItem ( lRow, "ADR_PAYS",		sPays  )		
	idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
	idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
	idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ) )			
	idwFicGenCmde.SetItem ( lRow, "MODE_LIVR",		"COL" )			
	
	// [PM289-2]
	idwFicGenCmde.SetItem ( lRow, "FRAIS_PORT",		String ( dcPrixHTTrspFixePM289 ) )			
	
	idwFicGenCmde.SetItem ( lRow, "ID_REF_FOUR",		sIdRefFour ) 				
	idwFicGenCmde.SetItem ( lRow, "MT_HT_CMDE",		String ( dcMtHTcmde  ))
	idwFicGenCmde.SetItem ( lRow, "QTE",			"1" )	

Next


This.uf_nom_fichier ( sNomFic, lCptProd )

// [VDOC20092]
iRet = idwFicGenCmde.SaveAs ( sNomFic, XLSX!, TRUE )	

If iRet > 0 Then
	This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
	This.Uf_Trace ( "ECR", "PI doit modifier le nom du fichier en << commandes_SPB_aaaammjj_hhmmss.XLSX >>" )

	// [VDOC26276]
	This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic ) 

Else
	iRet = -1
	This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
End If

Return iRet 
end function

private function integer uf_generer_fichier_bak2 (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_BAK2 (PRIVATE)
//* Auteur			: JFF
//* Date				: 12/10/2016
//* Libellé			: Génération du fichier de commande pour le fournisseur BRIGHTPOINT
//* Commentaires	: Trois fichiers seront générés dans le même répertoires :
//*					  un pour les commandes   : CMDjjmma.ind  (CMD10091.001)
//*					  un pour les prestations : PRSjjmma.ind  (PRS10091.001)
//*					  un pour les annulations : ANNjjmma.ind  (ANN10091.001)
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 17/10/2002	  Modification SFR : Pour ce produit (5712), on
//*								  crée un fichier supplémentaire pour chaque type (cmd, prs, annul ...)
//*								  et on les écrit dans un répertoire spécifique
//*								  Annexe 7 (6.7.2) dans l'intégration de SFR, analyse des traitements
//*
//* #4	 JFF	 07/04/2003   Ajout de l'ID_REF_FOUR et MT_TTC_CMDE
//* #5	 CAG	 06/05/2003	  Génération d'un fichier vide de cmde qd pas de cmdes
//*-----------------------------------------------------------------

Int	iRet, iPos
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sInfoSpbFrnCplt, sVal, sIdRefFour 
n_cst_string lnvPFCString

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le BRIGHTPOINT               */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_BAK2"

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC1
			sTypArt = "commandes"
			sTypArtNul = "commande"
			sAction = "A_COMMANDER"
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )

	End Choose


	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))
	
		// [PM246]
		sVal = ""
		If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
			sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "MAJ_ADRESSE", ";")
			If sVal = "OUI" Then
				sAction = "MAJ_ADRESSE"
			End If
		End If		
		// [PM246]	

		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) + " " + idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR_CPL",	idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ) )			
		idwFicGenCmde.SetItem ( lRow, "TYP_ART",			idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" ) )			
		idwFicGenCmde.SetItem ( lRow, "MARQ_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "MARQ_SIN",		   idwFicCharg.GetItemString ( lCpt, "MARQ_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_SIN",		   idwFicCharg.GetItemString ( lCpt, "MODL_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "NOM_GEST" ) )						
		idwFicGenCmde.SetItem ( lRow, "ACTION",			sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "ID_GTI",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )				

		sIdRefFour = idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" ) 

		// [PM289-3]
		iPos = Pos ( sIdRefFour, "_" ) 
		If iPos > 0 Then
			sIdRefFour = Left ( sIdRefFour, iPos - 1 )
		End If
		
		idwFicGenCmde.SetItem ( lRow, "ID_REF_FOUR",			sIdRefFour ) 				
		idwFicGenCmde.SetItem ( lRow, "MT_TTC_CMDE",			String ( idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) ) )				

	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, False )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_cordon (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_CORDON (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 02/01/2017
//* Libellé			: Génération du fichier de commande pour CORDON
//* Commentaires	: [DT253]
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	PHG	31/03/2008 	[DCMP080162] AJout Valeur Publique d'achat et Date Achat
//* #2	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
//* #3   JFF   20/10/2008  [FNAC_PROD_ECH_TECH].[20090127140540720]
//* #4   JFF   20/10/2008  [FNAC_PROD_ECH_TECH].[20090225143455120]
//* #7	FPI	20/03/2009	[DCMP090109] SBE devient réparateur d'IPhone
//* #8   JFF   27/03/2009  [DCMP090152] Civ long pour SBE
//*  	   JFF	13/04/2010  [ADRESSE_SBE]
//			FPI	10/08/2010	[PM01] Process 4
//* 		JFF   03/05/2011  [PM166][SBE]
//*      JFF   12/12/2011  [VDOC4970]
//*      JFF   04/10/2012  [BLCODE]
//*      JFF   12/12/2011  [VDOC9043]
//       JFF   07/05/2013  [PC938_ORANGE_V3]
//       JFF   09/09/2013  [PM222-1]
//       JFF   13/01/2014  [PM246]
//       JFF   28/03/2014  [DT081_EVOL_PRET_BRIS]
//       JFF   04/11/2014  [PM280-1]
//       JFF   16/03/2015  [DT081-3]
//       JFF   12/05/2015  [DT141][MANTIS14455]
//       JFF   17/08/2017  [BUG_MAIL_CORDON]
// 		JFF   21/06/2018  [VDOC26276]
//*-----------------------------------------------------------------
Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sIdRefFour, sTypArt2, sInfoSpbFrnCplt
String sNomLigne1, sNomLigne2, sAdrLigne1, sAdrLigne2, sCP, sVille, sValCar, sVal, sInfoSpbFrn
n_cst_cmd_commun	lnvCmdCommun
Long lIdProd,  lDeb,lFin, lCptKey
n_cst_attrib_key	lnv_Key[]
n_cst_string lnvString
String sIMEICorr, sInfoFrnSpbCplt

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour SBE 								  */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_CORDON"

/*------------------------------------------------------------------*/
/* Génération du fichier de COMMANDES (CMD)                         */
/*------------------------------------------------------------------*/
//* #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
// sFiltre = "ID_TYP_ART = 'EDI' AND COD_ETAT <> 'ANN'"
sFiltre = "COD_ETAT <> 'ANN'"

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de PRESTATIONS (PRS)                       */
		/*------------------------------------------------------------------*/
		// [PM82][LOT1] Simplification
		// [MANTIS3743]
		CASE 1
			sFiltre = "ID_FOUR= 'COR'"
			sNomFic = K_FIC2 // "PRS"
			sTypArt = "Ordre CORDON"
			sTypArtNul = "Ordre CORDON"
			This.Uf_Trace ( "ECR", "Génération du fichier de PRESTATION CORDON en cours..." )

	End Choose

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()
	
	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
	
	For lCpt = 1 To lTot
		lRow = idwFicGenCmde.InsertRow ( 0 )
	
	//* #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
	
		sTypArt2 = idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" ) 
	
		// #7 [DCMP090109]
		sAction = idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )
	
		// [VDOC4970]
		sInfoSpbFrn = String ( idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) )
		sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))
		sInfoFrnSpbCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_FRN_SPB_CPLT" ) ))			
	
		// [PM166][SBE]
		Choose Case sTypArt2
			Case "EDI", "PRS"
	
				// ON laisse tel quel
	
				// [PM82][LOT2]
				sVal = ""
				If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
					sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_REPARER_SAV", ";")
					If sVal = "OUI" Then
						sAction = "A_REPARER_SAV"
					End If
				End If
				// [PM82][LOT2]
				
				// [PM222-1]
				sVal = ""
				If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
					sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_CONTROLER_SAV", ";")
					If sVal = "OUI" Then
						sAction = "A_CONTROLER_SAV" 
					End If
				End If
				// [PM222-1]			
				
				// [PM280-1]
				sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_REP_GARANTIE", ";")
				If sVal = "OUI" Then
					sAction = "A_REP_GARANTIE"
				End If
				
				// [PM287-3]
				sVal = lnvString.of_Getkeyvalue ( sInfoFrnSpbCplt, "IFDNMQ_ACT", ";")
				If sVal = "FAIT" Then
					sAction = "IFDNMQ_FAIT"
				End If
	
		// [VDOC4970]
			Case "ALE", "BAM", "ACC"
				
				// [ITSM113805]
				sAction = "A_COMMANDER"
				
				//	[VDOC3537]				
				sInfoSpbFrn = "990"
	
		// [VDOC4970]
			Case "PCM"
				sInfoSpbFrn = "990"

		// [PC938_ORANGE_V3]
			Case "RST"
				sInfoSpbFrn = "990"
				sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "RST_INFO_SIMPLE", ";")
				If sVal = "OUI" Then
					sAction = "ALIMENTER_STOCK"
				Else 
					sAction = "RST_A_COMMANDER"					
				End If

		// [PC938_ORANGE_V3]
			Case "RES"
				sAction = "PRET_A_RESTITUER"

			Case "REA"
				sAction = "RECUP_APP_SIN"

			Case "PST"

				// [DT081_EVOL_PRET_BRIS]
				// [DT081-3]
				Choose Case sAction 
					Case "DEM_RESTIT", "INFO_CAUTION"
						// On laisse
					case Else 
						sAction = "A_COMMANDER"
				End Choose
				
			Case Else			
				sAction = "A_COMMANDER"
		End Choose
		
		Choose Case sTypArt2 
			Case "EDI", "PRS", "PCM", "CAF"
				sTypArt2 = idwFicCharg.GetItemString ( lCpt, "TYP_APP_SIN" )
				
			Case Else
				// On laisse tel quel
		End Choose
	//* :#6 [FNAC_PROD_ECH_TECH].[20090127140540720]
	
	// [PM246]
	sVal = ""
	If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
		sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "MAJ_ADRESSE", ";")
		If sVal = "OUI" Then
			sAction = "MAJ_ADRESSE"
		End If
	End If		
	// [PM246]	

// lignes fin
		
		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_POLICE",		idwFicCharg.GetItemString ( lCpt, "LIB_POLICE" ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "CODE_PROD", 		String (idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) )
		idwFicGenCmde.SetItem ( lRow, "PRENOM_CLI",		idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )

		If idwFicCharg.GetItemString ( lCpt, "ADR_COD_CIV" ) = "Ste" Then
			idwFicGenCmde.SetItem ( lRow, "RAISON_SOCIALE",	idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) + " " + idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		Else
			idwFicGenCmde.SetItem ( lRow, "RAISON_SOCIALE",	""	)
		End If
		
		idwFicGenCmde.SetItem ( lRow, "ADR_1",				idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_2",				idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CPL",			idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			

		// [BUG_MAIL_CORDON]
		sVal = Trim ( idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ))
		If sVal = "" Or IsNull ( sVal) Then
			sVal = Trim ( lnvString.of_getkeyvalue (sInfoSpbFrnCplt, "MAIL_ASSURE", ";"))
			If sVal = "" Or IsNull ( sVal) Then sVal = ""
		End If
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			sVal  )									
		
		idwFicGenCmde.SetItem ( lRow, "TYP_ART",			sTypArt2 )			
		idwFicGenCmde.SetItem ( lRow, "PROBLEME",			idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) )
		
		sVal = idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" )
		If F_IMEI ( sVal, sIMEICorr ) Then
			idwFicGenCmde.SetItem ( lRow, "NUM_IMEI",	sVal )
		Else
			idwFicGenCmde.SetItem ( lRow, "NUM_SERIE", sVal )
		End If 		
		
		idwFicGenCmde.SetItem ( lRow, "MARQ_APP",			idwFicCharg.GetItemString ( lCpt, "MARQ_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_APP",			idwFicCharg.GetItemString ( lCpt, "MODL_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "MAJ_PAR" ) )						
		idwFicGenCmde.SetItem ( lRow, "ACTION", sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "GARANTIE",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN",	sInfoSpbFrn  )		// [VDOC4970]

		sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt, "CODE_PICK_UP", ";")
		If IsNull ( sVal ) Then sVal = ""
		idwFicGenCmde.SetItem ( lRow, "CODE_PICK_UP",	sVal  )
		
		idwFicGenCmde.SetItem ( lRow, "ASSUREUR",			idwFicCharg.GetItemString ( lCpt, "ASSUREUR" ) )
		// [DCMP080162] AJout Valeur Publique d'achat et Date Achat ( note : date stockée sous forme de chaine )
		idwFicGenCmde.SetItem ( lRow, "MT_VAL_ACHAT",	idwFicCharg.GetItemString ( lCpt, "MT_VAL_ACHAT" ))
		idwFicGenCmde.SetItem ( lRow, "DTE_ACHAT",		idwFicCharg.GetItemString ( lCpt, "DTE_ACHAT" ) )
		idwFicGenCmde.SetItem ( lRow, "MT_PEC",			idwFicCharg.GetItemString ( lCpt, "MT_PEC" ) )
	

		// [PM166][SBE]
		If sAction = "A_COMMANDER" Then
			// On réinitialise certaines zones inutiles pour la commande
/* [DT141][MANTIS14455]
			idwFicGenCmde.SetItem ( lRow, "PROBLEME",	"")							
			idwFicGenCmde.SetItem ( lRow, "NUM_IMEI_SERIE",	"" )								
*/			
/* Idem à la RST d'OV3, on laisse la marq/modl IFR, plus haut sur MARQ_APP et MODL_APP
			idwFicGenCmde.SetItem ( lRow, "MARQ_APP",			idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
			idwFicGenCmde.SetItem ( lRow, "MODL_APP",			idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )						
*/		End If
		// :[PM166][SBE]	

		// [REPAR_GTI]
		If sAction = "A_REP_GARANTIE" Then
			idwFicGenCmde.SetItem ( lRow, "MARQ_APP",			idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
			idwFicGenCmde.SetItem ( lRow, "MODL_APP",			idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )				
		End if
		// :[REPAR_GTI]
		
/*
		Choose Case sAction  
			Case "A_COMMANDER", "RST_A_COMMANDER"
				If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
				sInfoSpbFrnCplt += "ID_REF_FOUR=" + idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )
		
				If Len ( sInfoSpbFrnCplt ) > 0 Then sInfoSpbFrnCplt += ";"
				sInfoSpbFrnCplt += "MT_TTC_CMDE=" + String ( idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) )
		End Choose
*/		
		// :[PM166][SBE]
		
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	sInfoSpbFrnCplt  )
		//* :#2 [FNAC_PROD_ECH_TECH]
	
	Next
	
	lTot = idwFicGenCmde.RowCount ()
	lRow = idwFicGenCmde.InsertRow (1)
	idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD", "DEBUT#" + String ( lTot ) )
	lRow = idwFicGenCmde.InsertRow (0)
	idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD", "FIN#" + String ( lTot ) )
	
	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, FALSE ) 
	
	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
		
		// [VDOC26276]
		This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic ) 
		
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
	End If

	If iRet = -1 Then Exit
Next

Return iRet 

end function

private function integer uf_flaguer_commandes_carma (ref long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Flaguer_Commandes_Carma (PRIVATE)
//* Auteur			: FPI
//* Date				: 28/03/2018
//* Libellé			: On marque en bases les commandes chargées commé étant générées
//*					  elle ne pouraient être par la suite que regénérées avant la fonction adéquat.
//*
//* Commentaires	: [DT339] Utilisé pour Carma
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*       JFF   11/04/2019   Correction BUG FPI du 28/03/2018, c'est lIdLotCmde et pas ilIdLotFNC
//*-----------------------------------------------------------------

Int iRet 
Long	lTot, lCpt, lIdLotCmde
DateTime	dtNow
String sVal

iRet = 1
dtNow = DateTime ( Today (), Now () )


/*------------------------------------------------------------------*/
/* Récupération d'un n° de lot de commandes.                        */
/*------------------------------------------------------------------*/
lIdLotCmde = -1
SQLCA.PS_S03_COMMANDE ( "ID_LOT_CMD", lIdLotCmde )

If lIdLotCmde <= 0 Or IsNull ( lIdLotCmde ) Then

	// RollBack immédiat.
	F_Commit ( SQLCA, False )
	iRet = -1
	This.Uf_Trace ( "ECR", "ERREUR lors de la récupération de l'ID_LOT_CMD, " + String ( lIdLotCmde ) )
Else
	This.Uf_Trace ( "ECR", "Attribution du n° de lot de commandes : " + String ( lIdLotCmde ) )
End If


// [ITSM178659]
F_COMMIT ( SQLCA, SQLCA.SQLCODE = 0 Or SQLCA.SQLDBCODE = 0  ) 

/*------------------------------------------------------------------*/
/* Attribution du n° de lot à toutes les lignes chargées.           */
/*------------------------------------------------------------------*/
If iRet > 0 Then
	lTot = idwFicCharg.RowCount ()
	For lCpt = 1 To lTot
		sVal=idwFicCharg.GetItemString(lCpt, "INFO_SPB_FRN_CPLT")
		
		if Pos(sVal,"GESTION_ENVOI_BA=SPB") <= 0 Then // On exclue les commandes générées par ETL
			idwFicCharg.SetItem ( lCpt, "ID_LOT_CMD", lIdLotCmde )
			idwFicCharg.SetItem ( lCpt, "CMD_GEN_LE", dtNow )
			idwFicCharg.SetItem ( lCpt, "CMD_GEN_PAR", stGlb.sCodOper )
		End if
		
	Next

	/*------------------------------------------------------------------*/
	/* Update en base.                                                  */
	/* Les lignes vont être marquées en bases.								  */
	/*------------------------------------------------------------------*/
	If idwFicCharg.Update () > 0 Then
		F_Commit ( SQLCA, True )
		This.Uf_Trace ( "ECR", "Update du marquage réussi, les commandes sont flaguées en base." )
		alidlotcmd=lIdLotCmde
	Else
		iRet = -1
		F_Commit ( SQLCA, False )
		This.Uf_Trace ( "ECR", "ERREUR, Update du marquage en base a échoué." )
		alidlotcmd=-1
	End if
End If


Return iRet

end function

public subroutine uf_maj_nom_fichier_ds_presta (string asnomficentier);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Maj_Nom_Fichier_Ds_Presta (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 21/06/2018
//* Libellé			: Mise à jour du nom de fichier dans la basesur la prestation concernée
//* Commentaires	: [VDOC26276]
//*
//* Arguments		: asNomFic		String		(Ref)
//*					  alCas			Long			(Val)	:	distingue le cas du produit 5712 pour les prestations (cf MAJ ci-dessous)
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//*
//*-----------------------------------------------------------------

String sNomFic, sSql, sSqlOrig, sVal
Long   lVal, lIdSin, lIdSeq, lTot, lCpt 
Int	 iErr 

iErr = 0

sSqlOrig = "EXEC sysadm.PS_U_MAJ_NOM_FICHIER_DS_PRESTA "

sSql = sSqlOrig 

asNomFicEntier = TRIM ( asNomFicEntier )
sNomFic = Reverse ( asNomFicEntier )
lVal = Pos ( sNomFic, "\" ) 
sNomFic = Left ( sNomFic, lVal - 1 )
sNomFic = Reverse ( sNomFic )

This.uf_Trace ( "ECR", "Marquage du nom de fichier " + sNomFic + " sur les prestations en base, en cours...")

lTot = idwFicCharg.RowCount ()			
For lCpt = 1 To lTot
	lIdSin = idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" ) 
	lIdSeq = idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" )
	
	sSql = sSqlOrig  
	
	sSql += String ( lIdSin ) + "., "
	sSql += String ( lIdSeq ) + ", "
	sSql += "'" + sNomFic + "'"

	If F_Execute ( sSql, SQLCA ) Then 
		If SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0 Then
			F_commit ( SQLCA, True )
		Else 
			iErr = 1
			sVal = SQLCA.SQLErrText
			sVal = f_remplace(sVal,Char(9)," ")
			sVal = f_remplace(sVal,Char(10)," ")		
			sVal = f_remplace(sVal,Char(11)," ")				
			sVal = f_remplace(sVal,Char(13)," ")				

			This.uf_Trace ( "ECR", "ERREUR ligne " + string ( lCpt ) + " : Problème d'Update du nom de fichier sur " + string ( lIdSin ) + "-" + String ( lIdSeq ) + ", msg SqlServer : " + sVal )

			F_commit ( SQLCA, False )
				
			Continue
		End If
	Else
		iErr = 1		
		sVal = SQLCA.SQLErrText		
		sVal = f_remplace(sVal,Char(9)," ")
		sVal = f_remplace(sVal,Char(10)," ")		
		sVal = f_remplace(sVal,Char(11)," ")				
		sVal = f_remplace(sVal,Char(13)," ")	

		This.uf_Trace ( "ECR", "ERREUR ligne " + string ( lCpt ) + " : Problème d'Update du nom de fichier sur " + string ( lIdSin ) + "-" + String ( lIdSeq ) + ", msg SqlServer : " + sVal )

		F_commit ( SQLCA, False )
			
		Continue
	End If

Next 

If iErr = 1 Then
	This.uf_Trace ( "ECR", "Marquage du nom de fichier " + sNomFic + " sur les prestations en base, terminé avec des erreurs.")	
Else 
	This.uf_Trace ( "ECR", "Marquage du nom de fichier " + sNomFic + " sur les prestations en base, terminé avec succès.")	
End If 

end subroutine

private function integer uf_generer_fichier_ceat (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_CEAT (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/09/2018
//* Libellé			: Génération du fichier de commande pour CORDON
//* Commentaires	: [DT361]
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	PHG	31/03/2008 	[DCMP080162] AJout Valeur Publique d'achat et Date Achat
//* #2	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
//* #3   JFF   20/10/2008  [FNAC_PROD_ECH_TECH].[20090127140540720]
//* #4   JFF   20/10/2008  [FNAC_PROD_ECH_TECH].[20090225143455120]
//* #7	FPI	20/03/2009	[DCMP090109] SBE devient réparateur d'IPhone
//* #8   JFF   27/03/2009  [DCMP090152] Civ long pour SBE
//*  	   JFF	13/04/2010  [ADRESSE_SBE]
//			FPI	10/08/2010	[PM01] Process 4
//* 		JFF   03/05/2011  [PM166][SBE]
//*      JFF   12/12/2011  [VDOC4970]
//*      JFF   04/10/2012  [BLCODE]
//*      JFF   12/12/2011  [VDOC9043]
//       JFF   07/05/2013  [PC938_ORANGE_V3]
//       JFF   09/09/2013  [PM222-1]
//       JFF   13/01/2014  [PM246]
//       JFF   28/03/2014  [DT081_EVOL_PRET_BRIS]
//       JFF   04/11/2014  [PM280-1]
//       JFF   16/03/2015  [DT081-3]
//       JFF   12/05/2015  [DT141][MANTIS14455]
//       JFF   17/08/2017  [BUG_MAIL_CORDON]
// 		JFF   21/06/2018  [VDOC26276]
//       JFF   03/09/2018  [DT361]
//*-----------------------------------------------------------------
Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sIdRefFour, sTypArt2, sInfoSpbFrnCplt
String sNomLigne1, sNomLigne2, sAdrLigne1, sAdrLigne2, sCP, sVille, sValCar, sVal, sInfoSpbFrn
n_cst_cmd_commun	lnvCmdCommun
Long lIdProd,  lDeb,lFin, lCptKey
n_cst_attrib_key	lnv_Key[]
n_cst_string lnvString
String sIMEICorr, sInfoFrnSpbCplt

iRet = 1
/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour SBE 								  */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_CEAT"

/*------------------------------------------------------------------*/
/* Génération du fichier de COMMANDES (CMD)                         */
/*------------------------------------------------------------------*/
//* #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
// sFiltre = "ID_TYP_ART = 'EDI' AND COD_ETAT <> 'ANN'"
sFiltre = "COD_ETAT <> 'ANN'"

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de PRESTATIONS (PRS)                       */
		/*------------------------------------------------------------------*/
		// [PM82][LOT1] Simplification
		// [MANTIS3743]
		CASE 1
			sFiltre = "ID_FOUR= 'CEA'"
			sNomFic = K_FIC2 // "PRS"
			sTypArt = "Ordre CEAT"
			sTypArtNul = "Ordre CEAT"
			This.Uf_Trace ( "ECR", "Génération du fichier de PRESTATION CEAT en cours..." )

	End Choose

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()
	
	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
	
	For lCpt = 1 To lTot
		lRow = idwFicGenCmde.InsertRow ( 0 )
	
	//* #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
	
		sTypArt2 = idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" ) 
	
		// #7 [DCMP090109]
		sAction = idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" )
	
		// [VDOC4970]
		sInfoSpbFrn = String ( idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) )
		sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))
		sInfoFrnSpbCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_FRN_SPB_CPLT" ) ))			
	
		// [PM166][SBE]
		Choose Case sTypArt2
			Case "EDI", "PRS"
	
				// ON laisse tel quel
	
				// [PM82][LOT2]
				sVal = ""
				If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
					sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_REPARER_SAV", ";")
					If sVal = "OUI" Then
						sAction = "A_REPARER_SAV"
					End If
				End If
				// [PM82][LOT2]
				
				// [PM222-1]
				sVal = ""
				If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
					sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_CONTROLER_SAV", ";")
					If sVal = "OUI" Then
						sAction = "A_CONTROLER_SAV" 
					End If
				End If
				// [PM222-1]			
				
				// [PM280-1]
				sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "A_REP_GARANTIE", ";")
				If sVal = "OUI" Then
					sAction = "A_REP_GARANTIE"
				End If
				
				// [PM287-3]
				sVal = lnvString.of_Getkeyvalue ( sInfoFrnSpbCplt, "IFDNMQ_ACT", ";")
				If sVal = "FAIT" Then
					sAction = "IFDNMQ_FAIT"
				End If
	

			Case Else			
				sAction = "A_COMMANDER"
		End Choose
		
		Choose Case sTypArt2 
			Case "EDI", "PRS", "PCM", "CAF"
				sTypArt2 = idwFicCharg.GetItemString ( lCpt, "TYP_APP_SIN" )
				
			Case Else
				// On laisse tel quel
		End Choose
	//* :#6 [FNAC_PROD_ECH_TECH].[20090127140540720]
	
	// [PM246]
	sVal = ""
	If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
		sVal = lnvString.of_Getkeyvalue ( sInfoSpbFrnCplt , "MAJ_ADRESSE", ";")
		If sVal = "OUI" Then
			sAction = "MAJ_ADRESSE"
		End If
	End If		
	// [PM246]	

// lignes fin
		
		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_POLICE",		idwFicCharg.GetItemString ( lCpt, "LIB_POLICE" ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "CODE_PROD", 		String (idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) )
		idwFicGenCmde.SetItem ( lRow, "PRENOM_CLI",		idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_1",				idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_2",				idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CPL",			idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			

		// [BUG_MAIL_CORDON]
		sVal = Trim ( idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ))
		If sVal = "" Or IsNull ( sVal) Then
			sVal = Trim ( lnvString.of_getkeyvalue (sInfoSpbFrnCplt, "MAIL_ASSURE", ";"))
			If sVal = "" Or IsNull ( sVal) Then sVal = ""
		End If
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			sVal  )									
		
		idwFicGenCmde.SetItem ( lRow, "TYP_ART",			sTypArt2 )			
		idwFicGenCmde.SetItem ( lRow, "PROBLEME",			idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) )
		
		sVal = idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" )
		If F_IMEI ( sVal, sIMEICorr ) Then
			idwFicGenCmde.SetItem ( lRow, "NUM_IMEI",	sVal )
		Else
			idwFicGenCmde.SetItem ( lRow, "NUM_SERIE", sVal )
		End If 		
		
		idwFicGenCmde.SetItem ( lRow, "MARQ_APP",			idwFicCharg.GetItemString ( lCpt, "MARQ_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_APP",			idwFicCharg.GetItemString ( lCpt, "MODL_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "MAJ_PAR" ) )						
		idwFicGenCmde.SetItem ( lRow, "ACTION", sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "GARANTIE",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN",	sInfoSpbFrn  )		// [VDOC4970]

		idwFicGenCmde.SetItem ( lRow, "ASSUREUR",			idwFicCharg.GetItemString ( lCpt, "ASSUREUR" ) )
		// [DCMP080162] AJout Valeur Publique d'achat et Date Achat ( note : date stockée sous forme de chaine )
		idwFicGenCmde.SetItem ( lRow, "MT_VAL_ACHAT",	idwFicCharg.GetItemString ( lCpt, "MT_VAL_ACHAT" ))
		idwFicGenCmde.SetItem ( lRow, "DTE_ACHAT",		idwFicCharg.GetItemString ( lCpt, "DTE_ACHAT" ) )
		idwFicGenCmde.SetItem ( lRow, "MT_PEC",			idwFicCharg.GetItemString ( lCpt, "MT_PEC" ) )
	
		
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	sInfoSpbFrnCplt  )
		//* :#2 [FNAC_PROD_ECH_TECH]
	
	Next
	
	lTot = idwFicGenCmde.RowCount ()
	lRow = idwFicGenCmde.InsertRow (1)
	idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD", "DEBUT#" + String ( lTot ) )
	lRow = idwFicGenCmde.InsertRow (0)
	idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD", "FIN#" + String ( lTot ) )
	
	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, FALSE ) 
	
	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
		
		// [VDOC26276]
		This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic ) 
		
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
	End If

	If iRet = -1 Then Exit
Next

Return iRet 

end function

private function integer uf_generer_fichier_agora_place (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_AGORA_PLACE (PRIVATE)
//* Auteur			: JFF
//* Date				: 17/09/2018
//* Libellé			: Génération du fichier de commande pour le fournisseur BRIGHTPOINT
//* Commentaires	: Trois fichiers seront générés dans le même répertoires :
//*					  un pour les commandes   : CMDjjmma.ind  (CMD10091.001)
//*					  un pour les prestations : PRSjjmma.ind  (PRS10091.001)
//*					  un pour les annulations : ANNjjmma.ind  (ANN10091.001)
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 17/10/2002	  Modification SFR : Pour ce produit (5712), on
//*								  crée un fichier supplémentaire pour chaque type (cmd, prs, annul ...)
//*								  et on les écrit dans un répertoire spécifique
//*								  Annexe 7 (6.7.2) dans l'intégration de SFR, analyse des traitements
//*
//* #4	 JFF	 07/04/2003   Ajout de l'ID_REF_FOUR et MT_TTC_CMDE
//* #5	 CAG	 06/05/2003	  Génération d'un fichier vide de cmde qd pas de cmdes
//        JFF   05/12/2017   [PM426-1]
// 		 JFF   03/01/2018   [VDOC25374]
// 		 JFF   21/06/2018   [VDOC26276]
//        JFF   17/12/2018   [PM444-2]
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sInfoSpbFrnCplt, sVal, sInfoSpbFrn, sActionOrig
n_cst_string lnvPFCString

iRet = 1

/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le BRIGHTPOINT               */
/*------------------------------------------------------------------*/
// [PM444-2]
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_AGORA_PLACE_PM444_2"	

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC1
			sTypArt = "commandes"
			sTypArtNul = "commande"
			sAction = "A_COMMANDER"
			sActionOrig = sAction 
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )

	End Choose

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		sInfoSpbFrn = String ( idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) )
		sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))

		sAction = sActionOrig
	
		// [PM246]
		sVal = ""
		If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
			sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "MAJ_ADRESSE", ";")
			If sVal = "OUI" Then
				sAction = "MAJ_ADRESSE"
			End If
		End If		
		// [PM246]	
	

		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )

// [PM444-2]
		idwFicGenCmde.SetItem ( lRow, "CODE_PROD", 		String (idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_POLICE",		idwFicCharg.GetItemString ( lCpt, "LIB_POLICE" ) )
		idwFicGenCmde.SetItem ( lRow, "ASSUREUR",			idwFicCharg.GetItemString ( lCpt, "ASSUREUR" ) )	
		
		idwFicGenCmde.SetItem ( lRow, "NOM_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "ADR_NOM" ) + " " + idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" ) )
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR_CPL",	idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ) )			
		idwFicGenCmde.SetItem ( lRow, "TYP_ART",			idwFicCharg.GetItemString ( lCpt, "ID_TYP_ART" ) )			
		idwFicGenCmde.SetItem ( lRow, "MARQ_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MARQ_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_PORT",		idwFicCharg.GetItemString ( lCpt, "ID_MODL_ART" ) )						
		idwFicGenCmde.SetItem ( lRow, "NOM_GEST",			idwFicCharg.GetItemString ( lCpt, "NOM_GEST" ) )						
		idwFicGenCmde.SetItem ( lRow, "ACTION",			sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "ID_GTI",			String ( idwFicCharg.GetItemNumber ( lCpt, "ID_GTI" ) ) )				
		idwFicGenCmde.SetItem ( lRow, "ID_REF_FOUR",			idwFicCharg.GetItemString ( lCpt, "ID_REF_FOUR" ) ) 				
		idwFicGenCmde.SetItem ( lRow, "MT_TTC_CMDE",			String ( idwFicCharg.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) ) )				


		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN",	sInfoSpbFrn )						
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	sInfoSpbFrnCplt  )

	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, False )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
		
		// [VDOC26276]
		This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic ) 
		
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_orangeopenpro (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_OrangeOpenPro (PRIVATE)
//* Auteur			: JFF
//* Date				: 05/09/2019
//* Libellé			: Génération du fichier de commande pour le fournisseur OrangeOpenPro
//* Commentaires	: 
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sInfoSpbFrnCplt, sVal, sInfoSpbFrn
n_cst_string lnvPFCString

iRet = 1

/*------------------------------------------------------------------*/
/* Format du fichier de commandes 											  */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_OrangeOpenPro"	


For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART = 'EDI' AND ID_REF_FOUR = 'CONTEST_IMEI' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC17
			sTypArt = "contestations IMEI"
			sTypArtNul = "contestation IMEI"
			sAction = "A_CONTROLER_IMEI"
			This.Uf_Trace ( "ECR", "Génération du fichier des contestation IMEI en cours..." )

	End Choose

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "CODE_PROD", 		idwFicCharg.GetItemString ( lCpt, "ID_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "NOM_ASS" ) )
		idwFicGenCmde.SetItem ( lRow, "PRENOM_CLI",		idwFicCharg.GetItemString ( lCpt, "PRENOM_ASS" ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_TEL",			idwFicCharg.GetItemString ( lCpt, "NUM_PORT" ) )	
		idwFicGenCmde.SetItem ( lRow, "NUM_IMEI",			idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" ) )		
		idwFicGenCmde.SetItem ( lRow, "DTE_SURV",			String ( idwFicCharg.GetItemDateTime ( lCpt, "DTE_SURV" ), "dd/mm/yyyy" ) )		
		idwFicGenCmde.SetItem ( lRow, "ACTION",			sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))  )

	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, False )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
		
		// [VDOC26276]
		This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic ) 
		
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_orangegrandpublic (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_OrangeGrandPublic (PRIVATE)
//* Auteur			: JFF
//* Date				: 05/09/2019
//* Libellé			: Génération du fichier de commande pour le fournisseur OrangeOpenPro
//* Commentaires	: 
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sInfoSpbFrnCplt, sVal, sInfoSpbFrn
n_cst_string lnvPFCString

iRet = 1

/*------------------------------------------------------------------*/
/* Format du fichier de commandes 											  */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_OrangeGrandPublic"	


For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART = 'EDI' AND ID_REF_FOUR = 'CONTEST_IMEI' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC17
			sTypArt = "contestations IMEI"
			sTypArtNul = "contestation IMEI"
			sAction = "A_CONTROLER_IMEI"
			This.Uf_Trace ( "ECR", "Génération du fichier des contestation IMEI en cours..." )

	End Choose

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "CODE_PROD", 		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_PROD", 		idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "NOM_CLI",			idwFicCharg.GetItemString ( lCpt, "NOM_ASS" ) )
		idwFicGenCmde.SetItem ( lRow, "PRENOM_CLI",		idwFicCharg.GetItemString ( lCpt, "PRENOM_ASS" ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_TEL",			idwFicCharg.GetItemString ( lCpt, "NUM_PORT" ) )	
		idwFicGenCmde.SetItem ( lRow, "NUM_IMEI",			idwFicCharg.GetItemString ( lCpt, "ID_SERIE_ANC" ) )		
		idwFicGenCmde.SetItem ( lRow, "DTE_SURV",			String ( idwFicCharg.GetItemDateTime ( lCpt, "DTE_SURV" ), "dd/mm/yyyy" ) )		
		idwFicGenCmde.SetItem ( lRow, "ACTION",			sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))  )

	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, False )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
		
		// [VDOC26276]
		This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic ) 
		
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private subroutine uf_charger_standard ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Charger_Standard (PRIVATE)
//* Auteur			: JFF
//* Date				: 27/09/2019
//* Libellé			: Modif après chargement des commandes pour tout fourn standard
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Pas d'espace pour les numéros de téléphone.                      */
/* Seulement dans la gêne du fichier, on laisse les espaces en base */
/*------------------------------------------------------------------*/
Long 	lTot, lCpt, lCptCas, lLen, lCptLen
String sVal

lTot = idwFicCharg.RowCount ()

For lCpt = 1 To lTot

	For lCptCas = 1 To 3
		sVal = idwFicCharg.GetItemString ( lCpt, "ADR_TEL" + String ( lCptCas )  )
		lLen = Len ( sVal )
		For lCptLen = lLen To 1 Step -1
			If Mid ( sVal, lCptLen, 1 ) = " " Then 
				sVal = Replace ( sVal, lCptLen, 1, "" )
			End If
		Next
		/*------------------------------------------------------------------*/
		/* #2                                                               */
		/*------------------------------------------------------------------*/
		uf_FormatChaine ( sVal, 1 )
		idwFicCharg.SetItem ( lCpt, "ADR_TEL" + String ( lCptCas ), sVal  )
 
	Next

	/*------------------------------------------------------------------*/
	/* #1                                                               */
	/*------------------------------------------------------------------*/
	sVal = idwFicCharg.GetItemString ( lCpt, "PROBLEME" )
	uf_FormatChaine ( sVal, 1 )
	idwFicCharg.SetItem ( lCpt, "PROBLEME", sVal  )

	/*------------------------------------------------------------------*/
	/* #2                                                               */
	/*------------------------------------------------------------------*/
	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_NOM" )
	uf_FormatChaine ( sVal, 1 )
	idwFicCharg.SetItem ( lCpt, "ADR_NOM", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_PRENOM" )
	uf_FormatChaine ( sVal, 1 )
	idwFicCharg.SetItem ( lCpt, "ADR_PRENOM", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" )
	uf_FormatChaine ( sVal, 1 )
	idwFicCharg.SetItem ( lCpt, "ADR_LIVR1", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" )
	uf_FormatChaine ( sVal, 1 )
	idwFicCharg.SetItem ( lCpt, "ADR_LIVR2", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" )
	uf_FormatChaine ( sVal, 1 )
	idwFicCharg.SetItem ( lCpt, "ADR_LIVR_CPL", sVal  )

	sVal = idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" )
	uf_FormatChaine ( sVal, 1 )
	idwFicCharg.SetItem ( lCpt, "ADR_VILLE", sVal  )

Next

end subroutine

public subroutine uf_maj_nom_spb_frn_cplt (string ascle, string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Maj_Nom_Spb_Frn_Cplt (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 20/06/2022
//* Libellé			: Mise à jour du nom de fichier dans la basesur la prestation concernée
//* Commentaires	: 
//*
//* Arguments		: 
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//*
//*-----------------------------------------------------------------

String sNomFic, sSql, sSqlOrig, sVal, sNumCmdSpb
Long   lVal, lIdSin, lIdSeq, lTot, lCpt, lPos 
Int	 iErr 

iErr = 0

sSqlOrig = "EXEC sysadm.PS_U_MAJ_SPB_FRN_CPLT "

sSql = sSqlOrig 

This.uf_Trace ( "ECR", "Marquage dans la clé " + asCle + " de la valeur " + asVal + " sur les prestations en base, en cours...")

lTot = idwFicGenCmde.RowCount ()			
For lCpt = 1 To lTot
	sNumCmdSpb = idwFicGenCmde.GetItemString  ( lCpt, "NUM_CMD_SPB" ) 
	
	lPos = Pos ( sNumCmdSpb, "-", 1 )
	lIdSin = Long ( Left ( sNumCmdSpb, lPos - 1 ) ) // #2
	lIdSeq = Long ( Right ( sNumCmdSpb, Len ( sNumCmdSpb ) - lPos ) ) // #2
	
	sSql = sSqlOrig  
	
	sSql += String ( lIdSin ) + "., "
	sSql += String ( lIdSeq ) + ", "
	sSql += "'" + asCle + "', "
	sSql += "'" + asVal + "'"

	If F_Execute ( sSql, SQLCA ) Then 
		If SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0 Then
			F_commit ( SQLCA, True )
		Else 
			iErr = 1
			sVal = SQLCA.SQLErrText
			sVal = f_remplace(sVal,Char(9)," ")
			sVal = f_remplace(sVal,Char(10)," ")		
			sVal = f_remplace(sVal,Char(11)," ")				
			sVal = f_remplace(sVal,Char(13)," ")				

			This.uf_Trace ( "ECR", "ERREUR ligne " + string ( lCpt ) + " : Problème d'Update du nom de fichier sur " + string ( lIdSin ) + "-" + String ( lIdSeq ) + ", msg SqlServer : " + sVal )

			F_commit ( SQLCA, False )
				
			Continue
		End If
	Else
		iErr = 1		
		sVal = SQLCA.SQLErrText		
		sVal = f_remplace(sVal,Char(9)," ")
		sVal = f_remplace(sVal,Char(10)," ")		
		sVal = f_remplace(sVal,Char(11)," ")				
		sVal = f_remplace(sVal,Char(13)," ")	

		This.uf_Trace ( "ECR", "ERREUR ligne " + string ( lCpt ) + " : Problème d'Update du nom de fichier sur " + string ( lIdSin ) + "-" + String ( lIdSeq ) + ", msg SqlServer : " + sVal )

		F_commit ( SQLCA, False )
			
		Continue
	End If

Next 

If iErr = 1 Then
	This.uf_Trace ( "ECR", "Marquage dans la clé " + asCle + " de la valeur " + asVal + " sur les prestations en base, terminé avec des erreurs.")	
Else 
	This.uf_Trace ( "ECR", "Marquage dans la clé " + asCle + " de la valeur " + asVal + " sur les prestations en base, terminé avec succès.")	
End If 

end subroutine

private function integer uf_generer_fichier_telstore (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_TELSTORE (PRIVATE)
//* Auteur			: JFF
//* Date				: 16/08/2022
//* Libellé			: Génération du fichier de commande pour le fournisseur TELSTORE
//* Commentaires	: Trois fichiers seront générés dans le même répertoires :
//*					  un pour les commandes   : CMDjjmma.ind  (CMD10091.001)
//*					  un pour les prestations : PRSjjmma.ind  (PRS10091.001)
//*					  un pour les annulations : ANNjjmma.ind  (ANN10091.001)
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 17/10/2002	  Modification SFR : Pour ce produit (5712), on
//*								  crée un fichier supplémentaire pour chaque type (cmd, prs, annul ...)
//*								  et on les écrit dans un répertoire spécifique
//*								  Annexe 7 (6.7.2) dans l'intégration de SFR, analyse des traitements
//*
//* #4	 JFF	 07/04/2003   Ajout de l'ID_REF_FOUR et MT_TTC_CMDE
//* #5	 CAG	 06/05/2003	  Génération d'un fichier vide de cmde qd pas de cmdes
//        JFF   05/12/2017   [PM426-1]
// 		 JFF   03/01/2018   [VDOC25374]
// 		 JFF   21/06/2018   [VDOC26276]
//        JFF   17/12/2018   [PM444-2]
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sInfoSpbFrnCplt, sVal, sInfoSpbFrn, sActionOrig 
n_cst_string lnvPFCString

iRet = 1

/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le BRIGHTPOINT               */
/*------------------------------------------------------------------*/
// [PM444-2]
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_TELSTORE"	

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC1
			sTypArt = "commandes"
			sTypArtNul = "commande"
			sAction = "A_COMMANDER"
			sActionOrig = sAction 
			This.Uf_Trace ( "ECR", "Génération du fichier de COMMANDES en cours..." )

	End Choose

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		sInfoSpbFrn = String ( idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) )
		sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))
	
		sAction = sActionOrig
	
		// [PM246]
		sVal = ""
		If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
			sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "MAJ_ADRESSE", ";")
			If sVal = "OUI" Then
				sAction = "MAJ_ADRESSE"
			End If
		End If		
		// [PM246]	
	

		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )

// [PM444-2]
		idwFicGenCmde.SetItem ( lRow, "CODE_PROD", 		String (idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_PROD",		   idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_POLICE",		idwFicCharg.GetItemString ( lCpt, "LIB_POLICE" ) )
		idwFicGenCmde.SetItem ( lRow, "ASSUREUR",			idwFicCharg.GetItemString ( lCpt, "ASSUREUR" ) )	

		idwFicGenCmde.SetItem ( lRow, "NOM_ASS",			idwFicCharg.GetItemString ( lCpt, "NOM_ASS" ) )	
		idwFicGenCmde.SetItem ( lRow, "PRENOM_ASS",		idwFicCharg.GetItemString ( lCpt, "PRENOM_ASS" ) )			
		
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR_CPL",	idwFicCharg.GetItemString ( lCpt, "ADR_LIVR_CPL" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL2",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL3",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL3" ) )			
		idwFicGenCmde.SetItem ( lRow, "ADR_MAIL",			idwFicCharg.GetItemString ( lCpt, "ADR_MAIL" ) )			
		idwFicGenCmde.SetItem ( lRow, "TYP_ART",			idwFicCharg.GetItemString ( lCpt, "TYP_APP_SIN" ) )			
		idwFicGenCmde.SetItem ( lRow, "INFORMATION",		idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) )			
		idwFicGenCmde.SetItem ( lRow, "MARQ_PORT",		idwFicCharg.GetItemString ( lCpt, "MARQ_APP" ) )						
		idwFicGenCmde.SetItem ( lRow, "MODL_PORT",		idwFicCharg.GetItemString ( lCpt, "MODL_APP" ) )						

		idwFicGenCmde.SetItem ( lRow, "MT_PEC",			idwFicCharg.GetItemString ( lCpt, "MT_PEC" ) )						
		
		idwFicGenCmde.SetItem ( lRow, "ACTION",			sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN",	sInfoSpbFrn )						

		sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt, "CODE_PICK_UP", ";")
		If IsNull ( sVal ) Then sVal = ""
		idwFicGenCmde.SetItem ( lRow, "CODE_PICK_UP",	sVal  )

		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	sInfoSpbFrnCplt  )

	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, True )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
		
		// [VDOC26276]
		This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic ) 
		
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_cardif (long alidlotcmd);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_CARDIF (PRIVATE)
//* Auteur			: JFF
//* Date				: 07/06/2023
//* Libellé			: Génération du fichier de commande pour le fournisseur CARDIF
//* Commentaires	[PMO89_RS4822]
//*
//* Arguments		: alIdLotCmd	Long	Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sInfoSpbFrnCplt, sVal, sInfoSpbFrn, sActionOrig, sVal1 
n_cst_string lnvPFCString

iRet = 1

/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le BRIGHTPOINT               */
/*------------------------------------------------------------------*/
// [PM444-2]
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_CARDIF"	

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"
			sNomFic = K_FIC1
			sTypArt = "demandes de contrôle"
			sTypArtNul = "demande de contrôle"
			sAction = "A_CONTROLER"
			sActionOrig = sAction 
			This.Uf_Trace ( "ECR", "Génération du fichier de DEMANDE DE CONTRÔLE en cours..." )

	End Choose

	idwFicCharg.SetFilter ( sFiltre )
	idwFicCharg.Filter ()
	idwFicCharg.Sort ()
	lTot = idwFicCharg.RowCount ()			
	idwFicGenCmde.Reset ()

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
		/*------------------------------------------------------------------*/
		/* #5	CAG : 06/05/2003 : on ne génère pas de fichier vide pour les  */
		/*								 annulations ni prestations					  */
		/*------------------------------------------------------------------*/
		If lCptCas <> 1 Then
			Continue
		End If
	End If

	For lCpt = 1 To lTot

		sInfoSpbFrn = String ( idwFicCharg.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) )
		sInfoSpbFrnCplt = Trim ( Upper ( idwFicCharg.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) ))
	
		sAction = sActionOrig
	
		// [PM246]
		sVal = ""
		If Not IsNull( sInfoSpbFrnCplt  ) and Trim ( sInfoSpbFrnCplt ) <> "" Then 
			sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt , "MAJ_ADRESSE", ";")
			If sVal = "OUI" Then
				sAction = "MAJ_ADRESSE"
			End If
		End If		
		// [PM246]	
	
		lRow = idwFicGenCmde.InsertRow ( 0 )

		idwFicGenCmde.SetItem ( lRow, "NUM_LOT_CMD",		String ( alIdLotCmd ) )
		idwFicGenCmde.SetItem ( lRow, "NUM_CMD_SPB",		String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SIN" )) + "-" + String ( idwFicCharg.GetItemNumber ( lCpt, "ID_SEQ" ) ) )
		idwFicGenCmde.SetItem ( lRow, "FOURNISSEUR", 	idwFicCharg.GetItemString ( lCpt, "ID_FOUR" ) )
		idwFicGenCmde.SetItem ( lRow, "CODE_PROD", 		String (idwFicCharg.GetItemNumber ( lCpt, "ID_PROD" ) ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_PROD",		   idwFicCharg.GetItemString ( lCpt, "LIB_PROD" ) )
		idwFicGenCmde.SetItem ( lRow, "LIB_POLICE",		idwFicCharg.GetItemString ( lCpt, "LIB_POLICE" ) )
		idwFicGenCmde.SetItem ( lRow, "ASSUREUR",			idwFicCharg.GetItemString ( lCpt, "ASSUREUR" ) )	

		sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt, "ID_INTER", ";")
		If IsNull ( sVal ) Then sVal = ""
		idwFicGenCmde.SetItem ( lRow, "ID_INTER",	sVal  )

		sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt, "LIB_CIV", ";")
		If IsNull ( sVal ) Then sVal = ""
		idwFicGenCmde.SetItem ( lRow, "LIB_CIV",	sVal  )
		
		sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt, "NOM", ";")
		If IsNull ( sVal ) Then sVal = ""
		idwFicGenCmde.SetItem ( lRow, "NOM_ASS",	sVal  )
		
		sVal1 = SQLCA.FN_GET_NOM_PRENOM ( sVal , "N" ) 
		If IsNull ( sVal1 ) Then sVal1 = ""
		idwFicGenCmde.SetItem ( lRow, "NOM",	sVal1 )

		sVal1 = SQLCA.FN_GET_NOM_PRENOM ( sVal , "P" ) 
		If IsNull ( sVal1 ) Then sVal1 = ""
		idwFicGenCmde.SetItem ( lRow, "PRENOM",	sVal1  )
		
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR1",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR1" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_LIVR2",		idwFicCharg.GetItemString ( lCpt, "ADR_LIVR2" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_CP",			idwFicCharg.GetItemString ( lCpt, "ADR_CP" ) )	
		idwFicGenCmde.SetItem ( lRow, "ADR_VILLE",		idwFicCharg.GetItemString ( lCpt, "ADR_VILLE" ) )		
		idwFicGenCmde.SetItem ( lRow, "ADR_TEL1",			idwFicCharg.GetItemString ( lCpt, "ADR_TEL1" ) )		

		sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt, "DTE_NAISS", ";")
		If IsNull ( sVal ) Then sVal = ""
		idwFicGenCmde.SetItem ( lRow, "DTE_NAISS",	sVal  )

		sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt, "VILLE_NAISS", ";")
		If IsNull ( sVal ) Then sVal = ""
		idwFicGenCmde.SetItem ( lRow, "VILLE_NAISS",	sVal  )		
		
		sVal = lnvPFCString.of_Getkeyvalue ( sInfoSpbFrnCplt, "PAYS_NAISS", ";")
		If IsNull ( sVal ) Then sVal = ""
		idwFicGenCmde.SetItem ( lRow, "PAYS_NAISS",	sVal  )		
		
		
		idwFicGenCmde.SetItem ( lRow, "INFORMATION",		idwFicCharg.GetItemString ( lCpt, "PROBLEME" ) )			
		idwFicGenCmde.SetItem ( lRow, "ACTION",			sAction )
		idwFicGenCmde.SetItem ( lRow, "CMD_GEN_LE",		String ( idwFicCharg.GetItemDateTime ( lCpt, "CMD_GEN_LE" ), "dd/mm/yyyy hh:mm:ss" ) )
		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN",	sInfoSpbFrn )						

		idwFicGenCmde.SetItem ( lRow, "INFO_SPB_FRN_CPLT",	sInfoSpbFrnCplt  )

	Next

	This.uf_nom_fichier ( sNomFic, lCptProd )
	iRet = idwFicGenCmde.SaveAs ( sNomFic, Text!, True )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
		
		// [VDOC26276]
		This.uf_Maj_Nom_Fichier_Ds_Presta ( sNomFic ) 
		
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

private function integer uf_generer_fichier_ifr ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gen_fic_commande::uf_Generer_Fichier_IFR (PRIVATE)
//* Auteur			: JFF
//* Date				: 12/06/2023
//* Libellé			: Génération du fichier IFR
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int	iRet
Long	lTot, lCpt, lCptCas, lRow, lCptProd
String	sNomFic, sTypArt, sAction, sFiltre, sTypArtNul, sInfoSpbFrnCplt, sVal, sInfoSpbFrn, sActionOrig 
n_cst_string lnvPFCString

iRet = 1

/*------------------------------------------------------------------*/
/* Format du fichier de commandes pour le BRIGHTPOINT               */
/*------------------------------------------------------------------*/
idwFicGenCmde.DataObject = "d_trt_fichier_cmde_IFR_1"	

For lCptCas = 1 To 1
	
	CHOOSE CASE lCptCas

		/*------------------------------------------------------------------*/
		/* Génération du fichier de COMMANDES (CMD)                         */
		/*------------------------------------------------------------------*/
		CASE 1
			sNomFic = K_FIC18
			sTypArt = "références IFR"
			sTypArtNul = "référence IFR"
			This.Uf_Trace ( "ECR", "Génération du fichier référentiel IFR en cours..." )

	End Choose

	lTot = idwFicCharg.RowCount ()			

	/*------------------------------------------------------------------*/
	/* On ne génère pas de fichier si pas de commandes ou pas de        */
	/* prestations.                                                     */
	/*------------------------------------------------------------------*/
	If lTot = 0 Then
		This.Uf_Trace ( "ECR", "Aucune " + sTypArtNul + " à générer" )
	End If

	This.uf_nom_fichier ( sNomFic, lCptProd )
	
	sNomFic = F_REMPLACE ( sNomFic, "FIC_CMD\", "" ) 
	
	iRet = idwFicCharg.SaveAs ( sNomFic, Text!, True )

	If iRet > 0 Then
		This.Uf_Trace ( "ECR", "Fichier des " + sTypArt + " généré avec succès sur : " + Upper ( sNomFic )  )
	Else
		iRet = -1
		This.Uf_Trace ( "ECR", "ERREUR dans la génération du fichier des " + sTypArt + " : le fichier n'est pas généré !!" )
		Exit
	End If

	If iRet = -1 Then Exit

Next

Return iRet 
end function

on n_cst_gen_fic_commande.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_gen_fic_commande.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

