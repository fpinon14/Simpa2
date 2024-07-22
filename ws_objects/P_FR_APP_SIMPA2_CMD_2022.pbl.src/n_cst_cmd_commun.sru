HA$PBExportHeader$n_cst_cmd_commun.sru
$PBExportComments$Objet Bibliotheque pour les fonctions communes pour la gestion des commandes.
forward
global type n_cst_cmd_commun from nonvisualobject
end type
end forward

global type n_cst_cmd_commun from nonvisualobject autoinstantiate
event info ( )
end type

forward prototypes
public subroutine uf_changer_lib_dw (ref datawindow adwtrtcmdfrn, long aiidprod, string asidfour, string astypart, string astypetrt)
public subroutine uf_getadresseo2mbase (long alidsin, string ascas, ref string asnomligne1, ref string asnomligne2, ref string asadrligne1, ref string asadrligne2, ref string ascp, ref string asville)
public subroutine uf_getadresseo2m_2 (string ascas, string asforcageidreffour, long alforcageprocess, string asforcagetypapp, string asforcagetypart, string asforcageetat, long alforcageidgti, string asforcagemodele, string asinfospbfrncplt, u_datawindow_detail adwcmdesin, u_datawindow adwwdivsin, datawindow adwdetpro, long alidprod, ref string asnomligne1, ref string asnomligne2, ref string asadrligne1, ref string asadrligne2, ref string ascp, ref string asville)
end prototypes

event info();//*-----------------------------------------------------------------
//*
//* Objet			: n_cst_cmd_commun
//* Evenement 		: info
//* Auteur			: Pierre-Henri Gillot
//* Date				: 05/12/2006 15:57:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Evenement vide, contient la documentation.
//*				  
//* Arguments		: 
//*
//* Retourne		: (none)
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

/*-----------

Objet destin$$HEX4$$e9002000e0002000$$ENDHEX$$recevoir toutes fonctions communes $$HEX2$$e0002000$$ENDHEX$$la fonctionalit$$HEX2$$e9002000$$ENDHEX$$"Gestion des Commandes"
pour l'instant de mani$$HEX1$$e800$$ENDHEX$$re relativement in$$HEX1$$e900$$ENDHEX$$dpendante par rapport $$HEX2$$e0002000$$ENDHEX$$l'interace et/ou aux objet de gestions.

Chaque fonction est autonome, toute r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence $$HEX2$$e0002000$$ENDHEX$$des objets ou des instances d'objets doivent
etre pass$$HEX1$$e900$$ENDHEX$$e aux fonctions de cet objet.

Pas de propri$$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$partag$$HEX1$$e900$$ENDHEX$$e dans cet objet.

--- Liste des Fonctions :

--  uf_changer_lib_dw : Permet de personaliser les static text des dw fournisseur.

-----------*/
end event

public subroutine uf_changer_lib_dw (ref datawindow adwtrtcmdfrn, long aiidprod, string asidfour, string astypart, string astypetrt);//*-----------------------------------------------------------------
//*
//* Fonction      : W_Sp_C_Commande2::wf_Changer_Lib_Dw
//* Auteur        : Catherine ABDMEZIEM
//*					  Transcription en UserObject : PHG
//* Date          : 20/05/2003 16:23:51
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Modification dynamique des statics text de la dw de 
//* Commentaires  : la valeur -1 pass$$HEX1$$e900$$ENDHEX$$e en param$$HEX1$$e800$$ENDHEX$$tre, signifie que l'on garde les textes initiaux
//*
//* Arguments     : ( Val )	Long 	   aiIdProd	:	Produit ou -1
//*					  ( Val )	String	asIdFour	:	Fournisseur ou "-1"
//*					  ( Val )	String	asTypArt	:	Type d'article (PRS ou TEL) ou "-1"
//*					  ( Val )   String   asTypeTrt:  Type de traitement (S)aisie/(C)Consultation/(V)alidation
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #..  ...   ../../....
//*
//* #1	CAG	21/09/2004	DCMP 040381 : Ajout du frn MSS
//* #2	CAG	23/09/2004	DCMP 040403 : Ajout des colonnes dte_emis_devis et mt_devis pour SBE
//* #3	MADM	06/02/2006	[DCMP060119]: Ajout du frn AVM
//* #4	MADM	09/05/2006	[DCMP060356]: Rempl du frn AVM par CORDON/COR
//* #5	PHG	09/10/2006  DCMP060670]: Modification de MT_DEVIS_T pour ANV, SBE, COR, MSS
//* #6	PHG	05/12/2006  			  : Urbanisation : Unification de fonction.
//*												 - Ce script a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$import$$HEX2$$e9002000$$ENDHEX$$et unifi$$HEX2$$e9002000$$ENDHEX$$de :
//*											 		W_Sp_C_Commande2::wf_Changer_Lib_Dw
//*											 		N_Cst_W_Commande2::uf_Changer_Lib_Dw
//* #7	JFF   18/12/2006  [DCMP060911] Modification de libell$$HEX2$$e9002000$$ENDHEX$$en fct des diff$$HEX1$$e900$$ENDHEX$$rent cas.
//* #8	JFF   23/01/2007  Modif demand$$HEX2$$e9002000$$ENDHEX$$par MGA
//* #9	PHG	03/12/2007	[O2M]
//* #10  JFF   26/03/2008  [SURCOUF_ECH_EXPRESS]
//* #11	PHG	24/04/2008	[DCMP080199] Ajout Zone "Nom Transporteur"
//* #12  JFF   05/09/2008  [MICROMANIA]
//* #13  JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
//* #14  JFF   16/04/2009 [DCMP090102]
//* #15  JFF   16/04/2009 [DCMP090140]
//* #16  JFF   10/06/2009 [RUEDUCOMMERCE]
//* #17  JFF   01/09/2009 [20090901090248010]
//* #18  JFF   02/09/2009 [DCMP090327].[SBETV]
//* #19  JFF   14/09/2009 [20090914175511700]
//* #20  JFF   20/09/2009 [20090916095232187]
//* #21  JFF   15/10/2009 [DCMP090421]
//* #22  JFF   16/11/2009 [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
//* #23  JFF   25/11/2009 [MSS_DIAG]
//* #24  JFF   15/01/2010 [O2M_DIAG_NOMADE].Lot2.JFF
//* #25  JFF   02/03/2010 [MSS_LOT2]
//*  	   JFF	13/04/2010 [WEBSIM2].[FRANCE]
//*      JFF   30/06/2010 [PC363_AUCHAN]
//*      JFF   29/07/2010 [PC321]
//*      JFF   07/03/2011 [VDOC3290]
//*      JFF   01/09/2011 [PC10][DIAG_NOMADE]
//*       JFF   19/09/2011   [PM82][LOT1]
//*       JFF   19/09/2011   [PM82][LOT2]
//*       JFF   21/11/2011   [PM95]
//*       JFF   05/01/2012   [RECUP_DONNEE_O2M]
//        JFF   24/01/2012   [CONFO][CUISINE]
// 		 JFF   13/02/2012   [PM200][PSM]
// 		 JFF   13/02/2012   [VDOC6449]
//        JFF   17/04/2012   [PM200][LOT2][DESOX]
//        JFF   23/05/2012   [PM103][1]
// 		 JFF   28/06/2012   [MANTIS3709][PM200][2]
//        JFF   30/08/2012   [VDOC8041]
//        JFF   11/09/2012   [PC662][POINT7]
// 		 FPI	 19/10/2012	  [PC884]
//        JFF   23/11/2012   [VDOC8945]
//        JFF   26/11/2012   [PC877]
//        JFF   04/02/2013   [PC662_VDOC9376_M6646]
//        JFF   07/05/2013   [PC938_ORANGE_V3]
//        JFF   07/05/2013   [VDOC9908]
//        JFF   07/05/2013   [PC929-1]
//        JFF   09/09/2013   [PM222-1]
//        JFF   11/10/2013   [VDOC12443]
//        JFF   30/12/2013   [PC13348&13408]
//        JFF   30/12/2013   [PM246]
//        JFF   07/05/2013   [DT081_EVOL_PRET_BRIS]
//        JFF   08/04/2014   [PM255]
//        JFF   07/05/2013   [PM250-1]
//        JFF   14/05/2014   [PC13274-2]
//        JFF   17/06/2014   [PM259-1]
//        JFF   25/11/2014   [PM251-2]
//        JFF   12/12/2014   [PC13321]
//        JFF   02/01/2015   [PC801_6_TAMET]
//        JFF   09/04/2015   [DT141]
//        JFF   20/07/2015   [DT150]
//        JFF   28/07/2015   [PM295-1]
//        JFF   29/02/2016   [DT191-1]
//        JFF   31/03/2016   [PM287-3]
//        JFF   08/04/2016   [PM287-2][MANTIS20212]
//        JFF   08/04/2016   [PM287-2][MANTIS20306]
//			 FPI	 08/04/2016	[DT176]
//			 FPI	 13/05/2016	[DT111]
//        JFF   17/05/2016 [PM280-2]
//        JFF   07/05/2013 [PM234-7]
//       JFF   11/10/2016 [DT076-2]
//       JFF   02/11/2016 [DT276]
//       JFF   21/11/2016 [DT280]
//       JFF   21/02/2107 [DT288]
//       JFF   06/11/2017 [PC171933]
//       JFF   07/02/2017 [VDOC25657]
//       JFF   22/02/2017 [VDOC25657]
// 		JFF   21/06/2018 [VDOC26276]
//		FPI	20/07/2018	[VDoc26518]
//       JFF   17/09/2018 [PM444-1]
//       JFF   01/10/2018 [PM445-1]
//       JFF   14/01/2019 [PC151379]
//       JFF   25/03/2019 [DT398]
//       JFF   02/09/2019 [DT424]
//       JFF   19/12/2022 [RS4093_EVOL_ELD]
//       JFF   06/04/2023 [PMO139_RS4926]
//       JFF   30/05/2023 [PMO89_RS4822]
//       JFF   07/03/2024 [HP252_276_HUB_PRESTA]
//*-----------------------------------------------------------------
String	sModif, sCodEtat, sInfoSpbFrnCplt, sInfoFrnSpbCplt
String   sTabRech [], sTabSubst [], sTabNull [], sRempl, sVal
Long     lStatusGc, lTot, lCpt, lAutorisation, lCptRempl
DateTime		dtDteEnvCli
n_cst_string lnvPFCString
Integer iPos
boolean bAppSwap, bFournHub 

lStatusGc = aDwTrtCmdFrn.GetItemNumber ( 1, "STATUS_GC" )  // #7
sCodEtat = aDwTrtCmdFrn.GetItemString ( 1, "COD_ETAT" )   // #7
dtDteEnvCli = aDwTrtCmdFrn.GetItemDateTime ( 1, "DTE_ENV_CLI" )
sInfoFrnSpbCplt = aDwTrtCmdFrn.GetItemString ( 1, "INFO_FRN_SPB_CPLT" )
bAppSwap = lnvPFCString.of_getkeyvalue (sInfoFrnSpbCplt, "APP_SWAP", ";") = "OUI"

bFournHub = FALSE
// [HP252_276_HUB_PRESTA]
If F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then
	bFournHub = SQLCA.PS_S01_CODE_CAR ( asIdFour, '-WP') > 0 
End If 



/*------------------------------------------------------------------*/
/* En cas de modif, modifier aussi w_sp_commande2.wf_Changer_lib_DW */
/*------------------------------------------------------------------*/

sModif = ""


