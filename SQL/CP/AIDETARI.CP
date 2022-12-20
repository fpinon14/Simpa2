-------------------------------------------------------------------
--
-- Fichier              :       AideTari.cp
-- Auteur               :       PLJ
-- Date                 :       09/03/98 14:00:00
--
-- Commentaires         :       Liste des procédures afférant à la table aide_tarif
--                      On effectue la création du compteur des compagnies avec
--                      le plus grand id_cie existant, si le compteur n'existe pas
--                      dans paramètre.
--
-- Procédures           :       DW_S01_AIDE_TARIF,
--                              DW_I01_AIDE_TARIF,
--                              DW_D01_AIDE_TARIF
-------------------------------------------------------------------



--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_AIDE_TARIF
-- Auteur               :       PLJ
-- Date                 :       09/03/98 14:00:00
-- Libellé              :       Selection d'un code tarif. 
-- Commentaires         :
-- Références           :       d_sp_aide_tarif
--
-- Arguments            :       @dcIdCode     decimal ( 7, 0 ) ( Val ) : identifiant du code tarif recherch‚.
--
-- Retourne             :       ResultSet
--
--------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_AIDE_TARIF' AND type = 'P' )
            DROP procedure sysadm.DW_S01_AIDE_TARIF
GO

CREATE PROC sysadm.DW_S01_AIDE_TARIF
            @dcIdCode     decimal ( 7, 0 )
AS

  SELECT aide_tarif.id_code,
         aide_tarif.id_gti,
         aide_tarif.lib_code,
         aide_tarif.mt_prej,
         aide_tarif.cree_le,
         aide_tarif.maj_le,
         aide_tarif.maj_par
    FROM sysadm.aide_tarif
   WHERE aide_tarif.id_code = @dcIdCode

GO





--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_AIDE_TARIF
-- Auteur               :       PLJ
-- Date                 :       09/03/98 14:00:00
-- Libellé              :       Insert dans la table Aide_Tarif.
-- Commentaires         :
-- Références           :       SQLPREVIEW de Dw_1 de la fenêtre W_T_SP_AIDE_TARIF
--
-- Arguments            :       @dcIdCode  decimal ( 7, 0 )		( Val ) : identifiant de la nouvelle Compagnie.
--                              @dcIdGti   decimal ( 7, 0 )		( Val )
--                              @sLibCode  String		( Val )
--				@dcMtPrej  Decimal (11,2)	( Val ) 
--                              @dtCreeLe  DateTime		( Val )
--                              @dtMajLe   DateTime		( Val )
--                              @sMajPar   String		( Val )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_AIDE_TARIF' AND type = 'P' )
            DROP procedure sysadm.DW_I01_AIDE_TARIF
GO

CREATE PROC sysadm.DW_I01_AIDE_TARIF
       @dcIdCode    decimal ( 7, 0 ) OUTPUT,
       @dcIdGti     decimal ( 7, 0 ),
       @sLibCode    Varchar ( 35 ),
       @dcMtPrej    Decimal (11,2),		
       @dtCreeLe    DateTime,
       @dtMajLe     DateTime,
       @sMajPar     Varchar ( 4 )
AS

  DECLARE      @iEtat     Integer
 
EXECUTE @iEtat = sysadm.PS_X_INCREMENTER 'ID_AIDE_T', @dcIdCode OUTPUT
Commit tran

  IF @iEtat = -1	
     BEGIN
        RAISERROR ( 50001, 16, -1 )
        Return -1
     END
	
  INSERT INTO sysadm.aide_tarif
            ( aide_tarif.id_code,
              aide_tarif.id_gti,
              aide_tarif.lib_code,
              aide_tarif.mt_prej,
              aide_tarif.cree_le,
              aide_tarif.maj_le,
              aide_tarif.maj_par )
       VALUES 
            ( @dcIdCode, @dcIdGti, @sLibCode, @dcMtPrej, @dtCreeLe, @dtMajLe, @sMajPar )

GO




--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_AIDE_TARIF
-- Auteur               :       PLJ
-- Date                 :       09/03/98 14:00:00
-- Libellé              :       Suppression d'une ligne aide_tarif.
-- Commentaires         :
-- Références           :       SQLPREVIEW de Dw_1 de la fenêtre W_T_SP_AIDE_TARIF
--
-- Arguments            :       @dcIdCode   decimal ( 7, 0 ) ( Val )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_AIDE_TARIF' AND type = 'P' )
            DROP procedure sysadm.DW_D01_AIDE_TARIF
GO

CREATE PROC sysadm.DW_D01_AIDE_TARIF
            @dcIdCode  decimal ( 7, 0 )
AS

 DELETE sysadm.aide_tarif
   WHERE aide_tarif.id_code = @dcIdCode

GO
