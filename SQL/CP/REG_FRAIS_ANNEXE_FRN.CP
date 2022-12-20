-------------------------------------------------------------------
--
-- Fichier              :       REG_FRAIS_ANNEXE_FRN.CP
-- Auteur               :       JFF
-- Date                 :       16/09/2022
--
-- Commentaires         :       
--
-- Procédures           :       
-------------------------------------------------------------------


--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_REG_FRAIS_ANNEXE_FRN_VAL
-- Auteur               :       JFF
-- Date                 :       16/09/2022
-- Libellé              :        
-- Commentaires         :       Insertion dans la table reg_frais_annexe_frn
-- Références           :       
--
--
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_REG_FRAIS_ANNEXE_FRN_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_REG_FRAIS_ANNEXE_FRN_VAL
GO

CREATE procedure sysadm.PS_I01_REG_FRAIS_ANNEXE_FRN_VAL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

 INSERT INTO    sysadm.reg_frais_annexe_frn
        (       reg_frais_annexe_frn.id_sin,
                reg_frais_annexe_frn.id_reg,
				reg_frais_annexe_frn.id_i,
                reg_frais_annexe_frn.id_gti,
                reg_frais_annexe_frn.id_detail,
				reg_frais_annexe_frn.typ_frais_anx,
                reg_frais_annexe_frn.mt_frais_anx,
                reg_frais_annexe_frn.cree_le,
                reg_frais_annexe_frn.maj_le,
                reg_frais_annexe_frn.maj_par,         
                reg_frais_annexe_frn.valide_le,
                reg_frais_annexe_frn.valide_par         
		)
 SELECT         w_reg_frais_annexe_frn.id_sin,
				w_reg_frais_annexe_frn.id_reg,
				w_reg_frais_annexe_frn.id_i,
				w_reg_frais_annexe_frn.id_gti,
				w_reg_frais_annexe_frn.id_detail,
				w_reg_frais_annexe_frn.typ_frais_anx,
				w_reg_frais_annexe_frn.mt_frais_anx,
				w_reg_frais_annexe_frn.cree_le,
				w_reg_frais_annexe_frn.maj_le,
				w_reg_frais_annexe_frn.maj_par,         
                @dtValideLe,
                @sCodOper
 FROM           sysadm.w_reg_frais_annexe_frn
 WHERE          w_reg_frais_annexe_frn.id_sin = @dcIdSin

 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_REG_FRAIS_ANNEXE_FRN_V01
-- Auteur               :       JFF
-- Date                 :       16/09/2022
-- Libellé              :        
-- Commentaires         :       Insertion dans la table reg_frais_annexe_frn
-- Références           :       
--
--
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_REG_FRAIS_ANNEXE_FRN_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_REG_FRAIS_ANNEXE_FRN_V01
GO

CREATE procedure sysadm.PS_I_REG_FRAIS_ANNEXE_FRN_V01
		@adcIdSin        Decimal ( 10, 0 ), -- [PI062]
		@adcIdReg		 Decimal ( 2, 0),
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
		@asCodOper        Varchar (4 ) -- [PM80_FA12_FRANEX]
AS

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

		If @dcMtFraisAnex <> 0 
		  Begin
			 INSERT INTO    sysadm.reg_frais_annexe_frn VALUES
					(       @adcIdSin,
							@adcIdReg,
							@adcIdI,
							@adcIdGti,
							@adcIdDetail,
							@iCpt,
							@dcMtFraisAnex,
							Getdate(),
							Getdate(),
							@asCodOper,         
							Getdate(),
							@asCodOper
					)
		  End

		Update @tb Set marquage = 1 Where id_typ_frais = @iCpt
		Set @iCpt = @iCpt + 1
	 End
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_REG_FRAIS_ANNEXE_FRN_TYP_DIF
-- Auteur               :       JFF
-- Date                 :       16/09/2022
-- Libellé              :        
-- Commentaires         :       Insertion dans la table reg_frais_annexe_frn
-- Références           :       
--
--
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_REG_FRAIS_ANNEXE_FRN_TYP_DIF' AND type = 'P' )
        DROP procedure sysadm.PS_S_REG_FRAIS_ANNEXE_FRN_TYP_DIF
GO

