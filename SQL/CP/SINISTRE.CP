-------------------------------------------------------------------
--
-- Fichier              :       Sinistre.cp
-- Auteur               :       YP
-- Date                 :       10/09/97 17:17:18
--
-- Commentaires         :       Liste des proc‚dures aff‚rents … la table SINISTRE
--
-- Proc‚dures           :       
-- sysadm.DW_S01_SINISTRE
-- sysadm.DW_S01_SINISTRE_CASTO
-- sysadm.DW_S02_SINISTRE
-- sysadm.DW_S03_SINISTRE_V01
-- sysadm.DW_S04_SINISTRE
-- sysadm.DW_S04_SINISTRE_V01
-- sysadm.PS_I01_SINISTRE_VAL
-- sysadm.PS_LIRE_MONTANT_V02
-- sysadm.PS_S01_SINISTRE_NBSIN_REGLES
-- sysadm.PS_U01_SINISTRE_VAL
-- sysadm.PS_U02_SINISTRE_VAL
-- sysadm.PS_V02_SIN
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_SINISTRE
-- Auteur               :       PLJ
-- Date                 :       16/07/1998
-- Libell‚              :        
-- Commentaires         :       S‚lection sur la table Sinistre et personne
-- R‚f‚rences           :       Utilis‚ dans W_CM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       La s‚lection
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_SINISTRE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_SINISTRE
GO

CREATE procedure sysadm.DW_S01_SINISTRE
        @dcIdSin        Decimal (  10,0 )  -- [PI062]
AS
 SELECT sinistre.id_sin,
        sinistre.id_prod,
        sinistre.id_rev,
        sinistre.id_ets,
        sinistre.id_adh,
        sinistre.id_sdos,
        sinistre.id_dos_cie,
        sinistre.id_natsin,
        sinistre.id_territ,
        sinistre.id_detsin,
        sinistre.cod_decl,
        sinistre.cod_i_decl,
        sinistre.dte_decl,
        sinistre.dte_surv,
        sinistre.heu_surv,
        sinistre.dte_adh,
        sinistre.dte_resil,
        sinistre.dte_fin_gti,
        sinistre.cod_opt,
        personne.cod_civ,
        personne.nom,
        personne.prenom,
        personne.adr_1,
        personne.adr_2,
        personne.adr_cp,
        personne.adr_ville,
        personne.num_fax,
        personne.num_telb,
        personne.num_teld,
        sinistre.mt_reg,
        sinistre.lieu,
        sinistre.txt_mess,
        sinistre.ref_cie,
        sinistre.id_carte,
        sinistre.id_type_carte,
        sinistre.cod_dec_mac,
        sinistre.cod_dec_ope,
        sinistre.cod_etat,
        sinistre.alt_ssui,
        sinistre.cod_mot_ssui,
        sinistre.id_ordre,    
        sinistre.cree_le,
        sinistre.maj_le,
        sinistre.maj_par,
        sinistre.valide_le,
        sinistre.valide_par,
        sinistre.cpt_reg,
	sinistre.num_port,
	sinistre.num_imei_port,
	sinistre.marq_port,
	sinistre.modl_port,
	sinistre.dte_ach_port,
	sinistre.dte_ouvlig_port,
        sinistre.id_contrat_abonne,
        sinistre.id_hlr,
        sinistre.id_orian_marque,
        sinistre.id_orian_modele,
        sinistre.id_orian_boutique
        
 FROM   sysadm.sinistre, sysadm.personne
 WHERE  sinistre.id_ordre = personne.id_ordre AND
	sinistre.id_sin = @dcIdSin

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I01_SINISTRE_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libell‚              :        
-- Commentaires         :       Insertion dans la table SINISTRE
-- R‚f‚rences           :       Utilis‚ dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdOrdre      Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_SINISTRE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_SINISTRE_VAL
GO

CREATE procedure sysadm.PS_I01_SINISTRE_VAL
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @dcIdOrdre      Decimal (  7,0 ),
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

 INSERT INTO    sysadm.sinistre
        (       sinistre.id_sin,
                sinistre.id_prod,
                sinistre.id_rev,
                sinistre.id_ets,
                sinistre.id_adh,
                sinistre.id_sdos,
                sinistre.id_ordre,
                sinistre.dte_adh,
                sinistre.dte_sous,
                sinistre.dte_opt,
                sinistre.cod_opt,
                sinistre.dte_resil,
                sinistre.dte_fin_gti,
                sinistre.id_dos_cie,
                sinistre.ref_cie,
                sinistre.cod_decl,
                sinistre.cod_i_decl,
                sinistre.dte_decl,
                sinistre.dte_surv,
                sinistre.heu_surv,
                sinistre.mt_reg,
                sinistre.lieu,
                sinistre.txt_mess,
                sinistre.cod_dec_mac,
                sinistre.cod_dec_ope,
                sinistre.cod_etat,
                sinistre.dte_ouv,
                sinistre.id_natsin,
                sinistre.id_territ,
                sinistre.id_detsin,
                sinistre.id_type_carte,
                sinistre.id_carte,
                sinistre.cpt_reg,
                sinistre.alt_ssui,
                sinistre.cod_mot_ssui,
                sinistre.cree_le,
                sinistre.maj_le,
                sinistre.maj_par, 
                sinistre.valide_le,
                sinistre.valide_par,
                sinistre.num_port,
                sinistre.num_imei_port,
                sinistre.marq_port,
                sinistre.modl_port,
                sinistre.dte_ach_port,
                sinistre.dte_ouvlig_port,
                sinistre.id_contrat_abonne,
                sinistre.id_hlr,
                sinistre.id_orian_marque,
                sinistre.id_orian_modele,
                sinistre.id_orian_boutique
                )
 SELECT         w_sin.id_sin,
                w_sin.id_prod,
                w_sin.id_rev,
                w_sin.id_ets,
                w_sin.id_adh,
                w_sin.id_sdos,
                @dcIdOrdre,
                w_sin.dte_adh,
                w_sin.dte_sous,
                w_sin.dte_opt,
                w_sin.cod_opt,
                w_sin.dte_resil,
                w_sin.dte_fin_gti,
                w_sin.id_dos_cie,
                w_sin.ref_cie,
                w_sin.cod_decl,
                w_sin.cod_i_decl,
                w_sin.dte_decl,
                w_sin.dte_surv,
                w_sin.heu_surv,
                w_sin.mt_reg + w_sin.mt_a_reg,
                w_sin.lieu,
                w_sin.txt_mess,
                w_sin.cod_dec_mac,
                w_sin.cod_dec_ope,
                w_sin.cod_etat,
                Convert ( DateTime, Convert ( Varchar ( 10 ), @dtValideLe, 103 ) ),
                w_sin.id_natsin,
                w_sin.id_territ,
                w_sin.id_detsin,
                w_sin.id_type_carte,
                w_sin.id_carte,
                0,
                w_sin.alt_ssui,
                w_sin.cod_mot_ssui,
                w_sin.cree_le,
                w_sin.maj_le,
                w_sin.maj_par,
                @dtValideLe,
                @sCodOper,
                w_sin.num_port,
                w_sin.num_imei_port,
                w_sin.marq_port,
                w_sin.modl_port,
                w_sin.dte_ach_port,
                w_sin.dte_ouvlig_port,
                w_sin.id_contrat_abonne,
                w_sin.id_hlr,
                w_sin.id_orian_marque,
                w_sin.id_orian_modele,
                w_sin.id_orian_boutique

 FROM           sysadm.w_sin
 WHERE          w_sin.id_sin = @dcIdSin

 Return @@RowCount

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_U01_SINISTRE_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libell‚              :        
-- Commentaires         :       Modification dans la table SINISTRE
-- R‚f‚rences           :       Utilis‚ dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF		02/11/2017   [VDOC24872]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_SINISTRE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U01_SINISTRE_VAL
GO


