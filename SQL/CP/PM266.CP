-------------------------------------------------------------------
--
-- Fichier              :       PM266.CP
-- Auteur               :       FABRY JF
-- Date                 :       06/10/2014
--
-- Commentaires         :       PS affèrant au PM266
--
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_PM266_TRT_PERIODE_ASS
-- Auteur               :       FABRY JF
-- Date                 :       06/10/2014
-- Libellé              :        
-- Commentaires         :       [PM266]
-- Références           :       
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM266_TRT_PERIODE_ASS' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM266_TRT_PERIODE_ASS
GO

CREATE procedure sysadm.PS_I_PM266_TRT_PERIODE_ASS
	@adtDteDeb	 DateTime,
	@adtDteFin	 DateTime,
	@asCas		 VarChar ( 50 ), -- 'TRAITEMENT_PERIODE' ou 'RELECTURE_PERIODE'
	@aiIdPeriode  Integer,
	@adcIdCie	 Decimal ( 7),  -- soit id_cie ou null pour tout assureur
	@asFormatRet  VarChar ( 50 ), -- 'FICHIER_VOLCANES' ou 'DONNEES_EN_COLONNE'
	@asResult	 VarChar ( 100 ) OUTPUT
	
AS

Declare @wdtDteDeb VarChar ( 30 )
Declare @wdtDteFin VarChar ( 30 )
Declare @sSigne VarChar ( 1 )
Declare @sChaine VarChar ( 50 )
Declare @iLen  Integer
Declare @iContinue Integer
Declare @iRet Integer

Set @iContinue = 0

-- Variable de w_volcanes_ass
Declare @dcIdCle  Integer
Declare @dcIdSin  decimal(10)    -- [PI062]
Declare @dcIdI  decimal(7)   
Declare @dcIdReg  decimal(2)   
Declare @iCodMotReg  integer      
Declare @sCodProdDms  varchar ( 10 )      
Declare @dcIdEts  decimal(7)   
Declare @sIdAdh  varchar(19)  
Declare @dcIdsDos  decimal(2)   
Declare @dcIdCie  decimal(7)   
Declare @sLibPolice  varchar(35)  
Declare @sCodModeReg  varchar(2)   
Declare @sCodInter  varchar(1)   
Declare @sTypFour  varchar(3)   
Declare @dcMtReg  decimal(11,2)
Declare @sDteReg  varchar(8)   
Declare @dcCodRadical  decimal(7)   
Declare @dcIdProd  decimal(7)   

-- Variable de trace_volcanes_ass
Declare @ivCptTri  Integer
Declare @viIdPeriode  Integer
Declare @vdtDteDeb  DateTime
Declare @vdtDteFin  DateTime
Declare @vsDteDeb  VarChar ( 20 )
Declare @vsDteFin  VarChar ( 20 )
Declare @vsDteJour  VarChar ( 20 )
Declare @vdcIdCie  decimal(7)   
Declare @vsEnrTete  VarChar (200)
Declare @vsCodAppli  varchar (200)
Declare @vsIdSin  varchar (200)
Declare @vsIdI  varchar (200)
Declare @vsIdReg  varchar (200)
Declare @vsIdSeq  varchar (200)
Declare @vsIdEnreg  varchar (200)
Declare @vsIdProd  varchar (200)
Declare @vsIdEts  varchar (200)
Declare @vsIdAdh  varchar (200)
Declare @vsIdsDos  varchar (200)
Declare @vsIdCiev  varchar (200)
Declare @vsCodContrat  varchar (200)
Declare @vsCodReg  varchar (200)
Declare @vsCodDest  varchar (200)
Declare @vsMtSin  varchar (200)
Declare @vsDteReg  varchar (200)
Declare @vsRadical  varchar (200)
Declare @vsIdPdr  varchar (200)
Declare @vsFiller  varchar (200)
Declare @vsIdFour  varchar (200)
Declare @vsIdProdSIn  varchar (200)

If @asCas not in ( 'TRAITEMENT_PERIODE', 'RELECTURE_PERIODE' )
  Begin
	Set @asResult = 'Cas de traitement non reconnu'
	Return -7
  End 
  
If @asFormatRet not in ( 'FICHIER_VOLCANES' , 'DONNEES_EN_COLONNE'   )
  Begin
	Set @asResult = 'Format non reconnu'
	Return -8
  End 

 