/*------------------------------------------------------------------*/
/* Initialisation des libell$$HEX1$$e900$$ENDHEX$$s par d$$HEX1$$e900$$ENDHEX$$faut                           */
/*------------------------------------------------------------------*/
sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande fournisseur' "
sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez le fournisseur' "
sModif += "STATUS_GC_T.Text 		= 'Statut de la prestation' "
sModif += "ID_SERIE_NOUV_T.Text 	= 'N$$HEX2$$b0002000$$ENDHEX$$IMEI' "
sModif += "ID_BON_TRANSP_T.Text 	= 'Dernier N$$HEX2$$b0002000$$ENDHEX$$bon trans connu' "
sModif += "COMMENT_FRN_T.Text 	= 'Commentaire fournisseur' "
sModif += "DTE_RCP_BTE_CLI_T.Text= 'R$$HEX1$$e900$$ENDHEX$$cep. bo$$HEX1$$ee00$$ENDHEX$$te vide par le client' "
sModif += "DTE_DEP_BTE_CLI_T.Text= 'D$$HEX1$$e900$$ENDHEX$$p$$HEX1$$f400$$ENDHEX$$t bo$$HEX1$$ee00$$ENDHEX$$te pleine $$HEX2$$e0002000$$ENDHEX$$la poste par le client' "
sModif += "DTE_ELV_MOBILE_T.Text = 'Enl$$HEX1$$e800$$ENDHEX$$vement mobile $$HEX2$$e0002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$parer par transp.' "
sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception de l~~'appareil dans le CTR' "
sModif += "DTE_ENV_ST_T.Text 	   = 'Envoi mobile vers CTR agr$$HEX2$$e900e900$$ENDHEX$$' "
sModif += "DTE_EMIS_DEVIS_T.Text = 'Date du diagnostic par le CTR' "
sModif += "MT_DEVIS_T.Text 		= 'Montant du forfait de r$$HEX1$$e900$$ENDHEX$$paration HT' "
sModif += "ALT_DEV_ACP_T.Text 	= 'Devis accept$$HEX1$$e900$$ENDHEX$$' "
sModif += "DTE_DEV_ACP_T.Text 	= 'Prise de d$$HEX1$$e900$$ENDHEX$$cision sur le devis' "
sModif += "DTE_RET_LOGIS_T.Text 	= 'Retour de l~~'appareil du CTR vers le logisticien' "
sModif += "DTE_RET_PRET_MIN_T.Text = 'R$$HEX1$$e900$$ENDHEX$$cup pr$$HEX1$$e900$$ENDHEX$$vue kit pr$$HEX1$$ea00$$ENDHEX$$t + rest mob r$$HEX1$$e900$$ENDHEX$$par$$HEX2$$e9002000$$ENDHEX$$(min)' "
sModif += "DTE_RET_PRET_MAX_T.Text = 'R$$HEX1$$e900$$ENDHEX$$cup pr$$HEX1$$e900$$ENDHEX$$vue kit pr$$HEX1$$ea00$$ENDHEX$$t + rest mob r$$HEX1$$e900$$ENDHEX$$par$$HEX2$$e9002000$$ENDHEX$$(max)' "
sModif += "DTE_ENV_CLI_T.Text 	= 'Envoi du mobile (Nouv./R$$HEX1$$e900$$ENDHEX$$par$$HEX1$$e900$$ENDHEX$$) chez le client' "
sModif += "ID_ORIAN_MODELE_T.Text = '' "
sModif += "ADRFC_NOM_T.Text = '' " // #11 [CMP080199]
sModif += "DTE_RCP_MOB_CLI_T.Text= 'R$$HEX1$$e900$$ENDHEX$$ception du mobile (nouveau/r$$HEX1$$e900$$ENDHEX$$par$$HEX1$$e900$$ENDHEX$$) par le client' "

/*------------------------------------------------------------------*/
/* Ecriture sur la Dw des libell$$HEX1$$e900$$ENDHEX$$s par d$$HEX1$$e900$$ENDHEX$$faut pour tous             */
/* fournisseurs.                                                    */
/*------------------------------------------------------------------*/
aDwTrtCmdFrn.Modify ( sModif )
sModif = ""
 
// Pour tous les cas
sModif += "DTE_RCP_BTE_CLI_T.Text= '' " // #7
sModif += "DTE_DEP_BTE_CLI_T.Text= '' " // #7
sModif += "DTE_ELV_MOBILE_T.Text = '' " // #7
sModif += "DTE_ENV_ST_T.Text = '' "	// #7
sModif += "DTE_DEV_ACP_T.Text	= '' "
sModif += "DTE_RET_PRET_MIN_T.Text = '' "
sModif += "DTE_RET_PRET_MAX_T.Text = '' "
sModif += "ID_ORIAN_MODELE_T.Text 	= '' "

/*------------------------------------------------------------------*/
/* Variante si Prestation ou Commande.                              */
/*------------------------------------------------------------------*/
Choose Case asTypArt
	Case "PRS"
//		sModif += "STATUS_GC_T.Text 	= 'Etat de l~~'appareil' " // #7
		sModif += "DTE_RCP_MOB_CLI_T.Text= 'R$$HEX1$$e900$$ENDHEX$$ception de l~~'appareil r$$HEX1$$e900$$ENDHEX$$par$$HEX2$$e9002000$$ENDHEX$$par l~~'assur$$HEX1$$e900$$ENDHEX$$' "		

		sModif += "DTE_EMIS_DEVIS_T.Text = '' " // #7
		sModif += "MT_DEVIS_T.Text 		= '' " // #7				
		sModif += "ALT_DEV_ACP_T.Text 	= '' " // #7


		Choose Case True  // D#7
			Case lStatusGc = 2 And ( sCodEtat = "ECL" Or sCodEtat = "RPC" )
				sModif += "DTE_ENV_CLI_T.Text 	= 'Envoi de l~~'appareil r$$HEX1$$e900$$ENDHEX$$par$$HEX2$$e9002000$$ENDHEX$$chez l~~'assur$$HEX1$$e900$$ENDHEX$$'"
				sModif += "DTE_RCP_MOB_CLI_T.Text= 'R$$HEX1$$e900$$ENDHEX$$ception de l~~'appareil r$$HEX1$$e900$$ENDHEX$$par$$HEX2$$e9002000$$ENDHEX$$par l~~'assur$$HEX1$$e900$$ENDHEX$$' "

			Case lStatusGc = 21 And ( sCodEtat = "ECL" Or sCodEtat = "RPC" )
				sModif += "DTE_ENV_CLI_T.Text 	= 'Envoi de l~~'appareil irr$$HEX1$$e900$$ENDHEX$$parable chez l~~'assur$$HEX1$$e900$$ENDHEX$$'"
				sModif += "DTE_RCP_MOB_CLI_T.Text= 'R$$HEX1$$e900$$ENDHEX$$ception de l~~'appareil irr$$HEX1$$e900$$ENDHEX$$parable par l~~'assur$$HEX1$$e900$$ENDHEX$$' "

			Case lStatusGc = 21 And sCodEtat = "RSP" 
				sModif += "DTE_ENV_CLI_T.Text 	= 'Mis en stock de l~~'appareil irr$$HEX1$$e900$$ENDHEX$$parable'"
				sModif += "DTE_RCP_MOB_CLI_T.Text= '' "
	
		End Choose // D#7

		// #20  JFF   20/09/2009 [20090916095232187] On r$$HEX1$$e900$$ENDHEX$$active le code, pour tt type de trt 
		// #17 [20090901090248010] N'est plus n$$HEX1$$e900$$ENDHEX$$cessaire du fait que -GC/2 ait $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$renomm$$HEX1$$e900$$ENDHEX$$
//		If IsNull ( dtDteEnvCli ) And lStatusGc = 2 And asTypeTrt <> "S" Then 

	Case "TEL"
//		sModif += "STATUS_GC_T.Text 	= '' " // #7
		sModif += "DTE_RCP_FRN_T.Text 	= 'Traitement de la commande' " // #7
		sModif += "DTE_EMIS_DEVIS_T.Text = '' " // #7
		sModif += "MT_DEVIS_T.Text 		= '' " // #7		
		If asTypeTrt <> "S" Then aDwTrtCmdFrn.SetItem ( 1, "MT_DEVIS", "" )
		sModif += "ALT_DEV_ACP_T.Text 	= '' " // #7
		If asTypeTrt <> "S" Then aDwTrtCmdFrn.SetItem ( 1, "ALT_DEV_ACP", "" )		
		sModif += "DTE_RET_LOGIS_T.Text 	= '' " // #7
      sModif += "DTE_ENV_CLI_T.Text 	= 'Envoi de l~~'appareil neuf chez l~~'assur$$HEX1$$e900$$ENDHEX$$' "
		sModif += "DTE_RCP_MOB_CLI_T.Text= 'R$$HEX1$$e900$$ENDHEX$$ception du nouvel appareil par l~~'assur$$HEX1$$e900$$ENDHEX$$' "				

	Case Else	
		sModif += "DTE_EMIS_DEVIS_T.Text = '' " // #7
		sModif += "MT_DEVIS_T.Text 		= '' " // #7				
		sModif += "ALT_DEV_ACP_T.Text 	= '' " // #7

End Choose


// #11 Ajout JFF [DCMP080199]
// [DCMP090327].[SBETV]
// [MSS_DIAG]
// [BLCODE]
// [PC884]
Choose Case asIdFour 
	Case "O2M", "SB1", "MS1", "BLC","LBE"
		// On laisse tel quel
	Case Else
		aDwTrtCmdFrn.SetItem ( 1, "ADRFC_NOM", "" )  
End Choose
// :#11

aDwTrtCmdFrn.Modify ( sModif )
sModif = ""

/*------------------------------------------------------------------*/
/* En fonction du produit, certains libell$$HEX1$$e900$$ENDHEX$$s peuvent $$HEX1$$ea00$$ENDHEX$$tre modifi$$HEX1$$e900$$ENDHEX$$s. */
/*------------------------------------------------------------------*/
Choose Case aiIdProd
	Case -1
End Choose

/*----------------------------------------------------------------------*/
/* En fonction du Fournisseur, certains libell$$HEX1$$e900$$ENDHEX$$s peuvent $$HEX1$$ea00$$ENDHEX$$tre modifi$$HEX1$$e900$$ENDHEX$$s. */
/*----------------------------------------------------------------------*/
Choose Case asIdFour
	Case "ASF"

		Choose Case lStatusGc
			Case 3, 4, 5
				sModif += "DTE_EMIS_DEVIS_T.Text = 'Emission du devis pour le client' "
				sModif += "DTE_DEV_ACP_T.Text 	= 'Prise de d$$HEX1$$e900$$ENDHEX$$cision sur devis par le client' "
				sModif += "ALT_DEV_ACP_T.Text 	= 'Devis accept$$HEX2$$e9002000$$ENDHEX$$par le client' "
				sModif += "MT_DEVIS_T.Text 		= 'Montant du devis client, TTC' "
			Case 7, 8, 9
				sModif += "DTE_EMIS_DEVIS_T.Text = 'Emission du devis pour SPB' "
				sModif += "DTE_DEV_ACP_T.Text 	= 'Prise de d$$HEX1$$e900$$ENDHEX$$cision devis par SPB' "
				sModif += "ALT_DEV_ACP_T.Text 	= 'Devis accept$$HEX2$$e9002000$$ENDHEX$$par SPB' "
				sModif += "MT_DEVIS_T.Text 		= 'Montant devis SPB, TTC' "
			Case Else
		End Choose

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande ARVATO' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez ARVATO' "
		sModif += "STATUS_GC_T.Text 		= 'Statut de la commande' "
		sModif += "ID_SERIE_NOUV_T.Text 	= 'Nouvel IMEI' "
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire ARVATO' "
		sModif += "DTE_ELV_MOBILE_T.Text = 'Collecte mobile r$$HEX1$$e900$$ENDHEX$$alis$$HEX2$$e9002000$$ENDHEX$$le' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception du mobile par le CTR' "		
		sModif += "DTE_RET_LOGIS_T.Text 	= 'Retour mobile du CTR vers ARVATO' "
		sModif += "ID_ORIAN_MODELE_T.Text 	= '' "


	Case "CET"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande CETELEC' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez CETELEC' "

	Case "CEG"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande SFR' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez SFR' "
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire SFR' " // #7
		sModif += "DTE_RCP_FRN_T.Text 	= 'Traitement de la commande chez SFR' " // #7

/*
	Case "ANV"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande A-NOVO' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez A-NOVO' "

		sModif += "ID_SERIE_NOUV_T.Text 	= 'IMEI figurant sur le mobile re$$HEX1$$e700$$ENDHEX$$u par A-NOVO' "
		sModif += "COMMENT_FRN_T.Text 	= 'Nom CTR + Commentaire A-NOVO + Swap IMEI' "

		Choose Case asTypArt
			Case "PRS"
				sModif += "DTE_RCP_FRN_T.Text = 'R$$HEX1$$e900$$ENDHEX$$ception du mobile chez A-NOVO' "
			Case "TEL"
				sModif += "DTE_RCP_FRN_T.Text = 'R$$HEX1$$e900$$ENDHEX$$ception de la Cmde chez A-NOVO' "
		End Choose

		sModif += "DTE_ENV_ST_T.Text 	   = 'Envoi mobile par A-NOVO vers CTR agr$$HEX2$$e900e900$$ENDHEX$$' "		
		sModif += "ALT_DEV_ACP_T.Text 	= 'Devis accept$$HEX2$$e9002000$$ENDHEX$$par A-NOVO' "
		sModif += "DTE_DEV_ACP_T.Text 	= 'Prise de d$$HEX1$$e900$$ENDHEX$$cision sur le devis par A-NOVO' "
		sModif += "DTE_RET_LOGIS_T.Text 	= 'Retour du mobile du CTR vers A-NOVO' "
*/

	Case "SBE"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande SBE' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez SBE' "

		sModif += "ID_SERIE_NOUV_T.Text 	= 'IMEI figurant sur le mobile re$$HEX1$$e700$$ENDHEX$$u par SBE' "
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire SBE' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception du mobile chez SBE' "
		sModif += "DTE_RET_LOGIS_T.Text 	= '' "

	Case "FTT"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande FTT' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez FTT' "
		sModif += "ID_SERIE_NOUV_T.Text 	= 'IMEI du nouveau mobile' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'Traitement de la commande chez FTT' "		

	Case "ORV"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande ORANGE' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez ORANGE' "
		sModif += "ID_SERIE_NOUV_T.Text 	= 'IMEI du nouveau mobile' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'Traitement de la commande chez ORANGE' "

	Case "DDF"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande DANGAARD' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez DANGAARD' "
		sModif += "ID_SERIE_NOUV_T.Text 	= 'IMEI du nouveau mobile' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'Traitement de la commande chez DANGAARD' "		
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire DANGAARD' " // #7

	Case "CIS" // [PM444-1]

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande CORIOLIS' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez CORIOLIS' "
		sModif += "ID_SERIE_NOUV_T.Text 	= 'IMEI du nouveau mobile' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'Traitement de la commande chez CORIOLIS' "		
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire CORIOLIS' " // #7

	Case "AGP"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande AGORA PLACE' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez AGORA PLACE' "
		sModif += "ID_SERIE_NOUV_T.Text 	= 'IMEI du nouveau mobile' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception du flux SPB chez AGORA PLACE' "		
		sModif += "DTE_ENV_CLI_T.Text 	= 'Traitement/Envoi de la commande par AGORA PLACE' "				
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire AGORA PLACE' " // #7


	Case "BK2"
