-------------------------------------------------------------------
--
-- Fichier              :       param_vts_pec.CP
-- Auteur               :       Fabry JF
-- Date                 :       03/04/2013
--
-- Commentaires         :       PS rattachées au projet param_vts_pec
--
-- sysadm.PS_GET_VTS_PEC
-- sysadm.PS_GET_VTS_PEC_V01
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_GET_VTS_PEC
-- Auteur               :       FABRY JF
-- Date                 :       03/04/2013
-- Libellé              :        
-- Commentaires         :       [PC929]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_GET_VTS_PEC' AND type = 'P' )
        DROP procedure sysadm.PS_GET_VTS_PEC
GO

CREATE procedure sysadm.PS_GET_VTS_PEC
  @alIdProd		decimal ( 7 ),
  @asIdTypArt	VarChar ( 3 ),
  @adtDteSurv	DateTime,
  @adtDteAchat	DateTime,
  @sdcTxVts		Varchar ( 20 ) OUTPUT
  
AS

Declare @dtDteDeb DateTime
Declare @dtDteFin DateTime
Declare @sTypCtrle VarChar ( 10 )
Declare @sTypUnt VarChar ( 10 )
Declare @iEcartUnt Integer
Declare @iTrouve Integer
Declare @dcTxVts   Decimal ( 11,5 ) 

Set @iTrouve = 0 
Set @dcTxVts = 0 

Select Distinct 
		@sTypCtrle = pa.dte_app
From   sysadm.param_vts_pec pa
Where  pa.id_prod = @alIdProd
And    pa.id_typ_art = @asIdTypArt


Select Distinct 
		@sTypUnt = pa.unt
From   sysadm.param_vts_pec pa
Where  pa.id_prod = @alIdProd
And    pa.id_typ_art = @asIdTypArt


If @sTypCtrle = 'ACHSRV'
  Begin
	Set @dtDteDeb = @adtDteAchat
	Set @dtDteFin = @adtDteSurv
  End 


Select Top 1 @iEcartUnt = Case @sTypUnt
					When 'J' Then Abs ( DATEDIFF ( day, @dtDteDeb, @dtDteFin ))
					When 'M' Then Abs ( DATEDIFF ( month, @dtDteDeb, @dtDteFin ))
					When 'A' Then Abs ( DATEDIFF ( Year, @dtDteDeb, @dtDteFin ))				
				 End 
From   sysadm.param_vts_pec pa
Where  pa.id_prod = @alIdProd
And    pa.id_typ_art = @asIdTypArt


Select top 1 @dcTxVts = pa.taux,
			 @iTrouve = 1
From   sysadm.param_vts_pec pa
Where  pa.id_prod = @alIdProd
And    pa.id_typ_art = @asIdTypArt
And    ( 
			( @iEcartUnt >= pa.debut and pa.incl_deb = 'O' ) 
			Or 
			( @iEcartUnt > pa.debut and pa.incl_deb = 'N' ) 
	   )
And    ( 
			( @iEcartUnt <= pa.fin and pa.incl_fin = 'O' ) 
			Or 
			( @iEcartUnt < pa.fin and pa.incl_fin = 'N' ) 
	   )

If @dcTxVts = 0 And @iTrouve = 0 Set @dcTxVts = 1

Set @sdcTxVts = CONVERT ( Varchar ( 20), @dcTxVts )

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_GET_VTS_PEC_V01
-- Auteur               :       FABRY JF
-- Date                 :       03/04/2013
-- Libellé              :        
-- Commentaires         :       [PC929]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- FPI - 26/07/2013 - [PC952 à 955] - V01 - ajout id_gti
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_GET_VTS_PEC_V01' AND type = 'P' )
        DROP procedure sysadm.PS_GET_VTS_PEC_V01
GO

CREATE procedure sysadm.PS_GET_VTS_PEC_V01
  @alIdProd		decimal ( 7 ),
  @asIdTypArt	VarChar ( 3 ),
  @alIdGti		decimal (7),
  @adtDteSurv	DateTime,
  @adtDteAchat	DateTime,
  @sdcTxVts		Varchar ( 20 ) OUTPUT
  
AS

Declare @dtDteDeb DateTime
Declare @dtDteFin DateTime
Declare @sTypCtrle VarChar ( 10 )
Declare @sTypUnt VarChar ( 10 )
Declare @iEcartUnt Integer
Declare @iTrouve Integer
Declare @dcTxVts   Decimal ( 11,5 ) 

Set @iTrouve = 0 
Set @dcTxVts = 0 

Select Distinct 
		@sTypCtrle = pa.dte_app
From   sysadm.param_vts_pec pa
Where  pa.id_prod = @alIdProd
And    pa.id_typ_art = @asIdTypArt
And    pa.id_gti = @alIdGti