CREATE procedure sysadm.PS_S_REG_FRAIS_ANNEXE_FRN_TYP_DIF
		@adcIdSin Decimal ( 10 ),
		@adcIdRegBase Decimal ( 2 ),
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
		@asVentilFraisOrig     Varchar ( 100 ) OutPut, -- [PM80_FA12_FRANEX]
		@asVentilFraisEnCoursAff  Varchar ( 100 ) OutPut, -- [PM80_FA12_FRANEX]
		@asVentilFraisEnCoursCtrle Varchar ( 100 ) OutPut -- [PM80_FA12_FRANEX]
AS

	Declare @iIdTypFrais Integer

	Select @asVentilFraisOrig = 
			( 
			SELECT Distinct '#' + CAST(rtrim ( rf.typ_frais_anx ) AS VARCHAR(250)) 
			FROM sysadm.reg_frais_annexe_frn rf with (nolock),
					sysadm.reglement rg  with (nolock)
			Where rg.id_sin = @adcIdSin 
			And   ( rg.id_reg_base = @adcIdRegBase or rg.id_reg = @adcIdRegBase ) 
			And   rg.lib_reg not in ( 'RM/FRANCHISE (FR5)', 'RM/REMB. FRANCHISE CB A L''ASSUREUR' ) -- [ITSM249772] [ICI]
			And   rg.cod_mot_reg in ( 'RN', 'RP' ) -- [ITSM429073]
			And   rf.id_sin = rg.id_sin
			And   rf.id_reg = rg.id_reg
			Order by 1 
			For XML PATH ('') 
			)  
	If @asVentilFraisOrig  is null Set @asVentilFraisOrig = ''
	Set @asVentilFraisOrig = @asVentilFraisOrig + '#'


	Set @asVentilFraisEnCoursAff = '#'
	Set @asVentilFraisEnCoursCtrle = '#'

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
			@iIdTypFrais = id_typ_frais,
			@dcMtFraisAnex = mt_frais_anex
		From	@tb
		Where	marquage = 0
		And     id_typ_frais = @iCpt

		If @dcMtFraisAnex <> 0
		  Begin
			Set @asVentilFraisEnCoursCtrle = @asVentilFraisEnCoursCtrle + Convert ( Varchar ( 20 ), @iIdTypFrais ) + '#'
			Set @asVentilFraisEnCoursAff = @asVentilFraisEnCoursAff + Convert ( Varchar ( 20 ), @iIdTypFrais ) + '#'
		  End
		Else
		  Begin
		    If CharIndex ( '#' + Convert ( varchar( 20), @iIdTypFrais ) + '#', @asVentilFraisOrig) > 0 
			  Begin
				Set @asVentilFraisEnCoursCtrle = @asVentilFraisEnCoursCtrle + Convert ( Varchar ( 20 ), @iIdTypFrais ) + '#'
			  End 
		  End  

		Update @tb Set marquage = 1 Where id_typ_frais = @iCpt
		Set @iCpt = @iCpt + 1
	 End

	 If @asVentilFraisEnCoursAff is null Set @asVentilFraisEnCoursAff = ''
	 If @asVentilFraisEnCoursCtrle is null Set @asVentilFraisEnCoursCtrle = ''
	 If @asVentilFraisOrig is null Set @asVentilFraisOrig  = ''

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_REG_FRAIS_ANNEXE_FRN_SOM_REGL_INCO
-- Auteur               :       JFF
-- Date                 :       16/09/2022
-- Libellé              :        
-- Commentaires         :       Insertion dans la table reg_frais_annexe_frn
-- Références           :       
--
--
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_REG_FRAIS_ANNEXE_FRN_SOM_REGL_INCO' AND type = 'P' )
        DROP procedure sysadm.PS_S_REG_FRAIS_ANNEXE_FRN_SOM_REGL_INCO
GO

CREATE procedure sysadm.PS_S_REG_FRAIS_ANNEXE_FRN_SOM_REGL_INCO
		@adcIdSin Decimal ( 10 ),
		@adcIdRegBase Decimal ( 2 ),
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
		@adcMtFraisAnexExistant Decimal ( 11,2 ) OutPut,
		@adcMtFraisAPasser Decimal ( 11,2 ) OutPut, 
	    @aiTypeDuFrais Integer OutPut,
		@adcMtDifFraisAnx Decimal ( 11,2 ) OutPut