// [DT076-2]
		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande BAK2' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez BAK2' "
		sModif += "ID_SERIE_NOUV_T.Text 	= 'IMEI du nouveau mobile' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'Traitement de la commande chez BAK2' "		
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire BAK2' " // #7


	/*------------------------------------------------------------------*/
	/* #1 CAG : 21/09/2004                                              */
	/*------------------------------------------------------------------*/
	Case "MSS"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande MSS' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez MSS' "
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire MSS' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception du notebook chez MSS' "
		sModif += "DTE_RET_LOGIS_T.Text 	= '' " // #7		
		sModif += "DTE_ELV_MOBILE_T.Text = 'D$$HEX1$$e900$$ENDHEX$$p$$HEX1$$f400$$ENDHEX$$t du notebook par le client au SAV FNAC' "
		sModif += "DTE_RCP_MOB_CLI_T.Text= '' " // #7


		sModif += "DTE_ENV_CLI_T.Text 	= 'Envoi du notebook au SAV FNAC' "
		Choose Case True  // D#7
			Case lStatusGc = 2 And ( sCodEtat = "ECL" Or sCodEtat = "RPC" )
				sModif += "DTE_ENV_CLI_T.Text 	= 'Envoi du notebook au SAV FNAC'"

			Case lStatusGc = 21 And ( sCodEtat = "ECL" Or sCodEtat = "RPC" )
				sModif += "DTE_ENV_CLI_T.Text 	= 'Envoi de l~~'appareil irr$$HEX1$$e900$$ENDHEX$$parable au SAV FNAC'"

			Case lStatusGc = 21 And sCodEtat = "RSP" 
				sModif += "DTE_ENV_CLI_T.Text 	= 'Mis en stock du  notebook irr$$HEX1$$e900$$ENDHEX$$parable'"

		End Choose // D#7


	Case "CDS"
		sModif += "ID_SERIE_NOUV_T.Text 	= 'N$$HEX2$$b0002000$$ENDHEX$$contrat assurance C-Discount' "
		sModif += "DTE_ENV_CLI_T.Text 	= 'Derni$$HEX1$$e800$$ENDHEX$$re r$$HEX1$$e900$$ENDHEX$$ponse c-Discount' "
		sModif += "ID_BON_TRANSP_T.Text 	= 'Valeur li$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$l~~'action c-Discount' "
		sModif += "STATUS_GC_T.Text 		= 'Action c-Discount' "
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire c-Discount' " // #7		

	/*------------------------------------------------------------------*/
	/* #3	 MADM	 06/02/2006	  [DCMP060119]: Ajout du frn AEVUM/AVM      */
	/* #4	 MADM	 09/05/2006	  [DCMP060356]: REMPL du frn AEVUM/AVM par CORDON/COR*/
  /*------------------------------------------------------------------*/

		
	Case "COR"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande CORDON' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez CORDON' "

		// [DT288]
		sModif += "ID_SERIE_NOUV_T.Text 	= 'N$$HEX2$$b0002000$$ENDHEX$$IMEI/SERIE' "	
	
		// [DT288]
		If bAppSwap Then 
			sModif += "ID_SERIE_NOUV_T.Text 	= 'IMEI/SERIE appareil swap$$HEX1$$e900$$ENDHEX$$'"
		End If
	
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire CORDON' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception du mobile chez CORDON' "
		sModif += "DTE_RET_LOGIS_T.Text 	= '' " // #7

	// [PC10][DIAG_NOMADE] 
	Case "MDS"

		sModif += "DTE_ENV_CLI_T.Text 	= 'Expertise le' "
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire MEDIA SATURN' " // #7						

	Case "ALP"
		sModif += "STATUS_GC_T.Text 		= 'Action ALAPAGE' "
		
	Case "O2M" // #9 [O2M]
		
		sModif += "ID_REF_FOUR_T.Text 	= 'Action a $$HEX1$$e900$$ENDHEX$$ffectuer par O2M' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception de l~~'appareil chez O2M' "		

		sModif += "ID_SERIE_NOUV_T.Text 	= 'N$$HEX2$$b0002000$$ENDHEX$$IMEI/SERIE' "	
		
		If bAppSwap Then 
			sModif += "ID_SERIE_NOUV_T.Text 	= 'IMEI/SERIE appareil swap$$HEX1$$e900$$ENDHEX$$'"
		End If
		
	   sModif += "DTE_ENV_CLI_T.Text 	= 'Action effectu$$HEX1$$e900$$ENDHEX$$e par O2M le' "
		sModif += "STATUS_GC_T.Text 		= 'Action O2M' "
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire O2M' "		
		sModif += "DTE_RET_LOGIS_T.Text 	= '' "
		sModif += "ID_ORIAN_MODELE_T.Text = 'Pi$$HEX1$$e800$$ENDHEX$$ces jointes au dossier' "
		sModif += "DTE_EMIS_DEVIS_T.Text = '' " // #7
		sModif += "MT_DEVIS_T.Text 		= '' " // #7				
		sModif += "ALT_DEV_ACP_T.Text 	= '' " // #7
		sModif += "ADRFC_NOM_T.Text		= 'Nom Transporteur'" //#11 [DCMP080199]

	Case "BLC" // [BLCODE]
		sModif += "ID_REF_FOUR_T.Text 	= 'Action a $$HEX1$$e900$$ENDHEX$$ffectuer par BLCODE' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception de l~~'appareil chez BLCODE' "		
		sModif += "ID_SERIE_NOUV_T.Text 	= 'N$$HEX2$$b0002000$$ENDHEX$$IMEI/SERIE' "	
	   sModif += "DTE_ENV_CLI_T.Text 	= 'Action effectu$$HEX1$$e900$$ENDHEX$$e par BLCODE le' "
		sModif += "STATUS_GC_T.Text 		= 'Action BLCODE' "
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire BLCODE' "		
		sModif += "DTE_RET_LOGIS_T.Text 	= '' "
		sModif += "ID_ORIAN_MODELE_T.Text = 'Pi$$HEX1$$e800$$ENDHEX$$ces jointes au dossier' "
		sModif += "DTE_EMIS_DEVIS_T.Text = '' " // #7
		sModif += "MT_DEVIS_T.Text 		= '' " // #7				
		sModif += "ALT_DEV_ACP_T.Text 	= '' " // #7
		sModif += "ADRFC_NOM_T.Text		= 'Nom Transporteur'" //#11 [DCMP080199]

	Case "GOM"
		sModif += "DTE_RCP_FRN_T.Text 	= 'Date de traitement chez GO MICRO' "
		sModif += "DTE_RET_LOGIS_T.Text 	= '' "
		sModif += "DTE_RCP_MOB_CLI_T.Text= '' "
		sModif += "DTE_EMIS_DEVIS_T.Text = '' " 
		sModif += "MT_DEVIS_T.Text 		= '' " 
		sModif += "ALT_DEV_ACP_T.Text 	= '' " 

	Case "SCF"

		sModif += "DTE_ENV_CLI_T.Text 	= 'Expertise le' "
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire SURCOUF' " // #10

	//* #12 [MICROMANIA]
	Case "MCM"
		sModif += "STATUS_GC_T.Text 		= 'Action MICROMANIA' "
		sModif += "ID_SERIE_NOUV_T.Text 	= 'N$$HEX2$$b0002000$$ENDHEX$$S$$HEX1$$e900$$ENDHEX$$rie' "

//* #14  JFF   16/04/2009 [DCMP090102]
	Case "CDP"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande CDiscountPRO' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez CDiscountPRO' "
		sModif += "ID_SERIE_NOUV_T.Text 	= 'IMEI/SERIE du nouvel appareil' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'Traitement de la commande chez CDiscountPRO' "		
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire CDiscountPRO' " // #7				

//* #15  JFF   16/04/2009 [DCMP090140]
	Case "PAP"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande Phone&Phone' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez Phone&Phone' "
		sModif += "ID_SERIE_NOUV_T.Text 	= 'IMEI du nouveau mobile' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'Traitement de la commande chez Phone&Phone' "		
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire Phone&Phone' " // #7				

//* #16  JFF   10/06/2009     [RUEDUCOMMERCE]
	Case "RDC"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande RueDuCommerce' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez RueDuCommerce' "
		sModif += "ID_SERIE_NOUV_T.Text 	= 'N$$HEX2$$b0002000$$ENDHEX$$S$$HEX1$$e900$$ENDHEX$$rie nouvel appareil' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'Traitement de la commande chez RueDuCommerce' "		
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire RueDuCommerce' " // #7				

	Case "SB1" // #18 [DCMP090327].[SBETV]
		sModif += "ID_REF_FOUR_T.Text 	= 'Action a $$HEX1$$e900$$ENDHEX$$ffectuer par SBETV' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception de l~~'appareil chez SBETV' "		
		sModif += "ID_SERIE_NOUV_T.Text 	= 'N$$HEX2$$b0002000$$ENDHEX$$IMEI/SERIE' "	
	   sModif += "DTE_ENV_CLI_T.Text 	= 'Action effectu$$HEX1$$e900$$ENDHEX$$e par SBETV le' "
		sModif += "STATUS_GC_T.Text 		= 'Action SBETV' "
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire SBETV' "		
		sModif += "DTE_RET_LOGIS_T.Text 	= '' "
		sModif += "DTE_RCP_MOB_CLI_T.Text= '' "
		sModif += "ID_ORIAN_MODELE_T.Text = 'Pi$$HEX1$$e800$$ENDHEX$$ces jointes au dossier' "
		sModif += "DTE_EMIS_DEVIS_T.Text = '' " // #7
		sModif += "MT_DEVIS_T.Text 		= '' " // #7				
		sModif += "ALT_DEV_ACP_T.Text 	= '' " // #7
		sModif += "ADRFC_NOM_T.Text		= 'Nom Transporteur'" //#11 [DCMP080199]

	Case "MS1" // [MSS_DIAG]
		sModif += "ID_REF_FOUR_T.Text 	= 'Action a $$HEX1$$e900$$ENDHEX$$ffectuer par MSS' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception de l~~'appareil chez MSS' "		
		sModif += "ID_SERIE_NOUV_T.Text 	= 'N$$HEX2$$b0002000$$ENDHEX$$IMEI/SERIE' "	
	   sModif += "DTE_ENV_CLI_T.Text 	= 'Action effectu$$HEX1$$e900$$ENDHEX$$e par MSS le' "
		sModif += "STATUS_GC_T.Text 		= 'Action MSS' "
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire MSS' "		
		sModif += "DTE_RET_LOGIS_T.Text 	= '' "
		sModif += "DTE_RCP_MOB_CLI_T.Text= '' "
		sModif += "ID_ORIAN_MODELE_T.Text = 'Pi$$HEX1$$e800$$ENDHEX$$ces jointes au dossier' "
		sModif += "DTE_EMIS_DEVIS_T.Text = '' " // #7
		sModif += "MT_DEVIS_T.Text 		= '' " // #7				
		sModif += "ALT_DEV_ACP_T.Text 	= '' " // #7
		sModif += "ADRFC_NOM_T.Text		= 'Nom Transporteur'" //#11 [DCMP080199]


	//* #22 [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
	Case "FNC"
		sModif += "DTE_RET_LOGIS_T.Text	= '' "
		sModif += "DTE_RCP_FRN_T.Text 	= '' "
		sModif += "DTE_RCP_MOB_CLI_T.Text= '' "
		sModif += "ID_CMD_FRN_T.Text	   = '' "
		sModif += "STATUS_GC_T.Text 		= '' "
		sModif += "ID_SERIE_NOUV_T.Text	= '' "
		sModif += "ID_BON_TRANSP_T.Text 	= '' "
		sModif += "DTE_ENV_CLI_T.Text    = 'BGE consomm$$HEX2$$e9002000$$ENDHEX$$le'"
		sModif += "ID_REF_FOUR_T.Text 	= '' "
		aDwTrtCmdFrn.SetItem ( 1, "COMMENT_FRN", "BGE consomm$$HEX2$$e9002000$$ENDHEX$$par le client en magasin." )
		aDwTrtCmdFrn.SetItem ( 1, "ID_REF_FOUR", "" )		

	// [PC363_AUCHAN]
	Case "AUC"
		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$carte cadeau Auchan' "
		sModif += "DTE_ENV_CLI_T.Text 	= 'Date envoi carte cadeau' "
		sModif += "DTE_RCP_MOB_CLI_T.Text= ''"

	// [PC321]
	Case "SCR"
		sModif += "MT_DEVIS_T.Text 		= 'Montant de la r$$HEX1$$e900$$ENDHEX$$paration HT' "
		sModif += "DTE_ENV_CLI_T.Text    = 'Date de disponibilit$$HEX2$$e9002000$$ENDHEX$$de l'appareil'"

	// [CONFO][CUISINE]
	Case "CFM"
		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$carte cadeau Conforama (Dallas)' "
		
	// [PM200][PSM]
	Case "PSM"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande PSM' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez PSM' "

		sModif += "ID_SERIE_NOUV_T.Text 	= 'N$$HEX2$$b0002000$$ENDHEX$$IMEI/SERIE' "	
	
		If bAppSwap Then 
			sModif += "ID_SERIE_NOUV_T.Text 	= 'IMEI/SERIE appareil swap$$HEX1$$e900$$ENDHEX$$'"
		End If
	
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire PSM' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception du mobile chez PSM' "
		sModif += "DTE_RET_LOGIS_T.Text 	= '' " // #7
