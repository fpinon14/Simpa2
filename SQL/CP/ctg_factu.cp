-------------------------------------------------------------------
--
-- Fichier              :       CTG_FACTU.CP
-- Auteur               :       FPI
-- Date                 :       13/02/2017
--
-- Commentaires         :       PS rattachées à la table ctg_factu [PM251-5]
--
-- Proc‚dures           :       
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S01_CTG_FACTU
-- Auteur               :       FPI
-- Date                 :       10/02/2017
-- Libelle              :
-- Commentaires         :       
-- References           :		[PM251-5]
--
-- Arguments            :       
-- Retourne             :       
-------------------------------------------------------------------
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_CTG_FACTU' AND type = 'P' )
        DROP procedure sysadm.PS_S01_CTG_FACTU
GO


CREATE procedure sysadm.PS_S01_CTG_FACTU
AS

SELECT id_seq,
      marq_app,
      modl_app,
      categorie,
      alt_actif,
      cree_le,
      cree_par,
      maj_le,
      maj_par
  FROM sysadm.ctg_factu
  order by id_seq
  
Go

grant execute on sysadm.PS_S01_CTG_FACTU to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S02_CTG_FACTU
-- Auteur               :       FPI
-- Date                 :       13/02/2017
-- Libelle              :
-- Commentaires         :       
-- References           :		[PM251-5]
--
-- Arguments            :       
-- Retourne             :       
-------------------------------------------------------------------
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_CTG_FACTU' AND type = 'P' )
        DROP procedure sysadm.PS_S02_CTG_FACTU
GO

CREATE procedure sysadm.PS_S02_CTG_FACTU
AS

SELECT distinct categorie
FROM sysadm.ctg_factu  
Go

grant execute on sysadm.PS_S02_CTG_FACTU to rolebddsinistres
Go