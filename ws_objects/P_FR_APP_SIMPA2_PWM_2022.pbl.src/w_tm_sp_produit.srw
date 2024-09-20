$PBExportHeader$w_tm_sp_produit.srw
$PBExportComments$-} Fenêtre de traitement pour le paramétrage des produits
forward
global type w_tm_sp_produit from w_8_traitement_master
end type
type dw_pieces from u_datawindow within w_tm_sp_produit
end type
type dw_refus from u_datawindow within w_tm_sp_produit
end type
type dw_codcon from u_datawindow within w_tm_sp_produit
end type
type dw_code from u_datawindow within w_tm_sp_produit
end type
type uo_onglets from u_onglets within w_tm_sp_produit
end type
type dw_lstgrp from u_datawindow within w_tm_sp_produit
end type
type uo_bord3d from u_bord3d within w_tm_sp_produit
end type
type uo_onglets2 from u_onglets within w_tm_sp_produit
end type
type dw_lst_rev from u_datawindow_detail within w_tm_sp_produit
end type
type uo_codcon from u_ajout within w_tm_sp_produit
end type
type uo_bord3d2 from u_bord3d within w_tm_sp_produit
end type
type uo_garantie from u_ajout within w_tm_sp_produit
end type
type uo_courrier from u_ajout within w_tm_sp_produit
end type
type uo_ets from u_ajout within w_tm_sp_produit
end type
type uo_info from u_ajout within w_tm_sp_produit
end type
type uo_onglets3 from u_onglets within w_tm_sp_produit
end type
type uo_bord3d3 from u_bord3d within w_tm_sp_produit
end type
type dw_relances from u_datawindow within w_tm_sp_produit
end type
type dw_lst_grp_grpsherpa from datawindow within w_tm_sp_produit
end type
type dw_paragraphes from u_datawindow within w_tm_sp_produit
end type
type dw_det_pro from u_datawindow within w_tm_sp_produit
end type
type uo_relance_pm407_1 from u_sp_relance_pm407_1 within w_tm_sp_produit
end type
end forward

global type w_tm_sp_produit from w_8_traitement_master
integer x = 0
integer y = 0
integer width = 3598
integer height = 1768
string title = "Gestion des produits"
boolean resizable = true
event ue_entreronglet011 pbm_custom01
event ue_entreronglet021 pbm_custom02
event ue_entreronglet031 pbm_custom03
event ue_entreronglet041 pbm_custom04
event ue_entreronglet051 pbm_custom05
event ue_quitteronglet031 pbm_custom06
event ue_quitteronglet041 pbm_custom07
event ue_entreronglet061 pbm_custom08
event ue_quitteronglet051 pbm_custom09
event ue_entreronglet012 pbm_custom10
event ue_entreronglet022 pbm_custom11
event ue_entreronglet032 pbm_custom12
event ue_entreronglet042 pbm_custom13
event ue_quitteronglet012 pbm_custom14
event ue_quitteronglet022 pbm_custom15
event ue_quitteronglet032 pbm_custom16
event ue_quitteronglet042 pbm_custom17
event ue_quitteronglet021 pbm_custom18
event ue_quitteronglet023 pbm_custom19
event ue_entreronglet023 pbm_custom20
event ue_droitecriture pbm_custom21
dw_pieces dw_pieces
dw_refus dw_refus
dw_codcon dw_codcon
dw_code dw_code
uo_onglets uo_onglets
dw_lstgrp dw_lstgrp
uo_bord3d uo_bord3d
uo_onglets2 uo_onglets2
dw_lst_rev dw_lst_rev
uo_codcon uo_codcon
uo_bord3d2 uo_bord3d2
uo_garantie uo_garantie
uo_courrier uo_courrier
uo_ets uo_ets
uo_info uo_info
uo_onglets3 uo_onglets3
uo_bord3d3 uo_bord3d3
dw_relances dw_relances
dw_lst_grp_grpsherpa dw_lst_grp_grpsherpa
dw_paragraphes dw_paragraphes
dw_det_pro dw_det_pro
uo_relance_pm407_1 uo_relance_pm407_1
end type
global w_tm_sp_produit w_tm_sp_produit

type variables

u_sp_gs_produit		iuoGsProduit
u_sp_zn_produit		iuoZnProduit

u_sp_gs_Courrier		iuoGsCourrier

u_sp_gs_ParaInfo		iUoGsParaInfo

u_sp_gs_Code_Garantie	iuoGsCodeGarantie

u_sp_gs_Code_Condition	iuoGsCodeCondition

u_sp_gs_Ets		iuoGsEts

u_sp_gs_Rev_Prod		iuoGsRevProd

u_sp_gs_relances		iuoGsRelances

Boolean			ibOngletutilise [ 6 ]

Decimal{0}		idcIdProd
Decimal{0}		idcIdRev

Integer			iiErreurCodEts = 0

datastore		ids_paragraphe // #6

boolean ibRelancePM407_1
end variables

forward prototypes
public function string wf_controlersaisie ()
public function boolean wf_preparerinserer ()
public function boolean wf_preparermodifier ()
public function boolean wf_preparersupprimer ()
public function boolean wf_preparervalider ()
public function string wf_controlergestion ()
public function boolean wf_terminervalider ()
public function boolean wf_accepttext ()
public function boolean wf_terminersupprimer ()
public subroutine wf_sup_pieces (long adcIdGti)
public subroutine wf_sup_refus (long adcIdGti)
public subroutine wf_sup_codcon (long adcidgti)
public function boolean wf_preparerabandonner ()
public subroutine wf_initongletcondition (string asidtypcod, string astitrecible, string astitresource)
private subroutine wf_positionnerobjets ()
public function boolean wf_controler_cod_adh ()
end prototypes

on ue_entreronglet011;call w_8_traitement_master::ue_entreronglet011;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_T_sp_Produit
//* Evenement 		:	Ue_EntrerOnglet011
//* Auteur			:	N°6
//* Date				:	20/06/97 14:23:03
//* Libellé			:	Indique que l'onglet a été utilisé.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

ibOngletUtilise [ 1 ] = True

/*------------------------------------------------------------------*/
/* On déclenche un ItemFocusChanged avant toute chose.              */
/*------------------------------------------------------------------*/

If	dw_1.AcceptText () > 0 Then
	dw_1.TriggerEvent ( ItemFocusChanged! )
Else
	uo_onglets.ibStop = True
End If

end on

on ue_entreronglet021;call w_8_traitement_master::ue_entreronglet021;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_Tm_Sp_Produit
//* Evenement 		:	Ue_EntrerOnglet021
//* Auteur			:	FABRY JF
//* Date				:	10/06/99 11:23:03
//* Libellé			:	Indique que l'onglet a été utilisé.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

ibOngletUtilise [ 2 ] = True

Uo_Bord3d3.Visible		= TRUE
Uo_Bord3d3.BringToTop	= TRUE

/*----------------------------------------------------------------------------*/
/* On se repositionne automatiquement sur l'onglet garantie.                  */
/*----------------------------------------------------------------------------*/
Uo_Onglets3.Uf_ChangerOnglet ( "01" )
end on

on ue_entreronglet031;call w_8_traitement_master::ue_entreronglet031;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_T_sp_Produit
//* Evenement 		:	Ue_EntrerOnglet031
//* Auteur			:	N°6
//* Date				:	20/06/97 14:23:03
//* Libellé			:	Indique que l'onglet a été utilisé.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

ibOngletUtilise [ 3 ] = True
end on

on ue_entreronglet041;call w_8_traitement_master::ue_entreronglet041;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_T_sp_Produit
//* Evenement 		:	Ue_EntrerOnglet041
//* Auteur			:	N°6
//* Date				:	20/06/97 14:23:03
//* Libellé			:	Indique que l'onglet a été utilisé.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

SetPointer ( HourGlass! )

ibOngletUtilise [ 4 ]	= TRUE

Uo_Bord3d2.Visible		= TRUE
Uo_Bord3d2.BringToTop	= TRUE

/*----------------------------------------------------------------------------*/
/* On se repositionne automatiquement sur l'onglet garantie.                  */
/*----------------------------------------------------------------------------*/
Uo_Onglets2.Uf_ChangerOnglet ( "01" )

/*----------------------------------------------------------------------------*/
/* Permet de renseigner la colonne ID_GTI pour un bon fonctionnement du       */
/* chargement de la DW Cible par la méthode du RowsCopy. Ce retrieve est      */
/* également fait lorsque l'on entre dans la fenêtre des codes conditions de  */
/* gar. pour les évènements.                                                  */
/* On filtrera les codes en fonction du type de code à l'entrée de chaque     */
/* onglet.                                                                    */
/*----------------------------------------------------------------------------*/
Uo_CodCon.Dw_Recherche.Retrieve ( -1 )
end on

on ue_entreronglet051;call w_8_traitement_master::ue_entreronglet051;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_T_sp_Produit
//* Evenement 		:	Ue_EntrerOnglet051
//* Auteur			:	N°6
//* Date				:	20/06/97 14:23:03
//* Libellé			:	Indique que l'onglet a été utilisé.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

ibOngletUtilise [ 5 ] = True

Uo_Ets.SetRedraw ( False )

/*------------------------------------------------------------------*/
/* Positionne les filtres sur Dw_ProdEts de manière à voir          */
/* seulement les établissements dont la révision est -1.            */
/*------------------------------------------------------------------*/

uo_Ets.Dw_Source.SetFilter ( "ID_REV = -1" )
uo_Ets.Dw_Source.Filter    (  )
uo_Ets.Dw_Source.Sort    	(  )

uo_Ets.SetRedraw ( True )
end on

on ue_quitteronglet041;call w_8_traitement_master::ue_quitteronglet041;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_T_sp_Produit
//* Evenement 		:	Ue_QuitterOnglet041
//* Auteur			:	N°6
//* Date				:	24/06/97 16:35:03
//* Libellé			:	Accept Text pour les garanties.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	Uo_Garantie.Dw_Source.AcceptText () < 0	Then

	Uo_Onglets.ibStop = True

Else

	Uo_Bord3d2.Visible		= FALSE
	Uo_Bord3d2.BringToTop	= FALSE

	Uo_CodCon.Visible			= FALSE
	Uo_CodCon.BringToTop		= FALSE

	Uo_Garantie.Visible		= FALSE
	Uo_Garantie.BringToTop	= FALSE

End If


end on

on ue_entreronglet061;call w_8_traitement_master::ue_entreronglet061;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_T_sp_Produit
//* Evenement 		:	Ue_EntrerOnglet061
//* Auteur			:	N°6
//* Date				:	21/07/1997 14:00:03
//* Libellé			:	Indique que l'onglet a été utilisé.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

ibOngletUtilise [ 6 ] = True
end on

on ue_quitteronglet051;call w_8_traitement_master::ue_quitteronglet051;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_T_sp_Produit
//* Evenement 		:	Ue_QuitterOnglet051
//* Auteur			:	N°6
//* Date				:	24/06/97 16:35:03
//* Libellé			:	Controles en sortie onglet Etablissement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
Long 		lLig	// Ligne ou Ets est Vide

If	Uo_Ets.Dw_Source.AcceptText () < 0	Then

	Uo_Onglets.ibStop = True
Else

	lLig	=	Uo_Ets.Dw_Source.Find ( "ISNULL ( ID_ETS )", 1, Uo_Ets.Dw_Source.RowCount ( ) )
	If lLig > 0 Then

		stMessage.sTitre	=	"Contrôle des établissements"
		stMessage.sCode	=	"REFU033"
		f_Message	 ( stMessage )
		Uo_Onglets.ibStop = True
		
	End If
End If


end on

on ue_entreronglet022;call w_8_traitement_master::ue_entreronglet022;//*-----------------------------------------------------------------
//*
//* Objet 			: w_tm_sp_produit
//* Evenement 		: Ue_EntrerOnglet022
//* Auteur			: YP
//* Date				: 07/11/1997 15:35:51
//* Libellé			: 
//* Commentaires	: Renseigne l'objet permettant d'ajouter ou de 
//*					  supprimer des naures de sinistre.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Wf_InitOngletCondition ( "+NS", 	"'Natures de sinistre non affectées'", &
											"'Natures de sinistre affectées au produit'" )


end on

on ue_entreronglet032;call w_8_traitement_master::ue_entreronglet032;//*-----------------------------------------------------------------
//*
//* Objet 			: w_tm_sp_produit
//* Evenement 		: Ue_EntrerOnglet032
//* Auteur			: YP
//* Date				: 07/11/1997 15:36:20
//* Libellé			: 
//* Commentaires	: Renseigne l'objet permettant d'ajouter ou de 
//*					  supprimer des territorialités.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Wf_InitOngletCondition ( "+TR",	"'Territorialités non affectées'", &
											"'Territorialités affectées au produit'" )


end on

on ue_entreronglet042;call w_8_traitement_master::ue_entreronglet042;//*-----------------------------------------------------------------
//*
//* Objet 			: w_tm_sp_produit
//* Evenement 		: Ue_EntrerOnglet042
//* Auteur			: YP
//* Date				: 07/11/1997 15:38:51
//* Libellé			: 
//* Commentaires	: Renseigne l'objet permettant d'ajouter ou de 
//*					  supprimer des détails de sinistre.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Wf_InitOngletCondition ( "+DT",	"'Détails de sinistre non affectés'", &
											"'Détails de sinistre affectés au produit'" )


end on

event ue_quitteronglet021;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_T_sp_Produit
//* Evenement 		:	Ue_QuitterOnglet021
//* Auteur			:	FABRY JF
//* Date				:	01/06/99 11:35:03
//* Libellé			:	Controles en sortie onglet Courrier
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*		FPI	30/01/2018	[PM407-1]				  
//*-----------------------------------------------------------------
String sPos

// [PM407-1]
if ibrelancepm407_1 Then
		If	uo_relance_pm407_1.dw_relance1.AcceptText () < 0	Then
			Uo_Onglets.ibStop = True
			uo_relance_pm407_1.dw_relance1.SetFocus ()
			return -1
		End if
			
		If	uo_relance_pm407_1.dw_relance_sup.AcceptText () < 0	Then
			Uo_Onglets.ibStop = True
			uo_relance_pm407_1.dw_relance_sup.SetFocus ()
			return -1
		End if

		If	uo_relance_pm407_1.dw_soldage.AcceptText () < 0	Then
			Uo_Onglets.ibStop = True
			uo_relance_pm407_1.dw_soldage.SetFocus ()
			return -1
		End if
End if
// :[PM407-1]

If	Dw_Relances.AcceptText () < 0	Then

	Uo_Onglets.ibStop = True
	Dw_Relances.SetFocus ()
	
Else

	Uo_Bord3d3.Visible		= FALSE
	Uo_Bord3d3.BringToTop	= FALSE

   Uo_courrier.Visible		= FALSE   
	Uo_courrier.BringToTop	= FALSE

   Dw_Relances.Visible		= FALSE
   Dw_Relances.BringToTop	= FALSE

   // [PM407-1]
   uo_relance_pm407_1.Visible		= FALSE
   uo_relance_pm407_1.BringToTop	= FALSE
	
End If
end event

on ue_quitteronglet023;call w_8_traitement_master::ue_quitteronglet023;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_T_sp_Produit
//* Evenement 		:	Ue_QuitterOnglet023
//* Auteur			:	FABRY JF
//* Date				:	01/06/99 11:35:03
//* Libellé			:	Controles en sortie onglet Relances
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Si une zone est mal renseignée, on ne quitte pas l'onglet.       */
/*------------------------------------------------------------------*/
If	Dw_Relances.AcceptText () < 0	Then

	Uo_Onglets3.ibStop = True
	Dw_Relances.SetFocus ()

End If

end on

event ue_entreronglet023;//*-----------------------------------------------------------------
//*
//* Objet 			: w_tm_sp_produit
//* Evenement 		: ue_EntrerOnglet023
//* Auteur			: Fabry JF
//* Date				: 03/06/1999 10:56:24
//* Libellé			: Entrer dnas la barre d'onglet 3, onglet n° 2
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*		FPI	30/01/2018	[PM407-1]		  				  
//*-----------------------------------------------------------------
Long lDeb, lFin

Dw_Relances.SetFocus ()
Dw_Relances.SetColumn ( Dw_Relances.ilPremCol )

// [PM407-1]
If ibrelancepm407_1 Then
	f_rechdetpro(lDeb, lFin, dw_det_pro, idcIdProd,"-DP",323)
	if lDeb > 0 Then
		uo_relance_pm407_1.Visible=TRUE
		uo_relance_pm407_1.SetFocus ()
		Dw_Relances.Visible=FALSE
	Else
		uo_relance_pm407_1.Visible=FALSE
	End if
End if
end event

on ue_droitecriture;call w_8_traitement_master::ue_droitecriture;//*-----------------------------------------------------------------
//*
//* Objet         : w_tm_sp_produit
//* Evenement     : ue_DroitEcriture
//* Auteur        : Fabry JF
//* Date          : 16/09/2003 14:17:32
//* Libellé       : DCMP 030399 OMG/SO
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

PictureButton TbPict []

TbPict[1] = pb_controler
TbPict[2] = pb_supprimer

F_Droit_Ecriture_Param ( tbPict, "" )


end on

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_ControlerSaisie
//* Auteur			:	N°6
//* Date				:	20/06/1997 14:31:07
//* Libellé			:	Contrôle de saisie des zones relatives à la table
//*					 	PRODUIT.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	String		"" -> On passe au controle de gestion
//*												Nom de colonne en erreur
//*
//*-----------------------------------------------------------------
//* MAJ			 PAR		Date		Modification
//* #1			 JFF		01/06/99 Ajout du controle de saisie concernant
//*                              les relances et le soldage des dossiers.(Col 24 à 32)
//*		FPI	30/01/2018	[PM407-1]		  
// 			FPI	08/10/2019	[FPI.20191008] Ajout du champs num_tel obligatoire
//*-----------------------------------------------------------------


String 		sCol [ 33 ]			// Nom des champs à vérifier.
String		sErr [ 34 ]			// Erreur relative a un champ à vérifier.
                      			// #1 un Champs en plus pour le ControlerSaisie de Dw_Relances
String		sVal [ 33 ]			// Valeur du champ en vérification.
String 		sNouvelleLigne		// Variable pour le retour à la ligne.
String		sText					// Variable relative a l'ensemble des champs à vérifier.
String		sPos					// Nom du premier champ non renseigné.

Long 			lCpt					// Compteur pour les champs à vérifier.
Long			lNbrCol				// Nombre de champs à vérifier.

n_cst_string nvString
String sValues[]

sNouvelleLigne	= "~r~n"
lNbrCol			= UpperBound ( sCol )
sPos				= ""
sText				= sNouvelleLigne

sCol [ 1 ]		= "ID_PROD"
sCol [ 2 ]		= "LIB_LONG"
sCol [ 3 ]		= "LIB_COURT"
sCol [ 4 ]		= "ID_DEPT"
sCol [ 5 ]		= "ID_DEPTS"
sCol [ 6 ]		= "ID_GRP"
sCol [ 7 ]		= "COD_MODE_REG"
sCol [ 8 ]		= "COD_DEST_REG"
sCol [ 9 ]		= "LIB_BQ_DEBIT"
sCol [ 10 ]		= "RIB_BQ"
sCol [ 11 ]		= "RIB_GUI"
sCol [ 12 ]		= "RIB_CPT"
sCol [ 13 ]		= "RIB_CLE"
sCol [ 14 ]		= "COD_ADH"
sCol [ 15 ]		= "COD_NIV_OPE"
sCol [ 16 ]		= "ID_CORB"
sCol [ 17 ]		= "NB_ADHERENT"
sCol [ 18 ]		= "DUR_PERRNV_ADH"
sCol [ 19 ]		= "UNT_PERRNV_ADH"
sCol [ 20 ]		= "COD_BASE_DMS"
sCol [ 21 ]		= "COD_PROD_DMS"
sCol [ 22 ]		= "COD_ADR_DMS"
sCol [ 23 ]		= "COD_EURO"
sCol [ 24 ]		= "DUR_RL1_MIN"
sCol [ 25 ]		= "DUR_RL1_MAX"
sCol [ 26 ]		= "UNT_RL1"
sCol [ 27 ]		= "DUR_RL2"
sCol [ 28 ]		= "UNT_RL2"
sCol [ 29 ]		= "DUR_SOLD_RL"
sCol [ 30 ]		= "UNT_SOLD_RL"
sCol [ 31 ]		= "DUR_SOLD_PC"
sCol [ 32 ]		= "UNT_SOLD_PC"
sCol [ 33 ]		= "NUM_TEL"	// [FPI.20191008]

sErr [ 1 ]		= " - Le code produit"
sErr [ 2 ]		= " - Le libellé long"
sErr [ 3 ]		= " - Le libellé court"
sErr [ 4 ]		= " - Le département"
sErr [ 5 ]		= " - Le secteur"
sErr [ 6 ]		= " - Le groupe"
sErr [ 7 ]		= " - Le mode de règlement"
sErr [ 8 ]		= " - Le destinataire du règlement"
sErr [ 9 ]		= " - Le libellé de la banque"
sErr [ 10 ]		= " - Le code banque"
sErr [ 11 ]		= " - Le code guichet"
sErr [ 12 ]		= " - Le N° de compte"
sErr [ 13 ]		= " - La clé RIB"
sErr [ 14 ]		= " - Le mode d'adhésion"
sErr [ 15 ]		= " - Le niveau de l'opérateur"
sErr [ 16 ]		= " - La corbeille"
sErr [ 17 ]		= " - Le nombre maximum d'adhérent"
sErr [ 18 ]		= " - La durée de la période de renouvellement"
sErr [ 19 ]		= " - L'unité de la période de renouvellement"
sErr [ 20 ]		= " - La base Adhésion"
// [DCMP080496] champ renommé en Code Produit Volcane
//sErr [ 21 ]		= " - Le code produit pour accéder à la base adhésion"
sErr [ 21 ]		= " - Le code produit VOLCANES ( Zone ~"ProdVolc~") "
//
sErr [ 22 ]		= " - Le mode des gestion des adresses avec les adhésions"
sErr [ 23 ]		= " - Le format de la monnaie"
sErr [ 24 ]		= " - Le délai minimum pour les 1ères relances"
sErr [ 25 ]		= " - Le délai maximum pour les 1ères relances"
sErr [ 26 ]		= " - L'unité de temps associée au 1ères relances"
sErr [ 27 ]		= " - Le délai minimum pour les 2èmes relances"
sErr [ 28 ]		= " - L'unité de temps associée au 2èmes relances"
sErr [ 29 ]		= " - Le délai minimum pour le soldage des dossiers relancés"
sErr [ 30 ]		= " - L'unité de temps associée au soldage des dossiers après relance"
sErr [ 31 ]		= " - Le délai minimum pour le soldage des dossiers qui n'ont jamais eu de courrier"
sErr [ 32 ]		= " - L'unité de temps associée au soldage des dossiers qui n'ont jamais eu de courrier"
sErr [ 32 ]		= " - L'unité de temps associée au soldage des dossiers qui n'ont jamais eu de courrier"
sErr [ 33 ]		= " - Le numéro de téléphone" // [FPI.20191008]
sErr [ 34 ] 	= " - Un << délai de soldage obligatoire des dossiers >> supérieur ou égal au << délai maximum des premières relances >>"

/*------------------------------------------------------------------*/
/* #1 : Controle la saisie de Dw_Relances.                          */
/*------------------------------------------------------------------*/
If Not iuoGsRelances.uf_Controlersaisie () Then
	sText = sText + sErr [ 34 ] + sNouvelleLigne
	sPos  = sCol [ 31 ]
End If


/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lNbrCol

	Choose Case lCpt

		Case 1, 4, 5, 6, 15, 16, 17, 18, 20, 21, 22, 23, 24, 25, 27, 29, 31

			sVal [ lCpt ] = String ( Dw_1.GetItemNumber ( 1, sCol [ lCpt ] ) )

		Case 2, 3, 7, 8, 9, 10, 11, 12, 13, 14, 19, 26, 28, 30, 32, 33 // [FPI.20191008] ajout 33

			sVal [ lcpt ] = Dw_1.GetItemString ( 1, sCol [ lCpt ] )

	End Choose

Next

/*----------------------------------------------------------------------------*/
/* Test spécifique lié à la gestion des adhésions DMS                         */
/*----------------------------------------------------------------------------*/


If sVal [ 14 ] = '1' Then

	sVal [ 20 ] = String ( Dw_1.GetItemNumber ( 1, sCol [ 20 ] ) )
// [DCMP080496] le Cod_prod_dms est obligatoire dans tous les cas
//	sVal [ 21 ] = String ( Dw_1.GetItemNumber ( 1, sCol [ 21 ] ) )
	sVal [ 22 ] = String ( Dw_1.GetItemNumber ( 1, sCol [ 22 ] ) )

Else

	sVal [ 20 ] = "0"
// [DCMP080496] le Cod_prod_dms est obligatoire dans tous les cas
//	sVal [ 21 ] = "0"
	sVal [ 22 ] = "0"
		
End If


/*------------------------------------------------------------------*/
/* Controle des zones, sont-elles renseignée ? (Contrôles           */
/* spécifiques pour les relances).                                 */
/*------------------------------------------------------------------*/
For	lCpt = 1	To	lNbrCol

	Choose Case lCpt

		Case IS <= 23

			If ( IsNull ( sVal [ lCpt ] ) or Trim ( sVal [ lCpt ] ) = "" )	Then

				If ( sPos = "" ) 	Then 	sPos = sCol [ lCpt ]
				sText = sText + sErr [ lCpt ] + sNouvelleLigne

			End If

		/*------------------------------------------------------------------*/
		/* #1 : Cas des relances/soldages (Dw_Relances prend son buffer de  */
		/*      données sur Dw_1 (ShareData) )										  */
		/*------------------------------------------------------------------*/
		Case 24 TO 32
			
			If ( ( Dw_1.GetItemString ( 1, "ALT_RL1" ) = "O" ) and ( lCpt >= 24 and lCpt <= 26 )  ) &
			OR ( ( Dw_1.GetItemString ( 1, "ALT_RL2" ) = "O" ) and ( lCpt >= 27 and lCpt <= 28 )  ) &
			OR ( ( Dw_1.GetItemString ( 1, "ALT_SOLD" ) = "O" ) and ( lCpt >= 29 and lCpt <= 32 ) ) &	
			Then

				If ( IsNull ( sVal [ lCpt ] ) or Trim ( sVal [ lCpt ] ) = "" )	Then

					If ( sPos = "" ) 	Then 	sPos = sCol [ lCpt ]
					sText = sText + sErr [ lCpt ] + sNouvelleLigne

				End If

			End If
		
		// [FPI.20191008]
		Case 33
			If ( IsNull ( sVal [ lCpt ] ) or Trim ( sVal [ lCpt ] ) = "" )	Then
	
				If ( sPos = "" ) 	Then 	sPos = sCol [ lCpt ]
				sText = sText + sErr [ lCpt ] + sNouvelleLigne
	
			End If
			
	End Choose
Next


/*------------------------------------------------------------------*/
/* Affichage de la chaîne correspondant au message d'erreur s'il y  */
/* en a une :												                    */
/*------------------------------------------------------------------*/
If	( sPos <> "" ) Then

	/*------------------------------------------------------------------*/
	/* On se positionne sur le premier onglet : Dw_1                    */
	/*------------------------------------------------------------------*/
	Uo_Onglets.Uf_ChangerOnglet ( "01" )

	stMessage.sTitre		= "Contrôle de Saisie des Produits"
	stMessage.Icon			= Information!
	stMessage.sVar[1] 	= sText
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )

End If

/*------------------------------------------------------------------*/
/* Teste s'il y a des codes garantie ou le montant provision et le  */
/* regroupement statistique a été saisi                             */
/*------------------------------------------------------------------*/
If sPos = "" Then

	/*------------------------------------------------------------------*/
	/* Controle de saisie pour les garanties                            */
	/*------------------------------------------------------------------*/
	sPos = iuoGsCodeGarantie.Uf_ControlerSaisie ()

		If ( sPos <> "" ) Then

			/*------------------------------------------------------------------*/
			/* On se positionne sur le troisième onglet : Uo_Garantie           */
			/*------------------------------------------------------------------*/
			Uo_Onglets.Uf_ChangerOnglet ( "04" )		
			Wf_Changer_Controle ( Uo_Garantie.Dw_Source )

		End If

End If

/*------------------------------------------------------------------*/
/* Teste s'il y a des courriers où le courrier type n'est pas saisi */
/*------------------------------------------------------------------*/
If sPos = "" then

	/*------------------------------------------------------------------*/
	/* Controle de saisie pour les courriers                            */
	/*------------------------------------------------------------------*/
	sPos = iuoGsCourrier.Uf_ControlerSaisie ()

	If ( sPos <> "" ) Then

		/*------------------------------------------------------------------*/
		/* On se positionne sur le deuxième onglet : Uo_Courrier            */
		/*------------------------------------------------------------------*/
		Uo_Onglets.Uf_ChangerOnglet ( "02" )		
		Wf_Changer_Controle ( Uo_Courrier.Dw_Source )

	End If

End If

/*------------------------------------------------------------------*/
/* Teste s'il y a des établissement ou le code ets a été saisi.     */
/*------------------------------------------------------------------*/
If sPos = "" Then

	/*------------------------------------------------------------------*/
	/* Controle de saisie pour les établissements.                      */
	/*------------------------------------------------------------------*/
//	sPos = iuoGsEts.Uf_ControlerSaisie ()

		If ( sPos <> "" ) Then

			/*------------------------------------------------------------------*/
			/* On se positionne sur le quatrième onglet : Uo_Ets                */
			/*------------------------------------------------------------------*/
			Uo_Onglets.Uf_ChangerOnglet ( "05" )		
			Wf_Changer_Controle ( Uo_Ets.Dw_Source )

		End If

End If


/*------------------------------------------------------------------*/
/* Teste s'il y a au moins une garantie, contrôle bloquant.         */
/*------------------------------------------------------------------*/
If sPos = "" Then

	sPos = iuoGscodeGarantie.Uf_PresenceCodeGarantie ( )

	If sPos <> "" Then

			Wf_Changer_Controle ( Uo_Garantie.dw_source )
			Uo_Onglets.Uf_ChangerOnglet ( "04" )

	End If

