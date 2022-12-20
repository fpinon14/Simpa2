-------------------------------------------------------------------
--
-- Fichier              :       Ets.cp
-- Auteur               :       NÝ6
-- Date                 :       21/07/97 17:06:18
--
-- Commentaires         :       Liste des procédure afférent à la table etablissement
--
-- Procédures           :
--                              DW_S01_ETABLISSEMENT
--                              DW_I01_ETABLISSEMENT
--                              DW_D01_ETABLISSEMENT
--                              IM_D01_ETABLISSEMENT
--                              IM_D02_ETABLISSEMENT
--                              DD_S01_ETABLISSEMENT
--                              IM_S01_ETABLISSEMENT
--				DD_S02_ETABLISSEMENT
--				DD_S03_ETABLISSEMENT
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_ETABLISSEMENT
-- Auteur               :       NÝ6
-- Date                 :       23/07/97 11:16:09
-- Libellé              :       Sélection des établissements associés à un Produit
-- Commentaires         :
-- Références           :       Utilisée dans D_SP_PROD_ETS, objet UO_ETS, fenetre W_TM_SP_PRODUIT
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 ) ( Val )
--
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_ETABLISSEMENT' AND type = 'P' )
            DROP procedure sysadm.DW_S01_ETABLISSEMENT
GO

CREATE PROC sysadm.DW_S01_ETABLISSEMENT
            @dcIdProd  decimal ( 7, 0 )
AS

 SELECT etablissement.id_prod,
        etablissement.id_grp,
        groupe.id_grp_base,
        groupe.lib_grp,
        etablissement.id_rev,
        etablissement.id_ets,    
        etablissement.cree_le,
        etablissement.maj_le,
        etablissement.maj_par
   FROM sysadm.etablissement,
        sysadm.groupe
  WHERE etablissement.id_grp  = groupe.id_grp AND
        etablissement.id_prod = @dcIdProd

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_ETABLISSEMENT
-- Auteur               :       NÝ6
-- Date                 :       23/07/97 11:22:09
-- Libellé              :       Insertion dans la table des Etablissements
-- Commentaires         :
-- Références           :       Utilisée dans UE_DWSOURCE_SQLPREVIEW de UO_ETS, fenêtre W_TM_SI_PRODUIT
--
-- Arguments            :       @dcIdProd      decimal ( 7, 0 )    ( Val )
--                              @dcIdGrp       decimal ( 7, 0 )    ( Val )
--                              @dcIdRev       decimal ( 7, 0 )    ( Val )
--                              @dcIdEts       decimal ( 7, 0 )    ( Val )
--                              @dtCreeLe      DateTime   ( Val )
--                              @dtMajLe       DateTime   ( Val )
--                              @sMajPar       String     ( Val )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_ETABLISSEMENT' AND type = 'P' )
            DROP procedure sysadm.DW_I01_ETABLISSEMENT
GO

CREATE PROC sysadm.DW_I01_ETABLISSEMENT
  @dcIdProd      decimal ( 7, 0 ),
  @dcIdGrp       decimal ( 7, 0 ),
  @dcIdRev       decimal ( 7, 0 ),
  @dcIdEts       decimal ( 7, 0 ),
  @dtCreeLe      DateTime,
  @dtMajLe       DateTime,
  @sMajPar       Varchar ( 4 )

