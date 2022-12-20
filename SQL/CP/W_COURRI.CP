-------------------------------------------------------------------
--
-- Fichier              :       W_COURRI.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion de la table W_COURRIER SIMPA2
--
-- Procédures           :       DW_S01_W_COURRIER
--                              DW_I01_W_COURRIER
--				DW_D01_W_COURRIER
--				DW_D02_W_COURRIER
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_COURRIER
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Select sur la table W_COURRIER
-- Références           :       Utilisé dans W_TM_SP_SINISTRE 
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-- #1	PHG	06/11/2006	[DNTMAIL1-2] Ajout du canal ( Id_Canal )
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_COURRIER' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_COURRIER
GO

CREATE procedure sysadm.DW_S01_W_COURRIER
        @dcIdSin        Decimal (  10, 0 ) -- [PI062]
AS
 SELECT w_courrier.id_sin,
        w_courrier.id_i,
        w_courrier.id_cpt,
        w_courrier.id_cour,
        w_courrier.alt_part,
        w_courrier.alt_pce,
        w_courrier.alt_ps,
        w_courrier.txt_compo1,
        w_courrier.txt_compo2,
        w_courrier.id_i_db,
        w_courrier.cree_le,
        w_courrier.maj_le,
        w_courrier.maj_par,
        w_courrier.id_cour_orig,
        w_courrier.id_canal -- #1 [DNTMAIL1-2]

 FROM   sysadm.w_courrier
 WHERE  w_courrier.id_sin = @dcIdSin

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_W_COURRIER
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion sur table W_COURRIER
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdsin        Decimal (  7,0 )        (Val)
--                      :       @dcIdI          Decimal (  7,0 )        (Val)
--                      :       @dcIdCpt        Decimal (  4,0 )        (Val)
--                      :       @sIdCour        Varchar (  6 )          (Val)
--                      :       @sAltPart       Varchar (  1 )          (Val)
--                      :       @sAltPce        Varchar (  1 )          (Val)
--                      :       @sAltPS         Varchar (  1 )          (Val)
--                      :       @sTxtCompo1     Varchar ( 248 )         (Val)
--                      :       @sTxtCompo2     Varchar ( 248 )         (Val)
--                      :       @dcIdIDb        Decimal (  7,0 )        (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @dtMajLe        DateTime                (Val)
--                      :       @sMajPar        Varchar (  4 )          (Val)
--				@sIdCourOrig	VarChar ( 6 )		(Val)
--			:	@sIdCanal	Varchar ( 2 )		(Val) -- #1 [DNTMAIL1-2]
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-- #1	PHG	06/11/2006	[DNTMAIL1-2] Ajout du canal ( Id_Canal )
--      JFF 12/02/2016  [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_W_COURRIER' AND type = 'P' )
        DROP procedure sysadm.DW_I01_W_COURRIER
GO

CREATE procedure sysadm.DW_I01_W_COURRIER
        @dcIdsin        Decimal (  10,0 ), -- [PI062]
        @dcIdI          Decimal (  7,0 ),
        @dcIdCpt        Decimal (  4,0 ),
        @sIdCour        Varchar (  6 )  ,
        @sAltPart       Varchar (  1 )  ,
        @sAltPce        Varchar (  1 )  ,
        @sAltPs         Varchar (  1 )  ,
        @sTxtCompo1     Varchar ( 248 ) ,
        @sTxtCompo2     Varchar ( 248 ) ,
        @dcIdIDb        Decimal ( 7,0 ) ,
        @dtCreeLe       DateTime        ,
        @dtMajLe        DateTime        ,
        @sMajPar        Varchar (  4 )  ,
        @sIdCourOrig	VarChar ( 6 ),
	@sIdCanal	Varchar ( 2 ) -- #1 [DNTMAIL1-2]

AS
 INSERT INTO    sysadm.w_courrier
        (       w_courrier.id_sin,
                w_courrier.id_i,
                w_courrier.id_cpt,
                w_courrier.id_cour,
                w_courrier.alt_part,
                w_courrier.alt_pce,
                w_courrier.alt_ps,
                w_courrier.txt_compo1,
                w_courrier.txt_compo2,
                w_courrier.id_i_db,
                w_courrier.cree_le,
                w_courrier.maj_le,
                w_courrier.maj_par,
                w_courrier.id_cour_orig,
		w_courrier.id_canal -- #1 [DNTMAIL1-2]
       )
 VALUES (       @dcIdsin,
                @dcIdI,
                @dcIdCpt,
                @sIdCour,
                @sAltPart,
                @sAltPce,
                @sAltPs,
                @sTxtCompo1,
                @sTxtCompo2,
                @dcIdIDb,
                @dtCreeLe,
                @dtMajLe,
                @sMajPar,
                @sIdCourOrig,
		@sIdCanal -- #1 [DNTMAIL1-2]
	)
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_W_COURRIER
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Suppression de tous les courriers de W_COURRIER
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--				@sMethode	VarChar (  3 )		(Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_W_COURRIER' AND type = 'P' )
        DROP procedure sysadm.DW_D01_W_COURRIER
GO

CREATE procedure sysadm.DW_D01_W_COURRIER
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sMethode	VarChar ( 3 )
AS

 If @sMethode = 'SVE' 
  DELETE FROM    sysadm.w_cour_blob
  WHERE          w_cour_blob.id_sin     = @dcIdSin
 Else
  DELETE FROM    sysadm.w_inter_blob
  WHERE          w_inter_blob.id_sin          = @dcIdSin         AND
                 w_inter_blob.id_typ_blob     = 'DT'   


 DELETE FROM    sysadm.w_courrier
 WHERE          w_courrier.id_sin          = @dcIdSin

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_D02_W_COURRIER
-- Auteur               :       Fabry JF
-- Date                 :       10/07/01
-- Libellé              :       
-- Commentaires         :       Suppression de tous les courriers de W_COURRIER
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--				@sMethode	VarChar (  3 )		(Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D02_W_COURRIER' AND type = 'P' )
        DROP procedure sysadm.DW_D02_W_COURRIER
GO

CREATE procedure sysadm.DW_D02_W_COURRIER
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sMethode	VarChar ( 3 )
AS

 If @sMethode = 'SVE' 
  DELETE FROM    sysadm.w_cour_blob
  WHERE          w_cour_blob.id_sin     = @dcIdSin
 Else
  DELETE FROM    sysadm.w_inter_blob
  WHERE          w_inter_blob.id_sin          = @dcIdSin


 DELETE FROM    sysadm.w_courrier
 WHERE          w_courrier.id_sin          = @dcIdSin

 UPDATE sysadm.w_inter
 SET	alt_part = 'N',
 	alt_pce  = 'N',
 	alt_ps   = 'N',
 	alt_quest= 'N',
 	id_cour  = null,
 	id_nat_cour = null
 WHERE          w_inter.id_sin          = @dcIdSin
GO

