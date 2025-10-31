-------------------------------------------------------------------
--
-- Fichier              :       W_DETAIL.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion des d‚tails dans SIMPA2
--
-- Procédures           :       DW_S01_W_DETAIL_LSTDET
--                              DW_I01_W_DETAIL
--                              DW_D01_W_DETAIL
--                              PS_S01_W_DETAIL_A_REGLER
--                              PS_S01_W_DETAIL_MT_PLAF
--                              PS_S02_W_DETAIL_MT_PLAF
--                              PS_S03_W_DETAIL_MT_PLAF
--                              PS_S04_W_DETAIL_MT_PLAF
--                              PS_S05_W_DETAIL_MT_PLAF
--                              PS_S06_W_DETAIL_MT_PLAF
--				PS_S07_W_DETAIL_NBEVT
--				PS_S08_W_DETAIL_NBEVT
--				PS_S09_W_DETAIL_NBEVT
--				PS_S10_W_DETAIL_NBEVT
--                              PS_I01_W_DETAIL_WKF
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_DETAIL_LSTDET
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       S‚lect sur la table W_DETAIL
-- Références           :       Utilis‚ dans W_TM_SP_SINISTRE (Liste d‚tail)
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-- MAJ			: 31/10/2003	JFF	Ajout colonne mt_val_achat
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_DETAIL_LSTDET' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_DETAIL_LSTDET
GO

