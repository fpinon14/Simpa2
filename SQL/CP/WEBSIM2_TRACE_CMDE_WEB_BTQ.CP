-------------------------------------------------------------------
--
-- Fichier              :       WEBSIM2_TRACE_CMDE_WEB_BTQ.CP
-- Auteur               :       JFF
-- Date                 :       04/2010
--
-- Commentaires         :       Gestion des traces pour le site intranet Simpa2 Web
--				Ces procédures ne sont pas visibles depuis les Web Services du site.
--				[WEBSIM2].[FRANCE]
-------------------------------------------------------------------
-- PS_I01_TRACE_CMDE_BTQ_V01	JFF 22/04/2010 Procédure d'insertion d'une trace
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Procedure            :       PS_I01_TRACE_CMDE_BTQ_V01
-- Auteur               :       FABRY JF
-- Date                 :       22/04/2010 
-- Libelle              :        
-- Commentaires         :       Procédure d'insertion d'une trace
--                               
-- References           :       
--
-- Arguments            :      	@asIdSession	varchar(30),
--				@asBrowser	varchar(50),
--				@asCasProduit	varchar(50),
--				@adcIdSin	Decimal (7),
--				@asMdp		VarChar(50),
--				@asNom		Varchar(50),
--				@asCodeVendeur	Varchar(50),
--				@asCodeMagasin	Varchar(50),
--				@adcIdCodeTrc	Decimal(7),
--				@asGravite	varchar(10),
--				@asIdAppli	varchar(5),
--				@asEtape	varchar(20),
--				@aiIdMess 	integer
--				@asValCar	VarChar(254),
--				@asMajPar	VarChar ( 4 )
--
--
-- Retourne             :       Integer                 >0 = OK
--                                                      -1 = NOK
--
-------------------------------------------------------------------
-- Code de traces : (-TR)
--	4 : WI/Sinistre non valide
--	5 : WI/Presence travail
--	8 : WI/Dossier clos
--	9 : WI/Pas de cmde WEB dispo
--	11 : WE/mdp absent sur dossier
--	12 : WI/durée validité mdp expirée
--	13 : WI/mdp erroné
--	15 : WE/Validation imposs. div. raisons
--	18 : SI/Cmde Web activé par GT
--	19 : SI/Cmde Web annulé par GT
--	20 : WI/Connexion établie
--	22 : WI/Validation cmde par vendeur
--	23 : WI/Nom ou code d''accès non valide
--	24 : WE/Donnée erronée ou absente
--	25 : WE/Problème lecture des données
--	26 : WE/lecture des données effectuée
--	27 : WI/Presta Web passé par GT
-------------------------------------------------------------------
-- Modif : 
-- [DCMP100420]	EMD	25/06/2010	Agrandissement du numéro de série
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRACE_CMDE_BTQ_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_I01_TRACE_CMDE_BTQ_V01
GO

CREATE PROCEDURE        sysadm.PS_I01_TRACE_CMDE_BTQ_V01
	@asIdSession     varchar(30),
	@asBrowser       varchar(200),
	@asCasProduit     varchar(50),
	@adcIdSin	 Decimal (10),  -- [PI062]
	@asMdp           varchar(50),
	@asNom		 varchar(50),
	@asCodeVendeur	 Varchar(50),
	@asCodeMagasin	 Varchar(50),
	@adcIdCodeTrc    Decimal(7),
	@asGravite       varchar(10),
	@asIdAppli       varchar(5),
	@asEtape         varchar(20),
	@aiIdMess        integer,
	@asValCar	 VarChar(254),
	@asMajPar	 VarChar ( 4 )

As

Declare	@sMajPar        varchar(4)
Declare	@sIdMarqCmde    varchar(35)
Declare	@sIdModlCmde    varchar(35)
Declare	@dcMtTtcRempl   decimal(11,2)
Declare	@dcMtPec        decimal(11,2)
Declare	@dcIdProd	Decimal ( 7 )
Declare	@dcIdGti	Decimal ( 7 )
Declare @sIdTypTrc 	varchar ( 3 )
Declare @iIdSeq		integer
Declare @dtFinValMdp	DateTime
Declare @sNumSerieRempl VarChar ( 60 )

Set @sIdTypTrc = '-TR'