CREATE procedure sysadm.PS_U01_SINISTRE_VAL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

DECLARE @iIdCli int
DECLARE @iIdInfo int
DECLARE @sInfoOld varchar(60)
DECLARE @sInfoNew varchar(60)
DECLARE @sMajPar varchar(4)
DECLARE @iRet int
DECLARE @iNbLig int
DECLARE @iIdSin int


Select @sInfoOld = rtrim ( s.num_imei_port ) From sysadm.sinistre s where id_sin = @dcIdSin
If @sInfoOld is null Set @sInfoOld = ''

Select @sInfoNew = rtrim ( s.num_imei_port ) From sysadm.w_sin s where id_sin = @dcIdSin
If @sInfoNew is null Set @sInfoNew = ''

If @sInfoOld <> @sInfoNew 
	Begin
	Set @iIdSin = Convert ( int, @dcIdSin )
		
	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Select @iIdCli = id_cli From SHERPA_PRO.sysadm.sinistre where id_sin = @iIdSin And id_appli = 2

			EXECUTE SHERPA_PRO.[sysadm].[PS_U01_INFO_CLIENT_LIB] 
			@iIdCli
			,50          -- @iIdInfo 50 représente l'IMEI
			,@sInfoOld   -- Ancien IMEI
			,@sInfoNew   -- Nouvel IMEI
			,@sCodOper    -- Trigramme de SIMPA2
			,@iRet OUTPUT   -- Code erreur SQL (normalement 0)
			,@iNbLig OUTPUT -- Nombre de lignes affectées (normalement 1)

		END
		ELSE
		BEGIN
				Select @iIdCli = id_cli From SHERPA_SIM.sysadm.sinistre where id_sin = @iIdSin And id_appli = 2

				EXECUTE [SHERPA_SIM].[sysadm].[PS_U01_INFO_CLIENT_LIB] 
				@iIdCli
				,50          -- @iIdInfo 50 représente l'IMEI
				,@sInfoOld   -- Ancien IMEI
				,@sInfoNew   -- Nouvel IMEI
				,@sCodOper    -- Trigramme de SIMPA2
				,@iRet OUTPUT   -- Code erreur SQL (normalement 0)
				,@iNbLig OUTPUT -- Nombre de lignes affectées (normalement 1)
		END
	End 



 UPDATE sysadm.sinistre
 SET    sysadm.sinistre.id_prod                = w_sin.id_prod         ,
        sysadm.sinistre.id_rev                 = w_sin.id_rev          ,
        sysadm.sinistre.id_ets                 = w_sin.id_ets          ,
        sysadm.sinistre.id_adh                 = w_sin.id_adh          ,
        sysadm.sinistre.id_sdos                = w_sin.id_sdos         ,
        sysadm.sinistre.dte_adh                = w_sin.dte_adh         ,
        sysadm.sinistre.dte_sous               = w_sin.dte_sous        ,
        sysadm.sinistre.dte_opt                = w_sin.dte_opt         ,
        sysadm.sinistre.cod_opt                = w_sin.cod_opt         ,
        sysadm.sinistre.dte_resil              = w_sin.dte_resil       ,
        sysadm.sinistre.dte_fin_gti            = w_sin.dte_fin_gti     ,
        sysadm.sinistre.id_dos_cie             = w_sin.id_dos_cie      ,
        sysadm.sinistre.ref_cie                = w_sin.ref_cie         ,
        sysadm.sinistre.cod_decl               = w_sin.cod_decl        ,
        sysadm.sinistre.cod_i_decl             = w_sin.cod_i_decl      ,
        sysadm.sinistre.dte_decl               = w_sin.dte_decl        ,
        sysadm.sinistre.dte_surv               = w_sin.dte_surv        ,
        sysadm.sinistre.heu_surv               = w_sin.heu_surv        ,
        sysadm.sinistre.mt_reg                 = w_sin.mt_reg + w_sin.mt_a_reg ,
        sysadm.sinistre.lieu                   = w_sin.lieu            ,
        sysadm.sinistre.txt_mess               = w_sin.txt_mess        ,
        sysadm.sinistre.cod_dec_mac            = w_sin.cod_dec_mac     ,
        sysadm.sinistre.cod_dec_ope            = w_sin.cod_dec_ope     ,
        sysadm.sinistre.cod_etat               = w_sin.cod_etat        ,
        sysadm.sinistre.id_natsin              = w_sin.id_natsin       ,
        sysadm.sinistre.id_territ              = w_sin.id_territ       ,
        sysadm.sinistre.id_detsin              = w_sin.id_detsin       ,
        sysadm.sinistre.id_type_carte          = w_sin.id_type_carte   ,
        sysadm.sinistre.id_carte               = w_sin.id_carte        ,
        sysadm.sinistre.alt_ssui               = w_sin.alt_ssui        ,
        sysadm.sinistre.cod_mot_ssui           = w_sin.cod_mot_ssui    ,
        sysadm.sinistre.maj_le                 = w_sin.maj_le          ,
        sysadm.sinistre.maj_par                = w_sin.maj_par         ,
        sysadm.sinistre.valide_le              = @dtValideLe           ,
        sysadm.sinistre.valide_par             = @sCodOper             ,
		sysadm.sinistre.num_port				= w_sin.num_port	, 
        sysadm.sinistre.num_imei_port          = w_sin.num_imei_port   , 
        sysadm.sinistre.marq_port              = w_sin.marq_port       ,
        sysadm.sinistre.modl_port              = w_sin.modl_port       ,
        sysadm.sinistre.dte_ach_port           = w_sin.dte_ach_port    ,
        sysadm.sinistre.dte_ouvlig_port        = w_sin.dte_ouvlig_port ,
        sysadm.sinistre.id_contrat_abonne      = w_sin.id_contrat_abonne       ,
        sysadm.sinistre.id_hlr                 = w_sin.id_hlr          ,
        sysadm.sinistre.id_orian_marque        = w_sin.id_orian_marque ,
        sysadm.sinistre.id_orian_modele        = w_sin.id_orian_modele ,
        sysadm.sinistre.id_orian_boutique      = w_sin.id_orian_boutique
        
 FROM   sysadm.sinistre, 
        sysadm.w_sin
 WHERE  w_sin.id_sin    = @dcIdSin         AND
        sinistre.id_sin = w_sin.id_sin

 Return @@RowCount

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_U02_SINISTRE_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libell‚              :        
-- Commentaires         :       Validation finale du dossier
-- R‚f‚rences           :       Utilis‚ dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--                      :       @dcCodEtat      Decimal (  7,0 )        (Val)
--                      :       @dcIdOrdre      Decimal (  7,0 )        (Val)
--                      :       @sNoBoite       VarChar ( 10   )        (Val)
--			:	@sMethode	VarChar (  3 )		(Val)  // DCMP 040020 "SVE" ou ""
--
-- Retourne             :       Rien
-- 
-- #1  JFF	  06/02/2006    [SITE_CMDE] Gestion des nouvelles option d'autorisation 79, 80, 81
-- JFF   12/02/2016   [PI062]
-- JFF   09/09/2022   [PM80_FA12_FRANEX]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U02_SINISTRE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U02_SINISTRE_VAL
GO

