-------------------------------------------------------------------
--
-- Fichier              :       REF_CODIC_DARTY.CP
-- Auteur               :       FABRY JF
-- Date                 :       29/12/2004
--
-- Commentaires         :       Liste des procédures afférant à la table REF_CODIC_DARTY
--                              pour SIMPA2
--
-- Procédures           :       DW_S01_REF_CODIC_DARTY
--                              DW_S02_REF_CODIC_DARTY
--				              	PS_I01_REF_CODIC_DARTY - [DCMP80862]   
--				                    
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :      DW_S01_REF_CODIC_DARTY
-- Auteur               :      FABRY JF
-- Date                 :      29/09/2004
-- Libellé              :      Selection de toutes les marques et modèles connu par DARTY pour DDDW
-- Commentaires         :      
-- Références           :      
--
-- Arguments            :      
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_REF_CODIC_DARTY' AND type = 'P' )
            DROP procedure sysadm.DW_S01_REF_CODIC_DARTY
GO

CREATE PROC sysadm.DW_S01_REF_CODIC_DARTY
  @sCas         Varchar ( 10 )  
AS

 If Upper ( @sCas ) = 'MARQUE'
  Begin
        SELECT  distinct 
                provenance,
                type_app,
                marque, 
                Convert ( VarChar ( 35 ), null ),
                Convert ( integer, null )

        FROM  sysadm.ref_codic_darty
  End 
  
 Else
  Begin
        SELECT  distinct 
                provenance,
                type_app,
                marque, 
                modele,
                codic
        FROM  sysadm.ref_codic_darty
   End 
 
Go

--------------------------------------------------------------------
--
-- Procédure            :      DW_S02_REF_CODIC_DARTY
-- Auteur               :      FABRY JF
-- Date                 :      29/09/2004
-- Libellé              :      Selection de toutes les marques et modèles connu par DARTY avec codic
-- Commentaires         :      
-- Références           :      
--
-- Arguments            :      
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_REF_CODIC_DARTY' AND type = 'P' )
            DROP procedure sysadm.DW_S02_REF_CODIC_DARTY
GO

CREATE PROC sysadm.DW_S02_REF_CODIC_DARTY
AS

Select  id_seq,
        provenance ,
        type_app,
        codic,
        marque,
        modele,
        cree_le,
        maj_le,
        maj_par 
FROM  sysadm.ref_codic_darty
  
Go


--------------------------------------------------------------------
--
-- Procédure            :      PS_I01_REF_CODIC_DARTY
-- Auteur               :      FPI
-- Date                 :      12/12/2008
-- Libellé              :      Insertion de codic darty
-- Commentaires         :      [DCMP80862]
-- Références           :      
--
-- Arguments            :      
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_REF_CODIC_DARTY' AND type = 'P' )
            DROP procedure sysadm.PS_I01_REF_CODIC_DARTY
GO

CREATE PROC sysadm.PS_I01_REF_CODIC_DARTY
  @sProvenance 		varchar(3),
  @sTypeApp			varchar(3),
  @iCodic			int,
  @sMarque			varchar(35),
  @sModele			varchar(35),
  @sMajPar 			varchar(4),
  @sAltTraite Varchar(1) OUTPUT
AS
	Set @sAltTraite = 'O'
	
	If Exists (Select * 
		   from 	sysadm.ref_codic_darty r
		   Where  r.codic = @iCodic)
	Begin
		Set @sAltTraite = 'N'	
		Return @@Error
	 End 
	
	Insert Into sysadm.ref_codic_darty(provenance, type_app, codic,
		marque, modele, cree_le, maj_le, maj_par)
	Values (Upper(@sProvenance),Upper(@sTypeApp), @iCodic,
		Upper(@sMarque), Upper(@sModele), getdate(), getdate(),@sMajPar)


	If @@Rowcount <> 1 
	Begin 
	  Set @sAltTraite = 'N'	
	End 
	
	Return @@Error
Go