If @asCas = 'TRAITEMENT_PERIODE'
  Begin

	Delete From sysadm.w_volcanes_ass

	If DataLength ( Convert ( VarChar (20), @aiIdPeriode ) ) <> 8 
	  Begin
			Set @asResult = 'Période non valide'
			Return -4
	  End 

	If Exists ( 
			Select 1
			From	sysadm.trace_volcanes_ass 
			Where   id_periode = @aiIdPeriode 
			And		( id_cie = @adcIdCie or @adcIdCie is null )
		) 
		Begin
			Set @asResult = 'Ce traitement a déjà été lancé'
			Return -1
		End 

	Set @wdtDteDeb = Convert ( VarChar ( 10), @adtDteDeb, 103) + ' ' + '00:00'
	Set @wdtDteFin = Convert ( VarChar ( 10), @adtDteFin, 103)  + ' ' + '23:59'

	If ISDATE ( @wdtDteDeb ) = 0 
		Begin
			If @wdtDteDeb is null Set @wdtDteDeb = ''
			Set @asResult = 'Date de début non valide ' + @wdtDteDeb 
			Return -2
		End 


	If ISDATE ( @wdtDteFin ) = 0 
		Begin
			If @wdtDteFin is null Set @wdtDteFin = ''
			Set @asResult = 'Date de fin non valide ' + @wdtDteFin 
			Return -3
		End 

	If @adcIdCie is not null
	  Begin
		If Not Exists ( 
				Select 1
				From	sysadm.exclu_ass ex
				Where   ex.id_cie = @adcIdCie
			)
			Begin
				Set @asResult = 'Cette assureur n''est pas éligible à ce traitement' + @wdtDteFin 
				Return -5
			End 
			
	  End 

	-- Insertion donnée brut volcanes dans table tempo de travail	  
	Insert into sysadm.w_volcanes_ass  (
								id_sin,
								id_i,
								id_reg,
								cod_mot_reg,
								cod_prod_dms,
								id_ets,
								id_adh,
								id_sdos,
								id_cie,
								lib_police,
								cod_mode_reg,
								cod_inter,
								typ_four,
								mt_reg,
								dte_reg,
								cod_radical,
								id_prod	)
	Exec sysadm.PS_S01_VOLCANE @wdtDteDeb, @wdtDteFin, 'INCLU_ASSUREUR'

	Update sysadm.w_volcanes_ass Set cree_le = GETDATE(), marquage = 0

	Update sysadm.w_volcanes_ass 
	Set    marquage = 1
	From   sysadm.w_volcanes_ass wa
	Where  ( @adcIdCie is null
			 And 	
			 Not Exists (
					Select 1
					From sysadm.exclu_ass ex
					Where ex.id_cie = wa.id_cie
				)
		   )
		   
	Or	   ( @adcIdCie is not null 
			 And wa.id_cie <> @adcIdCie )


	-- Traitement
	While Exists ( Select * From sysadm.w_volcanes_ass where marquage = 0 )
	 Begin
		Select 	Top 1 
			@dcIdCle = wv.id_cle,  
			@dcIdSin = wv.id_sin,
			@dcIdI = wv.id_i,
			@dcIdReg = wv.id_reg,
			@iCodMotReg = wv.cod_mot_reg,
			@sCodProdDms = wv.cod_prod_dms,
			@dcIdEts = wv.id_ets,
			@sIdAdh= ltrim ( rtrim ( wv.id_adh )),
			@dcIdsDos = wv.id_sdos,
			@dcIdCie = wv.id_cie,
			@sLibPolice = ltrim ( rtrim ( wv.lib_police)),
			@sCodModeReg = ltrim ( rtrim ( wv.cod_mode_reg)),
			@sCodInter = ltrim ( rtrim (wv.cod_inter)),
			@sTypFour = ltrim ( rtrim (wv.typ_four)),
			@dcMtReg = wv.mt_reg,
			@sDteReg = ltrim ( rtrim (wv.dte_reg)),
			@dcCodRadical = wv.cod_radical,
			@dcIdProd = wv.id_prod
		From	w_volcanes_ass wv,
				sysadm.exclu_ass ex
		Where	wv.marquage = 0
		And		wv.id_cie = ex.id_cie


		-- Set @vsDteDeb  
		Set @vsDteDeb = convert ( varchar(10), Convert ( DateTime, @wdtDteDeb) , 112 ) 

		-- Set @vsDteFin  
		Set @vsDteFin = convert ( varchar(10), Convert ( DateTime,@wdtDteFin) , 112 ) 
		
		-- Set @vsDteJour
		Set @vsDteJour = convert ( varchar(10), GETDATE(), 112 ) 	

		-- @ivCptTri 
		Set @ivCptTri = @dcIdCle

		-- @viIdPeriode
		Set @viIdPeriode = @aiIdPeriode
		
		-- @vdtDteDeb
		Set @vdtDteDeb = @adtDteDeb

		-- @vdtDteFin
		Set @vdtDteFin = @adtDteFin
		
		-- @vdcIdCie
		Set @vdcIdCie = @dcIdCie

		-- @vsCodAppli
		Set @vsCodAppli = 'BSP2'

		-- @vsEnrTete  
		Set @vsEnrTete = @vsCodAppli + SPACE (97) + @vsDteDeb + @vsDteFin + @vsDteJour

		-- @vsIdSin
		Set @vsIdSin = Right ( REPLICATE ( '0', 10 ) + CONVERT ( Varchar ( 10 ), @dcIdSin ), 10 )  -- [PI062]

		-- @vsIdI
		Set @vsIdI = Right ( REPLICATE ( '0', 2 ) + CONVERT ( Varchar ( 10 ), @dcIdI ), 2 ) 
			
		-- @vsIdReg
		Set @vsIdReg = Right ( REPLICATE ( '0', 2 ) + CONVERT ( Varchar ( 10 ), @dcIdReg ), 2 ) 
		
		-- @vsIdSeq
		Set @vsIdSeq = '0001'
		
		-- @vsIdEnreg = @iCodMotReg
		Set @vsIdEnreg = CONVERT ( Varchar ( 1 ), @iCodMotReg )
		
		-- @vsIdProd
		Set @vsIdProd = @sCodProdDms
		
		-- @vsIdEts
		Set @vsIdEts = Right ( REPLICATE ( '0', 5 ) + CONVERT ( Varchar ( 10 ), @dcIdEts ), 5 ) 
		
		-- @vsIdAdh
		Set @vsIdAdh = Right ( REPLICATE ( '0', 19 ) + @sIdAdh , 19 ) 
			
		-- @vsIdsDos
		Set @vsIdsDos = CONVERT ( Varchar ( 3 ), @dcIdsDos )
		
		-- @vsIdCiev
		Set @vsIdCiev = Right ( REPLICATE ( '0', 3 ) + CONVERT ( Varchar ( 10 ), @dcIdCie ), 3 ) 
		
		-- @vsCodContrat
		Set @vsCodContrat = Left ( @sLibPolice + SPACE ( 60 ), 60 )
			
		-- @vsCodReg
		Set @vsCodReg = Left ( @sCodModeReg + SPACE ( 2 ), 2 )
		
		-- @vsCodDest
		Set @vsCodDest = @sCodInter

		-- @vsDteReg
		Set @vsDteReg = @sDteReg
		
		-- @vsRadical
		Set @vsRadical = Right ( REPLICATE ( '0', 3 ) + CONVERT ( Varchar ( 10 ), @dcCodRadical ), 3 ) 
		If @vsRadical is null Or RTRIM ( @vsRadical ) = ''
		  Begin
			Set @vsRadical = '000'
		  End 
		
		-- @vsMtSin
		If @vsIdEnreg = '4' And @dcMtReg < 0 
		  Begin
			  -- @vsIdSeq
			  Set @vsIdSeq = '0002'
		  End
		Else
		  Begin
			  -- @vsIdSeq
			  Set @vsIdSeq = '0001'
		  End
		
		If @dcMtReg >= 0 
		  Begin
			Set @sSigne = '0'
		  End  
		Else
		  Begin
			Set @sSigne = '-'	  
			Set @dcMtReg = @dcMtReg * (-1)
		  End 
		
		Set @vsMtSin = @sSigne + Right( REPLICATE ( '0' , 12 ) + Replace ( CONVERT ( varchar ( 12 ), @dcMtReg * 100 ), '.00', '') , 12 )
		
		-- @vsIdPdr
		Set @vsIdPdr = '001'

		-- @vsIdFour
		Set @vsIdFour = @sTypFour
		If @vsIdFour is null Or LEN ( @vsIdFour ) <> 3 Or @vsIdFour = '-1'
		  Begin
			Set @vsIdFour = SPACE (3)
		  End

		-- @vsIdProdSIn
		Set @vsIdProdSIn = Right ( REPLICATE ( '0', 5 ) + CONVERT ( Varchar ( 10 ), @dcIdProd ), 5 ) 
		
		-- @vsFiller
		Set @vsFiller = SPACE ( 24 )
		
			-- Franchise Auchan
			If @vsIdEnreg = '2' 
			  Begin
				Set @sChaine = SPACE ( 5 )
				Exec sysadm.PS_S_RMFR @dcIdSin, @dcIdReg, @sChaine OUTPUT
				
				If @sChaine is null Or rtrim ( @sChaine ) = ''
				  Begin
					Set @sChaine = SPACE ( 5 )
				  End 
				
				Set @vsFiller = @sChaine + Right ( @vsFiller, DATALENGTH ( @vsFiller ) - 5  )
				
			  End 

			-- Orange v3 caution, // "2" = RM, "3" = RP  Caution Orange V3
			If @vsFiller = SPACE ( 24 ) And @vsIdEnreg in ( 2, 3 )
			  Begin
				Set @sChaine = SPACE ( 50 )
				Exec sysadm.PS_S_RMRP_CAUTION @dcIdSin, @dcIdReg, @vsIdEnreg, @sChaine OUTPUT

				If @sChaine is null Or rtrim ( @sChaine ) = ''
				  Begin
					Set @sChaine = ''
				  End 
				
				Set @vsFiller = Left ( @sChaine + SPACE (24), 24 )
				
			  End 

			-- Orange v3 caution, // "1" = RNM Frais spéciaux Orange v3
			If @vsFiller = SPACE ( 24 ) And @vsIdEnreg in ( 1 )
			  Begin
				Set @sChaine = SPACE ( 50 )
				Exec sysadm.PS_S_RN_FRAIS_SPECIAUX @dcIdSin, @dcIdReg, @vsIdEnreg, @sChaine OUTPUT

				If @sChaine is null Or rtrim ( @sChaine ) = ''
				  Begin
					Set @sChaine = ''
				  End 
				
				Set @vsFiller = Left ( @sChaine + SPACE (24), 24 )
				
			  End 

			-- [DT044-1_V5]
			If @vsFiller = SPACE ( 24 ) 
			  Begin
				Set @sChaine = SPACE ( 50 )
				Exec sysadm.PS_S_RN_FM_SPECIAUX_SANS_RAPPROCHEMENT @dcIdSin, @dcIdReg, @vsIdEnreg, @vsCodReg, @sChaine OUTPUT

				If @sChaine is null Or rtrim ( @sChaine ) = ''
				  Begin
					Set @sChaine = ''
				  End 
				
				Set @vsFiller = Left ( @sChaine + SPACE (24), 24 )
				
			  End 
			  
		-- Prépar enreg Volcanes
		
		Insert into sysadm.trace_volcanes_ass
			(
				cpt_tri,
				id_periode,
				dte_deb,
				dte_fin,
				id_cie,
				enr_tete,
				cod_appli,
				id_sin,
				id_i,
				id_reg,
				id_seq,
				id_enreg,
				id_prod,
				id_ets,
				id_adh,
				No_sDoss,
				id_ciev,
				cod_contrat,
				cod_reg,
				cod_dest,
				mt_sin,
				dte_reg,
				radical,
				id_pdr,
				filler,
				id_four,
				id_prod_sin,
				cree_le,
				maj_le,
				maj_par
			)	
		Values 
			(
				@ivCptTri,
				@viIdPeriode,
				@vdtDteDeb,
				@vdtDteFin,
				@vdcIdCie,
				@vsEnrTete,
				@vsCodAppli,
				@vsIdSin,
				@vsIdI,
				@vsIdReg,
				@vsIdSeq,
				@vsIdEnreg,
				@vsIdProd,
				@vsIdEts,
				@vsIdAdh,
				@vsIdsDos,
				@vsIdCiev,
				@vsCodContrat,
				@vsCodReg,
				@vsCodDest,
				@vsMtSin,
				@vsDteReg,
				@vsRadical,
				@vsIdPdr,
				@vsFiller,
				@vsIdFour,
				@vsIdProdSIn,
				GETDATE (),
				GETDATE (),
				'AUTO'
			)
			  
		-- Marquage enrg traité
		Update sysadm.w_volcanes_ass Set marquage = 1 Where id_cle = @dcIdCle 
	 End

	-- Traitement StatSin2
	Exec @iRet = sysadm.PS_I_PM266_TRT_STAT_SIN2 @wdtDteDeb, @wdtDteFin, @aiIdPeriode, @adcIdCie, @asResult OUTPUT
	If @iRet < 0 
	  Begin
		Return @iRet -- le Result est déjà renseginé par Ref.
	  End 
	

	Set @iContinue = 1
	Set @asResult = 'Traitement période ' + CONVERT ( VarChar (30), @aiIdPeriode) + ' terminé avec succès'
	 
  End 
  

  
  -- Fin 'TRAITEMENT_PERIODE'
  
