-------------------------------------------------------------------
--
-- Fichier              :       JOURNAL_EVTSIN.CP
-- Auteur               :       Fabry JF
-- Date                 :       31/03/2025
--
-- Commentaires         :       
-------------------------------------------------------------------


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_INSERTION_JOURNAL_EVTSIN
-- Auteur               :       Fabry JF
-- Date                 :       31/03/2025
-- Libell‚              :       
-- Commentaires         :       [MIG82_JOURN_EVT]
--
-- Retour				: 1 Succès
--						 -1 Erreur
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_INSERTION_JOURNAL_EVTSIN' AND type = 'P' )
        DROP procedure sysadm.PS_I_INSERTION_JOURNAL_EVTSIN
GO

CREATE procedure sysadm.PS_I_INSERTION_JOURNAL_EVTSIN
	@adcIdSin			Decimal ( 10 ),
	@asCodEvt			VarChar ( 6 ),
	@asSeriaVariable	VarChar ( 255 ),
	@asSeriaLibre		VarChar ( 255 ),
	@asProvenance		VarChar ( 40 ),
	@asCodOper			VarChar ( 4 )
AS

-- [MIG82_JOURN_EVT]
If Not ( sysadm.FN_CLE_NUMERIQUE ( 'MIG82_JOURN_EVT') > 0 ) Return -99

Declare @sLibEvt VarChar ( 255 )
Declare @dcIdProd Decimal ( 7 )
Declare @iPos1 Integer
Declare @iPos2 Integer
Declare @sVar VarChar ( 50 )

If @adcIdSin is null Return -4

Select @dcIdProd = ws.id_prod
From sysadm.w_sin ws
Where ws.id_sin = @adcIdSin

If @dcIdProd  Is Null 
 Begin
	Select @dcIdProd = s.id_prod
	From sysadm.sinistre s
	Where s.id_sin = @adcIdSin
 End 

If @dcIdProd is null Return -5

If Not Exists ( 
	Select Top 1 1 
	From sysadm.det_pro dp
	Where dp.id_prod = @dcIdProd
	And   dp.id_code_dp = 396
) Begin
	Return -6
  End 

Select	@sLibEvt = lTrim ( rTrim ( jevt.lib_evt ))
From	sysadm.param_journal_evtsin jevt
Where	jevt.code_evt = @asCodEvt
And		( jevt.id_prod is null Or jevt.id_prod = @dcIdProd )

If @sLibEvt is null Return -1

While 1=1 
 Begin
	Set @iPos1 = charIndex ( '<VAR:', @sLibEvt ) 
	If @iPos1 <= 0 Break

	Set @iPos2 = charIndex ( '>', @sLibEvt, @iPos1 ) 
	If @iPos2 <= 0 Return -2

	Set @iPos2 = @iPos2 + 1

	Set @sVar = Substring ( @sLibEvt, @iPos1, @iPos2 - @iPos1 )

	Set @sVar = Replace ( @sVar, '<VAR:', '' )
	Set @sVar = Replace ( @sVar, '>', '' )

	Set @sVar = sysadm.FN_CLE_VAL ( @sVar, @asSeriaVariable, ';' )

	Set @sLibEvt = Stuff ( @sLibEvt, @iPos1, @iPos2 - @iPos1, @sVar ) 
 End 

If @sLibEvt Is Null Or lTrim ( rTrim ( @sLibEvt )) = '' Return -3

Insert into sysadm.journal_evtsin 
	(
		id_sin,
		code_evt,
		lib_evt,
		provenance,
		cree_le,
		maj_le,
		maj_par
	)
Values 
	( 
		@adcIdSin,
		@asCodEvt,
		@sLibEvt,
		@asProvenance,
		GetDate(),
		GetDate(),
		@asCodOper
	)

Return @@RowCount

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_INSERTION_JOURNAL_EVTSIN
-- Auteur               :       Fabry JF
-- Date                 :       31/03/2025
-- Libell‚              :       
-- Commentaires         :       
--
-- Retour				: 1 Succès
--						 -1 Erreur
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_INSERTION_JOURNAL_EVTSIN' AND type = 'P' )
        DROP procedure sysadm.PS_S_INSERTION_JOURNAL_EVTSIN
GO

CREATE procedure sysadm.PS_S_INSERTION_JOURNAL_EVTSIN
	@adcIdSin			Decimal ( 10 )
AS

Select	lTrim ( rTrim ( jevt.lib_evt )), 
		jevt.cree_le
From   sysadm.journal_evtsin jevt
Where  jevt.id_sin = @adcIdSin
Order  by jevt.cree_le

GO


-------------------------------------------------------------------
--
-- Procédure            :       TR_IU_PARAM_JOURNAL_EVTSIN
-- Auteur               :       JFF
-- Date                 :       01/04/2025
-- Libell‚              :       [MIG82]
-- Commentaires         :       
--                              
--								
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_IU_PARAM_JOURNAL_EVTSIN' AND type = 'TR' )
        DROP Trigger sysadm.TR_IU_PARAM_JOURNAL_EVTSIN
GO

CREATE Trigger sysadm.TR_IU_PARAM_JOURNAL_EVTSIN
	On sysadm.param_journal_evtsin
For Insert, Update
AS

DECLARE @DBID INT
DECLARE @DBNAME NVARCHAR(128)

SET @DBID = DB_ID()
SET @DBNAME = DB_NAME()

RAISERROR ('La mise à jour de cette table se fait façon spéciale via un fichier Excel "Données table paramètrage journal_evtsin.xlsx".', 16, 1, @DBID, @DBNAME)
Rollback Tran

Go