CREATE procedure sysadm.PS_U02_SINISTRE_VAL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime        ,
        @dcCodEtat      Decimal (  7,0 ),
        @dcIdOrdre      Decimal (  7,0 ),
        @sNoBoite       VarChar ( 10   ),
        @sMethode	VarChar (  3 )
AS

Declare @iRet   Integer

Select @iRet = 1

 IF     @dcCodEtat = 200 Or @dcCodEtat = 900
        Begin
                DELETE FROM     sysadm.w_frais
                WHERE           w_frais.id_sin          = @dcIdSin
                IF      @@Error <> 0 Return -1

				If @sMethode = 'SVE'
				 Begin
					DELETE FROM     sysadm.w_cour_blob 
					WHERE           w_cour_blob.id_sin     = @dcIdSin
					IF      @@Error <> 0 Return -1
				 End
				Else
				 Begin
					DELETE FROM     sysadm.w_inter_blob 
					WHERE           w_inter_blob.id_sin     = @dcIdSin
					IF      @@Error <> 0 Return -1
				 End

                DELETE FROM     sysadm.w_div_det
                WHERE           w_div_det.id_sin        = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_para_info
                WHERE           w_para_info.id_sin      = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_courrier
                WHERE           w_courrier.id_sin       = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_inter
                WHERE           w_inter.id_sin          = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_refus
                WHERE           w_refus.id_sin          = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_piece
                WHERE           w_piece.id_sin          = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_para_plafond
                WHERE           w_para_plafond.id_sin   = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_commande
                WHERE           w_commande.id_sin       = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_detail
                WHERE           w_detail.id_sin         = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_gar_sin
                WHERE           w_gar_sin.id_sin        = @dcIdSin
                IF      @@Error <> 0 Return -1

				-- [PM80_FA12_FRANEX]
				DELETE FROM     sysadm.w_reg_frais_annexe_frn
				WHERE           w_reg_frais_annexe_frn.id_sin        = @dcIdSin
				IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_reg_gti
                WHERE           w_reg_gti.id_sin        = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_div_sin
                WHERE           w_div_sin.id_sin        = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_sin
                WHERE           w_sin.id_sin            = @dcIdSin
                IF      @@Error <> 0 Return -1

			
				/* En th‚orie, il ne devrait pas y avoir de commandes valid‚es
	 			   si le dossier est refus‚ ou sans suite, mais par prudence
	 			   je bascule quand les codes ‚tats des commandes. */
	 			UPDATE sysadm.commande
	 			SET    sysadm.commande.cod_etat = 'ECT'
	 			WHERE  id_sin   = @dcIdSin
	 			AND    cod_etat = 'CNV'
	 			AND    Left ( id_four, 2 ) <> 'WB'  -- #1
				IF     @@Error <> 0 Return -1

				-- #1 Cas Commande WEB
	 			UPDATE sysadm.commande
	 			SET    sysadm.commande.cod_etat = 'CWE'
	 			WHERE  id_sin   = @dcIdSin
	 			AND    cod_etat = 'CNV'
	 			AND    Left ( id_four, 2 ) = 'WB'   
				IF     @@Error <> 0 Return -1


				EXEC @iRet = sysadm.PS_U02_ROUTAGE_VAL @dcIdSin, 'CAS',
								@sCodOper, @dtValideLe, @sNoBoite
				If @iRet <> 1 Return -1

        End

 IF     @dcCodEtat = 500 Or @dcCodEtat = 600
        Begin

                DELETE FROM     sysadm.w_div_det
                WHERE           w_div_det.id_sin        = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_frais
                WHERE           w_frais.id_sin          = @dcIdSin
                IF      @@Error <> 0 Return -1

				If @sMethode = 'SVE'
				 Begin
					DELETE FROM     sysadm.w_cour_blob 
					WHERE           w_cour_blob.id_sin     = @dcIdSin
					IF      @@Error <> 0 Return -1
				 End
				Else
				 Begin
					DELETE FROM     sysadm.w_inter_blob 
					WHERE           w_inter_blob.id_sin     = @dcIdSin
					IF      @@Error <> 0 Return -1
				 End

                DELETE FROM     sysadm.w_para_info
                WHERE           w_para_info.id_sin      = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_courrier
                WHERE           w_courrier.id_sin       = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_inter
                WHERE           w_inter.id_sin          = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_refus
                WHERE           w_refus.id_sin          = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_piece
                WHERE           w_piece.id_sin          = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_para_plafond
                WHERE           w_para_plafond.id_sin   = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_commande
                WHERE           w_commande.id_sin         = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_detail
                WHERE           w_detail.id_sin         = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_gar_sin
                WHERE           w_gar_sin.id_sin        = @dcIdSin
                IF      @@Error <> 0 Return -1

				-- [PM80_FA12_FRANEX]
				DELETE FROM     sysadm.w_reg_frais_annexe_frn
				WHERE           w_reg_frais_annexe_frn.id_sin        = @dcIdSin
				IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_reg_gti
                WHERE           w_reg_gti.id_sin        = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_div_sin
                WHERE           w_div_sin.id_sin        = @dcIdSin
                IF      @@Error <> 0 Return -1

                DELETE FROM     sysadm.w_sin
                WHERE           w_sin.id_sin            = @dcIdSin
                IF      @@Error <> 0 Return -1

                UPDATE  sysadm.gar_sin
                SET     sysadm.gar_sin.cod_etat = 600
                WHERE   gar_sin.id_sin          = @dcIdSin       AND
                        gar_sin.cod_etat        = 500
                IF      @@Error <> 0 Return -1

                UPDATE  sysadm.sinistre
                SET     sysadm.sinistre.cod_etat = 600
                WHERE   sinistre.id_sin          = @dcIdSin
                IF      @@RowCount <> 1 Return -1

	 			UPDATE  sysadm.commande
	 			SET     sysadm.commande.cod_etat = 'ECT'
	 			WHERE   id_sin   = @dcIdSin
	 			AND     cod_etat = 'CNV'
	 			AND    Left ( id_four, 2 ) <> 'WB'  -- #1
				IF      @@Error <> 0 Return -1

				-- #1 Cas Commande WEB
	 			UPDATE sysadm.commande
	 			SET    sysadm.commande.cod_etat = 'CWE'
	 			WHERE  id_sin   = @dcIdSin
	 			AND    cod_etat = 'CNV'
	 			AND    Left ( id_four, 2 ) = 'WB'   
				IF     @@Error <> 0 Return -1


                EXEC @iRet = sysadm.PS_U02_ROUTAGE_VAL @dcIdSin, 'CAS',
                             @sCodOper, @dtValideLe, @sNoBoite
                If @iRet <> 1 Return -1

        End

 IF     @dcCodEtat = 100 Or @dcCodEtat = 550
        Begin

	 		UPDATE  sysadm.commande
	 		SET     sysadm.commande.cod_etat = 'ECT'
	 		WHERE   id_sin   = @dcIdSin
	 		AND     cod_etat = 'CNV'
	 		AND    Left ( id_four, 2 ) <> 'WB'  -- #1
			IF      @@Error <> 0 Return -10

			-- #1 Cas Commande WEB
	 		UPDATE sysadm.commande
	 		SET    sysadm.commande.cod_etat = 'CWE'
	 		WHERE  id_sin   = @dcIdSin
	 		AND    cod_etat = 'CNV'
	 		AND    Left ( id_four, 2 ) = 'WB'   
			IF     @@Error <> 0 Return -101


	 		UPDATE  sysadm.w_commande
	 		SET     sysadm.w_commande.cod_etat         = 'ECT',
	 			sysadm.w_commande.cpt_valide       = cpt_valide + 1
	 		WHERE   id_sin   = @dcIdSin
	 		AND     cod_etat = 'CNV'
	 		AND    Left ( id_four, 2 ) <> 'WB'  -- #1
			IF      @@Error <> 0 Return -11

			-- #1 Cas Commande WEB
	 		UPDATE  sysadm.w_commande
	 		SET     sysadm.w_commande.cod_etat         = 'CWE',
	 			sysadm.w_commande.cpt_valide       = cpt_valide + 1
	 		WHERE   id_sin   = @dcIdSin
	 		AND     cod_etat = 'CNV'
	 		AND     Left ( id_four, 2 ) = 'WB'   	 	
			IF      @@Error <> 0 Return -111


            UPDATE  sysadm.w_sin
            SET     sysadm.w_sin.cpt_valide        = w_sin.cpt_valide + 1,
                    sysadm.w_sin.alt_adr           = 'N',
                    sysadm.w_sin.cod_prov_pers     = 'P',
                    sysadm.w_sin.mt_reg            = w_sin.mt_reg + w_sin.mt_a_reg,
                    sysadm.w_sin.mt_a_reg          = 0,
                    sysadm.w_sin.id_ordre          = @dcIdOrdre
            WHERE   w_sin.id_sin            = @dcIdSin
            IF      @@RowCount <> 1 Return -1

            UPDATE  sysadm.w_gar_sin
            SET     sysadm.w_gar_sin.cpt_valide    = w_gar_sin.cpt_valide + 1,
                    sysadm.w_gar_sin.alt_valide    = 'N',
                    sysadm.w_gar_sin.mt_prej_reg   = sysadm.w_gar_sin.mt_prej_reg  + sysadm.w_gar_sin.mt_prej_areg,
                    sysadm.w_gar_sin.mt_fran_reg   = sysadm.w_gar_sin.mt_fran_reg  + sysadm.w_gar_sin.mt_fran_areg,
                    sysadm.w_gar_sin.mt_nplaf_reg  = sysadm.w_gar_sin.mt_nplaf_reg + sysadm.w_gar_sin.mt_nplaf_areg,
                    sysadm.w_gar_sin.mt_plaf_reg   = sysadm.w_gar_sin.mt_plaf_reg  + sysadm.w_gar_sin.mt_plaf_areg, 
                    sysadm.w_gar_sin.mt_dedu_reg   = sysadm.w_gar_sin.mt_dedu_reg  + sysadm.w_gar_sin.mt_dedu_areg, 
                    sysadm.w_gar_sin.mt_prej_areg  = 0,
                    sysadm.w_gar_sin.mt_fran_areg  = 0,
                    sysadm.w_gar_sin.mt_nplaf_areg = 0,
                    sysadm.w_gar_sin.mt_plaf_areg  = 0,
                    sysadm.w_gar_sin.mt_dedu_areg  = 0  
            WHERE   w_gar_sin.id_sin        = @dcIdSin      AND
                    w_gar_sin.alt_valide    = 'O'           
            IF      @@Error <> 0 Return -2

            UPDATE  sysadm.w_gar_sin
            SET     sysadm.w_gar_sin.cod_etat      = 600
            WHERE   w_gar_sin.id_sin        = @dcIdSin      AND
                    w_gar_sin.cod_etat      = 500           
            IF      @@Error <> 0 Return -3

            UPDATE  sysadm.w_detail
            SET     sysadm.w_detail.cpt_valide     = w_detail.cpt_valide + 1,
                    sysadm.w_detail.alt_valide     = 'N'
            WHERE   w_detail.id_sin         = @dcIdSin      AND
                    w_detail.alt_valide     = 'O'           
            IF      @@Error <> 0 Return -4


	-- DCMP990452 ajout alt_quest = 'N' par JFF le 01/10/99
            UPDATE  sysadm.w_inter
            SET     sysadm.w_inter.cpt_valide      = w_inter.cpt_valide + 1,
                    sysadm.w_inter.alt_valide      = 'N',
                    sysadm.w_inter.alt_ps          = 'N',
                    sysadm.w_inter.alt_part        = 'N',
                    sysadm.w_inter.alt_pce         = 'N',
                    sysadm.w_inter.alt_quest       = 'N',
					sysadm.w_inter.id_nat_cour     = null,
                    sysadm.w_inter.id_cour         = null,
                    sysadm.w_inter.mt_a_reg        = 0,
                    sysadm.w_inter.mt_reg          = w_inter.mt_a_reg + w_inter.mt_reg
            WHERE   w_inter.id_sin          = @dcIdSin      AND
                    w_inter.alt_valide      = 'O'           
            IF      @@Error <> 0 Return -5
                
            UPDATE  sysadm.gar_sin
            SET     sysadm.gar_sin.cod_etat        = 600
            WHERE   gar_sin.id_sin          = @dcIdSin      AND
                    gar_sin.cod_etat        = 500           
            IF      @@Error <> 0 Return -6
                
			UPDATE  sysadm.w_div_sin
			SET     sysadm.w_div_sin.cpt_valide     = w_div_sin.cpt_valide + 1
			WHERE   w_div_sin.id_sin = @dcIdSin    
			IF      @@Error <> 0 Return -12

			UPDATE  sysadm.w_div_det
			SET     sysadm.w_div_det.cpt_valide     = w_div_det.cpt_valide + 1
			WHERE   w_div_det.id_sin = @dcIdSin    
			IF      @@Error <> 0 Return -13

			If @sMethode = 'SVE'
			 Begin
				DELETE FROM     sysadm.w_cour_blob 
				WHERE           w_cour_blob.id_sin     = @dcIdSin
				IF      @@Error <> 0 Return -7
			 End
			Else
			 Begin
				DELETE FROM     sysadm.w_inter_blob 
				WHERE           w_inter_blob.id_sin     = @dcIdSin
				IF      @@Error <> 0 Return -7
			 End			

            DELETE FROM     sysadm.w_para_info
            WHERE           w_para_info.id_sin      = @dcIdSin
            IF      @@Error <> 0 Return -8

            DELETE FROM     sysadm.w_courrier
            WHERE           w_courrier.id_sin       = @dcIdSin
            IF      @@Error <> 0 Return -9

			-- [PM80_FA12_FRANEX]
			DELETE FROM     sysadm.w_reg_frais_annexe_frn
			WHERE           w_reg_frais_annexe_frn.id_sin        = @dcIdSin
			IF      @@Error <> 0 Return -1

            DELETE FROM     sysadm.w_reg_gti
            WHERE           w_reg_gti.id_sin        = @dcIdSin
            IF      @@Error <> 0 Return -1

            DELETE FROM     sysadm.w_para_plafond
            WHERE           w_para_plafond.id_sin   = @dcIdSin
            IF      @@Error <> 0 Return -1

            EXEC @iRet = sysadm.PS_U02_ROUTAGE_VAL @dcIdSin, 'CPL',
                            @sCodOper, @dtValideLe, NULL
            If @iRet <> 1 Return -10

        End

 Return @iRet

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S02_SINISTRE
-- Auteur               :       JFF
-- Date                 :       25/01/99 13:08:00
-- Libell‚              :       R‚cap des dossiers ouverts sur une p‚riode de dates 
-- Commentaires         :       Pour la compta analytique
-- R‚f‚rences           :       Utilis‚ dans 
--
-- Arguments            :       @dDateMin        DateTime        (Val)
--				@dDateMax        DateTime        (Val)	
--
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_SINISTRE' AND type = 'P' )
        DROP procedure sysadm.DW_S02_SINISTRE
