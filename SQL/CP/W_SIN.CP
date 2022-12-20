-------------------------------------------------------------------
--
-- Fichier              :       w_sin.cp
-- Auteur               :       YP
-- Date                 :       10/09/97 17:17:18
--
-- Commentaires         :       Liste des proc‚dures aff‚rentes … la table W_SINISTRE
--
-- Procedures           :       DW_S01_W_SIN
--                              PS_I01_W_SIN_WKF
--                              PS_I02_W_SIN_WKF
--                              PS_U01_W_SIN_WKF
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       DW_S01_W_SIN
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libelle              :        
-- Commentaires         :       Select sur la table W_SIN
-- References           :       Utilis‚ dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- #1	09/12/2009	PHG	Troncature à 20 car du num_imei_port pour [FNAC_EPT]
--		25/06/2010	EMD	[DCMP100420] Agrandissement du numéro de série
--  JFF		12/02/2016		[PI062]
--  JFF     30/09/2020      [PI097]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_SIN' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_SIN
GO

CREATE procedure sysadm.DW_S01_W_SIN
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS
 SELECT w_sin.id_sin,
        w_sin.id_prod,
        w_sin.id_rev,
        w_sin.id_ets,
        w_sin.id_adh,
        w_sin.id_sdos,
        w_sin.id_dos_cie,
        w_sin.id_natsin,
        w_sin.id_territ,
        w_sin.id_detsin,
        w_sin.cod_decl,
        w_sin.cod_i_decl,
        w_sin.dte_decl,
        w_sin.dte_surv,
        w_sin.heu_surv,
        w_sin.dte_adh,
        w_sin.dte_sous,
        w_sin.dte_opt,
        w_sin.cod_opt,
        w_sin.dte_resil,
        w_sin.dte_fin_gti,
        w_sin.dte_fin_gti_prec,
        w_sin.cod_civ,
        w_sin.nom,
        w_sin.prenom,
        w_sin.adr_1,
        w_sin.adr_2,
        w_sin.adr_cp,
        w_sin.adr_ville,
        w_sin.num_fax,
        w_sin.num_telb,
        w_sin.num_teld,
        w_sin.mt_a_reg,
        w_sin.mt_reg,
        w_sin.lieu,
        w_sin.txt_mess,
        w_sin.ref_cie,
        w_sin.id_carte,
        w_sin.id_type_carte,
        w_sin.cod_dec_mac,
        w_sin.cod_dec_ope,
        w_sin.cod_etat,
        w_sin.alt_ssui,
        w_sin.cod_mot_ssui,
        w_sin.id_ordre,
        w_sin.cod_prov_pers,
        w_sin.alt_bloc,
        w_sin.cpt_valide,
        w_sin.alt_rapatrier,
        w_sin.cree_le,
        w_sin.maj_le,
        w_sin.maj_par,
        w_sin.alt_adr,
        'N',
        '0',
  	Convert ( DateTime, '1900-01-01 0:00' ),
	w_sin.num_port,
	w_sin.num_imei_port num_imei_port, -- [PI097] Suppression du rtrim
	w_sin.marq_port,
	w_sin.modl_port,
	w_sin.dte_ach_port,
	w_sin.dte_ouvlig_port,
	'O',
        w_sin.id_contrat_abonne,
        w_sin.id_hlr,
        w_sin.id_orian_marque,
        w_sin.id_orian_modele,
        w_sin.id_orian_boutique
        
 FROM   sysadm.w_sin
 WHERE  w_sin.id_sin 	= @dcIdSin

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_I01_W_SIN_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libelle              :        
-- Commentaires         :       Insertion dans W_SIN       
-- References           :       Utilis‚ dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_SIN_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_SIN_WKF
GO

CREATE procedure sysadm.PS_I01_W_SIN_WKF
        @dcIdSin        Decimal (  10,0 ) -- [PI062] 
