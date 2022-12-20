-------------------------------------------------------------------
--
-- Fichier              :       PARAM_FTU_BRK_VTS.CP
-- Auteur               :       Pinon Fabien
-- Date                 :       03/03/2011
--
-- Commentaires         :       Gestion de la table PARAM_FTU_BRK_VTS
--
-- Procédures           :       DW_S01_PARAM_FTU_BRK_VTS
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_PARAM_FTU_BRK_VTS
-- Auteur               :       Fabien PINON
-- Date                 :       01/03/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_FTU_BRK_VTS
-- Références           :       Pour paramétrage
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PARAM_FTU_BRK_VTS' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S01_PARAM_FTU_BRK_VTS
GO

CREATE procedure sysadm.DW_S01_PARAM_FTU_BRK_VTS
	@iIdTarif int
AS

Select id_tarif, cpt_vetuste, 
  ie_mt_pivot_min, mt_pivot_min, 
  mt_pivot_max, ie_mt_pivot_max, 
  periode_min_j, periode_max_j, tx_reprise, 
  cree_le, maj_le, maj_par
From 	sysadm.param_ftu_brk_vts pf
where 	pf.id_tarif=@iIdTarif
order by mt_pivot_min, mt_pivot_max, periode_min_j, periode_max_j
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_U01_PARAM_FTU_BRK_VTS
-- Auteur               :       Fabien PINON
-- Date                 :       17/03/2011
-- Libellé              :        
-- Commentaires         :       Update sur la table PARAM_FTU_BRK_VTS
-- Références           :       Pour paramétrage
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_PARAM_FTU_BRK_VTS' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_U01_PARAM_FTU_BRK_VTS
GO

CREATE procedure sysadm.DW_U01_PARAM_FTU_BRK_VTS
	@iIdTarif int, 
	@iCptVetuste int,
	@sIeMtPivotMin varchar(1),
	@dcMtPivotMin decimal(11,2),
	@dcMtPivotMax decimal(11,2),
	@sIeMtPivotMax varchar(1),
	@dcMtPeriodeMin decimal(11,2),
	@dcMtPeriodeMax decimal(11,2),
	@dcTxReprise decimal(11,5),
	@sMajPar varchar(4)
AS

UPDATE sysadm.param_ftu_brk_vts
   SET ie_mt_pivot_min = @sIeMtPivotMin,
      mt_pivot_min = @dcMtPivotMin,
      mt_pivot_max = @dcMtPivotMax,
      ie_mt_pivot_max = @sIeMtPivotMax,
      periode_min_j = @dcMtPeriodeMin,
      periode_max_j = @dcMtPeriodeMax,
      tx_reprise = @dcTxReprise,
      maj_le = getdate(),
      maj_par = @sMajPar
 WHERE id_tarif = @iIdTarif
 and cpt_vetuste = @iCptVetuste

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_PARAM_FTU_BRK_VTS
-- Auteur               :       Fabien PINON
-- Date                 :       17/03/2011
-- Libellé              :        
-- Commentaires         :       Insert sur la table PARAM_FTU_BRK_VTS
-- Références           :       Pour paramétrage
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_PARAM_FTU_BRK_VTS' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_I01_PARAM_FTU_BRK_VTS
GO

CREATE procedure sysadm.DW_I01_PARAM_FTU_BRK_VTS
	@iIdTarif int, 
	@iCptVetuste int OUTPUT,
	@sIeMtPivotMin varchar(1),
	@dcMtPivotMin decimal(11,2),
	@dcMtPivotMax decimal(11,2),
	@sIeMtPivotMax varchar(1),
	@dcMtPeriodeMin decimal(11,2),
	@dcMtPeriodeMax decimal(11,2),
	@dcTxReprise decimal(11,5),
	@sMajPar varchar(4)
AS

  Set @iCptVetuste = 1
  
  select @iCptVetuste = isnull(max(cpt_vetuste),0) + 1
  From sysadm.param_ftu_brk_vts
  WHERE id_tarif = @iIdTarif

  INSERT INTO sysadm.param_ftu_brk_vts
           (id_tarif,cpt_vetuste, 
           ie_mt_pivot_min,mt_pivot_min,mt_pivot_max,ie_mt_pivot_max,
           periode_min_j,periode_max_j,
           tx_reprise,
           cree_le, maj_le, maj_par)
  VALUES (
	@iIdTarif, @iCptVetuste,
	@sIeMtPivotMin,@dcMtPivotMin,@dcMtPivotMax,@sIeMtPivotMax,
	@dcMtPeriodeMin,@dcMtPeriodeMax,
	@dcTxReprise,
	getdate(),getdate(),@sMajPar
	)
 
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_PARAM_FTU_BRK_VTS
-- Auteur               :       Fabien PINON
-- Date                 :       17/03/2011
-- Libellé              :        
-- Commentaires         :       Delete sur la table PARAM_FTU_BRK_VTS
-- Références           :       Pour paramétrage
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_PARAM_FTU_BRK_VTS' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_D01_PARAM_FTU_BRK_VTS
GO

CREATE procedure sysadm.DW_D01_PARAM_FTU_BRK_VTS
	@iIdTarif int, 
	@iCptVetuste int
AS

DELETE FROM sysadm.param_ftu_brk_vts
WHERE id_tarif = @iIdTarif
   and cpt_vetuste = @iCptVetuste

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_PARAM_FTU_BRK_VTS
-- Auteur               :       Fabien PINON
-- Date                 :       01/04/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_FTU_BRK_VTS
-- Références           :       Pour l'export des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_PARAM_FTU_BRK_VTS' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S02_PARAM_FTU_BRK_VTS
GO

CREATE procedure sysadm.DW_S02_PARAM_FTU_BRK_VTS
As
  select id_tarif, cpt_vetuste, 
  ie_mt_pivot_min, mt_pivot_min, mt_pivot_max, ie_mt_pivot_max, 
  periode_min_j, periode_max_j, 
  tx_reprise, cree_le, maj_le, maj_par
  from sysadm.param_ftu_brk_vts
  order by id_tarif, cpt_vetuste

Go