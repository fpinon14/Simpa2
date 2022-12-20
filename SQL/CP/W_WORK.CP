-------------------------------------------------------------------
--
-- Fichier              :       W_WORK.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion du WorkFlow dans SIMPA2
--
-- Proc‚dures           :       DW_S01_W_INTER_WKF
--                              DW_S01_ROUTAGE_WKF
--                              DW_S01_W_SIN_WKF
--                              DW_S02_W_SIN_WKF
--                              DW_S01_HOMONYME
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_W_INTER_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libell‚              :        
-- Commentaires         :       Select sur la table W_INTER ou INTER
-- R‚f‚rences           :       Utilis‚ dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sType          Varchar (  3 )          (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_INTER_WKF' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_INTER_WKF
GO

CREATE procedure sysadm.DW_S01_W_INTER_WKF 
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sType          Varchar ( 3 ) 
AS
 IF     @sType = 'CAS'

        SELECT  inter.id_sin,
                inter.id_i,
                inter.cod_inter,
                inter.cod_civ,
                inter.nom
        FROM    sysadm.inter
        WHERE   inter.id_sin = @dcIdSin
 ELSE

        SELECT  w_inter.id_sin,
                w_inter.id_i,
                w_inter.cod_inter,
                w_inter.cod_civ,
                w_inter.nom
        FROM    sysadm.w_inter
        WHERE   w_inter.id_sin = @dcIdSin

GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_ROUTAGE_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libell‚              :        
-- Commentaires         :       Select sur la table ROUTAGE
-- R‚f‚rences           :       Utilis‚ dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_ROUTAGE_WKF' AND type = 'P' )
        DROP procedure sysadm.DW_S01_ROUTAGE_WKF
GO

CREATE procedure sysadm.DW_S01_ROUTAGE_WKF
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS
 SELECT routage.id_sin,
        routage.alt_supp,
        routage.id_corb,
        routage.cod_table,
        routage.cod_travail,
        routage.alt_queue,
        w_queue.cod_etat,
        w_queue.alt_occupe,
        w_queue.trv_maj_par,
        w_queue.txt_mess1,
        w_queue.trv_cree_le,
        w_queue.dte_recu,
        sinistre.alt_ssui,
        sinistre.cod_etat
 FROM   sysadm.routage
 LEFT OUTER JOIN sysadm.w_queue        
 ON     CONVERT ( VARCHAR(10), routage.id_sin ) = w_queue.id_sin  -- [PI062]
 LEFT OUTER JOIN sysadm.sinistre       
 ON     sinistre.id_sin = routage.id_sin
 WHERE  routage.id_sin = @dcIdSin

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_W_SIN_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libell‚              :        
-- Commentaires         :       Select sur la table W_SIN ou SINISTRE
-- R‚f‚rences           :       Utilis‚ dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sType          Varchar (  3 )          (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_SIN_WKF' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_SIN_WKF
GO

CREATE procedure sysadm.DW_S01_W_SIN_WKF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sType          Varchar ( 3 )
AS
 IF     @sType = 'CAS'

        SELECT  sinistre.id_sin,
                sinistre.id_prod,
                sinistre.id_ets,
                sinistre.id_adh,
                sinistre.id_sdos,
                sinistre.dte_adh,
                sinistre.dte_decl,
                sinistre.dte_surv,
                sinistre.id_ordre,
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
                sinistre.dte_fin_gti,
                sinistre.dte_resil,
		sinistre.num_port,
		sinistre.num_imei_port,
		sinistre.marq_port,
		sinistre.modl_port,
		sinistre.dte_ach_port,
		sinistre.dte_ouvlig_port                
        FROM    sysadm.sinistre,
                sysadm.personne
        WHERE   sinistre.id_sin         = @dcIdSin                      AND
                sinistre.id_ordre       = personne.id_ordre
                
 ELSE
        SELECT  w_sin.id_sin,
                w_sin.id_prod,
                w_sin.id_ets,
                w_sin.id_adh,
                w_sin.id_sdos,
                w_sin.dte_adh,
                w_sin.dte_decl,
                w_sin.dte_surv,
                w_sin.id_ordre,
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
                w_sin.dte_fin_gti,
                w_sin.dte_resil,
		w_sin.num_port,
		w_sin.num_imei_port,
		w_sin.marq_port,
		w_sin.modl_port,
		w_sin.dte_ach_port,
		w_sin.dte_ouvlig_port                

        FROM    sysadm.w_sin
        WHERE   w_sin.id_sin            = @dcIdSin

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S02_W_SIN_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libell‚              :        
-- Commentaires         :       Select sur la table W_SIN et SINISTRE
-- R‚f‚rences           :       Utilis‚ dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @dcIdAdh        Varchar ( 19 )          (Val)
--                              @dcIdsDos       Decimal (  7,0 )        (Val)
--                      :       @sTypeAdh       Varchar (  3 )          (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_W_SIN_WKF' AND type = 'P' )
        DROP procedure sysadm.DW_S02_W_SIN_WKF
GO

CREATE procedure sysadm.DW_S02_W_SIN_WKF
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19 )  ,
        @dcIdsDos       Decimal (  7,0 ),
        @sTypeAdh       Varchar (  3 )

AS
/* ... Si le type d'adhésion est 1,2 ou 5 on utilise tous les paramètres */
 IF     @sTypeAdh = 'ADH'

        SELECT  sinistre.id_sin,
                sinistre.dte_adh,
                sinistre.dte_decl,
                sinistre.dte_surv,
                sinistre.id_ordre,
                personne.cod_civ,
                personne.nom,
                personne.prenom,
                personne.adr_1,
                personne.adr_2,
                personne.adr_cp,
                personne.adr_ville,
                routage.alt_queue,
                'P'+routage.cod_travail
        FROM    sysadm.sinistre,
                sysadm.personne,
                sysadm.routage
        WHERE   sinistre.id_adh         = @sIdAdh                       AND  -- [PI038][RELEVE]
                sinistre.id_prod        = @dcIdProd                     AND
                sinistre.id_ets         = @dcIdEts                      AND
                sinistre.id_sdos        = @dcIdsDos                     AND
                sinistre.id_ordre       = personne.id_ordre             AND
                sinistre.id_sin         = routage.id_sin
        UNION    
        SELECT  w_sin.id_sin,
                w_sin.dte_adh,
                w_sin.dte_decl,
                w_sin.dte_surv,
                w_sin.id_ordre,
                w_sin.cod_civ,
                w_sin.nom,
                w_sin.prenom,
                w_sin.adr_1,
                w_sin.adr_2,
                w_sin.adr_cp,
                w_sin.adr_ville,
                routage.alt_queue,
                'W'+routage.cod_travail
        FROM    sysadm.w_sin,
                sysadm.routage
        WHERE   w_sin.id_adh            = @sIdAdh                       AND  -- [PI038][RELEVE]
                w_sin.id_prod           = @dcIdProd                     AND
                w_sin.id_ets            = @dcIdEts                      AND
                w_sin.id_sdos           = @dcIdsDos                     AND
                w_sin.id_sin            = routage.id_sin                AND
                w_sin.cpt_valide        = 0

 ELSE        
/* ... Si le type d'adhésion est 3 ou 4 on utilise uniquement ID_ADH */

        SELECT  sinistre.id_sin,
                sinistre.dte_adh,
                sinistre.dte_decl,
                sinistre.dte_surv,
                sinistre.id_ordre,
                personne.cod_civ,
                personne.nom,
                personne.prenom,
                personne.adr_1,
                personne.adr_2,
                personne.adr_cp,
                personne.adr_ville,
                routage.alt_queue,
                'P'+routage.cod_travail
        FROM    sysadm.sinistre,
                sysadm.personne,
                sysadm.routage
        WHERE   sinistre.id_adh         = @sIdAdh                       AND  -- [PI038][RELEVE]
                sinistre.id_ordre       = personne.id_ordre             AND
                sinistre.id_sin         = routage.id_sin
        UNION    
        SELECT  w_sin.id_sin,
                w_sin.dte_adh,
                w_sin.dte_decl,
                w_sin.dte_surv,
                w_sin.id_ordre,
                w_sin.cod_civ,
                w_sin.nom,
                w_sin.prenom,
                w_sin.adr_1,
                w_sin.adr_2,
                w_sin.adr_cp,
                w_sin.adr_ville,
                routage.alt_queue,
                'W'+routage.cod_travail
        FROM    sysadm.w_sin,
                sysadm.routage
        WHERE   w_sin.id_adh            = @sIdAdh                       AND  -- [PI038][RELEVE]
                w_sin.id_sin            = routage.id_sin                AND
                w_sin.cpt_valide        = 0
                
GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_HOMONYME
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libell‚              :        
-- Commentaires         :       Recherche des Homonymes
-- R‚f‚rences           :       Utilis‚ dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @sNom           Varchar ( 35   )        (Val)
--                              @sPrenom        Varchar ( 35   )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_HOMONYME' AND type = 'P' )
        DROP procedure sysadm.DW_S01_HOMONYME
GO

CREATE procedure sysadm.DW_S01_HOMONYME
        @sNom           Varchar ( 35   ),
        @sPrenom        Varchar ( 35   )

AS
 SELECT personne.id_ordre,
        'P',
        personne.cod_civ,
        personne.nom,
        personne.prenom,
        personne.adr_1,
        personne.adr_2,
        personne.adr_cp,
        personne.adr_ville,
        sinistre.id_sin,
        sinistre.id_prod,
        sinistre.id_ets,
        sinistre.id_adh,
        sinistre.id_sdos,
        sinistre.dte_adh,
        sinistre.dte_surv,
        routage.alt_queue
 FROM   sysadm.personne,
        sysadm.sinistre,
        sysadm.routage
 WHERE  personne.nom     like   @sNom           AND
        personne.prenom  like   @sPrenom        AND
        personne.id_ordre = sinistre.id_ordre   AND
        sinistre.id_sin   = routage.id_sin
 UNION
 SELECT w_sin.id_ordre,
        w_sin.cod_prov_pers,
        w_sin.cod_civ,
        w_sin.nom,
        w_sin.prenom,
        w_sin.adr_1,
        w_sin.adr_2,
        w_sin.adr_cp,
        w_sin.adr_ville,
        w_sin.id_sin,
        w_sin.id_prod,
        w_sin.id_ets,
        w_sin.id_adh,
        w_sin.id_sdos,
        w_sin.dte_adh,
        w_sin.dte_surv,
        routage.alt_queue
 FROM   sysadm.w_sin,
        sysadm.routage
 WHERE  w_sin.nom       like @sNom              AND
        w_sin.prenom    like @sPrenom           AND
        w_sin.id_sin = routage.id_sin

GO
