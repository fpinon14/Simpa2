-------------------------------------------------------------------
--
-- Fichier              :       WEB_SITECOMMANDE.CP
-- Auteur               :       JFF
-- Date                 :       02/2007
--
-- Commentaires         :       Gestion des commandes pour l'extranet
-- 
--	http://choixmobile.spb.fr/
--
--	dossier test : 1330951 
--	Tel : 0600000005
--	mdp : ZE4T6Y
--
-------------------------------------------------------------------
-- PS_SPBW_MOBILES_DISPOS_V01               JFF 16/03/2007 Fonction multi-cas tester les/la dispo(s) d'un modèle (+chrg éventuellement)
-- PS_SPBW_MOBILES_DISPOS_V02               FPI	12/01/2017 [PM373-1] Ajout du critère de taille d'écran + colonne neuf/reconditionné
-- PS_SPBW_IDENTIFICATION_ACCES_V01         JFF 13/02/2007 On va lancer l'identification du client.
-- PS_SPBW_IDENTIFICATION_LECTURE_V01       JFF 13/02/2007 L'identification a bien fonctionnée, on récupére certaines informations.
-- PS_SPBW_CHOIX_MOBILE_LISTE_MARQUE_V01    JFF 03/03/2007 Il faut populiser la liste des marques disponibles pour le dossier.
-- PS_SPBW_CODE_V01                         JFF 03/03/2007 Récupération de certains codes de la table CODE. (Civilité, Caractéristiques techniques du mobile)
-- PS_SPBW_CHOIX_COMMUNE_V01                JFF 03/03/2007 Récupération de la liste de communes pour un code postal donné. (A Compiler sur SESAME_PRO)
-- PS_SPBW_CODECAR_V01			    JFF 03/03/2007 Liste des codes caractères
-- PS_SPBW_CHOIX_MOBILE_V01		    JFF 21/03/2007 Liste des mobiles selon critère marque et/ou EQF
-- PS_SPBW_COORDONNEES_LIVRAISON_V01        JFF 21/03/2007 Récupération des coordonnées de livraison
-- PS_SPBW_VALIDER_COMMANDE_V01  	    JFF 26/03/2007 Validation de la commande et des coordonnées de livraison
-- V_SPBW_TRCWB  			    JFF 03/05/2007 Vue particulière pour la trace commande WEB
-- PS_SPBW_LECT_FONCT_ET_VAL		    JFF 20/05/2011 [PM82][LOT3]
-- PS_SPBW_GET_MT_PEC			JFF      21/06/2016   [PM284-2]
-- PS_SPBW_REMB_NUMERAIRE		JFF      21/06/2016   [PM284-2]
-- ------------- MAJ LISTE REELLE ---------------------
-- sysadm.PS_SPBW_CHOIX_COMMUNE_V01
-- sysadm.PS_SPBW_CHOIX_MOBILE_LISTE_MARQUE_V01
-- sysadm.PS_SPBW_CHOIX_MOBILE_V01
-- sysadm.PS_SPBW_CODE_V01
-- sysadm.PS_SPBW_CODECAR_V01
-- sysadm.PS_SPBW_COORDONNEES_LIVRAISON_V01
-- sysadm.PS_SPBW_IDENTIFICATION_ACCES_V01
-- sysadm.PS_SPBW_IDENTIFICATION_LECTURE_V03
-- sysadm.PS_SPBW_MOBILES_DISPOS_V02
-- sysadm.PS_SPBW_VALIDER_COMMANDE_V02
-- sysadm.PS_SPBW_GET_MT_PEC
-- sysadm.PS_SPBW_LECT_FONCT_ET_VAL
-- sysadm.PS_SPBW_REMB_NUMERAIRE
-- sysadm.V_SPBW_TRCWB

-------------------------------------------------------------------

-------------------------------------------------------------------
-- Procedure            :       PS_SPBW_MOBILES_DISPOS_V02
-- Auteur               :       FABRY JF
-- Date                 :       16/03/2007 
-- Libelle              :        
-- Commentaires         :       On va effectuer la lecture de certaines informations suite à l'identification réussie
--                               
-- References           :       
--
-- Arguments            :       @adcIdSin               Decimal ( 7,0  )        (Val)
--                              @asCas                  VarChar ( 40   )        (Val) Cas de Trt : 
--                                                                              TEST_DISPOS = En fonction des critères du dossiers
--                                                                                            y a-t-il amu n (pris du param) mobiles potentiellement commandable
--                                                                                            par l'assuré, sinon => sortie -1
--                                                                              CHRG_LST_MARQUES = Chargement des marques de mobiles dispo      
--                                                                                                   en fct des critères du dossier, sinon = -1
--                                                                              
--                                                                              CHRG_LST_MOBILES = Chargement des mobiles dispo lié à une marques 
--                                                                                                   en fct des critères du dossier, 
--                                                                                                 OU en fonction critères EQF
--                                                                                                 sinon = -1
--                                                                                              
--                                                                              TEST_CHOIX_DEF = Suite à un choix effectué, ledit choix est-il tjs disponible
--                              @asMarque               VarChar ( 35 )          (Val) Marque pour le cas CHRG_LST_MOBILES et TEST_CHOIX_DEF 
--                              @asModl                 VarChar ( 35 )          (Val) Modèle pour le cas CHRG_LST_MOBILES et TEST_CHOIX_DEF 
--                              @asEQF                  VarChar (150 ) 		(Val) dans une même chaine les codes doivent être bornés par un # de chaque côté ex : '#1#3#' (cas = CHRG_LST_MOBILES)
--				@asETOU			VarChar (  2 )          (Val) Opérateur logique à utiliser pour la marque et l'EQF
--                              @asIdRefFour            VarChar ( 20 ) 		(Val) Référence fourn du mobile choisi pour le cas TEST_CHOIX_DEF  
--                              @asIdFour               VarChar (  3 ) 		(Val) fournisseur du mobiel choisi pour le cas TEST_CHOIX_DEF  
--                              @asLangage              VarChar (  3 )          (Val) Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       Integer                 >0 = Il y a des dispos
--                                                      -1 = aucune dispo
--
-------------------------------------------------------------------
-- #1	JFF 	18/10/2007	[DCMP070698]
-- #2	JFF 	27/11/2007	[DCMP070701]
-- #3   JFF     21/01/2008	Bug détecté par la gestion, on regarde au moins 3 mobiles 
--				sur SIMPA2 et au moins 3 marques sur le site, ce qui n'est pas la même chose
--				Je modifie sur "au moins 3 mobiles sur le site"
-- #4   JFF     03/12/2008      [DCMP080739] problème des slash dans les noms de fichiers
-- #5	JFF	13/01/2010	[DCMP090639] ramener sur le site choix de mobile, que les téléphones dont le code filtre est égal au code filtre choisi par le GT, et non plus dont le code filtre appartient à la liste associée au produit. 
--      JFF     20/07/2011      [20110720] Suite venue de A. Papillon, il a conseillé de mettre un Set Transaction Isolation level Read UnCommitted pour éviter les blocage
-- JFF      12/02/2016   [PI062]
-- JFF      24/04/2017   [PM373-1]
-- JFF      07/08/2019   [PM462-1]
-- JFF      31/10/2019   [VDOC28596]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SPBW_MOBILES_DISPOS_V02' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_SPBW_MOBILES_DISPOS_V02
GO


CREATE PROCEDURE        sysadm.PS_SPBW_MOBILES_DISPOS_V02
        @adcIdSin               Decimal (    10 )        , -- [PI062]
        @asCas                  VarChar (   40 )        ,
        @asMarque               VarChar (   35 )        ,
        @asModl                 VarChar (   35 )        ,
	@asEQF			VarChar (  150 )	,
	@asETOU			VarChar (    2 )        ,
	@asIdRefFour		VarChar (   20 )        ,
	@asIdFour		VarChar (    3 )        ,
        @asLangage              VarChar (    3 )        ,
        @asRetourMess           VarChar ( 2000 ) OUTPUT

AS
/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications Paramêtre                                                                                                       */
/* @adcIdSIn      = N° du sinistre .                                                                                            */
/*------------------------------------------------------------------------------------------------------------------------------*/

-- [20110720]
Set Transaction Isolation level Read UnCommitted

DECLARE @iRet           INTEGER   
Declare @iNbreMiniMob   Integer
Declare @dcIdGti	Decimal ( 7 )
Declare @sIdTypArt	VarChar ( 3 )
Declare @sCWE		VarChar ( 3 )
Declare @sNbreMiniMob   VarChar ( 5 )
Declare @dcIdProd	Decimal ( 7 )

Set @iRet = -1
Set @dcIdGti = -100
Set @sIdTypArt = 'XXX'
Set @sCWE = 'NON'

SET NOCOUNT ON

/* Sinistre Passe droit pour D. Buire */
-- [PM462-1] on passe à 1000000
IF	@adcIdSin <> 1000000 
	BEGIN
		Select  @sCWE = 'OUI',
		        @dcIdGti = c.id_gti,
		        @sIdTypArt = c.id_typ_art,
			@dcIdProd = s.id_prod
		From    sysadm.sinistre s,
		        sysadm.commande c
		Where   s.id_sin = @adcIdSin
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBA'
		and     c.cod_etat = 'CWE'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )
		
		IF      @sCWE = 'NON'
		        BEGIN
		                -- Pas de commande
		                Select @asRetourMess = sysadm.FN_MESS ( 4, @asLangage )
		                RETURN ( -1 )
		        END
		
		BEGIN
		        Select  @sNbreMiniMob = Upper ( sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'NBRE_MINI_MOB', IsNull ( dp.val_car, '' ), ';' ) ))
		        From    sysadm.det_pro dp,
		                sysadm.sinistre s
		        Where   s.id_sin = @adcIdSin
		        and     dp.id_prod = s.id_prod
		        and     dp.id_typ_code_dp = '-DP' 
		        and     dp.id_code_dp = 80
		        and     dp.id_code_num = @dcIdGti
		        and     dp.id_code_car = @sIdTypArt 
		END
		
		If ISNUMERIC ( @sNbreMiniMob ) = 0 
		        BEGIN
		                -- Pas de commande
		                Select @asRetourMess = sysadm.FN_MESS ( 11, @asLangage )
		                RETURN ( -1 )
		        END
		Else
			BEGIN
				Set @iNbreMiniMob = Convert ( Integer, @sNbreMiniMob )
			END 
		
		If Upper ( sysadm.FN_TRIM ( @asMarque )) = '(Toute marque)' Set @asMarque = ''
		Set @asETOU = Upper ( sysadm.FN_TRIM ( @asETOU ) )
		Set @asMarque  = sysadm.FN_TRIM ( @asMarque ) 
	        Set @asModl    = sysadm.FN_TRIM ( @asModl ) 
		Set @asIdRefFour = sysadm.FN_TRIM ( @asIdRefFour )
		Set @asIdFour = sysadm.FN_TRIM ( @asIdFour )


	END

/* Init des zones nulles */
Select 	@asMarque=isnull(@asMarque,''),
        @asModl=isnull(@asModl,''),
		@asEQF=isnull(@asEQF,''),
		@asETOU=isnull(@asETOU,''),
		@asIdFour=isnull(@asIdFour,''),
		@asIdRefFour=isnull(@asIdRefFour,'')

/* Traitement des Cas */

-- #3 je scinde les deux cas 
If Upper ( @asCas ) in ( 'TEST_DISPOS' )
        Begin
		/* Sinistre Passe droit pour D. Buire */
		IF	@adcIdSin = 1000000 
			BEGIN
				Select  'TOUS' as 'marque'
			END
		ELSE	
			BEGIN
				Select  '(Toute marque)' as 'marque'
				Union all
		                Select  Distinct sysadm.FN_TRIM ( a4.id_marq_art_ifr ) + ' ' + sysadm.FN_TRIM ( a4.id_modl_art_ifr )
				From 	sysadm.article a4
		
				Where a4.id_marq_art_ifr is not null
				And   a4.id_modl_art_ifr is not null
--				And   ( rtrim ( a4.id_four ) + rtrim ( a4.id_marq_art ) <> 'O2MAPPLE' ) -- [PM166_URGENCE] 01/06/2011 -- [VDOC28596] Shunt
				And   a4.id_ref_four + a4.id_four = 
						(
				                Select  Top 1 Min ( a.id_ref_four + a.id_four )                                
				                From    ( 
							select  * ,
								( Select frequence
								  From   ifr i
								  Where  i.marque = a.id_marq_art_ifr
								  And    i.reference = a.id_modl_art_ifr
								  And 	 i.id_trait = (
										select max ( id_trait )
										From   sysadm.ifr i2
										Where  i2.marque = i.marque
										And    i2.reference = i.reference
										)
								) mt_prix_ifr
							from sysadm.article a
--							Where ( rtrim ( a.id_four ) + rtrim ( a.id_marq_art ) <> 'O2MAPPLE' ) -- [PM166_URGENCE] 01/06/2011 -- [VDOC28596] shunt
					
							) as a,  -- #1 redéfinition de la table article avec un col en plus
				                        (
				                        Select  distinct
				                                ct.id_code_frn as 'Fourn',
				                                ct.id_code_art as 'Typ_Article',
				                                Case -- [PM462-1]
													-- When sysadm.FN_CLE_NUMERIQUE ( 'PM462-1') > 0 Then 15000 -- Valeur haute pour tout ramener
													When 1=0 Then 15000 -- Valeur haute pour tout ramener (je fais ce la pour ne pas refair le case)
													Else c.mt_ttc_cmde  
												End as 'Plafond'
												
				                        From    sysadm.commande c,
				                                sysadm.commande_type ct,
				                                sysadm.sinistre s
				        
				                        Where   s.id_sin = @adcIdSin
				                        and     c.id_sin = s.id_sin
				                        and     c.id_four = 'WBA'
				                        and     c.cod_etat = 'CWE'
				                        and     c.id_seq = (    Select max ( c2.id_seq ) 
				                                                From sysadm.commande c2
				                                                Where c2.id_sin = c.id_sin
				                                                and   c2.id_four = c.id_four
				                                                and   c2.cod_etat = c.cod_etat )
				                        and     ct.id_prod = s.id_prod
				                        and     ct.id_gti  = c.id_gti
				                        and     ct.id_code_art = c.id_typ_art
				                        and     Left ( ct.id_code_frn, 2 ) <> 'WB'
				                        ) as Tb1,
							ifr i
				
					        Where   a.id_marq_art_ifr = a4.id_marq_art_ifr 
						And 	a.id_modl_art_ifr = a4.id_modl_art_ifr 
						And	a.id_four = Tb1.Fourn
						And     a.id_typ_art = Tb1.Typ_Article
				                And     a.alt_dispo = 'O'
				                And     a.qt_disp > 0
				                And     a.id_marq_art_ifr = i.marque 
				                And     a.id_modl_art_ifr = i.reference

					-- #2
						And     a.mt_prix_ht = ( Select min ( a5.mt_prix_ht )
									 From  sysadm.article a5
									 Where a5.id_marq_art_ifr = a.id_marq_art_ifr 
									 And   a5.id_modl_art_ifr = a.id_modl_art_ifr 
									 And   a5.id_typ_art = Tb1.Typ_Article
								         And   a5.alt_dispo = 'O'
								         And   a5.qt_disp > 0
									 And   a5.id_four in (
									                Select 
									                        ct2.id_code_frn 
									                From    sysadm.commande c2,
									                        sysadm.commande_type ct2,
									                        sysadm.sinistre s2
									
									                Where   s2.id_sin = @adcIdSin
									                and     c2.id_sin = s2.id_sin
									                and     c2.id_four = 'WBA'
									                and     c2.cod_etat = 'CWE'
									                and     c2.id_seq = (    Select max ( c3.id_seq ) 
									                                        From sysadm.commande c3
									                                        Where c3.id_sin = c2.id_sin
									                                        and   c3.id_four = c2.id_four
									   and   c3.cod_etat = c2.cod_etat )
									                and     ct2.id_prod = s2.id_prod
									                and     ct2.id_gti  = c2.id_gti
									                and     ct2.id_code_art = c2.id_typ_art
									                and     Left ( ct2.id_code_frn, 2 ) <> 'WB'
									                )						
									 )					        
					-- :#2					        
				                
				                
				                -- #1 [DCMP070698] application du plafond selon param, soit TTC_IFR soit TTC_FOURN
				                And     ( 
								-- Soit application TTC_FOURN
								( Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) <= Tb1.Plafond
								  And 
								  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) <> 'TTC_IFR'
								)
								Or 
								-- Soit application TTC_IFR
								( Isnull ( nullif ( a.mt_prix_ifr, 0 ), Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) ) <= Tb1.Plafond
								  And
								  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) = 'TTC_IFR'
								)
							)

						And     ( i.id_trait = ( Select Max ( i2.id_trait ) From ifr i2 where i2.provenance = 'IFR'  ) Or i.provenance = 'SPB' )
		
						-- Critère BTP important sur gestion -DP/56
						And     ( 	Not Exists ( Select * from sysadm.det_pro dp where dp.id_prod = @dcIdProd and id_code_dp = 56 )
							 	OR
								EXISTS (
								-- #5 [DCMP090639] 
								/*
								Select  *
								From	sysadm.det_pro dp,
									sysadm.code_car c
								Where 	dp.id_prod = @dcIdProd 
								and 	dp.id_code_dp = 56
								and 	c.id_typ_code = dp.id_typ_calc
								and 	CHARINDEX ( sysadm.FN_TRIM ( c.id_code) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0
								*/

								-- Nouveau Select
								Select  *
								From	sysadm.div_sin ds 
								Where 	
								Exists ( 
									Select *
									From sysadm.det_pro dp
									Where dp.id_prod = @dcIdProd 
									and 	dp.id_code_dp = 56
									)						
								and	ds.id_sin = @adcIdSin
								and	ds.nom_zone = 'choix_pack'
								and 	CHARINDEX ( sysadm.FN_TRIM ( ds.val_car) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0						

								)
								-- #5 [DCMP090639] 
							)

						)

			END
                Set @iRet = @@RowCount

                If @iRet < @iNbreMiniMob + 1   -- +1 car @iRet = 1 au minimum avec '(Aucune'
                        Begin
                                Select @asRetourMess = sysadm.FN_MESS ( 10, @asLangage )
                                RETURN ( -1 )
                        End
                Else
                        Begin
                        	Select @asRetourMess = 'OK'
                                RETURN ( @iRet )
                        End

        End

