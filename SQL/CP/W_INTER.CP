-------------------------------------------------------------------
--
-- Fichier              :       W_INTER.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion des interlocuteurs dans SIMPA2
--
-- Procédures           :       DW_S01_W_INTER_LSTDET
--                              DW_I01_W_INTER
--                              DW_D01_W_INTER
--                              PS_I01_W_INTER_WKF
--                              PS_I02_W_INTER_WKF
--                              PS_I03_W_INTER_WKF
--                              PS_I04_W_INTER_WKF
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_INTER_LSTDET
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table W_SIN
--				JFF le 05/02/2004 : On ramène toujours la zone num_let_cheque à null !
--	
-- Références           :       Utilisé dans W_TM_SP_SINISTRE (Liste détail)
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
-------------------------------------------------------------------
-- JFF		12/02/2016	 [PI062]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_INTER_LSTDET' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_INTER_LSTDET
GO

CREATE procedure sysadm.DW_S01_W_INTER_LSTDET
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS
 SELECT w_inter.id_sin,  
        w_inter.id_i,  
        w_inter.cod_inter,  
        w_inter.cod_civ,  
        w_inter.nom,  
        w_inter.adr_1,  
        w_inter.adr_2,  
        w_inter.adr_cp,  
        w_inter.adr_ville,  
        w_inter.adr_att,  
        w_inter.num_teld,  
        w_inter.num_telb,  
        w_inter.num_fax,  
        w_inter.cod_mode_reg,  
        w_inter.rib_bq,  
        w_inter.rib_gui,  
        w_inter.rib_cpt,  
        w_inter.rib_cle,  
        w_inter.mt_a_reg,  
        w_inter.mt_reg,  
        w_inter.v_ref1,  
        w_inter.v_ref2,  
        w_inter.cod_ag,  
        w_inter.cod_bq,  
        w_inter.cpt_cour,  
        w_inter.alt_valide,  
        w_inter.cpt_valide,  
        w_inter.alt_part,  
        w_inter.alt_ps,  
        w_inter.alt_pce,  
        w_inter.alt_quest,  
        w_inter.id_cour,  
        w_inter.id_nat_cour,  
        w_inter.alt_courgest,  
        w_inter.id_i_db,  
        w_inter.id_courj,  
        w_inter.cree_le,  
        w_inter.maj_le,  
        w_inter.maj_par,  
        w_inter.ordre_cheque,  
        w_inter.num_let_cheque,  
        w_inter.id_four,  
		w_inter.alt_suivi_mail,  
		w_inter.adr_mail,  
		cast(null as char(29)),  
		cast(null as char(20)),  
		w_inter.alt_suivi_sms, -- #1 [FNAC_PROD_ECH_TECH]  
	    w_inter.num_port_sms, -- #1 [FNAC_PROD_ECH_TECH]  
		dte_naiss, -- [PMO89_RS4822]
		ville_naiss, -- [PMO89_RS4822]
		pays_naiss, -- [PMO89_RS4822]
		cod_etat_ctrle_inter -- [PMO89_RS4822]

 FROM   sysadm.w_inter
 WHERE  w_inter.id_sin = @dcIdSin

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_W_INTER
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion sur table W_INTER
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdI          Decimal (  7,0 )        (Val)
--                      :       @sCodInter      Varchar (  1 )          (Val)
--                      :       @sCodCiv        Varchar (  1 )          (Val)
--                      :       @sNom           Varchar ( 71 )          (Val)
--                      :       @sAdr1          Varchar ( 35 )          (Val)
--                      :       @sAdr2          Varchar ( 35 )          (Val)
--                      :       @sAdrCp         Varchar (  5 )          (Val)
--                      :       @sAdrVille      Varchar ( 35 )          (Val)
--                      :       @sAdrAtt        Varchar ( 35 )          (Val)
--                      :       @sNumTeld       Varchar ( 20 )          (Val)
--                      :       @sNumTelb       Varchar ( 20 )          (Val)
--                      :       @sNumFax        Varchar ( 20 )          (Val)
--                      :       @sCodModeReg    Varchar (  2 )          (Val)
--                      :       @sRibBq         Varchar (  5 )          (Val)
--                      :       @sRibGui        Varchar (  5 )          (Val)
--                      :       @sRibCpt        Varchar ( 11 )          (Val)
--                      :       @sRibCle        Varchar (  2 )          (Val)
--                      :       @dcMtAReg       Decimal ( 11,2)         (Val)
--                      :       @dcMtReg        Decimal ( 11,2)         (Val)
--                      :       @sVref1         Varchar ( 35 )          (Val)
--                      :       @sVref2         Varchar ( 35 )          (Val)
--                      :       @sCodeAg        Varchar (  5 )          (Val)
--                      :       @sCodeBq        Varchar (  5 )          (Val)
--                      :       @iCptCour       Integer                 (Val)
--                      :       @sAlt_Valide    Varchar (  1 )          (Val)
--                      :       @dcCptValide    Decimal (  2,0 )        (Val)
--                      :       @sAltPart       Varchar (  1 )          (Val)
--                      :       @sAltPs         Varchar (  1 )          (Val)
--                      :       @sAltPce        Varchar (  1 )          (Val)
--                      :       @sAltQuest      Varchar (  1 )          (Val)
--                      :       @sIdCour        Varchar (  6 )          (Val)
--                      :       @sIdNatCour     Varchar (  6 )          (Val)
--                      :       @sAltCourGest   Varchar (  1 )          (Val)
--                      :       @dcIdIDb        Decimal (  7,0 )        (Val)
--                      :       @sIdCourj       Varchar (  6 )          (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @dtMajLe        DateTime                (Val)
--                      :       @sMajPar        Varchar (  4 )          (Val)
--                      :       @sOrdreCheque	Varchar ( 35 )		(val)
--                      :       @sNumLetCheque	Varchar ( 10 )		(val)
--                      :       @sIdFour	VarChar ( 3 ) 		(val)
--                      :       @sAltSuiviMail	Varchar ( 1 )   (val)
--                      :       @sAdrMail		Varchar ( 50 )	(val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
--  JFF		12/02/2016		[PI062]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_W_INTER' AND type = 'P' )
        DROP procedure sysadm.DW_I01_W_INTER
GO

CREATE procedure sysadm.DW_I01_W_INTER
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdI          Decimal (  7,0 ),
        @sCodInter      Varchar (  1 )  ,
        @sCodCiv        Varchar (  1 )  ,
        @sNom           Varchar ( 71 )  ,
        @sAdr1          Varchar ( 35 )  ,
        @sAdr2          Varchar ( 35 )  ,
        @sAdrCp         Varchar (  5 )  ,
        @sAdrVille      Varchar ( 35 )  ,
        @sAdrAtt        Varchar ( 35 )  ,
        @sNumTeld       Varchar ( 20 )  ,
        @sNumTelb       Varchar ( 20 )  ,
        @sNumFax        Varchar ( 20 )  ,
        @sCodModeReg    Varchar (  2 )  ,
        @sRibBq         Varchar (  5 )  ,
        @sRibGui        Varchar (  5 )  ,
        @sRibCpt        Varchar ( 11 )  ,
        @sRibCle        Varchar (  2 )  ,
        @dcMtAReg       Decimal ( 11, 2 ),
        @dcMtReg        Decimal ( 11, 2 ),
        @sVref1         Varchar ( 35 ),
        @sVref2         Varchar ( 35 ),
        @sCodeAg        Varchar (  5 ),
        @sCodeBq        Varchar (  5 ),
        @iCptCour       Integer       ,
        @sAltValide     Varchar (  1 ),
        @dcCptValide    Decimal (  2,0 ),
        @sAltPart       Varchar (  1 )  ,
        @sAltPs         Varchar (  1 )  ,
        @sAltPce        Varchar (  1 )  ,
        @sAltQuest      Varchar (  1 )  ,
        @sIdCour        Varchar (  6 )  ,
        @sIdNatCour     Varchar (  6 )  ,
        @sAltCourGest   Varchar (  1 )  ,
        @dcIdIDb        Decimal (  7,0 ),
        @sIdCourj       Varchar (  6 )  ,
        @dtCreeLe       DateTime        ,
        @dtMajLe        DateTime        ,
        @sMajPar        Varchar (  4 )	,
        @sOrdreCheque	Varchar ( 35 )  ,
        @sNumLetCheque	Varchar ( 10 )  ,
        @sIdFour		Varchar ( 3 )   ,
		@sAltSuiviMail	Varchar ( 1 )   ,
		@sAdrMail		Varchar ( 50 ),
		@sAltSuiviSms	VarChar ( 1 ),  -- #1 [FNAC_PROD_ECH_TECH]
		@sNumPortSms    Varchar ( 20 ), -- #1 [FNAC_PROD_ECH_TECH]
		@dtDteNaiss		DateTime, -- [PMO89_RS4822]
		@sVilleNaiss    VarChar ( 35 ), -- [PMO89_RS4822]
		@sPaysNaiss     VarChar ( 35 ), -- [PMO89_RS4822]
		@sCodEtatCtrleInter Integer     -- [PMO89_RS4822]


AS
 INSERT INTO    sysadm.w_inter
        (       w_inter.id_sin,
                w_inter.id_i,
                w_inter.cod_inter,
                w_inter.cod_civ,
                w_inter.nom,
                w_inter.adr_1,
                w_inter.adr_2,
                w_inter.adr_cp,
                w_inter.adr_ville,
                w_inter.adr_att,
                w_inter.num_teld,
                w_inter.num_telb,
                w_inter.num_fax,
                w_inter.cod_mode_reg,
                w_inter.rib_bq,
                w_inter.rib_gui,
                w_inter.rib_cpt,
                w_inter.rib_cle,
                w_inter.mt_a_reg,
                w_inter.mt_reg,
                w_inter.v_ref1,
                w_inter.v_ref2,
                w_inter.cod_ag,
                w_inter.cod_bq,
                w_inter.cpt_cour,
                w_inter.alt_valide,
                w_inter.cpt_valide,
                w_inter.alt_part,
                w_inter.alt_ps,
                w_inter.alt_pce,
                w_inter.alt_quest,
                w_inter.id_cour,
                w_inter.id_nat_cour,
                w_inter.alt_courgest,
                w_inter.id_i_db,
                w_inter.id_courj,
                w_inter.cree_le,
                w_inter.maj_le,
                w_inter.maj_par,
                w_inter.ordre_cheque,
                w_inter.num_let_cheque,
                w_inter.id_four,
				w_inter.alt_suivi_mail,
				w_inter.adr_mail,
				w_inter.alt_suivi_sms, -- #1 [FNAC_PROD_ECH_TECH]
				w_inter.num_port_sms, -- #1 [FNAC_PROD_ECH_TECH]
				w_inter.dte_naiss, -- [PMO89_RS4822]
				w_inter.ville_naiss, -- [PMO89_RS4822]
				w_inter.pays_naiss, -- [PMO89_RS4822]
				w_inter.cod_etat_ctrle_inter -- [PMO89_RS4822]

		)
 VALUES (       @dcIdSin,
                @dcIdI,
                @sCodInter,
                @sCodCiv,
                @sNom,
                @sAdr1,
                @sAdr2,
                @sAdrCp,
                @sAdrVille,
                @sAdrAtt,
                @sNumTeld,
                @sNumTelb,
                @sNumFax,
                @sCodModeReg,
                @sRibBq,
                @sRibGui,
                @sRibCpt,
                @sRibCle,
                @dcMtAReg,
                @dcMtReg,
                @sVref1,
                @sVref2,
                @sCodeAg,
                @sCodeBq,
                @iCptCour,
                @sAltValide,
                @dcCptValide,
                @sAltPart,
                @sAltPs,
                @sAltPce,
                @sAltQuest,
                @sIdCour,
                @sIdNatCour,
                @sAltCourGest,
                @dcIdIDb,
                @sIdCourj,
                @dtCreeLe,
                @dtMajLe,
                @sMajPar,
                @sOrdreCheque,
                @sNumLetCheque,
                @sIdFour,
				@sAltSuiviMail,
				@sAdrMail,
				@sAltSuiviSms, -- #1 [FNAC_PROD_ECH_TECH]
				@sNumPortSms,  -- #1 [FNAC_PROD_ECH_TECH]
				@dtDteNaiss,   -- [PMO89_RS4822]
				@sVilleNaiss,  -- [PMO89_RS4822]
				@sPaysNaiss,   -- [PMO89_RS4822]
				@sCodEtatCtrleInter -- [PMO89_RS4822]

		)       
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_W_INTER
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Suppression d'un interlocuteur
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdI          Decimal (  7,0 )        (Val)
--				@sMethode	VarChar (  3 )		(Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_W_INTER' AND type = 'P' )
        DROP procedure sysadm.DW_D01_W_INTER
GO

CREATE procedure sysadm.DW_D01_W_INTER
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdI          Decimal (  7,0 ),
        @sMethode	VarChar ( 3 )
AS

 DELETE FROM    sysadm.w_para_info
 WHERE          w_para_info.id_sin      = @dcIdSin      AND
                w_para_info.id_i        = @dcIdI

 If @sMethode = 'SVE' 
  DELETE FROM    sysadm.w_cour_blob
  WHERE          w_cour_blob.id_sin     = @dcIdSin      AND
                 w_cour_blob.id_i       = @dcIdI
              
 Else
  DELETE FROM    sysadm.w_inter_blob
  WHERE          w_inter_blob.id_sin     = @dcIdSin      AND
                 w_inter_blob.id_i       = @dcIdI


 DELETE FROM    sysadm.w_courrier   
 WHERE          w_courrier.id_sin       = @dcIdSin      AND
                w_courrier.id_i         = @dcIdI
 
 DELETE FROM    sysadm.w_frais
 WHERE          w_frais.id_sin          = @dcIdSin      AND
                w_frais.id_i            = @dcIdI

 DELETE FROM    sysadm.w_inter
 WHERE          w_inter.id_sin          = @dcIdSin      AND
                w_inter.id_i            = @dcIdI

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_W_INTER_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table W_INTER
-- Références           :       Utilisé dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
-- JFF      12/02/2016   [PI062]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_INTER_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_INTER_WKF
GO

CREATE procedure sysadm.PS_I01_W_INTER_WKF
        @dcIdSin        Decimal (  10,0 )  -- [PI062]
AS
 INSERT INTO    sysadm.w_inter
        (       w_inter.id_sin,
                w_inter.id_i,
                w_inter.cod_inter,
                w_inter.cod_civ,
                w_inter.nom,
                w_inter.adr_1,
                w_inter.adr_2,
                w_inter.adr_cp,
                w_inter.adr_ville,
                w_inter.adr_att,
                w_inter.num_teld,
                w_inter.num_telb,
                w_inter.num_fax,
                w_inter.cod_mode_reg,
                w_inter.rib_bq,
                w_inter.rib_gui,
                w_inter.rib_cpt,
                w_inter.rib_cle,
                w_inter.mt_a_reg,
                w_inter.mt_reg,
                w_inter.v_ref1,
                w_inter.v_ref2,
                w_inter.cod_ag,
                w_inter.cod_bq,
                w_inter.cpt_cour,
                w_inter.alt_valide,
                w_inter.cpt_valide,
                w_inter.alt_part,
                w_inter.alt_ps,
                w_inter.alt_pce,
                w_inter.alt_quest,
                w_inter.id_cour,
                w_inter.id_nat_cour,
                w_inter.alt_courgest,
                w_inter.id_i_db,
                w_inter.id_courj,
                w_inter.cree_le,
                w_inter.maj_le,
                w_inter.maj_par,
                w_inter.ordre_cheque,
                w_inter.num_let_cheque,
                w_inter.id_four,
				w_inter.alt_suivi_mail,
				w_inter.adr_mail,
				w_inter.alt_suivi_sms, -- #1 [FNAC_PROD_ECH_TECH]
				w_inter.num_port_sms, -- #1 [FNAC_PROD_ECH_TECH]
				w_inter.dte_naiss, -- [PMO89_RS4822]
				w_inter.ville_naiss, -- [PMO89_RS4822]
				w_inter.pays_naiss, -- [PMO89_RS4822]
				w_inter.cod_etat_ctrle_inter -- [PMO89_RS4822]
		)
 SELECT         inter.id_sin,
                inter.id_i,
                inter.cod_inter,
                inter.cod_civ,
                inter.nom,
                inter.adr_1,
                inter.adr_2,
                inter.adr_cp,
                inter.adr_ville,
                inter.adr_att,
                inter.num_teld,
                inter.num_telb,
                inter.num_fax,
                inter.cod_mode_reg,
                inter.rib_bq,
                inter.rib_gui,
                inter.rib_cpt,
                inter.rib_cle,
                0.00,
                inter.mt_reg,
                inter.v_ref1,
                inter.v_ref2,
                inter.cod_ag,
                inter.cod_bq,
                inter.cpt_cour,
                'N',
                1,
                'N',
                'N',
                'N',
                'N',
                NULL,
                NULL,
                'N',
                NULL,
                NULL,
                inter.cree_le,
                inter.maj_le,
                inter.maj_par,
                inter.ordre_cheque,
                null,
                inter.id_four,
				inter.alt_suivi_mail,
				inter.adr_mail,
				inter.alt_suivi_sms, -- #1 [FNAC_PROD_ECH_TECH]
				inter.num_port_sms, -- #1 [FNAC_PROD_ECH_TECH]
				inter.dte_naiss, -- [PMO89_RS4822]
				inter.ville_naiss, -- [PMO89_RS4822]
				inter.pays_naiss, -- [PMO89_RS4822]
				inter.cod_etat_ctrle_inter -- [PMO89_RS4822]
		
 FROM           sysadm.inter
 WHERE          inter.id_sin = @dcIdSin

 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I02_W_INTER_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table W_INTER (Assur‚)
-- Références           :       Utilisé dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodCiv        Varchar (  1   )        (Val)
--                      :       @sNom           Varchar ( 35   )        (Val)
--                      :       @sPrenom        Varchar ( 35   )        (Val)
--                      :       @sAdr1          Varchar ( 35   )        (Val)
--                      :       @sAdr2          Varchar ( 35   )        (Val)
--                      :       @sAdrCp         Varchar (  5   )        (Val)
--                      :       @sAdrVille      Varchar ( 35   )        (Val)
--                      :       @sCodModeRegA   Varchar (  2   )        (Val)
--                      :       @sNumTelD       Varchar ( 20   )        (Val)
--                      :       @sNumTelB       Varchar ( 20   )        (Val)
--                      :       @sNumFax        Varchar ( 20   )        (Val)
--                      :       @sRibBq         Varchar (  5   )        (Val)
--                      :       @sRibGui        Varchar (  5   )        (Val)
--                      :       @sRibCpt        Varchar ( 11   )        (Val)
--                      :       @sRibCle        Varchar (  2   )        (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @dtMajLe        DateTime                (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--			:	@sAltSuiviMail	Varchar (  1   )        (Val)
--				@sAdrMail	Varchar (  50  )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 FS  le 18/02/2002 Ajt de Rtrim pour compatibilit‚ avec appel depuis sherpa
-- #2 FS  le 04/10/2002 Pour les soci‚t‚s je ne concat‚ne pas le prenom
-- #3 FS  le 16/06/2006 DntMail1 ; Getsion des paramétres @sAltSuiviMail, @sAdrMail
-- #4 JFF le 20/10/2008	[FNAC_PROD_ECH_TECH]
-- JFF      12/02/2016   [PI062]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I02_W_INTER_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_I02_W_INTER_WKF
GO

CREATE procedure sysadm.PS_I02_W_INTER_WKF
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @sCodCiv        Varchar (  1   ),
        @sNom           Varchar ( 35   ),
        @sPrenom        Varchar ( 35   ),
        @sAdr1          Varchar ( 35   ),
        @sAdr2          Varchar ( 35   ),
        @sAdrCp         Varchar (  5   ),
        @sAdrVille      Varchar ( 35   ),
        @sCodModeRegA   Varchar (  2   ),
        @sNumTelD       Varchar ( 20   ),
        @sNumTelB       Varchar ( 20   ),
        @sNumFax        Varchar ( 20   ),
        @sRibBq         Varchar (  5   ),
        @sRibGui        Varchar (  5   ),
        @sRibCpt        Varchar ( 11   ),
        @sRibCle        Varchar (  2   ),
        @dtCreeLe       DateTime        ,
        @dtMajLe        DateTime        ,
        @sCodOper       Varchar (  4   ),
		@sAltSuiviMail	Varchar (  1   ) = 'N', -- #3
		@sAdrMail	Varchar (  50  ) = null, -- #3
		@sAltSuiviSms	VarChar ( 1 ) = 'N',  -- #4 [FNAC_PROD_ECH_TECH]
		@sNumPortSms    Varchar ( 20 ) = null -- #4 [FNAC_PROD_ECH_TECH]
AS

Declare @sLib Varchar(71)

If @sCodCiv = '5' 
   Begin
      Select @sLib = Rtrim ( @sNom )
   End
Else
   Begin
      Select @sLib = Rtrim ( @sPrenom + ' ' + @sNom )
   End



 INSERT INTO    sysadm.w_inter
        (       w_inter.id_sin,
                w_inter.id_i,
                w_inter.cod_inter,
                w_inter.cod_civ,
                w_inter.nom,
                w_inter.adr_1,
                w_inter.adr_2,
                w_inter.adr_cp,
                w_inter.adr_ville,
                w_inter.adr_att,
                w_inter.num_teld,
                w_inter.num_telb,
                w_inter.num_fax,
                w_inter.cod_mode_reg,
                w_inter.rib_bq,
                w_inter.rib_gui,
                w_inter.rib_cpt,
                w_inter.rib_cle,
                w_inter.mt_a_reg,
                w_inter.mt_reg,
                w_inter.v_ref1,
                w_inter.v_ref2,
                w_inter.cod_ag,
                w_inter.cod_bq,
                w_inter.cpt_cour,
                w_inter.alt_valide,
                w_inter.cpt_valide,
                w_inter.alt_part,
                w_inter.alt_ps,
                w_inter.alt_pce,
                w_inter.alt_quest,
                w_inter.id_cour,
                w_inter.id_nat_cour,
                w_inter.alt_courgest,
                w_inter.id_i_db,
                w_inter.id_courj,
                w_inter.cree_le,
                w_inter.maj_le,
                w_inter.maj_par,
                w_inter.ordre_cheque,
                w_inter.num_let_cheque,
                w_inter.id_four,
				w_inter.alt_suivi_mail,
				w_inter.adr_mail,
				w_inter.alt_suivi_sms, -- #4 [FNAC_PROD_ECH_TECH]
				w_inter.num_port_sms, -- #4 [FNAC_PROD_ECH_TECH]
				w_inter.dte_naiss, -- [PMO89_RS4822]
				w_inter.ville_naiss, -- [PMO89_RS4822]
				w_inter.pays_naiss, -- [PMO89_RS4822]
				w_inter.cod_etat_ctrle_inter -- [PMO89_RS4822]
		)
 VALUES (       @dcIdSin,
                0,
                'A',
                @sCodCiv,
                @sLib,
                @sAdr1,
                @sAdr2,
                @sAdrCp,
                @sAdrVille,
                NULL,
                @sNumTelD,
                @sNumTelB,
                @sNumFax,
                @sCodModeRegA,
                @sRibBq,
                @sRibGui,
                @sRibCpt,
                @sRibCle,
                0.00,
                0.00,
                NULL,
                NULL,
                NULL,
                NULL,
                0,
                'O',
                0,
                'N',
                'N',
                'N',
                'N',
                NULL,
                NULL,
                'N',
                NULL,
                NULL,
                @dtCreeLe,
                @dtMajLe,
                @sCodOper,
                NULL,
                NULL,
                NULL,
				@sAltSuiviMail,
				@sAdrMail,
				@sAltSuiviSms,  -- #4 [FNAC_PROD_ECH_TECH]
				@sNumPortSms, -- #4 [FNAC_PROD_ECH_TECH]
				null, -- [PMO89_RS4822]
				null, -- [PMO89_RS4822]
				null, -- [PMO89_RS4822]
				0  -- [PMO89_RS4822]
)

Return @@RowCount

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I03_W_INTER_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table W_INTER (Banque)
-- Références           :       Utilisé dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sNom_B         Varchar ( 71   )        (Val)
--                      :       @sAdr1_B        Varchar ( 35   )        (Val)
--                      :       @sAdr2_B        Varchar ( 35   )        (Val)
--                      :       @sAdrCp_B       Varchar (  5   )        (Val)
--                      :       @sAdrVille_B    Varchar ( 35   )        (Val)
--                      :       @sNumTelD_B     Varchar ( 20   )        (Val)
--                      :       @sCodModeRegB   Varchar (  2   )        (Val)
--                      :       @sCodBq         Varchar (  5   )        (Val)
--                      :       @sCodAg         Varchar (  5   )        (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @dtMajLe        DateTime                (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I03_W_INTER_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_I03_W_INTER_WKF
GO

CREATE procedure sysadm.PS_I03_W_INTER_WKF
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @sNom_B         Varchar ( 71   ),
        @sAdr1_B        Varchar ( 35   ),
        @sAdr2_B        Varchar ( 35   ),
        @sAdrCp_B       Varchar (  5   ),
        @sAdrVille_B    Varchar ( 35   ),
        @sNumTelD_B     Varchar ( 20   ),
        @sCodModeRegB   Varchar (  2   ),
        @sCodBq         Varchar (  5   ),
        @sCodAg         Varchar (  5   ),
        @dtCreeLe       DateTime        ,
        @dtMajLe        DateTime        ,
        @sCodOper       Varchar (  4   )
AS
 INSERT INTO    sysadm.w_inter
        (       w_inter.id_sin,
                w_inter.id_i,
                w_inter.cod_inter,
                w_inter.cod_civ,
                w_inter.nom,
                w_inter.adr_1,
                w_inter.adr_2,
                w_inter.adr_cp,
                w_inter.adr_ville,
                w_inter.adr_att,
                w_inter.num_teld,
                w_inter.num_telb,
                w_inter.num_fax,
                w_inter.cod_mode_reg,
                w_inter.rib_bq,
                w_inter.rib_gui,
                w_inter.rib_cpt,
                w_inter.rib_cle,
                w_inter.mt_a_reg,
                w_inter.mt_reg,
                w_inter.v_ref1,
                w_inter.v_ref2,
                w_inter.cod_ag,
                w_inter.cod_bq,
                w_inter.cpt_cour,
                w_inter.alt_valide,
                w_inter.cpt_valide,
                w_inter.alt_part,
                w_inter.alt_ps,
                w_inter.alt_pce,
                w_inter.alt_quest,
                w_inter.id_cour,
                w_inter.id_nat_cour,
                w_inter.alt_courgest,
                w_inter.id_i_db,
                w_inter.id_courj,
                w_inter.cree_le,
                w_inter.maj_le,
                w_inter.maj_par,
                w_inter.ordre_cheque,
                w_inter.num_let_cheque,
                w_inter.id_four,
				w_inter.alt_suivi_mail,
				w_inter.adr_mail,
				w_inter.alt_suivi_sms, -- #1 [FNAC_PROD_ECH_TECH]
				w_inter.num_port_sms, -- #1 [FNAC_PROD_ECH_TECH]
				w_inter.dte_naiss, -- [PMO89_RS4822]
				w_inter.ville_naiss, -- [PMO89_RS4822]
				w_inter.pays_naiss, -- [PMO89_RS4822]
				w_inter.cod_etat_ctrle_inter -- [PMO89_RS4822]
		)
 VALUES (       @dcIdSin,
                1,
                'B',
                '5',
                @sNom_B,
                @sAdr1_B,
                @sAdr2_B,
                @sAdrCp_B,
                @sAdrVille_B,
                NULL,
                @sNumTelD_B,
                NULL,
                NULL,
                @sCodModeRegB,
                NULL,
                NULL,
                NULL,
                NULL,
                0.00,
                0.00,
                NULL,
                NULL,
                @sCodAg,
                @sCodBq,
                0,
                'O',
                0,
                'N',
                'N',
                'N',
                'N',
                NULL,
                NULL,
                'N',
                NULL,
                NULL,
                @dtCreeLe,
                @dtMajLe,
                @sCodOper,
                NULL,
                NULL,
                NULL,
				'N',
				NULL,
				NULL, -- #1 [FNAC_PROD_ECH_TECH]
				NULL,  -- #1 [FNAC_PROD_ECH_TECH]
				null, -- [PMO89_RS4822]
				null, -- [PMO89_RS4822]
				null, -- [PMO89_RS4822]
				0  -- [PMO89_RS4822]
		)

 Return @@RowCount
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I04_W_INTER_WKF
-- Auteur               :       FABRY JF 
-- Date                 :       25/10/2001
-- Libellé              :        
-- Commentaires         :       Insertion dans la table W_INTER (Cas Particulier)
-- Références           :       Utilisé dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--				@dcIdProd	Decimal (  7,0 )        (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @dtMajLe        DateTime                (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I04_W_INTER_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_I04_W_INTER_WKF
GO

CREATE procedure sysadm.PS_I04_W_INTER_WKF
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dtCreeLe       DateTime        ,
        @dtMajLe        DateTime        ,
        @sCodOper       Varchar (  4   )         
AS

Declare	@dcMaxInter	Decimal ( 7,0 )

/* DCMP 010285 MH Patry, pour 5 produits insertion 
   d'un inter particulier à la création des travaux. */
   
If ( Select count ( * ) 
     From sysadm.produit p
     Where p.id_prod = @dcIdProd 
     And   @dcIdProd in ( 11001, 14000, 14500, 14600, 15200 ) ) > 0 And 
   ( Select count ( * ) 
     From sysadm.agence
     Where id_bq = '30066'
     And   id_ag = '99998') > 0 
     	
   Begin

	Select @dcMaxInter = max ( id_i ) + 1
	From sysadm.w_inter
	Where id_sin = @dcIdSin

	 INSERT INTO    sysadm.w_inter
		(       w_inter.id_sin,
			w_inter.id_i,
			w_inter.cod_inter,
			w_inter.cod_civ,
			w_inter.nom,
			w_inter.adr_1,
			w_inter.adr_2,
			w_inter.adr_cp,
			w_inter.adr_ville,
			w_inter.adr_att,
			w_inter.num_teld,
			w_inter.num_telb,
			w_inter.num_fax,
			w_inter.cod_mode_reg,
			w_inter.rib_bq,
			w_inter.rib_gui,
			w_inter.rib_cpt,
			w_inter.rib_cle,
			w_inter.mt_a_reg,
			w_inter.mt_reg,
			w_inter.v_ref1,
			w_inter.v_ref2,
			w_inter.cod_ag,
			w_inter.cod_bq,
			w_inter.cpt_cour,
			w_inter.alt_valide,
			w_inter.cpt_valide,
			w_inter.alt_part,
			w_inter.alt_ps,
			w_inter.alt_pce,
			w_inter.alt_quest,
			w_inter.id_cour,
			w_inter.id_nat_cour,
			w_inter.alt_courgest,
			w_inter.id_i_db,
			w_inter.id_courj,
			w_inter.cree_le,
			w_inter.maj_le,
			w_inter.maj_par,
			w_inter.ordre_cheque,
            		w_inter.num_let_cheque,
			w_inter.id_four,
			w_inter.alt_suivi_mail,
			w_inter.adr_mail, 
			w_inter.alt_suivi_sms, -- #1 [FNAC_PROD_ECH_TECH]
			w_inter.num_port_sms, -- #1 [FNAC_PROD_ECH_TECH]
			w_inter.dte_naiss, -- [PMO89_RS4822]
			w_inter.ville_naiss, -- [PMO89_RS4822]
			w_inter.pays_naiss, -- [PMO89_RS4822]
			w_inter.cod_etat_ctrle_inter -- [PMO89_RS4822]
			
			)
			
	 Select 			
	 		@dcIdSin,
			@dcMaxInter,
			'B',
			'5',
			lib_ag,
			adr_1,
			adr_2,
			adr_cp,
			adr_ville,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			0.00,
			0.00,
			NULL,
			NULL,
			id_bq,
			id_ag,
			0,
			'O',
			0,
			'N',
			'N',
			'N',
			'N',
			NULL,
			NULL,
			'N',
			NULL,
			NULL,
			@dtCreeLe,
			@dtMajLe,
			@sCodOper,
			NULL,
			NULL,
			NULL,
			'N',
			NULL,
			NULL, -- #1 [FNAC_PROD_ECH_TECH]
			NULL,  -- #1 [FNAC_PROD_ECH_TECH]
			null, -- [PMO89_RS4822]
			null, -- [PMO89_RS4822]
			null, -- [PMO89_RS4822]
			0  -- [PMO89_RS4822]
			
	From sysadm.agence
	Where id_bq = '30066'
	And   id_ag = '99998'

   End 
/* Absolument retourner un nombre >0 */
Return 1   
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_CORRIGE_BLOB_VIDE
-- Auteur               :       Fabry JF
-- Date                 :       23/03/2001
-- Libellé              :        
-- Commentaires         :       Corrige le blob à Vide
--				
--	
-- Références           :       
--
-- Arguments            :       @dcIdIdSin	Decimal ( 7 ),
--				@dcIdI		Decimal ( 7 ),
--				@dcIdCpt	Decimal ( 7 ),
--				@sIdTypBlob	VarChar ( 2 )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CORRIGE_BLOB_VIDE' AND type = 'P' )
        DROP procedure sysadm.PS_CORRIGE_BLOB_VIDE
GO

CREATE procedure sysadm.PS_CORRIGE_BLOB_VIDE  
	@dcIdIdSin	Decimal ( 10 ),   -- [PI062]
	@dcIdI		Decimal ( 7 ),
	@dcIdCpt	Decimal ( 7 ),
	@sIdTypBlob	VarChar ( 2 )
AS

Update sysadm.w_inter
Set    alt_part = 'N', id_cour = null, id_nat_cour = null, alt_courgest = 'N', id_i_db= null, id_courj = null
Where   id_sin = @dcIdIdSin
And	id_i = @dcIdI

Delete from sysadm.w_cour_blob Where id_sin = @dcIdIdSin And id_i = @dcIdI And id_cpt = @dcIdCpt and id_typ_blob = @sIdTypBlob
Delete from sysadm.w_courrier Where id_sin = @dcIdIdSin And id_i = @dcIdI And id_cpt = @dcIdCpt

Update sysadm.w_queue 
Set alt_occupe = 'N'
Where id_sin = Convert ( VarChar ( 10 ), @dcIdIdSin )

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_PMO89_RS4822_PRESTA_CTRLE_INTER_ASSUREUR
-- Auteur               :       Fabry JF
-- Date                 :       05/06/2023
-- Libellé              :       Insertion des prestas liées aux contrôles assureurs
-- Commentaires         :       // [PMO89_RS4822] 
--				
--	
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PMO89_RS4822_PRESTA_CTRLE_INTER_ASSUREUR' AND type = 'P' )
        DROP procedure sysadm.PS_I_PMO89_RS4822_PRESTA_CTRLE_INTER_ASSUREUR
GO

CREATE procedure sysadm.PS_I_PMO89_RS4822_PRESTA_CTRLE_INTER_ASSUREUR  
	@adcIdSin Decimal ( 10 )
AS
Declare 
@iIdCle integer,
@dcIdSin decimal (10),
@dcIdI   decimal (2) ,
@sCodInter varchar (5),
@sCodCiv varchar (10),
@sLibCiv varchar (20),
@sNom varchar (71),
@sAdr1 varchar (35),
@sAdr2 varchar (35),
@sAdrCp varchar (5),
@sAdrVille varchar (35),
@sDteNaiss DateTime,
@sVilleNaiss varchar (35),
@sPaysNaiss varchar (35),
@dcIdGti Decimal (2),
@dcNewIdDetail Decimal (2),
@dcIdProd Decimal (7),
@iNewIdSeq Integer,
@sInfoSpbFrnCplt VarChar ( 800 ),
@dcIdRev Decimal (2 ),
@sNumTelD varchar ( 20 ),
@sLibTypInter Varchar ( 35 ),
@sMess VarChar ( 2000 ),
@iIdCt Integer

Declare @Tb Table ( 
id_cle integer identity,
id_sin decimal (10) ,
id_i decimal (2) ,
cod_inter varchar (5),
cod_civ varchar (10),
nom varchar (71),
adr_1 varchar (35),
adr_2 varchar (35),
adr_cp varchar (5),
adr_ville varchar (35),
num_tel_d varchar ( 20 ) ,
dte_naiss DateTime,
ville_naiss varchar (35),
pays_naiss varchar (35),
marquage integer)


-- Identifier les Interlocuteurs sur lesquels lancer une presta de contrôle
Insert Into @Tb
Select
wi.id_sin,
wi.id_i,
wi.cod_inter,
wi.cod_civ,
lTrim ( rtrim ( wi.nom)),
lTrim ( rtrim ( wi.adr_1)),
lTrim ( rtrim ( wi.adr_2)),
lTrim ( rtrim ( wi.adr_cp)),
lTrim ( rtrim ( wi.adr_ville)),
isnull (wi.num_teld, ''),
wi.dte_naiss,
lTrim ( rtrim ( wi.ville_naiss)),
lTrim ( rtrim ( wi.pays_naiss)),
0
From sysadm.w_inter wi,
	 sysadm.det_pro dp,
	 sysadm.w_sin ws
Where ws.id_sin = @adcIdSin
And   wi.id_sin = ws.id_sin
And   wi.cod_etat_ctrle_inter = 0
And   dp.id_prod = ws.id_prod
And   dp.id_code_dp = 365
And   CHARINDEX ( '#' + ltrim ( rtrim ( wi.cod_inter )) + '#', sysadm.FN_CLE_VAL ( 'TYP_INTER', dp.val_car, ';')) > 0 

If @@ROWCOUNT <= 0 Return

Select Top 1 @dcIdGti = wg.id_gti
From sysadm.w_gar_sin wg
where id_sin = @adcIdSin
and   cod_etat not in ( 900 ) 

Select @dcIdProd = ws.id_prod,
	   @dcIdRev = ws.id_rev
From sysadm.w_sin ws
Where ws.id_sin = @adcIdSin

If @dcIdRev is null Set @dcIdRev = 0
If @dcIdRev < 0 Set @dcIdRev = 0

-- Contrôle et redressement du paramètrage si besoin
Exec sysadm.PS_I_CREATION_AUTO_PARAM_CONDITION @dcIdProd , @dcIdRev, @dcIdGti, '+EV', 1482, 'N'

If @dcIdGti is null Set @dcIdGti = 0 
If @dcIdGti = 0 Return

Select	@dcNewIdDetail = max ( id_detail ) 
From	sysadm.w_detail
where   id_sin = @adcIdSin
and     id_gti = @dcIdGti 

If @dcNewIdDetail is null Set @dcNewIdDetail = -1 -- Car +1 donnera 0, le premier détail


Select	@iNewIdSeq = max ( id_seq ) 
From	sysadm.w_commande 
where   id_sin = @adcIdSin

If @iNewIdSeq is null Set @iNewIdSeq = 0 

While Exists ( Select Top 1 1 From @Tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdCle = id_cle,
		@dcIdSin = id_sin,
		@dcIdI = id_i,
		@sCodInter = cod_inter,
		@sCodCiv = cod_civ,
		@sNom = nom,
		@sAdr1 = adr_1,
		@sAdr2 = adr_2,
		@sAdrCp = adr_cp,
		@sAdrVille = adr_ville,
		@sDteNaiss = dte_naiss,
		@sVilleNaiss = ville_naiss,
		@sPaysNaiss = pays_naiss,
		@sNumTelD = num_tel_d
	From	@Tb
	Where	marquage = 0

	Select @sLibCiv = rTrim ( sysadm.FN_CODE_NUM ( @sCodCiv, '-CI' ) )
	Select @sLibTypInter = rTrim ( sysadm.FN_CODE_CAR ( @sCodInter, '-IN' ) )

	-- Créer un détail de support pour la presta
	Set @dcNewIdDetail = @dcNewIdDetail + 1	

	Insert into sysadm.w_detail 
	Select @adcIdSin,   @dcIdGti,   @dcNewIdDetail,   1482,   lib_det=null,   dte_det=null,   heu_det=null, num_carte=null,   mt_prej=0,   mt_fran=0,   mt_nplaf=0,   mt_plaf=0,   null, 'N', 'N', alt_plaf='N',   alt_reg='N',   alt_att='N', alt_valide='N',  1,  alt_ssui='O',   cod_mot_ssui=12,   cod_dec_mac=900,   cod_dec_ope=900,   cod_etat=900,   id_carte=0,   id_type_carte='00', getdate(),   getdate(),   'AUTO',   dte_cmd=null,   dte_livr=null,   mt_val_achat=null,   mt_val_publique=null,   num_facture=null

	Insert into sysadm.detail 
	Select @adcIdSin,   @dcIdGti,   @dcNewIdDetail,   1482,   id_reg=null,   id_i_reg=null,   lib_det=null,   dte_det=null,   heu_det=null, num_carte=null,   mt_prej=0,   mt_fran=0,   mt_nplaf=0,   mt_plaf=0,   alt_plaf='N',   alt_reg= 'N',   alt_att='N',   alt_ssui='O',   cod_mot_ssui=12,   cod_dec_mac=900,   cod_dec_ope=900,   cod_etat=900,   id_carte=0,   id_type_carte='00',   getdate(),   'AUTO',   getdate(),   getdate(),   'AUTO',   dte_cmd=null,   dte_livr=null,   mt_val_achat=null,   mt_val_publique=null,   num_facture=null


	-- Créer la presta elle-même
	Set @iNewIdSeq = @iNewIdSeq + 1	

	Set @sInfoSpbFrnCplt = 'ID_INTER=' + IsNull ( CONVERT (  varchar ( 5 ), @dcIdI ), '') + ';LIB_CIV=' + IsNull ( @sLibCiv, '')  + ';NOM=' + IsNull ( @sNom, '') + ';DTE_NAISS=' + CONVERT ( VarChar (10), IsNull ( @sDteNaiss, '01/01/1900'), 103 ) + ';VILLE_NAISS=' + IsNull ( @sVilleNaiss, '' ) + ';PAYS_NAISS=' + IsNull ( @sPaysNaiss, '' )
	Insert into sysadm.w_commande
	select @adcIdSin , @iNewIdSeq, @dcIdGti, @dcNewIdDetail, id_four='CDF', id_typ_art= 'CAF', 'Demande de Contrôle Interlocuteur', '', mt_ttc_cmde=0, adr_nom='X', adr_prenom='X', adr_livr1=@sAdr1, adr_livr2=@sAdr2, adr_livr_cpl=null, adr_cp=@sAdrCp, adr_ville=@sAdrVille, adr_tel1=@sNumTelD , adr_tel2=null, adr_tel3=null, adr_mail=null, dte_rdv_cli=null, hrdv_cli_min=null, hrdv_cli_max=null, id_serie_anc=null, 'Merci de contrôler cet interlocuteur', null,  null, null, null, null, 'ECT', null, 1, 'PRESTA AUTOMATIQUE', Getdate(), Getdate(), 'AUTO',  id_zone=null, id_bsp=null, dte_ret_pret=null, adr_cod_civ=@sCodCiv, 'DDE_CTRLE_INTER', id_orian_marque=null, id_orian_modele=null, dte_elv_mobile=null, 0, dte_emis_devis=null, mt_devis=null, null, dte_dev_acp=null, adrfc_cod_civ=null, adrfc_nom=null, adrfc_prenom=null, adrfc_livr1=null, adrfc_livr2=null, adrfc_livr_cpl=null, adrfc_cp=null, adrfc_ville=null, dte_ret_logis=null, dte_ret_pret_min=null, dte_ret_pret_max=null, id_ann=null, dte_env_bte_frn=null, dte_rcp_bte_cli=null, dte_dep_bte_cli=null, dte_env_st=null, dte_rcp_mob_cli=null, info_spb_frn=3410, id_marq_art_ifr=null, id_modl_art_ifr=null, info_spb_frn_cplt=@sInfoSpbFrnCplt , info_frn_spb_cplt=null

	Insert into sysadm.commande
	select @adcIdSin , @iNewIdSeq, @dcIdGti, @dcNewIdDetail, id_four='CDF', id_typ_art= 'CAF', 'Demande de Contrôle Interlocuteur', '', mt_ttc_cmde=0, adr_nom='X', adr_prenom='X', adr_livr1=@sAdr1, adr_livr2=@sAdr2, adr_livr_cpl=null, adr_cp=@sAdrCp, adr_ville=@sAdrVille, adr_tel1=@sNumTelD , adr_tel2=null, adr_tel3=null, adr_mail=null, dte_rdv_cli=null, hrdv_cli_min=null, hrdv_cli_max=null, id_serie_anc=null, 'Merci de contrôler cet interlocuteur', null,  null, null, null, null, 'ECT', null, 'PRESTA AUTOMATIQUE', 0, null, null, Getdate(), Getdate(), 'AUTO',  Getdate(),  'AUTO', id_zone=null, id_bsp=null, dte_ret_pret=null, adr_cod_civ=null, 'DDE_CTRLE_INTER', id_orian_marque=null, id_orian_modele=null, dte_elv_mobile=null, 0, dte_emis_devis=null, mt_devis=null, null, dte_dev_acp=null, adrfc_cod_civ=null, adrfc_nom=null, adrfc_prenom=null, adrfc_livr1=null, adrfc_livr2=null, adrfc_livr_cpl=null, adrfc_cp=null, adrfc_ville=null, dte_ret_logis=null, dte_ret_pret_min=null, dte_ret_pret_max=null, id_ann=null, dte_env_bte_frn=null, dte_rcp_bte_cli=null, dte_dep_bte_cli=null, dte_env_st=null, dte_rcp_mob_cli=null, info_spb_frn=3410, id_marq_art_ifr=null, id_modl_art_ifr=null, info_spb_frn_cplt=@sInfoSpbFrnCplt , info_frn_spb_cplt=null

	-- Maj du code état de l'inter
	Update sysadm.w_inter set cod_etat_ctrle_inter = 100 where id_sin = @adcIdSin and id_i = @dcIdI
	Update sysadm.inter set cod_etat_ctrle_inter = 100 where id_sin = @adcIdSin and id_i = @dcIdI

	Set @sMess = 'Engagement d''une demande de contrôle LCBFT vers l''assureur pour l''interlocuteur de type ' + @sLibTypInter + ' ' + @sNom + '. Vous ne pourrez pas régler le dossier tant que l''assureur n''aura pas répondu.'

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	'AUTO', 300, @iIdCt OUTPUT
	END
	ELSE
	BEGIN
		Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	'AUTO', 300, @iIdCt OUTPUT						
	END


	-- Marquage de l'enrg traité
	Update @Tb Set marquage = 1 Where id_cle = @iIdCle 
 End

Go

--------------------------------------------------------------------
--
-- Procédure            :       TR_LGY86_IU_ORIG_ADH
-- Auteur               :       Fabry JF
-- Date                 :       07/07/2025
-- Libellé              :       
-- Commentaires         :        [LGY86]
--				
--	
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_LGY86_IU_ORIG_ADH' AND xtype = 'TR' )
        DROP TRIGGER sysadm.TR_LGY86_IU_ORIG_ADH
GO

CREATE TRIGGER sysadm.TR_LGY86_IU_ORIG_ADH
ON sysadm.w_inter_encrypt
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    If Not Exists ( 
		Select Top 1 1
		From inserted i,
			 sysadm.w_inter_orig_adh orig
		Where orig.id_sin = i.id_sin
		and   orig.id_i = i.id_i
		and   orig.cod_inter = i.cod_inter
		and   i.cod_inter = 'A'  -- Que pour les assuré pour l'instant
	) 
	Begin

		Insert into sysadm.w_inter_orig_adh (
			id_sin,
			id_i,
			cod_inter,
			nom,
			adr_1,
			adr_2,
			adr_cp,
			adr_ville,
			num_teld,
			rib_bq,
			rib_gui,
			rib_cpt_encrypt,
			rib_cle,
			ordre_cheque,
			adr_mail,
			cree_le,
			maj_le,
			maj_par

		)
		Select Top 1 
			i.id_sin,
			i.id_i,
			i.cod_inter,
			i.nom,
			ltrim ( rtrim ( i.adr_1 )),
			ltrim ( rtrim ( i.adr_2 )),
			ltrim ( rtrim ( i.adr_cp )),
			ltrim ( rtrim ( i.adr_ville )),
			ltrim ( rtrim ( i.num_teld )),
			ltrim ( rtrim ( i.rib_bq )),
			ltrim ( rtrim ( i.rib_gui )),
			i.rib_cpt_encrypt,
			ltrim ( rtrim ( i.rib_cle )),
			ltrim ( rtrim ( i.ordre_cheque )),
			ltrim ( rtrim ( i.adr_mail )),
			i.cree_le,
			i.maj_le,
			i.maj_par
		From inserted i
		Where i.cod_inter = 'A' -- Que pour les assuré pour l'instant
		And Not Exists ( 
				Select Top 1 1
				From sysadm.w_inter_orig_adh orig
				Where orig.id_sin = i.id_sin
				and   orig.id_i = i.id_i
				and   orig.cod_inter = i.cod_inter
			)
	End 

END


Go
