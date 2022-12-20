-------------------------------------------------------------------
--
-- Fichier              :       PARAM_ALERTE_FRN.CP
-- Auteur               :       FPI
-- Date                 :       17/11/2011
--
-- Commentaires         :       [PM95]
-------------------------------------------------------------------
-- DW_S01_PARAM_ALERTE_FRN	FPI 17/11/2011 
-- DW_S02_PARAM_ALERTE_FRN	FPI 17/11/2011 
-- DW_S03_PARAM_ALERTE_FRN	FPI 17/11/2011 
-- DW_S04_PARAM_ALERTE_FRN	FPI 17/11/2011 
-- DW_I01_PARAM_ALERTE_FRN
-- DW_U01_PARAM_ALERTE_FRN
-- DW_D01_PARAM_ALERTE_FRN
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_PARAM_ALERTE_FRN
-- Auteur               :       Fabien PINON
-- Date                 :       17/11/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_ALERTE_FRN
-- Références           :       Pour la fenêtre accueil des PARAM_ALERTE_FRN
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PARAM_ALERTE_FRN' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S01_PARAM_ALERTE_FRN
GO

CREATE procedure sysadm.DW_S01_PARAM_ALERTE_FRN
  @iIdParam	Int,
  @iIdProd	Decimal(7,0),
  @iIdGti	Decimal(7,0),
  @sIdFour	Varchar(6),
  @iIdAlerte	Int
    
AS
Select id_param, alt_actif, id_prod, id_gti, id_four, 
	paf.id_alerte, del_extr_j, relance_2, 
	paf.cree_le, paf.maj_le, paf.maj_par,
	Case When id_gti=-1 Then 'Toutes garanties' Else sysadm.FN_CODE_NUM(paf.id_gti, '-GA') End as lib_gti,
	pafd.nat_alerte as lib_alerte	
From 	sysadm.param_alerte_frn paf
inner join sysadm.param_alerte_frn_def pafd on paf.id_alerte=pafd.id_alerte
Where 	(@iIdParam is null or paf.id_param=@iIdParam)
  and  (@iIdProd is null or paf.id_prod=@iIdProd)
  and  (@iIdGti is null or paf.id_gti=@iIdGti)
  and  (@sIdFour is null or paf.id_four=@sIdFour)
  and  (@iIdAlerte is null or paf.id_alerte=@iIdAlerte)
  
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_PARAM_ALERTE_FRN
-- Auteur               :       Fabien PINON
-- Date                 :       17/11/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_ALERTE_FRN
-- Références           :       Pour la fenêtre accueil des PARAM_ALERTE_FRN
--
-- Arguments            :      @sColonne la colonne souhaitée (ID_PROD ou ID_GTI)
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_PARAM_ALERTE_FRN' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S02_PARAM_ALERTE_FRN
GO

CREATE procedure sysadm.DW_S02_PARAM_ALERTE_FRN
  @sColonne varchar(10)
    
AS

If Upper(@sColonne) = 'ID_PROD'
Begin
	Select distinct paf.id_prod as id_code, p.lib_long as lib_code
	From 	sysadm.param_alerte_frn paf
	inner join sysadm.produit p on paf.id_prod = p.id_prod
End

If Upper(@sColonne) = 'ID_GTI'
Begin
	Select distinct paf.id_gti as id_code, 
		Case When id_gti=-1 Then 'Toutes garanties' Else sysadm.FN_CODE_NUM(paf.id_gti, '-GA') End as lib_code
	From 	sysadm.param_alerte_frn paf
End
  
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S03_PARAM_ALERTE_FRN
-- Auteur               :       Fabien PINON
-- Date                 :       17/11/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_ALERTE_FRN
-- Références           :       Pour la fenêtre accueil des PARAM_ALERTE_FRN
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_PARAM_ALERTE_FRN' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S03_PARAM_ALERTE_FRN
GO

CREATE procedure sysadm.DW_S03_PARAM_ALERTE_FRN
    
AS

Select distinct paf.id_alerte, pafd.nat_alerte
From 	sysadm.param_alerte_frn paf
inner join sysadm.param_alerte_frn_def pafd on paf.id_alerte=pafd.id_alerte
  
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S04_PARAM_ALERTE_FRN
-- Auteur               :       Fabien PINON
-- Date                 :       17/11/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_ALERTE_FRN
-- Références           :       Pour la fenêtre traitement des PARAM_ALERTE_FRN
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_PARAM_ALERTE_FRN' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S04_PARAM_ALERTE_FRN
GO

