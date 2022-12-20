-------------------------------------------------------------------
--
-- Fichier              :       OTION_ACP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion de la table OPTION_ADH
--
-- Procédures           :       DW_S01_OPTION_ADH
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_OPTION_ADH
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table OPTION_ADH
-- Références           :       Utilisé dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--                      :       @dcIEts         Decimal (  7,0 )        (Val)
--                      :       @dcIdOpt        Decimal (  2,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_OPTION_ADH' AND type = 'P' )
        DROP procedure sysadm.DW_S01_OPTION_ADH
GO

CREATE procedure sysadm.DW_S01_OPTION_ADH
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @dcIdOpt        Decimal (  2,0 )
AS
 SELECT option_adh.lib_opt,
        option_adh.cod_opt,
        option_adh.id_prod_val
 FROM   sysadm.option_adh
 WHERE  option_adh.id_prod      = @dcIdProd     AND
        option_adh.id_ets       = @dcIdEts      AND
        option_adh.id_opt       = @dcIdOpt

GO
