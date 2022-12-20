-------------------------------------------------------------------
--
-- Fichier              :       W_GTI.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion des garanties dans SIMPA2
--
-- Procédures           :       DW_S01_W_GTI_LSTDET
--                              DW_I01_W_GTI
--                              DW_D01_W_GTI
--                              PS_S01_W_GTI_A_REGLER
--                              PS_S01_W_GTI_MT_PLAF
--                              PS_S02_W_GTI_MT_PLAF
--                              PS_S03_W_GTI_MT_PLAF
--                              PS_S04_W_GTI_MT_PLAF
--                              PS_S05_W_GTI_MT_PLAF
--                              PS_S06_W_GTI_MT_PLAF
--                              PS_I01_W_GTI_WKF
-- 				PS_S01_W_GTI_NBSIN	Fabry JF, 22/12/2003, Calcul du nombre de sinistre par adhesion (Survenance)
-- 				PS_S02_W_GTI_NBSIN	Fabry JF, 22/12/2003, Calcul du nombre de sinistre par adherent (Survenance)
--				PS_S03_W_GTI_NBSIN	Fabry JF, 22/12/2003, Calcul du nombre de sinistre par adhesion (Renouvellement)
--				PS_S04_W_GTI_NBSIN      Fabry JF, 22/12/2003, Calcul du nombre de sinistre par adherent (Renouvellement)
--				PS_S05_W_GTI_NBSIN      Fabry JF, 22/12/2003, Calcul du nombre de sinistre par adhesion (Civile) [DCMP080377]
--				PS_S06_W_GTI_NBSIN      Fabry JF, 22/12/2003, Calcul du nombre de sinistre par adherent (Civile) [DCMP080377]
-- 				PS_S07_W_GTI_NBSIN	Fabry JF, 07/04/2010, [DCMP100220]
--				PS_S08_W_GTI_NBSIN	Fabry JF, 07/04/2010, [DCMP100220]	
--				PS_S09_W_GTI_NBGTI_ADHERENT	F. PINON, 17/06/2010, [DCMP100410]	
--				PS_S10_W_GTI_NBGTI_ADHESION	F. PINON, 17/06/2010, [DCMP100410]	
--				PS_S11_W_GTI_NBGTI_PEC_ADHESION	JFF, 07/12/2010, [PC397][PC441][PC443]	
--				PS_S12_W_GTI_NBGTI_PEC_ADHERENT	JFF, 07/12/2010, [PC397][PC441][PC443]
--				PS_S01_RECH_PGC_PANNE [PC363].[PANNE_PGC]
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_GTI_LSTDET
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :
-- Commentaires         :       S‚lect sur la table W_GAR_SIN
-- Références           :       Utilis‚ dans W_TM_SP_SINISTRE (Liste d‚tail)
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_GTI_LSTDET' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_GTI_LSTDET
GO

CREATE procedure sysadm.DW_S01_W_GTI_LSTDET
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS
 SELECT w_gar_sin.id_sin,
        w_gar_sin.id_gti,
        w_gar_sin.dte_oppo,
        w_gar_sin.heu_oppo,
        w_gar_sin.dte_1er_uf,
        w_gar_sin.mt_tot_prej,
        w_gar_sin.mt_prej_areg,
        w_gar_sin.mt_fran_areg,
        w_gar_sin.mt_nplaf_areg,
        w_gar_sin.mt_plaf_areg,
        w_gar_sin.mt_dedu_areg,
        w_gar_sin.mt_prej_reg,
        w_gar_sin.mt_dedu_reg,
        w_gar_sin.mt_fran_reg,
        w_gar_sin.mt_nplaf_reg,
        w_gar_sin.mt_plaf_reg,
        w_gar_sin.mt_prov,
        w_gar_sin.cod_dec_mac,
        w_gar_sin.cod_dec_ope,
        w_gar_sin.cod_etat,
        w_gar_sin.txt_mess,
        w_gar_sin.alt_bloc,
        w_gar_sin.alt_att,
        w_gar_sin.alt_plaf,
        w_gar_sin.alt_ssui,
        w_gar_sin.cod_mot_ssui,
        w_gar_sin.alt_valide,
        w_gar_sin.cpt_valide,
        w_gar_sin.cpt_i_areg,
        w_gar_sin.cree_le,
        w_gar_sin.maj_le,
        w_gar_sin.maj_par,
--Migration PB4 PB8 WYNIWYG 03/2006  ajout 1 ligne
	cast(null as datetime) as 'dte_oppo_date'
 FROM   sysadm.w_gar_sin
 WHERE  w_gar_sin.id_sin = @dcIdSin


GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_W_GTI
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion sur table W_GAR_SIN
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdsin        Decimal (  7,0 )        (Val)
--                      :       @dcIdGti        Decimal (  7,0 )        (Val)
--                      :       @dDteOppo       DateTime                (Val)
--                      :       @sHeuOppo       Varchar (  4 )          (Val)
--                      :       @dDte1erUf      DateTime                (Val)
--                      :       @dcMtTotPrej    Decimal ( 11,2 )        (Val)
--                      :       @dcMtPrejAreg   Decimal ( 11,2 )        (Val)
--                      :       @dcMtFranaReg   Decimal ( 11,2 )        (Val)
--                      :       @dcMtNPlafAreg  Decimal ( 11,2 )        (Val)
--                      :       @dcMtPlafAreg   Decimal ( 11,2 )        (Val)
--                      :       @dcMtDeduAreg   Decimal ( 11,2 )        (Val)
--                      :       @dcMtPrejReg    Decimal ( 11,2 )        (Val)
--                      :       @dcMtDeduReg    Decimal ( 11,2 )        (Val)
--                      :       @dcMtFranReg    Decimal ( 11,2 )        (Val)
--                      :       @dcMtNplafReg   Decimal ( 11,2 )        (Val)
--                      :       @dcMtPlafReg    Decimal ( 11,2 )        (Val)
--                      :       @dcMtProv       Decimal ( 11,2 )        (Val)
--                      :       @dcCodDecMac    Decimal (  7,0 )        (Val)
--                      :       @dcCodDecOpe    Decimal (  7,0 )        (Val)
--                      :       @dcCodEtat      Decimal (  7,0 )        (Val)
--                      :       @sTxtMess       Varchar (254)           (Val)
--                      :       @sAltBloc       Varchar (  1 )          (Val)
--                      :       @sAltAtt        Varchar (  1 )          (Val)
--                      :       @sAltPlaf       Varchar (  1 )          (Val)
--                      :       @sAltSsui       Varchar (  1 )          (Val)
--                      :       @dcCodMotSsui   Decimal (  2,0 )        (Val)
--                      :       @sAltValide     Varchar (  1 )          (Val)
--                      :       @dcCptValide    Decimal (  2,0 )        (Val)
--                      :       @dcCptIAreg     Decimal (  2,0 )        (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @dtMajLe        DateTime                (Val)
--                      :       @sMajPar        Varchar (  4 )          (Val)
--
-- Retourne             :       Rien
---------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_W_GTI' AND type = 'P' )
        DROP procedure sysadm.DW_I01_W_GTI
GO


CREATE procedure sysadm.DW_I01_W_GTI
        @dcIdsin        Decimal (  10,0 ), -- [PI062]
        @dcIdGti        Decimal (  7,0 ),
        @dDteOppo       DateTime        ,
        @sHeuOppo       Varchar (  4 )  ,
        @dDte1erUf      DateTime        ,
        @dcMtTotPrej    Decimal ( 11, 2),
        @dcMtPrejAreg   Decimal ( 11, 2),
        @dcMtFranaReg   Decimal ( 11, 2),
        @dcMtNPlafAreg  Decimal ( 11, 2),
        @dcMtPlafAreg   Decimal ( 11, 2),
        @dcMtDeduAreg   Decimal ( 11, 2),
        @dcMtPrejReg    Decimal ( 11, 2),
        @dcMtDeduReg    Decimal ( 11, 2),
        @dcMtFranReg    Decimal ( 11, 2),
        @dcMtNplafReg   Decimal ( 11, 2),
        @dcMtPlafReg    Decimal ( 11, 2),
        @dcMtProv       Decimal ( 11, 2),
        @dcCodDecMac    Decimal (  7,0 ),
        @dcCodDecOpe    Decimal (  7,0 ),
        @dcCodEtat      Decimal (  7,0 ),
        @sTxtMess       Varchar (254)   ,
        @sAltBloc       Varchar (  1 )  ,
        @sAltAtt        Varchar (  1 )  ,
        @sAltPlaf       Varchar (  1 )  ,
        @sAltSsui       Varchar (  1 )  ,
        @dcCodMotSsui   Decimal (  2,0 ),
        @sAltValide     Varchar (  1 )  ,
        @dcCptValide    Decimal (  2,0 ),
        @dcCptIAreg     Decimal (  2,0 ),
        @dtCreeLe       DateTime        ,
        @dtMajLe        DateTime        ,
        @sMajPar        Varchar (  4 )
AS
 INSERT INTO    sysadm.w_gar_sin
        (       w_gar_sin.id_sin,
                w_gar_sin.id_gti,
                w_gar_sin.dte_oppo,
                w_gar_sin.heu_oppo,
                w_gar_sin.dte_1er_uf,
                w_gar_sin.mt_tot_prej,
                w_gar_sin.mt_prej_areg,
                w_gar_sin.mt_fran_areg,
                w_gar_sin.mt_nplaf_areg,
                w_gar_sin.mt_plaf_areg,
                w_gar_sin.mt_dedu_areg,
                w_gar_sin.mt_prej_reg,
                w_gar_sin.mt_dedu_reg,
                w_gar_sin.mt_fran_reg,
                w_gar_sin.mt_nplaf_reg,
                w_gar_sin.mt_plaf_reg,
                w_gar_sin.mt_prov,
                w_gar_sin.cod_dec_mac,
                w_gar_sin.cod_dec_ope,
                w_gar_sin.cod_etat,
                w_gar_sin.txt_mess,
                w_gar_sin.alt_bloc,
                w_gar_sin.alt_att,
                w_gar_sin.alt_plaf,
                w_gar_sin.alt_ssui,
                w_gar_sin.cod_mot_ssui,
                w_gar_sin.alt_valide,
                w_gar_sin.cpt_valide,
                w_gar_sin.cpt_i_areg,
                w_gar_sin.cree_le,
                w_gar_sin.maj_le,
                w_gar_sin.maj_par               )
 VALUES (       @dcIdsin,
                @dcIdGti,
                @dDteOppo,
                @sHeuOppo,
                @dDte1erUf,
                @dcMtTotPrej,
                @dcMtPrejAreg,
                @dcMtFranaReg,
                @dcMtNPlafAreg,
                @dcMtPlafAreg,
                @dcMtDeduAreg,
                @dcMtPrejReg,
                @dcMtDeduReg,
                @dcMtFranReg,
                @dcMtNplafReg,
                @dcMtPlafReg,
                @dcMtProv,
                @dcCodDecMac,
                @dcCodDecOpe,
                @dcCodEtat,
                @sTxtMess,
                @sAltBloc,
                @sAltAtt,
                @sAltPlaf,
                @sAltSsui,
                @dcCodMotSsui,
                @sAltValide,
                @dcCptValide,
                @dcCptIAreg,
                @dtCreeLe,
                @dtMajLe,
                @sMajPar                )

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_W_GTI
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Suppression d'une garantie
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-- #1	14/09/2007	JFF	ajout du delete de w_div_det
--      12/02/2016  JFF [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_W_GTI' AND type = 'P' )
        DROP procedure sysadm.DW_D01_W_GTI
GO

CREATE procedure sysadm.DW_D01_W_GTI
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdGti        Decimal (  7,0 )
AS

 DELETE FROM    sysadm.w_refus
 WHERE          w_refus.id_sin          = @dcIdSin      AND
                w_refus.id_gti          = @dcIdGti
 
 DELETE FROM    sysadm.w_piece
 WHERE          w_piece.id_sin          = @dcIdSin      AND
                w_piece.id_gti          = @dcIdGti

 DELETE FROM    sysadm.w_para_plafond
 WHERE          w_para_plafond.id_sin   = @dcIdSin      AND
                w_para_plafond.id_gti   = @dcIdGti

 DELETE FROM    sysadm.w_commande
 WHERE          w_commande.id_sin               = @dcIdSin      AND
                w_commande.id_gti               = @dcIdGti   AND   
                w_commande.cpt_valide		= 0                

 DELETE FROM    sysadm.w_div_det
 WHERE          w_div_det.id_sin               = @dcIdSin      AND
                w_div_det.id_gti               = @dcIdGti  AND    
                w_div_det.cpt_valide		= 0      
                
 DELETE FROM    sysadm.w_detail
 WHERE          w_detail.id_sin         = @dcIdSin      AND
                w_detail.id_gti         = @dcIdGti

 DELETE FROM    sysadm.w_gar_sin
 WHERE          w_gar_sin.id_sin        = @dcIdSin      AND
                w_gar_sin.id_gti        = @dcIdGti

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_W_GTI_A_REGLER
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Existe t il des garanties … r‚gler pour la mˆme adh‚sion ?
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @iNbDetail      Integer         OUTPUT  (R‚f)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_W_GTI_A_REGLER' AND type = 'P' )
        DROP procedure sysadm.PS_S01_W_GTI_A_REGLER
GO


CREATE procedure sysadm.PS_S01_W_GTI_A_REGLER
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @iNbDetail      Integer OUTPUT
AS
 SELECT @iNbDetail = Count ( w_detail.id_sin )
 FROM   sysadm.w_sin,
        sysadm.w_gar_sin,
        sysadm.w_detail
 WHERE  w_sin.id_sin            = w_gar_sin.id_sin                      AND
        w_gar_sin.id_sin        = w_detail.id_sin                       AND
        w_sin.id_sin           <> @dcIdSin                              AND
        w_sin.id_prod           = @dcIdProd                             AND
        w_sin.id_ets            = @dcIdEts                              AND
        w_sin.id_adh            = @sIdAdh                               AND
        w_gar_sin.id_gti        = @dcIdGti                              AND
        w_sin.dte_surv         <= @dtSurv                               AND
        w_sin.dte_surv         >= DateAdd ( day, -365, @dtSurv )        AND
        w_detail.cod_etat       = 500

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_W_GTI_MT_PLAF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Calcul des plafonds par adh‚sion (Survenance)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
--
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S01_W_GTI_MT_PLAF
GO


CREATE procedure sysadm.PS_S01_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS
-- 691
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			gar_sin.id_gti          = @dcIdGti                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			gar_sin.id_gti          = @dcIdGti                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]		

	        
  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S02_W_GTI_MT_PLAF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Calcul des plafonds par adh‚rent (Survenance)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdsDos       Decimal (  2,0 )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S02_W_GTI_MT_PLAF
GO


CREATE procedure sysadm.PS_S02_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdsDos       Decimal (  2,0 ),
        @dcIdGti        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS
-- 692
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			gar_sin.id_gti          = @dcIdGti                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)
  End        	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p		
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			gar_sin.id_gti          = @dcIdGti                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom								AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]		

  End        	        
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S03_W_GTI_MT_PLAF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Calcul des plafonds par adh‚sion (Renouvellement)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S03_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S03_W_GTI_MT_PLAF
GO

