-------------------------------------------------------------------
--
-- Fichier              :       DET_ART.CP
-- Auteur               :       Abdmeziem C.
-- Date                 :       11/09/02
--
-- Commentaires         :       Gestion de la table DET_ARTICLE
--
-- Procédures           :       DW_S01_DET_ARTICLE
--				DW_I01_DET_ARTICLE
--				DW_D01_DET_ARTICLE
--				DW_U01_DET_ARTICLE
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_DET_ARTICLE
-- Auteur               :       Abdmeziem C.
-- Date                 :       11/09/02
-- Libellé              :        
-- Commentaires         :       Select sur la table DET_ARTICLE
--
-- Arguments            :       Val	@sIdFour	VarChar( 3 )
--
-- Retourne             :       Rien
-- 
-- #1  JFF 17/10/07  Ajout du critère fournisseur [ALAPAGE]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DET_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_DET_ARTICLE
GO

CREATE procedure sysadm.DW_S01_DET_ARTICLE
	@sIdFour	Varchar( 3 )
AS
 SELECT id_four,
 	id_ref_four,
 	id_prod,
 	id_typ_art,
 	id_article,
 	cree_le,
 	maj_le,
 	maj_par
 FROM   sysadm.det_article
 Where  id_four = @sIdFour
 
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_DET_ARTICLE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2007
-- Libellé              :        
-- Commentaires         :       Insert sur la table DET_ARTICLE
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_DET_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_I01_DET_ARTICLE
GO

CREATE procedure sysadm.DW_I01_DET_ARTICLE
	@sIdFour    varchar(3),
 	@sIdRefFour varchar(20),
 	@sIdProd    decimal(7,0),
 	@sIdTypArt  varchar(3),
 	@sIdArticle varchar(20)
 
AS

 Insert into sysadm.det_article 
 	( 
 	id_four,
 	id_ref_four,
 	id_prod,
 	id_typ_art,
 	id_article,
 	cree_le,
 	maj_le,
 	maj_par
 	)
 values 
 	(
	@sIdFour    ,
 	@sIdRefFour ,
 	@sIdProd    ,
 	@sIdTypArt  ,
 	@sIdArticle ,
 	getdate(),
 	getdate(),
 	'OPCO'
 	)

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_DET_ARTICLE
-- Auteur               :       Fabry JF
-- Date                 :       31/10/2007
-- Libellé              :        
-- Commentaires         :       delete sur la table DET_ARTICLE
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_DET_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_D01_DET_ARTICLE
GO

CREATE procedure sysadm.DW_D01_DET_ARTICLE
	@sIdFour    varchar(3),
 	@sIdRefFour varchar(20)
 
AS

 Delete from sysadm.det_article 
 Where  id_prod = @sIdFour
 And    id_ref_four = @sIdRefFour

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_DET_ARTICLE_TEST_PRESENCE
-- Auteur               :       Fabry JF
-- Date                 :       31/10/2007
-- Libellé              :        
-- Commentaires         :       delete sur la table DET_ARTICLE
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_DET_ARTICLE_TEST_PRESENCE' AND type = 'P' )
        DROP procedure sysadm.PS_S01_DET_ARTICLE_TEST_PRESENCE
GO

CREATE procedure sysadm.PS_S01_DET_ARTICLE_TEST_PRESENCE
	@sIdFour    varchar(3),
 	@sIdRefFour varchar(20)
 
AS

 Select *
 From   sysadm.det_article 
 Where  id_four = @sIdFour
 And    id_ref_four = @sIdRefFour
 
 Return @@RowCount
 
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_U01_DET_ARTICLE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2007
-- Libellé              :        
-- Commentaires         :       Update sur la table DET_ARTICLE
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_DET_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_U01_DET_ARTICLE
GO

CREATE procedure sysadm.DW_U01_DET_ARTICLE
	@sIdFour    varchar(3),
 	@sIdRefFour varchar(20),
 	@sIdProd    decimal(7,0),
 	@sIdTypArt  varchar(3),
 	@sIdArticle varchar(20)
 
AS

 Update sysadm.det_article
 Set    id_article = @sIdArticle, maj_le = getdate()
 Where  id_four = @sIdFour
 And 	id_ref_four = @sIdRefFour
 And 	id_prod = @sIdProd
 And	id_typ_art = @sIdTypArt
 
GO