-- #3 je scinde les deux cas 
If Upper ( @asCas ) in ( 'CHRG_LST_MARQUES' )
        Begin
		/* Sinistre Passe droit pour D. Buire */
		IF	@adcIdSin = 1000000 
			BEGIN
				Select  'TOUS' as 'marque'
			END
		ELSE	
			BEGIN
				Select  '(Toute marque)' as 'marque'
				Union all
		                Select  Distinct sysadm.FN_TRIM ( a4.id_marq_art_ifr ) 
				From 	sysadm.article a4
		
				Where a4.id_marq_art_ifr is not null
				And   a4.id_modl_art_ifr is not null
--				And   ( rtrim ( a4.id_four ) + rtrim ( a4.id_marq_art ) <> 'O2MAPPLE' ) -- [PM166_URGENCE] 01/06/2011 -- [VDOC28596] shunt

				And   a4.id_ref_four + a4.id_four = 
						(
				                Select  Top 1 Min ( a.id_ref_four + a.id_four )                                
				                From    ( 
							select  * ,
								( Select frequence
								  From   ifr i
								  Where  i.marque = a.id_marq_art_ifr
								  And    i.reference = a.id_modl_art_ifr
								  And 	 i.id_trait = (
										select max ( id_trait )
										From   sysadm.ifr i2
										Where  i2.marque = i.marque
										And    i2.reference = i.reference
										)
								) mt_prix_ifr
							from sysadm.article a
--							Where ( rtrim ( a.id_four ) + rtrim ( a.id_marq_art ) <> 'O2MAPPLE' ) -- [PM166_URGENCE] 01/06/2011 -- [VDOC28596] shunt
							) as a,  -- #1 redéfinition de la table article avec un col en plus
				                        (
				                        Select  distinct
				                                ct.id_code_frn as 'Fourn',
				                                ct.id_code_art as 'Typ_Article',
				                                Case -- [PM462-1]
													-- When sysadm.FN_CLE_NUMERIQUE ( 'PM462-1') > 0 Then 15000 -- Valeur haute pour tout ramener
													When 1=0 Then 15000 -- Valeur haute pour tout ramener (je fais ce la pour ne pas refair le case)
													Else c.mt_ttc_cmde  
												End as 'Plafond'

				                        From    sysadm.commande c,
				                                sysadm.commande_type ct,
				                                sysadm.sinistre s
				        
				                        Where   s.id_sin = @adcIdSin
				                        and     c.id_sin = s.id_sin
				                        and     c.id_four = 'WBA'
				                        and     c.cod_etat = 'CWE'
				                        and     c.id_seq = (    Select max ( c2.id_seq ) 
				                                                From sysadm.commande c2
				                                                Where c2.id_sin = c.id_sin
				                                                and   c2.id_four = c.id_four
				                                                and   c2.cod_etat = c.cod_etat )
				                        and     ct.id_prod = s.id_prod
				                        and     ct.id_gti  = c.id_gti
				                        and     ct.id_code_art = c.id_typ_art
				                        and     Left ( ct.id_code_frn, 2 ) <> 'WB'
				                        ) as Tb1,
							ifr i
				
					        Where   a.id_marq_art_ifr = a4.id_marq_art_ifr 
						And 	a.id_modl_art_ifr = a4.id_modl_art_ifr 
						And	a.id_four = Tb1.Fourn
						And     a.id_typ_art = Tb1.Typ_Article
				                And     a.alt_dispo = 'O'
				                And     a.qt_disp > 0
				                And     a.id_marq_art_ifr = i.marque 
				                And     a.id_modl_art_ifr = i.reference

					-- #2
						And     a.mt_prix_ht = ( Select min ( a5.mt_prix_ht )
									 From  sysadm.article a5
									 Where a5.id_marq_art_ifr = a.id_marq_art_ifr 
									 And   a5.id_modl_art_ifr = a.id_modl_art_ifr 
									 And   a5.id_typ_art = Tb1.Typ_Article
								         And   a5.alt_dispo = 'O'
								         And   a5.qt_disp > 0
									 And   a5.id_four in (
									                Select 
									                        ct2.id_code_frn 
									                From    sysadm.commande c2,
									                        sysadm.commande_type ct2,
									                        sysadm.sinistre s2
									
									                Where   s2.id_sin = @adcIdSin
									                and     c2.id_sin = s2.id_sin
									                and     c2.id_four = 'WBA'
									                and     c2.cod_etat = 'CWE'
									                and     c2.id_seq = (    Select max ( c3.id_seq ) 
									                                        From sysadm.commande c3
									                                        Where c3.id_sin = c2.id_sin
									                                        and   c3.id_four = c2.id_four
									                                        and   c3.cod_etat = c2.cod_etat )
									                and     ct2.id_prod = s2.id_prod
									                and     ct2.id_gti  = c2.id_gti
									                and     ct2.id_code_art = c2.id_typ_art
									                and     Left ( ct2.id_code_frn, 2 ) <> 'WB'
									                )						
									 )					        
					-- :#2					        
				                
				                
				                -- #1 [DCMP070698] application du plafond selon param, soit TTC_IFR soit TTC_FOURN
				                And     ( 
								-- Soit application TTC_FOURN
								( Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) <= Tb1.Plafond
								  And 
								  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) <> 'TTC_IFR'
								)
								Or 
								-- Soit application TTC_IFR
								( Isnull ( nullif ( a.mt_prix_ifr, 0 ), Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) ) <= Tb1.Plafond
								  And
								  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) = 'TTC_IFR'
								)
							)

						And     ( i.id_trait = ( Select Max ( i2.id_trait ) From ifr i2 where i2.provenance = 'IFR'  ) Or i.provenance = 'SPB' )
		
						-- Critère BTP important sur gestion -DP/56
						And     ( 	Not Exists ( Select * from sysadm.det_pro dp where dp.id_prod = @dcIdProd and id_code_dp = 56 )
							 	OR
								EXISTS (
								-- #5 [DCMP090639] 
								/*
								Select  *
								From	sysadm.det_pro dp,
									sysadm.code_car c
								Where 	dp.id_prod = @dcIdProd 
								and 	dp.id_code_dp = 56
								and 	c.id_typ_code = dp.id_typ_calc
								and 	CHARINDEX ( sysadm.FN_TRIM ( c.id_code) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0
								*/

								-- Nouveau Select
								Select  *
								From	sysadm.div_sin ds 
								Where 	
								Exists ( 
									Select *
									From sysadm.det_pro dp
									Where dp.id_prod = @dcIdProd 
									and 	dp.id_code_dp = 56
									)						
								and	ds.id_sin = @adcIdSin
								and	ds.nom_zone = 'choix_pack'
								and 	CHARINDEX ( sysadm.FN_TRIM ( ds.val_car) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0						

								)
								-- #5 [DCMP090639] 
							)

						)



			END
                Set @iRet = @@RowCount
                Select @asRetourMess = 'OK' -- #3
                RETURN ( @iRet ) -- #3

/* -- #3 
                If @iRet < @iNbreMiniMob + 1   -- +1 car @iRet = 1 au minimum avec '(Aucune'
                        Begin
                                Select @asRetourMess = sysadm.FN_MESS ( 10, @asLangage )
                                RETURN ( -1 )
                        End
                Else
                        Begin
                        	Select @asRetourMess = 'OK'
                                RETURN ( @iRet )
                        End
*/                        

        End

If Upper ( @asCas ) = 'CHRG_LST_MOBILES'
	Begin

		/* Sinistre Passe droit pour D. Buire */
		-- JFF      24/04/2017   [PM373-1]
		-- CAS 0 : Passe droit
		IF	@adcIdSin = 1000000 
			Begin
				Select  Distinct
					Replace (					
						Replace ( 
							sysadm.FN_TRIM ( a4.id_marq_art_ifr ) + '_' + sysadm.FN_TRIM ( a4.id_modl_art_ifr )
							, ' ', '_' 
							)
						, '/', '_'
						)
						as 'cle',  -- #4 [DCMP080739] 
			                sysadm.FN_TRIM ( a4.id_marq_art_ifr ) as 'id_marq_art_ifr',
			                sysadm.FN_TRIM ( a4.id_modl_art_ifr ) as 'id_modl_art_ifr',
					sysadm.FN_TRIM ( a4.id_ref_four ) as 'id_ref_four',
					sysadm.FN_TRIM ( a4.id_four ) as 'id_four',
					Case When isnull(a4.observ_frn,'') like '%#REC#%' Then 'REC' Else 'NEU' End as 'etat_appareil'
					
				From 	sysadm.article a4
		
				Where a4.id_marq_art_ifr is not null
				And   a4.id_modl_art_ifr is not null
				And   a4.id_typ_art = 'TEL' -- [PM373-1]
				And   a4.id_ref_four + a4.id_four = 
								(
							        Select  Top 1 Min ( a.id_ref_four + a.id_four )
							        From    sysadm.article a
							        Where   a.id_four in ( 'CEG', 'DME', 'O2M', 'CIS', 'CDP', 'AGP', 'SRR' ) -- [PM373-1] -- FPI - Suppr de PAP, DDF, BTP
									And     a.id_marq_art_ifr = a4.id_marq_art_ifr 
									And     a.id_modl_art_ifr = a4.id_modl_art_ifr 
									And     a.id_typ_art = a4.id_typ_art -- [PM373-1]
								) 

		                Set @iRet = @@RowCount
		                Set @iRet = @@RowCount

			End 

	-- CAS 1 : Marque renseignée, EQF non renseignée, on ne tient pas compte de l'opérateur
		If sysadm.FN_TRIM ( @asMarque ) <> '' And sysadm.FN_TRIM ( @asEQF ) = '' And @adcIdSin <> 1000000 
			Begin 
				-- Trt de la marque
				Select  Distinct
					Replace (					
						Replace ( 
							sysadm.FN_TRIM ( a4.id_marq_art_ifr ) + '_' + sysadm.FN_TRIM ( a4.id_modl_art_ifr )
							, ' ', '_' 
							)
						, '/', '_'
						)
						as 'cle',  -- #4 [DCMP080739]
			                sysadm.FN_TRIM ( a4.id_marq_art_ifr ) as 'id_marq_art_ifr',
			                sysadm.FN_TRIM ( a4.id_modl_art_ifr ) as 'id_modl_art_ifr',
					sysadm.FN_TRIM ( a4.id_ref_four ) as 'id_ref_four',
					sysadm.FN_TRIM ( a4.id_four ) as 'id_four',
					Case When isnull(a4.observ_frn,'') like '%#REC#%' Then 'REC' Else 'NEU' End as 'etat_appareil'
				From 	sysadm.article a4
		
				Where a4.id_marq_art_ifr is not null
				And   a4.id_modl_art_ifr is not null
--				And   ( rtrim ( a4.id_four ) + rtrim ( a4.id_marq_art ) <> 'O2MAPPLE' ) -- [PM166_URGENCE] 01/06/2011 -- [VDOC28596] shunt
				And   a4.id_ref_four + a4.id_four = 				
						(
					        Select   Top 1 Min ( a.id_ref_four + a.id_four )
					                                        
					        From   ( 
							select  * ,
								( Select frequence
								  From   ifr i
								  Where  i.marque = a.id_marq_art_ifr
								  And    i.reference = a.id_modl_art_ifr
								  And 	 i.id_trait = (
										select max ( id_trait )
										From   sysadm.ifr i2
										Where  i2.marque = i.marque
										And    i2.reference = i.reference
										)
								) mt_prix_ifr
							from sysadm.article a
							) as a,  -- #1 redéfinition de la table article avec un col en plus
					                (
					                Select  distinct
					                        ct.id_code_frn as 'Fourn',
					                        ct.id_code_art as 'Typ_Article',
					                        Case -- [PM462-1]
												-- When sysadm.FN_CLE_NUMERIQUE ( 'PM462-1') > 0 Then 15000 -- Valeur haute pour tout ramener
												When 1= 0 Then 15000 -- Valeur haute pour tout ramener(je fais ce la pour ne pas refair le case)
												Else c.mt_ttc_cmde  
											End as 'Plafond'
					                From    sysadm.commande c,
					                        sysadm.commande_type ct,
					                        sysadm.sinistre s
					
					                Where   s.id_sin = @adcIdSin
					                and     c.id_sin = s.id_sin
					                and     c.id_four = 'WBA'
					                and     c.cod_etat = 'CWE'
					                and     c.id_seq = (    Select max ( c2.id_seq ) 
					                                        From sysadm.commande c2
					                                        Where c2.id_sin = c.id_sin
					                                        and   c2.id_four = c.id_four
					                                        and   c2.cod_etat = c.cod_etat )
					                and     ct.id_prod = s.id_prod
					                and     ct.id_gti  = c.id_gti
					                and     ct.id_code_art = c.id_typ_art
					                and     Left ( ct.id_code_frn, 2 ) <> 'WB'
					                ) as Tb1
					
					        Where   a.id_marq_art_ifr = a4.id_marq_art_ifr 
						And 	a.id_modl_art_ifr = a4.id_modl_art_ifr 
						And     a.id_four = Tb1.Fourn
						And     a.id_typ_art = Tb1.Typ_Article
					        And     a.alt_dispo = 'O'
					        And     a.qt_disp > 0
					        And     a.id_marq_art_ifr =  @asMarque 					        
					-- #2
						And     a.mt_prix_ht = ( Select min ( a5.mt_prix_ht )
									 From  sysadm.article a5
									 Where a5.id_marq_art_ifr = a.id_marq_art_ifr 
									 And   a5.id_modl_art_ifr = a.id_modl_art_ifr 
									 And   a5.id_typ_art = Tb1.Typ_Article
								         And   a5.alt_dispo = 'O'
								         And   a5.qt_disp > 0
									 And   a5.id_four in (
									                Select 
									                        ct2.id_code_frn 
									                From    sysadm.commande c2,
									                        sysadm.commande_type ct2,
									                        sysadm.sinistre s2
									
									                Where   s2.id_sin = @adcIdSin
									                and     c2.id_sin = s2.id_sin
									                and     c2.id_four = 'WBA'
									                and     c2.cod_etat = 'CWE'
									                and     c2.id_seq = (    Select max ( c3.id_seq ) 
									                                        From sysadm.commande c3
									                                        Where c3.id_sin = c2.id_sin
									                                        and   c3.id_four = c2.id_four

									                                        and   c3.cod_etat = c2.cod_etat )
									                and     ct2.id_prod = s2.id_prod
									                and     ct2.id_gti  = c2.id_gti
									                and     ct2.id_code_art = c2.id_typ_art
									                and     Left ( ct2.id_code_frn, 2 ) <> 'WB'
									                )						
									 )					        
					-- :#2					        
					        
				                -- #1 [DCMP070698] application du plafond selon param, soit TTC_IFR soit TTC_FOURN
				                And     ( 
								-- Soit application TTC_FOURN
								( Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) <= Tb1.Plafond
								  And 
								  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) <> 'TTC_IFR'
								)
								Or 
								-- Soit application TTC_IFR
								( Isnull ( nullif ( a.mt_prix_ifr, 0 ), Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) ) <= Tb1.Plafond
								  And
								  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) = 'TTC_IFR'
								)
							)
					
						-- Critère BTP important sur gestion -DP/56
						And     ( 	Not Exists ( Select * from sysadm.det_pro dp where dp.id_prod = @dcIdProd and id_code_dp = 56 )
							 	OR
								EXISTS (
								-- #5 [DCMP090639] 
								/*
								Select  *
								From	sysadm.det_pro dp,
									sysadm.code_car c
								Where 	dp.id_prod = @dcIdProd 
								and 	dp.id_code_dp = 56
								and 	c.id_typ_code = dp.id_typ_calc
								and 	CHARINDEX ( sysadm.FN_TRIM ( c.id_code) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0
								*/

								-- Nouveau Select
								Select  *
								From	sysadm.div_sin ds 
								Where 	
								Exists ( 
									Select *
									From sysadm.det_pro dp
									Where dp.id_prod = @dcIdProd 
									and 	dp.id_code_dp = 56
									)						
								and	ds.id_sin = @adcIdSin
								and	ds.nom_zone = 'choix_pack'
								and 	CHARINDEX ( sysadm.FN_TRIM ( ds.val_car) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0						

								)
								-- #5 [DCMP090639] 
							)
						)

		                Set @iRet = @@RowCount
			
			End
	-- FIN CAS 1
 
	-- CAS 2 : Marque non renseignée, EQF renseignée, on ne tient pas compte de l'opérateur
		If sysadm.FN_TRIM ( @asMarque ) = '' And sysadm.FN_TRIM ( @asEQF ) <> '' And @adcIdSin <> 1000000 
			Begin
				-- Trt EQF
				Select  Distinct
					Replace (					
						Replace ( 
							sysadm.FN_TRIM ( a4.id_marq_art_ifr ) + '_' + sysadm.FN_TRIM ( a4.id_modl_art_ifr )
							, ' ', '_' 
							)
						, '/', '_'
						)
						as 'cle',  -- #4 [DCMP080739]
			                sysadm.FN_TRIM ( a4.id_marq_art_ifr ) as 'id_marq_art_ifr',
			                sysadm.FN_TRIM ( a4.id_modl_art_ifr ) as 'id_modl_art_ifr',
					sysadm.FN_TRIM ( a4.id_ref_four ) as 'id_ref_four',
					sysadm.FN_TRIM ( a4.id_four ) as 'id_four',
					Case When isnull(a4.observ_frn,'') like '%#REC#%' Then 'REC' Else 'NEU' End as 'etat_appareil'

				From 	sysadm.article a4
		
				Where a4.id_marq_art_ifr is not null
				And   a4.id_modl_art_ifr is not null
