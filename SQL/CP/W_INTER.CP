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
--  JFF		12/02/2016		[PI062]
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
	w_inter.num_port_sms -- #1 [FNAC_PROD_ECH_TECH]
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
	@sNumPortSms    Varchar ( 20 ) -- #1 [FNAC_PROD_ECH_TECH]

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
		w_inter.num_port_sms -- #1 [FNAC_PROD_ECH_TECH]
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
		@sNumPortSms   -- #1 [FNAC_PROD_ECH_TECH]
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
		w_inter.num_port_sms -- #1 [FNAC_PROD_ECH_TECH]
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
		inter.num_port_sms -- #1 [FNAC_PROD_ECH_TECH]
		
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
		w_inter.num_port_sms -- #4 [FNAC_PROD_ECH_TECH]
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
		@sNumPortSms -- #4 [FNAC_PROD_ECH_TECH]
		
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
		w_inter.num_port_sms -- #1 [FNAC_PROD_ECH_TECH]
	
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
		NULL  -- #1 [FNAC_PROD_ECH_TECH]
	
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
			w_inter.num_port_sms -- #1 [FNAC_PROD_ECH_TECH]
			
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
			NULL  -- #1 [FNAC_PROD_ECH_TECH]
			
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