If @asCas = 'RELECTURE_PERIODE' Or @iContinue = 1
  Begin
	
	-- Retour pour Quentin au format fichier Volcanes
 	If @asFormatRet =  'FICHIER_VOLCANES' 
 	  Begin
		Select Top 1 enr_tete
		From   sysadm.trace_volcanes_ass
		Where  id_periode = @aiIdPeriode  
		Union All
		Select 		cod_appli+
					id_sin+
					id_i+
					id_reg+
					id_seq +
					id_enreg+
					id_prod +
					id_ets+
					id_adh+
					No_sDoss+
					id_ciev+
					cod_contrat +
					cod_reg+
					cod_dest+
					mt_sin+
					dte_reg+
					radical+
					id_pdr+
					filler+
					id_four+
					id_prod_sin 
		From   sysadm.trace_volcanes_ass
		Where  id_periode = @aiIdPeriode
		Order by 1
 	  End

 	If @asFormatRet =  'DONNEES_EN_COLONNE'
 	  Begin
		Select 		enr_tete,
					cod_appli,
					id_sin,
					id_i,
					id_reg,
					id_seq,
					id_enreg,
					id_prod,
					id_ets,
					id_adh,
					No_sDoss,
					id_ciev,
					cod_contrat,
					cod_reg,
					cod_dest,
					mt_sin,
					dte_reg,
					radical,
					id_pdr,
					filler,
					id_four,
					id_prod_sin 
		From   sysadm.trace_volcanes_ass
		Where  id_periode = @aiIdPeriode
		Order by 1
	  End
	  If @asCas = 'RELECTURE_PERIODE'
	    Begin
			Set @asResult = 'Relecture période ' + CONVERT ( VarChar (30), @aiIdPeriode) + ' terminé avec succès'
		End 
  End  

