-------------------------------------------------------------------
--
-- Fichier              :       PS_U01_COMMANDE.CP
-- Auteur               :       Fabry Jf
-- Date                 :       08/08/18
--
-- Commentaires         :       Gestion de la PS PS_U01_COMMANDE
--
--------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       PS_U01_COMMANDE
-- Auteur               :       Fabry JF
-- Date                 :       04/10/01
-- Libelle              :        
-- Commentaires         :       Update la table COMMANDE 
-- References           :       Suivi des commandes
--
--								[THE_PS]
-- Retourne             :       Rien
-- MAJ			: 
-- #1  28/10/2003 JF  Ajout de "	And    id_four <> 'ASF'"  nécessaire pour ARVATO
-- #2  PHG 22/03/2007 [DCMP070191] Gestion de l'enregistrement du Maj_le
-- #3  PHG 05/12/2007 [O2M] Ajout enregistrement ID_ORIAN_MODELE
--		     [O2M] Création Contact travail + mail
-- #4  PHG 21/03/2008 Appel SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01
--		     ald   SIMPA2_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01
-- #5  PHG 24/04/2008 [DCMP080199]Ajout Nom Transporteur dans champs "adrfc_nom"
-- #6  JFF 15/05/2008 [DCMP080077]Gestion des codes alphanumérique des le commentaire frn.
-- #7  JFF 08/07/2008 [DCMP080077].BUG1 Le charindex sur une chaine null ne renvoie pas 0, mais null.
-- #8  PHG 04/08/2008 [DCMP080583] Si le code etat existant est RPC ou ANN, la commande est non modifiable.
-- #9  JFF 09/09/2008 [MICROMANIA] ajout de la marque, modèle, prix ttc
-- #10 PHG 22/10/2008 [DCMP080697] Duplication du process Bris Visible Irreparable Economique ( BVIE ) vers
--				   le process Bris Non Visible (BNV)
-- #11 JFF 20/10/2008 [FNAC_PROD_ECH_TECH]
-- #12 JFF 20/10/2008 [FNAC_PROD_ECH_TECH].[20090127140540720]
-- #13 JFF 14/05/2009 [DCMP090085]
-- #14 JFF 14/05/2009 [DCMP090282]
-- #15 JFF 02/09/2009 [DCMP090327].[SBETV]
-- #16 JFF 06/11/2009 [FRAIS_O2M]
-- #17 JFF 30/12/2009 [MSS_DIAG]
-- #18 JFF 13/01/2010 [DCMP090594]
-- #19 JFF 27/01/2010 [DCMP100066]
--     JFF 01/03/2010 [MSS_LOT2]
--     FPI 17/03/2010  [DMDI28514] Autres destinataires de refus de cmd Micromania
--     FPI 06/04/2010 [CORR_FPI_06032010] Correction sur rejet fichier MPR O2M
--     EMD 25/06/2010 [DCMP100420] Agrandissement du numéro de série
--     FPI 23/08/2010 [PC482]
--     FPI 23/08/2010 [PC482]
--     FPI 11/08/2010 [PM01] Ajout des status GC 167,168
--     JFF 17/05/2011 [PC501]-1
--     JFF 17/05/2011 [PC292]
--     JFF 19/09/2011 [PM82][LOT1]
--     JFF 19/09/2011 [PM82][LOT2]
--     JFF 13/02/2012 [VDOC6449]
--     JFF 13/04/2012 [DCMP100146][VDOC7456]
--     JFF 17/04/2012 [PM200][LOT2][DESOX]
--     FPI 04/07/2012 [DT011]
--     JFF 06/08/2012 [BLCODE]
--     JFF 06/08/2012 [RECUPDONN_MANTIS4252]
--     JFF 06/09/2012 [VDOC7912]
--	   FPI 13/09/2012 [VDOC8537] Allongement de la colonne id_bon_transp de 20 à 35
--     JFF 26/11/2012 [PC877]
--     JFF 02/04/2013 [PC929_CDISCOUNT]
--     JFF 07/05/2013 [PC938_ORANGE_V3]
--     JFF 07/05/2013 [PC929-1]
--     JFF 19/11/2013 [DT_60_AUGM_TVA]
--     JFF 30/12/2013 [PC13348&13408]
--     JFF 14/01/2014 [PM246]
--     JFF 28/03/2014 [DT081_EVOL_PRET_BRIS]
--     JFF 07/05/2013 [PM250-1]
--     JFF 07/05/2013 [MANTIS11520][PC13419]
--     JFF 14/08/2014 [VDOC14899] @sMajParCmdActuel par 'PRS'
--     JFF 18/08/2014 [PM254_V1]
--     JFF 02/10/2014 [VDOC15485]
--     JFF 19/11/2014 [VDOC15650]
--     JFF 25/11/2014 [PM251-2]
--     JFF 12/12/2014 [PC13321]
--	   JFF 18/02/2015 [PC801-6][MANTIS14177] 
--     JFF 02/03/2015 [PM289_CDP]
--	   JFF 09/09/2013 [PM222-1]
--     JFF 09/04/2015 [DT141]
--     JFF 21/05/2015 [VDOC17414]
--     JFF 15/06/2015 [DT154]
--     JFF 30/06/2015 [DT156]
--     JFF 20/07/2015 [DT150]
--     JFF 05/02/2016 [VDOC19868]
--     JFF 31/03/2016 [PM287-3]
--     JFF 19/04/2016 [DT209]
--	   FPI 12/05/2016 [DT111]
--     JFF 17/05/2016 [PM280-2]
--     JFF 21/06/2016 [PM284-2]
--     JFF 12/02/2016 [PI062]
--	   JFF 02/11/2016 [DT276]
--     JFF 21/11/2016   [DT280]
--     JFF 23/01/2017   [DT290]
--     JFF 21/02/2107   [DT288]
--     JFF 22/02/2107   [PM288-1][LOT2][PM287-3][M25172]
--     JFF 29/08/2017   [DT288-3_LOT1_2EME_VS]
--     JFF 18/09/2017   [DT288-3_LOT2]
--     JFF 29/09/2017   [VDOC24784]
--     JFF 20/12/2017   [PM426-3]
--     JFF 03/01/2018   [VDOC25366]
--     JFF 17/04/2018   [DT288-4]
--	   JFF 31/07/2018   [DT363]
--	   JFF 09/08/2018   [VDoc26518]
--     JFF 01/10/2018   [PM445-1]
--     JFF 21/11/2018   [VDOC27123]
--     JFF 26/11/2018   [PC874_2_V1]
--     JFF 28/01/2019   [PM450-1]
--     JFF 01/04/2019   [PM421-6]
--     JFF 02/09/2019   [DT424]
--     JFF 04/10/2019   [PM462-1][V3]
--     JFF 22/10/2019   [PI087_PM473_2]
--	   JFF 19/12/2022   [RS4093_EVOL_ELD]
--	   JFF 20/02/2023   [RS4616_RET_TLS]
--	   JFF 06/04/2023   [PMO139_RS4926]
--     JFF 26/04/2023   [RS5045_REF_MATP]
--     JFF 30/05/2023   [PMO89_RS4822]
--     JFF 07/03/2024   [HP252_276_HUB_PRESTA]
--     JFF 04/11/2024   [20241104105246567]
--     JFF 27/02/2025   [20250227094634600]
--     JFF 31/03/2025   [MIG82_JOURN_EVT]
--	   JFF 23/04/2025   [HUB1267]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.PS_U01_COMMANDE
GO

CREATE procedure sysadm.PS_U01_COMMANDE
	@dcIdSin        Decimal (  10,0 ), -- [PI062]
	@iIdSeq		Integer		,
	@iIdCmdFrn	VarChar ( 20 )	,
	@iIdSerieNouv	VarChar ( 60 )	,
	@dtDteRcpFrn	DateTime	,
	@dtDteEnvCli	DateTime	,
	@idBonTransp	VarChar ( 35 )	, -- [VDOC8537]
	@sCodEtat	VarChar ( 3 )	,
	@sCommentFrn	VarChar ( 255 )	, 
	@iIdBsp		Integer		,
	@dtDteRetPret	DateTime	,
	@dtDteElvMobile DateTime	,
	@iStatusGc	Integer		,
	@dtDteEmisDevis DateTime	,
	@dcMtDevis      Decimal (11,2)  ,
	@sAltDevAcp	VarChar ( 1 )	,
	@dtDteDevAcp	DateTime	,
	@dtDteRetLogis	DateTime	,
	@dtDteRetPretMin	DateTime	,
	@dtDteRetPretMax	DateTime	,
	@dtDteEnvBteFrn	DateTime	,
	@dtDteRcpBteCli	DateTime	,
	@dtDteDepBteCli	DateTime	,
	@dtDteEnvSt	DateTime	,
	@dtDteRcpMobCli	DateTime	,
	@iIdOrianModele	Integer		,	-- #3 PHG 05/12/2007 [O2M]
	@sAdrFcNom	varchar(35)     ,	-- #5 PHG 24/04/2008 [DCMP080199]
	@sMarq		varchar(35)	,	-- #9 JFF 09/09/2008 [MICROMANIA]
	@sModl		varchar(35)	,	-- #9 JFF 09/09/2008 [MICROMANIA]
	@dcPrixTTC	Decimal (11,2)  ,	-- #9 JFF 09/09/2008 [MICROMANIA]
	@sInfoFrnSpbCplt varchar (800) 		-- #11 JFF 20/10/2008 [FNAC_PROD_ECH_TECH]	
AS

Declare @sIdSerieNouvActuel	VarChar (60)
Declare @sCodEtatActuel		VarChar ( 3 )
Declare @sIdFour		VarChar ( 3 )
Declare @sIdTypArt		VarChar (3)
Declare @dtTimeStamp		datetime
Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @sObjet			VarChar ( 200 )
Declare @sIdRefFour		VarChar ( 20 )	-- #3 PHG 12/12/2007 [O2M]
Declare @iIdCt			integer		-- #3 PHG 12/12/2007 [O2M]
Declare @sCommentFrnActuel	Varchar(255) -- #6 [DCMP080077]
Declare @sMajParCmdActuel       Varchar(4) -- #6 [DCMP080077]
Declare @sIRR			VarChar(2) -- #6 [DCMP080077]
Declare @dcIdGti                Decimal (  7,0 ) -- #6 [DCMP080077]
Declare @dcIdDetail             Decimal (  7,0 ) -- #6 [DCMP080077]
Declare	@sInfoFrnSpbCpltActuel  varchar (800) 	-- #11 JFF 20/10/2008 [FNAC_PROD_ECH_TECH]	
Declare	@sInfoSpbFrnCpltActuel  varchar (800) 	-- [PC501]-1
Declare @iRech1			Integer -- #11 JFF 20/10/2008 [FNAC_PROD_ECH_TECH]	
Declare @iRech2			Integer -- #11 JFF 20/10/2008 [FNAC_PROD_ECH_TECH]	
Declare @sCle1			VarChar ( 50 ) -- #11 JFF 20/10/2008 [FNAC_PROD_ECH_TECH]	
Declare @sCleMinus		VarChar ( 50 ) -- [PM254_V1]
Declare @sVal1			VarChar ( 300 ) -- #11 JFF 20/10/2008 [FNAC_PROD_ECH_TECH]	
Declare @iStatusGCActuel        Integer -- #12 [FNAC_PROD_ECH_TECH].[20090127140540720]
Declare @sValChoixPack		VarChar ( 35 ) -- #14 JFF 14/05/2009 [DCMP090282]
Declare @dcIdProd               Decimal (  7,0 ) -- #14 JFF 14/05/2009 [DCMP090282]
Declare @sLibFour		VarChar ( 35) -- #15 JFF 02/09/2009 [DCMP090327].[SBETV]
Declare @dtDteRcpFrnActuel 	DateTime  -- #16 JFF 06/11/2009 [FRAIS_O2M]
Declare @iInfoSpbFrnActuel	Integer   -- #16 JFF 06/11/2009 [FRAIS_O2M]
Declare @dtDteEnvCliActuel 	DateTime  -- [VDOC24784]
Declare @sCasRetour		VarChar (50) -- [PC482]
Declare @sDbName  		VarChar ( 20 ) -- [PC482]
Declare @iDp179			Integer -- [PC292]
Declare @sPoint		Varchar ( 1 ) -- [VDOC6338]
Declare @iRet			Integer -- [DT011]
Declare @iCasPropoAutoO2m  Integer -- [PC877]
Declare @iCasPropoAutoAas  Integer -- [DT363]
Declare @dcNewIdDetail		Decimal ( 7 ) -- [PC877]
Declare @iNewIdSeq Integer -- [PC877]
Declare @iCasPropoAutoVpp Integer --  [PC929_CDISCOUNT]
Declare @iTrv Integer -- [PM246]
Declare @dcMtPecPlaf Decimal ( 11,2 ) -- [MANTIS11520][PC13419]
Declare @dcIdRev decimal ( 7 ) -- [MANTIS11520][PC13419]
Declare @sNomFicFrn VarChar ( 100 ) -- [PM254_V1]
Declare @sCdvCodEta VarChar ( 1 ) -- [PM289_CDP]
Declare @sEveCodEta VarChar ( 1 ) -- [PM289_CDP]
Declare @sCasAnoCdp VarChar (10) -- [PM289_CDP]
Declare @asIdAppli	varchar (20) -- [DT141]
Declare @asBase		varchar (20) -- [DT141]
Declare @iTraite	integer -- [DT141]
Declare @asCasRetour VarChar ( 50 )
Declare @idBonTranspActuel 	VarChar ( 35 ) -- [VDOC19112]	
Declare @sVal2		VarChar ( 300 ) 
Declare @iCasDT276SwapCTR Integer -- [DT276]
Declare @sTypeAppSin VarChar ( 3 ) -- [DT276]
Declare @iStopMajAdhMobRempl Integer
Declare @sVal3 Varchar ( 300 )
Declare @dtDteWork DateTime
Declare @dtDteRcpMobCliActuel DateTime
Declare @dtDteRcpMobCliActuelBCV DateTime
Declare @sTypAppSin Varchar ( 20 )
Declare @lVal Integer
Declare @sMtPaiementPayBox varchar ( 50 )
Declare @sNumCCElDRet VarChar ( 30 )
Declare @dcMtTTCcmde Decimal ( 11, 2 ) 
Declare @sMarqRempl Varchar ( 35 ) -- [RS4616_RET_TLS]
Declare @sModlRempl Varchar ( 35 ) -- [RS4616_RET_TLS]
Declare @sCoulRempl Varchar ( 35 ) -- [RS4616_RET_TLS]
Declare @sCapStkRempl Varchar ( 35 ) -- [RS4616_RET_TLS]
Declare @sNewIdRefFour VarChar ( 20 ) -- [RS4616_RET_TLS]
Declare @sNewIdRefFourTest VarChar ( 20 ) -- [RS4616_RET_TLS]
Declare @iCptId Integer -- [RS4616_RET_TLS]
Declare @sNomInter VarChar ( 71 )
Declare @dcIdInter Decimal (2 )
Declare @sCodInter Varchar ( 5 )
Declare @iPrestaHUB Integer
Declare @TypArtIfr VarChar ( 255 ) -- [HP252_276_HUB_PRESTA]
Declare @iMarqModlIFr Integer -- [HP252_276_HUB_PRESTA]
Declare @iDemandeSavHubPresta Integer -- [HP252_276_HUB_PRESTA]
Declare @iDemandeAutoPECRAR Integer -- [HP252_276_HUB_PRESTA]
Declare @dcIdEvt Decimal ( 7 ) -- [HP252_276_HUB_PRESTA]
Declare @iNbreSavActuel Integer -- [HP252_276_HUB_PRESTA]
Declare @sCasSav VarChar ( 30 ) -- [HP252_276_HUB_PRESTA]
Declare @sPrestaAutoHub  VarChar ( 35 )-- [HP252_276_HUB_PRESTA]
Declare @sDernIdRefFour VarChar ( 20 ) -- [HP252_276_HUB_PRESTA]
Declare @dtDteSource DateTime
Declare @iPJOMMC Integer  -- Prochain jour ouvré sur le même mois calendaire ? 1:Oui, 0: Non
Declare @dtDtePossible DateTime -- Prochaine date possible pour passer le règlement
Declare @sVal VarChar ( 100 )
Declare @sVar VarChar ( 255 )
Declare @iRemplacementAutomatiqueHub Integer  

Set @iCasPropoAutoO2m = 0 -- [PC877]
Set @iTraite = 0 
Set @iStopMajAdhMobRempl = 0 
Set @iDemandeSavHubPresta = IIF ( sysadm.FN_CLE_VAL ( 'DDE_SAV', @sInfoFrnSpbCplt, ';' ) = 'OUI', 1, 0) -- [HP252_276_HUB_PRESTA]
Set @iNbreSavActuel = IIF ( IsNumeric ( sysadm.FN_CLE_VAL ( 'NBRE_SAV_ACTUEL', @sInfoFrnSpbCplt, ';' ) ) = 1, 
								Convert ( integer, sysadm.FN_CLE_VAL ( 'NBRE_SAV_ACTUEL', @sInfoFrnSpbCplt, ';' )),
								0
						  ) -- [HP252_276_HUB_PRESTA]
Set @iDemandeAutoPECRAR = IIF ( sysadm.FN_CLE_VAL ( 'AUTO_PEC_RAR', @sInfoFrnSpbCplt, ';' ) = 'OUI', 1, 0) -- [HP252_276_HUB_PRESTA]
Set @sPrestaAutoHub = sysadm.FN_CLE_VAL ( 'PRESTA_AUTO', @sInfoFrnSpbCplt, ';' )
Set @iRemplacementAutomatiqueHub = IIF ( sysadm.FN_CLE_VAL ( 'CMDE_REMPL_AUTO', @sInfoFrnSpbCplt, ';' ) = 'OUI', 1, 0) -- [HUB1267]

-- #2 PHG 22/03/2007 [DCMP070191] Gestion de l'enregistrement du Maj_le
Set @dtTimeStamp = GetDate()
Set @asIdAppli = 'SIMPA2'
Set @asBase = ( Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) ))

Set @sIRR = '' -- #6 [DCMP080077]

-- [PM254_V1]
Set @sNomFicFrn = IsNull ( sysadm.FN_CLE_VAL ( 'NOM_FIC_FRN', @sInfoFrnSpbCplt, ';' ), '' )
Set @sInfoFrnSpbCplt = Replace ( @sInfoFrnSpbCplt, 'NOM_FIC_FRN=' + @sNomFicFrn, '' )
Set @sInfoFrnSpbCplt = Replace ( @sInfoFrnSpbCplt, ';;' , ';' )
If LEFT ( @sInfoFrnSpbCplt, 1 ) = ';' Set @sInfoFrnSpbCplt = RIGHT ( @sInfoFrnSpbCplt, LEN ( @sInfoFrnSpbCplt ) - 1 )
Set @sNomFicFrn = UPPER ( @sNomFicFrn )

-- [DT363]
Select 	@sTypAppSin = sysadm.FN_TRIM ( IsNull ( ds.val_car, '' ) )
From 	sysadm.div_sin ds
Where 	ds.id_sin = @dcIdSin And ds.nom_zone = 'type_app'
If @sTypAppSin is null Set @sTypAppSin = ''

/* Si la commande est d‚j… annul‚e, le code ‚tat ne peut plus changer */
If ( Select count (*)
     From   sysadm.w_commande
     Where  id_sin = @dcIdSin
     And    id_seq = @iIdSeq
     And    cod_etat = 'ANN' 
     And    id_four <> 'ASF' ) > 0 -- #1 JFF 28/10/2003 
     
     Begin
     	Select @sCodEtat = 'ANN'
     End 

If ( Select count (*)
     From   sysadm.w_commande
     Where  id_sin = @dcIdSin
     And    id_seq = @iIdSeq
     And    cod_etat = 'RPC' 
     And    id_four <> 'ASF' ) > 0 
     
     Begin
        Select @sCodEtat = 'RPC'
     End 

/* JFF le 08/06/2004 : On n'écrit dte_rcp_frn que si la valeur fourni par
le fournisseur n'est pas null. Cela en vu des réglements auto
avec A-NOVO afin d'éviter tout réglement en double sur la remise à null
d'une dte_rcp_frn dans un fichier reçu d'A-NOVO. A-NOVO peut donc
modifier la date, mais s'ils la remettent à null, on n'en tiendra pas compte */

/* DCMP 050514/ 30/12/2005/JFF : Sav de l'imei actuel sur le dossier */
Select  @sIdSerieNouvActuel = c.id_serie_nouv,
	@sIdTypArt = c.id_typ_art,
	@sCodEtatActuel = c.cod_etat,
	@sIdFour = c.id_four,
	@sIdRefFour = c.id_ref_four,	-- #3 PHG 12/12/2007 [O2M]
	@sCommentFrnActuel = c.comment_frn, -- #6 [DCMP080077]
	@sMajParCmdActuel = c.maj_par, -- #6 [DCMP080077]      
	@dcIdGti = c.id_gti, -- #6 [DCMP080077]
	@dcIdDetail = c.id_detail, -- #6 [DCMP080077]
	@sInfoSpbFrnCpltActuel = IsNull ( rtrim ( c.info_spb_frn_cplt ), ''), -- [PC501]-1
	@sInfoFrnSpbCpltActuel = IsNull ( rtrim ( c.info_frn_spb_cplt ), '' ), -- #11 [FNAC_PROD_ECH_TECH]	
	@iStatusGCActuel = c.status_gc, -- #12 [FNAC_PROD_ECH_TECH].[20090127140540720]
	@dcIdProd = s.id_prod, -- #14 JFF 14/05/2009 [DCMP090282]
	@dcIdRev = s.id_rev, -- [MANTIS11520][PC13419]
	@dtDteRcpFrnActuel = c.dte_rcp_frn, -- #16 JFF 06/11/2009 [FRAIS_O2M]
	@iInfoSpbFrnActuel = c.info_spb_frn, -- #16 JFF 06/11/2009 [FRAIS_O2M]
	@idBonTranspActuel = c.id_bon_transp, -- [VDOC19112]
	@dtDteEnvCliActuel	= c.dte_env_cli, -- [VDOC24784]
	@dtDteRcpMobCliActuel = c.dte_rcp_mob_cli, -- [VDOC24784]
	@dtDteRcpMobCliActuelBCV = sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', c.info_frn_spb_cplt, ';'), -- [VDOC24784]
	@sMtPaiementPayBox  = sysadm.FN_CLE_VAL ( 'MT_CPLT_PAYBOX_SCM', c.info_spb_frn_cplt, ';' ) -- [PM462-1][V3]
From	sysadm.commande c,
	sysadm.sinistre s
Where   c.id_sin = @dcIdSin
And 	c.id_seq = @iIdSeq
And     s.id_sin = c.id_sin

