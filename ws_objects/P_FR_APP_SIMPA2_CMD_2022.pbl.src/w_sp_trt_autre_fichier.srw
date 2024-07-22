HA$PBExportHeader$w_sp_trt_autre_fichier.srw
$PBExportComments$Int$$HEX1$$e900$$ENDHEX$$gration de fichiers CODIC DARTY [DCMP80862]
forward
global type w_sp_trt_autre_fichier from w_8_accueil
end type
type cb_charger from commandbutton within w_sp_trt_autre_fichier
end type
type cb_annuler from commandbutton within w_sp_trt_autre_fichier
end type
type st_charger from statictext within w_sp_trt_autre_fichier
end type
type st_extraire from statictext within w_sp_trt_autre_fichier
end type
type cb_controler from commandbutton within w_sp_trt_autre_fichier
end type
type dw_fourn from datawindow within w_sp_trt_autre_fichier
end type
type cb_maj from commandbutton within w_sp_trt_autre_fichier
end type
type dw_charger from datawindow within w_sp_trt_autre_fichier
end type
type hpb_trt from hprogressbar within w_sp_trt_autre_fichier
end type
type st_1 from statictext within w_sp_trt_autre_fichier
end type
type st_avertissement_monnaie from u_st_avertissement_monnaie within w_sp_trt_autre_fichier
end type
type lb_filelist from listbox within w_sp_trt_autre_fichier
end type
type cb_result from commandbutton within w_sp_trt_autre_fichier
end type
type cb_taillefen from commandbutton within w_sp_trt_autre_fichier
end type
type st_pct from statictext within w_sp_trt_autre_fichier
end type
end forward

global type w_sp_trt_autre_fichier from w_8_accueil
integer width = 3707
integer height = 1952
boolean minbox = true
long backcolor = 67108864
cb_charger cb_charger
cb_annuler cb_annuler
st_charger st_charger
st_extraire st_extraire
cb_controler cb_controler
dw_fourn dw_fourn
cb_maj cb_maj
dw_charger dw_charger
hpb_trt hpb_trt
st_1 st_1
st_avertissement_monnaie st_avertissement_monnaie
lb_filelist lb_filelist
cb_result cb_result
cb_taillefen cb_taillefen
st_pct st_pct
end type
global w_sp_trt_autre_fichier w_sp_trt_autre_fichier

type variables
Private :

String	K_FICCHARG_CODIC_DARTY = "FIC_CODIC.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$e CODIC DARTY
integer	K_TYPTRT_CODIC_DARTY	= 1

// FPI - 15/01/2009
String	K_FICCHARG_TAC_IMEI = "TAC_IMEI.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$e TAC IMEI
integer	K_TYPTRT_TAC_IMEI	= 2

// FPI - 30/06/2009 - [DCMP090310]
String	K_FICCHARG_CT_INFO = "CT_INFO.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$es Contacts info.
integer	K_TYPTRT_CT_INFO	= 3

integer K_TYPTRT_CAMARA = 4

// FPI - 05/11/2009 - [EXPANSION5.BOUTIQUES]
String	K_FICCHARG_BTQ = "EXP5_BOUTIQUE.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$es Boutiques Expansion5
integer	K_TYPTRT_BTQ	= 5

// FPI - 19/02/2010 - [DCMP100102]
Integer K_TYPTRT_LST_SIN =6
String K_FICCHARG_LST_SIN ="LST_SIN.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$es de liste des sinistres

// FPI - 30/11/2010 - [PC475]
Integer K_TYPTRT_BTQ_MCM =7
String isNomFicBtq

// FPI - 14/02/2012 - [PM200][PSM]
Integer K_TYPTRT_BTQ_PSM =8

// FPI - 18/09/2012 - [VDoc8686]
Integer K_TYPTRT_CT_CLIENT =9
String	K_FICCHARG_CT_CLIENT = "CT_CLIENT.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$es Contacts clients

// JFF - 21/12/2012 - [VDoc9663]
Integer K_TYPTRT_VDOC9663 =10
String	K_FICCHARG_VDOC9663 = "FIC_INTEGR_VDOC9663.TXT" 

// FPI - 17/052013 - [PC938]
Integer K_TYPTRT_IMEI_ORANGE =11
String isNomFicImei

// FPI - 14/01/2014 - [VDoc13194]
Integer K_TYPTRT_LST_CMDE_O2M =12
String K_FICCHARG_LST_CMDE_O2M ="LST_CMDE_PREST.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$es de liste des commandes

Integer K_TYPTRT_LST_CMDE_CDS =13
String K_FICCHARG_LST_CMDE_CDS ="LST_CMDE_CDS.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$es de liste des commandes CDS

// FPI - 21/01/2014 - [VDoc13415]
Integer K_TYPTRT_LST_CMDE_CFM =14
String K_FICCHARG_LST_CMDE_CFM ="LST_CMDE_CFM.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$es de liste des commandes Confo

// JFF - 21/01/2014 - [VDOC12917]
Integer K_RM_AVOIR_FOURN =15
String K_FICCHARG_RM_AVOIR_FOURN ="RM_AVOIR_FOURN.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$es de liste des commandes

// FPI - 19/09/2016	- [VDOC19525]
Integer K_TYPTRT_LST_SIN_CASTO =16

// FPI - 22/09/2016	- [VDOC21846]
Integer K_TYPTRT_LST_SIN_REG =17
String K_FICCHARG_LST_SIN_REG ="LST_SIN_REG.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$es de liste des dossiers & r$$HEX1$$e800$$ENDHEX$$glements

// FPI - 04/11/2016	- [VDOC22119]
Integer K_TYPTRT_LST_RM =18

// JFF   30/11/2016 [PM375-1]
Integer K_RP_AVOIR_FOURN =19
String K_FICCHARG_RP_AVOIR_FOURN ="RP_AVOIR_FOURN.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$es de liste des commandes
Integer K_RM_SIMPLE = 20
String K_FICCHARG_RM_SIMPLE ="RM_SIMPLE.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$es de liste des commandes
Integer K_RP_SIMPLE = 21
String K_FICCHARG_RP_SIMPLE ="RP_SIMPLE.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$es de liste des commandes
Integer K_RN_FRAIS_FACTU = 22
String K_FICCHARG_RN_FRAIS_FACTU ="RN_FRAIS_FACTU.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$es de liste des commandes

// FPI - [VDOC23002] - 13/02/2017
Integer K_TYPTRT_LST_REG = 23

// FPI - [VDOC23962] - 07/07/2017
Integer K_TYPTRT_LST_CMDE =24
String K_FICCHARG_LST_CMDE ="LST_CMDE.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$es de liste des commandes

// FPI - [VDOC24986] - 26/12/2017
Integer K_TYPTRT_LST_FACTU_CASTO =25

// FPI - 21/02/2018 - [VDoc25758]
Integer K_TYPTRT_LST_CMDE_AUC =26
String K_FICCHARG_LST_CMDE_AUC ="LST_CMDE_AUC.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$es de liste des commandes Auchan

// JFF - 27/05/2019 - [PM478-1]
Integer K_TYPTRT_RET_PM02 =27
String  K_FICCHARG_RET_PM02 ="RETOUR_PM02_O2M_SPB.TXT"

// FPI - [VDOC28472] - 07/10/2019
Integer K_TYPTRT_LST_FACT =28
String K_FICCHARG_LST_FACT ="LST_FACT.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$es de liste des commandes

// JFF 02/01/2023 [RS_4166_PND_CORUS]
Integer K_TYPTRT_LST_PND_CORUS =29
String K_FICCHARG_LST_PND_CORUS ="PND_CORUS.TXT" 


datastore ids_charger

// PC175
String		K_FIC_SORTIE_OPCON = "ERRSP2.DAT"
String		K_FICFINTRT = "FIN_TRT"
String  		isRepFicOpCon	

String K_FICLOG = "LOGCMD\FIC_AUTRE.LOG"

String   isCasTailleFen

end variables

forward prototypes
private function boolean wf_chargerdonnees ()
private function boolean wf_controler ()
private function boolean wf_maj ()
private function integer wf_chargerdw ()
private function boolean wf_controler_tac_imei (ref string asvaleurs[], ref string aserreur)
public function long wf_epure_tac_imei ()
public subroutine wf_trim_champs ()
private function boolean wf_controler_ct_info (ref string asvaleurs[], ref string aserreur)
public function boolean wf_init_camara (ref long alidlotextr, ref string asnomfichier)
protected function boolean wf_controler_boutiques (ref string asval[], ref string aserreur)
private function boolean wf_controler_codic (ref string asvaleurs[], ref string aserreur)
protected function boolean wf_controler_lst_sin (ref string asval[], ref string aserreur)
protected subroutine wf_trt_lst_sin ()
private function string wf_determiner_fic_btq (integer aitypfic)
private function long wf_charger_ficbtq (string asnomfic)
private function boolean wf_ctrl_btq (string slignebtq)
private function boolean wf_trt_btq_mcm ()
private subroutine wf_opcon_btq_mcm ()
private subroutine wf_delete_btq_mcm ()
private function integer wf_sortie_opcon (string ascas, integer aicodeerreur, string astexte, boolean abbox)
private function long wf_charger_ficbtq_psm (string asnomfic)
private function boolean wf_ctrl_btq_psm (ref string slignebtq)
protected subroutine wf_decoupe_adr (string asadresse, ref string asadr1, ref string asadr2, string asseparator)
private function boolean wf_trt_btq_psm ()
private subroutine wf_rename_file (boolean abok, integer aityptrt)
private subroutine wf_opcon_btq_psm ()
private function boolean wf_controler_ct_client (ref string asvaleurs[], ref string aserreur)
protected subroutine wf_trt_extr_vdoc9663 ()
protected function boolean wf_controler_ (ref string asval[], ref string aserreur)
private subroutine wf_opcon_imei_orange ()
private function string wf_determiner_fic_imei ()
public function boolean wf_trt_imei_orange ()
private subroutine wf_opcon_boutique (string asidfour)
public function integer wf_trace (string ascas, string astexte)
protected function boolean wf_controler_format_cmde (ref string asval[], ref string aserreur)
protected subroutine wf_trt_lst_cmd (integer aitrt)
private function boolean wf_controler_chps_oblig (ref string ascolnames[], ref string asvaleurs[], ref string aserreur)
public function boolean wf_trt_rm_avoir_fourn ()
protected function string wf_abbr (string asadresse, string asvaleur, string asabbrev)
public subroutine wf_trt_lstsinreg ()
protected function boolean wf_controler_lstsinreg (ref string asval[], ref string aserreur)
public function boolean wf_trt_rp_avoir_fourn ()
public function boolean wf_trt_rm_simple ()
public function boolean wf_trt_rp_simple ()
public function boolean wf_trt_rn_frais_factu ()
protected subroutine wf_trt_lst_reg (integer aitrt)
public function boolean wf_trt_retour_pm02 ()
protected function boolean wf_controler_vdoc28472 (ref long alcpt, ref string aserreur)
public function boolean wf_trt_lstfact ()
public subroutine wf_positionnerobjets ()
public function boolean wf_trt_pnd_corus ()
public function boolean wf_controler_pnd_corus (long alcpt, ref string aserreur)
public function boolean wf_controler_retour_pm02 (long alcpt, ref string aserreur)
private subroutine wf_pct ()
public function boolean wf_controler_rm_avoir_fourn (long alcpt, ref string aserreur)
public function boolean wf_controler_rp_avoir_fourn (long alcpt, ref string aserreur)
public function boolean wf_controler_rp_simple (long alcpt, ref string aserreur)
public function boolean wf_controler_rm_simple (long alcpt, ref string aserreur)
public function boolean wf_controler_rn_frais_factu (long alcpt, ref string aserreur)
end prototypes

private function boolean wf_chargerdonnees ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_autofact::wf_ChargerDonnees (PRIVATE)
//* Auteur        : FPI
//* Date          : 12/12/2008
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Chargement des donn$$HEX1$$e900$$ENDHEX$$es
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1		FPI	15/01/2009	Int$$HEX1$$e900$$ENDHEX$$gration des fichiers TAC_IMEI
//* #2		FPI	14/04/2009	Trim des champs marque & modele
//* #3	FPI		30/06/2009	[DCP090310] Int$$HEX1$$e900$$ENDHEX$$gration contacts d'info
//* #4	FPI		03/08/2009	[CAMARA]
//* #5	FPI		05/11/2009	[EXPANSION5.BOUTIQUES]
//* #6	FPI		19/02/2010	[DCMP100102]
//			FPI		12/02/2012 [PM200][PSM] Int$$HEX1$$e900$$ENDHEX$$gration fichier btq PSM
// 			FPI		18/09/2012  [VDoc8686]
// 			JFF		21/12/2012  [VDoc9663]
//			FPI		17/05/2013	[PC938]
// 			FPI		14/01/2014	[VDoc13194]
//			FPI		21/01/2014	[VDoc13415]
//			JFF		27/01/2014	[VDOC12917]
// 			FPI		19/09/2016	[VDOC19525]
// 			FPI		22/09/2016	[VDOC21846]
//			FPI		04/11/2016	[VDOC22119]
//       JFF   30/11/2016 [PM375-1]
//			FPI		13/02/2017	 [VDOC23002]
// 			FPI		26/12/2017	[VDOC24986]
//			FPI		21/02/2018	 [VDoc25758]
//       JFF   27/05/2019 [PM478-1]
//			FPI		07/10/2019	[VDOC28472]
//       JFF   02/01/2023 [RS_4166_PND_CORUS]
//*-----------------------------------------------------------------

Boolean bOk, bTrimChamps
Long	lTotRow
String sFicFourn
long	lIdTt

stMessage.sTitre  	= "Controle de saisie"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!

bOk = True
bTrimChamps = TRUE // #5

lIdTt = dw_fourn.getItemNumber(1,"id_tt")

Choose Case  lIdTt
	Case K_TYPTRT_CODIC_DARTY
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_CODIC_DARTY
	// #1
	Case K_TYPTRT_TAC_IMEI
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_TAC_IMEI
	// #3
	Case K_TYPTRT_CT_INFO
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_CT_INFO
		bTrimChamps=FALSE // #5
	// #5
	Case K_TYPTRT_BTQ
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_BTQ
		bTrimChamps=FALSE
	// #6
	Case K_TYPTRT_LST_SIN, K_TYPTRT_LST_SIN_CASTO, K_TYPTRT_LST_RM, K_TYPTRT_LST_REG, K_TYPTRT_LST_FACTU_CASTO // [VDOC19525] // [VDOC22119] [VDOC23002]
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_LST_SIN
		bTrimChamps=FALSE		
	// [PC175]
	Case K_TYPTRT_BTQ_MCM
		sFicFourn = wf_determiner_fic_btq( 1)
		isNomficbtq = sficfourn
		bTrimChamps=FALSE		
	//  [PM200][PSM] 
	Case K_TYPTRT_BTQ_PSM 
		sFicFourn = wf_determiner_fic_btq( 2)
		isNomficbtq = sficfourn
		bTrimChamps=FALSE		
	// [VDoc8686]
	Case K_TYPTRT_CT_CLIENT
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_CT_CLIENT
		bTrimChamps=FALSE 
	// [VDoc9663]
	Case K_TYPTRT_VDOC9663
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_VDOC9663
		bTrimChamps=FALSE 		
	// [PC938]
	Case K_TYPTRT_IMEI_ORANGE
		sFicFourn = wf_determiner_fic_imei() 
		isnomficimei = sficfourn
		bTrimChamps=FALSE 		
	// [VDoc13194]
	Case K_TYPTRT_LST_CMDE_O2M
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_LST_CMDE_O2M
		bTrimChamps=FALSE 	
	Case K_TYPTRT_LST_CMDE_CDS
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_LST_CMDE_CDS
		bTrimChamps=FALSE 	
	// [VDoc13415]
	Case K_TYPTRT_LST_CMDE_CFM
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_LST_CMDE_CFM
		bTrimChamps=FALSE
	// [VDOC12917]
	Case K_RM_AVOIR_FOURN
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_RM_AVOIR_FOURN
		bTrimChamps=FALSE
	// [VDOC21846]
	Case K_TYPTRT_LST_SIN_REG
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_LST_SIN_REG
		bTrimChamps=FALSE
	// [PM375-1]
	Case K_RP_AVOIR_FOURN
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_RP_AVOIR_FOURN
		bTrimChamps=FALSE
	// [PM375-1]
	Case K_RM_SIMPLE
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_RM_SIMPLE
		bTrimChamps=FALSE
	// [PM375-1]
	Case K_RP_SIMPLE
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_RP_SIMPLE
		bTrimChamps=FALSE
	// [PM375-1]
	Case K_RN_FRAIS_FACTU
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_RN_FRAIS_FACTU
		bTrimChamps=FALSE
	// [VDoc23962]
	Case K_TYPTRT_LST_CMDE
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_LST_CMDE
		bTrimChamps=FALSE 	
	// [VDoc25758]
	Case K_TYPTRT_LST_CMDE_AUC
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_LST_CMDE_AUC
		bTrimChamps=FALSE

	// [PM478-1]
	Case K_TYPTRT_RET_PM02
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_RET_PM02
		bTrimChamps=FALSE

	// [VDOC28472]
	Case K_TYPTRT_LST_FACT
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_LST_FACT
		bTrimChamps=FALSE
		
	// [RS_4166_PND_CORUS]
	Case K_TYPTRT_LST_PND_CORUS
		sFicFourn = stGlb.sRepTempo + K_FICCHARG_LST_PND_CORUS
		bTrimChamps=FALSE
		
End Choose

st_1.visible = false
wf_chargerdw ()

// #4
If lIdTt = K_TYPTRT_CAMARA Then
	dw_charger.SetTransObject(SQLCA)
	lTotRow = dw_charger.Retrieve( )

	if lTotRow < 0 Then 
		Return FALSE
	End If
	
	Return TRUE	
End if
// Fin #4

// [PC938]
If lIdTt = K_TYPTRT_IMEI_ORANGE Then dw_charger.SetTransObject(SQLCA)

/*------------------------------------------------------------------*/
/* Chemin ou Fichier Excel introuvable.                             */
/*------------------------------------------------------------------*/

If Not f_FileExists ( sFicFourn ) Then
	stMessage.sCode = "COMD036" 
	stMessage.sVar [1] = sFicFourn
	bOk = False
	dw_Charger.dataobject = ''
End If

/*------------------------------------------------------------------*/
/* Chargement des donn$$HEX1$$e900$$ENDHEX$$es.                                          */
/*------------------------------------------------------------------*/
If bOk Then
	Choose Case lIdTT
		Case K_TYPTRT_BTQ_MCM // [PC175]
			lTotRow=wf_charger_ficbtq (sFicFourn )
		Case	 K_TYPTRT_BTQ_PSM   //  [PM200][PSM] 
			lTotRow=wf_charger_ficbtq_PSM (sFicFourn )
		Case Else
			lTotRow = dw_Charger.ImportFile ( sFicFourn )
			
	end Choose
	
	If lTotRow < 0 Then
		stMessage.sCode = "COMD037"
		stMessage.sVar [1] = String ( lTotRow )
		bOk = False
	End If
	
End If

// #1
if lIdTt=K_typtrt_tac_imei Then lTotRow = wf_epure_tac_imei()

// #2 
//If lIdTt<> k_typtrt_ct_info Then wf_trim_champs() // #3 Ajout du if
if bTrimChamps and bOk Then wf_trim_champs( ) // #5 - Simplification // [PC175]

/*------------------------------------------------------------------*/
/* MAJ du static text                                               */
/*------------------------------------------------------------------*/
If bOk Then
	Choose case lIdTT
		Case  K_RM_AVOIR_FOURN // [VDOC12917]
			st_Charger.Text = String ( lTotRow ) + " RM Avoirs fournisseurs charg$$HEX1$$e900$$ENDHEX$$s"
		Case  K_TYPTRT_BTQ , K_TYPTRT_BTQ_MCM // [PC175]
			st_Charger.Text = String ( lTotRow ) + " r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences boutiques charg$$HEX1$$e900$$ENDHEX$$es"
		Case  K_TYPTRT_LST_SIN , K_TYPTRT_VDOC9663, K_TYPTRT_LST_SIN_CASTO, K_TYPTRT_LST_SIN_REG,K_TYPTRT_LST_RM, K_TYPTRT_LST_REG, K_TYPTRT_LST_FACTU_CASTO
			st_Charger.Text = String ( lTotRow ) + " r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences sinistres charg$$HEX1$$e900$$ENDHEX$$es"
		Case  K_TYPTRT_CT_CLIENT 
			st_Charger.Text = String ( lTotRow ) + " r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences clients charg$$HEX1$$e900$$ENDHEX$$es"
		Case  K_TYPTRT_IMEI_ORANGE 
			st_Charger.Text = String ( lTotRow ) + " IMEI Orange charg$$HEX1$$e900$$ENDHEX$$es"
		// [PM375-1]
		Case K_RP_AVOIR_FOURN
			st_Charger.Text = String ( lTotRow ) + " RP Avoirs fournisseurs charg$$HEX1$$e900$$ENDHEX$$s"		
		// [PM375-1]
		Case K_RM_SIMPLE
			st_Charger.Text = String ( lTotRow ) + " RM simples charg$$HEX1$$e900$$ENDHEX$$s"		
		// [PM375-1]
		Case K_RP_SIMPLE
			st_Charger.Text = String ( lTotRow ) + " RP simples charg$$HEX1$$e900$$ENDHEX$$s"		
		// [PM375-1]
		Case K_RN_FRAIS_FACTU
			st_Charger.Text = String ( lTotRow ) + " RN frais factu charg$$HEX1$$e900$$ENDHEX$$s"					
		// [PM478-1]
		Case K_RN_FRAIS_FACTU
			st_Charger.Text = String ( lTotRow ) + " Retours PM02 charg$$HEX1$$e900$$ENDHEX$$s"					
		// [RS_4166_PND_CORUS]
		Case K_TYPTRT_LST_PND_CORUS			
			st_Charger.Text = String ( lTotRow ) + " Retours PND CORUS charg$$HEX1$$e900$$ENDHEX$$s"					
		Case Else
			st_Charger.Text = String ( lTotRow ) + " r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences commandes charg$$HEX1$$e900$$ENDHEX$$es"
			
	End choose
	// Fin #6
End If


If (Not bOk) and (not gbOpcon) Then F_Message ( stMessage ) // [PC175] ajout controle Opcon

Return bOk



end function

private function boolean wf_controler ();
//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_autofact::wf_Controler (PRIVATE)
//* Auteur        : FPI
//* Date          : 12/12/2008
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le des donn$$HEX1$$e900$$ENDHEX$$es
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     	Modification
//* #1		FPI	15/01/2009	Int$$HEX1$$e900$$ENDHEX$$gration des fichiers TAC_IMEI
//* #2		FPI	15/01/2009	Correction bug sur les codics darty
//* #3		FPI	30/06/2009	[DCMP090310] Int$$HEX1$$e900$$ENDHEX$$gration contacts d'info
//* #4		FPI	30/06/2009	[EXPANSION5.BOUTIQUES] Int$$HEX1$$e900$$ENDHEX$$gration boutiques Expansion5
//* #5		FPI	19/02/2010	[DCMP100102] Extraction dte_surv, dte_achat 
// 			FPI	18/09/2012	[VDOC8686]
// 			JFF	21/12/2012  [VDoc9663]
//			FPI		17/05/2013	[PC938]
// 			FPI		14/01/2014	[VDoc13194]
//			FPI		21/01/2014	[VDOC13415]
//			JFF		27/01/2014	[VDOC12917]
// 			FPI		19/09/2016	[VDOC19525]
// 			FPI		22/09/2016	[VDOC21846]
//			FPI		04/11/2016 [VDOC22119]
//       JFF   30/11/2016 [PM375-1]
//			FPI		13/02/2017	 [VDOC23002]
// 			FPI		26/12/2017	[VDOC24986]
//			FPI		21/02/2018	[VDoc25758]
//       JFF   27/05/2019 [PM478-1]
//*-----------------------------------------------------------------

Long		lTotRow, lCpt, lPos, lTotLig
Boolean	bOk, bError
String	sErreur, sValPrec, sVal2
Integer iIdTt
String sVal[]
String sColNames[]
String sColOblig[]	//#3
String sAdr1, sAdr2	//  #4


n_cst_string uString

bOk = True
sErreur = ''

dw_Charger.AcceptText()			// #3 - Correction
ids_charger.Reset()				// #3 - Correction


iIdTt = dw_Fourn.GetItemNumber ( 1, "ID_TT")

Choose Case iIdTT
	Case K_TYPTRT_CODIC_DARTY
		sColNames={"CODE_TT","PROVENANCE","CODE_AR","CODIC","MARQUE","MODELE"}
	// #1
	Case K_TYPTRT_TAC_IMEI
		sColNames={"CODE_TT","MARQUE","MODELE","TAC_IMEI"}
	// #3
	Case K_TYPTRT_CT_INFO
		sColNames={"TYPE_TRT","ID_SIN","RESULTAT", "TXT_MESS","MONTANT", &
			"NUM_FACT", "DTE_ODP", "DTE_FACT", "DTE_REGSPB", "IS_OK","ERREUR"}
		sColOblig={"TYPE_TRT","ID_SIN","RESULTAT"}
	// #4
	Case K_TYPTRT_BTQ
		sColNames={"ID_PROD","ID_BOUTIQUE", "NOM", "ADRESSE", "ADR_CP", &
			"ADR_VILLE", "RESPONSABLE","LIB_POLICE", "FLAG_MAJ"}
		sColOblig={"ID_PROD","ID_BOUTIQUE","LIB_POLICE","FLAG_MAJ"}
	// #5 - 	[DCMP100102] 
	Case K_TYPTRT_LST_SIN, K_TYPTRT_LST_SIN_CASTO, K_TYPTRT_LST_RM, K_TYPTRT_LST_REG, K_TYPTRT_LST_FACTU_CASTO
		sColNames={"ID_SIN"}
	// [PC175]
	Case K_TYPTRT_BTQ_MCM
		sColNames={"CODE_MAG","ENSEIGNE","NOM_MAG","ADRESSE_1","CODE_POSTAL","VILLE"}
	// [PM200][PSM]
	Case K_TYPTRT_BTQ_PSM
		sColNames={"CODE_MAG","NOM_MAG","ADRESSE_1","CODE_POSTAL","VILLE"}
	// [VDOC8686]
	Case K_TYPTRT_CT_CLIENT
		sColNames={"NO_CLIENT","RESULTAT", "TXT_MESS"}
		sColOblig={"NO_CLIENT","RESULTAT", "TXT_MESS"}
	Case K_TYPTRT_VDOC9663 // [VDoc9663]	
		sColNames={"ID_SIN"}
	Case K_TYPTRT_IMEI_ORANGE // [PC938]	
		sColNames={"NUM_PORT","NUM_IMEI"}
	// [VDoc13194]
	Case K_TYPTRT_LST_CMDE_O2M, K_TYPTRT_LST_CMDE_CDS
			sColNames={"ID_SIN"}
	// [VDOC13415]
	Case K_TYPTRT_LST_CMDE_CFM, K_TYPTRT_LST_CMDE_AUC // [VDoc25758]
			sColNames={"NUM_CARTE"}
			sColOblig={"NUM_CARTE"}
	// [VDOC12497]			
	Case K_RM_AVOIR_FOURN
			sColNames={"ID_SIN_SEQ", "MT_AVOIR"}
			sColOblig={"ID_SIN_SEQ", "MT_AVOIR"}
	// [VDOC21846]
	Case K_TYPTRT_LST_SIN_REG
			sColNames={"ID_SIN", "ID_REG"}
			sColOblig={"ID_SIN", "ID_REG"}
	// [VDOC23962]
	Case K_TYPTRT_LST_CMDE
		sColNames={"n__dossier_sinistre_spb"}
		sColOblig={"n__dossier_sinistre_spb"}

	// [RS_4166_PND_CORUS]
	Case K_TYPTRT_LST_PND_CORUS

		// Suppression des lignes d'ent$$HEX1$$ea00$$ENDHEX$$tes
		dw_Charger.SetFilter ( "Left ( Trim ( val_ret_pnd_corus), 23 ) = 'NOM_FICHIER;APPLICATION'" )
		dw_Charger.Filter ()
		dw_Charger.RowsDiscard ( 1, dw_Charger.RowCount (), Primary! )
		dw_Charger.SetFilter ( "")
		dw_Charger.Filter ()

		dw_Charger.Sort ()
		
		lTotLig = dw_Charger.RowCount ()
		sValPrec = ""
		For lCpt = lTotLig To 1 Step -1
			
			sVal2 = Left ( dw_Charger.GetItemString ( lCpt, "val_ret_pnd_corus" ), 50 )
			
			If sVal2 = sValPrec Then
				dw_Charger.RowsDiscard ( lCpt + 1, lCpt + 1, Primary! )				
			End If 
						
			sValPrec = sVal2
		Next 

		dw_Charger.Sort ()
		
		st_Charger.Text = String ( dw_Charger.RowCount () ) + " Retours PND CORUS SIMPA2 et KSL $$HEX2$$e0002000$$ENDHEX$$traiter"	

		
End Choose

lTotRow = dw_Charger.RowCount ()
hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lTotRow
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()

SetPointer(HourGlass!)