Return 0
  
Go

grant execute on sysadm.PS_I_PM266_TRT_PERIODE_ASS to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_I_PM266_TRT_STAT_SIN2
-- Auteur               :       FABRY JF
-- Date                 :       06/10/2014
-- Libellé              :        
-- Commentaires         :       [PM266]
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM266_TRT_STAT_SIN2' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM266_TRT_STAT_SIN2
GO

CREATE procedure sysadm.PS_I_PM266_TRT_STAT_SIN2
	@adtDteDeb	 DateTime,
	@adtDteFin	 DateTime,
	@aiIdPeriode  Integer,
	@adcIdCie	 Decimal (7),
	@asResult	 VarChar ( 100 ) OUTPUT
	
AS

Insert into sysadm.stat_sin2
Select  g.id_sin,
		@aiIdPeriode,
		g.id_gti,
		Case 
			When Exists ( 
					Select 1
					From	sysadm.detail d
					Where   d.id_sin = g.id_sin
					And		d.id_gti = g.id_gti
					And     d.id_gti = 7
					And		d.id_evt between 700 and 719
				)
				Then 1
			When Exists ( 
					Select 1
					From	sysadm.detail d
					Where   d.id_sin = g.id_sin
					And		d.id_gti = g.id_gti
					And     d.id_gti = 7					
					And		d.id_evt between 720 and 739
				)
				Then 2
			When Exists ( 
					Select 1
					From	sysadm.detail d
					Where   d.id_sin = g.id_sin
					And		d.id_gti = g.id_gti
					And     d.id_gti = 7					
					And		d.id_evt between 740 and 759
				)
				Then 3
			Else g.id_gti
		End id_rgpt,
		g.cod_etat,
		1 cpt_etat,
		Case 
			When g.cree_le between @adtDteDeb and @adtDteFin Then 1
			Else 0
		End cpt_ouv,
		Case 
			When Exists ( 
					Select 1
					From	sysadm.reg_gti rg
					Where   rg.id_sin = g.id_sin
					And		rg.id_gti = g.id_gti
					And		rg.cree_le between @adtDteDeb and @adtDteFin
				 ) Then 1
			Else 0
		End cpt_reg,
		g.mt_plaf_reg mt_reg,
		g.mt_prov,
		GETDATE(),
		GETDATE(),
		'AUTO' 
