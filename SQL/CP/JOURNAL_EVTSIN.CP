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
	And   dp.id_code_dp = 397
) Begin
	Return -6
  End 

Select	@sDernCodEvtActuel = jevt.code_evt
From	sysadm.journal_evtsin jevt
Where	jevt.id_sin = @adcIdSin
And		jevt.id_seq = ( Select Max ( id_seq ) 
						From sysadm.journal_evtsin jevt2
						Where jevt2.id_sin = jevt.id_sin )

-- le dernier evt connu est le même donc on ne réinsère pas le même
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
-- Proc‚dure            :       PS_S_JOURNAL_EVTSIN
-- Auteur               :       Fabry JF
-- Date                 :       31/03/2025
-- Libell‚              :       
-- Commentaires         :       
--
-- Retour				: 1 Succès
--						 -1 Erreur
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_JOURNAL_EVTSIN' AND type = 'P' )
        DROP procedure sysadm.PS_S_JOURNAL_EVTSIN
GO

CREATE procedure sysadm.PS_S_JOURNAL_EVTSIN
	@adcIdSin			Decimal ( 10 )
AS

Select	jevt.cree_le 'Date évènement',
		lTrim ( rTrim ( jevt.lib_evt )) 'libellé évènement'
		
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

CREATE procedure sysadm.PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION
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
Declare @iRdvDiagVideo Integer
Declare @iAppRecuEnCTR Integer
Declare @iGeolocTjrsActiveReexp Integer
Declare @iCmdeRemplAppEnCours Integer
Declare @iMaxIdSeqIdemBACC Integer
Declare @sVar	VarChar ( 255 )
Declare @sBAouCC VarChar ( 50 )
Declare @sMtCmdeBACC VarChar ( 50 )
Declare @sCodeEtatBACC VarChar ( 50 )
Declare @iIdSeq Integer
Declare @sCodInter VarChar ( 5 )
Declare @dcMtTotReg Decimal ( 11, 2 )
Declare @iRibBq Integer
Declare @iRibGui Integer
Declare @sRibCpt VarChar ( 11 )
Declare @iCle Integer
Declare @sCodModeReg VarChar ( 5 )
Declare @sNom VarChar ( 71 )
Declare @sOrdrechq VarChar ( 35 )
Declare @sCodEvt Varchar ( 6 )
Declare @sVal VarChar ( 100 )
Declare @iCodEtat Integer
Declare @dcIdGti Decimal ( 7 )
Declare @sLibGti VarChar ( 35 )

Set @iEtatVuAssure = sysadm.FN_LIB_ETAT_DOS_ASSURE ( @adcIdSin, 'CODE' )

Set @iDdePceEc = 0
If Exists ( 
	Select Top 1 1 
	From sysadm.piece_histo ph with (nolock)
	Where ph.id_sin = @adcIdSin
	And ph.dte_demande is not null 
	And ph.dte_reception is null
	) Set @iDdePceEc = 1

Set @iPrestaEncours = 0
If Exists ( 
	Select Top 1 1 
	From sysadm.commande c with (nolock)
	Where c.id_sin = @adcIdSin
	And c.cod_etat in ( 'ECT', 'ECL' )
	) Set @iPrestaEncours = 1

Set @iRdvDiagVideo = 0
If Exists ( 
	Select Top 1 1 
	From sysadm.commande c with (nolock)
	Where c.id_sin = @adcIdSin
	And Len ( sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';' )) > 0
	And c.cod_etat in ( 'ECT', 'ECL' ) 
	And sysadm.FN_CLE_VAL ( 'RDV_DIAG_VIDEO', c.info_spb_frn_cplt, ';' ) = 'OUI'
	And sysadm.FN_CLE_VAL ( 'DIAG_VIDEO_ENGAGE', c.info_spb_frn_cplt, ';' ) <> 'OUI'
	) Set @iRdvDiagVideo = 1

Set @iAppRecuEnCTR = 0
If Exists ( 
	Select Top 1 1 
	From sysadm.commande c with (nolock)
	Where c.id_sin = @adcIdSin
	And Len ( sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';' )) > 0
	And c.cod_etat in ( 'ECT', 'ECL' ) 
	And c.dte_rcp_frn is not null
	And ( c.status_gc in ( 0, 159 ) Or c.status_gc is null ) 
	) Set @iAppRecuEnCTR = 1