GO

CREATE procedure sysadm.DW_S02_SINISTRE
	@dDateMin	DateTime,
	@dDateMax	DateTime

AS


SELECT 
	'NUM_DEPT' 	  = produit.id_dept,
	'NUM_PROD' 	  = produit.id_prod,
	'LIB_PROD' 	  = produit.lib_long,
	'NBRE_SIN_OUVERT' = count(sinistre.id_sin)

FROM 
	sysadm.sinistre,
	sysadm.produit

WHERE	
	sinistre.dte_ouv between @dDateMin and @dDateMax  	AND
	produit.id_prod  = sinistre.id_prod
	

GROUP BY
	produit.id_dept,
	produit.id_prod,
	produit.lib_long

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_LIRE_MONTANT_V02
-- Auteur               :       FABRY JF
-- Date                 :	01/08/2008
-- Libell‚              :       ramène la somme déjà réglé + la somme à régler sur le dossier
-- Commentaires         :       [DOUBLE_VALIDATION]
-- R‚f‚rences           :       Utilis‚ dans 
--
-- Arguments            :       @dcIdSin Decimal (7)
--				@dcMtTotal Decimal ( 11,2 ) OUTPUT
--
-- Retourne             :       Rien
--------------------------------------------------------------------- 
-- #1	28/01/2009	JFF	[20090128152140087] On déduit les FM des montants à règler.
--                      Demande ER, ML réunion du 28/01/2009
-- 	28/03/2011	JFF     [DECIMAL_PAPILLON] Je caste l'Id_sin en Décimal !!
--  22/04/2015  JFF     [VDOC16311]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_LIRE_MONTANT_V02' AND type = 'P' )
        DROP procedure sysadm.PS_LIRE_MONTANT_V02