From	sysadm.sinistre s,
		sysadm.gar_sin g,
		sysadm.garantie ga,
		sysadm.police po
Where   s.id_sin = g.id_sin
And		ga.id_prod = s.id_prod
And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
								IsNull ( 
									( Select max (id_rev )
									  From   revision r
									  Where  r.id_prod = s.id_prod ) , 0 ))
And		ga.id_gti = IsNull ( nullif ( g.id_gti, -1 ),
								(
								  Select top 1 id_gti  
								  From   sysadm.garantie ga2
								  Where  ga2.id_prod = ga.id_prod
								  And    ga2.id_rev = ga.id_rev 
								)
							)

And		po.id_police = ga.id_police
And		( po.id_cie = @adcIdCie or @adcIdCie is null )
And		g.valide_le between @adtDteDeb and @adtDteFin

If @@ERROR <> 0
  Begin
	Set @asResult = 'Problème sur traitement stat_sin2'
	Return -6
  End 

Return 0

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S11_DCCTA_PM266
-- Auteur               :       FABRY JF
-- Date                 :       06/10/2014
-- Libellé              :        
-- Commentaires         :       [PM266]
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S11_DCCTA_PM266' AND type = 'P' )
        DROP procedure sysadm.PS_S11_DCCTA_PM266
GO

CREATE procedure sysadm.PS_S11_DCCTA_PM266
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

--
--

 SELECT distinct
	@dtDteDeb 'dte_deb',
	@dtDteFin 'dte_fin',
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
        Sum ( reg_gti.mt_reg ), 
	produit.lib_long,
	garantie.cod_radical
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit,
        sysadm.garantie,
        sysadm.reg_gti,
		sysadm.departement,
		sysadm.police,
		sysadm.exclu_ass
 WHERE  ( sinistre.id_sin    = reglement.id_sin   ) 					and 
        ( sinistre.id_prod   = produit.id_prod    )     				and 
        ( garantie.id_prod   = sinistre.id_prod   ) 					and
        ( garantie.id_rev    = sinistre.id_rev    ) 					and
        ( garantie.id_gti    = ( Case  reg_gti.id_gti     
		  	         When  -1 Then
					IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
						   From   sysadm.reg_gti a_reg_gti
						   Where  a_reg_gti.id_sin = reg_gti.id_sin
						   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			         ( Select max ( gar_sin.id_gti ) 
						   From   sysadm.gar_sin
						   Where  sysadm.gar_sin.id_sin = sinistre.id_sin ) ) 
	    			 Else  reg_gti.id_gti 
				 End	) )						and
        ( reglement.id_sin   = reg_gti.id_sin      ) 					and
        ( reglement.id_reg   = reg_gti.id_reg      ) 					and 
	( produit.id_dept    = departement.id_dept )					and
        ( reglement.dte_reg between @dtDteDeb  and @dtDteFin  ) 			and 
        ( reglement.cod_mot_reg in ( 'RN', 'RE', 'RM', 'RP' ) )				and
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 			and
		( police.id_police = garantie.id_police ) And  -- [PM266]
		( exclu_ass.id_cie = police.id_cie ) -- [PM266]

	-- Et appartenant au Compte dédié AIG
	/* -- [PM266]
	( produit.rib_bq	= '30002'					)  and  
	( produit.rib_gui	= '06522'					)  and 
	( produit.rib_cpt	= '0000061704E'					)  and 
	( produit.rib_cle	= '94'						)  
	*/

 GROUP BY
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
	produit.lib_long,
	garantie.cod_radical
