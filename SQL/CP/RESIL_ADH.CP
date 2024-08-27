-------------------------------------------------------------------
--
-- Fichier              :       RESIL_ADH.CP
-- Auteur               :       FABRY JF
-- Date                 :       10/11/2014
--
-- Commentaires         :       
--
-- sysadm.PS_S_RESIL_ADH_ECR_FIC
-- sysadm.PS_I_RESIL_ADH_SAGA2
-- sysadm.PS_I_RESIL_ADH_V01
-- sysadm.PS_S_RESIL_ADH_V01
--------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_RESIL_ADH
-- Auteur               :       FABRY JF
-- Date                 :       06/10/2014
-- Libellé              :        
-- Commentaires         :       [PC801-5]
-- Références           :       
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      24/04/2020   [DT472]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_RESIL_ADH_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_RESIL_ADH_V01
GO

CREATE procedure sysadm.PS_I_RESIL_ADH_V01
        @dcIdSin       decimal ( 10, 0 ), -- [PI062]
		@sCauseResil   VarChar ( 255 ),
		@sCodOper	   VarChar ( 4 ),
		@dtDteSurv     DateTime, -- [DT472]
		@dcIdGti	   decimal ( 7 ), -- [DT472]
		@dcIdNatSin    decimal ( 7 ), -- [DT472]
		@iIdCodResilAdh Integer -- [DT472]
AS

Declare @dcIdProd	Decimal ( 7 )
Declare @dcIdProdDms	Decimal ( 3 )
Declare @dcIdEts	Decimal ( 7 )
Declare @sIdAdh		VarChar ( 19 )
Declare @dcIdDos	Decimal ( 2 )


select 	@dcIdProdDms = p.cod_prod_dms,
		@dcIdProd = s.id_prod ,
		@dcIdEts = s.id_ets,
		@sIdAdh = s.id_adh,
		@dcIdDos = s.id_sdos
From 	sysadm.sinistre s,
		sysadm.produit p
Where 	s.id_sin = @dcIdSin
And 	p.id_prod = s.id_prod 

Insert into sysadm.resil_adh
	(  
		id_sin,
		id_prod_sin, 
		id_prod_dms, 
		id_ets,      
		id_adh,      
		id_sdos,     
		motif_resil, 
		alt_genfic,  
		cree_le,     
		maj_le,      
		maj_par,
		cod_resil_adh, -- [DT472]
		dte_surv      -- [DT472]
	)

Values 
	(
	   @dcIdSin,
	   @dcIdProd,
	   @dcIdProdDms,
	   @dcIdEts,
	   @sIdAdh,
	   @dcIdDos,
	   @sCauseResil,
	   'N' ,
	   GetDate (),
	   GetDate (),
	   @sCodOper,
	   @iIdCodResilAdh,
	   convert ( varchar(10), @dtDteSurv, 112 ) 
        )

Update sysadm.w_div_sin
set    val_car = 'N'
Where  id_sin = @dcIdSin
And	   nom_zone = 'resil_auto_adh'

Update sysadm.div_sin
set    val_car = 'N'
Where  id_sin = @dcIdSin
And	   nom_zone = 'resil_auto_adh'
       
Go



--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RESIL_ADH
-- Auteur               :       FABRY JF
-- Date                 :       06/10/2014
-- Libellé              :        
-- Commentaires         :       [PC801-5]
-- Références           :       
--
-- JFF      12/02/2016   [PI062]
-- JFF      22/04/2020   [DT472]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RESIL_ADH_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S_RESIL_ADH_V01
GO

