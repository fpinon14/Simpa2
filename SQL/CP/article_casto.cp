/*
CREATE TABLE sysadm.article_casto
	(
	code_article int NOT NULL,
	libelle_article varchar(100) NOT NULL
	)  
Go

grant select, insert, delete, update on sysadm.article_casto to rolebddsinistres
Go
*/

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_CTL_ARTICLE_CASTO
-- Auteur               :       FPI
-- Date                 :       22/04/2014
-- Libellé              :        
-- Commentaires         :       Sélect sur la table article_casto
-- Références           :       
--
-- Arguments            :       @iCodeArticle int
--
-- Retourne             :       1 si le binome existe en table, 0 sinon
--
-------------------------------------------------------------------
-- JFF	07/09/2016	 Bascule table article_casto vers table article CAS/CAF
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_CTL_ARTICLE_CASTO' AND type = 'P' )
        DROP procedure sysadm.PS_S01_CTL_ARTICLE_CASTO
GO

CREATE procedure sysadm.PS_S01_CTL_ARTICLE_CASTO
        @iCodeArticle int
AS
	Declare @iRet integer
	
	Set @iRet=0

	Select @iRet=IsNull(Count(*),0)
	From sysadm.article a
	Where a.id_four = 'CAS'
	And	  a.id_ref_four = Convert ( VarChar, @iCodeArticle ) 

	If @iRet > 1 Set @iRet=1
	
	Return @iRet
Go

grant execute on sysadm.PS_S01_CTL_ARTICLE_CASTO to rolebddsinistres
Go