--				And   ( rtrim ( a4.id_four ) + rtrim ( a4.id_marq_art ) <> 'O2MAPPLE' ) -- [PM166_URGENCE] 01/06/2011 -- [VDOC28596] shunt
				And   a4.id_ref_four + a4.id_four = 
						(
				                Select  Top 1 Min ( a.id_ref_four + a.id_four )                                
				                From    ( 
							select  * ,
								( Select frequence
								  From   ifr i
								  Where  i.marque = a.id_marq_art_ifr
								  And    i.reference = a.id_modl_art_ifr
								  And 	 i.id_trait = (
										select max ( id_trait )
										From   sysadm.ifr i2
										Where  i2.marque = i.marque
										And    i2.reference = i.reference
										)
								) mt_prix_ifr
							from sysadm.article a
							) as a,  -- #1 redéfinition de la table article avec un col en plus
				                        (
				                        Select  distinct
				                                ct.id_code_frn as 'Fourn',
				                                ct.id_code_art as 'Typ_Article',
												Case -- [PM462-1]
													-- When sysadm.FN_CLE_NUMERIQUE ( 'PM462-1') > 0 Then 15000 -- Valeur haute pour tout ramener
													When 1=0 Then 15000 -- Valeur haute pour tout ramener
													Else c.mt_ttc_cmde  
												End as 'Plafond'
				                        From    sysadm.commande c,
				                                sysadm.commande_type ct,
				                                sysadm.sinistre s
				        
				                        Where   s.id_sin = @adcIdSin
				                        and     c.id_sin = s.id_sin
				                        and     c.id_four = 'WBA'
				                        and     c.cod_etat = 'CWE'
				                        and     c.id_seq = (    Select max ( c2.id_seq ) 
				                                                From sysadm.commande c2
				                                                Where c2.id_sin = c.id_sin
				                                                and   c2.id_four = c.id_four
				                                                and   c2.cod_etat = c.cod_etat )
				                        and     ct.id_prod = s.id_prod
				                        and     ct.id_gti  = c.id_gti
				                        and     ct.id_code_art = c.id_typ_art
				                        and     Left ( ct.id_code_frn, 2 ) <> 'WB'
				                        ) as Tb1,
							ifr i
				
					        Where   a.id_marq_art_ifr = a4.id_marq_art_ifr 
						And 	a.id_modl_art_ifr = a4.id_modl_art_ifr 
						And	a.id_four = Tb1.Fourn
						And     a.id_typ_art = Tb1.Typ_Article
				                And     a.alt_dispo = 'O'
				                And     a.qt_disp > 0
				                And     a.id_marq_art_ifr = i.marque 
				                And     a.id_modl_art_ifr = i.reference

					-- #2
						And     a.mt_prix_ht = ( Select min ( a5.mt_prix_ht )
									 From  sysadm.article a5
									 Where a5.id_marq_art_ifr = a.id_marq_art_ifr 
									 And   a5.id_modl_art_ifr = a.id_modl_art_ifr 
									 And   a5.id_typ_art = Tb1.Typ_Article
								         And   a5.alt_dispo = 'O'
								         And   a5.qt_disp > 0
									 And   a5.id_four in (
									                Select 
									                        ct2.id_code_frn 
									                From    sysadm.commande c2,
									                        sysadm.commande_type ct2,
									                        sysadm.sinistre s2
									
									                Where   s2.id_sin = @adcIdSin
									                and     c2.id_sin = s2.id_sin
									                and     c2.id_four = 'WBA'
									                and     c2.cod_etat = 'CWE'
									                and     c2.id_seq = (    Select max ( c3.id_seq ) 
									                                        From sysadm.commande c3
									                                        Where c3.id_sin = c2.id_sin
									                                        and   c3.id_four = c2.id_four
									                                        and   c3.cod_etat = c2.cod_etat )
									                and     ct2.id_prod = s2.id_prod
									                and     ct2.id_gti  = c2.id_gti
									                and     ct2.id_code_art = c2.id_typ_art
									                and     Left ( ct2.id_code_frn, 2 ) <> 'WB'
									                )						
									 )					        
					-- :#2					        
				                
				                
				                -- #1 [DCMP070698] application du plafond selon param, soit TTC_IFR soit TTC_FOURN
				                And     ( 
								-- Soit application TTC_FOURN
								( Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) <= Tb1.Plafond
								  And 
								  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) <> 'TTC_IFR'
								)
								Or 
								-- Soit application TTC_IFR
								( Isnull ( nullif ( a.mt_prix_ifr, 0 ), Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) ) <= Tb1.Plafond
								  And
								  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) = 'TTC_IFR'
								)
							)

						And     ( i.id_trait = ( Select Max ( i2.id_trait ) From ifr i2 where i2.provenance = 'IFR'  ) Or i.provenance = 'SPB' )
		
						-- Critère BTP important sur gestion -DP/56
						And     ( 	Not Exists ( Select * from sysadm.det_pro dp where dp.id_prod = @dcIdProd and id_code_dp = 56 )
							 	OR
								EXISTS (
								-- #5 [DCMP090639] 
								/*
								Select  *
								From	sysadm.det_pro dp,
									sysadm.code_car c
								Where 	dp.id_prod = @dcIdProd 
								and 	dp.id_code_dp = 56
								and 	c.id_typ_code = dp.id_typ_calc
								and 	CHARINDEX ( sysadm.FN_TRIM ( c.id_code) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0
								*/

								-- Nouveau Select
								Select  *
								From	sysadm.div_sin ds 
								Where 	
								Exists ( 
									Select *
									From sysadm.det_pro dp
									Where dp.id_prod = @dcIdProd 
									and 	dp.id_code_dp = 56
									)						
								and	ds.id_sin = @adcIdSin
								and	ds.nom_zone = 'choix_pack'
								and 	CHARINDEX ( sysadm.FN_TRIM ( ds.val_car) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0						

								)
								-- #5 [DCMP090639] 
							)
		
						/* EQF : A complèter si besoin d'autres test sur l'EQF */
				                --Res.APN
				                And 	( 	sysadm.FN_CLE_VAL ( 'POIDS', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.poids + '#', sysadm.FN_CLE_VAL ( 'POIDS', @asEQF, ';' ), 1 ) > 0 
				                	)	
				                --Sys.Expl 
				                And 	( 	sysadm.FN_CLE_VAL ( 'INFRED', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.infred + '#', sysadm.FN_CLE_VAL ( 'INFRED', @asEQF, ';' ), 1 ) > 0 
				                	)	
				                --Reseau
				                And 	( 	sysadm.FN_CLE_VAL ( 'COMMSTND', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.commstnd + '#', sysadm.FN_CLE_VAL ( 'COMMSTND', @asEQF, ';' ), 1 ) > 0 
				                	)	
				                --Wifi
				                And 	( 	sysadm.FN_CLE_VAL ( 'SCRNCOL', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.scrncol + '#', sysadm.FN_CLE_VAL ( 'SCRNCOL', @asEQF, ';' ), 1 ) > 0 
				                	)
				                --Design	
				                And 	( 	sysadm.FN_CLE_VAL ( 'MODEM', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.modem + '#', sysadm.FN_CLE_VAL ( 'MODEM', @asEQF, ';' ), 1 ) > 0 
				                	)
								-- [PM373-1] - Taille écran
								 And 	( 	sysadm.FN_CLE_VAL ( 'PROVIDER', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.provider + '#', sysadm.FN_CLE_VAL ( 'PROVIDER', @asEQF, ';' ), 1 ) > 0 
				                	)
						)

		                Set @iRet = @@RowCount

			End
	-- FIN CAS 2 

	-- CAS 3 : Marque renseignée, EQF renseignée, Opérateur OU
		If sysadm.FN_TRIM ( @asMarque ) <> '' And sysadm.FN_TRIM ( @asEQF ) <> '' And @asETOU = 'OU' And @adcIdSin <> 1000000 
			Begin 
				-- Trt de la marque
				Select  Distinct
					Replace (					
						Replace ( 
							sysadm.FN_TRIM ( a4.id_marq_art_ifr ) + '_' + sysadm.FN_TRIM ( a4.id_modl_art_ifr )
							, ' ', '_' 
							)
						, '/', '_'
						)
						as 'cle',  -- #4 [DCMP080739]
			                sysadm.FN_TRIM ( a4.id_marq_art_ifr ) as 'id_marq_art_ifr',
			                sysadm.FN_TRIM ( a4.id_modl_art_ifr ) as 'id_modl_art_ifr',
					sysadm.FN_TRIM ( a4.id_ref_four ) as 'id_ref_four',
					sysadm.FN_TRIM ( a4.id_four ) as 'id_four',
					Case When isnull(a4.observ_frn,'') like '%#REC#%' Then 'REC' Else 'NEU' End as 'etat_appareil'
				From 	sysadm.article a4
		
				Where a4.id_marq_art_ifr is not null
				And   a4.id_modl_art_ifr is not null
--				And   ( rtrim ( a4.id_four ) + rtrim ( a4.id_marq_art ) <> 'O2MAPPLE' ) -- [PM166_URGENCE] 01/06/2011 -- [VDOC28596] shunt
				And   a4.id_ref_four + a4.id_four = 
						(
					        Select  Top 1 Min ( a.id_ref_four + a.id_four ) 
					                                        
					        From    ( 
							select  * ,
								( Select frequence
								  From   ifr i
								  Where  i.marque = a.id_marq_art_ifr
								  And    i.reference = a.id_modl_art_ifr
								  And 	 i.id_trait = (
										select max ( id_trait )
										From   sysadm.ifr i2
										Where  i2.marque = i.marque
										And    i2.reference = i.reference
										)
								) mt_prix_ifr
							from sysadm.article a
							) as a,  -- #1 redéfinition de la table article avec un col en plus
					                (
					                Select  distinct
					                        ct.id_code_frn as 'Fourn',
					                        ct.id_code_art as 'Typ_Article',
					                        Case -- [PM462-1]
												-- When sysadm.FN_CLE_NUMERIQUE ( 'PM462-1') > 0 Then 15000 -- Valeur haute pour tout ramener
												When 1 = 0 Then 15000 -- Valeur haute pour tout ramener
												Else c.mt_ttc_cmde  
											End as 'Plafond'
					                From    sysadm.commande c,
					                        sysadm.commande_type ct,
					                        sysadm.sinistre s
					
					                Where   s.id_sin = @adcIdSin
					                and     c.id_sin = s.id_sin
					                and     c.id_four = 'WBA'
					                and     c.cod_etat = 'CWE'
					                and     c.id_seq = (    Select max ( c2.id_seq ) 
					                                        From sysadm.commande c2
					                                        Where c2.id_sin = c.id_sin
					                                        and   c2.id_four = c.id_four
					                                        and   c2.cod_etat = c.cod_etat )
					                and     ct.id_prod = s.id_prod
					                and     ct.id_gti  = c.id_gti
					                and     ct.id_code_art = c.id_typ_art
					                and     Left ( ct.id_code_frn, 2 ) <> 'WB'
					                ) as Tb1
					
					        Where   a.id_marq_art_ifr = a4.id_marq_art_ifr 
						And 	a.id_modl_art_ifr = a4.id_modl_art_ifr 
						And     a.id_four = Tb1.Fourn
						And     a.id_typ_art = Tb1.Typ_Article
					        And     a.alt_dispo = 'O'
					        And     a.qt_disp > 0             
					        And     a.id_marq_art_ifr = @asMarque					        
					-- #2
						And     a.mt_prix_ht = ( Select min ( a5.mt_prix_ht )
									 From  sysadm.article a5
									 Where a5.id_marq_art_ifr = a.id_marq_art_ifr 
									 And   a5.id_modl_art_ifr = a.id_modl_art_ifr 
									 And   a5.id_typ_art = Tb1.Typ_Article
								         And   a5.alt_dispo = 'O'
								         And   a5.qt_disp > 0
									 And   a5.id_four in (
									                Select 
									                        ct2.id_code_frn 
									                From    sysadm.commande c2,
									                        sysadm.commande_type ct2,
									                        sysadm.sinistre s2
									
									                Where   s2.id_sin = @adcIdSin
									                and     c2.id_sin = s2.id_sin
									                and     c2.id_four = 'WBA'
									                and     c2.cod_etat = 'CWE'
									                and     c2.id_seq = (    Select max ( c3.id_seq ) 
									                                        From sysadm.commande c3
									                                        Where c3.id_sin = c2.id_sin
									                                        and   c3.id_four = c2.id_four
									                                        and   c3.cod_etat = c2.cod_etat )
									                and     ct2.id_prod = s2.id_prod
									                and     ct2.id_gti  = c2.id_gti
									                and     ct2.id_code_art = c2.id_typ_art
									                and     Left ( ct2.id_code_frn, 2 ) <> 'WB'
									                )						
									 )					        
					-- :#2					        
					        
				                -- #1 [DCMP070698] application du plafond selon param, soit TTC_IFR soit TTC_FOURN
				  And     ( 
								-- Soit application TTC_FOURN
								( Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) <= Tb1.Plafond
								  And 
								  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) <> 'TTC_IFR'
								)
								Or 
								-- Soit application TTC_IFR
								( Isnull ( nullif ( a.mt_prix_ifr, 0 ), Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) ) <= Tb1.Plafond
								  And
								  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) = 'TTC_IFR'
								)
							)
					
						-- Critère BTP important sur gestion -DP/56
						And     ( 	Not Exists ( Select * from sysadm.det_pro dp where dp.id_prod = @dcIdProd and id_code_dp = 56 )
							 	OR
								EXISTS (
								-- #5 [DCMP090639] 
								/*
								Select  *
								From	sysadm.det_pro dp,
									sysadm.code_car c
								Where 	dp.id_prod = @dcIdProd 
								and 	dp.id_code_dp = 56
								and 	c.id_typ_code = dp.id_typ_calc
								and 	CHARINDEX ( sysadm.FN_TRIM ( c.id_code) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0
								*/

								-- Nouveau Select
								Select  *
								From	sysadm.div_sin ds 
								Where 	
								Exists ( 
									Select *
									From sysadm.det_pro dp
									Where dp.id_prod = @dcIdProd 
									and 	dp.id_code_dp = 56
									)						
								and	ds.id_sin = @adcIdSin
								and	ds.nom_zone = 'choix_pack'
								and 	CHARINDEX ( sysadm.FN_TRIM ( ds.val_car) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0						

								)
								-- #5 [DCMP090639] 
							)
						)

				UNION -- OU

				-- Trt de l'EQF
				Select  Distinct
					Replace (					
						Replace ( 
							sysadm.FN_TRIM ( a4.id_marq_art_ifr ) + '_' + sysadm.FN_TRIM ( a4.id_modl_art_ifr )
							, ' ', '_' 
							)
						, '/', '_'
						)
						as 'cle',  -- #4 [DCMP080739]
			                sysadm.FN_TRIM ( a4.id_marq_art_ifr ) as 'id_marq_art_ifr',
			                sysadm.FN_TRIM ( a4.id_modl_art_ifr ) as 'id_modl_art_ifr',
					sysadm.FN_TRIM ( a4.id_ref_four ) as 'id_ref_four',
					sysadm.FN_TRIM ( a4.id_four ) as 'id_four',
					Case When isnull(a4.observ_frn,'') like '%#REC#%' Then 'REC' Else 'NEU' End as 'etat_appareil'
					
				From 	sysadm.article a4
		
				Where a4.id_marq_art_ifr is not null
				And   a4.id_modl_art_ifr is not null
