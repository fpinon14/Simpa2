-------------------------------------------------------------------
--
-- Fichier              :       TRACE_CMDE_WEB.CP
-- Auteur               :       DGA/JFF
-- Date                 :       02/2007
--
-- Commentaires         :       Gestion des commandes pour l'extranet
-------------------------------------------------------------------
-- PS_I01_TRACE_CMDE_V01       	JFF 19/04/2007    Insertion dans la table de trace_cmde_web
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Procedure            :       PS_I01_TRACE_CMDE_V01
-- Auteur               :       FABRY JF
-- Date                 :       19/04/2007 
-- Libelle              :        [SITE_CMDE]
-- Commentaires         :       Insertion dans la table de trace_cmde_web
--                               
-- References           :       
--
-- Arguments            :       @asIdSession     varchar(30),
-- 				@asBrowser       varchar(200),
-- 				@adcIdSin	Decimal (7),
-- 				@asNumTel        varchar(10),
-- 				@asMdp           varchar(6),
-- 				@adcIdCodeTrc    Decimal(7),
-- 				@asGravite       varchar(10),
-- 				@asIdAppli       varchar(5),
-- 				@asEtape         varchar(20),
-- 				@aiIdMess        integer,
-- 				@asMajPar	 VarChar ( 4 )
--
-- Retourne             :       Integer                 >0 = Il y a des dispos
--                                                      -1 = aucune dispo
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      21/06/2016   [PM284-2]
-- JFF      07/08/2019   [PM462-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRACE_CMDE_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_I01_TRACE_CMDE_V01
GO

CREATE PROCEDURE        sysadm.PS_I01_TRACE_CMDE_V01
	@asIdSession     varchar(30),
	@asBrowser       varchar(200),
	@adcIdSin	Decimal (10),  -- [PI062]
	@asNumTel        varchar(10),
	@asMdp           varchar(6),
	@adcIdCodeTrc    Decimal(7),
	@asGravite       varchar(10),
	@asIdAppli       varchar(5),
	@asEtape         varchar(20),
	@aiIdMess        integer,
	@asMajPar	 VarChar ( 4 )

As

Declare	@sMajPar        varchar(4)
Declare	@sIdFourCmde    varchar(3)
Declare	@sIdMarqCmde    varchar(35)
Declare	@sIdModlCmde    varchar(35)
Declare	@dcMtTtcCmde    decimal(11,2)
Declare	@dcMtPlaf       decimal(11,2)
Declare	@dcIdProd	Decimal ( 7 )
Declare	@dcIdGti	Decimal ( 7 )
Declare @sIdTypTrc 	varchar ( 3 )
Declare @iIdSeq		integer
Declare @dtMajMdp	DateTime

Set @sIdTypTrc = '-TR'

Set @sMajPar = 'AUTO' -- [PM462-1]

/*
   2 : WI/Utilisation maintenance images 
   3 : WI/Utilisation Test DIT
   4 : WI/Sinistre non valide
  15 : WE/Validation imposs. div. raisons
  16 : WE/Imp envoi mail push conf
*/
If @adcIdCodeTrc in (  2, 3, 4, 15, 16  )
	BEGIN
		Set @dtMajMdp = null
		Set @iIdSeq = null
		Set @dcIdProd = null
		Set @dcIdGti = null
		Set @dcMtPlaf = 0
		Set @sIdFourCmde = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcCmde = 0
		Set @sMajPar = 'SPB'
	END

/*
   7 : WI/Cmde déjà passée en cours de trt
  17 : WI/Validation cmde par assuré
*/
If @adcIdCodeTrc in (  7, 17  )

	BEGIN
		Select  @dtMajMdp = d.maj_le,
			@iIdSeq = c.id_seq,
			@dcIdProd = s.id_prod,
		        @dcIdGti = c.id_gti,
			@dcMtTtcCmde = c.mt_ttc_cmde,
			@sIdFourCmde = c.id_four,
			@sIdMarqCmde = c.id_marq_art_ifr,
			@sIdModlCmde = c.id_modl_art_ifr

		From    sysadm.sinistre s,
		        sysadm.commande c,
				sysadm.div_sin d
                Where   s.id_sin = @adcIdSin
                and	d.id_sin = s.id_sin
		and     d.nom_zone = 'mdp_net'
		and     c.id_sin = s.id_sin
                and     c.cod_etat in ( 'ECT' ) 
                and     c.id_seq = (    Select max ( c2.id_seq ) 
                                        From sysadm.commande c2
                                        Where c2.id_sin = c.id_sin
                                        and   c2.id_four = c.id_four
                                        and   c2.cod_etat = c.cod_etat )
		
		Set @dcMtPlaf = 0
		Set @sMajPar = 'ASSU'
	END

/*
   5 : WI/Presence travail
   6 : WI/Num portable non valide
   8 : WI/Dossier clos
   9 : WI/Pas de cmde WEB dispo
*/
If @adcIdCodeTrc in (  5, 6, 8, 9 )
	BEGIN

		Select  @dcIdProd = s.id_prod
		From    sysadm.sinistre s
		Where   s.id_sin = @adcIdSin

		Set @iIdSeq = null
		Set @dcIdGti = null
		Set @dcMtPlaf = 0
		Set @sIdFourCmde = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcCmde = 0
		Set @sMajPar = 'ASSU'
	END

/*
  10 : WE/Prble Param delai mdp
  11 : WE/mdp absent sur dossier
  12 : WI/durée validité mdp expirée
  13 : WI/mdp erroné
  14 : WI/Trop peu mobile dispo fct plaf
  20 : WI/Connexion établie
*/
If @adcIdCodeTrc in ( 10, 11, 12, 13, 14, 20 )
	BEGIN
		Select  @dtMajMdp = d.maj_le,
			@iIdSeq = c.id_seq,
			@dcIdProd = s.id_prod,
		        @dcIdGti = c.id_gti,
			@dcMtPlaf = c.mt_ttc_cmde
		From    sysadm.sinistre s,
		        sysadm.commande c,
			sysadm.div_sin d

		Where   s.id_sin = @adcIdSin
                and	d.id_sin = s.id_sin
		and     d.nom_zone = 'mdp_net'
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBA'
		and     c.cod_etat = 'CWE'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )
		

		Set @sIdFourCmde = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcCmde = 0
		Set @sMajPar = 'ASSU'
	END