CREATE procedure sysadm.PS_S_RESIL_ADH_V01
AS
Set NoCount On
/*
			RIGHT ( '0000' + CONVERT (varchar(4),DatePart(year,getdate())   ),  4 )   + 
			RIGHT ( '00' + CONVERT (varchar(2),DatePart(month,getdate()) ),  2 )    + 
			RIGHT ( '00' + CONVERT (varchar(2),DatePart(day,getdate())   ),  2 )+ ' '    
*/

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin
	Select  Right ( Replicate ('0', 10 ) + LTRIM ( Convert ( Varchar (50), radh.id_sin )) , 10 ) + -- [PI062]
			Right ( Replicate ('0', 6 ) + LTRIM ( Convert ( Varchar (50), radh.id_prod_sin )), 6 ) +
			Right ( Replicate ('0', 4 ) + LTRIM ( Convert ( Varchar (50), radh.id_prod_dms )), 4 ) +
			Right ( Replicate ('0', 5 ) + LTRIM ( Convert ( Varchar (50), radh.id_ets )), 5 ) +
			Right ( Replicate ('0', 19 ) + LTRIM ( radh.id_adh ), 19 ) +
			Right ( Replicate ('0', 1 ) + LTRIM ( Convert ( Varchar (50), radh.id_sdos )), 1 ) +
			Left ( LTRIM ( Convert ( Varchar (100), Left ( radh.motif_resil, 100 ) )) + Replicate (' ', 100 ) , 100 ) +	
			convert ( varchar(8), GETDATE(), 112 ) + 
			IsNull ( convert ( varchar(8), radh.dte_surv, 112 ), space ( 8 ) ) +  -- [DT472]
			IsNull ( Right ( Replicate ('0', 5 ) + LTRIM ( radh.cod_resil_adh ), 5 ), space ( 5 ) ) + ' '  -- [DT472]

		From	sysadm.resil_adh radh,
			SHERPA_PRO.sysadm.sinistre s with (nolock) ,
			SHERPA_PRO.sysadm.adhesion a with (nolock),
			SHERPA_PRO.sysadm.det_pro dp with (nolock)
		Where  	radh.alt_genfic = 'N'
		And 	s.id_sin = radh.id_sin
		And		s.id_appli = 2
		And 	s.id_cli = a.id_cli
		And 	LTRIM ( s.id_adh ) = LTRIM ( Convert ( varchar ( 19 ), a.id_adh ) )
		And 	s.id_ets = a.id_ets
		And 	s.id_sdos = a.id_sdos
		and     dp.id_prod = s.id_prod_sin
		and     dp.id_typ_code = '-PADH'
		and     dp.id_code = a.id_prod_adh
	End
Else
	Begin
	Select  Right ( Replicate ('0', 10 ) + LTRIM ( Convert ( Varchar (50), radh.id_sin )) , 10 ) + -- [PI062]
			Right ( Replicate ('0', 6 ) + LTRIM ( Convert ( Varchar (50), radh.id_prod_sin )), 6 ) +
			Right ( Replicate ('0', 4 ) + LTRIM ( Convert ( Varchar (50), radh.id_prod_dms )), 4 ) +
			Right ( Replicate ('0', 5 ) + LTRIM ( Convert ( Varchar (50), radh.id_ets )), 5 ) +
			Right ( Replicate ('0', 19 ) + LTRIM ( radh.id_adh ), 19 ) +
			Right ( Replicate ('0', 1 ) + LTRIM ( Convert ( Varchar (50), radh.id_sdos )), 1 ) +
			Left ( LTRIM ( Convert ( Varchar (100), Left ( radh.motif_resil, 100 ) )) + Replicate (' ', 100 ) , 100 ) +	
			convert ( varchar(8), GETDATE(), 112 ) + 
			IsNull ( convert ( varchar(8), radh.dte_surv, 112 ), space ( 8 ) ) +  -- [DT472]
			IsNull ( Right ( Replicate ('0', 5 ) + LTRIM ( radh.cod_resil_adh ), 5 ), space ( 5 ) ) + ' '  -- [DT472]
	From	sysadm.resil_adh radh,
			SHERPA_SIM.sysadm.sinistre s with (nolock),
			SHERPA_SIM.sysadm.adhesion a with (nolock),
			SHERPA_SIM.sysadm.det_pro dp with (nolock)
		Where  	radh.alt_genfic = 'N'
		And 	s.id_sin = radh.id_sin
		And		s.id_appli = 2
		And 	s.id_cli = a.id_cli
		And 	LTRIM ( s.id_adh ) = LTRIM ( Convert ( varchar ( 19 ), a.id_adh ) )
		And 	s.id_ets = a.id_ets
		And 	s.id_sdos = a.id_sdos
		and     dp.id_prod = s.id_prod_sin
		and     dp.id_typ_code = '-PADH'
		and     dp.id_code = a.id_prod_adh
		
	End

Update sysadm.resil_adh
Set    alt_genfic = 'O'
Where  alt_genfic = 'N'

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RESIL_ADH_ECR_FIC
-- Auteur               :       FABRY JF
-- Date                 :       06/10/2014
-- Libellé              :        
-- Commentaires         :       [PC801-5]
-- Références           :       
--
-- JFF      22/04/2020   [DT472]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RESIL_ADH_ECR_FIC' AND type = 'P' )
        DROP procedure sysadm.PS_S_RESIL_ADH_ECR_FIC
