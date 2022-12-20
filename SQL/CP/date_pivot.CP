-------------------------------------------------------------------
--
-- Fichier              :       DATE_PIVOT.CP
-- Auteur               :       FABRY JF
-- Date                 :       07/06/2016
--
-- Commentaires         :       
--
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_DATE_PIVOT
-- Auteur               :       FABRY JF
-- Da te                 :       07/06/2016
-- Libellé              :       [DT227]
-- Commentaires         :       
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_DATE_PIVOT' AND type = 'P' )
        DROP procedure sysadm.PS_S_DATE_PIVOT
GO

CREATE procedure sysadm.PS_S_DATE_PIVOT
	@asCle   VarChar (50),
	@dtDt1	 DateTime Output,
	@dtDt2	 DateTime Output,
	@dtDt3	 DateTime Output
AS

	Select	@dtDt1 = dp.dte_1,
			@dtDt2 = dp.dte_2,
			@dtDt3 = dp.dte_3
	From	sysadm.date_pivot dp
	Where   dp.id_cle = @asCle

Go
