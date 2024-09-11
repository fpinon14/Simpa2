-------------------------------------------------------------------
--
-- Fichier              :       PM02.CP
-- Auteur               :       FABRY JF
-- Date                 :       19/12/2011
--
-- Commentaires         :       PS affèrant au PM02
--
-- sysadm.DW_S01_PM02_MARQUE
-- sysadm.DW_S01_PM02_MODELE
-- sysadm.PS_D01_PM02_DOUBLON
-- sysadm.PS_D01_PM02_TRT_PERIODE
-- sysadm.PS_I_PM02_BATCH_LANCEMENT
-- sysadm.PS_I_PM02_REDRESSEMENT_SUR_CONTACT
-- sysadm.PS_I01_PM02_AGREG
-- sysadm.PS_I01_PM02_EXTR
-- sysadm.PS_I01_PM02_REJET
-- sysadm.PS_S01_PM02_FICHIER_REJET
-- sysadm.PS_S01_PM02_FICHIER_SORTIE_VOLCANES
-- sysadm.PS_S01_PM02_FICHIER_SORTIE_XLS
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_PM02_MARQUE
-- Auteur               :       FABRY JF
-- Date                 :       19/12/2012
-- Libellé              :        
-- Commentaires         :       [PM02]
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PM02_MARQUE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_PM02_MARQUE
GO

CREATE procedure sysadm.DW_S01_PM02_MARQUE
	@dcIdProd    Decimal (7),
	@sIdTypArt   VarChar (3)
	
AS

Declare @Ref	VarChar ( 3 )
Declare @iOption73 Integer

If @sIdTypArt <> '-1'
 Begin
 	Select 	@Ref = rtrim ( Left ( d.id_code_car, 3 ))
 	From	sysadm.det_pro d
 	Where 	d.id_prod = @dcIdProd
 	And 	d.id_code_dp = 28
 	And	right ( d.id_code_car, 3 ) = @sIdTypArt  
 	
 	If @Ref is null Set @Ref = ''
 	
 	If @Ref = '' And Exists ( 
 				Select * 
				From	sysadm.det_pro d
				Where 	d.id_prod = @dcIdProd
				And 	d.id_code_dp = 28
				And	d.id_code_car = 'SPBAUT' 
 				)
 	 Begin
 	 	Set @Ref = 'SPB'
 	 End 
 	
 	If @Ref = '' 
 	 Begin
 	 	Select  1 as 'tri',
			'-1' as id_marque,
 	 		'Pour toute marque' as marque
 	 End
 	
 	If @Ref = 'DTY' 
 	 Begin
 	 	Select  1 as 'tri',
 	 		'-1' as id_marque,
 	 		'Pour toute marque' as marque
 	 	Union
		Select 	distinct
			2 as 'tri',
			rc.marque as id_marque,
 	 		rc.marque
		From	sysadm.ref_codic_darty rc
		Where   rc.type_app = @sIdTypArt
		Order by tri
 	 End

 	If @Ref = 'IFR' 
 	 Begin
 	 	Select  1 as 'tri',
 	 		'-1' as id_marque,
 	 		'Pour toute marque' as marque
 	 	Union
		Select 	distinct
			2 as 'tri',
			i.marque as id_marque,
 	 		i.marque
		From	sysadm.ifr i
		Order by tri
 	 End
 	
 	If @Ref = 'SPB' 
 	 Begin
 	 
 	 	Select 	@iOption73 = d.val_num
 	 	From	sysadm.det_pro d
 	 	Where   d.id_prod = @dcIdProd
 		And 	d.id_code_dp = 73
 	 	
 	 	If @iOption73 is null Set @iOption73 = 0
 	 	
		If @iOption73 > 0
		  Begin
			Select  1 as 'tri',
				'-1' as id_marque,
				'Pour toute marque' as marque
			Union
			Select 	distinct
				2 as 'tri',
				c.lib_code as id_marque,
				c.lib_code 'marque'
			From	sysadm.code c,
				sysadm.famille f
			Where 	c.id_typ_code = '-MB' 	 	
			And	f.id_typ_code = '-MB' 	 	
			And	f.id_fam = @iOption73
			And	c.id_code = f.id_code
			Order by tri
		  End		
		Else
		  Begin
			Select  1 as 'tri',
				'-1' as id_marque,
				'Pour toute marque' as marque
			Union
			Select 	distinct
				2 as 'tri',
				c.lib_code as id_marque,
				c.lib_code 'marque'
			From	sysadm.code c
			Where 	c.id_typ_code = '-MB' 	 	
			Order by tri
		  End
 	 End
 
 End
Else -- cas du -1
 Begin
 
 	Select  1 as 'tri',
 		'-1' as id_marque,
		'Pour toute marque' as marque
 	Union	
 	Select 	distinct
		2 as 'tri',
		rc.marque as id_marque,
 		rc.marque
 	From	sysadm.det_pro d,
 		sysadm.ref_codic_darty rc
 	Where 	d.id_prod = @dcIdProd
 	And 	d.id_code_dp = 28
 	And	Left ( d.id_code_car, 3 ) = 'DTY'
 	Union 
 	Select 	distinct
		2 as 'tri',
 		i.marque as id_marque,
 		i.marque
 	From	sysadm.det_pro d,
 		sysadm.ifr i
 	Where 	d.id_prod = @dcIdProd
 	And 	d.id_code_dp = 28
 	And	Left ( d.id_code_car, 3 ) = 'IFR'
 	Union 
 	Select 	distinct
		2 as 'tri',
 		c.lib_code as id_marque,
 		c.lib_code 'marque'
 	From	sysadm.det_pro d,
 		sysadm.code c
 	Where 	d.id_prod = @dcIdProd
 	And 	d.id_code_dp = 28
 	And	Left ( d.id_code_car, 3 ) = 'SPB'
 	And 	c.id_typ_code = '-MB'
 	And     Not Exists ( 	Select  * 
 				From 	sysadm.det_pro d2
 				Where 	d2.id_prod = @dcIdProd
 				And 	d2.id_code_dp = 73
 			   ) 
 	Union 
 	Select 	distinct
		2 as 'tri',
 		c.lib_code as id_marque,
 		c.lib_code 'marque'
 	From	sysadm.det_pro d,
 		sysadm.det_pro d2,
 		sysadm.code c,
 		sysadm.famille f
 	Where 	d.id_prod = @dcIdProd
 	And 	d.id_code_dp = 28
 	And	Left ( d.id_code_car, 3 ) = 'SPB'
 	And 	c.id_typ_code = '-MB'
 	And     d2.id_prod = d.id_prod
	And 	d2.id_code_dp = 73
	And	d2.val_num > 0 
	And	f.id_typ_code = '-MB' 	 		
	And 	f.id_fam = d2.val_num
	And 	c.id_code = f.id_code
 	
 	Order by tri
 
 End


Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_PM02_MODELE
-- Auteur               :       FABRY JF
-- Date                 :       19/12/2012
-- Libellé              :        
-- Commentaires         :       [PM02]
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PM02_MODELE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_PM02_MODELE
GO

CREATE procedure sysadm.DW_S01_PM02_MODELE
	@dcIdProd    Decimal (7),
	@sIdTypArt   VarChar (3)
	
AS

Declare @Ref	VarChar ( 3 )

If @sIdTypArt <> '-1'
 Begin
 	Select 	@Ref = rtrim ( Left ( d.id_code_car, 3 ))
 	From	sysadm.det_pro d
 	Where 	d.id_prod = @dcIdProd
 	And 	d.id_code_dp = 28
 	And	right ( d.id_code_car, 3 ) = @sIdTypArt  
 	
 	If @Ref is null Set @Ref = ''

 	If @Ref = '' And Exists ( 
 				Select * 
				From	sysadm.det_pro d
				Where 	d.id_prod = @dcIdProd
				And 	d.id_code_dp = 28
				And	d.id_code_car = 'SPBAUT' 
 				)
 	 Begin
 	 	Set @Ref = 'SPB'
 	 End 
 	
 	If @Ref = '' Or @Ref = 'SPB' 
 	 Begin
 	 	Select  1 as 'tri',
	 		'-1' as 'marque', 	
 			'-1' as 'id_modele', 	
 			'Pour tout modèle' as 'modele'
 	 End
 	
 	If @Ref = 'DTY' 
 	 Begin
 	 	Select  1 as 'tri',
	 		'-1' as 'marque', 	
 	 		'-1' as 'id_modele', 	
 			'Pour tout modèle' as 'modele'
 	 	Union
		Select 	distinct
			2 as 'tri',
			rc.marque,
			rc.modele as 'id_modele',
			rc.modele
		From	sysadm.ref_codic_darty rc
		Where   rc.type_app = @sIdTypArt		
		Order by tri
 	 End

 	If @Ref = 'IFR' 
 	 Begin
 	 	Select  1 as 'tri',
	 		'-1' as 'marque', 	
 	 		'-1' as 'id_modele', 	
 			'Pour tout modèle' as 'modele'
 	 	Union
		Select 	distinct
			2 as 'tri',
			i.marque,
			i.reference as 'id_modele',
			i.reference 
		From	sysadm.ifr i
		Order by tri
 	 End
 
 End
Else -- cas du -1
 Begin
 
 	Select  1 as 'tri',
 		'-1' as 'marque', 	
 		'-1' as 'id_modele', 	
 		'Pour tout modèle' as 'modele'

 	Union	
 	Select 	distinct
		2 as 'tri',
 		rc.marque,
 		rc.modele as 'id_modele',
		rc.modele
 	From	sysadm.det_pro d,
 		sysadm.ref_codic_darty rc
 	Where 	d.id_prod = @dcIdProd
 	And 	d.id_code_dp = 28
 	And	Left ( d.id_code_car, 3 ) = 'DTY'
 	Union 
 	Select 	distinct
		2 as 'tri',
 		i.marque,
 		i.reference as 'id_modele',
		i.reference
 	From	sysadm.det_pro d,
 		sysadm.ifr i
 	Where 	d.id_prod = @dcIdProd
 	And 	d.id_code_dp = 28
 	And	Left ( d.id_code_car, 3 ) = 'IFR'
 	
 	Order by tri
 
 End


Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_D01_PM02_TRT_PERIODE
-- Auteur               :       FABRY JF
-- Date                 :       19/12/2012
-- Libellé              :        
-- Commentaires         :       [PM02]
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_PM02_TRT_PERIODE' AND type = 'P' )
        DROP procedure sysadm.PS_D01_PM02_TRT_PERIODE
GO

CREATE procedure sysadm.PS_D01_PM02_TRT_PERIODE
	@iIdPeriode integer,
	@iIdTrt	    integer
	
AS

Delete From sysadm.rejet_ftu_brk 
Where 	id_periode = @iIdPeriode 
And 	id_trt = @iIdTrt