GO

CREATE procedure sysadm.PS_LIRE_MONTANT_V02
   @iIdSin Integer           -- Numéro de sinistre
AS
   Declare @dcMtTotal Decimal ( 11,2 ) 
   Declare @dcMtReg Decimal ( 11,2 )
   Declare @dcMtAReg Decimal ( 11,2 )
   Declare @dcMtFMaDeduire Decimal ( 11,2 ) -- #1 [20090128152140087]
   Declare @dcIdSin Decimal ( 10 )  -- [DECIMAL_PAPILLON] 	 -- [PI062]
   Declare @dcMtACommander Decimal ( 11,2 ) -- [VDOC16311]

   Set @dcMtTotal = 0
   Set @dcMtReg = 0
   Set @dcMtAReg = 0
   Set @dcMtACommander = 0 -- [VDOC16311]
   Set @dcIdSin = convert ( decimal (10), @iIdSin ) -- [PI062]

   Select @dcMtReg = IsNull (Sum ( IsNull ( mt_tot_reg , 0 ) ) , 0 ) 
   from   sysadm.reglement r
   Where  r.id_sin = @dcIdSin
   And    r.cod_mode_reg not in ( 'RI' )

   Select @dcMtAReg = IsNull ( Sum ( IsNull ( ws.mt_a_reg , 0 ) ) , 0 )
   from   sysadm.w_sin ws
   Where  ws.id_sin = @dcIdSin	

   -- [VDOC16311]
	If Exists ( 
		-- Cette requête est plus couteuse que la seconde, et permet de sortir maintenant si pas de CNV
		Select  Top 1 1
		From	sysadm.w_commande c
		Where	c.id_sin = @dcIdSin	
		And		c.cod_etat = 'CNV'
	)
	  Begin
		Select  @dcMtACommander =
				IsNull ( 
					nullif ( MAX ( c.mt_ttc_cmde ), 0 ),
					MAX ( dd.val_mt )
					   )
		From	sysadm.w_commande c,
				sysadm.w_div_det dd
		Where	c.id_sin = @dcIdSin	
		And		c.cod_etat = 'CNV'
		And		sysadm.FN_A_COMMANDER ( c.id_sin, c.id_seq, 'W' ) = 'A_COMMANDER'
		And		dd.id_sin = c.id_sin
		And		dd.id_gti = c.id_gti
		And		dd.id_detail = c.id_detail
		And		dd.nom_zone = 'mt_pec'
		
		If @dcMtACommander is null Set @dcMtACommander = 0
		If @dcMtACommander <= 0 Set @dcMtACommander = 0			
		
		Set @dcMtAReg = @dcMtAReg + @dcMtACommander
		
	  End		

   Select @dcMtFMaDeduire = IsNull ( Sum ( IsNull ( wi.mt_a_reg, 0 ) ), 0 )
   from   sysadm.w_inter wi
   Where  wi.id_sin = @dcIdSin 
   And    wi.mt_a_reg > 0
   And    wi.cod_mode_reg = 'FM'

   Set  @dcMtAReg = @dcMtAReg - @dcMtFMaDeduire -- #1 [20090128152140087]
   If @dcMtAReg < 0 Set @dcMtAReg = 0 -- #1 [20090128152140087] Sécurité... (normalement impossible)
   
   Set 	@dcMtTotal = @dcMtReg + @dcMtAReg

   Select @dcMtTotal as mt_total, @dcMtAReg as mt_a_verser

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_V02_SIN
-- Auteur               :       FPI
-- Date                 :       19/02/2010
-- Libell‚              :        
-- Commentaires         :       [DCMP100102] Existence de dossier de sinistre
-- R‚f‚rences           :       w_sp_trt_autre_fichier (pbl des commandes)
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       0 si le sinistre n'existe pas, 1 sinon
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_V02_SIN' AND type = 'P' )
        DROP procedure sysadm.PS_V02_SIN
GO

CREATE procedure sysadm.PS_V02_SIN
   @iIdSin Decimal (  10,0 ) -- [PI062]
