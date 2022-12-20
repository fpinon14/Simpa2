-------------------------------------------------------------------
--
-- Fichier              :       PARAM_FRAIS_DEFAUT.CP
-- Auteur               :       FPI
-- Date                 :       07/10/2013
--
-- Commentaires         :       Gestion des frais par défaut [VDoc12347]
--
-- Procédures           :       PS_S01_PARAM_FRAIS_DEFAUT
--------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_PARAM_FRAIS_DEFAUT
-- Auteur               :       FPI
-- Date                 :       07/10/2013
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDoc12347]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_PARAM_FRAIS_DEFAUT' AND type = 'P' )
        DROP procedure sysadm.PS_S01_PARAM_FRAIS_DEFAUT
GO

CREATE PROCEDURE PS_S01_PARAM_FRAIS_DEFAUT
	@dcIdProcess Decimal(7,0),
	@dcMontant	Decimal(7,2) OUTPUT
AS

	Set @dcMontant=0
	
  SELECT @dcMontant=mt_rbt
  FROM sysadm.param_frais_defaut
  WHERE id_process = @dcIdProcess and alt_prod = 'O'
  
  If @@RowCount=0 Set @dcMontant=0 -- Par sécurité

Go
