----------------------------------------------------------------------------------------------
-- histo_validation.cp
--
-- PS_I01_HISTO_VALIDATION_V01 FS le 11/08/2008 Enregistrement trace des doubles validation
-- PS_I01_HISTO_VALIDATION_V02 FPI le 19/08/2008 Ajout de colonnes dans HISTO_VALIDATION
-- PS_S01_HISTO_VALIDATION_NIVEAU_CONF FPI le 19/08/2008
----------------------------------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_HISTO_VALIDATION_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I01_HISTO_VALIDATION_V01
GO

CREATE PROC sysadm.PS_I01_HISTO_VALIDATION_V01
 @iIdSin 	int,
 @dMontant	decimal(11,2),
 @sValidePar	varchar(4),
 @sCompte	varchar(4),
 @sMessage	varchar(500)

AS

------------------------------------------------------------------------------------------
-- PS_I01_HISTO_VALIDATION_V01 FS le 11/08/2008 Enregistrement trace des doubles validation
------------------------------------------------------------------------------------------

  INSERT INTO sysadm.histo_validation(id_sin, montant, valide_le, valide_par, compte, message)
  VALUES( @iIdSin,@dMontant, getdate(), @sValidePar,		 @sCompte, @sMessage)

GO

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_HISTO_VALIDATION_V02' AND type = 'P' )
        DROP procedure sysadm.PS_I01_HISTO_VALIDATION_V02
GO

CREATE PROC sysadm.PS_I01_HISTO_VALIDATION_V02
 @iIdSin 	int,
 @dMontant	decimal(11,2),
 @sValidePar	varchar(4),
 @sCompte	varchar(4),
 @sMessage	varchar(500),
 @iIdNiveau int,
 @sAltConf char(1)

AS

  INSERT INTO sysadm.histo_validation(id_sin, montant, valide_le, valide_par, compte, message,id_niveau,alt_niveau_conf)
  VALUES( @iIdSin,@dMontant, getdate(), @sValidePar, @sCompte, @sMessage, @iIdNiveau, @sAltConf)

GO

------------------------------------------------------------------------------------------------------
-- PS_S01_HISTO_VALIDATION_NIVEAU_CONF : Renvoie un flag "se souvenir de la validation pour ce niveau"
------------------------------------------------------------------------------------------------------
-- FPI - 18/12/2008 - Correction pour lignes "caduques" du à un changement dans la matrice des niveaux/montant
------------------------------------------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_HISTO_VALIDATION_NIVEAU_CONF' AND type = 'P' )
        DROP procedure sysadm.PS_S01_HISTO_VALIDATION_NIVEAU_CONF
GO

CREATE PROC sysadm.PS_S01_HISTO_VALIDATION_NIVEAU_CONF
 @iIdSin 	int,
 @iIdNiveau int

AS

  DECLARE  @dcMontant decimal(11,2)
  DECLARE @iIdProd int
  DECLARE @iIdUo int
  DECLARE @iIdNiveauRequis int
  DECLARE @sAltConf Char(1)

  SET @sAltConf='N'

  Select top 1 @dcMontant=montant From sysadm.histo_validation 
  where id_sin=@iIdSin and id_niveau = @iIdNiveau and alt_niveau_conf='O'
  order by valide_le Desc

  If @@ROWCOUNT = 1
  BEGIN 

		-- Recherche du produit lié au sinistre
	
		Select @iIdProd=id_prod from sysadm.sinistre where id_sin = @iIdSin
	
		-- Non Trouvé : recherche dans w_sin
	
		If @@ROWCOUNT = 0
			Begin
			  Select @iIdProd=id_prod from sysadm.w_sin where id_sin = @iIdSin
			End

		-- Lecture Uo associé au produit
	
		EXEC @iIdUo = sysadm.PS_LIRE_UO_V01 @iIdProd	
		
		If master.dbo.SPB_FN_TYPEBASE( db_id() ) = 'PRO'
			EXEC SESAME_PRO.sysadm.PS_S01_NIVEAU_REQUIS_V01 @iIdUo, @dcMontant, @iIdNiveauRequis OUTPUT
		Else
			EXEC SESAME_SIM.sysadm.PS_S01_NIVEAU_REQUIS_V01 @iIdUo, @dcMontant, @iIdNiveauRequis OUTPUT
	
		If @iIdNiveauRequis = @iIdNiveau
			BEGIN
				 SET @sAltConf='O' 
			END
	 
  END
  
  Select @sAltConf as alt_conf
  
  -- FPI - 18/12/2008 - Ci-dessous l'ancien code
  /*

  SET @sAltConf='N'

  Select @iIdSin=id_sin From histo_validation 
  where id_sin=@iIdSin and id_niveau >= @iIdNiveau and alt_niveau_conf='O'

  If @@ROWCOUNT = 1 
  BEGIN SET @sAltConf='O' END
  
  Select @sAltConf as alt_conf
*/
  
  
  GO


