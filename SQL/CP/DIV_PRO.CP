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
