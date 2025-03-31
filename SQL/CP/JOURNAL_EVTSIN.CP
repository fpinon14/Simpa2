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
-- Commentaires         :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_INSERTION_JOURNAL_EVTSIN' AND type = 'P' )
        DROP procedure sysadm.PS_I_INSERTION_JOURNAL_EVTSIN
GO

CREATE procedure sysadm.PS_I_INSERTION_JOURNAL_EVTSIN
	@adcIdSin			Decimal ( 10 ),
	@asCodEvt			VarChar ( 6 ),
	@asSeriaVariable	VarChar ( 255 ),
	@asSeriaLibre		VarChar ( 255 )
AS




Go
