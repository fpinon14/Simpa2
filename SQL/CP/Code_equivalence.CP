-------------------------------------------------------------------
--
-- Fichier              :       CODE_EQUIVALENCE.CP
-- Auteur               :       FABRY JF
-- Date                 :       28/09/2004
--
-- Commentaires         :       SQL lié à la table Code_Equivalence
--
-- Proc‚dures           :       DW_S01_CODE_EQUIVALENCE
--
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_CODE_EQUIVALENCE
-- Auteur               :       FABRY JF
-- Date                 :       28/09/2004
-- Libell‚              :        
-- Commentaires         :       S‚lect sur la table CODE_EQUIVALENCE
-- R‚f‚rences           :       Utilis‚ dans W_CM_SP_SINISTRE 
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      23/05/2018   [PM373-2]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_CODE_EQUIVALENCE_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S01_CODE_EQUIVALENCE_V01
GO

CREATE procedure sysadm.DW_S01_CODE_EQUIVALENCE_V01
        
AS

Select 
	id_source,
	id_col,
	lib_col,
	id_val,
	lib_val,
	ordre_col_source,
	cree_le,
	maj_le,
	maj_par,
	lib_val_web,  -- [PM82][LOT3]
	ordre_valeur -- [PM373-2]
From 	sysadm.code_equivalence

GO

