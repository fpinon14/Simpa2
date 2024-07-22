HA$PBExportHeader$w_sp_trt_saisie_manuelle_suivi.srw
$PBExportComments$Saisie manuelle du suivi des commandes
forward
global type w_sp_trt_saisie_manuelle_suivi from w_8_accueil
end type
type st_2 from statictext within w_sp_trt_saisie_manuelle_suivi
end type
type em_refsin from editmask within w_sp_trt_saisie_manuelle_suivi
end type
type em_seq from editmask within w_sp_trt_saisie_manuelle_suivi
end type
type cb_interro from commandbutton within w_sp_trt_saisie_manuelle_suivi
end type
type gb_1 from groupbox within w_sp_trt_saisie_manuelle_suivi
end type
type dw_saisi from datawindow within w_sp_trt_saisie_manuelle_suivi
end type
type cb_maj from commandbutton within w_sp_trt_saisie_manuelle_suivi
end type
type cb_effacer from commandbutton within w_sp_trt_saisie_manuelle_suivi
end type
type st_resmaj from statictext within w_sp_trt_saisie_manuelle_suivi
end type
type st_1 from statictext within w_sp_trt_saisie_manuelle_suivi
end type
type dw_pm95 from datawindow within w_sp_trt_saisie_manuelle_suivi
end type
type cb_status_gc from commandbutton within w_sp_trt_saisie_manuelle_suivi
end type
type gb_2 from groupbox within w_sp_trt_saisie_manuelle_suivi
end type
end forward

global type w_sp_trt_saisie_manuelle_suivi from w_8_accueil
integer width = 3465
integer height = 1884
st_2 st_2
em_refsin em_refsin
em_seq em_seq
cb_interro cb_interro
gb_1 gb_1
dw_saisi dw_saisi
cb_maj cb_maj
cb_effacer cb_effacer
st_resmaj st_resmaj
st_1 st_1
dw_pm95 dw_pm95
cb_status_gc cb_status_gc
gb_2 gb_2
end type
global w_sp_trt_saisie_manuelle_suivi w_sp_trt_saisie_manuelle_suivi

forward prototypes
public subroutine wf_init ()
public subroutine wf_interro ()
public subroutine wf_maj ()
public function integer wf_gestion_mds (long row, dwobject dwo, string data)
public function boolean wf_controler (ref string ascolumn, ref string aserrmess)
public function integer wf_gestion_scf (long row, dwobject dwo, string data)
public function integer wf_gestion_axa (long row, dwobject dwo, string data)
public function integer wf_gestion_mbs (long row, dwobject dwo, string data)
public function integer wf_gestion_omt (long row, dwobject dwo, string data)
public subroutine wf_enableswap (boolean abenable)
public function integer wf_gestion_aas (long row, dwobject dwo, string data)
public subroutine wf_setheight (boolean bagrandir, string asfournisseur)
public subroutine wf_epure_zone ()
public subroutine wf_empty_swap ()
end prototypes

public subroutine wf_init ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_saisie_manuelle_suivi::wf_Init
//* Auteur        : Fabry JF
//* Date          : 27/01/2005 11:17:45
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
//*			FPI	22/11/2011	[PM95]
//				FPI	20/10/2016	[PC151259]
//	FPI	09/10/2017	[PC171918].1
//*-----------------------------------------------------------------
Long lTotLigne

If dw_Saisi.RowCount () > 0 Then 
	dw_Saisi.RowsDiscard ( 1, dw_Saisi.RowCount (), PRIMARY! )
End If

DataWindowChild dwChild