AS
	Declare @nbRows Integer
	
	Set @nbRows = 0
	
	Select @nbRows = Count(*)
	From sysadm.w_sin w
	Where w.id_sin = @iIdSin

	If @nbRows =0
	Begin
	  Select @nbRows = Count(*)
	  From sysadm.sinistre s
	  Where s.id_sin = @iIdSin
	End

	Return @nbRows
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S03_SINISTRE_V01
-- Auteur               :       FPI
-- Date                 :       30/07/2010
-- Libell‚              :        
-- Commentaires         :       [20100730.FPI] Correction pour la fenêtre d'intégration autres fichiers
--				-> V01 - [VDoc2282]
-- R‚f‚rences           :       d_trt_charge_lst_sin
--
-- Arguments            :       @sListeIdSin	Varchar(1000)       (Val)
--
-- Retourne             :       des informations sur la liste des sinistres fournis
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_SINISTRE_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S03_SINISTRE_V01
GO

CREATE procedure sysadm.DW_S03_SINISTRE_V01
   @sListeIdSin	Varchar(8000)
AS
	Declare @t TABLE (id_sin decimal(10,0))  -- [PI062]
	Declare @iPos int

-- Décomposition en table
While LEN(@sListeIdSin) > 0
Begin
	set @iPos=charindex(',',@sListeIdSin)
	If @iPos=0 
	Begin
		Insert into @t select @sListeIdSin
		set @sListeIdSin=''
	End 
	Else
	Begin
		Insert into @t select LEFT(@sListeIdSin,@iPos-1)
		Set @sListeIdSin=SUBSTRING(@sListeIdSin,@iPos+1,8000)
	End
End

-- Select
SELECT distinct convert(varchar(10),s.id_sin) as id_sin,  -- [PI062]
		convert(varchar(10),s.dte_surv,103) as date_surv, 
		convert(varchar(10),s.dte_ach_port  ,103) as date_achat, 
		( select top 1 convert(varchar(10), isnull (d.mt_val_achat, 0 ) ) from sysadm.detail d where s.id_sin=d.id_sin and d.id_evt=936 ) as mt_achat,
		( select top 1 convert(varchar(10), isnull (d.mt_val_publique, 0 ) ) from sysadm.detail d where s.id_sin=d.id_sin and d.id_evt=936 ) as mt_publique ,
		p.nom + ' ' + p.prenom as nom_assure, s.marq_port, s.modl_port, sysadm.FN_CODE_CAR(d.val_car,'-AR') as type_app,
		sysadm.FN_LIB_PROD(s.id_prod) as lib_produit,
		(select top 1 co.lib_cie 
		 from sysadm.w_gar_sin w
		 inner join sysadm.garantie g on g.id_prod = s.id_prod and g.id_rev = s.id_rev and g.id_gti = w.id_gti
		 inner join sysadm.police po on po.id_police=g.id_police
		 inner join sysadm.compagnie co on co.id_cie=po.id_cie
		 where w.id_sin=s.id_sin) as 'nom_assureur'
FROM sysadm.w_sin s 
	inner join @t t on s.id_sin=t.id_sin
	inner join personne p on p.id_ordre=s.id_ordre
	left outer join w_div_sin d on s.id_sin=d.id_sin and d.nom_zone='type_app'
UNION 
SELECT distinct convert(varchar(10),s.id_sin) as id_sin,   -- [PI062]
	convert(varchar(10),s.dte_surv,103) as date_surv, 
	convert(varchar(10),s.dte_ach_port  ,103) as date_achat, 
	( select top 1 convert(varchar(10), isnull (d.mt_val_achat, 0 ) ) from sysadm.detail d where s.id_sin=d.id_sin and d.id_evt=936 ) as mt_achat,
	( select top 1 convert(varchar(10), isnull (d.mt_val_publique, 0 ) ) from sysadm.detail d where s.id_sin=d.id_sin and d.id_evt=936 ) as mt_publique, 
	p.nom + ' ' + p.prenom as nom_assure, s.marq_port, s.modl_port, sysadm.FN_CODE_CAR(d.val_car,'-AR') as type_app,
	sysadm.FN_LIB_PROD(s.id_prod) as lib_produit,
		(select top 1 co.lib_cie 
		 from sysadm.gar_sin w
		 inner join sysadm.garantie g on g.id_prod = s.id_prod and g.id_rev = s.id_rev and g.id_gti = w.id_gti
		 inner join sysadm.police po on po.id_police=g.id_police
		 inner join sysadm.compagnie co on co.id_cie=po.id_cie
		 where w.id_sin=s.id_sin) as 'nom_assureur'
FROM sysadm.sinistre  s 
	inner join @t t on s.id_sin=t.id_sin
	inner join personne p on p.id_ordre=s.id_ordre
	left outer join div_sin d on s.id_sin=d.id_sin and d.nom_zone='type_app'
order by id_sin
	
Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S04_SINISTRE
-- Auteur               :       FPI
-- Date                 :       17/08/2011	
-- Libell‚              :        Renvoie les informations de sinistre pour la fen de règlt manuel PM72
-- Commentaires         :       [PM72.2]
-- R‚f‚rences           :       d_sp_cas_rm_frais
--
-- Arguments            :       @dcIdSin decimal(7,0)       (Val)
--
-- Retourne             :       des informations sur le sinistre
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_SINISTRE' AND type = 'P' )
        DROP procedure sysadm.DW_S04_SINISTRE
GO

CREATE procedure sysadm.DW_S04_SINISTRE
   @dcIdSin decimal(10,0)  -- [PI062]
AS
  Select s.id_sin,
	p.nom, p.prenom,
	s.id_prod, s.id_ets, s.id_adh, s.id_sdos,
	s.dte_surv, s.dte_adh,
	i.nom as nom_assure,
	i.adr_1, i.adr_2, i.adr_cp, i.adr_ville,
	sysadm.FN_CODE_CAR(
		Case When rib_bq is null Then 'C' Else i.cod_mode_reg End,'-MR') as mode_reglement,
	i.rib_bq, i.rib_gui, i.rib_cpt, i.rib_cle
  From sysadm.sinistre s
    Inner join sysadm.personne p on p.id_ordre = s.id_ordre
    Inner join sysadm.inter i on i.id_sin = s.id_sin
  Where s.id_sin =  @dcIdSin
    And i.cod_inter = 'A'

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S04_SINISTRE_V01
-- Auteur               :       FPI
-- Date                 :       17/08/2011	
-- Libell‚              :        Renvoie les informations de sinistre pour la fen de règlt manuel PM72
-- Commentaires         :       [PM72.2]
-- R‚f‚rences           :       d_sp_cas_rm_frais
--
-- Arguments            :       @dcIdSin decimal(7,0)       (Val)
--
-- Retourne             :       des informations sur le sinistre
--
-------------------------------------------------------------------
-- FPI	26/12/2011  - V01 - [PM72_DOMCOM] VDoc 6404
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_SINISTRE_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S04_SINISTRE_V01
GO

CREATE procedure sysadm.DW_S04_SINISTRE_V01
   @dcIdSin decimal(10,0)  -- [PI062]