--				And   ( rtrim ( a4.id_four ) + rtrim ( a4.id_marq_art ) <> 'O2MAPPLE' ) -- [PM166_URGENCE] 01/06/2011 -- [VDOC28596] shunt
				And   a4.id_ref_four + a4.id_four = 
						(
				                Select Top 1 Min ( a.id_ref_four + a.id_four ) 
				                                                
				                From    ( 
							select  * ,
								( Select frequence
								  From   ifr i
								  Where  i.marque = a.id_marq_art_ifr
								  And    i.reference = a.id_modl_art_ifr
								  And 	 i.id_trait = (
										select max ( id_trait )
										From   sysadm.ifr i2
										Where  i2.marque = i.marque
										And    i2.reference = i.reference
										)
								) mt_prix_ifr
							from sysadm.article a
							) as a,  -- #1 redéfinition de la table article avec un col en plus
				                        (
				                        Select  distinct
				                                ct.id_code_frn as 'Fourn',
				                                ct.id_code_art as 'Typ_Article',
												Case -- [PM462-1]
													-- When sysadm.FN_CLE_NUMERIQUE ( 'PM462-1') > 0 Then 15000 -- Valeur haute pour tout ramener
													When 1 = 0 Then 15000 -- Valeur haute pour tout ramener
													Else c.mt_ttc_cmde  
												End as 'Plafond'
				                        From    sysadm.commande c,
				                                sysadm.commande_type ct,
				                                sysadm.sinistre s
				        
				                        Where   s.id_sin = @adcIdSin
				                        and     c.id_sin = s.id_sin
				                        and     c.id_four = 'WBA'
				                        and     c.cod_etat = 'CWE'
				                        and     c.id_seq = (    Select max ( c2.id_seq ) 
				                                          From sysadm.commande c2
				                                                Where c2.id_sin = c.id_sin
				                                                and   c2.id_four = c.id_four
				                                                and   c2.cod_etat = c.cod_etat )
				                        and     ct.id_prod = s.id_prod
				                        and     ct.id_gti  = c.id_gti
				                        and     ct.id_code_art = c.id_typ_art
				                        and     Left ( ct.id_code_frn, 2 ) <> 'WB'
				                        ) as Tb1,
							ifr i
				
					        Where   a.id_marq_art_ifr = a4.id_marq_art_ifr 
						And 	a.id_modl_art_ifr = a4.id_modl_art_ifr 
						And	a.id_four = Tb1.Fourn
						And     a.id_typ_art = Tb1.Typ_Article
				                And     a.alt_dispo = 'O'
				                And     a.qt_disp > 0             
				                And     a.id_marq_art_ifr = i.marque 
				                And     a.id_modl_art_ifr = i.reference 
						And     ( i.id_trait = ( Select Max ( i2.id_trait ) From ifr i2 where i2.provenance = 'IFR'  ) Or i.provenance = 'SPB' )

					-- #2
						And     a.mt_prix_ht = ( Select min ( a5.mt_prix_ht )
									 From  sysadm.article a5
									 Where a5.id_marq_art_ifr = a.id_marq_art_ifr 
									 And   a5.id_modl_art_ifr = a.id_modl_art_ifr 
									 And   a5.id_typ_art = Tb1.Typ_Article
								         And   a5.alt_dispo = 'O'
								         And   a5.qt_disp > 0
									 And   a5.id_four in (
									                Select 
									                        ct2.id_code_frn 
									                From    sysadm.commande c2,
									                        sysadm.commande_type ct2,
									                        sysadm.sinistre s2
									
									                Where   s2.id_sin = @adcIdSin
									                and     c2.id_sin = s2.id_sin
									                and     c2.id_four = 'WBA'
									                and     c2.cod_etat = 'CWE'
									                and     c2.id_seq = (    Select max ( c3.id_seq ) 
									                                        From sysadm.commande c3
									                                        Where c3.id_sin = c2.id_sin
									                                        and   c3.id_four = c2.id_four
									                                        and   c3.cod_etat = c2.cod_etat )
									                and     ct2.id_prod = s2.id_prod
									                and     ct2.id_gti  = c2.id_gti
									                and     ct2.id_code_art = c2.id_typ_art
									                and     Left ( ct2.id_code_frn, 2 ) <> 'WB'
									                )						
									 )					        
					-- :#2
				                
				                -- #1 [DCMP070698] application du plafond selon param, soit TTC_IFR soit TTC_FOURN
				                And     ( 
								-- Soit application TTC_FOURN
								( Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) <= Tb1.Plafond
								  And 
								  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) <> 'TTC_IFR'
								)
								Or 
								-- Soit application TTC_IFR
								( Isnull ( nullif ( a.mt_prix_ifr, 0 ), Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) ) <= Tb1.Plafond
								  And
								  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) = 'TTC_IFR'
								)
							)
		
						-- Critère BTP important sur gestion -DP/56
						And     ( 	Not Exists ( Select * from sysadm.det_pro dp where dp.id_prod = @dcIdProd and id_code_dp = 56 )
							 	OR
								EXISTS (
								-- #5 [DCMP090639] 
								/*
								Select  *
								From	sysadm.det_pro dp,
									sysadm.code_car c
								Where 	dp.id_prod = @dcIdProd 
								and 	dp.id_code_dp = 56
								and 	c.id_typ_code = dp.id_typ_calc
								and 	CHARINDEX ( sysadm.FN_TRIM ( c.id_code) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0
								*/

								-- Nouveau Select
								Select  *
								From	sysadm.div_sin ds 
								Where 	
								Exists ( 
									Select *
									From sysadm.det_pro dp
									Where dp.id_prod = @dcIdProd 
									and 	dp.id_code_dp = 56
									)						
								and	ds.id_sin = @adcIdSin
								and	ds.nom_zone = 'choix_pack'
								and 	CHARINDEX ( sysadm.FN_TRIM ( ds.val_car) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0						

								)
								-- #5 [DCMP090639] 
							)
		
						/* EQF : A complèter si besoin d'autres test sur l'EQF */
				                --Res.APN
				                And 	( 	sysadm.FN_CLE_VAL ( 'POIDS', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.poids + '#', sysadm.FN_CLE_VAL ( 'POIDS', @asEQF, ';' ), 1 ) > 0 
				                	)	
				                --Sys.Expl 
				                And 	( 	sysadm.FN_CLE_VAL ( 'INFRED', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.infred + '#', sysadm.FN_CLE_VAL ( 'INFRED', @asEQF, ';' ), 1 ) > 0 
				                	)	
				                --Reseau
				                And 	( 	sysadm.FN_CLE_VAL ( 'COMMSTND', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.commstnd + '#', sysadm.FN_CLE_VAL ( 'COMMSTND', @asEQF, ';' ), 1 ) > 0 
				                	)	
				                --Wifi
				                And 	( 	sysadm.FN_CLE_VAL ( 'SCRNCOL', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.scrncol + '#', sysadm.FN_CLE_VAL ( 'SCRNCOL', @asEQF, ';' ), 1 ) > 0 
				                	)
				                --Design	
				                And 	( 	sysadm.FN_CLE_VAL ( 'MODEM', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.modem + '#', sysadm.FN_CLE_VAL ( 'MODEM', @asEQF, ';' ), 1 ) > 0 
				                	)
								-- [PM373-1] - Taille écran
								 And 	( 	sysadm.FN_CLE_VAL ( 'PROVIDER', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.provider + '#', sysadm.FN_CLE_VAL ( 'PROVIDER', @asEQF, ';' ), 1 ) > 0 
				                	)
						)
				

		                Set @iRet = @@RowCount
			
			End
	-- FIN CAS 3 

	-- CAS 4 : Marque renseignée, EQF renseignée, Opérateur ET
		If sysadm.FN_TRIM ( @asMarque ) <> '' And sysadm.FN_TRIM ( @asEQF ) <> '' And @asETOU = 'ET' And @adcIdSin <> 1000000 
			Begin 
				Select  Distinct
					Replace (					
						Replace ( 
							sysadm.FN_TRIM ( a4.id_marq_art_ifr ) + '_' + sysadm.FN_TRIM ( a4.id_modl_art_ifr )
							, ' ', '_' 
							)
						, '/', '_'
						)
						as 'cle',  -- #4 [DCMP080739]
			                sysadm.FN_TRIM ( a4.id_marq_art_ifr ) as 'id_marq_art_ifr',
			                sysadm.FN_TRIM ( a4.id_modl_art_ifr ) as 'id_modl_art_ifr',
					sysadm.FN_TRIM ( a4.id_ref_four ) as 'id_ref_four',
					sysadm.FN_TRIM ( a4.id_four ) as 'id_four',
					Case When isnull(a4.observ_frn,'') like '%#REC#%' Then 'REC' Else 'NEU' End as 'etat_appareil'
					
				From 	sysadm.article a4
		
				Where a4.id_marq_art_ifr is not null
				And   a4.id_modl_art_ifr is not null
--				And   ( rtrim ( a4.id_four ) + rtrim ( a4.id_marq_art ) <> 'O2MAPPLE' ) -- [PM166_URGENCE] 01/06/2011 -- [VDOC28596] shunt
				And   a4.id_ref_four + a4.id_four = 
						(
					        Select  Top 1 Min ( a.id_ref_four + a.id_four )
			                                                
				                From    ( 
							select  * ,
								( Select frequence
								  From   ifr i
								  Where  i.marque = a.id_marq_art_ifr
								  And    i.reference = a.id_modl_art_ifr
								  And 	 i.id_trait = (
										select max ( id_trait )
										From   sysadm.ifr i2
										Where  i2.marque = i.marque
										And    i2.reference = i.reference
										)
								) mt_prix_ifr
							from sysadm.article a
							) as a,  -- #1 redéfinition de la table article avec un col en plus,
				                        (
				                        Select  distinct
				                                ct.id_code_frn as 'Fourn',
				                                ct.id_code_art as 'Typ_Article',
												Case -- [PM462-1]
													-- When sysadm.FN_CLE_NUMERIQUE ( 'PM462-1') > 0 Then 15000 -- Valeur haute pour tout ramener
													When 1 = 0 Then 15000 -- Valeur haute pour tout ramener
													Else c.mt_ttc_cmde  
												End as 'Plafond'
				                        From    sysadm.commande c,
				                                sysadm.commande_type ct,
				                                sysadm.sinistre s
				        
				                        Where   s.id_sin = @adcIdSin
				                        and     c.id_sin = s.id_sin
				                        and     c.id_four = 'WBA'
				                        and     c.cod_etat = 'CWE'
				                        and     c.id_seq = (    Select max ( c2.id_seq ) 
				                                                From sysadm.commande c2
				                                                Where c2.id_sin = c.id_sin
				                                                and   c2.id_four = c.id_four
				                                                and   c2.cod_etat = c.cod_etat )
				                        and     ct.id_prod = s.id_prod
				                        and     ct.id_gti  = c.id_gti
				                        and     ct.id_code_art = c.id_typ_art
				                        and     Left ( ct.id_code_frn, 2 ) <> 'WB'
				                        ) as Tb1,
							ifr i
				
					        Where   a.id_marq_art_ifr = a4.id_marq_art_ifr 
						And 	a.id_modl_art_ifr = a4.id_modl_art_ifr 
						And	a.id_four = Tb1.Fourn
						And     a.id_typ_art = Tb1.Typ_Article
				                And     a.alt_dispo = 'O'
				                And     a.qt_disp > 0             
				                And     a.id_marq_art_ifr = @asMarque 
				                And     a.id_modl_art_ifr = i.reference 
						And     ( i.id_trait = ( Select Max ( i2.id_trait ) From ifr i2 where i2.provenance = 'IFR'  ) Or i.provenance = 'SPB' )
				                
					-- #2
						And     a.mt_prix_ht = ( Select min ( a5.mt_prix_ht )
									 From  sysadm.article a5
									 Where a5.id_marq_art_ifr = a.id_marq_art_ifr 
									 And   a5.id_modl_art_ifr = a.id_modl_art_ifr 
									 And   a5.id_typ_art = Tb1.Typ_Article
								         And   a5.alt_dispo = 'O'
								         And   a5.qt_disp > 0
									 And   a5.id_four in (
									                Select 
									                        ct2.id_code_frn 
									                From    sysadm.commande c2,
									                        sysadm.commande_type ct2,
									                        sysadm.sinistre s2
									
									                Where   s2.id_sin = @adcIdSin
									                and     c2.id_sin = s2.id_sin
									                and     c2.id_four = 'WBA'
									                and     c2.cod_etat = 'CWE'
									                and     c2.id_seq = (    Select max ( c3.id_seq ) 
									                                        From sysadm.commande c3
									                                        Where c3.id_sin = c2.id_sin
									                                        and   c3.id_four = c2.id_four
									                                        and   c3.cod_etat = c2.cod_etat )
									                and     ct2.id_prod = s2.id_prod
									                and     ct2.id_gti  = c2.id_gti
									                and     ct2.id_code_art = c2.id_typ_art
									                and     Left ( ct2.id_code_frn, 2 ) <> 'WB'
									                )						
									 )					        
					-- :#2				                
				                -- #1 [DCMP070698] application du plafond selon param, soit TTC_IFR soit TTC_FOURN
				                And     ( 
								-- Soit application TTC_FOURN
								( Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) <= Tb1.Plafond
								  And 
								  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) <> 'TTC_IFR'
								)
								Or 
								-- Soit application TTC_IFR
								( Isnull ( nullif ( a.mt_prix_ifr, 0 ), Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) ) <= Tb1.Plafond
								  And
								  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) = 'TTC_IFR'
								)
							)
		
						-- Critère BTP important sur gestion -DP/56
						And     ( 	Not Exists ( Select * from sysadm.det_pro dp where dp.id_prod = @dcIdProd and id_code_dp = 56 )
							 	OR
								EXISTS (
								-- #5 [DCMP090639] 
								/*
								Select  *
								From	sysadm.det_pro dp,
									sysadm.code_car c
								Where 	dp.id_prod = @dcIdProd 
								and 	dp.id_code_dp = 56
								and 	c.id_typ_code = dp.id_typ_calc
								and 	CHARINDEX ( sysadm.FN_TRIM ( c.id_code) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0
								*/

								-- Nouveau Select
								Select  *
								From	sysadm.div_sin ds 
								Where 	
								Exists ( 
									Select *
									From sysadm.det_pro dp
									Where dp.id_prod = @dcIdProd 
									and 	dp.id_code_dp = 56
									)						
								and	ds.id_sin = @adcIdSin
								and	ds.nom_zone = 'choix_pack'
								and 	CHARINDEX ( sysadm.FN_TRIM ( ds.val_car) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0						

								)
								-- #5 [DCMP090639] 
							)
		
						/* EQF : A complèter si besoin d'autres test sur l'EQF */
				                --Res.APN
				                And 	( 	sysadm.FN_CLE_VAL ( 'POIDS', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.poids + '#', sysadm.FN_CLE_VAL ( 'POIDS', @asEQF, ';' ), 1 ) > 0 
				                	)	
				                --Sys.Expl 
				                And 	( 	sysadm.FN_CLE_VAL ( 'INFRED', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.infred + '#', sysadm.FN_CLE_VAL ( 'INFRED', @asEQF, ';' ), 1 ) > 0 
				                	)	
				                --Reseau
				                And 	( 	sysadm.FN_CLE_VAL ( 'COMMSTND', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.commstnd + '#', sysadm.FN_CLE_VAL ( 'COMMSTND', @asEQF, ';' ), 1 ) > 0 
				                	)	
				                --Wifi
				                And 	( 	sysadm.FN_CLE_VAL ( 'SCRNCOL', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.scrncol + '#', sysadm.FN_CLE_VAL ( 'SCRNCOL', @asEQF, ';' ), 1 ) > 0 
				                	)
				                --Design	
				                And 	( 	sysadm.FN_CLE_VAL ( 'MODEM', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.modem + '#', sysadm.FN_CLE_VAL ( 'MODEM', @asEQF, ';' ), 1 ) > 0 
				                	)
								-- [PM373-1] - Taille écran
								 And 	( 	sysadm.FN_CLE_VAL ( 'PROVIDER', @asEQF, ';' ) = ''
				                		Or 	
				                		CharIndex ( '#' + i.provider + '#', sysadm.FN_CLE_VAL ( 'PROVIDER', @asEQF, ';' ), 1 ) > 0 
				                	)
						)

		                Set @iRet = @@RowCount

			End 

	-- CAS 5 : Marque non renseignée, EQF non renseignée, on ne tient pas compte de l'opérateur
		If sysadm.FN_TRIM ( @asMarque ) = '' And sysadm.FN_TRIM ( @asEQF ) = '' And @adcIdSin <> 1000000 
			Begin
				-- Trt EQF
				Select  Distinct
					Replace (					
						Replace ( 
							sysadm.FN_TRIM ( a4.id_marq_art_ifr ) + '_' + sysadm.FN_TRIM ( a4.id_modl_art_ifr )
							, ' ', '_' 
							)
						, '/', '_'
						)
						as 'cle',  -- #4 [DCMP080739]
			                sysadm.FN_TRIM ( a4.id_marq_art_ifr ) as 'id_marq_art_ifr',
			                sysadm.FN_TRIM ( a4.id_modl_art_ifr ) as 'id_modl_art_ifr',
					sysadm.FN_TRIM ( a4.id_ref_four ) as 'id_ref_four',
					sysadm.FN_TRIM ( a4.id_four ) as 'id_four',
					Case When isnull(a4.observ_frn,'') like '%#REC#%' Then 'REC' Else 'NEU' End as 'etat_appareil'
					
				From 	sysadm.article a4
		
				Where a4.id_marq_art_ifr is not null
				And   a4.id_modl_art_ifr is not null
--				And   ( rtrim ( a4.id_four ) + rtrim ( a4.id_marq_art ) <> 'O2MAPPLE' ) -- [PM166_URGENCE] 01/06/2011 -- [VDOC28596] shunt
				And   a4.id_ref_four + a4.id_four = 
						(
				                Select  Top 1 Min ( a.id_ref_four + a.id_four )                                
				                From    ( 
							select  * ,
								( Select frequence
								  From   ifr i
								  Where  i.marque = a.id_marq_art_ifr
								  And    i.reference = a.id_modl_art_ifr
								  And 	 i.id_trait = (
										select max ( id_trait )
										From   sysadm.ifr i2
										Where  i2.marque = i.marque
										And    i2.reference = i.reference
										)
								) mt_prix_ifr
							from sysadm.article a
							) as a,  -- #1 redéfinition de la table article avec un col en plus
				                        (
				                        Select  distinct
				                                ct.id_code_frn as 'Fourn',
				                                ct.id_code_art as 'Typ_Article',
												Case -- [PM462-1]
													-- When sysadm.FN_CLE_NUMERIQUE ( 'PM462-1') > 0 Then 15000 -- Valeur haute pour tout ramener
													When 1 = 0 Then 15000 -- Valeur haute pour tout ramener
													Else c.mt_ttc_cmde  
												End as 'Plafond'
				                        From    sysadm.commande c,
				                                sysadm.commande_type ct,
				                                sysadm.sinistre s
				        
				                        Where   s.id_sin = @adcIdSin
				                        and     c.id_sin = s.id_sin
				                        and     c.id_four = 'WBA'
				                        and     c.cod_etat = 'CWE'
				                        and     c.id_seq = (    Select max ( c2.id_seq ) 
				                                                From sysadm.commande c2
				                                                Where c2.id_sin = c.id_sin
				                                                and   c2.id_four = c.id_four
				                                                and   c2.cod_etat = c.cod_etat )
				                        and     ct.id_prod = s.id_prod
				                        and     ct.id_gti  = c.id_gti
				                        and     ct.id_code_art = c.id_typ_art
				                        and     Left ( ct.id_code_frn, 2 ) <> 'WB'
				                        ) as Tb1,
							ifr i
				
					        Where   a.id_marq_art_ifr = a4.id_marq_art_ifr 
						And 	a.id_modl_art_ifr = a4.id_modl_art_ifr 
						And	a.id_four = Tb1.Fourn
						And     a.id_typ_art = Tb1.Typ_Article
				                And     a.alt_dispo = 'O'
				                And     a.qt_disp > 0
				                And     a.id_marq_art_ifr = i.marque 
				                And     a.id_modl_art_ifr = i.reference

					-- #2
						And     a.mt_prix_ht = ( Select min ( a5.mt_prix_ht )
									 From  sysadm.article a5
									 Where a5.id_marq_art_ifr = a.id_marq_art_ifr 
									 And   a5.id_modl_art_ifr = a.id_modl_art_ifr 
									 And   a5.id_typ_art = Tb1.Typ_Article
								         And   a5.alt_dispo = 'O'
								         And   a5.qt_disp > 0
									 And   a5.id_four in (
									                Select 
									                        ct2.id_code_frn 
									                From    sysadm.commande c2,
									                        sysadm.commande_type ct2,
									                        sysadm.sinistre s2
									
									                Where   s2.id_sin = @adcIdSin
									                and     c2.id_sin = s2.id_sin
									                and     c2.id_four = 'WBA'
									                and     c2.cod_etat = 'CWE'
									                and     c2.id_seq = (    Select max ( c3.id_seq ) 
									                                        From sysadm.commande c3
									                                        Where c3.id_sin = c2.id_sin
									                                        and   c3.id_four = c2.id_four
									                                        and   c3.cod_etat = c2.cod_etat )
									                and     ct2.id_prod = s2.id_prod
									                and     ct2.id_gti  = c2.id_gti
									                and     ct2.id_code_art = c2.id_typ_art
									                and     Left ( ct2.id_code_frn, 2 ) <> 'WB'
									                )						
									 )					        
					-- :#2					        
				                
				                
				                -- #1 [DCMP070698] application du plafond selon param, soit TTC_IFR soit TTC_FOURN
				                And     ( 
								-- Soit application TTC_FOURN
								( Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) <= Tb1.Plafond
								  And 
								  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) <> 'TTC_IFR'
								)
								Or 
								-- Soit application TTC_IFR
								( Isnull ( nullif ( a.mt_prix_ifr, 0 ), Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) ) <= Tb1.Plafond
								  And
								  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) = 'TTC_IFR'
								)
							)

						And     ( i.id_trait = ( Select Max ( i2.id_trait ) From ifr i2 where i2.provenance = 'IFR'  ) Or i.provenance = 'SPB' )
		
						-- Critère BTP important sur gestion -DP/56
						And     ( 	Not Exists ( Select * from sysadm.det_pro dp where dp.id_prod = @dcIdProd and id_code_dp = 56 )
							 	OR
								EXISTS (
								-- #5 [DCMP090639] 
								/*
								Select  *
								From	sysadm.det_pro dp,
									sysadm.code_car c
								Where 	dp.id_prod = @dcIdProd 
								and 	dp.id_code_dp = 56
								and 	c.id_typ_code = dp.id_typ_calc
								and 	CHARINDEX ( sysadm.FN_TRIM ( c.id_code) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0
								*/

								-- Nouveau Select
								Select  *
								From	sysadm.div_sin ds 
								Where 	
								Exists ( 
									Select *
									From sysadm.det_pro dp
									Where dp.id_prod = @dcIdProd 
									and 	dp.id_code_dp = 56
									)						
								and	ds.id_sin = @adcIdSin
								and	ds.nom_zone = 'choix_pack'
								and 	CHARINDEX ( sysadm.FN_TRIM ( ds.val_car) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0						

								)
								-- #5 [DCMP090639] 
							)

						)

		                Set @iRet = @@RowCount

			End
	-- FIN CAS 5


		Select @asRetourMess = 'OK'
                RETURN ( @iRet )

        End