AS
 INSERT INTO    sysadm.w_sin
        (       w_sin.id_sin,
                w_sin.id_prod,
                w_sin.id_rev,
                w_sin.id_ets,
                w_sin.id_adh,
                w_sin.id_sdos,
                w_sin.id_dos_cie,
                w_sin.id_natsin,
                w_sin.id_territ,
                w_sin.id_detsin,
                w_sin.cod_decl,
                w_sin.cod_i_decl,
                w_sin.dte_decl,
                w_sin.dte_surv,
                w_sin.heu_surv,
                w_sin.dte_adh,
                w_sin.dte_sous,
                w_sin.dte_opt,
                w_sin.cod_opt,
                w_sin.dte_resil,
                w_sin.dte_fin_gti,
                w_sin.dte_fin_gti_prec,
                w_sin.cod_civ,
                w_sin.nom,
                w_sin.prenom,
                w_sin.adr_1,
                w_sin.adr_2,
                w_sin.adr_cp,
                w_sin.adr_ville,
                w_sin.num_fax,
                w_sin.num_telb,
                w_sin.num_teld,
                w_sin.mt_a_reg,
                w_sin.mt_reg,
                w_sin.lieu,
                w_sin.txt_mess,
                w_sin.ref_cie,
                w_sin.id_carte,
                w_sin.id_type_carte,
                w_sin.cod_dec_mac,
                w_sin.cod_dec_ope,
                w_sin.cod_etat,
                w_sin.alt_ssui,
                w_sin.cod_mot_ssui,
                w_sin.id_ordre,
                w_sin.cod_prov_pers,
                w_sin.alt_bloc,
                w_sin.cpt_valide,
                w_sin.alt_rapatrier,
                w_sin.cree_le,
                w_sin.maj_le,
                w_sin.maj_par,
                w_sin.alt_adr,
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
                )
 SELECT         sinistre.id_sin,
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
                sinistre.dte_sous,
                sinistre.dte_opt,
                sinistre.cod_opt,
                sinistre.dte_resil,
                sinistre.dte_fin_gti,
                sinistre.dte_fin_gti,
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
                0.00,
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
                'P',
                'N',
                1,
                'O',
			    sinistre.cree_le,
                sinistre.maj_le,
                sinistre.maj_par,
                'N',
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

                
 FROM           sysadm.sinistre,
                sysadm.personne
 WHERE          sinistre.id_sin         = @dcIdSin               AND
                sinistre.id_ordre       = personne.id_ordre    

 Return @@RowCount

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_I02_W_SIN_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libelle              :        
-- Commentaires         :       Insertion dans W_SIN       
-- References           :       Utilis‚ dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin                Decimal (  7,0 )        (Val)
--                      :       @dcIdProd               Decimal (  7,0 )        (Val)
--                      :       @dcIdEts                Decimal (  7,0 )        (Val)
--                      :       @sIdAdh                 Varchar ( 19   )        (Val)
--                      :       @dcIdsDos               Decimal (  2,0 )        (Val)
--                      :       @sCodRecu               Varchar (  1   )        (Val)
--                      :       @sCodIProv              Varchar (  1   )        (Val)
--                      :       @dtDteDecl              DateTime                (Val)
--                      :       @dtDteSurv              DateTime                (Val)
--                      :       @dtDteAdh               DateTime                (Val)
--                      :       @dtDteSous              DateTime                (Val)
--                      :       @dtDteOpt               DateTime                (Val)
--                      :       @dcOption               Decimal (  2,0 )        (Val)
--                      :       @dtDteResil             DateTime                (Val)
--                      :       @dtDteFinGti            DateTime                (Val)
--                      :       @sCodCiv                Varchar (  1   )        (Val)
--                      :       @sNom                   Varchar ( 35   )        (Val)
--                      :       @sPrenom                Varchar ( 35   )        (Val)
--                      :       @sAdr1                  Varchar ( 35   )        (Val)
--                      :       @sAdr2                  Varchar ( 35   )        (Val)
--                      :       @sAdrCp                 Varchar (  5   )        (Val)
--                      :       @sAdrVille              Varchar ( 35   )        (Val)
--                      :       @sNumFax                Varchar ( 20   )        (Val)
--                      :       @sNumTelB               Varchar ( 20   )        (Val)
--                      :       @sNumTelD               Varchar ( 20   )        (Val)
--                      :       @sTxtMess1              Varchar ( 254  )        (Val)
--                      :       @dcIdCarte              Decimal (  7,0 )        (Val)
--                      :       @sIdTypeCarte           Varchar (  3   )        (Val)
--                      :       @dcIdPersonne           Decimal (  7,0 )        (Val)
--                      :       @sCodProvPers           Varchar (  1   )        (Val)
--                      :       @dtCreeLe               DateTime                (Val)
--                      :       @dtMajLe                DateTime                (Val)
--                      :       @sCodOper               Varchar (  4   )        (Val)
--                      :       @sNumPort               Varchar ( 25   )        (Val)
--                      :       @sNumImeiPort           Varchar ( 25   )        (Val)
--                      :       @sMarqPort              Varchar ( 35   )        (Val)
--                      :       @sModlPort              Varchar ( 35   )        (Val)
--                      :       @dtAchPort              DateTime                (Val)
--                      :       @dtOuvLigPort           DateTime                (Val)
--                      :       @sIdContratAbonne       Varchar ( 20   )        (Val)
--                      :       @iIdHlr                 Integer                 (Val)
--                      :       @iIdOrianMarque         Integer                 (Val)
--                      :       @iIdOrianModele         Integer                 (Val)
--                      :       @iIdOrianBouutique      Integer                 (Val)
--
-- Retourne             :       Rien
---------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
---------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I02_W_SIN_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_I02_W_SIN_WKF
GO