AS


	DECLARE @tbSomRNRMRP_Actuel_par_typeFrAnx TABLE 
		( id_typ_frais integer,
		  mt_frais_anex decimal (11,2),
		  marquage	integer null 
		)

	Insert into @tbSomRNRMRP_Actuel_par_typeFrAnx
	SELECT rf.typ_frais_anx , sum ( rf.mt_frais_anx ), 0 
	FROM sysadm.reg_frais_annexe_frn rf,
			sysadm.reglement rg
	Where rg.id_sin = @adcIdSin 
	And   ( rg.id_reg_base = @adcIdRegBase or rg.id_reg = @adcIdRegBase ) 
	And   rg.lib_reg not in ( 'RM/FRANCHISE (FR5)', 'RM/REMB. FRANCHISE CB A L''ASSUREUR' ) -- [ITSM249772] [ICI]
	And   rg.cod_mot_reg in ( 'RN', 'RM', 'RP' ) -- [ITSM429073]
	And   rf.id_sin = rg.id_sin
	And   rf.id_reg = rg.id_reg
	Group by rf.typ_frais_anx
	Order by 1 


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

		If @dcMtFraisAnex is null Set @dcMtFraisAnex = 0

		Set @adcMtDifFraisAnx = 0

		Select @adcMtFraisAnexExistant = mt_frais_anex,
			   @adcMtFraisAPasser = @dcMtFraisAnex,
			   @aiTypeDuFrais = @iCpt,
			   @adcMtDifFraisAnx = mt_frais_anex - abs ( @dcMtFraisAnex )
		From @tbSomRNRMRP_Actuel_par_typeFrAnx tbSom
		Where tbSom.id_typ_frais = @iCpt

		If @adcMtFraisAnexExistant is null Set @adcMtFraisAnexExistant = 0 
		If @adcMtFraisAPasser is null Set @adcMtFraisAPasser = 0
		If @aiTypeDuFrais is null Set @aiTypeDuFrais = 0 
		If @adcMtDifFraisAnx is null Set @adcMtDifFraisAnx = 0 

		If @adcMtDifFraisAnx < 0 
		  Begin
			Return -1
		  End 

		Update @tb Set marquage = 1 Where id_typ_frais = @iCpt
		Set @iCpt = @iCpt + 1
	 End

	 Return 1

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_REG_FRAIS_ANNEXE_FRN
-- Auteur               :       JFF
-- Date                 :       16/09/2022
-- Libellé              :     // [PM80_FA12_FRANEX]   
-- Commentaires         :       
-- Références           :       
--
--
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_REG_FRAIS_ANNEXE_FRN' AND type = 'P' )
        DROP procedure sysadm.PS_S01_REG_FRAIS_ANNEXE_FRN
GO

CREATE procedure sysadm.PS_S01_REG_FRAIS_ANNEXE_FRN
        @adcIdSin        Decimal (  10,0 ), -- [PI062]
        @adcIdReg		Decimal ( 2 )
AS

Select	rfa.id_sin,
		rfa.id_reg,
		'(' + Convert ( varchar ( 10 ), rfa.id_i) + ') ' + RTRIM ( ltrim ( nom ) ) 'lib_inter',
		'(' + Convert ( varchar ( 10 ), rfa.id_gti) + ') ' + sysadm.FN_CODE_NUM ( rfa.id_gti,  '-GA') 'Lib_gti',
		IsNull ( '(' + Convert ( varchar ( 10 ), rfa.id_detail) + ') ' + sysadm.FN_CODE_NUM ( d.id_evt,  '+EV'), 'Aucun détail' ) 'Lib_Det_Gti',
		'(' + Convert ( varchar ( 10 ), rfa.typ_frais_anx) + ') ' + sysadm.FN_CODE_NUM ( rfa.typ_frais_anx,  '-W7') + Replicate ( '.', 100 ) 'Typ_frais_anx',
		rfa.mt_frais_anx 'Mt_Frais_anx'
from	sysadm.reg_frais_annexe_frn rfa
		left outer join sysadm.inter i on i.id_sin = rfa.id_sin and i.id_i = rfa.id_i
		left outer join sysadm.detail d on d.id_sin = rfa.id_sin and d.id_gti = rfa.id_gti and d.id_detail = rfa.id_detail