/*
  18 : SI/Cmde Web activé par GT
*/
If @adcIdCodeTrc in ( 18 )
	BEGIN
		Select  @dtMajMdp = d.maj_le,
			@iIdSeq = c.id_seq,
			@dcIdProd = s.id_prod,
		        @dcIdGti = c.id_gti,
			@dcMtPlaf = c.mt_ttc_cmde,
			@asNumTel = sysadm.FN_TRIM ( s.num_port ),
			@asMdp = sysadm.FN_TRIM ( d.val_car )

		From    sysadm.w_sin s,
		        sysadm.w_commande c,
			sysadm.w_div_sin d

		Where   s.id_sin = @adcIdSin
		and     d.id_sin = s.id_sin
		and     d.nom_zone = 'mdp_net'
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBA'
		and     c.cod_etat = 'CNV'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )
		

		Set @sIdFourCmde = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcCmde = 0
		Set @sMajPar = @asMajPar
	END

/*
  19 : SI/Cmde Web annulé par GT
*/
If @adcIdCodeTrc in ( 19 )
	BEGIN
		Select  @dtMajMdp = d.maj_le,
			@iIdSeq = c.id_seq,
			@dcIdProd = s.id_prod,
		        @dcIdGti = c.id_gti,
			@dcMtPlaf = c.mt_ttc_cmde,
			@asNumTel = sysadm.FN_TRIM ( s.num_port),
			@asMdp = sysadm.FN_TRIM ( d.val_car )

		From    sysadm.sinistre s,
		        sysadm.commande c,
			sysadm.div_sin d

		Where   s.id_sin = @adcIdSin
		and     d.id_sin = s.id_sin
		and     d.nom_zone = 'mdp_net'
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBA'
		and     c.cod_etat = 'ANN'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )
		

		Set @sIdFourCmde = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcCmde = 0
		Set @sMajPar = @asMajPar
	END