GO

CREATE PROC sysadm.PS_S_RESIL_ADH_ECR_FIC
AS

DECLARE @sCommande   VarChar(250),
        @sFicOut     VarChar(255),
        @sNomServeur VarChar(255)
 

SET @sFicOut = master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Resil_adh_vers_EA\' + 
               CONVERT (varchar(4), DatePart (year,getdate())  ) +
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(month,getdate()) ),  2 )    + 
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(day,getdate())   ),  2 )   + 
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(hour,getdate())   ),  2 )   + 
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(minute,getdate())   ),  2 )   + 
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(second,getdate())   ),  2 )   + 
               '-ADH_A_RESILIER.TXT'


SET @sNomServeur = @@servername

-- [DT472]
IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"SIMPA2_PRO.sysadm.PS_S_RESIL_ADH_V01" /o' + @sFicOut + ' -w5000'
Else
	SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"SIMPA2_TRT.sysadm.PS_S_RESIL_ADH_V01" /o' + @sFicOut + ' -w5000'

                                       
EXEC master.dbo.xp_cmdshell @sCommande, no_output


GO

grant execute on sysadm.PS_S_RESIL_ADH_ECR_FIC to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_RESIL_ADH_SAGA2
-- Auteur               :       Fabry JF
-- Date                 :       22/08/2024
-- Libelle              :        [MCO602_PNEU]
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_RESIL_ADH_SAGA2' AND type = 'P' )
        DROP procedure sysadm.PS_I_RESIL_ADH_SAGA2
GO

CREATE procedure sysadm.PS_I_RESIL_ADH_SAGA2
        @dcIdSin        Decimal (  10 ) ,
		@sIdOper		VarChar ( 4 ),
		@sChaineSeria   varchar ( 100 ) 
AS

Declare @sCas VarChar ( 50 )
Declare @iResil Integer
Declare @iIdProdAdh	Integer
Declare @iIdEts Integer
Declare @sIdAdh	VarChar ( 19 )
Declare @iIdSdos Integer

Set @iResil = 0

Select @sCas = sysadm.FN_CLE_VAL ( 'CAS', rtrim ( val_car ) + rtrim ( val_car2), ';' ) 
From sysadm.det_pro dp,
	 sysadm.sinistre s
Where s.id_sin = @dcIdSin
And	  dp.id_prod = s.id_prod
and   dp.id_code_dp = 380

If @sCas = 'UNE_SEULE_INDEMNISATION' 
	Begin

		If Exists ( Select Top 1 1 From sysadm.resil_adh_saga2 Where id_sin = @dcIdSin ) Return

		Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @dcIdSin, @sIdOper
	
		If sysadm.FN_LIB_ETAT_DOS_ASSURE( @dcIdSin,'CODE' ) in ( 550, 600, 1500, 1510, 1520 )
		 Begin
			Set @iResil = 1
		 End
	End 

If @iResil = 1 
	Begin
		
		Select  
				@iIdProdAdh	= p.cod_prod_dms,
				@iIdEts		= s.id_ets,
				@sIdAdh		= s.id_adh,
				@iIdSdos	= s.id_sdos
		From	sysadm.sinistre s,
				sysadm.produit p
		Where   s.id_sin = @dcIdSin
		And		p.id_prod = s.id_prod

		Insert into sysadm.resil_adh_saga2 ( 
			id_sin,
			id_prod_adh,
			id_ets,
			id_adh,
			id_sdos,
			cod_trt,
			chaine_seria,
			cree_le,
			maj_le,
			maj_par
		)

		Values (
			@dcIdSin,
			@iIdProdAdh,
			@iIdEts,
			rtrim ( ltrim ( @sIdAdh)),
			@iIdSdos,
			'N',
			rtrim ( ltrim ( @sChaineSeria)),
			Getdate(),
			Getdate(),
			rtrim ( ltrim ( @sIdOper ))
		)
	End 
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_PRODUIT_ADH_SAGA2
-- Auteur               :       Fabry JF
-- Date                 :       22/08/2024
-- Libelle              :       [MCO602_PNEU]
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PRODUIT_ADH_SAGA2' AND type = 'P' )
        DROP procedure sysadm.PS_S_PRODUIT_ADH_SAGA2
GO

CREATE procedure sysadm.PS_S_PRODUIT_ADH_SAGA2
	@iIdProd	integer
As

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin
		If SHERPA_PRO.sysadm.FN_IS_SAGA ( @iIdProd ) > 0 Return 1
	End 