AS
  Select s.id_sin,
	p.nom, p.prenom,
	s.id_prod, s.id_ets, s.id_adh, s.id_sdos,
	s.dte_surv, s.dte_adh,
	i.nom as nom_assure,
	i.adr_1, i.adr_2, i.adr_cp, i.adr_ville,
	sysadm.FN_CODE_CAR(
		Case When rib_bq is null Then 'C' Else i.cod_mode_reg End,'-MR') as mode_reglement,
	i.rib_bq, i.rib_gui, i.rib_cpt, i.rib_cle,
	(select val_nbre  from sysadm.div_sin where id_sin=@dcIdSin and Upper (nom_zone) = 'ID_CLI_BQ') as id_cli_bq
  From sysadm.sinistre s
    Inner join sysadm.personne p on p.id_ordre = s.id_ordre
    Inner join sysadm.inter i on i.id_sin = s.id_sin
  Where s.id_sin =  @dcIdSin
    And i.cod_inter = 'A'
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_SINISTRE_NBSIN_REGLES
-- Auteur               :       FPI
-- Date                 :       26/11/2011
-- Libellé              :       [PC801]
-- Commentaires         :       Calcul du nombre de sinistres par adhesion (Renouvellement) réglés
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_SINISTRE_NBSIN_REGLES' AND type = 'P' )
        DROP procedure sysadm.PS_S01_SINISTRE_NBSIN_REGLES
GO


CREATE procedure sysadm.PS_S01_SINISTRE_NBSIN_REGLES
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
	@iNbSin		Integer	 OUTPUT
	
AS
 SELECT @iNbSin  = count ( * )
 FROM   sysadm.sinistre s
	left outer join sysadm.commande c on c.id_sin=s.id_sin and c.cod_etat <> 'ANN' and c.id_typ_art not in ('EDI','PRS')
 WHERE  s.id_sin        <> @dcIdSin                              AND
        s.id_prod        = @dcIdProd                             AND
        s.id_ets         = @dcIdEts                              AND
        s.id_adh         = @sIdAdh                               AND
        s.dte_surv      <= @dtSurv                               AND
        s.dte_surv      >= @dtAdhRenouv                          AND
        ( s.cod_etat      in ( 550, 600 ) or c.id_seq is not null )

GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_SINISTRE_CASTO_V01
-- Auteur               :       FPI
-- Date                 :       19/09/2016
-- Libell‚              :        
-- Commentaires         :       [VDOC19525]
--
-- R‚f‚rences           :       d_trt_charge_lstsin_casto
--
-- Arguments            :       @sListeIdSin	Varchar(1000)       (Val)
--
-- Retourne             :       des informations sur la liste des sinistres fournis
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-- FPI		18/11/2016		[VDoc22376]
-- 	FPI		13/02/2017		[VDoc22486] ajout colonne 'date_mise_sans_suite'
--	FPI		08/02/2018		[VDoc25677] - V01 - ajout colonne 'Cause_attente'
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_SINISTRE_CASTO_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S01_SINISTRE_CASTO_V01
GO

CREATE procedure sysadm.DW_S01_SINISTRE_CASTO_V01
   @sListeIdSin	Varchar(8000)
AS
	Declare @t TABLE (id_sin decimal(10,0))  -- [PI062]
	Declare @iPos int

-- Décomposition en table
While LEN(@sListeIdSin) > 0
Begin
	set @iPos=charindex(',',@sListeIdSin)
	If @iPos=0 
	Begin
		Insert into @t select @sListeIdSin
		set @sListeIdSin=''
	End 
	Else
	Begin
		Insert into @t select LEFT(@sListeIdSin,@iPos-1)
		Set @sListeIdSin=SUBSTRING(@sListeIdSin,@iPos+1,8000)
	End
End

-- Select
select distinct s.id_sin,
	sysadm.FN_CODE_NUM(d.id_evt,'+EV') as lib_detail,
	Case When exists (select 1 from div_det dd where dd.id_sin=d.id_sin and dd.id_gti=d.id_gti and dd.id_detail=d.id_detail
		and dd.nom_zone='pec' and val_car='O') Then 'Oui' Else 'Non' end as pec_cochee,
	(select val_mt from div_det dd where dd.id_sin=d.id_sin and dd.id_gti=d.id_gti and dd.id_detail=d.id_detail
		and dd.nom_zone='mt_pec') as mt_pec,
	(select val_car from div_det dd where dd.id_sin=d.id_sin and dd.id_gti=d.id_gti and dd.id_detail=d.id_detail
		and dd.nom_zone='note_debit_1') as note_debit_1,
	(select val_car from sysadm.div_det dd 
		where dd.id_sin=d.id_sin and dd.id_gti=d.id_gti and dd.id_detail=d.id_detail
			and dd.nom_zone='note_debit_2') as no_note_debit_2,
	(select val_car from div_det dd where dd.id_sin=d.id_sin and dd.id_gti=d.id_gti and dd.id_detail=d.id_detail
		and dd.nom_zone='prix_remise_1') as prix_remise_1                      ,
	(select val_car from sysadm.div_det dd 
		where dd.id_sin=d.id_sin and dd.id_gti=d.id_gti and dd.id_detail=d.id_detail
			and dd.nom_zone='prix_remise_2') as prix_remise_2,
	Case When dd.val_car='O' Then 'Oui' Else 'Non' end as bon_a_regler_cochee,
	r.mt_tot_reg,
	r.lib_reg,
	b.id_boutique,
	b.adr_ville,
	convert(varchar(10),s.dte_decl,103) as date_decla,
	convert(varchar(10),dd.maj_le,103) as date_cochage_bon_a_regler,
	Case When s.cod_etat=900 Then convert(varchar(10),s.valide_le,103) Else NULL End as date_mise_sans_suite,
	(select sysadm.FN_CODE_CAR(dd.val_car, dd.id_typ_liste) from sysadm.div_det dd 
		where dd.id_sin=d.id_sin and dd.id_gti=d.id_gti and dd.id_detail=d.id_detail
			and dd.nom_zone='cause_attente') as Cause_attente
FROM sysadm.sinistre  s 
	inner join @t t on s.id_sin=t.id_sin
	left outer join sysadm.detail d on d.id_sin=s.id_sin
	left outer join sysadm.inter i on s.id_sin=i.id_sin and i.id_four='CAS'
	left outer join sysadm.reglement r on r.id_sin=s.id_sin and r.id_reg=d.id_reg
	left outer join sysadm.boutique b on b.id_boutique=s.id_orian_boutique and b.id_prod=s.id_prod
	left outer join sysadm.div_det dd on dd.id_sin=d.id_sin and dd.id_gti=d.id_gti and dd.id_detail=d.id_detail
		and dd.nom_zone='bon_a_regler'
order by s.id_sin
	
Go

grant execute on sysadm.DW_S01_SINISTRE_CASTO_V01 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_SINISTRE_ZVAR_DT262
-- Auteur               :       JFF
-- Date                 :       10/01/2017
-- Libellé              :       [DT262]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_SINISTRE_ZVAR_DT262' AND type = 'P' )
        DROP procedure sysadm.PS_S01_SINISTRE_ZVAR_DT262
GO

CREATE procedure sysadm.PS_S01_SINISTRE_ZVAR_DT262
   @adcIdSin	Decimal ( 10 ),
   @asZvarNbreIndem	VarChar ( 10 ) OUTPUT,
   @asZvarIndem	VarChar ( 8000 ) OUTPUT
AS

Declare @dcIdEts Decimal ( 7 )
Declare @sIdAdh  VarChar ( 19 )
Declare @dcIdProd Decimal ( 7 )
Declare @iIdSeq integer
Declare @sIdSin varChar ( 10 )
Declare @sDteSurv Varchar ( 20 )
Declare @sDteIndem Varchar ( 20 )