End If

// [PM407-1]
If sPos="" and ibRelancePM407_1 Then
	sPos=uo_relance_pm407_1.uf_controler( ) 
	
	if sPos <> "" Then
		nvString.of_parsetoarray( sPos, '.', sValues)
		sPos=sValues[2]
		
		Choose Case sValues[1]
			Case "dw_relance1"
				Wf_Changer_Controle ( uo_relance_pm407_1.dw_relance1)
			Case "dw_relance_sup"
				Wf_Changer_Controle ( uo_relance_pm407_1.dw_relance_sup)
			Case "dw_soldage"
				Wf_Changer_Controle ( uo_relance_pm407_1.dw_soldage)
			End choose
			
		Uo_Onglets.Uf_ChangerOnglet ( "02" )
		Uo_Onglets3.Uf_ChangerOnglet ( "02" )
	End if
End if
// :[PM407-1]

Return ( sPos )

end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_PreparerInserer
//* Auteur			:	N°6
//* Date				:	20/06/1997 14:42:02
//* Libellé			:	Opérations avant insertion
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Booléen	-->	True :  L'insertion peut continuer
//*										
//*
//*-----------------------------------------------------------------
//* N° Modif          Reçue Le          Effectuée Le          PAR
//*
//* TEST0002          14/11/97          20/11/97				  YP
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF		01/06/99 Initialisation de Dw_Relances. Valeurs par défaut 
//*							pour les relances et le soldage des dossiers.
//* #2  PLJ  02/06/2004 Gestion ID_GRP_PROD groupe de produit Sherpa				  
//* #3	JCA	19/04/2007	DCMP 070051 - 			  
//*		FPI	30/01/2018	[PM407-1]		  
//*-----------------------------------------------------------------


DataWindowChild	dwcIdCour				// DDDW de l'Id_Cour des courriers.
Integer				iRet						// Valeur de retour d'un appel de fonction.
Long    				lCpt						// Compteur : nombre de ligne à importer
Long					lPos						// position du tiret dans le titre.
String  				sCol [ 2 ]				// Liste des champs à déprotéger.
String				sMod						// Chaine de modification de DW.


/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")


SetPointer ( HourGlass! )

/*------------------------------------------------------------------*/
/*TEST0002 :  On ne connait pas encore le libellé du produit, dans  */
/* ce cas s'il y en a un dans le titre, on le supprime.             */
/*------------------------------------------------------------------*/
lPos = Pos ( This.Title , "-" )
	
If lPos > 0 Then &
	This.Title = Left ( This.Title , lPos - 2 )


idcIdProd 	= -1

/*------------------------------------------------------------------*/
/* PREPARER INSERER POUR L'ONGLET DES PRODUITS.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Rend accessible en saisie le Code produit                        */
/*------------------------------------------------------------------*/
sCol[ 1 ] 		= "ID_PROD"
sCol[ 2 ] 		= "ID_GRP"
Dw_1.Uf_Proteger ( sCol, "0" )

/*------------------------------------------------------------------*/
/* En création le contractant est saisissable, on positionne la     */
/* flèche de la DDDW                                                */
/*------------------------------------------------------------------*/
sMod = "ID_GRP.dddw.UseAsBorder=Yes "
Dw_1.Uf_Modify ( sMod )

/*------------------------------------------------------------------*/
/* Précise la première et la dernière colonne                       */
/*------------------------------------------------------------------*/
Dw_1.ilPremCol = 1		// ID_PROD identifiant du produit.
Dw_1.ilDernCol = 9		// COD_NIV_OPE niveau mini opérateur passer outre décisions


/*------------------------------------------------------------------*/
/* PREPARER INSERER POUR L'ONGLET DES COURRIERS.                    */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Populise les informations dans Dw_Recherche                      */
/*------------------------------------------------------------------*/
Uo_Courrier.Uf_dwRechercheRetrieve ( "", Uo_Courrier )

Uo_Courrier.Dw_Source.GetChild ( "ID_COUR" , dwcIdCour )
If dwcIdCour.RowCount ( ) < 1 Then

	dwcIdCour.SetTransObject ( iTrTrans )
	If dwcIdCour.Retrieve ( ) <= 0 Then

		dwcIdCour.InsertRow ( 0 )

	End If

End If

iRet = Uo_Courrier.Dw_Recherche.RowsCopy ( 1 , Uo_Courrier.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                    Uo_Courrier.Dw_Cible , 1 , PRIMARY!  )


/*------------------------------------------------------------------*/
/* PREPARER INSERER POUR L'ONGLET DES PARAGRAPHES D'INFORMATIONS.   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Populise les informations dans Dw_Recherche                      */
/*------------------------------------------------------------------*/
Uo_Info.Uf_dwRechercheRetrieve ( "", Uo_Info )

iRet = Uo_Info.Dw_Recherche.RowsCopy ( 1 , 	Uo_Info.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                    			Uo_Info.Dw_Cible , 1 , PRIMARY!  )


/*------------------------------------------------------------------*/
/* PREPARER INSERER POUR L'ONGLET DES CODES GARANTIES.              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Populise les informations dans Dw_Recherche                      */
/*------------------------------------------------------------------*/
Uo_Garantie.Uf_DwRechercheRetrieve ( "", Uo_Garantie )

iRet = Uo_Garantie.Dw_Recherche.RowsCopy ( 1 , 	Uo_Garantie.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                    				Uo_Garantie.Dw_Cible , 1 , PRIMARY!  )


/*------------------------------------------------------------------*/
/* Initialisation des Dw liées												  */
/*------------------------------------------------------------------*/
Dw_Pieces.Reset  ( )
Dw_Refus.Reset   ( )
Dw_Codcon.Reset  ( )

// #3
dw_paragraphes.reset ()
// FIN - #3


/*------------------------------------------------------------------*/
/* PREPARER INSERER POUR L'ONGLET DES ETABLISSEMENTS.               */
/* Pour les Ets d'un produit : ID_REV = -1.                         */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Initialisation des Dw liées 												  */
/*------------------------------------------------------------------*/
dw_LstGrp.Reset 			( )
Uo_ets.Dw_Source.Reset	( )


/*------------------------------------------------------------------*/
/* PREPARER INSERER POUR L'ONGLET DES REVISIONS.                    */
/*------------------------------------------------------------------*/
Dw_Lst_Rev.Reset ( )

/*------------------------------------------------------------------*/
/* On initialise la tableau indiquant les onglets utilisés : Trace  */
/*------------------------------------------------------------------*/
For lCpt = 1 to UpperBound ( ibOngletUtilise )

	ibOngletUtilise [ lCpt ] = False

Next

/*------------------------------------------------------------------*/
/* Positionnement sur l'onglet 1 : PRODUIT                          */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_ChangerOnglet ( "01" )

/*------------------------------------------------------------------*/
/* Positionne le focus sur la première colonne de la Dw_1           */
/*------------------------------------------------------------------*/
Dw_1.SetColumn ( Dw_1.ilPremCol )

/*------------------------------------------------------------------*/
/* #1 : Préparation de la Dw_Relances (ShareData de Dw_1) pour      */
/* insertion. 																		  */
/*------------------------------------------------------------------*/
iuoGsRelances.uf_PreparerInserer ()


/*------------------------------------------------------------------*/
/* #2 Initialisation du libellé du groupe de produit Sherpa           */
/*------------------------------------------------------------------*/
dw_1.Modify ("t_id_grp_prod.Text=''" )
/*--------*/
/* FIN #2 */
/*--------*/

// [PM407-1]
dw_det_pro.Retrieve(-1)
dw_det_pro.SetSort ( "ID_PROD A,ID_TYP_CODE_DP A,ID_CODE_DP A,ID_TYP_CALC A,TRI A" ) 
dw_det_pro.Sort ()

ibRelancePM407_1=FALSE

Return ( TRUE )

end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_PreparerModifier
//* Auteur			:	N°6
//* Date				:	20/06/1997 14:47:18
//* Libellé			:	Opération avant modification
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Booléen 	Vrai : La Modification peut continuer
//*									
//*
//*-----------------------------------------------------------------
//* N° Modif          Reçue Le          Effectuée Le          PAR
//* TEST0002          14/11/97          20/11/97				  YP
//*-----------------------------------------------------------------
//* MAJ PAR		Date		 Modification
//* #1  JFF		01/06/99  Initialisation de Dw_Relances. 
//* #2  PLJ   13/07/2004 Gestion du groupe de produit Sherpa
//* #3	JCA	19/04/2007	DCMP 070051 - 			  
//*		FPI	30/01/2018	[PM407-1]		  
//*-----------------------------------------------------------------

Integer		iRet							// Valeur de retour d'un appel de fonction.
Long			lCpt							// Compteur : nombre de ligne à importer.
Long			lNbRev						// Nombre de révision définie pour ce produit.
Long			lPos							// Position du tiret dans le titre.
String		sMod							// Chaine utiliser pour réaliser un modify.
String		sLibLong						// Libellé long du produit.

String		sLibGrpSherpa 						//#2
Long			lTotGrp, lLigneGrp, lIdGrp		//#2
Long lDeb, lFin

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")

SetPointer ( HourGlass! )

idcIdProd	= Dec ( istPass.sTab [ 1 ] )

Dw_1.ilPremCol = 5		// LIB_LONG libellé long du produit.
Dw_1.ilDernCol = 9		// COD_NIV_OPE Niveau mini opérateur passer outre décision Machine

// #1
iuoGsRelances.uf_PreparerModifier ()

/*------------------------------------------------------------------*/
/* sélection de l'enregistrement à modifier                         */
/*------------------------------------------------------------------*/
If Dw_1.Retrieve ( idcIdProd ) <= 0 Then Return ( False )

/*------------------------------------------------------------------*/
/* TEST0002 : Gestion de l'affichage du libellé long dans le titre  */
/* de la fenêtre.                                                   */
/*------------------------------------------------------------------*/
sLibLong = Dw_1.GetItemString ( 1 , "LIB_LONG" )

If sLibLong <> "" Then

	lPos = Pos ( This.Title , "-" )

	If lPos > 0 Then

		This.Title = Left ( This.Title , lPos - 2 ) + " - " + sLibLong

	Else

		This.Title = This.Title + " - " + sLibLong

	End If

End If

/*------------------------------------------------------------------*/
/* PREPARER MODIFIER POUR L'ONGLET DES COURRIERS.                   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Populise les informations dans Dw_Recherche.                     */
/*------------------------------------------------------------------*/
Uo_Courrier.Uf_DwRechercheRetrieve ( "", Uo_Courrier )


iRet = Uo_Courrier.Dw_Recherche.RowsCopy ( 1 , Uo_Courrier.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                    Uo_Courrier.Dw_Cible , 1 , PRIMARY!  )

/*------------------------------------------------------------------*/
/* Populise les informations dans la datawindow Source.             */
/*------------------------------------------------------------------*/
Uo_Courrier.Uf_DwSourceRetrieve ( "", Uo_Courrier )


/*------------------------------------------------------------------*/
/* PREPARER MODIFIER POUR L'ONGLET DES PARAGRAPHES D'INFORMATIONS.  */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Populise les informations dans la Dw_Recherche.                  */
/*------------------------------------------------------------------*/
Uo_Info.Uf_dwRechercheRetrieve ( "" , Uo_Info )

iRet = Uo_Info.Dw_Recherche.RowsCopy ( 1 , 	Uo_Info.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                    			Uo_Info.Dw_Cible , 1 , PRIMARY!  )


/*------------------------------------------------------------------*/
/* Populise les informations dans la datawindow Source.             */
/*------------------------------------------------------------------*/
Uo_Info.Uf_dwSourceRetrieve ( "" , Uo_Info )


/*------------------------------------------------------------------*/
/* PREPARER MODIFIER POUR L'ONGLET DES CODES GARANTIES.             */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Populise les informations dans la Dw_Recherche.                  */
/*------------------------------------------------------------------*/
Uo_Garantie.Uf_DwRechercheRetrieve ( "", Uo_Garantie )

Uo_Garantie.Dw_Recherche.RowsCopy ( 1 , 	Uo_Garantie.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                				Uo_Garantie.Dw_Cible , 1 , PRIMARY!  )

/*------------------------------------------------------------------*/
/* Populise les informations dans la Dw_Source.                     */
/*------------------------------------------------------------------*/
Uo_Garantie.Uf_dwSourceRetrieve ( "", Uo_Garantie )

/*------------------------------------------------------------------*/
/* Initialisation des Dw liés à la gestion des garanties du produit */
/*------------------------------------------------------------------*/
Dw_Pieces.Retrieve ( idcIdProd, -1 )
Dw_Refus.Retrieve  ( idcIdProd, -1 )
Dw_Codcon.Retrieve ( idcIdProd )

// #1 
Dw_Paragraphes.Retrieve ( idcIdProd )
// FIN - #1 

/*------------------------------------------------------------------*/
/* PREPARER MODIFIER POUR L'ONGLET DES ETABLISSEMENTS.              */
/* Pour les Ets d'un produit : ID_REV = -1.                         */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Populise les informations dans les Dw liées.                     */
/*------------------------------------------------------------------*/
dw_LstGrp.Retrieve  ( Dw_1.GetItemNumber ( 1 , "ID_GRP" ) )
uo_Ets.uf_DwSourceRetrieve ( "", uo_Ets )

/*------------------------------------------------------------------*/
/* PREPARER MODIFIER POUR L'ONGLET DES REVISIONS.                   */
/*------------------------------------------------------------------*/
sMod = "datawindow.table.procedure ='1 EXECUTE sysadm.DW_S01_REVISION " + istPass.sTab [ 1 ] + "';"
Dw_Lst_Rev.Uf_Modify         ( sMod )
lNbRev = Dw_Lst_Rev.Retrieve (      )

/*------------------------------------------------------------------*/
/* La colonne"ALT_DUPLIC" est obtenue à partir de la colonne        */
/* "MAJ_PAR", il faut donc que j'initialise cette colonne.          */
/*------------------------------------------------------------------*/
For lCpt = 1 To lNbRev

	Dw_Lst_Rev.SetItem ( lCpt, "ALT_DUPLIC", "N" )

Next

/*------------------------------------------------------------------*/
/* On initialise le tableau indiquant les onglets utilisés          */
/*------------------------------------------------------------------*/
For lCpt = 1 to UpperBound ( ibOngletUtilise )

	ibOngletUtilise [ lCpt ] = False

Next

/*------------------------------------------------------------------*/
/* Positionnement sur l'onglet des produits.                        */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_ChangerOnglet ( "01" )

/*------------------------------------------------------------------*/
/* Positionne un filtre sur ID_DEPTS en fonction de de la valeur    */
/* de ID_DEPT.                                                      */
/* le deuxieme paramètre permet de ne pas réinitialiser ID_DEPTS    */
/*------------------------------------------------------------------*/
IuoZnProduit.Uf_Zn_IdDept ( dw_1.GetItemNumber ( 1, "ID_DEPT" ), False )


/*----------------------------------------------------------------------------*/
/* S'il n'y a pas d'établissement associé au produit, le contractant est      */
/* modifiable, sinon il ne l'est pas.                                         */
/*----------------------------------------------------------------------------*/
If Uo_Ets.Dw_Source.RowCount ( ) > 0 Then

	Dw_1.Uf_Proteger ( {"ID_GRP"} , "1" )

	/*------------------------------------------------------------------*/
	/* En création le contractant est saisissable, on positionne la     */
	/* flèche de la DDDW                                                */
	/*------------------------------------------------------------------*/
	sMod = "ID_GRP.dddw.UseAsBorder=No "
	Dw_1.Uf_Modify ( sMod )

Else

	Dw_1.Uf_Proteger ( {"ID_GRP"} , "0" )

	/*------------------------------------------------------------------*/
	/* En création le contractant est saisissable, on positionne la     */
	/* flèche de la DDDW                                                */
	/*------------------------------------------------------------------*/
	sMod = "ID_GRP.dddw.UseAsBorder=Yes "
	Dw_1.Uf_Modify ( sMod )

End If

Dw_1.Uf_Proteger ( {"ID_PROD"} , "1" )

/*------------------------------------------------------------------*/
/* Positionne le focus sur la première colonne de la Dw_1           */
/*------------------------------------------------------------------*/
Dw_1.SetColumn ( Dw_1.ilPremCol )


/*------------------------------------------------------------------*/
/* #2 Récupération du libellé du groupe de produit Sherpa           */
/*------------------------------------------------------------------*/
lIdGrp    = dw_1.GetItemNumber ( 1, "ID_GRP" )
lTotGrp   = dw_lst_grp_grpsherpa.RowCount()
lLigneGrp = dw_lst_grp_grpsherpa.Find ( "ID_GRP = " + String(lIdGrp) , 1, lTotGrp )

If lLigneGrp < 1 Then  
	dw_1.Modify ("t_id_grp_prod.Text='Erreur Récup'" )
Else

	sLibGrpSherpa = String ( dw_lst_Grp_grpsherpa.GetItemNumber ( lLigneGrp, "ID_GRP_PROD" ) ) + &
						 "  " 														    						       + &
 						 dw_lst_grp_grpsherpa.GetItemString ( lLigneGrp, "LIB_GRP_SHERPA" )

	dw_1.Modify ("t_id_grp_prod.Text = '" + sLibGrpSherpa + "'" )
	
End If

/*--------*/
/* FIN #2 */
/*--------*/

// [PM407-1]
dw_det_pro.Retrieve(idcIdProd)
dw_det_pro.SetSort ( "ID_PROD A,ID_TYP_CODE_DP A,ID_CODE_DP A,ID_TYP_CALC A,TRI A" ) 
dw_det_pro.Sort ()

ibRelancePM407_1=FALSE

f_rechdetpro(lDeb, lFin, dw_det_pro, idcIdProd,"-DP",323)
if lDeb > 0 Then
	ibRelancePM407_1=TRUE
	uo_relance_pm407_1.uf_initialiser(dw_det_pro,idcIdProd)
End if

Return ( TRUE )
end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_PreparerSupprimer
//* Auteur			:	N°6
//* Date				:	20/06/1997 15:34:31
//* Libellé			:	Demande de confirmation avant suppression.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean			TRUE = La suppression peut continuer
//*
//*-----------------------------------------------------------------
//* #1 JFF  12/12/2006   [DCMP060824]
//*-----------------------------------------------------------------

Boolean		bRet 			// Variable de retour de la fonction.

Decimal{0}	dcIdRev		// Identifiant de la révision.

Integer		iRet			// Confirmation de l'opérateur

String 		sText 		// Variable de retour de la fonction de controle.
String		sTable		// Nom de la table à tracer.
String		sType			// Type d'action effectuer sur la table.
String		sCle [ 2 ]	// Tableau de l'identifiant de l'enregistrement tracé.
String		sCol [ 1 ]	// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal [ 1 ]	// Tableau des valeurs des colonnes à tracer.

bRet 		= True
dcIdRev	= -1

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/
stMessage.sTitre 		= "Suppression d'un Produit"
stMessage.sVar[ 1 ] 	= "ce produit"
stMessage.Bouton		= YesNo!
stMessage.Icon			= Exclamation!
stMessage.sCode		= "CONF001"

iRet						= f_Message ( stMessage )

/*------------------------------------------------------------------*/
/* Traitement suivant confirmation ou non de l'opérateur            */
/*------------------------------------------------------------------*/
If iRet = 2 Then 	

	bRet = False

Else

	SetPointer ( HourGlass! )

	/*------------------------------------------------------------------*/
	/* Vérification de l'intégrité référencielle vis à vis de la table  */
	/* SINISTRE                                                         */
	/*------------------------------------------------------------------*/
	sText	= iuoGsProduit.uf_Gs_Sup_Produit ( idcIdProd )

	If sText <> "" Then

		bRet = False

		stMessage.sTitre 		= "Contrôle avant Suppression d'un Produit"
		stMessage.sVar[ 1 ] 	= "des sinistres"  // #1 ald sText
		stMessage.sVar[ 2 ] 	= "ce produit"
		stMessage.sCode		= "REFU002"
		f_Message ( stMessage )

	Else

		/*------------------------------------------------------------------*/
		/* Suppression du Produit : Table PRODUIT                           */
		/*------------------------------------------------------------------*/		
		If Dw_1.DeleteRow ( 0 ) < 0	Then

			bRet = False

		End If

	End If

End If

If bRet	Then
	/*------------------------------------------------------------------*/
	/* Suppression des enregistrements liés au Produit                  */
	/*			dans la table DELAI                                        */
	/*			dans la table PLAFOND                                      */
	/*			dans la table FRANCHISE                                    */
	/*			dans la table CONDITION                                    */
	/*			dans la table GARANTIE                                     */
	/*			dans la table CODE_CONDITION                               */
	/*			dans la table MOTIF                                        */
	/*			dans la table PIECE                                        */
	/*			dans la table CODE_GARANTIE                                */
	/*			dans la table REVISION                                     */
	/*			dans la table COURRIER                                     */
	/*			dans la table ETABLISSEMENT                                */
	/*			dans la table PARA_PROD                                    */
	/*			dans la table AFFILIER                                     */
	/*------------------------------------------------------------------*/
	F_Execute ( "Exec sysadm.PS_SUPPRODUIT " + String ( idcIdProd ), itrTrans) 

	If itrTrans.SQLCode < 0 Then

		F_DbErreur ( itrTrans.SQLDBCode, itrTrans.SQLErrText, itrTrans )
		bRet = False

	Else

		sType 		= 'D'
		sCle[ 1 ] 	= "'" + String ( idcIdProd ) + "'"

		/*------------------------------------------------------------------*/
		/* Trace suppression des lignes de DELAI                            */
		/*------------------------------------------------------------------*/
		sTable 		= "DELAI"

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

			bRet = False

		End If

		If	bRet	Then

			/*------------------------------------------------------------------*/
			/* Trace suppression des lignes de PLAFOND                          */
			/*------------------------------------------------------------------*/
			sTable 		= "PLAFOND"

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				bRet = False

			End If

		End If

		If	bRet	Then

			/*------------------------------------------------------------------*/
			/* Trace suppression des lignes de FRANCHISE                        */
			/*------------------------------------------------------------------*/
			sTable 		= "FRANCHISE"

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				bRet = False

			End If

		End If

		If	bRet	Then

			/*------------------------------------------------------------------*/
			/* Trace suppression des lignes de CODE_CONDITION                   */
			/*------------------------------------------------------------------*/
			sTable 		= "CODE_CONDITION"

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				bRet = False

			End If

		End If

		If	bRet	Then

			/*------------------------------------------------------------------*/
			/* Trace suppression des lignes de MOTIF                            */
			/*------------------------------------------------------------------*/
			sTable 		= "MOTIF"

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				bRet = False

			End If

		End If

		If	bRet	Then

			/*------------------------------------------------------------------*/
			/* Trace suppression des lignes de PIECE                            */
			/*------------------------------------------------------------------*/
			sTable 		= "PIECE"

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				bRet = False

			End If

		End If

		If	bRet	Then

			/*------------------------------------------------------------------*/
			/* Trace suppression des lignes de CODE_GARANTIE                    */
			/*------------------------------------------------------------------*/
			sTable 		= "CODE_GARANTIE"

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				bRet = False

			End If

		End If

		If	bRet	Then

			/*------------------------------------------------------------------*/
			/* Trace suppression des lignes de CONDITION                        */
			/*------------------------------------------------------------------*/
			sTable 		= "CONDITION"

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				bRet = False

			End If

		End If

		If	bRet	Then

			/*------------------------------------------------------------------*/
			/* Trace suppression des lignes de GARANTIE                         */
			/*------------------------------------------------------------------*/
			sTable 		= "GARANTIE"

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				bRet = False

			End If

		End If

		If	bRet	Then

			/*------------------------------------------------------------------*/
			/* Trace suppression des lignes de REVISION                         */
			/*------------------------------------------------------------------*/
			sTable 		= "REVISION"

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				bRet = False

			End If

		End If

		If	bRet	Then

			/*------------------------------------------------------------------*/
			/* Trace suppression des lignes de COURRIER                         */
			/*------------------------------------------------------------------*/
			sTable 		= "COURRIER"

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				bRet = False

			End If

		End If

		If	bRet	Then

			/*------------------------------------------------------------------*/
			/* Trace suppression des lignes de ETABLISSEMENT                    */
			/*------------------------------------------------------------------*/
			sTable 		= "ETABLISSEMENT"

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				bRet = False

			End If

		End If

		If	bRet	Then

			/*------------------------------------------------------------------*/
			/* Trace suppression des lignes de PARA_PROD                        */
			/*------------------------------------------------------------------*/
			sTable 		= "PARA_PROD"

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				bRet = False

			End If

		End If

		If	bRet	Then

			/*------------------------------------------------------------------*/
			/* Trace suppression des lignes dans AFFILIER                       */
			/*------------------------------------------------------------------*/
			sTable 		= "AFFILIER"

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				bRet = False

			End If

		End If

	End If

End If

Return ( bRet )
end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_PreparerValider
//* Auteur			:	N°6
//* Date				:	20/06/97 14:55:58
//* Libellé			:	Initialisation des infos en création.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean		 TRUE = La validation peut continuer
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF		03/06/99 Préparation de Dw_Relances (ShareData avec Dw1) avant Validation
//*		FPI	30/01/2018	[PM407-1]		  
//*-----------------------------------------------------------------

Boolean		bRet				// Valeur de retour de la fonction
String		sRelUntTps		// Relances, unité de temps

Datetime		dtMajLe			// Valeur du Maj_Le de Dw_1

bRet = True

/*------------------------------------------------------------------*/
/* Initialisation des informations de création et de dernière       */
/* modification d'un produit                                        */
/*------------------------------------------------------------------*/
If ( iUoGsProduit.Uf_PreparerValider ( istPass.bInsert ) )	Then

	dtMajLe  = Dw_1.GetItemDateTime  ( 1, "MAJ_LE"  )

Else

	bRet = False

End If

/*------------------------------------------------------------------*/
/* Mise à jour de l'objet d'assignation des codes garantie.         */
/*------------------------------------------------------------------*/
If	bRet	Then	

	bRet = iUoGsCodeGarantie.Uf_PreparerValider ( idcIdProd )

	/*------------------------------------------------------------------*/
	/* Mise à jour de l'objet d'assignation des révisions.              */
	/*------------------------------------------------------------------*/
	If	bRet	Then	bRet = iUoGsRevProd.Uf_PreparerValider ( idcIdProd )

End If

/*------------------------------------------------------------------*/
/* #1 : Traitement des différents cas à gérér sur Dw_Relances       */
/* juste avant la validation.                                       */
/*------------------------------------------------------------------*/

// Si pas de première relance, toutes les zones concernant la première
// relance sont mises à 0 ou à M selon le champs.
// ATTENTION : on ne touche pas à UNT_RL1 car cette zone contient l'unité
// de temps pour toutes les zones de délais de Dw_Relances.

If Dw_Relances.GetItemString ( 1, "ALT_RL1" ) = "N" then

	Dw_Relances.SetItem ( 1, "DUR_RL1_MIN", 0 )
	Dw_Relances.SetItem ( 1, "DUR_RL1_MAX", 0 )

End If

// Si pas de deuxième relance, toutes les zones concernant la deuxième
// relance sont mises à 0 ou à M selon le champs.
If Dw_Relances.GetItemString ( 1, "ALT_RL2" ) = "N" then

	Dw_Relances.SetItem ( 1, "DUR_RL2", 0 )
	Dw_Relances.SetItem ( 1, "UNT_RL2", "M" )

End If

// Si pas de soldage, toutes les zones concernant le soldage
// sont mises à 0 ou à M selon le champs.
If Dw_Relances.GetItemString ( 1, "ALT_SOLD" ) = "N" then

	Dw_Relances.SetItem ( 1, "DUR_SOLD_RL", 0 )
	Dw_Relances.SetItem ( 1, "DUR_SOLD_PC", 0 )
	Dw_Relances.SetItem ( 1, "UNT_SOLD_RL", "M" )
	Dw_Relances.SetItem ( 1, "UNT_SOLD_PC", "M" )

End If

// [ITSM325608]
// [EVOL_PARAM_RELSOLD]
/*
	If Dw_Relances.GetItemString ( 1, "ALT_RL2" ) = "O" then 
		Dw_Relances.SetItem ( 1, "UNT_RL2", Dw_Relances.GetItemString ( 1, "UNT_RL1" ) )
	End if
	If Dw_Relances.GetItemString ( 1, "ALT_SOLD" ) = "O" then
		Dw_Relances.SetItem ( 1, "UNT_SOLD_RL", Dw_Relances.GetItemString ( 1, "UNT_RL1" ) )
		Dw_Relances.SetItem ( 1, "UNT_SOLD_PC", Dw_Relances.GetItemString ( 1, "UNT_RL1" ) )
	End if
*/
// :[ITSM325608]

/*------------------------------------------------------------------*/
/* On active le mode incrémentation autonome. (voir la fonction     */
/* elle-même pour                                                   */
/* quelques explications sur ce mode d'utilisation de la trace ou   */
/* l'analyse des traitements de la trace !)                         */
/*------------------------------------------------------------------*/
UoGsTrace.uf_ModeIncAutonome ( True )

// [PM407-1]
if ibRelancePM407_1 Then
	uo_relance_pm407_1.uf_preparer_valider()
	
	Dw_Relances.SetItem ( 1, "ALT_RL1","N")
	Dw_Relances.SetItem ( 1, "ALT_RL2","N")
	Dw_Relances.SetItem ( 1, "ALT_SOLD","N")
	
	Dw_Relances.SetItem ( 1, "DUR_RL1_MIN",0)
	Dw_Relances.SetItem ( 1, "DUR_RL1_MAX",0)
	Dw_Relances.SetItem ( 1, "DUR_RL2",0)
	Dw_Relances.SetItem ( 1, "DUR_SOLD_RL",0)
	Dw_Relances.SetItem ( 1, "DUR_SOLD_PC",0)
End if