UNION ALL
 SELECT distinct 
	@dtDteDeb 'dte_deb',
	@dtDteFin 'dte_fin',
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
        Sum ( reg_gti.mt_reg ), 
	produit.lib_long,
	garantie.cod_radical
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit,
        sysadm.garantie,
        sysadm.reg_gti,
		sysadm.departement,
		sysadm.police,
		sysadm.exclu_ass	
 WHERE  ( sinistre.id_sin    = reglement.id_sin   ) 					and 
        ( sinistre.id_prod   = produit.id_prod    )     				and 
        ( garantie.id_prod   = sinistre.id_prod   ) 					and
        ( garantie.id_rev    = sinistre.id_rev    ) 					and
        ( garantie.id_gti    = ( Case  reg_gti.id_gti     
		  	         When  -1 Then
					IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
						   From   sysadm.reg_gti a_reg_gti
						   Where  a_reg_gti.id_sin = reg_gti.id_sin
						   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			         ( Select max ( gar_sin.id_gti ) 
						   From   sysadm.gar_sin
						   Where  sysadm.gar_sin.id_sin = sinistre.id_sin ) ) 
	    			 Else  reg_gti.id_gti 
				 End	) )						and
        ( reglement.id_sin   	  = reg_gti.id_sin      ) 				and
        ( reglement.id_reg_base   = reg_gti.id_reg      ) 				and 
	( produit.id_dept    = departement.id_dept )					and
        ( reglement.dte_reg between @dtDteDeb  and @dtDteFin  ) 			and 
        ( reglement.cod_mot_reg = 'RI'             ) 					and
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 			and        
		( police.id_police = garantie.id_police ) And  -- [PM266]
		( exclu_ass.id_cie = police.id_cie ) -- [PM266]

	-- Et appartenant au Compte dédié AIG
	/* -- [PM266]	
	( produit.rib_bq	= '30002'					)  and  
	( produit.rib_gui	= '06522'					)  and 
	( produit.rib_cpt	= '0000061704E'					)  and 
	( produit.rib_cle	= '94'						)  
	*/
	
 GROUP BY
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
	produit.lib_long,
	garantie.cod_radical
UNION ALL
 SELECT distinct 
	@dtDteDeb 'dte_deb',
	@dtDteFin 'dte_fin',
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
        Sum ( reg_gti.mt_reg ) * -1,
	produit.lib_long,
	garantie.cod_radical
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit,
        sysadm.garantie,
        sysadm.reg_gti,
		sysadm.departement,
		sysadm.police,
		sysadm.exclu_ass
 WHERE  ( sinistre.id_sin    = reglement.id_sin   ) 					and 
        ( sinistre.id_prod   = produit.id_prod    )     				and 
        ( garantie.id_prod   = sinistre.id_prod   ) 					and
        ( garantie.id_rev    = sinistre.id_rev    ) 					and
        ( garantie.id_gti    = ( Case  reg_gti.id_gti     
		  	         When  -1 Then
					IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
						   From   sysadm.reg_gti a_reg_gti
						   Where  a_reg_gti.id_sin = reg_gti.id_sin
						   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			         ( Select max ( gar_sin.id_gti ) 
						   From   sysadm.gar_sin
						   Where  sysadm.gar_sin.id_sin = sinistre.id_sin ) ) 
	    			 Else  reg_gti.id_gti 
				 End	) )						and
        ( reglement.id_sin   	  = reg_gti.id_sin      ) 				and
        ( reglement.id_reg_base   = reg_gti.id_reg      ) 				and 
	( produit.id_dept    = departement.id_dept )					and
        ( reglement.dte_reg between @dtDteDeb  and @dtDteFin  ) 			and 
        ( reglement.cod_mot_reg = 'RI'             ) 					and
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 			and	        
		( police.id_police = garantie.id_police ) And  -- [PM266]
		( exclu_ass.id_cie = police.id_cie ) -- [PM266

	-- Et appartenant au Compte dédié AIG
	/* -- [PM266]
	( produit.rib_bq	= '30002'					)  and  
	( produit.rib_gui	= '06522'					)  and 
	( produit.rib_cpt	= '0000061704E'					)  and 
	( produit.rib_cle	= '94'						)  
	*/

 GROUP BY
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
	produit.lib_long,
	garantie.cod_radical
	
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_STAT_LSTCPTA_PM266
-- Auteur               :       FABRY JF
-- Date                 :       06/10/2014
-- Libellé              :        
-- Commentaires         :       [PM266]
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_STAT_LSTCPTA_PM266' AND type = 'P' )
        DROP procedure sysadm.DW_S01_STAT_LSTCPTA_PM266
GO

CREATE procedure sysadm.DW_S01_STAT_LSTCPTA_PM266
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

--
-- Il faut faire un union car pour les produits avec cod_adh = '3', le lib_grp est obtenu
-- directement … partir de la table groupe et pour les produits avec les autres cod_adh, il
-- faut passer par la table etablissement
--

 SELECT @dtDteDeb 'dte_deb',
		@dtDteFin 'dte_fin',
	    ( 
		 Select tv.id_periode
		 From sysadm.trace_volcanes_ass tv
		 Where tv.id_sin = reglement.id_sin
		 And   Convert ( Decimal, tv.id_reg ) = reglement.id_reg
	    ) 'Periode_de_règlement',
		reglement.dte_reg, 
        sinistre.id_prod, 
        sinistre.id_ets, 
        produit.rib_bq + ' ' + produit.rib_gui + ' ' + produit.rib_cpt + ' ' + produit.rib_cle, 
        departement.lib_dept, 
        personne.nom,
        personne.prenom,
        groupe.lib_grp,
        sinistre.id_sin,
        reglement.mt_tot_reg, 
        reglement.id_reg, 
        reglement.cod_mode_reg,
        reglement.cod_inter, 
        reglement.cod_mot_reg 
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit, 
        sysadm.departement,
        sysadm.groupe,
        sysadm.personne 
 WHERE  ( sinistre.id_sin        = reglement.id_sin        ) and 
        ( sinistre.id_prod       = produit.id_prod         ) and 
        ( departement.id_dept    = produit.id_dept         ) and 
        ( sinistre.id_ets        = groupe.id_grp           ) and
        ( sinistre.id_ordre      = personne.id_ordre       ) and
        ( produit.cod_adh        = '3'                    ) and
        ( reglement.cod_mot_reg in ( 'RN', 'RE', 'RI', 'RP', 'RM' ) ) and 
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and
        ( reglement.dte_reg      between @dtDteDeb and @dtDteFin        ) And 
        Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
        )
        
 UNION ALL
 SELECT @dtDteDeb 'dte_deb',
		@dtDteFin 'dte_fin',
	    ( 
		 Select tv.id_periode
		 From sysadm.trace_volcanes_ass tv
		 Where tv.id_sin = reglement.id_sin
		 And   Convert ( Decimal, tv.id_reg ) = reglement.id_reg
	    ) 'Periode_de_règlement',
        reglement.dte_reg, 
        sinistre.id_prod, 
        sinistre.id_ets, 
        produit.rib_bq + ' ' + produit.rib_gui + ' ' + produit.rib_cpt + ' ' + produit.rib_cle, 
        departement.lib_dept, 
        personne.nom,
        personne.prenom,
        groupe.lib_grp,
        sinistre.id_sin,
        reglement.mt_tot_reg, 
        reglement.id_reg, 
        reglement.cod_mode_reg,
        reglement.cod_inter, 
        reglement.cod_mot_reg 
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit, 
        sysadm.departement,
        sysadm.groupe,
        sysadm.personne,
        sysadm.etablissement 
 WHERE  ( sinistre.id_sin        = reglement.id_sin        ) and 
        ( sinistre.id_prod       = produit.id_prod         ) and 
        ( departement.id_dept    = produit.id_dept         ) and 
        ( sinistre.id_ordre      = personne.id_ordre       ) and
	( etablissement.id_prod  = sinistre.id_prod        ) and
	( etablissement.id_ets   = sinistre.id_ets         ) and
	( etablissement.id_grp   = groupe.id_grp           ) and
	( etablissement.id_rev   = -1			   ) and
        ( produit.cod_adh        <> '3'                    ) and
        ( reglement.cod_mot_reg in ( 'RN', 'RE', 'RI', 'RP', 'RM' ) ) and 
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and
        ( reglement.dte_reg      between @dtDteDeb and @dtDteFin        ) and
        Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
        )
        
