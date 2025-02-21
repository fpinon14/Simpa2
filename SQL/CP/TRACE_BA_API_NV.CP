-------------------------------------------------------------------
--
-- Fichier              :       TRACE_BA_API_NV.CP
-- Auteur               :       FABRY JF
-- Date                 :       21/02/2025
--								
-- Commentaires         :       
--
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_TRACE_BA_API_NV
-- Auteur               :       JFF
-- Date                 :       21/02/2025
-- Libelle              :       
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_TRACE_BA_API_NV' AND type = 'P' )
        DROP procedure sysadm.PS_I_TRACE_BA_API_NV
GO

CREATE procedure sysadm.PS_I_TRACE_BA_API_NV
	@adcIdSin decimal(10),
	@aiIdSeq Integer,
	@asIdFour VarChar (3),
	@adcMtBonAchat Decimal(11, 2),
	@asAdrMail VarChar(128),
	@asIdContratAbonne VarChar(40),
	@asInfoCplt  VarChar(500),
	@asCodOper VarChar(4) 
AS

Insert into sysadm.trace_ba_api_nv 
	( 
		id_sin,
		id_seq,
		id_four,
		mt_bon_achat,
		adr_mail,
		id_contrat_abonne,
		info_cplt,
		cree_le,
		maj_le,
		maj_par
	)
	Values
	(
		@adcIdSin,
		@aiIdSeq,
		@asIdFour,
		@adcMtBonAchat,
		@asAdrMail,
		@asIdContratAbonne,
		@asInfoCplt,
		Getdate(),
		Getdate(),
		@asCodOper		
	)

Go