Return ( bRet )
end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_ControlerGestion
//* Auteur			:	N°6
//* Date				:	20/06/1997 14:34:12
//* Libellé			:	Contrôle de gestion de la saisie
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	""		->	Si contrôle Ok
//*					  				Nom de la colonne en Erreur
//*
//*-----------------------------------------------------------------
//* #1	JCA	01/10/2007		DCMP 70651 - Controle pour les modes d'adhesion 3 ou 4 
//*										le seul effet de revision est date de survenance
//			FPI	06/12/2010		[20101207.FPI] Contrôle de l'existence du rib dans GENVIR
//       JFF   15/05/2020     ajout d'un TRIM sur lib_court et lib_long
//*-----------------------------------------------------------------
String		sMess					// Message d'erreur.
String		sMessMotifRefus	// Message d'absence de motif de refus.
String		sCol 					// Nom de la colonne en Erreur.
String      sLibProduit			// Libellé du produit.
String      sVal

Decimal{0}	dcIdProd				// Identifiant du produit.

sCol = ""

sVal = Trim ( Dw_1.GetItemString ( 1, "LIB_COURT" ))
Dw_1.SetItem ( 1, "LIB_COURT", sVal )

sVal = Trim ( Dw_1.GetItemString ( 1, "LIB_LONG" ))
Dw_1.SetItem ( 1, "LIB_LONG", sVal )


If ( istPass.bInsert = True )  Then

	dcidProd 		= Dw_1.GetItemNumber ( 1, "ID_PROD" )

	sLibProduit = iuoGsProduit.uf_gs_Id_Produit ( dcidProd )

	/*------------------------------------------------------------------*/
	/* Si l'identifiant existe déjà, on déclenche le message d'erreur   */
	/*------------------------------------------------------------------*/
	If ( sLibProduit <> "" ) Then

		/*------------------------------------------------------------------*/
		/* Repositionne le bon onglet : Dw_1                                */
		/*------------------------------------------------------------------*/
		Uo_Onglets.Uf_ChangerOnglet ( "01" )

		stMessage.sTitre  = "Contrôle de Gestion des Produits"
		stMessage.sVar[1] = String ( dcIdProd )
		stMessage.sVar[2] = "au produit"
		stMessage.sVar[3] = sLibProduit
		stMessage.sCode	= "REFU001"

		f_Message ( stMessage )

		sCol 		= "ID_PROD"

	End If

End If

/*------------------------------------------------------------------*/
/* Contrôles d'existence non bloquant.                              */
/*------------------------------------------------------------------*/
If ( sCol = "" )	Then

	sMess = ""

	/*------------------------------------------------------------------*/
	/* Teste s'il y a des pièces et des évènements non saisis sur des   */
	/* garanties.                                                       */
	/*------------------------------------------------------------------*/
	sMess = iUoGsCodeGarantie.Uf_PresencePieceEvenement ( )

	/*------------------------------------------------------------------*/
	/* Controle si au moins un courrier a été associé au produit :      */
	/* NON bloquant.                                                    */
	/*------------------------------------------------------------------*/
	sMess = sMess + iuoGsCourrier.Uf_PresenceCourrier ( )

	/*------------------------------------------------------------------*/
	/* Controle si au moins un établissement a été associé au produit : */
	/* NON bloquant.                                                    */
	/*------------------------------------------------------------------*/
//	sMess = sMess + iuoGsEts.Uf_PresenceEts ( )

	/*------------------------------------------------------------------*/
	/* Teste s'il y a au moins une révision saisie. Contrôle non        */
	/* bloquant.                                                        */
	/*------------------------------------------------------------------*/
	sMess = sMess + iuoGsRevProd.Uf_Gs_PresenceRevision ( )

	/*------------------------------------------------------------------*/
	/* Teste s'il y a au moins une nature de sinistre, une              */
	/* territorialité, un détail pour le produit.                       */
	/*------------------------------------------------------------------*/
	sMess = sMess + iuoGsCodeCondition.Uf_PresenceCodeCondition ( )

	/*------------------------------------------------------------------*/
	/* Teste pour chaque garantie s'il y a des refus.                   */
	/*------------------------------------------------------------------*/
	sMessMotifRefus = iUoGsCodeGarantie.Uf_PresenceMotifRefus ( )

	If sMess <> "" Or sMessMotifRefus <> "" Then

		stMessage.sTitre		= "Avertissement"
		stMessage.sCode		= "GENE012"

		/*------------------------------------------------------------------*/
		/* Si aucun motif de refus n'a été positionné, on demande si c'est  */
		/* normal.                                                          */
		/*------------------------------------------------------------------*/
		If sMessMotifRefus <> "" Then

			stMessage.Bouton		=	YesNo!
			stMessage.Icon			=	Question!
			stMessage.sVar[ 1 ]	=	sMess + "~r~n" + sMessMotifRefus

			If ( f_Message ( stMessage ) = 2 ) Then

				sCol = "ID_GTI"

				Wf_Changer_Controle ( Uo_Garantie.dw_source )
				Uo_Onglets.Uf_ChangerOnglet ( "04" )
	
			End If

		Else

			stMessage.Icon			= Information!
			stMessage.sVar[ 1 ]	= sMess

			f_Message ( stMessage )

		End If

	End If

End If


/*------------------------------------------------------------------*/
/* Validité de la gestion de téléphonie ou pas.							  */
/*------------------------------------------------------------------*/
If sCol = "" Then
	sMess = iuoGsProduit.uf_GestionTelephonie ()
	If sMess <> "" Then

		sCol = "COD_TEL"

		stMessage.sTitre		= "Avertissement"
		stMessage.sCode		= "GENE012"
		stMessage.Bouton		=	Ok!
		stMessage.Icon			=	Question!
		stMessage.sVar[ 1 ]	=	sMess + "~r~n"

		f_Message ( stMessage ) 
	End If
End If

// #1
If sCol = "" Then
	If not wf_controler_cod_adh() Then

		sCol = "COD_ADH"

		stMessage.sTitre		= "Avertissement"
		stMessage.sCode		= "GENE159"
		stMessage.Bouton		=	Ok!
		stMessage.Icon			=	Information!

		f_Message ( stMessage ) 
	End If
End If
// FIN - #1

// [20101207.FPI]
If sCol = "" Then
	If not iuogsproduit.uf_gs_verif_compte( ) Then

		sCol = "RIB_BQ"

		stMessage.sTitre		= "Avertissement"
		stMessage.sCode		= "GENE167"
		stMessage.Bouton		=	Ok!
		stMessage.Icon			=	Information!

		f_Message ( stMessage ) 
	End If
End If

Return ( sCol )
end function

public function boolean wf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_TerminerValider ()
//* Auteur			:	N°6
//* Date				:	20/06/1997 15:42:17
//* Libellé			:	Update les Dw et les tables liées à la mise à jour
//*					 	de la table des produits.
//* Commentaires	: 
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean : True la validation peut se poursuivre.
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date			Modification
//*		FPI	30/01/2018	[PM407-1]		  
//*-----------------------------------------------------------------

Boolean		bRet		// Valeur de retour de la fonction

DateTime		dtMajLe	// Valeur de mise à jour


bRet		= True

dtMajLe	= Dw_1.GetItemDateTime ( 1, "MAJ_LE"  )

/*------------------------------------------------------------------*/
/* Update les courriers au produit.                                 */
/*------------------------------------------------------------------*/
If	ibOngletUtilise [ 2 ] Then	
	bRet = 	iUoGsCourrier.Uf_TerminerValider ( )

end if

/*------------------------------------------------------------------*/
/* Update les paragraphes d'informations au produit.                */
/*------------------------------------------------------------------*/
If	bRet And ibOngletUtilise[ 3 ]	Then	
	bRet = 	iUoGsParaInfo.Uf_TerminerValider ( )

end if	

/*------------------------------------------------------------------*/
/* Update les codes garanties du produit.                           */
/*------------------------------------------------------------------*/
If	bRet And ibOngletUtilise [ 4 ]	Then	

	bRet = iUoGsCodeGarantie.Uf_TerminerValider ( )

End If

/*------------------------------------------------------------------*/
/* Update les Etablissements du produit.                            */
/* si l'utilisateur est entré dans l'onglet des établissements ou   */
/* sur la fenêtre des révisions.                                    */
/*------------------------------------------------------------------*/
If	bRet And ( ibOngletUtilise [ 5 ]	Or ibOngletUtilise [ 6 ] )	Then

	bRet = (iUoGsEts.Uf_TerminerValider ( 	idcIdProd, 			&
														istPass.bInsert,  &
														dtMajLe,				&
														uoGsTrace ) > 0 )

End If

/*------------------------------------------------------------------*/
/* Update les revisions du produit.                                 */
/* La duplication doit être réalisée au même moment que la          */
/* validation du produit ( Cree_Le, Maj_Le )                        */
/*------------------------------------------------------------------*/
If	bRet And ibOngletUtilise [ 6 ]	Then	bRet = iUoGsRevProd.Uf_TerminerValider &
																( idcIdProd, dtMajLe )

// [PM407-1]
If bRet and ibrelancepm407_1 Then
	bRet=uo_relance_pm407_1.uf_terminer_valider( )
End if
// :[PM407-1]

/*------------------------------------------------------------------*/
/* On desactive le mode incrémentation autonome. (voir la fonction  */
/* elle-même pour                                                   */
/* quelques explications sur ce mode d'utilisation de la trace ou   */
/* l'analyse des traitements de la trace !)                         */
/*------------------------------------------------------------------*/
UoGsTrace.uf_ModeIncAutonome ( False )

/*------------------------------------------------------------------*/
/* commit la trace ou la rollbacke en fonction de l'état de bRet.   */
/*------------------------------------------------------------------*/
UoGsTrace.Uf_CommitTrace ( bRet )

Return ( bRet )
end function

public function boolean wf_accepttext ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_acceptText
//* Auteur			:	N°6
//* Date				:	20/06/97 14:30:04
//* Libellé			:	déclenche les AcceptText sur toutes les DW pour valider les saisies.
//* Commentaires	: 
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean		True = OK on peut continuer les contrôles.
//*										False Sinon
//*
//*-----------------------------------------------------------------

Dw_CodCon.SetFilter ( "" )
Dw_CodCon.Filter    ( )

/*----------------------------------------------------------------------------*/
/* Le ChangerOnglet 01 déclenchera le "quitteronglet", de l'onglet courant.   */
/* Ainsi si on se trouve par exemple sur l'onglet des Ets, le                 */
/* quitteronglet051 se déclenchera et un AccepText partira pour les Ets.      */
/* Idem pour les courriers, les garanties.                                    */
/*----------------------------------------------------------------------------*/

Uo_Onglets.Uf_ChangerOnglet ( "01" )

Return ( TRUE )
end function

public function boolean wf_terminersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_terminerSupprimer
//* Auteur			:	N°6
//* Date				:	20/06/97 15:40:29
//* Libellé			:	termine la suppression
//* Commentaires	: 
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	boolean		TRUE 	si OK, la suppression peut continuer.
//*										FALSE sinon.
//*
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Tout est OK, on peut commiter la trace.                          */
/*------------------------------------------------------------------*/
UoGsTrace.Uf_CommitTrace ( True )

Return ( True )
end function

public subroutine wf_sup_pieces (long adcIdGti);//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_sup_pieces
//* Auteur			:	La Recrue
//* Date				:	03/07/97 16:46:54
//* Libellé			:	Supprime les lignes corrrespondant au code garantie dans dw_Pieces
//* Commentaires	:	
//*
//* Arguments		:	Long	adcIdGti	(Val) :Identifiant de la garantie
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

Long 		lLig
String	sFind


sFind = "ID_GTI=" + String ( adcIdGti )

lLig = Dw_Pieces.Find ( sFind, 1, Dw_Pieces.RowCount () )

Do While ( lLig > 0 )

	Dw_Pieces.DeleteRow ( lLig )
	lLig = Dw_Pieces.Find ( sFind, 1, Dw_Pieces.RowCount () )

Loop
end subroutine

public subroutine wf_sup_refus (long adcIdGti);//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_sup_refus
//* Auteur			:	La Recrue
//* Date				:	03/07/97 16:46:54
//* Libellé			:	Supprime les lignes corrrespondant au code garantie dans dw_Refus
//* Commentaires	:	
//*
//* Arguments		:	Long	adcIdGti	(Val) :Identifiant de la garantie
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

Long 		lLig
String	sFind


sFind = "ID_GTI=" + String ( adcIdGti )

lLig = Dw_Refus.Find ( sFind, 1, Dw_Refus.RowCount () )

Do While ( lLig > 0 )

	Dw_Refus.DeleteRow ( lLig )
	lLig = Dw_Refus.Find ( sFind, 1, Dw_Refus.RowCount () )

Loop
end subroutine

public subroutine wf_sup_codcon (long adcidgti);//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_sup_codcon
//* Auteur			:	La Recrue
//* Date				:	03/07/97 16:46:54
//* Libellé			:	Supprime les lignes corrrespondant au code garantie dans Dw_CodCon
//* Commentaires	:	
//*
//* Arguments		:	Long	adcIdGti	(Val) :Identifiant de la garantie
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

Long 		lLig
String	sFind

Dw_CodCon.SetFilter ( "" )
Dw_CodCon.Filter    ( )

sFind = "ID_GTI=" + String ( adcIdGti )

lLig = Dw_CodCon.Find ( sFind, 1, Dw_CodCon.RowCount () )

Do While ( lLig > 0 )

	Dw_CodCon.DeleteRow ( lLig )
	lLig = Dw_CodCon.Find ( sFind, 1, Dw_CodCon.RowCount () )

Loop
end subroutine

public function boolean wf_preparerabandonner ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparerabandonner
//* Auteur			:	La Recrue
//* Date				:	15/07/97 15:09:49
//* Libellé			:	Permet de demander la confirmation d'abondon de saisie
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	True, ue_retour peut continuer.
//*
//*-----------------------------------------------------------------

stMessage.sTitre	= This.Title
stMessage.Bouton	= YesNo!
stMessage.Icon		= Exclamation!
stMessage.sVar[1] = "des produits"
stMessage.sCode	= "CONF002"

Return ( f_Message ( stMessage ) = 1 )

end function

public subroutine wf_initongletcondition (string asidtypcod, string astitrecible, string astitresource);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_InitOngletCondition
//* Auteur			: YP
//* Date				: 07/11/1997 15:28:54
//* Libellé			: 
//* Commentaires	: Populise les informations dans l'objet Contenu/contenant
//*					  des codes conditions.
//*
//* Arguments		:	asIdTypCode		String 	(Val) : le type de conditions.
//*						asTitreCible	String	(Val) : Titre de la liste Cible.
//*						asTitreSource	String	(Val) : Titre de la liste Source.
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String				sFiltre		// Filtre sur la DW de recherche.
String				sMod			// Chaine de modification.
Long					lCpt			// Compteur pour le nombre de ligne à importer.
Long 					lNbLigSrc	// Nombre de ligne dans Dw_Source.

SetPointer ( HourGlass! )

Uo_CodCon.SetRedraw ( False )

/*------------------------------------------------------------------*/
/* On affecte le titre aux datawindows de l'objet                   */
/*------------------------------------------------------------------*/
sMod = "titre.Text=" + asTitreCible
Uo_CodCon.Uf_Modify ( Uo_CodCon.Dw_Cible, sMod )

sMod = "titre.Text=" + asTitreSource
Uo_CodCon.Uf_Modify ( Uo_CodCon.Dw_Source, sMod )

Uo_CodCon.Dw_Cible.Reset ()

/*------------------------------------------------------------------*/
/* Populise les informations dans la datawindow Source.             */
/*--------------------------------------------------------- --------*/
Uo_CodCon.Dw_Source.SetFilter ( "ID_GTI=-1 AND ID_TYP_CODE='" + asIdTypCod + "'" )
Uo_CodCon.Dw_Source.Filter ( )
Uo_CodCon.Dw_Source.SetSort ( "id_code A" )
Uo_CodCon.Dw_Source.Sort ( )

lNbLigSrc = Uo_CodCon.Dw_Source.RowCount ( )

sFiltre = "ID_TYP_CODE='" + asIdTypCod + "'"

If lNbLigSrc > 0 Then

	For	lCpt = 1 To lNbLigSrc


		sFiltre = sFiltre + " AND ID_CODE <> " + String ( Uo_CodCon.Dw_Source.GetItemNumber ( lCpt , "ID_CODE" ) )

	Next

End If

Uo_CodCon.Dw_Recherche.SetFilter	( sFiltre )
Uo_Codcon.Dw_Recherche.Filter		( )
Uo_CodCon.Dw_Recherche.RowsCopy	( 1 , 	Uo_CodCon.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                    		Uo_CodCon.Dw_Cible , 1 , PRIMARY!  )

Uo_CodCon.Dw_Recherche.SetFilter ( "" )
Uo_CodCon.Dw_Recherche.Filter ( )


Uo_CodCon.Dw_Cible.SetSort ( "id_code A" )
Uo_CodCon.Dw_Cible.Sort ( )

/*------------------------------------------------------------------*/
/* On positionne le Focus sur  Dw_Cible afin d'éviter que  la       */
/* première ligne de Dw_cible ET de Dw_Source qui soient            */
/* sélectionnées simultanément.S'il n'y a pas de ligne dans         */
/* Dw_Cible le focus est positionné sur Dw_Source.                  */
/*------------------------------------------------------------------*/
If Uo_CodCon.Dw_Cible.RowCount ( ) > 0 Then

	Uo_CodCon.Dw_Cible.SelectRow ( 0 , False )	
	Uo_CodCon.Dw_Cible.SetFocus  ( )
	Uo_CodCon.Dw_Cible.SelectRow ( 1 , True )

Else

	Uo_CodCon.Dw_Source.SelectRow ( 0 , False )	
	Uo_CodCon.Dw_Source.SetFocus ( )
	Uo_CodCon.Dw_Source.SelectRow( 1 , True )

End If

Uo_CodCon.SetRedraw ( TRUE )
end subroutine

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PositionnerObjets
//* Auteur			: Fabry JF
//* Date				: 28/05/1999 16:19:16
//* Libellé			: Positonne et taille les objets
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*		FPI	30/01/2018	[PM407-1]		  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Fenêtre.                                                         */
/*------------------------------------------------------------------*/
This.X					=    1
This.Y					=    1
This.Width				= 3617
This.Height				= 2057

/*------------------------------------------------------------------*/
/* Onglet 01                                                        */
/*------------------------------------------------------------------*/
Uo_Onglets.X     		=   10
Uo_Onglets.Y     		=  160
Uo_Onglets.Height		=  109

/*------------------------------------------------------------------*/
/* Objets contenus dans l'onglet 01                                 */
/*------------------------------------------------------------------*/
/* Produit.                                                         */
/*------------------------------------------------------------------*/
Dw_1.X					=   60
Dw_1.Y					=  280
Dw_1.Width				= 3300
Dw_1.Height				= 1330
/*------------------------------------------------------------------*/
/* Courriers.                                                       */
/*------------------------------------------------------------------*/
uo_Onglets3.X			= Dw_1.X + 10
uo_Onglets3.Y			= Dw_1.Y + 10
uo_Onglets3.Height	= 109

uo_Courrier.X			= Dw_1.X + 70
uo_Courrier.Y			= Dw_1.Y + 140
uo_Courrier.Width		= Dw_1.Width - 160
uo_Courrier.Height	= Dw_1.Height - 160
/*------------------------------------------------------------------*/
/* Relances Dans Onglet_3.                                          */
/*------------------------------------------------------------------*/
Dw_Relances.X			= Dw_1.X + 70
Dw_Relances.Y			= Dw_1.Y + 140
Dw_Relances.Width		= Dw_1.Width - 160
Dw_Relances.Height	= Dw_1.Height - 160

// [PM407-1]
uo_relance_pm407_1.X			= Dw_1.X + 70
uo_relance_pm407_1.Y			= Dw_1.Y + 140
uo_relance_pm407_1.Width		= Dw_1.Width - 160
uo_relance_pm407_1.Height	= Dw_1.Height - 160
// :[PM407-1]

/*------------------------------------------------------------------*/
/* Infos Courriers.                                                 */
/*------------------------------------------------------------------*/
uo_Info.X				= Dw_1.X
uo_Info.Y				= Dw_1.Y
uo_Info.Width			= Dw_1.Width
uo_Info.Height			= Dw_1.Height
/*------------------------------------------------------------------*/
/* Garanties/Conditions.                                            */
/*------------------------------------------------------------------*/
uo_Onglets2.X			= Dw_1.X + 10
uo_Onglets2.Y			= Dw_1.Y + 10
uo_Onglets2.Height	= 109

uo_Garantie.X			= Dw_1.X + 70
uo_Garantie.Y			= Dw_1.Y + 140
uo_Garantie.Width		= Dw_1.Width - 160
uo_Garantie.Height	= Dw_1.Height - 160

uo_CodCon.X				= Dw_1.X + 70
uo_CodCon.Y				= Dw_1.Y + 140
uo_CodCon.Width		= Dw_1.Width - 160
uo_CodCon.Height		= Dw_1.Height - 160
/*------------------------------------------------------------------*/
/* Etablissements.                                                  */
/*------------------------------------------------------------------*/
uo_Ets.X					= Dw_1.X
uo_Ets.Y					= Dw_1.Y
uo_Ets.Width			= Dw_1.Width
uo_Ets.Height			= Dw_1.Height
/*------------------------------------------------------------------*/
/* Révisions.                                                       */
/*------------------------------------------------------------------*/
Dw_Lst_Rev.X			= Dw_1.X
Dw_Lst_Rev.Y			= Dw_1.Y
Dw_Lst_Rev.Width		= Dw_1.Width
Dw_Lst_Rev.Height		= Dw_1.Height


end subroutine

public function boolean wf_controler_cod_adh ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_tm_sp_produit::wf_controler_cod_adh
//* Auteur			: JCA
//* Date				: 01/10/2007
//* Commentaires	: DCMP 70651 - Controle pour les modes d'adhesion 3 ou 4 
//*										le seul effet de revision est date de survenance
//* Retourne		: NotFound	
//*
//*-----------------------------------------------------------------
//* MAJ		PAR		Date			Modification
//*-----------------------------------------------------------------

boolean bRet
integer iFind
string sCodAdh, sRechCodEffRev

bRet = true

sCodAdh = dw_1.object.cod_adh[1]

if sCodAdh = '3' or sCodAdh = '4' then
	sRechCodEffRev = "cod_eff_rev <> 'DTE_SURV'"
	iFind = dw_lst_rev.find ( sRechCodEffRev, 1, dw_lst_rev.rowcount() )
	
	if iFind > 0 then bRet = false
	
end if

return bRet
end function

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_Tm_sp_Produit
//* Evenement 		:	ue_initialiser
//* Auteur			:	N°6
//* Date				:	20/06/97 11:58:13
//* Libellé			:	Initialisation de la fenêtre de traitement des 
//*					 	Produits.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date			Modification
//* #1  JFF		28/05/99		Ajout du positionnement des objets via une fonction Wf.
//* #2  JFF		31/05/99		Ajout d'une 3ème barre d'onglet sur l'onglet Courrier.
//* #3  JFF		01/06/99    Initialisation de Dw_Relances.
//* #4  JFF    05/05/04    DCMP 040020 SVE Gestion validation autonome.	
//* #5  PLJ   13/07/2004   Gestion du groupe de produit Sherpa
//* #6	JCA	02/05/2007	DCMP 070051 - 	Modification de l'heritage de [u_sp_gs_courrier]
//			FPI	30/01/2018	[PM407-1]
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
// [MIGPB11] [EMD] : Debut Migration : mise en commentaire de la double declaration de sTables [ 1 ]
//String 				sTables [ 1 ]	// Tableau pour les tables utilisé pour définir
											// la Dw de détail des révision.
// [MIGPB11] [EMD] : Fin Migration											
String 				sTables []	// Tableau pour les tables utilisé pour définir la Dw de détail des révision.
//Fin Migration PB8-WYNIWYG-03/2006 FM

DataWindowChild	dwIdDept			// DDDW des départements.
DatawindowChild	dwIdDepts		// DDDW des sous départements.
DataWindowChild	dwCodNivOpe		// DDDW le code niveau opérateur.
DataWindowChild	dwIdCorb			// DDDW de la corbeille.
DataWindowChild	dwCodRgptStat	// DDDW des codes de regroupement des stats.
DataWindowChild	dwModReg			// DDDW des modes de règlement.
DataWindowChild	dwDestReg		// DDDW des destinataires de règlement.
DataWindowChild	dwCodadh			// DDDW des modes d'adhésion.
DataWindowChild	dwPolice			// DDDW des polices.

DataWindowChild	dwChild
//Migration PB8-WYNIWYG-03/2006 FM
//DataWindow			dwPassageEuro[1]
DataWindow			dwPassageEuro[]
//Fin Migration PB8-WYNIWYG-03/2006 FM
String				sCol [ 5 ]		// Tableau contenant les champs dont 
											// l'attribut 'protect' peut être modifié
String   			sMod				// Chaine construite pour le Modify

// #1
This.Wf_PositionnerObjets ()

// #4
If stGLB.bSaiValEdt Then
	dw_1.Modify ( "alt_ouvfenval.visible = '0'" )
Else 
	dw_1.Modify ( "alt_ouvfenval.visible = '1'" )
End If

/*------------------------------------------------------------------*/
/* Création et Initialisation de l'UO de contrôle de gestion et de  */
/* saisie       																	  */
/*------------------------------------------------------------------*/
iuoGsProduit	= Create u_sp_gs_Produit
iuoGsProduit.uf_initialisation	( itrTrans, Dw_1 )

iuoZnProduit	= Create u_sp_zn_Produit
iuoZnProduit.uf_initialisation	( itrTrans, Dw_1 )

iuoGsCourrier	= Create u_sp_gs_Courrier

// #6
//iuoGsCourrier.Uf_Initialisation	( itrTrans, Uo_Courrier )
iuoGsCourrier.Uf_Initialisation	( itrTrans, Uo_Courrier, Dw_Paragraphes )
// FIN - #6

iuoGsParaInfo	= Create u_sp_gs_ParaInfo
iuoGsParaInfo.Uf_Initialisation	( itrTrans, Uo_Info )

iuoGsRevProd	= Create u_sp_gs_Rev_Prod
iuoGsRevProd.Uf_Initialisation	( itrTrans, Dw_Lst_Rev )

iuoGsCodeCondition	= Create u_sp_gs_Code_Condition
iuoGsCodeCondition.Uf_Initialisation ( itrTrans, Dw_CodCon )

iuoGsCodeGarantie		= Create u_sp_gs_Code_Garantie
iuoGsCodeGarantie.Uf_Initialisation	( itrTrans, Uo_Garantie, Dw_Pieces, &
												  Dw_Refus, Dw_CodCon )

iuoGsEts					= Create u_sp_gs_Ets
iuoGsEts.Uf_Initialisation		( Uo_Ets.Dw_Source, uo_Ets.Dw_Cible, Dw_LstGrp, itrTrans )

iuoGsRelances	= Create u_sp_gs_Relances

/*------------------------------------------------------------------*/
/* Initialisation des Dw liés à la gestion des garanties du produit */
/*------------------------------------------------------------------*/
Dw_Pieces.uf_SetTransObject 	( itrTrans )
Dw_Pieces.isTri	=	"CPT_TRI A"
Dw_Refus.uf_SetTransObject  	( itrTrans )
Dw_Refus.isTri		=	"CPT_TRI A"
Dw_Codcon.uf_SetTransObject 	( itrTrans )
Dw_Code.uf_SetTransObject   	( itrTrans )

Dw_1.Uf_SetTransObject 			( itrTrans )

// #6
Dw_Paragraphes.uf_SetTransObject  	( itrTrans )
Dw_Paragraphes.isTri		=	"ID_ORDRE A"

ids_paragraphe = create datastore
ids_paragraphe.dataobject = 'd_sp_compo_cour_prod'
 ids_paragraphe.settrans( itrTrans )
// FIN - #6

/*------------------------------------------------------------------*/
/* Initialisation des champs dont la couleur changera en fonction   */
/* de la protection                                                 */
/*------------------------------------------------------------------*/
sCol [ 1 ] 			= "ID_PROD"
sCol [ 2 ] 			= "ID_GRP"
sCol [ 3 ] 			= "NB_ADHERENT"
sCol [ 4 ] 			= "DUR_PERRNV_ADH"
sCol [ 5 ] 			= "UNT_PERRNV_ADH"

Dw_1.Uf_InitialiserCouleur ( sCol )

/*------------------------------------------------------------------*/
/* Initialisation des DDDW nécessitant un argument ou un partage de */
/* boeuf'heur.                                                      */
/*------------------------------------------------------------------*/
Dw_1.GetChild ( "ID_DEPT"  		, dwIdDept  	)
Dw_1.GetChild ( "ID_DEPTS" 		, dwIdDepts 	)
Dw_1.GetChild ( "ID_CORB"			, dwIDCorb 		)
Dw_1.GetChild ( "COD_NIV_OPE"		, dwCodNivOpe 	)
Dw_1.GetChild ( "COD_MODE_REG"	, dwModReg	 	)
Dw_1.GetChild ( "COD_DEST_REG"	, dwDestReg	 	)
Dw_1.GetChild ( "COD_ADH"			, dwCodAdh	 	)
Dw_1.GetChild ( "ID_POLICE"		, dwPolice	 	)

dwIdDept.SetFilter ( "RIGHT(STRING(ID_DEPT),1)='0'" )
dwIdDept.Filter ( )

dwIdCorb.SetTransObject ( iTrTrans )
If ( 	dwIdCorb.Retrieve  ( "-CO" ) <=0 ) Then
		dwIdCorb.InsertRow ( 0     )
End If

dwCodNivOpe.SetTransObject ( iTrTrans )
If ( 	dwCodNivOpe.Retrieve  ( "-NO" ) <=0 ) Then
		dwCodNivOpe.InsertRow ( 0     )
End If

dwModReg.SetTransObject ( iTrTrans )
If ( 	dwModReg.Retrieve  ( "-MR" ) <=0 ) Then
		dwModReg.InsertRow ( 0     )
End If

dwDestReg.SetTransObject ( iTrTrans )
If ( 	dwDestReg.Retrieve  ( "-IN" ) <=0 ) Then
		dwDestReg.InsertRow ( 0     )