CREATE procedure sysadm.PS_S03_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS
-- 693
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			gar_sin.id_gti          = @dcIdGti                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)
  End
  
 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			gar_sin.id_gti          = @dcIdGti                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]		

  End
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S031_W_GTI_MT_PLAF
-- Auteur               :       Fabry JF
-- Date                 :       12/12/14 
-- Libellé              :       -- [PC13321]
-- Commentaires         :       Calcul des plafonds par adh‚sion (Renouvellement) mais sur le prod adhésion, c'est la variante
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S031_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S031_W_GTI_MT_PLAF
GO


CREATE procedure sysadm.PS_S031_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS
-- 749

 Declare @sCodAdh   VarChar ( 1 )
 Declare @dcIdProdDms Decimal ( 7 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom,   -- [ITSM361927]
		@dcIdProdDms = p.cod_prod_dms
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod

 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.produit -- [PC13321]
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			produit.cod_prod_dms	= @dcIdProdDms							AND -- [PC13321]
			sinistre.id_prod        = produit.id_prod						AND -- [PC13321]
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			gar_sin.id_gti          = @dcIdGti                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)
  End
  
 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p,
			sysadm.produit
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			produit.cod_prod_dms	= @dcIdProdDms							AND -- [PC13321]
			sinistre.id_prod        = produit.id_prod						AND -- [PC13321]
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			gar_sin.id_gti          = @dcIdGti                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				

  End

GO



--------------------------------------------------------------------
--
-- Procédure            :       PS_S04_W_GTI_MT_PLAF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Calcul des plafonds par adh‚rent (Renouvellement)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdsDos       Decimal (  2,0 )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
--
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S04_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S04_W_GTI_MT_PLAF
GO


CREATE procedure sysadm.PS_S04_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdsDos       Decimal (  2,0 ),
        @dcIdGti        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS
-- 694
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
 
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			gar_sin.id_gti          = @dcIdGti                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
  
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p			
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			gar_sin.id_gti          = @dcIdGti                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				

	        
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S05_W_GTI_MT_PLAF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Calcul des plafonds par adh‚sion (Survenance)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
--
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S05_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S05_W_GTI_MT_PLAF
GO

CREATE procedure sysadm.PS_S05_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS

-- 673

 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin        			= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			gar_sin.id_gti          		= @dcIdGti                              AND
			DatePart (year, sinistre.dte_surv )	=	DatePart ( year, @dtSurv )	AND
			(
			gar_sin.cod_etat        		= 550                                   OR
			gar_sin.cod_etat        		= 600
			)	  
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p
				
	 WHERE  sinistre.id_sin        			= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			gar_sin.id_gti          		= @dcIdGti                              AND
			DatePart (year, sinistre.dte_surv )	=	DatePart ( year, @dtSurv )	AND
			(
			gar_sin.cod_etat        		= 550                                   OR
			gar_sin.cod_etat        		= 600
			)	  																	AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S06_W_GTI_MT_PLAF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Calcul des plafonds par adh‚rent (Survenance)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdsDos       Decimal (  2,0 )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
--
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S06_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S06_W_GTI_MT_PLAF
GO


CREATE procedure sysadm.PS_S06_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdsDos       Decimal (  2,0 ),
        @dcIdGti        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS

 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin         		= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        		= @dcIdsDos                             AND
			gar_sin.id_gti          		= @dcIdGti                              AND
			DatePart ( year, sinistre.dte_surv )	=	DatePart ( year, @dtSurv )	AND
			(
			gar_sin.cod_etat        		= 550                                   OR
			gar_sin.cod_etat        		= 600
			)
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p
	 WHERE  sinistre.id_sin         		= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        		= @dcIdsDos                             AND
			gar_sin.id_gti          		= @dcIdGti                              AND
			DatePart ( year, sinistre.dte_surv )	=	DatePart ( year, @dtSurv )	AND
			(
			gar_sin.cod_etat        		= 550                                   OR
			gar_sin.cod_etat        		= 600
			)																		AND
			p.id_ordre						= sinistre.id_ordre						AND
			p.nom							= @sNom								AND
			p.prenom						= @sPrenom
	        
  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_W_GTI_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans W_GAR_SIN   
-- Références           :       Utilisé dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_GTI_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_GTI_WKF
GO

CREATE procedure sysadm.PS_I01_W_GTI_WKF
        @dcIdSin        Decimal (  10,0 )
AS
 INSERT INTO    sysadm.w_gar_sin
        (       w_gar_sin.id_sin,
                w_gar_sin.id_gti,
                w_gar_sin.dte_oppo,
                w_gar_sin.heu_oppo,
                w_gar_sin.dte_1er_uf,
                w_gar_sin.mt_tot_prej,
                w_gar_sin.mt_prej_areg,
                w_gar_sin.mt_fran_areg,
                w_gar_sin.mt_nplaf_areg,
                w_gar_sin.mt_plaf_areg,
                w_gar_sin.mt_dedu_areg,
                w_gar_sin.mt_prej_reg,
                w_gar_sin.mt_dedu_reg,
                w_gar_sin.mt_fran_reg,
                w_gar_sin.mt_nplaf_reg,
                w_gar_sin.mt_plaf_reg,
                w_gar_sin.mt_prov,
                w_gar_sin.cod_dec_mac,
                w_gar_sin.cod_dec_ope,
                w_gar_sin.cod_etat,
                w_gar_sin.txt_mess,
                w_gar_sin.alt_bloc,
                w_gar_sin.alt_att,
                w_gar_sin.alt_plaf,
                w_gar_sin.alt_ssui,
                w_gar_sin.cod_mot_ssui,
                w_gar_sin.alt_valide,
                w_gar_sin.cpt_valide,
                w_gar_sin.cpt_i_areg,
                w_gar_sin.cree_le,
                w_gar_sin.maj_le,
                w_gar_sin.maj_par )
 SELECT         gar_sin.id_sin,
                gar_sin.id_gti,
                gar_sin.dte_oppo,
                gar_sin.heu_oppo,
                gar_sin.dte_1er_uf,
                gar_sin.mt_tot_prej,
                0.00,
                0.00,
                0.00,
                0.00,
                0.00,
                gar_sin.mt_prej_reg,
                gar_sin.mt_dedu_reg,
                gar_sin.mt_fran_reg,
                gar_sin.mt_nplaf_reg,
                gar_sin.mt_plaf_reg,
                0.00,
                gar_sin.cod_dec_mac,
                gar_sin.cod_dec_ope,
                gar_sin.cod_etat,
                gar_sin.txt_mess,
                'N',
                'N',
                gar_sin.alt_plaf,
                gar_sin.alt_ssui,
                gar_sin.cod_mot_ssui,
                'N',
                1,
                0,
                gar_sin.cree_le,
                gar_sin.maj_le,
                gar_sin.maj_par
 FROM           sysadm.gar_sin
 WHERE          gar_sin.id_sin  = @dcIdSin

 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_W_GTI_NBSIN
-- Auteur               :       Fabry JF
-- Date                 :       22/12/2003
-- Libellé              :       
-- Commentaires         :       Calcul du nombre de sinistre par adhesion (Survenance)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- JFF  25/07/2011 [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_W_GTI_NBSIN' AND type = 'P' )
        DROP procedure sysadm.PS_S01_W_GTI_NBSIN
GO

CREATE procedure sysadm.PS_S01_W_GTI_NBSIN
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @iNbSin		Integer	 OUTPUT
AS

-- Plafond 695
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
  
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s
	 WHERE  s.id_sin        <> @dcIdSin                              AND
			s.id_prod        = @dcIdProd                             AND
			s.id_ets         = @dcIdEts                              AND
			s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			s.dte_surv      <= @dtSurv                               AND
			s.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			( s.cod_etat      in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '695'
				  And    s.cod_etat = 100 )
			)        
  End

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.personne p
	 WHERE  s.id_sin        <> @dcIdSin                              AND
			s.id_prod        = @dcIdProd                             AND
			s.id_ets         = @dcIdEts                              AND
			s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			s.dte_surv      <= @dtSurv                               AND
			s.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			( s.cod_etat      in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '695'
				  And    s.cod_etat = 100 )
			)														AND
			p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S02_W_GTI_NBSIN
-- Auteur               :       Fabry JF
-- Date                 :       22/12/2003
-- Libellé              :       
-- Commentaires         :       Calcul du nombre de sinistre par adherent (Survenance)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdsDos       Decimal (  2,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- JFF  25/07/2011 [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_W_GTI_NBSIN' AND type = 'P' )
        DROP procedure sysadm.PS_S02_W_GTI_NBSIN
GO


CREATE procedure sysadm.PS_S02_W_GTI_NBSIN
        @dcIdSin        Decimal (  10,0 ),
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
	@dcIdsDos       Decimal (  2,0 ),
        @dtSurv         DateTime        ,
        @iNbSin		Integer	 OUTPUT
AS
 -- Plafond 696
 
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s
	 WHERE  s.id_sin        <> @dcIdSin                              AND
			s.id_prod        = @dcIdProd                             AND
			s.id_ets         = @dcIdEts                              AND
			s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			s.id_sdos        = @dcIdsDos                             AND
			s.dte_surv      <= @dtSurv                               AND
			s.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			( s.cod_etat      in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '696'
				  And    s.cod_etat = 100 
				  )
			)   	  
  End
  
 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.personne p
	 WHERE  s.id_sin        <> @dcIdSin                              AND
			s.id_prod        = @dcIdProd                             AND
			s.id_ets         = @dcIdEts                              AND
			s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			s.id_sdos        = @dcIdsDos                             AND
			s.dte_surv      <= @dtSurv                               AND
			s.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			( s.cod_etat      in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '696'
				  And    s.cod_etat = 100 
				  )
			)   													 AND
			p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
			  
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S03_W_GTI_NBSIN
-- Auteur               :       Fabry JF
-- Date                 :       22/12/2003
-- Libellé              :       
-- Commentaires         :       Calcul du nombre de sinistre par adhesion (Renouvellement)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- JFF  25/07/2011 [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S03_W_GTI_NBSIN' AND type = 'P' )
        DROP procedure sysadm.PS_S03_W_GTI_NBSIN
GO


CREATE procedure sysadm.PS_S03_W_GTI_NBSIN
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
	@iNbSin		Integer	 OUTPUT
	
AS
 -- Plafond 697
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin 
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s
	 WHERE  s.id_sin        <> @dcIdSin                              AND
			s.id_prod        = @dcIdProd                             AND
			s.id_ets         = @dcIdEts                              AND
			s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			s.dte_surv      <= @dtSurv                               AND
			s.dte_surv      >= @dtAdhRenouv                          AND
			( s.cod_etat      in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '697'
				  And    s.cod_etat = 100 
				  )
			)    
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.personne p
	 WHERE  s.id_sin        <> @dcIdSin                              AND
			s.id_prod        = @dcIdProd                             AND
			s.id_ets         = @dcIdEts                              AND
			s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			s.dte_surv      <= @dtSurv                               AND
			s.dte_surv      >= @dtAdhRenouv                          AND
			( s.cod_etat      in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '697'
				  And    s.cod_etat = 100 
				  )
			)   													 AND
			p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S04_W_GTI_NBSIN