Set @iGeolocTjrsActiveReexp = 0
If Exists ( 
	Select Top 1 1 
	From sysadm.commande cOrig with (nolock),
		 sysadm.commande cRefReexp with (nolock)
	Where cOrig.id_sin = @adcIdSin
	And Len ( sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', cOrig.info_spb_frn_cplt, ';' )) > 0
	And cOrig.cod_etat in ( 'RFO', 'RPC' ) 
	And cOrig.status_gc = 305
	And cRefReexp.id_sin = cOrig.id_sin
	And cRefReexp.id_ref_four = 'REFUSE_A_REEXP'
	and cRefReexp.id_seq > cOrig.id_seq
	And cRefReexp.id_seq = ( Select max ( id_seq ) From sysadm.commande c2 with (nolock) Where c2.id_sin = cRefReexp.id_sin ) 
	-- And Convert( VarChar ( 10 ), cRefReexp.cree_le , 103 ) = Convert( VarChar ( 10 ), Getdate() , 103 )
	And cRefReexp.cree_le >= DateAdd ( minute, -30, Getdate() )
	) Set @iGeolocTjrsActiveReexp = 1

Set @iCmdeRemplAppEnCours = 0
If Exists ( 
	Select Top 1 1 
	From sysadm.commande c with (nolock)
	Where c.id_sin = @adcIdSin
	And Len ( sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';' )) > 0
	And c.cod_etat in ( 'ECT', 'ECL' ) 
	And Len ( sysadm.FN_CLE_VAL ( 'TYPE_REMPL', c.info_spb_frn_cplt, ';' )) = 'REMPL_APPAREIL'
--	And Convert( VarChar ( 10 ), c.cree_le , 103 ) = Convert( VarChar ( 10 ), Getdate() , 103 )
	And c.cree_le >= DateAdd ( minute, -30, Getdate() )
	) Set @iCmdeRemplAppEnCours = 1


Select @iMaxIdSeqIdemBACC = max ( c.id_seq ) 
From sysadm.commande c with (nolock)
Where c.id_sin = @adcIdSin
And c.cod_etat Not in ( 'ANN' ) 
And Len ( sysadm.FN_CLE_VAL ( 'TYPE_REMPL', c.info_spb_frn_cplt, ';' )) in ( 'CARTE_CADEAU', 'BON_ACHAT' )
-- And Convert( VarChar ( 10 ), c.cree_le , 103 ) = Convert( VarChar ( 10 ), Getdate() , 103 )
And c.cree_le >= DateAdd ( minute, -30, Getdate() )

IF @iMaxIdSeqIdemBACC > 0 
	Begin
		Select @sBAouCC = sysadm.FN_CLE_VAL ( 'TYPE_REMPL', c.info_spb_frn_cplt, ';' ),
			   @sMtCmdeBACC = Convert ( VarChar ( 30 ), c.mt_ttc_cmde ),
			   @sCodeEtatBACC = c.cod_etat
		From sysadm.commande c with (nolock)
		Where c.id_sin = @adcIdSin
		and   c.id_seq = @iMaxIdSeqIdemBACC
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

		If @iRdvDiagVideo > 0 
			Begin
				Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @adcIdSin, 'RDVDGV', @sVar, '', 'PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION', @asCodOper				
			End 

		If @iAppRecuEnCTR > 0 
			Begin
				Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @adcIdSin, 'APPCTR', @sVar, '', 'PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION', @asCodOper				
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

-- Autres
If @iEtatVuAssure Not in ( 200, 900 )
	Begin 
		If @iGeolocTjrsActiveReexp > 0 
			Begin
				Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @adcIdSin, 'GEORXP', @sVar, '', 'PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION', @asCodOper				
			End 

		If @iCmdeRemplAppEnCours > 0 
			Begin
				Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @adcIdSin, 'CDRPEC', @sVar, '', 'PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION', @asCodOper				
			End 
		
		IF @iMaxIdSeqIdemBACC > 0 
			Begin
				If @sBAouCC = 'BON_ACHAT' 
					Begin 
						Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @adcIdSin, 'INDMBA', @sMtCmdeBACC, '', 'PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION', @asCodOper				

						If @sCodeEtatBACC in ( 'ECT', 'ECL' ) 
							Begin
								Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @adcIdSin, 'BAECED', @sVar, '', 'PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION', @asCodOper				

							End 
						If @sCodeEtatBACC in ( 'RPC', 'RFO' ) 
							Begin
								Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @adcIdSin, 'BAEMIS', @sVar, '', 'PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION', @asCodOper				
							End 
					End 

				If @sBAouCC = 'CARTE_CADEAU' 
					Begin 				
						Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @adcIdSin, 'INDMCC', @sMtCmdeBACC, '', 'PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION', @asCodOper				

						If @sCodeEtatBACC in ( 'ECT', 'ECL' ) 
							Begin
								Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @adcIdSin, 'CCECED', @sVar, '', 'PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION', @asCodOper				

							End 
						If @sCodeEtatBACC in ( 'RPC', 'RFO' ) 
							Begin
								Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @adcIdSin, 'CCEMIS', @sVar, '', 'PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION', @asCodOper				
							End 
					End 

			End 
	End 

