HA$PBExportHeader$u_gs_sp_cree_wkf.sru
$PBExportComments$---} User Object anc$$HEX1$$ea00$$ENDHEX$$tre pour la gestion permettant d'armer iTrTrans et dw_1 en instance.
forward
global type u_gs_sp_cree_wkf from u_gs_sp_cree_wkf_anc
end type
end forward

global type u_gs_sp_cree_wkf from u_gs_sp_cree_wkf_anc
end type
global u_gs_sp_cree_wkf u_gs_sp_cree_wkf

type variables
Private :
	DataWindow		idw_Inter
	DataWindow		idw_Routage
	DataWindow		idw_Sinistre

	DataWindow		idw_Edms_Sri_Ref_Facturation
	DataWindow		idw_Edms_Sri_Lig_Facturation

	DataWindow		idw_Edms_Clx_Adh
	DataWindow		idw_Edms_Pxxx_Adh
	DataWindow		idw_Edms_Cic_Adh
	DataWindow		idw_Edms_Sri_Adh
	DataWindow		idw_Edms_Tel_Adh

	DataWindow		idw_Edms_Clx_Mvts
	DataWindow		idw_Edms_Pxxx_Mvts
	DataWindow		idw_Edms_Cic_Mvts
	DataWindow		idw_Edms_Sri_Mvts
	DataWindow		idw_Edms_Tel_Mvts

	DataWindow		idw_SinistresLies

	DataWindow		idw_Homonyme

	DataWindow		idw_OptionAdh

	DataWindow		idw_Adh
	DataWindow		idw_Mvts

	DataWindow		idw_DosSuiviPar

	Transaction		itrEdms

	Boolean			ibInitClx
	Boolean			ibInitPxxx
	Boolean			ibInitCic
	Boolean			ibInitSri
	Boolean			ibInitTel

	Boolean			ibSinLie
	Boolean			ibWorkFlow_En_Consult
	Boolean			ibAltContact

	String			isFicTrace
	String			isFicTraceAdr
	String			isFicTraceSin
	String			isFicEssaiTrc
	String			isNomMachine
//	String			isRepWindows

	DateTime			idtDebutSaisie

	String			isBoutonRac	
	String			isCadrageActuel

end variables

forward prototypes
public subroutine uf_traitement (integer aitype, ref s_pass astpass)
private subroutine uf_initialiserfenetre ()
private subroutine uf_preparerinserer (ref s_pass astpass)
private subroutine uf_tb_codtyprecu ()
private subroutine uf_tb_codrecu ()
private subroutine uf_zn_idi ()
private subroutine uf_zn_idprod ()
private subroutine uf_zn_idets ()
private subroutine uf_recuperer_sinistres_lies (ref s_pass astpass)
private subroutine uf_fin_sinistres_lies (ref s_pass astpass)
private subroutine uf_controlersaisie (ref s_pass astpass)
private function date uf_cast_dte_edms (decimal adcdte)
private function integer uf_ctrl_courcli_recu ()
private function integer uf_ctrl_courcli_surv ()
private function integer uf_ctrl_recu_surv ()
private function long uf_verifier_adhesion_edms ()
private subroutine uf_ecriretrace ()
private subroutine uf_ecriretrace_adresse ()
private subroutine uf_edms_dteresil ()
private subroutine uf_edms_dtefingti ()
private function long uf_edms_dteadh (decimal adcdteembauc, decimal adcdteadh)
private subroutine uf_gestion_str2nul ()
private function date uf_calcul_periode_edms (boolean absecurilion, decimal adcmvts, decimal adcnbmois)
private subroutine uf_positionner_ligneproduit ()
private function long uf_verifier_adhesion_edms_cplt ()
public subroutine uf_initialiser_dw_desc (ref datawindow adw_norm[])
public subroutine uf_gestion_contacts (string asidcorb, long alidsin)
private function boolean uf_recherche_produit (ref long allig, ref string ascodadh, ref long alcodbasedms, ref long alcodproddms, ref long alcodadrdms, ref long alnbadherent, ref long alCodTel)
private subroutine uf_edms_telephonie (long alcodtel, long alcodproddms)
private subroutine uf_recadrer_grille (string ascas)
private subroutine uf_visu_telephonie (boolean abswitch)
private subroutine uf_tb_telephonie (integer alcodtel, boolean abswitchnull, boolean abswitchtoujoursproteger)
private function long uf_zn_codtyprecu ()
private function long uf_zn_codrecu ()
private function integer uf_zn_idsin ()
private function long uf_zn_idadh (ref s_pass astpass)
private function long uf_zn_idsdos (ref s_pass astpass)
private function long uf_zn_dtecourcli ()
private function long uf_zn_dtesurv ()
private function long uf_zn_dterecu ()
private function long uf_zn_altadr ()
private subroutine uf_valider (ref s_pass astpass)
public function long uf_zn_trt (ref s_pass astpass)
end prototypes

