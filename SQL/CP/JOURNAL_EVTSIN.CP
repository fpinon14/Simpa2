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
Declare @sDernCodEvtActuel VarChar ( 6 )

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

Select	@sDernCodEvtActuel = jevt.code_evt
From	sysadm.journal_evtsin jevt
Where	jevt.id_sin = @adcIdSin
And		jevt.id_seq = ( Select Max ( id_seq ) 
						From sysadm.journal_evtsin jevt2
						Where jevt2.id_sin = jevt.id_sin )

-- C'est le dernier evt connu donc on ne réinsère pas le même
If @sDernCodEvtActuel = @asCodEvt Return -7

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
Order  by jevt.id_seq

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

RAISERROR ('La mise à jour de cette table se fait façon spéciale via un fichier Excel "HORS ASSUREUR - HORS CONTRACTANT\MIG-82 Journal évènements sinistres\Analyse\Données table paramètrage journal_evtsin.xlsx".', 16, 1, @DBID, @DBNAME)
Rollback Tran

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION
-- Auteur               :       Fabry JF
-- Date                 :       31/03/2025
-- Libell‚              :       
-- Commentaires         :       
--
-- Retour				: 1 Succès
--						 -1 Erreur
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION' AND type = 'P' )
        DROP procedure sysadm.PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION
GO

CREATE procedure sysadm.PS_S_INSERTION_JOURNAL_EVTSIN
	@adcIdSin			Decimal ( 10 ),
	@asCodOper			Varchar (  4 )
AS
/*
   100	En cours d'instruction
   200	Refusé
   500	A Régler
   550	En cours de règlement
   600	Réglé
   900	Sans suite
  1500	Réglé et clos pour l'assuré
  1510	Remplacé et clos pour l'assuré
  1520	Réparé et clos pour l'assuré
  1530	Refusé et clos pour l'assuré
  1540	Pris en charge
  1550	Dormant pour SPB
*/

Declare @iDdePceEc Integer
Declare @iEtatVuAssure Integer 
Declare @iPrestaEncours Integer 
Declare @sVar	VarChar ( 255 )

Set @iEtatVuAssure = sysadm.FN_LIB_ETAT_DOS_ASSURE ( @adcIdSin, 'CODE' )

Set @iDdePceEc = 0
If Exists ( 
	Select Top 1 1 
	From sysadm.piece_histo ph
	Where ph.id_sin = @adcIdSin
	And ph.dte_demande is not null 
	And ph.dte_reception is null
	) Set @iDdePceEc = 1

Set @iPrestaEncours = 0
If Exists ( 
	Select Top 1 1 
	From sysadm.commande c
	Where c.id_sin = @adcIdSin
	And c.cod_etat in ( 'ECT', 'ECL' ) 
	) Set @iPrestaEncours = 1

-- Règlement
If @iEtatVuAssure in ( 550, 600, 1500, 1510, 1520 )
	Begin

	End 

-- En cours
If @iEtatVuAssure in ( 100, 550, 1540 )
	Begin
		If @iDdePceEc <= 0 And @iPrestaEncours <= 0 
			Begin
				Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @adcIdSin, 'ECTTRT', @sVar, '', 'PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION', @asCodOper				
			End 

		If @iDdePceEc > 0 
			Begin
				Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @adcIdSin, 'ATTDOC', @sVar, '', 'PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION', @asCodOper				
			End 

	 
	End 

-- Dormant
If @iEtatVuAssure in ( 1550 )
	Begin
		If @iDdePceEc > 0 -- And @iPrestaEncours <= 0 
			Begin
				Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @adcIdSin, 'ATTDOC', @sVar, '', 'PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION', @asCodOper				
			End 
	End 


Go