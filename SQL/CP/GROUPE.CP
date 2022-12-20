-------------------------------------------------------------------
--
-- Fichier              :       Groupe.cp
-- Auteur               :       YP
-- Date                 :       02/09/97 10:19:38
--
-- Commentaires         :       Liste des procédures afférant à la table groupe
--                              pour SIMPA2
--
-- Procédures           :       DW_S02_GROUPE
--				PS_S01_CARTE_UF
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :      DW_S02_GROUPE
-- Auteur               :      YP
-- Date                 :      02/09/97 10:20:12
-- Libellé              :      Selection des Groupes disponible pour un Produit
-- Commentaires         :
-- Références           :      Utilise dans D_SP_LST_ETS_RCH, objet UO_ETS, fenetre W_TM_SP_PRODUIT
--			       Modif DBI le 20/01/1998 pour gestion du produit dans la recherche
-- Arguments            :      
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_GROUPE' AND type = 'P' )
            DROP procedure sysadm.DW_S02_GROUPE
GO

CREATE PROC sysadm.DW_S02_GROUPE
            @dcIdGrp  decimal (7,0)

AS

 SELECT Distinct convert ( decimal ( 7 ) , null ),
        groupe.id_grp, 
        groupe.id_grp_base, 
        groupe.lib_grp, 
        -1,
        convert ( decimal ( 7 ) , null ),
        convert ( datetime , null ),
        convert ( datetime , null ),
        ''
 FROM   sysadm.groupe 
 WHERE  ( groupe.id_grp_base = @dcIdGrp ) 
   OR   ( groupe.id_grp      = @dcIdGrp )

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_CARTE_UF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       D‚termination pour ID_EVT 711
-- Références           :       Utilisé dans W_TD_SP_W_DETAIL
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--                      :       @dcCarteIdGrp   Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_CARTE_UF' AND type = 'P' )
        DROP procedure sysadm.PS_S01_CARTE_UF
GO

CREATE procedure sysadm.PS_S01_CARTE_UF
        @dcIdProd       Decimal (  7,0 ),
        @dcCarteIdGrp   Decimal (  7,0 )
AS

Declare @iRet   Integer
Declare @dcGroupeIdGrpBase      Decimal (7,0)

 SELECT produit.id_prod,
        produit.id_grp,
        groupe.id_grp,
        groupe.id_grp_base
 FROM   sysadm.produit,
        sysadm.groupe
 WHERE  produit.id_prod         = @dcIdProd             AND
        produit.id_grp          = groupe.id_grp         AND
        (
        produit.id_grp          = @dcCarteIdGrp         Or
        groupe.id_grp_base      = @dcCarteIdGrp
        )

 Select @iRet = @@RowCount

 IF     @iRet = 0
        Begin

                SELECT  @dcGroupeIdGrpBase = groupe.id_grp_base
                FROM    sysadm.groupe
                WHERE   groupe.id_grp = @dcCarteIdGrp

                SELECT  produit.id_prod,
                        produit.id_grp,
                        groupe.id_grp,
                        groupe.id_grp_base
                FROM    sysadm.produit,
                        sysadm.groupe
                WHERE   produit.id_prod         = @dcIdProd             AND
                        produit.id_grp          = groupe.id_grp         AND
                        (
                        produit.id_grp          = @dcGroupeIdGrpBase   Or
                        groupe.id_grp_base      = @dcGroupeIdGrpBase
                        )

                 Select @iRet = @@RowCount

        End

 Return @iRet

GO