Delete From sysadm.cum_ftu_brk
Where 	id_periode = @iIdPeriode 
And 	id_trt = @iIdTrt

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_PM02_AGREG
-- Auteur               :       FABRY JF
-- Date                 :       19/12/2012
-- Libellé              :        
-- Commentaires         :       [PM02]
-- Références           :       
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      27/05/2019   [PM478-1]
-- JFF      22/10/2019   [PI087_PM473_2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_PM02_AGREG' AND type = 'P' )
        DROP procedure sysadm.PS_I01_PM02_AGREG
GO

CREATE procedure sysadm.PS_I01_PM02_AGREG
	@iIdTrt	    integer,
	@iIdPeriode integer,
	@sCodOper   Varchar ( 4 )
AS

-- Variable pour données lues de tables
Declare
@iMarquage            integer, 
@dcIdProd             decimal(7), 
@dcIdEts              decimal(7), 
@sIdAdh		      varchar(19), 	
@dcIdsDos             decimal(2), 
@dcIdProdVolc         decimal(3), 
@dcIdSin              decimal(10),  -- [PI062]
@iIdSeq               integer,    
@dcIdGti              decimal(7), 
@sLibGti              varchar(35),
@dcCodEtatDos         decimal(7), 
@sLibEtatDos          varchar(35),
@sNomAss              varchar(35),
@sPrenomAss           varchar(35),
@sMarqAppSin          varchar(35),
@sModlAppSin          varchar(35),
@sIdTypArt            varchar(3),
@sLibTypArt           varchar(35),
@sNumSerie            varchar(60),
@sIdBrk               varchar(3), 
@sLibBrk              varchar(35), 
@sLibPolice           varchar(35),
@dcIdCie              decimal(7), 
@sLibCie              varchar(35),
@dtDteAchat           datetime,   
@dtDteSurv            datetime,   
@dtDteRcpFrn          datetime,   
@iAppIncomplet	      integer,
@sMajPar              varchar(4),
@iIdTarif	      integer,	
@sTypMtPivot          varchar(6),           
@sHttcPivot           varchar(6),           
@dcMtPivot            decimal(11,2),
@sTypVetuste          varchar(6),
@iPerCplt             integer,
@sPerCpltUt           varchar(1),
@sTypDecote           varchar(6),
@dcMtDecote           decimal(11,2),
@sHttcDecote          varchar(6),
@dcTxDecote          decimal(11,5),
@dsMtForfaitaire      decimal(11,2),
@sHttcForfait         varchar(6),
@sIdFourForfait       varchar(3),
@dcTxTva             decimal(11,5),        
@ParamCplt            varchar(255)         

-- Variables de travail
Declare	
@iRet			Integer,
@dcTxTvaTrv		decimal(11,5),
@sMess			VarChar ( 255 ),
@mtForfaitHT 		decimal(11,2),
@mtUnitaireHT 		decimal(11,2),
@dcMtDecoteTTC		decimal(11,2),
@mtBaseTTC		decimal(11,2),
@mtBaseDecoteTTC	decimal(11,2),
@mtBaseHT		decimal(11,2),
@DteVetDeb		Datetime,
@DteVetFin		Datetime,
@iVetusteJ		Integer,
@txCoefVetuste		decimal(11,5),
@mtTvaForfait		decimal(11,2),
@mtFactHTforfait	decimal(11,2),
@mtFactTTCForfait	decimal(11,2),
@mtTvaMat		decimal(11,2),
@mtFactHTmat		decimal(11,2),
@mtFactTTCmat		decimal(11,2),
@mtFactTTCtotal		decimal(11,2),
@iIdCum				integer

While Exists ( Select * From sysadm.w_cum_ftu_brk where marquage = 0 )
 Begin
	Select 	Top 1 
		-- je ramène les données issues de la première extraction
		@iIdCum		  = wc.id_cum,
		@iIdTrt       = wc.id_trt,
		@iIdPeriode   = wc.id_periode,
		@iMarquage    = wc.marquage,
		@dcIdProd     = wc.id_prod,
		@dcIdEts      = wc.id_ets,
		@sIdAdh	      = wc.id_adh,
		@dcIdsDos     = wc.id_sdos, 
		@dcIdProdVolc = wc.id_prod_volc,
		@dcIdSin      = wc.id_sin,
		@iIdSeq       = wc.id_seq,
		@dcIdGti      = wc.id_gti,
		@sLibGti      = wc.lib_gti,
		@dcCodEtatDos = wc.cod_etat_dos,
		@sLibEtatDos  = wc.lib_etat_dos,
		@sNomAss      = wc.nom_ass,
		@sPrenomAss   = wc.prenom_ass,
		@sMarqAppSin  = wc.marq_app_sin,
		@sModlAppSin  = wc.modl_app_sin,
		@sIdTypArt    = wc.id_typ_art,
		@sLibTypArt   = wc.lib_typ_art,
		@sNumSerie    = wc.num_serie,
		@sIdBrk       = wc.id_brk,
		@sLibBrk      = wc.lib_brk,
		@sLibPolice   = wc.lib_police,
		@dcIdCie      = wc.id_cie,
		@sLibCie      = wc.lib_cie,
		@dtDteAchat   = wc.dte_achat,
		@dtDteSurv    = wc.dte_surv,
		@dtDteRcpFrn  = wc.dte_rcp_frn,
		@iAppIncomplet= wc.app_incomplet,
		@sMajPar      = wc.maj_par,

		-- je ramène les données de param
		@iIdTarif       = pfb.id_tarif       ,
		@sTypMtPivot    = pfb.typ_mt_pivot   ,
		@sHttcPivot     = pfb.httc_pivot     ,
		@dcMtPivot      = pfb.mt_pivot       ,
		@sTypVetuste    = pfb.typ_vetuste    ,
		@iPerCplt       = pfb.per_cplt       ,
		@sPerCpltUt     = pfb.per_cplt_ut    ,
		@sTypDecote     = pfb.typ_decote     ,
		@dcMtDecote     = pfb.mt_decote      ,
		@sHttcDecote    = pfb.httc_decote    ,
		@dcTxDecote     = pfb.tx_decote      ,
		@dsMtForfaitaire= pfb.mt_forfaitaire ,
		@sHttcForfait   = pfb.httc_forfait   ,
		@sIdFourForfait = pfb.id_four_forfait,
		@dcTxTva        = pfb.tx_tva         ,
		@ParamCplt      = pfb.param_cplt
		
	From	sysadm.w_cum_ftu_brk wc,
		sysadm.param_ftu_brk pfb
	Where 	wc.marquage = 0
	And	pfb.id_tarif = wc.id_tarif

	-- Traitement
	
	Set @iRet = 1
	Set @dcTxTvaTrv		= 0
	Set @sMess		= ''
	Set @mtForfaitHT 	= 0
	Set @mtUnitaireHT 	= 0
	Set @dcMtDecoteTTC	= 0
	Set @mtBaseTTC		= 0
	Set @mtBaseDecoteTTC	= 0
	Set @mtBaseHT		= 0
	Set @DteVetDeb		= 0
	Set @DteVetFin		= 0
	Set @iVetusteJ		= 0
	Set @txCoefVetuste	= 0
	Set @mtTvaMat		= 0
	Set @mtFactHTmat	= 0
	Set @mtFactTTCmat	= 0
	Set @mtTvaForfait	= 0
	Set @mtFactHTforfait	= 0
	Set @mtFactTTCForfait	= 0
	Set @mtFactTTCtotal	= 0



	If @iRet = 1 And @sTypMtPivot = 'FX'
	 Begin
		If @dcTxTva <= 0 
		 Begin
			-- Traitement Rejet
			Set @iRet = 0
			Set @sMess = '[REJET]: Valeur de TVA négative ou nulle (' + Rtrim ( Convert ( VarChar (20), @dcTxTva ) ) + ') , problème de division par zéro.'
			Exec sysadm.PS_I01_PM02_REJET @iIdTrt, @iIdPeriode, @dcIdProd, @dcIdSin, @sMess, @sCodOper, @sCodOper
		 End 
	End 

	-- Tva de travail
	If @iRet = 1 
	 Begin
		Set @dcTxTvaTrv = 1 + @dcTxTva
	 End 

	
	
	-- Pré-calcul => Détermination montant pivot.
	If @iRet = 1 And @sTypMtPivot = 'FX'
	 Begin
		-- ajustement Valeur TTC en HT (elle est toujours donnée en HT dan le fichier)
	 	Set @mtUnitaireHT = 	Case @sHttcPivot 
	 					When 'TTC' Then Round ( @dcMtPivot / @dcTxTvaTrv, 2 )
	 					When 'HT'  Then @dcMtPivot
	 				End 
		If @mtUnitaireHT is null Set @mtUnitaireHT = 0 				
	 	
	 End 
	
	If @iRet = 1 and @sTypMtPivot in ( 'VA', 'VP' ) -- Elle sont toujours en TTC
	 Begin
		Select 	@dcMtPivot = Min ( 
					     Case 
						When @sTypMtPivot = 'VA' And d.mt_val_achat > 0 Then d.mt_val_achat
						When @sTypMtPivot = 'VP' And d.mt_val_publique > 0 Then d.mt_val_publique
					     End
					 )
	     
		From	sysadm.detail d
		Where	d.id_sin = @dcIdSin
		And	( d.id_gti = @dcIdGti or @dcIdGti = -1 )
		And	d.id_evt in ( 936, 1328, 1317 )
		If @dcMtPivot is null Set @dcMtPivot = 0

		If @dcMtPivot <= 0 
		 Begin
			Select 	@dcMtPivot = Min ( 
						     Case 
							When @sTypMtPivot = 'VA' And d.mt_val_achat > 0 Then d.mt_val_achat
							When @sTypMtPivot = 'VP' And d.mt_val_publique > 0 Then d.mt_val_publique
						     End
						 )
			From	sysadm.detail d
			Where	d.id_sin = @dcIdSin
			And	( d.id_gti = @dcIdGti or @dcIdGti = -1 )
			And	d.id_evt = 940
		 End
		If @dcMtPivot is null Set @dcMtPivot = 0

		If @dcMtPivot <= 0 
		 Begin
			Select 	@dcMtPivot = Min ( 
						     Case 
							When @sTypMtPivot = 'VA' And d.mt_val_achat > 0 Then d.mt_val_achat
							When @sTypMtPivot = 'VP' And d.mt_val_publique > 0 Then d.mt_val_publique
						     End
					 	 )
			From	sysadm.detail d
			Where	d.id_sin = @dcIdSin
			And	( d.id_gti = @dcIdGti or @dcIdGti = -1 )
			And	d.id_evt = 1083
		 End
		If @dcMtPivot is null Set @dcMtPivot = 0

		If @dcMtPivot <= 0 
		 Begin
			Select 	@dcMtPivot = Min ( 
						     Case 
							When @sTypMtPivot = 'VA' And d.mt_val_achat > 0 Then d.mt_val_achat
							When @sTypMtPivot = 'VP' And d.mt_val_publique > 0 Then d.mt_val_publique
						     End
						 )
			From	sysadm.detail d
			Where	d.id_sin = @dcIdSin
			And	( d.id_gti = @dcIdGti or @dcIdGti = -1 )
			And	d.id_evt not in ( 936, 1328, 1317, 940, 1083 )
		 End

		If @dcMtPivot is null Set @dcMtPivot = 0
		
		If @dcMtPivot <= 0 
		 Begin 
		 	-- Traitement Rejet
		 	Set @iRet = 0
		 	Set @sMess = Case @sTypMtPivot 
		 			When 'VA' Then 'valeur d''achat d''origine'
		 			When 'VP' Then 'valeur publique de remplacement'
		 		     End 
			Set @sMess = '[REJET]: Impossible de trouver la ' + @sMess + ' en fonction de l''algorithme fourni par DPG dans l''EDB'
			Exec sysadm.PS_I01_PM02_REJET @iIdTrt, @iIdPeriode, @dcIdProd, @dcIdSin, @sMess, @sCodOper
		 End 
		Else
		 Begin
			Set @mtBaseTTC = @dcMtPivot
			If @mtBaseTTC is null Set @mtBaseTTC = 0 				
		 End	
	 End 	 

	-- Pré-calcul => Détermination décote
	If @iRet = 1 
	 Begin

		If @iAppIncomplet = 1 
		 Begin
			Set @dcMtDecoteTTC = 	
				Case @sTypDecote

					When 'DECPCT' Then
						Case 
							When @sTypMtPivot in ( 'FX' )	    Then Round ( @mtUnitaireHT * @dcTxDecote * @dcTxTvaTrv, 2 )
							When @sTypMtPivot in ( 'VA', 'VP' ) Then Round ( @mtBaseTTC * @dcTxDecote, 2 )
						End 


					When 'DECFIX'	Then
						Case @sHttcDecote
							When 'TTC' Then @dcMtDecote
							When 'HT'  Then Round ( @dcMtDecote * @dcTxTvaTrv, 2 )
						End

					Else 0

				End 
		 End
		Else
		 Begin
		  	Set @dcMtDecoteTTC = 0 -- On reforce à 0 la décote, même si elle est fixe, puisque l'appareil n'est pas incomplet
		  	Set @dcTxDecote = 0    -- Suite RR7 NC le 08/06/2011
		 End 
		 
		If @dcMtDecoteTTC is null Set @dcMtDecoteTTC = 0 				 
	End

	-- Pré-calcul => ajustement Montant forfaitaire TTC en HT (il est toujours donné en HT dan le fichier)
	If @iRet = 1
	 Begin
	 	If @sHttcForfait = 'TTC'		
		 Begin
			Set @mtForfaitHT = Round ( @dsMtForfaitaire / @dcTxTvaTrv, 2 )
		 End
		Else
		 Begin
			Set @mtForfaitHT = @dsMtForfaitaire
		 End
		 
		If @mtForfaitHT is null Set @mtForfaitHT = 0 				 
		 
	 End 

	-- Calcul Base TTC moins la décôte
	If @iRet = 1
	 Begin
		Set @mtBaseDecoteTTC = Round ( @mtBaseTTC - @dcMtDecoteTTC, 2 )
		If @mtBaseDecoteTTC is null Set @mtBaseDecoteTTC = 0 				 
	 End 
	
	-- Calcul Base HT
	If @iRet = 1
	 Begin
		Set @mtBaseHT = Round ( (@mtBaseTTC - @dcMtDecoteTTC) / @dcTxTvaTrv , 2 )
		If @mtBaseHT is null Set @mtBaseHT = 0 				 		
	 End

	-- Pré-calcul => Calcul de la vétusté.
	If @iRet = 1 -- Détermination des dates
	 Begin
		Set @DteVetDeb = @dtDteAchat
		Select @DteVetFin = 	Case @sTypVetuste
						When 'ACHSRV' Then @dtDteSurv
						When 'ACHRCP' Then @dtDteRcpFrn
					End 

		If @DteVetDeb is null 
		 Begin
			-- Traitement Rejet
			Set @iRet = 0
			Set @sMess = '[REJET]: La date d''achat n''est pas renseignée sur ce dossier, impossible de calculer la vétusté'
			Exec sysadm.PS_I01_PM02_REJET @iIdTrt, @iIdPeriode, @dcIdProd, @dcIdSin, @sMess, @sCodOper
		 End 	 

		If @DteVetFin is null 
		 Begin
			-- Traitement Rejet
			Set @iRet = 0
		 	Set @sMess = Case @sTypVetuste
						When 'ACHSRV' Then 'de survenance'
						When 'ACHRCP' Then 'de réception du matériel chez le fournisseur d''origine' 
					End 
			Set @sMess = '[REJET]: La date ' + @sMess + ' n''est pas renseignée sur ce dossier, impossible de calculer la vétusté'
			Exec sysadm.PS_I01_PM02_REJET @iIdTrt, @iIdPeriode, @dcIdProd, @dcIdSin, @sMess, @sCodOper
		 End 	 
	 End 

	If @iRet = 1 -- ajout période complèmentaire
	 Begin
		Select @DteVetFin = Case @sPerCpltUt
					When 'J' Then DateAdd ( day, @iPerCplt, @DteVetFin  )
					When 'M' Then DateAdd ( Month, @iPerCplt, @DteVetFin  )
					When 'A' Then DateAdd ( Year, @iPerCplt, @DteVetFin  )
				    End
	 End 

	If @iRet = 1 -- ajout période complèmentaire
	 Begin
		Select @iVetusteJ = DateDiff ( day, @DteVetDeb, @DteVetFin ) 
		If @iVetusteJ is null Set @iVetusteJ = 0 				 		

	 End	
	 
	-- Recherche du taux de vétuste en fonction du paramètrage et de la vétusté calculée.
	If @iRet = 1
	 Begin
		
		If @sTypMtPivot in ( 'VA', 'VP' )
		 Begin
			Select 	@txCoefVetuste = pfbv.tx_reprise
			From	sysadm.param_ftu_brk_vts pfbv
			Where	pfbv.id_tarif = @iIdTarif
			And
				( 
					( @mtBaseDecoteTTC > pfbv.mt_pivot_min And ie_mt_pivot_min = 'E' )
					Or 
					( @mtBaseDecoteTTC >= pfbv.mt_pivot_min And ie_mt_pivot_min = 'I' )
					Or 
					( pfbv.mt_pivot_min = -1 )
				)
			And
				(
					( @mtBaseDecoteTTC < pfbv.mt_pivot_max And ie_mt_pivot_max = 'E' )
					Or 
					( @mtBaseDecoteTTC <= pfbv.mt_pivot_max And ie_mt_pivot_max = 'I' )
					Or
					( pfbv.mt_pivot_max = -1 )
				)
			And

				( 	
					( @iVetusteJ >= pfbv.periode_min_j )
					Or 
					( pfbv.periode_min_j = -1 )
				)
			And	( 	
					( @iVetusteJ <= pfbv.periode_max_j )
					Or 
					( pfbv.periode_max_j = -1 )
				)
			
			If @txCoefVetuste is null Set @txCoefVetuste = 0
			If @txCoefVetuste = 0 
			 Begin
				-- Traitement Info
--				[VDOC7860]
--				Set @iRet = 2
				Set @sMess = '[INFO] : '
--				Set @sMess = @sMess + 'Vétusté du matériel en dehors des bornes du tableau de recherche. Matériel trop vieux, dossier marqué, ne sera plus réextrait'
				Set @sMess = @sMess + 'Vétusté du matériel en dehors des bornes du tableau de recherche. Matériel trop vieux, mais tout de même traité dans le PM02 avec un taux de coeficient de vétusté forcé à 0%, suite VDOC7860'
				Exec sysadm.PS_I01_PM02_REJET @iIdTrt, @iIdPeriode, @dcIdProd, @dcIdSin, @sMess, @sCodOper
			 End 
		 End
		
		If @txCoefVetuste is null Set @txCoefVetuste = 0 				 		
	End 
	
	-- Calcul Montant Facture HT sur matériel
	If @iRet = 1
	 Begin

		Set @mtFactHTmat = Case 
					When @sTypMtPivot in ( 'VA', 'VP' ) Then Round ( @mtBaseHT * @txCoefVetuste , 2 )
					When @sTypMtPivot in ( 'FX' ) Then 
						Case @sTypDecote -- Calcul décote HT

							When 'DECPCT' Then Round ( @mtUnitaireHT - ( @mtUnitaireHT * @dcTxDecote ), 2 )
							When 'DECFIX'	Then
								Case @sHttcDecote
									When 'TTC' Then Round ( @mtUnitaireHT - ( @dcMtDecote / @dcTxTvaTrv ), 2 )
									When 'HT'  Then Round ( @mtUnitaireHT - @dcMtDecote, 2 )
								End
							Else @mtUnitaireHT
						End 		 
		 		   End
		 
		Set @mtFactHTforfait = @mtForfaitHT
		
		If @mtFactHTmat is null Set @mtFactHTmat = 0 				 		
		If @mtFactHTforfait is null Set @mtFactHTforfait = 0 				 				
	
	 End

	-- Calcul Montant Tva sur matériel
	If @iRet = 1
	 Begin
		Set @mtTvaMat = Round ( ( @mtFactHTmat * @dcTxTvaTrv ) - @mtFactHTmat , 2 )
		Set @mtTvaForfait = 	Case @sHttcForfait
						When 'TTC' Then Round ( @dsMtForfaitaire - ( @dsMtForfaitaire / @dcTxTvaTrv ) , 2 )
						When 'HT'  Then Round ( ( @mtForfaitHT * @dcTxTvaTrv ) - @mtForfaitHT , 2 )
					End 
					
		If @mtTvaMat is null Set @mtTvaMat = 0 				 									
		If @mtTvaForfait is null Set @mtTvaForfait = 0 				 														
	 End 

	-- Calcul Montant Facture TTC sur matériel
	If @iRet = 1
	 Begin
		Set @mtFactTTCmat = Round ( @mtFactHTmat * @dcTxTvaTrv , 2 )
		Set @mtFactTTCForfait = Case @sHttcForfait
						When 'TTC' Then @dsMtForfaitaire
						When 'HT'  Then Round ( @mtForfaitHT * @dcTxTvaTrv, 2 )
					End 

		If @mtFactTTCmat is null Set @mtFactTTCmat = 0 				 									
		If @mtFactTTCForfait is null Set @mtFactTTCForfait = 0 				 														
				
	 End 

	-- Calcul Montant Facture TTC sur matériel
	If @iRet = 1
	 Begin
		Set @mtFactTTCtotal = Round ( 
						( @mtFactHTmat * @dcTxTvaTrv ) + 	
						Case @sHttcForfait
							When 'TTC' Then @dsMtForfaitaire
							When 'HT'  Then Round ( @mtForfaitHT * @dcTxTvaTrv, 2 )
						End 
					, 2 )
		If @mtFactTTCtotal is null Set @mtFactTTCtotal = 0 				 									
	 End 

	-- Insertion dans table définitive (2 fois si forfait)	
	If @iRet = 1
	 Begin
		Insert Into sysadm.cum_ftu_brk Values
			(
			@iIdTrt,
			@iIdPeriode,
			@iIdTarif,
			@dcIdProd,
			@dcIdEts,
			@sIdAdh,
			@dcIdsDos, 
			@dcIdProdVolc,
			@dcIdSin,
			@iIdSeq,
			@dcIdGti,
			@sLibGti,
			@dcCodEtatDos,
			@sLibEtatDos,
			@sNomAss,
			@sPrenomAss,
			@sMarqAppSin,
			@sModlAppSin,
			@sIdTypArt,
			@sLibTypArt,
			@sNumSerie,
			@sIdBrk,
			@sLibBrk,
			@sLibPolice,
			@dcIdCie,
			@sLibCie,
			@dtDteAchat,
			@dtDteSurv,
			@dtDteRcpFrn,
			0,
			null,
			@mtUnitaireHT,
			@mtBaseTTC,
			@sTypDecote,
			@dcTxDecote,
			@dcMtDecoteTTC,
			@dcTxTva,
			@mtBaseDecoteTTC,
			@mtBaseHT,
			@iVetusteJ,
			@txCoefVetuste,
			@mtFactHTmat, 
			@mtTvaMat,
			@mtFactTTCmat,
			@mtFactTTCtotal,
			Getdate(),
			Getdate(),
			@sCodOper,
			'', -- accord_brk, -- [PM478-1]
			0,  -- mt_facture_ttc_modifie_par_brk, -- [PM478-1]
			'', -- comment_brk, -- [PM478-1]
			0,  -- mt_facture_ttc_force_spb, -- [PM478-1]
			'' -- comment_spb -- [PM478-1]
			)

		-- Cas du 2ème enregistrements pour le Forfait
		If @dsMtForfaitaire > 0 
		 Begin
			Insert Into sysadm.cum_ftu_brk Values
				(
				@iIdTrt,
				@iIdPeriode,
				@iIdTarif,
				@dcIdProd,
				@dcIdEts,
				@sIdAdh,
				@dcIdsDos, 
				@dcIdProdVolc,
				@dcIdSin,
				@iIdSeq,
				@dcIdGti,
				@sLibGti,
				@dcCodEtatDos,
				@sLibEtatDos,
				@sNomAss,
				@sPrenomAss,
				@sMarqAppSin,
				@sModlAppSin,
				@sIdTypArt,
				@sLibTypArt,
				@sNumSerie,
				@sIdBrk,
				@sLibBrk,
				@sLibPolice,
				@dcIdCie,
				@sLibCie,
				@dtDteAchat,
				@dtDteSurv,
				@dtDteRcpFrn,
				@mtForfaitHT,
				@sIdFourForfait,
				0,
				0,
				'AUCUNE',
				0,
				0,
				@dcTxTva,
				0,
				0,
				0,
				0,
				@mtFactHTforfait,
				@mtTvaForfait,
				@mtFactTTCForfait,
				0,
				Getdate(),
				Getdate(),
				@sCodOper,
				'', -- accord_brk, -- [PM478-1]
				0,  -- mt_facture_ttc_modifie_par_brk, -- [PM478-1]
				'', -- comment_brk, -- [PM478-1]
				0,  -- mt_facture_ttc_force_spb, -- [PM478-1]
				'' -- comment_spb -- [PM478-1]
				)

		 End 
	 End	
	
	-- Marquage de cet enrg comme étant traité dans la table de travail
	Update sysadm.w_cum_ftu_brk 
	Set marquage = Case @iRet
			 When 0 Then 1 -- Non extrait, Marquage de rejet, sera réextrait la prochaine fois 
			 When 1 Then 2 -- Extrait, Marquage définitif, ne sera plus réextrait
			 When 2 Then 2 -- Non extrait, Marquage définitif, ne sera plus réextrait
		       End		
	Where id_cum = @iIdCum
	
 End

----------------------------------------------------------------------------
--       MARQUAGE DEFINITIF EN BASE DES DONNEES EXTRAITES ET TRAITEES     --
----------------------------------------------------------------------------
Insert into sysadm.div_sin
Select 	distinct
	wtb.id_sin,
	'pm02_id_trt',
	'Id_Trt Marquage extract. PM02',
	'-1',
	'N',
	'N',
	'O',
	'O',
	500,
	@iIdTrt,
	null,
	null,
	null, 
	getdate(),
	getdate(),
	@sCodOper,
	getdate(),
	@sCodOper

From 	sysadm.w_cum_ftu_brk wtb,
     	sysadm.sinistre s
Where Not Exists ( 
	Select 	*
	From   	sysadm.div_sin ds
	Where  	ds.id_sin = wtb.id_sin
	And	ds.nom_zone = 'pm02_id_trt'
      )
And  wtb.marquage = 2
And  s.id_sin = wtb.id_sin

Insert into sysadm.div_sin
Select 	distinct
	wtb.id_sin,
	'pm02_id_periode',
	'Id_Periode Marquage extract. PM02',
	'-1',
	'N',
	'N',
	'O',
	'O',
	501,
	@iIdPeriode,
	null,
	null,
	null,
	getdate(),
	getdate(),
	@sCodOper,
	getdate(),
	@sCodOper

From 	sysadm.w_cum_ftu_brk wtb,
     	sysadm.sinistre s
Where Not Exists ( 
	Select 	*
	From   	sysadm.div_sin ds
	Where  	ds.id_sin = wtb.id_sin
	And	ds.nom_zone = 'pm02_id_periode'
      )
And  wtb.marquage = 2
And  s.id_sin = wtb.id_sin

-- [PI087_PM473_2]
While Exists ( Select Top 1 1 From sysadm.w_cum_ftu_brk where marquage = 2 )
	Begin
		Select Top 1 
			-- je ramène les données issues de la première extraction
			@iIdCum	  = wc.id_cum,
			@dcIdSin  = wc.id_sin
		From	sysadm.w_cum_ftu_brk wc
		Where 	wc.marquage = 2

		Exec sysadm.PS_I_PI087_TRACE_DOSSIER @dcIdSin, 'VALIDATION', 'PM02'

		Update sysadm.w_cum_ftu_brk 
		Set marquage = 3 -- Tracé
		Where id_cum = @iIdCum
	End 

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_D01_PM02_DOUBLON
-- Auteur               :       FABRY JF
-- Date                 :       19/12/2012
-- Libellé              :        
-- Commentaires         :       [PM02][VDOC7722]
-- Références           :       
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_PM02_DOUBLON' AND type = 'P' )
        DROP procedure sysadm.PS_D01_PM02_DOUBLON
GO

CREATE procedure sysadm.PS_D01_PM02_DOUBLON
	@iIdTrt	    integer,
	@iIdPeriode integer,
	@sCodOper   Varchar ( 4 )
AS

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ),  -- [PI062]
	  nbre		integer,
	  marquage	integer null 
	)

