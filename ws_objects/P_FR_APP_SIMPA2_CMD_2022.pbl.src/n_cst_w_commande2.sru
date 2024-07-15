HA$PBExportHeader$n_cst_w_commande2.sru
$PBExportComments$Objet li$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$la fen$$HEX1$$ea00$$ENDHEX$$tre Commande2
forward
global type n_cst_w_commande2 from u_gs_sp_sinistre_anc
end type
end forward

global type n_cst_w_commande2 from u_gs_sp_sinistre_anc
end type
global n_cst_w_commande2 n_cst_w_commande2

type variables
Private:

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.           */
/*------------------------------------------------------------------*/
DataWindow		idw_wDetail

/*------------------------------------------------------------------*/
/* CAG 03/06/2003 : ajout de la zone ID_ANN  */
/*------------------------------------------------------------------*/
DataWindow		idw_AnnCmde
DataWindow		idw_Commune
DataWindow		idw_TacImei
DataWindow		idw_autorisation // [DCMP080479]

u_DataWindow		idw_TrtCmde
u_DataWindow		idw_TrtClient
/*------------------------------------------------------------------*/
/* DCMP 030207 : CAG 07/05/03                     */
/*------------------------------------------------------------------*/
u_DataWindow		idw_TrtCmde_Frn

u_DataWindow_Detail	idw_LstCmde
u_DataWindow_Detail	idw_LstGti

//*  JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
u_DataWindow_Detail	idw_DivDet
u_DataWindow_Detail	idw_wDivSin   // [WEBSIM2].[FRANCE]


/*------------------------------------------------------------------*/
/* DCMP 030207 : CAG 07/05/03                     */
/*------------------------------------------------------------------*/
Integer			iiNbMaxPg = 3	//  nbre de pages max $$HEX2$$e0002000$$ENDHEX$$g$$HEX1$$e900$$ENDHEX$$rer
Integer			iiCptPgCte	//  compteur de page courante

U_DataWindow		idwPg[3]		// tableau des dw correspondant aux pages
String			isPgCol[3]	// tableau des colonnes recevant le focus sur activation d'une page

CommandButton		icbPrec		// bouton pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent de la fen$$HEX1$$ea00$$ENDHEX$$tre w_gs_sp_w_commande2
CommandButton		icbSuiv		// bouton suivant de la fen$$HEX1$$ea00$$ENDHEX$$tre w_gs_sp_w_commande2
CommandButton		icbPrem		// bouton premier de la fen$$HEX1$$ea00$$ENDHEX$$tre w_gs_sp_w_commande2
CommandButton		icbDern		// bouton dernier de la fen$$HEX1$$ea00$$ENDHEX$$tre w_gs_sp_w_commande2
CommandButton		icbComLiv	// bouton v$$HEX1$$e900$$ENDHEX$$rif Commune livraison
CommandButton		icbComFac	// bouton v$$HEX1$$e900$$ENDHEX$$rif Commune facturation
CommandButton		icbImei		// Bouton r$$HEX1$$e900$$ENDHEX$$cup IMEI Adh origine
CommandButton		icbModifAdr	// [PM246]

StaticText		istAffPgCmd	// affichage de la page courante de la fen$$HEX1$$ea00$$ENDHEX$$tre w_gs_ps_w_commande2

Boolean			ibAltCommune   // DCMP 030362 Gestion des commune O/N

long 				ilIdProcess //  [PC321]
end variables

forward prototypes
public subroutine uf_preparermodifier (ref s_pass astpass)
private subroutine uf_protegerzone ()
public function string uf_controlersaisie ()
private function string uf_formatage_heure (string astext)
public function string uf_controlergestion ()
private function string uf_formatage_email (string astext)
private function string uf_formatage_cp (string astext)
public function integer uf_annuler_cmde ()
private function string uf_formatage_tel (string astext, boolean abswitch)
public function boolean uf_preparervalider ()
private subroutine uf_modifier_icone_sfr ()
private subroutine uf_zn_adrcp (string asval, boolean abinit)
private function string uf_controlergestion_cegetel ()
private subroutine uf_controlersaisie_commune (ref string aspos)
private subroutine uf_controlersaisie_tacimei (ref string aspos)
private function integer uf_zn_idserieanc (ref u_datawindow adw, string asdata, long alrow)
private function integer uf_zn_probleme (ref u_datawindow adw, string asdata, long alrow)
private subroutine uf_epuration_zonecommune (ref string asville, ref integer aicode)
private subroutine uf_controlersaisie_cp (ref string aspos)
public subroutine uf_gestionboutons (integer ainumpg, string asbouton, boolean abposdef)
private function string uf_controlergestion_darty ()
private subroutine uf_gestionzone_infospbfrn ()
public function long uf_controlerzone (string asdw, string asnomcol, string asdata)
public function long uf_gerermessage (string asdw)
public subroutine uf_majpec (long alidgti, long aliddetail)
public function integer uf_bt_supprimer_cmd (ref long alidgti, ref long aliddetail)
public function boolean uf_getautorisation (long aliddroit)
private function integer uf_zn_infospbfrn (ref u_datawindow adw, string asdata, long alrow)
private function boolean uf_getautorisation (long aliddroit, string asidfour)
public function boolean uf_getautorisation_221 (long alidprocess)
public function datawindow uf_get_dwdetpro ()
public function long uf_get_idprod ()
public subroutine uf_initialiser (ref s_pass astpass, ref commandbutton acbprec, ref commandbutton acbsuiv, ref commandbutton acbprem, ref commandbutton acbdern, ref commandbutton acbcomliv, ref commandbutton acbcomfac, ref commandbutton acbimei, ref statictext astaffpgcmd, commandbutton acbmodifadr)
public function boolean uf_cmdeauto_dt57 (long adcidsin, long aiidseq)
public function integer uf_zn_adrcodciv (datawindow adw, string asdata, long alrow)
end prototypes