/*
  -2 : WI/Utilisation maintenance images 
  -3 : WI/Utilisation Test DIT
  +4 : WI/Sinistre non valide
  +15 : WE/Validation imposs. div. raisons
  -16 : WE/Imp envoi mail push conf
  +25 : WE/Problème lecture des données
  +28 : WI/Magasin non valide
*/
If @adcIdCodeTrc in ( 4, 15, 25, 28  )
	BEGIN
		Set @dtFinValMdp = null
		Set @iIdSeq = null
		Set @dcIdProd = null
		Set @dcIdGti = null
		Set @dcMtPec = 0
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @sNumSerieRempl =null
		Set @dcMtTtcRempl = 0
		Set @sMajPar = 'SPB'
	END

/*
 -7 : WI/Cmde déjà passée en cours de trt
 -17 : WI/Validation cmde par assuré
 +22 : WI/Validation cmde par vendeur
*/
If @adcIdCodeTrc in (  22  )
	BEGIN
		Select  @dtFinValMdp = Convert ( DateTime, sysadm.FN_CLE_VAL ( 'DTE_FIN_VAL_MDP_BTQ', rtrim ( IsNull ( info_spb_frn_cplt, '' ) ), ';')),
			@iIdSeq = c.id_seq,
			@dcIdProd = s.id_prod,
		        @dcIdGti = c.id_gti,
			@dcMtTtcRempl = c.mt_ttc_cmde,
			@sIdMarqCmde = c.id_marq_art,
			@sIdModlCmde = c.id_modl_art,
			@sNumSerieRempl = c.id_serie_nouv

		From    sysadm.sinistre s,
		        sysadm.commande c,
			sysadm.div_sin d
                Where   s.id_sin = @adcIdSin
                and	d.id_sin = s.id_sin
		and     d.nom_zone = 'mdp_net_boutique'
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBB'
                and     c.cod_etat in ( 'RPC' ) 
                and     c.id_seq = (    Select max ( c2.id_seq ) 
                                        From sysadm.commande c2
                                        Where c2.id_sin = c.id_sin
                                        and   c2.id_four = c.id_four
                                        and   c2.cod_etat = c.cod_etat )
		
		Set @dcMtPec = 0
		Set @sMajPar = 'BTQ'
	END

/*
  +5 : WI/Presence travail
  -6 : WI/Num portable non valide
  +8 : WI/Dossier clos
  +9 : WI/Pas de cmde WEB dispo
 +23 : WI/Nom ou code d''accès non valide
 +24 : WE/Donnée erronée ou absente
*/
If @adcIdCodeTrc in (  5, 23, 8, 9, 24 )
	BEGIN

		Select  @dcIdProd = s.id_prod
		From    sysadm.sinistre s
		Where   s.id_sin = @adcIdSin

		Set @iIdSeq = null
		Set @dcIdGti = null
		Set @dcMtPec = 0
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcRempl = 0
		Set @sNumSerieRempl = null

		Set @sMajPar = 'BTQ'
	END

/*
  -10 : WE/Prble Param delai mdp
  +11 : WE/mdp absent sur dossier
  +12 : WI/durée validité mdp expirée
  +13 : WI/mdp erroné
  -14 : WI/Trop peu mobile dispo fct plaf
  +20 : WI/Connexion établie
  +26 : WE/lecture des données effectuée
*/
If @adcIdCodeTrc in ( 11, 12, 13, 20, 26 )
	BEGIN
		Select  @dtFinValMdp = Convert ( DateTime, sysadm.FN_CLE_VAL ( 'DTE_FIN_VAL_MDP_BTQ', rtrim ( IsNull ( info_spb_frn_cplt, '' ) ), ';')),
			@iIdSeq = c.id_seq,
			@dcIdProd = s.id_prod,
		        @dcIdGti = c.id_gti,
			@dcMtPec = c.mt_ttc_cmde
		From    sysadm.sinistre s,
		        sysadm.commande c,
			sysadm.div_sin d

		Where   s.id_sin = @adcIdSin
       and	d.id_sin = s.id_sin
		and     d.nom_zone = 'mdp_net_boutique'
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBB'
		and     c.cod_etat = 'CWE'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )
		

		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcRempl = 0
		Set @sNumSerieRempl = null
		Set @sMajPar = 'BTQ'
	END