CREATE procedure sysadm.DW_S04_PARAM_ALERTE_FRN
	@iIdParam int
As
  Select id_param, alt_actif, 
    id_prod, id_gti, id_four, 
    id_alerte, del_extr_j, relance_2, 
    cree_le, maj_le, maj_par,
    'N' as alt_reinit,
    'N' as alt_mode_creat
  From sysadm.param_alerte_frn
  Where id_param=@iIdParam
  
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_PARAM_ALERTE_FRN
-- Auteur               :       Fabien PINON
-- Date                 :       17/11/2011
-- Libellé              :        
-- Commentaires         :       Insert sur la table PARAM_ALERTE_FRN
-- Références           :       Pour la fenêtre traitement des PARAM_ALERTE_FRN
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_PARAM_ALERTE_FRN' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_I01_PARAM_ALERTE_FRN
GO

CREATE procedure sysadm.DW_I01_PARAM_ALERTE_FRN
	@sAltActif	varchar(1),
        @dcIdProd	decimal(7,0),
        @dcIdGti	decimal(7,0),
        @sIdFour 	varchar(3),
        @iIdAlerte	int,
        @iDelExtrJ 	int,
        @sRelance2 	varchar(1),
	@sMajPar	varchar(4),
	@iIdParam 	int OUTPUT
As
  Declare @iRet int
  
  INSERT INTO sysadm.param_alerte_frn
           (alt_actif,
	   id_prod,
           id_gti,
           id_four,
           id_alerte,
           del_extr_j,
           relance_2,
           cree_le,
           maj_le,
           maj_par)
     VALUES
           (@sAltActif,
        @dcIdProd,
        @dcIdGti,
        @sIdFour,
        @iIdAlerte,
        @iDelExtrJ,
        @sRelance2,
	getdate(),
	getdate(),
	@sMajPar)

  Select @iIdParam = @@IDENTITY, @iRet=@@ERROR

  If @iRet <> 0 Set @iIdParam=NULL

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_U01_PARAM_ALERTE_FRN
-- Auteur               :       Fabien PINON
-- Date                 :       18/11/2011
-- Libellé              :        
-- Commentaires         :       Update sur la table PARAM_ALERTE_FRN
-- Références           :       Pour la fenêtre traitement des PARAM_ALERTE_FRN
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_PARAM_ALERTE_FRN' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_U01_PARAM_ALERTE_FRN
GO

CREATE procedure sysadm.DW_U01_PARAM_ALERTE_FRN
	@iIdParam 	int,
	@sAltActif	varchar(1),
        @iDelExtrJ 	int,
        @sRelance2 	varchar(1),
	@sMajPar	varchar(4)
As
 Update sysadm.param_alerte_frn
 Set alt_actif=@sAltActif,
	del_extr_j = @iDelExtrJ,
        relance_2 = @sRelance2,
        maj_le = getdate(),
        maj_par = @sMajPar
 Where id_param = @iIdParam

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_PARAM_ALERTE_FRN
-- Auteur               :       Fabien PINON
-- Date                 :       18/11/2011
-- Libellé              :        
-- Commentaires         :       Update sur la table PARAM_ALERTE_FRN
-- Références           :       Pour la fenêtre traitement des PARAM_ALERTE_FRN
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_PARAM_ALERTE_FRN' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_D01_PARAM_ALERTE_FRN
GO

CREATE procedure sysadm.DW_D01_PARAM_ALERTE_FRN
	@iIdParam 	int
As
 Delete From sysadm.param_alerte_frn
 Where id_param = @iIdParam

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S05_PARAM_ALERTE_FRN
-- Auteur               :       Fabien PINON
-- Date                 :       21/11/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_ALERTE_FRN
-- Références           :       Pour l'extraction Excel
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S05_PARAM_ALERTE_FRN' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S05_PARAM_ALERTE_FRN
GO

CREATE procedure sysadm.DW_S05_PARAM_ALERTE_FRN
    
AS
Select id_param, alt_actif, id_prod, sysadm.FN_LIB_PROD(id_prod) as lib_produit,
	id_gti, Case When id_gti=-1 Then 'Toutes garanties' Else sysadm.FN_CODE_NUM(paf.id_gti, '-GA') End as lib_gti,
	id_four, 
	paf.id_alerte, rtrim(pafd.nat_alerte) as lib_alerte,
	del_extr_j, relance_2, 
	paf.cree_le, paf.maj_le, paf.maj_par
From 	sysadm.param_alerte_frn paf
inner join sysadm.param_alerte_frn_def pafd on paf.id_alerte=pafd.id_alerte

  
Go