//		sModif += "DTE_ENV_CLI_T.Text 	= 'Retour PSM sur l~~'appareil' " // MANTIS3709
		sModif += "DTE_ENV_CLI_T.Text 	= 'Envoi du mobile (Nouv./R$$HEX1$$e900$$ENDHEX$$par$$HEX1$$e900$$ENDHEX$$) chez le client' " // MANTIS3709

		// [PC938_ORANGE_V3]
		Choose Case asTypArt
			Case "REL"
				sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception de l~~'appareil de remplacement' " // #7
				sModif += "DTE_ENV_CLI_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration app. rempl. par l~~'assur$$HEX1$$e900$$ENDHEX$$' "
		End CHoose 
		
	// [PC801_6_TAMET]
	Case "TMT"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande TAMET' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez TAMET' "

		sModif += "ID_SERIE_NOUV_T.Text 	= 'IMEI figurant sur le mobile re$$HEX1$$e700$$ENDHEX$$u par TAMET' "
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire TAMET' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception du mobile chez TAMET' "
		sModif += "DTE_RET_LOGIS_T.Text 	= '' " // #7
		sModif += "DTE_ENV_CLI_T.Text 	= 'Envoi du mobile (Nouv./R$$HEX1$$e900$$ENDHEX$$par$$HEX1$$e900$$ENDHEX$$) chez le client' " // MANTIS3709

		// [PC938_ORANGE_V3]
		Choose Case asTypArt
			Case "REL"
				sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception de l~~'appareil de remplacement' " // #7
				sModif += "DTE_ENV_CLI_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration app. rempl. par l~~'assur$$HEX1$$e900$$ENDHEX$$' "
		End CHoose 

		
		// [PC884]
	Case "LBE"
		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$bon achat abr$$HEX1$$e900$$ENDHEX$$g$$HEX1$$e900$$ENDHEX$$' "
		sModif += "DTE_ENV_CLI_T.Text 	= 'Date envoi bon achat' "
		sModif += "STATUS_GC_T.Text= ''"
		sModif += "ID_SERIE_NOUV_T.Text= ''"
		sModif += "DTE_RCP_MOB_CLI_T.Text= ''"
		sModif += "DTE_RCP_FRN_T.Text= ''"
		sModif += "DTE_RCP_MOB_CLI_T.Text= ''"
		sModif += "DTE_RET_LOGIS_T.Text= ''"
		sModif += "ADRFC_NOM_T.Text= 'Type exp$$HEX1$$e900$$ENDHEX$$dition'"

	Case "MTT" // #9 [O2M]
		sModif += "ID_REF_FOUR_T.Text 	= 'Action a $$HEX1$$e900$$ENDHEX$$ffectuer par MTT' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception de l~~'appareil chez MTT' "		
		sModif += "ID_SERIE_NOUV_T.Text 	= 'N$$HEX2$$b0002000$$ENDHEX$$IMEI/SERIE' "	
	   sModif += "DTE_ENV_CLI_T.Text 	= 'Action effectu$$HEX1$$e900$$ENDHEX$$e par MTT le' "
		sModif += "STATUS_GC_T.Text 		= 'Action MTT' "
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire MTT' "		
		sModif += "DTE_RET_LOGIS_T.Text 	= '' "
		sModif += "ID_ORIAN_MODELE_T.Text = '' "
		sModif += "DTE_EMIS_DEVIS_T.Text = '' " // #7
		sModif += "MT_DEVIS_T.Text 		= '' " // #7				
		sModif += "ALT_DEV_ACP_T.Text 	= '' " // #7
		sModif += "ADRFC_NOM_T.Text		= 'Nom Transporteur'" //#11 [DCMP080199]
		
	Case "CMA" // [DT176]
		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$de lot' "
		sModif += "ID_BON_TRANSP_T.Text 	= 'N$$HEX2$$b0002000$$ENDHEX$$de recommand$$HEX2$$e9002000$$ENDHEX$$AR' "		 
		sModif += "DTE_ENV_CLI_T.Text 	= 'Date d~~'envoi du/des bon(s) d~~'achat' "

	Case "OMT" // [PC874_2_V1]
		sModif += "ID_REF_FOUR_T.Text 	= 'Action a $$HEX1$$e900$$ENDHEX$$ffectuer' "
		sModif += "STATUS_GC_T.Text 		= 'Satut de l~~'IMEI'"
		sModif += "DTE_ENV_CLI_T.Text 	= 'Date Dern. Utilisation IMEI' "
		sModif += "DTE_RCP_FRN_T.Text 	= ''"
		sModif += "DTE_RET_LOGIS_T.Text 	= '' "		
		sModif += "DTE_RCP_MOB_CLI_T.Text= '' "

	// [DT424]
	Case "OOP", "OGP"
		sModif += "DTE_RCP_FRN_T.Text	   = 'Date de traitement' "		
		sModif += "DTE_ENV_CLI_T.Text	   = 'Date de traitement' "				
		sModif += "DTE_RET_LOGIS_T.Text 	= '' "
		sModif += "DTE_RCP_MOB_CLI_T.Text= '' "

	// [RS3200]
	Case "TLS"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande TELSTORE' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. article chez TELSTORE' "
		sModif += "ID_SERIE_NOUV_T.Text 	= 'IMEI du nouveau mobile' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception du flux SPB chez TELSTORE' "		
		sModif += "DTE_ENV_CLI_T.Text 	= 'Traitement/Envoi de la commande par TELSTORE' "				
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire TELSTORE' " // #7

	// [PMO89_RS4822]
	Case "CDF"

		sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$commande CARDIF' "
		sModif += "ID_REF_FOUR_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$f. Dde chez CARDIF' "
		sModif += "ID_SERIE_NOUV_T.Text 	= '' "
		sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception du flux SPB chez CARDIF' "		
		sModif += "DTE_ENV_CLI_T.Text 	= 'Traitement de la demande par CARDIF' "				
		sModif += "COMMENT_FRN_T.Text 	= 'Commentaire CARDIF' " // #7
		
	Case Else
		
		
		// [HP252_276_HUB_PRESTA] 
		// Fournisseur li$$HEX2$$e9002000$$ENDHEX$$au Hub Prestataire
		If F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then

			// Par d$$HEX1$$e900$$ENDHEX$$faut, si le fournisseur est li$$HEX2$$e9002000$$ENDHEX$$au HP
			If bFournHub Then
				sModif = ""
				sModif += "ID_CMD_FRN_T.Text 		= 'N$$HEX2$$b0002000$$ENDHEX$$prestation CTR' "
				sModif += "ID_REF_FOUR_T.Text 	= 'Ordre intervention prestation' "
				sModif += "STATUS_GC_T.Text 		= 'Statut de la prestation' "				
				sModif += "ID_SERIE_NOUV_T.Text 	= 'IMEI/SERIE lu sur app. re$$HEX1$$e700$$ENDHEX$$u' "
				sModif += "ID_BON_TRANSP_T.Text 	= 'Dernier N$$HEX2$$b0002000$$ENDHEX$$bon transp. connu' "
				sModif += "ADRFC_NOM_T.Text 		= 'Nom du transporteur' " 
				sModif += "COMMENT_FRN_T.Text 	= 'Commentaire du CTR' "

				sModif += "DTE_RCP_BTE_CLI_T.Text= '' "		
				sModif += "DTE_DEP_BTE_CLI_T.Text= '' "
				sModif += "DTE_ELV_MOBILE_T.Text = '' "
				sModif += "DTE_RCP_FRN_T.Text 	= 'R$$HEX1$$e900$$ENDHEX$$ception appareil en CTR (station)' "
		
				sModif += "DTE_ENV_ST_T.Text 	   = '' "		
				sModif += "ALT_DEV_ACP_T.Text 	= '' "
				sModif += "DTE_DEV_ACP_T.Text 	= '' "
				sModif += "DTE_RET_LOGIS_T.Text 	= '' "
				sModif += "DTE_ENV_ST_T.Text 	   = '' "
				sModif += "DTE_EMIS_DEVIS_T.Text = '' "
				sModif += "MT_DEVIS_T.Text 		= '' "
				sModif += "ALT_DEV_ACP_T.Text 	= '' "
				sModif += "DTE_DEV_ACP_T.Text 	= '' "
				sModif += "DTE_RET_LOGIS_T.Text 	= '' "
				sModif += "DTE_RET_PRET_MIN_T.Text = '' "
				sModif += "DTE_RET_PRET_MAX_T.Text = '' "
				sModif += "DTE_ENV_CLI_T.Text 	= 'Date fin de traitement / envoi colis' "
				sModif += "ID_ORIAN_MODELE_T.Text = '' "
				sModif += "ADRFC_NOM_T.Text = '' " // #11 [CMP080199]
				sModif += "DTE_RCP_MOB_CLI_T.Text = 'R$$HEX1$$e900$$ENDHEX$$ception appareil (nouveau/r$$HEX1$$e900$$ENDHEX$$par$$HEX1$$e900$$ENDHEX$$) par le client' "

			End If 
		End IF 

	
End Choose

//* #13 [FNAC_PROD_ECH_TECH] Gestion des nouvelles zones en chaine
// #19  [20090914175511700]	
// If asTypeTrt <> "S" Then
// #25 [MSS_LOT2] On ne peut plus se permettre de modifier cette chaine en saisie $$HEX2$$e0002000$$ENDHEX$$pr$$HEX1$$e900$$ENDHEX$$sent
// du fait que des maj avec validation sont possibles maintenant.
// If sCodEtat <> "CNV" Then