-- Réglement numaire
Declare @TbReglNum Table ( 
	id_seq integer Identity ( 1, 1 ),
	id_reg integer,
	cod_inter Varchar ( 5 ),
	mt_tot_reg  Decimal ( 11, 2 ),
	rib_bq  integer, 
	rib_gui integer,
	rib_cpt Varchar ( 11 ),
	rib_cle integer,
	cod_mode_reg VarChar ( 5 ),
	nom VarChar ( 71 ),
	ordre_cheque varchar (35),
	marquage integer 
)

Insert into @TbReglNum 
Select  r.id_reg,
		ltrim ( rtrim ( r.cod_inter)),
		r.mt_tot_reg,
		r.rib_bq,
		r.rib_gui,
		ltrim ( rtrim ( r.rib_cpt )),
		r.rib_cle,
		r.cod_mode_reg,
		ltrim ( rtrim ( i.nom )),
		i.ordre_cheque,
		0
From sysadm.reglement r,
	 sysadm.inter i
Where r.id_sin = @adcIdSin
and	  r.cod_inter in ( 'A', 'T' ) 
And   r.cod_mot_reg = 'RN'
And   r.cree_le >= DateAdd ( minute, -30, Getdate() )
And   i.id_sin = r.id_sin
ANd   i.id_i = r.id_i

While Exists ( Select Top 1 1 From @TbReglNum where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@sCodInter = cod_inter,
		@dcMtTotReg = mt_tot_reg,
		@iRibBq = rib_bq,
		@iRibGui = rib_gui,
		@sRibCpt = rib_cpt,
		@iCle = rib_cle,
		@sCodModeReg = cod_mode_reg,
		@sNom = nom,
		@sOrdrechq = ordre_cheque
	From	@TbReglNum
	Where	marquage = 0

	Set @sCodEvt = 'INDVIR' -- Défaut VA
	If @sCodModeReg = 'C' Set @sCodEvt = 'INDCHQ' -- Chèque

	Set @sRibCpt = REPLICATE ( 'X', 9 ) + RIGHT ( @sRibCpt, 2 ) 

	If @sCodInter = 'A' Set @sNom = 'l''assuré ' + @sNom 

	Set @sVar = ''
	Set @sVar = sysadm.FN_CLE_VAL_E ( 'NOM', @sNom, @sVar, ';' )
	Set @sVar = sysadm.FN_CLE_VAL_E ( 'MT_REG', CONVERT ( VarChar ( 20 ), @dcMtTotReg ), @sVar, ';' )

	Set @sVal = @iRibBq + '-' + @iRibGui + '-' + @sRibCpt + '-' + @iCle
	If @sCodModeReg = 'VA' Set @sVar = sysadm.FN_CLE_VAL_E ( 'RIB_XXX', @sVal, @sVar, ';' )
	If @sCodModeReg = 'C' Set @sVar = sysadm.FN_CLE_VAL_E ( 'ORDRE', @sOrdrechq, @sVar, ';' )

	Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @adcIdSin, @sCodEvt, @sVar, '', 'PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION', @asCodOper	

	Update @TbReglNum Set marquage = 1 Where id_seq = @iIdSeq
 End

-- Trt Garantie 
Declare @TbGti Table ( 
	id_seq integer Identity ( 1, 1 ),
	id_gti decimal ( 7 ),
	lib_gti VarChar ( 35 ),
	cod_etat integer,
	marquage integer 
)

Insert into @TbGti 
Select  g.id_gti,
		lTrim ( rTrim ( cGti.lib_gti )),
		g.cod_etat,
		0
From sysadm.sinistre s,
	 sysadm.code_garantie cGti,
	 sysadm.gar_sin g
Where s.id_sin = @adcIdSin
And   g.id_sin = s.id_sin
And   g.valide_le >= DateAdd ( minute, -30, Getdate() )
And   cGti.id_prod = s.id_prod

While Exists ( Select Top 1 1 From @TbGti where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdGti = id_gti,
		@sLibGti = lib_gti,
		@iCodEtat = cod_etat
	From	@TbGti
	Where	marquage = 0

	If @iCodEtat = 200 Set @sCodEvt = 'GTREFU'
	If @iCodEtat = 900 Set @sCodEvt = 'GTSSUI'
	If @iCodEtat = 600 Set @sCodEvt = 'GTINDM'

	Set @sVar = ''
	Set @sVar = sysadm.FN_CLE_VAL_E ( 'LIB_GARANTIE', @sLibGti, @sVar, ';' )

	Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @adcIdSin, @sCodEvt, @sVar, '', 'PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION', @asCodOper	

	Update @TbReglNum Set marquage = 1 Where id_seq = @iIdSeq
 End


Go