If Upper ( @asCas ) = 'TEST_CHOIX_DEF'
        Begin
                Select  @iRet = count(*)
                                                
		From 	sysadm.article a4

		Where a4.id_marq_art_ifr is not null
		And   a4.id_modl_art_ifr is not null
--		And   ( rtrim ( a4.id_four ) + rtrim ( a4.id_marq_art ) <> 'O2MAPPLE' ) -- [PM166_URGENCE] 01/06/2011 -- [VDOC28596] shunt
		And   a4.id_ref_four + a4.id_four = 
				(
				Select  Top 1 Min ( a.id_ref_four + a.id_four )                                
				From    ( 
					select  * ,
						( Select frequence
						  From   ifr i
						  Where  i.marque = a.id_marq_art_ifr
						  And    i.reference = a.id_modl_art_ifr
						  And 	 i.id_trait = (
								select max ( id_trait )
								From   sysadm.ifr i2
								Where  i2.marque = i.marque
								And    i2.reference = i.reference
								)
						) mt_prix_ifr
					from sysadm.article a
					) as a,  -- #1 redéfinition de la table article avec un col en plus
					(
					Select  distinct
						ct.id_code_frn as 'Fourn',
						ct.id_code_art as 'Typ_Article',
					    Case -- [PM462-1]
							-- When sysadm.FN_CLE_NUMERIQUE ( 'PM462-1') > 0 Then 15000 -- Valeur haute pour tout ramener
							When 1 = 0 Then 15000 -- Valeur haute pour tout ramener
							Else c.mt_ttc_cmde  
						End as 'Plafond'

					From    sysadm.commande c,
						sysadm.commande_type ct,
						sysadm.sinistre s

					Where   s.id_sin = @adcIdSin
					and     c.id_sin = s.id_sin
					and     c.id_four = 'WBA'
					and     c.cod_etat = 'CWE'
					and     c.id_seq = (    Select max ( c2.id_seq ) 
								From sysadm.commande c2
								Where c2.id_sin = c.id_sin
								and   c2.id_four = c.id_four
								and   c2.cod_etat = c.cod_etat )
					and     ct.id_prod = s.id_prod
					and     ct.id_gti  = c.id_gti
					and     ct.id_code_art = c.id_typ_art
					and     Left ( ct.id_code_frn, 2 ) <> 'WB'
					) as Tb1,
					ifr i

				Where   a.id_marq_art_ifr = a4.id_marq_art_ifr 
				And 	a.id_modl_art_ifr = a4.id_modl_art_ifr 
				And	a.id_four = Tb1.Fourn
				And     a.id_typ_art = Tb1.Typ_Article
				And     a.alt_dispo = 'O'
				And     a.qt_disp > 0
				And     a.id_marq_art_ifr = i.marque 
				And     a.id_modl_art_ifr = i.reference

			-- #2
				And     a.mt_prix_ht = ( Select min ( a5.mt_prix_ht )
							 From  sysadm.article a5
							 Where a5.id_marq_art_ifr = a.id_marq_art_ifr 
							 And   a5.id_modl_art_ifr = a.id_modl_art_ifr 
							 And   a5.id_typ_art = Tb1.Typ_Article
							 And   a5.alt_dispo = 'O'
							 And   a5.qt_disp > 0
							 And   a5.id_four in (
									Select 
										ct2.id_code_frn 
									From    sysadm.commande c2,
										sysadm.commande_type ct2,
										sysadm.sinistre s2

									Where   s2.id_sin = @adcIdSin
									and     c2.id_sin = s2.id_sin
									and     c2.id_four = 'WBA'
									and     c2.cod_etat = 'CWE'
									and     c2.id_seq = (    Select max ( c3.id_seq ) 
												From sysadm.commande c3
												Where c3.id_sin = c2.id_sin
												and   c3.id_four = c2.id_four
												and   c3.cod_etat = c2.cod_etat )
									and     ct2.id_prod = s2.id_prod
									and     ct2.id_gti  = c2.id_gti
									and     ct2.id_code_art = c2.id_typ_art
									and     Left ( ct2.id_code_frn, 2 ) <> 'WB'
									)						
							 )					        
			-- :#2					        


				-- #1 [DCMP070698] application du plafond selon param, soit TTC_IFR soit TTC_FOURN
				And     ( 
						-- Soit application TTC_FOURN
						( Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) <= Tb1.Plafond
						  And 
						  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) <> 'TTC_IFR'
						)
						Or 
						-- Soit application TTC_IFR
						( Isnull ( nullif ( a.mt_prix_ifr, 0 ), Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) ) <= Tb1.Plafond
						  And
						  Upper ( sysadm.FN_CLE_VAL ( 'SITE_CMDE', ( Select top 1 val_car from sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 92 ) , ';' )) = 'TTC_IFR'
						)
					)

				And     ( i.id_trait = ( Select Max ( i2.id_trait ) From ifr i2 where i2.provenance = 'IFR'  ) Or i.provenance = 'SPB' )
				And     a.id_marq_art_ifr  = @asMarque 
				And     a.id_modl_art_ifr  = @asModl 
				And     a.id_ref_four      = @asIdRefFour 
				And     a.id_four   	   = @asIdFour	

				-- Critère BTP important sur gestion -DP/56
				And     ( 	Not Exists ( Select * from sysadm.det_pro dp where dp.id_prod = @dcIdProd and id_code_dp = 56 )
						OR
						EXISTS (
						-- #5 [DCMP090639] 
						/*
						Select  *
						From	sysadm.det_pro dp,
							sysadm.code_car c
						Where 	dp.id_prod = @dcIdProd 
						and 	dp.id_code_dp = 56
						and 	c.id_typ_code = dp.id_typ_calc
						and 	CHARINDEX ( sysadm.FN_TRIM ( c.id_code) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0
						*/

						-- Nouveau Select
						Select  *
						From	sysadm.div_sin ds 
						Where 	
						Exists ( 
							Select *
							From sysadm.det_pro dp
							Where dp.id_prod = @dcIdProd 
							and 	dp.id_code_dp = 56
							)						
						and	ds.id_sin = @adcIdSin
						and	ds.nom_zone = 'choix_pack'
						and 	CHARINDEX ( sysadm.FN_TRIM ( ds.val_car) , sysadm.FN_TRIM ( a.observ_frn) , 1 ) > 0						

						)
						-- #5 [DCMP090639] 
					)

				)


                If @iRet <= 0
                        Begin
                                Select @asRetourMess = sysadm.FN_MESS ( 10, @asLangage )
                                RETURN ( -1 )
                        End
                Else
                        Begin
                        	Select @asRetourMess = 'OK'
                                RETURN ( @iRet )
                        End

        End

Return @iRet

GO

grant execute on sysadm.PS_SPBW_MOBILES_DISPOS_V02 to rolebddsinistres
Go

-------------------------------------------------------------------
-- Procedure            :       PS_SPBW_IDENTIFICATION_ACCES_V01
-- Auteur               :       Fabry JF
-- Date                 :       13/02/2007 22:45
-- Libelle              :        
-- Commentaires         :       On va lancer l'identification du client
--                               
-- References           :       
--
-- Arguments            :       @asIdSin                VarChar (    7 )        (Val)
--				@asIdSession     	varchar(30),
--				@asBrowser       	varchar(50),
--                              @asNumTel               VarChar (   10 )        (Val)
--                              @asCodeAcces            VarChar (    6 )        (Val)
--                              @asCas                  VarChar (   20 )        (Val) Cas de trt : CNX = Connexion normale, entrée dans le site
--                                                                                                 CTRL1= Contrôle de référence action de validation
--                                                                                                       afin de savoir si le dossier est toujours 
--                                                                                                       à l'instant t, dans un état permettant une cmde Web
--                              @asLangage              VarChar (    3 )        (Val)  Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--                              @asRetourMess           VarChar ( 2000 )        (Réf)
--
-- Retourne             :       Integer                  1 = Tout est OK
--                                                      -1 = Il y a une erreur.
--
-------------------------------------------------------------------
-- Le 04/06/2007 JFF inversion contrôle Num tel et présence Travail
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SPBW_IDENTIFICATION_ACCES_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_SPBW_IDENTIFICATION_ACCES_V01
GO


CREATE PROCEDURE        sysadm.PS_SPBW_IDENTIFICATION_ACCES_V01
        @asIdSin                VarChar (    10 )        , -- [PI062]
	@asIdSession     	varchar(30),
	@asBrowser       	varchar(200),
        @asNumTel               VarChar (   10 )        ,
        @asCodeAcces            VarChar (    6 )        ,
        @asCas                  VarChar (    3 )        ,
        @asLangage              VarChar (    3 )        ,
        @asRetourMess           VarChar ( 2000 ) OUTPUT
AS
/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications Paramêtres                                                                                                      */
/* @asIdSIn      = N° du sinistre positionné dans le TextBox txtIdSin du site.                                                  */
/* @asNumTel     = N° du téléphone sinistré positionné dans le TextBox txtNumTel du site.                                       */
/* @asCodeAcces  = Code accés positionné dans le TextBox txtCodeAcces du site.                                                  */
/*------------------------------------------------------------------------------------------------------------------------------*/
/* Informations : Il faudra prévoir d'appeler cette procédure à chaque traitement sur le site (sans le code d'accés et sans     */
/* le n° de téléphone !! a vérifier) afin de contrôler la validité des informations en temps réél.                              */
/*------------------------------------------------------------------------------------------------------------------------------*/
SET NOCOUNT ON

DECLARE @iRet           INTEGER   
DECLARE @iNbre          INTEGER   
DECLARE @dcIdSin        DECIMAL ( 10, 0) -- [PI062]
DECLARE @dcIdGti        DECIMAL ( 7, 0)
DECLARE @sMdp           VARCHAR ( 6 )
DECLARE @sDEL_MDP       VARCHAR ( 3 )
DECLARE @sCWE           VARCHAR ( 3 )
DECLARE @sMdpPresent    VARCHAR ( 3 )
DECLARE @sIdTypArt      VARCHAR ( 3 )
DECLARE @sUnite         VARCHAR ( 1 )
DECLARE @dtMax          DATETIME
DECLARE @dtMajle        DATETIME
DECLARE @dcCodeEtat     DECIMAL ( 7, 0 )

/*------------------------------------------------------------------*/
/* On va caster la référence sinistre.                              */
/*------------------------------------------------------------------*/
SET @iRet = 1
SET @dcIdSin = CONVERT ( DECIMAL (10,0), @asIdSin ) -- [PI062]
SET @sCWE = 'NON'
SET @sMdpPresent = 'NON'
SET @asCas = Upper ( @asCas )

IF      @asIdSin IS NULL                                OR 
        @asNumTel IS NULL                               OR 
        @asCodeAcces IS NULL                            OR
        LEN ( sysadm.FN_TRIM ( @asIdSin ) )  <  7   OR -- [PI062]
        LEN ( sysadm.FN_TRIM ( @asIdSin ) )  >  10   OR -- [PI062]
        LEN ( sysadm.FN_TRIM ( @asNumTel ) )  <> 10     OR
        LEN ( sysadm.FN_TRIM ( @asCodeAcces ) ) <> 6    OR
        Left ( sysadm.FN_TRIM ( @asNumTel ), 2 ) not in ('06','07') OR		  -- [NUM_TEL_07]
        ISNUMERIC ( @asIdSin ) = 0                      OR
        ISNUMERIC ( @asNumTel ) = 0                     
       
        BEGIN
                -- Informations incorrectes pour l'accés au site.
                Select @asRetourMess = sysadm.FN_MESS ( 1, @asLangage )
                RETURN ( -1 )
        END


/*----------------------------*/
/* Passe droit pour DBUIRE    */
/*----------------------------*/
IF	@dcIdSin = 1000000 And sysadm.FN_TRIM ( @asNumTel ) = '0600000001' And sysadm.FN_TRIM ( @asCodeAcces ) = 'A3EZ4R'
	BEGIN
		If @asCas = 'CNX'
		        BEGIN
						-- [20190418_JFF] V01 passé en V02
		                EXEC @iRet = sysadm.PS_SPBW_MOBILES_DISPOS_V02 @dcIdSin, 'TEST_DISPOS', null, null, null, null, null, null, @asLangage, @asRetourMess OUTPUT

				--[TRACE_2]
				EXEC sysadm.PS_I01_TRACE_CMDE_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					@dcIdSin,	-- @adcIdSin	Decimal (10), -- [PI062]
					@asNumTel,	-- @asNumTel       varchar(10),
					@asCodeAcces,	-- @asMdp           varchar(6),
					2,		-- @adcIdCodeTrc    Decimal(7),
					'TRACE',	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					@asCas,		-- @asEtape         varchar(20),
					null, 		-- @aiIdMess        integer
					null		-- @asMajPar	 VarChar ( 4 )

		                IF @iRet = -1 RETURN ( -1 )
		        END

		SET @asRetourMess = 'OK'
		RETURN ( @iRet )
	END

/*----------------------------*/
/* Passe droit pour PI        */
/*----------------------------*/
IF	@dcIdSin = 1330951 And sysadm.FN_TRIM ( @asNumTel ) = '0600000005' And sysadm.FN_TRIM ( @asCodeAcces ) = 'ZE4T6Y'
	-- [SIN]
	-- @dcIdSin = 0 
	BEGIN
		If @asCas = 'CNX'
		        BEGIN

				Update div_sin
				Set maj_le = Getdate ()
				where id_sin = 1330951
				and nom_zone = 'mdp_net'

				Update w_div_sin
				Set maj_le = Getdate ()
				where id_sin = 1330951
				and nom_zone = 'mdp_net'

		                EXEC @iRet = sysadm.PS_U11_COMMANDE_TEST_PI 

				--[TRACE_3]
				EXEC sysadm.PS_I01_TRACE_CMDE_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					@dcIdSin,	-- @adcIdSin	Decimal (10), -- [PI062]
					@asNumTel,	-- @asNumTel        varchar(10),
					@asCodeAcces,	-- @asMdp           varchar(6),
					3,		-- @adcIdCodeTrc    Decimal(7),
					'TRACE',	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					@asCas,		-- @asEtape         varchar(20),
					null, 		-- @aiIdMess        integer
					null		-- @asMajPar	 VarChar ( 4 )


		                IF @iRet = -1 
					BEGIN
						SET @asRetourMess = 'Erreur sur TEST PI'
						RETURN ( -1 )
					END
		        END
	END

/*----------------------------*/
/* Test Existance du sinistre */
/*----------------------------*/
IF      Not Exists ( Select * From sysadm.sinistre s where s.id_sin = @dcIdSin )
        BEGIN
                -- Sinistre inexistant chez SPB
                Select @asRetourMess = sysadm.FN_MESS ( 2, @asLangage )

		--[TRACE_4] 
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@dcIdSin,	-- @adcIdSin	Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			4,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			@asCas,		-- @asEtape         varchar(20),
			2,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
        END

/*----------------------------*/
/* Test égalité Num_tel       */
/*----------------------------*/
IF      Not Exists ( Select * From sysadm.sinistre s where s.id_sin = @dcIdSin and sysadm.FN_TRIM ( s.num_port) = sysadm.FN_TRIM ( @asNumTel ) )
        BEGIN
                -- n° de mobile différent
		--[TRACE_6]
                Select @asRetourMess = sysadm.FN_MESS ( 3, @asLangage )

		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			6,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			@asCas,		-- @asEtape         varchar(20),
			3, 		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
        END

/*----------------------------*/
/* Test existance travail     */
/*----------------------------*/
IF      Exists ( Select * From sysadm.w_queue wq where Convert ( Decimal ( 10), wq.id_sin ) = @dcIdSin ) -- [PI062]
        BEGIN
                -- Dossier en cours de gestion, présence travail.

                Select @asRetourMess = sysadm.FN_MESS ( 14, @asLangage )

		--[TRACE_5] 
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@dcIdSin,	-- @adcIdSin	Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			5,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			@asCas,		-- @asEtape         varchar(20),
			14, 		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
        END


/*--------------------------------*/
/* Test Existance et validité mdp */
/*--------------------------------*/
-- Contrôle préparatoire : y a-t-il une cmde en cours de trt chez un Frn
        BEGIN
                Select  @sCWE = 'OUI'
                From    sysadm.sinistre s,
                        sysadm.commande c
                Where   s.id_sin = @dcIdSin
                and     c.id_sin = s.id_sin
                and     c.cod_etat in ( 'ECT' ) 
                and     c.id_seq = (    Select max ( c2.id_seq ) 
                                        From sysadm.commande c2
                                        Where c2.id_sin = c.id_sin
                                        and   c2.id_four = c.id_four
                                        and   c2.cod_etat = c.cod_etat )
        END