End If

dwCodAdh.SetTransObject ( iTrTrans )
If ( 	dwCodAdh.Retrieve  ( "-MA" ) <=0 ) Then
		dwCodAdh.InsertRow ( 0     )
End If

/*------------------------------------------------------------------*/
/* Prise en compte de la gestion du format de la monnaie dans les   */
/* courriers.                                                       */
/*------------------------------------------------------------------*/
dw_1.GetChild ( "COD_EURO"		, dwChild )
dwChild.SetTransObject ( itrTrans )
dwChild.Retrieve ( "-EU" )

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet                                       */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_Initialiser ( 6, 1 )

Uo_Onglets.Uf_EnregistrerOnglet ( "01", "Produit"				, "", Dw_1       , False )
Uo_Onglets.Uf_EnregistrerOnglet ( "02", "Courriers"			, "", Uo_Onglets3, False )
Uo_Onglets.Uf_EnregistrerOnglet ( "03", "Infos Courriers"	, "", Uo_Info		, False )
Uo_Onglets.Uf_EnregistrerOnglet ( "04", "Gar./Cond." 			, "", Uo_Onglets2, False )
Uo_Onglets.Uf_EnregistrerOnglet ( "05", "Etablissement"		, "", Uo_Ets     , False )
Uo_Onglets.Uf_EnregistrerOnglet ( "06", "Révisions"			, "", Dw_Lst_Rev , False )

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet 2                                     */
/*------------------------------------------------------------------*/
Uo_Onglets2.Uf_Initialiser ( 4, 2 )

Uo_Onglets2.Uf_EnregistrerOnglet ( "01", "Garanties"       , "", Uo_Garantie, False )
Uo_Onglets2.Uf_EnregistrerOnglet ( "02", "Natures"         , "", Uo_CodCon, 	False )
Uo_Onglets2.Uf_EnregistrerOnglet ( "03", "Territorialités" , "", Uo_CodCon, 	False )
Uo_Onglets2.Uf_EnregistrerOnglet ( "04", "Détails"         , "", Uo_CodCon, 	False )

/*------------------------------------------------------------------*/
/* #2 Initialisation de l'onglet 3 (pour les relances)              */
/*------------------------------------------------------------------*/
Uo_Onglets3.Uf_Initialiser ( 2, 3 )

Uo_Onglets3.Uf_EnregistrerOnglet ( "01", "Courriers"       , "", Uo_Courrier, False )
Uo_Onglets3.Uf_EnregistrerOnglet ( "02", "Relances"        , "", Dw_Relances,  False )

/*------------------------------------------------------------------*/
/* Affection des Dataobjet aux Dw de l'objet concernant les         */
/* courriers                                                        */
/*------------------------------------------------------------------*/

Uo_Courrier.Uf_Initialiser ( "d_sp_lst_cour_rch", "d_sp_prod_cour", "d_sp_lst_cour", itrTrans )

/*------------------------------------------------------------------*/
/* Affection des Dataobjet aux Dw de l'objet concernant les         */
/* paragraphes d'informations du produit.                           */
/*------------------------------------------------------------------*/
Uo_Info.Uf_Initialiser ( "d_sp_lst_par_rch", "d_sp_prod_para", "d_sp_lst_par", itrTrans )

/*------------------------------------------------------------------*/
/* Affection des Dataobjet aux Dw de l'objet concernant les codes   */
/* garanties du produit.                                            */
/*------------------------------------------------------------------*/
Uo_Garantie.Uf_Initialiser ( "d_sp_lst_cod_gar_rch", "d_sp_prod_gar", "d_sp_lst_cod_gar", itrTrans )

/*------------------------------------------------------------------*/
/* Gestion du Passage à l'EURO.                                     */
/*------------------------------------------------------------------*/
N_Cst_Passage_Euro	nvPassageEuro

dwPassageEuro [ 1 ] = uo_Garantie.dw_Source

nvPassageEuro = CREATE N_Cst_Passage_Euro
nvPassageEuro.uf_Initialiser ( dwPassageEuro[] )

DESTROY nvPassageEuro

/*------------------------------------------------------------------*/
/* Affection des Dataobjet aux Dw de l'objet : recherche, source,   */
/* cible.                                                           */
/*------------------------------------------------------------------*/
Uo_CodCon.Uf_Initialiser ( "d_sp_lst_cod_con_rch", "d_sp_prod_codcon", "d_sp_lst_cod_con", itrTrans )

/*------------------------------------------------------------------*/
/* Renseigne les Datawindows des l'objets contenus/contenants       */
/*------------------------------------------------------------------*/
dw_Code.ShareData   ( Uo_CodCon.dw_Recherche )
dw_CodCon.ShareData ( Uo_CodCon.dw_Source    )

/*----------------------------------------------------------------------------*/
/* Comme aucun InsertRow n'est réalisé sur la Dw Source la DdDw des codes de  */
/* regroupement des stats n'est pas renseignée automatiquement d'ou le        */
/* Retrieve.                                                                  */
/*----------------------------------------------------------------------------*/
Uo_Garantie.Dw_Source.GetChild ( "COD_RGPT_STAT", dwCodRgptStat )
dwCodRgptStat.SetTransObject   ( itrTrans )
If ( 	dwCodRgptStat.Retrieve   ( "-GS"    ) <= 0 ) Then

		dwCodRgptStat.InsertRow  ( 0        )

End If

/*------------------------------------------------------------------*/
/* Affection des Dataobjet aux Dw de l'objet concernant les Ets     */
/* du produit.                                                      */
/*------------------------------------------------------------------*/
Uo_Ets.Uf_Initialiser ( "d_sp_lst_ets_rch", "d_sp_prod_ets", "d_sp_lst_ets", itrTrans )

/*------------------------------------------------------------------*/
/* Initialisation de la Dw liée à la gestion des Ets du produit     */
/*------------------------------------------------------------------*/
/* Dw_LstGrp contient la liste des groupes associés aux contractants*/
/*    et qui ne font pas partie de la liste des ets du produit      */
/* Dw_ProdEts contient la table etablissement pour le produit		  */
/*------------------------------------------------------------------*/

Dw_LstGrp.uf_SetTransObject  ( itrTrans )

Dw_LstGrp.ShareData ( uo_Ets.Dw_Cible )

//*------------------------------------------------------------------*/
//* Description de la DW dynamique pour les révisions.               */
//* Les colonnes MAJ_LE et MAJ_PAR de la Dw dynamique des révisions  */
//*ne doivent pas être définies comme clés.                          */
//*------------------------------------------------------------------*/

Dw_Lst_Rev.istCol [ 1 ].sDbName			=	"revision.id_prod"
Dw_Lst_Rev.istCol [ 1 ].sResultSet		=	"id_prod"
Dw_Lst_Rev.istCol [ 1 ].sType				=	"decimal(0)"
Dw_Lst_Rev.istCol [ 1 ].sInvisible		= 	"O"
Dw_Lst_Rev.istCol [ 1 ].sUpdate			= 	"O"
Dw_Lst_Rev.istCol [ 1 ].sCle				= 	"O"

Dw_Lst_Rev.istCol [ 2 ].sDbName			=	"revision.id_rev"
Dw_Lst_Rev.istCol [ 2 ].sResultSet		=	"id_rev"
Dw_Lst_Rev.istCol [ 2 ].sType				=	"decimal(0)"
Dw_Lst_Rev.istCol [ 2 ].sHeaderName		=	"Rév"
Dw_Lst_Rev.istCol [ 2 ].ilargeur			=	3
Dw_Lst_Rev.istCol [ 2 ].sAlignement		=	"2"
Dw_Lst_Rev.istCol [ 2 ].sInvisible		= 	"N"
Dw_Lst_Rev.istCol [ 2 ].sUpdate			= 	"O"
Dw_Lst_Rev.istCol [ 2 ].sCle				= 	"O"

Dw_Lst_Rev.istCol [ 3 ].sDbName			=	"revision.lib_rev"
Dw_Lst_Rev.istCol [ 3 ].sResultSet		=	"lib_rev"
Dw_Lst_Rev.istCol [ 3 ].sType				=	"char(35)"
Dw_Lst_Rev.istCol [ 3 ].sHeaderName		=	"Libellé"
Dw_Lst_Rev.istCol [ 3 ].ilargeur			=	17
Dw_Lst_Rev.istCol [ 3 ].sAlignement		=	"0"
Dw_Lst_Rev.istCol [ 3 ].sInvisible		= 	"N"
Dw_Lst_Rev.istCol [ 3 ].sUpdate			= 	"O"
Dw_Lst_Rev.istCol [ 3 ].sCle				= 	"N"

Dw_Lst_Rev.istCol [ 4 ].sDbName			=	"revision.cod_eff_rev"
Dw_Lst_Rev.istCol [ 4 ].sResultSet		=	"cod_eff_rev"
Dw_Lst_Rev.istCol [ 4 ].sType				=	"char(20)"
Dw_Lst_Rev.istCol [ 4 ].sHeaderName		=	"Zone Effet"
Dw_Lst_Rev.istCol [ 4 ].ilargeur			=	14
Dw_Lst_Rev.istCol [ 4 ].sValues			=	"Survenance	DTE_SURV/Souscription	DTE_SOUS/Renouvellement	DTE_RNV"
Dw_Lst_Rev.istCol [ 4 ].sInvisible		= 	"N"
Dw_Lst_Rev.istCol [ 4 ].sUpdate			= 	"O"
Dw_Lst_Rev.istCol [ 4 ].sCle				= 	"N"

Dw_Lst_Rev.istCol [ 5 ].sDbName			=	"revision.dte_eff"
Dw_Lst_Rev.istCol [ 5 ].sResultSet		=	"dte_eff"
// [MIGPB8COR_PHG]
//Dw_Lst_Rev.istCol [ 5 ].sType				=	"date"
// remplace par
Dw_Lst_Rev.istCol [ 5 ].sType				=	"datetime"

Dw_Lst_Rev.istCol [ 5 ].sHeaderName		=	"Début d'effet"
Dw_Lst_Rev.istCol [ 5 ].sFormat			=	"dd/mm/yyyy"
Dw_Lst_Rev.istCol [ 5 ].ilargeur			=	9
Dw_Lst_Rev.istCol [ 5 ].sInvisible		= 	"N"
Dw_Lst_Rev.istCol [ 5 ].sAlignement		=	"2"
Dw_Lst_Rev.istCol [ 5 ].sUpdate			= 	"O"
Dw_Lst_Rev.istCol [ 5 ].sCle				= 	"N"

Dw_Lst_Rev.istCol [ 6 ].sDbName			=	"revision.dte_fin"
Dw_Lst_Rev.istCol [ 6 ].sResultSet		=	"dte_fin"
// [MIGPB8COR_PHG]
// Dw_Lst_Rev.istCol [ 6 ].sType				=	"date"
Dw_Lst_Rev.istCol [ 6 ].sType				=	"datetime"

Dw_Lst_Rev.istCol [ 6 ].sHeaderName		=	"Fin d'effet"
Dw_Lst_Rev.istCol [ 6 ].sFormat			=	"dd/mm/yyyy"
Dw_Lst_Rev.istCol [ 6 ].ilargeur			=	9
Dw_Lst_Rev.istCol [ 6 ].sInvisible		= 	"N"
Dw_Lst_Rev.istCol [ 6 ].sAlignement		=	"2"
Dw_Lst_Rev.istCol [ 6 ].sUpdate			= 	"O"
Dw_Lst_Rev.istCol [ 6 ].sCle				= 	"N"

Dw_Lst_Rev.istCol [ 7 ].sDbName			=	"revision.cree_le"
Dw_Lst_Rev.istCol [ 7 ].sResultSet		=	"cree_le"
Dw_Lst_Rev.istCol [ 7 ].sType				=	"datetime"
Dw_Lst_Rev.istCol [ 7 ].sInvisible		= 	"O"
Dw_Lst_Rev.istCol [ 7 ].sUpdate			= 	"O"
Dw_Lst_Rev.istCol [ 7 ].sCle				= 	"N"

Dw_Lst_Rev.istCol [ 8 ].sDbName			=	"revision.maj_le"
Dw_Lst_Rev.istCol [ 8 ].sResultSet		=	"maj_le"
Dw_Lst_Rev.istCol [ 8 ].sType				=	"datetime"
Dw_Lst_Rev.istCol [ 8 ].sHeaderName		=	"Mis à jour le"
Dw_Lst_Rev.istCol [ 8 ].sFormat			=	"dd/mm/yyyy"
Dw_Lst_Rev.istCol [ 8 ].ilargeur			=	9
Dw_Lst_Rev.istCol [ 8 ].sAlignement		=	"2"
Dw_Lst_Rev.istCol [ 8 ].sInvisible		= 	"N"
Dw_Lst_Rev.istCol [ 8 ].sUpdate			= 	"O"
Dw_Lst_Rev.istCol [ 8 ].sCle				= 	"N"

Dw_Lst_Rev.istCol [ 9 ].sDbName			=	"revision.maj_par"
Dw_Lst_Rev.istCol [ 9 ].sResultSet		=	"maj_par"
Dw_Lst_Rev.istCol [ 9 ].sType				=	"char(4)"
Dw_Lst_Rev.istCol [ 9 ].sHeaderName		=	"Par"
Dw_Lst_Rev.istCol [ 9 ].ilargeur			=	4
Dw_Lst_Rev.istCol [ 9 ].sAlignement		=	"2"
Dw_Lst_Rev.istCol [ 9 ].sInvisible		= 	"N"
Dw_Lst_Rev.istCol [ 9 ].sUpdate			= 	"O"
Dw_Lst_Rev.istCol [ 9 ].sCle				= 	"N"

Dw_Lst_Rev.istCol [ 10 ].sDbName			=	"revision.maj_par"
Dw_Lst_Rev.istCol [ 10 ].sResultSet		=	"alt_duplic"
// [MIGPB8COR_PHG]
// Dw_Lst_Rev.istCol [ 10 ].sType			=	"char(1)"
// remplace par
Dw_Lst_Rev.istCol [ 10 ].sType			=	"char(4)"

Dw_Lst_Rev.istCol [ 10 ].sInvisible		= 	"O"
Dw_Lst_Rev.istCol [ 10 ].sUpdate			= 	"N"
Dw_Lst_Rev.istCol [ 10 ].sCle				= 	"N"


sTables [ 1 ]	= "revision"

/*------------------------------------------------------------------*/
/* Création de la Data Window de detail                             */
/*------------------------------------------------------------------*/
Dw_Lst_Rev.Uf_Creer_Tout ( Dw_Lst_Rev.istCol, sTables, itrTrans )

/*------------------------------------------------------------------*/
/* donne les droit d'update à la Dw Dynamique de détail.            */
/*------------------------------------------------------------------*/
Dw_Lst_Rev.Uf_AutoriserUpdate ( "revision" )


/*------------------------------------------------------------------*/
/* La Dw sera triée en fonction du N° de revision                   */
/*------------------------------------------------------------------*/
Dw_Lst_Rev.isTri = "#2 A"

/*------------------------------------------------------------------*/
/* La première ligne est sélectionnée par défaut.                   */
/*------------------------------------------------------------------*/
Dw_Lst_Rev.Uf_Activer_Selection ( True )

/*------------------------------------------------------------------*/
/* Le curseur de la liste des révisions indique que l'on peut       */
/* appeler une fenetre par double click.                            */
/*------------------------------------------------------------------*/
sMod	=	"DataWindow.Pointer='K:\PB4OBJ\BMP\DBLCLICK.CUR'"
Dw_Lst_Rev.Modify ( sMod )

/*------------------------------------------------------------------*/
/* Initialisation de la révision à -1 pour les pieces et les refus. */
/*------------------------------------------------------------------*/
idcIdRev = -1


/*------------------------------------------------------------------*/
/* #3 : Initialisation de Dw_Relances.                              */
/*------------------------------------------------------------------*/

iuoGsRelances.Uf_Initialiser ( Dw_Relances, Dw_1 )


/*------------------------------------------------------------------*/
/* #5 Chargement de la datawindow contenant les groupes             */
/*    et grp prod sherpa                                            */
/*------------------------------------------------------------------*/
dw_lst_grp_grpsherpa.SetTransObject ( itrTrans )
dw_lst_grp_grpsherpa.Retrieve ()

// [PM407-1]
dw_det_pro.SetTransObject ( itrTrans )
end event

event we_childactivate;call super::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Produit::We_ChildActivate
//* Evenement 		: We_ChildActivate
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:53:35
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.X			=    1
This.Y			=    1
// [PB2022_TAILLE_FEN] + xxx
This.Height		= 1769 + 90


// [PB2022_TAILLE_FEN] + xxx
This.Width		= 3598 + 50

end event

on ue_controler;//*-----------------------------------------------------------------
//*
//* Objet 			: w_tm_sp_produit (OVERRIDE)
//* Evenement 		: ue_Controler
//* Auteur			: Fabry JF
//* Date				: 11/06/1999 09:00:31
//* Libellé			: Controle de la saisie
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	Dw_1.AcceptText () > 0 Then

	If Dw_Relances.AcceptText () > 0 Then

		If wf_AcceptText() Then
			wf_Controler ()
		End If
	
	Else 
		Dw_Relances.SetFocus ()
	End If

Else
	Dw_1.SetFocus ()
End If
end on

on ue_creer;call w_8_traitement_master::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_Tm_sp_Produit
//* Evenement 		:	Ue_Creer
//* Auteur			:	N°6
//* Date				:	20/06/1997 14:10:54
//* Libellé			:	Ouvre la fenêtre de traitement du détail pour la
//*					 	création d'un détail.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_pass			stPass

Decimal{ 0 }	dcIdRev	// Révision courante du produit.

stPass = istPass

Choose Case isDetailActif

	Case "dw_lst_rev"

			SetPointer ( HourGlass! )

			dcIdRev = 	Max ( dw_1.GetItemNumber ( 1, "COD_REV_SURV" ), &
							Max ( dw_1.GetItemNumber ( 1, "COD_REV_SOUS" ), &
									dw_1.GetItemNumber ( 1, "COD_REV_RNV"  ) ) )

			stPass.bInsert     = True
			stPass.bControl	 = True

			stPass.sTab [ 1 ]  = String ( idcIdProd )
			stPass.sTab [ 2 ]  = String ( dcIdRev )
			stPass.sTab [ 3 ]  = String ( dcIdRev + 1 )

			stPass.dwTab [ 1 ] = Dw_Lst_Rev

			stPass.dwNorm[ 1 ] = Uo_Ets.Dw_Source
			stPass.dwNorm[ 2 ] = Uo_Ets.Dw_Cible
			stPass.dwNorm[ 3 ] = Dw_LstGrp

			f_OuvreTraitement ( W_Td_sp_Revision, stPass )

End Choose
end on

on ue_modifier;call w_8_traitement_master::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_Tm_sp_Produit
//* Evenement 		:	Ue_Modifier
//* Auteur			:	N°6
//* Date				:	20/06/1997 14:10:00
//* Libellé			:	Ouvre la fenêtre de traitement du détail pour modifier
//*					 	un détail.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass	stPass

stPass = istPass

Choose Case isDetailActif

	Case "dw_lst_rev"

			SetPointer ( HourGlass! )

			stPass.bInsert     = False
			stPass.bControl	 = True

			stPass.sTab [ 1 ]  = String ( idcIdProd )


			stPass.sTab [ 2 ]  = String ( Max ( dw_1.GetItemNumber ( 1, "COD_REV_SURV" ), &
														Max ( dw_1.GetItemNumber ( 1, "COD_REV_SOUS" ), &
																dw_1.GetItemNumber ( 1, "COD_REV_RNV" ) ) ) )

			stPass.sTab [ 3 ]  = String ( Dw_Lst_Rev.GetItemNumber ( Dw_Lst_Rev.ilLigneClick, "ID_REV" ) )

			stPass.dwTab [ 1 ] = dw_lst_rev

			stPass.dwNorm[ 1 ] = Uo_Ets.Dw_Source
			stPass.dwNorm[ 2 ] = Uo_Ets.Dw_Cible
			stPass.dwNorm[ 3 ] = Dw_LstGrp

			f_OuvreTraitement ( W_Td_sp_Revision, stPass )

End Choose
end on

on ue_retour;call w_8_traitement_master::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_tm_sp_produit
//* Evenement 		:	Ue_Retour
//* Auteur			:	N°6
//* Date				:	30/07/1997 10:04:55
//* Libellé			:	Opérations à effectuer à la fermeture de la 
//*					 	fenêtre.
//* Commentaires	: Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Ferme la fenêtre de visualisation des paragraphes si elle est    */
/* ouverte et cachée.                                               */
/*------------------------------------------------------------------*/
If IsValid ( W_Consulter_Paragraphe )	Then

	Close ( W_Consulter_Paragraphe )

End If
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_tm_sp_produit
//* Evenement 		:	Close
//* Auteur			:	N°6
//* Date				:	20/06/1997 14:09:55
//* Libellé			:	Opérations à effectuer à la fermeture de la 
//*					 	fenêtre.
//* Commentaires	: Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Destruction du User Object de contrôle de gestion et de saisie   */
/* pour le paramétrage des produits                                 */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Destroy	iuoGsProduit
//Destroy	iuoZnProduit
//Destroy	iuoGsCourrier
//Destroy	iuoGsParaInfo
//Destroy	iuoGsCodeGarantie
//Destroy	iuoGsCodeCondition
//Destroy	iuoGsEts
//Destroy	iuoGsRevProd
//Destroy	iuoGsRelances
If IsValid(iuoGsProduit) Then Destroy	iuoGsProduit
If IsValid(iuoZnProduit) Then Destroy	iuoZnProduit
If IsValid(iuoGsCourrier) Then Destroy	iuoGsCourrier
If IsValid(iuoGsParaInfo) Then Destroy	iuoGsParaInfo
If IsValid(iuoGsCodeGarantie) Then Destroy	iuoGsCodeGarantie
If IsValid(iuoGsCodeCondition) Then Destroy	iuoGsCodeCondition
If IsValid(iuoGsEts) Then Destroy	iuoGsEts
If IsValid(iuoGsRevProd) Then Destroy	iuoGsRevProd
If IsValid(iuoGsRelances) Then Destroy	iuoGsRelances
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Ferme la fenêtre de visualisation des paragraphes si elle est    */
/* ouverte et cachée.                                               */
/*------------------------------------------------------------------*/
If IsValid ( W_Consulter_Paragraphe )	Then

	Close ( W_Consulter_Paragraphe )

End If
end event

on ue_majaccueil;call w_8_traitement_master::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_tm_sp_produit
//* Evenement 		:	UE_MAJACCUEIL - Extend
//* Auteur			:	N°6
//* Date				:	20/06/1997 14:16:37
//* Libellé			:	Construction de la chaîne pour mettre à jour la 
//*					 	fenêtre d'accueil.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 				sTab			  // Code tabulation
String				sMajLe		  // Variable tampon pour MAJ_LE
String				sIdProd		  // Variable tampon pour ID_PROD
String   			sLibDept      // Libellé du département
String            sIdDept       // Identifiant du département

Long              lNumLigneDept // No de ligne du département dans la DDDW

DatawindowChild 	dwIdDept		  // DataWindowChild du département


sTab				=	"~t"

sMajLe			=	String ( dw_1.GetItemDateTime ( 1, "MAJ_LE"  ), "dd/mm/yyyy hh:mm:ss" )
sIdProd			=	String ( dw_1.GetItemNumber   ( 1, "ID_PROD" ) )

/*------------------------------------------------------------------*/
/* Recherche du libellé du département dans la DDDW.                */
/*------------------------------------------------------------------*/

Dw_1.GetChild ( "ID_DEPT", dwIdDept )

sIdDept        =	String ( dw_1.GetItemNumber ( 1, "ID_DEPT"  ) )

lNumLigneDept  =	dwIdDept.Find 				( "ID_DEPT = " + sIdDept , 1, dwIdDept.RowCount() )

sLibDept       =	dwIdDept.GetItemString 	( lNumLigneDept, "LIB_DEPT" )


isMajAccueil 	=	sIdProd 											+ sTab + &
 						dw_1.GetItemString ( 1, "LIB_LONG" )	+ sTab + &
						sLibDept											+ sTab + &
						sMajLe								 			+ sTab + &
						dw_1.GetItemString ( 1, "MAJ_PAR"  )

end on

on w_tm_sp_produit.create
int iCurrent
call super::create
this.dw_pieces=create dw_pieces
this.dw_refus=create dw_refus
this.dw_codcon=create dw_codcon
this.dw_code=create dw_code
this.uo_onglets=create uo_onglets
this.dw_lstgrp=create dw_lstgrp
this.uo_bord3d=create uo_bord3d
this.uo_onglets2=create uo_onglets2
this.dw_lst_rev=create dw_lst_rev
this.uo_codcon=create uo_codcon
this.uo_bord3d2=create uo_bord3d2
this.uo_garantie=create uo_garantie
this.uo_courrier=create uo_courrier
this.uo_ets=create uo_ets
this.uo_info=create uo_info
this.uo_onglets3=create uo_onglets3
this.uo_bord3d3=create uo_bord3d3
this.dw_relances=create dw_relances
this.dw_lst_grp_grpsherpa=create dw_lst_grp_grpsherpa
this.dw_paragraphes=create dw_paragraphes
this.dw_det_pro=create dw_det_pro
this.uo_relance_pm407_1=create uo_relance_pm407_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pieces
this.Control[iCurrent+2]=this.dw_refus
this.Control[iCurrent+3]=this.dw_codcon
this.Control[iCurrent+4]=this.dw_code
this.Control[iCurrent+5]=this.uo_onglets
this.Control[iCurrent+6]=this.dw_lstgrp
this.Control[iCurrent+7]=this.uo_bord3d
this.Control[iCurrent+8]=this.uo_onglets2
this.Control[iCurrent+9]=this.dw_lst_rev
this.Control[iCurrent+10]=this.uo_codcon
this.Control[iCurrent+11]=this.uo_bord3d2
this.Control[iCurrent+12]=this.uo_garantie
this.Control[iCurrent+13]=this.uo_courrier
this.Control[iCurrent+14]=this.uo_ets
this.Control[iCurrent+15]=this.uo_info
this.Control[iCurrent+16]=this.uo_onglets3
this.Control[iCurrent+17]=this.uo_bord3d3
this.Control[iCurrent+18]=this.dw_relances
this.Control[iCurrent+19]=this.dw_lst_grp_grpsherpa
this.Control[iCurrent+20]=this.dw_paragraphes
this.Control[iCurrent+21]=this.dw_det_pro
this.Control[iCurrent+22]=this.uo_relance_pm407_1
end on

on w_tm_sp_produit.destroy
call super::destroy
destroy(this.dw_pieces)
destroy(this.dw_refus)
destroy(this.dw_codcon)
destroy(this.dw_code)
destroy(this.uo_onglets)
destroy(this.dw_lstgrp)
destroy(this.uo_bord3d)
destroy(this.uo_onglets2)
destroy(this.dw_lst_rev)
destroy(this.uo_codcon)
destroy(this.uo_bord3d2)
destroy(this.uo_garantie)
destroy(this.uo_courrier)
destroy(this.uo_ets)
destroy(this.uo_info)
destroy(this.uo_onglets3)
destroy(this.uo_bord3d3)
destroy(this.dw_relances)
destroy(this.dw_lst_grp_grpsherpa)
destroy(this.dw_paragraphes)
destroy(this.dw_det_pro)
destroy(this.uo_relance_pm407_1)
end on

type cb_debug from w_8_traitement_master`cb_debug within w_tm_sp_produit
end type

type dw_1 from w_8_traitement_master`dw_1 within w_tm_sp_produit
integer x = 480
integer y = 1412
integer width = 288
integer height = 128
integer taborder = 40
string dataobject = "d_sp_produit"
boolean border = false
end type

event dw_1::sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_1
//* Evenement 		:	SQLPREVIEW
//* Auteur			:	N°6
//* Date				:	20/06/1997 15:30:25
//* Libellé			:	Modification du SqlPreview de la datawindow Dw_1
//*					 	dans le cas de l'insertion d'un nouveau produit.
//*
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//* DCMP990023	JFF		21/05/99	Ajout de la zone ALT_INFO_PROV			  
//* #1			JFF		01/06/99 Ajout des colonnes soncernant les relances, sur l'Insert
//* #2			JFF		24/04/01 CONTACTDNT : Gestion contact client
//* #3			CAG		22/07/02 Dev SFR PREFERENCE : ajout des colonnes AltCodBoutique et IdProdClient
//* #4			CAG		15/11/02	Bug sur alt_crbq_dms non initialisé
//*-----------------------------------------------------------------

String		sSqlPreview			// SqlPreview de la datawindow Dw_1.
String		sLibCourt			// Libellé court du produit.
String		sLibLong				// Libellé long du produit.
String		sUntPerrNvAdh		// Unité de la duré de la période.
String		sCodModeReg			// Type de réglement.
String		sLibBqDebit			// libellé de la banque à débiter.
String		sRibBq				// Rib de la banque.
String		sRibGui				// Rib du guichet.
String		sRibCpt				// Rib du compte.
String		sRibCle				// Rib de la clé.
String		sCodDestReg			// Destinataire réglement.
String		sCodAdh				// Type adhésion.
String		sNumTel				// N° de téléphone.
String		sNumFax				// N° de fax.
String		sMajPar				// Auteur de la mise à jour.
String		sTable				// Nom de la table à tracer.
String		sType					// Type d'action effectuer sur la table.
String		sAltCreBqDms		// Création Automatique interlocuteur Banque Base DMS
String		sAltInfoProv  		// DCMP990023 : Montant de provision obligatoire
// #1
String		sAltRl1				// Indique si le produit prévoit des 1ères relances
String		sUntRl1				// Unité associée à dcDurRl1(min&max) (jours ou mois)
String		sAltRl2				// Indique si le produit prévoit des 2èmes relances
String		sUntRl2				// Unité associée à dcDurRl2 (jours ou mois)
String		sAltSold				// Indique si le produit prévoit du soldage de dossiers
String		sUntSoldRl			// Unité associée à dcDurSoldRl (jours ou mois)
String		sUntSoldPc			// Unité associée à dcDurSoldPc (jours ou mois)
// #2
String		sAltContact			// O/N Le produit gère les contacts client.
String		sAltOuvFenVal		// O/N Le produit gère l'ouverture de la fenêtre de validation si pas de courriers.
String		sAltCmdMobile		// O/N Le produit gère Les commandes de mobiles
// #3
String		sAltCodBoutique	// Y-a-t'il gestion d'un code boutique
String		sIdProdClient		// SFR : Nom du produit

