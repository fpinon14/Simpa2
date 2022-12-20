-------------------------------------------------------------------
--
-- Fichier              :       W_INT_BL.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion de la table W_INTER_BLOB SIMPA2
--
-- Procédures           :       IM_D01_W_INTER_BLOB
--                      :       IM_I01_W_INTER_BLOB
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_W_INTER_BLOB
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Suppression d'un blob pour un interlocuteur donn‚
-- Références           :       Utilis‚ dans W_TM_SP_SINISTRE 
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdI          Decimal (  7,0 )        (Val)
--                              @sIdTypBlob     Varchar (  2 )          (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_W_INTER_BLOB' AND type = 'P' )
        DROP procedure sysadm.IM_D01_W_INTER_BLOB
GO

CREATE procedure sysadm.IM_D01_W_INTER_BLOB
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @dcIdI          Decimal (  7,0 ),
        @sIdTypBlob     Varchar (  2 )
AS

 DELETE FROM    sysadm.w_inter_blob
 WHERE          w_inter_blob.id_sin          = @dcIdSin         AND
                w_inter_blob.id_i            = @dcIdI           AND
                w_inter_blob.id_typ_blob     = @sIdTypBlob


GO


--------------------------------------------------------------------
--
-- Procédure            :       IM_I01_W_INTER_BLOB
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion d'un blob pour un interlocuteur donn‚
-- Références           :       Utilis‚ dans W_TM_SP_SINISTRE 
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdI          Decimal (  7,0 )        (Val)
--                      :       @sIdTypBlob     Varchar (  2 )          (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @dtMajLe        DateTime                (Val)
--                      :       @sMajPar        Varchar (  4 )          (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_I01_W_INTER_BLOB' AND type = 'P' )
        DROP procedure sysadm.IM_I01_W_INTER_BLOB
GO

CREATE procedure sysadm.IM_I01_W_INTER_BLOB
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @dcIdI          Decimal (  7,0 ),
        @sIdTypBlob     Varchar (  2 )  ,
        @dtCreeLe       DateTime        ,
        @dtMajLe        DateTime        ,
        @sMajPar        Varchar (  4 )
AS

 DELETE FROM    sysadm.w_inter_blob 
 WHERE          sysadm.w_inter_blob.id_sin        = @dcIdSin       AND
                sysadm.w_inter_blob.id_i          = @dcIdI         AND
                sysadm.w_inter_blob.id_typ_blob   = @sIdTypBlob 


 INSERT INTO    sysadm.w_inter_blob
        (       w_inter_blob.id_sin,
                w_inter_blob.id_i,
                w_inter_blob.id_typ_blob,
                w_inter_blob.txt_blob,
                w_inter_blob.cree_le,
                w_inter_blob.maj_le,
                w_inter_blob.maj_par                 )
 VALUES (       @dcIdSin,
                @dcIdI,
                @sIdTypBlob,
                0x20,
                @dtCreeLe,
                @dtMajLe,
                @sMajPar                        )       

GO