dw_Saisi.GetChild ( "STATUS_GC", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-GC" )
dwChild.SetFilter ( "ID_CODE = 0" )
dwChild.Filter ()

dw_Saisi.GetChild ( "COD_ETAT", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-EC" )
dwChild.SetFilter ( "ID_CODE = 'ECT'" )
dwChild.Filter ()

dw_Saisi.InsertRow ( 0 )

dw_Saisi.Modify ( "t_num_interv_frn.text = 'N$$HEX2$$b0002000$$ENDHEX$$Intervention Fournisseur' t_num_interv_frn.visible = 1 id_cmd_frn.visible = 1")
dw_Saisi.Modify ( "t_num_bon_trp.text = 'N$$HEX2$$b0002000$$ENDHEX$$Bon transporteur'  t_num_bon_trp.visible = 1 id_bon_trans.visible = 1")
dw_Saisi.Modify ( "t_dte_env_cli.text = 'Date d~~'envoi au client'  t_dte_env_cli.visible = 1  dte_env_cli.visible = 1")
dw_Saisi.Modify ( "t_statut_gc.text = 'Statut de la commande'  t_statut_gc.visible = 1 status_gc.visible = 1" )
dw_Saisi.Modify ( "t_etat.text = 'Code $$HEX1$$e900$$ENDHEX$$tat de la commande'  t_etat.visible = 1  cod_etat.visible = 1")

dw_Saisi.Modify("info_frn_spb_cplt.visible=0") // [DT176]
dw_Saisi.Modify("comment_frn.visible=0") // [PC151259]

em_RefSin.Text = ""
em_Seq.Text = ""

em_refSin.SetFocus ()

cb_Maj.Enabled = FALSE
em_RefSin.Enabled = TRUE
em_Seq.Enabled = TRUE

cb_interro.Enabled = True

st_ResMaj.Hide ()

// [PM95]
SELECT count(*) INTO :lTotLigne
  FROM sysadm.autorisation
 WHERE id_nat_oper in (208,213)		AND
		 id_oper     = :stGlb.sCodOper
 USING SQLCA;


If lTotLigne > 0 Then
   dw_pm95.Visible = True
	dw_pm95.Reset()
	dw_pm95.InsertRow(0)
	dw_pm95.Object.b_enregistrer.Enabled=FALSE
Else
   dw_pm95.Visible = False
End if

// [ITSM_Status_GC_0] 
SELECT count(*) INTO :lTotLigne
  FROM sysadm.autorisation
 WHERE id_nat_oper in (225)		AND
		 id_oper     = :stGlb.sCodOper
 USING SQLCA;
 
 If lTotLigne > 0 Then
	cb_status_gc.Visible = True
	cb_status_gc.Enabled = False
	gb_2.Visible = True
	gb_2.bringtotop =FALSE
Else
	cb_status_gc.Visible = FALSE
	gb_2.Visible = FALSE
End if

// [PC171918].1
wf_setHeight(false,"")

// [DT339]
dw_Saisi.Modify ( "t_accord_indemn_pecu.visible=0 accord_indemn_pecu.visible=0")
dw_Saisi.Modify ( "t_comment_frn_1.visible=0 comment_frn_1.visible=0 ")
dw_Saisi.Modify ( "l_3.visible=1 cod_etat.protect='0' t_id_serie_nouv.text=~"Num$$HEX1$$e900$$ENDHEX$$ro s$$HEX1$$e900$$ENDHEX$$rie de l'appareil~"")
dw_saisi.Modify( "marque_swap.visible=1 marque_swap_1.visible=0")
dw_saisi.Modify( "modele_swap.visible=1 modele_swap_1.visible=0")
			

end subroutine

public subroutine wf_interro ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_saisie_manuelle_suivi::wf_Interro
//* Date          : 27/01/2005 11:17:45
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     	Modification
//* #1	PHG	21/03/2007		Optimisation pour Media Saturn
//* #2   JFF   23/06/2008  	[DCMP080287].FAX_MAIL
// 		JFF	20/01/2011  	[GROSBILL].[PC398-403-479]
//*      JFF   01/09/2011  [PC10][DIAG_NOMADE]
//*      FPI   22/11/2011  [PM95]
//*	 FPI	09/10/2012	[ITSM131637] on sort MBS et MDS du case par produit
//		FPI	21/11/2012	[ITSM_Status_GC_0] 
//		FPI	23/11/2012	[PC874]
//		FPI	18/12/2012	[PC10-2] ajout de CVC
//		FPI	26/03/2014	[PC925]
//		FPI	03/11/2014	[ITSM247199]
//		FPI	26/05/2015	[PC786-2]
//		FPI	08/09/2015  [PC13442-2] Ajout ATECH
//		FPI	08/04/2016	[DT176]
//		FPI	20/10/2016	[PC151259]
//    JFF   29/05/2017  [PC151259-2]
//    JFF   05/10/2017  [PC171918]
//	FPI	09/10/2017	[PC171918].1
//		FPI	06/08/2018	[DT363]
//    JFF   21/11/2018 [VDOC27123]
//		FPI	06/03/2019	[DT401]
//*-----------------------------------------------------------------

Long lIdSin, lIdSeq, lTot, lIdGti
DataWindowChild dwC_StatusGc, dwC_CodeEtat
string sCodeEtat // #1 PHG [DCMP070191]
n_cst_string nvString
string sVal
string sIdFour // [DT401]

// [PC171918].1
wf_setHeight(false,"")
wf_enableswap( false)
dw_saisi.Modify("app_swap.protect='1'")

dw_Saisi.GetChild ( "STATUS_GC", dwC_StatusGc )
dw_Saisi.GetChild ( "COD_ETAT", dwC_CodeEtat )

dw_Saisi.SetTransObject ( SQLCA )

lIdSin = Long ( em_RefSin.Text ) 
lIdSeq = Long ( em_Seq.Text ) 

If IsNull ( lIdSin ) Or IsNull ( lIdSeq ) Or lIdSin = 0 Or lIdSeq = 0 Then 
	wf_Init ()
	Return
End If

lTot = dw_Saisi.Retrieve ( lIdSin, lIdSeq )

cb_status_gc.Enabled=(lTot > 0) // [ITSM_Status_GC_0] 

If lTot < 1 Then
	wf_Init ()
	Return
End If

// [DT401]
if dw_saisi.GetItemString(1,"EST_IFR")="O" Then
	dw_saisi.Modify( "marque_swap.visible=0 marque_swap_1.visible=1")
	dw_saisi.Modify( "modele_swap.visible=0 modele_swap_1.visible=1")
	dw_saisi.Modify( "t_marque_swap.text='Marque swap (IFR)'")
	dw_saisi.Modify( "t_modele_swap.text='Mod$$HEX1$$e800$$ENDHEX$$le swap (IFR)'")
Else
	dw_saisi.Modify( "marque_swap.visible=1 marque_swap_1.visible=0")
	dw_saisi.Modify( "modele_swap.visible=1 modele_swap_1.visible=0")
	dw_saisi.Modify( "t_marque_swap.text='Marque swap'")
	dw_saisi.Modify( "t_modele_swap.text='Mod$$HEX1$$e800$$ENDHEX$$le swap'")
End if

if dw_saisi.getItemString(1,"ID_TYP_ART")="PRS" Then
	dw_saisi.Modify( "t_dte_rcp_frn.visible=1 dte_rcp_frn.visible=1")
Else
	dw_saisi.Modify( "t_dte_rcp_frn.visible=0 dte_rcp_frn.visible=0")
End if
// :[DT401]

// [PM95]
lTot=dw_pm95.Retrieve( dec(lIdSin), lIdSeq )
if lTot > 0 Then
	If dw_pm95.GetItemNumber(1,"nb_param_alerte") > 0 Then 
		dw_pm95.Object.b_enregistrer.Enabled=TRUE
	Else 
		dw_pm95.Object.b_enregistrer.Enabled=FALSE
	End if
	
	If dw_pm95.GetItemString(1,"valeur") ="" Then dw_pm95.SetItem(1,"VALEUR","NON")
End if
// :[PM95]

cb_interro.Enabled = False

dwC_StatusGc.SetFilter ( "ID_CODE = -1" )
dwC_StatusGc.Filter ()

dwC_CodeEtat.SetFilter ( "ID_CODE = '-1'" )
dwC_CodeEtat.Filter ()

lIdGti = dw_Saisi.GetItemNumber ( 1, "ID_GTI" )

dw_Saisi.Modify("info_frn_spb_cplt.visible=0")
dw_Saisi.Modify ( "cod_etat.visible=1");
dw_Saisi.Modify ( "comment_frn.visible=0")

/*------------------------------------------------------------------*/
/* Formatage de la grille en fonction des produits et fournisseurs. */
/*------------------------------------------------------------------*/
Choose Case dw_Saisi.GetItemNumber ( 1, "ID_PROD" )

	/*------------------------------------------------------------------*/
	/* Darty Nomade                                                     */
	/*------------------------------------------------------------------*/
	// [ITSM247199] ajout de produits
	Case 8691, 8692, 8693, 8694, 8695, &
		5706, 5760,  8696, 8697, 47500, 30800 To 30803

		Choose Case dw_Saisi.GetItemString ( 1, "ID_FOUR" )

			Case "DTY"
				dwC_StatusGc.SetFilter ( "ID_CODE IN ( 0, 32, 33, 34)" )
				dwC_StatusGc.Filter ()

				dwC_CodeEtat.SetFilter ( "ID_CODE IN ( 'RPC' )" )
				dwC_CodeEtat.Filter ()

				cb_Maj.Enabled = TRUE
				em_RefSin.Enabled = False
				em_Seq.Enabled = False

				

			Case "DST"
				dwC_StatusGc.SetFilter ( "ID_CODE IN ( 0, 30, 31)" )
				dwC_StatusGc.Filter ()

				dwC_CodeEtat.SetFilter ( "ID_CODE IN ( 'ECT', 'RPC', 'ANN')" )
				dwC_CodeEtat.Filter ()

				cb_Maj.Enabled = TRUE
				em_RefSin.Enabled = False
				em_Seq.Enabled = False


		End Choose 

	/*------------------------------------------------------------------*/
	/* MEDIA SATURN																	  */
	/*------------------------------------------------------------------*/
	// [PC10][DIAG_NOMADE] (237xx)
	/*Case 25300 TO 25315, 23703, 23705, 23706
		Choose Case dw_Saisi.GetItemString ( 1, "ID_FOUR" )

			// [PC10][DIAG_NOMADE] (MBS) // [PC10-2] ajout de CVC // [PC13442-2] Ajout ATECH
			Case "MDS", "MBS","CVC","ATC"
				If lIdGti = 11 Then

					dw_Saisi.Modify ( "t_num_interv_frn.text = 'N$$HEX2$$b0002000$$ENDHEX$$Intervention Fournisseur' t_num_interv_frn.visible = 0 id_cmd_frn.visible = 0")
					dw_Saisi.Modify ( "t_num_bon_trp.text = 'N$$HEX2$$b0002000$$ENDHEX$$Bon transporteur'  t_num_bon_trp.visible = 0 id_bon_trans.visible = 0")
					dw_Saisi.Modify ( "t_dte_env_cli.text = 'Date d~~'expertise'  t_dte_env_cli.visible = 1  dte_env_cli.visible = 1")
					dw_Saisi.Modify ( "t_statut_gc.text = 'Statut de la commande'  t_statut_gc.visible = 1 status_gc.visible = 1" )
					// #1 PHG [DCMP070191] Le Code Etat n'est plus visible.
					//dw_Saisi.Modify ( "t_etat.text = 'Code $$HEX1$$e900$$ENDHEX$$tat de la commande'  t_etat.visible = 1  cod_etat.visible = 1")
					// remplac$$HEX2$$e9002000$$ENDHEX$$par 
					dw_Saisi.Modify ( "t_etat.text = 'Code $$HEX1$$e900$$ENDHEX$$tat de la commande'  t_etat.visible = 0  cod_etat.visible = 0")
				
					dwC_StatusGc.SetFilter ( "ID_CODE IN ( 71, 72)" )
					dwC_StatusGc.Filter ()
	
					dwC_CodeEtat.SetFilter ( "ID_CODE IN ( 'ECT', 'ANN', 'RPC' )" )
					dwC_CodeEtat.Filter ()
					// #1 PHG [DCMP070191] On n'autorise le bouton de MAJ que si Cod_etat
					// = 'ECT' "en cours de traitement"
					sCodeEtat = dw_Saisi.object.cod_etat[1]
					cb_Maj.Enabled = (upper(sCodeEtat) = 'ECT')
					//
					em_RefSin.Enabled = False
					em_Seq.Enabled = False
				Else
					cb_Maj.Enabled = FALSE
				End If

		End Choose
	*/
	/*------------------------------------------------------------------*/
	/* SurCouf     																	  */
	/*------------------------------------------------------------------*/
	Case 28601 TO 28606
		Choose Case dw_Saisi.GetItemString ( 1, "ID_FOUR" )

			Case "SCF"
				If lIdGti = 18 Then

					dw_Saisi.Modify ( "t_num_interv_frn.text = 'N$$HEX2$$b0002000$$ENDHEX$$Intervention Fournisseur' t_num_interv_frn.visible = 0 id_cmd_frn.visible = 0")
					dw_Saisi.Modify ( "t_num_bon_trp.text = 'N$$HEX2$$b0002000$$ENDHEX$$Bon transporteur'  t_num_bon_trp.visible = 0 id_bon_trans.visible = 0")
					dw_Saisi.Modify ( "t_dte_env_cli.text = 'Date d~~'expertise'  t_dte_env_cli.visible = 1  dte_env_cli.visible = 1")
					dw_Saisi.Modify ( "t_statut_gc.text = 'Statut de la commande'  t_statut_gc.visible = 1 status_gc.visible = 1" )
					// #1 PHG [DCMP070191] Le Code Etat n'est plus visible.
					//dw_Saisi.Modify ( "t_etat.text = 'Code $$HEX1$$e900$$ENDHEX$$tat de la commande'  t_etat.visible = 1  cod_etat.visible = 1")
					// remplac$$HEX2$$e9002000$$ENDHEX$$par 
					dw_Saisi.Modify ( "t_etat.text = 'Code $$HEX1$$e900$$ENDHEX$$tat de la commande'  t_etat.visible = 0  cod_etat.visible = 0")
				
					dwC_StatusGc.SetFilter ( "ID_CODE IN ( 221, 222)" )
					dwC_StatusGc.Filter ()
	
					dwC_CodeEtat.SetFilter ( "ID_CODE IN ( 'ECT', 'ANN', 'RPC' )" )
					dwC_CodeEtat.Filter ()
					// #1 PHG [DCMP070191] On n'autorise le bouton de MAJ que si Cod_etat
					// = 'ECT' "en cours de traitement"
					sCodeEtat = dw_Saisi.object.cod_etat[1]
					cb_Maj.Enabled = (upper(sCodeEtat) = 'ECT')
					//
					em_RefSin.Enabled = False
					em_Seq.Enabled = False
				Else
					cb_Maj.Enabled = FALSE
				End If

		End Choose

	/*------------------------------------------------------------------*/
	/* // [GROSBILL].[PC398-403-479] 											  */
	/*------------------------------------------------------------------*/
	Case 38900 TO 38901, 42100, 43100
		Choose Case dw_Saisi.GetItemString ( 1, "ID_FOUR" )

			Case "AXA"
				dwC_StatusGc.SetFilter ( "ID_CODE IN ( 0, 2, 21)" )
				dwC_StatusGc.Filter ()

				dwC_CodeEtat.SetFilter ( "ID_CODE IN ( 'ECT', 'RPC', 'ANN')" )
				dwC_CodeEtat.Filter ()

				cb_Maj.Enabled = TRUE
				em_RefSin.Enabled = False
				em_Seq.Enabled = False

				sCodeEtat = dw_Saisi.object.cod_etat[1]
				cb_Maj.Enabled = (upper(sCodeEtat) = 'ECT')

		End Choose
	
	 Case Else
		cb_Maj.Enabled = FALSE

End CHoose

// [DT401]
sIdFour=dw_Saisi.GetItemString ( 1, "ID_FOUR" )
if sIdFour="AAS" Then
	if dw_Saisi.GetItemString ( 1, "ID_TYP_ART" )="PRS" Then sIdFour="AAS_PRS"
	if dw_Saisi.GetItemString ( 1, "ID_TYP_ART" )="CAF" Then sIdFour="AAS_CAF"
End if

// [ITSM131637]
Choose Case sIdFour 
	Case "MDS", "MBS", "CVC","ATC" // [PC10-2] ajout de CVC // [PC13442-2] Ajout ATECH
		If lIdGti = 11 Then

			dw_Saisi.Modify ( "t_num_interv_frn.text = 'N$$HEX2$$b0002000$$ENDHEX$$Intervention Fournisseur' t_num_interv_frn.visible = 0 id_cmd_frn.visible = 0")
			dw_Saisi.Modify ( "t_num_bon_trp.text = 'N$$HEX2$$b0002000$$ENDHEX$$Bon transporteur'  t_num_bon_trp.visible = 0 id_bon_trans.visible = 0")
			dw_Saisi.Modify ( "t_dte_env_cli.text = 'Date d~~'expertise'  t_dte_env_cli.visible = 1  dte_env_cli.visible = 1")
			dw_Saisi.Modify ( "t_statut_gc.text = 'Statut de la commande'  t_statut_gc.visible = 1 status_gc.visible = 1" )
			dw_Saisi.Modify ( "t_etat.text = 'Code $$HEX1$$e900$$ENDHEX$$tat de la commande'  t_etat.visible = 0  cod_etat.visible = 0")
		
			dwC_StatusGc.SetFilter ( "ID_CODE IN ( 71, 72)" )
			dwC_StatusGc.Filter ()

			dwC_CodeEtat.SetFilter ( "ID_CODE IN ( 'ECT', 'ANN', 'RPC' )" )
			dwC_CodeEtat.Filter ()
			sCodeEtat = dw_Saisi.object.cod_etat[1]
			cb_Maj.Enabled = (upper(sCodeEtat) = 'ECT')
			em_RefSin.Enabled = False
			em_Seq.Enabled = False
		Else
			cb_Maj.Enabled = FALSE
		End If
		
	Case "OMT" // [PC874]
			dw_Saisi.Modify ( "t_num_bon_trp.text = 'N$$HEX2$$b0002000$$ENDHEX$$Bon transporteur'  t_num_bon_trp.visible = 0 id_bon_trans.visible = 0")
			dw_Saisi.Modify ( "t_dte_env_cli.text = 'Date d~~'expertise'  t_dte_env_cli.visible = 1  dte_env_cli.visible = 1")
			
			dwC_StatusGc.SetFilter ( "ID_CODE IN ( 2,251,252 )" )
			dwC_StatusGc.Filter ()

			dwC_CodeEtat.SetFilter ( "ID_CODE IN ( 'ECT', 'ANN', 'RFO' )" )
			dwC_CodeEtat.Filter ()
			
			cb_Maj.Enabled = TRUE
		
		Case "SRR" // [PC925]
			dw_Saisi.Modify ( "t_num_bon_trp.text = 'N$$HEX2$$b0002000$$ENDHEX$$Bon transporteur'  t_num_bon_trp.visible = 0 id_bon_trans.visible = 0")
			dw_Saisi.Modify ( "t_dte_env_cli.visible = 1  dte_env_cli.visible = 1")
			
			dwC_StatusGc.SetFilter ( "ID_CODE IN ( 2,21, 152, 153, 154 )" )
			dwC_StatusGc.Filter ()

			dwC_CodeEtat.SetFilter ( "ID_CODE IN ( 'ECT', 'ANN', 'RFO' )" )
			dwC_CodeEtat.Filter ()
			
			cb_Maj.Enabled = TRUE

		Case "SOG" // [PC786-2]
			dw_Saisi.Modify ( "t_num_bon_trp.text = 'N$$HEX2$$b0002000$$ENDHEX$$Bon transporteur'  t_num_bon_trp.visible = 0 id_bon_trans.visible = 0")
			dw_Saisi.Modify ( "t_num_interv_frn.visible = 0 id_cmd_frn.visible = 0")
			
			dwC_StatusGc.SetFilter ( "ID_CODE IN (2,21,501 )" )
			dwC_StatusGc.Filter ()

			dwC_CodeEtat.SetFilter ( "ID_CODE IN ( 'ECT', 'ANN', 'RPC' )" )
			dwC_CodeEtat.Filter ()
			
			cb_Maj.Enabled = TRUE
			
		Case "CMA" // [DT176]
			dw_Saisi.Modify ( "status_gc.visible=0 info_frn_spb_cplt.visible=1")
			dw_Saisi.Modify ( "t_num_bon_trp.text = 'N$$HEX2$$b0002000$$ENDHEX$$de recommand$$HEX2$$e9002000$$ENDHEX$$AR' t_num_interv_frn.text='N$$HEX2$$b0002000$$ENDHEX$$de lot' t_statut_gc.text='N$$HEX2$$b0002000$$ENDHEX$$du/des bon(s) d~~'achat''")
			
			dwC_CodeEtat.SetFilter ( "ID_CODE IN ( 'ANN', 'RPC','ECT' )" )
			dwC_CodeEtat.Filter ()
			
			cb_status_gc.Enabled=false
			
			sVal=nvString.of_getkeyvalue(dw_Saisi.GetItemString(1,"info_spb_frn_cplt" ),"GESTION_ENVOI_BA",";")
			cb_Maj.Enabled =  (sVal = "SPB")
		
			if cb_maj.Enabled Then
				sVal=dw_Saisi.GetItemString(1,"info_frn_spb_cplt" )
				sVal=Mid(sVal,7)
			
				dw_Saisi.SetItem(1,"info_frn_spb_cplt" ,sVal)
			End if
			
		// [PC151259] // [PC151259-2] // [PC171918]
		Case "EKO","DGC","NET", "SMT", "RAV", "RTP", "SFG" ,"AAS_PRS"
			dw_Saisi.Modify ( "cod_etat.visible=0");
			dw_Saisi.Modify ( "comment_frn.visible=1")
			
			dwC_StatusGc.SetFilter ( "ID_CODE IN ( 0, 2, 21)" )
			dwC_StatusGc.Filter ()

			dwC_CodeEtat.SetFilter ( "ID_CODE = 'RPC" )
			dwC_CodeEtat.Filter ()
			
			dw_Saisi.SetItem(1,"COD_ETAT","RPC")
			
			cb_Maj.Enabled = TRUE
		
			sVal=dw_Saisi.GetItemString(1,"COMMENT_FRN")

			// [VDOC27123]BVID/BVIP/BVITm
			If pos(sVal,"[BVIE]") > 0 Then 
				dw_Saisi.SetItem(1,"COMMENT_FRN","[BVIE]")
			Elseif pos(sVal,"[BVID]") > 0 Then 
				dw_Saisi.SetItem(1,"COMMENT_FRN","[BVID]")
			Elseif pos(sVal,"[BVIP]") > 0 Then 
				dw_Saisi.SetItem(1,"COMMENT_FRN","[BVIP]")
			Elseif pos(sVal,"[BVIT]") > 0 Then 
				dw_Saisi.SetItem(1,"COMMENT_FRN","[BVIT]")
			Elseif pos(sVal,"[BNV]") > 0 Then 
				dw_Saisi.SetItem(1,"COMMENT_FRN","[BNV]")
			Else 
				dw_Saisi.SetItem(1,"COMMENT_FRN","")
			End if
			
			// [PC171918].1
			If Not isNull(dw_Saisi.getItemString(1,"VARIANTE")) Then
				if dw_Saisi.getItemString(1,"VARIANTE")="ADVISE_6" Then wf_setHeight(true,dw_Saisi.GetItemString ( 1, "ID_FOUR" ))
				
				if dw_Saisi.getItemString(1,"COMMENT_FRN") ="[BVIE]" Then
					dw_saisi.Modify("app_swap.protect='0'")
					if dw_Saisi.getItemString(1,"APP_SWAP") ="OUI" Then wf_enableswap( true)
				End if
				
			End if

			if sIdFour="AAS_PRS" Then // [DT401]
				dw_Saisi.Modify ( "accord_indemn_pecu.visible=1 t_accord_indemn_pecu.visible=1")
				wf_setHeight(true,"AAS")
				if dw_Saisi.getItemNumber(1,"status_gc") <> 21 Then 
					dw_saisi.Modify("accord_indemn_pecu.protect='1'")	
				End if
			End if
			
			if dw_saisi.GetItemString(1,"type_app")="TEL" Then
				dw_saisi.Modify("t_id_serie_nouv.text=~"Num$$HEX1$$e900$$ENDHEX$$ro IMEI de l'appareil~"")
			End if
			
		// [DT363]
		Case "AAS", "AAS_CAF"
			dw_Saisi.Modify ( "t_app_swap.visible=0 app_swap.visible=0 accord_indemn_pecu.visible=1 t_accord_indemn_pecu.visible=1")
			dw_Saisi.Modify ( "t_comment_frn_1.visible=1 comment_frn_1.visible=1 l_3.visible=0")
			
			dwC_StatusGc.SetFilter ( "ID_CODE IN (176,178 )" )
			dwC_StatusGc.Filter ()
			
			dwC_CodeEtat.SetFilter ( "ID_CODE IN ( 'ANN', 'RPC' )" )
			dwC_CodeEtat.Filter ()
			
			dw_Saisi.SetItem(1,"cod_etat" ,"RPC")
			dw_Saisi.Modify ( "cod_etat.protect='1'")
			
			if dw_saisi.GetItemString(1,"EST_IFR") = "O" Then
				dw_Saisi.Modify ( "t_marque_swap.text = 'Marque Rempl. (IFR)' t_modele_swap.text='Mod$$HEX1$$e800$$ENDHEX$$le Rempl. (IFR)''")
			else
				dw_Saisi.Modify ( "t_marque_swap.text = 'Marque Remplacement' t_modele_swap.text='Mod$$HEX1$$e800$$ENDHEX$$le Remplacement''")
			End if
		
			if dw_Saisi.getItemNumber(1,"status_gc")=178 Then 
				wf_setHeight(true,"AAS")
				dw_saisi.Modify("accord_indemn_pecu.protect='1'")	
				wf_enableswap( true)
			else
				wf_setHeight(false,"AAS")
			End if

			if dw_saisi.GetItemString(1,"type_app")="TEL" Then
				dw_saisi.Modify("t_id_serie_nouv.text=~"Num$$HEX1$$e900$$ENDHEX$$ro IMEI de l'appareil~"")
			End if
			
			cb_Maj.Enabled = TRUE
End Choose

end subroutine

public subroutine wf_maj ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_saisie_manuelle_suivi::wf_Maj
//* Date          : 27/01/2005 11:17:45
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	PHG	21/03/2007 [DCMP070191] Optimisation Gestion MEdia SAturne
//* #2   JFF   09/09/2008 [MICROMANIA]
//* #3	JFF	20/10/2008 [FNAC_PROD_ECH_TECH]
//*      JFF   01/09/2011  [PC10][DIAG_NOMADE]
//		FPI	18/12/2012	[PC10-2] Ajout de CVC
//		FPI	08/09/2015	[PC13442-2] Ajout ATECH
//		FPI 	08/04/2016	[DT176]
//		FPI	07/07/2016	[CORR_MAJ_MANU_CMD] ajout du recalcul de l'$$HEX1$$e900$$ENDHEX$$tat vu assur$$HEX1$$e900$$ENDHEX$$
//		FPI	14/10/2016	[PC151255] m$$HEX1$$e000$$ENDHEX$$j commande SCR depuis commande CMA
//		FPI	20/10/2016	[PC151259]
//		FPI	10/10/2017	[PC171918].1
//		FPI	06/08/2018	[DT339]
//		FPI	21/03/2019	[DT401] ajout dte_rcp_frn
//       JFF   22/11/2023 [RS6173_FERM_PRS_CMA]
//*-----------------------------------------------------------------

String sSql, sVal, sOldVal, sOldVal2
String sColumn, sErrMess
Boolean bRet 
n_cst_string nvString 
string sNull
string sCasRetour
Long lRet

bRet=True // [DT339]
wf_epure_zone()

SetNull(sNull)

dw_Saisi.AcceptText ()

// #1 PHG [DCMP070191]
// Controle avant Mise a jour
if Not wf_Controler(sColumn, sErrMess) then

	stMessage.sTitre		= "Mise $$HEX2$$e0002000$$ENDHEX$$jour des commandes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= sErrMess 

	if sColumn <> "APP_SWAP" Then // [PC171918].1
		F_Message ( stMessage )
	End if
	
	dw_saisi.setColumn(sColumn)
	dw_saisi.SetFocus()
	return 
End If

// [DT176]
if dw_saisi.getItemString(1,"ID_FOUR") = "CMA" Then
	sOldVal= dw_saisi.getItemString ( 1, "INFO_FRN_SPB_CPLT")
	sVal="NO_BA=" + sOldVal
	dw_saisi.SetItem(1,"INFO_FRN_SPB_CPLT",sVal)
	
	// [RS6173_FERM_PRS_CMA]
	If F_CLE_A_TRUE ( "RS6173_FERM_PRS_CMA" ) Then
		If dw_saisi.getItemString(1,"COD_ETAT")="ANN" Then 
			dw_Saisi.SetItem ( 1, "STATUS_GC", 176 )
		End If 
		
		If dw_saisi.getItemString(1,"COD_ETAT")="ECT" Then 
			dw_saisi.SetItem ( 1, "COD_ETAT", "RPC" )
			dw_Saisi.SetItem ( 1, "STATUS_GC", 178 )
		End If 
	End If
End if
// :[DT176]

// [PC171918].1
if dw_saisi.getItemString(1,"APP_SWAP") = "OUI" Then
	sVal= dw_saisi.getItemString(1,"INFO_FRN_SPB_CPLT")

	If IsNull ( sVal ) Then sVal = ""

	nvString.of_setkeyvalue(sVal,"APP_SWAP", "OUI", ";")
	nvString.of_setkeyvalue( sVal,"TGR_APPSW", "OUI", ";")
	nvString.of_setkeyvalue( sVal,"MARQSW",  dw_saisi.getItemString(1,"MARQUE_SWAP"), ";")
	nvString.of_setkeyvalue( sVal,"MODLSW",  dw_saisi.getItemString(1,"MODELE_SWAP"), ";")
	nvString.of_setkeyvalue( sVal,"MTTTCSW",   String(dw_saisi.getItemDecimal(1,"PRIX_SWAP")), ";")
	nvString.of_setkeyvalue( sVal,"NEUF_REC",  dw_saisi.getItemString(1,"ETAT_SWAP"), ";")
	
	dw_saisi.SetItem(1,"INFO_FRN_SPB_CPLT",sVal)
Else
	dw_saisi.SetItem(1,"ID_SERIE_NOUV",sNull) // [DT401]
End if
// :[PC171918].1

// [DT339]
if dw_saisi.getItemString(1,"ID_FOUR") = "AAS" Then
	nvString.of_setkeyvalue( sVal,"ACCORD_INDEM_PECU",  dw_saisi.getItemString(1,"ACCORD_INDEMN_PECU"), ";")
		
	if dw_saisi.getItemNumber(1,"STATUS_GC") = 178 Then
		nvString.of_setkeyvalue( sVal,"NEUF_REC",  dw_saisi.getItemString(1,"ETAT_SWAP"), ";")
	
		// Maj
		SQLCA.PS_U_COMMANDE_AAS(  Dec(em_refsin.Text) , &
		 	Long(em_seq.Text),  &
			dw_saisi.getItemString(1,"MARQUE_SWAP"),  &
			dw_saisi.getItemString(1,"MODELE_SWAP"),  &
			dw_saisi.getItemString(1,"MARQUE_SWAP"),  &
			dw_saisi.getItemString(1,"MODELE_SWAP"),  &
			dw_saisi.getItemString(1,"ID_SERIE_NOUV"),  &
			 dw_saisi.getItemDecimal(1,"PRIX_SWAP"))
			 
		bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0		
	End if
	
	dw_saisi.SetItem(1,"INFO_FRN_SPB_CPLT",sVal)
	dw_saisi.SetItem(1,"COMMENT_FRN",dw_saisi.getItemString(1,"COMMENT_FRN_1"))
		
End if
// :[DT339]


sOldVal2=dw_saisi.getItemString(1,"COMMENT_FRN") // [PC151259]

// [DT401]
if bRet Then
	sCasRetour = Fill ( " ", 50 )	
	lRet = SQLCA.PS_S03_MAILPUSH_ENVTEL_REMP_REPAR_V03 ( "SIMPA2", Upper ( SQLCA.DataBase ), &
		 Long ( em_RefSin.Text ), Long ( em_Seq.Text ) ,  &
		 dw_Saisi.GetItemDateTime ( 1, "DTE_ENV_CLI" ) , "CLIENT", &
		 dw_Saisi.GetItemString ( 1, "ID_BON_TRANS" ) , dw_saisi.GetItemNumber(1,"STATUS_GC"), &
		  dw_Saisi.GetItemString ( 1, "COMMENT_FRN"), dw_Saisi.GetItemString ( 1, "INFO_FRN_SPB_CPLT"), sCasRetour )
		  
		  bRet=(lRet >= 0)
End if
// :[DT401]

/*------------------------------------------------------------------*/
/*    sysadm.PS_U01_COMMANDE                                        */
/* 	@dcIdSin        Decimal (  7,0 ),                             */
/* 	@iIdSeq		Integer		,                                     */
/* 	@iIdCmdFrn	VarChar ( 20 )	,                                  */
/* 	@iIdSerieNouv	VarChar ( 20 )	,                               */
/* 	@dtDteRcpFrn	DateTime	,                                     */
/* 	@dtDteEnvCli	DateTime	,                                     */
/* 	@idBonTransp	VarChar ( 20 )	,                               */
/* 	@sCodEtat	VarChar ( 3 )	,                                  */
/* 	@sCommentFrn	VarChar ( 255 )	,                            */
/* 	@iIdBsp		Integer		,                                     */
/* 	@dtDteRetPret	DateTime	,                                     */
/* 	@dtDteElvMobile DateTime	,                                  */
/* 	@iStatusGc	Integer		,                                     */
/* 	@dtDteEmisDevis DateTime	,                                  */
/* 	@dcMtDevis      Decimal (11,2)  ,                             */
/* 	@sAltDevAcp	VarChar ( 1 )	,                                  */
/* 	@dtDteDevAcp	DateTime	,                                     */
/* 	@dtDteRetLogis	DateTime	,                                     */
/* 	@dtDteRetPretMin	DateTime	,                                  */
/* 	@dtDteRetPretMax	DateTime	,                                  */
/* 	@dtDteEnvBteFrn	DateTime	,                                  */
/* 	@dtDteRcpBteCli	DateTime	,                                  */
/* 	@dtDteDepBteCli	DateTime	,                                  */
/* 	@dtDteEnvSt	DateTime	,                                        */
/* 	@dtDteRcpMobCli	DateTime	                                   */
/*------------------------------------------------------------------*/

sSql  = "Exec sysadm.PS_U01_COMMANDE "

/* 	@dcIdSin        Decimal (  7,0 ),                             */
sSql += em_RefSin.Text + ", "

/* 	@iIdSeq		Integer		,                                     */
sSql += em_Seq.Text + ", "

/* 	@iIdCmdFrn	VarChar ( 20 )	,                                  */
sVal = dw_Saisi.GetItemString ( 1, "ID_CMD_FRN" ) 
If IsNull ( sVal ) Then 
	sVal = "null,"
Else 
	sVal = "'" + sVal + "', "
End If
sSql += sVal

/* 	@iIdSerieNouv	VarChar ( 20 )	,                               */
//sSql += "null, "
// [PC171918].1
sVal = dw_Saisi.GetItemString ( 1, "ID_SERIE_NOUV" ) 
If IsNull ( sVal ) Then 
	sVal = "null,"
Else 
	sVal = "'" + sVal + "', "
End If
sSql += sVal
// :[PC171918].1

/* 	@dtDteRcpFrn	DateTime	,                                     */
// [DT401]
sVal = String ( dw_Saisi.GetItemDateTime ( 1, "DTE_RCP_FRN" ) )
If IsNull ( sVal ) Then 
	sVal = "null,"
Else 
	sVal = "'" + sVal + "', "
End If
sSql += sVal

/* 	@dtDteEnvCli	DateTime	,                                     */
//Migration PB8-WYNIWYG-03/2006 FM
//sVal = String ( dw_Saisi.GetItemDate ( 1, "DTE_ENV_CLI" ) )
sVal = String ( dw_Saisi.GetItemDateTime ( 1, "DTE_ENV_CLI" ) )
//Fin Migration PB8-WYNIWYG-03/2006 FM
If IsNull ( sVal ) Then 
	sVal = "null,"
Else 
	sVal = "'" + sVal + "', "
End If
sSql += sVal

/* 	@idBonTransp	VarChar ( 20 )	,                               */
sVal = dw_Saisi.GetItemString ( 1, "ID_BON_TRANS" ) 
If IsNull ( sVal ) Then 
	sVal = "null,"
Else 
	sVal = "'" + sVal + "', "
End If
sSql += sVal


/* 	@sCodEtat	VarChar ( 3 )	,                                  */
sVal = dw_Saisi.GetItemString ( 1, "COD_ETAT" ) 
If IsNull ( sVal ) Then 
	sVal = "null,"
Else 
	sVal = "'" + sVal + "', "
End If
sSql += sVal

/* 	@sCommentFrn	VarChar ( 255 )	,                            */
sVal = dw_Saisi.GetItemString ( 1, "COMMENT_FRN" ) 
If IsNull ( sVal ) Then 
	sVal = "null,"
Else 
	sVal = "'" + sVal + "', "
End If
sSql += sVal

/* 	@iIdBsp		Integer		,                                     */
sSql += "null, "

/* 	@dtDteRetPret	DateTime	,                                     */
sSql += "null, "

/* 	@dtDteElvMobile DateTime	,                                  */
sSql += "null, "

/* 	@iStatusGc	Integer		,                                     */
sVal = String ( dw_Saisi.GetItemNumber ( 1, "STATUS_GC" ) )
If IsNull ( sVal ) Then 
	sVal = "null,"
Else 
	sVal = sVal + ", "
End If
sSql += sVal

/* 	@dtDteEmisDevis DateTime	,                                  */
sSql += "null, "

/* 	@dcMtDevis      Decimal (11,2)  ,                             */
sSql += "null, "

/* 	@sAltDevAcp	VarChar ( 1 )	,                                  */
sSql += "null, "

/* 	@dtDteDevAcp	DateTime	,                                     */
sSql += "null, "

/* 	@dtDteRetLogis	DateTime	,                                     */
sSql += "null, "

/* 	@dtDteRetPretMin	DateTime	,                                  */
sSql += "null, "

/* 	@dtDteRetPretMax	DateTime	,                                  */
sSql += "null, "

/* 	@dtDteEnvBteFrn	DateTime	,                                  */
sSql += "null, "

/* 	@dtDteRcpBteCli	DateTime	,                                  */
sSql += "null, "

/* 	@dtDteDepBteCli	DateTime	,                                  */
sSql += "null, "

/* 	@dtDteEnvSt	DateTime	,                                        */
sSql += "null, "

/* 	@dtDteRcpMobCli	DateTime	                                   */
sSql += "null, "

/* 	@iIdOrianModele	Integer	#xO2Mx [O2M]                       */
sSql += "null, "

/* 	@sAdrFcNom			varchar(35) [DCMP080199]                    */
sSql += "null, "

/* 	@sMarq			   varchar(35) #2 [MICROMANIA]                    */
sSql += "null, "

/* 	@sModl   			varchar(35) #2 [MICROMANIA]                    */
sSql += "null, "

/* 	@dcPrixTTC			Decimal (11,2) #2 [MICROMANIA]                    */
sSql += "null, "

/* 	@sInfoFrnSpbCplt			varchar (800)  #1 [FNAC_PROD_ECH_TECH]   */
// [DT176]
//sSql += "null, "
sVal = dw_Saisi.GetItemString ( 1, "INFO_FRN_SPB_CPLT" ) 
If IsNull ( sVal ) Then 
	sVal = "null,"
Else 
	sVal = "'" + sVal + "', "
End If
sSql += sVal
// :[DT176]

// Suppression dela derni$$HEX1$$e800$$ENDHEX$$re Virgule
sSql = Left ( sSql, Len ( sSql ) - 2 )

// Maj
if bRet Then // [DT339] - car maj avant PS_U01_COMMANDE
	bRet = F_Execute ( sSql, SQLCA )
End if

// [CORR_MAJ_MANU_CMD]
if bRet Then
	F_Execute ( "Exec sysadm.PS_I_DIV_SIN_ETAT_ASS " +  em_RefSin.Text + "., 'SQL'", SQLCA )
	bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0
End if

// [PC151255]
If bRet Then
	if dw_saisi.getItemString(1,"ID_FOUR") = "CMA" and &
		dw_saisi.getItemString(1,"COD_ETAT")="RPC" Then
		
		F_Execute ( "Exec sysadm.PS_U01_MAJ_COMMANDE_CMA " +  em_RefSin.Text + "., 'SQL'", SQLCA )
		bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0
		
	End if
End if
// :[PC151255]

F_Commit ( SQLCA, bRet )

dw_Saisi.Retrieve ( Long ( em_RefSin.Text ), Long ( em_Seq.Text ) ) 

If bRet Then
	st_ResMaj.Text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour termin$$HEX1$$e900$$ENDHEX$$e avec succ$$HEX1$$e800$$ENDHEX$$s. V$$HEX1$$e900$$ENDHEX$$rifiez la validit$$HEX2$$e9002000$$ENDHEX$$des informations relues de la base ci-dessous"
	st_ResMaj.BackColor = 65280
	st_ResMaj.Show ()
Else
	st_ResMaj.Text = "Echec lors de la mise $$HEX2$$e0002000$$ENDHEX$$jour !!"
	st_ResMaj.BackColor = 255
	st_ResMaj.Show ()
End If

If dw_Saisi.GetItemString ( 1, "ID_TYP_ART" ) 	= "PRS" And &
	dw_Saisi.GetItemString ( 1, "ID_FOUR" ) 		= "DST" And &
	dw_Saisi.GetItemNumber ( 1, "STATUS_GC" ) 	= 30 Then

	stMessage.sTitre		= "Mise $$HEX2$$e0002000$$ENDHEX$$jour des commandes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD370" 

	F_Message ( stMessage )

End If

If dw_Saisi.GetItemString ( 1, "ID_TYP_ART" ) 	= "PRS" And &
	dw_Saisi.GetItemString ( 1, "ID_FOUR" ) 		= "DTY" And &
	dw_Saisi.GetItemNumber ( 1, "STATUS_GC" ) 	= 34 Then

	stMessage.sTitre		= "Mise $$HEX2$$e0002000$$ENDHEX$$jour des commandes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD380" 

	F_Message ( stMessage )

End If

If dw_Saisi.GetItemString ( 1, "ID_TYP_ART" ) 	= "AEF" And &
	dw_Saisi.GetItemString ( 1, "ID_FOUR" ) 		= "MDS" And &
	dw_Saisi.GetItemNumber ( 1, "STATUS_GC" ) 	= 72 Then

	stMessage.sTitre		= "Mise $$HEX2$$e0002000$$ENDHEX$$jour des commandes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD381" 

	F_Message ( stMessage )

End If


// [PC10][DIAG_NOMADE] 
If dw_Saisi.GetItemString ( 1, "ID_TYP_ART" ) 	= "AEF" And &
	dw_Saisi.GetItemString ( 1, "ID_FOUR" ) 		= "MBS" And &
	dw_Saisi.GetItemNumber ( 1, "STATUS_GC" ) 	= 72 Then

	stMessage.sTitre		= "Mise $$HEX2$$e0002000$$ENDHEX$$jour des commandes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD381" 

	F_Message ( stMessage )

End If

// [PC10-2] 
If dw_Saisi.GetItemString ( 1, "ID_TYP_ART" ) 	= "AEF" And &
	 dw_Saisi.GetItemString ( 1, "ID_FOUR" ) 		= "CVC"  And &
	dw_Saisi.GetItemNumber ( 1, "STATUS_GC" ) 	= 72 Then

	stMessage.sTitre		= "Mise $$HEX2$$e0002000$$ENDHEX$$jour des commandes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD381" 

	F_Message ( stMessage )

End If

// [PC13442-2] 
If dw_Saisi.GetItemString ( 1, "ID_TYP_ART" ) 	= "AEF" And &
	 dw_Saisi.GetItemString ( 1, "ID_FOUR" ) 		= "ATC"  And &
	dw_Saisi.GetItemNumber ( 1, "STATUS_GC" ) 	= 72 Then

	stMessage.sTitre		= "Mise $$HEX2$$e0002000$$ENDHEX$$jour des commandes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD381" 

	F_Message ( stMessage )

End If

// [DT176]
if dw_saisi.getItemString(1,"ID_FOUR") = "CMA" Then
	dw_saisi.SetItem(1,"INFO_FRN_SPB_CPLT",sOldVal)
	dw_saisi.setitemstatus( 1, 0, Primary!, NotModified!	)
End if
// :[DT176]

// [PC151259]
dw_saisi.SetItem(1,"COMMENT_FRN",sOldVal2)
end subroutine

public function integer wf_gestion_mds (long row, dwobject dwo, string data);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_saisie_manuelle_suivi::wf_gestion_mds
//* Auteur			: Pierre-Henri Gillot
//* Date				: 21/03/2007 15:07:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 	Action $$HEX2$$e0002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$aliser pour M$$HEX1$$e900$$ENDHEX$$dia-Saturn sur saisie d'une donn$$HEX1$$e900$$ENDHEX$$e
//*						[DCMP070191] : Sur Saisie Statut de Gestion de Commande, on d$$HEX1$$e900$$ENDHEX$$termine 
//*							automatiquement le code $$HEX1$$e900$$ENDHEX$$tat de la commande.
//*						
//* R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence		: [DCMP070191] Optimisation pour Media Saturn
//*
//* Arguments		: 	value long row
//* 						value dwobject dwo
//*						value string data
//*
//*						Cette Fonction est un Wrapper de dw_saisi.itemchanged
//*						( d'ou les argument ci-dessus )
//*						aisement d$$HEX1$$e900$$ENDHEX$$portable dans un objet metier 
//*						si cette fenetre prends de l'embonpoint...
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
String sCodeEtat

Choose Case upper(dwo.name)
	case 'STATUS_GC'
		choose case long(data)
			case 71
				sCodeEtat = 'RPC'
			case 72
				sCodeEtat = 'ANN'
		End Choose
		dw_saisi.object.cod_etat[row] = sCodeEtat
End choose

return 0 // Accept Data Value
end function

public function boolean wf_controler (ref string ascolumn, ref string aserrmess);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_saisie_manuelle_suivi::wf_controler
//* Auteur			: Pierre-Henri Gillot
//* Date				: 21/03/2007 15:37:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controle des Valeurs $$HEX2$$e0002000$$ENDHEX$$la Validation
//* Commentaires	: Ajout$$HEX2$$e9002000$$ENDHEX$$pour [DCMP070191]
//*
//* Arguments		: 	ref string ascolumn, derni$$HEX1$$e800$$ENDHEX$$re colonne en Erreur
//* 						ref string aserrmess, Message d'erreur associ$$HEX1$$e900$$ENDHEX$$
//*						Retourne par r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence la cause de l'erreur actuelle
//*						et la colonne en erreur
//*						Le traitement de l'erreur est laiss$$HEX4$$e9002000e0002000$$ENDHEX$$l'appelant.
//*
//* Retourne		: boolean : True : Ok pour valider, False erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 PHG	 21/03/2007		[DCMP070191] Version Initiale
//* #2    JFF   23/06/2008    [DCMP080287].FAX_MAIL
//*       JFF   01/09/2011    [PC10][DIAG_NOMADE]
//		FPI	18/12/2012		[PC10-2]
// 		FPI	08/09/2015		[PC13442-2] Ajout ATECH
//		FPI	20/10/2016		[PC151259]
//		FPI	10/10/2017		[PC171918].1
//		FPI	07/08/2018		[DT363]
//		FPI	21/03/2019		[DT401]
//*-----------------------------------------------------------------

boolean 	bOk = TRUE
datetime dtDteEnvCli
string sCodeEtat, sVal
long	lIdGti
decimal dcVal

asErrMess = ''

if dw_saisi.RowCount() > 0 then
	lIdGti = dw_Saisi.GetItemNumber ( 1, "ID_GTI" )
	Choose Case dw_Saisi.GetItemNumber ( 1, "ID_PROD" )
		/*------------------------------------------------------------------*/
		/* Darty Nomade                                                     */
		/*------------------------------------------------------------------*/
		Case 8691, 8692, 8693, 8694, 8695
	
			Choose Case dw_Saisi.GetItemString ( 1, "ID_FOUR" )
	
				Case "DTY"
				// A completer si controle a faire avec DTY
	
				Case "DST"
				// A completer si controle a faire avec DST
	
			End Choose 
	
		/*------------------------------------------------------------------*/
		/* MEDIA SATURN																	  */
		/*------------------------------------------------------------------*/
		Case 25300 TO 25315 
			Choose Case dw_Saisi.GetItemString ( 1, "ID_FOUR" )
	
				Case "MDS"
					If lIdGti = 11 Then
						dtDteEnvCli = dw_saisi.object.dte_env_cli[1]
						sCodeEtat	= upper(string(dw_saisi.object.cod_etat[1]))
					
						// #1 PHG [DCMP070191] Regle de gestion 1 :
						// Si Code Etat = 'ECT' la date d'expertise NE DOIT PAS etre saisie
						if sCodeEtat = 'ECT' and & 
							( not isnull(dtDteEnvCli) and date(dtDteEnvCli) <> 1900-01-01 ) then
							bOk 		= False
							asColumn = "DTE_ENV_CLI"
							asErrMess = "COMD444"
						End If
						
						// #1 PHG [DCMP070191] Regle de gestion 2 :
						// Si Code Etat <> 'ECT' la date d'expertise est obligatoire
						if sCodeEtat <> 'ECT' and &
							( isnull(dtDteEnvCli) or date(dtDteEnvCli) = 1900-01-01 ) then
							bOk 		= False
							asColumn = "DTE_ENV_CLI"
							asErrMess = "COMD445"
						End If
					End IF
			End Choose

		// #2 [DCMP080287].FAX_MAIL			
		Case 28601 TO 28606 
			Choose Case dw_Saisi.GetItemString ( 1, "ID_FOUR" )
	
				Case "SCF"
					If lIdGti = 18 Then
						dtDteEnvCli = dw_saisi.object.dte_env_cli[1]
						sCodeEtat	= upper(string(dw_saisi.object.cod_etat[1]))
					
						// Regle de gestion 1 :
						// Si Code Etat = 'ECT' la date d'expertise NE DOIT PAS etre saisie
						if sCodeEtat = 'ECT' and & 
							( not isnull(dtDteEnvCli) and date(dtDteEnvCli) <> 1900-01-01 ) then
							bOk 		= False
							asColumn = "DTE_ENV_CLI"
							asErrMess = "COMD444"
						End If
						
						// Regle de gestion 2 :
						// Si Code Etat <> 'ECT' la date d'expertise est obligatoire
						if sCodeEtat <> 'ECT' and &
							( isnull(dtDteEnvCli) or date(dtDteEnvCli) = 1900-01-01 ) then
							bOk 		= False
							asColumn = "DTE_ENV_CLI"
							asErrMess = "COMD445"
						End If
					End IF
			End Choose	
		// :#2 [DCMP080287].FAX_MAIL			
		

		// [PC10][DIAG_NOMADE]
		Case 23703, 23705, 23706
			Choose Case dw_Saisi.GetItemString ( 1, "ID_FOUR" )
	
				Case "MBS"
					If lIdGti = 11 Then
						dtDteEnvCli = dw_saisi.object.dte_env_cli[1]
						sCodeEtat	= upper(string(dw_saisi.object.cod_etat[1]))
					
						// #1 PHG [DCMP070191] Regle de gestion 1 :
						// Si Code Etat = 'ECT' la date d'expertise NE DOIT PAS etre saisie
						if sCodeEtat = 'ECT' and & 
							( not isnull(dtDteEnvCli) and date(dtDteEnvCli) <> 1900-01-01 ) then
							bOk 		= False
							asColumn = "DTE_ENV_CLI"
							asErrMess = "COMD444"
						End If
						
						// #1 PHG [DCMP070191] Regle de gestion 2 :
						// Si Code Etat <> 'ECT' la date d'expertise est obligatoire
						if sCodeEtat <> 'ECT' and &
							( isnull(dtDteEnvCli) or date(dtDteEnvCli) = 1900-01-01 ) then
							bOk 		= False
							asColumn = "DTE_ENV_CLI"
							asErrMess = "COMD445"
						End If
					End IF
			End Choose		
		// [PC10][DIAG_NOMADE]
		
	End CHoose
End If

// [PC10-2]
// [PC13442-2] Ajout ATECH
If  lIdGti = 11 And (dw_Saisi.GetItemString ( 1, "ID_FOUR" ) = "CVC"  Or dw_Saisi.GetItemString ( 1, "ID_FOUR" ) = "ATC")Then
	dtDteEnvCli = dw_saisi.object.dte_env_cli[1]
	sCodeEtat	= upper(string(dw_saisi.object.cod_etat[1]))

	// Si Code Etat = 'ECT' la date d'expertise NE DOIT PAS etre saisie
	if sCodeEtat = 'ECT' and & 
		( not isnull(dtDteEnvCli) and date(dtDteEnvCli) <> 1900-01-01 ) then
		bOk 		= False
		asColumn = "DTE_ENV_CLI"
		asErrMess = "COMD444"
	End If
	
	// Si Code Etat <> 'ECT' la date d'expertise est obligatoire
	if sCodeEtat <> 'ECT' and &
		( isnull(dtDteEnvCli) or date(dtDteEnvCli) = 1900-01-01 ) then
		bOk 		= False
		asColumn = "DTE_ENV_CLI"
		asErrMess = "COMD445"
	End If
End IF
// :[PC10-2]

// [PC151259]
If  dw_saisi.Describe("comment_frn.visible")="1" Then

	If dw_saisi.GetItemNumber(1,"status_gc") = 2 Then 
		dw_saisi.SetItem(1,"COMMENT_FRN"," ")
		// [PC171918].1
		dw_saisi.SetItem(1,"APP_SWAP","NON")
	End if
	
	
	If dw_saisi.GetItemNumber(1,"status_gc") = 21 Then
		sVal=dw_saisi.getitemstring(1,"COMMENT_FRN") 
		
		If isNull(sVal) or Trim(sVal)="" Then
				bOk=FALSE
				ascolumn="comment_frn"
				stmessage.svar[1]="- " +  dw_saisi.Object.t_etat.text + "~n"
				asErrMess="GENE001"
		End if
	End if
	
End if
// :[PC151259]

// [CORR_MAJ_MANU_CMD]
If bOk Then
	sCodeEtat	= upper(string(dw_saisi.object.cod_etat[1]))
	If sCodeEtat = "RFO" or sCodeEtat="RPC" Then
		
		stmessage.svar[1]=""
		If dw_saisi.Describe("status_gc.visible")="1" Then
			if isnull(dw_saisi.GetItemNumber(1,"status_gc") ) or dw_saisi.GetItemNumber(1,"status_gc") =0 Then
				bOk=FALSE
				ascolumn="status_gc"
				stmessage.svar[1]="- le " + dw_saisi.Object.t_statut_gc.text + "~n"
			End if
		End if
		
		dtDteEnvCli = dw_saisi.object.dte_env_cli[1]
		If isnull(dtDteEnvCli) or date(dtDteEnvCli) = 1900-01-01  then
			bOk=FALSE
			ascolumn="dte_env_cli"
			stmessage.svar[1]="- la " + dw_saisi.Object.t_dte_env_cli.text + "~n" + stmessage.svar[1]
		End if
		
		If dw_saisi.Describe("id_bon_trans.visible")="1" Then
			if isnull(dw_saisi.GetItemString(1,"id_bon_trans") ) or Trim(dw_saisi.GetItemString(1,"id_bon_trans")) ="" Then
				bOk=FALSE
				ascolumn="id_bon_trans"
				stmessage.svar[1]="- le n$$HEX2$$b0002000$$ENDHEX$$de bon transporteur ~n" + stmessage.svar[1]
			End if
		End if
		
		If dw_saisi.Describe("id_cmd_frn.visible")="1" Then
			if isnull(dw_saisi.GetItemString(1,"id_cmd_frn") ) or Trim(dw_saisi.GetItemString(1,"id_cmd_frn")) ="" Then
				bOk=FALSE
				ascolumn="id_cmd_frn"
				stmessage.svar[1]="- le n$$HEX2$$b0002000$$ENDHEX$$d'intervention fournisseur ~n" + stmessage.svar[1]
			End if
		End if
		
		if not bOk Then
			asErrMess="GENE001"
		End if
	End if
End if

// [PC171918].1
if dw_saisi.GetItemString(1,"APP_SWAP") = "OUI" Then
	sVal=dw_saisi.getitemstring(1,"MARQUE_SWAP") 
		
	If isNull(sVal) or Trim(sVal)="" Then
			if bOk Then stmessage.svar[1]=""
			bOk=FALSE
			if asColumn="" Then ascolumn="marque_swap"
			stmessage.svar[1]+="- " +  dw_saisi.Object.t_marque_swap.text + "~n"
			asErrMess="GENE001"
	End if	
	
	sVal=dw_saisi.getitemstring(1,"MODELE_SWAP") 
		
	If isNull(sVal) or Trim(sVal)="" Then
			if bOk Then stmessage.svar[1]=""
			bOk=FALSE
			if asColumn="" Then ascolumn="modele_swap"
			stmessage.svar[1]+="- " +  dw_saisi.Object.t_modele_swap.text + "~n"
			asErrMess="GENE001"
	End if	


	sVal=dw_saisi.getitemstring(1,"ID_SERIE_NOUV") 
		
	If isNull(sVal) or Trim(sVal)="" Then
			if bOk Then stmessage.svar[1]=""
			bOk=FALSE
			if asColumn="" Then ascolumn="id_serie_nouv"
			stmessage.svar[1]+="- " +  dw_saisi.Object.t_id_serie_nouv.text + "~n"
			asErrMess="GENE001"
	End if	


	dcVal=dw_saisi.getitemDecimal(1,"PRIX_SWAP") 
		
	If isNull(dcVal) or dcVal = 0 Then
			if bOk Then stmessage.svar[1]=""
			bOk=FALSE
			if asColumn="" Then ascolumn="prix_swap"
			stmessage.svar[1]+="- " +  dw_saisi.Object.t_prix_swap.text + "~n"
			asErrMess="GENE001"
	End if	


	sVal=dw_saisi.getitemstring(1,"ETAT_SWAP") 
		
	If isNull(sVal) or Trim(sVal)="" Then
			if bOk Then stmessage.svar[1]=""
			bOk=FALSE
			if asColumn="" Then ascolumn="etat_swap"
			stmessage.svar[1]+="- " +  dw_saisi.Object.t_etat_swap.text + "~n"
			asErrMess="GENE001"
	End if	
Else
	// App_swap d$$HEX1$$e900$$ENDHEX$$coch$$HEX1$$e900$$ENDHEX$$
	If dw_saisi.GetItemString(1,"VARIANTE") ="ADVISE_6" Then
		stMessage.berreurg=FALSE
		stMessage.stitre="Mise $$HEX2$$e0002000$$ENDHEX$$jour manuelle de commandes"
		stMessage.bouton=YesNo!
		stMessage.sCode="COMD969"
		
		if f_message(stMessage) <> 1 Then 
			bOk=FALSE
			asColumn="APP_SWAP"
		End if
	End if
End if

// [DT363]
if bOk and dw_saisi.GetItemString(1,"ID_FOUR") = "AAS" and dw_saisi.GetItemNumber(1,"STATUS_GC") = 178 Then
	sVal=dw_saisi.getitemstring(1,"MARQUE_SWAP") 
		
	If isNull(sVal) or Trim(sVal)="" Then
			if bOk Then stmessage.svar[1]=""
			bOk=FALSE
			if asColumn="" Then ascolumn="marque_swap"
			stmessage.svar[1]+="- " +  dw_saisi.Object.t_marque_swap.text + "~n"
			asErrMess="GENE001"
	End if	
	
	sVal=dw_saisi.getitemstring(1,"MODELE_SWAP") 
		
	If isNull(sVal) or Trim(sVal)="" Then
			if bOk Then stmessage.svar[1]=""
			bOk=FALSE
			if asColumn="" Then ascolumn="modele_swap"
			stmessage.svar[1]+="- " +  dw_saisi.Object.t_modele_swap.text + "~n"
			asErrMess="GENE001"
	End if	


	sVal=dw_saisi.getitemstring(1,"ID_SERIE_NOUV") 
		
	If isNull(sVal) or Trim(sVal)="" Then
			if bOk Then stmessage.svar[1]=""
			bOk=FALSE
			if asColumn="" Then ascolumn="id_serie_nouv"
			stmessage.svar[1]+="- " +  dw_saisi.Object.t_id_serie_nouv.text + "~n"
			asErrMess="GENE001"
	End if	


	dcVal=dw_saisi.getitemDecimal(1,"PRIX_SWAP") 
		
	If isNull(dcVal) or dcVal = 0 Then
			if bOk Then stmessage.svar[1]=""
			bOk=FALSE
			if asColumn="" Then ascolumn="prix_swap"
			stmessage.svar[1]+="- " +  dw_saisi.Object.t_prix_swap.text + "~n"
			asErrMess="GENE001"
	End if	


	sVal=dw_saisi.getitemstring(1,"ETAT_SWAP") 
		
	If isNull(sVal) or Trim(sVal)="" Then
			if bOk Then stmessage.svar[1]=""
			bOk=FALSE
			if asColumn="" Then ascolumn="etat_swap"
			stmessage.svar[1]+="- " +  dw_saisi.Object.t_etat_swap.text + "~n"
			asErrMess="GENE001"
	End if	
	
	sVal=dw_saisi.getitemstring(1,"TYPE_APP") 
	
	// Si TEL, on regarde si c'est un IMEI
	if bOk and not isnull(sVal) Then
		if sVal="TEL" Then
			If not f_imei(dw_saisi.getitemstring(1,"ID_SERIE_NOUV") , sVal) Then
				bOk=FALSE
				ascolumn="id_serie_nouv"
				stMessage.sVar[1]="- Un n$$HEX2$$b0002000$$ENDHEX$$IMEI valide (de 15 chiffres)"
				asErrMess="GENE001"
			End if
		End if
	End if
	
End if

// [DT401]
If bOk And dw_Saisi.GetItemString(1,"ID_TYP_ART")="PRS"Then
	if isNull( dw_Saisi.GetItemDateTime ( 1, "DTE_RCP_FRN" ) )Then
		if bOk Then stmessage.svar[1]=""
			bOk=FALSE
			if asColumn="" Then ascolumn="dte_rcp_frn"
			stmessage.svar[1]+="- " +  dw_saisi.Object.t_dte_rcp_frn.text + "~n"
			asErrMess="GENE001"
	End if
End if

return bOk



end function

public function integer wf_gestion_scf (long row, dwobject dwo, string data);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_saisie_manuelle_suivi::wf_gestion_scf
//* Auteur			: Fabry JF
//* Date				: 25/06/2008
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [DCMP080287].FAX_MAIL
//* Commentaires	: 	
//* R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence		: 
//*
//* Arguments		: 	value long row
//* 						value dwobject dwo
//*						value string data
//*
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
String sCodeEtat

Choose Case upper(dwo.name)
	case 'STATUS_GC'
		choose case long(data)
			case 221
				sCodeEtat = 'RPC'
			case 222
				sCodeEtat = 'ANN'
		End Choose
		dw_saisi.object.cod_etat[row] = sCodeEtat
End choose

return 0 // Accept Data Value

end function

public function integer wf_gestion_axa (long row, dwobject dwo, string data);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_saisie_manuelle_suivi::wf_gestion_axa
//* Auteur			: Fabry JF
//* Date				: 25/06/2008
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [DCMP080287].FAX_MAIL
//* Commentaires	: 	
//* R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence		: 
//*
//* Arguments		: 	value long row
//* 						value dwobject dwo
//*						value string data
//*
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
String sCodeEtat

Choose Case upper(dwo.name)
	case 'STATUS_GC'
		choose case long(data)
			case 2, 21
				sCodeEtat = 'RPC'
		End Choose
		dw_saisi.object.cod_etat[row] = sCodeEtat
End choose

return 0 // Accept Data Value

end function

public function integer wf_gestion_mbs (long row, dwobject dwo, string data);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_saisie_manuelle_suivi::wf_gestion_Mbs
//* Auteur			: Fabry JF
//* Date				: 21/03/2007 15:07:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PC10][DIAG_NOMADE]	
//*						
//* R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence		: [DCMP070191] Optimisation pour Media Saturn
//*
//* Arguments		: 	value long row
//* 						value dwobject dwo
//*						value string data
//*
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
String sCodeEtat

Choose Case upper(dwo.name)
	case 'STATUS_GC'
		choose case long(data)
			case 71
				sCodeEtat = 'RPC'
			case 72
				sCodeEtat = 'ANN'
		End Choose
		dw_saisi.object.cod_etat[row] = sCodeEtat
End choose

return 0 // Accept Data Value
end function

public function integer wf_gestion_omt (long row, dwobject dwo, string data);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_saisie_manuelle_suivi::wf_gestion_OMT
//* Auteur			: FPI
//* Date				: 23/11/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PC874]	
//*						
//* R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence		: 
//*
//* Arguments		: 	value long row
//* 						value dwobject dwo
//*						value string data
//*
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
String sCodeEtat

Choose Case upper(dwo.name)
	case 'STATUS_GC'
		choose case long(data)
			case 2,251,252
				sCodeEtat = 'RFO'
		End Choose
		dw_saisi.object.cod_etat[row] = sCodeEtat
End choose

return 0 // Accept Data Value
end function

public subroutine wf_enableswap (boolean abenable);string sProtect="1"

if abEnable Then sProtect="0"

dw_saisi.Modify("modele_swap.protect='" + sProtect + "'")
dw_saisi.Modify("marque_swap.protect='" + sProtect + "'")
dw_saisi.Modify("prix_swap.protect='" + sProtect + "'")
dw_saisi.Modify("etat_swap.protect='" + sProtect + "'")
dw_saisi.Modify("id_serie_nouv.protect='" + sProtect + "'")

dw_saisi.Modify("modele_swap_1.protect='" + sProtect + "'")
dw_saisi.Modify("marque_swap_1.protect='" + sProtect + "'")

end subroutine

public function integer wf_gestion_aas (long row, dwobject dwo, string data);//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_saisie_manuelle_suivi::wf_gestion_aas
//* Auteur			: FPI
//* Date				: 06/08/2018
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [DT339]
//* Commentaires	: 	
//* R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence		: 
//*
//* Arguments		: 	value long row
//* 						value dwobject dwo
//*						value string data
//*
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
String sCodeEtat, sNull
DataWindowChild dwChild
Long lRow
Decimal dcNull

SetNull(sNull)
SetNull(dcNull)

Choose Case upper(dwo.name)
	case 'STATUS_GC'
		choose case long(data)
			case 178
				dw_saisi.SetItem(1,"accord_indemn_pecu","NON")
				wf_setHeight(true,"AAS")
				dw_saisi.Modify("accord_indemn_pecu.protect='1'")	
				wf_enableswap( true)
			Case 176
				wf_setHeight(false,"AAS")
				dw_saisi.Modify("accord_indemn_pecu.protect='0'")	
			Case 21 // [DT401]
				if Trim(dw_saisi.GetItemString(1,"comment_frn")) <> "" Then dw_saisi.Modify("accord_indemn_pecu.protect='0'")	
				wf_enableswap( false)	
			Case 2 // [DT401]
				dw_saisi.Modify("accord_indemn_pecu.protect='1'")	
				dw_saisi.SetItem(1,"accord_indemn_pecu","NON")
				
				dw_saisi.SetItem(1,"comment_frn",sNull)
				
				// R$$HEX1$$e900$$ENDHEX$$init des zones de swap
				dw_saisi.Modify("app_swap.protect='1'")	
				dw_saisi.SetItem(1,"app_swap","NON")
				wf_enableswap( false)
				wf_empty_swap( )
				
		End Choose
	Case "MARQUE_SWAP_1"
		
		if isNull(data) Then // On ne s$$HEX1$$e900$$ENDHEX$$lectionne rien
			dw_saisi.GetChild ( "MODELE_SWAP_1", dwChild )
			dwChild.SetFilter("MARQUE=''")
			dwChild.Filter()
			dw_saisi.SetItem(1,"MODELE_SWAP",sNull)
			Return 0
		End if
		
		dw_saisi.GetChild ( "MARQUE_SWAP_1", dwChild )
		lRow = dwChild.Find ( "MARQUE='" + data + "'", 1, dwChild.RowCount () )
		if lRow <=0 Then
			return 1
		End if
		
		dw_saisi.GetChild ( "MODELE_SWAP_1", dwChild )
		dwChild.SetFilter("MARQUE='" + data + "'")
		dwChild.Filter()
		dw_saisi.SetItem(1,"MODELE_SWAP",sNull)
		
	Case "MODELE_SWAP_1"
		dw_saisi.GetChild ( "MODELE_SWAP_1", dwChild )
		lRow = dwChild.Find ( "REFERENCE='" + data + "'", 1, dwChild.RowCount () )
		if lRow <=0 Then
			return 1
		End if

	// [DT401]
	Case "APP_SWAP"
		if data="OUI" Then
			dw_saisi.SetItem(1,"accord_indemn_pecu","NON")
		End if
	Case "ACCORD_INDEMN_PECU"
		if data="OUI" Then
			dw_saisi.SetItem(1,"app_swap","NON")
			wf_enableswap( false)
		End if
		
	Case "COMMENT_FRN"
		if data="[BNV]" or Trim(data)="" Then
			dw_saisi.Modify("accord_indemn_pecu.protect='1'")	
			dw_saisi.SetItem(1,"accord_indemn_pecu","NON")
			
			// R$$HEX1$$e900$$ENDHEX$$init des zones de swap
			dw_saisi.Modify("app_swap.protect='1'")	
			dw_saisi.SetItem(1,"app_swap","NON")
			wf_enableswap( false)
			wf_empty_swap( )
		else
			if dw_saisi.getItemNumber(1,"status_gc") = 21 Then
				if dw_saisi.getitemstring( 1, "app_swap") = "OUI" Then  wf_enableswap( true)
				dw_saisi.Modify("accord_indemn_pecu.protect='0'")	
			End if
			
		End if
		
End choose

return 0 // Accept Data Value

end function

public subroutine wf_setheight (boolean bagrandir, string asfournisseur);// [PC171918].1
// [DT401]
if asFournisseur="AAS" and dw_saisi.getItemString(1,"ID_TYP_ART")="PRS" Then
//	asFournisseur="AAS_PRS"
End if
// :[DT401]

Choose case asFournisseur
	Case "EKO","DGC","NET", "SMT", "RAV", "RTP", "SFG" ,"AAS_PRS"
		if bAgrandir Then
			This.height=2612
			gwmdi.height=3132
			dw_saisi.height=1512
			cb_effacer.y=2252
			cb_maj.y=2252
		else
			This.height=1824
			gwmdi.height=2340
			dw_saisi.height=772
			cb_effacer.y=1524
			cb_maj.y=1524
		End if
	Case "AAS"
		If bAgrandir Then
			This.height=2672
			gwmdi.height=3132
			dw_saisi.height=1512
			cb_effacer.y=2252
			cb_maj.y=2252
		Else
			This.height=2064
			gwmdi.height=2580
			dw_saisi.height=1012
			cb_effacer.y=1764
			cb_maj.y=1764
		End if
	Case Else
			This.height=1824
			gwmdi.height=2340
			dw_saisi.height=772
			cb_effacer.y=1524
			cb_maj.y=1524
End Choose
end subroutine

public subroutine wf_epure_zone ();String sComment

dw_Saisi.AcceptText ()

sComment = dw_saisi.getitemString(1,"COMMENT_FRN")

if isnull(sComment) Then sComment= dw_saisi.getitemString(1,"COMMENT_FRN_1")

if isnull(sComment) Then return

sComment = f_remplace(sComment,Char(13)," ")
sComment = f_remplace(sComment,Char(10)," ")
sComment = f_remplace(sComment,Char(9)," ")
sComment = f_remplace(sComment,Char(11)," ")
sComment = f_remplace(sComment,"~""," ")
sComment = f_remplace(sComment,"~'"," ")

dw_saisi.setitem( 1,"COMMENT_FRN",sComment)
dw_saisi.setitem( 1,"COMMENT_FRN_1",sComment)
end subroutine

public subroutine wf_empty_swap ();String sNull
Decimal dcNull

SetNull(dcNull)
SetNull(sNull)

dw_saisi.SetItem(1,"marque_swap",sNull)
dw_saisi.SetItem(1,"modele_swap",sNull)
dw_saisi.SetItem(1,"marque_swap_1",sNull)
dw_saisi.SetItem(1,"modele_swap_1",sNull)
dw_saisi.SetItem(1,"id_serie_nouv",sNull)
dw_saisi.SetItem(1,"prix_swap",dcNull)
dw_saisi.SetItem(1,"etat_swap",sNull)
end subroutine

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_saisie_manuelle_suivi
//* Evenement     : Open
//* Auteur        : Fabry JF
//* Date          : 27/01/2005 11:11:30
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
//*			FPI	22/11/2011	[PM95]
//				FPI	10/10/2017	[PC171819].1
//				FPI	14/08/2018	[DT363]
//*-----------------------------------------------------------------

DataWindowChild dwChild

This.Title = "Mise $$HEX2$$e0002000$$ENDHEX$$jour manuelle des commandes/prestations"

dw_Saisi.GetChild ( "STATUS_GC", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-GC" )

dw_Saisi.GetChild ( "COD_ETAT", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-EC" )

dw_Saisi.SetTransObject ( SQLCA )
dw_pm95.SetTransObject( SQLCA ) // [PM95]

// [PC171819].1
dw_Saisi.GetChild ( "MARQUE_SWAP", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ("-MB" )

dw_Saisi.GetChild ( "MARQUE_SWAP_1", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ("TEL" )

dw_Saisi.GetChild ( "MODELE_SWAP_1", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ("TEL" )


This.wf_Init ()


end event

on w_sp_trt_saisie_manuelle_suivi.create
int iCurrent
call super::create
this.st_2=create st_2
this.em_refsin=create em_refsin
this.em_seq=create em_seq
this.cb_interro=create cb_interro
this.gb_1=create gb_1
this.dw_saisi=create dw_saisi
this.cb_maj=create cb_maj
this.cb_effacer=create cb_effacer
this.st_resmaj=create st_resmaj
this.st_1=create st_1
this.dw_pm95=create dw_pm95
this.cb_status_gc=create cb_status_gc
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.em_refsin
this.Control[iCurrent+3]=this.em_seq
this.Control[iCurrent+4]=this.cb_interro
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.dw_saisi
this.Control[iCurrent+7]=this.cb_maj
this.Control[iCurrent+8]=this.cb_effacer
this.Control[iCurrent+9]=this.st_resmaj
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.dw_pm95
this.Control[iCurrent+12]=this.cb_status_gc
this.Control[iCurrent+13]=this.gb_2
end on

on w_sp_trt_saisie_manuelle_suivi.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.em_refsin)
destroy(this.em_seq)
destroy(this.cb_interro)
destroy(this.gb_1)
destroy(this.dw_saisi)
destroy(this.cb_maj)
destroy(this.cb_effacer)
destroy(this.st_resmaj)
destroy(this.st_1)
destroy(this.dw_pm95)
destroy(this.cb_status_gc)
destroy(this.gb_2)
end on

event hide;call super::hide;// [PC171918].1
gWMdi.Height=2340
end event

event show;call super::show;//wf_setHeight(This.height=3600) 
end event

type cb_debug from w_8_accueil`cb_debug within w_sp_trt_saisie_manuelle_suivi
end type

type pb_retour from w_8_accueil`pb_retour within w_sp_trt_saisie_manuelle_suivi
integer width = 242
integer height = 144
integer taborder = 130
end type

type pb_interro from w_8_accueil`pb_interro within w_sp_trt_saisie_manuelle_suivi
boolean visible = false
integer width = 242
integer height = 144
integer taborder = 150
end type

type pb_creer from w_8_accueil`pb_creer within w_sp_trt_saisie_manuelle_suivi
boolean visible = false
integer width = 242
integer height = 144
integer taborder = 140
end type

type dw_1 from w_8_accueil`dw_1 within w_sp_trt_saisie_manuelle_suivi
integer taborder = 30
end type

type pb_tri from w_8_accueil`pb_tri within w_sp_trt_saisie_manuelle_suivi
boolean visible = false
integer width = 242
integer height = 144
integer taborder = 160
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_sp_trt_saisie_manuelle_suivi
integer taborder = 20
end type

type st_2 from statictext within w_sp_trt_saisie_manuelle_suivi
integer x = 485
integer y = 464
integer width = 64
integer height = 80
boolean bringtotop = true
integer textsize = -15
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_refsin from editmask within w_sp_trt_saisie_manuelle_suivi
integer x = 46
integer y = 472
integer width = 443
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##########"
end type

type em_seq from editmask within w_sp_trt_saisie_manuelle_suivi
integer x = 562
integer y = 472
integer width = 114
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#"
end type

type cb_interro from commandbutton within w_sp_trt_saisie_manuelle_suivi
integer x = 681
integer y = 464
integer width = 343
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Interroger"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_1
//* Evenement     : clicked
//* Auteur        : Fabry JF
//* Date          : 27/01/2005 11:30:39
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

Parent.wf_Interro ()
end on

type gb_1 from groupbox within w_sp_trt_saisie_manuelle_suivi
integer x = 27
integer y = 376
integer width = 1042
integer height = 252
integer taborder = 110
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "N$$HEX1$$b000$$ENDHEX$$Commande"
end type

type dw_saisi from datawindow within w_sp_trt_saisie_manuelle_suivi
integer x = 46
integer y = 712
integer width = 2674
integer height = 776
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_trt_saisie_manuelle_suivi"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//*-----------------------------------------------------------------
//*
//* Objet         : dw_Saisi
//* Evenement     : ItemChanged
//* Auteur        : Fabry JF
//* Date          : 27/01/2005 11:11:30
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
//* #1	PHG	21/03/2007	  [DCMP070191] Optimisation MEdia Saturn
//* #2   JFF   23/06/2008    [DCMP080287].FAX_MAIL
// 		JFF	20/01/2011    [GROSBILL].[PC398-403-479]
//*      JFF   01/09/2011  [PC10][DIAG_NOMADE]
//		FPI	18/12/2012	[PC10-2] Converlance
//		FPI	08/09/2015	[PC13442-2] Atech
//		FPI	09/10/2017	[PC171918].1
//		FPI	06/08/2018	[DT339]
//    JFF   21/11/2018 [VDOC27123]
//*-----------------------------------------------------------------
DatawindowChild dwChild
Long lRow

st_ResMaj.Hide ()

// #1 [DCMP070191]
if upper(string(this.object.id_four[row])) = "MDS" then
	wf_gestion_mds(row, dwo, data)
End If

//* #2 [DCMP080287].FAX_MAIL
if upper(string(this.object.id_four[row])) = "SCF" then
	wf_gestion_scf(row, dwo, data)
End If
//* :#2 [DCMP080287].FAX_MAIL

// [GROSBILL].[PC398-403-479]
if upper(string(this.object.id_four[row])) = "AXA" then
   wf_gestion_axa (row, dwo, data)
End If

// [PC10][DIAG_NOMADE]
if upper(string(this.object.id_four[row])) = "MBS" then
	wf_gestion_mbs(row, dwo, data)
End If

// [PC10-2] Ajout de CVC
if upper(string(this.object.id_four[row])) = "CVC" then
	wf_gestion_mbs(row, dwo, data)
End If

// [PC874]
if upper(string(this.object.id_four[row])) = "OMT" then
	wf_gestion_omt(row, dwo, data)
End If

// [PC13442-2] Ajout ATECH
if upper(string(this.object.id_four[row])) = "ATC" then
	wf_gestion_mbs(row, dwo, data)
End If

// [PC171918].1
// [VDOC27123]BVID/BVIP/BVIT
if Lower(dwo.name)="comment_frn" then
	
	Choose Case data
		Case "[BVIE]", "[BVID]", "[BVIP]", "[BVIT]"
			wf_enableswap( dw_saisi.GetItemString(1,"APP_SWAP") = "OUI" )
			dw_saisi.Modify("app_swap.protect='0'")			
		Case Else 
			wf_enableswap( FALSE )			
			dw_saisi.Modify("app_swap.protect='1'")			
	End Choose 

End if

if Lower(dwo.name)="app_swap" then
	wf_enableswap( data = "OUI")
End if

if Lower(dwo.name)="marque_swap" then
	dw_saisi.GetChild ( "MARQUE_SWAP", dwChild )
	lRow = dwChild.Find ( "LIB_CODE='" + data + "'", 1, dwChild.RowCount () )
	if lRow <=0 Then
		return 1
	End if
End if

// [DT339]
if upper(string(this.object.id_four[row])) = "AAS" then
	Return wf_gestion_aas(row, dwo, data)
End If

end event

event itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: W_sp_trt_saisie_manuelle_suivi::dw_saisi
//* Evenement 		: ItemError
//* Auteur			: FPI
//* Date				: 10/10/2017
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PC171919].1
//* Commentaires	: Gestion des messages d'erreur
//*				  
//*-----------------------------------------------------------------
long	ll_ret = 0
n_cst_string lnv_String 

stMessage.sTitre		= "Mise $$HEX2$$e0002000$$ENDHEX$$jour manuelle des commandes"
stMessage.Icon			= Information!
stMessage.bErreurG	= TRUE

Choose Case Upper ( This.GetColumnName () ) 
	Case "PRIX_SWAP"
			stMessage.sVar[1] = "prix TTC de l'appareil swapp$$HEX1$$e900$$ENDHEX$$"			// Erreur de Validation - 
			stMessage.sCode	= "GENE003"
			ll_ret=1
			
			f_message(stMessage)
			
			 This.SetItem(row, "PRIX_SWAP",stNul.dcm)
	Case "MARQUE_SWAP", "MARQUE_SWAP_1"
			stMessage.sVar[1] = "marque de l'appareil swapp$$HEX1$$e900$$ENDHEX$$"			// Erreur de Validation - 
			stMessage.sCode	= "GENE002"
			ll_ret=1
			
			f_message(stMessage)
			
			 This.SetItem(row, "MARQUE_SWAP",stNul.str)
	Case "MODELE_SWAP_1"
			stMessage.sVar[1] = "mod$$HEX1$$e800$$ENDHEX$$le de l'appareil swapp$$HEX1$$e900$$ENDHEX$$"			// Erreur de Validation - 
			stMessage.sCode	= "GENE003"
			ll_ret=1
			
			f_message(stMessage)
			
			 This.SetItem(row, "MARQUE_SWAP",stNul.str)
End Choose
	



return ll_ret

end event

type cb_maj from commandbutton within w_sp_trt_saisie_manuelle_suivi
integer x = 1358
integer y = 1596
integer width = 1330
integer height = 108
integer taborder = 100
boolean bringtotop = true
integer textsize = -15
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mettre $$HEX2$$e0002000$$ENDHEX$$jour la commande"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_maj
//* Evenement     : clicked
//* Auteur        : Fabry JF
//* Date          : 27/01/2005 11:30:39
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

Parent.wf_Maj ()

end on

type cb_effacer from commandbutton within w_sp_trt_saisie_manuelle_suivi
integer x = 41
integer y = 1596
integer width = 1307
integer height = 108
integer taborder = 120
boolean bringtotop = true
integer textsize = -15
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Initialiser les zones"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_effacer
//* Evenement     : clicked
//* Auteur        : Fabry JF
//* Date          : 27/01/2005 11:30:39
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

Parent.wf_Init ()

end on

type st_resmaj from statictext within w_sp_trt_saisie_manuelle_suivi
integer x = 594
integer y = 192
integer width = 1568
integer height = 152
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_1 from statictext within w_sp_trt_saisie_manuelle_suivi
integer x = 320
integer y = 36
integer width = 2363
integer height = 112
integer textsize = -15
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
boolean enabled = false
string text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour manuelle des commandes/prestations"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_pm95 from datawindow within w_sp_trt_saisie_manuelle_suivi
integer x = 1129
integer y = 368
integer width = 1550
integer height = 320
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_maj_cmd_pm95"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_manuelle_suivi
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 22/11/2011 15:48:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PM95]
//*				  
//* Arguments		: value integer xpos	 */
/* 	value integer ypos	 */
/* 	value long row	 */
/* 	value dwobject dwo	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
Long lRet

If upper(dwo.Name) = "B_ENREGISTRER" Then
	if dw_pm95.Describe("b_enregistrer.Enabled") = "0" Then Return 0
	
	lRet=This.Update()
	
	If lRet=1 Then
		F_Commit ( SQLCA, TRUE )
		st_ResMaj.Text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour termin$$HEX1$$e900$$ENDHEX$$e avec succ$$HEX1$$e800$$ENDHEX$$s."
		st_ResMaj.BackColor = 65280
		st_ResMaj.Show ()
	Else
		F_Commit ( SQLCA, FALSE )
		st_ResMaj.Text = "Echec lors de la mise $$HEX2$$e0002000$$ENDHEX$$jour !!"
		st_ResMaj.BackColor = 255
		st_ResMaj.Show ()
	End If
End if
end event

type cb_status_gc from commandbutton within w_sp_trt_saisie_manuelle_suivi
integer x = 2757
integer y = 468
integer width = 590
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mettre $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_status_gc
//* Evenement     : clicked
//* Auteur        : FPI
//* Date          : 21/11/2012
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : [ITSM_Status_GC_0] 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------
Long lIdSin, lIdSeq

stMessage.sTitre		= "Mise $$HEX2$$e0002000$$ENDHEX$$jour des commandes"
stMessage.Icon			= Exclamation!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= YesNo!
stMessage.sCode		= "COMD749" 

if F_Message ( stMessage ) = 1 Then
	lIdSin = Long ( em_RefSin.Text ) 
	lIdSeq = Long ( em_Seq.Text ) 
	
	SQLCA.PS_U21_COMMANDE_STATUS_GC( lIdSin, lIdSeq, stglb.scodoper )
	
	If SQLCA.Sqlcode = 0 And SQLCA.Sqldbcode = 0 Then
	
		F_Commit ( SQLCA, TRUE )
		st_ResMaj.Text = "Mise $$HEX2$$e0002000$$ENDHEX$$jour termin$$HEX1$$e900$$ENDHEX$$e avec succ$$HEX1$$e800$$ENDHEX$$s."
		st_ResMaj.BackColor = 65280
		st_ResMaj.Show ()
	Else
		F_Commit ( SQLCA, FALSE )
		st_ResMaj.Text = "Le contexte du dossier ne permet plus cette mise $$HEX2$$e0002000$$ENDHEX$$jour."
		st_ResMaj.BackColor = 255
		st_ResMaj.Show ()
	End If
End if

end event

type gb_2 from groupbox within w_sp_trt_saisie_manuelle_suivi
integer x = 2738
integer y = 376
integer width = 640
integer height = 252
integer taborder = 170
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Mise $$HEX2$$e0002000$$ENDHEX$$0 status_gc"
end type