Select Distinct 
		@sTypUnt = pa.unt
From   sysadm.param_vts_pec pa
Where  pa.id_prod = @alIdProd
And    pa.id_typ_art = @asIdTypArt
And    pa.id_gti = @alIdGti


If @sTypCtrle = 'ACHSRV'
  Begin
	Set @dtDteDeb = @adtDteAchat
	Set @dtDteFin = @adtDteSurv
  End 


Select Top 1 @iEcartUnt = Case @sTypUnt
					When 'J' Then Abs ( DATEDIFF ( day, @dtDteDeb, @dtDteFin ))
					When 'M' Then Abs ( DATEDIFF ( month, @dtDteDeb, @dtDteFin ))
					When 'A' Then Abs ( DATEDIFF ( Year, @dtDteDeb, @dtDteFin ))				
				 End 
From   sysadm.param_vts_pec pa
Where  pa.id_prod = @alIdProd
And    pa.id_typ_art = @asIdTypArt
And    pa.id_gti = @alIdGti
/*

Select top 1 @dcTxVts = pa.taux,
			 @iTrouve = 1
From   sysadm.param_vts_pec pa
Where  pa.id_prod = @alIdProd
And    pa.id_typ_art = @asIdTypArt
And    pa.id_gti = @alIdGti
And    ( 
			( @iEcartUnt >= pa.debut and pa.incl_deb = 'O' ) 
			Or 
			( @iEcartUnt > pa.debut and pa.incl_deb = 'N' ) 
	   )
And    ( 
			( @iEcartUnt <= pa.fin and pa.incl_fin = 'O' ) 
			Or 
			( @iEcartUnt < pa.fin and pa.incl_fin = 'N' ) 
	   )
*/
-------------------
If @sTypUnt='A'
Begin
  Select top 1 @dcTxVts = pa.taux,
			 @iTrouve = 1
  From   sysadm.param_vts_pec pa
  Where  pa.id_prod = @alIdProd
		And    pa.id_typ_art = @asIdTypArt
		And    pa.id_gti = @alIdGti
		and pa.unt='A'
		And (
				(DATEADD(year,debut,@dtDteDeb) <= @dtDteFin and pa.incl_deb = 'O' ) 
				Or 
				( DATEADD(year,debut,@dtDteDeb) < @dtDteFin and pa.incl_deb = 'N' ) 
			)
		And (
				(fin < 100 And
				  (
					  (DATEADD(year,fin,@dtDteDeb) >= @dtDteFin and pa.incl_fin = 'O' ) 
					  Or 
					  ( DATEADD(year,fin,@dtDteDeb) > @dtDteFin and pa.incl_fin = 'N' ) 
				  )
				)
				or fin > 100)
End

If @sTypUnt='M'
Begin
  Select top 1 @dcTxVts = pa.taux,
			 @iTrouve = 1
  From   sysadm.param_vts_pec pa
	Where  pa.id_prod = @alIdProd
		And    pa.id_typ_art = @asIdTypArt
		And    pa.id_gti = @alIdGti
		and pa.unt='M'
		And (
				(DATEADD(month,debut,@dtDteDeb) <= @dtDteFin and pa.incl_deb = 'O' ) 
				Or 
				( DATEADD(month,debut,@dtDteDeb) < @dtDteFin and pa.incl_deb = 'N' ) 
			)
		And (
				(DATEADD(month,fin,@dtDteDeb) >= @dtDteFin and pa.incl_fin = 'O' ) 
				Or 
				( DATEADD(month,fin,@dtDteDeb) > @dtDteFin and pa.incl_fin = 'N' ) 
			)
End

If @sTypUnt='J'
Begin
  Select top 1 @dcTxVts = pa.taux,
			 @iTrouve = 1
  From   sysadm.param_vts_pec pa
	Where  pa.id_prod = @alIdProd
		And    pa.id_typ_art = @asIdTypArt
		And    pa.id_gti = @alIdGti
		and pa.unt='J'
		And (
				(DATEADD(day,debut,@dtDteDeb) <= @dtDteFin and pa.incl_deb = 'O' ) 
				Or 
				( DATEADD(day,debut,@dtDteDeb) < @dtDteFin and pa.incl_deb = 'N' ) 
			)
		And (
				(DATEADD(day,fin,@dtDteDeb) >= @dtDteFin and pa.incl_fin = 'O' ) 
				Or 
				( DATEADD(day,fin,@dtDteDeb) > @dtDteFin and pa.incl_fin = 'N' ) 
			)
End
--------------	
If @dcTxVts = 0 And @iTrouve = 0 Set @dcTxVts = 1

Set @sdcTxVts = CONVERT ( Varchar ( 20), @dcTxVts )

Go

grant execute on sysadm.PS_GET_VTS_PEC_V01 to rolebddsinistres
Go