/*
  21 : SI/mdp regénéré par GT
*/
If @adcIdCodeTrc in ( 21 )
	BEGIN
		Select  @dtMajMdp = d.maj_le,
			@iIdSeq = c.id_seq,
			@dcIdProd = s.id_prod,
		        @dcIdGti = c.id_gti,
			@dcMtPlaf = c.mt_ttc_cmde,
			@asNumTel = sysadm.FN_TRIM ( s.num_port ),
			@asMdp = sysadm.FN_TRIM ( d.val_car )

		From    sysadm.w_sin s,
		        sysadm.w_commande c,
			sysadm.w_div_sin d

		Where   s.id_sin = @adcIdSin
		and     d.id_sin = s.id_sin
		and     d.nom_zone = 'mdp_net'
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBA'
		and     c.cod_etat = 'CWE'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )
		

		Set @sIdFourCmde = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcCmde = 0
		Set @sMajPar = @asMajPar
	END

/*
   1 : SI/Trop peu mobile dispo fct plaf
*/
If @adcIdCodeTrc in ( 1 )
	BEGIN

		Select  @dcIdProd = s.id_prod
		From    sysadm.w_sin s
		Where   s.id_sin = @adcIdSin

		Set @iIdSeq = null
		Set @dcIdGti = Convert ( Decimal (7), sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'GTI', @asBrowser, ';' ) ) )
		Set @dcMtPlaf = Convert ( Decimal (11,2), sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'MT_PLAF', @asBrowser, ';' ) ) )
		Set @asBrowser = null
		Set @sIdFourCmde = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcCmde = 0
		Set @sMajPar = @asMajPar
	END

/*
  29 : WI/Cmde annulé par ass pour Dde Rbt
*/
If @adcIdCodeTrc in ( 29 )
	BEGIN
		Select  @dtMajMdp = d.maj_le,
				@iIdSeq = c.id_seq,
				@dcIdProd = s.id_prod,
		        @dcIdGti = c.id_gti,
				@dcMtPlaf = c.mt_ttc_cmde
		From    sysadm.sinistre s,
		        sysadm.commande c,
				sysadm.div_sin d

		Where   s.id_sin = @adcIdSin
                and	d.id_sin = s.id_sin
		and     d.nom_zone = 'mdp_net'
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBA'
		and     c.cod_etat = 'ANN'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )
		

		Set @sIdFourCmde = null
		Set @sIdMarqCmde = null
		Set @sIdModlCmde = null
		Set @dcMtTtcCmde = 0
		Set @sMajPar = 'ASSU'
	END

Insert into sysadm.trace_cmde_web (
	id_session,
	id_sin,
	num_tel,
	mdp,
	dte_maj_mdp,
	id_seq,
	id_prod,
	id_gti,
	id_typ_trc,
	id_code_trc,
	gravite,
	id_appli,
	etape,
	id_mess,
	mt_plaf,	
	id_four_cmde,
	id_marq_cmde,
	id_modl_cmde,
	mt_ttc_cmde,
	browser,
	cree_le,
	maj_le,
	maj_par
	)

	Values
	(
	@asIdSession,
	@adcIdSin,
	@asNumTel,
	@asMdp,
	@dtMajMdp,
	@iIdSeq,
	@dcIdProd,
	@dcIdGti,
	@sIdTypTrc,
	@adcIdCodeTrc,
	@asGravite,
	@asIdAppli,
	@asEtape,
	@aiIdMess,
	@dcMtPlaf,
	@sIdFourCmde,
	@sIdMarqCmde,
	@sIdModlCmde,
	@dcMtTtcCmde,
	@asBrowser,
	getdate(),
	getdate(),
	@sMajPar
	)

Go