CREATE procedure sysadm.DW_S01_W_DETAIL_LSTDET
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS
 SELECT w_detail.id_sin,
        w_detail.id_gti,
        w_detail.id_detail,
        w_detail.id_evt,
        w_detail.lib_det,
        w_detail.dte_det,
        w_detail.heu_det,
        w_detail.num_carte,
        w_detail.mt_prej,
        w_detail.mt_fran,
        w_detail.mt_nplaf,
        w_detail.mt_plaf,
        w_detail.id_i_reg,
        w_detail.alt_bloc,
        w_detail.alt_cour,
        w_detail.alt_plaf,
        w_detail.alt_reg,
        w_detail.alt_att,
        w_detail.alt_valide,
        w_detail.cpt_valide,
        w_detail.alt_ssui,
        w_detail.cod_mot_ssui,
        w_detail.cod_dec_mac,
        w_detail.cod_dec_ope,
        w_detail.cod_etat,
        w_detail.id_carte,
        w_detail.id_type_carte,
        w_detail.cree_le,
        w_detail.maj_le,
        w_detail.maj_par,
        'N',
        'N',
        'N',
        Convert ( DateTime, '1900-01-01 0:00' ),
        w_detail.dte_cmd,
        w_detail.dte_livr,
        w_detail.mt_val_achat,
        w_detail.mt_val_publique,
        w_detail.num_facture
        
 FROM   sysadm.w_detail
 WHERE  w_detail.id_sin = @dcIdSin

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_W_DETAIL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion sur table W_DETAIL
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdsin        Decimal (  7,0 )        (Val)
--                      :       @dcIdGti        Decimal (  7,0 )        (Val)
--                      :       @dcIdDetail     Decimal (  7,0 )        (Val)
--                      :       @dcIdEvt        Decimal (  7,0 )        (Val)
--                      :       @sLibDet        Varchar ( 65 )          (Val)
--                      :       @dDteDet        DateTime                (Val)
--                      :       @sHeuDet        Varchar (  4 )          (Val)
--                      :       @sNumCarte      Varchar ( 19 )          (Val)
--                      :       @dcMtPrej       Decimal ( 11,2 )        (Val)
--                      :       @dcMtFran       Decimal ( 11,2 )        (Val)
--                      :       @dcMtnPlaf      Decimal ( 11,2 )        (Val)
--                      :       @dcMtPlaf       Decimal ( 11,2 )        (Val)
--                      :       @dcIdiReg       Decimal (  7,0 )        (Val)
--                      :       @sAltBloc       Varchar (  1 )          (Val)
--                      :       @sAltCour       Varchar (  1 )          (Val)
--                      :       @sAltPlaf       Varchar (  1 )          (Val)
--                      :       @sAltReg        Varchar (  1 )          (Val)
--                      :       @sAltAtt        Varchar (  1 )          (Val)
--                      :       @sAltValide     Varchar (  1 )          (Val)
--                      :       @dcCptValide    Decimal (  2,0 )        (Val)
--                      :       @sAltSsui       Varchar (  1 )          (Val)
--                      :       @dcCodMotSsui   Decimal (  2,0 )        (Val)
--                      :       @dcCodDecMac    Decimal (  7,0 )        (Val)
--                      :       @dcCodDecOpe    Decimal (  7,0 )        (Val)
--                      :       @dcCodEtat      Decimal (  7,0 )        (Val)
--                      :       @dcIdCarte      Decimal (  7,0 )        (Val)
--                      :       @dcIdTypeCarte  Varchar (  3 )          (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @dtMajLe        DateTime                (Val)
--                      :       @sMajPar        Varchar (  4 )          (Val)
--			:	@dcMtValAchat	Decimal ( 11,2 )        (Val)
--        			@dcMtValPubl	Decimal ( 11,2 ),	(val)
--			        @sNumFacture	VarChar (35)		(val)
--
-- Retourne             :       Rien
-- MAJ			: 31/10/2003	JFF	Ajout colonne mt_val_achat
--       JFF   12/02/2016 [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_W_DETAIL' AND type = 'P' )
        DROP procedure sysadm.DW_I01_W_DETAIL
GO

CREATE procedure sysadm.DW_I01_W_DETAIL
        @dcIdsin        Decimal (  10,0 ), -- [PI062]
        @dcIdGti        Decimal (  7,0 ),
        @dcIdDetail     Decimal (  7,0 ),
        @dcIdEvt        Decimal (  7,0 ),
        @sLibDet        Varchar ( 65 )  ,
        @dDteDet        DateTime        ,
        @sHeuDet        Varchar (  4 )  ,
        @sNumCarte      Varchar ( 19 )  ,
        @dcMtPrej       Decimal ( 11,2 ),
        @dcMtFran       Decimal ( 11,2 ),
        @dcMtnPlaf      Decimal ( 11,2 ),
        @dcMtPlaf       Decimal ( 11,2 ),
        @dcIdiReg       Decimal (  7,0 ),
        @sAltBloc       Varchar (  1 )  ,
        @sAltCour       Varchar (  1 )  ,
        @sAltPlaf       Varchar (  1 )  ,
        @sAltReg        Varchar (  1 )  ,
        @sAltAtt        Varchar (  1 )  ,
        @sAltValide     Varchar (  1 )  ,
        @dcCptValide    Decimal (  2,0 ),
        @sAltSsui       Varchar (  1 )  ,
        @dcCodMotSsui   Decimal (  2,0 ),
        @dcCodDecMac    Decimal (  7,0 ),
        @dcCodDecOpe    Decimal (  7,0 ),
        @dcCodEtat      Decimal (  7,0 ),
        @dcIdCarte      Decimal (  7,0 ),
        @dcIdTypeCarte  Varchar (  3 )  ,
        @dtCreeLe       DateTime        ,
        @dtMajLe        DateTime        ,
        @sMajPar        Varchar (  4 )  ,
        @dtDteCmd       DateTime	,
        @dtDteLivr      DateTime	,
        @dcMtValAchat	Decimal ( 11,2 ),
        @dcMtValPubl	Decimal ( 11,2 ),
        @sNumFacture	VarChar (35)
AS
 INSERT INTO    sysadm.w_detail 
        (       w_detail.id_sin,
                w_detail.id_gti,
                w_detail.id_detail,
                w_detail.id_evt,
                w_detail.lib_det,
                w_detail.dte_det,
                w_detail.heu_det,
                w_detail.num_carte,
                w_detail.mt_prej,
                w_detail.mt_fran,
                w_detail.mt_nplaf,
                w_detail.mt_plaf,
                w_detail.id_i_reg,
                w_detail.alt_bloc,
                w_detail.alt_cour,
                w_detail.alt_plaf,
                w_detail.alt_reg,
                w_detail.alt_att,
                w_detail.alt_valide,
                w_detail.cpt_valide,
                w_detail.alt_ssui,
                w_detail.cod_mot_ssui,
                w_detail.cod_dec_mac,
                w_detail.cod_dec_ope,
                w_detail.cod_etat,
                w_detail.id_carte,
                w_detail.id_type_carte,
                w_detail.cree_le,
                w_detail.maj_le,
                w_detail.maj_par,
                w_detail.dte_cmd,
                w_detail.dte_livr,
                w_detail.mt_val_achat,
                w_detail.mt_val_publique,
                w_detail.num_facture
                )
                
 VALUES (       @dcIdsin,
                @dcIdGti,
                @dcIdDetail,
                @dcIdEvt,
                @sLibDet,
                @dDteDet,
                @sHeuDet,
                @sNumCarte,
                @dcMtPrej,
                @dcMtFran,
                @dcMtnPlaf,
                @dcMtPlaf,
                @dcIdiReg,
                @sAltBloc,
                @sAltCour,
                @sAltPlaf,
                @sAltReg,
                @sAltAtt,
                @sAltValide,
                @dcCptValide,
                @sAltSsui,
                @dcCodMotSsui,
                @dcCodDecMac,
                @dcCodDecOpe,
                @dcCodEtat,
                @dcIdCarte,
                @dcIdTypeCarte,
                @dtCreeLe,
                @dtMajLe,
                @sMajPar,
                @dtDteCmd,
                @dtDteLivr,
                @dcMtValAchat,
                @dcMtValPubl,
                @sNumFacture
                )

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_W_DETAIL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Suppression d'un d‚tail d'une garantie
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

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_W_DETAIL' AND type = 'P' )
        DROP procedure sysadm.DW_D01_W_DETAIL
GO

CREATE procedure sysadm.DW_D01_W_DETAIL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdGti        Decimal (  7,0 ),
        @dcIdDetail     Decimal (  7,0 )
AS

 DELETE FROM    sysadm.w_div_det
 WHERE          w_div_det.id_sin                = @dcIdSin      AND
                w_div_det.id_gti                = @dcIdGti      AND
                w_div_det.id_detail             = @dcIdDetail   AND
                w_div_det.cpt_valide		= 0                

 DELETE FROM    sysadm.w_refus
 WHERE          w_refus.id_sin                  = @dcIdSin      AND
                w_refus.id_gti                  = @dcIdGti      AND
                w_refus.id_detail               = @dcIdDetail

 DELETE FROM    sysadm.w_piece
 WHERE          w_piece.id_sin                  = @dcIdSin      AND
                w_piece.id_gti                  = @dcIdGti      AND
                w_piece.id_detail               = @dcIdDetail

 DELETE FROM    sysadm.w_para_plafond
 WHERE          w_para_plafond.id_sin           = @dcIdSin      AND
                w_para_plafond.id_gti           = @dcIdGti      AND
                w_para_plafond.id_detail        = @dcIdDetail

 DELETE FROM    sysadm.w_commande
 WHERE          w_commande.id_sin               = @dcIdSin      AND
                w_commande.id_gti               = @dcIdGti      AND
                w_commande.id_detail            = @dcIdDetail   AND
                w_commande.cpt_valide		= 0

 DELETE FROM    sysadm.w_detail
 WHERE          w_detail.id_sin                 = @dcIdSin      AND
                w_detail.id_gti                 = @dcIdGti      AND
                w_detail.id_detail              = @dcIdDetail
 
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_W_DETAIL_A_REGLER
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Existe t il des d‚tails … r‚gler pour la mˆme adh‚sion ?
-- Références           :       W_TD_SP_W_DETAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @iNbDetail      Integer         OUTPUT  (R‚f)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_W_DETAIL_A_REGLER' AND type = 'P' )
        DROP procedure sysadm.PS_S01_W_DETAIL_A_REGLER
GO

CREATE procedure sysadm.PS_S01_W_DETAIL_A_REGLER
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
        @dcIdEvt        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @iNbDetail      Integer OUTPUT
AS
 SELECT @iNbDetail = Count ( w_detail.id_sin )
 FROM   sysadm.w_sin,
        sysadm.w_detail
 WHERE  w_sin.id_sin            = w_detail.id_sin                       AND
        w_sin.id_sin           <> @dcIdSin                              AND
        w_sin.id_prod           = @dcIdProd                             AND
        w_sin.id_ets            = @dcIdEts                              AND
        w_sin.id_adh            = @sIdAdh                               AND
        w_detail.id_gti         = @dcIdGti                              AND
        w_detail.id_evt         = @dcIdEvt                              AND
        w_sin.dte_surv         <= @dtSurv                               AND
        w_sin.dte_surv         >= DateAdd ( day, -365, @dtSurv )        AND
        w_detail.cod_etat       = 500

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_W_DETAIL_MT_PLAF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Calcul des plafonds par adh‚sion (Survenance)
-- Références           :       W_TD_SP_W_DETAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPrej       VarChar ( 12 ) OUTPUT  (R‚f)
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_W_DETAIL_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S01_W_DETAIL_MT_PLAF
GO

CREATE procedure sysadm.PS_S01_W_DETAIL_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
        @dcIdEvt        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @dcMtPrej       VarChar ( 12 ) OUTPUT
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
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			detail.cod_etat         = 600
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			detail.cod_etat         = 600									AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
 
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S02_W_DETAIL_MT_PLAF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Calcul des plafonds par adh‚rent (Survenance)
-- Références           :       W_TD_SP_W_DETAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdsDos       Decimal (  2,0 )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPrej       Varchar ( 12 )  OUTPUT  (R‚f)
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_W_DETAIL_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S02_W_DETAIL_MT_PLAF
GO


CREATE procedure sysadm.PS_S02_W_DETAIL_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdsDos       Decimal (  2,0 ),
        @dcIdGti        Decimal (  7,0 ),
        @dcIdEvt        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @dcMtPrej       VarChar ( 12 ) OUTPUT
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
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			detail.cod_etat         = 600
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			detail.cod_etat         = 600	  								AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S03_W_DETAIL_MT_PLAF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Calcul des plafonds par adh‚sion (Renouvellement)
-- Références           :       W_TD_SP_W_DETAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @dcMtPrej       Varchar ( 12 )    OUTPUT  (R‚f)
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-- [20251031115051973][JFF][MIG215_FREE]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S03_W_DETAIL_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S03_W_DETAIL_MT_PLAF
GO


CREATE procedure sysadm.PS_S03_W_DETAIL_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
        @dcIdEvt        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
        @dcMtPrej       VarChar ( 12 ) OUTPUT
AS
-- 693
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
 Declare @iIdMotifRegSaga2 Integer 
 Declare @sIdSubscription Varchar ( 50 ) 
 Declare @dcMtRegAssureSaga2 Decimal ( 11,2 )
 
 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927]
 From	sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			detail.cod_etat         = 600
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			detail.cod_etat         = 600									AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
  End

-- [MIG19_PSPLAF_SAGA2]
-- [20251031115051973][JFF][MIG215_FREE]
If sysadm.FN_CLE_NUMERIQUE ( 'MIG19_PSPLAF_SAGA2') > 0 
 Begin
	-- [20251028104420513][JFF][OPTIM_PLAF_SAGA2]
	If sysadm.FN_CLE_NUMERIQUE ( 'OPTIM_PLAF_SAGA2') > 0 
		Begin
			If Exists ( Select Top 1 1 From sysadm.det_pro Where id_prod = @dcIdProd and id_code_dp = 408 ) 
				Begin 
					 Set @sIdSubscription = Right ( REPLICATE ( '0', 12 ) + LTRIM ( rtrim ( @sIdAdh ) ), 12 ) 

					-- le motif du règlement en lien avec SAGA2
					Declare @TbLienEvtMotifRegSaga2 Table (
						id_evt Integer,
						id_motifreg_saga2 Integer
					)

					Insert into @TbLienEvtMotifRegSaga2 Values ( 971, 6 ) -- Accessoire
					Insert into @TbLienEvtMotifRegSaga2 Values ( 924, 5 ) -- Carte SIM
					Insert into @TbLienEvtMotifRegSaga2 Values ( 1071, 5 ) -- Carte USIM (pareil)
	
					Select Top 1 @iIdMotifRegSaga2 = id_motifreg_saga2 
					From @TbLienEvtMotifRegSaga2 
					Where id_evt = @dcIdEvt

					If @iIdMotifRegSaga2 is null Set @iIdMotifRegSaga2 = 0

					 --[20251006144234][JFF][MIG119]
					If @iIdMotifRegSaga2 > 0 -- Pour un Gti spéciale
						Begin
							Select @dcMtRegAssureSaga2 = isNull ( Sum ( mt_reg_assure ),0 )
							From sysadm.stockage_plafond_saga2 
							where subscription_number = @sIdSubscription
							And Upper ( indemnise ) = 'OUI'
							And dte_surv <= @dtSurv                        
							And dte_surv >= @dtAdhRenouv
							And code_motif = @iIdMotifRegSaga2  
						End

					If @dcMtRegAssureSaga2 is null Set @dcMtRegAssureSaga2 = 0

					Set @dcMtPrej = Convert ( VarChar ( 12 ), convert ( Decimal( 11, 2), @dcMtPrej ) + @dcMtRegAssureSaga2 )

				End
		End
 End



GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S04_W_DETAIL_MT_PLAF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Calcul des plafonds par adh‚rent (Renouvellement)
-- Références           :       W_TD_SP_W_DETAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdsDos       Decimal (  2,0 )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @dcMtPrej       Varchar ( 12 )         OUTPUT  (R‚f)
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S04_W_DETAIL_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S04_W_DETAIL_MT_PLAF
GO


CREATE procedure sysadm.PS_S04_W_DETAIL_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdsDos       Decimal (  2,0 ),
        @dcIdGti        Decimal (  7,0 ),
        @dcIdEvt        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
        @dcMtPrej       VarChar ( 12 ) OUTPUT
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
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			detail.cod_etat         = 600
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			detail.cod_etat         = 600									AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S05_W_DETAIL_MT_PLAF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Calcul des plafonds par adh‚sion (année civile)
-- Références           :       W_TD_SP_W_DETAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPrej       VarChar ( 12 ) OUTPUT  (R‚f)
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S05_W_DETAIL_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S05_W_DETAIL_MT_PLAF
GO

CREATE procedure sysadm.PS_S05_W_DETAIL_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
        @dcIdEvt        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @dcMtPrej       VarChar ( 12 ) OUTPUT
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
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail
	 WHERE  sinistre.id_sin        			<> @dcIdSin			AND
			sinistre.id_prod       			= @dcIdProd			AND
			sinistre.id_ets        			= @dcIdEts			AND
			sinistre.id_adh        			= @sIdAdh			AND  -- [PI038][RELEVE]
			sinistre.id_sin         		= detail.id_sin			AND
			detail.id_gti         			= @dcIdGti			AND
			detail.id_evt           		= @dcIdEvt			AND
			DatePart ( year, sinistre.dte_surv )	= DatePart ( year, @dtSurv )	AND
			detail.cod_etat         		= 600	  
  
  End        	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        			<> @dcIdSin			AND
			sinistre.id_prod       			= @dcIdProd			AND
			sinistre.id_ets        			= @dcIdEts			AND
			sinistre.id_adh        			= @sIdAdh			AND  -- [PI038][RELEVE]
			sinistre.id_sin         		= detail.id_sin			AND
			detail.id_gti         			= @dcIdGti			AND
			detail.id_evt           		= @dcIdEvt			AND
			DatePart ( year, sinistre.dte_surv )	= DatePart ( year, @dtSurv )	AND
			detail.cod_etat         		= 600	  								AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S06_W_DETAIL_MT_PLAF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Calcul des plafonds par adh‚rent (Année civile)
-- Références           :       W_TD_SP_W_DETAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdsDos       Decimal (  2,0 )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPrej       Varchar ( 12 )  OUTPUT  (R‚f)
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S06_W_DETAIL_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S06_W_DETAIL_MT_PLAF
GO


CREATE procedure sysadm.PS_S06_W_DETAIL_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdsDos       Decimal (  2,0 ),
        @dcIdGti        Decimal (  7,0 ),
        @dcIdEvt        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @dcMtPrej       VarChar ( 12 ) OUTPUT
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
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail
	 WHERE  sinistre.id_sin        			<> @dcIdSin                     AND
			sinistre.id_prod        		= @dcIdProd                     AND
			sinistre.id_ets         		= @dcIdEts                      AND
			sinistre.id_adh         		= @sIdAdh                       AND  -- [PI038][RELEVE]
			sinistre.id_sdos        		= @dcIdsDos                     AND
			sinistre.id_sin         		= detail.id_sin                 AND
			detail.id_gti           		= @dcIdGti                      AND
			detail.id_evt           		= @dcIdEvt                      AND
			DatePart ( year, sinistre.dte_surv )	= DatePart ( year, @dtSurv )	AND
			detail.cod_etat         = 600	  
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        			<> @dcIdSin                     AND
			sinistre.id_prod        		= @dcIdProd                     AND
			sinistre.id_ets         		= @dcIdEts                      AND
			sinistre.id_adh         		= @sIdAdh                       AND  -- [PI038][RELEVE]
			sinistre.id_sdos        		= @dcIdsDos                     AND
			sinistre.id_sin         		= detail.id_sin                 AND
			detail.id_gti           		= @dcIdGti                      AND
			detail.id_evt           		= @dcIdEvt                      AND
			DatePart ( year, sinistre.dte_surv )	= DatePart ( year, @dtSurv )	AND
			detail.cod_etat         = 600	  	  							AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S07_W_DETAIL_NBEVT
-- Auteur               :       Fabry JF
-- Date                 :       28/09/2005
-- Libellé              :       
-- Commentaires         :       Calcul du nombre de sinistre par adhesion (Survenance)
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- [PLAF_REF]
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S07_W_DETAIL_NBEVT' AND type = 'P' )
        DROP procedure sysadm.PS_S07_W_DETAIL_NBEVT
GO


CREATE procedure sysadm.PS_S07_W_DETAIL_NBEVT
	@dcIdSin        Decimal ( 10,0 ), -- [PI062]
	@dcIdProd       Decimal (  7,0 ),
	@dcIdEts        Decimal (  7,0 ),
	@sIdAdh         Varchar ( 19   ),
	@dcIdGti        Decimal (  7,0 ),
	@dcIdEvt        Decimal (  7,0 ),
	@dtSurv         DateTime        ,
        @iNbSin		Integer	 OUTPUT
AS

-- Plafond 702

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
			sysadm.detail
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			( detail.cod_etat         = 600
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '702'
				  And    detail.cod_etat = 100 
				  )
			)
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			( detail.cod_etat         = 600
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '702'
				  And    detail.cod_etat = 100 
				  )
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S08_W_DETAIL_NBEVT
-- Auteur               :       Fabry JF
-- Date                 :       28/09/2005
-- Libellé              :       
-- Commentaires         :       Calcul du nombre de sinistre par adherent (Survenance)
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdsDos       Decimal (  2,0 )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- [PLAF_REF]
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S08_W_DETAIL_NBEVT' AND type = 'P' )
        DROP procedure sysadm.PS_S08_W_DETAIL_NBEVT
