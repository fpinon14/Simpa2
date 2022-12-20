-------------------------------------------------------------------
--
-- Fichier              :       W_COMMAN.CP
-- Auteur               :       Fabry Jf
-- Date                 :       03/09/01
--
-- Commentaires         :       Gestion de la table W_COMMANDE
--
-- Proc‚dures           :       DW_S01_W_COMMANDE
--				DW_D01_W_COMMANDE
--				PS_I01_W_COMMANDE_WKF
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_W_COMMANDE
-- Auteur               :       Fabry JF
-- Date                 :       07/09/01
-- Libell‚              :        
-- Commentaires         :       Select sur la table W_COMMANDE
-- R‚f‚rences           :       Utilis‚ dans W_TM_SP_SINISTRE 
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_COMMANDE
GO

/*-------------------------------------------------------------------
[DATABASE] SIMPA2_PRO
[DESCRIPTION] 
[MAJ PAR] DATAFLY - AFX
[DATEMAJ] 15/10/2009

[VARIABLES]
    @dcIdSin DECIMAL(7, 0)
-------------------------------------------------------------------*/
CREATE PROCEDURE [sysadm].[DW_S01_W_COMMANDE] 
	@dcIdSin DECIMAL(10, 0) -- [PI062]
AS 
    SELECT  w_commande.id_sin,
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
            w_commande.cpt_valide,
            w_commande.nom_gest,
            w_commande.cree_le,
            w_commande.maj_le,
            w_commande.maj_par,
            w_commande.id_zone,
            w_commande.id_bsp,
            w_commande.dte_ret_pret,
            w_commande.adr_cod_civ,
            w_commande.id_ref_four,
            w_commande.id_orian_marque,
            w_commande.id_orian_modele,
            NULL AS id_choix_horaire,
            w_commande.dte_elv_mobile,
            w_commande.status_gc,
            w_commande.dte_emis_devis,
            w_commande.mt_devis,
            w_commande.alt_dev_acp,
            w_commande.dte_dev_acp,
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
            commande.cmd_gen_le,
            w_commande.info_spb_frn,
            CONVERT (VARCHAR(2), NULL),
            CONVERT (VARCHAR(5), NULL),
            CONVERT (VARCHAR(5), NULL),
            CONVERT (VARCHAR(11), NULL),
            CONVERT (VARCHAR(2), NULL),
            w_commande.id_marq_art_ifr,
            w_commande.id_modl_art_ifr,
            w_commande.info_spb_frn_cplt, -- #1 [FNAC_PROD_ECH_TECH]
            w_commande.info_frn_spb_cplt  -- #1 [FNAC_PROD_ECH_TECH]
    FROM    sysadm.w_commande
            LEFT OUTER JOIN sysadm.commande ON sysadm.w_commande.id_seq = sysadm.commande.id_seq
                                               AND w_commande.id_sin = commande.id_sin
    WHERE   w_commande.id_sin = @dcIdSin

GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_D01_W_COMMANDE
-- Auteur               :       Fabry JF
-- Date                 :       07/09/01
-- Libell‚              :       
-- Commentaires         :       Suppression d'une commande
-- R‚f‚rences           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @iIdSeq         Integer		        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_W_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.DW_D01_W_COMMANDE
GO
CREATE procedure sysadm.DW_D01_W_COMMANDE
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @iIdSeq        Integer
AS

 DELETE FROM    sysadm.w_commande
 WHERE          id_sin      = @dcIdSin      AND
                id_seq      = @iIdSeq
 
GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I01_W_COMMANDE_WKF
-- Auteur               :       Fabry JF
-- Date                 :       04/10/01
-- Libell‚              :        
-- Commentaires         :       Insertion dans W_COMMANDE (rappatriement)
-- R‚f‚rences           :       Utilis‚ dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_COMMANDE_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_COMMANDE_WKF
GO