If IsNumeric ( @sMtPaiementPayBox ) = 0 Set @sMtPaiementPayBox = '0'
Set @iPrestaHUB = IIF ( Len ( sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', @sInfoSpbFrnCpltActuel, ';' ) ) > 0, 1, 0 ) -- [HP252_276_HUB_PRESTA]

-- [VDOC25366]
If @dtDteEnvCliActuel is not null
	Begin
		Set @dtDteEnvCli = @dtDteEnvCliActuel
	End

-- [VDOC24784]
If @dtDteRcpFrn is not null And @dtDteRcpFrnActuel is null
	Begin
	If DateDiff ( day, @dtDteRcpFrn, GetDate()) > 5 
		Begin
		Set @sMess = 'Presta ' + convert ( varchar (10), @dcIdSin ) + '-' + convert ( varchar (10), @iIdSeq ) + ': La date de réception de l''appareil en CTR renvoyée par le fournisseur (' 
		Set @sMess = @sMess + convert ( varchar(10), @dtDteRcpFrn, 103 ) + ') est antérieure à plus de 5 jours par rapport au présent jour d''intégration de la donnée en base ('
		Set @sMess = @sMess +  convert ( varchar(10), getdate(), 103 ) + '), elle sera donc ajustée en base au : '  
			
		Set @dtDteRcpFrn = DateAdd ( day, -5, GetDate() ) 

		Set @sMess = @sMess +  convert ( varchar(10), @dtDteRcpFrn, 103 ) + '.'  

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT							
		END
		ELSE
		BEGIN
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT							
		END	

		End 
	End 

If @dtDteEnvCli is not null And @dtDteEnvCliActuel is null 
	And @iStatusGc not in ( 621, 622 )
	Begin
	If DateDiff ( day, @dtDteEnvCli, GetDate()) > 5 
		Begin
		Set @sMess = 'Presta ' + convert ( varchar (10), @dcIdSin ) + '-' + convert ( varchar (10), @iIdSeq ) + ': La date de traitement (ou envoi de l''appareil chez l''assuré), renvoyée par le fournisseur (' 
		Set @sMess = @sMess + convert ( varchar(10), @dtDteEnvCli, 103 ) + ') est antérieure à plus de 5 jours par rapport au présent jour d''intégration de la donnée en base ('
		Set @sMess = @sMess +  convert ( varchar(10), getdate(), 103 ) + '), elle sera donc ajustée en base au : '  
			
		Set @dtDteEnvCli = DateAdd ( day, -5, GetDate() ) 

		Set @sMess = @sMess +  convert ( varchar(10), @dtDteEnvCli, 103 ) + '.'  

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT							
		END
		ELSE
		BEGIN
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT							
		END	

		End 
	End 


If @dtDteRcpMobCli is not null And ( @dtDteRcpMobCliActuel is null or @dtDteRcpMobCliActuelBCV is null or @dtDteRcpMobCliActuelBCV = '' )
	Begin
	If DateDiff ( day, @dtDteRcpMobCli, GetDate()) > 5 
		Begin
		Set @sMess = 'Presta ' + convert ( varchar (10), @dcIdSin ) + '-' + convert ( varchar (10), @iIdSeq ) + ': La date de réception de l''appareil chez l''assuré, renvoyée par le fournisseur (' 
		Set @sMess = @sMess + convert ( varchar(10), @dtDteRcpMobCli, 103 ) + ') est antérieure à plus de 5 jours par rapport au présent jour d''intégration de la donnée en base ('
		Set @sMess = @sMess +  convert ( varchar(10), getdate(), 103 ) + '), elle sera donc ajustée en base au : '  
			
		Set @dtDteRcpMobCli = DateAdd ( day, -5, GetDate() ) 

		Set @sMess = @sMess +  convert ( varchar(10), @dtDteRcpMobCli, 103 ) + '.'  

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT							
		END
		ELSE
		BEGIN
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT							
		END	
		End 
	End 

	If Len ( sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', @sInfoFrnSpbCplt, ';')) > 0 And ( @dtDteRcpMobCliActuelBCV is null or @dtDteRcpMobCliActuelBCV = '' )
	Begin
	Set @dtDteWork = sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', @sInfoFrnSpbCplt, ';')

	If DateDiff ( day, @dtDteWork , GetDate()) > 5 
		Begin
		Set @sMess = 'Presta ' + convert ( varchar (10), @dcIdSin ) + '-' + convert ( varchar (10), @iIdSeq ) + ': La date de réception de l''appareil chez l''assuré, renvoyée par le fournisseur (' 
		Set @sMess = @sMess + convert ( varchar(10), @dtDteWork, 103 ) + ') est antérieure à plus de 5 jours par rapport au présent jour d''intégration de la donnée en base ('
		Set @sMess = @sMess +  convert ( varchar(10), getdate(), 103 ) + '), elle sera donc ajustée en base au : '  
			
		Set @dtDteWork = DateAdd ( day, -5, GetDate() ) 

		Set @sMess = @sMess +  convert ( varchar(10), @dtDteWork, 103 ) + '.'  

		Set @sInfoFrnSpbCplt = sysadm.FN_CLE_VAL_E ( 'DTE_RCP_MOB_CLI', convert ( varchar(10), @dtDteWork, 103 ), rtrim ( @sInfoFrnSpbCplt), ';')

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT							
		END
		ELSE
		BEGIN
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT							
		END	
		End 
	End 
	
-- [DT276]
Select 	@sTypeAppSin = sysadm.FN_TRIM ( IsNull ( ds.val_car, '' ) )
From 	sysadm.div_sin ds
Where 	ds.id_sin = @dcIdSin And ds.nom_zone = 'type_app'

-- [ITSM425388]
If @iStatusGc in ( 159 ) and @iStatusGCActuel in ( 153, 154 ) 
	Begin
	Set @iStatusGc = @iStatusGCActuel
	End 

-- [PM289_CDP]
Select @sCasAnoCdp = sysadm.FN_CLE_VAL ( 'ANO_CDP', @sInfoFrnSpbCplt, ';' )

-- [PC13348&13408]
-- [PM246]
-- [ITSM355855] supp RSP
if @sCodEtatActuel in ( 'ANN' ) return 

-- [VDOC6338]
Set @sCommentFrnActuel = RTRIM (@sCommentFrnActuel)
If @sCommentFrnActuel is null Set @sCommentFrnActuel = ''
If @sCommentFrn is null Set @sCommentFrn = ''
Set @sPoint = '.'	
If @sCommentFrnActuel = '' 
 Begin
  Set @sPoint = ''
 End
Set @sCommentFrn = Right (  @sCommentFrnActuel + @sPoint + Convert ( VarChar (10), Getdate(), 103) + '=>' + rTrim ( @sCommentFrn ), 255 )
-- [VDOC6338]

-- #15 JFF 02/09/2009 [DCMP090327].[SBETV]
Select @sLibFour = sysadm.FN_TRIM ( sysadm.FN_CODE_CAR ( @sIdFour, '-FR' ) )
If @sLibFour is null Set @sLibFour = ''
-- :#15 JFF 02/09/2009 [DCMP090327].[SBETV]


-- #11 [FNAC_PROD_ECH_TECH]	
If @sInfoFrnSpbCplt is null Set @sInfoFrnSpbCplt = ''
If @sInfoFrnSpbCpltActuel is null Set @sInfoFrnSpbCpltActuel = '' 

Set @iRech1 = 1 
Set @iRech2 = CharIndex ( '=', @sInfoFrnSpbCplt, @iRech1 ) -- On recherche la clé (qu'on en connait pas à ce moment)
While ( @iRech1 > 0 And @iRech2 > 0 )
 Begin
	-- On isole la clé
	Set @sCle1 = Upper( Substring ( @sInfoFrnSpbCplt, @iRech1, @iRech2 - @iRech1 ))
	
	-- On en recherche la valeur associée
	Set @sVal1 = sysadm.FN_CLE_VAL ( @sCle1, @sInfoFrnSpbCplt, ';')
	
	-- On met à jour sur la chaine représentant la valeur actuelle en base
	-- #15 JFF 02/09/2009 [DCMP090327].[SBETV]
	-- [PC929-1] ajout du 21
	-- [PM246]
	-- [DT081_EVOL_PRET_BRIS]
	-- [PM251-2]
	-- [ITSM355855] RSP
	-- [PM445-1]
	If @iStatusGc in ( 301 ) Or 
	   @sCodEtatActuel in ( 'RPC', 'RFO', 'RSP' ) Or 
	   ( sysadm.FN_CLE_VAL ( 'PERTE_ALLER', @sInfoFrnSpbCplt, ';' ) = 'OUI' And sysadm.FN_CLE_VAL ( 'PERTE_ALLER', @sInfoFrnSpbCpltActuel, ';' ) <> 'OUI' ) -- [PM445-1]
	 Begin
	 	-- [VDOC6449]
	 	If @sCle1 In (  'DTE_LIVR_SBE', 
	 					'PRBLE_LIVRAISON', 
	 					'DTE_RESTIT_APP_PRET', 
	 					'ETAT_APP_PRET',
	 					'DTE_ARR_PLATFORM',
	 					'DTE_ARR_CENTR_DISTRIB',
					    'DTE_DEP_CENTR_DISTRIB',
						'DTE_RCP_MOB_CLI',
						'CODE_ERREUR_LIVR',
						'REMIS_EN_STK', -- [PM251-2]
						'PERTE_ALLER', -- [PM445-1]
						'PEC_PRBLE_LIVRAISON'
	 				  )
	 	  Begin

 			If @sCle1 in ( 'PRBLE_LIVRAISON', 'REMIS_EN_STK', 'PERTE_ALLER' )
 			  Begin
 			    -- si la valeur actuel en base de cette clé est différente de la valeur du fichier.
 				If sysadm.FN_CLE_VAL ( @sCle1, @sInfoFrnSpbCpltActuel, ';' ) <> @sVal1
 				  Begin
 					-- Alors on créé un travail.
 					Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> '

	 				-- [PM251-2]				    
				    If @sCle1 = 'REMIS_EN_STK' And @sVal1 = 'OUI' 
						begin
							Select @sMess = @sMess + 'Matériel remis en stock.'

							Update 	sysadm.w_commande
							Set		cod_etat = 'ANN'
							Where w_commande.id_sin = @dcIdSin
							And	  w_commande.id_seq = @iIdSeq

							Update 	sysadm.commande
							Set		cod_etat = 'ANN'
							Where	commande.id_sin = @dcIdSin
							And		commande.id_seq = @iIdSeq
						end
				    
				    If @sCle1 = 'PRBLE_LIVRAISON' 
						begin				    
							Select @sMess = @sMess + 
											 Case @sVal1
												When 'COLIS_PND' Then 'Colis en PND (NPAI)'
												When 'COLIS_NRPAC' Then 'Colis non réclamé par le client'
												When 'COLIS_PERDU' Then 'Colis perdu'
												When 'COLIS_BALNI' Then 'Colis non remis, boites aux lettres non identifiables'	-- [DT111]
												When 'COLIS_INCOR' Then 'Colis non remis,Adresse Incorrecte'	-- [DT111]
												When 'COLIS_REFUS' Then 'Colis refusé par client'	-- [DT111]
												When 'ANNUL_REFAIT' Then 'Colis annulé et refait'	-- [DT111]
												When 'EN_ATTENTE' Then 'Colis en attente' -- [DT288-4]
												When 'AUTRE' Then 'Autre'	-- [DT111]
												When 'J1' Then 'Demande SPB , restituée au client' -- [vDoc26518]
												When 'J2' Then 'Réparé, restitué client' -- [vDoc26518]
												When 'J3' Then 'Refus SAV,restitué au client' -- [vDoc26518]
												When 'J4' Then 'Perte Produit par le PSM' -- [vDoc26518]
												When 'J5' Then 'Perte Produit par le PSM' -- [vDoc26518]
												When 'J6' Then 'Produit déjà expédié vers SPBS' -- [vDoc26518]
												Else @sVal1 + '(valeur non décodée)'
											 End 


							-- [MIG82_JOURN_EVT]
							If sysadm.FN_CLE_NUMERIQUE ( 'MIG82_JOURN_EVT') > 0 
								Begin
									IF @iPrestaHUB > 0 
										Begin
											If @sVal1 in ( 'COLIS_PERDU', 'COLIS_NRPAC' ) Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'APRTET', '', '', 'PS_U01_COMMANDE', 'AUTO'	
											If @sVal1 in ( 'COLIS_PND', 'COLIS_INCOR' ) Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'ADERET', '', '', 'PS_U01_COMMANDE', 'AUTO'	
											If @sVal1 in ( 'COLIS_PERDU' ) Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'PBTRET', '', '', 'PS_U01_COMMANDE', 'AUTO'	
										End
								End 

						End 

					-- [PM445-1]
				    If @sCle1 = 'PERTE_ALLER' 
					  Begin
 						Set @sMess = @sMess + '.Perte du colis à l''aller (sens assuré vers CTR).' -- [PM445-1]
					  End 

					IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
					BEGIN
						-- [VDOC14899] @sMajParCmdActuel par 'PRS'
						EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, 'PRS', @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
					END
					ELSE
					BEGIN
						-- [VDOC14899] @sMajParCmdActuel par 'PRS'
						EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, 'PRS', @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
					END
 				  End
 			  End	

	 		-- [PM250-1]
			If @sCle1 in ( 'DTE_ARR_PLATFORM',
						   'DTE_ARR_CENTR_DISTRIB',
						   'DTE_DEP_CENTR_DISTRIB',
						   'DTE_RCP_MOB_CLI',
						   'CODE_ERREUR_LIVR'
						 )
 			  Begin	 
 			    -- si la valeur actuel en base de cette clé est différente de la valeur du fichier.
 				If sysadm.FN_CLE_VAL ( @sCle1, @sInfoFrnSpbCpltActuel, ';' ) <> @sVal1
 				  Begin
 					-- Alors on créé un travail.
 					Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> '

				    Select @sMess = @sMess + 
									 Case @sCle1
										When 'DTE_ARR_PLATFORM' Then 'Date d''arrivée et de prise en charge en plateforme logistique : ' + @sVal1
										When 'DTE_ARR_CENTR_DISTRIB' Then 'Date d''arrivée et de prise en charge en centre de distribution : ' + @sVal1
										When 'DTE_DEP_CENTR_DISTRIB' Then 'Date de départ du centre de distribution : ' + @sVal1
										When 'DTE_RCP_MOB_CLI' Then 'Date d''arrivée de l''appareil chez l''assuré: ' + @sVal1
										When 'CODE_ERREUR_LIVR' Then 'Code erreur de livraison : ' + @sVal1 + '. ' + 
												IsNull ( 
													(	Select Top 1 lib_evt
														From   sysadm.code_chronopost
														Where  code_evt = @sVal1 )
												, 'Pas de correspondance de code')
										Else @sVal1
									 End
									 

					IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
					BEGIN
						Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT							
					END
					ELSE
					BEGIN
						Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT							
					END	
					
					-- [DT154]
					-- [DT288-4]
					If @sCle1 = 'CODE_ERREUR_LIVR' And 
						@sVal1 in ( 'A1I1', 'A2I2', 'AT', 'IA', 'IS', 'RA', 'RT', 'A1EVT', 'A1INT', 'A2EVT', 'A2INT', 'A2QSF', 'A2RDL', 'SR',
									'A1', 'A1+EVT', 'A1+INT', 'A2', 'A2+EVT', 'A2+INT', 'A2+QSF', 'A2+RDL', 'HD+HD', 'IA+IA', 'RA+RA', 'SD+ERA', 'SD+ERC', 'SD+ERT', 'SD+MIA', 'SD+MIL', 'SD+MIS', 'SR+SR' )
						Begin
							Exec sysadm.PS_S_MAILPUSH_CODE_ERR_LIVR_CHRONOPOST @dcIdSin, @iIdSeq, @idBonTransp, @sAdrFcNom, @asCasRetour OUTPUT
						End
	
					 -- :[DT154]
					
 				  End 	 			  
			  End 	 			  


			-- [PM450-1]
				If @sCle1 in ( 'PEC_PRBLE_LIVRAISON' -- [PM450-1]
								)
 					Begin	 
 						-- si la valeur actuel en base de cette clé est différente de la valeur du fichier.
 						If sysadm.FN_CLE_VAL ( @sCle1, @sInfoFrnSpbCpltActuel, ';' ) <> @sVal1
 							Begin
 								-- Alors on créé un travail.
 								Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> '

								Select @sMess = @sMess + 
													Case 
														When @sCle1 = 'PEC_PRBLE_LIVRAISON' And @sVal1 = 'OUI' Then 'Problème de livraison pris en charge par le prestataire ' + @sLibFour
														When @sCle1 = 'PEC_PRBLE_LIVRAISON' And @sVal1 <> 'OUI' Then 'Problème de livraison NON pris en charge par le prestataire ' + @sLibFour
														Else ''
													End
									 

								IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
								BEGIN
									Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT							
								END
								ELSE
								BEGIN
									Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT							
								END	
							End 
 					End 
			-- [PM450-1]

	 	  	Select @sInfoFrnSpbCpltActuel = sysadm.FN_CLE_VAL_E ( @sCle1, @sVal1, @sInfoFrnSpbCpltActuel, ';')	 
	 	  	
			-- [PM254_V1]
			Set @sCleMinus = LOWER ( @sCle1 ) 
			Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'O', @sCleMinus, @sVal1, null, 'N', @sNomFicFrn
				 	  	
	 	  End 

		  -- [SUIVI_EDEL]
		  If @sCle1 like 'MONTANT[_]CARTE%' Or
			@sCle1 like 'NO[_]CARTE%' Or
			@sCle1 like 'NO[_]CARTE[_]ABREGE%' Or
			@sCle1 like 'NO[_]BA%' Or -- [DT111]
			@sCle1 like 'COLIS[_]RECU%' -- [DT111]
		  Begin
	 	  	Select @sInfoFrnSpbCpltActuel = sysadm.FN_CLE_VAL_E ( @sCle1, @sVal1, @sInfoFrnSpbCpltActuel, ';')	 
	 	  	
			-- [PM254_V1]
			Set @sCleMinus = LOWER ( @sCle1 ) 
			Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'O', @sCleMinus, @sVal1, null, 'N', @sNomFicFrn
		  End
	 End
	Else
	 Begin
		Select @sInfoFrnSpbCpltActuel = sysadm.FN_CLE_VAL_E ( @sCle1, @sVal1, @sInfoFrnSpbCpltActuel, ';')	 
		
		-- [PM254_V1]
		Set @sCleMinus = LOWER ( @sCle1 ) 
		Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'O', @sCleMinus, @sVal1, null, 'N', @sNomFicFrn  
		
	 End	 
	-- #15 JFF 02/09/2009 [DCMP090327].[SBETV]
	
	Set @iRech1 = @iRech2 + 1
	Set @iRech1 = CharIndex ( ';', @sInfoFrnSpbCplt, @iRech1 ) 
	If @iRech1 > 0
	  Begin
 	   Set @iRech1 = @iRech1 + 1
	   Set @iRech2 = CharIndex ( '=', @sInfoFrnSpbCplt, @iRech1 ) -- On recherche la prochaine clé (qu'on en connait pas à ce moment)
	  End
 End
-- :#11 [FNAC_PROD_ECH_TECH]	

-- #15 JFF 02/09/2009 [DCMP090327].[SBETV]
-- [PC929-1] ajout du 21
-- [PM246]
-- [PM250] Modif suite demande d'Hélène (et O2M)
-- [ITSM355855] RSP

If Len ( sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', @sInfoFrnSpbCplt, ';')) > 0 
  Begin
	Set @dtDteRcpMobCli = sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', @sInfoFrnSpbCplt, ';')
  End 

If @iStatusGc in ( 301 ) Or @sCodEtatActuel in ( 'RPC', 'RFO', 'RSP' )
 Begin

	Update 	sysadm.w_commande
	Set	sysadm.w_commande.info_frn_spb_cplt	= @sInfoFrnSpbCpltActuel
	Where	w_commande.id_sin = @dcIdSin
	And	w_commande.id_seq = @iIdSeq

	-- [VDOC19112]
	If @idBonTranspActuel <> @idBonTransp And LEN ( @idBonTranspActuel ) > 0 And LEN ( @idBonTransp ) > 0 
		Begin
			Update 	sysadm.w_commande
			Set	sysadm.w_commande.id_bon_transp	= @idBonTransp
			Where	w_commande.id_sin = @dcIdSin
			And	w_commande.id_seq = @iIdSeq
		End

	-- [DT288-3_LOT1_2EME_VS]
	IF @iStatusGc = 612 And @iStatusGCActuel <> 612
		Begin
			Update 	sysadm.w_commande
			Set	sysadm.w_commande.comment_frn = @sCommentFrn,
				sysadm.w_commande.status_gc = @iStatusGc
			Where	w_commande.id_sin = @dcIdSin
			And	w_commande.id_seq = @iIdSeq
		End

	If @dtDteRcpMobCliActuel <> @dtDteRcpMobCli Or ( @dtDteRcpMobCli is not null And @dtDteRcpMobCliActuel is null )
		Begin
			Update 	sysadm.w_commande
			Set	sysadm.w_commande.dte_rcp_mob_cli = @dtDteRcpMobCli
			Where	w_commande.id_sin = @dcIdSin
			And	w_commande.id_seq = @iIdSeq
		End

	--  [20250227094634600]
	If @iPrestaHUB > 0 And @iStatusGc = 0 And Len ( @idBonTransp ) > 0 
		Begin
			Update 	sysadm.w_commande
			Set	sysadm.w_commande.id_bon_transp = @idBonTransp 
			Where	w_commande.id_sin = @dcIdSin
			And	w_commande.id_seq = @iIdSeq
		End 

	If @iPrestaHUB > 0 And @iStatusGc = 0 And Len ( @sAdrFcNom ) > 0 
		Begin
			Update 	sysadm.w_commande
			Set	sysadm.w_commande.adrfc_nom = @sAdrFcNom 
			Where	w_commande.id_sin = @dcIdSin
			And	w_commande.id_seq = @iIdSeq
		End 
	--  /[20250227094634600]
 End
Else
 Begin
	Update 	sysadm.w_commande
	set	sysadm.w_commande.dte_rcp_frn = @dtDteRcpFrn
	Where	w_commande.id_sin = @dcIdSin
	And	w_commande.id_seq = @iIdSeq
	And 	@dtDteRcpFrn is not null
	And     @dtDteRcpFrnActuel is null -- #19 JFF 27/01/2010 [DCMP100066]

	Update 	sysadm.w_commande
	Set	sysadm.w_commande.id_cmd_frn		= @iIdCmdFrn,
		sysadm.w_commande.id_serie_nouv		= @iIdSerieNouv,
		sysadm.w_commande.dte_env_cli		= @dtDteEnvCli,
		sysadm.w_commande.id_bon_transp		= @idBonTransp,
		sysadm.w_commande.cod_etat		= @sCodEtat,
		sysadm.w_commande.comment_frn		= @sCommentFrn,
		sysadm.w_commande.id_bsp		= @iIdBsp,
		sysadm.w_commande.dte_ret_pret		= @dtDteRetPret,
		sysadm.w_commande.dte_elv_mobile	= @dtDteElvMobile,
		sysadm.w_commande.status_gc     	= @iStatusGc,
		sysadm.w_commande.dte_emis_devis	= @dtDteEmisDevis,
		sysadm.w_commande.mt_devis      	= @dcMtDevis,
		sysadm.w_commande.alt_dev_acp   	= @sAltDevAcp,
		sysadm.w_commande.dte_dev_acp   	= @dtDteDevAcp,
		sysadm.w_commande.dte_ret_logis 	= @dtDteRetLogis,
		sysadm.w_commande.dte_ret_pret_min 	= @dtDteRetPretMin,
		sysadm.w_commande.dte_ret_pret_max 	= @dtDteRetPretMax,
		sysadm.w_commande.dte_env_bte_frn 	= @dtDteEnvBteFrn,
		sysadm.w_commande.dte_rcp_bte_cli 	= @dtDteRcpBteCli,
		sysadm.w_commande.dte_dep_bte_cli 	= @dtDteDepBteCli,
		sysadm.w_commande.dte_env_st 		= @dtDteEnvSt,
		sysadm.w_commande.dte_rcp_mob_cli 	= @dtDteRcpMobCli,
		sysadm.w_commande.maj_le		= @dtTimeStamp, 	-- #2 PHG 22/03/2007 [DCMP070191]
		sysadm.w_commande.id_orian_modele 	= @iIdOrianModele,	-- #3 PHG 05/12/2007 [O2M]
		sysadm.w_commande.adrfc_nom		= @sAdrFcNom,		-- #5 PHG 24/04/2008 [DCMP080199]
		sysadm.w_commande.info_frn_spb_cplt	= @sInfoFrnSpbCpltActuel	-- #11 [FNAC_PROD_ECH_TECH]	
	Where	w_commande.id_sin = @dcIdSin
	And	w_commande.id_seq = @iIdSeq
 End	 
-- #15 JFF 02/09/2009 [DCMP090327].[SBETV]



/* GESTION MCM */ -- #8 JFF 09/09/2008 [MICROMANIA]
If @sIdFour = 'MCM'
Begin
	Update 	sysadm.w_commande
	Set	sysadm.w_commande.id_marq_art		= @sMarq,
		sysadm.w_commande.id_modl_art           = @sModl,
		sysadm.w_commande.mt_ttc_cmde		= @dcPrixTTC
	Where	w_commande.id_sin = @dcIdSin
	And	w_commande.id_seq = @iIdSeq
End


/* Si la commande est d‚j… annul‚e, le code ‚tat ne peut plus changer */
If ( Select count (*)
     From   sysadm.commande
     Where  id_sin = @dcIdSin
     And    id_seq = @iIdSeq
     And    cod_etat = 'ANN'
     And    id_four <> 'ASF' ) > 0 
     
     Begin
     	Select @sCodEtat = 'ANN'
     End 

If ( Select count (*)
     From   sysadm.commande
     Where  id_sin = @dcIdSin
     And    id_seq = @iIdSeq
     And    cod_etat = 'RPC'
     And    id_four <> 'ASF' ) > 0 
     Begin
        Select @sCodEtat = 'RPC'
     End 

-- #15 JFF 02/09/2009 [DCMP090327].[SBETV]
-- [PC929-1] ajout du 21
-- [PM246]
-- [PM250] Modif suite demande d'Hélène (et O2M)
-- [ITSM355855] RSP
If @iStatusGc in ( 301 ) Or @sCodEtatActuel in ( 'RPC', 'RFO', 'RSP' )
 Begin
	Update 	sysadm.commande
	Set	sysadm.commande.info_frn_spb_cplt = @sInfoFrnSpbCpltActuel
	Where	commande.id_sin = @dcIdSin
	And	commande.id_seq = @iIdSeq
		
	-- [VDOC19112]
	If @idBonTranspActuel <> @idBonTransp And LEN ( @idBonTranspActuel ) > 0 And LEN ( @idBonTransp ) > 0 
		Begin
			Update 	sysadm.commande
			Set	sysadm.commande.id_bon_transp = @idBonTransp
			Where	commande.id_sin = @dcIdSin
			And	commande.id_seq = @iIdSeq

			-- [DT288-4]
			Set @asCasRetour = space ( 255 )
			Exec @iRet = sysadm.PS_S03_MAILPUSH_ENVTEL_REMP_REPAR_V03
				@asIdAppli, --	varchar (20),
				@asBase, -- varchar (20),
				@dcIdSin,--     	Decimal (10), -- [PI062]
				@iIdSeq ,--      	Integer,
				@dtDteEnvCli, --   DateTime,
				'CLIENT', --	VarChar	(20),	
				@idBonTransp, --   VarChar	(50),
				@iStatusGc, -- @aiStatusGc   Integer,
				null ,-- @asCommentFrn VarChar ( 255), -- [DT100]
				@sInfoFrnSpbCplt,	--  VarChar ( 255 ), -- [DT141]
				@asCasRetour  OUTPUT  -- VarChar (50) OUTPUT
		End

	-- [DT288-3_LOT1_2EME_VS]
	IF @iStatusGc = 612 And @iStatusGCActuel <> 612
		Begin
			Update 	sysadm.commande
			Set	sysadm.commande.comment_frn = @sCommentFrn,
				sysadm.commande.status_gc = @iStatusGc
			Where commande.id_sin = @dcIdSin
			And	commande.id_seq = @iIdSeq
		End

	If @dtDteRcpMobCliActuel <> @dtDteRcpMobCli Or ( @dtDteRcpMobCli is not null And @dtDteRcpMobCliActuel is null )
		Begin
			Update 	sysadm.commande
			Set	sysadm.commande.dte_rcp_mob_cli = @dtDteRcpMobCli
			Where	commande.id_sin = @dcIdSin
			And	commande.id_seq = @iIdSeq
		End

	--  [20250227094634600]
	If @iPrestaHUB > 0 And @iStatusGc = 0 And Len ( @idBonTransp ) > 0 
		Begin
			Update 	sysadm.commande
			Set	sysadm.commande.id_bon_transp = @idBonTransp 
			Where	commande.id_sin = @dcIdSin
			And	commande.id_seq = @iIdSeq
		End 

	If @iPrestaHUB > 0 And @iStatusGc = 0 And Len ( @sAdrFcNom ) > 0 
		Begin
			Update 	sysadm.commande
			Set	sysadm.commande.adrfc_nom = @sAdrFcNom 
			Where	commande.id_sin = @dcIdSin
			And	commande.id_seq = @iIdSeq
		End 
	--  /[20250227094634600]

 End
Else
 Begin

	Update 	sysadm.commande
	Set	sysadm.commande.dte_rcp_frn	= @dtDteRcpFrn
	Where	commande.id_sin = @dcIdSin
	And	commande.id_seq = @iIdSeq
	And 	@dtDteRcpFrn is not null
	And     @dtDteRcpFrnActuel is null -- #19 JFF 27/01/2010 [DCMP100066]

	Update 	sysadm.commande
	Set	sysadm.commande.id_cmd_frn		= @iIdCmdFrn,
		sysadm.commande.id_serie_nouv		= @iIdSerieNouv,
		sysadm.commande.dte_env_cli		= @dtDteEnvCli,
		sysadm.commande.id_bon_transp		= @idBonTransp,
		sysadm.commande.cod_etat		= @sCodEtat,
		sysadm.commande.comment_frn		= @sCommentFrn,
		sysadm.commande.id_bsp			= @iIdBsp,
		sysadm.commande.dte_ret_pret		= @dtDteRetPret,
		sysadm.commande.dte_elv_mobile		= @dtDteElvMobile,
		sysadm.commande.status_gc     		= @iStatusGc,
		sysadm.commande.dte_emis_devis		= @dtDteEmisDevis,
		sysadm.commande.mt_devis      		= @dcMtDevis,
		sysadm.commande.alt_dev_acp   		= @sAltDevAcp,
		sysadm.commande.dte_dev_acp   		= @dtDteDevAcp,
		sysadm.commande.dte_ret_logis 		= @dtDteRetLogis,
		sysadm.commande.dte_ret_pret_min 	= @dtDteRetPretMin,
		sysadm.commande.dte_ret_pret_max 	= @dtDteRetPretMax,	
		sysadm.commande.dte_env_bte_frn 	= @dtDteEnvBteFrn,
		sysadm.commande.dte_rcp_bte_cli 	= @dtDteRcpBteCli,
		sysadm.commande.dte_dep_bte_cli 	= @dtDteDepBteCli,
		sysadm.commande.dte_env_st 		= @dtDteEnvSt,
		sysadm.commande.dte_rcp_mob_cli 	= @dtDteRcpMobCli,
		sysadm.commande.maj_le			= @dtTimeStamp, 	-- #2 PHG 22/03/2007 [DCMP070191]
		sysadm.commande.id_orian_modele		= @iIdOrianModele,	-- #3 PHG 05/12/2007 [O2M]
		sysadm.commande.adrfc_nom		= @sAdrFcNom,		-- #5 PHG 24/04/2008 [DCMP080199]
		sysadm.commande.info_frn_spb_cplt 	= @sInfoFrnSpbCpltActuel -- #11 [FNAC_PROD_ECH_TECH]	

	Where	commande.id_sin = @dcIdSin
	And	commande.id_seq = @iIdSeq
End
-- #15 JFF 02/09/2009 [DCMP090327].[SBETV]

-- [DT111]
If @sIdFour = 'CMA'
Begin
	Update 	sysadm.w_commande
	Set	id_bon_transp = @idBonTransp,
		dte_env_cli=@dtDteEnvCli
	Where	id_sin = @dcIdSin
		And	id_seq = @iIdSeq
		
	Update 	sysadm.commande
	Set	id_bon_transp = @idBonTransp,
		dte_env_cli=@dtDteEnvCli
	Where	id_sin = @dcIdSin
		And	id_seq = @iIdSeq
End
-- :[DT111]

-- [PM254_V1]
Set @sVal1 = Convert ( VarChar ( 15), @dtDteRcpFrn, 103 ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'dte_rcp_frn', @sVal1, null, 'N', @sNomFicFrn 

Set @sVal1 = Convert ( VarChar ( 255), @iIdCmdFrn ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'id_cmd_frn', @sVal1, null, 'N', @sNomFicFrn 

Set @sVal1 = Convert ( VarChar ( 255), @iIdSerieNouv ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'id_serie_nouv', @sVal1, null, 'N', @sNomFicFrn 

Set @sVal1 = Convert ( VarChar ( 15), @dtDteEnvCli, 103 ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'dte_env_cli', @sVal1, null, 'N', @sNomFicFrn 

Set @sVal1 = Convert ( VarChar ( 255), @idBonTransp ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'id_bon_transp', @sVal1, null, 'N', @sNomFicFrn  

Set @sVal1 = Convert ( VarChar ( 255), @sCodEtat ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'cod_etat', @sVal1, '-EC', 'O', @sNomFicFrn  

Set @sVal1 = Convert ( VarChar ( 255), @sCommentFrn ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'comment_frn', @sVal1, null, 'N', @sNomFicFrn  

Set @sVal1 = Convert ( VarChar ( 15), @iIdBsp ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'id_bsp', @sVal1, null, 'N', @sNomFicFrn

Set @sVal1 = Convert ( VarChar ( 15), @dtDteRetPret, 103 ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'dte_ret_pret', @sVal1, null, 'N', @sNomFicFrn

Set @sVal1 = Convert ( VarChar ( 15), @dtDteElvMobile, 103 ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'dte_elv_mobile', @sVal1, null, 'N', @sNomFicFrn

Set @sVal1 = Convert ( VarChar ( 15), @iStatusGc ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'status_gc', @sVal1, '-GC', 'N', @sNomFicFrn

Set @sVal1 = Convert ( VarChar ( 15), @dtDteEmisDevis, 103 ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'dte_emis_devis', @sVal1, null, 'N', @sNomFicFrn

Set @sVal1 = Convert ( VarChar ( 15), @dcMtDevis ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'mt_devis', @sVal1, null, 'N', @sNomFicFrn

Set @sVal1 = Convert ( VarChar ( 255), @sAltDevAcp ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'alt_dev_acp', @sVal1, null, 'N', @sNomFicFrn  

Set @sVal1 = Convert ( VarChar ( 15), @dtDteDevAcp, 103 ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'dte_dev_acp', @sVal1, null, 'N', @sNomFicFrn

Set @sVal1 = Convert ( VarChar ( 15), @dtDteRetLogis, 103 ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'dte_ret_logis', @sVal1, null, 'N', @sNomFicFrn

Set @sVal1 = Convert ( VarChar ( 15), @dtDteRetPretMin, 103 ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'dte_ret_pret_min', @sVal1, null, 'N', @sNomFicFrn

Set @sVal1 = Convert ( VarChar ( 15), @dtDteRetPretMax, 103 ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'dte_ret_pret_max', @sVal1, null, 'N', @sNomFicFrn

Set @sVal1 = Convert ( VarChar ( 15), @dtDteEnvBteFrn, 103 ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'dte_env_bte_frn', @sVal1, null, 'N', @sNomFicFrn

Set @sVal1 = Convert ( VarChar ( 15), @dtDteRcpBteCli, 103 ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'dte_rcp_bte_cli', @sVal1, null, 'N', @sNomFicFrn

Set @sVal1 = Convert ( VarChar ( 15), @dtDteEnvSt, 103 ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'dte_env_st', @sVal1, null, 'N', @sNomFicFrn

Set @sVal1 = Convert ( VarChar ( 15), @dtDteRcpMobCli, 103 ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'dte_rcp_mob_cli', @sVal1, null, 'N', @sNomFicFrn

Set @sVal1 = Convert ( VarChar ( 15), @iIdOrianModele ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'id_orian_modele', @sVal1, null, 'N', @sNomFicFrn

Set @sVal1 = Convert ( VarChar ( 255), @sAdrFcNom ) 
Exec sysadm.PS_I_TRACE_CMDE @dcIdSin, @iIdSeq, 'N', 'adrfc_nom', @sVal1, null, 'N', @sNomFicFrn  
 

/* GESTION MCM */ -- #8 JFF 09/09/2008 [MICROMANIA]
If @sIdFour = 'MCM'
Begin
	Update 	sysadm.commande
	Set	sysadm.commande.id_marq_art	 = @sMarq,
		sysadm.commande.id_modl_art      = @sModl,
		sysadm.commande.mt_ttc_cmde	 = @dcPrixTTC
	Where	commande.id_sin = @dcIdSin
	And	commande.id_seq = @iIdSeq
End


-- [RS4093_EVOL_ELD]
If sysadm.FN_CLE_NUMERIQUE ( 'RS4093_EVOL_ELD') > 0 
 Begin
	If @sIdFour = 'ELD' 
	  Begin

		Set @sNumCCElDRet = sysadm.FN_CLE_VAL ( 'NUM_CC_ELD_RET', @sInfoFrnSpbCpltActuel, ';' ) -- "Actuel" car déjà maj avec les valeurs entrantes

		-- Maj du numéro de CC à son emplacement original d'avant
		Update 	sysadm.w_commande
		Set	info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'NUM_CC_ELD', @sNumCCElDRet, rtrim ( ltrim ( info_spb_frn_cplt ) ), ';')
		Where	w_commande.id_sin = @dcIdSin
		And	w_commande.id_seq = @iIdSeq

		Update 	sysadm.commande
		Set	info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'NUM_CC_ELD', @sNumCCElDRet, rtrim ( ltrim ( info_spb_frn_cplt ) ), ';')
		Where	commande.id_sin = @dcIdSin
		And	commande.id_seq = @iIdSeq

		If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @dcIdSin  )	
			Begin
				If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'num_carte_cadeau')
					Begin
						Update sysadm.w_div_sin Set val_car = @sNumCCElDRet, maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'num_carte_cadeau'
					End 
				Else
					Begin	 
						Insert into sysadm.w_div_sin values ( @dcIdSin, 'num_carte_cadeau', 'Numéro de carte cadeau ELD', '-1', 'N', 'C', 'N', 'N', 120, null, null, null, @sNumCCElDRet, 1, getdate(), getdate(), 'AUTO' ) 
					End
			End

		If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @dcIdSin  )	
			Begin
				If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'num_carte_cadeau')
					Begin
						Update sysadm.div_sin Set val_car = @sNumCCElDRet, maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'num_carte_cadeau'
					End 
				Else
					Begin	 
						Insert into sysadm.div_sin values ( @dcIdSin, 'num_carte_cadeau', 'Numéro de carte cadeau ELD', '-1', 'N', 'C', 'N', 'N', 120, null, null, null, @sNumCCElDRet, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
					End
			End			
	  End 
 End 

-- [RS5045_REF_MATP]
If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 
 Begin
	If @iStatusGc = 401 
	  Begin
	    If @sIdFour = 'ELD' Exec @iRet=sysadm.PS_I_RS5045_MAIL_COUR_CARTE_CADEAU_ELD_KSL @dcIdSin, @iIdSeq 

		-- [MIG82_JOURN_EVT]
		If sysadm.FN_CLE_NUMERIQUE ( 'MIG82_JOURN_EVT') > 0 
			Begin
			 Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'CCEMIS', '', '', 'PS_U01_COMMANDE', 'AUTO'	
			End 
	  End 
 End 

-- [PM82][LOT1]
-- [PM200][PSM][PM82][LOT1][MANTIS2937]
-- [BLCODE]
-- [VDOC9304_PM82_LOT1]
If @sIdFour in ( 'BLC', 'O2M', 'COR', 'SBE', 'PSM', 'MTT', 'TMT', 'CEA' ) Or @iPrestaHUB > 0  -- [HP252_276_HUB_PRESTA]
	   
	BEGIN
		-- [PM200][LOT2][DESOX] -- [HP252_276_HUB_PRESTA]
		IF ( ( @sIdRefFour in ( 'A_REPARER', 'A_DESOXYDER') Or ( @sIdRefFour = 'A_DIAGNOSTIQUER' And  @iPrestaHUB > 0  )) And @iStatusGCActuel <> @iStatusGc And @iStatusGc in ( 153, 154 ) And @sCodEtatActuel not in ( 'RFO', 'RPC', 'ANN' ) )
   			BEGIN
				Select @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> ' +
				Case @iStatusGc 
					When 153 Then 'IMEI/Num. Série différent, recontactez l''assuré'
					When 154 Then 'IMEI/Num. Série illisible, recontactez l''assuré'
				End 

				IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
					BEGIN
						EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
					END
					ELSE
					BEGIN
						EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
					END
			END
	END
-- :[PM82][LOT1]


/* GESTION O2M */

-- #15 JFF 02/09/2009 [DCMP090327].[SBETV]
-- !! Attention @sIdFour doit exister en tant que user Sesame !! (trg virtuel) !!
-- [BLCODE]
-- [PC877]
-- [DT141]
-- [DT288-3_LOT2] ajout COR
If @sIdFour in ( 'BLC', 'O2M', 'SB1', 'MS1', 'PSM', 'MTT', 'TMT', 'SBE', 'COR', 'CEA' ) Or @iPrestaHUB > 0  -- [HP252_276_HUB_PRESTA]
BEGIN
	
      -- #16 JFF 06/11/2009 [FRAIS_O2M]
	  If @dtDteRcpFrnActuel is null And @dtDteRcpFrn is not null and @sIdFour in ('O2M', 'SBE') 
	   Begin

		 -- [20241104105246567]
		Set @dtDteSource = Getdate()
		Exec sysadm.PS_S_PROCHAIN_JOUR_OUVRE_DU_MEME_MOIS_CALENDAIRE @dtDteSource , @iPJOMMC output, @dtDtePossible output
		
		If @iPJOMMC > 0 
		  Begin
			 Exec sysadm.PS_I01_TRT_FRAIS_PRESTA @dcIdSin, @iIdSeq, @dcIdProd, @sIdFour, @dcIdGti, @iInfoSpbFrnActuel, 'OPCO'
		  End 
	   End 

	
	-- #11 [FNAC_PROD_ECH_TECH]	
	-- [PC877]
	If ( @sIdRefFour = 'A_DIAGNOSTIQUER' Or CharIndex ( 'A_REPARER', @sIdRefFour ) > 0 Or CharIndex ( 'A_DESOXYDER', @sIdRefFour ) > 0 ) 
	   And @iStatusGc in ( 157, 160 ) 
	   And @sCodEtatActuel Not in ( 'RFO', 'RPC') 
	   And @sCodEtat in ( 'RFO', 'RPC' )
	 Begin 
	 
	 	If @iStatusGc in ( 157 ) 
  		 Begin
		   Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> RDV non confirmé suite multiples appels, prestation clôturée. Vous pouvez poursuivre votre gestion.'
		 End 	 
		 
	 	If @iStatusGc in ( 160 ) 
  		 Begin
		   Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> RDV non honoré définitivement, prestation clôturée. Vous pouvez poursuivre votre gestion.'
		 End 	 
			

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			-- [VDOC14899] @sMajParCmdActuel par 'PRS'
			EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, 'PRS', @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END
		ELSE
		BEGIN
			-- [VDOC14899] @sMajParCmdActuel par 'PRS'
			EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, 'PRS', @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END

	 End


	-- :#11 [FNAC_PROD_ECH_TECH]	
	  
		-- #3 12/12/2007 : [O2M] : 
		-- si un retour est présent dans le fichier lié à une demande de prestation d’origine 
		-- dont l’action était « A_DIAGNOSTIQUER » en base (zone id_ref_four) ET si dans l’enregistrement présent dans le fichier, 
		-- « id_orian_modele » (pièce jointe) est à « N », alors on crée un contact ET un travail

	-- Code de cloture

	-- #20 [MSS_LOT2]
	-- [DCMP100146][VDOC7456]
	
	IF @sIdRefFour in ( 'CMDE_AUT_ACC', 'CMDE_BATT_AMOV', 'CMDE_ALIM_EXT') AND @iIdOrianModele = 2 And @iStatusGc in (176) And @sCodEtatActuel <> 'RFO' And @sCodEtat = 'RFO'
	Begin
		Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> La commande de l''accessoire est impossible, vous devez passer un acte de gestion manuel venant se substituer à cet ordre de commande.'

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END
		ELSE
		BEGIN
			EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END

	End

	-- [PC929-1]
	If @sIdFour = 'PSM' And @sIdRefFour = 'A_DIAGNOSTIQUER'
	 Begin
		Set @iIdOrianModele = 2
	 End

	-- [PC13348&13408]
	-- [DT141]
	If @sIdFour in ( 'MTT', 'SBE') And @sIdRefFour = 'A_DIAGNOSTIQUER'
	 Begin
		Set @iIdOrianModele = 2
	 End

	-- [PC292] gc179
	-- [ITSM_174624] Retrait  @iIdOrianModele = 2 Or @iInfoSpbFrnActuel = 980 
	-- [PM280-2]
	IF ( @sIdRefFour in ( 'A_DIAGNOSTIQUER', 'PROPO_A_EFFECTUER', 'CONTEST_SUR_REMPL' ) 
	   And @iStatusGc in ( 151,152,153,154,161,170,171,173,175,179) 
	   And @sCodEtatActuel <> 'RFO' 
	   And @sCodEtat = 'RFO')
	   OR 
	   ( @sIdRefFour in ( 'A_REPARER' ) 
		And @sCodEtatActuel not in ( 'RFO', 'RPC' )
	    And @sCodEtat in ( 'RFO', 'RPC' )
	    And @iStatusGc in ( 151,152,153,154,170,171) )
	     
	BEGIN
		-- [MIG82_JOURN_EVT]
		If sysadm.FN_CLE_NUMERIQUE ( 'MIG82_JOURN_EVT') > 0 
			Begin
				IF @iPrestaHUB > 0 and @iStatusGc = 151 and @iStatusGCActuel <> 151 
					Begin
					 Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'PECIND', '', '', 'PS_U01_COMMANDE', 'AUTO'	
					End
			End 	

		-- #3 [O2M] : Pas de Pièce Jointes
		-- #17 [MSS_DIAG]
		If @sIdFour = 'O2M' 
		Begin
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Pas de pièces jointes. Vous pouvez poursuivre votre gestion.'
		End
		Else
		Begin
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Vous pouvez poursuivre votre gestion.'
		End

		-- #17 [MSS_DIAG]
		--     [MSS_LOT2]

		If @sIdFour = 'MS1' and @iStatusGc in ( 153,154 )
		Begin
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Numéro de série différent ou illisible, Vous pouvez poursuivre votre gestion.'
		End

		--     [MSS_LOT2]
		If @sIdFour = 'MS1' and @iStatusGc in ( 152 )
		Begin
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Non conforme, Hors garantie d''assurance, contacter l''assuré pour lui proposer un devis ' + @sLibFour + ' à sa charge'
		End


		-- #17 [MSS_DIAG]
		If @iStatusGc in ( 173 ) And @iIdOrianModele = 2
		Begin
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Non conforme, mais panne soft tout de même dépannée, prévenir l''assuré que l''appareil lui a été renvoyé.'		
		End

		--     [MSS_LOT2]
		If @iStatusGc in ( 175 ) And @iIdOrianModele = 2
		Begin
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Panne sur accessoire/composant, vous pouvez poursuivre votre gestion.'
		End

		--    [PC292].[RR7_POINT_40]
		If @iStatusGc in ( 179 ) And @iIdOrianModele = 2
		Begin
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Vous devez prendre une décision sur le matériel proposé en retour du diagnostic.'
			
		End
		

		-- [DT011]
		-- [ITSM_174624] Retrait  @iIdOrianModele = 2 Or @iInfoSpbFrnActuel = 980 
		Set @iRet = 0 -- ajout avec [ITSM_174624]
		If @iIdOrianModele = 2 And @sIdRefFour not in ( 'A_REPARER' ) 
		  Begin
			Exec @iRet=sysadm.PS_S15_MAILPUSH_DIAGOK_ASSURE @dcIdSin, @iIdSeq, @sIdFour, @iStatusGc
		  End

		-- [PC938_ORANGE_V3]
		If @iInfoSpbFrnActuel = 980 and @iStatusGc in ( 151, 152, 153, 154 )
		  Begin
			Set @iRet = 1
			
			Select	@dcNewIdDetail = id_detail  
			From	sysadm.commande 
			where   id_sin = @dcIdSin
			and     id_seq = @iIdSeq

			If @dcNewIdDetail >= 0 
			  Begin

				Select @iNewIdSeq = max ( id_seq ) From commande where id_sin = @dcIdSin

				If @iNewIdSeq is null Set @iNewIdSeq = 0
				Set @iNewIdSeq = @iNewIdSeq + 1
				
				Insert into commande
				select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, id_four, id_typ_art, 'PRISE EN CHARGE A RECYCLER', '', mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, '', null,  null, null, null, null, 'RFO', null, 'PRESTA AUTOMATIQUE', 0, null, null, Getdate(), Getdate(), 'AUTO',  Getdate(),  'AUTO', id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'PEC_A_RECYCLER', id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, null, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, 965, 'PRISE EN CHARGE A RECYCLER', id_modl_art_ifr, null, null
				From commande c
				Where c.id_sin = @dcIdSin
				And   c.id_seq = @iIdSeq

				If Exists ( Select * from w_commande where id_sin = @dcIdSin   and id_seq = @iIdSeq )
				  Begin
					Insert into w_commande
					select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, id_four, id_typ_art, 'PRISE EN CHARGE A RECYCLER', '', mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, '', null,  null, null, null, null, 'RFO', null, 1, 'PRESTA AUTOMATIQUE', Getdate(), Getdate(), 'AUTO',  id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'PEC_A_RECYCLER'   , id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, null, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, 965, 'PRISE EN CHARGE A RECYCLER', id_modl_art_ifr, null, null
					From w_commande c
					Where c.id_sin = @dcIdSin
					And   c.id_seq = @iIdSeq
				  End 	
			  End 
			
		  End 
		
		If @iRet = 0 -- [DT011]
		Begin
			
			-- [PC929_CDISCOUNT]
			If Exists ( select * from sysadm.det_pro where id_prod=@dcIdProd and id_code_dp=235 ) 
			 Begin
				Set @iCasPropoAutoVpp = 1
			 End 
			  
			If @iCasPropoAutoVpp = 1 And @iStatusGc in ( 151, 171 )
			 Begin
			 
			    -- Pec à recycler
				Select	@dcNewIdDetail = id_detail  
				From	sysadm.detail
				where   id_sin = @dcIdSin
				and     id_gti = @dcIdGti
				And     id_evt = 1083

				If @dcNewIdDetail is null Set @dcNewIdDetail = 0

				Select @iNewIdSeq = max ( id_seq ) From commande where id_sin = @dcIdSin

				If @iNewIdSeq is null Set @iNewIdSeq = 0
				Set @iNewIdSeq = @iNewIdSeq + 1
				
				If Exists ( 
						Select Top 1 1
						From sysadm.commande c
						Where c.id_sin = @dcIdSin
						And   c.id_ref_four = 'A_DIAGNOSTIQUER'
					)	
				  Begin
					Insert into commande
					select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, id_four, id_typ_art, 'PRISE EN CHARGE A RECYCLER', '', mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, '', null,  null, null, null, null, 'RFO', null, 'PRESTA AUTOMATIQUE', 0, null, null, Getdate(), Getdate(), 'AUTO',  Getdate(),  'AUTO', id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'PEC_A_RECYCLER', id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, null, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, 965, 'PRISE EN CHARGE A RECYCLER', id_modl_art_ifr, null, null
					From commande c
					Where c.id_sin = @dcIdSin
					And   c.id_seq = @iIdSeq

					If Exists ( Select * from w_commande where id_sin = @dcIdSin   and id_seq = @iIdSeq )
					  Begin
						Insert into w_commande
						select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, id_four, id_typ_art, 'PRISE EN CHARGE A RECYCLER', '', mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, '', null,  null, null, null, null, 'RFO', null, 1, 'PRESTA AUTOMATIQUE', Getdate(), Getdate(), 'AUTO',  id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'PEC_A_RECYCLER'   , id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, null, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, 965, 'PRISE EN CHARGE A RECYCLER', id_modl_art_ifr, null, null
						From w_commande c
						Where c.id_sin = @dcIdSin
						And   c.id_seq = @iIdSeq
					  End 				
				  End 

			    -- Propos vpp
				Select	@dcNewIdDetail = max ( id_detail ) 
				From	sysadm.detail
				where   id_sin = @dcIdSin
				and     id_gti = @dcIdGti 

				If @dcNewIdDetail is null Set @dcNewIdDetail = 0
				Set @dcNewIdDetail = @dcNewIdDetail + 1

				Insert into sysadm.detail 
				Select id_sin,   id_gti,   @dcNewIdDetail,   936,   id_reg,   id_i_reg,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej,   mt_fran,   mt_nplaf,   mt_plaf,   alt_plaf,   alt_reg,   'O',   alt_ssui,   cod_mot_ssui,   cod_dec_mac,   cod_dec_ope,   cod_etat,   id_carte,   id_type_carte,   getdate(),   'AUTO',   getdate(),   getdate(),   'AUTO',   dte_cmd,   dte_livr,   mt_val_achat,   mt_val_publique,   num_facture
				From sysadm.detail d
				Where d.id_sin = @dcIdSin
				And   d.id_gti = @dcIdGti
				And   d.id_detail = @dcIdDetail

				If Exists ( Select * from w_detail where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
				  Begin
					Insert into sysadm.w_detail 
					Select id_sin,   id_gti,   @dcNewIdDetail,   936,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej,   mt_fran,   mt_nplaf,   mt_plaf,   null, 'N', 'N', alt_plaf,   alt_reg,   'O', alt_valide,  1,  alt_ssui,   cod_mot_ssui,   cod_dec_mac,   cod_dec_ope,   cod_etat,   id_carte,   id_type_carte, getdate(),   getdate(),   'AUTO',   dte_cmd,   dte_livr,   mt_val_achat,   mt_val_publique,   num_facture
					From sysadm.w_detail d
					Where d.id_sin = @dcIdSin
					And   d.id_gti = @dcIdGti
					And   d.id_detail = @dcIdDetail
				  End 

				Insert into sysadm.div_det 
				Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, getdate(), getdate(),  'AUTO', getdate(), 'AUTO'
				From sysadm.div_det d
				Where d.id_sin = @dcIdSin
				And   d.id_gti = @dcIdGti
				And   d.id_detail = @dcIdDetail

				If Exists ( Select * from w_div_det where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
				  Begin
					Insert into sysadm.w_div_det 
					Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, 1, getdate(),   getdate(), 'AUTO'
					From sysadm.w_div_det d
					Where d.id_sin = @dcIdSin
					And   d.id_gti = @dcIdGti
					And   d.id_detail = @dcIdDetail			  
				  End 

				-- [MANTIS11520][PC13419]
				Select @dcMtPecPlaf = d.val_mt
				From sysadm.div_det d
				Where d.id_sin = @dcIdSin
				And   d.id_gti = @dcIdGti
				And   d.id_detail = @dcIdDetail
				And   d.nom_zone = 'mt_pec'
				
				If @dcMtPecPlaf is null Set @dcMtPecPlaf = 0
			
				Exec sysadm.PS_U01_COMMANDE_PLAF @dcIdSin, @dcIdProd, @dcIdRev, @dcIdGti, 936, 721, @dcMtPecPlaf, @sInfoFrnSpbCplt, @dcMtPecPlaf OUTPUT					 
			 
				Update sysadm.div_det
				Set val_mt = @dcMtPecPlaf
				Where id_sin = @dcIdSin
				And   id_gti = @dcIdGti
				And   id_detail = @dcNewIdDetail	 
				
				Update sysadm.w_div_det
				Set val_mt = @dcMtPecPlaf
				Where id_sin = @dcIdSin
				And   id_gti = @dcIdGti
				And   id_detail = @dcNewIdDetail	 
				-- [MANTIS11520][PC13419]
				
				Select @iNewIdSeq = max ( id_seq ) From commande where id_sin = @dcIdSin

				If @iNewIdSeq is null Set @iNewIdSeq = 0
				Set @iNewIdSeq = @iNewIdSeq + 1
				
				Insert into commande
				select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, 'VPP', 'CAF', 'REMPLACEMENT APPAREIL VIPP/ASSURE', '', mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, '', null,  null, null, null, null, 'RPC', null, 'PRESTA AUTOMATIQUE', 0, null, null, Getdate(), Getdate(), 'AUTO',  Getdate(),  'AUTO', id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'REMPL_VIPP_ASSURE', id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, alt_dev_acp, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, 0, null, null, '', ''
				From commande c
				Where c.id_sin = @dcIdSin
				And   c.id_seq = @iIdSeq

				If Exists ( Select * from w_commande where id_sin = @dcIdSin   and id_seq = @iIdSeq )
				  Begin
					Insert into w_commande
					select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, 'VPP', 'CAF', 'REMPLACEMENT APPAREIL VIPP/ASSURE', '', mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, '', null,  null, null, null, null, 'RPC', null, 1, 'PRESTA AUTOMATIQUE', Getdate(), Getdate(), 'AUTO',  id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'REMPL_VIPP_ASSURE', id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, alt_dev_acp, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, 0, null, null, '', ''
					From w_commande c
					Where c.id_sin = @dcIdSin
					And   c.id_seq = @iIdSeq
				  End 
				  
				-- [MANTIS11520][PC13419]
				Update sysadm.commande
				Set mt_ttc_cmde = @dcMtPecPlaf
				Where id_sin = @dcIdSin
				And   id_seq = @iNewIdSeq	 
				
				Update sysadm.w_commande
				Set mt_ttc_cmde = @dcMtPecPlaf
				Where id_sin = @dcIdSin
				And   id_seq = @iNewIdSeq	 
				-- [MANTIS11520][PC13419]					  
				  				
			 End
			Else
			 Begin

				IF sysadm.FN_CLE_VAL ( 'FACT_PRESENTE', rtrim ( @sInfoFrnSpbCplt ) , ';') = 'NON' 
				   And Not Exists ( Select Top 1 1 From sysadm.div_sin wds Where wds.id_sin = @dcIdSin and wds.nom_zone = 'dte_pce_fact_achat_dem' )
				   And @sIdRefFour = 'A_DIAGNOSTIQUER'
				   And @iStatusGc = 151 
				   And Exists ( select top 1 1 From sysadm.det_pro dp, sysadm.sinistre s where s.id_sin = @dcIdSin And dp.id_prod = s.id_prod And dp.id_code_dp = 275 )
				  Begin				

					Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Diag conforme et facture absente. Facture demandée automatiquement par courrier KSL'
					IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
					BEGIN
						-- [VDOC18434]
						Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	'PRS', 300, @iIdCt OUTPUT
					END
					ELSE
					BEGIN
						-- [VDOC18434]						
						Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	'PRS', 300, @iIdCt OUTPUT
					END
					
					Set @iTraite = 1
					
				  End
		 
				-- [ITSM_174624] Retrait  @iIdOrianModele = 2 Or @iInfoSpbFrnActuel = 980 
				If @iIdOrianModele = 2 And @iTraite = 0			 
				 Begin
					IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
					BEGIN
					-- [VDOC18434]
						EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, 'PRS', @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
					END
					ELSE
					BEGIN
					-- [VDOC18434]					
						EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, 'PRS', @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
					END				
				End
			 End
		End
	END

	-- [DT011] -- [PC877]
	IF @sIdRefFour in ( 'A_DIAGNOSTIQUER', 'PROPO_A_EFFECTUER' ) And @iIdOrianModele = 1 and @iStatusGc in (151,179) And @sCodEtatActuel <> 'RFO' And @sCodEtat = 'RFO'
	BEGIN
		Exec @iRet=sysadm.PS_S15_MAILPUSH_DIAGOK_ASSURE @dcIdSin, @iIdSeq, @sIdFour, @iStatusGc
	End 
	-- :[DT011]
		
	-- #12 [FNAC_PROD_ECH_TECH].[20090127140540720]
	IF @sIdRefFour = 'A_DIAGNOSTIQUER' AND @iStatusGCActuel <> 162 And @iStatusGc = 162
	BEGIN 
		Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Symptome non détectable en 24h, diag plus long.'

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
		-- [VDOC7912]		
		--	EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
			Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
			
		END
		ELSE
		BEGIN
		-- [VDOC7912]				
		--	EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
			Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT			
		END
	END 

	-- [HP252_276_HUB_PRESTA]
	IF @iStatusGCActuel <> 12 And @iStatusGc = 12 And @iPrestaHUB > 0
	BEGIN 
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Le CTR a perdu l''appareil.'
			IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
			BEGIN
				Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
			END
			ELSE
			BEGIN
				Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
			END
	END
	-- /[HP252_276_HUB_PRESTA]

	-- [HP252_276_HUB_PRESTA]
	IF @iStatusGCActuel <> 305 And @iStatusGc = 305 And @iPrestaHUB > 0
	BEGIN 
			-- Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> La géolocalisation est active. Le prestataire se charge de contacter l''assuré pour la désactiver, aucune action spb.'
			-- Process modifié par Olfa le 26/02
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> La géolocalisation est active, contactez l''assuré pour lui demander de DéGéolocaliser son appareil et renvoyez un A_DIAG_FORCE ou A_REPARER_FORCE selon le cas.'

/*			Process modifié par Olfa le 26/02
			IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
			BEGIN
				Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
			END
			ELSE
			BEGIN
				Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
			END
*/

			-- Process modifié par Olfa le 26/02 => On créé un travail
			IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
			BEGIN
				EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
			END
			ELSE
			BEGIN
				EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
			END	

			-- [MIG82_JOURN_EVT]
			If sysadm.FN_CLE_NUMERIQUE ( 'MIG82_JOURN_EVT') > 0 
				Begin
				 Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'GEOLOC', '', '', 'PS_U01_COMMANDE', 'AUTO'	
				End

	END
	-- /[HP252_276_HUB_PRESTA]

	-- [HP252_276_HUB_PRESTA][MIG82_JOURN_EVT]
	IF @iStatusGCActuel <> 858 And @iStatusGc = 858 And @iPrestaHUB > 0
	BEGIN 
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> La géolocalisation de l''appareil est bien désactivée.'

			IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
			BEGIN
				Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
			END
			ELSE
			BEGIN
				Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
			END

			-- [MIG82_JOURN_EVT]
			If sysadm.FN_CLE_NUMERIQUE ( 'MIG82_JOURN_EVT') > 0 
			 Begin
				Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'DEGEOL', '', '', 'PS_U01_COMMANDE', 'AUTO'
			 End 

	END
	-- /[HP252_276_HUB_PRESTA][MIG82_JOURN_EVT]

	-- [HP252_276_HUB_PRESTA] -- [20250228130407143] Modif par Olfa le 28/02/25
	IF @iStatusGCActuel <> 169 And @iStatusGc = 169 And @iPrestaHUB > 0
	BEGIN 
			-- Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Appareil incomplet, process Hub Prestataire => Le HUB envoie automatiquement un mail à l''assuré lui demandant d''envoyer les éléments manquants au prestataire.'
			-- Process modifié par Olfa le 26/02
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Appareil incomplet, contactez l''assuré pour lui demander d''envoyer les éléments manquants au prestataire et envoyez un A_DIAG_FORCE ou A_REPARER_FORCE si l''assuré peut le faire ou bien un REFUSE_A_REEXP s''il ne peut pas.'

			/* Process modifié par Olfa le 26/02
			IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
			BEGIN
				Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
			END
			ELSE
			BEGIN
				Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
			END
			*/

			IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
			BEGIN
				EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
			END
			ELSE
			BEGIN
				EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
			END	

	END
	-- /[HP252_276_HUB_PRESTA]

	-- [HP252_276_HUB_PRESTA]
	IF @iStatusGCActuel <> 159 And @iStatusGc = 159 And @iPrestaHUB > 0
	BEGIN 
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Le CTR (Prestataire) a réceptionné l''appareil.'
			IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
			BEGIN
				Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
			END
			ELSE
			BEGIN
				Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
			END

			-- [MIG82_JOURN_EVT]
			If sysadm.FN_CLE_NUMERIQUE ( 'MIG82_JOURN_EVT') > 0 
				Begin
				 Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'APPCTR', '', '', 'PS_U01_COMMANDE', 'AUTO'	
				End 

	END
	-- /[HP252_276_HUB_PRESTA]



	-- #13 JFF 14/05/2009 [DCMP090085]
	IF @sIdRefFour = 'A_DIAGNOSTIQUER' AND @iStatusGCActuel <> 169 And @iStatusGc = 169 And @iPrestaHUB <= 0  -- [HP252_276_HUB_PRESTA]
	BEGIN 
		--[PC501]-1
		If @sIdFour in ( 'MS1' )
		 Begin
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Appareil incomplet. envoi automatique d''un ordre de diag en l''état'
			IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
			BEGIN
				Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
			END
			ELSE
			BEGIN
				Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
			END
			
			
			Update 	sysadm.w_commande
			Set	info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'ENV_VERS', 'MS1',
						    sysadm.FN_CLE_VAL_E ( 'MAJ_PRS', 'NON',
						    sysadm.FN_CLE_VAL_E ( 'NO_MAIL', 'OUI',
							sysadm.FN_CLE_VAL_E ( 'RETOUR_169', 'DIAG_EN_L_ETAT_ASS_N_ENVOIE_PAS_ACC', @sInfoSpbFrnCpltActuel , ';')
						    , ';')
						    , ';')						    
						    , ';')						    
			Where	id_sin = @dcIdSin
			And	id_seq = @iIdSeq

			Update 	sysadm.commande
			Set	info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'ENV_VERS', 'MS1',
						    sysadm.FN_CLE_VAL_E ( 'MAJ_PRS', 'NON',
						    sysadm.FN_CLE_VAL_E ( 'NO_MAIL', 'OUI',						    
							sysadm.FN_CLE_VAL_E ( 'RETOUR_169', 'DIAG_EN_L_ETAT_ASS_N_ENVOIE_PAS_ACC', @sInfoSpbFrnCpltActuel , ';')
						    , ';')
						    , ';')						    
						    , ';'),						    
				id_lot_cmd = 0,
				cmd_gen_le =null,
				cmd_gen_par =null
						 
			Where	id_sin = @dcIdSin
			And	id_seq = @iIdSeq
			
		 End
		Else
		 Begin

			-- #17 [MSS_DIAG] modif du message
			If Exists ( select * from sysadm.det_pro where id_prod=@dcIdProd and id_code_dp=238 ) 
			 Begin

				Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Appareil incomplet. Demander à l''assuré de renvoyer les élèments manquants aux fournisseurs'
			 
				-- [PC387][MANTIS10805]
				If Exists ( select * 
							from sysadm.det_pro 
							where id_prod=@dcIdProd 
							and id_code_dp=258 
							and sysadm.FN_CLE_VAL ( 'CAS', rtrim ( val_car), ';') = '1' )
				  Begin
					Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Appareil incomplet.'
				  End 

				IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
				BEGIN
					Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
				END
				ELSE
				BEGIN
					Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
				END
					
			 End
			Else
			 Begin
				Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Appareil incomplet. Demander à l''assuré de renvoyer les élèments manquants aux fournisseurs'

				-- [PC387][MANTIS10805]
				If Exists ( select * 
							from sysadm.det_pro 
							where id_prod=@dcIdProd 
							and id_code_dp=258 
							and sysadm.FN_CLE_VAL ( 'CAS', rtrim ( val_car), ';') = '1' )
				  Begin
					Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Appareil incomplet.'
				  End 

				IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
				BEGIN
					EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
				END
				ELSE
				BEGIN
					EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
				END	
			 End 
		End
	END 

	-- [DT288-3_LOT2]
	IF @sIdRefFour = 'A_REPARER' AND @iStatusGCActuel <> 169 And @iStatusGc = 169 and @sIdFour in ( 'COR' )  And @iPrestaHUB <= 0  -- [HP252_276_HUB_PRESTA]
	BEGIN 
		Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Appareil incomplet. Retour automatique de l''appareil vers l''assuré'

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END
		ELSE
		BEGIN
			EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END	

		-- [LGY38]
		If sysadm.FN_CLE_NUMERIQUE ( 'LGY38') > 0 
			Begin
				Update sysadm.w_queue Set etat_iwd = 99 Where id_sin = @dcIdSin
			End 
				
		Exec sysadm.PS_I_COMMANDE_APP_INCOMPLET_CORDON @dcIdSin, @dcIdGti
	END

	IF @sIdRefFour = 'A_RECUP_A_RECYCLER' AND @iStatusGCActuel <> @iStatusGc And @iStatusGc in (166,167,168)
	BEGIN 
		Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> '
		Select @sMess=Case @iStatusGc 
			When 166 Then @sMess + 'appareil récupéré, recyclage automatique.'
			When 167 Then @sMess + 'appareil récupéré, contre diagnostic conforme, recyclage automatique.'
			When 168 Then @sMess + 'appareil récupéré, contre diagnostic non conforme, pas de recyclage automatique, renvoie de l’appareil vers la boutique.'
			End

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1,		/* Le Client est trouvé automatiquement par la proc */
								2,		/* Famille : Sinistre */
								4,		/* Type de Contact : Information */
								'C',		/* Canal : Courrier */
								@dcIdSin,	/* N° de Sinistre */
								2,		/* Application : Simpa2 */
								@sMess,		/* Le message du Contact */
								@sIdFour,		/* Trig. Virtuel O2M */
								300, 		/* Etat : Contact Clos */
								@iIdCt OUTPUT	/* le N° de Ct crée, non utilisé */
		END
		ELSE
		BEGIN
			Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1,		/* Le Client est trouvé automatiquement par la proc */
								2,		/* Famille : Sinistre */
								4,		/* Type de Contact : Information */
								'C',		/* Canal : Courrier */
								@dcIdSin,	/* N° de Sinistre */
								2,		/* Application : Simpa2 */
								@sMess,		/* Le message du Contact */
								@sIdFour,		/* Trig. Virtuel O2M */
								300, 		/* Etat : Contact Clos */
								@iIdCt OUTPUT	/* le N° de Ct crée, non utilisé */

		END
	END

	IF @sIdRefFour = 'REFUSE_A_REEXP' And @sCodEtatActuel <> 'RFO' And @sCodEtat = 'RFO'
	BEGIN
		-- #3 Appareil Rexpédié
		Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> Appareil réexpédié avec n° de Colis :'+ISNULL(@idBonTransp,'<Pas de Numéro Indiqué>')
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1,		/* Le Client est trouvé automatiquement par la proc */
								2,		/* Famille : Sinistre */
								4,		/* Type de Contact : Information */
								'C',		/* Canal : Courrier */
								@dcIdSin,	/* N° de Sinistre */
								2,		/* Application : Simpa2 */
								@sMess,		/* Le message du Contact */
								@sIdFour,		/* Trig. Virtuel O2M */
								300, 		/* Etat : Contact Clos */
								@iIdCt OUTPUT	/* le N° de Ct crée, non utilisé */
		END
		ELSE
		BEGIN
			Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1,		/* Le Client est trouvé automatiquement par la proc */
								2,		/* Famille : Sinistre */
								4,		/* Type de Contact : Information */
								'C',		/* Canal : Courrier */
								@dcIdSin,	/* N° de Sinistre */
								2,		/* Application : Simpa2 */
								@sMess,		/* Le message du Contact */
								@sIdFour,		/* Trig. Virtuel O2M */
								300, 		/* Etat : Contact Clos */
								@iIdCt OUTPUT	/* le N° de Ct crée, non utilisé */

		END
	END
	
	-- [PC482]
	If @iStatusGCActuel <> 163 And @iStatusGc = 163
	Begin
		Set @sDbName = Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) )
		Exec sysadm.PS_S10_MAILPUSH_ENVOI_CRT 'SIMPA2',@sDbName,@dcIdSin,@iIdSeq, @sCasRetour OUTPUT
	End
	-- Fin [PC482]
	
	-- [PM284-2]
	If ( @iStatusGCActuel <> 21 And @iStatusGc = 21 ) OR ( @iStatusGCActuel <> 23 And @iStatusGc = 23 )
		Begin
		Exec sysadm.PS_S_MAILPUSH_APP_IRREPARABLE @dcIdSin, @iIdSeq, @sCasRetour OUTPUT
		End 
	-- [PM284-2]


	-- [PC292] 
	If @sIdFour in ( 'SB1' ) And @sIdRefFour = 'A_DIAGNOSTIQUER'
	 Begin
	 	If Exists ( Select * From sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 179) And @iStatusGc in ( 152, 170 ) 
	 	 Begin
	 	 	Update sysadm.commande
	 	 	Set cod_etat = 'ANN'
	 	 	Where id_sin = @dcIdSin
	 	 	And   id_four = 'O2M'
	 	 	and   id_ref_four = 'A_DIAGNOSTIQUER'
	 	 	and   cod_etat = 'ECT'
	 	 	
			Update sysadm.w_commande
			Set cod_etat = 'ANN'
			Where id_sin = @dcIdSin
			And   id_four = 'O2M'
			and   id_ref_four = 'A_DIAGNOSTIQUER'
	 	 	and   cod_etat = 'ECT'
	 	 End
	 End
	-- :[PC292]
	
END
-- :#15 JFF 02/09/2009 [DCMP090327].[SBETV]

-- [RECUPDONN_MANTIS4252]
-- [VDOC9908]
If @sIdFour = 'O2M' And @iStatusGCActuel <> 178 And @iStatusGc = 178 
 Begin

	Update sysadm.commande
	Set cod_etat = 'RFO'
	Where id_sin = @dcIdSin 
	And   id_ref_four in ( 'PEC_A_RECYCLER', 'PAS_DE_COMMANDE' )
	And   id_four = 'O2M'
	And   cod_etat = 'ECT'

	Update sysadm.w_commande
	Set cod_etat = 'RFO'
	Where id_sin = @dcIdSin 
	And   id_ref_four in ( 'PEC_A_RECYCLER', 'PAS_DE_COMMANDE' )
	And   id_four = 'O2M'
	And   cod_etat = 'ECT'
 End
-- [RECUPDONN_MANTIS4252]

-- [BLCODE]
If @sIdFour = 'BLC' And ( ( @iStatusGCActuel <> 152 And @iStatusGc = 152 )  Or ( @iStatusGCActuel <> 170 And @iStatusGc = 170 ) )
 Begin
	Update sysadm.commande
	Set cod_etat = 'RFO'
	Where id_sin = @dcIdSin 
	And   id_ref_four in ( 'A_RECUP_A_RECYCLER' )
	And   id_four = 'O2M'
	And   cod_etat = 'ECT'
	And   info_spb_frn = 1502

	Update sysadm.w_commande
	Set cod_etat = 'RFO'
	Where id_sin = @dcIdSin 
	And   id_ref_four in ( 'A_RECUP_A_RECYCLER' )
	And   id_four = 'O2M'
	And   cod_etat = 'ECT'
	And   info_spb_frn = 1502 		
 End 
-- [BLCODE]

-- #7 [DCMP080077].BUG1
If @sCommentFrn is null Set @sCommentFrn = ''
If @sCommentFrnActuel is null Set @sCommentFrnActuel = ''
-- :#7 [DCMP080077].BUG1

-- [PC929][MANTIS8600]
IF	@sIdRefFour in ( 'A_REPARER' ) 
	and @iStatusGc in ( 152, 170 ) 
	And @sIdFour = 'O2M' And @sCodEtatActuel Not in ( 'RPC', 'RFO', 'ANN') And @iStatusGCActuel Not in ( 152, 170 ) 
 Begin
 		Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> non conforme sur ordre de réparation '

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END
		ELSE
		BEGIN
			EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END				 
 End 

-- [PMO89_RS4822]
IF ( ( @iStatusGc = 810 And @iStatusGCActuel <> 810 ) Or ( @iStatusGc = 820 And @iStatusGCActuel <> 820 ) ) and  @sIdFour = 'CDF'
	Begin
		
		Select @sNomInter = lTrim ( rTrim ( i.nom)),
				@dcIdInter  = i.id_i,
				@sCodInter = i.cod_inter
		From sysadm.inter i,
				sysadm.commande c
		Where c.id_sin = @dcIdSin
		And c.id_seq = @iIdSeq
		And i.id_sin = c.id_sin 
		And i.id_i = Convert ( decimal (2), sysadm.FN_CLE_VAL ( 'ID_INTER', c.info_spb_frn_cplt, ';'))

		If @iStatusGc = 810 
			Begin 
			Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ @sLibFour + ' a contrôlé et accepté (OK) l''interlocuteur ' + @sNomInter + ' (' +  Convert ( varchar (5), @dcIdInter) + ') de type ' + sysadm.FN_CODE_CAR ( @sCodInter, '-IN' ) + ', prenez note des réponses de l''assureur avant de poursuivre l''instruction de votre dossier.'
			Update sysadm.w_inter set cod_etat_ctrle_inter = 300 where id_sin = @dcIdSin and id_i = @dcIdInter
			Update sysadm.inter set cod_etat_ctrle_inter = 300 where id_sin = @dcIdSin and id_i = @dcIdInter
			End 

		If @iStatusGc = 820 
			Begin 
			Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ @sLibFour + ' a contrôlé et rejeté (KO) l''interlocuteur ' + @sNomInter + ' (' +  Convert ( varchar (5), @dcIdInter) + ') de type ' + sysadm.FN_CODE_CAR ( @sCodInter, '-IN' ) + ', prenez note des réponses de l''assureur avant de poursuivre l''instruction de votre dossier.'
			Update sysadm.w_inter set cod_etat_ctrle_inter = 200 where id_sin = @dcIdSin and id_i = @dcIdInter
			Update sysadm.inter set cod_etat_ctrle_inter = 200 where id_sin = @dcIdSin and id_i = @dcIdInter
			End 


		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, 'PRS', @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END
		ELSE
		BEGIN
			EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, 'PRS', @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END

	End
-- /[PMO89_RS4822]

-- [VDOC8041]
IF @iStatusGc = 232 And @iStatusGCActuel <> 232
  Begin
	Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ @sLibFour + ' a besoin du code verrou de l''appareil pour continuer son action, merci de prendre contact avec l''assuré pour obtenir le code verrou.'		    

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, 'PRS', @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END
	ELSE
	BEGIN
		EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, 'PRS', @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END

  End
-- [VDOC8041]

-- [PM254_V1]
IF @iStatusGc in ( 265, 266, 267, 268, 302 ) And @iStatusGCActuel <> @iStatusGc 
  Begin
	Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ Isnull ( sysadm.FN_CODE_NUM ( @iStatusGc, '-GC' ), '' ) 		    

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
	END
	ELSE
	BEGIN
		Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
	END
  End
-- [PM254_V1]

-- [PC938_ORANGE_V3]
IF @iStatusGc = 261 And @iStatusGCActuel <> 261
  Begin
	Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Appareil de remplacement réceptionné en boutique ' + @sLibFour 		    

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
	END
	ELSE
	BEGIN
		Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
	END

  End
  
IF @iStatusGc = 262 And @iStatusGCActuel <> 262
  Begin
	Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Appareil de remplacement récupéré par l''assuré en boutique ' + @sLibFour 		    

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
	END
	ELSE
	BEGIN
		Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
	END
  End

IF @iStatusGc = 263 And @iStatusGCActuel <> 263
  Begin
	Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Appareil de prêt restitué par l''assuré.'

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
	END
	ELSE
	BEGIN
		Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
	END

	-- MANTIS8068
	Update sysadm.commande 
	Set cod_etat = 'RPC', comment_frn = 'RPC suite 263 O2M' + @sLibFour
	Where  id_sin = @dcIdSin
	And    id_typ_art not in ( 'PRS', 'EDI', 'RES', 'REL', 'REA' )
	And    cod_etat = 'ECT'
	
	Update sysadm.w_commande 
	Set cod_etat = 'RPC', comment_frn = 'RPC suite 263 O2M' + @sLibFour
	Where  id_sin = @dcIdSin
	And    id_typ_art not in ( 'PRS', 'EDI', 'RES', 'REL', 'REA' )
	And    cod_etat = 'ECT'
	
  End	  

IF @iStatusGc = 233 And @iStatusGCActuel <> 233
  Begin
	Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Appareil de remplacement réceptionné par l''assuré.' 

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
	END
	ELSE
	BEGIN
		Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
	END
  End

-- [DT288]
IF @iStatusGc = 611 And @iStatusGCActuel <> 611
  Begin
	Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Le CTR signale que l''appareil est conforme pour réparation.' 

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
		Exec @iRet=sysadm.PS_S_MAILPUSH_CONFORME_611 @dcIdSin, @iIdSeq, @sIdFour, @iStatusGc, @sCasRetour OUTPUT

	END
	ELSE
	BEGIN
		Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
		Exec @iRet=sysadm.PS_S_MAILPUSH_CONFORME_611 @dcIdSin, @iIdSeq, @sIdFour, @iStatusGc, @sCasRetour OUTPUT
	END
  End

-- [DT288-3_LOT1_2EME_VS]
IF @iStatusGc = 612 And @iStatusGCActuel <> 612
	Begin
	Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Réponse ' + @sLibFour + ' : '+ @sCommentFrn

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
		END
	ELSE
		BEGIN
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
		END
	End

-- [DT150]
/*
 Begin
	IF @iStatusGc in ( 305 ) And @iStatusGCActuel <> @iStatusGc 
	  Begin
	  
		Delete from sysadm.div_sin Where id_sin = @dcIdSin and nom_zone in ( 'dte_cour_geolocation', 'dte_degeoloc_par_ass' ) 
		Delete from sysadm.w_div_sin Where id_sin = @dcIdSin and nom_zone in ( 'dte_cour_geolocation', 'dte_degeoloc_par_ass' ) 

		Update 	sysadm.commande
		Set	info_frn_spb_cplt = sysadm.FN_CLE_VAL_E ( 'GEOLOC', 'A_SUPP', info_frn_spb_cplt, ';')
		Where	id_sin = @dcIdSin
		And	id_seq = @iIdSeq
		
		Update 	sysadm.w_commande
		Set	info_frn_spb_cplt = sysadm.FN_CLE_VAL_E ( 'GEOLOC', 'A_SUPP', info_frn_spb_cplt, ';')
		Where	id_sin = @dcIdSin
		And	id_seq = @iIdSeq
	  
		Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ Isnull ( sysadm.FN_CODE_NUM ( @iStatusGc, '-GC' ), '' ) + '. L''assuré a reçu un courrier automatique lui demandant de dé-géolocaliser son appareil lui-même et de confirmer c
ette dé-géolocalisation via ATLAS.'

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
		END
		ELSE
		BEGIN
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
		END
	  End
 */
-- [DT150]

-- [PM287-3]
IF @iStatusGc in ( 308 ) And @iStatusGCActuel <> @iStatusGc 
	Begin
	  
		Delete from sysadm.div_sin Where id_sin = @dcIdSin and nom_zone in ( 'dte_cour_PM287_3_InfoManq', 'dte_action_PM287_3_par_ass', 'action_ksl_ec_PM287_3' ) 
		Delete from sysadm.w_div_sin Where id_sin = @dcIdSin and nom_zone in ( 'dte_cour_PM287_3_InfoManq', 'dte_action_PM287_3_par_ass', 'action_ksl_ec_PM287_3') 

		-- [RS5045_REF_MATP]
		If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 
		 Begin
				Exec @iRet=sysadm.PS_I_RS5045_MAIL_COUR_PM287_3_INFO_MANQUANTE_KSL @dcIdSin, @iIdSeq 
		 End 
		Else
		 Begin
			Insert into sysadm.div_sin Values ( @dcIdSin, 'action_ksl_ec_PM287_3', 'Action KSL En cours PM287-3', -1, 'N', 'X', 'N', 'N', 500, null, null, null, 'O', Getdate(), Getdate(), 'AUTO', Getdate(), 'AUTO' )
			If Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @dcIdSin ) 
				Begin
					Insert into sysadm.w_div_sin Values ( @dcIdSin, 'action_ksl_ec_PM287_3', 'Action KSL En cours PM287-3', -1, 'N', 'X', 'N', 'N', 500, null, null, null, 'O', 1, Getdate(), Getdate(), 'AUTO' )
				End 
		 End 

		Update 	sysadm.commande
		Set	info_frn_spb_cplt = sysadm.FN_CLE_VAL_E ( 'IFDNMQ_ACT', 'A_FAIRE', info_frn_spb_cplt, ';')
		Where	id_sin = @dcIdSin
		And	id_seq = @iIdSeq
		
		Update 	sysadm.w_commande
		Set	info_frn_spb_cplt = sysadm.FN_CLE_VAL_E ( 'IFDNMQ_ACT', 'A_FAIRE', info_frn_spb_cplt, ';')
		Where	id_sin = @dcIdSin
		And	id_seq = @iIdSeq

		Set @sVal2 = sysadm.FN_CLE_VAL ( 'IFDNMQ_RET', @sInfoFrnSpbCplt, ';')
		Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ Isnull ( sysadm.FN_CODE_NUM ( @iStatusGc, '-GC' ), '' ) + '. L''assuré a reçu un courrier automatique lui demandant de :' + Char (10)
		If CharIndex  ( '#305#', @sVal2 ) > 0 Set @sMess = @sMess + '- dé-géolocaliser son appareil' + Char (10)
		If CharIndex  ( '#232#', @sVal2 ) > 0 Set @sMess = @sMess + '- fournir son code verrou' + Char (10)
		Set @sMess = @sMess + ' via l''extranet dont l''URL se trouve sur le courrier.'

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
			BEGIN
				Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 73, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
			END
		ELSE
			BEGIN
				Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 73, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
			END
	End

-- [PM288-1][LOT2][PM287-3][M25172]
IF @iStatusGc in ( 311 ) And @iStatusGCActuel <> @iStatusGc 
	Begin
	Set @sVal2 = sysadm.FN_CLE_VAL ( 'IFDNMQ_RET', @sInfoFrnSpbCpltActuel, ';')

	Set @sVal3 = ''

	If CharIndex  ( '#305#', @sVal2 ) > 0 Set @sVal3 = sysadm.FN_CLE_VAL_E ( '305', 'FAIT', rtrim ( @sVal3) , ';' ) 
	If CharIndex  ( '#232#', @sVal2 ) > 0 Set @sVal3 = sysadm.FN_CLE_VAL_E ( '232', 'A_FLASHER', rtrim ( @sVal3) , ';' ) 

	Exec sysadm.PS_U_EW_AFFICHAGE_PM287_3 @dcIdSin, 'INTEGRATION', @sVal3
End
-- [PM287-3]



-- [DT141]
IF sysadm.FN_CLE_VAL ( 'FACT_PRESENTE', rtrim ( @sInfoFrnSpbCplt ) , ';') = 'NON' 
   And Not Exists ( Select Top 1 1 From sysadm.div_sin wds Where wds.id_sin = @dcIdSin and wds.nom_zone = 'dte_pce_fact_achat_dem' )
   And @sIdRefFour = 'A_DIAGNOSTIQUER'
   And @iStatusGc in ( 151, 153, 154 )
   And Exists ( select top 1 1 From sysadm.det_pro dp, sysadm.sinistre s where s.id_sin = @dcIdSin And dp.id_prod = s.id_prod And dp.id_code_dp = 275 )
  Begin
  
	Insert into w_piece
	Select Top 1
			wc.id_sin,
			wc.id_gti,
			-1,
			p.id_pce,
			0,
			p.id_para,
			p.cpt_tri,
			GETDATE(),
			GETDATE(),
			'AUTO'
	From sysadm.w_sin ws,
		 sysadm.w_commande wc, 
		 sysadm.piece p
	Where wc.id_sin = @dcIdSin
	And   wc.id_seq = @iIdSeq
	And   ws.id_sin = wc.id_sin
	And   p.id_prod = ws.id_prod
	And   p.id_gti =  wc.id_gti
	And	  p.id_pce = 437
	And	  Not Exists (
		Select Top 1 1
		From sysadm.w_piece p2
		Where p2.id_sin = wc.id_sin
		And	  p2.id_gti = wc.id_gti
		And   p2.id_detail = -1
		And   p2.id_pce = p.id_pce
	)
 
	If @@ROWCOUNT = 1 And @iStatusGc = 151
	 Begin
		
		-- [RS5045_REF_MATP]
		If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0
			 Begin
				 Exec @iRet=sysadm.PS_I_RS5045_MAIL_COUR_DEM_PCE_SFR_SBE_FACT_ACHAT_KSL @dcIdSin, @iIdSeq 
			 End
		Else
			 Begin
				If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @dcIdSin  )	
				  Begin
					If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'pce_fact_achat_adem')
					 Begin
					   Update sysadm.w_div_sin Set val_car = 'O', maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'pce_fact_achat_adem'
					 End 
					Else
					 Begin	 
					   Insert into sysadm.w_div_sin values ( @dcIdSin, 'pce_fact_achat_adem', 'Pièce facture achat SBE à demander', '-1', 'N', 'X', 'N', 'N', 720, null, null, null, 'O', 0, getdate(), getdate(), 'AUTO' ) 
					 End
				  End


				If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @dcIdSin  )	
				  Begin
					If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'pce_fact_achat_adem')
					 Begin
					   Update sysadm.div_sin Set val_car = 'O', maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'pce_fact_achat_adem'
					 End 
					Else
					 Begin	 
					   Insert into sysadm.div_sin values ( @dcIdSin, 'pce_fact_achat_adem', 'Pièce facture achat SBE à demander', '-1', 'N', 'X', 'N', 'N', 720, null, null, null, 'O', getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
					 End
				  End
			End
	  End
  End 

IF @iStatusGc = 178 And @iStatusGCActuel <> 178
   and @sIdTypArt = 'CAF' and @sIdRefFour = 'CMDE_A_CPLTER'
   Begin

   -- [HP252_276_HUB_PRESTA]
   Select @TypArtIfr = 
		  '#' + ( 
		   Select stuff ( 
					( SELECT Distinct '#' + CAST(rtrim ( ltrim ( rtrim ( i.sku_saga )) ) AS VARCHAR(250)) 
					  FROM sysadm.ifr i
					  Where sku_saga is not null
					  For XML PATH ('') )
				, 1, 1, '' )) + '#'

	Select 	@sVal1 = sysadm.FN_TRIM ( IsNull ( ds.val_car, '' ) )
	From 	sysadm.div_sin ds
	Where 	ds.id_sin = @dcIdSin And ds.nom_zone = 'type_app'

	-- [RS4616_RET_TLS]
	-- Problème intégration si montant =0 donc bcv absent par le contrôle PB
	Select  @sVal2 = sysadm.FN_CLE_VAL ( 'MT_TTC_REMPL', rtrim ( @sInfoFrnSpbCplt ) , ';'),
			@dcMtTTCcmde = wc.mt_ttc_cmde,
			@sMarqRempl = sysadm.FN_CLE_VAL ( 'MARQ_REMPL', rtrim ( @sInfoFrnSpbCplt ) , ';'),
			@sModlRempl = sysadm.FN_CLE_VAL ( 'MODL_REMPL', rtrim ( @sInfoFrnSpbCplt ) , ';'),
			@sCoulRempl = sysadm.FN_CLE_VAL ( 'COUL_REMPL', rtrim ( @sInfoFrnSpbCplt ) , ';'),
			@sCapStkRempl = sysadm.FN_CLE_VAL ( 'CAP_STK_REMPL', rtrim ( @sInfoFrnSpbCplt ) , ';')
	From    sysadm.sinistre ws, sysadm.commande wc
	Where	wc.id_sin = @dcIdSin
	And		wc.id_seq = @iIdSeq		
	And		ws.id_sin = wc.id_sin

	If @sVal2 is null Set @sVal2 = '0'
	If IsNumeric ( @sVal2 ) = 0 Set @sVal2 = '0'
	If @sVal2 = '0' Set @sVal2 = Convert ( Varchar ( 10 ), @dcMtTTCcmde ) -- [RS4616_RET_TLS]

	If CharIndex ( 'TO', Upper ( @sCapStkRempl), 1 ) <=0  And 
	   CharIndex ( 'GO', Upper ( @sCapStkRempl), 1 ) <=0  And 
	   CharIndex ( 'GB', Upper ( @sCapStkRempl), 1 ) <=0  Set @sCapStkRempl = @sCapStkRempl + 'GB'

	Set @sModlRempl = rtrim ( ltrim ( @sModlRempl + ' ' + @sCoulRempl + ' ' + @sCapStkRempl ))

   -- [HP252_276_HUB_PRESTA]
   Set @iMarqModlIFr = 0
   If Exists  (
		Select top 1 1 From sysadm.ifr i
		Where i.marque = @sMarqRempl
		And   i.reference = @sModlRempl
   ) 
	Begin
		Set @iMarqModlIFr = 1
	End 


	Update 	sysadm.w_commande
	Set	id_marq_art		= @sMarqRempl, 
		id_modl_art		= @sModlRempl,
		mt_ttc_cmde		= Round ( Convert ( decimal (11,2 ) , @sVal2), 2 ), 
		id_marq_art_ifr = 
			Case 
				When @iMarqModlIFr > 0 Then @sMarqRempl -- [HP252_276_HUB_PRESTA]

				When @sIdFour = 'TLS' Then 
						(	Select Top 1 rtrim (la.marq_ifr ) 
							from sysadm.lien_article la 
							Where la.id_four = 'TLS'
							And la.marq_four = Left ( @sMarqRempl, 35)
							And la.modl_four = Left ( @sModlRempl, 35)
						)
				When @iPrestaHUB > 0 Then -- [HP252_276_HUB_PRESTA]
						(	Select Top 1 rtrim (la.marq_ifr ) 
							from sysadm.lien_article la 
							Where la.id_four = 'HUP'
							And la.marq_four = Left ( @sMarqRempl, 35)
							And la.modl_four = Left ( @sModlRempl, 35)
						)

				Else ws.marq_port
			End,		
		id_modl_art_ifr =
			Case 
				When @iMarqModlIFr > 0 Then @sModlRempl -- [HP252_276_HUB_PRESTA]

				When @sIdFour = 'TLS' Then 
					(	Select Top 1 rtrim ( la.modl_ifr ) 
						from sysadm.lien_article la 
						Where la.id_four = 'TLS'
						And la.marq_four = Left ( @sMarqRempl, 35)
						And la.modl_four = Left ( @sModlRempl, 35)
					)

				When @iPrestaHUB > 0 Then -- [HP252_276_HUB_PRESTA]
						(	Select Top 1 rtrim (la.modl_ifr ) 
							from sysadm.lien_article la 
							Where la.id_four = 'HUP'
							And la.marq_four = Left ( @sMarqRempl, 35)
							And la.modl_four = Left ( @sModlRempl, 35)
						)

				Else ws.modl_port
			End,
		id_typ_art = @sVal1 
	From    sysadm.w_sin ws, sysadm.w_commande wc
	Where	wc.id_sin = @dcIdSin
	And		wc.id_seq = @iIdSeq		
	And		ws.id_sin = wc.id_sin

	Update 	sysadm.commande
	Set	id_marq_art		= @sMarqRempl, 
		id_modl_art		= @sModlRempl,
		mt_ttc_cmde		= Round ( Convert ( decimal (11,2 ) , @sVal2 ), 2 ), 
		id_marq_art_ifr = 
			Case 
				When @iMarqModlIFr > 0 Then @sMarqRempl -- [HP252_276_HUB_PRESTA]

				When @sIdFour = 'TLS' Then 
						(	Select Top 1 rtrim (la.marq_ifr ) 
							from sysadm.lien_article la 
							Where la.id_four = 'TLS'
							And la.marq_four = Left ( @sMarqRempl, 35)
							And la.modl_four = Left ( @sModlRempl, 35)
						)

				When @iPrestaHUB > 0 Then -- [HP252_276_HUB_PRESTA]
						(	Select Top 1 rtrim (la.marq_ifr ) 
							from sysadm.lien_article la 
							Where la.id_four = 'HUP'
							And la.marq_four = Left ( @sMarqRempl, 35)
							And la.modl_four = Left ( @sModlRempl, 35)
						)

				Else ws.marq_port
			End,		
		id_modl_art_ifr =
			Case 
				When @iMarqModlIFr > 0 Then @sModlRempl -- [HP252_276_HUB_PRESTA]

				When @sIdFour = 'TLS' Then 
					(	Select Top 1 rtrim ( la.modl_ifr ) 
						from sysadm.lien_article la 
						Where la.id_four = 'TLS'
						And la.marq_four = Left ( @sMarqRempl, 35)
						And la.modl_four = Left ( @sModlRempl, 35)
					)

				When @iPrestaHUB > 0 Then -- [HP252_276_HUB_PRESTA]
						(	Select Top 1 rtrim (la.modl_ifr ) 
							from sysadm.lien_article la 
							Where la.id_four = 'HUP'
							And la.marq_four = Left ( @sMarqRempl, 35)
							And la.modl_four = Left ( @sModlRempl, 35)
						)

				Else ws.modl_port
			End,
		id_typ_art = @sVal1 
	From    sysadm.sinistre ws, sysadm.commande wc
	Where	wc.id_sin = @dcIdSin
	And		wc.id_seq = @iIdSeq		
	And		ws.id_sin = wc.id_sin
			
	If ( @sIdFour = 'TLS' Or @iPrestaHUB > 0 ) -- [HP252_276_HUB_PRESTA]
	   And CHARINDEX ( '#' + @sVal1 + '#', @TypArtIfr ) > 0 -- [HP252_276_HUB_PRESTA]
	   And @iMarqModlIFr <= 0 -- [HP252_276_HUB_PRESTA]
		Begin
		If Not Exists ( 
			Select Top 1 1 
			From sysadm.article a
			Where ( a.id_four = @sIdFour Or ( @iPrestaHUB > 0 And a.id_four = 'HUP' )) -- [HP252_276_HUB_PRESTA]
			And   a.id_marq_art = Left ( @sMarqRempl, 35)
			And   a.id_modl_art = Left ( @sModlRempl, 35)
		)
		Begin 

			Set @sNewIdRefFour = Replace ( Replace ( Replace ( convert( varchar ( 30), GetDate(), 120 ), '-', ''), ' ', ''), ':', '')
			Set @sNewIdRefFourTest = @sNewIdRefFour 

			Set @iCptId = 1
			Set @sNewIdRefFourTest = @sNewIdRefFour + '_' + convert ( varchar (5), @iCptId )

			While Exists ( Select Top 1 1
							From sysadm.article a with (nolock)
							Where a.id_four = @sIdFour
							And   a.id_ref_four = @sNewIdRefFourTest )
				Begin
					Set @iCptId = @iCptId + 1
					Set @sNewIdRefFourTest = @sNewIdRefFour + '_' + convert ( varchar (5), @iCptId )
				End

			Insert into sysadm.article 
			Select	Case 
						When @iPrestaHUB > 0 Then 'HUP'
						Else @sIdFour
					End, -- [HP252_276_HUB_PRESTA]
					@sNewIdRefFourTest,
					@sVal1, -- [HP252_276_HUB_PRESTA]
					Left ( @sMarqRempl, 35),
					Left ( @sModlRempl, 35),
					0,
					0,
					20000,
					null,
					'N',
					(	Select Top 1 rtrim ( la.marq_ifr ) 
						from sysadm.lien_article la 
						Where  ( la.id_four = @sIdFour Or ( @iPrestaHUB > 0 And la.id_four = 'HUP' )) -- [HP252_276_HUB_PRESTA]
						And la.marq_four = Left ( @sMarqRempl, 35)
						And la.modl_four = Left ( @sModlRempl, 35)
						),
					(	Select Top 1 rtrim ( la.modl_ifr ) 
						from sysadm.lien_article la 
						Where ( la.id_four = @sIdFour Or ( @iPrestaHUB > 0 And la.id_four = 'HUP' )) -- [HP252_276_HUB_PRESTA]
						And la.marq_four = Left ( @sMarqRempl, 35)
						And la.modl_four = Left ( @sModlRempl, 35)
						),
					200,
					1,
					getdate(),
					getdate(),
					'JFF'
		End
	End 

  End
  
-- [VDOC9908]
IF @iStatusGc = 178 And @iStatusGCActuel <> 178
   and @sIdTypArt = 'RST' and sysadm.FN_CLE_VAL ( 'RST_CMDE+SUIVI', rtrim ( @sInfoSpbFrnCpltActuel ) , ';') = 'OUI'
   Begin

	Select 	@sVal1 = sysadm.FN_TRIM ( IsNull ( ds.val_car, '' ) )
	From 	sysadm.div_sin ds
	Where 	ds.id_sin = @dcIdSin And ds.nom_zone = 'type_app'
	 
	Update 	sysadm.w_commande
	Set	id_marq_art		= sysadm.FN_CLE_VAL ( 'MARQ_RST_FRN', rtrim ( @sInfoFrnSpbCplt ) , ';'), 
		id_modl_art		= sysadm.FN_CLE_VAL ( 'MODL_RST_FRN', rtrim ( @sInfoFrnSpbCplt ) , ';'),
		id_ref_four		= sysadm.FN_CLE_VAL ( 'ID_REF_FOUR_RST_FRN', rtrim ( @sInfoFrnSpbCplt ) , ';'), 
		mt_ttc_cmde		= Round ( Convert ( decimal (11,2 ) , sysadm.FN_CLE_VAL ( 'PRIX_HT_RST_FRN', rtrim ( @sInfoFrnSpbCplt ) , ';')) * 1.2 , 2 ), -- TVA -- [DT_60_AUGM_TVA] 1.196
		id_marq_art_ifr = ws.marq_port,		
		id_modl_art_ifr = ws.modl_port,
		id_typ_art = @sVal1 
	From    sysadm.w_sin ws, sysadm.w_commande wc
	Where	wc.id_sin = @dcIdSin
	And		wc.id_seq = @iIdSeq		
	And		ws.id_sin = wc.id_sin

	Update 	sysadm.commande
	Set	id_marq_art		= sysadm.FN_CLE_VAL ( 'MARQ_RST_FRN', rtrim ( @sInfoFrnSpbCplt ) , ';'), 
		id_modl_art		= sysadm.FN_CLE_VAL ( 'MODL_RST_FRN', rtrim ( @sInfoFrnSpbCplt ) , ';'),
		id_ref_four		= sysadm.FN_CLE_VAL ( 'ID_REF_FOUR_RST_FRN', rtrim ( @sInfoFrnSpbCplt ) , ';'), 
		mt_ttc_cmde		= Round ( Convert ( decimal (11,2 ) , sysadm.FN_CLE_VAL ( 'PRIX_HT_RST_FRN', rtrim ( @sInfoFrnSpbCplt ) , ';')) * 1.2 , 2 ), -- TVA -- [DT_60_AUGM_TVA]
		id_marq_art_ifr = ws.marq_port,		
		id_modl_art_ifr = ws.modl_port,
		id_typ_art = @sVal1 
	From    sysadm.sinistre ws, sysadm.commande wc
	Where	wc.id_sin = @dcIdSin
	And		wc.id_seq = @iIdSeq		
	And		ws.id_sin = wc.id_sin

	-- [PM426-3]
	If Exists ( 
			Select Top 1 1
			From   sysadm.commande c
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    sysadm.FN_CLE_VAL ( 'RST_CMDE+SUIVI', info_spb_frn_cplt, ';' ) = 'OUI'
			)
		Begin
			Update sysadm.article
			Set qt_disp = Case 
						When qt_disp - 1 > 0 Then qt_disp - 1
						Else 0
						End
			From sysadm.commande c,
				 sysadm.article a
			Where c.id_sin = @dcIdSin
			And   c.id_seq = @iIdSeq
			And   a.id_four = c.id_four
			And   a.id_ref_four = c.id_ref_four
		End 
   End

-- [MIG82_JOURN_EVT]
If sysadm.FN_CLE_NUMERIQUE ( 'MIG82_JOURN_EVT') > 0 
	Begin
		
		IF ( @iStatusGc = 2 And @iStatusGCActuel <> 2 ) Or ( @iStatusGc = 178 And @iStatusGCActuel <> 178 )
		   Begin
				Select  @sVal = lTrim ( rTrim ( cGti.lib_gti ))
				From sysadm.sinistre s with (nolock),
					 sysadm.code_garantie cGti with (nolock)
				Where s.id_sin = @dcIdSin
				And   cGti.id_prod = s.id_prod
				And   cGti.id_gti = @dcIdGti

				Set @sVar = ''
				Set @sVar = sysadm.FN_CLE_VAL_E ( 'LIB_GARANTIE', @sVal, @sVar, ';' )

				Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'GTINDM', @sVar, '', 'PS_U01_COMMANDE', 'AUTO'	
		   End 

		IF ( @iStatusGc = 178 Or @iStatusGCActuel = 178 )
		   and sysadm.FN_CLE_VAL ( 'TYPE_REMPL', rtrim ( @sInfoSpbFrnCpltActuel ) , ';') = 'REMPL_APPAREIL'
		   Begin
			Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'CMDAPP', '', '', 'PS_U01_COMMANDE', 'AUTO'
		   End 

		IF ( @iStatusGc = 178 Or @iStatusGCActuel = 178 )
		   and sysadm.FN_CLE_VAL ( 'TYPE_REMPL', rtrim ( @sInfoSpbFrnCpltActuel ) , ';') = 'REMPL_APPAREIL'
		   and 	@dtDteRcpMobCli	is not null
		   And  @dtDteRcpMobCliActuel is null 
		   Begin
			Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'CDRPLV', '', '', 'PS_U01_COMMANDE', 'AUTO'
		   End 

		IF @iStatusGc = 2 And @iStatusGCActuel <> 2
		   Begin
			Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'APPREP', '', '', 'PS_U01_COMMANDE', 'AUTO'
		   End 

		IF ( @iStatusGc = 2 Or @iStatusGCActuel = 2 )
		   and 	@dtDteRcpMobCli	is not null
		   And  @dtDteRcpMobCliActuel is null 
		   Begin
			Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'APPRPL', '', '', 'PS_U01_COMMANDE', 'AUTO'	
		   End 

		IF ( @iStatusGc = 851 And @iStatusGCActuel <> 851 ) Or ( @iStatusGc = 855 And @iStatusGCActuel <> 855 )
		   Begin
			Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'RDVIND', '', '', 'PS_U01_COMMANDE', 'AUTO'
		   End 

		IF @iStatusGc = 853 And @iStatusGCActuel <> 853
		   Begin
			Set @sVal = sysadm.FN_CLE_VAL ( 'RDV_CONF', @sInfoFrnSpbCplt, ';' )
			IF @sVal is not null and LEN ( @sVal ) > 0 
				Begin
					Set @sVar = sysadm.FN_CLE_VAL_E ( 'DTE_RDV', @sVal, @sVar, ';' )
					Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'DVISIO', @sVar, '', 'PS_U01_COMMANDE', 'AUTO'
				End 
		   End 

		IF @iStatusGc = 854 And @iStatusGCActuel <> 854
		   Begin
			Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'CDPCEC', '', '', 'PS_U01_COMMANDE', 'AUTO'
		   End 

		IF @iStatusGc = 152 And @iStatusGCActuel <> 152 And CharIndex ( '[PRDV]', @sCommentFrn, 1 ) > 0
		   Begin			
			Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'DRSDVI', '', '', 'PS_U01_COMMANDE', 'AUTO'
		   End 

		IF @iStatusGc = 157 And @iStatusGCActuel <> 157 
		   Begin			
			Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'NRDVCF', '', '', 'PS_U01_COMMANDE', 'AUTO'
		   End 

		IF @iStatusGc = 156 And @iStatusGCActuel <> 156
		   Begin
			Set @sVal = sysadm.FN_CLE_VAL ( 'RDV_CONF', @sInfoFrnSpbCplt, ';' )
			IF @sVal is not null and LEN ( @sVal ) > 0 
				Begin
					Set @sVar = sysadm.FN_CLE_VAL_E ( 'DTE_RDV', @sVal, @sVar, ';' )
					Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'RDVDOM', @sVar, '', 'PS_U01_COMMANDE', 'AUTO'
				End 
		   End 

		-- APPECT - APPEXP - APPCNS
		Set @sVal = sysadm.FN_CLE_VAL ( 'INFO_JOURNAL', @sInfoFrnSpbCplt, ';' )
		IF @sVal is not null and LEN ( @sVal ) > 0 
			Begin
				Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, @sVal, '', '', 'PS_U01_COMMANDE', 'AUTO'				
			End 
	End

IF @iStatusGc = 176 And @iStatusGCActuel <> 176
  Begin
	Update sysadm.commande 
	Set cod_etat = 'ANN', comment_frn = 'Retour 176 du grossiste ' + @sLibFour + '.'
	Where  id_sin = @dcIdSin
	And    id_typ_art = 'REL'
	And    cod_etat = 'ECT'
	
	Update sysadm.w_commande 
	Set cod_etat = 'ANN', comment_frn = 'Retour 176 du grossiste ' + @sLibFour + '.'
	Where  id_sin = @dcIdSin
	And    id_typ_art = 'REL'
	And    cod_etat = 'ECT'		

	Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Impossible d''honorer la commande (Rupture de Stock).'

	-- [PM289_CDP]
	If @sIdFour in ( 'CDP' ) 
	 Begin
		If @sCasAnoCdp = 'OUI' 
		 Begin
			Select @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Commande annulée par le fournisseur. Veuillez règler l''assuré en numéraire.' 		 
		 End 
		Else
		 Begin
			Select @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Commande annulée par le fournisseur. Veuillez repasser une commande.' 		 
		 End 
	 
	 End 

	 	-- [DT339]
	If @sIdFour in ( 'CMA' ) 
	 Begin
		If sysadm.FN_CLE_VAL('STATUT',@sInfoFrnSpbCplt,';') = 'KO'
		 Begin
			Select @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Commande annulée par le fournisseur. Email non adressé pour adresse KO.' 		 
		 End 
		Else
		 Begin
			Select @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Commande annulée par le fournisseur. Le client n''a pas été chercher son BA.' 		 
		 End 
	 
	 End 


	Update sysadm.commande 
	Set comment_frn = 'Retour 176 du grossiste ' + @sLibFour + ' (Rupture de stock).' +
		-- [PM462-1][V3]
		Case 
			When Convert ( decimal (11,2 ), @sMtPaiementPayBox  ) > 0 
				Then 'Vous devez rembourser à l''assuré la franchise de ' + @sMtPaiementPayBox + '€ avec l''événement 1461 "Remb. franchise par SPB à l''assuré" sur une seule validation.'
			Else ''
		End 
	Where  id_sin = @dcIdSin
	And    id_seq = @iIdSeq
	
	Update sysadm.w_commande 
	Set comment_frn = 'Retour 176 du grossiste ' + @sLibFour + ' (Rupture de stock).' +
		-- [PM462-1][V3]
		Case 
			When Convert ( decimal (11,2 ), @sMtPaiementPayBox  ) > 0 
				Then 'Vous devez rembourser à l''assuré la franchise de ' + @sMtPaiementPayBox + '€ avec l''événement 1461 "Remb. franchise par SPB à l''assuré" sur une seule validation.'
			Else ''
		End 

	Where  id_sin = @dcIdSin
	And    id_seq = @iIdSeq

	-- [HP252_276_HUB_PRESTA]
	If @iPrestaHUB > 0 
		Begin
			Update sysadm.commande 
			Set comment_frn = @sCommentFrn
			Where  id_sin = @dcIdSin
			And    id_seq = @iIdSeq

			Update sysadm.w_commande 
			Set comment_frn = @sCommentFrn
			Where  id_sin = @dcIdSin
			And    id_seq = @iIdSeq

			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> ' + @sCommentFrn

		End 

    -- [PM462-1][V3]
/*
	If sysadm.FN_CLE_NUMERIQUE ( 'PM462-1') >= 0 
	 Begin
		If Convert ( decimal (11,2 ), @sMtPaiementPayBox  ) > 0 
		  Begin
			Set @sMess = @sMess + ' De plus, l''assuré avait payé une franchise de ' + @sMtPaiementPayBox + '€ que vous devez lui rembourser en suivant un process précis, à savoir rembourser cette franchise sur un détail de garantie instruit avec l''événement 1461 "Remb. franchise par SPB à l''assuré" sur une seule validation.'

			-- Enfin maj param si 1461 absent.
			Exec sysadm.PS_I_CREATION_AUTO_PARAM_CONDITION @dcIdProd, @dcIdRev, @dcIdGti, '+EV', 1461, 'N'
		  End
	 End 
*/

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END
	ELSE
	BEGIN
		EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END				 
	
  End 	   
  
IF ( @iStatusGc = 235 And @iStatusGCActuel <> 235 ) Or 
   ( @iStatusGc = 236 And @iStatusGCActuel <> 236 ) Or 
   ( @iStatusGc = 237 And @iStatusGCActuel <> 237 )
  Begin

	If @iStatusGc = 235 
	 Begin
		Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Matériel sinistré différent, récupération impossible.'
	 End 

	If @iStatusGc = 236 
	 Begin
		Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Matériel sinistré absent, récupération impossible.'
	 End 

	If @iStatusGc = 237 
	 Begin
		Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] -> Matériel sinistré différent ou absent suite seconde visite, récupération impossible, dossier à cloturer.'
		Update sysadm.commande 
		Set cod_etat = 'RPC', comment_frn = 'RPC suite 237 O2M' + @sLibFour
		Where  id_sin = @dcIdSin
		And    id_typ_art = 'PRS'
		And    cod_etat = 'ECT'
		And    id_four = 'PSM'
		And    @sIdFour = 'O2M'
		
		Update sysadm.w_commande 
		Set cod_etat = 'RPC', comment_frn = 'RPC suite 237 O2M' + @sLibFour
		Where  id_sin = @dcIdSin
		And    id_typ_art = 'PRS'
		And    cod_etat = 'ECT'
		And    id_four = 'PSM'
		And    @sIdFour = 'O2M'						
	 End 

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END
	ELSE
	BEGIN
		EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END				 
	
  End 	   
-- [PC938_ORANGE_V3]

-- [PM250-1]
IF @iStatusGc = 264 And @iStatusGCActuel <> 264
  Begin
	Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Rupture de stock de pièces détachées.'

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
	END
	ELSE
	BEGIN
		Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
	END
  End	  
 
IF @iStatusGc = 239 And @iStatusGCActuel <> 239
  Begin
	Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Rupture de stock sur l''appareil demandé (prêt ou remplacement).'

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
	END
	ELSE
	BEGIN
		Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
	END
  End	  
-- [PM250-1]

-- [PM284-1]
IF @iStatusGc = 303 And @iStatusGCActuel <> 303
  Begin
	Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Réception colis vide, fermeture auto de la prestation.' 

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END
	ELSE
	BEGIN
		EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END				 
  End 
-- [PM284-1] 
 
 -- [DT156]
IF @iStatusGc = 304 And @iStatusGCActuel <> 304
Begin
	Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Le ScapSav Leclerc refuse l''intervention, repassez en process normal via la création d''une nouvelle presta diag'  		    

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END
	ELSE
	BEGIN
		EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END	
End

-- [PM445-1]
If @dtDteRcpFrnActuel is null And @dtDteRcpFrn is null And ( @idBonTranspActuel is null Or @idBonTranspActuel ='' ) And @idBonTransp is not null
	And @sIdRefFour in ( 'A_REPARER', 'A_DESOXYDER', 'A_DIAGNOSTIQUER' )
	Begin
		Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'numéro de tracking ALLER : ' + rTrim ( lTrim ( @idBonTransp ))

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
		END
		ELSE
		BEGIN
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
		END
   End
 
-- [DT209]
If sysadm.FN_CLE_NUMERIQUE ( 'DT209') > 0 
 Begin
	IF @iStatusGc = 601 And @iStatusGCActuel <> 601
	  Begin
		Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Bon émargé disponible'
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END
		ELSE
		BEGIN
			EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END	
	  End
	IF @iStatusGc = 602 And @iStatusGCActuel <> 602
	  Begin
		Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Bon non émargé'
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END
		ELSE
		BEGIN
			EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END	
	  End
 End
 
 -- [PC874_2_V1]
IF ( @iStatusGc = 621 And @iStatusGCActuel <> 621 ) Or ( @iStatusGc = 622 And @iStatusGCActuel <> 622 )
 Begin
	Exec sysadm.PS_U_RETOUR_CTRLE_IMEI_OMT
		@dcIdSin,
		@dcIdGti,
		@iIdSeq,
		@iStatusGc,
		@sIdFour,
		@dtDteEnvCli,
		@sLibFour
 End


  -- [PC874_2_V1]
IF ( @iStatusGc = 402 And @iStatusGCActuel <> 402)
	Begin
		Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Carte cadeau refusée par ElectroDépot, prestation automatiquement annulée, reprenez la gestion du dossier.'
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
			BEGIN
				EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
			END
		ELSE
			BEGIN
				EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
			END			
	End

-- [DT424]
/*
If sysadm.FN_CLE_NUMERIQUE ( 'DT424') > 0 
 Begin

     INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cree_le, maj_le, maj_par, valide_le, valide_par )
		SELECT	@dcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N', dp.cpt_tri, 0, GETDATE(), GETDATE(), 'SQL', GETDATE(), 'SQL'
		FROM	sysadm.div_pro dp
		WHERE	dp.id_prod	=  @dcIdProd
			AND	dp.nom_zone	in ('cra_suivi_imei' )
			And not Exists (select * from sysadm.div_sin d where d.id_sin=@dcIdSin and d.nom_zone=dp.nom_zone)
			
	INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cpt_valide, cree_le, maj_le, maj_par )
		SELECT	@dcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N', dp.cpt_tri, 0, 1, GETDATE(), GETDATE(), 'SQL'
		FROM	div_pro dp
		WHERE	dp.id_prod	= @dcIdProd
			AND	dp.nom_zone	in ('cra_suivi_imei' )
			And not Exists (select * from sysadm.w_div_sin d where d.id_sin=@dcIdSin and d.nom_zone=dp.nom_zone)
			And Exists (select * from sysadm.w_sin s where s.id_sin=@dcIdSin)

	IF ( @iStatusGc = 710 And @iStatusGCActuel <> 710 ) 
	  Begin 
		update sysadm.w_div_sin set val_nbre = 1 where id_sin=@dcIdSin and nom_zone='cra_suivi_imei'
		update sysadm.div_sin set val_nbre = 1 where id_sin=@dcIdSin and nom_zone='cra_suivi_imei'

		Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Retour Contestation IMEI : Cas simple > Le client possède une assurance mono produit, Orange répond en fournissant les éléments.'
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'	BEGIN EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'	END	ELSE BEGIN EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C' END			
	  End 

	IF ( @iStatusGc = 715 And @iStatusGCActuel <> 715 ) 
	  Begin 
		update sysadm.w_div_sin set val_nbre = 11 where id_sin=@dcIdSin and nom_zone='cra_suivi_imei'
		update sysadm.div_sin set val_nbre = 11 where id_sin=@dcIdSin and nom_zone='cra_suivi_imei'

		Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Retour Contestation IMEI : Cas simple > Le client possède une assurance mono-produit, Orange répond en laissant en blanc le titulaire  (car différent du nom fourni par SPB).'

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'	BEGIN EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'	END	ELSE BEGIN EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C' END				  
  	  End 

	IF ( @iStatusGc = 720 And @iStatusGCActuel <> 720 ) 
	  Begin 
		update sysadm.w_div_sin set val_nbre = 1 where id_sin=@dcIdSin and nom_zone='cra_suivi_imei'
		update sysadm.div_sin set val_nbre = 1 where id_sin=@dcIdSin and nom_zone='cra_suivi_imei'

		Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Retour Contestation IMEI : Cas multi > Le client possède une assurance multi-produit, Orange répond en complétant le nom titulaire car Orange a trouvé un lien avec celui fourni par SPB (SPB a en charge de vérifier).'
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'	BEGIN EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'	END	ELSE BEGIN EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C' END				  
  	  End 

	IF ( @iStatusGc = 725 And @iStatusGCActuel <> 725 ) 
	  Begin 
		update sysadm.w_div_sin set val_nbre = 4 where id_sin=@dcIdSin and nom_zone='cra_suivi_imei'
		update sysadm.div_sin set val_nbre = 4 where id_sin=@dcIdSin and nom_zone='cra_suivi_imei'

		Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Retour Contestation IMEI : Cas FREE > Le client possède une assurance, Orange répond en laissant en blanc le titulaire (IMSI = 20815 => client FREE), n/a Orange ne connait pas l''identité associé (itinérance FREE).'
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'	BEGIN EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'	END	ELSE BEGIN EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C' END				  
  	  End 

	IF ( @iStatusGc = 730 And @iStatusGCActuel <> 730 ) 
	  Begin 
		update sysadm.w_div_sin set val_nbre = 1 where id_sin=@dcIdSin and nom_zone='cra_suivi_imei'
		update sysadm.div_sin set val_nbre = 1 where id_sin=@dcIdSin and nom_zone='cra_suivi_imei'

		Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Retour Contestation IMEI : Cas chgt de n° > Le client possède une assurance (mono ou multi), Orange répond en fournissant les 2 n° associés au même IMSI (i.e même carte SIM) ici, le client a une multi donc le n° sinistré n''est pas forcément identique au n° du titulaire de l''assurance.'
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'	BEGIN EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'	END	ELSE BEGIN EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C' END				  
  	  End 

	IF ( @iStatusGc = 735 And @iStatusGCActuel <> 735 ) 
	  Begin 
		update sysadm.w_div_sin set val_nbre = 1 where id_sin=@dcIdSin and nom_zone='cra_suivi_imei'
		update sysadm.div_sin set val_nbre = 1 where id_sin=@dcIdSin and nom_zone='cra_suivi_imei'

		Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Retour Contestation IMEI : Cas  chgt de  carte SIM > Le client possède une assurance (mono ou multi), Orange répond en fournissant les n° associés et les 2 IMSI (indiquant le chgt de carte SIM).'
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'	BEGIN EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'	END	ELSE BEGIN EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C' END				  
  	  End 

	IF ( @iStatusGc = 740 And @iStatusGCActuel <> 740 ) 
	  Begin 
		update sysadm.w_div_sin set val_nbre = 3 where id_sin=@dcIdSin and nom_zone='cra_suivi_imei'
		update sysadm.div_sin set val_nbre = 3 where id_sin=@dcIdSin and nom_zone='cra_suivi_imei'

		Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Retour Contestation IMEI : Pas de trafic observé sur le réseau Orange.'
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'	BEGIN EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'	END	ELSE BEGIN EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sIdFour, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C' END				  
  	  End 

    INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cree_le, maj_le, maj_par, valide_le, valide_par )
		SELECT	@dcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N', dp.cpt_tri, 0, GETDATE(), GETDATE(), 'SQL', GETDATE(), 'SQL'
		FROM	sysadm.div_pro dp
		WHERE	dp.id_prod	=  @dcIdProd
			AND	dp.nom_zone	in ('cra_last_dte' )
			And not Exists (select * from sysadm.div_sin d where d.id_sin=@dcIdSin and d.nom_zone=dp.nom_zone)
			
	INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cpt_valide, cree_le, maj_le, maj_par )
		SELECT	@dcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N', dp.cpt_tri, 0, 1, GETDATE(), GETDATE(), 'SQL'
		FROM	div_pro dp
		WHERE	dp.id_prod	= @dcIdProd
			AND	dp.nom_zone	in ('cra_last_dte' )
			And not Exists (select * from sysadm.w_div_sin d where d.id_sin=@dcIdSin and d.nom_zone=dp.nom_zone)
			And Exists (select * from sysadm.w_sin s where s.id_sin=@dcIdSin)

	Set @sVal1 = sysadm.FN_CLE_VAL ( 'DTE_DDU_1', @sInfoFrnSpbCplt, ';' )
	If @sVal1 is null Set @sVal1 = ''
	
	update sysadm.w_div_sin set val_dte=Convert ( DateTime, nullif ( @sVal1, '' ) ) where id_sin=@dcIdSin and nom_zone='cra_last_dte'
	update sysadm.div_sin   set val_dte=Convert ( DateTime, nullif ( @sVal1, '' )) where id_sin=@dcIdSin and nom_zone='cra_last_dte'

 End 
*/
-- /[DT424]

-- #6 [DCMP080077] Gestion des codes alpha dans le commentaire fournisseur.
-- [PM200][LOT2][DESOX] Ajout du regard code 21
-- [PC929-1] ajoue [PIE]
-- [VDOC27123]BVID/BVIP/BVIT
IF ( 
	( CharIndex ( '[BVIE]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVIE]', @sCommentFrnActuel, 1 ) = 0 ) 
	Or 
	( CharIndex ( '[BVID]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVID]', @sCommentFrnActuel, 1 ) = 0 ) 
	Or 
	( CharIndex ( '[BVIP]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVIP]', @sCommentFrnActuel, 1 ) = 0 ) 
	Or 
	( CharIndex ( '[BVIT]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVIT]', @sCommentFrnActuel, 1 ) = 0 ) 
	Or 
	( CharIndex ( '[PIE]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[PIE]', @sCommentFrnActuel, 1 ) = 0 ) 
   )
   And @iStatusGc = 21 
  
  BEGIN

	-- [PC877]
	Set @iCasPropoAutoO2m = 0
	Set @iCasPropoAutoVpp = 0
	Set @iCasPropoAutoAas = 0 -- [DT363]

	If Exists ( select * from sysadm.det_pro where id_prod=@dcIdProd and id_code_dp=235 ) 
	 Begin
		Set @iCasPropoAutoVpp = 1
	 End 

	-- [DT363]
	If  @sTypAppSin = 'TEL'
		And 
		Exists ( 
			Select Top 1 1 
			From sysadm.commande_type ct
			Where ct.id_prod = @dcIdProd
			And   ct.id_code_frn = 'AAS'
			And   ct.id_code_art = 'CAF'
		)
		And 
		Not Exists ( 
			Select Top 1 1 
			From   sysadm.commande c
			Where  c.id_sin = @dcIdSin
			And    c.id_four = 'AAS'
		)
		Begin
			Set @iCasPropoAutoAas = 1 -- [DT363]
		End 

	Set @sIRR = 'OK'

	-- [MANTIS14479]
	-- [VDOC27123]BVID/BVIP/BVIT
	-- [VDOC27291]
	If CharIndex ( '[BVIE]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVIE]', @sCommentFrnActuel, 1 ) = 0 
	 Begin
		Set @sMess = 'Message automatique suite retour fournisseur : Attention, dossier bris visible irréparable économique, vous pouvez continuer l''instruction du dossier'

		-- [MIG82_JOURN_EVT]
		If sysadm.FN_CLE_NUMERIQUE ( 'MIG82_JOURN_EVT') > 0 
			Begin
				Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'IRPIND', '', '', 'PS_U01_COMMANDE', 'AUTO'	
			End 
	 End

	If CharIndex ( '[BVID]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVID]', @sCommentFrnActuel, 1 ) = 0 
	 Begin
		Set @sMess = 'Message automatique suite retour fournisseur : Attention, dossier bris visible irréparable délai, vous pouvez continuer l''instruction du dossier'

		-- [MIG82_JOURN_EVT]
		If sysadm.FN_CLE_NUMERIQUE ( 'MIG82_JOURN_EVT') > 0 
			Begin
				Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'IRPIND', '', '', 'PS_U01_COMMANDE', 'AUTO'	
			End 
	 End 

	If  CharIndex ( '[BVIP]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVIP]', @sCommentFrnActuel, 1 ) = 0 
	 Begin
		Set @sMess = 'Message automatique suite retour fournisseur : Attention, dossier bris visible irréparable pièce indisponible, vous pouvez continuer l''instruction du dossier'

		-- [MIG82_JOURN_EVT]
		If sysadm.FN_CLE_NUMERIQUE ( 'MIG82_JOURN_EVT') > 0 
			Begin
				Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'IRPIND', '', '', 'PS_U01_COMMANDE', 'AUTO'	
			End 
	 End 

	If  CharIndex ( '[BVIT]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVIT]', @sCommentFrnActuel, 1 ) = 0 
	 Begin
		Set @sMess = 'Message automatique suite retour fournisseur : Attention, dossier bris visible irréparable technique, vous pouvez continuer l''instruction du dossier'

		-- [MIG82_JOURN_EVT]
		If sysadm.FN_CLE_NUMERIQUE ( 'MIG82_JOURN_EVT') > 0 
			Begin
				Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'IRPIND', '', '', 'PS_U01_COMMANDE', 'AUTO'	
			End 
	 End 
	   

	-- [MANTIS14479]
	If ( ( CharIndex ( '[PIE]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[PIE]', @sCommentFrnActuel, 1 ) = 0 ))
	 Begin
		Set @sMess = 'Message automatique suite retour fournisseur : Attention, dossier panne visible irréparable économique, vous pouvez continuer l''instruction du dossier'
	 End
	  
	  -- #14 [DCMP090282] sur le BVIE, ajout pour Darty Tel
	  If @dcIdProd in ( 5706, 5760 )
		Begin 
	  		If Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = @dcIdSin And ds.nom_zone = 'choix_pack' )
	  			Begin
					Select 	@sValChoixPack = sysadm.FN_TRIM ( IsNull ( ds.val_car, '' ) )
					From 	sysadm.div_sin ds
					Where 	ds.id_sin = @dcIdSin And ds.nom_zone = 'choix_pack'
					
					If @sValChoixPack is null Set @sValChoixPack = ''
					
					If @sValChoixPack = ''
						Begin 
		   					Update sysadm.div_sin Set val_car = '1F1' Where id_sin = @dcIdSin and nom_zone = 'choix_pack'						
						End 
						
	  			End 
	  		Else
	  			Begin
		   			Insert into sysadm.div_sin values ( @dcIdSin, 'choix_pack', 'Opérateur téléphonique', '-F1', 'O', 'LC', 'O', 'N', 10, null, null, null, '1F1', getdate(), getdate(), @sMajParCmdActuel, getdate(), @sMajParCmdActuel )
	  			End 


			If Exists ( Select * From sysadm.w_div_sin ds Where ds.id_sin = @dcIdSin And ds.nom_zone = 'choix_pack' )
	  			Begin
					Select 	@sValChoixPack = sysadm.FN_TRIM ( IsNull ( ds.val_car, '' ) )
					From 	sysadm.w_div_sin ds
					Where 	ds.id_sin = @dcIdSin And ds.nom_zone = 'choix_pack'
					
					If @sValChoixPack is null Set @sValChoixPack = ''
					
					If @sValChoixPack = ''
						Begin 
		   					Update sysadm.w_div_sin Set val_car = '1F1' Where id_sin = @dcIdSin and nom_zone = 'choix_pack'						
						End 
	  			
	  			End 
	  		Else
	  			Begin
		   			If Exists (select * from sysadm.w_sin Where id_sin = @dcIdSin) --     [CORR_FPI_06042010] - FPI - 06/04/2010
					Begin
						Insert into sysadm.w_div_sin values ( @dcIdSin, 'choix_pack', 'Opérateur téléphonique', '-F1', 'O', 'LC', 'O', 'N', 10, null, null, null, '1F1', 0, getdate(), getdate(), @sMajParCmdActuel )
					End
	  			End 
	  		
		End 
		-- :#14 JFF 14/05/2009 [DCMP090282]
	  
	  
	  
  END

-- Gestion du SAV
IF    ( CharIndex ( '[BVIEOX]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVIEOX]', @sCommentFrnActuel, 1 ) = 0 ) 
      OR 
      ( CharIndex ( '[BRIS]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BRIS]', @sCommentFrnActuel, 1 ) = 0 )
      OR 
      ( CharIndex ( '[SAV_NO_OK]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[SAV_NO_OK]', @sCommentFrnActuel, 1 ) = 0 )
      OR 
      ( CharIndex ( '[OXY]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[OXY]', @sCommentFrnActuel, 1 ) = 0 )

  BEGIN
	
	-- [PM82][LOT2] 
	-- [VDOC19868]
	If  @iStatusGc = 21 And ( Upper ( sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', @sInfoSpbFrnCpltActuel, ';' )) = 'OUI'
							 Or 
							  Upper ( sysadm.FN_CLE_VAL ( 'A_CONTROLER_SAV', @sInfoSpbFrnCpltActuel, ';' )) = 'OUI' -- [VDOC19868]
							 Or 
							  Upper ( sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', @sInfoSpbFrnCpltActuel, ';' )) = 'OUI' -- [VDOC19868]
							)
	  Begin
		If ( CharIndex ( '[BVIEOX]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVIEOX]', @sCommentFrnActuel, 1 ) = 0 ) 
		  Begin 
		    -- [PC801-6][MANTIS14177] 
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] : Le CTR a reçu l''appareil pour traitement SAV (suite 1ère réparation récemment effectuée), mais a détecté une OXYDATION, l''appareil sera renvoyé à l''assuré.'
		  End 
		  
		If ( CharIndex ( '[BRIS]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BRIS]', @sCommentFrnActuel, 1 ) = 0 )
		  Begin
		    -- [PC801-6][MANTIS14177] 		  
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] : Le CTR a reçu l''appareil pour traitement SAV (suite 1ère réparation récemment effectuée), mais a détecté un BRIS, l''appareil sera renvoyé à l''assuré.'
		  End 

		If ( CharIndex ( '[SAV_NO_OK]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[SAV_NO_OK]', @sCommentFrnActuel, 1 ) = 0 ) 
		  Begin 
			-- [PC801-6][MANTIS14177] 		  
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] : Le CTR a reçu l''appareil pour traitement SAV (suite 1ère réparation récemment effectuée), mais n''a pas détecté de panne/dommage qui ait un lien avec la 1ère réparation, l''appareil sera renvoyé à l''assuré.' 
		  End 

	  
		Set @sIRR  = 'OK'

	  End 
	  
	If  @iStatusGc in ( 23 ) And ( Upper ( sysadm.FN_CLE_VAL ( 'A_DESOXYDER_SAV', @sInfoSpbFrnCpltActuel, ';' )) = 'OUI' 
									Or 
									Upper ( sysadm.FN_CLE_VAL ( 'A_CONTROLER_SAV', @sInfoSpbFrnCpltActuel, ';' )) = 'OUI' -- [VDOC19868]
									Or 
									Upper ( sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', @sInfoSpbFrnCpltActuel, ';' )) = 'OUI' -- [VDOC19868]
								)
	    
	  Begin
		If ( CharIndex ( '[BVIEOX]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVIEOX]', @sCommentFrnActuel, 1 ) = 0 ) 
		  Begin 
			-- [PC801-6][MANTIS14177] 		  
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] : Le centre de réparation a reçu le mobile pour traitement SAV (suite 1ère désoxydation récemment effectuée), mais le mobile est bien en panne et non désoxydable, vous pouvez donc instruire le dossier.'
		  End 
		  
		If ( CharIndex ( '[BRIS]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BRIS]', @sCommentFrnActuel, 1 ) = 0 )
		  Begin
			-- [PC801-6][MANTIS14177] 		  		  
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] : Le centre de réparation a reçu le mobile pour traitement SAV (suite 1ère désoxydation récemment effectuée), mais a détecté un BRIS, son mobile lui sera renvoyé.'
		  End 

		If ( CharIndex ( '[SAV_NO_OK]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[SAV_NO_OK]', @sCommentFrnActuel, 1 ) = 0 ) 
		  Begin 
			-- [PC801-6][MANTIS14177] 		  		  		  
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] : Le centre de réparation a reçu le mobile pour traitement SAV (suite 1ère désoxydation récemment effectuée), mais n''a pas détecté de panne qui ait un lien avec la 1ère désoxydation, son mobile lui sera renvoyé.' 
		  End 

		If ( CharIndex ( '[OXY]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[OXY]', @sCommentFrnActuel, 1 ) = 0 ) 
		  Begin 
			-- [PC801-6][MANTIS14177] 		  
			Set @sMess = 'Contact créé automatiquement. Process [' + @sLibFour + '] : Le centre de réparation a reçu le mobile pour traitement SAV (suite 1ère désoxydation récemment effectuée), mais a détecté une nouvelle oxydation, son mobile lui sera renvoyé.' 
		  End 
  
		Set @sIRR  = 'OK'

	  End 
	  
  
	-- [PM82][LOT2]	  
	
	-- [PM200][LOT2][DESOX] ajout 21
	If ( CharIndex ( '[BVIEOX]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVIEOX]', @sCommentFrnActuel, 1 ) = 0 ) 
	   And @iStatusGc = 21 
	   And Upper ( sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', @sInfoSpbFrnCpltActuel, ';' )) <> 'OUI'
	   And Upper ( sysadm.FN_CLE_VAL ( 'A_DESOXYDER_SAV', @sInfoSpbFrnCpltActuel, ';' )) <> 'OUI'
	  Begin
		Set @sMess = 'Message automatique suite retour fournisseur [' + @sLibFour + '] : Attention, dossier bris visible irréparable économique oxydé, vous pouvez continuer l''instruction du dossier'
		-- 'Message automatique suite retour fournisseur : Attention, dossier bris visible irréparable économique+Oxydation, vous devez prendre une décision'


		Set @sMajParCmdActuel = 'IRNE'
		Set @sIRR  = 'OK'
	  End 
	
  END

-- [PM200][LOT2][DESOX] ajout 21
-- [PC13321]
-- [PM280-2]
IF       ( ( CharIndex ( '[BNV]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BNV]', @sCommentFrnActuel, 1 ) = 0 ) Or 
	       ( CharIndex ( '[PNC]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[PNC]', @sCommentFrnActuel, 1 ) = 0 ) Or 
		   ( CharIndex ( '[CRSMTPEC]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[CRSMTPEC]', @sCommentFrnActuel, 1 ) = 0 ) Or -- [PC13321]	       
		   ( CharIndex ( '[EXP]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[EXP]', @sCommentFrnActuel, 1 ) = 0 ) Or  -- [PM280-2]
		   ( CharIndex ( '[NOSPBS]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[NOSPBS]', @sCommentFrnActuel, 1 ) = 0 ) Or -- [PM280-2]
		   ( CharIndex ( '[PNV]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[PNV]', @sCommentFrnActuel, 1 ) = 0 ) Or -- [PM280-2][V3]
		   ( CharIndex ( '[PRDV]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[PRDV]', @sCommentFrnActuel, 1 ) = 0 ) Or -- [PMO139_RS4926]
		   ( CharIndex ( '[DNCAD]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[DNCAD]', @sCommentFrnActuel, 1 ) = 0 ) -- [HP252_276_HUB_PRESTA]
	     ) 
	 And @iStatusGc = 21
  BEGIN
  
	Set @sMess = 'Message automatique suite retour fournisseur [' + @sLibFour + '] : Attention, appareil en bris non visible, ce qui entraîne un renvoi de l''appareil à l''assuré et un refus de prise en charge. Vous pouvez continuer l''instruction du dossier'
	Set @sIRR = 'OK'

	-- [PC929_CDISCOUNT][PC929-2-V3]
	-- [PC13321]
	If CharIndex ( '[PNC]', @sCommentFrn, 1 ) > 0 -- [PC929_CDISCOUNT][PC929-2-V3]
	  Begin
		Set @sMess = 'Retour fournisseur [' + @sLibFour + '] : Attention, panne non constatée, ce qui entraîne un renvoi de l''appareil systématique à l''assuré par le prestataire et un refus de prise en charge. Vous pouvez continuer l''instruction du dossier'

		-- [MANTIS14489]
		If @iInfoSpbFrnActuel = 957 
		  Begin
			Set @sMess = 'Retour fournisseur [' + @sLibFour + '] : Attention, panne non constatée, ce qui entraîne un refus de prise en charge. Vous pouvez continuer l''instruction du dossier'			  
		  End 
		
		Set @sIRR = 'OK'
	  End 

	If CharIndex ( '[CRSMTPEC]', @sCommentFrn, 1 ) > 0 -- [PC929_CDISCOUNT][PC929-2-V3]
	  Begin
		Set @sMess = 'Retour fournisseur [' + @sLibFour + '] : Attention, coût de la réparation supérieur au montant de prise en charge, ce retour est couvert par le contrat. Vous pouvez continuer l''instruction du dossier'
		
		-- [MANTIS14489]
		If @iInfoSpbFrnActuel = 957 
		  Begin
			Set @sMess = 'Retour fournisseur [' + @sLibFour + '] : Attention, panne non constatée, ce qui entraîne un refus de prise en charge. Vous pouvez continuer l''instruction du dossier'
		  End 
		
		Set @sIRR = 'OK'
	  End 

	If CharIndex ( '[EXP]', @sCommentFrn, 1 ) > 0 -- [PM280-2]
	  Begin
		Set @sMess = 'Retour fournisseur [' + @sLibFour + '] : Attention, le fournisseur indique que la garantie de remplacement est expirée'
		Set @sIRR = 'OK'
	  End 


	If CharIndex ( '[NOSPBS]', @sCommentFrn, 1 ) > 0 -- [PM280-2]
	  Begin
		Set @sMess = 'Retour fournisseur [' + @sLibFour + '] : Attention, matériel non fourni par SPBS'
		Set @sIRR = 'OK'
	  End 

	If CharIndex ( '[PNV]', @sCommentFrn, 1 ) > 0 -- [PM280-2][V3]
	  Begin
		Set @sMess = 'Message automatique suite retour fournisseur [' + @sLibFour + '] : Attention, appareil en panne non visible, ce qui entraîne un renvoi de l''appareil à l''assuré et un refus de prise en charge. Vous pouvez continuer l''instruction du dossier'
		Set @sIRR = 'OK'
	  End 
	
	If CharIndex ( '[PRDV]', @sCommentFrn, 1 ) > 0 -- [PMO139_RS4926]
	  Begin
		Set @sMess = 'Retour fournisseur [' + @sLibFour + '] : Attention, panne résolue par Diagnostic Vidéo, ce qui entraîne un refus de prise en charge, le sinistre n''est pas considéré comme réparé. Vous pouvez continuer l''instruction du dossier'
		Set @sIRR = 'OK'
		Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'DRSDVI', '', '', 'PS_U01_COMMANDE', 'AUTO'
	  End 

	If CharIndex ( '[DNCAD]', @sCommentFrn, 1 ) > 0 -- [HP252_276_HUB_PRESTA]
	  Begin
		Set @sMess = 'Retour fournisseur [' + @sLibFour + '] : Attention, présence de dommages qui ne correspondent pas à la déclaration, ce qui entraîne un refus de prise en charge et un renvoi de l''appareil à l''assuré. Vous pouvez continuer l''instruction du dossier'
		Set @sIRR = 'OK'
	  End 
 
  END

-- [PM200][LOT2][DESOX]
IF      (  ( ( CharIndex ( '[BNVSOX]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BNVSOX]', @sCommentFrnActuel, 1 ) = 0 ) ) 
	Or ( ( CharIndex ( '[BVIEOX]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVIEOX]', @sCommentFrnActuel, 1 ) = 0 ) ) 
	) And @iStatusGc in ( 21, 23)

  BEGIN
	If CharIndex ( '[BNVSOX]', @sCommentFrn, 1 ) > 0
	 Begin
		Set @sMess = 'Message automatique suite retour fournisseur [' + @sLibFour + '] : Attention, appareil en bris non visible ET sans oxydation détectée, ce qui entraîne un renvoi de l''appareil systématique à l''assuré par le prestataire et un refus de prise en charge. Vous pouvez continuer l''instruction du dossier'
	 End 

	If CharIndex ( '[BVIEOX]', @sCommentFrn, 1 ) > 0
	 Begin
		Set @sMess = 'Message automatique suite retour fournisseur [' + @sLibFour + '] : Attention, dossier bris visible irréparable économique oxydé, vous pouvez continuer l''instruction du dossier'
	 End 

	Set @sIRR = 'OK'

  END
-- [PM200][LOT2][DESOX]

-- [DT276]
If @sIRR = 'OK' 
  Begin
	-- [DT276] -- [DT280]
	Exec sysadm.PS_I_COMMANDE_DT276_SWAP_CTR 
		@dcIdSin, 
		@dcIdGti, 
		@dcIdDetail, 
		@iIdSeq, 
		@sInfoFrnSpbCplt, 
		@sTypeAppSin, 
		@iIdSerieNouv, 
		@idBonTransp, 
		@dtDteEnvCli,
		@sLibFour,
		@sIdFour,
		@iInfoSpbFrnActuel, -- [DT290]
		@iCasDT276SwapCTR OUTPUT 

	-- [PC877]
	If ( @iCasPropoAutoO2m = 0 OR @iCasPropoAutoO2m is null ) And 
	   ( @iCasPropoAutoVpp = 0 OR @iCasPropoAutoVpp is null ) And -- [PC877]	
	   ( @iCasPropoAutoAas = 0 OR @iCasPropoAutoAas is null ) And -- [DT363]	
	   ( @iCasDT276SwapCTR = 0 Or @iCasDT276SwapCTR Is null ) -- [DT276]
	 Begin 
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			-- [VDOC14899] @sMajParCmdActuel par 'PRS'
			If @sMajParCmdActuel <> 'IRNE' Set @sMajParCmdActuel = 'PRS'
			-- /[VDOC14899]
			EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sMajParCmdActuel, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END
		ELSE
		BEGIN
			-- [VDOC14899] @sMajParCmdActuel par 'PRS'
			If @sMajParCmdActuel <> 'IRNE' Set @sMajParCmdActuel = 'PRS'
			-- /[VDOC14899]		
			EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sMajParCmdActuel, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END
	 End 

	-- [DT363]
	If @iCasPropoAutoAas = 1 
		Begin
		Exec sysadm.PS_I_CREER_PRESTA_REMPL_AAS
			@dcIdSin        ,
			@dcIdGti		,
			@dcIdDetail		,
			@iIdSeq			,
			@dcIdProd		,
			@dcIdRev		,
			@sInfoFrnSpbCpltActuel,
			@sIdFour
		End 

-- [PC929-1] ajoue [PIE]
-- [VDOC27123]BVID/BVIP/BVIT
	If @iCasPropoAutoVpp = 1 And 
	   (
		 ( ( CharIndex ( '[BVIE]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVIE]', @sCommentFrnActuel, 1 ) = 0 ) )
		 Or 
		 ( ( CharIndex ( '[BVID]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVID]', @sCommentFrnActuel, 1 ) = 0 ) )
		 Or 
		 ( ( CharIndex ( '[BVIP]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVIP]', @sCommentFrnActuel, 1 ) = 0 ) )
		 Or 
		 ( ( CharIndex ( '[BVIT]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[BVIT]', @sCommentFrnActuel, 1 ) = 0 ) )
		 Or 
		 ( ( CharIndex ( '[PIE]', @sCommentFrn, 1 ) > 0 And CharIndex ( '[PIE]', @sCommentFrnActuel, 1 ) = 0 ) )
	   )	
	   And @iStatusGc = 21
	 Begin
	 
		-- Propos vpp
		Select	@dcNewIdDetail = max ( id_detail ) 
		From	sysadm.detail
		where   id_sin = @dcIdSin
		and     id_gti = @dcIdGti 

		If @dcNewIdDetail is null Set @dcNewIdDetail = 0
		Set @dcNewIdDetail = @dcNewIdDetail + 1

		Insert into sysadm.detail 
		Select id_sin,   id_gti,   @dcNewIdDetail,   936,   id_reg,   id_i_reg,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej,   mt_fran,   mt_nplaf,   mt_plaf,   alt_plaf,   alt_reg,   'O',   alt_ssui,   cod_mot_ssui,   cod_dec_mac,   cod_dec_ope,   cod_etat,   id_carte,   id_type_carte,   getdate(),   'AUTO',   getdate(),   getdate(),   'AUTO',   dte_cmd,   dte_livr,   mt_val_achat,   mt_val_publique,   num_facture
		From sysadm.detail d
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail

		If Exists ( Select * from w_detail where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
		  Begin
			Insert into sysadm.w_detail 
			Select id_sin,   id_gti,   @dcNewIdDetail,   936,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej,   mt_fran,   mt_nplaf,   mt_plaf,   null, 'N', 'N', alt_plaf,   alt_reg,   'O', alt_valide,  1,  alt_ssui,   cod_mot_ssui,   cod_dec_mac,   cod_dec_ope,   cod_etat,   id_carte,   id_type_carte, getdate(),   getdate(),   'AUTO',   dte_cmd,   dte_livr,   mt_val_achat,   mt_val_publique,   num_facture
			From sysadm.w_detail d
			Where d.id_sin = @dcIdSin
			And   d.id_gti = @dcIdGti
			And   d.id_detail = @dcIdDetail
		  End 


		Insert into sysadm.div_det 
		Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, getdate(), getdate(),  'AUTO', getdate(), 'AUTO'
		From sysadm.div_det d
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail

		If Exists ( Select * from w_div_det where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
		  Begin
			Insert into sysadm.w_div_det 
			Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, 1, getdate(),   getdate(), 'AUTO'
			From sysadm.w_div_det d
			Where d.id_sin = @dcIdSin
			And   d.id_gti = @dcIdGti
			And   d.id_detail = @dcIdDetail			  
		  End 

		-- [MANTIS11520][PC13419]
		Select @dcMtPecPlaf = d.val_mt
		From sysadm.div_det d
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail
		And   d.nom_zone = 'mt_pec'
		
		If @dcMtPecPlaf is null Set @dcMtPecPlaf = 0
	
		Exec sysadm.PS_U01_COMMANDE_PLAF @dcIdSin, @dcIdProd, @dcIdRev, @dcIdGti, 936, 721, @dcMtPecPlaf, @sInfoFrnSpbCplt, @dcMtPecPlaf OUTPUT					 
		 
		Update sysadm.div_det
		Set val_mt = @dcMtPecPlaf
		Where id_sin = @dcIdSin
		And   id_gti = @dcIdGti
		And   id_detail = @dcNewIdDetail	 
		
		Update sysadm.w_div_det
		Set val_mt = @dcMtPecPlaf
		Where id_sin = @dcIdSin
		And   id_gti = @dcIdGti
		And   id_detail = @dcNewIdDetail	 
		-- [MANTIS11520][PC13419]

		Select @iNewIdSeq = max ( id_seq ) From commande where id_sin = @dcIdSin

		If @iNewIdSeq is null Set @iNewIdSeq = 0
		Set @iNewIdSeq = @iNewIdSeq + 1
		
		Insert into commande
		select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, 'VPP', 'CAF', 'REMPLACEMENT APPAREIL VIPP/ASSURE', '', mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, '', null,  null, null, null, null, 'RPC', null, 'PRESTA AUTOMATIQUE', 0, null, null, Getdate(), Getdate(), 'AUTO',  Getdate(),  'AUTO', id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'REMPL_VIPP_ASSURE', id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, alt_dev_acp, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, 0, null, null, '', ''
		From commande c
		Where c.id_sin = @dcIdSin
		And   c.id_seq = @iIdSeq

		If Exists ( Select * from w_commande where id_sin = @dcIdSin   and id_seq = @iIdSeq )
		  Begin
			Insert into w_commande
			select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, 'VPP', 'CAF', 'REMPLACEMENT APPAREIL VIPP/ASSURE', '', mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, '', null,  null, null, null, null, 'RPC', null, 1, 'PRESTA AUTOMATIQUE', Getdate(), Getdate(), 'AUTO',  id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'REMPL_VIPP_ASSURE', id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, alt_dev_acp, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, 0, null, null, '', ''
			From w_commande c
			Where c.id_sin = @dcIdSin
			And   c.id_seq = @iIdSeq
		  End 
		  
		-- [MANTIS11520][PC13419]
		Update sysadm.commande
		Set mt_ttc_cmde = @dcMtPecPlaf
		Where id_sin = @dcIdSin
		And   id_seq = @iNewIdSeq	 
		
		Update sysadm.w_commande
		Set mt_ttc_cmde = @dcMtPecPlaf
		Where id_sin = @dcIdSin
		And   id_seq = @iNewIdSeq	 
		-- [MANTIS11520][PC13419]			  				
	 End
				 
				 
	 
	If @iCasPropoAutoO2m = 1 -- [PC877] Création presta Auto.
	 Begin 
	 
		Select	@dcNewIdDetail = max ( id_detail ) 
		From	sysadm.detail
		where   id_sin = @dcIdSin
		and     id_gti = @dcIdGti 

		If @dcNewIdDetail is null Set @dcNewIdDetail = 0
		Set @dcNewIdDetail = @dcNewIdDetail + 1

		Insert into sysadm.detail 
		Select id_sin,   id_gti,   @dcNewIdDetail,   1083,   id_reg,   id_i_reg,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej,   mt_fran,   mt_nplaf,   mt_plaf,   alt_plaf,   alt_reg,   'O',   alt_ssui,   cod_mot_ssui,   cod_dec_mac,   cod_dec_ope,   cod_etat,   id_carte,   id_type_carte,   getdate(),   'AUTO',   getdate(),   getdate(),   'AUTO',   dte_cmd,   dte_livr,   mt_val_achat,   mt_val_publique,   num_facture
		From sysadm.detail d
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail

		If Exists ( Select * from w_detail where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
		  Begin
			Insert into sysadm.w_detail 
			Select id_sin,   id_gti,   @dcNewIdDetail,   1083,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej,   mt_fran,   mt_nplaf,   mt_plaf,   null, 'N', 'N', alt_plaf,   alt_reg,   'O', alt_valide,  1,  alt_ssui,   cod_mot_ssui,   cod_dec_mac,   cod_dec_ope,   cod_etat,   id_carte,   id_type_carte, getdate(),   getdate(),   'AUTO',   dte_cmd,   dte_livr,   mt_val_achat,   mt_val_publique,   num_facture
			From sysadm.w_detail d
			Where d.id_sin = @dcIdSin
			And   d.id_gti = @dcIdGti
			And   d.id_detail = @dcIdDetail
		  End 

		Insert into sysadm.div_det 
		Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, getdate(), getdate(),  'AUTO', getdate(), 'AUTO'
		From sysadm.div_det d
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail

		If Exists ( Select * from w_div_det where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
		  Begin
			Insert into sysadm.w_div_det 
			Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, 1, getdate(),   getdate(), 'AUTO'
			From sysadm.w_div_det d
			Where d.id_sin = @dcIdSin
			And   d.id_gti = @dcIdGti
			And   d.id_detail = @dcIdDetail			  
		  End 

		Select @iNewIdSeq = max ( id_seq ) From commande where id_sin = @dcIdSin

		If @iNewIdSeq is null Set @iNewIdSeq = 0
		Set @iNewIdSeq = @iNewIdSeq + 1
		
		Insert into commande
		select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, 'O2M', 'EDI', 'PROPOSITION A EFFECTUER', '', mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, 'Merci d''effectuer une proposition de matériel du même type que le matériel sinistré', null,  null, null, null, null, 'ECT', null, 'PRESTA AUTOMATIQUE', 0, null, null, Getdate(), Getdate(), 'AUTO',  Getdate(),  'JFF', id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'PROPO_A_EFFECTUER', id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, alt_dev_acp, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, 969, id_marq_art_ifr, id_modl_art_ifr, '', ''
		From commande c
		Where c.id_sin = @dcIdSin
		And   c.id_seq = @iIdSeq

		If Exists ( Select * from w_commande where id_sin = @dcIdSin   and id_seq = @iIdSeq )
		  Begin
			Insert into w_commande
			select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, 'O2M', 'EDI', 'PROPOSITION A EFFECTUER', '', mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, 'Merci d''effectuer une proposition de matériel du même type que le matériel sinistré', null,  null, null, null, null, 'ECT', null, 1, 'PRESTA AUTOMATIQUE', Getdate(), Getdate(), 'AUTO',  id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'PROPO_A_EFFECTUER', id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, alt_dev_acp, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, 969, id_marq_art_ifr, id_modl_art_ifr, '', ''
			From w_commande c
			Where c.id_sin = @dcIdSin
			And   c.id_seq = @iIdSeq
		  End 
	 End 
 
  End 
-- :#6 [DCMP080077]

/* GESTION MCM */ -- #8 JFF 09/09/2008 [MICROMANIA]
/*
If @sIdFour = 'MCM' And @iStatusGc = 202
	Begin
		Set @sMess = 'Micromania vient de refuser le dossier n°' + Convert ( VarChar ( 10 ), @dcIdSin ) + '-' + Convert ( VarChar ( 2 ), @iIdSeq ) -- [PI062]

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		Begin 
			EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sMess, 'PFE', @sErr output, @iIdCt OUTPUT , NULL, 'C'
		End
		Else
		Begin
			EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sMess, 'PFE', @sErr output, @iIdCt OUTPUT , NULL, 'C'		
		End 

		
		Set @sMess = 'Micromania vient de refuser le dossier n°' + Convert ( VarChar ( 7 ), @dcIdSin ) + '-' + Convert ( VarChar ( 2 ), @iIdSeq ) -- [PI062]
		Set @sMess = @sMess + ' Vous avez par conséquent un acte de gestion à faire (Refuser le dossier ).'
		Set @sMess = @sMess + CHAR (13) + CHAR (13)

		If Upper ( @sErr ) = 'OK' 
		  Begin
			Set @sMess = @sMess + 'Un travail en complément vient d''être créé avec le trigramme PFE sur le dossier ainsi qu''un contact.' 
			Set @sMess = @sMess + CHAR (13) + CHAR (13)
			Set @sMess = @sMess + 'Reprenez le dossier afin de réinstruire le dossier suite à cette annulation.'
		  End 
		Else
		  Begin
			Set @sMess = @sMess + 'Le travail en complément n''a pas pu être créé suite au problème suivant : ' + @sErr
			Set @sMess = @sMess + CHAR (13) + CHAR (13)
			Set @sMess = @sMess + 'Le contact a malgré tout été créé.'
		  End 

		Set @sObjet = 'Micromania : Refus dossier n°' + Convert ( VarChar ( 10 ), @dcIdSin ) + '-' + Convert ( VarChar ( 2 ), @iIdSeq ) -- [PI062]

		--    [DMDI28514]
		--Exec sysadm.PS_S01_MAIL  'pfermey@spb.fr,icherfils@spb.fr,skarrouche@spb.fr',
		Exec sysadm.PS_S01_MAIL  'jlquemar@spb.fr,clevallois@spb.fr,sbensikhelifa@spb.fr',
					 @sMess,
					 @sObjet,
					 null,
					 null,
					 null,
					 null,
					 null,
					 null,
					 null

	End 
*/

-- Maj dossier Auchan 
-- [PM421-6]
If @sIdFour = 'AUC'
	Begin 
		Exec sysadm.PS_I_PM421_6_MAJ_DOS_AUCHAN @dcIdSin, @iIdSeq, @iIdCmdFrn, @dtDteEnvCli
	End 

-- [HP252_276_HUB_PRESTA] -- Demande Auto de PEC RAR
If @iDemandeAutoPECRAR > 0 
	Begin
		Select	@sDernIdRefFour = c.id_ref_four
		From	sysadm.commande c 
		Where	c.id_sin = @dcIdSin
		And     c.id_seq = (	Select MAX ( id_seq ) 
								From sysadm.commande c1
								Where c1.id_sin = c.id_sin ) 
		If @sDernIdRefFour is null Set @sDernIdRefFour = ''		

		If @sDernIdRefFour = @sPrestaAutoHub Set @sPrestaAutoHub = ''

		If @sPrestaAutoHub = 'PEC_A_RECYCLER'
			Begin

				Select @iNewIdSeq = max ( id_seq ) From sysadm.commande where id_sin = @dcIdSin

				If @iNewIdSeq is null Set @iNewIdSeq = 0
				Set @iNewIdSeq = @iNewIdSeq + 1
				
				Insert into sysadm.commande
				select top 1 id_sin , @iNewIdSeq, id_gti, @dcIdDetail, id_four, 'EDI', 'PRISE EN CHARGE A RECYCLER', '', mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, '', null,  null, null, null, null, 'RFO', @sCommentFrn, 'PRESTA AUTOMATIQUE', 0, null, null, Getdate(), Getdate(), 'AUTO',  Getdate(),  'AUTO', id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'PEC_A_RECYCLER', id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, null, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, 990, 'PRISE EN CHARGE A RECYCLER', id_modl_art_ifr, 
							( sysadm.FN_CLE_VAL_E ( 'HP_ID_FOUR', c.id_four, 
								sysadm.FN_CLE_VAL_E ( 'HP_IDENTITY', '', 
									sysadm.FN_CLE_VAL_E ( 'HP_ID_HUB_PRESTA', 'FICTIVE' , '', ';' ) 
								, ';' ),
							  ';' )
							 ),
						   null
				From commande c
				Where c.id_sin = @dcIdSin
				And   c.id_seq = @iIdSeq

				If Exists ( Select * from sysadm.w_commande where id_sin = @dcIdSin and id_seq = @iIdSeq )
				  Begin
					Insert into sysadm.w_commande
					select top 1 id_sin , @iNewIdSeq, id_gti, @dcIdDetail, id_four, 'EDI', 'PRISE EN CHARGE A RECYCLER', '', mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, '', null,  null, null, null, null, 'RFO', @sCommentFrn, 1, 'PRESTA AUTOMATIQUE', Getdate(), Getdate(), 'AUTO',  id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'PEC_A_RECYCLER'   , id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, null, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, 990, 'PRISE EN CHARGE A RECYCLER', id_modl_art_ifr, 
							( sysadm.FN_CLE_VAL_E ( 'HP_ID_FOUR', c.id_four, 
								sysadm.FN_CLE_VAL_E ( 'HP_IDENTITY', '', 
									sysadm.FN_CLE_VAL_E ( 'HP_ID_HUB_PRESTA', 'FICTIVE' , '', ';' ) 
								, ';' ),
							  ';' )
							 ),
						   null

					From w_commande c
					Where c.id_sin = @dcIdSin
					And   c.id_seq = @iIdSeq
				  End 	

					Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Le Hub Prestataire a automatiquement engagé une prestation PEC_A_RECYCLER vers le CTR.' 

					IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
					BEGIN
						Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
					END
					ELSE
					BEGIN
						Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
					END


			End 

		If @sPrestaAutoHub = 'REFUSE_A_REEXP'
			Begin
				Select @iNewIdSeq = max ( id_seq ) From sysadm.commande where id_sin = @dcIdSin

				If @iNewIdSeq is null Set @iNewIdSeq = 0
				Set @iNewIdSeq = @iNewIdSeq + 1
				
				Insert into sysadm.commande
				select top 1 id_sin , @iNewIdSeq, id_gti, @dcIdDetail, id_four, 'EDI', 'REFUSE A REEXPEDIER', '', mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, '', null,  null, null, null, null, 'RFO', @sCommentFrn, 'PRESTA AUTOMATIQUE', 0, null, null, Getdate(), Getdate(), 'AUTO',  Getdate(),  'AUTO', id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'REFUSE_A_REEXP', id_orian_marque, id_orian_modele, dte_elv_mobile, 155, dte_emis_devis, mt_devis, null, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, 990, 'REFUSE A REEXPEDIER', id_modl_art_ifr, 
							( sysadm.FN_CLE_VAL_E ( 'HP_ID_FOUR', c.id_four, 
								sysadm.FN_CLE_VAL_E ( 'HP_IDENTITY', '', 
									sysadm.FN_CLE_VAL_E ( 'HP_ID_HUB_PRESTA', 'FICTIVE' , '', ';' ) 
								, ';' ),
							  ';' )
							 ),
						   null
				From commande c
				Where c.id_sin = @dcIdSin
				And   c.id_seq = @iIdSeq

				If Exists ( Select * from sysadm.w_commande where id_sin = @dcIdSin and id_seq = @iIdSeq )
				  Begin
					Insert into sysadm.w_commande
					select top 1 id_sin , @iNewIdSeq, id_gti, @dcIdDetail, id_four, 'EDI', 'REFUSE A REEXPEDIER', '', mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, '', null,  null, null, null, null, 'RFO', @sCommentFrn, 1, 'PRESTA AUTOMATIQUE', Getdate(), Getdate(), 'AUTO',  id_zone, id_bsp, dte_ret_pret, adr_cod_civ, 'REFUSE_A_REEXP'   , id_orian_marque, id_orian_modele, dte_elv_mobile, 155, dte_emis_devis, mt_devis, null, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli, 990, 'REFUSE A REEXPEDIER', id_modl_art_ifr, 
							( sysadm.FN_CLE_VAL_E ( 'HP_ID_FOUR', c.id_four, 
								sysadm.FN_CLE_VAL_E ( 'HP_IDENTITY', '', 
									sysadm.FN_CLE_VAL_E ( 'HP_ID_HUB_PRESTA', 'FICTIVE' , '', ';' ) 
								, ';' ),
							  ';' )
							 ),
						   null

					From w_commande c
					Where c.id_sin = @dcIdSin
					And   c.id_seq = @iIdSeq
				  End 	

					Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Le Prestataire a automatiquement engagé une prestation REFUSE_A_REEXP vers le CTR.' 

					IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
					BEGIN
						Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
					END
					ELSE
					BEGIN
						Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
					END
			End 


	End 

-- [HUB1267]
If @iRemplacementAutomatiqueHub > 0 
	Begin
		Select	@dcNewIdDetail = max ( id_detail ) 
		From	sysadm.detail
		where   id_sin = @dcIdSin
		and     id_gti = @dcIdGti 

		If @dcNewIdDetail is null Set @dcNewIdDetail = 0
		Set @dcNewIdDetail = @dcNewIdDetail + 1

		Set @dcIdEvt = 936 

		Exec sysadm.PS_I_CREATION_AUTO_PARAM_CONDITION @dcIdProd , @dcIdRev, @dcIdGti, '+EV', @dcIdEvt, 'O'

		Insert into sysadm.detail 
		Select id_sin,   id_gti,   @dcNewIdDetail,   @dcIdEvt,   id_reg=0,   id_i_reg=null,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej=0,   mt_fran=0,   mt_nplaf=0,   mt_plaf=0,   alt_plaf='N',   alt_reg='N',   alt_att='O',   alt_ssui='N',   cod_mot_ssui=0,   cod_dec_mac=100,   cod_dec_ope=100,   cod_etat=100,   id_carte,   id_type_carte,   getdate(),   'AUTO',   getdate(),   getdate(),   'AUTO',   dte_cmd=null,   dte_livr=null,   mt_val_achat,   mt_val_publique,   num_facture=null
		From sysadm.detail d
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail

		If Exists ( Select * from w_detail where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
		  Begin
			Insert into sysadm.w_detail 
			Select id_sin,   id_gti,   @dcNewIdDetail,   @dcIdEvt,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej=0,   mt_fran=0,   mt_nplaf=0,   mt_plaf=0,   id_i_reg=null, alt_bloc='N', alt_cour='N', alt_plaf='N',   alt_reg='N',   alt_att='O', alt_valide='N',  cpt_valide=1,  alt_ssui='N',   cod_mot_ssui=0,   cod_dec_mac=100,   cod_dec_ope=100,   cod_etat=100,   id_carte,   id_type_carte, getdate(),   getdate(),   'AUTO',   dte_cmd=null,   dte_livr=null,   mt_val_achat,   mt_val_publique,   num_facture=null
			From sysadm.w_detail d
			Where d.id_sin = @dcIdSin
			And   d.id_gti = @dcIdGti
			And   d.id_detail = @dcIdDetail
		  End 

		Insert into sysadm.div_det 
		Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, getdate(), getdate(),  'AUTO', getdate(), 'AUTO'
		From sysadm.div_det d
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail

		If Exists ( Select * from w_div_det where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
		  Begin
			Insert into sysadm.w_div_det 
			Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, 1, getdate(),   getdate(), 'AUTO'
			From sysadm.w_div_det d
			Where d.id_sin = @dcIdSin
			And   d.id_gti = @dcIdGti
			And   d.id_detail = @dcIdDetail			  
		  End 

		Select @iNewIdSeq = max ( id_seq ) From sysadm.commande where id_sin = @dcIdSin

		If @iNewIdSeq is null Set @iNewIdSeq = 0
		Set @iNewIdSeq = @iNewIdSeq + 1

		Insert into sysadm.commande
		select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, id_four=sysadm.FN_CLE_VAL ( 'ID_FOUR_REMPL', @sInfoFrnSpbCplt, ';' ), id_typ_art=@sTypeAppSin, id_marq_art, id_modl_art, mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, 'Prestation de remplacement automatique créée par le HUB PRESTATAIRE.', null,  null, null, null, null, 'ECT', null, 'PRESTA AUTOMATIQUE', 0, null, null, Getdate(), Getdate(), 'AUTO',  Getdate(),  'AUTO', id_zone, id_bsp, dte_ret_pret, adr_cod_civ, id_ref_four='A_COMMANDER', id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, alt_dev_acp, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli=null, 990 , id_marq_art_ifr, id_modl_art_ifr, 
						 sysadm.FN_CLE_VAL_E ( 'GEN_AUTO_CMDE_REMPL', 'OUI', 
							 sysadm.FN_CLE_VAL_E ( 'HP_ID_MODE_LOGIS', sysadm.FN_CLE_VAL ( 'ID_MODE_LOGIS_REMPL', @sInfoFrnSpbCplt, ';' ),
								 sysadm.FN_CLE_VAL_E ( 'HP_ID_POINT_SERV', sysadm.FN_CLE_VAL ( 'ID_POINT_SERV_REMPL', @sInfoFrnSpbCplt, ';' ),
									 sysadm.FN_CLE_VAL_E ( 'HP_IDENTITY', '', 
										sysadm.FN_CLE_VAL_E ( 'HP_ID_HUB_PRESTA', sysadm.FN_CLE_VAL ( 'ID_HUB_PRESTA_REMPL', @sInfoFrnSpbCplt, ';' ) , 
											'' -- on part d'une chaine vide
											, ';' ) 
									 , ';' )
								  , ';' )
							 , ';' )
						 ,';' ),
					 ''
		From sysadm.commande c
		Where c.id_sin = @dcIdSin
		And   c.id_seq = @iIdSeq

		If Exists ( Select * from w_commande where id_sin = @dcIdSin   and id_seq = @iIdSeq )
		  Begin
			Insert into sysadm.w_commande
			select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, id_four=sysadm.FN_CLE_VAL ( 'ID_FOUR_REMPL', @sInfoFrnSpbCplt, ';' ), id_typ_art=@sTypeAppSin, id_marq_art, id_modl_art, mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, 'Prestation de remplacement automatique créée par le HUB PRESTATAIRE.', null,  null, null, null, null, 'ECT', null, 1, 'PRESTA AUTOMATIQUE', Getdate(), Getdate(), 'AUTO',  id_zone, id_bsp, dte_ret_pret, adr_cod_civ, id_ref_four='A_COMMANDER', id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, alt_dev_acp, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli=null, 990, id_marq_art_ifr, id_modl_art_ifr, 
						 sysadm.FN_CLE_VAL_E ( 'GEN_AUTO_CMDE_REMPL', 'OUI', 
							 sysadm.FN_CLE_VAL_E ( 'HP_ID_MODE_LOGIS', sysadm.FN_CLE_VAL ( 'ID_MODE_LOGIS_REMPL', @sInfoFrnSpbCplt, ';' ),
								 sysadm.FN_CLE_VAL_E ( 'HP_ID_POINT_SERV', sysadm.FN_CLE_VAL ( 'ID_POINT_SERV_REMPL', @sInfoFrnSpbCplt, ';' ),
									 sysadm.FN_CLE_VAL_E ( 'HP_IDENTITY', '', 
										sysadm.FN_CLE_VAL_E ( 'HP_ID_HUB_PRESTA', sysadm.FN_CLE_VAL ( 'ID_HUB_PRESTA_REMPL', @sInfoFrnSpbCplt, ';' ) , 
											'' -- on part d'une chaine vide
											, ';' ) 
									 , ';' )
								  , ';' )
							 , ';' )
						 ,';' ),
					 ''
			From w_commande c
			Where c.id_sin = @dcIdSin
			And   c.id_seq = @iIdSeq
		  End 

		Set @sMess = 'Contact crée automatiquement -> '+ 'Le HUB Prestataire a engagé une commande de remplacement chez un autre prestataire que le prestataire de la prestation originale.' 

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
		END
		ELSE
		BEGIN
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
		END
		
		-- [MIG82_JOURN_EVT]
		Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'CDRPEC', @sVar, '', 'PS_U01_COMMANDE', 'AUTO'

	End 

-- [HP252_276_HUB_PRESTA] -- Gestion du SAV avc le Hub Prestataire.
If @iDemandeSavHubPresta > 0 And @iNbreSavActuel Not in ( 0, 1 )
	Begin
		Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Le prestataire a demandé la création d''une prestation de SAV, le nombre maximum de 2 SAV étant atteint du ce dossier, le système n''a pas créé de prestation, mais conserve juste pour mémoire par ce contact la notification du prestataire.' 

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
		END
		ELSE
		BEGIN
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
		END

	End 

If @iDemandeSavHubPresta > 0 And @iNbreSavActuel in ( 0, 1 )
	Begin
		Select	@dcNewIdDetail = max ( id_detail ) 
		From	sysadm.detail
		where   id_sin = @dcIdSin
		and     id_gti = @dcIdGti 

		If @dcNewIdDetail is null Set @dcNewIdDetail = 0
		Set @dcNewIdDetail = @dcNewIdDetail + 1

		Select	@dcIdEvt = dt.id_evt
		From	sysadm.detail dt
		Where	id_sin  = @dcIdSin
		And		id_gti  = @dcIdGti 
		And		id_detail = @dcIdDetail 


		Insert into sysadm.detail 
		Select id_sin,   id_gti,   @dcNewIdDetail,   @dcIdEvt,   id_reg=0,   id_i_reg=null,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej=0,   mt_fran=0,   mt_nplaf=0,   mt_plaf=0,   alt_plaf='N',   alt_reg='N',   alt_att='O',   alt_ssui='N',   cod_mot_ssui=0,   cod_dec_mac=100,   cod_dec_ope=100,   cod_etat=100,   id_carte,   id_type_carte,   getdate(),   'AUTO',   getdate(),   getdate(),   'AUTO',   dte_cmd=null,   dte_livr=null,   mt_val_achat,   mt_val_publique,   num_facture=null
		From sysadm.detail d
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail

		If Exists ( Select * from w_detail where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
		  Begin
			Insert into sysadm.w_detail 
			Select id_sin,   id_gti,   @dcNewIdDetail,   @dcIdEvt,   lib_det,   dte_det,   heu_det, num_carte,   mt_prej=0,   mt_fran=0,   mt_nplaf=0,   mt_plaf=0,   id_i_reg=null, alt_bloc='N', alt_cour='N', alt_plaf='N',   alt_reg='N',   alt_att='O', alt_valide='N',  cpt_valide=1,  alt_ssui='N',   cod_mot_ssui=0,   cod_dec_mac=100,   cod_dec_ope=100,   cod_etat=100,   id_carte,   id_type_carte, getdate(),   getdate(),   'AUTO',   dte_cmd=null,   dte_livr=null,   mt_val_achat,   mt_val_publique,   num_facture=null
			From sysadm.w_detail d
			Where d.id_sin = @dcIdSin
			And   d.id_gti = @dcIdGti
			And   d.id_detail = @dcIdDetail
		  End 

		Insert into sysadm.div_det 
		Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, getdate(), getdate(),  'AUTO', getdate(), 'AUTO'
		From sysadm.div_det d
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail

		If Exists ( Select * from w_div_det where id_sin = @dcIdSin  and id_gti = @dcIdGti  and id_detail = @dcIdDetail  )
		  Begin
			Insert into sysadm.w_div_det 
			Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, 1, getdate(),   getdate(), 'AUTO'
			From sysadm.w_div_det d
			Where d.id_sin = @dcIdSin
			And   d.id_gti = @dcIdGti
			And   d.id_detail = @dcIdDetail			  
		  End 

		Select @iNewIdSeq = max ( id_seq ) From sysadm.commande where id_sin = @dcIdSin

		If @iNewIdSeq is null Set @iNewIdSeq = 0
		Set @iNewIdSeq = @iNewIdSeq + 1

		If @iNbreSavActuel = 0 Set @sCasSav = 'A_REPARER_SAV'
		If @iNbreSavActuel = 1 Set @sCasSav = 'A_CONTROLER_SAV'
		
		Insert into sysadm.commande
		select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, id_four, id_typ_art, id_marq_art, id_modl_art, mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, 'Prestation de SAV demandée par le prestataire lui-même sur retour de la prestation ' + CONVERT ( Varchar ( 10), @iIdSeq) + '.', null,  null, null, null, null, 'ECT', null, 'PRESTA AUTOMATIQUE', 0, null, null, Getdate(), Getdate(), 'AUTO',  Getdate(),  'AUTO', id_zone, id_bsp, dte_ret_pret, adr_cod_civ, id_ref_four, id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, alt_dev_acp, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli=null, 990 , id_marq_art_ifr, id_modl_art_ifr, 
						 sysadm.FN_CLE_VAL_E ( @sCasSav, 'OUI', 
							 sysadm.FN_CLE_VAL_E ( 'HP_IDENTITY', '', 
								sysadm.FN_CLE_VAL_E ( 'HP_ID_HUB_PRESTA', sysadm.FN_CLE_VAL ( 'ID_HUB_PRESTA_SAV', @sInfoFrnSpbCplt, ';') , 
									Replace ( RTRIM ( c.info_spb_frn_cplt ), ';A_REPARER_SAV=OUI', '' )
									, ';' ) 
							 , ';' ),
						 ';' ),
					 ''
		From sysadm.commande c
		Where c.id_sin = @dcIdSin
		And   c.id_seq = @iIdSeq

		If Exists ( Select * from w_commande where id_sin = @dcIdSin   and id_seq = @iIdSeq )
		  Begin
			Insert into sysadm.w_commande
			select top 1 id_sin , @iNewIdSeq, id_gti, @dcNewIdDetail, id_four, id_typ_art, id_marq_art, id_modl_art, mt_ttc_cmde, adr_nom, adr_prenom, adr_livr1, adr_livr2, adr_livr_cpl, adr_cp, adr_ville, adr_tel1, adr_tel2, adr_tel3, adr_mail, dte_rdv_cli, hrdv_cli_min, hrdv_cli_max, id_serie_anc, 'Prestation de SAV demandée par le prestataire lui-même sur retour de la prestation ' + CONVERT ( Varchar ( 10), @iIdSeq) + '.', null,  null, null, null, null, 'ECT', null, 1, 'PRESTA AUTOMATIQUE', Getdate(), Getdate(), 'AUTO',  id_zone, id_bsp, dte_ret_pret, adr_cod_civ, id_ref_four, id_orian_marque, id_orian_modele, dte_elv_mobile, 0, dte_emis_devis, mt_devis, alt_dev_acp, dte_dev_acp, adrfc_cod_civ, adrfc_nom, adrfc_prenom, adrfc_livr1, adrfc_livr2, adrfc_livr_cpl, adrfc_cp, adrfc_ville, dte_ret_logis, dte_ret_pret_min, dte_ret_pret_max, id_ann, dte_env_bte_frn, dte_rcp_bte_cli, dte_dep_bte_cli, dte_env_st, dte_rcp_mob_cli=null, 990, id_marq_art_ifr, id_modl_art_ifr, 
						 sysadm.FN_CLE_VAL_E ( @sCasSav, 'OUI', 
							 sysadm.FN_CLE_VAL_E ( 'HP_IDENTITY', '', 
								sysadm.FN_CLE_VAL_E ( 'HP_ID_HUB_PRESTA', sysadm.FN_CLE_VAL ( 'ID_HUB_PRESTA_SAV', @sInfoFrnSpbCplt, ';') , 
									Replace ( RTRIM ( c.info_spb_frn_cplt ), ';A_REPARER_SAV=OUI', '' )
									, ';' ) 
							 , ';' ),
						 ';' ),
					 ''
			From w_commande c
			Where c.id_sin = @dcIdSin
			And   c.id_seq = @iIdSeq
		  End 

			Set @sMess = 'Contact crée automatiquement, Process [' + @sLibFour + '] -> '+ 'Le prestataire a demandé la création d''une prestation de SAV, laquelle a automatiquement été créée par le système.' 

			IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
			BEGIN
				Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT
			END
			ELSE
			BEGIN
				Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @dcIdSin, 2, @sMess,	@sIdFour, 300, @iIdCt OUTPUT						
			END

	End 



/* à laisser à la fin */
-- [VDOC15650]
Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @dcIdSin, 'OPCO'

/* DCMP 050514/ 30/12/2005/JFF : Si nouv IMEI diff du NouvImei présent dans la base alors on trace pour EA */
-- If @sIdTypArt <> 'PRS' And @sIdFour <> 'O2M' And @iIdSerieNouv is not null And ( @sIdSerieNouvActuel is null Or sysadm.FN_TRIM ( @sIdSerieNouvActuel ) <> sysadm.FN_TRIM ( @iIdSerieNouv ) )
If  sysadm.FN_A_COMMANDER ( @dcIdSin, @iIdSeq, 'P' ) = 'A_COMMANDER' And 
	@sCodEtatActuel not in ( 'RFO', 'RPC', 'ANN' ) And 
	@sIdTypArt = 'TEL' And @iIdSerieNouv is not null And ( @sIdSerieNouvActuel is null Or sysadm.FN_TRIM ( @sIdSerieNouvActuel ) <> sysadm.FN_TRIM ( @iIdSerieNouv ) )
	Begin 
			Set @iStopMajAdhMobRempl = 1 

			IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
				Begin
					If NOT ( SHERPA_PRO.sysadm.FN_IS_SAGA ( @dcIdProd ) > 0 )
						/*
						Not Exists ( 
						Select Top 1 1
						from SHERPA_PRO.sysadm.det_pro dp,
								SHERPA_PRO.sysadm.prod_app pa
						where   dp.id_prod = @dcIdProd
						And     dp.id_typ_code = '-BADH' 
						and		dp.id_code in ( 12, 16, 30 ) -- Rech si l'adhésion du produit est géré sous SAGA2. Le 29/11/18 Fred donne 30 en plus de 12 et 16.
						And		pa.id_prod = dp.id_prod
						And     pa.id_appli = 2
						)*/
						Begin
							Set @iStopMajAdhMobRempl = 0
						End 
				End 
			Else
				Begin
					If NOT ( SHERPA_SIM.sysadm.FN_IS_SAGA ( @dcIdProd ) > 0 )
						/*
						Not Exists ( 
						Select Top 1 1
						from SHERPA_SIM.sysadm.det_pro dp,
								SHERPA_SIM.sysadm.prod_app pa
						where   dp.id_prod = @dcIdProd
						And     dp.id_typ_code = '-BADH' 
						and		dp.id_code in ( 12, 16, 30 )
						And		pa.id_prod = dp.id_prod
						And     pa.id_appli = 2
						)*/
						Begin
							Set @iStopMajAdhMobRempl = 0
						End 
				End 

			If @iStopMajAdhMobRempl = 0 
				Begin
					Exec sysadm.PS_I01_TRACE_MOB_REMPL @dcIdSin, @iIdSeq, @iIdSerieNouv, 'OPCO'
				End 
	End  

-- [PI087_PM473_2]
Exec sysadm.PS_I_PI087_TRACE_DOSSIER @dcIdSin, 'VALIDATION', @sIdFour
 
Go

grant execute on sysadm.PS_U01_COMMANDE to rolebddsinistres
Go