GO


CREATE procedure sysadm.PS_S08_W_DETAIL_NBEVT
	@dcIdSin        Decimal (  10,0 ), -- [PI062]
	@dcIdProd       Decimal (  7,0 ),
	@dcIdEts        Decimal (  7,0 ),
	@sIdAdh         Varchar ( 19   ),
	@dcIdsDos       Decimal (  2,0 ),
	@dcIdGti        Decimal (  7,0 ),
	@dcIdEvt        Decimal (  7,0 ),
	@dtSurv         DateTime        ,
        @iNbSin		Integer	 OUTPUT
AS

-- Plafond 703
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
			sysadm.detail
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			( detail.cod_etat         = 600
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '703'
				  And    detail.cod_etat = 100
				  )
			)
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			( detail.cod_etat         = 600
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '703'
				  And    detail.cod_etat = 100
				  )
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S09_W_DETAIL_NBEVT
-- Auteur               :       Fabry JF
-- Date                 :       28/09/2005
-- Libellé              :       
-- Commentaires         :       Calcul du nombre de sinistre par adhesion (Renouvellement)
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- [PLAF_REF]
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
--[20251006144234][JFF][MIG119]
-- JFF      22/07/2025   [MIG165_BOUYGUES]
-- [20251028104420513][JFF][OPTIM_PLAF_SAGA2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S09_W_DETAIL_NBEVT' AND type = 'P' )
        DROP procedure sysadm.PS_S09_W_DETAIL_NBEVT
GO

CREATE procedure sysadm.PS_S09_W_DETAIL_NBEVT
	@dcIdSin        Decimal (  10,0 ), -- [PI062]
	@dcIdProd       Decimal (  7,0 ),
	@dcIdEts        Decimal (  7,0 ),
	@sIdAdh         Varchar ( 19   ),
	@dcIdGti        Decimal (  7,0 ),
	@dcIdEvt        Decimal (  7,0 ),
	@dtSurv         DateTime        ,
	@dtAdhRenouv    DateTime        ,
    @iNbSin			Integer	 OUTPUT
AS

-- Plafond 704
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]
 Declare @iIdMotifRegSaga2 Integer 
 Declare @sIdSubscription Varchar ( 50 ) 

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
			sysadm.detail
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
		( detail.cod_etat         = 600
			Or  Exists (  Select *
					  From   sysadm.det_pro
					  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '704'
				  And    detail.cod_etat = 100
			   )
		)        
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			( detail.cod_etat         = 600
			Or  Exists (  Select *
					  From   sysadm.det_pro
					  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '704'
				  And    detail.cod_etat = 100
			   )
			)      															AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End

