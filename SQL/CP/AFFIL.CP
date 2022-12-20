-------------------------------------------------------------------
--
-- Fichier              :  Affil.cp
-- Auteur               :  V.Capelle
-- Date                 :  05/11/1997 10:59:52
--
-- Commentaires         :  Liste des procédures stockées afférant à la 
--                         table affilier
--
-- Procédures           :  DW_S01_AFFILIER
--                         DW_S02_AFFILIER
--                         DW_I01_AFFILIER
--                         IM_D01_AFFILIER
--                         DW_U01_AFFILIER
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure				:       DW_S01_AFFILIER
-- Auteur				:       V.Capelle
-- Date					:       06/11/1997 09:51:37
-- Libellé				:       Recherche des cartes non affiliées à une
--                                              garantie, pour un produit et une révision.
-- Commentaires			        :	
-- Références				:	Fenêtre w_tm_sp_garantie, objet uo_affilier,
--                                              datawindow dw_sp_lst_affilier_rech
--
-- Arguments				:       @dcIdProd    decimal ( 7, 0 )  Produit
--                                              @dcIdRev     decimal ( 7, 0 )  Révision
--                                              @dcIdGti     decimal ( 7, 0 )  Garantie
--
-- Retourne				:       ResultSet
--				  
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_AFFILIER' AND type = 'P' )
            DROP procedure sysadm.DW_S01_AFFILIER
GO

CREATE PROC sysadm.DW_S01_AFFILIER
            @dcIdProd    decimal ( 7, 0 ),
            @dcIdRev     decimal ( 7, 0 ),
            @dcIdGti     decimal ( 7, 0 )

AS

SELECT Convert ( decimal (7),  null ),
       Convert ( decimal (7),  null ),
       Convert ( decimal (7),  null ),
       sysadm.carte.id_carte, 
       sysadm.carte.lib_carte,
       Convert ( datetime,  null ),
       GetDate(),
       GetDate(),
       ''
  FROM sysadm.carte
 WHERE carte.id_carte 
       NOT IN ( SELECT affilier.id_carte
                  FROM sysadm.affilier
                 WHERE affilier.id_prod = @dcIdProd AND
                       affilier.id_rev  = @dcIdRev AND
                       affilier.id_gti  = @dcIdGti )

GO


--------------------------------------------------------------------
--
-- Procédure                            :       Dw_S02_AFFILIER
-- Auteur                               :       V.Capelle
-- Date                                 :       06/11/1997 09:51:37
-- Libellé                              :       Liste des cartes affiliées à une garantie
--                                              pour un produit et une révision.
-- Commentaires                         :	
-- Références                           :       Fenêtre w_tm_sp_garantie, objet uo_affilier,
--                                              datawindow dw_sp_affilier
-- Arguments				:       @dcIdProd    decimal ( 7, 0 )  Produit
--                                              @dcIdRev     decimal ( 7, 0 )  Révision
--                                              @dcIdGti     decimal ( 7, 0 )  Garantie
--
-- Retourne                             :       ResultSet
--				  
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_AFFILIER' AND type = 'P' )
				DROP procedure sysadm.DW_S02_AFFILIER
GO

CREATE PROC sysadm.DW_S02_AFFILIER
            @dcIdProd    decimal ( 7, 0 ),
            @dcIdRev     decimal ( 7, 0 ),
            @dcIdGti     decimal ( 7, 0 )

AS

SELECT sysadm.affilier.id_prod,
       sysadm.affilier.id_rev,
       sysadm.affilier.id_gti, 
       sysadm.affilier.id_carte,
       sysadm.carte.lib_carte,
       sysadm.affilier.dte_affiliation,
       sysadm.affilier.cree_le,
       sysadm.affilier.maj_le,
       sysadm.affilier.maj_par
FROM   sysadm.affilier,
       sysadm.carte
WHERE  sysadm.affilier.id_prod  = @dcIdProd             AND
       sysadm.affilier.id_rev   = @dcIdRev              AND
       sysadm.affilier.id_gti   = @dcIdGti              AND
       sysadm.affilier.id_carte = sysadm.carte.id_carte 

GO

--------------------------------------------------------------------
--
-- Procédure                           :     DW_I01_AFFILIER
-- Auteur                              :     V.Capelle
-- Date                                :     06/11/1997 14:24:37
-- Libellé                             :     Insertion d'une carte affiliée à une garantie
--                                           pour un produit et une révision.
-- Commentaires                        :	
-- Références                          :     Fenêtre w_tm_sp_garantie, objet uo_affilier,
--                                           datawindow dw_sp_affilier SQLPREVIEW
--
-- Arguments                           :     @dcIdProd    decimal ( 7, 0 )         Produit
--                                           @dcIdRev     decimal ( 7, 0 )         Révision
--                                           @dcIdGti     decimal ( 7, 0 )         Garantie
--                                           @dcIdCarte   decimal ( 7, 0 )         Carte
--                                           @dtDteAffil  Datetime        Date d'affiliation
--                                           @dtCreeLe    Datetime        CREE_LE
--                                           @dtMajLe     Datetime        MAJ_LE
--                                           @sMajPar     VarChar ( 4 )   MAJ_PAR
--
-- Retourne                            :     Rien
--				  
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_AFFILIER' AND type = 'P' )
            DROP procedure sysadm.DW_I01_AFFILIER

