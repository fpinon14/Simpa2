-------------------------------------------------------------------
--
-- Fichier              :       W_FRAIS.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion des frais dans SIMPA2
--
-- Procédures           :       DW_S01_W_FRAIS
--                              DW_I01_W_FRAIS
--                              DW_D01_W_FRAIS
--                              PS_I01_W_FRAIS_WKF
-------------------------------------------------------------------


--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_FRAIS
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       S‚lect sur la table W_FRAIS
-- Références           :       Utilis‚ dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_FRAIS' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_FRAIS
GO

CREATE procedure sysadm.DW_S01_W_FRAIS
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS
 SELECT w_frais.id_sin,
        w_frais.id_i,
        w_frais.id_frais,
        w_frais.id_typ_frais,
        w_frais.lib_frais,
        w_frais.alt_cour,
        w_frais.mt_frais,
        w_frais.cod_etat,
        w_frais.cree_le,
        w_frais.maj_le,
        w_frais.maj_par        
 FROM   sysadm.w_frais
 WHERE  w_frais.id_sin = @dcIdSin

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_W_FRAIS
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion sur table W_FRAIS
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdsin        Decimal (  7,0 )        (Val)
--                      :       @dcIdI          Decimal (  7,0 )        (Val)
--                      :       @dcIdFrais      Decimal (  7,0 )        (Val)
--                      :       @dcIdTypFrais   Decimal (  7,0 )        (Val)
--                      :       @sLibFrais      Varchar ( 35 )          (Val)
--                      :       @sAltCour       Varchar (  1 )          (Val)
--                      :       @dcMtFrais      Decimal ( 11,2 )        (Val)
--                      :       @dcCodEtat      Decimal (  7,0 )        (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @dtMajLe        DateTime                (Val)
--                      :       @sMajPar        Varchar (  4 )          (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_W_FRAIS' AND type = 'P' )
        DROP procedure sysadm.DW_I01_W_FRAIS
GO

CREATE procedure sysadm.DW_I01_W_FRAIS
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdI          Decimal (  7,0 ),
        @dcIdFrais      Decimal (  7,0 ),
        @dcIdTypFrais   Decimal (  7,0 ),
        @sLibFrais      Varchar ( 35 )  ,
        @sAltCour       Varchar (  1 )  ,
        @dcMtFrais      Decimal ( 11,2 ),
        @dcCodEtat      Decimal (  7,0 ),
        @dtCreeLe       DateTime        ,
        @dtMajLe        DateTime        ,
        @sMajPar        Varchar (  4 )
AS
 INSERT INTO    sysadm.w_frais
        (       w_frais.id_sin,
                w_frais.id_i,
                w_frais.id_frais,
                w_frais.id_typ_frais,
                w_frais.lib_frais,
                w_frais.alt_cour,
                w_frais.mt_frais,
                w_frais.cod_etat,
                w_frais.cree_le,
                w_frais.maj_le,
                w_frais.maj_par                )
 VALUES (       @dcIdSin,
                @dcIdI,
                @dcIdFrais,
                @dcIdTypFrais,
                @sLibFrais,
                @sAltCour,
                @dcMtFrais,
                @dcCodEtat,
                @dtCreeLe,
                @dtMajLe,
                @sMajPar                )


GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_W_FRAIS
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Suppression d'un frais pour un interlocuteur
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdI          Decimal (  7,0 )        (Val)
--                              @dcIdFrais      Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_W_FRAIS' AND type = 'P' )
        DROP procedure sysadm.DW_D01_W_FRAIS
GO

CREATE procedure sysadm.DW_D01_W_FRAIS
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdI          Decimal (  7,0 ),
        @dcIdFrais      Decimal (  7,0 )
AS
 DELETE FROM    sysadm.w_frais
 WHERE          w_frais.id_sin          = @dcIdSin      AND
                w_frais.id_i            = @dcIdI        AND
                w_frais.id_frais        = @dcIdFrais
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_W_FRAIS_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table W_FRAIS
-- Références           :       Utilisé dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_FRAIS_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_FRAIS_WKF
GO

CREATE procedure sysadm.PS_I01_W_FRAIS_WKF
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS
 INSERT INTO    sysadm.w_frais
        (       w_frais.id_sin,
                w_frais.id_i,
                w_frais.id_frais,
                w_frais.id_typ_frais,
                w_frais.lib_frais,
                w_frais.alt_cour,
                w_frais.mt_frais,
                w_frais.cod_etat,
                w_frais.cree_le,
                w_frais.maj_le,
                w_frais.maj_par )
 SELECT         frais.id_sin,
                frais.id_i,
                frais.id_frais,
                frais.id_typ_frais,
                frais.lib_frais,
                'N',
                frais.mt_frais,
                frais.cod_etat,
                frais.cree_le,
                frais.maj_le,
                frais.maj_par
 FROM           sysadm.frais
 WHERE          frais.id_sin = @dcIdSin

 Return @@Error

GO
