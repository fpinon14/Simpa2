-------------------------------------------------------------------
--
-- Fichier              :       GAR_SIN.CP
-- Auteur               :       PLJ
-- Date                 :       16/07/1998
--
-- Commentaires         :       Gestion des garanties dans SIMPA2
--
-- Proc‚dures           :       DW_S01_GAR_SIN
--                              PS_I01_GAR_SIN_VAL
--                              PS_I02_GAR_SIN_VAL
--                              PS_U01_GAR_SIN_VAL
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_GAR_SIN
-- Auteur               :       PLJ
-- Date                 :       16/07/1998
-- Libell‚              :        
-- Commentaires         :       Select sur la table GAR_SIN
-- R‚f‚rences           :       Utilis‚ dans W_CM_SP_SINISTRE 
--
-- Arguments            :       @dcIdSin        decimal ( 7, 0 )                 (Val)
--
-- Retourne             :       La s‚lection
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_GAR_SIN' AND type = 'P' )
        DROP procedure sysadm.DW_S01_GAR_SIN
GO

CREATE procedure sysadm.DW_S01_GAR_SIN
        @dcIdSin        decimal ( 10, 0 )     -- [PI062]   
AS
 SELECT gar_sin.id_sin,
        gar_sin.id_gti,
        gar_sin.dte_oppo,
        gar_sin.heu_oppo,
        gar_sin.dte_1er_uf,
        gar_sin.mt_tot_prej,
        gar_sin.mt_prej_reg,
        gar_sin.mt_dedu_reg,
        gar_sin.mt_fran_reg,
        gar_sin.mt_nplaf_reg,
        gar_sin.mt_plaf_reg,
        gar_sin.mt_prov,
        gar_sin.cod_dec_mac,
        gar_sin.cod_dec_ope,
        gar_sin.cod_etat,
	gar_sin.txt_mess,
        gar_sin.alt_plaf,
        gar_sin.alt_ssui,
        gar_sin.cod_mot_ssui,
        gar_sin.cree_le,
        gar_sin.maj_le,
        gar_sin.maj_par,
        gar_sin.valide_le,
        gar_sin.valide_par
 FROM   sysadm.gar_sin
 WHERE  gar_sin.id_sin = @dcIdSin
 
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_GAR_SIN_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table GAR_SIN (D‚claration)
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_GAR_SIN_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_GAR_SIN_VAL
GO

CREATE procedure sysadm.PS_I01_GAR_SIN_VAL
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

 INSERT INTO    sysadm.gar_sin
        (       gar_sin.id_sin,
                gar_sin.id_gti,
                gar_sin.dte_oppo,
                gar_sin.heu_oppo,
                gar_sin.dte_1er_uf,
                gar_sin.mt_tot_prej,
                gar_sin.mt_prej_reg,
                gar_sin.mt_fran_reg,
                gar_sin.mt_nplaf_reg,
                gar_sin.mt_plaf_reg,
                gar_sin.mt_dedu_reg,
                gar_sin.mt_prov,
                gar_sin.cod_dec_mac,
                gar_sin.cod_dec_ope,
                gar_sin.cod_etat,
                gar_sin.dte_ouv,
                gar_sin.txt_mess,
                gar_sin.alt_plaf,
                gar_sin.alt_ssui,
                gar_sin.cod_mot_ssui,
                gar_sin.cree_le,
                gar_sin.maj_le,
                gar_sin.maj_par,
                gar_sin.valide_le,
                gar_sin.valide_par         )
 SELECT         w_gar_sin.id_sin,
                w_gar_sin.id_gti,
                w_gar_sin.dte_oppo,
                w_gar_sin.heu_oppo,
                w_gar_sin.dte_1er_uf,
                w_gar_sin.mt_tot_prej,
                w_gar_sin.mt_prej_areg + w_gar_sin.mt_prej_reg,
                w_gar_sin.mt_fran_areg + w_gar_sin.mt_fran_reg,
                w_gar_sin.mt_nplaf_areg + w_gar_sin.mt_nplaf_reg,
                w_gar_sin.mt_plaf_areg + w_gar_sin.mt_plaf_reg,
                w_gar_sin.mt_dedu_areg + w_gar_sin.mt_dedu_reg,
                w_gar_sin.mt_prov,
                w_gar_sin.cod_dec_mac,
                w_gar_sin.cod_dec_ope,
                w_gar_sin.cod_etat,
                Convert ( DateTime, Convert ( Varchar ( 10 ), @dtValideLe, 103 ) ),
                w_gar_sin.txt_mess,
                w_gar_sin.alt_plaf,
                w_gar_sin.alt_ssui,
                w_gar_sin.cod_mot_ssui,
                w_gar_sin.cree_le,
                w_gar_sin.maj_le,
                w_gar_sin.maj_par,
                @dtValideLe,
                @sCodOper
 FROM           sysadm.w_gar_sin
 WHERE          w_gar_sin.id_sin = @dcIdSin

 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I02_GAR_SIN_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table GAR_SIN (Compl‚ment)
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I02_GAR_SIN_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I02_GAR_SIN_VAL
GO