public subroutine uf_preparermodifier (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::Uf_PreparerModifier (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 31/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Pr$$HEX1$$e900$$ENDHEX$$paration de la modification d'une commande
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    CAG		07/05/03	DCMP 030207 : Ajout de 6 zones en retour de Cetelec (pour Cegetel Must)
//*								=> ajout d'une dw suppl$$HEX1$$e900$$ENDHEX$$mentaire => modif gestion des boutons prec et suiv
//* #2	 CAG		03/06/03 Ajout de la zone ID_ANN = cat$$HEX1$$e900$$ENDHEX$$gorie d'annulation
//* #3	 CAG		24/06/03 Pour les annul de cmde d'ASF, cat$$HEX1$$e900$$ENDHEX$$gorie 2, 3, 4 uniquement
//* #4	 JFF		05/07/04 DCMP 040206
//* #5	 PHG     05/12/06 DCMP xxxxxx Urbanisation : Unification de Focntion
//* #6	 JFF	   20/10/08	[FNAC_PROD_ECH_TECH]
//*-----------------------------------------------------------------

DataWindowChild	dwChild
Long					lCpt, lIdProd, lDeb, lFin
String				sIdFour, sIdTypArt, sModif, sFiltre
n_cst_cmd_commun	lnvCmdCommun

isTypeTrt = astPass.sTab [2]

/*------------------------------------------------------------------*/
/* On recopie la ligne du d$$HEX1$$e900$$ENDHEX$$tail de la fen$$HEX1$$ea00$$ENDHEX$$tre parent dans          */
/* dw_wGarSin de GARANTIE.                                          */
/*------------------------------------------------------------------*/
idw_TrtCmde.Uf_CopierLigne ()

icbComLiv.Enabled = ibAltCommune
icbComFac.Enabled = ibAltCommune

/*------------------------------------------------------------------*/
/* Protection/Deprotection des zones.                               */
/*------------------------------------------------------------------*/
This.Uf_ProtegerZone ()

/*------------------------------------------------------------------*/
/* Formater les N$$HEX2$$b0002000$$ENDHEX$$de T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phones.                                   */
/*------------------------------------------------------------------*/
idw_TrtClient.SetItem ( 1, "ADR_TEL1", Uf_Formatage_Tel ( idw_TrtClient.GetItemString ( 1, "ADR_TEL1" ), TRUE ) )
idw_TrtClient.SetItem ( 1, "ADR_TEL2", Uf_Formatage_Tel ( idw_TrtClient.GetItemString ( 1, "ADR_TEL2" ), TRUE ) )
idw_TrtClient.SetItem ( 1, "ADR_TEL3", Uf_Formatage_Tel ( idw_TrtClient.GetItemString ( 1, "ADR_TEL3" ), TRUE ) )

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* On positionne les icones en fonction du produit.                 */
/*------------------------------------------------------------------*/
uf_Modifier_Icone_Sfr ()
/*------------------------------------------------------------------*/
/* On proc$$HEX1$$e900$$ENDHEX$$de $$HEX2$$e0002000$$ENDHEX$$l'armement des valeurs pour les zones A ou B.       */
/*------------------------------------------------------------------*/
uf_Zn_AdrCp ( idw_TrtClient.GetItemString ( 1, "ADR_CP" ), TRUE )

/*------------------------------------------------------------------*/
/* #1 : CAG 07/05/2003                                              */
/*------------------------------------------------------------------*/
iiCptPgCte = 1
istAffPgCmd.Text = "page 1 / " + String ( iiNbMaxPg )
idwPg [ iiCptPgCte ].Show ()

For lCpt = 2 To iiNbMaxPg
	idwPg [ lCpt ].Hide ()
Next

// CAG 20/05/2003 :  modification des libell$$HEX1$$e900$$ENDHEX$$s de la dw des donn$$HEX1$$e900$$ENDHEX$$es fournisseur
sIdFour = idw_TrtCmde.GetItemString ( 1, "ID_FOUR" )
sIdTypArt = idw_TrtCmde.GetItemString ( 1, "ID_TYP_ART" )
lIdProd = idw_Produit.GetItemNumber ( 1, "ID_PROD" )

// #5 Unification de fonction
//This.uf_Changer_Lib_Dw ( lIdProd, sIdFour, sIdTypArt )
//remplac$$HEX2$$e9002000$$ENDHEX$$par :
//* #6 [FNAC_PROD_ECH_TECH] ajout isTypeTrt
lnvCmdCommun.uf_Changer_Lib_Dw ( idw_TrtCmde_Frn, lIdProd, sIdFour, sIdTypArt, isTypeTrt )

/*------------------------------------------------------------------*/
/* #2 : CAG 03/06/2003                                              */
/*------------------------------------------------------------------*/
idw_AnnCmde.InsertRow ( 0 )
idw_AnnCmde.SetItem ( 1, "ID_ANN", 0 )

If idw_TrtCmde.GetItemString ( 1, "COD_ETAT" ) = "ANN" Then
	sModif = "ID_ANN.VISIBLE = 1 ID_ANN_T.VISIBLE = 1"
Else
	sModif = "ID_ANN.VISIBLE = 0 ID_ANN_T.VISIBLE = 0"
End If
idw_TrtCmde.Modify ( sModif )
idw_TrtCmde_Frn.Modify ( sModif )

/*------------------------------------------------------------------*/
/* #3 : CAG 24/06/2003                                              */
/*------------------------------------------------------------------*/
sFiltre = ""
idw_AnnCmde.GetChild ( "ID_ANN", dwChild )
dwChild.SetFilter ( sFiltre )
dwChild.Filter ()


/*------------------------------------------------------------------*/
/* Le bouton de r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de l'IMEI adh corrig$$HEX2$$e9002000$$ENDHEX$$n'est            */
/* disponible que sur Option.                                       */
/*------------------------------------------------------------------*/

//* #6 [FNAC_PROD_ECH_TECH]
/*
F_RechDetPro ( lDeb, lFin, idw_detpro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 7 )
icbImei.Enabled = lDeb > 0 And isTypeTrt = "S" And idw_TrtCmde.GetItemNumber ( 1, "CPT_VALIDE" ) <= 0
icbIMEI.Show()
icbIMEI.BringToTop = TRUE
*/
icbIMEI.Hide()
//* :#6 [FNAC_PROD_ECH_TECH]



/*------------------------------------------------------------------*/
/* #4                                                               */
/*------------------------------------------------------------------*/
This.uf_GestionZone_InfoSpbFrn ()

end subroutine

private subroutine uf_protegerzone ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::Uf_ProtegerZone (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 31/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Protection des zones
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1   JCA   08/06/2006		Suppression ADR_MAIL   
//* 		FPI	15/07/2010		[PC321]
//       JFF   13/01/2014 [PM246]
//       JFF   11/10/2016 [DT076-2]
//		FPI	14/10/2016	[PC151255] - ajout des process 28xx
// 		FPI	10/07/2017	[ITSM475226] - Pour le scrollbar du probleme
//       JFF   06/11/2017 [PC171933]
//       JFF   03/09/2018 [DT361]
//       JFF   30/05/2023 [PMO89_RS4822]
//       JFF   07/03/2024 [HP252_276_HUB_PRESTA]
//*-----------------------------------------------------------------

Int	iCptValide
String	sProt, sCodEtat, sIdFour, sInfoSpbFrnCplt 
Long iIdLotCmde, lIdSin, lIdSeq
boolean bFournAutoriseModifAdresse
n_cst_string	lnvString

iCptValide = idw_TrtCmde.GetItemNumber ( 1, "CPT_VALIDE" )

lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN" )
lIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ" )
sIdFour = idw_TrtCmde.GetItemString ( 1, "ID_FOUR" )
sInfoSpbFrnCplt = idw_TrtCmde.GetItemString ( 1, "INFO_SPB_FRN_CPLT" )

iIdLotCmde = 1
bFournAutoriseModifAdresse = TRUE

SQLCA.PS_S_LECTURE_LOT_CMD ( lIdSin, lIdSeq, iIdLotCmde )

// [DT076-2] // [PC171933] [RS3200]
Choose Case sIdFour
	Case "SBE", "O2M", "SB1", "TMT", "PSM", "CIS", "BK2", "COR", "PAP", "CEA", "AGP", "TLS", "CDF"
		bFournAutoriseModifAdresse = TRUE
	Case Else
		bFournAutoriseModifAdresse = FALSE
End choose 

CHOOSE CASE Upper ( isTypeTrt )
	CASE "C", "V"

		idw_TrtCmde.uf_Proteger 			 &
				( {	"PROBLEME"				,& 
						"DTE_RDV_CLI"			,&
						"HRDV_CLI_MIN"			,&
						"HRDV_CLI_MAX"			,&
						"ID_CHOIX_HORAIRE"	, &
						"INFO_SPB_FRN"			&
				}, "1" ) // [PC321] Ajout de "INFO_SPB_FRN"

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 10/09/2002.                              */
/*------------------------------------------------------------------*/
/* CAG : Ajout de la colonne ADR_COD_CIV                            */
/*------------------------------------------------------------------*/
// #1
		idw_TrtClient.uf_Proteger &
				( {	"ADR_COD_CIV"		,&
						"ADR_NOM"			,& 
						"ADR_PRENOM"		,& 
						"ADR_LIVR1" 		,&
						"ADR_LIVR2"			,&
						"ADR_LIVR_CPL"		,&
						"ADR_CP"				,&
						"ADR_VILLE"			,&
						"ADR_TEL1"			,&
						"ADR_TEL2"			,&
						"ADR_TEL3"			,&
						"ADRFC_COD_CIV"	,&
						"ADRFC_NOM"			,& 
						"ADRFC_PRENOM"		,& 
						"ADRFC_LIVR1" 		,&
						"ADRFC_LIVR2"		,&
						"ADRFC_LIVR_CPL"	,&
						"ADRFC_CP"			,&
						"ADRFC_VILLE"		&
				}, "1" )

		icbComLiv.Enabled = FALSE
		icbComFac.Enabled = FALSE
		icbModifAdr.Enabled = FALSE // [PM246]
		
	CASE "S"

		If iCptValide <= 0 Then 
			sProt = "0"
		Else
			sProt = "1"
		End If

		icbComLiv.Enabled = sProt = "0"
		icbComFac.Enabled = sProt = "0"

		// [PM246]
		icbModifAdr.Enabled = sProt = "1" And iIdLotCmde > 0 And bFournAutoriseModifAdresse // [PM246] C'est l'inverse, on autorise quadn c'est valid$$HEX2$$e9002000$$ENDHEX$$!
		
		idw_TrtCmde.uf_Proteger &
				( {	"PROBLEME"				,& 
						"DTE_RDV_CLI"			,&
						"HRDV_CLI_MIN"			,&
						"HRDV_CLI_MAX"			,&
						"ID_CHOIX_HORAIRE"	 &
				}, sProt )

		// [PC321]
		If idw_TrtCmde.getitemstring( 1,"ID_FOUR") = "SCR" Then
			idw_TrtCmde.uf_Proteger ( {	"PROBLEME"}, "1" )
		End If
		// [:PC321]
	

		// [HP252_276_HUB_PRESTA] Pour une presta, on ne modifie plus l'adresse car d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$transmise au Hub.
		If F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then
			If sProt <> "1" Then
				If lnvString.of_getkeyvalue ( sInfoSpbFrnCplt, "HP_ID_HUB_PRESTA", ";") <> "" Then
					sProt = "1"
				End If 
			End If 
		End If			
		
		idw_TrtClient.uf_Proteger &
				( {	"ADR_COD_CIV"		,&
						"ADR_NOM"			,& 
						"ADR_PRENOM"		,& 
						"ADR_LIVR1" 		,&
						"ADR_LIVR2"			,&
						"ADR_LIVR_CPL"		,&
						"ADR_CP"				,&
						"ADR_VILLE"			,&
						"ADR_TEL1"			,&
						"ADR_TEL2"			,&
						"ADR_TEL3"			,&
						"ADRFC_COD_CIV"	,&
						"ADRFC_NOM"			,& 
						"ADRFC_PRENOM"		,& 
						"ADRFC_LIVR1" 		,&
						"ADRFC_LIVR2"		,&
						"ADRFC_LIVR_CPL"	,&
						"ADRFC_CP"			,&
						"ADRFC_VILLE"		&
				}, sProt )

			
				
				
		// [PC321]
		sProt="1"
		sCodEtat= idw_TrtCmde.getItemString(1,"COD_ETAT")
			
		If iCptValide > 0 and sCodEtat <> "RPC" and sCodEtat <> "ANN" Then
			Choose Case idw_TrtCmde.getItemNumber(1, "INFO_SPB_FRN")
				Case 1415,1420,1425,1430,1426, 2811, 2830 // [PC151255] - ajout des process 28xx
					sProt="0"
			End Choose
		End if
		
		idw_TrtCmde.uf_Proteger({"INFO_SPB_FRN"},sProt)
		// Fin [PC321]

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 10/09/2002.                              */
/*------------------------------------------------------------------*/
/* Gestion des TabOrders.                                           */
/*------------------------------------------------------------------*/
		If	idw_Produit.GetItemNumber ( 1, "COD_TEL" ) = 21 And idw_Produit.GetItemNumber ( 1, "ID_PROD" ) <> 5707	Then
			If	iCptValide <= 0	Then
				idw_TrtCmde.uf_Proteger ( { "ID_CHOIX_HORAIRE" }, "0" )
				idw_TrtCmde.uf_Proteger ( { "DTE_RDV_CLI", "HRDV_CLI_MIN", "HRDV_CLI_MAX" }, "1" )
			Else
				idw_TrtCmde.uf_Proteger ( { "ID_CHOIX_HORAIRE", "DTE_RDV_CLI", "HRDV_CLI_MIN", "HRDV_CLI_MAX" }, "1" )
			End If
		Else
			idw_TrtCmde.uf_Proteger ( { "ID_CHOIX_HORAIRE" }, "1" )
		End If

END CHOOSE

// [ITSM475226] - Pour le scrollbar
idw_TrtCmde.uf_proteger({"probleme"},"0")
idw_TrtCmde.Modify("probleme.Edit.displayOnly='Yes'")
idw_TrtCmde.Modify("probleme.Edit.AutoSelect='No'")
					
end subroutine

public function string uf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::Uf_ControlerSaisie (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 06/10/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de saisie
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 10/09/2002   Modification SFR # Ajout de la colonne ADR_COD_CIV
//* #2	 CAG	 07/11/2002	  						   R$$HEX1$$e900$$ENDHEX$$cup du code SRP + ajout des
//*															modifs : zone pb obligatoire pr PRS
//*															zone IMEI
//* #3	 CAG	 18/11/2002	  						   Ctrl de la zone IMEI :
//*														   document du cpte-rendu de mission chez CETELEC (2.3)
//*															Le Imei doit $$HEX1$$ea00$$ENDHEX$$tre un nombre de 15 chiffres ou "0" si PRS
//* #3.1	 JFF	 01/09/2003	  						   Pour CEGETEL (MUST), on ne prend pas que les IMEI Valide ou $$HEX2$$e0002000$$ENDHEX$$15x0.
//*															en revanche le pout #3.1 est d$$HEX1$$e900$$ENDHEX$$velopp$$HEX2$$e9002000$$ENDHEX$$avec DET_PRO et peut s'adapter $$HEX2$$e0002000$$ENDHEX$$tout produit
//* #4	 CAG	 18/11/2002	  						   Ctrl des zones de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phone
//*														   document du cmpte-rendu de mission chez CETELEC (2.2)
//*															10 chiffres commen$$HEX1$$e700$$ENDHEX$$ant par 0 et ne finissant pas par 0000
//* #5	 CAG	 19/05/2003		DCMP 030207 : Ajout de 6 zones en retour de Cetelec (pour Cegetel Must)
//*									=> ajout d'une dw suppl$$HEX1$$e900$$ENDHEX$$mentaire => modif gestion des boutons prec et suiv
//* #6	 JFF	 17/06/2003    Modif li$$HEX4$$e9002000e0002000$$ENDHEX$$ARVATO, Adresse de facturation
//* #7	 JFF   26/08/2003	  DCMP 030362 : contr$$HEX1$$f400$$ENDHEX$$le des communes par rapport au fichier INSEE
//* #8	 JFF   01/09/2003	  Contr$$HEX1$$f400$$ENDHEX$$les des Tac IMEI/Marques
//* #9	 JFF	 09/10/2003	  Acception sur option des CP $$HEX2$$e0002000$$ENDHEX$$00000
//* #10	 CAG	 25/11/2003	  Ajout d'un param$$HEX1$$e800$$ENDHEX$$tre : num$$HEX1$$e900$$ENDHEX$$ro de pg
//* #11	 JFF	 20/10/2008	  [FNAC_PROD_ECH_TECH]
//*			FPI	22/07/2010	[PC321] Contr$$HEX1$$f400$$ENDHEX$$les diff$$HEX1$$e900$$ENDHEX$$rents
//      JFF   23/05/2012 [PM103][1]
//		FPI	15/06/2012	[SFRP085.FPI] D$$HEX1$$e900$$ENDHEX$$sactivation du contr$$HEX1$$f400$$ENDHEX$$le du n$$HEX2$$b0002000$$ENDHEX$$de tel
//    JFF   27/08/2012  [MANTIS4331]
//		FPI	14/10/2016	[PC151255]
//*-----------------------------------------------------------------
String sCol [ ], sErr [ ], sTabNull [ ], s15Zero, sIMEIcorrige
String 		sNouvelleLigne, sPos, sText, sVal, sIdTypArt, sAdrTel3, sAdrTel
Long 			lCpt, lNbrCol, lDeb, lFin

Integer		iDeptInterdit[26] = { 4, 5, 6, 9, 11, 12, 13, 15, 30, 31, 32, 34, 40, 43, 46, 47, 48, 64, 65, 66, 73, 74, 81, 82, 83, 84 }
String		sIdFour
Long			lAdrCp
Boolean		bDeptTrouve, bAuMoinsUnePRS
Boolean 		bDP141 // [PC321]

Date			dDteRdvCli
Boolean 		bCommandeSCR_S2MI=false

sNouvelleLigne		= "~r~n"
sPos					= ""
sText					= sNouvelleLigne
sIdTypArt 			= idw_TrtCmde.GetItemString ( 1, "ID_TYP_ART" )
s15Zero				= Fill ( "0", 15 )


/*------------------------------------------------------------------*/
/* Controle de saisie de la partie Client.                          */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* #1																					  */
/*------------------------------------------------------------------*/
sCol[ 1 ] = "ADR_NOM"
sCol[ 2 ] = "ADR_PRENOM"
sCol[ 3 ] = "ADR_LIVR1"
sCol[ 4 ] = "ADR_CP"
sCol[ 5 ] = "ADR_VILLE"
sCol[ 6 ] = "ADR_TEL1"
sCol[ 7 ] = "ADR_COD_CIV"
// #6
sCol[ 8 ] = "ADRFC_NOM"
sCol[ 9 ] = "ADRFC_PRENOM"
sCol[ 10] = "ADRFC_LIVR1"
sCol[ 11] = "ADRFC_CP"
sCol[ 12] = "ADRFC_VILLE"
sCol[ 13] = "ADRFC_COD_CIV"

sErr[ 1 ] = " - Le nom du client (R$$HEX1$$e900$$ENDHEX$$cup/Livr.)"
sErr[ 2 ] = " - Le prenom du client (R$$HEX1$$e900$$ENDHEX$$cup/Livr.)"
sErr[ 3 ] = " - L'adresse (R$$HEX1$$e900$$ENDHEX$$cup/Livr.)"
sErr[ 4 ] = " - Le code postal (R$$HEX1$$e900$$ENDHEX$$cup/Livr.)"
sErr[ 5 ] = " - La ville (R$$HEX1$$e900$$ENDHEX$$cup/Livr.)"
sErr[ 6 ] = " - Le n$$HEX2$$b0002000$$ENDHEX$$de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phone"
// #6
sErr[ 7 ] = " - La civilit$$HEX2$$e9002000$$ENDHEX$$(R$$HEX1$$e900$$ENDHEX$$cup/Livr.)"
sErr[ 8 ] = " - Le nom du client (Fact.)"
sErr[ 9 ] = " - Le prenom du client (Fact.)"
sErr[ 10] = " - L'adresse (Fact.)"
sErr[ 11] = " - Le code postal (Fact.)"
sErr[ 12] = " - La ville (Fact.)"
sErr[ 13] = " - La civilit$$HEX2$$e9002000$$ENDHEX$$(Fact.)"
lNbrCol	 = UpperBound ( sCol )

stMessage.sTitre  	= "Controle de saisie"
stMessage.Icon			= Information!
stMessage.bErreurG	= TRUE
stMessage.Bouton		= Ok!
stMessage.sCode		= "GENE001"

// [PC321]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 141 )
bDP141 = lDeb > 0 
// :[PC321]

// [PC151255]
if idw_TrtCmde.GetItemString ( 1, "ID_FOUR") = "SCR" Then
	Choose Case idw_TrtCmde.GetItemNumber(1, "INFO_SPB_FRN")
		Case 2800 To 2899
			bCommandeSCR_S2MI=True
	End Choose
End if
// :[PC151255]

For lCpt = 1 To lNbrCol

	CHOOSE CASE lCpt
		CASE 1 TO 7
			sVal = idw_TrtClient.GetItemString ( 1, sCol [ lCpt ] )
	END CHOOSE

	If IsNull ( sVal ) or sVal = ""	Then

		If sPos = "" Then sPos = sCol[ lCpt ]
		sText = sText + sErr[ lCpt ] + sNouvelleLigne

	End If

Next

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* La saisie de ADR_TEL3 (correspondant au N$$HEX2$$b0002000$$ENDHEX$$de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phone du       */
/* portable) est obligatoire pour les produits SFR. Il doit de      */
/* plus comporter obligatoirement 10 chiffres et commencer par 06.  */
/*------------------------------------------------------------------*/
/* Ce contr$$HEX1$$f400$$ENDHEX$$le n'est valable que pour le cas d'une                  */
/* PReStation.(CETELEC).                                            */
/*------------------------------------------------------------------*/
If	sPos = "" And idw_Produit.GetItemNumber ( 1, "COD_TEL" ) = 21 And idw_Produit.GetItemNumber ( 1, "ID_PROD" ) <> 5707 Then
	sAdrTel3 = idw_TrtClient.GetItemString ( 1, "ADR_TEL3" )
	If	IsNull ( sAdrTel3 ) Or Len ( Trim ( sAdrTel3 ) ) = 0	Then
		sPos = "ADR_TEL3"
		sText = sText + " - Le N$$HEX2$$b0002000$$ENDHEX$$de portable" + sNouvelleLigne
	Else
/*------------------------------------------------------------------*/
/* On met 10 chiffres + 4 espaces en fonction du formatage.         */
/*------------------------------------------------------------------*/
		//[NUM_TEL_07]
		If	Len ( Trim ( uf_Formatage_Tel ( sAdrTel3, FALSE ) ) ) <> 10 Or ( Left ( sAdrTel3, 2 ) <> "06" And Left ( sAdrTel3, 2 ) <> "07" )	Then
			sPos = "ADR_TEL3"

			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "SFRP025"
		End If
	End If
End If

/*------------------------------------------------------------------*/
/* #4																					  */
/*------------------------------------------------------------------*/
// [SFRP085.FPI] D$$HEX1$$e900$$ENDHEX$$sactivation du contr$$HEX1$$f400$$ENDHEX$$le du n$$HEX2$$b0002000$$ENDHEX$$de tel
/*sCol[ 1 ] = "ADR_TEL1"
sCol[ 2 ] = "ADR_TEL2"
sCol[ 3 ] = "ADR_TEL3"

If sPos = "" Then
	For lCpt = 1 To 3
		sAdrTel = idw_TrtClient.GetItemString ( 1, sCol [ lCpt ] )
		If ( Not IsNull ( sAdrTel ) And sAdrTel <> "" ) And &
			( Left ( sAdrTel, 1 ) <> '0' Or &
			  Mid ( sAdrTel, 2, 1 ) = '0' Or &
			  Len ( sAdrTel ) <> 14 ) Then

			sPos = sCol [ lCpt ]
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "SFRP085"
			Choose Case lCpt
				Case 1
					sText = "premier"
				Case 2
					sText = "second"
				Case 3
					sText = "troisi$$HEX1$$e800$$ENDHEX$$me"
			End Choose
			Exit
		End If
	Next
End If
*/ 

If bCommandeSCR_S2MI Then sPos=""

If sPos <> "" Then
	/*------------------------------------------------------------------*/
	/* #5																					  */
	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/
	/* #10 CAG 25/11/2003															  */
	/*------------------------------------------------------------------*/
	uf_GestionBoutons ( 3, "", False )

	stMessage.sVar [1] = sText
	F_Message ( stMessage )
	Return sPos
End If
	
/*------------------------------------------------------------------*/
/* Controle de saisie de la partie Commande.                        */
/*------------------------------------------------------------------*/
sCol = sTabNull
sErr = sTabNull

sCol[ 1 ] = "PROBLEME"

// sCol[ 2 ] = "ID_SERIE_ANC" // [MANTIS4331]

sErr[ 1 ] = " - La description du probl$$HEX1$$e800$$ENDHEX$$me"
// sErr[ 2 ] = " - Le n$$HEX2$$b0002000$$ENDHEX$$de s$$HEX1$$e900$$ENDHEX$$rie de l'ancien appareil" // [MANTIS4331]

lNbrCol	 = UpperBound ( sCol )

stMessage.sTitre		= "Controle de saisie - Prestation(s)"
stMessage.Icon			= Information!
stMessage.bErreurG	= TRUE
stMessage.Bouton		= Ok!
stMessage.sCode		= "GENE001"

/*------------------------------------------------------------------*/
/* Le num$$HEX1$$e900$$ENDHEX$$ro IMEI est obligatoire	 										  	 */
/*------------------------------------------------------------------*/
//	sVal = idw_TrtCmde.GetItemString ( 1, sCol [ 2 ] )

// [MANTIS4331]
//	If IsNull ( sVal ) or sVal = ""	Then
//		sPos = sCol [ 2 ]
//		sText = sText + sErr[ 2 ] + sNouvelleLigne
//	End If
//
//	If sPos <> "" Then 
//		/*------------------------------------------------------------------*/
//		/* #5																					  */
//		/*------------------------------------------------------------------*/
//		/*------------------------------------------------------------------*/
//		/* #10 CAG 25/11/2003															  */
//		/*------------------------------------------------------------------*/
//		uf_GestionBoutons ( 1, "", False )
//
//		stMessage.sVar [1] = sText
//		F_Message ( stMessage )
//		Return sPos
//	End If

 	//* #11 [FNAC_PROD_ECH_TECH]
//	If sPos = "" Then
	If FALSE Then
		/*------------------------------------------------------------------*/
		/* #3																					  */
		/*------------------------------------------------------------------*/
		// Interdit-on l'IMEI $$HEX2$$e0002000$$ENDHEX$$0 pour ce produit ? OUI si lDeb > 0
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 6 )

		If ( ( sVal <> s15Zero ) And ( Len ( sVal ) <> 15 ) or Not IsNumber ( sVal ) ) &
			Or ( sVal = s15Zero And lDeb > 0 )  Then

			sPos = "ID_SERIE_ANC"
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!

			If lDeb > 0 Then
				stMessage.sCode		= "SFRP082"  // On interdit la saisie de 15x0
			Else
				stMessage.sCode		= "SFRP080"  // On Autorise la saisie de 15x0
			End If

			/*------------------------------------------------------------------*/
			/* #5																					  */
			/*------------------------------------------------------------------*/
			/*------------------------------------------------------------------*/
			/* #10 CAG 25/11/2003															  */
			/*------------------------------------------------------------------*/
			uf_GestionBoutons ( 1, "", False )

			F_Message ( stMessage )
			Return sPos
		End If
    End If


/*------------------------------------------------------------------*/
/* #3.1                                                             */
/*------------------------------------------------------------------*/
	If sPos = "" Then
		// Interdit-on l'IMEI $$HEX2$$e0002000$$ENDHEX$$0 pour ce produit ? OUI si lDeb > 0
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 6 )

		If sVal <> s15Zero Or lDeb > 0 Then

			F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 5 )

			If lDeb > 0 Then

				//Si l'IMEI n'est pas valide alors
				If Not F_IMEI ( sVal, sIMEIcorrige ) Then
					sPos = sCol [ 2 ]
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= Ok!
					stMessage.sCode		= "SFRP081"

					F_Message ( stMessage )
					Return sPos
				End If 
			End If
		End If
	End If


/*------------------------------------------------------------------*/
/* La description du probl$$HEX1$$e800$$ENDHEX$$me est obligatoire si c'est une 			  */
/* prestation   											                    */
/*------------------------------------------------------------------*/
If Upper ( sIdTypArt ) = "PRS"  and not bDP141 Then // [PC321] Pas de contr$$HEX1$$f400$$ENDHEX$$le du probl$$HEX1$$e800$$ENDHEX$$me pour SCR

	sVal = idw_TrtCmde.GetItemString ( 1, sCol [ 1 ] )

	If IsNull ( sVal ) or sVal = ""	Then
		sPos = sCol [ 1 ]
		sText = sText + sErr[ 1 ] + sNouvelleLigne
	End If

	If sPos <> "" Then 
		/*------------------------------------------------------------------*/
		/* #5																					  */
		/*------------------------------------------------------------------*/
		/*------------------------------------------------------------------*/
		/* #10 CAG 25/11/2003															  */
		/*------------------------------------------------------------------*/
		uf_GestionBoutons ( 1, "", False )

		stMessage.sVar [1] = sText
		F_Message ( stMessage )
		Return sPos

	End If
End If

/*------------------------------------------------------------------*/
/* On affiche un message pour signaler que certaines zones          */
/* (ID_MARQ_ART, ID_MODL_ART, zones rdv sauf pour     */
/*  CEGETEL) ne sont pas saisies. 										     */
/* On demande au gestionnaire de confirmer si cette situation est   */
/* normale.                                                         */
/*------------------------------------------------------------------*/
sCol = sTabNull
sErr = sTabNull

sCol[ 1 ] = "ID_MARQ_ART"
sCol[ 2 ] = "ID_MODL_ART"

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 04/10/2002.                              */
/*------------------------------------------------------------------*/
/* Dans le cas de CEGETEL, la date de rdv n'est pas obligatoire     */
/*------------------------------------------------------------------*/
bAuMoinsUnePRS		 = idw_TrtCmde.GetItemString ( 1, "ID_TYP_ART" ) = "PRS" 

/* [PM103][1]
If bAuMoinsUnePRS Then
	sCol[ 3 ] = "DTE_RDV_CLI"
	sCol[ 4 ] = "HRDV_CLI_MIN"
	sCol[ 5 ] = "HRDV_CLI_MAX"
End If
*/

sErr[ 1 ] = " - La marque de l'ancien appareil"
sErr[ 2 ] = " - Le mod$$HEX1$$e800$$ENDHEX$$le de l'ancien appareil"

/* [PM103][1]
sErr[ 3 ] = " - La date de rendez-vous avec le client"
sErr[ 4 ] = " - L'Heure de rendez-vous au plus t$$HEX1$$f400$$ENDHEX$$t"
sErr[ 5 ] = " - L'Heure de rendez-vous au plus tard"
*/

lNbrCol	 = UpperBound ( sCol )

stMessage.sTitre		= "Prestation(s)"
stMessage.Icon			= Question!
stMessage.bErreurG	= TRUE
stMessage.Bouton		= YesNo!
stMessage.sCode		= "GENE012"


For lCpt = 1 To lNbrCol

	CHOOSE CASE lCpt
		CASE 1,2
			sVal = idw_TrtCmde.GetItemString ( 1, sCol [ lCpt ] )
		CASE ELSE 
			sVal = "BIDON"

	END CHOOSE

	If IsNull ( sVal ) or sVal = ""	Then
//		sPos = "PRS" 	//* [FNAC_PROD_ECH_TECH]
		sText = sText + sErr[ lCpt ] + sNouvelleLigne
	End If

Next

If sPos <> "" Then 
	/*------------------------------------------------------------------*/
	/* #5																					  */
	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/
	/* #10 CAG 25/11/2003															  */
	/*------------------------------------------------------------------*/
	uf_GestionBoutons ( 1, "", False )
End If

/*------------------------------------------------------------------*/
/* Si c'est une Prestation on contr$$HEX1$$f400$$ENDHEX$$le alors que la date de Rdv et  */
/* Heures soient saisies.                                           */
/*------------------------------------------------------------------*/
If lNbrCol > 3 Then
	For lCpt = 3 To 5

		CHOOSE CASE lCpt
			CASE 4,5
				sVal = Trim ( idw_TrtCmde.GetItemString ( 1, sCol [ lCpt ] ) )

			CASE 3
				sVal = Trim ( String ( idw_TrtCmde.GetItemDate ( 1, sCol [ lCpt ] ) ) )

		END CHOOSE

		If IsNull ( sVal ) or sVal = ""	Then
			/*------------------------------------------------------------------*/
			/* #5																					  */
			/*------------------------------------------------------------------*/
			/*------------------------------------------------------------------*/
			/* #10 CAG 25/11/2003															  */
			/*------------------------------------------------------------------*/
			uf_GestionBoutons ( 1, "", False )

			If sPos = "PRS" Or sPos = "" Then sPos = sCol[ lCpt ]
			sText = sText + sErr[ lCpt ] + sNouvelleLigne
		End If

	Next
End If 

// [PC321] Si Gestion Carrefour on oublie les contr$$HEX1$$f400$$ENDHEX$$les pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dents
If bDP141 Then sPos="" 
// :[PC321]

If sPos <> "" Then 
	stMessage.sVar [1] = sText
	If F_Message ( stMessage ) = 1 Then 
		sPos = ""
	End If
End If


/*------------------------------------------------------------------*/
/* Le 30/07/2003 'DCMP 030337'                                      */
/* Pour ARVATO - et uniquement pour certains d$$HEX1$$e900$$ENDHEX$$partements -, la     */
/* prise de rendez-vous est interdite le 04/08/2003, le 11/08/2003  */
/* et le 25/08/2003.                                                */
/*------------------------------------------------------------------*/
If	sPos = ""	Then
	sIdTypArt	= Upper ( sIdTypArt )
	lAdrCp		= Integer ( Trim ( Left ( idw_TrtCmde.GetItemString ( 1, "ADR_CP" ), 2 ) ) )
	sIdFour		= idw_TrtCmde.GetItemString ( 1, "ID_FOUR" ) 
	dDteRdvCli	= idw_TrtCmde.GetItemDate ( 1, "DTE_RDV_CLI" )

	For	lCpt = 1 To 26
			If	lAdrCp = iDeptInterdit[ lCpt ]	Then
				bDeptTrouve = TRUE
				Exit
			End If
	Next

	/*------------------------------------------------------------------*/
	/* JFF le 17/12/03 : Modif demand$$HEX2$$e9002000$$ENDHEX$$pour le 26/12/2003 et            */
	/* 02/01/2004, sans tenir compte des Depts.                         */
	/*------------------------------------------------------------------*/
	bDeptTrouve = TRUE

End If

/*------------------------------------------------------------------*/
/* #7 : DCMP 030362                                                 */
/*------------------------------------------------------------------*/
If sPos = "" Then
	This.uf_ControlerSaisie_Commune ( sPos )
	If sPos <> "" Then 

		/*------------------------------------------------------------------*/
		/* #5																					  */
		/*------------------------------------------------------------------*/
		/*------------------------------------------------------------------*/
		/* #10 CAG 25/11/2003															  */
		/*------------------------------------------------------------------*/
		uf_GestionBoutons ( 3, "", False )
	End If

End If

/*------------------------------------------------------------------*/
/* #8 : 																				  */
/*------------------------------------------------------------------*/
If sPos = "" Then
	This.uf_ControlerSaisie_TacImei ( sPos )
	If sPos <> "" Then 
		/*------------------------------------------------------------------*/
		/* #5																					  */
		/*------------------------------------------------------------------*/
		/*------------------------------------------------------------------*/
		/* #10 CAG 25/11/2003															  */
		/*------------------------------------------------------------------*/
		uf_GestionBoutons ( 1, "", False )
	End If

End If

/*------------------------------------------------------------------*/
/* #9 : 																			     */
/*------------------------------------------------------------------*/
If sPos = "" Then
	This.uf_ControlerSaisie_CP ( sPos )
	IF sPos <> "" Then 

	/*------------------------------------------------------------------*/
	/* #10 CAG 25/11/2003															  */
	/*------------------------------------------------------------------*/
	uf_GestionBoutons ( 3, "", False )
	End If

End If


Return sPos

end function

private function string uf_formatage_heure (string astext);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::Uf_Formatage_Heure (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/10/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Formatage des Heures
//* Commentaires	: 
//*
//* Arguments		: asText		String		Val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String	sVal
Int		iLen
Long		lVal

sVal = Trim ( asText )
iLen = Len ( Trim ( sVal ) )
lVal = Long ( sVal )

CHOOSE CASE iLen
	CASE 0
		SetNull ( sVal ) 		

	// 8 = 0800
	CASE 1
		sVal = "0" + sVal + "00"		

	// 15 = 1500
	CASE 2
		If lVal > 23 Then 
			sVal = "-1"
		Else
			sVal = + sVal + "00"		
		End If

	// 156 = 1506
	// 246 = 0246
	CASE 3
		lVal = Long ( Left ( sVal, 2 ) )
		If lVal > 23 Then
			lVal = Long ( Right ( sVal, 2 ) )
			If lVal > 59 Then
				sVal = "-1"
			Else
				sVal = "0" + Left ( sVal, 1 ) + Right ( sVal, 2 )
			End If
		Else		

			sVal = Left ( sVal, 2 ) + "0" + Right ( sVal, 1 )
		End If

	//1530 = 1530
	CASE 4

		lVal = Long ( Left ( sVal, 2 ) )
		If lVal > 23 Then
			sVal = "-1"
		Else
			lVal = Long ( Right ( sVal, 2 ) )
			If lVal > 59 Then	sVal = "-1"
		End If

END CHOOSE

Return sVal
end function

public function string uf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::Uf_ControlerGestion (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 06/09/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de Gestion
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 CAG		19/05/03	DCMP 030207 : Ajout de 6 zones en retour de Cetelec (pour Cegetel Must)
//*								=> ajout d'une dw suppl$$HEX1$$e900$$ENDHEX$$mentaire => modif gestion des boutons prec et suiv
//* #2	 CAG		25/11/2003 Ajout d'un param$$HEX1$$e800$$ENDHEX$$tre : num$$HEX1$$e900$$ENDHEX$$ro de pg
//*-----------------------------------------------------------------

Int	iRet
String	sIdFour, sVal, sVal1, sPos
Date		dDate1, dDate2

iRet = 1
sIdFour = idw_TrtCmde.GetItemString ( 1, "ID_FOUR" )
sPos = ""

stMessage.sTitre  	= "Controle de gestion"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!


/*------------------------------------------------------------------*/
/* Contr$$HEX1$$f400$$ENDHEX$$le G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ral.                                                */
/*------------------------------------------------------------------*/
/* Heure mini avant Heure Maxi.												  */
/*------------------------------------------------------------------*/
sVal 	= idw_TrtCmde.GetItemString ( 1, "HRDV_CLI_MIN" )
sVal1 = idw_TrtCmde.GetItemString ( 1, "HRDV_CLI_MAX" )
If Not IsNull ( sVal ) And Not IsNull ( sVal1 ) Then
	If Time ( Left ( sVal, 2 ) + ":" + Right ( sVal, 2 ) ) > &
		Time ( Left ( sVal1, 2 ) + ":" + Right ( sVal1, 2 ) ) Then
		stMessage.sCode = "COMD011"		

		/*------------------------------------------------------------------*/
		/* #1																					  */
		/*------------------------------------------------------------------*/
		/*------------------------------------------------------------------*/
		/* #2 CAG 25/11/2003																  */
		/*------------------------------------------------------------------*/
		uf_GestionBoutons ( 1, "", False )

		F_Message ( stMessage )
		Return "HRDV_CLI_MIN" 
	End If
ElseIf IsNull ( sVal ) And Not IsNull ( sVal1 ) Then 
		stMessage.sCode = "COMD011"		

		/*------------------------------------------------------------------*/
		/* #1																					  */
		/*------------------------------------------------------------------*/
		/*------------------------------------------------------------------*/
		/* #2 CAG 25/11/2003																  */
		/*------------------------------------------------------------------*/
		uf_GestionBoutons ( 1, "", False )

		F_Message ( stMessage )
		Return "HRDV_CLI_MIN" 
End If	

/*------------------------------------------------------------------*/
/* Si Au moin une Heure alors une date doit $$HEX1$$ea00$$ENDHEX$$tre saisi.				  */
/*------------------------------------------------------------------*/
If ( Not IsNull ( sVal ) Or Not IsNull ( sVal1 ) ) And &
	( IsNull ( idw_TrtCmde.GetItemDate ( 1, "DTE_RDV_CLI" ) ) ) Then

	stMessage.sCode = "COMD012"		

	/*------------------------------------------------------------------*/
	/* #1																					  */
	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/
	/* #2 CAG 25/11/2003																  */
	/*------------------------------------------------------------------*/
	uf_GestionBoutons ( 1, "", False )

	F_Message ( stMessage )
	Return "DTE_RDV_CLI"

End If

/*------------------------------------------------------------------*/
/* Contr$$HEX1$$f400$$ENDHEX$$le Particulier pour certains fournisseurs.                 */
/*------------------------------------------------------------------*/
CHOOSE CASE Upper ( sIdFour )

	/*------------------------------------------------------------------*/
	/* Fournisseur CEGETEL 	 														  */
	/*------------------------------------------------------------------*/
	CASE "CEG"

		sPos = This.uf_ControlerGestion_CEGETEL () 

	/*------------------------------------------------------------------*/
	/* Fournisseur DARTY																  */
	/*------------------------------------------------------------------*/
	CASE "DTY"

		sPos = This.Uf_ControlerGestion_Darty () 


END CHOOSE

Return sPos
end function

private function string uf_formatage_email (string astext);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::Uf_Formatage_eMail (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/10/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Formatage de l'mail
//* Commentaires	: 
//*
//* Arguments		: asText		String		Val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String	sVal, sCar
Int		iLen, iPoint, iAt
Long		lVal, lCpt, lPos


sVal = Trim ( asText )
iLen = Len ( Trim ( sVal ) )

If iLen <= 0 Then Return sVal

/*------------------------------------------------------------------*/
/* Recherche d'un double espace $$HEX2$$e0002000$$ENDHEX$$remplacer par @                   */
/*------------------------------------------------------------------*/
DO WHILE Pos ( sVal, "  ", 1 ) > 1 
	sVal = Replace ( sVal, Pos ( sVal, "  ", 1 ), 2, "@" )	
LOOP

/*------------------------------------------------------------------*/
/* Recherche d'un espace $$HEX2$$e0002000$$ENDHEX$$remplacer par .                          */
/*------------------------------------------------------------------*/
DO WHILE Pos ( sVal, " ", 1 ) > 1 
	sVal = Replace ( sVal, Pos ( sVal, " ", 1 ), 1, "." )	
LOOP

/*------------------------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification de la validit$$HEX2$$e9002000$$ENDHEX$$de l'email.                          */
/*------------------------------------------------------------------*/
iPoint = 0
iAt = 0
For lCpt = 1 To iLen 
	sCar = Mid ( sVal, lCpt, 1 )

	// @ et . impossible en premier et dernier
	If ( lCpt = 1 Or lCpt = iLen ) And ( sCar = "@" Or sCar ="." ) Then 
		sVal = "-1"
		Exit
	End If

	If sCar = "." Then 
		iPoint++

		// xxx@xxx.xxx.xx Impossible
		If iPoint > 1 Then
			sVal = "-1"
			Exit
		End If

	End If

	If sCar = "@" Then 
		iAt++
		iPoint = 0

		// xxx@xx@xxx.xx Impossible
		If iAt >1 Then
			sVal = "-1"
			Exit
		End If

	End If

Next

// Pas plus d'un @ et au moins un .
If iAt <> 1 Or iPoint < 1 Then sVal = "-1"

/*------------------------------------------------------------------*/
/* Enfin il ne peut y avoir que certain caract$$HEX1$$e800$$ENDHEX$$res.                 */
/*------------------------------------------------------------------*/
If sVal <>  "-1" Then
	iLen = Len ( Trim ( sVal ) )
	For lCpt = 1 To iLen
		sCar = Mid ( sVal, lCpt, 1 )

		If Not ( ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Or &
					( Asc ( sCar ) >= 65 And Asc ( sCar ) <= 90 ) Or &
					( Asc ( sCar ) >= 97 And Asc ( sCar ) <= 122 ) Or &
					sCar = "." Or & 
					sCar = "@" Or &
					sCar = "_" ) Then

			sVal = "-1"
			Exit
		End If
	Next
End If




Return sVal
end function

private function string uf_formatage_cp (string astext);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::Uf_Formatage_CP (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/09/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Formatage CP
//* Commentaires	: 
//*
//* Arguments		: asText		String		Val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String	sVal, sCar
Int		iLen, iPoint, iAt
Long		lVal, lCpt, lPos

sVal = asText
iLen = Len ( Trim ( sVal ) )

/*------------------------------------------------------------------*/
/* Au moins 5 Caract$$HEX1$$e800$$ENDHEX$$res.                                           */
/*------------------------------------------------------------------*/
If iLen < 5 then 	sVal = "-1"


/*------------------------------------------------------------------*/
/* Enfin il ne peut y avoir que certains caract$$HEX1$$e800$$ENDHEX$$res.                */
/*------------------------------------------------------------------*/
If sVal <>  "-1" Then
	For lCpt = 1 To iLen
		sCar = Mid ( sVal, lCpt, 1 )

		If Not ( ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) ) Then
			sVal = "-1"
			Exit
		End If
	Next
End If

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
If	sVal <> "-1" And idw_Produit.GetItemNumber ( 1, "COD_TEL" ) = 21 And idw_Produit.GetItemNumber ( 1, "ID_PROD" ) <> 5707	Then
/*------------------------------------------------------------------*/
/* On proc$$HEX1$$e900$$ENDHEX$$de $$HEX2$$e0002000$$ENDHEX$$l'armement des valeurs pour les zones A ou B.       */
/*------------------------------------------------------------------*/
	uf_Zn_AdrCp ( sVal, FALSE )
End If

Return sVal
end function

public function integer uf_annuler_cmde ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande2::Uf_Annuler_Cmde (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 16/10/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Annulation d'une commande
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 31/10/2002	  Modification SFR # Annulation des commandes
//*								  pour CEGETEL ( annexe 15 d'Analyse des traitements ... )
//* #2	 CAG	 05/03/2003	  Si Annulation cmde CEGETEL et que cmde js g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e => pas de msg
//* #3	 CAG	 03/06/2003	  Ajout de la zone ID_ANN = cat$$HEX1$$e900$$ENDHEX$$gorie d'annulation
//* #4	 JFF	 07/11/2003   Pour ARVATO, on ne peut annuler que si prs concern$$HEX2$$e9002000$$ENDHEX$$a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$
//*								  il y a plus de 7 jours et que la date de collecte n'est pas renseign$$HEX1$$e900$$ENDHEX$$e.
//* #5	 CAG	 20/09/2004	  DCMP 040381 : Ajout du frn MSS
//* #6    MADM  07/02/2006   [DCMP060119]: Ajout du frn AVM
//* #7    MADM  09/05/2006   [DCMP060356]: Rempl du frn AVM par COR
//* #8    JFF   06/02/2006   [SITE_CMDE] Gestion des nouvelles option d'autorisation 79, 80, 81
//* #9	JCA	27/02/2007		DCMP 070085 - Permettre annulation du flux $$HEX1$$e900$$ENDHEX$$mis vers C-Discount
//* #10	JFF   18/09/2007 		[ALAPAGE]
//* #11	PHG	03/12/2007 		[O2M] : Gestion O2M
//* #12	PHG	04/03/2008	  [DCMP080174] : Regroupement des annulation O2M en un Fichier centralis$$HEX1$$e900$$ENDHEX$$.
//* #13	PHG	12/03/2008	  [DCMP080174] : Correction Affichage Message Incorrect
//* #14  JFF   20/06/2008 	  [DCMP080479]
//* #15  JFF   05/09/2008 	  [MICROMANIA]
//* #16  JFF   16/01/2009    [DCMP090026]
//* #17  JFF   09/02/2009    [20090209142923553]
//* #18  JFF   27/03/2009    [DCMP090165]
//* #19  JFF   21/04/2009    [DCMP090102]
//* #20  JFF   21/04/2009    [DCMP090140]
//* #21	FPI	20/05/2009	  [200905201403] l'autorisation 217 passe en 218
//* #22  JFF   10/06/2009    [RUEDUCOMMERCE]
//* #23  JFF   02/09/2009 	  [DCMP090327].[SBETV]
//* #24  JFF   28/10/2009 	  [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
//* #25  JFF   25/11/2009    [MSS_DIAG]
//* #26	FPI	26/01/2010	  [DCMP100015]
//*  	   JFF	13/04/2010    [WEBSIM2].[FRANCE]
//* 		JFF   04/11/2010    [PC301].[LOT2]
//			FPI	09/12/2010	  [VDoc2280]
//*      JFF   11/01/2011    [DECIMAL_PAPILLON]
//*      JFF   11/03/2011    [VDOC444]
// 		FPI	31/03/2011		[ITSM64370] Passage en long de la variable id_lot_cmd
//*     FPI    07/10/2011 [VDOC5312] Ajout du droit d'annulation de presta 221
//*     FPI   25/10/2011 [PR09] Commandes GAME
// 	  JFF   13/02/2012   [PM200][PSM]
// 		FPI	27/06/2012	[ITSM119168]
//    JFF   19/11/2012  [PC543][MANTIS5739]
//		FPI	22/02/2013	[PC721]
//       JFF   30/12/2013 [PC13348&13408]
//       JFF   11/02/2014 [DT57_CMDE_IPHONE_SFR]
//       JFF   30/05/2014 [ITSM215956]
//		FPI	19/11/2014 [ITSM250955]
//       JFF   02/01/2015 [PC801_6_TAMET]
//       JFF   09/04/2015 [DT141]
//       JFF   20/04/2015 [PC13321]
// 	  JFF    13/07/2015 [ITSM306150]
// 	  JFF    23/02/2016 [ITSM363758]
// 	  JFF    30/06/2016 [ITSM394275]
//		JFF   23/08/2016  [ETAT_153_SUR_ANN_2AC]
//       JFF   11/10/2016 [DT076-2]
//       JFF   03/09/2018 [DT361]
//       JFF   17/09/2018 [PM444-1]
//       JFF   04/10/2019 [PM462-1][V3]
//       JFF   30/05/2023 [PMO89_RS4822]
//*-----------------------------------------------------------------

Int		iRet,  iIdSeq
Long iIdLotCmd // [ITSM64370]
DateTime dtNow
Date		dNow, dCmdGenLe, dDteElvMob
Boolean	bAnnulGen, bAffichMsg //* #13	[DCMP080174] : bAffichMsg :Boolean pour indiquer si on doit afficher le msg ou pas.
Boolean	bMessParticulier //* #17 [20090209142923553]
Boolean	bCasO2MDiagNonCloture //* #18 [DCMP090165]
Boolean	bAnnulationParFluxEdi // #24 [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
Boolean  bPasseDroit  		// #24 [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
Boolean  bDT57_annulation // [DT57_CMDE_IPHONE_SFR]
Long		lIdSin, lRow, lVal1, lVal2
String	sIdTypArt, SIdFour, sIdRefFour, sVal 
DataWindowChild	dwChild
Int		iReponse // #13	[DCMP080174] : On stocke la reponse $$HEX2$$e0002000$$ENDHEX$$la question pos$$HEX1$$e900$$ENDHEX$$e en fin de trt pour l'annulation
Decimal {2} dcIdsin, dcMtFranchiseARemb
string	sModele, sInfoSpbFrnCplt // [DT57_CMDE_IPHONE_SFR]
n_cst_string lnvPFCString

bAffichMsg = True // #13	[DCMP080174] : Par defaut on affiche le mesasge quand on doit l'afficher.
bAnnulGen = True
bMessParticulier = FALSE
bCasO2MDiagNonCloture = FALSE //* #18 [DCMP090165]
bAnnulationParFluxEdi = FALSE // #24 [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
bDT57_annulation = False 
iRet = 1

sIdFour = Upper(idw_TrtCmde.GetItemString ( 1, "ID_FOUR" )) // #26
sIdRefFour = idw_TrtCmde.GetItemString ( 1, "ID_REF_FOUR" )

stMessage.sTitre		= "Annulation d'une commande"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!


lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
iIdLotCmd = -1

// [DECIMAL_PAPILLON]
dcIdsin = dec (lIdSin)
SELECT id_lot_cmd
INTO 	 :iIdLotCmd
FROM   sysadm.commande
WHERE  id_sin = :dcIdsin
AND    id_seq = :iIdSeq
USING  SQLCA ;

// Attention, 213 est plus fort que 218.
// #18 [DCMP090165] - [200905201403] 
// #23 [DCMP090327].[SBETV]
// #25 [MSS_DIAG]
// #26 - Simplification
// [VDoc2280] modif signature de uf_GetAutorisation
// [VDOC444]
bCasO2MDiagNonCloture = This.uf_GetAutorisation (218,"-1") And ( sIdFour = "O2M" ) And &
									 idw_TrtCmde.GetItemString ( 1, "ID_REF_FOUR" ) = "A_DIAGNOSTIQUER" And &
									 idw_TrtCmde.GetItemNumber ( 1, "STATUS_GC" ) <= 0
									 
/*							  	 ( idw_TrtCmde.GetItemString ( 1, "ID_FOUR" ) = "O2M" Or & 
									idw_TrtCmde.GetItemString ( 1, "ID_FOUR" ) = "SB1" Or &
									idw_TrtCmde.GetItemString ( 1, "ID_FOUR" ) = "MS1" &
								 ) And &
								 idw_TrtCmde.GetItemString ( 1, "ID_REF_FOUR" ) = "A_DIAGNOSTIQUER" And &
								 idw_TrtCmde.GetItemString ( 1, "COD_ETAT" ) = "ECT" 
*/
// #6  [DCMP080479]

// #24 [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
bPasseDroit = idw_TrtCmde.GetItemString ( 1, "ID_FOUR" ) = "FNC"

// [VDOC5312]
If not isNull(idw_TrtCmde.GetItemNumber ( 1, "INFO_SPB_FRN" )) Then // [ITSM119168]
	If not bPasseDroit Then bPasseDroit = uf_getautorisation_221(  idw_TrtCmde.GetItemNumber ( 1, "INFO_SPB_FRN" ))
End if

If sIdFour="SCR" and Upper ( idw_TrtCmde.GetItemString ( 1, "ID_TYP_ART" ) )="PRS" Then iIdLotCmd=1

// #24 [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
//  [VDoc2280] modi signature de uf_GetAutorisation
If Not bPasseDroit And &
	Not bCasO2MDiagNonCloture And &
	Not This.uf_GetAutorisation (213,sIdFour ) And &
	Not Upper ( idw_TrtCmde.GetItemString ( 1, "ID_FOUR" ) ) = "WBA" And & 
	iIdLotCmd > 0  Then
	stMessage.sTitre		= "Annulation d'une commande"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	
	// #26
	// [BLCODE] // [PC13348&13408]
	// [DT141] Ajout SBE
	Choose Case sIdFour
		Case "O2M", "SB1", "MS1", "BLC", "MTT", "SBE"
			stMessage.sCode		= "COMD589"
		Case Else
			stMessage.sCode		= "COMD476"
	End Choose
	//stMessage.sCode		= "COMD476"
	// Fin #26
	
	F_Message ( stMessage )
	iRet = -1
	Return iRet
End If	
// :#6  [DCMP080479]

/*------------------------------------------------------------------*/
/* #3 CAG : 03/06/2003                                              */
/*------------------------------------------------------------------*/
// Si aucune cat$$HEX1$$e900$$ENDHEX$$gorie d'annulation n'est s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e
idw_AnnCmde.SetItem ( 1, "ID_ANN", 4 )  	//* #6  [DCMP080479]
/*
idw_AnnCmde.GetChild ( "ID_ANN", dwChild )
lRow = dwChild.GetSelectedRow ( 0 )
If lRow < 2 Then
	stMessage.sTitre		= "Annulation d'une commande"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD048"
	F_Message ( stMessage )
	iRet = -1
	Return iRet
End If
*/

stMessage.sTitre		= "Annulation d'une commande"
stMessage.Icon			= Exclamation!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= YesNo!

dtNow = DateTime ( Today (), Now () )
dNow  = Today ()
// sIdFour = Upper ( idw_TrtCmde.GetItemString ( 1, "ID_FOUR" ) ) // #26 - Fait en d$$HEX1$$e900$$ENDHEX$$but de fonction
sIdTypArt = Upper ( idw_TrtCmde.GetItemString ( 1, "ID_TYP_ART" ) )
dCmdGenLe = Date ( idw_TrtCmde.GetItemDateTime ( 1, "CMD_GEN_LE" ) )
dDteElvMob= Date ( idw_TrtCmde.GetItemDateTime ( 1, "DTE_ELV_MOBILE" ) )

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
Choose case sIdFour

	/*------------------------------------------------------------------*/
	/* CEGETEL	                                                        */
	/*------------------------------------------------------------------*/
	Case "CEG"

		Choose Case sIdTypArt 

			Case "TEL"
				/*------------------------------------------------------------------*/
				/* #2 Select dans PB, car cas extr$$HEX1$$ea00$$ENDHEX$$mement rare                      */
				/*------------------------------------------------------------------*/
				lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
				iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
				iIdLotCmd = -1

				// [DECIMAL_PAPILLON]
				dcIdsin = dec (lIdSin)
		      SELECT id_lot_cmd
		      INTO 	 :iIdLotCmd
				FROM   sysadm.commande
				WHERE  id_sin = :dcIdsin
				AND    id_seq = :iIdSeq
		      USING  SQLCA ;

				If iIdLotCmd = 0 Then
					/*------------------------------------------------------------------*/
					/* Jamais g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on annule en interne.                             */
					/*------------------------------------------------------------------*/
					bAnnulGen = False
					idw_TrtCmde.SetItem ( 1, "COD_ETAT", "ANN" )
					idw_TrtCmde.SetItem ( 1, "NOM_GEST", stGlb.sNomOper + " " +stGlb.sPrenomOper  )
					idw_TrtCmde.SetItem ( 1, "MAJ_LE", dtNow )	
					idw_TrtCmde.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )	
					idw_TrtCmde.SetItem ( 1, "ID_ANN", idw_AnnCmde.GetItemNumber ( 1, "ID_ANN" ) )					
				Else
					
					/*------------------------------------------------------------------*/
					/* Annulation CEGETEL, il faut contacter C. Tyberghien              */
					/*------------------------------------------------------------------*/
					stMessage.sCode		= "COMD039"
				End If


			Case "PRS"

				// Il n'y a pas de prestation pour CEGETEL

		End Choose


	/*------------------------------------------------------------------*/
	/* ORANGE/DME																		  */
	/*------------------------------------------------------------------*/
	Case "DME"

		Choose Case sIdTypArt 
			Case "TEL"

				/*------------------------------------------------------------------*/
				/* #2 Select dans PB, car cas extr$$HEX1$$ea00$$ENDHEX$$mement rare                      */
				/*------------------------------------------------------------------*/
				lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
				iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
				iIdLotCmd = -1

				// [DECIMAL_PAPILLON]
				dcIdsin = dec (lIdSin)
		      SELECT id_lot_cmd
		      INTO 	 :iIdLotCmd
				FROM   sysadm.commande
				WHERE  id_sin = :dcIdsin
				AND    id_seq = :iIdSeq
		      USING  SQLCA ;

				If iIdLotCmd = 0 Then
					/*------------------------------------------------------------------*/
					/* Jamais g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on annule en interne.                             */
					/*------------------------------------------------------------------*/
					bAnnulGen = False
					idw_TrtCmde.SetItem ( 1, "COD_ETAT", "ANN" )
					idw_TrtCmde.SetItem ( 1, "NOM_GEST", stGlb.sNomOper + " " +stGlb.sPrenomOper  )
					idw_TrtCmde.SetItem ( 1, "MAJ_LE", dtNow )	
					idw_TrtCmde.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )	
					idw_TrtCmde.SetItem ( 1, "ID_ANN", idw_AnnCmde.GetItemNumber ( 1, "ID_ANN" ) )					
				Else
					/*------------------------------------------------------------------*/
					/* Annulation ORANGE, il faut contacter Michel Lacourarie 			  */
					/*------------------------------------------------------------------*/
					stMessage.sCode		= "COMD047"
				End If


			Case "PRS"

				// Il n'y a pas de prestation pour ORANGE/DME


		End Choose

	/*------------------------------------------------------------------*/
	/* SBE																				  */
	/*------------------------------------------------------------------*/
	Case "SBE"

		Choose Case sIdTypArt 

			Case "TEL"

				// Il n'y a pas de Commandes pour A-NOVO


			Case "PRS"

				/*------------------------------------------------------------------*/
				/* #2 Select dans PB, car cas extr$$HEX1$$ea00$$ENDHEX$$mement rare                      */
				/*------------------------------------------------------------------*/
				lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
				iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
				iIdLotCmd = -1

				// [DECIMAL_PAPILLON]
				dcIdsin = dec (lIdSin)
		      SELECT id_lot_cmd
		      INTO 	 :iIdLotCmd
				FROM   sysadm.commande
				WHERE  id_sin = :dcIdsin
				AND    id_seq = :iIdSeq
		      USING  SQLCA ;

				If iIdLotCmd = 0 Then
					/*------------------------------------------------------------------*/
					/* Jamais g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on annule en interne.                             */
					/*------------------------------------------------------------------*/
					bAnnulGen = False
					idw_TrtCmde.SetItem ( 1, "COD_ETAT", "ANN" )
					idw_TrtCmde.SetItem ( 1, "NOM_GEST", stGlb.sNomOper + " " +stGlb.sPrenomOper  )
					idw_TrtCmde.SetItem ( 1, "MAJ_LE", dtNow )	
					idw_TrtCmde.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )
					idw_TrtCmde.SetItem ( 1, "ID_ANN", idw_AnnCmde.GetItemNumber ( 1, "ID_ANN" ) )
				Else
					/*------------------------------------------------------------------------*/
					/* Annulation SBE, il faut contacter Fr$$HEX1$$e900$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$ric Duhamel.						  */
					/*------------------------------------------------------------------------*/

					stMessage.sCode = "COMD053"
				End If


		End Choose

	/*------------------------------------------------------------------*/
	/* #5 CAG : 20/09/2004                                              */
	/*------------------------------------------------------------------*/
	/* MSS																				  */
	/*------------------------------------------------------------------*/
	Case "MSS"

		Choose Case sIdTypArt 

			Case "TEL"

				// Il n'y a pas de Commandes pour MSS


			Case "PRS"

				/*------------------------------------------------------------------*/
				/* #2 Select dans PB, car cas extr$$HEX1$$ea00$$ENDHEX$$mement rare                      */
				/*------------------------------------------------------------------*/
				lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
				iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
				iIdLotCmd = -1

				// [DECIMAL_PAPILLON]
				dcIdsin = dec (lIdSin)
		      SELECT id_lot_cmd
		      INTO 	 :iIdLotCmd
				FROM   sysadm.commande
				WHERE  id_sin = :dcIdsin
				AND    id_seq = :iIdSeq
		      USING  SQLCA ;

				If iIdLotCmd = 0 Then
					/*------------------------------------------------------------------*/
					/* Jamais g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on annule en interne.                             */
					/*------------------------------------------------------------------*/
					bAnnulGen = False
					idw_TrtCmde.SetItem ( 1, "COD_ETAT", "ANN" )
					idw_TrtCmde.SetItem ( 1, "NOM_GEST", stGlb.sNomOper + " " +stGlb.sPrenomOper  )
					idw_TrtCmde.SetItem ( 1, "MAJ_LE", dtNow )	
					idw_TrtCmde.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )	
					idw_TrtCmde.SetItem ( 1, "ID_ANN", idw_AnnCmde.GetItemNumber ( 1, "ID_ANN" ) )					
				Else
					/*------------------------------------------------------------------------*/
					/* Annulation SBE, il faut contacter Fran$$HEX1$$e700$$ENDHEX$$ois Faisans.						  */
					/*------------------------------------------------------------------------*/

					stMessage.sCode = "COMD054"
				End If


		End Choose
	/*------------------------------------------------------------------*/
	/*  #6    MADM  07/02/2006   [DCMP060119]: Ajout du frn AEVUM/AVM   */
	/*  #7    MADM  09/05/2006   [DCMP060356]: Rempl du frn AVM par COR */
	/*------------------------------------------------------------------*/
	/* AEVUM																				  */
	/* CORDON/COR																		  */
	/*------------------------------------------------------------------*/
	// [PM200][PSM]
	// [PC801_6_TAMET]
	// [DT361]
	Case "COR", "PSM", "TMT", "CEA"

		Choose Case sIdTypArt 

			Case "TEL"

				// Il n'y a pas de Commandes pour CORDON


			Case "PRS"

				/*------------------------------------------------------------------*/
				/* #2 Select dans PB, car cas extr$$HEX1$$ea00$$ENDHEX$$mement rare                      */
				/*------------------------------------------------------------------*/
				lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
				iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
				iIdLotCmd = -1

				// [DECIMAL_PAPILLON]
				dcIdsin = dec (lIdSin)
		      SELECT id_lot_cmd
		      INTO 	 :iIdLotCmd
				FROM   sysadm.commande
				WHERE  id_sin = :dcIdsin
				AND    id_seq = :iIdSeq
		      USING  SQLCA ;

				If iIdLotCmd = 0 Then
					/*------------------------------------------------------------------*/
					/* Jamais g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on annule en interne.                             */
					/*------------------------------------------------------------------*/
					bAnnulGen = False
					idw_TrtCmde.SetItem ( 1, "COD_ETAT", "ANN" )
					idw_TrtCmde.SetItem ( 1, "NOM_GEST", stGlb.sNomOper + " " +stGlb.sPrenomOper  )
					idw_TrtCmde.SetItem ( 1, "MAJ_LE", dtNow )	
					idw_TrtCmde.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )	
					idw_TrtCmde.SetItem ( 1, "ID_ANN", idw_AnnCmde.GetItemNumber ( 1, "ID_ANN" ) )					
				Else
					/*------------------------------------------------------------------------*/
					/* Annulation COR, il faut contacter .												  */
					/*------------------------------------------------------------------------*/

					stMessage.sCode = "COMD426"
				End If


		End Choose

	/*------------------------------------------------------------------*/
	/* #9 C-DISCOUNT                                                  */
	/*------------------------------------------------------------------*/
	Case "CDS"

		Choose Case sIdTypArt 
			Case "EDI"

				/*------------------------------------------------------------------*/
				/* #2 Select dans PB, car cas extr$$HEX1$$ea00$$ENDHEX$$mement rare                      */
				/*------------------------------------------------------------------*/
				lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
				iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
				iIdLotCmd = -1

				// [DECIMAL_PAPILLON]
				dcIdsin = dec (lIdSin)
		      SELECT id_lot_cmd
		      INTO 	 :iIdLotCmd
				FROM   sysadm.commande
				WHERE  id_sin = :dcIdsin 
				AND    id_seq = :iIdSeq
		      USING  SQLCA ;

				If iIdLotCmd = 0 Then
					/*------------------------------------------------------------------*/
					/* Jamais g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on annule en interne.                             */
					/*------------------------------------------------------------------*/
					bAnnulGen = False
					idw_TrtCmde.SetItem ( 1, "COD_ETAT", "ANN" )
					idw_TrtCmde.SetItem ( 1, "NOM_GEST", stGlb.sNomOper + " " +stGlb.sPrenomOper  )
					idw_TrtCmde.SetItem ( 1, "MAJ_LE", dtNow )	
					idw_TrtCmde.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )	
					idw_TrtCmde.SetItem ( 1, "ID_ANN", idw_AnnCmde.GetItemNumber ( 1, "ID_ANN" ) )					
				Else
					stMessage.sCode		= "COMD056"
				End If

		End Choose
		

	/*------------------------------------------------------------------*/
	/* #8 WEB ASSURE (WBA)                                              */
	/*------------------------------------------------------------------*/
	Case "WBA"

		Choose Case sIdTypArt 
			Case "TEL"

				/*------------------------------------------------------------------*/
				/* #2 Select dans PB, car cas extr$$HEX1$$ea00$$ENDHEX$$mement rare                      */
				/*------------------------------------------------------------------*/
				lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
				iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
				iIdLotCmd = -10

				// [DECIMAL_PAPILLON]
				dcIdsin = dec (lIdSin)
		      SELECT id_lot_cmd
		      INTO 	 :iIdLotCmd
				FROM   sysadm.commande
				WHERE  id_sin = :dcIdsin
				AND    id_seq = :iIdSeq
		      USING  SQLCA ;

				If iIdLotCmd = -1 Then   // Attention tester $$HEX2$$e0002000$$ENDHEX$$-1 pas 0 !!!
					stMessage.sCode		= "COMD441"
					//* #17 [20090209142923553]
					bMessParticulier = TRUE
				End If
		End CHoose 