--[20251006144234][JFF][MIG119]
-- MIG19_PSPLAF_SAGA2
If sysadm.FN_CLE_NUMERIQUE ( 'MIG19_PSPLAF_SAGA2') >= 2 
 Begin
 	If Exists ( Select Top 1 1 From sysadm.det_pro Where id_prod = @dcIdProd and id_code_dp = 408 ) 
		Begin 

			-- Ce plafond est particulier et se fait par rapport à l'évènement, donc il n'a de sens sur SAGA2 que si je connais
			-- le motif du règlement en lien avec SAGA2
			Declare @TbLienEvtMotifRegSaga2 Table (
				id_evt Integer,
				id_motifreg_saga2 Integer
			)

			Insert into @TbLienEvtMotifRegSaga2 Values ( 971, 6 )
			Insert into @TbLienEvtMotifRegSaga2 Values ( 924, 5 ) -- Carte SIM
			Insert into @TbLienEvtMotifRegSaga2 Values ( 1071, 5 ) -- Carte USIM (pareil)
					
			Select Top 1 @iIdMotifRegSaga2 = id_motifreg_saga2 
			From @TbLienEvtMotifRegSaga2 
			Where id_evt = @dcIdEvt

			If @iIdMotifRegSaga2 > 0 
				Begin
						-- [20251028104420513][JFF][OPTIM_PLAF_SAGA2]
					If sysadm.FN_CLE_NUMERIQUE ( 'OPTIM_PLAF_SAGA2') > 0 
						Begin
							If @iNbSin is null Set @iNbSin = 0
							Set @sIdSubscription = Right ( REPLICATE ( '0', 12 ) + LTRIM ( rtrim ( @sIdAdh ) ), 12 ) 


							--[20251006144234][JFF][MIG119]
							Set @iNbSin = @iNbSin + 
										IsNull (  ( Select count (* ) 
													From 
													( Select Distinct id_sin 
														From sysadm.stockage_plafond_saga2 
														where subscription_number = @sIdSubscription  
														And Upper ( indemnise ) = 'OUI'
														And dte_surv <= @dtSurv                        
														And dte_surv >= @dtAdhRenouv
														And code_motif = @iIdMotifRegSaga2  
													) as T )
										, 0 ) 
						End 
					Else -- [20251028104420513][JFF][OPTIM_PLAF_SAGA2] à supprimer par la suite
						Begin 
							Declare @TbRetSaga2 Table ( 
							id_seq Integer identity (1, 1 ),
							id_sin integer,
							subscription_number varchar ( 50 ),
							indemnise VarChar ( 10 ),
							mt_reg_assure Decimal ( 11, 2 ),
							mode_indemnisation VarChar ( 50 ),
							mode_indemnisation_long VarChar ( 50 ),
							dte_adh DateTime,
							dte_decl DateTime,
							dte_surv DateTime,
							code_motif Integer,
							label_motif VarChar ( 50 )
							)

							If @iNbSin is null Set @iNbSin = 0
							Insert into @TbRetSaga2 Exec sysadm.PS_S_SAGA2_PLAFOND_PAR_ANNEE_SUR_SAGA2 @dcIdSin, @sIdAdh 

							--[20251006144234][JFF][MIG119]
							Set @iNbSin = @iNbSin + 
										IsNull (  ( Select count (* ) 
													From 
													( Select Distinct id_sin 
														From @TbRetSaga2 
														where Upper ( indemnise ) = 'OUI'
														And dte_surv <= @dtSurv                        
														And dte_surv >= @dtAdhRenouv
														And code_motif = @iIdMotifRegSaga2  
													) as T )
										, 0 ) 
						End
				End 
		End
 End 


GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S10_W_DETAIL_NBEVT
-- Auteur               :       Fabry JF
-- Date                 :       28/09/2005
-- Libellé              :       
-- Commentaires         :       Calcul du nombre de sinistre par adherent (Renouvellement)
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdsDos       Decimal (  2,0 )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- [PLAF_REF]
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S10_W_DETAIL_NBEVT' AND type = 'P' )
        DROP procedure sysadm.PS_S10_W_DETAIL_NBEVT
GO


CREATE procedure sysadm.PS_S10_W_DETAIL_NBEVT
	@dcIdSin        Decimal (  10,0 ), -- [PI062]
	@dcIdProd       Decimal (  7,0 ),
	@dcIdEts        Decimal (  7,0 ),
	@sIdAdh         Varchar ( 19   ),
	@dcIdsDos       Decimal (  2,0 ),
	@dcIdGti        Decimal (  7,0 ),
	@dcIdEvt        Decimal (  7,0 ),
	@dtSurv         DateTime        ,
	@dtAdhRenouv    DateTime        ,
        @iNbSin		Integer	 OUTPUT
AS

