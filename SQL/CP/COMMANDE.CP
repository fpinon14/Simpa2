-------------------------------------------------------------------
--
-- Fichier              :       COMMANDE.CP
-- Auteur               :       Fabry Jf
-- Date                 :       03/09/01
--
-- Commentaires         :       Gestion de la table COMMANDE
--
-- Procedures           :       DW_S01_COMMANDE
-- TRIGGER TR_U04_COMMANDE_V01
-- TRIGGER TR_U05_COMMANDE_V01
-- PROCEDURE [sysadm].[DW_S05_COMMANDE]
-- procedure sysadm.DW_S01_COMMANDE
-- procedure sysadm.DW_S01_COMMANDE_COURRIER_CARMA_V01
-- procedure sysadm.DW_S02_COMMANDE_COURRIER_AUCHAN_V01
-- procedure sysadm.DW_S02_COMMANDE_V13
-- procedure sysadm.DW_S03_COMMANDE
-- procedure sysadm.DW_S04_COMMANDE
-- procedure sysadm.DW_S07_COMMANDE_V01
-- procedure sysadm.DW_S08_COMMANDE
-- procedure sysadm.DW_S09_COMMANDE
-- procedure sysadm.DW_S10_COMMANDE
-- procedure sysadm.DW_S11_COMMANDE
-- procedure sysadm.DW_S12_COMMANDE
-- procedure sysadm.DW_U01_COMMANDE
-- procedure sysadm.PS_COMMANDES_SPBS_VEILLE
-- procedure sysadm.PS_COMMANDES_SPBS_VEILLE_MAIL
-- procedure sysadm.PS_I_PEC_A_RECYCLER_PM330
-- procedure sysadm.PS_I_REFUSE_A_REEXP_PM330
-- procedure sysadm.PS_I01_COMMANDE_VAL
-- procedure sysadm.PS_I02_COMMANDE_VAL
-- procedure sysadm.PS_S_ATLAS_PIECE_GEOLOCALISATION
-- procedure sysadm.PS_S_COMMANDES_VIPP
-- procedure sysadm.PS_S_COMMANDES_VIPP_QUOTIDIEN
-- procedure sysadm.PS_S_COUR_CARTE_CADEAU_ELD_KSL
-- procedure sysadm.PS_S_COUR_DEM_PCE_SFR_SBE_FACT_ACHAT_KSL
-- procedure sysadm.PS_S_ID_SEQ_NUM_CARTE_ED
-- procedure sysadm.PS_S_LECTURE_LOT_CMD
-- procedure sysadm.PS_S03_COMMANDE
-- procedure sysadm.PS_S04_COMMANDE
-- procedure sysadm.PS_S05_COMMANDE
-- procedure sysadm.PS_S06_COMMANDE
-- procedure sysadm.PS_S07_COMMANDE
-- procedure sysadm.PS_S08_COMMANDE
-- procedure sysadm.PS_S09_COMMANDE
-- procedure sysadm.PS_S10_COMMANDE
-- procedure sysadm.PS_S11_COMMANDE
-- procedure sysadm.PS_S11_COMMANDE_V07
-- procedure sysadm.PS_S12_COMMANDE
-- procedure sysadm.PS_S13_COMMANDE
-- procedure sysadm.PS_U_ATLAS_PIECE_GEOLOCALISATION
-- procedure sysadm.PS_U_COMMANDE_ELD_NUM_CC
-- procedure sysadm.PS_U_COMMANDE_PM82_LOT1_CLOTURE_A_REPARER_FORCE
-- procedure sysadm.PS_U_COMMANDE_PM82_LOT1_CLOTURE_PRS
-- procedure sysadm.PS_U_COMMANDE_VDOC9304_CLOTURE_A_DIAG_FORCE
-- procedure sysadm.PS_U_COMMANDE_VDOC9304_CLOTURE_DIAG
-- procedure sysadm.PS_U_COMMANDE_VIRTUELLE_FERM
-- procedure sysadm.PS_U_COMMANDE_VIRTUELLE_RST
-- procedure sysadm.PS_U_COUR_CARTE_CADEAU_ELD_KSL
-- procedure sysadm.PS_U_COUR_DEM_PCE_SFR_SBE_FACT_ACHAT_KSL
-- procedure sysadm.PS_U_FORCAGE_ID_LOT_CMD_PM103
-- procedure sysadm.PS_U_REDRESSEMENT_CMDE_ANNUL
-- procedure sysadm.PS_U_REINIT_PRESTA_ELD
-- procedure sysadm.PS_U01_COMMANDE
-- procedure sysadm.PS_U01_COMMANDE_PLAF
-- procedure sysadm.PS_U01_COMMANDE_SRR
-- procedure sysadm.PS_U01_COMMANDE_SRR_V01
-- procedure sysadm.PS_U01_PREP_SOLDAGE_TELEPHONIE
-- procedure sysadm.PS_U02_COMMANDE_EDEL
-- procedure sysadm.PS_U02_COMMANDE_VAL
-- procedure sysadm.PS_U02_COMMANDE_VAL_V01
-- procedure sysadm.PS_U02_COMMANDE_VAL_V02
-- procedure sysadm.PS_U03_COMMANDE_VAL
-- procedure sysadm.PS_U04_COMMANDE_VAL
-- procedure sysadm.PS_U05_COMMANDE_VAL
-- procedure sysadm.PS_U06_COMMANDE_VAL
-- procedure sysadm.PS_U07_COMMANDE_VAL
-- procedure sysadm.PS_U07_COMMANDE_VAL_V01
-- procedure sysadm.PS_U08_COMMANDE_VAL
-- procedure sysadm.PS_U09_COMMANDE_VAL
-- procedure sysadm.PS_U10_COMMANDE_MAJ_WEB
-- procedure sysadm.PS_U10_COMMANDE_VAL_SCF_ECH_EXPRESS
-- procedure sysadm.PS_U11_COMMANDE_TEST_PI
-- procedure sysadm.PS_U11_COMMANDE_VAL_FNAC_EPT
-- procedure sysadm.PS_U11_COMMANDE_VAL_FNAC_EPT_V01
-- procedure sysadm.PS_U12_COMMANDE_O2M
-- procedure sysadm.PS_U12_COMMANDE_VAL_RUEDUCOMMERCE
-- procedure sysadm.PS_U13_COMMANDE_VAL_MOBISQUARE
-- procedure sysadm.PS_U14_COMMANDE_VAL_CAMARA
-- procedure sysadm.PS_U15_COMMANDE_VAL_SMS
-- procedure sysadm.PS_U16_COMMANDE_VAL_SCCCG13
-- procedure sysadm.PS_U17_COMMANDE_VAL_SCCCG_V01
-- procedure sysadm.PS_U18_COMMANDE_MAIL_EXPANSION
-- procedure sysadm.PS_U18_COMMANDE_VAL_CARREFOUR
-- procedure sysadm.PS_U19_COMMANDE_VIRTUELLE_STD
-- procedure sysadm.PS_U20_COMMANDE_VAL_MAIL
-- procedure sysadm.PS_U21_COMMANDE_STATUS_GC
-- procedure sysadm.PS_U22_COMMANDE_ETAT_APP_PRET
-- TRIGGER TR_U01_COMMANDE 
-- TRIGGER TR_U02_COMMANDE_V01
-- TRIGGER TR_U03_COMMANDE_V01
-- view [sysadm].[v_commande_psm]
-- PS_U_PRESTA_LECLERC_PNEU
-- PS_I_COMMANDE_DT276_SWAP_CTR
--------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       DW_S01_COMMANDE
-- Auteur               :       Fabry JF
-- Date                 :       07/09/01
-- Libelle              :        
-- Commentaires         :       Select sur la table COMMANDE
-- References           :       En consultation permanente
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_COMMANDE
GO

CREATE procedure sysadm.DW_S01_COMMANDE
        @dcIdSin        Decimal (  10, 0 ) -- [PI062]
AS
 SELECT 
	id_sin,                         
	id_seq,                         
	id_gti,                         
	id_detail,                      
	id_four,                        
	id_typ_art,                     
	id_marq_art,                    
	id_modl_art,                    
	mt_ttc_cmde,                    
	adr_nom,                        
	adr_prenom,                     
	adr_livr1,                      
	adr_livr2,                      
	adr_livr_cpl,                   
	adr_cp,                         
	adr_ville,                      
	adr_tel1,                       
	adr_tel2,                       
	adr_tel3,                       
	adr_mail,                       
	dte_rdv_cli,                    
	hrdv_cli_min,                   
	hrdv_cli_max,                   
	id_serie_anc,                   
	probleme,                       
	id_cmd_frn,                     
	id_serie_nouv,                  
	id_bon_transp,                  
	dte_rcp_frn,                    
	dte_env_cli,                    
	cod_etat,                       
	comment_frn,                    
	nom_gest,                       
	id_lot_cmd,                     
	cmd_gen_le,                     
	cmd_gen_par,                    
	cree_le,                        
	maj_le,                         
	maj_par,
	valide_le,
	valide_par,
        id_zone,
        id_bsp,
        dte_ret_pret,
        adr_cod_civ,
        id_ref_four,
        id_orian_marque,
        id_orian_modele,
        dte_elv_mobile,
        status_gc     ,
        dte_emis_devis,
        mt_devis      ,
        alt_dev_acp   ,
        dte_dev_acp   ,
        adrfc_cod_civ,
	adrfc_nom,
	adrfc_prenom,
	adrfc_livr1,
	adrfc_livr2,
	adrfc_livr_cpl,
	adrfc_cp,
	adrfc_ville,
	dte_ret_logis,
	dte_ret_pret_min,
	dte_ret_pret_max,
	id_ann,
	dte_env_bte_frn,
	dte_rcp_bte_cli,
	dte_dep_bte_cli,
	dte_env_st,
	dte_rcp_mob_cli,
	info_spb_frn,
        id_marq_art_ifr,
        id_modl_art_ifr,
        info_spb_frn_cplt, -- #1 [FNAC_PROD_ECH_TECH]
	info_frn_spb_cplt  -- #1 [FNAC_PROD_ECH_TECH]

	
 FROM   sysadm.commande
 WHERE  commande.id_sin = @dcIdSin


GO

--------------------------------------------------------------------
--
-- Procedure            :       DW_S02_COMMANDE
-- Auteur               :       Fabry JF
-- Date                 :       07/09/01
-- Libelle              :        
-- Commentaires         :       Select sur la table COMMANDE
-- References           :       Pour g‚n‚ration du fichier de commande CETELEC
--
-- Arguments            :       @iIdLotCmd       Integer,
--				@sIdFour	 VarChar ( 3 )
--
-- Retourne             :       Rien
-- 
-- #1   JFF	15/10/2007	[ALAPAGE] On rappatrie le lib type article
-- #2	PHG	28/11/2007	[O2M] On rapatrie l'assureur
-- #3   PHG	31/03/2008	[DCMP080162] Pour O2M, rapatriement date d'achat
-- #4   JFF	05/09/2008	[MICROMANIA]
-- #5	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
-- #6   JFF	27/03/2009      [DCMP090152]
-- #7   JFF     25/11/2009      [MSS_DIAG] V01
-- #8   JFF     02/03/2010    	[MSS_LOT2] 
-- 	FPI	13/10/2010	[VDoc1416] Modif texte libellé civité longue 4
--	JFF     04/11/2010 	[PC301].[LOT2]
--      JFF     22/06/2011      [VDOC4513] V03
--      JFF     17/04/2012	[PM200][LOT2][DESOX]
--      JFF/FPI 23/11/2012	[PC874]
--      FPI 23/11/2012	[PC767] Ajout id_ets, id_sdos
--      FPI 22/07/2013	[PC952] Ajout lib_gti
--		FPI 09/09/2013	[PC767-1] Ajout des zones desimlocke & code_verrou - V10
--      JFF 21/02/2014  [VDOC13683]
--		FPI 14/05/2014	[PC13448]
--		JFF 06/11/2018   [PM451-1]
--      JFF 12/12/2018   [VDOC27242]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_COMMANDE_V13' AND type = 'P' )
        DROP procedure sysadm.DW_S02_COMMANDE_V13
GO


CREATE procedure sysadm.DW_S02_COMMANDE_V13
    @iIdLotCmd       Integer,
	@sIdFour	 VarChar ( 3 )
AS
 SELECT 
	cmd.id_sin,                         
	cmd.id_seq,                         
	cmd.id_gti,                         
	cmd.id_detail,
	produit.id_prod,
	produit.lib_long,
	cmd.id_four,                        
	cmd.id_typ_art,
	--#1
	( Select Top 1 IsNull ( c.lib_code, '' )
	  From  sysadm.code_car c with (nolock) 
	  Where c.id_typ_code = '-AR'
	  And   c.id_code = cmd.id_typ_art ) 'lib_typ_art', 
        IsNull ( cmd.id_marq_art, '' ),                    
        IsNull ( cmd.id_modl_art, '' ),                    
        IsNull ( cmd.mt_ttc_cmde, 0 ),                    
	IsNull ( sysadm.FN_CODE_NUM ( cmd.adr_cod_civ, '-CI' ), '' ) 'adr_cod_civ',
	IsNull ( sysadm.FN_CODE_NUM ( cmd.adr_cod_civ, '-CL' ), '' ) 'adr_cod_civ_lg',	
        IsNull ( cmd.adr_nom, '' ),                        
        IsNull ( cmd.adr_prenom, '' ),                     
        IsNull ( cmd.adr_livr1, '' ),                      
        IsNull ( cmd.adr_livr2, '' ),
        IsNull ( cmd.adr_livr_cpl, '' ),
        IsNull ( cmd.adr_cp, '' ),
        IsNull ( cmd.adr_ville, '' ),
        IsNull ( cmd.adr_tel1, '' ),
        IsNull ( cmd.adr_tel2, '' ),
        IsNull ( cmd.adr_tel3, '' ),
	sysadm.FN_EPURE_CHAINE  (
		( Select  Top 1 IsNull ( i.adr_mail, '' )
		  From   sysadm.inter i with (nolock) 
		  Where  i.id_sin = s.id_sin
		  and    i.cod_inter = 'A' )
		  ) 'adr_mail_assure', -- #4   Le 05/09/2008   JFF   [MICROMANIA]
        cmd.dte_rdv_cli,
        IsNull ( cmd.hrdv_cli_min,  '' ),                  
        IsNull ( cmd.hrdv_cli_max,  '' ),                  
        IsNull ( rtrim ( ltrim ( cmd.id_serie_anc)),  '' ),                  
        IsNull ( cmd.probleme,      '' ),                  
        IsNull ( cmd.id_cmd_frn,    '' ),                  
        IsNull ( rtrim ( ltrim ( cmd.id_serie_nouv)), '' ),                  
        IsNull ( cmd.id_bon_transp, '' ),                  
	cmd.dte_rcp_frn,                    
	cmd.dte_env_cli,                    
	cmd.cod_etat,                       
	cmd.comment_frn,                    
        IsNull ( cmd.nom_gest,      '' ),                  
	cmd.id_lot_cmd,                     
	cmd.cmd_gen_le,                     
	cmd.cmd_gen_par,                    
	cmd.cree_le,                        
	cmd.maj_le,                         
	cmd.maj_par,
	cmd.valide_le,
	cmd.valide_par,
	cmd.id_zone,
        IsNull ( cmd.id_ref_four, '' ),
        cmd.dte_elv_mobile,
        cmd.status_gc     ,
        cmd.dte_emis_devis,
        cmd.mt_devis      ,
        cmd.alt_dev_acp   ,
        cmd.dte_dev_acp  ,
        cmd.info_spb_frn,
        cmd.dte_env_bte_frn,
        ( Select Top 1 IsNull ( i.cod_mode_reg, 'C' )
          From   sysadm.inter i with ( nolock )
          Where  i.id_sin = s.id_sin
          And 	 i.cod_inter = 'A' ) 'cod_mode_reg',
        ( Select Top 1 IsNull ( i.rib_bq, '' )
          From   sysadm.inter i with ( nolock )
          Where  i.id_sin = s.id_sin
          And 	 i.cod_inter = 'A' ) 'rib_bq',
        ( Select Top 1 IsNull ( i.rib_gui, '' )
          From   sysadm.inter i with ( nolock )
          Where  i.id_sin = s.id_sin
          And 	 i.cod_inter = 'A' ) 'rib_gui',
        ( Select Top 1 IsNull ( i.rib_cpt, '' )
          From   sysadm.inter i with ( nolock )
          Where  i.id_sin = s.id_sin
          And 	 i.cod_inter = 'A' ) 'rib_cpt',
        ( Select Top 1 IsNull ( i.rib_cle, '' )
          From   sysadm.inter i with ( nolock )
          Where  i.id_sin = s.id_sin
          And 	 i.cod_inter = 'A' ) 'rib_cle',
	-- #2 [O2M] Ajout de l'assureur
	( 
	select	Top 1 cast(cie.id_cie as varchar(4))+'/'+cie.lib_cie
	from	sysadm.compagnie cie with (nolock) 
	inner join sysadm.garantie gti with (nolock) 
		on ( gti.id_prod = s.id_prod 	
		 And gti.id_rev = s.id_rev
		 And gti.id_gti = cmd.id_gti )
	inner join sysadm.police p with (nolock) 
		on ( p.id_cie = cie.id_cie And p.id_police = gti.id_police )
	) as 'assureur',
	(
	select	Top 1 p.lib_police
	from	sysadm.garantie g with (nolock),
		sysadm.police p
	Where	g.id_prod = s.id_prod 	
	And 	g.id_rev = s.id_rev
	And 	g.id_gti = cmd.id_gti 
	And	p.id_police = g.id_police
	) as 'lib_police',
	( Select Top 1 ds.val_car
	  From sysadm.div_sin ds with (nolock) 
	  Where ds.id_sin = s.id_sin
	  And   ds.nom_zone = 'type_app'
	) as 'typ_app_sin',
	( Select Top 1 sysadm.FN_CODE_CAR ( ds.val_car, '-AR' )
	  From sysadm.div_sin ds with (nolock) 
	  Where ds.id_sin = s.id_sin
	  And   ds.nom_zone = 'type_app'
	) as 'lib_typ_app_sin',
	-- #2 [O2M] Ajout dse marque et modele du sinistre
	s.marq_port as 'marq_app',
	s.modl_port as 'modl_app',
	( Select Top 1 IsNull ( d.mt_val_achat, 0 )
	  From sysadm.detail d with (nolock) 
	  where d.id_sin = cmd.id_sin
	  And   d.id_gti = cmd.id_gti
	  And   d.id_detail = cmd.id_detail ) 'mt_val_achat',
	( Select Top 1 IsNull ( dd.val_mt, 0 )
	  From sysadm.div_det dd with (nolock) 
	  where dd.id_sin = cmd.id_sin
	  And   dd.id_gti = cmd.id_gti
	  And   dd.id_detail = cmd.id_detail 
	  And   dd.nom_zone = 'mt_pec' ) 'mt_pec',
	Case -- #3 [DCMP080162] Ajout Date D'achat
		When ( 	Select 	count (*) 
			From 	sysadm.det_pro dp  with (nolock) 
		       	Where 	dp.id_prod = s.id_prod 
		       	And 	dp.id_code_dp = 42 
		       	and 	dp.id_code_car = 'A' 
		       	and 	dp.id_code_num = cmd.id_gti ) > 0 Then
		       		IsNull ( Convert ( VarChar ( 10 ) , 
						(select d.dte_det 
						from sysadm.detail d  with (nolock) 
						where d.id_sin = cmd.id_sin 
						and d.id_gti = cmd.id_gti 
						and d.id_detail = cmd.id_detail ) 
						, 103),
					 '' )
		Else IsNull ( Convert ( VarChar ( 10 ) , s.dte_ach_port , 103), '' )
	End as 'dte_achat',
	s.id_contrat_abonne, -- #4   Le 05/09/2008   JFF   [MICROMANIA]
	s.dte_decl, -- #4   Le 05/09/2008   JFF   [MICROMANIA]
	s.id_orian_boutique, -- #4   Le 05/09/2008   JFF   [MICROMANIA]
	( Select Top 1 IsNull ( b.cod_mag, '' )
	  From   sysadm.boutique b with (nolock) 
	  Where  b.id_prod = s.id_prod
	  And    b.id_boutique = s.id_orian_boutique ) 'cod_mag', -- #4   Le 05/09/2008   JFF   [MICROMANIA]
        cmd.info_spb_frn_cplt, -- #5 [FNAC_PROD_ECH_TECH]
	cmd.info_frn_spb_cplt,  -- #5 [FNAC_PROD_ECH_TECH]
	( Select Top 1 IsNull ( b.adr_ville, '' )
	  From   sysadm.boutique b with (nolock) 
	  Where  b.id_prod = s.id_prod
	  And    b.id_boutique = s.id_orian_boutique ) 'adr_ville_mag', -- #5 [FNAC_PROD_ECH_TECH]
	( Select Top 1 IsNull ( b.adr_cp, '' )
	  From   sysadm.boutique b with (nolock) 
	  Where  b.id_prod = s.id_prod
	  And    b.id_boutique = s.id_orian_boutique ) 'adr_cp_mag', -- #5 [FNAC_PROD_ECH_TECH]
	( Select Top 1 IsNull ( b.adr_tel, '' )
	  From   sysadm.boutique b with (nolock) 
	  Where  b.id_prod = s.id_prod
	  And    b.id_boutique = s.id_orian_boutique ) 'adr_tel_mag', -- #5 [FNAC_PROD_ECH_TECH]
	( Select Top 1 IsNull ( b.adr_tel, '' )
	  From   sysadm.boutique b with (nolock) 
	  Where  b.id_prod = s.id_prod
	  And    b.id_boutique = s.id_orian_boutique ) 'adr_fax_mag', -- #5 [FNAC_PROD_ECH_TECH]
	( Select Top 1 IsNull ( b.adr_nom, '' )
	  From   sysadm.boutique b with (nolock) 
	  Where  b.id_prod = s.id_prod
	  And    b.id_boutique = s.id_orian_boutique ) 'adr_nom_mag', -- #5 [FNAC_PROD_ECH_TECH]
	( Select Top 1 IsNull ( b.adr_1, '' )
	  From   sysadm.boutique b with (nolock) 
	  Where  b.id_prod = s.id_prod
	  And    b.id_boutique = s.id_orian_boutique ) 'adr_1_mag', -- #5 [FNAC_PROD_ECH_TECH]
	( Select Top 1 IsNull ( b.adr_2, '' )
	  From   sysadm.boutique b with (nolock) 
	  Where  b.id_prod = s.id_prod
	  And    b.id_boutique = s.id_orian_boutique ) 'adr_2_mag', -- #5 [FNAC_PROD_ECH_TECH]
  	( Select Top 1 IsNull ( b.responsable, '' )
	  From   sysadm.boutique b with (nolock) 
	  Where  b.id_prod = s.id_prod
	  And    b.id_boutique = s.id_orian_boutique ) 'responsable_mag', -- #5 [FNAC_PROD_ECH_TECH]
  	( Select Top 1 IsNull ( b.adr_mail, '' )
	  From   sysadm.boutique b with (nolock) 
	  Where  b.id_prod = s.id_prod
	  And    b.id_boutique = s.id_orian_boutique ) 'adr_mail_mag1', -- #5 [FNAC_PROD_ECH_TECH]
  	( Select Top 1 IsNull ( b.adr_mail_cc, '' )
	  From   sysadm.boutique b with (nolock) 
	  Where  b.id_prod = s.id_prod
	  And    b.id_boutique = s.id_orian_boutique ) 'adr_mail_cc_mag1', -- #5 [FNAC_PROD_ECH_TECH]
  	( Select Top 1 IsNull ( b.adr_mail2, '' )
	  From   sysadm.boutique b with (nolock) 
	  Where  b.id_prod = s.id_prod
	  And    b.id_boutique = s.id_orian_boutique ) 'adr_mail_mag2', -- #5 [FNAC_PROD_ECH_TECH]
  	( Select Top 1 IsNull ( b.adr_mail_cc2, '' )
	  From   sysadm.boutique b with (nolock) 
	  Where  b.id_prod = s.id_prod
	  And    b.id_boutique = s.id_orian_boutique ) 'adr_mail_cc_mag2', -- #5 [FNAC_PROD_ECH_TECH]
	Case 
		When cmd.adr_cod_civ in ( 5 ) Then IsNull ( sysadm.FN_CODE_NUM ( 4, '-CL' ), '' ) -- [PM451-1]
		Else IsNull ( sysadm.FN_CODE_NUM ( cmd.adr_cod_civ, '-CL' ), '' ) 
	End 'adr_cod_civ_long', -- #6 [DCMP090152]
	Case -- #7 [MSS_DIAG] V01
		
		-- #8 [MSS_LOT2] 
		When     sysadm.FN_CLE_VAL ( 'ENV_VERS', cmd.info_spb_frn_cplt, ';') = 'MS1' Then 0 

		When     sysadm.FN_CLE_VAL ( 'ENV_VERS', cmd.info_spb_frn_cplt, ';') = 'ATT' Then 1		
		-- #8 :[MSS_LOT2] 
		
		Else 0
	End  'aigui_MS1_ATT',	-- #7 [MSS_DIAG] V01
	( Select Top 1 rtrim ( ds.val_car )
	  From sysadm.div_sin ds with (nolock) 
	  Where ds.id_sin = s.id_sin
	  And   ds.nom_zone = 'num_fact'
	) as 'num_fact', -- #7 [MSS_DIAG] V01
	( Select Top 1 IsNull ( sysadm.FN_CODE_CAR ( rtrim ( dd.val_car), '-W1') , '' )
	  From sysadm.div_det dd with (nolock) 
	  where dd.id_sin = cmd.id_sin
	  And   dd.id_gti = cmd.id_gti
	  And   dd.id_detail = cmd.id_detail 
	  And   dd.nom_zone = 'adr_imm_pav' ) 'adr_imm_pav', -- [PC301].[LOT2]
	( Select Top 1 IsNull ( rtrim ( dd.val_car), '' )
	  From sysadm.div_det dd with (nolock) 
	  where dd.id_sin = cmd.id_sin
	  And   dd.id_gti = cmd.id_gti
	  And   dd.id_detail = cmd.id_detail 
	  And   dd.nom_zone = 'adr_imm_etg' ) 'adr_imm_etg', -- [PC301].[LOT2]
	 IsNull ( sysadm.FN_CODE_NUM ( cmd.info_spb_frn, '-IF' ), '' ) 'lib_info_spb_frn', -- [PC301].[LOT2]
	 s.num_port, -- [VDOC4513]
	 s.id_rev,   -- [PC501][EVOL10PC]
	 ( Select Top 1 w.id_evt
	   From   sysadm.w_detail w with (nolock) 
	   Where  w.id_sin = cmd.id_sin
	   And    w.id_gti = cmd.id_gti
	   And    w.id_detail = cmd.id_detail
	 ) 'id_evt', -- [PM200][LOT2][DESOX]
 	 ( Select Top 1 isnull ( p.nom, '' )  From sysadm.personne p with (nolock) where p.id_ordre = s.id_ordre ) nom_ass, -- [PC874]
	 ( Select Top 1 isnull ( p.prenom, '' )  From sysadm.personne p with (nolock) where p.id_ordre = s.id_ordre ) prenom_ass, -- [PC874]
	 ( Select Top 1 sysadm.FN_CLE_VAL('OPTION', rtrim ( d.val_car),';') From sysadm.det_pro d with (nolock) Where d.id_prod = s.id_prod and d.id_code_dp = 218 ) optiondp_218,
	  s.id_adh,	-- [PC874]
	  s.dte_surv, -- [PC929_CDISCOUNT]
	 ( Select Top 1 rtrim ( ds.val_dte )
	   From sysadm.div_sin ds with (nolock) 
	   Where ds.id_sin = s.id_sin
	   And   ds.nom_zone = 'dte_deb_gti'
	 ) as 'dte_deb_gti', -- [PC929_CDISCOUNT]
	  s.dte_fin_gti, -- [PC929_CDISCOUNT]
	 ( Select Top 1 rtrim ( ds.val_dte )
	   From sysadm.div_sin ds with (nolock) 
	   Where ds.id_sin = s.id_sin
	   And   ds.nom_zone = 'dte_livraison'
	 ) as 'dte_livraison', -- [PC929_CDISCOUNT]
	 ( IsNull ( ( 
			   Select Top 1 sysadm.FN_CLE_VAL ( 'APP_INCOMPLET', RTRIM( c1.info_frn_spb_cplt ) , ';' )
			   From sysadm.commande c1 with (nolock) 
			   Where c1.id_sin = s.id_sin
			   And sysadm.FN_CLE_VAL ( 'APP_INCOMPLET', RTRIM( c1.info_frn_spb_cplt ) , ';' ) = 'OUI' 
			   )
	   , 'NON' )
	 ) 'APP_INCOMPLET',
	 s.id_ets,
	 s.id_sdos,
	 (select Top 1 isnull(lib_gti,'') 
	   from sysadm.code_garantie cg with (nolock) 
		where cg.id_prod=s.id_prod and cg.id_gti=cmd.id_gti) 'LIB_GTI',
	( Select Top 1 isnull(ds.val_car,'')
	   From sysadm.div_sin ds with (nolock) 
	   Where ds.id_sin = s.id_sin
	   And   ds.nom_zone = 'code_verrou_sherpa_script'
	 ) as 'code_verrou', -- [PC767_1]
	 ( Select Top 1 isnull(ds.val_car,'')
	   From sysadm.div_sin ds with (nolock) 
	   Where ds.id_sin = s.id_sin
	   And   ds.nom_zone = 'desimlocke'
	 ) as 'desimlocke', -- [PC767_1]
	 s.dte_adh 'dte_adh', -- [VDOC13683]
	 ( Select Top 1 isnull(ds.val_car,'')
	   From sysadm.div_sin ds with (nolock) 
	   Where ds.id_sin = s.id_sin
	   And   ds.nom_zone = 'sku_ident_appareil'
	 ) as 'sku_ident_appareil',-- [PC13448]
	 ( Select Top 1 sysadm.FN_CLE_VAL('VARIANTE', rtrim ( d.val_car),';') From sysadm.det_pro d with (nolock) Where d.id_prod = s.id_prod and d.id_code_dp = 37 ) variante_dp37,
	 ( Select Top 1 sysadm.FN_CLE_VAL('CODE_INDEMNISATION', rtrim ( d.val_car),';') From sysadm.det_pro d with (nolock) Where d.id_prod = s.id_prod and d.id_code_dp = 37 ) code_indemn_dp37,
	   Case 
			When ISnull ( ( Select Top 1 cmd1.id_seq
				   From sysadm.commande cmd1 with (nolock) 
				   Where cmd1.id_sin = s.id_sin
				   And   sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', cmd1.info_spb_frn_cplt, ';') = 'OUI'
				   And   cmd1.cod_etat <> 'ANN'
				 ), 1000 ) < cmd.id_seq 
				 Then 
				 ( 
					Select Top 1
						   'MARQ=' + IsNull ( rtrim ( id_marq_art), '' ) + ';' +
						   'MODL=' + IsNull ( rtrim ( id_modl_art), '' ) + ';' +
						   'IMEI=' + IsNull ( rtrim ( id_serie_anc), '' ) 
					From   sysadm.commande cmd1 with (nolock) 
					Where cmd1.id_sin = s.id_sin
				    And   sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', cmd1.info_spb_frn_cplt, ';') = 'OUI'
				    And   cmd1.cod_etat <> 'ANN'
					And   cmd1.id_seq = ( 
											Select Max ( cmd2.id_seq)
											From   sysadm.commande cmd2 with (nolock)
											Where  cmd2.id_sin = cmd1.id_sin 
											And   sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', cmd2.info_spb_frn_cplt, ';') = 'OUI'
											And   cmd2.cod_etat <> 'ANN'
										) 
				 )
			Else ''
		End 'presence_a_rep_garantie'
	 
 FROM   sysadm.commande cmd with (nolock) ,
 	sysadm.produit with (nolock) ,
 	sysadm.sinistre s with (nolock) 
 WHERE  cmd.id_lot_cmd = @iIdLotCmd 
 And	cmd.id_four    = @sIdFour
 And 	cmd.id_sin = s.id_sin
 And	s.id_prod = produit.id_prod

GO

grant execute on sysadm.DW_S02_COMMANDE_V13 to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I01_COMMANDE_VAL
-- Auteur               :       Fabry JF
-- Date                 :       04/10/01
-- Libelle              :        
-- Commentaires         :       Insertion dans la table COMMANDE (D‚claration)
-- References           :       Utilis‚ dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
-- 
-- #1	JFF	06/02/2006	[SITE_CMDE] Gestion des nouvelles option d'autorisation 79, 80, 81
-- #2	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
--      JFF 21/11/20103 [VDOC12677]
--      JFF 12/02/2016  [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_COMMANDE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_COMMANDE_VAL
GO

CREATE procedure sysadm.PS_I01_COMMANDE_VAL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

Declare @dcNewIdDetail Decimal (7)
Declare @dcIdGti Decimal (7)
Declare @dcIdDetail Decimal (7)
Declare @dcIdSeq Integer


 INSERT INTO    sysadm.commande
	(	
		commande.id_sin,                         
		commande.id_seq,                         
		commande.id_gti,                         
		commande.id_detail,                      
		commande.id_four,                        
		commande.id_typ_art,                     
		commande.id_marq_art,                    
		commande.id_modl_art,                    
		commande.mt_ttc_cmde,                    
		commande.adr_nom,                        
		commande.adr_prenom,                     
		commande.adr_livr1,                      
		commande.adr_livr2,                      
		commande.adr_livr_cpl,                   
		commande.adr_cp,                         
		commande.adr_ville,                      
		commande.adr_tel1,                       
		commande.adr_tel2,                       
		commande.adr_tel3,                       
		commande.adr_mail,                       
		commande.dte_rdv_cli,                    
		commande.hrdv_cli_min,                   
		commande.hrdv_cli_max,                   
		commande.id_serie_anc,                   
		commande.probleme,                       
		commande.id_cmd_frn,                     
		commande.id_serie_nouv,                  
		commande.id_bon_transp,                  
		commande.dte_rcp_frn,                    
		commande.dte_env_cli,                    
		commande.cod_etat,                       
		commande.comment_frn,                    
		commande.nom_gest,                       
		commande.id_lot_cmd,                     
		commande.cmd_gen_le,                     
		commande.cmd_gen_par,                    
		commande.cree_le,                        
		commande.maj_le,                         
		commande.maj_par,                        
		commande.valide_le,                      
		commande.valide_par,
                commande.id_zone,
                commande.id_bsp,
                commande.dte_ret_pret,
                commande.adr_cod_civ,
                commande.id_ref_four,
                commande.id_orian_marque,
                commande.id_orian_modele,
		commande.dte_elv_mobile,
		commande.status_gc     ,
		commande.dte_emis_devis,
		commande.mt_devis      ,
		commande.alt_dev_acp   ,
		commande.dte_dev_acp   ,
		commande.adrfc_cod_civ,
		commande.adrfc_nom,
		commande.adrfc_prenom,
		commande.adrfc_livr1,
		commande.adrfc_livr2,
		commande.adrfc_livr_cpl,
		commande.adrfc_cp,
		commande.adrfc_ville,
		commande.dte_ret_logis,
		commande.dte_ret_pret_min,
		commande.dte_ret_pret_max,
		commande.id_ann,
		commande.dte_env_bte_frn,
		commande.dte_rcp_bte_cli,
		commande.dte_dep_bte_cli,
		commande.dte_env_st,
		commande.dte_rcp_mob_cli,
		commande.info_spb_frn,
                commande.id_marq_art_ifr,
                commande.id_modl_art_ifr,
        	commande.info_spb_frn_cplt, -- #1 [FNAC_PROD_ECH_TECH]
		commande.info_frn_spb_cplt  -- #1 [FNAC_PROD_ECH_TECH]

	)
 SELECT         
		 w_commande.id_sin,                         
		 w_commande.id_seq,                         
		 w_commande.id_gti,                         
		 w_commande.id_detail,                      
		 w_commande.id_four,                        
		 w_commande.id_typ_art,                     
		 w_commande.id_marq_art,                    
		 w_commande.id_modl_art,                    
		 w_commande.mt_ttc_cmde,                    
		 w_commande.adr_nom,                        
		 w_commande.adr_prenom,                     
		 w_commande.adr_livr1,                      
		 w_commande.adr_livr2,                      
		 w_commande.adr_livr_cpl,                   
		 w_commande.adr_cp,                         
		 w_commande.adr_ville,                      
		 w_commande.adr_tel1,                       
		 w_commande.adr_tel2,                       
		 w_commande.adr_tel3,                       
		 w_commande.adr_mail,                       
		 w_commande.dte_rdv_cli,                    
		 w_commande.hrdv_cli_min,                   
		 w_commande.hrdv_cli_max,                   
		 w_commande.id_serie_anc,                   
		 w_commande.probleme,                       
		 w_commande.id_cmd_frn,                     
		 w_commande.id_serie_nouv,                  
		 w_commande.id_bon_transp,                  
		 w_commande.dte_rcp_frn,                    
		 w_commande.dte_env_cli,                    
		 w_commande.cod_etat,                       
		 w_commande.comment_frn,                    
		 w_commande.nom_gest,                       
		 -- #1
		 Case Upper ( Left ( w_commande.id_four, 2 ) )
		 	When 'WB' Then -1
		 	Else 0
		 End,
		 -- /#1
		 null,
		 null,
		 w_commande.cree_le,                        
		 w_commande.maj_le,                         
		 w_commande.maj_par,
		 @dtValideLe,
		 @sCodOper,
                 w_commande.id_zone,
                 w_commande.id_bsp,
                 w_commande.dte_ret_pret,
                 w_commande.adr_cod_civ,
                 w_commande.id_ref_four,
		 -- #1 w_commande.id_orian_marque
		 Case Upper ( Left ( w_commande.id_four, 2 ) )
		 	When 'WB' Then 1
		 	Else 0
		 End,
		 -- /#1
                 w_commande.id_orian_modele,
		 w_commande.dte_elv_mobile,
		 w_commande.status_gc     ,
		 w_commande.dte_emis_devis,
		 w_commande.mt_devis      ,
		 w_commande.alt_dev_acp   ,
		 w_commande.dte_dev_acp ,
		 w_commande.adrfc_cod_civ,
		 w_commande.adrfc_nom,
		 w_commande.adrfc_prenom,
		 w_commande.adrfc_livr1,
		 w_commande.adrfc_livr2,
		 w_commande.adrfc_livr_cpl,
		 w_commande.adrfc_cp,
		 w_commande.adrfc_ville,
		 w_commande.dte_ret_logis,
		 w_commande.dte_ret_pret_min,
		 w_commande.dte_ret_pret_max,
		 w_commande.id_ann,
		 w_commande.dte_env_bte_frn,
		 w_commande.dte_rcp_bte_cli,
		 w_commande.dte_dep_bte_cli,
		 w_commande.dte_env_st,
		 w_commande.dte_rcp_mob_cli,
		 w_commande.info_spb_frn,
                 w_commande.id_marq_art_ifr,
                 w_commande.id_modl_art_ifr,
        	 w_commande.info_spb_frn_cplt, -- #1 [FNAC_PROD_ECH_TECH]
		 w_commande.info_frn_spb_cplt  -- #1 [FNAC_PROD_ECH_TECH]
		 

 FROM           sysadm.w_commande
 WHERE          w_commande.id_sin = @dcIdSin


-- [VDOC12677]
Select @dcIdGti = c.id_gti,
	   @dcIdDetail = c.id_detail,
	   @dcIdSeq = c.id_seq
From   sysadm.w_commande c
Where  c.id_sin = @dcIdSin
AND	   c.cpt_valide = 0
And    sysadm.FN_CLE_VAL ( 'CODE_BTQ_RELAI_PSM', c.info_spb_frn_cplt, ';' ) <> ''
And    c.id_four = 'PSM'

If 	@dcIdGti is not null
 Begin

	Select	@dcNewIdDetail = max ( id_detail ) 
	From	sysadm.detail
	where   id_sin = @dcIdSin
	and     id_gti = @dcIdGti 

	If @dcNewIdDetail is null Set @dcNewIdDetail = 0
	Set @dcNewIdDetail = @dcNewIdDetail + 1

	Insert into sysadm.detail 
	Select id_sin,   id_gti,   @dcNewIdDetail,   1414,   id_reg,   id_i_reg,   null,   dte_det,   heu_det, num_carte,   0,   0,   0,   0,   alt_plaf,   alt_reg,   'O',   alt_ssui,   cod_mot_ssui,   100,   100,   100,   id_carte,   id_type_carte,   getdate(),
   'AUTO',   getdate(),   getdate(),   'AUTO',   dte_cmd,   dte_livr,   mt_val_achat,   mt_val_publique,   num_facture
	From sysadm.detail d
	Where d.id_sin = @dcIdSin
	And   d.id_gti = @dcIdGti
	And   d.id_detail = @dcIdDetail

	If Exists ( Select * from w_detail where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
	  Begin
		Insert into sysadm.w_detail 
		Select id_sin,   id_gti,   @dcNewIdDetail,   1414,   null,   dte_det,   heu_det, num_carte,   0,   0,   0,   0,   null, 'N', 'N', alt_plaf,   alt_reg,   'O', 'O',  1,  alt_ssui,   cod_mot_ssui,   100,   100,   100,   id_carte,   id_type_carte, getdate()
,   getdate(),   'AUTO',   dte_cmd,   dte_livr,   mt_val_achat,   mt_val_publique,   num_facture
		From sysadm.w_detail d
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail
	  End 

	Insert into sysadm.div_det 
	Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, getdate(), getdate(),  'AUTO', getdate(), 'AUTO'
	From sysadm.div_det d
	Where d.id_sin = @dcIdSin
	And   d.id_gti = @dcIdGti
	And   d.id_detail = @dcIdDetail

	If Exists ( Select * from w_div_det where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
	  Begin
		Insert into sysadm.w_div_det 
		Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, 1, getdate(),   getdate(), 'AUTO'
		From sysadm.w_div_det d
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail			  
	  End 

	Update sysadm.commande
	Set	   id_detail = @dcNewIdDetail
	From   sysadm.commande c
	Where  c.id_sin = @dcIdSin
	AND	   c.id_seq = @dcIdSeq 
	 
	Update sysadm.w_commande
	Set	   id_detail = @dcNewIdDetail
	From   sysadm.w_commande c
	Where  c.id_sin = @dcIdSin
	AND	   c.id_seq = @dcIdSeq 

End  

 Return @@Error

GO


--------------------------------------------------------------------
--
-- Procedure            :       PS_I02_COMMANDE_VAL
-- Auteur               :       Fabry JF
-- Date                 :       04/10/01
-- Libelle              :        
-- Commentaires         :       Insertion dans la table COMMANDE (D‚claration)
-- References           :       Utilis‚ dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
--      JFF 21/11/20103 [VDOC12677]
--		JFF 12/02/2016  [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I02_COMMANDE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I02_COMMANDE_VAL
GO

CREATE procedure sysadm.PS_I02_COMMANDE_VAL
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS
Declare @dcNewIdDetail Decimal (7)
Declare @dcIdGti Decimal (7)
Declare @dcIdDetail Decimal (7)
Declare @dcIdSeq Integer

 INSERT INTO    sysadm.commande
	(	
		commande.id_sin,                         
		commande.id_seq,                         
		commande.id_gti,                         
		commande.id_detail,                      
		commande.id_four,                        
		commande.id_typ_art,                     
		commande.id_marq_art,                    
		commande.id_modl_art,                    
		commande.mt_ttc_cmde,                    
		commande.adr_nom,                        
		commande.adr_prenom,                     
		commande.adr_livr1,                      
		commande.adr_livr2,                      
		commande.adr_livr_cpl,                   
		commande.adr_cp,                         
		commande.adr_ville,                      
		commande.adr_tel1,                       
		commande.adr_tel2,                       
		commande.adr_tel3,                       
		commande.adr_mail,                       
		commande.dte_rdv_cli,                    
		commande.hrdv_cli_min,                   
		commande.hrdv_cli_max,                   
		commande.id_serie_anc,                   
		commande.probleme,                       
		commande.id_cmd_frn,                     
		commande.id_serie_nouv,                  
		commande.id_bon_transp,                  
		commande.dte_rcp_frn,                    
		commande.dte_env_cli,                    
		commande.cod_etat,                       
		commande.comment_frn,                    
		commande.nom_gest,                       
		commande.id_lot_cmd,                     
		commande.cmd_gen_le,                     
		commande.cmd_gen_par,                    
		commande.cree_le,                        
		commande.maj_le,                         
		commande.maj_par,                        
		commande.valide_le,                      
		commande.valide_par,
                commande.id_zone,
                commande.id_bsp,
                commande.dte_ret_pret,
                commande.adr_cod_civ,
                commande.id_ref_four,
                commande.id_orian_marque,
                commande.id_orian_modele,
		commande.dte_elv_mobile,
		commande.status_gc     ,
		commande.dte_emis_devis,
		commande.mt_devis      ,
		commande.alt_dev_acp   ,
		commande.dte_dev_acp   ,
		commande.adrfc_cod_civ,
		commande.adrfc_nom,
		commande.adrfc_prenom,
		commande.adrfc_livr1,
		commande.adrfc_livr2,
		commande.adrfc_livr_cpl,
		commande.adrfc_cp,
		commande.adrfc_ville,
		commande.dte_ret_logis,
		commande.dte_ret_pret_min,
		commande.dte_ret_pret_max,
		commande.id_ann,
		commande.dte_env_bte_frn,
		commande.dte_rcp_bte_cli,
		commande.dte_dep_bte_cli,
		commande.dte_env_st,
		commande.dte_rcp_mob_cli,
		commande.info_spb_frn,
                commande.id_marq_art_ifr,
                commande.id_modl_art_ifr,
        	commande.info_spb_frn_cplt, -- #1 [FNAC_PROD_ECH_TECH]
		commande.info_frn_spb_cplt  -- #1 [FNAC_PROD_ECH_TECH]
		
	)
 SELECT         
		 w_commande.id_sin,                         
		 w_commande.id_seq,                         
		 w_commande.id_gti,                         
		 w_commande.id_detail,                      
		 w_commande.id_four,                        
		 w_commande.id_typ_art,                     
		 w_commande.id_marq_art,                    
		 w_commande.id_modl_art,                    
		 w_commande.mt_ttc_cmde,                    
		 w_commande.adr_nom,                        
		 w_commande.adr_prenom,                     
		 w_commande.adr_livr1,                      
		 w_commande.adr_livr2,                      
		 w_commande.adr_livr_cpl,                   
		 w_commande.adr_cp,                         
		 w_commande.adr_ville,                      
		 w_commande.adr_tel1,                       
		 w_commande.adr_tel2,                       
		 w_commande.adr_tel3,                       
		 w_commande.adr_mail,                       
		 w_commande.dte_rdv_cli,                    
		 w_commande.hrdv_cli_min,                   
		 w_commande.hrdv_cli_max,                   
		 w_commande.id_serie_anc,                   
		 w_commande.probleme,                       
		 w_commande.id_cmd_frn,                     
		 w_commande.id_serie_nouv,                  
		 w_commande.id_bon_transp,                  
		 w_commande.dte_rcp_frn,                    
		 w_commande.dte_env_cli,                    
		 w_commande.cod_etat,                       
		 w_commande.comment_frn,                    
		 w_commande.nom_gest,                       
		 -- #1
		 Case Upper ( Left ( w_commande.id_four, 2 ) )
		 	When 'WB' Then -1
		 	Else 0
		 End,
		 -- /#1
		 null,
		 null,
		 w_commande.cree_le,                        
		 w_commande.maj_le,                         
		 w_commande.maj_par,
		 @dtValideLe,
		 @sCodOper,
                 w_commande.id_zone,
                 w_commande.id_bsp,
                 w_commande.dte_ret_pret,
                 w_commande.adr_cod_civ,
                 w_commande.id_ref_four,
		 -- #1 w_commande.id_orian_marque
		 Case Upper ( Left ( w_commande.id_four, 2 ) )
		 	When 'WB' Then 1
		 	Else 0
		 End,
		 -- /#1
                 w_commande.id_orian_modele,
		 w_commande.dte_elv_mobile,
		 w_commande.status_gc     ,
		 w_commande.dte_emis_devis,
		 w_commande.mt_devis      ,
		 w_commande.alt_dev_acp   ,
		 w_commande.dte_dev_acp   ,
		 w_commande.adrfc_cod_civ,
		 w_commande.adrfc_nom,
		 w_commande.adrfc_prenom,
		 w_commande.adrfc_livr1,
		 w_commande.adrfc_livr2,
		 w_commande.adrfc_livr_cpl,
		 w_commande.adrfc_cp,
		 w_commande.adrfc_ville,
		 w_commande.dte_ret_logis,
		 w_commande.dte_ret_pret_min,
		 w_commande.dte_ret_pret_max,
		 w_commande.id_ann,
		 w_commande.dte_env_bte_frn,
		 w_commande.dte_rcp_bte_cli,
		 w_commande.dte_dep_bte_cli,
		 w_commande.dte_env_st,
		 w_commande.dte_rcp_mob_cli,
		 w_commande.info_spb_frn,
                 w_commande.id_marq_art_ifr,
                 w_commande.id_modl_art_ifr,
		 w_commande.info_spb_frn_cplt, -- #1 [FNAC_PROD_ECH_TECH]
		 w_commande.info_frn_spb_cplt  -- #1 [FNAC_PROD_ECH_TECH]
                 
		                
 FROM           sysadm.w_commande
 WHERE          w_commande.id_sin = @dcIdSin
 AND		w_commande.cpt_valide = 0

-- [VDOC12677]
Select @dcIdGti = c.id_gti,
	   @dcIdDetail = c.id_detail,
	   @dcIdSeq = c.id_seq
From   sysadm.w_commande c
Where  c.id_sin = @dcIdSin
AND	   c.cpt_valide = 0
And    sysadm.FN_CLE_VAL ( 'CODE_BTQ_RELAI_PSM', c.info_spb_frn_cplt, ';' ) <> ''
And    c.id_four = 'PSM'

If 	@dcIdGti is not null
 Begin

	Select	@dcNewIdDetail = max ( id_detail ) 
	From	sysadm.detail
	where   id_sin = @dcIdSin
	and     id_gti = @dcIdGti 

	If @dcNewIdDetail is null Set @dcNewIdDetail = 0
	Set @dcNewIdDetail = @dcNewIdDetail + 1

	Insert into sysadm.detail 
	Select id_sin,   id_gti,   @dcNewIdDetail,   1414,   id_reg,   id_i_reg,   null,   dte_det,   heu_det, num_carte,   mt_prej,   mt_fran,   mt_nplaf,   mt_plaf,   alt_plaf,   alt_reg,   'O',   alt_ssui,   cod_mot_ssui,   cod_dec_mac,   cod_dec_ope,   cod_etat,   id_carte,   id_type_carte,   getdate(),   'AUTO',   getdate(),   getdate(),   'AUTO',   dte_cmd,   dte_livr,   mt_val_achat,   mt_val_publique,   num_facture
	From sysadm.detail d
	Where d.id_sin = @dcIdSin
	And   d.id_gti = @dcIdGti
	And   d.id_detail = @dcIdDetail

	If Exists ( Select * from w_detail where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
	  Begin
		Insert into sysadm.w_detail 
		Select id_sin,   id_gti,   @dcNewIdDetail,   1414,   null,   dte_det, heu_det, num_carte,   mt_prej,   mt_fran,   mt_nplaf,   mt_plaf,   null, 'N', 'N', alt_plaf,   alt_reg,   'O', alt_valide,  1,  alt_ssui,   cod_mot_ssui,   cod_dec_mac,   cod_dec_ope,
   cod_etat,   id_carte,   id_type_carte, getdate(),   getdate(),   'AUTO',   dte_cmd,   dte_livr,   mt_val_achat,   mt_val_publique,   num_facture
		From sysadm.w_detail d
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail
	  End 

	Insert into sysadm.div_det 
	Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, getdate(), getdate(),  'AUTO', getdate(), 'AUTO'
	From sysadm.div_det d
	Where d.id_sin = @dcIdSin
	And   d.id_gti = @dcIdGti
	And   d.id_detail = @dcIdDetail

	If Exists ( Select * from w_div_det where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
	  Begin
		Insert into sysadm.w_div_det 
		Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, 1, getdate(),   getdate(), 'AUTO'
		From sysadm.w_div_det d
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail			  
	  End 

	Update sysadm.commande
	Set	   id_detail = @dcNewIdDetail
	From   sysadm.commande c
	Where  c.id_sin = @dcIdSin
	AND	   c.id_seq = @dcIdSeq 
	 
	Update sysadm.w_commande
	Set	   id_detail = @dcNewIdDetail
	From   sysadm.w_commande c
	Where  c.id_sin = @dcIdSin
	AND	   c.id_seq = @dcIdSeq 


End  


 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_S03_COMMANDE
-- Auteur               :       Fabry JF
-- Date                 :       09/10/01
-- Libelle              :        
-- Commentaires         :       G‚n‚ration du fichier de commande
--				r‚cup‚ration d'un nouveau id_lot_cmd
--
-- Arguments            :       @sRefCpt        VarChar ( 10 )
--				@dcIdLotCmd	Decimal ( 7,0 ) OUTPUT
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S03_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.PS_S03_COMMANDE
GO

CREATE procedure sysadm.PS_S03_COMMANDE
        @sRefCpt        VarChar ( 10 ),
        @dcIdLotCmd	Decimal ( 7,0 ) OUTPUT
AS
	 EXEC sysadm.PS_X_INCREMENTER @sRefCpt, @dcIdLotCmd OUTPUT
GO

--------------------------------------------------------------------
--
-- Procedure            :       DW_S03_COMMANDE
-- Auteur               :       Fabry JF
-- Date                 :       09/10/01
-- Libelle              :        
-- Commentaires         :       Affichage des 50 derniers cr‚‚s
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.DW_S03_COMMANDE
GO

CREATE procedure sysadm.DW_S03_COMMANDE
AS

Declare @dtJour	DateTime

Select @dtJour = GetDate()


Select	c.id_four,
	cd.lib_code,
	c.id_lot_cmd,
	c.cmd_gen_le,
	c.cmd_gen_par,
	count ( * )

From	sysadm.commande c,
	sysadm.code_car cd
Where 	DATEDIFF(day, cmd_gen_le, getdate()) <= 30
And 	c.id_lot_cmd > 0
And	cd.id_typ_code = '-FR'
And	cd.id_code = c.id_four

Group by c.id_four,
	 cd.lib_code,
	 c.id_lot_cmd,
	 c.cmd_gen_le,
 	 c.cmd_gen_par
 	 
Order by cmd_gen_le desc

GO



--------------------------------------------------------------------
--
-- Procedure            :       DW_S04_COMMANDE
-- Auteur               :       Fabry JF
-- Date                 :       07/09/01
-- Libelle              :        
-- Commentaires         :       Select sur la table COMMANDE
-- References           :       Pour Stat ponctuelle
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.DW_S04_COMMANDE
GO

CREATE procedure sysadm.DW_S04_COMMANDE
        @sIdFour        VarChar ( 3 ),
        @sCodEtat       VarChar ( 3 ),
        @dcIdProd       Decimal (  7, 0 ),
        @dtValMin	DateTime,
        @dtValMax	DateTime
AS
 SELECT 
	p.id_prod Code_Produit,                         
	c.id_sin Ref_Sinistre,                         
	c.id_seq Sequence_Commande,                         
	c.id_gti Garantie,                         
	c.id_detail Detail_de_garantie,                      
	c.id_four Fournisseur_FR,                        
	c.id_typ_art Type_Article_AR,                     
	c.id_marq_art Marque_Article,                    
	c.id_modl_art Modele_Article,                    
	c.mt_ttc_cmde Montant_TTC_Commande,                    
	c.adr_nom Nom_Interlocuteur,                        
	c.adr_prenom Prenom_Interlocuteur,                     
	c.adr_livr1 Adresse_Livraison_1,                      
	c.adr_livr2 Adresse_Livraison_2,
	c.adr_livr_cpl Adresse_Livr_Compl,                      
	c.adr_cp Code_Postal,                         
	c.adr_ville Ville,                       
	c.adr_tel1 Telephone_1,                       
	c.adr_tel2 Telephone_2,                       
	c.adr_tel3 Telephone_3,                       
	c.adr_mail Mail,                       
	CONVERT(char(11), c.dte_rdv_cli, 103) + CONVERT(char(8), c.dte_rdv_cli, 108) Date_Rdv_Avec_Client,
	c.hrdv_cli_min Heure_Min_Rdv_Avec_Client,                   
	c.hrdv_cli_max Heure_Max_Rdv_Avec_Client,                   
	c.id_serie_anc Ancien_Num_IMEI,                   
	c.probleme Description_Probleme,                       
	c.id_cmd_frn Num_Commande_Fournisseur,                     
	c.id_serie_nouv Nouveau_Num_IMEI,                  
	c.id_bon_transp Num_Bon_Transporteur,                  
	CONVERT(char(11), c.dte_rcp_frn, 103) + CONVERT(char(8), c.dte_rcp_frn, 108) Date_Reception_Chez_Fourn,
	CONVERT(char(11), c.dte_env_cli, 103) + CONVERT(char(8), c.dte_env_cli, 108) Date_Envoi_Chez_Client_ou_SPB,
	c.cod_etat Etat_Commande,                       
	c.comment_frn Commentaire_Fournisseur,                    
	c.nom_gest Gestionnaire_Ayant_Traite,                       
	c.id_lot_cmd Num_Lot_Commande,                     
	CONVERT(char(11), c.cmd_gen_le, 103) + CONVERT(char(8), c.cmd_gen_le, 108) Commande_Generee_Le,
	c.cmd_gen_par Commande_Generee_Par,                    
	CONVERT(char(11), c.cree_le, 103) + CONVERT(char(8), c.cree_le, 108) Commande_Cree_Le,
	CONVERT(char(11), c.maj_le, 103) + CONVERT(char(8), c.maj_le, 108) Commande_Maj_Le,
	c.maj_par Commande_Maj_Par,
	CONVERT(char(11), c.valide_le, 103) + CONVERT(char(8), c.valide_le, 108) Commande_Valide_Le,
	c.valide_par Commande_Valide_Par,
	CONVERT(char(11), c.dte_ret_pret, 103) + CONVERT(char(8), c.dte_ret_pret, 108) Retour_Pret,
	c.id_ref_four Reference_Art_fournisseur,
	CONVERT(char(11), c.dte_elv_mobile, 103) + CONVERT(char(8), c.dte_elv_mobile, 108) Enlevement_Mobile,
	c.status_gc Status_Gti_Constructeur,
	CONVERT(char(11), c.dte_emis_devis, 103) + CONVERT(char(8), c.dte_emis_devis, 108) Emission_Devis_Par_Fourn,
	c.mt_devis Mt_Devis_Par_Fourn,
	c.alt_dev_acp Devis_Accepte_Par_Client,
	CONVERT(char(11), c.dte_dev_acp, 103) + CONVERT(char(8), c.dte_dev_acp, 108) Date_Acceptation_Devis_Par_C,
	c.adrfc_nom Fact_Nom,
	c.adrfc_prenom Fact_Prenom,
	c.adrfc_livr1 Fact_Livr1,
	c.adrfc_livr2 Fact_Livr2,
	c.adrfc_livr_cpl Fact_Livr_Cpl,
	c.adrfc_cp Fact_CP,
	c.adrfc_ville Fact_Ville,
	CONVERT(char(11), c.dte_ret_logis, 103) + CONVERT(char(8), c.dte_ret_logis, 108) Date_Ret_Chez_Logis,
	CONVERT(char(11), c.dte_ret_pret_min, 103) + CONVERT(char(8), c.dte_ret_pret_min, 108) Date_Ret_Pret_Prev_MIN,
	CONVERT(char(11), c.dte_ret_pret_max, 103) + CONVERT(char(8), c.dte_ret_pret_max, 108) Date_Ret_Pret_Prev_MAX,
	c.id_ann Categorie_Annulation,
	CONVERT(char(11), c.dte_env_bte_frn, 103) + CONVERT(char(8), c.dte_env_bte_frn, 108) Dte_Envoi_Boite_Vide,
	CONVERT(char(11), c.dte_rcp_bte_cli, 103) + CONVERT(char(8), c.dte_rcp_bte_cli, 108) Dte_Rcp_Boite_par_Cli,
	CONVERT(char(11), c.dte_dep_bte_cli, 103) + CONVERT(char(8), c.dte_dep_bte_cli, 108) Dte_Dep_Boite_par_Cli,
	CONVERT(char(11), c.dte_env_st, 103) + CONVERT(char(8), c.dte_env_st, 108) Dte_Env_ST_par_Logis,
	CONVERT(char(11), c.dte_rcp_mob_cli, 103) + CONVERT(char(8), c.dte_rcp_mob_cli, 108) Dte_Rcp_Mob_Par_Cli,
	( Select cIF.lib_code
	  From code cIF
	  Where cIF.id_typ_code = '-IF'
	  And 	cIF.id_code = c.info_spb_frn ) Info_SPB_vers_FOURN,
        c.id_marq_art_ifr  Marque_Article_IFR,
        c.id_modl_art_ifr  Modele_Article_IFR,
	c.info_spb_frn_cplt, -- #1 [FNAC_PROD_ECH_TECH]
	c.info_frn_spb_cplt  -- #1 [FNAC_PROD_ECH_TECH]


	
 FROM   sysadm.commande c,
 	sysadm.sinistre s,
 	sysadm.produit p
 WHERE  ( c.id_four  = @sIdFour  Or @sIdFour  = '*' ) 
 And 	( c.cod_etat = @sCodEtat Or @sCodEtat = '*' ) 
 And 	c.id_sin  = s.id_sin
 And 	s.id_prod = p.id_prod
 And 	( p.id_prod = @dcIdProd  Or @dcIdProd = 0 )
 And 	c.valide_le between @dtValMin And @dtValMax
 And 	c.cod_etat <> 'CNV'


UNION ALL

 SELECT 
 	p.id_prod,                         
 	wc.id_sin,                         
 	wc.id_seq,                         
 	wc.id_gti,                         
 	wc.id_detail,                      
 	wc.id_four,                        
 	wc.id_typ_art,                     
 	wc.id_marq_art,                    
 	wc.id_modl_art,                    
 	wc.mt_ttc_cmde,                    
 	wc.adr_nom,                        
 	wc.adr_prenom,                     
 	wc.adr_livr1,                      
 	wc.adr_livr2,                      
 	wc.adr_livr_cpl,                   
 	wc.adr_cp,                         
 	wc.adr_ville,                      
 	wc.adr_tel1,                       
 	wc.adr_tel2,                       
 	wc.adr_tel3,                       
 	wc.adr_mail,                       
	CONVERT(char(11), wc.dte_rdv_cli, 103) + CONVERT(char(8), wc.dte_rdv_cli, 108),
 	wc.hrdv_cli_min,                   
 	wc.hrdv_cli_max,                   
 	wc.id_serie_anc,                   
 	wc.probleme,                       
 	wc.id_cmd_frn,                     
 	wc.id_serie_nouv,                  
 	wc.id_bon_transp,                  
	CONVERT(char(11), wc.dte_rcp_frn, 103) + CONVERT(char(8), wc.dte_rcp_frn, 108),
	CONVERT(char(11), wc.dte_env_cli, 103) + CONVERT(char(8), wc.dte_env_cli, 108),
 	wc.cod_etat,                       
 	wc.comment_frn,                    
 	wc.nom_gest,                       
 	null,                     
 	null,                     
 	null,                    
	CONVERT(char(11), wc.cree_le, 103) + CONVERT(char(8), wc.cree_le, 108),
	CONVERT(char(11), wc.maj_le, 103) + CONVERT(char(8), wc.maj_le, 108),
 	wc.maj_par,
 	null,
 	null,
	CONVERT(char(11), wc.dte_ret_pret, 103) + CONVERT(char(8), wc.dte_ret_pret, 108),
	wc.id_ref_four,
	CONVERT(char(11), wc.dte_elv_mobile, 103) + CONVERT(char(8), wc.dte_elv_mobile, 108),
	wc.status_gc,
	CONVERT(char(11), wc.dte_emis_devis, 103) + CONVERT(char(8), wc.dte_emis_devis, 108),
	wc.mt_devis,
	wc.alt_dev_acp,
	CONVERT(char(11), wc.dte_dev_acp, 103) + CONVERT(char(8), wc.dte_dev_acp, 108),
	wc.adrfc_nom Fact_Nom,
	wc.adrfc_prenom Fact_Prenom,
	wc.adrfc_livr1 Fact_Livr1,
	wc.adrfc_livr2 Fact_Livr2,
	wc.adrfc_livr_cpl Fact_Livr_Cpl,
	wc.adrfc_cp Fact_CP,
	wc.adrfc_ville Fact_Ville,
	CONVERT(char(11), wc.dte_ret_logis, 103) + CONVERT(char(8), wc.dte_ret_logis, 108),
	CONVERT(char(11), wc.dte_ret_pret_min, 103) + CONVERT(char(8), wc.dte_ret_pret_min, 108),
	CONVERT(char(11), wc.dte_ret_pret_max, 103) + CONVERT(char(8), wc.dte_ret_pret_max, 108),
	wc.id_ann,
	CONVERT(char(11), wc.dte_env_bte_frn, 103) + CONVERT(char(8), wc.dte_env_bte_frn, 108),
	CONVERT(char(11), wc.dte_rcp_bte_cli, 103) + CONVERT(char(8), wc.dte_rcp_bte_cli, 108),
	CONVERT(char(11), wc.dte_dep_bte_cli, 103) + CONVERT(char(8), wc.dte_dep_bte_cli, 108),
	CONVERT(char(11), wc.dte_env_st, 103) + CONVERT(char(8), wc.dte_env_st, 108),
	CONVERT(char(11), wc.dte_rcp_mob_cli, 103) + CONVERT(char(8), wc.dte_rcp_mob_cli, 108),
	( Select cIF.lib_code
	  From code cIF
	  Where cIF.id_typ_code = '-IF'
	  And 	cIF.id_code = wc.info_spb_frn ) Info_SPB_vers_FRN,
        wc.id_marq_art_ifr  Marque_Article_PROV_IFR,
        wc.id_modl_art_ifr  Modele_Article_PROV_IFR,
        wc.info_spb_frn_cplt, -- #1 [FNAC_PROD_ECH_TECH]
	wc.info_frn_spb_cplt  -- #1 [FNAC_PROD_ECH_TECH]
        
 	
  FROM   sysadm.w_commande wc,
  	sysadm.w_sin ws,
  	sysadm.produit p
  WHERE  ( wc.id_four  = @sIdFour  Or @sIdFour  = '*' ) 
  And 	( wc.cod_etat = @sCodEtat Or @sCodEtat = '*' ) 
  And 	wc.id_sin  = ws.id_sin
  And 	ws.id_prod = p.id_prod
  And 	( p.id_prod = @dcIdProd  Or @dcIdProd = 0 )
  And 	wc.cod_etat = 'CNV'
  
GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_U02_COMMANDE_VAL_V01
-- Auteur               :       FABRY JF
-- Date                 :       16/10/2001
-- Libelle              :        
-- Commentaires         :       Modification dans la table  COMMANDE (Compl‚ment)
-- References           :       (Seulement pour les enregistrements modifi‚s dans le cas d'une
--				annulation de commande)
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-- #1  JFF	  06/02/2006    [SITE_CMDE] Gestion des nouvelles option d'autorisation 79, 80, 81
-- #2  PHG	  27/11/2007	[O2M]	Gestion Process O2M
-- #3  JFF        05/09/2008 	[MICROMANIA]
-- #4  JFF	  20/04/2009    [DCMP090102] CDP
-- #5  JFF	  20/04/2009    [DCMP090140] PAP
-- #6  JFF  	  10/06/2009    [RUEDUCOMMERCE]
-- #7  JFF        02/09/2009    [DCMP090327].[SBETV]
-- #8  JFF        28/10/2009    [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
-- #9  JFF        27/11/2009    [MSS_DIAG]
-- #10 JFF        02/03/2010    [MSS_LOT2] 
--     JFF	  13/04/2010  	[WEBSIM2].[FRANCE] Ajout WBB
--     JFF        30/06/2010    [PC363_AUCHAN]
--     JFF	  28/07/2010  	[PC321]
--     JFF        02/08/2010    Shunt vers PS_U02_COMMANDE_VAL_V02 suite problème.
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U02_COMMANDE_VAL_V01' AND type = 'P' )
        DROP procedure sysadm.PS_U02_COMMANDE_VAL_V01
GO


CREATE procedure sysadm.PS_U02_COMMANDE_VAL_V01
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

Declare @iRet integer

Exec @iRet = sysadm.PS_U02_COMMANDE_VAL_V02 @dcIdSin, @sCodOper, @dtValideLe

Return @iRet

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_U02_COMMANDE_VAL_V02
-- Auteur               :       FABRY JF
-- Date                 :       16/10/2001
-- Libelle              :        
-- Commentaires         :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-- JFF  14/09/2011  [VDOC5021]
-- JFF  23/05/2012  [PM103][1]
-- JFF  30/08/2012  [VDOC8041]
-- JFF  07/05/2013  [PC938_ORANGE_V3]
-- JFF  13/01/2014  [PM246]
-- JFF  09/04/2015  [DT141]
-- JFF  24/11/2015  [ITSM343686]
-- JFF      12/02/2016   [PI062]
-- FPI	28/04/2017	[PC151255] Mise à jour de commandes SCR
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U02_COMMANDE_VAL_V02' AND type = 'P' )
        DROP procedure sysadm.PS_U02_COMMANDE_VAL_V02
GO


CREATE  procedure sysadm.PS_U02_COMMANDE_VAL_V02
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS


Declare @sVal 	VarChar ( 30 )

-- [VDOC5021] 
If Exists ( Select * 
	    From sysadm.w_commande w,
		 sysadm.commande c
	    Where w.id_sin = @dcIdSin 
	    And   c.id_sin = w.id_sin
	    And   c.id_seq = w.id_seq
	    And   w.cod_etat = 'ANN'
	    And   c.cod_etat <> 'ANN'
	    And   c.id_lot_cmd > 0
	    And   w.cpt_valide > 0
	    And	  Not (     c.id_ref_four = 'A_DIAGNOSTIQUER' 
	    		And c.status_gc <=0 
	    		And Exists ( 
				Select * 
				From sysadm.autorisation a
				Where a.id_oper = @sCodOper
				And   a.id_nat_oper = 218
	    		           )
	    	      )
	   )
    And Not Exists ( 	Select * 
    			From sysadm.autorisation a
    		 	Where a.id_oper = @sCodOper
    		 	And   a.id_nat_oper = 213 )
  		 	
	Begin
		-- Cas ou l'annulation est passé alors que la commande n'est pas encore générée.
		-- Mais la commande se trouve générée avant que l'annulation ne soit validée.
		Return -1001
	End 

-- #10 [MSS_LOT2]
If Exists ( Select * 
	    From sysadm.w_commande w,
		 sysadm.commande c
	    Where w.id_sin = @dcIdSin 
	    And   c.id_sin = w.id_sin
	    And   c.id_seq = w.id_seq
	    And   w.cod_etat = 'ANN'
	    And   c.cod_etat <> 'ANN'
	    And   c.id_lot_cmd >= -1  	
	    And   w.cpt_valide > 0 )

	Begin
		UPDATE sysadm.commande
		 SET    
			 sysadm.commande.cod_etat	=	w_commande.cod_etat	,
			 sysadm.commande.id_ann		=	w_commande.id_ann	,
			 sysadm.commande.nom_gest	=	w_commande.nom_gest 	,
			 sysadm.commande.id_lot_cmd	=	
			 	Case 
					When id_lot_cmd in ( 0, -1) Then 999999
					When id_lot_cmd > 0 And w_commande.id_four in ( 'FNC' ) AND w_commande.id_typ_art = 'CAF' Then 0
					When id_lot_cmd > 0 Then id_lot_cmd 
				End, 
			 
			 sysadm.commande.maj_le		=	w_commande.maj_le	,
			 sysadm.commande.maj_par	=	w_commande.maj_par	,
			 sysadm.commande.valide_le	=	@dtValideLe     	,
			 sysadm.commande.valide_par	=	@sCodOper       	,
		
			 sysadm.commande.cmd_gen_le	=	
				Case 
					When id_lot_cmd > 0 And w_commande.id_four in ( 'FNC' ) AND w_commande.id_typ_art = 'CAF' Then null
					Else cmd_gen_le
				End,
			 sysadm.commande.cmd_gen_par	=	
				Case 
					When id_lot_cmd > 0 And w_commande.id_four in ( 'FNC' ) AND w_commande.id_typ_art = 'CAF' Then null
					Else cmd_gen_par
				End 
		
		 FROM   sysadm.commande,
			sysadm.w_commande
		 WHERE  w_commande.id_sin         = @dcIdSin              AND
			commande.id_sin		  = w_commande.id_sin	  AND
			commande.id_seq		  = w_commande.id_seq	  AND
			w_commande.cpt_valide     > 0			  AND
			w_commande.cod_etat 	  = 'ANN'		  AND
			commande.cod_etat 	  <> 'ANN'		  AND
			commande.id_lot_cmd	  >= -1  		  
	End

-- #10 [MSS_LOT2]
If Exists ( Select * 
	    From sysadm.w_commande w
	    Where w.id_sin = @dcIdSin 
	    And   w.cpt_valide > 0
	    And   w.cod_etat = 'CNV'
	    And   w.id_four = 'MS1'
	    And   w.id_typ_art = 'EDI'
	    And   w.id_ref_four = 'A_DIAGNOSTIQUER'
	    And   sysadm.FN_CLE_VAL ( 'MAJ_PRS', w.info_spb_frn_cplt, ';') = 'OUI' ) 
	Begin
		
		UPDATE sysadm.commande
		 SET    
			 sysadm.commande.cod_etat	=	'ECT'	,
			 sysadm.commande.id_lot_cmd	=	0	,
			 sysadm.commande.cmd_gen_le	=	null	,
			 sysadm.commande.cmd_gen_par	=	null	,
			 sysadm.commande.info_spb_frn   =       w_commande.info_spb_frn ,
			 sysadm.commande.info_spb_frn_cplt= 	sysadm.FN_CLE_VAL_E ( 'MAJ_PRS', 'NON', rTrim ( w_commande.info_spb_frn_cplt ), ';')
			 	 
		 FROM   sysadm.commande,
			sysadm.w_commande
		 WHERE  w_commande.id_sin         = @dcIdSin              AND
			commande.id_sin		  = w_commande.id_sin	  AND
			commande.id_seq		  = w_commande.id_seq	  AND
			w_commande.cpt_valide     > 0			  AND
			w_commande.cod_etat 	  = 'CNV'		  AND
			w_commande.id_four	  = 'MS1' 		  AND
			w_commande.id_typ_art 	  = 'EDI'   		  AND
			w_commande.id_ref_four 	  = 'A_DIAGNOSTIQUER'     AND
			sysadm.FN_CLE_VAL ( 'MAJ_PRS', w_commande.info_spb_frn_cplt, ';') = 'OUI' AND
			commande.id_lot_cmd	  > 0 	

		UPDATE sysadm.w_commande
		 SET     info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'MAJ_PRS', 'NON', rTrim ( info_spb_frn_cplt ), ';')
		FROM   sysadm.w_commande
		 WHERE  w_commande.id_sin = @dcIdSin
		And  sysadm.FN_CLE_VAL ( 'MAJ_PRS', info_spb_frn_cplt, ';') = 'OUI'
	End
-- :#10 [MSS_LOT2]

-- #10 [MSS_LOT2]
If Exists ( Select * 
	    From sysadm.w_commande w,
		 sysadm.commande c
	    Where w.id_sin = @dcIdSin 
	    And   c.id_sin = w.id_sin
	    And   c.id_seq = w.id_seq
	    And   w.cod_etat = 'RFO'
	    And   c.cod_etat <> 'RFO' )
	Begin
		UPDATE sysadm.commande
		 SET    sysadm.commande.cod_etat  = w_commande.cod_etat
		 FROM   sysadm.commande,
			sysadm.w_commande
		 WHERE  w_commande.id_sin         = @dcIdSin              AND
			commande.id_sin		  = w_commande.id_sin	  AND
			commande.id_seq		  = w_commande.id_seq	  AND
			w_commande.cod_etat 	  = 'RFO'		  AND
			commande.cod_etat	  <> 'RFO'
	End
-- :#10 [MSS_LOT2]

-- [PC321] 
If Exists ( Select * 
	    From sysadm.w_commande w,
		 sysadm.commande c
	    Where w.id_sin = @dcIdSin 
	    And   c.id_sin = w.id_sin
	    And   c.id_seq = w.id_seq
	    And   w.id_four = 'SCR'
	    --And   w.cod_etat = 'ECT'
	    --And   w.id_typ_art = 'PRS'   		      
	    And   w.cpt_valide > 0 )
	Begin
		UPDATE sysadm.commande
		 SET    
			 sysadm.commande.info_spb_frn   =	w_commande.info_spb_frn ,
			 sysadm.commande.maj_le		=	w_commande.maj_le	,
			 sysadm.commande.maj_par	=	w_commande.maj_par	,
			 sysadm.commande.valide_le	=	@dtValideLe     	,
			 sysadm.commande.valide_par	=	@sCodOper       	
		
		FROM   sysadm.commande,
		       sysadm.w_commande
		WHERE  w_commande.id_sin          = @dcIdSin              AND
		       commande.id_sin		  = w_commande.id_sin	  AND
		       commande.id_seq		  = w_commande.id_seq	  AND
		       w_commande.cpt_valide     > 0			  AND
		       --w_commande.cod_etat 	  = 'ECT'		  AND       
		       --w_commande.id_typ_art 	  = 'PRS'		AND
		       w_commande.id_four	  = 'SCR' 		 		       
	End
-- [PC321]        

-- [PM103][1]
If Exists ( Select * 
    From sysadm.w_commande w
    Where w.id_sin = @dcIdSin 
    And   w.cpt_valide > 0
	AND	  sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', w.info_spb_frn_cplt, ';') = 'OUI' )
 Begin
	UPDATE sysadm.commande
	 SET    
		sysadm.commande.mt_ttc_cmde= w.mt_ttc_cmde,
		sysadm.commande.id_cmd_frn= w.id_cmd_frn,
		sysadm.commande.id_serie_nouv= w.id_serie_nouv,
		sysadm.commande.id_bon_transp= w.id_bon_transp,
		sysadm.commande.dte_rcp_frn= w.dte_rcp_frn,
		sysadm.commande.dte_env_cli= w.dte_env_cli,
		sysadm.commande.cod_etat= w.cod_etat,
		sysadm.commande.comment_frn= w.comment_frn,
		sysadm.commande.status_gc= w.status_gc,
		sysadm.commande.dte_env_bte_frn= w.dte_env_bte_frn,
		sysadm.commande.dte_rcp_mob_cli= w.dte_rcp_mob_cli,
		sysadm.commande.info_frn_spb_cplt = w.info_frn_spb_cplt,
		sysadm.commande.maj_le=w.maj_le,
		sysadm.commande.maj_par=w.maj_par

	 FROM   sysadm.commande,
		    sysadm.w_commande w
	 WHERE  w.id_sin         = @dcIdSin              
	 And	commande.id_sin		  = w.id_sin
	 And 	commande.id_seq		  = w.id_seq
	 And    w.cpt_valide     > 0
 End 
-- :[PM103][1]

-- Si ça fonctionne bien, cela englobe la vDoc8041 qui n'est pas à activer.
-- [PC938_ORANGE_V3]
-- [PM246]
-- [DT141] SBE
If Exists ( Select * 
		From sysadm.w_commande w
		Where w.id_sin = @dcIdSin 
		And   w.cpt_valide > 0
		And   w.cod_etat = 'CNV'
		And   sysadm.FN_CLE_VAL ( 'MAJ_PRS', w.info_spb_frn_cplt, ';') = 'OUI' ) 
	Begin
		
		UPDATE sysadm.commande
		 SET    
			 sysadm.commande.cod_etat	=	Case  -- [PM246]
												When sysadm.FN_CLE_VAL ( 'MAJ_ADRESSE', w_commande.info_spb_frn_cplt, ';') = 'OUI' Then sysadm.FN_CLE_VAL ( 'COD_ETAT', w_commande.info_spb_frn_cplt, ';')
												Else 'ECT'
											End	,
			 sysadm.commande.id_lot_cmd	=	0	,
			 sysadm.commande.cmd_gen_le	=	null	,
			 sysadm.commande.cmd_gen_par	=	null	,
			 sysadm.commande.adr_cod_civ = w_commande.adr_cod_civ, -- [PM246]
			 sysadm.commande.adr_nom = w_commande.adr_nom, -- [PM246]
			 sysadm.commande.adr_prenom = w_commande.adr_prenom , -- [PM246]
			 sysadm.commande.adr_livr1 = w_commande.adr_livr1, -- [PM246]
			 sysadm.commande.adr_livr2 = w_commande.adr_livr2, -- [PM246]			 
			 sysadm.commande.adr_livr_cpl = w_commande.adr_livr_cpl, -- [PM246]			 
			 sysadm.commande.adr_cp = w_commande.adr_cp, -- [PM246]			 			 
			 sysadm.commande.adr_ville = w_commande.adr_ville, -- [PM246]
			 sysadm.commande.adr_tel1 = w_commande.adr_tel1, -- [PM246]
			 sysadm.commande.adr_tel2 = w_commande.adr_tel2, -- [PM246]			 
			 sysadm.commande.adr_tel3 = w_commande.adr_tel3, -- [PM246]			 			 
			 sysadm.commande.info_spb_frn_cplt= sysadm.FN_CLE_VAL_E ( 'MAJ_PRS', 'NON', rTrim ( w_commande.info_spb_frn_cplt ), ';')
			 	 
		 FROM   sysadm.commande,
			    sysadm.w_commande
		 WHERE  w_commande.id_sin         = @dcIdSin              AND
			commande.id_sin		  = w_commande.id_sin	  AND
			commande.id_seq		  = w_commande.id_seq	  AND
			w_commande.cpt_valide     > 0			  AND
			w_commande.cod_etat 	  = 'CNV'		  AND
			sysadm.FN_CLE_VAL ( 'MAJ_PRS', w_commande.info_spb_frn_cplt, ';') = 'OUI' AND
			commande.id_lot_cmd	  > 0 	

		UPDATE sysadm.w_commande
		 SET     info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'MAJ_PRS', 'NON', rTrim ( info_spb_frn_cplt ), ';'),
 				 cod_etat	=	Case  -- [PM246]
									When sysadm.FN_CLE_VAL ( 'MAJ_ADRESSE', w_commande.info_spb_frn_cplt, ';') = 'OUI' Then sysadm.FN_CLE_VAL ( 'COD_ETAT', w_commande.info_spb_frn_cplt, ';')
									Else 'ECT'
								End	
		FROM   sysadm.w_commande
		WHERE  w_commande.id_sin = @dcIdSin
		And  sysadm.FN_CLE_VAL ( 'MAJ_PRS', info_spb_frn_cplt, ';') = 'OUI'
		
	End

 Return @@Error

GO

grant execute on sysadm.PS_U02_COMMANDE_VAL_V02 to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procedure            :       DW_S05_COMMANDE
-- Auteur               :       Fabry JF
-- Date                 :       04/02/02
-- Libelle              :       DCMP 020032 Sonia Heroug 
-- Commentaires         :       Extraction mensuelle des PRS AXA COURTAGE g‚n‚r‚e dans le mois pour EA (R‚siliation)
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S05_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.DW_S05_COMMANDE
GO

/*-------------------------------------------------------------------
[DATABASE] SIMPA2_PRO
[DESCRIPTION] 
[MAJ PAR] DATAFLY - AFX
[DATEMAJ] 15/10/2009

[VARIABLES]
    @dtDteDeb DATETIME,
    @dtDteFin DATETIME,
    @idProd DECIMAL(7, 0)
-------------------------------------------------------------------*/
CREATE PROCEDURE [sysadm].[DW_S05_COMMANDE]
    @dtDteDeb DATETIME,
    @dtDteFin DATETIME,
    @idProd DECIMAL(7, 0)
AS 
    SELECT DISTINCT
            p.cod_prod_dms,
            REPLICATE('0', 5 - DATALENGTH(CONVERT (VARCHAR(5), s.id_ets)))
            + CONVERT (VARCHAR(5), s.id_ets) id_ets,
            REPLICATE('0', 7 - DATALENGTH(s.id_adh)) + s.id_adh id_adh,
            s.id_sdos,
            s.cod_opt,
            CONVERT(CHAR(8), c.cree_le, 112) cree_le,
            po.lib_police Police,
            cie.lib_cie Compagnie,
            s.id_prod,
            s.id_sin
    FROM    sysadm.sinistre s,
            sysadm.produit p,
            sysadm.commande c,
            sysadm.garantie g,
            sysadm.police po,
            sysadm.compagnie cie
    WHERE   s.id_prod = p.id_prod
            AND p.id_prod = @idProd
            AND s.id_sin = c.id_sin
            AND c.id_typ_art IN ( 'PRS', 'TEL' )
            AND c.cree_le BETWEEN @dtDteDeb AND @dtDteFin
            AND g.id_prod = s.id_prod
            AND g.id_rev = s.id_rev
            AND g.id_gti = c.id_gti
            AND g.id_police = po.id_police
            AND po.id_cie = cie.id_cie
            AND cie.id_cie = 42
    ORDER BY CONVERT(CHAR(8), c.cree_le, 112)

-- po.id_cie = 42  42=AXA COURTAGE

GO


--------------------------------------------------------------------
--
-- Procedure            :       DW_S07_COMMANDE
-- Auteur               :       Abdmeziem Catherine
-- Date                 :       08/10/02
-- Libelle              :        
-- Commentaires         :       Select sur la table COMMANDE CEGETEL
-- References           :       Pour g‚n‚ration du fichier de commande
--
-- Arguments            :       @sIdFour        Varchar ( 3 )        (Val)
--
-- Retourne             :       Rien
--
-- JFF      26/08/2013   [DT57_CMDE_IPHONE_SFR]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S07_COMMANDE_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S07_COMMANDE_V01
GO

CREATE procedure sysadm.DW_S07_COMMANDE_V01
	@iIdLotCmd	Integer,
	@sIdFour	VarChar ( 3 )
AS
 SELECT 
	c.id_sin,                         
	c.id_seq,                         
	c.id_gti,                         
	c.id_detail,
	p.id_prod,
	p.lib_court,
	IsNull ( p.id_prod_client, '' ),
	IsNull ( s.id_contrat_abonne, Replicate ('0', 8 ) ),
	c.id_four,                        
	c.id_typ_art,                     
	c.id_marq_art,                    
	c.id_modl_art,                    
	c.mt_ttc_cmde,                    
	IsNull ( c.adr_nom, '' ), 
	IsNull ( c.adr_prenom, '' ),
	IsNull ( c.adr_livr1, '' ),                      
	IsNull ( c.adr_livr2, '' ),
	IsNull ( c.adr_livr_cpl, '' ),
	IsNull ( c.adr_cp, '' ),
	IsNull ( c.adr_ville, '' ),                      
	IsNull ( c.adr_tel1, '' ),                       
	IsNull ( c.adr_tel2, '' ),                       
	IsNull ( c.adr_tel3, '' ),                       
	IsNull ( c.adr_mail, '' ),                       
	c.dte_rdv_cli,                    
	c.hrdv_cli_min,                   
	c.hrdv_cli_max,                   
	c.id_serie_anc,                   
	c.probleme,                       
	c.id_cmd_frn,                     
	c.id_serie_nouv,                  
	c.id_bon_transp,                  
	c.dte_rcp_frn,                    
	c.dte_env_cli,                    
	c.cod_etat,                       
	c.comment_frn,                    
	c.nom_gest,                       
	c.id_lot_cmd,                     
	c.cmd_gen_le,                     
	c.cmd_gen_par,                    
	c.cree_le,                        
	c.maj_le,                         
	c.maj_par,
	c.valide_le,
	c.valide_par,
	c.id_zone,
	c.id_bsp,
	c.dte_ret_pret,
	IsNull ( cdCIVLIVR.lib_code, '' ),
	c.id_ref_four,
	c.id_orian_marque,
	c.id_orian_modele,
	s.id_hlr,
	IsNull ( cdCIVFACT.lib_code, '' ),
	IsNull ( c.adrfc_nom, '' ),
	IsNull ( c.adrfc_prenom, '' ),
	IsNull ( c.adrfc_livr1, '' ),
	IsNull ( c.adrfc_livr2, '' ),
	IsNull ( c.adrfc_livr_cpl, '' ),
	IsNull ( c.adrfc_cp, '' ),
	IsNull ( c.adrfc_ville, '' ),
	c.dte_ret_logis,
	c.dte_ret_pret_min,
	c.dte_ret_pret_max,
	c.id_ann,
	'CTG ANNULATION',
	c.info_frn_spb_cplt, -- [DT57_CMDE_IPHONE_SFR]
	c.info_spb_frn_cplt  -- [DT57_CMDE_IPHONE_SFR]
	
 FROM   sysadm.commande c,
 	sysadm.produit p,
 	sysadm.sinistre s,
	sysadm.code cdCIVLIVR,
	sysadm.code cdCIVFACT
	
 WHERE  c.id_lot_cmd = @iIdLotCmd
 And	c.id_four    = @sIdFour
 And 	c.id_sin = s.id_sin
 And	s.id_prod = p.id_prod
 And	c.adr_cod_civ = convert ( Char ( 1 ) , cdCIVLIVR.id_code )
 And	cdCIVLIVR.id_typ_code = '-CI'
 And	c.adrfc_cod_civ = convert ( Char ( 1 ) , cdCIVFACT.id_code )
 And	cdCIVFACT.id_typ_code = '-CI'

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_S04_COMMANDE
-- Auteur               :       Abdmeziem Catherine
-- Date                 :       09/10/02
-- Libelle              :        
-- Commentaires         :       G‚n‚ration du fichier de commande pour Cegetel
--				r‚cup‚ration d'un nouveau cpt_cmd (ancien + x nouvelles commandes)
--				de la table produit
--
-- Arguments            :       @dcIdProd       Decimal ( 7, 0)
--				@iCptCmd	Integer		 OUTPUT
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S04_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.PS_S04_COMMANDE
GO

CREATE procedure sysadm.PS_S04_COMMANDE
        @dcIdProd	Decimal ( 7, 0),
	@iNbCmdes	Integer,
        @iCptCmd	Integer OUTPUT
AS

	Update	sysadm.produit
        Set     sysadm.produit.cpt_cmd   = sysadm.produit.cpt_cmd + @iNbCmdes
	Where	id_prod	= @dcIdProd
	
	If @@rowcount = 0	Return -1
	
	Select	@iCptCmd = cpt_cmd
	From	sysadm.produit
	Where	id_prod	 = @dcIdProd
	
	Return 1

GO


--------------------------------------------------------------------
--
-- Procedure            :       PS_S05_COMMANDE
-- Auteur               :       Abdmeziem Catherine
-- Date                 :       14/10/02
-- Libelle              :        
-- Commentaires         :       G‚n‚ration du fichier de commande pour Cegetel
--				r‚cup‚ration d'un nouveau id_lot_ceg
--				s'il est … 999 on le red‚marre … 1
--
-- Arguments            :       @sRefCpt        VarChar ( 10 )
--				@dcIdLotCmd	Decimal ( 7,0 ) OUTPUT
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S05_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.PS_S05_COMMANDE
GO

CREATE procedure sysadm.PS_S05_COMMANDE
        @sRefCpt        VarChar ( 10 ),
        @dcIdLotCeg	Decimal ( 7,0 ) OUTPUT
AS
	Select @dcIdLotCeg = cpt_val
	From sysadm.parametre
	Where ref_cpt = @sRefCpt
	
	If @dcIdLotCeg >= 999
		Begin
			Update sysadm.parametre
                           Set sysadm.parametre.cpt_val = 1
			 Where ref_cpt = @sRefCpt

			If @@rowcount = 0	Return -1
			
			Select @dcIdLotCeg = cpt_val
			  From sysadm.parametre
			 Where ref_cpt = @sRefCpt
			 
			 Return 1

		End
	Else 		EXEC sysadm.PS_X_INCREMENTER @sRefCpt, @dcIdLotCeg OUTPUT
GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_S06_COMMANDE
-- Auteur               :       FABRY JF
-- Date                 :       10/10/2005
-- Libelle              :       Lecture de la date de création de la commande en base
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @iIdSeq         Integer                 (Val)
--				@dtCreeLe	DateTime		OUTPUT
--				@dtCmdGenLe	DateTime		OUTPUT
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S06_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.PS_S06_COMMANDE
GO

CREATE procedure sysadm.PS_S06_COMMANDE
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @iIdSeq         Integer,
        @dtCreeLe	DateTime OUTPUT,
        @dtCmdGenLe	DateTime OUTPUT        
AS

Select  @dtCreeLe = c.cree_le,
	@dtCmdGenLe = c.cmd_gen_le

From    sysadm.commande c

Where   c.id_sin = @dcIdSin
And     c.id_seq = @iIdSeq
Go


--------------------------------------------------------------------
--
-- Procedure            :       DW_S08_COMMANDE
-- Auteur               :       Abdmeziem Catherine
-- Date                 :       22/10/02
-- Libelle              :        
-- Commentaires         :       Select sur la table COMMANDE
-- References           :       Pour Rep‚rage des pannes … cl“turer
--
-- Arguments            :       @sIdFour	VarChar ( 3 )		( Val )
--				@dcIdProd	Decimal ( 7, 0 )	( Val )
--				@dtValideMin	DateTime		( Val )
--				@dtValideMax	DateTime		( Val )
--
-- Retourne             :       Rien
-- MAJ			: Le 23/10/2003 JFF la jointure --> And c.cod_etat in ( 'ECL' )
--			  et remplacé par And c.cod_etat in ( 'RPC', 'ANN' )
--			  En effet cette jointure était valable pour CETELEC, mais par pour ARVATO.
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S08_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.DW_S08_COMMANDE
GO

CREATE procedure sysadm.DW_S08_COMMANDE
	@sIdFour	VarChar ( 3 ),
        @dcIdProd	Decimal (  7, 0 ),
        @dtValideMin	DateTime,
        @dtValideMax	DateTime,
	@sAltDteRetPret	VarChar ( 1 )
AS

Select	s.id_prod Code_Produit,
	c.id_sin Ref_Sinistre,
	c.id_seq Sequence_Commande,
	c.id_gti Garantie,
	c.id_detail Detail_de_garantie,
	c.id_four Fournisseur_FR,
	c.id_typ_art Type_Article_AR,
	c.id_marq_art Marque_Article,
	c.id_modl_art Modele_Article,
	c.mt_ttc_cmde Montant_TTC_Commande,
	c.adr_cod_civ	Civilite,
	c.adr_nom Nom_Interlocuteur,
	c.adr_prenom Prenom_Interlocuteur,
	c.adr_livr1 Adresse_Livraison_1,
	c.adr_livr2 Adresse_Livraison_2,
	c.adr_livr_cpl Adresse_Livr_Compl,
	c.adr_cp Code_Postal,
	c.adr_ville Ville,
	c.adr_tel1 Telephone_1,
	c.adr_tel2 Telephone_2,
	c.adr_tel3 Telephone_3,
	c.adr_mail Mail,
	CONVERT(char(11), c.dte_rdv_cli, 103) + CONVERT(char(8), c.dte_rdv_cli, 108) Date_Rdv_Avec_Client,
	c.hrdv_cli_min Heure_Min_Rdv_Avec_Client,
	c.hrdv_cli_max Heure_Max_Rdv_Avec_Client,
	c.id_serie_anc Ancien_Num_IMEI,
	c.probleme Description_Probleme,
	c.id_cmd_frn Num_Commande_Fournisseur,
	c.id_serie_nouv Nouveau_Num_IMEI,
	c.id_bon_transp Num_Bon_Transporteur,
	CONVERT(char(11), c.dte_rcp_frn, 103) + CONVERT(char(8), c.dte_rcp_frn, 108) Date_Reception_Chez_Fourn,
	CONVERT(char(11), c.dte_env_cli, 103) + CONVERT(char(8), c.dte_env_cli, 108) Date_Envoi_Chez_Client_ou_SPB,
	c.cod_etat Etat_Commande,
	c.comment_frn Commentaire_Fournisseur,
	c.nom_gest Gestionnaire_Ayant_Traite,
	c.id_lot_cmd Num_Lot_Commande,
	CONVERT(char(11), c.cmd_gen_le, 103) + CONVERT(char(8), c.cmd_gen_le, 108) Commande_Generee_Le,
	c.cmd_gen_par Commande_Generee_Par,
	CONVERT(char(11), c.cree_le, 103) + CONVERT(char(8), c.cree_le, 108) Commande_Cree_Le,
	CONVERT(char(11), c.maj_le, 103) + CONVERT(char(8), c.maj_le, 108) Commande_Maj_Le,
	c.maj_par Commande_Maj_Par,
	CONVERT(char(11), c.valide_le, 103) + CONVERT(char(8), c.valide_le, 108) Commande_Valide_Le,
	c.valide_par Commande_Valide_Par,
	c.id_zone Zone,
	CONVERT(char(11), c.dte_ret_pret, 103) + CONVERT(char(8), c.dte_ret_pret, 108) Date_Retour_Kit_Pret,
	c.id_ref_four Ref_fournisseur,
	c.id_orian_marque Orian_marque,
	c.id_orian_modele Orian_modele,
	CONVERT(char(11), c.dte_elv_mobile, 103) + CONVERT(char(8), c.dte_elv_mobile, 108) Enlevement_Mobile,
	c.status_gc Status_Gti_Constructeur,
	CONVERT(char(11), c.dte_emis_devis, 103) + CONVERT(char(8), c.dte_emis_devis, 108) Emission_Devis_Par_Fourn,
	c.mt_devis Mt_Devis_Par_Fourn,
	c.alt_dev_acp Devis_Accepte_Par_Client,
	CONVERT(char(11), c.dte_dev_acp, 103) + CONVERT(char(8), c.dte_dev_acp, 108) Date_Acceptation_Devis_Par_C

  From	sysadm.commande c,
	sysadm.sinistre s
 Where c.id_typ_art = 'PRS'
   And s.cod_etat in ( 100,550 )
   And c.cod_etat in ( 'RPC', 'ANN' )
   And Not Exists ( Select *
		      From sysadm.commande c2
		     Where c2.id_sin = c.id_sin
		       And c2.id_seq <> c.id_seq
		       And c2.cod_etat not in ( 'ANN', 'RSP', 'ECL', 'RPC' )
		  )
   And c.id_bsp = 0
   And ( c.id_four = @sIdFour Or @sIdFour = '*' )
   And c.valide_le between @dtValideMin And @dtValideMax
   And c.id_sin = s.id_sin
   And ( s.id_prod = @dcIdProd Or @dcIdProd = 0 )
   And Not Exists ( Select *
   		    From   sysadm.gar_sin g
   		    where  g.id_sin = s.id_sin
   		      And  g.id_gti <> 18 )
   And ( ( c.dte_ret_pret is not null And @sAltDteRetPret = 'R' ) Or
   	 ( c.dte_ret_pret is null And @sAltDteRetPret = 'N' ) Or
	 ( @sAltDteRetPret = 'S' ) )

GO


--------------------------------------------------------------------
--
-- Procedure            :       DW_S09_COMMANDE
-- Auteur               :       Abdmeziem Catherine
-- Date                 :       22/10/02
-- Libelle              :        
-- Commentaires         :       Select sur la table COMMANDE
-- References           :       Pour Rep‚rage des bris sur panne
--
-- Arguments            :       @sIdFour	VarChar ( 3 )		( Val )
--				@dcIdBsp	Decimal ( 1, 0 )	( Val )
--				@dcIdProd	Decimal ( 7, 0 )	( Val )
--				@dtValideMin	DateTime		( Val )
--				@dtValideMax	DateTime		( Val )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S09_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.DW_S09_COMMANDE
GO

CREATE procedure sysadm.DW_S09_COMMANDE
	@sIdFour	VarChar ( 3 ),
        @dcIdBsp	Decimal (  1, 0 ),
        @dcIdProd	Decimal (  7, 0 ),
        @dtValideMin	DateTime,
        @dtValideMax	DateTime,
	@sAltDteRetPret	VarChar ( 1 )
AS

Select	s.id_prod Code_Produit,
	c.id_sin Ref_Sinistre,
	c.id_seq Sequence_Commande,
	c.id_gti Garantie,
	c.id_detail Detail_de_garantie,
	c.id_four Fournisseur_FR,
	c.id_typ_art Type_Article_AR,
	c.id_marq_art Marque_Article,
	c.id_modl_art Modele_Article,
	c.mt_ttc_cmde Montant_TTC_Commande,
	c.adr_cod_civ	Civilite,
	c.adr_nom Nom_Interlocuteur,
	c.adr_prenom Prenom_Interlocuteur,
	c.adr_livr1 Adresse_Livraison_1,
	c.adr_livr2 Adresse_Livraison_2,
	c.adr_livr_cpl Adresse_Livr_Compl,
	c.adr_cp Code_Postal,
	c.adr_ville Ville,
	c.adr_tel1 Telephone_1,
	c.adr_tel2 Telephone_2,
	c.adr_tel3 Telephone_3,
	c.adr_mail Mail,
	CONVERT(char(11), c.dte_rdv_cli, 103) + CONVERT(char(8), c.dte_rdv_cli, 108) Date_Rdv_Avec_Client,
	c.hrdv_cli_min Heure_Min_Rdv_Avec_Client,
	c.hrdv_cli_max Heure_Max_Rdv_Avec_Client,
	c.id_serie_anc Ancien_Num_IMEI,
	c.probleme Description_Probleme,
	c.id_cmd_frn Num_Commande_Fournisseur,
	c.id_serie_nouv Nouveau_Num_IMEI,
	c.id_bon_transp Num_Bon_Transporteur,
	CONVERT(char(11), c.dte_rcp_frn, 103) + CONVERT(char(8), c.dte_rcp_frn, 108) Date_Reception_Chez_Fourn,
	CONVERT(char(11), c.dte_env_cli, 103) + CONVERT(char(8), c.dte_env_cli, 108) Date_Envoi_Chez_Client_ou_SPB,
	c.cod_etat Etat_Commande,
	c.comment_frn Commentaire_Fournisseur,
	c.nom_gest Gestionnaire_Ayant_Traite,
	c.id_lot_cmd Num_Lot_Commande,
	CONVERT(char(11), c.cmd_gen_le, 103) + CONVERT(char(8), c.cmd_gen_le, 108) Commande_Generee_Le,
	c.cmd_gen_par Commande_Generee_Par,
	CONVERT(char(11), c.cree_le, 103) + CONVERT(char(8), c.cree_le, 108) Commande_Cree_Le,
	CONVERT(char(11), c.maj_le, 103) + CONVERT(char(8), c.maj_le, 108) Commande_Maj_Le,
	c.maj_par Commande_Maj_Par,
	CONVERT(char(11), c.valide_le, 103) + CONVERT(char(8), c.valide_le, 108) Commande_Valide_Le,
	c.valide_par Commande_Valide_Par,
	cd.lib_code,
	c.id_zone Zone,
	CONVERT(char(11), c.dte_ret_pret, 103) + CONVERT(char(8), c.dte_ret_pret, 108) Date_Retour_Kit_Pret,
	c.id_ref_four Ref_fournisseur,
	c.id_orian_marque Orian_marque,
	c.id_orian_modele Orian_modele,
	CONVERT(char(11), c.dte_elv_mobile, 103) + CONVERT(char(8), c.dte_elv_mobile, 108) Enlevement_Mobile,
	c.status_gc Status_Gti_Constructeur,
	CONVERT(char(11), c.dte_emis_devis, 103) + CONVERT(char(8), c.dte_emis_devis, 108) Emission_Devis_Par_Fourn,
	c.mt_devis Mt_Devis_Par_Fourn,
	c.alt_dev_acp Devis_Accepte_Par_Client,
	CONVERT(char(11), c.dte_dev_acp, 103) + CONVERT(char(8), c.dte_dev_acp, 108) Date_Acceptation_Devis_Par_C
	
  From	sysadm.commande c,
	sysadm.sinistre s,
	sysadm.code cd
 Where c.id_typ_art = 'PRS'
   And c.id_bsp = @dcIdBsp
   And ( c.id_four = @sIdFour Or @sIdFour = '*' )
   And c.valide_le between @dtValideMin And @dtValideMax
   And c.id_sin = s.id_sin
   And ( s.id_prod = @dcIdProd Or @dcIdProd = 0 )
   And Not Exists ( Select *
   		    From   sysadm.gar_sin g
   		    where  g.id_sin = s.id_sin
   		    and g.id_gti = 11 )
   And cd.id_typ_code = '-BR'
   And cd.id_code = c.id_bsp
   And ( ( c.dte_ret_pret is not null And @sAltDteRetPret = 'R' ) Or
   	 ( c.dte_ret_pret is null And @sAltDteRetPret = 'N' ) Or
	 ( @sAltDteRetPret = 'S' ) )
GO




--------------------------------------------------------------------
--
-- Procédure            :       PS_U01_PREP_SOLDAGE_TELEPHONIE
-- Auteur               :       Erick John Stark
-- Date                 :       17/05/2003 11:27:57
-- Libellé              :
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @alIdSin                Decimal(7,0)            (Val)
--                      :       @asCodOper              Varchar (    4)         (Val)
--                      :       @adtValideLe            DateTime                (Val)
--                      :       @asNoBoite              VarChar ( 10  )         (Val)
--                      :       @asRetour               Varchar (  254)         (Réf)
--
-- Le 09/09/2003   DGA  : Ajout du paramètre @sNoBoite pour la gestion des boites archives.
--
-- Le 22/10/2003   DGA  : Modification suite demande JFFabry.
--                        Les zones ID_NATSIN, ID_TERRIT, ID_DETSIN ne doivent plus être controlées.
--                        Si l'une de ces zones est non renseignée, on positionne les valeurs suivantes
--                        ID_NATSIN = 28 -> Panne
--                        ID_TERRIT =  5 -> Monde Entier
--                        ID_DETSIN = 30 -> Autres
--
--
-- Retourne             :        1 -> Tout est OK, la valeur de retour est armée avec 'OK'
--                              -1 -> Il y a un problème, la valeur de retour est armée avec l'erreur
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_PREP_SOLDAGE_TELEPHONIE' AND type = 'P' )
        DROP procedure sysadm.PS_U01_PREP_SOLDAGE_TELEPHONIE
GO


CREATE procedure sysadm.PS_U01_PREP_SOLDAGE_TELEPHONIE
        @alIdSin                Decimal (  10,0 ), -- [PI062]
        @asCodOper              VarChar (   4  ),
        @adtValideLe            DateTime        ,
        @asNoBoite              VarChar ( 10  ) ,
        @asRetour               VarChar ( 254  ) OUTPUT
AS

Declare @iRet           Integer
Declare @iTotTravail    Integer
Declare @iTotSin        Integer
Declare @iTotGti        Integer
Declare @iTotDetail     Integer
Declare @sAltQueue      VarChar(1)

Declare @lIdI           Integer
Declare @dtDteLivr      DateTime

Declare @iIdNatsin      Integer,
        @iIdTerrit      Integer,
        @iIdDetsin      Integer

SET NOCOUNT ON
/*------------------------------------------------------------------*/
/* Initialisation des variables                                     */
/*------------------------------------------------------------------*/
SELECT @iRet            = 1
SELECT @sAltQueue       = ''
SELECT @asRetour        = 'OK'

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un travail pour le SINISTRE et si un      */
/* gestionnaire travaille actuellement sur le dossier.              */
/*------------------------------------------------------------------*/
SELECT  @iTotTravail = COUNT(*)
FROM    sysadm.w_queue
WHERE   sysadm.w_queue.id_sin   = CONVERT ( varchar(10), @alIdSin ) -- [PI062]

IF      @iTotTravail > 0
        BEGIN
                SELECT @iRet = -1
                SELECT @asRetour = 'Il existe un travail en cours pour ce dossier.'
        END

IF      @iRet = 1
        BEGIN
/*------------------------------------------------------------------*/
/* On récupére les valeurs pour les zones id_natsin, id_territ,     */
/* id_detsin.                                                       */
/*------------------------------------------------------------------*/
/* Modif du 22/10/2003.*/
/*---------------------*/
                SELECT  @iIdNatsin    = sysadm.sinistre.id_natsin,
                        @iIdTerrit    = sysadm.sinistre.id_territ,
                        @iIdDetsin    = sysadm.sinistre.id_detsin
                FROM    sysadm.sinistre
                WHERE   sysadm.sinistre.id_sin          = @alIdSin
        END

IF      @iRet = 1
        BEGIN
/*------------------------------------------------------------------*/
/* Sur la table SINISTRE le code état du sinistre doit être 'en     */
/* d'instruction'.(100)                                             */
/*------------------------------------------------------------------*/
                SELECT  @iTotSin = COUNT(*)
                FROM    sysadm.sinistre
                WHERE   sysadm.sinistre.id_sin          = @alIdSin              AND
                        sysadm.sinistre.cod_etat        = 100

                IF      @iTotSin = 0
                        BEGIN
                                SELECT @iRet = -1
                                SELECT @asRetour = 'Le code état du sinistre doit être ''en cours d''instruction''.'
                        END
        END

IF      @iRet = 1
        BEGIN
/*------------------------------------------------------------------*/
/* Il doit y avoir une seule garantie en cours pour le dossier.     */
/*------------------------------------------------------------------*/
                SELECT  @iTotGti = COUNT(*)
                FROM    sysadm.gar_sin
                WHERE   sysadm.gar_sin.id_sin   = @alIdSin
                
                IF      @iTotGti <> 1
                        BEGIN
                                SELECT @iRet = -1
                                SELECT @asRetour = 'Il ne doit y avoir qu''une seule garantie en cours pour le dossier. Actuellement, il y en a ' + CONVERT ( CHAR(2), @iTotGti ) + '.'
                        END
        END

IF      @iRet = 1
        BEGIN
/*------------------------------------------------------------------*/
/* Le code état de la seule garantie doit être 'en cours            */
/* d'instruction'.(100)                                             */
/*------------------------------------------------------------------*/
                SELECT  @iTotGti = COUNT(*)
                FROM    sysadm.gar_sin
                WHERE   sysadm.gar_sin.id_sin   = @alIdSin      AND
                        sysadm.gar_sin.cod_etat = 100 
                
                IF      @iTotGti = 0
                        BEGIN
                                SELECT @iRet = -1
                                SELECT @asRetour = 'Le code état de la garantie doit être ''en cours d''instruction''.'
                        END
        END

IF      @iRet = 1
        BEGIN
/*------------------------------------------------------------------*/
/* Il doit y avoir un seul détail en cours pour le dossier.         */
/*------------------------------------------------------------------*/
                SELECT  @iTotDetail = COUNT(*)
                FROM    sysadm.detail
                WHERE   sysadm.detail.id_sin  = @alIdSin
                
                IF      @iTotDetail <> 1
                        BEGIN
                                SELECT @iRet = -1
                                SELECT @asRetour = 'Il ne doit y avoir qu''un seul détail en cours pour le dossier. Actuellement, il y en a ' + CONVERT ( CHAR(2), @iTotDetail ) + '.'
                        END
        END

IF      @iRet = 1
        BEGIN
/*------------------------------------------------------------------*/
/* Le code état du seul détail doit être 'en cours d'instruction'.  */
/* COD_ETAT = 100.                                                  */
/*------------------------------------------------------------------*/
                SELECT  @iTotDetail = COUNT(*)
                FROM    sysadm.detail
                WHERE   sysadm.detail.id_sin    = @alIdSin      AND
                        sysadm.detail.cod_etat  = 100 
                
                IF      @iTotDetail = 0
                        BEGIN
                                SELECT @iRet = -1
                                SELECT @asRetour = 'Le code état du détail doit être ''en cours d''instruction''.'
                        END
        END

/*------------------------------------------------------------------*/
/* Les contrôles nécessaires ont été effectué. On va lancer les     */
/* UPDATES sur les différentes tables.                              */
/*------------------------------------------------------------------*/
/* Table SINISTRE.                                                  */
/*------------------------------------------------------------------*/
IF      @iRet = 1 And @iIdNatsin = 0
        BEGIN
/*---------------------*/
/* Modif du 22/10/2003.*/
/*------------------------------------------------------------------*/
/* On positionne la zone ID_NATSIN si besoin.                       */
/*------------------------------------------------------------------*/
                UPDATE  sysadm.sinistre
                SET     sysadm.sinistre.id_natsin       = 28
                WHERE   sysadm.sinistre.id_sin          = @alIdSin      AND
                        sysadm.sinistre.id_natsin       = 0

                IF      @@RowCount <> 1
                        BEGIN
                                SELECT @iRet = -1
                                SELECT @asRetour = 'La mise à jour de la table SINISTRE vient d''échouer.(Colonne ID_NATSIN)'
                        END
        END
        
/*------------------------------------------------------------------*/
/* Table SINISTRE.                                                  */
/*------------------------------------------------------------------*/
IF      @iRet = 1 And @iIdTerrit = 0
        BEGIN
/*---------------------*/
/* Modif du 22/10/2003.*/
/*------------------------------------------------------------------*/
/* On positionne la zone ID_TERRIT si besoin.                       */
/*------------------------------------------------------------------*/
                UPDATE  sysadm.sinistre
                SET     sysadm.sinistre.id_territ       = 5
                WHERE   sysadm.sinistre.id_sin          = @alIdSin      AND
                        sysadm.sinistre.id_territ       = 0

                IF      @@RowCount <> 1
                        BEGIN
                                SELECT @iRet = -1
                                SELECT @asRetour = 'La mise à jour de la table SINISTRE vient d''échouer.(Colonne ID_TERRIT)'
                        END
        END

/*------------------------------------------------------------------*/
/* Table SINISTRE.                                                  */
/*------------------------------------------------------------------*/
IF      @iRet = 1 And @iIdDetsin = 0
        BEGIN
/*---------------------*/
/* Modif du 22/10/2003.*/
/*------------------------------------------------------------------*/
/* On positionne la zone ID_DETSIN si besoin.                       */
/*------------------------------------------------------------------*/
                UPDATE  sysadm.sinistre
                SET     sysadm.sinistre.id_detsin       = 30
                WHERE   sysadm.sinistre.id_sin          = @alIdSin      AND
                        sysadm.sinistre.id_detsin       = 0

                IF      @@RowCount <> 1
                        BEGIN
                                SELECT @iRet = -1
                                SELECT @asRetour = 'La mise à jour de la table SINISTRE vient d''échouer.(Colonne ID_DETSIN)'
                        END
        END

/*------------------------------------------------------------------*/
/* Table SINISTRE.                                                  */
/*------------------------------------------------------------------*/
IF      @iRet = 1
        BEGIN
/*------------------------------------------------------------------*/
/* On positionne les 3 COD_ETAT à  550.            		    */
/* (En cours de réglement)                                          */
/*------------------------------------------------------------------*/
                UPDATE  sysadm.sinistre
                SET     sysadm.sinistre.cod_etat         = 550,
                        sysadm.sinistre.cod_dec_mac      = 550,
                        sysadm.sinistre.cod_dec_ope      = 550
                WHERE   sysadm.sinistre.id_sin           = @alIdSin
                
                IF      @@RowCount <> 1
                        BEGIN
                                SELECT @iRet = -1
                                SELECT @asRetour = 'La mise à jour de la table SINISTRE vient d''échouer.'
                        END
        END


/*------------------------------------------------------------------*/
/* Table GAR_SIN.                                                   */
/*------------------------------------------------------------------*/
IF      @iRet = 1
        BEGIN
/*------------------------------------------------------------------*/
/* On positionne ALT_ATT = 'N' et les 3 COD_ETAT à  550.            */
/* (En cours de réglement)                                          */
/*------------------------------------------------------------------*/
                UPDATE  sysadm.gar_sin
                SET     sysadm.gar_sin.cod_etat         = 550,
                        sysadm.gar_sin.cod_dec_mac      = 550,
                        sysadm.gar_sin.cod_dec_ope      = 550
                WHERE   sysadm.gar_sin.id_sin           = @alIdSin
                
                IF      @@RowCount <> 1
                        BEGIN
                                SELECT @iRet = -1
                                SELECT @asRetour = 'La mise à jour de la table GAR_SIN vient d''échouer.'
                        END
        END

/*------------------------------------------------------------------*/
/* On récupére d'abord la bonne valeur valeur pour ID_INTER_REG.    */
/* On récupére la plus grande de dates de DTE_ENV_CLI quelque soit  */
/* le COD_ETAT de la commande.                                      */
/*------------------------------------------------------------------*/
IF      @iRet = 1
        BEGIN
                SELECT  @lIdI   = sysadm.inter.id_i
                FROM    sysadm.inter
                WHERE   sysadm.inter.id_sin     = @alIdSin      AND
                        sysadm.inter.cod_inter  = 'A'
                        
                IF      @@RowCount = 0 Or @lIdI IS NULL
                        BEGIN
                                SELECT @iRet = -1
                                SELECT @asRetour = 'La récupération de l''interlocuteur assuré vient d''échouer.'
                        END
                        
                IF      @iRet = 1
                        BEGIN
                                SELECT  @dtDteLivr      = MAX ( sysadm.commande.dte_env_cli )
                                FROM    sysadm.commande
                                WHERE   sysadm.commande.id_sin  = @alIdSin      AND
                                        sysadm.commande.dte_env_cli IS NOT NULL

                                IF      @@RowCount = 0 Or @dtDteLivr IS NULL
                                        BEGIN
/*------------------------------------------------------------------*/
/* Le 27/05/2003. Vu avec Jean-François.                            */
/* Dans le cas, on la récupération d'une date valide DTE_ENV_CLI    */
/* est impossible, on positionne la date du jour.                   */
/*------------------------------------------------------------------*/
                                                SELECT @dtDteLivr = CONVERT ( DATETIME, CONVERT ( VARCHAR(12), GetDate () ) )
                                        END
                        END
        END
/*------------------------------------------------------------------*/
/* Table DETAIL.                                                    */
/*------------------------------------------------------------------*/
IF      @iRet = 1
        BEGIN
/*------------------------------------------------------------------*/
/* On positionne ALT_ATT = 'N' et les 3 COD_ETAT à 550.             */
/* (En cours de réglement). Il faut forcer MT_PREJ et MT_PLAF       */
/* à 0. On met ALT_REG = 'N'. On positionne la bonne valeur pour    */
/* ID_INTER_REG (Code de l'assuré). Dans la zone DTE_LIVR, on       */
/* positionne la plus grande des dates de DTE_ENV_CLI quelque soit  */
/* le COD_ETAT de la commande.                                      */
/*------------------------------------------------------------------*/
                UPDATE  sysadm.detail
                SET     sysadm.detail.alt_att           = 'N',
                        sysadm.detail.cod_etat          = 550,
                        sysadm.detail.cod_dec_mac       = 550,
                        sysadm.detail.cod_dec_ope       = 550,
                        sysadm.detail.mt_prej           = 0,
                        sysadm.detail.mt_plaf           = 0,
                        sysadm.detail.alt_reg           = 'N',
                        sysadm.detail.id_i_reg          = @lIdI,
                        sysadm.detail.dte_livr          = @dtDteLivr
                WHERE   sysadm.detail.id_sin            = @alIdSin

                IF      @@RowCount <> 1
                        BEGIN
                                SELECT @iRet = -1
                                SELECT @asRetour = 'La mise à jour de la table DETAIL vient d''échouer.'
                        END
        END
/*------------------------------------------------------------------*/
/* Table INTER.                  */
/*------------------------------------------------------------------*/
IF      @iRet = 1
        BEGIN
/*------------------------------------------------------------------*/
/* Il faut positionner le mode de règlement de l'assuré avec la     */
/* valeur FM.                                                       */
/*------------------------------------------------------------------*/
                UPDATE  sysadm.inter
                SET     sysadm.inter.cod_mode_reg       = 'FM'
                WHERE   sysadm.inter.id_sin             = @alIdSin              AND
                        sysadm.inter.id_i               = @lIdI

                IF      @@RowCount <> 1
                        BEGIN
                                SELECT @iRet = -1
                                SELECT @asRetour = 'La mise à jour de la table INTER vient d''échouer.'
                        END
        END
        
/*------------------------------------------------------------------*/
/* On effectue maintenant le soldage automatique du dossier. La     */
/* prodédure PS_D01_ARCHIVE_SOLDAGE ne renvoie aucun paramètre. Elle*/
/* renvoie uniquement 'O' dans la variable @sAltQueue s'il y a un   */
/* problème.                                                        */
/*------------------------------------------------------------------*/
IF      @iRet = 1
        BEGIN
                EXEC sysadm.PS_D01_ARCHIVE_SOLDAGE @alIdSin, @asCodOper, @adtValideLe, @sAltQueue OUTPUT, @asNoBoite
                IF      @sAltQueue      = 'O'
                        BEGIN
                                SELECT @iRet = -1
                                SELECT @asRetour = 'Erreur dans la procédure PS_D01_ARCHIVE_SOLDAGE.'
                        END
        END


Return ( @iRet )

GO

--------------------------------------------------------------------
--
-- Procédure            :       TR_U01_COMMANDE
-- Auteur               :       Fabry JF
-- Date                 :       06/11/2003 11:27:57
-- Libellé              :
-- Commentaires         :       On met à jour le n° de commande CEGETEL
--				sur w_commande au moment de l'update sur commande
-- Références           :
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'TR_U01_COMMANDE' AND type = 'TR')
   DROP TRIGGER sysadm.TR_U01_COMMANDE
GO
CREATE TRIGGER TR_U01_COMMANDE 
ON sysadm.commande
FOR UPDATE
AS 
   Update sysadm.w_commande
   set   sysadm.w_commande.id_cmd_frn = i.id_cmd_frn 
   From  inserted i
   where i.id_four = 'CEG'
   and   sysadm.w_commande.id_sin = i.id_sin
   and   sysadm.w_commande.id_seq = i.id_seq	
GO


--------------------------------------------------------------------
--
-- Procedure            :       PS_U03_COMMANDE_VAL
-- Auteur               :       FABRY JF
-- Date                 :       13/11/2001
-- Libelle              :       Mise à jour spéciale pour DARTY 
-- Commentaires         :       On bascule pendant la validation les états de commande TEL en RPC
-- References           :       uf_Gestion_DARTY dans u_gs_sp_sinistre
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U03_COMMANDE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U03_COMMANDE_VAL
GO

CREATE procedure sysadm.PS_U03_COMMANDE_VAL
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

UPDATE sysadm.commande
 SET    
	cod_etat	= 'RPC',
	id_lot_cmd	= 999995,
	cmd_gen_le	= s.valide_le,
	cmd_gen_par	= s.valide_par

 FROM   sysadm.sinistre s
 	
 WHERE  s.id_sin = commande.id_sin
 AND	commande.id_sin = @dcIdSin
 AND     commande.cod_etat <> 'ANN'     
 AND	commande.id_four = 'DTY'

UPDATE sysadm.w_commande
 SET    
	cod_etat	= 'RPC'

 WHERE  w_commande.id_sin = @dcIdSin
 AND	w_commande.cod_etat <> 'ANN'	 
 AND	w_commande.id_four = 'DTY'

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_U04_COMMANDE_VAL
-- Auteur               :       FABRY JF
-- Date                 :       24/01/2005
-- Libelle              :       Mise à jour spéciale pour DARTY 
-- Commentaires         :       On bascule pendant la validation les états de commande en ECT
-- References           :       uf_Gestion_DARTY dans u_gs_sp_sinistre
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-- #1  JFF   01/10/2007   Je scinde le trt DST du DTY.
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U04_COMMANDE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U04_COMMANDE_VAL
GO

CREATE procedure sysadm.PS_U04_COMMANDE_VAL
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

UPDATE sysadm.commande
 SET
        cod_etat        = 'ECT',
        id_lot_cmd      = 999990,
        cmd_gen_le      = s.valide_le,
        cmd_gen_par     = s.valide_par

 FROM   sysadm.sinistre s

 WHERE  s.id_sin = commande.id_sin
 AND    commande.id_sin = @dcIdSin
 AND    commande.cod_etat in ( 'CNV', 'ECT' )
 AND    commande.id_four in ( 'DST' )

UPDATE sysadm.commande
 SET
        cod_etat        = 'RPC',
        id_lot_cmd      = 999990,
        cmd_gen_le      = s.valide_le,
        cmd_gen_par     = s.valide_par

 FROM   sysadm.sinistre s

 WHERE  s.id_sin = commande.id_sin
 AND    commande.id_sin = @dcIdSin
 AND    commande.cod_etat in ( 'CNV', 'ECT' )
 AND    commande.id_four in ( 'DTY' )


UPDATE sysadm.w_commande
 SET
        cod_etat        = 'ECT'

 WHERE  w_commande.id_sin = @dcIdSin
 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
 AND    w_commande.id_four in ( 'DST' )

UPDATE sysadm.w_commande
 SET
        cod_etat        = 'RPC'

 WHERE  w_commande.id_sin = @dcIdSin
 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
 AND    w_commande.id_four in ( 'DTY' )

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_U05_COMMANDE_VAL
-- Auteur               :       FABRY JF
-- Date                 :       27/07/2005
-- Libelle              :       Mise à jour spéciale pour CDISCOUNT
-- Commentaires         :       On bascule pendant la validation les états de commande en DEF
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U05_COMMANDE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U05_COMMANDE_VAL
GO

CREATE procedure sysadm.PS_U05_COMMANDE_VAL
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

UPDATE sysadm.commande
 SET
        cod_etat        = 'DEF'

 FROM   sysadm.sinistre s

 WHERE  s.id_sin = commande.id_sin
 AND    commande.id_sin = @dcIdSin
 AND    commande.cod_etat = 'ECT'
 AND    commande.id_four in ( 'CDS' )

UPDATE sysadm.w_commande
 SET
        cod_etat        = 'DEF'

 WHERE  w_commande.id_sin = @dcIdSin
 AND    w_commande.cod_etat = 'ECT'
 AND    w_commande.id_four in ( 'CDS' )

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_U06_COMMANDE_VAL
-- Auteur               :       FABRY JF
-- Date                 :       09/11/2005
-- Libelle              :       Mise à jour spéciale pour MOBISTORE
-- Commentaires         :       On bascule pendant la validation les états de commande TEL en RPC
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--      JFF   01/09/2011  [PC10][DIAG_NOMADE] (AEF)
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U06_COMMANDE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U06_COMMANDE_VAL
GO

CREATE procedure sysadm.PS_U06_COMMANDE_VAL
        @dcIdSin        Decimal (  10,0 )
AS

UPDATE sysadm.commande
 SET    
	cod_etat	= 'RPC',
	id_lot_cmd	= 999985,
	cmd_gen_le	= s.valide_le,
	cmd_gen_par	= s.valide_par

 FROM   sysadm.sinistre s
 	
 WHERE  s.id_sin = commande.id_sin
 AND	commande.id_sin = @dcIdSin
 AND    commande.cod_etat <> 'ANN'     
 AND	commande.id_four in ( 'MBS', 'BST' )
 AND	commande.id_typ_art <> 'AEF' 

UPDATE sysadm.w_commande
 SET    
	cod_etat	= 'RPC'

 WHERE  w_commande.id_sin = @dcIdSin
 AND	w_commande.cod_etat <> 'ANN'	 
 AND	w_commande.id_four in ( 'MBS', 'BST' )
 AND	w_commande.id_typ_art <> 'AEF'

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_U07_COMMANDE_VAL
-- Auteur               :       FABRY JF
-- Date                 :       09/10/2006
-- Libelle              :       Mise à jour spéciale pour MEDIA SATURN NOMADE
-- Commentaires         :       On bascule pendant la validation les états de commande.
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--				@sCas		VarChar ( 30 )          (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U07_COMMANDE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U07_COMMANDE_VAL
GO


CREATE procedure sysadm.PS_U07_COMMANDE_VAL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCas		VarChar (30)
AS

If Upper ( @sCas ) = '11/EXPERT_MDS'
  Begin
	UPDATE sysadm.commande
	 SET
		cod_etat        = 'ECT',
		id_lot_cmd      = 999980,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par

	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    commande.id_four in ( 'MDS' )

	UPDATE sysadm.w_commande
	 SET
		cod_etat        = 'ECT'

	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_four in ( 'MDS' )
  End
 
If Upper ( @sCas ) = '10/CMDE_MDS'
  Begin
	UPDATE sysadm.commande
	 SET
		cod_etat        = 'RPC',
		id_lot_cmd      = 999975,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par

	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    commande.id_four in ( 'MDS' )

	UPDATE sysadm.w_commande
	 SET
		cod_etat        = 'RPC'

	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_four in ( 'MDS' )
  End
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U07_COMMANDE_VAL_V01
-- Auteur               :       FPI
-- Date                 :       20/09/2012
-- Libelle              :       Mise à jour spéciale pour MEDIA SATURN NOMADE
-- Commentaires         :       On bascule pendant la validation les états de commande.
-- References           :       [CORR_MDS] - on ne tient plus compte du cas de gestion
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U07_COMMANDE_VAL_V01' AND type = 'P' )
        DROP procedure sysadm.PS_U07_COMMANDE_VAL_V01
GO


CREATE procedure sysadm.PS_U07_COMMANDE_VAL_V01
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

  UPDATE sysadm.commande
	SET
	  cod_etat        = 'ECT',
	  id_lot_cmd      = 999980,
	  cmd_gen_le      = s.valide_le,
	  cmd_gen_par     = s.valide_par
  FROM   sysadm.sinistre s
  WHERE  s.id_sin = commande.id_sin
	  AND    commande.id_sin = @dcIdSin
	  AND    commande.cod_etat in ( 'CNV', 'ECT' )
	  AND    commande.id_four in ( 'MDS' )
	  AND    commande.id_typ_art in ( 'AEF')

  UPDATE sysadm.commande
  SET
	  cod_etat        = 'RPC',
	  id_lot_cmd      = 999975,
	  cmd_gen_le      = s.valide_le,
	  cmd_gen_par     = s.valide_par
  FROM   sysadm.sinistre s
  WHERE  s.id_sin = commande.id_sin
	  AND    commande.id_sin = @dcIdSin
	  AND    commande.cod_etat in ( 'CNV', 'ECT' )
	  AND    commande.id_four in ( 'MDS' )
	  AND    commande.id_typ_art in ( 'CAF')

  UPDATE sysadm.w_commande
  SET
	  cod_etat        = 'ECT'
  WHERE  w_commande.id_sin = @dcIdSin
	  AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	   AND    w_commande.id_four in ( 'MDS' )
	  AND    w_commande.id_typ_art in ( 'AEF')

  UPDATE sysadm.w_commande
  SET
	  cod_etat        = 'RPC'
  WHERE  w_commande.id_sin = @dcIdSin
	  AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	   AND    w_commande.id_four in ( 'MDS' )
	  AND    w_commande.id_typ_art in ( 'CAF')
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U08_COMMANDE_VAL
-- Auteur               :       FABRY JF
-- Date                 :       03/11/2006
-- Libelle              :       Mise à jour spéciale pour MONDOVELO
-- Commentaires         :       On bascule pendant la validation les états de commande.
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U08_COMMANDE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U08_COMMANDE_VAL
GO

CREATE procedure sysadm.PS_U08_COMMANDE_VAL
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

UPDATE sysadm.commande
 SET
	cod_etat        = 'RPC',
	id_lot_cmd      = 999970,
	cmd_gen_le      = s.valide_le,
	cmd_gen_par     = s.valide_par

 FROM   sysadm.sinistre s

 WHERE  s.id_sin = commande.id_sin
 AND    commande.id_sin = @dcIdSin
 AND    commande.cod_etat in ( 'CNV', 'ECT' )
 AND    commande.id_four in ( 'MVL' )

UPDATE sysadm.w_commande
 SET
	cod_etat        = 'RPC'

 WHERE  w_commande.id_sin = @dcIdSin
 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
 AND    w_commande.id_four in ( 'MVL' )

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U09_COMMANDE_VAL
-- Auteur               :       FABRY JF
-- Date                 :       29/01/2007
-- Libelle              :       Mise à jour spéciale pour MEDIA SATURN TELEPHONIE
-- Commentaires         :       On bascule pendant la validation les états de commande.
-- References           :       Media Saturn Téléphonie [DCMP060794]
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U09_COMMANDE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U09_COMMANDE_VAL
GO

CREATE procedure sysadm.PS_U09_COMMANDE_VAL
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

UPDATE sysadm.commande
 SET
	cod_etat        = 'RPC',
	id_lot_cmd      = 999965,
	cmd_gen_le      = s.valide_le,
	cmd_gen_par     = s.valide_par

 FROM   sysadm.sinistre s

 WHERE  s.id_sin = commande.id_sin
 AND    commande.id_sin = @dcIdSin
 AND    commande.cod_etat in ( 'CNV', 'ECT' )
 AND    commande.id_four in ( 'MDS' )

UPDATE sysadm.w_commande
 SET
	cod_etat        = 'RPC'

 WHERE  w_commande.id_sin = @dcIdSin
 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
 AND    w_commande.id_four in ( 'MDS' )

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U10_COMMANDE_VAL_SCF_ECH_EXPRESS
-- Auteur               :       FABRY JF
-- Date                 :       09/10/2006
-- Libelle              :       Mise à jour spéciale pour Surcouf Echange Express
-- Commentaires         :       On bascule pendant la validation les états de commande.
-- References           :       [DCMP080287].FAX_MAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U10_COMMANDE_VAL_SCF_ECH_EXPRESS' AND type = 'P' )
        DROP procedure sysadm.PS_U10_COMMANDE_VAL_SCF_ECH_EXPRESS
GO

CREATE procedure sysadm.PS_U10_COMMANDE_VAL_SCF_ECH_EXPRESS
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS


	UPDATE sysadm.commande
	 SET
		cod_etat        = 'ECT',
		id_lot_cmd      = 999960,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par

	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    commande.id_four in ( 'SCF' )

	UPDATE sysadm.w_commande
	 SET
		cod_etat        = 'ECT'

	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_four in ( 'SCF' )

 Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U11_COMMANDE_VAL_FNAC_EPT_V01
-- Auteur               :       FABRY JF
-- Date                 :       09/10/2006
-- Libelle              :       Mise à jour spéciale pour Fnac EPT
-- Commentaires         :       On bascule pendant la validation les états de commande.  
-- References           :       [FNAC_PROD_ECH_TECH]
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-- #1   JFF  27/10/2009  [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U11_COMMANDE_VAL_FNAC_EPT_V01' AND type = 'P' )
        DROP procedure sysadm.PS_U11_COMMANDE_VAL_FNAC_EPT_V01
GO

CREATE procedure sysadm.PS_U11_COMMANDE_VAL_FNAC_EPT_V01
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @iCas		Integer
AS

If @iCas = 1 -- TOUT
  Begin
	UPDATE sysadm.commande
	 SET
		cod_etat        = 'RPC',
		id_lot_cmd      = 999955,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par

	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    commande.id_four in ( 'FNC' )

	UPDATE sysadm.w_commande
	 SET
		cod_etat        = 'RPC'

	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_four in ( 'FNC' )
  End

If @iCas = 2 -- TOUT Sauf CAF
  Begin
	UPDATE sysadm.commande
	 SET
		cod_etat        = 'RPC',
		id_lot_cmd      = 999955,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par

	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    commande.id_four in ( 'FNC' )
	 AND	commande.id_typ_art Not in ( 'CAF' )

	UPDATE sysadm.w_commande
	 SET
		cod_etat        = 'RPC'

	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_four in ( 'FNC' )
	 AND	w_commande.id_typ_art Not in ( 'CAF' )	 
  End

 Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U12_COMMANDE_VAL_RUEDUCOMMERCE
-- Auteur               :       FABRY JF
-- Date                 :       10/06/2009
-- Libelle              :       Mise à jour spéciale pour RDC
-- Commentaires         :       On bascule pendant la validation les états de commande.  
-- References           :       [RUEDUCOMMERCE]
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U12_COMMANDE_VAL_RUEDUCOMMERCE' AND type = 'P' )
        DROP procedure sysadm.PS_U12_COMMANDE_VAL_RUEDUCOMMERCE
GO

CREATE procedure sysadm.PS_U12_COMMANDE_VAL_RUEDUCOMMERCE
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

	UPDATE sysadm.commande
	 SET
		cod_etat        = 'RPC'

	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    commande.id_four in ( 'RDC' )

	UPDATE sysadm.w_commande
	 SET
		cod_etat        = 'RPC'

	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_four in ( 'RDC' )
 Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U13_COMMANDE_VAL_MOBISQUARE
-- Auteur               :       FABRY JF
-- Date                 :       10/06/2009
-- Libelle              :       Mise à jour spéciale pour MCY
-- Commentaires         :       On bascule pendant la validation les états de commande.  
-- References           :       [MOBISQUARE]
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
---- [PC514] Ajout de ACUBE -- [PC853]
--   JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U13_COMMANDE_VAL_MOBISQUARE' AND type = 'P' )
        DROP procedure sysadm.PS_U13_COMMANDE_VAL_MOBISQUARE
GO

CREATE procedure sysadm.PS_U13_COMMANDE_VAL_MOBISQUARE
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

	UPDATE sysadm.commande
	 SET
		cod_etat        = 'RPC',
		id_lot_cmd      = 999950,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par


	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    commande.id_four in ( 'MCY','ACU', 'CYT', 'FPC' ) -- [PC514] [PC853]

	UPDATE sysadm.w_commande
	 SET
		cod_etat        = 'RPC'

	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_four in ( 'MCY' ,'ACU', 'CYT', 'FPC' ) -- [PC514] [PC853]
 
 Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U14_COMMANDE_VAL_CAMARA
-- Auteur               :       FABRY JF
-- Date                 :       03/08/2009
-- Libelle              :       Mise à jour tempo pour CAMARA
-- Commentaires         :       On bascule pendant la validation les états de commande.  
-- References           :       [MOBISQUARE]
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-- #7    JFF    03/08/2009  [CAMARA].[PRESTA_WEB_BOUTIQUE]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U14_COMMANDE_VAL_CAMARA' AND type = 'P' )
        DROP procedure sysadm.PS_U14_COMMANDE_VAL_CAMARA
GO

CREATE procedure sysadm.PS_U14_COMMANDE_VAL_CAMARA
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

	UPDATE sysadm.commande
	 SET
		cod_etat        = 'RPC',
		id_lot_cmd      = 999945,
		id_four		= 'CAM',
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par


	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT', 'CWE' )
	 AND    commande.id_four in ( 'WBB' )

	UPDATE sysadm.w_commande
	 SET
		cod_etat        = 'RPC',
		id_four		= 'CAM'		

	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_four in ( 'CNV', 'ECT', 'CWE' )

 Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U15_COMMANDE_VAL_SMS
-- Auteur               :       FABRY JF
-- Date                 :       03/08/2009
-- Libelle              :       Mise à jour pour SMS
-- Commentaires         :       On bascule pendant la validation les états de commande.  
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-- #7    JFF    03/08/2009  [CAMARA].[PRESTA_WEB_BOUTIQUE]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U15_COMMANDE_VAL_SMS' AND type = 'P' )
        DROP procedure sysadm.PS_U15_COMMANDE_VAL_SMS
GO

CREATE procedure sysadm.PS_U15_COMMANDE_VAL_SMS
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

	UPDATE sysadm.commande
	 SET
		cod_etat        = 'RPC',
		id_lot_cmd      = 999940,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par


	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    commande.id_typ_art in ( 'SMS' )

	UPDATE sysadm.w_commande
	 SET
		cod_etat        = 'RPC'

	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_typ_art in ( 'SMS' )

 Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U16_COMMANDE_VAL_SCCCG13
-- Auteur               :       FABRY JF
-- Date                 :       06/10/2009
-- Libelle              :       Mise à jour tempo pour SCCCG13
-- Commentaires         :       On bascule pendant la validation les états de commande.  
-- References           :       [SCCCG13]
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-- #7    JFF    03/08/2009  [CAMARA].[PRESTA_WEB_BOUTIQUE]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U16_COMMANDE_VAL_SCCCG13' AND type = 'P' )
        DROP procedure sysadm.PS_U16_COMMANDE_VAL_SCCCG13
GO

CREATE procedure sysadm.PS_U16_COMMANDE_VAL_SCCCG13
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

	UPDATE sysadm.commande
	 SET
		cod_etat        = 'RPC',
		id_lot_cmd      = 999935,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par


	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    commande.id_four in ( 'SCC' )

	UPDATE sysadm.w_commande
	 SET
		cod_etat        = 'RPC'

	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_four in ( 'SCC' )
 
 Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U18_COMMANDE_MAIL_EXPANSION
-- Auteur               :       FABRY JF
-- Date                 :       09/04/2010
-- Libelle              :       Mise à jour spéciale pour EX5
-- Commentaires         :       On bascule pendant la validation les états de commande.  
-- References           :       [EXP5].[MAIL_BOUTIQUE]
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U18_COMMANDE_MAIL_EXPANSION' AND type = 'P' )
        DROP procedure sysadm.PS_U18_COMMANDE_MAIL_EXPANSION
GO

CREATE procedure sysadm.PS_U18_COMMANDE_MAIL_EXPANSION
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS
	UPDATE sysadm.commande
	 SET
		cod_etat        = 'RPC',
		id_lot_cmd      = 999950,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par


	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    commande.id_four in ( 'EX5' )

	UPDATE sysadm.w_commande
	 SET
		cod_etat        = 'RPC'

	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_four in ( 'EX5' )
 
 Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U19_COMMANDE_VIRTUELLE_STD
-- Auteur               :       FABRY JF
-- Date                 :       15/09/2010
-- Libelle              :       Mise à jour spéciale 
-- Commentaires         :       On bascule pendant la validation les états de commande.  
-- References           :       [PC301].[CARREFOUR]
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--				@sIdFour	VarChar ( 3 )
-- Retourne             :       Rien
--				JFF 22/11/2010 [PC301].[LOT2]
-- 			        JFF 23/05/2012 [PM103][1]
-- JFF      07/05/2013   [PC938_ORANGE_V3]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U19_COMMANDE_VIRTUELLE_STD' AND type = 'P' )
        DROP procedure sysadm.PS_U19_COMMANDE_VIRTUELLE_STD
GO

CREATE procedure sysadm.PS_U19_COMMANDE_VIRTUELLE_STD
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sIdFour	VarChar ( 3 ),
        @iIdLot		integer
AS

	UPDATE sysadm.commande
	 SET
		-- [PM103][1]
		cod_etat        = Case 
					When @sIdFour = 'O2M' And commande.id_typ_art = 'RST' Then 'RPC' -- [PC938_ORANGE_V3]
					When @sIdFour in ( 'CDS', 'MS1', 'O2M', 'SB1', 'SCR', 'TSF' ) Then 'RFO'
					Else 'RPC'
				  End,
		id_lot_cmd      = @iIdLot,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par

	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    commande.id_four = Upper ( rtrim ( @sIdFour ) )

	UPDATE sysadm.w_commande
	 SET
		-- [PM103][1]
		cod_etat        = Case 
					When @sIdFour = 'O2M' And w_commande.id_typ_art = 'RST' Then 'RPC' -- [PC938_ORANGE_V3]
					When @sIdFour in ( 'CDS', 'MS1', 'O2M', 'SB1', 'SCR', 'TSF' ) Then 'RFO'
					Else 'RPC'
				  End

	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_four = Upper ( rtrim ( @sIdFour ) )
 Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U20_COMMANDE_VAL_MAIL
-- Auteur               :       FPI
-- Date                 :       05/04/2011
-- Libelle              :       Mise à jour pour MAI [PC434]
-- Commentaires         :       On bascule pendant la validation les états de commande.  
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U20_COMMANDE_VAL_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_U20_COMMANDE_VAL_MAIL
GO

CREATE procedure sysadm.PS_U20_COMMANDE_VAL_MAIL
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

	UPDATE sysadm.commande
	 SET
		cod_etat        = 'RPC',
		id_lot_cmd      = 999930,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par


	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    commande.id_typ_art in ( 'MAI' )

	UPDATE sysadm.w_commande
	 SET
		cod_etat        = 'RPC'

	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_typ_art in ( 'MAI' )

 Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_S10_COMMANDE_V06
-- Auteur               :       FABRY JF
-- Date                 :       27/01/2005
-- Libelle              :       Mise à jour spéciale pour DARTY 
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @iIdSeq         Integer                 (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- V01 - ajout de la colonne info_spb_frn_cplt
-- V02 - ajout de comment_frn
-- JFF      12/02/2016   [PI062]
-- V03 - ajout de id_serie_nouv [PC171918].1
-- V04 - ajout de Accord pour indemnistation pécunière [DT363]
-- V05
-- V06 - FPI - 19/03/2019 - [DT401] ajout dte_rcp_frn
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S10_COMMANDE_V06' AND type = 'P' )
        DROP procedure sysadm.DW_S10_COMMANDE_V06
GO

CREATE procedure sysadm.DW_S10_COMMANDE_V06
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @iIdSeq         Integer
AS

Select  p.id_prod,
        p.lib_court,
        cFR.lib_code,
        cFR.id_code,
	c.id_gti,
        c.id_cmd_frn,
        c.id_typ_art,
        c.id_bon_transp,
        c.dte_env_cli,
        c.cod_etat,
        IsNull ( c.status_gc, 0 ),
		info_frn_spb_cplt, -- V01
		info_spb_frn_cplt, -- V01
		c.comment_frn, -- V02
		c.id_serie_nouv, -- V03
		isnull(nullif(sysadm.FN_CLE_VAL('APP_SWAP',c.info_frn_spb_cplt,';'),''),'NON') as app_swap,
		Case When id_four='AAS' And c.cod_etat = 'RPC' and c.status_gc=178 Then id_marq_art
			Else sysadm.FN_CLE_VAL('MARQSW',c.info_frn_spb_cplt,';') End as marque_swap,
		Case When id_four='AAS' and id_typ_art <> 'PRS' Then id_modl_art
			Else sysadm.FN_CLE_VAL('MODLSW',c.info_frn_spb_cplt,';') End as modele_swap,
		Case When id_four='AAS' And c.cod_etat = 'RPC' and c.status_gc=178 Then mt_ttc_cmde
			Else nullif(sysadm.FN_CLE_VAL('MTTTCSW',c.info_frn_spb_cplt,';'),'') End as prix_swap,
		sysadm.FN_CLE_VAL('NEUF_REC',c.info_frn_spb_cplt,';') as etat_swap,
		case
			When exists (select 1 
				from sysadm.det_pro d 
				where p.id_prod=d.id_prod 
					and d.id_code_dp=252
					and sysadm.FN_CLE_VAL('VARIANTE', rtrim ( val_car) + rtrim ( val_car2 ),';') ='ADVISE_6'
					and sysadm.FN_CLE_VAL('FAMILLE', rtrim ( val_car) + rtrim ( val_car2 ),';') ='GEM') Then 'ADVISE_6'
			End
			as variante,
		isnull(nullif(sysadm.FN_CLE_VAL('ACCORD_INDEM_PECU',c.info_frn_spb_cplt,';'),''),'NON') as accord_indemn_pecu,
		(select top 1 val_car from sysadm.div_sin d where d.id_sin=s.id_sin and d.nom_zone='type_app') as type_app,
		case When exists (select 1 
			from sysadm.sinistre s 
				inner join sysadm.div_sin d on d.id_sin=s.id_sin
				inner join sysadm.det_pro dp on dp.id_prod=s.id_prod
			where d.id_sin=s.id_sin and d.nom_zone='type_app'
	and dp.id_code_dp=28 and dp.id_code_car='IFR'+rtrim(d.val_car)) Then 'O' Else 'N' End as est_IFR,
	c.dte_rcp_frn
From    sysadm.commande c,
        sysadm.sinistre s,
        sysadm.produit  p,      
        sysadm.code_car cFR

Where   s.id_sin = @dcIdSin
And     p.id_prod = s.id_prod
And     c.id_sin = s.id_sin
And     c.id_seq = @iIdSeq
And     cFR.id_typ_code = '-FR'
And     cFR.id_code = c.id_four

Go
grant execute on sysadm.DW_S10_COMMANDE_V06 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S07_COMMANDE
-- Auteur               :       FABRY JF
-- Date                 :       21/11/2006
-- Libelle              :       Renvoi le fournisseur de la 
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @iIdSeq         Integer                 (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S07_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.PS_S07_COMMANDE
GO

CREATE procedure sysadm.PS_S07_COMMANDE
        @dcIdSin        Decimal (  10,0 ),
        @iIdSeq         Integer,
        @sIdFour 	VarChar ( 3 ) OUTPUT
AS
	
	Select @sIdFour = IsNull ( id_four, '-1' )
	From sysadm.commande 
	where id_sin = @dcIdSin 
	and id_seq = @iIdSeq 
	
Go



--------------------------------------------------------------------
--
-- Procedure            :       PS_U10_COMMANDE_MAJ_WEB
-- Auteur               :       Fabry JF
-- Date                 :       26/03/07
-- Libelle              :       Maj de la commande à partir du site [SITE_CMDE]
-- Commentaires         :       Update la table COMMANDE 
-- References           :       
--
-- 
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      22/01/2018   [VDOC25549]
-- JFF      07/08/2019   [PM462-1] Création V01
-- JFF      07/08/2019   [PM462-1][V3]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U10_COMMANDE_MAJ_WEB_V01' AND type = 'P' )
        DROP procedure sysadm.PS_U10_COMMANDE_MAJ_WEB_V01
GO


CREATE procedure sysadm.PS_U10_COMMANDE_MAJ_WEB_V01
	@adcIdSin       Decimal (  10,0 ), -- [PI062]
	@aiIdSeq	Integer		,
	@asIdRefFour	VarChar (  20  ), 
	@asIdFour	VarChar (   3  ),
	@asIdMarqArtIfr VarChar (  35  ),
	@asIdModlArtIfr VarChar (  35  ),
	@asCodCiv	VarChar (   1  ),
	@asAdrNom	VarChar (  35  ),
	@asAdrPrenom	VarChar (  35  ),
	@asAdrLivr1	VarChar (  35  ),
	@asAdrLivr2	VarChar (  35  ),
	@asAdrLivrCpl	VarChar (  35  ),
	@asAdrCP	VarChar (   5  ),
	@asAdrVille	VarChar (  35  ),
	@asAdrTel1	VarChar (  10  ),
	@asAdrTel2	VarChar (  10  ),
	@asAdrTel3	VarChar (  10  ),
	@asAdrMail	VarChar (  120  ),
	@adcMtPaiementPayBox Decimal ( 11, 2 )  -- [PM462-1]
AS

Declare @sNeufRec VarChar ( 50 )
Declare @iCptReg Decimal ( 2 )
Declare @dcIdGti Decimal ( 7 )


Select @sNeufRec = a.observ_frn
From sysadm.article a
Where a.id_four = @asIdFour
And   a.id_ref_four = @asIdRefFour

If @sNeufRec is null Set @sNeufRec= ''
If CharIndex ( '[#REC#]', @sNeufRec ) > 0 Set @sNeufRec = 'REC' Else Set @sNeufRec = 'NEU'
 
 
-- [PM462-1][V3]
/*
If sysadm.FN_CLE_NUMERIQUE ( 'PM462-1') >= 0 
 Begin
	If @adcMtPaiementPayBox > 0 
	  Begin
		Update sysadm.sinistre Set cpt_reg = cpt_reg + 1 where id_sin = @adcIdSin
		Select @iCptReg  = cpt_reg From sysadm.sinistre s where id_sin = @adcIdSin
		Select @dcIdGti = id_gti from sysadm.commande where id_sin = @adcIdSin and id_seq = @aiIdSeq

		Insert into sysadm.reglement values ( @adcIdSin, @iCptReg, @adcMtPaiementPayBox, 'PAIEMT FRANCH. PAR ASSURE>SPB (CB)', Convert ( varchar, Getdate(), 103), null,null,null,null, 'A', 'CB', 'PF', 0, null, Getdate(), 'AUTO',Getdate(), Getdate(), 'JFF', null )
		Insert into sysadm.reg_gti   values ( @adcIdSin, @iCptReg, @dcIdGti, @dcIdGti, 0, @adcMtPaiementPayBox, @adcMtPaiementPayBox, Getdate(), Getdate(), 'JFF' )

	  End 
 End 
*/

Update 	sysadm.commande
Set
	id_lot_cmd	= 0,
	id_ref_four	= @asIdRefFour,
	id_four		= @asIdFour,
	id_typ_art	= a.id_typ_art,
	id_marq_art_ifr = @asIdMarqArtIfr,
	id_modl_art_ifr = @asIdModlArtIfr,
	adr_cod_civ     = @asCodCiv,
	adr_nom         = @asAdrNom,
	adr_prenom      = @asAdrPrenom,
	adr_livr1       = @asAdrLivr1,
	adr_livr2       = @asAdrLivr2,
	adr_livr_cpl    = @asAdrLivrCpl,
	adr_cp          = @asAdrCP,
	adr_ville       = @asAdrVille,              
	adr_tel1        = @asAdrTel1,
	adr_tel2        = @asAdrTel2,
	adr_tel3        = @asAdrTel3,
	cod_etat	= 'ECT',
	id_marq_art	= a.id_marq_art,
	id_modl_art	= a.id_modl_art,
	mt_ttc_cmde	= Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ),
	id_orian_marque = 1,  -- Repère cmde Web
	info_spb_frn_cplt = 
	sysadm.FN_CLE_VAL_E ( 'MT_CPLT_PAYBOX_SCM', Convert ( varchar, @adcMtPaiementPayBox), -- [PM462-1][SCM=Site Choix Mobile]
	sysadm.FN_CLE_VAL_E ( 'ID_REG_FRANCHISE', Convert ( varchar, @iCptReg), -- [PM462-1][V3]
	sysadm.FN_CLE_VAL_E ( 'NEUF_REC', @sNeufRec, rtrim ( info_spb_frn_cplt ), ';') -- [VDOC25549]
	, ';')
	, ';')

From 	sysadm.commande c,
	sysadm.article  a

Where  	c.id_sin = @adcIdSin
And	c.id_seq = @aiIdSeq
And	c.id_four = 'WBA'
And     c.cod_etat = 'CWE'
And	a.id_four = @asIdFour
And	a.id_ref_four = @asIdRefFour
And     a.id_marq_art_ifr = @asIdMarqArtIfr
And 	a.id_modl_art_ifr = @asIdModlArtIfr

If	@@RowCount <> 1
	Begin
		Return -1
	End 

If 	Exists ( 	Select 	*
	    		From 	sysadm.w_commande
	    		Where	id_sin = @adcIdSin
	    		And 	id_seq = @aiIdSeq )
	Begin    		
		Update 	sysadm.w_commande
		Set
			id_ref_four	= @asIdRefFour,
			id_four		= @asIdFour,
			id_typ_art	= a.id_typ_art,
			id_marq_art_ifr = @asIdMarqArtIfr,
			id_modl_art_ifr = @asIdModlArtIfr,
			adr_cod_civ     = @asCodCiv,
			adr_nom         = @asAdrNom,
			adr_prenom      = @asAdrPrenom,
			adr_livr1       = @asAdrLivr1,
			adr_livr2       = @asAdrLivr2,
			adr_livr_cpl    = @asAdrLivrCpl,
			adr_cp          = @asAdrCP,
			adr_ville       = @asAdrVille,            
			adr_tel1        = @asAdrTel1,
			adr_tel2        = @asAdrTel2,
			adr_tel3        = @asAdrTel3,
			cod_etat	= 'ECT',
			id_marq_art	= a.id_marq_art,
			id_modl_art	= a.id_modl_art,
			mt_ttc_cmde	= Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ),
			id_orian_marque = 1,  -- Repère cmde Web
			info_spb_frn_cplt = 
			sysadm.FN_CLE_VAL_E ( 'MT_CPLT_PAYBOX_SCM', Convert ( varchar, @adcMtPaiementPayBox), -- [PM462-1][SCM=Site Choix Mobile]
			sysadm.FN_CLE_VAL_E ( 'ID_REG_FRANCHISE', Convert ( varchar, @iCptReg), -- [PM462-1][V3]
			sysadm.FN_CLE_VAL_E ( 'NEUF_REC', @sNeufRec, rtrim ( info_spb_frn_cplt ), ';') -- [VDOC25549]
			, ';')
			, ';')

		From 	sysadm.w_commande c,
				sysadm.article  a

		Where  	c.id_sin = @adcIdSin
		And	c.id_seq = @aiIdSeq
		And	c.id_four = 'WBA'
		And     c.cod_etat = 'CWE'
		And	a.id_four = @asIdFour
		And	a.id_ref_four = @asIdRefFour
		And     a.id_marq_art_ifr = @asIdMarqArtIfr
		And 	a.id_modl_art_ifr = @asIdModlArtIfr

		If	@@RowCount <> 1
			Begin
				Return -1
			End 
	End

Update	sysadm.inter 
Set adr_mail = sysadm.FN_TRIM ( Lower ( @asAdrMail ) )
Where id_sin = @adcIdSin
And cod_inter = 'A'

If	@@RowCount <> 1
	Begin
		Return -1
	End 


If 	Exists ( 	Select 	*
	    		From 	sysadm.w_inter
	    		Where	id_sin = @adcIdSin
	    		And 	cod_inter = 'A' )
	Begin    		

		Update	sysadm.w_inter 
		Set adr_mail = sysadm.FN_TRIM ( Lower ( @asAdrMail ) )
		Where id_sin = @adcIdSin
		And cod_inter = 'A'

		If	@@RowCount <> 1
			Begin
				Return -1
			End 
	End 

Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U11_COMMANDE_TEST_PI
-- Auteur               :       Fabry JF
-- Date                 :       17/04/2007
-- Libelle              :       Forçage pour Test PI [SITE_CMDE]
-- Commentaires         :       
-- References           :       
--
-- 
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U11_COMMANDE_TEST_PI' AND type = 'P' )
        DROP procedure sysadm.PS_U11_COMMANDE_TEST_PI
GO


CREATE procedure sysadm.PS_U11_COMMANDE_TEST_PI
AS

Declare @dcIdSin       Decimal (  10,0 ) -- [PI062]
Declare @dcIdProd      Decimal (  7,0 )
Declare @iIdSeq	       Integer	       

-- [SIN]
Set @dcIdSin = 1330951
Set @dcIdProd = 10902 
Set @iIdSeq = 1

Update 	sysadm.sinistre
Set	num_port = '0600000005', cod_etat = 100, id_rev = -1, id_prod = @dcIdProd
Where  	id_sin = @dcIdSin

Update 	sysadm.w_sin
Set	num_port = '0600000005', cod_etat = 100, id_rev = -1, id_prod = @dcIdProd
Where  	id_sin = @dcIdSin

Update 	sysadm.div_sin
Set	val_car = 'ZE4T6Y'
Where  	id_sin = @dcIdSin
And	nom_zone = 'mdp_net'

Update 	sysadm.w_div_sin
Set	val_car = 'ZE4T6Y'
Where  	id_sin = @dcIdSin
And	nom_zone = 'mdp_net'

Update 	sysadm.commande
Set
	id_lot_cmd	= -1,
	id_ref_four	= 'TEL_VIRTUEL_SPB_WEB',
	id_four		= 'WBA',
	id_typ_art	= 'TEL',
	id_marq_art_ifr = 'CHOIX PAR l''ASSURE (WEB)',
	id_modl_art_ifr = '',
	adr_cod_civ     = '5',
	adr_nom         = 'SPB',
	adr_prenom      = 'DEPT DEI/ES',
	adr_livr1       = '71 QUAI COLBERT',
	adr_livr2       = '',
	adr_livr_cpl    = '',
	adr_cp          = '76600',
	adr_ville       = 'LE HAVRE',              
	adr_tel1        = '0232740000',
	adr_tel2        = '',
	adr_tel3        = '',
	cod_etat	= 'CWE',
	id_marq_art	= 'CHOIX PAR l''ASSURE (WEB)',
	id_modl_art	= 'CHOIX PAR l''ASSURE (WEB)',
	mt_ttc_cmde	= 2000,
	id_orian_marque = 1  -- Repère cmde Web

From 	sysadm.commande c

Where  	c.id_sin = @dcIdSin
And	c.id_seq = @iIdSeq

If	@@RowCount <> 1
	Begin
		Return -1
	End 

If 	Exists ( 	Select 	*
	    		From 	sysadm.w_commande
	    		Where	id_sin = @dcIdSin
	    		And 	id_seq = @iIdSeq )
	Begin    		
		Update 	sysadm.w_commande
		Set
			id_ref_four	= 'TEL_VIRTUEL_SPB_WEB',
			id_four		= 'WBA',
			id_typ_art	= 'TEL',
			id_marq_art_ifr = 'CHOIX PAR l''ASSURE (WEB)',
			id_modl_art_ifr = '',
			adr_cod_civ     = '5',
			adr_nom         = 'SPB',
			adr_prenom      = 'DEPT DEI/ES',
			adr_livr1       = '71 QUAI COLBERT',
			adr_livr2       = '',
			adr_livr_cpl    = '',
			adr_cp          = '76600',
			adr_ville       = 'LE HAVRE',              
			adr_tel1        = '0232740000',
			adr_tel2        = '',
			adr_tel3        = '',
			cod_etat	= 'CWE',
			id_marq_art	= 'CHOIX PAR l''ASSURE (WEB)',
			id_modl_art	= 'CHOIX PAR l''ASSURE (WEB)',
			mt_ttc_cmde	= 2000,
			id_orian_marque = 1  -- Repère cmde Web



		From 	sysadm.w_commande c

		Where  	c.id_sin = @dcIdSin
		And	c.id_seq = @iIdSeq

		If	@@RowCount <> 1
			Begin
				Return -1
			End 
	End

Update	sysadm.inter 
Set adr_mail = ''
Where id_sin = @dcIdSin
And cod_inter = 'A'

If	@@RowCount <> 1
	Begin
		Return -1
	End 


If 	Exists ( 	Select 	*
	    		From 	sysadm.w_inter
	    		Where	id_sin = @dcIdSin
	    		And 	cod_inter = 'A' )
	Begin    		

		Update	sysadm.w_inter 
		Set adr_mail = ''
		Where id_sin = @dcIdSin
		And cod_inter = 'A'

		If	@@RowCount <> 1
			Begin
				Return -1
			End 
	End 

Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U12_COMMANDE_O2M
-- Auteur               :       PHG
-- Date                 :       13/12/2007
-- Libelle              :       Mise à jour spéciale pour O2M
-- Commentaires         :       On bascule pendant la validation les états de commande en RFO
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-- #11   JFF  28/12/2009  [20091228155332733] ajout SBE TV
-- #12   JFF  30/12/2009  [MSS_DIAG]
-- #13   JFF  25/02/2010  [20100225095612467]
--	 FPI  19/08/2011  [VDoc4752] Les commandes DESISION_SPB avec process 970 - Ok pour cmde mat proposés restent ouvertes
--       JFF  12/12/2011  [VDOC4970] Fermeture auto PAS DE COMMANDE
--       JFF  05/01/2012  [RECUP_DONNEE_O2M]
--       JFF  06/08/2012  [BLCODE]
--       JFF  17/08/2012  [RECUPDONN_MANTIS4326]
--       JFF  06/08/2012  [BLCODE]
--       JFF  30/12/2013  [PC13348&13408]
--       JFF  09/04/2015  [DT141]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U12_COMMANDE_O2M' AND type = 'P' )
        DROP procedure sysadm.PS_U12_COMMANDE_O2M
GO


CREATE procedure sysadm.PS_U12_COMMANDE_O2M
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

Declare @RecupDonnee VarChar ( 1 )
Declare @sMethodeRecupDonnee VarChar ( 5 )

-- [RECUP_DONNEE_O2M]
Select @RecupDonnee = rTrim ( val_car )
From   sysadm.div_sin dv
Where  dv.id_sin = @dcIdSin
And    nom_zone = 'recup_donnees'

If @RecupDonnee = '' Set @RecupDonnee = 'N'
If @RecupDonnee is null Set @RecupDonnee = 'N'

Select @RecupDonnee 

-- [RECUPDONN_MANTIS4326]
Select 	Top 1 @sMethodeRecupDonnee = rTrim ( sysadm.FN_CLE_VAL ( 'METHODE', rtrim ( val_car ), ';'))
From  	sysadm.det_pro d,
	sysadm.produit p,
	sysadm.sinistre s
Where   d.id_prod = p.id_prod
And     d.id_code_dp = 205
And     d.id_prod = s.id_prod
And     s.id_sin = @dcIdSin
If @sMethodeRecupDonnee is null Set @sMethodeRecupDonnee = ''

UPDATE sysadm.commande
 SET
	cod_etat        = 'RFO'

 FROM   sysadm.sinistre s

 WHERE  s.id_sin = commande.id_sin
 AND    commande.id_sin = @dcIdSin
 -- #13   JFF  25/02/2010  [20100225095612467]
 -- AND    commande.cod_etat = 'ECT'
 AND    commande.cod_etat in ( 'ECT', 'CNV' )
 AND    commande.id_four in ( 'O2M', 'SB1', 'MS1', 'BLC', 'MTT', 'SBE' )  -- [BLCODE] -- [PC13348&13408]-- [DT141]
 AND  ( commande.id_ref_four in ( 'GOM_A_RECYCLER', 'DECISION_SPB' )
		  Or 
		  ( commande.id_ref_four in ('PEC_A_RECYCLER' )
			And
			( @sMethodeRecupDonnee <> '1' or @RecupDonnee = 'N' )
		  )
		  Or 
		  ( commande.id_ref_four in ('PAS_DE_COMMANDE')
			And 
			@RecupDonnee = 'N'
		  )		  
		  Or -- [PC13348&13408]
		  ( commande.id_ref_four in ('REFUSE_A_REEXP' )
		    And 
		    commande.id_four = 'MTT'
		  )
	)

 AND 	( commande.info_spb_frn <> 970 or commande.info_spb_frn is null ) -- [VDoc4752]


UPDATE sysadm.w_commande
 SET
	cod_etat        = 'RFO'

 WHERE  w_commande.id_sin = @dcIdSin
 -- #13   JFF  25/02/2010  [20100225095612467]
 -- AND    commande.cod_etat = 'ECT'
 AND    w_commande.cod_etat in ( 'ECT', 'CNV' )
 AND    w_commande.id_four in ( 'O2M', 'SB1', 'MS1', 'BLC', 'MTT', 'SBE' ) -- [BLCODE] -- [PC13348&13408]-- [DT141]
 AND    ( w_commande.id_ref_four in ( 'GOM_A_RECYCLER', 'DECISION_SPB' )
		   Or 
		  ( w_commande.id_ref_four in ('PEC_A_RECYCLER' )
			And
			( @sMethodeRecupDonnee <> '1' or @RecupDonnee = 'N' )
		  )
		  Or 
		  ( w_commande.id_ref_four in ('PAS_DE_COMMANDE')
			And 
			@RecupDonnee = 'N'
		  )		  
		  Or -- [PC13348&13408]
		  ( w_commande.id_ref_four in ('REFUSE_A_REEXP' )
		    And 
		    w_commande.id_four = 'MTT'
		  )		  
	    )
 AND 	( w_commande.info_spb_frn <> 970 or w_commande.info_spb_frn is null ) -- [VDoc4752]

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       TR_U02_COMMANDE_V01
-- Auteur               :       Fabry JF
-- Date                 :       24/04/2007
-- Libelle              :	[SITE_CMDE]
-- Commentaires         :       Trigger pour traiter la trace 19, (SI/Cmde Web annulé par GT)
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_U02_COMMANDE_V01' AND type = 'TR' )
        DROP trigger sysadm.TR_U02_COMMANDE_V01
GO

CREATE TRIGGER sysadm.TR_U02_COMMANDE_V01
            ON sysadm.commande
    FOR UPDATE 
AS 

Declare @dcIdSin Decimal ( 10 ) -- [PI062]
Declare @asValidePar  VarChar (4)

If Update ( cod_etat )
         
   Begin 

	Select 	Top 1
		@dcIdSin = i.id_sin,
		@asValidePar = i.valide_par
	From   inserted i, deleted d
	Where  i.id_sin = d.id_sin
	And    i.id_seq = d.id_seq
	And    i.id_four = d.id_four
	And    d.id_four = 'WBA'
	And    d.cod_etat = 'CWE'
	And    i.cod_etat = 'ANN'

	If @@RowCount = 1 

	  Begin 

		-- [TRACE_19]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			null,		-- @asIdSession     varchar(30),
			null,		-- @asBrowser       varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			null,		-- @asNumTel        varchar(10),
			null,		-- @asMdp           varchar(6),
			19,		-- @adcIdCodeTrc    Decimal(7),
			'TRACE', 	-- @asGravite       varchar(10),
			'SIM8',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			null,		-- @aiIdMess        integer
                        @asValidePar    -- @asMajPar        VarChar (4)

	  End 
   End 
GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       TR_U03_COMMANDE_V01
-- Auteur               :       Fabry JF
-- Date                 :       24/04/2007
-- Libelle              :	[SITE_CMDE]
-- Commentaires         :       Trigger pour traiter la trace 18, (SI/Cmde Web activé par GT)
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_U03_COMMANDE_V01' AND type = 'TR' )
        DROP trigger sysadm.TR_U03_COMMANDE_V01
GO


CREATE TRIGGER sysadm.TR_U03_COMMANDE_V01
            ON sysadm.commande
    FOR INSERT
AS 

Declare @dcIdSin Decimal ( 10 ) -- [PI062]
Declare @asValidePar  VarChar (4)
        
Select 	Top 1
	@dcIdSin = i.id_sin,
	@asValidePar = i.valide_par
From   inserted i
Where  i.id_four = 'WBA'
And    i.cod_etat = 'CNV'

If @@RowCount = 1 

  Begin 

	-- [TRACE_18]
	EXEC sysadm.PS_I01_TRACE_CMDE_V01
		null,		-- @asIdSession     varchar(30),
		null,		-- @asBrowser       varchar(50),
		@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
		null,		-- @asNumTel        varchar(10),
		null,		-- @asMdp           varchar(6),
		18,		-- @adcIdCodeTrc    Decimal(7),
		'TRACE', 	-- @asGravite       varchar(10),
		'SIM8',		-- @asIdAppli       varchar(5),
		'VALIDATION',	-- @asEtape         varchar(20),
		null,		-- @aiIdMess        integer
                @asValidePar    -- @asMajPar        VarChar (4)

  End 

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_S08_COMMANDE  
-- Auteur               :       FABRY JF
-- Date                 :       21/11/2006
-- Libelle              :       Recherche si présence 
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @iIdSeq         Integer                 (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S08_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.PS_S08_COMMANDE
GO

CREATE procedure sysadm.PS_S08_COMMANDE
        @sIdFour 	VarChar ( 3 )
AS
	
	Select *
	From   sysadm.commande
	Where  id_four = @sIdFour
	And    id_lot_cmd = 0
	
	Return @@RowCount
	
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S09_COMMANDE
-- Auteur               :       FABRY JF
-- Date                 :       18/06/2008
-- Libelle              :       Permets d'aiguiller la réparation d'un mobile entre deux fourn selon un pourcentage et une date pivot
-- Commentaires         :       [DCMP080500]  
-- References           :       
-- 
-- Arguments
--	@asFour1 Varchar ( 3 ) Fournisseur 1
--	@asFour2 Varchar ( 3 ) Fournisseur 2
--	@asMarq Varchar ( 35 ) Marque à aiguiller
--	@asModl Varchar ( 35 ) Modèle à aiguiller ( Facultatif si '')
--	@asdcRepartFourn1 varChar ( 5 ), Taux de répartition en pourcentage pour le Fournisseur 1 avec 2 chf ap la Virg. ex : 54.21 (càd 54.21%)
--	@adtDtePivot DateTime, Date pivot pour la répartition
--	@asFourRetenu Varchar ( 3 ) OUTPUT Fournisseur retenu en retour
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S09_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.PS_S09_COMMANDE
GO


CREATE procedure sysadm.PS_S09_COMMANDE
	@dcIdSin Decimal ( 10), -- [PI062]
	@asFour1 Varchar ( 3 ),
	@asFour2 Varchar ( 3 ),
	@asMarq Varchar ( 35 ),
	@asModl Varchar ( 35 ),
	@asdcRepartFourn1 varChar ( 6 ),
	@adtDtePivot DateTime,
	@asFourRetenu Varchar ( 3 ) OUTPUT
AS
	

Declare @dcNbFour1 Decimal ( 11,2 )
Declare @dcNbFour2 Decimal ( 11,2 )
Declare @dcRepartFourn2 Decimal ( 11,2 )
Declare @dcRepartFourn1 Decimal ( 11,2 )
Declare @sFourPresent Varchar ( 3 ) 

Set @sFourPresent = null

Select  Top 1 @sFourPresent = c.id_four
From	sysadm.commande c
Where 	c.id_sin = @dcIdSin
And	c.id_typ_art = 'PRS'
Order by c.id_seq desc

If @sFourPresent is not null  
	Begin
		Set @asFourRetenu = @sFourPresent
	End 

If @sFourPresent is null  
	Begin

		Set @dcRepartFourn1 = Convert ( Decimal ( 11,2 ), @asdcRepartFourn1 )

		Set @dcRepartFourn2 = 100 - @dcRepartFourn1

		select 	@dcNbFour1 = IsNull ( count (*), 0 )
		from 	sysadm.commande c
		where  	c.id_four = @asFour1 
		and 	c.id_typ_art = 'PRS' 
		and 	c.id_marq_art = @asMarq
		and 	( @asModl is null Or c.id_modl_art = @asModl )
		and     c.cree_le >= @adtDtePivot

		select 	@dcNbFour2 = IsNull ( count (*), 0 )
		from 	sysadm.commande c
		where  	c.id_four = @asFour2 
		and 	c.id_typ_art = 'PRS' 
		and 	c.id_marq_art = @asMarq
		and 	( @asModl is null Or c.id_modl_art = @asModl )
		and     c.cree_le >= @adtDtePivot

		If @dcNbFour1 + @dcNbFour2 = 0
			Begin 
				Set @asFourRetenu = @asFour1
			End
		Else 
			Begin
				Select @asFourRetenu = Case 
							When Round ( (@dcNbFour1/(@dcNbFour1 + @dcNbFour2)) * 100 , 2 ) <= @dcRepartFourn1 Then @asFour1
							When Round ( (@dcNbFour2/(@dcNbFour1 + @dcNbFour2)) * 100 , 2 ) < @dcRepartFourn2 Then @asFour2
						       End 
			End
	End
	
-- Test
--Select Round ( (@dcNbFour1/(@dcNbFour1 + @dcNbFour2)) * 100 , 2 ), @asFour1, Round ( (@dcNbFour2/(@dcNbFour1 + @dcNbFour2)) * 100 , 2 ), @asFour2, @asFourRetenu 

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S10_COMMANDE  
-- Auteur               :       FABRY JF
-- Date                 :       08/08/2008
-- Libelle              :       Permet de récupérer l'ID_REF_FOUR et l'ID_TYP_ART de la commande émise.
-- Commentaires         :       [DCMP080615]  
-- References           :       
-- 
-- Arguments
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S10_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.PS_S10_COMMANDE
GO

CREATE procedure sysadm.PS_S10_COMMANDE
	@dcIdSin Decimal ( 10), -- [PI062]
	@iIdSeq Integer,
	@sIdRefFour Varchar ( 20 ) OUTPUT,
	@sIdTypArt Varchar ( 3 ) OUTPUT
	
As

Select  @sIdRefFour = c.id_ref_four,
	@sIdTypArt = c.id_typ_art
From 	sysadm.commande c
Where	c.id_sin = @dcIdSin
And 	c.id_seq = @iIdSeq

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S11_COMMANDE
-- Auteur               :       FABRY JF
-- Date                 :       24/11/2008
-- Libelle              :       
-- Commentaires         :     	[FNAC_PROD_ECH_TECH]  
-- References           :     	[PC301].[LOT2]  
-- 
-- Arguments
--
-- Retourne             :       Rien
-- 		 JFF     03/05/2011 [PM166][O2M]
--               JFF     30/05/2012 [VDOC7926]
--               JFF     29/11/2012 [VDOC9142]
--         JFF      07/05/2013   [PC938_ORANGE_V3]
-- JFF      07/05/2013   [PC929-1]
-- JFF      25/11/2014   [PM251-2]
-- JFF      20/07/2015   [DT150]
-- JFF      28/07/2015   [PM295-1]
-- JFF		31/07/2015   [DT141][DT168]
-- JFF      12/11/2015   [VDOC19112]
-- JFF      31/03/2016   [PM287-3]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S11_COMMANDE_V07' AND type = 'P' )
        DROP procedure sysadm.PS_S11_COMMANDE_V07
GO


CREATE procedure sysadm.PS_S11_COMMANDE_V07
	@dcIdSin Decimal ( 10), -- [PI062]
	@iIdSeq Integer,
	@sIdFour Varchar ( 3 ) OUTPUT,
	@sCodEtat Varchar ( 3 ) OUTPUT,
	@iStatusGc Integer OUTPUT,
	@sIdRefFour Varchar( 20 ) OUTPUT,
	@iInfoSpbFrn Integer OUTPUT,
	@sIdTypArt Varchar(3) OUTPUT,
	@dcIdProd Decimal (7) OUTPUT,
	@sInfoSpbFrnCplt VarChar ( 800 ) OUTPUT,
	@sInfoFrnSpbCplt VarChar ( 800 ) OUTPUT,	
	@sChaineBCV VarChar ( 800 ) OUTPUT
As

Declare @sVal VarChar ( 100 )
Declare @sVal1 VarChar ( 100 )
Declare @sVal2 VarChar ( 100 )
Declare @sVal3 VarChar ( 100 )
Declare @iNbreARepSav Integer 
Declare @iNbreACtlSav Integer 
Declare @iNbreSavActuel Integer 
-- 

If @sChaineBCV is null Set @sChaineBCV = ''

-- [PC938_ORANGE_V3]
If Exists ( Select * 
			from sysadm.det_pro d with (nolock), 
				 sysadm.sinistre s with (nolock)
			where d.id_code_dp = 239 
			And   d.id_prod = s.id_prod
			And   s.id_sin = @dcIdSin
			)
	Begin 
		Select @sChaineBCV = sysadm.FN_CLE_VAL_E ( 'ORANGE_V3', 'OUI', RTRIM ( @sChaineBCV) , ';')
	End 

-- [PC929-1]
If Exists ( Select * 
			from sysadm.det_pro d with (nolock), 
				 sysadm.sinistre s with (nolock)
			where d.id_code_dp = 235 
			And   d.id_prod = s.id_prod
			And   s.id_sin = @dcIdSin
			)
	Begin 
		Select @sChaineBCV = sysadm.FN_CLE_VAL_E ( 'CDISCOUNT_SERENITE', 'OUI', RTRIM ( @sChaineBCV) , ';')
	End 

-- [PC938_ORANGE_V3]

-- [PM251-2]
If (Select sysadm.FN_A_COMMANDER ( @dcIdSin, @iIdSeq, 'P' )) = 'A_COMMANDER'
	Begin 
		Select @sChaineBCV = sysadm.FN_CLE_VAL_E ( 'CMDE_REMPL', 'OUI', RTRIM ( @sChaineBCV) , ';')
	End 

-- [DT150]
If Exists ( Select * 
			from sysadm.det_pro d with (nolock), 
				 sysadm.sinistre s with (nolock)
			where d.id_code_dp = 284 
			And   d.id_prod = s.id_prod
			And   s.id_sin = @dcIdSin
			)
	Begin 
		Select @sChaineBCV = sysadm.FN_CLE_VAL_E ( 'GESTION_GEOLOCALISATION', 'OUI', RTRIM ( @sChaineBCV) , ';')
	End 

-- [PM295-1]
If Exists ( Select * 
			from sysadm.det_pro d with (nolock), 
				 sysadm.sinistre s with (nolock)
			where d.id_code_dp = 285 
			And   d.id_prod = s.id_prod
			And   s.id_sin = @dcIdSin
			)
	Begin 
		Select @sChaineBCV = sysadm.FN_CLE_VAL_E ( 'CHGT_CARTE_MERE', 'OUI', RTRIM ( @sChaineBCV) , ';')
	End 

-- [DT141][DT168]
Select  @sChaineBCV = sysadm.FN_CLE_VAL_E ( 'TYP_APP_DS', UPPER ( IsNull ( ds.val_car, '') ), RTRIM ( @sChaineBCV) , ';') 
From	sysadm.div_sin ds with (nolock)
Where   ds.id_sin = @dcIdSin
And     nom_zone = 'type_app'

--[VDOC19112]

Select @sVal = rtrim ( c.id_bon_transp ),
		@sVal1 = nullif ( convert ( varchar, IsNull ( c.dte_rcp_frn, '' ), 103), '01/01/1900' ),
		@sVal2 = nullif ( convert ( varchar, IsNull ( c.dte_env_cli, '' ), 103), '01/01/1900' ),
		@sVal3 = nullif ( convert ( varchar, IsNull ( s.cree_le, '' ), 103), '01/01/1900' )
From   sysadm.commande c with (nolock),
		sysadm.sinistre s with (nolock)
Where  c.id_sin = @dcIdSin
And    c.id_seq = @iIdSeq
And    s.id_sin = c.id_sin
   
If @sVal is null Set @sVal = ''
Select @sChaineBCV = sysadm.FN_CLE_VAL_E ( 'ID_BON_TRANSP', @sVal, RTRIM ( @sChaineBCV) , ';')

If @sVal1 is null Set @sVal1 = ''
Select @sChaineBCV = sysadm.FN_CLE_VAL_E ( 'DTE_RCP_FRN', @sVal1, RTRIM ( @sChaineBCV) , ';')

If @sVal2 is null Set @sVal2 = ''
Select @sChaineBCV = sysadm.FN_CLE_VAL_E ( 'DTE_ENV_CLI', @sVal2, RTRIM ( @sChaineBCV) , ';')

If @sVal3 is null Set @sVal3 = ''
Select @sChaineBCV = sysadm.FN_CLE_VAL_E ( 'CREE_LE_SIN', @sVal3, RTRIM ( @sChaineBCV) , ';')

 
-- [PM287-3]
Select @sVal = sysadm.FN_CLE_VAL ( 'DNCX_STATUS_GC', rtrim ( val_car ) + rtrim ( val_car2), ';' ) 
From sysadm.det_pro d with (nolock), 
		sysadm.sinistre s with (nolock)
where d.id_code_dp = 296 
And   d.id_prod = s.id_prod
And   s.id_sin = @dcIdSin

If @sVal is null Set @sVal = ''
Select @sChaineBCV = sysadm.FN_CLE_VAL_E ( 'DNCX_STATUS_GC', @sVal, RTRIM ( @sChaineBCV) , ';')

-- [HP252_276_HUB_PRESTA]
If sysadm.FN_CLE_NUMERIQUE ( 'HP252_276_HUB_PRESTA') > 0 
 Begin
	If sysadm.FN_CLE_VAL ( 'DDE_SAV', @sChaineBCV, ';' ) = 'OUI'
		Begin 
			Select	@iNbreARepSav = COUNT(*) 
			From	sysadm.commande c with (nolock)
			Where	c.id_sin = @dcIdSin
--			And 	c.id_seq = @iIdSeq
			And		sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', c.info_spb_frn_cplt, ';' ) = 'OUI'
			And     c.cod_etat <> 'ANN'

			Select	@iNbreACtlSav = COUNT(*) 
			From	sysadm.commande c with (nolock)
			Where	c.id_sin = @dcIdSin
--			And 	c.id_seq = @iIdSeq
			And		sysadm.FN_CLE_VAL ( 'A_CONTROLER_SAV', c.info_spb_frn_cplt, ';' ) = 'OUI'
			And     c.cod_etat <> 'ANN'

			If @iNbreARepSav is null Set @iNbreARepSav = 0 
			If @iNbreACtlSav is null Set @iNbreACtlSav = 0 

			If @iNbreARepSav = @iNbreACtlSav And @iNbreARepSav = 0 And @iNbreACtlSav = 0 Set @iNbreSavActuel = 0
			If @iNbreARepSav = @iNbreACtlSav And @iNbreARepSav > 0 And @iNbreACtlSav > 0 Set @iNbreSavActuel = 2
			If @iNbreARepSav > @iNbreACtlSav And @iNbreARepSav > 0 And @iNbreACtlSav = 0 Set @iNbreSavActuel = 1

			If @iNbreSavActuel is null Set @iNbreSavActuel = 0 

			Set @sChaineBCV = sysadm.FN_CLE_VAL_E ( 'NBRE_SAV_ACTUEL', Convert ( VarChar ( 10 ), @iNbreSavActuel ), rTrim ( @sChaineBCV ), ';' )
		End 

/*			
	Select	@sDernIdRefFour = c.id_ref_four
	From	sysadm.commande c with (nolock)
	Where	c.id_sin = @dcIdSin
	And     c.id_seq = (	Select MAX ( id_seq ) 
							From sysadm.commande c1
							Where c1.id_sin = c.id_sin ) 
	If @sDernIdRefFour is null Set @sDernIdRefFour = ''
	Set @sChaineBCV = sysadm.FN_CLE_VAL_E ( 'DERN_ID_REF_FOUR', @sDernIdRefFour, rTrim ( @sChaineBCV ), ';' )
*/
 End 


Select  @sIdFour = IsNull ( c.id_four , '') ,
	@sCodEtat = IsNull ( c.cod_etat, ''),
	@iStatusGc = c.status_gc,
	@sIdRefFour = IsNull ( c.id_ref_four, ''),
	@iInfoSpbFrn = c.info_spb_frn,
	@sIdTypArt = IsNull ( c.id_typ_art, ''),
	@dcIdProd = s.id_prod,
	@sInfoSpbFrnCplt = IsNull ( c.info_spb_frn_cplt, ''),
	@sInfoFrnSpbCplt = IsNull ( c.info_frn_spb_cplt, ''),	
	@sChaineBCV = IsNull ( @sChaineBCV , '') -- [PC938_ORANGE_V3] (obligé de faire comme ça... la variable égale la variable.
From 	sysadm.commande c with (nolock),
	sysadm.sinistre s with (nolock)
Where	c.id_sin = @dcIdSin
And 	c.id_seq = @iIdSeq
And 	s.id_sin = c.id_sin

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S12_COMMANDE  
-- Auteur               :       FABRY JF
-- Date                 :       24/11/2008
-- Libelle              :       
-- Commentaires         :     	[FNAC_PROD_ECH_TECH]  
-- References           :       
-- 
-- Arguments
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S12_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.PS_S12_COMMANDE
GO

CREATE procedure sysadm.PS_S12_COMMANDE
	@dcIdSin Decimal ( 10), -- [PI062]
	@iIdSeq Integer,
	@sRetour Varchar ( 50 ) OUTPUT,
	@sOk Varchar ( 1 ) OUTPUT -- O ou N
	
As

/*
If @iIdSeq = 9 
	Begin
	    If  ( Select s.cree_le 
	    	from   sinistre s
	    	Where  s.id_sin = @dcIdSin ) > '06/12/2008'
	    	
	    	Begin
			Set @sOk = 'N'
			Set @sRetour = '(tiret 9 au delà du 06/12/2008, cas incohérent)'
			Return
	    	End 
	    	Else
		Begin
			Set @sOk = 'O'
			Set @sRetour = ''
			Return			
		End 

	    	
	End 
*/

If Exists (
	Select  *
	From 	sysadm.commande c
	Where	c.id_sin = @dcIdSin
	And 	c.id_seq = @iIdSeq
	And     c.id_four = 'FNC'
	 )
	 Begin
	 	Set @sOk = 'O'
	 	Set @sRetour = ''
	 End 
Else
	 Begin
		Set @sOk = 'N'
		Set @sRetour = '(inexistant ou non lié au fournisseur FNC)'
	 End 
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S13_COMMANDE
-- Auteur               :       FABRY JF
-- Date                 :       24/11/2008
-- Libelle              :       
-- Commentaires         :     	[DCMP090102][DCMP090140]
-- References           :       Ramène le type art de la commande
-- 
-- Arguments
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S13_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.PS_S13_COMMANDE
GO

CREATE procedure sysadm.PS_S13_COMMANDE
	@dcIdSin Decimal ( 10), -- [PI062]
	@iIdSeq Integer,
	@sRetour Varchar ( 3 ) OUTPUT
As

Set @sRetour = ''

Select @sRetour = IsNull ( c.id_typ_art, '' )
From   sysadm.commande c
Where  c.id_sin = @dcIdSin
And    c.id_seq = @iIdSeq

Go

-- JFF      12/02/2016   [PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U02_COMMANDE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U02_COMMANDE_VAL
GO

CREATE procedure sysadm.PS_U02_COMMANDE_VAL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS


-- Annulation Commande CEGETEL jamais générée
UPDATE sysadm.commande
 SET    
	 sysadm.commande.cod_etat	=	w_commande.cod_etat	,
	 sysadm.commande.id_ann		=	w_commande.id_ann	,
	 sysadm.commande.nom_gest	=	w_commande.nom_gest 	,
	 sysadm.commande.id_lot_cmd	=	999999			,
	 sysadm.commande.cmd_gen_le	=	w_commande.maj_le	,
	 sysadm.commande.cmd_gen_par	=	w_commande.maj_par	,
	 sysadm.commande.maj_le		=	w_commande.maj_le	,
	 sysadm.commande.maj_par	=	w_commande.maj_par	,
	 sysadm.commande.valide_le	=	@dtValideLe     	,
	 sysadm.commande.valide_par	=	@sCodOper       	

 FROM   sysadm.commande,
	sysadm.w_commande
 WHERE  w_commande.id_sin         = @dcIdSin              AND
	commande.id_sin		  = w_commande.id_sin	  AND
	commande.id_seq		  = w_commande.id_seq	  AND
	w_commande.cpt_valide     > 0			  AND
	w_commande.cod_etat 	  = 'ANN'		  AND
	w_commande.id_four	  in ( 'CEG', 'DDF', 'DME', 'ANV', 'FTT', 'SBE', 'MSS', 'ORV', 'CDS', 'MBS', 'COR', 'BTP', 'WBA', 'ALP', 'GOM', 'O2M', 'MCM', 'CDP', 'PAP', 'RDC', 'SB1' )  AND 
	commande.cod_etat 	  <> 'ANN'		  AND
	commande.id_lot_cmd	  in ( 0, -1 ) 
	
-- Annulation Commande ayant été générée
UPDATE sysadm.commande
 SET    
	 sysadm.commande.cod_etat	=	w_commande.cod_etat	,
	 sysadm.commande.id_ann		=	w_commande.id_ann	,
	 sysadm.commande.nom_gest	=	w_commande.nom_gest 	,
	 sysadm.commande.maj_le		=	w_commande.maj_le	,
	 sysadm.commande.maj_par	=	w_commande.maj_par	,
	 sysadm.commande.valide_le	=	@dtValideLe     	,
	 sysadm.commande.valide_par	=	@sCodOper       	

 FROM   sysadm.commande,
	sysadm.w_commande
 WHERE  w_commande.id_sin         = @dcIdSin              AND
	commande.id_sin		  = w_commande.id_sin	  AND
	commande.id_seq		  = w_commande.id_seq	  AND
	w_commande.cpt_valide     > 0			  AND
	w_commande.cod_etat 	  = 'ANN'		  AND
	w_commande.id_four	  in ( 'CEG', 'DDF', 'DME', 'ANV', 'FTT', 'SBE', 'MSS', 'ORV', 'CDS', 'MBS', 'COR', 'BTP', 'ALP', 'GOM', 'O2M', 'MCM', 'CDP', 'PAP', 'RDC' )	  AND 
	commande.cod_etat 	  <> 'ANN'		  AND
	commande.id_lot_cmd	  > 0   -- #1 >o ald <>0

 Return @@Error

GO

-- JFF      12/02/2016   [PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U11_COMMANDE_VAL_FNAC_EPT' AND type = 'P' )
        DROP procedure sysadm.PS_U11_COMMANDE_VAL_FNAC_EPT
GO

CREATE procedure sysadm.PS_U11_COMMANDE_VAL_FNAC_EPT
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS


	UPDATE sysadm.commande
	 SET
		cod_etat        = 'RPC',
		id_lot_cmd      = 999955,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par

	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    commande.id_four in ( 'FNC' )

	UPDATE sysadm.w_commande
	 SET
		cod_etat        = 'RPC'

	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_four in ( 'FNC' )

GO


--------------------------------------------------------------------
--
-- Procedure            :       PS_U17_COMMANDE_VAL_SCCCG
-- Auteur               :       F. Pinon
-- Date                 :       02/04/2010
-- Libelle              :       Mise à jour tempo pour SCCCG
-- Commentaires         :       On bascule pendant la validation les états de commande.  
-- References           :       [PC106] SCC CG13
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--								@sIdFour		Char (3)				(Val)
--
-- Retourne             :       Rien
--	JFF	30/11/2010	[PC106]
--	FPI 14/02/2013	[PC467-2] Ajout de SAM
--  FPI 27/01/2014 [PC988] Ajout de CFI
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U17_COMMANDE_VAL_SCCCG_V01' AND type = 'P' )
        DROP procedure sysadm.PS_U17_COMMANDE_VAL_SCCCG_V01
GO

CREATE procedure sysadm.PS_U17_COMMANDE_VAL_SCCCG_V01
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

Declare @iIdLotCmd	int

	Select @iIdLotCmd= 999935

	UPDATE sysadm.commande
	 SET
		cod_etat        = Case When commande.id_typ_art='EDI' Then 'RFO' Else 'RPC' End,
		id_lot_cmd      = @iIdLotCmd,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par


	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    commande.id_four in ( 'ECO', 'SCC', 'TSF','SAM','CFI' )

	UPDATE sysadm.w_commande
	 SET
		cod_etat        = Case When w_commande.id_typ_art='EDI' Then 'RFO' Else 'RPC' End

	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_four in ( 'ECO', 'SCC', 'TSF','SAM','CFI' )
 
 Go

 grant execute on sysadm.PS_U17_COMMANDE_VAL_SCCCG_V01 to rolebddsinistres
 Go
--------------------------------------------------------------------
--
-- Procedure            :       PS_U18_COMMANDE_VAL_CARREFOUR
-- Auteur               :       JFF
-- Date                 :       29/07/2010
-- Libelle              :       
-- Commentaires         :       On bascule pendant la validation les états de commande.  
-- References           :       [PC321]
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--								@sIdFour		Char (3)				(Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U18_COMMANDE_VAL_CARREFOUR' AND type = 'P' )
        DROP procedure sysadm.PS_U18_COMMANDE_VAL_CARREFOUR
GO


CREATE procedure sysadm.PS_U18_COMMANDE_VAL_CARREFOUR
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

	UPDATE sysadm.commande
	 SET
		cod_etat        = 'RPC',
		id_lot_cmd      = 999999,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par

	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    commande.id_four in ( 'SCR')
	 AND    commande.info_spb_frn in ( 1425,1426 )

	UPDATE sysadm.w_commande
	 SET
		cod_etat        = 'RPC'

	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_four in ( 'SCR')
	 AND    w_commande.info_spb_frn in ( 1425,1426 )
	  
 Go


  --------------------------------------------------------------------
  --
  -- Proc‚dure            :       TR_U04_COMMANDE_V01
  -- Auteur               :       Fabry JF
  -- Date                 :       20/04/2010
  -- Libelle              :	[WEBSIM2].[FRANCE]
  -- Commentaires         :       Trigger pour traiter la trace 19, (SI/Cmde Web annulé par GT)
  --
  -- References           :
  --
  -- Arguments            :       
  -- Retourne             :     
  -------------------------------------------------------------------  
  -- JFF      12/02/2016   [PI062]
  -------------------------------------------------------------------
  IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_U04_COMMANDE_V01' AND type = 'TR' )
          DROP trigger sysadm.TR_U04_COMMANDE_V01
  GO
  

CREATE TRIGGER sysadm.TR_U04_COMMANDE_V01
              ON sysadm.commande
      FOR UPDATE 
  AS 
  
  Declare @dcIdSin Decimal ( 10 ) -- [PI062]
  Declare @asValidePar  VarChar (4)
  
  If Update ( cod_etat )
           
     Begin 
  
  	Select 	Top 1
  		@dcIdSin = i.id_sin,
  		@asValidePar = i.valide_par
  	From   inserted i, deleted d
  	Where  i.id_sin = d.id_sin
  	And    i.id_seq = d.id_seq
  	And    i.id_four = d.id_four
  	And    d.id_four = 'WBB'
  	And    d.cod_etat = 'CWE'
  	And    i.cod_etat = 'ANN'
  
  	If @@RowCount = 1 
  
  	  Begin 
  
  		-- [TRACE_19]
  		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
  			null,		-- @asIdSession     varchar(30),
  			null,		-- @asBrowser       varchar(50),
  			null,  		-- @asCasProduit    varchar(50),			
  			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
  			null,		-- @asNumTel        varchar(10),
  			null,		-- @asMdp           varchar(6),
  			null,		-- @asCodeVendeur   Varchar(50),
  			null,		-- @asCodeMagasin   Varchar(50),
  			19,		-- @adcIdCodeTrc    Decimal(7),
  			'TRACE', 	-- @asGravite       varchar(10),
  			'SIM8',		-- @asIdAppli       varchar(5),
  			'VALIDATION',	-- @asEtape         varchar(20),
  			null,		-- @aiIdMess        integer
  			null,		-- @asValCar	 VarChar(254),
                          @asValidePar    -- @asMajPar        VarChar (4)
  
  	  End 
     End 
  GO
  
  --------------------------------------------------------------------
  --
  -- Proc‚dure            :       TR_U05_COMMANDE_V01
  -- Auteur               :       Fabry JF
  -- Date                 :       20/04/2010
  -- Libelle              :	[WEBSIM2].[FRANCE]
  -- Commentaires         :       Trigger pour traiter la trace 18, (SI/Cmde Web activé par GT)
  --
  -- References           :
  --
  -- Arguments            :       
  -- Retourne             : 
  -------------------------------------------------------------------
  -- JFF      12/02/2016   [PI062]
  -------------------------------------------------------------------
  IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_U05_COMMANDE_V01' AND type = 'TR' )
          DROP trigger sysadm.TR_U05_COMMANDE_V01
  GO
  
  
CREATE TRIGGER sysadm.TR_U05_COMMANDE_V01
              ON sysadm.commande
      FOR INSERT
  AS 
  
  Declare @dcIdSin Decimal ( 10 ) -- JFF      12/02/2016   [PI062]
  Declare @asValidePar  VarChar (4)
          
  Select 	Top 1
  	@dcIdSin = i.id_sin,
  	@asValidePar = i.valide_par
  From   inserted i
  Where  i.id_four = 'WBB'
  And    i.cod_etat = 'CNV'
  
  If @@RowCount = 1 
  
    Begin 
  
  	-- [TRACE_18]
  	EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
  		null,		-- @asIdSession     varchar(30),
  		null,		-- @asBrowser       varchar(50),
  		null,  		-- @asCasProduit    varchar(50),			
  		@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
  		null,		-- @asNumTel        varchar(10),
  		null,		-- @asMdp           varchar(6),
  		null,		-- @asCodeVendeur   Varchar(50),
  		null,		-- @asCodeMagasin   Varchar(50),
  		18,		-- @adcIdCodeTrc    Decimal(7),
  		'TRACE', 	-- @asGravite       varchar(10),
  		'SIM8',		-- @asIdAppli       varchar(5),
  		'VALIDATION',	-- @asEtape         varchar(20),
  		null,		-- @aiIdMess        integer
  		null,		-- @asValCar	 VarChar(254),
                  @asValidePar    -- @asMajPar        VarChar (4)
  
    End 
  GO

--------------------------------------------------------------------
--
-- Procedure            :       DW_S01_COMMANDE_COURRIER_CARMA_V01
-- Auteur               :       Fabry JF
-- Date                 :       23/11/2011
-- Libelle              :       Pour Carrefour
-- Commentaires         :       Select sur la table COMMANDE
-- References           :       
--
-- Arguments            :       @iIdLotCmd       Integer,
--				@sIdFour	 VarChar ( 3 )
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
-- [PC321] - modif nom_contrat repris depuis DP 66 ald 67
-- JFF   24/08/2012  [ITSM127946]
-- FPI - 25/05/2016  [DT176] exclusion de certains produits pour génération via ETL (DP 297)
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_COMMANDE_COURRIER_CARMA_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S01_COMMANDE_COURRIER_CARMA_V01
GO

CREATE procedure sysadm.DW_S01_COMMANDE_COURRIER_CARMA_V01
	@iIdLotCmd       Integer,
	@sIdFour	 VarChar ( 3 )	

As

Select	p.id_prod 'cod_produit',
	( Select ltrim ( rtrim ( dp.val_car)) 
	  From sysadm.det_pro dp
	  Where dp.id_prod = s.id_prod
	  And   dp.id_code_dp = 66 ) 'libelle_produit',
	co.lib_cie 'nom_assureur',
	po.lib_police 'numero_police',
	( Select rtrim ( IsNull ( sysadm.FN_CODE_NUM ( c.adr_cod_civ, '-CI' ), '') ) + ' ' + rtrim ( IsNull ( c.adr_prenom, '') ) + ' ' + rtrim ( IsNull ( c.adr_nom, '') ) ) 'adresse_postale_1',
	c.adr_livr1 'adresse_postale_2',
	c.adr_livr2 'adresse_postale_3',
	c.adr_livr_cpl 'adresse_postale_4',
	rtrim ( IsNull ( c.adr_cp, '' ))  + ' ' + rtrim ( IsNull ( c.adr_ville, '' )) 'adresse_postale_5',
	convert ( Varchar , null ) 'adresse_postale_6',
	c.cmd_gen_le 'edition_date',
	'Le Havre' 'edition_lieu',
	c.id_sin 'commun_id_sin',
	s.id_adh 'num_dossier',
	( Select IsNull ( sysadm.FN_CODE_NUM ( c.adr_cod_civ, '-CL' ), ''))  'civ_longue',
	( Select IsNull ( dd.val_mt, 0 )
	  From sysadm.div_det dd
	  where dd.id_sin = c.id_sin
	  And   dd.id_gti = c.id_gti
	  And   dd.id_detail = c.id_detail 
	  And   dd.nom_zone = 'mt_pec' ) 'mt_indemnisation',
	Case 
		When Exists ( 
			  Select * 
			  From sysadm.det_pro dp
			  Where dp.id_prod = s.id_prod
			  And   dp.id_code_dp = 66 
			  ) Then
				( Select ltrim ( rtrim ( dp.val_car)) 
				  From sysadm.det_pro dp
				  Where dp.id_prod = s.id_prod
				  And   dp.id_code_dp = 66 ) 
		Else ( Select top 1 pr.lib_long 
			   From sysadm.produit pr
			   Where pr.id_prod = s.id_prod )
	End 'nom_contrat', -- [PC321] 66 ald 67 -- [ITSM127946]
	p.num_tel 'rens_telephone',
	p.num_fax 'rens_fax',
	'garantietv@spb.fr' 'mail_exp',
	'christine_chanteur@carrefour.com' 'mail_add_dest',
	'Sabine_Tourville@carrefour.com;suivi_carrefour@spb.eu;mathilde_roux@carrefour.com;marc_barbesange@carrefour.com' 'mail_copie_a_1',
	'' 'mail_copie_a_2',
	'O' 'mail_canal',
	c.nom_gest 'ut_resp_edition',
	c.cmd_gen_le 'generation_doc_tstamp',
	'N' 'annule_et_remplace',
	'BACH' 'acte_gestion_code',
	'ENVOI_BACH' 'maq_code'

From 	sysadm.commande c,
	sysadm.produit p,
	sysadm.sinistre s,
	garantie g,
	police po,
	compagnie co
	
Where   c.id_four = @sIdFour
and 	c.id_lot_cmd = @iIdLotCmd
and     s.id_sin = c.id_sin
and     p.id_prod = s.id_prod
and	g.id_prod = s.id_prod
and     g.id_rev = s.id_rev
and     g.id_gti = c.id_gti
and	po.id_police = g.id_police
and	co.id_cie = po.id_cie
and not exists (select 1 
		from sysadm.det_pro d 
		where d.id_prod=p.id_prod
			and d.id_code_dp=297)
	

Go

grant execute on sysadm.DW_S01_COMMANDE_COURRIER_CARMA_V01 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_S02_COMMANDE_COURRIER_AUCHAN_V01
-- Auteur               :       Fabry JF
-- Date                 :       23/11/2011
-- Libelle              :       Pour Auchan
-- Commentaires         :       Select sur la table COMMANDE
-- References           :       
--
-- Arguments            :       @iIdLotCmd       Integer,
--				@sIdFour	 VarChar ( 3 )
--
-- Retourne             :       Rien
-- 
-- JFF	11/03/2014	[PC387-2/PC412-1/PC696-1]
-- JFF  28/03/2014  [PC387-2/PC412-1/PC696-1][MANTIS10807]
-- JFF  28/05/2014  [PC786-1_AUCHAN_GEM]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_COMMANDE_COURRIER_AUCHAN_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S02_COMMANDE_COURRIER_AUCHAN_V01
GO

CREATE procedure sysadm.DW_S02_COMMANDE_COURRIER_AUCHAN_V01
	@iIdLotCmd       Integer,
	@sIdFour	 VarChar ( 3 )	

As

Select	p.id_prod 'cod_produit',
	( Select Replace (ltrim ( rtrim ( dp.val_car)), '&', 'et' ) 
	  From sysadm.det_pro dp
	  Where dp.id_prod = s.id_prod
	  And   dp.id_code_dp = 66 ) 'libelle_produit',
	co.lib_cie 'nom_assureur',
	po.lib_police 'numero_police',
	( Select rtrim ( IsNull ( sysadm.FN_CODE_NUM ( c.adr_cod_civ, '-CI' ), '') ) + ' ' + rtrim ( IsNull ( c.adr_prenom, '') ) + ' ' + rtrim ( IsNull ( c.adr_nom, '') ) ) 'adresse_postale_1',
	c.adr_livr1 'adresse_postale_2',
	c.adr_livr2 'adresse_postale_3',
	c.adr_livr_cpl 'adresse_postale_4',
	rtrim ( IsNull ( c.adr_cp, '' ))  + ' ' + rtrim ( IsNull ( c.adr_ville, '' )) 'adresse_postale_5',
	convert ( Varchar , null ) 'adresse_postale_6',
	c.cmd_gen_le 'edition_date',
	'Le Havre' 'edition_lieu',
	c.id_sin 'commun_id_sin',
	s.id_adh 'num_dossier',
	( Select IsNull ( sysadm.FN_CODE_NUM ( c.adr_cod_civ, '-CL' ), ''))  'civ_longue',
	( Select IsNull ( dd.val_mt, 0 )
	  From sysadm.div_det dd
	  where dd.id_sin = c.id_sin
	  And   dd.id_gti = c.id_gti
	  And   dd.id_detail = c.id_detail 
	  And   dd.nom_zone = 'mt_pec' ) 'mt_indemnisation',
	( Select ltrim ( rtrim ( dp.val_car)) 
	  From sysadm.det_pro dp
	  Where dp.id_prod = s.id_prod
	  And   dp.id_code_dp = 67 ) 'nom_contrat',
	p.num_tel 'rens_telephone',
	p.num_fax 'rens_fax',
	Case s.id_prod
		When 41100 Then 'microordinateur@spb.eu'
		When 41101 Then 'microordinateur@spb.eu'
		When 41800 Then 'telephonie@spb.eu'
		When 41801 Then 'telephonie@spb.eu'
		When 41802 Then 'telephonie@spb.eu'
		When 41803 Then 'telephonie@spb.eu'
		When 41804 Then 'telephonie@spb.eu'
		When 41805 Then 'telephonie@spb.eu'
		When 39000 Then 'consolesdejeux@spb.eu'
		When 48000 Then 'auchantelephonie@spb.eu'
		When 48001 Then 'auchantelephonie@spb.eu'
		Else 'a_parametrer@spb.eu'	
	End 'mail_exp',
	'nbausier@auchan.fr' 'mail_add_dest',
	'mvenant@auchan.fr;sandrinecoulon@karapass.eu' 'mail_copie_a_1',
	'' 'mail_copie_a_2',
	'O' 'mail_canal',
	c.nom_gest 'ut_resp_edition',
	c.cmd_gen_le 'generation_doc_tstamp',
	'N' 'annule_et_remplace',
	'BACH' 'acte_gestion_code',
	Case 
		-- [PC387-2/PC412-1/PC696-1]
		When Exists ( 
			   Select * 
			   From   sysadm.commande c1
			   Where  c1.id_sin = c.id_sin
			   And    sysadm.FN_CLE_VAL ( 'APP_INCOMPLET', c1.info_frn_spb_cplt, ';') = 'OUI' 
			   And    Exists ( 
						Select * 
						From   sysadm.plafond pl,
							   sysadm.detail dt
						Where  dt.id_sin = c.id_sin
						And    dt.id_gti = c.id_gti
						And    dt.id_detail = c.id_detail
						And    pl.id_prod = s.id_prod
						And	   pl.id_rev = s.id_rev
						And    pl.id_gti = c.id_gti
						And    pl.id_niv_plaf = '+EV'
						And    pl.id_ref_plaf = dt.id_evt
						And	   pl.id_typ_plaf = 721						
					  )
			 ) Then 'oui'
		Else 'non'
	End 'mt_franchise',
	'ENVOI_BKDO' 'maq_code',
	c.id_gti 'num_garantie', -- [PC786-1_AUCHAN_GEM]
	Case When Exists (
				Select 1
				From   sysadm.gar_sin g
				Where  g.id_sin = s.id_sin
				And	   g.id_gti = 52
				And    g.cod_etat not in (200, 900)
			  )
		 Then 'oui'
		 Else 'non'
	End 'gti_52_ouv' -- [PC786-1_AUCHAN_GEM]

From 	sysadm.commande c,
	sysadm.produit p,
	sysadm.sinistre s,
	sysadm.garantie g,
	sysadm.police po,
	sysadm.compagnie co
	
Where   c.id_four = @sIdFour
and 	c.id_lot_cmd = @iIdLotCmd
and     s.id_sin = c.id_sin
and     p.id_prod = s.id_prod
and	g.id_prod = s.id_prod
and     g.id_rev = s.id_rev
and     g.id_gti = c.id_gti
and	po.id_police = g.id_police
and	co.id_cie = po.id_cie


Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_REDRESSEMENT_CMDE_ANNUL
-- Auteur               :       Fabry JF
-- Date                 :       14/09/01
-- Libelle              :        
-- Commentaires         :       [VDOC5021]
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_REDRESSEMENT_CMDE_ANNUL' AND type = 'P' )
        DROP procedure sysadm.PS_U_REDRESSEMENT_CMDE_ANNUL
GO

CREATE procedure sysadm.PS_U_REDRESSEMENT_CMDE_ANNUL
        @dcIdSin        Decimal (  10, 0 ) -- [PI062]
AS

Declare @iIdSeq Integer

Select  Top 1 @iIdSeq = w.id_seq
From 	sysadm.w_commande w,
 	sysadm.commande c
Where w.id_sin = @dcIdSin 
And   c.id_sin = w.id_sin
And   c.id_seq = w.id_seq
And   w.cod_etat = 'ANN'
And   c.cod_etat <> 'ANN'
And   c.id_lot_cmd > 0
And   w.cpt_valide > 0

Update  sysadm.w_commande
Set	cod_etat = c.cod_etat, id_ann = c.id_ann, nom_gest = c.nom_gest, maj_le = c.maj_le, maj_par = c.maj_par
From 	sysadm.commande c
Where 	c.id_sin = @dcIdSin
and	c.id_seq = @iIdSeq
and 	w_commande.id_sin = c.id_sin
and 	w_commande.id_seq = c.id_seq

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_COMMANDE_PM82_LOT1_CLOTURE_PRS
-- Auteur               :       JFF
-- Date                 :       21/09/2011
-- Libelle              :       Cloture d'une presta PRS 153/154 si REFUS_A_REEXP
-- Commentaires         :       [PM82][LOT1]
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      07/03/2024   [HP252_276_HUB_PRESTA]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COMMANDE_PM82_LOT1_CLOTURE_PRS' AND type = 'P' )
        DROP procedure sysadm.PS_U_COMMANDE_PM82_LOT1_CLOTURE_PRS
GO


CREATE procedure sysadm.PS_U_COMMANDE_PM82_LOT1_CLOTURE_PRS
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

UPDATE sysadm.commande
 SET	cod_etat = 
        Case commande.id_four
        	When 'O2M' Then 'RFO'
        	Else 'RPC'
        End 

 FROM   sysadm.sinistre s

 WHERE  s.id_sin = commande.id_sin
 AND    commande.id_sin = @dcIdSin
 AND 	commande.id_typ_art = 'PRS'
 AND    commande.id_ref_four in ( 'A_REPARER' )
 AND 	commande.status_gc in ( 153, 154 ) 
 AND	commande.cod_etat not in ( 'ANN' )
 
UPDATE sysadm.w_commande
 SET
		cod_etat = 
        Case w_commande.id_four
        	When 'O2M' Then 'RFO'
        	Else 'RPC'
        End 

 FROM   sysadm.w_sin s

 WHERE  s.id_sin = w_commande.id_sin
 AND    w_commande.id_sin = @dcIdSin
 AND 	w_commande.id_typ_art = 'PRS'
 AND    w_commande.id_ref_four in ( 'A_REPARER' )
 AND 	w_commande.status_gc in ( 153, 154 ) 
 AND	w_commande.cod_etat not in ( 'ANN' )


 -- [HP252_276_HUB_PRESTA]
If sysadm.FN_CLE_NUMERIQUE ( 'HP252_276_HUB_PRESTA') > 0 
 Begin

	 UPDATE sysadm.commande
	 SET	cod_etat = 
			Case commande.id_four
        		When 'O2M' Then 'RFO'
        		Else 'RPC'
			End 

	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.id_ref_four in ( 'A_DIAGNOSTIQUER' )
	 AND 	commande.status_gc in ( 153, 154 ) 
	 AND	commande.cod_etat not in ( 'ANN' )
 
	UPDATE sysadm.w_commande
	 SET
			cod_etat = 
			Case w_commande.id_four
        		When 'O2M' Then 'RFO'
        		Else 'RPC'
			End 

	 FROM   sysadm.w_sin s

	 WHERE  s.id_sin = w_commande.id_sin
	 AND    w_commande.id_sin = @dcIdSin
	 AND    w_commande.id_ref_four in ( 'A_DIAGNOSTIQUER' )
	 AND 	w_commande.status_gc in ( 153, 154 ) 
	 AND	w_commande.cod_etat not in ( 'ANN' )

 End
GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_COMMANDE_VDOC9304_CLOTURE_DIAG
-- Auteur               :       JFF
-- Date                 :       22/02/2013
-- Libelle              :       Cloture d'une presta PRS 153/154 si REFUS_A_REEXP
-- Commentaires         :       [VDOC9304_PM82_LOT1]
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COMMANDE_VDOC9304_CLOTURE_DIAG' AND type = 'P' )
        DROP procedure sysadm.PS_U_COMMANDE_VDOC9304_CLOTURE_DIAG
GO

CREATE procedure sysadm.PS_U_COMMANDE_VDOC9304_CLOTURE_DIAG
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

UPDATE sysadm.commande
 SET	cod_etat = 'RFO'

 FROM   sysadm.sinistre s

 WHERE  s.id_sin = commande.id_sin
 AND    commande.id_sin = @dcIdSin
 AND    commande.id_ref_four in ( 'A_DIAGNOSTIQUER' )
 AND 	commande.status_gc in ( 153, 154 ) 
 AND	commande.cod_etat not in ( 'ANN' )
 
UPDATE sysadm.w_commande
 SET	cod_etat = 'RFO'
 
 FROM   sysadm.w_sin s

 WHERE  s.id_sin = w_commande.id_sin
 AND    w_commande.id_sin = @dcIdSin
 AND    w_commande.id_ref_four in ( 'A_DIAGNOSTIQUER' )
 AND 	w_commande.status_gc in ( 153, 154 ) 
 AND	w_commande.cod_etat not in ( 'ANN' )
 
GO


--------------------------------------------------------------------
--
-- Procedure            :       PS_U_COMMANDE_PM82_LOT1_CLOTURE_A_REPARER_FORCE
-- Auteur               :       JFF
-- Date                 :       21/09/2011
-- Libelle              :       Cloture d'une presta PRS 153/154 si REFUS_A_REEXP
-- Commentaires         :       [PM82][LOT1]
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-- 
-- JFF	07/06/2012  [MANTIS3405][PM200]
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      07/03/2024   [HP252_276_HUB_PRESTA]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COMMANDE_PM82_LOT1_CLOTURE_A_REPARER_FORCE' AND type = 'P' )
        DROP procedure sysadm.PS_U_COMMANDE_PM82_LOT1_CLOTURE_A_REPARER_FORCE
GO


CREATE procedure sysadm.PS_U_COMMANDE_PM82_LOT1_CLOTURE_A_REPARER_FORCE
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

UPDATE sysadm.commande
 SET	cod_etat = 
        Case commande.id_four
        	When 'O2M' Then 'RFO'
        	Else 'RPC'
        End 

 FROM   sysadm.sinistre s

 WHERE  s.id_sin = commande.id_sin
 AND    commande.id_sin = @dcIdSin
 AND    commande.id_ref_four in ( 'A_REPARER_FORCE', 'A_DESOXYDER_FORCE', 'A_DIAG_FORCE' )  --[MANTIS3405][PM200] -- [HP252_276_HUB_PRESTA]
 AND	commande.cod_etat not in ( 'ANN' )
 
UPDATE sysadm.w_commande
 SET
		cod_etat = 
        Case w_commande.id_four
        	When 'O2M' Then 'RFO'
        	Else 'RPC'
        End 

 FROM   sysadm.w_sin s

 WHERE  s.id_sin = w_commande.id_sin
 AND    w_commande.id_sin = @dcIdSin
 AND    w_commande.id_ref_four in ( 'A_REPARER_FORCE', 'A_DESOXYDER_FORCE', 'A_DIAG_FORCE'  ) --[MANTIS3405][PM200] -- [HP252_276_HUB_PRESTA]
 AND	w_commande.cod_etat not in ( 'ANN' )

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_COMMANDE_VDOC9304_CLOTURE_A_DIAG_FORCE
-- Auteur               :       JFF
-- Date                 :       22/02/2013
-- Libelle              :       Cloture d'une presta PRS 153/154 si REFUS_A_REEXP
-- Commentaires         :       [VDOC9304_PM82_LOT1]
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-- 
-- JFF	07/06/2012  [MANTIS3405][PM200]
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COMMANDE_VDOC9304_CLOTURE_A_DIAG_FORCE' AND type = 'P' )
        DROP procedure sysadm.PS_U_COMMANDE_VDOC9304_CLOTURE_A_DIAG_FORCE
GO

CREATE procedure sysadm.PS_U_COMMANDE_VDOC9304_CLOTURE_A_DIAG_FORCE
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

UPDATE sysadm.commande
 SET	cod_etat = 'RFO'
 
 FROM   sysadm.sinistre s

 WHERE  s.id_sin = commande.id_sin
 AND    commande.id_sin = @dcIdSin
 AND    commande.id_ref_four in ( 'A_DIAG_FORCE' )  
 AND	commande.cod_etat not in ( 'ANN' )
 
UPDATE sysadm.w_commande
  SET	cod_etat = 'RFO'

 FROM   sysadm.w_sin s

 WHERE  s.id_sin = w_commande.id_sin
 AND    w_commande.id_sin = @dcIdSin
  AND   w_commande.id_ref_four in ( 'A_DIAG_FORCE' )  
 AND	w_commande.cod_etat not in ( 'ANN' )


GO


--------------------------------------------------------------------
--
-- Procedure            :       DW_S11_COMMANDE
-- Auteur               :       FPI
-- Date                 :       22/11/2011
-- Libelle              :       Pour la fenêtre de maj manuelle de commande
-- Commentaires         :       [PM95]
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--				@iIdSeq		Int			(Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S11_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.DW_S11_COMMANDE
GO

CREATE procedure sysadm.DW_S11_COMMANDE
	@dcIdSin        Decimal (  10,0 ),  -- [PI062]
	@iIdSeq		Int
AS
	Select c.id_sin, c.id_seq, sysadm.FN_CLE_VAL('EXCL_REL',c.info_spb_frn_cplt,';') as valeur,
		(select count(*) 
		from sysadm.param_alerte_frn p 
		where p.id_prod=s.id_prod 
		and ( c.id_gti=p.id_gti or p.id_gti = -1 ) -- [PM287-2]
		and p.id_four=c.id_four) as nb_param_alerte
	From sysadm.commande c
		inner join sysadm.sinistre s on s.id_sin=c.id_sin
	where c.id_sin=@dcIdSin
		and c.id_seq=@iIdSeq
	Union
	Select c.id_sin, c.id_seq, sysadm.FN_CLE_VAL('EXCL_REL',c.info_spb_frn_cplt,';') as valeur,
		(select count(*) 
		from sysadm.param_alerte_frn p 
		where p.id_prod=s.id_prod 
		and ( c.id_gti=p.id_gti or p.id_gti = -1 ) -- [PM287-2]
		and p.id_four=c.id_four) as nb_param_alerte
	From sysadm.w_commande c
		inner join sysadm.w_sin s on s.id_sin=c.id_sin
	where c.id_sin=@dcIdSin
		and c.id_seq=@iIdSeq

Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_U01_COMMANDE
-- Auteur               :       FPI
-- Date                 :       22/11/2011
-- Libelle              :       Pour la fenêtre de maj manuelle de commande
-- Commentaires         :       [PM95]
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--				@iIdSeq		Int			(Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.DW_U01_COMMANDE
GO

CREATE procedure sysadm.DW_U01_COMMANDE
    @dcIdSin        Decimal (  10,0 ), -- [PI062]
	@iIdSeq		Int,
	@sVal		Varchar(3)
AS
	Update sysadm.commande 
	Set info_spb_frn_cplt=sysadm.FN_CLE_VAL_E('EXCL_REL',@sVal, info_spb_frn_cplt,';')
	where id_sin=@dcIdSin
	and id_seq=@iIdSeq
	
	Update sysadm.w_commande 
	Set info_spb_frn_cplt=sysadm.FN_CLE_VAL_E('EXCL_REL',@sVal, info_spb_frn_cplt,';')
	where id_sin=@dcIdSin
	and id_seq=@iIdSeq
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_FORCAGE_ID_LOT_CMD_PM103
-- Auteur               :       FABRY JF
-- Date                 :       25/05/2012
-- Libelle              :       Mise à jour spéciale 
-- Commentaires         :       On bascule pendant la validation les états de commande.  
-- References           :       [PM103][1]
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--				@sIdFour	VarChar ( 3 )
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_FORCAGE_ID_LOT_CMD_PM103' AND type = 'P' )
        DROP procedure sysadm.PS_U_FORCAGE_ID_LOT_CMD_PM103
GO

CREATE procedure sysadm.PS_U_FORCAGE_ID_LOT_CMD_PM103
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @iIdLot		integer
AS

	UPDATE sysadm.commande
	 SET
		id_lot_cmd      = @iIdLot,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par

	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND	sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', commande.info_spb_frn_cplt, ';') = 'OUI'
 Go

        
		
--------------------------------------------------------------------
--
-- Procedure            :       PS_U21_COMMANDE_STATUS_GC
-- Auteur               :       FPI
-- Date                 :       20/11/2012
-- Libelle              :       Mise à jour du status_gc à 0 
-- Commentaires         :       [ITSM_Status_GC_0] 
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--								@iIdSeq			Int
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U21_COMMANDE_STATUS_GC' AND type = 'P' )
        DROP procedure sysadm.PS_U21_COMMANDE_STATUS_GC
GO

CREATE procedure sysadm.PS_U21_COMMANDE_STATUS_GC
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
		@iIdSeq		Int,
		@sMajPar		Varchar(10)
AS

Declare @sDtJour varchar(10)
DECLARE @DBID INT     -- JFF_20140507
DECLARE @DBNAME NVARCHAR(128) -- JFF_20140507

-- JFF_20140507
If Exists ( 
	Select * from sysadm.w_queue where id_sin = @dcIdSin
	) 
   Or 
   Exists ( 
	Select	* 
	From	sysadm.detail d,
			sysadm.commande c
	Where	c.id_sin = @dcIdSin
	And		c.id_seq = @iIdSeq
	And		d.id_sin = c.id_sin
	And		d.id_gti = c.id_gti
	And		d.id_detail = c.id_detail
	And		d.mt_plaf > 0
   )
   OR 
   IsNull ( 
   ( Select max ( id_seq ) 
     From sysadm.commande c 
	 where c.id_sin = @dcIdSin
   ), 0 ) > @iIdSeq
  Begin
     SET @DBID = DB_ID()
     SET @DBNAME = DB_NAME()
     RAISERROR (50002, 16, 1, @DBID, @DBNAME)
     Return
  End
-- /JFF_20140507

Set @sDtJour = Convert ( VarChar ( 10 ) , getdate() , 103)

update sysadm.commande 
set status_gc=0, 
	cod_etat = 'ECT', 
	info_spb_frn_cplt = sysadm.FN_CLE_VAL_E('REMISE_SGC_A_0',@sDtJour + '_' + @sMajPar, rtrim (  isnull(info_spb_frn_cplt,'') ),';') 
where id_sin=@dcIdSin and id_seq=@iIdSeq


update sysadm.w_commande 
set status_gc=0, 
	cod_etat = 'ECT', 
	info_spb_frn_cplt = sysadm.FN_CLE_VAL_E('REMISE_SGC_A_0',@sDtJour + '_' + @sMajPar, rtrim (  isnull(info_spb_frn_cplt,'') ),';') 
where id_sin=@dcIdSin and id_seq=@iIdSeq

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U02_COMMANDE_EDEL
-- Auteur               :       FPI
-- Date                 :       05/12/2012
-- Libelle              :       Mise à jour de la zone info_frn_spb_cplt
-- Commentaires         :       [PC884] 
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--								@iIdSeq			Int
--								@sInfoSpbFrnCplt
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U02_COMMANDE_EDEL' AND type = 'P' )
        DROP procedure sysadm.PS_U02_COMMANDE_EDEL
GO

CREATE procedure sysadm.PS_U02_COMMANDE_EDEL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
		@iIdSeq		Int,
		@sInfoFrnSpbCplt		Varchar(255)
AS

update sysadm.commande 
set info_frn_spb_cplt = Left(Case When rtrim(isnull(info_frn_spb_cplt,''))='' Then @sInfoFrnSpbCplt Else rtrim(info_frn_spb_cplt) + ';' + @sInfoFrnSpbCplt End,255)
where id_sin=@dcIdSin and id_seq=@iIdSeq

update sysadm.w_commande 
set info_frn_spb_cplt = Left(Case When rtrim(isnull(info_frn_spb_cplt,''))='' Then @sInfoFrnSpbCplt Else rtrim(info_frn_spb_cplt) + ';' +@sInfoFrnSpbCplt End,255)
where id_sin=@dcIdSin and id_seq=@iIdSeq

Go

grant execute on sysadm.PS_U02_COMMANDE_EDEL to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procedure            :       v_commande_psm
-- Auteur               :       SBA
-- Date                 :       25/01/2013
-- Libelle              :       Vue sur commande
-- Commentaires         :       [VDOC10082]
-- References           :       
-- Arguments            :       
-- Retourne             :       Rien
-------------------------------------------------------------------
-- 08/03/2016   JFF [VDOC20161]
-------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[sysadm].[v_commande_psm]'))
DROP VIEW [sysadm].[v_commande_psm]
GO
CREATE view [sysadm].[v_commande_psm]
As
Select 
   s.id_sin,
	
   c.probleme, /* commentaire du GT */
   
   /*Point de vente ou centralisation  */
   
   Case 
       When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
                       Then 'POINT DE VENTE'
       When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
                       Then 'CENTRALISATION'
   End 'pdv_ou_coli_centl',
   
   /* Nom du psm */
   Case 
       When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
                       Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
       When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
                       Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
					   /*[VDOC20161]
					   Then ( Select Top 1 b.adr_nom
                                         From sysadm.boutique b
                                         Where b.id_prod = s.id_prod
                                         And   Convert ( Integer, b.cod_mag ) = Convert ( Integer, sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' ) )
                                      )
					   */
		Else                                      
			( Select Top 1 b.adr_nom
		                 From sysadm.boutique b
                         Where b.id_prod = s.id_prod
                         And   Convert ( Integer, b.cod_mag ) = Convert ( Integer, sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' ) )
                      )
		
   End 'nom_psm',
   Case 
                               When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
                                               Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
                               When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
                                               Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
											   -- Then sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' ) [VDOC20161]
   End 'Numéro PSM',
   Convert ( VarChar ( 10), c.dte_rcp_frn, 103 ) 'dte_reception'

From sysadm.commande c inner join sysadm.sinistre s on s.id_sin=c.id_sin
Where 
    c.id_four = 'PSM'     and
    c.id_seq = (select MAX(id_seq) from sysadm.commande c1 where c1.id_sin=c.id_sin and c1.id_four=c.id_four)

GO   
   
--------------------------------------------------------------------
--
-- Procedure            :       PS_U_COMMANDE_VIRTUELLE_RST
-- Auteur               :       FABRY JF
-- Date                 :       15/09/2010
-- Libelle              :       Mise à jour spéciale 
-- Commentaires         :       On bascule pendant la validation les états de commande.  
-- References           :       [PC301].[CARREFOUR]
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--				@sIdFour	VarChar ( 3 )
-- Retourne             :       Rien
--				JFF 22/11/2010 [PC301].[LOT2]
-- 			        JFF 23/05/2012 [PM103][1]
-- JFF      07/05/2013   [PC938_ORANGE_V3]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COMMANDE_VIRTUELLE_RST' AND type = 'P' )
        DROP procedure sysadm.PS_U_COMMANDE_VIRTUELLE_RST
GO

CREATE procedure sysadm.PS_U_COMMANDE_VIRTUELLE_RST
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sIdFour	VarChar ( 3 ),
        @iIdLot		integer
AS

	UPDATE sysadm.commande
	 SET
		-- [PM103][1]
		cod_etat        = 'RPC',
		id_lot_cmd      = @iIdLot,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par

	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    commande.id_four = Upper ( rtrim ( @sIdFour ) )
	 AND    commande.id_typ_art = 'RST'

	UPDATE sysadm.w_commande
	 SET
		-- [PM103][1]
	    cod_etat        = 'RPC'
	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat in ( 'CNV', 'ECT' )
	 AND    w_commande.id_four = Upper ( rtrim ( @sIdFour ) )
	 AND    w_commande.id_typ_art = 'RST'
 
 Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U_COMMANDE_VIRTUELLE_FERM
-- Auteur               :       FABRY JF
-- Date                 :       15/09/2010
-- Libelle              :       Mise à jour spéciale 
-- Commentaires         :       On bascule pendant la validation les états de commande.  
-- References           :       [PC301].[CARREFOUR]
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--				@sIdFour	VarChar ( 3 )
-- Retourne             :       Rien
--				JFF 22/11/2010 [PC301].[LOT2]
-- 			        JFF 23/05/2012 [PM103][1]
-- JFF      07/05/2013   [PC938_ORANGE_V3]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COMMANDE_VIRTUELLE_FERM' AND type = 'P' )
        DROP procedure sysadm.PS_U_COMMANDE_VIRTUELLE_FERM
GO

CREATE procedure sysadm.PS_U_COMMANDE_VIRTUELLE_FERM
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sIdFour	VarChar ( 3 ),
        @iIdLot		integer
AS

	UPDATE sysadm.commande
	 SET
		-- [PM103][1]
		cod_etat        = 'RPC',
		id_lot_cmd      = @iIdLot,
		cmd_gen_le      = s.valide_le,
		cmd_gen_par     = s.valide_par

	 FROM   sysadm.sinistre s

	 WHERE  s.id_sin = commande.id_sin
	 AND    commande.id_sin = @dcIdSin
	 AND    commande.cod_etat not in ( 'ANN' )
	 AND    commande.id_four = Upper ( rtrim ( @sIdFour ) )

	UPDATE sysadm.w_commande
	 SET
		-- [PM103][1]
	    cod_etat        = 'RPC'
	 WHERE  w_commande.id_sin = @dcIdSin
	 AND    w_commande.id_sin = @dcIdSin
	 AND    w_commande.cod_etat not in ( 'ANN' )
	 AND    w_commande.id_four = Upper ( rtrim ( @sIdFour ) )
	 	 
 Go


--------------------------------------------------------------------
--
-- Procedure            :       DW_S12_COMMANDE
-- Auteur               :       FPI
-- Date                 :       24/07/2013
-- Libelle              :       Chargement des commande ORE
-- Commentaires         :       
-- References           :       [PC767-1]
--
-- Arguments            :       @iIdLotCmd       Integer,
--								@sIdFour	 VarChar ( 3 )
-- Retourne             :       liste des presta de réparation
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S12_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.DW_S12_COMMANDE
GO

CREATE procedure sysadm.DW_S12_COMMANDE
	@iIdLotCmd       Integer,
	@sIdFour	 VarChar ( 3 )
As
	Select
		s.id_sin, 
		cmd.id_seq,
		cmd.id_four,
		IsNull ( cmd.adr_nom, '' ) as adr_nom,                        
	IsNull ( cmd.adr_prenom, '' ) as adr_prenom,                     
	IsNull ( cmd.adr_livr1, '' ) as adr_livr1,                      
	IsNull ( cmd.adr_livr2, '' ) as adr_livr2,   
	IsNull ( cmd.adr_livr_cpl, '' ) as adr_livr_cpl,
	IsNull ( cmd.adr_cp, '' ) as adr_cp,
	IsNull ( cmd.adr_ville, '' ) as adr_ville,
	IsNull ( cmd.adr_tel1, '' ) as adr_tel1,
	IsNull ( cmd.adr_tel2, '' ) as adr_tel2,
	IsNull ( cmd.adr_tel3, '' ) as adr_tel3,
		s.marq_port,
		s.modl_port,
		cmd.id_marq_art as marq_commandee,
		cmd.id_modl_art as modl_commandee,
		s.num_imei_port as num_imei_port,
		isnull(d.val_car,'') as code_verrou,
		Case d2.val_car When 'O' Then 'Oui' Else 'Non' End as desimlocke,
		cmd.probleme,
		Case when cmd.id_typ_art='PRS' Then 'Réparation' Else 'Remplacement' End as action,
		''    as oui_non,
		''    as precision_si_non,
		cmd.id_lot_cmd,                     
		cmd.cmd_gen_le,                     
		cmd.cmd_gen_par, 
		cmd.id_typ_art,
		cmd.cod_etat
		
	from sysadm.commande cmd
		inner join sysadm.sinistre s on s.id_sin=cmd.id_sin
		left outer join sysadm.div_sin d on d.id_sin=s.id_sin and d.nom_zone='code_verrou_sherpa_script'
		left outer join sysadm.div_sin d2 on d.id_sin=s.id_sin and d2.nom_zone='desimlocke'
		
	WHERE  cmd.id_lot_cmd = @iIdLotCmd  
	And	cmd.id_four    = @sIdFour
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_COMMANDES_VIPP
-- Auteur               :       FPI
-- Date                 :       19/07/2013
-- Libellé              :        
-- Commentaires         :       [PC929]
-- Références           :       
--
-------------------------------------------------------------------
-- FPI - 28/10/2014 - [ITSM245983] Ajout du filtre (dp 235) pour les résil Unisys
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_COMMANDES_VIPP' AND type = 'P' )
        DROP procedure sysadm.PS_S_COMMANDES_VIPP
GO

CREATE procedure sysadm.PS_S_COMMANDES_VIPP
	@dteDeb datetime,
	@dteFin datetime
AS
    SET NOCOUNT ON
	select Right('000' + convert(varchar(3),floor(s.id_prod / 100)),3) + 
		 Right('00000' + convert(varchar(10),id_ets),5) +
		 right('0000000' + rtrim(id_adh),7) + 
		 convert(varchar(1),id_sdos) +
		 convert(varchar(10),c.cree_le,112)
	from sysadm.commande c
	inner join sysadm.sinistre s on c.id_sin=s.id_sin
	inner join sysadm.det_pro d on d.id_prod=s.id_prod
	where c.id_four='VPP' and c.cree_le between @dteDeb and @dteFin
	and c.cod_etat <> 'ANN'
	and d.id_code_dp=235
	and sysadm.FN_CLE_VAL('RESIL_UNISYS',val_car,';')='OUI'
Go

grant execute on sysadm.PS_S_COMMANDES_VIPP to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_COMMANDES_VIPP_QUOTIDIEN
-- Auteur               :       FPI
-- Date                 :       19/07/2013
-- Libellé              :        
-- Commentaires         :       [PC929]
-- Références           :       
--
-------------------------------------------------------------------
-- JFF      19/03/2025   [LGY_40]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_COMMANDES_VIPP_QUOTIDIEN' AND type = 'P' )
        DROP procedure sysadm.PS_S_COMMANDES_VIPP_QUOTIDIEN
GO

CREATE procedure sysadm.PS_S_COMMANDES_VIPP_QUOTIDIEN
AS

Declare @dteDeb datetime,
	@dteFin datetime
Declare @sFicOut   VarChar(255)
Declare @sOsqlOption VarChar(255)
Declare @sNomServeur VarChar(255)
Declare @sBase		 VarChar ( 15 )
Declare @sRequete    VarChar ( 255 )
Declare @sCommande	 VarChar ( 255 )
Declare @iRetOsql    integer
Declare @iFileExist  integer
Declare @sMessage    Varchar(1000)
Declare @sObjet      VarChar(255)
Declare @sRetourErrMail VarChar(255)

Set @dteFin=CONVERT(datetime,(convert(date,GETDATE())))
Set @dteDeb=DATEADD(day,-1,@dteFin)

-- Un job chez PI effectuera le déplacement vers le bon répertoire
--Set @sFicOut='\\spb.lan\production\flux_applis\teletran\recept\cdiscount\Resil_CDiscount_'
-- Set @sFicOut='\\F4T\Simpa2\Cdiscount\Resiliations\Resil_CDiscount_'
-- [LGY_40]
Set @sFicOut = sysadm.FN_GET_CHEMIN ( 'SERV_FIC_PRESTA' ) + 'Cdiscount\Resiliations\Resil_CDiscount_'

Set @sFicOut=@sFicOut + convert(varchar(10),@dteDeb,112) + '.txt'

Set @sRequete='PS_S_COMMANDES_VIPP ''' + 
		CONVERT(varchar(20),@dteDeb,20) + ''',''' +
		CONVERT(varchar(20),@dteFin,20) + ''''
		
Set @sNomServeur = @@servername

-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode
Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /f1252'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO') Set @sBase = 'SIMPA2_PRO' Else Set @sBase = 'SIMPA2_TRT'

SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"exec ' + 
				 @sBase + '.sysadm.' + @sRequete + ' ' + 
				 '" /o' + @sFicOut + ' -w5000 -h-1' + @sOsqlOption

Exec master.dbo.xp_cmdshell @sCommande, no_output
-- En commentaire car déplacement du fichier par PI
/*				 
IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
Begin 		
	EXECUTE xp_fileexist @sFicOut, @iFileExist Output
	End
Else
	Begin
		Set @iFileExist = 1
End

If @iFileExist = 0
	Begin
		IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		  Begin
			Set @sObjet = 'Traitement Résil CDiscount-VIPP en erreur'
		  End 
		Else
		  Begin
			Set @sObjet = 'Traitement résil CDiscount-VIPP !! RECETTE !! en erreur'
		  End 
		
		Set @sMessage  = @sObjet + '.'
		Set @sMessage  = @sMessage + CHAR ( 13 ) +  CHAR ( 13 ) 
		Set @sMessage  = @sMessage + 'Le fichier suivant : ' + @sFicOut + ' ne s''est pas écrit sur disque, le traitement est stoppé.'
		
		EXEC master.dbo.SPB_PS_MAIL 
				@sRetourErrMail OUTPUT, 
				--'jff@spb.fr,GG_DSI-DO-PI@spb.lan,fpi@spb.fr,ilg@spb.fr',
				'fpi@spb.fr',
				@sMessage, 
				@sObjet, 
				'', 
				'', 
				NULL, 
				NULL, 
				NULL, 
				NULL, 
				NULL
	
		Return -1
	End 	
*/
				 
go

grant execute on sysadm.PS_S_COMMANDES_VIPP_QUOTIDIEN to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U01_COMMANDE_SRR
-- Auteur               :       FPI
-- Date                 :       26/03/2014
-- Libelle              :       Mise à jour de commande SRR
-- Commentaires         :       [PC925] 
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--								@iIdSeq			Int
--								@
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_COMMANDE_SRR' AND type = 'P' )
        DROP procedure sysadm.PS_U01_COMMANDE_SRR
GO

CREATE procedure sysadm.PS_U01_COMMANDE_SRR
        @dcIdSin        Decimal (  10,0 ),
		@iIdSeq		Int,
		@sIdCmdFrn		Varchar(20)
AS

update sysadm.commande 
set id_cmd_frn = @sIdCmdFrn, cod_etat='RPC', maj_le=getdate()
where id_sin=@dcIdSin and id_seq=@iIdSeq

update sysadm.w_commande 
set id_cmd_frn = @sIdCmdFrn, cod_etat='RPC'
where id_sin=@dcIdSin and id_seq=@iIdSeq

Go

grant execute on sysadm.PS_U01_COMMANDE_SRR to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U01_COMMANDE_SRR_V01
-- Auteur               :       FPI
-- Date                 :       26/03/2014
-- Libelle              :       Mise à jour de commande SRR
-- Commentaires         :       [PC925] 
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--								@iIdSeq			Int
--								@
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- [PC14639]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_COMMANDE_SRR_V01' AND type = 'P' )
        DROP procedure sysadm.PS_U01_COMMANDE_SRR_V01
GO


CREATE procedure sysadm.PS_U01_COMMANDE_SRR_V01
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
		@iIdSeq		Int,
		@sIdCmdFrn		Varchar(20),
		@sMess			varchar(254),
		@sMajPar	Varchar(4)
AS

update sysadm.commande 
set id_cmd_frn = @sIdCmdFrn, cod_etat='RPC', maj_le=getdate()
where id_sin=@dcIdSin and id_seq=@iIdSeq

update sysadm.w_commande 
set id_cmd_frn = @sIdCmdFrn, cod_etat='RPC'
where id_sin=@dcIdSin and id_seq=@iIdSeq

If @sMess is not null
Begin 
	update sysadm.commande 
	set info_spb_frn_cplt='ERREUR_WS=' + @sMess, maj_le=getdate(), maj_par=@sMajPar
	where id_sin=@dcIdSin and id_seq=@iIdSeq
	
	update sysadm.w_commande 
	set info_spb_frn_cplt='ERREUR_WS=' + @sMess, maj_le=getdate(), maj_par=@sMajPar
	where id_sin=@dcIdSin and id_seq=@iIdSeq
	
	 IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')  
      EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V03 @dcIdSin, 2, @sMess, @sMajPar, 'X' , 0 , null, 'I', null, 785  
  Else  
      EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V03 @dcIdSin, 2, @sMess, @sMajPar, 'X' , 0 , null, 'I', null, 785  
End

Go

grant execute on sysadm.PS_U01_COMMANDE_SRR_V01 to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U01_COMMANDE_PLAF
-- Auteur               :       JFF
-- Date                 :       29/07/2014
-- Libelle              :       Interprétation du plafond 721 franchise si incomplet sur insertion auto VIPP 
-- Commentaires         :       [MANTIS11520] -- [MANTIS11520][PC13419]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_COMMANDE_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_U01_COMMANDE_PLAF
GO

CREATE procedure sysadm.PS_U01_COMMANDE_PLAF
        @dcIdSin         Decimal (  10,0 ), -- [PI062]
        @dcIdProd        Decimal (  7,0 ),
		@dcIdRev		 Decimal (  7,0 ),
		@dcIdGti         Decimal (  7,0 ),
		@dcIdEvt		 Decimal (  7,0 ),
		@dcIdTypPlaf	 Decimal (  7,0 ),
		@dcMtPec		 Decimal ( 11,2 ),
		@sInfoFrnSpbCplt VarChar ( 800 ),
		@dcMtPecPlaf	 Decimal ( 11,2 ) OUTPUT
AS

Declare @dcIdNivPlaf VarChar ( 3)
Declare @dcIdRefPlaf VarChar ( 3)
Declare @dcMtPlaf Decimal ( 11,2 )
Declare @iAppIncomplet integer

Set @dcIdNivPlaf = '+EV'
Set @iAppIncomplet = 0

If @dcIdEvt is null Set @dcIdEvt = -1
Set @dcIdRefPlaf = @dcIdEvt 

If @dcIdRefPlaf = -1 Set @dcIdNivPlaf = '-GA'

If @dcIdTypPlaf = 721 
  Begin
	If ( Select sysadm.FN_CLE_VAL ( 'APP_INCOMPLET', @sInfoFrnSpbCplt, ';' )) = 'OUI'
	 Begin
		Set @iAppIncomplet = 1
	 End
	Else
	 Begin
		If Exists ( 
			Select 1
			From   sysadm.commande c
			Where  c.id_sin = @dcIdSin
			And    c.cod_etat <> 'ANN' 
			And    sysadm.FN_CLE_VAL ( 'APP_INCOMPLET', c.info_frn_spb_cplt, ';' ) = 'OUI'
		   ) 
		  Begin
			Set @iAppIncomplet = 1		  
		  End 
	 End 
  End 

Select  @dcMtPlaf = p.mt_plaf
From	sysadm.plafond p
Where   p.id_prod = @dcIdProd
And     p.id_rev  = @dcIdRev
And     p.id_gti  = @dcIdGti
And     p.id_niv_plaf = @dcIdNivPlaf
And     p.id_ref_plaf = @dcIdRefPlaf
And     p.id_typ_plaf = @dcIdTypPlaf

If @dcMtPlaf is null Set @dcMtPlaf = 0

If @iAppIncomplet = 1
  Begin	
	Set @dcMtPecPlaf = @dcMtPec - ( @dcMtPec * @dcMtPlaf )
  End 
Else
  Begin 
	Set @dcMtPecPlaf = @dcMtPec 
  End 
If @dcMtPecPlaf is null Set @dcMtPecPlaf = 0
If @dcMtPecPlaf <= 0 Set @dcMtPecPlaf = 0

Go
--------------------------------------------------------------------
--
-- Procedure            :       PS_COMMANDES_SPBS_VEILLE
-- Auteur               :       FPI
-- Date                 :       30/07/2014
-- Libelle              :       Mail avec les commandes SPBS de la veille pour P. Hemled & S. Raccouchot 
-- Commentaires         :       [FPI.20140730]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_COMMANDES_SPBS_VEILLE' AND type = 'P' )
        DROP procedure sysadm.PS_COMMANDES_SPBS_VEILLE
GO

CREATE procedure sysadm.PS_COMMANDES_SPBS_VEILLE
AS
Declare @sLaVeille VarChar ( 10 )
Declare @sLaVeilleFin VarChar ( 23 )
Declare @dtDeb Datetime
Declare @dtFin Datetime

Set Nocount on

Set @sLaVeille  = Convert ( VarChar ( 10), DateAdd ( day,-1, getdate()), 103 )
Set @sLaVeilleFin=Convert ( VarChar ( 10), getdate(), 103 )

Select @dtDeb=CONVERT(datetime,@sLaVeille,103),
	@dtFin=CONVERT(datetime,@sLaVeilleFin,103)

select c.id_sin, id_seq, 
	s.id_prod, sysadm.FN_LIB_PROD(s.id_prod) as lib_produit,
	adr_nom, adr_prenom, 
	adr_livr1, 
	isnull(adr_livr2,'') as adr_livr2, 
	isnull(adr_livr_cpl,'') as adr_livr_cpl, 
	adr_cp, adr_ville,
	isnull(adr_tel1,'') as adr_tel1,
	isnull(adr_tel2,'') as adr_tel2,
	isnull(adr_tel3,'') as adr_tel3,
	id_typ_art, probleme, num_imei_port,
	marq_port, modl_port, 
	Convert ( VarChar ( 10),cmd_gen_le,103) as cmd_gen_le,
	id_gti, id_ref_four,
	isnull(info_spb_frn,'') as info_spb_frn,
	isnull(info_spb_frn_cplt,'') as info_spb_frn_cplt 
from sysadm.commande c
	inner join sinistre s on s.id_sin=c.id_sin
where id_four='O2M' 
	and cmd_gen_le is not null
	and cmd_gen_le between @dtDeb and @dtFin
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
	
Go



grant execute on sysadm.PS_COMMANDES_SPBS_VEILLE to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procedure            :       PS_COMMANDES_SPBS_VEILLE_MAIL
-- Auteur               :       FPI
-- Date                 :       30/07/2014
-- Libelle              :       Mail avec les commandes SPBS de la veille pour P. Hemled & S. Raccouchot 
-- Commentaires         :       [FPI.20140730]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      19/03/2025   [LGY_40]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_COMMANDES_SPBS_VEILLE_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_COMMANDES_SPBS_VEILLE_MAIL
GO

CREATE procedure sysadm.PS_COMMANDES_SPBS_VEILLE_MAIL
AS

Declare @sNomServeur VarChar(255)
Declare @sOsqlOption VarChar(255)
Declare @iRetOsql    int	
Declare @sFicOut     VarChar(255)		
Declare @sBase		 VarChar ( 15 )
Declare @sRequete	 VarChar ( 100 )
Declare @sCommande	 VarChar ( 255 )
Declare @sMessage    Varchar(800)
Declare @sObjet      VarChar(255)
Declare @sRetourErrMail VarChar(255)
Declare @sChemin    VarChar ( 255 )
Declare @sFichierExcel VarChar ( 255 )

Set NoCount On

--Set @sChemin = master.sysadm.SPB_FN_GET_ROOT() + '\Sinistre\Export_Cmd_O2M_Veille\'
-- Set @sChemin='\\F4T\SIMPA2\O2M\Export_Cmd_O2M_Veille\'
-- [LGY_40]
Set @sChemin=sysadm.FN_GET_CHEMIN ( 'SERV_FIC_PRESTA' ) + 'Export_Cmd_O2M_Veille\'

Set @sFichierExcel = 'Export_Cmd_O2M_' + Convert ( VarChar ( 10), DateAdd ( day,-1, getdate()), 112 ) + '.xls'
Set @sNomServeur = @@servername

-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode
Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO') Set @sBase = 'SIMPA2_PRO' Else Set @sBase = 'SIMPA2_TRT'

Set @sFicOut = @sChemin + @sFichierExcel

Set @sRequete = 'PS_COMMANDES_SPBS_VEILLE'

SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
		 @sBase + '.sysadm.' + @sRequete + ' ' + 
		 '" /o' + @sFicOut + ' -w5000' + @sOsqlOption


EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = 'Commandes SPBS du ' + Convert ( VarChar ( 10), DateAdd ( day,-1, getdate()), 103 )
set @sMessage  = 'Bonjour,'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Vous trouverez ci-joint l''extraction des commandes SPBS du ' + Convert ( VarChar ( 10), DateAdd ( day,-1, getdate()), 103 ) + '.'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Bonne réception.'

if @iRetOsql = 0
 BEGIN
	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'p.hemled@o2m.fr',
			@sMessage, 
			@sObjet, 
			'', 
			NULL, --'sracouchot@spb.eu', 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL
 END


Go

grant execute on sysadm.PS_COMMANDES_SPBS_VEILLE_MAIL to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U22_COMMANDE_ETAT_APP_PRET
-- Auteur               :       FPI
-- Date                 :       07/10/2014
-- Libelle              :       Mise à jour du info_frn_spb_cplt
-- Commentaires         :       [OV3.FPI] 
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--								@iIdSeq			Int
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U22_COMMANDE_ETAT_APP_PRET' AND type = 'P' )
        DROP procedure sysadm.PS_U22_COMMANDE_ETAT_APP_PRET
GO

CREATE procedure sysadm.PS_U22_COMMANDE_ETAT_APP_PRET
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
		@iIdSeq		Int,
		@sMajPar		Varchar(10)
AS

Declare @sDtJour varchar(10)

Set @sDtJour = Convert ( VarChar ( 10 ) , getdate() , 103)

update sysadm.commande 
set info_frn_spb_cplt = sysadm.FN_CLE_VAL_E('ETAT_APP_PRET','CONFORME',
		sysadm.FN_CLE_VAL_E('REC_CONF',@sDtJour + '_' + @sMajPar, rtrim (  isnull(info_frn_spb_cplt,'') ),';')
		,';') 		
where id_sin=@dcIdSin and id_seq=@iIdSeq


update sysadm.w_commande 
set info_frn_spb_cplt = sysadm.FN_CLE_VAL_E('ETAT_APP_PRET','CONFORME',
		sysadm.FN_CLE_VAL_E('REC_CONF',@sDtJour + '_' + @sMajPar, rtrim (  isnull(info_frn_spb_cplt,'') ),';')
		,';') 		
where id_sin=@dcIdSin and id_seq=@iIdSeq

Go

grant execute on sysadm.PS_U22_COMMANDE_ETAT_APP_PRET to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U_COMMANDE_ELD_NUM_CC
-- Auteur               :       JFF
-- Date                 :       17/12/2014
-- Libelle              :       Mise à jour du du numéro de carte ElectroDepot
-- Commentaires         :       [PC13321] 
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--								@iIdSeq			Int
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      04/02/2019   [PM421-3]
-- JFF      19/12/2022   [RS4093_EVOL_ELD]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COMMANDE_ELD_NUM_CC' AND type = 'P' )
        DROP procedure sysadm.PS_U_COMMANDE_ELD_NUM_CC
GO


CREATE procedure sysadm.PS_U_COMMANDE_ELD_NUM_CC
        @dcIdSin    Decimal (  10,0 ), -- [PI062]
		@iIdSeq		Int
As

Declare @idTrt Integer
Declare @sNumCCElD VarChar  ( 50 )
Declare @sPartieFixeELD VarChar  ( 20 )
Declare @sPartieFixeVariable VarChar  ( 20 )
Declare @sPartAleatoire VarChar ( 4 )
Declare @dtDteNaiss Datetime
Declare @sRefIdemn VarChar ( 30 )

-- Carte Cadeau

-- [RS4093_EVOL_ELD] 
If sysadm.FN_CLE_NUMERIQUE ( 'RS4093_EVOL_ELD') > 0 
 Begin
	Set @sNumCCElD = CONVERT ( Varchar ( 10 ), @dcIdSin ) + '-' + CONVERT ( Varchar ( 2 ), @iIdSeq ) 

	Update sysadm.commande 
	Set info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'RS4093', 'OUI', RTRIM( info_spb_frn_cplt ) , ';' )
	Where id_sin = @dcIdSin
	And id_seq = @iIdSeq

	Update sysadm.w_commande 
	Set info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'RS4093', 'OUI', RTRIM( info_spb_frn_cplt ) , ';' )
	Where id_sin = @dcIdSin
	And id_seq = @iIdSeq
 End 
Else 
 Begin
	Set @sPartieFixeELD = 'K9447595051'

	EXEC sysadm.PS_X_INCREMENTER 'ID_CC_ELD', @idTrt OUTPUT 

	Set @sPartieFixeVariable = Right ( REPLICATE ( '0', 8 ) + CONVERT ( VarChar ( 20 ) , @idTrt ), 8 )

	Set @sNumCCElD = @sPartieFixeELD + @sPartieFixeVariable 
	If @sNumCCElD is null Set @sNumCCElD = ''
 End 

 	
Update sysadm.commande 
Set info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'NUM_CC_ELD', @sNumCCElD, RTRIM( info_spb_frn_cplt ) , ';' )
Where id_sin = @dcIdSin
And id_seq = @iIdSeq

Update sysadm.w_commande 
Set info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'NUM_CC_ELD', @sNumCCElD, RTRIM( info_spb_frn_cplt ) , ';' )
Where id_sin = @dcIdSin
And id_seq = @iIdSeq


-- [PM421-3]
-- [RS4093_EVOL_ELD] 
If NOT sysadm.FN_CLE_NUMERIQUE ( 'RS4093_EVOL_ELD') > 0 
 Begin
	If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @dcIdSin  )	
		Begin
			If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'num_carte_cadeau')
				Begin
					Update sysadm.w_div_sin Set val_car = @sNumCCElD, maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'num_carte_cadeau'
				End 
			Else
				Begin	 
					Insert into sysadm.w_div_sin values ( @dcIdSin, 'num_carte_cadeau', 'Numéro de carte cadeau ELD', '-1', 'N', 'C', 'N', 'N', 120, null, null, null, @sNumCCElD, 1, getdate(), getdate(), 'AUTO' ) 
				End
		End

	If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @dcIdSin  )	
		Begin
			If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'num_carte_cadeau')
				Begin
					Update sysadm.div_sin Set val_car = @sNumCCElD, maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'num_carte_cadeau'
				End 
			Else
				Begin	 
					Insert into sysadm.div_sin values ( @dcIdSin, 'num_carte_cadeau', 'Numéro de carte cadeau ELD', '-1', 'N', 'C', 'N', 'N', 120, null, null, null, @sNumCCElD, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
				End
		End	
 End 

-- Ref idemnisation
Select @sPartAleatoire = Replace ( Right ( convert ( VarChar ( 50 ) , GETDATE(), 113 ), 5 ), ':', '' )

Select @dtDteNaiss = ds.val_dte
From sysadm.div_sin ds
Where ds.id_sin = @dcIdSin
And   ds.nom_zone = 'dte_nais_adh'

If @dtDteNaiss is null Set @dtDteNaiss = GETDATE()

Set @sRefIdemn = LEFT ( @sPartAleatoire, 2 ) + CONVERT ( Varchar ( 50), @dtDteNaiss, 112 ) + Right ( @sPartAleatoire, 2 )

Update sysadm.commande 
Set info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'REF_INDEM', @sRefIdemn, RTRIM( info_spb_frn_cplt ) , ';' )
Where id_sin = @dcIdSin
And id_seq = @iIdSeq

Update sysadm.w_commande 
Set info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'REF_INDEM', @sRefIdemn, RTRIM( info_spb_frn_cplt ) , ';' )
Where id_sin = @dcIdSin
And id_seq = @iIdSeq

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_COMMANDE_ELD_NUM_CC_REDRESS
-- Auteur               :       JFF
-- Date                 :       23/04/2019
-- Libelle              :       Mise à jour du du numéro de carte ElectroDepot
-- Commentaires         :       [PC13321] 
-- References           :       Parfois, les num CC ne se génère pas, jamais trouvé la cause du pourquoi
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--								@iIdSeq			Int
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COMMANDE_ELD_NUM_CC_REDRESS' AND type = 'P' )
        DROP procedure sysadm.PS_U_COMMANDE_ELD_NUM_CC_REDRESS
GO


CREATE procedure sysadm.PS_U_COMMANDE_ELD_NUM_CC_REDRESS

AS

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ),
	  id_seq_cmde integer,
	  marquage	integer null 
	)

Declare @dcIdSin decimal (10 )
Declare @iIdSeqCmde integer
Declare @iIdSeq integer

Insert into @tb
Select id_sin, id_seq, 0
From sysadm.commande 
where id_four = 'ELD' 
And   id_typ_art = 'CAF'
And   sysadm.FN_CLE_VAL ( 'NUM_CC_ELD', rtrim ( info_spb_frn_cplt ) , ';' ) = ''
And   id_lot_cmd = 0
And   cree_le > DateAdd ( day, -2, getdate() )


While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin,
		@iIdSeqCmde = id_seq_cmde
	From	@tb
	Where	marquage = 0


	Exec sysadm.PS_U_COMMANDE_ELD_NUM_CC @dcIdSin, @iIdSeqCmde

	Update @tb Set marquage = 1 Where id_seq = @iIdSeq
 End

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S_COUR_CARTE_CADEAU_ELD_KSL
-- Auteur               :       JFF
-- Date                 :       17/12/2014
-- Libelle              :       Mise à jour du du numéro de carte ElectroDepot
-- Commentaires         :       [PC13321] 
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--								@iIdSeq			Int
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      06/11/2018   [PM451-1]
-- JFF      19/12/2022   [RS4093_EVOL_ELD]
-- JFF      26/04/2023   [RS5045_REF_MATP]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_COUR_CARTE_CADEAU_ELD_KSL' AND type = 'P' )
        DROP procedure sysadm.PS_S_COUR_CARTE_CADEAU_ELD_KSL
GO

CREATE procedure sysadm.PS_S_COUR_CARTE_CADEAU_ELD_KSL
As

SET NOCOUNT ON

-- [RS5045_REF_MATP]
If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 
 Begin
	-- Fin de cette méthode
	Return
 End 

Delete from sysadm.w_cour_xml_orangev3

Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      code_maquette,
	  adr_mail,
	  montant_carte_cadeau,
	  ref_indemnisation,
	  id_seq_cmde,
	  code_chq_cadeau,
	  code_acces_securise, -- [RS4093_EVOL_ELD]
	  app_marque,
      app_modele
	)
Select	
	s.id_sin, 
	sysadm.FN_CODE_NUM(pers.cod_civ,'-CI') as civilite, 
	Case When pers.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
		 Else sysadm.FN_CODE_NUM(pers.cod_civ,'-CL') 
	End as civilite_longue, 
	pers.nom,
	pers.prenom,
	pers.adr_1, 
	pers.adr_2, 
	Case pers.adr_cp When '00000' then '' Else pers.adr_cp End as adr_cp, 
	pers.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=s.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=s.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	rtrim ( sysadm.FN_LIB_CIE (s.id_sin)) as lib_compagnie,
	rtrim ( sysadm.FN_LIB_POLICE (s.id_sin)) as lib_police,
	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=s.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),s.dte_decl,20) as dte_decl,
	s.maj_par as code_operateur,
	'carte_cadeau_electro_depot' as code_maquette,
	i.adr_mail,
	c.mt_ttc_cmde As montant_carte_cadeau,
	sysadm.FN_CLE_VAL ( 'REF_INDEM', rtrim(c.info_spb_frn_cplt), ';' ) As ref_indemnisation,
	c.id_seq,
	sysadm.FN_CLE_VAL ( 'NUM_CC_ELD', rtrim( c.info_spb_frn_cplt), ';' ) As code_chq_cadeau,
	sysadm.FN_CLE_VAL ( 'CODE_SECURITE', rtrim( c.info_frn_spb_cplt), ';' ) As code_acces_securise, -- [RS4093_EVOL_ELD]
	s.marq_port,
	s.modl_port
	
From	sysadm.sinistre s,
		sysadm.personne pers,
		sysadm.produit p,
		sysadm.inter i,
		sysadm.commande c
Where   pers.id_ordre = s.id_ordre
And	    c.id_four = 'ELD'
And     c.status_gc = 401
And		c.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'DTE_BGE', c.info_spb_frn_cplt, ';' ) = '' -- Absence marquage
And		c.id_sin = s.id_sin		
And		p.id_prod=s.id_prod
And		i.id_sin=s.id_sin
And 	i.cod_inter='A'

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	xml_data 
From sysadm.w_cour_xml_orangev3

Go

grant execute on sysadm.PS_S_COUR_CARTE_CADEAU_ELD_KSL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_COUR_CARTE_CADEAU_ELD_KSL
-- Auteur               :       JFF
-- Date                 :       17/12/2014
-- Libelle              :       Mise à jour du du numéro de carte ElectroDepot
-- Commentaires         :       [PC13321] 
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--								@iIdSeq			Int
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      26/04/2023   [RS5045_REF_MATP]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COUR_CARTE_CADEAU_ELD_KSL' AND type = 'P' )
        DROP procedure sysadm.PS_U_COUR_CARTE_CADEAU_ELD_KSL
GO

CREATE procedure sysadm.PS_U_COUR_CARTE_CADEAU_ELD_KSL
        @adcIdSin     Decimal (  10,0 ), -- [PI062]
        @aiIdSeq	  Integer
As

SET NOCOUNT ON

-- [RS5045_REF_MATP]
If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 
 Begin
	-- Fin de cette méthode
	Return
 End

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )

Set @sMess = 'Courrier lié à la carte cadeau, envoyé '
	
Update	sysadm.commande
Set	    info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'DTE_BGE', CONVERT ( VarChar ( 10 ), getdate(), 103 ), RTRIM( c.info_spb_frn_cplt ), ';')
From	sysadm.commande c 
Where  	c.id_sin = @adcIdSin
And		c.id_seq = @aiIdSeq

Update	sysadm.w_commande
Set	    info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'DTE_BGE', CONVERT ( VarChar ( 10 ), getdate(), 103 ), RTRIM( c.info_spb_frn_cplt ), ';')
From	sysadm.w_commande c 
Where  	c.id_sin = @adcIdSin
And		c.id_seq = @aiIdSeq

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT
END

Go

grant execute on sysadm.PS_U_COUR_CARTE_CADEAU_ELD_KSL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_COUR_CARTE_CADEAU_ELD_KSL_REDRESS
-- Auteur               :       JFF
-- Date                 :       05/04/2019
-- Libelle              :       Mise à jour du du numéro de carte ElectroDepot en mode redressement
--                              En effet, l'automate KSL créé bien le courrier, mais ne marque pas toujours le courrier sur SIMPA2
-- Commentaires         :       [PC13321] 
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--								@iIdSeq			Int
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      26/04/2023   [RS5045_REF_MATP]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COUR_CARTE_CADEAU_ELD_KSL_REDRESS' AND type = 'P' )
        DROP procedure sysadm.PS_U_COUR_CARTE_CADEAU_ELD_KSL_REDRESS
GO

CREATE procedure sysadm.PS_U_COUR_CARTE_CADEAU_ELD_KSL_REDRESS
As

SET NOCOUNT ON

-- [RS5045_REF_MATP]
-- Lors de la désact de clé, pensez à enlever l'appel dans PS_CORRECTION_BASE_NUIT_2
If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 
 Begin
	-- Fin de cette méthode
	Return
 End 

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ),
	  id_seq_cmde integer,
	  marquage	integer null 
	)

Set @sMess = 'Courrier lié à la carte cadeau, envoyé '

Declare @dcIdSin decimal (10 )
Declare @iIdSeq integer
Declare @iIdSeqCmde integer

Insert into @tb
Select  c.id_sin,
		c.id_seq,
		0
From	sysadm.commande c
Where   c.id_four = 'ELD'
And     c.status_gc = 401
And		c.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'DTE_BGE', c.info_spb_frn_cplt, ';' ) = '' -- Absence marquage
and     c.dte_env_cli <= Dateadd ( day, -3, getdate())


While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin,
		@iIdSeqCmde = id_seq_cmde
	From	@tb
	Where	marquage = 0

	
	Update	sysadm.commande
	Set	    info_spb_frn_cplt = 
			sysadm.FN_CLE_VAL_E ( 'DTE_BGE_REDRESSEE', 'OUI',
			sysadm.FN_CLE_VAL_E ( 'DTE_BGE', CONVERT ( VarChar ( 10 ), DateAdd ( day, 1, c.dte_env_cli), 103 ), RTRIM( c.info_spb_frn_cplt ), ';')
			, ';')
	From	sysadm.commande c 
	Where  	c.id_sin = @dcIdSin
	And		c.id_seq = @iIdSeqCmde

	Update	sysadm.w_commande
	Set	    info_spb_frn_cplt = 
			sysadm.FN_CLE_VAL_E ( 'DTE_BGE_REDRESSEE', 'OUI',
			sysadm.FN_CLE_VAL_E ( 'DTE_BGE', CONVERT ( VarChar ( 10 ), DateAdd ( day, 1, c.dte_env_cli), 103 ), RTRIM( c.info_spb_frn_cplt ), ';')
			, ';')
	From	sysadm.w_commande c 
	Where  	c.id_sin = @dcIdSin
	And		c.id_seq = @iIdSeqCmde

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT
	END
	ELSE
	BEGIN
		Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT
	END

	Update @tb Set marquage = 1 Where id_seq = @iIdSeq
 End
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_ID_SEQ_NUM_CARTE_ED
-- Auteur               :       JFF
-- Date                 :       17/12/2014
-- Libelle              :       Mise à jour du du numéro de carte ElectroDepot
-- Commentaires         :       [PC13321] 
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--								@iIdSeq			Int
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_ID_SEQ_NUM_CARTE_ED' AND type = 'P' )
        DROP procedure sysadm.PS_S_ID_SEQ_NUM_CARTE_ED
GO

CREATE procedure sysadm.PS_S_ID_SEQ_NUM_CARTE_ED
	@dcIdSin	Decimal (10), -- [PI062]
	@sNumCarteED	VarChar ( 100 ),
	@iIdSeq		Integer OutPut
As

If @sNumCarteED is null Set @sNumCarteED = ''

If @sNumCarteED <> ''
	Begin 
	Select @iIdSeq	= c.id_seq
	From sysadm.commande c
	Where c.id_sin = @dcIdSin
	And   c.id_four = 'ELD'
	And   c.id_typ_art = 'CAF'
	And   c.cod_etat in ( 'ECT', 'ECL' ) 
	And   sysadm.FN_CLE_VAL ( 'NUM_CC_ELD', c.info_spb_frn_cplt, ';' ) = @sNumCarteED
	End 

If @iIdSeq is Null Or @iIdSeq <= 0 
	Begin
	Select Top 1 @iIdSeq = c.id_seq
	From sysadm.commande c
	Where c.id_sin = @dcIdSin
	And   c.id_four = 'ELD'
	And   c.id_typ_art = 'CAF'
	And   c.cod_etat in ( 'ECT', 'ECL' ) 
	End 

If @iIdSeq is Null Or @iIdSeq <= 0 
	Begin
	Select Top 1 @iIdSeq = c.id_seq
	From sysadm.commande c
	Where c.id_sin = @dcIdSin
	And   c.id_four = 'ELD'
	And   c.id_typ_art = 'CAF'
	And   c.cod_etat in ( 'RPC', 'RFO', 'ANN' ) 
	End 

If @iIdSeq is null Or @iIdSeq <= 0 Set @iIdSeq = -1

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S_COUR_DEM_PCE_SFR_SBE_FACT_ACHAT_KSL
-- Auteur               :       JFF
-- Date                 :       05/05/2015
-- Libelle              :       
-- Commentaires         :       [DT141] 
-- References           :       
-- Arguments            :       
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      06/11/2018   [PM451-1]
-- JFF      26/04/2023   [RS5045_REF_MATP]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_COUR_DEM_PCE_SFR_SBE_FACT_ACHAT_KSL' AND type = 'P' )
        DROP procedure sysadm.PS_S_COUR_DEM_PCE_SFR_SBE_FACT_ACHAT_KSL
GO

CREATE procedure sysadm.PS_S_COUR_DEM_PCE_SFR_SBE_FACT_ACHAT_KSL
As

SET NOCOUNT ON

-- [RS5045_REF_MATP]
If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0
 Begin
	-- Fin de cette méthode
	Return
 End 

Delete from sysadm.w_cour_xml_orangev3

Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      no_ligne_assuree,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      code_maquette,
	  adr_mail,
	  app_marque,
      app_modele
	)
Select	
	s.id_sin, 
	sysadm.FN_CODE_NUM(pers.cod_civ,'-CI') as civilite, 
	Case When pers.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
		 Else sysadm.FN_CODE_NUM(pers.cod_civ,'-CL') 
	End as civilite_longue, 
	pers.nom,
	pers.prenom,
	pers.adr_1, 
	pers.adr_2, 
	Case pers.adr_cp When '00000' then '' Else pers.adr_cp End as adr_cp, 
	pers.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=s.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=s.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	rtrim ( sysadm.FN_LIB_CIE (s.id_sin)) as lib_compagnie,
	rtrim ( sysadm.FN_LIB_POLICE (s.id_sin)) as lib_police,
	s.num_port as no_ligne_assuree,
	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=s.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),s.dte_decl,20) as dte_decl,
	s.maj_par as code_operateur,
	'MAIL_DEM_PIECE_SBE' as code_maquette,
	i.adr_mail,
	s.marq_port,
	s.modl_port

From	sysadm.sinistre s,
		sysadm.personne pers,
		sysadm.produit p,
		sysadm.inter i,
		sysadm.div_sin ds
Where   pers.id_ordre = s.id_ordre
and		ds.nom_zone = 'pce_fact_achat_adem'
and		ds.val_car = 'O'
And		ds.id_sin = s.id_sin		
And		p.id_prod=s.id_prod
And		i.id_sin=s.id_sin
And 	i.cod_inter='A'
And		Not Exists ( 
			Select top 1 1
			From   sysadm.div_sin ds2
			Where  ds2.id_sin = ds.id_sin
			And	   ds2.nom_zone = 'dte_pce_fact_achat_dem'
		) 

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	xml_data 
From sysadm.w_cour_xml_orangev3

Go

grant execute on sysadm.PS_S_COUR_DEM_PCE_SFR_SBE_FACT_ACHAT_KSL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_COUR_DEM_PCE_SFR_SBE_FACT_ACHAT_KSL
-- Auteur               :       JFF
-- Date                 :       05/05/2014
-- Libelle              :       
-- Commentaires         :       [DT141] 
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--								@iIdSeq			Int
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      26/04/2023   [RS5045_REF_MATP]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COUR_DEM_PCE_SFR_SBE_FACT_ACHAT_KSL' AND type = 'P' )
        DROP procedure sysadm.PS_U_COUR_DEM_PCE_SFR_SBE_FACT_ACHAT_KSL
GO

CREATE procedure sysadm.PS_U_COUR_DEM_PCE_SFR_SBE_FACT_ACHAT_KSL
        @adcIdSin     Decimal (  10,0 ) -- [PI062]
As

SET NOCOUNT ON

-- [RS5045_REF_MATP]
If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 
 Begin
	-- Fin de cette méthode
	Return
 End 

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )

Set @sMess = 'Courrier lié à la demande de pièce facture d''achat, envoyé par KSL.'

If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_pce_fact_achat_dem')
	 Begin
	   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_pce_fact_achat_dem'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_pce_fact_achat_dem', 'Date facture achat SBE demandée', '-1', 'N', 'D', 'N', 'N', 721, null, null, GETDATE(), null, 0, getdate(), getdate(), 'EDS' ) 
	 End
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_pce_fact_achat_dem')
	 Begin
	   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_pce_fact_achat_dem'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_pce_fact_achat_dem', 'Date facture achat SBE demandée', '-1', 'N', 'D', 'N', 'N', 721, null, null, GETDATE(), null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
	 End
  End
  
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'pce_fact_achat_adem')
	 Begin
	   Update sysadm.w_div_sin Set val_car = 'N', maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @adcIdSin And nom_zone = 'pce_fact_achat_adem'
	 End 
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'pce_fact_achat_adem')
	 Begin
	   Update sysadm.div_sin Set val_car = 'N', maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @adcIdSin And nom_zone = 'pce_fact_achat_adem'
	 End 
  End

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT
	END
	ELSE
	BEGIN
		Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT
	END
Go
	

grant execute on sysadm.PS_U_COUR_DEM_PCE_SFR_SBE_FACT_ACHAT_KSL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_ATLAS_PIECE_GEOLOCALISATION
-- Auteur               :       JFF
-- Date                 :       21/07/2014
-- Libelle              :       
-- Commentaires         :       [DT150] 
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_ATLAS_PIECE_GEOLOCALISATION' AND type = 'P' )
        DROP procedure sysadm.PS_S_ATLAS_PIECE_GEOLOCALISATION
GO

CREATE procedure sysadm.PS_S_ATLAS_PIECE_GEOLOCALISATION
        @adcIdSin     Decimal (  10,0 ), -- [PI062]
        @asRetour	  VarChar ( 30 ) OUTPUT
As

Set @asRetour = 'CAC_GEOLOC_A_NE_PAS_PRESENTER'

If Exists ( 
	Select  Top 1 1
	From	sysadm.commande c
	Where   c.id_sin = @adcIdSin
	And		c.cod_etat <> 'ANN'
	And     sysadm.FN_CLE_VAL ( 'GEOLOC', rtrim( c.info_frn_spb_cplt ), ';' ) = 'A_SUPP'
	And		c.dte_rcp_frn is not null )
	
	Begin 
		Set @asRetour = 'CAC_GEOLOC_A_PRESENTER'
	End 
	
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_ATLAS_PIECE_GEOLOCALISATION
-- Auteur               :       JFF
-- Date                 :       21/07/2014
-- Libelle              :       
-- Commentaires         :       [DT150] 
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_ATLAS_PIECE_GEOLOCALISATION' AND type = 'P' )
        DROP procedure sysadm.PS_U_ATLAS_PIECE_GEOLOCALISATION
GO

CREATE procedure sysadm.PS_U_ATLAS_PIECE_GEOLOCALISATION
        @adcIdSin     Decimal (  10,0 ) -- [PI062]
As

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )

Update	sysadm.commande
Set		cmd_gen_le = null, 
		cmd_gen_par = null, 
		id_lot_cmd = 0, 
		status_gc = 306,
		info_frn_spb_cplt = sysadm.FN_CLE_VAL_E ( 'GEOLOC', 'SUPP', rtrim ( c.info_frn_spb_cplt), ';')
From	sysadm.commande c
Where   c.id_sin = @adcIdSin
And		c.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'GEOLOC', rtrim( c.info_frn_spb_cplt ), ';' ) = 'A_SUPP'
And		c.dte_rcp_frn is not null

Update	sysadm.w_commande
Set		status_gc = 306,
		info_frn_spb_cplt = sysadm.FN_CLE_VAL_E ( 'GEOLOC', 'SUPP', rtrim ( c.info_frn_spb_cplt), ';')
From	sysadm.w_commande c
Where   c.id_sin = @adcIdSin
And		c.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'GEOLOC', rtrim( c.info_frn_spb_cplt ), ';' ) = 'A_SUPP'
And		c.dte_rcp_frn is not null

-- dte_cour_rest_pret_HV
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_degeoloc_par_ass')
	 Begin
	   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EW' Where id_sin = @adcIdSin And nom_zone = 'dte_degeoloc_par_ass'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_degeoloc_par_ass', 'Date de dé-géoloc par l''assuré', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, 0, getdate(), getdate(), 'EW' ) 
	 End
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_degeoloc_par_ass')
	 Begin
	   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EW' Where id_sin = @adcIdSin And nom_zone = 'dte_degeoloc_par_ass'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_degeoloc_par_ass', 'Date de dé-géoloc par l''assuré', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, getdate(), getdate(), 'EW', getdate(), 'EW' ) 
	 End
  End


Set @sMess = 'L''assuré a confirmé via ATLAS qu''il a bien dé-géolocalisé son appareil, un flux est parti vers le fournisseur pour l''en avertir.'

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'EW', 300, @iIdCt OUTPUT
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'EW', 300, @iIdCt OUTPUT
END


Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_REINIT_PRESTA_ELD
-- Auteur               :       JFF
-- Date                 :       21/07/2014
-- Libelle              :       
-- Commentaires         :       [PC13321] 
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @iIdSeq         Integer                 (Val)
--
-- Retourne             :       Rien
--
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_REINIT_PRESTA_ELD' AND type = 'P' )
        DROP procedure sysadm.PS_U_REINIT_PRESTA_ELD
GO


CREATE procedure sysadm.PS_U_REINIT_PRESTA_ELD
        @adcIdSin     Decimal (  10,0 ), -- [PI062]
        @aiIdSeq      Integer
As

SET NOCOUNT ON

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )


If Not Exists ( 
	Select Top 1 1
	From	sysadm.commande c
	Where   c.id_sin = @adcIdSin
	And		c.id_seq = @aiIdSeq
	And		c.id_four = 'ELD'
	And     c.status_gc = 401
	And		c.cod_etat <> 'ANN'
	And     sysadm.FN_CLE_VAL ( 'DTE_BGE', c.info_spb_frn_cplt, ';' ) <> '' 
  )
 Begin
	Return -1
 End 
	
Update	sysadm.commande
Set	    info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'DTE_BGE', '', RTRIM( c.info_spb_frn_cplt ), ';'),
		comment_frn = RTRIM ( comment_frn ) + '.' + sysadm.FN_AFF_DATE ( GETDATE(), 'SH') + '=>Réinit envoi BGE par EDS'
From	sysadm.commande c 
Where  	c.id_sin = @adcIdSin
And		c.id_seq = @aiIdSeq

Update	sysadm.w_commande
Set	    info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'DTE_BGE', '', RTRIM( c.info_spb_frn_cplt ), ';'),
		comment_frn = RTRIM ( comment_frn ) + '.' + sysadm.FN_AFF_DATE ( GETDATE(), 'SH') + '=>Réinit envoi BGE par EDS'
From	sysadm.w_commande c 
Where  	c.id_sin = @adcIdSin
And		c.id_seq = @aiIdSeq

Set @sMess = 'Suite problème d''envoie du bon d''échange ElectroDépot par KSL, l''équipe EDS réinitialise la presta ELD ' + 
			 CONVERT ( VarChar ( 20 ), @adcIdSin ) + '-' + CONVERT ( VarChar ( 20 ), @aiIdSeq ) + ', le ' + sysadm.FN_AFF_DATE ( GETDATE(), 'AVEC_HEURE' ) + ' pour un nouvel envoi du BGE.'

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess, 'EDS', 300, @iIdCt OUTPUT
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess, 'EDS', 300, @iIdCt OUTPUT
END

Return 0

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_LECTURE_LOT_CMD
-- Auteur               :       JFF
-- Date                 :       08/01/2016
-- Libelle              :       
-- Commentaires         :        
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_LECTURE_LOT_CMD' AND type = 'P' )
        DROP procedure sysadm.PS_S_LECTURE_LOT_CMD
GO

CREATE procedure sysadm.PS_S_LECTURE_LOT_CMD
        @adcIdSin     Decimal (  10,0 ), -- [PI062]
		@aiIdSeq		  Integer,
		@aiIdLotCmd    Integer OUTPUT
As

Select @aiIdLotCmd = c.id_lot_cmd
From   sysadm.commande c
Where  c.id_sin = @adcIdSin
And    c.id_seq = @aiIdSeq

If @aiIdLotCmd is null Set @aiIdLotCmd = 0

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_I_PEC_A_RECYCLER_PM330
-- Auteur               :       JFF
-- Date                 :       08/01/2016
-- Libelle              :       
-- Commentaires         :        
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF   13/04/2016  [PM330-1][MANTIS20367]
-- JFF   08/07/2016  [VDOC21260]
-- JFF   21/02/2107  [DT288]
-- JFF   19/09/2018  [DT361]
-- JFF   21/10/2019  [VDOC28556] Hélène
-- JFF   29/10/2019  J'ajoute SBE, si problème on l'enlèvera
-- JFF   07/03/2024  [HP252_276_HUB_PRESTA]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PEC_A_RECYCLER_PM330' AND type = 'P' )
        DROP procedure sysadm.PS_I_PEC_A_RECYCLER_PM330
GO

CREATE procedure sysadm.PS_I_PEC_A_RECYCLER_PM330
        @adcIdSin     Decimal (  10,0 )
As

Declare @iEligible Integer
Declare @dcNewIdDetail Decimal ( 7,0 )
Declare @dcIdGti	Decimal ( 7,0 )
Declare @dcIdDetail Decimal ( 7,0 )
Declare @iNewIdSeq Integer
Declare @iIdSeq Integer
Declare @sProbleme Varchar ( 255 )
Declare @iIdSeqRAR Integer
Declare @sQualifcationIrrep VarChar ( 10 ) -- [VDOC28556] Hélène
Declare @sCasRetour VarChar ( 50 )
Declare @iIdSeqHubPrestaOrig Integer

Set @sProbleme = ''
Set @iEligible = 0
Set @iIdSeqHubPrestaOrig = -1

-- [HP252_276_HUB_PRESTA]
If sysadm.FN_CLE_NUMERIQUE ( 'HP252_276_HUB_PRESTA') > 0 
 Begin
	Select @iIdSeqHubPrestaOrig = Max ( id_seq )
	From sysadm.commande c with ( nolock )
	Where c.id_sin = @adcIdSin
	And   c.id_ref_four in ( 'A_REPARER' ) 
	And   Len ( sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';' ) ) > 0 
	And   sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';' ) <> 'FICTIVE'
	And   c.status_gc in ( 21 )
	And	  c.cod_etat <> 'ANN'
	/*
	And   ( CharIndex ( '[BVIE]', c.comment_frn, 1 ) > 0 Or 
		    CharIndex ( '[BVIEOX]', c.comment_frn, 1 ) > 0  Or 
			CharIndex ( '[BVID]', c.comment_frn, 1 ) > 0  Or 
			CharIndex ( '[BVIP]', c.comment_frn, 1 ) > 0  Or 
			CharIndex ( '[BVIT]', c.comment_frn, 1 ) > 0  Or 
			CharIndex ( '[PIE]',  c.comment_frn, 1 ) > 0  ) 
	*/

 End 

If @iIdSeqHubPrestaOrig is null Set @iIdSeqHubPrestaOrig = -1
If @iIdSeqHubPrestaOrig = 0 Set @iIdSeqHubPrestaOrig = -1

If Not Exists ( 
		Select	Top 1 1
		From	sysadm.commande_type ct,
				sysadm.sinistre s
		Where   s.id_sin = @adcIdSin
		And		ct.id_prod = s.id_prod
		And		ct.id_code_frn in ( 'O2M', 'PSM', 'COR', 'CEA', 'SBE' ) -- [DT288]
   ) And @iIdSeqHubPrestaOrig < 0
   Begin
	Return
   End 

Select @iIdSeqRAR = c.id_seq
From   commande c
Where  c.id_sin = @adcIdSin
And    c.id_ref_four = 'PEC_A_RECYCLER'
And    c.id_seq = ( Select Max ( c1.id_seq ) 
					From   commande c1
					Where  c1.id_sin = c.id_sin
					And    c1.id_ref_four = c.id_ref_four
				    )

If @iIdSeqRAR is null Set @iIdSeqRAR = 0

If @iIdSeqRAR = ( Select Max ( c.id_seq )
					From  commande c
					Where  c.id_sin = @adcIdSin )
				And @iIdSeqHubPrestaOrig < 0 -- [HP252_276_HUB_PRESTA]
	Begin
	 Return
	End 

If @iIdSeqRAR >= ( Select Max ( c.id_seq )
					From  commande c
					Where  c.id_sin = @adcIdSin ) - 1
				 And Exists ( 
				   Select Top 1 1 
				    From   sysadm.commande c
					Where  c.id_sin = @adcIdSin
					And    c.id_ref_four = 'PEC_A_RECYCLER'
					And    sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';' ) = 'FICTIVE'
				 )
				And @iIdSeqHubPrestaOrig > 0 -- [HP252_276_HUB_PRESTA]
	Begin
		Return
	End 

-- [PM330-1][MANTIS20367]
If Exists ( 
	Select	Top 1 1
	From	sysadm.reglement r,
			sysadm.reg_gti rg, -- [PM330-1][MANTIS20367]
			sysadm.commande c1,
			sysadm.detail d
	Where   r.id_sin = @adcIdSin
	And     r.cod_inter = 'A'
	And     r.cod_mot_reg = 'RN'
	And     d.id_sin = r.id_sin
	And     d.id_reg = r.id_reg
	And     d.id_evt not in ( 1425 )
--	And		Convert ( VarChar( 10 ), r.cree_le, 103 ) = Convert ( VarChar( 10 ), GetDate(), 103 ) 
--	And		Convert ( VarChar( 10 ), r.valide_le, 103 ) = Convert ( VarChar( 10 ), GetDate(), 103 ) 
	And     rg.id_sin = r.id_sin -- [PM330-1][MANTIS20367]
	And     rg.id_reg = r.id_reg -- [PM330-1][MANTIS20367]
	And		rg.id_gti > 0 -- [PM330-1][MANTIS20367]
	And		rg.id_gti <> 8 -- [PM330-1][MANTIS20367]
	And		c1.id_sin = r.id_sin
	And		c1.id_ref_four in ( 'A_REPARER', 'A_DESOXYDER' )
	And		( c1.id_four in ( 'O2M', 'PSM', 'COR', 'CEA', 'SBE' ) Or @iIdSeqHubPrestaOrig > 0 ) -- [HP252_276_HUB_PRESTA]
	And		c1.status_gc in ( 21, 23 )
	And		c1.cod_etat <> 'ANN'
	And		Not Exists ( 
				Select	Top 1 1
				From	sysadm.commande c
				Where   c.id_sin = r.id_sin
				And		c.id_ref_four = 'PEC_A_RECYCLER'
				And     c.id_four = c1.id_four
			) 
)
  Begin
	Set @iEligible = 1
	Set @sProbleme = 'Un réglement vers l''assuré vient d''avoir lieu, vous pouvez recycler l''appareil sinistré'
  End 

If @iEligible = 0 And 
   	Exists ( 
	Select	Top 1 1
	From	sysadm.commande cmde,
			sysadm.commande c1
	Where   cmde.id_sin = @adcIdSin
	And		cmde.cod_etat <> 'ANN'
	And		cmde.status_gc <> 176
	And		sysadm.FN_A_COMMANDER ( cmde.id_sin, cmde.id_seq, 'P' ) = 'A_COMMANDER'
--	And		Convert ( VarChar( 10 ), cmde.cree_le, 103 ) = Convert ( VarChar( 10 ), GetDate(), 103 )  [VDOC21260]
--	And		Convert ( VarChar( 10 ), cmde.valide_le, 103 ) = Convert ( VarChar( 10 ), GetDate(), 103 )  -- [VDOC21260]
	And		c1.id_sin = cmde.id_sin
	And		c1.id_ref_four in ( 'A_REPARER', 'A_DESOXYDER' )
	And		( c1.id_four in ( 'O2M', 'PSM', 'COR', 'CEA', 'SBE' ) Or @iIdSeqHubPrestaOrig > 0 ) -- [HP252_276_HUB_PRESTA] -- [DT288]
	And		c1.status_gc in ( 21, 23 )
	And		c1.cod_etat <> 'ANN'
	And		Not Exists ( 
				Select	Top 1 1
				From	sysadm.commande c
				Where   c.id_sin = cmde.id_sin
				And		c.id_ref_four = 'PEC_A_RECYCLER'
				And     c.id_four = c1.id_four
			) 
)
  Begin
	Set @iEligible = 2
	Set @sProbleme = 'Une demande de remplacement (pour l''assuré) auprès du fournisseur vient d''avoir lieu, vous pouvez recycler l''appareil sinistré'
  End 		

  If @iEligible = 0 Return

If Exists ( Select Top 1 1 From sysadm.w_commande Where id_sin = @adcIdSin ) 
  Begin		
		Select	Top 1 @dcIdGti = c1.id_gti,
					  @dcIdDetail = c1.id_detail,
					  @iIdSeq = c1.id_seq,
					  @sQualifcationIrrep = Case -- [VDOC28556] Hélène
												When CharIndex ( '[BVIE]', c1.comment_frn, 1 ) > 0  Then '[BVIE]'
												When CharIndex ( '[BVIEOX]', c1.comment_frn, 1 ) > 0  Then '[BVIEOX]'
												When CharIndex ( '[BVID]', c1.comment_frn, 1 ) > 0  Then '[BVID]'
												When CharIndex ( '[BVIP]', c1.comment_frn, 1 ) > 0  Then '[BVIP]'
												When CharIndex ( '[BVIT]', c1.comment_frn, 1 ) > 0  Then '[BVIT]'
												When CharIndex ( '[PIE]',  c1.comment_frn, 1 ) > 0  Then '[PIE]'
												Else ''
											End 
		From	sysadm.w_commande c1
		Where   c1.id_sin = @adcIdSin
		And		( 
					(			c1.id_ref_four in ( 'A_REPARER', 'A_DESOXYDER' )
						And		c1.status_gc in ( 21, 23 )
						And		c1.cree_le < GetDate()
						And		c1.cod_etat <> 'ANN'
						And     @iIdSeqHubPrestaOrig < 0 
						And     c1.id_seq = ( Select Max ( c2.id_seq) 
												From   sysadm.commande c2
												Where  c2.id_sin = c1.id_sin
												And    c2.id_ref_four in ( 'A_REPARER', 'A_DESOXYDER' )
												And    c2.status_gc in ( 21, 23 )
												And    c2.cree_le < GetDate()
												And	 c2.cod_etat <> 'ANN' )
					)
					Or 
					c1.id_seq = @iIdSeqHubPrestaOrig
				)
				
  End 
Else
  Begin
	Select	Top 1 @dcIdGti = c1.id_gti,
				  @dcIdDetail = c1.id_detail,
				  @iIdSeq = c1.id_seq,
				  @sQualifcationIrrep = Case -- [VDOC28556] Hélène
											When CharIndex ( '[BVIE]', c1.comment_frn, 1 ) > 0  Then '[BVIE]'
											When CharIndex ( '[BVIEOX]', c1.comment_frn, 1 ) > 0  Then '[BVIEOX]'
											When CharIndex ( '[BVID]', c1.comment_frn, 1 ) > 0  Then '[BVID]'
											When CharIndex ( '[BVIP]', c1.comment_frn, 1 ) > 0  Then '[BVIP]'
											When CharIndex ( '[BVIT]', c1.comment_frn, 1 ) > 0  Then '[BVIT]'
											When CharIndex ( '[PIE]',  c1.comment_frn, 1 ) > 0  Then '[PIE]'
											Else ''
										End 
	From	sysadm.commande c1
	Where   c1.id_sin = @adcIdSin
	And		( 
				(			c1.id_ref_four in ( 'A_REPARER', 'A_DESOXYDER' )
					And		c1.status_gc in ( 21, 23 )
					And		c1.cree_le < GetDate()
					And		c1.cod_etat <> 'ANN'
					And     @iIdSeqHubPrestaOrig < 0 
					And     c1.id_seq = ( Select Max ( c2.id_seq) 
											From   sysadm.commande c2
											Where  c2.id_sin = c1.id_sin
											And    c2.id_ref_four in ( 'A_REPARER', 'A_DESOXYDER' )
											And    c2.status_gc in ( 21, 23 )
											And    c2.cree_le < GetDate()
											And	 c2.cod_etat <> 'ANN' )
				)
				Or 
				c1.id_seq = @iIdSeqHubPrestaOrig
			)
  End 

Select	@dcNewIdDetail = max ( id_detail ) 
From	sysadm.detail
where   id_sin = @adcIdSin
and     id_gti = @dcIdGti 

If @dcNewIdDetail is null Set @dcNewIdDetail = 0
Set @dcNewIdDetail = @dcNewIdDetail + 1

Insert into sysadm.detail 
Select id_sin,   id_gti,   @dcNewIdDetail,   1083,   id_reg=null,   id_i_reg=null,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej=0,   mt_fran=0,   mt_nplaf=0,   mt_plaf=0,   alt_plaf='N',   alt_reg= 'N',   'O',   alt_ssui='O',   cod_mot_ssui=12,   cod_dec_mac=900,   cod_dec_ope=900,   cod_etat=900,   id_carte,   id_type_carte,   getdate(),   'AUTO',   getdate(),   getdate(),   'AUTO',   dte_cmd=null,   dte_livr=null,   mt_val_achat,   mt_val_publique,   num_facture=null
From sysadm.detail d
Where d.id_sin = @adcIdSin
And   d.id_gti = @dcIdGti
And   d.id_detail = @dcIdDetail

If Exists ( Select * from w_detail where id_sin = @adcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
	Begin
	Insert into sysadm.w_detail 
	Select id_sin,   id_gti,   @dcNewIdDetail,   1083,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej=0,   mt_fran=0,   mt_nplaf=0,   mt_plaf=0,   null, 'N', 'N', alt_plaf='N',   alt_reg='N',   'O', alt_valide,  1,  alt_ssui='O',   cod_mot_ssui=12,   cod_dec_mac=900,   cod_dec_ope=900,   cod_etat=900,   id_carte,   id_type_carte, getdate(),   getdate(),   'AUTO',   dte_cmd=null,   dte_livr=null,   mt_val_achat,   mt_val_publique,   num_facture=null
	From sysadm.w_detail d
	Where d.id_sin = @adcIdSin
	And   d.id_gti = @dcIdGti
	And   d.id_detail = @dcIdDetail
	End 

Insert into sysadm.div_det 
Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, getdate(), getdate(),  'AUTO', getdate(), 'AUTO'
From sysadm.div_det d
Where d.id_sin = @adcIdSin
And   d.id_gti = @dcIdGti
And   d.id_detail = @dcIdDetail

If Exists ( Select * from w_div_det where id_sin = @adcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
	Begin
	Insert into sysadm.w_div_det 
	Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, 1, getdate(),   getdate(), 'AUTO'
	From sysadm.w_div_det d
	Where d.id_sin = @adcIdSin
	And   d.id_gti = @dcIdGti
	And   d.id_detail = @dcIdDetail			  
	End 
	  
Select @iNewIdSeq = max ( id_seq ) From sysadm.commande where id_sin = @adcIdSin 


If @iNewIdSeq is null Set @iNewIdSeq = 0
Set @iNewIdSeq = @iNewIdSeq + 1
				
Insert into sysadm.commande
select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, id_four, id_typ_art= 'EDI', 'PRISE EN CHARGE A RECYCLER', '', mt_ttc_cmde=0, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, @sProbleme, null,  null, null, null, null, 'RFO', null, 'PRESTA AUTOMATIQUE', 0, null, null, Getdate(), Getdate(), 'AUTO',  Getdate(),  'AUTO', id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'PEC_A_RECYCLER', id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, null, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli=null, 0, 'PRISE EN CHARGE A RECYCLER', id_modl_art_ifr, 
			IIF ( @iIdSeqHubPrestaOrig > 0, 
					( sysadm.FN_CLE_VAL_E ( 'HP_ID_FOUR', c.id_four, 
						sysadm.FN_CLE_VAL_E ( 'HP_IDENTITY', '', 
							sysadm.FN_CLE_VAL_E ( 'HP_ID_HUB_PRESTA', sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';') , '', ';' ) 
						, ';' ),
					  ';' )
				     ), null ),
		   null
From commande c
Where c.id_sin = @adcIdSin
And   c.id_seq = @iIdSeq

If Exists ( Select * from sysadm.w_commande where id_sin = @adcIdSin and id_seq = @iIdSeq )
	Begin
		Insert into sysadm.w_commande
		select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, id_four, id_typ_art= 'EDI', 'PRISE EN CHARGE A RECYCLER', '', mt_ttc_cmde=0, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, @sProbleme, null,  null, null, null, null, 'RFO', null, 1, 'PRESTA AUTOMATIQUE', Getdate(), Getdate(), 'AUTO',  id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'PEC_A_RECYCLER'   , id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, null, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli=null, 0, 'PRISE EN CHARGE A RECYCLER', id_modl_art_ifr,
				IIF ( @iIdSeqHubPrestaOrig > 0, 
						( sysadm.FN_CLE_VAL_E ( 'HP_ID_FOUR', c.id_four, 
							sysadm.FN_CLE_VAL_E ( 'HP_IDENTITY', '', 
								sysadm.FN_CLE_VAL_E ( 'HP_ID_HUB_PRESTA', sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';') , '', ';' ) 
							, ';' ),
						  ';' )
						 ), null ),
			   null
		From w_commande c
		Where c.id_sin = @adcIdSin
		And   c.id_seq = @iIdSeq
	End 				


	-- [HP252_276_HUB_PRESTA]
If sysadm.FN_CLE_NUMERIQUE ( 'HP252_276_HUB_PRESTA') > 0 
 Begin
	If @iIdSeqHubPrestaOrig > 0 
		Begin
			Insert into sysadm.en_attente_transfert_vers_hp ( id_cas, id_sin, id_seq, id_hub_presta, id_four, typ_dommage, point_service, mode_logis, code_pickup, nom_pickup, ref_ass_pickup, adr1_pickup, adr2_pickup, adr3_pickup, adr_cp_pickup, adr_ville_pickup, code_process, lib_code_process, id_gti, lib_perso_gti, id_detail, id_prod, lib_prod, id_prod_adh, id_ets, id_adh, id_sdos, id_typ_art, cod_civ_livr, lib_civ_livr_court, lib_civ_livr_long, id_contrat_abonne, nom_ass, prenom_ass, nom_livr, prenom_livr, adr1_livr, adr2_livr, adr3_livr, adr_cp_livr, adr_ville_livr, num_tel1_ass, num_tel2_ass, num_tel3_ass, mail_assure, num_imei_app_sin, num_serie_app_sin, description_probleme, cod_etat, valide_le, valide_par, cmd_gen_le, id_ref_four, ordre_action, id_assureur, lib_assureur, lib_police, typ_app_sin, lib_typ_app_sin, marq_app_sin, modl_app_sin, ref_app_sin, num_tel_sin, mt_val_achat, mt_prise_en_charge, date_achat, etat_app_sin, code_verrou, desimlocke, info_spb_frn_cplt )
			exec sysadm.PS_HP276_S_S2_OBTENTION_DONNEES_PRESTA_SIMPA2_POUR_PREPARATION_CREATION_HUB_PRESTATAIRE 2, @adcIdSin, @iNewIdSeq
		End 
 End 


-- [VDOC28556] Hélène
	 /*
	 Merci de bien vouloir créer un nouveau pushmail à envoyer : 
	- sur les pdts AIG 
	- suite à un retour sur une presta de réparation du type BVIE BVIT BVID ou BVIP suivi d'une presta 'pec à recycler" 
	- avec le contenu suivant : Nous faisons suite à votre déclaration de sinistre du <date de déclaration du sinistre>. 
	  Après diagnostic, nous vous informons que votre appareil <Marque-Modèle-Capacité-Couleur> est <techniquement ou économiquement> irréparable. 
	- mettre "économiquement" en cas de retour BVIE et "techniquement" dans les autres cas. 
	*/

	-- Condition pour l'instant en dur, on verra si par la suite on doit le mettre sur d'autres assureur.
	If ( 
		Select  top 1 po.id_cie
		From	sysadm.sinistre s,
				sysadm.garantie g,
				sysadm.commande c,
				sysadm.police po
		Where   s.id_sin = @adcIdSin
		And     c.id_sin = s.id_sin
		And     c.id_seq = @iIdSeq
		And     g.id_prod = s.id_prod
		And     g.id_rev  = s.id_rev
		And     g.id_gti  = c.id_gti
		And     po.id_police = g.id_police
	) In ( 6, 75, 76, 130 )
		Begin
			Exec sysadm.PS_I_MAILPUSH_VDOC28556_BVI @adcIdSin, @sQualifcationIrrep, @sCasRetour OUTPUT
		End 
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_REFUSE_A_REEXP_PM330
-- Auteur               :       JFF
-- Date                 :       08/01/2016
-- Libelle              :       [PM330-1]
-- Commentaires         :        
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      29/02/2016   [DT191-1]
-- JFF      26/05/2016   [VDOC20908]    
-- JFF      21/02/2107   [DT288]
-- JFF      15/05/2107   [VDOC23763]
-- JFF      18/09/2017   [DT288-3_LOT2]
-- JFF      17/04/2018   [DT288-4]
-- JFF	    09/08/2018   [ITSM551169]
-- JFF	    09/08/2018   [ITSM551169]
-- JFF		19/09/2018	 [DT361]
-- JFF      07/03/2024   [HP252_276_HUB_PRESTA]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_REFUSE_A_REEXP_PM330' AND type = 'P' )
        DROP procedure sysadm.PS_I_REFUSE_A_REEXP_PM330
GO

CREATE procedure sysadm.PS_I_REFUSE_A_REEXP_PM330
        @adcIdSin     Decimal (  10 )
As

Declare @iEligible Integer
Declare @dcNewIdDetail Decimal ( 7,0 )
Declare @dcIdGti	Decimal ( 7,0 )
Declare @dcIdDetail Decimal ( 7,0 )
Declare @iNewIdSeq Integer
Declare @iIdSeq Integer
Declare @sProbleme Varchar ( 255 )
Declare @sCodePickUp VarChar ( 50 )
Declare @sQRelPickUpRet VarChar ( 50 )
Declare @sMailAssure VarChar ( 100 )
Declare @sInfoSpbFrnCplt VarChar ( 255 )
Declare @iIdProcess Integer
Declare @sAdrCodCiv VarChar ( 35 )
Declare @sAdrNom	 VarChar ( 35 )
Declare @sAdrPrenom VarChar ( 35 )
Declare @sAdrLivr1 VarChar ( 35 )
Declare @sAdrLivr2 VarChar ( 35 )
Declare @sAdrLivrCpl VarChar ( 35 )
Declare @sAdrCp	 VarChar ( 35 )
Declare @sAdrVille VarChar ( 35 )
Declare @asCasRetour    VarChar ( 50 )
Declare @sDbName  	VarChar ( 20 )
Declare @sCodEtat VarChar ( 10 )
Declare @iIdSeqRAR Integer
Declare @sIdFour VarChar ( 3 )
Declare @sMess	VarChar ( 2000 )
Declare @iIdCt	integer		
Declare @iIdSeqHubPrestaOrig Integer
Declare @sEtatPresta VarChar ( 10 )

Set @sProbleme = ''
Set @iEligible = 0
Set @iIdProcess = 990
Set @iIdSeqHubPrestaOrig = -1

-- [HP252_276_HUB_PRESTA]
If sysadm.FN_CLE_NUMERIQUE ( 'HP252_276_HUB_PRESTA') > 0 
 Begin
	Select @iIdSeqHubPrestaOrig = Max ( id_seq )
	From sysadm.commande c with ( nolock )
	Where c.id_sin = @adcIdSin
	And   c.id_ref_four in ( 'A_REPARER' ) 
	And   Len ( sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';' ) ) > 0 
	And   sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';' ) <> 'FICTIVE'
	And   c.status_gc in ( 21 )
	And	  c.cod_etat <> 'ANN'
	/*
	And   Not Exists ( 
			Select Top 1 1
			From sysadm.commande c1
			Where c1.id_sin = c.id_sin
			And    c.id_ref_four = 'REFUSE_A_REEXP'
			And    c.id_seq = ( Select Max ( c2.id_seq ) 
								From   commande c2
								Where  c2.id_sin = c1.id_sin
								And    c2.id_ref_four = c.id_ref_four
								)
		  )
	*/

	If @iIdSeqHubPrestaOrig is null Set @iIdSeqHubPrestaOrig = -1
 End 
 
If @iIdSeqHubPrestaOrig is null Set @iIdSeqHubPrestaOrig = -1
If @iIdSeqHubPrestaOrig = 0 Set @iIdSeqHubPrestaOrig = -1

If Not Exists ( 
		Select	Top 1 1
		From	sysadm.commande_type ct,
				sysadm.sinistre s
		Where   s.id_sin = @adcIdSin
		And		ct.id_prod = s.id_prod
		And		ct.id_code_frn in ( 'O2M', 'PSM', 'COR', 'CEA', 'SBE' ) -- [DT288]
   ) And @iIdSeqHubPrestaOrig < 0
   Begin
	Return
   End 

Select @iIdSeqRAR = c.id_seq
From   sysadm.commande c
Where  c.id_sin = @adcIdSin
And    c.id_ref_four = 'REFUSE_A_REEXP'
And    c.id_seq = ( Select Max ( c1.id_seq ) 
					From   commande c1
					Where  c1.id_sin = c.id_sin
					And    c1.id_ref_four = c.id_ref_four
				    )

If @iIdSeqRAR is null Set @iIdSeqRAR = 0

If @iIdSeqRAR = ( Select Max ( c.id_seq )
					From  commande c
					Where  c.id_sin = @adcIdSin )
				And @iIdSeqHubPrestaOrig < 0 -- [HP252_276_HUB_PRESTA]
	Begin
		Return
	End 

If @iIdSeqRAR >= ( Select Max ( c.id_seq )
					From  commande c
					Where  c.id_sin = @adcIdSin ) - 1
				 And Exists ( 
				   Select Top 1 1 
				    From   sysadm.commande c
					Where  c.id_sin = @adcIdSin
					And    c.id_ref_four = 'REFUSE_A_REEXP'
					And    sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';' ) = 'FICTIVE'
				 )
				And @iIdSeqHubPrestaOrig > 0 -- [HP252_276_HUB_PRESTA]
	Begin
		Return
	End 


If Exists ( 
	Select	Top 1 1
	From	sysadm.gar_sin g,
			sysadm.commande c1,
			sysadm.refus r
	Where   c1.id_sin = @adcIdSin
	And		c1.id_ref_four in ( 'A_REPARER', 'A_DESOXYDER' )
	And		( c1.id_four in ( 'O2M', 'PSM', 'COR', 'CEA' ) Or @iIdSeqHubPrestaOrig > 0 ) -- [HP252_276_HUB_PRESTA]-- [DT288]
	And		( c1.status_gc in ( 21, 23 ) or ( c1.status_gc = 169 and c1.id_four = 'COR' )) -- [DT288-3_LOT2]
	And		c1.cod_etat <> 'ANN'
	And		g.id_sin = c1.id_sin
	And     g.id_gti = c1.id_gti
	And		g.cod_etat = 200
	And		r.id_sin = g.id_sin -- VDOC21660
	And     r.id_gti = g.id_gti -- VDOC21660
	And		r.id_motif not in ( 661, 603 ) -- VDOC21660
)
	Begin
		Set @iEligible = 1
		Set @sProbleme = 'La garantie est refusée, vous pouvez renvoyer l''appareil sinistré à l''assuré'
	End 

-- Autre cas de contrôle
If Exists ( 
	Select	Top 1 1
	From	sysadm.commande c1
	Where   c1.id_sin = @adcIdSin
	And		( c1.id_ref_four = 'PEC_A_RECYCLER'
			  Or 
			  sysadm.FN_A_COMMANDER ( c1.id_sin, c1.id_seq, 'P' ) = 'A_COMMANDER'
			)
	And		c1.cod_etat <> 'ANN'
  )
  Begin
	Set @iEligible = 0
  End 

-- Vu avec Hélène par Tel le 13/04/2016 : Si amu forçage de PEC, on n'envoie par le refuse_a_reexp
-- Et ([vDoc23763] 12/05/17) : ...ET il ne faut pas qu'il existe un refus opérateur.
If (
		Exists ( 
			Select	Top 1 1
			From	sysadm.div_det dd
			Where   dd.id_sin = @adcIdSin
			And		dd.nom_zone = 'alt_pec'
			And		dd.val_car = 'O'
	    )
	    Or
	    Exists (
			Select	Top 1 1
			From	sysadm.detail d
			Where   d.id_sin = @adcIdSin
			And		d.alt_reg = 'O'
	    )
	)
	And Not Exists ( 
		Select Top 1 1 
		From sysadm.refus r
		Where r.id_sin = @adcIdSin
		And   r.alt_ope = 'O'
	)
  Begin
	Set @iEligible = 0
  End 

If @iEligible = 0 Return
  
Select	Top 1 @dcIdGti = c1.id_gti,
			  @dcIdDetail = c1.id_detail,
			  @iIdSeq = c1.id_seq,
			  @sIdFour = c1.id_four,
			  @sCodePickUp = sysadm.FN_CLE_VAL ( 'CODE_PICK_UP', c1.info_spb_frn_cplt, ';'), -- [DT191-1]
			  @sQRelPickUpRet = sysadm.FN_CLE_VAL ( 'RET_REL_PICK_UP', c1.info_spb_frn_cplt, ';'), -- [DT191-1]
			  @sMailAssure = sysadm.FN_CLE_VAL ( 'MAIL_ASSURE', c1.info_spb_frn_cplt, ';'), -- [DT191-1]
			  @sAdrCodCiv = c1.adr_cod_civ,
			  @sAdrNom = c1.adr_nom,
			  @sAdrPrenom = c1.adr_prenom,
			  @sAdrLivr1 = c1.adr_livr1,
			  @sAdrLivr2 = c1.adr_livr2,
			  @sAdrLivrCpl = c1.adr_livr_cpl,
			  @sAdrCp = c1.adr_cp,
			  @sAdrVille = c1.adr_ville,
			  @sCodEtat = c1.cod_etat
From	sysadm.commande c1
Where   c1.id_sin = @adcIdSin
And     ( 
			(
				c1.id_ref_four in ( 'A_REPARER', 'A_DESOXYDER' )
				And		c1.id_four in ( 'O2M', 'PSM', 'COR', 'CEA' )  -- [HP252_276_HUB_PRESTA]-- [DT288]
				And		( c1.status_gc in ( 21, 23 ) or ( c1.status_gc = 169 and c1.id_four = 'COR' )) -- [DT288-3_LOT2]
				And		c1.cree_le < GetDate()
				And		c1.cod_etat <> 'ANN'
				And     @iIdSeqHubPrestaOrig < 0
			)
			Or 
			c1.id_seq = @iIdSeqHubPrestaOrig
		)

If @iIdSeqHubPrestaOrig > 0 Set @sQRelPickUpRet = 'NON'

Select	@dcNewIdDetail = max ( id_detail ) 
From	sysadm.detail
where   id_sin = @adcIdSin
and     id_gti = @dcIdGti 

If @dcNewIdDetail is null Set @dcNewIdDetail = 0
Set @dcNewIdDetail = @dcNewIdDetail + 1

Insert into sysadm.detail 
Select id_sin,   id_gti,   @dcNewIdDetail,   1083,   id_reg=null,   id_i_reg=null,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej=0,   mt_fran=0,   mt_nplaf=0,   mt_plaf=0,   alt_plaf='N',   alt_reg= 'N',   alt_att= 'N',   alt_ssui='O',   cod_mot_ssui=12,   cod_dec_mac=900,   cod_dec_ope=900,   cod_etat=900,   id_carte,   id_type_carte,   getdate(),   'AUTO',   getdate(),   getdate(),   'AUTO',   dte_cmd=null,   dte_livr=null,   mt_val_achat,   mt_val_publique,   num_facture=null
From sysadm.detail d
Where d.id_sin = @adcIdSin
And   d.id_gti = @dcIdGti
And   d.id_detail = @dcIdDetail

If Exists ( Select * from w_detail where id_sin = @adcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
	Begin
	Insert into sysadm.w_detail 
	Select id_sin,   id_gti,   @dcNewIdDetail,   1083,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej=0,   mt_fran=0,   mt_nplaf=0,   mt_plaf=0,   null, 'N', 'N', alt_plaf='N',   alt_reg='N',   alt_att= 'N', alt_valide,  1,  alt_ssui='O',   cod_mot_ssui=12,   cod_dec_mac=900,   cod_dec_ope=900,   cod_etat=900,   id_carte,   id_type_carte, getdate(),   getdate(),   'AUTO',   dte_cmd=null,   dte_livr=null,   mt_val_achat,   mt_val_publique,   num_facture=null
	From sysadm.w_detail d
	Where d.id_sin = @adcIdSin
	And   d.id_gti = @dcIdGti
	And   d.id_detail = @dcIdDetail
	End 

Insert into sysadm.div_det 
Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, getdate(), getdate(),  'AUTO', getdate(), 'AUTO'
From sysadm.div_det d
Where d.id_sin = @adcIdSin
And   d.id_gti = @dcIdGti
And   d.id_detail = @dcIdDetail

If Exists ( Select * from w_div_det where id_sin = @adcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
	Begin
	Insert into sysadm.w_div_det 
	Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, 1, getdate(),   getdate(), 'AUTO'
	From sysadm.w_div_det d
	Where d.id_sin = @adcIdSin
	And   d.id_gti = @dcIdGti
	And   d.id_detail = @dcIdDetail			  
	End 
	  
Select @iNewIdSeq = max ( id_seq ) From commande where id_sin = @adcIdSin

If @iNewIdSeq is null Set @iNewIdSeq = 0
Set @iNewIdSeq = @iNewIdSeq + 1

-- [DT191-1]
If @sQRelPickUpRet = 'OUI' And Len ( @sCodePickUp ) > 0 And @sIdFour <> 'COR'
 Begin
	Set @sInfoSpbFrnCplt = 'CODE_PICK_UP=' + rtrim ( @sCodePickUp ) + ';RET_REL_PICK_UP=OUI;MAIL_ASSURE=' + rtrim ( @sMailAssure ) 
	Set @iIdProcess = 983
 End 
 -- [DT191-1]
  	
Set @sEtatPresta = 'ECT'	
If 	@iIdSeqHubPrestaOrig > 0 Set @sEtatPresta = 'RFO'	

Insert into commande
select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, id_four, id_typ_art= 'EDI', 'REFUSE A REEXPEDIER', '', mt_ttc_cmde=0, 
			adr_nom=@sAdrNom, 
			adr_prenom=@sAdrPrenom, 
			adr_livr1=@sAdrLivr1, 
			adr_livr2=@sAdrLivr2, 
			adr_livr_cpl=@sAdrLivrCpl, 
			adr_cp=@sAdrCp, 
			adr_ville=@sAdrVille, 
			adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, @sProbleme, null,  null, null, null, null, @sEtatPresta, null, 'PRESTA AUTOMATIQUE', 0, null, null, Getdate(), Getdate(), 'AUTO',  Getdate(),  'AUTO', id_zone, id_bsp, dte_ret_pret, adr_cod_civ=@sAdrCodCiv, 'REFUSE_A_REEXP', id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, null, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli=null, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, @iIdProcess, 'REFUSE A REEXPEDIER', id_modl_art_ifr,
			IIF ( @iIdSeqHubPrestaOrig > 0, 
					( sysadm.FN_CLE_VAL_E ( 'HP_ID_FOUR', c.id_four, 
						sysadm.FN_CLE_VAL_E ( 'HP_IDENTITY', '', 
							sysadm.FN_CLE_VAL_E ( 'HP_ID_HUB_PRESTA', sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';') , @sInfoSpbFrnCplt, ';' ) 
						, ';' ),
					  ';' )
				     ), @sInfoSpbFrnCplt ),	  -- [HP252_276_HUB_PRESTA] 
			null
From commande c
Where c.id_sin = @adcIdSin
And   c.id_seq = @iIdSeq

If Exists ( Select * from w_commande where id_sin = @adcIdSin and id_seq = @iIdSeq )
	Begin
		Insert into w_commande
		select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, id_four, id_typ_art= 'EDI', 'REFUSE A REEXPEDIER', '', mt_ttc_cmde=0, 
				adr_nom=@sAdrNom, 
				adr_prenom=@sAdrPrenom, 
				adr_livr1=@sAdrLivr1, 
				adr_livr2=@sAdrLivr2, 
				adr_livr_cpl=@sAdrLivrCpl, 
				adr_cp=@sAdrCp, 
				adr_ville=@sAdrVille, 
				adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, @sProbleme, null,  null, null, null, null, @sEtatPresta, null, 1, 'PRESTA AUTOMATIQUE', Getdate(), Getdate(), 'AUTO',  id_zone, id_bsp, dte_ret_pret, adr_cod_civ=@sAdrCodCiv, 'REFUSE_A_REEXP'   , id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, null, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, @iIdProcess, 'REFUSE A REEXPEDIER', id_modl_art_ifr, 
				IIF ( @iIdSeqHubPrestaOrig > 0, 
						( sysadm.FN_CLE_VAL_E ( 'HP_ID_FOUR', c.id_four, 
							sysadm.FN_CLE_VAL_E ( 'HP_IDENTITY', '', 
								sysadm.FN_CLE_VAL_E ( 'HP_ID_HUB_PRESTA', sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';') , @sInfoSpbFrnCplt, ';' ) 
							, ';' ),
							';' )
							), @sInfoSpbFrnCplt ),	  -- [HP252_276_HUB_PRESTA] 
			   null
		From w_commande c
		Where c.id_sin = @adcIdSin
		And   c.id_seq = @iIdSeq
	End 				

	-- [HP252_276_HUB_PRESTA]
If sysadm.FN_CLE_NUMERIQUE ( 'HP252_276_HUB_PRESTA') > 0 
 Begin
	If @iIdSeqHubPrestaOrig > 0 
		Begin
			Insert into sysadm.en_attente_transfert_vers_hp ( id_cas, id_sin, id_seq, id_hub_presta, id_four, typ_dommage, point_service, mode_logis, code_pickup, nom_pickup, ref_ass_pickup, adr1_pickup, adr2_pickup, adr3_pickup, adr_cp_pickup, adr_ville_pickup, code_process, lib_code_process, id_gti, lib_perso_gti, id_detail, id_prod, lib_prod, id_prod_adh, id_ets, id_adh, id_sdos, id_typ_art, cod_civ_livr, lib_civ_livr_court, lib_civ_livr_long, id_contrat_abonne, nom_ass, prenom_ass, nom_livr, prenom_livr, adr1_livr, adr2_livr, adr3_livr, adr_cp_livr, adr_ville_livr, num_tel1_ass, num_tel2_ass, num_tel3_ass, mail_assure, num_imei_app_sin, num_serie_app_sin, description_probleme, cod_etat, valide_le, valide_par, cmd_gen_le, id_ref_four, ordre_action, id_assureur, lib_assureur, lib_police, typ_app_sin, lib_typ_app_sin, marq_app_sin, modl_app_sin, ref_app_sin, num_tel_sin, mt_val_achat, mt_prise_en_charge, date_achat, etat_app_sin, code_verrou, desimlocke, info_spb_frn_cplt )
			exec sysadm.PS_HP276_S_S2_OBTENTION_DONNEES_PRESTA_SIMPA2_POUR_PREPARATION_CREATION_HUB_PRESTATAIRE 2, @adcIdSin, @iNewIdSeq
		End 
 End 

If @sQRelPickUpRet = 'OUI' And Len ( @sCodePickUp ) > 0 
	Begin
	Update sysadm.commande 
	Set cod_etat = 'CNV'
	Where id_sin = @adcIdSin
	And   id_seq = @iIdSeq

	Set @sDbName = Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) )
	EXEC sysadm.PS_S_MAILPUSH_REFUSE_A_REEXP_RET_PICK_UP @adcIdSin, @iIdSeq, @asCasRetour OUTPUT
	
	Update sysadm.commande 
	Set cod_etat = 	@sCodEtat 
	Where id_sin = @adcIdSin
	And   id_seq = @iIdSeq
End 

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_EW_AFFICHAGE_PM287_3
-- Auteur               :       JFF
-- Date                 :       31/03/2016
-- Libelle              :       
-- Commentaires         :       [PM287-3] 
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_EW_AFFICHAGE_PM287_3' AND type = 'P' )
        DROP procedure sysadm.PS_S_EW_AFFICHAGE_PM287_3
GO

CREATE procedure sysadm.PS_S_EW_AFFICHAGE_PM287_3
        @adcIdSin     Decimal ( 10,0 ),
        @asChaineBcv  VarChar ( 255 ) OUTPUT
As

Set NoCount On

Select  @asChaineBcv = sysadm.FN_CLE_VAL ( 'IFDNMQ_RET', rtrim ( c.info_frn_spb_cplt ), ';' )
From	sysadm.commande c
Where   c.id_sin = @adcIdSin
And		c.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'IFDNMQ_ACT', rtrim( c.info_frn_spb_cplt ), ';' ) = 'A_FAIRE'
And     c.status_gc = 308
And		c.dte_rcp_frn is not null 

If @asChaineBcv is null Or rTrim ( lTrim ( @asChaineBcv )) = '' Set @asChaineBcv = 'AUCUN_AFFICHAGE'

Select @asChaineBcv 
	
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_EW_AFFICHAGE_PM287_3
-- Auteur               :       JFF
-- Date                 :       31/03/2016
-- Libelle              :       
-- Commentaires         :       [PM287-3]  
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
--     JFF 22/02/2107   [PM288-1][LOT2][PM287-3][M25172]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_EW_AFFICHAGE_PM287_3' AND type = 'P' )
        DROP procedure sysadm.PS_U_EW_AFFICHAGE_PM287_3
GO

CREATE procedure sysadm.PS_U_EW_AFFICHAGE_PM287_3
        @adcIdSin     Decimal (  10,0 ),
		@asProvenance VarChar( 50 ), -- EXTRANET, INTEGRATION [PM288-1][LOT2][PM287-3][M25172]
		@asChaineBcv  VarChar ( 255 )
As

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )
Declare @sVal		VarChar ( 100 )
Declare @sTraite	VarChar ( 10 )
Declare @iStatusGc  Integer -- [PM288-1][LOT2][PM287-3][M25172]

Set @sTraite = ''
If @asChaineBcv is null Or rtrim ( ltrim ( @asChaineBcv )) = '' Return -1 -- Chaine retour vide

If @asProvenance Not in ( 'EXTRANET', 'INTEGRATION') Return -3 -- [PM288-1][LOT2][PM287-3][M25172]

-- [PM288-1][LOT2][PM287-3][M25172]
Select @iStatusGc = 
		Case @asProvenance
			When 'EXTRANET' Then 309
			When 'INTEGRATION' Then 311
		End 



If Not Exists ( 
	Select Top 1 1 
	From	sysadm.commande c
	Where   c.id_sin = @adcIdSin
	And		c.cod_etat <> 'ANN'
	And     sysadm.FN_CLE_VAL ( 'IFDNMQ_ACT', rtrim( c.info_frn_spb_cplt ), ';' ) = 'A_FAIRE'
	And		c.dte_rcp_frn is not null
	And		c.status_gc in ( 308, 311 )
	)
	Begin 
		Return -2 -- Dossier non éligible
	End 

-- Décodage retour EW
-- 305 Dé-géoloc
If CharIndex ( '305=', @asChaineBcv ) > 0 
  Begin
	Select @sVal = sysadm.FN_CLE_VAL ( '305', @asChaineBcv, ';' )
	If @sVal = 'FAIT' 
	 Begin
		Set @sTraite = 'OUI' -- Sans valeur de report, juste mémoire de l'action

		Update	sysadm.commande
		Set		info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'GEOLOC', 'SUPP', rtrim ( c.info_spb_frn_cplt), ';')
		From	sysadm.commande c
		Where   c.id_sin = @adcIdSin
		And		c.cod_etat <> 'ANN'
		And     sysadm.FN_CLE_VAL ( 'IFDNMQ_ACT', rtrim( c.info_frn_spb_cplt ), ';' ) = 'A_FAIRE'
		And		c.status_gc in ( 308, 311 )
		And		c.dte_rcp_frn is not null

		Update	sysadm.w_commande
		Set		info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'GEOLOC', 'SUPP', rtrim ( c.info_spb_frn_cplt), ';')
		From	sysadm.w_commande c
		Where   c.id_sin = @adcIdSin
		And		c.cod_etat <> 'ANN'
		And     sysadm.FN_CLE_VAL ( 'IFDNMQ_ACT', rtrim( c.info_frn_spb_cplt ), ';' ) = 'A_FAIRE'
		And		c.status_gc in ( 308, 311 )
		And		c.dte_rcp_frn is not null

	 End
	Else
	 Begin
	  Return -305  -- Valeur erronée
	 End 
  End	

-- 232 Code verrou
If CharIndex ( '232=', @asChaineBcv ) > 0 
  Begin
	Select @sVal = sysadm.FN_CLE_VAL ( '232', @asChaineBcv, ';' )
	If Len ( rtrim ( @sVal ))  >0 
	 Begin
		Set @sTraite = 'OUI' 

		Update	sysadm.commande
		Set		info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'CODE_VERROU', Upper ( @sVal ), rtrim ( c.info_spb_frn_cplt), ';')
		From	sysadm.commande c
		Where   c.id_sin = @adcIdSin
		And		c.cod_etat <> 'ANN'
		And     sysadm.FN_CLE_VAL ( 'IFDNMQ_ACT', rtrim( c.info_frn_spb_cplt ), ';' ) = 'A_FAIRE'
		And		c.status_gc in ( 308, 311 )
		And		c.dte_rcp_frn is not null

		Update	sysadm.w_commande
		Set		info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'CODE_VERROU', Upper ( @sVal ), rtrim ( c.info_spb_frn_cplt), ';')
		From	sysadm.w_commande c
		Where   c.id_sin = @adcIdSin
		And		c.cod_etat <> 'ANN'
		And     sysadm.FN_CLE_VAL ( 'IFDNMQ_ACT', rtrim( c.info_frn_spb_cplt ), ';' ) = 'A_FAIRE'
		And		c.status_gc in ( 308, 311 )
		And		c.dte_rcp_frn is not null
	 End
  End

-- Maj général de fin
If @sTraite = 'OUI'
 Begin
	Update	sysadm.commande
	Set		cmd_gen_le = null, 
			cmd_gen_par = null, 
			id_lot_cmd = 0, 
			status_gc = @iStatusGc, -- [PM288-1][LOT2][PM287-3][M25172]
			info_frn_spb_cplt = sysadm.FN_CLE_VAL_E ( 'IFDNMQ_RET', '',
								sysadm.FN_CLE_VAL_E ( 'IFDNMQ_ACT', 'FAIT', rtrim ( c.info_frn_spb_cplt), ';')
								, ';')
	From	sysadm.commande c
	Where   c.id_sin = @adcIdSin
	And		c.cod_etat <> 'ANN'
	And     sysadm.FN_CLE_VAL ( 'IFDNMQ_ACT', rtrim( c.info_frn_spb_cplt ), ';' ) = 'A_FAIRE'
	And		c.status_gc in ( 308, 311 )
	And		c.dte_rcp_frn is not null

	Update	sysadm.w_commande
	Set		status_gc = @iStatusGc, -- [PM288-1][LOT2][PM287-3][M25172]
			info_frn_spb_cplt = sysadm.FN_CLE_VAL_E ( 'IFDNMQ_RET', '',
								sysadm.FN_CLE_VAL_E ( 'IFDNMQ_ACT', 'FAIT', rtrim ( c.info_frn_spb_cplt), ';')
								, ';')
	From	sysadm.w_commande c
	Where   c.id_sin = @adcIdSin
	And		c.cod_etat <> 'ANN'
	And     sysadm.FN_CLE_VAL ( 'IFDNMQ_ACT', rtrim( c.info_frn_spb_cplt ), ';' ) = 'A_FAIRE'
	And		c.status_gc in ( 308, 311 )
	And		c.dte_rcp_frn is not null
 End

-- dte_cour_rest_pret_HV
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_action_PM287_3_par_ass')
	 Begin
	   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EW' Where id_sin = @adcIdSin And nom_zone = 'dte_action_PM287_3_par_ass'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_action_PM287_3_par_ass', 'Date infos. renseig. pr PM287-3', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, 0, getdate(), getdate(), 'EW' ) 
	 End
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_action_PM287_3_par_ass')
	 Begin
	   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EW' Where id_sin = @adcIdSin And nom_zone = 'dte_action_PM287_3_par_ass'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_action_PM287_3_par_ass', 'Date infos. renseig. pr PM287-3', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, getdate(), getdate(), 'EW', getdate(), 'EW' ) 
	 End
  End

If @iStatusGc = 311 
  Begin
	Update sysadm.div_sin
	Set val_car = 'N'
	Where id_sin = @adcIdSin
	And   nom_zone = 'action_ksl_ec_PM287_3'
	And   val_car = 'O'

	Update sysadm.div_sin
	Set val_car = 'N'
	Where id_sin = @adcIdSin
	And   nom_zone = 'action_ksl_ec_PM287_3'
	And   val_car = 'O'
  End

-- [PM288-1][LOT2][PM287-3][M25172]
If @iStatusGc = 309 Set @sMess = 'L''assuré a confirmé via l''extranet qu''il a bien renseigné les données/infos manquantes, un flux est parti vers le fournisseur pour l''en avertir.'
If @iStatusGc = 311 Set @sMess = 'Le CTR a confirmé par intégration de fichier qu''il a bien à présent les données/infos manquantes obtenues par téléphone avec l''assuré directement.'


IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 74, 'C', @adcIdSin, 2, @sMess,	'EW', 300, @iIdCt OUTPUT
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 74, 'C', @adcIdSin, 2, @sMess,	'EW', 300, @iIdCt OUTPUT
END

Return 0

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_AGENT_CLOTURE_PM287_3
-- Auteur               :       JFF
-- Date                 :       31/03/2016
-- Libelle              :       
-- Commentaires         :       [PM287-3]  
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      04/05/2017   [DT288-1_LOT2]
-- JFF      25/09/2017   [PM287-6]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_AGENT_CLOTURE_PM287_3' AND type = 'P' )
        DROP procedure sysadm.PS_S_AGENT_CLOTURE_PM287_3
GO

CREATE procedure sysadm.PS_S_AGENT_CLOTURE_PM287_3
As

Declare @dtDateSysteme DateTime
Declare @iDelai Integer
Declare @iStatutGc Integer
Declare @dcNewIdDetail Decimal ( 7 )

Set @dtDateSysteme = GetDate()
Set @iDelai = 10 -- jours -- [DT288-1_LOT2] passé de de 7 à 10


DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ),
	  id_seq_cmde integer,
	  id_four  varchar ( 3 ),
	  id_gti    decimal ( 7 ),
	  id_detail decimal ( 7 ),
	  id_ref_four varchar ( 20 ),
	  adr_cod_civ varchar ( 50 ),
	  adr_nom varchar ( 50 ),
	  adr_prenom varchar ( 50 ),
	  adr_livr1 varchar ( 50 ),
	  adr_livr2 varchar ( 50 ),
	  adr_livr_cpl varchar ( 50 ),
	  adr_cp varchar ( 50 ),
	  adr_ville varchar ( 50 ),
	  info_spb_frn_cplt varchar ( 255 ),
	  status_gc  integer,
	  cod_etat varchar ( 50 ),
	  id_evt	integer,
	  marquage	integer null 
	)

Declare @dcIdSin decimal (10 )
Declare @dcIdGti decimal (7 )
Declare @dcIdDetail decimal (7 )
Declare @iNbre  Integer
Declare @iIdSeq integer
Declare @iIdSeqCmde integer
Declare @sAction VarChar ( 50 )
Declare @sIdRefFour VarChar ( 50 )
Declare @iIdEvt Integer
Declare @iNewIdSeq Integer
Declare @sAdrCodCiv VarChar ( 35 )
Declare @sAdrNom	 VarChar ( 35 )
Declare @sAdrPrenom VarChar ( 35 )
Declare @sAdrLivr1 VarChar ( 35 )
Declare @sAdrLivr2 VarChar ( 35 )
Declare @sAdrLivrCpl VarChar ( 35 )
Declare @sAdrCp	 VarChar ( 35 )
Declare @sAdrVille VarChar ( 35 )
Declare @asCasRetour    VarChar ( 50 )
Declare @sDbName  	VarChar ( 20 )
Declare @sCodEtatOrig VarChar ( 10 )
Declare @sCodePickUp VarChar ( 50 )
Declare @sQRelPickUpRet VarChar ( 50 )
Declare @sMailAssure VarChar ( 100 )
Declare @sInfoSpbFrnCplt VarChar ( 255 )
Declare @iIdProcess Integer
Declare @sProbleme Varchar ( 255 )
Declare @sCodEtatNew VarChar ( 10 )
Declare @sCommentFrn VarChar ( 255 )
Declare @sMess VarChar ( 255 )
Declare @iIdCt Integer
Declare @sIdFour VarChar ( 10 )

Set @sAction = ''
Set @sProbleme = ''
Set @iIdProcess = 990

Insert into @tb
select  c.id_sin,
		c.id_seq,
		c.id_four,
		c.id_gti,
		c.id_detail,
		c.id_ref_four,
		c.adr_cod_civ,
		c.adr_nom,
		c.adr_prenom,
		c.adr_livr1,
		c.adr_livr2,
		c.adr_livr_cpl,
		c.adr_cp,
		c.adr_ville,
		c.info_spb_frn_cplt,
		c.status_gc,
		c.cod_etat,
		dt.id_evt,
	    0 'marquage'
from	sysadm.commande c,
		sysadm.div_sin ds,
		sysadm.detail dt
where	sysadm.FN_CLE_VAL ( 'IFDNMQ_ACT', c.info_frn_spb_cplt, ';' ) = 'A_FAIRE'
And		sysadm.FN_CLE_VAL ( 'IFDNMQ_RET', c.info_frn_spb_cplt, ';' ) = '#305#' -- 305 uniquement, confirmé avec Marin le 01/04/2016
And		c.status_gc = 308
And     ds.id_sin = c.id_sin 
and		ds.nom_zone = 'dte_cour_PM287_3_InfoManq' 
And		ds.val_dte is not null
And		DateAdd ( day, @iDelai, ds.val_dte ) < @dtDateSysteme
And		dt.id_sin = c.id_sin
And		dt.id_gti = c.id_gti
And		dt.id_detail = c.id_detail

While Exists ( Select * From @tb where marquage = 0 )
 Begin

 	Set @sAction = ''
	Set @iStatutGc = 0
	Set @sCommentFrn = ''
	Set @sCodEtatNew = ''
	Set @sCodEtatOrig = ''
	Set @sMess = ''

	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin,
		@sIdFour = id_four,
		@iIdSeqCmde = id_seq_cmde,
		@dcIdGti = id_gti,
		@dcIdDetail = id_detail,
		@sIdRefFour = id_ref_four,
		@sCodePickUp = sysadm.FN_CLE_VAL ( 'CODE_PICK_UP', info_spb_frn_cplt, ';'), -- [DT191-1]
		@sQRelPickUpRet = sysadm.FN_CLE_VAL ( 'RET_REL_PICK_UP', info_spb_frn_cplt, ';'), -- [DT191-1]
		@sMailAssure = sysadm.FN_CLE_VAL ( 'MAIL_ASSURE', info_spb_frn_cplt, ';'), -- [DT191-1]
		@sAdrCodCiv = adr_cod_civ,
		@sAdrNom = adr_nom,
		@sAdrPrenom = adr_prenom,
		@sAdrLivr1 = adr_livr1,
		@sAdrLivr2 = adr_livr2,
		@sAdrLivrCpl = adr_livr_cpl,
		@sAdrCp = adr_cp,
		@sAdrVille = adr_ville,
		@iStatutGc = status_gc,
		@sCodEtatOrig = cod_etat,
		@iIdEvt = id_evt

	From	@tb
	Where	marquage = 0

	If Exists ( 
				Select Top 1 1 
				From   sysadm.det_pro dp,
					   sysadm.sinistre s
						
				Where  s.id_sin = @dcIdSin
				And    dp.id_prod = s.id_prod
				And    dp.id_code_dp = 296
				And    sysadm.FN_CLE_VAL ( 'REFUSE_A_REEXP_DEL_DEP', rtrim ( val_car ) + rtrim ( val_car2), ';' ) = 'OUI'
			  )
		Begin
			Set @sAction = 'REFUSE_A_REEXP'
			Set @iStatutGc = 21
			Set @sCommentFrn = '[BNV] Cloture automatique par le système PM287-3 suite non réponse de l''assuré.'
			Set @sCodEtatNew = 'ECT'
			Set @sCodEtatOrig = 'RPC'
			Set @sMess = 'Suite non réponse de l''assuré dans les délais à la dé-géolocalisation de son appareil, la prestation n°' + Convert ( VarChar (5), @iIdSeqCmde)  + ' est automatiquement fermée par le système PM287-3. Le matériel sinistré est renvoyé à l''assuré.'
		End

	If @sAction = ''
	 Begin
		If @sIdRefFour = 'A_DIAGNOSTIQUER' 
		 Begin
			Set @sAction = 'PEC_A_RECYCLER'
			Set @iStatutGc = 151
			Set @sCodEtatNew = 'RFO'
			Set @sCodEtatOrig = 'RFO'
			Set @sCommentFrn = '[BNV] Cloture automatique par le système PM287-3 suite non réponse de l''assuré.'
			Set @sMess = 'Suite non réponse de l''assuré dans les délais à la dé-géolocalisation de son appareil, la prestation n°' + Convert ( VarChar (5), @iIdSeqCmde)  + ' est fermée par le système PM287-3 et dite CONFORME. Une seconde prestation PEC_A_RECYCLER est automatiquement envoyée au prestataire.'
		 End
	 End 

	If @sAction = ''
	 Begin
		If @sIdRefFour = 'A_REPARER' And @iIdEvt <> 1377
		 Begin
			Set @sAction = 'A_REPARER_FORCE'
			Set @iStatutGc = 310
			Set @sCodEtatNew = 'RFO'
			Set @sCodEtatOrig = 'ECT'
			Set @sCommentFrn = 'PM287-3 l''assuré n''a pas répondu, à forcer donc.'
			Set @sMess = 'Suite non réponse de l''assuré dans les délais à la dé-géolocalisation de son appareil sur la prestation n°' + Convert ( VarChar (5), @iIdSeqCmde)  + ', le système PM287-3 force automatiquement l''acte de réparation auprès du prestataire (réinitialisation de l''appareil).'
		 End
	 End 

	If @sAction = ''
	 Begin
		If @sIdRefFour = 'A_DESOXYDER' And @iIdEvt = 1377
		 Begin
			Set @sAction = 'A_DESOXYDER_FORCE'
			Set @iStatutGc = 310
			Set @sCodEtatNew = 'RFO'
			Set @sCodEtatOrig = 'ECT'
			Set @sCommentFrn = 'PM287-3 l''assuré n''a pas répondu, à forcer donc.'
			Set @sMess = 'Suite non réponse de l''assuré dans les délais à la dé-géolocalisation de son appareil sur la prestation n°' + Convert ( VarChar (5), @iIdSeqCmde)  + ', le système PM287-3 force automatiquement l''acte de désoxydation auprès du prestataire (réinitialisation de l''appareil).'
		 End
	 End 


	If @sAction <> ''
	 Begin
		Set @sProbleme = @sCommentFrn

		Select @iNewIdSeq = max ( id_seq ) From commande where id_sin = @dcIdSin

		If @iNewIdSeq is null Set @iNewIdSeq = 0
		Set @iNewIdSeq = @iNewIdSeq + 1

		-- [DT191-1]
		If @sQRelPickUpRet = 'OUI' And Len ( @sCodePickUp ) > 0 And @sIdFour <> 'COR'
		 Begin
			Set @sInfoSpbFrnCplt = 'CODE_PICK_UP=' + rtrim ( @sCodePickUp ) + ';RET_REL_PICK_UP=OUI;MAIL_ASSURE=' + rtrim ( @sMailAssure ) 
			Set @iIdProcess = 983
		 End 

		-- [DT191-1]
		Insert into commande
		select top 1 id_sin , @iNewIdSeq, id_gti, @dcIdDetail, id_four, id_typ_art= 'EDI', @sAction, '', mt_ttc_cmde=0, 
					adr_nom=@sAdrNom, 
					adr_prenom=@sAdrPrenom, 
					adr_livr1=@sAdrLivr1, 
					adr_livr2=@sAdrLivr2, 
					adr_livr_cpl=@sAdrLivrCpl, 
					adr_cp=@sAdrCp, 
					adr_ville=@sAdrVille, 
					adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, @sProbleme, null,  null, null, null, null, @sCodEtatNew, CONVERT ( VarChar ( 10), GetDate(), 103 ) + ' ' + @sCommentFrn , 'PRESTA AUTOMATIQUE', 0, null, null, Getdate(), Getdate(), 'P287'	 ,  Getdate(), 'P287', id_zone, id_bsp, dte_ret_pret, adr_cod_civ=@sAdrCodCiv, @sAction, id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, null, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, @iIdProcess, @sAction, id_modl_art_ifr,
				@sInfoSpbFrnCplt ,-- [DT191-1]   
				null
		From commande c
		Where c.id_sin = @dcIdSin
		And   c.id_seq = @iIdSeqCmde

		If Exists ( Select * from w_commande where id_sin = @dcIdSin and id_seq = @iIdSeqCmde )
			Begin
			Insert into w_commande
			select top 1 id_sin , @iNewIdSeq, id_gti, @dcIdDetail, id_four, id_typ_art= 'EDI', @sAction, '', mt_ttc_cmde=0, 
					adr_nom=@sAdrNom, 
					adr_prenom=@sAdrPrenom, 
					adr_livr1=@sAdrLivr1, 
					adr_livr2=@sAdrLivr2, 
					adr_livr_cpl=@sAdrLivrCpl, 
					adr_cp=@sAdrCp, 
					adr_ville=@sAdrVille, 
					adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, @sProbleme, null,  null, null, null, null, @sCodEtatNew, CONVERT ( VarChar ( 10), GetDate(), 103 ) + ' ' + @sCommentFrn , 1, 'PRESTA AUTOMATIQUE', Getdate(), Getdate(), 'P287',  id_zone, id_bsp, dte_ret_pret, adr_cod_civ=@sAdrCodCiv, @sAction   , id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, null, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, @iIdProcess, @sAction, id_modl_art_ifr, 
					@sInfoSpbFrnCplt -- [DT191-1]
					, null
			From w_commande c
			Where c.id_sin = @dcIdSin
			And   c.id_seq = @iIdSeqCmde
			End 				
	
		-- Maj presta orig
		Update sysadm.commande 
		Set    cod_etat = @sCodEtatOrig,
			   status_gc = @iStatutGc,
			   comment_frn = Case 
								When @iStatutGc in ( 151, 21  ) Then rtrim ( isnull ( comment_frn, '' ) ) + '. ' + CONVERT ( VarChar ( 10), GetDate(), 103 ) + ' ' + @sCommentFrn 
								Else rtrim ( comment_frn )
							 End,
			   maj_le = getdate(),
			   maj_par = 'P287'	,
			   valide_le = getdate(),
			   valide_par = 'P287',
			   info_frn_spb_cplt = sysadm.FN_CLE_VAL_E ( 'IFDNMQ_ACT', '', info_frn_spb_cplt, ';')
   			  
		Where  id_sin = @dcIdSin
		And    id_seq = @iIdSeqCmde

		-- Maj presta orig
		Update sysadm.w_commande 
		Set    cod_etat = @sCodEtatOrig,
			   status_gc = @iStatutGc,
			   comment_frn = Case 
								When @iStatutGc in ( 151, 21  ) Then rtrim ( isnull ( comment_frn, '' ) ) + '. ' + CONVERT ( VarChar ( 10), GetDate(), 103 ) + ' ' + @sCommentFrn 
								Else rtrim ( comment_frn )
							 End,
			   maj_le = getdate(),
			   maj_par = 'P287',
			   info_frn_spb_cplt = sysadm.FN_CLE_VAL_E ( 'IFDNMQ_ACT', '', info_frn_spb_cplt, ';')			   	 
   			  
		Where  id_sin = @dcIdSin
		And    id_seq = @iIdSeqCmde

		-- [PM287-6]
		If @sAction = 'REFUSE_A_REEXP'
			Begin
			Delete sysadm.div_sin where id_sin = @dcIdSin and nom_zone = 'cour_info_manquante_ref_a_reexp'

			Insert into sysadm.div_sin 
			(
			id_sin,
			nom_zone,
			lib_label,
			id_typ_liste,
			alt_liste_codecar,
			id_typ_zone,
			alt_oblig,
			alt_prot,
			cpt_tri,
			val_nbre,
			val_mt,
			val_dte,
			val_car,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par
			)
			Values 
			(
			@dcIdSin,
			'cour_info_manquante_ref_a_reexp',
			'Cour.info.manquante.ref_a_reexp',
			-1,
			'N',
			'C',
			'N',
			'O',
			800,
			null,
			null,
			null,
			'refus_a_reexpedier', -- Code maquette donné par EPG (NT)
			getdate (),
			Getdate (),
			'AUTO',
			Getdate (),
			'AUTO'
			)	
		End

		 IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		 BEGIN
			Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 75, 'C', @dcIdSin, 2, @sMess, 'AUTO', 300, @iIdCt OUTPUT
		 END
		 ELSE
		 BEGIN
			Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 75, 'C', @dcIdSin, 2, @sMess, 'AUTO', 300, @iIdCt OUTPUT
		 END


	 End


	Update @tb
	Set marquage = 1
	Where id_seq = @iIdSeq
 End


Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U01_MAJ_NO_RECOMMANDE_CMA
-- Auteur               :       FPI
-- Date                 :       21/06/2016
-- Libelle              :       Mise à jour du n° de recommandé de la dernière commande Carma
-- Commentaires         :       [DT176]  
-- References           :       
-- Arguments            :       
--
-- Retourne             :       0 OK, -1 +ieurs commandes éligibles, >0 problème SQL
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_MAJ_NO_RECOMMANDE_CMA' AND type = 'P' )
        DROP procedure sysadm.PS_U01_MAJ_NO_RECOMMANDE_CMA
GO

CREATE procedure sysadm.PS_U01_MAJ_NO_RECOMMANDE_CMA
	@adcIdSin      	Decimal (10),
	@asRecommande	Varchar(35)
AS
	Declare @iIdSeq int,
		@iRet int

	Set @iRet=0

	Select @iRet=count(*)
	from sysadm.commande
	where id_sin=@adcIdSin and id_four='CMA' and cod_etat <> 'ANN'

	If @iRet=1
	Begin

		Select @iIdSeq=id_seq
		from sysadm.commande
		where id_sin=@adcIdSin and id_four='CMA' and cod_etat <> 'ANN'

		update sysadm.commande 
		set id_bon_transp=@asRecommande
		where id_sin=@adcIdSin and id_seq=@iIdSeq

		Set @iRet=@@ROWCOUNT

		update sysadm.w_commande 
		set id_bon_transp=@asRecommande
		where id_sin=@adcIdSin and id_seq=@iIdSeq

		If @iRet=1 Set @iRet=0
	End
	Else Set @iRet=-1
	

	Return @iRet
Go


grant execute on sysadm.PS_U01_MAJ_NO_RECOMMANDE_CMA to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_PC151549_MOT_REC_PEC
-- Auteur               :       Fabry JF
-- Date                 :       04/07/2016
-- Libelle              :       [PC151549] 
-- Commentaires         :       Select sur la table COMMANDE
-- References           :       En consultation permanente
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF	24/08/2016  VDOC21661
-- JFF	12/04/2017  VDOC23580
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PC151549_MOT_REC_PEC_V02' AND type = 'P' )
        DROP procedure sysadm.PS_S_PC151549_MOT_REC_PEC_V02
GO

CREATE procedure sysadm.PS_S_PC151549_MOT_REC_PEC_V02
        @sNom        Varchar ( 35 ),
		@sPrenom     Varchar ( 35 ),
		@sIMEI		 Varchar ( 20 ),
		@sNumTel	 Varchar ( 10 ),
		@sIdSin		 Varchar ( 10 )
AS

Declare @dcIdSin Decimal( 10 )

If ( rTrim ( @sNom ) = '' Or @sNom is null ) And ( rTrim ( @sPrenom ) <> '' and @sPrenom is not null ) Return -1 -- Prénom Obligatire 
If ( rTrim ( @sPrenom ) = '' Or @sPrenom is null ) And ( rTrim ( @sNom ) <> '' and @sNom is not null ) Return -2 -- Prénom Obligatire 
IF rTrim ( @sIdSin ) <> '' And @sIdSin is not null And IsNumeric ( @sIdSin ) = 0 Return -3 --- réf sin non numérique

Set @sNom = Upper ( ltrim ( rtrim ( @sNom )))
Set @sPrenom = Upper ( ltrim ( rtrim ( @sPrenom )))
Set @sIMEI = ltrim ( rtrim ( @sIMEI ))
Set @sNumTel = ltrim ( rtrim ( @sNumTel ))
Set @sIdSin = ltrim ( rtrim ( @sIdSin ))

Set @dcIdSin = Convert ( Decimal ( 10 ), @sIdSin )

Select  s.id_sin 'sinitre',
		rtrim ( p.nom ) + ' ' + rtrim ( p.prenom ) 'Nom/Prénom',
		( Select sysadm.FN_AFF_DATE ( min ( c.cree_le ), 'SH') 
			From   sysadm.commande c
			Where c.id_sin = s.id_sin
			And	  c.id_four = 'BST'
			And   c.cod_etat <> 'ANN'
		) 'Dte_Pec',
		'A_RENSEIGNER_PAR_EXTRANET' 'Statut',
		s.num_imei_port 'IMEI/Série',
		s.id_adh 'Num_Adhésion',
		rtrim ( b.cod_mag ) 'Code_PDV',
		Case When Exists ( 
					Select Top 1 1
					From   sysadm.div_sin ds
					Where  ds.id_sin = s.id_sin
					And	   ds.nom_zone = 'ech_express_48h'
					And	   ds.val_car = 'O'
				  ) Then 'Express'
			 Else 'Classique'

		End 'Type_Remplacement',
		IsNull ( 
			( Select min ( dd.val_mt )
			  From	sysadm.div_det dd
			  Where dd.id_sin = s.id_sin
			  And	dd.nom_zone = 'mt_pec'
			  And   dd.val_mt > 0 
			  And   dd.val_mt <> 9999
			), 0 ) 'Mt_Pec',
		Case 
			When Exists ( Select Top 1 1 From sysadm.gar_sin g where g.id_sin = s.id_sin and g.id_gti = 10 )
			  Then 'VOL'
			Else ''
		End 'VOL', -- VDOC21661
		rtrim ( s.marq_port ) 'Marque', -- VDOC23580
		rtrim ( s.modl_port ) 'Modèle', -- VDOC23580
		rtrim ( s.num_imei_port ) 'IMEI' -- VDOC23580

From	sysadm.sinistre s,
		sysadm.personne p,
		sysadm.det_pro  dp,
		sysadm.inter	i,
		sysadm.boutique b
Where   dp.id_code_dp = 302
And		s.id_prod = dp.id_prod
And		s.cod_etat <> 900
And		b.id_prod = dp.id_prod
And		b.id_boutique = s.id_orian_boutique
And		b.region is null
And		p.id_ordre = s.id_ordre
And		i.id_sin = s.id_sin
and		i.cod_inter = 'A'
And		( p.nom = @sNom Or @sNom is null Or @sNom = '' ) 
And		( p.prenom = @sPrenom Or @sPrenom is null Or @sPrenom = '' ) 
And		( s.num_imei_port = @sIMEI Or @sIMEI is null Or @sIMEI = '' )
And		( ( i.num_teld = @sNumTel Or @sNumTel is null Or @sNumTel = '' )
		  Or
		  ( s.num_port = @sNumTel Or @sNumTel is null Or @sNumTel = '' )
		)
And		( s.id_sin = @dcIdSin Or @sIdSin is null Or @sNumTel = '' )
And		Exists ( 
			Select Top 1 1
			From sysadm.commande c
			Where c.id_sin = s.id_sin
			And	  c.id_four = 'BST'
			And   c.cod_etat <> 'ANN'
		)

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_PC151549_LST_COMPL_PEC
-- Auteur               :       Fabry JF
-- Date                 :       04/07/2016
-- Libelle              :       [PC151549] 
-- Commentaires         :       Select sur la table COMMANDE
-- References           :       En consultation permanente
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF	24/08/2016  VDOC21661
-- JFF	12/04/2017  VDOC23580
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PC151549_LST_COMPL_PEC_V02' AND type = 'P' )
        DROP procedure sysadm.PS_S_PC151549_LST_COMPL_PEC_V02
GO

CREATE procedure sysadm.PS_S_PC151549_LST_COMPL_PEC_V02
        @sIdBoutique Varchar ( 35 )
AS

Set @sIdBoutique = ltrim ( rtrim ( @sIdBoutique ))

Select  s.id_sin 'sinitre',
		rtrim ( p.nom ) + ' ' + rtrim ( p.prenom ) 'Nom/Prénom',
		( Select sysadm.FN_AFF_DATE ( min ( c.cree_le ), 'SH') 
			From   sysadm.commande c
			Where c.id_sin = s.id_sin
			And	  c.id_four = 'BST'
			And   c.cod_etat <> 'ANN'
		) 'Dte_Pec',
		'A_RENSEIGNER_PAR_EXTRANET' 'Statut',
		s.num_imei_port 'IMEI/Série',
		s.id_adh 'Num_Adhésion',
		b.cod_mag 'Code_PDV',
		Case When Exists ( 
					Select Top 1 1
					From   sysadm.div_sin ds
					Where  ds.id_sin = s.id_sin
					And	   ds.nom_zone = 'ech_express_48h'
					And	   ds.val_car = 'O'
				  ) Then 'Express'
			 Else 'Classique'

		End 'Type_Remplacement',
		IsNull ( 
			( Select min ( dd.val_mt )
			  From	sysadm.div_det dd
			  Where dd.id_sin = s.id_sin
			  And	dd.nom_zone = 'mt_pec'
			  And   dd.val_mt > 0 
			  And   dd.val_mt <> 9999
			), 0 ) 'Mt_Pec',
		Case 
			When Exists ( Select Top 1 1 From sysadm.gar_sin g where g.id_sin = s.id_sin and g.id_gti = 10 )
			  Then 'VOL'
			Else ''
		End 'VOL', -- VDOC21661
		rtrim ( s.marq_port ) 'Marque', -- VDOC23580
		rtrim ( s.modl_port ) 'Modèle', -- VDOC23580
		rtrim ( s.num_imei_port ) 'IMEI' -- VDOC23580

From	sysadm.sinistre s,
		sysadm.personne p,
		sysadm.det_pro  dp,
		sysadm.boutique b
Where   dp.id_code_dp = 302
And		s.id_prod = dp.id_prod
And		s.cod_etat <> 900
And		p.id_ordre = s.id_ordre
And		b.id_prod = s.id_prod
And		( b.cod_mag = @sIdBoutique Or @sIdBoutique = 'BOO' )
And		b.region is null
And		s.id_orian_boutique = b.id_boutique
And		Exists ( 
			Select Top 1 1
			From sysadm.commande c
			Where c.id_sin = s.id_sin
			And	  c.id_four = 'BST'
			And   c.cod_etat <> 'ANN'
		)

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_PRESTA_LECLERC_PNEU
-- Auteur               :       Fabry JF
-- Date                 :       11/10/2016
-- Libelle              :       [DT227][V3]
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF	23/03/2017	Suite retur D'Emiline Georges
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_PRESTA_LECLERC_PNEU' AND type = 'P' )
        DROP procedure sysadm.PS_U_PRESTA_LECLERC_PNEU
GO

CREATE procedure sysadm.PS_U_PRESTA_LECLERC_PNEU
        @dcIdSin Decimal (10),
		@scodOper Varchar ( 4 )
AS

If Exists ( 
		Select	Top 1 1 
		From	sysadm.detail d
		Where   d.id_sin = @dcIdSin
		And     d.id_evt = 1397
		And		d.cod_etat not in ( 900, 200 )  -- Suite retur D'Emiline Georges
	)
	Begin
		Update sysadm.commande 
		Set cod_etat = 'ANN',
			comment_frn = 'Annulé suite evt 1397 (Remboursement suite remplacement) instruit',
			maj_le = getdate (),
			maj_par = @scodOper,
			valide_le = getdate (),
			valide_par = @scodOper
		Where id_sin = @dcIdSin
		And   id_four in ( 'CAL', 'AUT' )
		And   id_typ_art = 'PRS'

		Update sysadm.w_commande 
		Set cod_etat = 'ANN',
			comment_frn = 'Annulé suite evt 1397 instruit',
			maj_le = getdate (),
			maj_par = @scodOper
		Where id_sin = @dcIdSin
		And   id_four in ( 'CAL', 'AUT' )
		And   id_typ_art = 'PRS'
	End 


If Exists ( 
		Select	Top 1 1 
		From	sysadm.detail d
		Where   d.id_sin = @dcIdSin
		And     d.id_evt = 940
		And		d.cod_etat in ( 500, 600 )
	)
	Begin
		Update sysadm.commande 
		Set cod_etat = 'ANN',
			comment_frn = 'Annulé suite evt 940 (Remboursement appareil garanti) instruit, en vu d''un réglement à l''assuré directement',
			maj_le = getdate (),
			maj_par = @scodOper,
			valide_le = getdate (),
			valide_par = @scodOper
		Where id_sin = @dcIdSin
		And   id_four in ( 'CAL', 'AUT' )
		And   id_typ_art in ( 'PRS', 'PNE')

		Update sysadm.w_commande 
		Set cod_etat = 'ANN',
			comment_frn = 'Annulé suite evt 940 instruit',
			maj_le = getdate (),
			maj_par = @scodOper
		Where id_sin = @dcIdSin
		And   id_four in ( 'CAL', 'AUT' )
		And   id_typ_art in ( 'PRS', 'PNE')
	End 

Go


-------------------------------------------------------------------
-- Procedure            :       PS_U01_MAJ_COMMANDE_CMA
-- Auteur               :       F. Pinon
-- Date                 :       19/07/2010 
-- Libelle              :        
-- Commentaires         :       Procédure de mise à jour de commande
--                               
-- References           :       [PC151255]
--
-- Arguments            :       @dcIdSin              Decimal(10,0)        	(Val) Identifiant de sinistre
--				                @sCodOper             VarChar (4)           (Val) Code opérateur
--
--
-- Retourne             :       (Rien)
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_MAJ_COMMANDE_CMA' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_U01_MAJ_COMMANDE_CMA
GO

CREATE PROCEDURE sysadm.PS_U01_MAJ_COMMANDE_CMA
	@dcIdSin decimal(10,0),
	@sCodOper varchar(4)
As
	update sysadm.w_commande
	set info_spb_frn=2830,
		maj_le=getdate(),
		maj_par=@sCodOper
	where id_sin=@dcIdSin 
		and id_four='SCR'
		and cod_etat <> 'ANN'
		and info_spb_frn=2811

	update sysadm.commande
	set info_spb_frn=2830,
		maj_le=getdate(),
		maj_par=@sCodOper
	where id_sin=@dcIdSin 
		and id_four='SCR'
		and cod_etat <> 'ANN'
		and info_spb_frn=2811

Go

grant execute on sysadm.PS_U01_MAJ_COMMANDE_CMA to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_COMMANDE_DT276_SWAP_CTR
-- Auteur               :       Fabry JF
-- Date                 :       03/11/2016
-- Libelle              :       [DT276]
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      21/11/2016   [DT280]
-- JFF      23/01/2017   [DT290]
-- JFF      07/03/2017   [DT280] Vu avec Hélène, je génère pour O2M dans tous les cas
-- JFF      21/02/2107   [DT288]
-- FPI		24/10/2017	 [FPI.COR.20171024] Mail Helène : les commandes pour régularisation suite swap ne doivent pas être envoyés à Cordon
-- JFF		31/10/2017	 [JFF.COR.20171031] Mail Christine: les commandes pour régularisation suite swap doivent être envoyés à Cordon
-- JFF      07/03/2024   [HP252_276_HUB_PRESTA]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_COMMANDE_DT276_SWAP_CTR' AND type = 'P' )
        DROP procedure sysadm.PS_I_COMMANDE_DT276_SWAP_CTR
GO

CREATE procedure sysadm.PS_I_COMMANDE_DT276_SWAP_CTR
        @dcIdSin Decimal (10),
		@dcIdGti Decimal (7),
		@dcIdDetail Decimal (7),
		@iIdSeq Integer,
		@sInfoFrnSpbCplt VarChar ( 255 ),
		@sTypeAppSin VarChar ( 3 ), 
		@sIdSerieNouv VarChar ( 60 ),
		@sIdBonTransp VarChar ( 35 ),
		@dtDteEnvCli DateTime,
		@sLibFour VarChar ( 35), 
		@sIdFour VarChar ( 3), 
		@iInfoSpbFrnActuel Integer,
		@iCasDT276SwapCTR Integer OUTPUT
AS

Declare @dcNewIdDetail Decimal ( 7 )
Declare @iNewIdSeq Integer
Declare @sMess  VarChar ( 2000 )
Declare @iIdCt Integer
Declare @iInfoSpbFrn Integer
Declare @iIdLotCmd Integer
Declare @dcIdEvt Decimal ( 7 )
Declare @iPrestaHUB Integer
Declare @sAutresInfosRempl VarChar ( 100 )
Declare @sMarqRempl VarChar ( 35 )
Declare @sModlRempl VarChar ( 35 )
Declare @iMarqModlIFr Integer
Declare @sNewInfoSpbFrnCplt VarChar ( 255 )
Declare @sNewInfoFrnSpbCplt VarChar ( 255 )
Declare @sCapStkRempl VarChar ( 35 )
Declare @sCoulRempl VarChar ( 35 )
Declare @TypArtIfr		VarChar ( 255 )
Declare @sNewIdRefFour VarChar ( 20 ) -- [RS4616_RET_TLS]
Declare @sNewIdRefFourTest VarChar ( 20 ) -- [RS4616_RET_TLS]
Declare @iCptId Integer -- [RS4616_RET_TLS]


Set @iCasDT276SwapCTR = 0 
Set @iPrestaHUB = 0 
IF sysadm.FN_CLE_VAL ( 'TGR_APPSW', rtrim ( @sInfoFrnSpbCplt ) , ';') <> 'OUI' Return
IF sysadm.FN_CLE_VAL ( 'APP_SWAP', rtrim ( @sInfoFrnSpbCplt ) , ';') <> 'OUI' Return

Set @iInfoSpbFrn = 0
Set @iIdLotCmd   = 999999

-- [HP252_276_HUB_PRESTA]
Set @sMarqRempl = sysadm.FN_CLE_VAL ( 'MARQSW', @sInfoFrnSpbCplt, ';' ) 
Set @sModlRempl = sysadm.FN_CLE_VAL ( 'MODLSW', @sInfoFrnSpbCplt, ';' ) 

-- [HP252_276_HUB_PRESTA]
If sysadm.FN_CLE_NUMERIQUE ( 'HP252_276_HUB_PRESTA') > 0 
Begin
	
	Select @iPrestaHUB = IIF ( Len ( sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';' ) ) > 0, 1, 0 )
	From sysadm.commande c
	Where c.id_sin = @dcIdSin
	And   c.id_seq = @iIdSeq
	If @iPrestaHUB is null Set @iPrestaHUB = 0
	
	Set @sAutresInfosRempl = sysadm.FN_CLE_VAL ( 'AUTRES_INFOS_REMPL', @sInfoFrnSpbCplt, ';' )
	If @iPrestaHUB > 0 And @sAutresInfosRempl in ( 'COULEUR_ET_CAPACITE', 'COULEUR', 'CAPACITE')
		Begin
			If @sAutresInfosRempl = 'COULEUR_ET_CAPACITE'
				Begin
					Set @sCapStkRempl = sysadm.FN_CLE_VAL ( 'CAP_STK_REMPL', @sInfoFrnSpbCplt, ';' )
					Set @sCoulRempl = sysadm.FN_CLE_VAL ( 'COUL_REMPL', @sInfoFrnSpbCplt, ';' )
					If  CharIndex ( 'TO', Upper ( @sCapStkRempl), 1 ) <=0  And 
						CharIndex ( 'GO', Upper ( @sCapStkRempl), 1 ) <=0  And 
						CharIndex ( 'GB', Upper ( @sCapStkRempl), 1 ) <=0  Set @sCapStkRempl = @sCapStkRempl + 'GB'

					Set @sModlRempl = rtrim ( ltrim ( @sModlRempl + ' ' + @sCoulRempl + ' ' + @sCapStkRempl ))
				End 

			If @sAutresInfosRempl = 'COULEUR'
				Begin
					Set @sCoulRempl = sysadm.FN_CLE_VAL ( 'COUL_REMPL', @sInfoFrnSpbCplt, ';' )
					Set @sModlRempl = rtrim ( ltrim ( @sModlRempl + ' ' + @sCoulRempl ))
				End 

			If @sAutresInfosRempl = 'CAPACITE'
				Begin
					Set @sCapStkRempl = sysadm.FN_CLE_VAL ( 'CAP_STK_REMPL', @sInfoFrnSpbCplt, ';' )
					If  CharIndex ( 'TO', Upper ( @sCapStkRempl), 1 ) <=0  And 
						CharIndex ( 'GO', Upper ( @sCapStkRempl), 1 ) <=0  And 
						CharIndex ( 'GB', Upper ( @sCapStkRempl), 1 ) <=0  Set @sCapStkRempl = @sCapStkRempl + 'GB'

					Set @sModlRempl = rtrim ( ltrim ( @sModlRempl + ' ' + @sCapStkRempl ))
				End 
		End 

End 


-- [HP252_276_HUB_PRESTA]
Set @iMarqModlIFr = 0
If Exists  (
	Select top 1 1 From sysadm.ifr i
	Where i.marque = @sMarqRempl
	And   i.reference = @sModlRempl
) 
Begin
	Set @iMarqModlIFr = 1
End 


-- [DT290]
-- [DT280] Vu avec Hélène, je génère pour O2M dans tous les cas
-- [DT288]
-- [HP252_276_HUB_PRESTA] Or @iPrestaHUB > 0
If @iInfoSpbFrnActuel = 984 Or @sIdFour in ( 'O2M', 'COR' ) Or @iPrestaHUB > 0
 Begin
	Set @iInfoSpbFrn = 986
	Set @iIdLotCmd   = 0
	-- If @sIdFour='COR' Set @iIdLotCmd   = 999999 -- [FPI.COR.20171024]
 End 

Set @iCasDT276SwapCTR = 1 

Select @dcIdEvt = sysadm.FN_EVT_REMPL  ( @dcIdSin, null, @dcIdGti )

Select	@dcNewIdDetail = max ( id_detail ) 
From	sysadm.detail
where   id_sin = @dcIdSin
and     id_gti = @dcIdGti 

If @dcNewIdDetail is null Set @dcNewIdDetail = 0
Set @dcNewIdDetail = @dcNewIdDetail + 1

Insert into sysadm.detail 
Select id_sin,   id_gti,   @dcNewIdDetail,   @dcIdEvt,   id_reg,   id_i_reg,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej,   mt_fran,   mt_nplaf,   mt_plaf,   alt_plaf,   alt_reg,   'O',   alt_ssui,   cod_mot_ssui,   cod_dec_mac,   cod_dec_ope,   cod_etat,   id_carte,   id_type_carte,   getdate(),   'AUTO',   getdate(),   getdate(),   'AUTO',   dte_cmd,   dte_livr,   mt_val_achat,   mt_val_publique,   num_facture
From sysadm.detail d
Where d.id_sin = @dcIdSin
And   d.id_gti = @dcIdGti
And   d.id_detail = @dcIdDetail


If Exists ( Select * from w_detail where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
	Begin
	Insert into sysadm.w_detail 
	Select id_sin,   id_gti,   @dcNewIdDetail,   @dcIdEvt,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej,   mt_fran,   mt_nplaf,   mt_plaf,   null, 'N', 'N', alt_plaf,   alt_reg,   'O', alt_valide,  1,  alt_ssui,   cod_mot_ssui,   cod_dec_mac,   cod_dec_ope,   cod_etat,   id_carte,   id_type_carte, getdate(),   getdate(),   'AUTO',   dte_cmd,   dte_livr,   mt_val_achat,   mt_val_publique,   num_facture
	From sysadm.w_detail d
	Where d.id_sin = @dcIdSin
	And   d.id_gti = @dcIdGti
	And   d.id_detail = @dcIdDetail
	End 


Insert into sysadm.div_det 
Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, getdate(), getdate(),  'AUTO', getdate(), 'AUTO'
From sysadm.div_det d
Where d.id_sin = @dcIdSin
And   d.id_gti = @dcIdGti
And   d.id_detail = @dcIdDetail

If Exists ( Select * from w_div_det where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
	Begin
		Insert into sysadm.w_div_det 
		Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, 1, getdate(),   getdate(), 'AUTO'
		From sysadm.w_div_det d
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail			  
	End 
	 

Select @iNewIdSeq = max ( id_seq ) From sysadm.commande where id_sin = @dcIdSin

If @iNewIdSeq is null Set @iNewIdSeq = 0
Set @iNewIdSeq = @iNewIdSeq + 1

-- [HP252_276_HUB_PRESTA]		
Set @sNewInfoSpbFrnCplt = 
			sysadm.FN_CLE_VAL_E ( 'GRADE_REC', sysadm.FN_CLE_VAL ( 'GRADE_REC', @sInfoFrnSpbCplt, ';' ),
			sysadm.FN_CLE_VAL_E ( 'NEUF_REC', sysadm.FN_CLE_VAL ( 'NEUF_REC', @sInfoFrnSpbCplt, ';' ), '', ';')
			, ';')

-- [HP252_276_HUB_PRESTA] HP_ID_HUB_PRESTA bidon juste pour mémoire que c'est une 
If @iPrestaHUB > 0 Set @sNewInfoSpbFrnCplt = sysadm.FN_CLE_VAL_E ( 'HP_ID_HUB_PRESTA', 'FICTIVE', @sNewInfoSpbFrnCplt, ';')


-- [HP252_276_HUB_PRESTA]
Set @sNewInfoFrnSpbCplt = sysadm.FN_CLE_VAL_E ( 'SWAP_AUTO_CTR', 'OUI', '', ';' )


Insert into sysadm.commande
select top 1 
		id_sin,
		@iNewIdSeq, 
		id_gti, 
		@dcNewIdDetail, 
		c.id_four, -- [DT280]
		@sTypeAppSin,
		@sMarqRempl,  -- [HP252_276_HUB_PRESTA]
		@sModlRempl,  -- [HP252_276_HUB_PRESTA]
		Convert ( Decimal ( 11, 2 ), sysadm.FN_CLE_VAL ( 'MTTTCSW', @sInfoFrnSpbCplt, ';' )), 
		adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, 
		'', null,  
		@sIdSerieNouv, 
		@sIdBonTransp,
		null,
		@dtDteEnvCli, 
		'RPC', 
		Convert ( VarChar ( 10), GetDate(), 103) + '=>Commande de remplacement automatique suite SWAP ' + sysadm.FN_CODE_CAR ( c.id_four, '-FR') + '.', -- [DT280]
		'PRESTA AUTOMATIQUE', @iIdLotCmd, null, null, Getdate(), Getdate(), 'AUTO',  Getdate(),  'AUTO', id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'REMPL_SWAP_CTR', id_orian_marque, id_orian_modele, dte_elv_mobile,
		178,
		dte_emis_devis, mt_devis, alt_dev_acp, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, @iInfoSpbFrn,
		IIF ( @iMarqModlIFr > 0, @sMarqRempl, null ), -- [HP252_276_HUB_PRESTA]
		IIF ( @iMarqModlIFr > 0, @sModlRempl, null ), -- [HP252_276_HUB_PRESTA]
		@sNewInfoSpbFrnCplt, -- [HP252_276_HUB_PRESTA]
		@sNewInfoFrnSpbCplt -- [DT280] -- [HP252_276_HUB_PRESTA]
From sysadm.commande c
Where c.id_sin = @dcIdSin
And   c.id_seq = @iIdSeq

If Exists ( Select * from sysadm.w_commande where id_sin = @dcIdSin   and id_seq = @iIdSeq )
 Begin
	Insert into sysadm.w_commande
	select top 1 
		id_sin,
		@iNewIdSeq, 
		id_gti, 
		@dcNewIdDetail, 
		c.id_four,  -- [DT280]
		@sTypeAppSin,
		@sMarqRempl, -- [HP252_276_HUB_PRESTA]
		@sModlRempl, -- [HP252_276_HUB_PRESTA]
		Convert ( Decimal ( 11, 2 ), sysadm.FN_CLE_VAL ( 'MTTTCSW', @sInfoFrnSpbCplt, ';' )), 
		adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, 
		'', null,  
		@sIdSerieNouv, 
		@sIdBonTransp,
		null,
		@dtDteEnvCli, 
		'RPC', 
		Convert ( VarChar ( 10), GetDate(), 103) + '=>Commande de remplacement automatique suite SWAP ' + sysadm.FN_CODE_CAR ( c.id_four, '-FR') + '.', -- [DT280]
		1, 'PRESTA AUTOMATIQUE', Getdate(), Getdate(), 'AUTO',  id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'REMPL_SWAP_CTR', id_orian_marque, id_orian_modele, dte_elv_mobile, 
		178, 
		dte_emis_devis, mt_devis, alt_dev_acp, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, @iInfoSpbFrn, 
		IIF ( @iMarqModlIFr > 0, @sMarqRempl, null ), -- [HP252_276_HUB_PRESTA]
		IIF ( @iMarqModlIFr > 0, @sModlRempl, null ), -- [HP252_276_HUB_PRESTA]
		@sNewInfoSpbFrnCplt, -- [HP252_276_HUB_PRESTA]
		@sNewInfoFrnSpbCplt -- [DT280] -- [HP252_276_HUB_PRESTA]
	From sysadm.w_commande c
	Where c.id_sin = @dcIdSin
	And   c.id_seq = @iIdSeq
 End 

Exec sysadm.PS_I_PEC_A_RECYCLER_PM330 @dcIdSin
			
-- On coupe le trigger pour les prochains passage
Update 	sysadm.w_commande
Set	info_frn_spb_cplt = sysadm.FN_CLE_VAL_E ( 'TGR_APPSW', 'NON', rtrim ( wc.info_frn_spb_cplt ) , ';')  
From    sysadm.w_commande wc
Where	wc.id_sin = @dcIdSin
And		wc.id_seq = @iIdSeq		

Update 	sysadm.commande
Set	info_frn_spb_cplt = sysadm.FN_CLE_VAL_E ( 'TGR_APPSW', 'NON', rtrim ( c.info_frn_spb_cplt ) , ';')  
From    sysadm.commande c
Where	c.id_sin = @dcIdSin
And		c.id_seq = @iIdSeq		


-- Contact, sans travail !!!
-- [DT280]
Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'SWAP CTR : Remplacement de l''appareil sinistré directement effectué par ' + @sLibFour + '. Commande de remplacement créée par le système.'

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
END
ELSE
BEGIN
	Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
END

-- Trt pour affection marque/modèle IFR
-- [HP252_276_HUB_PRESTA]
If @iPrestaHUB > 0 
	Begin 
	   -- [HP252_276_HUB_PRESTA]
	   Set @iMarqModlIFr = 0
	   If Exists  (
			Select top 1 1 From sysadm.ifr i
			Where i.marque = @sMarqRempl
			And   i.reference = @sModlRempl
	   ) 
		Begin
			Set @iMarqModlIFr = 1
		End 

	   If @iMarqModlIFr = 0 
		Begin
		   Select @TypArtIfr = 
				  '#' + ( 
				   Select stuff ( 
							( SELECT Distinct '#' + CAST(rtrim ( ltrim ( rtrim ( i.sku_saga )) ) AS VARCHAR(250)) 
							  FROM sysadm.ifr i
							  Where sku_saga is not null
							  For XML PATH ('') )
						, 1, 1, '' )) + '#'
		 End 

		Update 	sysadm.w_commande
		Set	
			id_marq_art_ifr = 
				Case 
					When @iMarqModlIFr > 0 Then @sMarqRempl -- [HP252_276_HUB_PRESTA]

					Else 
							(	Select Top 1 rtrim (la.marq_ifr ) 
								from sysadm.lien_article la 
								Where la.id_four = 'HUP'
								And la.marq_four = Left ( @sMarqRempl, 35)
								And la.modl_four = Left ( @sModlRempl, 35)
							)

				End,		
			id_modl_art_ifr =
				Case 
					When @iMarqModlIFr > 0 Then @sModlRempl -- [HP252_276_HUB_PRESTA]

					Else
							(	Select Top 1 rtrim (la.modl_ifr ) 
								from sysadm.lien_article la 
								Where la.id_four = 'HUP'
								And la.marq_four = Left ( @sMarqRempl, 35)
								And la.modl_four = Left ( @sModlRempl, 35)
							)

				End

		From    sysadm.w_commande wc
		Where	wc.id_sin = @dcIdSin
		And		wc.id_seq = @iNewIdSeq		

		Update 	sysadm.commande
		Set	
			id_marq_art_ifr = 
				Case 
					When @iMarqModlIFr > 0 Then @sMarqRempl -- [HP252_276_HUB_PRESTA]

					Else 
							(	Select Top 1 rtrim (la.marq_ifr ) 
								from sysadm.lien_article la 
								Where la.id_four = 'HUP'
								And la.marq_four = Left ( @sMarqRempl, 35)
								And la.modl_four = Left ( @sModlRempl, 35)
							)

				End,		
			id_modl_art_ifr =
				Case 
					When @iMarqModlIFr > 0 Then @sModlRempl -- [HP252_276_HUB_PRESTA]

					Else
							(	Select Top 1 rtrim (la.modl_ifr ) 
								from sysadm.lien_article la 
								Where la.id_four = 'HUP'
								And la.marq_four = Left ( @sMarqRempl, 35)
								And la.modl_four = Left ( @sModlRempl, 35)
							)

				End

		From    sysadm.commande wc
		Where	wc.id_sin = @dcIdSin
		And		wc.id_seq = @iNewIdSeq	

		If Not Exists (
				Select Top 1 1 
				From sysadm.article a
				Where ( a.id_four = @sIdFour Or ( @iPrestaHUB > 0 And a.id_four = 'HUP' )) -- [HP252_276_HUB_PRESTA]
				And   a.id_marq_art = Left ( @sMarqRempl, 35)
				And   a.id_modl_art = Left ( @sModlRempl, 35)
					  )
		   And CHARINDEX ( '#' + @sTypeAppSin + '#', @TypArtIfr ) > 0 -- [HP252_276_HUB_PRESTA]
		   And @iMarqModlIFr <= 0 -- [HP252_276_HUB_PRESTA]

			Begin
				Set @sNewIdRefFour = Replace ( Replace ( Replace ( convert( varchar ( 30), GetDate(), 120 ), '-', ''), ' ', ''), ':', '')
				Set @sNewIdRefFourTest = @sNewIdRefFour 

				Set @iCptId = 1
				Set @sNewIdRefFourTest = @sNewIdRefFour + '_' + convert ( varchar (5), @iCptId )

				While Exists ( Select Top 1 1
								From sysadm.article a with (nolock)
								Where a.id_four = @sIdFour
								And   a.id_ref_four = @sNewIdRefFourTest )
					Begin
						Set @iCptId = @iCptId + 1
						Set @sNewIdRefFourTest = @sNewIdRefFour + '_' + convert ( varchar (5), @iCptId )
					End

				Insert into sysadm.article 
				Select	'HUP',
						@sNewIdRefFourTest,
						@sTypeAppSin, -- [HP252_276_HUB_PRESTA]
						Left ( @sMarqRempl, 35),
						Left ( @sModlRempl, 35),
						0,
						0,
						20000,
						null,
						'N',
						(	Select Top 1 rtrim ( la.marq_ifr ) 
							from sysadm.lien_article la 
							Where  la.id_four = 'HUP' -- [HP252_276_HUB_PRESTA]
							And la.marq_four = Left ( @sMarqRempl, 35)
							And la.modl_four = Left ( @sModlRempl, 35)
							),
						(	Select Top 1 rtrim ( la.modl_ifr ) 
							from sysadm.lien_article la 
							Where  la.id_four = 'HUP' -- [HP252_276_HUB_PRESTA]
							And la.marq_four = Left ( @sMarqRempl, 35)
							And la.modl_four = Left ( @sModlRempl, 35)
							),
						200,
						1,
						getdate(),
						getdate(),
						'JFF'

			End 
	End 

Go

grant execute on sysadm.PS_I_COMMANDE_DT276_SWAP_CTR to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_COMMANDE_APP_INCOMPLET_CORDON
-- Auteur               :       Fabry JF
-- Date                 :       18/09/2017
-- Libelle              :       [DT288-3_LOT2]
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      26/04/2023   [RS5045_REF_MATP]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_COMMANDE_APP_INCOMPLET_CORDON' AND type = 'P' )
        DROP procedure sysadm.PS_I_COMMANDE_APP_INCOMPLET_CORDON
GO

CREATE procedure sysadm.PS_I_COMMANDE_APP_INCOMPLET_CORDON
	@adcIdSin Decimal ( 10 ),
	@adcIdGti Decimal ( 7 )
AS

Declare @sCodOper       Varchar (  4   )
Declare @sNoBoite       Varchar ( 10   )
Declare @sProc          Varchar ( 60   )
Declare @dtValideLe     DateTime        
Declare @sMethode	VarChar ( 3 )
Declare @iRet Integer
Declare @dcIdInter Decimal ( 2,0 )
Declare @sCodeMaquette VarChar ( 255 )
Declare @iIdXml    Integer
Declare @sTypMail  VarChar ( 6 ) 
Declare @sTypApp  VarChar ( 10 ) 
Declare @sAdrMail VarChar ( 255 ) 
Declare @sNomLivraison Varchar ( 71 ) 
Declare @sAdr1Livraison Varchar ( 35 ) 
Declare @sAdr2Livraison Varchar ( 35 ) 
Declare @sCpVilleLivraison Varchar ( 50 ) 
Declare @sAdrMailCC Varchar ( 255 )
Declare @sXMLVar    VarChar (max)
Declare @sIdAppli  Varchar ( 20 ) 
Declare @iIdSin Integer
Declare @iIdProd Integer
Declare @iIdEts Integer
Declare @dcIdProd     Decimal (7)
Declare @dcIdEts 	 Decimal (7) 
Declare @iOptionDP    Integer
Declare @sLibProd     VarChar (255) 
Declare @sAltQuarant  VarChar (1)
Declare @sNumProd     VarChar (20)   
Declare @sCiv		VarChar (20) 
Declare @sNom		VarChar ( 71 )
Declare @sMailFrom	VarChar (128) 
Declare @sMailSend	VarChar (128) 
Declare @sMailCc	VarChar (128)
Declare @sMailObjet	VarChar ( 255 )
Declare @sBoiteMail   VarChar (35)
Declare @sMailBody	VarChar ( 7000 )
Declare @sErrOutPut VarChar ( 255 ) 

/*
If Exists ( 
	Select Top 1 1
	From   sysadm.sinistre s
	Where  s.id_sin = @adcIdSin
	And    s.cod_etat in ( 550, 600 ) 
	)
	Begin
		Return
	End 
*/

Delete sysadm.w_refus where id_sin = @adcIdSin and id_motif = 1655
Delete sysadm.refus where id_sin = @adcIdSin and id_motif = 1655

Insert into sysadm.w_refus 
Select  Top 1
		@adcIdSin,
		@adcIdGti,
		-1,
		mt.id_motif,
		'O',
		'N',
		null, 
		mt.id_para,
		mt.cpt_tri,
		GETDATE (),
		GETDATE (),
		'AUTO'
From	sysadm.w_sin ws,
		sysadm.motif mt
Where   ws.id_sin = @adcIdSin
And     mt.id_prod = ws.id_prod
And     mt.id_gti = @adcIdGti
And     mt.id_motif = 1655

Insert into sysadm.refus 
Select  Top 1
		@adcIdSin,
		@adcIdGti,
		-1,
		mt.id_motif,
		'O',
		'N',
		null, 
		mt.id_para,
		GETDATE (),
		'AUTO',
		GETDATE (),
		GETDATE (),
		'AUTO'
From	sysadm.sinistre ws,
		sysadm.motif mt
Where   ws.id_sin = @adcIdSin
And     mt.id_prod = ws.id_prod
And     mt.id_gti = @adcIdGti
And     mt.id_motif = 1655


Delete sysadm.w_div_sin where id_sin = @adcIdSin and nom_zone = 'cour_app_incomplet_ref_a_reexp'
Delete sysadm.div_sin where id_sin = @adcIdSin and nom_zone = 'cour_app_incomplet_ref_a_reexp'

-- [RS5045_REF_MATP] à supp par la suite
If NOT (sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 )
	Begin 
	-- Tag déclencheur courrier
		Insert into sysadm.w_div_sin 
		(
		id_sin,
		nom_zone,
		lib_label,
		id_typ_liste,
		alt_liste_codecar,
		id_typ_zone,
		alt_oblig,
		alt_prot,
		cpt_tri,
		val_nbre,
		val_mt,
		val_dte,
		val_car,
		cpt_valide,
		cree_le,
		maj_le,
		maj_par
		)
		Values 
		(
		@adcIdSin,
		'cour_app_incomplet_ref_a_reexp',
		'Cour.App.Incomplet.Ref.A.Reexp',
		-1,
		'N',
		'C',
		'N',
		'O',
		800,
		null,
		null,
		null,
		'Information_client', -- Code maquette donné par EPG (NT)
		0,
		getdate (),
		Getdate (),
		'AUTO'
		)
	End 

Update sysadm.w_detail
Set cod_dec_mac = 200, 
	cod_dec_ope = 200, 
	cod_etat = 200, 
	alt_att = 'N',
	alt_ssui = 'N',
	cod_mot_ssui = 0,
	maj_le = getdate(),
	alt_valide = 'O',
	maj_par = 'AUTO'
Where id_sin = 	@adcIdSin
And   id_gti =  @adcIdGti

Update sysadm.w_gar_sin 
Set cod_dec_mac = sysadm.FN_GET_ETAT_GARANTIE_PM251 ( @adcIdSin , @adcIdGti, 'W') 
Where id_sin = 	@adcIdSin
And   id_gti =  @adcIdGti

Update sysadm.w_gar_sin
set	cod_dec_ope = cod_dec_mac,
	cod_etat = cod_dec_mac,
	alt_valide = 'O',
	maj_le = getdate(),
	maj_par = 'AUTO'
Where  id_sin = @adcIdSin
And    id_gti = @adcIdGti

Update sysadm.w_sin
Set	cod_dec_mac = sysadm.FN_GET_ETAT_DOSSIER_PM251 ( @adcIdSin, 'W' )
Where  id_sin = @adcIdSin

Update sysadm.w_sin
Set	cod_dec_ope = cod_dec_mac,
	cod_etat = cod_dec_mac,
	maj_le = getdate(),
	maj_par = 'AUTO'
Where  id_sin = @adcIdSin	

-- Le travail doit être occupé !!
Update w_queue set alt_occupe = 'O' where id_sin = @adcIdSin


--  Validation
Set @sCodOper = 'AUTO'
Set @sNoBoite = ''
Set @sProc = Space ( 35 )
Set @dtValideLe = getdate()
set @sMethode = 'SVE'


Exec @iRet = sysadm.PS_VALIDATION
		@adcIdSin,
		@sCodOper,
		@sNoBoite,
		@sProc OUTPUT,
		@dtValideLe OUTPUT,
		@sMethode

Delete sysadm.w_queue Where id_sin = @adcIdSin
Update sysadm.routage Set alt_queue = 'N', cod_travail = 'CPL' Where id_sin = @adcIdSin

-- Je ne lance pas la PS de trace de validation, car la PS est appelle par PS_U01_COMMANDE et donc tracé à la fin.

Exec sysadm.PS_I_REFUSE_A_REEXP_PM330 @adcIdSin

-- [RS5045_REF_MATP] à supp par la suite
If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 
	Begin 
		Set @sIdAppli = 'SIMPA2'
		Set @iOptionDP = -1

		Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
			@adcIdSin,
			@iOptionDP,
			@dcIdProd   OUTPUT,
			@sLibProd   OUTPUT,
			@dcIdEts    OUTPUT,
			@sNumProd   OUTPUT,
			@sCiv	    OUTPUT,
			@sNom	    OUTPUT,
			@sMailFrom  OUTPUT,
			@sMailSend  OUTPUT,
			@sMailCc    OUTPUT,
			@sAltQuarant OUTPUT,
			@sBoiteMail  OUTPUT,
			@sXMLVar     OUTPUT

		-- Armement du corps du mail 
		Set @sMailObjet = 'Corps de l''Objet construit par KSL'
		Set @sMailBody  = 'Corps du mail construit par KSL'

		-- On convertit pour l'appel de la PS
		Set @iIdSin  = Convert ( integer, @adcIdSin )
		Set @iIdProd = Convert ( integer, @dcIdProd )
		Set @iIdEts  = Convert ( integer, @dcIdEts )
		Set @sAltQuarant = 'N'

		Select @dcIdInter = id_i From sysadm.inter where id_sin = @adcIdSin and cod_inter = 'A'
		If @dcIdInter is null Set @dcIdInter = 0

		Set @sTypMail = 'INCCOR' -- TM TRACE_MAIL_PRO Code_car
		
		Select 	@sTypApp = 
			Case When Exists (select * from sysadm.commande w where w.id_sin=@adcIdSin and w.id_typ_art='PRS' and w.cod_etat <> 'ANN') 
				Then 'repa' 
			Else 'rempl' 
		End 
		
		Select @sAdrMail = 
			Case -- [DT346]
				When Exists ( 
						Select Top 1 1 
						From   sysadm.div_sin ds,
							   sysadm.det_pro dp,
							   sysadm.sinistre s
						Where  ds.id_sin = @adcIdSin
						And	   ds.nom_zone = 'client_vip'
						And	   ds.val_car = 'VIPPAR'
						And	   s.id_sin = ds.id_sin 
						And	   dp.id_prod = s.id_prod
						And    dp.id_code_dp = 272
					)	Then 'laura.naulot@orange.com,desk@parnasse.fr'
			 Else null
			End 

		Select @sNomLivraison = i.nom,
			   @sAdr1Livraison = i.adr_1,
			   @sAdr2Livraison = i.adr_2,
			   @sCpVilleLivraison = IsNull ( i.adr_cp, '') + ' ' + IsNull ( i.adr_ville, '' ) 
		From sysadm.inter i
		Where i.id_sin = @adcIdSin
		And i.id_i = @dcIdInter

		Select Top 1 @sAdrMailCC = 
			   Case 
				  When rtrim ( ds.val_car ) in ( 'SEN', 'SEM' ) 
					Then 'vip@orange.com,franck.bonnard@orange.com' -- [VDOC17642] [VDOC20329]	 
				  When rtrim ( ds.val_car ) in ( 'ASN' ) 
					Then 't.munier@senat.fr,franck.bonnard@orange.com' -- [VDOC17642]	 [VDOC20329]	 
				  Else ''
			   End
		From   sysadm.div_sin ds,
			   sysadm.det_pro dp,
			   sysadm.sinistre s			   
		Where  ds.id_sin = @adcIdSin
		And	   ds.nom_zone = 'client_vip'
		And	   s.id_sin = ds.id_sin 
		And	   dp.id_prod = s.id_prod
		And    dp.id_code_dp = 272

		If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
			Begin
				-- Appel Obligatoire pour déclarer le XML
				Exec @iIdXml = TRACE_MAIL_PRO.sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_SIMPA2 @adcIdSin, @dcIdInter, @iIdXml
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL @iIdXml, 'OUI', 'OUI', 'OUI'
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL @sTypMail, @sCodeMaquette OutPut

				-- Ajout personnalisé du client appelant le système
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'code_maquette', @sCodeMaquette
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'type_appareil', @sTypApp
				If @sAdrMail is not null Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adr_mail', @sAdrMail 
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'nom_livraison', @sNomLivraison
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adresse1_livraison', @sAdr1Livraison
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adresse2_livraison', @sAdr2Livraison
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'cp_ville_livraison', @sCpVilleLivraison
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adr_mail_cc', @sAdrMailCC

				-- Appel pour construire et récupérer le XML dans @xmlResult
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE @iIdXml, @sCodeMaquette, @sXMLVar OUTPUT

				Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_RS5045_I_MAIL_PUSH_KSL
					@sIdAppli,
					@iIdSin,
					@iIdProd,
					@sLibProd,
					@iIdEts,
					@sMailFrom,
					@sMailSend,
					@sMailCc,
					null,
					@sMailObjet,
					@sMailBody,
					@sBoiteMail,
					@sTypMail,
					2,
					-1,
					@sXMLVar,
					null, -- id_chem, peut être forcé mais si null, sera pris par défaut sysadm.code_maquette_ksl_rs5045
					null, -- dteh_exec
					@sErrOutPut OutPut

			End    -- TRACE_MAIL_PRO : Fin écriture

		Else
			Begin
				-- Appel Obligatoire pour déclarer le XML
				Exec @iIdXml = TRACE_MAIL_TRT.sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_SIMPA2 @adcIdSin, @dcIdInter, @iIdXml
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL @iIdXml, 'OUI', 'OUI', 'OUI'
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL @sTypMail, @sCodeMaquette OutPut

				-- Ajout personnalisé du client appelant le système
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'code_maquette', @sCodeMaquette
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'type_appareil', @sTypApp
				If @sAdrMail is not null Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adr_mail', @sAdrMail 
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'nom_livraison', @sNomLivraison
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adresse1_livraison', @sAdr1Livraison
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adresse2_livraison', @sAdr2Livraison
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'cp_ville_livraison', @sCpVilleLivraison
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adr_mail_cc', @sAdrMailCC

				-- Appel pour construire et récupérer le XML dans @xmlResult
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE @iIdXml, @sCodeMaquette, @sXMLVar OUTPUT

				Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_RS5045_I_MAIL_PUSH_KSL
					@sIdAppli,
					@iIdSin,
					@iIdProd,
					@sLibProd,
					@iIdEts,
					@sMailFrom,
					@sMailSend,
					@sMailCc,
					null,
					@sMailObjet,
					@sMailBody,
					@sBoiteMail,
					@sTypMail,
					2,
					-1,
					@sXMLVar,
					null, -- id_chem, peut être forcé mais si null, sera pris par défaut sysadm.code_maquette_ksl_rs5045
					null, -- dteh_exec
					@sErrOutPut OutPut
			End	


	End 

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_COUR_APP_INCOMPLET_CORDON
-- Auteur               :       Fabry JF
-- Date                 :       18/09/2017
-- Libelle              :       [DT288-3_LOT2]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      22/09/2016   [PM234-7][M21970]
-- JFF		26/04/2017   [DT288]
-- JFF      03/08/2017   [DF006]
-- JFF      12/02/2018   [DT346]
-- JFF      06/11/2018   [PM451-1]
-- JFF      26/04/2023   [RS5045_REF_MATP]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_COUR_APP_INCOMPLET_CORDON' AND type = 'P' )
        DROP procedure sysadm.PS_S_COUR_APP_INCOMPLET_CORDON
GO

CREATE procedure sysadm.PS_S_COUR_APP_INCOMPLET_CORDON
AS

SET NOCOUNT ON


-- [RS5045_REF_MATP]
If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0
 Begin
	-- Fin de cette méthode
	Return
 End 


Delete from sysadm.w_cour_xml_orangev3

Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      no_ligne_assuree,
      app_marque,
      app_modele,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      type_appareil,
	  code_maquette,
	  adr_mail,
	  nom_livraison,
	  adresse1_livraison,
	  adresse2_livraison,
	  cp_ville_livraison,
	  imei, -- [PM234-7][M21970]
	  maj_par, -- [PM234-7][M21970]
	  adr_mail_cc -- [DF006]
	  )
Select	
	s.id_sin, 
	sysadm.FN_CODE_NUM(pers.cod_civ,'-CI') as civilite, 
	Case When pers.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
		 Else sysadm.FN_CODE_NUM(pers.cod_civ,'-CL') 
	End as civilite_longue, 
	pers.nom,
	pers.prenom,
	pers.adr_1, 
	pers.adr_2, 
	Case pers.adr_cp When '00000' then '' Else pers.adr_cp End as adr_cp, 
	pers.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=s.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=s.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	rtrim ( sysadm.FN_LIB_CIE (s.id_sin)) as lib_compagnie,
	rtrim ( sysadm.FN_LIB_POLICE (s.id_sin)) as lib_police,
	s.num_port as num_tel_assure,
	s.marq_port,
	s.modl_port,
	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=s.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),s.dte_decl,20) as dte_decl,
	s.maj_par as code_operateur,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=s.id_sin and 
			w.id_typ_art='PRS'	and w.cod_etat <> 'ANN') Then 'repa' 
		Else 'rempl' End as type_appareil,
	IsNull ( rtrim ( ds.val_car ), '') as code_maquette,
	Case -- [DT346]
		When Exists ( 
				Select Top 1 1 
				From   sysadm.div_sin ds,
					   sysadm.det_pro dp 
				Where  ds.id_sin = s.id_sin
				And	   ds.nom_zone = 'client_vip'
				And	   ds.val_car = 'VIPPAR'
				And	   s.id_sin = ds.id_sin 
				And	   dp.id_prod = s.id_prod
				And    dp.id_code_dp = 272
			)	Then 'laura.naulot@orange.com,desk@parnasse.fr'
		Else i.adr_mail
	End 'adr_mail',
	i.nom nom_livraison,
	i.adr_1 adresse1_livraison,
	i.adr_2 adresse2_livraison,
	i.adr_cp cp_ville_livraison,
	rtrim ( s.num_imei_port ) imei, -- [PM234-7][M21970]
	rtrim ( s.maj_par ) imei, -- [PM234-7][M21970]
	(
		Select Top 1
			   Case 
				  When rtrim ( ds.val_car ) in ( 'SEN', 'SEM' ) 
					Then 'vip@orange.com,franck.bonnard@orange.com' -- [VDOC17642] [VDOC20329]	 
				  When rtrim ( ds.val_car ) in ( 'ASN' ) 
					Then 't.munier@senat.fr,franck.bonnard@orange.com' -- [VDOC17642]	 [VDOC20329]	 
				  Else ''
			   End

		From   sysadm.div_sin ds,
			   sysadm.det_pro dp 
		Where  ds.id_sin = s.id_sin
		And	   ds.nom_zone = 'client_vip'
		And	   s.id_sin = ds.id_sin 
		And	   dp.id_prod = s.id_prod
		And    dp.id_code_dp = 272
	) adr_mail_cc -- [VDOC17642][DF006]

	  
From	sysadm.sinistre s,
		sysadm.personne pers,
		sysadm.produit p,
		sysadm.inter i,
		sysadm.div_sin ds
Where   ds.nom_zone = 'cour_app_incomplet_ref_a_reexp'
And		len ( rtrim ( ds.val_car ) ) > 0 
And		Not Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_cour_app_incomplet_ref_a_reexp' )
And		ds.id_sin = s.id_sin
And		pers.id_ordre = s.id_ordre
And		p.id_prod=s.id_prod
And		i.id_sin=s.id_sin
And 	i.cod_inter='A'

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	xml_data 
From sysadm.w_cour_xml_orangev3

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_U_COUR_APP_INCOMPLET_CORDON
-- Auteur               :       Fabry JF
-- Date                 :       03/08/2016
-- Libellé              :		[DT288-3_LOT2]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      26/04/2023   [RS5045_REF_MATP]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COUR_APP_INCOMPLET_CORDON' AND type = 'P' )
        DROP procedure sysadm.PS_U_COUR_APP_INCOMPLET_CORDON
GO

CREATE procedure sysadm.PS_U_COUR_APP_INCOMPLET_CORDON
        @adcIdSin     Decimal (  7,0 ),
        @asCas 	VarChar (35) = null
AS

-- [RS5045_REF_MATP]
If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0
 Begin
	-- Fin de cette méthode
	Return
 End 

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )

-- dte_cour_pec_envksl_pm234_7
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_app_incomplet_ref_a_reexp')
	 Begin
	   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_app_incomplet_ref_a_reexp'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_cour_app_incomplet_ref_a_reexp', 'Date cour.app.incomp.Refus_A_Reexp', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, 0, getdate(), getdate(), 'EDS' ) 
	 End

	Delete sysadm.w_div_sin Where id_sin = @adcIdSin and nom_zone = 'cour_app_incomplet_ref_a_reexp'
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_app_incomplet_ref_a_reexp')
	 Begin
	   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_app_incomplet_ref_a_reexp'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_cour_app_incomplet_ref_a_reexp', 'Date cour.app.incomp.Refus_A_Reexp', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
	 End

	Delete sysadm.div_sin Where id_sin = @adcIdSin and nom_zone = 'cour_app_incomplet_ref_a_reexp'

  End
  
Set @sMess = 'Le courrier indiquant à l''assuré que son appareil va lui être renvoyé car il a été reçu incomplet, a été envoyé par KSL.'

If @asCas = 'ECHEC_DISTRIB'
	Begin

		Select	@sAdrMailErr = i.adr_mail
		From	sysadm.inter i
		Where   i.id_sin = @adcIdSin
		And		i.cod_inter = 'A'

		Set @sMess = @sMess + Char (13) + 'Echec distribution dû à une adresse mail erronée : ' + @sAdrMailErr 
		Set @sMess = @sMess + Char (13) + 'L''adresse a été effacée du dossier SIMPA2 et marquée sur SHERPA pour ne plus être utiliser sur SIMPA2.'		
	End 

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'EDS', 300, @iIdCt OUTPUT, 760
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'EDS', 300, @iIdCt OUTPUT, 760
END


If @asCas = 'ECHEC_DISTRIB'
  Begin
	Update sysadm.inter 
	Set adr_mail = null
	Where id_sin = @adcIdSin
	And   cod_inter = 'A'
	
	Update sysadm.w_inter 
	Set adr_mail = null
	Where id_sin = @adcIdSin
	And   cod_inter = 'A'
	
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin  
		Update 	SHERPA_PRO.sysadm.info_client
		Set	id_info = 53
		From	SHERPA_PRO.sysadm.sinistre s,
			SHERPA_PRO.sysadm.info_client i
		Where	s.id_sin = @adcIdSin
		And	s.id_appli = 2
		And	i.id_cli = s.id_cli
		And	i.id_info = 5
		And	lib_info = @sAdrMailErr
	 End 	 	
	 Else
	 Begin  
		Update 	SHERPA_SIM.sysadm.info_client
		Set	id_info = 53
		From	SHERPA_SIM.sysadm.sinistre s,
			SHERPA_SIM.sysadm.info_client i
		Where	s.id_sin = @adcIdSin
		And	s.id_appli = 2
		And	i.id_cli = s.id_cli
		And	i.id_info = 5
		And	lib_info = @sAdrMailErr
	 End 		
	
  End 

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_COUR_COUR_INFO_MANQ_REF_A_REEXP
-- Auteur               :       Fabry JF
-- Date                 :       25/09/2017
-- Libelle              :       [PM287-6]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      22/09/2016   [PM234-7][M21970]
-- JFF		26/04/2017   [DT288]
-- JFF      03/08/2017   [DF006]
-- JFF      12/02/2018   [DT346]
-- JFF      06/11/2018   [PM451-1
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_COUR_COUR_INFO_MANQ_REF_A_REEXP' AND type = 'P' )
        DROP procedure sysadm.PS_S_COUR_COUR_INFO_MANQ_REF_A_REEXP
GO

CREATE procedure sysadm.PS_S_COUR_COUR_INFO_MANQ_REF_A_REEXP
AS

SET NOCOUNT ON

Delete from sysadm.w_cour_xml_orangev3

Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      no_ligne_assuree,
      app_marque,
      app_modele,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      type_appareil,
	  code_maquette,
	  adr_mail,
	  nom_livraison,
	  adresse1_livraison,
	  adresse2_livraison,
	  cp_ville_livraison,
	  imei, -- [PM234-7][M21970]
	  maj_par, -- [PM234-7][M21970]
	  adr_mail_cc -- [DF006]
	  )
Select	
	s.id_sin, 
	sysadm.FN_CODE_NUM(pers.cod_civ,'-CI') as civilite, 
	Case When pers.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
		 Else sysadm.FN_CODE_NUM(pers.cod_civ,'-CL') 
	End as civilite_longue, 
	pers.nom,
	pers.prenom,
	pers.adr_1, 
	pers.adr_2, 
	Case pers.adr_cp When '00000' then '' Else pers.adr_cp End as adr_cp, 
	pers.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=s.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=s.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	rtrim ( sysadm.FN_LIB_CIE (s.id_sin)) as lib_compagnie,
	rtrim ( sysadm.FN_LIB_POLICE (s.id_sin)) as lib_police,
	s.num_port as num_tel_assure,
	s.marq_port,
	s.modl_port,
	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=s.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),s.dte_decl,20) as dte_decl,
	s.maj_par as code_operateur,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=s.id_sin and 
			w.id_typ_art='PRS'	and w.cod_etat <> 'ANN') Then 'repa' 
		Else 'rempl' End as type_appareil,
	IsNull ( rtrim ( ds.val_car ), '') as code_maquette,
	Case -- [DT346]
		When Exists ( 
				Select Top 1 1 
				From   sysadm.div_sin ds,
					   sysadm.det_pro dp 
				Where  ds.id_sin = s.id_sin
				And	   ds.nom_zone = 'client_vip'
				And	   ds.val_car = 'VIPPAR'
				And	   s.id_sin = ds.id_sin 
				And	   dp.id_prod = s.id_prod
				And    dp.id_code_dp = 272
			)	Then 'laura.naulot@orange.com,desk@parnasse.fr'
		Else i.adr_mail
	End 'adr_mail',
	i.nom nom_livraison,
	i.adr_1 adresse1_livraison,
	i.adr_2 adresse2_livraison,
	i.adr_cp cp_ville_livraison,
	rtrim ( s.num_imei_port ) imei, -- [PM234-7][M21970]
	rtrim ( s.maj_par ) imei, -- [PM234-7][M21970]
	(
		Select Top 1
			   Case 
				  When rtrim ( ds.val_car ) in ( 'SEN', 'SEM' ) 
					Then 'vip@orange.com,franck.bonnard@orange.com' -- [VDOC17642] [VDOC20329]	 
				  When rtrim ( ds.val_car ) in ( 'ASN' ) 
					Then 't.munier@senat.fr,franck.bonnard@orange.com' -- [VDOC17642]	 [VDOC20329]	 
				  Else ''
			   End

		From   sysadm.div_sin ds,
			   sysadm.det_pro dp 
		Where  ds.id_sin = s.id_sin
		And	   ds.nom_zone = 'client_vip'
		And	   s.id_sin = ds.id_sin 
		And	   dp.id_prod = s.id_prod
		And    dp.id_code_dp = 272
	) adr_mail_cc -- [VDOC17642][DF006]

	  
From	sysadm.sinistre s,
		sysadm.personne pers,
		sysadm.produit p,
		sysadm.inter i,
		sysadm.div_sin ds
Where   ds.nom_zone = 'cour_info_manquante_ref_a_reexp'
And		len ( rtrim ( ds.val_car ) ) > 0 
And		Not Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_cour_info_manquante_ref_a_reexp' )
And		ds.id_sin = s.id_sin
And		pers.id_ordre = s.id_ordre
And		p.id_prod=s.id_prod
And		i.id_sin=s.id_sin
And 	i.cod_inter='A'

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	xml_data 
From sysadm.w_cour_xml_orangev3

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U_COUR_COUR_INFO_MANQ_REF_A_REEXP
-- Auteur               :       Fabry JF
-- Date                 :       25/09/2017
-- Libellé              :		[PM287-6]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COUR_COUR_INFO_MANQ_REF_A_REEXP' AND type = 'P' )
        DROP procedure sysadm.PS_U_COUR_COUR_INFO_MANQ_REF_A_REEXP
GO

CREATE procedure sysadm.PS_U_COUR_COUR_INFO_MANQ_REF_A_REEXP
        @adcIdSin     Decimal (  7,0 ),
        @asCas 	VarChar (35) = null
AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )

-- dte_cour_pec_envksl_pm234_7
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_info_manquante_ref_a_reexp')
	 Begin
	   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_info_manquante_ref_a_reexp'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_cour_info_manquante_ref_a_reexp', 'Date cour.info.manq.Refus_A_Reexp', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, 0, getdate(), getdate(), 'EDS' ) 
	 End

	Delete sysadm.w_div_sin Where id_sin = @adcIdSin and nom_zone = 'cour_info_manquante_ref_a_reexp'
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_info_manquante_ref_a_reexp')
	 Begin
	   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_info_manquante_ref_a_reexp'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_cour_info_manquante_ref_a_reexp', 'Date cour.info.manq.Refus_A_Reexp', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
	 End

	Delete sysadm.div_sin Where id_sin = @adcIdSin and nom_zone = 'cour_info_manquante_ref_a_reexp'

  End
  
Set @sMess = 'Le courrier indiquant à l''assuré que son appareil va lui être renvoyé car n''a pas fait les actions nécessaires sur l''extranet liés aux données manquantes, a été envoyé par KSL.'

If @asCas = 'ECHEC_DISTRIB'
	Begin

		Select	@sAdrMailErr = i.adr_mail
		From	sysadm.inter i
		Where   i.id_sin = @adcIdSin
		And		i.cod_inter = 'A'

		Set @sMess = @sMess + Char (13) + 'Echec distribution dû à une adresse mail erronée : ' + @sAdrMailErr 
		Set @sMess = @sMess + Char (13) + 'L''adresse a été effacée du dossier SIMPA2 et marquée sur SHERPA pour ne plus être utiliser sur SIMPA2.'		
	End 

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'EDS', 300, @iIdCt OUTPUT, 760
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'EDS', 300, @iIdCt OUTPUT, 760
END


If @asCas = 'ECHEC_DISTRIB'
  Begin
	Update sysadm.inter 
	Set adr_mail = null
	Where id_sin = @adcIdSin
	And   cod_inter = 'A'
	
	Update sysadm.w_inter 
	Set adr_mail = null
	Where id_sin = @adcIdSin
	And   cod_inter = 'A'
	
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin  
		Update 	SHERPA_PRO.sysadm.info_client
		Set	id_info = 53
		From	SHERPA_PRO.sysadm.sinistre s,
			SHERPA_PRO.sysadm.info_client i
		Where	s.id_sin = @adcIdSin
		And	s.id_appli = 2
		And	i.id_cli = s.id_cli
		And	i.id_info = 5
		And	lib_info = @sAdrMailErr
	 End 	 	
	 Else
	 Begin  
		Update 	SHERPA_SIM.sysadm.info_client
		Set	id_info = 53
		From	SHERPA_SIM.sysadm.sinistre s,
			SHERPA_SIM.sysadm.info_client i
		Where	s.id_sin = @adcIdSin
		And	s.id_appli = 2
		And	i.id_cli = s.id_cli
		And	i.id_info = 5
		And	lib_info = @sAdrMailErr
	 End 		
	
  End 

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_MAJ_NOM_FICHIER_DS_PRESTA
-- Auteur               :       Fabry JF
-- Date                 :       21/06/2018
-- Libelle              :        
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_MAJ_NOM_FICHIER_DS_PRESTA' AND type = 'P' )
        DROP procedure sysadm.PS_U_MAJ_NOM_FICHIER_DS_PRESTA
GO

CREATE procedure sysadm.PS_U_MAJ_NOM_FICHIER_DS_PRESTA
        @dcIdSin        Decimal (  10, 0 ), -- [PI062]
		@iIdSeq			Integer,
		@sNomFic		varchar  ( 100 )
AS

Update sysadm.w_commande 
Set info_spb_frn_cplt = Left ( sysadm.FN_CLE_VAL_E ( 'FLUX', @sNomFic, rtrim ( IsNull ( info_spb_frn_cplt, '') ), ';'), 800 )
Where id_sin = @dcIdSin
And   id_seq = @iIdSeq

Update sysadm.commande 
Set info_spb_frn_cplt = Left ( sysadm.FN_CLE_VAL_E ( 'FLUX', @sNomFic, rtrim ( IsNull ( info_spb_frn_cplt, '') ), ';'), 800 )
Where id_sin = @dcIdSin
And   id_seq = @iIdSeq

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_I_CREER_PRESTA_REMPL_AAS
-- Auteur               :       Fabry JF
-- Date                 :       21/06/2018
-- Libelle              :        
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_CREER_PRESTA_REMPL_AAS' AND type = 'P' )
        DROP procedure sysadm.PS_I_CREER_PRESTA_REMPL_AAS
GO

CREATE procedure sysadm.PS_I_CREER_PRESTA_REMPL_AAS
        @dcIdSin        Decimal (  10, 0 ), -- [PI062]
		@dcIdGti		Decimal ( 7 ),
		@dcIdDetail		Decimal ( 7 ),
		@iIdSeq			Integer,
		@dcIdProd		Decimal( 7 ),
		@dcIdRev		Decimal( 7 ),
		@sInfoFrnSpbCplt varchar ( 800 ),
		@sIdFour		varchar (3 )
AS

Declare @dcNewIdDetail Decimal ( 7 )
Declare @iNewIdSeq Integer
Declare @dcMtPecPlaf Decimal ( 11,2 )
Declare @asCasRetour VarChar ( 50 )
Declare @sMess			VarChar ( 2000 )
Declare @iIdCt			integer		
 
 -- Création Commande de remplacement
	Select	@dcNewIdDetail = max ( id_detail ) 
	From	sysadm.detail
	where   id_sin = @dcIdSin
	and     id_gti = @dcIdGti 

	If @dcNewIdDetail is null Set @dcNewIdDetail = 0
	Set @dcNewIdDetail = @dcNewIdDetail + 1

	Insert into sysadm.detail 
	Select id_sin,   id_gti,   @dcNewIdDetail,   936,   id_reg,   id_i_reg,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej,   mt_fran,   mt_nplaf,   mt_plaf,   alt_plaf,   alt_reg,   'O',   alt_ssui,   cod_mot_ssui,   cod_dec_mac,   cod_dec_ope,   cod_etat,   id_carte,   id_type_carte,   getdate(),   'AUTO',   getdate(),   getdate(),   'AUTO',   dte_cmd,   dte_livr,   mt_val_achat,   mt_val_publique,   num_facture
	From sysadm.detail d
	Where d.id_sin = @dcIdSin
	And   d.id_gti = @dcIdGti
	And   d.id_detail = @dcIdDetail

	If Exists ( Select * from w_detail where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
		Begin
		Insert into sysadm.w_detail 
		Select id_sin,   id_gti,   @dcNewIdDetail,   936,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej,   mt_fran,   mt_nplaf,   mt_plaf,   null, 'N', 'N', alt_plaf,   alt_reg,   'O', alt_valide,  1,  alt_ssui,   cod_mot_ssui,   cod_dec_mac,   cod_dec_ope,   cod_etat,   id_carte,   id_type_carte, getdate(),   getdate(),   'AUTO',   dte_cmd,   dte_livr,   mt_val_achat,   mt_val_publique,   num_facture
		From sysadm.w_detail d
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail
		End 


	Insert into sysadm.div_det 
	Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, getdate(), getdate(),  'AUTO', getdate(), 'AUTO'
	From sysadm.div_det d
	Where d.id_sin = @dcIdSin
	And   d.id_gti = @dcIdGti
	And   d.id_detail = @dcIdDetail

	If Exists ( Select * from w_div_det where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
		Begin
		Insert into sysadm.w_div_det 
		Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, 1, getdate(),   getdate(), 'AUTO'
		From sysadm.w_div_det d
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail			  
		End 

	-- [MANTIS11520][PC13419]
	Select @dcMtPecPlaf = d.val_mt
	From sysadm.div_det d
	Where d.id_sin = @dcIdSin
	And   d.id_gti = @dcIdGti
	And   d.id_detail = @dcIdDetail
	And   d.nom_zone = 'mt_pec'
		
	If @dcMtPecPlaf is null Set @dcMtPecPlaf = 0
	
	Exec sysadm.PS_U01_COMMANDE_PLAF @dcIdSin, @dcIdProd, @dcIdRev, @dcIdGti, 936, 721, @dcMtPecPlaf, @sInfoFrnSpbCplt, @dcMtPecPlaf OUTPUT					 
		 
	Update sysadm.div_det
	Set val_mt = @dcMtPecPlaf
	Where id_sin = @dcIdSin
	And   id_gti = @dcIdGti
	And   id_detail = @dcNewIdDetail	 
		
	Update sysadm.w_div_det
	Set val_mt = @dcMtPecPlaf
	Where id_sin = @dcIdSin
	And   id_gti = @dcIdGti
	And   id_detail = @dcNewIdDetail	 
	-- [MANTIS11520][PC13419]

	Select @iNewIdSeq = max ( id_seq ) From commande where id_sin = @dcIdSin

	If @iNewIdSeq is null Set @iNewIdSeq = 0
	Set @iNewIdSeq = @iNewIdSeq + 1
		
	Insert into commande
	select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, 'AAS', 'CAF', 'REMPLACEMENT APPAREIL AAS', '', mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, '', null,  null, null, null, null, 'ECT', null, 'PRESTA AUTOMATIQUE', 0, null, null, Getdate(), Getdate(), 'AUTO',  Getdate(),  'AUTO', id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'REMPL_AAS', id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, alt_dev_acp, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, 0, null, null, '', ''
	From commande c
	Where c.id_sin = @dcIdSin
	And   c.id_seq = @iIdSeq

	If Exists ( Select * from w_commande where id_sin = @dcIdSin   and id_seq = @iIdSeq )
		Begin
			Insert into w_commande
			select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, 'AAS', 'CAF', 'REMPLACEMENT APPAREIL AAS', '', mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, '', null,  null, null, null, null, 'ECT', null, 1, 'PRESTA AUTOMATIQUE', Getdate(), Getdate(), 'AUTO',  id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'REMPL_AAS', id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, alt_dev_acp, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, 0, null, null, '', ''
			From w_commande c
			Where c.id_sin = @dcIdSin
			And   c.id_seq = @iIdSeq
		End 
		  
	-- [MANTIS11520][PC13419]
	Update sysadm.commande
	Set mt_ttc_cmde = @dcMtPecPlaf
	Where id_sin = @dcIdSin
	And   id_seq = @iNewIdSeq	 
		
	Update sysadm.w_commande
	Set mt_ttc_cmde = @dcMtPecPlaf
	Where id_sin = @dcIdSin
	And   id_seq = @iNewIdSeq	 
	-- [MANTIS11520][PC13419]			  				


-- Contact
	Set @sMess = 'Message automatique suite retour fournisseur : Attention, dossier bris visible irréparable économique, commande de remplacement automatiquement émise vers Advise Affinity Services'

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT							
		END
	ELSE
		BEGIN
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT							
		END	

-- Mail vers AAS
	Exec sysadm.PS_I_MAILPUSH_DT363_REMPL_AAS @dcIdSin, @iNewIdSeq, @dcIdProd, -1, '-1'

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U_COMMANDE_AAS
-- Auteur               :       FPI	
-- Date                 :       06/08/2018
-- Libelle              :        
-- Commentaires         :       [DT363]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COMMANDE_AAS' AND type = 'P' )
        DROP procedure sysadm.PS_U_COMMANDE_AAS
GO

CREATE procedure sysadm.PS_U_COMMANDE_AAS
        @dcIdSin        Decimal (  10, 0 ), 
		@iIdSeq			Integer,
		@sMarq		Varchar ( 35 ),
		@sModl		Varchar ( 35 ),
		@sMarqIfr		Varchar ( 35 ),
		@sModlIfr		Varchar ( 35 ),
		@sIdSerieNouv	Varchar(60),
		@dcMtTTCCmde	Decimal(11,2)		
As
	
	Update w
	Set id_marq_art=ISNULL(@sMarq, id_marq_art),
		id_modl_art=ISNULL(@sModl, id_modl_art),
		id_marq_art_ifr=ISNULL(@sMarqIfr, id_marq_art_ifr),
		id_modl_art_ifr=ISNULL(@sModlIfr, id_modl_art_ifr),
		id_serie_nouv=ISNULL(@sIdSerieNouv, id_serie_nouv),
		mt_ttc_cmde=ISNULL(@dcMtTTCCmde, mt_ttc_cmde),
		id_typ_art=d.val_car
	from sysadm.w_commande w
		inner join sysadm.w_div_sin d on d.id_sin=w.id_sin
	Where w.id_sin=@dcIdSin and w.id_seq=@iIdSeq 
		and d.nom_zone='type_app'

	Update c
	Set id_marq_art=ISNULL(@sMarq, id_marq_art),
		id_modl_art=ISNULL(@sModl, id_modl_art),
		id_marq_art_ifr=ISNULL(@sMarqIfr, id_marq_art_ifr),
		id_modl_art_ifr=ISNULL(@sModlIfr, id_modl_art_ifr),
		id_serie_nouv=ISNULL(@sIdSerieNouv, id_serie_nouv),
		mt_ttc_cmde=ISNULL(@dcMtTTCCmde, mt_ttc_cmde),
		id_typ_art=d.val_car
	from sysadm.commande c
		inner join sysadm.div_sin d on d.id_sin=c.id_sin
	Where c.id_sin=@dcIdSin and c.id_seq=@iIdSeq
		and d.nom_zone='type_app'

GO

grant execute on sysadm.PS_U_COMMANDE_AAS to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_XML_COUR_COMMANDE_CMA
-- Auteur               :       FPI	
-- Date                 :       16/08/2018
-- Libelle              :        Sélection des mails chapeaux à envoyer aux clients
-- Commentaires         :       [DT339]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_XML_COUR_COMMANDE_CMA' AND type = 'P' )
        DROP procedure sysadm.PS_S_XML_COUR_COMMANDE_CMA
GO

CREATE PROCEDURE sysadm.PS_S_XML_COUR_COMMANDE_CMA
As
select c.id_sin, c.id_seq,
'<?xml version="1.0" encoding="UTF-8" standalone="no" ?>' + 
'<S xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' + (
Select	p.id_prod 'C/@Code_produit',
	( Select ltrim ( rtrim ( dp.val_car)) 
	  From sysadm.det_pro dp
	  Where dp.id_prod = s.id_prod
	  And   dp.id_code_dp = 66 ) 'C/@Nom_produit',
	rtrim(co.lib_cie) 'C/@Nom_assureur',
	rtrim(po.lib_police) 'C/@Num_police',
	( Select rtrim ( IsNull ( sysadm.FN_CODE_NUM ( c.adr_cod_civ, '-CI' ), '') ) + ' ' + 
		rtrim ( IsNull ( c.adr_prenom, '') ) + ' ' + rtrim ( IsNull ( c.adr_nom, '') ) ) 'C/@Adresse_postale_1',
	rtrim(c.adr_livr1) 'C/@Adresse_postale_2',
	rtrim(c.adr_livr2) 'C/@Adresse_postale_3',
	rtrim(c.adr_livr_cpl) 'C/@Adresse_postale_4',
	rtrim ( IsNull ( c.adr_cp, '' ))  + ' ' + rtrim ( IsNull ( c.adr_ville, '' )) 'C/@Adresse_postale_5',
	convert ( Varchar , null ) 'C/@Adresse_postale_6',
	c.cmd_gen_le 'C/@Edition_date',
	'Le Havre' 'C/@Edition_lieu',
	rtrim(s.id_adh) 'C/@Num_dossier',
	Case 
		When Exists ( 
			  Select * 
			  From sysadm.det_pro dp
			  Where dp.id_prod = s.id_prod
			  And   dp.id_code_dp = 66 
			  ) Then
				( Select ltrim ( rtrim ( dp.val_car)) 
				  From sysadm.det_pro dp
				  Where dp.id_prod = s.id_prod
				  And   dp.id_code_dp = 66 ) 
		Else ( Select top 1 pr.lib_long 
			   From sysadm.produit pr
			   Where pr.id_prod = s.id_prod )
	End 'C/@Nom_contrat',
	rtrim(p.num_tel) 'C/@Rens_telephone',
	rtrim(p.num_fax) 'C/@Rens_fax',
	'garantietv@spb.fr' 'C/@Mail_exp',
	Rtrim(c.adr_mail) 'C/@Mail_Add_Dest',
	'Sabine_Tourville@carrefour.com;suivi_carrefour@spb.eu;mathilde_roux@carrefour.com;marc_barbesange@carrefour.com' 'C/@Mail_Copie_a_1',
	'O' 'C/@Mail_canal',
	rtrim(c.nom_gest) 'C/@Ut_Resp_edition',
	convert(varchar(20),c.cmd_gen_le,120) 'C/@Generation_Doc_Tstamp',
	'N' 'C/@Annule_et_remplace',
	'BACH' 'C/@Acte_gestion_code',
	'ENVOI_BACH_MAIL' 'C/@Maq_code',
	( Select IsNull ( sysadm.FN_CODE_NUM ( c.adr_cod_civ, '-CL' ), ''))  'C/@Civilite_longue',
	c.id_sin 'Sinistre/commun/@id_sin',
	( Select IsNull ( dd.val_mt, 0 )
	  From sysadm.div_det dd
	  where dd.id_sin = c.id_sin
	  And   dd.id_gti = c.id_gti
	  And   dd.id_detail = c.id_detail 
	  And   dd.nom_zone = 'mt_pec' ) 'Sinistre/virement/@mt_reg'
From sysadm.produit p,
	sysadm.sinistre s,
	sysadm.garantie g,
	sysadm.police po,
	sysadm.compagnie co
	
Where   s.id_sin = c.id_sin
and     p.id_prod = s.id_prod
and	g.id_prod = s.id_prod
and     g.id_rev = s.id_rev
and     g.id_gti = c.id_gti
and	po.id_police = g.id_police
and	co.id_cie = po.id_cie

for xml path('Doc')) +
'</S>' as xml_data 
from sysadm.commande c
Where   c.id_four = 'CMA'
and 	c.id_lot_cmd =  0  
and		cod_etat <> 'ANN'
and sysadm.FN_CLE_VAL('TYPE_ENVOI',c.info_spb_frn_cplt,';')='DEMATERIALISE'
and c.info_spb_frn_cplt not like '%ENVOI_MAIL_CLIENT%'
Go

grant execute on sysadm.PS_S_XML_COUR_COMMANDE_CMA to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_MAIL_COMMANDE_CMA
-- Auteur               :       FPI	
-- Date                 :       16/08/2018
-- Libelle              :        Mise à jour suite envoi des mails chapeaux à envoyer aux clients
-- Commentaires         :       [DT339]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_MAIL_COMMANDE_CMA' AND type = 'P' )
        DROP procedure sysadm.PS_U_MAIL_COMMANDE_CMA
GO

CREATE PROCEDURE sysadm.PS_U_MAIL_COMMANDE_CMA
	@dcIdSin	decimal(10,0),
	@iIdSeq int,
	@sResult varchar(3) -- OK / NOK
As
	Update sysadm.commande 
	Set info_spb_frn_cplt=sysadm.FN_CLE_VAL_E('ENVOI_MAIL_CLIENT',@sResult,info_spb_frn_cplt,';')
	Where id_sin=@dcIdSin and id_seq=@iIdSeq

	Update sysadm.w_commande 
	Set info_spb_frn_cplt=sysadm.FN_CLE_VAL_E('ENVOI_MAIL_CLIENT',@sResult,info_spb_frn_cplt,';')
	Where id_sin=@dcIdSin and id_seq=@iIdSeq
Go

grant execute on sysadm.PS_U_MAIL_COMMANDE_CMA to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_FERMETURE_PRESTA
-- Auteur               :       JFF
-- Date                 :       04/10/2018
-- Libelle              :       [PM445]
-- Commentaires         :        
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_FERMETURE_PRESTA' AND type = 'P' )
        DROP procedure sysadm.PS_U_FERMETURE_PRESTA
GO

CREATE procedure sysadm.PS_U_FERMETURE_PRESTA
        @adcIdSin     Decimal (  10,0 ),
		@aiIdSeq	  integer,
		@asCommentFrn  VarChar ( 255 )
As

Update sysadm.commande 
Set cod_etat = 
		Case 
			When id_ref_four in ( 'REFUSE_A_REEXP', 'PEC_A_RECYCLER' ) Then 'RFO'
			Else 'RPC'
		End, 
		comment_frn = IsNull ( rtrim ( comment_frn ) , '' ) + '.' + Convert ( varchar, getdate(), 103) + '=>' + rtrim ( @asCommentFrn )
Where id_sin = @adcIdSin
And   id_seq = @aiIdSeq

Update sysadm.w_commande 
Set cod_etat = 
		Case 
			When id_ref_four in ( 'REFUSE_A_REEXP', 'PEC_A_RECYCLER' ) Then 'RFO'
			Else 'RPC'
		End,  
	comment_frn = IsNull ( rtrim ( comment_frn ), '' ) + '.' + Convert ( varchar, getdate(), 103) + '=>' + rtrim ( @asCommentFrn ) 
Where id_sin = @adcIdSin
And   id_seq = @aiIdSeq

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_RETOUR_CTRLE_IMEI_OMT
-- Auteur               :       JFF
-- Date                 :       29/11/2018
-- Libelle              :       [PC874_2_V1]
-- Commentaires         :        
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_RETOUR_CTRLE_IMEI_OMT' AND type = 'P' )
        DROP procedure sysadm.PS_U_RETOUR_CTRLE_IMEI_OMT
GO

CREATE procedure sysadm.PS_U_RETOUR_CTRLE_IMEI_OMT
        @adcIdSin     Decimal (  10,0 ),
		@adcIdGti	  Decimal ( 7 ),
		@aiIdSeq	  integer,
		@aiStatusGc   integer,
		@asIdFour		varchar (3 ),
		@adtDteEnvCli DateTime,
		@asLibFour	   VarChar ( 35)
As

Declare @sMess			VarChar ( 2000 )
Declare @iIdCt			Integer	
Declare @sErr			Varchar(60)
Declare @iVal			Integer

Update sysadm.w_div_sin Set val_car = 'N' Where id_sin = @adcIdSin and nom_zone = 'cra_ctrl_imei'
Update sysadm.div_sin Set val_car = 'N' Where id_sin = @adcIdSin and nom_zone = 'cra_ctrl_imei'

Delete sysadm.w_div_sin Where id_sin = @adcIdSin and nom_zone in ( 'cra_last_dte', 'cra_suivi_imei' )
Delete sysadm.div_sin Where id_sin = @adcIdSin and nom_zone in ( 'cra_last_dte', 'cra_suivi_imei' )

If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
	Begin	 
		Insert into sysadm.w_div_sin values ( @adcIdSin, 'cra_last_dte', 'Date dernière utilisation', '-1', 'N', 'D', 'N', 'N', 40, null, null, @adtDteEnvCli , null, 0, getdate(), getdate(), 'AUTO' ) 
	End

If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
	Begin
		Insert into sysadm.div_sin values ( @adcIdSin, 'cra_last_dte', 'Date dernière utilisation', '-1', 'N', 'D', 'N', 'N', 40, null, null, @adtDteEnvCli , null, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
	End
	
Set @iVal = 2

If @aiStatusGc = 621 Set @iVal = 2
If @aiStatusGc = 622 Set @iVal = 3

If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
	Begin	 
		Insert into sysadm.w_div_sin values ( @adcIdSin, 'cra_suivi_imei', 'Suivi IMEI', '-CR', 'N', 'LN', 'N', 'N', 35, @iVal, null, null, null, 0, getdate(), getdate(), 'AUTO' ) 
	End

If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
	Begin
		Insert into sysadm.div_sin values ( @adcIdSin, 'cra_suivi_imei', 'Suivi IMEI', '-CR', 'N', 'LN', 'N', 'N', 35, @iVal, null, null, null, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
	End

Update sysadm.w_detail
Set cod_etat = 900, cod_dec_ope = 900, cod_dec_mac = 900,
	alt_ssui = 'O',
	cod_mot_ssui = 12,
	alt_att = 'N'
From sysadm.w_detail wd,
		sysadm.w_commande wc
Where wc.id_sin = @adcIdSin
And   wc.id_seq = @aiIdSeq
And   wd.id_sin = wc.id_sin
And   wd.id_gti = wc.id_gti
And   wd.id_detail = wc.id_detail

Update sysadm.detail
Set cod_etat = 900, cod_dec_ope = 900, cod_dec_mac = 900,
	alt_ssui = 'O',
	cod_mot_ssui = 12,
	alt_att = 'N'
From sysadm.detail d,
		sysadm.commande c
Where c.id_sin = @adcIdSin
And   c.id_seq = @aiIdSeq
And   d.id_sin = c.id_sin
And   d.id_gti = c.id_gti
And   d.id_detail = c.id_detail

Delete sysadm.w_piece 
From    sysadm.w_piece wp,
		sysadm.w_commande wc
Where wc.id_sin = @adcIdSin
And   wc.id_seq = @aiIdSeq
And   wp.id_sin = wc.id_sin
And   wp.id_gti = wc.id_gti
And   wp.id_detail = wc.id_detail

Delete sysadm.w_refus
From    sysadm.w_refus wr,
		sysadm.w_commande wc
Where wc.id_sin = @adcIdSin
And   wc.id_seq = @aiIdSeq
And   wr.id_sin = wc.id_sin
And   wr.id_gti = wc.id_gti
And   wr.id_detail = wc.id_detail

Delete sysadm.refus
From    sysadm.refus r,
		sysadm.commande c
Where c.id_sin = @adcIdSin
And   c.id_seq = @aiIdSeq
And   r.id_sin = c.id_sin
And   r.id_gti = c.id_gti
And   r.id_detail = c.id_detail


Set @sMess = 'Contact crée automatiquement, Process [' + @asLibFour + '] -> '+ 'Retour contrôle IMEI'
If @aiStatusGc = 621 Set @sMess = @sMess + ' ( IMEI présent )'
If @aiStatusGc = 622 Set @sMess = @sMess + ' ( IMEI absent )'

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @adcIdSin, 2, @sMess, @asIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END
ELSE
	BEGIN
		EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @adcIdSin, 2, @sMess, @asIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END	

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U_COMMANDE_DT339_MAJ_PRESTA
-- Auteur               :       JFF
-- Date                 :       12/03/2019
-- Libelle              :       [DT339]
-- Commentaires         :        
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COMMANDE_DT339_MAJ_PRESTA' AND type = 'P' )
        DROP procedure sysadm.PS_U_COMMANDE_DT339_MAJ_PRESTA
GO

CREATE procedure sysadm.PS_U_COMMANDE_DT339_MAJ_PRESTA
        @adcIdSin     Decimal (  10,0 ),
		@aiIdSeq	  integer,
		@asCas		  VarChar ( 20 )
As

If @asCas = 'OUI'
 Begin
	Update sysadm.commande 
	Set info_spb_frn_cplt = 
			sysadm.FN_CLE_VAL_E ( 'DTE_MAIL_CHAP', Convert ( varchar, getdate(), 103 ) , 
			sysadm.FN_CLE_VAL_E ( 'MAIL_CHAP_ENVOYE', 'OUI', rtrim ( info_spb_frn_cplt) , ';' )
			, ';' )
	Where id_sin = @adcIdSin
	And   id_seq = @aiIdSeq

	Update sysadm.w_commande 
	Set info_spb_frn_cplt = 
			sysadm.FN_CLE_VAL_E ( 'DTE_MAIL_CHAP', Convert ( varchar, getdate(), 103 ) , 
			sysadm.FN_CLE_VAL_E ( 'MAIL_CHAP_ENVOYE', 'OUI', rtrim ( info_spb_frn_cplt) , ';' )
			, ';' )
	Where id_sin = @adcIdSin
	And   id_seq = @aiIdSeq

 End 
Else
 Begin
	Update sysadm.commande 
	Set info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'MAIL_CHAP_ENVOYE', 'NON', rtrim ( info_spb_frn_cplt) , ';' )
	Where id_sin = @adcIdSin
	And   id_seq = @aiIdSeq

	Update sysadm.w_commande 
	Set info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'MAIL_CHAP_ENVOYE', 'NON', rtrim ( info_spb_frn_cplt) , ';' )
	Where id_sin = @adcIdSin
	And   id_seq = @aiIdSeq
 End 

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_I_PM421_6_MAJ_DOS_AUCHAN
-- Auteur               :       JFF
-- Date                 :       03/04/2019
-- Libelle              :       [PM421-6]
-- Commentaires         :        
-- References           :       
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM421_6_MAJ_DOS_AUCHAN' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM421_6_MAJ_DOS_AUCHAN
GO

CREATE procedure sysadm.PS_I_PM421_6_MAJ_DOS_AUCHAN
        @adcIdSin     Decimal (  10,0 ),
		@aiIdSeq	  integer,
		@aiIdCmdFrn	  integer,
		@dtDteEnvCli  DateTime
As

Declare @mtMtCarteCadeau Decimal ( 11,2 )
Declare @dtDteCreeLeCarteCadeau Datetime

	If Not (
	   Exists ( Select Top 1 1 
				From sysadm.sinistre s,
					 sysadm.det_pro dp
				Where s.id_sin = @adcIdSin
				And   dp.id_prod = dp.id_prod
				And   dp.id_code_dp = 140 )
	   And Exists ( Select top 1 1
					From sysadm.div_pro dp,
						 sysadm.sinistre s
					Where s.id_prod = s.id_prod
					And   dp.id_prod = s.id_prod
					And   dp.nom_zone = 'num_carte_cadeau' )
	   And Exists ( Select top 1 1
					From sysadm.div_pro dp,
						 sysadm.sinistre s
					Where s.id_prod = s.id_prod
					And   dp.id_prod = s.id_prod
					And   dp.nom_zone = 'dte_carte_cadeau' )
	   And Exists ( Select top 1 1
					From sysadm.div_pro dp,
						 sysadm.sinistre s
					Where s.id_prod = s.id_prod
					And   dp.id_prod = s.id_prod
					And   dp.nom_zone = 'mt_carte_cadeau' )
		)
		Begin
			Return 
		End 

Select	@mtMtCarteCadeau = c.mt_ttc_cmde,
		@dtDteCreeLeCarteCadeau = c.cree_le
From	sysadm.commande c
Where   c.id_sin = @adcIdSin
And     c.id_seq = @aiIdSeq

If @mtMtCarteCadeau is null Set @mtMtCarteCadeau = 0

 	If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
		Begin
			If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'num_carte_cadeau')
				Begin
					Update sysadm.w_div_sin Set val_car = Convert ( varchar, @aiIdCmdFrn ) , maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @adcIdSin And nom_zone = 'num_carte_cadeau'
				End 
			Else
				Begin	 
					Insert into sysadm.w_div_sin values ( @adcIdSin, 'num_carte_cadeau', 'Numéro de carte cadeau AUC', '-1', 'N', 'C', 'N', 'N', 125, null, null, null, Convert ( varchar,  @aiIdCmdFrn ), 1, getdate(), getdate(), 'AUTO' ) 
				End
				

			If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_carte_cadeau')
				Begin
					Update sysadm.w_div_sin Set val_dte = @dtDteCreeLeCarteCadeau, maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @adcIdSin And nom_zone = 'dte_carte_cadeau'
				End 
			Else
				Begin	 
					Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_carte_cadeau', 'Date de commande de la carte cadeau', '-1', 'N', 'D', 'N', 'N', 130, null, null, @dtDteCreeLeCarteCadeau, null, 1, getdate(), getdate(), 'AUTO' ) 
				End

			
			If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'mt_carte_cadeau')
				Begin
					Update sysadm.w_div_sin Set val_mt = @mtMtCarteCadeau, maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @adcIdSin And nom_zone = 'mt_carte_cadeau'
				End 
			Else
				Begin	 
					Insert into sysadm.w_div_sin values ( @adcIdSin, 'mt_carte_cadeau', 'Montant de la carte cadeau', '-1', 'N', 'S', 'N', 'N', 135, null, @mtMtCarteCadeau, null, null, 1, getdate(), getdate(), 'AUTO' ) 
				End

		End

	If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
		Begin
			If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'num_carte_cadeau')
				Begin
					Update sysadm.w_div_sin Set val_car = Convert ( varchar,  @aiIdCmdFrn ), maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @adcIdSin And nom_zone = 'num_carte_cadeau'
				End 
			Else
				Begin	 
					Insert into sysadm.div_sin values ( @adcIdSin, 'num_carte_cadeau', 'Numéro de carte cadeau AUC', '-1', 'N', 'C', 'N', 'N', 125, null, null, null, Convert ( varchar, @aiIdCmdFrn ), getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
				End


			If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_carte_cadeau')
				Begin
					Update sysadm.w_div_sin Set val_dte = @dtDteCreeLeCarteCadeau, maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @adcIdSin And nom_zone = 'dte_carte_cadeau'
				End 
			Else
				Begin	 
					Insert into sysadm.div_sin values ( @adcIdSin, 'dte_carte_cadeau', 'Date de commande de la carte cadeau', '-1', 'N', 'D', 'N', 'N', 130, null, null, @dtDteCreeLeCarteCadeau, null, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
				End

				
			If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'mt_carte_cadeau')
				Begin
					Update sysadm.w_div_sin Set val_mt = @mtMtCarteCadeau, maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @adcIdSin And nom_zone = 'mt_carte_cadeau'
				End 
			Else
				Begin	 
					Insert into sysadm.div_sin values ( @adcIdSin, 'mt_carte_cadeau', 'Montant de la carte cadeau', '-1', 'N', 'S', 'N', 'N', 135, null, @mtMtCarteCadeau, null, null, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
				End

		End


Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_COMMANDE_ORANGE_CTL_IMEI
-- Auteur               :       JFF
-- Date                 :       02/09/2019
-- Libelle              :		[DT424]
-- Commentaires         :       Remplacement de m'ENvoi par mail du contrôle IMEI de sysadm.PS_S_MAILPUSH_ORANGE_CTL_IMEI par un flux.
--
-- References           :
--
-- Arguments            :      
--				@adcIdSin       Decimal (  7,0 )        (Val)
--
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- JFF      14/06/2016   [PC161703]
-- JFF      12/02/2016   [PI062]
-- JFF		16/05/2018   [VDOC26156]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_COMMANDE_ORANGE_CTL_IMEI' AND type = 'P' )
        DROP procedure sysadm.PS_S_COMMANDE_ORANGE_CTL_IMEI
GO

CREATE procedure sysadm.PS_S_COMMANDE_ORANGE_CTL_IMEI
	@adcIdSin      	Decimal (10) -- [PI062]
AS

Declare @dcIdEvt Decimal ( 7,0 )
Declare @dcNewIdDetail Decimal ( 7,0 )
Declare @dcIdGti Decimal ( 7,0 )
Declare @iDetailExist Integer
Declare @iNewIdSeq Integer
Declare @sIdFour varchar ( 3 )

Declare @sPrenom VarChar ( 35 ) 
Declare @sNom VarChar ( 35 ) 
Declare @sAdr1 VarChar ( 35 ) 
Declare @sAdr2 VarChar ( 35 ) 
Declare @sAdrCp VarChar ( 5 ) 
Declare @sAdrVille VarChar ( 35 ) 
Declare @sNumTel VarChar ( 10 ) 
Declare @iCptDmde integer
Declare @dcIdProd Decimal ( 7 )
Declare @dcIdRev Decimal ( 7 )
Declare @sImeiSin VarChar ( 20 )

Select @iCptDmde=ds.val_nbre
From sysadm.w_sin s
inner join sysadm.det_pro d on s.id_prod=d.id_prod
inner join sysadm.produit p on p.id_prod=s.id_prod
left outer join sysadm.w_div_sin ds on ds.id_sin=s.id_sin and ds.nom_zone='cra_cpt_dmde'
Where s.id_sin=@adcIdSin
and d.id_code_dp=268

If @@RowCount = 0 
Begin 
	Select @iCptDmde=ds.val_nbre
	From sysadm.sinistre s
	inner join sysadm.det_pro d on s.id_prod=d.id_prod
	inner join sysadm.produit p on p.id_prod=s.id_prod
	left outer join sysadm.div_sin ds on ds.id_sin=s.id_sin and ds.nom_zone='cra_cpt_dmde'
	Where s.id_sin=@adcIdSin
	and d.id_code_dp=268
End 

-- Création du détail
Set  @dcIdEvt = 1457

Select Top 1 @dcIdGti = id_gti From sysadm.w_gar_sin where id_sin = @adcIdSin and id_gti not in ( 8 )
If @dcIdGti is null 
  Begin
	Select Top 1 @dcIdGti = id_gti From sysadm.gar_sin where id_sin = @adcIdSin and id_gti not in ( 8 )
  End 

Select	@dcNewIdDetail = max ( id_detail ) 
From	sysadm.detail
where   id_sin = @adcIdSin
and     id_gti = @dcIdGti 

If @dcNewIdDetail is null 
  Begin
	Select	@dcNewIdDetail = max ( id_detail ) 
	From	sysadm.w_detail
	where   id_sin = @adcIdSin
	and     id_gti = @dcIdGti 
  End 

If @dcNewIdDetail is null Set @dcNewIdDetail = 0
Set @dcNewIdDetail = @dcNewIdDetail + 1

Set @iDetailExist = 0

If Exists ( Select * from gar_sin where id_sin = @adcIdSin  and id_gti = @dcIdGti  )
 Begin
    Set @iDetailExist = 1
	Insert into sysadm.detail 
	Select @adcIdSin  id_sin,   
		   @dcIdGti   id_gti,
		   @dcNewIdDetail id_detail,
		   @dcIdEvt id_evt,
		   0 id_reg,
		   null id_i_reg,
		   null lib_det,   
		   null dte_det,   
		   null heu_det, 
		   null num_carte,   
		   0    mt_prej,   
		   0    mt_fran,
		   0    mt_nplaf,   
		   0    mt_plaf,   
		   'N'  alt_plaf,   
		   'N'  alt_reg,   
		   'O'  alt_att,
		   'N'  alt_ssui,   
		   0 cod_mot_ssui,   
		   100  cod_dec_mac,   
		   100  cod_dec_ope,   
		   100  cod_etat,   
		   0    id_carte,   
		   00 id_type_carte,   
		   getdate(),   
		   'AUTO',   
		   getdate(),   
		   getdate(),   
		   'AUTO',   
		   null  dte_cmd,   
		   null  dte_livr,   
		   0     mt_val_achat,   
		   0     mt_val_publique,   
		   null  num_facture
 End 

If Exists ( Select * from w_gar_sin where id_sin = @adcIdSin  and id_gti = @dcIdGti  )
	Begin
	Insert into sysadm.w_detail 
	Select @adcIdSin  id_sin,   
		   @dcIdGti   id_gti,
		   @dcNewIdDetail id_detail,
		   @dcIdEvt id_evt,
		   null lib_det,   
		   null dte_det,   
		   null heu_det, 
		   null num_carte,   
		   0    mt_prej,   
		   0    mt_fran,
		   0    mt_nplaf,   
		   0    mt_plaf,   
	       null id_i_reg,
		   'N'  alt_bloc,
		   'N'  alt_cour,
		   'N'  alt_plaf,   
		   'N'  alt_reg,   
		   'O'  alt_att,
		   'N'  alt_valide,
		   @iDetailExist cpt_valide,
		   'N'  alt_ssui,   
		   0 cod_mot_ssui,   
		   100  cod_dec_mac,   
		   100  cod_dec_ope,   
		   100  cod_etat,   
		   0    id_carte,   
		   00 id_type_carte,   
		   getdate(),   
		   getdate(),   
		   'AUTO',   
		   null  dte_cmd,   
		   null  dte_livr,   
		   0     mt_val_achat,   
		   0     mt_val_publique,   
		   null  num_facture
	End 

-- Je laisse div_vet volontairement, je ne mets rien.

-- Création de la prestation.

Select @iNewIdSeq = max ( id_seq ) From sysadm.commande where id_sin = @adcIdSin
If @iNewIdSeq is null Set @iNewIdSeq = 0
Set @iNewIdSeq = @iNewIdSeq + 1

Select Top 1 @sIdFour = ct.id_code_frn,
			 @sPrenom = ws.prenom,
			 @sNom = ws.nom,
			 @sAdr1 = ws.adr_1,
			 @sAdr2 = ws.adr_2,
			 @sAdrCp = ws.adr_cp,
			 @sAdrVille = ws.adr_ville,
			 @sNumTel = IsNull ( IsNull ( ws.num_teld, ws.num_telb), '0600000000' ),
			 @dcIdProd = ws.id_prod,
			 @dcIdRev = ws.id_rev,
			 @sImeiSin = ws.num_imei_port
From   sysadm.w_sin ws,
	   sysadm.commande_type ct
Where  ws.id_sin = @adcIdSin
And    ct.id_prod = ws.id_prod
And    ct.id_code_frn in ( 'OOP', 'OGP' ) 

If @dcIdProd is null 
  Begin
	Select Top 1 @sIdFour = ct.id_code_frn,
				 @sPrenom = p.prenom,
				 @sNom = p.nom,
				 @sAdr1 = p.adr_1,
				 @sAdr2 = p.adr_2,
				 @sAdrCp = p.adr_cp,
				 @sAdrVille = p.adr_ville,
				 @sNumTel = IsNull ( IsNull ( p.num_teld, p.num_telb), '0600000000' ),
				 @dcIdProd = s.id_prod,
				 @dcIdRev = s.id_rev,
				 @sImeiSin = s.num_imei_port
	From   sysadm.sinistre s,
		   sysadm.personne p,
		   sysadm.commande_type ct
	Where  s.id_sin = @adcIdSin
	And    ct.id_prod = s.id_prod
	And    ct.id_code_frn in ( 'OOP', 'OGP' ) 
	ANd    p.id_ordre = s.id_ordre
  End 
	   
If @iDetailExist = 1 
  Begin
	Insert into sysadm.commande
	select top 1 
			@adcIdSin id_sin,
			@iNewIdSeq, 
			@dcIdGti id_gti, 
			@dcNewIdDetail, 
			@sIdFour,
			a.id_typ_art,
			a.id_marq_art,
			a.id_modl_art,
			0, 
			@sNom adr_nom,  @sPrenom adr_prenom, @sAdr1 adr_livr1, @sAdr2 adr_livr2, '' adr_livr_cpl, @sAdrCp adr_cp, @sAdrVille adr_ville, @sNumTel adr_tel1, null adr_tel2, null adr_tel3, null adr_mail, null dte_rdv_cli, null hrdv_cli_min, null hrdv_cli_max,
			@sImeiSin id_serie_anc, 
			'', null,  
			null, 
			null,
			null,
			null, 
			'ECT', 
			'',
			'PRESTA AUTOMATIQUE', 0, null, null, Getdate(), Getdate(), 'AUTO',  Getdate(),  'AUTO', null id_zone, null id_bsp, null dte_ret_pret, null adr_cod_civ, a.id_ref_four, null id_orian_marque, null id_orian_modele, null dte_elv_mobile,
			0,
			null dte_emis_devis, null mt_devis, null alt_dev_acp, null dte_dev_acp, null adrfc_cod_civ, null adrfc_nom, null adrfc_prenom, null adrfc_livr1, null adrfc_livr2, null adrfc_livr_cpl, null adrfc_cp, null adrfc_ville, null dte_ret_logis, null dte_ret_pret_min, null dte_ret_pret_max, null id_ann, null dte_env_bte_frn, null dte_rcp_bte_cli, null dte_dep_bte_cli, null dte_env_st, null dte_rcp_mob_cli, 
			3310,
			null,
			null, 
			'',
			'' 
	From sysadm.article a
	Where a.id_four = @sIdFour
	And   a.id_typ_art = 'EDI'
	And   a.id_ref_four = 'CONTEST_IMEI'
  End

If Exists ( Select * from w_gar_sin where id_sin = @adcIdSin  and id_gti = @dcIdGti  )
	Begin
		Insert into sysadm.w_commande
		select top 1 
				@adcIdSin id_sin,
				@iNewIdSeq, 
				@dcIdGti id_gti, 
				@dcNewIdDetail, 
				@sIdFour,
				a.id_typ_art,
				a.id_marq_art,
				a.id_modl_art,
				0, 
				@sNom adr_nom,  @sPrenom adr_prenom, @sAdr1 adr_livr1, @sAdr2 adr_livr2, '' adr_livr_cpl, @sAdrCp adr_cp, @sAdrVille adr_ville, @sNumTel adr_tel1, null adr_tel2, null adr_tel3, null adr_mail, null dte_rdv_cli, null hrdv_cli_min, null hrdv_cli_max, 
				@sImeiSin id_serie_anc, 
				'', null,  
				null, 
				null,
				null,
				null, 
				'ECT', 
				'',
				@iDetailExist,
				'PRESTA AUTOMATIQUE', Getdate(), Getdate(), 'AUTO', null id_zone, null id_bsp, null dte_ret_pret, null adr_cod_civ, a.id_ref_four, null id_orian_marque, null id_orian_modele, null dte_elv_mobile,
				0,
				null dte_emis_devis, null mt_devis, null alt_dev_acp, null dte_dev_acp, null adrfc_cod_civ, null adrfc_nom, null adrfc_prenom, null adrfc_livr1, null adrfc_livr2, null adrfc_livr_cpl, null adrfc_cp, null adrfc_ville, null dte_ret_logis, null dte_ret_pret_min, null dte_ret_pret_max, null id_ann, null dte_env_bte_frn, null dte_rcp_bte_cli, null dte_dep_bte_cli, null dte_env_st, null dte_rcp_mob_cli, 
				3310,
				null,
				null, 
				'',
				'' 
		From sysadm.article a
		Where a.id_four = @sIdFour
		And   a.id_typ_art = 'EDI'
		And   a.id_ref_four = 'CONTEST_IMEI'

	End 


 -- maj des compteurs
  update sysadm.w_div_sin set val_car='N' where id_sin=@adcIdSin and nom_zone='cra_ctrl_imei'
  update sysadm.div_sin set val_car='N' where id_sin=@adcIdSin and nom_zone='cra_ctrl_imei'
 
  If @iCptDmde is null or @iCptDmde=0
  Begin
    INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cree_le, maj_le, maj_par, valide_le, valide_par )
		SELECT	@adcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N', dp.cpt_tri, 0, GETDATE(), GETDATE(), 'SQL', GETDATE(), 'SQL'
		FROM	sysadm.div_pro dp
		WHERE	dp.id_prod	=  @dcIdProd
			AND	dp.nom_zone	in ('cra_cpt_dmde','cra_dat_gen', 'cra_suivi_imei' )
			And not Exists (select * from sysadm.div_sin d where d.id_sin=@adcIdSin and d.nom_zone=dp.nom_zone)
			
	INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cpt_valide, cree_le, maj_le, maj_par )
		SELECT	@adcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N', dp.cpt_tri, 0, 1, GETDATE(), GETDATE(), 'SQL'
		FROM	div_pro dp
		WHERE	dp.id_prod	= @dcIdProd
			AND	dp.nom_zone	in ('cra_cpt_dmde','cra_dat_gen', 'cra_suivi_imei' )
			And not Exists (select * from sysadm.w_div_sin d where d.id_sin=@adcIdSin and d.nom_zone=dp.nom_zone)
			And Exists (select * from sysadm.w_sin s where s.id_sin=@adcIdSin)
  End
  
  update sysadm.w_div_sin set val_dte=GETDATE() where id_sin=@adcIdSin and nom_zone='cra_dat_gen'
  update sysadm.div_sin set val_dte=GETDATE() where id_sin=@adcIdSin and nom_zone='cra_dat_gen'
  update sysadm.w_div_sin set val_nbre=val_nbre + 1 where id_sin=@adcIdSin and nom_zone='cra_cpt_dmde'
  update sysadm.div_sin set val_nbre=val_nbre + 1 where id_sin=@adcIdSin and nom_zone='cra_cpt_dmde'

  update sysadm.w_div_sin set val_nbre = 1 where id_sin=@adcIdSin and nom_zone='cra_suivi_imei'
  update sysadm.div_sin set val_nbre = 1 where id_sin=@adcIdSin and nom_zone='cra_suivi_imei'

  -- Enfin maj param si 1457 absent.
  Exec sysadm.PS_I_CREATION_AUTO_PARAM_CONDITION @dcIdProd, @dcIdRev, @dcIdGti, '+EV', 1457, 'N'

Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_CTRLE_CARMA_AVANT_MAJ_PRESTA
-- Auteur               :       JFF
-- Date                 :       16/02/2021
-- Libelle              :		
-- Commentaires         :       Utiliser dans l'ETL CARMA de Fabien pour la MAJ des presta.
--
-- References           :
--
-- Arguments            :      	@adcIdSin      	Decimal (10), -- [PI062]
--								@aiIdSeq		integer
--
-- Retourne             :      1 => Vas-y Stéph, laisse appeler la PS de Fabien comme actuellement
--                            -1 => Tu n'appelles pas la PS de Fabien.
--
-------------------------------------------------------------------
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_CTRLE_CARMA_AVANT_MAJ_PRESTA' AND type = 'P' )
        DROP procedure sysadm.PS_S_CTRLE_CARMA_AVANT_MAJ_PRESTA
GO

CREATE procedure sysadm.PS_S_CTRLE_CARMA_AVANT_MAJ_PRESTA
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiIdSeq		integer
AS

If Not Exists ( Select Top 1 1 From sysadm.commande where id_sin = @adcIdSin And id_seq = @aiIdSeq ) 
  Begin 
	Select -1
	Return -1
  End

If Exists ( 
	Select Top 1 1 
	From   sysadm.commande with (nolock)
	Where  id_sin = @adcIdSin
	And    id_seq = @aiIdSeq
	And    cod_etat in ( 'RFO', 'RPC', 'ANN') )
	Begin
		Select -1
		Return -1
	End 

Select 1
Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_MAJ_SPB_FRN_CPLT
-- Auteur               :       Fabry JF
-- Date                 :       21/06/2018
-- Libelle              :        
-- Commentaires         :       [RS3220][RS3220_MODDEGR_TELST]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_MAJ_SPB_FRN_CPLT' AND type = 'P' )
        DROP procedure sysadm.PS_U_MAJ_SPB_FRN_CPLT
GO

CREATE procedure sysadm.PS_U_MAJ_SPB_FRN_CPLT
        @dcIdSin        Decimal (  10, 0 ), -- [PI062]
		@iIdSeq			Integer,
		@sCle           varchar ( 100),
		@sVal		    varchar  ( 100 )
		
AS

Set @sCle = UPPER ( ltrim ( rtrim ( @sCle )))

Update sysadm.w_commande 
Set info_spb_frn_cplt = Left ( sysadm.FN_CLE_VAL_E ( @sCle, @sVal, rtrim ( IsNull ( info_spb_frn_cplt, '') ), ';'), 800 )
Where id_sin = @dcIdSin
And   id_seq = @iIdSeq

Update sysadm.commande 
Set info_spb_frn_cplt = Left ( sysadm.FN_CLE_VAL_E ( @sCle, @sVal, rtrim ( IsNull ( info_spb_frn_cplt, '') ), ';'), 800 )
Where id_sin = @dcIdSin
And   id_seq = @iIdSeq

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_PRESTA_LECLERC_PNEU_MCO602
-- Auteur               :       Fabry JF
-- Date                 :       06/08/2024
-- Libelle              :        
-- Commentaires         :       [RS3220][RS3220_MODDEGR_TELST]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PRESTA_LECLERC_PNEU_MCO602' AND type = 'P' )
        DROP procedure sysadm.PS_I_PRESTA_LECLERC_PNEU_MCO602
GO

CREATE procedure sysadm.PS_I_PRESTA_LECLERC_PNEU_MCO602
        @adcIdSin        Decimal (  10, 0 ) -- [PI062]
As

Declare @iPrestaCal Integer
Declare @iPrestaLbe Integer
Declare @iRegltAssure Integer
Declare @iIdReg Integer
Declare @dcIdGti Decimal ( 7 )
Declare @dcNewIdDetail Decimal ( 7 )
Declare @dcMtForfaitPresta Decimal ( 11, 2)
Declare @dcIdProd decimal ( 7 )
Declare @iNewIdSeq Integer
Declare @sIdTypArt VarChar ( 3 )
Declare @iStatuGc Integer
Declare @sTypePresta VarChar ( 10 )
Declare @sCAL VarChar ( 35 )
Declare @sNumTelInter VarChar ( 20 )

Select @sCAL = sysadm.FN_GET_DIV_SIN ( @adcIdSin, 'lieu_repar', 'P', 'RETOUR=CODE')
If @sCAL <> 'CAL' Return

Select	@iPrestaCal = COUNT(*)
From	sysadm.commande c
Where	c.id_sin = @adcIdSin
And		c.id_four = 'CAL'
And		c.cod_etat <> 'ANN'
If @iPrestaCal is null Set @iPrestaCal = 0 

If @iPrestaCal > 0 Return

Select  @iRegltAssure = COUNT(*)
From	sysadm.w_a_virer wa
Where   wa.id_sin = @adcIdSin
And		wa.cod_inter = 'A'
And		wa.cod_pos = 0
If @iRegltAssure is null Set @iRegltAssure = 0 

Select	@iPrestaLbe = COUNT(*)
From	sysadm.commande c
Where	c.id_sin = @adcIdSin
And		c.id_four = 'LBE'
And		c.cod_etat <> 'ANN'
If @iPrestaLbe is null Set @iPrestaLbe = 0 

If @iRegltAssure <= 0 And @iPrestaLbe <= 0 Return

If @iRegltAssure > 0 
	Begin 
		Select Top 1 @iIdReg = wa.id_reg
		From sysadm.w_a_virer wa
		Where wa.id_sin = @adcIdSin
		If @iIdReg is null Set @iIdReg = 0 

		Select	@dcIdGti = dt.id_gti
		From	sysadm.detail dt
		Where	dt.id_sin = @adcIdSin
		And		dt.id_reg = @iIdReg
	End 

If @iPrestaLbe > 0 And  @iRegltAssure <= 0 
	Begin 
		Select	@dcIdGti = c.id_gti
		From	sysadm.commande c
		Where	c.id_sin = @adcIdSin
		And		c.id_four = 'LBE'
		And		c.cod_etat <> 'ANN'
	End 

Select	@dcIdProd = id_prod
From	sysadm.sinistre
Where	id_sin = @adcIdSin

Select  @sNumTelInter = i.num_teld
From	sysadm.inter i
Where	i.id_sin = @adcIdSin

If  @sNumTelInter is null Set @sNumTelInter = '0000000000'

Set @sTypePresta = sysadm.FN_GET_DIV_SIN ( @adcIdSin, 'typ_presta', 'P', 'RETOUR=CODE' )

If @sTypePresta = 'REP'
	Begin 
		Select @dcMtForfaitPresta = Convert ( Decimal (11, 2), sysadm.FN_CLE_VAL ( 'FRAIS_REPA', RTRIM ( val_car ) + rtrim ( val_car2 ), ';') )
		From sysadm.det_pro dp
		Where dp.id_prod = @dcIdProd
		And	  dp.id_code_dp = 299

		Set @sIdTypArt = 'PRS'
		Set @iStatuGc = 2

	End 

If @sTypePresta = 'RMP'
	Begin 
		Select @dcMtForfaitPresta = Convert ( Decimal (11, 2), sysadm.FN_CLE_VAL ( 'FRAIS_REMPL', RTRIM ( val_car ) + rtrim ( val_car2 ), ';') )
		From sysadm.det_pro dp
		Where dp.id_prod = @dcIdProd
		And	  dp.id_code_dp = 299

		Set @sIdTypArt = 'PNE'
		Set @iStatuGc = 178

	End 

Select	@dcNewIdDetail = max ( id_detail ) 
From	sysadm.detail
where   id_sin = @adcIdSin
and     id_gti = @dcIdGti 

If @dcNewIdDetail is null Set @dcNewIdDetail = 0
Set @dcNewIdDetail = @dcNewIdDetail + 1

Select @iNewIdSeq = max ( id_seq ) From sysadm.commande where id_sin = @adcIdSin 

If @iNewIdSeq is null Set @iNewIdSeq = 0
Set @iNewIdSeq = @iNewIdSeq + 1

Insert into sysadm.detail ( id_sin,    id_gti,   id_detail,      id_evt,   id_reg,   id_i_reg,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej,   mt_fran,   mt_nplaf,   mt_plaf,   alt_plaf,   alt_reg,   alt_att,   alt_ssui,   cod_mot_ssui,   cod_dec_mac, cod_dec_ope, cod_etat,   id_carte,   id_type_carte, valide_le, valide_par, cree_le,   maj_le  ,   maj_par,    dte_cmd,   dte_livr,   mt_val_achat,			mt_val_publique,    num_facture )
Values					  ( @adcIdSin, @dcIdGti, @dcNewIdDetail, 1489,     null,     null,       null,      null,      null,    null,		 0,			0,		   0,		   0,		  'N',		  'N'	 ,   'O'    ,   'N'     ,   0,		     	100,		 100,		  100     ,   0   ,       '00',          getdate(), 'AUTO',     getdate(), getdate(),  'AUTO',     null,      null,       @dcMtForfaitPresta,   @dcMtForfaitPresta, null        )

Insert into sysadm.div_det ( id_sin,    id_gti,   id_detail,      nom_zone, lib_label,         id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, cree_le,   maj_le,     maj_par, valide_le, valide_par )    
Values					   ( @adcIdSin, @dcIdGti, @dcNewIdDetail, 'pec',    'Prise en charge', '-1',         'N',               'X',   	     'N',       'N'      , 40,      null,     null,   null,    'O',     getdate(), getdate(),  'AUTO',  getdate(), 'AUTO'     )

Insert into sysadm.div_det ( id_sin,    id_gti,   id_detail,      nom_zone, lib_label,		              id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte,   val_car, cree_le,   maj_le,     maj_par, valide_le, valide_par )    
Values					   ( @adcIdSin, @dcIdGti, @dcNewIdDetail, 'dte_pec', 'Date de prise en charge',   '-1',         'N',               'X',   	     'N',       'N'      , 43,     null,     null,   GETDATE(), null,    getdate(), getdate(),  'AUTO',  getdate(), 'AUTO'     )

Insert into sysadm.div_det ( id_sin,    id_gti,   id_detail,      nom_zone, lib_label,		              id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, cree_le,   maj_le,     maj_par, valide_le, valide_par )    
Values					   ( @adcIdSin, @dcIdGti, @dcNewIdDetail, 'mt_pec', 'Mt maxi de prise en charge', '-1',         'N',               'X',   	     'N',       'N'      , 44,     null,     null,   null,    'O',     getdate(), getdate(),  'AUTO',  getdate(), 'AUTO'     )



Insert into sysadm.commande ( id_sin,    id_seq,     id_gti,   id_detail,      id_four,   id_typ_art  , id_marq_art,   id_modl_art,   mt_ttc_cmde,        adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp,   adr_ville,   adr_tel1,	  adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, probleme,                                                                                                                             id_cmd_frn, id_serie_nouv, id_bon_transp, dte_rcp_frn, dte_env_cli, cod_etat, comment_frn, nom_gest, id_lot_cmd, cmd_gen_le, cmd_gen_par, cree_le,   maj_le,    maj_par, valide_le, valide_par, id_zone, id_bsp, dte_ret_pret, adr_cod_civ, id_ref_four,   id_orian_marque, id_orian_modele, dte_elv_mobile, status_gc, dte_emis_devis, mt_devis, alt_dev_acp, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, info_spb_frn, id_marq_art_ifr, id_modl_art_ifr, info_spb_frn_cplt, info_frn_spb_cplt)
Select 						  @adcIdSin, @iNewIdSeq, @dcIdGti, @dcNewIdDetail, a.id_four, a.id_typ_art, a.id_marq_art, a.id_modl_art, @dcMtForfaitPresta ,p.nom  , p.prenom,   p.adr_1,   p.adr_2  , null,         p.adr_cp, p.adr_ville, @sNumTelInter, null,     null    , null,     null,        null,         null,         null,         'Prestation automatique pour règler le forfait d''intervention de ' + CONVERT ( varchar ( 20), @dcMtForfaitPresta ) + ' € à LECLERC', null,       null,          null,          null,        Getdate(),   'RPC',    null,        'AUTO',   999980    , GETDATE(),  'AUTO',      GETDATE(), GETDATE(), 'AUTO',  GETDATE(), 'AUTO',     null,    null,   null,         null,        a.id_ref_four, null,            null,            null,           @iStatuGc, null,           null,     null,        null,        null,          null,      null,         null,        null,        null,           null,     null,        null,          null,             null,             null,   null,            null,            null,            null,       null,            990,          null,            null,            null,              null  
From sysadm.article a,
	 sysadm.sinistre s,
	 sysadm.personne p
Where a.id_four = 'CAL'
And	  a.id_typ_art = @sIdTypArt
And	  s.id_sin = @adcIdSin
And   p.id_ordre = s.id_ordre

If Exists ( Select * from w_sin where id_sin = @adcIdSin )
	Begin

		Select  @sNumTelInter = i.num_teld
		From	sysadm.w_inter i
		Where	i.id_sin = @adcIdSin

		If  @sNumTelInter is null Set @sNumTelInter = '0000000000'

		Insert into sysadm.w_detail ( id_sin,    id_gti,   id_detail,      id_evt,	lib_det,   dte_det,   heu_det, num_carte,   mt_prej,   mt_fran,   mt_nplaf,   mt_plaf,   id_i_reg,    alt_bloc, alt_cour, alt_plaf, alt_reg,   alt_att,   alt_valide, cpt_valide, alt_ssui,   cod_mot_ssui,   cod_dec_mac, cod_dec_ope, cod_etat,   id_carte,   id_type_carte,  cree_le,   maj_le  ,   maj_par,    dte_cmd,   dte_livr,   mt_val_achat,			mt_val_publique,    num_facture )
		Values					    ( @adcIdSin, @dcIdGti, @dcNewIdDetail, 1489,    null,      null,      null,    null,		0,		   0,		  0,		  0,		 null,        'N',		'N'     , 'N',      'N'	,   'O'    ,   'N',        1,          'N'     ,   0,			   100,		    100,		 100     ,   0   ,       '00',           getdate(), getdate(),  'AUTO',     null,      null,       @dcMtForfaitPresta,   @dcMtForfaitPresta,    null        )

		Insert into sysadm.w_div_det ( id_sin,    id_gti,   id_detail,      nom_zone, lib_label,         id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, cpt_valide, cree_le,   maj_le,     maj_par )    
		Values					     ( @adcIdSin, @dcIdGti, @dcNewIdDetail, 'pec',    'Prise en charge', '-1',         'N',               'X',   	   'N',       'N'      , 40,      null,     null,   null,    'O',     1,          getdate(), getdate(),  'AUTO'  )

		Insert into sysadm.w_div_det ( id_sin,    id_gti,   id_detail,      nom_zone, lib_label,		              id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte,   val_car, cpt_valide, cree_le,   maj_le,     maj_par )
		Values					     ( @adcIdSin, @dcIdGti, @dcNewIdDetail, 'dte_pec', 'Date de prise en charge',   '-1',         'N',               'X',   	     'N',       'N'      , 43,     null,     null,   GETDATE(), null,    1,          getdate(), getdate(),  'AUTO'  )

		Insert into sysadm.w_div_det ( id_sin,    id_gti,   id_detail,      nom_zone, lib_label,		              id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, cpt_valide, cree_le,   maj_le,     maj_par )
		Values					     ( @adcIdSin, @dcIdGti, @dcNewIdDetail, 'mt_pec', 'Mt maxi de prise en charge', '-1',         'N',               'X',   	     'N',       'N'      , 44,     null,     null,   null,    'O',     1,          getdate(), getdate(),  'AUTO'  )

		Insert into sysadm.w_commande ( id_sin,    id_seq,     id_gti,   id_detail,      id_four,   id_typ_art  , id_marq_art,   id_modl_art,   mt_ttc_cmde,        adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp,   adr_ville,   adr_tel1,	  adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, probleme,                                                                                                                             id_cmd_frn, id_serie_nouv, id_bon_transp, dte_rcp_frn, dte_env_cli, cod_etat, comment_frn, cpt_valide, nom_gest, cree_le,   maj_le,    maj_par, id_zone, id_bsp, dte_ret_pret, adr_cod_civ, id_ref_four,   id_orian_marque, id_orian_modele, dte_elv_mobile, status_gc, dte_emis_devis, mt_devis, alt_dev_acp, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, info_spb_frn, id_marq_art_ifr, id_modl_art_ifr, info_spb_frn_cplt, info_frn_spb_cplt)
		Select 						    @adcIdSin, @iNewIdSeq, @dcIdGti, @dcNewIdDetail, a.id_four, a.id_typ_art, a.id_marq_art, a.id_modl_art, @dcMtForfaitPresta ,p.nom  , p.prenom,   p.adr_1,   p.adr_2  , null,         p.adr_cp, p.adr_ville, @sNumTelInter,   null,     null    , null,     null,        null,         null,         null,         'Prestation automatique pour règler le forfait d''intervention de ' + CONVERT ( varchar ( 20), @dcMtForfaitPresta ) + ' € à LECLERC', null,       null,          null,          null,        Getdate(),   'RPC',    null,        0,          'AUTO',   GETDATE(), GETDATE(), 'AUTO',  null,    null,   null,         null,        a.id_ref_four, null,            null,            null,           @iStatuGc, null,           null,     null,        null,        null,          null,      null,         null,        null,        null,           null,     null,        null,          null,             null,             null,   null,            null,            null,            null,       null,            990,          null,            null,            null,              null  
		From sysadm.article a,
			 sysadm.sinistre s,
			 sysadm.personne p
		Where a.id_four = 'CAL'
		And	  a.id_typ_art = @sIdTypArt
		And	  s.id_sin = @adcIdSin
		And   p.id_ordre = s.id_ordre
	End 

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_MAJ_PRESTA_API_MAXI_COFFEE
-- Auteur               :       Fabry JF
-- Date                 :       23/02/2025
-- Libelle              :       Maj de la presta MAXI COFFEE après appel de L'API pour le BA
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_MAJ_PRESTA_API_MAXI_COFFEE' AND type = 'P' )
        DROP procedure sysadm.PS_U_MAJ_PRESTA_API_MAXI_COFFEE
GO

CREATE procedure sysadm.PS_U_MAJ_PRESTA_API_MAXI_COFFEE
        @adcIdSin        Decimal (  10, 0 ),
		@aiIdSeq		 Integer,
		@aiStatusApi	 Integer,
		@asInfoSpbFrnCplt  Varchar ( 800 ),
		@asInfoFrnSpbCplt  Varchar ( 800 ),
		@asCodOper Varchar ( 4 ) 
As

Declare  @sCompteur VarChar ( 20 )
Declare  @sMtCmde VarChar ( 20 )
Declare  @sCommentFrn VarChar ( 200 )
Declare  @MessContact VarChar ( 508 )
Declare  @iIdCt Integer
Declare  @sErr VarChar ( 255 )

-- Maj du compteur
Select	@sCompteur = sysadm.FN_CLE_VAL ( 'COMPTEUR', c.info_spb_frn_cplt, ';' ),
		@sMtCmde = Convert ( VarChar ( 20 ), c.mt_ttc_cmde ) 
From sysadm.commande c
Where c.id_sin = @adcIdSin
And   c.id_seq = @aiIdSeq

If IsNumeric ( @sCompteur ) = 0 Set @sCompteur = '0'
Set @sCompteur = convert ( VarChar ( 10 ),  convert ( Integer, @sCompteur ) + 1 )

Set @asInfoSpbFrnCplt = sysadm.FN_CLE_VAL_E ( 'COMPTEUR', @sCompteur, @asInfoSpbFrnCplt, ';')

-- Traitement Sans Appel, erreur de param
If @aiStatusApi = 1000
Begin
		Set @sCommentFrn = 'L''appel et le retour de l''API Maxi Coffee n''a même pas pu se faire, l''URL/AUTH de l''API est/sont absent(s) du paramétrage, prévenez le service informatique.'

		Update sysadm.commande 
		Set status_gc = 902,
			comment_frn = @sCommentFrn
		Where id_sin = @adcIdSin and id_seq = @aiIdSeq 

		Update sysadm.w_commande 
		Set status_gc = 902,
			comment_frn = @sCommentFrn
		Where id_sin = @adcIdSin and id_seq = @aiIdSeq 

End 


-- Traitement du succès
If @aiStatusApi = 200 
	Begin
		Set @sCommentFrn = 'L''appel et le retour de l''API Maxi Coffee s''est fait avec succès pour un montant de ' + @sMtCmde + '€,'
		Set @sCommentFrn = @sCommentFrn + ' avec un retour de coupon dont le numéro est ' + sysadm.FN_CLE_VAL ( 'COUPON_ID', @asInfoFrnSpbCplt, ';') + '.'

		Update sysadm.commande 
		Set cod_etat = 'RFO',
			status_gc = 901,
			comment_frn = @sCommentFrn, 
			info_spb_frn_cplt = @asInfoSpbFrnCplt,
			info_frn_spb_cplt = @asInfoFrnSpbCplt
		
		Where id_sin = @adcIdSin and id_seq = @aiIdSeq 

		Update sysadm.w_commande 
		Set cod_etat = 'RFO',
			status_gc = 901,
			comment_frn = @sCommentFrn, 
			info_spb_frn_cplt = @asInfoSpbFrnCplt,
			info_frn_spb_cplt = @asInfoFrnSpbCplt
			
		Where id_sin = @adcIdSin and id_seq = @aiIdSeq 

		Set @MessContact = 'L''Appel de l''API MAXI COFFEE s''est fait avec succès le ' + sysadm.FN_CLE_VAL ( 'DTE_APPEL', @asInfoSpbFrnCplt, ';') + ' pour un montant de ' + @sMtCmde + '€, avec un retour de coupon dont le numéro est ' + sysadm.FN_CLE_VAL ( 'COUPON_ID', @asInfoFrnSpbCplt, ';') + '.'

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @adcIdSin, 2, @MessContact, 'AUTO', 300, @iIdCt OUTPUT							
		END
		ELSE
		BEGIN
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @adcIdSin, 2, @MessContact,'AUTO', 300, @iIdCt OUTPUT							
		END	


	End 

-- Traitement de l'échecs
If ( @aiStatusApi >= 300 And @aiStatusApi < 1000 ) Or @aiStatusApi = -1
	Begin
		Set @sCommentFrn = 'L''appel et le retour de l''API Maxi Coffee s''est terminé en échec , il faut re-valider ce dossier pour tenter un nouvel appel. La prestation reste en cours jusqu''à un appel qui se termine avec succès.'

		Update sysadm.commande 
		Set status_gc = 902,
			comment_frn = @sCommentFrn, 
			info_spb_frn_cplt = @asInfoSpbFrnCplt,
			info_frn_spb_cplt = @asInfoFrnSpbCplt
		
		Where id_sin = @adcIdSin and id_seq = @aiIdSeq 

		Update sysadm.w_commande 
		Set status_gc = 902,
			comment_frn = @sCommentFrn, 
			info_spb_frn_cplt = @asInfoSpbFrnCplt,
			info_frn_spb_cplt = @asInfoFrnSpbCplt
		
		Where id_sin = @adcIdSin and id_seq = @aiIdSeq 

	End 

Go