Else
	Begin
		If SHERPA_SIM.sysadm.FN_IS_SAGA ( @iIdProd ) > 0 Return 1
	End

Return 0

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_SI_MOTEUR_REPORT_ADH_RESIL_VERS_SAGA2
-- Auteur               :       Fabry JF
-- Date                 :       22/08/2024
-- Libelle              :       [MCO602_PNEU]
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SI_MOTEUR_REPORT_ADH_RESIL_VERS_SAGA2' AND type = 'P' )
        DROP procedure sysadm.PS_SI_MOTEUR_REPORT_ADH_RESIL_VERS_SAGA2
GO

CREATE procedure sysadm.PS_SI_MOTEUR_REPORT_ADH_RESIL_VERS_SAGA2
As
Declare @isProdOuSim VarChar ( 20 ) 
Declare @iError Integer

Update sysadm.resil_adh_saga2 Set cod_trt = 'T' where cod_trt = 'N'

Declare @TB_EnAttenteTransfert Table (
	[id_seq] [Integer] NOT NULL,
	[id_sin] decimal (10) not null,
	[id_prod_adh] decimal (5) NOT NULL,
	[id_ets] decimal (7) NOT NULL,
	[id_adh] varchar(19) NOT NULL,
	[id_sdos] decimal (7) NOT NULL,
	[cod_trt] varchar ( 1 ) NOT NULL,
	[chaine_seria] varchar ( 100 ) null,
	[cree_le] [datetime] NOT NULL,
	[maj_le] [datetime] NOT NULL,
	[maj_par] [char](4) NOT NULL
)

Declare 
	@iIdSeq integer,
	@iIdSin integer,
	@iIdProdAdh integer,
	@iIdEts integer,
	@sIdAdh varchar(19),
	@iIdSdos integer,
	@sCodTrt varchar ( 1 ),
	@sChaineSeria varchar ( 100 ),
	@dtCreeLe datetime,
	@dtMajLe datetime,
	@sMajPar char(4) 

Insert into @TB_EnAttenteTransfert
Select 
	id_seq,
	id_sin,
	id_prod_adh,
	id_ets,
	id_adh,
	id_sdos,
	cod_trt,
	chaine_seria,
	cree_le,
	maj_le,
	maj_par
From sysadm.resil_adh_saga2
Where cod_trt = 'T'

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO' Set @isProdOuSim = 'PROD' ELSE Set @isProdOuSim = 'SIM'

While Exists ( Select Top 1 1 From @TB_EnAttenteTransfert where cod_trt = 'T' )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@iIdSin = id_sin,
		@iIdProdAdh = id_prod_adh,
		@iIdEts = id_ets,
		@sIdAdh = id_adh,
		@iIdSdos = id_sdos,
		@sCodTrt ='N',
		@sChaineSeria = chaine_seria,
		@dtCreeLe = cree_le,
		@dtMajLe = maj_le,
		@sMajPar = maj_par
	From @TB_EnAttenteTransfert 
	where cod_trt = 'T'	

	If @isProdOuSim = 'PROD' 
		Begin 
			Exec @iError = [LS-SAGA2].[SAGA2_PVC].edi.PS_I_SIMPA2_RESIL_ADH_SAGA2 
				@iIdSin,
				@iIdProdAdh,
				@iIdEts,
				@sIdAdh,
				@iIdSdos,
				@sCodTrt,
				@sChaineSeria,
				@dtCreeLe,
				@dtMajLe,
				@sMajPar
		End
	Else
		Begin 
			Exec @iError = [S2SQL14PP1\PPRSAGA2].[SAGA2_PVC].edi.PS_I_SIMPA2_RESIL_ADH_SAGA2 
				@iIdSin,
				@iIdProdAdh,
				@iIdEts,
				@sIdAdh,
				@iIdSdos,
				@sCodTrt,
				@sChaineSeria,
				@dtCreeLe,
				@dtMajLe,
				@sMajPar
		End

	-- Echec
	If @iError <> 0 
		Begin
			Update @TB_EnAttenteTransfert Set cod_trt = 'O' Where id_seq = @iIdSeq
			Update sysadm.resil_adh_saga2 Set cod_trt = 'N', maj_le = GETDATE() Where id_seq = @iIdSeq
			Continue
		End


	-- Succès
		
	Update @TB_EnAttenteTransfert Set cod_trt = 'O' Where id_seq = @iIdSeq
	Update sysadm.resil_adh_saga2 Set cod_trt = 'O', maj_le = GETDATE() Where id_seq = @iIdSeq
 End
