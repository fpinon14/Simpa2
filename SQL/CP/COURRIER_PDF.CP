-------------------------------------------------------------------
--
-- Fichier              :       COURRIER_PDF.CP
-- Auteur               :       FABRY JF
-- Date                 :       15/07/2025 
--
-- Commentaires         :       
--
-- Procédures           :       
-------------------------------------------------------------------
--------------------------------------------------------------------
--
-- Procédure            :       PS_I_COURRIER_PDF
-- Auteur               :       FABRY JF
-- Date                 :       15/07/2025 
-- Libellé              :        
-- Commentaires         :       
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_COURRIER_PDF' AND type = 'P' )
        DROP procedure sysadm.PS_I_COURRIER_PDF
GO

CREATE procedure sysadm.PS_I_COURRIER_PDF
        @adcIdSin        Decimal (  10,0 ), -- [PI062]
		@adcIdInter		Decimal ( 7 ),
		@adcIdCpt		Decimal ( 4 ),
		@asCodOper		VarChar ( 4 ),
		@aiIdentity		Integer Output 
AS

Declare @iError Integer 

Insert into sysadm.courrier_pdf ( 
		id_sin,
		id_i,
		id_arch,
		txt_blob,
		cree_le,
		maj_le,
		maj_par
	)
	Values
	(
		@adcIdSin,
		@adcIdInter,
		null,
		convert ( VarBinary ( max ), ' ' ),
		getdate(),
		getdate(),
		@asCodOper
	)

Set @aiIdentity = @@Identity
Set @iError = @@Error

If @@Error <> 0 Return @@Error 

Update	sysadm.w_cour_blob
Set		id_pdf = @aiIdentity 
Where	id_sin = @adcIdSin
And     id_i = @adcIdInter
And		id_cpt = @adcIdCpt

Return @@Error 

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_COURRIER_PDF_AVEC_ID_ARCH
-- Auteur               :       FABRY JF
-- Date                 :       15/07/2025 
-- Libellé              :        
-- Commentaires         :       
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_COURRIER_PDF_AVEC_ID_ARCH' AND type = 'P' )
        DROP procedure sysadm.PS_I_COURRIER_PDF_AVEC_ID_ARCH
GO

CREATE procedure sysadm.PS_I_COURRIER_PDF_AVEC_ID_ARCH
        @adcIdSin        Decimal (  10,0 ), -- [PI062]
		@adcIdInter		Decimal ( 7 ),
		@asCodOper		VarChar ( 4 ),
		@iIdArch		Integer,
		@aiIdentity		Integer Output 
AS

Declare @iError Integer 

Insert into sysadm.courrier_pdf ( 
		id_sin,
		id_i,
		id_arch,
		txt_blob,
		cree_le,
		maj_le,
		maj_par
	)
	Values
	(
		@adcIdSin,
		@adcIdInter,
		@iIdArch,
		convert ( VarBinary ( max ), ' ' ),
		getdate(),
		getdate(),
		@asCodOper
	)

Set @aiIdentity = @@Identity
Set @iError = @@Error

Return @@Error 

Go