// [WEBSIM2].[FRANCE]
	Case "WBB"

		/*------------------------------------------------------------------*/
		/* #2 Select dans PB, car cas extr$$HEX1$$ea00$$ENDHEX$$mement rare                      */
		/*------------------------------------------------------------------*/
		lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
		iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
		iIdLotCmd = -10

		// [DECIMAL_PAPILLON]
		dcIdsin = dec (lIdSin)
		SELECT id_lot_cmd
		INTO 	 :iIdLotCmd
		FROM   sysadm.commande
		WHERE  id_sin = :dcIdsin
		AND    id_seq = :iIdSeq
		USING  SQLCA ;

		If iIdLotCmd = -1 Then   // Attention tester $$HEX2$$e0002000$$ENDHEX$$-1 pas 0 !!!
			stMessage.sCode		= "COMD623"
			bMessParticulier = TRUE // [WEBSIM2].[2]
		End If
// :[WEBSIM2].[FRANCE]

	// #23 [DCMP090327].[SBETV]
	// [MSS_DIAG]
	// [BLCODE]
	// [PC13348&13408]
	// [DT141] Ajout SBE
	Case "O2M", "SB1", "MS1", "BLC", "MTT", "SBE" //#11 [O2M]

		Choose Case sIdTypArt 
			Case "EDI", "PRS"

				/*------------------------------------------------------------------*/
				/*  Select dans PB, car cas extr$$HEX1$$ea00$$ENDHEX$$mement rare                      */
				/*------------------------------------------------------------------*/
				lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
				iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
				iIdLotCmd = -1


				// [DECIMAL_PAPILLON]
				dcIdsin = dec (lIdSin)
		      SELECT id_lot_cmd
		      INTO 	 :iIdLotCmd
				FROM   sysadm.commande
				WHERE  id_sin = :dcIdsin 
				AND    id_seq = :iIdSeq
		      USING  SQLCA ;

				If iIdLotCmd = 0 Then
					/*------------------------------------------------------------------*/
					/* Jamais g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on annule en interne.                             */
					/*------------------------------------------------------------------*/
					bAnnulGen = False
					idw_TrtCmde.SetItem ( 1, "COD_ETAT", "ANN" )
					idw_TrtCmde.SetItem ( 1, "NOM_GEST", stGlb.sNomOper + " " +stGlb.sPrenomOper  )
					idw_TrtCmde.SetItem ( 1, "MAJ_LE", dtNow )	
					idw_TrtCmde.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )	
					idw_TrtCmde.SetItem ( 1, "ID_ANN", idw_AnnCmde.GetItemNumber ( 1, "ID_ANN" ) )										
				Else // #12 [DCMP080174] Plus de message, les commandes annul$$HEX1$$e900$$ENDHEX$$es et envoy$$HEX1$$e900$$ENDHEX$$es
					  // sont envoy$$HEX1$$e900$$ENDHEX$$es sont forme de fichier Excel $$HEX2$$e0002000$$ENDHEX$$O2M