-- Plafond 705
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
			sysadm.detail
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
  			( detail.cod_etat         = 600
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '705'
				  And    detail.cod_etat = 100
				  )
		)   
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
  			( detail.cod_etat         = 600
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '705'
				  And    detail.cod_etat = 100
				  )
		)																	AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
  End
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_W_DETAIL_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans W_SIN       
-- Références           :       Utilisé dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-- MAJ			: 
-- 31/10/2003	JFF	Ajout colonne mt_val_achat
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_DETAIL_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_DETAIL_WKF
GO

CREATE procedure sysadm.PS_I01_W_DETAIL_WKF
        @dcIdSin        Decimal (  10,0 )  -- [PI062]
AS
 INSERT INTO    sysadm.w_detail
        (       w_detail.id_sin,
                w_detail.id_gti,
                w_detail.id_detail,
                w_detail.id_evt,
                w_detail.lib_det,
                w_detail.dte_det,
                w_detail.heu_det,
                w_detail.num_carte,
                w_detail.mt_prej,
                w_detail.mt_fran,
                w_detail.mt_nplaf,
                w_detail.mt_plaf,
                w_detail.id_i_reg,
                w_detail.alt_bloc,
                w_detail.alt_cour,
                w_detail.alt_plaf,
                w_detail.alt_reg,
                w_detail.alt_att,
                w_detail.alt_valide,
                w_detail.cpt_valide,
                w_detail.alt_ssui,
                w_detail.cod_mot_ssui,
                w_detail.cod_dec_mac,
                w_detail.cod_dec_ope,
                w_detail.cod_etat,
                w_detail.id_carte,
                w_detail.id_type_carte,
                w_detail.cree_le,
                w_detail.maj_le,
                w_detail.maj_par,
		w_detail.dte_cmd,
		w_detail.dte_livr,
		w_detail.mt_val_achat,
		w_detail.mt_val_publique,
		w_detail.num_facture
                )
 SELECT         detail.id_sin,
                detail.id_gti,
                detail.id_detail,
                detail.id_evt,
                detail.lib_det,
                detail.dte_det,
                detail.heu_det,
                detail.num_carte,
                detail.mt_prej,
                detail.mt_fran,
                detail.mt_nplaf,
                detail.mt_plaf,
                reglement.id_i,
                'N',
                'N',
                detail.alt_plaf,
                detail.alt_reg,
                detail.alt_att,
                'N',
                1,
                detail.alt_ssui,
                detail.cod_mot_ssui,
                detail.cod_dec_mac,
                detail.cod_dec_ope,
                detail.cod_etat,
                detail.id_carte,
                detail.id_type_carte,
                detail.cree_le,
                detail.maj_le,
                detail.maj_par,
		detail.dte_cmd,
		detail.dte_livr,
		detail.mt_val_achat,
		detail.mt_val_publique,
		detail.num_facture
 FROM           sysadm.detail
LEFT OUTER JOIN sysadm.reglement
ON              detail.id_sin = reglement.id_sin AND
                detail.id_reg = reglement.id_reg
 WHERE          detail.id_sin   = @dcIdSin

 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S11_W_DETAIL_NBEVT
-- Auteur               :       PHG, d'après Fabry JF
-- Date                 :       16/04/2007
-- Libellé              :       
-- Commentaires         :       Calcul du nombre de sinistre par adhesion (Survenance)
--				Toute garantie confondue 
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- [PLAF_REF]
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]

-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S11_W_DETAIL_NBEVT' AND type = 'P' )
        DROP procedure sysadm.PS_S11_W_DETAIL_NBEVT
GO

CREATE procedure sysadm.PS_S11_W_DETAIL_NBEVT
	@dcIdSin        Decimal (  10,0 ), -- [PI062]
	@dcIdProd       Decimal (  7,0 ),
	@dcIdEts        Decimal (  7,0 ),
	@sIdAdh         Varchar ( 19   ),
	@dcIdEvt        Decimal (  7,0 ),
	@dtSurv         DateTime        ,
        @iNbSin		Integer	 OUTPUT
AS

-- Plafond 707
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
			sysadm.detail
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			( detail.cod_etat         = 600
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '707'
				  And    detail.cod_etat = 100 
				  )
			)        
  End        	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			( detail.cod_etat         = 600
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '707'
				  And    detail.cod_etat = 100 
				  )
			)        														AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S12_W_DETAIL_NBEVT
-- Auteur               :       PHG, d'après Fabry JF
-- Date                 :       16/04/2007
-- Libellé              :       
-- Commentaires         :       Calcul du nombre de sinistre par adherent (Survenance)
--				Toute Garantie Confondue.
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdsDos       Decimal (  2,0 )        (Val)
----                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S12_W_DETAIL_NBEVT' AND type = 'P' )
        DROP procedure sysadm.PS_S12_W_DETAIL_NBEVT
GO

CREATE procedure sysadm.PS_S12_W_DETAIL_NBEVT
	@dcIdSin        Decimal (  10,0 ), -- [PI062]
	@dcIdProd       Decimal (  7,0 ),
	@dcIdEts        Decimal (  7,0 ),
	@sIdAdh         Varchar ( 19   ),
	@dcIdsDos       Decimal (  2,0 ),
	@dcIdEvt        Decimal (  7,0 ),
	@dtSurv         DateTime        ,
        @iNbSin		Integer	 OUTPUT
AS

-- Plafond 708
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
			sysadm.detail
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			( detail.cod_etat         = 600
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '708'
				  And    detail.cod_etat = 100
				  )
			)
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			( detail.cod_etat         = 600
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '708'
				  And    detail.cod_etat = 100
				  )
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S13_W_DETAIL_NBEVT
-- Auteur               :       PHG, Fabry JF
-- Date                 :       16/04/2007
-- Libellé              :       
-- Commentaires         :       Calcul du nombre de sinistre par adhesion (Renouvellement)
--				Toute Garantie Confondue
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
----                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S13_W_DETAIL_NBEVT' AND type = 'P' )
        DROP procedure sysadm.PS_S13_W_DETAIL_NBEVT
GO


CREATE procedure sysadm.PS_S13_W_DETAIL_NBEVT
	@dcIdSin        Decimal (  10,0 ), -- [PI062]
	@dcIdProd       Decimal (  7,0 ),
	@dcIdEts        Decimal (  7,0 ),
	@sIdAdh         Varchar ( 19   ),
	@dcIdEvt        Decimal (  7,0 ),
	@dtSurv         DateTime        ,
	@dtAdhRenouv    DateTime        ,
        @iNbSin		Integer	 OUTPUT
AS

-- Plafond 709
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
			sysadm.detail
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			( detail.cod_etat         = 600
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '709'
				  And    detail.cod_etat = 100 
				  )
			)
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			( detail.cod_etat         = 600
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '709'
				  And    detail.cod_etat = 100 
				  )
			)																AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
  End
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S14_W_DETAIL_NBEVT
-- Auteur               :       PHG, d'apres Fabry JF
-- Date                 :       16/04/2007
-- Libellé              :       
-- Commentaires         :       Calcul du nombre de sinistre par adherent (Renouvellement)
--				Toute Garantie Confondue
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdsDos       Decimal (  2,0 )        (Val)
----                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
--
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S14_W_DETAIL_NBEVT' AND type = 'P' )
        DROP procedure sysadm.PS_S14_W_DETAIL_NBEVT
GO


CREATE procedure sysadm.PS_S14_W_DETAIL_NBEVT
	@dcIdSin        Decimal (  10,0 ), -- [PI062]
	@dcIdProd       Decimal (  7,0 ),
	@dcIdEts        Decimal (  7,0 ),
	@sIdAdh         Varchar ( 19   ),
	@dcIdsDos       Decimal (  2,0 ),
	@dcIdEvt        Decimal (  7,0 ),
	@dtSurv         DateTime        ,
	@dtAdhRenouv    DateTime        ,
       @iNbSin		Integer	 OUTPUT