AS

 INSERT INTO sysadm.etablissement
           ( etablissement.id_prod,
             etablissement.id_grp,
             etablissement.id_rev,
             etablissement.id_ets,
             etablissement.cree_le,
             etablissement.maj_le,
             etablissement.maj_par )
      VALUES
           ( @dcIdProd, @dcIdGrp, @dcIdRev, @dcIdEts,
             @dtCreeLe, @dtMajLe, @sMajPar )

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_ETABLISSEMENT
-- Auteur               :       NÝ6
-- Date                 :       23/07/97 11:22:09
-- Libellé              :       Suppression dans la table des Etablissements
-- Commentaires         :
-- Références           :       Utilisée dans UE_DWSOURCE_SQLPREVIEW de UO_ETS, fenêtre W_TM_SP_PRODUIT
--
-- Arguments            :       @dcIdProd     decimal ( 7, 0 )    ( Val )
--                              @dcIdGrp      decimal ( 7, 0 )    ( Val )
--                              @dcIdRev      decimal ( 7, 0 )    ( Val )
--                              @dcIdEts      decimal ( 7, 0 )    ( Val )
--
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_ETABLISSEMENT' AND type = 'P' )
            DROP procedure sysadm.DW_D01_ETABLISSEMENT
GO

CREATE PROC sysadm.DW_D01_ETABLISSEMENT
            @dcIdProd     decimal ( 7, 0 ),
            @dcIdGrp      decimal ( 7, 0 ),
            @dcIdRev      decimal ( 7, 0 ),
            @dcIdEts      decimal ( 7, 0 )
AS

 DELETE FROM sysadm.etablissement
 WHERE       etablissement.id_prod = @dcIdProd AND
             etablissement.id_grp  = @dcIdGrp  AND
             etablissement.id_rev  = @dcIdRev  AND
             etablissement.id_ets  = @dcIdEts

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_ETABLISSEMENT
-- Auteur               :       NÝ6
-- Date                 :       24/07/97 11:33:02
-- Libellé              :       Delete sur table ETABLISSEMENT
-- Commentaires         :       PS_SUPREVISION 
-- Références           :
--
-- Arguments            :
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_ETABLISSEMENT' AND type = 'P' )
            DROP procedure sysadm.IM_D01_ETABLISSEMENT
GO

CREATE PROC sysadm.IM_D01_ETABLISSEMENT
            @dcIdProd  decimal ( 7, 0 ),
            @dcIdRev   decimal ( 7, 0 )
AS

 DELETE FROM sysadm.etablissement
       WHERE etablissement.id_prod = @dcIdProd AND
             etablissement.id_rev  = @dcIdRev


GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D02_ETABLISSEMENT
-- Auteur               :       NÝ6
-- Date                 :       24/07/97 11:35:04
-- Libellé              :       Delete sur table ETABLISSEMENT
-- Commentaires         :
-- Références           :       PS_SUPPRODUIT 
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D02_ETABLISSEMENT' AND type = 'P' )
            DROP procedure sysadm.IM_D02_ETABLISSEMENT
GO

CREATE PROC sysadm.IM_D02_ETABLISSEMENT
            @dcIdProd  decimal ( 7, 0 )
AS

 DELETE FROM sysadm.etablissement
       WHERE etablissement.id_prod = @dcIdProd

GO


--------------------------------------------------------------------
--
-- Procédure            :       DD_S01_ETABLISSEMENT
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       DropDown sur Etablissement
-- Références           :       Utilis‚ dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdProd       Decimal ( 7, 0 )
--                      :       @dcIdRev        Decimal ( 7, 0 )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S01_ETABLISSEMENT' AND type = 'P' )
        DROP procedure sysadm.DD_S01_ETABLISSEMENT
GO

CREATE procedure sysadm.DD_S01_ETABLISSEMENT
        @dcIdProd       decimal ( 7, 0 ),
        @dcIdRev        decimal ( 7, 0 )
AS
 SELECT etablissement.id_ets,
        etablissement.id_grp,
        groupe.lib_grp
 FROM   sysadm.etablissement,
        sysadm.groupe
 WHERE  etablissement.id_prod   = @dcIdProd     AND
        etablissement.id_rev    = @dcIdRev      AND
        etablissement.id_grp    = groupe.id_grp

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_S01_ETABLISSEMENT
-- Auteur               :       DBI
-- Date                 :       21/01/98
-- Libellé              :       Controle existance de sinistre pour un etablissement 
-- Commentaires         :       
-- Références           :       Utilis‚ dans W_TM_SP_Produit
--
-- Arguments            :       @dcIdProd       decimal ( 7, 0 )
--                      :       @dcIdEts        decimal ( 7, 0 )
--                      :       @iSinistre      Integer OUTPUT
--				Contient 0 si pas de sinistre
--					 3 si sinistre dans table Sinistre
--					 4 si sinistre dans table W_Sin
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S01_ETABLISSEMENT' AND type = 'P' )
        DROP procedure sysadm.IM_S01_ETABLISSEMENT