GO

CREATE PROC sysadm.DW_I01_AFFILIER
            @dcIdProd    decimal ( 7, 0 ),
            @dcIdRev     decimal ( 7, 0 ),
            @dcIdGti     decimal ( 7, 0 ),
            @dcIdCarte   decimal ( 7, 0 ),
            @dtDteAffil  Datetime,
            @dtCreeLe    Datetime,
            @dtMajLe     Datetime,
            @sMajPar     VarChar ( 4 )
AS

INSERT INTO sysadm.affilier
          ( id_prod,   
            id_rev,   
            id_gti,   
            id_carte,   
            dte_affiliation, 
            cree_le,   
            maj_le,   
            maj_par  )
VALUES
          ( @dcIdProd,   @dcIdRev,  @dcIdGti, @dcIdCarte, 
            @dtDteAffil, @dtCreeLe, @dtMajLe, @sMajPar ) 

GO



--------------------------------------------------------------------
--
-- Procédure                            :   IM_D01_AFFILIER
-- Auteur                               :   V.Capelle
-- Date                                 :   07/11/1997 16:27:37
-- Libellé                              :   Suppression des cartes affiliées à une garantie
--                                          pour un produit et une révision.
-- Commentaires                         :	
-- Références                           :	
-- Arguments                            :   @dcIdProd    decimal ( 7, 0 )  Produit
--                                          @dcIdRev     decimal ( 7, 0 )  Révision
--                                          @dcIdGti     decimal ( 7, 0 )  Garantie
--
-- Retourne                             :	
--				  
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_AFFILIER' AND type = 'P' )
				DROP procedure sysadm.IM_D01_AFFILIER
GO

CREATE PROC sysadm.IM_D01_AFFILIER
            @dcIdProd    decimal ( 7, 0 ),
            @dcIdRev     decimal ( 7, 0 ),
            @dcIdGti     decimal ( 7, 0 )

AS

DELETE FROM sysadm.affilier
      WHERE sysadm.affilier.id_prod  = @dcIdProd             AND
            sysadm.affilier.id_rev   = @dcIdRev              AND
            sysadm.affilier.id_gti   = @dcIdGti

GO



--------------------------------------------------------------------
--
-- Procédure                            :   DW_U01_AFFILIER
-- Auteur                               :   V.Capelle
-- Date                                 :   12/11/1997 14:24:37
-- Libellé                              :   Modification d'une carte affiliée à une garantie
--                                          pour un produit et une révision.
-- Commentaires                         :	
-- Références                           :   Fenêtre w_tm_sp_garantie, objet uo_affilier,
--                                          datawindow dw_sp_affilier SQLPREVIEW
--
-- Arguments                            :   @dcIdProd    decimal ( 7, 0 )         Produit
--                                          @dcIdRev     decimal ( 7, 0 )         Révision
--                                          @dcIdGti     decimal ( 7, 0 )         Garantie
--                                          @dcIdCarte   decimal ( 7, 0 )         Carte
--                                          @dtDteAffil  Datetime        Date d'affiliation
--                                          @dtMajLe     Datetime        MAJ_LE
--                                          @sMajPar     VarChar ( 4 )   MAJ_PAR
--
-- Retourne                             :   Rien
--				  
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_AFFILIER' AND type = 'P' )
				DROP procedure sysadm.DW_U01_AFFILIER
GO

CREATE PROC sysadm.DW_U01_AFFILIER
            @dcIdProd    decimal ( 7, 0 ),
            @dcIdRev     decimal ( 7, 0 ),
            @dcIdGti     decimal ( 7, 0 ),
            @dcIdCarte   decimal ( 7, 0 ),
            @dtDteAffil  Datetime,
            @dtMajLe     Datetime,
            @sMajPar     VarChar ( 4 )

AS

UPDATE sysadm.affilier
   SET sysadm.affilier.dte_affiliation = @dtDteAffil  ,
       sysadm.affilier.maj_le          = @dtMajLe     ,
       sysadm.affilier.maj_par         = @sMajPar     
 WHERE sysadm.affilier.id_prod         = @dcIdProd    AND
       sysadm.affilier.id_rev          = @dcIdRev     AND
       sysadm.affilier.id_gti          = @dcIdGti     AND
       sysadm.affilier.id_carte        = @dcIdCarte              

GO