CREATE procedure sysadm.PS_I01_W_COMMANDE_WKF
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS
 INSERT INTO    sysadm.w_commande
        (       
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
		w_commande.cpt_valide,                     
		w_commande.nom_gest,                       
		w_commande.cree_le,                        
		w_commande.maj_le,                         
		w_commande.maj_par,
                w_commande.id_zone,
                w_commande.id_bsp,
                w_commande.dte_ret_pret,
                w_commande.adr_cod_civ,
                w_commande.id_ref_four,
                w_commande.id_orian_marque,
                w_commande.id_orian_modele,
		w_commande.dte_elv_mobile,
		w_commande.status_gc     ,
		w_commande.dte_emis_devis,
		w_commande.mt_devis      ,
		w_commande.alt_dev_acp   ,
		w_commande.dte_dev_acp  ,
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
                
                )
 SELECT         commande.id_sin,                         
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
		1,
		commande.nom_gest,                       
		commande.cree_le,                        
		commande.maj_le,                         
		commande.maj_par,
                commande.id_zone,
                commande.id_bsp,
                commande.dte_ret_pret,
                commande.adr_cod_civ,
                commande.id_ref_four,
                commande.id_orian_marque,
                commande.id_orian_modele,
		commande.dte_elv_mobile,
		commande.status_gc,
		commande.dte_emis_devis,
		commande.mt_devis,
		commande.alt_dev_acp,
		commande.dte_dev_acp,
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
                

 FROM           sysadm.commande
 WHERE          commande.id_sin   = @dcIdSin

 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_W_COMMANDE
-- Auteur               :       FPI
-- Date                 :       23/12/2010
-- Libellé              :       Insert sur la table w_commande.
-- Commentaires         :
-- Références           :       W_TM_SP_SINISTRE, dw_w_commande.SQLPREVIEW
--
-- Arguments            :       @dcIdProd       decimal ( 7, 0 ),
--                              @sIdNatCour     Varchar ( 6 ),
--                              @sIdCour        Varchar ( 6 ),
--                              @sIdConfDeb     Varchar ( 6 ),
--                              @sIdConfN       Varchar ( 6 ),
--                              @sIdConfFin     Varchar ( 6 ),
--                              @sAltConf       Varchar ( 1 ),
--                              @dtCreeLe       DateTime,
--                              @dtMajLe        DateTime,
--                              @sMajPar        Varchar ( 4 )
--
-- Retourne           :
--
-------------------------------------------------------------------
-- FPI	13/09/2012 [VDOC8537] Allongement de la colonne id_bon_transp de 20 à 35
-- JFF  12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_W_COMMANDE' AND type = 'P' )
            DROP procedure sysadm.DW_I01_W_COMMANDE
GO
CREATE PROCEDURE sysadm.DW_I01_W_COMMANDE
  @dcIdSin       decimal ( 10, 0 ), -- [PI062]
  @iIdSeq	int,
  @dcIdGti       decimal ( 7, 0 ),
  @dcIdDetail       decimal ( 7, 0 ),
  @sIdFour        Varchar ( 3 ),
  @sIdTypArt        Varchar ( 3 ),
  @sIdMarqArt        Varchar ( 35 ),
  @sIdModlArt        Varchar ( 35 ),
  @dcMtTtcCmde       decimal ( 11, 2 ),
  @sAdrNom        Varchar ( 35 ),
  @sAdrPrenom        Varchar ( 35 ),
  @sAdrLivr1        Varchar ( 35 ),
  @sAdrLivr2        Varchar ( 35 ),
  @sAdrLivrCpl        Varchar ( 35 ),
  @sAdrCp        Varchar ( 5 ),
  @sAdrVille        Varchar ( 35 ),
  @sAdrTel1        Varchar ( 20 ),
  @sAdrTel2        Varchar ( 20 ),
  @sAdrTel3        Varchar ( 20 ),
  @sAdrMail        Varchar ( 50 ),
  @dtRdvCli       DateTime,
  @sHrdvCliMin        Varchar ( 4 ),
  @sHrdvCliMax        Varchar ( 4 ),
  @sIdSerieAnc        Varchar ( 60 ),
  @sProbleme        Varchar ( 255 ),
  @sIdCmdFrn        Varchar ( 20 ),
  @sIdSerieNouv        Varchar ( 60 ),
  @sIdBonTrsp        Varchar ( 35 ), -- [VDOC8537]
  @dtRcpFrn       DateTime,
  @dtEnvCli       DateTime,
  @sCodEtat        Varchar ( 3 ),
  @sCommentFrn        Varchar ( 255 ),
  @sNomGest	Varchar(40),
  @dtCreeLe       DateTime,
  @dtMajLe        DateTime,
  @sMajPar        Varchar ( 4 ),
  @sIdZone	  Varchar(1),
  @iIdBsp	int,
  @dtRetPret	datetime ,
  @sAdrCodCiv	Varchar(1) ,
  @sIdRefFour	Varchar(20) ,
  @iIdOrianMarque	int ,
  @iIdOrianModele	int ,
  @dtElvMobile	datetime ,
  @iStatusGc int ,
  @dtEmisDevis datetime ,
  @dcMtDevis decimal(11, 2) ,
  @sAltDevAcp Varchar(1) ,
  @dtDevAcp datetime ,
  @sAdrfcCodCiv Varchar(1) ,
  @sAdrfcNom Varchar(35) ,
  @sAdrfcPrenom Varchar(35) ,
  @sAdrfcLivr1 Varchar(35) ,
  @sAdrfcLivr2 Varchar(35) ,
  @sAdrfcLivrCpl Varchar(35) ,
  @sAdrfcCp Varchar(5) ,
  @sAdrfcVille Varchar(35) ,
  @dtRetLogis datetime ,
  @dtRetPretMin datetime ,
  @dtRetPretMax datetime ,
  @iIdAnn int ,
  @dtEnvBteFrn datetime ,
  @dtRcpBteCli datetime ,
  @dtDepBteCli datetime ,
  @dtEnvSt datetime ,
  @dtRcpMobCli datetime ,
  @iInfoSpbFrn int ,
  @sIdMarqArtIfr Varchar(35) ,
  @sIdModlArtIfr Varchar(35) ,
  @sInfoSpbFrnCplt Varchar(800) ,
  @sInfoFrnSpbCplt Varchar(800)
