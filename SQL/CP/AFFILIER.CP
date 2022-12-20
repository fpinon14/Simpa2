-------------------------------------------------------------------
--
-- Fichier                      : Affilier.cp
-- Auteur                       : YP
-- Date                         : 04/09/97 12:13:18
--
-- Commentaires                 : Liste des procédure de gestion des affiliations.
--
-- Procédures                   :
-- Fonctions                    : IM_S01_AFFILIER
--                                IM_D01_AFFILIER
--                                IM_D02_AFFILIER
--                                IM_I01_AFFILIER
--                                PS_S01_AFFILIER_SINISTRE
--
-------------------------------------------------------------------

-------------------------------------------------------------------
--
-- Procédure            :       IM_S01_AFFILIER
-- Auteur               :       YP
-- Date                 :       04/09/97 12:14:27
-- Libellé              :       permet de savoir s'il y a des garanties en relation avec la
--                              carte que l'on veut supprimer.
-- Commentaires         :
-- Références           :       Appelé par l'User Object U_SP_GS_CARTE dans la
--                              fonction Uf_Gs_Sup_Carte()
--
-- Arguments            :       @dcIdCarte      decimal ( 7, 0 ) ( Val )
--
-- Retourne             :       Le nombre de ligne existante
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S01_AFFILIER' AND type = 'P' )
            DROP procedure sysadm.IM_S01_AFFILIER
GO

CREATE PROC sysadm.IM_S01_AFFILIER
            @dcIdCarte  decimal ( 7, 0 )
AS

   SELECT  sysadm.affilier.id_gti
   FROM    sysadm.affilier
   WHERE   sysadm.affilier.id_carte = @dcIdCarte

  RETURN @@ROWCOUNT

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_AFFILIER
-- Auteur               :       YP
-- Date                 :       05/09/97 14:51:55
-- Libellé              :       Delete sur table AFFILIER
-- Commentaires         :
-- Références           :       PS_SUPPRODUIT
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 )
--
-- Retourne             :
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
-- Procédure            :       IM_D02_AFFILIER
-- Auteur               :       YP
-- Date                 :       05/09/97 14:51:55
-- Libellé              :       Delete sur table AFFILIER
-- Commentaires         :
-- Références           :       PS_SUPREVISION
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 )
--                              @dcIdRev   decimal ( 7, 0 )
--
-- Retourne             :
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D02_AFFILIER' AND type = 'P' )
            DROP procedure sysadm.IM_D02_AFFILIER
GO

CREATE PROC sysadm.IM_D02_AFFILIER
            @dcIdProd  decimal ( 7, 0 ),
            @dcIdRev   decimal ( 7, 0 )

