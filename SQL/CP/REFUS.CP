-------------------------------------------------------------------
--
-- Fichier              :       REFUS.CP
-- Auteur               :       PLJ
-- Date                 :       28/07/1198
--
-- Commentaires         :       Gestion des refus dans SIMPA2
--
-- Procédures           :       DW_S01_REFUS
--                              PS_I01_REFUS_VAL
--                              
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_REFUS
-- Auteur               :       PLJ
-- Date                 :       28/07/1998
-- Libell‚              :        
-- Commentaires         :       Select sur la table REFUS
-- R‚f‚rences           :       Utilis‚ dans W_CM_SP_SINISTRE 
--
-- Arguments            :       @dcIdSin        Decimal ( 7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_REFUS' AND type = 'P' )
        DROP procedure sysadm.DW_S01_REFUS
GO
/*-------------------------------------------------------------------
[DATABASE] SIMPA2_PRO
[DESCRIPTION] 
[MAJ PAR] DATAFLY - AFX
[DATEMAJ] 15/10/2009

[VARIABLES]
    @dcIdSin DECIMAL(7, 0)
-------------------------------------------------------------------*/
CREATE PROCEDURE [sysadm].[DW_S01_REFUS]
 @dcIdSin DECIMAL(10, 0) -- [PI062]
AS 
    SELECT  refus.id_sin,
            refus.id_gti,
            refus.id_detail,
            refus.id_motif,
            refus.alt_mac,
            refus.alt_ope,
            refus.id_i,
            refus.id_para,
            refus.cree_le,
            refus.maj_le,
            refus.maj_par,
            paragraphe.cpt_ver,
            code.lib_code
    FROM    sysadm.refus
            INNER JOIN sysadm.code ON sysadm.refus.id_motif = sysadm.code.id_code
            LEFT OUTER JOIN sysadm.paragraphe ON sysadm.refus.id_para = sysadm.paragraphe.id_para
    WHERE   refus.id_sin = @dcIdSin
            AND code.id_typ_code = '+RE'

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_REFUS_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table REFUS
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--                      :       @iType          Integer                 (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_REFUS_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_REFUS_VAL
GO

CREATE procedure sysadm.PS_I01_REFUS_VAL
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime        ,
        @iType          Integer
AS
/* 
On est dans le cas d'une modification, on supprime les refus existants.
*/
 IF     @iType = 1
        Begin
                DELETE FROM     sysadm.refus
                WHERE           refus.id_sin = @dcIdSin

                IF      @@Error <> 0 Return -1
        End

 INSERT INTO    sysadm.refus
        (       refus.id_sin,
                refus.id_gti,
                refus.id_detail,
                refus.id_motif,
                refus.alt_mac,
                refus.alt_ope,
                refus.id_i,
                refus.id_para,
                refus.cree_le,
                refus.maj_le,
                refus.maj_par,
                refus.valide_le,
                refus.valide_par        )
 SELECT         w_refus.id_sin,
                w_refus.id_gti,
                w_refus.id_detail,
                w_refus.id_motif,
                w_refus.alt_mac,
                w_refus.alt_ope,
                w_refus.id_i,
                w_refus.id_para,
                w_refus.cree_le,
                w_refus.maj_le,
                w_refus.maj_par,
                @dtValideLe,
                @sCodOper
 FROM           sysadm.w_refus
 WHERE          w_refus.id_sin = @dcIdSin

 Return @@Error

GO