String		sCle [ 1 ]			// Tableau de l'identifiant de l'enregistrement tracé.
//Migration PB8-WYNIWYG-03/2006 FM
//String		sCol [ 31 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 31 ]			// Tableau des valeurs des colonnes à tracer.
String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal []			// Tableau des valeurs des colonnes à tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM
Long			dcIdDept				// Identifiant du département.
Long			dcIdDepts			// Identifiant du sous département.
Long			dcIdGrp				// Identifiant du groupe.
Long			dcIdCorb				// Identifiant de la corbeille.
Long			dcCodRevSurv		// Identifiant de la révision ( survenance ).
Long			dcCodRevSous		// Identifiant de la révision.
Long			dcCodRevRnv			// Identifiant de la révision.
Long			dcCodNivOpe			// Niveau de l'opérateur.
Long			dcDurPerrnvAdh		// Duré de la période
Long			dcIdPolice			// Identifiant de la police.
Long			dcCodBaseDms		// Base DMS à utiliser
Long			dcCodAdrDms			// Méthode de gestion des adresses DMS
Long			dcCodProdDms		// Code produit de la base DMS
Long			dcNbAdherent		// Nombre maximum d'adhérent sur une adhésion
Long			dcCodEuro			// Gestion du format de la monnaie
// #1
Long			dcDurRl1Min			// Donne le délai minimal en jours ou en mois pour les 1ères relances, à partir de la date du jour
Long			dcDurRl1Max			// Donne le délai maximal en jours ou en mois pour les 1ères relances, à partir de la date du jour
Long			dcDurRl2				// Donne le délai en jours ou en mois pour les 2èmes relances, à partir de la première relance.
Long			dcDurSoldRl			// Donne le délai en jours ou en mois pour le soldage des dossiers à partir de la deuxième relance. 
Long			dcDurSoldPc			// Donne le délai en jours ou en mois pour le soldage des dossiers qui n'ont pas fait l'objet de relance.
Long			lCodTel				// Zone COD_TEL pour la gestion des produits de téléphonie.

DateTime		dtCreeLe
DateTime		dtMajLe

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

//Migration PB8-WYNIWYG-03/2006 FM
//sSqlPreview	= This.GetSQLPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM
/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "PRODUIT"

Choose Case Left ( sSqlPreview, 4 )

	Case	"INSE" 

		dcIdDept			= Dw_1.GetItemNumber   ( 1, "ID_DEPT"        )
		dcIdGrp			= Dw_1.GetItemNumber   ( 1, "ID_GRP"         )
		sLibCourt		= Dw_1.GetItemString   ( 1, "LIB_COURT"      )
		sLibLong			= Dw_1.GetItemString   ( 1, "LIB_LONG"       )
		dcCodRevSurv	= Dw_1.GetItemNumber   ( 1, "COD_REV_SURV"   )
		dcCodRevSous	= Dw_1.GetItemNumber   ( 1, "COD_REV_SOUS"   )
		dcCodNivOpe		= Dw_1.GetItemNumber   ( 1, "COD_NIV_OPE"    )
		dcCodRevRnv		= Dw_1.GetItemNumber   ( 1, "COD_REV_RNV"    )
		dcDurPerrnvAdh	= Dw_1.GetItemNumber   ( 1, "DUR_PERRNV_ADH" )
		sUntPerrnvAdh	= Dw_1.GetItemString   ( 1, "UNT_PERRNV_ADH" )
		sCodModeReg		= Dw_1.GetItemString   ( 1, "COD_MODE_REG"   )
		sLibBqDebit		= f_GetString ( Dw_1, 1, "LIB_BQ_DEBIT"	)
		sRibBq			= f_GetString ( Dw_1, 1, "RIB_BQ"  			)
		sRibGui			= f_GetString ( Dw_1, 1, "RIB_GUI"  		)
		sRibCpt			= f_GetString ( Dw_1, 1, "RIB_CPT"  		)
		sRibCle			= f_GetString ( Dw_1, 1, "RIB_CLE"  		)
		sCodDestReg		= Dw_1.GetItemString   ( 1, "COD_DEST_REG"   )
		sCodAdh			= Dw_1.GetItemString   ( 1, "COD_ADH"        )
		dcIdCorb			= Dw_1.GetItemNumber   ( 1, "ID_CORB"        )
		dcIdPolice		= Dw_1.GetItemNumber   ( 1, "ID_POLICE"      )
		sNumTel			= f_GetString ( Dw_1, 1, "NUM_TEL"  		)
		sNumFax			= f_GetString ( Dw_1, 1, "NUM_FAX"  		)
		dcIdDepts		= Dw_1.GetItemNumber   ( 1, "ID_DEPTS"       )
		dtCreele			= Dw_1.GetItemDateTime ( 1, "CREE_LE"        )
		dtMajLe			= Dw_1.GetItemDateTime ( 1, "MAJ_LE"         )
		sMajPar			= Dw_1.GetItemString   ( 1, "MAJ_PAR"        )

		dcCodBaseDms	= Dw_1.GetItemNumber   ( 1, "COD_BASE_DMS"   )
		dcCodAdrDms		= Dw_1.GetItemNumber   ( 1, "COD_ADR_DMS"    )
		dcCodProdDms	= Dw_1.GetItemNumber   ( 1, "COD_PROD_DMS"   )
		dcNbAdherent	= Dw_1.GetItemNumber   ( 1, "NB_ADHERENT"    )
// #4
		sAltCreBqDms	= f_GetString ( Dw_1, 1, "ALT_CREBQ_DMS"  )
		dcCodEuro		= Dw_1.GetItemNumber ( 1, "COD_EURO" )
		sAltInfoProv	= Dw_1.GetItemString ( 1, "ALT_INFO_PROV" )
// #1
		sAltRl1			= Dw_1.GetItemString ( 1, "ALT_RL1" )
		sUntRl1			= Dw_1.GetItemString ( 1, "UNT_RL1" )
		sAltRl2			= Dw_1.GetItemString ( 1, "ALT_RL2" )
		sUntRl2			= Dw_1.GetItemString ( 1, "UNT_RL2" )
		sAltSold			= Dw_1.GetItemString ( 1, "ALT_SOLD" )
		sUntSoldRl		= Dw_1.GetItemString ( 1, "UNT_SOLD_RL" )
		sUntSoldPc		= Dw_1.GetItemString ( 1, "UNT_SOLD_PC" )
		dcDurRl1Min		= Dw_1.GetItemNumber ( 1, "DUR_RL1_MIN" )
		dcDurRl1Max		= Dw_1.GetItemNumber ( 1, "DUR_RL1_MAX" )
		dcDurRl2			= Dw_1.GetItemNumber ( 1, "DUR_RL2" )
		dcDurSoldRl		= Dw_1.GetItemNumber ( 1, "DUR_SOLD_RL" )
		dcDurSoldPc		= Dw_1.GetItemNumber ( 1, "DUR_SOLD_PC" )

		sAltContact		= Dw_1.GetItemString ( 1, "ALT_CONTACT" )
		sAltOuvFenVal	= Dw_1.GetItemString ( 1, "ALT_OUVFENVAL" )
		lCodTel			= Dw_1.GetItemNumber ( 1, "COD_TEL" )
		sAltCmdMobile	= Dw_1.GetItemString ( 1, "ALT_CMD_MOBILE" )

// #3
		sAltCodBoutique= Dw_1.GetItemString ( 1, "ALT_COD_BOUTIQUE" )
		sIdProdClient	= f_GetString ( Dw_1, 1, "ID_PROD_CLIENT"	)

		itrTrans.DW_I01_PRODUIT (	idcIdProd      , &
											dcIdDept       , &
											dcIdGrp        , &
											sLibCourt      , &
											sLibLong       , &
											dcCodRevSurv   , &
											dcCodRevSous   , &
											dcCodRevRnv    , &
											dcCodNivOpe    , &
											dcDurPerrnvAdh , &
											sUntPerrnvAdh  , &
											sCodModeReg    , &
											sLibBqDebit    , &
											sRibBq         , &
											sRibGui        , &
											sRibCpt        , &
											sRibCle        , &
											sCodDestReg    , &
											sCodAdh        , &
											dcIdCorb       , &
											dcIdPolice     , &
											sNumTel        , &
											sNumFax        , &
											dcIdDepts      , &
											dcCodBaseDms   , &
											dcCodAdrDms	   , &
											dcCodProdDms   , &
											sAltCreBqDms   , &
											dcNbAdherent   , &
										 	dtCreeLe       , &
										 	dtMajLe        , &
										 	sMajPar        , &
											dcCodEuro	   , &
											sAltInfoProv   , &
											sAltRl1		   , &
											dcDurRl1Min	   , &											
											dcDurRl1Max	   , &
											sUntRl1		   , &
											sAltRl2		   , &
											dcDurRl2		   , &
											sUntRl2		   , &
											sAltSold		   , &
											dcDurSoldRl	   , &						
											sUntSoldRl	   , &
											dcDurSoldPc	   , &
											sUntSoldPc	   , &
											sAltContact	   , &
											lCodTel		   , &
											sAltOuvFenVal  , &
											sAltCmdMobile  , &
											sIdProdClient  , &
											sAltCodBoutique  &
										 )

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol  = { "ID_PROD", "ID_DEPT", "ID_ETS", "LIB_COURT", "LIB_LONG", &
					    "COD_REV_SURV", "COD_REV_SOUS", "COD_REV_RNV", "COD_NIV_OPE", & 
                   "DUR_PERRNV_ADH", "UNT_PERRNV_ADH", "COD_MODE_REG", &
                   "LIB_BQ_DEBIT", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE", &
                   "COD_DEST_REG", "COD_ADH", "ID_CORB", "ID_POLICE", "NUM_TEL", &
                   "NUM_FAX", "ID_DEPTS", "COD_BASE_DMS", "COD_ADR_DMS", &
						 "COD_PROD_DMS", "NB_ADHERENT", "ALT_CREBQ_DMS", "COD_EURO", "ALT_INFO_PROV" }


			sVal [ 1 ]  = "'" + String ( idcIdProd      )  + "'"
			sVal [ 2 ]  = "'" + String ( dcIdDept       )  + "'"
			sVal [ 3 ]  = "'" + String ( dcIdGrp        )  + "'"
			sVal [ 4 ]  = "'" + sLibCourt                  + "'"
			sVal [ 5 ]  = "'" + sLibLong                   + "'"
			sVal [ 6 ]  = "'" + String ( dcCodRevSurv   )  + "'"
			sVal [ 7 ]  = "'" + String ( dcCodRevSous   )  + "'"
			sVal [ 8 ]  = "'" + String ( dcCodRevRnv    )  + "'"
			sVal [ 9 ]  = "'" + String ( dcCodNivOpe    )  + "'"
			sVal [ 10 ] = "'" + String ( dcDurPerrnvAdh )  + "'"
			sVal [ 11 ] = "'" + sUntPerrnvAdh              + "'"
			sVal [ 12 ] = "'" + sCodModeReg                + "'"
			sVal [ 13 ] = f_GetItem ( Dw_1, 1, "LIB_BQ_DEBIT"  )
			sVal [ 14 ] = f_GetItem ( Dw_1, 1, "RIB_BQ"        )
			sVal [ 15 ] = f_GetItem ( Dw_1, 1, "RIB_GUI"       )
			sVal [ 16 ] = f_GetItem ( Dw_1, 1, "RIB_CPT"       )
			sVal [ 17 ] = f_GetItem ( Dw_1, 1, "RIB_CLE"       )
			sVal [ 18 ] = "'" + sCodDestReg                + "'"
			sVal [ 19 ] = "'" + sCodAdh                    + "'"
			sVal [ 20 ] = "'" + String ( dcIdCorb )        + "'"
			sVal [ 21 ] = f_getitem ( Dw_1, 1, "ID_POLICE"     ) 
			sVal [ 22 ] = f_GetItem ( Dw_1, 1, "NUM_TEL"       )
			sVal [ 23 ] = f_GetItem ( Dw_1, 1, "NUM_FAX"       )
			sVal [ 24 ] = "'" + String ( dcIdDepts    )  + "'"
			sVal [ 25 ] = "'" + String ( dcCodBaseDms )  + "'"
			sVal [ 26 ] = "'" + String ( dcCodAdrDms  )  + "'"
			sVal [ 27 ] = "'" + String ( dcCodProdDms )  + "'"
			sVal [ 28 ] = "'" + String ( sAltCreBqDms )  + "'"
			sVal [ 29 ] = "'" + String ( dcNbAdherent )  + "'"
			sVal [ 30 ] = "'" + String ( dcCodEuro )  	+ "'"
			sVal [ 31 ] = "'" + sAltInfoProv 				+ "'"

			sCle [ 1 ]	= sVal [ 1 ]

			sType = 'I'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

	Case	"UPDA"

		uoGsTrace.uf_PreparerTrace ( sSqlPreview, sCol, sVal )

		sCle [ 1 ]	= "'" + String ( Dw_1.GetItemNumber ( 1, "ID_PROD" ) ) + "'"

		sType = 'U'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			Dw_1.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If

	Case	"DELE"

		F_Execute ( "Exec sysadm.DW_D01_PRODUIT " + String ( idcIdProd ), itrTrans) 

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCle [ 1 ] = "'" + String ( idcIdProd ) + "'"
			sType = 'D'
	
			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

End Choose
//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM


end event

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_1
//* Evenement 		:	ItemChanged - Extend
//* Auteur			:	N°6
//* Date				:	20/06/1997 15:14:37
//* Libellé			:	Contrôle de champs
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
//* N° Modif          Reçue Le          Effectuée Le          PAR
//*
//* TEST0002          14/11/97          20/11/97				  YP
//*
//* #2  PLJ   13/07/2004 Gestion du groupe de produit Sherpa
//* #3	JCA	01/12/2006	Contrôle pour limiter les erreurs de parametrage
//*-----------------------------------------------------------------

Long		lPos			// Position du tiret dans le titre.
String	sVal			// Valeur à contrôler.
Boolean  bRet			// Valeur de retour de fonction.
Integer	iRet			// valeur de retour de fonction.

String		sLibGrpSherpa 				//#2
Long			lTotGrp, lLigneGrp		//#2
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

sVal 		= This.GetText ( )

Choose Case isNomCol

	Case "ID_PROD"

			If iuoGsProduit.Uf_Gs_Id_Produit ( Long ( sVal ) ) <> "" Then

				This.iiErreur = 1
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			ElseIf Not iUoGsProduit.Uf_Gs_Longueur ( sVal ) Then

				This.iiErreur = 2
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else

				idcIdProd = Dec ( sVal )

			End If

	Case "ID_GRP"

			/*----------------------------------------------------------------------------*/
			/* Initialise les établissements en fonction du contractant saisi.            */
			/* TRUE indique que l'on renseigne les Ets suite à une saisie.                */
			/*----------------------------------------------------------------------------*/
			iRet = iUoGsEts.Uf_RazEts ( sVal  )

			If iRet = 1 Then
				Dw_1.SetFocus ( )	
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else	
				Dw_1.SetFocus ( )
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 0 )
				ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM
				/*------------------------------------------------------------------*/
				/* #1 Récupération du libellé du groupe de produit Sherpa           */
				/*------------------------------------------------------------------*/
				lTotGrp   = dw_lst_grp_grpsherpa.RowCount()
				lLigneGrp = dw_lst_grp_grpsherpa.Find ( "ID_GRP = " + sVal , 1, lTotGrp )

				If lLigneGrp < 1 Then  
					dw_1.Modify ("t_id_grp_prod.Text='Erreur Récup'" )
				Else

					sLibGrpSherpa = String ( dw_lst_Grp_grpsherpa.GetItemNumber ( lLigneGrp, "ID_GRP_PROD" ) ) + &
										 "  " 														    						       + &
				 						 dw_lst_grp_grpsherpa.GetItemString ( lLigneGrp, "LIB_GRP_SHERPA" )

					dw_1.Modify ("t_id_grp_prod.Text = '" + sLibGrpSherpa + "'" )
	
				End If
				/*--------*/
				/* FIN #1 */
				/*--------*/

			End If




	Case "ID_DEPT"

			IuoZnProduit.Uf_Zn_IdDept ( Dec ( sVal ) , TRUE )


	Case "RIB_BQ"

		/*------------------------------------------------------------------*/
		/* Complète le champ avec 5 zero à gauche                           */
		/*------------------------------------------------------------------*/
		sVal = IuoZnProduit.Uf_Zn_Completer ( sVal, 5 )

		/*------------------------------------------------------------------*/
		/* Si le RIB est incorrect, on déclenche une erreur de saisie, sinon*/
		/* on repositionne la valeur du champ complèté des éventuels zeros  */
		/* manquant à gauche																  */
		/*------------------------------------------------------------------*/
		bRet = IuoZnProduit.Uf_Zn_VerifRib ( sVal, Dw_1.GetITemString ( 1, "RIB_GUI" ), &
							   								 Dw_1.GetITemString ( 1, "RIB_CPT" ), &
																 Dw_1.GetITemString ( 1, "RIB_CLE" )  )
		If bRet = False then

			iiErreur = 1
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode(1)
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If

	Case "RIB_GUI"

		/*------------------------------------------------------------------*/
		/* Complète le champ avec 5 zero à gauche                           */
		/*------------------------------------------------------------------*/
		sVal = IuoZnProduit.Uf_Zn_Completer ( sVal, 5 )

		/*------------------------------------------------------------------*/
		/* Si le RIB est incorrect, on déclenche une erreur de saisie, sinon*/
		/* on repositionne la valeur du champ complèté des éventuels zero   */
		/* manquant à gauche																  */
		/*------------------------------------------------------------------*/
		bRet = IuoZnProduit.Uf_Zn_VerifRib (	Dw_1.GetITemString ( 1, "RIB_BQ"  ), &
															sVal                               , &
							   							Dw_1.GetITemString ( 1, "RIB_CPT" ), &
															Dw_1.GetITemString ( 1, "RIB_CLE" )  )
		If bRet = False then

			iiErreur = 1
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode(1)
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			This.SetItem ( 1 , isNomCol , sVal )
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 2 )
			ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If

	Case "RIB_CPT"

		/*------------------------------------------------------------------*/
		/* Complète le champ avec 11 zero à gauche                          */
		/*------------------------------------------------------------------*/
		sVal = IuoZnProduit.Uf_Zn_Completer ( sVal, 11 )

		/*------------------------------------------------------------------*/
		/* Si le RIB est incorrect, on déclenche une erreur de saisie, sinon*/
		/* on repositionne la valeur du champ complèté des éventuels zero   */
		/* manquant à gauche																  */
		/*------------------------------------------------------------------*/
				
		bRet = IuoZnProduit.Uf_Zn_VerifRib (	Dw_1.GetITemString ( 1, "RIB_BQ"  ), &
							   							Dw_1.GetITemString ( 1, "RIB_GUI" ), &
															sVal                               , &
															Dw_1.GetITemString ( 1, "RIB_CLE" )  )
		If bRet = False then

			iiErreur = 1
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode(1)
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			This.SetItem ( 1 , isNomCol , sVal )
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 2 )
			ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If

	Case "RIB_CLE"

		/*------------------------------------------------------------------*/
		/* Complète le champ avec 2 zero à gauche                           */
		/*------------------------------------------------------------------*/
		sVal = IuoZnProduit.Uf_Zn_Completer ( sVal, 2 )

		/*------------------------------------------------------------------*/
		/* Si le RIB est incorrect, on déclenche une erreur de saisie, sinon*/
		/* on repositionne la valeur du champ complèté des éventuels zero   */
		/* manquant à gauche																  */
		/*------------------------------------------------------------------*/
				
		bRet = IuoZnProduit.Uf_Zn_VerifRib (	Dw_1.GetITemString ( 1, "RIB_BQ"  ), &
							   							Dw_1.GetITemString ( 1, "RIB_GUI" ), &
															Dw_1.GetITemString ( 1, "RIB_CPT" ), &
															sVal                                 )
		If bRet = False then

			iiErreur = 1
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode(1)
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			This.SetItem ( 1 , isNomCol , sVal )
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 2 )
			ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If


	Case "LIB_LONG"

		/*------------------------------------------------------------------*/
		/* TEST0002 : Gestion de l'affichage du libellé long dans le titre  */
		/* de la fenêtre.                                                   */
		/*------------------------------------------------------------------*/
		If sVal <> "" Then

			lPos = Pos ( Parent.Title , "-" )

			If lPos > 0 Then

				Parent.Title = Left ( Parent.Title , lPos - 2 ) + " - " + sVal

			Else

				Parent.Title = Parent.Title + " - " + sVal

			End If

		Else

			/*------------------------------------------------------------------*/
			/* On ne connait pas le libellé, dans ce cas s'il y en a un dans    */
			/* le titre, on le supprime.                                        */
			/*------------------------------------------------------------------*/
			lPos = Pos ( Parent.Title , "-" )
	
			If lPos > 0 Then &
				Parent.Title = Left ( Parent.Title , lPos - 2 )

		End If
	// #3
	case "COD_TEL"
		if sVal > '0' then
			if not IuoZnProduit.uf_zn_gestion_appareil( Dw_1.GetItemNumber ( 1, "ID_PROD" ) ) then
				ll_ret = 1
			end if
		end if		

	case "ALT_CMD_MOBILE"
		if sVal = 'O' then
			if not IuoZnProduit.uf_zn_gestion_echange_flux( Dw_1.GetItemNumber ( 1, "ID_PROD" ) ) then
				ll_ret = 1
			end if
		end if		

	case "ALT_COD_BOUTIQUE"
		if sVal = 'O' then
			if not IuoZnProduit.uf_zn_gestion_boutique( Dw_1.GetItemNumber ( 1, "ID_PROD" ) ) then
				ll_ret = 1
			end if
		end if		
	case "ID_CORB"
		if sVal <> string ( Dw_1.GetItemNumber ( 1, "ID_CORB", Primary!, True ) ) then
			if string ( Dw_1.GetItemNumber ( 1, "ID_CORB", Primary!, True ) ) <> '999' then
				ll_ret = 1
			end if
		end if
	//#3 - FIN
End Choose
//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_1
//* Evenement 		:	ITEMERROR - Extend 
//* Auteur			:	N°6
//* Date				:	20/06/1997 15:22:24
//* Libellé			:	Gestion des messages d'erreur suite aux erreurs 
//*					 	de saisies.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JCA	04/12/2006	Optimisation controle paramétrage	  
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre	= "Paramétrage des Produits"
	stMessage.Icon		= Information!

	Choose Case isErrCol

		Case "ID_PROD"

			If ( iiErreur = 1 ) Then
				stMessage.sVar[1] = "le produit " + GetText() 
				stMessage.sCode	= "GENE005"

			ElseIf ( iiErreur = 2 ) Then
				stMessage.sCode	= "GENE015"

			Else
				stMessage.sVar[1] = "code du produit"
				stMessage.sCode	= "GENE003"

			End If

		Case "LIB_COURT"
			stMessage.sVar[1] = "libellé court du produit"
			stMessage.sCode	= "GENE003"

		Case "LIB_LONG"
			stMessage.sVar[1] = "libellé long du produit"
			stMessage.sCode	= "GENE003"

		Case "LIB_BQ_DEBIT"
			stMessage.sVar[1] = "libellé de la banque"
			stMessage.sCode	= "GENE003"

		Case "RIB_BQ"

			Choose Case iiErreur

				Case 0
					stMessage.sVar[1] = "code de la banque"
					stMessage.sCode	= "GENE003"

				Case 1
					stMessage.sCode   = "REFU005"

			End Choose


		Case "RIB_GUI"

			Choose Case iiErreur

				Case 0
					stMessage.sVar[1] = "code du guichet"
					stMessage.sCode	= "GENE003"

				Case 1
					stMessage.sCode   = "REFU005"

			End Choose


		Case "RIB_CPT"

			Choose Case iiErreur

				Case 0
					stMessage.sVar[1] = "numéro du compte"
					stMessage.sCode	= "GENE003"

				Case 1
					stMessage.sCode   = "REFU005"

			End Choose


		Case "RIB_CLE"

			Choose Case iiErreur

				Case 0
					stMessage.sVar[1] = "clé RIB"
					stMessage.sCode	= "GENE002"

				Case 1
					stMessage.sCode   = "REFU005"

			End Choose

		Case "NUM_TEL"
			stMessage.sVar[1] = "numéro de téléphone"
			stMessage.sCode	= "GENE003"

		Case "NUM_FAX"
			stMessage.sVar[1] = "numéro de fax"
			stMessage.sCode	= "GENE003"

		Case "NB_ADHERENT"
			stMessage.sVar[1] = "nombre d'adhérent"
			stMessage.sCode	= "GENE003"

		Case "DUR_PERRNV_ADH"
			stMessage.sVar[1] = "période de renouvellement"
			stMessage.sCode	= "GENE002"

		Case "COD_PROD_DMS"
			// [DCMP080496] Renommage en : Code Produit Volcane
			stMessage.sVar[1] = "code produit VOLCANES"
			//
			stMessage.sCode	= "GENE003"

		// #1
		Case "COD_TEL"
			stMessage.sCode		= "GENE150"
		Case "ALT_CMD_MOBILE"
			stMessage.sCode		= "GENE151"
		Case "ALT_COD_BOUTIQUE"
			stMessage.sCode		= "GENE152"
		Case "ID_CORB"
			stMessage.sCode		= "GENE153"
		// #1 - FIN
	End Choose

	f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//	This.uf_Reinitialiser ()
	Return This.uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

//Migration PB8-WYNIWYG-03/2006 FM
return AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on dw_1::dberror;call w_8_traitement_master`dw_1::dberror;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_1
//* Evenement 		:	dberror
//* Auteur			:	N°6
//* Date				:	20/06/1997 15:14:14
//* Libellé			:	En cas d'erreur base, on rollbacke la trace.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On désactive le mode incrémentation autonome. (voir la fonction  */
/* elle-même pour                                                   */
/* quelques explications sur ce mode d'utilisation de la trace ou   */
/* l'analyse des traitements de la trace !)                         */
/*------------------------------------------------------------------*/
UoGsTrace.uf_ModeIncAutonome ( False )

UoGsTrace.Uf_CommitTrace ( False )
end on

on dw_1::itemfocuschanged;call w_8_traitement_master`dw_1::itemfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_tm_Sp_Produit::dw_1
//* Evenement 		: ItemFocusChanged
//* Auteur			: DBI
//* Date				: 13/07/1998 09:35:04
//* Libellé			: 
//* Commentaires	: Modification des zones
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Choose Case This.isNomCol
	Case "COD_ADH"
		iuoZnProduit.Uf_Zn_Cod_Adh ( This.GetItemString ( 1, "COD_ADH" ) )
		This.isNomCol = ""
	End Choose

end on

type st_titre from w_8_traitement_master`st_titre within w_tm_sp_produit
boolean visible = false
integer x = 2834
integer y = 24
integer width = 713
end type

type pb_retour from w_8_traitement_master`pb_retour within w_tm_sp_produit
integer x = 14
integer y = 12
integer width = 242
integer height = 144
integer taborder = 140
end type

type pb_valider from w_8_traitement_master`pb_valider within w_tm_sp_produit
integer x = 507
integer y = 12
integer width = 242
integer height = 144
integer taborder = 160
end type

type pb_imprimer from w_8_traitement_master`pb_imprimer within w_tm_sp_produit
boolean visible = false
integer x = 992
integer y = 12
integer width = 242
integer height = 144
integer taborder = 0
end type

type pb_controler from w_8_traitement_master`pb_controler within w_tm_sp_produit
integer x = 265
integer y = 12
integer width = 242
integer height = 144
integer taborder = 150
end type

type pb_supprimer from w_8_traitement_master`pb_supprimer within w_tm_sp_produit
integer x = 750
integer y = 12
integer width = 242
integer height = 144
integer taborder = 170
end type

type dw_pieces from u_datawindow within w_tm_sp_produit
boolean visible = false
integer x = 3122
integer y = 800
integer width = 288
integer height = 128
integer taborder = 0
string dataobject = "d_sp_prod_pce"
boolean vscrollbar = true
end type

event sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_Pieces
//* Evenement 		: SqlPreview
//* Auteur			: La Recrue
//* Date				: 02/07/1997 14:41:24
//* Libellé			: 
//* Commentaires	: Insertion des pieces pour une garantie
//*					  dans la table PIECE.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Decimal{0}	dcIdGti				// Identifiant de la garantie
Decimal{0}	dcIdPce				// Identifiant de la piece
Decimal{0}	dcCptTri				// Compteur de tri

String		sSql					// commande SQL qui doit être envoyée.
String		sTable				// Nom de la table à tracer.
String		sType					// Type d'action effectuer sur la table.
String		sCodTypPce			// Type de Piece. ( G NORMALEMENT )
String		sIdPara				// Paragraphe associé à la piece.
String		sCle [ 4 ]			// Tableau de l'identifiant de l'enregistrement tracé.
//Migration PB8-WYNIWYG-03/2006 FM
//String		sCol [ 9 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 9 ]			// Tableau des valeurs des colonnes à tracer.
String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal []			// Tableau des valeurs des colonnes à tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM
Long			lLig					// N° de la ligne à insèrer.

DateTime		dtMajLe				// Date de Mise à Jour.

dwBuffer		dwBuf					// buffer de donnée de la Dw.

Boolean		bTrace				// La trace doit elle avoir lieu

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

//Migration PB8-WYNIWYG-03/2006 FM
//sSql = This.GetSqlPreview ()
sSql = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Permet d'obtenir le N° de l'enregistrement à inserer.            */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//This.GetUpdateStatus ( lLig, dwBuf )		
lLig = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "PIECE"