AS

  DELETE FROM sysadm.affilier
       WHERE affilier.id_prod = @dcIdProd AND
             affilier.id_rev  = @dcIdRev

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_I01_AFFILIER
-- Auteur               :       YP
-- Date                 :       05/09/97 15:12:08
-- Libellé              :       Insert sur la table AFFILIER.
-- Commentaires         :       Utilise pour dupliquer les GARANTIES de la derniere REVISION lors de
--                              la création d'une nouvelle REVISION.
-- Références           :       W_Tm_Sp_Produit, Wf_TerminerValider () U_SP_GS_REV_PROD, Uf_TerminerValider ()
--
-- Arguments            :       @dcIdProd        decimal ( 7, 0 ),
--                              @dcIdRev         decimal ( 7, 0 ),
--                              @dcIdRevAnc      decimal ( 7, 0 ),
--                              @dtCreeLe        DateTime,
--                              @dtMajLe         DateTime,
--                              @sMajPar         Varchar ( 4 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_I01_AFFILIER' AND type = 'P' )
            DROP procedure sysadm.IM_I01_AFFILIER
GO

CREATE PROC sysadm.IM_I01_AFFILIER
            @dcIdProd        decimal ( 7, 0 ),
            @dcIdRev         decimal ( 7, 0 ),
            @dcIdRevAnc      decimal ( 7, 0 ),
            @dtCreeLe        DateTime,
            @dtMajLe         DateTime,
            @sMajPar         Varchar ( 4 )
AS

INSERT INTO sysadm.affilier 
          ( sysadm.affilier.id_prod,   
            sysadm.affilier.id_rev,   
            sysadm.affilier.id_gti,   
            sysadm.affilier.id_carte, 
            sysadm.affilier.dte_affiliation, 
            sysadm.affilier.cree_le, 
            sysadm.affilier.maj_le, 
            sysadm.affilier.maj_par )
SELECT      sysadm.affilier.id_prod,   
            @dcIdRev,
            sysadm.affilier.id_gti,
            sysadm.affilier.id_carte, 
            sysadm.affilier.dte_affiliation,
            @dtCreeLe,
            @dtMajLe,
            @sMajPar
FROM        sysadm.affilier
WHERE       affilier.id_prod = @dcIdProd   AND
            affilier.id_rev  = @dcIdRevAnc

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_AFFILIER_SINISTRE
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       S‚lect sur la table AFFILIER
-- Références           :       Utilis‚ dans U_GS_SP_SINISTRE_GARANTIE
--
-- Arguments            :       @dcIdProd       decimal ( 7, 0 )                 (Val)
--                              @dcIdRev        decimal ( 7, 0 )                 (Val)
--                              @dcIdGti        decimal ( 7, 0 )                 (Val)
--                              @dcIdCarte      decimal ( 7, 0 )                 (Val)
--                              @iNbCarte       Integer         OUTPUT  (R‚f)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_AFFILIER_SINISTRE' AND type = 'P' )
        DROP procedure sysadm.PS_S01_AFFILIER_SINISTRE
GO

CREATE procedure sysadm.PS_S01_AFFILIER_SINISTRE
        @dcIdProd       decimal ( 7, 0 )       ,
        @dcIdRev        decimal ( 7, 0 )       ,
        @dcIdGti        decimal ( 7, 0 )       ,
        @dcIdCarte      decimal ( 7, 0 )       ,
        @iNbCarte       Integer       OUTPUT

AS
 SELECT @iNbCarte = Count(*)
 FROM   sysadm.affilier
 WHERE  affilier.id_prod        = @dcIdProd     AND
        affilier.id_rev         = @dcIdRev      AND
        affilier.id_gti         = @dcIdGti      AND
        affilier.id_carte       = @dcIdCarte

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S02_AFFILIER_SINISTRE
-- Auteur               :       FPI
-- Date                 :       17/12/2010
-- Libellé              :       [VDoc1306]
-- Commentaires         :       S‚lect sur la table AFFILIER
-- Références           :       Utilis‚ dans U_GS_SP_SINISTRE_GARANTIE
--
-- Arguments            :       @dcIdProd       decimal ( 7, 0 )                 (Val)
--                              @dcIdRev        decimal ( 7, 0 )                 (Val)
--                              @dcIdGti        decimal ( 7, 0 )                 (Val)
--                              @dcIdCarte      decimal ( 7, 0 )                 (Val)
--                              @dtAffil       Datetime         OUTPUT  (R‚f)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_AFFILIER_SINISTRE' AND type = 'P' )
        DROP procedure sysadm.PS_S02_AFFILIER_SINISTRE
GO

CREATE procedure sysadm.PS_S02_AFFILIER_SINISTRE
        @dcIdProd       decimal ( 7, 0 )       ,
        @dcIdRev        decimal ( 7, 0 )       ,
        @dcIdGti        decimal ( 7, 0 )       ,
        @dcIdCarte      decimal ( 7, 0 )       ,
        @dtAffil	Datetime       OUTPUT

AS
 SELECT @dtAffil = dte_affiliation
 FROM   sysadm.affilier
 WHERE  affilier.id_prod        = @dcIdProd     AND
        affilier.id_rev         = @dcIdRev      AND
        affilier.id_gti         = @dcIdGti      AND
        affilier.id_carte       = @dcIdCarte

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_MODIF_NUM_CARTE_EN_X
-- Auteur               :       JFF
-- Date                 :       14/12/2021
-- Libellé              :       
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MODIF_NUM_CARTE_EN_X' AND type = 'P' )
        DROP procedure sysadm.PS_S_MODIF_NUM_CARTE_EN_X
GO

CREATE procedure sysadm.PS_S_MODIF_NUM_CARTE_EN_X
	@dcIdSin		 Decimal ( 10 ),
	@sLes6PremiersCB	VarChar ( 6 ),
	@sLe7et8EnRetourCB	VarChar ( 2 ) OUTPUT 

AS

Set @sLes6PremiersCB = lTrim ( rTrim ( @sLes6PremiersCB ))
If @sLes6PremiersCB is null Set @sLes6PremiersCB = ''

If @sLes6PremiersCB = '' Or Len ( @sLes6PremiersCB ) <> 6 Or ISNUMERIC ( @sLes6PremiersCB ) = 0
 Begin
	Set @sLe7et8EnRetourCB = null
	Return -1
 End 

Select Top 1 @sLe7et8EnRetourCB = substring ( c.val_rg_mini, 7, 2 ) 
from sysadm.w_sin ws,
	 sysadm.affilier a,
	 sysadm.carte c
Where ws.id_sin = @dcIdSin 
And   a.id_prod = ws.id_prod
And   a.id_rev = ws.id_rev
And   c.id_carte = a.id_carte
And   Left ( c.val_rg_mini, 6 ) = @sLes6PremiersCB 

If @sLe7et8EnRetourCB is null 
  Begin
	Select Top 1 @sLe7et8EnRetourCB = substring ( c.val_rg_mini, 7, 2 ) 
	from sysadm.sinistre ws,
		 sysadm.affilier a,
		 sysadm.carte c
	Where ws.id_sin = @dcIdSin 
	And   a.id_prod = ws.id_prod
	And   a.id_rev = ws.id_rev
	And   c.id_carte = a.id_carte
	And   Left ( c.val_rg_mini, 6 ) = @sLes6PremiersCB 
  End 

If @sLe7et8EnRetourCB is null Set @sLe7et8EnRetourCB = ''

If @sLe7et8EnRetourCB = '' Or Len ( @sLe7et8EnRetourCB ) <> 2 Or ISNUMERIC ( @sLe7et8EnRetourCB ) = 0
 Begin
	Set @sLe7et8EnRetourCB = null
	Return -1
 End 

 Return 1

Go
