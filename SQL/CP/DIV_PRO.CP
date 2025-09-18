-------------------------------------------------------------------
--
-- Fichier              :       DIV_PRO.CP
-- Auteur               :       FABRY JF
-- Date                 :       15/06/2004
--
-- Commentaires         :       Gestion de la table DIV_PRO
--
-- Procédures           :       DW_S01_DIV_PRO
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_DIV_PRO
-- Auteur               :       FABRY JF
-- Date                 :       15/06/2004
-- Libellé              :        
-- Commentaires         :       Select sur la table DIV_PRO
-- Références           :       Utilise dans W_TM_SP_SINISTRE (Liste d‚tail)
--
-- Arguments            :       @dcIdProd        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DIV_PRO' AND type = 'P' )
        DROP procedure sysadm.DW_S01_DIV_PRO
GO

CREATE procedure sysadm.DW_S01_DIV_PRO
        @dcIdProd        Decimal (  7,0 )
AS

Select 
	id_prod,
	nom_zone,
	lib_label,
	id_typ_liste,
	alt_liste_codecar,
	id_typ_zone,
	alt_oblig,
	cpt_tri,
	cree_le,
	maj_le,
	maj_par	
From 	sysadm.div_pro
Where	id_prod = @dcIdProd

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RECUP_PARAM_ZONE_DIV_PRO
-- Auteur               :       FABRY JF
-- Date                 :       29/06/2020
-- Libellé              :        [PC202553_SELECTRA]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       @dcIdProd        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RECUP_PARAM_ZONE_DIV_PRO' AND type = 'P' )
        DROP procedure sysadm.PS_S_RECUP_PARAM_ZONE_DIV_PRO
GO

CREATE procedure sysadm.PS_S_RECUP_PARAM_ZONE_DIV_PRO
        @asdcIdProd        Decimal (  7,0 ),
		@asNomZone		   VarChar ( 35 ),
		@asIdTypListe	   VarChar ( 3 ) OUTPUT,
		@asAltListeCodeCar VarChar ( 1 ) OUTPUT,
		@asIdTypZone       Varchar ( 5 ) OUTPUT   
AS

Select 
	@asIdTypListe = id_typ_liste,
	@asAltListeCodeCar = alt_liste_codecar,
	@asIdTypZone = id_typ_zone
From 	sysadm.div_pro
Where	id_prod = @asdcIdProd
And     nom_zone = lower ( @asNomZone )

Go

--------------------------------------------------------------------
--
-- Procédure            : [sysadm].[DW_S01_DIV_PRO_SHERPA]
-- Auteur               : FS
-- Date                 : 16/09/2025
-- Libellé              : [MIG225] Cdiscount (mais utilisable pour tous les produits)
-- Commentaires         : Chargement du mapping div_pro : source Sherpa --> cible Simpa2      
-- Références           : Utilisé par Sherpa pour alimenter div_sin      
--
-- Arguments            : @dcIdProd        Decimal (  7,0 )        (Val)
--
-- Retourne             : Liste des colonnes mappées sur Div_Pro
-------------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('sysadm.DW_S01_DIV_PRO_SHERPA') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[DW_S01_DIV_PRO_SHERPA]
GO

-- [sysadm].[DW_S01_DIV_PRO_SHERPA] [MIG225] FS le 16/09/2025 lecture div_pro par Sherpa
CREATE procedure [sysadm].[DW_S01_DIV_PRO_SHERPA]
      @dcIdProd        Decimal (  7,0 )
AS

Select 
	id_prod,
	nom_zone as id_dst_simpa,
	id_src_sherpa,
	typ_src_sherpa,
	isnull(lg_src_sherpa,0) as lg_src_sherpa
From 	sysadm.div_pro
Where	
	id_prod = @dcIdProd And
	id_src_sherpa is not null
order by typ_src_sherpa, id_src_sherpa


GO

grant execute on [sysadm].[DW_S01_DIV_PRO_SHERPA] to rolebddsinistres
Go