// [HP252_276_HUB_PRESTA]
If Not F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then

	If asTypeTrt <> "S" Then
		sInfoSpbFrnCplt = aDwTrtCmdFrn.GetItemString ( 1, "INFO_SPB_FRN_CPLT" )
		sInfoFrnSpbCplt = aDwTrtCmdFrn.GetItemString ( 1, "INFO_FRN_SPB_CPLT" )
		
		// SPB vers FRN
		sTabRech  [1] = ";"									; sTabSubst [1] = ", "
		sTabRech  [2] = "=" 									; sTabSubst [2] = " : "
		sTabRech  [3] = "MAT_SIN"							; sTabSubst [3] = "Mat$$HEX1$$e900$$ENDHEX$$riel sinistr$$HEX1$$e900$$ENDHEX$$"
		sTabRech  [4] = "[SIN_APP]"						; sTabSubst [4] = "Appareil"
		sTabRech  [5] = "[SIN_BATT]"						; sTabSubst [5] = "Batterie amovible"
		sTabRech  [6] = "[SIN_ALIM]"						; sTabSubst [6] = "Alimentation"
		sTabRech  [7] = "DTE_HEU_RDV"						; sTabSubst [7] = "Date/heure rdv > assur$$HEX1$$e900$$ENDHEX$$"
	
		// #16 [RUEDUCOMMERCE]
		sTabRech  [8] = "REF_FDP"						   ; sTabSubst [8] = "R$$HEX1$$e900$$ENDHEX$$f Fdp"
		sTabRech  [9] = "CODE_PAYS"						; sTabSubst [9] = "Code Pays"
		// #18 [DCMP090327].[SBETV]
		sTabRech  [10] = "DEPT_ENLEV"						; sTabSubst [10] = "D$$HEX1$$e900$$ENDHEX$$partement d'enl$$HEX1$$e800$$ENDHEX$$vement de l'appareil"
	
		// #21 [DCMP090421]
		sTabRech  [11] = "MAIL_ASSURE"					; sTabSubst [11] = "Mail de l'assur$$HEX1$$e900$$ENDHEX$$"
	
		// #24 [O2M_DIAG_NOMADE].Lot2.JFF
		sTabRech  [12] = "MAIL_BTQ_REL"					; sTabSubst [12] = "Mail boutique pour relance"
		sTabRech  [13] = "CODE_BTQ_REL"					; sTabSubst [13] = "Code boutique"	
	
		// #25 [MSS_LOT2]	
		sTabRech  [14] = "[SIN_AUT_ACC]"					; sTabSubst [14] = "Autre(s) accessoires(s)"		
		sTabRech  [15] = "RETOUR_169"						; sTabSubst [15] = "Retour MSS mat. incomplet"		
		sTabRech  [16] = "ASS_ENVOIE_ACC"				; sTabSubst [16] = "L'assur$$HEX2$$e9002000$$ENDHEX$$envoie le(s) acc."
		sTabRech  [17] = "DIAG_EN_L_ETAT_ASS_N_ENVOIE_PAS_ACC" ; sTabSubst [17] = "MSS diag en l'$$HEX1$$e900$$ENDHEX$$tat, l'ass n'envoie pas le(s) acc(s)"
		sTabRech  [18] = "REL_C13" 						; sTabSubst [18] = "Nombre de relance Chrono13"	
		sTabRech  [19] = "REL_RDV" 						; sTabSubst [19] = "Nombre de relance de rdv"	
		sTabRech  [20] = "LIB_ART_CLT"					; sTabSubst [20] = "Libell$$HEX2$$e9002000$$ENDHEX$$article client"
	
		// [WEBSIM2].[FRANCE]
		sTabRech  [21] = "DTE_FIN_VAL_MDP_BTQ"			; sTabSubst [21] = "Date Fin validit$$HEX2$$e9002000$$ENDHEX$$mot de passe boutique"	
	
		// [PC363_AUCHAN]
		sTabRech  [22] = "DUR_VAL_CC"				     	; sTabSubst [22] = "Dur$$HEX1$$e900$$ENDHEX$$e validit$$HEX2$$e9002000$$ENDHEX$$Carte Cadeau"
		// [PC321]
		sTabRech  [23] = "NUM_DIAG"						; sTabSubst [23] = "Num$$HEX1$$e900$$ENDHEX$$ro Diag"	
		sTabRech  [24] = "NUM_DOS_TECHNISOFT"			; sTabSubst [24] = "Num$$HEX1$$e900$$ENDHEX$$ro dossier TechniSoft"	
		sTabRech  [25] = "BRIS_REP"						; sTabSubst [25] = "Bris r$$HEX1$$e900$$ENDHEX$$parable"		
		sTabRech  [26] = "MT_REP"						   ; sTabSubst [26] = "Montant r$$HEX1$$e900$$ENDHEX$$paration"			
		sTabRech  [27] = "DEL_IMMO_APP"				   ; sTabSubst [27] = "D$$HEX1$$e900$$ENDHEX$$lai immobilisation"			
		sTabRech  [28] = "DTE_DIAG"				      ; sTabSubst [28] = "Date Diag"			
		sTabRech  [29] = "LIEU_DIAG"				      ; sTabSubst [29] = "Lieu Diag"			
		sTabRech  [30] = "ETAT"				      		; sTabSubst [30] = "Etat presta"			
		sTabRech  [31] = "DTE_APP_DISPO"					; sTabSubst [31] = "Date app. Dispo"			
		sTabRech  [32] = "MT_DEVIS"						; sTabSubst [32] = "Montant devis"			
		sTabRech  [33] = "MT_ENVOI"						; sTabSubst [33] = "Montant envoi"			
		sTabRech  [34] = "SAV"								; sTabSubst [34] = "SAV"				
		sTabRech  [35] = "TEL_SAV"							; sTabSubst [35] = "T$$HEX1$$e900$$ENDHEX$$l SAV"				
		sTabRech  [36] = "IRREP"							; sTabSubst [36] = "Cause irr$$HEX1$$e900$$ENDHEX$$parabilit$$HEX1$$e900$$ENDHEX$$"				
		
		// [VDOC3290]
		sTabRech  [37] = "APP_INCOMPLET"			     	; sTabSubst [37] = "Appareil incomplet"
		sTabRech  [38] = "SYMP_NON_DETEC_EN_24H"		; sTabSubst [38] = "Sympt$$HEX1$$f400$$ENDHEX$$me non d$$HEX1$$e900$$ENDHEX$$tectable en 24h"
		// [VDOC3290]
		
		// [PM82][LOT2]
		sTabRech  [39] = "A_REPARER_SAV"					; sTabSubst [39] = "A r$$HEX1$$e900$$ENDHEX$$parer en mode SAV"
	
		// [PM95]
		// [PM287-2][MANTIS20212]
		sTabRech  [40] = "CPT_REL_PM95"					; sTabSubst [40] = "Compteur Relance PM287-2"
		sTabRech  [41] = "EXCL_REL"						; sTabSubst [41] = "Presta Exclue Relance PM287-2"
		sTabRech  [42] = "ALERTE"							; sTabSubst [42] = "Derni$$HEX1$$e800$$ENDHEX$$re(s) Alerte PM287-2 d$$HEX1$$e900$$ENDHEX$$clench$$HEX1$$e900$$ENDHEX$$e(s)"
	
		// [RECUP_DONNEE_O2M]
		sTabRech  [43] = "RECUP_DONNEES"					; sTabSubst [43] = "R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de donn$$HEX1$$e900$$ENDHEX$$es"
		sTabRech  [44] = "RECUP_APP_PAR_ASSURE"		; sTabSubst [44] = "R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de mat$$HEX1$$e900$$ENDHEX$$riel"
		
		// [CONFO][CUISINE]
		sTabRech  [45] = "DTE_CREATION_CARTE_CADEAU"	; sTabSubst [45] = "Date de cr$$HEX1$$e900$$ENDHEX$$ation carte cadeau dans le syt$$HEX1$$e800$$ENDHEX$$me Dallas"
	
		// [PM200][PSM]
		sTabRech  [46] = "CODE_BTQ_PSM_CENTRALE"		; sTabSubst [46] = "Code Boutique Centrale PSM"	
		sTabRech  [47] = "MT_PEC"							; sTabSubst [47] = "Montant de prise en charge"
		sTabRech  [48] = "A_DESOXYDER_SAV"				; sTabSubst [48] = "A d$$HEX1$$e900$$ENDHEX$$soxyder en mode SAV"	
	
		// [BLCODE]
		sTabRech  [49] = "REF_MAT"							; sTabSubst [49] = "R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence mat$$HEX1$$e900$$ENDHEX$$riel"	
		sTabRech  [50] = "MARQUAGE"						; sTabSubst [50] = "Marquage"
	
		// [PM103][1]	
		sTabRech  [51] = "PRESTA_REPRISE_BASE_MANUELLE"	; sTabSubst [51] = "Presta. reprise base manuelle"	
	
		// [VDOC8041]
		sTabRech  [52] = "MAJ_PRS"							; sTabSubst [52] = "Mise $$HEX2$$e0002000$$ENDHEX$$jour prestation"	
		sTabRech  [53] = "CODE_VERROU"					; sTabSubst [53] = "Code verrou"		
	
		sTabRech  [54] = "DONNEUR_ORDRE"					; sTabSubst [54] = "Donneur d'ordre" // [DT57]
	
		sTabRech  [55] = "NEUF_REC"						; sTabSubst [55] = "Neuf/Recond"				
		sTabRech  [56] = "NEU"								; sTabSubst [56] = "Neuf"				
		sTabRech  [57] = ""									; sTabSubst [57] = ""				
		
	// [PC938_ORANGE_V3]	
		sTabRech  [58] = "CODE_BTQ_RELAI_PSM"			; sTabSubst [58] = "Boutique Relai PSM"
		sTabRech  [59] = "RELAI_BTQ_PSM"					; sTabSubst [59] = "Relai en boutique PSM"
		sTabRech  [60] = "TYP_RELAI"						; sTabSubst [60] = "Type action"
		sTabRech  [61] = "NOM_ASS"							; sTabSubst [61] = "Nom assur$$HEX1$$e900$$ENDHEX$$"
		sTabRech  [62] = "PRENOM_ASS"						; sTabSubst [62] = "Pr$$HEX1$$e900$$ENDHEX$$nom assur$$HEX1$$e900$$ENDHEX$$"
		sTabRech  [63] = "RST_INFO_SIMPLE"				; sTabSubst [63] = "Rupture de stock info simple"	
		sTabRech  [64] = "PCE_PV_RECU"					; sTabSubst [64] = "Pi$$HEX1$$e800$$ENDHEX$$ce PV re$$HEX1$$e700$$ENDHEX$$u"
		sTabRech  [65] = "RST_CMDE+SUIVI"				; sTabSubst [65] = "Rupture de stock+Cmde+Suivi"	
		sTabRech  [66]	= "APP_SIN_A_RECUPERER"			; sTabSubst [66]	= "App. Sinistr$$HEX4$$e9002000e0002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer"							
	
	// A laisser tjrs $$HEX2$$e0002000$$ENDHEX$$la fin	
		sTabRech  [67] = "REC"								; sTabSubst [67] = "Reconditionn$$HEX1$$e900$$ENDHEX$$"						
		sTabRech  [68] = "A_CONTROLER_SAV"				; sTabSubst [68] = "A controler en mode SAV" // [PM222-1]
		sTabRech  [69] = "MAIL_IOS7"						; sTabSubst [69] = "Mail IOS7" // [VDOC12443]
	
		sTabRech  [70] = "MAJOR_CONTRACTUELLE_EUROS"	; sTabSubst [70] = "Majoration contractuelle en euros"			
	// [DT081_EVOL_PRET_BRIS]
		sTabRech  [71] = "TYP_APP_PRET"					; sTabSubst [71] = "Type Appareil de pr$$HEX1$$ea00$$ENDHEX$$t"
		sTabRech  [72] = "PRC_ORIG"						; sTabSubst [72] = "Process d'origine"
		sTabRech  [73] = "DTE_COUR_RESTIT_1REL"		; sTabSubst [73] = "Date cour. 1$$HEX1$$e800$$ENDHEX$$re Rel. restit."	
		sTabRech  [74] = "DTE_COUR_RESTIT_2REL"		; sTabSubst [74] = "Date cour. 2$$HEX1$$e800$$ENDHEX$$me Rel. restit."	
		sTabRech  [75] = "DTE_COUR_RESTIT"				; sTabSubst [75] = "Date cour. dem. restit."	
		sTabRech  [76] = "RPC_SUR_DEBCAUT"				; sTabSubst [76] = "Ferm$$HEX2$$e9002000$$ENDHEX$$sur D$$HEX1$$e900$$ENDHEX$$bit Caution"		
		sTabRech  [77] = "CODE_PICK_UP"					; sTabSubst [77] = "Code Rel. PickUp"			
		sTabRech  [78] = "SUR_DEM_ASS"					; sTabSubst [78] = "Sur Demande Assur$$HEX1$$e900$$ENDHEX$$"	 // [PC13274-2]		
		sTabRech  [79] = "CODE_PARENTAL"					; sTabSubst [79] = "Code parental"	 // [PM259-1]		
		sTabRech  [80] = "NUM_CC_ELD"					   ; sTabSubst [80] = "Carte Cadeau Electro D$$HEX1$$e900$$ENDHEX$$p$$HEX1$$f400$$ENDHEX$$t"	 // [PC13321]		
		sTabRech  [81] = "REF_INDEM"					   ; sTabSubst [81] = "R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence indemnisation"	 // [PC13321]			
		sTabRech  [82] = "DTE_BGE"					   	; sTabSubst [82] = "Date envoi courrier KSL carte cadeau"	 // [PC13321]			
		sTabRech  [83] = "PRC_ORIG"					   ; sTabSubst [83] = "Process Origine"	 // [DT81]			
		sTabRech  [84] = "SKU_IFR"					   	; sTabSubst [84] = "Sku IFR"	
		sTabRech  [85] = "CMDE_A_CPLT"					; sTabSubst [85] = "Commande $$HEX2$$e0002000$$ENDHEX$$compl$$HEX1$$e900$$ENDHEX$$ter"	// [DT141]
		sTabRech  [86] = "MAJ_ADRESSE"					; sTabSubst [86] = "Mise $$HEX2$$e0002000$$ENDHEX$$jour adresse"	
		sTabRech  [87] = "RET_REL_PICK_UP"				; sTabSubst [87] = "Retour par relais Pick Up"	// [DT191-1]
		sTabRech  [88] = "GEOLOC"							; sTabSubst [88] = "G$$HEX1$$e900$$ENDHEX$$olocalisation"	// [PM287-3]
		sTabRech  [89] = "SUPP"						   	; sTabSubst [89] = "Supprim$$HEX1$$e900$$ENDHEX$$e"   // [PM287-3]
		sTabRech  [90] = "MT_PREFACT"						; sTabSubst [90] = "Montant de pr$$HEX1$$e900$$ENDHEX$$-facturation"   // [PM287-3]
		sTabRech  [91] = "AUTO_ATLAS"						; sTabSubst [91] = "Presta auto par ATLAS"   // [PM234-7]
		sTabRech  [92] = "GESTION_ENVOI_BA"				; sTabSubst [92] = "Gestion envoi BA"   
		sTabRech  [93] = "BTQ_PSM_ADV"					; sTabSubst [93] = "Boutique PSM Advise"   // [ITSM494276]
		sTabRech  [94] = "GRADE_REC"						; sTabSubst [94] = "Grade Recond."	// [VDOC25657]	
		sTabRech  [95] = "PROV_REC"						; sTabSubst [95] = "Prov. Recond."	// [VDOC25770]			
		sTabRech  [96] = "FLUX"								; sTabSubst [96] = "Flux" // [VDOC26276]
		sTabRech  [97] = "AUTO_ATM"						; sTabSubst [97] = "Presta auto par ATM"   // [PC151379]
		sTabRech  [98] = "MAIL_CHAP_ENVOYE"				; sTabSubst [98] = "Mail chapeau envoy$$HEX1$$e900$$ENDHEX$$"   // [DT339]
		sTabRech  [99] = "DTE_MAIL_CHAP"				   ; sTabSubst [99] = "Date envoi Mail chapeau"   // [DT339]	
		sTabRech  [100] = "BUYBACK"				   	; sTabSubst [100] = "Buy Back"   // [DT386]		
		sTabRech  [101] = "AUTO_AXA"						; sTabSubst [101] = "Presta auto par AXA"   // [DT386]
		sTabRech  [102] = "MT_CPLT_PAYBOX_SCM"			; sTabSubst [102] = "Mt Cplt PayBox SCM"   // [PM462-1]
		sTabRech  [103] = "TYP_PCE_IDENT"				; sTabSubst [103] = "Type pce ident"   // [DT386_EXTR_AXA_V8]
		sTabRech  [104] = "AUTOR_PCE_IDENT"			   ; sTabSubst [104] = "Autorit$$HEX2$$e9002000$$ENDHEX$$pce ident"   // [DT386_EXTR_AXA_V8]
		sTabRech  [105] = "NUM_PCE_IDENT"				; sTabSubst [105] = "Num$$HEX1$$e900$$ENDHEX$$ro pce ident"   // [DT386_EXTR_AXA_V8]
		sTabRech  [106] = "DTE_DELIVR_PI"				; sTabSubst [106] = "Date d$$HEX1$$e900$$ENDHEX$$livr PI"   // [DT386_EXTR_AXA_V8]
		sTabRech  [107] = "DTE_FIN_VAL_PI"				; sTabSubst [107] = "Date Fin valid PI"   // [DT386_EXTR_AXA_V8]
		sTabRech  [108] = "ID_REG_FRANCHISE"			; sTabSubst [108] = "IdReg Franchise"   // [PM462-1]
		
		lTot = UpperBound ( sTabRech )
		For lCpt = 1 To lTot
			sInfoSpbFrnCplt = F_Remplace ( sInfoSpbFrnCplt, sTabRech  [lCpt], sTabSubst [lCpt] )
		Next
		
		aDwTrtCmdFrn.SetItem ( 1, "INFO_SPB_FRN_CPLT", sInfoSpbFrnCplt )
		
		// :SPB vers FRN
		
		sTabRech = sTabNull; sTabSubst = sTabNull
		
		// FRN vers SPB
		sTabRech  [1] = ";"									; sTabSubst [1] = ", "
		sTabRech  [2] = "=" 									; sTabSubst [2] = " : "
		sTabRech  [3] = "RDV_CONF"							; sTabSubst [3] = "Confirmation RDV " + asIdFour + "/assur$$HEX1$$e900$$ENDHEX$$"
	// #18 [DCMP090327].[SBETV]
		sTabRech  [4] = "DTE_LIVR_BROKER"				; sTabSubst [4] = "Mat$$HEX1$$e900$$ENDHEX$$riel livr$$HEX2$$e9002000$$ENDHEX$$au broker le"
	
		// [WEBSIM2].[FRANCE]
		sTabRech  [5] = "CODE_MAGASIN"					; sTabSubst [5] = "Code magasin"
		sTabRech  [6] = "CODE_VENDEUR"					; sTabSubst [6] = "Code vendeur"
	
		// [PC363_AUCHAN]
		sTabRech  [7] = "MARQUE_REMPL"					; sTabSubst [7] = "Marque remplacement"
		sTabRech  [8] = "MODELE_REMPL"					; sTabSubst [8] = "Mod$$HEX1$$e800$$ENDHEX$$le remplacement"
		sTabRech  [9] = "PRIX_TTC_FACTU_O2M"			; sTabSubst [9] = "Prix TTC Facture O2M"
		sTabRech  [10] = "PRIX_TTC_PUBLIC"				; sTabSubst [10] = "Prix TTC public"
		sTabRech  [11] = "APP_INCOMPLET"					; sTabSubst [11] = "Appareil incomplet"
		// [PM82][LOT1]
		sTabRech  [12] = "RETOUR_153"						; sTabSubst [12] = "IMEI/Num.S$$HEX1$$e900$$ENDHEX$$rie diff$$HEX1$$e900$$ENDHEX$$rent"	
		sTabRech  [13] = "RETOUR_154"						; sTabSubst [13] = "IMEI/Num.S$$HEX1$$e900$$ENDHEX$$rie illisible"	
	
		// [RECUP_DONNEE_O2M]
		sTabRech  [14] = "CGU_PRESENT"					; sTabSubst [14] = "CGU Pr$$HEX1$$e900$$ENDHEX$$sent"
		sTabRech  [15] = "DONNEES_RECUPEREES"			; sTabSubst [15] = "Donn$$HEX1$$e900$$ENDHEX$$es r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es"
		sTabRech  [16] = "DONNEES_TRANSFEREES_SUR_NOUVEL_APP"; sTabSubst [16] = "Donn$$HEX1$$e900$$ENDHEX$$es tranf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es sur nouvel appareil"		
		sTabRech  [17] = "PCT_DONNEES_RECUP"			; sTabSubst [17] = "% donn$$HEX1$$e900$$ENDHEX$$es r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es"		
		sTabRech  [18] = "LOGIN_AXALOT"					; sTabSubst [18] = "Login Axalot"
		sTabRech  [19]	= "MDP_AXALOT"						; sTabSubst [19] = "Mot de passe Axalot"
		sTabRech  [20] = "APP_RECUPERE_PAR_ASSURE"   ; sTabSubst [20] = "Appareil r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX2$$e9002000$$ENDHEX$$par assur$$HEX1$$e900$$ENDHEX$$"			// [PM200][PSM]
		sTabRech  [21]	= "ASSURE_EN_PDV"					; sTabSubst [21] = "Assur$$HEX2$$e9002000$$ENDHEX$$en point de vente"
		sTabRech  [22]	= "NOM_PDV"							; sTabSubst [22] = "Nom point de vente"
		sTabRech  [23]	= "NUM_PDV"							; sTabSubst [23] = "Num$$HEX1$$e900$$ENDHEX$$ro point de vente"
		sTabRech  [24]	= "ASSURE_ENVOIE_COLIS"			; sTabSubst [24] = "Assur$$HEX2$$e9002000$$ENDHEX$$envoie colis"		// [VDOC6449]
		sTabRech  [25] = "DTE_LIVR_SBE"					; sTabSubst [25] = "Mat$$HEX1$$e900$$ENDHEX$$riel centralis$$HEX2$$e9002000$$ENDHEX$$chez SBE/2ES"	
		sTabRech  [26] = "ETAT_SG"							; sTabSubst [26] = "Etat SG"	
		sTabRech  [27] = "DATE_ETAT_SG"					; sTabSubst [27] = "Date Etat SG"		
		sTabRech  [28] = "TV_HG"					      ; sTabSubst [28] = "TV HG"			
		sTabRech  [29] = "DATE_TV_HG"						; sTabSubst [29] = "Date TV HG"			// [PM200][LOT2][DESOX]
		sTabRech  [30] = "PRESENCE_OX"					; sTabSubst [30] = "Pr$$HEX1$$e900$$ENDHEX$$sence d'une oxydation"			
		sTabRech  [31] = "PRIX_TTC_FACTU_BLC"			; sTabSubst [31] = "Prix TTC Facture BLCODE"	
		sTabRech  [32]	= "INTER_A_DOMICILE"				; sTabSubst [32] = "Intervention $$HEX2$$e0002000$$ENDHEX$$Domicile"			// [PC877]
		sTabRech  [33]	= "DTE_RESTIT_APP_PRET"			; sTabSubst [33] = "Date restitution app. pr$$HEX1$$ea00$$ENDHEX$$t"	// [PC938_ORANGE_V3]		
		sTabRech  [34]	= "ETAT_APP_PRET"					; sTabSubst [34] = "Etat app. pr$$HEX1$$ea00$$ENDHEX$$t"	
		sTabRech  [35]	= "PCT_ENDOMM"						; sTabSubst [35] = "Pourcentage endommag$$HEX1$$e900$$ENDHEX$$"
		sTabRech  [36]	= "MARQ_RST_FRN"					; sTabSubst [36] = "Marque Cmd$$HEX1$$e900$$ENDHEX$$e"
		sTabRech  [37]	= "MODL_RST_FRN"					; sTabSubst [37] = "Mod$$HEX1$$e800$$ENDHEX$$le Cmd$$HEX1$$e900$$ENDHEX$$e"	
		sTabRech  [38]	= "ID_REF_FOUR_RST_FRN"			; sTabSubst [38] = "Ref fourn Cmd$$HEX1$$e900$$ENDHEX$$e"		
		sTabRech  [39]	= "PRIX_HT_RST_FRN"				; sTabSubst [39] = "Prix HT Cmd$$HEX1$$e900$$ENDHEX$$"			
		sTabRech  [40]	= "PSM_NOM1"						; sTabSubst [40] = "PSM Nom1"
		sTabRech  [41]	= "PSM_NOM2"						; sTabSubst [41] = "PSM Nom2"
		sTabRech  [42]	= "PSM_ADR1"						; sTabSubst [42] = "PSM Adresse1"	
		sTabRech  [43]	= "PSM_ADR2"						; sTabSubst [43] = "PSM Adresse2"		
		sTabRech  [44]	= "PSM_CP"							; sTabSubst [44] = "PSM Code Postal"			
		sTabRech  [45]	= "PSM_VILLE"						; sTabSubst [45] = "PSM Ville"				
		sTabRech  [46] = "LIVRAISON_PSM"					; sTabSubst [46] = "Livraison PSM"
		sTabRech  [47] = "DTE_RETOUR"					   ; sTabSubst [47] = "Date Retour"	// [VDOC9908]
		sTabRech  [48] = "SITE"							   ; sTabSubst [48] = "Site"	// [VDOC9908]
		sTabRech  [49] = "EN_RAPPORT_REPAR"			   ; sTabSubst [49] = "Panne en rapport avec la r$$HEX1$$e900$$ENDHEX$$paration"	// [PM222-1]
		sTabRech  [50] = "PEC_PRBLE_LIVRAISON"			; sTabSubst [50] = "Prise en charge probl$$HEX1$$e800$$ENDHEX$$me de livraison"	// [PM450-1]	
		sTabRech  [51] = "COLIS_PND"			   		; sTabSubst [51] = "Colis en PND (NPAI)"	// [PM246]		
		sTabRech  [52] = "COLIS_NRPAC"			   	; sTabSubst [52] = "Colis non r$$HEX1$$e900$$ENDHEX$$clam$$HEX2$$e9002000$$ENDHEX$$par le client"	// [PM246]			
		sTabRech  [53] = "COLIS_PERDU"			   	; sTabSubst [53] = "Colis perdu"	// [PM246]				
		sTabRech  [54] = "DTE_ARR_PLATFORM"				; sTabSubst [54] = "Date arriv$$HEX1$$e900$$ENDHEX$$e PlateForme Log."	// [PM250-1]				
		sTabRech  [55] = "DTE_ARR_CENTR_DISTRIB"		; sTabSubst [55] = "Date arriv$$HEX1$$e900$$ENDHEX$$e Centre Distrib."	// [PM250-1]				
		sTabRech  [56] = "DTE_DEP_CENTR_DISTRIB"		; sTabSubst [56] = "Date d$$HEX1$$e900$$ENDHEX$$part Centre Distrib."	// [PM250-1]					
		sTabRech  [57] = "DTE_RCP_MOB_CLI"				; sTabSubst [57] = "Date arriv$$HEX1$$e900$$ENDHEX$$e chez l'assur$$HEX1$$e900$$ENDHEX$$"	   // [PM250-1]					
		sTabRech  [58] = "CODE_ERREUR_LIVR"				; sTabSubst [58] = "Code Err. livraison"	   // [PM250-1]					
		sTabRech  [59] = "REMIS_EN_STK"					; sTabSubst [59] = "Mat$$HEX1$$e900$$ENDHEX$$riel remis en stock"	   // [PM251-2]						
		sTabRech  [60] = "CDV_CODETA"						; sTabSubst [60] = "Etat CDV"	   // [PM289_CDP]
		sTabRech  [61] = "EVE_CODETA"						; sTabSubst [61] = "Etat EVE"	   // [PM289_CDP]
		sTabRech  [62] = "ANO_CDP"							; sTabSubst [62] = "Anomalie"	   // [PM289_CDP]
		sTabRech  [63] = "FACT_PRESENTE"					; sTabSubst [63] = "Facture pr$$HEX1$$e900$$ENDHEX$$sente"	   // [DT141]	
		sTabRech  [64] = "MARQ_REMPL"						; sTabSubst [64] = "Marque Rempl."	   // [DT141]		
		sTabRech  [65] = "MODL_REMPL"						; sTabSubst [65] = "Mod$$HEX1$$e800$$ENDHEX$$le Rempl."	   // [DT141]			
		sTabRech  [66] = "MT_TTC_REMPL"					; sTabSubst [66] = "Mt TTC Rempl."	   // [DT141]			
		sTabRech  [67] = "TYPE_SWAP"						; sTabSubst [67] = "Type de swap"	   // [DT141]				
		sTabRech  [68] = "GEOLOC"						   ; sTabSubst [68] = "G$$HEX1$$e900$$ENDHEX$$olocalisation"   // [DT141]				
		sTabRech  [69] = "A_SUPP"						   ; sTabSubst [69] = "A supprimer"   // [DT150]					
		sTabRech  [70] = "SUPP"						   	; sTabSubst [70] = "Supprim$$HEX1$$e900$$ENDHEX$$e"   // [DT150]						
		sTabRech  [71] = "CHGT_CM"						  	; sTabSubst [71] = "Changement carte m$$HEX1$$e800$$ENDHEX$$re"   // [PM295-1]							
		sTabRech  [72] = "IFDNMQ_RET"					  	; sTabSubst [72] = "Info/Donn$$HEX1$$e900$$ENDHEX$$es Manquantes"   // [PM287-3]					
		sTabRech  [73] = "IFDNMQ_ACT"					  	; sTabSubst [73] = "Info/Donn$$HEX1$$e900$$ENDHEX$$es Action"   // [PM287-3]						
		sTabRech  [74] = "NO_BA"						   ; sTabSubst [74] = "N$$HEX2$$b0002000$$ENDHEX$$du/des bon(s) d'achat"   // [DT176]
		sTabRech  [75] = "COLIS_BALNI"					; sTabSubst [75] = "Boites aux lettres non identifiables"   	// [DT111]
		sTabRech  [76] = "COLIS_INCOR"					; sTabSubst [76] = "Adresse Incorrecte"   	// [DT111]
		sTabRech  [77] = "COLIS_REFUS"					; sTabSubst [77] = "Refus$$HEX2$$e9002000$$ENDHEX$$par client"   	// [DT111]
		sTabRech  [78] = "ANNUL_REFAIT"					; sTabSubst [78] = "Annul$$HEX2$$e9002000$$ENDHEX$$et refait"   	// [DT111]
		sTabRech  [79] = "A_CHARGE"						; sTabSubst [79] = "Contestation $$HEX2$$e0002000$$ENDHEX$$charge"   	// [PM280-2]
		sTabRech  [80] = "DECLASS_PCT"					; sTabSubst [80] = "Declassement %"   	// [PM280-2]	
		sTabRech  [81] = "MARQSW"							; sTabSubst [81] = "Marque Swap$$HEX1$$e900$$ENDHEX$$e"   	// [DT276]	
		sTabRech  [82] = "MODLSW"							; sTabSubst [82] = "Mod$$HEX1$$e800$$ENDHEX$$le Swap$$HEX1$$e900$$ENDHEX$$e"   	// [DT276]		
		sTabRech  [83] = "APP_SWAP"						; sTabSubst [83] = "Appareil swap$$HEX1$$e900$$ENDHEX$$"   	// [DT276]			
		sTabRech  [84] = "SWAP_AUTO_CTR"					; sTabSubst [84] = "Swap CTR"   	// [DT276] // [DT280]
		sTabRech  [85] = "SWAP_GSX"						; sTabSubst [85] = "Swap GSX"   	// [DT288]
		sTabRech  [86] = "REF_ORANGE"						; sTabSubst [86] = "Ref. Orange"   	// [DT288]	
		sTabRech  [87] = "NOTIF_REPA"						; sTabSubst [87] = "Notif. R$$HEX1$$e900$$ENDHEX$$pa"   	// [PC171933]		
		sTabRech  [88] = "NEUF_REC"						; sTabSubst [88] = "Neuf/Recond"	// [VDOC25657]
		sTabRech  [89] = "GRADE_REC"						; sTabSubst [89] = "Grade Recond."	// [VDOC25657]	
		sTabRech  [90] = "PROV_REC"						; sTabSubst [90] = "Prov. Recond."	// [VDOC25770]		
	
		// [VDoc26518]
		sTabRech  [91] = "Probl$$HEX1$$e800$$ENDHEX$$me de livraison : J1"	; sTabSubst [91] = "Probl$$HEX1$$e800$$ENDHEX$$me de livraison : Demande SPB , restitu$$HEX1$$e900$$ENDHEX$$e au client"
		sTabRech  [92] = "Probl$$HEX1$$e800$$ENDHEX$$me de livraison : J2"	; sTabSubst [92] = "Probl$$HEX1$$e800$$ENDHEX$$me de livraison : R$$HEX1$$e900$$ENDHEX$$par$$HEX1$$e900$$ENDHEX$$,restitu$$HEX2$$e9002000$$ENDHEX$$client"
		sTabRech  [93] = "Probl$$HEX1$$e800$$ENDHEX$$me de livraison : J3"	; sTabSubst [93] = "Probl$$HEX1$$e800$$ENDHEX$$me de livraison : Refus SAV,restitu$$HEX2$$e9002000$$ENDHEX$$au client"
		sTabRech  [94] = "Probl$$HEX1$$e800$$ENDHEX$$me de livraison : J4"	; sTabSubst [94] = "Probl$$HEX1$$e800$$ENDHEX$$me de livraison : Perte Produit par le PSM"
		sTabRech  [95] = "Probl$$HEX1$$e800$$ENDHEX$$me de livraison : J5"	; sTabSubst [95] = "Probl$$HEX1$$e800$$ENDHEX$$me de livraison : Perte Produit par le PSM"
		sTabRech  [96] = "Probl$$HEX1$$e800$$ENDHEX$$me de livraison : J6"	; sTabSubst [96] = "Probl$$HEX1$$e800$$ENDHEX$$me de livraison : Produit d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$exp$$HEX1$$e900$$ENDHEX$$di$$HEX2$$e9002000$$ENDHEX$$vers SPBS"
		// :[VDoc26518]
		
		sTabRech  [97] = "ACCORD_INDEM_PECU"			; sTabSubst [97] = "Accord Indemnistation p$$HEX1$$e900$$ENDHEX$$cuniaire"	// [DT363]			
		sTabRech  [98] = "TYP_BA_ALLER"					; sTabSubst [98] = "Type Tracking Aller"	// [PM445-1]				
		sTabRech  [99] = "BPPAYE"							; sTabSubst [99] = "Bon Pr$$HEX1$$e900$$ENDHEX$$Pay$$HEX1$$e900$$ENDHEX$$"	// [PM445-1]					
		sTabRech  [100] = "RPICKUP"						; sTabSubst [100] = "Relais PickUp"	// [PM445-1]						
		sTabRech  [101] = "PERTE_ALLER"					; sTabSubst [101] = "Perte Aller"	// [PM445-1]							
		sTabRech  [102] = "PRBLE_LIVRAISON"			   ; sTabSubst [102] = "Probl$$HEX1$$e800$$ENDHEX$$me de livraison"	// [PM246]	
		sTabRech  [103] = "TCH_BPP"			   		; sTabSubst [103] = "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement BPP"	// [DT398]	
	
		// [DT424]
		sTabRech  [104] = "DTE_1_UTIL_1"			  		; sTabSubst [104] = "Date 1$$HEX1$$e800$$ENDHEX$$re util(1)"	
		sTabRech  [105] = "DTE_DDU_1"			  			; sTabSubst [105] = "Date dern util(1)"		
		sTabRech  [106] = "IMSI_1"			  				; sTabSubst [106] = "Num carte SIM (IMSI)(1)"			
		sTabRech  [107] = "MSISDN_1"			  			; sTabSubst [107] = "Num ligne (MSISDN)(1)"				
		sTabRech  [108] = "PRENOM_CLI_1"			  		; sTabSubst [108] = "Pr$$HEX1$$e900$$ENDHEX$$nom client(1)"						
		sTabRech  [109] = "NOM_CLI_1"			  			; sTabSubst [109] = "Nom client(1)"					
		sTabRech  [110] = "DTE_1_UTIL_2"			  		; sTabSubst [110] = "Date 1$$HEX1$$e800$$ENDHEX$$re util(2)"	
		sTabRech  [111] = "DTE_DDU_2"			  			; sTabSubst [111] = "Date dern util(2)"		
		sTabRech  [112] = "IMSI_2"			  				; sTabSubst [112] = "Num carte SIM (IMSI)(2)"			
		sTabRech  [113] = "MSISDN_2"			  			; sTabSubst [113] = "Num ligne (MSISDN)(2)"				
		sTabRech  [114] = "PRENOM_CLI_2"			  		; sTabSubst [114] = "Pr$$HEX1$$e900$$ENDHEX$$nom client(2)"						
		sTabRech  [115] = "NOM_CLI_2"			  			; sTabSubst [115] = "Nom client(2)"					
		// /[DT424]
	
		// [RS4093_EVOL_ELD]
		sTabRech  [116] = "NUM_CC_ELD_RET"	  			; sTabSubst [116] = "Carte Cadeau Electro D$$HEX1$$e900$$ENDHEX$$p$$HEX1$$f400$$ENDHEX$$t"					
		sTabRech  [117] = "CODE_SECURITE"	  			; sTabSubst [117] = "code s$$HEX1$$e900$$ENDHEX$$curit$$HEX1$$e900$$ENDHEX$$"						
		// /[RS4093_EVOL_ELD]
	
		// [PMO139_RS4926]
		sTabRech  [118] = "DIAG_VIDEO_ENGAGE"	  		; sTabSubst [118] = "Diag vid$$HEX1$$e900$$ENDHEX$$o engag$$HEX1$$e900$$ENDHEX$$"							
		
		lTot = UpperBound ( sTabRech )
		For lCpt = 1 To lTot
			sInfoFrnSpbCplt = F_Remplace ( sInfoFrnSpbCplt, sTabRech  [lCpt], sTabSubst [lCpt] )
		Next
		
		aDwTrtCmdFrn.SetItem ( 1, "INFO_FRN_SPB_CPLT", sInfoFrnSpbCplt )
		
		// :FRN vers SPB
	End If	
