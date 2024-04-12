-------------------------------------------------------------------
--
-- Fichier              :       PM251.CP
-- Auteur               :       FABRY JF
-- Date                 :       27/11/2014
--								[PM251-1][PM251-2]
-- Commentaires         :       
--
-- sysadm.PS_I01_TRACE_CMDE_V01
-- sysadm.PS_I01_MAJ_SKU_IFR_PM251
-- sysadm.PS_I01_RETOUR_PREFACT_PM251
-- sysadm.PS_S_CONTROLE_DBLT_REGLT
-- sysadm.PS_S_CONTROLE_VALIDATION
-- sysadm.PS_S_REGLEMENT_PM251
-- sysadm.PS_S01_PRE_FACTU_PM251_MASSE_NREGL
-- sysadm.PS_S01_PRE_FACTU_PM251_MASSE_REGL_ET_NREGL
-- sysadm.PS_S01_PRE_FACTU_PM251_UNITAIRE_NREGL
-- sysadm.PS_S01_PRE_FACTU_PM251_UNITAIRE_REGLE_ET_NREGL
-- sysadm.PS_S01_PRE_FACTU_PM251_V03
-- sysadm.PS_U_MAJ_CONTACT_PM251
-- sysadm.PS_U_PREPA_VAL_AUTO_PM251_V01
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       PS_S01_PRE_FACTU_PM251
-- Auteur               :       JFF
-- Date                 :       08/09/2014
-- Libelle              :       Select pour pre-factu à partir de SAGA
-- Commentaires         :       [PM251-1]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF	21/11/2014	[VDOC16011]
-- JFF	25/11/2014	[PM251-2]
-- JFF  12/05/2015  [DT076_V6]
-- JFF  28/07/2015  [DT076_V6]
-- JFF  28/07/2015  [PM295-1]
-- JFF  08/03/2016  [VDOC20161]
-- JFF  25/05/2016  [PM251-4]
-- JFF  07/07/2016  [VDOC21248]
-- JFF  12/02/2016  [PI062]
-- JFF  07/11/2016  [PC151259]
-- JFF  26/12/2016  [20161226.1.JFF]
-- JFF  16/01/2016  [PM251-5] V03
-- JFF  16/01/2016  [PM363-1]
-- JFF  27/01/2017  [PM251-4][M23697]
-- JFF  10/03/2017  [PM383-1]
-- JFF  29/05/2017  [PC151259-2]
-- JFF  05/10/2017  [PC171918]
-- JFF  06/11/2017  [PC171933]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_PRE_FACTU_PM251_V03' AND type = 'P' )
        DROP procedure sysadm.PS_S01_PRE_FACTU_PM251_V03
GO

CREATE procedure sysadm.PS_S01_PRE_FACTU_PM251_V03
        @dtDteDeb		 DateTime, -- Utilisé si @dcIdSin à null
        @dtDteFin		 DateTime, -- Utilisé si @dcIdSin à null
        @sCas			 VarChar ( 50 ),  -- 'PRESTA_REGLEES_ET_NON_REGLEES' ou null
        @dcIdSin		 Decimal ( 10 ), -- [PI062] -- null pour le traitement standard, sinon un id_sin pour un sinistre précis
        @iIdSeq			 Integer -- idem l'id_seq lié à l'id_sin, sinon null
        
AS

Set @dtDteDeb = Convert ( Varchar, @dtDteDeb, 103 ) + ' 0:00:00'
Set @dtDteFin = Convert ( Varchar, @dtDteFin, 103 ) + ' 23:59:00'

-- En Masse, non réglé
IF @dtDteDeb is not null And @dtDteFin is not null And @sCas is null and @dcIdSin is null and @iIdSeq is null
 Begin
	Exec sysadm.PS_S01_PRE_FACTU_PM251_MASSE_NREGL @dtDteDeb, @dtDteFin 
 End 

-- En Masse, Réglé & non réglé
IF @dtDteDeb is not null And @dtDteFin is not null And @sCas = 'PRESTA_REGLEES_ET_NON_REGLEES' and @dcIdSin is null and @iIdSeq is null
 Begin
	Exec sysadm.PS_S01_PRE_FACTU_PM251_MASSE_REGL_ET_NREGL @dtDteDeb, @dtDteFin
 End 

-- Unitaire, non réglé
IF @dtDteDeb is null And @dtDteFin is null And @sCas is null and @dcIdSin is not null and @iIdSeq is not null
 Begin
	Exec sysadm.PS_S01_PRE_FACTU_PM251_UNITAIRE_NREGL @dcIdSin, @iIdSeq
 End 

-- Unitaire, réglé & non réglé
IF @dtDteDeb is null And @dtDteFin is null And @sCas = 'PRESTA_REGLEES_ET_NON_REGLEES' and @dcIdSin is not null and @iIdSeq is not null
 Begin
	Exec sysadm.PS_S01_PRE_FACTU_PM251_UNITAIRE_REGLE_ET_NREGL @dcIdSin, @iIdSeq
 End 

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S01_PRE_FACTU_PM251_MASSE_NREGL
-- Auteur               :       JFF
-- Date                 :       13/09/2018
-- Libelle              :       
-- Commentaires         :       [PM251-1][VDOC26763]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF	13/09/2018	VDOC26763
-- JFF  07/08/2019  [PM462-1]
-- JFF  25/08/2022  [RS3220] TELSTORE O2M=>TLS=>TL1
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_PRE_FACTU_PM251_MASSE_NREGL' AND type = 'P' )
        DROP procedure sysadm.PS_S01_PRE_FACTU_PM251_MASSE_NREGL
GO

CREATE procedure sysadm.PS_S01_PRE_FACTU_PM251_MASSE_NREGL
        @dtDteDeb		 DateTime, -- Utilisé si @dcIdSin à null
        @dtDteFin		 DateTime -- Utilisé si @dcIdSin à null
AS

