-------------------------------------------------------------------
--
-- Fichier              :       W_REFUS.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion des refus dans SIMPA2
--
-- Procédures           :       DW_S01_W_REFUS
--                              DW_I01_W_REFUS
--                              PS_I01_W_REFUS_WKF
--                              DW_D01_W_REFUS
--								PS_I_W_REFUS_PM322
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_REFUS
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :
-- Commentaires         :       Sélect sur la table W_REFUS
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_REFUS' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_REFUS
GO

CREATE procedure sysadm.DW_S01_W_REFUS
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS
 SELECT w_refus.id_sin,
        w_refus.id_gti,
        w_refus.id_detail,
        w_refus.id_motif,
        w_refus.alt_mac,
        w_refus.alt_ope,
        w_refus.id_i,
        w_refus.id_para,
        w_refus.cpt_tri,
        w_refus.cree_le,
        w_refus.maj_le,
        w_refus.maj_par,
        paragraphe.cpt_ver,
        code.lib_code,
        w_refus.alt_mac,
        w_refus.alt_ope,
        w_refus.id_i,
--ajout Migration PB4 PB8 WYNIWYG 03/2006
cast (null as varchar) as 'alt_init_id_i'

 FROM   sysadm.w_refus,
        sysadm.paragraphe,
        sysadm.code
 WHERE  w_refus.id_sin          = @dcIdSin              AND
        w_refus.id_para         = paragraphe.id_para    AND    
        w_refus.id_motif        = code.id_code          AND
        code.id_typ_code        = '+RE'

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_W_REFUS
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion sur table W_REFUS
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdGti        Decimal (  7,0 )        (Val)
--                      :       @dcIdDetail     Decimal (  7,0 )        (Val)
--                      :       @dcIdMotif      Decimal (  7,0 )        (Val)
--                      :       @sAltMac        Varchar (  1 )          (Val)
--                      :       @sAltOpe        Varchar (  1 )          (Val)
--                      :       @dcIdI          Decimal (  7,0 )        (Val)
--                      :       @sIdPara        Varchar (  1 )          (Val)
--                      :       @dcCptTri       Decimal (  2,0 )        (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @dtMajLe        DateTime                (Val)
--                      :       @sMajPar        Varchar (  4 )          (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_W_REFUS' AND type = 'P' )
        DROP procedure sysadm.DW_I01_W_REFUS
GO

CREATE procedure sysadm.DW_I01_W_REFUS
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdGti        Decimal (  7,0 ),
        @dcIdDetail     Decimal (  7,0 ),
        @dcIdMotif      Decimal (  7,0 ),
        @sAltMac        Varchar (  1 )  ,
        @sAltOpe        Varchar (  1 )  ,
        @dcIdI          Decimal (  7,0 ),
        @sIdPara        Varchar (  4 )  ,
        @dcCptTri       Decimal (  2,0 ),
        @dtCreeLe       DateTime        ,
        @dtMajLe        DateTime        ,
        @sMajPar        Varchar (  4 )
AS
 INSERT INTO    sysadm.w_refus
        (       w_refus.id_sin,
                w_refus.id_gti,
                w_refus.id_detail,
                w_refus.id_motif,
                w_refus.alt_mac,
                w_refus.alt_ope,
                w_refus.id_i,
                w_refus.id_para,
                w_refus.cpt_tri,
                w_refus.cree_le,
                w_refus.maj_le,
                w_refus.maj_par         )
 VALUES (       @dcIdSin,
                @dcIdGti,
                @dcIdDetail,
                @dcIdMotif,
                @sAltMac,
                @sAltOpe,
                @dcIdI,
                @sIdPara,
                @dcCptTri,
                @dtCreeLe,
                @dtMajLe,
                @sMajPar                )

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_W_REFUS
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Suppression de la liste des refus d'une garantie
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdDetail     Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_W_REFUS' AND type = 'P' )
        DROP procedure sysadm.DW_D01_W_REFUS
GO

CREATE procedure sysadm.DW_D01_W_REFUS
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdGti        Decimal (  7,0 ),
        @dcIdDetail     Decimal (  7,0 )
AS
 DELETE FROM    sysadm.w_refus
 WHERE          w_refus.id_sin          = @dcIdSin      AND
                w_refus.id_gti          = @dcIdGti      AND        
                w_refus.id_detail       = @dcIdDetail

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_W_REFUS_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans W_REFUS
-- Références           :       Utilisé dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_REFUS_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_REFUS_WKF
GO

CREATE procedure sysadm.PS_I01_W_REFUS_WKF
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @dcIdProd       Decimal (  7,0 )
AS
 INSERT INTO    sysadm.w_refus
        (       w_refus.id_sin,
                w_refus.id_gti,
                w_refus.id_detail,
                w_refus.id_motif,
                w_refus.alt_mac,
                w_refus.alt_ope,
                w_refus.id_i,
                w_refus.id_para,
                w_refus.cpt_tri,
                w_refus.cree_le,
                w_refus.maj_le,
                w_refus.maj_par )
 SELECT         refus.id_sin,
                refus.id_gti,
                refus.id_detail,
                refus.id_motif,
                refus.alt_mac,
                refus.alt_ope,
                refus.id_i,
                refus.id_para,
                motif.cpt_tri,
                refus.cree_le,
                refus.maj_le,
                refus.maj_par
 FROM           sysadm.refus,
                sysadm.motif
 WHERE          refus.id_sin    = @dcIdSin              AND
                motif.id_prod   = @dcIdProd             AND
                motif.id_rev    = -1                    AND
                refus.id_motif  = motif.id_motif        AND
                refus.id_gti    = motif.id_gti

 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_W_REFUS_PM322
-- Auteur               :       Fabry JF
-- Date                 :       02/02/2016
-- Libellé              :        
-- Commentaires         :       Insertion dans W_REFUS
-- Références           :       Utilisé dans W_T_SP_CREE_TRAVAIL
--
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_W_REFUS_PM322' AND type = 'P' )
        DROP procedure sysadm.PS_I_W_REFUS_PM322
GO

CREATE procedure sysadm.PS_I_W_REFUS_PM322
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
		@dcIdMotif		Decimal (  7,0 ),
		@dcIdInterCour  Decimal (  7,0 ),
		@sCodOper		VarChar ( 4 )
AS

If @sCodOper is null Or lTrim ( rTrim ( @sCodOper )) = '' Set @sCodOper = 'SHPP'

Insert into sysadm.w_refus
Select  Top 1
		@dcIdSin,
		wg.id_gti,
		-1,
		@dcIdMotif,
		'N',
		'O',
		@dcIdInterCour,
		m.id_para,
		m.cpt_tri,
		Getdate(),
		GetDate(),
		@sCodOper
From	sysadm.motif m,
		sysadm.w_sin ws,
		sysadm.w_gar_sin wg
Where   ws.id_sin = @dcIdSin
And     wg.id_sin = ws.id_sin
And     m.id_prod = ws.id_prod
And		m.id_gti = wg.id_gti
And		m.id_motif = @dcIdMotif
And     m.cod_typ_motif = 'G'
And		Not Exists ( 
			Select	Top 1 1
			From	sysadm.w_refus r
			Where   r.id_sin = ws.id_sin
			And		r.id_gti  = wg.id_gti
			And     r.id_detail = -1
			And     r.id_motif =  m.id_motif
		)

-- demande Fred par mail le 15/03/16
Delete	sysadm.w_piece
From	sysadm.w_piece p,
		sysadm.w_refus r
Where   r.id_sin = @dcIdSin
And  	r.id_motif = @dcIdMotif
And		r.id_sin = p.id_sin
And		r.id_gti = p.id_gti

Go
