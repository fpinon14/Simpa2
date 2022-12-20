-------------------------------------------------------------------
--
-- Fichier              : trace_facture_a_regler.cp
--
-- Commentaires         : Proc‚dure de la table trace_facture_a_regler 
--
-- Proc‚dures           
-- 
-- DW_S01_TRACE_FACT_A_REGL	FPI	03/08/2009 PS de lecture trace_facture_a_regler 
-------------------------------------------------------------------


--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_TRACE_FACT_A_REGL
-- Auteur               :       FPI
-- Date                 :       03/08/2009
-- Libell‚              :        
-- Commentaires         :       Lecture trace_facture_a_regler 
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_TRACE_FACT_A_REGL' AND type = 'P' )
        DROP procedure sysadm.DW_S01_TRACE_FACT_A_REGL
GO

CREATE procedure DW_S01_TRACE_FACT_A_REGL
AS

Select 	id_cle,
		id_sin,
		id_seq,
		id_four_fact as id_four,
		num_fact as num_facture,
		dte_fact,
		mt_a_reg as mt_fact,
		'boutique : ' + id_boutique + ' lot d’extraction : '  as cat_fact,
		id_lot_extr,
		id_boutique
From sysadm.trace_facture_a_regler
Where id_lot_extr = 0

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_U01_TRACE_FACT_A_REGL
-- Auteur               :       FPI
-- Date                 :       03/08/2009
-- Libell‚              :        
-- Commentaires         :       Update trace_facture_a_regler 
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_TRACE_FACT_A_REGL' AND type = 'P' )
        DROP procedure sysadm.PS_U01_TRACE_FACT_A_REGL
GO

CREATE procedure PS_U01_TRACE_FACT_A_REGL
	@iIdCle	int,
	@iIdLot	int
AS

Update sysadm.trace_facture_a_regler
Set id_lot_extr = @iIdLot
Where id_cle = @iIdCle

Go