-- Auteur               :       Fabry JF
-- Date                 :       22/12/2003
-- Libellé              :       
-- Commentaires         :       Calcul du nombre de sinistre par adherent (Renouvellement)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdsDos       Decimal (  2,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S04_W_GTI_NBSIN' AND type = 'P' )
        DROP procedure sysadm.PS_S04_W_GTI_NBSIN
GO


CREATE procedure sysadm.PS_S04_W_GTI_NBSIN
        @dcIdSin        Decimal (  10,0 ),-- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
	@dcIdsDos       Decimal (  2,0 ),
	@dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
	@iNbSin		Integer	 OUTPUT
	
AS
 -- Plafond 698
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
  
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	SELECT @iNbSin  = count ( * )
	FROM   sysadm.sinistre s
	WHERE  s.id_sin        <> @dcIdSin                              AND
		s.id_prod        = @dcIdProd                             AND
		s.id_ets         = @dcIdEts                              AND
		s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
		s.id_sdos        = @dcIdsDos                             AND
		s.dte_surv      <= @dtSurv                               AND
		s.dte_surv      >= @dtAdhRenouv                          AND
		( s.cod_etat    in ( 550, 600 )
		Or  Exists (  Select *
				  From   sysadm.det_pro
				  Where  det_pro.id_prod = s.id_prod 
			  And    det_pro.id_code_dp = 182
			  And    det_pro.id_code_car = '698'
			  And    s.cod_etat = 100 
			)
		)
  
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	SELECT @iNbSin  = count ( * )
	FROM    sysadm.sinistre s,
			sysadm.personne p
	WHERE  s.id_sin        <> @dcIdSin                              AND
		s.id_prod        = @dcIdProd                             AND
		s.id_ets         = @dcIdEts                              AND
		s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
		s.id_sdos        = @dcIdsDos                             AND
		s.dte_surv      <= @dtSurv                               AND
		s.dte_surv      >= @dtAdhRenouv                          AND
		( s.cod_etat    in ( 550, 600 )
		Or  Exists (  Select *
				  From   sysadm.det_pro
				  Where  det_pro.id_prod = s.id_prod 
			  And    det_pro.id_code_dp = 182
			  And    det_pro.id_code_car = '698'
			  And    s.cod_etat = 100 
			)
		)	 													 AND
		p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
		p.nom					= @sNom									AND -- [ITSM361927]
		p.prenom				= @sPrenom -- [ITSM361927]				
  End
 
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_W_GTI_CLIENT
-- Auteur               :       Fabry JF
-- Date                 :       03/12/2004
-- Libellé              :       
-- Commentaires         :       Plafond par Client (DCMP 040407)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_W_GTI_CLIENT' AND type = 'P' )
        DROP procedure sysadm.PS_S01_W_GTI_CLIENT
GO


CREATE procedure sysadm.PS_S01_W_GTI_CLIENT
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS

 Declare @dtDteDeb  VarChar ( 10 )
 Declare @dtDteFin  VarChar ( 10 )
 Declare @dcMtPlafRegLoc  VarChar ( 12 ) 
 
 Set @dtDteDeb = '01/01/' + SubString ( Convert ( Varchar ( 10 ), GetDate (), 103 ), 7, 4   ) 
 Set @dtDteFin = '31/12/' + SubString ( Convert ( Varchar ( 10 ), GetDate (), 103 ), 7, 4   ) 

 IF @@SERVERNAME = master.dbo.SPB_FN_ServerName ('SIM')
 SELECT @dcMtPlafRegLoc  = Convert ( VarChar ( 12 ), isNull ( 
        (
        Select  Sum ( s.mt_reg )
        From    sysadm.sinistre s,
                SHERPA_SIM.sysadm.sinistre s3
        Where   s3.id_cli = s2.id_cli
        And     s3.id_appli = 2
        And     s3.id_prod_sin = @dcIdProd
        And     s.id_sin  = s3.id_sin
        And     s.dte_surv between @dtDteDeb And @dtDteFin 
        And     s.id_sin <> @dcIdSin        
        )
        ,'0' ) 
        )
 FROM   SHERPA_SIM.sysadm.sinistre s2
 WHERE  s2.id_sin        = @dcIdSin
 And    s2.id_appli      = 2
 And    s2.id_prod_sin   = @dcIdProd


 IF @@SERVERNAME = master.dbo.SPB_FN_ServerName ('PRO')
 SELECT @dcMtPlafRegLoc  = Convert ( VarChar ( 12 ), isNull ( 
        (
        Select  Sum ( s.mt_reg )
        From    sysadm.sinistre s,
                SHERPA_PRO.sysadm.sinistre s3
        Where   s3.id_cli = s2.id_cli
        And     s3.id_appli = 2
        And     s3.id_prod_sin = @dcIdProd
        And     s.id_sin  = s3.id_sin
        And     s.dte_surv between @dtDteDeb And @dtDteFin 
        And     s.id_sin <> @dcIdSin
        )
        ,'0' ) 
        )
 FROM   SHERPA_PRO.sysadm.sinistre s2
 WHERE  s2.id_sin        = @dcIdSin
 And    s2.id_appli      = 2
 And    s2.id_prod_sin   = @dcIdProd


 Set @dcMtPlafReg = @dcMtPlafRegLoc     
 Select IsNull ( @dcMtPlafReg, '0' )

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_W_GTI_PRODUIT
-- Auteur               :       Fabry JF
-- Date                 :       03/12/2004
-- Libellé              :       
-- Commentaires         :       Plafond par produit (DCMP 040407)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_W_GTI_PRODUIT' AND type = 'P' )
        DROP procedure sysadm.PS_S01_W_GTI_PRODUIT
GO

CREATE procedure sysadm.PS_S01_W_GTI_PRODUIT
        @dcIdSin        Decimal (  10,0 ),
        @dcIdProd       Decimal (  7,0 ),
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS

 Declare @dtDteDeb  VarChar ( 10 )
 Declare @dtDteFin  VarChar ( 10 )
 Declare @dcMtPlafRegLoc  VarChar ( 12 ) 
 
 Set @dtDteDeb = '01/01/' + SubString ( Convert ( Varchar ( 10 ), GetDate (), 103 ), 7, 4   ) 
 Set @dtDteFin = '31/12/' + SubString ( Convert ( Varchar ( 10 ), GetDate (), 103 ), 7, 4   ) 

 Select  @dcMtPlafRegLoc  = Convert ( VarChar ( 12 ), isNull (  Sum ( s.mt_reg ), 0 ) )
 From    sysadm.sinistre s
 Where   s.id_prod = @dcIdProd
 And     s.dte_surv between @dtDteDeb And @dtDteFin 
 And     s.id_sin <> @dcIdSin

 Set @dcMtPlafReg = @dcMtPlafRegLoc     
 Select IsNull ( @dcMtPlafReg, '0' )

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S05_W_GTI_NBSIN
-- Auteur               :       Fabry JF
-- Date                 :       12/06/2008
-- Libellé              :       [DCMP080377]
-- Commentaires         :       Plafond nb sinistre par année civile par adhérent
-- Références           :       W_TM_SP_W_GTI
--
--
-- Retourne             :       Rien
--
-- JFF  25/07/2011 [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S05_W_GTI_NBSIN' AND type = 'P' )
        DROP procedure sysadm.PS_S05_W_GTI_NBSIN
GO


CREATE procedure sysadm.PS_S05_W_GTI_NBSIN
        @dcIdSin        Decimal ( 10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdsDos       Decimal (  2,0 ),
        @dtSurv         DateTime        ,
		@iNbSin			Integer	 OUTPUT
AS
 
 -- plafond 712
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre
	 WHERE  sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        		= @dcIdsDos                             AND
			DatePart ( year, sinistre.dte_surv )	=	DatePart ( year, @dtSurv )	AND
			( sinistre.cod_etat        		in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '712'
				  And    sinistre.cod_etat = 100
				  )
			)
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.personne p
	 WHERE  sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        		= @dcIdsDos                             AND
			DatePart ( year, sinistre.dte_surv )	=	DatePart ( year, @dtSurv )	AND
			( sinistre.cod_etat        		in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '712'
				  And    sinistre.cod_etat = 100
				  )
			)																		AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				

  End
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S06_W_GTI_NBSIN
-- Auteur               :       Fabry JF
-- Date                 :       03/12/2004
-- Libellé              :       [DCMP080377]
-- Commentaires         :       Plafond nb sinistre par année civile par adhérent
-- Références           :       W_TM_SP_W_GTI
--
--
-- Retourne             :       Rien

--
-- Retourne             :       Rien
-- JFF  25/07/2011 [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S06_W_GTI_NBSIN' AND type = 'P' )
        DROP procedure sysadm.PS_S06_W_GTI_NBSIN
GO

CREATE procedure sysadm.PS_S06_W_GTI_NBSIN
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
	@iNbSin		Integer	 OUTPUT
AS

-- Plafond 711

 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin         		= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			DatePart ( year, sinistre.dte_surv )	=	DatePart ( year, @dtSurv )	AND
			( sinistre.cod_etat        		in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '711'
				  And    sinistre.cod_etat = 100
				  )
			)
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p,
			sysadm.w_sin ws				
	 WHERE  sinistre.id_sin         		= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			DatePart ( year, sinistre.dte_surv )	=	DatePart ( year, @dtSurv )	AND
			( sinistre.cod_etat        		in ( 550, 600 )
			Or  Exists (  Select *
					  From   sysadm.det_pro
					  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '711'
				  And    sinistre.cod_etat = 100
				  )
			)																		AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S07_W_GTI_NBSIN
-- Auteur               :       Fabry JF
-- Date                 :       07/04/2010
-- Libellé              :       [DCMP100220]
-- Commentaires         :       Plafond nb sinistre par adhésion
-- Références           :       W_TM_SP_W_GTI
--
--
-- Retourne             :       Rien

--
-- Retourne             :       Rien
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S07_W_GTI_NBSIN' AND type = 'P' )
        DROP procedure sysadm.PS_S07_W_GTI_NBSIN
GO



CREATE procedure sysadm.PS_S07_W_GTI_NBSIN
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
		@iNbSin		Integer	 OUTPUT
AS

-- Plafond 715
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
 
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin         		= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			( sinistre.cod_etat        		in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '715'
				  And    sinistre.cod_etat = 100
				  )
			)	  
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p
	 WHERE  sinistre.id_sin         		= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			( sinistre.cod_etat        		in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '715'
				  And    sinistre.cod_etat = 100
				  )
			)																		AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
        
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S08_W_GTI_NBSIN
-- Auteur               :       Fabry JF
-- Date                 :       07/04/2010
-- Libellé              :       [DCMP100220]
-- Commentaires         :       Plafond nb sinistre par adhérent
-- Références           :       W_TM_SP_W_GTI
--
--
-- Retourne             :       Rien

--
-- Retourne             :       Rien
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S08_W_GTI_NBSIN' AND type = 'P' )
        DROP procedure sysadm.PS_S08_W_GTI_NBSIN
GO

CREATE procedure sysadm.PS_S08_W_GTI_NBSIN
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdsDos       Decimal (  2,0 ),
	@iNbSin		Integer	 OUTPUT
AS

-- Plafond 716


 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin         		= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        		= @dcIdsDos                             AND
			( sinistre.cod_etat        		in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '716'
				  And    sinistre.cod_etat = 100 
				  )
			)	  
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
		 SELECT @iNbSin  = count ( * )
		 FROM   sysadm.sinistre,
				sysadm.gar_sin,
				sysadm.personne p
		 WHERE  sinistre.id_sin         		= gar_sin.id_sin                        AND
				sinistre.id_sin        			<> @dcIdSin                             AND
				sinistre.id_prod        		= @dcIdProd                             AND
				sinistre.id_ets         		= @dcIdEts                              AND
				sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
				sinistre.id_sdos        		= @dcIdsDos                             AND
				( sinistre.cod_etat        		in ( 550, 600 )
				Or  Exists (  Select *
    					  From   sysadm.det_pro
    					  Where  det_pro.id_prod = sinistre.id_prod 
					  And    det_pro.id_code_dp = 182
					  And    det_pro.id_code_car = '716'
					  And    sinistre.cod_etat = 100 
					  )
				)																		AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S09_W_GTI_NBGTI_ADHERENT_V01
-- Auteur               :       F. Pinon
-- Date                 :       17/06/2010
-- Libellé              :       [DCMP100410]
-- Commentaires         :       Plafond nb sinistre par adhérent & gti
-- Références           :       W_TM_SP_W_GTI
--
--
-- Retourne             :       Rien

--
-- Retourne             :       Rien
--  JFF   07/12/2010    [PC397][PC441][PC443]
-------------------------------------------------------------------
-- V01 - ajout sous dossier
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S09_W_GTI_NBGTI_ADHERENT_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S09_W_GTI_NBGTI_ADHERENT_V01
GO

CREATE procedure sysadm.PS_S09_W_GTI_NBGTI_ADHERENT_V01
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdsDos       Decimal (  2,0 ),
	@dtSurv         DateTime        ,
	@dcIdGti        Decimal (  7,0 ),
        @iNbSin		Integer	 OUTPUT
AS
  Declare @sDuree varchar(5),
	  @sUnite varchar(1),
	  @dtMinSurv Datetime

  Select @sDuree=NULL,@sUnite=NULL
  	  
  Select @sDuree = sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'DUREE_PERIODE', IsNull ( dp.val_car, '' ), ';' ) ),
  	 @sUnite = sysadm.FN_CLE_VAL ( 'UNITE_PERIODE', IsNull ( dp.val_car, '' ), ';' ) 
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 139  
  and    dp.val_num = 718  --  [PC397][PC441][PC443]  
  and    id_code_num = @dcIdGti

  If @sDuree is NULL Or @sUnite is NULL
  Begin
    Set @iNbSin=0
    Return
  End 

  select @dtMinSurv=Case @sUnite
  			When 'J' Then DateAdd ( day, - convert ( integer, @sDuree ), @dtSurv )
  			When 'M' Then DateAdd ( Month, - convert ( integer, @sDuree ), @dtSurv )
  			When 'A' Then DateAdd ( Year, - convert ( integer, @sDuree ), @dtSurv )
  		  End

-- Plafond 718
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.gar_sin g
	 WHERE  s.id_sin = g.id_sin                        	AND
		g.id_gti = @dcIdGti				AND
			s.id_sin  <> @dcIdSin				AND
			s.id_prod = @dcIdProd				AND
			s.id_ets = @dcIdEts				AND
			s.id_adh = @sIdAdh				AND  -- [PI038][RELEVE]
			s.id_sdos  	= @dcIdsDos                     AND
			s.dte_surv      <= @dtSurv                      AND 
			s.dte_surv      >= @dtMinSurv AND
		( s.cod_etat       in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '718'
				  And    s.cod_etat = 100
				  )
			)        
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.gar_sin g,
			sysadm.personne p
	 WHERE  s.id_sin = g.id_sin                        	AND
		g.id_gti = @dcIdGti				AND
			s.id_sin  <> @dcIdSin				AND
			s.id_prod = @dcIdProd				AND
			s.id_ets = @dcIdEts				AND
			s.id_adh = @sIdAdh				AND  -- [PI038][RELEVE]
			s.id_sdos  	= @dcIdsDos         AND
			s.dte_surv      <= @dtSurv      AND 
			s.dte_surv      >= @dtMinSurv   AND
		( s.cod_etat       in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '718'
				  And    s.cod_etat = 100
				  )
			)        						AND
			p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S10_W_GTI_NBGTI_ADHESION
-- Auteur               :       F. Pinon
-- Date                 :       17/06/2010
-- Libellé              :       [DCMP100410]
-- Commentaires         :       Plafond nb sinistre par adhérent & gti
-- Références           :       W_TM_SP_W_GTI
--
--
-- Retourne             :       Rien

--
-- Retourne             :       Rien
--  JFF   07/12/2010    [PC397][PC441][PC443]
-------------------------------------------------------------------
-- V01 - suppr du sous dossier
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S10_W_GTI_NBGTI_ADHESION_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S10_W_GTI_NBGTI_ADHESION_V01
GO

CREATE procedure sysadm.PS_S10_W_GTI_NBGTI_ADHESION_V01
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
		@dcIdGti        Decimal (  7,0 ),
        @iNbSin		Integer	 OUTPUT
AS
 Declare @sDuree varchar(5),
	  @sUnite varchar(1),
	  @dtMinSurv Datetime

  Select @sDuree=NULL,@sUnite=NULL
  
  Select @sDuree = sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'DUREE_PERIODE', IsNull ( dp.val_car, '' ), ';' ) ),
  	 @sUnite = sysadm.FN_CLE_VAL ( 'UNITE_PERIODE', IsNull ( dp.val_car, '' ), ';' ) 
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 139
  and    dp.val_num = 717  --  [PC397][PC441][PC443]  
  and    id_code_num = @dcIdGti

  If @sDuree is NULL Or @sUnite is NULL
  Begin
    Set @iNbSin=0
    Return
  End 
  
  select @dtMinSurv=Case @sUnite
  			When 'J' Then DateAdd ( day, - convert ( integer, @sDuree ), @dtSurv )
  			When 'M' Then DateAdd ( Month, - convert ( integer, @sDuree ), @dtSurv )
  			When 'A' Then DateAdd ( Year, - convert ( integer, @sDuree ), @dtSurv )
  		  End

-- Plafond 717
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
  
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.gar_sin g
	 WHERE  s.id_sin = g.id_sin                        	AND
		g.id_gti = @dcIdGti				AND
			s.id_sin  <> @dcIdSin				AND
			s.id_prod = @dcIdProd				AND
			s.id_ets = @dcIdEts				AND
			s.id_adh = @sIdAdh				AND  -- [PI038][RELEVE]
			s.dte_surv      <= @dtSurv                      AND 
			s.dte_surv      >= @dtMinSurv			AND
			( s.cod_etat        		in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '717'
				  And    s.cod_etat = 100
				  )
			)        	  
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.gar_sin g,
			sysadm.personne p			
	 WHERE  s.id_sin = g.id_sin                     	AND
			g.id_gti = @dcIdGti				AND
			s.id_sin  <> @dcIdSin			AND
			s.id_prod = @dcIdProd			AND
			s.id_ets = @dcIdEts				AND
			s.id_adh = @sIdAdh				AND  -- [PI038][RELEVE]
			s.dte_surv      <= @dtSurv                      AND 
			s.dte_surv      >= @dtMinSurv			AND
			( s.cod_etat        		in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '717'
				  And    s.cod_etat = 100
				  )
			)        	  									AND
			p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
  
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S11_W_GTI_NBGTI_PEC_ADHESION	
-- Auteur               :       JFF
-- Date                 :       07/12/2010
-- Libellé              :       [DCMP100410]
-- Commentaires         :       Plafond nb sinistre par adhérent & gti
-- Références           :       [PC397][PC441][PC443]
--
--
-- Retourne             :       Rien

--
-- Retourne             :       Rien
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S11_W_GTI_NBGTI_PEC_ADHESION' AND type = 'P' )
        DROP procedure sysadm.PS_S11_W_GTI_NBGTI_PEC_ADHESION
GO


CREATE procedure sysadm.PS_S11_W_GTI_NBGTI_PEC_ADHESION
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
	@dtSurv         DateTime        ,
	@dcIdGti        Decimal (  7,0 ),
        @iNbSin		Integer	 OUTPUT
