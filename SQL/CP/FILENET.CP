-------------------------------------------------------------------
--
-- Fichier              :       FILENET.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion des courriers … envoyer dans FileNet
--
-- Procédures           :       DW_S01_FN_ARCHIVE
--                      :       DW_I01_FN_ARCHIVE
--                      :       DW_S01_ARCHIVE_FN_LSTDET
--                      :       PS_U01_ARCHIVE
-------------------------------------------------------------------


--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_FN_ARCHIVE
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       S‚lect sur la table FN_ARCHIVE
-- Références           :       Utilis‚ dans W_TM_ARCHIVAGE_BLOB_FN
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_FN_ARCHIVE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_FN_ARCHIVE
GO

CREATE procedure sysadm.DW_S01_FN_ARCHIVE
AS
 SELECT fn_archive.id_fn,
        fn_archive.recup_deb,
        fn_archive.recup_fin,
        fn_archive.nbr_dossier,
        fn_archive.trt_deb,
        fn_archive.fn_deb,
        fn_archive.fn_fin,
        fn_archive.trt_fin,
        fn_archive.nbr_dt,
        fn_archive.nbr_ps,
        fn_archive.nbr_pce,
        fn_archive.nbr_part,
        fn_archive.cree_le,
        fn_archive.maj_le,
        fn_archive.maj_par
 FROM   sysadm.fn_archive

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_FN_ARCHIVE
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion sur table FN_ARCHIVE
-- Références           :       W_TM_ARCHIVAGE_BLOB_FN, SqlPreview
--
-- Arguments            :       @dtRecupDeb     DateTime                (Val)
--                      :       @dcRecupFin     DateTime                (Val)
--                      :       @dcNbrDossier   Decimal (  7,0 )        (Val)
--                      :       @dtTrtDeb       DateTime                (Val)
--                      :       @dtFnDeb        DateTime                (Val)
--                      :       @dtFnFin        DateTime                (Val)
--                      :       @dtTrtFin       DateTime                (Val)
--                      :       @dcNbrDt        Decimal (  7,0 )        (Val)
--                      :       @dcNbrPs        Decimal (  7,0 )        (Val)
--                      :       @dcNbrPce       Decimal (  7,0 )        (Val)
--                      :       @dcNbrPart      Decimal (  7,0 )        (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @dtMajLe        DateTime                (Val)
--                      :       @sMajPar        Varchar (  4 )          (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_FN_ARCHIVE' AND type = 'P' )
        DROP procedure sysadm.DW_I01_FN_ARCHIVE
GO

CREATE procedure sysadm.DW_I01_FN_ARCHIVE
        @dtRecupDeb     DateTime        ,
        @dcRecupFin     DateTime        ,
        @dcNbrDossier   Decimal (  7,0 ),
        @dtTrtDeb       DateTime        ,
        @dtFnDeb        DateTime        ,
        @dtFnFin        DateTime        ,
        @dtTrtFin       DateTime        ,
        @dcNbrDt        Decimal (  7,0 ),
        @dcNbrPs        Decimal (  7,0 ),
        @dcNbrPce       Decimal (  7,0 ),
        @dcNbrPart      Decimal (  7,0 ),
        @dtCreeLe       DateTime        ,
        @dtMajLe        DateTime        ,
        @sMajPar        Varchar (  4 )  
AS
 INSERT INTO    sysadm.fn_archive
        (       fn_archive.recup_deb,
                fn_archive.recup_fin,
                fn_archive.nbr_dossier,
                fn_archive.trt_deb,
                fn_archive.fn_deb,
                fn_archive.fn_fin,
                fn_archive.trt_fin,
                fn_archive.nbr_dt,
                fn_archive.nbr_ps,
                fn_archive.nbr_pce,
                fn_archive.nbr_part,
                fn_archive.cree_le,
                fn_archive.maj_le,
                fn_archive.maj_par                )
 VALUES (       @dtRecupDeb,
                @dcRecupFin,
                @dcNbrDossier,
                @dtTrtDeb,
                @dtFnDeb,
                @dtFnFin,
                @dtTrtFin,
                @dcNbrDt,
                @dcNbrPs,
                @dcNbrPce,
                @dcNbrPart,
                @dtCreeLe,
                @dtMajLe,
                @sMajPar                )

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_ARCHIVE_FN_LSTDET
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       S‚lect sur la table ARCHIVE
-- Références           :       Utilis‚ dans W_TM_ARCHIVE_BLOB_FN (List d‚tail)
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_ARCHIVE_FN_LSTDET' AND type = 'P' )
        DROP procedure sysadm.DW_S01_ARCHIVE_FN_LSTDET
GO

CREATE procedure sysadm.DW_S01_ARCHIVE_FN_LSTDET
AS
 SELECT archive.id_sin,
        archive.id_inter,
        archive.id_doc,
        archive.alt_part,
        archive.alt_ps,
        archive.alt_pce,
        archive.valide_le,
        NULL,
        NULL,
        NULL,
        NULL
 FROM   sysadm.archive
 WHERE  archive.dte_archiv is null      AND
        archive.id_sin in ( 100565, 105345, 110035 )
 ORDER BY archive.valide_le

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_U01_ARCHIVE
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Update sur la table ARCHIVE
-- Références           :       Utilis‚ dans W_TM_ARCHIVE_BLOB_FN
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdInter      Decimal (  7,0 )        (Val)
--                      :       @dcIdDoc        Decimal (  7,0 )        (Val)
--                      :       @dcRefDocDt     Decimal (  8,0 )        (Val)
--                      :       @dcRefDocCp     Decimal (  8,0 )        (Val)
--                      :       @dcRefDocPc     Decimal (  8,0 )        (Val)
--                      :       @dcRefDocPs     Decimal (  8,0 )        (Val)
--                      :       @dcNbrSupp      Decimal ( 7,0  )        (Val)
--                      :       @sProc          Varchar ( 60   )        (R‚f)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_ARCHIVE' AND type = 'P' )
        DROP procedure sysadm.PS_U01_ARCHIVE
GO

CREATE procedure sysadm.PS_U01_ARCHIVE
        @dcIdSin        Decimal (  7,0 ), 
        @dcIdInter      Decimal (  7,0 ), 
        @dcIdDoc        Decimal (  7,0 ), 
        @dcRefDocDt     Decimal (  8,0 ), 
        @dcRefDocCp     Decimal (  8,0 ), 
        @dcRefDocPc     Decimal (  8,0 ), 
        @dcRefDocPs     Decimal (  8,0 ), 
        @dcNbrSupp      Decimal (  7,0 ),
        @sProc          Varchar ( 60   ) OUTPUT

AS

 /* ... Mise … jour dans la table ARCHIVE ... */
 Select @sProc = "Mise a Jour dans ARCHIVE"

 UPDATE sysadm.archive
 SET    archive.ref_doc_dt      = @dcRefDocDt   ,
        archive.ref_doc_cp      = @dcRefDocCp   ,
        archive.ref_doc_pc      = @dcRefDocPc   ,
        archive.ref_doc_ps      = @dcRefDocPs   ,
        archive.dte_archiv      = GetDate ()
 WHERE  archive.id_sin          = @dcIdSin              AND
        archive.id_inter        = @dcIdInter            AND
        archive.id_doc          = @dcIdDoc

 If @@RowCount <> 1 Return -1

 /* ... Suppression dans la table ARCHIVE_BLOB ... */
 Select @sProc = "Suppression dans ARCHIVE_BLOB"

 DELETE FROM    sysadm.archive_blob
 WHERE          archive_blob.id_sin     = @dcIdSin      AND
                archive_blob.id_inter   = @dcIdInter    AND
                archive_blob.id_doc     = @dcIdDoc

 If     @@RowCount = @dcNbrSupp
        Begin
                Select @sProc = ''
        End

GO