Choose Case Left ( sSql, 4 )

	Case "INSE"

		/*------------------------------------------------------------------*/
		/* Procédure d'insertion.                                           */
		/*------------------------------------------------------------------*/

		dcIdGti		= dw_Pieces.GetItemNumber ( lLig, "ID_GTI"      )
		dcIdPce		= dw_Pieces.GetItemNumber ( lLig, "ID_PCE"      )
		sIdPara		= dw_Pieces.GetItemString ( lLig, "ID_PARA"     )
		sCodTypPce	= dw_Pieces.GetItemString ( lLig, "COD_TYP_PCE" )
		dcCptTri		= dw_Pieces.GetItemNumber ( lLig, "CPT_TRI"     )
		dtMajLe     = Dw_1.GetItemDateTime    ( 1   , "MAJ_LE"      )

		itrTrans.DW_I01_PIECE (	idcIdProd		, &
										idcIdRev			, &
										dcIdGti			, &
										dcIdPce			, &
										sIdPara			, &
										sCodTypPce		, &
										dtMajLe   		, &
										dtMajLe   		, &
								 	  	stGlb.sCodOper , &
										dcCptTri )

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			Dw_Pieces.SetActionCode ( 1 )		
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol = { "ID_PROD", "ID_REV", "ID_GTI", "ID_PCE", "ID_PARA", &
						"COD_TYP_PCE", "CPT_TRI" }

			sVal [ 1 ] = "'" + String ( idcIdProd )	+ "'"
			sVal [ 2 ] = "'" + String ( idcIdRev )		+ "'"
			sVal [ 3 ] = "'" + String ( dcIdGti )		+ "'"
			sVal [ 4 ] = "'" + String ( dcIdPce )		+ "'"
			sVal [ 5 ] = "'" + sIdPara						+ "'"
			sVal [ 6 ] = "'" + sCodTypPce					+ "'"
			sVal [ 7 ] = "'" + String ( dcCptTri )		+ "'"

			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]	= sVal [ 2 ]
			sCle [ 3 ]	= sVal [ 3 ]
			sCle [ 4 ]	= sVal [ 4 ]

			sType = 'I'


			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				Dw_pieces.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				Dw_pieces.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If


	Case  "UPDA"

		uoGsTrace.uf_PreparerTrace ( sSql, sCol, sVal )

		sCle [ 1 ]	= "'" + String ( idcIdProd ) + "'"
		sCle [ 2 ]	= "'" + String ( dw_Pieces.GetItemNumber ( lLig, "ID_REV" ) ) + "'"
		sCle [ 3 ]	= "'" + String ( dw_Pieces.GetItemNumber ( lLig, "ID_GTI" ) ) + "'"
		sCle [ 4 ]	= "'" + String ( dw_Pieces.GetItemNumber ( lLig, "ID_PCE" ) ) + "'"

		sType = 'U'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			Dw_Pieces.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If

	Case	"DELE"

		dcIdGti		= dw_Pieces.GetItemNumber ( lLig, "ID_GTI", DELETE!, false )
		dcIdPce		= dw_Pieces.GetItemNumber ( lLig, "ID_PCE", DELETE!, false )

		If ( uo_garantie.Dw_Source.Find ( "ID_GTI = " + String ( dcIdGti ), 1, uo_garantie.Dw_Source.RowCount () ) > 0 ) Then

			F_Execute ( "Exec sysadm.DW_D01_PIECE " + String ( idcIdProd ) + ", " + String ( idcIdRev ) + ", " + String ( dcIdGti ) + ", " + String ( dcIdPce ), itrTrans) 

			If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				Dw_Pieces.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
				bTrace = False

			Else

				bTrace = True

			End If

		Else
//Migration PB8-WYNIWYG-03/2006 FM
//				Dw_Pieces.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
				bTrace = True

		End If

		If ( bTrace ) Then

			sCle [ 1 ] = "'" + String ( idcIdProd )	+ "'"
			sCle [ 2 ] = "'" + String ( idcIdRev )		+ "'"
			sCle [ 3 ] = "'" + String ( dcIdGti )		+ "'"
			sCle [ 4 ] = "'" + String ( dcIdPce )		+ "'"

			sType = 'D'


			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				Dw_pieces.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				Dw_pieces.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

End Choose
//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on dberror;call u_datawindow::dberror;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_traitement::dw_1
//* Evenement 		: dberror
//* Auteur			: Y. Picard
//* Date				: 27/02/97 15:29:14
//* Libellé			: En cas d'erreur base, on rollbacke la trace.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On désactive le mode incrémentation autonome. (voir la fonction  */
/* elle-même pour                                                   */
/* quelques explications sur ce mode d'utilisation de la trace ou   */
/* l'analyse des traitements de la trace !)                         */
/*------------------------------------------------------------------*/
UoGsTrace.uf_ModeIncAutonome ( FALSE )

UoGsTrace.Uf_CommitTrace ( False )
end on

type dw_refus from u_datawindow within w_tm_sp_produit
boolean visible = false
integer x = 3122
integer y = 296
integer width = 288
integer height = 128
integer taborder = 0
string dataobject = "d_sp_prod_ref"
boolean vscrollbar = true
end type

event sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_Refus
//* Evenement 		: SqlPreview
//* Auteur			: La Recrue
//* Date				: 02/07/1997 14:41:24
//* Libellé			: 
//* Commentaires	: Mise à jour de la table MOTIF
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Decimal{0}	dcIdGti				// Identifiant de la garantie
Decimal{0}	dcIdMotif			// Identifiant du motif de refus
Decimal{0}	dcCptTri				// Compteur de tri

String		sSql					// commande SQL qui doit être envoyée.
String		sTable				// Nom de la table à tracer.
String		sType					// Type d'action effectuer sur la table.
String		sIdPara				// Paragraphe associé au refus.
String		sCodTypMotif		// Type de motif associé au refus.
String		sCodNatMotif		// Nature de motif associé au refus.
String		sCle [ 4 ]			// Tableau de l'identifiant de l'enregistrement tracé.
//Migration PB8-WYNIWYG-03/2006 FM
//String		sCol [ 10 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 10 ]			// Tableau des valeurs des colonnes à tracer.
String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal []			// Tableau des valeurs des colonnes à tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM
Long			lLig					// N° de la ligne à insèrer.

DateTime		dtMajLe				// Date de Mise à Jour.

dwBuffer		dwBuf					// buffer de donnée de la Dw.

Boolean		bTrace				// La trace doit elle avoir lieu

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

//Migration PB8-WYNIWYG-03/2006 FM
//sSql = This.GetSqlPreview ()
sSql = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Permet d'obtenir le N° de l'enregistrement à inserer.            */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//This.GetUpdateStatus ( lLig, dwBuf )		
lLig = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "MOTIF"

Choose Case Left ( sSql, 4 )

	Case "INSE"

		/*------------------------------------------------------------------*/
		/* Procédure d'insertion.                                           */
		/*------------------------------------------------------------------*/

		dcIdGti		= Dw_Refus.GetItemNumber ( lLig, "ID_GTI"    		)
		dcIdMotif	= Dw_Refus.GetItemNumber ( lLig, "ID_MOTIF"  		)
		sIdPara		= Dw_Refus.GetItemString ( lLig, "ID_PARA"   		)
		sCodTypMotif= Dw_Refus.GetItemString ( lLig, "COD_TYP_MOTIF"	)
		sCodNatMotif= Dw_Refus.GetItemString ( lLig, "COD_NAT_MOTIF"	)
		dtMajLe		= Dw_1.GetItemDateTime   ( 1   , "MAJ_LE"    		)
		dcCptTri		= Dw_Refus.GetItemNumber ( lLig, "CPT_TRI"  			)

		itrTrans.DW_I01_MOTIF (	idcIdProd		, &
										idcIdRev			, &
										dcIdGti			, &
										dcIdMotif		, &
										sIdPara			, &
										sCodTypMotif	, &
										sCodNatMotif	, &
										dtMajLe   		, &
										dtMajLe   		, &
								 	  	stGlb.sCodOper , &
										dcCptTri )

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			Dw_Refus.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol = { "ID_PROD", "ID_REV", "ID_GTI", "ID_MOTIF", "ID_PARA", "COD_TYP_MOTIF" , &
						"COD_NAT_MOTIF", "CPT_TRI" }

			sVal [ 1 ] = "'" + String ( idcIdProd )	+ "'"
			sVal [ 2 ] = "'" + String ( idcIdRev  )	+ "'"
			sVal [ 3 ] = "'" + String ( dcIdGti   )	+ "'"
			sVal [ 4 ] = "'" + String ( dcIdMotif )	+ "'"
			sVal [ 5 ] = "'" + sIdPara						+ "'"
			sVal [ 6 ] = "'" + sCodTypMotif				+ "'"
			sVal [ 7 ] = "'" + sCodNatMotif				+ "'"
			sVal [ 8 ] = "'" + String ( dcCptTri )		+ "'"

			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]	= sVal [ 2 ]
			sCle [ 3 ]	= sVal [ 3 ]
			sCle [ 4 ]	= sVal [ 4 ]

			sType = 'I'


			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				Dw_Refus.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				Dw_Refus.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If


	Case  "UPDA"

		uoGsTrace.uf_PreparerTrace ( sSql, sCol, sVal )

		sCle [ 1 ]	= "'" + String ( idcIdProd ) + "'"
		sCle [ 2 ]	= "'" + String ( Dw_Refus.GetItemNumber ( lLig, "ID_REV"   ) )	+ "'"
		sCle [ 3 ]	= "'" + String ( Dw_Refus.GetItemNumber ( lLig, "ID_GTI"   ) )	+ "'"
		sCle [ 4 ]	= "'" + String ( Dw_Refus.GetItemNumber ( lLig, "ID_MOTIF" ) ) + "'"

		sType = 'U'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			Dw_Refus.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If

	Case	"DELE"

		dcIdGti		= Dw_Refus.GetItemNumber ( lLig, "ID_GTI"   , DELETE!, false )
		dcIdMotif	= Dw_Refus.GetItemNumber ( lLig, "ID_MOTIF" , DELETE!, false )

		If ( uo_garantie.Dw_Source.Find ( "ID_GTI = " + String ( dcIdGti ), 1, uo_garantie.Dw_Source.RowCount () ) > 0 ) Then

			F_Execute ( "Exec sysadm.DW_D01_MOTIF " + String ( idcIdProd ) + ", " + String ( idcIdRev ) + ", " + String ( dcIdGti ) + ", " + String ( dcIdMotif ), itrTrans) 

			If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				Dw_Refus.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
				bTrace = False

			Else

				bTrace = True

			End If

		Else
//Migration PB8-WYNIWYG-03/2006 FM
//			Dw_Refus.SetActionCode ( 2 )
			ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			bTrace = True

		End If

		If ( bTrace ) Then

			sCle [ 1 ] = "'" + String ( idcIdProd )	+ "'"
			sCle [ 2 ] = "'" + String ( idcIdRev  )	+ "'"
			sCle [ 3 ] = "'" + String ( dcIdGti   )	+ "'"
			sCle [ 4 ] = "'" + String ( dcIdMotif )	+ "'"

			sType = 'D'


			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				Dw_Refus.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				Dw_Refus.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on dberror;call u_datawindow::dberror;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_traitement::dw_1
//* Evenement 		: dberror
//* Auteur			: Y. Picard
//* Date				: 27/02/97 15:29:14
//* Libellé			: En cas d'erreur base, on rollbacke la trace.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On désactive le mode incrémentation autonome. (voir la fonction  */
/* elle-même pour                                                   */
/* quelques explications sur ce mode d'utilisation de la trace ou   */
/* l'analyse des traitements de la trace !)                         */
/*------------------------------------------------------------------*/
UoGsTrace.uf_ModeIncAutonome ( FALSE )

UoGsTrace.Uf_CommitTrace ( False )
end on

type dw_codcon from u_datawindow within w_tm_sp_produit
boolean visible = false
integer x = 3122
integer y = 464
integer width = 288
integer height = 128
integer taborder = 0
string dataobject = "d_sp_prod_codcon"
boolean vscrollbar = true
end type

event sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_CodCon
//* Evenement 		: SqlPreview
//* Auteur			: La Recrue
//* Date				: 02/07/1997 14:41:24
//* Libellé			: 
//* Commentaires	: Maj à jour de la table Code_Condition.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
//* N° Modif          Reçue Le          Effectuée Le          PAR
//*
//* TEST0002          21/11/97          21/11/97				  YP
//*-----------------------------------------------------------------

Decimal{0}	dcIdGti				// Identifiant de la garantie
Decimal{0}	dcIdCode				// Code de la condition en question.

String		sSql					// commande SQL qui doit être envoyée.
String		sTable				// Nom de la table à tracer.
String		sType					// Type d'action effectuer sur la table.
String		sIdTypCode			// Identifiant du type de code ( +NS, +TR )
String		sLibEvt				// Libellé par défaut associé pour les evts
String		sCle [ 4 ]			// Tableau de l'identifiant de l'enregistrement tracé.
//Migration PB8-WYNIWYG-03/2006 FM
//String		sCol [ 8 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 8 ]			// Tableau des valeurs des colonnes à tracer.
String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal []			// Tableau des valeurs des colonnes à tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM
Long			lLig					// N° de la ligne à insèrer.

DateTime		dtMajLe				// Date de Mise à Jour.

dwBuffer		dwBuf					// buffer de donnée de la Dw.

Boolean		bTrace				// La trace doit elle avoir lieu
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

//Migration PB8-WYNIWYG-03/2006 FM
//sSql = This.GetSqlPreview ()
sSql = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Permet d'obtenir le N° de l'enregistrement à inserer.            */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//This.GetUpdateStatus ( lLig, dwBuf )
lLig = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "CODE_CONDITION"

Choose Case Left ( sSql, 4 )

	Case "INSE"

		/*------------------------------------------------------------------*/
		/* Procédure d'insertion.                                           */
		/*------------------------------------------------------------------*/

		dcIdGti		= Dw_CodCon.GetItemNumber ( lLig, "ID_GTI"      )
		sIdTypCode	= Dw_CodCon.GetItemString ( lLig, "ID_TYP_CODE" )
		sLibEvt		= Dw_CodCon.GetItemString ( lLig, "LIB_EVT" )
		If isNull ( sLibEvt ) Then sLibEvt = ''
//		sLibEvt		= f_GetItem ( Dw_CodCon, lLig, "LIB_EVT"		)
		dcIdCode		= Dw_CodCon.GetItemNumber ( lLig, "ID_CODE"     )
//		dtMajLe		= Dw_1.GetItemDateTime    ( 1   , "MAJ_LE"      )
		dtMajLe		= DateTime ( Today(), Now() )

		itrTrans.DW_I01_CODE_COND (	idcIdProd		, &
													dcIdGti			, &
													sIdTypCode		, &
													dcIdCode			, &
													sLibEvt 			, &
													dtMajLe   		, &
													dtMajLe   		, &
  										 	  		stGlb.sCodOper)


		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			Dw_CodCon.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol = { "ID_PROD", "ID_GTI", "ID_TYP_CODE", "ID_CODE", "LIB_EVT" }

			sVal [ 1 ] = "'" + String ( idcIdProd )	+ "'"
			sVal [ 2 ] = "'" + String ( dcIdGti )		+ "'"
			sVal [ 3 ] = "'" + sIdTypCode 				+ "'"
			sVal [ 4 ] = "'" + String ( dcIdCode )		+ "'"
			sVal [ 5 ] = "'" + f_Remplace ( sLibEvt, "~'", "~`" )	+ "'"

			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]	= sVal [ 2 ]
			sCle [ 3 ]	= sVal [ 3 ]
			sCle [ 4 ]	= sVal [ 4 ]

			sType = 'I'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				Dw_CodCon.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				Dw_CodCon.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If


	Case  "UPDA"

		uoGsTrace.uf_PreparerTrace ( sSql, sCol, sVal )

		sCle [ 1 ]	= "'" + String ( idcIdProd )														+ "'"
		sCle [ 2 ]	= "'" + String ( Dw_CodCon.GetItemNumber ( lLig, "ID_GTI" ) )			+ "'"
		sCle [ 3 ]	= "'" + Dw_CodCon.GetItemString ( lLig, "ID_TYP_CODE" ) 					+ "'"
		sCle [ 4 ]	= "'" + String ( Dw_CodCon.GetItemNumber ( lLig, "ID_CODE" ) )			+ "'"

		// Modif DBI le 04/03/1998
		// Remplacement caractère ' du libellé par `
		If sVal[1] <> "NULL" Then
	
			sVal[1]	=	"~'" + f_Remplace ( Mid ( sVal[1], 2, Len  ( sVal[1] ) - 2 ), "~'~'", "~`" ) + "~'"
		End If

		sType = 'U'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			Dw_CodCon.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If

	Case	"DELE"

		dcIdGti		= Dw_CodCon.GetItemNumber ( lLig, "ID_GTI"     , DELETE!, false )
		sIdTypCode	= Dw_CodCon.GetItemString ( lLig, "ID_TYP_CODE", DELETE!, false )
		dcIdCode		= Dw_CodCon.GetItemNumber ( lLig, "ID_CODE"    , DELETE!, false )

		/*------------------------------------------------------------------*/
		/* TEST0002 : Dans le cas des code condition du niveau produit      */
		/* id_gti = 0, mais cette garantie 0 n'existe pas en tant que tel,  */
		/* donc on ne fait pas le test du Find .                            */
		/*------------------------------------------------------------------*/
		If ( uo_garantie.Dw_Source.Find ( "ID_GTI = " + String ( dcIdGti ), 1, uo_garantie.Dw_Source.RowCount () ) > 0 ) Or &
			( dcIdGti = -1 ) Then

			itrTrans.DW_D01_CODE_CONDITION ( idcIdProd, dcIdGti, sIdTypCode, dcIdCode )

			If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				Dw_CodCon.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
				bTrace = False

			Else

				bTrace = True

			End If

		Else
//Migration PB8-WYNIWYG-03/2006 FM
//			Dw_CodCon.SetActionCode ( 2 )	
			ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			bTrace = True

		End If
	

		If ( bTrace ) Then

			sCle [ 1 ] = "'" + String ( idcIdProd )	+ "'"
			sCle [ 2 ] = "'" + String ( dcIdGti )		+ "'"
			sCle [ 3 ] = "'" + sIdTypCode 				+ "'"
			sCle [ 4 ] = "'" + String ( dcIdCode )		+ "'"

			sType = 'D'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				Dw_CodCon.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				Dw_CodCon.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on dberror;call u_datawindow::dberror;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_traitement::dw_1
//* Evenement 		: dberror
//* Auteur			: Y. Picard
//* Date				: 27/02/97 15:29:14
//* Libellé			: En cas d'erreur base, on rollbacke la trace.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On désactive le mode incrémentation autonome. (voir la fonction  */
/* elle-même pour                                                   */
/* quelques explications sur ce mode d'utilisation de la trace ou   */
/* l'analyse des traitements de la trace !)                         */
/*------------------------------------------------------------------*/
UoGsTrace.uf_ModeIncAutonome ( FALSE )

UoGsTrace.Uf_CommitTrace ( False )
end on

type dw_code from u_datawindow within w_tm_sp_produit
boolean visible = false
integer x = 3122
integer y = 128
integer width = 288
integer height = 128
integer taborder = 0
string dataobject = "d_sp_lst_cod_con_rch"
boolean vscrollbar = true
end type

type uo_onglets from u_onglets within w_tm_sp_produit
integer x = 46
integer y = 196
integer width = 997
integer height = 108
integer taborder = 0
boolean border = false
end type

type dw_lstgrp from u_datawindow within w_tm_sp_produit
boolean visible = false
integer x = 3122
integer y = 632
integer width = 288
integer height = 128
integer taborder = 0
string dataobject = "d_sp_lst_ets_rch"
boolean vscrollbar = true
end type

type uo_bord3d from u_bord3d within w_tm_sp_produit
integer x = 1445
integer y = 40
integer width = 306
integer height = 104
boolean bringtotop = true
end type

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_3d::Constructor (OVERRIDE)
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 14:57:30
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne le Bord en 3D, puis on appelle la construction     */
/* normale.                                                         */
/*------------------------------------------------------------------*/

This.X			=   19			// Valeur de Onglet1.X + 9
This.Y			=  256			// Valeur de Onglet1.Y + 96
This.Width		= 3400
This.Height		= 1420

Call U_Bord3D::Constructor
end on

on uo_bord3d.destroy
call u_bord3d::destroy
end on

type uo_onglets2 from u_onglets within w_tm_sp_produit
integer x = 46
integer y = 352
integer width = 997
integer height = 108
integer taborder = 50
boolean border = false
end type

type dw_lst_rev from u_datawindow_detail within w_tm_sp_produit
integer x = 864
integer y = 1412
integer width = 288
integer height = 128
integer taborder = 130
boolean bringtotop = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_lst_Rev
//* Evenement 		:	SqlPreview
//* Auteur			:	N°6
//* Date				:	20/06/1997 16:23:44
//* Libellé			: 
//* Commentaires	:	Insertion des révisions pour un produit.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String		sSqlPreview			// SqlPreview de la datawindow Dw_1.
String		sCodEffRev			// Code type d'effet de la révision.
String		sLibRev				// Libellé de la révision.
String		sMajPar

String		sTable				// Nom de la table à tracer.
String		sType					// Type d'action effectuer sur la table.
String		sCle [ 2 ]			// Tableau de l'identifiant de l'enregistrement tracé.
//Migration PB8-WYNIWYG-03/2006 FM
//String		sCol [ 9 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 9 ]			// Tableau des valeurs des colonnes à tracer.
String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal []			// Tableau des valeurs des colonnes à tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM
Long			dcIdRev				// Identifiant de la revision.
Long			lLig					// N° de la ligne à insèrer ou supprimer.
Long			lCpt					// Compteur : nbr colonne.

DateTime		dtCreeLe
DateTime		dtMajLe

DateTime		dtDteEff				// date de début d'effet de la révision.
DateTime		dtDtefin				// date de fin d'effet de la révision.
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

dwBuffer		dwBuf					// buffer de donnée de la Dw.
//Migration PB8-WYNIWYG-03/2006 FM
//sSqlPreview	= This.GetSQLPreview ()
sSqlPreview	= SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM
/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "REVISION"

/*------------------------------------------------------------------*/
/* Permet d'obtenir le N° de l'enregistrement à inserer.            */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//This.GetUpdateStatus ( lLig, dwBuf )
lLig = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 FM
Choose Case Left ( sSqlPreview, 4 )

	Case "INSE"

		dcIdRev	 	= This.GetItemNumber		( lLig, "ID_REV"      )
		slibRev		= This.GetItemString		( lLig, "LIB_REV"     )
		sCodEffRev	= This.GetItemString		( lLig, "COD_EFF_REV" )
		//[MIGPB8COR] : Remplacer GetItemDate par GetItemDateTime
		//dtDteEff	 	= DateTime ( This.GetItemDate ( lLig, "DTE_EFF" ), 00:00:00 )
		//dtDteFin	 	= DateTime ( This.GetItemDate ( lLig, "DTE_FIN" ), 00:00:00 )
		dtDteEff   =     This.GetItemDateTime	( lLig, "DTE_EFF" )
		dtDteFin   =     This.GetItemDateTime	( lLig, "DTE_FIN" )
		//[MIGPB8COR]
		
		dtCreele	 	= This.GetItemDateTime	( lLig, "CREE_LE"     )
		dtMajLe	 	= This.GetItemDateTime	( lLig, "MAJ_LE"      )
		sMajPar	 	= This.GetItemString		( lLig, "MAJ_PAR"     )

		/*------------------------------------------------------------------*/
		/* Procédure d'insertion.                                           */
		/*------------------------------------------------------------------*/
// [MIGPB11] [EMD] : Debut Migration : Report migration Suisse
/*		itrTrans.DW_I01_REVISION ( idcIdProd  , &
											dcIdRev    , &
											sLibRev    , &
											sCodEffRev , &
											dtDteEff   , &
											dtDteFin   , &
									 	   dtCreeLe   , &
										 	dtMajLe    , &
										 	sMajPar ) */
		itrTrans.DW_I01_REVISION ( idcIdProd, &
											dcIdRev, &
											sLibRev, &
											sCodEffRev, &
											String ( dtDteEff ), &
											String ( dtDteFin ), &
											dtCreeLe, &
										 	dtMajLe, &
										 	sMajPar )
// [MIGPB11] [EMD] : Fin Migration

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol = { "ID_PROD" , "ID_REV" , "LIB_REV" , "COD_EFF_REV" , &
						"DTE_EFF" , "DTE_FIN" }

			sVal [ 1 ] = "'" + String ( idcIdProd   ) + "'"
			sVal [ 2 ] = "'" + String ( dcIdRev     ) + "'"
			sVal [ 3 ] = "'" + sLibRev                + "'"
			sVal [ 4 ] = "'" + sCodEffRev             + "'"
			sVal [ 5 ] = "'" + String ( dtDteEff, "dd/mm/yyyy" ) + "'"
			sVal [ 6 ] = "'" + String ( dtDteFin, "dd/mm/yyyy" ) + "'"

			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]	= sVal [ 2 ]
			sType = 'I'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

	Case	"UPDA" 

		uoGsTrace.uf_PreparerTrace ( sSqlPreview, sCol, sVal )

		sCle [ 1 ]	= "'" + String ( This.GetItemNumber ( lLig, "ID_PROD" ) ) + "'"
		sCle [ 2 ]	= "'" + String ( This.GetItemNumber ( lLig, "ID_REV"  ) ) + "'"
		sType = 'U'

		/*------------------------------------------------------------------*/
		/* Les date n'ont pas un format lisible.                            */
		/*------------------------------------------------------------------*/
		For lCpt = 1 to UpperBound (sCol)
			//[MIGPB8COR] : Remplacer GetItemDate par GetItemDateTime
			If sCol [ lCpt ] = "DTE_EFF" Then &
				sVal [ lCpt ] = "'" + String ( This.GetItemDateTime ( lLig, "DTE_EFF" ), "dd/mm/yyyy" ) + "'"
				
			If sCol [ lCpt ] = "DTE_FIN" Then &
				sVal [ lCpt ] = "'" + String ( This.GetItemDateTime ( lLig, "DTE_FIN" ), "dd/mm/yyyy" ) + "'"
			//[MIGPB8COR]	
				
			
		Next

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If


	Case	"DELE"

		dcIdRev  = This.GetItemNumber ( lLig, "ID_REV" , DELETE!, False )

		F_Execute ( "Exec sysadm.DW_D01_REVISION " + String ( idcIdProd ) + ", " + String ( idcIdRev ), itrTrans) 

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCle [ 1 ] = "'" + String ( idcIdProd ) + "'"
			sCle [ 2 ] = "'" + String ( dcIdRev   ) + "'"

			sType = 'D'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

End Choose
//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on dberror;call u_datawindow_detail::dberror;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_Lst_Rev
//* Evenement 		:	dberror
//* Auteur			:	N°6
//* Date				:	20/06/97 16:21:14
//* Libellé			:	En cas d'erreur base, on rollbacke la trace.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On désactive le mode incrémentation autonome. (voir la fonction  */
/* elle-même pour                                                   */
/* quelques explications sur ce mode d'utilisation de la trace ou   */
/* l'analyse des traitements de la trace !)                         */
/*------------------------------------------------------------------*/
UoGsTrace.uf_ModeIncAutonome ( False )

UoGsTrace.Uf_CommitTrace ( False )
end on

on ue_modifiermenu;call u_datawindow_detail::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_Lst_Rev
//* Evenement 		:	ue_ModififerMenu
//* Auteur			:	N°6
//* Date				:	20/06/1997 16:22:14
//* Libellé			: 
//* Commentaires	:	Je n'autorise pas la suppression d'une révision en utilisant
//*					 	le menu contextuel.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.Uf_Mnu_SupprimerItem ( 3 )
end on

type uo_codcon from u_ajout within w_tm_sp_produit
integer x = 96
integer y = 1412
integer width = 288
integer height = 128
integer taborder = 70
boolean border = false
end type

on ue_dwsource_supprime;call u_ajout::ue_dwsource_supprime;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_codcon
//* Evenement 		: ue_dwSourceSupprime
//* Auteur			: YP
//* Date				: 10/04/97 10:10:44
//* Libellé			: Lors de la suppression d'un record de la liste des codes condition
//*                 affectés, on le Copy dans le Buffer DELETE! de Dw_Source SI le status de la
//*						ligne est à NotModified! ou DataModified!.
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
//* N° Modif          Reçue Le          Effectuée Le          PAR
//*
//* TEST0002          20/11/97          20/11/97				  YP
//* [MIGPB8COR]		 30/05/06 			 30/05/06				  PHG
//*
//*-----------------------------------------------------------------
Decimal{0}		dcIdGti					//Identifiant d'une garantie.
Decimal{0}		dcIdCode					//Identifiant d'un code.

String			sIdTypCode				//Identifiant du type de code.

Long				lNbCondition			//Nombre de condition existante.

dwItemStatus	dwItemStat				//Statut de la ligne courante.
integer			li_Ligsup			// [MIGPB8COR] : indice ligne à supprimer