Set @asZvarIndem = ''
Set @asZvarNbreIndem = ''

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	Varchar ( 10 ),
	  dte_surv  Varchar ( 20 ),
	  dte_surv2 DateTime,
	  dte_indem Varchar ( 20 ),
	  marquage	integer null 
	)

	
Select @dcIdEts = s.id_ets,
	   @sIdAdh  = s.id_adh,
	   @dcIdProd = s.id_prod
From	sysadm.w_sin s
Where  s.id_sin = @adcIdSin

Insert into @tb
Select  Convert ( VarChar ( 10 ), s.id_sin ) 'id_sin',
		sysadm.FN_AFF_DATE ( s.dte_surv, 'SH' ) 'dte_surv',
		s.dte_surv 'dte_surv2',
		sysadm.FN_AFF_DATE_CLOTURE_ASS ( s.id_sin ) 'dte_indem',
		0
From	sysadm.sinistre s,
		sysadm.div_sin ds
Where   s.id_prod = @dcIdProd
And		s.id_ets = @dcIdEts
And		s.id_adh = @sIdAdh
And		ds.id_sin = s.id_sin
And		ds.nom_zone = 'etat_vu_assure'
and		ds.val_nbre in ( 1500, 1510, 1520 )
And		s.id_sin <> @adcIdSin

Select @asZvarNbreIndem = Convert ( VarChar ( 10), count(*) ) From @tb
If @asZvarNbreIndem is null Set @asZvarNbreIndem = '0'

While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@sIdSin = id_sin,
		@sDteSurv = dte_surv,
		@sDteIndem = dte_indem
	From	@tb
	Where	marquage = 0
	Order by dte_surv2

	Set @asZvarIndem = @asZvarIndem + '- Sinistre n° ' + @sIdSin + ' survenu le ' + @sDteSurv + ' indemnisé le ' + @sDteIndem + Char ( 11 )

	Update @tb
	Set marquage = 1
	Where id_seq = @iIdSeq
 End

 If @asZvarIndem is null Set @asZvarIndem = ''

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_VDOC24032_GENESYS
-- Auteur               :       JFF
-- Date                 :       10/01/2017
-- Libellé              :       [PM411]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF		02/11/2017   [EVOL_FRED]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC24032_GENESYS_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC24032_GENESYS_V01
GO

CREATE procedure sysadm.PS_S_VDOC24032_GENESYS_V01
	@sNumTel	VarChar ( 10 )
AS

SET NOCOUNT ON

Declare @iIdCli Int

Set @sNumTel = rtrim( ltrim ( @sNumTel ))

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ),
	  etat		varchar ( 35 ),
	  id_cli_sherpa integer,
	  adr_mail_simpa2 VarChar (200),
	  cree_le DateTime
	)


IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Insert into @tb
		Select  s.id_sin,
				sysadm.FN_CODE_NUM ( ds.val_nbre, '-ET' ) 'etat',
				shs.id_cli 'id_cli_sherpa',
				rtrim ( i.adr_mail ) 'adr_mail_simpa2',
				s.cree_le

		From	sysadm.sinistre s,
				sysadm.div_sin ds,
				SHERPA_PRO.sysadm.sinistre shs,
				sysadm.inter i
		Where   s.num_port = @sNumTel
		and     ds.id_sin = s.id_sin
		and     ds.nom_zone = 'etat_vu_assure'
		and		ds.val_nbre in ( 100, 550, 1540, 1550 )
		And		shs.id_sin = convert ( int, s.id_sin ) 
		And		shs.id_appli = 2
		And		i.id_sin = s.id_sin
		And		i.cod_inter = 'A'
		Order by s.cree_le desc

		Select  Top 1
				id_sin, etat, id_cli_sherpa, adr_mail_simpa2
		From	@tb 
	END
ELSE
	BEGIN
		Insert into @tb
		Select  s.id_sin,
				sysadm.FN_CODE_NUM ( ds.val_nbre, '-ET' ) 'etat',
				shs.id_cli 'id_cli_sherpa',
				rtrim ( i.adr_mail ) 'adr_mail_simpa2',
				s.cree_le

		From	sysadm.sinistre s,
				sysadm.div_sin ds,
				SHERPA_SIM.sysadm.sinistre shs,
				sysadm.inter i
		Where   s.num_port = @sNumTel
		and     ds.id_sin = s.id_sin
		and     ds.nom_zone = 'etat_vu_assure'
		and		ds.val_nbre in ( 100, 550, 1540, 1550 )
		And		shs.id_sin = convert ( int, s.id_sin ) 
		And		shs.id_appli = 2
		And		i.id_sin = s.id_sin
		And		i.cod_inter = 'A'
		Order by s.cree_le desc

		Select  Top 1
				id_sin, etat, id_cli_sherpa, adr_mail_simpa2
		From	@tb 
	END
GO

grant execute on sysadm.PS_S_VDOC24032_GENESYS_V01 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM369_2_SUIVI_ATLAS
-- Auteur               :       JFF
-- Date                 :       17/10/2017
-- Libellé              :       [PM369-2]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM369_2_SUIVI_ATLAS' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM369_2_SUIVI_ATLAS
GO

CREATE procedure sysadm.PS_S_PM369_2_SUIVI_ATLAS
	@dcIdSin	Decimal ( 10 )
AS

If Exists ( 
	Select	Top 1 1
	From	sysadm.det_pro dp,
			sysadm.sinistre s
	Where	s.id_sin = @dcIdSin
	And		dp.id_prod = s.id_prod
	And		dp.id_code_dp = 316 )
	Begin 
		Return 1
	End 

Return 0

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S_FACTU_CASTO
-- Auteur               :       FPI
-- Date                 :       26/12/2017
-- Libell‚              :        
-- Commentaires         :       [VDOC24986]
--
-- R‚f‚rences           :       d_trt_charge_factu_casto
--
-- Arguments            :       @sListeIdSin	Varchar(1000)       (Val)
--
-- Retourne             :       des informations sur la liste des sinistres fournis
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_FACTU_CASTO' AND type = 'P' )
        DROP procedure sysadm.DW_S_FACTU_CASTO
GO

CREATE procedure sysadm.DW_S_FACTU_CASTO
   @sListeIdSin	Varchar(8000)
AS
	Declare @t TABLE (id_sin decimal(10,0))  -- [PI062]
	Declare @iPos int

-- Décomposition en table
While LEN(@sListeIdSin) > 0
Begin
	set @iPos=charindex(',',@sListeIdSin)
	If @iPos=0 
	Begin
		Insert into @t select @sListeIdSin
		set @sListeIdSin=''
	End 
	Else
	Begin
		Insert into @t select LEFT(@sListeIdSin,@iPos-1)
		Set @sListeIdSin=SUBSTRING(@sListeIdSin,@iPos+1,8000)
	End
End

-- Select
select s.id_sin, d.num_facture, d.mt_val_achat, r.mt_tot_reg
from sysadm.sinistre s
	inner join @t t on s.id_sin=t.id_sin
	left outer join sysadm.detail d on d.id_sin=s.id_sin and d.id_reg > 0
	left outer join sysadm.reglement r on r.id_sin=s.id_sin and (r.id_reg=d.id_reg or r.id_reg_base=d.id_reg)
order by s.id_sin
	
Go

grant execute on sysadm.DW_S_FACTU_CASTO to rolebddsinistres
Go