Go

/*
Declare @iNbreSource Integer
Declare @iNbreDest Integer

Update sysadm.resil_adh_saga2 Set cod_trt = 'T' where cod_trt = 'N'
Select @iNbreSource = count(*) From sysadm.resil_adh_saga2 Where cod_trt = 'T'

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert [LS-SAGA2].SAGA2_PVC.edi.simpa2_resil_adh_saga2 ( 
		id_sin,
		id_prod_adh,
		id_ets,
		id_adh,
		id_sdos,
		cod_trt,
		chaine_seria,
		cree_le,
		maj_le,
		maj_par
	)
	Select 
		id_sin,
		id_prod_adh,
		id_ets,
		id_adh,
		id_sdos,
		cod_trt,
		chaine_seria,
		cree_le,
		maj_le,
		maj_par
	From sysadm.resil_adh_saga2
	Where cod_trt = 'T'

	Select @iNbreDest = @@ROWCOUNT

	If @iNbreSource = @iNbreDest
		Begin
			Update sysadm.resil_adh_saga2 Set cod_trt = 'O' where cod_trt = 'T'
			Update [LS-SAGA2].SAGA2_PVC.edi.simpa2_resil_adh_saga2 Set cod_trt = 'N' where cod_trt = 'T'
		End 
	Else
		Begin
			Delete [LS-SAGA2].SAGA2_PVC.edi.simpa2_resil_adh_saga2 where cod_trt = 'T'
			Update sysadm.resil_adh_saga2 Set cod_trt = 'N' where cod_trt = 'T'
		End 
END
ELSE
BEGIN
	Insert [S2SQL14PP1\PPRSAGA2].SAGA2_PVC.edi.simpa2_resil_adh_saga2 ( 
		id_sin,
		id_prod_adh,
		id_ets,
		id_adh,
		id_sdos,
		cod_trt,
		chaine_seria,
		cree_le,
		maj_le,
		maj_par
	)
	Select 
		id_sin,
		id_prod_adh,
		id_ets,
		id_adh,
		id_sdos,
		cod_trt,
		chaine_seria,
		cree_le,
		maj_le,
		maj_par
	From sysadm.resil_adh_saga2
	Where cod_trt = 'T'

	Select @iNbreDest = @@ROWCOUNT

	If @iNbreSource = @iNbreDest
		Begin
			Update sysadm.resil_adh_saga2 Set cod_trt = 'O' where cod_trt = 'T'
			Update [S2SQL14PP1\PPRSAGA2].SAGA2_PVC.edi.simpa2_resil_adh_saga2 Set cod_trt = 'N' where cod_trt = 'T'
		End 
	Else
		Begin
			Delete [S2SQL14PP1\PPRSAGA2].SAGA2_PVC.edi.simpa2_resil_adh_saga2 where cod_trt = 'T'
			Update sysadm.resil_adh_saga2 Set cod_trt = 'N' where cod_trt = 'T'
		End 
END

Go
*/

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_RESIL_ADH_SAGA2
-- Auteur               :       Fabry JF
-- Date                 :       22/08/2024
-- Libelle              :       [MCO602_PNEU]
-- Commentaires         :       ===>>>> /!\ A Compiler sur SAGA2_PVC /!\
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
/*
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_RESIL_ADH_SAGA2' AND type = 'P' )
        DROP procedure edi.PS_I_SIMPA2_RESIL_ADH_SAGA2
GO

CREATE procedure edi.PS_I_SIMPA2_RESIL_ADH_SAGA2
	@iIdSin integer,
	@iIdProdAdh integer,
	@iIdEts integer,
	@sIdAdh varchar(19),
	@iIdSdos integer,
	@sCodTrt varchar ( 1 ),
	@sChaineSeria varchar ( 100 ),
	@dtCreeLe datetime,
	@dtMajLe datetime,
	@sMajPar char(4) 
As

Insert into edi.simpa2_resil_adh_saga2 
	(
	id_sin,
	id_prod_adh,
	id_ets,
	id_adh,
	id_sdos,
	cod_trt,
	chaine_seria,
	cree_le,
	maj_le,
	maj_par
	)
Values 
	(
	@iIdSin,
	@iIdProdAdh,
	@iIdEts,
	@sIdAdh,
	@iIdSdos,
	@sCodTrt,
	@sChaineSeria,
	@dtCreeLe,
	@dtMajLe,
	@sMajPar
	)

Go
*/