If This.ilLigSourceSupp > 0 Then

	/*------------------------------------------------------------------*/
	/* TEST0002 : On ne peut supprimer un code condition que s'il n'est */
	/* pas utilisé comme condition d'une condition de garantie.         */
	/*------------------------------------------------------------------*/
	dcIdGti  	= This.Dw_Source.GetItemNumber ( This.ilLigSourceSupp, "ID_GTI" 		)
	dcIdCode		= This.Dw_Source.GetItemNumber ( This.ilLigSourceSupp, "ID_CODE" 		)
	sIdTypcode	= This.Dw_Source.GetItemString ( This.ilLigSourceSupp, "ID_TYP_CODE" )

	/*------------------------------------------------------------------*/
	/* Recherche s'il existe une condition pour les identifiants        */
	/*------------------------------------------------------------------*/
	itrTrans.IM_S01_CONDITION ( idcIdProd, dcIdGti, sIdTypcode, dcIdCode, lNbCondition )

	If ( lNbCondition <> 0 ) Or Not f_procedure ( stMessage, itrTrans, "IM_S01_CONDITION" ) Then

		/*------------------------------------------------------------------*/
		/* On n'autorise pas la suppression de code condition pour ce       */
		/* produit.                                                         */
		/*------------------------------------------------------------------*/
		This.ibSupprime = False

		stMessage.sTitre  = "Contrôle de suppression des codes conditions"
		stMessage.sCode	= "REFU034"

		f_Message ( stMessage )

	Else

		/*------------------------------------------------------------------*/
		/* S'il y a bien une ligne courante,                                */
		/* Si le statut de la ligne courante est NotModified ou             */
		/* DataModified, on copie la ligne dans le buffer DELETE! de        */
		/* dw_source.                                                       */
		/*------------------------------------------------------------------*/
		dwItemstat = Dw_Source.GetItemStatus ( This.ilLigSourceSupp, 0 , PRIMARY!)

		If ( dwItemStat = NotModified! Or dwItemStat = DataModified! ) Then

			// [MIGPB8COR]
	//		dw_Source.RowsCopy ( This.ilLigSourceSupp, This.ilLigSourceSupp, Primary!, Dw_Source, &
	//									Dw_Source.DeletedCount ( ) + 1, DELETE! 	)
	//		remplacé par :
			li_Ligsup = Dw_Source.DeletedCount() + 1
			dw_source.object.data.Delete[li_Ligsup] = &
				dw_source.object.data.Primary[This.ilLigSourceSupp]
			dw_source.setitemstatus(li_Ligsup, 0 , Delete!, DataModified!)
			dw_source.setitemstatus(li_Ligsup, 0 , Delete!, NotModified!)

		End If

	End If

End If

end on

on constructor;call u_ajout::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_CodCon
//* Evenement 		: Constructor
//* Auteur			: N°6
//* Date				: 20/01/1997 16:58:04
//* Libellé			: 
//* Commentaires	: Initialisation de l'objet
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* L'objet ne possède pas de titre.                                 */
/*------------------------------------------------------------------*/
ibTitre = False

/*------------------------------------------------------------------*/
/* Utilisation des boutons avec une taille pour des fenêtre 800x600 */
/*------------------------------------------------------------------*/
isTaille = '8_'


end on

on ue_dimensionner;call u_ajout::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet 			: UO_CodCon
//* Evenement 		: Ue_Dimensionner
//* Auteur			: N°6
//* Date				: 04/01/1997 12:03:56
//* Libellé			: 
//* Commentaires	: Rend invisible les boutons permettant de supprimer ou 
//*					  d'ajouter tout.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uo_CodCon.Pb_enlever_tout.Visible = False
Uo_CodCon.Pb_ajouter_tout.Visible = False
end on

on uo_codcon.destroy
call u_ajout::destroy
end on

type uo_bord3d2 from u_bord3d within w_tm_sp_produit
integer x = 1874
integer y = 40
integer width = 306
integer height = 104
integer taborder = 80
end type

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_3d::Constructor (OVERRIDE)
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 14:57:30
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne le Bord en 3D, puis on appelle la construction     */
/* normale.                                                         */
/*------------------------------------------------------------------*/

This.X			=   79			// Valeur De Onglet2.X + 9
This.Y			=  386			// Valeur De Onglet2.Y + 96
This.Width		= 3250
This.Height		= 1240

Call U_Bord3D::Constructor
end on

on uo_bord3d2.destroy
call u_bord3d::destroy
end on

type uo_garantie from u_ajout within w_tm_sp_produit
integer x = 2400
integer y = 1412
integer width = 288
integer height = 128
integer taborder = 120
boolean border = false
end type

event ue_dwsource_sqlpreview;call super::ue_dwsource_sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			:	Uo_Garantie
//* Evenement 		:	Ue_Dwsource_Sqlpreview
//* Auteur			:	N°6
//* Date				:	20/06/1997 16:20:44
//* Libellé			: 
//* Commentaires	:	Insertion des codes des garanties pour un produit
//*					 	dans la table CODE_GARANTIE.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String		sSqlPreview			// commande SQL qui doit être envoyée.
String		sLibGti				// libellé du code garantie.
String		sMajPar				// Auteur de la mise à jour.

String		sTable				// Nom de la table à tracer.
String		sType					// Type d'action effectuer sur la table.
String		sCle [ 2 ]			// Tableau de l'identifiant de l'enregistrement tracé.
//Migration PB8-WYNIWYG-03/2006 FM
//String		sCol [ 8 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 8 ]			// Tableau des valeurs des colonnes à tracer.
String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal []			// Tableau des valeurs des colonnes à tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM
Long			dcIdGti				// Identifiant du code garantie.
Decimal{2}	dcMtCmt				// Montant provision.
Long			dcCodRgptStat		// Code regroupement statistique.
Long			lLig					// N° de la ligne à insèrer ou supprimer.

DateTime		dtMajLe
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

dwBuffer		dwBuf					// buffer de donnée de la Dw.
//Migration PB8-WYNIWYG-03/2006 FM
//sSqlPreview = Uo_Garantie.Dw_Source.GetSqlPreview ()
sSqlPreview = sql_syntax
//Fin Migration PB8-WYNIWYG-03/2006 FM
/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "CODE_GARANTIE"

/*------------------------------------------------------------------*/
/* Permet d'obtenir le N° de l'enregistrement à inserer.            */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Uo_Garantie.Dw_Source.GetUpdateStatus ( lLig, dwBuf )
lLig = ligne
dwBuf = buffer_dw
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case Left ( sSqlPreview, 4 )

	Case "INSE"

		dcIdGti			= Uo_Garantie.Dw_Source.GetItemNumber ( lLig, "ID_GTI"        )
		sLibGti			= Uo_Garantie.Dw_Source.GetItemString ( lLig, "LIB_GTI"       )
		dcMtCmt	 		= Uo_Garantie.Dw_Source.GetItemNumber ( lLig, "MT_CMT"        )
		dcCodRgptStat 	= Uo_Garantie.Dw_Source.GetItemNumber ( lLig, "COD_RGPT_STAT" )
		dtMajLe     	= Dw_1.GetItemDateTime ( 1 , "MAJ_LE"  )
		sMajPar	   	= stGLB.sCodOper

		/*------------------------------------------------------------------*/
		/* Procédure d'insertion.                                           */
		/*------------------------------------------------------------------*/
		itrTrans.DW_I01_CODE_GARANTIE (	idcIdProd    , &
													dcIdGti      , &
										 			sLibGti      , &
										 			dcMtCmt      , &
										 			dcCodRgptStat, &
								 	    			dtMajLe      , &
									 	 			dtMajLe      , &
  									 	 			sMajPar )

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			Uo_Garantie.Dw_Source.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol = { "ID_PROD" , "ID_GTI" , "LIB_GTI" , &
                  "MT_CMT"  , "COD_RGPT_STAT" }

			sVal [ 1 ] = "'" + String ( idcIdProd     ) + "'"
			sVal [ 2 ] = "'" + String ( dcIdGti       ) + "'"
			sVal [ 3 ] = "'" + sLibGti                  + "'"
			sVal [ 4 ] = "'" + String ( dcMtCmt       ) + "'"
			sVal [ 5 ] = "'" + String ( dcCodRgptStat ) + "'"

			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]	= sVal [ 2 ]
			sType = 'I'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				Uo_Garantie.Dw_Source.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				Uo_Garantie.Dw_Source.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

	Case	"UPDA"

		uoGsTrace.uf_PreparerTrace ( sSqlPreview, sCol, sVal )

		sCle [ 1 ]	= "'" + String ( idcIdProd ) + "'"
		sCle [ 2 ]	= "'" + String ( Uo_Garantie.Dw_Source.GetItemNumber ( lLig, "ID_GTI" ) ) + "'"
		sType = 'U'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			Uo_Garantie.Dw_Source.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If

	Case	"DELE"

		dcIdGti	= Uo_Garantie.Dw_Source.GetItemNumber ( lLig, "ID_GTI", DELETE!, False )
		
		F_Execute ( "Exec sysadm.PS_SUPCODEGARANTIE " + String ( idcIdProd ) + ", " + String ( idcIdRev ) + ", " + String ( dcIdGti ), itrTrans) 

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			Uo_Garantie.Dw_Source.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCle [ 1 ] = "'" + String ( idcIdProd ) + "'"
			sCle [ 2 ] = "'" + String ( dcIdGti  ) + "'"
			sType = 'D'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				Uo_Garantie.Dw_Source.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				Uo_Garantie.Dw_Source.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

End Choose
//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM
end event

on ue_dwsource_supprime;call u_ajout::ue_dwsource_supprime;//*-----------------------------------------------------------------
//*
//* Objet 			:	Uo_Garantie
//* Evenement 		:	Ue_Dwsource_Supprime
//* Auteur			:	N°6
//* Date				:	20/06/1997 16:10:31
//* Libellé			: 
//* Commentaires	:	Test si la ligne peut être supprimer de la table
//*						CODE_GARANTIE.
//*					  
//*					 	Lors de la suppression d'un record de la liste des garanties affectées
//*						on le Copy dans le Buffer DELETE! de Dw_Source SI le status de la
//*						ligne est à NotModified! ou DataModified!.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date			Modification
//* PHG			30/05/2006  [MIGPB8COR] Correction de la suppression
//*				  
//*-----------------------------------------------------------------

Long				dcIdGti				// Identifiant du code garantie concerné.
Long				lNbGarantie			// Nombre de garantie utilisant ce code.

dwItemStatus	dwItemStat			// Statut de la ligne courante.
integer			li_Ligsup			// [MIGPB8COR] : indice ligne à supprimer


If	This.ilLigSourceSupp > 0		Then

	dcIdGti  = This.Dw_Source.GetItemNumber ( This.ilLigSourceSupp, "ID_GTI" )

	/*------------------------------------------------------------------*/
	/* Recherche s'il existe une garantie pour les identifiants         */
	/*------------------------------------------------------------------*/
	itrTrans.IM_S03_GARANTIE ( idcIdProd, dcIdGti, lNbGarantie )

	If ( lNbGarantie <> 0 ) Or Not f_procedure ( stMessage, itrTrans, "IM_S03_GARANTIE" ) Then

		/*------------------------------------------------------------------*/
		/* Je n'autorise pas la suppression de cette garantie pour ce       */
		/* produit.                                                         */
		/*------------------------------------------------------------------*/
		This.ibSupprime = False

		stMessage.sTitre  = "Contrôle de suppression des Codes garanties"
		stMessage.sCode	= "REFU007"

		f_Message ( stMessage )

	Else

		/*------------------------------------------------------------------*/
		/* S'il y a bien une ligne courante,                                */
		/* Si le statut de la ligne courante est NotModified ou             */
		/* DataModified, on copie la ligne dans le buffer DELETE! de        */
		/* dw_source.                                                       */
		/*------------------------------------------------------------------*/
		dwItemstat = This.Dw_Source.GetItemStatus ( This.ilLigSourceSupp, 0 , PRIMARY!)

		If ( dwItemStat = NotModified! Or dwItemStat = DataModified! ) Then
			// [MIGPB8COR]
	//		dw_Source.RowsCopy ( This.ilLigSourceSupp, This.ilLigSourceSupp, Primary!, Dw_Source, &
	//									Dw_Source.DeletedCount ( ) + 1, DELETE! 	)
	//		remplacé par :
			li_Ligsup = Dw_Source.DeletedCount() + 1
			dw_source.object.data.Delete[li_Ligsup] = &
				dw_source.object.data.Primary[This.ilLigSourceSupp]
			dw_source.setitemstatus(li_Ligsup, 0 , Delete!, DataModified!)
			dw_source.setitemstatus(li_Ligsup, 0 , Delete!, NotModified!)
		End If

		Wf_Sup_Pieces ( dcIdGti )
		Wf_Sup_Refus  ( dcIdGti )
		Wf_Sup_CodCon ( dcIdGti )

	End If

End If
end on

event ue_dwsource_dclick;call super::ue_dwsource_dclick;//*-----------------------------------------------------------------
//*
//* Objet 			:	Uo_Garantie
//* Evenement 		:	Ue_Dwsource_Dclick
//* Auteur			:	N°6
//* Date				:	20/06/1997 16:15:34
//* Libellé			: 
//* Commentaires	:	Ouvre la fenêtre permettant de définir la garantie
//*					 	sélectionnée.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_pass		stPass		// structure de passge pour l'appel de W_t_sp_Code_Condition.
String		sTitre		// titre de la fenêtre W_t_sp_Code_Condition.

SetPointer ( HourGlass! )

stPass.trTrans 		= istPass.trTrans
stPass.wParent			= Parent.Parentwindow()
stPass.bEnableParent	= False

stPass.sTab [ 1 ] = String ( idcIdProd )
stPass.sTab [ 2 ] = String ( Uo_Garantie.Dw_Source.GetItemNumber ( Uo_Garantie.illigsourceclick, "ID_GTI" ) )

sTitre = Uo_Garantie.Dw_Source.GetItemString ( Uo_Garantie.illigsourceclick, "LIB_GTI" )

If isValid ( W_td_sp_Code_Condition )	= False	Then

	OpenWithParm ( W_td_sp_Code_Condition, stPass, stPass.wParent )

Else

	W_td_sp_Code_Condition.idcIdProd = idcIdProd
	W_td_sp_Code_Condition.idcIdGti = Dec ( stPass.sTab [ 2 ] )
	W_td_sp_Code_Condition.Show ()

End If

W_td_sp_Code_Condition.Title = "Gestion de la garantie " + sTitre
end event

event constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			:	Uo_Garantie
//* Evenement 		:	Constructor
//* Auteur			:	N°6
//* Date				:	20/06/1997 16:14:04
//* Libellé			: 
//* Commentaires	:	Initialisation de l'objet définissant les garanties
//*					 	du produit.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* L'objet ne possède pas de titre.                                 */
/*------------------------------------------------------------------*/
ibTitre = False

/*------------------------------------------------------------------*/
/* Utilisation des boutons avec une taille pour des fenêtre 800x600 */
/*------------------------------------------------------------------*/
isTaille = '8_'

/*------------------------------------------------------------------*/
/* Utilisation d'un RowFocusIndicateur                              */
/*------------------------------------------------------------------*/
ibIndicateur = True
//Migration PB8-WYNIWYG-03/2006 FM
//isIndicateur = "K:\PB4OBJ\BMP\FOCUS_2.BMP"*
isIndicateur = "K:\PB4OBJ\BMP\FOCUSPB8.BMP"
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_dwsource_itemerror;call super::ue_dwsource_itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			:	Uo_Garantie
//* Evenement 		:	UE_DWSOURCE_ITEMERROR
//* Auteur			:	N°6
//* Date				:	20/06/1997 16:17:44
//* Libellé			: 
//* Commentaires	:	Gestion des messages d'erreur suite aux erreurs 
//*					 	de saisies.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Choose Case Upper ( Dw_Source.GetColumnName ( ) )

	Case "MT_CMT"

		stMessage.sTitre	= "Paramétrage des Garanties"
		stMessage.Icon		= Information!
		stMessage.sVar[1] = "montant de provision"
		stMessage.sCode	= "GENE003"

		f_Message ( stMessage )

	Case "COD_RGPT_STAT"

		stMessage.sTitre	= "Paramétrage des Garanties"
		stMessage.Icon		= Information!
		stMessage.sVar[1] = "le groupe statistique"
		stMessage.sCode	= "GENE003"

		f_Message ( stMessage )

	Case "LIB_GTI"

		stMessage.sTitre	= "Paramétrage des Garanties"
		stMessage.Icon		= Information!
		stMessage.sVar[1] = "le libellé de la garantie"
		stMessage.sCode	= "GENE003"

		f_Message ( stMessage )

End Choose
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Source.SetActionCode ( 1 )
Return 1
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on ue_dimensionner;call u_ajout::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet 			:	Uo_Garantie
//* Evenement 		:	Ue_Dimensionner
//* Auteur			:	N°6
//* Date				:	20/06/1997 16:14:54
//* Libellé			: 
//* Commentaires	:	Rend invisible les boutons permettant de
//*					 	supprimer ou d'ajouter tout.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uo_Garantie.Pb_enlever_tout.Visible = False
Uo_Garantie.Pb_ajouter_tout.Visible = False
end on

on ue_dwsource_retrieve;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_garantie
//* Evenement 		:	Ue_dwSource_Retrieve
//* Auteur			:	N°6
//* Date				:	02/07/97 17:35:14
//* Libellé			:	On renseigne la Dw source.
//* Commentaires	:	Codes garanties affectés au produit.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Par défaut, on gére un seul argument de type string dans le      */
/* retrieve.                                                        */
/*------------------------------------------------------------------*/

ilLigSource = dw_Source.Retrieve  ( idcIdProd )
end on

on ue_dwrecherche_retrieve;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_garantie
//* Evenement 		:	Ue_dwRecherche_Retrieve
//* Auteur			:	N°6
//* Date				:	02/07/97 17:32:14
//* Libellé			:	On renseigne la Dw Recherche.
//* Commentaires	:	Garanties pouvant être affectés au produit.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Par défaut, on gére un seul argument de type string dans le      */
/* retrieve.                                                        */
/*------------------------------------------------------------------*/

ilLigRecherche = dw_Recherche.Retrieve  ( idcIdProd )
end on

on uo_garantie.destroy
call u_ajout::destroy
end on

type uo_courrier from u_ajout within w_tm_sp_produit
event ue_select ( string asidcour )
integer x = 2016
integer y = 1412
integer width = 288
integer height = 128
integer taborder = 60
boolean border = false
end type

event ue_select(string asidcour);//*-----------------------------------------------------------------
//*
//* Objet			: w_tm_sp_produit
//* Evenement 		: ue_select
//* Auteur			: JCA
//* Date				: 25/05/2007
//* Libellé			: Sélectionne la ligne ajoutée
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 
//*-----------------------------------------------------------------

string sRech
integer iSelectRow


sRech = "ID_COUR = '" + asIdCour + "'"
iSelectRow = uo_courrier.dw_source.find ( sRech, 1, uo_courrier.dw_source.rowcount() )

uo_courrier.dw_source.SetFocus ( )
uo_courrier.dw_source.scrolltorow ( iSelectRow )
uo_courrier.dw_source.SetRow ( iSelectRow  )
uo_courrier.dw_source.selectrow ( iSelectRow , true)

end event

event ue_dwsource_sqlpreview;call super::ue_dwsource_sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			:	Uo_Courrier
//*
//* Evenement 		:	Ue_Dwsource_Sqlpreview
//* Auteur			:	N°6
//* Date				:	01/07/1997 10:28:44
//* Libellé			:	Insertion des codes des courriers pour un produit.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JCA	25/05/2007	DCMP 070051 - Fusion des tables [courrier] et [composition], 
//*													toutes les mise à jour se font sur la datawindows dw_paragraphes
//*-----------------------------------------------------------------


////Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

// #1

//String		sSqlPreview			// SqlPreview de la datawindow Dw_1.
//String		sIdCour				// Code courrier type du courrier.
//String		sIdNatCour			// Identifiant du courrier.
//String		sAltConf				// flag pour la confirmation.
//String		sMajPar				// Auteur de la mise à jour.
//
//String		sTable				// Nom de la table à tracer.
//String		sType					// Type d'action effectuer sur la table.
//String		sCle [ 2 ]			// Tableau de l'identifiant de l'enregistrement tracé.
////Migration PB8-WYNIWYG-03/2006 FM
////String		sCol [ 10 ]			// Tableau des colonnes de la table : nom de ces colonnes.
////String		sVal [ 10 ]			// Tableau des valeurs des colonnes à tracer.
//String		sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal []			// Tableau des valeurs des colonnes à tracer.
////Fin Migration PB8-WYNIWYG-03/2006 FM
//Long			lLig					// N° de la ligne à insèrer ou supprimer.
//
//DateTime		dtMajLe

//dwBuffer		dwBuf					// buffer de donnée de la Dw.
////Migration PB8-WYNIWYG-03/2006 FM
////sSqlPreview = Uo_Courrier.Dw_Source.GetSqlPreview ()
//sSqlPreview = sql_syntax
////Fin Migration PB8-WYNIWYG-03/2006 FM
///*------------------------------------------------------------------*/
///* Initialisation pour la Trace.                                    */
///*------------------------------------------------------------------*/
//sTable		= "COUR_PROD"
//
///*------------------------------------------------------------------*/
///* Permet d'obtenir le N° de l'enregistrement à inserer.            */
///*------------------------------------------------------------------*/
////Migration PB8-WYNIWYG-03/2006 FM
////Uo_Courrier.Dw_Source.GetUpdateStatus ( lLig, dwBuf )		
//lLig = ligne
//dwBuf = buffer_dw
////Fin Migration PB8-WYNIWYG-03/2006 FM
//
//Choose Case Left ( sSqlPreview, 4 )
//
//	Case "INSE"
//
//		sIdNatCour	= Uo_Courrier.Dw_Source.GetItemString 	( lLig, "ID_NAT_COUR" )
//		sIdCour		= Uo_Courrier.Dw_Source.GetItemString 	( lLig, "ID_COUR"     )
//		sAltConf	 	= 'N'
//		dtMajLe     = Dw_1.GetItemDateTime 						( 1 , "MAJ_LE"  )
//	   sMajPar		= stGLB.sCodOper
//
//		/*------------------------------------------------------------------*/
//		/* Procédure d'insertion.                                           */
//		/*------------------------------------------------------------------*/
//
//		F_Execute ( "Exec sysadm.DW_I01_COUR_PROD " + String ( idcIdProd ) + " , " + &
//									 	 "'" + sIdNatCour + "', " + &
//										 "'" + sIdCour    + "', " + &
//										 "'" + sAltConf   + "', " + &
//									 	 "'" + String ( dtMajLe ) + "', " + &
//									 	 "'" + String ( dtMajLe ) + "', " + &
//  									 	 "'" + sMajPar + "'", itrTrans )
//
//		If itrTrans.SqlCode <> 0	Then
////Migration PB8-WYNIWYG-03/2006 FM
////			Uo_Courrier.Dw_Source.SetActionCode ( 1 )
//			ll_ret = 1
////Fin Migration PB8-WYNIWYG-03/2006 FM
//		Else
//
//			sCol = { "ID_PROD" , "ID_NAT_COUR" , "ID_COUR" , &
//                  "ID_CONF_DEB", "ID_CONF_N", "ID_CONF_FIN", "ALT_CONF" }
//
//			sVal [ 1 ]  = "'" + String ( idcIdProd   ) + "'"
//			sVal [ 2 ]  = "'" + sIdNatCour             + "'"
//			sVal [ 3 ]  = "'" + sIdCour                + "'"
//			sVal [ 4 ]  = f_GetItem ( Dw_1, 1, "ID_CONF_DEB"  )
//			sVal [ 5 ]  = f_GetItem ( Dw_1, 1, "ID_CONF_N"    )
//			sVal [ 6 ]  = f_GetItem ( Dw_1, 1, "ID_CONF_FIN"  )
//			sVal [ 7 ]  = "'" + sAltConf               + "'"
//
//
//
//			sCle [ 1 ]	= sVal [ 1 ]
//			sCle [ 2 ]	= sVal [ 2 ]
//
//			sType = 'I'
//
//			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
////Migration PB8-WYNIWYG-03/2006 FM
////				Uo_Courrier.Dw_Source.SetActionCode ( 1 )
//				ll_ret = 1
////Fin Migration PB8-WYNIWYG-03/2006 FM
//			Else
////Migration PB8-WYNIWYG-03/2006 FM
////				Uo_Courrier.Dw_Source.SetActionCode ( 2 )
//				ll_ret = 2
////Fin Migration PB8-WYNIWYG-03/2006 FM
//			End If
//
//		End If
//
//	Case	"UPDA"
//
//		uoGsTrace.uf_PreparerTrace ( sSqlPreview, sCol, sVal )
//
//		sCle [ 1 ]	= "'" + String ( idcIdProd ) + "'"
//		sCle [ 2 ]	= "'" + Uo_Courrier.Dw_Source.GetItemString ( lLig, "ID_NAT_COUR" ) + "'"
//
//		sType = 'U'
//
//		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
////Migration PB8-WYNIWYG-03/2006 FM
////			Uo_Courrier.Dw_Source.SetActionCode ( 1 )
//			ll_ret = 1
////Fin Migration PB8-WYNIWYG-03/2006 FM
//		End If
//
//	Case	"DELE"
//
//		sIdNatCour	= Uo_Courrier.Dw_Source.GetItemString ( lLig, "ID_NAT_COUR", DELETE!, False )
//
//		F_Execute ( "Exec sysadm.DW_D01_COUR_PROD " + String (idcIdProd) + ", '" + sIdNatCour + "'", SQLCA )
//
//		If itrTrans.SqlCode <> 0	Then
////Migration PB8-WYNIWYG-03/2006 FM
////			Uo_Courrier.Dw_Source.SetActionCode ( 1 )
//			ll_ret = 1
////Fin Migration PB8-WYNIWYG-03/2006 FM
//		Else
//
//			sCle [ 1 ] = "'" + String ( idcIdProd   ) + "'"
//			sCle [ 2 ] = "'" + sIdNatCour 				+ "'"
//
//			sType = 'D'
//
//			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
////Migration PB8-WYNIWYG-03/2006 FM
////				Uo_Courrier.Dw_Source.SetActionCode ( 1 )
//				ll_ret = 1
////Fin Migration PB8-WYNIWYG-03/2006 FM
//			Else
////Migration PB8-WYNIWYG-03/2006 FM
////				Uo_Courrier.Dw_Source.SetActionCode ( 2 )
//				ll_ret = 2
////Fin Migration PB8-WYNIWYG-03/2006 FM
//			End If
//
//		End If
//
//End Choose

// #1 - FIN

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM


end event

event ue_dwsource_retrieve;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_courrier
//* Evenement 		:	Ue_dwSource_Retrieve - OVERRIDE
//* Auteur			:	N°6
//* Date				:	30/06/97 16:50:14
//* Libellé			:	On renseigne la Dw source.
//* Commentaires	:	Courriers affectés au produit.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Par défaut, on gére un seul argument de type string dans le      */
/* retrieve.                                                        */
/*------------------------------------------------------------------*/

ilLigSource = dw_Source.Retrieve  ( idcIdProd )

end event

event ue_dwsource_dclick;call super::ue_dwsource_dclick;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_courrier
//* Evenement 		:	Ue_Dwsource_Dclick
//* Auteur			:	N°6
//* Date				:	01/07/97 15:52:13
//* Libellé			:	Ouvre la fenêtre permettant de saisir les confirmations
//*					 	pour le courrier sélectionné.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JCA	16/04/2007	DCMP 070051 - code mort 			  
//*-----------------------------------------------------------------

//s_pass		stPass				// structure de passage pour l'appel de W_td_sp_ConFirmation.
//
//SetPointer ( HourGlass! )
//
//stPass = istPass
//
//stPass.bInsert     = False
//stPass.bControl		= False
//stPass.bSupprime   = False
//
//stPass.lTab [ 1 ]  = Uo_Courrier.ilLigSourceClick
//
//f_OuvreTraitement ( W_Td_sp_Confirmation, stPass )

long lLig
s_pass		stPass				// structure de passage pour l'appel de w_t_sp_paragraphe_cour_prod

SetPointer ( HourGlass! )
stPass = istPass

lLig = ilLigSourceClick

stPass.trTrans 		= istPass.trTrans
stPass.wParent			= Parent.Parentwindow()
stPass.bEnableParent	= False

stPass.lTab[1] =	lLig
stPass.lTab[2]	=	dw_1.GetItemNumber ( 1,"ID_PROD" )

stPass.sTab[1]	=	Uo_Courrier.Dw_Source.GetItemString ( lLig, "ID_COUR" )

if not isValid ( w_t_sp_paragraphe_cour_prod ) then
	OpenWithParm ( w_t_sp_paragraphe_cour_prod, stPass, stPass.wParent )
else
	w_t_sp_paragraphe_cour_prod.idcIdProd = dw_1.GetItemNumber ( 1,"ID_PROD" )
	//w_t_sp_paragraphe_cour_prod.isIdCour = Uo_Courrier.Dw_Source.GetItemString ( lLig, "ID_COUR" )
	w_t_sp_paragraphe_cour_prod.isIdCour = Uo_Courrier.Dw_Source.GetItemString ( lLig, "ID_NAT_COUR" )
	w_t_sp_paragraphe_cour_prod.show()
	
end if

w_t_sp_paragraphe_cour_prod.Title = "Gestion du courrier - " + Uo_Courrier.Dw_Source.GetItemString ( lLig, "LIB_CODE" ) + " - " + Uo_Courrier.Dw_Source.GetItemString ( lLig, "ID_COUR" )
end event

event ue_dwsource_supprime;call super::ue_dwsource_supprime;//*-----------------------------------------------------------------
//*
//* Objet 			:	uo_courrier
//* Evenement 		:	ue_dwSource_Supprime
//* Auteur			:	N°6
//* Date				:	20/06/97 16:08:44
//* Libellé			:	Lors de la suppression d'une ligne de la liste des courriers affectés
//*					 	on le "Copy" dans le Buffer DELETE! de Dw_Source.
//*						Seulement si le status de la ligne est à NotModified! ou DataModified!.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* 		PHG	30/05/2006	[MIGPB8COR] Correction de la suppression
//* #1	JCA	23/05/2007	DCMP 070051 - Fusion des table [courrier] et [composition] en [cour_prod]
//*-----------------------------------------------------------------

dwItemStatus	dwItemStat			// Statut de la ligne courante.
// integer			li_Ligsup			// [MIGPB8COR] : indice ligne à supprimer

string sIdCour, sFiltreOrigParagraphe, sFiltreSupp // #1
integer iSuppLigne, iTotCountSupp// #1
String sIdNatCour

/*------------------------------------------------------------------*/
/* S'il y a bien une ligne courante,                                */
/* Si le statut de la ligne est NotModified ou DataModified :       */
/* 	- On copie la ligne dans le buffer DELETE! de DW_SOURCE.      */
/*------------------------------------------------------------------*/

If This.ilLigSourceSupp > 0 Then

	dwItemstat = Dw_Source.GetItemStatus ( This.ilLigSourceSupp , 0 , PRIMARY!)

	If ( dwItemStat = NotModified! Or dwItemStat = DataModified! ) Then

		// [MIGPB8COR]
