-------------------------------------------------------------------
--
-- Fichier              :       TRACE_ALERTE.CP
-- Auteur               :       Fabry JF
-- Date                 :       19/02/2014
--
-- Commentaires         :       VDOC12845
--
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_TRACE_ALERTE
-- Auteur               :       Fabry JF 
-- Date                 :       19/02/2014
-- Libelle              : 	VDOC12845
-- Commentaires         :       
-- References           :
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_TRACE_ALERTE' AND type = 'P' )
        DROP procedure sysadm.PS_I_TRACE_ALERTE
GO

CREATE procedure sysadm.PS_I_TRACE_ALERTE
  @adcIdSin     Decimal (10), -- [PI062]
  @sActionEc	VarChar ( 50 ),
  @sActionValidee	VarChar ( 50 ),
  @sDecision	VarChar ( 10 ),
  @sCodOper		VarChar ( 5 ),
  @dtDteMaj		DateTime

AS

Insert Into sysadm.trace_alerte 
	( 
		id_sin,
		action_ec,
		action_validee,
		decision,
		cree_le,
		maj_le,
		maj_par
	)
Values
	(
		@adcIdSin,
		@sActionEc,
		@sActionValidee,
		@sDecision,
		@dtDteMaj,
		@dtDteMaj,
		@sCodOper
	)

GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_U_TRACE_ALERTE
-- Auteur               :       Fabry JF 
-- Date                 :       19/02/2014
-- Libelle              : 	VDOC12845
-- Commentaires         :       
-- References           :
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_TRACE_ALERTE' AND type = 'P' )
        DROP procedure sysadm.PS_U_TRACE_ALERTE
GO

CREATE procedure sysadm.PS_U_TRACE_ALERTE
  @adcIdSin     Decimal (10), -- [PI062]
  @sDecision	VarChar ( 10 ),
  @sCodOper		VarChar ( 5 ),
  @dtDteMaj		DateTime

AS

Update sysadm.trace_alerte 
Set    decision = @sDecision
Where  id_sin = @adcIdSin
And    cree_le = @dtDteMaj

GO