For lCpt = 1 to lTotRow

	// Chargement dans les variables de controle
	For lPos=1 To UpperBound(sColNames)
		sVal[lPos] = dw_Charger.GetItemString(lCpt, sColNames[lPos])
	Next
	
	// Contr$$HEX1$$f400$$ENDHEX$$les
	Choose Case iIdTT
		Case K_TYPTRT_CODIC_DARTY
			// Contr$$HEX1$$f400$$ENDHEX$$le que toutes les col sont renseign$$HEX1$$e900$$ENDHEX$$es
			bOk=wf_controler_chps_oblig( sColNames, sVal, sErreur)
			
			// Controle de gestion
			if bOk Then
				bOk = wf_controler_codic( sVal, sErreur)
			End If
			
			// Correction de la valeur du mod$$HEX1$$e800$$ENDHEX$$le : ' et "
			sVal[6] = uString.of_globalreplace(sVal[6],"'","p")		//#2 :  avant : sVal[5] dans le of_globalreplace
			sVal[6] = uString.of_globalreplace(sVal[6],"~"","p")
		
		// #1
		Case K_TYPTRT_TAC_IMEI
			// Contr$$HEX1$$f400$$ENDHEX$$le que toutes les col sont renseign$$HEX1$$e900$$ENDHEX$$es
			bOk=wf_controler_chps_oblig( sColNames, sVal, sErreur)
			
			// Contr$$HEX1$$f400$$ENDHEX$$le des champs
			if bOk Then
				bOk =wf_controler_tac_imei(sVal, sErreur)
			End If
			
		// #3
		Case K_TYPTRT_CT_INFO
			// Contr$$HEX1$$f400$$ENDHEX$$le que toutes les col sont renseign$$HEX1$$e900$$ENDHEX$$es
			bOk=wf_controler_chps_oblig( sColOblig, sVal, sErreur)
			
			// Contr$$HEX1$$f400$$ENDHEX$$le des champs
			if bOk Then
				bOk =wf_controler_ct_info(sVal, sErreur)
			End If
		// #4
		Case K_TYPTRT_BTQ
			// Contr$$HEX1$$f400$$ENDHEX$$le que toutes les col sont renseign$$HEX1$$e900$$ENDHEX$$es
			bOk=wf_controler_chps_oblig( sColOblig, sVal, sErreur)
			
			// Contr$$HEX1$$f400$$ENDHEX$$le de gestion
			If bOk Then
				bOk = wf_controler_boutiques(sVal, sErreur)
			End if
		// #5
		Case K_TYPTRT_LST_SIN, K_TYPTRT_VDOC9663, K_TYPTRT_LST_SIN_CASTO, K_TYPTRT_LST_RM, K_TYPTRT_LST_REG, K_TYPTRT_LST_FACTU_CASTO
			bOk=wf_controler_lst_sin ( sVal, sErreur)
		
		// [PC175] // [PC938]
		Case K_TYPTRT_BTQ_MCM, K_TYPTRT_BTQ_PSM, K_TYPTRT_IMEI_ORANGE, K_TYPTRT_LST_CMDE_CFM, K_TYPTRT_LST_CMDE_AUC
			// Contr$$HEX1$$f400$$ENDHEX$$le que toutes les col sont renseign$$HEX1$$e900$$ENDHEX$$es
			bOk=wf_controler_chps_oblig( sColNames, sVal, sErreur)
		
		Case K_TYPTRT_CT_CLIENT // [VDoc8686]
			// Contr$$HEX1$$f400$$ENDHEX$$le que toutes les col sont renseign$$HEX1$$e900$$ENDHEX$$es
			bOk=wf_controler_chps_oblig( sColOblig, sVal, sErreur)
			
			// Contr$$HEX1$$f400$$ENDHEX$$le des champs
			if bOk Then
				bOk =wf_controler_ct_client(sVal, sErreur)
			End If
		// [VDoc13194]
		Case K_TYPTRT_LST_CMDE_O2M, K_TYPTRT_LST_CMDE_CDS
			bOk=wf_controler_format_cmde(sVal, sErreur)
			
		// [VDOC12917]	
		Case K_RM_AVOIR_FOURN	
			bOk=wf_controler_Rm_Avoir_fourn ( lCpt, sErreur )			

		// [PM375-1]
		Case K_RP_AVOIR_FOURN	
			bOk=wf_controler_rp_avoir_fourn ( lCpt, sErreur )			

		// [PM375-1]
		Case K_RM_SIMPLE	
			bOk=wf_controler_rm_simple ( lCpt, sErreur )			

		// [PM375-1]
		Case K_RP_SIMPLE	
			bOk=wf_controler_rp_simple ( lCpt, sErreur )			

		// [PM375-1
		Case K_RN_FRAIS_FACTU	
			bOk=wf_controler_rn_Frais_Factu ( lCpt, sErreur )			

		// [VDOC21846]
		Case K_TYPTRT_LST_SIN_REG
			bOk= wf_controler_lstsinreg( sVal, sErreur)			

		// [PM378-1]
		Case K_TYPTRT_RET_PM02
			bOk= wf_controler_retour_PM02 ( lCpt, sErreur)	
		
		// [VDOC28472]
		Case K_TYPTRT_LST_FACT
			bOk= wf_controler_vDoc28472 ( lCpt, sErreur)	
			
		// [RS_4166_PND_CORUS]
		Case K_TYPTRT_LST_PND_CORUS
			bOk= wf_controler_pnd_corus ( lCpt, sErreur)	

	End Choose
	
	// Positionnement sur l'erreur
	If Not bOk Then 
		dw_Charger.ScrollToRow ( lCpt )
		dw_Charger.SelectRow ( 0, FALSE ) // #3 - Am$$HEX1$$e900$$ENDHEX$$lioration
		dw_Charger.SelectRow ( lCpt, True )
		Exit
	End If

	// Copie des champs dans le ds de stockage
	lPos = ids_charger.InsertRow(0)
	
	Choose Case iIdTT
		Case K_TYPTRT_CODIC_DARTY
			ids_charger.object.code_tt[lPos] 	= iIdTt
			ids_charger.object.provenance[lPos] 	= sVal[2]
			ids_charger.object.code_ar[lPos] 	= sVal[3]
			ids_charger.object.codic[lPos] 		= long(sVal[4])
			ids_charger.object.marque[lPos] 	= sVal[5]
			ids_charger.object.modele[lPos]		= sVal[6]
	
		// #1
		Case K_TYPTRT_TAC_IMEI
			ids_charger.object.code_tt[lPos] 	= iIdTt
			ids_charger.object.tac_imei[lPos] 	= long(sVal[4])
			ids_charger.object.marque[lPos] 	= sVal[2]
			ids_charger.object.modele[lPos]		= sVal[3]
		// #3
		Case K_TYPTRT_CT_INFO
			ids_charger.object.type_trt[lPos] 	= long(sVal[1])
			ids_charger.object.id_sin[lPos] 		= sVal[2]
			ids_charger.object.resultat[lPos] 	= long(sVal[3])
			ids_charger.object.txt_mess[lPos] 	= sVal[4]
			ids_charger.object.montant[lPos] 	= dec(sVal[5])
			ids_charger.object.num_fact[lPos] 	= sVal[6]
			ids_charger.object.dte_odp[lPos] 	= datetime(date(sVal[7]))
			ids_charger.object.dte_fact[lPos] 	= datetime(date(sVal[8]))
			ids_charger.object.dte_regspb[lPos] 	= datetime(date(sVal[9]))
		// #4
		Case K_TYPTRT_BTQ
			ids_charger.object.id_prod[lPos] 	 = long(sVal[1])
			ids_charger.object.id_boutique[lPos] = sVal[2]
			ids_charger.object.nom[lPos]			 = sVal[3]
			wf_decoupe_adr(sVal[4],sAdr1, sAdr2," ")
			ids_charger.object.adr_1[lPos]		 = sAdr1
			ids_charger.object.adr_2[lPos]		 = sAdr2
			ids_charger.object.adr_cp[lPos]		 = sVal[5]
			ids_charger.object.adr_ville[lPos] 	 = sVal[6]
			ids_charger.object.responsable[lPos] = Left(sVal[7],35)
			ids_charger.object.lib_police[lPos]  = Left(sVal[8],35)
			ids_charger.object.flag_maj[lPos]  	 = sVal[9]
		Case K_TYPTRT_LST_SIN_REG
			ids_charger.object.id_sin[lPos] 	 = sVal[1]
			ids_charger.object.id_reg[lPos] = sVal[2]
	end choose
	
	SetNull(lPos)
	hpb_trt.Position = lCpt
	wf_pct ()	
	Yield()
	
Next

if bOk Then 
	st_Extraire.Text  = "Contr$$HEX1$$f400$$ENDHEX$$le Ok !"
	st_extraire.BackColor = 32768
   st_extraire.TextColor = 16777215
else
	st_Extraire.Text  = "Erreur sur la ligne n$$HEX1$$b000$$ENDHEX$$"+string(lCpt)+" "+sErreur
	st_extraire.BackColor = 255
   st_extraire.TextColor = 16777215	
	
End If

SetPointer(Arrow!)

Return bOk
end function

private function boolean wf_maj ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_autre_fichier::wf_Maj (PRIVATE)
//* Auteur        :FPI
//* Date          : 12/12/2008
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : [DCMP80862]
//*					  
//*
//* Arguments     : 
//*
//* Retourne      : Boolean	bRet
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1		FPI	15/01/2009	Int$$HEX1$$e900$$ENDHEX$$gration des fichiers TAC_IMEI
//* #2		FPI	01/07/2009	[DCMP090310] Int$$HEX1$$e900$$ENDHEX$$gration contacts d'info
//* #3		FPI	03/08/2009	[CAMARA]
//* #4 		FPI	06/11/2009	[EXPANSION5.BOUTIQUES] Ajout de l'int$$HEX1$$e900$$ENDHEX$$gration des btq
//* #5		FPI	19/02/2010	[DCMP100102]
//				FPI	02/12/2010	[PC175]
// 				FPI	15/02/2012	[PM200][PSM]
//				FPI	18/09/2012	[VDoc8686]
//				FPI	17/05/2013	[PC938]
// 				FPI	14/01/2014	[VDoc13194]
//			FPI		21/01/2014	[VDOC13415]
//			JFF		27/01/2014	[VDOC12917]
// 			FPI		19/09/2016	[VDOC19525]
// 			FPI		22/09/2016	[VDOC21846]
//       JFF   30/11/2016 [PM375-1]
//			FPI		13/02/2017	 [VDOC23002]
// 			FPI		26/12/2017	[VDOC24986]
//       JFF   27/05/2019 [PM478-1]
//			FPI		07/10/2019	[VDOC28472]
//       JFF   02/01/2023 [RS_4166_PND_CORUS]
//*-----------------------------------------------------------------

Long		lCpt, lTot, lNbTraite, lRet
String	sTraite = 'N'
Boolean	bRet
integer  iIdTt
String 	sErr // #2
Long 		lIdLotExtr // #3
String 	sNomFichier, sCatFact // #3

lNbTraite = 0
lTot = dw_Charger.RowCount()
hpb_trt.Position = 0
hpb_trt.MaxPosition = lTot
wf_pct ()
Yield ()


iIdTt    = dw_Fourn.object.id_tt[1]
bRet = True

sErr = Fill(" ",60) // #2

st_extraire.textcolor = 16711680
st_extraire.backcolor = 67108864

// #1 Traitement avant insertion
Choose Case iIdTt
		Case K_TYPTRT_TAC_IMEI
			sqlca.PS_D01_TAC_IMEI()
			If SQLCA.SQLCode <> 0 Or SQLCA.SQLDBCode <> 0 Then		bRet = False
			
		Case K_TYPTRT_CAMARA // #3
			bRet=wf_init_camara(lIdLotExtr, sNomFichier)
			If not bRet Then 
				cb_maj.Enabled = TRUE
				Return FALSE
			End if
		Case K_TYPTRT_LST_SIN, K_TYPTRT_LST_SIN_CASTO, K_TYPTRT_LST_FACTU_CASTO // #5
			wf_trt_lst_sin()
			Return TRUE
		Case K_TYPTRT_BTQ_MCM //[PC175]
			Return wf_trt_btq_mcm()
		Case K_TYPTRT_BTQ_PSM // [PM200][PSM]
			Return wf_trt_btq_psm()
		Case K_TYPTRT_VDOC9663
			wf_trt_extr_vdoc9663 ()
			Return TRUE
		// [PC938]
		Case K_TYPTRT_IMEI_ORANGE
			Return wf_trt_imei_orange()
		// [VDoc13194]
		Case K_TYPTRT_LST_CMDE_O2M, K_TYPTRT_LST_CMDE_CDS,  K_TYPTRT_LST_CMDE_CFM, K_TYPTRT_LST_RM, K_TYPTRT_LST_CMDE, K_TYPTRT_LST_CMDE_AUC //, K_TYPTRT_LST_REG
			wf_trt_lst_cmd(iIdTt)
			Return TRUE

		// [VDOC23002]
		Case K_TYPTRT_LST_REG
			wf_trt_lst_reg(iIdTt)
			Return TRUE
			
		// [VDOC12917]
		Case K_RM_AVOIR_FOURN
			Return wf_trt_rm_avoir_fourn ()			

		// [PM375-1]
		Case K_RP_AVOIR_FOURN
			Return wf_trt_rp_avoir_fourn ()			
		
		// [PM375-1]
		Case K_RM_SIMPLE
			Return wf_trt_rm_simple ()			
		
		// [PM375-1]
		Case K_RP_SIMPLE
			Return wf_trt_rp_simple ()			

		// [PM375-1]
		Case K_RN_FRAIS_FACTU
			Return wf_trt_rn_Frais_Factu ()			

		// [VDOC21846]
		Case K_TYPTRT_LST_SIN_REG
			wf_trt_lstsinreg( )
			Return True

		// [PM378-1]
		Case K_TYPTRT_RET_PM02
			Return wf_trt_retour_PM02 ()					
		
		// [VDOC28472]
		Case K_TYPTRT_LST_FACT
			Return wf_trt_lstfact ()

		// [RS_4166_PND_CORUS]			
		Case K_TYPTRT_LST_PND_CORUS
			Return wf_trt_PND_CORUS ()

			
	End Choose

If bRet Then
	For lCpt = 1 To lTot
		Choose Case iIdTt
			Case K_TYPTRT_CODIC_DARTY
				lRet = sqlca.PS_I01_REF_CODIC_DARTY (ids_charger.object.provenance[lCpt],	&
														 ids_charger.object.code_ar[lCpt],		&
														 ids_charger.object.codic[lCpt],		&
														 ids_charger.object.marque[lCpt],		&
														 ids_charger.object.modele[lCpt],		&
														stGlb.sCodOper, sTraite )
			// #1
			Case K_TYPTRT_TAC_IMEI
				lRet = sqlca.PS_I01_TAC_IMEI (	ids_charger.object.tac_imei[lCpt],		&
																	ids_charger.object.marque[lCpt],		&
																	ids_charger.object.modele[lCpt],		&
																	stGlb.sCodOper, sTraite )
			// #2
			Case K_TYPTRT_Ct_info
				lRet = SQLCA.PS_Integrer_contact_facturation( &
						ids_charger.object.type_trt[lCpt], 			&
						ids_charger.object.id_sin[lCpt],				&
						ids_charger.object.resultat[lCpt],			&
						ids_charger.object.txt_mess[lCpt],			&
						ids_charger.object.montant[lCpt],			&
						ids_charger.object.num_fact[lCpt],			&
						ids_charger.object.dte_odp[lCpt],			&
						ids_charger.object.dte_fact[lCpt],			&
						ids_charger.object.dte_regspb[lCpt],		&
						stglb.scodoper , "E", sErr)
						
				If lRet = 0 Then 
					sTraite='O'
				Else
					sTraite='N'
				End if
		
			// #3 [CAMARA]
			Case K_TYPTRT_CAMARA
				dw_charger.setitem(lCpt,"ID_LOT_EXTR",lIdLotExtr)
				
				sCatFact = dw_charger.getItemString(lCpt, "CAT_FACT")
				dw_charger.setitem(lCpt,"CAT_FACT",sCatFact + String(lIdLotExtr))
				
				SQLCA.PS_U01_trace_fact_a_regl( dw_charger.object.id_cle[lCpt], &
						lIdLotExtr)
						
			// #4 [EXPANSION5.BOUTIQUES]
			Case K_TYPTRT_BTQ
				lRet = SQLCA.PS_I01_BOUTIQUE( ids_charger.object.id_prod[lCpt], &
					ids_charger.object.id_boutique[lCpt], &
					ids_charger.object.adr_ville[lCpt], &
					ids_charger.object.adr_cp[lCpt], &
					ids_charger.object.nom[lCpt], &
					ids_charger.object.adr_1[lCpt], & 
					ids_charger.object.adr_2[lCpt], &
					ids_charger.object.responsable[lCpt], &
					ids_charger.object.lib_police[lCpt], &
					ids_charger.object.flag_maj[lCpt], &
					stglb.scodoper )
					
				If lRet = 0 Then 
					sTraite='O'
				Else
					sTraite='N'
				End if
			
			// [VDoc8686]
			Case K_TYPTRT_Ct_Client
				lRet = SQLCA.PS_Integrer_contact_client( &
						Long(dw_charger.object.no_client[lCpt]), 			&
						Long(dw_charger.object.resultat[lCpt]),				&
						dw_charger.object.txt_mess[lCpt],			&
						"E", stglb.scodoper)
				If lRet = 0 Then 
					sTraite='O'
				Else
					sTraite='N'
				End if
				
			// [PC938]
			Case K_TYPTRT_IMEI_ORANGE
				Exit
		End Choose

		bRet = ( SQLCA.sqlcode = 0 And SQLCA.sqlDBcode = 0  And lRet = 0 )
	
		if sTraite = 'O' then lNbTraite++
		
		if bRet then
			hpb_trt.Position = lCpt
			wf_pct ()
			Yield()
			If iIdTt <> K_TYPTRT_CAMARA Then F_Commit ( SQLCA, True ) // #3 - Pour Camara, on commit $$HEX2$$e0002000$$ENDHEX$$la fin
			If iIdTt = k_typtrt_ct_info Then dw_charger.setItem(lCpt,"IS_OK","O") // #2
		else
			
			// #2
			If iIdTt = k_typtrt_ct_info Then
				if sTraite = 'O' then lNbTraite --
				
				dw_charger.setItem(lCpt,"IS_OK","N")
				
				if Trim(sErr) = "" Then sErr = SQLCA.SQLErrText
				
				dw_charger.setItem(lCpt,"ERREUR",sErr)
				F_Commit ( SQLCA, False )
			Else // Fin #2
				exit
			End if // #2
			
		End If
	Next
End if

// #3
if bRet and iIdTT = K_TYPTRT_CAMARA Then
	stMessage.sCode = "COMD543" // Msg d'avert
	stMessage.Icon		= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sVar[1] = sNomFichier
	stMessage.sTitre = "AVERTISSEMENT"
	f_message(stmessage)
	
	if dw_charger.saveas(sNomFichier, Text!, TRUE) = -1 Then
		bRet = FALSE
   	F_Commit ( SQLCA, False )
		
		stMessage.bErreurG	= TRUE
		stMessage.sCode = "ANCE008" 
		f_message(stmessage)
		cb_maj.Enabled=TRUE
		dw_charger.Retrieve()
	Else
		F_Commit ( SQLCA, TRUE )
		st_extraire.text="Extraction et marquage termin$$HEX1$$e900$$ENDHEX$$s"
	End If
	
	Return bRet	
End if
// Fin #3


If Not bRet And iIdTT<> k_typtrt_ct_info Then // #2 ajout de clause ct_info
   stMessage.Icon      = Exclamation!
   stMessage.sCode   = "SFRP100"
   stMessage.sVar[1]    = String ( SQLCA.SqlDbCode )
   stMessage.sVar[2]    = SQLCA.SqlErrText
   F_Commit ( SQLCA, False )
Else
   stMessage.Icon      = Information!
   stMessage.sCode   = "COMD430"
   stMessage.sVar[1]   = String ( lNbTraite )
End If

stMessage.sTitre		= "Traitement/Int$$HEX1$$e900$$ENDHEX$$gration autre fichier."
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!
If (not gbOpcon) Then F_Message ( stMessage ) // [PC175] ajout de gbopcon


Return bRet
end function

private function integer wf_chargerdw ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_autofact::wf_ChargerDw (PRIVATE)
//* Auteur        : FPI
//* Date          : 12/12/2008
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Chargement du data object correspond type de traitement choisi
//* Commentaires  : [DCMP80862]
//*
//* Arguments     : 
//*
//* Retourne      :	0	ok
//*						-1	nok
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1		FPI	15/01/2009	Int$$HEX1$$e900$$ENDHEX$$gration des fichiers TAC_IMEI
//* #2	FPI		30/06/2009	[DCP090310] Int$$HEX1$$e900$$ENDHEX$$gration contacts d'info
//* #3 	FPI		03/08/2009	[CAMARA]
//* #4 	FPI		05/11/2009	[EXPANSION5.BOUTIQUES]
//* #5	FPI		19/02/2010	[DCMP100102]
// 			FPI		18/09/2012  [VDoc8686]
// 			JFF		21/12/2012  [VDoc9663]
//			FPI		17/05/2013	[PC938]
// 			FPI		14/01/2014	[VDoc13194]
//			FPI		21/01/2014	[VDoc13415]
//			JFF		27/01/2014	[VDOC12917]
// 			FPI		19/09/2016	[VDOC19525]
// 			FPI		22/09/2016	[VDOC21846]
//			FPI		04/11/2016	[VDOC22119]
//       JFF   30/11/2016 [PM375-1]
//			FPI		13/02/2017	 [VDOC23002]
// 			FPI		26/12/2017	[VDOC24986]
//			FPI		21/02/2018	[VDoc25758]
//       JFF   27/05/2019 [PM478-1]
//  		FPI		07/10/2019	[VDOC28472] 
//       JFF   09/09/2022 [PM80_FA12_FRANEX]
//       JFF   02/01/2023 [RS_4166_PND_CORUS]
//*-----------------------------------------------------------------
	
integer iIdTt

iIdTt		= dw_Fourn.object.id_tt[1]

ids_charger 	= create datastore

Choose Case iIdTt
	Case K_TYPTRT_CODIC_DARTY 
		dw_charger.dataobject = 'd_trt_charge_codic_darty'
		ids_charger.dataobject = 'd_trt_int_fic_codic_darty'
	// #1
	Case K_TYPTRT_TAC_IMEI
		dw_charger.dataobject = 'd_trt_charge_tac_imei'
		ids_charger.dataobject = 'd_trt_int_fic_tac_imei'
	Case K_TYPTRT_CT_INFO // #2
		dw_charger.dataobject = 'd_trt_charge_ct_info'
		ids_charger.dataobject = 'd_trt_int_fic_ct_info'
	Case K_TYPTRT_CAMARA // #3 [CAMARA]
		dw_charger.dataobject = 'd_trt_charge_autofact_camara'
	Case K_TYPTRT_BTQ // #4 [EXPANSION5.BOUTIQUES]
		dw_charger.dataobject = 'd_trt_charge_btq'
		ids_charger.dataobject = 'd_trt_int_fic_btq'
	Case K_TYPTRT_LST_SIN // #5 - [DCMP100102]
		dw_charger.dataobject = 'd_trt_charge_lst_sin'
	Case K_TYPTRT_BTQ_MCM // [PC175]
		dw_charger.dataobject = 'd_trt_charge_btq_mcm'
	Case K_TYPTRT_BTQ_PSM // [PM200][PSM]
		dw_charger.dataobject = 'd_trt_charge_btq_psm'
	Case K_TYPTRT_CT_CLIENT // [VDoc8686]
		dw_charger.dataobject = 'd_trt_charge_contact_client'
	Case K_TYPTRT_VDOC9663 // [VDoc9663]
		dw_charger.dataobject = 'd_trt_charge_extraction_vdoc9663'
	Case K_TYPTRT_IMEI_ORANGE // [PC938]
		dw_charger.dataobject = 'd_trt_int_fic_imei_orangev3'
	// [VDoc13194]
	Case K_TYPTRT_LST_CMDE_O2M
//		dw_charger.dataobject = 'd_trt_charge_extraction_vdoc8285'
		dw_charger.dataobject = 'd_trt_charge_extraction_vdoc8285_vjf'
	Case K_TYPTRT_LST_CMDE_CDS
		dw_charger.dataobject = 'd_trt_charge_extraction_vdoc12967'
	// [VDoc13415]
	Case K_TYPTRT_LST_CMDE_CFM
		dw_charger.dataobject = 'd_trt_charge_extraction_vdoc12705'
	// [VDOC12917]
	Case K_RM_AVOIR_FOURN
		
		// [PM80_FA12_FRANEX]
		dw_charger.dataobject = "d_trt_charge_rm_avoir_fourn_vdoc12917_1"
		dw_charger.Modify ( "id_sin_seq.protect=1 id_four.protect=1 mt_avoir.protect=1 lib_rm.protect=1 indem_princ_1.protect=1 frais_anex_2.protect=1 frais_anex_3.protect=1 frais_anex_4.protect=1 frais_anex_5.protect=1 frais_anex_6.protect=1 result_trt.protect=1 " ) 
		
	// [VDOC19525]
	Case K_TYPTRT_LST_SIN_CASTO
		dw_charger.dataobject = 'd_trt_charge_lstsin_casto'
	// [VDOC21846]
	Case K_TYPTRT_LST_SIN_REG
		dw_charger.dataobject = 'd_trt_charge_lstsinreg'
		ids_charger.dataobject = 'd_trt_charge_lstsinreg'
	// [VDOC22119]
	Case  K_TYPTRT_LST_RM
		dw_charger.dataobject = "d_trt_vdoc22119"
	// [PM375-1]		
	Case K_RP_AVOIR_FOURN

		// [PM80_FA12_FRANEX]
		dw_charger.dataobject = 'd_trt_charge_rp_avoir_fourn_pm375-1_1'
		dw_charger.Modify ( "id_sin_seq.protect=1 id_four.protect=1 mt_avoir.protect=1 lib_rp.protect=1 indem_princ_1.protect=1 frais_anex_2.protect=1 frais_anex_3.protect=1 frais_anex_4.protect=1 frais_anex_5.protect=1 frais_anex_6.protect=1 result_trt.protect=1 " ) 
		
	// [PM375-1]		
	Case K_RM_SIMPLE
		// [PM80_FA12_FRANEX]
		dw_charger.dataobject = 'd_trt_charge_rm_simple_pm375-1_1'
		dw_charger.Modify ( "id_sin.protect=1 id_reg_base.protect=1 mt_rm.protect=1 lib_rm.protect=1 indem_princ_1.protect=1 frais_anex_2.protect=1 frais_anex_3.protect=1 frais_anex_4.protect=1 frais_anex_5.protect=1 frais_anex_6.protect=1 result_trt.protect=1 " ) 
		
	// [PM375-1]		
	Case K_RP_SIMPLE
		// [PM80_FA12_FRANEX]
		dw_charger.dataobject = 'd_trt_charge_rp_simple_pm375-1_1'
		dw_charger.Modify ( "id_sin.protect=1 id_reg_base.protect=1 mt_rp.protect=1 lib_rp.protect=1 indem_princ_1.protect=1 frais_anex_2.protect=1 frais_anex_3.protect=1 frais_anex_4.protect=1 frais_anex_5.protect=1 frais_anex_6.protect=1 result_trt.protect=1 " ) 
		
	// [PM375-1]		
	Case K_RN_FRAIS_FACTU

		// [PM80_FA12_FRANEX]
		dw_charger.dataobject = 'd_trt_charge_rn_frais_factu_pm375-1_1'
		dw_charger.Modify ( "id_sin.protect=1 mt_rn.protect=1 lib_rn.protect=1 id_four_fct.protect=1 indem_princ_1.protect=1 frais_anex_2.protect=1 frais_anex_3.protect=1 frais_anex_4.protect=1 frais_anex_5.protect=1 frais_anex_6.protect=1 result_trt.protect=1 " ) 
		
	// [VDoc23002]
	Case K_TYPTRT_LST_REG			
		dw_charger.dataobject = "d_trt_vdoc23002"
	// [VDoc23962]
	Case K_TYPTRT_LST_CMDE
		dw_charger.dataobject = 'd_trt_charge_extraction_vdoc21987'
	// [VDOC24986]
	Case K_TYPTRT_LST_FACTU_CASTO
		dw_charger.dataobject = "d_trt_charge_factu_casto"
	// [VDoc25758]
	Case K_TYPTRT_LST_CMDE_AUC
		dw_charger.dataobject = 'd_trt_charge_extraction_vdoc25758'

	// [PM478-1]		
	Case K_TYPTRT_RET_PM02
		dw_charger.dataobject = 'd_trt_charge_retour_PM02_PM478'
		
	//  [VDOC28472] 
	Case K_TYPTRT_LST_FACT
		dw_charger.dataobject = 'd_trt_charge_extraction_vdoc28472'

	// [RS_4166_PND_CORUS]
	Case K_TYPTRT_LST_PND_CORUS
		dw_charger.dataobject = 'd_trt_charge_pnd_corus'
		dw_charger.Modify ( "val_ret_pnd_corus.protect=1 val_ret_pnd_corus.protect=1" ) 
		


End Choose

return 0
end function

private function boolean wf_controler_tac_imei (ref string asvaleurs[], ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_tac_imei
//* Auteur			: F. Pinon
//* Date				: 15/01/2009 11:26:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Int$$HEX1$$e900$$ENDHEX$$gration des fichiers TAC_IMEI
//*
//* Arguments		: ref string asvaleurs[]	 */
/* 	ref string aserreur	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

n_cst_string uString
boolean bOk
string sMarque
Long lPos

bOk = True

// idTrt
bOk = ( integer(asValeurs[1]) =  K_TYPTRT_TAC_IMEI)
if not bok then asErreur += 'Code de traitement diff$$HEX1$$e900$$ENDHEX$$rent du type de traitement s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$! '
			
//TAC_IMEI
if bOk Then
	bOk = IsNumber(asValeurs[4])
	if not bok then asErreur += "Code TAC n'est pas un nombre ! "
End If
	
// Marque est <= $$HEX2$$e0002000$$ENDHEX$$35 Caract$$HEX1$$e800$$ENDHEX$$res
If bOk Then
	bOk = (Len(asValeurs[2]) <= 35	)
	if not bok then asErreur += "Marque trop grand ! "
End If

// Mod$$HEX1$$e800$$ENDHEX$$le est <= $$HEX2$$e0002000$$ENDHEX$$35 Caract$$HEX1$$e800$$ENDHEX$$res
If bOk Then
	bOk = ( Len(asValeurs[3]) <= 35	)
	if not bok then asErreur += "Mod$$HEX1$$e800$$ENDHEX$$le trop grand ! "
End If

if bOk Then
	// ** Ajustement de la marque**
	sMarque = Upper(asvaleurs[2])

	// Marque Orange
	lPos = Pos(sMarque,"ORANGE")
	if lPos = 0 Then lPos = Pos(sMarque,"QTEK")
	if lPos = 0 Then lPos = Pos(sMarque,"HTC")
	if lPos = 0 Then lPos = Pos(Upper(asvaleurs[3]),"QTEK")
	if lPos = 0 Then lPos = Pos(Upper(asvaleurs[3]),"SPV")

	if lPos > 0 Then sMarque = "#ORANGE#QTEK#HTC"

	// Marque MITSUBISHI ELECTRIC
	lPos = Pos(sMarque,"MITSUBISHI")
	if lPos > 0 Then sMarque = "MITSUBISHI ELECTRIC"

	// Marque RIM BLACKBERRY
	if sMarque = "RIM" Then sMarque = "RIM BLACKBERRY"

	// Marque PALMONE
	if sMarque = "PALM ONE" Then sMarque = "PALMONE"

	// Marque SONY ERICSSON
	if sMarque = "SONYERICSSON" Then sMarque = "SONY ERICSSON"

	// Marque VK
	if sMarque = "VK MOBILES" Then sMarque = "VK"

	asvaleurs[2] = sMarque
	
End if

Return bOk
end function

public function long wf_epure_tac_imei ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_epure_tac_imei
//* Auteur			: F. Pinon
//* Date				: 15/01/2009 12:02:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Supprime les doublons & lignes inutiles dans les donn$$HEX1$$e900$$ENDHEX$$es TAC_IMEI
//* Commentaires	: Int$$HEX1$$e900$$ENDHEX$$gration des fichiers TAC_IMEI
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

long lRow
string sTac1, sTac2, sMarque, sFind

// Suppression des marques 'INCONNU' ou vide
sFind = "Upper(Trim(marque)) = 'INCONNU' or isnull(marque) or Trim(marque)=''"

lRow = dw_charger.find( sFind, 1, dw_charger.RowCount())

do while lRow > 0 
	dw_charger.deleterow( lRow)
	lRow = dw_charger.find( sFind, lRow, dw_charger.RowCount())
loop

dw_charger.setsort("tac_imei")
dw_charger.sort()

if dw_charger.RowCount() > 1 Then
	// Suppression des doublons tac_imei
	For lRow = dw_charger.RowCount() to 2 step -1
		sTac1=dw_charger.getitemstring(lRow,"tac_imei")
		stac1=trim(stac1)
		
		sTac2=dw_charger.getitemstring(lRow - 1,"tac_imei")
		stac2=trim(stac2)
	
		if sTac1 = sTac2 Then dw_charger.deleteRow(lRow)
	Next
End if

Return dw_charger.RowCount()

end function

public subroutine wf_trim_champs ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trim_champs
//* Auteur			: F. Pinon
//* Date				: 15/04/2009 11:24:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Trim les valeurs dans dw_charger
//* Commentaires	: 
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

Long lRow
String sVal

For lRow = 1 To dw_charger.rowcount( )
	// Modele
	sVal = dw_charger.GetItemString(lRow,"modele")
	if not isNull(sVal) Then
		sVal=Trim(sVal)
		dw_charger.SetItem(lRow,"modele",sVal)
	End if
	
	// Marque
	sVal = dw_charger.GetItemString(lRow,"marque")
	if not isNull(sVal) Then
		sVal=Trim(sVal)
		dw_charger.SetItem(lRow,"marque",sVal)
	End if

Next
end subroutine

private function boolean wf_controler_ct_info (ref string asvaleurs[], ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_ct_info
//* Auteur			: F. Pinon
//* Date				: 30/06/2009 16:33:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [DCMP090310]
//*
//* Arguments		: ref string asvaleurs[]	 */
/* 	ref string aserreur	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

n_cst_string uString
boolean bOk
Integer iTypeTrt, iResultat, iRet
Decimal dcMontant
DateTime dteODP, dteFact, dteRegSpb
String sErr

bOk = True

//type_trt
if bOk Then
	bOk = IsNumber(asValeurs[1]) Or IsNull(asValeurs[1])
	if not bok then 
		asErreur += "Type traitement n'est pas un nombre ! "
	Else 
		iTypeTrt = integer(asValeurs[1])
	End if
End If
	
//Resultat
if bOk Then
	bOk = IsNumber(asValeurs[3]) Or IsNull(asValeurs[3])
	if not bok then 
		asErreur += "R$$HEX1$$e900$$ENDHEX$$sultat n'est pas un nombre ! "
	Else 
		iResultat = integer(asValeurs[3])
	End if
End If

//Montant
if bOk Then
	bOk = IsNumber(asValeurs[5]) Or IsNull(asValeurs[5])
	if not bok then 
		asErreur += "Montant n'est pas un nombre ! "
	Else 
		dcMontant = Dec(asValeurs[5])
	End if
End If

//Date ODP
if bOk Then
	bOk = IsDate(asValeurs[7]) Or IsNull(asValeurs[7])
	if not bok then 
		asErreur += "Date ordre de paiement n'est pas une date ! "
	Else 
		dteODP = datetime(date(asValeurs[7]))
	End if
End If

//Date facture
if bOk Then
	bOk = IsDate(asValeurs[8]) Or IsNull(asValeurs[8])
	if not bok then 
		asErreur += "Date facture n'est pas une date ! "
	Else 
		dteFact = datetime(date(asValeurs[8]))
	End If
End If

//Date reglement SPB
if bOk Then
	bOk = IsDate(asValeurs[9]) Or IsNull(asValeurs[9])
	if not bok then 
		asErreur += "Date r$$HEX1$$e800$$ENDHEX$$glement SPB n'est pas une date ! "
	Else 
		dteRegSpb = datetime(date(asValeurs[9]))
	End if
End If

If bOk Then
	sErr=Fill(" ",60)
	
	iRet = SQLCA.PS_Integrer_contact_facturation( iTypeTrt , asvaleurs[2] , &
		iResultat , asValeurs[4], dcMontant, asValeurs[6], &
		dteODP , dtefact, dteRegSpb , stglb.scodoper , "V", sErr)
	
	If iRet <> 0 Then
		aserreur = sErr
		bOk=FALSE
	End if
End if
	
Return bOk
end function

public function boolean wf_init_camara (ref long alidlotextr, ref string asnomfichier);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_init_camara
//* Auteur			: F. Pinon
//* Date				: 03/08/2009 10:01:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [CAMARA]
//*
//* Arguments		: ref long alidlotextr	 */
/* 	ref string asnomfichier	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
Boolean bRet
Integer iRetour
String sNomComplet, sNomFic
long lcptval, lPos

bRet = FALSE

iRetour = GetFileSaveName( "Nom du fichier Texte", sNomComplet, sNomFic, "", &
												"Fichiers Texte (*.TXT),*.TXT")
If iRetour > 0 Then bRet = TRUE

if bRet Then
	SQLCA.PS_X_Incrementer( "ID_LOT_FAC", lcptval)

	If SQLCA.SQLCode <> 0 Or SQLCA.SQLDBCode <> 0 or lcptval < 0 Then
		stMessage.bErreurg = FALSE
		stMessage.Icon      = Exclamation!
	   stMessage.sCode   = "SFRP100"
   	stMessage.sVar[1]    = String ( SQLCA.SqlDbCode )
	   stMessage.sVar[2]    = SQLCA.SqlErrText
		stMessage.sTitre = "Extraction CAMARA"
	  	f_commit(SQLCA, FALSE)
		bRet = FALSE
	Else
		f_commit(SQLCA, TRUE)
		alidlotextr = lCptval
	End if
End if

If bRet Then
	If right(sNomComplet,4) = ".TXT" Then // Car le SaveAs ajoute .TXT $$HEX2$$e0002000$$ENDHEX$$la fin
		sNomComplet = Left(sNomComplet,Len(sNomComplet) -4)
	End If
	
	lPos = LastPos(sNomComplet,".")
	if lPos > 0 and lPos > Len(sNomComplet) - 5 Then // A cause de "spb.lan"
		sNomComplet=Left(sNomComplet,lPos -1)
	End if
	
	sNomComplet += "_lot_" + string(lcptval) + "_" 
	sNomComplet += String(Today(), "yyyymmdd") + string(Now(), "hhmmss")  
	sNomComplet += ".TXT"
	asNomFichier = sNomComplet
End if

Return bRet
end function

protected function boolean wf_controler_boutiques (ref string asval[], ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_boutiques
//* Auteur			: F. Pinon
//* Date				: 09/11/2009 09:52:57
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [O2M_FRAIS]
//*
//* Arguments		: ref string asvaleur[]	 */
/* 	ref string aserreur	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Boolean bOk

// Contr$$HEX1$$f400$$ENDHEX$$le des champs
bOk = IsNumber(asVal[1])

if bOk Then
	// Contr$$HEX1$$f400$$ENDHEX$$le d'existence
	If SQLCA.PS_V01_BOUTIQUE( Dec(asVal[1]), asval[2], asval[9]) = -1 Then
		if  asval[9] ='I' Then 	asErreur += "Cette boutique existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$."
		if  asval[9] ='U' Then 	asErreur += "Cette boutique n'existe pas."
		bOk=FALSE
	End if
Else
	asErreur += "L'identifiant produit n'est pas un nombre ! "
End if

Return bOk
end function

private function boolean wf_controler_codic (ref string asvaleurs[], ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_codic
//* Auteur			: F. Pinon
//* Date				: 09/11/2009 09:59:52
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: ref string asvaleurs[]	 */
/* 	ref string aserreur	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	29/12/2012	[ITSM140261] Correction taille marque/modele table des codics
//* 		JFF   30/08/2017	Pas de type TEL sur le r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiel DARTY !
//*-----------------------------------------------------------------

boolean bOK

bOk=TRUE

// Code_tt	
bOk = ( integer(asValeurs[1]) =  K_TYPTRT_CODIC_DARTY)
if not bok then asErreur += 'Code de traitement diff$$HEX1$$e900$$ENDHEX$$rent du type de traitement s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$! '
			
// Provenance est <= $$HEX2$$e0002000$$ENDHEX$$3 Caract$$HEX1$$e800$$ENDHEX$$res
If bOk Then
	bOk = (Len(asValeurs[2]) <= 3	)
	if not bok then asErreur += "Provenance trop grand ! "
End If


// Type d'article
If bOk Then
	if SQLCA.PS_S01_CODE_CAR ( asValeurs[3], '-AR') <> 1 Then
		bOk = False
		asErreur += "Type d'article inexistant ! "
	End if
End If

// Pas de type TEL sur le r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiel DARTY ! 
If bOk Then
	bOk = ( asValeurs[3] <> "TEL" )
	if not bok then asErreur += "Pas de type TEL sur le r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiel DARTY ! "
End If

//Codic
If bOk Then
	bOk = IsNumber(asValeurs[4])
	if not bok then asErreur += "Codic n'est pas un nombre ! "
End If

// Marque est <= $$HEX2$$e0002000$$ENDHEX$$30 Caract$$HEX1$$e800$$ENDHEX$$res
If bOk Then
	bOk = (Len(asValeurs[5]) <= 30	)
	if not bok then asErreur += "Marque trop grand ! "
End If

// Mod$$HEX1$$e800$$ENDHEX$$le est <= $$HEX2$$e0002000$$ENDHEX$$30 Caract$$HEX1$$e800$$ENDHEX$$res
If bOk Then
	bOk = ( Len(asValeurs[6]) <= 30	)
	if not bok then asErreur += "Mod$$HEX1$$e800$$ENDHEX$$le trop grand ! "
End If


Return bOK
end function

protected function boolean wf_controler_lst_sin (ref string asval[], ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_lst_sin
//* Auteur			: F. Pinon
//* Date				: 19/02/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [DCMP100102]
//*
//* Arguments		: ref string asvaleur[]	 */
/* 	ref string aserreur	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Boolean bOk

// Contr$$HEX1$$f400$$ENDHEX$$le des champs
bOk = IsNumber(asVal[1])

if bOk Then
	// Contr$$HEX1$$f400$$ENDHEX$$le d'existence
	If SQLCA.PS_V02_SIN( Dec(asVal[1]) ) = 0 Then
		asErreur="Ce sinistre n'existe pas"
		bOk=FALSE
	End if
Else
	asErreur += "L'identifiant sinistre n'est pas un nombre ! "
End if

Return bOk
end function

protected subroutine wf_trt_lst_sin ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trt_lst_sin
//* Auteur			: F. Pinon
//* Date				: 19/02/2010 11:03:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [DCMP100102]
//*
//* Arguments		: 
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	30/07/2010	[20100730.FPI] Utilisation d'une PS
//*-----------------------------------------------------------------

String sSql, sIdSin
Long lRow, lTotRow
n_cst_string nvstring

lTotRow = dw_charger.rowcount( )

hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lTotRow
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()

For lRow = 1 To lTotRow
	sIdSin=dw_charger.GetItemstring( lRow, "ID_SIN")
	sSql+=sIdSin + ","

	hpb_trt.Position = lRow
	wf_pct ()
	Yield ()		
Next

sSql=Left(sSql,Len(sSql) - 1)

//	[20100730.FPI]
//sSql=nvString.of_globalreplace( dw_charger.getsqlselect( ) , "id_sin = -1", "id_sin in (" + sSql + ")")
//dw_charger.setsqlselect( sSql)
dw_charger.SetTransObject( SQLCA)

//dw_charger.Retrieve()
dw_charger.Retrieve(sSql)
//	:[20100730.FPI]

dw_charger.saveas( stglb.sreptempo + "LST_SIN.XLS" ,Excel!, TRUE)

stMessage.sTitre		= "Traitement/Int$$HEX1$$e900$$ENDHEX$$gration autre fichier."
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!
stMessage.scode="GENE013"
stMessage.sVar[1] = "L'extraction est enregistr$$HEX1$$e900$$ENDHEX$$e dans le fichier " + stglb.sreptempo + "LST_SIN.XLS"
F_Message ( stMessage )

end subroutine

private function string wf_determiner_fic_btq (integer aitypfic);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_determiner_fic_btq
//* Auteur			: F. Pinon
//* Date				: 30/11/2010 14:51:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value integer aitypfic	 */
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	14/02/2012	[PM200][PSM] Int$$HEX1$$e900$$ENDHEX$$gration fichier btq PSM
//*-----------------------------------------------------------------
String sNomFic,sRepFic, sVal
Long lTotLig, lCpt

Choose Case aiTypFic
	Case 1 // MCM
		if gbOpcon Then
			sRepFic =  ProfileString(stglb.sfichierini, "GEST_COMMANDES","REP_FIC_BTQ","ERREUR")
		Else
			sRepFic =  stglb.sreptempo
		End if
	
		sNomFic = sRepFic + "magasins*.csv"
	Case 2 // PSM
		if gbOpcon Then
			sRepFic =  ProfileString(stglb.sfichierini, "GEST_COMMANDES","REP_GEN","ERREUR")
			
			sVal= ProfileString(stglb.sfichierini, "GEST_COMMANDES","REP_FIC_BTQ2","REF_BOUTIQUES")
			If Left(sVal,1) <> "\"	 and Right(sRepFic,1) <> "\" Then sRepFic+="\"
			
			sRepFic+="PSM" + "\" + sVal
			If Right(sRepFic,1) <> "\" Then sRepFic+="\"
		Else
			sRepFic =  stglb.sreptempo
		End if
	
		sNomFic = sRepFic + "PSM*.0*"
		
End Choose

if sRepFic="ERREUR" Then return ""
	
if right(sRepFic,1) <> "\" Then sRepFic +=  "\"
lb_filelist.Reset()
	
lb_filelist.DirList ( sNomFic, 0 )
	
lTotLig = lb_filelist.TotalItems ()
	
If lTotLig <=0 Then return ""

lb_filelist.SelectItem ( 1 )
sNomfic= sRepFic + lb_filelist.SelectedItem ( )

Return sNomFic
end function

private function long wf_charger_ficbtq (string asnomfic);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_charger_ficbtq
//* Auteur			: F. Pinon
//* Date				: 30/11/2010 16:05:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string asnomfic	 */
//*
//* Retourne		: long	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Long lTotRow, lPos
String sListeBoutiques, sVal
Integer iFic
Boolean bRet

sListeBoutiques=""

iFic = FileOpen ( asnomfic, LineMode!, Read!)

// On ne tient pas compte de la 1$$HEX1$$e800$$ENDHEX$$re ligne
FileRead ( iFic, sVal ) 

Do While FileRead ( iFic, sVal ) <> -100
	Do While Pos(sVal," ;") > 0 
		sVal = f_remplace(sVal," ;",";")
	Loop
	
	bRet=wf_ctrl_btq(sVal)
	If not bRet Then exit 
	
	sVal = f_remplace(sVal,";",char(9))
	sListeBoutiques +=sVal + CharA(10) 
Loop

FileClose ( iFic )	

if not bRet then return -1

lPos=Pos(Reverse(sListeBoutiques),Char(10) , 3)
lPos=Len(sListeBoutiques) - lPos

sListeBoutiques=Mid(sListeBoutiques,1,lPos)

Try
	lTotRow = dw_charger.ImportString( sListeBoutiques, sListeBoutiques)
	dw_charger.SetTransobject( SQLCA )
Catch (RuntimeError e)
	lTotRow=0
End try

Return lTotRow

end function

private function boolean wf_ctrl_btq (string slignebtq);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_ctrl_btq
//* Auteur			: F. Pinon
//* Date				: 01/12/2010 11:33:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PC175]
//*
//* Arguments		: value string slignebtq	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String sVal[]
n_cst_string uString
Long lTailleChamps[]={ 3, 11, 40,40,40,5, 40, 20} 
Int iIndex, lTailleTab
								
uString.of_parsetoarray( slignebtq , ";", sVal)

lTailleTab = UpperBound(sVal) 
If lTailleTab = 2 Then
	if sVal[1] = "99" Then 
		Return TRUE
	Else 
		Return FALSE
	end if
End if

If lTailleTab > 8 or lTailleTab < 7 Then Return FALSE

For iIndex=1 to lTailleTab 
	If Len(sVal[iIndex]) > lTailleChamps[iIndex] Then Return False
Next

Return TRUE
end function

private function boolean wf_trt_btq_mcm ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trt_btq_mcm
//* Auteur			: F. Pinon
//* Date				: 02/12/2010 10:14:21
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PC175]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	14/03/2011	[PC175.2] Suppression de boutiques
//*-----------------------------------------------------------------
Long lRow,lRet
Boolean bRet
Blob blBlob
String sNomFicRen,sListeCodeMag

// Remplissage de la colonne MAJ_PAR
For lRow=1 to dw_charger.Rowcount( )
	dw_charger.SetItem(lRow, "MAJ_PAR",stglb.scodoper)
//	sListeCodeMag+="'" + dw_charger.GetItemString(lRow,"CODE_MAG") + "',"
Next

wf_delete_btq_mcm( ) // [PC175.2]

// Mise $$HEX2$$e0002000$$ENDHEX$$jour
lRet = dw_charger.Update( )
bRet = (lRet = 1)

// Suppression des boutiques
/*if bRet Then
	sListeCodeMag=Left(sListeCodeMag,Len(sListeCodeMag) -1)
	SQLCA.PS_D01_BOUTIQUE_MCM( sListeCodeMag )
	
	bRet =(SQLCA.sqlcode = 0 And SQLCA.sqlDBcode =0)
End if
*/

if bRet Then 
	st_Charger.Text="Mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e"
	F_Commit ( SQLCA, True )
Else
	st_Charger.Text="Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour"
	F_Commit ( SQLCA, False )
End if

Return bRet



end function

private subroutine wf_opcon_btq_mcm ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_opcon_btq_mcm
//* Auteur			: F. Pinon
//* Date				: 02/12/2010 16:07:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	08/06/2011	[ITSM71141] On effectue la mise $$HEX2$$e0002000$$ENDHEX$$jour uniquement juste apr$$HEX1$$e800$$ENDHEX$$s la gen des commandes MCM
//*-----------------------------------------------------------------
Boolean bRet
Long lCount

// 	[ITSM71141]
Select COUNT(*) 
Into :lCount
from sysadm.commande 
where id_four='MCM' and id_lot_cmd=0
USING SQLCA;

If lCount <> 0 Then return

//:[ITSM71141]

dw_fourn.setItem(1,"ID_TT",K_TYPTRT_BTQ_MCM)

bRet = wf_chargerdonnees( )

if bRet Then bRet=wf_controler( )

if bRet Then bRet=wf_maj( )

wf_rename_file( bRet, K_TYPTRT_BTQ_MCM )

end subroutine

private subroutine wf_delete_btq_mcm ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_delete_btq_mcm
//* Auteur			: F. Pinon
//* Date				: 14/03/2011 14:07:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PC175.2]
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

Datastore dsMagMCM
Boolean bRet
Long lRow
String sCodMag, sEnseigne, sRech

bRet=TRUE

dsMagMCM=Create datastore
dsMagMCM.dataobject="d_stk_liste_btq_mcm"
dsMagMCM.SetTransobject( SQLCA )

If SQLCA.SQLCode <> 0 or SQLCA.SQLDBCode <> 0 Then bRet=FALSE

if bRet Then
	lRow=dsMagMCM.Retrieve()
	If SQLCA.SQLCode <> 0 or SQLCA.SQLDBCode <> 0 Then bRet=FALSE
End if


if bRet Then
	lRow=1
	Do While lRow < dsMagMCM.RowCount() +1
		sCodMag=dsMagMCM.GetItemString( lRow, "COD_MAG")
		sEnseigne=dsMagMCM.GetItemString( lRow, "ENSEIGNE")
		
		sRech="CODE_MAG='" + sCodMag + "' AND (Upper(ENSEIGNE)='" + Upper(sEnseigne) + "'"
		if Upper(sEnseigne) = "MICROMANIA" Then sRech +="or Upper(ENSEIGNE)='RECYCLEWARE'"
		sRech+=")"
		
		If dw_charger.Find(sRech,1,dw_charger.RowCount( )) = 0 Then
			dsMagMCM.deleterow( lRow)
		Else 
			lRow++
		End if

	Loop
End if

lRow=dsMagMCM.Update()

Destroy dsMagMCM
end subroutine

private function integer wf_sortie_opcon (string ascas, integer aicodeerreur, string astexte, boolean abbox);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_sortie_opcon
//* Auteur			: F. Pinon
//* Date				: 19/05/2011 15:59:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PC175]
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
		If f_FileExists ( isRepFicOpcon + K_FIC_SORTIE_OPCON ) Then // #1
//Fin Migration PB8-WYNIWYG-03/2006 CP
			
			If Not FileDelete ( isRepFicOpcon + K_FIC_SORTIE_OPCON ) Then // #1
				iRet = -1
			End If 
		End If 

	CASE "ECR"

		/*------------------------------------------------------------------*/
		/* On est connect$$HEX2$$e9002000$$ENDHEX$$avec OpCon, donc sortie en fichier Erreur.       */
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

	Case "FIN_TRT"
		iFicOpcon = FileOpen ( isRepFicOpCon + K_FICFINTRT, LineMode!, Write!, Shared!, Replace! )
		FileClose ( iFicOpcon )

END CHOOSE



Return iRet
end function

private function long wf_charger_ficbtq_psm (string asnomfic);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_charger_ficbtq
//* Auteur			: F. Pinon
//* Date				: 14/02/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PM200][PSM]
//*
//* Arguments		: value string asnomfic	 */
//*
//* Retourne		: long	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Long lTotRow, lPos
String sListeBoutiques, sVal
Integer iFic
Boolean bRet

sListeBoutiques=""

iFic = FileOpen ( asnomfic, LineMode!, Read!)

Do While FileRead ( iFic, sVal ) <> -100
	Do While Pos(sVal," ;") > 0 
		sVal = f_remplace(sVal," ;",";")
	Loop
	
	bRet=wf_ctrl_btq_psm(sVal)
	If not bRet Then exit 
	
	sVal = f_remplace(sVal,";",char(9))
	sListeBoutiques +=sVal + CharA(10) 
Loop

FileClose ( iFic )	

if not bRet then return -1

/*lPos=Pos(Reverse(sListeBoutiques),Char(10) , 3)
lPos=Len(sListeBoutiques) - lPos

sListeBoutiques=Mid(sListeBoutiques,1,lPos)*/

Try
	lTotRow = dw_charger.ImportString( sListeBoutiques, sListeBoutiques)
	dw_charger.SetTransobject( SQLCA )
Catch (RuntimeError e)
	lTotRow=0
End try

Return lTotRow

end function

private function boolean wf_ctrl_btq_psm (ref string slignebtq);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_ctrl_btq_psm
//* Auteur			: F. Pinon
//* Date				: 14/02/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PM200][PSM]
//*
//* Arguments		: value string slignebtq	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	13/12/2012	[CORR_BTQ_PSM] si pas de num tel alors le parse renvoie 6 col.
//			FPI	26/12/2014	[VDOC16118] Am$$HEX1$$e900$$ENDHEX$$lioration maj adresse
//			FPI	28/04/2016	[CORR_BTQ_PSM2] Correction du libell$$HEX2$$e9002000$$ENDHEX$$de PSM
//*-----------------------------------------------------------------

String sVal[]
n_cst_string uString
Long lTailleChamps[]={ 20, 35,81,5,35,250,20} 
Int iIndex, lTailleTab
String sResult=""
String sAdr1, sAdr2

uString.of_parsetoarray( slignebtq , ";", sVal)

lTailleTab = UpperBound(sVal) 

// [CORR_BTQ_PSM]
If lTailleTab = 6 Then
	sVal[7]=" "
	lTailleTab = 7
End if

If lTailleTab <> 7 Then Return FALSE

For iIndex=1 to lTailleTab 
	// [CORR_BTQ_PSM2]
	If iIndex=2 Then
		sVal[2] = uString.of_globalreplace( sVal[2],"Shop in shop PSM Welcom","PSM")
	End If

	If Len(sVal[iIndex]) > lTailleChamps[iIndex] Then Return False
		
	if iIndex=3 Then
		// Parse de l'adresse en 2
		// Suppr des caract$$HEX1$$e800$$ENDHEX$$res parasites
		sVal[iIndex] = uString.of_globalreplace( sVal[iIndex], "/","-", TRUE)
		sVal[iIndex] = uString.of_globalreplace( sVal[iIndex], "$$HEX1$$ca00$$ENDHEX$$","", TRUE)
		sVal[iIndex] = uString.of_globalreplace( sVal[iIndex], "$$HEX1$$7d01$$ENDHEX$$","$$HEX1$$e900$$ENDHEX$$", TRUE)
		sVal[iIndex] = uString.of_globalreplace( sVal[iIndex], "$$HEX1$$2221$$ENDHEX$$","$$HEX1$$f400$$ENDHEX$$", TRUE)
		
		sAdr1=sVal[iIndex]
		sAdr2=""
		
		// On tente la d$$HEX1$$e900$$ENDHEX$$coupe avec le -
		If Len(sAdr1) > 40 Then
			wf_decoupe_adr( sVal[iIndex], sadr1, sadr2, " - ")
		
			if sVal[iIndex] <> sadr1 + " - " + sadr2 Then
				// On tente l'abbreviation sur l'ensemble
				sAdr1=wf_abbr(sVal[iIndex],"Avenue","Av.")
				if Len(sAdr1) > 40 Then sAdr1=wf_abbr(sAdr1,"Boulevard","Bd")
				if Len(sAdr1) > 40 Then sAdr1=wf_abbr(sAdr1,"G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ral","Gal")
				if Len(sAdr1) > 40 Then sAdr1=wf_abbr(sAdr1,"General","Gal")
				if Len(sAdr1) > 40 Then sAdr1=wf_abbr(sAdr1,"Mar$$HEX1$$e900$$ENDHEX$$chal","Mal")
				if Len(sAdr1) > 40 Then sAdr1=wf_abbr(sAdr1,"Marechal","Mal")
			
				// Si NOK, on d$$HEX1$$e900$$ENDHEX$$coupe avec la virgule
				if Len(sAdr1) > 40 Then
					wf_decoupe_adr( sVal[iIndex], sadr1, sadr2, ", ")
				else
					sAdr2=""
				End if
			End if
			
		End if
		
		sResult+=sAdr1+ ";" + sAdr2 + ";"
	Else
		sResult+=sVal[iIndex] + ";"
	End if
Next


slignebtq = sResult 

Return TRUE
end function

protected subroutine wf_decoupe_adr (string asadresse, ref string asadr1, ref string asadr2, string asseparator);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_decoupe_adr
//* Auteur			: F. Pinon
//* Date				: 05/11/2009 16:46:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [EXPANSION5.BOUTIQUES]
//*
//* Arguments		: value string asadresse	 */
/* 	ref string asadr1	 */
/* 	ref string asadr2	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	15/02/2012	[PM200][PSM] Ajout du param$$HEX1$$e800$$ENDHEX$$tre asseparator
//			FPI	26/12/2014	[VDOC16118] Am$$HEX1$$e900$$ENDHEX$$lioration maj adresse
//*-----------------------------------------------------------------
Integer iPos, iLastPos

asAdr1=""
asAdr2=""

If Len(asAdresse) > 80 Then
	asAdr1=Left(asAdresse,40)
	asAdr2=Mid(asAdresse,41,40)
	Return
End if

If Len(asAdresse) < 41 Then 
	iPos = 0
Else 
	iPos=Pos(asAdresse,asSeparator)
End if

if iPos = 0 or iPos > 40 Then
	asAdr1=Left(asAdresse,40)
	asAdr2=Mid(asAdresse,41,40)
Else
	Do While iPos <= 41 and iPos > 0
		iLastPos = iPos
		iPos=Pos(asAdresse,asSeparator, iPos + 1 )  
	Loop
	
	asAdr1=Left(asAdresse,iLastPos - 1)
	asAdr2=Mid(asAdresse,iLastPos + Len(asSeparator) ,40) // [VDOC16118]
End if

asadr1=Trim(asadr1)
asadr2=Trim(asadr2)
end subroutine

private function boolean wf_trt_btq_psm ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trt_btq_psm
//* Auteur			: F. Pinon
//* Date				: 15/02/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PM200][PSM]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------
Long lRow,lRet
Boolean bRet

// Remplissage de la colonne MAJ_PAR
For lRow=1 to dw_charger.Rowcount( )
	dw_charger.SetItem(lRow, "MAJ_PAR",stglb.scodoper)
Next

//wf_delete_btq_mcm( ) // Suppression des boutiques ?

// Mise $$HEX2$$e0002000$$ENDHEX$$jour
lRet = dw_charger.Update( )
bRet = (lRet = 1)

if bRet Then 
	st_Charger.Text="Mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e"
	F_Commit ( SQLCA, True )
Else
	st_Charger.Text="Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour"
	
	if gbOpcon Then 
		wf_trace("ECR",SQLCA.Sqlerrtext)
	End if
	
	F_Commit ( SQLCA, False )
End if

Return bRet



end function

private subroutine wf_rename_file (boolean abok, integer aityptrt);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_rename_file
//* Auteur			: F. Pinon
//* Date				: 02/12/2010 17:01:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Renomme le fichier des boutques MCM selon son int$$HEX1$$e900$$ENDHEX$$gration/non
//* Commentaires	: [PC175]
//*
//* Arguments		: value boolean abok	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	15/02/2012	[PM200][PSM] Renommage selon type trt
//			FPI	17/05/2013	[PC938]
//			JFF   03/09/2013  [PC938_ORV3_FILERENAM]
//*-----------------------------------------------------------------

String sNomFicRen
Blob blBlob
Boolean bRet

If aiTyptrt=K_TYPTRT_IMEI_ORANGE Then isnomficbtq=isNomficimei //[PC938]

if isnull(isnomficbtq) Then return
if Len(Trim(isnomficbtq)) = 0  Then return

// Renommage du fichier
sNomFicRen  = Left ( isnomficbtq , Len ( isnomficbtq ) - 3 ) 
if abOK Then
	
	Choose Case aityptrt 
		Case K_TYPTRT_BTQ_MCM
			sNomFicRen +="ok"
		Case K_TYPTRT_BTQ_PSM, K_TYPTRT_IMEI_ORANGE //[PC938]
			sNomFicRen +="X" + Right(isnomficbtq,2)
	End Choose
Else
	sNomFicRen +="bad"
End if

// [PC938_ORV3_FILERENAM]
bRet = F_FileRename ( isnomficbtq, sNomFicRen )

end subroutine

private subroutine wf_opcon_btq_psm ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_opcon_btq_psm
//* Auteur			: F. Pinon
//* Date				: 15/02/2012 15:13:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PM200][PSM]
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

Boolean bRet

dw_fourn.setItem(1,"ID_TT",K_TYPTRT_BTQ_PSM)

bRet = wf_chargerdonnees( )

if bRet Then bRet=wf_controler( )

if bRet Then bRet=wf_maj( )

wf_rename_file( bRet, K_TYPTRT_BTQ_PSM )

end subroutine

private function boolean wf_controler_ct_client (ref string asvaleurs[], ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_ct_client
//* Auteur			: F. Pinon
//* Date				: 18/09/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [VDoc8686]
//*
//* Arguments		: ref string asvaleurs[]	 */
/* 	ref string aserreur	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

boolean bOk
Integer iResultat, iRet
Long lIdCli
String sErr

sErr=""

//Id_client
bOk = IsNumber(asValeurs[1]) Or IsNull(asValeurs[1])
if not bok then 
	asErreur += "Id_client n'est pas un nombre !"
Else 
	lIdCli = long(asValeurs[1])
End if

//Resultat
If bOk Then
	bOk = IsNumber(asValeurs[2]) Or IsNull(asValeurs[2])
	if not bok then 
		asErreur += "R$$HEX1$$e900$$ENDHEX$$sultat n'est pas un nombre !"
	Else 
		iResultat = integer(asValeurs[2])
	End if
End if

If bOk Then
	iRet = SQLCA.PS_Integrer_contact_client( lIdCli , iResultat, asValeurs[3], "V",   stglb.scodoper)
	
	If iRet <> 1 Then
		aserreur = "Client inexistant"
		bOk=FALSE
	End if
End if
	
Return bOk
end function

protected subroutine wf_trt_extr_vdoc9663 ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trt_Extr_vDoc9663
//* Auteur			: Fabry JF
//* Date				: 21/12/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [VDOC9663]
//*
//* Arguments		: 
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	30/07/2010	[20100730.FPI] Utilisation d'une PS
//*-----------------------------------------------------------------

String sSql, sIdSin
Long lRow, lTotRow
n_cst_string nvstring

lTotRow = dw_charger.rowcount( )

hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lTotRow
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()

For lRow = 1 To lTotRow
	sIdSin=dw_charger.GetItemstring( lRow, "ID_SIN")
	sSql+=sIdSin + ","

	hpb_trt.Position = lRow
	wf_pct ()
	Yield ()	
	
Next

sSql=Left(sSql,Len(sSql) - 1)

//	[20100730.FPI]
//sSql=nvString.of_globalreplace( dw_charger.getsqlselect( ) , "id_sin = -1", "id_sin in (" + sSql + ")")
//dw_charger.setsqlselect( sSql)
dw_charger.SetTransObject( SQLCA)

//dw_charger.Retrieve()
dw_charger.Retrieve(sSql)
//	:[20100730.FPI]

dw_charger.saveas( stglb.sreptempo + "EXTRACTION_VDOC9663.XLS" ,Excel!, TRUE)

stMessage.sTitre		= "Traitement/Int$$HEX1$$e900$$ENDHEX$$gration autre fichier."
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!
stMessage.scode="GENE013"
stMessage.sVar[1] = "L'extraction est enregistr$$HEX1$$e900$$ENDHEX$$e dans le fichier " + stglb.sreptempo + "EXTRACTION_VDOC9663.XLS"
F_Message ( stMessage )

end subroutine

protected function boolean wf_controler_ (ref string asval[], ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_lst_sin
//* Auteur			: F. Pinon
//* Date				: 19/02/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [DCMP100102]
//*
//* Arguments		: ref string asvaleur[]	 */
/* 	ref string aserreur	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Boolean bOk

// Contr$$HEX1$$f400$$ENDHEX$$le des champs
bOk = IsNumber(asVal[1])

if bOk Then
	// Contr$$HEX1$$f400$$ENDHEX$$le d'existence
	If SQLCA.PS_V02_SIN( Dec(asVal[1]) ) = 0 Then
		asErreur="Ce sinistre n'existe pas"
		bOk=FALSE
	End if
Else
	asErreur += "L'identifiant sinistre n'est pas un nombre ! "
End if

Return bOk
end function

private subroutine wf_opcon_imei_orange ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_opcon_imei_orange
//* Auteur			: F. Pinon
//* Date				:  17/05/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PC938]
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

Boolean bRet

wf_trace("INIT","")
wf_trace("ECR","Int$$HEX1$$e900$$ENDHEX$$gration des IMEI Orange V3")

dw_fourn.setItem(1,"ID_TT",K_TYPTRT_IMEI_ORANGE)

bRet = wf_chargerdonnees( )

if bRet Then wf_trace("ECR",String(dw_charger.RowCount()) + " lignes charg$$HEX1$$e900$$ENDHEX$$es")

if bRet Then bRet=wf_controler( )

if bRet Then bRet=wf_maj( )

if bRet Then 
	wf_trace("ECR","Mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e")
Else
	wf_trace("ECR","Echec de mise $$HEX2$$e0002000$$ENDHEX$$jour")
End if

wf_rename_file( bRet, K_TYPTRT_IMEI_ORANGE )

end subroutine

private function string wf_determiner_fic_imei ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_determiner_fic_imei
//* Auteur			: F. Pinon
//* Date				: 17/05/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------
String sNomFic,sRepFic, sVal
Long lTotLig, lCpt

if gbOpcon Then
	sRepFic =  ProfileString(stglb.sfichierini, "GEST_COMMANDES","REP_CRAO_ORANGEV3","ERREUR")
Else
	sRepFic =  stglb.sreptempo
End if

if sRepFic="ERREUR" Then return ""

if right(sRepFic,1) <> "\" Then sRepFic +=  "\"


sNomFic = sRepFic + "CTRLE_IMEI_*.txt"

lb_filelist.Reset()
	
lb_filelist.DirList ( sNomFic, 0 )
	
lTotLig = lb_filelist.TotalItems ()
	
If lTotLig <=0 Then return ""

lb_filelist.SelectItem ( 1 )
sNomfic= sRepFic + lb_filelist.SelectedItem ( )

Return sNomFic
end function

public function boolean wf_trt_imei_orange ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trt_imei_orange
//* Auteur			: F. Pinon
//* Date				: 17/05/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PC175]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 		FPI	20/06/2013	[20130620.FPI] Ajout ctl fichier IMEI Orange V3 Vide
//*-----------------------------------------------------------------
Long lRow,lRet
Boolean bRet
Blob blBlob
String sNomFicRen,sListeCodeMag

// [20130620.FPI]
If dw_charger.RowCount() = 0 Then
	st_Charger.Text="Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour : fichier vide"
	Return true
End if

SQLCA.PS_D01_imei_orangev3( )
If SQLCA.SQLCode <> 0 Or SQLCA.SQLDBCode <> 0 Then	 bRet = False

// Mise $$HEX2$$e0002000$$ENDHEX$$jour
lRet = dw_charger.Update( )
bRet = (lRet = 1)

if bRet Then 
	st_Charger.Text="Mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e"
	F_Commit ( SQLCA, True )
Else
	st_Charger.Text="Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour"
	F_Commit ( SQLCA, False )
End if

Return bRet



end function

private subroutine wf_opcon_boutique (string asidfour);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_opcon_boutique
//* Auteur			: F. Pinon
//* Date				: 18/09/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [VDOC12140]
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

Boolean bRet
Integer iTypeTrt

wf_trace("INIT","")
wf_trace("ECR","Int$$HEX1$$e900$$ENDHEX$$gration des boutiques " + asidfour)

Choose Case asIdFour
	Case "PSM"
		iTypeTrt=K_TYPTRT_BTQ_PSM
	Case "MCM"
		iTypeTrt=K_TYPTRT_BTQ_MCM
End Choose

dw_fourn.setItem(1,"ID_TT",iTypeTrt)

bRet = wf_chargerdonnees( )

if bRet Then wf_trace("ECR",String(dw_charger.RowCount()) + " boutiques charg$$HEX1$$e900$$ENDHEX$$es")

if bRet Then bRet=wf_controler( )

if bRet Then bRet=wf_maj( )

if bRet Then 
	wf_trace("ECR","Mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e")
Else
	wf_trace("ECR","Echec de mise $$HEX2$$e0002000$$ENDHEX$$jour")
End if

wf_rename_file( bRet, K_TYPTRT_BTQ_PSM )

end subroutine

public function integer wf_trace (string ascas, string astexte);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_autre_fichier::wf_Trace (PRIVATE)
//* Auteur			: FPI	
//* Date				: 26/09/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Trace des op$$HEX1$$e900$$ENDHEX$$rations
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

Int	iRet, iiFicTrc
String sRepFicLog, sMes
Long	lRow

sRepFicLog =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_GEN", "" )  + K_FICLOG
iRet = 1

CHOOSE CASE Upper ( asCas )

	CASE "INIT"
		iiFicTrc = FileOpen ( sRepFicLog, LineMode!, Write!, Shared!, Append! )

		If iiFicTrc <= 0 Then 
			iRet = -1
		Else
			sMes = Fill( "*", 80 )
			FileWrite ( iiFicTrc, sMes )
			FileClose ( iiFicTrc )
		End If

	CASE "ECR"

			iiFicTrc = FileOpen ( sRepFicLog, LineMode!, Write!, Shared!, Append! )

			sMes = String ( Today() ) + "~t" + String ( Now () ) + "~t" + Upper ( stGlb.sCodOper ) + "~t" + asTexte
			FileWrite ( iiFicTrc, sMes )
			FileClose ( iiFicTrc )

END CHOOSE



Return iRet
end function

protected function boolean wf_controler_format_cmde (ref string asval[], ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_lst_sin
//* Auteur			: F. Pinon
//* Date				: 19/02/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [DCMP100102]
//*
//* Arguments		: ref string asvaleur[]	 */
/* 	ref string aserreur	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Boolean bOk=TRUE
n_cst_string nvstring
String sValeurs[]

If isNull(asVal[1]) Then
	asErreur="Num$$HEX1$$e900$$ENDHEX$$ro de commande non renseign$$HEX1$$e900$$ENDHEX$$"
	bOk=FALSE
End if

If bOk Then
	nvString.of_parsetoarray( asVal[1], "-", sValeurs)
	if UpperBound(sValeurs) <> 2 Then
		asErreur="Num$$HEX1$$e900$$ENDHEX$$ro de commande invalide"
		bOk=FALSE
	End if
End if

// Contr$$HEX1$$f400$$ENDHEX$$le des champs
If bOk Then
	bOk = IsNumber(sValeurs[1])

	if bOk Then 	bOk = IsNumber(sValeurs[2])
	
	If not bOk then 
		asErreur="Num$$HEX1$$e900$$ENDHEX$$ro de commande invalide"
		bOk=FALSE
	End if
End if

Return bOk
end function

protected subroutine wf_trt_lst_cmd (integer aitrt);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trt_lst_cmd
//* Auteur			: F. Pinon
//* Date				: 14/01/2014
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [VDoc13194]
//*
//* Arguments		: 
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//			FPI		13/02/2017	 [VDOC23002]
//			FPI		21/02/2018	 [VDoc25758]
//*-----------------------------------------------------------------

String sIdSin, sFichier
String sSql[]
String sColName
Long lRow, lSql, lTotRow
n_cst_string nvstring

dw_charger.SetTransObject( SQLCA)
lTotRow = dw_charger.rowcount( )

lSql=1
sSql[lSql]=""

Choose case aiTrt
	Case K_TYPTRT_LST_CMDE_CDS 
		sFichier=stglb.sreptempo + "LST_CMDE_CDS.XLS"
		sColName="ID_SIN"
	Case K_TYPTRT_LST_CMDE_O2M
		sFichier=stglb.sreptempo + "LST_CMDE_O2M.XLS"
		sColName="ID_SIN"
	Case K_TYPTRT_LST_CMDE_CFM
		sFichier=stglb.sreptempo + "LST_CMDE_CFM.XLS"
		sColName="NUM_CARTE"
	Case K_TYPTRT_LST_RM
		sFichier=stglb.sreptempo + "LST_SIN_RM.XLS"
		sColName="ID_SIN"
	Case K_TYPTRT_LST_REG // [VDoc23002]
		sFichier=stglb.sreptempo + "LST_SIN_REG.XLS"
		sColName="ID_SIN"
	Case K_TYPTRT_LST_CMDE // [VDoc23962]
		sFichier=stglb.sreptempo + "LST_CMDE.XLS"
		sColName="n__dossier_sinistre_spb"
	Case K_TYPTRT_LST_CMDE_AUC // [VDoc25758]
		sFichier=stglb.sreptempo + "LST_CMDE_AUC.XLS"
		sColName="NUM_CARTE"
End Choose

hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lTotRow
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()

For lRow = 1 To lTotRow
	if Len(sSql[lSql]) > 7950 Then
		lSql+=1
		sSql[lSql]=""
	End if
	sIdSin=dw_charger.GetItemstring( lRow, sColName)
	sSql[lSql]+=sIdSin + ","
	
	hpb_trt.Position = lRow
	wf_pct ()
	Yield ()	
	
Next

sSql[lSql]=Left(sSql[lSql], Len(sSql[lSql]) - 1)

dw_charger.Reset()

hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lSql
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()

For lRow=1 To lSql
	dw_charger.Retrieve(sSql[lRow])
	hpb_trt.Position = lRow
	wf_pct ()
	Yield ()	
	
Next


dw_charger.saveas(  sFichier ,Excel!, TRUE)

stMessage.sTitre		= "Traitement/Int$$HEX1$$e900$$ENDHEX$$gration autre fichier."
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!
stMessage.scode="GENE013"
stMessage.sVar[1] = "L'extraction est enregistr$$HEX1$$e900$$ENDHEX$$e dans le fichier " + sFichier
F_Message ( stMessage )

end subroutine

private function boolean wf_controler_chps_oblig (ref string ascolnames[], ref string asvaleurs[], ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_chps_oblig
//* Auteur			: F.Pinon	
//* Date				: 27/01/2014 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Int$$HEX1$$e900$$ENDHEX$$gration des fichiers TAC_IMEI
//*
//* Arguments		: ref string ascolnames[]	 */
/* 	ref string asvaleurs[]	 */
/* 	ref string aserreur	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 FPI	 01/07/2009		Am$$HEX1$$e900$$ENDHEX$$lioration : on ne met que la premi$$HEX1$$e800$$ENDHEX$$re erreur
//*-----------------------------------------------------------------

n_cst_string uString
boolean bOK
long lPos

bOk=TRUE

For lPos=1 To UpperBound(asColNames)
	If uString.of_isempty(asValeurs[lPos]) Then
		bOk = FALSE
		asErreur += "La colonne " + asColNames[lPos] + " n'est pas renseign$$HEX1$$e900$$ENDHEX$$e ! "
		exit // #1 
	end if
Next
			
Return bOK
end function

public function boolean wf_trt_rm_avoir_fourn ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trt_rm_avoir_fourn
//* Auteur			: JFF
//* Date				: 28/01/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [VDOC12917]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 		FPI	20/06/2013	[20130620.FPI] Ajout ctl fichier IMEI Orange V3 Vide
//       JFF   09/09/2022 [PM80_FA12_FRANEX]
//*-----------------------------------------------------------------
Long lRow,lRet, lIdSin, lIdSeq, lTotRow, lCpt, lPos, lRetFinal
Boolean bRet
String sNomFicRen,sListeCodeMag, sVal, sLibRm, sResult, sIdFour
Decimal {2} dcMtAvoir


lTotRow = dw_charger.RowCount()

hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lTotRow
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()

bRet = True

cb_result.Enabled = TRUE

If lTotRow = 0 Then
	st_Charger.Text="Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour : fichier vide"
	Return true
End if

lRetFinal = 0 // Scucc$$HEX1$$e800$$ENDHEX$$s total

For lCpt = 1 To lTotRow

	sVal = dw_Charger.GetItemString ( lCpt, "ID_SIN_SEQ" )	

	lPos = Pos ( sVal, "-", 1 )
	lIdSin = Long ( Left ( sVal, lPos - 1 ) ) 
	lIdSeq = Long ( Right ( sVal, Len ( sVal ) - lPos ) ) 
	
	sIdFour = dw_Charger.GetItemString ( lCpt, "ID_FOUR" )	
	
	sVal = dw_Charger.GetItemString ( lCpt, "MT_AVOIR" )	

	dcMtAvoir = Dec ( sVal )
	
	sLibRm = dw_Charger.GetItemString ( lCpt, "LIB_RM" )	

	sResult = Fill ( " ", 255 )

	// [PM80_FA12_FRANEX]
	lRet = SQLCA.PS_I_RM_AVOIR_VDOC12917_V02 (lIdSin, lIdSeq, sIdFour, dcMtAvoir, sLibRM, stGlb.sCodOper, &
															Dec(dw_Charger.object.indem_princ_1[lCpt]),	&
															Dec(dw_Charger.object.frais_anex_2[lCpt]), 	& 
															Dec(dw_Charger.object.frais_anex_3[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_4[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_5[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_6[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_7[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_8[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_9[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_10[lCpt]),  & 
															Dec(dw_Charger.object.frais_anex_11[lCpt]),  & 		
															sResult )

	dw_Charger.SetItem ( lCpt, "RESULT_TRT", sResult )
	
	If lRet > 0 And lRetFinal <> 2 And lRetFinal <> -1 Then
		lRetFinal = 1
	End If 

	If ( lRet <= 0 And lRetFinal = 1 ) Or ( lRet > 0 And lRetFinal = -1 ) Then
		lRetFinal = 2
	End If 
	
	If lRet <= 0 And lRetFinal = 0 Then
		lRetFinal = -1
	End If 

	bRet = SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0  
	
	if bRet Then 
		F_Commit ( SQLCA, True )
	Else
		F_Commit ( SQLCA, False )
		Exit
	End if

	hpb_trt.Position = lCpt
	wf_pct ()
	Yield ()			
Next

If bRet then 
	If lRetFinal = 1 Then 
		// st_Charger.Text="Mise $$HEX2$$e0002000$$ENDHEX$$jour totale effectu$$HEX1$$e900$$ENDHEX$$e"
		st_extraire.BackColor = 32768
		st_extraire.TextColor = 16777215
		st_extraire.Text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour totale effectu$$HEX1$$e900$$ENDHEX$$e"
	End If
	
	If lRetFinal = 2 Then 
		// st_Charger.Text="Mise $$HEX2$$e0002000$$ENDHEX$$jour partielle effectu$$HEX1$$e900$$ENDHEX$$e"
		st_extraire.BackColor = 255
		st_extraire.TextColor = 16777215		
		st_extraire.Text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour partielle effectu$$HEX1$$e900$$ENDHEX$$e, consultez les r$$HEX1$$e900$$ENDHEX$$sultats de chaque ligne"
	End If
	
	If lRetFinal = -1 Then 
		// st_Charger.Text="Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e"
		st_extraire.BackColor = 255
		st_extraire.TextColor = 16777215		
		st_extraire.Text = "Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e, consultez les r$$HEX1$$e900$$ENDHEX$$sultats de chaque ligne"
	End If
Else 
	// st_Charger.Text="Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour en base, arr$$HEX1$$ea00$$ENDHEX$$t de traitement ligne " + String ( lCpt )
	dw_Charger.SetItem ( lCpt, "RESULT_TRT", st_Charger.Text )
	st_extraire.BackColor = 255
	st_extraire.TextColor = 16777215		
	st_extraire.Text = "Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour en base, arr$$HEX1$$ea00$$ENDHEX$$t de traitement ligne " + String ( lCpt )
End If 

cb_result.Event Clicked ()

Return bRet



end function

protected function string wf_abbr (string asadresse, string asvaleur, string asabbrev);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_abbr
//* Auteur			: F. Pinon
//* Date				: 26/12/2014
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [VDOC16118]
//*
//* Arguments		: value string asadresse	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------
String sRet
n_cst_string nvString

sRet=nvString.of_globalreplace( asAdresse, asValeur, asAbbrev)
sRet=nvString.of_globalreplace( sRet, Lower(asValeur), Lower(asAbbrev) )
sRet=nvString.of_globalreplace( sRet, Upper(asValeur), Upper(asAbbrev) )
sRet=nvString.of_globalreplace( sRet, Upper(Left(asValeur,1)) + Mid(asValeur,2,100), Upper(Left(asAbbrev,1)) + Mid(asAbbrev,2,100) )
sRet=nvString.of_globalreplace( sRet, Lower(Left(asValeur,1)) + Mid(asValeur,2,100), Lower(Left(asAbbrev,1)) + Mid(asAbbrev,2,100) )

Return sRet
end function

public subroutine wf_trt_lstsinreg ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trt_lstsinreg
//* Auteur			: F. Pinon
//* Date				: 22/09/2016
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [VDOC21846]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

long lRow, lTotRow
decimal dcIdSin, dcIdReg

lTotRow = ids_charger.RowCount()

hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lTotRow
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()

dw_charger.dataobject="d_trt_vdoc21811"
dw_charger.SetTransObject(SQLCA)

dw_charger.Reset()

For lRow=1 to lTotRow
	dcIdSin = dec(ids_charger.GetItemString(lRow,"ID_SIN"))
	dcIdReg = dec(ids_charger.GetItemString(lRow,"ID_REG"))
	
	dw_charger.Retrieve( dcIdSin, dcIdreg, lRow)
	

	hpb_trt.Position = lRow
	wf_pct ()
	Yield ()		
Next

cb_result.enabled=TRUE
end subroutine

protected function boolean wf_controler_lstsinreg (ref string asval[], ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_lstsinreg
//* Auteur			: F. Pinon
//* Date				: 22/09/2016
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	:[VDOC21846]
//*
//* Arguments		: ref string asvaleur[]	 */
/* 	ref string aserreur	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Boolean bOk

// Contr$$HEX1$$f400$$ENDHEX$$le des champs
bOk = IsNumber(asVal[1])

if bOk Then
	// Contr$$HEX1$$f400$$ENDHEX$$le d'existence
	If SQLCA.PS_V02_SIN( Dec(asVal[1]) ) = 0 Then
		asErreur="Ce sinistre n'existe pas"
		bOk=FALSE
	End if
Else
	asErreur += "L'identifiant sinistre n'est pas un nombre ! "
End if

if bOk and not IsNumber(asVal[2]) Then
	asErreur += "Le num$$HEX1$$e900$$ENDHEX$$ro de r$$HEX1$$e800$$ENDHEX$$glement n'est pas un nombre ! "
	bOk=FALSE
End if

Return bOk
end function

public function boolean wf_trt_rp_avoir_fourn ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trt_rp_avoir_fourn
//* Auteur			: JFF
//* Date				: 30/11/2016
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [VDOC12917]// [PM375-1]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 		FPI	20/06/2013	[20130620.FPI] Ajout ctl fichier IMEI Orange V3 Vide
//       JFF   09/09/2022  [PM80_FA12_FRANEX]
//*-----------------------------------------------------------------
Long lRow,lRet, lIdSin, lIdSeq, lTotRow, lCpt, lPos, lRetFinal
Boolean bRet
String sNomFicRen,sListeCodeMag, sVal, sLibRP, sResult, sIdFour
Decimal {2} dcMtAvoir

lTotRow = dw_charger.RowCount()

hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lTotRow
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()

bRet = True

cb_result.Enabled = TRUE

If lTotRow = 0 Then
	st_Charger.Text="Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour : fichier vide"
	Return true
End if

lRetFinal = 0 // Scucc$$HEX1$$e800$$ENDHEX$$s total

For lCpt = 1 To lTotRow

	sVal = dw_Charger.GetItemString ( lCpt, "ID_SIN_SEQ" )	

	lPos = Pos ( sVal, "-", 1 )
	lIdSin = Long ( Left ( sVal, lPos - 1 ) ) 
	lIdSeq = Long ( Right ( sVal, Len ( sVal ) - lPos ) ) 
	
	sIdFour = dw_Charger.GetItemString ( lCpt, "ID_FOUR" )	
	
	sVal = dw_Charger.GetItemString ( lCpt, "MT_AVOIR" )	

	dcMtAvoir = Dec ( sVal )
	
	sLibRP = dw_Charger.GetItemString ( lCpt, "LIB_RP" )	

	sResult = Fill ( " ", 255 )
	// [PM80_FA12_FRANEX]
	lRet = SQLCA.PS_I_RP_AVOIR_PM375_V01 (lIdSin, lIdSeq, sIdFour, dcMtAvoir, sLibRP, stGlb.sCodOper, &
															Dec(dw_Charger.object.indem_princ_1[lCpt]),	&
															Dec(dw_Charger.object.frais_anex_2[lCpt]), 	& 
															Dec(dw_Charger.object.frais_anex_3[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_4[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_5[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_6[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_7[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_8[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_9[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_10[lCpt]),  & 
															Dec(dw_Charger.object.frais_anex_11[lCpt]),  & 		
															sResult )

	dw_Charger.SetItem ( lCpt, "RESULT_TRT", sResult )
	
	If lRet > 0 And lRetFinal <> 2 And lRetFinal <> -1 Then
		lRetFinal = 1
	End If 

	If ( lRet <= 0 And lRetFinal = 1 ) Or ( lRet > 0 And lRetFinal = -1 ) Then
		lRetFinal = 2
	End If 
	
	If lRet <= 0 And lRetFinal = 0 Then
		lRetFinal = -1
	End If 

	bRet = SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0  
	
	if bRet Then 
		F_Commit ( SQLCA, True )
	Else
		F_Commit ( SQLCA, False )
		Exit
	End if

	hpb_trt.Position = lCpt
	wf_pct ()
	Yield ()			
	
Next

If bRet then 
	If lRetFinal = 1 Then 
		// st_Charger.Text="Mise $$HEX2$$e0002000$$ENDHEX$$jour totale effectu$$HEX1$$e900$$ENDHEX$$e"
		st_extraire.BackColor = 32768
		st_extraire.TextColor = 16777215
		st_extraire.Text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour totale effectu$$HEX1$$e900$$ENDHEX$$e"
	End If
	
	If lRetFinal = 2 Then 
		// st_Charger.Text="Mise $$HEX2$$e0002000$$ENDHEX$$jour partielle effectu$$HEX1$$e900$$ENDHEX$$e"
		st_extraire.BackColor = 255
		st_extraire.TextColor = 16777215		
		st_extraire.Text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour partielle effectu$$HEX1$$e900$$ENDHEX$$e, consultez les r$$HEX1$$e900$$ENDHEX$$sultats de chaque ligne"
	End If
	
	If lRetFinal = -1 Then 
		// st_Charger.Text="Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e"
		st_extraire.BackColor = 255
		st_extraire.TextColor = 16777215		
		st_extraire.Text = "Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e, consultez les r$$HEX1$$e900$$ENDHEX$$sultats de chaque ligne"
	End If
Else 
	// st_Charger.Text="Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour en base, arr$$HEX1$$ea00$$ENDHEX$$t de traitement ligne " + String ( lCpt )
	dw_Charger.SetItem ( lCpt, "RESULT_TRT", st_Charger.Text )
	st_extraire.BackColor = 255
	st_extraire.TextColor = 16777215		
	st_extraire.Text = "Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour en base, arr$$HEX1$$ea00$$ENDHEX$$t de traitement ligne " + String ( lCpt )
End If 
cb_result.Event Clicked ()

Return bRet



end function

public function boolean wf_trt_rm_simple ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trt_rm_simple
//* Auteur			: JFF
//* Date				: 30/11/2016
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [VDOC12917][PM375-1]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 		FPI	20/06/2013	[20130620.FPI] Ajout ctl fichier IMEI Orange V3 Vide
//       JFF   09/09/2022  [PM80_FA12_FRANEX]
//*-----------------------------------------------------------------
Long lRow,lRet, lIdSin, lIdSeq, lTotRow, lCpt, lPos, lRetFinal, lIdRegBase
Boolean bRet
String sNomFicRen,sListeCodeMag, sVal, sLibRm, sResult, sIdFour
Decimal {2} dcMtRM


lTotRow = dw_charger.RowCount()

hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lTotRow
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()

bRet = True

cb_result.Enabled = TRUE

If lTotRow = 0 Then
	st_Charger.Text="Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour : fichier vide"
	Return true
End if

lRetFinal = 0 // Scucc$$HEX1$$e800$$ENDHEX$$s total

For lCpt = 1 To lTotRow

	sVal = dw_Charger.GetItemString ( lCpt, "ID_SIN" )	

	lIdSin = Long ( sVal ) 

	sVal = dw_Charger.GetItemString ( lCpt, "ID_REG_BASE" )	
	
	lIdRegBase = Long ( sVal ) 
	
	sVal = dw_Charger.GetItemString ( lCpt, "MT_RM" )	

	dcMtRM = Dec ( sVal )
	
	sLibRm = dw_Charger.GetItemString ( lCpt, "LIB_RM" )	

	sResult = Fill ( " ", 255 )
	
	// [PM80_FA12_FRANEX]
	lRet = SQLCA.PS_I_RM_SIMPLE_PM375_V01 (lIdSin, lIdRegBase, dcMtRM, sLibRM, stGlb.sCodOper, &
															Dec(dw_Charger.object.indem_princ_1[lCpt]),	&
															Dec(dw_Charger.object.frais_anex_2[lCpt]), 	& 
															Dec(dw_Charger.object.frais_anex_3[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_4[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_5[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_6[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_7[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_8[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_9[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_10[lCpt]),  & 
															Dec(dw_Charger.object.frais_anex_11[lCpt]),  & 		
															sResult )

	dw_Charger.SetItem ( lCpt, "RESULT_TRT", sResult )
	
	If lRet > 0 And lRetFinal <> 2 And lRetFinal <> -1 Then
		lRetFinal = 1
	End If 

	If ( lRet <= 0 And lRetFinal = 1 ) Or ( lRet > 0 And lRetFinal = -1 ) Then
		lRetFinal = 2
	End If 
	
	If lRet <= 0 And lRetFinal = 0 Then
		lRetFinal = -1
	End If 

	bRet = SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0  
	
	if bRet Then 
		F_Commit ( SQLCA, True )
	Else
		F_Commit ( SQLCA, False )
		Exit
	End if

	hpb_trt.Position = lCpt
	wf_pct ()
	Yield ()		
		
Next

If bRet then 
	If lRetFinal = 1 Then 
		// st_Charger.Text="Mise $$HEX2$$e0002000$$ENDHEX$$jour totale effectu$$HEX1$$e900$$ENDHEX$$e"
		st_extraire.BackColor = 32768
		st_extraire.TextColor = 16777215
		st_extraire.Text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour totale effectu$$HEX1$$e900$$ENDHEX$$e"
	End If
	
	If lRetFinal = 2 Then 
		// st_Charger.Text="Mise $$HEX2$$e0002000$$ENDHEX$$jour partielle effectu$$HEX1$$e900$$ENDHEX$$e"
		st_extraire.BackColor = 255
		st_extraire.TextColor = 16777215		
		st_extraire.Text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour partielle effectu$$HEX1$$e900$$ENDHEX$$e, consultez les r$$HEX1$$e900$$ENDHEX$$sultats de chaque ligne"
	End If
	
	If lRetFinal = -1 Then 
		// st_Charger.Text="Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e"
		st_extraire.BackColor = 255
		st_extraire.TextColor = 16777215		
		st_extraire.Text = "Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e, consultez les r$$HEX1$$e900$$ENDHEX$$sultats de chaque ligne"
	End If
Else 
	// st_Charger.Text="Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour en base, arr$$HEX1$$ea00$$ENDHEX$$t de traitement ligne " + String ( lCpt )
	dw_Charger.SetItem ( lCpt, "RESULT_TRT", st_Charger.Text )
	st_extraire.BackColor = 255
	st_extraire.TextColor = 16777215		
	st_extraire.Text = "Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour en base, arr$$HEX1$$ea00$$ENDHEX$$t de traitement ligne " + String ( lCpt )
End If 

cb_result.Event Clicked ()

Return bRet



end function

public function boolean wf_trt_rp_simple ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trt_rp_simple
//* Auteur			: JFF
//* Date				: 30/11/2016
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [VDOC12917][PM375-1]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 		FPI	20/06/2013	[20130620.FPI] Ajout ctl fichier IMEI Orange V3 Vide
//*-----------------------------------------------------------------

Long lRow,lRet, lIdSin, lIdSeq, lTotRow, lCpt, lPos, lRetFinal, lIdRegBase
Boolean bRet
String sNomFicRen,sListeCodeMag, sVal, sLibRP, sResult, sIdFour
Decimal {2} dcMtRP

lTotRow = dw_charger.RowCount()

hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lTotRow
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()


bRet = True

cb_result.Enabled = TRUE

If lTotRow = 0 Then
	st_Charger.Text="Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour : fichier vide"
	Return true
End if


lRetFinal = 0 // Scucc$$HEX1$$e800$$ENDHEX$$s total

For lCpt = 1 To lTotRow

	sVal = dw_Charger.GetItemString ( lCpt, "ID_SIN" )	

	lIdSin = Long ( sVal ) 

	sVal = dw_Charger.GetItemString ( lCpt, "ID_REG_BASE" )	
	
	lIdRegBase = Long ( sVal ) 
	
	sVal = dw_Charger.GetItemString ( lCpt, "MT_RP" )	

	dcMtRP = Dec ( sVal )
	
	sLibRP = dw_Charger.GetItemString ( lCpt, "LIB_RP" )	

	sResult = Fill ( " ", 255 )
	
	// [PM80_FA12_FRANEX]
	lRet = SQLCA.PS_I_RP_SIMPLE_PM375_V01 (lIdSin, lIdRegBase, dcMtRP, sLibRP, stGlb.sCodOper, &
															Dec(dw_Charger.object.indem_princ_1[lCpt]),	&
															Dec(dw_Charger.object.frais_anex_2[lCpt]), 	& 
															Dec(dw_Charger.object.frais_anex_3[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_4[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_5[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_6[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_7[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_8[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_9[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_10[lCpt]),  & 
															Dec(dw_Charger.object.frais_anex_11[lCpt]),  & 		
															sResult )


	dw_Charger.SetItem ( lCpt, "RESULT_TRT", sResult )
	
	If lRet > 0 And lRetFinal <> 2 And lRetFinal <> -1 Then
		lRetFinal = 1
	End If 

	If ( lRet <= 0 And lRetFinal = 1 ) Or ( lRet > 0 And lRetFinal = -1 ) Then
		lRetFinal = 2
	End If 
	
	If lRet <= 0 And lRetFinal = 0 Then
		lRetFinal = -1
	End If 

	bRet = SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0  
	
	if bRet Then 
		F_Commit ( SQLCA, True )
	Else
		F_Commit ( SQLCA, False )
		Exit
	End if

	hpb_trt.Position = lCpt
	wf_pct ()
	Yield ()		
		
Next

If bRet then 
	If lRetFinal = 1 Then 
		// st_Charger.Text="Mise $$HEX2$$e0002000$$ENDHEX$$jour totale effectu$$HEX1$$e900$$ENDHEX$$e"
		st_extraire.BackColor = 32768
		st_extraire.TextColor = 16777215
		st_extraire.Text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour totale effectu$$HEX1$$e900$$ENDHEX$$e"
	End If
	
	If lRetFinal = 2 Then 
		// st_Charger.Text="Mise $$HEX2$$e0002000$$ENDHEX$$jour partielle effectu$$HEX1$$e900$$ENDHEX$$e"
		st_extraire.BackColor = 255
		st_extraire.TextColor = 16777215		
		st_extraire.Text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour partielle effectu$$HEX1$$e900$$ENDHEX$$e, consultez les r$$HEX1$$e900$$ENDHEX$$sultats de chaque ligne"
	End If
	
	If lRetFinal = -1 Then 
		// st_Charger.Text="Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e"
		st_extraire.BackColor = 255
		st_extraire.TextColor = 16777215		
		st_extraire.Text = "Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e, consultez les r$$HEX1$$e900$$ENDHEX$$sultats de chaque ligne"
	End If
Else 
	// st_Charger.Text="Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour en base, arr$$HEX1$$ea00$$ENDHEX$$t de traitement ligne " + String ( lCpt )
	dw_Charger.SetItem ( lCpt, "RESULT_TRT", st_Charger.Text )
	st_extraire.BackColor = 255
	st_extraire.TextColor = 16777215		
	st_extraire.Text = "Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour en base, arr$$HEX1$$ea00$$ENDHEX$$t de traitement ligne " + String ( lCpt )
End If 
cb_result.Event Clicked ()


Return bRet



end function

public function boolean wf_trt_rn_frais_factu ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trt_rn_Frais_Factu
//* Auteur			: JFF
//* Date				: 30/11/2016
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [VDOC12917][PM375-1]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 		FPI	20/06/2013	[20130620.FPI] Ajout ctl fichier IMEI Orange V3 Vide
//*-----------------------------------------------------------------
Long lRow,lRet, lIdSin, lIdSeq, lTotRow, lCpt, lPos, lRetFinal, lIdRegBase
Boolean bRet
String sNomFicRen,sListeCodeMag, sVal, sLibRN, sResult, sIdFourFct
Decimal {2} dcMtRN

lTotRow = dw_charger.RowCount()

hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lTotRow
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()

bRet = True

cb_result.Enabled = TRUE

If lTotRow = 0 Then
	st_Charger.Text="Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour : fichier vide"
	Return true
End if

lRetFinal = 0 // Scucc$$HEX1$$e800$$ENDHEX$$s total

For lCpt = 1 To lTotRow

	sVal = dw_Charger.GetItemString ( lCpt, "ID_SIN" )	

	lIdSin = Long ( sVal ) 

	sVal = dw_Charger.GetItemString ( lCpt, "MT_RN" )	

	dcMtRN = Dec ( sVal )
	
	sLibRN = dw_Charger.GetItemString ( lCpt, "LIB_RN" )	

	sIdFourFct = dw_Charger.GetItemString ( lCpt, "ID_FOUR_FCT" )	


	sResult = Fill ( " ", 255 )
	// [PM80_FA12_FRANEX]
	lRet = SQLCA.PS_I_RN_FRAIS_FACTU_PM375_V01 (lIdSin, dcMtRN, sLibRN, sIdFourFct, stGlb.sCodOper, &
															Dec(dw_Charger.object.indem_princ_1[lCpt]),	&
															Dec(dw_Charger.object.frais_anex_2[lCpt]), 	& 
															Dec(dw_Charger.object.frais_anex_3[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_4[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_5[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_6[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_7[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_8[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_9[lCpt]), 	&  
															Dec(dw_Charger.object.frais_anex_10[lCpt]),  & 
															Dec(dw_Charger.object.frais_anex_11[lCpt]),  & 		
															sResult )

	dw_Charger.SetItem ( lCpt, "RESULT_TRT", sResult )
	
	If lRet > 0 And lRetFinal <> 2 And lRetFinal <> -1 Then
		lRetFinal = 1
	End If 

	If ( lRet <= 0 And lRetFinal = 1 ) Or ( lRet > 0 And lRetFinal = -1 ) Then
		lRetFinal = 2
	End If 
	
	If lRet <= 0 And lRetFinal = 0 Then
		lRetFinal = -1
	End If 

	bRet = SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0  

	If lRet = -2 Then
		lRetFinal = -1
		bRet = False
	End If 
	
	if bRet Then 
		F_Commit ( SQLCA, True )
	Else
		F_Commit ( SQLCA, False )
		Exit
	End if

	hpb_trt.Position = lCpt
	wf_pct ()
	Yield ()		
		
Next

If bRet then 
	If lRetFinal = 1 Then 
		// st_Charger.Text="Mise $$HEX2$$e0002000$$ENDHEX$$jour totale effectu$$HEX1$$e900$$ENDHEX$$e"
		st_extraire.BackColor = 32768
		st_extraire.TextColor = 16777215
		st_extraire.Text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour totale effectu$$HEX1$$e900$$ENDHEX$$e"
	End If
	
	If lRetFinal = 2 Then 
		// st_Charger.Text="Mise $$HEX2$$e0002000$$ENDHEX$$jour partielle effectu$$HEX1$$e900$$ENDHEX$$e"
		st_extraire.BackColor = 255
		st_extraire.TextColor = 16777215		
		st_extraire.Text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour partielle effectu$$HEX1$$e900$$ENDHEX$$e, consultez les r$$HEX1$$e900$$ENDHEX$$sultats de chaque ligne"
	End If
	
	If lRetFinal = -1 Then 
		// st_Charger.Text="Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e"
		st_extraire.BackColor = 255
		st_extraire.TextColor = 16777215		
		st_extraire.Text = "Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e, consultez les r$$HEX1$$e900$$ENDHEX$$sultats de chaque ligne"
	End If
Else 
	// st_Charger.Text="Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour en base, arr$$HEX1$$ea00$$ENDHEX$$t de traitement ligne " + String ( lCpt )
	dw_Charger.SetItem ( lCpt, "RESULT_TRT", st_Charger.Text )
	st_extraire.BackColor = 255
	st_extraire.TextColor = 16777215		
	st_extraire.Text = "Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour en base, arr$$HEX1$$ea00$$ENDHEX$$t de traitement ligne " + String ( lCpt )
End If 
cb_result.Event Clicked ()

Return bRet



end function

protected subroutine wf_trt_lst_reg (integer aitrt);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trt_lst_reg
//* Auteur			: F. Pinon
//* Date				: 08/03/2017
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [VDoc23002]
//*					  Nombre de colonnes dynamiques
//*
//* Arguments		: 
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

String sIdSin, sFichier
String sSql[]
String sColName, sline, sDwFinal, sDwName
Long lRow, lSql, lCol, lRow2, lTmp, lTotRow
n_cst_string nvstring
int inbColMax, inbCol
int nbColToCreate, nbColOrig
string  sDwSyntax[]
String sdwSyntax2[]

lSql=1
sSql[lSql]=""
sLine=char(13)
lTotRow = dw_charger.rowcount( )

Choose case aiTrt
	Case K_TYPTRT_LST_REG 
		sFichier=stglb.sreptempo + "LST_SIN_REG.XLS"
		sColName="ID_SIN"
		nbColToCreate=5 // Nb de colonnes $$HEX2$$e0002000$$ENDHEX$$dupliquer
		nbColOrig=6 // Nb max de groupe de r$$HEX1$$e900$$ENDHEX$$sultats dans la dw actuelle
		sDwName="d_trt_vdoc23002"
End Choose

hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lTotRow
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()

// Groupe de n$$HEX2$$b0002000$$ENDHEX$$de dossiers
For lRow = 1 To lTotRow
	if Len(sSql[lSql]) > 7950 Then
		lSql+=1
		sSql[lSql]=""
	End if
	sIdSin=dw_charger.GetItemstring( lRow, sColName)
	sSql[lSql]+=sIdSin + ","

	hpb_trt.Position = lRow
	wf_pct ()
	Yield ()		
Next

sSql[lSql]=Left(sSql[lSql], Len(sSql[lSql]) - 1)

// Barre de progression
hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lSql
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()


// D$$HEX1$$e900$$ENDHEX$$termination du nb de groupe de r$$HEX1$$e900$$ENDHEX$$sultats max
iNbColMax=nbColOrig
For lRow=1 To lSql
	iNbCol=SQLCA.DW_S_vdoc23002_nbcol( sSql[lRow])
	if iNbColMax < iNbCol Then iNbColMax = iNbCol 

	hpb_trt.Position = lRow
	wf_pct ()
	Yield ()	
	
Next

dw_charger.DataObject=sDwName

// Cr$$HEX1$$e900$$ENDHEX$$ation des colonnes suppl$$HEX1$$e900$$ENDHEX$$mentaire
if iNbColMax > nbColOrig Then

	// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du source de la dw
	nvString.of_parsetoarray(dw_charger.Describe("DataWindow.Syntax"),sline,sDwSyntax)
	
	// Copie jusqu'$$HEX2$$e0002000$$ENDHEX$$la fin de d$$HEX1$$e900$$ENDHEX$$finition des colonnes
	lRow=1
	Do
		sDwSyntax2[lRow]=sDwSyntax[lRow]
		lRow+=1
	loop while Pos(Upper(sDwSyntax[lRow]),"PROCEDURE") <= 0
 	
    lRow=lRow - 1
	 
	If aiTrt=K_TYPTRT_LST_REG Then 
		sDwSyntax2[lRow]=""
		lRow=lRow -1
	End if
	
	// Cr$$HEX1$$e900$$ENDHEX$$ation des colonnes suppl$$HEX1$$e900$$ENDHEX$$mentaires _xx
	For lRow2=nbColOrig+1 to iNbColMax 
		For lCol=nbColToCreate to 1 Step -1
			lTmp=UpperBound(sDwSyntax2) + 1
			sDwSyntax2[lTmp]=sDwSyntax[lRow - lCol+1]
			sDwSyntax2[lTmp]=nvString.of_globalreplace( sDwSyntax2[lTmp], "_" + String(nbColOrig), "_" + String(lRow2))
		Next
	Next
	
	// Copie des lignes restantes
	lRow+=1
	Do While lRow <=UpperBound(sDwSyntax)
		sDwSyntax2[UpperBound(sDwSyntax2) + 1]=sDwSyntax[lRow]
		lRow+=1
	Loop
	
	// Cr$$HEX1$$e900$$ENDHEX$$ation de la syntaxe de dw finale
	sDwFinal=""
	For lRow=1 To UpperBound(sDwSyntax2)
		if Pos(sDwSyntax2[lRow] ,"name=cout_sinistre") > 0 And aiTrt = K_TYPTRT_LST_REG Then
			sDwSyntax2[lRow]=nvString.Of_globalreplace(sDwSyntax2[lRow],"id=35","id=" + string(35 + ((iNbColMax - nbColOrig) * nbColToCreate)))
		End if
		sDwFinal+=sDwSyntax2[lRow] + sLine
	Next
	
	// Cr$$HEX1$$e900$$ENDHEX$$ation de la dw
	dw_Charger.create( sDwFinal)

End if

dw_charger.SetTransObject( SQLCA)
dw_charger.Reset()

hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lSql
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()


// Retrieve
For lRow=1 To lSql
	hpb_trt.Position = lRow
	wf_pct ()
	Yield ()	
	dw_charger.Retrieve(sSql[lRow],inbColMax )
Next

hpb_trt.Position=0

dw_charger.saveas(  sFichier ,Excel!, TRUE)

stMessage.sTitre		= "Traitement/Int$$HEX1$$e900$$ENDHEX$$gration autre fichier."
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!
stMessage.scode="GENE013"
stMessage.sVar[1] = "L'extraction est enregistr$$HEX1$$e900$$ENDHEX$$e dans le fichier " + sFichier
F_Message ( stMessage )

end subroutine

public function boolean wf_trt_retour_pm02 ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trt_retour_PM02
//* Auteur			: JFF
//* Date				: 25/05/2019
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PM378-1]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*
//*-----------------------------------------------------------------
Long lRow,lRet, lIdSin, lIdSeq, lTotRow, lCpt, lPos, lRetFinal, lIdCum, lIdTrt, lIdPeriode
Boolean bRet
String sVal, sResult, sAccordBrk, sCommentBrk, sCommentSPB
Decimal {2} dcMtFactTtcModifBrk, dcMtFactTtcForceSPB

lTotRow= dw_charger.RowCount()

hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lTotRow
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()

bRet = True

cb_result.Enabled = TRUE

If lTotRow = 0 Then
	st_Charger.Text="Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour : fichier vide"
	Return true
End if

lRetFinal = 0 // Scucc$$HEX1$$e800$$ENDHEX$$s total

For lCpt = 1 To lTotRow

	sVal = dw_Charger.GetItemString ( lCpt, "ID_CUM" )	
	lIdCum = Long ( sVal ) 

	sVal = dw_Charger.GetItemString ( lCpt, "ID_TRT" )	
	lIdTrt = Long ( sVal ) 

	sVal = dw_Charger.GetItemString ( lCpt, "ID_PERIODE" )	
	lIdPeriode = Long ( sVal ) 

	sVal = dw_Charger.GetItemString ( lCpt, "ID_SIN" )	
	lIdSin = Long ( sVal ) 

	sVal = dw_Charger.GetItemString ( lCpt, "ID_SEQ" )	
	lIdSeq = Long ( sVal ) 

	sVal = Trim ( dw_Charger.GetItemString ( lCpt, "ACCORD_BRK" ))
	sAccordBrk = sVal  	

	sVal = dw_Charger.GetItemString ( lCpt, "MT_FACT_TTC_MODIF_BRK" )	
	dcMtFactTtcModifBrk = Dec ( sVal )

	sVal = Trim ( dw_Charger.GetItemString ( lCpt, "COMMENT_BRK" ))
	sCommentBrk = sVal 	
	
	sVal = dw_Charger.GetItemString ( lCpt, "MT_FACT_TTC_FORCE_SPB" )	
	dcMtFactTtcForceSPB = Dec ( sVal )

	sVal = Trim ( dw_Charger.GetItemString ( lCpt, "COMMENT_SPB" ))
	sCommentSPB = sVal 		
	
	sResult = Fill ( " ", 255 )
	lRet = SQLCA.PS_U_PM02_PM478_MAJ_CUM_FTU_BRK (lIdCum, lIdTrt, lIdPeriode, lIdSin, lIdSeq, sAccordBrk, dcMtFactTtcModifBrk, sCommentBrk, dcMtFactTtcForceSPB, sCommentSPB, stGlb.sCodOper, sResult )

	dw_Charger.SetItem ( lCpt, "RESULT_TRT", sResult )
	
	If lRet > 0 And lRetFinal <> 2 And lRetFinal <> -1 Then
		lRetFinal = 1
	End If 

	If ( lRet <= 0 And lRetFinal = 1 ) Or ( lRet > 0 And lRetFinal = -1 ) Then
		lRetFinal = 2
	End If 
	
	If lRet <= 0 And lRetFinal = 0 Then
		lRetFinal = -1
	End If 

	bRet = SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0  
	
	if bRet Then 
		F_Commit ( SQLCA, True )
	Else
		st_Charger.Text="Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour en base"
		F_Commit ( SQLCA, False )
		Exit
	End if

	hpb_trt.Position = lCpt
	wf_pct ()
	Yield ()			
Next

If lRetFinal = 1 Then 
	st_Charger.Text="Mise $$HEX2$$e0002000$$ENDHEX$$jour totale effectu$$HEX1$$e900$$ENDHEX$$e"
End If

If lRetFinal = 2 Then 
	st_Charger.Text="Mise $$HEX2$$e0002000$$ENDHEX$$jour partielle effectu$$HEX1$$e900$$ENDHEX$$e"
End If

If lRetFinal = -1 Then 
	st_Charger.Text="Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e"
End If

cb_result.Event Clicked ()

Return bRet



end function

protected function boolean wf_controler_vdoc28472 (ref long alcpt, ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_vDoc28472
//* Auteur			: F. Pinon
//* Date				: 07/10/2019
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [VDOC28472]
//*
//* Arguments		: ref string asvaleur[]	 */
/* 	ref string aserreur	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Boolean bOk
String sVal

sVal=dw_charger.GetItemString(alCpt,"ID_SIN")
// Contr$$HEX1$$f400$$ENDHEX$$le des champs
bOk = IsNumber(sVal)

if bOk Then
	// Contr$$HEX1$$f400$$ENDHEX$$le d'existence
	If SQLCA.PS_V02_SIN( Dec(sVal) ) = 0 Then
		asErreur="Ce sinistre n'existe pas"
		bOk=FALSE
	End if
Else
	asErreur += "L'identifiant sinistre n'est pas un nombre ! "
End if

sVal=dw_charger.GetItemString(alCpt,"MONTANT")
sVal=f_remplace(sVal,",",".")

dw_charger.SetItem(alCpt,"MONTANT",sVal)

if bOk and not IsNumber(sVal) Then
	asErreur += "Le montant n'est pas un nombre ! "
	bOk=FALSE
End if

sVal=dw_charger.GetItemString(alCpt,"FOURNISSEUR")
if bOk and Trim(sVal) = "" Then
	asErreur+="Le fournisseur n'est pas renseign$$HEX1$$e900$$ENDHEX$$"
	bOk=FALSE
End if

Return bOk
end function

public function boolean wf_trt_lstfact ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trt_lstfact
//* Auteur			: FPI
//* Date				: 07/10/2019
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [VDOC28472] - extraction du tiret $$HEX2$$e0002000$$ENDHEX$$partir du dossier et montant r$$HEX1$$e900$$ENDHEX$$gl$$HEX2$$e9002000$$ENDHEX$$au fournisseur
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------
Long lRow,lRet, lIdSin, lTotRow, lCpt
Boolean bRet
String sVal, sResult, sIdFour
Decimal {2} dcMontant

lTotRow = dw_Charger.RowCount ()

hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lTotRow
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()

bRet = True

cb_result.Enabled = TRUE

If lTotRow = 0 Then
	Return true
End if

For lCpt = 1 To lTotRow

	sVal = dw_Charger.GetItemString ( lCpt, "ID_SIN" )	
	lIdSin = Long ( sVal ) 

	sVal = dw_Charger.GetItemString ( lCpt, "MONTANT" )	
	dcMontant = Dec ( sVal )
	
	sVal = dw_Charger.GetItemString ( lCpt, "FOURNISSEUR" )	
	sIdFour=sVal
	
	sResult = Fill ( " ", 255 )
	SQLCA.PS_S_VDOC28472 (lIdSin, dcMontant, sIdFour, sResult )

	dw_Charger.SetItem ( lCpt, "NO_COMMANDES", sResult )
		
	hpb_trt.Position = lCpt
	wf_pct ()
	Yield ()	
Next

//cb_result.Event Clicked ()

Return bRet



end function

public subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Sinistre::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 28/09/2022
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On positionne et on taille tous les objets
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------


Choose case isCasTailleFen
		
	Case "AGRANDIR"
//		gWMdi.X     -=1900
//		gWMdi.Y     -=500
		gWMdi.X     = 100
		gWMdi.Y     = 100
//		gWMdi.Width +=4850
		gWMdi.Width +=3650
		gWMdi.Height +=1500
		
		cb_taillefen.X = gWMdi.Width - 900
		
		dw_charger.Width +=3613
		dw_charger.Height +=1510
		
		hpb_trt.Y += 1510
		hpb_trt.Width = dw_charger.Width
		st_pct.Y = hpb_trt.Y
		st_pct.X = hpb_trt.X + ( hpb_trt.Width / 2 ) - ( st_pct.Width / 2)
		
		st_Charger.Y += 1510
		st_Charger.Width = dw_charger.Width
		
		st_Extraire.Y += 1510
		st_Extraire.Width = dw_charger.Width
		
		
	Case "REDUIRE"		
		gWMdi.X     +=1900
		gWMdi.Y     +=500
//		gWMdi.Width -=4850
		gWMdi.Width -=3650
		gWMdi.Height -=1500		
	
		cb_taillefen.X = 2862

		dw_charger.Width -=3613
		dw_charger.Height -=1510

		hpb_trt.Width = dw_charger.Width
		hpb_trt.Y -= 1510
		st_pct.Y = hpb_trt.Y
		st_pct.X = hpb_trt.X + ( hpb_trt.Width / 2 ) - ( st_pct.Width / 2)


		st_Charger.Y -= 1510
		st_Charger.Width = dw_charger.Width
		
		st_Extraire.Y -= 1510
		st_Extraire.Width = dw_charger.Width
	
	
	
End Choose
	





end subroutine

public function boolean wf_trt_pnd_corus ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_trt_pnd_corus
//* Auteur			: JFF
//* Date				: 02/01/2023
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	:  [RS_4166_PND_CORUS]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 		FPI	20/06/2013	[20130620.FPI] Ajout ctl fichier IMEI Orange V3 Vide
//       JFF   09/09/2022  [PM80_FA12_FRANEX]
//*-----------------------------------------------------------------

Boolean bRet, bTrtSIMPA2, bTrtKSL, bMajPartielle, bAMUligneTraitee
Int iPos1, iPos2, iRet, iPosDeb, iPosFin
String sValRetPndCorus, sCodInter, sIdCour, sDteEdit, sResult, sMotif, sLibinter, sCreelePnd 
String sSql, sIdCourSav, sDteRetPnd, sResultTrt, sIdLot, sCar, sVal, sTagKsl, sTagSIMPA2
Long lIdSin, lIdInter, lIdDoc, lTotRow, lRetFinal, lCpt, lResulte, lRet, lIdProdAdh, lIdAdh, lIdCLi, lIdEts, lIdsdos 

bMajPartielle = False
bAMUligneTraitee = False
bRet = True
sTagSIMPA2 = "SIMPA2"
sTagKsl = "KSL_ADH"

If dw_charger.RowCount() = 0 Then
	st_Charger.Text="Aucune mise $$HEX2$$e0002000$$ENDHEX$$jour : fichier vide"
	Return true
End if

lTotRow = dw_Charger.RowCount ()
lRetFinal = 0 // Scucc$$HEX1$$e800$$ENDHEX$$s total

hpb_trt.MinPosition = 0
hpb_trt.MaxPosition = lTotRow
hpb_trt.Position = 0	
hpb_trt.SetStep = 1
wf_pct ()
Yield ()

For lCpt = 1 To lTotRow

	sValRetPndCorus = Trim ( dw_Charger.GetItemString ( lCpt, "VAL_RET_PND_CORUS" ))
	sResultTrt = Trim ( dw_Charger.GetItemString ( lCpt, "RESULT_TRT" ))
	If IsNull ( sResultTrt) Then sResultTrt = ""
	
	bTrtSIMPA2 = Left ( Trim ( sValRetPndCorus), Len ( sTagSIMPA2 ) ) = sTagSIMPA2
	bTrtKSL    = Left ( Trim ( sValRetPndCorus), Len ( sTagKsl ) ) = sTagKsl
	
	If bTrtSIMPA2 Then
	
		iPos1 = Pos ( sValRetPndCorus, "_" )  
		iPos1 = Pos ( sValRetPndCorus, "_", iPos1 + 1 ) + 1 
		iPosDeb = iPos1 
		iPos2 = Pos ( sValRetPndCorus, "_", iPos1 )  
		
		lIdSin = Long ( Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) )
		
		iPos1 = iPos2 + 1 
		iPos2 = Pos ( sValRetPndCorus, "_", iPos1 )  
		
		lIdInter = Long ( Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) )
		
		iPos1 = iPos2 + 1 
		iPos2 = Pos ( sValRetPndCorus, "_", iPos1 )  
		
		lIdDoc = Long ( Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) )
		
		iPos1 = iPos2 + 1 
		iPos2 = Pos ( sValRetPndCorus, "_", iPos1 )  
		
		sCodInter = Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) 
		
		Choose Case sCodInter 
			Case "A"
				sLibinter = "Assur$$HEX1$$e900$$ENDHEX$$"
			Case "B"
				sLibinter = "Banque"			
			Case "F"
				sLibinter = "Fournisseur"						
			Case "T"
				sLibinter = "Autre"									
			Case Else 
				sLibinter = sCodInter
		End Choose 
		
		
		iPos1 = iPos2 + 1 
		iPos2 = Pos ( sValRetPndCorus, "_", iPos1 )  
		
		sIdCour = Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) 
		
		// Si le courrier pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent $$HEX1$$e900$$ENDHEX$$tait un ALAX01, on passe le suivant.
		// Bien dw doit $$HEX1$$ea00$$ENDHEX$$tre tri$$HEX2$$e9002000$$ENDHEX$$en nom desc.
		If sIdCourSav = "ALAX01" Then 
			// hpb_trt.Position = lCpt
			hpb_trt.Position ++
			wf_pct ()
			Yield ()
			sIdCourSav = sIdCour		
			dw_Charger.SetItem ( lCpt, "RESULT_TRT", "Non trait$$HEX2$$e9002000$$ENDHEX$$car d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$trait$$HEX2$$e9002000$$ENDHEX$$sur le courrier " + sIdCourSav + " pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent, m$$HEX1$$ea00$$ENDHEX$$me enveloppe" )
			Continue 
		End IF 
		
		sIdCourSav = sIdCour	
	
		// Cas d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$marqu$$HEX2$$e9002000$$ENDHEX$$par le pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent Contr$$HEX1$$f400$$ENDHEX$$le, on ne traite pas
		If sResultTrt <> "" Then 
			bMajPartielle = True
			hpb_trt.Position = lCpt
			wf_pct ()
			Yield ()
			Continue 
		End IF 
		
		
		iPos1 = iPos2 + 1 
		iPos2 = Pos ( sValRetPndCorus, "_", iPos1 )  
		iPosFin = iPos2 
		
		sDteEdit = Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) 
		sDteEdit = Right ( sDteEdit, 2 ) + "/" + Mid ( sDteEdit, 5, 2 ) + "/" + Left ( sDteEdit, 4 )
	
		iPos1 = LastPos ( sValRetPndCorus, ";" ) + 1
		sMotif = Mid ( sValRetPndCorus, iPos1, Len ( sValRetPndCorus )) 
		sMotif = Upper ( sMotif ) 
		sMotif = F_REMPLACE ( sMotif, "$$HEX2$$c300a900$$ENDHEX$$", "$$HEX1$$e900$$ENDHEX$$" )  	
		sMotif = F_REMPLACE ( sMotif, "$$HEX2$$c300a800$$ENDHEX$$", "$$HEX1$$e800$$ENDHEX$$" )  		
		sMotif = F_REMPLACE ( sMotif, "$$HEX1$$c300$$ENDHEX$$", "$$HEX1$$e000$$ENDHEX$$" ) 
		sMotif = F_REMPLACE ( sMotif, "$$HEX1$$a000$$ENDHEX$$", " " ) // Le premier n'est pas un espace mais un car sp$$HEX2$$e9002000$$ENDHEX$$:)
		sMotif = F_REMPLACE ( sMotif, "  ", " " )  		
		sMotif = Upper ( Left ( sMotif, 1 ) ) + Lower ( Right ( sMotif, Len ( sMotif ) -1 ) )
		sMotif = F_REMPLACE ( sMotif , "'", "''" )
	
		iPos2 = LastPos ( sValRetPndCorus, ";", iPos1 - 2 ) + 1
		sDteRetPnd = Mid ( sValRetPndCorus, iPos2, iPos1 - 1 - iPos2 ) 
	
		// PS
		sSql  = "Exec sysadm.PS_I_RS4166_CTC_TRV_PND_CORUS "
		sSql += String ( lIdSin ) + "., "
		sSql += String ( lIdInter ) + "., "
		sSql += String ( lIdDoc ) + "., "
		sSql += "'" + sLibinter + "'" + ", "
		sSql += "'" + sIdCour + "'" + ", "	
		sSql += "'" + sDteEdit + "'" + ", "	
		sSql += "'" + sDteRetPnd + "'" + ", "		
		sSql += "'" + sMotif + "'" + ", "
		sSql += "'" + stGlb.sCodOper + "'"
		
		F_Execute ( sSql, SQLCA )	
		
		bRet = SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0  
	
		if bRet Then 
			F_Commit ( SQLCA, True )
			sResult = "Trait$$HEX2$$e9002000$$ENDHEX$$avec succ$$HEX1$$e800$$ENDHEX$$s"
			dw_Charger.SetItem ( lCpt, "RESULT_TRT", sResult )		
			bAMUligneTraitee =True
		Else
			F_Commit ( SQLCA, False )
			Exit
		End if

	End If 
	
	If bTrtKSL Then

		// Cas d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$marqu$$HEX2$$e9002000$$ENDHEX$$par le pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent Contr$$HEX1$$f400$$ENDHEX$$le, on ne traite pas
		If sResultTrt <> "" Then 
			bMajPartielle = True
			hpb_trt.Position = lCpt
			wf_pct ()
			Yield ()	
			Continue 
		End IF 
		
		iPos1 = Pos ( sValRetPndCorus, "_", len ( sTagKsl )  ) + 1
		iPos2= Pos ( sValRetPndCorus, "-", iPos1 )  
	
		lIdProdAdh = Long ( Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) )
	
		iPos1 = iPos2 + 1 
		iPos2 = Pos ( sValRetPndCorus, "-", iPos1 )  
	
		lIdEts = Long ( Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) )
	
		iPos1 = iPos2 + 1 
		iPos2 = Pos ( sValRetPndCorus, "-", iPos1 )  
	
		lIdAdh = Long ( Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) )
	
		iPos1 = iPos2 + 1 
		iPos2 = Pos ( sValRetPndCorus, "_", iPos1 )  
	
		lIdsDos = Long ( Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) )

		iPos1 = LastPos ( sValRetPndCorus, ";" ) + 1
		sMotif = Mid ( sValRetPndCorus, iPos1, Len ( sValRetPndCorus )) 
		sMotif = Upper ( sMotif ) 
		sMotif = F_REMPLACE ( sMotif, "$$HEX2$$c300a900$$ENDHEX$$", "$$HEX1$$e900$$ENDHEX$$" )  	
		sMotif = F_REMPLACE ( sMotif, "$$HEX2$$c300a800$$ENDHEX$$", "$$HEX1$$e800$$ENDHEX$$" )  		
		sMotif = F_REMPLACE ( sMotif, "$$HEX1$$c300$$ENDHEX$$", "$$HEX1$$e000$$ENDHEX$$" ) 
		sMotif = F_REMPLACE ( sMotif, "$$HEX1$$a000$$ENDHEX$$", " " ) // Le premier n'est pas un espace mais un car sp$$HEX2$$e9002000$$ENDHEX$$:)
		sMotif = F_REMPLACE ( sMotif, "  ", " " )  		
		sMotif = Upper ( Left ( sMotif, 1 ) ) + Lower ( Right ( sMotif, Len ( sMotif ) -1 ) )
		sMotif = F_REMPLACE ( sMotif , "'", "''" )
	
		iPos2 = LastPos ( sValRetPndCorus, ";", iPos1 - 2 ) + 1
		sDteRetPnd = Mid ( sValRetPndCorus, iPos2, iPos1 - 1 - iPos2 ) 

		SQLCA.PS_S_RS4166_CTRLE_ADH_FFM ( lIdProdAdh, lIdEts, lIdAdh, lIdsdos, sDteRetPnd, lIdCLi, sCreelePnd ) 

		// PS
		sSql  = "Exec sysadm.PS_I_RS4166_CTC_TRV_PND_CORUS_FFM_KSL "
		sSql += String ( lIdCLi ) + ", "
		sSql += String ( lIdProdAdh ) + ", "
		sSql += String ( lIdEts ) + ", "
		sSql += String ( lIdAdh ) + ", "
		sSql += String ( lIdsdos ) + "., "		
		sSql += "'" + sDteRetPnd + "'" + ", "
		sSql += "'" + sMotif + "'" + ", "	
		sSql += "'" + stGlb.sCodOper + "'"		

		F_Execute ( sSql, SQLCA )	
		
		bRet = SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0  
	
		if bRet Then 
			F_Commit ( SQLCA, True )
			sResult = "Trait$$HEX2$$e9002000$$ENDHEX$$avec succ$$HEX1$$e800$$ENDHEX$$s"
			dw_Charger.SetItem ( lCpt, "RESULT_TRT", sResult )		
			bAMUligneTraitee =True
		Else
			F_Commit ( SQLCA, False )
			Exit
		End if		
		
	End If 		

	hpb_trt.Position = lCpt
	wf_pct ()
	Yield ()	
	
Next 

If bRet then 
	If bMajPartielle And Not bAMUligneTraitee Then
		st_extraire.BackColor = 255
		st_extraire.TextColor = 16777215
		st_extraire.Text = "Aucune Mise $$HEX2$$e0002000$$ENDHEX$$jour effectu$$HEX1$$e900$$ENDHEX$$e, sauvegardez le log et consultez le"
	ElseIf bMajPartielle Then
		st_extraire.BackColor = RGB(255, 100, 0)
		st_extraire.TextColor = 16777215
		st_extraire.Text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour partielle, des lignes n'ont pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trait$$HEX1$$e900$$ENDHEX$$es, sauvegardez le log et consultez le"
	Else		
		st_extraire.BackColor = 32768
		st_extraire.TextColor = 16777215
		st_extraire.Text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour totale effectu$$HEX1$$e900$$ENDHEX$$e"		
	End If 
Else 
	// st_Charger.Text="Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour en base, arr$$HEX1$$ea00$$ENDHEX$$t de traitement ligne " + String ( lCpt )
	st_extraire.BackColor = 255
	st_extraire.TextColor = 16777215		
	st_extraire.Text = "Erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour en base, arr$$HEX1$$ea00$$ENDHEX$$t de traitement ligne " + String ( lCpt )
//	dw_Charger.SetItem ( lCpt, "RESULT_TRT", st_Charger.Text )
End If 

cb_result.Enabled = TRUE

Return bRet

end function

public function boolean wf_controler_pnd_corus (long alcpt, ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_pnd_corus
//* Auteur			: JFF
//* Date				: 03/01/2023
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [RS_4166_PND_CORUS]
//* Commentaires	: 
//*
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

boolean bOK, bTrtSIMPA2, bTrtKSL
Int iPos1, iPos2, iRet, iPosDeb, iPosFin
String sValRetPndCorus, sCodInter, sIdCour, sDteEdit, sDteRetPnd, sCreelePnd, sVal, sCar, sTagKsl, sTagSIMPA2, sIdProd
Long lIdSin, lIdInter, lIdDoc, lIdProdAdh, lIdAdh, lIdEts, lIdsDos, lCpt, lIdCLi

bOk=TRUE
sTagSIMPA2 = "SIMPA2"
sTagKsl = "KSL_ADH"

// SIMPA2_262083_7865956_0_1_A_AC0P01_20221208_140457.PDF

sValRetPndCorus = Trim ( Upper ( dw_Charger.GetItemString ( alCpt, "VAL_RET_PND_CORUS" )))

bTrtSIMPA2 = Left ( sValRetPndCorus, len ( sTagSIMPA2 ) ) = sTagSIMPA2
bTrtKSL    = Left ( sValRetPndCorus, len ( sTagKsl ) ) = sTagKsl

If Not bTrtSIMPA2 And Not bTrtKSL Then
	asErreur = "ERREUR : cette ligne (" + Left ( sValRetPndCorus, 20) + "...) devant normalement r$$HEX1$$e900$$ENDHEX$$pr$$HEX1$$e900$$ENDHEX$$senter un courrier n'est pas au format SIMPA2 ou KSL attendu"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	// bOk = False
End If 

// TRT SIMPA2

IF bTrtSIMPA2 Then
	iPos1 = Pos ( sValRetPndCorus, "_" )  
	iPos1 = Pos ( sValRetPndCorus, "_", iPos1 + 1 ) + 1 
	iPosDeb = iPos1 
	iPos2 = Pos ( sValRetPndCorus, "_", iPos1 )  
	
	lIdSin = Long ( Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) )
	
	iPos1 = iPos2 + 1 
	iPos2 = Pos ( sValRetPndCorus, "_", iPos1 )  
	
	lIdInter = Long ( Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) )
	
	iPos1 = iPos2 + 1 
	iPos2 = Pos ( sValRetPndCorus, "_", iPos1 )  
	
	lIdDoc = Long ( Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) )
	
	iPos1 = iPos2 + 1 
	iPos2 = Pos ( sValRetPndCorus, "_", iPos1 )  
	
	sCodInter = Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) 
	
	iPos1 = iPos2 + 1 
	iPos2 = Pos ( sValRetPndCorus, "_", iPos1 )  
	
	sIdCour = Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) 
	
	iPos1 = iPos2 + 1 
	iPos2 = Pos ( sValRetPndCorus, "_", iPos1 )  
	iPosFin = iPos2 
	
	sDteEdit = Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) 
	sDteEdit = Right ( sDteEdit, 2 ) + "/" + Mid ( sDteEdit, 5, 2 ) + "/" + Left ( sDteEdit, 4 )
	
	sDteRetPnd = Space ( 10 ) 
	sCreelePnd = Space ( 10 ) 
	sIdProd    = space ( 10 )
	
	iRet = SQLCA.PS_S_RS4166_CTRLE_DATA_PND_CORUS ( lIdSin, lIdInter, lIdDoc, sCodInter, sIdCour, sDteEdit, sDteRetPnd, sCreelePnd, sIdProd ) 
	
	If iRet = -1 Then
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", "ERREUR : Le courrier " + Mid ( sValRetPndCorus, iPosDeb, iPosFin - iPosDeb) + " n'a pas de r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence sur SIMPA2, la ligne n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trait$$HEX1$$e900$$ENDHEX$$e" )
	End If

	If iRet = -2 Then
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", "ERREUR : Le produit " + sIdProd + " du courrier " + Mid ( sValRetPndCorus, iPosDeb, iPosFin - iPosDeb) + " n'est pas $$HEX1$$e900$$ENDHEX$$ligible au traitement des PND, la ligne n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trait$$HEX1$$e900$$ENDHEX$$e" )	
	End If
	
	IF iRet = 2 Then
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", "ERREUR : PND d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$existant du " + sDteRetPnd + " trait$$HEX2$$e9002000$$ENDHEX$$le " + sCreelePnd + ", la ligne n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trait$$HEX1$$e900$$ENDHEX$$e" )	
	End If 

End If 


// TRT KSL

IF bTrtKSL Then
	iPos1 = Pos ( sValRetPndCorus, "_", len ( sTagKsl ) ) + 1
	iPos2= Pos ( sValRetPndCorus, "-", iPos1 )  

	lIdProdAdh = Long ( Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) )

	iPos1 = iPos2 + 1 
	iPos2 = Pos ( sValRetPndCorus, "-", iPos1 )  

	lIdEts = Long ( Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) )

	iPos1 = iPos2 + 1 
	iPos2 = Pos ( sValRetPndCorus, "-", iPos1 )  

	lIdAdh = Long ( Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) )

	iPos1 = iPos2 + 1 
	iPos2 = Pos ( sValRetPndCorus, "_", iPos1 )  

	lIdsDos = Long ( Mid ( sValRetPndCorus, iPos1, iPos2 - iPos1 ) )
	
	iPos1 = LastPos ( sValRetPndCorus, ";" ) + 1
	iPos2 = LastPos ( sValRetPndCorus, ";", iPos1 - 2 ) + 1
	sDteRetPnd = Mid ( sValRetPndCorus, iPos2, iPos1 - 1 - iPos2 ) 

	sCreelePnd = Space ( 10 ) 		
		
	iRet = SQLCA.PS_S_RS4166_CTRLE_ADH_FFM ( lIdProdAdh, lIdEts, lIdAdh, lIdsdos, sDteRetPnd, lIdCLi, sCreelePnd  ) 
	
	If iRet <= 0 Then
		asErreur = "ERREUR : l'adh$$HEX1$$e900$$ENDHEX$$sion " + String ( lIdProdAdh ) + "-" + String ( lIdEts ) + "-" + String ( lIdAdh ) + "-" + String ( lIdsDos ) + " n'a pas de r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence adh$$HEX1$$e900$$ENDHEX$$sion sur SHERPA, la ligne n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trait$$HEX1$$e900$$ENDHEX$$e"
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
		// bOk = False
	End If 
	
	IF iRet = 2 Then
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", "ERREUR : l'adh$$HEX1$$e900$$ENDHEX$$sion " + String ( lIdProdAdh ) + "-" + String ( lIdEts ) + "-" + String ( lIdAdh ) + "-" + String ( lIdsDos ) + " a plusieurs r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences adh$$HEX1$$e900$$ENDHEX$$sions sur SHERPA, la ligne n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trait$$HEX1$$e900$$ENDHEX$$e" )
	End If 

	IF iRet = 3 Then
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", "ERREUR : PND d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$existant du " + sDteRetPnd + " trait$$HEX2$$e9002000$$ENDHEX$$le " + sCreelePnd )	
	End If 		

	IF iRet = 4 Then
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", "ERREUR : Produit adh$$HEX1$$e900$$ENDHEX$$sion " + String (lIdProdAdh) + " non $$HEX1$$e900$$ENDHEX$$ligible au traitement des PND, la ligne n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trait$$HEX1$$e900$$ENDHEX$$e" )	
	End If 		
		
	
End If 

Return bOK

end function

public function boolean wf_controler_retour_pm02 (long alcpt, ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_retour_PM02
//* Auteur			: JFF
//* Date				: 28/05/2019 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PM478-1]
//* Commentaires	: Int$$HEX1$$e900$$ENDHEX$$gration des Retours du PM02
//*
//* Arguments		: ref string ascolnames[]
//* 	ref string asvaleurs[]
//* 	ref string aserreur
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

n_cst_string uString
boolean bOK, bOkRow
long lPos, lTotRow, lRow
String sVal, sAccordBrk
Decimal {2} dcMtFactTtcModifBrk, dcMtFactTtcForceSPB

bOk=TRUE
bOkRow = True

sVal = dw_Charger.GetItemString ( alCpt, "ID_CUM" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone ID_CUM de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And ( Not ISNUMBER ( sVal )  ) Then
	asErreur = "ERREUR : La zone ID_CUM de la ligne " + String ( alCpt ) + " doit $$HEX1$$ea00$$ENDHEX$$tre un nombre"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow Then 
	If ( Long ( sVal ) <= 0 ) Then
		asErreur = "ERREUR : La zone ID_CUM de la ligne " + String ( alCpt ) + " doit $$HEX1$$ea00$$ENDHEX$$tre un nombre positif"
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
		bOk = False
		bOkRow = False
	End IF 
End If

If bOkRow Then
	lRow = dw_Charger.Find ( "ID_CUM= '"+ sVal + "'", 1, dw_Charger.RowCount () )
	If lRow > 0 Then
		If lRow = alCpt Then
			lRow = dw_Charger.Find ( "ID_CUM= '"+ sVal + "'", alCpt + 1, dw_Charger.RowCount () )
			If lRow = alCpt Then
				bOkRow = False
			End If
		End If
		If bOkRow And lRow > 0 Then
			asErreur = "ERREUR : La valeur " + sVal + " de la zone ID_CUM de la ligne " + String ( alCpt ) + " n'est pas unique dans le fichier."
			dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
			bOk = False
			bOkRow = False
		End If
	End If
End If		

sVal = dw_Charger.GetItemString ( alCpt, "ID_TRT" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone ID_TRT de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And ( Not ISNUMBER ( sVal )  ) Then
	asErreur = "ERREUR : La zone ID_TRT de la ligne " + String ( alCpt ) + " doit $$HEX1$$ea00$$ENDHEX$$tre un nombre"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow Then
	If ( Long ( sVal ) <= 0 ) Then
		asErreur = "ERREUR : La zone ID_TRT de la ligne " + String ( alCpt ) + " doit $$HEX1$$ea00$$ENDHEX$$tre un nombre positif"
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
		bOk = False
		bOkRow = False
	End If 
End If

sVal = dw_Charger.GetItemString ( alCpt, "ID_PERIODE" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone ID_PERIODE de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And ( Not ISNUMBER ( sVal )  ) Then
	asErreur = "ERREUR : La zone ID_PERIODE de la ligne " + String ( alCpt ) + " doit $$HEX1$$ea00$$ENDHEX$$tre un nombre"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow Then
	If ( Long ( sVal ) <= 0 ) Then
		asErreur = "ERREUR : La zone ID_PERIODE de la ligne " + String ( alCpt ) + " doit $$HEX1$$ea00$$ENDHEX$$tre un nombre positif"
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
		bOk = False
		bOkRow = False
	End If 
End If

sVal = dw_Charger.GetItemString ( alCpt, "ID_SIN" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone ID_SIN de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And ( Not ISNUMBER ( sVal )  ) Then
	asErreur = "ERREUR : La zone ID_SIN de la ligne " + String ( alCpt ) + " doit $$HEX1$$ea00$$ENDHEX$$tre un nombre"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow Then
	If ( Long ( sVal ) <= 0 ) Then
		asErreur = "ERREUR : La zone ID_SIN de la ligne " + String ( alCpt ) + " doit $$HEX1$$ea00$$ENDHEX$$tre un nombre positif"
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
		bOk = False
		bOkRow = False
	End If 
End If

sVal = dw_Charger.GetItemString ( alCpt, "ID_SEQ" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone ID_SEQ de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And ( Not ISNUMBER ( sVal )  ) Then
	asErreur = "ERREUR : La zone ID_SEQ de la ligne " + String ( alCpt ) + " doit $$HEX1$$ea00$$ENDHEX$$tre un nombre"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow Then 
	If ( Long ( sVal ) <= 0 ) Then
		asErreur = "ERREUR : La zone ID_SEQ de la ligne " + String ( alCpt ) + " doit $$HEX1$$ea00$$ENDHEX$$tre un nombre positif"
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
		bOk = False
		bOkRow = False
	End If 
End If

sVal = Trim ( dw_Charger.GetItemString ( alCpt, "ACCORD_BRK" ))
sAccordBrk = sVal 

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone ACCORD_BRK de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And sVal <> "O" And sVal <> "N" Then
	asErreur = "ERREUR : La zone ACCORD_BRK de la ligne " + String ( alCpt ) + " Doit contenir la valeur 'O' (Oui) ou 'N' (Non)"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

sVal = Trim ( dw_Charger.GetItemString ( alCpt, "MT_FACT_TTC_MODIF_BRK" ))

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	dw_Charger.SetItem ( alCpt, "MT_FACT_TTC_MODIF_BRK", 0 )
	sVal= "0"
End If

If bOkRow And ( Not ISNUMBER ( sVal )  ) Then
	asErreur = "ERREUR : La zone MT_FACT_TTC_MODIF_BRK de la ligne " + String ( alCpt ) + " doit $$HEX1$$ea00$$ENDHEX$$tre un nombre (2 decimals $$HEX1$$e900$$ENDHEX$$ventuellement)"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow Then 
	If ( Dec ( sVal ) < 0 ) Then
		asErreur = "ERREUR : La zone MT_FACT_TTC_MODIF_BRK de la ligne " + String ( alCpt ) + " doit $$HEX1$$ea00$$ENDHEX$$tre un nombre positif"
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
		bOk = False
		bOkRow = False
	End If 
End If

dcMtFactTtcModifBrk = Dec ( sVal )


sVal = Trim ( dw_Charger.GetItemString ( alCpt, "COMMENT_BRK" ))

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	If dcMtFactTtcModifBrk > 0 Then 
		asErreur = "ERREUR : La zone COMMENT_BRK de la ligne " + String ( alCpt ) + " est vide (obligatoire si montant broker positif)"
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
		bOk = False
		bOkRow = False
	End If 
End If


sVal = Trim ( dw_Charger.GetItemString ( alCpt, "MT_FACT_TTC_FORCE_SPB" ))

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	dw_Charger.SetItem ( alCpt, "MT_FACT_TTC_FORCE_SPB", 0 )
	sVal= "0"
End If

If bOkRow And ( Not ISNUMBER ( sVal )  ) Then
	asErreur = "ERREUR : La zone MT_FACT_TTC_FORCE_SPB de la ligne " + String ( alCpt ) + " doit $$HEX1$$ea00$$ENDHEX$$tre un nombre (2 decimals $$HEX1$$e900$$ENDHEX$$ventuellement)"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow Then 
	If ( Dec ( sVal ) < 0 ) Then
		asErreur = "ERREUR : La zone MT_FACT_TTC_FORCE_SPB de la ligne " + String ( alCpt ) + " doit $$HEX1$$ea00$$ENDHEX$$tre un nombre positif"
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
		bOk = False
		bOkRow = False
	End If 
End If

dcMtFactTtcForceSPB = Dec ( sVal )


sVal = Trim ( dw_Charger.GetItemString ( alCpt, "COMMENT_SPB" ))

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	If dcMtFactTtcForceSPB > 0 Then 
		asErreur = "ERREUR : La zone COMMENT_SPB de la ligne " + String ( alCpt ) + " est vide (obligatoire si montant SPB positif)"
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
		bOk = False
		bOkRow = False
	End If 
End If

cb_result.Enabled = TRUE

Return bOK
end function

private subroutine wf_pct ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_autofact::wf_pct (PRIVATE)
//* Auteur        : JFF
//* Date          : 13/01/2023
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: maj pourcentage
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------



st_pct.text = String ( Integer ( String ( (( hpb_trt.position / hpb_trt.MaxPosition ) * 100 )))) + "%"

If  hpb_trt.position >= hpb_trt.MaxPosition / 2 Then 
	st_pct.textcolor = RGB(255, 255, 255)
Else 
	st_pct.textcolor = RGB(0, 0, 0)
End If 


end subroutine

public function boolean wf_controler_rm_avoir_fourn (long alcpt, ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_rm_avoir_fourn
//* Auteur			: JFF
//* Date				: 27/01/2014 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [VDOC12917]
//* Commentaires	: Int$$HEX1$$e900$$ENDHEX$$gration des fichiers TAC_IMEI
//*
//* Arguments		: ref string ascolnames[]	 */
/* 	ref string asvaleurs[]	 */
/* 	ref string aserreur	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 FPI	 01/07/2009		Am$$HEX1$$e900$$ENDHEX$$lioration : on ne met que la premi$$HEX1$$e800$$ENDHEX$$re erreur
//        JFF   30/11/2016   [PM375-1]
//       JFF   09/09/2022 [PM80_FA12_FRANEX]
//*-----------------------------------------------------------------

n_cst_string uString
boolean bOK, bOkRow
long lPos, lTotRow, lRow, lTotTbFrais, lCptTbFrais, lIdSin, lIdSeq
Int iRet, iIdRegBaseIdSeq
String sVal, sMtRMAvoir
string   sTbFraisAnex[]
Decimal {2} dcSomTbFrais
String sResult  
DateTime dtDteRegBase, dtDtePivotMepPM80

bOk=TRUE
bOkRow = True
sVal = dw_Charger.GetItemString ( alCpt, "ID_SIN_SEQ" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone ID_SIN_SEQ de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

lPos = Pos ( sVal, "-", 1 )
If bOkRow And lPos <= 0 Then 
	asErreur = "ERREUR : La zone ID_SIN_SEQ de la ligne " + String ( alCpt ) + " n'a pas de tiret"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow Then 
	If Not IsNumber ( Left ( sVal, lPos - 1 ) ) Or Not IsNumber ( Right ( sVal, Len ( sVal ) - lPos ) ) Then
		asErreur = "ERREUR : La zone ID_SIN_SEQ de la ligne " + String ( alCpt ) + " n'est pas valide"
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
		bOk = False
		bOkRow = False
	End If
End If 

// [PM375-1]
If bOkRow and dw_Charger.RowCount () > 1 Then
	lRow = dw_Charger.Find ( "ID_SIN_SEQ= '"+ sVal + "'", 1, dw_Charger.RowCount () )
	If lRow > 0 Then
		If lRow = alCpt Then
			lRow = dw_Charger.Find ( "ID_SIN_SEQ= '"+ sVal + "'", alCpt + 1, dw_Charger.RowCount () )
			If lRow = alCpt Then
				bOkRow = False
			End If
		End If
		If bOkRow And lRow > 0 Then
			asErreur = "ERREUR : La valeur " + sVal + " de la zone ID_SIN_SEQ de la ligne " + String ( alCpt ) + " n'est pas unique dans le fichier."
			dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
			bOk = False
			bOkRow = False
		End If
	End If
End If		

// [PM80_FA12_FRANEX]
If bOkRow Then
	lIdSin = Long ( Left ( sVal, lPos - 1 ) ) 
	lIdSeq = Long ( Right ( sVal, Len ( sVal ) - lPos ) ) 
End If 

sVal = dw_Charger.GetItemString ( alCpt, "ID_FOUR" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone ID_FOUR de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And Len ( Trim ( sVal ) ) > 3 Then
	asErreur = "ERREUR : La zone ID_FOUR de la ligne " + String ( alCpt ) + " est trop longue (3 Caract$$HEX1$$e800$$ENDHEX$$re max)"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If


sVal = dw_Charger.GetItemString ( alCpt, "LIB_RM" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone LIB_RM de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And Len ( Trim ( sVal ) ) > 35  Then
	asErreur = "ERREUR : La zone LIB_RM de la ligne " + String ( alCpt ) + " est trop longue (35 car maxi)"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If


sVal = dw_Charger.GetItemString ( alCpt, "MT_AVOIR" ) 
sMtRMAvoir = sVal // [PM80_FA12_FRANEX]

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone MT_AVOIR de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False		
	bOkRow = False
End If

If bOkRow And Not IsNumber ( sVal ) Then
	asErreur = 'La valeur "' + sVal + '", $$HEX2$$e0002000$$ENDHEX$$la ligne ' + String ( alCpt ) + " n'est pas valide."
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False		
End If

// [PM80_FA12_FRANEX]
If bOkRow And dec ( sMtRMAvoir ) >= 0 Then
	asErreur = "Le montant du RM avec Avoir doit $$HEX1$$ea00$$ENDHEX$$tre strictement n$$HEX1$$e900$$ENDHEX$$gatif"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False		
End If

sTbFraisAnex[1] =  dw_charger.object.indem_princ_1[alCpt]
sTbFraisAnex[2] =  dw_charger.object.frais_anex_2 [alCpt]		
sTbFraisAnex[3] =  dw_charger.object.frais_anex_3 [alCpt]		
sTbFraisAnex[4] =  dw_charger.object.frais_anex_4 [alCpt]		
sTbFraisAnex[5] =  dw_charger.object.frais_anex_5 [alCpt]		
sTbFraisAnex[6] =  dw_charger.object.frais_anex_6 [alCpt]		
sTbFraisAnex[7] =  dw_charger.object.frais_anex_7 [alCpt]		
sTbFraisAnex[8] =  dw_charger.object.frais_anex_8 [alCpt]		
sTbFraisAnex[9] =  dw_charger.object.frais_anex_9 [alCpt]		
sTbFraisAnex[10] =  dw_charger.object.frais_anex_10 [alCpt]		
sTbFraisAnex[11] =  dw_charger.object.frais_anex_11 [alCpt]	

// Contr$$HEX1$$f400$$ENDHEX$$le que le r$$HEX1$$e800$$ENDHEX$$glement de base ait $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$pass$$HEX2$$e9002000$$ENDHEX$$apr$$HEX1$$e800$$ENDHEX$$s la MEP du PM80, si c'est avant, interdiction de ventiler.
iIdRegBaseIdSeq = -1
iRet = SQLCA.PS_S_PM80_CTRLE_VENTIL_REG_BASE ( lIdSin, iIdRegBaseIdSeq, lIdSeq, dtDteRegBase, dtDtePivotMepPM80, sResult ) 

If iRet < 0 Then
	asErreur = sResult
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False				
End If 

// Remplacer les null par 0 et // aucun montant strictement positif
lTotTbFrais = UpperBound ( sTbFraisAnex ) 

If bOkRow Then
	For lCptTbFrais = 1 To lTotTbFrais 
		If IsNull ( sTbFraisAnex [lCptTbFrais] ) Or Trim ( sTbFraisAnex [lCptTbFrais] ) = "" Then sTbFraisAnex [lCptTbFrais] = "0"
		If Not IsNumber( sTbFraisAnex [lCptTbFrais] ) then
			asErreur += "Les zones de montants de frais doivent $$HEX1$$ea00$$ENDHEX$$tre num$$HEX1$$e900$$ENDHEX$$riques (d$$HEX1$$e900$$ENDHEX$$cimales)"				
			dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
			bOk = False
			bOkRow = False	
		End If 
		
		If bOkRow Then
			if Dec ( sTbFraisAnex [lCptTbFrais]) > 0 Then
				asErreur += "Les zones de montants de frais doivent $$HEX1$$ea00$$ENDHEX$$tre n$$HEX1$$e900$$ENDHEX$$gatives ou $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro"				
				dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
				bOk = False
				bOkRow = False	
			End If 
		End If 
	Next 
End If 

/* Suite mail de Coraline, l'indem princ peut $$HEX1$$ea00$$ENDHEX$$tre $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro	
// Indem Princ doit $$HEX1$$ea00$$ENDHEX$$tre n$$HEX1$$e900$$ENDHEX$$gatif
If bOkRow And dec ( sTbFraisAnex [1] ) >= 0 Then
	asErreur += "Le montant de frais 'Indem. Princ' doit $$HEX1$$ea00$$ENDHEX$$tre strictement n$$HEX1$$e900$$ENDHEX$$gatif"				
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False			
End If 
*/

// La somme des frais de 1 $$HEX2$$e0002000$$ENDHEX$$11 doit $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$gale au montant de facture
If bOkRow Then
	dcSomTbFrais = 0 
	For lCptTbFrais = 1 To lTotTbFrais 
		dcSomTbFrais += dec ( sTbFraisAnex [lCptTbFrais] )
	Next
	
	If dtDteRegBase < dtDtePivotMepPM80 Then
		If dcSomTbFrais <> 0 Then
			asErreur +=	"ERREUR : Ventilation interdite d$$HEX1$$e800$$ENDHEX$$s lors que le r$$HEX1$$e800$$ENDHEX$$glement d'origine (num$$HEX1$$e900$$ENDHEX$$ro " + String ( iIdRegBaseIdSeq ) + ") a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$pass$$HEX2$$e9002000$$ENDHEX$$avant la mise en production du PM80 (r$$HEX1$$e800$$ENDHEX$$glement pass$$HEX2$$e9002000$$ENDHEX$$le " + String ( dtDteRegBase, "dd/mm/yyyy hh:mm:ss") + " et MEP du PM80 le " + String ( dtDtePivotMepPM80, "dd/mm/yyyy hh:mm:ss") + "). Ne passez aucune ventilation, laissez les ventilations vides."			
			dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
			bOk = False
			bOkRow = False				
		End If 			
	ElseIf dec ( sMtRMAvoir ) <> dcSomTbFrais Then
		asErreur += "La somme des frais doit $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$gale au montant du RM factur$$HEX1$$e900$$ENDHEX$$"	
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
		bOk = False
		bOkRow = False				
	End If 
End If 

dw_charger.object.indem_princ_1[alCpt] = sTbFraisAnex[1]
dw_charger.object.frais_anex_2 [alCpt] = sTbFraisAnex[2]
dw_charger.object.frais_anex_3 [alCpt] = sTbFraisAnex[3] 
dw_charger.object.frais_anex_4 [alCpt] = sTbFraisAnex[4] 
dw_charger.object.frais_anex_5 [alCpt] = sTbFraisAnex[5]
dw_charger.object.frais_anex_6 [alCpt] = sTbFraisAnex[6] 
dw_charger.object.frais_anex_7 [alCpt] = sTbFraisAnex[7] 
dw_charger.object.frais_anex_8 [alCpt] = sTbFraisAnex[8] 
dw_charger.object.frais_anex_9 [alCpt] = sTbFraisAnex[9] 
dw_charger.object.frais_anex_10 [alCpt] = sTbFraisAnex[10]
dw_charger.object.frais_anex_11 [alCpt] = sTbFraisAnex[11]	
	

cb_result.Enabled = TRUE

Return bOK
end function

public function boolean wf_controler_rp_avoir_fourn (long alcpt, ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_rp_avoir_fourn
//* Auteur			: JFF
//* Date				: 30/11/2016
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [VDOC12917][PM375-1]
//* Commentaires	: 
//*
//* Arguments		: ref string ascolnames[]
//* 	ref string asvaleurs[]
//* 	ref string aserreur
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 FPI	 01/07/2009	  Am$$HEX1$$e900$$ENDHEX$$lioration : on ne met que la premi$$HEX1$$e800$$ENDHEX$$re erreur
//        JFF   09/09/2022   [PM80_FA12_FRANEX]
//*-----------------------------------------------------------------

n_cst_string uString
boolean bOK, bOkRow
long lPos, lTotRow, lRow, lTotTbFrais, lCptTbFrais, lIdSin, lIdSeq
Int iRet, iIdRegBaseIdSeq
String sVal, sMtRPAvoir
string   sTbFraisAnex[]
Decimal {2} dcSomTbFrais
String sResult  
DateTime dtDteRegBase, dtDtePivotMepPM80

bOk=TRUE
bOkRow = True
sVal = dw_Charger.GetItemString ( alCpt, "ID_SIN_SEQ" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone ID_SIN_SEQ de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

lPos = Pos ( sVal, "-", 1 )
If bOkRow And lPos <= 0 Then 
	asErreur = "ERREUR : La zone ID_SIN_SEQ de la ligne " + String ( alCpt ) + " n'a pas de tiret"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow Then 
	If Not IsNumber ( Left ( sVal, lPos - 1 ) ) Or Not IsNumber ( Right ( sVal, Len ( sVal ) - lPos ) ) Then
		asErreur = "ERREUR : La zone ID_SIN_SEQ de la ligne " + String ( alCpt ) + " n'est pas valide"
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
		bOk = False
		bOkRow = False
	End If
End If 

If bOkRow and dw_Charger.RowCount () > 1 Then 
	lRow = dw_Charger.Find ( "ID_SIN_SEQ= '"+ sVal + "'", 1, dw_Charger.RowCount () )
	If lRow > 0 Then
		If lRow = alCpt Then
			lRow = dw_Charger.Find ( "ID_SIN_SEQ= '"+ sVal + "'", alCpt + 1, dw_Charger.RowCount () )
			If lRow = alCpt Then
				bOkRow = False
			End If
		End If
		If bOkRow And lRow > 0 Then
			asErreur = "ERREUR : La valeur " + sVal + " de la zone ID_SIN_SEQ de la ligne " + String ( alCpt ) + " n'est pas unique dans le fichier."
			dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
			bOk = False
			bOkRow = False
		End If
	End If
End If

// [PM80_FA12_FRANEX]
If bOkRow Then
	lIdSin = Long ( Left ( sVal, lPos - 1 ) ) 
	lIdSeq = Long ( Right ( sVal, Len ( sVal ) - lPos ) ) 
End If 

sVal = dw_Charger.GetItemString ( alCpt, "ID_FOUR" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone ID_FOUR de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And Len ( Trim ( sVal ) ) > 3 Then
	asErreur = "ERREUR : La zone ID_FOUR de la ligne " + String ( alCpt ) + " est trop longue (3 Caract$$HEX1$$e800$$ENDHEX$$re max)"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If


sVal = dw_Charger.GetItemString ( alCpt, "LIB_RP" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone LIB_RP de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And Len ( Trim ( sVal ) ) > 35  Then
	asErreur = "ERREUR : La zone LIB_RP de la ligne " + String ( alCpt ) + " est trop longue (35 car maxi)"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If


sVal = dw_Charger.GetItemString ( alCpt, "MT_AVOIR" ) 
sMtRPAvoir = sVal // [PM80_FA12_FRANEX]

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone MT_AVOIR de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False		
	bOkRow = False
End If

If bOkRow And Not IsNumber ( sVal ) Then
	asErreur = 'La valeur "' + sVal + '", $$HEX2$$e0002000$$ENDHEX$$la ligne ' + String ( alCpt ) + " n'est pas valide."
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False		
End If

// [PM80_FA12_FRANEX]
If bOkRow And dec ( sMtRPAvoir ) <= 0 Then
	asErreur = "Le montant du RP avec Avoir doit $$HEX1$$ea00$$ENDHEX$$tre strictement positif"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False		
End If

sTbFraisAnex[1] =  dw_charger.object.indem_princ_1[alCpt]
sTbFraisAnex[2] =  dw_charger.object.frais_anex_2 [alCpt]		
sTbFraisAnex[3] =  dw_charger.object.frais_anex_3 [alCpt]		
sTbFraisAnex[4] =  dw_charger.object.frais_anex_4 [alCpt]		
sTbFraisAnex[5] =  dw_charger.object.frais_anex_5 [alCpt]		
sTbFraisAnex[6] =  dw_charger.object.frais_anex_6 [alCpt]		
sTbFraisAnex[7] =  dw_charger.object.frais_anex_7 [alCpt]		
sTbFraisAnex[8] =  dw_charger.object.frais_anex_8 [alCpt]		
sTbFraisAnex[9] =  dw_charger.object.frais_anex_9 [alCpt]		
sTbFraisAnex[10] =  dw_charger.object.frais_anex_10 [alCpt]		
sTbFraisAnex[11] =  dw_charger.object.frais_anex_11 [alCpt]	

// Contr$$HEX1$$f400$$ENDHEX$$le que le r$$HEX1$$e800$$ENDHEX$$glement de base ait $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$pass$$HEX2$$e9002000$$ENDHEX$$apr$$HEX1$$e800$$ENDHEX$$s la MEP du PM80, si c'est avant, interdiction de ventiler.
iIdRegBaseIdSeq = -1
iRet = SQLCA.PS_S_PM80_CTRLE_VENTIL_REG_BASE ( lIdSin, iIdRegBaseIdSeq, lIdSeq, dtDteRegBase, dtDtePivotMepPM80, sResult ) 

If iRet < 0 Then
	asErreur = sResult
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False				
End If


// Remplacer les null par 0 et // aucun montant strictement n$$HEX1$$e900$$ENDHEX$$gatif
lTotTbFrais = UpperBound ( sTbFraisAnex ) 

If bOkRow Then
	For lCptTbFrais = 1 To lTotTbFrais 
		If IsNull ( sTbFraisAnex [lCptTbFrais] ) Or Trim ( sTbFraisAnex [lCptTbFrais] ) = "" Then sTbFraisAnex [lCptTbFrais] = "0"
		If Not IsNumber( sTbFraisAnex [lCptTbFrais] ) then
			asErreur += "Les zones de montants de frais doivent $$HEX1$$ea00$$ENDHEX$$tre num$$HEX1$$e900$$ENDHEX$$riques (d$$HEX1$$e900$$ENDHEX$$cimales)"				
			dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
			bOk = False
			bOkRow = False	
		End If 
		
		If bOkRow Then
			if Dec ( sTbFraisAnex [lCptTbFrais])  < 0 Then
				asErreur += "Les zones de montants de frais doivent $$HEX1$$ea00$$ENDHEX$$tre positives ou $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro"				
				dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
				bOk = False
				bOkRow = False	
			End If 
		End If 
	Next 
End If 

/* Suite mail de Coraline, l'indem princ peut $$HEX1$$ea00$$ENDHEX$$tre $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro	
// Indem Princ doit $$HEX1$$ea00$$ENDHEX$$tre positif
If bOkRow And dec ( sTbFraisAnex [1] ) <= 0 Then
	asErreur += "Le montant de frais 'Indem. Princ' doit $$HEX1$$ea00$$ENDHEX$$tre strictement positif"				
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False			
End If 
*/

// La sommes des frais de 1 $$HEX2$$e0002000$$ENDHEX$$11 doit $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$gale au montant de facture
If bOkRow Then
	dcSomTbFrais = 0 
	For lCptTbFrais = 1 To lTotTbFrais 
		dcSomTbFrais += dec ( sTbFraisAnex [lCptTbFrais] )
	Next 

	
	If dtDteRegBase < dtDtePivotMepPM80 Then
		If dcSomTbFrais <> 0 Then
			asErreur +=	"ERREUR : Ventilation interdite d$$HEX1$$e800$$ENDHEX$$s lors que le r$$HEX1$$e800$$ENDHEX$$glement d'origine (num$$HEX1$$e900$$ENDHEX$$ro " + String ( iIdRegBaseIdSeq ) + ") a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$pass$$HEX2$$e9002000$$ENDHEX$$avant la mise en production du PM80 (r$$HEX1$$e800$$ENDHEX$$glement pass$$HEX2$$e9002000$$ENDHEX$$le " + String ( dtDteRegBase, "dd/mm/yyyy hh:mm:ss") + " et MEP du PM80 le " + String ( dtDtePivotMepPM80, "dd/mm/yyyy hh:mm:ss") + "). Ne passez aucune ventilation, laissez les ventilations vides."			
			dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
			bOk = False
			bOkRow = False				
		End If 			
	ElseIf dec ( sMtRPAvoir ) <> dcSomTbFrais Then
		asErreur += "La somme des frais doit $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$gale au montant du RP Factur$$HEX1$$e900$$ENDHEX$$"	
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
		bOk = False
		bOkRow = False				
	End If 
	
End If 

dw_charger.object.indem_princ_1[alCpt] = sTbFraisAnex[1]
dw_charger.object.frais_anex_2 [alCpt] = sTbFraisAnex[2]
dw_charger.object.frais_anex_3 [alCpt] = sTbFraisAnex[3] 
dw_charger.object.frais_anex_4 [alCpt] = sTbFraisAnex[4] 
dw_charger.object.frais_anex_5 [alCpt] = sTbFraisAnex[5]
dw_charger.object.frais_anex_6 [alCpt] = sTbFraisAnex[6] 
dw_charger.object.frais_anex_7 [alCpt] = sTbFraisAnex[7] 
dw_charger.object.frais_anex_8 [alCpt] = sTbFraisAnex[8] 
dw_charger.object.frais_anex_9 [alCpt] = sTbFraisAnex[9] 
dw_charger.object.frais_anex_10 [alCpt] = sTbFraisAnex[10]
dw_charger.object.frais_anex_11 [alCpt] = sTbFraisAnex[11]		
	
cb_result.Enabled = TRUE

Return bOK
end function

public function boolean wf_controler_rp_simple (long alcpt, ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_rp_simple
//* Auteur			: JFF
//* Date				: 30/11/2016
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PM375-1]
//* Commentaires	: 
//*
//* Arguments		: ref string ascolnames[]	 */
/* 	ref string asvaleurs[]	 */
/* 	ref string aserreur	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 FPI	 01/07/2009		Am$$HEX1$$e900$$ENDHEX$$lioration : on ne met que la premi$$HEX1$$e800$$ENDHEX$$re erreur
//        JFF   09/09/2022   [PM80_FA12_FRANEX]
//*-----------------------------------------------------------------

n_cst_string uString
boolean bOK, bOkRow
long lPos, lTotRow, lRow, lTotTbFrais, lCptTbFrais, lIdSin 
Int iRet, iIdRegBase
String sVal, sMtRPsimple, sResult 
string   sTbFraisAnex[]
Decimal {2} dcSomTbFrais
DateTime dtDteRegBase, dtDtePivotMepPM80

bOk=TRUE
bOkRow = True
sVal = dw_Charger.GetItemString ( alCpt, "ID_SIN" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone ID_SIN de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And Not IsNumber ( sVal )  Then
	asErreur = "ERREUR : La zone ID_SIN de la ligne " + String ( alCpt ) + " n'est pas valide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow and dw_Charger.RowCount () > 1 Then
	lRow = dw_Charger.Find ( "ID_SIN= '"+ sVal + "'", 1, dw_Charger.RowCount () )
	If lRow > 0 Then
		If lRow = alCpt Then
			lRow = dw_Charger.Find ( "ID_SIN= '"+ sVal + "'", alCpt + 1, dw_Charger.RowCount () )
			If lRow = alCpt Then
				bOkRow = False
			End If			
		End If
		If bOkRow And lRow > 0 Then
			asErreur = "ERREUR : La valeur " + sVal + " de la zone ID_SIN de la ligne " + String ( alCpt ) + " n'est pas unique dans le fichier."
			dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
			bOk = False
			bOkRow = False
		End If
	End If	
End If	

// [PM80_FA12_FRANEX]
If bOkRow Then
	lIdSin = Long ( sVal ) 
End If 
	
sVal = dw_Charger.GetItemString ( alCpt, "ID_REG_BASE" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone ID_REG_BASE de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If


If bOkRow And Not IsNumber ( sVal )  Then
	asErreur = "ERREUR : La zone ID_REG_BASE de la ligne " + String ( alCpt ) + " n'est pas valide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

// [PM80_FA12_FRANEX]
If bOkRow Then
	iIdRegBase = Integer ( sVal ) 
End If 

sVal = dw_Charger.GetItemString ( alCpt, "MT_RP" ) 
sMtRPsimple = sVal // [PM80_FA12_FRANEX]

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone MT_RP de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False		
	bOkRow = False
End If

If bOkRow And Not IsNumber ( sVal ) Then
	asErreur = 'La valeur "' + sVal + '", $$HEX2$$e0002000$$ENDHEX$$la ligne ' + String ( alCpt ) + " n'est pas valide."
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False		
End If


sVal = dw_Charger.GetItemString ( alCpt, "LIB_RP" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone LIB_RP de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And Len ( Trim ( sVal ) ) > 35  Then
	asErreur = "ERREUR : La zone LIB_RP de la ligne " + String ( alCpt ) + " est trop longue (35 car maxi)"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

// [PM80_FA12_FRANEX]
If bOkRow And dec ( sMtRPsimple ) <= 0 Then
	asErreur = "Le montant du RP simple doit $$HEX1$$ea00$$ENDHEX$$tre strictement positif"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False		
End If	

sTbFraisAnex[1] =  dw_charger.object.indem_princ_1[alCpt]
sTbFraisAnex[2] =  dw_charger.object.frais_anex_2 [alCpt]		
sTbFraisAnex[3] =  dw_charger.object.frais_anex_3 [alCpt]		
sTbFraisAnex[4] =  dw_charger.object.frais_anex_4 [alCpt]		
sTbFraisAnex[5] =  dw_charger.object.frais_anex_5 [alCpt]		
sTbFraisAnex[6] =  dw_charger.object.frais_anex_6 [alCpt]		
sTbFraisAnex[7] =  dw_charger.object.frais_anex_7 [alCpt]		
sTbFraisAnex[8] =  dw_charger.object.frais_anex_8 [alCpt]		
sTbFraisAnex[9] =  dw_charger.object.frais_anex_9 [alCpt]		
sTbFraisAnex[10] =  dw_charger.object.frais_anex_10 [alCpt]		
sTbFraisAnex[11] =  dw_charger.object.frais_anex_11 [alCpt]	

// Contr$$HEX1$$f400$$ENDHEX$$le que le r$$HEX1$$e800$$ENDHEX$$glement de base ait $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$pass$$HEX2$$e9002000$$ENDHEX$$apr$$HEX1$$e800$$ENDHEX$$s la MEP du PM80, si c'est avant, interdiction de ventiler.
iRet = SQLCA.PS_S_PM80_CTRLE_VENTIL_REG_BASE ( lIdSin, iIdRegbase, -1, dtDteRegBase, dtDtePivotMepPM80, sResult ) 

If iRet < 0 Then
	asErreur = sResult
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False				
End If 		

// Remplacer les null par 0 et // aucun montant strictement n$$HEX1$$e900$$ENDHEX$$gatif
lTotTbFrais = UpperBound ( sTbFraisAnex ) 

If bOkRow Then
	For lCptTbFrais = 1 To lTotTbFrais 
		If IsNull ( sTbFraisAnex [lCptTbFrais] ) Or Trim ( sTbFraisAnex [lCptTbFrais] ) = "" Then sTbFraisAnex [lCptTbFrais] = "0"
		If Not IsNumber( sTbFraisAnex [lCptTbFrais] ) then
			asErreur += "Les zones de montants de frais doivent $$HEX1$$ea00$$ENDHEX$$tre num$$HEX1$$e900$$ENDHEX$$riques (d$$HEX1$$e900$$ENDHEX$$cimales)"				
			dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
			bOk = False
			bOkRow = False	
		End If 
		
		If bOkRow Then
			if Dec ( sTbFraisAnex [lCptTbFrais])  < 0 Then
				asErreur += "Les zones de montants de frais doivent $$HEX1$$ea00$$ENDHEX$$tre positives ou $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro !"				
				dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
				bOk = False
				bOkRow = False	
			End If 
		End If 
	Next 
End If 

/* Suite mail de Coraline, l'indem princ peut $$HEX1$$ea00$$ENDHEX$$tre $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro	
// Indem Princ doit $$HEX1$$ea00$$ENDHEX$$tre positif
If bOkRow And dec ( sTbFraisAnex [1] ) <= 0 Then
	asErreur += "Le montant de frais 'Indem. Princ' doit $$HEX1$$ea00$$ENDHEX$$tre strictement positif !"				
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False			
End If 
*/

// La sommes des frais de 1 $$HEX2$$e0002000$$ENDHEX$$11 doit $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$gale au montant de facture
If bOkRow Then
	dcSomTbFrais = 0 
	For lCptTbFrais = 1 To lTotTbFrais 
		dcSomTbFrais += dec ( sTbFraisAnex [lCptTbFrais] )
	Next

	If dtDteRegBase < dtDtePivotMepPM80 Then
		If dcSomTbFrais <> 0 Then
			asErreur +=	"ERREUR : Ventilation interdite d$$HEX1$$e800$$ENDHEX$$s lors que le r$$HEX1$$e800$$ENDHEX$$glement d'origine (num$$HEX1$$e900$$ENDHEX$$ro " + String ( iIdRegBase ) + ") a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$pass$$HEX2$$e9002000$$ENDHEX$$avant la mise en production du PM80 (r$$HEX1$$e800$$ENDHEX$$glement pass$$HEX2$$e9002000$$ENDHEX$$le " + String ( dtDteRegBase, "dd/mm/yyyy hh:mm:ss") + " et MEP du PM80 le " + String ( dtDtePivotMepPM80, "dd/mm/yyyy hh:mm:ss") + "). Ne passez aucune ventilation, laissez les ventilations vides."			
			dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
			bOk = False
			bOkRow = False				
		End If 			
	ElseIf dec ( sMtRPsimple ) <> dcSomTbFrais Then
		asErreur += "La somme des frais doit $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$gale au montant du RP simple"	
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
		bOk = False
		bOkRow = False				
	End If 
End If 

dw_charger.object.indem_princ_1[alCpt] = sTbFraisAnex[1]
dw_charger.object.frais_anex_2 [alCpt] = sTbFraisAnex[2]
dw_charger.object.frais_anex_3 [alCpt] = sTbFraisAnex[3] 
dw_charger.object.frais_anex_4 [alCpt] = sTbFraisAnex[4] 
dw_charger.object.frais_anex_5 [alCpt] = sTbFraisAnex[5]
dw_charger.object.frais_anex_6 [alCpt] = sTbFraisAnex[6] 
dw_charger.object.frais_anex_7 [alCpt] = sTbFraisAnex[7] 
dw_charger.object.frais_anex_8 [alCpt] = sTbFraisAnex[8] 
dw_charger.object.frais_anex_9 [alCpt] = sTbFraisAnex[9] 
dw_charger.object.frais_anex_10 [alCpt] = sTbFraisAnex[10]
dw_charger.object.frais_anex_11 [alCpt] = sTbFraisAnex[11]		


cb_result.Enabled = TRUE
	
Return bOK
end function

public function boolean wf_controler_rm_simple (long alcpt, ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_rm_simple
//* Auteur			: JFF
//* Date				: 30/11/2016
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PM375-1]
//* Commentaires	: 
//*
//* Arguments		: ref string ascolnames[]	 */
/* 	ref string asvaleurs[]	 */
/* 	ref string aserreur	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 FPI	 01/07/2009		Am$$HEX1$$e900$$ENDHEX$$lioration : on ne met que la premi$$HEX1$$e800$$ENDHEX$$re erreur
//        JFF   09/09/2022 [PM80_FA12_FRANEX]
//*-----------------------------------------------------------------

n_cst_string uString
boolean bOK, bOkRow
long lPos, lTotRow, lRow, lTotTbFrais, lCptTbFrais, lIdSin
Int iRet, iIdRegBase
String sVal, sMtRMsimple, sResult 
string   sTbFraisAnex[]
Decimal {2} dcSomTbFrais
DateTime dtDteRegBase, dtDtePivotMepPM80

bOk=TRUE
bOkRow = True
sVal = dw_Charger.GetItemString ( alCpt, "ID_SIN" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone ID_SIN de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And Not IsNumber ( sVal )  Then
	asErreur = "ERREUR : La zone ID_SIN de la ligne " + String ( alCpt ) + " n'est pas valide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow and dw_Charger.RowCount () > 1 Then
	lRow = dw_Charger.Find ( "ID_SIN= '"+ sVal + "'", 1, dw_Charger.RowCount () )
	If lRow > 0 Then
		If lRow = alCpt Then
			lRow = dw_Charger.Find ( "ID_SIN= '"+ sVal + "'", alCpt + 1, dw_Charger.RowCount () )
			If lRow = alCpt Then
				bOkRow = False
			End If			
		End If
		If bOkRow And lRow > 0 Then
			asErreur = "ERREUR : La valeur " + sVal + " de la zone ID_SIN de la ligne " + String ( alCpt ) + " n'est pas unique dans le fichier."
			dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
			bOk = False
			bOkRow = False
		End If
	End If	
End If	

// [PM80_FA12_FRANEX]
If bOkRow Then
	lIdSin = Long ( sVal ) 
End If 

sVal = dw_Charger.GetItemString ( alCpt, "ID_REG_BASE" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone ID_REG_BASE de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If


If bOkRow And Not IsNumber ( sVal )  Then
	asErreur = "ERREUR : La zone ID_REG_BASE de la ligne " + String ( alCpt ) + " n'est pas valide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

// [PM80_FA12_FRANEX]
If bOkRow Then
	iIdRegBase = Integer ( sVal ) 
End If 


sVal = dw_Charger.GetItemString ( alCpt, "MT_RM" ) 
sMtRMsimple = sVal // [PM80_FA12_FRANEX]

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone MT_RM de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False		
	bOkRow = False
End If

If bOkRow And Not IsNumber ( sVal ) Then
	asErreur = 'La valeur "' + sVal + '", $$HEX2$$e0002000$$ENDHEX$$la ligne ' + String ( alCpt ) + " n'est pas valide."
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False		
End If

sVal = dw_Charger.GetItemString ( alCpt, "LIB_RM" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone LIB_RM de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And Len ( Trim ( sVal ) ) > 35  Then
	asErreur = "ERREUR : La zone LIB_RM de la ligne " + String ( alCpt ) + " est trop longue (35 car maxi)"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

// [PM80_FA12_FRANEX]
If bOkRow And dec ( sMtRMsimple ) >= 0 Then
	asErreur = "Le montant du RM simple doit $$HEX1$$ea00$$ENDHEX$$tre strictement n$$HEX1$$e900$$ENDHEX$$gatif"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False		
End If	

sTbFraisAnex[1] =  dw_charger.object.indem_princ_1[alCpt]
sTbFraisAnex[2] =  dw_charger.object.frais_anex_2 [alCpt]		
sTbFraisAnex[3] =  dw_charger.object.frais_anex_3 [alCpt]		
sTbFraisAnex[4] =  dw_charger.object.frais_anex_4 [alCpt]		
sTbFraisAnex[5] =  dw_charger.object.frais_anex_5 [alCpt]		
sTbFraisAnex[6] =  dw_charger.object.frais_anex_6 [alCpt]		
sTbFraisAnex[7] =  dw_charger.object.frais_anex_7 [alCpt]		
sTbFraisAnex[8] =  dw_charger.object.frais_anex_8 [alCpt]		
sTbFraisAnex[9] =  dw_charger.object.frais_anex_9 [alCpt]		
sTbFraisAnex[10] =  dw_charger.object.frais_anex_10 [alCpt]		
sTbFraisAnex[11] =  dw_charger.object.frais_anex_11 [alCpt]	

	// Contr$$HEX1$$f400$$ENDHEX$$le que le r$$HEX1$$e800$$ENDHEX$$glement de base ait $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$pass$$HEX2$$e9002000$$ENDHEX$$apr$$HEX1$$e800$$ENDHEX$$s la MEP du PM80, si c'est avant, interdiction de ventiler.
iRet = SQLCA.PS_S_PM80_CTRLE_VENTIL_REG_BASE ( lIdSin, iIdRegbase, -1, dtDteRegBase, dtDtePivotMepPM80, sResult ) 

If iRet < 0 Then
	asErreur = sResult
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False				
End If 	

// Remplacer les null par 0 et // aucun montant strictement positif
lTotTbFrais = UpperBound ( sTbFraisAnex ) 

If bOkRow Then
	For lCptTbFrais = 1 To lTotTbFrais 
		If IsNull ( sTbFraisAnex [lCptTbFrais] ) Or Trim ( sTbFraisAnex [lCptTbFrais] ) = "" Then sTbFraisAnex [lCptTbFrais] = "0"
		If Not IsNumber( sTbFraisAnex [lCptTbFrais] ) then
			asErreur += "Les zones de montants de frais doivent $$HEX1$$ea00$$ENDHEX$$tre num$$HEX1$$e900$$ENDHEX$$riques (d$$HEX1$$e900$$ENDHEX$$cimales)"				
			dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
			bOk = False
			bOkRow = False	
		End If 
		
		If bOkRow Then
			if Dec ( sTbFraisAnex [lCptTbFrais]) > 0 Then
				asErreur += "Les zones de montants de frais doivent $$HEX1$$ea00$$ENDHEX$$tre n$$HEX1$$e900$$ENDHEX$$gatives ou $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro"				
				dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
				bOk = False
				bOkRow = False	
			End If 
		End If 
	Next 
End If 

/* Suite mail de Coraline, l'indem princ peut $$HEX1$$ea00$$ENDHEX$$tre $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro	
// Indem Princ doit $$HEX1$$ea00$$ENDHEX$$tre n$$HEX1$$e900$$ENDHEX$$gatif
If bOkRow And dec ( sTbFraisAnex [1] ) >= 0 Then
	asErreur += "Le montant de frais 'Indem. Princ' doit $$HEX1$$ea00$$ENDHEX$$tre strictement n$$HEX1$$e900$$ENDHEX$$gatif"				
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False			
End If 
*/

// La somme des frais de 1 $$HEX2$$e0002000$$ENDHEX$$11 doit $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$gale au montant de facture
If bOkRow Then
	dcSomTbFrais = 0 
	For lCptTbFrais = 1 To lTotTbFrais 
		dcSomTbFrais += dec ( sTbFraisAnex [lCptTbFrais] )
	Next 

	If dtDteRegBase < dtDtePivotMepPM80 Then
		If dcSomTbFrais <> 0 Then
			asErreur +=	"ERREUR : Ventilation interdite d$$HEX1$$e800$$ENDHEX$$s lors que le r$$HEX1$$e800$$ENDHEX$$glement d'origine (num$$HEX1$$e900$$ENDHEX$$ro " + String ( iIdRegBase ) + ") a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$pass$$HEX2$$e9002000$$ENDHEX$$avant la mise en production du PM80 (r$$HEX1$$e800$$ENDHEX$$glement pass$$HEX2$$e9002000$$ENDHEX$$le " + String ( dtDteRegBase, "dd/mm/yyyy hh:mm:ss") + " et MEP du PM80 le " + String ( dtDtePivotMepPM80, "dd/mm/yyyy hh:mm:ss") + "). Ne passez aucune ventilation, laissez les ventilations vides."			
			dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
			bOk = False
			bOkRow = False				
		End If 			
	ElseIf dec ( sMtRMsimple ) <> dcSomTbFrais Then
		asErreur += "La somme des frais doit $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$gale au montant du RM simple"	
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
		bOk = False
		bOkRow = False				
	End If 
	
End If 

dw_charger.object.indem_princ_1[alCpt] = sTbFraisAnex[1]
dw_charger.object.frais_anex_2 [alCpt] = sTbFraisAnex[2]
dw_charger.object.frais_anex_3 [alCpt] = sTbFraisAnex[3] 
dw_charger.object.frais_anex_4 [alCpt] = sTbFraisAnex[4] 
dw_charger.object.frais_anex_5 [alCpt] = sTbFraisAnex[5]
dw_charger.object.frais_anex_6 [alCpt] = sTbFraisAnex[6] 
dw_charger.object.frais_anex_7 [alCpt] = sTbFraisAnex[7] 
dw_charger.object.frais_anex_8 [alCpt] = sTbFraisAnex[8] 
dw_charger.object.frais_anex_9 [alCpt] = sTbFraisAnex[9] 
dw_charger.object.frais_anex_10 [alCpt] = sTbFraisAnex[10]
dw_charger.object.frais_anex_11 [alCpt] = sTbFraisAnex[11]
		
cb_result.Enabled = TRUE


Return bOK
end function

public function boolean wf_controler_rn_frais_factu (long alcpt, ref string aserreur);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_autre_fichier::wf_controler_rn_Frais_Factu
//* Auteur			: JFF
//* Date				: 30/11/2016
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PM375-1]
//* Commentaires	: 
//*
//* Arguments		: ref string ascolnames[]	 */
/* 	ref string asvaleurs[]	 */
/* 	ref string aserreur	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 FPI	 01/07/2009		Am$$HEX1$$e900$$ENDHEX$$lioration : on ne met que la premi$$HEX1$$e800$$ENDHEX$$re erreur
//        JFF   09/09/2022    [PM80_FA12_FRANEX]
//*-----------------------------------------------------------------

n_cst_string uString
boolean bOK, bOkRow
long lPos, lTotRow, lRow, lTotTbFrais, lCptTbFrais
String sVal, sMtRNfrais
string   sTbFraisAnex[]
Decimal {2} dcSomTbFrais

bOk=TRUE
bOkRow = True
sVal = dw_Charger.GetItemString ( alCpt, "ID_SIN" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone ID_SIN de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And Not IsNumber ( sVal )  Then
	asErreur = "ERREUR : La zone ID_SIN de la ligne " + String ( alCpt ) + " n'est pas valide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow and dw_Charger.RowCount () > 1 Then
	lRow = dw_Charger.Find ( "ID_SIN= '"+ sVal + "'", 1, dw_Charger.RowCount () )
	If lRow > 0 Then
		If lRow = alCpt Then
			lRow = dw_Charger.Find ( "ID_SIN= '"+ sVal + "'", alCpt + 1, dw_Charger.RowCount () )
			If lRow = alCpt Then
				bOkRow = False
			End If			
		End If
		If bOkRow And lRow > 0 Then
			asErreur = "ERREUR : La valeur " + sVal + " de la zone ID_SIN de la ligne " + String ( alCpt ) + " n'est pas unique dans le fichier."
			dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
			bOk = False
			bOkRow = False
		End If
	End If
End If	
	
sVal = dw_Charger.GetItemString ( alCpt, "MT_RN" ) 
sMtRNfrais = sVal // [PM80_FA12_FRANEX]

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone MT_RN de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False		
	bOkRow = False
End If

If bOkRow And Not IsNumber ( sVal ) Then
	asErreur = 'La valeur "' + sVal + '", $$HEX2$$e0002000$$ENDHEX$$la ligne ' + String ( alCpt ) + " n'est pas valide."
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False		
End If


sVal = dw_Charger.GetItemString ( alCpt, "LIB_RN" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone LIB_RN de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And Len ( Trim ( sVal ) ) > 35  Then
	asErreur = "ERREUR : La zone LIB_RP de la ligne " + String ( alCpt ) + " est trop longue (35 car maxi)"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

sVal = dw_Charger.GetItemString ( alCpt, "ID_FOUR_FCT" )

If bOkRow And ( IsNull ( sVal ) Or Len ( Trim ( sVal ) ) <= 0 ) Then
	asErreur = "ERREUR : La zone ID_FOUR_FCT de la ligne " + String ( alCpt ) + " est vide"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If

If bOkRow And Len ( Trim ( sVal ) ) > 3 Then
	asErreur = "ERREUR : La zone ID_FOUR_FCT de la ligne " + String ( alCpt ) + " est trop longue (3 Caract$$HEX1$$e800$$ENDHEX$$re max)"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )
	bOk = False
	bOkRow = False
End If	

// [PM80_FA12_FRANEX]
If bOkRow And dec ( sMtRNfrais ) <= 0 Then
	asErreur = "Le montant du RN de frais doit $$HEX1$$ea00$$ENDHEX$$tre strictement positif"
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False		
End If	

sTbFraisAnex[1] =  dw_charger.object.indem_princ_1[alCpt]
sTbFraisAnex[2] =  dw_charger.object.frais_anex_2 [alCpt]		
sTbFraisAnex[3] =  dw_charger.object.frais_anex_3 [alCpt]		
sTbFraisAnex[4] =  dw_charger.object.frais_anex_4 [alCpt]		
sTbFraisAnex[5] =  dw_charger.object.frais_anex_5 [alCpt]		
sTbFraisAnex[6] =  dw_charger.object.frais_anex_6 [alCpt]		
sTbFraisAnex[7] =  dw_charger.object.frais_anex_7 [alCpt]		
sTbFraisAnex[8] =  dw_charger.object.frais_anex_8 [alCpt]		
sTbFraisAnex[9] =  dw_charger.object.frais_anex_9 [alCpt]		
sTbFraisAnex[10] =  dw_charger.object.frais_anex_10 [alCpt]		
sTbFraisAnex[11] =  dw_charger.object.frais_anex_11 [alCpt]	

// Remplacer les null par 0 et // aucun montant strictement n$$HEX1$$e900$$ENDHEX$$gatif
lTotTbFrais = UpperBound ( sTbFraisAnex ) 

If bOkRow Then
	For lCptTbFrais = 1 To lTotTbFrais 
		If IsNull ( sTbFraisAnex [lCptTbFrais] ) Or Trim ( sTbFraisAnex [lCptTbFrais] ) = "" Then sTbFraisAnex [lCptTbFrais] = "0"
		If Not IsNumber( sTbFraisAnex [lCptTbFrais] ) then
			asErreur += "Les zones de montants de frais doivent $$HEX1$$ea00$$ENDHEX$$tre num$$HEX1$$e900$$ENDHEX$$riques (d$$HEX1$$e900$$ENDHEX$$cimales)"				
			dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
			bOk = False
			bOkRow = False	
		End If 
		
		If bOkRow Then
			if Dec ( sTbFraisAnex [lCptTbFrais])  < 0 Then
				asErreur += "Les zones de montants de frais doivent $$HEX1$$ea00$$ENDHEX$$tre positives ou $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro !"				
				dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
				bOk = False
				bOkRow = False	
			End If 
		End If 
	Next 
End If 

/*
// Indem Princ doit $$HEX1$$ea00$$ENDHEX$$tre positif
If bOkRow And dec ( sTbFraisAnex [1] ) <= 0 Then
	asErreur += "Le montant de frais 'Indem. Princ' doit $$HEX1$$ea00$$ENDHEX$$tre strictement positif"				
	dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
	bOk = False
	bOkRow = False			
End If 
*/

// La sommes des frais de 1 $$HEX2$$e0002000$$ENDHEX$$11 doit $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$gale au montant de facture
If bOkRow Then
	dcSomTbFrais = 0 
	For lCptTbFrais = 1 To lTotTbFrais 
		dcSomTbFrais += dec ( sTbFraisAnex [lCptTbFrais] )
	Next 
	If dec ( sMtRNfrais ) <> dcSomTbFrais Then
		asErreur += "La somme des frais doit $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$gale au montant du RN de frais"	
		dw_Charger.SetItem ( alCpt, "RESULT_TRT", asErreur )		
		bOk = False
		bOkRow = False				
	End If 
End If 
		

cb_result.Enabled = TRUE

Return bOK
end function

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Trt_Extr1::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: PHG, d'apr$$HEX1$$e800$$ENDHEX$$s JFF ( w_sp_trt_stat3 )
//* Date				: 20/11/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JCA	22/02/2007	DCMP 070110 - Ajout du fournisseur Darty
//* #2	PHG	13/06/2008	[DCMP080461] Int$$HEX1$$e900$$ENDHEX$$gration FActuration Hors Prestation
//			FPI	03/12/2010	[PC175] Ajout d'un traitement Opcon
//			FPI	15/02/2012	[PM200][PSM]
//			FPI	17/05/2013	[PC938]
//				FPI	18/09/2013	[VDOC12140]
//*-----------------------------------------------------------------

DataWindowChild dwChild
Long lRow, lCpt
Long lTrouve

This.Title = "Int$$HEX1$$e900$$ENDHEX$$gration autre fichier"

dw_Fourn.Reset ()
dw_Fourn.InsertRow ( 0 )

dw_Fourn.GetChild ( "ID_TT", dwChild )
dwChild.SetTransObject ( SQLCA )
lRow = dwChild.Retrieve ( "-TT" )

isCasTailleFen = "REDUIRE"

/*------------------------------------------------------------------*/
/*[PC175] Lancement automatique par OpCon/XPS                              */
/*------------------------------------------------------------------*/
If gbOpCon Then
	If This.wf_Sortie_OpCon ( "INIT", 0, "", FALSE ) < 0 Then Halt
	
		wf_opcon_btq_mcm( )
	
		wf_opcon_btq_psm()
	
		// [PC938]
		//wf_opcon_imei_orange( ) // [ITSM212977]
	
	If This.wf_Sortie_OpCon ( "FIN_TRT", 0, "", FALSE ) < 0 Then Halt
	pb_Retour.PostEvent ( Clicked! )
End If

end event

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_autofact
//* Evenement     : Show
//* Auteur        : FPI
//* Date          : 12/12/2008
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Chargement des donn$$HEX1$$e900$$ENDHEX$$es
//* Commentaires  : [DCMP80862]
//*
//* Arguments     : Aucun
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     	Modification
//			FPI		11/10/2013	[VDOC12140]
//			JFF		27/01/2014	[VDOC12917]
//*-----------------------------------------------------------------
integer iNull
Long lCpt

// [VDOC12140]
If gbOpCon Then
	If This.wf_Sortie_OpCon ( "INIT", 0, "", FALSE ) < 0 Then Halt
	For lCpt=1 To UpperBound(stglb.stab_opcon_xps)
		
		Choose case stGlb.sMessageErreur
			Case "INT_BOUTIQUE"
				wf_opcon_boutique(stglb.stab_opcon_xps [lCpt] )
			Case "INT_IMEI"
				// Pas de contr$$HEX1$$f400$$ENDHEX$$le de la section car que IMEI Orange pour l'instant
				//wf_opcon_imei_orange( )  // [ITSM212977]
		End Choose
	Next

	If This.wf_Sortie_OpCon ( "FIN_TRT", 0, "", FALSE ) < 0 Then Halt
	pb_Retour.PostEvent ( Clicked! )
End if
// :[VDOC12140]



setnull(iNull)

cb_Charger.Enabled = FALSE
cb_result.Enabled = FALSE  // [VDOC12917]
cb_Annuler.Enabled = False
cb_Controler.Enabled = False
cb_Maj.Enabled = False
hpb_trt.Position = 0
wf_pct ()
Yield ()
	
st_charger.Text = ""
st_Extraire.Text = ""

dw_fourn.SetItem ( 1, "ID_TT", iNull )
dw_fourn.AcceptText()

st_1.Visible = true 

Dw_Charger.Reset ()

if isvalid(ids_Charger) then ids_Charger.reset ()

st_extraire.textcolor = 16711680
st_extraire.backcolor = 67108864

end event

on w_sp_trt_autre_fichier.create
int iCurrent
call super::create
this.cb_charger=create cb_charger
this.cb_annuler=create cb_annuler
this.st_charger=create st_charger
this.st_extraire=create st_extraire
this.cb_controler=create cb_controler
this.dw_fourn=create dw_fourn
this.cb_maj=create cb_maj
this.dw_charger=create dw_charger
this.hpb_trt=create hpb_trt
this.st_1=create st_1
this.st_avertissement_monnaie=create st_avertissement_monnaie
this.lb_filelist=create lb_filelist
this.cb_result=create cb_result
this.cb_taillefen=create cb_taillefen
this.st_pct=create st_pct
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_charger
this.Control[iCurrent+2]=this.cb_annuler
this.Control[iCurrent+3]=this.st_charger
this.Control[iCurrent+4]=this.st_extraire
this.Control[iCurrent+5]=this.cb_controler
this.Control[iCurrent+6]=this.dw_fourn
this.Control[iCurrent+7]=this.cb_maj
this.Control[iCurrent+8]=this.dw_charger
this.Control[iCurrent+9]=this.hpb_trt
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.st_avertissement_monnaie
this.Control[iCurrent+12]=this.lb_filelist
this.Control[iCurrent+13]=this.cb_result
this.Control[iCurrent+14]=this.cb_taillefen
this.Control[iCurrent+15]=this.st_pct
end on

on w_sp_trt_autre_fichier.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_charger)
destroy(this.cb_annuler)
destroy(this.st_charger)
destroy(this.st_extraire)
destroy(this.cb_controler)
destroy(this.dw_fourn)
destroy(this.cb_maj)
destroy(this.dw_charger)
destroy(this.hpb_trt)
destroy(this.st_1)
destroy(this.st_avertissement_monnaie)
destroy(this.lb_filelist)
destroy(this.cb_result)
destroy(this.cb_taillefen)
destroy(this.st_pct)
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_autofact
//* Evenement 		: close
//* Auteur			: Pierre-Henri Gillot
//* Date				: 23/11/2006 13:27:36
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

if isCasTailleFen = "AGRANDIR" Then cb_taillefen.TriggerEvent ( "clicked" ) 

if isvalid(ids_charger) then destroy ids_charger
end event

type cb_debug from w_8_accueil`cb_debug within w_sp_trt_autre_fichier
end type

type pb_retour from w_8_accueil`pb_retour within w_sp_trt_autre_fichier
integer width = 242
integer height = 144
integer taborder = 130
end type

type pb_interro from w_8_accueil`pb_interro within w_sp_trt_autre_fichier
boolean visible = false
integer taborder = 150
boolean enabled = false
end type

type pb_creer from w_8_accueil`pb_creer within w_sp_trt_autre_fichier
boolean visible = false
integer taborder = 140
boolean enabled = false
end type

type dw_1 from w_8_accueil`dw_1 within w_sp_trt_autre_fichier
integer x = 32
integer y = 1492
integer width = 302
integer height = 244
integer taborder = 30
end type

type pb_tri from w_8_accueil`pb_tri within w_sp_trt_autre_fichier
boolean visible = false
integer taborder = 160
boolean enabled = false
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_sp_trt_autre_fichier
integer taborder = 20
end type

type cb_charger from commandbutton within w_sp_trt_autre_fichier
integer x = 101
integer y = 312
integer width = 873
integer height = 172
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Charger le fichier"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_autofact::cb_Charger
//* Evenement     : Clicked
//* Auteur        : PHG, d'apr$$HEX1$$e800$$ENDHEX$$s JFF ( w_sp_trt_stat3 )
//* Date          : 20/11/2006
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Chargement des donn$$HEX1$$e900$$ENDHEX$$es
//* Commentaires  : Chargement des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences commandes SPB se trouvant
//*					  sur C:\WINNT\TEMP\DEVIS.TXT
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//* #1	 CAG	 06/11/2002	  Modification SFR # Ajout du ctrl facturation CEGETEL
//* #2	 CAG	 30/01/2003	  Annexe 22 : Ajout du bouton maj cod_etat = "RPC"
//* #3	 PHG	 16/06/2008	 [DCMP080461] Int$$HEX1$$e900$$ENDHEX$$gration Facturation Hors Prestation
//*-----------------------------------------------------------------

String	sModif

If Parent.wf_ChargerDonnees () Then 

	cb_Charger.Enabled = False
	cb_Annuler.Enabled = True
	cb_Controler.Enabled = True

	/*------------------------------------------------------------------*/
	/* #2                                                               */
	/*------------------------------------------------------------------*/
	cb_Maj.Enabled = False

	hpb_trt.Position = 0
	wf_pct ()
	Yield ()	
	/*------------------------------------------------------------------*/
	/* #1                                                               */
	/*------------------------------------------------------------------*/
	sModif  = "ID_FOURN.protect = 1 ID_FOURN.background.color = 12632256 ID_FOURN.border = 6"
	// #3 [DCMP080461] LA dddw du choix de type de FActu est non accesssible.
	sModif += " ID_TYP_FACT.protect = 1 ID_TYP_FACT.background.color = 12632256 ID_TYP_FACT.border = 6"
	//
	dw_Fourn.Modify ( sModif )

End If


end event

type cb_annuler from commandbutton within w_sp_trt_autre_fichier
integer x = 101
integer y = 484
integer width = 873
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annuler le chargement"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_extr1::cb_Annuler
//* Evenement     : cb_Annuler
//* Auteur        : PHG, d'apr$$HEX1$$e800$$ENDHEX$$s JFF ( w_sp_trt_stat3 )
//* Date          : 20/11/2006
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

Parent.TriggerEvent ("show")

end on

type st_charger from statictext within w_sp_trt_autre_fichier
integer x = 1088
integer y = 1484
integer width = 2482
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_extraire from statictext within w_sp_trt_autre_fichier
integer x = 1088
integer y = 1580
integer width = 2482
integer height = 152
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_controler from commandbutton within w_sp_trt_autre_fichier
integer x = 101
integer y = 580
integer width = 873
integer height = 172
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Contr$$HEX1$$f400$$ENDHEX$$ler les donn$$HEX1$$e900$$ENDHEX$$es charg$$HEX1$$e900$$ENDHEX$$es"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_autofact::cb_Controler
//* Evenement     : Clicked
//* Auteur        : PHG, d'apr$$HEX1$$e800$$ENDHEX$$s JFF ( w_sp_trt_stat3 )
//* Date          : 20/11/2006
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Controle des donn$$HEX1$$e900$$ENDHEX$$es
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	    	Modification
//*-----------------------------------------------------------------

If Parent.wf_Controler () Then
	
	cb_Charger.Enabled = False
	cb_Annuler.Enabled = True
	cb_Controler.Enabled = False
	cb_Maj.enabled = True
	
	hpb_trt.Position = 0
	wf_pct ()
	Yield ()	
End If

end event

type dw_fourn from datawindow within w_sp_trt_autre_fichier
integer x = 1362
integer y = 176
integer width = 1929
integer height = 120
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_choix_type_trt"
boolean border = false
boolean livescroll = true
end type

event itemchanged;
//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_autofact::dw_Fourn
//* Evenement     : ItemChanged
//* Auteur        : FPI
//* Date          : 12/12/2006
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Choix du type de traitement
//* Commentaires  : 
//*
//* Arguments     : Aucun
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 FPI		31/07/2009	[CAMARA] Changement de libell$$HEX2$$e9002000$$ENDHEX$$des boutons
//* #2	FPI		19/02/2010	[DCMP100102] Ajout du traitement 6
// 			FPI		19/09/2016	[VDOC19525]
//			FPI		04/11/2016	 [VDOC22119]
//			FPI		13/02/2017	 [VDOC23002]
// 			FPI		26/12/2017	[VDOC24986]
// 			FPI		21/02/2018	[VDOC25758]
// 			FPI		07/10/2019	[VDOC28472]
//*-----------------------------------------------------------------
integer iActionCode
boolean bOkToProcess
n_cst_string lnvString

iActionCode=0

bOkToProcess = Not lnvString.of_isEmpty(data) 
	
cb_Charger.Enabled = bOkToProcess

st_1.visible = false 

// #1
Choose case long(data)
	Case K_TYPTRT_CAMARA
		cb_charger.Text = "Charger les Factures $$HEX2$$e0002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$gler" 
		cb_maj.Text = "Extraction et marquage en base"
	Case  K_TYPTRT_LST_SIN, K_TYPTRT_LST_CMDE_O2M, K_TYPTRT_LST_CMDE_CDS, K_TYPTRT_LST_CMDE_CFM, K_TYPTRT_LST_SIN_CASTO, K_TYPTRT_LST_SIN_REG, K_TYPTRT_LST_RM, K_TYPTRT_LST_REG,K_TYPTRT_LST_CMDE, K_TYPTRT_LST_FACTU_CASTO, K_TYPTRT_LST_CMDE_AUC, K_TYPTRT_LST_FACT
		cb_charger.Text = "Charger le fichier"
		cb_maj.Text = "Lancer l'extraction"
	Case Else
		// Textes par d$$HEX1$$e900$$ENDHEX$$faut
		cb_charger.Text = "Charger le fichier"
		cb_maj.Text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour en base"
End choose

st_charger.Text=""
st_extraire.Text=""

return iActionCode

end event

event itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Fourn::ItemError
//* Evenement 		: ItemError
//* Auteur			: JCA
//* Date				: 26/02/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des Erreurs 
//* 						DCMP 070110 - Ajout du fournisseur Darty
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
// 			FPI		[PC175] Ajout gbOpcon
//*-----------------------------------------------------------------

stMessage.sTitre	= "Gestion de la facturation fournisseur"
stMessage.Icon		= Information!

If gbOpcon Then return 1 // [PC175]

Choose Case dwo.name
Case "id_fourn"
	stMessage.bErreurG	= False
	stMessage.sVar[1] 	= "Saisie du fournisseur"
	stMessage.sCode		= "GENE154"
	setnull(data)
	
	cb_charger.enabled = false
	f_message ( stMessage )
End Choose

This.SetItem ( row, dwo.name, data )

return 1

end event

type cb_maj from commandbutton within w_sp_trt_autre_fichier
integer x = 101
integer y = 752
integer width = 873
integer height = 172
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour en base"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_autofact::cb_Maj
//* Evenement     : Clicked
//* Auteur        : PHG
//* Date          : 21/11/2006
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Lancement du traitement
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Boolean bRet

cb_Maj.Enabled = False
cb_Annuler.Enabled = False
pb_retour.enabled = False

SetPointer(HourGlass!)
If Parent.wf_Maj () Then 
	cb_Charger.Enabled = False
	cb_Controler.Enabled = False
End If
cb_Annuler.Enabled = True
pb_retour.Enabled = True

SetPointer(Arrow!)


end event

type dw_charger from datawindow within w_sp_trt_autre_fichier
integer x = 1088
integer y = 312
integer width = 2482
integer height = 1064
integer taborder = 110
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemerror;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_autofact
//* Evenement 		: itemerror
//* Auteur			: PHG
//* Date				: 17/06/2008 11:27:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 	[DCMP080496] On intercepte les erreur 
//*						pour ne pas avoir le msg standard d'erreur 
//*						d'import des dw.
//*				  
//* Arguments		: value long row	 */
/* 	value dwobject dwo	 */
/* 	value string data	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
// Return Code :
//
//return 0  	// (Default) Reject the data value and show an error message box
return 1  	// Reject the data value with no message box
				// ne permet pas d'enlever le msg box de question pour continuer l'import
//return 2  	// Accept the data value
//return 3  	// Reject the data value but allow focus to change

end event

event getfocus;
//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_autre_fichier::getfocus
//* Auteur         : F. Pinon
//* Date            : 14/08/2009 09:46:49
//* Libell$$HEX10$$e900200020002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires   : 
//*
//* Arguments      : 
//*
//* Retourne      : long   
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date        Modification
//* #..   ...   ../../....   
//* #1   FPI    14/08/2009      [DCMP090310] Am$$HEX1$$e900$$ENDHEX$$lioration
//*-----------------------------------------------------------------

If this.RowCount() > 0 And cb_maj.Enabled = TRUE Then
   // on r$$HEX1$$e900$$ENDHEX$$active le btn ctl et d$$HEX1$$e900$$ENDHEX$$sactive cb_maj
   cb_maj.Enabled = False
   cb_controler.Enabled = TRUE
End if

end event

event retrievestart;Int iIdTt 

iIdTt= dw_Fourn.GetItemNumber ( 1, "ID_TT")
Choose Case iIdTt
	Case K_TYPTRT_LST_CMDE_O2M,K_TYPTRT_LST_CMDE_CDS, K_TYPTRT_LST_CMDE_CFM, K_TYPTRT_LST_CMDE_AUC, K_TYPTRT_LST_SIN_REG, K_TYPTRT_LST_RM,K_TYPTRT_LST_REG,K_TYPTRT_LST_CMDE
		Return 2
End Choose

Return 0
end event

type hpb_trt from hprogressbar within w_sp_trt_autre_fichier
integer x = 1088
integer y = 1396
integer width = 2482
integer height = 64
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 1
end type

type st_1 from statictext within w_sp_trt_autre_fichier
boolean visible = false
integer x = 1737
integer y = 764
integer width = 891
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "S$$HEX1$$e900$$ENDHEX$$lectionner un traitement..."
boolean focusrectangle = false
end type

type st_avertissement_monnaie from u_st_avertissement_monnaie within w_sp_trt_autre_fichier
integer x = 1289
integer y = 28
integer width = 1522
integer height = 136
boolean bringtotop = true
long backcolor = 67108864
string text = "Si des montants se trouvent dans le fichier texte $$HEX2$$e0002000$$ENDHEX$$int$$HEX1$$e900$$ENDHEX$$grer, ces derniers doivent $$HEX1$$ea00$$ENDHEX$$tre exprim$$HEX1$$e900$$ENDHEX$$s en Euros."
alignment alignment = center!
end type

event constructor;//*-----------------------------------------------------------------
//*
//* Objet			: u_st_avertissement_monnaie
//* Evenement 		: constructor
//* Auteur			: 
//* Date				: 27/02/2008 14:43:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: (OVERRIDE)
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

this.text += " " +stGlb.sMonnaieLitteralDesire + "s"
end event

type lb_filelist from listbox within w_sp_trt_autre_fichier
boolean visible = false
integer x = 393
integer y = 1512
integer width = 311
integer height = 212
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_result from commandbutton within w_sp_trt_autre_fichier
integer x = 105
integer y = 920
integer width = 869
integer height = 156
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Sauvegarder les r$$HEX1$$e900$$ENDHEX$$sultats"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Fonction      : clicked  (PRIVATE)
//* Auteur        : JFF
//* Date          : 28/01/2013
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le des donn$$HEX1$$e900$$ENDHEX$$es
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     	Modification
//			JFF		27/01/2014	[VDOC12917]
//*-----------------------------------------------------------------

String sNomComplet, sNomFic
Long lRet
		
GetFileSaveName( "Sauvegarde du r$$HEX1$$e900$$ENDHEX$$sultat de traitement en fichier Excel", sNomComplet, sNomFic, "", "Fichiers Excel (*.XLS),*.XLS, Tous Fichiers (*.*),*.*")

lRet = dw_Charger.SaveAs ( sNomComplet, Excel!, True )

Choose Case lRet 
	Case -1 
		
		stMessage.sTitre		= "Ecriture fichier"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "GENE170"
		stMessage.sVar[1] 	= sNomComplet
		F_Message ( stMessage )
		
	Case 1
		
		stMessage.sTitre		= "Ecriture fichier"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "GENE169"
		stMessage.sVar[1] 	= sNomComplet		
		F_Message ( stMessage )
		
End Choose		
		
end event

type cb_taillefen from commandbutton within w_sp_trt_autre_fichier
integer x = 2866
integer y = 28
integer width = 709
integer height = 128
integer taborder = 160
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "J~'agrandis la fen$$HEX1$$ea00$$ENDHEX$$tre"
end type

event clicked;
If isCasTailleFen = "REDUIRE" Then 
	isCasTailleFen = "AGRANDIR"
	Wf_PositionnerObjets ( )
	cb_taillefen.Text = "Je r$$HEX1$$e900$$ENDHEX$$duis la fen$$HEX1$$ea00$$ENDHEX$$tre"
Else 
	isCasTailleFen = "REDUIRE"
	Wf_PositionnerObjets ( )
	cb_taillefen.Text = "J'agrandis la fen$$HEX1$$ea00$$ENDHEX$$tre"	
End If 
end event

type st_pct from statictext within w_sp_trt_autre_fichier
integer x = 2235
integer y = 1396
integer width = 183
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 553648127
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