//					/*------------------------------------------------------------------------*/
//					/* Annulation O2M, il faut contacter .												  */
//					/*------------------------------------------------------------------------*/
//
//					stMessage.sCode = "COMD460" // [O2M] Message d'annulation de commande

//* #25  [MSS_DIAG] Je shunt le FALSE qui se trouve $$HEX1$$ea00$$ENDHEX$$tre g$$HEX1$$ea00$$ENDHEX$$nant.
//					bAffichMsg	= False // #13 [DCMP080174]
				End If

		End CHoose

//* #15 [MICROMANIA]  Annul$$HEX2$$e9002000$$ENDHEX$$par Lisette Small le 09/09/08, pas de process d'annulatino pour MCM.
//* #16 [DCMP090026] Je r$$HEX1$$e900$$ENDHEX$$active le process d'annulation Micromania.
	Case "MCM" 

		Choose Case sIdTypArt 
			Case "AEF"

				/*------------------------------------------------------------------*/
				/*  Select dans PB, car cas extr$$HEX1$$ea00$$ENDHEX$$mement rare                      */
				/*------------------------------------------------------------------*/
				lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
				iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
				iIdLotCmd = -1

				// [DECIMAL_PAPILLON]
				dcIdsin = dec (lIdSin)
		      SELECT id_lot_cmd
		      INTO 	 :iIdLotCmd
				FROM   sysadm.commande
				WHERE  id_sin = :dcIdsin 
				AND    id_seq = :iIdSeq
		      USING  SQLCA ;

				If iIdLotCmd = 0 Then
					/*------------------------------------------------------------------*/
					/* Jamais g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on annule en interne.                             */
					/*------------------------------------------------------------------*/
					bAnnulGen = False
					idw_TrtCmde.SetItem ( 1, "COD_ETAT", "ANN" )
					idw_TrtCmde.SetItem ( 1, "NOM_GEST", stGlb.sNomOper + " " +stGlb.sPrenomOper  )
					idw_TrtCmde.SetItem ( 1, "MAJ_LE", dtNow )	
					idw_TrtCmde.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )	
					idw_TrtCmde.SetItem ( 1, "ID_ANN", idw_AnnCmde.GetItemNumber ( 1, "ID_ANN" ) )										
				Else 					
					stMessage.sCode = "COMD481"
					//* #17 [20090209142923553]
					bMessParticulier = TRUE					
				End If

		End CHoose

	//* #19 [DCMP090102]
	Case "CDP"

		Choose Case sIdTypArt 
			Case "xxx"
			Case Else				

				/*------------------------------------------------------------------*/
				/* #2 Select dans PB, car cas extr$$HEX1$$ea00$$ENDHEX$$mement rare                      */
				/*------------------------------------------------------------------*/
				lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
				iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
				iIdLotCmd = -1

				// [DECIMAL_PAPILLON]
				dcIdsin = dec (lIdSin)
		      SELECT id_lot_cmd
		      INTO 	 :iIdLotCmd
				FROM   sysadm.commande
				WHERE  id_sin = :dcIdsin 
				AND    id_seq = :iIdSeq
		      USING  SQLCA ;

				If iIdLotCmd = 0 Then
					/*------------------------------------------------------------------*/
					/* Jamais g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on annule en interne.                             */
					/*------------------------------------------------------------------*/
					bAnnulGen = False
					idw_TrtCmde.SetItem ( 1, "COD_ETAT", "ANN" )
					idw_TrtCmde.SetItem ( 1, "NOM_GEST", stGlb.sNomOper + " " +stGlb.sPrenomOper  )
					idw_TrtCmde.SetItem ( 1, "MAJ_LE", dtNow )	
					idw_TrtCmde.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )	
					idw_TrtCmde.SetItem ( 1, "ID_ANN", idw_AnnCmde.GetItemNumber ( 1, "ID_ANN" ) )					
				Else
					// stMessage.sCode		= ""
				End If
		End CHoose
		
	//* #20 [DCMP090140]
	// [DT076-2] [PM444-1] [RS3200]
	Case "PAP", "CIS", "BK2", "AGP", "TLS", "CDF"

		Choose Case sIdTypArt 
			Case "TEL"

				/*------------------------------------------------------------------*/
				/* #2 Select dans PB, car cas extr$$HEX1$$ea00$$ENDHEX$$mement rare                      */
				/*------------------------------------------------------------------*/
				lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
				iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
				iIdLotCmd = -1

				// [DECIMAL_PAPILLON]
				dcIdsin = dec (lIdSin)
		      SELECT id_lot_cmd
		      INTO 	 :iIdLotCmd
				FROM   sysadm.commande
				WHERE  id_sin = :dcIdsin 
				AND    id_seq = :iIdSeq
		      USING  SQLCA ;

				If iIdLotCmd = 0 Then
					/*------------------------------------------------------------------*/
					/* Jamais g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on annule en interne.                             */
					/*------------------------------------------------------------------*/
					bAnnulGen = False
					idw_TrtCmde.SetItem ( 1, "COD_ETAT", "ANN" )
					idw_TrtCmde.SetItem ( 1, "NOM_GEST", stGlb.sNomOper + " " +stGlb.sPrenomOper  )
					idw_TrtCmde.SetItem ( 1, "MAJ_LE", dtNow )	
					idw_TrtCmde.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )	
					idw_TrtCmde.SetItem ( 1, "ID_ANN", idw_AnnCmde.GetItemNumber ( 1, "ID_ANN" ) )					
				Else
					// stMessage.sCode		= ""
				End If

		End CHoose

	//* #22 [RUEDUCOMMERCE]
	Case "RDC"

		Choose Case sIdTypArt 
			Case "xxx"
			Case Else				

				/*------------------------------------------------------------------*/
				/* #2 Select dans PB, car cas extr$$HEX1$$ea00$$ENDHEX$$mement rare                      */
				/*------------------------------------------------------------------*/
				lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
				iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
				iIdLotCmd = -1

				// [DECIMAL_PAPILLON]
				dcIdsin = dec (lIdSin)
		      SELECT id_lot_cmd
		      INTO 	 :iIdLotCmd
				FROM   sysadm.commande
				WHERE  id_sin = :dcIdsin 
				AND    id_seq = :iIdSeq
		      USING  SQLCA ;

				If iIdLotCmd = 0 Then
					/*------------------------------------------------------------------*/
					/* Jamais g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on annule en interne.                             */
					/*------------------------------------------------------------------*/
					bAnnulGen = False
					idw_TrtCmde.SetItem ( 1, "COD_ETAT", "ANN" )
					idw_TrtCmde.SetItem ( 1, "NOM_GEST", stGlb.sNomOper + " " +stGlb.sPrenomOper  )
					idw_TrtCmde.SetItem ( 1, "MAJ_LE", dtNow )	
					idw_TrtCmde.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )	
					idw_TrtCmde.SetItem ( 1, "ID_ANN", idw_AnnCmde.GetItemNumber ( 1, "ID_ANN" ) )					
				Else
					// stMessage.sCode		= ""
				End If
		End CHoose
	
	// #24 [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]	
	Case "FNC"

		Choose Case sIdTypArt 
			Case "CAF"
				/*------------------------------------------------------------------*/
				/* Annulation aupr$$HEX1$$e800$$ENDHEX$$s du fournisseur par fichier.						  */
				/*------------------------------------------------------------------*/
				lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
				iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
				iIdLotCmd = -1

				// [DECIMAL_PAPILLON]
				dcIdsin = dec (lIdSin)
		      SELECT id_lot_cmd
		      INTO 	 :iIdLotCmd
				FROM   sysadm.commande
				WHERE  id_sin = :dcIdsin 
				AND    id_seq = :iIdSeq
		      USING  SQLCA ;

				If iIdLotCmd = 0 Then
					bAnnulGen = False
					stMessage.sCode = "COMD570"
					stMessage.Icon			= Information!
					stMessage.Bouton		= Ok!
					F_Message ( stMessage )
				Else
					stMessage.sCode		= "COMD031"
					stMessage.Bouton		= YESNO!

					if F_Message ( stMessage ) = 2 then
						bAnnulGen = False
					Else 
						bAffichMsg	= False 
						bAnnulationParFluxEdi = True
						idw_TrtCmde.SetItem ( 1, "COD_ETAT", "ANN" )
						idw_TrtCmde.SetItem ( 1, "NOM_GEST", stGlb.sNomOper + " " +stGlb.sPrenomOper  )
						idw_TrtCmde.SetItem ( 1, "MAJ_LE", dtNow )	
						idw_TrtCmde.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )	
						idw_TrtCmde.SetItem ( 1, "ID_ANN", idw_AnnCmde.GetItemNumber ( 1, "ID_ANN" ) )					
					End If
				End If				

				stMessage.Bouton		= Ok!
		End Choose

	// [PC363_AUCHAN]
	// [PC721] Ajout LBE
	Case "AUC" , "LBE"

		Choose Case sIdTypArt 
			Case "CAF"
				lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
				iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
				iIdLotCmd = -1

				// [DECIMAL_PAPILLON]
				dcIdsin = dec (lIdSin)
		      SELECT id_lot_cmd
		      INTO 	 :iIdLotCmd
				FROM   sysadm.commande
				WHERE  id_sin = :dcIdsin 
				AND    id_seq = :iIdSeq
		      USING  SQLCA ;

				If iIdLotCmd = 0 Then
					/*------------------------------------------------------------------*/
					/* Jamais g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on annule en interne.                             */
					/*------------------------------------------------------------------*/
					bAnnulGen = False
					idw_TrtCmde.SetItem ( 1, "COD_ETAT", "ANN" )
					idw_TrtCmde.SetItem ( 1, "NOM_GEST", stGlb.sNomOper + " " +stGlb.sPrenomOper  )
					idw_TrtCmde.SetItem ( 1, "MAJ_LE", dtNow )	
					idw_TrtCmde.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )	
					idw_TrtCmde.SetItem ( 1, "ID_ANN", idw_AnnCmde.GetItemNumber ( 1, "ID_ANN" ) )					
				Else
					// stMessage.sCode		= ""
				End If
		End CHoose		

	// [PC301].[LOT2]
	Case "CAR"

		Choose Case sIdTypArt 

			Case "XXX"
			Case Else

				/*------------------------------------------------------------------*/
				/* #2 Select dans PB, car cas extr$$HEX1$$ea00$$ENDHEX$$mement rare                      */
				/*------------------------------------------------------------------*/
				lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
				iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
				iIdLotCmd = -1

				// [DECIMAL_PAPILLON]
				dcIdsin = dec (lIdSin)
		      SELECT id_lot_cmd
		      INTO 	 :iIdLotCmd
				FROM   sysadm.commande
				WHERE  id_sin = :dcIdsin
				AND    id_seq = :iIdSeq
		      USING  SQLCA ;

				If iIdLotCmd = 0 Then
					/*------------------------------------------------------------------*/
					/* Jamais g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on annule en interne.                             */
					/*------------------------------------------------------------------*/
					bAnnulGen = False
					idw_TrtCmde.SetItem ( 1, "COD_ETAT", "ANN" )
					idw_TrtCmde.SetItem ( 1, "NOM_GEST", stGlb.sNomOper + " " +stGlb.sPrenomOper  )
					idw_TrtCmde.SetItem ( 1, "MAJ_LE", dtNow )	
					idw_TrtCmde.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )	
					idw_TrtCmde.SetItem ( 1, "ID_ANN", idw_AnnCmde.GetItemNumber ( 1, "ID_ANN" ) )					
				Else
					// stMessage.sCode		= ""
				End If

		End Choose		
		
	Case "SCR"// [VDOC5312]
		Choose Case sIdTypArt 

			Case "PRS"

				/*------------------------------------------------------------------*/
				/* #2 Select dans PB, car cas extr$$HEX1$$ea00$$ENDHEX$$mement rare                      */
				/*------------------------------------------------------------------*/
				lIdSin = idw_TrtCmde.GetItemNumber ( 1, "ID_SIN")
				iIdSeq = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ")
				iIdLotCmd = -1

				// [DECIMAL_PAPILLON]
				dcIdsin = dec (lIdSin)
			      SELECT id_lot_cmd
			      INTO 	 :iIdLotCmd
					FROM   sysadm.commande
				WHERE  id_sin = :dcIdsin
					AND    id_seq = :iIdSeq
			      USING  SQLCA ;

				If iIdLotCmd = 0 Then
					/*------------------------------------------------------------------*/
					/* Jamais g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on annule en interne.                             */
					/*------------------------------------------------------------------*/
					bAnnulGen = False
					idw_TrtCmde.SetItem ( 1, "COD_ETAT", "ANN" )
					idw_TrtCmde.SetItem ( 1, "NOM_GEST", stGlb.sNomOper + " " +stGlb.sPrenomOper  )
					idw_TrtCmde.SetItem ( 1, "MAJ_LE", dtNow )	
					idw_TrtCmde.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )	
					idw_TrtCmde.SetItem ( 1, "ID_ANN", idw_AnnCmde.GetItemNumber ( 1, "ID_ANN" ) )					
				Else
					// stMessage.sCode		= ""
				End If

		End Choose		
		// fin [VDoc5312]
		
		// [PR09]
		Case "GAM"
			Choose Case sIdTypArt 
				Case "CAF"
					// On autorise dans tous les cas
			End choose
		// :[PR09]
		
		// [PC543][MANTIS5739]		
		Case "CFM"
			Choose Case sIdTypArt 
				Case "CAF"
					// On autorise dans tous les cas
			End choose

		// [ITSM215956]
		Case "ADV"
			Choose Case sIdTypArt 
				Case "CAF"
					// On autorise dans tous les cas
			End choose

		//[ITSM250955]
		Case "OME"
			Choose Case sIdTypArt 
				Case "CAF"
					// On autorise dans tous les cas
			End choose

		//[PC13321]	
		Case "ELD"
			Choose Case sIdTypArt 
				Case "CAF"
					// On autorise dans tous les cas
			End choose
		
		// [ITSM306150] [ITSM363758][ITSM394275]
		Case "DTY", "MBS", "CVC", "ATC", "CMA", "OMT", "AAS"
			// On autorise dans tous les cas
			
	/*------------------------------------------------------------------*/
	/* Pas d'annulation.																  */
	/*------------------------------------------------------------------*/
	// "DTY", "DST", "CDS", "MBS"
	// JFF le 23/11/2006 : Je modifie en Else
	Case Else

			bAnnulGen = False
			iRet = -1
			stMessage.Icon			= Information!
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "COMD064"				
			F_Message ( stMessage )

