-------------------------------------------------------------------
--
-- Fichier              :       DIV_PDET.CP
-- Auteur               :       FABRY JF
-- Date                 :       04/10/2005
--
-- Commentaires         :       Gestion de la table DIV_PDET
--
-- Procédures           :       DW_S01_DIV_PDET
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_DIV_PDET
-- Auteur               :       FABRY JF
-- Date                 :       04/10/2005
-- Libellé              :        
-- Commentaires         :       Select sur la table DIV_PDET
-- Références           :       Utilise dans W_TM_SP_SINISTRE (Liste d‚tail)
--
-- Arguments            :       @dcIdProd        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DIV_PDET' AND type = 'P' )
        DROP procedure sysadm.DW_S01_DIV_PDET
GO

CREATE procedure sysadm.DW_S01_DIV_PDET
        @dcIdProd        Decimal (  7,0 )
AS

Select 
	id_prod,
	id_gti,
	nom_zone,
	lib_label,
	id_typ_liste,
	alt_liste_codecar,
	id_typ_zone,
	alt_oblig,
	cpt_tri,
	cree_le,
	maj_le,
	maj_par	
From 	sysadm.div_pdet
Where	id_prod = @dcIdProd

Go