AS

-- Plafond 710
 Declare @sCodAdh   VarChar ( 1 )
 Declare @sNom		VarChar ( 35 ) -- [ITSM361927]
 Declare @sPrenom	VarChar ( 35 ) -- [ITSM361927]

 Select @sCodAdh = p.cod_adh,
		@sNom = s.nom,  -- [ITSM361927]
		@sPrenom = s.prenom   -- [ITSM361927] From	sysadm.produit p,
From    sysadm.produit p,
		sysadm.w_sin s
 Where  s.id_sin = @dcIdSin
 And	p.id_prod = s.id_prod
 
 If @sCodAdh <> '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.detail
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			( detail.cod_etat         = 600
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '710'
				  And    detail.cod_etat = 100 
				  )
			)	  
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sdos        = @dcIdsDos                             AND
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			( detail.cod_etat         = 600
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '710'
				  And    detail.cod_etat = 100 
				  )
			)	  															AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				

  End

GO


--------------------------------------------------------------------
-- Procédure            :       PS_S_W_DETAIL_NBEVT_GTI_ADHESION
-- Auteur               :       Fabry JF
-- Date                 :       23/08/11
-- Libellé              :       [CONFO][CUISINE][PC680]
-- Commentaires         :       
-- Références           :       1 nombre d'évènement défini, par GTI
--
--
-- Retourne             :       Rien

--
-- Retourne             :       Rien
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_W_DETAIL_NBEVT_GTI_ADHESION' AND type = 'P' )
        DROP procedure sysadm.PS_S_W_DETAIL_NBEVT_GTI_ADHESION
GO

CREATE procedure sysadm.PS_S_W_DETAIL_NBEVT_GTI_ADHESION
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
	@iNbSin		Integer	 OUTPUT
AS

-- Plafond 730
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
			sysadm.detail
	 WHERE  sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sin         		= detail.id_sin                         AND
			detail.id_gti           		= @dcIdGti                              AND
		   ( detail.cod_etat        		= 600 
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '730'
				  And    detail.cod_etat = 100 
				  )
			) 
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @iNbSin  = count ( * )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        			<> @dcIdSin                             AND
			sinistre.id_prod        		= @dcIdProd                             AND
			sinistre.id_ets         		= @dcIdEts                              AND
			sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sin         		= detail.id_sin                         AND
			detail.id_gti           		= @dcIdGti                              AND
		   ( detail.cod_etat        		= 600 
			Or  Exists (  Select *
    				  From   sysadm.det_pro
    				  Where  det_pro.id_prod = sinistre.id_prod 
				  And    det_pro.id_code_dp = 182
				  And    det_pro.id_code_car = '730'
				  And    detail.cod_etat = 100 
				  )
			) 																		AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				

  End

GO

--------------------------------------------------------------------
-- Procédure            :       PS_S_W_DETAIL_CODERGPT_DISTINCT_GTI_ADHESION
-- Auteur               :       Fabry JF
-- Date                 :       23/08/11
-- Libellé              :       [CONFO][CUISINE][PC680]
-- Commentaires         :       
-- Références           :       1 nombre d'évènement défini, par GTI
--
--
-- Retourne             :       Rien

--
-- Retourne             :       Rien
-- PLAF_REF
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_W_DETAIL_CODERGPT_DISTINCT_GTI_ADHESION' AND type = 'P' )
        DROP procedure sysadm.PS_S_W_DETAIL_CODERGPT_DISTINCT_GTI_ADHESION
GO



CREATE procedure sysadm.PS_S_W_DETAIL_CODERGPT_DISTINCT_GTI_ADHESION
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdGti        Decimal (  7,0 ),
		@iNbSin		Integer	 OUTPUT,
		@sChaine	VarChar ( 100 ) OUTPUT
AS

-- Plafond 731

Declare @iIdSeq Integer
Declare @iIdRpgt Integer

DECLARE @tb TABLE 
	( id_seq	integer	identity ,
	  id_rgpt   integer null ,
	  marquage	integer null 
	)

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
	Insert into @tb
	Select Distinct tb.id_rgpt, 0
	From 
		(
		 SELECT dd.val_nbre 'id_rgpt'
		 FROM   sysadm.sinistre,
				sysadm.div_det dd,
				sysadm.detail d
		 WHERE  sinistre.id_sin        			<> @dcIdSin                             AND
				sinistre.id_prod        		= @dcIdProd                             AND
				sinistre.id_ets         		= @dcIdEts                              AND
				sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
				d.id_sin						= sinistre.id_sin						AND
				d.id_gti						= @dcIdGti								AND
				dd.id_sin						= d.id_sin								AND
				dd.id_gti						= d.id_gti								AND
				dd.id_detail					= d.id_detail							AND
				dd.nom_zone						= 'code_rgpr_element'					AND
			   ( d.cod_etat        				= 600 
				Or  Exists (  Select *
						  From   sysadm.det_pro
						  Where  det_pro.id_prod = sinistre.id_prod 
					  And    det_pro.id_code_dp = 182
					  And    det_pro.id_code_car = '731'
					  And    d.cod_etat = 100
					  )
			   )
		) as tb	  
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	Insert into @tb
	Select Distinct tb.id_rgpt, 0
	From 
		(
		 SELECT dd.val_nbre 'id_rgpt'
		 FROM   sysadm.sinistre,
				sysadm.div_det dd,
				sysadm.detail d,
				sysadm.personne p
		 WHERE  sinistre.id_sin        			<> @dcIdSin                             AND
				sinistre.id_prod        		= @dcIdProd                             AND
				sinistre.id_ets         		= @dcIdEts                              AND
				sinistre.id_adh         		= @sIdAdh                               AND  -- [PI038][RELEVE]
				d.id_sin						= sinistre.id_sin						AND
				d.id_gti						= @dcIdGti								AND
				dd.id_sin						= d.id_sin								AND
				dd.id_gti						= d.id_gti								AND
				dd.id_detail					= d.id_detail							AND
				dd.nom_zone						= 'code_rgpr_element'					AND
			   ( d.cod_etat        				= 600 
				Or  Exists (  Select *
						  From   sysadm.det_pro
						  Where  det_pro.id_prod = sinistre.id_prod 
					  And    det_pro.id_code_dp = 182
					  And    det_pro.id_code_car = '731'
					  And    d.cod_etat = 100
					  )
			   )																		AND
				p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
				p.nom					= @sNom									AND -- [ITSM361927]
				p.prenom				= @sPrenom -- [ITSM361927]				
		) as tb	  	  
	        
  End

Select @iNbSin = COUNT (* ) From @tb

Set @sChaine = ''

While Exists ( Select * From @tb where marquage = 0 )
 Begin
	Select Top 1 
		@iIdSeq = id_seq,
	    @iIdRpgt = id_rgpt
	From	@tb
	Where	marquage = 0

	Set @sChaine = @sChaine + '#' + Convert ( VarChar ( 5 ), @iIdRpgt)

	Update @tb
	Set marquage = 1
	Where id_seq = @iIdSeq
 End

Set @sChaine = @sChaine + '#' 

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_VERIF_CODE_RGPT_V01
-- Auteur               :       Fabry JF
-- Date                 :       07/02/2012
-- Libelle              :		[CONFO][CUISINE][PC680]
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       Integer
--					  
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_VERIF_CODE_RGPT_V01' AND type = 'P' )
        DROP procedure sysadm.PS_VERIF_CODE_RGPT_V01 
GO


