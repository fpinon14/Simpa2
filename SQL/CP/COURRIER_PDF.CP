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
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
		@dcIdInter		Decimal ( 7 ),
		@dcIdCpt		Decimal ( 2 )
AS
 
Insert into sysadm.courrier_pdf ( 
		

	)


Go