GO

CREATE procedure sysadm.IM_S01_ETABLISSEMENT
        @dcIdProd       decimal ( 7, 0 ),
        @dcIdEts        decimal ( 7, 0 ),
        @iSinistre      Integer OUTPUT

AS

Declare @iNbSin         Integer

 SELECT @iSinistre = ( 0 )

 SELECT @iNbSin = ( Count ( sinistre.id_sin ) )
 FROM   sysadm.sinistre
 WHERE  sinistre.id_prod   = @dcIdProd     AND
        sinistre.id_ets    = @dcIdEts

 If @iNbSin > 0
  Begin

   SELECT @iSinistre = ( 3 )
  End 
 Else
  Begin

   SELECT @iNbSin = ( Count ( w_sin.id_sin ) )
   FROM   sysadm.w_sin
   WHERE  w_sin.id_prod   = @dcIdProd     AND
          w_sin.id_ets    = @dcIdEts

   If @iNbSin > 0 
   Begin

    SELECT @iSinistre = ( 4 )
   End 
  End

  Select @iSinistre

GO

--------------------------------------------------------------------
--
-- Procédure            :       DD_S02_ETABLISSEMENT
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :                  
-- Commentaires         :       DropDown sur Etablissement
-- Références           :       Utilis‚ dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S02_ETABLISSEMENT' AND type = 'P' )
        DROP procedure sysadm.DD_S02_ETABLISSEMENT
GO

CREATE procedure sysadm.DD_S02_ETABLISSEMENT
AS
 SELECT etablissement.id_prod,
        etablissement.id_ets,
        etablissement.id_grp,
        groupe.lib_grp
 FROM   sysadm.etablissement,
        sysadm.groupe
 WHERE  etablissement.id_rev    = -1            AND
        etablissement.id_grp    = groupe.id_grp

GO


--------------------------------------------------------------------
--
-- Procédure            :       DD_S03_ETABLISSEMENT
-- Auteur               :       JFF
-- Date                 :       02/03/99 11:27:57
-- Libellé              :                  
-- Commentaires         :       DropDown affichant les établissement en fonction du cod_adh ( =3 ou <>3 )
--	
-- Références           :       Utilis‚ dans W_SP_GS_TRAIT_ETAT_DDE, DDDW_PRODUIT_TRT_DDE
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S03_ETABLISSEMENT' AND type = 'P' )
        DROP procedure sysadm.DD_S03_ETABLISSEMENT
GO

CREATE procedure sysadm.DD_S03_ETABLISSEMENT
AS

SELECT 
	distinct produit.id_prod, groupe.id_grp, groupe.lib_grp

FROM  	
	sysadm.produit,
	sysadm.affilier,
	sysadm.carte,
	sysadm.groupe

	
WHERE   ( produit.cod_adh	= '3'						)  and
	( affilier.id_prod	= produit.id_prod				)  and
	( carte.id_carte	= affilier.id_carte				)  and
	( carte.id_grp		= groupe.id_grp					)


UNION ALL
	

SELECT 
	distinct produit.id_prod, groupe.id_grp, groupe.lib_grp

FROM  	
	sysadm.produit,
	sysadm.etablissement,
	sysadm.groupe

	
WHERE   ( produit.cod_adh	<> '3'						)  and
	( etablissement.id_prod = produit.id_prod				)  and
	( etablissement.id_rev  = -1						)  and
	( etablissement.id_grp  = groupe.id_grp					)


GO