End If


// #19  [20090914175511700]	
If sModif <> '' Then
	sModif = F_REMPLACE ( sModif, char(9), " " )
	aDwTrtCmdFrn.Modify ( sModif )
End If


end subroutine

public subroutine uf_getadresseo2mbase (long alidsin, string ascas, ref string asnomligne1, ref string asnomligne2, ref string asadrligne1, ref string asadrligne2, ref string ascp, ref string asville);//*-----------------------------------------------------------------
//* Fonction      : n_cst_cmd_commun::uf_GetAdresseO2MBase
//* Auteur        : FABRY JF
//* Date          : 28/04/2010
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Renvoi l'adresse O2M en fonction du contexte.
//* Commentaires  : [ADRESSE_O2M]
//*
//* Arguments     :    	alIdSin		Long		Val
//*					   	asCas			String	Val,
//*							asNomLigne1	String 	Ref,
//*							asNomLigne2	String 	Ref,
//*							asAdrLigne1	String 	Ref,
//*							asAdrLigne2	String 	Ref,
//*							asCP			String 	Ref,
//*							asVille		String 	Ref
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------

// D$$HEX1$$e900$$ENDHEX$$claration pour les appels
// String sNomLigne1, sNomLigne2, sAdrLigne1, sAdrLigne2, sCP, sVille	
// n_cst_cmd_commun	lnvCmdCommun
// lnvCmdCommun.uf_GetAdresseO2MBase ( lIdsin, sCas, sNomLigne1, sNomLigne2, sAdrLigne1, sAdrLigne2, sCP, sVille )

