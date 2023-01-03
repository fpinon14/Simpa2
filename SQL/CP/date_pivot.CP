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

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_DATE_PIVOT_CTRLE_REP_COURRIER
-- Auteur               :       FABRY JF
-- Da te                 :      27/12/2022
-- Libellé              :       
-- Commentaires         :       
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_DATE_PIVOT_CTRLE_REP_COURRIER' AND type = 'P' )
        DROP procedure sysadm.PS_U_DATE_PIVOT_CTRLE_REP_COURRIER
GO

CREATE procedure sysadm.PS_U_DATE_PIVOT_CTRLE_REP_COURRIER
	@asCle   VarChar (50),
	@aiFrequenceMin integer
AS

Declare @dtDt1 DateTime 

-- Retour 1 : Ok pour lancer Trt redressement + Commit en PB
-- Retour 0 : Pas de lancement Trt redressement
 
Select	@dtDt1 = dp.dte_1
From	sysadm.date_pivot dp
Where   dp.id_cle = @asCle

If @dtDt1 is null Return 1

If @dtDt1 < DATEADD ( minute, @aiFrequenceMin * (-1), Getdate()) 
  Begin
	Update sysadm.date_pivot
	Set dte_1 = GETDATE ()
	Where id_cle = @asCle

	Return 1
	
  End 

Return 0

Go