UNION ALL
 SELECT @dtDteDeb 'dte_deb',
		@dtDteFin 'dte_fin',
	    ( 
		 Select tv.id_periode
		 From sysadm.trace_volcanes_ass tv
		 Where tv.id_sin = reglement.id_sin
		 And   Convert ( Decimal, tv.id_reg ) = reglement.id_reg
	    ) 'Periode_de_règlement',
		reglement.dte_reg, 
        sinistre.id_prod, 
        sinistre.id_ets, 
        produit.rib_bq + ' ' + produit.rib_gui + ' ' + produit.rib_cpt + ' ' + produit.rib_cle, 
        departement.lib_dept, 
        personne.nom,
        personne.prenom,
        groupe.lib_grp,
        sinistre.id_sin,
        reglement.mt_tot_reg * -1, 
        reglement.id_reg, 
        reglement.cod_mode_reg,
        reglement.cod_inter, 
        reglement.cod_mot_reg 
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit, 
        sysadm.departement,
        sysadm.groupe,
        sysadm.personne 
 WHERE  ( sinistre.id_sin        = reglement.id_sin        ) and 
        ( sinistre.id_prod       = produit.id_prod         ) and 
        ( departement.id_dept    = produit.id_dept         ) and 
        ( sinistre.id_ets        = groupe.id_grp           ) and
        ( sinistre.id_ordre      = personne.id_ordre       ) and
        ( produit.cod_adh        = '3'                     ) and
        ( reglement.cod_mot_reg  = 'RI'  		   ) and 
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and
        ( reglement.dte_reg      between @dtDteDeb and @dtDteFin        )  And
        Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
        )
       
        
 UNION ALL
 SELECT @dtDteDeb 'dte_deb',
		@dtDteFin 'dte_fin',
	    ( 
		 Select tv.id_periode
		 From sysadm.trace_volcanes_ass tv
		 Where tv.id_sin = reglement.id_sin
		 And   Convert ( Decimal, tv.id_reg ) = reglement.id_reg
	    ) 'Periode_de_règlement',
		reglement.dte_reg, 
        sinistre.id_prod, 
        sinistre.id_ets, 
        produit.rib_bq + ' ' + produit.rib_gui + ' ' + produit.rib_cpt + ' ' + produit.rib_cle, 
        departement.lib_dept, 
        personne.nom,
        personne.prenom,
        groupe.lib_grp,
        sinistre.id_sin,
        reglement.mt_tot_reg * -1, 
        reglement.id_reg, 
        reglement.cod_mode_reg,
        reglement.cod_inter, 
        reglement.cod_mot_reg 
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit, 
        sysadm.departement,
        sysadm.groupe,
        sysadm.personne,
        sysadm.etablissement 
 WHERE  ( sinistre.id_sin        = reglement.id_sin        ) and 
        ( sinistre.id_prod       = produit.id_prod         ) and 
        ( departement.id_dept    = produit.id_dept         ) and 
        ( sinistre.id_ordre      = personne.id_ordre       ) and
	( etablissement.id_prod  = sinistre.id_prod        ) and
	( etablissement.id_ets   = sinistre.id_ets         ) and
	( etablissement.id_grp   = groupe.id_grp           ) and
	( etablissement.id_rev   = -1			   ) and
        ( produit.cod_adh        <> '3'                    ) and
        ( reglement.cod_mot_reg  = 'RI'  		   ) and 
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and
        ( reglement.dte_reg      between @dtDteDeb and @dtDteFin        ) And
        Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
        )
       

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM266_ETAT_DCP_1
-- Auteur               :       FABRY JF
-- Date                 :       06/10/2014
-- Libellé              :        
-- Commentaires         :       [PM266]
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM266_ETAT_DCP_1' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM266_ETAT_DCP_1
GO