asNomLigne1	= Space ( 35 )
asNomLigne2	= Space ( 35 )
asAdrLigne1	= Space ( 35 )
asAdrLigne2	= Space ( 35 )
asCP			= Space ( 35 )
asVille		= Space ( 35 )

SQLCA.PS_S01_ADRESSE_O2M_V01 (alIdSin, asCas, asNomLigne1, asNomLigne2, asAdrLigne1, asAdrLigne2, asCP, asVille ) 

If IsNull ( asNomLigne1 ) Or Len ( asNomLigne1 ) <= 0 Then asNomLigne1 = ""
If IsNull ( asNomLigne2 ) Or Len ( asNomLigne2 ) <= 0 Then asNomLigne2 = ""
If IsNull ( asAdrLigne1 ) Or Len ( asAdrLigne1 ) <= 0 Then asAdrLigne1 = ""
If IsNull ( asAdrLigne2 ) Or Len ( asAdrLigne2 ) <= 0 Then asAdrLigne2 = ""
If IsNull ( asCP ) Or Len ( asCP ) <= 0 Then asCP = ""
If IsNull ( asVille ) Or Len ( asVille ) <= 0 Then asVille = ""

end subroutine

public subroutine uf_getadresseo2m_2 (string ascas, string asforcageidreffour, long alforcageprocess, string asforcagetypapp, string asforcagetypart, string asforcageetat, long alforcageidgti, string asforcagemodele, string asinfospbfrncplt, u_datawindow_detail adwcmdesin, u_datawindow adwwdivsin, datawindow adwdetpro, long alidprod, ref string asnomligne1, ref string asnomligne2, ref string asadrligne1, ref string asadrligne2, ref string ascp, ref string asville);//*////////////////////////////////////////////////////////////////-
//*
//* Fonction      : n_cst_cmd_commun::uf_GetAdresseO2M_2
//* Auteur        : FPI
//* Date          : 11/07/2014
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Renvoi l"adresse O2M en fonction du contexte.
//* Commentaires  : [VDOC14882] - MEP : recopier le code dans uf_GetAdresseO2M
//*
//* Arguments     :    	asCas			String	Val,
//*							asforcageidreffour  String val,
//*							alForcageProcess  Long Val,
//*							asForcageTypApp String Val,
//*							asForcageTypArt String Val,
//*							asForcageEtat  String val,
//*							alForcageIdGti	Long	Val,
//*							u_DataWindow_Detail	adwCmdeSin  Val,
//*							u_DataWindow	adwWDivsin  Val,
//*							Datawindow		adwDetPro
//*							Long				alIdprod		Val,
//*							asNomLigne1	String 	Ref,
//*							asNomLigne2	String 	Ref,
//*							asAdrLigne1	String 	Ref,
//*							asAdrLigne2	String 	Ref,
//*							asCP			String 	Ref,
//*							asVille		String 	Ref
//*
//* Retourne      : Rien
//*
//*       JFF  10/06/2010    [PC419/440/418/439_MICROMANIA]
//*       JFF  13/11/2012    [VDOC9057]
//			FPI	19/04/2013	[VDOC10610] Modif adresse O2M
//			FPI	14/06/2013	[VDOC11407] Modif adresse O2M
//*       JFF  24/07/2013    [MANTIS8246][PC938]
//		FPI 11/07/2014		 [VDOC14882] Refonte de la m$$HEX1$$e900$$ENDHEX$$thode
//		FPI 05/09/2014		[VDoc15221] On ne change pas le CP
//       JFF   04/11/2014 [PM280-1]
//       JFF   18/11/2014 [VDOC15981]
//       JFF   06/05/2015 [PM280-1][MANTIS15144]
//       JFF   17/05/2016 [PM280-2]
//       JFF   23/05/2018 [PM280-2][V3] bCasSPB5A
//       JFF   04/01/2019 [PM280-2] suite mail Emm. Olivier le 04/01/19, CONTEST_SUR_REMPL devient SPB 5 et non plus SPB5A
//       JFF   27/10/2021 [RS1218-RS1259-ADRO2M]
//       JFF   05/07/2022 [RS3337]
//*////////////////////////////////////////////////////////////////-