CREATE procedure sysadm.PS_I02_W_SIN_WKF
        @dcIdSin                Decimal (  10,0 ),   -- [PI062]
        @dcIdProd               Decimal (  7,0 ),
        @dcIdEts                Decimal (  7,0 ),
        @sIdAdh                 Varchar ( 19   ),
        @dcIdsDos               Decimal (  2,0 ),
        @sCodRecu               Varchar (  1   ),
        @sCodIProv              Varchar (  1   ),
        @dtDteDecl              DateTime        ,
        @dtDteSurv              DateTime        ,
        @dtDteAdh               DateTime        ,
        @dtDteSous              DateTime        ,
        @dtDteOpt               DateTime        ,
        @dcOption               Decimal (  2,0 ),
        @dtDteResil             DateTime        ,
        @dtDteFinGti            DateTime        ,
        @sCodCiv                Varchar (  1   ),
        @sNom                   Varchar ( 35   ),
        @sPrenom                Varchar ( 35   ),
        @sAdr1                  Varchar ( 35   ),
        @sAdr2                  Varchar ( 35   ),
        @sAdrCp                 Varchar (  5   ),
        @sAdrVille              Varchar ( 35   ),
        @sNumFax                Varchar ( 20   ),
        @sNumTelB               Varchar ( 20   ),
        @sNumTelD               Varchar ( 20   ),
        @sTxtMess1              Varchar ( 254  ),
        @dcIdCarte              Decimal (  7,0 ),
        @sIdTypeCarte           Varchar (  3   ),
        @dcIdPersonne           Decimal (  7,0 ),
        @sCodProvPers           Varchar (  1   ),
        @dtCreeLe               DateTime        ,
        @dtMajLe                DateTime        ,
        @sCodOper               Varchar (  4   ),
        @sNumPort               Varchar ( 25   ),
        @sNumImeiPort           Varchar ( 25   ),
        @sMarqPort              Varchar ( 35   ),
        @sModlPort              Varchar ( 35   ),
        @dtAchPort              DateTime        ,
        @dtOuvLigPort           DateTime        ,
        @sIdContratAbonne       Varchar ( 20   ),
        @lIdOrianHlr            Integer         ,
        @lIdOrianMarque         Integer         ,
        @lIdOrianModele         Integer         ,
        @lIdOrianBoutique       Integer
AS
 INSERT INTO    sysadm.w_sin
        (       w_sin.id_sin,
                w_sin.id_prod,
                w_sin.id_rev,
                w_sin.id_ets,
                w_sin.id_adh,
                w_sin.id_sdos,
                w_sin.id_dos_cie,
                w_sin.id_natsin,
                w_sin.id_territ,
                w_sin.id_detsin,
                w_sin.cod_decl,
                w_sin.cod_i_decl,
                w_sin.dte_decl,
                w_sin.dte_surv,
                w_sin.heu_surv,
                w_sin.dte_adh,
                w_sin.dte_sous,
                w_sin.dte_opt,
                w_sin.cod_opt,
                w_sin.dte_resil,
                w_sin.dte_fin_gti,
                w_sin.dte_fin_gti_prec,
                w_sin.cod_civ,
                w_sin.nom,
                w_sin.prenom,
                w_sin.adr_1,
                w_sin.adr_2,
                w_sin.adr_cp,
                w_sin.adr_ville,
                w_sin.num_fax,
                w_sin.num_telb,
                w_sin.num_teld,
                w_sin.mt_a_reg,
                w_sin.mt_reg,
                w_sin.lieu,
                w_sin.txt_mess,
                w_sin.ref_cie,
                w_sin.id_carte,
                w_sin.id_type_carte,
                w_sin.cod_dec_mac,
                w_sin.cod_dec_ope,
                w_sin.cod_etat,
                w_sin.alt_ssui,
                w_sin.cod_mot_ssui,
                w_sin.id_ordre,
                w_sin.cod_prov_pers,
                w_sin.alt_bloc,
                w_sin.cpt_valide,
                w_sin.alt_rapatrier,
                w_sin.cree_le,
                w_sin.maj_le,
                w_sin.maj_par,
                w_sin.alt_adr,
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
                )
 VALUES (       @dcIdSin,
                @dcIdProd,
                -1,
                @dcIdEts,
                @sIdAdh,
                @dcIdsDos,
                NULL,
                0,
                0,
                0,
                @sCodRecu,
                @sCodIProv,
                @dtDteDecl,
                @dtDteSurv,
                NULL,
                @dtDteAdh,
                @dtDteSous,
                @dtDteOpt,
                @dcOption,
                @dtDteResil,
                @dtDteFinGti,
                @dtDteFinGti,
                @sCodCiv,
                @sNom,
                @sPrenom,
                @sAdr1,
                @sAdr2,
                @sAdrCp,
                @sAdrVille,
                @sNumFax,
                @sNumTelB,
                @sNumTelD,
                0.00,
                0.00,
                NULL,
                @sTxtMess1,
                NULL,
                @dcIdCarte,
                @sIdTypeCarte,
                0,
                0,
                0,
                'N',
                0,
                @dcIdPersonne,
                @sCodProvPers,
                'N',
                0,
                'N',
                @dtCreeLe,
                @dtMajLe,
                @sCodOper,
                'N',
                @sNumPort,
                @sNumImeiPort,
                @sMarqPort,
                @sModlPort,
                @dtAchPort,
                @dtOuvLigPort,
                @sIdContratAbonne,
                @lIdOrianHlr,
                @lIdOrianMarque,
                @lIdOrianModele,
                @lIdOrianBoutique )

 Return @@RowCount