CREATE procedure sysadm.PS_I02_GAR_SIN_VAL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

 INSERT INTO    sysadm.gar_sin
        (       gar_sin.id_sin,
                gar_sin.id_gti,
                gar_sin.dte_oppo,
                gar_sin.heu_oppo,
                gar_sin.dte_1er_uf,
                gar_sin.mt_tot_prej,
                gar_sin.mt_prej_reg,
                gar_sin.mt_fran_reg,
                gar_sin.mt_nplaf_reg,
                gar_sin.mt_plaf_reg,
                gar_sin.mt_dedu_reg,
                gar_sin.mt_prov,
                gar_sin.cod_dec_mac,
                gar_sin.cod_dec_ope,
                gar_sin.cod_etat,
                gar_sin.dte_ouv,
                gar_sin.txt_mess,
                gar_sin.alt_plaf,
                gar_sin.alt_ssui,
                gar_sin.cod_mot_ssui,
                gar_sin.cree_le,
                gar_sin.maj_le,
                gar_sin.maj_par,
                gar_sin.valide_le,
                gar_sin.valide_par         )
 SELECT         w_gar_sin.id_sin,
                w_gar_sin.id_gti,
                w_gar_sin.dte_oppo,
                w_gar_sin.heu_oppo,
                w_gar_sin.dte_1er_uf,
                w_gar_sin.mt_tot_prej,
                w_gar_sin.mt_prej_areg + w_gar_sin.mt_prej_reg,
                w_gar_sin.mt_fran_areg + w_gar_sin.mt_fran_reg,
                w_gar_sin.mt_nplaf_areg + w_gar_sin.mt_nplaf_reg,
                w_gar_sin.mt_plaf_areg + w_gar_sin.mt_plaf_reg,
                w_gar_sin.mt_dedu_areg + w_gar_sin.mt_dedu_reg,
                w_gar_sin.mt_prov,
                w_gar_sin.cod_dec_mac,
                w_gar_sin.cod_dec_ope,
                w_gar_sin.cod_etat,
                Convert ( DateTime, Convert ( Varchar ( 10 ), @dtValideLe, 103 ) ),
                w_gar_sin.txt_mess,
                w_gar_sin.alt_plaf,
                w_gar_sin.alt_ssui,
                w_gar_sin.cod_mot_ssui,
                w_gar_sin.cree_le,
                w_gar_sin.maj_le,
                w_gar_sin.maj_par,
                @dtValideLe,
                @sCodOper
 FROM           sysadm.w_gar_sin
 WHERE          w_gar_sin.id_sin = @dcIdSin             AND
                w_gar_sin.cpt_valide = 0                AND
                w_gar_sin.alt_valide = 'O'

 Return @@Error



GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_U01_GAR_SIN_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Modification dans la table GAR_SIN (Compl‚ment)
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_GAR_SIN_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U01_GAR_SIN_VAL
GO

CREATE procedure sysadm.PS_U01_GAR_SIN_VAL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

 UPDATE sysadm.gar_sin
 SET    sysadm.gar_sin.dte_oppo        = w_gar_sin.dte_oppo            ,
        sysadm.gar_sin.heu_oppo        = w_gar_sin.heu_oppo            ,
        sysadm.gar_sin.dte_1er_uf      = w_gar_sin.dte_1er_uf          ,
        sysadm.gar_sin.mt_tot_prej     = w_gar_sin.mt_tot_prej         ,
        sysadm.gar_sin.mt_prej_reg     = w_gar_sin.mt_prej_areg + w_gar_sin.mt_prej_reg,
        sysadm.gar_sin.mt_fran_reg     = w_gar_sin.mt_fran_areg + w_gar_sin.mt_fran_reg,
        sysadm.gar_sin.mt_nplaf_reg    = w_gar_sin.mt_nplaf_areg + w_gar_sin.mt_nplaf_reg,
        sysadm.gar_sin.mt_plaf_reg     = w_gar_sin.mt_plaf_areg + w_gar_sin.mt_plaf_reg,
        sysadm.gar_sin.mt_dedu_reg     = w_gar_sin.mt_dedu_areg + w_gar_sin.mt_dedu_reg,
        sysadm.gar_sin.mt_prov         = w_gar_sin.mt_prov             ,
        sysadm.gar_sin.cod_dec_mac     = w_gar_sin.cod_dec_mac         ,
        sysadm.gar_sin.cod_dec_ope     = w_gar_sin.cod_dec_ope         ,
        sysadm.gar_sin.cod_etat        = w_gar_sin.cod_etat            ,
        sysadm.gar_sin.txt_mess        = w_gar_sin.txt_mess            ,
        sysadm.gar_sin.alt_plaf        = w_gar_sin.alt_plaf            ,
        sysadm.gar_sin.alt_ssui        = w_gar_sin.alt_ssui            ,
        sysadm.gar_sin.cod_mot_ssui    = w_gar_sin.cod_mot_ssui        ,
        sysadm.gar_sin.maj_le          = w_gar_sin.maj_le              ,
        sysadm.gar_sin.maj_par         = w_gar_sin.maj_par             ,
        sysadm.gar_sin.valide_le       = @dtValideLe                   ,
        sysadm.gar_sin.valide_par      = @sCodOper
 FROM   sysadm.gar_sin,
        sysadm.w_gar_sin
 WHERE  w_gar_sin.id_sin        = @dcIdSin                      AND
        gar_sin.id_sin          = w_gar_sin.id_sin              AND
        gar_sin.id_gti          = w_gar_sin.id_gti              AND
        w_gar_sin.cpt_valide    > 0                             AND
        w_gar_sin.alt_valide    = 'O'

 Return @@Error

GO
