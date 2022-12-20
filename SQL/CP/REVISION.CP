-------------------------------------------------------------------
--
-- Fichier              :       Revision.cp
-- Auteur               :       La Recrue
-- Date                 :       18/07/97 11:35:24
--
-- Commentaires         :       Liste des procedures afférent à la table révision
--
-- Procédures           :       DD_S01_REVISION
--                              DW_S01_REVISION
--                              DW_I01_REVISION
--                              DW_D01_REVISION
--                              IM_D01_REVISION
--				PS_S01_CTRL_REV
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DD_S01_REVISION
-- Auteur               :       La Recrue
-- Date                 :       18/07/97 11:37:27
-- Libellé              :       Selection des révisions d'un produit
-- Commentaires         :
-- Références           :       dddw_sp_revision
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--
-- Retourne             :       ResultSet
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S01_REVISION' AND type = 'P' )
            DROP procedure sysadm.DD_S01_REVISION
GO

/* Migration Wyniwyg - 29/03/2006 - JCA
CREATE PROC sysadm.DD_S01_REVISION
        @dcIdProd       Decimal (  7,0 )
AS

SELECT  revision.id_rev,
        revision.lib_rev
FROM    sysadm.revision
WHERE   revision.id_prod = @dcIdProd

GO*/

CREATE PROC sysadm.DD_S01_REVISION
        @dcIdProd       Decimal (  7,0 )
AS

SELECT  revision.id_rev,
        revision.lib_rev
--Migration PB4 PB8 WYNIWYG 03/2006 : ajout d'une colonne
, cast(null as varchar(43)) as 'libelle'
FROM    sysadm.revision 
WHERE   revision.id_prod = @dcIdProd
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_REVISION
-- Auteur               :       N°6
-- Date                 :       22/07/97 17:25:09
-- Libellé              :       Sélection des Révisions d'un Produit
-- Commentaires         :
-- Références           :       Utilisee dans DW_LST_REV, Dw dynamique fenetre W_TM_SP_PRODUIT.
--                              Utilisee dans DW_1, fenetre W_TD_SP_REVISION.
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--
-- Retourne             :
--
-- #1			: 	Correction Post Migration PB8
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_REVISION' AND type = 'P' )
            DROP procedure sysadm.DW_S01_REVISION
GO

CREATE PROC sysadm.DW_S01_REVISION
        @dcIdProd       Decimal (  7,0 )