CREATE procedure sysadm.PS_VERIF_CODE_RGPT_V01 
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @iIdRgpt		Integer,
        @sChaine	    VarChar ( 255 )	OUTPUT,
        @sChaine1	    VarChar ( 255 )	OUTPUT

AS

Declare @iIdSeq Integer
Declare @dcIdSin2 Decimal (10) -- [PI062]
Declare @sLibGti VarChar ( 35)
Declare @dcIdDetail Decimal (7)
Declare @iIdRpgt Integer
Declare @sChaineW VarChar ( 510 )


DECLARE @tb TABLE 
	( id_seq	integer	identity ,
	  id_sin	decimal (10) null , -- [PI062]
	  lib_gti   varchar ( 35 ) null ,
	  id_detail decimal (7) null ,
	  id_rgpt   integer null ,
	  marquage	integer null 
	)

Insert into @tb
SELECT  d.id_sin,
		cg.lib_gti,
		d.id_detail,
		d.val_nbre,
		0
FROM   sysadm.sinistre s,
       sysadm.div_det d,
	   sysadm.code_garantie cg
WHERE  s.id_sin      = d.id_sin
AND	s.id_sin        <> @dcIdSin
AND s.id_prod        = @dcIdProd
AND s.id_ets         = @dcIdEts
AND s.id_adh         = @sIdAdh
And d.nom_zone = 'code_rgpr_element'
And cg.id_prod = s.id_prod
And cg.id_gti  = d.id_gti

Set @sChaineW = ''

While Exists ( Select * From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin2 = id_sin,
		@sLibGti = lib_gti,
		@dcIdDetail = id_detail,
	    @iIdRpgt = id_rgpt
	From	@tb
	Where	marquage = 0

	Set @sChaineW = @sChaineW + 'Sinistre ' + Isnull ( Convert ( VarChar ( 10 ), @dcIdSin2 ), '') + ', ' + -- [PI062]
					'Garantie ' + IsNull ( rTrim ( @sLibGti ), '' ) + ', ' +
					'Detail n° '+ IsNull ( Convert ( VarChar ( 2 ), @dcIdDetail ), '' ) + ', ' +
					'Meuble n° ' + IsNull ( Convert ( VarChar ( 2 ), @iIdRpgt ), '' ) +
					CHAR ( 13)

	Update @tb
	Set marquage = 1
	Where id_seq = @iIdSeq
 End

 Set @sChaine = LEFT ( @sChaineW , 255 )

 If LEN ( @sChaineW ) > 255
  Begin
	Set @sChaine1 = Substring ( @sChaineW , 256, LEN ( @sChaineW ))
  End 
  
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_W_DETAIL_MT_PLAF_EVT_REGLE
-- Auteur               :       JFF
-- Date                 :       25/09/2013
-- Libellé              :       
-- Commentaires         :       Calcul des plafonds par adh‚sion (année civile)
-- Références           :       W_TD_SP_W_DETAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPrej       VarChar ( 12 ) OUTPUT  (R‚f)
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_W_DETAIL_MT_PLAF_EVT_REGLE' AND type = 'P' )
        DROP procedure sysadm.PS_S_W_DETAIL_MT_PLAF_EVT_REGLE
GO

CREATE procedure sysadm.PS_S_W_DETAIL_MT_PLAF_EVT_REGLE
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdEvt        Decimal (  7,0 ),
        @dcMtPrej       VarChar ( 12 ) OUTPUT
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
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail
	 WHERE  sinistre.id_sin        			<> @dcIdSin			AND
			sinistre.id_prod       			= @dcIdProd			AND
			sinistre.id_ets        			= @dcIdEts			AND
			sinistre.id_adh        			= @sIdAdh			AND  -- [PI038][RELEVE]
			sinistre.id_sin         		= detail.id_sin			AND
			detail.id_evt           		= @dcIdEvt				AND
			detail.cod_etat         		= 600
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        			<> @dcIdSin			AND
			sinistre.id_prod       			= @dcIdProd			AND
			sinistre.id_ets        			= @dcIdEts			AND
			sinistre.id_adh        			= @sIdAdh			AND  -- [PI038][RELEVE]
			sinistre.id_sin         		= detail.id_sin			AND
			detail.id_evt           		= @dcIdEvt				AND
			detail.cod_etat         		= 600					AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				

	        
  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S09_W_DETAIL_NBEVT_DTE_SURV
-- Auteur               :       Fabry JF
-- Date                 :       04/10/2013
-- Libellé              :       [VDOC11880]
-- Commentaires         :       Calcul du nombre de sinistre par adhesion (Renouvellement)
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @iNbSin		Integer	 OUTPUT
--
-- Retourne             :       Rien
-- [PC260-PC586-PC512/1-PC697-PC608-PC/1-PC345-PC514/1-PC10/1-PC397-PC441-PC443] ajout état 100
-- [PLAF_REF]
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S09_W_DETAIL_NBEVT_DTE_SURV' AND type = 'P' )
        DROP procedure sysadm.PS_S09_W_DETAIL_NBEVT_DTE_SURV
GO

CREATE procedure sysadm.PS_S09_W_DETAIL_NBEVT_DTE_SURV
	@dcIdSin        Decimal (  10,0 ), -- [PI062]
	@dcIdProd       Decimal (  7,0 ),
	@dcIdEts        Decimal (  7,0 ),
	@sIdAdh         Varchar ( 19   ),
	@dcIdGti        Decimal (  7,0 ),
	@dcIdEvt        Decimal (  7,0 ),
	@dtSurv         DateTime        ,
	@dtAdhRenouv    DateTime        ,
        @iNbSin		Integer	 OUTPUT
AS

-- Plafond 743
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
		 SELECT distinct sinistre.dte_surv
		 FROM   sysadm.sinistre,
				sysadm.detail
		 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
				sinistre.id_prod        = @dcIdProd                             AND
				sinistre.id_ets         = @dcIdEts                              AND
				sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
				sinistre.id_sin         = detail.id_sin                         AND
				detail.id_gti           = @dcIdGti                              AND
				detail.id_evt           = @dcIdEvt                              AND
				sinistre.dte_surv      <= @dtSurv                               AND
				sinistre.dte_surv      >= @dtAdhRenouv                          AND
			( detail.cod_etat         = 600
				Or  Exists (  Select *
    					  From   sysadm.det_pro
    					  Where  det_pro.id_prod = sinistre.id_prod 
					  And    det_pro.id_code_dp = 182
					  And    det_pro.id_code_car = '743'
					  And    detail.cod_etat = 100
				   )
			)        
		) as Tb
  End        	        

 If @sCodAdh = '3' 
  Begin
	SELECT @iNbSin  = count ( * )
	From (
		 SELECT distinct sinistre.dte_surv
		 FROM   sysadm.sinistre,
				sysadm.detail,
				sysadm.personne p
		 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
				sinistre.id_prod        = @dcIdProd                             AND
				sinistre.id_ets         = @dcIdEts                              AND
				sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
				sinistre.id_sin         = detail.id_sin                         AND
				detail.id_gti           = @dcIdGti                              AND
				detail.id_evt           = @dcIdEvt                              AND
				sinistre.dte_surv      <= @dtSurv                               AND
				sinistre.dte_surv      >= @dtAdhRenouv                          AND
				( detail.cod_etat         = 600
					Or  Exists (  Select *
    						  From   sysadm.det_pro
    						  Where  det_pro.id_prod = sinistre.id_prod 
						  And    det_pro.id_code_dp = 182
						  And    det_pro.id_code_car = '743'
						  And    detail.cod_etat = 100
					   )
				)        														AND
				p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
				p.nom					= @sNom									AND -- [ITSM361927]
				p.prenom				= @sPrenom -- [ITSM361927]				

		) as Tb
  End

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_753_W_DETAIL_MT_PLAF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Calcul des plafonds par adh‚sion (année civile)
-- Références           :       W_TD_SP_W_DETAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPrej       VarChar ( 12 ) OUTPUT  (R‚f)
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_753_W_DETAIL_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S_753_W_DETAIL_MT_PLAF
GO