//		dw_Source.RowsCopy ( This.ilLigSourceSupp, This.ilLigSourceSupp, Primary!, Dw_Source, &
//									Dw_Source.DeletedCount ( ) + 1, DELETE! 	)
//		remplacé par :

// #1 la gestion de mise à jour se fait dw_paragraphes
//		li_Ligsup = Dw_Source.DeletedCount() + 1
//		dw_source.object.data.Delete[li_Ligsup] = &
//			dw_source.object.data.Primary[This.ilLigSourceSupp]
//		dw_source.setitemstatus(li_Ligsup, 0 , Delete!, DataModified!)
//		dw_source.setitemstatus(li_Ligsup, 0 , Delete!, NotModified!)

		sIdCour = uo_courrier.dw_source.object.id_cour[this.ilLigSourceSupp]

 		sIdNatCour = uo_courrier.dw_source.object.id_nat_cour[this.ilLigSourceSupp] // 	[COUR_PROD] 
		 
		// Sauvegarde du filtre original
		sFiltreOrigParagraphe = dw_paragraphes.Describe ("DataWindow.Table.filter") 
		If sFiltreOrigParagraphe = "?" Then sFiltreOrigParagraphe = ""

		sFiltreSupp = "ID_PROD = " + string(idcidprod) + " AND ID_COUR = '" + sIdCour + "'"
		
		dw_paragraphes.SetFilter ( sFiltreSupp )
		dw_paragraphes.Filter ()
		iTotCountSupp = dw_paragraphes.RowCount ()
		
		for iSuppLigne = iTotCountSupp to 1 step -1
			dw_paragraphes.deleterow ( iSuppLigne )
		next
		
		// restauration du filtre d'origine
		dw_paragraphes.SetFilter ( sFiltreOrigParagraphe )
		dw_paragraphes.Filter ( )
		dw_paragraphes.Sort ()

// #1 - FIN
	End If

End If


end event

event constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			:	Uo_Courrier
//* Evenement 		:	Constructor
//* Auteur			:	N°6
//* Date				:	20/06/1997 16:05:04
//* Libellé			:	Initialisation de l'objet
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JCA	25/04/2007	DCMP 070051 - Pour uniformasisation
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* L'objet ne possède pas de titre.                                 */
/*------------------------------------------------------------------*/
ibTitre = False

/*------------------------------------------------------------------*/
/* Utilisation des boutons avec une taille pour des fenêtre 800x600 */
/*------------------------------------------------------------------*/
isTaille = '8_'

/*------------------------------------------------------------------*/
/* Utilisation d'un RowFocusIndicateur : Focus_2                    */
/*------------------------------------------------------------------*/

// #2

//ibIndicateur = True
////Migration PB8-WYNIWYG-03/2006 FM
////isIndicateur = "K:\PB4OBJ\BMP\FOCUS_2.BMP"
//isIndicateur = "K:\PB4OBJ\BMP\FOCUSPB8.BMP"
////Fin Migration PB8-WYNIWYG-03/2006 FM

// FIN - #2
end event

event ue_dwrecherche_retrieve;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_courrier
//* Evenement 		:	Ue_dwRecherche_Retrieve - OVERRIDE
//* Auteur			:	N°6
//* Date				:	30/06/97 16:52:14
//* Libellé			:	On renseigne la Dw Recherche.
//* Commentaires	:	Courriers pouvant être affectés au produit.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Par défaut, on gére un seul argument de type string dans le      */
/* retrieve.                                                        */
/*------------------------------------------------------------------*/

ilLigRecherche = dw_Recherche.Retrieve  ( idcIdProd )

end event

on ue_dimensionner;call u_ajout::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet 			:	uo_courrier
//* Evenement 		:	ue_dimensionner
//* Auteur			:	N°6
//* Date				:	01/07/1997 12:43:56
//* Libellé			:	Rend invisible les boutons permettant de supprimer ou 
//*					 	d'ajouter tout.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uo_Courrier.Pb_enlever_tout.Visible = False
Uo_Courrier.Pb_ajouter_tout.Visible = False
end on

on uo_courrier.destroy
call u_ajout::destroy
end on

event ue_dwcible_supprime;call super::ue_dwcible_supprime;//*-----------------------------------------------------------------
//*
//* Objet			: w_tm_sp_produit
//* Evenement 		: ue_dwcible_supprime
//* Auteur			: JCA
//* Date				: 22/05/2007
//* Libellé			: 
//*-----------------------------------------------------------------
//* MAJ		PAR      Date	     Modification
// 				FPI		20/09/2010	[ITSM45694] Correction perte de connexion sur la liste des §
//*-----------------------------------------------------------------

string sIdCour, sRech
integer iCount, iTotCount, iReturn, iSelectRow

sIdCour = uo_courrier.dw_cible.object.id_cour[this.ilLigSourceSupp]
ids_paragraphe.settransobject(itrtrans) // [ITSM45694]
ids_paragraphe.retrieve ( sIdCour )
iTotCount = ids_paragraphe.RowCount ( )

for iCount = 1 to iTotCount
	ids_paragraphe.setitem( iCount, 'ID_PROD', idcidprod )
	ids_paragraphe.setitem( iCount, 'ALT_CONF', 'N' )
	ids_paragraphe.setitem( iCount, 'MAJ_LE', now() )
	ids_paragraphe.setitem( iCount, 'MAJ_PAR', stglb.scodoper )
next

iReturn = ids_paragraphe.RowsCopy ( 1,  iTotCount, PRIMARY!, dw_paragraphes, 1, PRIMARY! )
uo_courrier.Dw_Cible.SelectRow ( this.ilLigSourceSupp, False )	

this.post event ue_select ( sIdCour )

ids_paragraphe.reset()
end event

type uo_ets from u_ajout within w_tm_sp_produit
integer x = 1632
integer y = 1412
integer width = 288
integer height = 128
integer taborder = 110
boolean border = false
end type

event ue_dwsource_itemchanged;call super::ue_dwsource_itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_ets
//* Evenement 		:	Ue_DwSource_ItemChanged
//* Auteur			:	DBI
//* Date				:	09/09/1997 15:40:33
//* Libellé			:	Test de saisie.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

Integer		iActionCode	= 0	// Action Code à envoyer

/*----------------------------------------------------------------------------*/
/* Test à la saisie du CodEts qu'il y a bien unicité de ce code dans les      */
/* établissements associés au produit.                                        */
/*----------------------------------------------------------------------------*/
Choose Case Upper ( Dw_Source.GetColumnName ( ) )

	Case "ID_ETS"

		iiErreurCodEts = iUoGsEts.Uf_Zn_Ets ( this.Dw_Source.GetText ( )  , &
														idcIdProd							, &
                                         	This.Dw_Source.GetRow  ( ) ) 
		iActionCode 	= iiErreurCodEts
End Choose
//Migration PB8-WYNIWYG-03/2006 FM
//This.Dw_Source.SetActionCode ( iActionCode )
return iActionCode
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on ue_dwcible_supprime;call u_ajout::ue_dwcible_supprime;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_ets
//* Evenement 		: ue_DwCible_Supprime
//* Auteur			: DBI
//* Date				: 21/01/1998 15:06:40
//* Libellé			: On laisse la ligne dans la cible pour pouvoir la transférer plusieurs fois
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------



Dw_Cible.RowsCopy ( This.ilLigSourceSupp, This.ilLigSourceSupp, Primary!, Dw_Cible, &
						  This.ilLigSourceSupp + 1, Primary! 	)
Dw_Cible.SelectRow ( ilLigSourceSupp, False )	




end on

on ue_dwsource_supprime;call u_ajout::ue_dwsource_supprime;//*-----------------------------------------------------------------
//*
//* Objet			:	Uo_Ets
//* Evenement 		:	Ue_DwSource_Supprime
//* Auteur			:	DBI
//* Date				:	09/09/1997 16:53:49
//* Libellé			:	Si l'établissement que l'on essait de supprimer est associé à une révision,
//*                  on annule la suppression.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
Long			dcIdEts			// Identifiant de l'établissement que l'on veut supprimer.
Long			lRet				// Retour uf_SupEts

/*----------------------------------------------------------------------------*/
/* ibSupprime est toujours à False car la suppression de dw_source effectue   */
/* une copie vers Dw_cible.                                                   */
/* Or le groupe existe forcément dans Dw_source. Si on fait la copie, il      */
/* apparait 2 fois.                                                           */
/* On effectue uniquement une suppression de la source                        */
/*----------------------------------------------------------------------------*/

ibSupprime 	= False

dcIdEts		= Dw_Source.GetItemNumber ( ilLigSourceSupp , "ID_ETS" )

lRet			= iuoGsEts.Uf_SupEts ( idcIdProd, dcIdEts )

If lRet > 0 Then

	stMessage.sTitre	= "Suppression d'un établissement"
	stMessage.Icon		= Information!
	stMessage.sCode	= "REFU032"

	Choose Case lRet
	Case 1

		stMessage.sVar[1] = "une révision"
		stMessage.sVar[2] = "supprimer"

	Case 2, 3, 4

		stMessage.sVar[1] = "un sinistre"
		stMessage.sVar[2] = "supprimer"

	End Choose
	f_Message ( stMessage )
Else

	Dw_Source.DeleteRow ( ilLigSourceSupp )
End If

end on

on ue_dwsource_retrieve;//*-----------------------------------------------------------------
//*
//* Objet 			: u_Ajout
//* Evenement 		: Ue_dwSource_Retrieve
//* Auteur			: DBI
//* Date				: 20/01/1998
//* Libellé			: Chargement avec argument type decimal
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* overwrite                                                        */
/*------------------------------------------------------------------*/

ilLigSource = dw_Source.Retrieve ( idcIdProd )
end on

event ue_dwsource_itemerror;call super::ue_dwsource_itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			:	Uo_Ets
//* Evenement 		:	UE_DWSOURCE_ITEMERROR
//* Auteur			:	N°6
//* Date				:	23/07/1997 14:48:44
//* Libellé			: 
//* Commentaires	:	Gestion des messages d'erreur suite aux erreurs 
//*					 	de saisies.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

stMessage.sTitre	= "Paramétrage des Etablissements"
stMessage.Icon		= Information!

Choose Case Upper ( Dw_Source.GetColumnName ( ) )

	Case "ID_ETS"

		Choose Case iiErreurCodEts

			Case 0
				stMessage.sVar[1] = "code de l'établissement"
				stMessage.sCode	= "GENE003"

			Case 1

				stMessage.sCode	= "REFU031"

			Case 2, 3, 4

				stMessage.sCode	= "REFU032"
				stMessage.sVar[1] = "un sinistre"
				stMessage.sVar[2] = "modifier"

		End Choose

End Choose

iiErreurCodEts = 0

f_Message ( stMessage )
//Migration PB8-WYNIWYG-03/2006 FM
//Dw_Source.SetActionCode ( 1 )
Return 1
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_ets
//* Evenement 		:	Constructor
//* Auteur			:	N°6
//* Date				:	21/07/97 13:53:52
//* Libellé			:	Initialisation de l'objet définissant les etablissements
//*						du produit.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* L'objet ne possède pas de titre.                                 */
/*------------------------------------------------------------------*/
ibTitre = False

/*------------------------------------------------------------------*/
/* Utilisation des boutons avec une taille pour des fenêtre 800x600 */
/*------------------------------------------------------------------*/
isTaille = '8_'

/*------------------------------------------------------------------*/
/* Utilisation d'un RowFocusIndicateur                              */
/*------------------------------------------------------------------*/
ibIndicateur = True
//Migration PB8-WYNIWYG-03/2006 FM
//isIndicateur = "K:\PB4OBJ\BMP\FOCUS_2.BMP"
isIndicateur = "K:\PB4OBJ\BMP\FOCUSPB8.BMP"
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on ue_dimensionner;call u_ajout::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet 			:	Uo_Ets
//* Evenement 		:	Ue_Dimensionner
//* Auteur			:	N°6
//* Date				:	21/07/97 13:55:52
//* Libellé			: 
//* Commentaires	:	Rend invisible les boutons permettant de
//*					 	supprimer ou d'ajouter tout.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.Pb_enlever_tout.Visible = False
This.Pb_ajouter_tout.Visible = False
end on

on uo_ets.destroy
call u_ajout::destroy
end on

type uo_info from u_ajout within w_tm_sp_produit
integer x = 1248
integer y = 1412
integer width = 288
integer height = 128
integer taborder = 100
end type

event ue_dwsource_sqlpreview;call super::ue_dwsource_sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Info
//* Evenement 		: Ue_DwSource_SqlPreview
//* Auteur			: YP
//* Date				: 26/08/1997 11:05:24
//* Libellé			: 
//* Commentaires	: Insertion des paragraphes d'infos pour un produit
//*					  dans la table PARA_PROD.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long			lLig					// N° de la ligne à insèrer.
Long			dcIdProd				// Identifiant du produit.

dwBuffer		dwBuf					// buffer de donnée de la Dw.

DateTime		dtMajLe				// Date de Mise à Jour.

String		sSql					// commande SQL qui doit être envoyée.
String		sTable				// Nom de la table à tracer.
String		sType					// Type d'action effectuer sur la table.
String		sCle [ 2 ]			// Tableau de l'identifiant de l'enregistrement tracé.
String		sCol [ 5 ]			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal [ 5 ]			// Tableau des valeurs des colonnes à tracer.
String		sMajPar				// auteur de la mise à jour.
String		sIdPara				// Identifiant du paragraphe.
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

//Migration PB8-WYNIWYG-03/2006 FM
//sSql = Uo_Info.dw_Source.GetSqlPreview ()
sSql = sql_syntax
//Fin Migration PB8-WYNIWYG-03/2006 FM
/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "PARA_PROD"

/*------------------------------------------------------------------*/
/* Permet d'obtenir le N° de l'enregistrement à inserer.            */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Uo_Info.Dw_Source.GetUpdateStatus ( lLig, dwBuf )
lLig = ligne
dwBuf = buffer_dw
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case Left ( sSql, 4 )

	Case "INSE"

		sIdPara	=	Uo_Info.Dw_Source.GetItemString ( lLig , "ID_PARA" )
		dtMajLe	=	Dw_1.GetItemDateTime ( 1 , "MAJ_LE"  )
		sMajPar	=	stGLB.sCodOper

		/*----------------------------------------------------------------------------*/
		/* Procédure d'insertion.                                                     */
		/*----------------------------------------------------------------------------*/
		iTrTrans.DW_I01_PARA_PROD	(	idcIdProd , sIdPara , dtMajLe , dtMajLe , sMajPar )

		If itrTrans.SqlCode <> 0 Then
//Migration PB8-WYNIWYG-03/2006 FM
//			Uo_Info.Dw_Source.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol = { "ID_PROD", "ID_PARA" }

			sVal [ 1 ] = "'" + String ( idcIdProd ) 	+ "'"
			sVal [ 2 ] = "'" + sIdPara						+ "'"

			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]	= sVal [ 2 ]

			sType = 'I'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				Uo_Info.Dw_Source.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				Uo_Info.Dw_Source.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End IF

	/*------------------------------------------------------------------*/
	/* Il n'y a pas de colonne saisissable, il ne peut donc y avoir     */
	/* d'UPDATE.                                                        */
	/*------------------------------------------------------------------*/
	/* Case  "UPDA" */


	Case	"DELE"

		sIdPara		= Uo_Info.Dw_Source.GetItemString ( lLig , "ID_PARA" , DELETE! , False )

		itrTrans.DW_D01_PARA_PROD ( idcIdProd , sIdPara )

		If itrTrans.SqlCode <> 0 Then
//Migration PB8-WYNIWYG-03/2006 FM
//			Uo_Info.Dw_Source.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCle [ 1 ]	= "'" + String ( dcIdProd ) 	+ "'"
			sCle [ 2 ]	= "'" + sIdPara					+ "'"

			sType = 'D'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				Uo_Info.Dw_Source.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				Uo_Info.Dw_Source.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

End Choose
//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on ue_dwsource_rbuttondown;call u_ajout::ue_dwsource_rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_info
//* Evenement 		:	ue_dwsource_rbuttondown
//* Auteur			:	YP
//* Date				:	11/09/97 15:23:29
//* Libellé			:	Permet de déclencher la visualisation du paragraphe
//*						courant de la ligne courante.
//*						si ligne courante il y a et si § il y a
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String		sCol		// Colonne sur laquelle se trouve le curseur
Long			lLig		// Ligne sur laquelle se trouve le curseur

s_Pass		stPass

lLig	=	f_GetObjectAtPointer ( This.Dw_Source, sCol )

If lLig > 0 Then

	This.Dw_Source.ScrollToRow ( lLig )
	This.Dw_Source.SetRow ( lLig )

	stPass.trTrans	=	Parent.itrTrans
	stPass.sTab[1]	=	This.Dw_Source.GetItemString ( lLig, "ID_PARA" )
	stPass.sTab[2]	=	" Paragraphe " + This.Dw_Source.GetItemString ( lLig, "ID_PARA" )

	If	Not ( IsNull ( stPass.sTab [ 1 ] ) )	Then

		If	IsValid ( W_Consulter_Paragraphe )	Then

			W_Consulter_Paragraphe.Show ()

		Else

			Open ( W_Consulter_Paragraphe )

		End If

		W_Consulter_Paragraphe.Wf_AfficherParagraphe ( stPass )

	End If

End If
end on

on ue_dwrecherche_retrieve;//*-----------------------------------------------------------------
//*
//* Objet 			: u_Ajout
//* Evenement 		: Ue_dwRecherche_Retrieve - OVERRIDE
//* Auteur			: YP
//* Date				: 26/08/1997 15:04:38
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

ilLigRecherche = dw_Recherche.Retrieve ( idcIdProd )
end on

on ue_dwsource_retrieve;//*-----------------------------------------------------------------
//*
//* Objet 			: u_Ajout
//* Evenement 		: Ue_dwSource_Retrieve - OVERRIDE
//* Auteur			: YP
//* Date				: 26/08/1997 12:11:38
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

ilLigSource = dw_Source.Retrieve ( idcIdProd )
end on

on constructor;call u_ajout::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Info
//* Evenement 		: CONSTRUCTOR
//* Auteur			: YP
//* Date				: 26/08/1997 11:04:04
//* Libellé			: 
//* Commentaires	: Initialisation de l'objet permettant de gérer les
//*					  paragraphes d'informations.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* L'objet ne possède pas de titre.                                 */
/*------------------------------------------------------------------*/
ibTitre = False

/*------------------------------------------------------------------*/
/* Utilisation des boutons avec une taille pour des fenêtre 800x600 */
/*------------------------------------------------------------------*/
isTaille = '8_'
end on

on ue_dimensionner;call u_ajout::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Info
//* Evenement 		: Ue_Dimensionner
//* Auteur			: YP
//* Date				: 26/08/1997 10:50:56
//* Libellé			: 
//* Commentaires	: Rend invisible les boutons permettant de supprimer ou 
//*					  d'ajouter tout.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uo_Info.Pb_enlever_tout.Visible = False
Uo_Info.Pb_ajouter_tout.Visible = False
end on

on ue_dwsource_supprime;call u_ajout::ue_dwsource_supprime;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_info
//* Evenement 		: ue_dwSourceSupprime
//* Auteur			: Y. Picard
//* Date				: 26/08/97 11:10:44
//* Libellé			: Lors de la suppression d'un record de la liste des paragraphes d'info
//*                 affectés, on le Copy dans le Buffer DELETE! de Dw_Source SI le status de la
//*						ligne est à NotModified! ou DataModified!.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* PHG			30/05/2006	  [MIGPB8COR]: Correction de la suppression
//* 		 
//*-----------------------------------------------------------------

dwItemStatus	dwItemStat			//Statut de la ligne courante.
integer			li_Ligsup			// [MIGPB8COR] : indice ligne à supprimer

/*------------------------------------------------------------------*/
/* S'il y a bien une ligne courante,                                */
/* Si le statut de la ligne courante est NotModified ou             */
/* DataModified, on copie la ligne dans le buffer DELETE! de        */
/* dw_source.                                                       */
/*------------------------------------------------------------------*/

If ilLigSourceSupp > 0 Then

	dwItemstat = Dw_Source.GetItemStatus ( ilLigSourceSupp , 0 , PRIMARY!)

	If ( dwItemStat = NotModified! Or dwItemStat = DataModified! ) Then &
		// [MIGPB8COR]
//		dw_Source.RowsCopy ( This.ilLigSourceSupp, This.ilLigSourceSupp, Primary!, Dw_Source, &
//									Dw_Source.DeletedCount ( ) + 1, DELETE! 	)
//		remplacé par :
		li_Ligsup = Dw_Source.DeletedCount() + 1
		dw_source.object.data.Delete[li_Ligsup] = &
			dw_source.object.data.Primary[This.ilLigSourceSupp]
		dw_source.setitemstatus(li_Ligsup, 0 , Delete!, DataModified!)
		dw_source.setitemstatus(li_Ligsup, 0 , Delete!, NotModified!)

	End If

End If

end on

on uo_info.destroy
call u_ajout::destroy
end on

type uo_onglets3 from u_onglets within w_tm_sp_produit
integer x = 46
integer y = 508
integer width = 997
integer height = 116
integer taborder = 30
boolean border = false
end type

type uo_bord3d3 from u_bord3d within w_tm_sp_produit
integer x = 2304
integer y = 40
integer width = 306
integer height = 104
integer taborder = 90
end type

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_3d::Constructor (OVERRIDE)
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 14:57:30
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne le Bord en 3D, puis on appelle la construction     */
/* normale.                                                         */
/*------------------------------------------------------------------*/

This.X			=   79			// Valeur De Onglet3.X + 9
This.Y			=  386			// Valeur De Onglet3.Y + 96
This.Width		= 3250
This.Height		= 1240

Call U_Bord3D::Constructor
end on

on uo_bord3d3.destroy
call u_bord3d::destroy
end on

type dw_relances from u_datawindow within w_tm_sp_produit
integer x = 2784
integer y = 1412
integer width = 288
integer height = 128
integer taborder = 10
string dataobject = "d_sp_prod_relances"
boolean border = false
end type

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_relances
//* Evenement 		: ItemChanged
//* Auteur			: Fabry JF
//* Date				: 01/06/1999 17:01:49
//* Libellé			: Contrôles de Champs
//* Commentaires	: On ne contrôle pas les unités de temps associées aux délai, 
//*					  car elles ne peuvent par définition jamais être à null ou à vide.
//*					  L'initialisation de la Dw force ces champs à M (Mois).
//*					  
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Gestion des Contrôles, via l'objet.                              */
/*------------------------------------------------------------------*/

// [MIGPB8COR] PHG
//iuoGsRelances.uf_Zn_Trt ( 1 )
return iuoGsRelances.uf_Zn_Trt ( 1 )

end event

event itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_Relances
//* Evenement 		:	ITEMERROR
//* Auteur			:	Fabry JF
//* Date				:	02/06/1999 15:22:24
//* Libellé			:	Gestion des erreurs de saisies.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Gestion des erreurs, via l'objet.                                */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//iuoGsRelances.uf_Zn_Trt ( 2 )
Return iuoGsRelances.uf_Zn_Trt ( 2 )
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type dw_lst_grp_grpsherpa from datawindow within w_tm_sp_produit
boolean visible = false
integer x = 3122
integer y = 968
integer width = 288
integer height = 128
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_spb_lst_groupe"
boolean livescroll = true
end type

type dw_paragraphes from u_datawindow within w_tm_sp_produit
boolean visible = false
integer x = 3122
integer y = 1132
integer width = 288
integer height = 128
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_sp_compo_para_cour_prod"
end type

event dberror;call super::dberror;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_PAragraphes
//* Evenement 		:	dberror
//* Auteur			:	N°6 (JCA)
//* Date				:	20/06/97 16:21:14 (02/05/2007)
//* Libellé			:	En cas d'erreur base, on rollbacke la trace.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ 	PAR		Date			Modification
//* #0	JCA	02/05/2007		DCMP 070051 - reprise du code à partir des autres DataWindow
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On désactive le mode incrémentation autonome. (voir la fonction  */
/* elle-même pour                                                   */
/* quelques explications sur ce mode d'utilisation de la trace ou   */
/* l'analyse des traitements de la trace !)                         */
/*------------------------------------------------------------------*/
UoGsTrace.uf_ModeIncAutonome ( False )

UoGsTrace.Uf_CommitTrace ( False )
end event

event sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			:	dw_paragraphe
//* Evenement 		:	UE_DWSOURCE_SQLPREVIEW
//* Auteur			:	JCA
//* Date				:	02/05/2007
//* Libellé			:	Trace des modifications dans la table COUR_PROD
//*	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sIdCour
String	sIdPara			// Identifiant du paragraphe
decimal	dcIdOrdre		// Ordre du paragraphe dans la compo.

String	sTable			// Nom de la table à tracer.
String	sType				// Type d'action effectuer sur la table.
String	sCle [ 4 ]		// Tableau de l'identifiant de l'enregistrement tracé.
String	sCol [ 4 ]		// Tableau des colonnes de la table : nom de ces colonnes.
String	sVal [ 4 ]		// Tableau des valeurs des colonnes à tracer.

string	sRech
integer	iParagrapheCount, iRow

Long		ll_return = 0

/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "COUR_PROD"

Choose Case Left ( sqlsyntax, 4 )

	Case "INSE"
		
//		iParagrapheCount = dw_paragraphes.rowcount ()
//		sRech = "ID_PROD = " + String ( idcIdProd ) + "ID_COUR = '" + isidcour + "'"
//		iRow = dw_paragraphes.find( sRech, 1, iParagrapheCount )

		sIdCour	 = dw_paragraphes.GetItemString   ( row, "ID_COUR"  )
		sIdPara	 = dw_paragraphes.GetItemString   ( row, "ID_PARA"  )
		dcIdOrdre = dw_paragraphes.GetItemNumber   ( row, "ID_ORDRE" )

		sCol = { "ID_PROD", "ID_COUR", "ID_PARA", "ID_ORDRE" }
	
		sVal [ 1 ] = "'" + String ( idcIdProd ) + "'"
		sVal [ 2 ] = "'" + sIdCour + "'"
		sVal [ 3 ] = "'" + sIdPara + "'"
		sVal [ 4 ] = "'" + String ( dcIdOrdre ) + "'"
	
		sCle [ 1 ]	= sVal [ 1 ]
		sCle [ 2 ]	= sVal [ 2 ]
		sCle [ 3 ]	= sVal [ 3 ]
		sCle [ 4 ]	= sVal [ 4 ]
		sType = 'I'
	
		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
			ll_return = 1
	
		End If

	Case "UPDA"

		sIdCour	 = dw_paragraphes.GetItemString   ( row, "ID_COUR"  )
		sIdPara	 = dw_paragraphes.GetItemString   ( row, "ID_PARA"  )
		dcIdOrdre = dw_paragraphes.GetItemNumber   ( row, "ID_ORDRE" )

		sCol = { "ID_PROD", "ID_COUR", "ID_PARA", "ID_ORDRE" }
	
		sVal [ 1 ] = "'" + String ( idcIdProd )  + "'"
		sVal [ 2 ] = "'" + sIdCour    + "'"
		sVal [ 3 ] = "'" + sIdPara   + "'"
		sVal [ 4 ] = "'" + String ( dcIdOrdre ) + "'"
	
		sCle [ 1 ]	= sVal [ 1 ]
		sCle [ 2 ]	= sVal [ 2 ]
		sCle [ 3 ]	= sVal [ 3 ]
		sCle [ 4 ]	= sVal [ 4 ]
		sType = 'U'
	
		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
			ll_return = 1
	
		End If

	Case "DELE"

		sIdCour	 = dw_paragraphes.GetItemString   ( row, "ID_COUR", DELETE!, false )
		sIdPara	 = dw_paragraphes.GetItemString   ( row, "ID_PARA", DELETE!, false  )
		dcIdOrdre = dw_paragraphes.GetItemNumber   ( row, "ID_ORDRE", DELETE!, false )

		sCol = { "ID_PROD", "ID_COUR", "ID_PARA", "ID_ORDRE" }
	
		sVal [ 1 ] = "'" + String ( idcIdProd ) + "'"
		sVal [ 2 ] = "'" + sIdCour + "'"
		sVal [ 3 ] = "'" + sIdPara + "'"
		sVal [ 4 ] = "'" + String ( dcIdOrdre ) + "'"
	
		sCle [ 1 ]	= sVal [ 1 ]
		sCle [ 2 ]	= sVal [ 2 ]
		sCle [ 3 ]	= sVal [ 3 ]
		sCle [ 4 ]	= sVal [ 4 ]
		sType = 'D'
	
		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
			ll_return = 1
	
		End If

End Choose

Return ll_return
end event

type dw_det_pro from u_datawindow within w_tm_sp_produit
boolean visible = false
integer x = 3122
integer y = 1292
integer width = 288
integer height = 128
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_lst_det_pro_modif"
end type

event dberror;call super::dberror;//*-----------------------------------------------------------------
//*
//* Objet 			:	dw_det_pro
//* Evenement 		:	dberror
//* Auteur			:	N°6 (JCA)
//* Date				:	20/06/97 16:21:14 (02/05/2007)
//* Libellé			:	En cas d'erreur base, on rollbacke la trace.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ 	PAR		Date			Modification
//* #0	JCA	02/05/2007		DCMP 070051 - reprise du code à partir des autres DataWindow
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On désactive le mode incrémentation autonome. (voir la fonction  */
/* elle-même pour                                                   */
/* quelques explications sur ce mode d'utilisation de la trace ou   */
/* l'analyse des traitements de la trace !)                         */
/*------------------------------------------------------------------*/
UoGsTrace.uf_ModeIncAutonome ( False )

UoGsTrace.Uf_CommitTrace ( False )
end event

type uo_relance_pm407_1 from u_sp_relance_pm407_1 within w_tm_sp_produit
boolean visible = false
integer x = 3131
integer y = 1440
integer width = 288
integer height = 128
integer taborder = 20
boolean bringtotop = true
end type

on uo_relance_pm407_1.destroy
call u_sp_relance_pm407_1::destroy
end on