AS

 SELECT revision.id_prod,
        revision.id_rev,
        revision.lib_rev,
        revision.cod_eff_rev,
        revision.dte_eff,
        revision.dte_fin,
        revision.cree_le,
        revision.maj_le,
        revision.maj_par,
        revision.maj_par as alt_duplic -- [MIGPB8COR] #1
   FROM sysadm.revision
  WHERE revision.id_prod = @dcIdProd
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_REVISION
-- Auteur               :       N°6
-- Date                 :       22/07/97 17:27:30
-- Libellé              :       Insertion dans la table REVISION
-- Commentaires         :
-- Références           :       SQLPREVIEW de Dw_Lst_Rev : fenetre W_TM_SP_PRODUIT
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdRev        Decimal (  7,0 )        (Val)
--                              @sLibRev        String                  (Val)
--                              @sCodEffRev     String                  (Val)
--                              @dtDteEff       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dtCreeLe       DateTime                (Val)
--                              @dtMajLe        DateTime                (Val)
--                              @sMajPar        String                  (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_REVISION' AND type = 'P' )
            DROP procedure sysadm.DW_I01_REVISION
GO

CREATE PROC sysadm.DW_I01_REVISION
        @dcIdProd       Decimal (  7,0 ),
        @dcIdRev        Decimal (  7,0 ),
        @sLibRev        Varchar ( 35 )  ,
        @sCodEffRev     Varchar ( 20 )  ,
        @dtDteEff       DateTime        ,
        @dtDteFin       DateTime        ,
        @dtCreeLe       DateTime        ,
        @dtMajLe        DateTime        ,
        @sMajPar        Varchar ( 4 )
AS

 INSERT INTO sysadm.revision
           ( revision.id_prod,
             revision.id_rev,
             revision.lib_rev,
             revision.cod_eff_rev,
             revision.dte_eff,
             revision.dte_fin,
             revision.cree_le,
             revision.maj_le, 
             revision.maj_par )
      VALUES
           ( @dcIdProd, @dcIdRev, @sLibRev, @sCodEffRev, @dtDteEff,
             @dtDteFin, @dtCreeLe, @dtMajLe, @sMajPar )

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_REVISION
-- Auteur               :       N°6
-- Date                 :       22/07/97 17:31:28
-- Libellé              :       Suppression d'une Révision d'un Produit.
-- Commentaires         :
-- Références           :       SQLPREVIEW de Dw_Lst_Rev, fenetre W_TM_SP_PRODUIT
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdRev        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_REVISION' AND type = 'P' )
            DROP procedure sysadm.DW_D01_REVISION
GO

CREATE PROC sysadm.DW_D01_REVISION
        @dcIdProd       Decimal (  7,0 ),
        @dcIdRev        Decimal (  7,0 )
AS

 DELETE FROM sysadm.revision
       WHERE revision.id_prod = @dcIdProd AND
             revision.id_rev  = @dcIdRev

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_REVISION
-- Auteur               :       N°6
-- Date                 :       22/07/97 17:50:48
-- Libellé              :       Suppression dans la table REVISION
-- Commentaires         :
-- Références           :       Utilise par la procédure PS_SUPPRODUIT
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_REVISION' AND type = 'P' )
            DROP procedure sysadm.IM_D01_REVISION
GO

CREATE PROC sysadm.IM_D01_REVISION
        @dcIdProd       Decimal (  7,0 )
AS

 DELETE FROM sysadm.revision
       WHERE revision.id_prod = @dcIdProd

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_CTRL_REV
-- Auteur               :       FPI
-- Date                 :       04/02/2010
-- Libellé              :       Contrôle de saisie de révision
-- Commentaires         :
-- Références           :       [20100204.FPI]
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--				@dcIdprod 	Decimal (  7,0 )        (Val)
--				@sTypEffet 	VarChar ( 10 )        	(Val)
--				@dDteEff 	Datetime        	(Val)
--				@dDteMinProposee Datetime 		(Ref)
--
-- Retourne             :       1 = Ok
-- 				-1 = Une date (adhésion/survenance) postérieure à la date du jour existe pour un dossier.
--
-------------------------------------------------------------------
-- FPI - 01/02/2016 - Correction
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_CTRL_REV' AND type = 'P' )
            DROP procedure sysadm.PS_S01_CTRL_REV
GO

CREATE PROC sysadm.PS_S01_CTRL_REV
	@dcIdprod Decimal (7),
	@sTypEffet VarChar ( 10 ),
	@dDteEff Datetime,
	@dDteMinProposee Datetime OUTPUT
AS

Declare @dtJour Datetime,
	@dDteMin1 datetime
	
Set @dtJour = getdate()

If @sTypEffet = 'DTE_SOUS'
 Begin 
	Select @dDteMinProposee = max ( dte_adh )  
	from sysadm.sinistre s 
	Where s.id_prod = @dcIdprod 

	Select @dDteMin1 = max ( dte_adh )  
	from sysadm.sinistre s 
	Where s.id_prod = @dcIdprod 
	
 End 	

If @sTypEffet = 'DTE_SURV'
 Begin 
	Select @dDteMinProposee = max ( dte_surv )  
	from sysadm.sinistre s 
	Where s.id_prod = @dcIdprod 

	Select @dDteMin1 = max ( dte_surv )  
	from sysadm.sinistre s 
	Where s.id_prod = @dcIdprod 
 End 

If @sTypEffet = 'DTE_RNV'
 Begin 

	Select @dDteMinProposee = max ( sysadm.FN_DTE_RNV  ( s.id_sin ) )  
	from sysadm.sinistre s 
	Where s.id_prod = @dcIdprod 
	And   sysadm.FN_DTE_RNV  ( s.id_sin ) between @dDteEff and s.dte_surv

	Select @dDteMin1 = max ( sysadm.FN_DTE_RNV  ( s.id_sin ) )  
	from sysadm.sinistre s 
	Where s.id_prod = @dcIdprod 
	And   sysadm.FN_DTE_RNV  ( s.id_sin ) between @dDteEff and s.dte_surv
	
 End 

If @dDteMinProposee is null or @dDteMinProposee < @dDteMin1	Set @dDteMinProposee=@dDteMin1

If @dDteMinProposee is null
 Begin 
  Set @dDteMinProposee = @dDteEff
  Return 1
End 

If @dDteMinProposee > @dtJour
 Begin 
	Set @dDteMinProposee = null
	Return -1
 End 

Set @dDteMinProposee = DateAdd ( day, 1, @dDteMinProposee ) 

Return 1

Go

grant execute on sysadm.PS_S01_CTRL_REV to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_REVISION
-- Auteur               :       FPI
-- Date                 :       02/03/2011
-- Libellé              :       Sélection des Révisions d'un Produit pour param_ftu_brk
-- Commentaires         :
-- Références           :       [PM02]
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_REVISION' AND type = 'P' )
            DROP procedure sysadm.DW_S02_REVISION
GO

CREATE PROC sysadm.DW_S02_REVISION
        @dcIdProd       Decimal (  7,0 )
AS

 SELECT r.id_prod,
        r.id_rev,
        r.lib_rev
   FROM sysadm.revision r
  WHERE r.id_prod = @dcIdProd
  UNION
  Select @dcIdProd, -1,'Toute révision de ce produit'
GO