CREATE procedure sysadm.PS_S_PM266_ETAT_DCP_1
	@adtDteDeb	 DateTime,
	@adtDteFin	 DateTime
AS

Select r.id_sin 'Reference_sinistre',
	   r.id_reg 'Numéro_Reglement',
	   s.cod_opt 'Option' ,
	   IsNull ( 
		   ( 
			Select SUM ( mt_tot_prej )
			From	sysadm.gar_sin gs
			Where   gs.id_sin = s.id_sin
		   ) 
		 ,0 )  'Montant_prej_sinistre',
	   IsNull ( 
		   ( Select MAX ( d.mt_val_achat )
			 From sysadm.detail d
			 Where d.id_sin = r.id_sin
			 And   d.id_reg = r.id_reg )
		, 0 ) 'Mt_Val_Achat',
	   r.mt_tot_reg 'Montant règlement',
	   sysadm.FN_AFF_DATE ( r.dte_reg, 'SANS_HEURE' ) 'Date_Reglement',
	   sysadm.FN_AFF_DATE ( s.dte_adh, 'SANS_HEURE' ) 'Date_Adhésion',
	   sysadm.FN_AFF_DATE ( s.dte_decl, 'SANS_HEURE' ) 'Date_Declaration',	   
	   sysadm.FN_AFF_DATE ( s.dte_surv, 'SANS_HEURE' ) 'Date_Survenance',	   	   
	   YEAR ( s.dte_surv ) 'Annee_Survenance',
	   ( 
		 Select tv.id_periode
		 From sysadm.trace_volcanes_ass tv
		 Where tv.id_sin = r.id_sin
		 And   Convert ( Decimal, tv.id_reg ) = r.id_reg
	   ) 'Periode_de_règlement',
	   ( Select IsNull ( rtrim( nom) , '') + ' ' + IsNull ( rtrim( prenom), '') from sysadm.personne pe where pe.id_ordre = s.id_ordre ) 'Nom_sinistre',
	   '(' + r.cod_mot_reg + ') ' + sysadm.FN_CODE_CAR ( r.cod_mot_reg, '-MO' ) 'Motif_Reglement' ,
	   ( 
		 Select COUNT(*)
		 From	sysadm.reglement r2
		 Where  r2.id_sin = r.id_sin
		 And    r2.cod_mot_reg = 'RN'
	   ) 'Nombre_Reglement',
	   '(' + Convert ( VarChar ( 5), rg.id_gti ) + ') ' + sysadm.FN_CODE_NUM ( rg.id_gti, '-GA') 'Garantie' ,
	   sysadm.FN_CODE_NUM ( s.id_natsin, '+NS') 'Nature_de_sinistre' ,
	   po.lib_police ,
	   cie.lib_cie ,
	   s.id_adh 'Référence_Adhésion' ,
	   ( 
		Select sysadm.FN_CODE_CAR ( i.id_four, '-FR' )
		From   sysadm.inter i
		Where  i.id_sin = s.id_sin
		And    i.id_i = r.id_i
	   ) 'Fournisseur_Réglé'

From	sysadm.reglement r,
		sysadm.reg_gti rg,
		sysadm.exclu_ass ex,
		sysadm.sinistre s,
		sysadm.garantie ga,
		sysadm.police po,		
		sysadm.compagnie cie

Where   r.dte_reg between @adtDteDeb and @adtDteFin
and		s.id_sin = r.id_sin
And		rg.id_sin = r.id_sin
And     rg.id_reg = r.id_reg
And		ga.id_prod = s.id_prod
And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
								IsNull ( 
									( Select max (id_rev )
									  From   revision r
									  Where  r.id_prod = s.id_prod ) , 0 )
							)
And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
								(
								  Select top 1 id_gti  
								  From   sysadm.garantie ga2
								  Where  ga2.id_prod = ga.id_prod
								  And    ga2.id_rev = ga.id_rev 
								)
							)
And		po.id_police = ga.id_police
and		ex.id_cie = po.id_cie			
And     cie.id_cie = po.id_cie

Order by r.id_sin,
	     r.id_reg


Go