IF      @sCWE = 'OUI'
        BEGIN
                -- Pas de commande en cours de trt chez un Frn
                Select @asRetourMess = sysadm.FN_MESS ( 9, @asLangage )

		--[TRACE_7]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			7,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			@asCas,		-- @asEtape         varchar(20),
			9, 		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
        END

/*--------------------------------*/
/* Test etat dossier              */
/*--------------------------------*/
Select @dcCodeEtat = s.cod_etat  From sysadm.sinistre s where s.id_sin = @dcIdSin 
IF      @dcCodeEtat Not in ( 100, 550 ) 
        BEGIN
                -- dossier clos !
                Select @asRetourMess = sysadm.FN_MESS ( 8, @asLangage )

		--[TRACE_8]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			8,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			@asCas,		-- @asEtape         varchar(20),
			8, 		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
        END 


-- Contrôle préparatoire : y a-t-il une cmde Web à dispo pour choix par l'assuré ?
        BEGIN
                Set     @sCWE = 'NON'

                Select  @sCWE = 'OUI',
                        @dcIdGti = c.id_gti,
                        @sIdTypArt = c.id_typ_art,
                        @dcCodeEtat = s.cod_etat
                From    sysadm.sinistre s,
                        sysadm.commande c
                Where   s.id_sin = @dcIdSin
                and     c.id_sin = s.id_sin
                and     c.id_four = 'WBA'
                and     c.cod_etat = 'CWE'
                and     c.id_seq = (    Select max ( c2.id_seq ) 
                                        From sysadm.commande c2
                                        Where c2.id_sin = c.id_sin
                            and   c2.id_four = c.id_four
                                        and   c2.cod_etat = c.cod_etat )
        END

IF      @sCWE = 'NON'
        BEGIN
                -- Pas de commande
                Select @asRetourMess = sysadm.FN_MESS ( 4, @asLangage )

		--[TRACE_9]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			9,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			@asCas,		-- @asEtape         varchar(20),
			4, 		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
        END


-- Récupération du délai de validité du mdp, ex : 35J
        BEGIN
                Select  @sDEL_MDP = Upper ( sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'DEL_MDP', IsNull ( dp.val_car, '' ), ';' ) ))
                From    sysadm.det_pro dp,
                        sysadm.sinistre s
                Where   s.id_sin = @dcIdSin
                and     dp.id_prod = s.id_prod
                and     dp.id_typ_code_dp = '-DP' 
                and     dp.id_code_dp = 80
                and     dp.id_code_num = @dcIdGti
                and     dp.id_code_car = @sIdTypArt 
        END

-- [ERR1]
IF      IsNumeric ( Left ( @sDEL_MDP, Len ( @sDEL_MDP ) -1 )) = 0 OR Right ( @sDEL_MDP, 1 ) Not in ( 'J', 'M', 'A' )
        BEGIN
                -- Problème param
                Select @asRetourMess = sysadm.FN_MESS ( 5, @asLangage )

		--[TRACE_10]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			10,		-- @adcIdCodeTrc    Decimal(7),
			'ERREUR', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			@asCas,		-- @asEtape         varchar(20),
			5, 		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )

        END

-- Armement préparatoire des deux valeurs de param indiquant la durée de la validité du mdp
        BEGIN
                Set @iNbre = Convert ( integer, Left ( @sDEL_MDP, 2 ) )
                Set @sUnite = Upper ( Right ( @sDEL_MDP, 1 ) )
        END

-- Récupération du mdp, avec dern date de maj
        BEGIN
                Select  @sMdpPresent = 'OUI',   
                        @sMdp = IsNull ( sysadm.FN_TRIM ( d.val_car ), '' ),
                        @dtMajle = d.maj_le
                From    sysadm.div_sin d 
                where   d.id_sin = @dcIdSin 
                and     d.nom_zone = 'mdp_net'
		and     sysadm.FN_TRIM ( d.val_car ) <> ''
        END

-- [ERR1]
IF      @sMdpPresent = 'NON' 
        BEGIN
                -- Mode passe absent sur dossier sinistre
                Select @asRetourMess = sysadm.FN_MESS ( 5, @asLangage )

		--[TRACE_11]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			11,		-- @adcIdCodeTrc    Decimal(7),
			'ERREUR', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			@asCas,		-- @asEtape         varchar(20),
			5, 		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
        END 

-- Calcul date max de validatié du mdp
        BEGIN
                Select  @dtMax = 
                        Case @sUnite
                                When 'J' Then DateAdd ( day, 1, DateAdd ( day, @iNbre, @dtMajle ))
                                When 'M' Then DateAdd ( day, 1, DateAdd ( month, @iNbre, @dtMajle ))
                                When 'A' Then DateAdd ( day, 1, DateAdd ( Year, @iNbre, @dtMajle ))
                        End 
        END

IF      @sMdpPresent = 'OUI' And @dtMax <= Getdate()
        BEGIN
                -- Mode passe présent mais durée validité dépassée
                Select @asRetourMess = sysadm.FN_MESS ( 6, @asLangage )

		--[TRACE_12]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			12,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			@asCas,		-- @asEtape         varchar(20),
			6, 		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
        END 

-- Test du code d'accès
IF      Upper ( sysadm.FN_TRIM ( @asCodeAcces ) ) <> Upper ( @sMdp )
        BEGIN
                -- Mode passe présent, valide, mais érroné
                Select @asRetourMess = sysadm.FN_MESS ( 7, @asLangage )

		--[TRACE_13]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			13,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			@asCas,		-- @asEtape         varchar(20),
			7,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
        END 

/*--------------------------------*/
/* Test si amu mobile disponilbe  */
/*--------------------------------*/
If @asCas = 'CNX'
        BEGIN
				-- [20190418_JFF] V01 passé en V02
                EXEC @iRet = sysadm.PS_SPBW_MOBILES_DISPOS_V02 @dcIdSin, 'TEST_DISPOS', null, null, null, null, null, null, @asLangage, @asRetourMess OUTPUT
                IF @iRet = -1 
			BEGIN
				--[TRACE_14]
				EXEC sysadm.PS_I01_TRACE_CMDE_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
					@asNumTel,	-- @asNumTel        varchar(10),
					@asCodeAcces,	-- @asMdp           varchar(6),
					14,		-- @adcIdCodeTrc    Decimal(7),
					'INFO_BLOQ', 	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					@asCas,		-- @asEtape         varchar(20),
					10,		-- @aiIdMess        integer
					null		-- @asMajPar	 VarChar ( 4 )

				RETURN ( -1 )
			END 

		-- [TRACE_20]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			20,		-- @adcIdCodeTrc    Decimal(7),
			'TRACE',	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			@asCas,		-- @asEtape         varchar(20),
			null,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )
        END

SET @asRetourMess = 'OK'
RETURN ( @iRet )

GO


-------------------------------------------------------------------
-- Procedure            :       PS_SPBW_IDENTIFICATION_LECTURE_V03
-- Auteur               :       FPI
-- Date                 :       13/06/2018
-- Libelle              :       [PM373-2] - ajout de la civilité longue
-- Commentaires         :       On va effectuer la lecture de certaines informations suite à l'identification réussie
--                               
-- References           :       
--
-- Arguments            :       @adcIdSin               Decimal ( 7,0  )        (Val)
--
-- Retourne             :       Integer                  1 = Tout est OK
--                                                      -1 = Il y a une erreur.
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SPBW_IDENTIFICATION_LECTURE_V03' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_SPBW_IDENTIFICATION_LECTURE_V03
GO


CREATE PROCEDURE        sysadm.PS_SPBW_IDENTIFICATION_LECTURE_V03
        @adcIdSin               Decimal ( 10,0 ) 
AS
/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications Paramêtre                                                                                                       */
/* @adcIdSIn      = N° du sinistre .                                                                                            */
/*------------------------------------------------------------------------------------------------------------------------------*/
SET NOCOUNT ON

DECLARE @iRet           INTEGER   

SET @iRet = 1


IF	@adcIdSin = 1000000 
	BEGIN
		SELECT  @adcIdSin as 'id_sin',
		        '0600000001' as 'num_port',
		        'PASSE DROIT GESTION IMAGE' AS 'NOM_PRENOM',
				'PASSE DROIT' AS NOM,
				'GESTION IMAGE' AS PRENOM,
		        '01/01/2007' as 'dte_surv',
		        'GTI' AS 'LIB_CODE',
		        'MARQUE' as 'marq_port',
		        'MODELE' as 'modl_port' ,
		        'Monsieur' as 'civ_longue' 
	END
ELSE IF	@adcIdSin = 1330951 
	BEGIN
		SELECT  s.id_sin,
		        s.num_port,
		        'SPB DEPT DEI/ES' AS 'NOM_PRENOM',
		        'SPB' AS NOM,
				'DEPT DEI/ES' AS PRENOM,
				s.dte_surv,
		        ( 	Select 	cg.lib_gti 
				From 	sysadm.code_garantie cg
				Where 	cg.id_prod = s.id_prod
				and     cg.id_gti  = c.id_gti
			) AS 'LIB_CODE',
		        s.marq_port,
		        s.modl_port,
			    sysadm.FN_CODE_NUM(p.cod_civ,'-CL') as 'civ_longue' 				
		
		FROM    sysadm.sinistre s,
		        sysadm.commande c,
		        personne p
		
		Where   s.id_sin = @adcIdSin
		and     p.id_ordre = s.id_ordre
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBA'
		and     c.cod_etat = 'CWE'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )
	END	
	
ELSE
	BEGIN
		SELECT  s.id_sin,
		        s.num_port,
		        sysadm.FN_TRIM ( p.nom ) + ' ' + sysadm.FN_TRIM ( p.prenom ) AS 'NOM_PRENOM',
		        sysadm.FN_TRIM ( p.nom )  as NOM,
				sysadm.FN_TRIM ( p.prenom ) as PRENOM,
				s.dte_surv,
		        ( 	Select 	cg.lib_gti 
				From 	sysadm.code_garantie cg
				Where 	cg.id_prod = s.id_prod
				and     cg.id_gti  = c.id_gti
			) AS 'LIB_CODE',
		        s.marq_port,
		        s.modl_port,
			    sysadm.FN_CODE_NUM(p.cod_civ,'-CL') as 'civ_longue' 	     
		
		FROM    sysadm.sinistre s,
		        sysadm.commande c,
		        personne p
		
		Where   s.id_sin = @adcIdSin
		and     p.id_ordre = s.id_ordre
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBA'
		and     c.cod_etat = 'CWE'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )
	END

RETURN ( @iRet )

GO

grant execute on sysadm.PS_SPBW_IDENTIFICATION_LECTURE_V03 to rolebddsinistres
Go

-------------------------------------------------------------------
-- Procedure            :       PS_SPBW_CHOIX_MOBILE_LISTE_MARQUE_V01
-- Auteur               :       Fabry JF
-- Date                 :       03/03/2007 22:45
-- Libelle              :        
-- Commentaires         :       On va récupérer la liste des marques disponibles pour le dossier
--                               
-- References           :       
--
-- Arguments            :       @adcIdSin               Decimal ( 7,0  )        (Val)
--				@asIdSession     	varchar(30),
--			        @asLangage              VarChar (    3 ),
--        			@asRetourMess           VarChar ( 2000 ) OUTPUT

--
-- Retourne             :       Integer                  1 = Tout est OK
--                                                      -1 = Il y a une erreur.
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SPBW_CHOIX_MOBILE_LISTE_MARQUE_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_SPBW_CHOIX_MOBILE_LISTE_MARQUE_V01
GO

CREATE PROCEDURE        sysadm.PS_SPBW_CHOIX_MOBILE_LISTE_MARQUE_V01
        @adcIdSin               Decimal ( 10,0 ), -- [PI062]
	@asIdSession     	varchar(30),
	@asBrowser       	varchar(200),
        @asLangage              VarChar (    3 ),
        @asRetourMess           VarChar ( 2000 ) OUTPUT
AS
/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications Parametre                                                                                                       */
/* @adcIdSIn      = N° du sinistre .                                                                                            */
/*------------------------------------------------------------------------------------------------------------------------------*/
SET NOCOUNT ON

DECLARE @iRet           INTEGER   

-- [20190418_JFF] V01 passé en V02
EXEC @iRet = sysadm.PS_SPBW_MOBILES_DISPOS_V02 @adcIdSin, 'CHRG_LST_MARQUES', null, null, null, null, null, null, @asLangage, @asRetourMess OUTPUT

IF @iRet < 0 
	BEGIN
		-- [TRACE_14]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@adcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			null,		-- @asNumTel        varchar(10),
			null,		-- @asMdp           varchar(6),
			14,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'LST_MARQUES',	-- @asEtape         varchar(20),
			10,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

	END 
        
RETURN ( @iRet )

GO

-------------------------------------------------------------------
-- Procedure            :       PS_SPBW_CODE_V01
-- Auteur               :       Fabry JF
-- Date                 :       03/03/2007 22:45
-- Libelle              :        
-- Commentaires         :       On va récupérer certains codes particuliers
--                               
-- References           :       
--
-- Arguments            :       @asIdTypCode            VarChar (    3 )        (Val)
--
-- Retourne             :       Integer                  1 = Tout est OK
--                                                      -1 = Il y a une erreur.
--
-------------------------------------------------------------------
-- 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SPBW_CODE_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_SPBW_CODE_V01
GO

CREATE PROCEDURE        sysadm.PS_SPBW_CODE_V01
        @asIdTypCode            VarChar (    3 )
AS
/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications Paramêtre                                                                                                       */
/* @sIdTypCode  = Type du code à charger.                                                                                       */
/*------------------------------------------------------------------------------------------------------------------------------*/
SET NOCOUNT ON

DECLARE @iRet           INTEGER   

SET @iRet = 1

/*------------------------------------------------------------------------------------------------------------------------------*/
/* Information : Cette procédure sert à populier certaines liste de codes. (Ex : Civilité, Caractéristiques des mobiles.        */
/*------------------------------------------------------------------------------------------------------------------------------*/
SELECT  c.id_typ_code,
        c.id_code,
        c.lib_code
FROM    sysadm.code     AS c
WHERE   c.id_typ_code   = @asIdTypCode
ORDER BY
        c.id_code
        
RETURN ( @iRet )

GO

-------------------------------------------------------------------
-- Procedure            :       PS_SPBW_CHOIX_COMMUNE_V01
-- Auteur               :       Fabry JF
-- Date                 :       13/02/2007 22:45
-- Libelle              :        
-- Commentaires         :       On va récupérer une liste de commune en fonction d'un code postal
--                               
-- References           :       
--
-- Arguments            :       @asCodePostal           VarChar (    5 )        (Val)
--
-- Retourne             :       Integer                  1 = Tout est OK
--                                                      -1 = Il y a une erreur.
--
-------------------------------------------------------------------
-- 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SPBW_CHOIX_COMMUNE_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_SPBW_CHOIX_COMMUNE_V01
GO

CREATE PROCEDURE        sysadm.PS_SPBW_CHOIX_COMMUNE_V01
        @asCodePostal           VarChar (    5 )
AS
/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications Paramêtres                                                                                                      */
/* @asCodePostal = CodePostal recherché.                                                                                        */
/*------------------------------------------------------------------------------------------------------------------------------*/
/* Informations : Il faudra prévoir de compiler cette commande sur le serveur F4T Base:SESAME_PRO.                              */
/*------------------------------------------------------------------------------------------------------------------------------*/
SET NOCOUNT ON

DECLARE @iRet           INTEGER
SET     @iRet = 1
/*------------------------------------------------------------------*/
/* On vérifie que l'argument est correct.                           */
/*------------------------------------------------------------------*/
IF      @asCodePostal   IS NULL                         OR
        LEN ( RTRIM ( LTRIM ( @asCodePostal ) ) ) <> 5  OR
        ISNUMERIC ( @asCodePostal ) = 0
        BEGIN
                RETURN (-1)
        END

SELECT  co.code_postal,
        co.nom_commune,
        co.nom_departement,
        co.cod_insee,
        co.cod_dept
FROM    sysadm.commune          AS      co
WHERE   co.code_postal  = @asCodePostal
ORDER BY
        co.nom_commune

RETURN ( @iRet )

GO

-------------------------------------------------------------------
-- Procedure            :       PS_SPBW_CODECAR_V01
-- Auteur               :       Fabry JF
-- Date                 :       03/03/2007 22:45
-- Libelle              :        
-- Commentaires         :       On va récupérer certains codes particuliers
--                               
-- References           :       
--
-- Arguments            :       @asIdTypCode            VarChar (    3 )        (Val)
--
-- Retourne             :       Integer                  1 = Tout est OK
--                                                      -1 = Il y a une erreur.
--
-------------------------------------------------------------------
-- 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SPBW_CODECAR_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_SPBW_CODECAR_V01
GO

CREATE PROCEDURE        sysadm.PS_SPBW_CODECAR_V01
        @asIdTypCode            VarChar (    3 )
AS
/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications Paramêtre                                                                                                       */
/* @sIdTypCode  = Type du code à charger.                                                                                       */
/*------------------------------------------------------------------------------------------------------------------------------*/
SET NOCOUNT ON

DECLARE @iRet           INTEGER   

SET @iRet = 1

/*------------------------------------------------------------------------------------------------------------------------------*/
/* Information : Cette procédure sert à populier certaines liste de codes.                                                      */
/*------------------------------------------------------------------------------------------------------------------------------*/
SELECT  c.id_typ_code,
        c.id_code,
        c.lib_code
FROM    sysadm.code_car AS c
WHERE   c.id_typ_code   = @asIdTypCode
ORDER BY
        c.id_code
        
RETURN ( @iRet )

GO


-------------------------------------------------------------------
-- Procedure            :       PS_SPBW_CHOIX_MOBILE_V01
-- Auteur               :       Fabry JF
-- Date                 :       13/02/2007 22:45
-- Libelle              :        
-- Commentaires         :       On va récupérer une liste de mobile
--                               
-- References           :       
--
-- Arguments            :       @adcIdSin               Decimal ( 7,0  )        (Val)
--				@asIdSession     	varchar(30),
--         			@asMarque               VarChar ( 35 ),
-- 				@asEQF			VarChar ( 150 ), 
--         			@asETOU			VarChar (  2 ),
--         			@asLangage              VarChar (    3 ),
--         			@asRetourMess           VarChar ( 2000 ) OUTPUT
--
-- Retourne             :       Integer                  1 = Tout est OK
--                                                      -1 = Il y a une erreur.
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SPBW_CHOIX_MOBILE_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_SPBW_CHOIX_MOBILE_V01
GO