AS
 Declare @sDuree varchar(5),
	  @sUnite varchar(1),
	  @dtMinSurv Datetime

-- Plafond 719
-- Volontairement je ne regarde par l'option dp/182, l'état 100 est implicite pour ce plafond de PEC.

  Select @sDuree=NULL,@sUnite=NULL
  
  Select @sDuree = sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'DUREE_PERIODE', IsNull ( dp.val_car, '' ), ';' ) ),
  	 @sUnite = sysadm.FN_CLE_VAL ( 'UNITE_PERIODE', IsNull ( dp.val_car, '' ), ';' ) 
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 139
  and    dp.val_num = 719
  and    id_code_num = @dcIdGti

  If @sDuree is NULL Or @sUnite is NULL
  Begin
    Set @iNbSin=0
    Return
  End 
  
  Select @dtMinSurv=Case @sUnite
  			When 'J' Then DateAdd ( day, - convert ( integer, @sDuree ), @dtSurv )
  			When 'M' Then DateAdd ( Month, - convert ( integer, @sDuree ), @dtSurv )
  			When 'A' Then DateAdd ( Year, - convert ( integer, @sDuree ), @dtSurv )
  		  End


 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
  
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.detail d,
			sysadm.gar_sin g,
			sysadm.div_det dd
	 WHERE  s.id_sin <> @dcIdSin				AND
			s.id_prod = @dcIdProd				AND
			s.id_ets = @dcIdEts				AND
			s.id_adh = @sIdAdh				AND  -- [PI038][RELEVE]
			s.dte_surv      <= @dtSurv                      AND 
			s.dte_surv      >= @dtMinSurv			AND
			s.cod_etat in ( 100, 550, 600 ) 		AND
			g.id_sin = s.id_sin				AND
		g.id_gti = @dcIdGti				AND        
			g.cod_etat in ( 100, 550, 600 )			AND
			d.id_sin = g.id_sin				AND
			d.id_gti = g.id_gti				AND
			d.cod_etat in ( 100, 500, 600 )			AND
			dd.id_sin = d.id_sin				AND
			dd.id_gti = d.id_gti				AND
			dd.id_detail = d.id_detail			AND        
			dd.nom_zone = 'pec'				AND
			dd.val_car = 'O'
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.detail d,
			sysadm.gar_sin g,
			sysadm.div_det dd,
			sysadm.personne p
	 WHERE  s.id_sin <> @dcIdSin				AND
			s.id_prod = @dcIdProd				AND
			s.id_ets = @dcIdEts				AND
			s.id_adh = @sIdAdh				AND  -- [PI038][RELEVE]
			s.dte_surv      <= @dtSurv                      AND 
			s.dte_surv      >= @dtMinSurv			AND
			s.cod_etat in ( 100, 550, 600 ) 		AND
			g.id_sin = s.id_sin				AND
			g.id_gti = @dcIdGti				AND        
			g.cod_etat in ( 100, 550, 600 )			AND
			d.id_sin = g.id_sin				AND
			d.id_gti = g.id_gti				AND
			d.cod_etat in ( 100, 500, 600 )			AND
			dd.id_sin = d.id_sin				AND
			dd.id_gti = d.id_gti				AND
			dd.id_detail = d.id_detail			AND        
			dd.nom_zone = 'pec'				AND
			dd.val_car = 'O'												AND
			p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
     
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S12_W_GTI_NBGTI_PEC_ADHERENT
-- Auteur               :       JFF
-- Date                 :       07/12/2010
-- Libellé              :       [DCMP100410]
-- Commentaires         :       Plafond nb sinistre par adhérent & gti
-- Références           :       [PC397][PC441][PC443]
--
--
-- Retourne             :       Rien

--
-- Retourne             :       Rien
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S12_W_GTI_NBGTI_PEC_ADHERENT' AND type = 'P' )
        DROP procedure sysadm.PS_S12_W_GTI_NBGTI_PEC_ADHERENT
GO

CREATE procedure sysadm.PS_S12_W_GTI_NBGTI_PEC_ADHERENT
        @dcIdSin        Decimal (  10,0 ),-- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdsDos       Decimal (  2,0 ),
	@dtSurv         DateTime        ,
	@dcIdGti        Decimal (  7,0 ),
        @iNbSin		Integer	 OUTPUT
AS
 Declare @sDuree varchar(5),
	  @sUnite varchar(1),
	  @dtMinSurv Datetime

  Select @sDuree=NULL,@sUnite=NULL
  
  Select @sDuree = sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'DUREE_PERIODE', IsNull ( dp.val_car, '' ), ';' ) ),
  	 @sUnite = sysadm.FN_CLE_VAL ( 'UNITE_PERIODE', IsNull ( dp.val_car, '' ), ';' ) 
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 139
  and    dp.val_num = 720
  and    id_code_num = @dcIdGti

  If @sDuree is NULL Or @sUnite is NULL
  Begin
    Set @iNbSin=0
    Return
  End 
  
  Select @dtMinSurv=Case @sUnite
  			When 'J' Then DateAdd ( day, - convert ( integer, @sDuree ), @dtSurv )
  			When 'M' Then DateAdd ( Month, - convert ( integer, @sDuree ), @dtSurv )
  			When 'A' Then DateAdd ( Year, - convert ( integer, @sDuree ), @dtSurv )
  		  End

-- Plafond 720
-- Volontairement je ne regarde par l'option dp/182, l'état 100 est implicite pour ce plafond de PEC.

 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
 
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.detail d,
			sysadm.gar_sin g,
			sysadm.div_det dd
	 WHERE  s.id_sin <> @dcIdSin				AND
			s.id_prod = @dcIdProd				AND
			s.id_ets = @dcIdEts				AND
			s.id_adh = @sIdAdh				AND  -- [PI038][RELEVE]
			s.id_sdos  	= @dcIdsDos                     AND
			s.dte_surv      <= @dtSurv                      AND 
			s.dte_surv      >= @dtMinSurv			AND
			s.cod_etat in ( 100, 550, 600 ) 		AND
			g.id_sin = s.id_sin				AND
			g.id_gti = @dcIdGti				AND        
			g.cod_etat in ( 100, 550, 600 )			AND
			d.id_sin = g.id_sin				AND
			d.id_gti = g.id_gti				AND
			d.cod_etat in ( 100, 500, 600 )			AND
			dd.id_sin = d.id_sin				AND
			dd.id_gti = d.id_gti				AND
			dd.id_detail = d.id_detail			AND        
			dd.nom_zone = 'pec'				AND
			dd.val_car = 'O'
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.detail d,
			sysadm.gar_sin g,
			sysadm.div_det dd,
			sysadm.personne p
	 WHERE  s.id_sin <> @dcIdSin				AND
			s.id_prod = @dcIdProd				AND
			s.id_ets = @dcIdEts				AND
			s.id_adh = @sIdAdh				AND  -- [PI038][RELEVE]
			s.id_sdos  	= @dcIdsDos                     AND
			s.dte_surv      <= @dtSurv                      AND 
			s.dte_surv      >= @dtMinSurv			AND
			s.cod_etat in ( 100, 550, 600 ) 		AND
			g.id_sin = s.id_sin				AND
			g.id_gti = @dcIdGti				AND        
			g.cod_etat in ( 100, 550, 600 )			AND
			d.id_sin = g.id_sin				AND
			d.id_gti = g.id_gti				AND
			d.cod_etat in ( 100, 500, 600 )			AND
			dd.id_sin = d.id_sin				AND
			dd.id_gti = d.id_gti				AND
			dd.id_detail = d.id_detail			AND        
			dd.nom_zone = 'pec'				AND
			dd.val_car = 'O'												AND
			p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
     
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_RECH_PGC_PANNE
-- Auteur               :       JFF
-- Date                 :       07/12/2010
-- Libellé              :       [PC363].[PANNE_PGC]
-- Commentaires         :       
-- Références           :       [PC363].[PANNE_PGC]
--
--
-- Retourne             :       Rien

--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_RECH_PGC_PANNE' AND type = 'P' )
        DROP procedure sysadm.PS_S01_RECH_PGC_PANNE
GO

CREATE procedure sysadm.PS_S01_RECH_PGC_PANNE
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
	@iPresence_Panne integer OUTPUT,
	@iPresence_PGC   integer OUTPUT,
	@dtDteRempl	DateTime OUTPUT
AS
 SELECT @iPresence_Panne = 
		Case g.id_gti
			When 18 Then 1
			Else 0
		End,
	@iPresence_PGC = 
		Case g.id_gti
			When 15 Then 1
			Else 0
		End,
	@dtDteRempl = c.cree_le
	
 FROM   sysadm.sinistre s,
        sysadm.gar_sin g,
        sysadm.commande c
 WHERE  s.id_sin   <> @dcIdSin
 And    s.id_prod  = @dcIdProd
 And    s.id_ets   = @dcIdEts
 And    s.id_adh   = @sIdAdh
 And    s.id_sin   = g.id_sin
 And    g.id_gti   in (15, 18)
 And	c.id_sin   = s.id_sin
 And    c.id_four  = 'O2M'
 And	c.id_ref_four = 'DECISION_SPB'
 And    c.info_spb_frn = 970
 And    c.cod_etat <> 'ANN'
 
 If @iPresence_Panne is null Set @iPresence_Panne = 0
 If @iPresence_PGC is null Set @iPresence_PGC = 0

 SELECT @iPresence_Panne = @iPresence_Panne + 
		IsNull ( 
			Case g.id_gti
				When 18 Then 1
				Else 0
			End
		, 0 ),
	@iPresence_PGC = @iPresence_PGC +
		IsNull ( 
			Case g.id_gti
				When 15 Then 1
				Else 0
			End
		, 0 ),
	@dtDteRempl = c.cree_le		

 FROM   sysadm.w_sin s,
        sysadm.w_gar_sin g,
        sysadm.w_commande c
 WHERE  s.id_sin   <> @dcIdSin
 And    s.id_prod  = @dcIdProd
 And    s.id_ets   = @dcIdEts
 And    s.id_adh   = @sIdAdh
 And    s.id_sin   = g.id_sin
 And    g.id_gti   in (15, 18)
 And	c.id_sin   = s.id_sin
 And    c.id_four  = 'O2M'
 And	c.id_ref_four = 'DECISION_SPB'
 And    c.info_spb_frn = 970
 And    c.cod_etat <> 'ANN'
 
 If @iPresence_Panne is null Set @iPresence_Panne = 0
 If @iPresence_PGC is null Set @iPresence_PGC = 0

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S13_W_GTI_NBSIN_NUM_PORT
-- Auteur               :       FPI
-- Date                 :       06/05/2011
-- Libellé              :       [PC345]
-- Commentaires         :       Plafond nb sinistre par produit/numéro portable sinistré
-- Références           :       
--
--
-- Retourne             :       Rien

--
-- Retourne             :       Rien
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S13_W_GTI_NBSIN_NUM_PORT' AND type = 'P' )
        DROP procedure sysadm.PS_S13_W_GTI_NBSIN_NUM_PORT
GO

CREATE procedure sysadm.PS_S13_W_GTI_NBSIN_NUM_PORT
        @dcIdSin        Decimal (10,0),  -- [PI062]
        @dcIdProd       Decimal (7,0),
        @sNumPort       Varchar (25),
        @dtSurv         DateTime ,
        @iNbSin         Integer	 OUTPUT
AS
	Declare @iAnneeSurv int
	
	-- Plafond 723
	
	Select @iNbSin=0, @iAnneeSurv=year(@dtSurv), @sNumPort=replace(@sNumPort,' ','')
	
	select @iNbSin=Count(*)
	from sysadm.sinistre s
	where s.id_prod = @dcIdProd
	and s.num_port  = @sNumPort
	and year(s.dte_surv) = @iAnneeSurv
	and s.id_sin <> @dcIdSin
	and ( cod_etat not in (900,200)
        	Or  Exists (  Select *
        	      From   sysadm.det_pro
        	      Where  det_pro.id_prod = s.id_prod 
		      And    det_pro.id_code_dp = 182
		      And    det_pro.id_code_car = '723'
		      And    s.cod_etat = 100 
		      )
	    )

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_W_GTI_NBSIN_NUM_PORT_ANN_ADH
-- Auteur               :       JFF
-- Date                 :       10/02/2016
-- Libellé              :       [VDOC19467]
-- Commentaires         :       Plafond nb sinistre par produit/numéro portable sinistré
-- Références           :       
--
--
-- Retourne             :       Rien

--
-- Retourne             :       Rien
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_W_GTI_NBSIN_NUM_PORT_ANN_ADH' AND type = 'P' )
        DROP procedure sysadm.PS_S_W_GTI_NBSIN_NUM_PORT_ANN_ADH
GO

CREATE procedure sysadm.PS_S_W_GTI_NBSIN_NUM_PORT_ANN_ADH
        @dcIdSin        Decimal (10,0), -- [PI062]
        @dcIdProd       Decimal (7,0),
		@dcIdEts		Decimal (7,0),
		@sIdAdh			VarChar ( 19),
        @sNumPort       Varchar ( 25),
        @dtSurv         DateTime ,
		@dtAdhRenouv    DateTime ,
        @iNbSin         Integer	 OUTPUT
AS
	Declare @iAnneeSurv int
	
	-- Plafond 752
	
	Select @iNbSin=0, @iAnneeSurv=year(@dtSurv), @sNumPort=replace(@sNumPort,' ','')
	
	select @iNbSin=Count(*)
	from sysadm.sinistre s
	where s.id_prod = @dcIdProd
	and s.num_port  = @sNumPort
	and s.id_sin <> @dcIdSin
	And s.id_prod = @dcIdProd
    And s.id_ets = @dcIdEts
	AND s.id_adh = @sIdAdh
	AND s.dte_surv  <= @dtSurv
	AND	s.dte_surv  >= @dtAdhRenouv
	and ( s.cod_etat not in (900,200)
        	Or  Exists (  Select *
        	      From   sysadm.det_pro
        	      Where  det_pro.id_prod = s.id_prod 
		      And    det_pro.id_code_dp = 182
		      And    det_pro.id_code_car = '752'
		      And    s.cod_etat = 100 
		      )
	    )
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S14_W_GTI_NBGTI_ADHESION
-- Auteur               :       Fabry JF
-- Date                 :       23/08/11
-- Libellé              :       
-- Commentaires         :       
-- Références           :       W_TM_SP_W_GTI
--
--
-- Retourne             :       Rien
--
-- Retourne             :       Rien
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S14_W_GTI_NBGTI_ADHESION' AND type = 'P' )
        DROP procedure sysadm.PS_S14_W_GTI_NBGTI_ADHESION
GO

CREATE procedure sysadm.PS_S14_W_GTI_NBGTI_ADHESION
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
	@iNbSin		Integer	 OUTPUT
AS

-- Plafond 724

 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

  Select @sCodAdh = p.cod_adh,
		 @sNom = s.nom,  -- [ITSM361927]
		 @sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin         		= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			( sinistre.cod_etat        		in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '724'
				  And    sinistre.cod_etat = 100
				  )
			) AND
			gar_sin.id_gti = @dcIdGti
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p
	 WHERE  sinistre.id_sin         		= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			( sinistre.cod_etat        		in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '724'
				  And    sinistre.cod_etat = 100
				  )
			) AND
			gar_sin.id_gti = @dcIdGti												AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S15_W_GTI_NBGTI_ADHERENT
