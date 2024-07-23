$PBExportHeader$w_sp_trt_autofact.srw
$PBExportComments$Automatisation Facturation Fournisseur
forward
global type w_sp_trt_autofact from w_8_accueil
end type
type cb_charger from commandbutton within w_sp_trt_autofact
end type
type cb_annuler from commandbutton within w_sp_trt_autofact
end type
type st_charger from statictext within w_sp_trt_autofact
end type
type st_extraire from statictext within w_sp_trt_autofact
end type
type cb_controler from commandbutton within w_sp_trt_autofact
end type
type dw_fourn from datawindow within w_sp_trt_autofact
end type
type cb_maj from commandbutton within w_sp_trt_autofact
end type
type dw_charger from datawindow within w_sp_trt_autofact
end type
type hpb_trt from hprogressbar within w_sp_trt_autofact
end type
type st_1 from statictext within w_sp_trt_autofact
end type
type st_avertissement_monnaie from u_st_avertissement_monnaie within w_sp_trt_autofact
end type
type cb_result from commandbutton within w_sp_trt_autofact
end type
type dw_visu_trt from datawindow within w_sp_trt_autofact
end type
type cb_taillefen from commandbutton within w_sp_trt_autofact
end type
type st_pct from statictext within w_sp_trt_autofact
end type
end forward

global type w_sp_trt_autofact from w_8_accueil
integer width = 3639
integer height = 1952
long backcolor = 67108864
windowanimationstyle openanimation = leftslide!
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
cb_result cb_result
dw_visu_trt dw_visu_trt
cb_taillefen cb_taillefen
st_pct st_pct
end type
global w_sp_trt_autofact w_sp_trt_autofact

type variables
Private :

String	K_FICCHARG = "FICFOURN.TXT" // Nom du fichier de donnée de facturation
integer	K_TYPFACT_PRESTA	= 1
integer	K_TYPFACT_H_PRESTA= 2
integer	K_TYPFACT_H_PRESTA_MAJ_1_DETAIL = 3 // [VDOC9586]
integer	K_TYPFACT_H_PRESTA_IPHONE_O2M_SFR = 4 // [DT57_CMDE_IPHONE_SFR]
integer	K_TYPFACT_PRESTA_NORM_SANS_REGL = 5 // [DT044-1_V5]
integer	K_TYPFACT_DIAG_O2M = 6 // [PM210]
integer	K_TYPFACT_BNP_SECU = 7 // [PC13174]

datastore ids_charger

String   isCasTailleFen
end variables

forward prototypes
private function boolean wf_chargerdonnees ()
private function boolean wf_maj ()
private function integer wf_chargerdw ()
private function boolean wf_pm251_2_validation_auto (long adcidsin, long adcidprod, ref string asresult)
private function boolean wf_controler ()
public subroutine wf_positionner_objets (string ascas)
public subroutine wf_positionnerobjets ()
private subroutine wf_pct ()
end prototypes

private function boolean wf_chargerdonnees ();
//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_autofact::wf_ChargerDonnees (PRIVATE)
//* Auteur        : PHG
//* Date          : 22/11/2006
//* Libellé       : Chargement des données
//* Commentaires  : Chargement des références commandes SPB se trouvant
//*					  sur <REP_TEMPO>\FICFOURN.TXT
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	JCA	22/02/2007	DCMP 070110 - Ajout du fournisseur Darty
//*-----------------------------------------------------------------

Boolean bOk
Long	lTotRow
String sFicFourn

stMessage.sTitre  	= "Controle de saisie"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!

bOk = True
sFicFourn = stGlb.sRepTempo + K_FICCHARG

// #1
// charge le data object correspondant au groupe de fournisseur sélectionné (darty ou non darty).
st_1.visible = false
wf_chargerdw ()
// FIN - #1

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
/* Chargement des données.                                          */
/*------------------------------------------------------------------*/
If bOk Then
	lTotRow = dw_Charger.ImportFile ( sFicFourn )

	If lTotRow < 0 Then
		stMessage.sCode = "COMD037"
		stMessage.sVar [1] = String ( lTotRow )
		bOk = False
	End If
	
End If

/*------------------------------------------------------------------*/
/* MAJ du static text                                               */
/*------------------------------------------------------------------*/
If bOk Then
	st_Charger.Text = String ( lTotRow ) + " références commandes chargées"
End If


If Not bOk Then F_Message ( stMessage )

Return bOk


end function

private function boolean wf_maj ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_autofact::wf_Maj (PRIVATE)
//* Auteur        : PHG, d'après JFF
//* Date          : 21/11/2006
//* Libellé       : 
//* Commentaires  : 
//*					  
//*
//* Arguments     : 
//*
//* Retourne      : Boolean	bRet
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modi
//* #1	JCA		23/02/2007	DCMP 070110 - Ajout du fournisseur Darty
//* #2	PHG						[DCMP080166] - Ajout Catégorie de Facture  
//* #3	PHG		13/06/2008	[DCMP080461] - Intégration Facture Hors PRestation
//* #4	PHG		15/04/2009	[FNAC_PROD_ECH_TECH] - Fnac Attitude
//* #5   JFF		09/01/2013  [VDOC9586]
//       JFF      07/10/2013  [DT044-1_V5]
//       JFF   	05/11/2013 	[PM210]
//       JFF      03/09/2014  [DT92_FACTU_CASTO]
//       JFF      22/10/2014  [FACTU_VIP_CDS]
// 		FPI		29/10/2014	[PC13174]
//       JFF   	25/11/2014 	[PM251-2]
// 		FPI	30/01/2015	[FACTU_SRR]
// 		JFF	12/03/2015  [VDOC14649]
//       JFF   09/04/2015 [DT141]
//       JFF   29/10/2015 [BUG_PM251-2]
//       JFF   07/06/2016 [DT227]
//       JFF   07/11/2016 [PC151259]
//			JFF   11/04/2017 [ITSM456299]
//			JFF   08/08/2017 [DT288] Facturation ORANGCE SCF (Cordon)
//		   JFF   21/12/2017 [BUG_REGL_FACT_DBL_RG]
//       JFF   22/10/2019 [PI087_PM473_2]
//       JFF   09/09/2022 [PM80_FA12_FRANEX]
//*-----------------------------------------------------------------

Long		lCpt, lTot, lNbTraite, lRet, dcIdProd, lNbValide, lIdSeq, lVal, lAutorisation
Long      lCtrlValide, lRet2, dcIdInter, dcIdDoc
String	sTraite = 'N', sResult, sResultSav, sSql 
Boolean	bRet, bRollbackContinue, bEligiblePM251T2, bDroitForcage, bRet2
string   sFournisseur // #1
integer  iIdTypFact
String 	sLstArt1, sLstArt2, sLstArt3, sChaine
n_cst_string lnvPFCString


bEligiblePM251T2  = False
bRollbackContinue = False
lNbValide = 0
lNbTraite = 0
bRet = False
lTot = dw_Charger.RowCount()
hpb_trt.Position = 0
hpb_trt.MaxPosition = lTot
wf_pct()
Yield()

SetNull ( dcIdInter )
SetNull ( dcIdDoc )

st_extraire.textcolor = 16711680
st_extraire.backcolor = 67108864

sFournisseur  = dw_Fourn.object.id_fourn[1] 		// #1
iIdTypFact    = dw_Fourn.object.id_typ_fact[1] 	// #3 [DCMP080461] Lecture Type de Facturation

stMessage.sTitre		= "Mise a jour." 
stMessage.Icon			= Exclamation!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= YesNo!

sChaine = ""

// [PM336-1]
SQLCA.ps_s01_autorisation (226, stGlb.sCodOper, -1, lAutorisation )	
bDroitForcage = lAutorisation > 0

// [VDOC9586]

lIdSeq = 0 // [PM251-2]

Choose Case iIdTypFact 
	Case K_typfact_h_presta 
		// Non éligible au PM251-2, Pas d'action sur SIMPA2
		lIdSeq = -100	// [PM251-2]	
		stMessage.sCode		= "COMD479" 
		
	Case K_TYPFACT_H_PRESTA_MAJ_1_DETAIL
		bEligiblePM251T2 = TRUE // [PM251-2]		
		lIdSeq = -100	// [PM251-2]			

		// [PM251-2]
		stMEssage.scode  = "COMD891"							

		
	Case K_TYPFACT_H_PRESTA_IPHONE_O2M_SFR
		// Non éligible au PM251-2, n'a jamais vu le jour en prodcution.
		lIdSeq = -100	// [PM251-2]			
		stMessage.sCode		= "COMD824" 
		
	Case K_TYPFACT_PRESTA_NORM_SANS_REGL
		bEligiblePM251T2 = TRUE // [PM251-2]				

		// [PM251-2]
		stMEssage.scode  = "COMD892"							
		
	Case K_TYPFACT_DIAG_O2M

		bEligiblePM251T2 = TRUE // [PM251-2]				
		stMessage.sCode		= "COMD836"  // [PM210]
		
	Case K_TYPFACT_BNP_SECU
		// Non éligible au PM251-2, reste manuel
		lIdSeq = -100  // [PM251-2]
		stMEssage.scode  = "COMD884"// [PC13174]
		
	Case Else
		bEligiblePM251T2 = TRUE // [PM251-2]		
	
		// [PM251-2]
		If bEligiblePM251T2 Then		
			stMessage.sCode		= "COMD889" 
		Else
			stMessage.sCode		= "COMD429" 
		End If
		
End Choose