Select  sysadm.FN_AFF_DATE ( @dtDteDeb, 'AVEC_HEURE' ) 'dte_cloture',
		sysadm.FN_AFF_DATE ( @dtDteFin, 'AVEC_HEURE' ) 'fin_cloture',
		c.id_sin,
		c.id_seq,
		c.id_four,
		sysadm.FN_CODE_CAR ( c.id_four, '-FR' ) lib_four,
		s.id_prod,
		s.id_ets,
		s.id_adh,
		s.id_sdos,
		sysadm.FN_LIB_PROD ( s.id_prod ) lib_prod,
		sysadm.FN_GET_LIB_POLICE_V01 ( s.id_sin, s.id_prod, s.id_rev, c.id_gti, null ) lib_police,
		sysadm.FN_LIB_CIE( s.id_sin ) lib_cie,
		( select ds.val_car from sysadm.div_sin ds where ds.id_sin = s.id_sin and nom_zone = 'type_app' ) typ_app_sin,
		( select sysadm.FN_CODE_CAR ( ds.val_car, '-AR') from sysadm.div_sin ds where ds.id_sin = s.id_sin and nom_zone = 'type_app' ) lib_typ_app_sin,
		s.dte_ach_port 'dte_achat',
		s.dte_surv,
		rtrim( s.marq_port )'marq_sin',
		rtrim( s.modl_port ) 'modl_sin',
		rtrim( s.num_imei_port ) 'imei_serie_sin',
		( Select Top 1 rtrim( i.sku_saga )
		  From	sysadm.ifr i
		  where	i.marque = s.marq_port
		  And	i.reference = s.modl_port ) sku_saga_sin,
		rtrim( sysadm.FN_CODE_NUM ( c.info_spb_frn, '-IF' )) + ' (' + Convert ( varchar ( 10), c.info_spb_frn ) + ')' 'lib_process',		  
		c.info_spb_frn 'process',
		c.id_typ_art 'id_typ_art',
		Case 
			When c.cod_etat <> 'ANN' And c.status_gc <> 176 And c.id_gti <> 10 And sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'PRET' Then 'PRET'
		End 'Pret',
		Case 
			When c.id_typ_art = 'EDI' Then c.id_ref_four
			When c.id_typ_art = 'PRS' Then 'REPARATION/DESOXYDATION'
			When c.id_typ_art not in ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' )		
				 Or 
				 ( c.id_typ_art in ( 'RST' ) And sysadm.FN_CLE_VAL ( 'RST_CMDE+SUIVI', rtrim ( c.info_spb_frn_cplt), ';'  ) = 'OUI' )  Then 'A_COMMANDER'
			Else sysadm.FN_CODE_CAR ( c.id_typ_art, '-AR' )
		End 'action',
		Case 
			When sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Mode SAV Réparation'
			When sysadm.FN_CLE_VAL ( 'A_DESOXYDER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Mode SAV Désoxydation'
 			When sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Mode Garantie App. Rempl.'
 			When sysadm.FN_CLE_VAL ( 'A_CONTROLER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Mode 2ème SAV pour Ctrle'
			Else ''
		End 'SAV',
		Case 
			When sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Or
				 sysadm.FN_CLE_VAL ( 'A_DESOXYDER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' 
				 Then
				 ( Select max ( c1.id_seq )
				   From	  sysadm.commande c1
				   Where  c1.id_sin = c.id_sin
				   and    c1.id_seq < c.id_seq
				   And    c1.id_ref_four in (  'A_REPARER', 'A_DESOXYDER' )
				   And    c1.status_gc in ( 2,22,21,23 )
				   And    c1.cod_etat <> 'ANN'
				 ) 
		End 'IdSeq_orig_sav',
		Case 
			when CharIndex ( '[SAV_NO_OK]', c.comment_frn, 1 ) > 0 Then 'SAV_NO_OK'
			Else ''
		End 'Retour_SAV',
		c.id_ref_four,
		Case 
			When sysadm.FN_CLE_VAL ( 'RST_CMDE+SUIVI', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Rupture de Stock avec Commande de Remplacement + Suivi'
			When sysadm.FN_CLE_VAL ( 'RST_INFO_SIMPLE', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Rupture de Stock pour information'			
			Else ''
		End 'typ_rupture_stock',
		rtrim( c.id_marq_art ) 'marq_fourn_cmde',
		rtrim( c.id_modl_art ) 'modl_fourn_cmde',
		rtrim( c.id_marq_art_ifr ) 'marq_ifr_cmde',
		rtrim( c.id_modl_art_ifr ) 'modl_ifr_cmde',
		( Select Top 1 rtrim( i.sku_saga )
		  From	sysadm.ifr i
		  where	i.marque = c.id_marq_art_ifr
		  And	i.reference = c.id_modl_art_ifr ) sku_saga_cmd,
		Case
			When IsNumeric ( sysadm.FN_CLE_VAL ( 'PRIX_TTC_FACTU_O2M', rtrim ( info_frn_spb_cplt ) , ';' )) = 1 Then
				 CONVERT( decimal ( 11,2), replace ( sysadm.FN_CLE_VAL ( 'PRIX_TTC_FACTU_O2M', rtrim ( info_frn_spb_cplt ) , ';' ), ',', '.' ))
			Else c.mt_ttc_cmde
		End mt_ttc_cmde,
		c.id_serie_nouv 'imei_serie_nouv',
		( Select rtrim( i.nom ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Nom_Inter_Ass',
		( Select rtrim( i.adr_1 ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Adr1_inter_Ass',		
		( Select rtrim( i.adr_2 ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Adr2_inter_Ass',				
		( Select rtrim( i.adr_cp )  from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'AdrCp_inter_Ass',				
		( Select rtrim( i.adr_ville ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'AdrVille_inter_Ass',				
		rtrim( sysadm.FN_CODE_NUM ( c.status_gc, '-GC' ) + ' (' + Convert ( varchar ( 10), c.status_gc) + ')' ) lib_status_gc,
		c.cod_etat,
		c.dte_env_cli 'dte_fin_trait',
		Case 
			When c.cod_etat in ( 'RPC', 'RFO', 'RSP' ) Then 'CLOTUREE (' + rtrim ( c.cod_etat) + ')'
			When c.cod_etat in ( 'ANN' ) Then 'ANNULEE (' + rtrim ( c.cod_etat) + ')'
			Else sysadm.FN_CODE_CAR ( c.cod_etat, '-EC' )
		End lib_etat,
		Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré en pointe de vente'
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré envoie coli en centralisation'
		End 'Ass_en_pdv_ou_coli',
		Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
				/* [VDOC20161]
				Then ( Select Top 1 b.adr_nom
					   From sysadm.boutique b
					   Where b.id_prod = s.id_prod
					   And   b.cod_mag = sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' ) 
					 )
				*/
		End 'Nom_PDV_ou_btq_centralisation',
		Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
				-- Then sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' ) [VDOC20161]
		End 'Num_PDV_ou_btq_centralisation',
		sysadm.FN_CODE_NUM ( c.id_gti, '-GA' ) + ' (' + Convert ( varchar ( 10), c.id_gti) + ')' lib_garantie,
		ISNULL ( 
			NullIf ( 		
				Convert ( Decimal ( 11,2 ), 
					ISNULL ( 
						nullif ( sysadm.FN_CLE_VAL ( 'MT_PEC', rtrim ( c.info_spb_frn_cplt ), ';'), ''),
						IsNull ( 
							( Select dd.val_mt
							  From sysadm.div_det dd
							  Where dd.id_sin = d.id_sin
							  And   dd.id_gti = d.id_gti
							  And   dd.id_detail = d.id_detail
							  And   dd.nom_zone = 'mt_pec' 
							),
							  0 )
					 	    )
					    )
					,-1
					) 
				,0 ) 
			+
			Case -- [PM462-1]
				When IsNumeric ( sysadm.FN_CLE_VAL ( 'MT_CPLT_PAYBOX_SCM', c.info_spb_frn_cplt, ';') ) > 0 
					Then Convert ( Decimal (11, 2 ), sysadm.FN_CLE_VAL ( 'MT_CPLT_PAYBOX_SCM', c.info_spb_frn_cplt, ';'))
				Else 0
			End	'mt_pec', -- [VDOC16011]
		Case 
			When sysadm.FN_CLE_VAL ( 'REMIS_EN_STK', RTRIM ( c.info_frn_spb_cplt ) , ';' ) = 'OUI' Then '[OUI]Presta ANNulée, matériel remis en stock chez le grossiste'
			Else ''
		End 'Remis_en_stk', -- [PM251-2]
		c.comment_frn, -- [PM251-2]
		Case 
			-- [PC151259]
			-- [PC151259-2]
			-- [PC171918]
			When Exists ( 
					Select	Top 1 1 
					From	sysadm.det_pro dp 
					where	dp.id_prod = s.id_prod 
					And		dp.id_code_dp = 252
					And		sysadm.FN_CLE_VAL ( 'VARIANTE', rtrim ( dp.val_car ) + rtrim ( dp.val_car2), ';') in ( 'FULL_SERENITY_ADV_5', 'ADVISE_6', 'ADVISE_7') -- [PC171918] -- [PC171933]
				 )
				 And c.id_four in ( 'BK2', 'EKO', 'DGC', 'NET', 'SMT', 'RAV', 'RTP', 'SFG' )
				Then
				'ADV'

			When Exists ( 
					Select	Top 1 1 
					From	sysadm.det_pro dp 
					where	dp.id_prod = s.id_prod 
					And		dp.id_code_dp = 252
					And		sysadm.FN_CLE_VAL ( 'VARIANTE', rtrim ( dp.val_car ) + rtrim ( dp.val_car2), ';') not in ( 'FULL_SERENITY_ADV_5', 'ADVISE_6', 'ADVISE_7' ) -- [PC151259] -- [PC171918] -- [PC171933]
				 )
				 And c.id_four in ( 'PSM', 'ADV', 'BK2' ) -- [DT076-2] BK2
				Then
				'ADV'
			When c.id_four = 'BLC' Then 'O2M'  -- [PM363-1]
			When sysadm.FN_CLE_VAL ( 'RS3220', c.info_spb_frn_cplt, ';' ) = 'TLS' Then 'TL1' -- [RS3220]
			Else
				c.id_four
		End 'A_regler_a', -- [DT076_V6]
		/*
		Case 
			When sysadm.FN_CLE_VAL ( 'CHGT_CM', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
			 Then 'OUI'
			Else 'NON'
		End*/ 'système jamais mis en production (PM295-1)' 'Chgt_Carte_Mere', -- [PM295-1]
		sysadm.FN_CLE_VAL ( 'NUM_CC_ELD', rtrim( c.info_spb_frn_cplt) , ';' ) 'Num_Carte_Cadeau',
		IsNull ( 
			( Select Top 1 ds.val_nbre 
			  From	sysadm.div_sin ds
			  Where ds.id_sin = s.id_sin
			  And   ds.nom_zone = 'tranche_tarif' )
			,0 ) 'tranche_tarif',
		Case sysadm.FN_CLE_VAL ( 'NEUF_REC', c.info_spb_frn_cplt, ';')
			When 'NEU' Then '[NEU] appareil de remplacement neuf'
			When 'REC' Then '[REC] appareil de remplacement reconditionné'
			Else sysadm.FN_CLE_VAL ( 'NEUF_REC', c.info_spb_frn_cplt, ';')
		End 'Neuf_Recond',
		IsNull ( 
			( Select MAX ( mt_plaf )
			  From	sysadm.plafond p
			  Where p.id_prod = s.id_prod
			  And	p.id_rev = s.id_rev
			  And   p.id_gti = c.id_gti
			  And   id_typ_plaf = 680
			), 0 ) 'plaf_680',
		IsNull ( c.id_bon_transp, '') 'num_tracking',
		'PRESTATION' 'type_enrg',
		null 'id_reg',
		null 'id_reg_base',
		null 'lib_reg',
		null 'mt_tot_reg',
		null 'dte_reg',
		null 'cod_inter',
		null 'cod_mot_reg',
		null 'nom_inter',
		null 'Ventilation_regl',
		IsNull ( 
			( Select sum ( rg.mt_reg ) -- [VDOC21248]
			  From sysadm.reglement r,
				   sysadm.reg_gti rg,
				   sysadm.commande c1,
				   sysadm.detail d
			  Where c1.id_sin = c.id_sin 
			  And   c1.id_seq = c.id_seq
			  And	d.id_sin = c1.id_sin
			  And	d.id_gti = c1.id_gti
			  And	d.id_detail = c1.id_detail
			  And	r.id_sin = d.id_sin
			  And   ( r.id_reg = d.id_reg or r.id_reg_base = d.id_reg )
			  And   r.cod_mot_reg not in ( 'RI' ) -- Modif le 26/12/16 JFF [20161226.1.JFF]
			  And   r.cod_mode_reg = 'FM' -- Modif le 26/12/16 JFF [20161226.1.JFF]
			  And   rg.id_sin = r.id_sin
			  And   rg.id_reg = r.id_reg
			  And   rg.id_gti > 0
			), 0 ) 'Mt_som_regle_sur_presta_hf', -- [VDOC21248]
		( Select (  -- [VDOC21248]
			  Select Cast (  'Mouv. Financié  ' + Convert ( varchar ( 10 ), rg.mt_reg ) + '€ le ' + Convert ( varchar ( 10), rg.cree_le, 103 ) + ' type ' + rtrim ( r.cod_mot_reg)+ ' # '  As Varchar ( 250 ))
			  From sysadm.reglement r,
				   sysadm.reg_gti rg,
				   sysadm.commande c1,
				   sysadm.detail d
			  Where c1.id_sin = c.id_sin 
			  And   c1.id_seq = c.id_seq
			  And	d.id_sin = c1.id_sin
			  And	d.id_gti = c1.id_gti
			  And	d.id_detail = c1.id_detail
			  And	r.id_sin = d.id_sin
			  And   ( r.id_reg = d.id_reg or r.id_reg_base = d.id_reg )
			  And   r.cod_mot_reg not in ( 'RI' ) -- Modif le 26/12/16 JFF [20161226.1.JFF]
			  And   r.cod_mode_reg = 'FM' -- Modif le 26/12/16 JFF [20161226.1.JFF]
			  And   rg.id_sin = r.id_sin
			  And   rg.id_reg = r.id_reg
			  And   rg.id_gti > 0
			  For XML Path ('')  )
		) 'Detail_regle_sur_presta_hf', -- [VDOC21248]
		( Select ( 		-- [PM251-5]
			Select CAST( '#' + rtrim ( cf.categorie ) + '#' AS VARCHAR(250)) 
			From   sysadm.ctg_factu cf 
			Where  cf.marq_app = c.id_marq_art_ifr
			And	   cf.modl_app = c.id_modl_art_ifr
			For XML PATH ('') 
		)) 'Categorie_Facturation', -- /[PM251-5]
		Case sysadm.FN_A_COMMANDER ( c.id_sin, c.id_seq, 'P' ) -- [PM251-4][M23697]
			When 'A_COMMANDER' Then 'REMPL'
			Else null
		End 'Remplacement',
		Case 
			When sysadm.FN_CLE_VAL ( 'SOUS_GC', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
			 Then 'OUI'
			Else 'NON'
		End 'Réparé_sous_gc' -- [PM383-1]

From	sysadm.sinistre s,
		sysadm.commande c,
		sysadm.detail d
Where	c.dte_env_cli between @dtDteDeb and @dtDteFin 
And		c.cod_etat in ( 'ANN', 'RPC', 'RFO', 'RSP' )
And     d.id_sin = c.id_sin
And     d.id_gti = c.id_gti
And     d.id_detail = c.id_detail
And		d.cod_etat <> 600 
And     s.id_sin = c.id_sin

Union all

Select
		sysadm.FN_AFF_DATE ( @dtDteDeb, 'AVEC_HEURE' ) 'dte_cloture',
		sysadm.FN_AFF_DATE ( @dtDteFin, 'AVEC_HEURE' ) 'fin_cloture',
		r.id_sin,
		null,
		null,
		null,
		s.id_prod,
		s.id_ets,
		s.id_adh,
		s.id_sdos,
		sysadm.FN_LIB_PROD ( s.id_prod ) lib_prod,
		sysadm.FN_LIB_POLICE (s.id_sin ) lib_police,
		sysadm.FN_LIB_CIE( s.id_sin ) lib_cie,
		IsNull ( ( select ds.val_car from sysadm.div_sin ds where ds.id_sin = s.id_sin and nom_zone = 'type_app' ), 'PAP') typ_app_sin,
		IsNull ( ( select sysadm.FN_CODE_CAR ( ds.val_car, '-AR') from sysadm.div_sin ds where ds.id_sin = s.id_sin and nom_zone = 'type_app' ),  sysadm.FN_CODE_CAR ( 'PAP', '-AR')) lib_typ_app_sin,
		s.dte_ach_port 'dte_achat',
		s.dte_surv,
		rtrim( s.marq_port )'marq_sin',
		rtrim( s.modl_port ) 'modl_sin',
		rtrim( s.num_imei_port ) 'imei_serie_sin',
		( Select Top 1 rtrim( i.sku_saga )
		  From	sysadm.ifr i
		  where	i.marque = s.marq_port
		  And	i.reference = s.modl_port ) sku_saga_sin,
		null lib_process,		  
		null 'process',
		null 'id_typ_art',
		null 'Pret',
		null 'action',
		null 'SAV',
		null 'IdSeq_orig_sav',
		null 'Retour_SAV',
		null 'id_ref_four',
		null 'typ_rupture_stock',
		null 'marq_fourn_cmde',
		null 'modl_fourn_cmde',
		null 'marq_ifr_cmde',
		null 'modl_ifr_cmde',
		null 'sku_saga_cmd',
		null 'mt_ttc_cmde',
		null 'imei_serie_nouv',
		( Select rtrim( i.nom ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Nom_Inter_Ass',
		( Select rtrim( i.adr_1 ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Adr1_inter_Ass',		
		( Select rtrim( i.adr_2 ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Adr2_inter_Ass',				
		( Select rtrim( i.adr_cp )  from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'AdrCp_inter_Ass',				
		( Select rtrim( i.adr_ville ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'AdrVille_inter_Ass',				
		null 'lib_status_gc',
		null 'cod_etat',
		null 'dte_fin_trait',
		null 'lib_etat',
		null 'Ass_en_pdv_ou_coli',
		null 'Nom_PDV_ou_btq_centralisation',
		null 'Num_PDV_ou_btq_centralisation',
		null 'lib_garantie',
		null 'mt_pec', -- [VDOC16011]
		null 'Remis_en_stk', -- [PM251-2]
		null 'comment_frn', -- [PM251-2]
		null 'A_regler_a', -- [DT076_V6]
		null 'Chgt_Carte_Mere', -- [PM295-1]
		null 'Num_Carte_Cadeau',
		IsNull ( 
			( Select Top 1 ds.val_nbre 
			  From	sysadm.div_sin ds
			  Where ds.id_sin = s.id_sin
			  And   ds.nom_zone = 'tranche_tarif' )
			,0 ) 'tranche_tarif',
		null 'Neuf_Recond',
		null 'plaf_680',
		null 'num_tracking',
		'MVT_FINANCIER' 'type_enrg', -- [PM251-4]
		r.id_reg,
		r.id_reg_base,
		r.lib_reg,
		r.mt_tot_reg,
		sysadm.FN_AFF_DATE ( r.dte_reg, 'SH' ) 'dte_reg',
		sysadm.FN_CODE_CAR ( r.cod_inter, '-IN' ) 'cod_inter',
		r.cod_mot_reg,
		Case cod_mode_reg
			When 'FM' Then ( Select sysadm.FN_CODE_CAR ( i.id_four, '-FR' )
							 From   sysadm.inter i
							 Where  i.id_sin = r.id_sin
							 And    i.id_i = r.id_i)
			Else (  Select i.nom
					From   sysadm.inter i
					Where  i.id_sin = r.id_sin
					And    i.id_i = r.id_i )
		End,
		( Select ( 
				Select Cast (  'Mouv. Financié sur ' + sysadm.FN_CODE_NUM ( rg.id_gti, '-GS' ) + '  ' + Convert ( varchar ( 10 ), rg.mt_reg ) + '€ le ' + Convert ( varchar ( 10), rg.cree_le, 103 ) + ' type ' + rtrim ( r.cod_mot_reg)+ ' # '  As Varchar ( 250 ))
				From sysadm.reglement r1,
					 sysadm.reg_gti rg
				Where r1.id_sin = s.id_sin 
				And   r1.id_reg = r.id_reg
				And   r1.cree_le between @dtDteDeb and @dtDteFin
				And   r1.cod_mot_reg <> 'RI'
				And   rg.id_sin = r1.id_sin
				And   rg.id_reg = r1.id_reg
			    For XML Path ('')  )
		) 'Ventilation_regl',
		null 'Mt_som_regle_sur_presta_hf',
		null 'Detail_regle_sur_presta_hf',
		null 'Categorie_Facturation', -- /[PM251-5]
		Case
			When Exists ( 
					Select Top 1 1 
					From	sysadm.detail d,
							sysadm.commande c
					Where	d.id_sin = r.id_sin
					and		d.id_reg = r.id_reg
					And		c.id_sin = d.id_sin
					And		c.id_gti = d.id_gti
					And		c.id_detail = d.id_detail
					And		sysadm.FN_A_COMMANDER ( c.id_sin, c.id_seq, 'P' ) = 'A_COMMANDER'
				) 
				Then 'REMPL'
		End 'Remplacement', -- [PM251-4][M23697]
		null 'Réparé_sous_gc' -- [PM383-1]

From	sysadm.reglement r,
		sysadm.sinistre s
Where   r.cree_le between @dtDteDeb and @dtDteFin
And		r.cod_mot_reg <> 'RI'
And		s.id_sin = r.id_sin
And		Exists ( Select Top 1 1
				 From sysadm.commande_type ct
				 Where ct.id_prod = s.id_prod )
And		Not Exists ( 
			Select Top 1 1 
			From sysadm.reg_gti rg
			Where rg.id_sin = r.id_sin
			And   rg.id_reg = r.id_reg
			And   rg.id_gti = 8
			And   rg.mt_reg = r.mt_tot_reg
		)
And		Not Exists ( 
			Select Top 1 1 
			From sysadm.reg_gti rg
			Where rg.id_sin = r.id_sin
			And   rg.id_reg = r.id_reg
			And   rg.id_gti = -1
			And   rg.mt_reg = r.mt_tot_reg
		)
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S01_PRE_FACTU_PM251_MASSE_REGL_ET_NREGL
-- Auteur               :       JFF
-- Date                 :       13/09/2018
-- Libelle              :       
-- Commentaires         :       [PM251-1][VDOC26763]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF	13/09/2018	VDOC26763
-- JFF  07/08/2019  [PM462-1]
-- JFF  25/08/2022  [RS3220] TELSTORE O2M=>TLS=>TL1
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_PRE_FACTU_PM251_MASSE_REGL_ET_NREGL' AND type = 'P' )
        DROP procedure sysadm.PS_S01_PRE_FACTU_PM251_MASSE_REGL_ET_NREGL
GO

CREATE procedure sysadm.PS_S01_PRE_FACTU_PM251_MASSE_REGL_ET_NREGL
        @dtDteDeb		 DateTime, -- Utilisé si @dcIdSin à null
        @dtDteFin		 DateTime -- Utilisé si @dcIdSin à null
AS

Select  sysadm.FN_AFF_DATE ( @dtDteDeb, 'AVEC_HEURE' ) 'dte_cloture',
		sysadm.FN_AFF_DATE ( @dtDteFin, 'AVEC_HEURE' ) 'fin_cloture',
		c.id_sin,
		c.id_seq,
		c.id_four,
		sysadm.FN_CODE_CAR ( c.id_four, '-FR' ) lib_four,
		s.id_prod,
		s.id_ets,
		s.id_adh,
		s.id_sdos,
		sysadm.FN_LIB_PROD ( s.id_prod ) lib_prod,
		sysadm.FN_GET_LIB_POLICE_V01 ( s.id_sin, s.id_prod, s.id_rev, c.id_gti, null ) lib_police,
		sysadm.FN_LIB_CIE( s.id_sin ) lib_cie,
		( select ds.val_car from sysadm.div_sin ds where ds.id_sin = s.id_sin and nom_zone = 'type_app' ) typ_app_sin,
		( select sysadm.FN_CODE_CAR ( ds.val_car, '-AR') from sysadm.div_sin ds where ds.id_sin = s.id_sin and nom_zone = 'type_app' ) lib_typ_app_sin,
		s.dte_ach_port 'dte_achat',
		s.dte_surv,
		rtrim( s.marq_port )'marq_sin',
		rtrim( s.modl_port ) 'modl_sin',
		rtrim( s.num_imei_port ) 'imei_serie_sin',
		( Select Top 1 rtrim( i.sku_saga )
		  From	sysadm.ifr i
		  where	i.marque = s.marq_port
		  And	i.reference = s.modl_port ) sku_saga_sin,
		rtrim( sysadm.FN_CODE_NUM ( c.info_spb_frn, '-IF' )) + ' (' + Convert ( varchar ( 10), c.info_spb_frn ) + ')' 'lib_process',		  
		c.info_spb_frn 'process',
		c.id_typ_art 'id_typ_art',
		Case 
			When c.cod_etat <> 'ANN' And c.status_gc <> 176 And c.id_gti <> 10 And sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'PRET' Then 'PRET'
		End 'Pret',
		Case 
			When c.id_typ_art = 'EDI' Then c.id_ref_four
			When c.id_typ_art = 'PRS' Then 'REPARATION/DESOXYDATION'
			When c.id_typ_art not in ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' )		
				 Or 
				 ( c.id_typ_art in ( 'RST' ) And sysadm.FN_CLE_VAL ( 'RST_CMDE+SUIVI', rtrim ( c.info_spb_frn_cplt), ';'  ) = 'OUI' )  Then 'A_COMMANDER'
			Else sysadm.FN_CODE_CAR ( c.id_typ_art, '-AR' )
		End 'action',
		Case 
			When sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Mode SAV Réparation'
			When sysadm.FN_CLE_VAL ( 'A_DESOXYDER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Mode SAV Désoxydation'
 			When sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Mode Garantie App. Rempl.'
 			When sysadm.FN_CLE_VAL ( 'A_CONTROLER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Mode 2ème SAV pour Ctrle'
			Else ''
		End 'SAV',
		Case 
			When sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Or
				 sysadm.FN_CLE_VAL ( 'A_DESOXYDER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' 
				 Then
				 ( Select max ( c1.id_seq )
				   From	  sysadm.commande c1
				   Where  c1.id_sin = c.id_sin
				   and    c1.id_seq < c.id_seq
				   And    c1.id_ref_four in (  'A_REPARER', 'A_DESOXYDER' )
				   And    c1.status_gc in ( 2,22,21,23 )
				   And    c1.cod_etat <> 'ANN'
				 ) 
		End 'IdSeq_orig_sav',
		Case 
			when CharIndex ( '[SAV_NO_OK]', c.comment_frn, 1 ) > 0 Then 'SAV_NO_OK'
			Else ''
		End 'Retour_SAV',
		c.id_ref_four,
		Case 
			When sysadm.FN_CLE_VAL ( 'RST_CMDE+SUIVI', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Rupture de Stock avec Commande de Remplacement + Suivi'
			When sysadm.FN_CLE_VAL ( 'RST_INFO_SIMPLE', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Rupture de Stock pour information'			
			Else ''
		End 'typ_rupture_stock',
		rtrim( c.id_marq_art ) 'marq_fourn_cmde',
		rtrim( c.id_modl_art ) 'modl_fourn_cmde',
		rtrim( c.id_marq_art_ifr ) 'marq_ifr_cmde',
		rtrim( c.id_modl_art_ifr ) 'modl_ifr_cmde',
		( Select Top 1 rtrim( i.sku_saga )
		  From	sysadm.ifr i
		  where	i.marque = c.id_marq_art_ifr
		  And	i.reference = c.id_modl_art_ifr ) sku_saga_cmd,
		Case
			When IsNumeric ( sysadm.FN_CLE_VAL ( 'PRIX_TTC_FACTU_O2M', rtrim ( info_frn_spb_cplt ) , ';' )) = 1 Then
				 CONVERT( decimal ( 11,2), replace ( sysadm.FN_CLE_VAL ( 'PRIX_TTC_FACTU_O2M', rtrim ( info_frn_spb_cplt ) , ';' ), ',', '.' ))
			Else c.mt_ttc_cmde
		End mt_ttc_cmde,
		c.id_serie_nouv 'imei_serie_nouv',
		( Select rtrim( i.nom ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Nom_Inter_Ass',
		( Select rtrim( i.adr_1 ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Adr1_inter_Ass',		
		( Select rtrim( i.adr_2 ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Adr2_inter_Ass',				
		( Select rtrim( i.adr_cp )  from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'AdrCp_inter_Ass',				
		( Select rtrim( i.adr_ville ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'AdrVille_inter_Ass',				
		rtrim( sysadm.FN_CODE_NUM ( c.status_gc, '-GC' ) + ' (' + Convert ( varchar ( 10), c.status_gc) + ')' ) lib_status_gc,
		c.cod_etat,
		c.dte_env_cli 'dte_fin_trait',
		Case 
			When c.cod_etat in ( 'RPC', 'RFO', 'RSP' ) Then 'CLOTUREE (' + rtrim ( c.cod_etat) + ')'
			When c.cod_etat in ( 'ANN' ) Then 'ANNULEE (' + rtrim ( c.cod_etat) + ')'
			Else sysadm.FN_CODE_CAR ( c.cod_etat, '-EC' )
		End lib_etat,
		Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré en pointe de vente'
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré envoie coli en centralisation'
		End 'Ass_en_pdv_ou_coli',
		Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
				/* [VDOC20161]
				Then ( Select Top 1 b.adr_nom
					   From sysadm.boutique b
					   Where b.id_prod = s.id_prod
					   And   b.cod_mag = sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' ) 
					 )
				*/
		End 'Nom_PDV_ou_btq_centralisation',
		Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
				-- Then sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' ) [VDOC20161]
		End 'Num_PDV_ou_btq_centralisation',
		sysadm.FN_CODE_NUM ( c.id_gti, '-GA' ) + ' (' + Convert ( varchar ( 10), c.id_gti) + ')' lib_garantie,
		ISNULL ( 
			NullIf ( 		
				Convert ( Decimal ( 11,2 ), 
					ISNULL ( 
						nullif ( sysadm.FN_CLE_VAL ( 'MT_PEC', rtrim ( c.info_spb_frn_cplt ), ';'), ''),
						IsNull ( 
							( Select dd.val_mt
							  From sysadm.div_det dd
							  Where dd.id_sin = d.id_sin
							  And   dd.id_gti = d.id_gti
							  And   dd.id_detail = d.id_detail
							  And   dd.nom_zone = 'mt_pec' 
							),
							  0 )
					 	    )
					    )
					,-1
					) 
				,0 ) 
			+
			Case -- [PM462-1]
				When IsNumeric ( sysadm.FN_CLE_VAL ( 'MT_CPLT_PAYBOX_SCM', c.info_spb_frn_cplt, ';') ) > 0 
					Then Convert ( Decimal (11, 2 ), sysadm.FN_CLE_VAL ( 'MT_CPLT_PAYBOX_SCM', c.info_spb_frn_cplt, ';'))
				Else 0
			End	'mt_pec', -- [VDOC16011]
		Case 
			When sysadm.FN_CLE_VAL ( 'REMIS_EN_STK', RTRIM ( c.info_frn_spb_cplt ) , ';' ) = 'OUI' Then '[OUI]Presta ANNulée, matériel remis en stock chez le grossiste'
			Else ''
		End 'Remis_en_stk', -- [PM251-2]
		c.comment_frn, -- [PM251-2]
		Case 
			-- [PC151259]
			-- [PC151259-2]
			-- [PC171918]
			When Exists ( 
					Select	Top 1 1 
					From	sysadm.det_pro dp 
					where	dp.id_prod = s.id_prod 
					And		dp.id_code_dp = 252
					And		sysadm.FN_CLE_VAL ( 'VARIANTE', rtrim ( dp.val_car ) + rtrim ( dp.val_car2), ';') in ( 'FULL_SERENITY_ADV_5', 'ADVISE_6', 'ADVISE_7') -- [PC171918] -- [PC171933]
				 )
				 And c.id_four in ( 'BK2', 'EKO', 'DGC', 'NET', 'SMT', 'RAV', 'RTP', 'SFG' )
				Then
				'ADV'

			When Exists ( 
					Select	Top 1 1 
					From	sysadm.det_pro dp 
					where	dp.id_prod = s.id_prod 
					And		dp.id_code_dp = 252
					And		sysadm.FN_CLE_VAL ( 'VARIANTE', rtrim ( dp.val_car ) + rtrim ( dp.val_car2), ';') not in ( 'FULL_SERENITY_ADV_5', 'ADVISE_6', 'ADVISE_7' ) -- [PC151259] -- [PC171918] -- [PC171933]
				 )
				 And c.id_four in ( 'PSM', 'ADV', 'BK2' ) -- [DT076-2] BK2
				Then
				'ADV'
			When c.id_four = 'BLC' Then 'O2M'  -- [PM363-1]
			When sysadm.FN_CLE_VAL ( 'RS3220', c.info_spb_frn_cplt, ';' ) = 'TLS' Then 'TL1' -- [RS3220]
			Else
				c.id_four
		End 'A_regler_a', -- [DT076_V6]
		/*
		Case 
			When sysadm.FN_CLE_VAL ( 'CHGT_CM', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
			 Then 'OUI'
			Else 'NON'
		End*/ 'système jamais mis en production (PM295-1)' 'Chgt_Carte_Mere', -- [PM295-1]
		sysadm.FN_CLE_VAL ( 'NUM_CC_ELD', rtrim( c.info_spb_frn_cplt) , ';' ) 'Num_Carte_Cadeau',
		IsNull ( 
			( Select Top 1 ds.val_nbre 
			  From	sysadm.div_sin ds
			  Where ds.id_sin = s.id_sin
			  And   ds.nom_zone = 'tranche_tarif' )
			,0 ) 'tranche_tarif',
		Case sysadm.FN_CLE_VAL ( 'NEUF_REC', c.info_spb_frn_cplt, ';')
			When 'NEU' Then '[NEU] appareil de remplacement neuf'
			When 'REC' Then '[REC] appareil de remplacement reconditionné'
			Else sysadm.FN_CLE_VAL ( 'NEUF_REC', c.info_spb_frn_cplt, ';')
		End 'Neuf_Recond',
		IsNull ( 
			( Select MAX ( mt_plaf )
			  From	sysadm.plafond p
			  Where p.id_prod = s.id_prod
			  And	p.id_rev = s.id_rev
			  And   p.id_gti = c.id_gti
			  And   id_typ_plaf = 680
			), 0 ) 'plaf_680',
		IsNull ( c.id_bon_transp, '') 'num_tracking',
		'PRESTATION' 'type_enrg',
		null 'id_reg',
		null 'id_reg_base',
		null 'lib_reg',
		null 'mt_tot_reg',
		null 'dte_reg',
		null 'cod_inter',
		null 'cod_mot_reg',
		null 'nom_inter',
		null 'Ventilation_regl',
		IsNull ( 
			( Select sum ( rg.mt_reg ) -- [VDOC21248]
			  From sysadm.reglement r,
				   sysadm.reg_gti rg,
				   sysadm.commande c1,
				   sysadm.detail d
			  Where c1.id_sin = c.id_sin 
			  And   c1.id_seq = c.id_seq
			  And	d.id_sin = c1.id_sin
			  And	d.id_gti = c1.id_gti
			  And	d.id_detail = c1.id_detail
			  And	r.id_sin = d.id_sin
			  And   ( r.id_reg = d.id_reg or r.id_reg_base = d.id_reg )
			  And   r.cod_mot_reg not in ( 'RI' ) -- Modif le 26/12/16 JFF [20161226.1.JFF]
			  And   r.cod_mode_reg = 'FM' -- Modif le 26/12/16 JFF [20161226.1.JFF]
			  And   rg.id_sin = r.id_sin
			  And   rg.id_reg = r.id_reg
			  And   rg.id_gti > 0
			), 0 ) 'Mt_som_regle_sur_presta_hf', -- [VDOC21248]
		( Select (  -- [VDOC21248]
			  Select Cast (  'Mouv. Financié  ' + Convert ( varchar ( 10 ), rg.mt_reg ) + '€ le ' + Convert ( varchar ( 10), rg.cree_le, 103 ) + ' type ' + rtrim ( r.cod_mot_reg)+ ' # '  As Varchar ( 250 ))
			  From sysadm.reglement r,
				   sysadm.reg_gti rg,
				   sysadm.commande c1,
				   sysadm.detail d
			  Where c1.id_sin = c.id_sin 
			  And   c1.id_seq = c.id_seq
			  And	d.id_sin = c1.id_sin
			  And	d.id_gti = c1.id_gti
			  And	d.id_detail = c1.id_detail
			  And	r.id_sin = d.id_sin
			  And   ( r.id_reg = d.id_reg or r.id_reg_base = d.id_reg )
			  And   r.cod_mot_reg not in ( 'RI' ) -- Modif le 26/12/16 JFF [20161226.1.JFF]
			  And   r.cod_mode_reg = 'FM' -- Modif le 26/12/16 JFF [20161226.1.JFF]
			  And   rg.id_sin = r.id_sin
			  And   rg.id_reg = r.id_reg
			  And   rg.id_gti > 0
			  For XML Path ('')  )
		) 'Detail_regle_sur_presta_hf', -- [VDOC21248]
		( Select ( 		-- [PM251-5]
			Select CAST( '#' + rtrim ( cf.categorie ) + '#' AS VARCHAR(250)) 
			From   sysadm.ctg_factu cf 
			Where  cf.marq_app = c.id_marq_art_ifr
			And	   cf.modl_app = c.id_modl_art_ifr
			For XML PATH ('') 
		)) 'Categorie_Facturation', -- /[PM251-5]
		Case sysadm.FN_A_COMMANDER ( c.id_sin, c.id_seq, 'P' ) -- [PM251-4][M23697]
			When 'A_COMMANDER' Then 'REMPL'
			Else null
		End 'Remplacement',
		Case 
			When sysadm.FN_CLE_VAL ( 'SOUS_GC', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
			 Then 'OUI'
			Else 'NON'
		End 'Réparé_sous_gc' -- [PM383-1]

From	sysadm.sinistre s,
		sysadm.commande c,
		sysadm.detail d
Where	c.dte_env_cli between @dtDteDeb and @dtDteFin 
And		c.cod_etat in ( 'ANN', 'RPC', 'RFO', 'RSP' )
And     d.id_sin = c.id_sin
And     d.id_gti = c.id_gti
And     d.id_detail = c.id_detail
And     s.id_sin = c.id_sin

Union all

Select
		sysadm.FN_AFF_DATE ( @dtDteDeb, 'AVEC_HEURE' ) 'dte_cloture',
		sysadm.FN_AFF_DATE ( @dtDteFin, 'AVEC_HEURE' ) 'fin_cloture',
		r.id_sin,
		null,
		null,
		null,
		s.id_prod,
		s.id_ets,
		s.id_adh,
		s.id_sdos,
		sysadm.FN_LIB_PROD ( s.id_prod ) lib_prod,
		sysadm.FN_LIB_POLICE (s.id_sin ) lib_police,
		sysadm.FN_LIB_CIE( s.id_sin ) lib_cie,
		IsNull ( ( select ds.val_car from sysadm.div_sin ds where ds.id_sin = s.id_sin and nom_zone = 'type_app' ), 'PAP') typ_app_sin,
		IsNull ( ( select sysadm.FN_CODE_CAR ( ds.val_car, '-AR') from sysadm.div_sin ds where ds.id_sin = s.id_sin and nom_zone = 'type_app' ),  sysadm.FN_CODE_CAR ( 'PAP', '-AR')) lib_typ_app_sin,
		s.dte_ach_port 'dte_achat',
		s.dte_surv,
		rtrim( s.marq_port )'marq_sin',
		rtrim( s.modl_port ) 'modl_sin',
		rtrim( s.num_imei_port ) 'imei_serie_sin',
		( Select Top 1 rtrim( i.sku_saga )
		  From	sysadm.ifr i
		  where	i.marque = s.marq_port
		  And	i.reference = s.modl_port ) sku_saga_sin,
		null lib_process,		  
		null 'process',
		null 'id_typ_art',
		null 'Pret',
		null 'action',
		null 'SAV',
		null 'IdSeq_orig_sav',
		null 'Retour_SAV',
		null 'id_ref_four',
		null 'typ_rupture_stock',
		null 'marq_fourn_cmde',
		null 'modl_fourn_cmde',
		null 'marq_ifr_cmde',
		null 'modl_ifr_cmde',
		null 'sku_saga_cmd',
		null 'mt_ttc_cmde',
		null 'imei_serie_nouv',
		( Select rtrim( i.nom ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Nom_Inter_Ass',
		( Select rtrim( i.adr_1 ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Adr1_inter_Ass',		
		( Select rtrim( i.adr_2 ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Adr2_inter_Ass',				
		( Select rtrim( i.adr_cp )  from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'AdrCp_inter_Ass',				
		( Select rtrim( i.adr_ville ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'AdrVille_inter_Ass',				
		null 'lib_status_gc',
		null 'cod_etat',
		null 'dte_fin_trait',
		null 'lib_etat',
		null 'Ass_en_pdv_ou_coli',
		null 'Nom_PDV_ou_btq_centralisation',
		null 'Num_PDV_ou_btq_centralisation',
		null 'lib_garantie',
		null 'mt_pec', -- [VDOC16011]
		null 'Remis_en_stk', -- [PM251-2]
		null 'comment_frn', -- [PM251-2]
		null 'A_regler_a', -- [DT076_V6]
		null 'Chgt_Carte_Mere', -- [PM295-1]
		null 'Num_Carte_Cadeau',
		IsNull ( 
			( Select Top 1 ds.val_nbre 
			  From	sysadm.div_sin ds
			  Where ds.id_sin = s.id_sin
			  And   ds.nom_zone = 'tranche_tarif' )
			,0 ) 'tranche_tarif',
		null 'Neuf_Recond',
		null 'plaf_680',
		null 'num_tracking',
		'MVT_FINANCIER' 'type_enrg', -- [PM251-4]
		r.id_reg,
		r.id_reg_base,
		r.lib_reg,
		r.mt_tot_reg,
		sysadm.FN_AFF_DATE ( r.dte_reg, 'SH' ) 'dte_reg',
		sysadm.FN_CODE_CAR ( r.cod_inter, '-IN' ) 'cod_inter',
		r.cod_mot_reg,
		Case cod_mode_reg
			When 'FM' Then ( Select sysadm.FN_CODE_CAR ( i.id_four, '-FR' )
							 From   sysadm.inter i
							 Where  i.id_sin = r.id_sin
							 And    i.id_i = r.id_i)
			Else (  Select i.nom
					From   sysadm.inter i
					Where  i.id_sin = r.id_sin
					And    i.id_i = r.id_i )
		End,
		( Select ( 
				Select Cast (  'Mouv. Financié sur ' + sysadm.FN_CODE_NUM ( rg.id_gti, '-GS' ) + '  ' + Convert ( varchar ( 10 ), rg.mt_reg ) + '€ le ' + Convert ( varchar ( 10), rg.cree_le, 103 ) + ' type ' + rtrim ( r.cod_mot_reg)+ ' # '  As Varchar ( 250 ))
				From sysadm.reglement r1,
					 sysadm.reg_gti rg
				Where r1.id_sin = s.id_sin 
				And   r1.id_reg = r.id_reg
				And   r1.cree_le between @dtDteDeb and @dtDteFin
				And   r1.cod_mot_reg <> 'RI'
				And   rg.id_sin = r1.id_sin
				And   rg.id_reg = r1.id_reg
			    For XML Path ('')  )
		) 'Ventilation_regl',
		null 'Mt_som_regle_sur_presta_hf',
		null 'Detail_regle_sur_presta_hf',
		null 'Categorie_Facturation', -- /[PM251-5]
		Case
			When Exists ( 
					Select Top 1 1 
					From	sysadm.detail d,
							sysadm.commande c
					Where	d.id_sin = r.id_sin
					and		d.id_reg = r.id_reg
					And		c.id_sin = d.id_sin
					And		c.id_gti = d.id_gti
					And		c.id_detail = d.id_detail
					And		sysadm.FN_A_COMMANDER ( c.id_sin, c.id_seq, 'P' ) = 'A_COMMANDER'
				) 
				Then 'REMPL'
		End 'Remplacement', -- [PM251-4][M23697]
		null 'Réparé_sous_gc' -- [PM383-1]

From	sysadm.reglement r,
		sysadm.sinistre s
Where   r.cree_le between @dtDteDeb and @dtDteFin
And		r.cod_mot_reg <> 'RI'
And		s.id_sin = r.id_sin
And		Exists ( Select Top 1 1
				 From sysadm.commande_type ct
				 Where ct.id_prod = s.id_prod )
And		Not Exists ( 
			Select Top 1 1 
			From sysadm.reg_gti rg
			Where rg.id_sin = r.id_sin
			And   rg.id_reg = r.id_reg
			And   rg.id_gti = 8
			And   rg.mt_reg = r.mt_tot_reg
		)
And		Not Exists ( 
			Select Top 1 1 
			From sysadm.reg_gti rg
			Where rg.id_sin = r.id_sin
			And   rg.id_reg = r.id_reg
			And   rg.id_gti = -1
			And   rg.mt_reg = r.mt_tot_reg
		)


Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S01_PRE_FACTU_PM251_UNITAIRE_NREGL
-- Auteur               :       JFF
-- Date                 :       13/09/2018
-- Libelle              :       
-- Commentaires         :       [PM251-1][VDOC26763]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF	13/09/2018	VDOC26763
-- JFF  07/08/2019  [PM462-1]
-- JFF  25/08/2022  [RS3220] TELSTORE O2M=>TLS=>TL1
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_PRE_FACTU_PM251_UNITAIRE_NREGL' AND type = 'P' )
        DROP procedure sysadm.PS_S01_PRE_FACTU_PM251_UNITAIRE_NREGL
GO

CREATE procedure sysadm.PS_S01_PRE_FACTU_PM251_UNITAIRE_NREGL
       @dcIdSin		Decimal ( 10 ), -- [PI062] -- null pour le traitement standard, sinon un id_sin pour un sinistre précis
       @iIdSeq		Integer -- idem l'id_seq lié à l'id_sin, sinon null

AS

Select  '' 'dte_cloture',
		'' 'fin_cloture',
		c.id_sin,
		c.id_seq,
		c.id_four,
		sysadm.FN_CODE_CAR ( c.id_four, '-FR' ) lib_four,
		s.id_prod,
		s.id_ets,
		s.id_adh,
		s.id_sdos,
		sysadm.FN_LIB_PROD ( s.id_prod ) lib_prod,
		sysadm.FN_GET_LIB_POLICE_V01 ( s.id_sin, s.id_prod, s.id_rev, c.id_gti, null ) lib_police,
		sysadm.FN_LIB_CIE( s.id_sin ) lib_cie,
		( select ds.val_car from sysadm.div_sin ds where ds.id_sin = s.id_sin and nom_zone = 'type_app' ) typ_app_sin,
		( select sysadm.FN_CODE_CAR ( ds.val_car, '-AR') from sysadm.div_sin ds where ds.id_sin = s.id_sin and nom_zone = 'type_app' ) lib_typ_app_sin,
		s.dte_ach_port 'dte_achat',
		s.dte_surv,
		rtrim( s.marq_port )'marq_sin',
		rtrim( s.modl_port ) 'modl_sin',
		rtrim( s.num_imei_port ) 'imei_serie_sin',
		( Select Top 1 rtrim( i.sku_saga )
		  From	sysadm.ifr i
		  where	i.marque = s.marq_port
		  And	i.reference = s.modl_port ) sku_saga_sin,
		rtrim( sysadm.FN_CODE_NUM ( c.info_spb_frn, '-IF' )) + ' (' + Convert ( varchar ( 10), c.info_spb_frn ) + ')' 'lib_process',		  
		c.info_spb_frn 'process',
		c.id_typ_art 'id_typ_art',
		Case 
			When c.cod_etat <> 'ANN' And c.status_gc <> 176 And c.id_gti <> 10 And sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'PRET' Then 'PRET'
		End 'Pret',
		Case 
			When c.id_typ_art = 'EDI' Then c.id_ref_four
			When c.id_typ_art = 'PRS' Then 'REPARATION/DESOXYDATION'
			When c.id_typ_art not in ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' )		
				 Or 
				 ( c.id_typ_art in ( 'RST' ) And sysadm.FN_CLE_VAL ( 'RST_CMDE+SUIVI', rtrim ( c.info_spb_frn_cplt), ';'  ) = 'OUI' )  Then 'A_COMMANDER'
			Else sysadm.FN_CODE_CAR ( c.id_typ_art, '-AR' )
		End 'action',
		Case 
			When sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Mode SAV Réparation'
			When sysadm.FN_CLE_VAL ( 'A_DESOXYDER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Mode SAV Désoxydation'
 			When sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Mode Garantie App. Rempl.'
 			When sysadm.FN_CLE_VAL ( 'A_CONTROLER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Mode 2ème SAV pour Ctrle'
			Else ''
		End 'SAV',
		Case 
			When sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Or
				 sysadm.FN_CLE_VAL ( 'A_DESOXYDER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' 
				 Then
				 ( Select max ( c1.id_seq )
				   From	  sysadm.commande c1
				   Where  c1.id_sin = c.id_sin
				   and    c1.id_seq < c.id_seq
				   And    c1.id_ref_four in (  'A_REPARER', 'A_DESOXYDER' )
				   And    c1.status_gc in ( 2,22,21,23 )
				   And    c1.cod_etat <> 'ANN'
				 ) 
		End 'IdSeq_orig_sav',
		Case 
			when CharIndex ( '[SAV_NO_OK]', c.comment_frn, 1 ) > 0 Then 'SAV_NO_OK'
			Else ''
		End 'Retour_SAV',
		c.id_ref_four,
		Case 
			When sysadm.FN_CLE_VAL ( 'RST_CMDE+SUIVI', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Rupture de Stock avec Commande de Remplacement + Suivi'
			When sysadm.FN_CLE_VAL ( 'RST_INFO_SIMPLE', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Rupture de Stock pour information'			
			Else ''
		End 'typ_rupture_stock',
		rtrim( c.id_marq_art ) 'marq_fourn_cmde',
		rtrim( c.id_modl_art ) 'modl_fourn_cmde',
		rtrim( c.id_marq_art_ifr ) 'marq_ifr_cmde',
		rtrim( c.id_modl_art_ifr ) 'modl_ifr_cmde',
		( Select Top 1 rtrim( i.sku_saga )
		  From	sysadm.ifr i
		  where	i.marque = c.id_marq_art_ifr
		  And	i.reference = c.id_modl_art_ifr ) sku_saga_cmd,
		Case
			When IsNumeric ( sysadm.FN_CLE_VAL ( 'PRIX_TTC_FACTU_O2M', rtrim ( info_frn_spb_cplt ) , ';' )) = 1 Then
				 CONVERT( decimal ( 11,2), replace ( sysadm.FN_CLE_VAL ( 'PRIX_TTC_FACTU_O2M', rtrim ( info_frn_spb_cplt ) , ';' ), ',', '.' ))
			Else c.mt_ttc_cmde
		End mt_ttc_cmde,
		c.id_serie_nouv 'imei_serie_nouv',
		( Select rtrim( i.nom ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Nom_Inter_Ass',
		( Select rtrim( i.adr_1 ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Adr1_inter_Ass',		
		( Select rtrim( i.adr_2 ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Adr2_inter_Ass',				
		( Select rtrim( i.adr_cp )  from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'AdrCp_inter_Ass',				
		( Select rtrim( i.adr_ville ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'AdrVille_inter_Ass',				
		rtrim( sysadm.FN_CODE_NUM ( c.status_gc, '-GC' ) + ' (' + Convert ( varchar ( 10), c.status_gc) + ')' ) lib_status_gc,
		c.cod_etat,
		c.dte_env_cli 'dte_fin_trait',
		Case 
			When c.cod_etat in ( 'RPC', 'RFO', 'RSP' ) Then 'CLOTUREE (' + rtrim ( c.cod_etat) + ')'
			When c.cod_etat in ( 'ANN' ) Then 'ANNULEE (' + rtrim ( c.cod_etat) + ')'
			Else sysadm.FN_CODE_CAR ( c.cod_etat, '-EC' )
		End lib_etat,
		Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré en pointe de vente'
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré envoie coli en centralisation'
		End 'Ass_en_pdv_ou_coli',
		Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
				/* [VDOC20161]
				Then ( Select Top 1 b.adr_nom
					   From sysadm.boutique b
					   Where b.id_prod = s.id_prod
					   And   b.cod_mag = sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' ) 
					 )
				*/
		End 'Nom_PDV_ou_btq_centralisation',
		Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
				-- Then sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' ) [VDOC20161]
		End 'Num_PDV_ou_btq_centralisation',
		sysadm.FN_CODE_NUM ( c.id_gti, '-GA' ) + ' (' + Convert ( varchar ( 10), c.id_gti) + ')' lib_garantie,
		ISNULL ( 
			NullIf ( 		
				Convert ( Decimal ( 11,2 ), 
					ISNULL ( 
						nullif ( sysadm.FN_CLE_VAL ( 'MT_PEC', rtrim ( c.info_spb_frn_cplt ), ';'), ''),
						IsNull ( 
							( Select dd.val_mt
							  From sysadm.div_det dd
							  Where dd.id_sin = d.id_sin
							  And   dd.id_gti = d.id_gti
							  And   dd.id_detail = d.id_detail
							  And   dd.nom_zone = 'mt_pec' 
							),
							  0 )
					 	    )
					    )
					,-1
					) 
				,0 ) 
			+
			Case -- [PM462-1]
				When IsNumeric ( sysadm.FN_CLE_VAL ( 'MT_CPLT_PAYBOX_SCM', c.info_spb_frn_cplt, ';') ) > 0 
					Then Convert ( Decimal (11, 2 ), sysadm.FN_CLE_VAL ( 'MT_CPLT_PAYBOX_SCM', c.info_spb_frn_cplt, ';'))
				Else 0
			End	'mt_pec', -- [VDOC16011]
		Case 
			When sysadm.FN_CLE_VAL ( 'REMIS_EN_STK', RTRIM ( c.info_frn_spb_cplt ) , ';' ) = 'OUI' Then '[OUI]Presta ANNulée, matériel remis en stock chez le grossiste'
			Else ''
		End 'Remis_en_stk', -- [PM251-2]
		c.comment_frn, -- [PM251-2]
		Case 
			-- [PC151259]
			-- [PC151259-2]
			-- [PC171918]
			When Exists ( 
					Select	Top 1 1 
					From	sysadm.det_pro dp 
					where	dp.id_prod = s.id_prod 
					And		dp.id_code_dp = 252
					And		sysadm.FN_CLE_VAL ( 'VARIANTE', rtrim ( dp.val_car ) + rtrim ( dp.val_car2), ';') in ( 'FULL_SERENITY_ADV_5', 'ADVISE_6', 'ADVISE_7') -- [PC171918] -- [PC171933]
				 )
				 And c.id_four in ( 'BK2', 'EKO', 'DGC', 'NET', 'SMT', 'RAV', 'RTP', 'SFG' )
				Then
				'ADV'

			When Exists ( 
					Select	Top 1 1 
					From	sysadm.det_pro dp 
					where	dp.id_prod = s.id_prod 
					And		dp.id_code_dp = 252
					And		sysadm.FN_CLE_VAL ( 'VARIANTE', rtrim ( dp.val_car ) + rtrim ( dp.val_car2), ';') not in ( 'FULL_SERENITY_ADV_5', 'ADVISE_6', 'ADVISE_7' ) -- [PC151259] -- [PC171918] -- [PC171933]
				 )
				 And c.id_four in ( 'PSM', 'ADV', 'BK2' ) -- [DT076-2] BK2
				Then
				'ADV'
			When c.id_four = 'BLC' Then 'O2M'  -- [PM363-1]
			When sysadm.FN_CLE_VAL ( 'RS3220', c.info_spb_frn_cplt, ';' ) = 'TLS' Then 'TL1' -- [RS3220]
			Else
				c.id_four
		End 'A_regler_a', -- [DT076_V6]
		/*
		Case 
			When sysadm.FN_CLE_VAL ( 'CHGT_CM', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
			 Then 'OUI'
			Else 'NON'
		End*/ 'système jamais mis en production (PM295-1)' 'Chgt_Carte_Mere', -- [PM295-1]
		sysadm.FN_CLE_VAL ( 'NUM_CC_ELD', rtrim( c.info_spb_frn_cplt) , ';' ) 'Num_Carte_Cadeau',
		IsNull ( 
			( Select Top 1 ds.val_nbre 
			  From	sysadm.div_sin ds
			  Where ds.id_sin = s.id_sin
			  And   ds.nom_zone = 'tranche_tarif' )
			,0 ) 'tranche_tarif',
		Case sysadm.FN_CLE_VAL ( 'NEUF_REC', c.info_spb_frn_cplt, ';')
			When 'NEU' Then '[NEU] appareil de remplacement neuf'
			When 'REC' Then '[REC] appareil de remplacement reconditionné'
			Else sysadm.FN_CLE_VAL ( 'NEUF_REC', c.info_spb_frn_cplt, ';')
		End 'Neuf_Recond',
		IsNull ( 
			( Select MAX ( mt_plaf )
			  From	sysadm.plafond p
			  Where p.id_prod = s.id_prod
			  And	p.id_rev = s.id_rev
			  And   p.id_gti = c.id_gti
			  And   id_typ_plaf = 680
			), 0 ) 'plaf_680',
		IsNull ( c.id_bon_transp, '') 'num_tracking',
		'PRESTATION' 'type_enrg',
		null 'id_reg',
		null 'id_reg_base',
		null 'lib_reg',
		null 'mt_tot_reg',
		null 'dte_reg',
		null 'cod_inter',
		null 'cod_mot_reg',
		null 'nom_inter',
		null 'Ventilation_regl',
		IsNull ( 
			( Select sum ( rg.mt_reg ) -- [VDOC21248]
			  From sysadm.reglement r,
				   sysadm.reg_gti rg,
				   sysadm.commande c1,
				   sysadm.detail d
			  Where c1.id_sin = c.id_sin 
			  And   c1.id_seq = c.id_seq
			  And	d.id_sin = c1.id_sin
			  And	d.id_gti = c1.id_gti
			  And	d.id_detail = c1.id_detail
			  And	r.id_sin = d.id_sin
			  And   ( r.id_reg = d.id_reg or r.id_reg_base = d.id_reg )
			  And   r.cod_mot_reg not in ( 'RI' ) -- Modif le 26/12/16 JFF [20161226.1.JFF]
			  And   r.cod_mode_reg = 'FM' -- Modif le 26/12/16 JFF [20161226.1.JFF]
			  And   rg.id_sin = r.id_sin
			  And   rg.id_reg = r.id_reg
			  And   rg.id_gti > 0
			), 0 ) 'Mt_som_regle_sur_presta_hf', -- [VDOC21248]
		( Select (  -- [VDOC21248]
			  Select Cast (  'Mouv. Financié  ' + Convert ( varchar ( 10 ), rg.mt_reg ) + '€ le ' + Convert ( varchar ( 10), rg.cree_le, 103 ) + ' type ' + rtrim ( r.cod_mot_reg)+ ' # '  As Varchar ( 250 ))
			  From sysadm.reglement r,
				   sysadm.reg_gti rg,
				   sysadm.commande c1,
				   sysadm.detail d
			  Where c1.id_sin = c.id_sin 
			  And   c1.id_seq = c.id_seq
			  And	d.id_sin = c1.id_sin
			  And	d.id_gti = c1.id_gti
			  And	d.id_detail = c1.id_detail
			  And	r.id_sin = d.id_sin
			  And   ( r.id_reg = d.id_reg or r.id_reg_base = d.id_reg )
			  And   r.cod_mot_reg not in ( 'RI' ) -- Modif le 26/12/16 JFF [20161226.1.JFF]
			  And   r.cod_mode_reg = 'FM' -- Modif le 26/12/16 JFF [20161226.1.JFF]
			  And   rg.id_sin = r.id_sin
			  And   rg.id_reg = r.id_reg
			  And   rg.id_gti > 0
			  For XML Path ('')  )
		) 'Detail_regle_sur_presta_hf', -- [VDOC21248]
		( Select ( 		-- [PM251-5]
			Select CAST( '#' + rtrim ( cf.categorie ) + '#' AS VARCHAR(250)) 
			From   sysadm.ctg_factu cf 
			Where  cf.marq_app = c.id_marq_art_ifr
			And	   cf.modl_app = c.id_modl_art_ifr
			For XML PATH ('') 
		)) 'Categorie_Facturation', -- /[PM251-5]
		Case sysadm.FN_A_COMMANDER ( c.id_sin, c.id_seq, 'P' ) -- [PM251-4][M23697]
			When 'A_COMMANDER' Then 'REMPL'
			Else null
		End 'Remplacement',
		Case 
			When sysadm.FN_CLE_VAL ( 'SOUS_GC', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
			 Then 'OUI'
			Else 'NON'
		End 'Réparé_sous_gc' -- [PM383-1]

From	sysadm.sinistre s,
		sysadm.commande c,
		sysadm.detail d
Where	c.cod_etat in ( 'ANN', 'RPC', 'RFO', 'RSP' )
And     c.id_sin = @dcIdSin And c.id_seq = @iIdSeq  
And     d.id_sin = c.id_sin
And     d.id_gti = c.id_gti
And     d.id_detail = c.id_detail
And		d.cod_etat <> 600 
And     s.id_sin = c.id_sin



Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S01_PRE_FACTU_PM251_UNITAIRE_REGLE_ET_NREGL
-- Auteur               :       JFF
-- Date                 :       13/09/2018
-- Libelle              :       
-- Commentaires         :       [PM251-1][VDOC26763]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF	13/09/2018	VDOC26763
-- JFF  07/08/2019  [PM462-1]
-- JFF  25/08/2022  [RS3220] TELSTORE O2M=>TLS=>TL1
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_PRE_FACTU_PM251_UNITAIRE_REGLE_ET_NREGL' AND type = 'P' )
        DROP procedure sysadm.PS_S01_PRE_FACTU_PM251_UNITAIRE_REGLE_ET_NREGL
GO

CREATE procedure sysadm.PS_S01_PRE_FACTU_PM251_UNITAIRE_REGLE_ET_NREGL
       @dcIdSin		Decimal ( 10 ), -- [PI062] -- null pour le traitement standard, sinon un id_sin pour un sinistre précis
       @iIdSeq		Integer -- idem l'id_seq lié à l'id_sin, sinon null

AS

Select  '' 'dte_cloture',
		'' 'fin_cloture',
		c.id_sin,
		c.id_seq,
		c.id_four,
		sysadm.FN_CODE_CAR ( c.id_four, '-FR' ) lib_four,
		s.id_prod,
		s.id_ets,
		s.id_adh,
		s.id_sdos,
		sysadm.FN_LIB_PROD ( s.id_prod ) lib_prod,
		sysadm.FN_GET_LIB_POLICE_V01 ( s.id_sin, s.id_prod, s.id_rev, c.id_gti, null ) lib_police,
		sysadm.FN_LIB_CIE( s.id_sin ) lib_cie,
		( select ds.val_car from sysadm.div_sin ds where ds.id_sin = s.id_sin and nom_zone = 'type_app' ) typ_app_sin,
		( select sysadm.FN_CODE_CAR ( ds.val_car, '-AR') from sysadm.div_sin ds where ds.id_sin = s.id_sin and nom_zone = 'type_app' ) lib_typ_app_sin,
		s.dte_ach_port 'dte_achat',
		s.dte_surv,
		rtrim( s.marq_port )'marq_sin',
		rtrim( s.modl_port ) 'modl_sin',
		rtrim( s.num_imei_port ) 'imei_serie_sin',
		( Select Top 1 rtrim( i.sku_saga )
		  From	sysadm.ifr i
		  where	i.marque = s.marq_port
		  And	i.reference = s.modl_port ) sku_saga_sin,
		rtrim( sysadm.FN_CODE_NUM ( c.info_spb_frn, '-IF' )) + ' (' + Convert ( varchar ( 10), c.info_spb_frn ) + ')' 'lib_process',		  
		c.info_spb_frn 'process',
		c.id_typ_art 'id_typ_art',
		Case 
			When c.cod_etat <> 'ANN' And c.status_gc <> 176 And c.id_gti <> 10 And sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'PRET' Then 'PRET'
		End 'Pret',
		Case 
			When c.id_typ_art = 'EDI' Then c.id_ref_four
			When c.id_typ_art = 'PRS' Then 'REPARATION/DESOXYDATION'
			When c.id_typ_art not in ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' )		
				 Or 
				 ( c.id_typ_art in ( 'RST' ) And sysadm.FN_CLE_VAL ( 'RST_CMDE+SUIVI', rtrim ( c.info_spb_frn_cplt), ';'  ) = 'OUI' )  Then 'A_COMMANDER'
			Else sysadm.FN_CODE_CAR ( c.id_typ_art, '-AR' )
		End 'action',
		Case 
			When sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Mode SAV Réparation'
			When sysadm.FN_CLE_VAL ( 'A_DESOXYDER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Mode SAV Désoxydation'
 			When sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Mode Garantie App. Rempl.'
 			When sysadm.FN_CLE_VAL ( 'A_CONTROLER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Mode 2ème SAV pour Ctrle'
			Else ''
		End 'SAV',
		Case 
			When sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Or
				 sysadm.FN_CLE_VAL ( 'A_DESOXYDER_SAV', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' 
				 Then
				 ( Select max ( c1.id_seq )
				   From	  sysadm.commande c1
				   Where  c1.id_sin = c.id_sin
				   and    c1.id_seq < c.id_seq
				   And    c1.id_ref_four in (  'A_REPARER', 'A_DESOXYDER' )
				   And    c1.status_gc in ( 2,22,21,23 )
				   And    c1.cod_etat <> 'ANN'
				 ) 
		End 'IdSeq_orig_sav',
		Case 
			when CharIndex ( '[SAV_NO_OK]', c.comment_frn, 1 ) > 0 Then 'SAV_NO_OK'
			Else ''
		End 'Retour_SAV',
		c.id_ref_four,
		Case 
			When sysadm.FN_CLE_VAL ( 'RST_CMDE+SUIVI', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Rupture de Stock avec Commande de Remplacement + Suivi'
			When sysadm.FN_CLE_VAL ( 'RST_INFO_SIMPLE', RTRIM ( c.info_spb_frn_cplt ) , ';' ) = 'OUI' Then 'Rupture de Stock pour information'			
			Else ''
		End 'typ_rupture_stock',
		rtrim( c.id_marq_art ) 'marq_fourn_cmde',
		rtrim( c.id_modl_art ) 'modl_fourn_cmde',
		rtrim( c.id_marq_art_ifr ) 'marq_ifr_cmde',
		rtrim( c.id_modl_art_ifr ) 'modl_ifr_cmde',
		( Select Top 1 rtrim( i.sku_saga )
		  From	sysadm.ifr i
		  where	i.marque = c.id_marq_art_ifr
		  And	i.reference = c.id_modl_art_ifr ) sku_saga_cmd,
		Case
			When IsNumeric ( sysadm.FN_CLE_VAL ( 'PRIX_TTC_FACTU_O2M', rtrim ( info_frn_spb_cplt ) , ';' )) = 1 Then
				 CONVERT( decimal ( 11,2), replace ( sysadm.FN_CLE_VAL ( 'PRIX_TTC_FACTU_O2M', rtrim ( info_frn_spb_cplt ) , ';' ), ',', '.' ))
			Else c.mt_ttc_cmde
		End mt_ttc_cmde,
		c.id_serie_nouv 'imei_serie_nouv',
		( Select rtrim( i.nom ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Nom_Inter_Ass',
		( Select rtrim( i.adr_1 ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Adr1_inter_Ass',		
		( Select rtrim( i.adr_2 ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'Adr2_inter_Ass',				
		( Select rtrim( i.adr_cp )  from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'AdrCp_inter_Ass',				
		( Select rtrim( i.adr_ville ) from sysadm.inter i where i.id_sin = s.id_sin and i.cod_inter = 'A' ) 'AdrVille_inter_Ass',				
		rtrim( sysadm.FN_CODE_NUM ( c.status_gc, '-GC' ) + ' (' + Convert ( varchar ( 10), c.status_gc) + ')' ) lib_status_gc,
		c.cod_etat,
		c.dte_env_cli 'dte_fin_trait',
		Case 
			When c.cod_etat in ( 'RPC', 'RFO', 'RSP' ) Then 'CLOTUREE (' + rtrim ( c.cod_etat) + ')'
			When c.cod_etat in ( 'ANN' ) Then 'ANNULEE (' + rtrim ( c.cod_etat) + ')'
			Else sysadm.FN_CODE_CAR ( c.cod_etat, '-EC' )
		End lib_etat,
		Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré en pointe de vente'
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré envoie coli en centralisation'
		End 'Ass_en_pdv_ou_coli',
		Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
				/* [VDOC20161]
				Then ( Select Top 1 b.adr_nom
					   From sysadm.boutique b
					   Where b.id_prod = s.id_prod
					   And   b.cod_mag = sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' ) 
					 )
				*/
		End 'Nom_PDV_ou_btq_centralisation',
		Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
				-- Then sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' ) [VDOC20161]
		End 'Num_PDV_ou_btq_centralisation',
		sysadm.FN_CODE_NUM ( c.id_gti, '-GA' ) + ' (' + Convert ( varchar ( 10), c.id_gti) + ')' lib_garantie,
		ISNULL ( 
			NullIf ( 		
				Convert ( Decimal ( 11,2 ), 
					ISNULL ( 
						nullif ( sysadm.FN_CLE_VAL ( 'MT_PEC', rtrim ( c.info_spb_frn_cplt ), ';'), ''),
						IsNull ( 
							( Select dd.val_mt
							  From sysadm.div_det dd
							  Where dd.id_sin = d.id_sin
							  And   dd.id_gti = d.id_gti
							  And   dd.id_detail = d.id_detail
							  And   dd.nom_zone = 'mt_pec' 
							),
							  0 )
					 	    )
					    )
					,-1
					) 
				,0 ) 
			+
			Case -- [PM462-1]
				When IsNumeric ( sysadm.FN_CLE_VAL ( 'MT_CPLT_PAYBOX_SCM', c.info_spb_frn_cplt, ';') ) > 0 
					Then Convert ( Decimal (11, 2 ), sysadm.FN_CLE_VAL ( 'MT_CPLT_PAYBOX_SCM', c.info_spb_frn_cplt, ';'))
				Else 0
			End	'mt_pec', -- [VDOC16011]
		Case 
			When sysadm.FN_CLE_VAL ( 'REMIS_EN_STK', RTRIM ( c.info_frn_spb_cplt ) , ';' ) = 'OUI' Then '[OUI]Presta ANNulée, matériel remis en stock chez le grossiste'
			Else ''
		End 'Remis_en_stk', -- [PM251-2]
		c.comment_frn, -- [PM251-2]
		Case 
			-- [PC151259]
			-- [PC151259-2]
			-- [PC171918]
			When Exists ( 
					Select	Top 1 1 
					From	sysadm.det_pro dp 
					where	dp.id_prod = s.id_prod 
					And		dp.id_code_dp = 252
					And		sysadm.FN_CLE_VAL ( 'VARIANTE', rtrim ( dp.val_car ) + rtrim ( dp.val_car2), ';') in ( 'FULL_SERENITY_ADV_5', 'ADVISE_6', 'ADVISE_7') -- [PC171918] -- [PC171933]
				 )
				 And c.id_four in ( 'BK2', 'EKO', 'DGC', 'NET', 'SMT', 'RAV', 'RTP', 'SFG' )
				Then
				'ADV'

			When Exists ( 
					Select	Top 1 1 
					From	sysadm.det_pro dp 
					where	dp.id_prod = s.id_prod 
					And		dp.id_code_dp = 252
					And		sysadm.FN_CLE_VAL ( 'VARIANTE', rtrim ( dp.val_car ) + rtrim ( dp.val_car2), ';') not in ( 'FULL_SERENITY_ADV_5', 'ADVISE_6', 'ADVISE_7' ) -- [PC151259] -- [PC171918] -- [PC171933]
				 )
				 And c.id_four in ( 'PSM', 'ADV', 'BK2' ) -- [DT076-2] BK2
				Then
				'ADV'
			When c.id_four = 'BLC' Then 'O2M'  -- [PM363-1]
			When sysadm.FN_CLE_VAL ( 'RS3220', c.info_spb_frn_cplt, ';' ) = 'TLS' Then 'TL1' -- [RS3220]
			Else
				c.id_four
		End 'A_regler_a', -- [DT076_V6]
		/*
		Case 
			When sysadm.FN_CLE_VAL ( 'CHGT_CM', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
			 Then 'OUI'
			Else 'NON'
		End*/ 'système jamais mis en production (PM295-1)' 'Chgt_Carte_Mere', -- [PM295-1]
		sysadm.FN_CLE_VAL ( 'NUM_CC_ELD', rtrim( c.info_spb_frn_cplt) , ';' ) 'Num_Carte_Cadeau',
		IsNull ( 
			( Select Top 1 ds.val_nbre 
			  From	sysadm.div_sin ds
			  Where ds.id_sin = s.id_sin
			  And   ds.nom_zone = 'tranche_tarif' )
			,0 ) 'tranche_tarif',
		Case sysadm.FN_CLE_VAL ( 'NEUF_REC', c.info_spb_frn_cplt, ';')
			When 'NEU' Then '[NEU] appareil de remplacement neuf'
			When 'REC' Then '[REC] appareil de remplacement reconditionné'
			Else sysadm.FN_CLE_VAL ( 'NEUF_REC', c.info_spb_frn_cplt, ';')
		End 'Neuf_Recond',
		IsNull ( 
			( Select MAX ( mt_plaf )
			  From	sysadm.plafond p
			  Where p.id_prod = s.id_prod
			  And	p.id_rev = s.id_rev
			  And   p.id_gti = c.id_gti
			  And   id_typ_plaf = 680
			), 0 ) 'plaf_680',
		IsNull ( c.id_bon_transp, '') 'num_tracking',
		'PRESTATION' 'type_enrg',
		null 'id_reg',
		null 'id_reg_base',
		null 'lib_reg',
		null 'mt_tot_reg',
		null 'dte_reg',
		null 'cod_inter',
		null 'cod_mot_reg',
		null 'nom_inter',
		null 'Ventilation_regl',
		IsNull ( 
			( Select sum ( rg.mt_reg ) -- [VDOC21248]
			  From sysadm.reglement r,
				   sysadm.reg_gti rg,
				   sysadm.commande c1,
				   sysadm.detail d
			  Where c1.id_sin = c.id_sin 
			  And   c1.id_seq = c.id_seq
			  And	d.id_sin = c1.id_sin
			  And	d.id_gti = c1.id_gti
			  And	d.id_detail = c1.id_detail
			  And	r.id_sin = d.id_sin
			  And   ( r.id_reg = d.id_reg or r.id_reg_base = d.id_reg )
			  And   r.cod_mot_reg not in ( 'RI' ) -- Modif le 26/12/16 JFF [20161226.1.JFF]
			  And   r.cod_mode_reg = 'FM' -- Modif le 26/12/16 JFF [20161226.1.JFF]
			  And   rg.id_sin = r.id_sin
			  And   rg.id_reg = r.id_reg
			  And   rg.id_gti > 0
			), 0 ) 'Mt_som_regle_sur_presta_hf', -- [VDOC21248]
		( Select (  -- [VDOC21248]
			  Select Cast (  'Mouv. Financié  ' + Convert ( varchar ( 10 ), rg.mt_reg ) + '€ le ' + Convert ( varchar ( 10), rg.cree_le, 103 ) + ' type ' + rtrim ( r.cod_mot_reg)+ ' # '  As Varchar ( 250 ))
			  From sysadm.reglement r,
				   sysadm.reg_gti rg,
				   sysadm.commande c1,
				   sysadm.detail d
			  Where c1.id_sin = c.id_sin 
			  And   c1.id_seq = c.id_seq
			  And	d.id_sin = c1.id_sin
			  And	d.id_gti = c1.id_gti
			  And	d.id_detail = c1.id_detail
			  And	r.id_sin = d.id_sin
			  And   ( r.id_reg = d.id_reg or r.id_reg_base = d.id_reg )
			  And   r.cod_mot_reg not in ( 'RI' ) -- Modif le 26/12/16 JFF [20161226.1.JFF]
			  And   r.cod_mode_reg = 'FM' -- Modif le 26/12/16 JFF [20161226.1.JFF]
			  And   rg.id_sin = r.id_sin
			  And   rg.id_reg = r.id_reg
			  And   rg.id_gti > 0
			  For XML Path ('')  )
		) 'Detail_regle_sur_presta_hf', -- [VDOC21248]
		( Select ( 		-- [PM251-5]
			Select CAST( '#' + rtrim ( cf.categorie ) + '#' AS VARCHAR(250)) 
			From   sysadm.ctg_factu cf 
			Where  cf.marq_app = c.id_marq_art_ifr
			And	   cf.modl_app = c.id_modl_art_ifr
			For XML PATH ('') 
		)) 'Categorie_Facturation', -- /[PM251-5]
		Case sysadm.FN_A_COMMANDER ( c.id_sin, c.id_seq, 'P' ) -- [PM251-4][M23697]
			When 'A_COMMANDER' Then 'REMPL'
			Else null
		End 'Remplacement',
		Case 
			When sysadm.FN_CLE_VAL ( 'SOUS_GC', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
			 Then 'OUI'
			Else 'NON'
		End 'Réparé_sous_gc' -- [PM383-1]

From	sysadm.sinistre s,
		sysadm.commande c,
		sysadm.detail d
Where	c.cod_etat in ( 'ANN', 'RPC', 'RFO', 'RSP' )
And     c.id_sin = @dcIdSin And c.id_seq = @iIdSeq  
And     d.id_sin = c.id_sin
And     d.id_gti = c.id_gti
And     d.id_detail = c.id_detail
And     s.id_sin = c.id_sin


Go



--------------------------------------------------------------------
--
-- Procedure            :       PS_I01_RETOUR_PREFACT_PM251
-- Auteur               :       JFF
-- Date                 :       08/09/2014
-- Libelle              :       Retour écriture suite pré-fact Quentin
-- Commentaires         :       [PM251-2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF	21/11/2014	[VDOC16011]
-- JFF	25/11/2014	[PM251-2]
-- JFF  12/02/2016  [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_RETOUR_PREFACT_PM251' AND type = 'P' )
        DROP procedure sysadm.PS_I01_RETOUR_PREFACT_PM251
GO

CREATE procedure sysadm.PS_I01_RETOUR_PREFACT_PM251
        @dcIdSin		 Decimal ( 10 ), -- [PI062]
        @iIdSeq			 Integer,
        @mtPrefFact		 Decimal ( 11, 2 )
AS
	If @mtPrefFact is null Set @mtPrefFact = -1

	Update sysadm.commande 
	Set info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'MT_PREFACT', Convert ( VarChar ( 11), @mtPrefFact ), RTRIM( info_spb_frn_cplt ), ';' )
	Where id_sin = @dcIdSin
	And id_seq = @iIdSeq
	
	Update sysadm.w_commande 
	Set info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'MT_PREFACT', Convert ( VarChar ( 11), @mtPrefFact ), RTRIM( info_spb_frn_cplt ), ';' )
	Where id_sin = @dcIdSin
	And id_seq = @iIdSeq
	
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_I01_MAJ_SKU_IFR_PM251
-- Auteur               :       JFF
-- Date                 :       27/11/2014
-- Libelle              :       Maj du SKU SAGA2 sur IFR
-- Commentaires         :       [PM251-2]
-- References           :       A appeler la nuit par Quentin via une boucle.
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_MAJ_SKU_IFR_PM251' AND type = 'P' )
        DROP procedure sysadm.PS_I01_MAJ_SKU_IFR_PM251
GO

CREATE procedure sysadm.PS_I01_MAJ_SKU_IFR_PM251
        @asMarqIfr		 VarChar ( 35 ),
        @asModlIfr		 VarChar ( 35 ),
        @asSkuSaga		 VarChar ( 50 )
AS

	Declare @sSkuSagaActuel VarChar ( 50 )
	Set @asSkuSaga = RTRIM ( LTRIM ( @asSkuSaga ))
	
	If Not Exists ( 
		Select top 1 1
		From sysadm.ifr i
		Where i.marque = @asMarqIfr
		And   i.reference = @asModlIfr
		) 
		Begin
			Return
		End
	
	Select @sSkuSagaActuel = i.sku_saga
	From sysadm.ifr i
	Where i.marque = @asMarqIfr
	And   i.reference = @asModlIfr
	
	If @sSkuSagaActuel is null Or @sSkuSagaActuel <> @asSkuSaga
	 Begin
		Update sysadm.ifr
		Set sku_saga = @asSkuSaga
		Where marque = @asMarqIfr
		And   reference = @asModlIfr
	 End 
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S_REGLEMENT_PM251
-- Auteur               :       JFF
-- Date                 :       27/11/2014
-- Libelle              :       
-- Commentaires         :       [PM251-2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_REGLEMENT_PM251' AND type = 'P' )
        DROP procedure sysadm.PS_S_REGLEMENT_PM251
GO


CREATE procedure sysadm.PS_S_REGLEMENT_PM251
        @dcIdSin		 Decimal ( 10 ) -- [PI062]
AS

Select  r.id_sin,
		r.id_reg,
		r.id_reg_base,
		( Select Top 1 rtrim( nom )
		  From   sysadm.inter i
		  Where  i.id_sin = r.id_sin
		  And    i.id_i = r.id_i ) nom_inter,
		( Select min ( c.id_seq )
		  From	sysadm.detail d,
				sysadm.commande c
		  Where d.id_sin = r.id_sin
		  And	d.id_reg = r.id_reg
		  And	c.id_sin = d.id_sin
		  And	c.id_gti = d.id_gti
		  And	c.id_detail = d.id_detail
		  And   c.id_typ_art not in ( 'REL' )
		 ) 'Id_Seq_Liaison_Presta',		
		r.mt_tot_reg,
		rtrim( r.lib_reg ) lib_reg,
		r.dte_reg,
		r.cod_inter,
		rtrim( sysadm.FN_CODE_CAR ( r.cod_inter, '-IN' ) ) lib_inter,
		r.cod_mode_reg,
		rtrim( sysadm.FN_CODE_CAR ( r.cod_mode_reg, '-MR' ) ) lib_mode_reg,
		r.cod_mot_reg,
		rtrim( sysadm.FN_CODE_CAR ( r.cod_mot_reg, '-MO' ) ) lib_mot_reg
  

From	sysadm.reglement r

Where	r.id_sin = @dcIdSin



Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_PREPA_VAL_AUTO_PM251
-- Auteur               :       JFF
-- Date                 :       27/11/2014
-- Libelle              :       
-- Commentaires         :       [PM251-2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-- JFF	25/03/2015	ITSM281224
-- JFF	24/03/2015  'ADV' en 'XA'
-- JFF	22/04/2015	[VDOC16311]
-- JFF  12/05/2015  [DT076_V6]
-- JFF  20/05/2015  [VDOC17700]
-- JFF  21/05/2015  [VDOC17414]
-- JFF  19/06/2015  [ITSM300904]
-- JFF  24/12/2015  [VDOC19513]
-- JFF  11/04/2016  [PM336-1]
-- JFF  12/02/2016  [PI062]
-- JFF  11/10/2016  [DT076-2]
-- JFF  07/11/2016  [PC151259]
-- JFF  29/05/2017  [PC151259-2]
-- JFF  05/10/2017  [PC171918]
-- JFF  06/11/2017  [PC171933]
-- JFF  04/01/2022  [RS_1617_PM251]
-- JFF  07/03/2024  [HP252_276_HUB_PRESTA]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_PREPA_VAL_AUTO_PM251_V01' AND type = 'P' )
        DROP procedure sysadm.PS_U_PREPA_VAL_AUTO_PM251_V01
GO

CREATE procedure sysadm.PS_U_PREPA_VAL_AUTO_PM251_V01
        @dcIdSin	Decimal ( 10 ),
        @iIdSeq		Integer,
        @sCodOper	Varchar ( 4 ),
		@sChaine	VarChar ( 255 ), -- [PM336-1]
        @dcIdProd   Decimal ( 7 ) OUTPUT,
        @sResult	VarChar ( 500 ) OUTPUT
AS
	
	-- IdSeq > 0 normal, méthode 1 PS_U03_DETAIL_MAJ_FACTU ( K_TYPFACT_PRESTA ) 
	-- IdSeq = -100, méthode 3 est le cas PS_U08_DETAIL_MAJ_FACTU_V01 ( K_TYPFACT_H_PRESTA_MAJ_1_DETAIL )

	Declare @mtPrefact Decimal ( 11,2 )
	Declare @mtPec Decimal ( 11,2 )
	Declare @mtPrej Decimal ( 11,2 )
	Declare @iIdIReg Integer
	Declare @dcIdGti Decimal ( 7)
	Declare @dcIdDetail Decimal ( 7)	
	Declare @dcIdIReg Decimal ( 7)	
	Declare @iRet Integer
	Declare @sCommande VarChar ( 10 )
	Declare @iNbADiag Integer 
	Declare @iNbRefOuPec Integer 
	Declare @sCodEtatPresta VarChar ( 10 )
	
	Set @iRet = 0 -- Ok pour validation

	If @iIdSeq > 0
	  Begin
		Select	@sCommande = sysadm.FN_A_COMMANDER ( c.id_sin, c.id_seq, 'P' ),
				@mtPec = dd.val_mt,
				@mtPrej = d.mt_prej,
				@iIdIReg = d.id_i_reg,
				@dcIdGti = d.id_gti,
				@dcIdDetail = d.id_detail,
				@dcIdIReg = d.id_i_reg,
				@dcIdProd = s.id_prod,
				@sCodEtatPresta = c.cod_etat -- [VDOC19513]
		From	sysadm.w_commande c,
				sysadm.w_div_det dd,
				sysadm.w_detail d,
				sysadm.w_sin s
							
		Where	c.id_sin = @dcIdSin
		And		c.id_seq = @iIdSeq
		And		d.id_sin = c.id_sin
		And		d.id_gti = c.id_gti
		And		d.id_detail = c.id_detail
		And     d.cod_etat not in ( 500, 600 )
		And		dd.id_sin = c.id_sin
		And		dd.id_gti = c.id_gti
		And		dd.id_detail = c.id_detail
		And		dd.nom_zone = 'mt_pec'
		And		s.id_sin = c.id_sin
		
		If @@ROWCOUNT <> 1
		Begin
			Set @sResult = 'ERREUR : Erreur sur le nombre de détail à traiter (cause absence de détail ou détail déjà réglé précédemment).'
			Return -100
		End 
				
	  End
	  
	-- -100 est le cas PS_U08_DETAIL_MAJ_FACTU_V01 ( K_TYPFACT_H_PRESTA_MAJ_1_DETAIL )	  
	If @iIdSeq = -100
	  Begin
	  
	    If ( Select COUNT (*)
    		 From	sysadm.w_detail d,
					sysadm.w_sin s
			 Where	d.id_sin = @dcIdSin
			 And	s.id_sin = d.id_sin
			 ) = 1 
			Begin
	  
				Select	@mtPec = d.mt_val_achat,
						@mtPrej = d.mt_prej,
						@iIdIReg = d.id_i_reg,
						@dcIdGti = d.id_gti,
						@dcIdDetail = d.id_detail,
						@dcIdIReg = d.id_i_reg,
						@dcIdProd = s.id_prod
				From	sysadm.w_detail d,
						sysadm.w_sin s
									
				Where	d.id_sin = @dcIdSin
				And		s.id_sin = d.id_sin
				And     d.cod_etat not in ( 500, 600 )
				
				If @@ROWCOUNT <> 1
				Begin
					Set @sResult = 'ERREUR : Erreur sur le nombre de détail à traiter (cause absence de détail ou détail déjà réglé précédemment).'
					Return -100
				End 
			End
		Else
			Begin
				Set @sResult = 'ERREUR : Erreur sur le nombre de détail à traiter (cause absence de détail ou détail déjà réglé précédemment).'
				Return -100
			End 
		
	  End 

		 If Exists ( 
				 Select Top 1 1 
				 From   sysadm.w_commande c,
					    sysadm.w_detail dt,
						sysadm.w_inter i
				 Where  c.id_sin = @dcIdSin
				 And    c.id_seq = @iIdSeq
				 And    c.id_four = 'PSM'
				 And    dt.id_sin = c.id_sin 
				 And    dt.id_gti = c.id_gti
				 And    dt.id_detail = c.id_detail
				 And    i.id_sin = dt.id_sin
				 And    i.id_i = dt.id_i_reg
				 And    i.cod_inter = 'F'
				 And    i.id_four = 'O2M' 
				)
		Begin 
			Set @sResult = 'ERREUR : Vous cherchez à régler O2M alors que le fournisseur de la prestation liée à ce règlement est PSM.'
			Return -100	
		End 

	-- [VDOC19513]
	If @sCodEtatPresta Not in ( 'RPC', 'ANN', 'RFO', 'RSP', 'DEF' )
		Begin
		Set @sResult = 'ERREUR : Prestation non fermée par le prestataire, règlement interdit.'
		Return -100
		End 
	  
	If @mtPec is null Set @mtPec = 0
	
	Select	@mtPrefact = Case 
							When IsNumeric ( sysadm.FN_CLE_VAL ( 'MT_PREFACT', c.info_spb_frn_cplt , ';') ) = 1 Then
								 Convert ( Decimal ( 11, 2), sysadm.FN_CLE_VAL ( 'MT_PREFACT', c.info_spb_frn_cplt , ';') )
							Else 0
						 End
	From	sysadm.commande c
	Where	c.id_sin = @dcIdSin
	And		c.id_seq = @iIdSeq
	
	If @mtPrefact is null Set @mtPrefact = 0

-- [RS_1617_PM251] Su demande de Coraline, on néglige le MT_PREFAC donné par SAGA2 au profit du MT_PEC SIMPA2
	Set @mtPrefact = @mtPec

	 -- Mantis 13860 
	 -- [PM336-1]
	 If sysadm.FN_CLE_VAL ( 'A_FORCER', @sChaine, ';' ) <> 'OUI' 
	    Begin
		 If @mtPrefact > 0 And @mtPec > 0 And @mtPrefact > @mtPec And @sCommande = 'A_COMMANDER'
			Begin
				Set @sResult = 'ERREUR : Montant de pré-facturation supérieur au montant de prise en charge.'
				Return -100
			End 
		End 
-- [RS_1617_PM251] Su demande de Coraline, on néglige le MT_PREFAC donné par SAGA2 au profit du MT_PEC SIMPA2
/*
	If @mtPrefact = 0 And @mtPec > 0 
		Begin
			Set @mtPrefact = @mtPec
		End 
*/

-- /[RS_1617_PM251]


	 If @mtPrefact = 0
		Begin
			-- [RS_1617_PM251] Su demande de Coraline, on change les termes de pré-fracturation en prise charge (plafond)
			Set @sResult = 'ERREUR : Impossible de déterminer un montant de prise charge (plafond).'
		--	Set @sResult = 'ERREUR : Impossible de déterminer un montant de pré-facturation, ni de prise en charge.'

			-- /[RS_1617_PM251]

			Return -100
		End 


	
	 If @mtPrej is null Or @mtPrej = 0 
		Begin
			Set @sResult = 'ERREUR : Montant à régler (zone montant de préjudice) non renseigné sur le détail de garantie.'
			Return -100
		End 	 

	 If @iIdIReg is null
		Begin
			Set @sResult = 'ERREUR : Interlocuteur de règlement non renseigné sur le détail de garantie.'
			Return -100
		End 	 

	 If Exists ( 
		 Select Top 1 1
		 From sysadm.w_detail d
		 Where d.id_sin = @dcIdSin
		 And   (   d.id_gti <> @dcIdGti
				or d.id_detail <> @dcIdDetail
			   )
		 And   d.cod_etat = 500
		)
		Begin
			Set @sResult = 'ERREUR : Présence d''un détail de garantie en cours de validation par la DSA/DR'
			Return -100
		End 

	 If Exists ( 
		 Select Top 1 1
		 From sysadm.w_detail d
		 Where d.id_sin = @dcIdSin
		 And   (    d.id_gti <> @dcIdGti
				 Or d.id_detail <> @dcIdDetail
			   ) 
		 And   d.cod_etat = 1
		)
		Begin
			Set @sResult = 'ERREUR : Présence d''un détail de garantie bloqué par la DSA/DR'
			Return -100
		End 
		  
	 If Exists ( 
		 Select Top 1 1
		 From sysadm.w_commande c
		 Where c.id_sin = @dcIdSin
		 And   c.cod_etat = 'CNV'
		)
		Begin
			Set @sResult = 'ERREUR : Présence d''une prestation en cours de validation par la DSA/DR'
			Return -100
		End 		  

	 -- [VDOC17700]
	  If Exists ( 
		 Select Top 1 1
		 From sysadm.w_courrier wc
		 Where wc.id_sin = @dcIdSin
		)
		Begin
			Set @sResult = 'ERREUR : Présence d''un courrier en cours de validation par la DSA/DR'
			Return -100
		End 		  

	 If Exists ( 
		 Select Top 1 1
		 From sysadm.w_refus r
		 Where r.id_sin = @dcIdSin
		 And   r.id_gti = @dcIdGti
		 And   r.id_motif = 661
		)
		Begin
			Set @sResult = 'ERREUR : Refus 661 déclenché sur la garantie, la somme des mt_pec des détails dépassent le plafond garantie'
			Return -100
		End 		  

	 If Not Exists ( 
		 Select Top 1 1
		 From sysadm.w_detail wd
		 Where wd.id_sin = @dcIdSin
		 And   wd.id_gti = @dcIdGti
		 And   wd.id_detail = @dcIdDetail
		 And   wd.cpt_valide > 0
		)
		Begin
			Set @sResult = 'ERREUR : le détail que vous facturez n''a jamais été validé auparavant par la DSA/DR'
			Return -100
		End 		  

	 If Exists ( 
		 Select Top 1 1
		 From sysadm.w_detail wd
		 Where wd.id_sin = @dcIdSin
		 And   wd.cod_etat = 0
		)
		Begin
			Set @sResult = 'ERREUR : un détail de garantie n''a jamais été validé'
			Return -100
		End 		  

	 -- [PM336-1]
	 If sysadm.FN_CLE_VAL ( 'A_FORCER', @sChaine, ';' ) <> 'OUI'
		Begin
		 If @mtPrej > @mtPrefact 
			Begin
				-- [RS_1617_PM251] Su demande de Coraline, on change les termes de pré-fracturation en prise charge (plafond)
				Set @sResult = 'ERREUR : Montant facture (' + CONVERT ( VarChar ( 20), @mtPrej ) + '€) supérieur au montant de prise charge (plafond) (' + CONVERT ( VarChar ( 20), @mtPrefact ) + '€)'
				-- Set @sResult = 'ERREUR : Montant facture (' + CONVERT ( VarChar ( 20), @mtPrej ) + '€) supérieur au montant de pré-facturation (' + CONVERT ( VarChar ( 20), @mtPrefact ) + '€)'
				-- /[RS_1617_PM251]

				Return -100
			End
		End

	-- ITSM281224
	If ( 
		Select  c.id_ref_four
		From	sysadm.w_commande c
		Where	c.id_sin = @dcIdSin	
		And		c.id_seq = @iIdSeq
		And		c.cod_etat <> 'ANN' ) = 'A_DIAGNOSTIQUER'
		Begin
			Select  @iNbADiag = COUNT(*)
			From	sysadm.w_commande c
			Where	c.id_sin = @dcIdSin	
			And		c.cod_etat <> 'ANN'
			And		c.id_ref_four = 'A_DIAGNOSTIQUER'
			
			Select  @iNbRefOuPec = COUNT(*)
			From	sysadm.w_commande c
			Where	c.id_sin = @dcIdSin
			And		c.cod_etat <> 'ANN'					
			And		c.id_ref_four in ( 'REFUSE_A_REEXP','PEC_A_RECYCLER' )
			
			Select @iNbADiag, @iNbRefOuPec
			
			If @iNbADiag > 0 And @iNbRefOuPec < @iNbADiag 
			  Begin
				Set @sResult = 'ERREUR : Pour régler une prestation de type A_DIAGNOSTIQUER, la DSA doit d''abord passer le flux de type PEC_A_RECYCLER ou REFUSE_A_REEEXP. Revoyez avec la DSA.'
				Return -100				  
			  End 
		
		End 

	-- [HP252_276_HUB_PRESTA]
	 If Exists ( 
		 Select Top 1 1
		 From sysadm.w_commande wc
		 Where wc.id_sin = @dcIdSin
		 And   sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', wc.info_spb_frn_cplt, ';') <> ''
		 And   wc.cod_etat = 'CNV'
		)
		Begin
			Set @sResult = 'ERREUR : Une prestation liée au Hub Prestataire est à valider sur ce dossier par la DGRC d''abord.'
			Return -100
		End 		  

	 -- Tout est Ok, début de maj.
	Update w_queue set alt_occupe = 'O' where id_sin = @dcIdSin and alt_occupe = 'N'

	 If @@ROWCOUNT <> 1
		Begin
			Set @sResult = 'ERREUR : Le dossier (travail) est occupé par un utilisateur.'
			Return -100
		End 	 

	 Set @iRet = @@Error 

	 IF @iRet <> 0 
	   Begin
		Return @iRet 
	   End 

	 Update sysadm.w_detail
	 set	mt_nplaf = @mtPrej,
			mt_plaf = @mtPrej,
			alt_bloc = 'N',
			alt_att = 'N',
			alt_valide = 'O',
			alt_ssui = 'N',
			cod_mot_ssui = 0,
			cod_dec_mac = 500,
			cod_dec_ope = 500,
			cod_etat = 500,
			maj_le = GETDATE(),
			maj_par = @sCodOper
	 Where  id_sin = @dcIdSin
	 And    id_gti = @dcIdGti
	 And    id_detail = @dcIdDetail

	 Set @iRet = @@Error 

	 IF @iRet <> 0 
	   Begin
		Return @iRet 
	   End 
	
	 -- [ITSM300904]
	 Delete sysadm.w_piece
	 Where  id_sin = @dcIdSin
	 And    id_gti = @dcIdGti
	 And    id_detail = @dcIdDetail
	 

	 Update sysadm.w_gar_sin
	 Set	mt_tot_prej = mt_tot_prej + @mtPrej,
			mt_prej_areg = @mtPrej,
			mt_nplaf_areg = @mtPrej,
			mt_plaf_areg = @mtPrej,
			cod_dec_mac = sysadm.FN_GET_ETAT_GARANTIE_PM251 ( @dcIdSin, @dcIdGti, 'W' ) ,
			alt_bloc = 'N',
			alt_att = 'N',
			alt_ssui = 'N',
			cod_mot_ssui = 0,
			alt_valide = 'O',
			cpt_i_areg = 1,
			maj_le = GETDATE(),
			maj_par = @sCodOper
	 Where  id_sin = @dcIdSin
	 And     id_gti = @dcIdGti

	 Set @iRet = @@Error 

	 IF @iRet <> 0 
	   Begin
		Return @iRet 
	   End 

    -- [ITSM300904]
	If sysadm.FN_GET_ETAT_GARANTIE_PM251 ( @dcIdSin, @dcIdGti, 'W' ) in ( 900, 600, 200 )
	  Begin
	  	 Delete sysadm.w_piece
		 Where  id_sin = @dcIdSin
		 And    id_gti = @dcIdGti
	  End 

	 Update sysadm.w_gar_sin
	 set	cod_dec_ope = cod_dec_mac,
			cod_etat = cod_dec_mac
	 Where  id_sin = @dcIdSin
	 And     id_gti = @dcIdGti

	 Set @iRet = @@Error 

	 IF @iRet <> 0 
	   Begin
		Return @iRet 
	   End 
	 
	 Update sysadm.w_inter
	 Set	mt_a_reg = @mtPrej,
			alt_valide = 'O',
			maj_le = GETDATE(),
			maj_par = @sCodOper
	 Where  id_sin = @dcIdSin
	 And	id_i = @dcIdIReg
	 
	 Set @iRet = @@Error 

	 IF @iRet <> 0 
	   Begin
		Return @iRet 
	   End 

	 -- [DT076_V6]
	 -- [DT076-2] BK2
	 -- [PC151259]
	 -- [PC151259-2]
	Update sysadm.w_inter_encrypt
	Set	cod_mode_reg = 'XA',
		alt_valide = 'O',
		maj_le = GETDATE(),
		maj_par = @sCodOper
	From	sysadm.det_pro dp,
			sysadm.w_sin ws,
			sysadm.w_inter_encrypt wi
	Where  ws.id_sin = @dcIdSin
	And    dp.id_prod = ws.id_prod
	And	dp.id_code_dp = 252
	And	wi.id_sin = ws.id_sin
	And	( 
			( sysadm.FN_CLE_VAL ( 'VARIANTE', rtrim ( dp.val_car ) + rtrim ( dp.val_car2) , ';') in ( 'FULL_SERENITY_ADV_5', 'ADVISE_6', 'ADVISE_7' ) -- [PC171918] -- [PC171933]
				And 
				wi.id_four in ( 'ADV' ) -- , 'BK2', 'EKO', 'DGC', 'NE1', 'NE2', 'NE3', 'NE4', 'NE5', 'NE6', 'NE7', 'SMT', 'RAV', 'RTP' on ne maintient plus
			)
			Or
			( sysadm.FN_CLE_VAL ( 'VARIANTE', rtrim ( dp.val_car ) + rtrim ( dp.val_car2), ';') not in ( 'FULL_SERENITY_ADV_5', 'ADVISE_6', 'ADVISE_7' ) -- [PC171918] -- [PC171933]
				And 
				wi.id_four in ( 'ADV', 'PSM', 'BK2' )
			)
		)
	 		  	 
	 Set @iRet = @@Error 

	 IF @iRet <> 0 
	   Begin
		Return @iRet 
	   End 


	 Update sysadm.w_sin
	 Set	mt_a_reg = @mtPrej,
			cod_dec_mac = sysadm.FN_GET_ETAT_DOSSIER_PM251 ( @dcIdSin, 'W' ) ,
			alt_ssui = 'N',
			cod_mot_ssui = 0,
			alt_bloc = 'N',
			maj_le = GETDATE(),
			maj_par = @sCodOper
	 Where  id_sin = @dcIdSin

	 Set @iRet = @@Error 

	 IF @iRet <> 0 
	   Begin
		Return @iRet 
	   End 
	  	 
	 Update sysadm.w_sin
	 Set	cod_dec_ope = cod_dec_mac ,
			cod_etat = cod_dec_mac 
	 Where  id_sin = @dcIdSin			
 
 	 Set @iRet = @@Error 

	 IF @iRet <> 0 
	   Begin
		Return @iRet 
	   End 

	-- ITSM296306
	Delete from sysadm.w_reg_gti Where id_sin = @dcIdSin
	Insert into sysadm.w_reg_gti ( 
		id_sin,
        id_i,
        id_gti,
        id_rgpt,
        id_reg,
        mt_reg,
        mt_rgpt,
		cree_le,
        maj_le,
        maj_par               
        )
	
		values 
		(
		@dcIdSin,
		@dcIdIReg,
		@dcIdGti,
		@dcIdGti,
		0,
		@mtPrej,
		@mtPrej,
        GETDATE(),
		GETDATE(),            
		@sCodOper 
		)

	If Exists ( Select * From sysadm.w_div_det dd Where dd.id_sin = @dcIdSin And dd.id_gti = @dcIdGti And dd.id_detail = @dcIdDetail and nom_zone = 'validation_auto')
	 Begin
	   Update sysadm.w_div_det Set val_car = 'O' Where id_sin = @dcIdSin And id_gti = @dcIdGti And id_detail = @dcIdDetail and nom_zone = 'validation_auto'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_det values ( @dcIdSin, @dcIdGti, @dcIdDetail, 'validation_auto', 'Validation Régl. automatique', '--', 'N', 'X', 'N', 'O', 80, null, null, null, 'O', 0, getdate(), getdate(), @sCodOper )        
	 End

 	 Set @iRet = @@Error 

	 IF @iRet <> 0 
	   Begin
		Return @iRet 
	   End 

	Return @iRet 
	 
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_MAJ_CONTACT_PM251
-- Auteur               :       JFF
-- Date                 :       27/11/2014
-- Libelle              :       
-- Commentaires         :       [PM251-2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_MAJ_CONTACT_PM251' AND type = 'P' )
        DROP procedure sysadm.PS_U_MAJ_CONTACT_PM251
GO


CREATE procedure sysadm.PS_U_MAJ_CONTACT_PM251
        @dcIdSin	Decimal ( 10 ) -- [PI062]
AS 

Declare @iRet Integer
Declare @iIdContact Integer

Select @iIdContact = wq.id_contact
From   sysadm.w_queue wq
Where  Convert ( Decimal ( 10 ), wq.id_sin ) = @dcIdSin -- [PI062]

Delete sysadm.w_queue where id_sin = @dcIdSin 
Set @iRet = @@Error 

IF @iRet <> 0 
  Begin
	Return @iRet 
  End 

-- [DT044-1_V5] Méthode 5
If @iRet = 0 
  Begin
	-- La condition est à l'intérieur
	Exec sysadm.PS_SUPP_REGL_W_A_VIRER @dcIdSin
	If @@ERROR <> 0 
	  begin
		Return @iRet 
	  End
  End 		


If @iRet = 0 
  Begin

	IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		Exec @iRet = SHERPA_PRO.sysadm.PS_U_MAJ_CONTACT_PM251_SH @dcIdSin, @iIdContact 
	Else
		Exec @iRet = SHERPA_SIM.sysadm.PS_U_MAJ_CONTACT_PM251_SH @dcIdSin, @iIdContact 

	IF @iRet <> 0 
	  Begin
		Return @iRet 
	  End 
  End 

Return @iRet
	
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_CONTROLE_VALIDATION
-- Auteur               :       JFF
-- Date                 :       11/04/2017
-- Libelle              :       
-- Commentaires         :       [ITSM456299]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_CONTROLE_VALIDATION' AND type = 'P' )
        DROP procedure sysadm.PS_S_CONTROLE_VALIDATION
GO

CREATE procedure sysadm.PS_S_CONTROLE_VALIDATION
        @dcIdSin	Decimal ( 10 ) -- [PI062]
AS 

If Exists ( 
	Select Top 1 1 
	From   sysadm.w_detail wd
	Where  wd.id_sin = @dcIdSin
	And    wd.cod_etat = 500
	And    wd.id_i_reg > 0 
	And    wd.mt_prej > 0 
	And    wd.dte_livr is not null
  )
  Begin
	Update sysadm.w_detail 
	Set 
		id_i_reg=null,
		dte_livr= null,
		num_facture = 'XXX' , 
		mt_prej = 0, 
		alt_att = 'N',
		alt_reg = 'N',
		alt_ssui = 'N',
		cod_mot_ssui = 0,
		cod_etat = 100,
		cod_dec_mac = 100,
		cod_dec_ope = 100
	From sysadm.w_detail wd
	Where wd.id_sin = @dcIdSin
	And	  wd.cod_etat = 500
	And   wd.id_i_reg > 0 
	And   wd.mt_prej > 0 
	And   wd.dte_livr is not null
	Return -1
  End 

Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_CONTROLE_DBLT_REGLT
-- Auteur               :       JFF
-- Date                 :       21/12/2017
-- Libelle              :       
-- Commentaires         :       Suite bug où la validation de facturation valide en même 
--								un ancien réglemant assuré déjà validé.
-- References           :       
-- Arguments            :       PS_S_CONTROLE_DBLT_REGLT
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_CONTROLE_DBLT_REGLT' AND type = 'P' )
        DROP procedure sysadm.PS_S_CONTROLE_DBLT_REGLT
GO

CREATE procedure sysadm.PS_S_CONTROLE_DBLT_REGLT
        @dcIdSin	Decimal ( 10 ) -- [PI062]
AS 

-- Je regarde 1 seconde avant et une seconde après la date de la présente validation en cours.
-- Si cette validation possède 2 réglement, c'est le bug.
If ( 
	Select T.nbre
	From 
	(
		select valide_le, valide_par, count (*) as nbre
		from sysadm.reglement 
		where id_sin=@dcIdSin
		And   valide_le between DateAdd ( second, -1, GetDate () ) And DateAdd ( second, +1, GetDate () )
		Group by valide_le, valide_par
		Having count (*) > 1
	) as T
  ) > 1
  Begin
	Return -1
  End 

Return 1

Go

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRACE_CMDE_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_I01_TRACE_CMDE_V01
GO

CREATE PROCEDURE        sysadm.PS_I01_TRACE_CMDE_V01
	@asIdSession     varchar(30),
	@asBrowser       varchar(200),
	@adcIdSin	Decimal (10),  -- [PI062]
	@asNumTel        varchar(10),
	@asMdp           varchar(6),
	@adcIdCodeTrc    Decimal(7),
	@asGravite       varchar(10),
	@asIdAppli       varchar(5),
	@asEtape         varchar(20),
	@aiIdMess        integer,
	@asMajPar	 VarChar ( 4 )

As

Declare	@sMajPar        varchar(4)
Declare	@sIdFourCmde    varchar(3)
Declare	@sIdMarqCmde    varchar(35)
Declare	@sIdModlCmde    varchar(35)
Declare	@dcMtTtcCmde    decimal(11,2)
Declare	@dcMtPlaf       decimal(11,2)
Declare	@dcIdProd	Decimal ( 7 )
Declare	@dcIdGti	Decimal ( 7 )
Declare @sIdTypTrc 	varchar ( 3 )
Declare @iIdSeq		integer
Declare @dtMajMdp	DateTime

Set @sIdTypTrc = '-TR'

Set @sMajPar = 'AUTO' -- [PM462-1]

/*
   2 : WI/Utilisation maintenance images 
   3 : WI/Utilisation Test DIT
   4 : WI/Sinistre non valide
  15 : WE/Validation imposs. div. raisons
  16 : WE/Imp envoi mail push conf
*/
If @adcIdCodeTrc in (  2, 3, 4, 15, 16  )
	BEGIN
		Set @dtMajMdp = null
		Set @iIdSeq = null
		Set @dcIdProd = null
		Set @dcIdGti = null
		Set @dcMtPlaf = 0
		Set @sIdFourCmde = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcCmde = 0
		Set @sMajPar = 'SPB'
	END

/*
   7 : WI/Cmde déjà passée en cours de trt
  17 : WI/Validation cmde par assuré
*/
If @adcIdCodeTrc in (  7, 17  )

	BEGIN
		Select  @dtMajMdp = d.maj_le,
			@iIdSeq = c.id_seq,
			@dcIdProd = s.id_prod,
		        @dcIdGti = c.id_gti,
			@dcMtTtcCmde = c.mt_ttc_cmde,
			@sIdFourCmde = c.id_four,
			@sIdMarqCmde = c.id_marq_art_ifr,
			@sIdModlCmde = c.id_modl_art_ifr

		From    sysadm.sinistre s,
		        sysadm.commande c,
				sysadm.div_sin d
                Where   s.id_sin = @adcIdSin
                and	d.id_sin = s.id_sin
		and     d.nom_zone = 'mdp_net'
		and     c.id_sin = s.id_sin
                and     c.cod_etat in ( 'ECT' ) 
                and     c.id_seq = (    Select max ( c2.id_seq ) 
                                        From sysadm.commande c2
                                        Where c2.id_sin = c.id_sin
                                        and   c2.id_four = c.id_four
                                        and   c2.cod_etat = c.cod_etat )
		
		Set @dcMtPlaf = 0
		Set @sMajPar = 'ASSU'
	END

/*
   5 : WI/Presence travail
   6 : WI/Num portable non valide
   8 : WI/Dossier clos
   9 : WI/Pas de cmde WEB dispo
*/
If @adcIdCodeTrc in (  5, 6, 8, 9 )
	BEGIN

		Select  @dcIdProd = s.id_prod
		From    sysadm.sinistre s
		Where   s.id_sin = @adcIdSin

		Set @iIdSeq = null
		Set @dcIdGti = null
		Set @dcMtPlaf = 0
		Set @sIdFourCmde = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcCmde = 0
		Set @sMajPar = 'ASSU'
	END

/*
  10 : WE/Prble Param delai mdp
  11 : WE/mdp absent sur dossier
  12 : WI/durée validité mdp expirée
  13 : WI/mdp erroné
  14 : WI/Trop peu mobile dispo fct plaf
  20 : WI/Connexion établie
*/
If @adcIdCodeTrc in ( 10, 11, 12, 13, 14, 20 )
	BEGIN
		Select  @dtMajMdp = d.maj_le,
			@iIdSeq = c.id_seq,
			@dcIdProd = s.id_prod,
		        @dcIdGti = c.id_gti,
			@dcMtPlaf = c.mt_ttc_cmde
		From    sysadm.sinistre s,
		        sysadm.commande c,
			sysadm.div_sin d

		Where   s.id_sin = @adcIdSin
                and	d.id_sin = s.id_sin
		and     d.nom_zone = 'mdp_net'
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBA'
		and     c.cod_etat = 'CWE'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )
		

		Set @sIdFourCmde = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcCmde = 0
		Set @sMajPar = 'ASSU'
	END

/*
  18 : SI/Cmde Web activé par GT
*/
If @adcIdCodeTrc in ( 18 )
	BEGIN
		Select  @dtMajMdp = d.maj_le,
			@iIdSeq = c.id_seq,
			@dcIdProd = s.id_prod,
		        @dcIdGti = c.id_gti,
			@dcMtPlaf = c.mt_ttc_cmde,
			@asNumTel = sysadm.FN_TRIM ( s.num_port ),
			@asMdp = sysadm.FN_TRIM ( d.val_car )

		From    sysadm.w_sin s,
		        sysadm.w_commande c,
			sysadm.w_div_sin d

		Where   s.id_sin = @adcIdSin
		and     d.id_sin = s.id_sin
		and     d.nom_zone = 'mdp_net'
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBA'
		and     c.cod_etat = 'CNV'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )
		

		Set @sIdFourCmde = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcCmde = 0
		Set @sMajPar = @asMajPar
	END

/*
  19 : SI/Cmde Web annulé par GT
*/
If @adcIdCodeTrc in ( 19 )
	BEGIN
		Select  @dtMajMdp = d.maj_le,
			@iIdSeq = c.id_seq,
			@dcIdProd = s.id_prod,
		        @dcIdGti = c.id_gti,
			@dcMtPlaf = c.mt_ttc_cmde,
			@asNumTel = sysadm.FN_TRIM ( s.num_port),
			@asMdp = sysadm.FN_TRIM ( d.val_car )

		From    sysadm.sinistre s,
		        sysadm.commande c,
			sysadm.div_sin d

		Where   s.id_sin = @adcIdSin
		and     d.id_sin = s.id_sin
		and     d.nom_zone = 'mdp_net'
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBA'
		and     c.cod_etat = 'ANN'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )
		

		Set @sIdFourCmde = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcCmde = 0
		Set @sMajPar = @asMajPar
	END

/*
  21 : SI/mdp regénéré par GT
*/
If @adcIdCodeTrc in ( 21 )
	BEGIN
		Select  @dtMajMdp = d.maj_le,
			@iIdSeq = c.id_seq,
			@dcIdProd = s.id_prod,
		        @dcIdGti = c.id_gti,
			@dcMtPlaf = c.mt_ttc_cmde,
			@asNumTel = sysadm.FN_TRIM ( s.num_port ),
			@asMdp = sysadm.FN_TRIM ( d.val_car )

		From    sysadm.w_sin s,
		        sysadm.w_commande c,
			sysadm.w_div_sin d

		Where   s.id_sin = @adcIdSin
		and     d.id_sin = s.id_sin
		and     d.nom_zone = 'mdp_net'
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBA'
		and     c.cod_etat = 'CWE'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )
		

		Set @sIdFourCmde = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcCmde = 0
		Set @sMajPar = @asMajPar
	END

/*
   1 : SI/Trop peu mobile dispo fct plaf
*/
If @adcIdCodeTrc in ( 1 )
	BEGIN

		Select  @dcIdProd = s.id_prod
		From    sysadm.w_sin s
		Where   s.id_sin = @adcIdSin

		Set @iIdSeq = null
		Set @dcIdGti = Convert ( Decimal (7), sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'GTI', @asBrowser, ';' ) ) )
		Set @dcMtPlaf = Convert ( Decimal (11,2), sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'MT_PLAF', @asBrowser, ';' ) ) )
		Set @asBrowser = null
		Set @sIdFourCmde = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcCmde = 0
		Set @sMajPar = @asMajPar
	END

/*
  29 : WI/Cmde annulé par ass pour Dde Rbt
*/
If @adcIdCodeTrc in ( 29 )
	BEGIN
		Select  @dtMajMdp = d.maj_le,
				@iIdSeq = c.id_seq,
				@dcIdProd = s.id_prod,
		        @dcIdGti = c.id_gti,
				@dcMtPlaf = c.mt_ttc_cmde
		From    sysadm.sinistre s,
		        sysadm.commande c,
				sysadm.div_sin d

		Where   s.id_sin = @adcIdSin
                and	d.id_sin = s.id_sin
		and     d.nom_zone = 'mdp_net'
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBA'
		and     c.cod_etat = 'ANN'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )
		

		Set @sIdFourCmde = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcCmde = 0
		Set @sMajPar = 'ASSU'
	END

Insert into sysadm.trace_cmde_web (
	id_session,
	id_sin,
	num_tel,
	mdp,
	dte_maj_mdp,
	id_seq,
	id_prod,
	id_gti,
	id_typ_trc,
	id_code_trc,
	gravite,
	id_appli,
	etape,
	id_mess,
	mt_plaf,	
	id_four_cmde,
	id_marq_cmde,
	id_modl_cmde,
	mt_ttc_cmde,
	browser,
	cree_le,
	maj_le,
	maj_par
	)

	Values
	(
	@asIdSession,
	@adcIdSin,
	@asNumTel,
	@asMdp,
	@dtMajMdp,
	@iIdSeq,
	@dcIdProd,
	@dcIdGti,
	@sIdTypTrc,
	@adcIdCodeTrc,
	@asGravite,
	@asIdAppli,
	@asEtape,
	@aiIdMess,
	@dcMtPlaf,
	@sIdFourCmde,
	@sIdMarqCmde,
	@sIdModlCmde,
	@dcMtTtcCmde,
	@asBrowser,
	getdate(),
	getdate(),
	@sMajPar
	)

Go