-- Auteur               :       Fabry JF
-- Date                 :       23/08/11
-- Libellé              :       
-- Commentaires         :       Plafond nb sinistre par adhérent
-- Références           :       W_TM_SP_W_GTI
--
--
-- Retourne             :       Rien
--
-- Retourne             :       Rien
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S15_W_GTI_NBGTI_ADHERENT' AND type = 'P' )
        DROP procedure sysadm.PS_S15_W_GTI_NBGTI_ADHERENT
GO


CREATE procedure sysadm.PS_S15_W_GTI_NBGTI_ADHERENT 
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdsDos       Decimal (  2,0 ),
	@dcIdGti        Decimal (  7,0 ),
	@iNbSin		Integer	 OUTPUT
AS

-- Plafond 725

 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin         		= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        		= @dcIdsDos                             AND
			( sinistre.cod_etat        		in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '725'
				  And    sinistre.cod_etat = 100
				  )
			) AND 
			gar_sin.id_gti = @dcIdGti	  
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p
	 WHERE  sinistre.id_sin         		= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        		= @dcIdsDos                             AND
			( sinistre.cod_etat        		in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '725'
				  And    sinistre.cod_etat = 100
				  )
			) AND 
			gar_sin.id_gti = @dcIdGti	  											AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				

	        
  End
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S09_W_GTI_NBSIN
-- Auteur               :       Fabry JF
-- Date                 :       22/11/2011
-- Libellé              :       [PC581].[POINT155][VDOC5984]
-- Commentaires         :       Calcul du nombre de sinistre par adhesion (Survenance)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S09_W_GTI_NBSIN' AND type = 'P' )
        DROP procedure sysadm.PS_S09_W_GTI_NBSIN
GO


CREATE procedure sysadm.PS_S09_W_GTI_NBSIN
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @iNbSin		Integer	 OUTPUT
   
AS

 -- Plafond 726
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.gar_sin g
	 WHERE  s.id_sin         = g.id_sin				 AND
		s.id_sin        <> @dcIdSin                              AND
			s.id_prod        = @dcIdProd                             AND
			s.id_ets         = @dcIdEts                              AND
			s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			s.dte_surv      <= @dtSurv                               AND
			s.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			( s.cod_etat      in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '726'
				  And    s.cod_etat = 100 )
			) AND
			g.id_gti = @dcIdGti
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.gar_sin g,
			sysadm.personne p
	 WHERE  s.id_sin         = g.id_sin				 AND
			s.id_sin        <> @dcIdSin                              AND
			s.id_prod        = @dcIdProd                             AND
			s.id_ets         = @dcIdEts                              AND
			s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			s.dte_surv      <= @dtSurv                               AND
			s.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			( s.cod_etat      in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '726'
				  And    s.cod_etat = 100 )
			) AND
			g.id_gti = @dcIdGti										 AND
			p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S10_W_GTI_NBSIN
-- Auteur               :       Fabry JF
-- Date                 :       22/11/2011
-- Libellé              :       [PC581].[POINT155][VDOC5984]
-- Commentaires         :       Calcul du nombre de sinistre par adherent (Survenance)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdsDos       Decimal (  2,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S10_W_GTI_NBSIN' AND type = 'P' )
        DROP procedure sysadm.PS_S10_W_GTI_NBSIN
GO

CREATE procedure sysadm.PS_S10_W_GTI_NBSIN
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
	@dcIdsDos       Decimal (  2,0 ),
        @dtSurv         DateTime        ,
        @iNbSin		Integer	 OUTPUT
AS
 -- Plafond 727
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.gar_sin g
	 WHERE  s.id_sin         = g.id_sin				 AND
			s.id_sin        <> @dcIdSin                              AND
			s.id_prod        = @dcIdProd                             AND
			s.id_ets         = @dcIdEts                              AND
			s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			s.id_sdos        = @dcIdsDos                             AND
			s.dte_surv      <= @dtSurv                               AND
			s.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			( s.cod_etat      in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '727'
				  And    s.cod_etat = 100 )
			) AND               
			g.id_gti = @dcIdGti      	  
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.gar_sin g,
			sysadm.personne p		
	 WHERE  s.id_sin         = g.id_sin				 AND
			s.id_sin        <> @dcIdSin                              AND
			s.id_prod        = @dcIdProd                             AND
			s.id_ets         = @dcIdEts                              AND
			s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			s.id_sdos        = @dcIdsDos                             AND
			s.dte_surv      <= @dtSurv                               AND
			s.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			( s.cod_etat      in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '727'
				  And    s.cod_etat = 100 )
			) AND               
			g.id_gti = @dcIdGti      	  							AND
			p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S11_W_GTI_NBSIN
-- Auteur               :       Fabry JF
-- Date                 :       22/11/2011
-- Libellé              :       [PC581].[POINT155][VDOC5984]
-- Commentaires         :       Calcul du nombre de sinistre par adhesion (Renouvellement)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]

-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S11_W_GTI_NBSIN' AND type = 'P' )
        DROP procedure sysadm.PS_S11_W_GTI_NBSIN
GO

CREATE procedure sysadm.PS_S11_W_GTI_NBSIN
        @dcIdSin        Decimal (  10,0 ),-- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),        
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
	@iNbSin		Integer	 OUTPUT
	
AS
 -- Plafond 728
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
  
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.gar_sin g
	 WHERE  s.id_sin         = g.id_sin				 AND
		s.id_sin        <> @dcIdSin                              AND
			s.id_prod        = @dcIdProd                             AND
			s.id_ets         = @dcIdEts                              AND
			s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			s.dte_surv      <= @dtSurv                               AND
			s.dte_surv      >= @dtAdhRenouv                          AND
			( s.cod_etat      in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '728'
				  And    s.cod_etat = 100 )
			) AND               
			g.id_gti = @dcIdGti   
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.gar_sin g,
			sysadm.personne p
	 WHERE  s.id_sin         = g.id_sin				 AND
		s.id_sin        <> @dcIdSin                              AND
			s.id_prod        = @dcIdProd                             AND
			s.id_ets         = @dcIdEts                              AND
			s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			s.dte_surv      <= @dtSurv                               AND
			s.dte_surv      >= @dtAdhRenouv                          AND
			( s.cod_etat      in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '728'
				  And    s.cod_etat = 100 )
			) AND               
			g.id_gti = @dcIdGti   									AND
			p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S12_W_GTI_NBSIN
-- Auteur               :       Fabry JF
-- Date                 :       22/11/2011
-- Libellé              :       [PC581].[POINT155][VDOC5984]
-- Commentaires         :       Calcul du nombre de sinistre par adherent (Renouvellement)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdsDos       Decimal (  2,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S12_W_GTI_NBSIN' AND type = 'P' )
        DROP procedure sysadm.PS_S12_W_GTI_NBSIN
GO


CREATE procedure sysadm.PS_S12_W_GTI_NBSIN
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
	@dcIdsDos       Decimal (  2,0 ),
	@dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
	@iNbSin		Integer	 OUTPUT
	
AS
 -- Plafond 729
 
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.gar_sin g
	 WHERE  s.id_sin         = g.id_sin				 AND
		s.id_sin        <> @dcIdSin                              AND
			s.id_prod        = @dcIdProd                             AND
			s.id_ets         = @dcIdEts                              AND
			s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			s.id_sdos        = @dcIdsDos                             AND
			s.dte_surv      <= @dtSurv                               AND
			s.dte_surv      >= @dtAdhRenouv                          AND
			( s.cod_etat    in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '698'
				  And    s.cod_etat = 100 )
			) AND               
			g.id_gti = @dcIdGti   	  
  
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.gar_sin g,
			sysadm.personne p
	 WHERE  s.id_sin         = g.id_sin				 AND
		s.id_sin        <> @dcIdSin                              AND
			s.id_prod        = @dcIdProd                             AND
			s.id_ets         = @dcIdEts                              AND
			s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			s.id_sdos        = @dcIdsDos                             AND
			s.dte_surv      <= @dtSurv                               AND
			s.dte_surv      >= @dtAdhRenouv                          AND
			( s.cod_etat    in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '698'
				  And    s.cod_etat = 100 )
			) AND               
			g.id_gti = @dcIdGti   	  								AND
			p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_W_GTI_PLAF_ADHESION
-- Auteur               :       Fabry JF
-- Date                 :       23/08/11
-- Libellé              :       [VDOC7410]
-- Commentaires         :       
-- Références           :       W_TM_SP_W_GTI
--
--
-- Retourne             :       Rien
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_W_GTI_PLAF_ADHESION' AND type = 'P' )
        DROP procedure sysadm.PS_S_W_GTI_PLAF_ADHESION
GO

CREATE procedure sysadm.PS_S_W_GTI_PLAF_ADHESION
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS

-- Plafond 732
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
 
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin         		= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			gar_sin.id_gti 				= @dcIdGti				AND
			(
			gar_sin.cod_etat        = 550 OR
			gar_sin.cod_etat        = 600
			)
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p
	 WHERE  sinistre.id_sin         		= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			gar_sin.id_gti 				= @dcIdGti				AND
			(
			gar_sin.cod_etat        = 550 OR
			gar_sin.cod_etat        = 600
			)																		AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
  End
       
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_W_GTI_PLAF_ADHERENT
-- Auteur               :       Fabry JF
-- Date                 :       23/08/11
-- Libellé              :       [VDOC7410]
-- Commentaires         :       
-- Références           :       W_TM_SP_W_GTI
--
--
-- Retourne             :       Rien
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_W_GTI_PLAF_ADHERENT' AND type = 'P' )
        DROP procedure sysadm.PS_S_W_GTI_PLAF_ADHERENT
GO

CREATE procedure sysadm.PS_S_W_GTI_PLAF_ADHERENT
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdsDos       Decimal (  2,0 ),
        @dcIdGti        Decimal (  7,0 ),
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS

-- Plafond 733

 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
 
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin         		= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos			= @dcIdsDos				AND
			gar_sin.id_gti 				= @dcIdGti				AND
			(
			gar_sin.cod_etat        = 550 OR
			gar_sin.cod_etat        = 600
			)	  
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p
	 WHERE  sinistre.id_sin         		= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos			= @dcIdsDos									AND
			gar_sin.id_gti 				= @dcIdGti									AND
			(
			gar_sin.cod_etat        = 550 OR
			gar_sin.cod_etat        = 600
			)																		AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
  End
       
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S734_W_GTI_MT_PLAF
-- Auteur               :       Fabry JF
-- Date                 :       23/11/12
-- Libellé              :       [PC877]
-- Commentaires         :       Calcul des plafonds par adh‚sion (Survenance)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S734_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S734_W_GTI_MT_PLAF
GO


CREATE procedure sysadm.PS_S734_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS
-- 734

 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
  
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				

	        
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S735_W_GTI_MT_PLAF
-- Auteur               :       Fabry JF
-- Date                 :       23/11/12
-- Libellé              :       [PC877]
-- Commentaires         :       Calcul des plafonds par adh‚rent (Survenance)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdsDos       Decimal (  2,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S735_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S735_W_GTI_MT_PLAF
GO


CREATE procedure sysadm.PS_S735_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ), 
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdsDos       Decimal (  2,0 ),
        @dtSurv         DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS
-- 735

 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
 
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S736_W_GTI_MT_PLAF
-- Auteur               :       Fabry JF
-- Date                 :       23/11/12
-- Libellé              :       [PC877]
-- Commentaires         :       Calcul des plafonds par adh‚sion (Renouvellement)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
--
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S736_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S736_W_GTI_MT_PLAF
GO


CREATE procedure sysadm.PS_S736_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS
-- 736
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
 
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)	  
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p,
			sysadm.w_sin ws
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S750_W_GTI_MT_PLAF
-- Auteur               :       Fabry JF
-- Date                 :       08/09/2015
-- Libellé              :       [DT162]
-- Commentaires         :       Calcul des plafonds par adh‚sion (Renouvellement)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
--
-- JFF      20/01/2014   [PM208]
-- JFF      28/10/2015   [MANTIS17828]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S750_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S750_W_GTI_MT_PLAF
GO


CREATE procedure sysadm.PS_S750_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS
-- Plafond 750
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
  
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.det_pro dp -- [DT162]
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			dp.id_prod				= @dcIdProd								AND
			dp.id_code_dp			= 289									AND
			dp.id_typ_calc			= '-PL'									AND
			dp.id_code_num			= 750									AND
			CHARINDEX (	'#' + CONVERT ( varchar ( 10), sinistre.id_prod ) + '#', dp.val_car ) > 0  -- [DT162]
	
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p,
			sysadm.det_pro dp -- [DT162]
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
-- [MANTIS17828] sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom								AND -- [ITSM361927]				
			dp.id_prod				= @dcIdProd								AND
			dp.id_code_dp			= 289									AND
			dp.id_typ_calc			= '-PL'									AND
			dp.id_code_num			= 750									AND
			CHARINDEX (	'#' + CONVERT ( varchar ( 10), sinistre.id_prod ) + '#', dp.val_car ) > 0  -- [DT162]
  End
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S737_W_GTI_MT_PLAF
-- Auteur               :       Fabry JF
-- Date                 :       23/11/12
-- Libellé              :       [PC877]
-- Commentaires         :       Calcul des plafonds par adh‚rent (Renouvellement)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdsDos       Decimal (  2,0 )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S737_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S737_W_GTI_MT_PLAF
GO