End Choose


/*------------------------------------------------------------------*/
/* #2                                                               */
/*------------------------------------------------------------------*/
If bAnnulGen Then
	// #13 [DCMP080174]
	if bAffichMsg Then
		//* #17 [20090209142923553]
		If Not bMessParticulier Then
			stMessage.sCode		= "COMD477"		// #6  [DCMP080479] On force le message $$HEX2$$e0002000$$ENDHEX$$pr$$HEX1$$e900$$ENDHEX$$sent
			//* #25  [MSS_DIAG]
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YesNo!
		End If
		iReponse = F_Message ( stMessage )
	Else
		iReponse = 1 // Pas de message, on confirme donc par defaut l'annulation.
	End If

	// [PM462-1][V3]
	If F_CLE_A_TRUE ( "PM462-1" ) Then
		SQLCA.PS_S_ANNUL_PRESTA_CTRLE_FRANCHISE_CB ( lIdSin, iIdSeq, dcMtFranchiseARemb )
		If dcMtFranchiseARemb > 0 Then
			stMessage.sCode	= "COMD992"
			//* #25  [MSS_DIAG]
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YesNo!			
			stMessage.sVar[1] =  String ( dcMtFranchiseARemb, "#,##0.00 \$$HEX1$$ac20$$ENDHEX$$" ) 
			iReponse = F_Message ( stMessage )
		End If 
	End If

	if iReponse = 1 Then
		idw_TrtCmde.SetItem ( 1, "COD_ETAT", "ANN" )
		idw_TrtCmde.SetItem ( 1, "NOM_GEST", stGlb.sNomOper + " " +stGlb.sPrenomOper  )
		idw_TrtCmde.SetItem ( 1, "MAJ_LE", dtNow )	
		idw_TrtCmde.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )	
		/*------------------------------------------------------------------*/
		/* #3 CAG : 03/06/2003                                              */
		/*------------------------------------------------------------------*/
		idw_TrtCmde.SetItem ( 1, "ID_ANN", idw_AnnCmde.GetItemNumber ( 1, "ID_ANN" ) )

		// [ETAT_153_SUR_ANN_2AC]
		If sIdRefFour = "REFUSE_A_REEXP" Then
			lVal1 = idw_LstCmde.Find ( "ID_TYP_ART = 'PRS' AND STATUS_GC IN ( 153, 154) AND COD_ETAT IN ( 'RFO', 'RPC' ) AND ID_SEQ < " + String ( iIdSeq ), 1, idw_LstCmde.RowCount () )
			lVal2= Long ( idw_LstCmde.Describe ( "Evaluate ( 'Max ( ID_SEQ )', 0 )" ) ) 
			If lVal1 > 0 And lVal2 = iIdSeq Then
				idw_LstCmde.SetItem ( lVal1, "COD_ETAT", "ECT" )
				sVal = idw_LstCmde.GetItemString ( lVal1, "INFO_SPB_FRN_CPLT" )
				lnvPFCString.of_Setkeyvalue ( sVal, "ANN_RAREXP_" + stGlb.sCodOper + "_ECT", String ( Today(), "dd/mm/yyyy"), ";")
				idw_LstCmde.SetItem ( lVal1, "INFO_SPB_FRN_CPLT", Trim ( sVal ))
			End If
		End If

		// [WEBSIM2].[FRANCE]
		If Upper ( idw_TrtCmde.GetItemString ( 1, "ID_FOUR" ) ) = "WBB" Then
			lRow = idw_wDivSin.Find ( "NOM_ZONE = 'mdp_net_boutique'", 1,  idw_WDivSin.RowCount () ) 
			If lRow > 0 Then
				idw_wDivSin.SetItem ( lRow, "VAL_CAR", stNul.Str )
			End If
		End If
		// [WEBSIM2].[FRANCE]
				
		//* #6  [DCMP080479]
		If Not Upper ( idw_TrtCmde.GetItemString ( 1, "ID_FOUR" ) ) = "WBA" &
			And Not Upper ( idw_TrtCmde.GetItemString ( 1, "ID_FOUR" ) ) = "WBB" &
			And Not bAnnulationParFluxEdi Then
			stMessage.sCode = "COMD478"
			//* #25  [MSS_DIAG]
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!			
			F_Message ( stMessage )
		End If
		//* :#6  [DCMP080479]

		// #24 [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
		If bAnnulationParFluxEdi Then
			stMessage.sCode	= "COMD569"
			//* #25  [MSS_DIAG]
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!			
			stMessage.sVar[1] = sIdFour
			F_Message ( stMessage )
		End IF

	Else
		iRet = -1
	End If
End If

Return iRet
end function

