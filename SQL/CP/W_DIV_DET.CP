-------------------------------------------------------------------
--
-- Fichier              :       W_DIV_DET.CP
-- Auteur               :       FABRY JF
-- Date                 :       03/10/2005
--
-- Commentaires         :       Gestion de la table W_DIV_DET
--
-- Procédures           :       DW_S01_W_DIV_DET
--				PS_I01_W_DIV_DET_WKF
--				DW_D01_W_DIV_DET
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_DIV_DET
-- Auteur               :       FABRY JF
-- Date                 :       15/06/2004
-- Libellé              :        
-- Commentaires         :       Select sur la table W_DIV_DET
-- Références           :       Utilise dans W_TM_SP_SINISTRE (Liste d‚tail)
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_DIV_DET' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_DIV_DET
GO

CREATE procedure sysadm.DW_S01_W_DIV_DET
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

Select 
	id_sin,
	id_gti,
	id_detail,
	nom_zone,
	lib_label,
	id_typ_liste,
	alt_liste_codecar,
	id_typ_zone,
	alt_oblig,
	alt_prot,
	cpt_tri,
	val_nbre,
	val_mt,
	val_dte,
	val_car,
	'N',
	cpt_valide,
	cree_le,
	maj_le,
	maj_par
From 	sysadm.w_div_det
Where	id_sin = @dcIdSin

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_W_DIV_DET_WKF
-- Auteur               :       FABRY JF
-- Date                 :       05/10/2005
-- Libellé              :        
-- Commentaires         :       Insertion dans W_DIV_DET       
-- Références           :       Utilisé dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_DIV_DET_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_DIV_DET_WKF
GO

CREATE procedure sysadm.PS_I01_W_DIV_DET_WKF
        @dcIdSin        Decimal (  10,0 )   -- [PI062]
AS

 
INSERT INTO    sysadm.w_div_det
	(       
	w_div_det.id_sin,
	w_div_det.id_gti,
	w_div_det.id_detail,
	w_div_det.nom_zone,
	w_div_det.lib_label,
	w_div_det.id_typ_liste,
	w_div_det.alt_liste_codecar,
	w_div_det.id_typ_zone,
	w_div_det.alt_oblig,
	w_div_det.alt_prot,
	w_div_det.cpt_tri,
	w_div_det.val_nbre,
	w_div_det.val_mt,
	w_div_det.val_dte,
	w_div_det.val_car,
	w_div_det.cpt_valide,
	w_div_det.cree_le,
	w_div_det.maj_le,
	w_div_det.maj_par
	)

SELECT  
	div_det.id_sin,
	div_det.id_gti,
	div_det.id_detail,
	div_det.nom_zone,
	div_det.lib_label,
	div_det.id_typ_liste,
	div_det.alt_liste_codecar,
	div_det.id_typ_zone,
	div_det.alt_oblig,
	div_det.alt_prot,
	div_det.cpt_tri,
	div_det.val_nbre,
	div_det.val_mt,
	div_det.val_dte,
	div_det.val_car,
	1,
	div_det.cree_le,
	div_det.maj_le,
	div_det.maj_par

FROM    sysadm.div_det

WHERE   div_det.id_sin   = @dcIdSin

Return @@Error

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_D01_W_DIV_DET
-- Auteur               :       FPI
-- Date                 :       24/12/2010
-- Libell‚              :       
-- Commentaires         :       Suppression dans w_div_det
-- R‚f‚rences           :       W_TM_SP_SINISTRE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdDetail        Decimal (  7,0 )        (Val)
--                              @sNomZone        Varchar( 35 )        (Val)
--
-- Retourne             :       Rien
--
---------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_W_DIV_DET' AND type = 'P' )
        DROP procedure sysadm.DW_D01_W_DIV_DET
GO

CREATE procedure sysadm.DW_D01_W_DIV_DET
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
	@dcIdGti        Decimal (  7,0 ),
	@dcIdDetail        Decimal (  7,0 ),
	@sNomZone        Varchar( 35 )
AS

 DELETE FROM    sysadm.w_div_det
 WHERE          id_sin      = @dcIdSin      AND
                id_gti      = @dcIdGti      AND
                id_detail   = @dcIdDetail   AND
                nom_zone    = @sNomZone   
 
GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_I01_W_DIV_DET
-- Auteur               :       FPI
-- Date                 :       24/12/2010
-- Libell‚              :       
-- Commentaires         :       Insertion dans w_div_det
-- R‚f‚rences           :       W_TM_SP_SINISTRE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdDetail        Decimal (  7,0 )        (Val)
--                              @sNomZone        Varchar( 35 )        (Val)
--				...
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_W_DIV_DET' AND type = 'P' )
        DROP procedure sysadm.DW_I01_W_DIV_DET
GO

CREATE procedure sysadm.DW_I01_W_DIV_DET
        @dcIdSin        	Decimal (  10,0 ), -- [PI062]
	@dcIdGti        	Decimal (  7,0 ),
	@dcIdDetail     	Decimal (  7,0 ),
	@sNomZone       	Varchar( 35 ),
	@sLibLabel		Varchar(35),
        @sIdTypListe 		Varchar(5),
        @sAltListeCodecar 	Varchar(1),
        @sIdTypZone 		Varchar(3),
        @sAltOblig 		Varchar(1),
        @sAltProt 		Varchar(1),
        @iCptTri 		int,
        @iValNbre 		int,
        @dcValMt 		decimal(11,2),
        @dtValDte 		datetime,
        @sValCar 		Varchar(35),
        @dtCreeLe 		datetime,
        @dtMajLe 		datetime,
        @sMajPar 		Varchar(4)
AS
INSERT INTO sysadm.w_div_det
           (id_sin,id_gti,id_detail,nom_zone,
           lib_label,id_typ_liste,alt_liste_codecar,
           id_typ_zone,alt_oblig,alt_prot,cpt_tri,
           val_nbre,val_mt,val_dte,val_car,cpt_valide,
           cree_le,maj_le,maj_par)
     VALUES
           (@dcIdSin, @dcIdGti, @dcIdDetail, @sNomZone, 
           @sLibLabel, @sIdTypListe, @sAltListeCodecar, 
	   @sIdTypZone, @sAltOblig, @sAltProt, @iCptTri, 
           @iValNbre, @dcValMt, @dtValDte, @sValCar, 0, 
	   @dtCreeLe, @dtMajLe, @sMajPar)
GO