Where   rfa.id_sin = @adcIdSin
And     rfa.id_reg = @adcIdReg
Order by 6
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S02_REG_FRAIS_ANNEXE_FRN
-- Auteur               :       JFF
-- Date                 :       16/09/2022
-- Libellé              :     // [PM80_FA12_FRANEX]   
-- Commentaires         :       
-- Références           :       
--
--
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_REG_FRAIS_ANNEXE_FRN' AND type = 'P' )
        DROP procedure sysadm.PS_S02_REG_FRAIS_ANNEXE_FRN
GO

CREATE procedure sysadm.PS_S02_REG_FRAIS_ANNEXE_FRN
        @adcIdSin        Decimal (  10,0 ), -- [PI062]
        @adcIdReg		Decimal ( 2 )
AS

If Exists ( 
	Select	Top 1 1  
	From	sysadm.reglement r
	Where   r.id_sin = @adcIdSin
	And		r.id_reg = @adcIdReg
	And		r.cod_mode_reg = 'FM'
	And		r.cod_inter = 'F'
) 
Return 1

If Exists ( 
	Select	Top 1 1  
	From	sysadm.reglement r,
			sysadm.reglement r2
	Where   r.id_sin = @adcIdSin
	And		r.id_reg = @adcIdReg
	And     r2.id_sin = r.id_sin
	And     r2.id_reg = r.id_reg_base
	And		r2.cod_mode_reg = 'FM'
	And		r2.cod_inter = 'F'
) 
Return 1

Return 0

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S03_REG_FRAIS_ANNEXE_FRN
-- Auteur               :       JFF
-- Date                 :       16/09/2022
-- Libellé              :     // [PM80_FA12_FRANEX]   
-- Commentaires         :       
-- Références           :       
--
--
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S03_REG_FRAIS_ANNEXE_FRN' AND type = 'P' )
        DROP procedure sysadm.PS_S03_REG_FRAIS_ANNEXE_FRN
GO

CREATE procedure sysadm.PS_S03_REG_FRAIS_ANNEXE_FRN
        @adcIdSin        Decimal ( 10,0 ), -- [PI062]
        @adcIdReg		Decimal ( 2 ),
		@adtPivotMEP_PM80 DateTime OutPut
AS

Select Top 1 @adtPivotMEP_PM80 = dtp.dte_1
From sysadm.date_pivot dtp
Where dtp.id_cle = 'PM80_FA12_FRANEX'

If Exists ( 
	Select	Top 1 1  
	From	sysadm.reg_frais_annexe_frn rfa
	Where   rfa.id_sin = @adcIdSin
	And		rfa.id_reg = @adcIdReg
) 
Return 1

Return 0

Go


--------------------------------------------------------------------
--
-- Procédure            :       v_reg_frais_annexe_frn
-- Auteur               :       JFF
-- Date                 :       16/09/2022
-- Libellé              :     // [PM80_FA12_FRANEX]   
-- Commentaires         :       
-- Références           :       
--
--
-------------------------------------------------------------------
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'v_reg_frais_annexe_frn' AND type = 'V' )
        DROP view sysadm.v_reg_frais_annexe_frn
GO

CREATE view sysadm.v_reg_frais_annexe_frn
AS

Select	rfa.id_sin,
		rfa.id_reg,
		rfa.id_i id_inter,
		RTRIM ( ltrim ( nom ) ) 'lib_inter',
		rfa.id_gti,
		sysadm.FN_CODE_NUM ( rfa.id_gti,  '-GA') 'lib_gti',
		rfa.id_detail,
		IsNull ( d.id_evt, -1 ) id_evt,
		IsNull ( sysadm.FN_CODE_NUM ( d.id_evt,  '+EV'), 'Aucun détail' ) 'lib_evt_det_gti',
		rfa.typ_frais_anx,
		sysadm.FN_CODE_NUM ( rfa.typ_frais_anx,  '-W7') 'lib_typ_frais_anx',
		rfa.mt_frais_anx 'mt_Frais_anx',
		rfa.cree_le,
		rfa.maj_le,
		rfa.maj_par,
		rfa.valide_le,
		rfa.valide_par
from	sysadm.reg_frais_annexe_frn rfa
		left outer join sysadm.inter i on i.id_sin = rfa.id_sin and i.id_i = rfa.id_i
		left outer join sysadm.detail d on d.id_sin = rfa.id_sin and d.id_gti = rfa.id_gti and d.id_detail = rfa.id_detail
Go