If F_Message ( stMessage ) = 1 Then
	
	bRet = True

	// [PM251-2]
	dw_visu_trt.Reset ()
	dw_visu_trt.InsertRow ( 0 )
	dw_visu_trt.SetItem ( 1, "DTE_DEB", DateTime ( Today (), Now () ) )

	For lCpt = 1 To lTot

	sChaine = ""


	// [PM336-1]
	If TRIM ( ids_charger.GetITemString ( lCpt, "A_FORCER" )) = "A_FORCER" And bDroitForcage Then
		lnvPFCString.of_Setkeyvalue ( sChaine, "A_FORCER", "OUI", ";")
	End If 

	sResult = space ( 500 )
	
		if iIdTypFact = K_typfact_h_presta Then // #3 [DCMP080461] Mise à Jour Contact / travail

			// [PM80_FA12_FRANEX] : Rien ici car aucun maj de détail, aucune validation de règlement.

			lRet = sqlca.PS_U05_DETAIL_MAJ_FACTU_V01 (long(ids_charger.object.id_sin[lCpt]),	&
													 string(ids_charger.object.id_fourn[lCpt]),		&
													 datetime(ids_charger.object.dte_fact[lCpt]),	&
													 string(ids_charger.object.num_facture[lCpt]),	&
													 Real(ids_charger.object.mte_fact[lCpt]),			&
						/* #2 [DCMP080166]*/	 string(ids_charger.object.cat_fact[lCpt]), 		&
						/* [PM336-1] */		 sChaine,													&
													 sTraite )
		ElseIf iIdTypFact = K_TYPFACT_H_PRESTA_MAJ_1_DETAIL Then
				// [VDOC9586] // [DT92_FACTU_CASTO]

				// [PM80_FA12_FRANEX] libérer u_transaction à la désac de clé, supp ancienne PS !!!
				lRet = sqlca.PS_U08_DETAIL_MAJ_FACTU_V03 (long(ids_charger.object.id_sin[lCpt]),	&
														 string(ids_charger.object.id_fourn[lCpt]),		&
														 datetime(ids_charger.object.dte_fact[lCpt]),	&
														 string(ids_charger.object.num_facture[lCpt]),	&
														 Real(ids_charger.object.mte_fact[lCpt]),			&
														 string(ids_charger.object.cat_fact[lCpt]), 		&
														 Dec(ids_charger.object.indem_princ_1[lCpt]),	&
														 Dec(ids_charger.object.frais_anex_2[lCpt]), 	& 
														 Dec(ids_charger.object.frais_anex_3[lCpt]), 	&  
														 Dec(ids_charger.object.frais_anex_4[lCpt]), 	&  
														 Dec(ids_charger.object.frais_anex_5[lCpt]), 	&  
														 Dec(ids_charger.object.frais_anex_6[lCpt]), 	&  
														 Dec(ids_charger.object.frais_anex_7[lCpt]), 	&  
														 Dec(ids_charger.object.frais_anex_8[lCpt]), 	&  
														 Dec(ids_charger.object.frais_anex_9[lCpt]), 	&  
														 Dec(ids_charger.object.frais_anex_10[lCpt]), 	& 
														 Dec(ids_charger.object.frais_anex_11[lCpt]), 	& 
							 /* [PM336-1] */		 sChaine,													&
														 sTraite, &
														 sResult )

				// [DT92_FACTU_CASTO]
				dw_charger.SetItem ( lCpt, "RESULT", Trim ( sResult ) ) 
														 
														 
		ElseIf iIdTypFact = K_TYPFACT_H_PRESTA_IPHONE_O2M_SFR Then
				// [DT57_CMDE_IPHONE_SFR]

				// [PM80_FA12_FRANEX] libérer u_transaction à la désac de clé
				lRet = sqlca.PS_U09_DETAIL_MAJ_FACTU_V02 (long(ids_charger.object.id_sin[lCpt]),	&
															 string(ids_charger.object.id_fourn[lCpt]),		&
															 datetime(ids_charger.object.dte_fact[lCpt]),	&
															 string(ids_charger.object.num_facture[lCpt]),	&
															 Real(ids_charger.object.mte_fact[lCpt]),			&
															 string(ids_charger.object.cat_fact[lCpt]), 		&
															 Dec(ids_charger.object.indem_princ_1[lCpt]),	&
															 Dec(ids_charger.object.frais_anex_2[lCpt]), 	& 
															 Dec(ids_charger.object.frais_anex_3[lCpt]), 	&  
															 Dec(ids_charger.object.frais_anex_4[lCpt]), 	&  
															 Dec(ids_charger.object.frais_anex_5[lCpt]), 	&  
															 Dec(ids_charger.object.frais_anex_6[lCpt]), 	&  
															 Dec(ids_charger.object.frais_anex_7[lCpt]), 	&  
															 Dec(ids_charger.object.frais_anex_8[lCpt]), 	&  
															 Dec(ids_charger.object.frais_anex_9[lCpt]), 	&  
															 Dec(ids_charger.object.frais_anex_10[lCpt]), 	& 
															 Dec(ids_charger.object.frais_anex_11[lCpt]), 	& 																 
								/* [PM336-1] */		 sChaine,													&															 
															 sTraite )
			
														 
		ElseIf iIdTypFact = K_TYPFACT_PRESTA_NORM_SANS_REGL Then
				// [DT044-1_V5]
				lIdSeq = long ( ids_charger.object.id_seq[lCpt] )

				// [PM80_FA12_FRANEX] libérer u_transaction à la désac de clé
				lRet = sqlca.PS_U_DETAIL_MAJ_FACTU_SANS_REGL_DT44_V02 (long(ids_charger.object.id_sin[lCpt]),	&
															 integer(ids_charger.object.id_seq[lCpt]),		&
															 datetime(ids_charger.object.dte_fact[lCpt]),	&
															 string(ids_charger.object.num_facture[lCpt]),	&
															 Real(ids_charger.object.mte_fact[lCpt]),			&
															 string(ids_charger.object.cat_fact[lCpt]), 		&
															 Dec(ids_charger.object.indem_princ_1[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_2[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_3[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_4[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_5[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_6[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_7[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_8[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_9[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_10[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_11[lCpt]), 	&
								/* [PM336-1] */		 sChaine,													&															 
															 sTraite )
														 

		ElseIf iIdTypFact = K_TYPFACT_DIAG_O2M Then
				// [PM210]
				lIdSeq = long ( ids_charger.object.id_seq[lCpt] )
				
				// [PM80_FA12_FRANEX] libérer u_transaction à la désac de clé
		
				lRet = sqlca.PS_U_DETAIL_MAJ_FACTU_DIAG_O2M_V02 (long(ids_charger.object.id_sin[lCpt]),	&
															 integer(ids_charger.object.id_seq[lCpt]),		&
															 datetime(ids_charger.object.dte_fact[lCpt]),	&
															 string(ids_charger.object.num_facture[lCpt]),	&
															 Real(ids_charger.object.mte_fact[lCpt]),			&
															 string(ids_charger.object.cat_fact[lCpt]), 		&
															 Dec(ids_charger.object.indem_princ_1[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_2[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_3[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_4[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_5[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_6[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_7[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_8[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_9[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_10[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_11[lCpt]), 	&
								/* [PM336-1] */		 sChaine,													&															 															 
															 sTraite )

		ElseIf iIdTypFact = K_TYPFACT_BNP_SECU Then
				// [PC13174]
				// [PM80_FA12_FRANEX] libérer u_transaction à la désac de clé
		
				lRet = sqlca.PS_U_DETAIL_MAJ_FACTU_BNP_SECU_V03 (long(ids_charger.object.id_prod[lCpt]),	&
															 long(ids_charger.object.id_ets[lCpt]),	&
															 string(ids_charger.object.id_adh[lCpt]),	&
															 string(ids_charger.object.id_fourn[lCpt]),		&
															 datetime(ids_charger.object.dte_fact[lCpt]),	&
															 string(ids_charger.object.num_facture[lCpt]),	&
															 Real(ids_charger.object.mte_fact[lCpt]),			&
															 string(ids_charger.object.cat_fact[lCpt]), 		&
															 Dec(ids_charger.object.indem_princ_1[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_2[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_3[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_4[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_5[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_6[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_7[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_8[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_9[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_10[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_11[lCpt]), 	&
								/* [PM336-1] */		 sChaine,													&															 															 
															 sTraite )

		Else
			// #1

		
			choose case sFournisseur
				case "DT1", "DT2", "DT3", "DT4", "DT5", "DT6", "DT7", "DT8","DT9", "DT0", &
				"DTA","DTB","DTC","DTD","DTE","DTF","DTG","DTH","DTI","DTJ","DTK","DTL", &
				"DTM","DTN","DTO","DTP","DTQ","DTR","DTS","DTT","DTU","DTV","DTW","DTX","DTY","DTZ", &
				"DU0","DU1","DU2","DU3","DU4","DU5","DU6","DU7","DU8","DU9", &
				"DUA","DUB","DUC","DUE","DUF","DUG","DUH","DUI","DUJ","DUK","DUL","DUM","DUN","DUO", &
				"DUP","DUQ","DUR","DUS","DUT","DUU","DUV","DUW","DUX","DUY","DUZ", &
				"DV0","DV1","DV2","DV3","DV4","DV5","DV6","DV7","DV8","DV9","DVA","DVB","DVC","DVE","DVF", &
				"DVG","DVH","DVI","DVJ","DVK","DVL","DVM","DVN","DVO","DVP","DVQ","DVR","DVS","DVT","DVU","DVV", "DVW","DVX","DVY","DVZ"
					
					// [PM251-2]
					If bEligiblePM251T2 Then
						// [PM80_FA12_FRANEX] libérer u_transaction à la désac de clé

						lRet = sqlca.PS_U04_DETAIL_MAJ_FACTU_V03 (long(ids_charger.object.id_sin[lCpt]),	&
																 string(ids_charger.object.id_fourn[lCpt]),		&
																 datetime(ids_charger.object.dte_fact[lCpt]),	&
																 string(ids_charger.object.num_facture[lCpt]),	&
																 Real(ids_charger.object.mte_fact[lCpt]),			&
									/* #2 [DCMP080166]*/	 string(ids_charger.object.cat_fact[lCpt]), 		&
																 Dec(ids_charger.object.indem_princ_1[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_2[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_3[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_4[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_5[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_6[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_7[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_8[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_9[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_10[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_11[lCpt]), 	&
									/* [PM336-1] */		 sChaine,													&									
																 sTraite, &
																 lIdSeq )
																	 
						
					Else
					
					/* N'est plus utilisé, à supprimer plus tard.
						lRet = sqlca.PS_U04_DETAIL_MAJ_FACTU (long(ids_charger.object.id_sin[lCpt]),	&
																 string(ids_charger.object.id_fourn[lCpt]),		&
																 datetime(ids_charger.object.dte_fact[lCpt]),	&
																 string(ids_charger.object.num_facture[lCpt]),	&
																 Real(ids_charger.object.mte_fact[lCpt]),			&
									/* #2 [DCMP080166]*/	 string(ids_charger.object.cat_fact[lCpt]), 		&
																 sTraite )
					*/																 
					End If
															
				case "FNC"  // #4 [FNAC_PROD_ECH_TECH]



					sLstArt1 = Left ( ids_charger.object.lst_article[lCpt], 255 )
					sLstArt2 = Mid  ( ids_charger.object.lst_article[lCpt], 256, 255 )
					sLstArt3 = Mid  ( ids_charger.object.lst_article[lCpt], 511, 255 )
					
					If IsNull ( sLstArt1 ) Then sLstArt1 = ""
					If IsNull ( sLstArt2 ) Then sLstArt2 = ""
					If IsNull ( sLstArt3 ) Then sLstArt3 = ""

					lIdSeq = long ( ids_charger.object.id_seq[lCpt] )

					// [PM80_FA12_FRANEX] libérer u_transaction à la désac de clé
					
					lRet = sqlca.PS_U06_DETAIL_MAJ_FACTU_V02 (long(ids_charger.object.id_sin[lCpt]),	&
															 long(ids_charger.object.id_seq[lCpt] ),			&
															 datetime(ids_charger.object.dte_fact[lCpt]),	&
															 string(ids_charger.object.num_facture[lCpt]),	&
															 Real(ids_charger.object.mte_fact[lCpt]),			&
								/* #2 [DCMP080166]*/	 string(ids_charger.object.cat_fact[lCpt]), 		&
															 string(ids_charger.object.soc_cptable[lCpt]),	&
															 string(ids_charger.object.mag_rempl[lCpt]),		&
															 string(ids_charger.object.heu_ticket[lCpt]),	&
															 string(ids_charger.object.caisse[lCpt]),			&
															 string(ids_charger.object.hote[lCpt]),			&
															 string(ids_charger.object.ticket[lCpt]),			&
															 Real(ids_charger.object.mt_ticket[lCpt]),		&
															 string(ids_charger.object.lst_fact[lCpt]),		&
															 sLstArt1,	&
															 sLstArt2,	&
															 sLstArt3,	&
															 Dec(ids_charger.object.indem_princ_1[lCpt]), 			&
															 Dec(ids_charger.object.frais_anex_2[lCpt]), 			& 
															 Dec(ids_charger.object.frais_anex_3[lCpt]), 			&  
															 Dec(ids_charger.object.frais_anex_4[lCpt]), 			&  
															 Dec(ids_charger.object.frais_anex_5[lCpt]), 			&  
															 Dec(ids_charger.object.frais_anex_6[lCpt]), 			&  
															 Dec(ids_charger.object.frais_anex_7[lCpt]), 			&  
															 Dec(ids_charger.object.frais_anex_8[lCpt]), 			&  
															 Dec(ids_charger.object.frais_anex_9[lCpt]), 			&  
															 Dec(ids_charger.object.frais_anex_10[lCpt]), 			& 
															 Dec(ids_charger.object.frais_anex_11[lCpt]), 			&
								/* [PM336-1] */		 sChaine,													&
															 sTraite )

				// [PC151259]
				// [PM363-1]
				Case "CDS", &
					  "SR1", &
					  "CEG", &
					  "O2M", &
					  "OSC", &
					  "TOI", &
					  "TL1", &
					  "A4E", "A4F", "A4G", "A4H", "A4I", "A4J", "A4K", "A4L", "A4M", "A4N", "A4O", "A4P",&
					  "A4Q", "A4R", "A4S", "A4T", "A4U", "A4V", "A4W", "A4X", "A4Y", "A4Z", "A5A", "A5B", "A5C", "A5D",&
					  "A5E", "A5F", "A5G", "A5H", "A5I", "A5J", "A5K", "A5L", "A5M", "A5N", "A5O", "A5P", "A5Q", "A5R",&
					  "A5S", "A5T", "A5U", "A5V", "A5W", "A5X", "A5Y", "A5Z", "A6A", "A6B", "A6C", "A6D", "A6E", "A6F",&
					  "A6G", "A6H", "A6I", "A6J", "A6K", "A6L", "A6M", "A6N", "A6O", "A6P", "A6Q", "A6R", "A6S", "A6T",&
					  "A6U", "A6V", "A6W", "A6X", "A6Y", "A6Z", "A7A", "A7B", "A7C", "A7D", "A7E", "A7F", "A7G", "A7H",&
					  "A7I", "A7J", "A7K", "A7L", "A7M", "A7N", "A7O", "A7P", "A7Q", "A7R", "A7S", "A7T", "A7U", "A7V",&
					  "A7W", "A7X", "A7Y", "A7Z", "A80", "A81", "A82", "A83", "A84", "A85", "A86", "A87", "A88", "A89",&
					  "A90", "A91", "A92", "A93", "A94", "A95", "A96", "A97", "A98",&
					  "NE1", "NE2", "NE3", "NE4", "NE5", "NE6", "NE7", "BLP", "BLQ"
					// [FACTU_SRR]
					// [FACTU_VIP_CDS]
					// Nouveau générique pour Méthode en en spécifiant le fournisseur à règler
					// [DT227]
					lIdSeq = long ( ids_charger.object.id_seq[lCpt] )						

					// [PM80_FA12_FRANEX] libérer u_transaction à la désac de clé
					
					lRet = sqlca.PS_U031_DETAIL_MAJ_FACTU_V02 (long(ids_charger.object.id_sin[lCpt]),	&
														 integer(ids_charger.object.id_seq[lCpt]),		&
														 string(ids_charger.object.id_fourn[lCpt]),		&															 
														 datetime(ids_charger.object.dte_fact[lCpt]),	&
														 string(ids_charger.object.num_facture[lCpt]),	&
														 Real(ids_charger.object.mte_fact[lCpt]),			&
							/* #2 [DCMP080166]*/	 string(ids_charger.object.cat_fact[lCpt]), 		&
														 Dec(ids_charger.object.indem_princ_1[lCpt]),	&
														 Dec(ids_charger.object.frais_anex_2[lCpt]), 	& 
														 Dec(ids_charger.object.frais_anex_3[lCpt]), 	&  
														 Dec(ids_charger.object.frais_anex_4[lCpt]), 	&  
														 Dec(ids_charger.object.frais_anex_5[lCpt]), 	&  
														 Dec(ids_charger.object.frais_anex_6[lCpt]), 	&  
														 Dec(ids_charger.object.frais_anex_7[lCpt]), 	&  
														 Dec(ids_charger.object.frais_anex_8[lCpt]), 	&  
														 Dec(ids_charger.object.frais_anex_9[lCpt]), 	&  
														 Dec(ids_charger.object.frais_anex_10[lCpt]),	& 
														 Dec(ids_charger.object.frais_anex_11[lCpt]),	&								
							/* [PM336-1] */		 sChaine,													&							
														 sTraite )						
															 
					
				Case "999"  // lié à SCR
					// [VDOC14649]
					// [PM80_FA12_FRANEX] libérer u_transaction à la désac de clé

					lRet = sqlca.PS_U032_DETAIL_MAJ_FACTU_V02 (long(ids_charger.object.id_sin[lCpt]),	&
															 "999_SCR" , &
															 string(ids_charger.object.id_fourn[lCpt]),		&		
															 datetime(ids_charger.object.dte_fact[lCpt]),	&
															 string(ids_charger.object.num_facture[lCpt]),	&
															 Real(ids_charger.object.mte_fact[lCpt]),			&
								/* #2 [DCMP080166]*/	 string(ids_charger.object.cat_fact[lCpt]), 		&
															 Dec(ids_charger.object.indem_princ_1[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_2[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_3[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_4[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_5[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_6[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_7[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_8[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_9[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_10[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_11[lCpt]), 	&
								/* [PM336-1] */		 sChaine,													&								
															 sTraite, &
															 lIdSeq )
	

				// [PC151259-2]
				case "ADV"

					// [PM80_FA12_FRANEX] libérer u_transaction à la désac de clé
					lRet = sqlca.PS_U10_DETAIL_MAJ_FACTU_ADVISE_V01 (long(ids_charger.object.id_sin[lCpt]),	&
																 string(ids_charger.object.id_fourn[lCpt]),		&
																 datetime(ids_charger.object.dte_fact[lCpt]),	&
																 string(ids_charger.object.num_facture[lCpt]),	&
																 Real(ids_charger.object.mte_fact[lCpt]),			&
																 string(ids_charger.object.cat_fact[lCpt]), 		&
																 Dec(ids_charger.object.indem_princ_1[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_2[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_3[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_4[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_5[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_6[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_7[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_8[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_9[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_10[lCpt]), 	&
																 Dec(ids_charger.object.frais_anex_11[lCpt]), 	&
																 sChaine,													&									
																 sTraite, &
																 lIdSeq )
				
				case else
					lIdSeq = long ( ids_charger.object.id_seq[lCpt] )					

					// [PM80_FA12_FRANEX] libérer u_transaction à la désac de clé
				
					lRet = sqlca.PS_U03_DETAIL_MAJ_FACTU_V02 (long(ids_charger.object.id_sin[lCpt]),	&
															 integer(ids_charger.object.id_seq[lCpt]),		&
															 datetime(ids_charger.object.dte_fact[lCpt]),	&
															 string(ids_charger.object.num_facture[lCpt]),	&
															 Real(ids_charger.object.mte_fact[lCpt]),			&
								/* #2 [DCMP080166]*/	 string(ids_charger.object.cat_fact[lCpt]), 		&
															 Dec(ids_charger.object.indem_princ_1[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_2[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_3[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_4[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_5[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_6[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_7[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_8[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_9[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_10[lCpt]), 	&
															 Dec(ids_charger.object.frais_anex_11[lCpt]), 	&
								/* [PM336-1] */		 sChaine,													&
															 sTraite )
															 
															 
			end choose
			// FIN - #1
		End If
		
		bRet = ( SQLCA.sqlcode = 0 And SQLCA.sqlDBcode = 0  And lRet = 0 )


		if bRet then 
			F_Commit ( SQLCA, True )

			// [BUG_PM251-2]
			If sTraite = "O" Then
				lNbTraite++									
			End If

			dw_visu_trt.SetItem ( 1, "MAJ_DETAIL", String ( lNbTraite ) + "/" +  String ( lTot ) + "   " + String ( Round ( ( lNbTraite / lTot ) * 100,0 ) ) + "%")		
			hpb_trt.Position++
			wf_pct()
			Yield()

			
			// [BUG_PM251-2]
			If sTraite <> "O" Then
				dw_charger.SetItem ( lCpt, "RESULT", "ERREUR : Erreur sur le nombre de détail à traiter (cause absence de détail ou détail déjà réglé précédemment)." ) 
				Continue
			End If
			
		else
			exit
		End If


//If stGlb.sCodOper = "CBA" Then bEligiblePM251T2 = FALSE
		
		// [PM251-2]
		If bEligiblePM251T2 Then
			If bRet Then

				// Préparation du dossier à la validation finale, simule la saisie, les Ctrl/Valide
				If Len ( Trim ( sResult ) ) > 0 Then sResult += "."
				
				sResultSav = Trim ( sResult )
				sResult = Space ( 500 )

			
				lRet = SQLCA.PS_U_PREPA_VAL_AUTO_PM251_V01 ( &
							long ( ids_charger.object.id_sin[lCpt] ), & 
							lIdSeq, &
							stGlb.sCodOper, &
							sChaine, /* [PM336-1] */ &
							dcIdProd, &
			 			   sResult )

			
				If IsNull ( sResult ) Then sResult = ""
				sResult = sResultSav + Trim ( sResult )
				
				dw_charger.SetItem ( lCpt, "RESULT", Trim ( sResult ) ) 
				
				bRollbackContinue = lRet = -100
				If bRollbackContinue Then lRet = 0
				
				bRet = ( SQLCA.sqlcode = 0 And SQLCA.sqlDBcode = 0  And lRet = 0 )
							 
				If bRet Then
					If bRollbackContinue Then
						bRollbackContinue = False
						F_Commit ( SQLCA, False)
						Continue
					Else
						F_Commit ( SQLCA, True )
					End If
				Else
					dw_charger.SetItem ( lCpt, "RESULT", "ERREUR SQL " + String ( lRet ) + " sur PS_U_PREPA_VAL_AUTO_PM251 : " + SQLCA.SqlErrText ) 
					F_Commit ( SQLCA, False)
					Continue
				End If
			End If
			
			If bRet Then

				sResultSav = Trim ( sResult )
				sResult = Space ( 500 )

				bRet = This.wf_pm251_2_validation_auto ( &
							long ( ids_charger.object.id_sin[lCpt] ), & 
							dcIdProd, &
							sResult ) 

				If IsNull ( sResult ) Then sResult = ""
				sResult = sResultSav + Trim ( sResult )

				dw_charger.SetItem ( lCpt, "RESULT", Trim ( sResult ) ) 				
				
				bRet = ( SQLCA.sqlcode = 0 And SQLCA.sqlDBcode = 0 And bRet )

				If bRet Then
					
					// [BUG_REGL_FACT_DBL_RG]
					lCtrlValide = SQLCA.PS_S_CONTROLE_DBLT_REGLT ( long ( ids_charger.object.id_sin[lCpt] ) )
					
					IF lCtrlValide <= 0 Then
						dw_charger.SetItem ( lCpt, "RESULT", "ERREUR : Problème technique lors de la validation(1). A repasser par l'automate jusqu'à ce que ce réglement passe." )						
						F_Commit ( SQLCA, False)
						Continue
					End If
					
					F_Commit ( SQLCA, True )
					
					// ITSM456299
					lCtrlValide = SQLCA.PS_S_CONTROLE_VALIDATION ( long ( ids_charger.object.id_sin[lCpt] ) )
					F_Commit ( SQLCA, True )
					
					If  lCtrlValide < 0 Then
						dw_charger.SetItem ( lCpt, "RESULT", "ERREUR : Problème technique lors de la validation(2). A repasser par l'automate jusqu'à ce que ce réglement passe." )
					Else
						// [PM336-1]
						If lnvPFCString.of_Getkeyvalue ( sChaine, "A_FORCER", ";") = "OUI" Then
							dw_charger.SetItem ( lCpt, "RESULT", "Validation => Ok (forcée)" )
						Else
							dw_charger.SetItem ( lCpt, "RESULT", "Validation => Ok" )
						End If
	
						lNbValide ++
						dw_visu_trt.SetItem ( 1, "DOS_VALIDE", String ( lNbValide ) + "/" +  String ( lTot ) + "   " + String ( Round ( ( lNbValide / lTot ) * 100 ,0 ) ) + "%")		
					End If 
				Else
					dw_charger.SetItem ( lCpt, "RESULT", "ERREUR SQL " + String ( lRet ) + " sur wf_pm251_2_validation_auto : " + SQLCA.SqlErrText ) 
					F_Commit ( SQLCA, False)
					Continue
				End If
			
			End If 
			
		
			If bRet Then
				lRet = SQLCA.PS_U_MAJ_CONTACT_PM251 ( long ( ids_charger.object.id_sin[lCpt] ) )
			
				bRet = ( SQLCA.sqlcode = 0 And SQLCA.sqlDBcode = 0  And lRet = 0 )
				
				If bRet Then
					F_Commit ( SQLCA, True )
				Else
					dw_charger.SetItem ( lCpt, "RESULT", "ERREUR SQL " + String ( lRet ) + " sur PS_U_MAJ_CONTACT_PM251 : " + SQLCA.SqlErrText ) 
					F_Commit ( SQLCA, False)
					Continue
				End If
				
			End IF 
			
		End If
		
		// [PI087_PM473_2]
		// Gestion de la trace ici. Si problème, je n'affecte pas la validation, c'est déjà commité et je ne touche pas au bRet
		If bRet Then
		
			lRet2 = SQLCA.PS_I_PI087_TRACE_DOSSIER_V01 ( long ( ids_charger.object.id_sin[lCpt] ), "VALIDATION", stGLB.sCodOper, dcIdInter, dcIdDoc )

			bRet2 = SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0 And lRet2 > 0
			
			F_Commit ( SQLCA, bRet2 ) 
		
		End If		
		
	Next

	If bRet And dw_Charger.Find ( "Left ( RESULT, 6 ) = 'ERREUR'", 1, dw_Charger.RowCount () ) <= 0 Then
		st_extraire.BackColor = 32768
		st_extraire.TextColor = 16777215
		st_extraire.Text = "Mise à jour passée avec succés sur toutes les lignes"
	ElseIf Not bRet Then
		st_extraire.BackColor = 255
		st_extraire.TextColor = 16777215	
		st_extraire.Text = "Erreur technique importante lors de la mise des tables de temporaire (W)"		
	Else 
		st_extraire.BackColor = 255
		st_extraire.TextColor = 16777215	
		st_extraire.Text = "Des erreurs ont été détectées dans la mise à jour, consultez les résultats de chaque prestation"		
	End If 

	dw_visu_trt.SetItem ( 1, "DTE_FIN", DateTime ( Today (), Now () ) )

	If Not bRet Then
		stMessage.Icon		= Exclamation!
		stMessage.sCode	= "SFRP100"
		stMessage.sVar[1] 	= String ( SQLCA.SqlDbCode )
		stMessage.sVar[2] 	= SQLCA.SqlErrText
		F_Commit ( SQLCA, False )
		cb_result.Enabled = TRUE
	Else
		stMessage.Icon		= Information!
		cb_result.Enabled = TRUE
		
		// [PM251-2]
		If bEligiblePM251T2 Then		
			stMessage.sCode	= "COMD888"
			stMessage.sVar[1]	= String ( lTot)
			stMessage.sVar[2]	= String ( lNbTraite )
			stMessage.sVar[3]	= String ( lNbValide )
		Else
			stMessage.sCode	= "COMD430"
			stMessage.sVar[1]	= String ( lNbTraite )
		End If
	End If

	// [PM251-2]
	If bEligiblePM251T2 Then
		stMessage.sTitre		= "Résultat du traitement"		
	Else
		stMessage.sTitre		= "Mise à jour des détail avec les données de facturation."
	End If
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!

	F_Message ( stMessage )

	// [PM251-2]
	If bEligiblePM251T2 Then
		cb_result.Event Clicked ()
	End If

End If


 

Return bRet
end function

private function integer wf_chargerdw ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_autofact::wf_ChargerDw (PRIVATE)
//* Auteur        : JCA
//* Date          : 22/02/2007
//* Libellé       : Chargement du data object correspond au fournisseur choisit
//* Commentaires  : DCMP 070110 - Ajout du fournisseur Darty
//*
//* Arguments     : 
//*
//* Retourne      :	0	ok
//*						-1	nok
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	PHG	13/06/2008	[DCMP080461] Intégration FActuration Hors PRestation
//* #2	PHG	10/04/2009	[FNAC_PROD_ECH_TECH] Fnac Attitude
//*    	JFF	09/01/2013	[VDOC9586]
//       JFF   07/10/2013  [DT044-1_V5]
//       JFF   05/11/2013  [PM210]
//       JFF   22/10/2014  [FACTU_VIP_CDS]
//		FPI	29/10/2014	[PC13174]
// 		FPI	30/01/2015	[FACTU_SRR]
// 		JFF	12/03/2015  [VDOC14649]
//       JFF   09/04/2015 [DT141]
//       JFF   11/04/2016 [PM336-1]
//       JFF   07/06/2016 [DT227]
//       JFF   07/11/2016 [PC151259]
//       JFF   29/05/2017 [PC151259-2]
//			JFF   08/08/2017 [DT288] Facturation ORANGCE SCF (Cordon)
//       JFF   09/09/2022 [PM80_FA12_FRANEX]
//*-----------------------------------------------------------------

string sFournisseur
integer iIdTypFact // [DCMP080461]

sFournisseur 	= dw_Fourn.object.id_fourn[1]
iIdTypFact		= dw_Fourn.object.id_typ_fact[1] // [DCMP080461]

ids_charger 	= create datastore

Choose Case iIdTypFact   // [DCMP080461] Choix du type de Facturation
		 // [DCMP080461] Facturation de Prestation
		 // [DT044-1_V5]
		 // [PM210]
		 // [FACTU_VIP_CDS]
	Case K_TYPFACT_PRESTA, &
		  K_TYPFACT_PRESTA_NORM_SANS_REGL, &
		  K_TYPFACT_DIAG_O2M
		  
		// [PC151259-2] ADV
		Choose case sFournisseur
			case "ADV", &
				"DT1", "DT2", "DT3", "DT4", "DT5", "DT6", "DT7", "DT8","DT9", "DT0", &
				"DTA","DTB","DTC","DTD","DTE","DTF","DTG","DTH","DTI","DTJ","DTK","DTL", &
				"DTM","DTN","DTO","DTP","DTQ","DTR","DTS","DTT","DTU","DTV","DTW","DTX","DTY","DTZ", &
				"DU0","DU1","DU2","DU3","DU4","DU5","DU6","DU7","DU8","DU9", &
				"DUA","DUB","DUC","DUE","DUF","DUG","DUH","DUI","DUJ","DUK","DUL","DUM","DUN","DUO", &
				"DUP","DUQ","DUR","DUS","DUT","DUU","DUV","DUW","DUX","DUY","DUZ", &
				"DV0","DV1","DV2","DV3","DV4","DV5","DV6","DV7","DV8","DV9","DVA","DVB","DVC","DVE","DVF", &
				"DVG","DVH","DVI","DVJ","DVK","DVL","DVM","DVN","DVO","DVP","DVQ","DVR","DVS","DVT","DVU","DVV", &
				"DVW","DVX","DVY","DVZ"
				
				
				// [PM80_FA12_FRANEX]
				dw_charger.dataobject  = 'd_trt_charge_autofact_dty_3'
				ids_charger.dataobject = 'd_stk_autofact_dty_3'
				
			case "FNC" // #2 [FNAC_PROD_ECH_TECH]

				// [PM80_FA12_FRANEX]
				// [PM336-1]
				dw_charger.dataobject  = 'd_trt_charge_autofact_fnac_3'
				ids_charger.dataobject = 'd_stk_autofact_fnac_3'
			
			// [DT227]
			// [PC151259]	
			// [PM363-1] O2M
			Case "CDS", &
				  "SR1", &
				  "999", &
				  "CEG", &
				  "O2M", &
				  "TL1", &
				  "OSC", &
				  "TOI", &
				  "A4E", "A4F", "A4G", "A4H", "A4I", "A4J", "A4K", "A4L", "A4M", "A4N", "A4O", "A4P",&
				  "A4Q", "A4R", "A4S", "A4T", "A4U", "A4V", "A4W", "A4X", "A4Y", "A4Z", "A5A", "A5B", "A5C", "A5D",&
				  "A5E", "A5F", "A5G", "A5H", "A5I", "A5J", "A5K", "A5L", "A5M", "A5N", "A5O", "A5P", "A5Q", "A5R",&
				  "A5S", "A5T", "A5U", "A5V", "A5W", "A5X", "A5Y", "A5Z", "A6A", "A6B", "A6C", "A6D", "A6E", "A6F",&
				  "A6G", "A6H", "A6I", "A6J", "A6K", "A6L", "A6M", "A6N", "A6O", "A6P", "A6Q", "A6R", "A6S", "A6T",&
				  "A6U", "A6V", "A6W", "A6X", "A6Y", "A6Z", "A7A", "A7B", "A7C", "A7D", "A7E", "A7F", "A7G", "A7H",&
				  "A7I", "A7J", "A7K", "A7L", "A7M", "A7N", "A7O", "A7P", "A7Q", "A7R", "A7S", "A7T", "A7U", "A7V",&
				  "A7W", "A7X", "A7Y", "A7Z", "A80", "A81", "A82", "A83", "A84", "A85", "A86", "A87", "A88", "A89",&
				  "A90", "A91", "A92", "A93", "A94", "A95", "A96", "A97", "A98",&
				  "NE1", "NE2", "NE3", "NE4", "NE5", "NE6", "NE7", "BLP", "BLQ"
				// [FACTU_SRR]
				// [FACTU_VIP_CDS]
				// Nouveau générique pour Méthode en spécifiant le fournisseur à règler
				// [VDOC14649]
				// [PM336-1]
				// [DT227]
			   // [DT141] 
				// [PM336-1]				

				// [PM80_FA12_FRANEX]
				dw_charger.dataobject  = 'd_trt_charge_autofactfrn_3'
				ids_charger.dataobject = 'd_stk_autofactfrn_3'
			
			case else
				
				// [PM80_FA12_FRANEX]
				dw_charger.dataobject  = 'd_trt_charge_autofact_3'
				ids_charger.dataobject = 'd_stk_autofact_3'
		End choose
	

	// [DT57_CMDE_IPHONE_SFR]
	// [DCMP080461] Facturation hors prestation. [VDOC9586]
	Case K_TYPFACT_H_PRESTA

		// [PM80_FA12_FRANEX]
		dw_charger.dataobject = 'd_trt_charge_autofact_hpresta_3A'
		ids_charger.dataobject = 'd_stk_autofact_hpresta_3A'
	
	// [DT57_CMDE_IPHONE_SFR]
	// [DCMP080461] Facturation hors prestation. [VDOC9586]
	Case K_TYPFACT_H_PRESTA_MAJ_1_DETAIL, &
		  K_TYPFACT_H_PRESTA_IPHONE_O2M_SFR 

		// [PM80_FA12_FRANEX]
		dw_charger.dataobject = 'd_trt_charge_autofact_hpresta_3B'
		ids_charger.dataobject = 'd_stk_autofact_hpresta_3B'
		
	// [PC13174]
	Case K_TYPFACT_BNP_SECU

		// [PM80_FA12_FRANEX]
		dw_charger.dataobject = 'd_trt_charge_autofact_axa_3'
		ids_charger.dataobject = 'd_stk_autofact_axa_3'
		
End Choose

return 0
end function

private function boolean wf_pm251_2_validation_auto (long adcidsin, long adcidprod, ref string asresult);//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_autofact::wf_pm251_2_validation_auto (PRIVATE)
//* Auteur        : 
//* Date          : 21/11/2006
//* Libellé       : 
//* Commentaires  : 
//*					  
//*
//* Arguments     : 
//*
//* Retourne      : Boolean	bRet
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
// 	  JFF 30/12/2014 [ITSM_260394]
//*-----------------------------------------------------------------

Boolean bRet

Long dcIdSin, lDeb, lFin, lRetValidation, lErrSql2627, lCpt, lSqlDbCode, lRet
String sProc, sCodOper, sFicEssai, sSql, sNoBoite, sMethode 
DateTime	dtValideLe
Boolean b2Tour
// #6
Decimal dcIdProd 
String sRet, sRep
n_cst_se_double_val nvDoubleVal
int iRet

sRep = ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE", "Erreur" )


// [ITSM63255]
For lCpt = 1 To 2

	dcIdSin		= adcIdSin
	sCodOper 	= stGLB.sCodOper
	sFicEssai	= sRep + stGLB.sCodOper + String ( Today (), "ddmm" ) + ".TMP"
	sProc			= Space ( 60 )
	dtValideLe	= DateTime ( Today (), Now () )
	bRet			= True
	lErrSql2627 = 0
	b2Tour 		= False
	
	sMethode = "SVE"
	
	// #6
	dcIdProd = adcIdProd
	
	nvDoubleVal=CREATE n_cst_se_double_val

	iRet=nvDoubleVal.uf_DoubleValidationOK(stGLB.sCodOper, dcIdSin, dcIdProd, &
						stglb.sfichierini, SQLCA, sRet)

	stmessage.svar[1] = sRet

	If iRet <> nvdoubleval.K_OK Then 

		Choose case iRet
		Case nvdoubleval.K_ERR_INITALISATION
			asResult+="ERREUR : Double validation du dossier=>Erreur d'initialisation." 
		Case nvdoubleval.K_ANNULE
			asResult+="ERREUR : Double validation du dossier=>Opération annulée."
		Case nvdoubleval.K_ERR_NIVEAU_REQUIS
			asResult+="ERREUR : Double validation du dossier=>Opération non autorisée, Ce dossier nécessite une double validation de " + stmessage.svar[1] + "."
		Case nvdoubleval.K_ERR_SAISIE
			asResult+="ERREUR : Double validation du dossier=>Erreur de saisie du trigramme/mot de passe."
		Case nvdoubleval.K_ERR_DROIT_INSUFFISANT
			asResult+="ERREUR : Double validation du dossier=>Vous n'avez pas les droits pour le niveau " + stmessage.svar[1] + "."
		Case nvdoubleval.K_ERR_OPER_INCONNU
			asResult+="ERREUR : Double validation du dossier=>Opérateur inexistant, Veuillez contacter l'équipe paramétrage EPG au 2245."
		Case nvdoubleval.K_ERR_LIRE_UO
			asResult+="ERREUR : Double validation du dossier=>Le code département (-DP,99) n'est pas paramétré sur le produit " + string(dcIdProd) + ".Veuillez contacter l'équipe paramétrageEPG au 2245."
		Case nvdoubleval.K_OK
			asResult+="ERREUR : Double validation du dossier=>Validation OK."
		Case nvdoubleval.K_ERR_LIRE_MONTANT
			asResult+="ERREUR : Double validation du dossier=>Erreur de détermination du montant du sinistre."
		Case nvdoubleval.K_ERR_HISTO
			asResult+="ERREUR : Double validation du dossier=>Erreur d'historisation de la double validation du dossier."
		Case Else
			asResult+="ERREUR : Double validation du dossier=>Opérateur inexistant, Veuillez contacter l'équipe paramétrage."
		end choose
	
		f_commit(SQLCA,False)
		bRet=FALSE
		
	End if
	
	DESTROY nvDoubleVal
	// Fin #6

	If Not bRet Then Return bRet 
	
	/*------------------------------------------------------------------*/
	/* Le 04/06/1999.                                                   */
	/* Modif DGA: On vérifie si l'on peut ecrire dans le répertoire de  */
	/* TRACE. Si ce n'est pas le cas, on arrete tout.                   */
	/*------------------------------------------------------------------*/
	If bRet Then 
		If	F_Verifier_Ecriture_Trace ( sFicEssai ) < 0	Then
		/*------------------------------------------------------------------*/
		/* On affiche un message d'erreur que l'on ne peut tracer. On sort  */
		/* ensuite immédiatement de la fonction.                            */
		/*------------------------------------------------------------------*/
			asResult += "ERREUR : L'écriture de la TRACE est impossible. Appeler le service informatique."		
			bRet = False
		
		End If
	End If

	If Not bRet Then Return bRet 	
	
	sNoBoite = "CENTRALISE"
	
	// #4
	//	If	IsNull ( sNoBoite ) Then sNoBoite = ''
	If Trim ( sNoBoite ) = "" Then SetNull ( sNoBoite ) // #4
	
	// #3
	lRetValidation = SQLCA.PS_VALIDATION	(	dcIdSin,				&
										sCodOper,			&
										sNoBoite,			&
										sProc,				&
										dtValideLe,			&
										sMethode 			&
									)

	lSqlDbCode = SQLCA.SqlDbCode
	
	// [ITSM_260394]
	If lSqlDbCode <> 0 Then
		lRetValidation = lSqlDbCode 
	End If
		
	// [CORRECTIF_VALIDATION]
	If lRetValidation < 0 Then bRet = FALSE
	
	/*------------------------------------------------------------------*/
	/* La zone sProc est passée par référence. Elle est armée à ''      */
	/* dans la procédure. Si une erreur survient, on arme cette chaîne  */
	/* pour expliquer ou est survenue l'erreur.                         */
	/*------------------------------------------------------------------*/
	sProc = Trim ( sProc )
	If	sProc <> "" Then bRet = False
	
	/*------------------------------------------------------------------*/
	/* Si SqlDbCode est armé, on part du principe qu'il y a eu une      */
	/* erreur, et ce quel que soit la valeur de sProc.                  */
	/*------------------------------------------------------------------*/
	If SQLCA.SqlCode <> 0 Or SQLCA.SqlDbCode <> 0	Then bRet = False
	
	
	/*------------------------------------------------------------------*/
	/* Delete des zones temporaires sur w_div_sin et div_sin            */
	/*------------------------------------------------------------------*/
	If bRet Then
		F_Execute ( "Exec sysadm.PS_D01_W_DIV_SIN " + String ( dcIdSin ) + "., 'zn_tmp_cas_gestion'", SQLCA )
		bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0
	End If
	
	If bRet Then
		// [PM103][1]
		F_Execute ( "Exec sysadm.PS_D01_W_DIV_SIN " + String ( dcIdSin ) + "., 'zn_tmp_PM103_1'", SQLCA )
		bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0
		// :[PM103][1]
	End If
	
	If bRet Then		
		// [VDOC12394]
		F_Execute ( "Exec sysadm.PS_D01_W_DIV_SIN " + String ( dcIdSin ) + "., 'ctl_sepa'", SQLCA )
		bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0
		// :[VDOC12394]
	End If

	// [VDOC12394]
	If bRet Then
		F_Execute ( "Exec sysadm.PS_I_DIV_SIN_ETAT_ASS " + String ( dcIdSin ) + "., '" + Trim ( sCodOper ) + "'", SQLCA )
		bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0
	End If 
	// [VDOC12394]
	
	// Gestion des erreurs
	If	Not bRet	Then
		//#3
		Choose Case lRetValidation 
			Case -1000 
				asResult += "ERREUR : Problème lors de la validation, passez en validation manuelle"
				// [VDOC4288]
				F_Commit ( SQLCA, False )


			// [VDOC5021]
			Case -1001 

				asResult += "ERREUR : Problème lors de la validation, passez en validation manuelle"
				F_Commit ( SQLCA, False )
				
				F_Execute ( "Exec sysadm.PS_U_REDRESSEMENT_CMDE_ANNUL " + String ( dcIdSin ) + ".", SQLCA )				
				F_Commit ( SQLCA, True)

			// [ITSM85146] IM_CUR_ARCHIVE_VAL_SVE / PS_I03_ARCHIVE_BLOB_VAL
			Case -1002
				If lCpt = 1 Then
					b2Tour = True
					F_Commit ( SQLCA, False )
					F_Execute ( "Update sysadm.w_courrier Set id_canal = 'CO' where id_sin = " + String ( dcIdSin ) + ".", SQLCA )				
					F_Commit ( SQLCA, True )
				End If

			Case Else

				// [ITSM63255] Erreur PrimayKey
				If lCpt = 1 And ( lRetValidation = 2627 Or SQLCA.SqlDbCode = 2627 ) Then
					lErrSql2627 = 2627
					F_Commit ( SQLCA, False )
					F_Execute ( "Exec sysadm.PS_CORRIGE_CPT_VALIDE " + String ( dcIdSin ) + ".", SQLCA )				
					F_Commit ( SQLCA, True )

					// [ITSM129947]
					F_Commit ( SQLCA, False )
					F_Execute ( "Delete from sysadm.wkfs_w_queue where id_sin= " + String ( dcIdSin ) + ".", SQLCA )				
					F_Commit ( SQLCA, True )
					
				Else
					asResult += "ERREUR : Processus : " + sProc + ", Erreur SQL : " + String ( SQLCA.SqlDbCode ) + ", Msg Erreur : " + SQLCA.SqlErrText
										
					/*------------------------------------------------------------------*/
					/* On peut envoyer le ROLLBACK.                                     */
					/*------------------------------------------------------------------*/
					F_Commit ( SQLCA, False )

				End If
		End Choose
	End If

// [ITSM63255]
If lErrSql2627 > 0 Then b2Tour = True
If Not b2Tour Then Exit

Next

return bRet
end function

private function boolean wf_controler ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_autofact::wf_Controler (PRIVATE)
//* Auteur        : PHG, d'après JFF ( w_sp_trt_stat3 )
//* Date          : 21/11/2006
//* Libellé       : Contrôle des données
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     	Modification
//* #1	JCA		23/02/2007	DCMP 070110 - Ajout du fournisseur Darty
//* #2	PHG		17/03/2008	[DCMP080166] Ajout Champs 'Catégorie de Facture'
//* #3 	FPI		05/03/2009	Contrôle date de facture > today()
//* #4	PHG		10/04/2009  [FNAC_PROD_ECH_TECH] Fnac Attitude
//* #5	JFF		04/05/2009  [FNAC_PROD_ECH_TECH].20090504151852270 Fnac Attitude
//* #6	PHG		28/09/2009	[DCMP090483] Controle non nullité des champs 
//*									"heure du ticket - caisse - hôte - n° de ticket"				
//* #7   JFF      30/11/2009  [FNAC_BGE].[20091130112458810]
//* #8   JFF      03/12/2009  [FNAC_BGE].[20091203110556880]
//*      JFF      09/01/2013  [VDOC9586]
//       JFF   26/08/2013 [DT57_CMDE_IPHONE_SFR]
//       JFF   07/10/2013 [DT044-1_V5]
//       JFF   05/11/2013 [PM210]
//       JFF   22/10/2014 [FACTU_VIP_CDS]
//		FPI	29/10/2014	[PC13174] nouvelle méthode de factu
//		FPI	30/01/2015	[FACTU_SRR]
// 		JFF	12/03/2015  [VDOC14649]
//       JFF   09/04/2015 [DT141]
//		FPI	16/06/2015  [DT147] Nouveaux codes fournisseurs Darty
//       JFF   11/04/2016 [PM336-1]
//       JFF   07/06/2016 [DT227]
//       JFF   07/11/2016 [PC151259]
// 		JFF	08/12/2016 [VDOC22083]
//       JFF   27/12/2016 [DT227][V2]
//       JFF   13/01/2017 [PM363-1]
//       JFF   29/05/2017 [PC151259-2]
//			JFF   08/08/2017 [DT288] Facturation ORANGCE SCF (Cordon)
//       JFF   09/09/2022 [PM80_FA12_FRANEX]
//*-----------------------------------------------------------------
//*
//* [FNAC_PROD_ECH_TECH] Fnac Attitude : Note de développement :
//* On atteint la limite de ce qui est qualitativement gérable via choose case
//* pour les controle et enregistrement par fournisseur.
//*
//* Si jamais un autre fournisseur devait se greffer sur se processus, je propose
//* la réécriture de cette fenêtre via le principe suivant :
//* - Déport de wf_controler et wf_maj dans un objet d'intégration par fournisseur
//* basé sur l'architecture suivante :
//* n_cst_autofact_anc : Objet ancetre d'intégration, gérer le commun en tout les fournisseur
//*      +-> n_cst_autofact_<code fournisseur>, implémentant les controle spécifique
//*			 et la méthode d'enregistrement par fournisseur.
//* Le tout étant instancié à la volée, via un CREATE USING, par code fournisseur,
//* lors de la sélection de celui-ci dans la dddw.
//* Pierre-Henri Gillot, le 15/04/2009 
//*-----------------------------------------------------------------

Long		lTotRow, lCpt, lPos, lAutorisation 
Boolean	bOk, bError, bDroitForcage
String	sIdSinIdSeq, sDteFact, sNumFacture, sMteFact, sIdFourn, sIdFournFic, sErreur
String	sCatFact, sAForcer, sIdFourAG
Long 		lIdSinPrec, lLongueur // #8 [FNAC_BGE].[20091203110556880] 

Long	 	lIdSin
Integer 	iIdSeq
Integer  iIdTypFact //[DCMP080461]
boolean	bHpresta	  // #2 [DCMP080166]

string	sOk, sRetour, sDesc // [FNAC_PROD_ECH_TECH]
string	sChampSup[]  // #4 [FNAC_PROD_ECH_TECH] Tableau de champs supplémentaire, hors chmaps existant
string   sNull[]
n_cst_string	lnvString
string   sTbFraisAnex[], sTbFraisNull[]
Long     lTotTbFrais, lCptTbFrais
Decimal {2} dcSoMTbFrais

Long lIdProd, lIdEts
String sIdAdh
Boolean bBasculeFNC 

		


// Pour Fnac 
// sChampSup[1] : soc_cptable
// sChampSup[2] : mag_rempl
// sChampSup[3] : heu_ticket
// sChampSup[4] : caisse
// sChampSup[5] : hote
// sChampSup[6] : ticket
// sChampSup[7] : mt_ticket
// sChampSup[8] : lst_fact
// sChampSup[9] : lst_article

/* Frais annexe dcTbFraisAnex[]
     1	Indemnisation principale
     2	Diagnostic/Analyse/Expertise
     3	Irréparable
     4	Refus
     5	Frais de gestion/frais de dossier
     6	Logistique/transport/frais d'envoi
     7	[FRAIS_LIBRE_DISPO]
     8	[FRAIS_LIBRE_DISPO]
     9	[FRAIS_LIBRE_DISPO]
    10	[FRAIS_LIBRE_DISPO]
    11	[FRAIS_LIBRE_DISPO]
*/

bBasculeFNC = FALSE
bOk = True
sErreur = ''
bDroitForcage = FALSE

// [PM336-1]
SQLCA.ps_s01_autorisation (226, stGlb.sCodOper, -1, lAutorisation )	
bDroitForcage = lAutorisation > 0 

lTotRow = dw_Charger.RowCount ()
hpb_trt.MaxPosition = lTotRow
hpb_trt.Position = 0
wf_pct()
Yield()

sIdFourn = dw_Fourn.GetItemString ( 1, "ID_FOURN" )
iIdTypFact = dw_fourn.object.id_typ_fact[1]

Choose Case sIdFourn
	Case "LBE"
		Choose Case iIdTypFact 
			Case 5
				// Ok
			Case Else
				bOk = False
		End Choose				
End Choose						

if not bok then sErreur += "Traitement n°" + String ( iIdTypFact ) + " non autorisé sur le fournisseur " + sIdFourn

// Traitement 5 interdit le Vendredi pour un problème de bordereau GenVir.
If iIdTypFact = 5 And DayNumber ( ToDay() ) = 6 Then
	bOk = False
	if not bok then sErreur += "Traitement n°" + String ( iIdTypFact ) + " interdit le Vendredi."
End If
	
// [VDOC9586]
// [DCMP080461] K_TYPFACT_H_PRESTA_MAJ_1_DETAIL
// [DT57_CMDE_IPHONE_SFR] K_TYPFACT_H_PRESTA_IPHONE_O2M_SFR 
// [PC13174] K_TYPFACT_BNP_SECU
bHpresta =( iIdTypFact = k_typfact_h_presta Or &
				iIdTypFact = K_TYPFACT_H_PRESTA_MAJ_1_DETAIL Or &
				iIdTypFact = K_TYPFACT_H_PRESTA_IPHONE_O2M_SFR /* Or & 
				iIdTypFact = K_TYPFACT_BNP_SECU*/ )

// On vide le datastore de traitement.
ids_Charger.reset()

SetPointer(HourGlass!)

For lCpt = 1 to lTotRow
	
	if bHpresta Then // [DCMP080461]
		// Chargement dans les variables de controle
/*
		If iIdTypFact = K_TYPFACT_BNP_SECU Then // [PC13174]
			lIdProd = long( dw_charger.object.id_prod[lCpt] )
			lIdEts = long( dw_charger.object.id_ets[lCpt] )
			sIdAdh= dw_charger.object.id_adh[lCpt]
		Else */
			lIdSin	= long( dw_charger.object.id_sin[lCpt] )
/*		End if */
		
		sDteFact		= dw_charger.object.dte_fact[lCpt]
		sNumFacture	= dw_charger.object.num_facture[lCpt]
		sMteFact		= dw_charger.object.mte_fact[lCpt]
		//on charge le fournisseur du fichier pour la ligne en cours
		sIdFournFic = dw_charger.object.id_fourn[lCpt]
		// #2	[DCMP080166] Catégorie de Facture
		sCatFact		= dw_charger.object.cat_fact[lCpt]

		// [PM336-1]
		sAForcer    = dw_charger.object.a_forcer [lCpt]

	Elseif iIdTypFact = K_TYPFACT_BNP_SECU Then
		lIdProd = long( dw_charger.object.id_prod[lCpt] )
		lIdEts = long( dw_charger.object.id_ets[lCpt] )
		sIdAdh= dw_charger.object.id_adh[lCpt]			
		sDteFact		= dw_charger.object.dte_fact[lCpt]
		sNumFacture	= dw_charger.object.num_facture[lCpt]
		sMteFact		= dw_charger.object.mte_fact[lCpt]
		//on charge le fournisseur du fichier pour la ligne en cours
		sIdFournFic = dw_charger.object.id_fourn[lCpt]
		// #2	[DCMP080166] Catégorie de Facture
		sCatFact		= dw_charger.object.cat_fact[lCpt]

		// [PM336-1]
		sAForcer    = dw_charger.object.a_forcer [lCpt]
		
	Else
		// #1
		choose case sIdFourn
				// [DT147] Nouveaux code fournisseurs Darty
				// [PC151259-2]
			case "ADV", &
				"DT1", "DT2", "DT3", "DT4", "DT5", "DT6", "DT7", "DT8","DT9", "DT0", &
				"DTA","DTB","DTC","DTD","DTE","DTF","DTG","DTH","DTI","DTJ","DTK","DTL", &
				"DTM","DTN","DTO","DTP","DTQ","DTR","DTS","DTT","DTU","DTV","DTW","DTX","DTY","DTZ", &
				"DU0","DU1","DU2","DU3","DU4","DU5","DU6","DU7","DU8","DU9", &
				"DUA","DUB","DUC","DUE","DUF","DUG","DUH","DUI","DUJ","DUK","DUL","DUM","DUN","DUO", &
				"DUP","DUQ","DUR","DUS","DUT","DUU","DUV","DUW","DUX","DUY","DUZ", &
				"DV0","DV1","DV2","DV3","DV4","DV5","DV6","DV7","DV8","DV9","DVA","DVB","DVC","DVE","DVF", &
				"DVG","DVH","DVI","DVJ","DVK","DVL","DVM","DVN","DVO","DVP","DVQ","DVR","DVS","DVT","DVU","DVV", "DVW","DVX","DVY","DVZ"
				// Chargement dans les variables de controle
				lIdSin	= long( dw_charger.object.id_sin[lCpt] )
				sDteFact		= dw_charger.object.dte_fact[lCpt]
				sNumFacture	= dw_charger.object.num_facture[lCpt]
				sMteFact		= dw_charger.object.mte_fact[lCpt]
				//on charge le fournisseur du fichier pour la ligne en cours
				sIdFournFic = dw_charger.object.id_fourn[lCpt]
				// #2	[DCMP080166] Catégorie de Facture
				sCatFact		= dw_charger.object.cat_fact[lCpt]

				// [PM336-1]
				sAForcer    = dw_charger.object.a_forcer [lCpt]
				
			// [DT227]
			// [PC151259]
			Case "CDS", &
				  "SR1", &
				  "CEG", &
				  "OSC", &
				  "TOI", &
				  "TL1", &
				  "A4E", "A4F", "A4G", "A4H", "A4I", "A4J", "A4K", "A4L", "A4M", "A4N", "A4O", "A4P",&
				  "A4Q", "A4R", "A4S", "A4T", "A4U", "A4V", "A4W", "A4X", "A4Y", "A4Z", "A5A", "A5B", "A5C", "A5D",&
				  "A5E", "A5F", "A5G", "A5H", "A5I", "A5J", "A5K", "A5L", "A5M", "A5N", "A5O", "A5P", "A5Q", "A5R",&
				  "A5S", "A5T", "A5U", "A5V", "A5W", "A5X", "A5Y", "A5Z", "A6A", "A6B", "A6C", "A6D", "A6E", "A6F",&
				  "A6G", "A6H", "A6I", "A6J", "A6K", "A6L", "A6M", "A6N", "A6O", "A6P", "A6Q", "A6R", "A6S", "A6T",&
				  "A6U", "A6V", "A6W", "A6X", "A6Y", "A6Z", "A7A", "A7B", "A7C", "A7D", "A7E", "A7F", "A7G", "A7H",&
				  "A7I", "A7J", "A7K", "A7L", "A7M", "A7N", "A7O", "A7P", "A7Q", "A7R", "A7S", "A7T", "A7U", "A7V",&
				  "A7W", "A7X", "A7Y", "A7Z", "A80", "A81", "A82", "A83", "A84", "A85", "A86", "A87", "A88", "A89",&
				  "A90", "A91", "A92", "A93", "A94", "A95", "A96", "A97", "A98",&
				  "NE1", "NE2", "NE3", "NE4", "NE5", "NE6", "NE7", "BLP", "BLQ"
				  
				// [FACTU_VIP_CDS]
				// [FACTU_SRR]
				// [DT227]
				// Nouveau générique pour Méthode en en spécifiant le fournisseur à règler
				// Chargement dans les variables de controle
				sIdSinIdSeq = dw_charger.object.id_sin_id_seq[lCpt]
				sDteFact		= dw_charger.object.dte_fact[lCpt]
				sNumFacture	= dw_charger.object.num_facture[lCpt]
				sMteFact		= dw_charger.object.mte_fact[lCpt]
				sIdFournFic = dw_charger.object.id_fourn[lCpt]  // La nouveauté
				sCatFact		= dw_charger.object.cat_fact[lCpt]
	
				// [PM336-1]
				sAForcer    = dw_charger.object.a_forcer [lCpt]

	
				// Controle Forme Id-Sin Id-Seq : Il doivent être numérique
				// Utilisation des codes retour des cast de Long et Integer
				// pour ce faire.
				
				lPos = Pos ( sIdSinIdSeq, '-' )
				lIdSin = Long(Left(sIdSinIdSeq, lPos - 1 ) )
				iIdSeq = Integer(Right(sIdSinIdSeq, len(sIdSinIdSeq)-lPos ) )
				bOk = (lIdSin<>0) and ( Not IsNull (lIdSin) ) and &
						(iIdSeq<>0) and ( Not IsNull (iIdSeq) ) 

		
			// [PM363-1] à migrer au dessus lors de la désact de la clé PM363-1
			Case "O2M"
				// [PM363-1]
				// [FACTU_VIP_CDS]
				// [FACTU_SRR]
				// [DT227]
				// Nouveau générique pour Méthode en en spécifiant le fournisseur à règler
				// Chargement dans les variables de controle
				sIdSinIdSeq = dw_charger.object.id_sin_id_seq[lCpt]
				sDteFact		= dw_charger.object.dte_fact[lCpt]
				sNumFacture	= dw_charger.object.num_facture[lCpt]
				sMteFact		= dw_charger.object.mte_fact[lCpt]
				sIdFournFic = dw_charger.object.id_fourn[lCpt]  // La nouveauté
				sCatFact		= dw_charger.object.cat_fact[lCpt]
	
				// [PM336-1]
				sAForcer    = dw_charger.object.a_forcer [lCpt]

	
				// Controle Forme Id-Sin Id-Seq : Il doivent être numérique
				// Utilisation des codes retour des cast de Long et Integer
				// pour ce faire.
				
				lPos = Pos ( sIdSinIdSeq, '-' )
				lIdSin = Long(Left(sIdSinIdSeq, lPos - 1 ) )
				iIdSeq = Integer(Right(sIdSinIdSeq, len(sIdSinIdSeq)-lPos ) )
				bOk = (lIdSin<>0) and ( Not IsNull (lIdSin) ) and &
						(iIdSeq<>0) and ( Not IsNull (iIdSeq) ) 

			Case "999" // lié SCR 
				// [VDOC14649]
				sIdSinIdSeq = dw_charger.object.id_sin_id_seq[lCpt]
				sDteFact		= dw_charger.object.dte_fact[lCpt]
				sNumFacture	= dw_charger.object.num_facture[lCpt]
				sMteFact		= dw_charger.object.mte_fact[lCpt]
				sIdFournFic = dw_charger.object.id_fourn[lCpt]  
				sCatFact		= dw_charger.object.cat_fact[lCpt]

				// [PM336-1]
				sAForcer    = dw_charger.object.a_forcer [lCpt]

				lPos = Pos ( sIdSinIdSeq, '-' )
				lIdSin = Long(Left(sIdSinIdSeq, lPos - 1 ) )
				
			case "FNC"// #4 [FNAC_PROD_ECH_TECH]
				//on charge le fournisseur du fichier pour la ligne en cours
				//Correspond à id_fourn
				sIdFournFic = dw_charger.object.id_fourn[lCpt]
				// Chargement dans les variables de controle
				sIdSinIdSeq = dw_charger.object.id_bon_ech[lCpt] 
				// On bourre a gauche sIdSinIdSeq avec des 0
				// #5	[FNAC_PROD_ECH_TECH].20090504151852270 surtout pas !
				// sIdSinIdSeq = right('00000000'+sIdSinIdSeq, 8)
				
				lIdSin = Long(Mid ( Trim ( sIdSinIdSeq), 5, 7 ))
				
				sDteFact		= dw_charger.object.dte_fact[lCpt]
				// formatage de la date de factu de jjmmaaaa en jj/mm/aaaa
				sDteFact = right('00000000'+sDteFact, 8)
				sDteFact = left(sDteFact,2)+"/"+mid(sDteFact,3,2)+"/"+right(sDteFact,4)

				sNumFacture	= dw_charger.object.num_facture[lCpt]
				sMteFact		= string(dw_charger.object.mte_fact[lCpt]) // Correspond à mt_fact
				// #2	[DCMP080166] Catégorie de Facture
				sCatFact		= dw_charger.object.cat_fact[lCpt]

				// [PM336-1]
				sAForcer    = dw_charger.object.a_forcer [lCpt]
				
				sChampSup[1] = dw_charger.object.soc_cptable[lCpt]	
				sChampSup[2] = dw_charger.object.mag_rempl[lCpt]	
				sChampSup[3] = string(dw_charger.object.heu_ticket[lCpt]/*, "hh:mm"*/)	

				sChampSup[4] = dw_charger.object.caisse[lCpt]	
				sChampSup[4] = right('0000'+sChampSup[4], 4)
				
				sChampSup[5] = dw_charger.object.hote[lCpt]	
				sChampSup[5] = right('000'+sChampSup[5], 3)
				
				sChampSup[6] = dw_charger.object.ticket[lCpt]	
				sChampSup[6] = right('0000'+sChampSup[6], 4)
				
				sChampSup[7] = string(dw_charger.object.mt_ticket[lCpt])	

				sChampSup[8] = dw_charger.object.lst_fact[lCpt]	
				//* #5 [FNAC_PROD_ECH_TECH].20090504151852270 Fnac Attitude
				sChampSup[8] = F_Remplace ( sChampSup[8], "", "[#]" )
				sChampSup[8] = F_Remplace ( sChampSup[8], '"', "p" )
				sChampSup[8] = F_Remplace ( sChampSup[8] , "'", "p" )
				sChampSup[8] = Trim ( sChampSup[8])

				sChampSup[9] = dw_charger.object.lst_article[lCpt]	
				//* #5 [FNAC_PROD_ECH_TECH].20090504151852270 Fnac Attitude
				sChampSup[9] = F_Remplace ( sChampSup[9], "", "[#]" )
				sChampSup[9] = F_Remplace ( sChampSup[9], '"', "p" )
				sChampSup[9] = F_Remplace ( sChampSup[9] , "'", "p" )

		case else
	
				// Chargement dans les variables de controle
				sIdSinIdSeq = dw_charger.object.id_sin_id_seq[lCpt]
				sDteFact		= dw_charger.object.dte_fact[lCpt]
				sNumFacture	= dw_charger.object.num_facture[lCpt]
				sMteFact		= dw_charger.object.mte_fact[lCpt]
				// #2	[DCMP080166] Catégorie de Facture
				sCatFact		= dw_charger.object.cat_fact[lCpt]
	
				// [PM336-1]
				sAForcer    = dw_charger.object.a_forcer [lCpt]
	
				// Controle Forme Id-Sin Id-Seq : Il doivent être numérique
				// Utilisation des codes retour des cast de Long et Integer
				// pour ce faire.
				
				lPos = Pos ( sIdSinIdSeq, '-' )
				lIdSin = Long(Left(sIdSinIdSeq, lPos - 1 ) )
				iIdSeq = Integer(Right(sIdSinIdSeq, len(sIdSinIdSeq)-lPos ) )
				bOk = (lIdSin<>0) and ( Not IsNull (lIdSin) ) and &
						(iIdSeq<>0) and ( Not IsNull (iIdSeq) ) 
		
				// Controle Code Fournisseur Sélectionné = Code Fournisseur de la commande
				sIdFournFic = Space(3) // Init de la chaine pour appel RPC.
				sqlca.PS_S07_COMMANDE(lIdSin,iIdSeq,sIdFournFic)
				bOk = ( sqlca.sqlcode = 0 )
				if Not bOk then sErreur += 'Erreur SQL : '+SQLCA.SQLErrText
		end choose
		// FIN - #1
	End If

	// [PM80_FA12_FRANEX]
	// Zones communes à tous les DO ci-dessus, donc un seul chargement commun
	sTbFraisAnex = sTbFraisNull
	sTbFraisAnex[1] =  dw_charger.object.indem_princ_1[lCpt]
	sTbFraisAnex[2] =  dw_charger.object.frais_anex_2 [lCpt]		
	sTbFraisAnex[3] =  dw_charger.object.frais_anex_3 [lCpt]		
	sTbFraisAnex[4] =  dw_charger.object.frais_anex_4 [lCpt]		
	sTbFraisAnex[5] =  dw_charger.object.frais_anex_5 [lCpt]		
	sTbFraisAnex[6] =  dw_charger.object.frais_anex_6 [lCpt]		
	sTbFraisAnex[7] =  dw_charger.object.frais_anex_7 [lCpt]		
	sTbFraisAnex[8] =  dw_charger.object.frais_anex_8 [lCpt]		
	sTbFraisAnex[9] =  dw_charger.object.frais_anex_9 [lCpt]		
	sTbFraisAnex[10] =  dw_charger.object.frais_anex_10 [lCpt]		
	sTbFraisAnex[11] =  dw_charger.object.frais_anex_11 [lCpt]		


	// *** Variables chargées en mémoire, controle des données
	// [PM336-1]
	if bOk Then 
		If Upper ( sAForcer ) = "A_FORCER" And Not bDroitForcage Then
			bOk = FALSE
		End If
		if not bok then sErreur += "Vous n'avez pas le droit de forcer ! "
	End If

	// [VDOC22083]
	If bOk Then
		// [DT227][V2]
		sIdFourAg = Space (3 )	
		
		If sIdFournFic = "FNC" Then
			bBasculeFNC = TRUE
			sIdFournFic = dw_charger.object.soc_cptable[lCpt]	
		End If
		
		If SQLCA.PS_CTRLE_ID_FOUR_FCT_V01 ( lIdSin, sIdFournFic, sIdFourAG ) < 0 Then
			bOk = False
			sErreur += "Le sinistre " + String (lIdSin) + " n'a aucun lien avec le fournisseur " + sIdFournFic + " !"
		End if 

		If bBasculeFNC Then
			bBasculeFNC = FALSE
			sIdFournFic = "FNC"
		End If

			// [DT227][V2]
		If bOk Then
			Choose Case sIdFourAG
				Case "CAL"
					bOk = dw_charger.Find ( "ID_FOURN = '" + upper(Trim(sIdFourn)) + "'" , 1, dw_charger.RowCount ()) > 0 
					if not bok then sErreur += "Code Fournisseur sélectionné absent du fichier !"
				Case Else
					bOk = ( upper(trim(sIdFournFic)) = upper(Trim(sIdFourn)) )
					if not bok then sErreur += "Code Fournisseur du Fichier, différent de celui sélectionné ! "
			
			End Choose 
		End If
	End If
		

	// Controle que dte fact est bien une date
	If bOk Then
		If IsNull ( sDteFact ) Then sDteFact = ""
		bOk = bOk And IsDate(sDteFact)
		if not bok then sErreur += "Date Facturation n'est pas une date ! "
	End If
	
	// #3 - Controle dte fact antérieure à aujourd'hui
	if bOK Then
		If IsNull ( sDteFact ) Then sDteFact = ""
		bOk = bOk And  (Date(sDteFact) <= today())
		if not bok then sErreur += "Date Facturation doit être inférieure ou égale à la date du jour ! "
	End if
	
	If bOk Then
		If IsNull ( sNumFacture ) Then sNumFacture = ""
		sNumFacture = Trim ( sNumFacture )
		bOk = bOk And sNumFacture <> ""
		if not bok then sErreur += "N° de facture obligatoire ! "
	End If
	
	// Controle que Num Facture est <= à 35 Caractère
	If bOk Then
		If IsNull ( sNumFacture ) Then sNumFacture = ""
		bOk = bOk And ( Len(sNumFacture) <= 35	)
		if not bok then sErreur += "N° de facture trop grand ! "
	End If

	// #2 [DCMP080166]
	// Controle que Catégorie de Facture est <= à 35 Caractère
	If bOk Then
		If IsNull ( sCatFact ) Then sCatFact = ""		
		bOk = bOk And ( Len(sCatFact) <= 35	)
		if not bok then sErreur += "Catégorie de facture trop grand ! "
	End If
	//

	// Controle que Montant Facture est bien un décimal
	If bOk Then
		bOk = bOk And ( Dec(sMteFact)<> 0 )	
		if not bok then sErreur += "Montant de facturation n'est pas un nombre ! "
	End If
	
	// [PM80_FA12_FRANEX]
	// Ici contrôles des frais annexes
	
	// Remplacer les null par 0 et // aucun montant strictement négatif
	lTotTbFrais = UpperBound ( sTbFraisAnex ) 
	
	If bOk Then
		For lCptTbFrais = 1 To lTotTbFrais 
			If IsNull ( sTbFraisAnex [lCptTbFrais] ) Or Trim ( sTbFraisAnex [lCptTbFrais] ) = "" Then sTbFraisAnex [lCptTbFrais] = "0"
			If Not IsNumber( sTbFraisAnex [lCptTbFrais] ) then
				bOk = False
				sErreur += "Les zones de montants de frais doivent être numériques (décimales) !"				
				Exit
			End If 
			
			If bOk Then
				if Dec ( sTbFraisAnex [lCptTbFrais])  < 0 Then
					bOk = False
					sErreur += "Les zones de montants de frais doivent être positives ou à zéro !"				
					Exit
				End If 
			End If 
		Next 
	End If 
	
	/* Suite mail de Coraline, l'indem princ peut être à zéro
	// Indem Princ doit être positif
	If bOk And dec ( sTbFraisAnex [1] ) <= 0 Then
		bOk = False
		sErreur += "Le montant de frais 'Indem. Princ' doit être strictement positif !"				
	End If 
	*/
	
	// La somme des frais de 1 à 11 doit être égale au montant de facture
	If bOk Then
		dcSomTbFrais = 0 
		For lCptTbFrais = 1 To lTotTbFrais 
			dcSomTbFrais += dec ( sTbFraisAnex [lCptTbFrais] )
		Next 
		If dec ( sMteFact )  <> dcSomTbFrais Then
			bOk = False
			sErreur += "La somme des frais doit être égale au montant de facturation !"				
		End If 
	End If 
	

	// *** Controles Spécifiques, par fournisseurs
	if bOk Then
		choose case sIdFourn
				
			case "FNC"// #4 [FNAC_PROD_ECH_TECH]
				sRetour 	= space(50)
				sOk 		= " "

				if bOk Then
					// soc_cptable
					SQLCA.PS_S01_AGENCE( sChampSup[1], "FNC", sRetour, sOk )
					bOk = ( sqlca.sqlcode = 0 )
					if Not bOk then sErreur += "Erreur SQL : PS_S01_AGENCE : "+SQLCA.SQLErrText
					if bOk and sOk = "N" then
						sErreur += "Société Comptable : " + trim(sRetour)
						bOk = False
					End If
					sRetour 	= space(50)
					sOk 		= " "
				End If

				if bOk Then
					// id_bon_ech
					// - 1 Controle de format : lng = 8 et idSin et IdSeq sont des nombres
					// Attention : lIdSin et lIdSeq sont réutilisé lors du report des données
					// vers le datastore d'enregitrement.

					// #7 [FNAC_BGE].[20091130112458810]
					Choose Case Len ( Trim ( sIdSinIdSeq ) )
				
						Case 8 // Ancien Format
							lIdSin = Long(Left(trim(sIdSinIdSeq), 7 ) )
							iIdSeq = Integer(Right(trim(sIdSinIdSeq), 1 ) )
							lLongueur = 8
						Case 20 // Nouveau Format
							lIdSin = Long(Mid ( Trim ( sIdSinIdSeq), 5, 7 ))
							iIdSeq = Integer(Mid ( Trim ( sIdSinIdSeq), 12, 1 ))
							lLongueur = 20
					End Choose
					// :#7 [FNAC_BGE].[20091130112458810]
					
					//* #8 [FNAC_BGE].[20091203110556880] passage de 8 à 20
					bOk = (lIdSin<>0) and ( Not IsNull (lIdSin) ) and &
							(iIdSeq<>0) and ( Not IsNull (iIdSeq) ) and &
							len(trim(sIdSinIdSeq)) = lLongueur
					if not bok then sErreur += "N° Bon d'échange incorrect ! "
					//* #8 [FNAC_BGE].[20091203110556880]
					
				End If


				//* :#8 [FNAC_BGE].[20091203110556880] 
				if bOk Then
					// id_bon_ech
					// - 3 Verification de presta existante
					SQLCA.PS_S12_COMMANDE( lIdSin, iIdSeq, sRetour, sOk )
					bOk = ( sqlca.sqlcode = 0 )
					if Not bOk then sErreur += " Erreur SQL : PS_S12_COMMANDE : "+SQLCA.SQLErrText
					if bOk and sOk = "N" then
						sErreur += "N° Bon d'échange : " + trim(sRetour)
						bOk = False
					End If
					sRetour 	= space(50)
					sOk 		= " "
					
				End If
				
				If bOk Then
					// num_fact : Doit être renseigné
					bOk = ( Len(trim(sNumFacture) ) > 0 ) and ( not isnull(sNumFacture) )
					if not bok then sErreur += "N° de facture obligatoire ! "
				End If
				
				if bOk Then
					// mt_bon, ie mt_fact
					// - 1 Doit êre positif.
					bOk = Dec(sMteFact) > 0
					if not bok then sErreur += "Mt du bon à 0 ou négatif ! "
				End If

				if bOk Then
					// mt_bon, ie mt_fact
					// - 2 Vérif par rapport à Mt de P.E.C.
					SQLCA.PS_S01_DIV_Det ( lIdSin, iIdSeq, Dec(sMteFact), sRetour, sOk )
					bOk = ( sqlca.sqlcode = 0 )
					if Not bOk then sErreur += "Erreur SQL : PS_S01_DIV_Det : "+SQLCA.SQLErrText
					if bOk and sOk = "N" then
						sErreur += "Mt Bon : " + trim(sRetour)
						bOk = False
					End If
					sRetour 	= space(50)
					sOk 		= " "
					
				End If

				if bOk Then
					// mag_rempl ( sChampSup[2] )
					// 1 - doit etre nombre et de lng 4
					bOk = /*len(trim(sChampSup[2]))=4 and*/ integer(sChampSup[2])>0
					if not bok then sErreur += "Magasin Remplacement Incorrect ! "
				End If					
				
				if bOk Then
					// mag_rempl ( sChampSup[2] )
					// 2 - Doit etre dans la table agence
					SQLCA.PS_S03_BOUTIQUE( lIdSin, sChampSup[2], sRetour, sOk)
					bOk = ( sqlca.sqlcode = 0 )
					if Not bOk then sErreur += "Erreur SQL : PS_S03_BOUTIQUE : "+SQLCA.SQLErrText
					if bOk and sOk = "N" then
						sErreur += "Magasin remplacement : " + trim(sRetour)
						bOk = False
					End If
					sRetour 	= space(50)
					sOk 		= " "
			
				End If

				if bOk Then
					// sChampSup[3] : heu_ticket
					// 1 - Doit etre un heure 
					// #6 [DCMP090483] et non null
					bOk = IsTime(sChampSup[3]) and Not (lnvString.of_isEmpty( sChampSup[3]))
					if not bok then sErreur += "Heure Ticket Incorrecte ! "
				End If					

				if bOk Then
					// caisse ( sChampSup[4] )
					// 1 - doit etre nombre
					// #6 [DCMP090483] et non null
					bOk = (Not lnvString.of_IsEmpty(sChampSup[4])) and integer(sChampSup[4])>0
					if not bok then sErreur += "Caisse Incorrecte ! "
				End If					

				if bOk Then
					// hote ( sChampSup[5] )
					// 1 - doit etre nombre
					// #6 [DCMP090483] et non null
					bOk = (Not lnvString.of_IsEmpty(sChampSup[5])) and integer(sChampSup[5])>0
					if not bok then sErreur += "Hote Incorrect ! "
				End If
				
				if bOk Then
					// ticket ( sChampSup[6] )
					// 1 - doit etre nombre
					// #6 [DCMP090483] et non null
					bOk = (Not lnvString.of_IsEmpty(sChampSup[6])) and integer(sChampSup[6])>0
					if not bok then sErreur += "Ticket Incorrect ! "
				End If
				
				if bOk Then
					// mt_ticket,
					// Doit êre positif.
					bOk = Dec(sChampSup[7] ) > 0
					if not bok then sErreur += "Mt Ticket à 0 ou négatif ! "
				End If

		End choose
	End If
			

	If Not bOk Then 
		dw_Charger.ScrollToRow ( lCpt )
		dw_Charger.SelectRow ( lCpt, True )
		Exit
	Else
		// *** Controles OK, reports des enregistrment dans le datastore d'enregistrement.
		// Copie des champs dans le ds de stockage
		lPos = ids_charger.InsertRow(0)
		
		//[VDOC9586]	
		// [DT57_CMDE_IPHONE_SFR]
		if ( iIdTypFact = k_typfact_h_presta Or &
			  iIdTypFact = K_TYPFACT_H_PRESTA_MAJ_1_DETAIL Or & 
			  iIdTypFact = K_TYPFACT_H_PRESTA_IPHONE_O2M_SFR & 
			  ) Then
			ids_charger.object.id_sin[lPos] 			= lIdSin
			ids_charger.object.dte_fact[lPos] 		= Date(sDteFact)
			ids_charger.object.num_facture[lPos] 	= sNumFacture
			ids_charger.object.mte_fact[lPos] 		= Dec(sMteFact)
			ids_charger.object.id_fourn[lPos] 		= sIdFournFic
			// #2 [DCMP080166]
			ids_charger.object.cat_fact[lPos] 		= sCatFact
			
			// [PM336-1]
			ids_charger.object.a_forcer[lPos]	= sAForcer
			
			
		Elseif (iIdTypFact = k_typfact_bnp_secu) Then	// [PC13174]
			ids_charger.object.id_adh[lPos] 			= sIdAdh
			ids_charger.object.id_prod[lPos] 			= lIdProd
			ids_charger.object.id_ets[lPos] 			= lIdEts
			ids_charger.object.dte_fact[lPos] 		= Date(sDteFact)
			ids_charger.object.num_facture[lPos] 	= sNumFacture
			ids_charger.object.mte_fact[lPos] 		= Dec(sMteFact)
			ids_charger.object.id_fourn[lPos] 		= sIdFournFic
			ids_charger.object.cat_fact[lPos] 		= sCatFact
			
			// [PM336-1]
			ids_charger.object.a_forcer[lPos]	= sAForcer
			
		Else
			// #1
			choose case sIdFourn
				// [PC151259-2]
				case "ADV", &
				"DT1", "DT2", "DT3", "DT4", "DT5", "DT6", "DT7", "DT8","DT9", "DT0", &
				"DTA","DTB","DTC","DTD","DTE","DTF","DTG","DTH","DTI","DTJ","DTK","DTL", &
				"DTM","DTN","DTO","DTP","DTQ","DTR","DTS","DTT","DTU","DTV","DTW","DTX","DTY","DTZ", &
				"DU0","DU1","DU2","DU3","DU4","DU5","DU6","DU7","DU8","DU9", &
				"DUA","DUB","DUC","DUE","DUF","DUG","DUH","DUI","DUJ","DUK","DUL","DUM","DUN","DUO", &
				"DUP","DUQ","DUR","DUS","DUT","DUU","DUV","DUW","DUX","DUY","DUZ", &
				"DV0","DV1","DV2","DV3","DV4","DV5","DV6","DV7","DV8","DV9","DVA","DVB","DVC","DVE","DVF", &
				"DVG","DVH","DVI","DVJ","DVK","DVL","DVM","DVN","DVO","DVP","DVQ","DVR","DVS","DVT","DVU","DVV", "DVW","DVX","DVY","DVZ"
				
					ids_charger.object.id_sin[lPos] 			= lIdSin
					ids_charger.object.dte_fact[lPos] 		= Date(sDteFact)
					ids_charger.object.num_facture[lPos] 	= sNumFacture
					ids_charger.object.mte_fact[lPos] 		= Dec(sMteFact)
					ids_charger.object.id_fourn[lPos] 		= sIdFournFic
					// #2 [DCMP080166]
					ids_charger.object.cat_fact[lPos] 		= sCatFact
					
					// [PM336-1]
					ids_charger.object.a_forcer[lPos]	= sAForcer
				
				// [PC151259]
				Case "CDS", &
					  "SR1", &
					  "CEG", &
					  "OSC", &
					  "TOI", &
					  "TL1", &
					  "A4E", "A4F", "A4G", "A4H", "A4I", "A4J", "A4K", "A4L", "A4M", "A4N", "A4O", "A4P",&
					  "A4Q", "A4R", "A4S", "A4T", "A4U", "A4V", "A4W", "A4X", "A4Y", "A4Z", "A5A", "A5B", "A5C", "A5D",&
					  "A5E", "A5F", "A5G", "A5H", "A5I", "A5J", "A5K", "A5L", "A5M", "A5N", "A5O", "A5P", "A5Q", "A5R",&
					  "A5S", "A5T", "A5U", "A5V", "A5W", "A5X", "A5Y", "A5Z", "A6A", "A6B", "A6C", "A6D", "A6E", "A6F",&
					  "A6G", "A6H", "A6I", "A6J", "A6K", "A6L", "A6M", "A6N", "A6O", "A6P", "A6Q", "A6R", "A6S", "A6T",&
					  "A6U", "A6V", "A6W", "A6X", "A6Y", "A6Z", "A7A", "A7B", "A7C", "A7D", "A7E", "A7F", "A7G", "A7H",&
					  "A7I", "A7J", "A7K", "A7L", "A7M", "A7N", "A7O", "A7P", "A7Q", "A7R", "A7S", "A7T", "A7U", "A7V",&
					  "A7W", "A7X", "A7Y", "A7Z", "A80", "A81", "A82", "A83", "A84", "A85", "A86", "A87", "A88", "A89",&
					  "A90", "A91", "A92", "A93", "A94", "A95", "A96", "A97", "A98",&
					  "NE1", "NE2", "NE3", "NE4", "NE5", "NE6", "NE7", "BLP", "BLQ"
					// [FACTU_VIP_CDS]
					// [FACTU_SRR]
					// [DT227]
					// Nouveau générique pour Méthode en en spécifiant le fournisseur à règler
					ids_charger.object.id_sin[lPos] 			= lIdSin
					ids_charger.object.id_seq[lPos] 			= iIdSeq
					ids_charger.object.dte_fact[lPos] 		= Date(sDteFact)
					ids_charger.object.num_facture[lPos] 	= sNumFacture
					ids_charger.object.mte_fact[lPos] 		= Dec(sMteFact)
					ids_charger.object.id_fourn[lPos] 		= sIdFournFic  // La nouveauté
					ids_charger.object.cat_fact[lPos] 		= sCatFact			
					
					// [PM336-1]
					ids_charger.object.a_forcer[lPos]	= sAForcer
					

				// [PM363-1] à migrer au dessus lors de la désact de la clé PM363-1
				Case "O2M"
					// [PM363-1]
					ids_charger.object.id_sin[lPos] 			= lIdSin
					ids_charger.object.id_seq[lPos] 			= iIdSeq
					ids_charger.object.dte_fact[lPos] 		= Date(sDteFact)
					ids_charger.object.num_facture[lPos] 	= sNumFacture
					ids_charger.object.mte_fact[lPos] 		= Dec(sMteFact)
					ids_charger.object.id_fourn[lPos] 		= sIdFournFic  // La nouveauté
					ids_charger.object.cat_fact[lPos] 		= sCatFact		
					
					// [PM336-1]
					ids_charger.object.a_forcer[lPos]	= sAForcer
					
				Case "999" // lié SCR [VDOC14649]
					ids_charger.object.id_sin[lPos] 			= lIdSin
					ids_charger.object.dte_fact[lPos] 		= Date(sDteFact)
					ids_charger.object.num_facture[lPos] 	= sNumFacture
					ids_charger.object.mte_fact[lPos] 		= Dec(sMteFact)
					ids_charger.object.id_fourn[lPos] 		= sIdFournFic  // La nouveauté
					ids_charger.object.cat_fact[lPos] 		= sCatFact						
					
					// [PM336-1]
					ids_charger.object.a_forcer[lPos]	= sAForcer
				
					
				case "FNC"// #4 [FNAC_PROD_ECH_TECH]
					ids_charger.object.id_sin[lPos] 			= lIdSin
					ids_charger.object.id_seq[lPos] 			= iIdSeq
					ids_charger.object.dte_fact[lPos] 		= Date(sDteFact)
					ids_charger.object.num_facture[lPos] 	= sNumFacture
					ids_charger.object.mte_fact[lPos] 		= Dec(sMteFact)
					// #2 [DCMP080166]
					ids_charger.object.cat_fact[lPos] 		= sCatFact
					
					// [PM336-1]
					ids_charger.object.a_forcer[lPos]	= sAForcer
					
					//
					//* #8 [FNAC_BGE].[20091203110556880] modification lCpt en lPos
					ids_charger.object.soc_cptable[lPos]	= sChampSup[1]
					ids_charger.object.mag_rempl[lPos]		= sChampSup[2]
					ids_charger.object.heu_ticket[lPos]		= time(sChampSup[3])
					ids_charger.object.caisse[lPos]			= sChampSup[4]
					ids_charger.object.hote[lPos]				= sChampSup[5]
					ids_charger.object.ticket[lPos]			= sChampSup[6]
					ids_charger.object.mt_ticket[lPos]		= Dec(sChampSup[7])
					ids_charger.object.lst_fact[lPos]		= sChampSup[8]
					ids_charger.object.lst_article[lPos]	= sChampSup[9]
					//* :#8 [FNAC_BGE].[20091203110556880]
					
					
					
				case else
					ids_charger.object.id_sin[lPos] 			= lIdSin
					ids_charger.object.id_seq[lPos] 			= iIdSeq
					ids_charger.object.dte_fact[lPos] 		= Date(sDteFact)
					ids_charger.object.num_facture[lPos] 	= sNumFacture
					ids_charger.object.mte_fact[lPos] 		= Dec(sMteFact)
					// #2 [DCMP080166]
					ids_charger.object.cat_fact[lPos] 		= sCatFact
					
					// [PM336-1]
					ids_charger.object.a_forcer[lPos]	= sAForcer

			end choose
		End If
		
		// [PM80_FA12_FRANEX]

		// Zones communes à tous les DO ci-dessus, donc un seul chargement commun
		ids_charger.object.indem_princ_1[lPos] = Dec (sTbFraisAnex[1])
		ids_charger.object.frais_anex_2[lPos] = Dec (sTbFraisAnex[2])
		ids_charger.object.frais_anex_3[lPos] = Dec (sTbFraisAnex[3]) 
		ids_charger.object.frais_anex_4[lPos] = Dec (sTbFraisAnex[4]) 
		ids_charger.object.frais_anex_5[lPos] = Dec (sTbFraisAnex[5])
		ids_charger.object.frais_anex_6[lPos] = Dec (sTbFraisAnex[6]) 
		ids_charger.object.frais_anex_7[lPos] = Dec (sTbFraisAnex[7]) 
		ids_charger.object.frais_anex_8[lPos] = Dec (sTbFraisAnex[8]) 
		ids_charger.object.frais_anex_9[lPos] = Dec (sTbFraisAnex[9]) 
		ids_charger.object.frais_anex_10[lPos] = Dec (sTbFraisAnex[10])
		ids_charger.object.frais_anex_11[lPos] = Dec (sTbFraisAnex[11])

		
		
		//
		SetNull(lPos)
		hpb_trt.Position++
		wf_pct()
		Yield()


	End If
Next


//* #8 [FNAC_BGE].[20091203110556880] contrôle déporté
If bOk And sIdFourn = "FNC" Then 
	lTotRow = ids_charger.Rowcount ()
	ids_charger.SetSort ( "ID_SIN A" )
	ids_charger.Sort ()
	lIdSinPrec = -1
	For lCpt = 1 To lTotRow
		lIdSin = ids_charger.object.id_sin [lCpt]
		
		If lIdSin = lIdSinPrec Then
			bOk = False
			lCpt = 0
			sErreur += "N° Bon d'échange en doublon sinistre " + String (lIdSin) + " (à rechercher dans le fichier FNAC) ! "
			sRetour 	= space(50)
			sOk 		= " "
			Exit
		End If
		
		lIdSinPrec = lIdSin
	Next
End If
//* #8 [FNAC_BGE].[20091203110556880] 


if bOk Then // [DCMP080461] Confirmation d'un traitement hors prestation
	if bHpresta Then
		stmessage.stitre = "Confirmation du Type de Facturation"
		stMessage.icon	  = Question!
		stMessage.bouton = YesNo!
		
		Choose Case iIdTypFact 
				
			Case k_typfact_h_presta 
				stMEssage.scode  = "COMD475"
				
			Case K_TYPFACT_H_PRESTA_MAJ_1_DETAIL
				// [PM251-2]
				stMEssage.scode  = "COMD890"								
			

			Case K_TYPFACT_H_PRESTA_IPHONE_O2M_SFR
				// [DT57_CMDE_IPHONE_SFR]
				stMEssage.scode  = "COMD824"				
			
		End Choose 
				
		if F_message(stMessage) = 1 THen
			st_Extraire.Text  = "Contrôle Ok !"
			bOk = TRUE
		Else
			st_Extraire.text  = "Contrôle non validé ( erreur de choix de type de facturation ) !"
			bOk = FALSE
		End If
	Else
		// [DT044-1_V5]
		// [PM210]
		stMEssage.scode = ""
		Choose Case iIdTypFact 
			
			Case K_TYPFACT_PRESTA_NORM_SANS_REGL
				stMEssage.scode  = "COMD830"
				stMEssage.Bouton = YESNO!

			Case K_TYPFACT_DIAG_O2M
				stMEssage.scode  = "COMD835"
				stMEssage.Bouton = YESNO!

			Case K_TYPFACT_BNP_SECU
					// [PC13174]
				stMEssage.scode  = "COMD883"				
				stMEssage.Bouton = YESNO!					
			
			Case Else
				st_Extraire.Text  = "Contrôle Ok !"
			
		End Choose 
		
		If stMEssage.scode <> "" Then
			if F_message(stMessage) = 1 THen
				st_Extraire.Text  = "Contrôle Ok !"
				bOk = TRUE
			Else
				st_Extraire.text  = "Contrôle non validé ( erreur de choix de type de facturation ) !"
				bOk = FALSE
			End If				
		End If
	End If
else
	st_Extraire.Text  = "Erreur sur la ligne n°"+string(lCpt)+" "+sErreur
End If
SetPointer(Arrow!)


If bOk Then
	st_extraire.BackColor = 32768
   st_extraire.TextColor = 16777215
Else
	st_extraire.BackColor = 255
   st_extraire.TextColor = 16777215	
End If 


Return bOk

end function

public subroutine wf_positionner_objets (string ascas);
end subroutine

public subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Sinistre::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 28/09/2022
//* Libellé			: 
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

		hpb_trt.Y -= 1510
		hpb_trt.Width = dw_charger.Width
		st_pct.Y = hpb_trt.Y
		st_pct.X = hpb_trt.X + ( hpb_trt.Width / 2 ) - ( st_pct.Width / 2)

		st_Charger.Y -= 1510
		st_Charger.Width = dw_charger.Width
		
		st_Extraire.Y -= 1510
		st_Extraire.Width = dw_charger.Width
	
	
	
End Choose
	





end subroutine

private subroutine wf_pct ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_autofact::wf_pct (PRIVATE)
//* Auteur        : JFF
//* Date          : 13/01/2023
//* Libellé       : maj pourcentage
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

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Trt_Extr1::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: PHG, d'après JFF ( w_sp_trt_stat3 )
//* Date				: 20/11/2006
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JCA	22/02/2007	DCMP 070110 - Ajout du fournisseur Darty
//* #2	PHG	13/06/2008	[DCMP080461] Intégration FActuration Hors Prestation
//*-----------------------------------------------------------------

DataWindowChild dwChild
Long lRow

This.Title = "Automatisation Facturation Fournisseur Téléphonie"

// #1
// ids_charger = create datastore
// ids_charger.dataobject = 'd_stk_autofact'
// #1

dw_Fourn.Reset ()
dw_Fourn.InsertRow ( 0 )

dw_Fourn.GetChild ( "ID_FOURN", dwChild )
dwChild.SetTransObject ( SQLCA )
lRow = dwChild.Retrieve ( "-FR" )

// #2 [DCMP080461] Chargement de la liste des types de facturation
dw_Fourn.GetChild ( "ID_TYP_FACT", dwChild )
dwChild.SetTransObject ( SQLCA )
lRow = dwChild.Retrieve ( "-AF" )

// Gros problème : Cette fenêtre (je ne sais pas pourquoi) ne déclenche plus
// nativement le SHOW(), var comprendre, l'appel de la fonction this.show() ne fonctionne pas non plus

isCasTailleFen = "REDUIRE"
// cb_taillefen.PostEvent ( "clicked" ) 
PostEvent ("show")

end event

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_autofact
//* Evenement     : Show
//* Auteur        : PHG, d'après JFF ( w_sp_trt_stat3 )
//* Date          : 20/11/2006
//* Libellé       : Chargement des données
//* Commentaires  : Chargement des références commandes SPB se trouvant
//*					  sur C:\TEMP\[utilisateur]\[application]\FICFOURN.TXT
//*
//* Arguments     : Aucun
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     	Modification
//* #1	JCA		23/02/2007	DCMP 070110 - Ajout du fournisseur Darty
//* #2	PHG		13/06/2008	[DCMP080461] Integration Facturation Hors PRestation
//       JFF      03/09/2014  [DT92_FACTU_CASTO]
//       JFF   	25/11/2014 	[PM251-2]
//*-----------------------------------------------------------------

String	sIdFourn, sModif
integer  iIdTypFact //#2 [DCMP080461]

sModif = "ID_FOURN.protect = 0 ID_FOURN.background.color = 16777215 ID_FOURN.border = 5 "

//#2 [DCMP080461] La dddw de selection du type de factu est accessible.
sModif += "ID_TYP_FACT.protect = 0 ID_TYP_FACT.background.color = 16777215 ID_TYP_FACT.border = 5 "
//

dw_Fourn.Modify ( sModif )

//sIdFourn = dw_Fourn.GetItemString ( 1, "ID_FOURN" )
//If IsNull ( sIdFourn ) Then sIdFourn = ""
//
////#2 [DCMP080461]
//iIdTypFact = dw_fourn.object.id_typ_fact[1]
////
//
//cb_Charger.Enabled = sIdFourn <> ""

cb_Charger.Enabled = FALSE

cb_Annuler.Enabled = False
cb_Controler.Enabled = False
cb_result.Enabled = FALSE  // [DT92_FACTU_CASTO]
cb_Maj.Enabled = False
hpb_trt.Position = 0
wf_pct()
Yield()


st_charger.Text = ""
st_Extraire.Text = ""

dw_fourn.SetItem ( 1, "ID_FOURN", "" ) 	// #1 - Remise à blanc de la dropdown du fournisseur
dw_fourn.SetItem ( 1, "ID_TYP_FACT", stnul.inum )  // #2 [DCMP080461] - Remise à blanc de la dropdown du fournisseur

st_1.Visible = true // #1

Dw_Charger.Reset ()

if isvalid(ids_Charger) then ids_Charger.reset ()

// [PM251-2]
dw_visu_trt.Visible = True	
dw_visu_trt.Reset ()
dw_visu_trt.InsertRow ( 0 )	


st_extraire.textcolor = 16711680
st_extraire.backcolor = 67108864



end event

on w_sp_trt_autofact.create
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
this.cb_result=create cb_result
this.dw_visu_trt=create dw_visu_trt
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
this.Control[iCurrent+12]=this.cb_result
this.Control[iCurrent+13]=this.dw_visu_trt
this.Control[iCurrent+14]=this.cb_taillefen
this.Control[iCurrent+15]=this.st_pct
end on

on w_sp_trt_autofact.destroy
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
destroy(this.cb_result)
destroy(this.dw_visu_trt)
destroy(this.cb_taillefen)
destroy(this.st_pct)
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_autofact
//* Evenement 		: close
//* Auteur			: Pierre-Henri Gillot
//* Date				: 23/11/2006 13:27:36
//* Libellé			: 
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

type cb_debug from w_8_accueil`cb_debug within w_sp_trt_autofact
end type

type pb_retour from w_8_accueil`pb_retour within w_sp_trt_autofact
integer width = 242
integer height = 144
integer taborder = 130
end type

type pb_interro from w_8_accueil`pb_interro within w_sp_trt_autofact
boolean visible = false
integer taborder = 150
boolean enabled = false
end type

type pb_creer from w_8_accueil`pb_creer within w_sp_trt_autofact
boolean visible = false
integer taborder = 140
boolean enabled = false
end type

type dw_1 from w_8_accueil`dw_1 within w_sp_trt_autofact
integer x = 0
integer y = 1520
integer width = 302
integer height = 244
integer taborder = 30
end type

type pb_tri from w_8_accueil`pb_tri within w_sp_trt_autofact
boolean visible = false
integer taborder = 160
boolean enabled = false
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_sp_trt_autofact
integer taborder = 20
end type

type cb_charger from commandbutton within w_sp_trt_autofact
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
string text = "Charger les références"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_autofact::cb_Charger
//* Evenement     : Clicked
//* Auteur        : PHG, d'après JFF ( w_sp_trt_stat3 )
//* Date          : 20/11/2006
//* Libellé       : Chargement des données
//* Commentaires  : Chargement des références commandes SPB se trouvant
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
//* #3	 PHG	 16/06/2008	 [DCMP080461] Intégration Facturation Hors Prestation
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

type cb_annuler from commandbutton within w_sp_trt_autofact
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
//* Auteur        : PHG, d'après JFF ( w_sp_trt_stat3 )
//* Date          : 20/11/2006
//* Libellé       : 
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

type st_charger from statictext within w_sp_trt_autofact
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

type st_extraire from statictext within w_sp_trt_autofact
integer x = 1088
integer y = 1584
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

type cb_controler from commandbutton within w_sp_trt_autofact
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
string text = "Contrôler les données chargées"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_autofact::cb_Controler
//* Evenement     : Clicked
//* Auteur        : PHG, d'après JFF ( w_sp_trt_stat3 )
//* Date          : 20/11/2006
//* Libellé       : Controle des données
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
	
End If

end event

type dw_fourn from datawindow within w_sp_trt_autofact
integer x = 430
integer y = 168
integer width = 2917
integer height = 120
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_choix_fournisseur_ctrl"
boolean border = false
boolean livescroll = true
end type

event itemchanged;
//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_autofact::dw_Fourn
//* Evenement     : ItemChanged
//* Auteur        : PHG
//* Date          : 20/11/2006
//* Libellé       : Choix du fournisseur
//* Commentaires  : 
//*
//* Arguments     : Aucun
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1   JCA	23/02/2007		DCMP 070110 - Ajout du fournisseur Darty
//* #2	PHG	16/06/2008		[DCMP080461] Intégration FActuration Hors PRestation
//*-----------------------------------------------------------------
integer iActionCode, iTotFourn, iRow // #1
DataWindowChild dwChild // #1
boolean bOkToProcess
n_cst_string lnvString

//#2 [DCMP080461] Gestion de l'accès au bouton "Charger"
Choose case upper(dwo.name)
	case "ID_FOURN"
		bOkToProcess = Not lnvString.of_isEmpty(data) and &
							Not lnvString.of_IsEmpty(string(object.id_typ_fact[row]))
	case "ID_TYP_FACT"
		bOkToProcess = Not lnvString.of_isEmpty(data) and &
							Not lnvString.of_IsEmpty(string(object.id_fourn[row]))
End Choose
	
cb_Charger.Enabled = bOkToProcess
//

st_1.visible = false // #1

// #1
// d_choix_fournisseur_ctrl rendu editable afin de faciliter la recherche
// controle que la saisie est valide
choose case dwo.name 
	case 'id_fourn'
		this.GetChild ( dwo.name, dwChild )
		iTotFourn = dwChild.rowcount()
		
		iRow = dwChild.find ( "ID_CODE = '" + data + "'", 1, iTotFourn )
		
		if  iRow < 1 then
			iActionCode = 1
		end if
end choose

return iActionCode
// FIN - #1
end event

event itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Fourn::ItemError
//* Evenement 		: ItemError
//* Auteur			: JCA
//* Date				: 26/02/2006
//* Libellé			: 
//* Commentaires	: Gestion des Erreurs 
//* 						DCMP 070110 - Ajout du fournisseur Darty
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

stMessage.sTitre	= "Gestion de la facturation fournisseur"
stMessage.Icon		= Information!

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

type cb_maj from commandbutton within w_sp_trt_autofact
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
string text = "Mise à jour"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_autofact::cb_Maj
//* Evenement     : Clicked
//* Auteur        : PHG
//* Date          : 21/11/2006
//* Libellé       : Lancement du traitement
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

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

type dw_charger from datawindow within w_sp_trt_autofact
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
//* Libellé			: 
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

type hpb_trt from hprogressbar within w_sp_trt_autofact
integer x = 1088
integer y = 1396
integer width = 2482
integer height = 64
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type st_1 from statictext within w_sp_trt_autofact
boolean visible = false
integer x = 1344
integer y = 764
integer width = 1728
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
string text = "Sélectionner un fournisseur... puis charger les références..."
boolean focusrectangle = false
end type

type st_avertissement_monnaie from u_st_avertissement_monnaie within w_sp_trt_autofact
integer x = 1614
integer y = 12
integer width = 1193
integer height = 136
boolean bringtotop = true
long backcolor = 67108864
string text = "Les montants du fichier texte à intégrer doivent être exprimés en "
alignment alignment = center!
end type

event constructor;//*-----------------------------------------------------------------
//*
//* Objet			: u_st_avertissement_monnaie
//* Evenement 		: constructor
//* Auteur			: 
//* Date				: 27/02/2008 14:43:58
//* Libellé			: 
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

type cb_result from commandbutton within w_sp_trt_autofact
integer x = 105
integer y = 920
integer width = 869
integer height = 156
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Sauvegarder les résultats"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Fonction      : clicked  (PRIVATE)
//* Auteur        : JFF
//* Date          : 28/01/2013
//* Libellé       : Contrôle des données
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     	Modification
//			JFF		27/01/2014	[VDOC12917]
//			FPI		23/07/2024	[MIG_PB2022] Sauvegarde Excel! remplacée par Excel8!
//*-----------------------------------------------------------------

String sNomComplet, sNomFic
Long lRet
		
GetFileSaveName( "Sauvegarde du résultat de traitement en fichier Excel", sNomComplet, sNomFic, "", "Fichiers Excel (*.XLS),*.XLS, Tous Fichiers (*.*),*.*")

lRet = dw_Charger.SaveAs ( sNomComplet, Excel8!, True ) // [MIG_PB2022]

Choose Case lRet 
	Case -1 
		
		stMessage.sTitre		= "Ecriture fichier"
		stMessage.Icon			= StopSign!
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

type dw_visu_trt from datawindow within w_sp_trt_autofact
boolean visible = false
integer x = 32
integer y = 1220
integer width = 1033
integer height = 392
integer taborder = 120
boolean bringtotop = true
string title = "none"
string dataobject = "d_visu_trt_facturation"
boolean border = false
end type

type cb_taillefen from commandbutton within w_sp_trt_autofact
integer x = 2866
integer y = 28
integer width = 709
integer height = 128
integer taborder = 150
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "J~'agrandis la fenêtre"
end type

event clicked;
If isCasTailleFen = "REDUIRE" Then 
	isCasTailleFen = "AGRANDIR"
	Wf_PositionnerObjets ( )
	cb_taillefen.Text = "Je réduis la fenêtre"
Else 
	isCasTailleFen = "REDUIRE"
	Wf_PositionnerObjets ( )
	cb_taillefen.Text = "J'agrandis la fenêtre"	
End If 
end event

type st_pct from statictext within w_sp_trt_autofact
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