GO


--------------------------------------------------------------------
--
-- Procedure            :       PS_U01_W_SIN_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libelle              :        
-- Commentaires         :       Modification de DTE_FIN_GTI (W_SIN)
-- References           :       Utilis‚ dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dtDteFinGti    DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_W_SIN_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_U01_W_SIN_WKF
GO

CREATE procedure sysadm.PS_U01_W_SIN_WKF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dtDteFinGti    DateTime

AS
 UPDATE         sysadm.w_sin
 SET            sysadm.w_sin.dte_fin_gti_prec  = sysadm.w_sin.dte_fin_gti,
                sysadm.w_sin.dte_fin_gti       = @dtDteFinGti
 WHERE          sysadm.w_sin.id_sin            = @dcIdSin

 Return @@RowCount

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_W_SIN_NBRE_SIN_EC
-- Auteur               :       Fabry JF
-- Date                 :       23/11/12
-- Libellé              :       [PC877]
-- Commentaires         :       
-- Références           :       
--
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_W_SIN_NBRE_SIN_EC' AND type = 'P' )
        DROP procedure sysadm.PS_S_W_SIN_NBRE_SIN_EC
GO


CREATE procedure sysadm.PS_S_W_SIN_NBRE_SIN_EC
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProdAdh    Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @sSIREN			Varchar ( 20   ),
        @sChaineSin	VarChar ( 250 ) Output
AS
Declare @s1 VarChar ( 250 )
Declare @s2 VarChar ( 250 )

Select @s1 = (
 	  SELECT CAST(rtrim ( w.id_sin ) + ', ' AS VARCHAR(250)) 
 	  FROM sysadm.w_sin w
 	  Where w.id_prod between @dcIdProdAdh * 100 And (@dcIdProdAdh * 100) + 99
 	  And   
 		  (		w.id_ets = @dcIdEts
 		  And   w.id_adh = @sIdAdh
 		  And   w.id_sin <> @dcIdSin
 		  )
	  OR  (		w.id_contrat_abonne = @sSIREN )
 	  
 	  For XML PATH ('') )

Select @s2 = (
 	  SELECT CAST(rtrim ( w.id_sin ) + ', ' AS VARCHAR(250)) 
 	  FROM sysadm.sinistre w
 	  Where w.id_prod between @dcIdProdAdh * 100 And (@dcIdProdAdh * 100) + 99
 	  And   
 		  (		w.id_ets = @dcIdEts
 		  And   w.id_adh = @sIdAdh
 		  And   w.id_sin <> @dcIdSin
 		  )
	  OR  (		w.id_contrat_abonne = @sSIREN )
 	  For XML PATH ('') )

If @s1 is null Set @s1 = ''
If @s2 is null Set @s2 = ''

Set @sChaineSin = @s1 + @s2 
Set @sChaineSin = SUBSTRING ( @sChaineSin, 1, LEN ( rTrim ( @sChaineSin )) - 1 )

Go


