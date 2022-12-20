-------------------------------------------------------------------
--
-- Fichier              :       CONSULT_RESTREINTE_EXCL.CP
-- Auteur               :       Fabry JF
-- Date                 :       29/10/2018
--
-- Commentaires         :       
--
-- Proc‚dures           :      
--
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_CONS_RESTR_EXCL
-- Auteur               :       Fabry JF
-- Date                 :       01/02/2018
-- Libelle              :       
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
-- JFF      11/02/2019   [PM473-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_CONS_RESTR_EXCL' AND type = 'P' )
        DROP procedure sysadm.PS_S_CONS_RESTR_EXCL
GO

CREATE procedure sysadm.PS_S_CONS_RESTR_EXCL
	@adcIdSin	Decimal ( 10 ),
	@asIdOper   VarChar ( 4 ),
	@asTable	VarChar ( 1 )
AS


-- [PM473-1]
If @asTable = 'W' 
	Begin 
		If Exists ( 
			Select  Top 1 1 
			From	sysadm.w_sin ws,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.autorisation au,
					sysadm.produit_excl_hors_ue px
			Where   ws.id_sin = @adcIdSin
			And     ga.id_prod = ws.id_prod
			And     ga.id_rev = ws.id_rev  
			And     po.id_police = ga.id_police
			And     au.id_oper = @asIdOper
			And     au.id_nat_oper = 31
			And     px.id_cie = po.id_cie
			And     ( px.id_prod = -1 Or px.id_prod = ws.id_prod )
			) 
			Begin
				Return -1
			End 
	End 

If @asTable = 'P' 
	Begin 
		If Exists ( 
			Select  Top 1 1 
			From	sysadm.sinistre s,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.autorisation au,
					sysadm.produit_excl_hors_ue px
			Where   s.id_sin = @adcIdSin
			And     ga.id_prod = s.id_prod
			And     ga.id_rev = s.id_rev  
			And     po.id_police = ga.id_police
			And     au.id_oper = @asIdOper
			And     au.id_nat_oper = 31
			And     px.id_cie = po.id_cie
			And     ( px.id_prod = -1 Or px.id_prod = s.id_prod )
			) 
			Begin
				Return -1
			End 
	End 

Return 1
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U_CONS_RESTR_EXCL
-- Auteur               :       Fabry JF
-- Date                 :       01/02/2018
-- Libelle              :       
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_CONS_RESTR_EXCL' AND type = 'P' )
        DROP procedure sysadm.PS_U_CONS_RESTR_EXCL
GO

CREATE procedure sysadm.PS_U_CONS_RESTR_EXCL
	@adcIdSin	Decimal ( 10 )
AS

Update sysadm.w_queue Set alt_occupe = 'N' Where id_sin = @adcIdSin	
Update sysadm.routage Set alt_queue = 'N' Where id_sin = @adcIdSin	

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_ACCES_GT_UE_HORS_UE
-- Auteur               :       Fabry JF
-- Date                 :       12/02/2019
-- Libelle              :       
-- Commentaires         :       [PM473-1]
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_ACCES_GT_UE_HORS_UE' AND type = 'P' )
        DROP procedure sysadm.PS_S_ACCES_GT_UE_HORS_UE
GO

CREATE procedure sysadm.PS_S_ACCES_GT_UE_HORS_UE
	@asIdOper	 VarChar ( 4 ),
	@adcIdProd   Decimal ( 7 ),
	@adtDteAdh   DateTime,
	@adtDteSurv  DateTime,
	@adcIdSin	 Decimal ( 10 )
AS

Declare @iRet Integer
Declare @sRev     VarChar ( 10 )

--  1  GT Hors UE autorisé
--  0  Manque des paramètres ou paramètre erroné ou décision impossible
-- -1  GT Hors UE refusé

If ltrim ( @asIdOper ) = '' Set @asIdOper = null

If @asIdOper is null Return 0

If	@adcIdSin is Not null 
  Begin
	If Not Exists ( Select Top 1 1 From sysadm.w_sin where id_sin = @adcIdSin )
	   And 
	   Not Exists ( Select Top 1 1 From sysadm.sinistre where id_sin = @adcIdSin )
	   Begin
		Return 0
	   End 

	If Exists ( Select Top 1 1 From sysadm.w_sin where id_sin = @adcIdSin )
	  Begin 
		Exec @iRet = sysadm.PS_S_CONS_RESTR_EXCL @adcIdSin, @asIdOper, 'W'
		Return @iRet 
	  End 

	If Exists ( Select Top 1 1 From sysadm.sinistre where id_sin = @adcIdSin )
	  Begin 
		Exec @iRet = sysadm.PS_S_CONS_RESTR_EXCL @adcIdSin, @asIdOper, 'W'
		Return @iRet 
	  End 

	Return 0

  End 

If	@adcIdProd is not null And @adtDteAdh is not null And @adtDteSurv is not null 
  Begin

	If Not Exists ( Select Top 1 1 From sysadm.produit p Where p.id_prod = @adcIdProd ) Return 0

	If @adtDteAdh < '01/01/1980' Return 0
	If @adtDteSurv < '01/01/1980' Return 0
	Set @sRev = Space ( 10 )

	Exec sysadm.PS_X_CALC_REVISION @adcIdProd, @adtDteSurv, @adtDteAdh, @sRev OUTPUT
	
	If	@sRev is null Or @sRev = '-1' Return 0

	If Exists ( 
		Select  Top 1 1 
		From	sysadm.garantie ga,
				sysadm.police po,
				sysadm.autorisation au,
				sysadm.produit_excl_hors_ue px
		Where   ga.id_prod = @adcIdProd
		And     ga.id_rev = Convert ( Decimal ( 7 ), @sRev )
		And     po.id_police = ga.id_police
		And     au.id_oper = @asIdOper
		And     au.id_nat_oper = 31
		And     px.id_cie = po.id_cie
		And     ( px.id_prod = -1 Or px.id_prod = ga.id_prod )
	)
	Begin
		Return -1
	End 

	Return 1
  End

Return 0

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_CTLE_DOS_CREE_EN_SIM
-- Auteur               :       Fabry JF
-- Date                 :       12/02/2019
-- Libelle              :       
-- Commentaires         :       [PM473-1]
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CTLE_DOS_CREE_EN_SIM' AND type = 'P' )
        DROP procedure sysadm.PS_CTLE_DOS_CREE_EN_SIM
GO

CREATE procedure sysadm.PS_CTLE_DOS_CREE_EN_SIM
	@adcIdSin Decimal (10) -- [PI062]
As

Declare @sNom VarChar ( 100 )
Declare @dtDernValid DateTime 

Select @dtDernValid = dte_1
From   sysadm.date_pivot dp
Where  dp.id_cle = 'DERN_VALID'

Set @dtDernValid = DateAdd ( hour, 8, @dtDernValid )

If Exists ( Select top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin )
	Begin
		If Exists ( 
			Select	Top 1 1 
			From	sysadm.w_sin ws
			Where   ws.cree_le > @dtDernValid
			And     ws.id_sin = @adcIdSin
		)
		Begin
			Return 1
		End 
	End
Else 
	Begin
		If Exists ( Select top 1 1 From sysadm.sinistre Where id_sin = @adcIdSin )
			Begin
				If Exists ( 
					Select	Top 1 1 
					From	sysadm.sinistre s
					Where   s.cree_le > @dtDernValid
					And     s.id_sin = @adcIdSin
				)
				Begin
					Return 1
				End 
			End 
	End

Return -1

Go

 