CREATE PROCEDURE        sysadm.PS_SPBW_CHOIX_MOBILE_V01
        @adcIdSin               Decimal ( 10,0 ), -- [PI062]
	@asIdSession     	varchar(30),
	@asBrowser       	varchar(200),
        @asMarque               VarChar ( 35 ),
	@asEQF			VarChar ( 150 ), 
        @asETOU			VarChar (  2 ),
        @asLangage              VarChar (    3 ),
        @asRetourMess           VarChar ( 2000 ) OUTPUT
AS
/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications Paramêtres                                                                                                      */
/* @adcIdSin    = Référence Sinistre.                                                                                           */
/*------------------------------------------------------------------------------------------------------------------------------*/
SET NOCOUNT ON

DECLARE @iRet           INTEGER   

-- [PM373-1] FPI
EXEC @iRet = sysadm.PS_SPBW_MOBILES_DISPOS_V02 @adcIdSin, 'CHRG_LST_MOBILES', @asMarque, null, @asEQF, @asETOU, null, null, @asLangage, @asRetourMess OUTPUT


IF @iRet <= 0 
	BEGIN
		--[TRACE_14]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@adcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			null,		-- @asNumTel        varchar(10),
			null,		-- @asMdp           varchar(6),
			14,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'LST_MOBILES',	-- @asEtape         varchar(20),
			10,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

	END 


RETURN ( @iRet )
GO

-------------------------------------------------------------------
-- Procedure            :       PS_SPBW_COORDONNEES_LIVRAISON_V01
-- Auteur               :       Fabry JF
-- Date                 :       21/03/2007 
-- Libelle              :       Gestion des coordonnées de l'inter de livraison 
-- Commentaires         :       Gère la lecture des données existantes ainsi que la maj, le cas échéant
--                               
-- References           :       
--
-- Arguments            :       @adcIdSin               Decimal ( 7,0  )        (Val)
--				@asIdSession     	varchar(30),
-- 				@asMarque 		Varchar ( 35   )	,
-- 				@asModele		Varchar ( 35   )	,
-- 				@asIdRefFour            VarChar ( 20   )        ,
-- 				@asIdFour               VarChar (  3   )        ,
--                              @asLangage              VarChar (    3 )        (Val)  Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--                              @asRetourMess           VarChar ( 2000 )        (Réf)
--                              
--
-- Retourne             :       Integer                  1 = Tout est OK
--                                                      -1 = Il y a une erreur.
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SPBW_COORDONNEES_LIVRAISON_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_SPBW_COORDONNEES_LIVRAISON_V01
GO


CREATE PROCEDURE        sysadm.PS_SPBW_COORDONNEES_LIVRAISON_V01
        @adcIdSin               Decimal (    10 )        , -- [PI062]
	@asIdSession     	varchar(30),
	@asBrowser       	varchar(200),
	@asMarque 		Varchar ( 35   )	,
	@asModele		Varchar ( 35   )	,
	@asIdRefFour            VarChar ( 20   )        ,
	@asIdFour               VarChar (  3   )        ,
        @asLangage              VarChar (    3 )        ,
        @asRetourMess           VarChar ( 2000 ) OUTPUT
AS
SET NOCOUNT ON

DECLARE @iRet           INTEGER

Set @iRet = -1
Set @asRetourMess = 'KO'

SET NOCOUNT ON

-- [20190418_JFF] V01 passé en V02
EXEC @iRet = sysadm.PS_SPBW_MOBILES_DISPOS_V02 @adcIdSin, 'TEST_CHOIX_DEF', @asMarque, @asModele, null, null, @asIdRefFour, @asIdFour, @asLangage, @asRetourMess OUTPUT

IF @iRet <= 0 
	BEGIN
		--[TRACE_14]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@adcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			null,		-- @asNumTel        varchar(10),
			null,		-- @asMdp           varchar(6),
			14,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'COORD_LIVR',	-- @asEtape         varchar(20),
			10,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

	END 

If @iRet > 0 
	Begin
		Select  Top 1
		        c.adr_cod_civ,
		        c.adr_nom,
		        c.adr_prenom,
		        (       Select  Top 1 i.adr_mail 
		                from    sysadm.inter i
		                Where   i.id_sin = s.id_sin
		                And     i.cod_inter = 'A'
		        ) as adr_mail,
		        c.adr_tel1,
		        c.adr_tel2,
		        c.adr_tel3,
		        c.adr_livr1,
		        c.adr_livr2,
		        c.adr_livr_cpl,                        
		        c.adr_cp,
		        c.adr_ville
		
		From    sysadm.commande c,
		        sysadm.sinistre s
		
		Where   s.id_sin = @adcIdSin
		and     c.id_sin = s.id_sin
		and     c.id_four = 'WBA'
		and     c.cod_etat = 'CWE'
		and     c.id_seq = (    Select max ( c2.id_seq ) 
		                        From sysadm.commande c2
		                        Where c2.id_sin = c.id_sin
		                        and   c2.id_four = c.id_four
		                        and   c2.cod_etat = c.cod_etat )

		If @@Rowcount = 1 
			Begin
				Set @iRet = 1
				Set @asRetourMess = 'OK'
			End
	End 
Go


-------------------------------------------------------------------
-- Procedure            :       PS_SPBW_VALIDER_COMMANDE_V02
-- Auteur               :       Fabry JF
-- Date                 :       26/03/2007 
-- Libelle              :       Validation de la commande et des coordonnées de livraison
-- Commentaires         :       
--                               
-- References           :       
--
-- Arguments            :       @adcIdSin     	Decimal (  7,0 )        (Val)
-- 				@asIdSession    varchar (    30)	(Val)
-- 				@asBrowser      varchar (    50)	(Val)
-- 				@asNumTel       VarChar (   10 )	(Val)
-- 				@asCodeAcces    VarChar (    6 )	(Val)
-- 				@asIdRefFour	VarChar (  20  )	(Val) 
-- 				@asIdFour	VarChar (   3  )	(Val)
-- 				@asIdMarqArtIfr VarChar (  35  )	(Val)
-- 				@asIdModlArtIfr VarChar (  35  )	(Val)
-- 				@asCodCiv	VarChar (   1  )	(Val)
-- 				@asAdrNom	VarChar (  35  )	(Val)
-- 				@asAdrPrenom	VarChar (  35  )	(Val)
-- 				@asAdrLivr1	VarChar (  35  )	(Val)
-- 				@asAdrLivr2	VarChar (  35  )	(Val)
-- 				@asAdrLivrCpl	VarChar (  35  )	(Val)
-- 				@asAdrCP	VarChar (   5  )	(Val)
-- 				@asAdrVille	VarChar (  35  )	(Val)
-- 				@asAdrTel1	VarChar (  10  )	(Val)
-- 				@asAdrTel2	VarChar (  10  )	(Val)
-- 				@asAdrTel3	VarChar (  10  )	(Val)
-- 				@asAdrMail	VarChar (  120 )	(Val)
-- 				@asLangage      VarChar (    3 )	(Val)
-- 				@asRetourMess   VarChar ( 2000 ) 	(ref)
--                              @asLangage              VarChar (    3 )        (Val)  Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--                              @asRetourMess           VarChar ( 2000 )        (Réf)

--                              
--
-- Retourne             :       Integer                  1 = Tout est OK
--                                                      -1 = Il y a une erreur.
-- #1 JFF 23/07/2007 : Ajout de la création automatique de l'interlocuteur fournisseur liée à la validation
-- #2 JFF 08/02/2008 : Modif suite remontés C. Chauvin.
-- JFF      12/02/2016   [PI062]
-- JFF      07/08/2019   [PM462-1] ajout d'un arguement et passage à la V02
-------------------------------------------------------------------
/*
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SPBW_VALIDER_COMMANDE_V02' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_SPBW_VALIDER_COMMANDE_V02
GO
CREATE PROCEDURE        sysadm.PS_SPBW_VALIDER_COMMANDE_V02

La PS V02 ne verra jamais le jour, je reviens donc à la V01 en apportant les optimisation de la V02

*/
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SPBW_VALIDER_COMMANDE_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_SPBW_VALIDER_COMMANDE_V01
GO


CREATE PROCEDURE        sysadm.PS_SPBW_VALIDER_COMMANDE_V01
        @adcIdSin       Decimal (    10 ), -- [PI062]
	@asIdSession    varchar (    30),
	@asBrowser      varchar (   200),
        @asNumTel       VarChar (   10 ),
        @asCodeAcces    VarChar (    6 ),
	@asIdRefFour	VarChar (  20  ), 
	@asIdFour	VarChar (   3  ),
	@asIdMarqArtIfr VarChar (  35  ),
	@asIdModlArtIfr VarChar (  35  ),
	@asCodCiv	VarChar (   1  ),
	@asAdrNom	VarChar (  35  ),
	@asAdrPrenom	VarChar (  35  ),
	@asAdrLivr1	VarChar (  35  ),
	@asAdrLivr2	VarChar (  35  ),
	@asAdrLivrCpl	VarChar (  35  ),
	@asAdrCP	VarChar (   5  ),
	@asAdrVille	VarChar (  35  ),
	@asAdrTel1	VarChar (  10  ),
	@asAdrTel2	VarChar (  10  ),
	@asAdrTel3	VarChar (  10  ),
	@asAdrMail	VarChar (  120 ),
	-- @asMtPaiementPayBox varchar ( 20 ),  -- [PM462-1]  Je Shunt, lié à la V02 qui ne verra jamais le jour.
    @asLangage      VarChar (    3 ),
    @asRetourMess   VarChar ( 2000 ) OUTPUT

AS
SET NOCOUNT ON

Declare @iIdSeq		Integer
Declare @sCWE		VarChar ( 3 )
Declare @sDbName  	VarChar ( 20 )
Declare @iRet 		Integer
Declare @sIdSin		Varchar ( 10 ) -- [PI062]
Declare @sCasRetour 	VarChar ( 50 )
Declare @dtValideLe	Datetime -- #1
Declare @dcTTCArticle Decimal ( 11,2 ) -- [PM462-1]
Declare @dcMtPec Decimal ( 11,2 ) -- [PM462-1]
Declare @dcMtPaiementPayBox Decimal ( 11,2 ) -- [PM462-1]

Set @sCWE = 'NON'
set @sIdSin = Convert ( VarChar ( 10 ), @adcIdSin) -- [PI062]
Set @dtValideLe = GetDate()

IF	@adcIdSin = 1000000 And sysadm.FN_TRIM ( @asNumTel ) = '0600000001' And sysadm.FN_TRIM ( @asCodeAcces ) = 'A3EZ4R'
	BEGIN
                -- Passe droit pour D. Buire
                Select @asRetourMess = sysadm.FN_MESS ( 15, @asLangage )
                RETURN ( -1 )
	END


-- Dernier test de la validation de l'acces en cours
EXEC @iRet = sysadm.PS_SPBW_IDENTIFICATION_ACCES_V01
	@sIdSin,
	@asIdSession,
	@asBrowser,
        @asNumTel,
        @asCodeAcces,
        'CTRL1',
        @asLangage,
        @asRetourMess OUTPUT

If 	@iRet <= 0
	Begin
                -- Commande impossible
                RETURN ( -1 )
	End 

-- Recherche de la séquence en cours, avec en plus un contrôle sur la validité du dossier (qui ne coûte rien)
BEGIN
	Select  @sCWE = 'OUI',
	        @iIdSeq = c.id_seq
	From    sysadm.sinistre s,
	        sysadm.commande c
	Where   s.id_sin = @adcIdSin
	and     c.id_sin = s.id_sin
	and     c.id_four = 'WBA'
	and     c.cod_etat = 'CWE'
	and     c.id_seq = (    Select max ( c2.id_seq ) 
	                        From sysadm.commande c2
	                        Where c2.id_sin = c.id_sin
	                        and   c2.id_four = c.id_four
	                        and   c2.cod_etat = c.cod_etat )
	And	Not Exists ( Select * From   sysadm.w_queue wq Where Convert ( Decimal ( 10 ) , wq.id_sin ) = s.id_sin )  -- [PI062]
END

IF      @sCWE = 'NON'
        BEGIN
                -- Pas de commande
                Select @asRetourMess = sysadm.FN_MESS ( 4, @asLangage )

		--[TRACE_9]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@adcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			9,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			4, 		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
        END

-- Verrouillage optimiser de la table article (avant test disponibilité !)
EXEC sysadm.PS_U04_ARTICLE @asIdFour, @asIdRefFour

-- Test Disponibilité du mobile choisi
-- [20190418_JFF] V01 passé en V02
EXEC @iRet = sysadm.PS_SPBW_MOBILES_DISPOS_V02 @adcIdSin, 'TEST_CHOIX_DEF', @asIdMarqArtIfr, @asIdModlArtIfr, null, null, @asIdRefFour, @asIdFour, @asLangage, @asRetourMess OUTPUT

If 	@iRet <= 0
	Begin
        -- Commande impossible
		--[TRACE_14]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@adcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			14,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			10,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
	End 

-- Contrôle ajouté car soupçon de Bug sur l'extranet, des commandes d'appareils non chargé m'arrivent ici en validation.
-- Récup du TTC de l'article
Select @dcTTCArticle = Convert ( decimal ( 11,2 ), Convert ( money, mt_prix_ht * ( 1 + ( tva / 100 ) )))
From   sysadm.article a
Where  a.id_four = @asIdFour
And    a.id_ref_four = @asIdRefFour	
	
If @dcTTCArticle is null Set @dcTTCArticle = 0
	
-- Récup du mt de PEC
Select  @dcMtPec = c.mt_ttc_cmde
From    sysadm.commande c
Where   c.id_sin = @adcIdSin
and     c.id_four = 'WBA'
and     c.cod_etat = 'CWE'
and     c.id_seq = (    Select max ( c2.id_seq ) 
						From sysadm.commande c2
						Where c2.id_sin = c.id_sin
						and   c2.id_four = c.id_four
						and   c2.cod_etat = c.cod_etat )

If @dcMtPec is null Set @dcMtPec = 0

If @dcTTCArticle > @dcMtPec 
	Begin
		-- Commande impossible
		Select @asRetourMess = sysadm.FN_MESS ( 125, @asLangage )
		RETURN ( -1 )
	End 

-- [PM462-1] Traitement dépassement mt_pec et donc paiement Paybox pour le cplt.
/* lié à la V02
If sysadm.FN_CLE_NUMERIQUE ( 'PM462-1') > 0 
 Begin
 	-- Je regarde si le TTC de l'appareil est supérieur MT_PEC
	-- Si oui, nous sommes dans un dépassement, donc @adcMtPaiementPayBox doit être positif
	-- et la différent TTC article - MT_PEC doit être égale @adcMtPaiementPayBox, sinon, Erreur.

	If @asMtPaiementPayBox is null Set @asMtPaiementPayBox = '0'
	If rTrim ( lTrim ( @asMtPaiementPayBox )) = '' Set @asMtPaiementPayBox = '0'
	If IsNumeric ( @asMtPaiementPayBox ) <= 0 Set @asMtPaiementPayBox = '0'
	If IsNumeric ( @asMtPaiementPayBox ) > 0 Set @dcMtPaiementPayBox = Convert ( Decimal ( 11, 2 ), @asMtPaiementPayBox )

	-- Récup du TTC de l'article
	Select @dcTTCArticle = Convert ( decimal ( 11,2 ), Convert ( money, mt_prix_ht * ( 1 + ( tva / 100 ) )))
	From   sysadm.article a
	Where  a.id_four = @asIdFour
	And    a.id_ref_four = @asIdRefFour	
	
	If @dcTTCArticle is null Set @dcTTCArticle = 0
	
	-- Récup du mt de PEC
	Select  @dcMtPec = c.mt_ttc_cmde
	From    sysadm.commande c
	Where   c.id_sin = @adcIdSin
	and     c.id_four = 'WBA'
	and     c.cod_etat = 'CWE'
	and     c.id_seq = (    Select max ( c2.id_seq ) 
							From sysadm.commande c2
							Where c2.id_sin = c.id_sin
							and   c2.id_four = c.id_four
							and   c2.cod_etat = c.cod_etat )

	If @dcMtPec is null Set @dcMtPec = 0

	-- Si TTC > MT_PEC et que la difference des 2 n'est pas égale au cplt PayBox, il y a un problème
	If @dcTTCArticle > @dcMtPec And @dcTTCArticle - @dcMtPec <> @dcMtPaiementPayBox
	  Begin
                -- Commande impossible
                Select @asRetourMess = sysadm.FN_MESS ( 16, @asLangage )

		-- [TRACE_15] [ERR4]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@adcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			30,		-- @adcIdCodeTrc    Decimal(7),
			'ERREUR', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			16,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
	  End 

	-- Si TTC < MT PEC et que le montant paybox est positif, alors problème aussi (pas logique)
	If @dcTTCArticle < @dcMtPec And @dcMtPaiementPayBox > 0
	  Begin
                -- Commande impossible
                Select @asRetourMess = sysadm.FN_MESS ( 17, @asLangage )

		-- [TRACE_15] [ERR5]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@adcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			30,		-- @adcIdCodeTrc    Decimal(7),
			'ERREUR', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			17,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
	  End 

	  -- Maj table commande/w_commande
		EXEC @iRet = sysadm.PS_U10_COMMANDE_MAJ_WEB_V01
			@adcIdSin,
			@iIdSeq,
			@asIdRefFour, 
			@asIdFour,
			@asIdMarqArtIfr,
			@asIdModlArtIfr,
			@asCodCiv,
			@asAdrNom,
			@asAdrPrenom,
			@asAdrLivr1,
			@asAdrLivr2,
			@asAdrLivrCpl,
			@asAdrCP,
			@asAdrVille,
			@asAdrTel1,
			@asAdrTel2,
			@asAdrTel3,
			@asAdrMail,
			@dcMtPaiementPayBox
 
 End 
-- /[PM462-1]
Else
 Begin 
 */

	-- Maj table commande/w_commande
	EXEC @iRet = sysadm.PS_U10_COMMANDE_MAJ_WEB 
		@adcIdSin,
		@iIdSeq,
		@asIdRefFour, 
		@asIdFour,
		@asIdMarqArtIfr,
		@asIdModlArtIfr,
		@asCodCiv,
		@asAdrNom,
		@asAdrPrenom,
		@asAdrLivr1,
		@asAdrLivr2,
		@asAdrLivrCpl,
		@asAdrCP,
		@asAdrVille,
		@asAdrTel1,
		@asAdrTel2,
		@asAdrTel3,
		@asAdrMail
 -- End