AS

 INSERT INTO sysadm.w_commande
           (id_sin, id_seq, id_gti, id_detail, 
           id_four, id_typ_art, id_marq_art, id_modl_art, 
           mt_ttc_cmde, 
           adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, 
           adr_tel1, adr_tel2, adr_tel3, adr_mail, 
           dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, 
           id_serie_anc, probleme, id_cmd_frn, id_serie_nouv, 
           id_bon_transp, dte_rcp_frn, dte_env_cli, 
           cod_etat, comment_frn, cpt_valide, 
           nom_gest, cree_le, maj_le, maj_par, 
           id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 
           id_ref_four, id_orian_marque, id_orian_modele, 
           dte_elv_mobile, status_gc, 
           dte_emis_devis, mt_devis, 
           alt_dev_acp, dte_dev_acp, 
           adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, 
           adrfc_cp, adrfc_ville, 
           dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, 
           id_ann, 
           dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, 
           dte_env_st, dte_rcp_mob_cli, 
           info_spb_frn, id_marq_art_ifr, id_modl_art_ifr, 
           info_spb_frn_cplt, info_frn_spb_cplt)
     VALUES  (@dcIdSin,@iIdSeq,@dcIdGti,@dcIdDetail,
		@sIdFour,@sIdTypArt,@sIdMarqArt,@sIdModlArt,
		@dcMtTtcCmde,
		@sAdrNom,@sAdrPrenom,@sAdrLivr1,@sAdrLivr2,@sAdrLivrCpl,@sAdrCp,@sAdrVille,
		@sAdrTel1,@sAdrTel2,@sAdrTel3,@sAdrMail,
		@dtRdvCli,@sHrdvCliMin,@sHrdvCliMax,
		@sIdSerieAnc,@sProbleme,@sIdCmdFrn,@sIdSerieNouv,
		@sIdBonTrsp,@dtRcpFrn,@dtEnvCli,
		@sCodEtat,@sCommentFrn,0,
		@sNomGest,@dtCreeLe,@dtMajLe,@sMajPar,
		@sIdZone,@iIdBsp,@dtRetPret,@sAdrCodCiv,
		@sIdRefFour,@iIdOrianMarque,@iIdOrianModele,
		@dtElvMobile,@iStatusGc,
		@dtEmisDevis,@dcMtDevis,
		@sAltDevAcp,@dtDevAcp,
		@sAdrfcCodCiv,@sAdrfcNom,@sAdrfcPrenom,@sAdrfcLivr1,@sAdrfcLivr2,@sAdrfcLivrCpl,
		@sAdrfcCp,@sAdrfcVille,
		@dtRetLogis,@dtRetPretMin,@dtRetPretMax,
		@iIdAnn,
		@dtEnvBteFrn,@dtRcpBteCli,@dtDepBteCli,
		@dtEnvSt,@dtRcpMobCli,
		@iInfoSpbFrn,@sIdMarqArtIfr,@sIdModlArtIfr,
		@sInfoSpbFrnCplt,@sInfoFrnSpbCplt)
GO