/*
  18 : SI/Cmde Web activé par GT
*/
If @adcIdCodeTrc in ( 18 )
	BEGIN
		Select  @dtFinValMdp = Convert ( DateTime, sysadm.FN_CLE_VAL ( 'DTE_FIN_VAL_MDP_BTQ', rtrim ( IsNull ( info_spb_frn_cplt, '' ) ), ';')),
			@iIdSeq = c.id_seq,
			@dcIdProd = s.id_prod,
		        @dcIdGti = c.id_gti,
			@dcMtPec = c.mt_ttc_cmde,
			@asMdp = sysadm.FN_TRIM ( d.val_car )

		From    sysadm.w_sin s,
		        sysadm.w_commande c,
			sysadm.w_div_sin d

		Where   s.id_sin = @adcIdSin
		and     d.id_sin = s.id_sin
		and     d.nom_zone = 'mdp_net_boutique'
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBB'
		and     c.cod_etat = 'CNV'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )
		

		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcRempl = 0
		Set @sNumSerieRempl = null
		Set @sMajPar = @asMajPar
	END

/*
  19 : SI/Cmde Web annulé par GT
*/
If @adcIdCodeTrc in ( 19 )
	BEGIN
		Select  @dtFinValMdp = Convert ( DateTime, sysadm.FN_CLE_VAL ( 'DTE_FIN_VAL_MDP_BTQ', rtrim ( IsNull ( info_spb_frn_cplt, '' ) ), ';')),
			@iIdSeq = c.id_seq,
			@dcIdProd = s.id_prod,
		        @dcIdGti = c.id_gti,
			@dcMtPec = c.mt_ttc_cmde,
			@asMdp = sysadm.FN_TRIM ( d.val_car )

		From    sysadm.sinistre s,
		        sysadm.commande c,
			sysadm.div_sin d

		Where   s.id_sin = @adcIdSin
		and     d.id_sin = s.id_sin
		and     d.nom_zone = 'mdp_net_boutique'
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBB'
		and     c.cod_etat = 'ANN'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )
		


		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcRempl = 0
		Set @sNumSerieRempl = null
		Set @sMajPar = @asMajPar
	END

/*
 -21 : SI/mdp regénéré par GT
*/

/*
  -1 : SI/Trop peu mobile dispo fct plaf
  +27 : WI/Presta Web passé par GT
*/
If @adcIdCodeTrc in ( 27 )
	BEGIN

		Select  @dcIdProd = s.id_prod
		From    sysadm.w_sin s
		Where   s.id_sin = @adcIdSin

		Set @iIdSeq = null
		Set @dcIdGti = Convert ( Decimal (7), sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'GTI', @asBrowser, ';' ) ) )
		Set @dcMtPec = Convert ( Decimal (11,2), sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'MT_PLAF', @asBrowser, ';' ) ) )
		Set @asBrowser = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcRempl = 0
		Set @sNumSerieRempl = null
		Set @sMajPar = @asMajPar
	END



Insert into sysadm.trace_cmde_web_btq (
	   id_session,
	   cas_produit,
	   id_sin,
	   mdp,
	   nom,
	   dte_fin_val_mdp,
	   id_seq,
	   id_prod,
	   id_gti,
	   id_typ_trc,
	   id_code_trc,
	   gravite,
	   id_appli,
	   etape,
	   id_mess,
	   mt_pec,
	   id_marq_cmde,
	   id_modl_cmde,
	   num_serie_rempl,
	   mt_achat_rempl,
	   code_vendeur,
	   code_mag,
	   browser,
	   val_car,
	   cree_le,
	   maj_le,
	   maj_par
	)

	Values
	(
	@asIdSession,
	@asCasProduit,
	@adcIdSin,
	@asMdp,
	@asNom,
	@dtFinValMdp,
	@iIdSeq,
	@dcIdProd,
	@dcIdGti,
	@sIdTypTrc,
	@adcIdCodeTrc,
	@asGravite,
	@asIdAppli,
	@asEtape,
	@aiIdMess,
	@dcMtPec,
	@sIdMarqCmde,
	@sIdModlCmde,
	@sNumSerieRempl,
	@dcMtTtcRempl,
	@asCodeVendeur,
	@asCodeMagasin,
	@asBrowser,
	@asValCar,
	getdate(),
	getdate(),
	@sMajPar
	)

GO
