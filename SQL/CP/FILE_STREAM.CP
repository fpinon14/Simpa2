-------------------------------------------------------------------
--
-- Fichier              :       FILE_STREAM.CP
-- Auteur               :       FABRY JF
-- Date                 :       27/02/2023
--
-- Commentaires         :       à COMPILUER sur la Base FILE_STREAM, serveur [SQL14DEV\SIMSINISTRES]
--
-- Procedures           :       
----------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_EXTRACT_DOC_GENESYS
-- Auteur               :       FABRY JF
-- Date                 :       27/02/2023
-- Libelle              :        
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_EXTRACT_DOC_GENESYS' AND type = 'P' )
        DROP procedure dbo.PS_S_EXTRACT_DOC_GENESYS
GO
CREATE procedure dbo.PS_S_EXTRACT_DOC_GENESYS
	@asCas VarChar ( 20 )
AS

Declare @sId nVarChar ( 16 ) 

If @asCas <>  'ADJONCTION' Delete dbo.ft_genesys_doc

While Exists ( Select Top 1 1 From dbo.cle_doc_genesys where marquage = 0 )
 Begin
	Select 	Top 1 
		@sId = id_cle
	From	dbo.cle_doc_genesys
	Where	marquage = 0

	Insert into dbo.ft_genesys_doc ( file_stream, name )
	Select d.Content, Upper ( rtrim ( i.Id) + '___Id_Doc_' + rTrim ( d.Id ) + '___Nom_Doc_' + rtrim ( d.TheName ) )
	FROM [SQLGENESYS\GENESYS].[GEN_MCR_UCS_ARCH].[dbo].[Interaction]		i	
	inner join [SQLGENESYS\GENESYS].[GEN_MCR_UCS_ARCH].[dbo].[Attachment] a on i.Id= a.EntityId
	inner join [SQLGENESYS\GENESYS].[GEN_MCR_UCS_ARCH].[dbo].[Document] d on a.DocumentId = d.Id
	where i.MediaTypeId	= 'email'	
	and i.Id = @sId

	Update dbo.cle_doc_genesys Set marquage = 1 Where id_cle = @sId
 End

Select * from dbo.ft_genesys_doc name

Go

