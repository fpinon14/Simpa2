-------------------------------------------------------------------
--
-- Fichier              :       W_COUR_BLOB.CP
-- Auteur               :       Fabry JF
-- Date                 :       12/03/2004
--
-- Commentaires         :       Gestion de la table W_COUR_BLOB SIMPA2
--
-- Procédures           :       DW_S01_W_COUR_BLOB
--				DW_S02_W_COUR_BLOB
--                      :       
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_COUR_BLOB
-- Auteur               :       Fabry JF
-- Date                 :       12/03/2004 
-- Libellé              :        
-- Commentaires         :       Sélect sur la table W_COUR_BLOB
-- Références           :       
--                              
-- Arguments            :       @dcIdSin         Decimal ( 7 )         ( Val )
--                              @sTypeTrt       Varchar (  4 )          ( Val )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_COUR_BLOB' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_COUR_BLOB
GO

CREATE procedure sysadm.DW_S01_W_COUR_BLOB
        @dcIdSin         Decimal ( 10 ), -- [PI062]
        @sTypeTrt        VarChar ( 4 )
AS
 
 SELECT wb.id_sin,
        wb.id_i,
        wb.id_cpt,
        wb.id_typ_blob,
	wb.id_typ_doc,
        wb.cree_le,
        wb.maj_le,
        wb.maj_par
 FROM   sysadm.w_cour_blob wb
        INNER JOIN sysadm.w_courrier  wr ON 
 	  		wb.id_sin      = @dcIdSin          AND
		        wb.id_sin      = wr.id_sin         AND
        		wb.id_i        = wr.id_i           AND
		        wb.id_cpt      = wr.id_cpt
 WHERE  wb.id_typ_blob = 'DO'
 AND    ( wr.alt_part = 'O' Or @sTypeTrt = 'TOUT' )

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_W_COUR_BLOB
-- Auteur               :       Abdmeziem Catherine
-- Date                 :       09/11/2004
-- Libellé              :        
-- Commentaires         :       Sélect sur la table W_COUR_BLOB
-- Références           :       
--                              
-- Arguments            :       @dcIdSin         Decimal ( 7 )         ( Val )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_W_COUR_BLOB' AND type = 'P' )
        DROP procedure sysadm.DW_S02_W_COUR_BLOB
GO

CREATE procedure sysadm.DW_S02_W_COUR_BLOB
        @dcIdSin         Decimal ( 10 ) -- [PI062]
AS
 
 SELECT wb.id_sin,
        wb.id_i,
        wb.id_cpt,
        wb.id_typ_blob,
	wb.id_typ_doc,
        wb.cree_le,
        wb.maj_le,
        wb.maj_par
 FROM   sysadm.w_cour_blob wb
 WHERE  wb.id_sin      = @dcIdSin
 
GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_W_COUR_BLOB
-- Auteur               :       Fabry JF
-- Date                 :       17/10/2001 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table W_COUR_BLOB
-- Références           :       
--
-- Arguments            :       @dcIdSin         Decimal (7)            (Val)
--                      :       @dcIdI           Decimal (7)	        (Val)
--                      :       @dcIdCpt         Decimal (4)            (Val)
--                      :       @sIdTypBlob      Varchar (  2   )        (Val)
--                      :       @iIdTypDoc       Integer                 (Val)
--                      :       @dtCreeLe        DateTime                (Val)
--                      :       @dtMajLe         DateTime                (Val)
--                      :       @sMajPar         Varchar (  4   )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_W_COUR_BLOB' AND type = 'P' )
        DROP procedure sysadm.DW_I01_W_COUR_BLOB
GO
CREATE procedure sysadm.DW_I01_W_COUR_BLOB
	@dcIdSin         Decimal (10)            , --  [PI062]
	@dcIdI           Decimal (7)	        ,
	@dcIdCpt         Decimal (4)            ,
	@sIdTypBlob      Varchar (  2   )       ,
	@iIdTypDoc       Integer                ,
	@dtCreeLe        DateTime               ,
	@dtMajLe         DateTime               ,
	@sMajPar         Varchar (  4   )       

AS
 INSERT INTO    sysadm.w_cour_blob
        (       w_cour_blob.id_sin,
                w_cour_blob.id_i,
                w_cour_blob.id_cpt,
                w_cour_blob.id_typ_blob,
                w_cour_blob.id_typ_doc,
                w_cour_blob.txt_blob,
                w_cour_blob.cree_le,
                w_cour_blob.maj_le,
                w_cour_blob.maj_par )
 VALUES (       @dcIdSin,
                @dcIdI,
                @dcIdCpt,
                @sIdTypBlob,
                @iIdTypDoc,
                ' ',
                @dtCreeLe,
                @dtMajLe,
                @sMajPar )

GO