CREATE procedure sysadm.PS_S737_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdsDos       Decimal (  2,0 ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS
-- 737
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p,
			sysadm.w_sin ws

	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			ws.id_sin				= sinistre.id_sin						AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S738_W_GTI_MT_PLAF
-- Auteur               :       Fabry JF
-- Date                 :       23/11/12
-- Libellé              :       [PC877]
-- Commentaires         :       Calcul des plafonds par adh‚sion (Renouvellement)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      12/05/2020   [PI085]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S738_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S738_W_GTI_MT_PLAF
GO


CREATE procedure sysadm.PS_S738_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProdAdh    Decimal (  7,0 ),
        @sIdSiren       Varchar ( 20   ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS
-- 738
 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
 FROM   sysadm.sinistre,
		sysadm.gar_sin,
		sysadm.produit p  --  [PI085]
 WHERE  p.cod_prod_dms = @dcIdProdAdh								    AND  --  [PI085]
		sinistre.id_sin         = gar_sin.id_sin                        AND
        sinistre.id_sin        <> @dcIdSin                              AND
        sinistre.id_prod        = p.id_prod							    AND  --  [PI085]
        sinistre.id_contrat_abonne = @sIdSiren                          AND
        sinistre.dte_surv      <= @dtSurv                               AND
        sinistre.dte_surv      >= @dtAdhRenouv                          AND
        (
        gar_sin.cod_etat        = 550                                   OR
        gar_sin.cod_etat        = 600
        )
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_W_GTI_MT_PLAF_BOUYGUES
-- Auteur               :       Fabry JF
-- Date                 :       26/11/12
-- Libellé              :       [PC877]
-- Commentaires         :       Calcul des plafonds par adh‚rent (Renouvellement)
-- Références           :       W_TM_SP_W_GTI
--
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_W_GTI_MT_PLAF_BOUYGUES' AND type = 'P' )
        DROP procedure sysadm.PS_S_W_GTI_MT_PLAF_BOUYGUES
GO
CREATE procedure sysadm.PS_S_W_GTI_MT_PLAF_BOUYGUES
    @adcIdProdAdh       Decimal (  7,0 ),
    @adcIdProd          Decimal (  7,0 ),    
    @asIdSiren         Varchar ( 19   ),
    @adtAdh		DateTime		,
    @adtSurv         DateTime       ,
    @adcMtPlaf		 Decimal (11, 2 ) OUTPUT 

AS

Declare @dtAdhRenouv DateTime
Declare @dcDurPerRnv_Adh Integer
Declare @sUntPerRnv_Adh  VarChar ( 10 )
Declare @lCptMax Integer
Declare @sIdRev VarChar ( 5 )
Declare @dcMtPlafond Decimal (  11,2 )
Declare @dcMtPlafReg Decimal (  11,2 )

If @adcIdProdAdh  is null Return -1
If @asIdSiren  is null Return -1
If @adtAdh	 is null Return -1
If @adtSurv  is null Return -1

Select  @dcDurPerRnv_Adh = p.dur_perrnv_adh,
		@sUntPerRnv_Adh = p.unt_perrnv_adh
From   sysadm.produit p
Where  p.id_prod = @adcIdProd 

Set @dtAdhRenouv = @adtAdh
While @dtAdhRenouv < @adtSurv
 Begin
	Select @dtAdhRenouv = Case @sUntPerRnv_Adh
							When 'J' Then DATEADD ( DAY, @dcDurPerRnv_Adh, @dtAdhRenouv)
							When 'M' Then DATEADD ( Month, @dcDurPerRnv_Adh, @dtAdhRenouv )
							When 'A' Then DATEADD ( year, @dcDurPerRnv_Adh, @dtAdhRenouv )														
						  End 
 End 

Select @dtAdhRenouv = Case @sUntPerRnv_Adh
						When 'J' Then DATEADD ( DAY, -@dcDurPerRnv_Adh, @dtAdhRenouv)
						When 'M' Then DATEADD ( Month, -@dcDurPerRnv_Adh, @dtAdhRenouv )
						When 'A' Then DATEADD ( year, -@dcDurPerRnv_Adh, @dtAdhRenouv )														
					  End 

Set @sIdRev = SPACE ( 5 )
Exec sysadm.PS_X_CALC_REVISION @adcIdProd, @adtSurv, @adtAdh, @sIdRev OUTPUT

If Exists ( Select *
			From   sysadm.plafond p
			Where  p.id_prod = @adcIdProd
			And    p.id_rev  = Convert ( Decimal ( 7 ), @sIdRev )
			And    id_niv_plaf = '-GA'
			And    id_ref_plaf = '-1'
			And    id_typ_plaf = 738 ) 
			
	Begin 
		Select @dcMtPlafond = Max ( mt_plaf )
		From   sysadm.plafond p
		Where  p.id_prod = @adcIdProd
		And    p.id_rev  = Convert ( Decimal ( 7 ), @sIdRev )
		And    id_niv_plaf = '-GA'
		And    id_ref_plaf = '-1'
		And    id_typ_plaf = 738
		
		Exec sysadm.PS_S738_W_GTI_MT_PLAF -1, @adcIdProdAdh, @asIdSiren, @adtSurv, @dtAdhRenouv, @dcMtPlafReg OUTPUT
	End 

If @dcMtPlafReg is null Set @dcMtPlafReg = 0
If @dcMtPlafond is null Set @dcMtPlafond = 0
Set @adcMtPlaf = @dcMtPlafond - @dcMtPlafReg 

If @adcMtPlaf <0 Set @adcMtPlaf = 0


Return 1

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S03_W_GTI_NBSIN_DTE_SURV
-- Auteur               :       Fabry JF
-- Date                 :       22/12/2003
-- Libellé              :       [VDOC11880]
-- Commentaires         :       Calcul du nombre de sinistre par adhesion (Renouvellement)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- JFF  25/07/2011 [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S03_W_GTI_NBSIN_DTE_SURV' AND type = 'P' )
        DROP procedure sysadm.PS_S03_W_GTI_NBSIN_DTE_SURV
GO


CREATE procedure sysadm.PS_S03_W_GTI_NBSIN_DTE_SURV
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
	@iNbSin		Integer	 OUTPUT
	
AS
 -- Plafond 742
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
 
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 From (
		 SELECT distinct s.dte_surv
		 FROM   sysadm.sinistre s
		 WHERE  s.id_sin        <> @dcIdSin                              AND
				s.id_prod        = @dcIdProd                             AND
				s.id_ets         = @dcIdEts                              AND
				s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
				s.dte_surv      <= @dtSurv                               AND
				s.dte_surv      >= @dtAdhRenouv                          AND
		        
				( s.cod_etat      in ( 550, 600 )
				Or  Exists (  Select *
    					  From   sysadm.det_pro
    					  Where  det_pro.id_prod = s.id_prod 
					  And    det_pro.id_code_dp = 182
					  And    det_pro.id_code_car = '742'
					  And    s.cod_etat = 100 
					  )
				)  
			) As Tb
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 From (
		 SELECT distinct s.dte_surv
		 FROM   sysadm.sinistre s,
				sysadm.personne p
		 WHERE  s.id_sin        <> @dcIdSin                              AND
				s.id_prod        = @dcIdProd                             AND
				s.id_ets         = @dcIdEts                              AND
				s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
				s.dte_surv      <= @dtSurv                               AND
				s.dte_surv      >= @dtAdhRenouv                          AND
		        
				( s.cod_etat      in ( 550, 600 )
				Or  Exists (  Select *
    					  From   sysadm.det_pro
    					  Where  det_pro.id_prod = s.id_prod 
					  And    det_pro.id_code_dp = 182
					  And    det_pro.id_code_car = '742'
					  And    s.cod_etat = 100 
					  )
				)														AND
				p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
				p.nom					= @sNom									AND -- [ITSM361927]
				p.prenom				= @sPrenom -- [ITSM361927]				
			) As Tb	  
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S751_W_GTI_NBSIN_DTE_SURV
-- Auteur               :       Fabry JF
-- Date                 :       08/09/2015
-- Libellé              :       [DT162]
-- Commentaires         :       Calcul du nombre de sinistre par adhesion (Renouvellement)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- JFF  25/07/2011 [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF      28/10/2015   [MANTIS17828]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-- JFF		06/01/2017   [VDOC22794]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S751_W_GTI_NBSIN_DTE_SURV' AND type = 'P' )
        DROP procedure sysadm.PS_S751_W_GTI_NBSIN_DTE_SURV
GO

CREATE procedure sysadm.PS_S751_W_GTI_NBSIN_DTE_SURV
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
		@iNbSin		Integer	 OUTPUT
	
AS
 -- Plafond 751
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
 
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 From (
		 SELECT distinct s.dte_surv
		 FROM   sysadm.sinistre s,
				sysadm.det_pro dp  -- [DT162]
		 WHERE  s.id_sin        <> @dcIdSin                              AND
--[MANTIS17828] s.id_prod        = @dcIdProd                             AND
				s.id_ets         = @dcIdEts                              AND
				s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
				s.dte_surv		<> @dtSurv								 AND  -- [VDOC22794]
				s.dte_surv      <= @dtSurv                               AND
				s.dte_surv      >= @dtAdhRenouv                          AND
				( s.cod_etat      in ( 550, 600 )
				Or  Exists (  Select *
    					  From   sysadm.det_pro
    					  Where  det_pro.id_prod = s.id_prod 
					  And    det_pro.id_code_dp = 182
					  And    det_pro.id_code_car = '751'
					  And    s.cod_etat = 100 
					  )
				)														  AND
				dp.id_prod				= @dcIdProd								AND
				dp.id_code_dp			= 289									AND
				dp.id_typ_calc			= '-PL'									AND
				dp.id_code_num			= 751									AND
				CHARINDEX (	'#' + CONVERT ( varchar ( 10), s.id_prod ) + '#', dp.val_car ) > 0  -- [DT162]				
			) As Tb

	If @iNbSin is null Set @iNbSin = 0
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 From (
		 SELECT distinct s.dte_surv
		 FROM   sysadm.sinistre s,
				sysadm.personne p,
				sysadm.det_pro dp -- [DT162]
		 WHERE  s.id_sin        <> @dcIdSin                              AND
--[MANTIS17828] s.id_prod        = @dcIdProd                             AND
				s.id_ets         = @dcIdEts                              AND
				s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
				s.dte_surv		<> @dtSurv								 AND  -- [VDOC22794]
				s.dte_surv      <= @dtSurv                               AND
				s.dte_surv      >= @dtAdhRenouv                          AND
		        
				( s.cod_etat      in ( 550, 600 )
				Or  Exists (  Select *
    					  From   sysadm.det_pro
    					  Where  det_pro.id_prod = s.id_prod 
					  And    det_pro.id_code_dp = 182
					  And    det_pro.id_code_car = '751'
					  And    s.cod_etat = 100 
					  )
				)														AND
				p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
				p.nom					= @sNom									AND -- [ITSM361927]
				p.prenom				= @sPrenom						AND -- [ITSM361927]				
				dp.id_prod				= s.id_prod						AND
				dp.id_code_dp			= 289							AND
				dp.id_typ_calc			= '-PL'							AND
				dp.id_code_num			= 751							AND
				CHARINDEX (	'#' + CONVERT ( varchar ( 10), s.id_prod ) + '#', dp.val_car ) > 0  -- [DT162]	
			) As Tb

	If @iNbSin is null Set @iNbSin = 0

  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_W_GTI_NBSIN_RESIL_ADH
-- Auteur               :       Fabry JF
-- Date                 :       10/11/2014
-- Libellé              :       [PC801-5]
-- Commentaires         :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- JFF  25/07/2011 [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-- JFF      03/04/2017   [DT294]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_W_GTI_NBSIN_RESIL_ADH' AND type = 'P' )
        DROP procedure sysadm.PS_S_W_GTI_NBSIN_RESIL_ADH
GO

CREATE procedure sysadm.PS_S_W_GTI_NBSIN_RESIL_ADH
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @iNbSin		Integer	 OUTPUT
AS

-- Plafond 748
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
 Declare @dtSurvDT294	DateTime -- [DT294]
 Declare @dcIdSinDT294  Decimal (  10,0 )

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 Set @iNbSin = 0 

 If @sCodAdh <> '3' 
  Begin
  	 -- [DT294]
	If	Exists ( 
			Select Top 1 1 
			From   sysadm.det_pro dp
			Where  dp.id_prod = @dcIdProd
			And	   dp.id_code_dp = 275
			And	   sysadm.FN_CLE_VAL ( 'DT294', rtrim ( val_car ) + rtrim ( val_car2), ';' ) = 'OUI'
		)
		Begin
			Select	@dtSurvDT294 = max ( s.dte_surv) 
			From	sysadm.sinistre s
			Where   s.id_prod = @dcIdProd
			And		s.id_ets  = @dcIdEts
			And		s.id_adh  = @sIdAdh
			And		s.dte_surv between '01/01/2016' and '31/05/2016'

			If @dtSurvDT294 is not null 
				Begin
					Select	Top 1 @dcIdSinDT294 = s.id_sin
					From	sysadm.sinistre s
					Where   s.id_prod = @dcIdProd
					And    s.id_ets  = @dcIdEts
					And	s.id_adh  = @sIdAdh
					And	s.dte_surv = @dtSurvDT294

					SELECT @iNbSin  = count ( * )
					FROM   sysadm.sinistre s
					WHERE  s.id_sin        <> @dcIdSinDT294                         AND
						s.id_prod        = @dcIdProd                             AND
						s.id_ets         = @dcIdEts                              AND
						s.id_adh         = @sIdAdh                               AND
						s.dte_surv      <= @dtSurvDT294                          AND
						s.dte_surv      >= DateAdd ( day, -365, @dtSurvDT294 )   AND
						( sysadm.FN_LIB_ETAT_DOS_ASSURE ( s.id_sin, 'CODE') in ( '1500', '1510', '1520' )
						Or  Exists (  Select *
    								From   sysadm.det_pro
    								Where  det_pro.id_prod = s.id_prod 
								And    det_pro.id_code_dp = 182
								And    det_pro.id_code_car = '748'
								And    s.cod_etat = 100 )
						)  

				If @iNbSin > 0 Set @iNbSin = @iNbSin + 1
				If @iNbSin < 3 Set @iNbSin = 0

				End 
		End 

	  -- /[DT294]
	 If @iNbSin = 0 
	  Begin

		 SELECT @iNbSin  = count ( * )
		 FROM   sysadm.sinistre s
		 WHERE  s.id_sin        <> @dcIdSin                              AND
				s.id_prod        = @dcIdProd                             AND
				s.id_ets         = @dcIdEts                              AND
				s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
				s.dte_surv      <= @dtSurv                               AND
				s.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
				( sysadm.FN_LIB_ETAT_DOS_ASSURE ( s.id_sin, 'CODE') in ( '1500', '1510', '1520' )
				Or  Exists (  Select *
    					  From   sysadm.det_pro
    					  Where  det_pro.id_prod = s.id_prod 
					  And    det_pro.id_code_dp = 182
					  And    det_pro.id_code_car = '748'
					  And    s.cod_etat = 100 )
				)        
	  End
  End

 If @sCodAdh = '3' 
  Begin
  	 -- [DT294]
	If	Exists ( 
			Select Top 1 1 
			From   sysadm.det_pro dp
			Where  dp.id_prod = @dcIdProd
			And	   dp.id_code_dp = 275
			And	   sysadm.FN_CLE_VAL ( 'DT294', rtrim ( val_car ) + rtrim ( val_car2), ';' ) = 'OUI'
		)
		Begin
			Select	@dtSurvDT294 = max ( s.dte_surv) 
			From	sysadm.sinistre s
			Where   s.id_prod = @dcIdProd
			And		s.id_ets  = @dcIdEts
			And		s.id_adh  = @sIdAdh
			And		s.dte_surv between '01/01/2016' and '31/05/2016'

			If @dtSurvDT294 is not null 
				Begin
					Select	Top 1 @dcIdSinDT294 = s.id_sin
					From	sysadm.sinistre s
					Where   s.id_prod = @dcIdProd
					And    s.id_ets  = @dcIdEts
					And	s.id_adh  = @sIdAdh
					And	s.dte_surv = @dtSurvDT294

					SELECT @iNbSin  = count ( * )
					FROM   sysadm.sinistre s
					WHERE  s.id_sin        <> @dcIdSinDT294                         AND
						s.id_prod        = @dcIdProd                             AND
						s.id_ets         = @dcIdEts                              AND
						s.id_adh         = @sIdAdh                               AND
						s.dte_surv      <= @dtSurvDT294                          AND
						s.dte_surv      >= DateAdd ( day, -365, @dtSurvDT294 )   AND
						( sysadm.FN_LIB_ETAT_DOS_ASSURE ( s.id_sin, 'CODE') in ( '1500', '1510', '1520' )
						Or  Exists (  Select *
    								From   sysadm.det_pro
    								Where  det_pro.id_prod = s.id_prod 
								And    det_pro.id_code_dp = 182
								And    det_pro.id_code_car = '748'
								And    s.cod_etat = 100 )
						)  

				If @iNbSin > 0 Set @iNbSin = @iNbSin + 1					
				If @iNbSin < 3 Set @iNbSin = 0

				End 
		End 
	  -- /[DT294]

	 If @iNbSin = 0 
	  Begin

		 SELECT @iNbSin  = count ( * )
		 FROM   sysadm.sinistre s,
				sysadm.personne p
		 WHERE  s.id_sin        <> @dcIdSin                              AND
				s.id_prod        = @dcIdProd                             AND
				s.id_ets         = @dcIdEts                              AND
				s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
				s.dte_surv      <= @dtSurv                               AND
				s.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
				( sysadm.FN_LIB_ETAT_DOS_ASSURE ( s.id_sin, 'CODE') in ( '1500', '1510', '1520' )
				Or  Exists (  Select *
    					  From   sysadm.det_pro
    					  Where  det_pro.id_prod = s.id_prod 
					  And    det_pro.id_code_dp = 182
					  And    det_pro.id_code_car = '748'
					  And    s.cod_etat = 100 )
				)														AND
				p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
				p.nom					= @sNom									AND -- [ITSM361927]
				p.prenom				= @sPrenom -- [ITSM361927]				
	  End 
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_W_GTI_NBSIN_RESIL_ADH_DATA
-- Auteur               :       Fabry JF
-- Date                 :       27/06/2016
-- Libellé              :       [DT247]
-- Commentaires         :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- JFF  25/07/2011 [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      03/04/2017   [DT294]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_W_GTI_NBSIN_RESIL_ADH_DATA' AND type = 'P' )
        DROP procedure sysadm.PS_S_W_GTI_NBSIN_RESIL_ADH_DATA
GO

CREATE procedure sysadm.PS_S_W_GTI_NBSIN_RESIL_ADH_DATA
        @dcIdSin        Decimal (  10,0 ),
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @asChaine		Varchar ( 100 )  OUTPUT
AS

-- Plafond 748
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
 Declare @dtSurvMax DateTime 
 Declare @dtDeclMax DateTime 
 Declare @dtSurvDT294	DateTime -- [DT294]
 Declare @dcIdSinDT294  Decimal (  10,0 ) -- [DT294]
 Declare @iNbSin integer -- [DT294]

 DECLARE @tb TABLE 
	( id_sin	decimal (10 ),
	  dte_surv  datetime,
	  dte_decl  datetime
	)

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin

	 -- [DT294]
	If	Exists ( 
			Select Top 1 1 
			From   sysadm.det_pro dp
			Where  dp.id_prod = @dcIdProd
			And	   dp.id_code_dp = 275
			And	   sysadm.FN_CLE_VAL ( 'DT294', rtrim ( val_car ) + rtrim ( val_car2), ';' ) = 'OUI'
		)
		Begin
			Select	@dtSurvDT294 = max ( s.dte_surv) 
			From	sysadm.sinistre s
			Where   s.id_prod = @dcIdProd
			And		s.id_ets  = @dcIdEts
			And		s.id_adh  = @sIdAdh
			And		s.dte_surv between '01/01/2016' and '31/05/2016 23:59'

			If @dtSurvDT294 is not null 
				Begin
					Select	Top 1 @dcIdSinDT294 = s.id_sin
					From	sysadm.sinistre s
					Where   s.id_prod = @dcIdProd
					And    s.id_ets  = @dcIdEts
					And	s.id_adh  = @sIdAdh
					And	s.dte_surv = @dtSurvDT294

					SELECT @iNbSin  = count ( * )
					FROM   sysadm.sinistre s
					WHERE  s.id_sin        <> @dcIdSinDT294                         AND
						s.id_prod        = @dcIdProd                             AND
						s.id_ets         = @dcIdEts                              AND
						s.id_adh         = @sIdAdh                               AND
						s.dte_surv      <= @dtSurvDT294                          AND
						s.dte_surv      >= DateAdd ( day, -365, @dtSurvDT294 )   AND
						( sysadm.FN_LIB_ETAT_DOS_ASSURE ( s.id_sin, 'CODE') in ( '1500', '1510', '1520' )
						Or  Exists (  Select *
    								From   sysadm.det_pro
    								Where  det_pro.id_prod = s.id_prod 
								And    det_pro.id_code_dp = 182
								And    det_pro.id_code_car = '748'
								And    s.cod_etat = 100 )
						)  

				If @iNbSin > 0 Set @iNbSin = @iNbSin + 1					
				If @iNbSin < 3 Set @iNbSin = 0
					
			 	If @iNbSin >= 3 
					Begin
						Insert into @tb
						SELECT s.id_sin,
							s.dte_surv,
							s.dte_decl
						FROM   sysadm.sinistre s
						WHERE  s.id_prod        = @dcIdProd                             AND
							s.id_ets         = @dcIdEts                              AND
							s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
							s.dte_surv      <= @dtSurvDT294                               AND
							s.dte_surv      >= DateAdd ( day, -365, @dtSurvDT294 )        AND
							( sysadm.FN_LIB_ETAT_DOS_ASSURE ( s.id_sin, 'CODE') in ( '1500', '1510', '1520' )
							Or  Exists (  Select *
    									From   sysadm.det_pro
    									Where  det_pro.id_prod = s.id_prod 
									And    det_pro.id_code_dp = 182
									And    det_pro.id_code_car = '748'
									And    s.cod_etat = 100 )
							)   
					End

				End 
		End 
	  -- /[DT294]

	 If @iNbSin = 0 
	  Begin
		 Insert into @tb
		 SELECT s.id_sin,
				s.dte_surv,
				s.dte_decl
		 FROM   sysadm.sinistre s
		 WHERE  s.id_sin        <> @dcIdSin                              AND
				s.id_prod        = @dcIdProd                             AND
				s.id_ets         = @dcIdEts                              AND
				s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
				s.dte_surv      <= @dtSurv                               AND
				s.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
				( sysadm.FN_LIB_ETAT_DOS_ASSURE ( s.id_sin, 'CODE') in ( '1500', '1510', '1520' )
				Or  Exists (  Select *
    					  From   sysadm.det_pro
    					  Where  det_pro.id_prod = s.id_prod 
					  And    det_pro.id_code_dp = 182
					  And    det_pro.id_code_car = '748'
					  And    s.cod_etat = 100 )
				)   
	  End
  End

 If @sCodAdh = '3' 
  Begin
  	 -- [DT294]
	If	Exists ( 
			Select Top 1 1 
			From   sysadm.det_pro dp
			Where  dp.id_prod = @dcIdProd
			And	   dp.id_code_dp = 275
			And	   sysadm.FN_CLE_VAL ( 'DT294', rtrim ( val_car ) + rtrim ( val_car2), ';' ) = 'OUI'
		)
		Begin
			Select	@dtSurvDT294 = max ( s.dte_surv) 
			From	sysadm.sinistre s
			Where   s.id_prod = @dcIdProd
			And		s.id_ets  = @dcIdEts
			And		s.id_adh  = @sIdAdh
			And		s.dte_surv between '01/01/2016' and '31/05/2016'

			If @dtSurvDT294 is not null 
				Begin
					Select	Top 1 @dcIdSinDT294 = s.id_sin
					From	sysadm.sinistre s
					Where   s.id_prod = @dcIdProd
					And    s.id_ets  = @dcIdEts
					And	s.id_adh  = @sIdAdh
					And	s.dte_surv = @dtSurvDT294

					SELECT @iNbSin  = count ( * )
					FROM   sysadm.sinistre s
					WHERE  s.id_sin        <> @dcIdSinDT294                         AND
						s.id_prod        = @dcIdProd                             AND
						s.id_ets         = @dcIdEts                              AND
						s.id_adh         = @sIdAdh                               AND
						s.dte_surv      <= @dtSurvDT294                          AND
						s.dte_surv      >= DateAdd ( day, -365, @dtSurvDT294 )   AND
						( sysadm.FN_LIB_ETAT_DOS_ASSURE ( s.id_sin, 'CODE') in ( '1500', '1510', '1520' )
						Or  Exists (  Select *
    								From   sysadm.det_pro
    								Where  det_pro.id_prod = s.id_prod 
								And    det_pro.id_code_dp = 182
								And    det_pro.id_code_car = '748'
								And    s.cod_etat = 100 )
						)  

				If @iNbSin > 0 Set @iNbSin = @iNbSin + 1					
				If @iNbSin < 3 Set @iNbSin = 0
					
			 	If @iNbSin >= 3 
					Begin
						Insert into @tb
						SELECT s.id_sin,
							s.dte_surv,
							s.dte_decl
						FROM   sysadm.sinistre s
						WHERE  s.id_prod        = @dcIdProd                             AND
							s.id_ets         = @dcIdEts                              AND
							s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
							s.dte_surv      <= @dtSurvDT294                               AND
							s.dte_surv      >= DateAdd ( day, -365, @dtSurvDT294 )        AND
							( sysadm.FN_LIB_ETAT_DOS_ASSURE ( s.id_sin, 'CODE') in ( '1500', '1510', '1520' )
							Or  Exists (  Select *
    									From   sysadm.det_pro
    									Where  det_pro.id_prod = s.id_prod 
									And    det_pro.id_code_dp = 182
									And    det_pro.id_code_car = '748'
									And    s.cod_etat = 100 )
							)   
					End

				End 
		End 
	  -- /[DT294]

	 If @iNbSin = 0 
	  Begin
		 Insert into @tb
		 SELECT s.id_sin,
				s.dte_surv,
				s.dte_decl
		 FROM   sysadm.sinistre s,
				sysadm.personne p
		 WHERE  s.id_sin        <> @dcIdSin                              AND
				s.id_prod        = @dcIdProd                             AND
				s.id_ets         = @dcIdEts                              AND
				s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
				s.dte_surv      <= @dtSurv                               AND
				s.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
				( sysadm.FN_LIB_ETAT_DOS_ASSURE ( s.id_sin, 'CODE') in ( '1500', '1510', '1520' )
				Or  Exists (  Select *
    					  From   sysadm.det_pro
    					  Where  det_pro.id_prod = s.id_prod 
					  And    det_pro.id_code_dp = 182
					  And    det_pro.id_code_car = '748'
					  And    s.cod_etat = 100 )
				)														AND
				p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
				p.nom					= @sNom									AND -- [ITSM361927]
				p.prenom				= @sPrenom -- [ITSM361927]
	  End				
 End

 If Exists ( Select Top 1 1 From @tb )
  Begin
	Select @dtSurvMax = Max ( dte_surv ) 
	From   @tb

	If @dtSurvMax is not null
	  Begin
		Select Top 1 @dtDeclMax = dte_decl
		From   @tb
		Where  dte_surv = @dtSurvMax
	  End 

	If @dtSurvMax is not null
	  Begin
		Select @asChaine = sysadm.FN_CLE_VAL_E ( 'DTE_SURV', Convert ( Varchar ( 10), @dtSurvMax, 103 ), @asChaine, ';' )
	  End 

	If @dtDeclMax is not null
	  Begin
		Select @asChaine = sysadm.FN_CLE_VAL_E ( 'DTE_DECL', Convert ( Varchar ( 10), @dtDeclMax, 103 ), @asChaine, ';' )
	  End 
  End 

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_753_W_GTI_MT_PLAF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       [VDOC24781]
-- Commentaires         :       Calcul des plafonds par adh‚sion (Survenance)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
--
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_753_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S_753_W_GTI_MT_PLAF
GO

CREATE procedure sysadm.PS_S_753_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS

-- 753

 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin        			= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			DatePart (year, sinistre.dte_surv )	=	DatePart ( year, @dtSurv )	AND
			(
			gar_sin.cod_etat        		= 550                                   OR
			gar_sin.cod_etat        		= 600
			)	  
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p
				
	 WHERE  sinistre.id_sin        			= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			DatePart (year, sinistre.dte_surv )	=	DatePart ( year, @dtSurv )	AND
			(
			gar_sin.cod_etat        		= 550                                   OR
			gar_sin.cod_etat        		= 600
			)	  																	AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S755_W_GTI_NBSIN_DTE_SURV
-- Auteur               :       Fabry JF
-- Date                 :       08/09/2015
-- Libellé              :       [DT162]
-- Commentaires         :       Calcul du nombre de sinistre par adhesion (par année de surv)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- JFF  25/07/2011 [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF      28/10/2015   [MANTIS17828]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-- JFF		06/01/2017   [VDOC22794]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S755_W_GTI_NBSIN_DTE_SURV' AND type = 'P' )
        DROP procedure sysadm.PS_S755_W_GTI_NBSIN_DTE_SURV
GO

CREATE procedure sysadm.PS_S755_W_GTI_NBSIN_DTE_SURV
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @iNbSin		Integer	 OUTPUT
	
AS
 -- Plafond 755
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
 
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 From (
		 SELECT distinct s.dte_surv
		 FROM   sysadm.sinistre s,
				sysadm.det_pro dp  -- [DT162]
		 WHERE  s.id_sin        <> @dcIdSin                              AND
--[MANTIS17828] s.id_prod        = @dcIdProd                             AND
				s.id_ets         = @dcIdEts                              AND
				s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
				s.dte_surv		<> @dtSurv								 AND  -- [VDOC22794]
				s.dte_surv      <= @dtSurv                               AND
				s.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
				( s.cod_etat      in ( 550, 600 )
				Or  Exists (  Select *
    					  From   sysadm.det_pro
    					  Where  det_pro.id_prod = s.id_prod 
					  And    det_pro.id_code_dp = 182
					  And    det_pro.id_code_car = '755'
					  And    s.cod_etat = 100 
					  )
				)														  AND
				dp.id_prod				= @dcIdProd								AND
				dp.id_code_dp			= 289									AND
				dp.id_typ_calc			= '-PL'									AND
				dp.id_code_num			= 755									AND
				CHARINDEX (	'#' + CONVERT ( varchar ( 10), s.id_prod ) + '#', dp.val_car ) > 0  -- [DT162]				
			) As Tb

	If @iNbSin is null Set @iNbSin = 0
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 From (
		 SELECT distinct s.dte_surv
		 FROM   sysadm.sinistre s,
				sysadm.personne p,
				sysadm.det_pro dp -- [DT162]
		 WHERE  s.id_sin        <> @dcIdSin                              AND
--[MANTIS17828] s.id_prod        = @dcIdProd                             AND
				s.id_ets         = @dcIdEts                              AND
				s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
				s.dte_surv		<> @dtSurv								 AND  -- [VDOC22794]
				s.dte_surv      <= @dtSurv                               AND
				s.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
				( s.cod_etat      in ( 550, 600 )
				Or  Exists (  Select *
    					  From   sysadm.det_pro
    					  Where  det_pro.id_prod = s.id_prod 
					  And    det_pro.id_code_dp = 182
					  And    det_pro.id_code_car = '755'
					  And    s.cod_etat = 100 
					  )
				)														AND
				p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
				p.nom					= @sNom									AND -- [ITSM361927]
				p.prenom				= @sPrenom						AND -- [ITSM361927]				
				dp.id_prod				= s.id_prod						AND
				dp.id_code_dp			= 289							AND
				dp.id_typ_calc			= '-PL'							AND
				dp.id_code_num			= 755							AND
				CHARINDEX (	'#' + CONVERT ( varchar ( 10), s.id_prod ) + '#', dp.val_car ) > 0  -- [DT162]	
			) As Tb

	If @iNbSin is null Set @iNbSin = 0

  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_W_GTI_NBSIN_REGL_REPAR_REMPL
-- Auteur               :       Fabry JF
-- Date                 :       06/03/2018
-- Libellé              :       [DT341]
-- Commentaires         :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien

-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_W_GTI_NBSIN_REGL_REPAR_REMPL' AND type = 'P' )
        DROP procedure sysadm.PS_S_W_GTI_NBSIN_REGL_REPAR_REMPL
GO

CREATE procedure sysadm.PS_S_W_GTI_NBSIN_REGL_REPAR_REMPL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @iNbSin		Integer	 OUTPUT
AS

-- Ce n'est as un plafond, juste pour un messagebox.
 
Set @iNbSin = 0 

SELECT @iNbSin  = count ( * )
FROM   sysadm.sinistre s
WHERE  s.id_sin        <> @dcIdSin                         AND
	s.id_prod        = @dcIdProd                             AND
	s.id_ets         = @dcIdEts                              AND
	s.id_adh         = @sIdAdh                               AND
	s.dte_surv      <= @dtSurv								AND
	s.dte_surv      >= DateAdd ( day, -365, @dtSurv )		 AND
	( sysadm.FN_LIB_ETAT_DOS_ASSURE ( s.id_sin, 'CODE') in ( '1500', '1510', '1520' )
	Or  Exists (  Select *
    			From   sysadm.det_pro
    			Where  det_pro.id_prod = s.id_prod 
			And    det_pro.id_code_dp = 182
			And    det_pro.id_code_car = '748'
			And    s.cod_etat = 100 )
	)  
 
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_W_GTI_MT_PLAF_756
-- Auteur               :       FABRY JF
-- Date                 :       17/10/2018
-- Libellé              :       
-- Commentaires         :       Calcul des plafonds par adh‚sion (Renouvellement)
-- Références           :       W_TM_SP_W_GTI [PC171999]
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_W_GTI_MT_PLAF_756' AND type = 'P' )
        DROP procedure sysadm.PS_S_W_GTI_MT_PLAF_756
GO

CREATE procedure sysadm.PS_S_W_GTI_MT_PLAF_756
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
		@sTypPers		Varchar ( 10 ),
        @dcIdGti        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS
-- 756
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.div_sin
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			gar_sin.id_gti          = @dcIdGti                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			div_sin.id_sin			= sinistre.id_sin						AND
			div_sin.nom_zone		= 'personne_sin'						AND
			div_sin.val_car			= @sTypPers
  End
  
 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p,
			sysadm.div_sin
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			gar_sin.id_gti          = @dcIdGti                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom 								AND	-- [ITSM361927]
			div_sin.id_sin			= sinistre.id_sin						AND
			div_sin.nom_zone		= 'personne_sin'						AND
			div_sin.val_car			= @sTypPers


  End
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S757_W_GTI_MT_PLAF
-- Auteur               :       Fabry JF
-- Date                 :       04/07/2019
-- Libellé              :       [PC192235]
-- Commentaires         :       Calcul des plafonds par adh‚sion (Renouvellement)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
--
-- JFF      20/01/2014   [PM208]
-- JFF      28/10/2015   [MANTIS17828]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S757_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S757_W_GTI_MT_PLAF
GO


CREATE procedure sysadm.PS_S757_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
        @dcIdGti		Decimal ( 7 ),
		@dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS
-- Plafond 757
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
  
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.det_pro dp -- [DT162]
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			gar_sin.id_gti			= @dcIdGti								AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			dp.id_prod				= @dcIdProd								AND
			dp.id_code_dp			= 289									AND
			dp.id_typ_calc			= '-PL'									AND
			dp.id_code_num			= 757									AND
			CHARINDEX (	'#' + CONVERT ( varchar ( 10), sinistre.id_prod ) + '#', dp.val_car ) > 0  -- [DT162]
	
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p,
			sysadm.det_pro dp -- [DT162]
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
-- [MANTIS17828] sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			gar_sin.id_gti			= @dcIdGti								AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom								AND -- [ITSM361927]				
			dp.id_prod				= @dcIdProd								AND
			dp.id_code_dp			= 289									AND
			dp.id_typ_calc			= '-PL'									AND
			dp.id_code_num			= 757									AND
			CHARINDEX (	'#' + CONVERT ( varchar ( 10), sinistre.id_prod ) + '#', dp.val_car ) > 0  -- [DT162]
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S758_W_GTI_NBGTI_DTE_SURV
-- Auteur               :       Fabry JF
-- Date                 :       04/07/2019
-- Libellé              :       [PC192235]
-- Commentaires         :       Calcul des plafonds par adh‚sion (Renouvellement)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- JFF  25/07/2011 [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF      28/10/2015   [MANTIS17828]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-- JFF		06/01/2017   [VDOC22794]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S758_W_GTI_NBGTI_DTE_SURV' AND type = 'P' )
        DROP procedure sysadm.PS_S758_W_GTI_NBGTI_DTE_SURV
GO

CREATE procedure sysadm.PS_S758_W_GTI_NBGTI_DTE_SURV
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
        @dcIdGti		Decimal ( 7 ),
		@iNbSin		Integer	 OUTPUT
	
AS
 -- Plafond 758
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
 
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 From (
		 SELECT distinct s.dte_surv
		 FROM   sysadm.sinistre s,
				sysadm.gar_sin g,
				sysadm.det_pro dp  -- [DT162]
		 WHERE  g.id_sin        =  s.id_sin								 AND
				s.id_sin        <> @dcIdSin                              AND
--[MANTIS17828] s.id_prod        = @dcIdProd                             AND
				s.id_ets         = @dcIdEts                              AND
				s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
				g.id_gti 	     = @dcIdGti								AND
				s.dte_surv		<> @dtSurv								 AND  -- [VDOC22794]
				s.dte_surv      <= @dtSurv                               AND
				s.dte_surv      >= @dtAdhRenouv                          AND
				( s.cod_etat      in ( 550, 600 )
				Or  Exists (  Select *
    					  From   sysadm.det_pro
    					  Where  det_pro.id_prod = s.id_prod 
					  And    det_pro.id_code_dp = 182
					  And    det_pro.id_code_car = '758'
					  And    s.cod_etat = 100 
					  )
				)														  AND
				dp.id_prod				= @dcIdProd								AND
				dp.id_code_dp			= 289									AND
				dp.id_typ_calc			= '-PL'									AND
				dp.id_code_num			= 758									AND
				CHARINDEX (	'#' + CONVERT ( varchar ( 10), s.id_prod ) + '#', dp.val_car ) > 0  -- [DT162]				
			) As Tb

	If @iNbSin is null Set @iNbSin = 0
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 From (
		 SELECT distinct s.dte_surv
		 FROM   sysadm.sinistre s,
				sysadm.personne p,
				sysadm.gar_sin g,
				sysadm.det_pro dp -- [DT162]
		 WHERE  s.id_sin        <> @dcIdSin                              AND
--[MANTIS17828] s.id_prod        = @dcIdProd                             AND
				s.id_ets         = @dcIdEts                              AND
				s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
				g.id_gti 	     = @dcIdGti								 AND
				s.dte_surv		<> @dtSurv								 AND  -- [VDOC22794]
				s.dte_surv      <= @dtSurv                               AND
				s.dte_surv      >= @dtAdhRenouv                          AND
		        
				( s.cod_etat      in ( 550, 600 )
				Or  Exists (  Select *
    					  From   sysadm.det_pro
    					  Where  det_pro.id_prod = s.id_prod 
					  And    det_pro.id_code_dp = 182
					  And    det_pro.id_code_car = '758'
					  And    s.cod_etat = 100 
					  )
				)														AND
				p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
				p.nom					= @sNom									AND -- [ITSM361927]
				p.prenom				= @sPrenom						AND -- [ITSM361927]				
				dp.id_prod				= s.id_prod						AND
				dp.id_code_dp			= 289							AND
				dp.id_typ_calc			= '-PL'							AND
				dp.id_code_num			= 758							AND
				CHARINDEX (	'#' + CONVERT ( varchar ( 10), s.id_prod ) + '#', dp.val_car ) > 0  -- [DT162]	
			) As Tb

	If @iNbSin is null Set @iNbSin = 0

  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S759_W_GTI_MT_PLAF
-- Auteur               :       Fabry JF
-- Date                 :       08/09/2020
-- Libellé              :       [PC202551]
-- Commentaires         :       Calcul des plafonds par adh‚sion (Survenance)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S759_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S759_W_GTI_MT_PLAF
GO


CREATE procedure sysadm.PS_S759_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS
-- 759

 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
  
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.det_pro dp
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			dp.id_prod              = sinistre.id_prod						AND
			dp.id_code_dp           = 351									AND
			CharIndex ( '#' + Convert ( varchar ( 10 ), gar_sin.id_gti) + '#', sysadm.FN_CLE_VAL ( 'ID_GTI', rtrim ( val_car ) + rtrim ( val_car2 ), ';' )) > 0
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p,
			sysadm.det_pro dp
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom								AND -- [ITSM361927]
			dp.id_prod              = sinistre.id_prod						AND
			dp.id_code_dp           = 351									AND
			CharIndex ( '#' + Convert ( varchar ( 10 ), gar_sin.id_gti) + '#', sysadm.FN_CLE_VAL ( 'ID_GTI', rtrim ( val_car ) + rtrim ( val_car2 ), ';' )) > 0
        
  End
GO



--------------------------------------------------------------------
--
-- Procédure            :       PS_S11_W_GTI_NBSINRGL_ADHESION_RNV_SPLREF611
-- Auteur               :       Fabry JF
-- Date                 :       01/10/2020
-- Libellé              :       [DT509]
-- Commentaires         :       Calcul du nombre de sinistre par adhesion (Renouvellement) ayant été réglé sur une nature de souplesse
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S11_W_GTI_NBSINRGL_ADHESION_RNV_SPLREF611' AND type = 'P' )
        DROP procedure sysadm.PS_S11_W_GTI_NBSINRGL_ADHESION_RNV_SPLREF611
GO

CREATE procedure sysadm.PS_S11_W_GTI_NBSINRGL_ADHESION_RNV_SPLREF611
        @dcIdSin        Decimal (  10,0 ),-- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),        
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
		@dcIdNatSin     Decimal ( 7 ),
	    @iNbSin		Integer	 OUTPUT
	
AS
 -- Plafond 760
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
  
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.gar_sin g
	 WHERE  s.id_sin         = g.id_sin				 AND
		s.id_sin        <> @dcIdSin                              AND
			s.id_prod        = @dcIdProd                             AND
			s.id_ets         = @dcIdEts                              AND
			s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			s.dte_surv      <= @dtSurv                               AND
			s.dte_surv      >= @dtAdhRenouv                          AND
			s.id_natsin      = @dcIdNatSin                           AND
			s.id_natsin      in ( 133, 134, 135, 136 )               AND  -- Les 4 natures de sinistre en souplesse pour l'instant
			( s.cod_etat      in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '760'
				  And    s.cod_etat = 100 )
			) AND               
			g.id_gti = @dcIdGti   
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre s,
			sysadm.gar_sin g,
			sysadm.personne p
	 WHERE  s.id_sin         = g.id_sin				 AND
		s.id_sin        <> @dcIdSin                              AND
			s.id_prod        = @dcIdProd                             AND
			s.id_ets         = @dcIdEts                              AND
			s.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			s.dte_surv      <= @dtSurv                               AND
			s.dte_surv      >= @dtAdhRenouv                          AND
			s.id_natsin      = @dcIdNatSin                           AND
			s.id_natsin      in ( 133, 134, 135, 136 )               AND  -- Les 4 natures de sinistre en souplesse pour l'instant
			( s.cod_etat      in ( 550, 600 )
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = s.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '760'
				  And    s.cod_etat = 100 )
			) AND               
			g.id_gti = @dcIdGti   									AND
			p.id_ordre				= s.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_W_GTI_NBIN_GTI_ANCIVILE_ADHESION
-- Auteur               :       FBARY JF	
-- Date                 :       02/07/20 
-- Libellé              :       [VDOC29286]
-- Commentaires         :       Calcul des plafonds par adh‚sion (Survenance)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
--
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_W_GTI_NBIN_GTI_ANCIVILE_ADHESION' AND type = 'P' )
        DROP procedure sysadm.PS_S_W_GTI_NBIN_GTI_ANCIVILE_ADHESION
GO

CREATE procedure sysadm.PS_S_W_GTI_NBIN_GTI_ANCIVILE_ADHESION
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
		@iNbSin			Integer	 OUTPUT
AS

-- 761

 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin
	 WHERE  sinistre.id_sin        			= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			gar_sin.id_gti          		= @dcIdGti                              AND
			DatePart (year, sinistre.dte_surv )	=	DatePart ( year, @dtSurv )	AND
			(
			gar_sin.cod_etat        		= 550                                   OR
			gar_sin.cod_etat        		= 600
			)	  
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p
				
	 WHERE  sinistre.id_sin        			= gar_sin.id_sin                        AND
			sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			gar_sin.id_gti          		= @dcIdGti                              AND
			DatePart (year, sinistre.dte_surv )	=	DatePart ( year, @dtSurv )	AND
			(
			gar_sin.cod_etat        		= 550                                   OR
			gar_sin.cod_etat        		= 600
			)	  																	AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S762_W_GTI_MT_PLAF
-- Auteur               :       Fabry JF
-- Date                 :       23/11/12
-- Libellé              :       [PC877]
-- Commentaires         :       Calcul des plafonds par adh‚sion (Survenance)
-- Références           :       W_TM_SP_W_GTI
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S762_W_GTI_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S762_W_GTI_MT_PLAF
GO


CREATE procedure sysadm.PS_S762_W_GTI_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dtSurv         DateTime        ,
        @dcMtPlafReg    VarChar ( 12 ) OUTPUT
AS
-- 762

 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
  
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.det_pro dp -- [DT162]
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			dp.id_prod				= @dcIdProd								AND
			dp.id_code_dp			= 289									AND
			dp.id_typ_calc			= '-PL'									AND
			dp.id_code_num			= 762									AND
			CHARINDEX (	'#' + CONVERT ( varchar ( 10), sinistre.id_prod ) + '#', dp.val_car ) > 0  -- [DT162]

  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlafReg  = Convert ( VarChar ( 12 ), isNull ( Sum ( gar_sin.mt_plaf_reg ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.gar_sin,
			sysadm.personne p,
			sysadm.det_pro dp -- [DT162]
	 WHERE  sinistre.id_sin         = gar_sin.id_sin                        AND
			sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			(
			gar_sin.cod_etat        = 550                                   OR
			gar_sin.cod_etat        = 600
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom								AND -- [ITSM361927]				
			dp.id_prod				= @dcIdProd								AND
			dp.id_code_dp			= 289									AND
			dp.id_typ_calc			= '-PL'									AND
			dp.id_code_num			= 762									AND
			CHARINDEX (	'#' + CONVERT ( varchar ( 10), sinistre.id_prod ) + '#', dp.val_car ) > 0  -- [DT162]
        
  End
GO