public subroutine uf_traitement (integer aitype, ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Traitement (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:29:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Integer		aiType			(Val)	Type de traitement 
//*					  s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Choose Case aiType
Case 1					// INITIALISATION		(Ue_Initialiser de la fen$$HEX1$$ea00$$ENDHEX$$tre)
	Uf_InitialiserFenetre ()

Case 2					// INSERTION			(Wf_PreparerInserer)
	Uf_PreparerInserer ( astPass )

Case 4					// CONTROLE SAISIE	(Wf_ControlerSaisie) + (Wf_ControlerGestion)
	Uf_ControlerSaisie 	( astPass )

Case 7					// VALIDER	(Wf_Valider) ( La fonction anc$$HEX1$$ea00$$ENDHEX$$tre est totalement r$$HEX2$$e900e900$$ENDHEX$$crite. )
	Uf_Valider ( astPass )

Case 8					// CAS PARTICULIER	(Appel sur l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement Ue_Sinistres_Lies)
	Uf_Fin_Sinistres_Lies ( astPass )

End Choose



end subroutine

private subroutine uf_initialiserfenetre ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Travail::Uf_InitialiserFenetre (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de cr$$HEX1$$e900$$ENDHEX$$ation d'un travail
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1 DGA              19/09/2006              Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire DCMP-060643
//*-----------------------------------------------------------------

DataWindowChild		dwChild

//u_DeclarationFuncky uoDeclarationFuncky //[I037] Migration FUNCKy

String sRep, sFic

String sCol[ 30 ]

/*------------------------------------------------------------------*/
/* On initialise l'objet de transaction de dw_wTravail.             */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La DW est une External, mais on a besoin d'initialiser l'objet   */
/* de transaction.                                                  */
/*------------------------------------------------------------------*/
idw_wTravail.Uf_SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les DDDW qui ne changent jamais.                     */
/* Colonnes COD_CIV, ID_PROD, COD_I_PROV, ID_ETS.                   */
/*------------------------------------------------------------------*/
idw_wTravail.GetChild ( "COD_CIV", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-CI", "-CL" )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la liste de tous les produits.                       */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le 12/01/1999                                                    */
/* On filtre la liste des produits en fonction des droits de        */
/* l'op$$HEX1$$e900$$ENDHEX$$rateur sur CORB_OPER.                                       */
/*------------------------------------------------------------------*/
idw_wTravail.GetChild ( "ID_PROD", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( stGLB.sCodOper )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la liste des types d'interlocuteurs.                 */
/*------------------------------------------------------------------*/
idw_wTravail.GetChild ( "COD_I_PROV", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ( "-IN" )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la liste de tous les $$HEX1$$e900$$ENDHEX$$tablissement (Tous les         */
/* produits) avec ID_REV = -1.                                      */
/*------------------------------------------------------------------*/
idw_wTravail.GetChild ( "ID_ETS", dwChild )
dwChild.SetTransObject ( This.itrTrans )
dwChild.Retrieve ()

/*------------------------------------------------------------------*/
/* On s'occupe des colonnes qui peuvent changer de couleur, en      */
/* fonction de la saisie.                                           */
/*------------------------------------------------------------------*/
sCol [  1 ] = "DTE_COUR_CLI"
sCol [  2 ] = "DTE_RECU"
sCol [  3 ] = "NB_PAGE"
sCol [  4 ] = "ID_SIN"
sCol [  5 ] = "ID_I"
sCol [  6 ] = "COD_I_PROV"
sCol [  7 ] = "ID_PROD"
sCol [  8 ] = "DTE_ADH"
sCol [  9 ] = "ID_ETS"
sCol [ 10 ] = "DTE_SURV"
sCol [ 11 ] = "ID_ADH"
sCol [ 12 ] = "DTE_RESIL"
sCol [ 13 ] = "ID_SDOS"
sCol [ 14 ] = "COD_CIV"
sCol [ 15 ] = "NOM"
sCol [ 16 ] = "PRENOM"
sCol [ 17 ] = "ADR_1"
sCol [ 18 ] = "ADR_2"
sCol [ 19 ] = "ADR_CP"
sCol [ 20 ] = "ADR_VILLE"
sCol [ 21 ] = "NUM_TELD"
sCol [ 22 ] = "NUM_TELB"
sCol [ 23 ] = "NUM_FAX"
sCol [ 24 ] = "NUM_PORT"
sCol [ 25 ] = "NUM_IMEI_PORT"
sCol [ 26 ] = "MARQ_PORT"
sCol [ 27 ] = "MODL_PORT"
sCol [ 28 ] = "DTE_ACH_PORT"
sCol [ 29 ] = "DTE_OUVLIG_PORT"
sCol [ 30 ] = "TXT_MESS1"

idw_wTravail.Uf_InitialiserCouleur ( sCol )

/*------------------------------------------------------------------*/
/* Par d$$HEX1$$e900$$ENDHEX$$faut, la derni$$HEX1$$e800$$ENDHEX$$re colonne saisissable de dw_wTravail est   */
/* TXT_MESS1 et la premi$$HEX1$$e800$$ENDHEX$$re est COD_TYP_RECU.                       */
/*------------------------------------------------------------------*/
idw_wTravail.ilDernCol = 4					// Zne TXT_MESS1
idw_wTravail.ilPremCol = 8					// Zne COD_TYP_RECU

/*------------------------------------------------------------------*/
/* Par d$$HEX1$$e900$$ENDHEX$$faut, on ne positionne pas les objets de transaction sur   */
/* les DW en rapport avec les adh$$HEX1$$e900$$ENDHEX$$sion EDMS. Cela permet de         */
/* continuer $$HEX2$$e0002000$$ENDHEX$$fonctionner, pour les compl$$HEX1$$e900$$ENDHEX$$ments et les             */
/* d$$HEX1$$e900$$ENDHEX$$clarations, sans liaison avec EDMS. L'initialisation des DW    */
/* sera r$$HEX1$$e900$$ENDHEX$$alis$$HEX1$$e900$$ENDHEX$$e au coup par coup.                                  */
/*------------------------------------------------------------------*/
ibInitClx		= False
ibInitPxxx		= False
ibInitCic		= False


/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re maintenant le nom de la machine. On part du principe */
/* que ce nom est positionn$$HEX2$$e9002000$$ENDHEX$$dans la valeur Dos (SQL=XXX)           */
/*------------------------------------------------------------------*/
//uoDeclarationFuncky = Create u_DeclarationFuncky
//isNomMachine = uoDeclarationFuncky.Uf_GetEnv ( "SQL" )
isNomMachine = stGLB.uoWin.uf_getenvironment( "SQL" )
//Migration PB8-WYNIWYG-03/2006 FM
//Destroy uoDeclarationFuncky
//If IsValid(uoDeclarationFuncky) Then Destroy uoDeclarationFuncky
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* On initialise maintenant le nom du fichier de TRACE au format    */
/* JJMMAAAA.App (App correspond au code de l'application).          */
/* Pour connaitre le r$$HEX1$$e900$$ENDHEX$$pertoire qui contient le fichier de TRACE,   */
/* il faut lire la section TRACE du fichier INI de l'application.   */
/*------------------------------------------------------------------*/
sRep = ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE_C", "" )
isFicTrace = sRep + String ( Today (), "ddmmyyyy" ) + "." + Left ( stGLB.sCodAppli, 3 )

/*------------------------------------------------------------------*/
/* Le nom du fichier de trace pour la modifications des adresses.   */
/*------------------------------------------------------------------*/
sRep = ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE_ADR", "" )
isFicTraceAdr = sRep + String ( Today (), "ddmmyyyy" ) + "." + Left ( stGLB.sCodAppli, 3 )

/*------------------------------------------------------------------*/
/* Le nom du fichier de trace pour l'essai d'$$HEX1$$e900$$ENDHEX$$criture.              */
/*------------------------------------------------------------------*/
sRep				= ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE_C", "Erreur" )
isFicEssaiTrc	= sRep + stGLB.sCodOper + String ( Today (), "ddmm" ) + ".TMP"

/*----------------------------------------------------------------------------*/
/* Armement du nom du rep win                                                 */
/*----------------------------------------------------------------------------*/
//uoDeclarationFuncky	= Create u_DeclarationFuncky 
//isRepWindows 			= uoDeclarationFuncky.Uf_WinDir () //[I037] Migration FUNCKy : Variable inutilis$$HEX1$$e900$$ENDHEX$$e
//Migration PB8-WYNIWYG-03/2006 FM
//Destroy uoDeclarationFuncky
//If IsValid(uoDeclarationFuncky) Then Destroy uoDeclarationFuncky
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*----------------------------------------------------------------------------*/
/* Populisation de la DDDW des utilisateurs.                                  */
/*----------------------------------------------------------------------------*/
idw_DosSuiviPar.GetChild ( "DOS_SUIVI_PAR", dwChild )
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sFic = isRepWindows + "\TEMP\OPER" + stGlb.sCodAppli + ".TXT"
sFic = stGLB.sRepTempo + "OPER" + stGlb.sCodAppli + ".TXT"

//Migration PB8-WYNIWYG-03/2006 FM
//If FileExists ( sFic ) Then 
If f_FileExists ( sFic ) Then 
//Fin Migration PB8-WYNIWYG-03/2006 FM
	dwChild.Reset ()
	dwChild.ImportFile ( sFic )
End If

/*----------------------------------------------------------------------------*/
/* On cache les zones de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie par d$$HEX1$$e900$$ENDHEX$$faut											*/
/*----------------------------------------------------------------------------*/
This.Uf_Visu_Telephonie (FALSE)



end subroutine

private subroutine uf_preparerinserer (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_PreparerInserer (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Insertion d'un nouveau travail
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Boolean bRet

String sFiltre

DataWindowChild dwChild, dwChild1

bRet 			= True

ibAltContact = False
iDw_DosSuiviPar.Hide ()
isBoutonRac = astPass.sTab [3]
uf_Tb_Telephonie ( 0, TRUE, FALSE )

/*----------------------------------------------------------------------------*/
/* Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre poru la gestion par T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phone ou normale.          */
/*----------------------------------------------------------------------------*/
CHOOSE CASE isBoutonRac 
	CASE "TEL"
		idw_wTravail.Modify ( "cod_recu.visible = 0 cod_typ_recu.visible = 0" )
		idw_wTravail.Modify ( "t_cod_recu.visible = 1 t_cod_typ_recu.visible = 1" )

		idw_wTravail.SetItem ( 1, "COD_RECU", "T" )
		idw_wTravail.SetColumn ( "COD_RECU" )
		idw_wTravail.isNomCol = "COD_RECU" 
		idw_wTravail.TriggerEvent ( "ItemChanged" )

		idw_wTravail.SetItem ( 1, "COD_TYP_RECU", "D" )
		idw_wTravail.SetColumn ( "COD_TYP_RECU" )
		idw_wTravail.isNomCol = "COD_TYP_RECU" 
		idw_wTravail.TriggerEvent ( "ItemChanged" )

	CASE "COURRIER", "TOUT"
		idw_wTravail.Modify ( "cod_recu.visible = 1 cod_typ_recu.visible = 1" )
		idw_wTravail.Modify ( "t_cod_recu.visible = 0 t_cod_typ_recu.visible = 0" )


END CHOOSE


/*------------------------------------------------------------------*/
/* On g$$HEX1$$e900$$ENDHEX$$re les TabOrder.                                            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La colonne COD_TYP_RECU et COD_RECU sont initialis$$HEX1$$e900$$ENDHEX$$es            */
/* automatiquement lors d'une insertion. Les fonctions de TabOrder  */
/* permettent de positionner correctement la DW de saisie.          */
/*------------------------------------------------------------------*/
Uf_Tb_CodTypRecu ()
Uf_Tb_CodRecu ()

/*------------------------------------------------------------------*/
/* Je filtre la DW sur ID_ETS pour ne faire appara$$HEX1$$ee00$$ENDHEX$$tre aucune       */
/* ligne dans la zone. La zone ID_ETS est fonction de la valeur     */
/* saisie dans ID_PROD.                                             */
/*------------------------------------------------------------------*/
idw_wTravail.GetChild ( "ID_ETS", dwChild )
sFiltre = "ID_PROD = 99999"
dwChild.SetFilter ( sFiltre )
dwChild.Filter ()

/*------------------------------------------------------------------*/
/* On initialise les DDDW des autres DataWindow. On essaye de       */
/* faire un ShareData dans la mesure du possible.                   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Table INTER. (COD_CIV)                                           */
/*------------------------------------------------------------------*/
idw_wTravail.GetChild ( "COD_CIV", dwChild )
idw_Inter.GetChild ( "COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* Sinistres Li$$HEX1$$e900$$ENDHEX$$s. (COD_CIV)                                        */
/*------------------------------------------------------------------*/
idw_wTravail.GetChild ( "COD_CIV", dwChild )
idw_SinistresLies.GetChild ( "COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* Gestion des Homonymes. (COD_CIV)                                 */
/*------------------------------------------------------------------*/
idw_wTravail.GetChild ( "COD_CIV", dwChild )
idw_Homonyme.GetChild ( "COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )


idw_wTravail.SetColumn ( idw_wTravail.ilPremCol )

/*------------------------------------------------------------------*/
/* On remet la DW servant au stockage des sinistres li$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$vide.    */
/*------------------------------------------------------------------*/
idw_SinistresLies.Reset ()

/*------------------------------------------------------------------*/
/* On remet la DW sur routage $$HEX2$$e0002000$$ENDHEX$$vide.                               */
/*------------------------------------------------------------------*/
idw_Routage.Reset ()

/*------------------------------------------------------------------*/
/* La DW external servant au stockage des coordonn$$HEX1$$e900$$ENDHEX$$es de l'adh$$HEX1$$e900$$ENDHEX$$sion */
/* est remise $$HEX2$$e0002000$$ENDHEX$$vide.                                               */
/*------------------------------------------------------------------*/
idw_Adh.Reset ()
idw_Mvts.Reset ()

/*------------------------------------------------------------------*/
/* On bascule le focus sur le 1er Onglet (DataWindow de TRAVAIL)    */
/* par d$$HEX1$$e900$$ENDHEX$$faut.                                                      */
/*------------------------------------------------------------------*/
iuoOng.Uf_ChangerOnglet ( "01" )
iuoOng.Uf_ActiverOnglet ( "02", False )

/*------------------------------------------------------------------*/
/* On initialise un DateTime de d$$HEX1$$e900$$ENDHEX$$but pour savoir combien de temps  */
/* repr$$HEX1$$e900$$ENDHEX$$sente la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail.                             */
/*------------------------------------------------------------------*/
idtDebutSaisie = DateTime ( Today (), Now () )
		
astPass.bRetour = bRet


end subroutine

private subroutine uf_tb_codtyprecu ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Tb_CodTypRecu (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 17:35:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des TabOrder pour le type de d$$HEX1$$e900$$ENDHEX$$claration
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//* DCMP990451	JFF		29/09/99 Affichage du message d'ouverture de 
//*										de pochette				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Cette fonction concerne les zones suivantes :                    */
/* COD_I_PROV, ID_PROD, ID_ETS, ID_ADH, ID_SDOS,                    */
/* DTE_SURV, ALT_ADR, COD_CIV, NOM, PRENOM, ADR_1, ADR_2, ADR_CP,   */
/* ADR_VILLE, NUM_TELD, NUM_TELB, NUM_FAX.                          */
/*------------------------------------------------------------------*/

String sCol[ 17 ]
Boolean	bProtectTel
String sCodTypRecu

DateTime dDteCourCli // [PI056] date -> datetime

sCol[  1 ] = "COD_I_PROV"
sCol[  2 ] = "ID_PROD"
sCol[  3 ] = "ID_ETS"
sCol[  4 ] = "ID_ADH"
sCol[  5 ] = "ID_SDOS"
sCol[  6 ] = "DTE_SURV"
sCol[  7 ] = "ALT_ADR"
sCol[  8 ] = "COD_CIV"
sCol[  9 ] = "NOM"
sCol[ 10 ] = "PRENOM"
sCol[ 11 ] = "ADR_1"
sCol[ 12 ] = "ADR_2"
sCol[ 13 ] = "ADR_CP"
sCol[ 14 ] = "ADR_VILLE"
sCol[ 15 ] = "NUM_TELD"
sCol[ 16 ] = "NUM_TELB"
sCol[ 17 ] = "NUM_FAX"

sCodTypRecu = idw_wTravail.GetItemString ( 1, "COD_TYP_RECU" )

/*------------------------------------------------------------------*/
/* On arme toutes les zones $$HEX2$$e0002000$$ENDHEX$$NULL pour ne pas r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer de la      */
/* merde au cas ou le gestionnaire fasse joujou avec la zone.       */
/*------------------------------------------------------------------*/
idw_wTravail.SetItem ( 1, "ID_PROD", 		stNul.dcm )
idw_wTravail.SetItem ( 1, "ID_ETS", 		stNul.dcm )
idw_wTravail.SetItem ( 1, "ID_ADH", 		stNul.str )
idw_wTravail.SetItem ( 1, "ID_SDOS", 		stNul.dcm )
idw_wTravail.SetItem ( 1, "DTE_SURV", 		stNul.dat )

idw_wTravail.SetItem ( 1, "ALT_ADR", 		"N" )
idw_wTravail.SetItem ( 1, "COD_CIV", 		stNul.str )
idw_wTravail.SetItem ( 1, "NOM",		 		stNul.str )
idw_wTravail.SetItem ( 1, "PRENOM", 		stNul.str )
idw_wTravail.SetItem ( 1, "ADR_1", 			stNul.str )
idw_wTravail.SetItem ( 1, "ADR_2", 			stNul.str )
idw_wTravail.SetItem ( 1, "ADR_CP", 		stNul.str )
idw_wTravail.SetItem ( 1, "ADR_VILLE", 	stNul.str )
idw_wTravail.SetItem ( 1, "NUM_TELD", 		stNul.str )
idw_wTravail.SetItem ( 1, "NUM_TELB", 		stNul.str )
idw_wTravail.SetItem ( 1, "NUM_FAX", 		stNul.str )

idw_wTravail.SetItem ( 1, "ID_SIN", 		stNul.dcm )
idw_wTravail.SetItem ( 1, "ID_I", 			stNul.dcm )
idw_wTravail.SetItem ( 1, "COD_I_PROV",	stNul.str )
idw_wTravail.ClearValues ( "ID_I" )

idw_wTravail.SetItem ( 1, "OPTION", 		stNul.dcm )
idw_wTravail.SetItem ( 1, "DTE_ADH", 		stNul.dat )
idw_wTravail.SetItem ( 1, "DTE_FIN_GTI", 	stNul.dat )
idw_wTravail.SetItem ( 1, "DTE_RESIL", 	stNul.dat )
idw_wTravail.SetItem ( 1, "ID_CORB", 		stNul.dcm )

idw_wTravail.SetItem ( 1, "ID_ORDRE", 		stNul.dcm )
idw_wTravail.SetItem ( 1, "COD_PROV_PERS","W" )
ibSinLie	= False

idw_wTravail.SetItem ( 1, "TXT_MESS1",		stNul.str )

/*------------------------------------------------------------------*/
/* On reinitialise les DW servant au stockage des informations      */
/* relatives $$HEX2$$e0002000$$ENDHEX$$l'adh$$HEX1$$e900$$ENDHEX$$sion et aux mouvements financiers.             */
/*------------------------------------------------------------------*/
idw_Adh.Reset ()
idw_Mvts.Reset ()

Choose Case sCodTypRecu
Case "D"

	bProtectTel = FALSE
/*------------------------------------------------------------------*/
/* S'il s'agit d'une d$$HEX1$$e900$$ENDHEX$$claration, on arme que certaines zones, en   */
/* effet les autres d$$HEX1$$e900$$ENDHEX$$pendent du type d'adh$$HEX1$$e900$$ENDHEX$$sion. Elles seront      */
/* positionn$$HEX1$$e900$$ENDHEX$$es sur la zone ID_PROD.                                */
/*------------------------------------------------------------------*/
	idw_wTravail.Uf_Proteger ( sCol, "0" )
	idw_wTravail.Uf_Proteger ( { "ID_SIN", "ID_I", "DTE_ADH", "DTE_RESIL", "ALT_ADR" }, "1" )

	If	idw_wTravail.GetItemString ( 1, "COD_RECU" ) = "T" Then
		idw_wTravail.SetItem ( 1, "DTE_DECL", Today () )
	Else
		dDteCourCli = idw_wTravail.GetItemDateTime ( 1, "DTE_COUR_CLI" ) // [PI056] date -> datetime
		If	Not IsNull ( dDteCourCli ) Then
			idw_wTravail.SetItem ( 1, "DTE_DECL", dDteCourCli )
		End If
	End If
/*------------------------------------------------------------------*/
/* On positionne la gestion des TabOrder pour les zones de          */
/* t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie.                                                      */
/*------------------------------------------------------------------*/

	// DCMP990451
	istPochette.Hide()

Case "C"
	bProtectTel = TRUE
	idw_wTravail.Uf_Proteger ( sCol, "1" )
	idw_wTravail.Uf_Proteger ( { "DTE_ADH", "DTE_RESIL" }, "1" )
	idw_wTravail.Uf_Proteger ( { "ID_SIN", "ID_I" }, "0" )

	idw_wTravail.SetItem ( 1, "DTE_DECL", 		stNul.dat )
/*------------------------------------------------------------------*/
/* On positionne la gestion des TabOrder pour les zones de          */
/* t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie.                                                      */
/*------------------------------------------------------------------*/

End Choose

uf_Tb_Telephonie ( 0, TRUE, bProtectTel )
end subroutine

private subroutine uf_tb_codrecu ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Tb_CodRecu (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 17:35:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des TabOrder pour le mode de d$$HEX1$$e900$$ENDHEX$$claration
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Cette fonction concerne les zones suivantes :                    */
/* DTE_COUR_CLI, DTE_RECU, NB_PAGE                                  */
/*------------------------------------------------------------------*/

String sCol[ 20 ]

String sCodRecu, sCodTypRecu

sCol[  1 ] = "DTE_COUR_CLI"
sCol[  2 ] = "DTE_RECU"
sCol[  3 ] = "NB_PAGE"

sCodRecu 	= idw_wTravail.GetItemString ( 1, "COD_RECU" )
sCodTypRecu = idw_wTravail.GetItemString ( 1, "COD_TYP_RECU" )

Choose Case sCodRecu
Case "C", "F", "Q"
/*------------------------------------------------------------------*/
/* Il s'agit d'un courrier ou d'un fax, on arme les zones $$HEX2$$e0002000$$ENDHEX$$NULL.   */
/*------------------------------------------------------------------*/
	idw_wTravail.SetItem ( 1, "DTE_COUR_CLI", stNul.Dat )
	idw_wTravail.SetItem ( 1, "DTE_RECU", stNul.Dat )
	idw_wTravail.SetItem ( 1, "NB_PAGE", 0 )

	idw_wTravail.Uf_Proteger ( sCol, "0" )

	If	sCodTypRecu = "D" Then
		idw_wTravail.SetItem ( 1, "DTE_DECL", stNul.Dat )		
	End If

Case "T"
/*------------------------------------------------------------------*/
/* Il s'agit d'un coup de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phone, on arme DTE_COUR_CLI, DTE_DECL */
/* et DTE_RECU avec la date du jour. On arme NB_PAGE $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro.        */
/*------------------------------------------------------------------*/
	idw_wTravail.SetItem ( 1, "DTE_COUR_CLI", Today () )
	idw_wTravail.SetItem ( 1, "DTE_RECU", Today () )
	idw_wTravail.SetItem ( 1, "NB_PAGE", 0 )

	idw_wTravail.Uf_Proteger ( sCol, "1" )

	If	sCodTypRecu = "D" Then
		idw_wTravail.SetItem ( 1, "DTE_DECL", Today () )
	End If

End Choose

end subroutine

private subroutine uf_zn_idi ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Zn_IdI (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de ID_I
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lTotInter, lLig

String sIdI, sRech, sCodInter

sIdI	= idw_wTravail.GetText ()


If sIdI = "-1"	Then
	idw_wTravail.Uf_Proteger ( { "COD_I_PROV" }, "0" )
	idw_wTravail.SetItem ( 1, "COD_I_PROV", stNul.str )

Else
	idw_wTravail.Uf_Proteger ( { "COD_I_PROV" }, "1" )

	lTotInter	= idw_Inter.RowCount ()
	sRech			= "ID_I = " + sIdI
	lLig			= idw_Inter.Find ( sRech, 1, lTotInter )
	sCodInter	= idw_Inter.GetItemString ( lLig, "COD_INTER" )

	idw_wTravail.SetItem ( 1, "COD_I_PROV", sCodInter )

End If



end subroutine

private subroutine uf_zn_idprod ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Zn_IdProd (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de ID_PROD
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lLig, lCodAdrDms, lIdCorb, lCodTel

String sCodAdh, sText, sIdProd, sFiltre , sFiltreNull, sLibCorb, sData, sCodDestReg, sCodModeReg

DataWindowChild	dwChild, dwChild1, dwChild2

SetPointer ( HourGlass! )

idw_wTravail.GetChild ( "ID_PROD", dwChild )
idw_wTravail.GetChild ( "ID_ETS", dwChild1 )

lLig = dwChild.GetRow ()

sCodAdh		= dwChild.GetItemString ( lLig, "COD_ADH" )
lCodTel		= dwChild.GetItemNumber ( lLig, "COD_TEL" )
sIdProd		= idw_wTravail.GetText ()

/*------------------------------------------------------------------*/
/* Cette fonction concerne les zones suivantes :                    */
/* ID_ETS, ID_ADH, ID_SDOS, DTE_ADH, DTE_RESIL, ALT_ADR, COD_CIV,   */
/* NOM, PRENOM                                                      */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On change la valeur du code produit, la premi$$HEX1$$e800$$ENDHEX$$re chose $$HEX2$$e0002000$$ENDHEX$$faire   */
/* est de r$$HEX1$$e900$$ENDHEX$$initialiser les zones qui d$$HEX1$$e900$$ENDHEX$$pendent de ID_PROD.         */
/*------------------------------------------------------------------*/

idw_wTravail.SetItem ( 1, "ID_ETS", stNul.dcm )
idw_wTravail.SetItem ( 1, "ID_ADH", stNul.str )
idw_wTravail.SetItem ( 1, "ID_SDOS", stNul.dcm )
idw_wTravail.SetItem ( 1, "DTE_ADH", stNul.dat )
idw_wTravail.SetItem ( 1, "DTE_RESIL", stNul.dat )
idw_wTravail.SetItem ( 1, "DTE_FIN_GTI", stNul.dat )
idw_wTravail.SetItem ( 1, "DTE_SOUS", stNul.dat )
idw_wTravail.SetItem ( 1, "DTE_OPT", stNul.dat )
idw_wTravail.SetItem ( 1, "OPTION", stNul.dcm )
idw_wTravail.SetItem ( 1, "COD_CIV", stNul.str )
idw_wTravail.SetItem ( 1, "NOM", stNul.str )
idw_wTravail.SetItem ( 1, "PRENOM", stNul.str )
idw_wTravail.SetItem ( 1, "ALT_ADR", "N" )
idw_wTravail.SetItem ( 1, "ADR_1", stNul.str )
idw_wTravail.SetItem ( 1, "ADR_2", stNul.str )
idw_wTravail.SetItem ( 1, "ADR_CP", stNul.str )
idw_wTravail.SetItem ( 1, "ADR_VILLE", stNul.str )
idw_wTravail.SetItem ( 1, "ID_ORDRE", stNul.dcm )
idw_wTravail.SetItem ( 1, "COD_PROV_PERS", "W" )
ibSinLie = False

idw_wTravail.SetItem ( 1, "ID_CARTE", 0 )
idw_wTravail.SetItem ( 1, "ID_TYPE_CARTE", "00" )

/*------------------------------------------------------------------*/
/* On s'occupe des TabOrder pour la t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie. On positionne       */
/* toutes les zones $$HEX2$$e0002000$$ENDHEX$$NULL dans la fonction uf_Tb_Telephonie ()     */
/*------------------------------------------------------------------*/
uf_Tb_Telephonie ( lCodTel, TRUE, FALSE )

Choose Case sCodAdh
Case "1", "6"
/*------------------------------------------------------------------*/
/* Les adh$$HEX1$$e900$$ENDHEX$$sion sont g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es chez SPB. On va saisir ID_ETS, ID_ADH   */
/* et ID_SDOS pour proc$$HEX1$$e900$$ENDHEX$$der $$HEX2$$e0002000$$ENDHEX$$la recherche sur la base DMS.         */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La gestion des adresses est-elle prise en compte dans la base    */
/* adh$$HEX1$$e900$$ENDHEX$$sion ?                                                       */
/*------------------------------------------------------------------*/
	lCodAdrDms = dwChild.GetItemNumber ( lLig, "COD_ADR_DMS" )

	If	lCodAdrDms = 1	Then
		idw_wTravail.Uf_Proteger ( { "DTE_ADH", "DTE_RESIL", "COD_CIV", "NOM", "PRENOM", "ADR_1", "ADR_2", "ADR_CP", "ADR_VILLE" }, "1" )
		idw_wTravail.Uf_Proteger ( { "ID_ETS", "ID_ADH", "ID_SDOS", "ALT_ADR" }, "0" )
	Else

		idw_wTravail.Uf_Proteger ( { "ID_ETS", "ID_ADH", "ID_SDOS", "ADR_1", "ADR_2", "ADR_CP", "ADR_VILLE", "ALT_ADR" }, "0" )
		idw_wTravail.Uf_Proteger ( { "DTE_ADH", "DTE_RESIL", "COD_CIV", "NOM", "PRENOM" }, "1" )
	End If

	sText = "ID_ADH.Edit.Limit=7"
	idw_wTravail.Uf_Modify ( sText )

	sFiltre = "ID_PROD = " + sIdProd
	dwChild1.SetFilter ( sFiltre )
	dwChild1.Filter ()

	iuoOng.Uf_ActiverOnglet ( "02", True )

Case "2"
/*------------------------------------------------------------------*/
/* Les adh$$HEX1$$e900$$ENDHEX$$sions existent mais elles ne sont pas g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es chez SPB,   */
/* il faut permettre la saisie des zones.                           */
/*------------------------------------------------------------------*/
	idw_wTravail.Uf_Proteger ( { "ID_ETS", "ID_ADH", "ID_SDOS", "DTE_ADH", "DTE_RESIL", "COD_CIV", "NOM", &
										  "PRENOM", "ADR_1", "ADR_2", "ADR_CP", "ADR_VILLE" }, "0" )
	idw_wTravail.Uf_Proteger ( { "ALT_ADR" }, "1" )

	sText = "ID_ADH.Edit.Limit=7"
	idw_wTravail.Uf_Modify ( sText )

	sFiltre = "ID_PROD = " + sIdProd
	dwChild1.SetFilter ( sFiltre )
	dwChild1.Filter ()

	iuoOng.Uf_ActiverOnglet ( "02", False )

Case "3"
/*------------------------------------------------------------------*/
/* Pas d'adh$$HEX1$$e900$$ENDHEX$$sion, Le N$$HEX2$$b0002000$$ENDHEX$$ETS est positionn$$HEX2$$e9002000$$ENDHEX$$une fois pour toute.    */
/* Il faut juste saisir le N$$HEX2$$b0002000$$ENDHEX$$Adh$$HEX1$$e900$$ENDHEX$$sion. Le Sous-dossier est forc$$HEX4$$e900200020002000$$ENDHEX$$*/
/* $$HEX2$$e0002000$$ENDHEX$$1. La date d'adh$$HEX1$$e900$$ENDHEX$$sion est mise $$HEX2$$e0002000$$ENDHEX$$NULL.                         */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Il faut armer la valeur de ID_ETS $$HEX2$$e0002000$$ENDHEX$$0. En effet, si le           */
/* gestionnaire ne saisi pas la zone ID_ADH, il n'y a pas de        */
/* d$$HEX1$$e900$$ENDHEX$$termination pour ID_ETS. Or cette zone est obligatoire dans    */
/* W_SIN.                                                           */
/*------------------------------------------------------------------*/
	idw_wTravail.Uf_Proteger ( { "ID_ETS", "ID_SDOS", "DTE_ADH", "DTE_RESIL", "ALT_ADR" }, "1" )
	idw_wTravail.Uf_Proteger ( { "ID_ADH", "COD_CIV", "NOM", "PRENOM", "ADR_1", "ADR_2", "ADR_CP", "ADR_VILLE" }, "0" )

	sText = "ID_ADH.Edit.Limit=19"
	idw_wTravail.Uf_Modify ( sText )

	idw_wTravail.SetItem ( 1, "ID_ETS", 0 )
	idw_wTravail.SetItem ( 1, "ID_SDOS", 1 )

	dwChild1.SetFilter ( sFiltreNull )
	dwChild1.Filter ()

	iuoOng.Uf_ActiverOnglet ( "02", False )

Case "4"
/*------------------------------------------------------------------*/
/* Pas d'adh$$HEX1$$e900$$ENDHEX$$sion, le N$$HEX2$$b0002000$$ENDHEX$$ETS est $$HEX2$$e0002000$$ENDHEX$$saisir, ainsi que le N$$HEX11$$b0002000200020002000200020002000200020002000$$ENDHEX$$*/
/* Adh$$HEX1$$e900$$ENDHEX$$sion. Le Sous-dossier est forc$$HEX4$$e9002000e0002000$$ENDHEX$$1. La date d'adh$$HEX1$$e900$$ENDHEX$$sion est  */
/* mise $$HEX2$$e0002000$$ENDHEX$$NULL.                                                     */
/*------------------------------------------------------------------*/
	idw_wTravail.Uf_Proteger ( { "ID_SDOS", "DTE_ADH", "DTE_RESIL", "ALT_ADR" }, "1" )
	idw_wTravail.Uf_Proteger ( { "ID_ETS", "ID_ADH", "COD_CIV", "NOM", "PRENOM", "ADR_1", "ADR_2", "ADR_CP", "ADR_VILLE" }, "0" )

	sText = "ID_ADH.Edit.Limit=19"
	idw_wTravail.Uf_Modify ( sText )

	idw_wTravail.SetItem ( 1, "ID_SDOS", 1 )

	sFiltre = "ID_PROD = " + sIdProd
	dwChild1.SetFilter ( sFiltre )
	dwChild1.Filter ()

	iuoOng.Uf_ActiverOnglet ( "02", False )

Case "5"
/*------------------------------------------------------------------*/
/* Cas Garantie 24. Tout est $$HEX2$$e0002000$$ENDHEX$$saisir.                              */
/*------------------------------------------------------------------*/
	idw_wTravail.Uf_Proteger ( { "ID_ETS", "ID_ADH", "ID_SDOS", "DTE_ADH", "DTE_RESIL", "COD_CIV", "NOM", "PRENOM" }, "0" )
	idw_wTravail.Uf_Proteger ( { "ALT_ADR" }, "1" )

	sText = "ID_ADH.Edit.Limit=8"
	idw_wTravail.Uf_Modify ( sText )

	sFiltre = "ID_PROD = " + sIdProd
	dwChild1.SetFilter ( sFiltre )
	dwChild1.Filter ()

	iuoOng.Uf_ActiverOnglet ( "02", False )

End Choose

/*------------------------------------------------------------------*/
/* On arme maintenant le code corbeille ainsi que le libell$$HEX2$$e9002000$$ENDHEX$$de la  */
/* corbeille.                                                       */
/*------------------------------------------------------------------*/
idw_wTravail.ClearValues ( "ID_CORB" )

sLibCorb = dwChild.GetItemString ( lLig, "LIB_CORB" )
lIdCorb	= dwChild.GetItemNumber ( lLig, "ID_CORB" )

sData		= sLibCorb + "~t" + String ( lIdCorb )
idw_wTravail.SetValue ( "ID_CORB", 1, sData )
idw_wTravail.SetItem ( 1, "ID_CORB", lIdCorb )


/*----------------------------------------------------------------------------*/
/* AJOUT JFF LE 11/05/2001 : On filtre la Dw des utilisateurs.                */
/*----------------------------------------------------------------------------*/
ibAltContact = dwChild.GetItemString ( lLig, "ALT_CONTACT" ) = "O"
This.uf_Gestion_Contacts ( String ( lIdCorb) , -1 )

/*------------------------------------------------------------------*/
/* Dans tous les cas, on va cr$$HEX1$$e900$$ENDHEX$$er un INTERLOCUTEUR de type ASSURE.  */
/*------------------------------------------------------------------*/
sCodModeReg = dwChild.GetItemString ( lLig, "COD_MODE_REG" )
sCodDestReg = dwChild.GetItemString ( lLig, "COD_DEST_REG" )

If	sCodDestReg = "A" Then
	idw_wTravail.SetItem ( 1, "COD_MODE_REG_A", sCodModeReg )
Else
	idw_wTravail.SetItem ( 1, "COD_MODE_REG_A", stNul.str )
End If

/*------------------------------------------------------------------*/
/* On repositionne la DW servant au stockage des coordonn$$HEX1$$e900$$ENDHEX$$es de     */
/* l'adh$$HEX1$$e900$$ENDHEX$$sion. Cette DW sera arm$$HEX1$$e900$$ENDHEX$$e dans la fonction                 */
/* Uf_Verifier_Adhesion_Edms ().                                    */
/*------------------------------------------------------------------*/
idw_Adh.Reset ()
idw_Mvts.Reset ()

SetPointer ( Arrow! )
end subroutine

private subroutine uf_zn_idets ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Zn_IdEts (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de ID_ETS
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sCodAdh

Long lLig, lCodBaseDms, lCodProdDms, lCodAdrDms, lNbAdherent, lCodTel

/*------------------------------------------------------------------*/
/* Pour les produits avec COD_ADH = 1,2,5 on positionne la zone     */
/* ID_SDOS $$HEX2$$e0002000$$ENDHEX$$NULL. La gestion des sinistres li$$HEX1$$e900$$ENDHEX$$s se fera donc sur   */
/* cette zone. Pour les produits avec COD_ADH = 3,4 on positionne   */
/* la zone ID_ADH $$HEX2$$e0002000$$ENDHEX$$NULL. La gestion des sinistres li$$HEX1$$e900$$ENDHEX$$s se fera     */
/* donc sur cette zone.                                             */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La gestion des ADHESIONS EDMS se fera sur la zone ID_SDOS.       */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On recherche les informations du produit en cours de saisie.     */
/*------------------------------------------------------------------*/
Uf_Recherche_Produit ( lLig, sCodAdh, lCodBaseDms, lCodProdDms, lCodAdrDms, lNbAdherent, lCodTel )

/*------------------------------------------------------------------*/
/* On initialise ID_ORDRE et COD_PROV_PERS.                         */
/*------------------------------------------------------------------*/
idw_wTravail.SetItem ( 1, "ID_ORDRE", stNul.dcm )
idw_wTravail.SetItem ( 1, "COD_PROV_PERS", "W" )
ibSinLie = False


Choose Case sCodAdh
Case "1", "2", "5", "6"
	idw_wTravail.SetItem ( 1, "ID_SDOS", stNul.dcm )
	
Case "3", "4"
	idw_wTravail.SetItem ( 1, "ID_ADH", stNul.str )

End Choose
end subroutine

private subroutine uf_recuperer_sinistres_lies (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Recuperer_Sinistres_Lies (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/07/1998 09:51:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va v$$HEX1$$e900$$ENDHEX$$rifier s'il existe d'autres sinistres pour cette adh$$HEX1$$e900$$ENDHEX$$sion
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DataWindowChild dwChild

String sCodAdh, sIdAdh, sTitre

Long lLig, lIdEts, lIdsDos, lIdProd, lTotSin, lCodBaseDms, lCodProdDms, lCodAdrDms, lNbAdherent, lCodTel

/*------------------------------------------------------------------*/
/* On recherche les informations du produit en cours de saisie.     */
/*------------------------------------------------------------------*/
If Not Uf_Recherche_Produit ( lLig, sCodAdh, lCodBaseDms, lCodProdDms, lCodAdrDms, lNbAdherent, lCodTel ) Then
	Return
End If

/*------------------------------------------------------------------*/
/* On remet la DW servant au stockage des sinistres li$$HEX1$$e800$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$vide.    */
/*------------------------------------------------------------------*/
idw_SinistresLies.Reset ()

/*------------------------------------------------------------------*/
/* Pour arriver dans cette fonction, on vient de modifier soit la   */
/* zone ID_ADH, soit la zone ID_SDOS.                               */
/*------------------------------------------------------------------*/
lIdProd	= idw_wTravail.GetItemNumber ( 1, "ID_PROD" )
lIdEts	= idw_wTravail.GetItemNumber ( 1, "ID_ETS" )
sIdAdh	= idw_wTravail.GetItemString ( 1, "ID_ADH" )
lIdsDos	= idw_wTravail.GetItemNumber ( 1, "ID_SDOS" )

idw_wTravail.GetChild ( "ID_PROD", dwChild )

Choose Case sCodAdh
Case "1", "2", "5", "6"
	lTotSin	= idw_SinistresLies.Retrieve ( sIdAdh, lIdProd, lIdEts, lIdsDos, "ADH" )
	sTitre	= "Produit : " + String ( lIdProd ) + " ( " + dwChild.GetItemString ( lLig, "LIB_COURT" ) + " )  -  " + &
				  "Ets : " + String ( lIdEts ) + "  -  Adh$$HEX1$$e900$$ENDHEX$$sion : " + sIdAdh + "  -  Sous-Dossier : " + String ( lIdsDos )

Case "3", "4"
	lTotSin = idw_SinistresLies.Retrieve ( sIdAdh, 0, 0, 0, "XXX" )
	sTitre	= "Adh$$HEX1$$e900$$ENDHEX$$sion : " + sIdAdh

End Choose

/*------------------------------------------------------------------*/
/* On positionne les zones ID_ORDRE et COD_PROV_PERS avec des       */
/* valeurs initiales.                                               */
/*------------------------------------------------------------------*/
idw_wTravail.SetItem ( 1, "ID_ORDRE", stNul.dcm )
idw_wTravail.SetItem ( 1, "COD_PROV_PERS", "W" )
ibSinLie = False

astPass.lTab[1] = lTotSin
astPass.sTab[1] = sTitre
end subroutine

private subroutine uf_fin_sinistres_lies (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Fin_Sinistres_Lies (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va positionner les valeurs de ID_ORDRE et COD_PROV_PERS
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*--------------------------------------------------------------

String sCodProvPers, sCodAdh
String sCodCiv, sNom, sPrenom, sAdr1, sAdr2, sAdrCp, sAdrVille

Long lIdOrdre, lLig

DataWindowChild dwChild

idw_wTravail.GetChild ( "ID_PROD", dwChild )
lLig = dwChild.GetRow ()

sCodAdh = dwChild.GetItemString ( lLig, "COD_ADH" )

Choose Case astPass.lTab[1]
Case 1
/*------------------------------------------------------------------*/
/* Le gestionnaire est d'accord pour r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer les coordonn$$HEX1$$e900$$ENDHEX$$es que  */
/* l'on vient de lui pr$$HEX1$$e900$$ENDHEX$$senter.                                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Tous les N$$HEX2$$b0002000$$ENDHEX$$ordre sont identiques. (On le v$$HEX1$$e900$$ENDHEX$$rifie dans la        */
/* fen$$HEX1$$ea00$$ENDHEX$$tre W_T_Sp_Sinistres_Lies). On peut donc prendre le premier  */
/* sans crainte.                                                    */
/*------------------------------------------------------------------*/
	lIdOrdre			= idw_SinistresLies.GetItemNumber ( 1, "ID_ORDRE" )
	sCodProvPers	= "P"

	sCodCiv		= idw_SinistresLies.GetItemString ( 1, "COD_CIV" )
	sNom			= idw_SinistresLies.GetItemString ( 1, "NOM" )
	sPrenom		= idw_SinistresLies.GetItemString ( 1, "PRENOM" )
	sAdr1			= idw_SinistresLies.GetItemString ( 1, "ADR_1" )
	sAdr2			= idw_SinistresLies.GetItemString ( 1, "ADR_2" )
	sAdrCp		= idw_SinistresLies.GetItemString ( 1, "ADR_CP" )
	sAdrVille	= idw_SinistresLies.GetItemString ( 1, "ADR_VILLE" )

	idw_wTravail.SetItem ( 1, "COD_CIV",	sCodCiv )
	idw_wTravail.SetItem ( 1, "NOM",			sNom )
	idw_wTravail.SetItem ( 1, "PRENOM",		sPrenom )
	idw_wTravail.SetItem ( 1, "ADR_1",		sAdr1 )
	idw_wTravail.SetItem ( 1, "ADR_2",		sAdr2 )
	idw_wTravail.SetItem ( 1, "ADR_CP", 	sAdrCp )
	idw_wTravail.SetItem ( 1, "ADR_VILLE",	sAdrVille )
	ibSinLie = True

Case 2
/*------------------------------------------------------------------*/
/* Le gestionnaire ne veut pas des coordonn$$HEX1$$e900$$ENDHEX$$es, mais il a bien      */
/* identifi$$HEX2$$e9002000$$ENDHEX$$l'adh$$HEX1$$e900$$ENDHEX$$rent. Il faut donc prendre la valeur de          */
/* ID_ORDRE.                                                        */
/*------------------------------------------------------------------*/
	lIdOrdre			= idw_SinistresLies.GetItemNumber ( 1, "ID_ORDRE" )
	sCodProvPers	= "P"

Case 0
/*------------------------------------------------------------------*/
/* Le gestionnaire vient de faire retour sur la fen$$HEX1$$ea00$$ENDHEX$$tre             */
/* W_T_Sp_Sinistres_Lies. On positionne les valeurs $$HEX2$$e0002000$$ENDHEX$$NULL. On      */
/* positionne la zone ID_ADH ou ID_SDOS $$HEX2$$e0002000$$ENDHEX$$NULL.                     */
/*------------------------------------------------------------------*/
	lIdOrdre			= stNul.dcm
	sCodProvPers	= "W"
	ibSinLie = False

	Choose Case idw_wTravail.isNomCol
	Case "ID_ADH"	
		idw_wTravail.SetItem ( 1, "ID_ADH", stNul.str )
	Case "ID_SDOS"
		idw_wTravail.SetItem ( 1, "ID_SDOS", stNul.dcm )
	End Choose

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$initialise les valeurs de ID_CARTE et ID_TYPE_CARTE. Ceci   */
/* n'est important que pour les produits avec une m$$HEX1$$e900$$ENDHEX$$thode           */
/* d'adh$$HEX1$$e900$$ENDHEX$$sion par carte. En effet, le gestionnaire peut saisir une  */
/* carte valide, cela $$HEX2$$e0002000$$ENDHEX$$pour effet de positionne ID_CARTE et        */
/* ID_TYPE_CARTE. Le gestionnaire saisi ensuite une nouvelle carte  */
/* correspondant $$HEX2$$e0002000$$ENDHEX$$un sinistre pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent. Elle arrive sur la        */
/* fen$$HEX1$$ea00$$ENDHEX$$tre des sinistres li$$HEX1$$e900$$ENDHEX$$s. Elle fait retour, puis elle peut     */
/* enregistrer son travail, car la zone ID_ADH n'est pas            */
/* obligatoire.                                                     */
/*------------------------------------------------------------------*/
	idw_wTravail.SetItem ( 1, "ID_CARTE", 0 )
	idw_wTravail.SetItem ( 1, "ID_TYPE_CARTE", "00" )

	If	sCodAdh = "3" Then
		idw_wTravail.SetItem ( 1, "ID_ETS", 0 )
	End If

End Choose
	
idw_wTravail.SetItem ( 1, "ID_ORDRE", lIdOrdre )
idw_wTravail.SetItem ( 1, "COD_PROV_PERS", sCodProvPers )

astPass.bRetour = ibSinLie
end subroutine

private subroutine uf_controlersaisie (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_ControlerSaisie (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Contr$$HEX1$$f400$$ENDHEX$$le de saisie d'un travail
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sCol [ 15 ], sErr [ 15 ], sVal [ 15 ], sNumTel

String sCodIProv, sCodAdh, sRet

DataWindowChild dwChild

DateTIme dDteCourCli, dDteRecu, dDteAdh, dDteSurv // [PI056] date -> datetime

String sNouvelleLigne, sText, sPos, sOng, sCodTypRecu, sCodRecu, sAdr2
String sNom, sPrenom
String sNomB, sAgenceB, sAdr1B, sAdr2B, sAdrCpB, sAdrVilleB
String sAltCmdMobile

Long 	lCpt, lNbrCol, lNbPage, lIdSin, lIdI, lLig, lTotHomonyme
Long 	lIdOrdre, lIdOrdreLu, lCodTel

Boolean bReset

sNouvelleLigne		= "~r~n"
lNbrCol				= UpperBound ( sCol )
sPos					= ""
sText					= sNouvelleLigne
sOng					= "01"

idw_wTravail.GetChild ( "ID_PROD", dwChild )
lLig = dwChild.Find ( "ID_PROD = " + String ( idw_wTravail.GetItemNumber ( 1, "ID_PROD" ) ), 1, dwChild.RowCount () )
If lLig > 0 Then 
	lCodTel =  dwChild.GetItemNumber ( lLig, "COD_TEL" ) 
	sAltCmdMobile = dwChild.GetItemString ( lLig, "ALT_CMD_MOBILE" ) 
Else
	lCodTel = 0
	sAltCmdMobile = "N"
End If

/*------------------------------------------------------------------*/
/* On transforme toutes les chaines vides en NULL avant de          */
/* commencer.                                                       */
/*------------------------------------------------------------------*/
Uf_Gestion_Str2Nul ()

/*------------------------------------------------------------------*/
/* Les controles sont diff$$HEX1$$e900$$ENDHEX$$rents pour un compl$$HEX1$$e900$$ENDHEX$$ment ou une          */
/* d$$HEX1$$e900$$ENDHEX$$claration.                                                     */
/*------------------------------------------------------------------*/
sCodTypRecu = idw_wTravail.GetItemString ( 1, "COD_TYP_RECU" )

If	sCodTypRecu = "C"	Then
	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie d'un travail (COMPLEMENT)"
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "GENE001"

	dDteCourCli = idw_wTravail.GetItemDateTime ( 1, "DTE_COUR_CLI" )
	dDteRecu		= idw_wTravail.GetItemDateTime ( 1, "DTE_RECU" )
	lNbPage		= idw_wTravail.GetItemNumber ( 1, "NB_PAGE" )
	lIdSin		= idw_wTravail.GetItemNumber ( 1, "ID_SIN" )
	lIdI			= idw_wTravail.GetItemNumber ( 1, "ID_I" )
	sCodIProv	= idw_wTravail.GetItemString ( 1, "COD_I_PROV" )
	sCodRecu		= idw_wTravail.GetItemString ( 1, "COD_RECU" )


	If IsNull ( dDteCourCli ) Then
		If sPos	= "" Then sPos = "DTE_COUR_CLI"
		sText		= sText + " - la date du courrier client" + sNouvelleLigne
	End If

	If IsNull ( dDteRecu ) Then
		If sPos	= "" Then sPos = "DTE_RECU"
		sText		= sText + " - la date arriv$$HEX1$$e900$$ENDHEX$$e SPB" + sNouvelleLigne
	End If

	If ( IsNull ( lNbPage ) Or lNbPage = 0 ) And sCodRecu <> "T" Then
		If sPos	= "" Then sPos = "NB_PAGE"
		sText		= sText + " - le nombre de pages" + sNouvelleLigne
	End If

	If IsNull ( lIdSin ) Then
		If sPos	= "" Then sPos = "ID_SIN"
		sText		= sText + " - le N$$HEX2$$b0002000$$ENDHEX$$de sinistre" + sNouvelleLigne
	End If

	If IsNull ( lIdI ) Then
		If sPos	= "" Then sPos = "ID_I"
		sText		= sText + " - la provenance du compl$$HEX1$$e900$$ENDHEX$$ment" + sNouvelleLigne
	End If

	If IsNull ( sCodIProv ) Or sCodIProv = "" Then
		If sPos	= "" Then sPos = "COD_I_PROV"
		sText		= sText + " - le type de l'interlocuteur" + sNouvelleLigne
	End If

/*------------------------------------------------------------------*/
/* Si le code de l'interlocuteur = -1 (AUTRE), le type de           */
/* l'interlocuteur ne peut-$$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$(A)ssur$$HEX1$$e900$$ENDHEX$$.                    */
/*------------------------------------------------------------------*/
	If	sPos = ""	Then
		If	lIdI = -1 And sCodIProv = "A"	Then
			sPos = "COD_I_PROV"
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WORK210"
		End If
	End If

Else

	/*------------------------------------------------------------------*/
	/* Le 15/11/2001, JFF															  */
	/* Pour les produits de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie, on regarde si le n$$HEX2$$b0002000$$ENDHEX$$de          */
	/* t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phone est renseign$$HEX1$$e900$$ENDHEX$$, mais on ne bloque pas.                  */
	/*------------------------------------------------------------------*/
	sNumTel = Trim ( idw_wTravail.GetItemString ( 1, "NUM_TELD" ) )
	If ( IsNull ( sNumTel ) Or sNumTel = "" ) And sAltCmdMobile = "O" Then
		stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie d'un travail (DECLARATION)"
		stMessage.bErreurG	= FALSE
		stMessage.bouton		= YESNO!
		stMessage.sCode		= "WORK390"
		If F_Message ( stMessage ) = 2 Then 
			sPos = "NUM_TELD"
			sText += " - Le num$$HEX1$$e900$$ENDHEX$$ro de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phone" + sNouvelleLigne
		End If
	End If

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie d'un travail (DECLARATION)"
	stMessage.bErreurG	= TRUE
	stMessage.bouton		= OK!
	stMessage.sCode		= "GENE001"

	sCol[  1 ] = "COD_I_PROV"
	sCol[  2 ] = "COD_CIV"
	sCol[  3 ] = "NOM"
	sCol[  4 ] = "PRENOM"
	sCol[  5 ] = "ADR_1"
	sCol[  6 ] = "ADR_CP"
	sCol[  7 ] = "ADR_VILLE"
	sCol[  8 ] = "ID_ADH"
	sCol[  9 ] = "DTE_COUR_CLI"
	sCol[ 10 ] = "DTE_RECU"
	sCol[ 11 ] = "DTE_DECL"
	sCol[ 12 ] = "ID_PROD"
	sCol[ 13 ] = "ID_ETS"
	sCol[ 14 ] = "ID_SDOS"
	sCol[ 15 ] = "NB_PAGE"

	sErr[  1 ] = " - Le type de l'interlocuteur"
	sErr[  2 ] = " - La civilit$$HEX1$$e900$$ENDHEX$$"
	sErr[  3 ] = " - Le nom"
	sErr[  4 ] = " - Le pr$$HEX1$$e900$$ENDHEX$$nom"
	sErr[  5 ] = " - La premi$$HEX1$$e800$$ENDHEX$$re ligne d'adresse"
	sErr[  6 ] = " - Le code postal"
	sErr[  7 ] = " - La ville"
	sErr[  8 ] = " - Le N$$HEX2$$b0002000$$ENDHEX$$adh$$HEX1$$e900$$ENDHEX$$sion"
	sErr[  9 ] = " - La date du courrier client"
	sErr[ 10 ] = " - La date de r$$HEX1$$e900$$ENDHEX$$ception SPB"
	sErr[ 11 ] = " - La date de d$$HEX1$$e900$$ENDHEX$$claration du sinistre"
	sErr[ 12 ] = " - Le code produit"
	sErr[ 13 ] = " - Le code $$HEX1$$e900$$ENDHEX$$tablissement"
	sErr[ 14 ] = " - Le N$$HEX2$$b0002000$$ENDHEX$$de sous-dossier"
	sErr[ 15 ] = " - Le nombre de pages"

/*------------------------------------------------------------------*/
/* Il faut faire un TRIM pour toutes les zones, sauf le CODE        */
/* POSTAL.                                                          */
/*------------------------------------------------------------------*/
	For	lCpt = 1 To 8
			sVal[ lCpt ] = Trim ( idw_wTravail.GetItemString ( 1, sCol[ lCpt ] ) )
	Next

	sVal[  6 ] = idw_wTravail.GetItemString ( 1, sCol[  6 ] )

/*------------------------------------------------------------------*/
/* On recup$$HEX1$$e900$$ENDHEX$$re les zones de type DATE.                              */
/*------------------------------------------------------------------*/
	sVal[  9 ] = String ( idw_wTravail.GetItemDateTime ( 1, sCol[  9 ] ) ) // [PI056] date -> datetime
	sVal[ 10 ] = String ( idw_wTravail.GetItemDateTime ( 1, sCol[ 10 ] ) ) // [PI056] date -> datetime
	sVal[ 11 ] = String ( idw_wTravail.GetItemDateTime ( 1, sCol[ 11 ] ) ) // [PI056] date -> datetime

/*------------------------------------------------------------------*/
/* On recup$$HEX1$$e900$$ENDHEX$$re les zones de type NUMERIQUE.                         */
/*------------------------------------------------------------------*/
	sVal[ 12 ] = String ( idw_wTravail.GetItemNumber ( 1, sCol[ 12 ] ) )
	sVal[ 13 ] = String ( idw_wTravail.GetItemNumber ( 1, sCol[ 13 ] ) )
	sVal[ 14 ] = String ( idw_wTravail.GetItemNumber ( 1, sCol[ 14 ] ) )
	sVal[ 15 ] = String ( idw_wTravail.GetItemNumber ( 1, sCol[ 15 ] ) )

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/
	For	lCpt = 1 To 7
			If IsNull ( sVal[ lCpt ] ) or sVal[ lCpt ] = ""	Then
				If sPos = "" Then sPos = sCol[ lCpt ]
				sText = sText + sErr[ lCpt ] + sNouvelleLigne
			End If
	Next

/*------------------------------------------------------------------*/
/* Si la m$$HEX1$$e900$$ENDHEX$$thode d'adh$$HEX1$$e900$$ENDHEX$$sion est $$HEX1$$e900$$ENDHEX$$gale $$HEX2$$e0002000$$ENDHEX$$1 (ADHESION SPB), 2         */
/* (ADHESION NON SPB), 5 (GARANTIE 24), 6 (Protectation Paiement)   */
/* toutes les zones sont obligatoires, sinon ID_ADH, ID_ETS et      */
/* ID_SDOS peuvent $$HEX1$$ea00$$ENDHEX$$tre NULL.                                       */
/*------------------------------------------------------------------*/
	If	Not IsNull ( sVal[ 12 ] ) Then
		idw_wTravail.GetChild ( "ID_PROD", dwChild )
		lLig = dwChild.GetRow ()

		sCodAdh = dwChild.GetItemString ( lLig, "COD_ADH" )

		If	sCodAdh = "1" Or sCodAdh = "2" Or sCodAdh = "5" Or sCodAdh = "6" Then
/*------------------------------------------------------------------*/
/* Toutes les zones sont obligatoires.                              */
/*------------------------------------------------------------------*/
			For	lCpt = 8 To 14
					If IsNull ( sVal[ lCpt ] ) or sVal[ lCpt ] = ""	Then
						If sPos = "" Then sPos = sCol[ lCpt ]
						sText = sText + sErr[ lCpt ] + sNouvelleLigne
					End If
			Next
		Else
/*------------------------------------------------------------------*/
/* On oblige $$HEX2$$e0002000$$ENDHEX$$saisir DTE_COUR_CLI, DTE_RECU, DTE_DECL, ID_PROD,    */
/* ID_ETS, ID_SDOS.                                                 */
/*------------------------------------------------------------------*/
			For	lCpt = 9 To 14
					If IsNull ( sVal[ lCpt ] ) or sVal[ lCpt ] = ""	Then
						If sPos = "" Then sPos = sCol[ lCpt ]
						sText = sText + sErr[ lCpt ] + sNouvelleLigne
					End If
			Next
		End If
	Else
/*------------------------------------------------------------------*/
/* Le code produit est NULL, on oblige $$HEX2$$e0002000$$ENDHEX$$saisir DTE_COUR_CLI,       */
/* DTE_RECU, DTE_DECL, ID_PROD.                                     */
/*------------------------------------------------------------------*/
		For	lCpt = 9 To 12
				If IsNull ( sVal[ lCpt ] ) or sVal[ lCpt ] = ""	Then
					If sPos = "" Then sPos = sCol[ lCpt ]
					sText = sText + sErr[ lCpt ] + sNouvelleLigne
				End If
		Next
	End If
End If

/*------------------------------------------------------------------*/
/* Le 08/10/1998.                                                   */
/* La zone DTE_SURV est obligatoire pour les produits avec COD_ADH  */
/* = 1,2,5,6                                                        */
/*------------------------------------------------------------------*/
If	sCodAdh = "1" Or sCodAdh = "2" Or sCodAdh = "5" Or sCodAdh = "6" Then
	dDteSurv = idw_wTravail.GetItemDateTime ( 1, "DTE_SURV" ) // [PI056] date -> datetime
	If	IsNull ( dDteSurv )	Then
		If sPos = "" Then sPos = "DTE_SURV"
		sText = sText + " - La date de survenance" + sNouvelleLigne
	End If
End If

/*------------------------------------------------------------------*/
/* La zone NB_PAGE est obligatoire sauf si COD_RECU est $$HEX1$$e900$$ENDHEX$$gal $$HEX7$$e000200020002000200020002000$$ENDHEX$$*/
/* (T)$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phone.                                                     */
/*------------------------------------------------------------------*/
sCodRecu = idw_wTravail.GetItemString ( 1, "COD_RECU" )
If	sCodRecu <> "T" And ( IsNull ( sVal[15] ) Or sVal[15] = '0' ) Then
	If sPos = "" Then sPos = sCol[ 15 ]
	sText = sText + sErr[ 15 ] + sNouvelleLigne
End If

/*------------------------------------------------------------------*/
/* La date d'adh$$HEX1$$e900$$ENDHEX$$sion est obligatoire pour les produits avec        */
/* COD_ADH = "2", "5".                                              */
/*------------------------------------------------------------------*/
If	sCodAdh = "2" Or sCodAdh = "5" Then
	dDteAdh = idw_wTravail.GetItemDateTime ( 1, "DTE_ADH" ) // [PI056] date -> datetime
	If	IsNull ( dDteAdh ) Or String ( dDteAdh ) = "" Then
		If sPos = "" Then sPos = "DTE_ADH"
		sText = sText + " - La date d'adh$$HEX1$$e900$$ENDHEX$$sion" + sNouvelleLigne
	End If
End If

/*------------------------------------------------------------------*/
/* On va maintenant v$$HEX1$$e900$$ENDHEX$$rifier que les donn$$HEX1$$e900$$ENDHEX$$es r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es lors de la  */
/* recherche adh$$HEX1$$e900$$ENDHEX$$sion correspondent bien aux diff$$HEX1$$e900$$ENDHEX$$rentes r$$HEX1$$e900$$ENDHEX$$gles de  */
/* validation.                                                      */
/*------------------------------------------------------------------*/
/* Le 03/07/01 JFF : On ne contr$$HEX1$$f400$$ENDHEX$$le pas les coordonn$$HEX1$$e900$$ENDHEX$$es de la banque*/
/* en t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie, il peut ne pas y avoir de banque reli$$HEX4$$e9002000e0002000$$ENDHEX$$l'adh$$HEX1$$e900$$ENDHEX$$si */
/* on sur la base unisys.														  */
/*------------------------------------------------------------------*/
If	sPos = "" and lCodTel <= 0	Then

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie d'un travail (DECLARATION)"
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "WORK230"

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie la zone COD_CIV.                                      */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la valeur de la DATAVALUE. Si cette valeur est       */
/* num$$HEX1$$e900$$ENDHEX$$rique, c'est que nous n'en poss$$HEX1$$e900$$ENDHEX$$dons pas l'$$HEX1$$e900$$ENDHEX$$quivalent.       */
/*------------------------------------------------------------------*/
	sRet = idw_wTravail.Describe ( "Evaluate ( 'LookUpDisplay ( COD_CIV )', 1 ) " )

	If	IsNumber ( sRet ) Then
		If sPos = "" Then sPos = sCol[ 2 ]
		sText = sText + sErr[ 2 ] + sNouvelleLigne
	End If

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie le NOM et le PRENOM.                                  */
/*------------------------------------------------------------------*/
	For	lCpt = 3 To 4
		If	Not F_Libelle ( sVal[ lCpt ], 7 )	Then 
			If sPos = "" Then sPos = sCol[ lCpt ]
			sText = sText + sErr[ lCpt ] + sNouvelleLigne
		End If
	Next

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie ADR_1, ADR_2 et ADR_VILLE.                            */
/*------------------------------------------------------------------*/
	If	Not F_Libelle ( sVal[ 5 ], 2 )	Then 
		If sPos = "" Then sPos = sCol[ 5 ]
		sText = sText + sErr[ 5 ] + sNouvelleLigne
	End If

	sAdr2 = idw_wTravail.GetItemString ( 1, "ADR_2" )
	If	Not F_Libelle ( sAdr2, 2 )	Then 
		If sPos = "" Then sPos = "ADR_2"
		sText = sText + " - La seconde ligne d'adresse" + sNouvelleLigne
	End If

	If	Not F_Libelle ( sVal[ 7 ], 2 )	Then 
		If sPos = "" Then sPos = sCol[ 7 ]
		sText = sText + sErr[ 7 ] + sNouvelleLigne
	End If
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie ADR_CP.                                               */
/*------------------------------------------------------------------*/
	If	Not F_Code_Postal ( sVal[ 6 ], 2 )	Then 
		If sPos = "" Then sPos = sCol[ 6 ]
		sText = sText + sErr[ 6 ] + sNouvelleLigne
	End If

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si les coordonn$$HEX1$$e900$$ENDHEX$$es de l'agence bancaire sont          */
/* correctes.                                                       */
/*------------------------------------------------------------------*/
	If	idw_Adh.RowCount () > 0 Then
		sNomB			= idw_Adh.GetItemString ( 1, "DOMIC_NOM_BANQ" )
		sAgenceB		= idw_Adh.GetItemString ( 1, "DOMIC_NOM_AGENCE" )
		sAdr1B		= idw_Adh.GetItemString ( 1, "DOMIC_ADR_35_1" )
		sAdr2B		= idw_Adh.GetItemString ( 1, "DOMIC_ADR_35_2" )
		sAdrCpB		= idw_Adh.GetItemString ( 1, "DOMIC_CPOSTAL" )
		sAdrVilleB	= idw_Adh.GetItemString ( 1, "DOMIC_VILLE" )

		If	Not F_Libelle ( sNomB, 7 )	Then 
			If sPos = "" Then sPos = "DTE_COUR_CLI"
			sText = sText + " - Le nom de la banque" + sNouvelleLigne
		End If

		If	Not F_Libelle ( sAgenceB, 7 )	Then 
			If sPos = "" Then sPos = "DTE_COUR_CLI"
			sText = sText + " - Le nom de l'agence" + sNouvelleLigne
		End If

		If	Not F_Libelle ( sAdr1B, 2 )	Then 
			If sPos = "" Then sPos = "DTE_COUR_CLI"
			sText = sText + " - La premi$$HEX1$$e800$$ENDHEX$$re ligne d'adresse de la banque" + sNouvelleLigne
		End If

		If	Not F_Libelle ( sAdr2B, 2 )	Then 
			If sPos = "" Then sPos = "DTE_COUR_CLI"
			sText = sText + " - La seconde ligne d'adresse de la banque" + sNouvelleLigne
		End If

		If	Not F_Libelle ( sAdrVilleB, 2 )	Then 
			If sPos = "" Then sPos = "DTE_COUR_CLI"
			sText = sText + " - La ville de la banque" + sNouvelleLigne
		End If

		If	Not F_Code_Postal ( sAdrCpB, 2 )	Then 
			If sPos = "" Then sPos = "DTE_COUR_CLI"
			sText = sText + " - Le code postal de la banque" + sNouvelleLigne
		End If

	End If
End If

/*----------------------------------------------------------------------------*/
/* AJOUT JFF LE 11/05/2001 : En gestion de contact, la zone DOS_SUIVI_PAR     */
/* doit $$HEX1$$ea00$$ENDHEX$$tre renseign$$HEX1$$e900$$ENDHEX$$e.                                                      */
/*----------------------------------------------------------------------------*/
If ibAltContact Then
	If IsNull ( idw_DosSuiviPar.GetItemString ( 1, "DOS_SUIVI_PAR" ) ) Or  &
		Trim ( idw_DosSuiviPar.GetItemString ( 1, "DOS_SUIVI_PAR" ) ) = "" Then
		If sPos = "" Then sPos = "DTE_COUR_CLI"
		sText = sText + " - Qui doit traiter le dossier" + sNouvelleLigne
	End If 
End If

/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/
If	sPos <> "" Then

	stMessage.Icon			= Information!
	stMessage.sVar[1] 	= sText

	f_Message ( stMessage )

	If	Not IsNull ( sOng ) And iuoOng.Uf_RecupererOngletCourant () <> sOng Then
		iuoOng.Uf_ChangerOnglet ( sOng )
	End If

Else

/*------------------------------------------------------------------*/
/* On lance la recherche des homonymes. Le seul $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment, pris en    */
/* compte dans la fonction Wf_ControlerSaisie () est le nombre de   */
/* ligne dans la DW.                                                */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La premi$$HEX1$$e800$$ENDHEX$$re chose $$HEX2$$e0002000$$ENDHEX$$faire est donc de faire un Reset (). S'il    */
/* ne s'agit pas d'une d$$HEX1$$e900$$ENDHEX$$claration, on ne fait rien. Dans le cas    */
/* contraire, on d$$HEX1$$e900$$ENDHEX$$clenche la recherche.                            */
/*------------------------------------------------------------------*/
	idw_Homonyme.Reset ()

	If	sCodTypRecu = "D" Then
		sNom 		= Left ( idw_wTravail.GetItemString ( 1, "NOM" ), 5 ) + "%"
		sPrenom	= Left ( idw_wTravail.GetItemString ( 1, "PRENOM" ), 5 ) + "%"

		lTotHomonyme = idw_Homonyme.Retrieve ( sNom, sPrenom )
		idw_Homonyme.Sort ()
		idw_Homonyme.GroupCalc ()

		lIdOrdre = idw_wTravail.GetItemNumber ( 1, "ID_ORDRE" )
		If	Not IsNull ( lIdOrdre ) Then
/*------------------------------------------------------------------*/
/* On va v$$HEX1$$e900$$ENDHEX$$rifier s'il existe plusieurs N$$HEX2$$b0002000$$ENDHEX$$ordre diff$$HEX1$$e900$$ENDHEX$$rents dans    */
/* la DW des homonymes. S'il existe  plusieurs sinistres, mais un   */
/* seul N$$HEX2$$b0002000$$ENDHEX$$ordre pour tous, on va comparer ce N$$HEX2$$b0002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, $$HEX2$$e0002000$$ENDHEX$$celui  */
/* que l'on poss$$HEX1$$e900$$ENDHEX$$de actuellement. ( Issu normalement de la          */
/* recherche des sinistres li$$HEX1$$e900$$ENDHEX$$s ). Si ces deux num$$HEX1$$e900$$ENDHEX$$ros sont         */
/* identiques, on fait un reset de la DW pour ne pas afficher la    */
/* fen$$HEX1$$ea00$$ENDHEX$$tre de recherche des homonymes. (Cela ne servirait en effet  */
/* $$HEX2$$e0002000$$ENDHEX$$rien).                                                         */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Maintenant, il est possible de modifier le NOM et le PRENOM de   */
/* la personne. On peut donc tr$$HEX1$$e900$$ENDHEX$$s bien avoir un N$$HEX2$$b0002000$$ENDHEX$$ordre (          */
/* r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX2$$e9002000$$ENDHEX$$par les sinistres pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dents ), et modifier totalement  */
/* les zones NOM et PRENOM. La consequence est que l'on ne          */
/* retrouve plus d'homonyme.                                        */
/*------------------------------------------------------------------*/
			bReset = True
			If	lTotHomonyme <> 0 Then
				lIdOrdreLu = idw_Homonyme.GetItemNumber ( 1, "ID_ORDRE" )
			End If
	
			For	lCpt  = 2 To lTotHomonyme
					If lIdOrdreLu <> idw_Homonyme.GetItemNumber ( lCpt, "ID_ORDRE" )	Then
						bReset = False
						Exit
					End If
			Next

			If bReset And lIdOrdre = lIdOrdreLu Then idw_Homonyme.Reset ()

		End If
	End If
End If
		
astPass.sTab [ 1 ] 	= sPos
astPass.bRetour 		= ibSinLie

end subroutine

private function date uf_cast_dte_edms (decimal adcdte);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Cast_Dte_Edms (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/07/1998 09:51:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: La date EDMS est au format NUMBER (AAAAMMJJ), il faut la caster pour produire une date
//*
//* Arguments		: Decimal{0}	adcDte			(Val)	Date qu'il faut traiter 
//*
//* Retourne		: Date			
//*
//*-----------------------------------------------------------------

Date dRet
String sDat

sDat = String ( adcDte )

sDat =	Right ( sDat, 2 )		+ "/" + &
			Mid ( sDat, 5, 2 )	+ "/" + &
			Left ( sDat, 4 )

If	Isdate ( sDat ) Then
	dRet = Date ( sDat )
Else
	dRet = stNul.Dat
End If

Return dRet
end function

private function integer uf_ctrl_courcli_recu ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Ctrl_CourCli_Recu (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de DTE_COUR_CLI et DTE_RECU
//*
//* Arguments		: Aucun
//*
//* Retourne		: Long		 1 = Les dates sont correctes
//*									-1 = Les dates ne sont pas correctes
//*
//*-----------------------------------------------------------------

Integer iRet

DateTime dDteCourCli, dDteRecu // [PI056] date -> datetime

iRet = 1

Choose Case idw_wTravail.isNomCol
Case "DTE_COUR_CLI"
	dDteCourCli		= DateTime ( idw_wTravail.GetText () )
	dDteRecu			= idw_wTravail.GetItemDateTime ( 1, "DTE_RECU" )

Case "DTE_RECU"
	dDteCourCli		= idw_wTravail.GetItemDateTime ( 1, "DTE_COUR_CLI" )
	dDteRecu			= DateTime ( idw_wTravail.GetText () )

End Choose

/*------------------------------------------------------------------*/
/* Si les deux dates sont saisies, on v$$HEX1$$e900$$ENDHEX$$rifie que la date du        */
/* courrier client n'est pas strictement sup$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la date de    */
/* r$$HEX1$$e900$$ENDHEX$$ception.                                                       */
/*------------------------------------------------------------------*/
If	Not IsNull ( dDteCourCli ) And Not IsNull ( dDteRecu )	Then
	If	dDteCourCli > dDteRecu	Then
		iRet = -1
	End If
End If

Return ( iRet )

end function

private function integer uf_ctrl_courcli_surv ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Ctrl_CourCli_Surv (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de DTE_COUR_CLI et DTE_SURV
//*
//* Arguments		: Aucun
//*
//* Retourne		: Long		 1 = Les dates sont correctes
//*									-1 = Les dates ne sont pas correctes
//*
//*-----------------------------------------------------------------

Integer iRet

Date dDteCourCli, dDteSurv

iRet = 1

Choose Case idw_wTravail.isNomCol
Case "DTE_COUR_CLI"
	dDteCourCli		= Date ( idw_wTravail.GetText () )
	dDteSurv			= Date(idw_wTravail.GetItemDateTime ( 1, "DTE_SURV" )) // [PI056] date -> datetime

Case "DTE_SURV"
	dDteCourCli		= Date(idw_wTravail.GetItemDateTime ( 1, "DTE_COUR_CLI" )) // [PI056] date -> datetime
	dDteSurv			= Date ( idw_wTravail.GetText () )

End Choose

/*------------------------------------------------------------------*/
/* Si les deux dates sont saisies, on v$$HEX1$$e900$$ENDHEX$$rifie que la date du        */
/* courrier client n'est pas strictement inf$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la date de    */
/* survenance.                                                      */
/*------------------------------------------------------------------*/
If	Not IsNull ( dDteCourCli ) And Not IsNull ( dDteSurv )	Then
	If	dDteSurv > dDteCourCli	Then
		iRet = -1
	End If
End If

Return ( iRet )

end function

private function integer uf_ctrl_recu_surv ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Ctrl_Recu_Surv (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de DTE_RECU et DTE_SURV
//*
//* Arguments		: Aucun
//*
//* Retourne		: Long		 1 = Les dates sont correctes
//*									-1 = Les dates ne sont pas correctes
//*
//*-----------------------------------------------------------------

Integer iRet

DateTime dDteRecu, dDteSurv // [PI056] date -> datetime

iRet = 1

Choose Case idw_wTravail.isNomCol
Case "DTE_RECU"
	dDteRecu			= DateTime ( idw_wTravail.GetText () )
	dDteSurv			= idw_wTravail.GetItemDateTime ( 1, "DTE_SURV" )

Case "DTE_SURV"
	dDteRecu			= idw_wTravail.GetItemDateTime ( 1, "DTE_RECU" )
	dDteSurv			= DateTime ( idw_wTravail.GetText () )

End Choose

/*------------------------------------------------------------------*/
/* Si les deux dates sont saisies, on v$$HEX1$$e900$$ENDHEX$$rifie que la date de        */
/* r$$HEX1$$e900$$ENDHEX$$ception n'est pas strictement inf$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la date de          */
/* survenance.                                                      */
/*------------------------------------------------------------------*/
If	Not IsNull ( dDteRecu ) And Not IsNull ( dDteSurv )	Then
	If	dDteSurv > dDteRecu	Then
		iRet = -1
	End If
End If

Return ( iRet )

end function

private function long uf_verifier_adhesion_edms ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Verifier_Adhesion_Edms (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/07/1998 09:51:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va v$$HEX1$$e900$$ENDHEX$$rifier si l'adh$$HEX1$$e900$$ENDHEX$$sion existe dans la base EDMS
//*
//* Arguments		: Aucun
//*
//* Retourne		: Long				 0 = L'adh$$HEX1$$e900$$ENDHEX$$sion n'existe pas
//*											-1 = Pas de connection avec OPENA
//*											-2 = Erreur sur le SetTransObject
//*											-3 = Erreur sur les zones DTE_SOUS, DTE_OPT, DTE_RESIL, DTE_FINGTI, RIB
//*											 1 = L'adh$$HEX1$$e900$$ENDHEX$$sion existe ou toutes les zones ne sont pas saisies
//*
//*-----------------------------------------------------------------
//* #1  PLJ   27/12/2001  Ajout d'un st_message de temporisation
//*                       pour eviter la ruptutre de connexion, en cas de 
//*                       manipulation sans que la recherche soit termin$$HEX1$$e900$$ENDHEX$$e
//*-----------------------------------------------------------------

DataWindow dwTrtAdh, dwTrtMvts
DatawindowChild dwChild

String sCodAdh, sCodCiv, sNom, sPrenom, sAdr1, sAdr2, sAdrCp, sAdrVille
String sBqePlvt, sAgPlvt, sCptPlvt, sCle, sText, sNouvelleLigne

Long lRet, lLig, lIdEts, lIdAdh, lIdsDos, lCodBaseDms, lCodProdDms, lCodAdrDms, lOption
Long lNbAdherent, lCodTel, lNull

Decimal {0} dcDteAdh, dcDteEmbauc

Date dDteSous, dDteOpt, dDteFinGti, dDteResil

istMessage.Visible = True		//#1

SetNull ( lNull )
lRet					= 0
sText 				= ""
sNouvelleLigne		= "~r~n"

idw_wTravail.GetChild ( "ID_PROD", dwChild )

/*------------------------------------------------------------------*/
/* On recherche les informations du produit en cours de saisie.     */
/*------------------------------------------------------------------*/
If Not Uf_Recherche_Produit ( lLig, sCodAdh, lCodBaseDms, lCodProdDms, lCodAdrDms, lNbAdherent, lCodTel ) Then
/*------------------------------------------------------------------*/
/* Si toutes les zones ne sont pas saisies, on s'arrete.            */
/*------------------------------------------------------------------*/
	istMessage.Visible = False	//#1
	Return ( 1 )
End If

/*------------------------------------------------------------------*/
/* On peut se permettre de transformer la valeur de ID_ADH en       */
/* valeur num$$HEX1$$e900$$ENDHEX$$rique. En effet selon St Denis il y a au maximum 7    */
/* Chiffres.                                                        */
/*------------------------------------------------------------------*/
lIdAdh	= Long ( idw_wTravail.GetItemString ( 1, "ID_ADH" ) )
lIdEts	= idw_wTravail.GetItemNumber ( 1, "ID_ETS" )
lIdsDos	= idw_wTravail.GetItemNumber ( 1, "ID_SDOS" )

SetPointer ( HourGlass! )

If	Not IsValid ( itrEdms )	Then
	itrEdms = Create Transaction

	If	Not F_ConnectOpena ( stGLB.sFichierIni, "SIMPA2 EDMS", itrEdms, stMessage )	Then
/*------------------------------------------------------------------*/
/* La structure du message est arm$$HEX1$$e900$$ENDHEX$$e dans la fonction               */
/* F_ConnectOpena ().                                               */
/*------------------------------------------------------------------*/
		F_Message ( stMessage )
		lRet = -1
	End If
End If

If	lRet = 0 Then
	Choose Case lCodBaseDms
	Case 1							// Base CLX
		If	Not ibInitClx	Then
			If	idw_Edms_Clx_Adh.SetTransObject ( itrEdms ) < 0 Then 
				lRet = -2
			Else
				ibInitClx	= True
				idw_Edms_Clx_Mvts.SetTransObject ( itrEdms )
			End If
		End If

		dwTrtAdh		= idw_Edms_Clx_Adh
		dwTrtMvts	= idw_Edms_Clx_Mvts

	Case 2							// Base PXXX
		If	Not ibInitPxxx	Then
			If idw_Edms_Pxxx_Adh.SetTransObject ( itrEdms ) < 0 Then
				lRet = -2
			Else
				ibInitPxxx	= True
				idw_Edms_Pxxx_Mvts.SetTransObject ( itrEdms )
			End If
		End If

		dwTrtAdh		= idw_Edms_Pxxx_Adh
		dwTrtMvts	= idw_Edms_Pxxx_Mvts

	Case 3							// Base CIC
		If	Not ibInitCic	Then
			If idw_Edms_Cic_Adh.SetTransObject ( itrEdms ) < 0 Then
				lRet = -2
			Else
				ibInitCic	= True
				idw_Edms_Cic_Mvts.SetTransObject ( itrEdms )
			End If
		End If

		dwTrtAdh		= idw_Edms_Cic_Adh
		dwTrtMvts	= idw_Edms_Cic_Mvts

	Case 4							// Base PRODSEC DCMP000306 DBI 16/10/2000
		If	Not ibInitSri	Then
			If idw_Edms_Sri_Adh.SetTransObject ( itrEdms ) < 0 Then
				lRet = -2
			Else
				ibInitSri	= True
				idw_Edms_Sri_Mvts.SetTransObject ( itrEdms )
/*------------------------------------------------------------------*/
/* Le 26/09/2001. Modification DGA (Suite demande AMO LUC).         */
/* Facturation ESPRIT LIBRE DCMP 010302                             */
/*------------------------------------------------------------------*/
				idw_Edms_Sri_Ref_Facturation.SetTransObject ( itrEdms )
				idw_Edms_Sri_Lig_Facturation.SetTransObject ( itrEdms )
			End If
		End If

		dwTrtAdh		= idw_Edms_Sri_Adh
		dwTrtMvts	= idw_Edms_Sri_Mvts

	Case 5							// Base PRODTEL DCMP000306 DBI 16/10/2000
		If	Not ibInitTel	Then
			If idw_Edms_Tel_Adh.SetTransObject ( itrEdms ) < 0 Then
				lRet = -2
			Else
				ibInitSri	= True
				idw_Edms_Tel_Mvts.SetTransObject ( itrEdms )
			End If
		End If

		dwTrtAdh		= idw_Edms_Tel_Adh
		dwTrtMvts	= idw_Edms_Tel_Mvts

	End Choose

/*------------------------------------------------------------------*/
/* Si l'initialisation des objets de transaction se passe bien, on  */
/* peut d$$HEX1$$e900$$ENDHEX$$clencher un retrieve.                                     */
/*------------------------------------------------------------------*/
	If lRet = 0 Then
		dwTrtAdh.Reset ()	
		dwTrtMvts.Reset ()	
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re l'adh$$HEX1$$e900$$ENDHEX$$sion en cours de traitement.                   */
/*------------------------------------------------------------------*/
		lRet = dwTrtAdh.Retrieve ( lCodProdDms, lIdEts, lIdAdh, lIdsDos )

	End If

End If

SetPointer ( Arrow! )

If	lRet > 0 Then

/*----------------------------------------------------------------------------*/
/* Pascal nous met $$HEX2$$e0002000$$ENDHEX$$0 la banque et l'agence pour les produits de Tel,        */
/* afin que l'adh$$HEX1$$e900$$ENDHEX$$sion soit trouv$$HEX1$$e900$$ENDHEX$$e, je les remet donc $$HEX2$$e0002000$$ENDHEX$$null dans ce cas.    */
/*----------------------------------------------------------------------------*/
	If dwTrtAdh.GetItemNumber ( 1, "DOSAD_BQE_PLVT" ) = 0 Then dwTrtAdh.SetItem ( 1, "DOSAD_BQE_PLVT", lNull )
	If dwTrtAdh.GetItemNumber ( 1, "DOSAD_AG_PLVT" ) = 0 Then dwTrtAdh.SetItem ( 1, "DOSAD_AG_PLVT", lNull )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re maintenant les mouvements financiers qui sont        */
/* positionn$$HEX1$$e900$$ENDHEX$$s sur l'adh$$HEX1$$e900$$ENDHEX$$rent principal.                            */
/*------------------------------------------------------------------*/
	dwTrtMvts.Retrieve ( lCodProdDms, lIdEts, lIdAdh, 1 )

/*------------------------------------------------------------------*/
/* On recopie les informations concernant l'adh$$HEX1$$e900$$ENDHEX$$sion et les         */
/* mouvements financiers dans les DW de stockage.                   */
/*------------------------------------------------------------------*/
	idw_Adh.Reset ()
	idw_Mvts.Reset ()

	dwTrtAdh.RowsCopy ( 1, 1, Primary!, idw_Adh, 1, Primary! )
	dwTrtMvts.RowsCopy ( 1, 9999, Primary!, idw_Mvts, 1, Primary! )

/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re les zones de DATA - en les castant si besoin - dans    */
/* la DW de saisie.                                                 */
/*------------------------------------------------------------------*/
	If	lCodAdrDms = 1	Then
		sAdr1			= Trim ( idw_Adh.GetItemString ( 1, "DOSAD_ADRESSE1" ) )
		sAdr2			= Trim ( idw_Adh.GetItemString ( 1, "DOSAD_ADRESSE2" ) )
		sAdrCp		= idw_Adh.GetItemString ( 1, "DOSAD_CPOSTALE" )
		sAdrVille	= idw_Adh.GetItemString ( 1, "DOSAD_VILLE" )

		idw_wTravail.SetItem ( 1, "ADR_1", sAdr1 )
 		idw_wTravail.SetItem ( 1, "ADR_2", sAdr2 )
		idw_wTravail.SetItem ( 1, "ADR_CP", sAdrCp )
		idw_wTravail.SetItem ( 1, "ADR_VILLE", sAdrVille )
	End If

	sCodCiv	= String ( idw_Adh.GetItemNumber ( 1, "DOSAD_CIVILITE" ) )
	sNom		= idw_Adh.GetItemString ( 1, "DOSAD_NOM" )
	sPrenom	= idw_Adh.GetItemString ( 1, "DOSAD_PRENOM" )
	lOption	= idw_Adh.GetItemNumber ( 1, "DOSAD_C_OPTION" )

	idw_wTravail.SetItem ( 1, "COD_CIV", sCodCiv )
	idw_wTravail.SetItem ( 1, "NOM", sNom )
	idw_wTravail.SetItem ( 1, "PRENOM", sPrenom )
	idw_wTravail.SetItem ( 1, "OPTION", lOption )

	dcDteEmbauc		= idw_Adh.GetItemNumber ( 1, "DOSAD_DT_EMBAUC" )
	dcDteAdh			= idw_Adh.GetItemNumber ( 1, "DOSAD_DAT_ADH" )

	dDteSous			= Uf_Cast_Dte_Edms ( dcDteAdh )
	dDteOpt			= Uf_Cast_Dte_Edms ( dcDteEmbauc )
	
	idw_wTravail.SetItem ( 1, "DTE_SOUS", dDteSous )
	idw_wTravail.SetItem ( 1, "DTE_OPT", dDteOpt )

/*------------------------------------------------------------------*/
/* On s'occupe des zones OPTION et DTE_ADH.                         */
/*------------------------------------------------------------------*/
	lRet = Uf_Edms_DteAdh ( dcDteEmbauc, dcDteAdh )

/*------------------------------------------------------------------*/
/* On s'occupe des zones pour la t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie.                        */
/* Seule l'acc$$HEX1$$e800$$ENDHEX$$s est autoris$$HEX2$$e9002000$$ENDHEX$$par le fichier ini et seulement le    */
/* G$$HEX1$$e800$$ENDHEX$$re la t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie.															  */
/*------------------------------------------------------------------*/
	If dwChild.GetItemNumber ( lLig, "COD_TEL" ) > 0 Then
		uf_Edms_Telephonie ( lCodTel, lCodProdDms )
	End If


/*------------------------------------------------------------------*/
/* On s'occupe de la zone DTE_RESIL.                                */
/*------------------------------------------------------------------*/
	Uf_Edms_DteResil ()

/*------------------------------------------------------------------*/
/* On s'occupe de la zone DTE_FIN_GTI.                              */
/*------------------------------------------------------------------*/
	If	sCodAdh = "1" Then
		Uf_Edms_DteFinGti ()
	Else
		idw_wTravail.SetItem ( 1, "DTE_FIN_GTI", stNul.Dat )
	End If
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le RIB de l'assur$$HEX2$$e9002000$$ENDHEX$$dans des varaibles.               */
/*------------------------------------------------------------------*/
	sBqePlvt		= String ( idw_Adh.GetItemNumber ( 1, "DOSAD_BQE_PLVT" ), "00000" )
	sAgPlvt		= String ( idw_Adh.GetItemNumber ( 1, "DOSAD_AG_PLVT" ),  "00000" )
	sCptPlvt		= idw_Adh.GetItemString ( 1, "DOSAD_CPT_PLVT" )
	sCle			= idw_Adh.GetItemString ( 1, "DOSAD_CLE" )

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie la v$$HEX1$$e900$$ENDHEX$$racit$$HEX2$$e9002000$$ENDHEX$$des informatiosn r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es.              */
/*------------------------------------------------------------------*/
	If	lRet > 0 Then
		If	IsNull  ( dDteSous ) Or Year ( dDteSous ) = 1900 Then 
			sText = sText + " - la zone SEDOSAD_DOSAD.DAT_ADH" + sNouvelleLigne
			lRet = -3
		End If

		dDteFinGti	= Date(idw_wTravail.GetItemDateTime ( 1, "DTE_FIN_GTI" )) // [PI056] date -> datetime
		dDteResil 	= Date(idw_wTravail.GetItemDateTime ( 1, "DTE_RESIL" )) // [PI056] date -> datetime

		If	( IsNull  ( dDteFinGti ) Or Year ( dDteFinGti ) = 1900 ) And sCodAdh = "1" Then 
			sText = sText + " - la date de fin de garantie" + sNouvelleLigne
			lRet = -3
		End If

		If	Year ( dDteResil ) = 1900 Then 
			sText = sText + " - la date de r$$HEX1$$e900$$ENDHEX$$siliation" + sNouvelleLigne
			lRet = -3
		End If

/*------------------------------------------------------------------*/
/* Le 03/07/01 par JFF : On ne contr$$HEX1$$f400$$ENDHEX$$le le Rib que pour les produits*/
/* qui n'ont pas de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie. En effet les produits de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie */
/* n'ont pas forc$$HEX1$$e900$$ENDHEX$$ment un pr$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$vement de prime par ib, mais par Ch$$HEX1$$e800$$ENDHEX$$-*/
/* que, dans ce cas l'adh$$HEX1$$e900$$ENDHEX$$sion est rejet$$HEX1$$e900$$ENDHEX$$, le RIB n'$$HEX1$$e900$$ENDHEX$$tant pas correc*/
/* te puisque inexistant. ce contr$$HEX1$$f400$$ENDHEX$$le permet de passer.				  */
/*------------------------------------------------------------------*/
		If lCodTel <= 0 Then
			If	Not F_Rib ( sBqePlvt, sAgPlvt, sCptPlvt, sCle ) Then 
				sText = sText + " - le RIB assur$$HEX1$$e900$$ENDHEX$$" + sNouvelleLigne
				lRet = -3
			End If
		End If

		If	lRet = -3 Then
			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
			stMessage.Icon			= StopSign!
			stMessage.bErreurG	= False
			stMessage.sVar[1]		= sText
			stMessage.sCode		= "WORK270"

			F_Message ( stMessage )
		End If
	End If
End If

istMessage.Visible = False	//#1
Return ( lRet )
end function

private subroutine uf_ecriretrace ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_EcrireTrace ( Private )
//* Auteur			: Erick John Stark
//* Date				: 04/28/97 14:57:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: VOIR L'OBJET CONTACT_TRACE, LA FONCTION Y EST DUPLIQUEE.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lTot, lCpt

String sTrace[26]
String sLigne, sTab, sCodTravail, sAltQueue

/*------------------------------------------------------------------*/
/* On va ecrire une trace dans le fichier.                          */
/* Cette trace contient dans l'ordre                                */
/*                                                                  */
/* COD_APPLI						01                                    */
/* N$$HEX2$$b0002000$$ENDHEX$$Machine						02                                    */
/* COD_SERVICE						03                                    */
/* ID_SIN							04                                    */
/* ID_CORB 							05                                    */
/* NOM + PRENOM					06                                    */
/* COD_ETAT 						07  1 Par d$$HEX1$$e900$$ENDHEX$$faut                      */
/* COD_ACTION 						08                                    */
/* ALT_BLOC 						09  N Par d$$HEX1$$e900$$ENDHEX$$faut                      */
/* TRV_CREE_LE (D$$HEX1$$e900$$ENDHEX$$part)			10                                    */
/* TRV_MAJ_LE (D$$HEX1$$e900$$ENDHEX$$part)			11                                    */
/* TRV_MAJ_LE (Fin)				12                                    */
/* TRV_MAJ_PAR (Fin)				13                                    */
/* TRV_ROUTE_LE (Fin)			14  Vide                              */
/* TRV_ROUTE_PAR (Fin)			15  Vide                              */
/* TRV_EDITE_LE (Fin)			16  Vide                              */
/* TRV_EDITE_PAR (Fin)			17  Vide                              */
/* DOS_MAJ_LE (Fin)				18                                    */
/* DOS_MAJ_PAR (Fin)				19                                    */
/* DOS_MAJ_PAR (Fin)				20                                    */
/* ID_PROD							21                                    */
/* DTE_RECU							22                                    */
/* COD_TYP_RECU					23                                    */
/* COD_RECU							24                                    */
/* COD_I_PROV						25                                    */
/* DTE_COUR_CLI					26                                    */
/*------------------------------------------------------------------*/

sTab = "~t"
lTot = UpperBound ( sTrace )

sTrace[ 1 ]  = stGLB.sCodAppli
sTrace[ 2 ]  = isNomMachine
sTrace[ 3 ]  = stGLB.sCodServ
sTrace[ 4 ]  = String ( idw_wTravail.GetItemNumber ( 1, "ID_SIN" ) )
sTrace[ 5 ]  = String ( idw_wTravail.GetItemNumber ( 1, "ID_CORB" ) )
sTrace[ 6 ]  = idw_wTravail.GetItemString ( 1, "NOM" ) + " " + idw_wTravail.GetItemString ( 1, "PRENOM" )
sTrace[ 7 ]  = "1"
sTrace[ 8 ]  = ""
sTrace[ 9 ]		= "N"
sTrace[ 10 ]	= String ( idtDebutSaisie, "dd/mm/yyyy hh:mm:ss.ff" )
sTrace[ 11 ]	= String ( idtDebutSaisie, "dd/mm/yyyy hh:mm:ss.ff" )

sTrace[ 12 ]	= String ( idw_wTravail.GetItemDateTime ( 1, "CREE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )
sTrace[ 13 ]	= stGLB.sCodOper
sTrace[ 14 ]	= ""
sTrace[ 15 ]	= ""
sTrace[ 16 ]	= ""
sTrace[ 17 ]	= ""
sTrace[ 18 ]	= sTrace[ 12 ]
sTrace[ 19 ]	= "CREE"
sTrace[ 20 ]	= String ( idw_wTravail.GetItemNumber ( 1, "NB_PAGE" ) )

sTrace[ 21 ]	= String ( idw_wTravail.GetItemNumber ( 1, "ID_PROD" 	) )
sTrace[ 22 ]	= String ( idw_wTravail.GetItemDateTime ( 1, "DTE_RECU" 		), "dd/mm/yyyy" ) // [PI056] date -> datetime

If	idw_wTravail.GetItemString ( 1, "COD_TYP_RECU" ) = "D" Then
	sTrace[ 23 ]  = "0"
Else
	sCodTravail = idw_Routage.GetItemString ( 1, "COD_TRAVAIL" )
	sAltQueue	= idw_Routage.GetItemString ( 1, "ALT_QUEUE" )

	Choose Case sCodTravail
	Case "CPL"
		If sAltQueue = "N"	Then
			sTrace[ 23 ]  = "1"
		Else
			sTrace[ 23 ]  = "4"
		End If

	Case "CAS"
		sTrace[ 23 ]  = "2"

	Case "DEC"
		sTrace[ 23 ]  = "3"

	End Choose
End If

sTrace[ 24 ]	= idw_wTravail.GetItemString ( 1, "COD_RECU" 				)
sTrace[ 25 ]	= idw_wTravail.GetItemString ( 1, "COD_I_PROV"				)
sTrace[ 26 ]	= String ( idw_wTravail.GetItemDateTime ( 1, "DTE_COUR_CLI" ), "dd/mm/yyyy" ) // [PI056] date -> datetime

sLigne	= ""
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie qu'il n'y ait plus de cha$$HEX1$$ee00$$ENDHEX$$ne nulle.                   */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot
		If	IsNull ( sTrace[ lCpt ] ) Or sTrace[ lCpt ] = "''" Then
			sTrace[ lCpt ] = ""
		End If
Next

/*------------------------------------------------------------------*/
/* On traite les N-1 valeurs, puis la derni$$HEX1$$e800$$ENDHEX$$re. Pour terminer, on   */
/* ecrit la ligne                                                   */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot - 1
		sLigne = sLigne + sTrace[ lCpt ] + sTab
Next

sLigne = sLigne + sTrace[ lTot ]

f_EcrireFichierText ( isFicTrace, sLigne )

end subroutine

private subroutine uf_ecriretrace_adresse ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_EcrireTrace_Adresse ( Private )
//* Auteur			: Erick John Stark
//* Date				: 04/28/97 14:57:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lTot, lCpt

String sTrace[13]
String sLigne, sTab, sAltAdr

/*------------------------------------------------------------------*/
/* On va ecrire une trace dans le fichier.                          */
/* Cette trace contient dans l'ordre                                */
/*                                                                  */
/* ID_SIN							01                                    */
/* ID_PROD 							02                                    */
/* ID_ETS							03                                    */
/* ID_ADH	 						04                                    */
/* ID_SDOS							05                                    */
/* ADR_1		 						06                                    */
/* ADR_2								07                                    */
/* ADR_CP							08                                    */
/* ADR_VILLE						09                                    */
/* NOM								10                                    */
/* PRENOM							11                                    */
/* DOS_MAJ_LE (Fin)				12                                    */
/* DOS_MAJ_PAR (Fin)				13                                    */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Le gestionnaire a t-il modifi$$HEX2$$e9002000$$ENDHEX$$les coordonn$$HEX1$$e900$$ENDHEX$$es ?                 */
/*------------------------------------------------------------------*/
sAltAdr = idw_wTravail.GetItemString ( 1, "ALT_ADR" )
If	sAltAdr = "N"	Then
	Return
End If

sTab = "~t"
lTot = UpperBound ( sTrace )

sTrace[  1 ]  = String ( idw_wTravail.GetItemNumber ( 1, "ID_SIN" ) )
sTrace[  2 ]  = String ( idw_wTravail.GetItemNumber ( 1, "ID_PROD" ) )
sTrace[  3 ]  = String ( idw_wTravail.GetItemNumber ( 1, "ID_ETS" ) )
sTrace[  4 ]  = idw_wTravail.GetItemString ( 1, "ID_ADH" )
sTrace[  5 ]  = String ( idw_wTravail.GetItemNumber ( 1, "ID_SDOS" ) )
sTrace[  6 ]  = Trim ( idw_wTravail.GetItemString ( 1, "ADR_1" ) )
sTrace[  7 ]  = Trim ( idw_wTravail.GetItemString ( 1, "ADR_2" ) )
sTrace[  8 ]  = idw_wTravail.GetItemString ( 1, "ADR_CP" )
sTrace[  9 ]  = Trim ( idw_wTravail.GetItemString ( 1, "ADR_VILLE" ) )
sTrace[ 10 ]  = Trim ( idw_wTravail.GetItemString ( 1, "NOM" ) )
sTrace[ 11 ]  = Trim ( idw_wTravail.GetItemString ( 1, "PRENOM" ) )
sTrace[ 12 ]  = String ( idw_wTravail.GetItemDateTime ( 1, "CREE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )
sTrace[ 13 ]  = stGLB.sCodOper

sLigne	= ""
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie qu'il n'y ait plus de cha$$HEX1$$ee00$$ENDHEX$$ne nulle.                   */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot
		If	IsNull ( sTrace[ lCpt ] ) Or sTrace[ lCpt ] = "''" Then
			sTrace[ lCpt ] = ""
		End If
Next

/*------------------------------------------------------------------*/
/* On traite les N-1 valeurs, puis la derni$$HEX1$$e800$$ENDHEX$$re. Pour terminer, on   */
/* ecrit la ligne                                                   */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot - 1
		sLigne = sLigne + sTrace[ lCpt ] + sTab
Next

sLigne = sLigne + sTrace[ lTot ]

f_EcrireFichierText ( isFicTraceAdr, sLigne )

end subroutine

private subroutine uf_edms_dteresil ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Edms_DteResil (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/07/1998 09:51:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Traitement de la date de r$$HEX1$$e900$$ENDHEX$$siliation r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Date dDteResil

Long lTotMvts, lCpt, lMvtsCodeMouv, lJour

Decimal {0} dcMvtsParam5, dcDerEch, dcStatut

Integer iAn, iMois

String sDat

/*------------------------------------------------------------------*/
/* La DW idw_Adh contient les informations relatives $$HEX2$$e0002000$$ENDHEX$$l'adh$$HEX1$$e900$$ENDHEX$$sion   */
/* courante. La DW idw_Mvts contient toutes les informations        */
/* concernant les mouvements financiers.                            */
/*------------------------------------------------------------------*/
lTotMvts		= idw_Mvts.RowCount ()
dDteResil	= stNul.Dat

/*------------------------------------------------------------------*/
/* Si le STATUT du dossier est $$HEX2$$e0002000$$ENDHEX$$1 ou $$HEX2$$e0002000$$ENDHEX$$4, il faut calculer la      */
/* date de r$$HEX1$$e900$$ENDHEX$$siliation.                                             */
/*------------------------------------------------------------------*/
dcStatut = idw_Adh.GetItemNumber ( 1, "DOSAD_STATUT" )

If	dcStatut = 1 Or dcStatut = 4	Then
/*------------------------------------------------------------------*/
/* On recherche un code mouvement de type 3 dans la liste des       */
/* mouvements. Si on en trouve un, on v$$HEX1$$e900$$ENDHEX$$rifie la zone MVTS_PARAM5.  */
/* Si cette zone n'est pas vide, elle contient la date de           */
/* r$$HEX1$$e900$$ENDHEX$$siliation, sinon il faut prendre le dernier jour du mois de    */
/* DOSAD_DER_ECH.                                                   */
/*------------------------------------------------------------------*/
	For	lCpt = lTotMvts To 1	Step -1
			lMvtsCodeMouv	= idw_Mvts.GetItemNumber ( lCpt, "MVTS_CODE_MOUV" )

			If	lMvtsCodeMouv = 3	Then
				dcMvtsParam5		= idw_Mvts.GetItemNumber ( lCpt, "MVTS_PARAM5" )

				If	dcMvtsParam5 <> 0 Then
					dDteResil = Uf_Cast_Dte_Edms ( dcMvtsParam5 )
				Else
/*------------------------------------------------------------------*/
/* La zone DOSAD_DER_ECH est au format AAAAMM. Il faut donc         */
/* calculer la fin du mois.                                         */
/*------------------------------------------------------------------*/
					dcDerEch = idw_Adh.GetItemNumber ( 1, "DOSAD_DER_ECH" )
					iMois		= Integer ( Right ( String ( dcDerEch ), 2 ) )
					iAn		= Integer ( Left ( String ( dcDerEch ), 4 ) )
					lJour		= F_Fin_Mois ( iAn, iMois )

					sDat =	String ( lJour ) + "/" + &
								String ( iMois ) + "/" + &
								String ( iAn )

					dDteResil = Date ( sDat )
				End If
				Exit
			End If
	Next
End If

idw_wTravail.SetItem ( 1, "DTE_RESIL", dDteResil )



 




end subroutine

private subroutine uf_edms_dtefingti ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Edms_DteFinGti (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/07/1998 09:51:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Traitement de la date de fin de garantie r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lTotMvts, lCpt, lMvtsCodeMouv, lCpt1

Date dDteFinGti, dParam3, dParam2, dDteResil, dDteFinGtiEspritLibre

Long lIdProd, lIdEts, lIdAdh, lIdsDos, lIdProdEdms
Long lTotRefFacturation, lTotLigFacturation, lCodBq, lCodAg, lNumCtr
String sLibId, sTypeCtr, sIdEts

Decimal {0} dcTmp, dcMvtsParam7, dcMvtsParam3, dcMvtsParam2, dcMvtsParam3_Gratuit, dcMvtsParam3_13
Decimal {0} dcMvtsCyclePlvt, dcParam3EspritLibre

Decimal {2} dcMtSolde

Boolean bRemBoursement, bSecurilion, bImpaye, bGratuit

lTotMvts			= idw_Mvts.RowCount ()
lIdProd			= idw_wTravail.GetItemNumber ( 1, "ID_PROD" )
lIdProdEdms		= idw_Adh.GetItemNumber ( 1, "DOSAD_CODE_PROD" )
dDteFinGti		= stNul.Dat
dcMvtsParam7	= 0
dcMvtsParam3	= 0
dcMvtsParam2	= 0
bRemboursement	= False
bSecurilion		= False
bImpaye			= False
bGratuit			= False


/*------------------------------------------------------------------*/
/* On positionne une variable d'instance pour savoir si on est      */
/* dans le cas d'un produit SECURILION. Cela va nous permettre de   */
/* d$$HEX1$$e900$$ENDHEX$$terminer si on est dans un cas particulier.                    */
/*------------------------------------------------------------------*/
Choose Case lIdProd
Case 901, 902, 904, 905
/*------------------------------------------------------------------*/
/* On prend la valeur de MVTS_CYCLE_PLVT. Si cette valeur est       */
/* $$HEX1$$e900$$ENDHEX$$gale $$HEX2$$e0002000$$ENDHEX$$3, on se trouve dans un cas particulier. Il faut         */
/* prendre la fin du trimestre et non la date d'adh$$HEX1$$e900$$ENDHEX$$sion.           */
/*------------------------------------------------------------------*/
	If	idw_Mvts.GetItemNumber ( lTotMvts, "MVTS_CYCLE_PLVT" ) = 3 Then
		bSecurilion = True
	End If
End Choose

/*------------------------------------------------------------------*/
/* On recherche MVTS_PARAM7 le plus grand avec                      */
/* MVTS_CODE_MOUV = 13, 14, 15.                                     */
/* 13 = Cr$$HEX1$$e900$$ENDHEX$$ation Adh$$HEX1$$e900$$ENDHEX$$sion                                           */
/* 14 = Pr$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$vement                                                 */
/* 15 = Rappel                                                      */
/* Une fois que l'on trouve ce mouvement, on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la valeur     */
/* de PARAM3. (Sauf 999999)                                         */
/*------------------------------------------------------------------*/
For	lCpt = lTotMvts To 1 Step -1
		lMvtsCodeMouv	= idw_Mvts.GetItemNumber ( lCpt, "MVTS_CODE_MOUV" )

		If	( lMvtsCodeMouv = 13 Or lMvtsCodeMouv = 14 Or lMvtsCodeMouv = 15 ) Then
			dcTmp = idw_Mvts.GetItemNumber ( lCpt, "MVTS_PARAM7" )
			If	dcMvtsParam7 < dcTmp	Then
				If	idw_Mvts.GetItemNumber ( lCpt, "MVTS_PARAM3" ) <> 999999 Then
					dcMvtsParam3 = idw_Mvts.GetItemNumber ( lCpt, "MVTS_PARAM3" )
				End If
				dcMvtsParam7 = dcTmp
			End If
		End If
Next

/*------------------------------------------------------------------*/
/* Si MVTS_PARAM3 est $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro (Dossier jamais pr$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$) la date  */
/* de fin de garantie est $$HEX1$$e900$$ENDHEX$$gale $$HEX2$$e0002000$$ENDHEX$$la date d'adh$$HEX1$$e900$$ENDHEX$$sion.               */
/*------------------------------------------------------------------*/
If	dcMvtsParam3 = 0 Then
	dDteFinGti = Date(idw_wTravail.GetItemDateTime ( 1, "DTE_ADH" )) // [PI056] date -> datetime
Else
/*------------------------------------------------------------------*/
/* La zone MVTS_PARAM3 est une p$$HEX1$$e900$$ENDHEX$$riode sous la forme SSAAMM, on     */
/* lui plaque le jour d'adh$$HEX1$$e900$$ENDHEX$$sion, on lui ajoute un mois et on lui   */
/* retire un jour. (Au moment ou on plaque le jour d'adh$$HEX1$$e900$$ENDHEX$$sion, si   */
/* on trouve une p$$HEX1$$e900$$ENDHEX$$riode invalide, il faut soustraire 1 (ou 2)      */
/* jour pour obtenir une date normale, puis lui ajouter un mois et  */
/* ne surtout plus retirer un jour ).                               */
/*------------------------------------------------------------------*/
		dParam3 = Uf_Calcul_Periode_Edms ( bSecurilion, dcMvtsParam3, 1 )
		dDteFinGti = dParam3
End If

/*------------------------------------------------------------------*/
/* On g$$HEX1$$e900$$ENDHEX$$re maintenant les impay$$HEX1$$e900$$ENDHEX$$s. Si le SOLDE de l'adh$$HEX1$$e900$$ENDHEX$$sion est    */
/* sup$$HEX1$$e900$$ENDHEX$$rieur $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro, on recherche les MVTS impay$$HEX1$$e900$$ENDHEX$$s dans l'ordre     */
/* d$$HEX1$$e900$$ENDHEX$$croissant. Le premier trouv$$HEX2$$e9002000$$ENDHEX$$est forc$$HEX1$$e900$$ENDHEX$$ment le bon.             */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On recherche MVTS_PARAM2 (Sauf 999999) le plus grand avec        */
/* MVTS_CODE_MOUV = 01.                                             */
/* 01 = Impay$$HEX1$$e900$$ENDHEX$$s                                                     */
/*------------------------------------------------------------------*/
dcMtSolde = idw_Adh.GetItemNumber ( 1, "DOSAD_MT_SOLDE" )
If	dcMtSolde > 0 Then
	For	lCpt = lTotMvts To 1 Step -1
			lMvtsCodeMouv	= idw_Mvts.GetItemNumber ( lCpt, "MVTS_CODE_MOUV" )
			If	( lMvtsCodeMouv = 1 ) Then
				bImpaye	= True
				dcTmp = idw_Mvts.GetItemNumber ( lCpt, "MVTS_PARAM2" )
				If	dcMvtsParam2 < dcTmp	Then
					dcMvtsParam2 = dcTmp
					Exit
				End If
			End If
	Next

	If	bImpaye	Then
/*------------------------------------------------------------------*/
/* Si PARAM2 est $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$999999 ( en th$$HEX1$$e900$$ENDHEX$$orie possible pour un        */
/* impay$$HEX2$$e9002000$$ENDHEX$$sur un rappel ), on prend le dernier PARAM3 obtenu plus   */
/* haut, on lui enl$$HEX1$$e900$$ENDHEX$$ve un cycle de pr$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$vement, ( -1 Mois ), on     */
/* plaque le jour d'adh$$HEX1$$e900$$ENDHEX$$sion et on lui enl$$HEX1$$e900$$ENDHEX$$ve un jour.              */
/*------------------------------------------------------------------*/
		If	dcMvtsParam2 = 999999 Then
/*------------------------------------------------------------------*/
/* On va retirer la valeur du cycle de pr$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$vement.                 */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La valeur de lCpt correspond au Mouvement trouv$$HEX1$$e900$$ENDHEX$$.                */
/*------------------------------------------------------------------*/
			dcMvtsCyclePlvt = idw_Mvts.GetItemNumber ( lCpt, "MVTS_CYCLE_PLVT" )
			dcMvtsCyclePlvt = - ( dcMvtsCyclePlvt - 1 )

			dParam3 = Uf_Calcul_Periode_Edms ( bSecurilion, dcMvtsParam3, dcMvtsCyclePlvt )
			dDteFinGti = dParam3

		Else
/*------------------------------------------------------------------*/
/* On vient d'obtenir le d$$HEX1$$e900$$ENDHEX$$but de la p$$HEX1$$e900$$ENDHEX$$riode du pr$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$vement         */
/* impay$$HEX1$$e900$$ENDHEX$$, on lui plaque le jour d'adh$$HEX1$$e900$$ENDHEX$$sion et on lui enl$$HEX1$$e900$$ENDHEX$$ve un     */
/* jour. Si cette date obtenue est inf$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la date d'adh$$HEX1$$e900$$ENDHEX$$sion  */
/* ( cas d'un impay$$HEX2$$e9002000$$ENDHEX$$sur le premier pr$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$vement ), on prend la      */
/* date d'adh$$HEX1$$e900$$ENDHEX$$sion.                                                 */
/*------------------------------------------------------------------*/
			dParam2 = Uf_Calcul_Periode_Edms ( bSecurilion, dcMvtsParam2, 0 )
			dDteFinGti = dParam2

		End If
	End If
End If

/*------------------------------------------------------------------*/
/* Cas particulier des remboursements.                              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le 29/03/1999.                                                   */
/* Il ne faut prendre en compte les remboursements que si le        */
/* dossier est resili$$HEX1$$e900$$ENDHEX$$. (Zone DOSAD.DER_ECH renseign$$HEX1$$e900$$ENDHEX$$e). Le calcul  */
/* de la zone DTE_RESIL est effectu$$HEX2$$e9002000$$ENDHEX$$juste avant l'appel de cette   */
/* fonction, on peut donc tester sans danger la zone DTE_RESIL.     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le plus grand mouvement de remboursement. Si le      */
/* PARAM3 de ce mouvement est $$HEX1$$e900$$ENDHEX$$gal au PARAM3 r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX2$$e9002000$$ENDHEX$$au d$$HEX1$$e900$$ENDHEX$$but, on  */
/* prend le PARAM2 du mouvement 02, on lui plaque le jour de        */
/* l'adh$$HEX1$$e900$$ENDHEX$$sion, et on enl$$HEX1$$e900$$ENDHEX$$ve un jour.                                */
/*------------------------------------------------------------------*/
For	lCpt = lTotMvts To 1 Step -1
		lMvtsCodeMouv	= idw_Mvts.GetItemNumber ( lCpt, "MVTS_CODE_MOUV" )
		If	( lMvtsCodeMouv = 2 ) Then
			bRemboursement = True
			Exit
		End If
Next

/*------------------------------------------------------------------*/
/* Le 31/03/1999. Modif DGA.                                        */
/* Il ne faut prendre en compte le remboursement que si le dossier  */
/* est r$$HEX1$$e900$$ENDHEX$$sili$$HEX1$$e900$$ENDHEX$$. La date de r$$HEX1$$e900$$ENDHEX$$siliation est calcul$$HEX1$$e900$$ENDHEX$$e juste avant     */
/* cette fonction dans Uf_Verifier_Adhesion_Edms (). Il suffit      */
/* donc de prendre la zone DTE_RESIl en compte.                     */
/*------------------------------------------------------------------*/
dDteResil = Date(idw_wTravail.GetItemDateTime ( 1, "DTE_RESIL" )) // [PI056] date -> datetime
If	bRemboursement And ( Not IsNull ( dDteResil ) ) Then
	If	idw_Mvts.GetItemNumber ( lCpt, "MVTS_PARAM3" ) = dcMvtsParam3 Then
		dcMvtsParam2 = idw_Mvts.GetItemNumber ( lCpt, "MVTS_PARAM2" )

		dParam2 = Uf_Calcul_Periode_Edms ( bSecurilion, dcMvtsParam2, 0 )
		dDteFinGti = dParam2

	End If
End If

/*------------------------------------------------------------------*/
/* Cas particulier des gratuit$$HEX1$$e900$$ENDHEX$$s.                                   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On recherche le dernier mouvement de gratuit$$HEX1$$e900$$ENDHEX$$. (COD_MOUV=20).    */
/* Si on trouve un mouvement, on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la zone PARAM3. On        */
/* recherche ensuite le mouvement de type 13 pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent le           */
/* mouvement de gratuit$$HEX1$$e900$$ENDHEX$$. Pour ce mouvement (13), on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re       */
/* PARAM3, (Si PARAM3 est $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro, on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re PARAM2). On      */
/* compare ensuite le PARAM3 (Mvts20) au PARAM2/3 (Mvts13).         */
/*------------------------------------------------------------------*/
For	lCpt = lTotMvts To 1 Step -1
		lMvtsCodeMouv	= idw_Mvts.GetItemNumber ( lCpt, "MVTS_CODE_MOUV" )
		If	( lMvtsCodeMouv = 20 ) Then
			dcMvtsParam3_Gratuit = idw_Mvts.GetItemNumber ( lCpt, "MVTS_PARAM3" )
			bGratuit = True
			Exit
		End If
Next

If	bGratuit	Then
	For	lCpt1 = lCpt To 1 Step -1
			lMvtsCodeMouv	= idw_Mvts.GetItemNumber ( lCpt1, "MVTS_CODE_MOUV" )
			If	( lMvtsCodeMouv = 13 ) Then
				dcMvtsParam3_13 = idw_Mvts.GetItemNumber ( lCpt1, "MVTS_PARAM3" )
				If	dcMvtsParam3_13 = 0 Then
					dcMvtsParam3_13 = idw_Mvts.GetItemNumber ( lCpt1, "MVTS_PARAM2" )
				End If
				Exit
			End If
	Next
End If

If	bGratuit	Then
	If	dcMvtsParam3_Gratuit > dcMvtsParam3_13	Then
/*------------------------------------------------------------------*/
/* Le 31/03/1999. Modif DGA.                                        */
/* Il faut ajouter un mois pour la gratuit$$HEX1$$e900$$ENDHEX$$.                        */
/*------------------------------------------------------------------*/
		dParam3 = Uf_Calcul_Periode_Edms ( bSecurilion, dcMvtsParam3_Gratuit, 1 )
		dDteFinGti = dParam3
	End If
End If

/*------------------------------------------------------------------*/
/* Si la date de fin de garantie que l'on vient de trouver est      */
/* inf$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la date d'adh$$HEX1$$e900$$ENDHEX$$sion, on prend la date d'adh$$HEX1$$e900$$ENDHEX$$sion     */
/* comme date de r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence.                                         */
/*------------------------------------------------------------------*/
If	dDteFinGti < Date(idw_wTravail.GetItemDateTime ( 1, "DTE_ADH" )) Then
	dDteFinGti = Date(idw_wTravail.GetItemDateTime ( 1, "DTE_ADH" ))
End If

/*------------------------------------------------------------------*/
/* Le 26/09/2001. Modification DGA (Suite demande AMO LUC).         */
/* Facturation ESPRIT LIBRE DCMP 010302                             */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Pour le produit 02 uniquement, on va lancer une requ$$HEX1$$ea00$$ENDHEX$$te sur      */
/* SEREFIDRF (avec Produit/Ets/Adh./sDos). On recherche une valeur  */
/* (LIB_ID) pour TYPY = 3 et ACTUEL = 0. Il est possible de ne      */
/* rien r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer.                                                  */
/*------------------------------------------------------------------*/
If	lIdProdEdms = 2	Then
	lIdAdh	= Long ( idw_wTravail.GetItemString ( 1, "ID_ADH" ) )
	lIdEts	= idw_wTravail.GetItemNumber ( 1, "ID_ETS" )
	lIdsDos	= idw_wTravail.GetItemNumber ( 1, "ID_SDOS" )

	idw_Edms_Sri_Ref_Facturation.Reset ()
	idw_Edms_Sri_Lig_Facturation.Reset ()

	lTotRefFacturation = idw_Edms_Sri_Ref_Facturation.Retrieve ( lIdProdEdms, lIdEts, lIdAdh, lIdsDos )
/*------------------------------------------------------------------*/
/* On vient de trouver une ligne pour la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence de la            */
/* facturation. On va d$$HEX1$$e900$$ENDHEX$$coder la zone REFID_LIBID pour effectuer    */
/* le retrieve sur les lignes de facturation.                       */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* REFID_LIBID = 12-12345-12345-XXX-12345678                        */
/*                1   2     3    4      5                           */
/* 1 = Entete                                                       */
/* 2 = Code Banque                                                  */
/* 3 = Code Agence                                                  */
/* 4 = Type (Tjrs OGB)                                              */
/* 5 = Num$$HEX1$$e900$$ENDHEX$$ro Contrat                                               */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le SELECT pour les lignes de facturation s'effectue avec une     */
/* jointure sur la table SETITRE afin de v$$HEX1$$e900$$ENDHEX$$rifier la valeur de      */
/* l'$$HEX1$$e900$$ENDHEX$$tablissement. IMPORTANT. VU LUC le 01/10/2001, on ne traite   */
/* que les lignes de facturation pour des $$HEX1$$e900$$ENDHEX$$tablissement             */
/* $$HEX1$$e900$$ENDHEX$$quivalents.                                                     */
/*------------------------------------------------------------------*/
	If	lTotRefFacturation > 0	Then
		sLibId	= idw_Edms_Sri_Ref_Facturation.GetItemString ( 1, "REFID_LIBID" )
		lCodBq	= Long ( Mid ( sLibId, 3, 5 ) )
		lCodAg	= Long ( Mid ( sLibId, 8, 5 ) )
		sTypeCtr	= Mid ( sLibId, 13, 3 )
		lNumCtr	= Long ( Mid ( sLibId, 16, 8 ) )
		sIdEts	= String ( lIdEts, "00000" )

		lTotLigFacturation = idw_Edms_Sri_Lig_Facturation.Retrieve ( lCodBq, lCodAg, sTypeCtr, lNumCtr, lIdProdEdms, sIdEts )
/*------------------------------------------------------------------*/
/* La DW est tri$$HEX2$$e9002000$$ENDHEX$$par ordre croissant sur PARAM3. Il suffit donc    */
/* de prendre le dernier enregistrement de la DW. On obtient ainsi  */
/* la plus grande p$$HEX1$$e900$$ENDHEX$$riode r$$HEX1$$e900$$ENDHEX$$gl$$HEX1$$e900$$ENDHEX$$e.                                   */
/*------------------------------------------------------------------*/
		If	lTotLigFacturation > 0	Then
			dcParam3EspritLibre		= idw_Edms_Sri_Lig_Facturation.GetItemNumber ( lTotLigFacturation, "SRI_SEELFAC_ELFAC_PARAM3" )
			dDteFinGtiEspritLibre	= Uf_Calcul_Periode_Edms ( bSecurilion, dcParam3EspritLibre, 0 )

			If	dDteFinGtiEspritLibre > dDteFinGti	Then
				dDteFinGti = dDteFinGtiEspritLibre
			End If
		End If

/*------------------------------------------------------------------*/
/* On compare le nouveau PARAM3 trouv$$HEX2$$e9002000$$ENDHEX$$au PARAM3 pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent. On      */
/* prend la plus grande date des deux.                              */
/*------------------------------------------------------------------*/
	End If
End If

idw_wTravail.SetItem ( 1, "DTE_FIN_GTI", dDteFinGti )

end subroutine

private function long uf_edms_dteadh (decimal adcdteembauc, decimal adcdteadh);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Edms_DteAdh (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/07/1998 09:51:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Traitement de la date d'adh$$HEX1$$e900$$ENDHEX$$sion r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e
//*
//* Arguments		: Decimal{0}	adcDteEmbauc	(Val)	Date embauche au format AAAAMMJJ
//*					  Decimal{0}	adcDteAdh		(Val)	Date adh$$HEX1$$e900$$ENDHEX$$sion au format AAAAMMJJ
//*
//* Retourne		: Long		 1 = Tout est OK
//*									-1 = On ne trouve pas l'option
//*
//*-----------------------------------------------------------------

Long lIdProd, lIdEts, lOption, lIdProdVal, lTotMvts
Long lTotOption, lRet, lCpt, lMvtsCodeMouv, lMvtsCodeMoyen
Decimal {0} dcMvtsParam1, dcMvtsParam6

String sCodOpt

Date dDteAdh, dDteOpt, dDteSurv

lRet = 1

/*------------------------------------------------------------------*/
/* Les zones ID_PROD et ID_ETS sont forc$$HEX1$$e900$$ENDHEX$$ment saisies.              */
/*------------------------------------------------------------------*/
lIdProd	= idw_wTravail.GetItemNumber ( 1, "ID_PROD" )
lIdEts	= idw_wTravail.GetItemNumber ( 1, "ID_ETS" )

/*------------------------------------------------------------------*/
/* La premi$$HEX1$$e800$$ENDHEX$$re chose a faire est de positionner la date d'adh$$HEX1$$e900$$ENDHEX$$sion. */
/*------------------------------------------------------------------*/
dDteAdh = Uf_Cast_Dte_Edms ( adcDteAdh )
idw_wTravail.SetItem ( 1, "DTE_ADH", dDteAdh )

/*------------------------------------------------------------------*/
/* Le 17/10/1998. (DGA)                                             */
/* Cas particulier des adh$$HEX1$$e900$$ENDHEX$$sions avec des mouvements                */
/* INTEGRE/DESINTEGRE.                                              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On recherche MVTS_CODE_MOUV = 12 (Modification)                  */
/* Une fois que l'on trouve ce mouvement, v$$HEX1$$e900$$ENDHEX$$rifie si                */
/* MVTS.CODE_MOYEN = 14 (Modification de la zone DTE_ADH) et        */
/* MVTS.PARAM1 = 91 (DESINTEGRE)                                    */
/* Dans ce cas la date d'adh$$HEX1$$e900$$ENDHEX$$sion r$$HEX1$$e900$$ENDHEX$$elle se trouve dans MVTS.PARAM6.*/
/*------------------------------------------------------------------*/
lTotMvts = idw_Mvts.RowCount ()

For	lCpt = 1 To lTotMvts
		lMvtsCodeMouv	= idw_Mvts.GetItemNumber ( lCpt, "MVTS_CODE_MOUV" )
		lMvtsCodeMoyen	= idw_Mvts.GetItemNumber ( lCpt, "MVTS_CODE_MOYEN" )
		dcMvtsParam1	= idw_Mvts.GetItemNumber ( lCpt, "MVTS_PARAM1" )

		If	lMvtsCodeMouv = 12 And lMvtsCodeMoyen = 14 And dcMvtsParam1 = 91	Then
			dcMvtsParam6	= idw_Mvts.GetItemNumber ( lCpt, "MVTS_PARAM6" )
			dDteAdh = Uf_Cast_Dte_Edms ( dcMvtsParam6 )
			idw_wTravail.SetItem ( 1, "DTE_ADH", dDteAdh )
			Exit
		End If			
Next

/*------------------------------------------------------------------*/
/* On vient de positionner la zone OPTION dans la fonction          */
/* Uf_Verifier_Adhesion_Edms ().                                    */
/*------------------------------------------------------------------*/
lOption	= idw_wTravail.GetItemNumber ( 1, "OPTION" )

idw_OptionAdh.Reset ()
lTotOption = idw_OptionAdh.Retrieve ( lIdProd, lIdEts, lOption )

/*------------------------------------------------------------------*/
/* On vient de charger la DW OPTION en fonction du produit, de      */
/* l'$$HEX1$$e900$$ENDHEX$$tablissement et de l'option positionn$$HEX1$$e900$$ENDHEX$$e en adh$$HEX1$$e900$$ENDHEX$$sion. On doit  */
/* forc$$HEX1$$e900$$ENDHEX$$ment trouver au moins une ligne. Si ce n'est pas le cas,    */
/* on d$$HEX1$$e900$$ENDHEX$$clenche une erreur.                                         */
/*------------------------------------------------------------------*/
If	lTotOption = 0 Then
	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
	stMessage.Icon			= StopSign!
	stMessage.bErreurG	= False
	stMessage.sCode		= "WORK310"

	F_Message ( stMessage )
	Return ( -1 )
	
Else
	sCodOpt = idw_OptionAdh.GetItemString ( 1, "COD_OPT" )
End If

Choose Case sCodOpt
Case "S"
/*------------------------------------------------------------------*/
/* On positionne la valeur du produit si celui-ci est diff$$HEX1$$e900$$ENDHEX$$rent du  */
/* produit saisi. On affiche en plus un message d'avertissement.    */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modif DBI le 20/12/2000                                          */
/* La date d'embauche pose pb sur produit dans PRODTEL              */
/* car elle est utilis$$HEX1$$e900$$ENDHEX$$e pour la date d'ouverture de la ligne       */
/* t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonique.                                                    */
/*------------------------------------------------------------------*/

	idw_wTravail.SetItem ( 1, "DTE_OPT", stNul.dat )

	lIdProdVal = idw_OptionAdh.GetItemNumber ( 1, "ID_PROD_VAL" )

	If	lIdProdVal <> lIdProd Then
		idw_wTravail.SetItem ( 1, "ID_PROD", lIdProdVal )
		Uf_Positionner_LigneProduit ()

		stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= False
		stMessage.sVar[1]		= String ( lIdProd )
		stMessage.sVar[2]		= String ( lIdProdVal )
		stMessage.sCode		= "WORK320"

		F_Message ( stMessage )
	End If

Case "<"
	dDteSurv	= Date(idw_wTravail.GetItemDateTime ( 1, "DTE_SURV" ))
	dDteOpt	= Uf_Cast_Dte_Edms ( adcDteEmbauc )

/*------------------------------------------------------------------*/
/* Si la date de survenance n'est pas connue, il est impossible de  */
/* v$$HEX1$$e900$$ENDHEX$$rifier l'option. On affiche un message d'avertissement.        */
/* Si la date de survenance est inf$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la date d'embauche     */
/* (DTE_OPT maintenant), on ne fait rien, sinon ID_PROD est $$HEX1$$e900$$ENDHEX$$gal $$HEX3$$e00020002000$$ENDHEX$$*/
/* ID_PROD_VAL.                                                     */
/*------------------------------------------------------------------*/
	If	IsNull ( dDteSurv ) Then
		lRet = -1

		stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= False
		stMessage.sCode		= "WORK330"

		F_Message ( stMessage )

/*----------------------------------------------------------------------------*/
/* MODIF JFF LE 22/05/01 : Dans le cas du '<', cela signifie que la dte       */
/* d'embauche contient obligatoirement la date de changement d'option, si 		*/
/* celle-ci n'est pas renseign$$HEX2$$e9002000$$ENDHEX$$au niveau des bases adh$$HEX1$$e900$$ENDHEX$$sions UNISYS, ce n'est*/
/* pas normal.                           													*/
/*----------------------------------------------------------------------------*/
	ElseIf IsNull ( dDteOpt ) Or dDteOpt = 1900-01-01 Then 
		lRet = -1

		stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= False
		stMessage.sCode		= "WORK380"

		F_Message ( stMessage )

	Else
 		If	dDteSurv >= dDteOpt Then
			lIdProdVal = idw_OptionAdh.GetItemNumber ( 1, "ID_PROD_VAL" )
			If	lIdProdVal <> lIdProd Then
				idw_wTravail.SetItem ( 1, "ID_PROD", lIdProdVal )
				Uf_Positionner_LigneProduit ()

				idw_wTravail.SetItem ( 1, "DTE_OPT", dDteOpt )

				stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= False
				stMessage.sVar[1]		= String ( lIdProd )
				stMessage.sVar[2]		= String ( lIdProdVal )
				stMessage.sCode		= "WORK320"

				F_Message ( stMessage )

			End If
		End If
	End If

Case ">"

	dDteSurv	= Date(idw_wTravail.GetItemDateTime ( 1, "DTE_SURV" ))
	dDteOpt	= Uf_Cast_Dte_Edms ( adcDteEmbauc )

/*------------------------------------------------------------------*/
/* Si la date de survenance n'est pas connue, il est impossible de  */
/* v$$HEX1$$e900$$ENDHEX$$rifier l'option. On affiche un message d'avertissement.        */
/* Si la date de survenance est sup$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e800$$ENDHEX$$gale $$HEX2$$e0002000$$ENDHEX$$la date       */
/* d'embauche (DTE_OPT maintenant ), ID_PROD est $$HEX1$$e900$$ENDHEX$$gal $$HEX14$$e0002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
/* ID_PROD_VAL.                                                     */
/*------------------------------------------------------------------*/
	If	IsNull ( dDteSurv ) Then
		lRet = -1

		stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= False
		stMessage.sCode		= "WORK330"

		F_Message ( stMessage )

/*----------------------------------------------------------------------------*/
/* MODIF JFF LE 22/05/01 : Dans le cas du '>', cela signifie que la dte       */
/* d'embauche contient obligatoirement la date de changement d'option, si 		*/
/* celle-ci n'est pas renseign$$HEX2$$e9002000$$ENDHEX$$au niveau des bases adh$$HEX1$$e900$$ENDHEX$$sions UNISYS, ce n'est*/
/* pas normal.                           													*/
/*----------------------------------------------------------------------------*/
	ElseIf IsNull ( dDteOpt ) Or dDteOpt = 1900-01-01 Then 
		lRet = -1

		stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= False
		stMessage.sCode		= "WORK380"

		F_Message ( stMessage )


	Else 
		If	dDteSurv < dDteOpt Then
			lIdProdVal = idw_OptionAdh.GetItemNumber ( 1, "ID_PROD_VAL" )
			If	lIdProdVal <> lIdProd Then
				idw_wTravail.SetItem ( 1, "ID_PROD", lIdProdVal )
				Uf_Positionner_LigneProduit ()

				idw_wTravail.SetItem ( 1, "DTE_OPT", dDteOpt )

				stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= False
				stMessage.sVar[1]		= String ( lIdProd )
				stMessage.sVar[2]		= String ( lIdProdVal )
				stMessage.sCode		= "WORK320"

				F_Message ( stMessage )

			End If
		End If
	End If

End Choose

Return ( lRet )

end function

private subroutine uf_gestion_str2nul ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Gestion_Str2Nul (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 17/10/1998 18:05:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cette fonction transforme les chaines vides en NULL
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sCol[ 11 ]
String sVal, sAdr1B, sAdr2B, sAdrVilleB
Long lCpt, lNbrCol

/*------------------------------------------------------------------*/
/* Le but de cette fonction est de transformer toutes les zones au  */
/* format STRING dans la DW courante en NULL. Cela $$HEX1$$e900$$ENDHEX$$vitera d'avoir  */
/* sur le moteurs des zones avec des blancs. Cette fonction doit    */
/* $$HEX1$$ea00$$ENDHEX$$tre appel$$HEX1$$e900$$ENDHEX$$e avant la fonction Uf_ControlerSaisie ().            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* De plus si les gestionnaire saisi des blancs DEVANT la zone,     */
/* ces caract$$HEX1$$e800$$ENDHEX$$res sont automatiquement enlev$$HEX1$$e900$$ENDHEX$$s.                     */
/*------------------------------------------------------------------*/

lNbrCol				= UpperBound ( sCol )

sCol[  1 ] = "TXT_MESS1"
sCol[  2 ] = "ID_ADH"
sCol[  3 ] = "NOM"
sCol[  4 ] = "PRENOM"
sCol[  5 ] = "ADR_1"
sCol[  6 ] = "ADR_2"
sCol[  7 ] = "ADR_CP"
sCol[  8 ] = "ADR_VILLE"
sCol[  9 ] = "NUM_TELD"
sCol[ 10 ] = "NUM_TELB"
sCol[ 11 ] = "NUM_FAX"

For	lCpt = 1 To lNbrCol
		sVal = Trim ( idw_wTravail.GetItemString ( 1, sCol[ lCpt ] ) )
		If Len ( sVal ) = 0 Then
			idw_wTravail.SetItem ( 1, sCol[ lCpt ], stNul.str )
		Else
			idw_wTravail.SetItem ( 1, sCol[ lCpt ], sVal )
		End If
Next

/*------------------------------------------------------------------*/
/* Le 03/12/1998.                                                   */
/* Apr$$HEX1$$e900$$ENDHEX$$s v$$HEX1$$e900$$ENDHEX$$rification, si la zone DOMIC_ADR_35_2 est vide, on met   */
/* la zone $$HEX2$$e0002000$$ENDHEX$$NULL. De plus, si la zone DOMIC_ADR_35_1 est vide,     */
/* on met "." $$HEX2$$e0002000$$ENDHEX$$la place.                                           */
/*------------------------------------------------------------------*/
If	idw_Adh.RowCount () > 0 Then
	sAdr1B		= Trim ( idw_Adh.GetItemString ( 1, "DOMIC_ADR_35_1" ) )
	sAdr2B		= Trim ( idw_Adh.GetItemString ( 1, "DOMIC_ADR_35_2" ) )
	sAdrVilleB	= Trim ( idw_Adh.GetItemString ( 1, "DOMIC_VILLE" ) )

	If	Len ( sAdr1B ) = 0 Then
		idw_Adh.SetItem ( 1, "DOMIC_ADR_35_1", "." )
	Else
		idw_Adh.SetItem ( 1, "DOMIC_ADR_35_1", sAdr1B )
	End If

	If Len ( sAdr2B ) = 0 Then
		idw_Adh.SetItem ( 1, "DOMIC_ADR_35_2", stNul.str )
	Else
		idw_Adh.SetItem ( 1, "DOMIC_ADR_35_2", sAdr2B )
	End If

	If Len ( sAdrVilleB ) = 0 Then
		idw_Adh.SetItem ( 1, "DOMIC_VILLE", stNul.str )
	Else
		idw_Adh.SetItem ( 1, "DOMIC_VILLE", sAdrVilleB )
	End If
End If
end subroutine

private function date uf_calcul_periode_edms (boolean absecurilion, decimal adcmvts, decimal adcnbmois);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Calcul_Periode_Edms (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 16/10/1998 16:32:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Boolean		abSecurilion		(Val) S'agit-il du cas particulier en SECURILION
//						: Decimal {0}	adcMvts				(Val)	Mouvement $$HEX2$$e0002000$$ENDHEX$$prendre en compte
//*					: Decimal {0}	adcNbMois			(Val)	Nombre de mois $$HEX2$$e0002000$$ENDHEX$$traiter
//*
//* Retourne		: Date			 
//*
//*-----------------------------------------------------------------

Date dParam3

Long lJour
Integer iAn, iMois, iCpt

Boolean bMoinsUnJour

bMoinsUnJour = False

/*------------------------------------------------------------------*/
/* Il s'agit du cas partiulier en SECURILION (Pr$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$vement           */
/* Trimestriel). La date de fin de garantie correspond $$HEX2$$e0002000$$ENDHEX$$la fin du  */
/* trimestre de pr$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$vement.                                        */
/*------------------------------------------------------------------*/
If	abSecurilion	Then
	iMois	= Integer ( Right ( String ( adcMvts ), 2 ) )	
	iAn	= Integer ( Left ( String ( adcMvts ), 4 ) )
	Choose Case iMois
	Case 3, 12			// Mois de Mars et D$$HEX1$$e900$$ENDHEX$$cembre
		lJour = 31
	Case 6, 9			// Mois de Juin et Septembre
		lJour = 30
	End Choose

	dParam3	= Date ( iAn, iMois, lJour )
	If	adcNbMois < 0	Then
		dParam3 	= F_Plus_Date ( dParam3, adcNbMois, "M" )
	End If

Else

	lJour = Long ( String ( idw_wTravail.GetItemDateTime ( 1, "DTE_ADH" ), "DD" ) ) // [PI056]
	iAn	= Integer ( Left ( String ( adcMvts ), 4 ) )
	iMois	= Integer ( Right ( String ( adcMvts ), 2 ) )

	dParam3	= Date ( iAn, iMois, lJour )

/*------------------------------------------------------------------*/
/* On g$$HEX1$$e900$$ENDHEX$$re un compteur pour les cas particuliers (Cas ou ou mois    */
/* adh$$HEX1$$e900$$ENDHEX$$sion = 02 (FEVRIER) avec ann$$HEX1$$e900$$ENDHEX$$e bissextile. On enleve         */
/* peut-$$HEX1$$ea00$$ENDHEX$$tre un jour de trop dans la boucle, il faut donc le        */
/* compenser $$HEX2$$e0002000$$ENDHEX$$la fin.                                              */
/*------------------------------------------------------------------*/
	iCpt = 0		
	Do While String ( dParam3 ) = "01/01/1900"
		iCpt ++
		lJour --
		dParam3	= Date ( iAn, iMois, lJour )
		bMoinsUnJour = True
	Loop

/*------------------------------------------------------------------*/
/* On ajoute un mois, ou on retire le cycle de pr$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$vement, ou on   */
/* ne fait rien. (adcNbMois = 0).                                   */
/*------------------------------------------------------------------*/
	dParam3 = F_Plus_Date ( dParam3, adcNbMois, "M" )

	If	Long ( String ( dParam3, "DD" ) ) <> lJour Then
		bMoinsUnJour = True
	End If

/*------------------------------------------------------------------*/
/* On retire un jour.                                               */
/*------------------------------------------------------------------*/
	If	Not bMoinsUnJour Then
		dParam3 = F_Plus_Date ( dParam3, -1, "J" )
	Else
		If	iCpt > 0 Then dParam3 = F_Plus_Date ( dParam3, ( iCpt - 1 ), "J" )
	End If
End If

Return ( dParam3 )
end function

private subroutine uf_positionner_ligneproduit ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Positionner_LigneProduit
//* Auteur			: Erick John Stark
//* Date				: 21/10/1998 09:33:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Positionnement sur la bonne ligne de la DW de produit
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Dans le cas ou l'on fait un SetItem sur la zone ID_PROD, il ne   */
/* faut pas oublier de se positionner sur la bonne ligne de la DW.  */
/* En effet, dans toutes les fonctions qui utilisent la DDDW sur    */
/* ID_PROD, on fait des GetRow ().                                  */
/*------------------------------------------------------------------*/

DataWindowChild	dwChild

Long lTotProduit, lLig, lIdProd, lIdCorb

String sRech, sData, sLibCorb

idw_wTravail.GetChild ( "ID_PROD", dwChild )

lIdProd		= idw_wTravail.GetItemNumber ( 1, "ID_PROD" )

sRech 		= "ID_PROD = " + String ( lIdProd )
lTotProduit = dwChild.RowCount ()
lLig			= dwChild.Find ( sRech, 1, lTotProduit )

dwChild.ScrollToRow ( lLig )
dwChild.SetRow ( lLig )

/*------------------------------------------------------------------*/
/* On positionne la bonne corbeille. En effet, on vient de changer  */
/* le code produit $$HEX2$$e0002000$$ENDHEX$$cause de l'option.                             */
/*------------------------------------------------------------------*/
sLibCorb = dwChild.GetItemString ( lLig, "LIB_CORB" )
lIdCorb	= dwChild.GetItemNumber ( lLig, "ID_CORB" )

sData		= sLibCorb + "~t" + String ( lIdCorb )
idw_wTravail.SetValue ( "ID_CORB", 1, sData )
idw_wTravail.SetItem ( 1, "ID_CORB", lIdCorb )




end subroutine

private function long uf_verifier_adhesion_edms_cplt ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Verifier_Adhesion_Edms (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/07/1998 09:51:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va recalculer la date DTE_FIN_GTI dans le cas d'un compl$$HEX1$$e900$$ENDHEX$$ment
//*
//* Arguments		: Aucun
//*
//* Retourne		: Long				 0 = L'adh$$HEX1$$e900$$ENDHEX$$sion n'existe pas
//*											-1 = Pas de connection avec OPENA
//*											-2 = Erreur sur le SetTransObject
//*											-3 = Erreur sur la zone DTE_FINGTI
//*											 1 = L'adh$$HEX1$$e900$$ENDHEX$$sion existe ou toutes les zones ne sont pas saisies
//*
//*-----------------------------------------------------------------

DataWindow dwTrtAdh, dwTrtMvts

String sCodAdh
String sText, sNouvelleLigne

Long lRet, lLig, lIdEts, lIdAdh, lIdsDos, lCodBaseDms, lCodProdDms, lCodAdrDms
Long lNbAdherent, lCodTel

Date dDteFinGti

lRet					= 0
sText 				= ""
sNouvelleLigne		= "~r~n"

/*------------------------------------------------------------------*/
/* On recherche les informations du produit en cours de saisie.     */
/*------------------------------------------------------------------*/
If Not Uf_Recherche_Produit ( lLig, sCodAdh, lCodBaseDms, lCodProdDms, lCodAdrDms, lNbAdherent, lCodTel ) Then
/*------------------------------------------------------------------*/
/* Si toutes les zones ne sont pas saisies, on s'arrete.            */
/*------------------------------------------------------------------*/
	Return ( 1 )
End If

/*------------------------------------------------------------------*/
/* On peut se permettre de transformer la valeur de ID_ADH en       */
/* valeur num$$HEX1$$e900$$ENDHEX$$rique. En effet selon St Denis il y a au maximum 7    */
/* Chiffres.                                                        */
/*------------------------------------------------------------------*/
lIdAdh	= Long ( idw_wTravail.GetItemString ( 1, "ID_ADH" ) )
lIdEts	= idw_wTravail.GetItemNumber ( 1, "ID_ETS" )
lIdsDos	= idw_wTravail.GetItemNumber ( 1, "ID_SDOS" )

SetPointer ( HourGlass! )

If	Not IsValid ( itrEdms )	Then
	itrEdms = Create Transaction

	If	Not F_ConnectOpena ( stGLB.sFichierIni, "SIMPA2 EDMS", itrEdms, stMessage )	Then
/*------------------------------------------------------------------*/
/* La structure du message est arm$$HEX1$$e900$$ENDHEX$$e dans la fonction               */
/* F_ConnectOpena ().                                               */
/*------------------------------------------------------------------*/
		F_Message ( stMessage )
		lRet = -1
	End If
End If

If	lRet = 0 Then
	Choose Case lCodBaseDms
	Case 1							// Base CLX
		If	Not ibInitClx	Then
			If	idw_Edms_Clx_Adh.SetTransObject ( itrEdms ) < 0 Then 
				lRet = -2
			Else
				ibInitClx	= True
				idw_Edms_Clx_Mvts.SetTransObject ( itrEdms )
			End If
		End If

		dwTrtAdh		= idw_Edms_Clx_Adh
		dwTrtMvts	= idw_Edms_Clx_Mvts

	Case 2							// Base PXXX
		If	Not ibInitPxxx	Then
			If idw_Edms_Pxxx_Adh.SetTransObject ( itrEdms ) < 0 Then
				lRet = -2
			Else
				ibInitPxxx	= True
				idw_Edms_Pxxx_Mvts.SetTransObject ( itrEdms )
			End If
		End If

		dwTrtAdh		= idw_Edms_Pxxx_Adh
		dwTrtMvts	= idw_Edms_Pxxx_Mvts

	Case 3							// Base CIC
		If	Not ibInitCic	Then
			If idw_Edms_Cic_Adh.SetTransObject ( itrEdms ) < 0 Then
				lRet = -2
			Else
				ibInitCic	= True
				idw_Edms_Cic_Mvts.SetTransObject ( itrEdms )
			End If
		End If

		dwTrtAdh		= idw_Edms_Cic_Adh
		dwTrtMvts	= idw_Edms_Cic_Mvts

	Case 4							// Base PRODSEC DCMP000306 DBI 16/10/2000
		If	Not ibInitSri	Then
			If idw_Edms_Sri_Adh.SetTransObject ( itrEdms ) < 0 Then
				lRet = -2
			Else
				ibInitSri	= True
				idw_Edms_Sri_Mvts.SetTransObject ( itrEdms )
/*------------------------------------------------------------------*/
/* Le 26/09/2001. Modification DGA (Suite demande AMO LUC).         */
/* Facturation ESPRIT LIBRE DCMP 010302                             */
/*------------------------------------------------------------------*/
				idw_Edms_Sri_Ref_Facturation.SetTransObject ( itrEdms )
				idw_Edms_Sri_Lig_Facturation.SetTransObject ( itrEdms )
			End If
		End If

		dwTrtAdh		= idw_Edms_Sri_Adh
		dwTrtMvts	= idw_Edms_Sri_Mvts

	Case 5							// Base PRODTEL DCMP000306 DBI 16/10/2000
		If	Not ibInitTel	Then
			If idw_Edms_Tel_Adh.SetTransObject ( itrEdms ) < 0 Then
				lRet = -2
			Else
				ibInitTel	= True
				idw_Edms_Tel_Mvts.SetTransObject ( itrEdms )
			End If
		End If

		dwTrtAdh		= idw_Edms_Tel_Adh
		dwTrtMvts	= idw_Edms_Tel_Mvts

	End Choose

/*------------------------------------------------------------------*/
/* Si l'initialisation des objets de transaction se passe bien, on  */
/* peut d$$HEX1$$e900$$ENDHEX$$clencher un retrieve.                                     */
/*------------------------------------------------------------------*/
	If lRet = 0 Then
		dwTrtAdh.Reset ()	
		dwTrtMvts.Reset ()	
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re l'adh$$HEX1$$e900$$ENDHEX$$sion en cours de traitement.                   */
/*------------------------------------------------------------------*/
		lRet = dwTrtAdh.Retrieve ( lCodProdDms, lIdEts, lIdAdh, lIdsDos )
	End If

End If

SetPointer ( Arrow! )

If	lRet > 0 Then
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re maintenant les mouvements financiers qui sont        */
/* positionn$$HEX1$$e900$$ENDHEX$$s sur l'adh$$HEX1$$e900$$ENDHEX$$rent principal.                            */
/*------------------------------------------------------------------*/
	dwTrtMvts.Retrieve ( lCodProdDms, lIdEts, lIdAdh, 1 )

/*------------------------------------------------------------------*/
/* On recopie les informations concernant l'adh$$HEX1$$e900$$ENDHEX$$sion et les         */
/* mouvements financiers dans les DW de stockage.                   */
/*------------------------------------------------------------------*/
	idw_Adh.Reset ()
	idw_Mvts.Reset ()

	dwTrtAdh.RowsCopy ( 1, 1, Primary!, idw_Adh, 1, Primary! )
	dwTrtMvts.RowsCopy ( 1, 9999, Primary!, idw_Mvts, 1, Primary! )

/*------------------------------------------------------------------*/
/* On s'occupe de la zone DTE_FIN_GTI.                              */
/*------------------------------------------------------------------*/
	If	sCodAdh = "1" Then
		Uf_Edms_DteFinGti ()
	Else
		idw_wTravail.SetItem ( 1, "DTE_FIN_GTI", stNul.Dat )
	End If

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie la v$$HEX1$$e900$$ENDHEX$$racit$$HEX2$$e9002000$$ENDHEX$$des informatiosn r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es.              */
/*------------------------------------------------------------------*/
	If	lRet > 0 Then

		dDteFinGti	= Date(idw_wTravail.GetItemDateTime ( 1, "DTE_FIN_GTI" )) // [PI056]

		If	( IsNull  ( dDteFinGti ) Or Year ( dDteFinGti ) = 1900 ) And sCodAdh = "1" Then 
			sText = sText + " - la date de fin de garantie" + sNouvelleLigne
			lRet = -3
		End If

		If	lRet = -3 Then
			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
			stMessage.Icon			= StopSign!
			stMessage.bErreurG	= False
			stMessage.sVar[1]		= sText
			stMessage.sCode		= "WORK270"

			F_Message ( stMessage )
		End If
	End If
End If

Return ( lRet )
end function

public subroutine uf_initialiser_dw_desc (ref datawindow adw_norm[]);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Initialiser_Dw_Desc (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: DataWindow				adw_Norm[14]		(R$$HEX1$$e900$$ENDHEX$$f)	Tableau de DataWindow
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
long	ll_ret
/*------------------------------------------------------------------*/
/* On va utiliser un tableau de DW pour armer les instances du      */
/* NVUO, il faut les charger dans le bon ordre.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* DataWindow sur la table INTER et W_INTER.                        */
/*------------------------------------------------------------------*/
idw_Inter	= adw_Norm[1]
ll_ret = idw_Inter.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la table ROUTAGE.                                 */
/*------------------------------------------------------------------*/
idw_Routage	= adw_Norm[2]
ll_ret = idw_Routage.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la table SINISTRE et W_SIN.                       */
/*------------------------------------------------------------------*/
idw_Sinistre	= adw_Norm[3]
ll_ret = idw_Sinistre.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la table SINISTRE et W_SIN.                       */
/* (R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des sinistres li$$HEX1$$e900$$ENDHEX$$s)                                */
/*------------------------------------------------------------------*/
idw_SinistresLies	= adw_Norm[4]
ll_ret = idw_SinistresLies.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la base EDMS (Base CLX). (ADHESION)               */
/*  (On ne fait pas de SetTransObject. Il sera fait au moment ou on */
/*  en aura besoin)                                                 */
/*------------------------------------------------------------------*/
idw_Edms_Clx_Adh = adw_Norm[5]

/*------------------------------------------------------------------*/
/* DataWindow sur la base EDMS (Base PXXX). (ADHESION)              */
/*  (On ne fait pas de SetTransObject. Il sera fait au moment ou on */
/*  en aura besoin)                                                 */
/*------------------------------------------------------------------*/
idw_Edms_Pxxx_Adh = adw_Norm[6]

/*------------------------------------------------------------------*/
/* DataWindow sur la base EDMS (Base CIC). (ADHESION)               */
/*  (On ne fait pas de SetTransObject. Il sera fait au moment ou on */
/*  en aura besoin)                                                 */
/*------------------------------------------------------------------*/
idw_Edms_Cic_Adh = adw_Norm[7]

/*------------------------------------------------------------------*/
/* DataWindow sur la base EDMS (Base ProdSec). (ADHESION)           */
/*  (On ne fait pas de SetTransObject. Il sera fait au moment ou on */
/*  en aura besoin)                                                 */
/*------------------------------------------------------------------*/
idw_Edms_Sri_Adh = adw_Norm[15]

/*------------------------------------------------------------------*/
/* DataWindow sur la base EDMS (Base ProdTel). (ADHESION)           */
/*  (On ne fait pas de SetTransObject. Il sera fait au moment ou on */
/*  en aura besoin)                                                 */
/*------------------------------------------------------------------*/
idw_Edms_Tel_Adh = adw_Norm[17]

/*------------------------------------------------------------------*/
/* DataWindow sur la base EDMS (Base CLX). (MOUVEMENTS)             */
/*  (On ne fait pas de SetTransObject. Il sera fait au moment ou on */
/*  en aura besoin)                                                 */
/*------------------------------------------------------------------*/
idw_Edms_Clx_Mvts = adw_Norm[8]

/*------------------------------------------------------------------*/
/* DataWindow sur la base EDMS (Base PXXX). (MOUVEMENTS)            */
/*  (On ne fait pas de SetTransObject. Il sera fait au moment ou on */
/*  en aura besoin)                                                 */
/*------------------------------------------------------------------*/
idw_Edms_Pxxx_Mvts = adw_Norm[9]

/*------------------------------------------------------------------*/
/* DataWindow sur la base EDMS (Base CIC). (MOUVEMENTS)             */
/*  (On ne fait pas de SetTransObject. Il sera fait au moment ou on */
/*  en aura besoin)                                                 */
/*------------------------------------------------------------------*/
idw_Edms_Cic_Mvts = adw_Norm[10]

/*------------------------------------------------------------------*/
/* DataWindow sur la base EDMS (Base ProdSec). (MOUVEMENTS)         */
/*  (On ne fait pas de SetTransObject. Il sera fait au moment ou on */
/*  en aura besoin)                                                 */
/*------------------------------------------------------------------*/
idw_Edms_Sri_Mvts = adw_Norm[16]

/*------------------------------------------------------------------*/
/* DataWindow sur la base EDMS (Base ProdTel). (MOUVEMENTS)         */
/*  (On ne fait pas de SetTransObject. Il sera fait au moment ou on */
/*  en aura besoin)                                                 */
/*------------------------------------------------------------------*/
idw_Edms_Tel_Mvts = adw_Norm[18]

/*------------------------------------------------------------------*/
/* DataWindow sur la table OPTION_ADH.                              */
/*------------------------------------------------------------------*/
idw_OptionAdh	= adw_Norm[11]
idw_OptionAdh.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow external permettant de stocker les coordonn$$HEX1$$e900$$ENDHEX$$es        */
/* de l'adh$$HEX1$$e900$$ENDHEX$$sion.                                                   */
/*------------------------------------------------------------------*/
idw_Adh	= adw_Norm[12]

/*------------------------------------------------------------------*/
/* DataWindow external permettant de stocker les mouvements         */
/* financiers.                                                      */
/*------------------------------------------------------------------*/
idw_Mvts	= adw_Norm[13]

/*------------------------------------------------------------------*/
/* DataWindow pour la recherche des homonymes.                      */
/*------------------------------------------------------------------*/
idw_Homonyme	= adw_Norm[14]
idw_Homonyme.SetTransObject ( This.itrTrans )

/*----------------------------------------------------------------------------*/
/* Datawindow pour l'affectation de la personne qui traitera le dossier.      */
/*----------------------------------------------------------------------------*/
idw_DosSuiviPar = adw_Norm[19]
idw_DosSuiviPar.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la base EDMS (Base SRI). (REF FACTURATION)        */
/*  (On ne fait pas de SetTransObject. Il sera fait au moment ou on */
/*  en aura besoin)                                                 */
/*------------------------------------------------------------------*/
idw_Edms_Sri_Ref_Facturation = adw_Norm[20]

/*------------------------------------------------------------------*/
/* DataWindow sur la base EDMS (Base SRI). (LIG FACTURATION)        */
/*  (On ne fait pas de SetTransObject. Il sera fait au moment ou on */
/*  en aura besoin)                                                 */
/*------------------------------------------------------------------*/
idw_Edms_Sri_Lig_Facturation = adw_Norm[21]

end subroutine

public subroutine uf_gestion_contacts (string asidcorb, long alidsin);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Gestion_Contacts (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de ID_SIN
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//* DCMP990451	JFF		29/09/99 Affichage du message d'ouverture de 
//*										de pochette				  
//*-----------------------------------------------------------------

String sCodTypRecu
DatawindowChild dwChild

sCodTypRecu = idw_wTravail.GetItemString ( 1, "COD_TYP_RECU" ) 

If ibAltContact Then

	CHOOSE CASE Upper ( sCodTypRecu )
		// Dec
		CASE "D"
			idw_DosSuiviPar.Reset ()
			idw_DosSuiviPar.InsertRow (0)
			idw_DosSuiviPar.GetChild ( "DOS_SUIVI_PAR", dwChild )
			dwChild.SetFilter ( "ID_CORB = " + asIdCorb )
			dwChild.Filter ()
			idw_DosSuiviPar.SetItem ( 1, "DOS_SUIVI_PAR", stNul.str )
			idw_DosSuiviPar.Show ()

		// Cpl
		CASE "C"
			idw_DosSuiviPar.Reset () 
			idw_DosSuiviPar.Retrieve ( alIdSin )
			If idw_DosSuiviPar.RowCount () <= 0 Then idw_DosSuiviPar.InsertRow ( 0 )
		
			idw_DosSuiviPar.GetChild ( "DOS_SUIVI_PAR", dwChild )
			dwChild.SetFilter ( "ID_CORB = " + asIdCorb )
			dwChild.Filter ()
			idw_DosSuiviPar.Show ()

	END CHOOSE

Else
	idw_DosSuiviPar.Hide ()
	idw_DosSuiviPar.SetItem ( 1, "DOS_SUIVI_PAR", stNul.Str )
End If


end subroutine

private function boolean uf_recherche_produit (ref long allig, ref string ascodadh, ref long alcodbasedms, ref long alcodproddms, ref long alcodadrdms, ref long alnbadherent, ref long alCodTel);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Recherche_Produit (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Recherche sur la DwChild de PRODUIT
//*
//* Arguments		: Long			alLig				(R$$HEX1$$e900$$ENDHEX$$f) GetRow () de la DwChild
//* 					  String			asCodAdh			(R$$HEX1$$e900$$ENDHEX$$f) Zne COD_ADH de PRODUIT
//* 					  Long			alCodBaseDms	(R$$HEX1$$e900$$ENDHEX$$f) Zne COD_BASE_DMS de PRODUIT
//* 					  Long			alCodProdDms	(R$$HEX1$$e900$$ENDHEX$$f) Zne COD_PROD_DMS de PRODUIT
//* 					  Long			alCodAdrDms		(R$$HEX1$$e900$$ENDHEX$$f) Zne COD_ADR_DMS de PRODUIT
//* 					  Long			alNbAdherent	(R$$HEX1$$e900$$ENDHEX$$f) Zne NB_ADHERENT de PRODUIT
//* 					  Long			alCodTel			(R$$HEX1$$e900$$ENDHEX$$f) Zne COD_TEL de PRODUIT
//*
//* Retourne		: Boolean			True  = Toutes les zones ID_PROD, ID_ETS, ID_ADH, ID_SDOS sont saisies
//*											False = Il manque une ou plusieurs zones
//*
//*-----------------------------------------------------------------

DataWindowChild dwChild

Long lIdProd, lIdEts, lIdsDos

String sIdAdh

Boolean bRet

alLig		= 0
asCodAdh = stNul.str

lIdProd	= idw_wTravail.GetItemNumber ( 1, "ID_PROD" )
lIdEts 	= idw_wTravail.GetItemNumber ( 1, "ID_ETS" )
sIdAdh	= idw_wTravail.GetItemString ( 1, "ID_ADH" )
lIdsDos	= idw_wTravail.GetItemNumber ( 1, "ID_SDOS" )

If	Not IsNull ( lIdProd ) Then
	idw_wTravail.GetChild ( "ID_PROD", dwChild )	

	alLig 			= dwChild.GetRow ()
	asCodAdh			= dwChild.GetItemString ( alLig, "COD_ADH" ) 

	alCodBaseDms	= dwChild.GetItemNumber ( alLig, "COD_BASE_DMS" ) 
	alCodProdDms	= dwChild.GetItemNumber ( alLig, "COD_PROD_DMS" )
	alCodAdrDms		= dwChild.GetItemNumber ( alLig, "COD_ADR_DMS" ) 
	alCodAdrDms		= dwChild.GetItemNumber ( alLig, "COD_ADR_DMS" ) 
	alNbAdherent	= dwChild.GetItemNumber ( alLig, "NB_ADHERENT" )
	alCodTel			= dwChild.GetItemNumber ( alLig, "COD_TEL" )

End If

If Not IsNull ( lIdProd ) And Not IsNull ( lIdEts ) And Not IsNull ( lIdsDos ) And Not IsNull ( sIdAdh ) Then
	bRet = True
Else
	bRet = False
End If

Return ( bRet )
end function

private subroutine uf_edms_telephonie (long alcodtel, long alcodproddms);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Edms_Telephonie (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/05/2001 08:51:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Traitement des zones li$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$la t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie dans la base ash$$HEX1$$e900$$ENDHEX$$sion
//*
//* Arguments		: Long			alCodTel			(Val)	Zone COD_TEL de la table PRODUIT
//*					  Long			alCodProdDms	(Val)	Zone COD_PROD_DMS de la table PRODUIT
//*
//* Retourne		: Aucun
//*
//*-----------------------------------------------------------------

String sNumPort, sNumImeiPort, sMarqPort, sModlPort
Decimal {0} dcDteEmbauc
Date dDteEmbauc


/*------------------------------------------------------------------*/
/* On positionne toutes les zones $$HEX2$$e0002000$$ENDHEX$$NULL.                           */
/*------------------------------------------------------------------*/
idw_wTravail.SetItem ( 1, "NUM_PORT", stNul.Str  )
idw_wTravail.SetItem ( 1, "NUM_IMEI_PORT", stNul.Str )
idw_wTravail.SetItem ( 1, "MARQ_PORT", stNul.Str )
idw_wTravail.SetItem ( 1, "MODL_PORT", stNul.Str )

idw_wTravail.SetItem ( 1, "DTE_ACH_PORT", stNul.Dat )
idw_wTravail.SetItem ( 1, "DTE_OUVLIG_PORT", stNul.Dat )

/*------------------------------------------------------------------*/
/* En fonction de la zone COD_TEL, on effectue certaines actions.   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La variable alCodProdDms permet d'effectuer certaines            */
/* op$$HEX1$$e900$$ENDHEX$$rations particuli$$HEX1$$e800$$ENDHEX$$res pour les produits DMS. (Ex:Pour le      */
/* produit 82, seuls le si$$HEX1$$e800$$ENDHEX$$cle et l'ann$$HEX1$$e900$$ENDHEX$$e de la date d'ouvertue     */
/* sont g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es.)                                                    */
/*------------------------------------------------------------------*/
Choose Case alCodTel
Case 1
/*------------------------------------------------------------------*/
/* La premi$$HEX1$$e800$$ENDHEX$$re chose $$HEX2$$e0002000$$ENDHEX$$faire est de positionner le N$$HEX2$$b0002000$$ENDHEX$$de portable.  */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le N$$HEX2$$b0002000$$ENDHEX$$de portable est positionn$$HEX2$$e9002000$$ENDHEX$$dans la zone DOSAD-NO-CARTE     */
/* compl$$HEX1$$e900$$ENDHEX$$t$$HEX4$$e9002000e0002000$$ENDHEX$$droite avec des z$$HEX1$$e900$$ENDHEX$$ros. (Vu avec PO, on prend les 10   */
/* premiers chiffres de la zone).                                   */
/*------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* JFF Le 01/07/01 : Probl$$HEX1$$e800$$ENDHEX$$me : La zone DOSAD_NO_CARTE est ramen$$HEX1$$e900$$ENDHEX$$e en tant    */
/* que number, donc sur les 16 chiffres, les premiers 0 ne son pas garder,    */
/* il aurait fallu le ramener en String !.                                    */
/* Je fais donc la v$$HEX1$$e900$$ENDHEX$$rif suivante, sachant que cette zone doit contenir 16    */
/* chiffre,                                                                   */
/* si ce n'est pas le cas, je comble devant avec des 0.                       */
/*----------------------------------------------------------------------------*/
	sNumPort = String ( idw_Adh.GetItemNumber ( 1, "DOSAD_NO_CARTE" ) )
	
	If Len ( sNumPort ) < 16 Then
		sNumPort = Fill ( "0", 16 - Len ( sNumPort ) ) + sNumPort
	End If

	sNumPort = Trim ( Left ( sNumPort, 10 ) )
	idw_wTravail.SetItem ( 1, "NUM_PORT", sNumPort )
/*------------------------------------------------------------------*/
/* On s'occupe maintenant du N$$HEX2$$b0002000$$ENDHEX$$IMEI. Cette zone n'est g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e que    */
/* dans le produit 57.                                              */
/*------------------------------------------------------------------*/
	sNumImeiPort = Trim ( idw_Adh.GetItemString ( 1, "DOSAD_NJF" ) )
	idw_wTravail.SetItem ( 1, "NUM_IMEI_PORT", sNumImeiPort )
/*------------------------------------------------------------------*/
/* On s'occupe de la marque et du mod$$HEX1$$e900$$ENDHEX$$le. Ces zones ne sont g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es  */
/* que dans le produit 57.                                          */
/*------------------------------------------------------------------*/
	sMarqPort = Trim ( idw_Adh.GetItemString ( 1, "DOSAD_RSOC" ) )
	idw_wTravail.SetItem ( 1, "MARQ_PORT", sMarqPort )

	sModlPort = Trim ( idw_Adh.GetItemString ( 1, "DOSAD_ACTIVITE" ) )
	idw_wTravail.SetItem ( 1, "MODL_PORT", sModlPort )
/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de la DATE EMBAUC dans la Base EDMS.                */
/*------------------------------------------------------------------*/
	dcDteEmbauc	= idw_Adh.GetItemNumber ( 1, "DOSAD_DT_EMBAUC" )
	dDteEmbauc	= Uf_Cast_Dte_Edms ( dcDteEmbauc )
/*------------------------------------------------------------------*/
/* On s'occupe maintenant de la date d'achat.                       */
/*------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* La base DMS ne distingue pas la date d'achat et d'ouverture de ligne,      */
/* on renseigne donc les deux zones avec la m$$HEX1$$ea00$$ENDHEX$$me date.                        */
/*----------------------------------------------------------------------------*/
	idw_wTravail.SetItem ( 1, "DTE_ACH_PORT", dDteEmbauc )
	idw_wTravail.SetItem ( 1, "DTE_OUVLIG_PORT", dDteEmbauc )

End Choose






end subroutine

private subroutine uf_recadrer_grille (string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Recadrer_Grille (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 16/05/2001 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On recadre la grille de saisie
//*
//* Arguments		: String		asCas		Val
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sTabNomCol []
String sTabX []
Long	 lCpt, lTotLig, lParam

If asCas = "CENTRE" And isCadrageActuel = "CENTRE" Then Return
If asCas = "GAUCHE" And ( isCadrageActuel = "GAUCHE" Or isCadrageActuel = "" ) Then Return

/*----------------------------------------------------------------------------*/
/* Valeur de d$$HEX1$$e900$$ENDHEX$$placement de la grille vers la gauche ou la droite             */
/*----------------------------------------------------------------------------*/
lParam = 521.5
lCpt = 1

sTabNomCol [lCpt] = "t_nom_prenom"
lCpt ++
sTabNomCol [lCpt] = "cod_civ"
lCpt ++
sTabNomCol [lCpt] = "nom"
lCpt ++
sTabNomCol [lCpt] = "prenom"
lCpt ++
sTabNomCol [lCpt] = "adr_1"
lCpt ++
sTabNomCol [lCpt] = "adr_2"
lCpt ++
sTabNomCol [lCpt] = "adr_cp"
lCpt ++
sTabNomCol [lCpt] = "adr_ville"
lCpt ++
sTabNomCol [lCpt] = "t_tel_dom"
lCpt ++
sTabNomCol [lCpt] = "num_teld"
lCpt ++
sTabNomCol [lCpt] = "t_tel_bur"
lCpt ++
sTabNomCol [lCpt] = "num_telb"
lCpt ++
sTabNomCol [lCpt] = "t_tel_fax"
lCpt ++
sTabNomCol [lCpt] = "num_fax"
lCpt ++
sTabNomCol [lCpt] = "t_message"
lCpt ++
sTabNomCol [lCpt] = "txt_mess1"
lCpt ++
sTabNomCol [lCpt] = "t_cree_le"
lCpt ++
sTabNomCol [lCpt] = "cree_le"
lCpt ++
sTabNomCol [lCpt] = "t_maj_le"
lCpt ++
sTabNomCol [lCpt] = "maj_le"
lCpt ++
sTabNomCol [lCpt] = "t_maj_par"
lCpt ++
sTabNomCol [lCpt] = "maj_par"
lCpt ++
sTabNomCol [lCpt] = "t_cadre11"
lCpt ++
sTabNomCol [lCpt] = "t_cadre12"
lCpt ++
sTabNomCol [lCpt] = "t_cadre21"
lCpt ++
sTabNomCol [lCpt] = "t_cadre22"
lCpt ++
sTabNomCol [lCpt] = "t_cadre31"
lCpt ++
sTabNomCol [lCpt] = "t_cadre32"

lTotLig = UpperBound ( sTabNomCol )

For lCpt = 1 To lTotLig 
	sTabX [lcpt] = idw_wTravail.Describe ( sTabnomCol [lCpt] + ".x" )
Next

CHOOSE CASE True
	CASE asCas = "CENTRE" And ( isCadrageActuel = "GAUCHE" Or isCadrageActuel = "" )
		isCadrageActuel = "CENTRE"

	CASE asCas = "GAUCHE" And isCadrageActuel = "CENTRE"
		isCadrageActuel= "GAUCHE"
		lParam *= -1

END CHOOSE

For lCpt = 1 To lTotLig 
	idw_wTravail.Modify ( sTabnomCol [lCpt] + ".x=" + String ( Long ( sTabX [lCpt] ) + lParam ) )
	idw_wTravail.setposition (sTabnomCol [lCpt], "detail", TRUE)
Next


end subroutine

private subroutine uf_visu_telephonie (boolean abswitch);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Visu_Telephonie (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 16/05/2001 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Affichage ou pas des zones de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$hponie
//*
//* Arguments		: Boolean	abSwitch		Val
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sTabNomCol [], sTabSFr[]
Long	 lCpt, lTotLig
String sParam

If abSwitch Then 
	sParam = "1"
Else
	sParam = "0"
End If

/*----------------------------------------------------------------------------*/
/* Valeur de d$$HEX1$$e900$$ENDHEX$$placement de la grille vers la gauche ou la droite             */
/*----------------------------------------------------------------------------*/
lCpt = 1

sTabNomCol [lCpt] = "t_num_port"
lCpt ++
sTabNomCol [lCpt] = "num_port"
lCpt ++
sTabNomCol [lCpt] = "t_num_imei_port"
lCpt ++
sTabNomCol [lCpt] = "num_imei_port"
lCpt ++
sTabNomCol [lCpt] = "t_marq_port"
lCpt ++
sTabNomCol [lCpt] = "marq_port"
lCpt ++
sTabNomCol [lCpt] = "t_modl_port"
lCpt ++
sTabNomCol [lCpt] = "modl_port"
lCpt ++
sTabNomCol [lCpt] = "t_dte_ach_port"
lCpt ++
sTabNomCol [lCpt] = "dte_ach_port"
lCpt ++
sTabNomCol [lCpt] = "t_dte_ouvlig_port"
lCpt ++
sTabNomCol [lCpt] = "dte_ouvlig_port"
lCpt ++
sTabNomCol [lCpt] = "t_cadre41"
lCpt ++
sTabNomCol [lCpt] = "t_cadre42"

lTotLig = UpperBound ( sTabNomCol )

For lCpt = 1 To lTotLig 
	idw_wTravail.Modify ( sTabnomCol [lCpt] + ".visible=" + sParam )
Next

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* Les donn$$HEX1$$e900$$ENDHEX$$es pour la gestion SFR seront transmises via SHERPA.    */
/* N$$HEX1$$e900$$ENDHEX$$ammoins pour effectuer les premiers tests je positionne les    */
/* zones dans la DW. Ces zones sont li$$HEX1$$e800$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$COD_TEL. (Ce qui est    */
/* inexact mais pour le test cela suffit). Seul DGA aura acc$$HEX1$$e900$$ENDHEX$$s $$HEX5$$e0002000200020002000$$ENDHEX$$*/
/* ces zones.                                                       */
/*------------------------------------------------------------------*/
lCpt = 1

sTabSfr [lCpt] = "t_id_contrat_abonne"
lCpt ++
sTabSfr [lCpt] = "id_contrat_abonne"
lCpt ++
sTabSfr [lCpt] = "t_id_hlr"
lCpt ++
sTabSfr [lCpt] = "id_hlr"
lCpt ++
sTabSfr [lCpt] = "t_id_orian_marque"
lCpt ++
sTabSfr [lCpt] = "id_orian_marque"
lCpt ++
sTabSfr [lCpt] = "t_id_orian_modele"
lCpt ++
sTabSfr [lCpt] = "id_orian_modele"
lCpt ++
sTabSfr [lCpt] = "t_id_orian_boutique"
lCpt ++
sTabSfr [lCpt] = "id_orian_boutique"

lTotLig = UpperBound ( sTabSfr )

If	abSwitch And stGLB.sCodOper = "DGA"	Then
	sParam = "1"
Else
	sParam = "0"
End If

For lCpt = 1 To lTotLig 
	idw_wTravail.Modify ( sTabSfr [lCpt] + ".visible=" + sParam )
Next

end subroutine

private subroutine uf_tb_telephonie (integer alcodtel, boolean abswitchnull, boolean abswitchtoujoursproteger);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Tb_Telephonie (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 25/05/2001 17:35:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des TabOrder pour les zones de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie
//*
//* Arguments		: (Val)		alCodTel		 Integer		Type de traitement
//*					  (Val)		abSwitchNull Boolean		Init des zones 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Cette fonction concerne les zones suivantes :                    */
/* NUM_PORT, NUM_IMEI_PORT, MARQ_PORT, MODL_PORT, DTE_ACH_PORT,     */
/* DTE_OUVLIG_PORT.                                                 */
/*------------------------------------------------------------------*/
String sCol[ 6 ]

sCol[  1 ] = "NUM_PORT"
sCol[  2 ] = "NUM_IMEI_PORT"
sCol[  3 ] = "MARQ_PORT"
sCol[  4 ] = "MODL_PORT"
sCol[  5 ] = "DTE_ACH_PORT"
sCol[  6 ] = "DTE_OUVLIG_PORT"

If abSwitchNull Then 
	idw_wTravail.SetItem ( 1, "NUM_PORT", stNul.Str )
	idw_wTravail.SetItem ( 1, "NUM_IMEI_PORT", stNul.Str )
	idw_wTravail.SetItem ( 1, "MARQ_PORT", stNul.Str )
	idw_wTravail.SetItem ( 1, "MODL_PORT", stNul.Str )
	
	idw_wTravail.SetItem ( 1, "DTE_ACH_PORT", stNul.Dat )
	idw_wTravail.SetItem ( 1, "DTE_OUVLIG_PORT", stNul.Dat )
End If

idw_wTravail.SetRedraw ( FALSE )

Choose Case alCodTel

// On ne g$$HEX1$$e800$$ENDHEX$$re pas la t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie
Case 0 
	// On cache la t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie
	This.Uf_Visu_Telephonie (FALSE)
	idw_wTravail.setposition ("t_cacher_telephonie", "detail", TRUE)
	This.Uf_Recadrer_Grille ( "CENTRE" )

// Retrieve sur base DMS des zones de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie
Case 1
	/*------------------------------------------------------------------*/
	/* On s'occupe de la gestion t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonique en automatique, les       */
	/* zones sont donc non saississables.                               */
	/*------------------------------------------------------------------*/
	This.Uf_Visu_Telephonie (TRUE)
	idw_wTravail.setposition ("t_cacher_telephonie", "detail", FALSE)
	idw_wTravail.Uf_Proteger ( sCol, "1" )

	idw_wTravail.Modify ( "t_dte_ouvlig_port.visible = 0 dte_ouvlig_port.visible = 0 " + & 
								 "t_dte_ach_port.x = 2359 t_dte_ach_port.width = 417 "  + & 
								 "dte_ach_port.x = 2812 t_dte_ach_port.text = 'Dte Achat/Ouv.Lig.'"  & 
							  )
	This.Uf_Recadrer_Grille ( "GAUCHE" )

// Acc$$HEX1$$e800$$ENDHEX$$s aux zones de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie en modification, sans retrieve sur base DMS
Case 2
	/*------------------------------------------------------------------*/
	/* La gestion de la t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie se fait de mani$$HEX1$$e800$$ENDHEX$$re manuelle, les     */
	/* zones deviennent saisissables.                                   */
	/*------------------------------------------------------------------*/
	This.Uf_Visu_Telephonie (TRUE)
	idw_wTravail.setposition ("t_cacher_telephonie", "detail", FALSE)
	If Not abSwitchToujoursProteger Then 
		idw_wTravail.Uf_Proteger ( sCol, "0" )
	Else
		idw_wTravail.Uf_Proteger ( sCol, "1" )
	End If

	idw_wTravail.Modify ( "t_dte_ouvlig_port.visible = 1 dte_ouvlig_port.visible = 1 " + & 
								 "t_dte_ach_port.x = 2547 t_dte_ach_port.width = 247 "  + & 
								 "dte_ach_port.x = 2817 t_dte_ach_port.text = 'Dte Achat'"  & 
							  )
	This.Uf_Recadrer_Grille ( "GAUCHE" )

End Choose

idw_wTravail.SetRedraw ( TRUE )
end subroutine

private function long uf_zn_codtyprecu ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de COD_TYP_RECU
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On vient de changer la valeur de COD_TYP_RECU. On va envoyer     */
/* ensuite la gestion des TabOrder. Dans la fonction                */
/* Uf_Tb_CodTypRecu, on utilise un GetItemString, il ne faut donc   */
/* pas oublier maintenant de faire un SetItem.                      */
/*------------------------------------------------------------------*/
String sCodTypRecu

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP


sCodTypRecu = idw_wTravail.GetText ()

idw_DosSuiviPar.Hide ()
idw_DosSuiviPar.SetItem ( 1, "DOS_SUIVI_PAR", stNul.Str )

idw_wTravail.SetItem ( 1, "COD_TYP_RECU", sCodTypRecu )

//Migration PB8-WYNIWYG-03/2006 CP
//idw_wTravail.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		

Uf_Tb_CodTypRecu ()

//Migration PB8-WYNIWYG-03/2006 CP
//
		Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end function

private function long uf_zn_codrecu ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Zn_CodRecu (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de COD_RECU
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On vient de changer la valeur de COD_RECU. On va envoyer         */
/* ensuite la gestion des TabOrder. Dans la fonction                */
/* Uf_Tb_CodRecu, on utilise un GetItemString, il ne faut donc pas  */
/* oublier maintenant de faire un SetItem.                          */
/*------------------------------------------------------------------*/

String sCodRecu

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

sCodRecu = idw_wTravail.GetText ()

idw_wTravail.SetItem ( 1, "COD_RECU", sCodRecu )

//Migration PB8-WYNIWYG-03/2006 CP
//idw_wTravail.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		


Uf_Tb_CodRecu ()

//Migration PB8-WYNIWYG-03/2006 CP
//
		Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		


end function

private function integer uf_zn_idsin ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Zn_IdSin (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de ID_SIN
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//* DCMP990451	JFF		29/09/99 Affichage du message d'ouverture de 
//*										de pochette				  
//*-----------------------------------------------------------------
//* #1 le 30/09/1999 DBI Suppression de l'interdiction de cr$$HEX1$$e900$$ENDHEX$$ation 
//*                      d'un travail sur les dossiers sans suite.
//*-----------------------------------------------------------------

Integer iAction

Long lPochette   // DCMP990451
Long lIdSin, lTotSin, lTotInter, lCpt
Long lIdProd, lIdEts, lIdsDos, lLig, lIdCorb, lTotProduit, lCodEtatSin, lRet

String sCodTravail, sData, sNom, sRet, sAltSsui
String sIdAdh, sCodCiv, sPrenom, sAdr1, sAdr2, sAdrCp, sAdrVille, sNumTeld, sNumTelb, sNumFax, sLibCorb, sRech
String sTxtMess1, sTxtAvert
String sTrvCreeLe, sDteRecu, sCodAdh
String sNumPort, sNumIMEIPort, sMarqPort, sModlPort
//Migration PB8-WYNIWYG-03/2006 FM
//Date	 dDteAchPort, dDteOuvLigPort
DateTime	 dDteAchPort, dDteOuvLigPort

//Date dDteAdh, dDteDecl, dDteSurv, dDteResil
DateTime dDteAdh, dDteDecl, dDteSurv, dDteResil
//Fin Migration PB8-WYNIWYG-03/2006 FM

DataWindowChild	dwChild, dwChild1

Boolean bStop

long	ll_ret

iAction		= 2
bStop			= False

// DCMP990451
istPochette.Hide()

lIdSin		= Long ( idw_wTravail.GetText () )
lTotSin		= idw_Routage.Retrieve ( lIdSin )
sTxtAvert	= ""

If	lTotSin = 1	Then
/*------------------------------------------------------------------*/
/* On vient de trouver le sinistre dans le cas d'un compl$$HEX1$$e900$$ENDHEX$$ment. On  */
/* va d$$HEX1$$e900$$ENDHEX$$terminer ou se trouve le sinistre. Si COD_TRAVAIL = CAS,    */
/* il est dans la table SINISTRE, si COD_TRAVAIL <> CAS, il faut    */
/* r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer les informations de W_SIN.                             */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re ensuite les interlocuteurs en se servant du m$$HEX1$$ea00$$ENDHEX$$me     */
/* test.                                                            */
/*------------------------------------------------------------------*/
	sCodTravail		= idw_Routage.GetItemString ( 1, "COD_TRAVAIL" )
/*------------------------------------------------------------------*/
/* Si le dossier de sinistre est CLOS, on avertit le gestionnaire,  */
/* et on lui demande s'il veut continuer.                           */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Dans la commande on recup$$HEX1$$e900$$ENDHEX$$re par jointure sur SINISTRE la zone   */
/* ALT_SSUI. (On fait un OUTER JOIN car le sinistre peut ne pas     */
/* exister sur SINISTRE. Si ALT_SSUI est egal $$HEX2$$e0002000$$ENDHEX$$OUI, pour un        */
/* dossier clos, on interdit le rapatriement.                       */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le 19/01/1999.                                                   */
/* Si le sinistre poss$$HEX1$$e900$$ENDHEX$$de un COD_ETAT $$HEX2$$e0002000$$ENDHEX$$900, on interdit aussi la   */
/* cr$$HEX1$$e900$$ENDHEX$$ation d'un compl$$HEX1$$e900$$ENDHEX$$ment. Le COD_ETAT peut $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$900 et    */
/* ALT_SSUI $$HEX2$$e0002000$$ENDHEX$$(N)on.                                                */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
//* #1	If	sCodTravail = "CAS"	And 
//*         ( sAltSsui = "O" Or lCodEtatSin = 900 ) Then 
/*------------------------------------------------------------------*/

	If	sCodTravail = "CAS" And Not ibWorkFlow_En_Consult Then		// #1

				stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
				stMessage.Icon			= Question!
				stMessage.Bouton		= YesNo!
				stMessage.bErreurG	= False
				stMessage.sCode		= "WORK150"

				If F_Message ( stMessage ) = 2	Then
					bStop = True
				Else
					sTxtAvert = "Dossier rapatri$$HEX2$$e9002000$$ENDHEX$$le : " + String ( Today (), "dd/mm/yyyy" )
				End If

	End If

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie s'il existe un travail pour ce dossier. Si oui, on    */
/* v$$HEX1$$e900$$ENDHEX$$rifie qu'il n'est pas en cours de traitement. Si c'est le cas  */
/* on interdit la cr$$HEX1$$e900$$ENDHEX$$ation du travail.                              */
/*------------------------------------------------------------------*/
	If	idw_Routage.GetItemString ( 1, "ALT_QUEUE" ) = "O"	And Not bStop Then
		If	idw_Routage.GetItemString ( 1, "ALT_OCCUPE" ) = "O" Then

			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
			stMessage.Icon			= Information!
			stMessage.Bouton		= OK!
			stMessage.bErreurG	= False
			stMessage.sVar[1]		= idw_Routage.GetItemString ( 1, "TRV_MAJ_PAR" )
			stMessage.sCode		= "WORK170"

			F_Message ( stMessage )

			bStop = True
		Else
			Choose Case idw_Routage.GetItemString ( 1, "COD_ETAT" )
			Case "1"
				stMessage.sVar[1] = "(en SAISIE)"
			Case "3"
				stMessage.sVar[1] = "(en EDITION)"
			Case "5"
				stMessage.sVar[1] = "(en VALIDATION)"
			End Choose

			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
			stMessage.Icon			= Question!
			stMessage.Bouton		= YesNo!
			stMessage.bErreurG	= False
			stMessage.sCode		= "WORK160"

			If Not ibWorkFlow_En_Consult Then
				If F_Message ( stMessage ) = 2 Then
					bStop = True
				Else

/*------------------------------------------------------------------*/
/* Le 02/12/1998:                                                   */
/* Dans le cas ou un travail existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$, on affiche aussi la date  */
/* de cr$$HEX1$$e900$$ENDHEX$$ation du travail pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent (TRV_CREE_LE) ainsi que la      */
/* date de r$$HEX1$$e900$$ENDHEX$$ception SPB (DTE_RECU).                                */
/*------------------------------------------------------------------*/
					sTrvCreeLe	= "Travail pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent : " + String ( idw_Routage.GetItemDateTime ( 1, "TRV_CREE_LE" ), "dd/mm/yyyy hh:mm" )
//Migration PB8-WYNIWYG-03/2006 FM
//					sDteRecu		= "Arriv$$HEX1$$e900$$ENDHEX$$e AOC : " + String ( idw_Routage.GetItemDate ( 1, "DTE_RECU" ), "dd/mm/yyyy" )
					sDteRecu		= "Arriv$$HEX1$$e900$$ENDHEX$$e AOC : " + String ( idw_Routage.GetItemDateTime ( 1, "DTE_RECU" ), "dd/mm/yyyy" )
//Fin Migration PB8-WYNIWYG-03/2006 FM
					sTxtAvert	= "Nouveaux $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments recus le : " + String ( Today (), "dd/mm/yyyy" )
					sTxtAvert	= sTxtAvert + " - " + sTrvCreeLe + " - " + sDteRecu
				End If
			End If
		End If
	End If

	If	Not bStop Then

		ll_ret = idw_Sinistre.Retrieve ( lIdSin, sCodTravail )
		lTotInter		= idw_Inter.Retrieve ( lIdSin, sCodTravail )

/*------------------------------------------------------------------*/
/* Le 15/01/1999                                                    */
/* On v$$HEX1$$e900$$ENDHEX$$rifie si la personne peut saisir un compl$$HEX1$$e900$$ENDHEX$$ment sur le       */
/* dossier correspondant. Les gestionnaires peuvent ne pas avoir    */
/* acc$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$la corbeille.                                            */
/*------------------------------------------------------------------*/
		lIdProd	= idw_Sinistre.GetItemNumber ( 1, "ID_PROD" )
		sRech		= "ID_PROD = " + String ( lIdProd )
		ll_ret = idw_wTravail.GetChild ( "ID_PROD", dwChild )

		lTotProduit = dwChild.RowCount ()
		lLig			= dwChild.Find ( sRech, 1, lTotProduit )

		If	lLig	<= 0	Then
			bStop = True

			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
			stMessage.Icon			= StopSign!
			stMessage.Bouton		= OK!
			stMessage.bErreurG	= False
			stMessage.sVar[1]		= String ( lIdProd )
			stMessage.sCode		= "WORK350"

			F_Message ( stMessage )
		End If
	End If

	If	Not bStop	Then
/*------------------------------------------------------------------*/
/* On populise la zone ID_I avec la liste des interlocuteurs        */
/* r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$s, en lui ajoutant en plus une entr$$HEX1$$e900$$ENDHEX$$e (-1->Autre)        */
/*------------------------------------------------------------------*/
		idw_wTravail.ClearValues ( "ID_I" )

		For	lCpt = 1 To lTotInter
				sRet	= String ( lCpt )
				sNom	= idw_Inter.Describe ( "Evaluate ( 'LookUpDisplay ( COD_CIV )', " + sRet + ") " ) + " " + idw_Inter.GetItemString ( lCpt, "NOM" )
				sData = sNom + "~t" + String ( idw_Inter.GetItemNumber ( lCpt, "ID_I" ) )
				idw_wTravail.SetValue ( "ID_I", lCpt, sData )
		Next
		idw_wTravail.SetValue ( "ID_I", ( lTotInter + 1 ), "Autre~t-1" )

		idw_wTravail.SetItem ( 1, "ID_SIN", lIdSin )
		idw_wTravaiL.SetItem ( 1, "ID_I",  stNul.dcm )
		idw_wTravaiL.SetItem ( 1, "COD_I_PROV",  stNul.str )

/*------------------------------------------------------------------*/
/* On populise maintenant les diverses informations du sinistre     */
/* (Provenant soit de W_SIN ou de SINISTRE+PERSONNE)                */
/*------------------------------------------------------------------*/
		lIdProd	= idw_Sinistre.GetItemNumber ( 1, "ID_PROD" )
		lIdEts	= idw_Sinistre.GetItemNumber ( 1, "ID_ETS" )
		sIdAdh	= idw_Sinistre.GetItemString ( 1, "ID_ADH" )
		lIdsDos	= idw_Sinistre.GetItemNumber ( 1, "ID_SDOS" )

//Migration PB8-WYNIWYG-03/2006 FM
//		dDteAdh	= idw_Sinistre.GetItemDate ( 1, "DTE_ADH" )
//		dDteDecl	= idw_Sinistre.GetItemDate ( 1, "DTE_DECL" )
//		dDteSurv	= idw_Sinistre.GetItemDate ( 1, "DTE_SURV" )
//		dDteResil= idw_Sinistre.GetItemDate ( 1, "DTE_RESIL" )
		dDteAdh	= idw_Sinistre.GetItemDateTime ( 1, "DTE_ADH" )
		dDteDecl	= idw_Sinistre.GetItemDateTime ( 1, "DTE_DECL" )
		dDteSurv	= idw_Sinistre.GetItemDateTime ( 1, "DTE_SURV" )
		dDteResil= idw_Sinistre.GetItemDateTime ( 1, "DTE_RESIL" )
//Fin Migration PB8-WYNIWYG-03/2006 FM

		sCodCiv	= idw_Sinistre.GetItemString ( 1, "COD_CIV" )
		sNom		= idw_Sinistre.GetItemString ( 1, "NOM" )
		sPrenom	= idw_Sinistre.GetItemString ( 1, "PRENOM" )
		sAdr1		= idw_Sinistre.GetItemString ( 1, "ADR_1" )
		sAdr2		= idw_Sinistre.GetItemString ( 1, "ADR_2" )
		sAdrCp	= idw_Sinistre.GetItemString ( 1, "ADR_CP" )
		sAdrVille= idw_Sinistre.GetItemString ( 1, "ADR_VILLE" )
		sNumTeld	= idw_Sinistre.GetItemString ( 1, "NUM_TELD" )
		sNumTelb	= idw_Sinistre.GetItemString ( 1, "NUM_TELB" )
		sNumFax	= idw_Sinistre.GetItemString ( 1, "NUM_FAX" )

		sNumPort			= idw_Sinistre.GetItemString ( 1, "NUM_PORT" )
		sNumIMEIPort	= idw_Sinistre.GetItemString ( 1, "NUM_IMEI_PORT" )
		sMarqPort		= idw_Sinistre.GetItemString ( 1, "MARQ_PORT" )
		sModlPort		= idw_Sinistre.GetItemString ( 1, "MODL_PORT" )
//Migration PB8-WYNIWYG-03/2006 FM
//		dDteAchPort		= idw_Sinistre.GetItemDate	  ( 1, "DTE_ACH_PORT" )
//		dDteOuvLigPort = idw_Sinistre.GetItemDate   ( 1, "DTE_OUVLIG_PORT" )
		dDteAchPort		= idw_Sinistre.GetItemDateTime	  ( 1, "DTE_ACH_PORT" )
		dDteOuvLigPort = idw_Sinistre.GetItemDateTime   ( 1, "DTE_OUVLIG_PORT" )
//Fin Migration PB8-WYNIWYG-03/2006 FM

		idw_wTravail.SetItem ( 1, "ID_PROD", lIdProd )
		idw_wTravail.SetItem ( 1, "ID_ETS", lIdEts )
		idw_wTravail.SetItem ( 1, "ID_ADH", sIdAdh )
		idw_wTravail.SetItem ( 1, "ID_SDOS", lIdsDos )

		idw_wTravail.SetItem ( 1, "DTE_ADH", dDteAdh )
		idw_wTravail.SetItem ( 1, "DTE_DECL", dDteDecl )
		idw_wTravail.SetItem ( 1, "DTE_SURV", dDteSurv )
		idw_wTravail.SetItem ( 1, "DTE_RESIL", dDteResil )

		idw_wTravail.SetItem ( 1, "COD_CIV", sCodCiv )
		idw_wTravail.SetItem ( 1, "NOM", sNom )
		idw_wTravail.SetItem ( 1, "PRENOM", sPrenom )
		idw_wTravail.SetItem ( 1, "ADR_1", sAdr1 )
		idw_wTravail.SetItem ( 1, "ADR_2", sAdr2 )
		idw_wTravail.SetItem ( 1, "ADR_CP", sAdrCp )
		idw_wTravail.SetItem ( 1, "ADR_VILLE", sAdrVille )
		idw_wTravail.SetItem ( 1, "NUM_TELD", sNumTeld )
		idw_wTravail.SetItem ( 1, "NUM_TELB", sNumTelb )
		idw_wTravail.SetItem ( 1, "NUM_FAX", sNumFax )

		idw_wTravail.SetItem ( 1, "NUM_PORT", sNumPort )
		idw_wTravail.SetItem ( 1, "NUM_IMEI_PORT", sNumIMEIPort )
		idw_wTravail.SetItem ( 1, "MARQ_PORT", sMarqPort )
		idw_wTravail.SetItem ( 1, "MODL_PORT", sModlPort )
		idw_wTravail.SetItem ( 1, "DTE_ACH_PORT", dDteAchPort )
		idw_wTravail.SetItem ( 1, "DTE_OUVLIG_PORT", dDteOuvLigPort )


/*------------------------------------------------------------------*/
/* On arme maintenant le code corbeille ainsi que le libell$$HEX2$$e9002000$$ENDHEX$$de la  */
/* corbeille. Ces informations sont r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es de la DDDW sur       */
/* ID_PROD.                                                         */
/*------------------------------------------------------------------*/
		idw_wTravail.ClearValues ( "ID_CORB" )

		idw_wTravail.GetChild ( "ID_PROD", dwChild )
		sRech 		= "ID_PROD = " + String ( lIdProd )
		lTotProduit = dwChild.RowCount ()
		lLig			= dwChild.Find ( sRech, 1, lTotProduit )
/*------------------------------------------------------------------*/
/* On n'oublie pas de se repositionner sur la bonne ligne pour      */
/* ID_PROD. C'est important, en effet dans les autres scripts on    */
/* fait des GETROW.                                                 */
/*------------------------------------------------------------------*/
		dwChild.ScrollToRow ( lLig )
		dwChild.SetRow ( lLig )

		sLibCorb = dwChild.GetItemString ( lLig, "LIB_CORB" )
		lIdCorb	= dwChild.GetItemNumber ( lLig, "ID_CORB" )
		sCodAdh	= dwChild.GetItemString ( lLig, "COD_ADH" )

		sData		= sLibCorb + "~t" + String ( lIdCorb )
		idw_wTravail.SetValue ( "ID_CORB", 1, sData )
		idw_wTravail.SetItem ( 1, "ID_CORB", lIdCorb )

/*------------------------------------------------------------------*/
/* On arme $$HEX1$$e900$$ENDHEX$$ventuellement la zone message dans le cas d'un dossier  */
/* clos ou pour un travail d$$HEX1$$e800$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$existant.                           */
/*------------------------------------------------------------------*/
		If	sTxtAvert <> "" Then
			sTxtMess1 = idw_Routage.GetItemString ( 1, "TXT_MESS1" )
			If	Not IsNull ( sTxtMess1 ) Then
				sTxtAvert = sTxtMess1 + "~r~n" + sTxtAvert
			End If
			idw_wTravail.SetItem ( 1, "TXT_MESS1", sTxtAvert )
		End If
	End If

	If	Not bStop	Then
/*------------------------------------------------------------------*/
/* Le 01/06/1999. Modif DGA.                                        */
/* On va recalculer la date de fin de garantie pour les produits    */
/* dont la gestion est assur$$HEX1$$e900$$ENDHEX$$e chez EDMS.                           */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La variable sCodAdh est arm$$HEX1$$e900$$ENDHEX$$e juste au-dessus, dans la fonction  */
/* qui positionne la DDDW de PRODUIT.                               */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On s'occupe simplement des produits avec un COD_ADH $$HEX2$$e0002000$$ENDHEX$$1. On ne   */
/* calcule pas la date de fin de garantie pour les produits avec    */
/* COD_ADH = 6.                                                     */
/*------------------------------------------------------------------*/
		If	sCodAdh = "1"	Then
			lRet = Uf_Verifier_Adhesion_Edms_Cplt ()

			If	lRet <> 1	Then
				stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= False
				stMessage.sCode		= "WORK200"

				F_Message ( stMessage )

				idw_wTravail.SetItem ( 1, "ID_SIN", stNul.dcm )

			End If
		End If
	End If


	/*------------------------------------------------------------------*/
	/* Modif suite DCMP990451                                           */
	/*------------------------------------------------------------------*/
	If Not bStop Then

		If idw_wTravail.GetItemString ( 1, "COD_TYP_RECU" ) = "C" Then
		
			lPochette = -1

			iTrTrans.PS_S02_W_QUEUE_POCHETTE	( idw_wTravail.GetItemNumber ( 1, "ID_SIN"), "TRAVAIL" , lPochette )

			// << Veuillez ouvrir une pochette pour ce compl$$HEX1$$e900$$ENDHEX$$ment >>
			If lPochette = 1 Then

				istpochette.Text =  ProfileString ( stGlb.sFichierErreur, "MESSAGE", "WORK360", "Message Pochette Introuvable" )
				istpochette.Show()

			End If
		End If
	End If

	If lLig > 0 Then 
		/*----------------------------------------------------------------------------*/
		/* AJOUT JFF LE 11/05/2001 : On filtre la Dw des utilisateurs.                */
		/*----------------------------------------------------------------------------*/
		ibAltContact = dwChild.GetItemString ( lLig, "ALT_CONTACT" ) = "O"
		This.uf_Gestion_Contacts ( String ( lIdCorb) , lIdSin )

		/*------------------------------------------------------------------*/
		/* On s'occupe des TabOrder pour la t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie. On positionne       */
		/* toutes les zones $$HEX2$$e0002000$$ENDHEX$$NULL dans la fonction uf_Tb_Telephonie ()     */
		/*------------------------------------------------------------------*/
		uf_Tb_Telephonie ( dwChild.GetItemNumber ( lLig, "COD_TEL" ), FALSE, TRUE )
	Else
		ibAltContact = FALSE
	End If


Else
	iAction						= 1
	idw_wTravail.iiErreur	= 1
End If


//Migration PB8-WYNIWYG-03/2006 CP
//idw_wTravail.SetActionCode ( iAction )
		Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 CP		


end function

private function long uf_zn_idadh (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Zn_IdAdh (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de ID_ADH
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Integer iAction

Long dcIdCarte, dcIdGrp, lLig, lNbAffilier, lIdProd, lCodBaseDms, lCodProdDms, lCodAdrDms, lNbAdherent, lCodTel

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

String sIdAdh, sCodAdh, sIdTypeCarte

lIdProd			= idw_wTravail.GetItemNumber ( 1, "ID_PROD" )
sIdTypeCarte	= Space ( 3 )
sIdAdh			= idw_wTravail.GetText ()

/*------------------------------------------------------------------*/
/* On recherche les informations du produit en cours de saisie.     */
/*------------------------------------------------------------------*/
Uf_Recherche_Produit ( lLig, sCodAdh, lCodBaseDms, lCodProdDms, lCodAdrDms, lNbAdherent, lCodTel )

iAction				= 2

/*------------------------------------------------------------------*/
/* On va v$$HEX1$$e900$$ENDHEX$$rifier si le N$$HEX2$$b0002000$$ENDHEX$$de carte est valide. (Cas ou les         */
/* adh$$HEX1$$e900$$ENDHEX$$sions sont g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$s en fonction de la carte)                    */
/*------------------------------------------------------------------*/
Choose Case sCodAdh
Case "3", "4"
/*------------------------------------------------------------------*/
/* Le gestionnaire vient d'effacer le contenu de la zone. Gestion   */
/* du iiCarNul standard avec r$$HEX1$$e900$$ENDHEX$$initialisation d'un certain nombre   */
/* de zones $$HEX2$$e0002000$$ENDHEX$$la fin du script.                                     */
/*------------------------------------------------------------------*/
	If	sIdAdh = ""	Then
		iAction 	= 1

		If	sCodAdh = "3" Then
			idw_wTravail.SetItem ( 1, "ID_ETS", 0 )
		End If

		idw_wTravail.SetItem ( 1, "ID_CARTE", 0 )
		idw_wTravail.SetItem ( 1, "ID_TYPE_CARTE", "00" )

		idw_wTravail.SetItem ( 1, "ID_ORDRE", stNul.dcm )
		idw_wTravail.SetItem ( 1, "COD_PROV_PERS", "W" )
		ibSinLie = False

	Else
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie le N$$HEX2$$b0002000$$ENDHEX$$de carte.                                       */
/*------------------------------------------------------------------*/
		If	F_Carte ( sIdAdh, "111" )	Then
/*------------------------------------------------------------------*/
/* On recherche le type de la carte ainsi que son l'identifiant.    */
/* Cette recherche va s'effectuer dans la table CARTE. Si on ne     */
/* trouve rien, cela signifie que la carte est non couverte. On     */
/* interdit la cr$$HEX1$$e900$$ENDHEX$$ation d'un sinistre. Si la carte est couverte,    */
/* on v$$HEX1$$e900$$ENDHEX$$rifie l'affiliation de la carte au produit. Si cette        */
/* affiliation n'est pas trouv$$HEX1$$e900$$ENDHEX$$e, on affiche un message d'erreur    */
/* non bloquant. Le sinistre sera refus$$HEX2$$e9002000$$ENDHEX$$sur la grille.             */
/*------------------------------------------------------------------*/
			itrTrans.PS_S01_CARTE_SINISTRE ( sIdAdh, lIdProd, dcIdCarte, sIdTypeCarte, dcIdGrp, lNbAffilier )
			If	F_Procedure ( stMessage, itrTrans, "PS_S01_CARTE_SINISTRE" )	Then

				If	sIdTypeCarte = "   " Then

					iAction 						= 1
					idw_wTravail.iiErreur	= 3

				Else
/*------------------------------------------------------------------*/
/* Cette carte ne semble pas $$HEX1$$ea00$$ENDHEX$$tre affili$$HEX1$$e900$$ENDHEX$$e au produit. On affiche   */
/* un message non bloquant.                                         */
/*------------------------------------------------------------------*/
					If	lNbAffilier = 0 Then
						stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
						stMessage.Icon			= Information!
						stMessage.bErreurG	= False
						stMessage.sCode		= "WORK140"

						F_Message ( stMessage )
					End If
/*------------------------------------------------------------------*/
/* On arme n$$HEX1$$e900$$ENDHEX$$ammoins la zone ID_ETS avec la zone dcIdGrp que l'on   */
/* vient de r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer. La zone ID_ETS est non accessible. Mais cela */
/* uniquement pour les produits avec COD_ADH = 3.                   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On arme maintenant les valeurs pour ID_TYPE_CARTE et ID_CARTE.   */
/*------------------------------------------------------------------*/
					idw_wTravail.SetItem ( 1, "ID_CARTE", dcIdCarte )
					idw_wTravail.SetItem ( 1, "ID_TYPE_CARTE", sIdTypeCarte )
			
					If	sCodAdh = "3" Then
						idw_wTravail.SetItem ( 1, "ID_ETS", dcIdGrp )
					End If
				End If
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la proc$$HEX1$$e900$$ENDHEX$$dure, la structure     */
/* stMessage vient d'$$HEX1$$ea00$$ENDHEX$$tre arm$$HEX1$$e900$$ENDHEX$$e, on d$$HEX1$$e900$$ENDHEX$$clenche un ItemError.         */
/*------------------------------------------------------------------*/
			Else
				iAction 						= 1
				idw_wTravail.iiErreur	= 2
			End If
		Else
/*------------------------------------------------------------------*/
/* Il y a une erreur de saisie sur le N$$HEX2$$b0002000$$ENDHEX$$de carte.                  */
/*------------------------------------------------------------------*/
			iAction 						= 1
			idw_wTravail.iiErreur	= 1
		End If
	End If

Case "1", "2", "5", "6"
/*------------------------------------------------------------------*/
/* On enl$$HEX1$$e900$$ENDHEX$$ve les z$$HEX1$$e900$$ENDHEX$$ros que le gestionnaire pourrait saisir.         */
/*------------------------------------------------------------------*/
	If	sIdAdh = "" Then
		sIdAdh = stNul.str
	Else
		sIdAdh = String ( Dec ( sIdAdh ) )
	End If	

	idw_wTravail.SetItem ( 1, "ID_SDOS", stNul.dcm )
	
End Choose


//Migration PB8-WYNIWYG-03/2006 CP
//idw_wTravail.SetActionCode ( iAction )
		ll_return = iAction
//Fin Migration PB8-WYNIWYG-03/2006 CP		


/*------------------------------------------------------------------*/
/* Il est important de faire un ActionCode $$HEX2$$e0002000$$ENDHEX$$2. En effet la         */
/* fonction SetActionCode n'est pas imm$$HEX1$$e900$$ENDHEX$$diate. Il faut attendre la  */
/* fin de la fonction appelante.                                    */
/*------------------------------------------------------------------*/
If	iAction = 2 Then
	If	sIdAdh = "" Then SetNull ( sIdAdh )
	idw_wTravail.SetItem ( 1, "ID_ADH", sIdAdh )

/*------------------------------------------------------------------*/
/* Si la zone ID_PROD est saisie, on essaye de r$$HEX1$$e900$$ENDHEX$$cuperer des        */
/* sinistres li$$HEX1$$e900$$ENDHEX$$s.                                                  */
/*------------------------------------------------------------------*/
	If	lLig > 0 Then
		Uf_Recuperer_Sinistres_Lies ( astPass )
	End If
Else
/*------------------------------------------------------------------*/
/* Il vient d'y avoir une erreur. (N$$HEX2$$b0002000$$ENDHEX$$de carte incorrecte, Erreur   */
/* de saisie, Erreur de proc$$HEX1$$e900$$ENDHEX$$dure, Carte non couverte). On ne va    */
/* pas r$$HEX1$$e900$$ENDHEX$$initialiser la valeur de ID_ADH avec la valeur pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente  */
/* selon le souhait de Denis. Il faut donc annuler les valeurs      */
/* pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dentes pour ID_CARTE et ID_TYPE_CARTE. De plus, au cas ou,  */
/* dans la fonction Uf_Valider () si la zone ID_ADH est NULL, on    */
/* force ID_CARTE et ID_TYPE_CARTE. Deux contr$$HEX1$$f400$$ENDHEX$$les valent mieux     */
/* qu'un.                                                           */
/*------------------------------------------------------------------*/
//		ibSinLie = False

End If

//Migration PB8-WYNIWYG-03/2006 CP
//
		Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end function

private function long uf_zn_idsdos (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Zn_IdsDos (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de ID_SDOS
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lVal, lLig, lCodBaseDms, lCodProdDms, lCodAdrDms, lNbAdherent, lCodTel
Long lIdsDosPrec

String sCodAdh

Long lRet

lIdsDosPrec = idw_wTravail.GetItemNumber ( 1, "ID_SDOS" )

lVal 			= Long ( idw_wTravail.GetText () )
idw_wTravail.SetItem ( 1, "ID_SDOS", lVal )

lRet = 1

/*------------------------------------------------------------------*/
/* On recherche les informations du produit en cours de saisie.     */
/*------------------------------------------------------------------*/
Uf_Recherche_Produit ( lLig, sCodAdh, lCodBaseDms, lCodProdDms, lCodAdrDms, lNbAdherent, lCodTel )

/*------------------------------------------------------------------*/
/* On va tester la valeur de ID_SDOS en fonction du nombre          */
/* d'adh$$HEX1$$e900$$ENDHEX$$rents autoris$$HEX1$$e900$$ENDHEX$$s dans la table PRODUIT.                     */
/*------------------------------------------------------------------*/
If	lVal > lNbAdherent Then

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= False
	stmessage.sVar[1]		= String ( lNbAdherent )
	stMessage.sCode		= "WORK340"

	F_Message ( stMessage )

	idw_wTravail.SetItem ( 1, "ID_SDOS", lIdsDosPrec )
Else
/*------------------------------------------------------------------*/
/* La m$$HEX1$$e900$$ENDHEX$$thode d'adh$$HEX1$$e900$$ENDHEX$$sion nous oblige a rechercher les adh$$HEX1$$e900$$ENDHEX$$sions     */
/* sur EDMS.                                                        */
/*------------------------------------------------------------------*/
	If	sCodAdh = "1" Or sCodAdh = "6" Then
		lRet = Uf_Verifier_Adhesion_Edms ()
	End If

	If	lRet > 0	Then
/*------------------------------------------------------------------*/
/* La recherche sur la base EDMS vient d'aboutir. Si la gestion     */
/* des adresses est prise en compte, on rend la zone ALT_ADR        */
/* saississable.                                                    */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On se retrouve aussi ici dans le cas ou les adh$$HEX1$$e900$$ENDHEX$$sions ne sont    */
/* pas g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es chez SPB.                                             */
/*------------------------------------------------------------------*/
		Choose Case lCodAdrDms
		Case 1, 2
			idw_wTravail.Uf_Proteger ( { "ALT_ADR" }, "0" )
			idw_wTravail.SetItem ( 1, "ALT_ADR", "N" )

			If	lCodAdrDms = 1 Then
				idw_wTravail.Uf_Proteger ( { "NOM", "PRENOM", "ADR_1", "ADR_2", "ADR_CP", "ADR_VILLE" }, "1" )
			Else
				idw_wTravail.Uf_Proteger ( { "NOM", "PRENOM" }, "1" )
			End If
		End Choose
/*------------------------------------------------------------------*/
/* On va d$$HEX1$$e900$$ENDHEX$$clencher la recherche des sinistres li$$HEX1$$e800$$ENDHEX$$s.                */
/*------------------------------------------------------------------*/
		Uf_Recuperer_Sinistres_Lies ( astPass )
	Else
/*------------------------------------------------------------------*/
/* L'adh$$HEX1$$e900$$ENDHEX$$sion n'existe pas, ou bien il y a un probl$$HEX1$$e900$$ENDHEX$$me, on          */
/* positionne la zone ID_SDOS $$HEX2$$e0002000$$ENDHEX$$NULL.                               */
/*------------------------------------------------------------------*/
		idw_wTravail.SetItem ( 1, "ID_SDOS", stNul.dcm )

		Choose Case lRet
		Case 0					// Adh$$HEX1$$e900$$ENDHEX$$sion n'existe pas
			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le sur la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= False
			stMessage.sCode		= "WORK200"

			F_Message ( stMessage )

		End Choose
	End If
End If

//Migration PB8-WYNIWYG-03/2006 CP
//idw_wTravail.SetActionCode ( 2 )
		Return 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		


end function

private function long uf_zn_dtecourcli ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Zn_DteCourCli (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de DTE_COUR_CLI
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Integer iAction

Date dDteCourCli

iAction = 0

/*------------------------------------------------------------------*/
/* La date du courrier client doit $$HEX1$$ea00$$ENDHEX$$tre inf$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gale $$HEX2$$e0002000$$ENDHEX$$la    */
/* date de r$$HEX1$$e900$$ENDHEX$$ception du courrier.                                   */
/*------------------------------------------------------------------*/
If	Uf_Ctrl_CourCli_Recu () < 0 Then
	idw_wTravail.iiErreur = 1
	iAction = 1
End If

/*------------------------------------------------------------------*/
/* La date du courrier client doit $$HEX1$$ea00$$ENDHEX$$tre sup$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gale $$HEX2$$e0002000$$ENDHEX$$la    */
/* date de survenance.                                              */
/*------------------------------------------------------------------*/
If	iAction = 0 Then
	If	Uf_Ctrl_CourCli_Surv () < 0 Then
		idw_wTravail.iiErreur = 2
		iAction = 1
	End If
End If

/*------------------------------------------------------------------*/
/* Dans le cas d'une d$$HEX1$$e900$$ENDHEX$$claration, la zone DTE_DECL est $$HEX1$$e900$$ENDHEX$$gale $$HEX7$$e000200020002000200020002000$$ENDHEX$$*/
/* DTE_COUR_CLI.                                                    */
/*------------------------------------------------------------------*/
If	iAction = 0 And idw_wTravail.GetItemString ( 1, "COD_TYP_RECU" ) = "D" Then
	dDteCourCli		= Date ( idw_wTravail.GetText () )
	idw_wTravail.SetItem ( 1, "DTE_DECL", dDteCourCli )
End If

//Migration PB8-WYNIWYG-03/2006 CP
//idw_wTravail.SetActionCode ( iAction )
		Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end function

private function long uf_zn_dtesurv ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Zn_DteSurv (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de DTE_SURV
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Integer iAction

Long lIdProd, lLig

DataWindowChild dwChild

String sCodAdh

iAction = 0

/*------------------------------------------------------------------*/
/* La date du courrier client doit $$HEX1$$ea00$$ENDHEX$$tre sup$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gale $$HEX2$$e0002000$$ENDHEX$$la    */
/* date de survenance.                                              */
/*------------------------------------------------------------------*/
If	Uf_Ctrl_CourCli_Surv () < 0 Then
	idw_wTravail.iiErreur = 1
	iAction = 1
End If

/*------------------------------------------------------------------*/
/* La date du r$$HEX1$$e900$$ENDHEX$$ception doit $$HEX1$$ea00$$ENDHEX$$tre sup$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gale $$HEX2$$e0002000$$ENDHEX$$la          */
/* date de survenance.                                              */
/*------------------------------------------------------------------*/
If	iAction = 0 Then
	If	Uf_Ctrl_Recu_Surv () < 0 Then
		idw_wTravail.iiErreur = 2
		iAction = 1
	End If
End If

/*------------------------------------------------------------------*/
/* La date de survenance sert a calculer la date d'adh$$HEX1$$e900$$ENDHEX$$sion pour    */
/* les produits avec COD_ADH = 1. Il faut donc r$$HEX1$$e900$$ENDHEX$$initialiser        */
/* syst$$HEX1$$e900$$ENDHEX$$matiquement la zone ID_SDOS, car c'est sur cette zone que   */
/* l'on d$$HEX1$$e900$$ENDHEX$$clenche la recherche des adh$$HEX1$$e900$$ENDHEX$$sions.                       */
/*------------------------------------------------------------------*/
If	iAction = 0 Then
	lIdProd = idw_wTravail.GetItemNumber ( 1, "ID_PROD" )
	If	Not IsNull ( lIdProd )	Then
		idw_wTravail.GetChild ( "ID_PROD", dwChild )

		lLig				= dwChild.GetRow ()
		sCodAdh			= dwChild.GetItemString ( lLig, "COD_ADH" )
		If	sCodAdh = "1" Or sCodAdh = "6" Then
			idw_wTravail.SetItem ( 1, "ID_SDOS", stNul.dcm )
		End If
	End If
End If

//Migration PB8-WYNIWYG-03/2006 CP
//idw_wTravail.SetActionCode ( iAction )
		Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 CP		



end function

private function long uf_zn_dterecu ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Wkf::Uf_Zn_DteRecu (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de DTE_RECU
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Integer iAction

iAction = 0

/*------------------------------------------------------------------*/
/* La date du courrier client doit $$HEX1$$ea00$$ENDHEX$$tre inf$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gale $$HEX2$$e0002000$$ENDHEX$$la    */
/* date de r$$HEX1$$e900$$ENDHEX$$ception du courrier.                                   */
/*------------------------------------------------------------------*/
If	Uf_Ctrl_CourCli_Recu () < 0 Then
	idw_wTravail.iiErreur = 1
	iAction = 1
End If

/*------------------------------------------------------------------*/
/* La date du r$$HEX1$$e900$$ENDHEX$$ception doit $$HEX1$$ea00$$ENDHEX$$tre sup$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gale $$HEX2$$e0002000$$ENDHEX$$la          */
/* date de survenance.                                              */
/*------------------------------------------------------------------*/
If	iAction = 0 Then
	If	Uf_Ctrl_Recu_Surv () < 0 Then
		idw_wTravail.iiErreur = 2
		iAction = 1
	End If
End If

//Migration PB8-WYNIWYG-03/2006 CP
//idw_wTravail.SetActionCode ( iAction )
		Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end function

private function long uf_zn_altadr ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_AltAdr (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 17:35:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de la zone ALT_ADR
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sAltAdr, sCodAdh, sNom, sPrenom, sAdr1, sAdr2, sAdrCp, sAdrVille
String sCol[ 6 ]

Long lLig, lCodBaseDms, lCodProdDms, lCodAdrDms, lNbAdherent, lCodTel

Integer iAction

sCol[  1 ] = "ADR_1"
sCol[  2 ] = "ADR_2"
sCol[  3 ] = "ADR_CP"
sCol[  4 ] = "ADR_VILLE"
sCol[  5 ] = "NOM"
sCol[  6 ] = "PRENOM"

sAltAdr = idw_wTravail.GetText ()
iAction = 0

/*------------------------------------------------------------------*/
/* On rend la zone ALT_ADR accessible dans la fonction              */
/* Uf_Recuperer_Adhesion.                                           */
/*------------------------------------------------------------------*/
If Not Uf_Recherche_Produit ( lLig, sCodAdh, lCodBaseDms, lCodProdDms, lCodAdrDms, lNbAdherent, lCodTel ) Then
	iAction = 2
Else
	If	sAltAdr = "N" Then
		If	lCodAdrDms = 1 Then
			idw_wTravail.Uf_Proteger ( sCol, "1" )
		Else
			idw_wTravail.Uf_Proteger ( { "NOM", "PRENOM" }, "1" )
		End If

		sNom			= idw_Adh.GetItemString ( 1, "DOSAD_NOM" )
		sPrenom		= idw_Adh.GetItemString ( 1, "DOSAD_PRENOM" )
		sAdr1			= idw_Adh.GetItemString ( 1, "DOSAD_ADRESSE1" )
		sAdr2			= idw_Adh.GetItemString ( 1, "DOSAD_ADRESSE2" )
		sAdrCp		= idw_Adh.GetItemString ( 1, "DOSAD_CPOSTALE" )
		sAdrVille	= idw_Adh.GetItemString ( 1, "DOSAD_VILLE" )

		idw_wTravail.SetItem ( 1, "NOM", 		sNom )
		idw_wTravail.SetItem ( 1, "PRENOM", 	sPrenom )
		idw_wTravail.SetItem ( 1, "ADR_1", 		sAdr1 )
		idw_wTravail.SetItem ( 1, "ADR_2", 		sAdr2 )
		idw_wTravail.SetItem ( 1, "ADR_CP", 	sAdrCp )
		idw_wTravail.SetItem ( 1, "ADR_VILLE", sAdrVille )

/*------------------------------------------------------------------*/
/* Si la zone COD_PROV_PERS est positionn$$HEX1$$e900$$ENDHEX$$e mais que ibSinLie est   */
/* faux, il faut repositionner COD_PROV_PERS $$HEX2$$e0002000$$ENDHEX$$W.                   */
/*------------------------------------------------------------------*/
		If	Not ibSinLie Then
			idw_wTravail.SetItem ( 1, "COD_PROV_PERS", 	"W" )
			idw_wTravail.SetItem ( 1, "ID_ORDRE", 			stNul.dcm )			
		End If

	Else
		If	lCodAdrDms = 1 Then
			idw_wTravail.Uf_Proteger ( sCol, "0" )
		Else
			idw_wTravail.Uf_Proteger ( { "NOM", "PRENOM" }, "0" )
		End If
	End If
End If

//Migration PB8-WYNIWYG-03/2006 CP
//idw_wTravail.SetActionCode ( iAction )
		Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 CP		


end function

private subroutine uf_valider (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Travail::Uf_Valider (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Enregistrement des informations correspondant au travail
//*					  VOIR AUSSI L'OBJET CONTACT_TRACE, ON INSERE AUSSI UN TRAVAIL !
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* Ajout des colonnes ID_CONTRAT_ABONNE, ID_HLR, ID_ORIAN_MARQUE,   */
/* ID_ORIAN_MODELE, ID_ORIAN_BOUTIQUE.                              */
/*------------------------------------------------------------------*/
Boolean bRet

String sCodTypeRecu, sCodRecu, sCodIProv, sIdAdh, sDosMajPar, sIdSinContact
String sCodCiv, sNom, sPrenom, sAdr1, sAdr2, sAdrCp, sAdrVille, sNumTelD, sNumTelB, sNumFax, sTxtMess1, sCodOper
String sCodTravail, sAltQueue, sIdTypeCarte, sCodProvPers, sProc, sSql
String sCodModeRegA, sRibBq, sRibGui, sRibCpt, sRibCle
String sCodBq_B, sCodAg_B, sNom_B, sAdr1_B, sAdr2_B, sAdrCp_B, sAdrVille_B, sCodModeRegB, sAltCreBqDms, sNumTelD_B

String 	sNumPort, sNumImeiPort, sMarqPort, sModlPort, sIdContratAbonne
DateTime	dtDteAchPort, dtDteOuvLigPort

DateTime dtDteCourCli, dtDteRecu, dtDteAdh, dtDteFinGti, dtDteResil, dtDteDecl, dtDteSurv, dtMajLe, dtCreeLe
DateTime dtDteSous, dtDteOpt, dtNow

Decimal dcNbPage, dcIdSin, dcIdI, dcIdProd, dcIdEts, dcIdsDos, dcOption, dcIdCarte, dcIdOrdre

Long lLig, lMaxSeq, lNbrPI
Long lIdHlr, lIdOrianMarque, lIdOrianModele, lIdOrianBoutique

Decimal dcIdCorb
String  sNvIdSin

DataWindowChild dwChild

bRet = True

sProc			= Space ( 60 )
sNvIdSin		= Space ( 10 ) // [PI062]

/*------------------------------------------------------------------*/
/* On arme les variables dont on a besoin dans la proc$$HEX1$$e900$$ENDHEX$$dure.        */
/*------------------------------------------------------------------*/

sCodTypeRecu	= idw_wTravail.GetItemString ( 1, "COD_TYP_RECU" )
sCodRecu			= idw_wTravail.GetItemString ( 1, "COD_RECU" )
// [PI056]
/*
dtDteCourCli	= DateTime ( idw_wTravail.GetItemDate ( 1, "DTE_COUR_CLI" ) )
dtDteRecu		= DateTime ( idw_wTravail.GetItemDate ( 1, "DTE_RECU" ) )
*/
dtDteCourCli	= idw_wTravail.GetItemDateTime ( 1, "DTE_COUR_CLI" )
dtDteRecu		=  idw_wTravail.GetItemDateTime ( 1, "DTE_RECU" )
// :[PI056]

dcNbPage			= idw_wTravail.GetItemNumber ( 1, "NB_PAGE" )
dcIdSin			= idw_wTravail.GetItemNumber ( 1, "ID_SIN" )
dcIdI				= idw_wTravail.GetItemNumber ( 1, "ID_I" )
sCodIProv		= idw_wTravail.GetItemString ( 1, "COD_I_PROV" )

dcIdProd			= idw_wTravail.GetItemNumber ( 1, "ID_PROD" )
dcIdEts			= idw_wTravail.GetItemNumber ( 1, "ID_ETS" )
sIdAdh			= F_GetString ( idw_wTravail, 1, "ID_ADH" )
dcIdsDos			= idw_wTravail.GetItemNumber ( 1, "ID_SDOS" )
dcOption			= idw_wTravail.GetItemNumber ( 1, "OPTION" )

// [PI056]
/*
dtDteAdh			= DateTime ( idw_wTravail.GetItemDate ( 1, "DTE_ADH" ) )
dtDteFinGti		= DateTime ( idw_wTravail.GetItemDate ( 1, "DTE_FIN_GTI" ) )
dtDteResil		= DateTime ( idw_wTravail.GetItemDate ( 1, "DTE_RESIl" ) )
*/
dtDteAdh			= idw_wTravail.GetItemDateTime ( 1, "DTE_ADH" ) 
dtDteFinGti		= idw_wTravail.GetItemDateTime ( 1, "DTE_FIN_GTI" ) 
dtDteResil		= idw_wTravail.GetItemDateTime ( 1, "DTE_RESIl" ) 
// :[PI056]

dcIdCorb			= idw_wTravail.GetItemNumber ( 1, "ID_CORB" )

// [PI056]
/*dtDteDecl		= DateTime ( idw_wTravail.GetItemDate ( 1, "DTE_DECL" ) )
dtDteSurv		= DateTime ( idw_wTravail.GetItemDate ( 1, "DTE_SURV" ) )*/
dtDteDecl		= idw_wTravail.GetItemDateTime ( 1, "DTE_DECL" ) 
dtDteSurv		=  idw_wTravail.GetItemDateTime ( 1, "DTE_SURV" ) 
// :[PI056]

sCodCiv			= idw_wTravail.GetItemString ( 1, "COD_CIV" )
sNom				= Trim ( idw_wTravail.GetItemString ( 1, "NOM" ) )
sPrenom			= F_GetString ( idw_wTravail, 1, "PRENOM" )
sAdr1				= Trim ( idw_wTravail.GetItemString ( 1, "ADR_1" ) )
sAdr2				= F_GetString ( idw_wTravail, 1, "ADR_2" ) 
sAdrCp			= idw_wTravail.GetItemString ( 1, "ADR_CP" )
sAdrVille		= Trim ( idw_wTravail.GetItemString ( 1, "ADR_VILLE" ) )
sNumTelD			= F_GetString ( idw_wTravail, 1, "NUM_TELD" ) 
sNumTelB			= F_GetString ( idw_wTravail, 1, "NUM_TELB" ) 
sNumFax			= F_GetString ( idw_wTravail, 1, "NUM_FAX" ) 
sTxtMess1		= F_GetString ( idw_wTravail, 1, "TXT_MESS1" ) 

sCodOper			= stGLB.sCodOper
dtMajLe			= DateTime ( Today(), Now () )
dtCreeLe			= dtMajLe

If	sCodTypeRecu = "C" Then
	sCodTravail = idw_Routage.GetItemString ( 1, "COD_TRAVAIL" )
	sAltQueue	= idw_Routage.GetItemString ( 1, "ALT_QUEUE" )
Else
	sCodTravail = ""
	sAltQueue	= "N"
End If

// [PI056]
/*dtDteSous		= DateTime ( idw_wTravail.GetItemDate ( 1, "DTE_SOUS" ) )
dtDteOpt			= DateTime ( idw_wTravail.GetItemDate ( 1, "DTE_OPT" ) )*/
dtDteSous		= idw_wTravail.GetItemDateTime ( 1, "DTE_SOUS" )
dtDteOpt			= idw_wTravail.GetItemDateTime ( 1, "DTE_OPT" ) 
// :[PI056]

If	sIdAdh = "" Then 
	dcIdCarte 			= 0
	sIdTypeCarte		= "00"
Else
	dcIdCarte			= idw_wTravail.GetItemNumber ( 1, "ID_CARTE" )
	sIdTypeCarte		= idw_wTravail.GetItemString ( 1, "ID_TYPE_CARTE" )
End If

dcIdOrdre		= idw_wTravail.GetItemNumber ( 1, "ID_ORDRE" )
sCodProvPers	= idw_wTravail.GetItemString ( 1, "COD_PROV_PERS" )
If	IsNull ( sCodProvPers ) Or sCodProvPers = "" Then sCodProvPers = "W"

sCodModeRegA	= F_GetString ( idw_wTravail, 1, "COD_MODE_REG_A" )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le RIB du client dans le cas des adh$$HEX1$$e900$$ENDHEX$$sions g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es    */
/* chez SPB.                                                        */
/*------------------------------------------------------------------*/
If	idw_Adh.RowCount () > 0 Then
	sRibBq			= String ( idw_Adh.GetItemNumber ( 1, "DOSAD_BQE_PLVT" ), "00000" )
	sRibGui			= String ( idw_Adh.GetItemNumber ( 1, "DOSAD_AG_PLVT" ), "00000" )
	sRibCpt			= idw_Adh.GetItemString ( 1, "DOSAD_CPT_PLVT" )
	sRibCle			= idw_Adh.GetItemString ( 1, "DOSAD_CLE" )
End If

/*------------------------------------------------------------------*/
/* On s'occupe des valeurs pour l'interlocuteur BANQUE, si besoin.  */
/*------------------------------------------------------------------*/
If	sCodTypeRecu <> "C" Then
	idw_wTravail.GetChild ( "ID_PROD", dwChild )
	lLig = dwChild.GetRow ()

	sAltCreBqDms = dwChild.GetItemString ( lLig, "ALT_CREBQ_DMS" )

	If	sAltCreBqDms = "O" Then
		sCodBq_B 		= String ( idw_Adh.GetItemNumber ( 1, "DOSAD_BQE_PLVT" ), "00000" )
		sCodAg_B 		= String ( idw_Adh.GetItemNumber ( 1, "DOSAD_AG_PLVT" ), "00000" )
/*------------------------------------------------------------------*/
/* Pour le num$$HEX1$$e900$$ENDHEX$$ro de t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phone de la banque, on v$$HEX1$$e900$$ENDHEX$$rifie si la       */
/* longueur de la zone est de 10, et s'il n'y a que des chiffres.   */
/* Si tout est correct on initialise le N$$HEX2$$b0002000$$ENDHEX$$sinon on met une valeur  */
/* NULLE.                                                           */
/*------------------------------------------------------------------*/
		sNumTelD_B	= idw_Adh.GetItemString ( 1, "DOMIC_TELEPH_15" )
		If	Len ( sNumTelD_B ) <> 10 Or Not IsNumber ( sNumTelD_B ) Then
			sNumTelD_B = ""
		End If
			
/*------------------------------------------------------------------*/
/* Qui est destinataire des r$$HEX1$$e900$$ENDHEX$$glements ?                            */
/*------------------------------------------------------------------*/
		If	dwChild.GetItemString ( lLig, "COD_DEST_REG" ) = "B" Then
			sCodModeRegB	= dwChild.GetItemString ( lLig, "COD_MODE_REG" )
		End If

		Choose Case sCodBq_B
		Case "30004"
/*------------------------------------------------------------------*/
/* Cas de la BNP.                                                   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* DOMIC_NOM_BANQ                                                   */
/* 'AGENCE' + DOSAD_COD_AG                                          */
/* DOMIC_NOM_AGENCE	                                               */
/* '00000' '.'                                                      */
/*------------------------------------------------------------------*/
			sNom_B		= idw_Adh.GetItemString ( 1, "DOMIC_NOM_BANQ" )
			sAdr1_B		= "AGENCE " + sCodAg_B
			sAdr2_B		= idw_Adh.GetItemString ( 1, "DOMIC_NOM_AGENCE" )
			sAdrCp_B		= "00000"
			sAdrVille_B	= "."

		Case Else
/*------------------------------------------------------------------*/
//* Autres cas.                                                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* DOMIC_NOM_BANQ                                                   */
/* DOMIC_ADR35_1                                                    */
/* DOMIC_ADR35_2                                                    */
/* DOMIC_CPOSTAL DOMIC_VILLE                                        */
/*------------------------------------------------------------------*/
			sNom_B		= idw_Adh.GetItemString ( 1, "DOMIC_NOM_BANQ" )
			sAdr1_B		= idw_Adh.GetItemString ( 1, "DOMIC_ADR_35_1" )
			sAdr2_B		= F_GetString ( idw_Adh, 1, "DOMIC_ADR_35_2" )
			sAdrCp_B		= idw_Adh.GetItemString ( 1, "DOMIC_CPOSTAL" )
			sAdrVille_B	= idw_ADh.GetItemString ( 1, "DOMIC_VILLE" )

		End Choose
	End If
Else
	sAltCreBqDms = "N"
End If

/*----------------------------------------------------------------------------*/
/* AJOUT JFF LE 11/05/01 : sDosMajPar indique qui doit traiter le dossier.    */
/*----------------------------------------------------------------------------*/
If idw_DosSuiviPar.RowCount ( ) > 0 Then
	sDosMajPar = idw_DosSuiviPar.GetItemString ( 1, "DOS_SUIVI_PAR" )
	If IsNull ( sDosMajPar ) Or Trim ( sDosMajPar ) = "" Then sDosMajPar = "CREE"
Else
	sDosMajPar = "CREE"
End If

/*------------------------------------------------------------------*/
/* Modif DGA.                                                       */
/* Gestion de la t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonie.                                        */
/*------------------------------------------------------------------*/
sNumPort				= F_GetString ( idw_wTravail, 1, "NUM_PORT" )
sNumImeiPort		= F_GetString ( idw_wTravail, 1, "NUM_IMEI_PORT" )
sMarqPort			= F_GetString ( idw_wTravail, 1, "MARQ_PORT" )
sModlPort			= F_GetString ( idw_wTravail, 1, "MODL_PORT" )
// [PI056]
/*
dtDteAchPort		= DateTime ( idw_wTravail.GetItemDate ( 1, "DTE_ACH_PORT" ) )
dtDteOuvLigPort	= DateTime ( idw_wTravail.GetItemDate ( 1, "DTE_OUVLIG_PORT" ) )
*/
dtDteAchPort		= idw_wTravail.GetItemDateTime ( 1, "DTE_ACH_PORT" ) 
dtDteOuvLigPort	= idw_wTravail.GetItemDateTime ( 1, "DTE_OUVLIG_PORT" ) 
// :[PI056]

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* Armement des valeurs par d$$HEX1$$e900$$ENDHEX$$faut. Cette gestion doit $$HEX1$$ea00$$ENDHEX$$tre         */
/* r$$HEX1$$e900$$ENDHEX$$alis$$HEX1$$e900$$ENDHEX$$e en ActiveLinc Via SHERPA.                               */
/*------------------------------------------------------------------*/
sIdContratAbonne	= F_GetString ( idw_wTravail, 1, "ID_CONTRAT_ABONNE" )
lIdHlr				= idw_wTravail.GetItemNumber ( 1, "ID_HLR" )
lIdOrianMarque		= idw_wTravail.GetItemNumber ( 1, "ID_ORIAN_MARQUE" )
lIdOrianModele		= idw_wTravail.GetItemNumber ( 1, "ID_ORIAN_MODELE" )
lIdOrianBoutique	= idw_wTravail.GetItemNumber ( 1, "ID_ORIAN_BOUTIQUE" )
/*------------------------------------------------------------------*/
/* Le 25/05/1999.                                                   */
/* Modif DGA: On v$$HEX1$$e900$$ENDHEX$$rifie si l'on peut ecrire dans le r$$HEX1$$e900$$ENDHEX$$pertoire de  */
/* TRACE. Si ce n'est pas le cas, on arrete tout.                   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Par d$$HEX1$$e900$$ENDHEX$$faut, on ne teste l'$$HEX1$$e900$$ENDHEX$$criture que pour la trace du          */
/* WorkFlow. La trace pour la modification des adresses est moins   */
/* importante.                                                      */
/*------------------------------------------------------------------*/
If	F_Verifier_Ecriture_Trace ( isFicEssaiTrc ) < 0	Then

/*------------------------------------------------------------------*/
/* On affiche un message d'erreur que l'on ne peut tracer. On sort  */
/* ensuite imm$$HEX1$$e900$$ENDHEX$$diatement de la fonction.                            */
/*------------------------------------------------------------------*/
	stMessage.sTitre		= "Cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
	stMessage.Icon			= StopSign!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "APPLI09"
   stMessage.bTrace  	= False

	F_Message ( stMessage )
	bRet = False

Else

	itrTrans.PS_VAL_W_QUEUE		 (	sCodTypeRecu,		&
											sCodRecu,			&
											dtDteCourCli,		&
											dtDteRecu,			&
											dcIdSin,				&
											dcIdI,				&
											sCodIProv,			&
											dcIdProd,			&
											dcIdEts,				&
											sIdAdh,				&
											dcIdsDos,			&
											dcOption,			&
											dtDteAdh,			&
											dtDteFinGti,		&
											dtDteResil,			&
											dcIdCorb,			&
											dtDteDecl,			&
											dtDteSurv,			&
											sCodCiv,				&
											sNom,					&
											sPrenom,				&
											sAdr1,				&
											sAdr2,				&
											sAdrCp,				&
											sAdrVille,			&
											sNumTelD,			&
											sNumTelB,			&
											sNumFax,				&
											sTxtMess1,			&
											dtCreeLe,			&
											dtMajLe,				&
											sCodOper,			&
											sCodTravail,		&
											sAltQueue, 			&
											dtDteSous, 			&
											dtDteOpt, 			&
											dcIdCarte, 			&
											sIdTypeCarte, 		&
											dcIdOrdre, 			&
											sCodProvPers, 		&
											sCodModeRegA, 		&
											sRibBq,		 		&
											sRibGui,		 		&
											sRibCpt,		 		&
											sRibCle,		 		&
											sAltCreBqDms,		&
											sCodBq_B,			&
											sCodAg_B,		 	&
											sNom_B,		 		&
											sAdr1_B,		 		&
											sAdr2_B,		 		&
											sAdrCp_B,		 	&
											sAdrVille_B,		&
											sCodModeRegB, 		&
											sNumTelD_B,			&
											sDosMajPar,			&
											sNumPort,			&
											sNumImeiPort,		&
											sMarqPort,			&
											sModlPort,			&
											dtDteAchPort,		&
											dtDteOuvLigPort,	&
											sIdContratAbonne,	&
											lIdHlr,				&
											lIdOrianMarque,	&
											lIdOrianModele,	&
											lIdOrianBoutique,	&
											sProc,				&
											sNvIdSin )


/*------------------------------------------------------------------*/
/* La zone sProc est pass$$HEX1$$e900$$ENDHEX$$e par r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence. Elle est arm$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$''      */
/* dans la proc$$HEX1$$e900$$ENDHEX$$dure. Si une erreur survient, on arme cette cha$$HEX1$$ee00$$ENDHEX$$ne  */
/* pour expliquer ou est survenue l'erreur.                         */
/*------------------------------------------------------------------*/
	sProc = Trim ( sProc )
	If	sProc <> "" Then bRet = False

/*------------------------------------------------------------------*/
/* Si SqlDbCode est arm$$HEX1$$e900$$ENDHEX$$, on part du principe qu'il y a eu une      */
/* erreur, et ce quel que soit la valeur de sProc.                  */
/*------------------------------------------------------------------*/
	If itrTrans.SqlCode <> 0	Then bRet = False


/*----------------------------------------------------------------------------*/
/* AJOUT JFF LE 11/05/01 : Insertion d'un contact .                           */
/*----------------------------------------------------------------------------*/
	If bRet and ibAltcontact Then
		sSql	=	"EXECUTE sysadm.DW_I01_CONTACT " 

		// En d$$HEX1$$e900$$ENDHEX$$claration
		If sCodTypeRecu = "D" Then
			sIdSinContact = sNvIdSin	

			sSql += sIdSinContact + "," 		// Sin
			sSql += "0" + "," 					// Msg_seq
			sSql += "'D'" + "," 					// Type_Msg

		// En compl$$HEX1$$e900$$ENDHEX$$ment
		Else 
			sIdSinContact = String( Long ( String ( dcIdSin ) ) ) 

			sSql += sIdSinContact + ","  		// Sin

			lMaxSeq = 0 
			itrTrans.PS_S01_CONTACT ( Long ( sIdSinContact ), lMaxSeq )
			sSql += String ( lMaxSeq + 1 ) + ","	// Msg_Seq
			
			//========= Ici une variable seule telle que dans le source d'origine
			//========= d$$HEX1$$e900$$ENDHEX$$clenche un "Invalid statement" pour PB 8
			//lNbrPI
			//=========
			
			itrTrans.PS_S02_CONTACT ( Long ( sIdSinContact ), 'PI', lNbrPI )			
			If sCodRecu = "T" Then 
				sSql += "'C'" + "," 	// Type_Msg
			ElseIf lNbrPI > 0 Then
				sSql += "'CP'" + "," 	// Type_Msg
			Else
				sSql += "'CS'" + "," 	// Type_Msg
			End If

		End If

		sSql += "0" + "," 						// Nat_Msg
		sSql += "'" + sCodRecu + "'" + "," 	// Canal
		sSql += "'" + sCodIProv + "'" + "," // Provenance
		sSql += "null" + "," 					// Text 1
		sSql += "null" + "," 					// Text 2
		sSql += "'O'" + "," 						// altValide

		dtNow = DateTime ( Today (), Now () )
		sSql += "'" + String ( dtNow, "dd/mm/yyyy hh:mm:ss" ) + "'" + "," // Cree_le
		sSql += "'" + String ( dtNow, "dd/mm/yyyy hh:mm:ss" )	+ "'" + "," // Maj_le
		sSql += "'" + stGlb.sCodOper + "'"										   // CodOper

		bRet = F_Execute ( sSql, itrTrans )

	End If


/*------------------------------------------------------------------*/
/* On s'occupe maintenant du COMMIT, ou du ROLLBACK.                */
/*------------------------------------------------------------------*/
	If	bRet	Then
		F_Commit ( itrTrans, True )

/*------------------------------------------------------------------*/
/* Dans le cas d'une d$$HEX1$$e900$$ENDHEX$$claration, on positionne le nouveau N$$HEX2$$b0002000$$ENDHEX$$de    */
/* sinistre dans ID_SIN. Cette valeur sera r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e sur            */
/* l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement Ue_MajAccueil de la fen$$HEX1$$ea00$$ENDHEX$$tre pour mettre $$HEX2$$e0002000$$ENDHEX$$jour la    */
/* DW d'accueil.                                                    */
/*------------------------------------------------------------------*/
		If	sCodTypeRecu = "D" Then
			idw_wTravail.SetItem ( 1, "ID_SIN", Long ( sNvIdSin ) )
		End If

/*------------------------------------------------------------------*/
/* On initialise les zones de la DW pour avoir les m$$HEX1$$ea00$$ENDHEX$$mes valeurs    */
/* dans la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil et dans la table.                      */
/* De plus, ces valeurs vont pouvoir permettre de d$$HEX1$$e900$$ENDHEX$$terminer le     */
/* temps de saisie d'une cr$$HEX1$$e900$$ENDHEX$$ation. Et cela grace $$HEX2$$e0002000$$ENDHEX$$la TRACE.        */
/*------------------------------------------------------------------*/
		idw_wTravail.SetItem ( 1, "CREE_LE", dtCreeLe )
		idw_wTravail.SetItem ( 1, "MAJ_LE", dtMajLe )

/*------------------------------------------------------------------*/
/* Ecriture de la fameuse TRACE.                                    */
/*------------------------------------------------------------------*/
		Uf_EcrireTrace ()
		Uf_EcrireTrace_Adresse ()
	Else
/*------------------------------------------------------------------*/
/* On charge les valeurs de la structure Message avec les valeurs   */
/* de itrTrans, avant de faire un ROLLBACK.                         */
/*------------------------------------------------------------------*/

		stMessage.sTitre		= "Cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
		stMessage.Icon			= StopSign!
		stMessage.bErreurG	= False
		stMessage.sVar[1] 	= sProc
		stMessage.sVar[2] 	= String ( itrTrans.SqlDbCode )
		stMessage.sVar[3] 	= itrTrans.SqlErrText
		stMessage.sCode		= "WORK220"
	   stMessage.bTrace  	= True

/*------------------------------------------------------------------*/
/* On peut envoyer le ROLLBACK.                                     */
/*------------------------------------------------------------------*/
		F_Commit ( itrTrans, False )
/*------------------------------------------------------------------*/
/* On peut afficher le message sans risques.                        */
/*------------------------------------------------------------------*/
		F_Message ( stMessage )
	End If
End If

astPass.bRetour = bRet

end subroutine

public function long uf_zn_trt (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Cree_Travail::Uf_Zn_Trt (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:27:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Traitement sur les zones de dw_wTravail. (On vient de ItemChanged)
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
//ll_ret r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re les valeurs de retour de chaque fonction
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

ibWorkFlow_En_Consult = astPass.sTab [2] = "WORKFLOW_EN_CONSULT"

Choose Case idw_wTravail.isNomCol
Case "COD_TYP_RECU"
	ll_ret = Uf_Zn_CodTypRecu ()

Case "COD_RECU"
	ll_ret = Uf_Zn_CodRecu ()

Case "DTE_COUR_CLI"
	ll_ret = Uf_Zn_DteCourCli ()

Case "DTE_RECU"
	ll_ret = Uf_Zn_DteRecu ()

Case "ID_SIN"
	ll_ret = Uf_Zn_IdSin ()

Case "ID_I"
	Uf_Zn_IdI ()

Case "ID_PROD"
	Uf_Zn_IdProd ()

Case "ID_ETS"
	Uf_Zn_IdEts ()

Case "ID_ADH"
/*------------------------------------------------------------------*/
/* On se sert de lTab[1] pour savoir combien il existe de           */
/* sinistres li$$HEX1$$e900$$ENDHEX$$s. Cette valeur est utilis$$HEX1$$e900$$ENDHEX$$e sur la DW de la        */
/* fen$$HEX1$$ea00$$ENDHEX$$tre W_T_Sp_Cree_Travail.                                     */
/*------------------------------------------------------------------*/
	astPass.lTab[1] = 0
	ll_ret = Uf_Zn_IdAdh ( astPass )

Case "ID_SDOS"
/*------------------------------------------------------------------*/
/* On se sert de lTab[1] pour savoir combien il existe de           */
/* sinistres li$$HEX1$$e900$$ENDHEX$$s. Cette valeur est utilis$$HEX1$$e900$$ENDHEX$$e sur la DW de la        */
/* fen$$HEX1$$ea00$$ENDHEX$$tre W_T_Sp_Cree_Travail.                                     */
/*------------------------------------------------------------------*/
	astPass.lTab[1] = 0
	ll_ret = Uf_Zn_IdsDos ( astPass )

Case "DTE_SURV"
	ll_ret = Uf_Zn_DteSurv ()

Case "NOM", "PRENOM"
	If	Not ibSinLie Then
		idw_wTravail.SetItem ( 1, "COD_PROV_PERS", "W" )
		idw_wTravail.SetItem ( 1, "ID_ORDRE", stNul.dcm )
	End If

Case "ALT_ADR"
	ll_ret = Uf_Zn_AltAdr ()


End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

on destructor;call u_gs_sp_cree_wkf_anc::destructor;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Gs_Sp_Cree_Wkf::Destuctor
//* Evenement 		: Destructor
//* Auteur			: Erick John Stark
//* Date				: 24/07/1998 15:04:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On supprime l'objet de transaction EDMS s'il existe
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If IsValid ( itrEdms )	Then
	Destroy itrEdms
End If
end on

on u_gs_sp_cree_wkf.create
call super::create
end on

on u_gs_sp_cree_wkf.destroy
call super::destroy
end on