If 	@iRet <= 0
	Begin
                -- Commande impossible
                Select @asRetourMess = sysadm.FN_MESS ( 12, @asLangage )

		-- [TRACE_15]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@adcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			15,		-- @adcIdCodeTrc    Decimal(7),
			'ERREUR', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			12,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
	End 


-- Maj table article (décrémentation du stock)
-- #2
If @adcIdSin = 1330951
 Begin 
	Set @iRet = 1
 End 
Else 
-- :#2
 Begin
	EXEC @iRet = sysadm.PS_U05_ARTICLE @adcIdSin, @iIdSeq	
 End

If 	@iRet <= 0
	Begin
                -- Commande impossible
                Select @asRetourMess = sysadm.FN_MESS ( 10, @asLangage )

		-- [TRACE_15]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@adcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			15,		-- @adcIdCodeTrc    Decimal(7),
			'ERREUR', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			10,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
	End 

-- Suppression de mot de passe [ERR3]
Update 	sysadm.div_sin
Set	val_car = null
Where  	id_sin = @adcIdSin
And	nom_zone = 'mdp_net'

If 	@@RowCount <> 1
 	Begin
                -- Commande impossible
                Select @asRetourMess = sysadm.FN_MESS ( 13, @asLangage )

		-- [TRACE_15]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@adcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			15,		-- @adcIdCodeTrc    Decimal(7),
			'ERREUR', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			13,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
	End 

-- #2
If @adcIdSin = 1330951
 Begin
	Select 'toto' -- Afin le @@rowcount soit égal à 1
 End
Else 
 Begin 
	Update 	sysadm.w_div_sin
	Set	val_car = null
	Where  	id_sin = @adcIdSin
	And	nom_zone = 'mdp_net'
 End

If 	@@RowCount <> 1
 	Begin
                -- Commande impossible
                Select @asRetourMess = sysadm.FN_MESS ( 13, @asLangage )

		-- [TRACE_15]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@adcIdSin,	-- @adcIdSin	    Decimal (10),  -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			15,		-- @adcIdCodeTrc    Decimal(7),
			'ERREUR', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			13,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
	End 

-- #1
EXEC @iRet = sysadm.PS_I03_INTER_VAL @adcIdSin, 'ASSU', @dtValideLe
If 	@iRet <> 0 
	Begin
		-- Commande impossible
		Select @asRetourMess = sysadm.FN_MESS ( 13, @asLangage )

		-- [TRACE_15]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@adcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			15,		-- @adcIdCodeTrc    Decimal(7),
			'ERREUR', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			13,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

		Return ( -1 )
	End 

-- Envoi Push de confimation 
Set @sDbName = Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) )
EXEC @iRet = sysadm.PS_S07_MAILPUSH_CONF_CMDE_WEB_ASS 'SIMPA2', @sDbName, @adcIdSin, @iIdSeq, @sCasRetour OUTPUT

If 	@sCasRetour <> 'MAIL_ENVOYE'
	Begin
                -- Commande impossible
                Select @asRetourMess = sysadm.FN_MESS ( 12, @asLangage )

		-- [TRACE_16]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@adcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			16,		-- @adcIdCodeTrc    Decimal(7),
			'ERREUR', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			12,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
	End 



/* Pour le test PI, on empêche au dernier moment la commande de partir */
IF	--@dcIdSin = [SIN]
	@adcIdSin = 1330951
	BEGIN
		Update sysadm.commande
		Set    id_lot_cmd = -1
		Where  id_sin = @adcIdSin
		And    id_seq = @iIdSeq

		Update 	sysadm.sinistre
		Set	id_prod = -1
		Where  	id_sin = @adcIdSin

		Update 	sysadm.w_sin
		Set	id_prod = -1
		Where  	id_sin = @adcIdSin

	END
Else
	Begin
		-- [TRACE_17]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@adcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			17,		-- @adcIdCodeTrc    Decimal(7),
			'TRACE', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			null,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )

	END  

Select @asRetourMess = 'OK'

Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @adcIdSin, 'WEB'

Return ( 1 )

Go

--------------------------------------------------------------------
--
-- Procédure            :       V_SPBW_TRCWB
-- Auteur               :       FABRY JF
-- Date                 :       03/05/2007
-- Libellé              :       Vue particulière pour la trace commande WEB
--
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'V_SPBW_TRCWB' AND type = 'V' )
        DROP view sysadm.V_SPBW_TRCWB
GO

CREATE view sysadm.V_SPBW_TRCWB
As
select  
maj_par,
cree_le,
sysadm.FN_CODE_NUM ( id_code_trc, id_typ_trc ) 'action',
id_session ,
id_sin,
num_tel,
mdp,
dte_maj_mdp,
id_seq,
id_prod,
id_gti,
gravite,
id_appli,
etape,
mt_plaf,
id_four_cmde,
id_marq_cmde,
id_modl_cmde,
mt_ttc_cmde,
sysadm.FN_MESS ( id_mess, 'FRA' ) 'mess',
browser
from sysadm.trace_cmde_web
Go

-------------------------------------------------------------------
-- Procedure            :       PS_SPBW_LECT_FONCT_ET_VAL
-- Auteur               :       Fabry JF
-- Date                 :       20/05/2011
-- Libelle              :       Lecture des fonctionnalités et valeurs de fonctionnalités nouvelle méthode.
-- Commentaires         :       
--                               
-- References           :       
--
-- Arguments            :       
--                              
--
-- Retourne             :       Integer  
-------------------------------------------------------------------
-- JFF      23/05/2018   [PM373-2]                
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SPBW_LECT_FONCT_ET_VAL' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_SPBW_LECT_FONCT_ET_VAL
GO

CREATE PROCEDURE sysadm.PS_SPBW_LECT_FONCT_ET_VAL
As

-- [PM373-2]

	-- poids
	Select  distinct 
		ce.id_col 'cod_fonc',
		ce.lib_col 'lib_fonc',
		i.poids 'cod_valeur',
		ce.lib_val_web 'lib_valeur',
		ce.ordre_valeur -- [PM373-2]
	from   	sysadm.ifr i,
		sysadm.code_equivalence ce
	Where	ce.id_val = i.poids 
	And 	ce.id_col = 'POIDS'
	Union all
	Select  distinct 
		ce.id_col 'cod_fonc',
		ce.lib_col 'lib_fonc',
		'-1',
		ce.lib_val_web 'lib_valeur',
		ce.ordre_valeur -- [PM373-2]
	from   	sysadm.code_equivalence ce
	Where	ce.id_val = '-1'
	And 	ce.id_col = 'POIDS'

	-- infred
	Union all
	Select  distinct 
		ce.id_col 'cod_fonc',
		ce.lib_col 'lib_fonc',
		i.infred 'cod_valeur',
		ce.lib_val_web 'lib_valeur',
		ce.ordre_valeur -- [PM373-2]
	from   	sysadm.ifr i,
		sysadm.code_equivalence ce
	Where	ce.id_val = i.infred
	And 	ce.id_col = 'INFRED'
	Union all
	Select  distinct 
		ce.id_col 'cod_fonc',
		ce.lib_col 'lib_fonc',
		'-1',
		ce.lib_val_web 'lib_valeur',
		ce.ordre_valeur -- [PM373-2]
	from   	sysadm.code_equivalence ce
	Where	ce.id_val = '-1'
	And 	ce.id_col = 'INFRED'


	-- commstnd
	Union all
	Select  distinct 
		ce.id_col 'cod_fonc',
		ce.lib_col 'lib_fonc',
		i.commstnd 'cod_valeur',
		ce.lib_val_web 'lib_valeur',
		ce.ordre_valeur -- [PM373-2]
	from   	sysadm.ifr i,
		sysadm.code_equivalence ce
	Where	ce.id_val = i.commstnd
	And 	ce.id_col = 'COMMSTND'
	Union all
	Select  distinct 
		ce.id_col 'cod_fonc',
		ce.lib_col 'lib_fonc',
		'-1',
		ce.lib_val_web 'lib_valeur',
		ce.ordre_valeur -- [PM373-2]
	from   	sysadm.code_equivalence ce
	Where	ce.id_val = '-1'
	And 	ce.id_col = 'COMMSTND'

	-- scrncol
	Union all
	Select  distinct 
		ce.id_col 'cod_fonc',
		ce.lib_col 'lib_fonc',
		i.scrncol 'cod_valeur',
		ce.lib_val_web 'lib_valeur',
		ce.ordre_valeur -- [PM373-2]
	from   	sysadm.ifr i,
		sysadm.code_equivalence ce
	Where	ce.id_val = i.scrncol
	And 	ce.id_col = 'SCRNCOL'
	Union all
	Select  distinct 
		ce.id_col 'cod_fonc',
		ce.lib_col 'lib_fonc',
		'-1',
		ce.lib_val_web 'lib_valeur',
		ce.ordre_valeur -- [PM373-2]
	from   	sysadm.code_equivalence ce
	Where	ce.id_val = '-1'
	And 	ce.id_col = 'SCRNCOL'

	-- modem
	Union all
	Select  distinct 
		ce.id_col 'cod_fonc',
		ce.lib_col 'lib_fonc',
		i.modem 'cod_valeur',
		ce.lib_val_web 'lib_valeur',
		ce.ordre_valeur -- [PM373-2]
	from   	sysadm.ifr i,
		sysadm.code_equivalence ce
	Where	ce.id_val = i.modem
	And 	ce.id_col = 'MODEM'
	Union all
	Select  distinct 
		ce.id_col 'cod_fonc',
		ce.lib_col 'lib_fonc',
		'-1',
		ce.lib_val_web 'lib_valeur',
		ce.ordre_valeur -- [PM373-2]
	from   	sysadm.code_equivalence ce
	Where	ce.id_val = '-1'
	And 	ce.id_col = 'MODEM'
	-- [PM373-1] 
	Union all
	Select  distinct 
		ce.id_col 'cod_fonc',
		ce.lib_col 'lib_fonc',
		'-1',
		ce.lib_val_web 'lib_valeur',
		ce.ordre_valeur -- [PM373-2]
	from   	sysadm.code_equivalence ce
	Where	ce.id_val = '-1'
	And 	ce.id_col = 'PROVIDER'
	Union all
	Select  distinct 
		ce.id_col 'cod_fonc',
		ce.lib_col 'lib_fonc',
		i.provider 'cod_valeur',
		ce.lib_val_web 'lib_valeur',
		ce.ordre_valeur -- [PM373-2]
	from   	sysadm.ifr i,
		sysadm.code_equivalence ce
	Where	ce.id_val = i.provider 
	And 	ce.id_col = 'PROVIDER'

	Order by cod_fonc, ordre_valeur


Go

grant execute on sysadm.PS_SPBW_LECT_FONCT_ET_VAL to rolebddsinistres
Go

-------------------------------------------------------------------
-- Procedure            :       PS_SPBW_GET_MT_PEC
-- Auteur               :       Fabry JF
-- Date                 :       21/06/2016 
-- Libelle              :        
-- Commentaires         :       [PM284-2]
--                               
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Integer                  1 = Tout est OK
--                                                      -1 = Il y a une erreur.
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SPBW_GET_MT_PEC' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_SPBW_GET_MT_PEC
GO

CREATE PROCEDURE sysadm.PS_SPBW_GET_MT_PEC
        @adcIdSin  Decimal ( 10 ),
		@adcMtPec  Decimal ( 11, 2 ) OutPut,
		@adcIdprod Decimal ( 7 ) OutPut
As
	Select  @adcMtPec = c.mt_ttc_cmde,
			@adcIdprod = s.id_prod
	From    sysadm.sinistre s,
			sysadm.commande c
	Where   s.id_sin = @adcIdSin
	and     c.id_sin = s.id_sin
	and     c.id_four = 'WBA'
	and     c.cod_etat = 'CWE'
	and     c.id_seq = (    Select max ( c2.id_seq ) 
							From sysadm.commande c2
							Where c2.id_sin = c.id_sin
							and   c2.id_four = c.id_four
							and   c2.cod_etat = c.cod_etat )

	If @adcMtPec is null Set @adcMtPec = 0

	Select @adcMtPec, @adcIdprod

Go

-------------------------------------------------------------------
-- Procedure            :       PS_SPBW_REMB_NUMERAIRE
-- Auteur               :       Fabry JF
-- Date                 :       21/06/2016 
-- Libelle              :        
-- Commentaires         :       [PM284-2]
--                               
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Integer                  1 = Tout est OK
--                                                      -1 = Il y a une erreur.
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SPBW_REMB_NUMERAIRE' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_SPBW_REMB_NUMERAIRE
GO

CREATE PROCEDURE sysadm.PS_SPBW_REMB_NUMERAIRE
        @adcIdSin  Decimal ( 10 ),
		@asIdSession    varchar (    30),
		@asBrowser      varchar (   200),
        @asNumTel       VarChar (   10 ),
        @asCodeAcces    VarChar (    6 ),
		@asLangage      VarChar (    3 ),
		@asRetourMess   VarChar ( 2000 ) OUTPUT
As

Declare @sMess VarChar ( 200 )
Declare @iIdSeq Integer
Declare @iIdCt Integer
Declare @sErr VarChar ( 255 )
Declare @iRet Integer
Declare @sIdSin Varchar ( 10 )
Declare @dtValideLe DateTime

Set @sMess = 'Prestation WEB annulée par l''assuré via le site de choix de mobile. L''assuré préfère un remboursement numéraire.'
set @sIdSin = Convert ( VarChar ( 10 ), @adcIdSin)
Set @dtValideLe = GetDate()

-- Dernier test de la validation de l'acces en cours
EXEC @iRet = sysadm.PS_SPBW_IDENTIFICATION_ACCES_V01
	@sIdSin,
	@asIdSession,
	@asBrowser,
    @asNumTel,
    @asCodeAcces,
    'CTRL1',
    @asLangage,
    @asRetourMess OUTPUT

If 	@iRet <= 0
	Begin
        -- Commande impossible
        RETURN ( -1 )
	End 

Select  @iIdSeq = c.id_seq
From    sysadm.sinistre s,
		sysadm.commande c
Where   s.id_sin = @adcIdSin
and     c.id_sin = s.id_sin
and     c.id_four = 'WBA'
and     c.cod_etat = 'CWE'
and     c.id_seq = (    Select max ( c2.id_seq ) 
						From sysadm.commande c2
						Where c2.id_sin = c.id_sin
						and   c2.id_four = c.id_four
						and   c2.cod_etat = c.cod_etat )
And		Not Exists ( Select * From   sysadm.w_queue wq Where Convert ( Decimal ( 10 ) , wq.id_sin ) = s.id_sin ) 

If @iIdSeq is null Or @iIdSeq <= 0 
	Begin
        Select @asRetourMess = sysadm.FN_MESS ( 123, @asLangage )

		-- [TRACE_15]
		EXEC sysadm.PS_I01_TRACE_CMDE_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@adcIdSin,	-- @adcIdSin	    Decimal (7),
			@asNumTel,	-- @asNumTel        varchar(10),
			@asCodeAcces,	-- @asMdp           varchar(6),
			9,		-- @adcIdCodeTrc    Decimal(7),
			'ERREUR', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			123,		-- @aiIdMess        integer
			null		-- @asMajPar	 VarChar ( 4 )
		Return -1
	End 

Update sysadm.w_commande 
Set    cod_etat = 'ANN',
	   comment_frn = @sMess,
	   maj_le = GetDate(),
	   maj_par = 'WEB'
Where  id_sin = @adcIdSin
And    id_seq = @iIdSeq

Update sysadm.commande 
Set    cod_etat = 'ANN',
	   comment_frn = @sMess,
	   maj_le = GetDate(),
	   maj_par = 'WEB'
Where  id_sin = @adcIdSin
And    id_seq = @iIdSeq


IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01
						-1,		/* Le Client est trouvé automatiquement par la proc */
						3,		/* Famille : Autre */
						78,		/* Type de Contact : Information */ -- [PM287-2]
						'I',		/* Canal : Internet */
						@adcIdSin,	/* N° de Sinistre */
						2,		/* Application : Simpa2 */
						@sMess,	/* Le message du Contact */
						'WEB',		/* Trig. Virtuel PM95*/
						300, 		/* Etat : Contact Clos */
						@iIdCt OUTPUT	/* le N° de Ct crée, non utilisé */
						
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	
						-1,		/* Le Client est trouvé automatiquement par la proc */
						3,		/* Famille : Autre */
						78,		/* Type de Contact : Information */ -- [PM287-2]
						'I',		/* Canal : Internet */
						@adcIdSin,	/* N° de Sinistre */
						2,		/* Application : Simpa2 */
						@sMess,	/* Le message du Contact */
						'WEB',		/* Trig. Virtuel PM95*/
						300, 		/* Etat : Contact Clos */
						@iIdCt OUTPUT	/* le N° de Ct crée, non utilisé */
END

Set @sMess = 'Dossier à reprendre pour réglement à effectuer(' + @sMess + ').'

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @adcIdSin, 2, @sMess, 'WEB', @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
END
ELSE
BEGIN
	EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @adcIdSin, 2, @sMess, 'WEB', @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
END

Select @asRetourMess = sysadm.FN_MESS ( 124, @asLangage )

-- [TRACE_15]
EXEC sysadm.PS_I01_TRACE_CMDE_V01
	@asIdSession,	-- @asIdSession     varchar(30),
	@asBrowser,	-- @asBrowser       varchar(50),
	@adcIdSin,	-- @adcIdSin	    Decimal (7),
	@asNumTel,	-- @asNumTel        varchar(10),
	@asCodeAcces,	-- @asMdp           varchar(6),
	29,		-- @adcIdCodeTrc    Decimal(7),
	'TRACE', 	-- @asGravite       varchar(10),
	'WEB',		-- @asIdAppli       varchar(5),
	'VALIDATION',	-- @asEtape         varchar(20),
	124,		-- @aiIdMess        integer
	null		-- @asMajPar	 VarChar ( 4 )

Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @adcIdSin, 'WEB'

Return 1

Go