DECLARE @tb2 TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ),  -- [PI062]
	  id_tarif	integer,	  
	  nbre		integer,
	  marquage	integer null 
	)


Declare @dcIdSin decimal (10 ) -- [PI062]
Declare @iNbre  Integer
Declare @iIdSeq integer
Declare @iIdTarif integer
Declare @iMinIdCum integer
Declare @iResultat integer
Declare @sTypApp VarChar ( 3 )
Declare @sMess	VarChar ( 255 )
Declare @dcIdProd Decimal ( 7 )

Insert into @tb
select distinct 
	   c.id_sin, 
	   COUNT(*),
	   0 'marquage'
from	sysadm.cum_ftu_brk c
where	c.id_four_forfait is null 
And		c.id_trt = @iIdTrt
group by c.id_sin, c.id_trt
having COUNT(*) > 1 


While Exists ( Select * From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin
	From	@tb
	Where	marquage = 0

	-- Delete sur les marque/modèle
	Select	distinct top 1
			@iIdTarif = p.id_tarif
	From	sysadm.param_ftu_brk p,
			sysadm.cum_ftu_brk c
	Where   c.id_sin = @dcIdSin 
	And		p.id_tarif = c.id_tarif
	And		( p.id_marq_art <> '-1' And p.id_modl_art <> '-1' )
	-- ne rien coder ici pour ne pas changer le @@RowCount
	Set @iResultat = @@ROWCOUNT 
	If @iResultat > 0 
		Begin 
			Delete from sysadm.cum_ftu_brk 
			Where id_sin = @dcIdSin 
			And	  id_tarif <> @iIdTarif
			And	  id_trt = @iIdTrt 
			
			Update @tb
			Set marquage = 1
			Where id_seq = @iIdSeq

			Continue			
			
		End 
	
	If @iResultat <= 0 
		Begin
			Select	distinct top 1
					@iIdTarif = p.id_tarif
			From	sysadm.param_ftu_brk p,
					sysadm.cum_ftu_brk c
			Where   c.id_sin = @dcIdSin 
			And		p.id_tarif = c.id_tarif
			And		( p.id_marq_art <> '-1' And p.id_modl_art = '-1' )
			Set @iResultat = @@ROWCOUNT 
			If @iResultat > 0 
				Begin 
					Delete from sysadm.cum_ftu_brk 
					Where id_sin = @dcIdSin 
					And	  id_tarif <> @iIdTarif
					And	  id_trt = @iIdTrt 
			
					Update @tb
					Set marquage = 1
					Where id_seq = @iIdSeq

					Continue			
					
				End 
		End


	If @iResultat <= 0 
		Begin
			-- Delete sur les type d'appareil
			Select	distinct top 1
					@iIdTarif = p.id_tarif
			From	sysadm.param_ftu_brk p,
					sysadm.cum_ftu_brk c
			Where   c.id_sin = @dcIdSin 
			And		p.id_tarif = c.id_tarif
			And		p.id_typ_art = c.id_typ_art
			-- ne rien coder ici pour ne pas changer le @@RowCount
			Set @iResultat = @@ROWCOUNT 
			If @iResultat > 0 
				Begin 
					Delete from sysadm.cum_ftu_brk 
					Where id_sin = @dcIdSin 
					And	  id_tarif <> @iIdTarif
					And	  id_trt = @iIdTrt 

					Update @tb
					Set marquage = 1
					Where id_seq = @iIdSeq

					Continue			
					
				End 
		End
		
	Update @tb
	Set marquage = 1
	Where id_seq = @iIdSeq
 End

-- Par tarif
Insert into @tb2
select distinct 
	   c.id_sin, 
	   c.id_tarif,
	   COUNT(*),
	   0 'marquage'
from	sysadm.cum_ftu_brk c
where	c.id_four_forfait is null 
And		c.id_trt = @iIdTrt
group by c.id_sin, c.id_tarif, c.id_trt
having COUNT(*) > 1 

While Exists ( Select * From @tb2 where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin,
		@iIdTarif = id_tarif,
		@iNbre = nbre
	From	@tb2
	Where	marquage = 0

	Select @dcIdProd = s.id_prod
	From   sysadm.sinistre s
	Where  s.id_sin = @dcIdSin

	Set @sMess = '[INFO]: ' + CONVERT ( VarChar ( 10 ), @iNbre ) + ' PEC_A_RECYCLER. 1 seule de traitée, dossier marqué, ne ressortira dans le PM02'
	Exec sysadm.PS_I01_PM02_REJET @iIdTrt, @iIdPeriode, @dcIdProd, @dcIdSin, @sMess, @sCodOper

	Select @iMinIdCum = MIN ( c.id_cum ) 
	From   sysadm.cum_ftu_brk c
	Where  c.id_trt = @iIdTrt
	And    c.id_sin = @dcIdSin
	And    c.id_tarif = @iIdTarif

	If @iMinIdCum is not null and @iMinIdCum > 0
	  Begin
		Delete From sysadm.cum_ftu_brk
		Where  id_trt = @iIdTrt
		And    id_sin = @dcIdSin
		And    id_tarif = @iIdTarif		
		And    id_cum > @iMinIdCum
	  End
		
	Update @tb2
	Set marquage = 1
	Where id_seq = @iIdSeq

 End

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_PM02_EXTR
-- Auteur               :       FABRY JF
-- Date                 :       19/12/2012
-- Libellé              :        
-- Commentaires         :       [PM02]
-- Références           :       
-------------------------------------------------------------------
-- JFF	27/02/2012	[20120127] suite réunion avec aurélien
-- JFF  13/02/2012  [VDOC6449] dte_livr_SBE
-- JFF  03/07/2014  [PM02-2]
-- JFF  23/02/2016  [PM330-1]
-- JFF  08/03/2016  [VDOC20139]
-- JFF  21/11/2018  [VDOC27123]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_PM02_EXTR' AND type = 'P' )
        DROP procedure sysadm.PS_I01_PM02_EXTR
GO

CREATE procedure sysadm.PS_I01_PM02_EXTR
	@iIdTrt	    integer,
	@iIdPeriode integer,
	@sCodOper   Varchar ( 4 )
AS

-- Nettoyage de la table
Delete From sysadm.w_cum_ftu_brk
Delete From sysadm.param_ftu_brk_vts_sv where id_trt = @iIdTrt and id_periode = @iIdPeriode
Delete From sysadm.param_ftu_brk_sv where id_trt = @iIdTrt and id_periode = @iIdPeriode

-- Sav du param pour la période
Insert into sysadm.param_ftu_brk_sv 
Select 	@iIdTrt,
	@iIdPeriode,
	id_tarif,
	id_prod,
	id_rev,
	alt_actif,
	id_gti,
	id_four,
	id_methode,
	id_brk,
	id_typ_art,
	id_marq_art,
	id_modl_art,
	dte_deb_eff,
	dte_fin_eff,
	typ_eff,
	typ_mt_pivot,
	httc_pivot,
	mt_pivot,
	typ_vetuste,
	per_cplt,
	per_cplt_ut,
	typ_decote,
	mt_decote,
	httc_decote,
	tx_decote,
	mt_forfaitaire,
	httc_forfait,
	id_four_forfait,
	tx_tva,
	param_cplt,
	cree_le,
	maj_le,
	maj_par
From	sysadm.param_ftu_brk

Insert into sysadm.param_ftu_brk_vts_sv
Select 	@iIdTrt,
	@iIdPeriode,
	id_tarif,
	cpt_vetuste,
	ie_mt_pivot_min,
	mt_pivot_min,
	mt_pivot_max,
	ie_mt_pivot_max,
	periode_min_j,
	periode_max_j,
	tx_reprise,
	cree_le,
	maj_le,
	maj_par
From	sysadm.param_ftu_brk_vts

--------------------------------------
--        E X T R A C T I O N	    --
--------------------------------------
--       Méthode de travail 1&2     --
--------------------------------------
Insert into sysadm.w_cum_ftu_brk (
	id_trt,
	id_periode,
	marquage,
	id_tarif,
	id_prod,
	id_ets,
	id_adh,
	id_sdos,
	id_prod_volc,
	id_sin,
	id_seq,
	id_gti,
	lib_gti,
	cod_etat_dos,
	lib_etat_dos,
	nom_ass,
	prenom_ass,
	marq_app_sin,
	modl_app_sin,
	id_typ_art,
	lib_typ_art,
	num_serie,
	id_brk,
	lib_brk,
	lib_police,
	id_cie,
	lib_cie,
	dte_achat,
	dte_surv,
	dte_rcp_frn,
	app_incomplet,
	cree_le,
	maj_le,
	maj_par
	)
Select  
	@iIdTrt			'id_trt',
	@iIdPeriode 		'id_periode',
	0			'marquage',
	pfb.id_tarif		'id_tarif',
	s.id_prod 		'id_prod',
	s.id_ets		'id_ets',
	s.id_adh		'id_adh',
	s.id_sdos		'id_sdos',
	p.cod_prod_dms 		'id_prod_volc',
	c.id_sin 		'id_sin',
	c.id_seq		'id_seq',
	c.id_gti		'id_gti',
	( Select Top 1 cg.lib_gti
	  From	 sysadm.code_garantie cg
	  Where  cg.id_prod = s.id_prod
	  And    cg.id_gti  = c.id_gti
	) 			'lib_gti',
	s.cod_etat		'cod_etat_dos',
	sysadm.FN_CODE_NUM ( s.cod_etat, '-ET') 
				'lib_etat_dos', 
	( Select Top 1 pe.nom
	  From	 sysadm.personne pe
	  Where  pe.id_ordre = s.id_ordre
	)  			'nom_ass',
	( Select Top 1 pe.prenom
	  From	 sysadm.personne pe
	  Where  pe.id_ordre = s.id_ordre
	)  			'prenom_ass',
	s.marq_port 		'marq_app_sin',
	s.modl_port 		'modl_app_sin',
	ds.val_car		'id_typ_art',
	sysadm.FN_CODE_CAR ( ds.val_car, '-AR' )
				'lib_typ_art',
	s.num_imei_port		'num_serie',
	pfb.id_brk		'id_brk',
	sysadm.FN_CODE_CAR ( pfb.id_brk, '-01' )
				'lib_brk',
	po.lib_police		'lib_police',
	cie.id_cie		'id_cie',
	cie.lib_cie		'lib_cie',
	IsNull ( s.dte_ach_port, 
	  	( Select min ( d.dte_det ) 
		  From 	sysadm.detail d,
		  	sysadm.det_pro dp
		  Where d.id_sin = s.id_sin 
		  And 	dp.id_prod = s.id_prod
		  And   dp.id_code_dp = 42
		  And   dp.id_code_num = c.id_gti
		  And   dp.id_code_car = 'A'
		) )		'dte_achat',
	s.dte_surv		'dte_surv',
	Case pfb.id_methode
		When 1 Then IsNull ( c.dte_rcp_frn, 
					     ( 
						Select 	min ( c2.dte_rcp_frn )
						From   	sysadm.commande c2
						Where	c2.id_sin = c.id_sin
						And	c2.id_four = c.id_four
						And	c2.id_ref_four = 'A_DIAGNOSTIQUER'
					     )
				   )		
	-- [VDOC6449]x2
		When 2 Then Case IsDate ( sysadm.FN_CLE_VAL ( 'DTE_LIVR_SBE',c.info_frn_spb_cplt, ';' ) )
				When 1 Then convert ( Datetime , sysadm.FN_CLE_VAL ( 'DTE_LIVR_SBE',c.info_frn_spb_cplt, ';' ) )
				Else Convert ( Datetime, null )
			    End 
		Else c.dte_rcp_frn
	End 			'dte_rcp_frn',
	IsNull ( ( Select Case 
			When Count ( * ) > 0 Then 1
			Else 0
		 End 
	  From   sysadm.commande c1
	  Where  c1.id_sin = s.id_sin
	  And	 rtrim ( sysadm.FN_CLE_VAL ( 'APP_INCOMPLET',c1.info_frn_spb_cplt, ';' )) = 'OUI' 
	), 0)  			'app_incomplet',
	getdate()		'cree_le',
	getdate()		'maj_le',
	@sCodOper		'maj_par'

From	sysadm.commande c,
	sysadm.sinistre s,
	sysadm.produit p,
	sysadm.div_sin ds,
	sysadm.garantie ga,
	sysadm.police po,
	sysadm.compagnie cie,
	sysadm.param_ftu_brk pfb
	
Where 	( c.id_ref_four = 'PEC_A_RECYCLER'
	  Or
	  (	c.id_ref_four = 'A_RECUP_A_RECYCLER'
	   and	c.status_gc in ( 166, 167 ) 
	  )
	  Or 
	  (     c.id_typ_art = 'AEF' 
	   and  c.status_gc in ( 71, 201, 221, 203 )
	  )
	)
And	c.cod_etat <> 'ANN'
And	s.id_sin = c.id_sin 
And	p.id_prod = s.id_prod
And	ds.id_sin = s.id_sin
And	ds.nom_zone = 'type_app'

And	ga.id_prod = s.id_prod
And	ga.id_rev  = s.id_rev
And     ga.id_gti  = c.id_gti
And     po.id_police = ga.id_police
And     cie.id_cie = po.id_cie
And ga.id_gti not in ( 10, 12 ) --[VDOC20139]

And	pfb.id_prod = s.id_prod
And	( pfb.id_rev = s.id_rev or ( pfb.id_rev = -1 And pfb.id_rev <> s.id_rev ) ) 
And	pfb.alt_actif = 'O'
And	( pfb.id_gti = c.id_gti or ( pfb.id_gti = -1 And pfb.id_gti <> c.id_gti ) )
And	pfb.id_four = c.id_four
And	pfb.id_methode in (1, 2)
And	( pfb.id_typ_art = ds.val_car or ( pfb.id_typ_art = '-1' And pfb.id_typ_art <> ds.val_car ) )
And	( pfb.id_marq_art = s.marq_port or ( pfb.id_marq_art  = '-1' And pfb.id_marq_art <> s.marq_port ))
And	( pfb.id_modl_art = s.modl_port or ( pfb.id_modl_art  = '-1' And pfb.id_modl_art <> s.modl_port ))
And	( 
	 ( pfb.typ_eff = 'DTESRV' And IsNull ( s.dte_surv, pfb.dte_deb_eff ) between pfb.dte_deb_eff and pfb.dte_fin_eff )
	 Or 
	 ( pfb.typ_eff = 'DTERFR' And Case pfb.id_methode
					When 1 Then IsNull ( c.dte_rcp_frn, 
								IsNull ( 
									     ( 
										Select 	min ( c2.dte_rcp_frn )
										From   	sysadm.commande c2
										Where	c2.id_sin = c.id_sin
										And	c2.id_four = c.id_four
										And	c2.id_ref_four = 'A_DIAGNOSTIQUER'
									     ),
									pfb.dte_deb_eff     
									)
							   )
					-- [VDOC6449]x2
					When 2 Then Case IsDate ( sysadm.FN_CLE_VAL ( 'DTE_LIVR_SBE',c.info_frn_spb_cplt, ';' ) )
							When 1 Then convert ( Datetime , sysadm.FN_CLE_VAL ( 'DTE_LIVR_SBE',c.info_frn_spb_cplt, ';' ) )
							Else pfb.dte_deb_eff -- pour au moins ramener l'enrg, le Select mettra null, donc Rejet dans l'agreg
						    End 
					Else c.dte_rcp_frn
				      End
		between pfb.dte_deb_eff and pfb.dte_fin_eff ) 
	)

And	Not Exists 
	( 
	Select 	Top 1 1 
	From	sysadm.div_sin ds2
	Where 	ds2.id_sin = s.id_sin
	And 	ds2.nom_zone in ( 'alim_sin', 'aut_acc_sin', 'batt_sin' )
	And 	ds2.val_car = 'O'
	) 

And 	Not Exists 
	(
	Select 	Top 1 1 
	From	sysadm.div_sin ds2,
		sysadm.commande c2
	Where 	ds2.id_sin = s.id_sin
	And 	ds2.nom_zone in ( 'app_sin' )
	And 	ds2.val_car = 'O'
	And	c2.id_sin = s.id_sin
	And	c2.status_gc = 175
	)

And	Not exists 
	( 
	Select 	Top 1 1 
	From	sysadm.div_sin ds2
	Where	ds2.id_sin = s.id_sin
	And	nom_zone = 'pm02_id_trt'
	) 
	
-- [PM330-1]
And Not Exists 
	(
	Select 	Top 1 1 
	From	sysadm.commande c2
	Where 	c2.id_sin = s.id_sin
	And		c2.id_ref_four in ( 'A_REPARER', 'A_DESOXYDER' )
	)


--------------------------------------
--       Méthode de travail 3       --
--------------------------------------
Insert into sysadm.w_cum_ftu_brk (
	id_trt,
	id_periode,
	marquage,
	id_tarif,
	id_prod,
	id_ets,
	id_adh,
	id_sdos,
	id_prod_volc,
	id_sin,
	id_seq,
	id_gti,
	lib_gti,
	cod_etat_dos,
	lib_etat_dos,
	nom_ass,
	prenom_ass,
	marq_app_sin,
	modl_app_sin,
	id_typ_art,
	lib_typ_art,
	num_serie,
	id_brk,
	lib_brk,
	lib_police,
	id_cie,
	lib_cie,
	dte_achat,
	dte_surv,
	dte_rcp_frn,
	app_incomplet,
	cree_le,
	maj_le,
	maj_par
	)
Select  
	@iIdTrt			'id_trt',
	@iIdPeriode 		'id_periode',
	0			'marquage',
	pfb.id_tarif		'id_tarif',
	s.id_prod 		'id_prod',
	s.id_ets		'id_ets',
	s.id_adh		'id_adh',
	s.id_sdos		'id_sdos',
	p.cod_prod_dms 		'id_prod_volc',
	c.id_sin 		'id_sin',
	c.id_seq		'id_seq',
	c.id_gti		'id_gti',
	( Select Top 1 cg.lib_gti
	  From	 sysadm.code_garantie cg
	  Where  cg.id_prod = s.id_prod
	  And    cg.id_gti  = c.id_gti
	) 			'lib_gti',
	s.cod_etat		'cod_etat_dos',
	sysadm.FN_CODE_NUM ( s.cod_etat, '-ET') 
				'lib_etat_dos', 
	( Select Top 1 pe.nom
	  From	 sysadm.personne pe
	  Where  pe.id_ordre = s.id_ordre
	)  			'nom_ass',
	( Select Top 1 pe.prenom
	  From	 sysadm.personne pe
	  Where  pe.id_ordre = s.id_ordre
	)  			'prenom_ass',
	s.marq_port 		'marq_app_sin',
	s.modl_port 		'modl_app_sin',
	ds.val_car		'id_typ_art',
	sysadm.FN_CODE_CAR ( ds.val_car, '-AR' )
				'lib_typ_art',
	s.num_imei_port		'num_serie',
	pfb.id_brk		'id_brk',
	sysadm.FN_CODE_CAR ( pfb.id_brk, '-01' )
				'lib_brk',
	po.lib_police		'lib_police',
	cie.id_cie		'id_cie',
	cie.lib_cie		'lib_cie',
	IsNull ( s.dte_ach_port, 
	  	( Select min ( d.dte_det ) 
		  From 	sysadm.detail d,
		  	sysadm.det_pro dp
		  Where d.id_sin = s.id_sin 
		  And 	dp.id_prod = s.id_prod
		  And   dp.id_code_dp = 42
		  And   dp.id_code_num = c.id_gti
		  And   dp.id_code_car = 'A'
		) )		'dte_achat',
	s.dte_surv		'dte_surv',
	c.dte_rcp_frn		'dte_rcp_frn',
	IsNull ( ( Select Case 
			When Count ( * ) > 0 Then 1
			Else 0
		 End 
	  From   sysadm.commande c1
	  Where  c1.id_sin = s.id_sin
	  And	 rtrim ( sysadm.FN_CLE_VAL ( 'APP_INCOMPLET',c1.info_frn_spb_cplt, ';' )) = 'OUI' 
	), 0)  			'app_incomplet',
	getdate()		'cree_le',
	getdate()		'maj_le',
	@sCodOper		'maj_par'


From	sysadm.commande c,
	sysadm.sinistre s,
	sysadm.produit p,
	sysadm.div_sin ds,
	sysadm.garantie ga,
	sysadm.police po,
	sysadm.compagnie cie,
	sysadm.param_ftu_brk pfb
Where 	c.id_typ_art = 'PRS'
And	c.cod_etat <> 'ANN'
And	c.status_gc = 21
And   ( 
		  Charindex ( '[BVIE]', c.comment_frn ) > 0 
		  Or 
		  -- [VDOC27123]BVID/BVIP/BVIT
		  Charindex ( '[BVID]', c.comment_frn ) > 0 
		  Or 
		  -- [VDOC27123]BVID/BVIP/BVIT
		  Charindex ( '[BVIP]', c.comment_frn ) > 0 
		  Or 
		  -- [VDOC27123]BVID/BVIP/BVIT
		  Charindex ( '[BVIT]', c.comment_frn ) > 0 
		  Or 
		  (
		   Charindex ( '[BVIEOX]', c.comment_frn ) > 0 
		   And 
		   c.cod_etat = 'RSP'
		   And
		   c.id_four <> 'O2M'  	   --[20120127]
		  )
		  Or 
		  ( 
			--[20120127]
	  		Charindex ( '[BVIEOX]', c.comment_frn ) > 0 
	  		And 
			c.id_four = 'O2M'
			And	not exists ( Select * 
							From   	sysadm.refus r
							where   r.id_sin = c.id_sin
							and     r.id_gti = c.id_gti
							and     r.id_detail = c.id_detail
							)
		   --:[20120127]						
  		   )
  	   )
And	ga.id_prod = s.id_prod
And	ga.id_rev  = s.id_rev
And     ga.id_gti  = c.id_gti
And     po.id_police = ga.id_police
-- [PM02-2] suppression du forçage sur AIG.
-- And	po.id_cie = 6 -- code donné par NC le 14-03-2011
And     cie.id_cie = po.id_cie
And ga.id_gti not in ( 10, 12 ) --[VDOC20139]

And	s.id_sin = c.id_sin
And	p.id_prod = s.id_prod
And	ds.id_sin = s.id_sin
And	ds.nom_zone = 'type_app'

And	pfb.id_prod = s.id_prod
And	( pfb.id_rev = s.id_rev or ( pfb.id_rev = -1 And pfb.id_rev <> s.id_rev ) ) 
And	pfb.alt_actif = 'O'
And	( pfb.id_gti = c.id_gti or ( pfb.id_gti = -1 And pfb.id_gti <> c.id_gti ) )
And	pfb.id_four = c.id_four
And	pfb.id_methode = 3
And	( pfb.id_typ_art = ds.val_car or ( pfb.id_typ_art = '-1' And pfb.id_typ_art <> ds.val_car ) )
And	( pfb.id_marq_art = s.marq_port or ( pfb.id_marq_art  = '-1' And pfb.id_marq_art <> s.marq_port ))
And	( pfb.id_modl_art = s.modl_port or ( pfb.id_modl_art  = '-1' And pfb.id_modl_art <> s.modl_port ))
And	( 
	 ( pfb.typ_eff = 'DTESRV' And IsNull ( s.dte_surv, pfb.dte_deb_eff ) between pfb.dte_deb_eff and pfb.dte_fin_eff )
	 Or 
	 ( pfb.typ_eff = 'DTERFR' And IsNull ( c.dte_rcp_frn, pfb.dte_deb_eff) between pfb.dte_deb_eff and pfb.dte_fin_eff )
	)

And	Not exists 
	( 
	Select 	Top 1 1 
	From	sysadm.div_sin ds
	Where	ds.id_sin = s.id_sin
	And	nom_zone = 'pm02_id_trt'
	)	
-- [PM330-1]
And Not Exists 
	(
	Select 	Top 1 1 
	From	sysadm.commande c2
	Where 	c2.id_sin = s.id_sin
	And		c2.id_ref_four = 'REFUSE_A_REEXP'
	And		c2.cod_etat <> 'ANN'
	)

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_PM02_REJET
-- Auteur               :       FABRY JF
-- Date                 :       19/12/2012
-- Libellé              :        
-- Commentaires         :       [PM02]
-- Références           :       
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_PM02_REJET' AND type = 'P' )
        DROP procedure sysadm.PS_I01_PM02_REJET 
GO

CREATE procedure sysadm.PS_I01_PM02_REJET
	@iIdTrt	    integer,
	@iIdPeriode integer,
	@dcIdProd   decimal (7),
	@dcIdSin    decimal (10),  -- [PI062]
	@sMess      VarChar ( 255 ), 
	@sCodOper   Varchar ( 4 )
	
AS

	Insert into rejet_ftu_brk (
		 id_trt,    
		 id_periode,
		 id_prod,   
		 id_sin,    
		 mess,      
		 cree_le,   
		 maj_le,    
		 maj_par 
	)
	
	Values (
		@iIdTrt,
		@iIdPeriode,
		@dcIdProd,
		@dcIdSin,
		@sMess, 
		Getdate(),
		Getdate(),
		@sCodOper
	)

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_PM02_BATCH_LANCEMENT
-- Auteur               :       FABRY JF
-- Date                 :       19/12/2012
-- Libellé              :        
-- Commentaires         :       [PM02]
-- Références           :       
--
-------------------------------------------------------------------
-- JFF 06/06/2012 [VDOC7722]
-- JFF 27/05/2019 [PM478-1]
-- JFF	10/09/2024   [20240910162546267] Changement chemin UNC Serveur fichier prod
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM02_BATCH_LANCEMENT' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM02_BATCH_LANCEMENT
GO

CREATE procedure sysadm.PS_I_PM02_BATCH_LANCEMENT
AS

Declare	@iIdTrt	    integer
Declare	@iIdTrt2    integer
Declare	@iIdPeriode integer
Declare	@iIdAnnee   integer
Declare	@iIdMois    integer
Declare	@sCodOper   Varchar 
Declare @dcCptVal   Decimal (9)
Declare @sChemin    VarChar ( 255 )
Declare @sFichierFactExcel VarChar ( 255 )
Declare @sFichierFactExcelRequete VarChar ( 255 )
Declare @sFichierVolcanes  VarChar ( 255 )
Declare @sFichierVolcanesRequete VarChar ( 255 )
Declare @sFichierRejetExcel  VarChar ( 255 )
Declare @sFichierRejetExcelRequete VarChar ( 255 )
Declare @sNomServeur VarChar(255)
Declare @sOsqlOption VarChar(255)
Declare @iRetOsql    int	
Declare @sFicOut     VarChar(255)
Declare @sFicOut2    VarChar(255)
Declare @sIdBrk	     VarChar ( 3 )
Declare @iCpt		 Integer
Declare @sBase		 VarChar ( 15 )
Declare @sRequete	 VarChar ( 100 )
Declare @sCommande	 VarChar ( 255 )
Declare @sMessage    Varchar(800)
Declare @sObjet      VarChar(255)
Declare @sRetourErrMail VarChar(255)


DECLARE @tb TABLE 
	( id_brk	Varchar ( 3 ) null ,
	  marquage	integer null 
	)


Set Transaction Isolation level Read UnCommitted

Begin tran
Exec sysadm.PS_X_INCREMENTER 'ID_TRT', @dcCptVal OUTPUT
Commit Tran

Set nocount on

-- Marquage dossiers Maryse
Exec sysadm.PS_I_PM02_REDRESSEMENT_SUR_CONTACT

-- Demande de Sylvie et PGM le 19/12/2011, on fait -1 mois sur la période de lancement
Set @iIdAnnee = Convert ( VarChar ( 4),  Year ( GETDATE()))
Set @iIdMois  = Right ( '0' + Convert ( VarChar ( 2),  month ( GETDATE())), 2 )

If @iIdMois = 1 
 Begin
	Set @iIdMois = 12
	Set @iIdAnnee = @iIdAnnee - 1 
 End 
Else
 Begin
	Set @iIdMois = @iIdMois - 1
 End 

Set @iIdPeriode = Convert ( VarChar ( 4),  @iIdAnnee ) + Right ( '0' + Convert ( VarChar ( 2), @iIdMois ), 2 )
Set @iIdTrt = @dcCptVal

-- Extraction
Exec sysadm.PS_I01_PM02_EXTR @iIdTrt, @iIdPeriode, 'PM02'

-- Agrégation
Exec sysadm.PS_I01_PM02_AGREG @iIdTrt, @iIdPeriode, 'PM02'

-- [VDOC7722] Exclusion doublons sur Marque/modèle <> Pour tout
Exec sysadm.PS_D01_PM02_DOUBLON @iIdTrt, @iIdPeriode, 'PM02'

-------------------------------------
-- Ecrire des fichiers (des états) --
-------------------------------------
Set @iCpt = 1

-- [20240910162546267]
-- Set @sChemin = '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\PM02_Factu_Broker_Reprise_Mat\'
Set @sChemin = sysadm.FN_GET_CHEMIN ( 'SERV_FIC_PROD' ) + 'SIMPA2\XLS\Autres\PM02_Factu_Broker_Reprise_Mat\'

Set @sFichierFactExcel = '[PER]_[ID_TRT]_[BRK]_PM02_Facturation_Reprise_Materiel.xls'

-- [PM478-1]
If sysadm.FN_CLE_NUMERIQUE ( 'PM478-1') > 0 
 Begin
	Set @sFichierFactExcelRequete = 'PS_S01_PM02_FICHIER_SORTIE_XLS_V01'
 End 
Else
 Begin
	Set @sFichierFactExcelRequete = 'PS_S01_PM02_FICHIER_SORTIE_XLS'
 End 


Set @sFichierVolcanes  = '[PER]_[ID_TRT]_PM02_Facturation_Reprise_Materiel_Volcanes.[EXT]'
Set @sFichierVolcanesRequete = 'PS_S01_PM02_FICHIER_SORTIE_VOLCANES'

Set @sFichierRejetExcel  = '[PER]_[ID_TRT]_PM02_Rejets_Infos.xls'
Set @sFichierRejetExcelRequete = 'PS_S01_PM02_FICHIER_REJET'  

Set @sNomServeur = @@servername

-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode
Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO') Set @sBase = 'SIMPA2_PRO' Else Set @sBase = 'SIMPA2_TRT'

While @iCpt <= 3
 Begin
	

	Select @sFicOut = Case @iCpt
				When 1 Then @sChemin + @sFichierFactExcel
				When 2 Then @sChemin + @sFichierVolcanes
				When 3 Then @sChemin + @sFichierRejetExcel
			  End 
			  
	Select @sRequete = Case @iCpt
				When 1 Then @sFichierFactExcelRequete
				When 2 Then @sFichierVolcanesRequete
				When 3 Then @sFichierRejetExcelRequete
			   End 
			   
	Set @sRequete = @sRequete + ' ' + Convert ( VarChar ( 6 ) , @iIdPeriode ) + ', ' + Convert ( VarChar (6), @iIdTrt )

	Set @sFicOut = Replace ( @sFicOut, '[PER]', Convert ( VarChar ( 6 ), @iIdPeriode ) )
	Set @sFicOut = Replace ( @sFicOut, '[ID_TRT]', Convert ( VarChar ( 6 ), @iIdTrt ) )

	If @iCpt = 2
	  Begin
	  	Set @sFicOut = Replace ( @sFicOut, '[EXT]', CHAR ( 64 + Right ( Convert ( VarChar ( 6 ), @iIdPeriode ) , 2 ) )  )
	  End  

	If @iCpt = 1 
	 Begin
		Insert into @tb
		Select  Distinct 
			c.id_brk,
			0
		From	sysadm.cum_ftu_brk c,
			sysadm.produit p
		Where   c.id_periode = @iIdPeriode
		And	c.id_trt = @iIdTrt
		
		While Exists ( Select * From @tb where marquage = 0 )
		 Begin
			Select 	Top 1 
				@sIdBrk = rTrim ( id_brk )
			From	@tb
			Where	marquage = 0

			Set @sFicOut = Replace ( @sFicOut, '[BRK]', @sIdBrk )
			Set @sRequete = @sRequete + ', ''' + @sIdBrk + ''''

			SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
					 @sBase + '.sysadm.' + @sRequete + ' ' + 
					 '" /o' + @sFicOut + ' -w5000' + @sOsqlOption

			EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

			Update @tb
			Set marquage = 1
			Where id_brk = @sIdBrk
		 End

	 End 
	Else
	 Begin
		SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
				 @sBase + '.sysadm.' + @sRequete + ' ' + 
				 '" /o' + @sFicOut + ' -w5000' + @sOsqlOption
				 
		EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output	
	 End

	Set @iCpt = @iCpt + 1

 End 

Set @sObjet = 'Traitement PM02 Terminé : Traitement n°' + CONVERT ( Varchar ( 6 ), @iIdTrt ) + ' (période à titre indicatif : ' + CONVERT ( Varchar ( 6 ), @iIdPeriode ) + ')' 
Set @sMessage  = @sObjet 
Set @sMessage  = @sMessage + CHAR ( 13 ) +  CHAR ( 13 ) 
Set @sMessage  = @sMessage + 'Les fichiers sont disponibles sur ' + @sChemin
Set @sMessage  = @sMessage + CHAR ( 13 ) +  CHAR ( 13 ) 
Set @sMessage  = @sMessage + 'Pour rappel, les traitements issus du PM02 sont sauvegardés, ils pourront donc être ressortis à l''identique pour un numéro de traitement donné (pas de gestion de période sur le PM02).'

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'ETHEVENON@spb.eu,JFF@spb.eu,fluxfidis@spb.eu',
--		'JFF@spb.eu',
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut2, 
		NULL, 
		NULL, 
		NULL, 
		NULL


-- Suite problème détecté par JF, alerte vers Aurélien et JF
Select id_sin, id_trt, COUNT(*) 
from   sysadm.cum_ftu_brk
Where  mt_forfait_ht = 0
And    id_trt = @iIdTrt
And    id_periode = @iIdPeriode
Group by id_sin, id_trt
having COUNT(*)	> 1
-- !! Ne rien mettre entre la fin du select et le test du @@Rowcount !!!!!
If @@ROWCOUNT > 0 
 Begin 
  EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'JFF@spb.eu',
		'Select id_sin, id_trt, COUNT(*) from cum_ftu_brk Where mt_forfait_ht = 0 Group by id_sin, id_trt having COUNT(*) > 1', 
		'PM02 Doublons !', 
		'', 
		'', 
		@sFicOut2, 
		NULL, 
		NULL, 
		NULL, 
		NULL
 End 

Set nocount off

Go

grant execute on sysadm.PS_I_PM02_BATCH_LANCEMENT to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_PM02_REDRESSEMENT_SUR_CONTACT
-- Auteur               :       FABRY JF
-- Date                 :       19/12/2012
-- Libellé              :        
-- Commentaires         :       [PM02]
-- Références           :       
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF	    05/01/2017   [VDOC25312]
-- JFF      21/11/2018   [VDOC27123]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM02_REDRESSEMENT_SUR_CONTACT' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM02_REDRESSEMENT_SUR_CONTACT
GO

CREATE procedure sysadm.PS_I_PM02_REDRESSEMENT_SUR_CONTACT
AS

Set Transaction Isolation level Read UnCommitted

DECLARE @tb601 TABLE 
	( id_sin	decimal ( 10 )	null, -- [PI062]
	  periode	integer  null,
	  marquage	integer  null
	)

Declare @dcIdSin 	decimal ( 10 ), -- [PI062]
	@iIdPeriode	integer

If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin 
		Insert into @tb601
		Select  distinct 
			c.id_sin, 
			Convert ( VarChar ( 4),  Year ( cree_le)) + Right ( '0' + Convert ( VarChar ( 2),  month ( cree_le)), 2 ) 'periode',
			0 'marquage'
		From	SHERPA_PRO.sysadm.contact c
		Where   id_nat_tache = 601
		And 	Not Exists ( 
				Select 	*
				From   	sysadm.div_sin ds
				Where  	ds.id_sin = c.id_sin
				And	ds.nom_zone = 'pm02_id_trt'
				  )
	End
Else
	Begin 
		Insert into @tb601
		Select  distinct 
			id_sin, 
			Convert ( VarChar ( 4),  Year ( cree_le)) + Right ( '0' + Convert ( VarChar ( 2),  month ( cree_le)), 2 ) 'periode',
			0 'marquage'
		From	SHERPA_SIM.sysadm.contact c
		Where   id_nat_tache = 601
		And 	Not Exists ( 
				Select 	*
				From   	sysadm.div_sin ds
				Where  	ds.id_sin = c.id_sin
				And	ds.nom_zone = 'pm02_id_trt'
				  )

	End	

-- Demande Nathalie Coignet Mail du 18/10/2011
Insert into @tb601
Select distinct 
       c.id_sin,
       Convert ( VarChar ( 4),  Year ( c.cree_le)) + Right ( '0' + Convert ( VarChar ( 2),  month ( c.cree_le)), 2 ) 'periode',
       0 'marquage'
From	sysadm.sinistre s,
		sysadm.commande c,
		sysadm.div_sin ds,
		sysadm.garantie ga,
		sysadm.police po
Where   c.id_typ_art = 'PRS'
And		c.cod_etat <> 'ANN'
And		c.id_four in ( 'ANV', 'COR', 'SBE' )
And     c.cree_le < '01/01/2009'
And		c.status_gc = 21
And 	( Charindex ( '[BVIE]', c.comment_frn ) > 0 
		  Or 
		  -- [VDOC27123]BVID/BVIP/BVIT
		  Charindex ( '[BVID]', c.comment_frn ) > 0 
		  Or 
		  -- [VDOC27123]BVID/BVIP/BVIT
		  Charindex ( '[BVIP]', c.comment_frn ) > 0 
		  Or 
		  -- [VDOC27123]BVID/BVIP/BVIT
		  Charindex ( '[BVIT]', c.comment_frn ) > 0 
		  Or 
		  (
		   Charindex ( '[BVIEOX]', c.comment_frn ) > 0 
		   And 
		   c.cod_etat = 'RSP'
		  )
		)
And		s.id_sin   = c.id_sin
And		ga.id_prod = s.id_prod
And		ga.id_rev  = s.id_rev
And     ga.id_gti  = c.id_gti
And     po.id_police = ga.id_police
And		po.id_cie = 6 -- code donné par NC le 14-03-2011
And		ds.id_sin = s.id_sin
And		ds.nom_zone = 'type_app'
And 	ds.val_car = 'TEL'
and		Not exists ( Select * From @tb601 t Where t.id_sin = c.id_sin )
And 	Not Exists ( 
				Select 	*
				From   	sysadm.div_sin ds
				Where  	ds.id_sin = c.id_sin
				And	ds.nom_zone = 'pm02_id_trt'
				  )


-- Demande Nathalie Coignet Mail du 18/10/2011
Insert into @tb601
Select distinct 
       c.id_sin,
       Convert ( VarChar ( 4),  Year ( c.cree_le)) + Right ( '0' + Convert ( VarChar ( 2),  month ( c.cree_le)), 2 ) 'periode',
       0 'marquage'
From	sysadm.sinistre s,
		sysadm.commande c,
		sysadm.div_sin ds,
		sysadm.garantie ga,
		sysadm.police po
Where   c.id_ref_four = 'PEC_A_RECYCLER'
And		c.cod_etat <> 'ANN'
And		c.id_four = 'O2M'
And     c.cree_le < '01/01/2009'
And		ga.id_prod = s.id_prod
And		ga.id_rev  = s.id_rev
And     ga.id_gti  = c.id_gti
And     po.id_police = ga.id_police
And		po.id_cie = 6 -- code donné par NC le 14-03-2011
And		ds.id_sin = c.id_sin
And		ds.nom_zone = 'type_app'
And 	ds.val_car = 'TEL'	
and		Not exists ( Select * From @tb601 t Where t.id_sin = c.id_sin )
And 	Not Exists ( 
				Select 	*
				From   	sysadm.div_sin ds
				Where  	ds.id_sin = c.id_sin
				And	ds.nom_zone = 'pm02_id_trt'
				  )

-- Demande suite réunion Mail du 25/11/2011
-- On exclut les dossiers ayant
-- une prestation REFUS_A_REEXP en status 155 
-- ET une prestation PEC_A_RECYCLER
-- ET que la séquence de la prestation à REFUS_A_REEXP soit plus grande que la séquence de la presta PEC_A_RECYCLER
-- ET qu'il n'existe pas de prestation de ( DIAGNOSTIC ou PEC_RECYCLER ) de séquence supérieure à celle de la presta REFUS_A_REEXP
Insert into @tb601
Select distinct 
       c.id_sin,
       Convert ( VarChar ( 4),  Year ( c1.cree_le)) + Right ( '0' + Convert ( VarChar ( 2),  month ( c1.cree_le)), 2 ) 'periode',
       0 'marquage'
From	sysadm.commande c,
		sysadm.commande c1
Where	c.id_ref_four = 'PEC_A_RECYCLER'
And		c.cod_etat <> 'ANN'
And		c1.id_sin = c.id_sin
And		c1.id_ref_four = 'REFUSE_A_REEXP'
And		c1.cod_etat <> 'ANN'
-- [VDOC25312]
And		c1.status_gc > 0 -- = 155
And     c1.id_seq > c.id_seq
And		Not exists ( 
				Select * 
				From sysadm.commande c2
				Where c2.id_sin = c.id_sin
				And	c2.id_ref_four in ( 'A_DIAGNOSTIQUER',  'PEC_A_RECYCLER' )
				And	c2.cod_etat <> 'ANN'
				And c2.id_seq > c1.id_seq
				) 				
and		Not exists ( Select * From @tb601 t Where t.id_sin = c.id_sin )
And 	Not Exists ( 
				Select 	*
				From   	sysadm.div_sin ds
				Where  	ds.id_sin = c.id_sin
				And	ds.nom_zone = 'pm02_id_trt'
				  )

-- Boucle de traitement
While Exists ( Select * From @tb601 where marquage = 0 )
 Begin
	Select 	Top 1 
		@dcIdSin = id_sin,
		@iIdPeriode = periode
	From	@tb601
	Where	marquage = 0

	If Not Exists ( 
			Select 	*
			From   	sysadm.div_sin ds
			Where  	ds.id_sin = @dcIdSin
			And	ds.nom_zone = 'pm02_id_trt'
		      )
		Begin 
			Insert into sysadm.div_sin 
			Select
				@dcIdSin,
				'pm02_id_trt',
				'Id_Trt Marquage extract. PM02',
				'-1',
				'N',
				'N',
				'O',
				'O',
				500,
				-1,
				null,
				null,
				null, 
				getdate(),
				getdate(),
				'PM02',
				getdate(),
				'PM02'
			From 	sysadm.sinistre
			Where   id_sin = @dcIdSin
		End

	If Not Exists ( 
			Select 	*
			From   	sysadm.div_sin ds
			Where  	ds.id_sin = @dcIdSin
			And	ds.nom_zone = 'pm02_id_periode'
		      )
	
		Begin 
			Insert into sysadm.div_sin 
			Select
				@dcIdSin,
				'pm02_id_periode',
				'Id_Periode Marquage extract. PM02',
				'-1',
				'N',
				'N',
				'O',
				'O',
				501,
				@iIdPeriode,
				null,
				null,
				null,
				getdate(),
				getdate(),
				'PM02',
				getdate(),
				'PM02'
			From 	sysadm.sinistre
			Where   id_sin = @dcIdSin
		End


	-- Marquage de cet enrg comme étant traité dans la table de travail
	Update @tb601
	Set marquage = 1
	Where id_sin = @dcIdSin
 End
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_PM02_FICHIER_REJET
-- Auteur               :       FABRY JF
-- Date                 :       19/12/2012
-- Libellé              :        
-- Commentaires         :       [PM02]
-- Références           :       
--
-------------------------------------------------------------------


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_PM02_FICHIER_REJET' AND type = 'P' )
        DROP procedure sysadm.PS_S01_PM02_FICHIER_REJET
GO

CREATE procedure sysadm.PS_S01_PM02_FICHIER_REJET
	@iIdPeriode integer,
	@iIdTrt integer
AS

Set nocount on
Select 
	id_cle,
	id_trt,
	id_periode,
	id_prod,
	id_sin,
	mess,
	Convert ( VarChar ( 10 ), cree_le, 103 ) cree_le,
	Convert ( VarChar ( 10 ), maj_le, 103) maj_le,	
	maj_par
	
From	sysadm.rejet_ftu_brk
Where   id_periode = @iIdPeriode
And	id_trt = @iIdTrt

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_PM02_FICHIER_SORTIE_VOLCANES
-- Auteur               :       FABRY JF
-- Date                 :       19/12/2012
-- Libellé              :        
-- Commentaires         :       [PM02]
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_PM02_FICHIER_SORTIE_VOLCANES' AND type = 'P' )
        DROP procedure sysadm.PS_S01_PM02_FICHIER_SORTIE_VOLCANES 
GO

CREATE procedure sysadm.PS_S01_PM02_FICHIER_SORTIE_VOLCANES
	@iIdPeriode integer,
	@iIdTrt integer
AS

Set nocount on
Select  'S2' +
	Right ( replicate ( '0', 8   ) + Convert ( Varchar ( 8   ), IsNull ( c.id_trt		, 0) ), 8    ) +
	Right ( replicate ( '0', 6   ) + Convert ( Varchar ( 6   ), IsNull ( c.id_periode		, 0) ), 6    ) +
	Right ( replicate ( '0', 8   ) + Convert ( Varchar ( 8   ), IsNull ( c.id_tarif		, 0) ), 8    ) +
	Left  ( IsNull ( p.lib_long		, '') + replicate ( ' ', 65 ), 65  ) +
	Right ( replicate ( '0', 10  ) + Convert ( Varchar ( 10  ), IsNull ( c.id_prod		, 0) ), 10   ) +
	Right ( replicate ( '0', 10  ) + Convert ( Varchar ( 10  ), IsNull ( c.id_ets		, 0) ), 10   ) +
	Right ( replicate ( '0', 7  )  +                            IsNull ( c.id_adh		, '0'), 7    ) +	
	Right ( replicate ( '0', 2   ) + Convert ( Varchar ( 2   ), IsNull ( c.id_sdos		, 0) ), 2    ) +
	Right ( replicate ( '0', 5   ) + Convert ( Varchar ( 5   ), IsNull ( c.id_prod_volc	, 0) ), 5   ) +
	Right ( replicate ( '0', 10  ) + Convert ( Varchar ( 10  ), IsNull ( c.id_sin		, 0) ), 10   ) +
	Right ( replicate ( '0', 1   ) + Convert ( Varchar ( 1   ), IsNull ( c.id_seq		, 0) ), 1    ) +
	Right ( replicate ( '0', 6   ) + Convert ( Varchar ( 6   ), IsNull ( c.id_gti		, 0) ), 6    ) +
	Left  ( IsNull ( c.lib_gti		, '') + replicate ( ' ', 35  ), 35  ) +
	Right ( replicate ( '0', 6   ) + Convert ( Varchar ( 6   ), IsNull ( c.cod_etat_dos	, 0) ), 6    ) +
	Left  ( IsNull ( c.lib_etat_dos		, '') + replicate ( ' ', 35  ), 35  ) +
	Left  ( IsNull ( c.nom_ass		, '') + replicate ( ' ', 35  ), 35  ) +
	Left  ( IsNull ( c.prenom_ass		, '') + replicate ( ' ', 35  ), 35  ) +
	Left  ( IsNull ( c.marq_app_sin		, '') + replicate ( ' ', 35  ), 35  ) +
	Left  ( IsNull ( c.modl_app_sin		, '') + replicate ( ' ', 35  ), 35  ) +	
	Left  ( IsNull ( c.id_typ_art		, '') + replicate ( ' ', 6   ), 6   ) +	
	Left  ( IsNull ( c.lib_typ_art		, '') + replicate ( ' ', 35  ), 35  ) +	
	Left  ( IsNull ( c.num_serie		, '') + replicate ( ' ', 60  ), 60  ) +	
	Left  ( IsNull ( c.id_brk		, '') + replicate ( ' ', 6   ), 6   ) +	
	Left  ( IsNull ( c.lib_brk		, '') + replicate ( ' ', 35  ), 35  ) +	
	Left  ( IsNull ( c.lib_police		, '') + replicate ( ' ', 35  ), 35  ) +	
	Right ( replicate ( '0', 6   ) + Convert ( Varchar ( 6   ), IsNull ( c.id_cie		, 0) ), 6    ) +
	Left  ( IsNull ( c.lib_cie		, '') + replicate ( ' ', 35  ), 35  ) +	

	Right ( replicate ( '0', 4   ) + IsNull ( Convert ( VarChar ( 4 ), Year  ( c.dte_achat ) ), '0000' ) , 4 )  +
	Right ( replicate ( '0', 2   ) + IsNull ( Convert ( VarChar ( 2 ), month ( c.dte_achat ) ), '00'   ) , 2 )  +
	Right ( replicate ( '0', 2   ) + IsNull ( Convert ( VarChar ( 2 ), day   ( c.dte_achat ) ), '00'   ) , 2 )  +

	Right ( replicate ( '0', 4   ) + IsNull ( Convert ( VarChar ( 4 ), Year  ( c.dte_surv  ) ), '0000' ) , 4 )  +
	Right ( replicate ( '0', 2   ) + IsNull ( Convert ( VarChar ( 2 ), month ( c.dte_surv  ) ), '00'   ) , 2 )  +
	Right ( replicate ( '0', 2   ) + IsNull ( Convert ( VarChar ( 2 ), day   ( c.dte_surv  ) ), '00'   ) , 2 )  +

	Right ( replicate ( '0', 4   ) + IsNull ( Convert ( VarChar ( 4 ), Year  ( c.dte_rcp_frn ) ), '0000' ) , 4 )  +
	Right ( replicate ( '0', 2   ) + IsNull ( Convert ( VarChar ( 2 ), month ( c.dte_rcp_frn ) ), '00'   ) , 2 )  +
	Right ( replicate ( '0', 2   ) + IsNull ( Convert ( VarChar ( 2 ), day   ( c.dte_rcp_frn ) ), '00'   ) , 2 )  +

	Right ( replicate ( '0', 12  ) + Replace ( Convert ( VarChar ( 12   ), IsNull ( c.mt_forfait_ht, 0 )), '.', ''), 12   )  + 
	Left  ( IsNull ( c.id_four_forfait	, '') + replicate ( ' ', 6   ), 6   ) +	
	Right ( replicate ( '0', 12  ) + Replace ( Convert ( VarChar ( 12   ), IsNull ( c.mt_unitaire_ht, 0 )), '.', ''), 12   )  + 
	Right ( replicate ( '0', 12  ) + Replace ( Convert ( VarChar ( 12   ), IsNull ( c.mt_base_ttc, 0 )), '.', ''), 12   )  + 
	Left  ( IsNull ( c.typ_decote		, '') + replicate ( ' ', 6   ), 6   ) +	
	Right ( replicate ( '0', 12  ) + Replace ( Convert ( VarChar ( 12   ), IsNull ( c.tx_decote, 0 )), '.', ''), 12   )  + 
	Right ( replicate ( '0', 12  ) + Replace ( Convert ( VarChar ( 12   ), IsNull ( c.mt_decote_ttc, 0 )), '.', ''), 12   )  + 
	Right ( replicate ( '0', 12  ) + Replace ( Convert ( VarChar ( 12   ), IsNull ( c.tx_tva, 0 )), '.', ''), 12   )  + 
	Right ( replicate ( '0', 12  ) + Replace ( Convert ( VarChar ( 12   ), IsNull ( c.mt_base_decote_ttc, 0 )), '.', ''), 12   )  + 
	Right ( replicate ( '0', 12  ) + Replace ( Convert ( VarChar ( 12   ), IsNull ( c.mt_base_ht, 0 )), '.', ''), 12   )  + 
	Right ( replicate ( '0', 12  ) + Convert ( VarChar ( 12   ), IsNull ( c.vetuste_j, 0 )), 12   )  + 
	Right ( replicate ( '0', 12  ) + Replace ( Convert ( VarChar ( 12   ), IsNull ( c.tx_coef_vetuste, 0 )), '.', ''), 12   )  + 
	Right ( replicate ( '0', 12  ) + Replace ( Convert ( VarChar ( 12   ), IsNull ( c.mt_fact_ht, 0 )), '.', ''), 12   )  + 
	Right ( replicate ( '0', 12  ) + Replace ( Convert ( VarChar ( 12   ), IsNull ( c.mt_tva, 0 )), '.', ''), 12   )  + 
	Right ( replicate ( '0', 12  ) + Replace ( Convert ( VarChar ( 12   ), IsNull ( c.mt_fact_ttc, 0 )), '.', ''), 12   )  + 
	replicate ( ' ', 1    ) +
	replicate ( '0', 12   ) +
	replicate ( ' ', 255  ) +
	replicate ( '0', 12   ) +
	replicate ( ' ', 255  )

From	sysadm.cum_ftu_brk c,
	sysadm.produit p
Where   c.id_periode = @iIdPeriode
And	c.id_trt = @iIdTrt
And	p.id_prod = c.id_prod
Order by c.id_periode, c.id_trt, c.id_brk, c.id_sin, c.mt_forfait_ht


Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_PM02_FICHIER_SORTIE_XLS
-- Auteur               :       FABRY JF
-- Date                 :       19/12/2012
-- Libellé              :        
-- Commentaires         :       [PM02]
-- Références           :       
--
-------------------------------------------------------------------
-- JFF      27/05/2019   [PM478-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_PM02_FICHIER_SORTIE_XLS_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S01_PM02_FICHIER_SORTIE_XLS_V01 
GO

CREATE procedure sysadm.PS_S01_PM02_FICHIER_SORTIE_XLS_V01
	@iIdPeriode integer,
	@iIdTrt integer,
	@iIdFour VarChar ( 3 )
AS

Set nocount on
Select 
    c.id_cum, -- [PM478-1] Ajout
	'S2' id_orig,
	c.id_trt,
	c.id_periode,
	c.id_tarif,
	p.lib_long lib_prod,
	c.id_prod,
	c.id_ets,
	c.id_adh,
	c.id_sdos,
	c.id_prod_volc,
	c.id_sin,
	c.id_seq,
	c.id_gti,
	c.lib_gti,
	c.cod_etat_dos,
	c.lib_etat_dos,
	c.nom_ass,
	c.prenom_ass,
	c.marq_app_sin,
	c.modl_app_sin,
	c.id_typ_art,
	c.lib_typ_art,
	'''' + c.num_serie + '''' num_serie,
	c.id_brk,
	c.lib_brk,
	c.lib_police,
	c.id_cie,
	c.lib_cie,
	Convert ( VarChar ( 10 ), c.dte_achat, 103 ) dte_achat,
	Convert ( VarChar ( 10 ), c.dte_surv, 103 ) dte_surv,
	Convert ( VarChar ( 10 ), c.dte_rcp_frn, 103 ) dte_rcp_frn,
	c.mt_forfait_ht,
	c.id_four_forfait,
	c.mt_unitaire_ht,
	c.mt_base_ttc,
	c.typ_decote,
	c.tx_decote,
	c.mt_decote_ttc,
	c.tx_tva,
	c.mt_base_decote_ttc,
	c.mt_base_ht,
	c.vetuste_j,
	c.tx_coef_vetuste,
	c.mt_fact_ht,
	c.mt_tva,
	c.mt_fact_ttc,
	IsNull ( c.accord_brk, '') accord_brk, -- [PM478-1]
	IsNull ( c.mt_fact_ttc_modif_brk, 0 ) mt_facture_ttc_modifie_par_brk, -- [PM478-1]
	IsNull ( c.comment_brk, '' ) comment_brk, -- [PM478-1]
	IsNull ( c.mt_fact_ttc_force_spb, 0 ) mt_facture_ttc_force_spb, -- [PM478-1]
	IsNull ( c.comment_spb, '' ) comment_spb -- [PM478-1]
	
	/* [PM478-1] (avant)
	'' accord_brk,
	0  mt_facture_ttc_modifie_par_brk,
	'' comment_brk,
	0  mt_facture_ttc_force_spb,
	'' comment_spb
	*/

From	sysadm.cum_ftu_brk c,
	sysadm.produit p
Where   c.id_periode = @iIdPeriode
And	c.id_trt = @iIdTrt
And 	c.id_brk = @iIdFour
And	p.id_prod = c.id_prod

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S02_PM02_FICHIER_SORTIE_XLS
-- Auteur               :       FABRY JF
-- Date                 :       28/05/2019
-- Libellé              :        
-- Commentaires         :       [PM02][PM478-1]
-- Références           :       
--
-------------------------------------------------------------------
-- JFF      27/05/2019   [PM478-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_PM02_FICHIER_SORTIE_XLS' AND type = 'P' )
        DROP procedure sysadm.PS_S02_PM02_FICHIER_SORTIE_XLS 
GO

CREATE procedure sysadm.PS_S02_PM02_FICHIER_SORTIE_XLS
	@dtDteDebBidon DateTime, -- Pour fonctionner avec le TRT sur DDE.
	@iIdPeriode integer
AS

Set nocount on
Select 
    c.id_cum, -- [PM478-1] Ajout
	'S2' id_orig,
	c.id_trt,
	c.id_periode,
	c.id_tarif,
	p.lib_long lib_prod,
	c.id_prod,
	c.id_ets,
	c.id_adh,
	c.id_sdos,
	c.id_prod_volc,
	c.id_sin,
	c.id_seq,
	c.id_gti,
	c.lib_gti,
	c.cod_etat_dos,
	c.lib_etat_dos,
	c.nom_ass,
	c.prenom_ass,
	c.marq_app_sin,
	c.modl_app_sin,
	c.id_typ_art,
	c.lib_typ_art,
	'''' + c.num_serie + '''' num_serie,
	c.id_brk,
	c.lib_brk,
	c.lib_police,
	c.id_cie,
	c.lib_cie,
	Convert ( VarChar ( 10 ), c.dte_achat, 103 ) dte_achat,
	Convert ( VarChar ( 10 ), c.dte_surv, 103 ) dte_surv,
	Convert ( VarChar ( 10 ), c.dte_rcp_frn, 103 ) dte_rcp_frn,
	c.mt_forfait_ht,
	c.id_four_forfait,
	c.mt_unitaire_ht,
	c.mt_base_ttc,
	c.typ_decote,
	c.tx_decote,
	c.mt_decote_ttc,
	c.tx_tva,
	c.mt_base_decote_ttc,
	c.mt_base_ht,
	c.vetuste_j,
	c.tx_coef_vetuste,
	c.mt_fact_ht,
	c.mt_tva,
	c.mt_fact_ttc,
	IsNull ( c.accord_brk, '') accord_brk, -- [PM478-1]
	IsNull ( c.mt_fact_ttc_modif_brk, 0 ) mt_facture_ttc_modifie_par_brk, -- [PM478-1]
	IsNull ( c.comment_brk, '' ) comment_brk, -- [PM478-1]
	IsNull ( c.mt_fact_ttc_force_spb, 0 ) mt_facture_ttc_force_spb, -- [PM478-1]
	IsNull ( c.comment_spb, '' ) comment_spb -- [PM478-1]
	
	/* [PM478-1] (avant)
	'' accord_brk,
	0  mt_facture_ttc_modifie_par_brk,
	'' comment_brk,
	0  mt_facture_ttc_force_spb,
	'' comment_spb
	*/

From	sysadm.cum_ftu_brk c,
	sysadm.produit p
Where   c.id_periode = @iIdPeriode
And	p.id_prod = c.id_prod

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_U_PM02_PM478_MAJ_CUM_FTU_BRK
-- Auteur               :       FABRY JF
-- Date                 :       27/05/2019
-- Libellé              :        
-- Commentaires         :       [PM02][PM478-1]
-- Références           :       
--
-------------------------------------------------------------------
-- JFF      27/05/2019   [PM478-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_PM02_PM478_MAJ_CUM_FTU_BRK' AND type = 'P' )
        DROP procedure sysadm.PS_U_PM02_PM478_MAJ_CUM_FTU_BRK 
GO

CREATE procedure sysadm.PS_U_PM02_PM478_MAJ_CUM_FTU_BRK
	@aiIdCum integer,
	@aiIdTrt integer,
	@aiIdPeriode integer,
	@adcIdSin decimal ( 10 ),
	@aiIdSeq integer,
	@asAccordBrk VarChar ( 1 ),
	@adcMtFactTtcModifBrk Decimal ( 11,2 ),
	@asCommentBrk VarChar ( 100 ),
	@adcMtFactTtcForceSPB Decimal ( 11,2 ),
	@asCommentSPB VarChar ( 100 ),
	@asIdOper varchar ( 4 ),
	@asResult varchar ( 255 ) OUTPUT
AS

If Not exists ( 
	Select Top 1 1 
	From   sysadm.cum_ftu_brk c
	Where  c.id_cum = @aiIdCum
	And    c.id_trt = @aiIdTrt
	And    c.id_periode = @aiIdPeriode
	And    c.id_sin = @adcIdSin
	And    c.id_seq	= @aiIdSeq
)
  Begin
	Set @asResult = 'ERREUR : les 5 données permettant d''identifier la ligne à modifier, ne trouvent aucune correspondance en base.'
	Return -1
  End 

  Update sysadm.cum_ftu_brk
  Set	 accord_brk = @asAccordBrk,
		 mt_fact_ttc_modif_brk = @adcMtFactTtcModifBrk,
		 comment_brk = @asCommentBrk,
		 mt_fact_ttc_force_spb = @adcMtFactTtcForceSPB,
		 comment_spb = @asCommentSPB,
		 maj_le = getdate(),
		 maj_par = @asIdOper
  Where	 id_cum = @aiIdCum

  If @@ROWCOUNT <> 1 
    Begin
		Set @asResult = 'ERREUR : Problème de mise à jour en base, les données ne sont pas écrites.'
		Return -1
	End 

Return 1
Go