CREATE procedure sysadm.PS_S_753_W_DETAIL_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdEvt        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @dcMtPrej       VarChar ( 12 ) OUTPUT
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
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail
	 WHERE  sinistre.id_sin        			<> @dcIdSin			AND
			sinistre.id_prod       			= @dcIdProd			AND
			sinistre.id_ets        			= @dcIdEts			AND
			sinistre.id_adh        			= @sIdAdh			AND  -- [PI038][RELEVE]
			sinistre.id_sin         		= detail.id_sin			AND
			detail.id_evt           		= @dcIdEvt			AND
			DatePart ( year, sinistre.dte_surv )	= DatePart ( year, @dtSurv )	AND
			detail.cod_etat         		= 600	  
  
  End        	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        			<> @dcIdSin			AND
			sinistre.id_prod       			= @dcIdProd			AND
			sinistre.id_ets        			= @dcIdEts			AND
			sinistre.id_adh        			= @sIdAdh			AND  -- [PI038][RELEVE]
			sinistre.id_sin         		= detail.id_sin			AND
			detail.id_evt           		= @dcIdEvt			AND
			DatePart ( year, sinistre.dte_surv )	= DatePart ( year, @dtSurv )	AND
			detail.cod_etat         		= 600	  								AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_W_DETAIL_MT_PLAF_756
-- Auteur               :       FABRY JF
-- Date                 :       17/10/2018
-- Libellé              :       
-- Commentaires         :       Calcul des plafonds par adh‚sion (Renouvellement)
-- Références           :       W_TD_SP_W_DETAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdEvt        Decimal (  7,0 )        (Val)
--                              @dtSurv         DateTime                (Val)
--                              @dtAdhRenouv    DateTime                (Val)
--                              @dcMtPrej       Varchar ( 12 )    OUTPUT  (R‚f)
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_W_DETAIL_MT_PLAF_756' AND type = 'P' )
        DROP procedure sysadm.PS_S_W_DETAIL_MT_PLAF_756
GO


CREATE procedure sysadm.PS_S_W_DETAIL_MT_PLAF_756
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
		@sTypPers		Varchar ( 10 ),
        @dcIdGti        Decimal (  7,0 ),
        @dcIdEvt        Decimal (  7,0 ),
        @dtSurv         DateTime        ,
        @dtAdhRenouv    DateTime        ,
        @dcMtPrej       VarChar ( 12 ) OUTPUT
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
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.div_sin
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			detail.cod_etat         = 600									AND
			div_sin.id_sin			= sinistre.id_sin						AND
			div_sin.nom_zone		= 'personne_sin'						AND
			div_sin.val_car			= @sTypPers
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPrej  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p,
			sysadm.div_sin
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.id_sin         = detail.id_sin                         AND
			detail.id_gti           = @dcIdGti                              AND
			detail.id_evt           = @dcIdEvt                              AND
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= @dtAdhRenouv                          AND
			detail.cod_etat         = 600									AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom								AND
			div_sin.id_sin			= sinistre.id_sin						AND
			div_sin.nom_zone		= 'personne_sin'						AND
			div_sin.val_car			= @sTypPers  			-- [ITSM361927]				
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S734_W_DETAIL_MT_PLAF
-- Auteur               :       Fabry JF
-- Date                 :       26/11/2019
-- Libellé              :       [PC192290]
-- Commentaires         :       Calcul des plafonds par adh‚sion (Survenance)
-- Références           :       W_TM_SP_W_DETAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--						        @dcIdEvt        Decimal (  7,0 ),  
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S734_W_DETAIL_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S734_W_DETAIL_MT_PLAF
GO


CREATE procedure sysadm.PS_S734_W_DETAIL_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdEvt        Decimal (  7,0 ),        
        @dtSurv         DateTime        ,
        @dcMtPlaf	    VarChar ( 12 ) OUTPUT
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
	 SELECT @dcMtPlaf  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			sinistre.id_sin         = detail.id_sin							AND
			detail.id_evt           = @dcIdEvt								AND
			detail.cod_etat         = 600	    
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlaf  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			sinistre.id_sin         = detail.id_sin							AND
			detail.cod_etat         = 600									AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom -- [ITSM361927]				
	        
  End
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S759_W_DETAIL_MT_PLAF
-- Auteur               :       Fabry JF
-- Date                 :       08/09/2020
-- Libellé              :       [PC202551]
-- Commentaires         :       Calcul des plafonds par adh‚sion (Survenance)
-- Références           :       W_TM_SP_W_DETAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdEts        Decimal (  7,0 )        (Val)
--                              @sIdAdh         Varchar ( 19   )        (Val)
--						        @dcIdEvt        Decimal (  7,0 ),  
--                              @dtSurv         DateTime                (Val)
--                              @dcMtPlafReg    VarChar ( 12 ) OUTPUT
--
-- Retourne             :       Rien
-- JFF      20/01/2014   [PM208]
-- JFF		09/02/2016   [ITSM361927]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S759_W_DETAIL_MT_PLAF' AND type = 'P' )
        DROP procedure sysadm.PS_S759_W_DETAIL_MT_PLAF
GO


CREATE procedure sysadm.PS_S759_W_DETAIL_MT_PLAF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 19   ),
        @dcIdEvt        Decimal (  7,0 ),        
        @dtSurv         DateTime        ,
        @dcMtPlaf	    VarChar ( 12 ) OUTPUT
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
	 SELECT @dcMtPlaf  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.det_pro dp
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			sinistre.id_sin         = detail.id_sin							AND
			detail.id_evt           = @dcIdEvt								AND
			detail.cod_etat         = 600									AND
			dp.id_prod              = sinistre.id_prod						AND
			dp.id_code_dp           = 351									AND
			CharIndex ( '#' + Convert ( varchar ( 10 ), detail.id_gti) + '#', sysadm.FN_CLE_VAL ( 'ID_GTI', rtrim ( val_car ) + rtrim ( val_car2 ), ';' )) > 0
  End        	        
	        

 If @sCodAdh = '3' 
  Begin
	 SELECT @dcMtPlaf  = Convert ( VarChar ( 12 ), isNull ( Sum ( detail.mt_plaf ),0 ) )
	 FROM   sysadm.sinistre,
			sysadm.detail,
			sysadm.personne p,
			sysadm.det_pro dp
	 WHERE  sinistre.id_sin        <> @dcIdSin                              AND
			sinistre.id_prod        = @dcIdProd                             AND
			sinistre.id_ets         = @dcIdEts                              AND
			sinistre.id_adh         = @sIdAdh                               AND  -- [PI038][RELEVE]
			sinistre.dte_surv      <= @dtSurv                               AND
			sinistre.dte_surv      >= DateAdd ( day, -365, @dtSurv )        AND
			sinistre.id_sin         = detail.id_sin							AND
			detail.cod_etat         = 600									AND
			p.id_ordre				= sinistre.id_ordre						AND -- [ITSM361927]
			p.nom					= @sNom									AND -- [ITSM361927]
			p.prenom				= @sPrenom								AND -- [ITSM361927]				
			dp.id_prod              = sinistre.id_prod						AND
			dp.id_code_dp           = 351									AND
			CharIndex ( '#' + Convert ( varchar ( 10 ), detail.id_gti) + '#', sysadm.FN_CLE_VAL ( 'ID_GTI', rtrim ( val_car ) + rtrim ( val_car2 ), ';' )) > 0
	        
  End
GO
