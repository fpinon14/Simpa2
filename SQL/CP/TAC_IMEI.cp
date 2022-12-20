-------------------------------------------------------------------
--
-- Fichier              :       TAC_IMEI.CP
-- Auteur               :       PINON F.
-- Date                 :       15/01/2009
--
-- Commentaires         :       Liste des procédures afférant à la table TAC_IMEI
--                              pour SIMPA2
--
-- Procédures           :      	DW_S01_TAC_IMEI
--				PS_S01_TAC_IMEI
--				PS_I01_TAC_IMEI - FPI - 15/01/2009
--				PS_D01_TAC_IMEI - FPI - 15/01/2009
--				
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :      DW_S01_TAC_IMEI
-- Auteur               :      FABRY JF
-- Date                 :      22/08/2006
-- Libellé              :      Selection de toutes les marques et modèles connu par SFR
-- Commentaires         :      
-- Références           :       d_lst_tac_imei
--
-- Arguments            :      
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_TAC_IMEI' AND type = 'P' )
            DROP procedure sysadm.DW_S01_TAC_IMEI
GO

CREATE procedure sysadm.DW_S01_TAC_IMEI
AS
 SELECT id_tac,
	marque,
	modele

 FROM   sysadm.tac_imei
 

GO


--------------------------------------------------------------------
--
-- Procédure            :      PS_S01_TAC_IMEI
-- Auteur               :      FABRY JF
-- Date                 :      22/08/2006
-- Libellé              :      
-- Commentaires         :      
-- Références           :   	u_gs_sp_sinistre.uf_controlersaisie_tacimei
--				w_tm_sp_w_gar_sin.wf_condition_tac
--
-- Arguments            :      
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_TAC_IMEI' AND type = 'P' )
            DROP procedure sysadm.PS_S01_TAC_IMEI
GO

CREATE procedure sysadm.PS_S01_TAC_IMEI
        @iIdTac         integer,
        @sMarque        VarChar (35) OUTPUT,
        @sModele        VarChar (35) OUTPUT
AS
 SELECT @sMarque = t.marque,
        @sModele = t.modele

 FROM   sysadm.tac_imei t
 Where  Right ( '00000000' + convert ( varchar ( 8 ), t.id_tac ), 8 ) = Right ( '00000000' + convert ( varchar ( 8 ), @iIdTac ), 8 )
 

GO

--------------------------------------------------------------------
--
-- Procédure            :      PS_I01_TAC_IMEI
-- Auteur               :      FPI
-- Date                 :      15/01/2009
-- Libellé              :      Insertion dans tac_imei
-- Commentaires         :      
-- Références           :      
--
-- Arguments            :      
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TAC_IMEI' AND type = 'P' )
            DROP procedure sysadm.PS_I01_TAC_IMEI
GO

CREATE PROC sysadm.PS_I01_TAC_IMEI
  @iIdTac			int,
  @sMarque			varchar(35),
  @sModele			varchar(35),
  @sMajPar 			varchar(4),
  @sAltTraite Varchar(1) OUTPUT
AS
	Set @sAltTraite = 'O'
	
	Insert Into sysadm.tac_imei(
		id_tac,
		marque, 
		modele, 
		cree_le, 
		maj_le, 
		maj_par)
	Values (
		@iIdTac,
		@sMarque, 
		@sModele, 
		getdate(), 
		getdate(),
		@sMajPar)


	If @@Rowcount <> 1 
	Begin 
	  Set @sAltTraite = 'N'	
	End 
	
	Return @@Error
Go

--------------------------------------------------------------------
--
-- Procédure            :      PS_D01_TAC_IMEI
-- Auteur               :      FPI
-- Date                 :      15/01/2009
-- Libellé              :      Vidage de la table tac_imei
-- Commentaires         :      
-- Références           :      
--
-- Arguments            :      
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_TAC_IMEI' AND type = 'P' )
            DROP procedure sysadm.PS_D01_TAC_IMEI
GO

CREATE PROC sysadm.PS_D01_TAC_IMEI
AS
	Delete from sysadm.tac_imei
	
Go
 