private function string uf_formatage_tel (string astext, boolean abswitch);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commandes2:Uf_Formatage_Tel (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/10/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Formatage des N$$HEX2$$b0002000$$ENDHEX$$de Tel
//* Commentaires	: 
//*
//* Arguments		: asText		String		Val
//*					  abSwitch	Boolean		Val		True : on ins$$HEX1$$e900$$ENDHEX$$re des espaces
//*																False: on retire les espaces
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
String	sVal, sCar
Int		iLen
Long		lCpt


sVal = Trim ( asText )
iLen = Len ( Trim ( sVal ) )

/*------------------------------------------------------------------*/
/* Que des Chiffres ou des espaces dans le n$$HEX2$$b0002000$$ENDHEX$$de T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phone.         */
/*------------------------------------------------------------------*/
If abSwitch Then
	For lCpt = 1 To iLen
		sCar = Mid ( sVal, lCpt, 1 )
		If Not ( ( Asc (sCar) >= 48 And asc (sCar) <= 57 ) Or sCar = " " ) Then
			sVal = "-1"
			Return sVal
		End If
	Next
End IF

CHOOSE CASE abSwitch
	CASE TRUE

		CHOOSE CASE iLen
		
			// Standard Fran$$HEX1$$e700$$ENDHEX$$ais 1234567890 -> 12 34 56 78 90
			CASE 10

				sVal = Left ( sVal, 2 ) 	+ " " + &
						 Mid  ( sVal, 3, 2 ) + " " + &
						 Mid  ( sVal, 5, 2 ) + " " + &
						 Mid  ( sVal, 7, 2 ) + " " + &
						 Right( sVal, 2 ) 

		END CHOOSE

	CASE ELSE

		/*------------------------------------------------------------------*/
		/* Pas d'espace pour les num$$HEX1$$e900$$ENDHEX$$ros de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phone.                      */
		/*------------------------------------------------------------------*/
		For lCpt = iLen To 1 Step -1
			If Mid ( sVal, lCpt, 1 ) = " " Then 
				sVal = Replace ( sVal, lCpt, 1, "" )
			End If
		Next

END CHOOSE



Return sVal
end function

public function boolean uf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande2::Uf_PreparerValider (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 31/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Pr$$HEX1$$e900$$ENDHEX$$paration de la validation d'une commande
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
/* On supprime les espaces des n$$HEX2$$b0002000$$ENDHEX$$de Tel seulement pour les n$$HEX7$$b000200020002000200020002000$$ENDHEX$$*/
/* Fran$$HEX1$$e700$$ENDHEX$$ais $$HEX2$$e0002000$$ENDHEX$$10 Chiffres.                                          */
/*------------------------------------------------------------------*/
idw_TrtClient.SetItem ( 1, "ADR_TEL1", Uf_Formatage_Tel ( idw_TrtClient.GetItemString ( 1, "ADR_TEL1" ), FALSE ) )
idw_TrtClient.SetItem ( 1, "ADR_TEL2", Uf_Formatage_Tel ( idw_TrtClient.GetItemString ( 1, "ADR_TEL2" ), FALSE ) )
idw_TrtClient.SetItem ( 1, "ADR_TEL3", Uf_Formatage_Tel ( idw_TrtClient.GetItemString ( 1, "ADR_TEL3" ), FALSE ) )

Return True

end function

private subroutine uf_modifier_icone_sfr ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_W_Commande2::uf_Modifier_Icone_Sfr (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 21/07/2002 09:31:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On positionne un BITMAP diff$$HEX1$$e900$$ENDHEX$$rent sur la zone ADR_TEL3
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String sMod, sIdTypArt

sIdTypArt 			= Upper ( idw_TrtCmde.GetItemString ( 1, "ID_TYP_ART" ) )

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/

If	idw_Produit.GetItemNumber ( 1, "COD_TEL" ) = 21	And sIdTypArt = "PRS" And &
	idw_Produit.GetItemNumber ( 1, "ID_PROD" ) <> 5707 Then
	sMod = "P_ADR_TEL3.FileName = 'K:\PB4OBJ\BMP\TEL_PORT.BMP'"
Else
	sMod = "P_ADR_TEL3.FileName = 'K:\PB4OBJ\BMP\TEL.BMP'"
End If
/*------------------------------------------------------------------*/
/* On execute le modify sur la DW.                                  */
/*------------------------------------------------------------------*/
idw_TrtClient.Modify ( sMod )

end subroutine

private subroutine uf_zn_adrcp (string asval, boolean abinit);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_W_Commande3::uf_Zn_AdrCp (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 21/07/2002 09:31:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On s'occupe de la zone ADR_CP
//*
//* Arguments		: (Val)		asVal		String
//*					  (Val)		abInit	Vient-on de la fonction uf_PreparerModifier ou Non ?
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   04/06/2003	  Modification de la structure de la table ZONE_COGEPAR (nouvellement
//*								  nomm$$HEX1$$e900$$ENDHEX$$e ZONE_FOURNISSEUR), donc modification du sRech
//* 
//*-----------------------------------------------------------------

Long lTotZoneFournisseur, lLig, lIdProd
String sIdZone, sRech, sFiltreFin, sIdFour, sValDefaut
DataWindowChild		dwChild

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
lIdProd =  idw_Produit.GetItemNumber ( 1, "ID_PROD" )
sIdFour =  idw_TrtCmde.GetItemString ( 1, "ID_FOUR" )

sValDefaut = "B"  // B pour CETELEC

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
If	idw_Produit.GetItemNumber ( 1, "COD_TEL" ) = 21 And lIdProd <> 5707	Then
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si le CODE POSTAL que l'on vient de saisir existe     */
/* dans la table ZONE_COGEPAR.                                      */
/*------------------------------------------------------------------*/
	If	Not IsNull ( asVal )	Then
		lTotZoneFournisseur = idw_ZoneFournisseur.RowCount ()

		// #1
		sRech = "ID_PROD = " + String ( lIdProd ) + "  AND " + &
				  "ID_FOUR = '" + sIdFour 				+ "' AND " + &
				  "CODE_POSTAL = '" + asVal + "'"
		lLig = idw_ZoneFournisseur.Find ( sRech, 1, lTotZoneFournisseur )

		If	lLig > 0	Then
			// #1
			sIdZone = idw_ZoneFournisseur.GetItemString ( lLig, "CODE_ACTION" )
		Else
			sIdZone = sValDefaut 
		End If
	Else
		sIdZone = stNul.str
	End If
/*------------------------------------------------------------------*/
/* Il s'agit de l'initialisation, c'est $$HEX2$$e0002000$$ENDHEX$$dire que l'on vient       */
/* directement de la fonction uf_PreparerModifier, il faut prendre  */
/* les valeurs remont$$HEX1$$e900$$ENDHEX$$es par le SELECT.                             */
/*------------------------------------------------------------------*/
	If	Not abInit	Then
		idw_TrtCmde.SetItem ( 1, "ID_ZONE", sIdZone )
/*------------------------------------------------------------------*/
/* On positionne les zones qui d$$HEX1$$e900$$ENDHEX$$pendent de ID_ZONE $$HEX2$$e0002000$$ENDHEX$$NULL.         */
/*------------------------------------------------------------------*/
		idw_TrtCmde.SetItem ( 1, "ID_CHOIX_HORAIRE", stNul.lng )
		idw_TrtCmde.SetItem ( 1, "DTE_RDV_CLI", stNul.dat )
		idw_TrtCmde.SetItem ( 1, "HRDV_CLI_MIN", stNul.str )
		idw_TrtCmde.SetItem ( 1, "HRDV_CLI_MAX", stNul.str )
	End If


	sFiltreFin = This.uf_Filtrer_HoraireRdv ( sIdZone )
	idw_TrtCmde.GetChild ( "ID_CHOIX_HORAIRE", dwChild )

	dwChild.SetFilter ( sFiltreFin )
	dwChild.Filter ()
	dwChild.Sort ()
End If

end subroutine

private function string uf_controlergestion_cegetel ();//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_w_commande2::uf_ControlerGestion_CEGETEL ( PRIVATE )
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 04/10/2002 16:19:15
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : Aucun
//*
//* Retourne      : String	:	1 lettre + nom zone erreur ( lettre = dw sur laquelle se situe l'erreur )
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   	11/03/2003 Ajout de contr$$HEX1$$f400$$ENDHEX$$les sur adresses et ville
//* #2 	 CAG		19/05/03	DCMP 030207 : Ajout de 6 zones en retour de Cetelec (pour Cegetel Must)
//*								=> ajout d'une dw suppl$$HEX1$$e900$$ENDHEX$$mentaire => modif gestion des boutons prec et suiv
//* #3	 CAG		25/11/2003 Ajout d'un param$$HEX1$$e800$$ENDHEX$$tre : num$$HEX1$$e900$$ENDHEX$$ro de pg
//*-----------------------------------------------------------------

DataWindowChild	dwChild
String				sPos
Long					lRow, lLen

sPos = ""

	idw_TrtClient.GetChild ( "ADR_COD_CIV", dwChild )
	lRow = dwChild.GetRow ()

	lLen = Len ( Trim ( dwChild.GetItemString ( lRow, "LIB_CODE" ) ) ) + &
			 Len ( Trim ( idw_TrtClient.GetItemString ( 1, "ADR_NOM" ) ) )+ &
			 Len ( Trim ( idw_TrtClient.GetItemString ( 1, "ADR_PRENOM" ) ) )
	// -2 pour les 2 espaces entre la civilit$$HEX2$$e9002000$$ENDHEX$$et le nom, et le nom et le pr$$HEX1$$e900$$ENDHEX$$nom
	If lLen > 30 - 2 Then
		stMessage.sCode = "COMD038"
		sPos = "ADR_NOM"
	End If

	/*------------------------------------------------------------------*/
	/*	#1 ADR_CPL <= 30                                                 */
	/*------------------------------------------------------------------*/
	lLen = Len ( Trim ( idw_TrtClient.GetItemString ( 1, "ADR_LIVR_CPL" ) ) )
	If lLen > 30 Then
		stMessage.sCode = "COMD041"
		sPos = "ADR_LIVR_CPL" 
	End If

	/*------------------------------------------------------------------*/
	/* #1 ADR_1 + ADR_2 <= 30                                           */
	/*------------------------------------------------------------------*/
	lLen = Len ( Trim ( idw_TrtClient.GetItemString ( 1, "ADR_LIVR1" ) ) )	+ &
			 Len ( Trim ( idw_TrtClient.GetItemString ( 1, "ADR_LIVR2" ) ) )
	// -1 pour le s$$HEX1$$e900$$ENDHEX$$parateur
	If lLen > 30 - 1 Then
		stMessage.sCode = "COMD042"
		sPos = "ADR_LIVR1" 
	End If

	/*------------------------------------------------------------------*/
	/* #1 ADR_VILLE <= 25                                               */
	/*------------------------------------------------------------------*/
	lLen = Len ( Trim ( idw_TrtClient.GetItemString ( 1, "ADR_VILLE" ) ) )
	If lLen > 25 Then
		stMessage.sCode = "COMD043"
		sPos = "ADR_VILLE" 
	End If

/*------------------------------------------------------------------*/
/* #3	CAG 25/11/2003																  */
/*------------------------------------------------------------------*/
If sPos <> "" Then
	uf_GestionBoutons ( 3, "", False )

	F_Message ( stMessage )
End If

Return sPos

end function

private subroutine uf_controlersaisie_commune (ref string aspos);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande2::uf_ControlerSaisie_Commune (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 25/08/2003 16:34:05
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: DCMP 030362 Contr$$HEX1$$f400$$ENDHEX$$le des communes.
//* Commentaires  : 
//*
//* Arguments     : String		r$$HEX1$$e900$$ENDHEX$$f		asPos
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF	  08/10/2003  Le fichier INSEE.TXT ne contien que les 25 premiers 
//*								  caract$$HEX1$$e800$$ENDHEX$$res de la ville.
//* #2	 JFF	  27/01/2004  DCMP 030581 : On pr$$HEX1$$e900$$ENDHEX$$voit un shunt pour le contr$$HEX1$$f400$$ENDHEX$$le des communes.
//* #3	 PHG	  17/06/2006  [DCMP060445] : Unification Sherpa/simpa Controle des communes
//*								  R$$HEX2$$e900e900$$ENDHEX$$criture de la fonction.
//*
//*-----------------------------------------------------------------

Long 			lCptAdr, lDeb, lFin
String 		sVille, sCP, sMes, sPosCP, sPosVille

If asPos <> "" Or Not ibAltCommune Then Return

/*------------------------------------------------------------------*/
/* #2 : OPTION 16 : Si Option, on d$$HEX1$$e900$$ENDHEX$$connecte tout le contr$$HEX1$$f400$$ENDHEX$$le des   */
/* communes                                                         */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 16 )
If lDeb > 0 Then Return


For lCptAdr = 1 To 1
	
	/*------------------------------------------------------------------*/
	/* Cas de l'adresse de Livraison et de facturation	                 */
	/*------------------------------------------------------------------*/
	Choose Case lCptAdr
		Case 1 // Livraison
			sCP	  	 = Upper ( Trim ( idw_TrtClient.GetItemString ( 1, "ADR_CP" )	) ) 
			sVille  	 = Upper ( Trim ( idw_TrtClient.GetItemString ( 1, "ADR_VILLE" )	 ) )
			sMes		 ="livraison"
			sPosCP	 = "ADR_CP"
			sPosVille = "ADR_VILLE"

		Case 2 // Facturation
			sCP	  	 = Upper ( Trim ( idw_TrtClient.GetItemString ( 1, "ADRFC_CP" )	) ) 
			sVille    = Upper ( Trim ( idw_TrtClient.GetItemString ( 1, "ADRFC_VILLE" ) ) )	
			sMes		 ="facturation"
			sPosCP	 = "ADRFC_CP"
			sPosVille = "ADRFC_VILLE"

	End Choose 
	
	if Not stglb.uocommune.uf_verif_cp_ville( sCP, sVille) then
		if Not stglb.uocommune.uf_checkcp( sCP) then
			/*------------------------------------------------------------------*/
			/* Le CP n'existe pas					                                */
			/*------------------------------------------------------------------*/
			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie d'un interlocuteur (Communes)"
			stMessage.Bouton		= Ok!
			stMessage.Icon			= Information!
			stMessage.sVar[1]		= sMes
			stMessage.bErreurG	= TRUE
			stMessage.sCode		= "COMM06"
			f_Message ( stMessage )
			asPos = sPosCP
		else
			/*------------------------------------------------------------------*/
			/* La commune n'existe pas                                          */
			/*------------------------------------------------------------------*/
			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie d'un interlocuteur (Communes)"
			stMessage.Bouton		= Ok!
			stMessage.Icon			= Information!
			stMessage.sVar[1]		= sMes
			stMessage.bErreurG	= TRUE
			stMessage.sCode		= "COMM07"
			f_Message ( stMessage )
			asPos = sPosVille
		End If

	End If
	If asPos <> "" Then Exit
Next

end subroutine

private subroutine uf_controlersaisie_tacimei (ref string aspos);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande2::uf_ControlerSaisie_TacImei (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 02/09/2003 15:04:10
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le des TAC_IMEI
//* Commentaires  : 
//*
//* Arguments     : String		r$$HEX1$$e900$$ENDHEX$$f		asPos
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//			 JFF   18/03/2016  [SHUNT_GENE131]
//*-----------------------------------------------------------------

String	sTacImei
String	sMarqPort, sMarqTAC, sIdTypArt   
Long 		lTotTAC, lRow 

// JFF 31/03, n'est plus utilis$$HEX4$$e9002000e0002000$$ENDHEX$$cet endroit.
Return

If asPos <> "" Then Return

sTacImei = Left ( idw_TrtCmde.GetItemString ( 1, "ID_SERIE_ANC" )  , 6 )
sMarqPort = Upper ( idw_TrtCmde.GetItemString ( 1, "ID_MARQ_ART" ) )
sIdTypArt   = Upper ( idw_TrtCmde.GetItemString ( 1, "ID_TYP_ART" ) )

If sTacImei = "000000" Then Return
If sIdTypArt <> "PRS" Then Return

lTotTAC = idw_TacImei.RowCount ()

/*------------------------------------------------------------------*/
/* On ne fait le contr$$HEX1$$f400$$ENDHEX$$le de coh$$HEX1$$e900$$ENDHEX$$rence que si les deux zones sont   */
/* renseign$$HEX1$$e900$$ENDHEX$$es.                                                     */
/*------------------------------------------------------------------*/
If IsNull ( sMarqPort ) Or sMarqPort = "" Or IsNull ( sTacImei ) Or sTacImei = "" Then Return

lRow = idw_TacImei.Find ( "ID_TAC = " + sTacImei, 1, lTotTAC )

/*------------------------------------------------------------------*/
/* TAC Trouv$$HEX2$$e9002000$$ENDHEX$$dans la base.                                         */
/*------------------------------------------------------------------*/
If lRow > 0 Then
	sMarqTAC = Upper ( idw_TacImei.GetItemString ( lRow, "MARQUE" ) )

	/*------------------------------------------------------------------*/
	/* Mais le TAC ne correspond pas $$HEX2$$e0002000$$ENDHEX$$la Marque.                       */
	/*------------------------------------------------------------------*/
	If sMarqPort <> sMarqTac Then

		stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de validit$$HEX2$$e9002000$$ENDHEX$$du TAC IMEI"
		stMessage.Bouton		= Ok!
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.sVar[1]		= sTacImei
		stMessage.sVar[2]		= sMarqTac
		stMessage.sCode		= "GENE130"
		f_Message ( stMessage )
		asPos = "ID_SERIE_ANC"

	End If

End If






end subroutine

private function integer uf_zn_idserieanc (ref u_datawindow adw, string asdata, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande2::Uf_Zn_IdSerieAnc (PRIVATE)
//* Date				: 02/09/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Zone Id_Serie_Anc
//* Commentaires	: 
//*
//* Arguments		: aDw				DataWindow	Ref
//*					  asData			String		Val
//*					  alRow			String		Val
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF	   09/09/2003 Denis souhaite que les gestionnaire saississent
//*								  eux-m$$HEX1$$ea00$$ENDHEX$$me les quinze '0', et non pas que la saisie
//*								  soit assist$$HEX1$$e900$$ENDHEX$$e.
//* 
//*---------------------------------------------------------------

Int iRet
Long	lLen, lCpt
Boolean bQueDesZeros

iRet 		= 0

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
Return iRet

asData 	= Trim ( asData )
lLen 		= Len ( asData )
bQueDesZeros = True

For lCpt = 1 To lLen
	If Mid ( asData, lCpt, 1 ) <> "0" Then 
		bQueDesZeros = False
		Exit
	End If
Next

If bQueDesZeros Then 
	asData = Fill ( "0", 15 )
	aDw.SetItem ( alRow, "ID_SERIE_ANC", asData )
	iRet = 2
End If

Return iRet
end function

private function integer uf_zn_probleme (ref u_datawindow adw, string asdata, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande2::Uf_Zn_Probleme
//* Date				: 19/09/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Zone Choix
//* Commentaires	: 
//*
//* Arguments		: aDw				u_DataWindow	Val
//*					  asData			String		Val
//*					  alRow			String		Val
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	25/06/2010 	[20100625.FPI] Epuration de message
//*---------------------------------------------------------------

Int iRet
Long	lLen, lCpt

iRet = 0
lLen = Len ( asData )

/*------------------------------------------------------------------*/
/* Il ne doit pas y avoir de retour chariot.                        */
/*------------------------------------------------------------------*/
If Pos ( asData, Char ( 13 ), 1 ) > 0 Then iRet = 1
//[20100625.FPI] Epuration de message
If Pos ( asData, Char ( 11 ), 1 ) > 0 Then iRet = 1
If Pos ( asData, Char ( 10 ), 1 ) > 0 Then iRet = 1

Return iRet
end function

private subroutine uf_epuration_zonecommune (ref string asville, ref integer aicode);//*-----------------------------------------------------------------
//*
//* Fonction      : uf_gs_sp_sinistre::uf_Epuration_ZoneCommune ( PRIVATE )
//* Auteur        : Fabry JF
//* Date          : 12/09/2003 10:48:04
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Supprime tout ce qui est g$$HEX1$$ea00$$ENDHEX$$nant dans la chaine de 
//*					  la ville afin de ne garder que la ville.
//* Commentaires  : 
//*
//* Arguments     : String 	asVille 		aRef
//*					  Integer	aiCode		aRef	 1 : Pr$$HEX1$$e900$$ENDHEX$$sence d'un CEDEX, BP, etc 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------
String sVille, sCar, sMot, sMotSubst
String sTbMotCle []   // Mots Cl$$HEX4$$e9002000e0002000$$ENDHEX$$ne pas tenir Compte
Integer iTotMotCle, iCpt, iPos
Boolean bCarTrouve

sTbMotCle = { " BP", "CEDEX", "C$$HEX1$$c900$$ENDHEX$$DEX", "CED$$HEX1$$c900$$ENDHEX$$X", "C$$HEX1$$c900$$ENDHEX$$D$$HEX1$$c900$$ENDHEX$$X" }
sVille = Upper ( asVille )
aiCode = 0

/*------------------------------------------------------------------*/
/* 1 : Suppression des mots cl$$HEX1$$e900$$ENDHEX$$s                                    */
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
/* 2 : Par la gauche, suppression de tout caract$$HEX1$$e800$$ENDHEX$$re non compris     */
/* entre 65 et 90 (ASCII).                                          */
/*------------------------------------------------------------------*/
bCarTrouve = TRUE
Do While bCarTrouve 
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
/* 3 : Par la Droite, suppression de tout caract$$HEX1$$e800$$ENDHEX$$re non compris     */
/* entre 65 et 90 (ASCII).                                          */
/*------------------------------------------------------------------*/
bCarTrouve = TRUE
Do While bCarTrouve 
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
/* 4 : Si _SAINT_ Ou _SAINTE_ trouv$$HEX2$$e9002000$$ENDHEX$$en d$$HEX1$$e900$$ENDHEX$$but de chaine remplacer   */
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
/* 5 : Si la ville est compos$$HEX1$$e900$$ENDHEX$$e, il ne doit y avoir qu'un espace 	  */
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

private subroutine uf_controlersaisie_cp (ref string aspos);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande2::uf_ControlerSaisie_CP (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 09/10/2003 16:34:05
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : String		r$$HEX1$$e900$$ENDHEX$$f		asPos
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF   23/05/2012   [PM103][1]
//		FPI	12/07/2012	[ITSM120934]
//*-----------------------------------------------------------------

Long 			lTotRow, lCpt, lCptAdr, lDeb, lFin
String 		sVille, sCP, sPosCP, sDept, sIdCodeCar, sValCar, sIdTypArt, sAdrCp, sAdrVille
Boolean		bAutorise
Int 			i
n_cst_string lnvPFCString

If asPos <> "" Then Return

bAutorise=TRUE // [ITSM120934]

// on recherche si l'option 8 est param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$e pour le produit
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 8 )

if lDeb > 0 then
	
	For i = lDeb To lFin
		// type d'artivle param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$
		sIdCodeCar = idw_DetPro.object.id_code_car[i]
		// mot cl$$HEX2$$e9002000$$ENDHEX$$autorisant les DOM-TOM et l'ETRANGER
		sValCar	=	lnvPFCString.of_getkeyvalue ( idw_DetPro.object.val_car[i], 'TERR', ';' )
		
		// si le type d'article param$$HEX1$$e900$$ENDHEX$$tr$$HEX2$$e9002000$$ENDHEX$$est le m$$HEX1$$ea00$$ENDHEX$$me que celui pour la commande en cours
		if sIdCodeCar = sIdTypArt then
		
			if sAdrCp = '00000' then

				// si la chaine contient la sous chaine '[ETRANGER]'
				if Pos ( sValCar, '[ETRANGER]' ) = 0  then
					bAutorise = false // on REFUSE la prestation
					exit
				end if
				
			elseif left ( sAdrCp, 2 ) = '98' or left ( sAdrCp, 2 ) = '97' then
				
				// si la chaine contient la sous chaine '[DOM-TOM]' ou  si la ville est MONACO
				if Pos ( sValCar, '[DOM-TOM]' ) = 0 and upper(sAdrVille) <> 'MONACO' then
					bAutorise = false // on REFUSE la prestation
					stMessage.sVar[1] = "des DOM-TOM"
					exit
				end if

			end if
			
		end if
		
	next
	
else
	// si l'option n'est pas param$$HEX1$$e900$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$e et que l'on a un CP ETRANGER OU DOM-TOM
	if sAdrCp = '00000' then
		bAutorise = false // on REFUSE la prestation
		stMessage.sVar[1] = "$$HEX1$$e900$$ENDHEX$$trangers"
	end if
		
	if ( left ( sAdrCp, 2 ) = '98' or left ( sAdrCp, 2 ) = '97' ) and & 
				upper(sAdrVille) <> 'MONACO' then
		bAutorise = false // on REFUSE la prestation
		stMessage.sVar[1] = "des DOM-TOM"			
	end if
end if

if bAutorise = false And asPos = "" then
	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le d'autorisation"
	stMessage.Bouton		= Ok!
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "GENE155"
	f_Message ( stMessage )
	asPos = 'ADR_CP'
End IF

/*
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 8 )

/*------------------------------------------------------------------*/
/* Si l'option n'est pas pr$$HEX1$$e900$$ENDHEX$$sente, on sort de ce contr$$HEX1$$f400$$ENDHEX$$le.          */
/* On ne contr$$HEX1$$f400$$ENDHEX$$le que si l'option 8 est pr$$HEX1$$e900$$ENDHEX$$sente dans DET_PRO       */
/*------------------------------------------------------------------*/
If lDeb <= 0 Then Return

// [PM103][1]
For lCptAdr = 1 To 1
	
	/*------------------------------------------------------------------*/
	/* Cas de l'adresse de Livraison et de facturation	                 */
	/*------------------------------------------------------------------*/
	Choose Case lCptAdr
		Case 1 // Livraison
			sCP	  	 = Upper ( Trim ( idw_TrtClient.GetItemString ( 1, "ADR_CP" ) ) ) 
			sPosCP	 = "ADR_CP"

 // [PM103][1]
//		Case 2 // Facturation
//			sCP	  	 = Upper ( Trim ( idw_TrtClient.GetItemString ( 1, "ADRFC_CP" ) ) ) 
//			sPosCP	 = "ADRFC_CP"


	End Choose 

	If sCP = "00000" Then

		stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie des CP"
		stMessage.Bouton		= Ok!
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "COMM08"
		f_Message ( stMessage )
		asPos = sPosCP	 

	End If

	If asPos <> "" Then Exit
Next
*/









end subroutine

public subroutine uf_gestionboutons (integer ainumpg, string asbouton, boolean abposdef);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_W_Commande2::uf_GestionBoutons
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 19/05/2003 15:50:00
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: DCMP 030207 : Ajout de 6 zones en retour de Cetelec (pour Cegetel Must)
//* Commentaires  : => ajout d'une dw suppl$$HEX1$$e900$$ENDHEX$$mentaire => modif gestion des boutons prec et suiv
//*
//* Arguments     : ( Val )	Integer	aiNumPg	:	indique la page sur laquelle on se positionne (0 si c'est par appui de bouton)
//*					  ( Val )	String	asBouton	:	indique le bouton sur lequel on a appuy$$HEX2$$e9002000$$ENDHEX$$(vide si on se positionne sur une pg pr$$HEX1$$e900$$ENDHEX$$cise)
//*					  ( Val )	Boolean	abPosDef	:	indique si l'on doit se positionner sur la 1$$HEX1$$e800$$ENDHEX$$re zone modifiable par d$$HEX1$$e900$$ENDHEX$$faut
//*
//* Retourne      : Aucun
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//* #1	 CAG	 26/05/2003	  Ajout des boutons premier et dernier
//* #2	 CAG	 25/11/2003	  Ajout d'un param$$HEX1$$e800$$ENDHEX$$tre : num$$HEX1$$e900$$ENDHEX$$ro de pg
//* #3	 JFF	 20/10/2008	  [FNAC_PROD_ECH_TECH]
//        JFF   13/01/2014   [PM246]
//*-----------------------------------------------------------------


Integer	iPgPrec

/*------------------------------------------------------------------*/
/* #2 CAG 25/11/2003															     */
/*------------------------------------------------------------------*/
If aiNumPg = iiCptPgCte Then Return

iPgPrec = iiCptPgCte
If aiNumPg = 0 Then
	Choose Case asBouton
		Case "SUIV"
			iiCptPgCte ++
		Case "PREC"
			iiCptPgCte --
		Case "PREM"
			iiCptPgCte = 1
		Case "DERN"
			iiCptPgCte = iiNbMaxPg
	End Choose
Else
	iiCptPgCte = aiNumPg
End If

If idwPg [ iPgPrec ].AcceptText () < 0 Then Return

idwPg [ iPgPrec ].Hide ()
idwPg [ iiCptPgCte ].Show ()

// Bouton visible sur 3$$HEX1$$e800$$ENDHEX$$me page (Coord. Inter)
icbComLiv.Visible = iiCptPgCte = 3
//icbComFac.Visible = icbComLiv.Visible 
icbComLiv.BringToTop = icbComLiv.Visible 
//icbComFac.BringToTop = icbComLiv.Visible 

// [PM246]
// [PM246]
icbModifAdr.Visible = iiCptPgCte = 3
icbModifAdr.BringToTop = icbComLiv.Visible 

//* #3 [FNAC_PROD_ECH_TECH]
/*
icbIMEI.Visible = iiCptPgCte = 1
icbIMEI.BringToTop = icbIMEI.Visible
*/

Choose Case iiCptPgCte
	Case 1
		icbPrec.Enabled = False
		icbSuiv.Enabled = True
		icbPrem.Enabled = False
		icbDern.Enabled = True
	Case iiNbMaxPg
		icbPrec.Enabled = True
		icbSuiv.Enabled = False
		icbPrem.Enabled = True
		icbDern.Enabled = False
	Case Else
		icbPrec.Enabled = True
		icbSuiv.Enabled = True
		icbPrem.Enabled = True
		icbDern.Enabled = True
End Choose

// Mise $$HEX2$$e0002000$$ENDHEX$$jour de l'affichage du compteur
istAffPgCmd.Text = "page " + String ( iiCptPgCte ) + " / " + String ( iiNbMaxPg )

If abPosDef Then
	If isPgCol [ iiCptPgCte ] <> "" Then
		idwPg [ iiCptPgCte ].SetColumn ( isPgCol [ iiCptPgCte ] )
	End If
	idwPg [ iiCptPgCte ].SetFocus ()
End If

end subroutine

private function string uf_controlergestion_darty ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande2::Uf_ControlerGestion_Darty (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 17/11/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler Sp$$HEX1$$e900$$ENDHEX$$cifique pour DARTY
//* Commentaires	: La zone probl$$HEX1$$e800$$ENDHEX$$me pour DARTY doit au moins contenir un chiffre.
//*					  Ce chiffre est fix$$HEX2$$e9002000$$ENDHEX$$par la machine pour l'ordre du choix.
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String sPos, sProbleme

sPos = ""

If Upper ( idw_TrtCmde.GetItemString ( 1, "ID_TYP_ART" ) ) <> "TEL" Then
	Return sPos
End If 

sProbleme = idw_TrtCmde.GetItemString ( 1, "PROBLEME" )

If Not IsNumber ( sProbleme ) Or sProbleme = "" Or IsNull ( sProbleme ) Then
		stMessage.sCode = "COMD065"		
		F_Message ( stMessage )
		Return "PROBLEME"
End If

Return sPos

end function

private subroutine uf_gestionzone_infospbfrn ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_Commande2::uf_GestionZone_InfoSpbFrn (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 30/06/2004 14:58:44
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Gestion de la zone Info_Spb_Frn
//* Commentaires  : DCMP 040206
//*					  $$HEX2$$e0002000$$ENDHEX$$Partir du code ($$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment de la liste), il faut retrouver le code la liste,
//*					  le label $$HEX2$$e0002000$$ENDHEX$$placer devant la zone
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//* 		FPI	22/07/2010	[PC321] Filtre sur la liste car saisissable
//*-----------------------------------------------------------------

Long	lIdCodeElt, lIdListe
DataWindowChild dwChild
String sLabel

lIdCodeElt = idw_TrtCmde.GetItemNumber ( 1, "INFO_SPB_FRN" )

If IsNull ( lIdCodeElt ) Then return

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$termine le code de la liste correspondante.                 */
/*------------------------------------------------------------------*/
lIdListe = ( Int ( lIdCodeElt / 100 ) ) * 100

idw_TrtCmde.GetChild ( "INFO_SPB_FRN", dwChild )

dwChild.SetFilter ( "ID_CODE = " + String ( lIdListe + 1 ) )
dwChild.Filter ()

If dwChild.RowCount () <> 1 Then 
	dwChild.SetFilter( "" ) 
	dwChild.Filter() 
	Return
End If

/*------------------------------------------------------------------*/
/* Mise $$HEX2$$e0002000$$ENDHEX$$jour de label.                                            */
/*------------------------------------------------------------------*/
sLabel = dwChild.GetItemString ( 1, "LIB_CODE" )
sLabel  = F_Remplace ( sLabel , "'", "~~'" )

idw_TrtCmde.Modify ( "info_spb_frn_t.text = '" + sLabel  + "'" )

//dwChild.SetFilter( "" ) 
dwChild.SetFilter ( "ID_CODE > " + String ( lIdListe + 1 ) + " and ID_CODE <" + String ( lIdListe + 99 )) // [PC321]
dwChild.Filter() 

// [PC321]
ilIdProcess = idw_trtcmde.GetItemnumber( 1, "INFO_SPB_FRN")

end subroutine

public function long uf_controlerzone (string asdw, string asnomcol, string asdata);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::Uf_ControlerZone (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 06/09/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controle de zones
//* Commentaires	: 
//*
//* Arguments		: asDw			String		Val
//*					  asNomcol		String		Val
//*					  asData			String		Val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Int	iRet
u_DataWindow dw
String sVal, sHoraire, sHoraireDeb, sHoraireFin
Date dJourRdv
Long lLigHoraire
DataWindowChild	dwChild

iRet = 0

CHOOSE CASE Upper ( asDw )
	
	Case  "DW_1"
		
		dw = idw_TrtCmde

		CHOOSE CASE Upper ( asNomCol )

			CASE "HRDV_CLI_MIN", "HRDV_CLI_MAX"

				sVal = This.uf_Formatage_Heure ( asData )

				If sVal = "-1" Then 
					iRet = 1
				Else
					iRet = 2
					idw_TrtCmde.SetItem ( 1, asNomCol, sVal )
				End If

			CASE "PROBLEME"
				iRet = This.uf_Zn_Probleme ( dw, asData, 1 )

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
			Case"ID_CHOIX_HORAIRE"
				dw.GetChild ( "ID_CHOIX_HORAIRE", dwChild )
				lLigHoraire = dwChild.GetRow ()
				sHoraire		= dwChild.GetItemString ( lLigHoraire, "HORAIRE" )
				sHoraireDeb	= Left ( sHoraire, 2 ) + Mid ( sHoraire, 4, 2 )
				sHoraireFin	= Mid ( sHoraire, 7, 2 ) + Right ( sHoraire, 2 )
		
				dw.SetItem ( 1, "HRDV_CLI_MIN", sHoraireDeb )
				dw.SetItem ( 1, "HRDV_CLI_MAX", sHoraireFin )

				dJourRdv		= dwChild.GetItemDate ( lLigHoraire, "JOUR" )
				dw.SetItem ( 1, "DTE_RDV_CLI", dJourRdv )

			Case "ID_SERIE_ANC"
				iRet = This.Uf_Zn_IdSerieAnc ( dw, asData, 1 )

			// [PC321]
			Case "INFO_SPB_FRN"
				iRet = This.Uf_Zn_InfoSpbFrn ( dw, asData, 1 )
			// :[PC321]
			
		END CHOOSE

	Case "DW_CLIENT"

		dw = idw_TrtClient

		CHOOSE CASE Upper ( asNomCol )

			CASE "ADR_CP"
				sVal = This.uf_Formatage_CP ( asData )
	
				If sVal = "-1" Then 
					iRet = 1
				End If


			CASE "ADR_TEL1", "ADR_TEL2", "ADR_TEL3"

				sVal = This.uf_Formatage_Tel ( asData, TRUE )
				If sVal = "-1" Then 
					iRet = 1
				Else
					iRet = 2
					idw_TrtCmde.SetItem ( 1, asNomCol, sVal )
				End If


			CASE "ADR_MAIL"

				sVal = This.uf_Formatage_eMail ( asData )
	
				If sVal = "-1" Then 
					iRet = 1
				Else
					iRet = 2
					idw_TrtCmde.SetItem ( 1, asNomCol, sVal )
				End If

			CASE "ADR_COD_CIV"
				
				iRet = This.uf_Zn_AdrCodCiv ( dw, asData, 1 ) // [PM452-1]

				

		END CHOOSE

END CHOOSE
//Migration PB8-WYNIWYG-03/2006 FM
//dw.SetActionCode ( iRet )
Return iRet
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

public function long uf_gerermessage (string asdw);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::Uf_GererMessage (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 06/09/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion Msg d'erreurs
//* Commentaires	: 
//*
//* Arguments		: asDw		String		Val
//*					  
//*					  
//*
//* Retourne		: String
//* [MIGPB8COR]	: Chang$$HEX2$$e9002000$$ENDHEX$$en Long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	22/07/2010	[PC321] Contr$$HEX1$$f400$$ENDHEX$$le de la zone info_spb_frn
//*-----------------------------------------------------------------

u_DataWindow Dw

stMessage.sTitre  	= "Controle de zone"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.bouton 		= Ok!

CHOOSE CASE Upper ( asDw )

	CASE "DW_1"
		dw = idw_TrtCmde

		CHOOSE CASE Upper ( dw.isErrCol )

			CASE "PROBLEME"
				stMessage.sCode = "COMD034"
				F_Message ( stMessage )

			CASE "INFO_SPB_FRN"
				stMessage.sCode = "COMD641"
				F_Message ( stMessage )

		End Choose

	CASE "DW_CLIENT"
		dw = idw_TrtClient

		CHOOSE CASE Upper ( dw.isErrCol )

			CASE "ADR_MAIL"
				stMessage.sCode = "COMD015"
				F_Message ( stMessage )

			CASE "ADR_CP"
				stMessage.sCode = "COMD016"
				F_Message ( stMessage )

			CASE "ADR_TEL1", "ADR_TEL2", "ADR_TEL3"
				stMessage.sCode = "COMD033"
				F_Message ( stMessage )
				
				
			Case "ADR_COD_CIV"

				Choose Case dw.iiErreur

					// [PM452-1]
					Case 0
						stMessage.sCode	= "WINT306"
						F_Message ( stMessage )
				End Choose 					

		END CHOOSE


END CHOOSE

dw.iiReset = 0 // [PC321] 0 ald 2
return dw.uf_Reinitialiser ( )
end function

public subroutine uf_majpec (long alidgti, long aliddetail);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_W_Commande2::uf_majpec (PUBLIC)
//* Auteur			: FABRY JF
//* Date				: 19/06/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Maj des donn$$HEX1$$e900$$ENDHEX$$es de PEC le cas $$HEX1$$e900$$ENDHEX$$ch$$HEX1$$e900$$ENDHEX$$ant
//* Commentaires	: [DCMP070163-070164-070248-070318] Gestion Prise en charge
//*
//* Arguments		: Long 		alIdGti		R$$HEX1$$e900$$ENDHEX$$f
//*					  Long 		alIdDetail	R$$HEX1$$e900$$ENDHEX$$f
//*
//* Retourne		: Integer
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   03/08/2009   [CAMARA].[PRESTA_WEB_BOUTIQUE]
//			FPI	17/03/2016	[SUPPR_PEC] Correction suppression de la PEC d'un d$$HEX1$$e900$$ENDHEX$$tail
//*-----------------------------------------------------------------

String sRech, sRechOrig
Long lRow, lRow2, lNbreCmde
Boolean	bTrouve 

bTrouve = FALSE

sRechOrig = "ID_GTI = " + String ( alIdGti ) + " AND ID_DETAIL = "  + String ( alIdDetail ) 

lRow = idw_LstCmde.Find ( sRechOrig + " AND COD_ETAT = 'CNV'", 1, idw_LstCmde.Rowcount() ) 

//* #1 [CAMARA].[PRESTA_WEB_BOUTIQUE]
If lRow > 0 Then
	lNbreCmde = 1
	lRow2 = idw_LstCmde.Find ( sRechOrig + " AND COD_ETAT = 'CNV'", lRow + 1, idw_LstCmde.Rowcount() )
	
	If lRow2 > 0 And lRow2 > lRow Then
		lNbreCmde = 2
	End If
End If

If lNbreCmde > 1 Then
	stMessage.Icon			= Information!
	stMessage.Bouton		= Ok!
	stMessage.sVar [1]   = String ( alIdDetail )
	stMessage.sCode		= "WSIN591"				
	F_Message ( stMessage )
	Return		
End If 	
//* #1 [CAMARA].[PRESTA_WEB_BOUTIQUE]	

// Rechercher d'une PEC
sRech = sRechOrig + " AND UPPER ( NOM_ZONE ) = 'PEC' "

lRow = idw_DivDet.Find ( sRech, 1, idw_DivDet.RowCount () )
If lRow > 0 Then
	
	// [SUPPR_PEC]
	if idw_DivDet.GetItemNumber(lRow,"CPT_VALIDE") > 0 Then Return
	
	idw_DivDet.SetItem ( lRow, "VAL_CAR", "N" )
	bTrouve = TRUE
End If

// Rechercher d'un for$$HEX1$$e700$$ENDHEX$$age de PEC
sRech = sRechOrig + " AND UPPER ( NOM_ZONE ) = 'ALT_PEC' "

lRow = idw_DivDet.Find ( sRech, 1, idw_DivDet.RowCount () )
If lRow > 0 Then
	idw_DivDet.SetItem ( lRow, "VAL_CAR", "N" )
	bTrouve = TRUE	
End If

// Recherche d'un plafond syst$$HEX1$$e800$$ENDHEX$$me
sRech = sRechOrig + " AND UPPER ( NOM_ZONE ) = 'ALT_PLAF_PEC' "

lRow = idw_DivDet.Find ( sRech, 1, idw_DivDet.RowCount () )
If lRow > 0 Then
	idw_DivDet.SetItem ( lRow, "VAL_CAR", "N" )
	bTrouve = TRUE	
End If

// Recherche d'une date de prise en charge
sRech = sRechOrig + " AND UPPER ( NOM_ZONE ) = 'DTE_PEC' "

lRow = idw_DivDet.Find ( sRech, 1, idw_DivDet.RowCount () )
If lRow > 0 Then
	idw_DivDet.SetItem ( lRow, "VAL_DTE", stNul.dtm )	// [PI056].20190926
	bTrouve = TRUE	
End If

// Recherche d'une date de prise en charge
sRech = sRechOrig + " AND UPPER ( NOM_ZONE ) = 'MT_PEC' "

lRow = idw_DivDet.Find ( sRech, 1, idw_DivDet.RowCount () )
If lRow > 0 Then
	idw_DivDet.SetItem ( lRow, "VAL_MT", 0 )
	bTrouve = TRUE	
End If

// On averti si au moins une application
If bTrouve Then
	stMessage.Icon			= Information!
	stMessage.Bouton		= Ok!
	stMessage.sVar [1]   = String ( alIdDetail )
	stMessage.sCode		= "WSIN590"				
	F_Message ( stMessage )
End If


end subroutine

public function integer uf_bt_supprimer_cmd (ref long alidgti, ref long aliddetail);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_W_Commande2::uf_bt_Supprimer_Cmd (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 21/07/2002 09:31:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Traitement du CLICK sur le bouton SUPPRIMER de la fen$$HEX1$$ea00$$ENDHEX$$tre de COMMANDE2
//*
//* Arguments		: Long		alIdGti		R$$HEX1$$e900$$ENDHEX$$f
//*					  Long		alIdDetail	R$$HEX1$$e900$$ENDHEX$$f
//*
//* Retourne		: Integer
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 CAG	 30/01/2003	  Lors de la suppression d'une cmde alors
//*								  que le 1er d$$HEX1$$e900$$ENDHEX$$tail est $$HEX2$$e0002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$gler, msg emp$$HEX1$$ea00$$ENDHEX$$chant
//*								  la suppression
//* #2	JFF	 12/08/2003   Rendre impossible la suppression sui une seq sup$$HEX1$$e900$$ENDHEX$$rieure existe.
//* #3   JFF    04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//*  	   JFF	 13/04/2010   [WEBSIM2].[FRANCE]
//*      JFF    05/12/2011   [ITSM92864]
//*-----------------------------------------------------------------

Long lIdGti, lIdDetail, lTotDetail, lLig, lCodEtat, lTotCmd, lIdSeq, lRow, lDeb, lFin
String sRech
Integer iRet
Boolean bCarrefourGRTV
Decimal {2} dcMtPlaf

iRet = 1

/*------------------------------------------------------------------*/
/* #2																					  */
/*------------------------------------------------------------------*/
lTotCmd = idw_LstCmde.RowCount ()
lIdSeq  = idw_TrtCmde.GetItemNumber ( 1, "ID_SEQ" )

If idw_LstCmde.Find ( "ID_SEQ > " + String ( lIdSeq ), 1, lTotCmd ) > 0 Then
	stMessage.sTitre		= "Gestion SFR"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "SFRP016"

	F_Message ( stMessage )

	iRet = -1
	Return ( iRet )

End If

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si le d$$HEX1$$e900$$ENDHEX$$tail sur lequel la commande est pass$$HEX1$$e900$$ENDHEX$$e est    */
/* en cours de r$$HEX1$$e800$$ENDHEX$$glement. Si oui la suppression est interdite.      */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Je ne fais pas le test sur la zone CODE_TEL $$HEX2$$e0002000$$ENDHEX$$21, car ce cas     */
/* doit $$HEX1$$ea00$$ENDHEX$$tre toujours valable.                                      */
/*------------------------------------------------------------------*/

lIdGti		= idw_TrtCmde.GetItemNumber ( 1, "ID_GTI" )
lIdDetail	= idw_TrtCmde.GetItemNumber ( 1, "ID_DETAIL" )

lTotDetail	= idw_wDetail.RowCount ()
sRech			= "ID_GTI = " + String ( lIdGti ) + " And ID_DETAIL = " + String ( lIdDetail )

lLig			= idw_wDetail.Find ( sRech, 1, lTotDetail )
/*------------------------------------------------------------------*/
/* La ligne doit forc$$HEX1$$e900$$ENDHEX$$ment exister sinon c'est tr$$HEX1$$e800$$ENDHEX$$s tr$$HEX1$$e800$$ENDHEX$$s grave.     */
/*------------------------------------------------------------------*/
/* #1 : GetItemNumber sur lLig et non 1                             */
/*------------------------------------------------------------------*/
lCodEtat		= idw_wDetail.GetItemNumber ( lLig, "COD_ETAT" )
dcMtPlaf    = idw_wDetail.GetItemNumber ( lLig, "MT_PLAF" ) // [ITSM92864]

// [ITSM92864]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 152 )
bCarrefourGRTV = lDeb > 0

// [ITSM92864]
If	( lCodEtat = 500 Or lCodEtat = 600 ) And &
	Not ( bCarrefourGRTV And ( lCodEtat = 500 Or lCodEtat = 600 ) And dcMtPlaf = 0 ) &
	Then
	stMessage.sTitre		= "Gestion SFR"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "SFRP015"

	F_Message ( stMessage )

	iRet = -1
End If

// #3
alIdGti = lIdGti
alIdDetail = lIdDetail

// [WEBSIM2].[FRANCE]
If Upper ( idw_TrtCmde.GetItemString ( 1, "ID_FOUR" ) ) = "WBB" And iRet > 0 Then
	lRow = idw_wDivSin.Find ( "NOM_ZONE = 'mdp_net_boutique'", 1,  idw_WDivSin.RowCount () ) 
	If lRow > 0 Then
		idw_wDivSin.SetItem ( lRow, "VAL_CAR", stNul.Str )
	End If
End If
// [WEBSIM2].[FRANCE]


Return ( iRet )

end function

public function boolean uf_getautorisation (long aliddroit);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_command2::uf_GetAutorisation (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 20/06/2008 
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Lecture simple d'une autorisation
//* Commentaires  : [DCMP080479]
//*
//* Arguments     : Long	alDroit		Val
//*
//* Retourne      : Boolean  TRUE, on a le droit
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String sIdProd, sFindOrig, sFindOrig1

sIdProd = String ( idw_Produit.GetItemNumber ( 1, "ID_PROD" ) )

sFindOrig   = "ID_OPER = '" + Upper ( stGlb.sCodOper ) + "' AND " + &
				  "ID_NAT_OPER = " + String ( alIdDroit ) + " AND ID_PROD = " + sIdProd

sFindOrig1   = "ID_OPER = '" + Upper ( stGlb.sCodOper ) + "' AND " + &
				  "ID_NAT_OPER = " + String ( alIdDroit ) + " AND ID_PROD = -1"


Return idw_Autorisation.Find ( sFindOrig   , 1, idw_Autorisation.RowCount() )  > 0 Or &
	    idw_Autorisation.Find ( sFindOrig1  , 1, idw_Autorisation.RowCount() )  > 0


end function

private function integer uf_zn_infospbfrn (ref u_datawindow adw, string asdata, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande2::Uf_Zn_InfoSpbFrn (PRIVATE)
//* Date				: 16/07/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Zone Info_Spb_Frn
//* Commentaires	: [PC321]
//*
//* Arguments		: aDw				DataWindow	Ref
//*					  asData			String		Val
//*					  alRow			String		Val
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//			FPI		13/10/2014	[DT108] - ajout process 1421
//			FPI		14/10/2016	[PC151255]
//*---------------------------------------------------------------

Int iRet
Decimal dcPrixAchat
Long lRowDetail, lIdGti, lIdDetail, lDeb, lFin, lRow
String sMarqPort, sModlPort, sVal
n_cst_string nvString
Boolean bOk

iRet 		= 0

// Si prix d'achat <= 150$$HEX1$$ac20$$ENDHEX$$, suite $$HEX2$$e0002000$$ENDHEX$$un 1415, que 1425 ou 1430 autoris$$HEX1$$e900$$ENDHEX$$
lIdGti		= idw_TrtCmde.GetItemNumber ( 1, "ID_GTI" )
lIdDetail	= idw_TrtCmde.GetItemNumber ( 1, "ID_DETAIL" )

lRowDetail = idw_wDetail.Find ( "ID_GTI = " + String ( lIdGti ) + " And ID_DETAIL = " + String ( lIdDetail ), 1, idw_wDetail.RowCount () )

dcPrixAchat = idw_wdetail.GetItemDecimal(lRowDetail,"MT_VAL_ACHAT")

if dcPrixAchat <= 150 and ilIdProcess=1415 Then
	if asData = "1420" Then 	Return 1
End if

if ilIdProcess=0 Then ilIdProcess=idw_trtcmde.GetItemNumber(1,"INFO_SPB_FRN") // [PC151255]

Choose Case asData
	Case "1420","1430"
		Choose Case ilIdProcess
			Case 1420,1430,1415,1426, 1421 // [DT108] Ajout 1421
				// OK
			Case Else
				iRet=1
		End choose
	Case "1425"
			stmessage.stitre="Prestation(s)"
			stmessage.berreurg=FALSE
			stmessage.icon=Information!
			stmessage.scode="COMD651"
			stMessage.bouton=OK!
			f_message(stmessage)
	Case "1426"
			stmessage.stitre="Prestation(s)"
			stmessage.berreurg=FALSE
			stmessage.icon=Information!
			stmessage.scode="COMD652"
			stMessage.bouton=OK!
			f_message(stmessage)
	Case "1421" // [DT108]
			bOk=FALSE
			F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 265 )
			If lDeb > 0 Then
				sMarqPort = idw_trtCmde.getItemString( 1, "ID_MARQ_ART")
				sModlPort = idw_trtCmde.getItemString( 1, "ID_MODL_ART")
				
				For lRow=lDeb to lFin
					sVal=idw_DetPro.GetItemString(lRow, "VAL_CAR")
				
					If nvString.of_getkeyvalue( sVal, "MARQUE", ";")=sMarqPort Then
						sVal=nvString.of_getkeyvalue( sVal, "MODELES", ";")
						if Pos(sVal,"#" + sModlPort + "#") > 0 Then 
							bOk=True
							exit
						End if
					End if
					
				Next
				If not bOk then iRet=1
			End if
	// [PC151255]
	Case "2820"
		Choose Case ilIdProcess
			Case 2811,2830
				// OK
			Case Else
				iRet=1
		End choose
	Case Else
		iRet=1
End choose

Return iRet
end function

private function boolean uf_getautorisation (long aliddroit, string asidfour);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_command2::uf_GetAutorisation (PUBLIC)
//* Auteur        : FPI
//* Date          : 09/12/2010
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Lecture d'une autorisation avec VAL_CAR="ID_FOUR=..."
//* Commentaires  : [VDoc2280]
//*
//* Arguments     : Long	alDroit		Val
//*					     String asIdFour		Val
//*
//* Retourne      : Boolean  TRUE, on a le droit
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//    JFF   19/11/2012  [PC543][MANTIS5739]				
//*-----------------------------------------------------------------

String sIdProd, sFindOrig, sValCar 
n_cst_string lnvPFCString
Long lRow

sIdProd = String ( idw_Produit.GetItemNumber ( 1, "ID_PROD" ) )

sFindOrig   = "ID_OPER = '" + Upper ( stGlb.sCodOper ) + "' AND " + &
				  "ID_NAT_OPER = " + String ( alIdDroit ) + " AND (ID_PROD =" + sIdProd + " OR ID_PROD=-1) AND " + &
				  "(ISNULL(VAL_CAR) OR VAL_CAR ='-1' OR POS ( VAL_CAR, 'ID_FOUR=') > 0 )"

lRow = idw_Autorisation.Find ( sFindOrig, 1, idw_Autorisation.RowCount() )
				  
If alIdDroit = 213 And lRow > 0 Then
	sValCar = lnvPFCString.of_getkeyvalue (idw_Autorisation.GetItemString ( lRow, "VAL_CAR" ), "ID_FOUR", ";")
	If Not IsNull ( sValCar ) And Trim ( sValCar ) <> "-1" Then
		If Pos ( sValCar, "#" + Trim ( asidfour ) + "#" ) <= 0 Then
			lRow = 0
		End If			
	End IF
End If

Return lRow	> 0 			  
			  



end function

public function boolean uf_getautorisation_221 (long alidprocess);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande2::uf_GetAutorisation_221 (PUBLIC)
//* Auteur        : FPI
//* Date          : 07/10/2011
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Lecture de l'autorisation 221
//* Commentaires  : [VDoc5312]
//*
//* Arguments     : Long alIdProcess		Val
//*
//* Retourne      : Boolean  TRUE, on a le droit
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String sIdProd, sFindOrig

sIdProd = String ( idw_Produit.GetItemNumber ( 1, "ID_PROD" ) )

sFindOrig   = "ID_OPER = '" + Upper ( stGlb.sCodOper ) + "' AND " + &
				  "ID_NAT_OPER = 221 AND (ID_PROD =" + sIdProd + " OR ID_PROD=-1) AND " + &
				  "VAL_CAR LIKE '%/" + String(alidprocess) + "/%'"


Return idw_Autorisation.Find ( sFindOrig   , 1, idw_Autorisation.RowCount() )  > 0 


end function

public function datawindow uf_get_dwdetpro ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande2::uf_get_dwdetpro 
//* Auteur        : FPI
//* Date          : 23/05/2012
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: [PM103]
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Return idw_detpro
end function

public function long uf_get_idprod ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande2::uf_get_idprod 
//* Auteur        : FPI
//* Date          : 23/05/2012
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: [PM103]
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Return idw_Produit.GetItemNumber( 1,"ID_PROD")
end function

public subroutine uf_initialiser (ref s_pass astpass, ref commandbutton acbprec, ref commandbutton acbsuiv, ref commandbutton acbprem, ref commandbutton acbdern, ref commandbutton acbcomliv, ref commandbutton acbcomfac, ref commandbutton acbimei, ref statictext astaffpgcmd, commandbutton acbmodifadr);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::Uf_Initialiser (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 31/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Ref		s_Pass	astPass
//*					  ( R$$HEX1$$e900$$ENDHEX$$f )	CommandButton	acbPrec		:	bouton pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent de la fen$$HEX1$$ea00$$ENDHEX$$tre w_gs_sp_w_commande2
//*					  ( R$$HEX1$$e900$$ENDHEX$$f )	CommandButton	acbSuiv		:	bouton suivant de la fen$$HEX1$$ea00$$ENDHEX$$tre w_gs_sp_w_commande2
//*					  ( R$$HEX1$$e900$$ENDHEX$$f )	CommandButton	acbPrem		:	bouton premier de la fen$$HEX1$$ea00$$ENDHEX$$tre w_gs_sp_w_commande2
//*					  ( R$$HEX1$$e900$$ENDHEX$$f )	CommandButton	acbDern		:	bouton dernier de la fen$$HEX1$$ea00$$ENDHEX$$tre w_gs_sp_w_commande2
//*					  ( R$$HEX1$$e900$$ENDHEX$$f )	CommandButton	acbComLiv	:	bouton V$$HEX1$$e900$$ENDHEX$$rif Commune Adr. Livr.
//*					  ( R$$HEX1$$e900$$ENDHEX$$f )	CommandButton	acbComFac	:	bouton V$$HEX1$$e900$$ENDHEX$$rif Commune Adr. Fact.
//*					  ( R$$HEX1$$e900$$ENDHEX$$f )	CommandButton	acbIMEI		:	bouton R$$HEX1$$e900$$ENDHEX$$cup. IMEI Adh. Modifi$$HEX1$$e900$$ENDHEX$$
//*					  ( R$$HEX1$$e900$$ENDHEX$$f )	StaticText		astAffPgCmd	:	affichage de la page courante de la fen$$HEX1$$ea00$$ENDHEX$$tre w_gs_sp_w_commande2
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 
//* #1  CAG		07/05/03	DCMP 030207 : Ajout de 6 zones en retour de Cetelec (pour Cegetel Must)
//*								=> ajout d'une dw suppl$$HEX1$$e900$$ENDHEX$$mentaire => modif gestion des boutons prec et suiv
//* #2  CAG		26/05/03 Ajout des boutons premier et dernier
//* #3  CAG		03/06/03 Ajout de la zone ID_ANN = cat$$HEX1$$e900$$ENDHEX$$gorie d'annulation
//* #4  JFF		05/07/04 DCMP 040206
//* #5  JCA    08/06/2006		Suppression ADR_MAIL   
//* #6  JFF    04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #7  JFF    20/06/2008 [DCMP080479]
//*  	  JFF	   13/04/2010 [WEBSIM2].[FRANCE]
//* 	 FPI		15/07/2010	[PC321] Ajout de la saisie du process
//       JFF   13/01/2014 [PM246]
//*-----------------------------------------------------------------
DatawindowChild	dwChild, dwChild1
Long					lCpt, lIdProd

idw_TrtCmde = astPass.dwMaster
idw_TrtClient = astPass.dwMaster1
/*------------------------------------------------------------------*/
/* #1 : CAG 07/05/2003                                              */
/*------------------------------------------------------------------*/
idw_TrtCmde_Frn = astPass.udwTab [1]
icbPrec = acbPrec
icbSuiv = acbSuiv
/*------------------------------------------------------------------*/
/* #2 : CAG 26/05/2003                                              */
/*------------------------------------------------------------------*/
icbPrem = acbPrem
icbDern = acbDern
icbIMEI = acbIMEI
istAffPgCmd = astAffPgCmd

icbComLiv = acbComLiv
icbComFac = acbComFac

// [PM246]
icbModifAdr = acbModifAdr

ibAltCommune = astPass.bTab [1]

idw_LstCMde = astPass.dwTab [1]
idw_LstGti  = astPass.dwTab [2]
idw_DivDet  = astPass.dwTab [3]  // #6

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On ajoute la DW DW_WDETAIL afin de controler que le d$$HEX1$$e900$$ENDHEX$$tail       */
/* n'est pas A REGLER si l'on cherche $$HEX2$$e0002000$$ENDHEX$$supprimer la commande li$$HEX1$$e900$$ENDHEX$$e  */
/* $$HEX2$$e0002000$$ENDHEX$$ce d$$HEX1$$e900$$ENDHEX$$tail.                                                     */
/*------------------------------------------------------------------*/
idw_wDetail	= astPass.dwNorm [ 1 ]

/*------------------------------------------------------------------*/
/* #3 : CAG 03/06/2003                                              */
/*------------------------------------------------------------------*/
idw_AnnCmde  = astPass.dwNorm [2]
idw_Commune  = astPass.dwNorm [6]
idw_TacImei  = astPass.dwNorm [7]
idw_autorisation = astPass.dwNorm [8] //* #7  [DCMP080479]
idw_wDivSin   = astPass.dwNorm [9] // [WEBSIM2].[FRANCE]

isTypeTrt	= astPass.sTab [2]

idw_TrtCmde.ShareData ( idw_Trtclient )
/*------------------------------------------------------------------*/
/* #1 : CAG 07/05/2003                                              */
/*------------------------------------------------------------------*/
idw_TrtCmde.ShareData ( idw_TrtCmde_Frn )

idw_LstCMde.GetChild ( "ID_TYP_ART", dwChild ) 
idw_TrtCmde.GetChild ( "ID_TYP_ART", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_LstCMde.GetChild ( "ID_FOUR", dwChild )
idw_TrtCmde.GetChild ( "ID_FOUR", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_LstCMde.GetChild ( "COD_ETAT", dwChild )
idw_TrtCmde.GetChild ( "COD_ETAT", dwChild1 )
dwChild.ShareData ( dwChild1 )
/*------------------------------------------------------------------*/
/* #1 : CAG 07/05/2003                                              */
/*------------------------------------------------------------------*/
idw_TrtCmde_Frn.GetChild ( "COD_ETAT", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_LstGti.GetChild ( "ID_GTI", dwChild )
idw_TrtCmde.GetChild ( "ID_GTI", dwChild1 )
dwChild.ShareData ( dwChild1 )
idw_TrtClient.GetChild ( "ID_GTI", dwChild1 )
dwChild.ShareData ( dwChild1 )
/*------------------------------------------------------------------*/
/* #1 : CAG 07/05/2003                                              */
/*------------------------------------------------------------------*/
idw_TrtCmde_Frn.GetChild ( "ID_GTI", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
idw_LstCmde.GetChild ( "ID_BSP", dwChild )
idw_TrtCmde.GetChild ( "ID_BSP", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_TrtClient.GetChild ( "ID_BSP", dwChild1 )
dwChild.ShareData ( dwChild1 )
/*------------------------------------------------------------------*/
/* #1 : CAG 07/05/2003                                              */
/*------------------------------------------------------------------*/
idw_TrtCmde_Frn.GetChild ( "ID_BSP", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 03/09/2002.                              */
/*------------------------------------------------------------------*/
idw_LstCmde.GetChild ( "ADR_COD_CIV", dwChild )
idw_TrtCmde.GetChild ( "ADR_COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_TrtClient.GetChild ( "ADR_COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )
idw_TrtClient.GetChild ( "ADRFC_COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_TrtCmde.GetChild ( "ID_CHOIX_HORAIRE", dwChild1 )
idw_HoraireRdv.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* #1 : CAG 07/05/2003                                              */
/*------------------------------------------------------------------*/
idw_TrtCmde_Frn.GetChild ( "STATUS_GC", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-GC" )

/*------------------------------------------------------------------*/
/* #3 : CAG 03/06/2003                                              */
/*------------------------------------------------------------------*/
idw_AnnCmde.GetChild ( "ID_ANN", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-CA" )
idw_TrtCmde.GetChild ( "ID_ANN", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* #4: 																				  */
/*------------------------------------------------------------------*/
idw_TrtCmde.GetChild ( "INFO_SPB_FRN", dwChild)
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-IF" )

/*------------------------------------------------------------------*/
/* Initialisation des champs dont la couleur changera en fonction   */
/* de la protection                                                 */
/*------------------------------------------------------------------*/

idw_TrtCmde.uf_InitialiserCouleur &
		( {		"DTE_RDV_CLI"			,&
				"HRDV_CLI_MIN"			,&
				"HRDV_CLI_MAX"			,&
				"ID_CHOIX_HORAIRE"	, &
				"INFO_SPB_FRN"			&
		} ) // [PC321] Ajout de "INFO_SPB_FRN" // [ITSM475226] Suppression de PROBLEME

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 10/09/2002.                              */
/*------------------------------------------------------------------*/
/* CAG : Ajout de la colonne ADR_COD_CIV                            */
/*------------------------------------------------------------------*/
// #5
idw_TrtClient.uf_InitialiserCouleur &
		( {	"ADR_COD_CIV"		,&
				"ADR_NOM"			,& 
				"ADR_PRENOM"		,& 
				"ADR_LIVR1" 		,&
				"ADR_LIVR2"			,&
				"ADR_LIVR_CPL"		,&
				"ADR_CP"				,&
				"ADR_VILLE"			,&
				"ADR_TEL1"			,&
				"ADR_TEL2"			,&
				"ADR_TEL3"			,&
				"ADRFC_COD_CIV"	,&
				"ADRFC_NOM"			,& 
				"ADRFC_PRENOM"		,& 
				"ADRFC_LIVR1" 		,&
				"ADRFC_LIVR2"		,&
				"ADRFC_LIVR_CPL"	,&
				"ADRFC_CP"			,&
				"ADRFC_VILLE"		&
		} )

/*------------------------------------------------------------------*/
/* #1 : CAG 19/05/2003                                              */
/*------------------------------------------------------------------*/
/* Initialisation du tableau des dw - pages, ainsi que des          */
/* colonnes qui recevront le focus sur activation de chaque page    */
/*------------------------------------------------------------------*/
For lCpt = 1 To iiNbMaxPg
	Choose Case lCpt
		Case 1
			idwPg [ lCpt ] = idw_TrtCmde
			isPgCol [ lCpt ] = "PROBLEME"
		Case 2
			idwPg [ lCpt ] = idw_TrtCmde_Frn
			isPgCol [ lCpt ] = ""
		Case 3
			idwPg [ lCpt ] = idw_TrtClient
			isPgCol [ lCpt ] = "ADR_COD_CIV"
	End Choose
Next

end subroutine

public function boolean uf_cmdeauto_dt57 (long adcidsin, long aiidseq);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::Uf_CmdeAuto_DT57 (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 13/02/2014
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [DT57_CMDE_IPHONE_SFR]
//* Commentaires	: Controle de Gestion
//*
//* Arguments		: adcIdSin, aiIdSeq
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Boolean bTrouve
String  sMarqueIfr, sModeleIfr, sIdRefFour, sInfoSpbFrnCplt 
Decimal {2} dcMtTTC
Long lSeqMax, lTot 
n_cst_string lnvPFCString

bTrouve = False

sMarqueIfr = idw_TrtCmde.GetItemString ( 1, "ID_MARQ_ART_IFR" )
sModeleIfr = idw_TrtCmde.GetItemString ( 1, "ID_MODL_ART_IFR" )
sIdRefFour = Fill ( "", 20 )

SQLCA.PS_S_RECH_ART_NEUF ( sMarqueIfr, sModeleIfr, dcMtTTC, sIdRefFour ) 

If Not IsNull ( sIdRefFour ) And Trim ( sIdRefFour ) <> "" Then
	bTrouve = TRUE

	lSeqMax = Long ( idw_LstCmde.Describe ( "Evaluate ( 'max (id_seq)', 0 )") )
	lSeqMax ++
	
	lTot = idw_LstCmde.Rowcount () + 1
	
	idw_LstCmde.RowsCopy ( 1, 1, Primary!, idw_LstCmde, lTot, Primary! )				
	
	idw_LstCmde.SetItem ( lTot, "ID_SEQ", lSeqMax )
	idw_LstCmde.SetItem ( lTot, "MT_TTC_CMDE", dcMtTTC )
	idw_LstCmde.SetItem ( lTot, "ID_REF_FOUR", sIdRefFour )
	idw_LstCmde.SetItem ( lTot, "CPT_VALIDE", 0 )
	idw_LstCmde.SetItem ( lTot, "COD_ETAT", "CNV" )
	idw_LstCmde.SetItem ( lTot, "STATUS_GC", 0 )
	idw_LstCmde.SetItem ( lTot, "ID_CMD_FRN", stNul.str)
	idw_LstCmde.SetItem ( lTot, "ID_SERIE_NOUV", stNul.str)
	idw_LstCmde.SetItem ( lTot, "ID_BON_TRANSP", stNul.str)
	idw_LstCmde.SetItem ( lTot, "DTE_RCP_FRN", stNul.dtm)
	idw_LstCmde.SetItem ( lTot, "DTE_ENV_CLI", stNul.dtm)
	idw_LstCmde.SetItem ( lTot, "CREE_LE", DateTime ( Today(), Now()) )
	idw_LstCmde.SetItem ( lTot, "MAJ_LE", DateTime ( Today(), Now()) )
	idw_LstCmde.SetItem ( lTot, "MAJ_PAR", stGlb.sCodOper )
	idw_LstCmde.SetItem ( lTot, "INFO_SPB_FRN_CPLT", "" )
	
End If

Return bTrouve 
end function

public function integer uf_zn_adrcodciv (datawindow adw, string asdata, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande2::Uf_Zn_AdrCodCiv (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 12/11/2018
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Zone Cod_civ
//* Commentaires	: [PM452-1]
//*
//* Arguments		: aDw				DataWindow	Val
//*					  asData			String		Val
//*					  alRow			String		Val
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*---------------------------------------------------------------

Int iRet

iRet = 0

If asData = "3" Then
	iRet = 1
End If

Return iRet
end function

on n_cst_w_commande2.create
call super::create
end on

on n_cst_w_commande2.destroy
call super::destroy
end on