Long lRow, lDeb, lFin
Boolean bCasSPB1, bCasSPB4, bCasSPB2, bTrouve, bCasIPad, bARepGarantie, bCasHorsTel, bCasSPB5, bCasSPB5A
n_cst_string lnvPFCString
String sLettreCatg 

If IsNull ( asNomLigne1 ) Or Len ( asNomLigne1 ) <= 0 Then asNomLigne1 = ""
If IsNull ( asNomLigne2 ) Or Len ( asNomLigne2 ) <= 0 Then asNomLigne2 = ""
If IsNull ( asAdrLigne1 ) Or Len ( asAdrLigne1 ) <= 0 Then asAdrLigne1 = ""
If IsNull ( asAdrLigne2 ) Or Len ( asAdrLigne2 ) <= 0 Then asAdrLigne2 = ""
If IsNull ( asCP ) Or Len ( asCP ) <= 0 Then asCP = ""
If IsNull ( asVille ) Or Len ( asVille ) <= 0 Then asVille = ""

bTrouve=FALSE
bCasIPad=FALSE
bCasHorsTel=FALSE

// Adresse r$$HEX2$$e900e900$$ENDHEX$$lle, standard, compl$$HEX1$$e800$$ENDHEX$$te
If asCas = "COMPLETE" Then

// [RS3337]
asNomLigne1	= "LOXY"
asAdrLigne1	= "21-23 Rue Saint-Hilaire" 
asAdrLigne2 = "Saint-Ouen l'Aum$$HEX1$$f400$$ENDHEX$$ne" 
asCP        = "95041" 
asVille	   = "CERGY-PONTOISE CEDEX 1"

	Return
End If

// Partie commune aux formats particulier
// [RS1218-RS1259-ADRO2M]
// [RS3337]
asNomLigne1	= "LOXY"
asAdrLigne1	= "21-23 Rue Saint-Hilaire" 
asAdrLigne2 = "Saint-Ouen l'Aum$$HEX1$$f400$$ENDHEX$$ne" 
asCP        = "95041" 
asVille	   = "CERGY-PONTOISE CEDEX 1"

lRow=0

// [VDOC9057]
If IsNull ( asforcageidreffour ) Or Len ( asforcageidreffour ) = 0 Then
	lRow = adwCmdeSin.Find( "ID_FOUR = 'O2M' AND ID_TYP_ART IN ( 'EDI', 'PRS') AND COD_ETAT IN ( 'CNV', 'ECT')", 1, adwCmdeSin.RowCount() ) 
	If lRow > 0 Then
		asforcageidreffour = adwCmdeSin.GetItemString ( lRow, "ID_REF_FOUR" )
	End If
End If	
// [VDOC9057]

If IsNull ( asForcageTypApp ) Or Len ( asForcageTypApp ) = 0 Then
	lRow = adwWDivsin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, adwWDivSin.RowCount () ) 
	If lRow > 0 Then
		asForcageTypApp = Upper ( Trim ( adwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) 
	End IF
End If

If IsNull ( alForcageProcess ) Or alForcageProcess <= 0 Then
	lRow = adwCmdeSin.Find( "ID_FOUR = 'O2M' AND ID_TYP_ART IN ( 'EDI', 'PRS') AND COD_ETAT IN ( 'CNV', 'ECT')", 1, adwCmdeSin.RowCount() ) 
	If lRow > 0 Then
		alForcageProcess = adwCmdeSin.GetItemNumber ( lRow, "INFO_SPB_FRN" )
	End If
End If

If IsNull ( asForcageEtat ) Or Len ( asForcageEtat ) = 0 Then
	lRow = adwCmdeSin.Find( "ID_FOUR = 'O2M' AND ID_TYP_ART IN ( 'EDI', 'PRS') AND COD_ETAT IN ( 'CNV', 'ECT')", 1, adwCmdeSin.RowCount() ) 
	If lRow > 0 Then
		asForcageEtat = adwCmdeSin.GetItemString ( lRow, "COD_ETAT" )
	End If 
End If

If IsNull ( asForcageTypArt ) Or Len ( asForcageTypArt ) = 0 Then
	lRow = adwCmdeSin.Find( "ID_FOUR = 'O2M' AND ID_TYP_ART IN ( 'EDI', 'PRS') AND COD_ETAT IN ( 'CNV', 'ECT')", 1, adwCmdeSin.RowCount() ) 
	If lRow > 0 Then
		asForcageTypArt = adwCmdeSin.GetItemString ( lRow, "ID_TYP_ART" )
	End If 
End If

If IsNull ( asInfoSpbFrnCplt ) Or Len ( asInfoSpbFrnCplt ) = 0 Then
	lRow = adwCmdeSin.Find( "ID_FOUR = 'O2M' AND ID_TYP_ART IN ( 'EDI', 'PRS') AND COD_ETAT IN ( 'CNV', 'ECT')", 1, adwCmdeSin.RowCount() ) 
	If lRow > 0 Then
		asInfoSpbFrnCplt = adwCmdeSin.GetItemString ( lRow, "INFO_SPB_FRN_CPLT" )
	End If 
End If


If asForcageTypArt="PRS" Then
	
	If IsNull ( asForcageModele ) Or Len ( asForcageModele ) = 0 Then
		If lRow=0 Then lRow=1
		If Left(adwCmdeSin.GetItemString(lRow,"ID_MODL_ART"),4) = "IPAD" Then bCasIPad=TRUE
	Else
		bCasIPad=( Left(asForcageModele,4) = "IPAD" )
	End if
	
End if

If IsNull ( alForcageIdGti ) Or alForcageIdGti <= 0 Then
	lRow = adwCmdeSin.Find( "ID_FOUR = 'O2M' AND ID_TYP_ART IN ( 'EDI', 'PRS') AND COD_ETAT IN ( 'CNV', 'ECT')", 1, adwCmdeSin.RowCount() ) 
	If lRow > 0 Then
		alForcageIdGti = adwCmdeSin.GetItemNumber ( lRow, "ID_GTI" )
	End If
End If

// [PM280-1]
sLettreCatg = ""
sLettreCatg =  SQLCA.FN_CODE_CAR ( asForcageTypApp, "-AT" )
If IsNull ( sLettreCatg ) Then sLettreCatg = ""

// [VDOC15981]
 bCasHorsTel = asForcageTypApp <> "TEL"

// SPB 1
// [VDOC9057]
// [MANTIS8246][PC938]
bCasSPB1 = 	( &
				  ( asForcageTypApp = "TEL" And &
				    asForcageTypArt = "EDI" And &
				    asforcageidreffour = "A_DIAGNOSTIQUER" ) &
				 Or &
				  ( asForcageTypArt = "REA" ) &
				) &				  
				And &
				( asForcageEtat = "CNV" OR asForcageEtat = "ECT" )
If bCasSPB1 Then
	asNomLigne1 = "SPB 1"
	bTrouve=TRUE
End If

// [PM280-1][MANTIS15144]
bCasSPB5 = 	asForcageTypArt = "PRS" And &
				lnvPFCString.of_getkeyvalue (asInfoSpbFrnCplt, "A_REP_GARANTIE", ";") = "OUI" And &
				( asForcageEtat = "CNV" OR asForcageEtat = "ECT" )
If bCasSPB5 And (not bTrouve) Then
	asNomLigne1 = "SPB 5"
	bTrouve=TRUE
End If

// [PM280-2][V3]
bCasSPB5A = 	( asforcageidreffour = "CONTEST_SUR_REMPL" ) &
				And &
				( asForcageEtat = "CNV" OR asForcageEtat = "ECT" )
				
If bCasSPB5A And (not bTrouve) Then
	asNomLigne1 = "SPB 5"
	bTrouve=TRUE
End If

// SPB 4	
// [VDOC9057]
bCasSPB4 = 	asForcageTypArt = "PRS" And &
				( asForcageEtat = "CNV" OR asForcageEtat = "ECT" )
		
If bCasSPB4 And (not bTrouve) Then
	asNomLigne1 = "SPB 4"

	// [VDOC15981]
	If bCasHorsTel Then asNomLigne1 = "SPB 8"
	
	bTrouve=TRUE
End If

// SPB 2
// [PC419/440/418/439_MICROMANIA] ajout gti 15
// [VDOC9057]
bCasSPB2 = 	asForcageTypArt = "EDI" And &
				asforcageidreffour = "A_DIAGNOSTIQUER" And &					
				( alForcageIdGti = 18 Or alForcageIdGti = 15 ) And &
				( asForcageEtat = "CNV" OR asForcageEtat = "ECT" )

If bCasSPB2 And (not bTrouve) Then
	asNomLigne1 = "SPB 2"
	bTrouve=TRUE
End If

// SPB 3 (D$$HEX1$$e900$$ENDHEX$$faut)
If not bTrouve Then asNomLigne1 = "SPB 3"

// [PM280-1]
asNomLigne1 += sLettreCatg 

// Affectation de l'adresse
// [PM280-1] ajout du LEFT , 5
// [RS3337]
asNomLigne1	= "LOXY - " + asNomLigne1
asAdrLigne1	= "21-23 Rue Saint-Hilaire" 
asAdrLigne2 = "Saint-Ouen l'Aum$$HEX1$$f400$$ENDHEX$$ne" 
asCP        = "95041" 
asVille	   = "CERGY-PONTOISE CEDEX 1"

end subroutine

on n_cst_cmd_commun.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_cmd_commun.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

