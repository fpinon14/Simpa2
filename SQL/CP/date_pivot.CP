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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_DATE_PIVOT_CTRLE_REP_COURRIER_V01' AND type = 'P' )
        DROP procedure sysadm.PS_U_DATE_PIVOT_CTRLE_REP_COURRIER_V01
GO

CREATE procedure sysadm.PS_U_DATE_PIVOT_CTRLE_REP_COURRIER_V01
	@asCle   VarChar (50),
	@aiFrequenceMin integer,
	@asRepCourDest VarChar ( 200 )
AS
-- Retour 1 : Ok pour lancer Trt redressement + Commit en PB
-- Retour 0 : Pas de lancement Trt redressement

Declare @dtDt1 DateTime 
 
Select	@dtDt1 = dp.dte_1
From	sysadm.date_pivot dp with (nolock)
Where   dp.id_cle = @asCle

If @dtDt1 is null Return 0

If @dtDt1 < DATEADD ( minute, @aiFrequenceMin * (-1), Getdate()) 
  Begin
	Declare @sDIR Varchar ( 100 )
	Declare @TbRepCour Table ( nom_fic varchar ( 100) INDEX IX1 CLUSTERED ) 
	Declare @TbLstFicBase Table ( nom_fic varchar ( 100) INDEX IX1 CLUSTERED, ext varchar (3), autre varchar ( 10) ) 
	Set @sDIR = 'DIR "' + @asRepCourDest + '*.*" /b'

	-- Garantie qu'un autre GT ne lancera pas le traitement
	Update sysadm.date_pivot
	Set dte_1 = GETDATE ()
	Where id_cle = @asCle

	-- @TbRepCour se charge avec la liste des fichiers du répertoire
	Insert into @TbRepCour EXEC master.dbo.xp_cmdshell @sDIR 
	Delete @TbRepCour where nom_fic is null
	Update @TbRepCour Set nom_fic = Upper ( nom_fic )

	-- @@TbLstFicBase se charge avec la liste des fichiers de la base
	Insert into @TbLstFicBase EXEC sysadm.PS_S_PARA_REELS_REP_COURRIER
	Update @TbLstFicBase Set nom_fic = Upper ( nom_fic )

	-- S'il existe un fichier de la liste base absent du répertoire alors...
	If Exists ( 
		Select Top 1 1 
		From @TbLstFicBase Tl
		Where Not exists ( 
				Select Top 1 1 
				From @TbRepCour Tr
				Where Tr.nom_fic = Tl.nom_fic
			  )
	  )
	  Begin 
		Return 1
	  End 
	Else
	  Begin
		Return 0
	  End 
  End 

Return 0

Go
