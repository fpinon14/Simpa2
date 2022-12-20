-------------------------------------------------------------------
--
-- Fichier              :       RESIL_ADH.CP
-- Auteur               :       FABRY JF
-- Date                 :       10/11/2014
--
-- Commentaires         :       
--
-------------------------------------------------------------------

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

