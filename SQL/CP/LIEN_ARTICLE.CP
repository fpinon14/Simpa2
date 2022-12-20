-------------------------------------------------------------------
--
-- Fichier              :       LIEN_ARTICLE.CP
-- Auteur               :       FABRY JF
-- Date                 :       29/02/2012
--
-- Commentaires         :       
--
-------------------------------------------------------------------
--------------------------------------------------------------------
--
-- Procédure            :       PS_S_VDOC6993_LIEN_ARTICLE
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [VDoc6993]
-- Références           :       
--
-------------------------------------------------------------------
--  JFF  26/12/2018  [OPTIM_LIEN_AUTO]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC6993_LIEN_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC6993_LIEN_ARTICLE
GO

CREATE procedure sysadm.PS_S_VDOC6993_LIEN_ARTICLE
	@sIdFour	VarChar ( 3 ),
	@sIdRefFour Varchar ( 20 ),
	@sIdMarqArt Varchar ( 35 ),
	@sIdModlArt varChar ( 35),
	@sIdMarqArtIFr Varchar ( 35 ) OUTPUT,
	@sIdModlArtIfr varChar ( 35 ) OUTPUT
	
AS
-- [OPTIM_LIEN_AUTO]
Select Top 1
		@sIdMarqArtIFr = rTrim ( l.marq_ifr ),
		@sIdModlArtIfr = rTrim ( l.modl_ifr )
From   sysadm.lien_article l
Where --  l.id_four = @sIdFour  // aucun intérêt (JFF le 10/08/2020)
--	And    l.id_ref_four = @sIdRefFour
--  And 
       l.marq_four = @sIdMarqArt
And    l.modl_four = @sIdModlArt

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_LIEN_ARTICLE
-- Auteur               :       FPI
-- Date                 :       05/03/2012
-- Libellé              :        
-- Commentaires         :       [VDoc6993]
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_LIEN_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_LIEN_ARTICLE
GO

CREATE procedure sysadm.DW_S01_LIEN_ARTICLE
	
AS

Select id_four, 
	id_ref_four, 
	marq_four, 
	modl_four, 
	marq_ifr, 
	modl_ifr, 
	cree_le, 
	maj_le, 
	maj_par
From   sysadm.lien_article l
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_U01_LIEN_ARTICLE
-- Auteur               :       FPI
-- Date                 :       05/03/2012
-- Libellé              :        
-- Commentaires         :       [VDoc6993]
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_LIEN_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_U01_LIEN_ARTICLE
GO

CREATE procedure sysadm.DW_U01_LIEN_ARTICLE
	@sIdFour	VarChar ( 3 ),
	@sIdRefFour Varchar ( 20 ),
	@sIdMarqArt Varchar ( 35 ),
	@sIdModlArt varChar ( 35),
	@sIdMarqArtIfr Varchar ( 35 ),
	@sIdModlArtIfr varChar ( 35 ),
	@sMajPar Varchar(4)
	
AS

Update sysadm.lien_article 
Set marq_ifr=@sIdMarqArtIfr, 
    modl_ifr=@sIdModlArtIfr,
    maj_le=getdate(),
    maj_par=@sMajPar
Where  id_four = @sIdFour
And    id_ref_four = @sIdRefFour
And    marq_four = @sIdMarqArt
And    modl_four = @sIdModlArt

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_LIEN_ARTICLE
-- Auteur               :       FPI
-- Date                 :       05/03/2012
-- Libellé              :       Liste des fournisseurs 
-- Commentaires         :       [VDoc6993]
-- Références           :       
--
-- JFF      28/09/2015   [PM319-1]
-- JFF      05/10/2015   [PM319-2]
-- FPI		15/09/2017   [DT328-1]
-- JFF      10/06/2021   [BTRUN_344_REF_BYGUES]  BYG
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_LIEN_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_S02_LIEN_ARTICLE
GO

CREATE procedure sysadm.DW_S02_LIEN_ARTICLE
	
AS

select distinct id_code_frn, 
	sysadm.FN_CODE_CAR(id_code_frn,'-FR') as lib_frn
From sysadm.commande_type
Where  id_code_art in ('TEL','PC1','PC2')
Union
-- [PM319-1] [PM319-2] [DT328-1]
Select distinct id_four, 
	sysadm.FN_CODE_CAR(id_four,'-FR') as lib_frn
From sysadm.article
Where  id_four in ( 'PPO', 'PPB' , 'RTB', 'BYG', 'FRE' )
And	   id_typ_art in ('TEL')

Go

grant execute on sysadm.DW_S02_LIEN_ARTICLE to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S03_LIEN_ARTICLE
-- Auteur               :       FPI
-- Date                 :       05/03/2012
-- Libellé              :       Liste des références fournisseurs
-- Commentaires         :       [VDoc6993]
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_LIEN_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_S03_LIEN_ARTICLE
GO

CREATE procedure sysadm.DW_S03_LIEN_ARTICLE
	@sIdFour	VarChar ( 3 )
AS

select distinct id_ref_four, 
	id_marq_art, 
	id_modl_art
From sysadm.article
Where  id_typ_art in ('TEL','PC1','PC2')
	and id_four=@sIdFour

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_LIEN_ARTICLE
-- Auteur               :       FPI
-- Date                 :       05/03/2012
-- Libellé              :       Ajout dans lien_article
-- Commentaires         :       [VDoc6993]
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_LIEN_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_I01_LIEN_ARTICLE
GO

CREATE procedure sysadm.DW_I01_LIEN_ARTICLE
	@sIdFour	VarChar ( 3 ),
	@sIdRefFour Varchar ( 20 ),
	@sIdMarqArt Varchar ( 35 ),
	@sIdModlArt varChar ( 35),
	@sIdMarqArtIfr Varchar ( 35 ) ,
	@sIdModlArtIfr varChar ( 35 ),
	@sMajPar Varchar(4)
	
AS

Insert into sysadm.lien_article (
	id_four, 
	id_ref_four, 
	marq_four, 
	modl_four, 
	marq_ifr, 
	modl_ifr,
	cree_le,
	maj_le,
	maj_par
	)
Values	(
	@sIdFour,
	@sIdRefFour,
	@sIdMarqArt,
	@sIdModlArt,
	@sIdMarqArtIfr,
	@sIdModlArtIfr,
	getdate(),
	getdate(),
	@sMajPar
	)
	
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_LIEN_ARTICLE
-- Auteur               :       FPI
-- Date                 :       05/03/2012
-- Libellé              :       Suppressiom dans lien_article
-- Commentaires         :       [VDoc6993]
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_LIEN_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_D01_LIEN_ARTICLE
GO

CREATE procedure sysadm.DW_D01_LIEN_ARTICLE
	@sIdFour	VarChar ( 3 ),
	@sIdRefFour Varchar ( 20 ),
	@sIdMarqArt Varchar ( 35 ),
	@sIdModlArt varChar ( 35)
	
	
AS

Delete from sysadm.lien_article 
Where  id_four = @sIdFour
  And    id_ref_four = @sIdRefFour
  And    marq_four = @sIdMarqArt
  And    modl_four = @sIdModlArt
	
Go