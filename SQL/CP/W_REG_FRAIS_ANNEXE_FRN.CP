-------------------------------------------------------------------
--
-- Fichier              :       W_REG_FRAIS_ANNEXE_FRN.CP
-- Auteur               :       JFF
-- Date                 :       16/09/2022
--
-- Commentaires         :       
--
-- Procédures           :       
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01
-- Auteur               :       JFF
-- Date                 :       2716/09/2022
-- Libell‚              :        
-- Commentaires         :       [PM80_FA12_FRANEX]
--
-- Retourne             :       Rien
-------------------------------------------------------------------
--  
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01' AND type = 'P' )
        DROP procedure sysadm.PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01
GO

CREATE procedure sysadm.PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01
		@adcIdSin        Decimal ( 10, 0 ), -- [PI062]
		@adcIdI          Decimal ( 7,0),
		@adcIdGti        Decimal ( 7,0),
		@adcIdDetail     Decimal ( 7,0),
		@adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]
		@adcMtFraisAnex_2 Decimal (11,2), -- [PM80_FA12_FRANEX]
		@adcMtFraisAnex_3 Decimal (11,2), -- [PM80_FA12_FRANEX]
		@adcMtFraisAnex_4 Decimal (11,2), -- [PM80_FA12_FRANEX]
		@adcMtFraisAnex_5 Decimal (11,2), -- [PM80_FA12_FRANEX]
		@adcMtFraisAnex_6 Decimal (11,2), -- [PM80_FA12_FRANEX]
		@adcMtFraisAnex_7 Decimal (11,2), -- [PM80_FA12_FRANEX]
		@adcMtFraisAnex_8 Decimal (11,2), -- [PM80_FA12_FRANEX]
		@adcMtFraisAnex_9 Decimal (11,2), -- [PM80_FA12_FRANEX]
		@adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]
		@adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]
		@asCodOper	VarChar ( 4 ) -- [PM80_FA12_FRANEX]
AS

	-- Delete sysadm.w_reg_frais_annexe_frn where id_sin = @adcIdSin and id_gti = @adcIdGti and id_detail = @adcIdDetail
	Delete sysadm.w_reg_frais_annexe_frn where id_sin = @adcIdSin 

	If @@Error <> 0 Return @@Error

	DECLARE @tb TABLE 
		( id_typ_frais integer,
		  mt_frais_anex decimal (11,2),
		  marquage	integer null 
		)

	Declare @iCpt Integer 
	Declare @dcMtFraisAnex Decimal ( 11, 2 ) 

	Insert into @tb values ( 1, @adcMtIndemPrinc_1, 0 )
	Insert into @tb values ( 2, @adcMtFraisAnex_2, 0)
	Insert into @tb values ( 3, @adcMtFraisAnex_3, 0)
	Insert into @tb values ( 4, @adcMtFraisAnex_4, 0)
	Insert into @tb values ( 5, @adcMtFraisAnex_5, 0)
	Insert into @tb values ( 6, @adcMtFraisAnex_6, 0)
	Insert into @tb values ( 7, @adcMtFraisAnex_7, 0)
	Insert into @tb values ( 8, @adcMtFraisAnex_8, 0)
	Insert into @tb values ( 9, @adcMtFraisAnex_9, 0)
	Insert into @tb values ( 10, @adcMtFraisAnex_10, 0)
	Insert into @tb values ( 11, @adcMtFraisAnex_11, 0)

	Set @iCpt = 1

	While Exists ( Select Top 1 1 From @tb where marquage = 0 )
	 Begin
		Select 	Top 1 
			@dcMtFraisAnex = mt_frais_anex
		From	@tb
		Where	marquage = 0
		And     id_typ_frais = @iCpt

		If @dcMtFraisAnex > 0
		  Begin
			Insert into sysadm.w_reg_frais_annexe_frn 
						(
							id_sin,
							id_reg,
							id_i,
							id_gti,
							id_detail,
							typ_frais_anx,
							mt_frais_anx,
							cree_le,
							maj_le,
							maj_par
						)
			Values		(
							@adcIdSin,
							0,
							@adcIdI,
							@adcIdGti,
							@adcIdDetail,
							@iCpt,
							@dcMtFraisAnex,
							Getdate(),
							Getdate(),
							@asCodOper
						)
			If @@Error <> 0 Return @@Error

		  End

		Update @tb Set marquage = 1 Where id_typ_frais = @iCpt
		Set @iCpt = @iCpt + 1
	 End

	Return @@Error
Go

