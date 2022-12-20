-------------------------------------------------------------------
--
-- Fichier              :       STATS.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion des statistiques
--
-- Procédures           :       DW_S01_GAR_SIN_STAT
--                              DW_S02_GAR_SIN_STAT
--				DW_S03_DETAIL_STAT
--                              DW_I01_STAT_SIN
--                              PS_S01_STAT_SIN_STAT
--                              PS_S02_STAT_SIN_STAT
--                              DW_S01_STAT_LSTCPTA
--                              PS_S01_VOLCANE
--                              PS_S01_DCCTA	   Modif CAG 18/11/2003 : Changement de cpte AIG (cf DMDI 9793)
--							Exclusion des produits concernés qui sont affectés sur nvelle stat ci-dessous
--                              PS_S11_DCCTA	   cf stat ci-dessus
--				PS_S01_LSTREG
--				PS_S011_LSTREG	   Variante de PS_S01_LSTREG pour CGU COURTAGE (DCMP10374)
--				PS_S012_LSTREG	   Variante pour 4 produits DCMP 20078 P.FERMEY : Ajout du n° de Compte du client
--				PS_S013_LSTREG	   Variante de PS_S11_LSTREG pour GAN (DCMP050537)
--				PS_S014_LSTREG	   Variante de PS_S01_LSTREG pour DAS (VDoc4141)
--				PS_S02_LSTREG
-- 				PS_S03_LSTREG      Liste d‚taill‚e des rŠglements uniquement pour les adh‚sions par carte
--						   affichant le num‚ro de carte et le nom du sinistr‚.
--				PS_S04_LSTREG_TEL  Liste des réglés pour la téléphonie.
--				PS_S05_LSTREG_TEL  Liste des réglés pour la téléphonie seulement ceux qui ont une dte de livr.
--				PS_S07_LSTRI	   Liste des RI ultérieurs au '26/11/2003' dont le RN est antérieur au '26/11/2003'
--						   pour chgt de compte AIG sur produits cités dans DMDI 9793
--				DW_S01_DOSOUV
--				DW_S01_DOSENCI
--				DW_S01_STATSIN_UF_PREPAR
--				DW_S02_STATSIN_UF_PREPAR
--				DW_S01_FRAIS_EXPERTISE
--				DW_S01_COMPTA
--				DW_S02_COMPTA
--          DW_S01_ST_ORANGE1ER_REFUS_SIMPA FS le 02/04/2010 : Extraction des refus oraux orange 1er
--				DW_S01_STAT_FRAIS_PRESTA_ASS
--				DW_S01_STAT_FRAIS_PRESTA
--				DW_S01_STAT_CONFORAMA
--				PS_S013_LSTREG_GAN
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_GAR_SIN_STAT
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table GAR_SIN
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_GAR_SIN_STAT' AND type = 'P' )
        DROP procedure sysadm.DW_S01_GAR_SIN_STAT
GO

CREATE procedure sysadm.DW_S01_GAR_SIN_STAT
        @dtDteDeb       DateTime        ,
        @dtDteFin       DateTime
AS
 SELECT gar_sin.id_sin,
        gar_sin.id_gti,
        gar_sin.cod_etat,
        gar_sin.dte_ouv,
        gar_sin.mt_prov
 FROM   sysadm.gar_sin
 WHERE  gar_sin.valide_le >= @dtDteDeb          AND
        gar_sin.valide_le <= @dtDteFin
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_GAR_SIN_STAT
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table GAR_SIN
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_GAR_SIN_STAT' AND type = 'P' )
        DROP procedure sysadm.DW_S02_GAR_SIN_STAT
GO
                                
CREATE procedure sysadm.DW_S02_GAR_SIN_STAT
        @dtDteDeb       DateTime
AS
 SELECT gar_sin.id_sin,
        gar_sin.id_gti,
        gar_sin.cod_etat,
        gar_sin.dte_ouv,
        gar_sin.mt_prov
 FROM   sysadm.gar_sin
 WHERE  gar_sin.valide_le < @dtDteDeb          AND
        (
        gar_sin.cod_etat = 100                  OR
        gar_sin.cod_etat = 550
        )
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S03_DETAIL_STAT
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table DETAIL
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_DETAIL_STAT' AND type = 'P' )
        DROP procedure sysadm.DW_S03_DETAIL_STAT
GO
                                
CREATE procedure sysadm.DW_S03_DETAIL_STAT
      @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS
 SELECT detail.id_sin,
        detail.id_gti,
        detail.id_evt,
        id_rgpt = 
        CASE
        WHEN    detail.id_evt >= 700 AND detail.id_evt <= 719 THEN 700
        WHEN    detail.id_evt >= 720 AND detail.id_evt <= 739 THEN 720
        ELSE    740
        END,
        detail.cod_etat,
        detail.maj_le,
        detail.valide_le
 FROM   sysadm.detail
 WHERE  detail.id_sin   = @dcIdSin              AND
        detail.id_gti   = 7

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_STAT_SIN
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion sur table STAT_SIN
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdPeriode    Decimal (  7,0 )        (Val)
--                      :       @dcIdGti        Decimal (  7,0 )        (Val)
--                      :       @dcIdRgpt       Decimal (  7,0 )        (Val)
--                      :       @dcCodEtat      Decimal (  7,0 )        (Val)
--                      :       @dcCptEtat      Decimal (  4,0 )        (Val)
--                      :       @dcCptOuv       Decimal (  4,0 )        (Val)
--                      :       @dcCptReg       Decimal (  4,0 )        (Val)
--                      :       @dcMtReg        Decimal ( 11,2)         (Val)
--                      :       @dcMtProv       Decimal ( 11,2)         (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @dtMajLe        DateTime                (Val)
--                      :       @sMajPar        Varchar (  4 )          (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      06/10/2014   [PM266]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_STAT_SIN' AND type = 'P' )
        DROP procedure sysadm.DW_I01_STAT_SIN
GO
CREATE procedure sysadm.DW_I01_STAT_SIN
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdPeriode    Decimal (  7,0 ),
        @dcIdGti        Decimal (  7,0 ),
        @dcIdRgpt       Decimal (  7,0 ),
        @dcCodEtat      Decimal (  7,0 ),
        @dcCptEtat      Decimal (  4,0 ),
        @dcCptOuv       Decimal (  4,0 ),
        @dcCptReg       Decimal (  4,0 ),
        @dcMtReg        Decimal ( 11,2 ),  
        @dcMtProv       Decimal ( 11,2 ),  
        @dtCreeLe       DateTime        , 
        @dtMajLe        DateTime        , 
        @sMajPar        Varchar (  4 )
AS

-- [PM266]
If sysadm.FN_CLE_NUMERIQUE ( 'PM266') > 0 
 Begin
	If Exists (
			Select 1
			From	sysadm.sinistre s,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.exclu_ass ex
			Where   s.id_sin = @dcIdSin
			And		ga.id_prod = s.id_prod
			And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = s.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( @dcIdGti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie
			)
			Begin
				Return  -- Assureur exclu 
			End 
	
 End 


 INSERT INTO    sysadm.stat_sin
        (       stat_sin.id_sin,
                stat_sin.id_periode,
                stat_sin.id_gti,
                stat_sin.id_rgpt,
                stat_sin.cod_etat,
                stat_sin.cpt_etat,
                stat_sin.cpt_ouv,
                stat_sin.cpt_reg,
                stat_sin.mt_reg,
                stat_sin.mt_prov,
                stat_sin.cree_le,
                stat_sin.maj_le,
                stat_sin.maj_par        )
 VALUES (       @dcIdSin,
                @dcIdPeriode,
                @dcIdGti,
                @dcIdRgpt,
                @dcCodEtat,
                @dcCptEtat,
                @dcCptOuv,
                @dcCptReg,
                @dcMtReg,
                @dcMtProv,
                @dtCreeLe,
                @dtMajLe,
                @sMajPar                )       
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_STAT_SIN_STAT
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table STAT_SIN 
-- Références           :       
--
-- Arguments            :       @dcIdPeriode    Decimal (  7,0 )        (Val)
--                              @dcNbrLig       Decimal (  7,0 )        (R‚f)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_STAT_SIN_STAT' AND type = 'P' )
        DROP procedure sysadm.PS_S01_STAT_SIN_STAT
GO

CREATE procedure sysadm.PS_S01_STAT_SIN_STAT
        @dcIdPeriode    Decimal (  7,0 ),
        @dcNbrLig       Decimal (  7,0 ) OUTPUT
AS

 SELECT @dcNbrLig = count( stat_sin.id_sin )
 FROM   sysadm.stat_sin
 WHERE  stat_sin.id_periode     = @dcIdPeriode

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S02_STAT_SIN_STAT
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table STAT_SIN
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdRgpt       Decimal (  7,0 )        (Val)
--                              @dcCodEtat1     Decimal (  7,0 )        (Val)
--                              @dcCodEtat2     Decimal (  7,0 )        (Val)
--                              @iChoixTrt      Integer                 (Val)
--                              @dcPeriode      Decimal (  7,0 )        (Val)
--                              @dcNbrLig       Decimal (  7,0 )        (R‚f)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_STAT_SIN_STAT' AND type = 'P' )
        DROP procedure sysadm.PS_S02_STAT_SIN_STAT
GO


CREATE procedure sysadm.PS_S02_STAT_SIN_STAT
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdRgpt       Decimal (  7,0 ),
        @dcCodEtat1     Decimal (  7,0 ),
        @dcCodEtat2     Decimal (  7,0 ),
        @iChoixTrt      Integer         ,
        @dcPeriode      Decimal (  7,0 ),
        @dcNbrLig       Decimal (  7,0 ) OUTPUT
AS

 IF     @iChoixTrt = 1
        /* ... S‚lect avec le COD_ETAT (Avec EGALITE) ... */
        Begin

                SELECT @dcNbrLig = count ( stat_sin.id_sin )
                FROM   sysadm.stat_sin
                WHERE  stat_sin.id_sin          = @dcIdSin              AND
                       stat_sin.id_rgpt         = @dcIdRgpt             AND
                       ( 
                       stat_sin.cod_etat        = @dcCodEtat1             OR
                       stat_sin.cod_etat        = @dcCodEtat2
                       )
        End

 IF     @iChoixTrt = 2
        /* ... S‚lect sans le COD_ETAT ... */
        Begin
                SELECT  @dcNbrLig = count ( stat_sin.id_sin )
                FROM    sysadm.stat_sin
                WHERE   stat_sin.id_sin         = @dcIdSin              AND
                        stat_sin.id_rgpt        = @dcIdRgpt
        End

 IF     @iChoixTrt = 3
        /* ... S‚lect avec le COD_ETAT (Avec SUPERIEUR OU EGAL) ... */
        Begin

                SELECT  @dcNbrLig = count ( stat_sin.id_sin )
                FROM    sysadm.stat_sin
                WHERE   stat_sin.id_sin         = @dcIdSin              AND
                        stat_sin.id_rgpt        = @dcIdRgpt             AND
                        stat_sin.cod_etat      >= @dcCodEtat1
        End

 IF     @iChoixTrt = 4
        /* ... S‚lect pour le cas particuliers des UF sans d‚tails ... */
        Begin
                SELECT  @dcNbrLig = count ( stat_sin.id_sin )
                FROM    sysadm.stat_sin
                WHERE   stat_sin.id_sin         = @dcIdSin              AND
                        stat_sin.id_gti         = 7                     AND
                        stat_sin.id_rgpt        = 7                     AND
                        stat_sin.cod_etat       = @dcCodEtat1           AND
                        stat_sin.id_periode     = @dcPeriode
        End

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_STAT_LSTCPTA
-- Auteur               :       DBI
-- Date                 :       08/12/1998
-- Libellé              :        
-- Commentaires         :       Liste des rŠglements pour la compta
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- Modification DBI le 26/04/1999
-- Int‚gration des r‚guls et RI dans Volcanes
-- [BUG20080728].COD_MODE_REG  JFF
-- JFF      06/10/2014   [PM266]
-- JFF		08/04/2021   reglement.lib_reg -- Ajout 
-- JFF      14/09/2021   [RS905] Ajout lib_produit
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_STAT_LSTCPTA' AND type = 'P' )
        DROP procedure sysadm.DW_S01_STAT_LSTCPTA
GO

CREATE procedure sysadm.DW_S01_STAT_LSTCPTA
        @dtDteDeb       DateTime        ,
        @dtDteFin       DateTime
AS

--
-- Il faut faire un union car pour les produits avec cod_adh = '3', le lib_grp est obtenu
-- directement … partir de la table groupe et pour les produits avec les autres cod_adh, il
-- faut passer par la table etablissement
--

 SELECT reglement.dte_reg, 
        sinistre.id_prod, 
        sinistre.id_ets, 
        produit.rib_bq + ' ' + produit.rib_gui + ' ' + produit.rib_cpt + ' ' + produit.rib_cle, 
        departement.lib_dept, 
        personne.nom,
        personne.prenom,
        groupe.lib_grp,
        sinistre.id_sin,
        reglement.mt_tot_reg, 
        reglement.id_reg, 
        reglement.cod_mode_reg,
        reglement.cod_inter, 
        reglement.cod_mot_reg,
		reglement.lib_reg, -- Ajout JFF 08/04/2021
		produit.lib_long -- [RS905]
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit, 
        sysadm.departement,
        sysadm.groupe,
        sysadm.personne 
 WHERE  ( sinistre.id_sin        = reglement.id_sin        ) and 
        ( sinistre.id_prod       = produit.id_prod         ) and 
        ( departement.id_dept    = produit.id_dept         ) and 
        ( sinistre.id_ets        = groupe.id_grp           ) and
        ( sinistre.id_ordre      = personne.id_ordre       ) and
        ( produit.cod_adh        = '3'                    ) and
        ( reglement.cod_mot_reg in ( 'RN', 'RE', 'RI', 'RP', 'RM' ) ) and 
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and
        ( reglement.dte_reg      between @dtDteDeb and @dtDteFin ) 
          -- [PM266]
          AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
  			    Or
				Not Exists ( 
					Select 1
					From	sysadm.exclu_ass ex,
							sysadm.garantie ga,
							sysadm.police po,
							sysadm.reg_gti rg
					Where	rg.id_sin = reglement.id_sin
					And     rg.id_reg = reglement.id_reg
					And		ga.id_prod = sinistre.id_prod
					And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
													IsNull ( 
														( Select max (id_rev )
														  From   revision r
														  Where  r.id_prod = sinistre.id_prod ) , 0 ))
					And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
													(
													  Select top 1 id_gti  
													  From   sysadm.garantie ga2
													  Where  ga2.id_prod = ga.id_prod
													  And    ga2.id_rev = ga.id_rev 
													)
												)
					And		po.id_police = ga.id_police
					and		ex.id_cie = po.id_cie			
				)
			  ) 
        
 UNION ALL
 SELECT reglement.dte_reg, 
        sinistre.id_prod, 
        sinistre.id_ets, 
        produit.rib_bq + ' ' + produit.rib_gui + ' ' + produit.rib_cpt + ' ' + produit.rib_cle, 
        departement.lib_dept, 
        personne.nom,
        personne.prenom,
        groupe.lib_grp,
        sinistre.id_sin,
        reglement.mt_tot_reg, 
        reglement.id_reg, 
        reglement.cod_mode_reg,
        reglement.cod_inter, 
        reglement.cod_mot_reg,
		reglement.lib_reg, -- Ajout JFF 08/04/2021
		produit.lib_long -- [RS905]
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit, 
        sysadm.departement,
        sysadm.groupe,
        sysadm.personne,
        sysadm.etablissement 
 WHERE  ( sinistre.id_sin        = reglement.id_sin        ) and 
        ( sinistre.id_prod       = produit.id_prod         ) and 
        ( departement.id_dept    = produit.id_dept         ) and 
        ( sinistre.id_ordre      = personne.id_ordre       ) and
	( etablissement.id_prod  = sinistre.id_prod        ) and
	( etablissement.id_ets   = sinistre.id_ets         ) and
	( etablissement.id_grp   = groupe.id_grp           ) and
	( etablissement.id_rev   = -1			   ) and
        ( produit.cod_adh        <> '3'                    ) and
        ( reglement.cod_mot_reg in ( 'RN', 'RE', 'RI', 'RP', 'RM' ) ) and 
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and
        ( reglement.dte_reg      between @dtDteDeb and @dtDteFin        ) 
          -- [PM266]
          AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
  			    Or
				Not Exists ( 
					Select 1
					From	sysadm.exclu_ass ex,
							sysadm.garantie ga,
							sysadm.police po,
							sysadm.reg_gti rg
					Where	rg.id_sin = reglement.id_sin
					And     rg.id_reg = reglement.id_reg
					And		ga.id_prod = sinistre.id_prod
					And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
													IsNull ( 
														( Select max (id_rev )
														  From   revision r
														  Where  r.id_prod = sinistre.id_prod ) , 0 ))
					And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
													(
													  Select top 1 id_gti  
													  From   sysadm.garantie ga2
													  Where  ga2.id_prod = ga.id_prod
													  And    ga2.id_rev = ga.id_rev 
													)
												)
					And		po.id_police = ga.id_police
					and		ex.id_cie = po.id_cie			
				)
			  ) 
       
UNION ALL
 SELECT reglement.dte_reg, 
        sinistre.id_prod, 
        sinistre.id_ets, 
        produit.rib_bq + ' ' + produit.rib_gui + ' ' + produit.rib_cpt + ' ' + produit.rib_cle, 
        departement.lib_dept, 
        personne.nom,
        personne.prenom,
        groupe.lib_grp,
        sinistre.id_sin,
        reglement.mt_tot_reg * -1, 
        reglement.id_reg, 
        reglement.cod_mode_reg,
        reglement.cod_inter, 
        reglement.cod_mot_reg, 
		reglement.lib_reg, -- Ajout JFF 08/04/2021
		produit.lib_long -- [RS905]
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit, 
        sysadm.departement,
        sysadm.groupe,
        sysadm.personne 
 WHERE  ( sinistre.id_sin        = reglement.id_sin        ) and 
        ( sinistre.id_prod       = produit.id_prod         ) and 
        ( departement.id_dept    = produit.id_dept         ) and 
        ( sinistre.id_ets        = groupe.id_grp           ) and
        ( sinistre.id_ordre      = personne.id_ordre       ) and
        ( produit.cod_adh        = '3'                     ) and
        ( reglement.cod_mot_reg  = 'RI'  		   ) and 
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and
        ( reglement.dte_reg      between @dtDteDeb and @dtDteFin ) 
          -- [PM266]
          AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
  			    Or
				Not Exists ( 
					Select 1
					From	sysadm.exclu_ass ex,
							sysadm.garantie ga,
							sysadm.police po,
							sysadm.reg_gti rg
					Where	rg.id_sin = reglement.id_sin
					And     rg.id_reg = reglement.id_reg
					And		ga.id_prod = sinistre.id_prod
					And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
													IsNull ( 
														( Select max (id_rev )
														  From   revision r
														  Where  r.id_prod = sinistre.id_prod ) , 0 ))
					And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
													(
													  Select top 1 id_gti  
													  From   sysadm.garantie ga2
													  Where  ga2.id_prod = ga.id_prod
													  And    ga2.id_rev = ga.id_rev 
													)
												)
					And		po.id_police = ga.id_police
					and		ex.id_cie = po.id_cie			
				)
			  ) 
        
 UNION ALL
 SELECT reglement.dte_reg, 
        sinistre.id_prod, 
        sinistre.id_ets, 
        produit.rib_bq + ' ' + produit.rib_gui + ' ' + produit.rib_cpt + ' ' + produit.rib_cle, 
        departement.lib_dept, 
        personne.nom,
        personne.prenom,
        groupe.lib_grp,
        sinistre.id_sin,
        reglement.mt_tot_reg * -1, 
        reglement.id_reg, 
        reglement.cod_mode_reg,
        reglement.cod_inter, 
        reglement.cod_mot_reg,
		reglement.lib_reg, -- Ajout JFF 08/04/2021
		produit.lib_long -- [RS905]
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit, 
 sysadm.departement,
        sysadm.groupe,
        sysadm.personne,
        sysadm.etablissement 
 WHERE  ( sinistre.id_sin        = reglement.id_sin        ) and 
        ( sinistre.id_prod       = produit.id_prod         ) and 
        ( departement.id_dept    = produit.id_dept         ) and 
        ( sinistre.id_ordre      = personne.id_ordre       ) and
	( etablissement.id_prod  = sinistre.id_prod        ) and
	( etablissement.id_ets   = sinistre.id_ets         ) and
	( etablissement.id_grp   = groupe.id_grp           ) and
	( etablissement.id_rev   = -1			   ) and
        ( produit.cod_adh        <> '3'                    ) and
        ( reglement.cod_mot_reg  = 'RI'  		   ) and 
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and
        ( reglement.dte_reg      between @dtDteDeb and @dtDteFin        ) 
          -- [PM266]
          AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
  			    Or
				Not Exists ( 
					Select 1
					From	sysadm.exclu_ass ex,
							sysadm.garantie ga,
							sysadm.police po,
							sysadm.reg_gti rg
					Where	rg.id_sin = reglement.id_sin
					And     rg.id_reg = reglement.id_reg
					And		ga.id_prod = sinistre.id_prod
					And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
													IsNull ( 
														( Select max (id_rev )
														  From   revision r
														  Where  r.id_prod = sinistre.id_prod ) , 0 ))
					And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
													(
													  Select top 1 id_gti  
													  From   sysadm.garantie ga2
													  Where  ga2.id_prod = ga.id_prod
													  And    ga2.id_rev = ga.id_rev 
													)
												)
					And		po.id_police = ga.id_police
					and		ex.id_cie = po.id_cie			
				)
			  ) 
GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_STAT_LSTCPTA Version Garantie
-- Auteur               :       DBI (JFF) version Gti
-- Date                 :       08/12/1998 (14/09/2021)
-- Libellé              :        
-- Commentaires         :       Liste des rŠglements pour la compta
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- Modification DBI le 26/04/1999
-- Int‚gration des r‚guls et RI dans Volcanes
-- [BUG20080728].COD_MODE_REG  JFF
-- JFF      06/10/2014   [PM266]
-- JFF		08/04/2021   reglement.lib_reg -- Ajout 
-- JFF      14/09/2021   [RS905] Ajout lib_produit
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_STAT_LSTCPTA_GTI' AND type = 'P' )
        DROP procedure sysadm.DW_S01_STAT_LSTCPTA_GTI
GO

CREATE procedure sysadm.DW_S01_STAT_LSTCPTA_GTI
        @dtDteDeb       DateTime        ,
        @dtDteFin       DateTime
AS

--
-- Il faut faire un union car pour les produits avec cod_adh = '3', le lib_grp est obtenu
-- directement … partir de la table groupe et pour les produits avec les autres cod_adh, il
-- faut passer par la table etablissement
--

 SELECT reglement.dte_reg, 
        sinistre.id_prod, 
        sinistre.id_ets, 
        produit.rib_bq + ' ' + produit.rib_gui + ' ' + produit.rib_cpt + ' ' + produit.rib_cle, 
        departement.lib_dept, 
        personne.nom,
        personne.prenom,
        groupe.lib_grp,
        sinistre.id_sin,
        reg_gti.mt_reg,  -- [RS905]
        reglement.id_reg, 
        reglement.cod_mode_reg,
        reglement.cod_inter, 
        reglement.cod_mot_reg,
		reglement.lib_reg, -- Ajout JFF 08/04/2021
		produit.lib_long, -- [RS905]
		IsNull ( sysadm.FN_CODE_NUM ( reg_gti.id_gti, '-GS'), 'Frais divers') lib_gti -- [RS905]

 FROM   sysadm.reglement,
		sysadm.reg_gti, -- [RS905]
        sysadm.sinistre, 
        sysadm.produit, 
        sysadm.departement,
        sysadm.groupe,
        sysadm.personne 
 WHERE  ( sinistre.id_sin        = reglement.id_sin        ) and 
        ( sinistre.id_prod       = produit.id_prod         ) and 
        ( departement.id_dept    = produit.id_dept         ) and 
        ( sinistre.id_ets        = groupe.id_grp           ) and
        ( sinistre.id_ordre      = personne.id_ordre       ) and
        ( produit.cod_adh        = '3'                    ) and
        ( reglement.cod_mot_reg in ( 'RN', 'RE', 'RI', 'RP', 'RM' ) ) and 
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and
        ( reglement.dte_reg      between @dtDteDeb and @dtDteFin ) and
		( reg_gti.id_sin = reglement.id_sin ) And  -- [RS905]
		( reg_gti.id_reg = reglement.id_reg ) -- [RS905]
          -- [PM266]
          AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
  			    Or
				Not Exists ( 
					Select 1
					From	sysadm.exclu_ass ex,
							sysadm.garantie ga,
							sysadm.police po,
							sysadm.reg_gti rg
					Where	rg.id_sin = reglement.id_sin
					And     rg.id_reg = reglement.id_reg
					And		ga.id_prod = sinistre.id_prod
					And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
													IsNull ( 
														( Select max (id_rev )
														  From   revision r
														  Where  r.id_prod = sinistre.id_prod ) , 0 ))
					And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
													(
													  Select top 1 id_gti  
													  From   sysadm.garantie ga2
													  Where  ga2.id_prod = ga.id_prod
													  And    ga2.id_rev = ga.id_rev 
													)
												)
					And		po.id_police = ga.id_police
					and		ex.id_cie = po.id_cie			
				)
			  ) 
        
 UNION ALL
 SELECT reglement.dte_reg, 
        sinistre.id_prod, 
        sinistre.id_ets, 
        produit.rib_bq + ' ' + produit.rib_gui + ' ' + produit.rib_cpt + ' ' + produit.rib_cle, 
        departement.lib_dept, 
        personne.nom,
        personne.prenom,
        groupe.lib_grp,
        sinistre.id_sin,
        reg_gti.mt_reg,  -- [RS905]
        reglement.id_reg, 
        reglement.cod_mode_reg,
        reglement.cod_inter, 
        reglement.cod_mot_reg,
		reglement.lib_reg, -- Ajout JFF 08/04/2021
		produit.lib_long, -- [RS905]
		IsNull ( sysadm.FN_CODE_NUM ( reg_gti.id_gti, '-GS'), 'Frais divers') -- [RS905]

 FROM   sysadm.reglement, 
		sysadm.reg_gti, -- [RS905]
        sysadm.sinistre, 
        sysadm.produit, 
        sysadm.departement,
        sysadm.groupe,
        sysadm.personne,
        sysadm.etablissement 
 WHERE  ( sinistre.id_sin        = reglement.id_sin        ) and 
        ( sinistre.id_prod       = produit.id_prod         ) and 
        ( departement.id_dept    = produit.id_dept         ) and 
        ( sinistre.id_ordre      = personne.id_ordre       ) and
	( etablissement.id_prod  = sinistre.id_prod        ) and
	( etablissement.id_ets   = sinistre.id_ets         ) and
	( etablissement.id_grp   = groupe.id_grp           ) and
	( etablissement.id_rev   = -1			   ) and
        ( produit.cod_adh        <> '3'                    ) and
        ( reglement.cod_mot_reg in ( 'RN', 'RE', 'RI', 'RP', 'RM' ) ) and 
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and
        ( reglement.dte_reg      between @dtDteDeb and @dtDteFin        ) and
		( reg_gti.id_sin = reglement.id_sin ) And  -- [RS905]
		( reg_gti.id_reg = reglement.id_reg ) -- [RS905]
          -- [PM266]
          AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
  			    Or
				Not Exists ( 
					Select 1
					From	sysadm.exclu_ass ex,
							sysadm.garantie ga,
							sysadm.police po,
							sysadm.reg_gti rg
					Where	rg.id_sin = reglement.id_sin
					And     rg.id_reg = reglement.id_reg
					And		ga.id_prod = sinistre.id_prod
					And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
													IsNull ( 
														( Select max (id_rev )
														  From   revision r
														  Where  r.id_prod = sinistre.id_prod ) , 0 ))
					And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
													(
													  Select top 1 id_gti  
													  From   sysadm.garantie ga2
													  Where  ga2.id_prod = ga.id_prod
													  And    ga2.id_rev = ga.id_rev 
													)
												)
					And		po.id_police = ga.id_police
					and		ex.id_cie = po.id_cie			
				)
			  ) 
       
UNION ALL
 SELECT reglement.dte_reg, 
        sinistre.id_prod, 
        sinistre.id_ets, 
        produit.rib_bq + ' ' + produit.rib_gui + ' ' + produit.rib_cpt + ' ' + produit.rib_cle, 
        departement.lib_dept, 
        personne.nom,
        personne.prenom,
        groupe.lib_grp,
        sinistre.id_sin,
        reg_gti.mt_reg * (-1),  -- [RS905]
        reglement.id_reg, 
        reglement.cod_mode_reg,
        reglement.cod_inter, 
        reglement.cod_mot_reg, 
		reglement.lib_reg, -- Ajout JFF 08/04/2021
		produit.lib_long, -- [RS905]
		IsNull ( sysadm.FN_CODE_NUM ( reg_gti.id_gti, '-GS'), 'Frais divers') -- [RS905]

 FROM   sysadm.reglement, 
		sysadm.reg_gti, -- [RS905]
        sysadm.sinistre, 
        sysadm.produit, 
        sysadm.departement,
        sysadm.groupe,
        sysadm.personne 
 WHERE  ( sinistre.id_sin        = reglement.id_sin        ) and 
        ( sinistre.id_prod       = produit.id_prod         ) and 
        ( departement.id_dept    = produit.id_dept         ) and 
        ( sinistre.id_ets        = groupe.id_grp           ) and
        ( sinistre.id_ordre      = personne.id_ordre       ) and
        ( produit.cod_adh        = '3'                     ) and
        ( reglement.cod_mot_reg  = 'RI'  		   ) and 
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and
        ( reglement.dte_reg      between @dtDteDeb and @dtDteFin ) and
		( reg_gti.id_sin = reglement.id_sin ) And  -- [RS905]
		( reg_gti.id_reg = reglement.id_reg ) -- [RS905]

          -- [PM266]
          AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
  			    Or
				Not Exists ( 
					Select 1
					From	sysadm.exclu_ass ex,
							sysadm.garantie ga,
							sysadm.police po,
							sysadm.reg_gti rg
					Where	rg.id_sin = reglement.id_sin
					And     rg.id_reg = reglement.id_reg
					And		ga.id_prod = sinistre.id_prod
					And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
													IsNull ( 
														( Select max (id_rev )
														  From   revision r
														  Where  r.id_prod = sinistre.id_prod ) , 0 ))
					And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
													(
													  Select top 1 id_gti  
													  From   sysadm.garantie ga2
													  Where  ga2.id_prod = ga.id_prod
													  And    ga2.id_rev = ga.id_rev 
													)
												)
					And		po.id_police = ga.id_police
					and		ex.id_cie = po.id_cie			
				)
			  ) 
        
 UNION ALL
 SELECT reglement.dte_reg, 
        sinistre.id_prod, 
        sinistre.id_ets, 
        produit.rib_bq + ' ' + produit.rib_gui + ' ' + produit.rib_cpt + ' ' + produit.rib_cle, 
        departement.lib_dept, 
        personne.nom,
        personne.prenom,
        groupe.lib_grp,
        sinistre.id_sin,
        reg_gti.mt_reg * (-1) ,  -- [RS905]
        reglement.id_reg, 
        reglement.cod_mode_reg,
        reglement.cod_inter, 
        reglement.cod_mot_reg,
		reglement.lib_reg, -- Ajout JFF 08/04/2021
		produit.lib_long, -- [RS905]
		IsNull ( sysadm.FN_CODE_NUM ( reg_gti.id_gti, '-GS'), 'Frais divers') -- [RS905]

 FROM   sysadm.reglement, 
		sysadm.reg_gti, -- [RS905]
        sysadm.sinistre, 
        sysadm.produit, 
 sysadm.departement,
        sysadm.groupe,
        sysadm.personne,
        sysadm.etablissement 
 WHERE  ( sinistre.id_sin        = reglement.id_sin        ) and 
        ( sinistre.id_prod       = produit.id_prod         ) and 
        ( departement.id_dept    = produit.id_dept         ) and 
        ( sinistre.id_ordre      = personne.id_ordre       ) and
	( etablissement.id_prod  = sinistre.id_prod        ) and
	( etablissement.id_ets   = sinistre.id_ets         ) and
	( etablissement.id_grp   = groupe.id_grp           ) and
	( etablissement.id_rev   = -1			   ) and
        ( produit.cod_adh        <> '3'                    ) and
        ( reglement.cod_mot_reg  = 'RI'  		   ) and 
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and
        ( reglement.dte_reg      between @dtDteDeb and @dtDteFin        ) and
		( reg_gti.id_sin = reglement.id_sin ) And  -- [RS905]
		( reg_gti.id_reg = reglement.id_reg )  -- [RS905]
          -- [PM266]
          AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
  			    Or
				Not Exists ( 
					Select 1
					From	sysadm.exclu_ass ex,
							sysadm.garantie ga,
							sysadm.police po,
							sysadm.reg_gti rg
					Where	rg.id_sin = reglement.id_sin
					And     rg.id_reg = reglement.id_reg
					And		ga.id_prod = sinistre.id_prod
					And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
													IsNull ( 
														( Select max (id_rev )
														  From   revision r
														  Where  r.id_prod = sinistre.id_prod ) , 0 ))
					And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
													(
													  Select top 1 id_gti  
													  From   sysadm.garantie ga2
													  Where  ga2.id_prod = ga.id_prod
													  And    ga2.id_rev = ga.id_rev 
													)
												)
					And		po.id_police = ga.id_police
					and		ex.id_cie = po.id_cie			
				)
			  ) 
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_VOLCANE
-- Auteur               :       DBI
-- Date                 :       08/12/1998
-- Libellé              :        
-- Commentaires         :       Liste des rŠglements volcane
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- Modif. DBI le 26/03/1999
-- Suite int‚gration des r‚guls, gestion des RI avec ID_REG_BASE
-- Modif. DBI le 20/06/2000
-- Gestion cas particuliers pour id_ets des produits du GIE CB
-- Modif JFF le 30/03/06, je modifie la façon d'extraire le produit adhésion
-------------------------------------------------------------------
-- #1  JFF  22/05/2008  [3SUISSE].COD_MODE_REG 
--     JFF  24/05/2013  [PC512-5_ORANGE_V2_BIS]
--     JFF  07/05/2013  [PC938_ORANGE_V3_V10]
--     JFF  06/10/2014   [PM266]
--     JFF  12/05/2020   [PI085]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_VOLCANE' AND type = 'P' )
        DROP procedure sysadm.PS_S01_VOLCANE
GO

/*-------------------------------------------------------------------
[DATABASE] SIMPA2_PRO
[DESCRIPTION] 
[MAJ PAR] DATAFLY - AFX
[DATEMAJ] 15/10/2009

	[VARIABLES]
    @dtDteDeb DATETIME,
    @dtDteFin DATETIME
-------------------------------------------------------------------*/
CREATE PROCEDURE [sysadm].[PS_S01_VOLCANE]
    @dtDteDeb DATETIME,
    @dtDteFin DATETIME,
    @asCas	  VarChar ( 50 ) -- EXCLU_ASSUREUR (PM266 Activé coté PB) ou  TOUT_ASSUREUR comme avant ou INCLU_ASSUREUR (PM266 Activé Quentin) 
AS 

Declare @iFN_CLE_NUMERIQUE_PI085 Integer

Set @iFN_CLE_NUMERIQUE_PI085  = sysadm.FN_CLE_NUMERIQUE ( 'PI085')

    SELECT DISTINCT
            sinistre.id_sin,
            reglement.id_i,
            reglement.id_reg,
            CASE reglement.cod_mot_reg
              WHEN 'RN' THEN '1'
              WHEN 'RM' THEN '2'
              WHEN 'RP' THEN '3'
              ELSE '0'
            END,
			 Case --  [PI085]
				When @iFN_CLE_NUMERIQUE_PI085 > 0 Then 
					Case  
				 		When produit.cod_prod_dms is null Then Substring ( Right ( '00000' + Convert ( Varchar (5), sinistre.id_prod), 5), 1 , 5 ) --  [PI085]
						Else Right ( '00000' + Convert ( Varchar (5), produit.cod_prod_dms), 5 ) --  [PI085]
					End 
				Else 
					Case 
						When produit.cod_prod_dms is null Then Substring ( Right ( '0000' + Convert ( Varchar (5), sinistre.id_prod), 5), 1 , 3 )
						Else Right ( '0000' + Convert ( Varchar (5), produit.cod_prod_dms), 3)
					End 
			 End, --  [PI085]
/*
            CASE WHEN produit.cod_prod_dms IS NULL
                 THEN SUBSTRING(RIGHT('0000'
                                      + CONVERT (VARCHAR(5), sinistre.id_prod),
                                      5), 1, 3)
                 ELSE RIGHT('0000' + CONVERT (VARCHAR(5), produit.cod_prod_dms),
                            3)
            END,
*/
            CASE produit.id_grp
              WHEN 153 THEN produit.id_grp
              ELSE sinistre.id_ets
            END,
            sinistre.id_adh,
            sinistre.id_sdos,
            police.id_cie,
			Case -- [PC512-5_ORANGE_V2_BIS]
				When div_sin.val_car is not null and Len ( rtrim( div_sin.val_car ) ) > 0 Then div_sin.val_car
				Else police.lib_police
			End lib_police,
            reglement.cod_mode_reg,
            reglement.cod_inter,
            CASE reglement.cod_mode_reg
              WHEN 'FM' THEN ISNULL(inter.id_four, SPACE(3))
              ELSE SPACE(3)
            END,
            SUM(reg_gti.mt_reg),
            CONVERT (VARCHAR(4), DATEPART(year, reglement.dte_reg))
            + RIGHT('0' + CONVERT (VARCHAR(2), DATEPART(month,
                                                        reglement.dte_reg)), 2)
            + RIGHT('0' + CONVERT (VARCHAR(2), DATEPART(day, reglement.dte_reg)),
                    2),
            garantie.cod_radical,
            sinistre.id_prod   -- JFF le 31/12/2007
    FROM    sysadm.reglement
            INNER JOIN sysadm.sinistre ON sysadm.reglement.id_sin = sysadm.sinistre.id_sin
            INNER JOIN sysadm.produit ON sysadm.sinistre.id_prod = sysadm.produit.id_prod
            INNER JOIN sysadm.garantie ON sysadm.sinistre.id_prod = sysadm.garantie.id_prod
                                          AND sysadm.sinistre.id_rev = sysadm.garantie.id_rev
            INNER JOIN sysadm.police ON sysadm.garantie.id_police = sysadm.police.id_police
            INNER JOIN sysadm.reg_gti ON sysadm.reglement.id_sin = sysadm.reg_gti.id_sin
                                         AND sysadm.reglement.id_reg = sysadm.reg_gti.id_reg
            LEFT OUTER JOIN sysadm.inter ON sysadm.reglement.id_sin = sysadm.inter.id_sin
                                            AND sysadm.reglement.id_i = sysadm.inter.id_i
			--[PC512-5_ORANGE_V2_BIS]
			LEFT OUTER JOIN sysadm.div_sin On sysadm.reglement.id_sin = sysadm.div_sin.id_sin
											AND sysadm.div_sin.nom_zone = 'lib_police'
											
			
    WHERE   ( garantie.id_gti = ( CASE reg_gti.id_gti
                                    WHEN -1
                                    THEN ISNULL(( SELECT    NULLIF(NULLIF(MAX(a_reg_gti.id_gti), 0), -1)
                                                  FROM      sysadm.reg_gti a_reg_gti
                                                  WHERE     a_reg_gti.id_sin = reg_gti.id_sin
                                                            AND a_reg_gti.id_reg = reg_gti.id_reg
                                                ),
                                                ( SELECT    MAX(gar_sin.id_gti)
                                                  FROM      sysadm.gar_sin
                                                  WHERE     sysadm.gar_sin.id_sin = sinistre.id_sin
                                                ))
                                    ELSE reg_gti.id_gti
                                  END ) )
            AND ( reglement.dte_reg BETWEEN @dtDteDeb AND @dtDteFin )
            AND ( reglement.cod_mot_reg IN ( 'RN', 'RM', 'RP' ) )
            AND  ( reglement.cod_mode_reg IN ( 'VA', 'VM', 'C', 'FM', 'BX', 'VV' ) )
            -- [PM266]
            AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
				  Or
				  ( 
					( Not Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
						And  
						@asCas = 'EXCLU_ASSUREUR' 
					)
					Or 
					( Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
						And  
						@asCas = 'INCLU_ASSUREUR' 
					)
				  )					
				)
    GROUP BY sinistre.id_sin,
            reglement.id_i,
            reglement.id_reg,
            CASE reglement.cod_mot_reg
              WHEN 'RN' THEN '1'
              WHEN 'RM' THEN '2'
              WHEN 'RP' THEN '3'
              ELSE '0'
            END,
			 Case --  [PI085]
				When @iFN_CLE_NUMERIQUE_PI085 > 0 Then 
					Case  
				 		When produit.cod_prod_dms is null Then Substring ( Right ( '00000' + Convert ( Varchar (5), sinistre.id_prod), 5), 1 , 5 ) --  [PI085]
						Else Right ( '00000' + Convert ( Varchar (5), produit.cod_prod_dms), 5 ) --  [PI085]
					End 
				Else 
					Case 
						When produit.cod_prod_dms is null Then Substring ( Right ( '0000' + Convert ( Varchar (5), sinistre.id_prod), 5), 1 , 3 )
						Else Right ( '0000' + Convert ( Varchar (5), produit.cod_prod_dms), 3)
					End 
			 End, --  [PI085]
            CASE produit.id_grp
              WHEN 153 THEN produit.id_grp
              ELSE sinistre.id_ets
            END,
            sinistre.id_adh,
            sinistre.id_sdos,
            police.id_cie,
          	Case 
				When div_sin.val_car is not null and Len ( rtrim( div_sin.val_car ) ) > 0 Then div_sin.val_car
				Else police.lib_police
			End,
            reglement.cod_mode_reg,
            reglement.cod_inter,
            CASE reglement.cod_mode_reg
              WHEN 'FM' THEN ISNULL(inter.id_four, SPACE(3))
              ELSE SPACE(3)
            END,
            CONVERT (VARCHAR(4), DATEPART(year, reglement.dte_reg))
            + RIGHT('0' + CONVERT (VARCHAR(2), DATEPART(month,
                                                        reglement.dte_reg)), 2)
            + RIGHT('0' + CONVERT (VARCHAR(2), DATEPART(day, reglement.dte_reg)),
                    2),
            garantie.cod_radical,
            sinistre.id_prod   -- JFF le 31/12/2007
    UNION ALL
    SELECT DISTINCT
            sinistre.id_sin,
            reglement.id_i,
            reglement.id_reg,
            '4',
			 Case --  [PI085]
				When @iFN_CLE_NUMERIQUE_PI085 > 0 Then 
					Case  
				 		When produit.cod_prod_dms is null Then Substring ( Right ( '00000' + Convert ( Varchar (5), sinistre.id_prod), 5), 1 , 5 ) --  [PI085]
						Else Right ( '00000' + Convert ( Varchar (5), produit.cod_prod_dms), 5 ) --  [PI085]
					End 
				Else 
					Case 
						When produit.cod_prod_dms is null Then Substring ( Right ( '0000' + Convert ( Varchar (5), sinistre.id_prod), 5), 1 , 3 )
						Else Right ( '0000' + Convert ( Varchar (5), produit.cod_prod_dms), 3)
					End 
			 End, --  [PI085]
            CASE produit.id_grp
              WHEN 153 THEN produit.id_grp
              ELSE sinistre.id_ets
            END,
            sinistre.id_adh,
            sinistre.id_sdos,
            police.id_cie,
			Case -- [PC512-5_ORANGE_V2_BIS]
				When div_sin.val_car is not null and Len ( rtrim( div_sin.val_car ) ) > 0 Then div_sin.val_car
				Else police.lib_police
			End lib_police,
            reglement.cod_mode_reg,
            reglement.cod_inter,
            CASE reglement.cod_mode_reg
              WHEN 'FM' THEN ISNULL(inter.id_four, SPACE(3))
              ELSE SPACE(3)
            END,
            SUM(reg_gti.mt_reg),
            CONVERT (VARCHAR(4), DATEPART(year, reglement.dte_reg))
            + RIGHT('0' + CONVERT (VARCHAR(2), DATEPART(month,
                                                        reglement.dte_reg)), 2)
            + RIGHT('0' + CONVERT (VARCHAR(2), DATEPART(day, reglement.dte_reg)),
                    2),
            garantie.cod_radical,
            sinistre.id_prod   -- JFF le 31/12/2007
    FROM    sysadm.reglement
            INNER JOIN sysadm.sinistre ON sysadm.reglement.id_sin = sysadm.sinistre.id_sin
            INNER JOIN sysadm.produit ON sysadm.sinistre.id_prod = sysadm.produit.id_prod
            INNER JOIN sysadm.garantie ON sysadm.sinistre.id_prod = sysadm.garantie.id_prod
                                          AND sysadm.sinistre.id_rev = sysadm.garantie.id_rev
            INNER JOIN sysadm.police ON sysadm.garantie.id_police = sysadm.police.id_police
            INNER JOIN sysadm.reg_gti ON sysadm.reglement.id_sin = sysadm.reg_gti.id_sin
                                         AND sysadm.reglement.id_reg_base = sysadm.reg_gti.id_reg
            LEFT OUTER JOIN sysadm.inter ON sysadm.reglement.id_sin = sysadm.inter.id_sin
                                            AND reglement.id_i = inter.id_i
			--[PC512-5_ORANGE_V2_BIS]
			LEFT OUTER JOIN sysadm.div_sin On sysadm.reglement.id_sin = sysadm.div_sin.id_sin
											AND sysadm.div_sin.nom_zone = 'lib_police'
                                            
    WHERE   ( garantie.id_gti = ( CASE reg_gti.id_gti
                                    WHEN -1
                                    THEN ISNULL(( SELECT    NULLIF(NULLIF(MAX(a_reg_gti.id_gti), 0), -1)
                                                  FROM      sysadm.reg_gti a_reg_gti
                                                  WHERE     a_reg_gti.id_sin = reg_gti.id_sin
                                                            AND a_reg_gti.id_reg = reg_gti.id_reg
                                                ),
                                                ( SELECT    MAX(sysadm.gar_sin.id_gti)
                                                  FROM      sysadm.gar_sin
                                                  WHERE     sysadm.gar_sin.id_sin = sinistre.id_sin
                                                ))
                                    ELSE reg_gti.id_gti
                                  END ) )
            AND ( reglement.dte_reg BETWEEN @dtDteDeb AND @dtDteFin )
            AND ( reglement.cod_mot_reg = 'RI' )
			AND   ( reglement.cod_mode_reg IN ( 'VA', 'VM', 'C', 'FM', 'BX', 'VV' ) )
            -- [PM266]
            AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
				  Or
				  ( 
					( Not Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
						And  
						@asCas = 'EXCLU_ASSUREUR' 
					)
					Or 
					( Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
						And  
						@asCas = 'INCLU_ASSUREUR' 
					)
				  )					
				)
			
    GROUP BY sinistre.id_sin,
            reglement.id_i,
            reglement.id_reg,
			 Case --  [PI085]
				When @iFN_CLE_NUMERIQUE_PI085 > 0 Then 
					Case  
				 		When produit.cod_prod_dms is null Then Substring ( Right ( '00000' + Convert ( Varchar (5), sinistre.id_prod), 5), 1 , 5 ) --  [PI085]
						Else Right ( '00000' + Convert ( Varchar (5), produit.cod_prod_dms), 5 ) --  [PI085]
					End 
				Else 
					Case 
						When produit.cod_prod_dms is null Then Substring ( Right ( '0000' + Convert ( Varchar (5), sinistre.id_prod), 5), 1 , 3 )
						Else Right ( '0000' + Convert ( Varchar (5), produit.cod_prod_dms), 3)
					End 
			 End, --  [PI085]
            CASE produit.id_grp
              WHEN 153 THEN produit.id_grp
              ELSE sinistre.id_ets
            END,
            sinistre.id_adh,
            sinistre.id_sdos,
            police.id_cie,
            Case 
				When div_sin.val_car is not null and Len ( rtrim( div_sin.val_car ) ) > 0 Then div_sin.val_car
				Else police.lib_police
			End,
            reglement.cod_mode_reg,
            reglement.cod_inter,
            CASE reglement.cod_mode_reg
              WHEN 'FM' THEN ISNULL(inter.id_four, SPACE(3))
              ELSE SPACE(3)
            END,
            CONVERT (VARCHAR(4), DATEPART(year, reglement.dte_reg))
            + RIGHT('0' + CONVERT (VARCHAR(2), DATEPART(month,
                                                        reglement.dte_reg)), 2)
            + RIGHT('0' + CONVERT (VARCHAR(2), DATEPART(day, reglement.dte_reg)),
                    2),
            garantie.cod_radical,
            sinistre.id_prod   -- JFF le 31/12/2007	
    UNION ALL
    SELECT DISTINCT
            sinistre.id_sin,
            reglement.id_i,
            reglement.id_reg,
            '4',
			 Case --  [PI085]
				When @iFN_CLE_NUMERIQUE_PI085 > 0 Then 
					Case  
				 		When produit.cod_prod_dms is null Then Substring ( Right ( '00000' + Convert ( Varchar (5), sinistre.id_prod), 5), 1 , 5 ) --  [PI085]
						Else Right ( '00000' + Convert ( Varchar (5), produit.cod_prod_dms), 5 ) --  [PI085]
					End 
				Else 
					Case 
						When produit.cod_prod_dms is null Then Substring ( Right ( '0000' + Convert ( Varchar (5), sinistre.id_prod), 5), 1 , 3 )
						Else Right ( '0000' + Convert ( Varchar (5), produit.cod_prod_dms), 3)
					End 
			 End, --  [PI085]
            CASE produit.id_grp
              WHEN 153 THEN produit.id_grp
              ELSE sinistre.id_ets
            END,
            sinistre.id_adh,
            sinistre.id_sdos,
            police.id_cie,
            Case -- [PC512-5_ORANGE_V2_BIS]
				When div_sin.val_car is not null and Len ( rtrim( div_sin.val_car ) ) > 0 Then div_sin.val_car
				Else police.lib_police
			End lib_police,
            reglement.cod_mode_reg,
            reglement.cod_inter,
            CASE reglement.cod_mode_reg
              WHEN 'FM' THEN ISNULL(inter.id_four, SPACE(3))
              ELSE SPACE(3)
            END,
            SUM(reg_gti.mt_reg) * -1,
            CONVERT (VARCHAR(4), DATEPART(year, reglement.dte_reg))
            + RIGHT('0' + CONVERT (VARCHAR(2), DATEPART(month,
                                                        reglement.dte_reg)), 2)
            + RIGHT('0' + CONVERT (VARCHAR(2), DATEPART(day, reglement.dte_reg)),
                    2),
            garantie.cod_radical,
            sinistre.id_prod   -- JFF le 31/12/2007	
    FROM    sysadm.reglement
            INNER JOIN sysadm.sinistre ON sysadm.reglement.id_sin = sysadm.sinistre.id_sin
            INNER JOIN sysadm.produit ON sysadm.sinistre.id_prod = sysadm.produit.id_prod
            INNER JOIN sysadm.garantie ON sysadm.sinistre.id_prod = sysadm.garantie.id_prod
                                          AND sysadm.sinistre.id_rev = sysadm.garantie.id_rev
            INNER JOIN sysadm.police ON sysadm.garantie.id_police = sysadm.police.id_police
            INNER JOIN sysadm.reg_gti ON sysadm.reglement.id_sin = sysadm.reg_gti.id_sin
                                         AND sysadm.reglement.id_reg_base = sysadm.reg_gti.id_reg
            LEFT OUTER JOIN sysadm.inter ON sysadm.reglement.id_sin = sysadm.inter.id_sin
                                            AND reglement.id_i = inter.id_i
                                            
			--[PC512-5_ORANGE_V2_BIS]
			LEFT OUTER JOIN sysadm.div_sin On sysadm.reglement.id_sin = sysadm.div_sin.id_sin
											AND sysadm.div_sin.nom_zone = 'lib_police'				                                            
                                            
    WHERE   ( garantie.id_gti = ( CASE reg_gti.id_gti
                                    WHEN -1
                                    THEN ISNULL(( SELECT    NULLIF(NULLIF(MAX(a_reg_gti.id_gti), 0), -1)
                                                  FROM      sysadm.reg_gti a_reg_gti
                                                  WHERE     a_reg_gti.id_sin = reg_gti.id_sin
                                                            AND a_reg_gti.id_reg = reg_gti.id_reg
                                                ),
                                                ( SELECT    MAX(sysadm.gar_sin.id_gti)
                                                  FROM      sysadm.gar_sin
                                                  WHERE     sysadm.gar_sin.id_sin = sinistre.id_sin
                                                ))
                                    ELSE reg_gti.id_gti
                                  END ) )
            AND ( reglement.dte_reg BETWEEN @dtDteDeb AND @dtDteFin )
            AND ( reglement.cod_mot_reg = 'RI' )
			AND ( reglement.cod_mode_reg IN ( 'VA', 'VM', 'C', 'FM', 'BX', 'VV' ) )
            -- [PM266]
            AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
				  Or
				  ( 
					( Not Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
						And  
						@asCas = 'EXCLU_ASSUREUR' 
					)
					Or 
					( Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
						And  
						@asCas = 'INCLU_ASSUREUR' 
					)
				  )					
				)
			
    GROUP BY sinistre.id_sin,
            reglement.id_i,
            reglement.id_reg,
			 Case --  [PI085]
				When @iFN_CLE_NUMERIQUE_PI085 > 0 Then 
					Case  
				 		When produit.cod_prod_dms is null Then Substring ( Right ( '00000' + Convert ( Varchar (5), sinistre.id_prod), 5), 1 , 5 ) --  [PI085]
						Else Right ( '00000' + Convert ( Varchar (5), produit.cod_prod_dms), 5 ) --  [PI085]
					End 
				Else 
					Case 
						When produit.cod_prod_dms is null Then Substring ( Right ( '0000' + Convert ( Varchar (5), sinistre.id_prod), 5), 1 , 3 )
						Else Right ( '0000' + Convert ( Varchar (5), produit.cod_prod_dms), 3)
					End 
			 End, --  [PI085]
            CASE produit.id_grp
              WHEN 153 THEN produit.id_grp
              ELSE sinistre.id_ets
            END,
            sinistre.id_adh,
            sinistre.id_sdos,
            police.id_cie,
            Case 
				When div_sin.val_car is not null and Len ( rtrim( div_sin.val_car ) ) > 0 Then div_sin.val_car
				Else police.lib_police
			End,
            reglement.cod_mode_reg,
            reglement.cod_inter,
            CASE reglement.cod_mode_reg
              WHEN 'FM' THEN ISNULL(inter.id_four, SPACE(3))
              ELSE SPACE(3)
            END,
            CONVERT (VARCHAR(4), DATEPART(year, reglement.dte_reg))
            + RIGHT('0' + CONVERT (VARCHAR(2), DATEPART(month,
                                                        reglement.dte_reg)), 2)
            + RIGHT('0' + CONVERT (VARCHAR(2), DATEPART(day, reglement.dte_reg)),
                    2),
            garantie.cod_radical,
            sinistre.id_prod   -- JFF le 31/12/2007

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_DCCTA
-- Auteur               :       DBI
-- Date                 :       08/12/1998
-- Libellé              :        
-- Commentaires         :       Liste des rŠglements DCCTA par radical
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--
-- Modification DBI le 26/04/1999
-- Int‚gration des r‚guls et RI dans Volcanes

-- Modification CAG le 18/11/2003
-- Changement de cpte AIG cf DMDI 9793
--	Exclusion des produits concernés qui sont affectés
--	sur une nvelle stat ( PS_S11_DCCTA)
-------------------------------------------------------------------
-- #1  JFF  22/05/2008  [3SUISSE].COD_MODE_REG 
-- JFF      06/10/2014   [PM266]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_DCCTA' AND type = 'P' )
        DROP procedure sysadm.PS_S01_DCCTA
GO

CREATE procedure sysadm.PS_S01_DCCTA
        @dtDteDeb       DateTime        ,
        @dtDteFin       DateTime
AS

--
--

 SELECT distinct 
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
        Sum ( reg_gti.mt_reg ), 
	produit.lib_long,
	garantie.cod_radical
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit,
        sysadm.garantie,
        sysadm.reg_gti,
	sysadm.departement
 WHERE  ( sinistre.id_sin    = reglement.id_sin   ) 					and 
        ( sinistre.id_prod   = produit.id_prod    )     				and 
        ( garantie.id_prod   = sinistre.id_prod   ) 					and
        ( garantie.id_rev    = sinistre.id_rev    ) 					and
        ( garantie.id_gti    = ( Case  reg_gti.id_gti     
		  	         When  -1 Then
					IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
						   From   sysadm.reg_gti a_reg_gti
						   Where  a_reg_gti.id_sin = reg_gti.id_sin
						   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			         ( Select max ( gar_sin.id_gti ) 
						   From   sysadm.gar_sin
						   Where  sysadm.gar_sin.id_sin = sinistre.id_sin ) ) 
	    			 Else  reg_gti.id_gti 
				 End	) )						and
        ( reglement.id_sin   = reg_gti.id_sin      ) 					and
        ( reglement.id_reg   = reg_gti.id_reg      ) 					and 
	( produit.id_dept    = departement.id_dept )					and
        ( reglement.dte_reg between @dtDteDeb  and @dtDteFin  ) 			and 
        ( reglement.cod_mot_reg in ( 'RN', 'RE', 'RM', 'RP' ) )				and
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 			

	-- Et n'appartenant pas au Compte dédié AIG
	/* -- [PM266]
	( Not (	
		( produit.rib_bq	= '30002'					)  and  
		( produit.rib_gui	= '06522'					)  and 
		( produit.rib_cpt	= '0000061704E'					)  and 
		( produit.rib_cle	= '94'						)  
	      )
	 )
	 */
          -- [PM266]
          AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
  			    Or
				Not Exists ( 
					Select 1
					From	sysadm.exclu_ass ex,
							sysadm.garantie ga,
							sysadm.police po,
							sysadm.reg_gti rg
					Where	rg.id_sin = reglement.id_sin
					And     rg.id_reg = reglement.id_reg
					And		ga.id_prod = sinistre.id_prod
					And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
													IsNull ( 
														( Select max (id_rev )
														  From   revision r
														  Where  r.id_prod = sinistre.id_prod ) , 0 ))
					And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
													(
													  Select top 1 id_gti  
													  From   sysadm.garantie ga2
													  Where  ga2.id_prod = ga.id_prod
													  And    ga2.id_rev = ga.id_rev 
													)
												)
					And		po.id_police = ga.id_police
					and		ex.id_cie = po.id_cie			
				)
			  ) 


 GROUP BY
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
	produit.lib_long,
	garantie.cod_radical
UNION ALL
 SELECT distinct 
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
        Sum ( reg_gti.mt_reg ), 
	produit.lib_long,
	garantie.cod_radical
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit,
        sysadm.garantie,
        sysadm.reg_gti,
	sysadm.departement
 WHERE  ( sinistre.id_sin    = reglement.id_sin   ) 					and 
        ( sinistre.id_prod   = produit.id_prod    )     				and 
        ( garantie.id_prod   = sinistre.id_prod   ) 					and
        ( garantie.id_rev    = sinistre.id_rev    ) 					and
        ( garantie.id_gti    = ( Case  reg_gti.id_gti     
		  	         When  -1 Then
					IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
						   From   sysadm.reg_gti a_reg_gti
						   Where  a_reg_gti.id_sin = reg_gti.id_sin
						   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			         ( Select max ( gar_sin.id_gti ) 
						   From   sysadm.gar_sin
						   Where  sysadm.gar_sin.id_sin = sinistre.id_sin ) ) 
	    			 Else  reg_gti.id_gti 
				 End	) )						and
        ( reglement.id_sin   	  = reg_gti.id_sin      ) 				and
        ( reglement.id_reg_base   = reg_gti.id_reg      ) 				and 
	( produit.id_dept    = departement.id_dept )					and
        ( reglement.dte_reg between @dtDteDeb  and @dtDteFin  ) 			and 
        ( reglement.cod_mot_reg = 'RI'             ) 					and
	( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 

	/* -- [PM266]
	( Not (	
		( produit.rib_bq	= '30002'					)  and  
		( produit.rib_gui	= '06522'					)  and 
		( produit.rib_cpt	= '0000061704E'					)  and 
		( produit.rib_cle	= '94'						)  
	      )
	 )
	 */

          -- [PM266]
          AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
  			    Or
				Not Exists ( 
					Select 1
					From	sysadm.exclu_ass ex,
							sysadm.garantie ga,
							sysadm.police po,
							sysadm.reg_gti rg
					Where	rg.id_sin = reglement.id_sin
					And     rg.id_reg = reglement.id_reg
					And		ga.id_prod = sinistre.id_prod
					And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
													IsNull ( 
														( Select max (id_rev )
														  From   revision r
														  Where  r.id_prod = sinistre.id_prod ) , 0 ))
					And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
													(
													  Select top 1 id_gti  
													  From   sysadm.garantie ga2
													  Where  ga2.id_prod = ga.id_prod
													  And    ga2.id_rev = ga.id_rev 
													)
												)
					And		po.id_police = ga.id_police
					and		ex.id_cie = po.id_cie			
				)
			  ) 

 GROUP BY
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
	produit.lib_long,
	garantie.cod_radical
UNION ALL
 SELECT distinct 
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
        Sum ( reg_gti.mt_reg ) * -1,
	produit.lib_long,
	garantie.cod_radical
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit,
        sysadm.garantie,
        sysadm.reg_gti,
	sysadm.departement
 WHERE  ( sinistre.id_sin    = reglement.id_sin   ) 					and 
        ( sinistre.id_prod   = produit.id_prod    )     				and 
        ( garantie.id_prod   = sinistre.id_prod   ) 					and
        ( garantie.id_rev    = sinistre.id_rev    ) 					and
        ( garantie.id_gti    = ( Case  reg_gti.id_gti     
		  	         When  -1 Then
					IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
						   From   sysadm.reg_gti a_reg_gti
						   Where  a_reg_gti.id_sin = reg_gti.id_sin
						   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			         ( Select max ( gar_sin.id_gti ) 
						   From   sysadm.gar_sin
						   Where  sysadm.gar_sin.id_sin = sinistre.id_sin ) ) 
	    			 Else  reg_gti.id_gti 
				 End	) )						and
        ( reglement.id_sin   	  = reg_gti.id_sin      ) 				and
        ( reglement.id_reg_base   = reg_gti.id_reg      ) 				and 
	( produit.id_dept    = departement.id_dept )					and
        ( reglement.dte_reg between @dtDteDeb  and @dtDteFin  ) 			and 
        ( reglement.cod_mot_reg = 'RI'             ) 					and
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 

	/*
	-- Et n'appartenant pas au Compte dédié AIG
	( Not (	
		( produit.rib_bq	= '30002'					)  and  
		( produit.rib_gui	= '06522'					)  and 
		( produit.rib_cpt	= '0000061704E'					)  and 
		( produit.rib_cle	= '94'						)  
	      )
	 )
	 */
	 
          -- [PM266]
          AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
  			    Or
				Not Exists ( 
					Select 1
					From	sysadm.exclu_ass ex,
							sysadm.garantie ga,
							sysadm.police po,
							sysadm.reg_gti rg
					Where	rg.id_sin = reglement.id_sin
					And     rg.id_reg = reglement.id_reg
					And		ga.id_prod = sinistre.id_prod
					And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
													IsNull ( 
														( Select max (id_rev )
														  From   revision r
														  Where  r.id_prod = sinistre.id_prod ) , 0 ))
					And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
													(
													  Select top 1 id_gti  
													  From   sysadm.garantie ga2
													  Where  ga2.id_prod = ga.id_prod
													  And    ga2.id_rev = ga.id_rev 
													)
												)
					And		po.id_police = ga.id_police
					and		ex.id_cie = po.id_cie			
				)
			  ) 
	 

 GROUP BY
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
	produit.lib_long,
	garantie.cod_radical

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S11_DCCTA
-- Auteur               :       CAG
-- Date                 :       18/11/2003
-- Libellé              :        
-- Commentaires         :       Liste des rŠglements DCCTA par radical pour
--				les produits AIG (cf PS_S01_DCCTA, modif 18/11/2003)
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1  JFF  22/05/2008  [3SUISSE].COD_MODE_REG 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S11_DCCTA' AND type = 'P' )
        DROP procedure sysadm.PS_S11_DCCTA
GO

CREATE procedure sysadm.PS_S11_DCCTA
        @dtDteDeb       DateTime        ,
        @dtDteFin       DateTime
AS

--
--

 SELECT distinct 
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
        Sum ( reg_gti.mt_reg ), 
	produit.lib_long,
	garantie.cod_radical
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit,
        sysadm.garantie,
        sysadm.reg_gti,
	sysadm.departement
 WHERE  ( sinistre.id_sin    = reglement.id_sin   ) 					and 
        ( sinistre.id_prod   = produit.id_prod    )     				and 
        ( garantie.id_prod   = sinistre.id_prod   ) 					and
        ( garantie.id_rev    = sinistre.id_rev    ) 					and
        ( garantie.id_gti    = ( Case  reg_gti.id_gti     
		  	         When  -1 Then
					IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
						   From   sysadm.reg_gti a_reg_gti
						   Where  a_reg_gti.id_sin = reg_gti.id_sin
						   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			         ( Select max ( gar_sin.id_gti ) 
						   From   sysadm.gar_sin
						   Where  sysadm.gar_sin.id_sin = sinistre.id_sin ) ) 
	    			 Else  reg_gti.id_gti 
				 End	) )						and
        ( reglement.id_sin   = reg_gti.id_sin      ) 					and
        ( reglement.id_reg   = reg_gti.id_reg      ) 					and 
	( produit.id_dept    = departement.id_dept )					and
        ( reglement.dte_reg between @dtDteDeb  and @dtDteFin  ) 			and 
        ( reglement.cod_mot_reg in ( 'RN', 'RE', 'RM', 'RP' ) )				and

-- #1 [3SUISSE].COD_MODE_REG Ajout BX
--      ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM' ) ) 			and
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 			and
-- :#1 [3SUISSE].COD_MODE_REG

	-- Et appartenant au Compte dédié AIG
	( produit.rib_bq	= '30002'					)  and  
	( produit.rib_gui	= '06522'					)  and 
	( produit.rib_cpt	= '0000061704E'					)  and 
	( produit.rib_cle	= '94'						)  


 GROUP BY
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
	produit.lib_long,
	garantie.cod_radical
UNION ALL
 SELECT distinct 
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
        Sum ( reg_gti.mt_reg ), 
	produit.lib_long,
	garantie.cod_radical
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit,
        sysadm.garantie,
        sysadm.reg_gti,
	sysadm.departement
 WHERE  ( sinistre.id_sin    = reglement.id_sin   ) 					and 
        ( sinistre.id_prod   = produit.id_prod    )     				and 
        ( garantie.id_prod   = sinistre.id_prod   ) 					and
        ( garantie.id_rev    = sinistre.id_rev    ) 					and
        ( garantie.id_gti    = ( Case  reg_gti.id_gti     
		  	         When  -1 Then
					IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
						   From   sysadm.reg_gti a_reg_gti
						   Where  a_reg_gti.id_sin = reg_gti.id_sin
						   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			         ( Select max ( gar_sin.id_gti ) 
						   From   sysadm.gar_sin
						   Where  sysadm.gar_sin.id_sin = sinistre.id_sin ) ) 
	    			 Else  reg_gti.id_gti 
				 End	) )						and
        ( reglement.id_sin   	  = reg_gti.id_sin      ) 				and
        ( reglement.id_reg_base   = reg_gti.id_reg      ) 				and 
	( produit.id_dept    = departement.id_dept )					and
        ( reglement.dte_reg between @dtDteDeb  and @dtDteFin  ) 			and 
        ( reglement.cod_mot_reg = 'RI'             ) 					and

-- #1 [3SUISSE].COD_MODE_REG Ajout BX
--      ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM' ) ) 			and
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 			and        
-- :#1 [3SUISSE].COD_MODE_REG

	-- Et appartenant au Compte dédié AIG
	( produit.rib_bq	= '30002'					)  and  
	( produit.rib_gui	= '06522'					)  and 
	( produit.rib_cpt	= '0000061704E'					)  and 
	( produit.rib_cle	= '94'						)  

 GROUP BY
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
	produit.lib_long,
	garantie.cod_radical
UNION ALL
 SELECT distinct 
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
        Sum ( reg_gti.mt_reg ) * -1,
	produit.lib_long,
	garantie.cod_radical
 FROM   sysadm.reglement, 
        sysadm.sinistre, 
        sysadm.produit,
        sysadm.garantie,
        sysadm.reg_gti,
	sysadm.departement
 WHERE  ( sinistre.id_sin    = reglement.id_sin   ) 					and 
        ( sinistre.id_prod   = produit.id_prod    )     				and 
        ( garantie.id_prod   = sinistre.id_prod   ) 					and
        ( garantie.id_rev    = sinistre.id_rev    ) 					and
        ( garantie.id_gti    = ( Case  reg_gti.id_gti     
		  	         When  -1 Then
					IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
						   From   sysadm.reg_gti a_reg_gti
						   Where  a_reg_gti.id_sin = reg_gti.id_sin
						   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			         ( Select max ( gar_sin.id_gti ) 
						   From   sysadm.gar_sin
						   Where  sysadm.gar_sin.id_sin = sinistre.id_sin ) ) 
	    			 Else  reg_gti.id_gti 
				 End	) )						and
        ( reglement.id_sin   	  = reg_gti.id_sin      ) 				and
        ( reglement.id_reg_base   = reg_gti.id_reg      ) 				and 
	( produit.id_dept    = departement.id_dept )					and
        ( reglement.dte_reg between @dtDteDeb  and @dtDteFin  ) 			and 
        ( reglement.cod_mot_reg = 'RI'             ) 					and

-- #1 [3SUISSE].COD_MODE_REG Ajout BX
--      ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM' ) ) 			and	
        ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 			and	        
-- :#1 [3SUISSE].COD_MODE_REG 
	-- Et appartenant au Compte dédié AIG
	( produit.rib_bq	= '30002'					)  and  
	( produit.rib_gui	= '06522'					)  and 
	( produit.rib_cpt	= '0000061704E'					)  and 
	( produit.rib_cle	= '94'						)  

 GROUP BY
	sinistre.id_prod,
        sinistre.id_ets, 
	produit.rib_bq + '-' + produit.rib_gui + '-' + produit.rib_cpt + '-' + produit.rib_cle,
	departement.lib_dept,
	produit.lib_long,
	garantie.cod_radical
	
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_LSTREG
-- Auteur               :       DBI
-- Date                 :       08/12/1998
-- Libellé              :        
-- Commentaires         :       Liste d‚taill‚e des rŠglements
-- Références           :       
--
--				EURO
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
-- [BUG20080728].COD_MODE_REG  JFF
-------------------------------------------------------------------
-- JFF      06/10/2014   [PM266]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_LSTREG' AND type = 'P' )
        DROP procedure sysadm.PS_S01_LSTREG
GO

CREATE procedure sysadm.PS_S01_LSTREG
	@dtDteDeb       DateTime        ,
   @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      ,
	@dcIdProd	Decimal(7)	WITH RECOMPILE

AS

/* 
   Gestion de l'euro, si prod négatif, état en Euro,
   si prod positif, état en Francs Francais.
*/
Declare @dcTaux Decimal ( 6,5 )

Select  @dcTaux = 1              
If @dcIdProd < 0 
 Begin
  Select  @dcTaux = 6.55957
  Select  @dcIdProd = @dcIdProd * (-1)
 End

SET NOCOUNT ON

Declare	@sCodAdh Char(1)


Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramŠne dans un premier temps le d‚tail du rŠglement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les r‚guls effectu‚es
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg / @dcTaux,
 'ID_DETAIL'	= detail.id_detail,
 'MT_PREJ'	= detail.mt_prej / @dcTaux,
 'MT_PLAF'	= detail.mt_plaf / @dcTaux,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'DTE_DET'	= detail.dte_det,
 'EV' 		= code_Ev.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.detail    ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.code code_Ev,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	detail.id_sin		)	and
 ( reg_gti.id_reg	=	detail.id_reg		)	and
 ( reg_gti.id_gti	=	detail.id_gti		)	and
 ( reg_gti.id_rgpt	=	( Case detail.id_gti
				When 7 Then
					Case 
					 When detail.id_evt between 700 and 719 then 700
					 When detail.id_evt between 720 and 739 then 720
					 Else 740
					End
				Else	detail.id_gti
				End )			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( detail.id_sin	=	gar_sin.id_sin		)	and
 ( detail.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( code_Ev.id_typ_code	=	'+EV'			)	and
 ( code_Ev.id_code	=	detail.id_evt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )       and 
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg / @dcTaux,
 'ID_DETAIL'	= frais.id_frais,
 'MT_PREJ'	= frais.mt_frais / @dcTaux,
 'MT_PLAF'	= frais.mt_frais / @dcTaux,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= code_Nf.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 

Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= 'REGULARISATION',
 'MT_REG_GTI'	= reglement.mt_tot_reg / @dcTaux,
 'ID_DETAIL'	= 0,
 'MT_PREJ'	= 0,
 'MT_PLAF'	= reglement.mt_tot_reg / @dcTaux,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= reglement.lib_reg,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie

Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

END

Else				-- Adhesions SPB ou autres hors carte

BEGIN

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg / @dcTaux,
 'ID_DETAIL'	= detail.id_detail,
 'MT_PREJ'	= detail.mt_prej / @dcTaux,
 'MT_PLAF'	= detail.mt_plaf / @dcTaux,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'DTE_DET'	= detail.dte_det,
 'EV' 		= code_Ev.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.detail    ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.code code_Ev,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 

Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	detail.id_sin		)	and
 ( reg_gti.id_reg	=	detail.id_reg		)	and
 ( reg_gti.id_gti	=	detail.id_gti		)	and
 ( reg_gti.id_rgpt	=	( Case detail.id_gti
				When 7 Then
					Case 
					 When detail.id_evt between 700 and 719 then 700
					 When detail.id_evt between 720 and 739 then 720
					 Else 740
					End
				Else	detail.id_gti
				End )			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( detail.id_sin	=	gar_sin.id_sin		)	and
 ( detail.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( code_Ev.id_typ_code	=	'+EV'			)	and
 ( code_Ev.id_code	=	detail.id_evt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg / @dcTaux,
 'ID_DETAIL'	= frais.id_frais,
 'MT_PREJ'	= frais.mt_frais / @dcTaux,
 'MT_PLAF'	= frais.mt_frais / @dcTaux,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= code_Nf.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 

Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= 'REGULARISATION',
 'MT_REG_GTI'	= reglement.mt_tot_reg / @dcTaux,
 'ID_DETAIL'	= 0,
 'MT_PREJ'	= 0,
 'MT_PLAF'	= reglement.mt_tot_reg / @dcTaux,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= reglement.lib_reg,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

END

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S011_LSTREG
-- Auteur               :       JFF ( Reprise et modification de la requête initiale de DBI PS_S01_LSTREG )
-- Date                 :       08/01/2002
-- Libellé              :        
-- Commentaires         :       Liste d‚taill‚e des rŠglements pour CGU COURTAGE
-- Références           :       
--
--				
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
-- [BUG20080728].COD_MODE_REG  JFF
-------------------------------------------------------------------
-- #1 - FPI - 04/12/2009 - [EXPANSION5.LIB_POLICE] 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S011_LSTREG' AND type = 'P' )
        DROP procedure sysadm.PS_S011_LSTREG
GO

CREATE procedure sysadm.PS_S011_LSTREG 
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      ,
	@dcIdProd	Decimal(7)	WITH RECOMPILE

AS

/* Variante de PS_S01_LSTREG, mais on ne ramène
   pas le détail 
*/

SET NOCOUNT ON

Declare	@sCodAdh Char(1)


Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramSne dans un premier temps le d'tail du rSglement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les r'guls effectu'es
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_gti	=	reg_gti.id_gti	 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF


UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 

Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF


UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= 'REGULARISATION',
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF


END

Else				-- Adhesions SPB ou autres hors carte

BEGIN

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( reg_gti.id_sin	=	gar_sin.id_sin		)	and
 ( reg_gti.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF

UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= 'REGULARISATION',
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF


END

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S012_LSTREG
-- Auteur               :       DBI
-- Date                 :       08/12/1998
-- Libellé              :        
-- Commentaires         :       Liste d‚taill‚e des rŠglements
-- Références           :       Variante pour 4 produits DCMP 20078 P.FERMEY Ajoutn° de compte du client
--
--				EURO
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
-- [BUG20080728].COD_MODE_REG  JFF
-------------------------------------------------------------------
-- #1 - FPI - 04/12/2009 - [EXPANSION5.LIB_POLICE] 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S012_LSTREG' AND type = 'P' )
        DROP procedure sysadm.PS_S012_LSTREG
GO

CREATE procedure sysadm.PS_S012_LSTREG
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      ,
	@dcIdProd	Decimal(7)	WITH RECOMPILE

AS

/* 
   Gestion de l'euro, si prod négatif, état en Euro,
   si prod positif, état en Francs Francais.
*/
Declare @dcTaux Decimal ( 6,5 )

Select  @dcTaux = 1              
If @dcIdProd < 0 
 Begin
  Select  @dcTaux = 6.55957
  Select  @dcIdProd = @dcIdProd * (-1)
 End

SET NOCOUNT ON

Declare	@sCodAdh Char(1)


Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramŠne dans un premier temps le d‚tail du rŠglement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les r‚guls effectu‚es
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'RIB_BQ'	= reglement.rib_bq, 
 'RIB_GUI'	= reglement.rib_gui,
 'RIB_CPT'	= reglement.rib_cpt,
 'RIB_CLE'	= reglement.rib_cle,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg / @dcTaux,
 'ID_DETAIL'	= detail.id_detail,
 'MT_PREJ'	= detail.mt_prej / @dcTaux,
 'MT_PLAF'	= detail.mt_plaf / @dcTaux,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'DTE_DET'	= detail.dte_det,
 'EV' 		= code_Ev.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.detail    ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.code code_Ev,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	detail.id_sin		)	and
 ( reg_gti.id_reg	=	detail.id_reg		)	and
 ( reg_gti.id_gti	=	detail.id_gti		)	and
 ( reg_gti.id_rgpt	=	( Case detail.id_gti
				When 7 Then
					Case 
					 When detail.id_evt between 700 and 719 then 700
					 When detail.id_evt between 720 and 739 then 720
					 Else 740
					End
				Else	detail.id_gti
				End )			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( detail.id_sin	=	gar_sin.id_sin		)	and
 ( detail.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( code_Ev.id_typ_code	=	'+EV'			)	and
 ( code_Ev.id_code	=	detail.id_evt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( reglement.id_sin 	= 	reg_gti.id_sin		)	and
 ( reglement.id_reg 	= 	reg_gti.id_reg		)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 	

UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'RIB_BQ'	= reglement.rib_bq, 
 'RIB_GUI'	= reglement.rib_gui,
 'RIB_CPT'	= reglement.rib_cpt,
 'RIB_CLE'	= reglement.rib_cle, 
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg / @dcTaux,
 'ID_DETAIL'	= frais.id_frais,
 'MT_PREJ'	= frais.mt_frais / @dcTaux,
 'MT_PLAF'	= frais.mt_frais / @dcTaux,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= code_Nf.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( reglement.id_sin 	= 	reg_gti.id_sin		)	and
 ( reglement.id_reg 	= 	reg_gti.id_reg		)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 	

UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'RIB_BQ'	= reglement.rib_bq, 
 'RIB_GUI'	= reglement.rib_gui,
 'RIB_CPT'	= reglement.rib_cpt,
 'RIB_CLE'	= reglement.rib_cle,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= 'REGULARISATION',
 'MT_REG_GTI'	= reglement.mt_tot_reg / @dcTaux,
 'ID_DETAIL'	= 0,
 'MT_PREJ'	= 0,
 'MT_PLAF'	= reglement.mt_tot_reg / @dcTaux,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= reglement.lib_reg,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


END

Else				-- Adhesions SPB ou autres hors carte

BEGIN

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'RIB_BQ'	= reglement.rib_bq, 
 'RIB_GUI'	= reglement.rib_gui,
 'RIB_CPT'	= reglement.rib_cpt,
 'RIB_CLE'	= reglement.rib_cle,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg / @dcTaux,
 'ID_DETAIL'	= detail.id_detail,
 'MT_PREJ'	= detail.mt_prej / @dcTaux,
 'MT_PLAF'	= detail.mt_plaf / @dcTaux,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'DTE_DET'	= detail.dte_det,
 'EV' 		= code_Ev.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.detail    ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.code code_Ev,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	detail.id_sin		)	and
 ( reg_gti.id_reg	=	detail.id_reg		)	and
 ( reg_gti.id_gti	=	detail.id_gti		)	and
 ( reg_gti.id_rgpt	=	( Case detail.id_gti
				When 7 Then
					Case 
					 When detail.id_evt between 700 and 719 then 700
					 When detail.id_evt between 720 and 739 then 720
					 Else 740
					End
				Else	detail.id_gti
				End )			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( detail.id_sin	=	gar_sin.id_sin		)	and
 ( detail.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( code_Ev.id_typ_code	=	'+EV'			)	and
 ( code_Ev.id_code	=	detail.id_evt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( reglement.id_sin 	= 	reg_gti.id_sin		)	and
 ( reglement.id_reg 	= 	reg_gti.id_reg		)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 
	  	
UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'RIB_BQ'	= reglement.rib_bq, 
 'RIB_GUI'	= reglement.rib_gui,
 'RIB_CPT'	= reglement.rib_cpt,
 'RIB_CLE'	= reglement.rib_cle,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg / @dcTaux,
 'ID_DETAIL'	= frais.id_frais,
 'MT_PREJ'	= frais.mt_frais / @dcTaux,
 'MT_PLAF'	= frais.mt_frais / @dcTaux,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= code_Nf.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( reglement.id_sin 	= 	reg_gti.id_sin		)	and
 ( reglement.id_reg 	= 	reg_gti.id_reg		)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 
	  	
UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'RIB_BQ'	= reglement.rib_bq, 
 'RIB_GUI'	= reglement.rib_gui,
 'RIB_CPT'	= reglement.rib_cpt,
 'RIB_CLE'	= reglement.rib_cle,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= 'REGULARISATION',
 'MT_REG_GTI'	= reglement.mt_tot_reg / @dcTaux,
 'ID_DETAIL'	= 0,
 'MT_PREJ'	= 0,
 'MT_PLAF'	= reglement.mt_tot_reg / @dcTaux,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= reglement.lib_reg,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie

Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

END

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S013_LSTREG_GAN
-- Auteur               :       FPI	
-- Date                 :       25/07/2012
-- Libellé              :        
-- Commentaires         :       Liste détaillée des réglements
-- Références           :       Variante de PS_S13_LSTREG pour GAN (VDoc7247)
--
--				EURO
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
--				
-- Retourne             :       Rien
-------------------------------------------------------------------
-- [VDoc9436] Ajout du produit 72200
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S013_LSTREG_GAN' AND type = 'P' )
        DROP procedure sysadm.PS_S013_LSTREG_GAN
GO

CREATE procedure sysadm.PS_S013_LSTREG_GAN
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      
	
AS

SET NOCOUNT ON

Select distinct 
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'LIB_POLICE'	= police.lib_police,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_ADH'	= ( convert ( varchar (6), sinistre.id_prod ) + '-' +
   		  Right ( '00000' + convert ( varchar (5), sinistre.id_ets ), 5 ) + '-' +
   		  Right ( Replicate ( '0', 19 ) + sinistre.id_adh, 19 ) + '-' +
  		  convert ( varchar (1), sinistre.id_sdos ) ),
 'DTE_ADH'	= sinistre.dte_adh,
 'DTE_FIN_GTI'  = sinistre.dte_fin_gti,
 'GA' 		= code_Gs.lib_code,
 'NS' 		= code_Ns.lib_code,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'MT_PREJ_GTI'  = gar_sin.mt_tot_prej,
 'VAL_ACHAT'    = ( Select IsNull (max ( d.mt_val_achat),0 )
  		    From   detail d
  		    Where  d.id_sin = sinistre.id_sin
 		    And    d.id_gti = gar_sin.id_gti ),
 'VAL_PUBLIQUE' = ( Select IsNull (max ( d.mt_val_publique),0 )
 		    From   detail d
 		    Where  d.id_sin = sinistre.id_sin
 		    And    d.id_gti = gar_sin.id_gti ),		    
 'DTE_REG'	= reg_gti.maj_le,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'LIB_PROD'	= produit.lib_long,
 'ID_REG'	= reg_gti.id_reg,
 'TYP_REGL'	= sysadm.FN_CODE_CAR(reglement.cod_mode_reg, '-MR'), -- [DCMP080675]
 'DEST_REG'	= inter.nom
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne,
 sysadm.inter 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_gti	=	reg_gti.id_gti	 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
  ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
-- ( sinistre.id_prod	in ( 551, 16100, 16101, 55100 )			)	and
-- [DCMP080611] remplacé par :
 ( produit.id_prod	=	sinistre.id_prod		)	and
  produit.id_prod not in (551,5707,5709,5710,5711,5712,5720,5721,5722,5723,
5724,5725,5726,5727,5728,5729,5730,5731,5732,5733,6900,
8300,11001,11101,11300,11400,13700,14000,14300,14500,14600,15200,15600,
15800,15900,16200,16500,17800,24600,38300,57600) and -- [VDoc9436] Ajout du produit 72200
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) )  and
-- :[BUG20080728].COD_MODE_REG  JFF
 ( inter.id_sin 	= 	sinistre.id_sin		)	and
 ( inter.id_i 		= 	reglement.id_i		)	and 
 compagnie.id_cie in (2,12,66,67) 

UNION ALL

-- Select 2 COD_ADH = 3 (par carte)
Select distinct
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'LIB_POLICE'	= police.lib_police,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_ADH'	= ( convert ( varchar (6), sinistre.id_prod ) + '-' +
    		  Right ( '00000' + convert ( varchar (5), sinistre.id_ets ), 5 ) + '-' +
    		  Right ( Replicate ( '0', 19 ) + sinistre.id_adh, 19 ) + '-' +
   		  convert ( varchar (1), sinistre.id_sdos ) ),
 'DTE_ADH'	= sinistre.dte_adh, 
 'DTE_FIN_GTI'  = sinistre.dte_fin_gti,
 'GA' 		= code_Nf.lib_code,
 'NS' 		= code_Ns.lib_code,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'MT_PREJ_GTI'  = 0,
 'VAL_ACHAT'    = 0,
 'VAL_PUBLIQUE' = 0,
 'DTE_REG'	= reg_gti.maj_le,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'LIB_PROD'	= produit.lib_long,
 'ID_REG'	= reg_gti.id_reg,
 'TYP_REGL'	= sysadm.FN_CODE_CAR(reglement.cod_mode_reg, '-MR'), -- [DCMP080675]
 'DEST_REG'	= inter.nom
 
From
 sysadm.reglement ,
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.inter 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( reglement.id_sin     =       reg_gti.id_sin		)	and
 ( reglement.id_reg     =       reg_gti.id_reg		)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
  produit.id_prod not in (551,5707,5709,5710,5711,5712,5720,5721,5722,5723,
5724,5725,5726,5727,5728,5729,5730,5731,5732,5733,6900,
8300,11001,11101,11300,11400,13700,14000,14300,14500,14600,15200,15600,
15800,15900,16200,16500,17800,24600,38300,57600) and -- [VDoc9436] Ajout du produit 72200
( produit.id_dept	=	departement.id_dept	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
-- ( sinistre.id_prod	in ( 551, 16100, 16101, 55100 )			)	and
-- [DCMP080611] remplacé par :
 ( produit.id_prod	=	sinistre.id_prod		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) )  and
-- :[BUG20080728].COD_MODE_REG  JFF
 ( inter.id_sin 	= 	sinistre.id_sin		)	and
 ( inter.id_i 		= 	reglement.id_i		)	and 
 compagnie.id_cie in (2,12,66,67) 


UNION ALL

-- Select 3 COD_ADH = 3 (par carte)
Select distinct
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'LIB_POLICE'	= police.lib_police,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_ADH'	= ( convert ( varchar (6), sinistre.id_prod ) + '-' +
    		  Right ( '00000' + convert ( varchar (5), sinistre.id_ets ), 5 ) + '-' +
    		  Right ( Replicate ( '0', 19 ) + sinistre.id_adh, 19 ) + '-' +
   		  convert ( varchar (1), sinistre.id_sdos ) ),
 'DTE_ADH'	= sinistre.dte_adh,  		  
 'DTE_FIN_GTI'  = sinistre.dte_fin_gti,
 'GA' 		= 'REGULARISATION',
 'NS' 		= code_Ns.lib_code,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'MT_PREJ_GTI'  = 0,
 'VAL_ACHAT'    = 0,
 'VAL_PUBLIQUE' = 0,
 'DTE_REG'	= reglement.dte_reg,
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'LIB_PROD'	= produit.lib_long, 		    
 'ID_REG'	= reglement.id_reg,
 'TYP_REGL'	= sysadm.FN_CODE_CAR(reglement.cod_mode_reg, '-MR'), -- [DCMP080675]
 'DEST_REG'	= inter.nom
 
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.code code_Ns,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.inter 
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
-- ( sinistre.id_prod	in ( 551, 16100, 16101, 55100 )			)	and
-- [DCMP080611] remplacé par :
 ( produit.id_prod	=	sinistre.id_prod		)	and
  produit.id_prod not in (551,5707,5709,5710,5711,5712,5720,5721,5722,5723,
5724,5725,5726,5727,5728,5729,5730,5731,5732,5733,6900,
8300,11001,11101,11300,11400,13700,14000,14300,14500,14600,15200,15600,
15800,15900,16200,16500,17800,24600,38300,57600) --[VDoc9436] Ajout du produit 72200
 and( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) )  and
-- :[BUG20080728].COD_MODE_REG  JFF
 ( inter.id_sin 	= 	sinistre.id_sin		)	and
 ( inter.id_i 		= 	reglement.id_i		)	and 
 compagnie.id_cie in (2,12,66,67) 

go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S013_LSTREG_GAN_V01
-- Auteur               :       FPI	
-- Date                 :       11/01/2013
-- Libellé              :        
-- Commentaires         :       Liste détaillée des réglements
-- Références           :       Variante de PS_S13_LSTREG pour GAN (VDoc7247) + VDoc10010
--
--				EURO
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
--				
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF  07/08/2020  [VDOC29539] 8200, 8201, 16100, 16101, 16300, 16301, 55100
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S013_LSTREG_GAN_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S013_LSTREG_GAN_V01
GO


CREATE procedure sysadm.PS_S013_LSTREG_GAN_V01
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      
	
AS

SET NOCOUNT ON

Select distinct 
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'LIB_POLICE'	= police.lib_police,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_ADH'	= ( convert ( varchar (6), sinistre.id_prod ) + '-' +
   		  Right ( '00000' + convert ( varchar (5), sinistre.id_ets ), 5 ) + '-' +
   		  Right ( Replicate ( '0', 19 ) + sinistre.id_adh, 19 ) + '-' +
  		  convert ( varchar (1), sinistre.id_sdos ) ),
 'DTE_ADH'	= sinistre.dte_adh,
 'DTE_FIN_GTI'  = sinistre.dte_fin_gti,
 'GA' 		= code_Gs.lib_code,
 'NS' 		= code_Ns.lib_code,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'MT_PREJ_GTI'  = gar_sin.mt_tot_prej,
 'VAL_ACHAT'    = ( Select IsNull (max ( d.mt_val_achat),0 )
  		    From   detail d
  		    Where  d.id_sin = sinistre.id_sin
 		    And    d.id_gti = gar_sin.id_gti ),
 'VAL_PUBLIQUE' = ( Select IsNull (max ( d.mt_val_publique),0 )
 		    From   detail d
 		    Where  d.id_sin = sinistre.id_sin
 		    And    d.id_gti = gar_sin.id_gti ),		    
 'DTE_REG'	= reg_gti.maj_le,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'LIB_PROD'	= produit.lib_long,
 'ID_REG'	= reg_gti.id_reg,
 'TYP_REGL'	= sysadm.FN_CODE_CAR(reglement.cod_mode_reg, '-MR'), -- [DCMP080675]
 'DEST_REG'	= inter.nom,
 'ETAT_MACHINE_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_dec_mac,'-ET'),
 'ETAT_OPER_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_dec_ope,'-ET'),
 'ETAT_FINAL_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_etat,'-ET'),
 'FORCAGE'=Case When gar_sin.cod_dec_mac=200 and gar_sin.cod_etat=600 Then 'Dossier forçé par le responsable' Else '' End
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne,
 sysadm.inter 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_gti	=	reg_gti.id_gti	 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
  ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
-- ( sinistre.id_prod	in ( 551, 16100, 16101, 55100 )			)	and
-- [DCMP080611] remplacé par :
 ( produit.id_prod	=	sinistre.id_prod		)	and
  produit.id_prod not in (551,5707,5709,5710,5711,5712,5720,5721,5722,5723,
5724,5725,5726,5727,5728,5729,5730,5731,5732,5733,6900,
8300,11001,11101,11300,11400,13700,14000,14300,14500,14600,15200,15600,
15800,15900,16200,16500,17800,24600,38300,57600) and -- [VDoc9436] Ajout du produit 72200
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) )  and
-- :[BUG20080728].COD_MODE_REG  JFF
 ( inter.id_sin 	= 	sinistre.id_sin		)	and
 ( inter.id_i 		= 	reglement.id_i		)	and 
 compagnie.id_cie in (2,12,66,67) 

UNION ALL

-- Select 2 COD_ADH = 3 (par carte)
Select distinct
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'LIB_POLICE'	= police.lib_police,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_ADH'	= ( convert ( varchar (6), sinistre.id_prod ) + '-' +
    		  Right ( '00000' + convert ( varchar (5), sinistre.id_ets ), 5 ) + '-' +
    		  Right ( Replicate ( '0', 19 ) + sinistre.id_adh, 19 ) + '-' +
   		  convert ( varchar (1), sinistre.id_sdos ) ),
 'DTE_ADH'	= sinistre.dte_adh, 
 'DTE_FIN_GTI'  = sinistre.dte_fin_gti,
 'GA' 		= code_Nf.lib_code,
 'NS' 		= code_Ns.lib_code,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'MT_PREJ_GTI'  = 0,
 'VAL_ACHAT'    = 0,
 'VAL_PUBLIQUE' = 0,
 'DTE_REG'	= reg_gti.maj_le,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'LIB_PROD'	= produit.lib_long,
 'ID_REG'	= reg_gti.id_reg,
 'TYP_REGL'	= sysadm.FN_CODE_CAR(reglement.cod_mode_reg, '-MR'), -- [DCMP080675]
 'DEST_REG'	= inter.nom,
 'ETAT_MACHINE_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_dec_mac,'-ET'),
 'ETAT_OPER_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_dec_ope,'-ET'),
 'ETAT_FINAL_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_etat,'-ET'),
 'FORCAGE'=Case When gar_sin.cod_dec_mac=200 and gar_sin.cod_etat=600 Then 'Dossier forçé par le responsable' Else '' End
 
From
 sysadm.reglement ,
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.inter ,
 sysadm.gar_sin
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( reglement.id_sin     =       reg_gti.id_sin		)	and
 ( reglement.id_reg     =       reg_gti.id_reg		)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
  produit.id_prod not in (551,5707,5709,5710,5711,5712,5720,5721,5722,5723,
5724,5725,5726,5727,5728,5729,5730,5731,5732,5733,6900,
8300,11001,11101,11300,11400,13700,14000,14300,14500,14600,15200,15600,
15800,15900,16200,16500,17800,24600,38300,57600) and -- [VDoc9436] Ajout du produit 72200
( produit.id_dept	=	departement.id_dept	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
-- ( sinistre.id_prod	in ( 551, 16100, 16101, 55100 )			)	and
-- [DCMP080611] remplacé par :
 ( produit.id_prod	=	sinistre.id_prod		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) )  and
-- :[BUG20080728].COD_MODE_REG  JFF
 ( inter.id_sin 	= 	sinistre.id_sin		)	and
 ( inter.id_i 		= 	reglement.id_i		)	and 
 compagnie.id_cie in (2,12,66,67) 				and
 ( gar_sin.id_sin = sinistre.id_sin 	)	and
 ( garantie.id_gti	=	gar_sin.id_gti)


UNION ALL

-- Select 3 COD_ADH = 3 (par carte)
Select distinct
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'LIB_POLICE'	= police.lib_police,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_ADH'	= ( convert ( varchar (6), sinistre.id_prod ) + '-' +
    		  Right ( '00000' + convert ( varchar (5), sinistre.id_ets ), 5 ) + '-' +
    		  Right ( Replicate ( '0', 19 ) + sinistre.id_adh, 19 ) + '-' +
   		  convert ( varchar (1), sinistre.id_sdos ) ),
 'DTE_ADH'	= sinistre.dte_adh,  		  
 'DTE_FIN_GTI'  = sinistre.dte_fin_gti,
 'GA' 		= 'REGULARISATION',
 'NS' 		= code_Ns.lib_code,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'MT_PREJ_GTI'  = 0,
 'VAL_ACHAT'    = 0,
 'VAL_PUBLIQUE' = 0,
 'DTE_REG'	= reglement.dte_reg,
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'LIB_PROD'	= produit.lib_long, 		    
 'ID_REG'	= reglement.id_reg,
 'TYP_REGL'	= sysadm.FN_CODE_CAR(reglement.cod_mode_reg, '-MR'), -- [DCMP080675]
 'DEST_REG'	= inter.nom,
 'ETAT_MACHINE_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_dec_mac,'-ET'),
 'ETAT_OPER_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_dec_ope,'-ET'),
 'ETAT_FINAL_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_etat,'-ET'),
 'FORCAGE'=Case When gar_sin.cod_dec_mac=200 and gar_sin.cod_etat=600 Then 'Dossier forçé par le responsable' Else '' End
 
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.code code_Ns,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.inter, 
 sysadm.gar_sin
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
-- ( sinistre.id_prod	in ( 551, 16100, 16101, 55100 )			)	and
-- [DCMP080611] remplacé par :
 ( produit.id_prod	=	sinistre.id_prod		)	and
  produit.id_prod not in (551,5707,5709,5710,5711,5712,5720,5721,5722,5723,
5724,5725,5726,5727,5728,5729,5730,5731,5732,5733,6900,
8300,11001,11101,11300,11400,13700,14000,14300,14500,14600,15200,15600,
15800,15900,16200,16500,17800,24600,38300,57600) --[VDoc9436] Ajout du produit 72200
 and( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) )  and
-- :[BUG20080728].COD_MODE_REG  JFF
 ( inter.id_sin 	= 	sinistre.id_sin		)	and
 ( inter.id_i 		= 	reglement.id_i		)	and 
 compagnie.id_cie in (2,12,66,67) 				and
 ( gar_sin.id_sin = sinistre.id_sin 	)	and
 ( garantie.id_gti	=	gar_sin.id_gti)

go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S013_LSTREG
-- Auteur               :       JF FABRY
-- Date                 :       26/12/2005
-- Libellé              :        
-- Commentaires         :       Liste détaillée des réglements
-- Références           :       Variante de PS_S11_LSTREG pour GAN (DCMP050537)
--
--				EURO
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
--				
-- Retourne             :       Rien
-- [BUG20080728].COD_MODE_REG  JFF
-- [DCMP080611] le 05/08/2008  PHG Refonte de cet etat et éclatement par produit
-------------------------------------------------------------------
-- #1 - FPI - 04/12/2009 - [EXPANSION5.LIB_POLICE] 
-- #2 - FPI - 07/04/2011 - [DCMP100588] Ajout du destinataire règlement
-- JFF      06/10/2014   [PM266]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S013_LSTREG' AND type = 'P' )
        DROP procedure sysadm.PS_S013_LSTREG
GO

CREATE procedure sysadm.PS_S013_LSTREG 
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      ,
	@dcIdProd	Decimal(7)
	
AS

SET NOCOUNT ON

Declare	@sCodAdh Char(1)


Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- [DCMP080611] On remet la distinction par cod_adh via un IF ...
-- et non pas par jointure...
-- Chaque cas se compose de trois select avec Union All
-- Je raméne dans un premier temps le détail du réglement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les réguls effectuées
--******************************************************************
--

If ( @sCodAdh = '3' ) 		-- Adhesions par carte
BEGIN
-- Select 1 COD_ADH = 3 (par carte)
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'LIB_POLICE'	= police.lib_police,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_ADH'	= ( convert ( varchar (6), sinistre.id_prod ) + '-' +
   		  Right ( '00000' + convert ( varchar (5), sinistre.id_ets ), 5 ) + '-' +
   		  Right ( Replicate ( '0', 19 ) + sinistre.id_adh, 19 ) + '-' +
  		  convert ( varchar (1), sinistre.id_sdos ) ),
 'DTE_ADH'	= sinistre.dte_adh,
 'DTE_FIN_GTI'  = sinistre.dte_fin_gti,
 'GA' 		= code_Gs.lib_code,
 'NS' 		= code_Ns.lib_code,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'MT_PREJ_GTI'  = gar_sin.mt_tot_prej,
 'VAL_ACHAT'    = ( Select IsNull (max ( d.mt_val_achat),0 )
  		    From   detail d
  		    Where  d.id_sin = sinistre.id_sin
 		    And    d.id_gti = gar_sin.id_gti ),
 'VAL_PUBLIQUE' = ( Select IsNull (max ( d.mt_val_publique),0 )
 		    From   detail d
 		    Where  d.id_sin = sinistre.id_sin
 		    And    d.id_gti = gar_sin.id_gti ),		    
 'DTE_REG'	= reg_gti.maj_le,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'LIB_PROD'	= produit.lib_long,
 'ID_REG'	= reg_gti.id_reg,
 'TYP_REGL'	= sysadm.FN_CODE_CAR(reglement.cod_mode_reg, '-MR'), -- [DCMP080675]
 'DEST_REG'	= inter.nom
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne,
 sysadm.inter 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_gti	=	reg_gti.id_gti	 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
-- ( sinistre.id_prod	in ( 551, 16100, 16101, 55100 )			)	and
-- [DCMP080611] remplacé par :
 ( produit.id_prod	=	@dcIdProd		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) )  and
-- :[BUG20080728].COD_MODE_REG  JFF
 ( inter.id_sin 	= 	sinistre.id_sin		)	and
 ( inter.id_i 		= 	reglement.id_i		)	
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 

UNION ALL

-- Select 2 COD_ADH = 3 (par carte)
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'LIB_POLICE'	= police.lib_police,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_ADH'	= ( convert ( varchar (6), sinistre.id_prod ) + '-' +
    		  Right ( '00000' + convert ( varchar (5), sinistre.id_ets ), 5 ) + '-' +
    		  Right ( Replicate ( '0', 19 ) + sinistre.id_adh, 19 ) + '-' +
   		  convert ( varchar (1), sinistre.id_sdos ) ),
 'DTE_ADH'	= sinistre.dte_adh, 
 'DTE_FIN_GTI'  = sinistre.dte_fin_gti,
 'GA' 		= code_Nf.lib_code,
 'NS' 		= code_Ns.lib_code,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'MT_PREJ_GTI'  = 0,
 'VAL_ACHAT'    = 0,
 'VAL_PUBLIQUE' = 0,
 'DTE_REG'	= reg_gti.maj_le,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'LIB_PROD'	= produit.lib_long,
 'ID_REG'	= reg_gti.id_reg,
 'TYP_REGL'	= sysadm.FN_CODE_CAR(reglement.cod_mode_reg, '-MR'), -- [DCMP080675]
 'DEST_REG'	= inter.nom
 
From
 sysadm.reglement ,
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.inter 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( reglement.id_sin     =       reg_gti.id_sin		)	and
 ( reglement.id_reg     =       reg_gti.id_reg		)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
-- ( sinistre.id_prod	in ( 551, 16100, 16101, 55100 )			)	and
-- [DCMP080611] remplacé par :
 ( produit.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) )  and
-- :[BUG20080728].COD_MODE_REG  JFF
 ( inter.id_sin 	= 	sinistre.id_sin		)	and
 ( inter.id_i 		= 	reglement.id_i		)	

  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 

UNION ALL

-- Select 3 COD_ADH = 3 (par carte)
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'LIB_POLICE'	= police.lib_police,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_ADH'	= ( convert ( varchar (6), sinistre.id_prod ) + '-' +
    		  Right ( '00000' + convert ( varchar (5), sinistre.id_ets ), 5 ) + '-' +
    		  Right ( Replicate ( '0', 19 ) + sinistre.id_adh, 19 ) + '-' +
   		  convert ( varchar (1), sinistre.id_sdos ) ),
 'DTE_ADH'	= sinistre.dte_adh,  		  
 'DTE_FIN_GTI'  = sinistre.dte_fin_gti,
 'GA' 		= 'REGULARISATION',
 'NS' 		= code_Ns.lib_code,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'MT_PREJ_GTI'  = 0,
 'VAL_ACHAT'    = 0,
 'VAL_PUBLIQUE' = 0,
 'DTE_REG'	= reglement.dte_reg,
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'LIB_PROD'	= produit.lib_long, 		    
 'ID_REG'	= reglement.id_reg,
 'TYP_REGL'	= sysadm.FN_CODE_CAR(reglement.cod_mode_reg, '-MR'), -- [DCMP080675]
 'DEST_REG'	= inter.nom
 
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.inter 
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
-- ( sinistre.id_prod	in ( 551, 16100, 16101, 55100 )			)	and
-- [DCMP080611] remplacé par :
 ( produit.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) )  and
-- :[BUG20080728].COD_MODE_REG  JFF
 ( inter.id_sin 	= 	sinistre.id_sin		)	and
 ( inter.id_i 		= 	reglement.id_i		)	
   -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 
 
END
ELSE
BEGIN
-- Select 1 COD_ADH <> 3 (adhesion SPB ou hors carte)
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'LIB_POLICE'	= police.lib_police,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_ADH'	= ( convert ( varchar (6), sinistre.id_prod ) + '-' +
   		  Right ( '00000' + convert ( varchar (5), sinistre.id_ets ), 5 ) + '-' +
   		  Right ( Replicate ( '0', 19 ) + sinistre.id_adh , 19 ) + '-' +
  		  convert ( varchar (1), sinistre.id_sdos ) ),
 'DTE_ADH'	= sinistre.dte_adh,
 'DTE_FIN_GTI'  = sinistre.dte_fin_gti,
 'GA' 		= code_Gs.lib_code,
 'NS' 		= code_Ns.lib_code,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'MT_PREJ_GTI'  = gar_sin.mt_tot_prej,
 'VAL_ACHAT'    = ( Select IsNull (max ( d.mt_val_achat),0 )
  		    From   detail d
  		    Where  d.id_sin = sinistre.id_sin
 		    And    d.id_gti = gar_sin.id_gti ),
 'VAL_PUBLIQUE' = ( Select IsNull (max ( d.mt_val_publique),0 )
 		    From   detail d
 		    Where  d.id_sin = sinistre.id_sin
 		    And    d.id_gti = gar_sin.id_gti ),		    
 'DTE_REG'	= reg_gti.maj_le,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'LIB_PROD'	= produit.lib_long, 		    
 'ID_REG'	= reg_gti.id_reg,
 'TYP_REGL'	= sysadm.FN_CODE_CAR(reglement.cod_mode_reg, '-MR'), -- [DCMP080675]
 'DEST_REG'	= inter.nom
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne,
 sysadm.inter 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( reg_gti.id_sin	=	gar_sin.id_sin		)	and
 ( reg_gti.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
-- ( sinistre.id_prod	in ( 3601, 3603, 5731, 5732, 5733, 8200, 8201) )	and
-- [DCMP080611] remplacé par :
 ( produit.id_prod	=	@dcIdProd		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) )  and
-- :[BUG20080728].COD_MODE_REG  JFF
 ( inter.id_sin 	= 	sinistre.id_sin		)	and
 ( inter.id_i 		= 	reglement.id_i		)	
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 
	  
UNION ALL

-- Select 2 COD_ADH <> 3 (adhesion SPB ou hors carte)
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'LIB_POLICE'	= police.lib_police,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_ADH'	= ( convert ( varchar (6), sinistre.id_prod ) + '-' +
    		  Right ( '00000' + convert ( varchar (5), sinistre.id_ets ), 5 ) + '-' +
    		  Right ( Replicate ( '0', 19 ) + sinistre.id_adh, 19 ) + '-' +
   		  convert ( varchar (1), sinistre.id_sdos ) ),
 'DTE_ADH'	= sinistre.dte_adh,
 'DTE_FIN_GTI'  = sinistre.dte_fin_gti,
 'GA' 		= code_Nf.lib_code,
 'NS' 		= code_Ns.lib_code,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'MT_PREJ_GTI'  = 0,
 'VAL_ACHAT' 	= 0,
 'VAL_PUBLIQUE' = 0,
 'DTE_REG'	= reg_gti.maj_le,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'LIB_PROD'	= produit.lib_long, 		    
 'ID_REG'	= reg_gti.id_reg,
 'TYP_REGL'	= sysadm.FN_CODE_CAR(reglement.cod_mode_reg, '-MR'), -- [DCMP080675]
 'DEST_REG'	= inter.nom
From
 sysadm.reglement   ,
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.inter 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( reglement.id_sin 	=       reg_gti.id_sin		)       and
 ( reglement.id_reg     =       reg_gti.id_reg        	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
-- ( sinistre.id_prod	in ( 3601, 3603, 5731, 5732, 5733, 8200, 8201 ) )	and
-- [DCMP080611] remplacé par :
 ( produit.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and
-- :[BUG20080728].COD_MODE_REG  JFF
 ( inter.id_sin 	= 	sinistre.id_sin		)	and
 ( inter.id_i 		= 	reglement.id_i		)	
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 
	  
UNION ALL

-- Select 3 COD_ADH <> 3 (adhesion SPB ou hors carte)
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'LIB_POLICE'	= police.lib_police,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_ADH'	= ( convert ( varchar (6), sinistre.id_prod ) + '-' +
    		  Right ( '00000' + convert ( varchar (5), sinistre.id_ets ), 5 ) + '-' +
    		  Right ( Replicate ( '0', 19 ) + sinistre.id_adh, 19 ) + '-' +
   		  convert ( varchar (1), sinistre.id_sdos ) ),
 'DTE_ADH'	= sinistre.dte_adh,
 'DTE_FIN_GTI'  = sinistre.dte_fin_gti,
 'GA' 		= 'REGULARISATION',
 'NS' 		= code_Ns.lib_code,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'MT_PREJ_GTI'  = 0,
 'VAL_ACHAT' 	= 0,
 'VAL_PUBLIQUE' = 0,
 'DTE_REG'	= reglement.dte_reg,
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'LIB_PROD'	= produit.lib_long, 		    
 'ID_REG'	= reglement.id_reg,
 'TYP_REGL'	= sysadm.FN_CODE_CAR(reglement.cod_mode_reg, '-MR'), -- [DCMP080675]
 'DEST_REG'	= inter.nom
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.inter
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
-- ( sinistre.id_prod	in ( 3601, 3603, 5731, 5732, 5733, 8200, 8201 ) )	and
-- [DCMP080611] remplacé par :
 ( produit.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and
-- :[BUG20080728].COD_MODE_REG  JFF
 ( inter.id_sin 	= 	sinistre.id_sin		)	and
 ( inter.id_i 		= 	reglement.id_i		)	
   -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 
	  
END

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S02_LSTREG
-- Auteur               :       DBI
-- Date                 :       08/12/1998
-- Libellé              :        
-- Commentaires         :       Liste d‚taill‚e des rŠglements pour un ‚tablissement
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
--				@dcIdEts	Decimal(7)		(Val)
-- Retourne             :       Rien
-- [BUG20080728].COD_MODE_REG  JFF
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_LSTREG' AND type = 'P' )
        DROP procedure sysadm.PS_S02_LSTREG
GO

CREATE procedure sysadm.PS_S02_LSTREG
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      ,
	@dcIdProd	Decimal(7)	,
	@dcIdEts	Decimal(7)	WITH RECOMPILE

AS

SET NOCOUNT ON

Declare	@sCodAdh Char(1)


Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramŠne dans un premier temps le d‚tail du rŠglement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les r‚guls effectu‚es
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ID_DETAIL'	= detail.id_detail,
 'MT_PREJ'	= detail.mt_prej,
 'MT_PLAF'	= detail.mt_plaf,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'DTE_DET'	= detail.dte_det,
 'EV' 		= code_Ev.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.detail    ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.code code_Ev,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 

Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	detail.id_sin		)	and
 ( reg_gti.id_reg	=	detail.id_reg		)	and
 ( reg_gti.id_gti	=	detail.id_gti		)	and
 ( reg_gti.id_rgpt	=	( Case detail.id_gti
				When 7 Then
					Case 
					 When detail.id_evt between 700 and 719 then 700
					 When detail.id_evt between 720 and 739 then 720
					 Else 740
					End
				Else	detail.id_gti
				End )			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( detail.id_sin	=	gar_sin.id_sin		)	and
 ( detail.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( code_Ev.id_typ_code	=	'+EV'			)	and
 ( code_Ev.id_code	=	detail.id_evt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( sinistre.id_ets	=	@dcIdEts		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF

UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ID_DETAIL'	= frais.id_frais,
 'MT_PREJ'	= frais.mt_frais,
 'MT_PLAF'	= frais.mt_frais,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= code_Nf.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( sinistre.id_ets	=	@dcIdEts		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF


UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= 'REGULARISATION',
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ID_DETAIL'	= 0,
 'MT_PREJ'	= 0,
 'MT_PLAF'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= reglement.lib_reg,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( sinistre.id_ets	=	@dcIdEts		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF


END

Else				-- Adhesions SPB ou autres hors carte

BEGIN

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ID_DETAIL'	= detail.id_detail,
 'MT_PREJ'	= detail.mt_prej,
 'MT_PLAF'	= detail.mt_plaf,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'DTE_DET'	= detail.dte_det,
 'EV' 		= code_Ev.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.detail    ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.code code_Ev,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	detail.id_sin		)	and
 ( reg_gti.id_reg	=	detail.id_reg		)	and
 ( reg_gti.id_gti	=	detail.id_gti		)	and
 ( reg_gti.id_rgpt	=	( Case detail.id_gti
				When 7 Then
					Case 
					 When detail.id_evt between 700 and 719 then 700
					 When detail.id_evt between 720 and 739 then 720
					 Else 740
					End
				Else	detail.id_gti
				End )			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( detail.id_sin	=	gar_sin.id_sin		)	and
 ( detail.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( code_Ev.id_typ_code	=	'+EV'			)	and
 ( code_Ev.id_code	=	detail.id_evt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( groupe.id_grp	=	@dcIdEts		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF

UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ID_DETAIL'	= frais.id_frais,
 'MT_PREJ'	= frais.mt_frais,
 'MT_PLAF'	= frais.mt_frais,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= code_Nf.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 

Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( groupe.id_grp	=	@dcIdEts		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF

UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= 'REGULARISATION',
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ID_DETAIL'	= 0,
 'MT_PREJ'	= 0,
 'MT_PLAF'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= reglement.lib_reg,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF


END

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S03_LSTREG
-- Auteur               :       JFF
-- Date                 :       22/01/1999
-- Libellé              :       Liste d‚taill‚e des rŠglements uniquement pour les adh‚sions par carte 
--				affichant le num‚ro de carte et le nom du sinistr‚.
-- Commentaires         :       Par rapport au requˆte pr‚c‚dente du mˆme type, je rajoute seulement le rappatriement
--				du nom, pr‚nom, et num‚ro de carte de l'assur‚.
--				Si id_ets = -1 on ramŠne toutes les banques du produit
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
--				@dcIdEts	Decimal(7)		(Val)
-- Retourne             :       Rien
-- [BUG20080728].COD_MODE_REG  JFF
-------------------------------------------------------------------
-- #1 - FPI - 04/12/2009 - [EXPANSION5.LIB_POLICE] 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S03_LSTREG' AND type = 'P' )
        DROP procedure sysadm.PS_S03_LSTREG
GO

CREATE procedure sysadm.PS_S03_LSTREG
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      ,
	@dcIdProd	Decimal(7)      ,
	@dcIdEts	Decimal(7)	WITH RECOMPILE

AS

SET NOCOUNT ON

Declare	@sCodAdh Char(1)


Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramŠne dans un premier temps le d‚tail du rŠglement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les r‚guls effectu‚es
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'NUM_CARTE'	= sinistre.id_adh,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ID_DETAIL'	= detail.id_detail,
 'MT_PREJ'	= detail.mt_prej,
 'MT_PLAF'	= detail.mt_plaf,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'DTE_DET'	= detail.dte_det,
 'EV' 		= code_Ev.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.detail    ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.code code_Ev,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	detail.id_sin		)	and
 ( reg_gti.id_reg	=	detail.id_reg		)	and
 ( reg_gti.id_gti	=	detail.id_gti		)	and
 ( reg_gti.id_rgpt	=	( Case detail.id_gti
				When 7 Then
					Case 
					 When detail.id_evt between 700 and 719 then 700
					 When detail.id_evt between 720 and 739 then 720
					 Else 740
					End
				Else	detail.id_gti
				End )			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( detail.id_sin	=	gar_sin.id_sin		)	and
 ( detail.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( sinistre.id_ets	= 	( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( code_Ev.id_typ_code	=	'+EV'			)	and
 ( code_Ev.id_code	=	detail.id_evt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre	=	sinistre.id_ordre	)	and

 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'NUM_CARTE'	= sinistre.id_adh,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ID_DETAIL'	= frais.id_frais,
 'MT_PREJ'	= frais.mt_frais,
 'MT_PLAF'	= frais.mt_frais,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= code_Nf.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 

Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( sinistre.id_ets	= 	( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre	=	sinistre.id_ordre	)	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 
	

UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'NUM_CARTE'	= sinistre.id_adh,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= 'REGULARISATION',
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ID_DETAIL'	= 0,
 'MT_PREJ'	= 0,
 'MT_PLAF'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= reglement.lib_reg,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( sinistre.id_ets	= 	( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre	=	sinistre.id_ordre	)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


END

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S07_LSTRI
-- Auteur               :       Abdmeziem Catherine
-- Date                 :       28/10/2003
-- Libellé              :        
-- Commentaires         :       Liste détaillée des RI ultérieurs au 26/11/2003
--				dont le reglt lié est antérieur au 26/11/2003
--				(chgt de compte sur les produits cités ds DMDI 9793)
-- Références           :       
--
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 - FPI - 09/12/2009 - [EXPANSION5.LIB_POLICE] 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S07_LSTRI' AND type = 'P' )
        DROP procedure sysadm.PS_S07_LSTRI
GO

CREATE procedure sysadm.PS_S07_LSTRI
        @dtDteDeb       DateTime        ,
        @dtDteFin       DateTime

AS

	SELECT	ri.id_sin Dossier,
		ri.id_reg N_Reg_RI,
		ri.dte_reg Dte_Reg_RI,
		rn.id_reg N_Reg_RN,
		rn.dte_reg Dte_Reg_RN,
		s.id_prod Produit,
		p.lib_long Lib_Produit,
		po.lib_police Lib_Police,
		cie.lib_cie Lib_Assureur
	FROM reglement ri,
		sinistre s,
		reglement rn,
		produit p,
		reg_gti rg,
		garantie g,
		police po,
		compagnie cie
	WHERE ri.cod_mot_reg = 'RI'
	  AND ri.dte_reg >= '26/11/2003 0:00'
	  AND rn.dte_reg < '26/11/2003 0:00'
	  AND ri.dte_reg BETWEEN @dtDteDeb AND @dtDteFin

	-- Et appartenant au Compte dédié AIG
	  AND p.rib_bq	= '30002'
	  AND p.rib_gui	= '06522'
	  AND p.rib_cpt	= '0000061704E'
	  AND p.rib_cle	= '94'		
	  AND s.id_sin = ri.id_sin
	  AND rn.id_sin = ri.id_sin
	  AND rn.id_reg = ri.id_reg_base
	  AND p.id_prod = s.id_prod
	  AND rg.id_sin = rn.id_sin
	  AND rg.id_reg = rn.id_reg
	  AND g.id_prod = s.id_prod
	  AND g.id_rev = s.id_rev
	  AND g.id_gti = rg.id_gti
	  AND po.id_police = g.id_police
	  AND cie.id_cie = po.id_cie
	ORDER BY s.id_sin
	
GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_DOSOUV
-- Auteur               :       DBI
-- Date                 :       28/12/98 15:37:00
-- Libellé              :       
-- Commentaires         :	Nombre de dossiers ouverts sur une p‚riode
-- Références           :       
--
-- Arguments            :       @dtDteDeb         Datetime,
--			        @dtDteFin	  Datetime,
--            		   	@dcIdProd         Decimal ( 7, 0 )
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DOSOUV' AND type = 'P' )
            DROP procedure sysadm.DW_S01_DOSOUV
GO

CREATE PROC sysadm.DW_S01_DOSOUV
            @dtDteDeb         Datetime,
            @dtDteFin	      Datetime,
            @dcIdProd         Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	DatePart ( Year, sinistre.dte_surv),
	groupe.id_grp,
	groupe.lib_grp,
	sinistre.id_natsin,
	CodeNatSin.lib_code,
	Count ( sinistre.id_sin )

FROM  	sysadm.produit,
	sysadm.sinistre,
	sysadm.groupe,
	sysadm.departement,
	sysadm.code CodeNatSin

WHERE 	( sinistre.id_prod 	= @dcIdProd					)  and
	( sinistre.id_prod 	= produit.id_prod				)  and
	( sinistre.dte_ouv  between @dtDteDeb and @dtDteFin			)  and
	( produit.cod_adh	= '3'						)  and
	( sinistre.id_ets	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= sinistre.id_natsin				)  
GROUP BY 
	produit.lib_long,
	departement.lib_dept,
	DatePart ( Year, sinistre.dte_surv),
	groupe.id_grp,
	groupe.lib_grp,
	sinistre.id_natsin,
	CodeNatSin.lib_code
		
UNION ALL

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	DatePart ( Year, sinistre.dte_surv),
	groupe.id_grp,
	groupe.lib_grp,
	sinistre.id_natsin,
	CodeNatSin.lib_code,
	Count ( sinistre.id_sin )

FROM  	sysadm.produit,
	sysadm.sinistre,
	sysadm.groupe,
	sysadm.departement,
	sysadm.etablissement,
	sysadm.code CodeNatSin

WHERE 	( sinistre.id_prod 	= @dcIdProd					)  and
	( sinistre.id_prod 	= produit.id_prod				)  and
	( sinistre.dte_ouv  between @dtDteDeb and @dtDteFin			)  and
	( produit.cod_adh	<> '3'						)  and
	( etablissement.id_prod = sinistre.id_prod				)  and
	( etablissement.id_ets  = sinistre.id_ets				)  and
	( etablissement.id_grp  = groupe.id_grp					)  and
	( etablissement.id_rev  = -1						)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= sinistre.id_natsin				)  
GROUP BY 
	produit.lib_long,
	departement.lib_dept,
	DatePart ( Year, sinistre.dte_surv),
	groupe.id_grp,
	groupe.lib_grp,
	sinistre.id_natsin,
	CodeNatSin.lib_code
	
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_DOSENCI
-- Auteur               :       DBI
-- Date                 :       28/12/98 15:37:00
-- Libellé              :       
-- Commentaires         :	Nombre de dossiers En cours d'instruction … fin p‚riode
-- Références           :       
--
-- Arguments            :       @dcPeriodeMax	  Decimal ( 7, 0 ),
--            		   	@dcIdProd         Decimal ( 7, 0 )
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DOSENCI' AND type = 'P' )
	drop procedure sysadm.DW_S01_DOSENCI
GO

CREATE PROC sysadm.DW_S01_DOSENCI
            @dcPeriodeMax	Decimal ( 7, 0 ),
	    @dcIdProd         	Decimal ( 7, 0 )

AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	DatePart ( Year, sinistre.dte_surv),
	groupe.id_grp,
	groupe.lib_grp,
	sinistre.id_natsin,
	CodeNatSin.lib_code,
	Count ( distinct stat_sin.id_sin )

FROM  	sysadm.produit,
	sysadm.sinistre,
	sysadm.groupe,
	sysadm.departement,
	sysadm.code CodeNatSin,
	sysadm.stat_sin

WHERE 	( sinistre.id_prod 	= @dcIdProd					)  and
	( sinistre.id_prod 	= produit.id_prod				)  and
	( stat_sin.id_sin	= sinistre.id_sin				)  and
	( stat_sin.id_periode	= @dcPeriodeMax					)  and
	( stat_sin.cod_etat	= 100						)  and
	( produit.cod_adh	= '3'						)  and
	( sinistre.id_ets	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= sinistre.id_natsin				)  and
	( Not Exists ( Select id_sin
		       From   sysadm.stat_sin stat_sin_b
		       Where  stat_sin_b.id_sin   = sinistre.id_sin
		       And    stat_sin_b.id_periode < @dcPeriodeMax 
		       And    stat_sin_b.cod_etat in ( 550, 600 ) ) )
		       
	
GROUP BY 
	produit.lib_long,
	departement.lib_dept,
	DatePart ( Year, sinistre.dte_surv),
	groupe.id_grp,
	groupe.lib_grp,
	sinistre.id_natsin,
	CodeNatSin.lib_code
		
UNION ALL

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	DatePart ( Year, sinistre.dte_surv),
	groupe.id_grp,
	groupe.lib_grp,
	sinistre.id_natsin,
	CodeNatSin.lib_code,
	Count ( distinct stat_sin.id_sin )

FROM  	sysadm.produit,
	sysadm.sinistre,
	sysadm.groupe,
	sysadm.departement,
	sysadm.etablissement,
	sysadm.code CodeNatSin,
	sysadm.stat_sin

WHERE 	( sinistre.id_prod 	= @dcIdProd					)  and
	( sinistre.id_prod 	= produit.id_prod				)  and
	( stat_sin.id_sin	= sinistre.id_sin				)  and
	( stat_sin.id_periode	= @dcPeriodeMax					)  and
	( stat_sin.cod_etat	= 100						)  and
	( produit.cod_adh	<> '3'						)  and
	( etablissement.id_prod = sinistre.id_prod				)  and
	( etablissement.id_ets  = sinistre.id_ets				)  and
	( etablissement.id_grp  = groupe.id_grp					)  and
	( etablissement.id_rev  = -1						)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= sinistre.id_natsin				)  and 
	( Not Exists ( Select id_sin
		       From   sysadm.stat_sin stat_sin_b
		       Where  stat_sin_b.id_sin   = sinistre.id_sin
		       And    stat_sin_b.id_periode < @dcPeriodeMax 
		       And    stat_sin_b.cod_etat in ( 550, 600 ) ) )
		       
GROUP BY 
	produit.lib_long,
	departement.lib_dept,
	DatePart ( Year, sinistre.dte_surv),
	groupe.id_grp,
	groupe.lib_grp,
	sinistre.id_natsin,
	CodeNatSin.lib_code

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_STATSIN_UF_PREPAR
-- Auteur               :       DBI
-- Date                 :       28/12/98 15:37:00
-- Libellé              :       
-- Commentaires         :	Nombre de dossiers garanties … fin p‚riode
-- Références           :       
--
-- Arguments            :       @dcPeriodeMax	  Decimal ( 7, 0 ),
--            		   	@dteFin		  Datetime,
--            		   	@dcIdProd         Decimal ( 7, 0 )
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_STATSIN_UF_PREPAR' AND type = 'P' )
	drop procedure sysadm.DW_S01_STATSIN_UF_PREPAR
GO

CREATE PROC sysadm.DW_S01_STATSIN_UF_PREPAR
            @dteFin		Datetime,
            @dcPeriodeMax	Decimal ( 7, 0 ),
	    @dcIdProd         	Decimal ( 7, 0 )

AS

SELECT 
	produit.lib_long,
	departement.lib_dept,
	DatePart ( Year, sinistre.dte_surv),
	stat_sin.id_gti,
	CodeGa.lib_code,
	groupe.id_grp,
	groupe.lib_grp,
	sinistre.id_natsin,
	CodeNatSin.lib_code,
	Count ( distinct stat_sin.id_sin )

FROM  	sysadm.produit,
	sysadm.sinistre,
	sysadm.groupe,
	sysadm.departement,
	sysadm.etablissement,
	sysadm.code CodeGa,
	sysadm.code CodeNatSin,
	sysadm.stat_sin

WHERE 	( sinistre.id_prod 	= @dcIdProd					)  and
	( sinistre.id_prod 	= produit.id_prod				)  and
	( stat_sin.id_sin	= sinistre.id_sin				)  and
	( stat_sin.id_periode	= @dcPeriodeMax					)  and
	( stat_sin.cod_etat	= 100						)  and
	( produit.cod_adh	<> '3'						)  and
	( etablissement.id_prod = sinistre.id_prod				)  and
	( etablissement.id_ets  = sinistre.id_ets				)  and
	( etablissement.id_grp  = groupe.id_grp					)  and
	( etablissement.id_rev  = -1						)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeGa.id_typ_code	= '-GA'						)  and
	( CodeGa.id_code	= stat_sin.id_gti				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= sinistre.id_natsin				)  and 
	( sinistre.dte_surv	>= DATEADD ( Month, -2, @dteFin )		)  and
	( stat_sin.id_gti	= 7 						)
		       
GROUP BY 
	produit.lib_long,
	departement.lib_dept,
	DatePart ( Year, sinistre.dte_surv),
	stat_sin.id_gti,
	CodeGa.lib_code,
	groupe.id_grp,
	groupe.lib_grp,
	sinistre.id_natsin,
	CodeNatSin.lib_code
	
GO



--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_STATSIN_UF_PREPAR
-- Auteur               :       DBI
-- Date                 :       28/12/98 15:37:00
-- Libellé              :       
-- Commentaires         :	Nombre de dossiers en cours … fin p‚riode avec particularit‚ Uf
-- Références           :       
--
-- Arguments            :       @dcPeriodeMax	  Decimal ( 7, 0 ),
--            		   	@dteFin		  Datetime,
--            		   	@dcIdProd         Decimal ( 7, 0 )
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_STATSIN_UF_PREPAR' AND type = 'P' )
	drop procedure sysadm.DW_S02_STATSIN_UF_PREPAR
GO

CREATE PROC sysadm.DW_S02_STATSIN_UF_PREPAR
            @dteFin		Datetime,
            @dcPeriodeMax	Decimal ( 7, 0 ),
	    @dcIdProd         	Decimal ( 7, 0 )

AS


SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	DatePart ( Year, sinistre.dte_surv),
	groupe.id_grp,
	groupe.lib_grp,
	sinistre.id_natsin,
	CodeNatSin.lib_code,
	Count ( distinct stat_sin.id_sin )

FROM  	sysadm.produit,
	sysadm.sinistre,
	sysadm.groupe,
	sysadm.departement,
	sysadm.etablissement,
	sysadm.code CodeNatSin,
	sysadm.stat_sin

WHERE 	( sinistre.id_prod 	= @dcIdProd					)  and
	( sinistre.id_prod 	= produit.id_prod				)  and
	( stat_sin.id_sin	= sinistre.id_sin				)  and
	( stat_sin.id_periode	= @dcPeriodeMax					)  and
	( stat_sin.cod_etat	= 100						)  and
	( produit.cod_adh	<> '3'						)  and
	( etablissement.id_prod = sinistre.id_prod				)  and
	( etablissement.id_ets  = sinistre.id_ets				)  and
	( etablissement.id_grp  = groupe.id_grp					)  and
	( etablissement.id_rev  = -1						)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= sinistre.id_natsin				)  and
	( 
	 ( stat_sin.id_gti	= 7 And sinistre.dte_surv     > DateAdd ( Month, -2, @dteFin ))  Or 
	 ( stat_sin.id_gti	<> 7						)  
	)						   	   		   and	
	( Not Exists ( Select id_sin
		       From   stat_sin stat_sin_b
		       Where  stat_sin_b.id_sin   = sinistre.id_sin
		       And    stat_sin_b.id_periode < @dcPeriodeMax
		       And    stat_sin_b.cod_etat in ( 550, 600 ) ) )
GROUP BY 
	produit.lib_long,
	departement.lib_dept,
	DatePart ( Year, sinistre.dte_surv),
	groupe.id_grp,
	groupe.lib_grp,
	sinistre.id_natsin,
	CodeNatSin.lib_code

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_FRAIS_EXPERTISE
-- Auteur               :       DBI
-- Date                 :       08/02/1998 15:37:00
-- Libellé              :       
-- Commentaires         :	Liste des frais expertise d'un produit
-- Références           :       
--
-- Arguments            :       @dteDeb		  Datetime,
--            		   	@dteFin		  Datetime,
--            		   	@dcIdProd         Decimal ( 7, 0 )
-- Retourne             :	Rien
-- [BUG20080728].COD_MODE_REG  JFF
-- JFF      06/10/2014   [PM266]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_FRAIS_EXPERTISE' AND type = 'P' )
	drop procedure sysadm.DW_S01_FRAIS_EXPERTISE
GO

CREATE PROC sysadm.DW_S01_FRAIS_EXPERTISE
			@dteDeb		  Datetime,
			@dteFin		  Datetime,
			@dcIdProd         integer
AS

 Declare @dcIdProd2 Decimal ( 7 )
 
 Set @dcIdProd2 = Convert ( Decimal ( 7 ), @dcIdProd )

 select produit.lib_long, departement.lib_dept, sinistre.id_sin, personne.nom, personne.prenom, frais.mt_frais
 from   sysadm.reglement, sysadm.frais, sysadm.produit, sysadm.sinistre, sysadm.personne, sysadm.departement
 where  reglement.id_sin = frais.id_sin
 and    reglement.id_reg = frais.id_reg
 and    reglement.dte_reg between @dteDeb and @dteFin
 and    frais.id_typ_frais = 10
 and    reglement.id_sin   = sinistre.id_sin
 and    personne.id_ordre  = sinistre.id_ordre
 and    produit.id_prod    = sinistre.id_prod
 and	departement.id_dept= produit.id_dept
 and    sinistre.id_prod   = @dcIdProd2
-- [BUG20080728].COD_MODE_REG  JFF
 and   ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
 and   ( reglement.cod_mot_reg not in ( 'RI' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S04_LSTREG_TEL
-- Auteur               :       FABRY JF
-- Date                 :       29/05/1998
-- Libellé              :        
-- Commentaires         :       Liste d‚taill‚e des rŠglements pour la téléphonie
-- Références           :       
--
--				EURO
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
-- [BUG20080728].COD_MODE_REG  JFF
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S04_LSTREG_TEL' AND type = 'P' )
        DROP procedure sysadm.PS_S04_LSTREG_TEL
GO

CREATE procedure sysadm.PS_S04_LSTREG_TEL
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal ( 7, 0 ),
	@dcPeriodeFin   Decimal ( 7, 0 ),
	@dcIdProd	Decimal ( 7, 0 ) WITH RECOMPILE

AS

/* 
   Gestion de l'euro, si prod négatif, état en Euro,
   si prod positif, état en Francs Francais.
*/
Declare @dcTaux Decimal ( 6,5 )

Select  @dcTaux = 1              
If @dcIdProd < 0 
 Begin
  Select  @dcTaux = 6.55957
  Select  @dcIdProd = @dcIdProd * (-1)
 End

SET NOCOUNT ON

Declare	@sCodAdh Char(1)


Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramŠne dans un premier temps le d‚tail du rŠglement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les r‚guls effectu‚es
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN

Select
 'PERIODE_DEB' 	= @dcPeriodeDeb,
 'PERIODE_FIN'	= @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'ID_ADH' 	= sinistre.id_adh, 
 'ID_SDOS' 	= sinistre.id_sdos, 
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG'	= reg_gti.mt_reg / @dcTaux,
 'ID_DETAIL'	= detail.id_detail,
 'MT_PREJ'	= detail.mt_prej / @dcTaux,
 'MT_PLAF'	= detail.mt_plaf / @dcTaux,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'DTE_DET'	= detail.dte_det,
 'EV' 		= code_Ev.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'NOM_ADHERENT' = RTrim ( LTrim ( personne.nom ) ) ,
 'PRENOM_ADHERENT' = RTrim ( LTrim ( personne.prenom ) ),
 'DTE_CMD'	= detail.dte_cmd,
 'DTE_LIVR'	= detail.dte_livr,
 'DEST_REG'	= inter_reg.nom,
 'COD_ETAT'	= sinistre.cod_etat,
 'LIB_ETAT'	= code_Et.lib_code,
 'NUM_PORT'	= sinistre.num_port,
 'NUM_IMEI_PORT'= sinistre.num_imei_port,
 'MARQ_PORT'	= sinistre.marq_port,
 'MODL_PORT'	= sinistre.modl_port,
 'DTE_ACH_PORT'	= sinistre.dte_ach_port,
 'DTE_OUVLIG_PORT' = sinistre.dte_ouvlig_port,
 'DTE_ADHESION' = sinistre.dte_adh,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
 
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.detail    ,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.code code_Ev,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.personne,
 sysadm.inter	inter_reg,
 sysadm.code code_Et,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 

Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	detail.id_sin		)	and
 ( reg_gti.id_reg	=	detail.id_reg		)	and
 ( reg_gti.id_gti	=	detail.id_gti		)	and
 ( reg_gti.id_rgpt	=	( Case detail.id_gti
				When 7 Then
					Case 
					 When detail.id_evt between 700 and 719 then 700
					 When detail.id_evt between 720 and 739 then 720
					 Else 740
					End
				Else	detail.id_gti
				End )			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( detail.id_sin	=	gar_sin.id_sin		)	and
 ( detail.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( code_Ev.id_typ_code	=	'+EV'			)	and
 ( code_Ev.id_code	=	detail.id_evt		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( inter_reg.id_sin	= 	sinistre.id_sin		)	and
 ( inter_reg.id_i	= 	detail.id_i_reg		)	and
 ( code_Et.id_typ_code	=	'-ET'			)	and
 ( code_Et.id_code	=	sinistre.cod_etat	)	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 


UNION ALL

Select
 'PERIODE_DEB' 	= @dcPeriodeDeb,
 'PERIODE_FIN'	= @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'ID_ADH' 	= sinistre.id_adh, 
 'ID_SDOS' 	= sinistre.id_sdos,  
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG'	= reg_gti.mt_reg / @dcTaux,
 'ID_DETAIL'	= frais.id_frais,
 'MT_PREJ'	= frais.mt_frais / @dcTaux,
 'MT_PLAF'	= frais.mt_frais / @dcTaux,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= code_Nf.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'NOM_ADHERENT' = RTrim ( LTrim ( personne.nom ) ) ,
 'PRENOM_ADHERENT' = RTrim ( LTrim ( personne.prenom ) ),
 'DTE_CMD'	= null,
 'DTE_LIVR'	= null,
 'DEST_REG'	= inter_reg.nom,
 'COD_ETAT'	= sinistre.cod_etat,
 'LIB_ETAT'	= code_Et.lib_code,
 'NUM_PORT'	= sinistre.num_port,
 'NUM_IMEI_PORT'= sinistre.num_imei_port,
 'MARQ_PORT'	= sinistre.marq_port,
 'MODL_PORT'	= sinistre.modl_port,
 'DTE_ACH_PORT'	= sinistre.dte_ach_port,
 'DTE_OUVLIG_PORT' = sinistre.dte_ouvlig_port,
 'DTE_ADHESION' = sinistre.dte_adh,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique

From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.personne,
 sysadm.inter	inter_reg,
 sysadm.code code_Et,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 



Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( inter_reg.id_sin	= 	sinistre.id_sin		)	and
 ( inter_reg.id_i	= 	reg_gti.id_i		)	and
 ( code_Et.id_typ_code	=	'-ET'			)	and
 ( code_Et.id_code	=	sinistre.cod_etat	)	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 

UNION ALL
Select
 'PERIODE_DEB' 	= @dcPeriodeDeb,
 'PERIODE_FIN'	= @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'ID_ADH' 	= sinistre.id_adh, 
 'ID_SDOS' 	= sinistre.id_sdos, 
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= 'REGULARISATION',
 'MT_REG'	= reglement.mt_tot_reg / @dcTaux,
 'ID_DETAIL'	= 0,
 'MT_PREJ'	= 0,
 'MT_PLAF'	= reglement.mt_tot_reg / @dcTaux,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= reglement.lib_reg,
 'LIB_GRP'	= groupe.lib_grp,
 'NOM_ADHERENT' = RTrim ( LTrim ( personne.nom ) ) ,
 'PRENOM_ADHERENT' = RTrim ( LTrim ( personne.prenom ) ),
 'DTE_CMD'	= null,
 'DTE_LIVR'	= null,
 'DEST_REG'	= inter_reg.nom,
 'COD_ETAT'	= sinistre.cod_etat,
 'LIB_ETAT'	= code_Et.lib_code,
 'NUM_PORT'	= sinistre.num_port,
 'NUM_IMEI_PORT'= sinistre.num_imei_port,
 'MARQ_PORT'	= sinistre.marq_port,
 'MODL_PORT'	= sinistre.modl_port,
 'DTE_ACH_PORT'	= sinistre.dte_ach_port,
 'DTE_OUVLIG_PORT' = sinistre.dte_ouvlig_port,
 'DTE_ADHESION' = sinistre.dte_adh,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique

From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.personne,
 sysadm.inter	inter_reg,
 sysadm.code code_Et


Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( inter_reg.id_sin	= 	sinistre.id_sin		)	and
 ( inter_reg.id_i	= 	reglement.id_i		)	and
 ( code_Et.id_typ_code	=	'-ET'			)	and
 ( code_Et.id_code	=	sinistre.cod_etat	)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 

END

Else				-- Adhesions SPB ou autres hors carte

BEGIN

Select
 'PERIODE_DEB' 	= @dcPeriodeDeb,
 'PERIODE_FIN'	= @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'ID_ADH' 	= sinistre.id_adh, 
 'ID_SDOS' 	= sinistre.id_sdos, 
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG'	= reg_gti.mt_reg / @dcTaux,
 'ID_DETAIL'	= detail.id_detail,
 'MT_PREJ'	= detail.mt_prej / @dcTaux,
 'MT_PLAF'	= detail.mt_plaf / @dcTaux,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'DTE_DET'	= detail.dte_det,
 'EV' 		= code_Ev.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'NOM_ADHERENT' = RTrim ( LTrim ( personne.nom ) ) ,
 'PRENOM_ADHERENT' = RTrim ( LTrim ( personne.prenom ) ),
 'DTE_CMD'	= detail.dte_cmd,
 'DTE_LIVR'	= detail.dte_livr,
 'DEST_REG'	= inter_reg.nom,
 'COD_ETAT'	= sinistre.cod_etat,
 'LIB_ETAT'	= code_Et.lib_code,
 'NUM_PORT'	= sinistre.num_port,
 'NUM_IMEI_PORT'= sinistre.num_imei_port,
 'MARQ_PORT'	= sinistre.marq_port,
 'MODL_PORT'	= sinistre.modl_port,
 'DTE_ACH_PORT'	= sinistre.dte_ach_port,
 'DTE_OUVLIG_PORT' = sinistre.dte_ouvlig_port,
 'DTE_ADHESION' = sinistre.dte_adh,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique

From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.detail    ,
 sysadm.gar_sin,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.code code_Ev,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.personne,
 sysadm.inter	inter_reg,
 sysadm.code code_Et,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 

Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	detail.id_sin		)	and
 ( reg_gti.id_reg	=	detail.id_reg		)	and
 ( reg_gti.id_gti	=	detail.id_gti		)	and
 ( reg_gti.id_rgpt	=	( Case detail.id_gti
				When 7 Then
					Case 
					 When detail.id_evt between 700 and 719 then 700
					 When detail.id_evt between 720 and 739 then 720
					 Else 740
					End
				Else	detail.id_gti
				End )			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( detail.id_sin	=	gar_sin.id_sin		)	and
 ( detail.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( code_Ev.id_typ_code	=	'+EV'			)	and
 ( code_Ev.id_code	=	detail.id_evt		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( inter_reg.id_sin	= 	sinistre.id_sin		)	and
 ( inter_reg.id_i	= 	detail.id_i_reg		)	and
 ( code_Et.id_typ_code	=	'-ET'			)	and
 ( code_Et.id_code	=	sinistre.cod_etat	)	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 

	

 
UNION ALL
Select
 'PERIODE_DEB' 	= @dcPeriodeDeb,
 'PERIODE_FIN'	= @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'ID_ADH' 	= sinistre.id_adh, 
 'ID_SDOS' 	= sinistre.id_sdos,  
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG'	= reg_gti.mt_reg / @dcTaux,
 'ID_DETAIL'	= frais.id_frais,
 'MT_PREJ'	= frais.mt_frais / @dcTaux,
 'MT_PLAF'	= frais.mt_frais / @dcTaux,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= code_Nf.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'NOM_ADHERENT' = RTrim ( LTrim ( personne.nom ) ) ,
 'PRENOM_ADHERENT' = RTrim ( LTrim ( personne.prenom ) ),
 'DTE_CMD'	= null,
 'DTE_LIVR'	= null,
 'DEST_REG'	= inter_reg.nom,
 'COD_ETAT'	= sinistre.cod_etat,
 'LIB_ETAT'	= code_Et.lib_code,
 'NUM_PORT'	= sinistre.num_port,
 'NUM_IMEI_PORT'= sinistre.num_imei_port,
 'MARQ_PORT'	= sinistre.marq_port,
 'MODL_PORT'	= sinistre.modl_port,
 'DTE_ACH_PORT'	= sinistre.dte_ach_port,
 'DTE_OUVLIG_PORT' = sinistre.dte_ouvlig_port,
 'DTE_ADHESION' = sinistre.dte_adh,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
 
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.personne,
 sysadm.inter	inter_reg,
 sysadm.code code_Et,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 


Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( inter_reg.id_sin	= 	sinistre.id_sin		)	and
 ( inter_reg.id_i	= 	reg_gti.id_i		)	and
 ( code_Et.id_typ_code	=	'-ET'			)	and
 ( code_Et.id_code	=	sinistre.cod_etat	)	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 

UNION ALL

Select
 'PERIODE_DEB' 	= @dcPeriodeDeb,
 'PERIODE_FIN'	= @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'ID_ADH' 	= sinistre.id_adh, 
 'ID_SDOS' 	= sinistre.id_sdos, 
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= 'REGULARISATION',
 'MT_REG'	= reglement.mt_tot_reg / @dcTaux,
 'ID_DETAIL'	= 0,
 'MT_PREJ'	= 0,
 'MT_PLAF'	= reglement.mt_tot_reg / @dcTaux,
 'ALT_PLAF'	= 'N',
 'DTE_DET'	= null,
 'EV' 		= reglement.lib_reg,
 'LIB_GRP'	= groupe.lib_grp,
 'NOM_ADHERENT' = RTrim ( LTrim ( personne.nom ) ) ,
 'PRENOM_ADHERENT' = RTrim ( LTrim ( personne.prenom ) ),
 'DTE_CMD'	= null,
 'DTE_LIVR'	= null,
 'DEST_REG'	= inter_reg.nom,
 'COD_ETAT'	= sinistre.cod_etat,
 'LIB_ETAT'	= code_Et.lib_code,
 'NUM_PORT'	= sinistre.num_port,
 'NUM_IMEI_PORT'= sinistre.num_imei_port,
 'MARQ_PORT'	= sinistre.marq_port,
 'MODL_PORT'	= sinistre.modl_port,
 'DTE_ACH_PORT'	= sinistre.dte_ach_port,
 'DTE_OUVLIG_PORT' = sinistre.dte_ouvlig_port,
 'DTE_ADHESION' = sinistre.dte_adh,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
 
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.personne,
 sysadm.inter	inter_reg,
 sysadm.code code_Et


Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( inter_reg.id_sin	= 	sinistre.id_sin		)	and
 ( inter_reg.id_i	= 	reglement.id_i		)	and
 ( code_Et.id_typ_code	=	'-ET'			)	and
 ( code_Et.id_code	=	sinistre.cod_etat	)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 


END

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S05_LSTREG_TEL
-- Auteur               :       FABRY JF
-- Date                 :       29/05/1998
-- Libellé              :        
-- Commentaires         :       Liste d‚taill‚e des rŠglements pour la téléphonie
--				seulement pour les détails ayant une date de livraison
-- Références           :       
--
--				EURO
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
-- [BUG20080728].COD_MODE_REG  JFF
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S05_LSTREG_TEL' AND type = 'P' )
        DROP procedure sysadm.PS_S05_LSTREG_TEL
GO

CREATE procedure sysadm.PS_S05_LSTREG_TEL
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal ( 7, 0 ),
	@dcPeriodeFin   Decimal ( 7, 0 ),
	@dcIdProd	Decimal ( 7, 0 ) WITH RECOMPILE

AS

/* 
   Gestion de l'euro, si prod négatif, état en Euro,
   si prod positif, état en Francs Francais.
*/
Declare @dcTaux Decimal ( 6,5 )

Select  @dcTaux = 1              
If @dcIdProd < 0 
 Begin
  Select  @dcTaux = 6.55957
  Select  @dcIdProd = @dcIdProd * (-1)
 End

SET NOCOUNT ON

Declare	@sCodAdh Char(1)


Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramŠne dans un premier temps le d‚tail du rŠglement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les r‚guls effectu‚es
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN

Select
 'PERIODE_DEB' 	= @dcPeriodeDeb,
 'PERIODE_FIN'	= @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'ID_ADH' 	= sinistre.id_adh, 
 'ID_SDOS' 	= sinistre.id_sdos, 
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG'	= reg_gti.mt_reg / @dcTaux,
 'ID_DETAIL'	= detail.id_detail,
 'MT_PREJ'	= detail.mt_prej / @dcTaux,
 'MT_PLAF'	= detail.mt_plaf / @dcTaux,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'DTE_DET'	= detail.dte_det,
 'EV' 		= code_Ev.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'NOM_ADHERENT' = RTrim ( LTrim ( personne.nom ) ) ,
 'PRENOM_ADHERENT' = RTrim ( LTrim ( personne.prenom ) ),
 'DTE_CMD'	= detail.dte_cmd,
 'DTE_LIVR'	= detail.dte_livr,
 'DEST_REG'	= inter_reg.nom,
 'COD_ETAT'	= sinistre.cod_etat,
 'LIB_ETAT'	= code_Et.lib_code,
 'NUM_PORT'	= sinistre.num_port,
 'NUM_IMEI_PORT'= sinistre.num_imei_port,
 'MARQ_PORT'	= sinistre.marq_port,
 'MODL_PORT'	= sinistre.modl_port,
 'DTE_ACH_PORT'	= sinistre.dte_ach_port,
 'DTE_OUVLIG_PORT' = sinistre.dte_ouvlig_port,
 'DTE_ADHESION' = sinistre.dte_adh,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
 
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.detail    ,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.code code_Ev,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.personne,
 sysadm.inter	inter_reg,
 sysadm.code code_Et,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 

Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	detail.id_sin		)	and
 ( reg_gti.id_reg	=	detail.id_reg		)	and
 ( reg_gti.id_gti	=	detail.id_gti		)	and
 ( reg_gti.id_rgpt	=	( Case detail.id_gti
				When 7 Then
					Case 
					 When detail.id_evt between 700 and 719 then 700
					 When detail.id_evt between 720 and 739 then 720
					 Else 740
					End
				Else	detail.id_gti
				End )			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( detail.id_sin	=	gar_sin.id_sin		)	and
 ( detail.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( code_Ev.id_typ_code	=	'+EV'			)	and
 ( code_Ev.id_code	=	detail.id_evt		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( inter_reg.id_sin	= 	sinistre.id_sin		)	and
 ( inter_reg.id_i	= 	detail.id_i_reg		)	and
 ( code_Et.id_typ_code	=	'-ET'			)	and
 ( code_Et.id_code	=	sinistre.cod_etat	)	and
 ( detail.dte_cmd is not null				)  	and
 ( detail.dte_livr is not null				)	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 


END

Else				-- Adhesions SPB ou autres hors carte

BEGIN

Select
 'PERIODE_DEB' 	= @dcPeriodeDeb,
 'PERIODE_FIN'	= @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'ID_ADH' 	= sinistre.id_adh, 
 'ID_SDOS' 	= sinistre.id_sdos, 
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG'	= reg_gti.mt_reg / @dcTaux,
 'ID_DETAIL'	= detail.id_detail,
 'MT_PREJ'	= detail.mt_prej / @dcTaux,
 'MT_PLAF'	= detail.mt_plaf / @dcTaux,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'DTE_DET'	= detail.dte_det,
 'EV' 		= code_Ev.lib_code,
 'LIB_GRP'	= groupe.lib_grp,
 'NOM_ADHERENT' = RTrim ( LTrim ( personne.nom ) ) ,
 'PRENOM_ADHERENT' = RTrim ( LTrim ( personne.prenom ) ),
 'DTE_CMD'	= detail.dte_cmd,
 'DTE_LIVR'	= detail.dte_livr,
 'DEST_REG'	= inter_reg.nom,
 'COD_ETAT'	= sinistre.cod_etat,
 'LIB_ETAT'	= code_Et.lib_code,
 'NUM_PORT'	= sinistre.num_port,
 'NUM_IMEI_PORT'= sinistre.num_imei_port,
 'MARQ_PORT'	= sinistre.marq_port,
 'MODL_PORT'	= sinistre.modl_port,
 'DTE_ACH_PORT'	= sinistre.dte_ach_port,
 'DTE_OUVLIG_PORT' = sinistre.dte_ouvlig_port,
 'DTE_ADHESION' = sinistre.dte_adh,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
 

From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.detail    ,
 sysadm.gar_sin,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.code code_Ev,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.personne,
 sysadm.inter	inter_reg,
 sysadm.code code_Et,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 


Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	detail.id_sin		)	and
 ( reg_gti.id_reg	=	detail.id_reg		)	and
 ( reg_gti.id_gti	=	detail.id_gti		)	and
 ( reg_gti.id_rgpt	=	( Case detail.id_gti
				When 7 Then
					Case 
					 When detail.id_evt between 700 and 719 then 700
					 When detail.id_evt between 720 and 739 then 720
					 Else 740
					End
				Else	detail.id_gti
				End )			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( detail.id_sin	=	gar_sin.id_sin		)	and
 ( detail.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( code_Ev.id_typ_code	=	'+EV'			)	and
 ( code_Ev.id_code	=	detail.id_evt		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( inter_reg.id_sin	= 	sinistre.id_sin		)	and
 ( inter_reg.id_i	= 	detail.id_i_reg		)	and
 ( code_Et.id_typ_code	=	'-ET'			)	and
 ( code_Et.id_code	=	sinistre.cod_etat	)	and
 ( detail.dte_cmd is not null				)  	and
 ( detail.dte_livr is not null				)	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = reglement.id_sin
			And     rg.id_reg = reglement.id_reg
			And		ga.id_prod = sinistre.id_prod
			And     ga.id_rev = IsNull ( nullif ( sinistre.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = sinistre.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 


END

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_COMPTA
-- Auteur               :       FABRY JF
-- Date                 :       08/06/2001
-- Libellé              :       Liste de l etat des sinistres sur une période données,
--				pour Marie-Laure Eude, DEEI1944.
--				
-- Commentaires         :       
-- 
--				
-- Références           :       Datawindow : 
--
-- Arguments            :       @dtDteDeb   	DateTime (val)
--				@dtDteFin   	DateTime (val)
--				
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      06/10/2014   [PM266]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_COMPTA' AND type = 'P' )
        DROP procedure sysadm.DW_S01_COMPTA
GO

CREATE procedure sysadm.DW_S01_COMPTA 
	@dtDteDeb   	DateTime,
	@dtDteFin   	DateTime WITH RECOMPILE

AS

select	p.id_prod	as num_prod,
	p.lib_court	as nom_prod,
	s.cod_etat	as code_etat_actuel,
	et.lib_code	as lib_etat_actuel,
	DatePart ( month, s.dte_decl ) as mois_decl,
	count (*) as nbre_dossiers,
	-- [BUG20080728].COD_MODE_REG  JFF
	0 as Montant_regle
	-- :[BUG20080728].COD_MODE_REG  JFF

from 	sysadm.produit p,
	sysadm.code	et,
	sysadm.sinistre s

where	s.dte_decl between @dtDteDeb and @dtDteFin
and	p.id_prod = s.id_prod
and	et.id_typ_code = '-ET'
and	et.id_code = s.cod_etat
and     s.cod_etat not in ( 550, 600 )
-- [PM266]
AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
    Or
	Not Exists ( 
		Select 1
		From	sysadm.exclu_ass ex,
				sysadm.garantie ga,
				sysadm.police po,
				sysadm.reg_gti rg,
				sysadm.reglement r
		Where	r.id_sin = s.id_sin
		And		rg.id_sin = r.id_sin
		And     rg.id_reg = r.id_reg
		And		ga.id_prod = s.id_prod
		And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
										IsNull ( 
											( Select max (id_rev )
											  From   revision r
											  Where  r.id_prod = s.id_prod ) , 0 ))
		And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
										(
										  Select top 1 id_gti  
										  From   sysadm.garantie ga2
										  Where  ga2.id_prod = ga.id_prod
										  And    ga2.id_rev = ga.id_rev 
										)
									)
		And		po.id_police = ga.id_police
		and		ex.id_cie = po.id_cie			
	)
  ) 



Group	by
	p.id_prod,
	p.lib_court,
	s.cod_etat,
	et.lib_code,
	DatePart ( month, s.dte_decl )
Union
-- [BUG20080728].COD_MODE_REG  JFF
select	p.id_prod	as num_prod,
	p.lib_court	as nom_prod,
	s.cod_etat	as code_etat_actuel,
	et.lib_code	as lib_etat_actuel,
	DatePart ( month, s.dte_decl ) as mois_decl,
	count (*) as nbre_dossiers,
	-- [BUG20080728].COD_MODE_REG  JFF
	sum ( r.mt_tot_reg) as Montant_regle
	-- :[BUG20080728].COD_MODE_REG  JFF

from 	sysadm.produit p,
	sysadm.code	et,
	sysadm.sinistre s,
	-- [BUG20080728].COD_MODE_REG  JFF
	sysadm.reglement r
	-- [BUG20080728].COD_MODE_REG  JFF 
	

where	s.dte_decl between @dtDteDeb and @dtDteFin
and	p.id_prod = s.id_prod
and	et.id_typ_code = '-ET'
and	et.id_code = s.cod_etat
and     s.cod_etat in ( 550, 600 )
and	r.id_sin     =  s.id_sin 
and     r.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' )  
and 	r.cod_mot_reg not in ( 'RI' )
-- [PM266]
AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
    Or
	Not Exists ( 
		Select 1
		From	sysadm.exclu_ass ex,
				sysadm.garantie ga,
				sysadm.police po,
				sysadm.reg_gti rg,
				sysadm.reglement r
		Where	r.id_sin = s.id_sin
		And		rg.id_sin = r.id_sin
		And     rg.id_reg = r.id_reg
		And		ga.id_prod = s.id_prod
		And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
										IsNull ( 
											( Select max (id_rev )
											  From   revision r
											  Where  r.id_prod = s.id_prod ) , 0 ))
		And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
										(
										  Select top 1 id_gti  
										  From   sysadm.garantie ga2
										  Where  ga2.id_prod = ga.id_prod
										  And    ga2.id_rev = ga.id_rev 
										)
									)
		And		po.id_police = ga.id_police
		and		ex.id_cie = po.id_cie			
	)
  ) 


Group	by
	p.id_prod,
	p.lib_court,
	s.cod_etat,
	et.lib_code,
	DatePart ( month, s.dte_decl )
-- :[BUG20080728].COD_MODE_REG  JFF

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_COMPTA
-- Auteur               :       FABRY JF
-- Date                 :       08/06/2001
-- Libellé              :       Liste de l etat des garantie sur une période données,
--				pour Marie-Laure Eude, DEEI1944.
--				
-- Commentaires         :       
--				
--				
-- Références           :       Datawindow : 
--
-- Arguments            :       @dtDteDeb   	DateTime (val)
--				@dtDteFin   	DateTime (val)
--				
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      06/10/2014   [PM266]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_COMPTA' AND type = 'P' )
        DROP procedure sysadm.DW_S02_COMPTA
GO

CREATE procedure sysadm.DW_S02_COMPTA 
	@dtDteDeb   	DateTime,
	@dtDteFin   	DateTime WITH RECOMPILE

AS


select	p.id_prod	as num_prod,
	p.lib_court	as nom_prod,
	g.id_gti	as num_garantie,	
	libgti.lib_code	as nom_garantie,
	g.cod_etat	as code_etat_actuel_garantie,	
	et.lib_code	as lib_etat_actuel_garantie,
	DatePart ( month, s.dte_decl ) as mois_decl_sinistre,
	count (*) as nbre_garanties,
	-- [BUG20080728].COD_MODE_REG  JFF
	0 as Montant_regle_garantie
	-- :[BUG20080728].COD_MODE_REG  JFF

from 	sysadm.produit  p,
	sysadm.code	et,
	sysadm.code	libgti,
	sysadm.sinistre s,
	sysadm.gar_sin	g

where	s.dte_decl between @dtDteDeb and @dtDteFin
and	p.id_prod = s.id_prod
and	g.id_sin   = s.id_sin
and	et.id_typ_code = '-ET'
and	et.id_code = g.cod_etat
and	libgti.id_typ_code = '-GA'
and	libgti.id_code = g.id_gti
-- [BUG20080728].COD_MODE_REG  JFF
and     g.cod_etat not in ( 550, 600 )
-- :[BUG20080728].COD_MODE_REG  JFF
-- [PM266]
AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
    Or
	Not Exists ( 
		Select 1
		From	sysadm.exclu_ass ex,
				sysadm.garantie ga,
				sysadm.police po,
				sysadm.reg_gti rg,
				sysadm.reglement r
		Where	r.id_sin = s.id_sin
		And		rg.id_sin = r.id_sin
		And     rg.id_reg = r.id_reg
		And		ga.id_prod = s.id_prod
		And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
										IsNull ( 
											( Select max (id_rev )
											  From   revision r
											  Where  r.id_prod = s.id_prod ) , 0 ))
		And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
										(
										  Select top 1 id_gti  
										  From   sysadm.garantie ga2
										  Where  ga2.id_prod = ga.id_prod
										  And    ga2.id_rev = ga.id_rev 
										)
									)
		And		po.id_police = ga.id_police
		and		ex.id_cie = po.id_cie			
	)
  ) 

Group	by 
	p.id_prod,
	p.lib_court,
	g.id_gti,
	libgti.lib_code,
	g.cod_etat,
	et.lib_code,
	DatePart ( month, s.dte_decl )
-- [BUG20080728].COD_MODE_REG  JFF
Union
select	p.id_prod	as num_prod,
	p.lib_court	as nom_prod,
	g.id_gti	as num_garantie,	
	libgti.lib_code	as nom_garantie,
	g.cod_etat	as code_etat_actuel_garantie,	
	et.lib_code	as lib_etat_actuel_garantie,
	DatePart ( month, s.dte_decl ) as mois_decl_sinistre,
	count (*) as nbre_garanties,
	-- [BUG20080728].COD_MODE_REG  JFF
	Sum ( rg.mt_reg ) as Montant_regle_garantie
	-- :[BUG20080728].COD_MODE_REG  JFF

from 	sysadm.produit  p,
	sysadm.code	et,
	sysadm.code	libgti,
	sysadm.sinistre s,
	sysadm.gar_sin	g,
	-- [BUG20080728].COD_MODE_REG  JFF
	sysadm.reglement r,
	sysadm.reg_gti rg
	-- [BUG20080728].COD_MODE_REG  JFF 


where	s.dte_decl between @dtDteDeb and @dtDteFin
and	p.id_prod = s.id_prod
and	g.id_sin   = s.id_sin
and	et.id_typ_code = '-ET'
and	et.id_code = g.cod_etat
and	libgti.id_typ_code = '-GA'
and	libgti.id_code = g.id_gti
	-- [BUG20080728].COD_MODE_REG  JFF
and     g.cod_etat in ( 550, 600 )
and     rg.id_sin = g.id_sin
and     rg.id_gti = g.id_gti
and	r.id_sin     =  rg.id_sin 
and	r.id_reg     =  rg.id_reg 
and     r.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' )  
and 	r.cod_mot_reg not in ( 'RI' )
	-- :[BUG20080728].COD_MODE_REG  JFF
-- [PM266]
AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
    Or
	Not Exists ( 
		Select 1
		From	sysadm.exclu_ass ex,
				sysadm.garantie ga,
				sysadm.police po,
				sysadm.reg_gti rg,
				sysadm.reglement r
		Where	r.id_sin = s.id_sin
		And		rg.id_sin = r.id_sin
		And     rg.id_reg = r.id_reg
		And		ga.id_prod = s.id_prod
		And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
										IsNull ( 
											( Select max (id_rev )
											  From   revision r
											  Where  r.id_prod = s.id_prod ) , 0 ))
		And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
										(
										  Select top 1 id_gti  
										  From   sysadm.garantie ga2
										  Where  ga2.id_prod = ga.id_prod
										  And    ga2.id_rev = ga.id_rev 
										)
									)
		And		po.id_police = ga.id_police
		and		ex.id_cie = po.id_cie			
	)
  ) 

Group	by 
	p.id_prod,
	p.lib_court,
	g.id_gti,
	libgti.lib_code,
	g.cod_etat,
	et.lib_code,
	DatePart ( month, s.dte_decl )

-- :[BUG20080728].COD_MODE_REG  JFF

Go


--------------------------------------------------------------------
--
-- Procédure            : DW_S01_ST_ORANGE1ER_REFUS_SIMPA
-- Auteur               : FS
-- Date                 : 22/04/2010
-- Libellé              : Extraction des refus Orange 1Er ( Pc322)
--                        ( extraction lancée depuis Sherpa : PS_X_ORANGE1ER_REFUS )
--
-- Arguments            :  @dtDteDeb  	DateTime (val)
--									@dtDteFin  	DateTime (val)
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_ST_ORANGE1ER_REFUS_SIMPA' AND type = 'P' )
        DROP procedure sysadm.DW_S01_ST_ORANGE1ER_REFUS_SIMPA
GO
CREATE procedure [sysadm].[DW_S01_ST_ORANGE1ER_REFUS_SIMPA]
@dtDateDeb	datetime,
@dtDateFin	datetime WITH RECOMPILE

AS
------------------------------------------------------------------------------------------------------------------------
-- sysadm.DW_S01_ST_ORANGE1ER_REFUS FS le 02/04/2010 : Extraction des refus oraux orange 1er
--                                  FS le 12/06/2013 : prise en compte de tous les produits 96 + Ajout des rubriques code et libellé produit
------------------------------------------------------------------------------------------------------------------------

Declare @iNbLig integer

Select @dtDateFin = DateAdd ( day, 1 ,@dtDateFin )   /* ... Ajout une journ‚e pour couvrir la p‚riode jusqu'a 23h59 ...*/


	/*-------------------------------------------------------------------------*/
	/* Sélection des motifs Simpa2                                             */
	/*-------------------------------------------------------------------------*/

	Select
		'type_refus',	
		'num_ligne_client',	
		'sinistre',
		'produit',	
		'nom_produit',
		'nom',	
		'prenom',	
		'marque',	
		'modele',	
		'date_declaration',	
		'date_refus',
		'motif_refus'

union all
	
	Select
	   'Refus écrit'  as type_refus      ,
	   s.num_port     as num_ligne_client,
	   Convert ( varchar(15),s.id_sin )  as sinistre,
	   CONVERT( varchar(10), s.id_prod ) as produit,  -- vdoc 1186
	   pdt.lib_long   as nom_produit, -- vdoc 1186
	   p.nom          as nom     ,
	   p.prenom       as prenom  ,   
		s.marq_port    as marque  ,
		s.modl_port    as modele  ,
		Convert( varchar(10),s.dte_decl, 103 ) as date_declaration,
		Convert( varchar(10),r.cree_le , 103 ) + ' ' + convert(varchar(10),r.cree_le,108)
	                                           as date_refus ,
		sysadm.FN_CODE_NUM ( r.id_motif, '+RE') as motif_refus
	
	From sysadm.sinistre s, 
		  sysadm.refus r,
		  sysadm.gar_sin g,
	     sysadm.personne p,
	     sysadm.produit pdt -- vdoc 1186
	Where
	      s.id_prod between 9600 and 9699 -- VDOC11186 prise en compte de tous les produit 96xx
	And 	s.cod_etat = 200
	And   s.id_ordre = p.id_ordre
	And   r.id_sin = s.id_sin
	And   g.id_sin = r.id_sin
	And 	g.id_gti = r.id_gti
	And 	g.cod_etat = 200
	And     s.id_prod = pdt.id_prod -- vdoc 1186
	And	r.cree_le between @dtDateDeb and @dtDateFin
	
Set @iNbLig = @@rowcount

Return @iNbLig

Go
grant execute on sysadm.[DW_S01_ST_ORANGE1ER_REFUS_SIMPA] to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procédure            : DW_S01_STAT_FRAIS_PRESTA_ASS
-- Auteur               : FPI
-- Date                 : 08/04/2011
-- Libellé              : Extraction des frais presta assureur - [VDoc3603]
--
-- Arguments            :  @dtDteDeb  	DateTime (val)
--			   @dtDteFin  	DateTime (val)
--  			@dcIdProd	Decimal(7)		(Val)
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 FPI 18/07/2011 Utilisation du mois civil de la date de fin
-- #2 FPI 21/09/2011 Utilisation du mois civil de la date de début
-- [VDoc8100] FPI 15/06/2012 Passage du produit adh ald produit sin
-- [20130905142500] Modification suite remonté de François.
-- [201309091100.FPI] Correction - suppr de la jointure avec param_frais
-- JFF      06/10/2014   [PM266]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_STAT_FRAIS_PRESTA_ASS' AND type = 'P' )
        DROP procedure sysadm.DW_S01_STAT_FRAIS_PRESTA_ASS
GO

CREATE procedure sysadm.DW_S01_STAT_FRAIS_PRESTA_ASS
@dtDateDeb	datetime,
@dtDateFin	datetime,
@dcIdProd	Decimal(7) WITH RECOMPILE

AS

Declare @dcIdProdDeb decimal(7,0),
	@dcIdProdFin decimal(7,0)

Set @dcIdProdDeb= @dcIdProd * 100
Set @dcIdProdFin= @dcIdProdDeb +99

-- #1
Set @dtDateDeb = convert(datetime,convert(varchar(4),datepart(year,@dtDateDeb)) +  RIGHT('0' + convert(varchar(2), MONTH(@dtDateDeb)),2) + '01',112)
Set @dtDateFin = DATEADD(month,1,@dtDateDeb)

Select t.id_prod, sysadm.FN_LIB_PROD(t.id_prod) as lib_produit,
	t.no_contrat,
	t.id_sin,
	pe.nom,pe.prenom,
	sysadm.FN_CODE_CAR(d.val_car,'-AR') as lib_typ_appareil,
	tt.id_process as code_process,
	sysadm.FN_CODE_NUM(tt.id_process,'-IF') as lib_process,
	t.dte_trt, -- [20130905142500]
--	t.cree_le, -- [20130905142500] ne sera jamais à présent
	t.montant
from sysadm.trt_frais_presta t
  inner join trace_trt_frais_presta tt on t.id_sin=tt.id_sin and t.id_seq_cmd=tt.id_seq_cmd
  inner join sysadm.sinistre s on s.id_sin=t.id_sin
  inner join personne pe on pe.id_ordre=s.id_ordre
  inner join div_sin d on d.id_sin=s.id_sin
  --inner join sysadm.param_frais p on p.id_prod=tt.id_prod and p.id_four=t.cod_presta -- [201309091100.FPI]
  --  and p.id_gti=tt.id_gti and p.id_process=tt.id_process --[201309091100.FPI]
where d.nom_zone='type_app'
  --and p.cod_pec_assureur > 0
  and t.cod_pec_assureur > 0 --[201309091100.FPI]
  and t.dte_trt between @dtDateDeb and @dtDateFin -- [20130905142500]
--  and t.cree_le between @dtDateDeb and @dtDateFin -- [20130905142500]
  and s.id_prod between @dcIdProdDeb and @dcIdProdFin
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg,
					sysadm.reglement r
			Where	r.id_sin = s.id_sin
			And 	rg.id_sin = r.id_sin
			And     rg.id_reg = r.id_reg
			And		ga.id_prod = s.id_prod
			And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = s.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 

Go

--------------------------------------------------------------------
--
-- Procédure            : DW_S01_STAT_FRAIS_PRESTA
-- Auteur               : FPI
-- Date                 : 08/04/2011
-- Libellé              : Extraction des frais presta prestataire - [VDoc3603]
--
-- Arguments            :  @dtDteDeb  	DateTime (val)
--			   @dtDteFin  	DateTime (val)
--	    		   @dcIdProd	Decimal(7)		(Val)
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 FPI 18/07/2011 Utilisation du mois civil de la date de fin
-- #2 FPI 21/09/2011 Utilisation du mois civil de la date de début
-- [VDoc8100] FPI 15/06/2012 Passage du produit adh ald produit sin
-- [20130905142500] Modification suite remonté de François.
-- [201309091100.FPI] Correction - suppr de la jointure avec param_frais
-- JFF      06/10/2014   [PM266]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_STAT_FRAIS_PRESTA' AND type = 'P' )
        DROP procedure sysadm.DW_S01_STAT_FRAIS_PRESTA
GO

CREATE procedure sysadm.DW_S01_STAT_FRAIS_PRESTA
@dtDateDeb	datetime,
@dtDateFin	datetime,
@dcIdProd	Decimal(7) WITH RECOMPILE
AS

Declare @dcIdProdDeb decimal(7,0),
	@dcIdProdFin decimal(7,0)

Set @dcIdProdDeb= @dcIdProd * 100
Set @dcIdProdFin= @dcIdProdDeb +99

-- #1
Set @dtDateDeb = convert(datetime,convert(varchar(4),datepart(year,@dtDateDeb)) +  RIGHT('0' + convert(varchar(2), MONTH(@dtDateDeb)),2) + '01',112)
Set @dtDateFin = DATEADD(month,1,@dtDateDeb)

Select t.id_prod, sysadm.FN_LIB_PROD(t.id_prod) as lib_produit,
	t.no_contrat,
	t.id_sin,
	pe.nom,pe.prenom,
	sysadm.FN_CODE_CAR(d.val_car,'-AR') as lib_typ_appareil,
	tt.id_process as code_process,
	sysadm.FN_CODE_NUM(tt.id_process,'-IF') as lib_process,
	t.dte_trt, -- [20130905142500]
--	t.cree_le, -- [20130905142500] ne sera jamais à présent
	t.montant
from sysadm.trt_frais_presta t
  inner join trace_trt_frais_presta tt on t.id_sin=tt.id_sin and t.id_seq_cmd=tt.id_seq_cmd
  inner join sysadm.sinistre s on s.id_sin=t.id_sin
  inner join personne pe on pe.id_ordre=s.id_ordre
  inner join div_sin d on d.id_sin=s.id_sin
  --inner join sysadm.param_frais p on p.id_prod=tt.id_prod and p.id_four=t.cod_presta  -- [201309091100.FPI]
  --  and p.id_gti=tt.id_gti and p.id_process=tt.id_process
where d.nom_zone='type_app'
  --and p.cod_pec_presta > 0
  and t.cod_pec_presta > 0 -- [201309091100.FPI]
  and t.dte_trt between @dtDateDeb and @dtDateFin -- [20130905142500]  
  -- and t.cree_le between @dtDateDeb and @dtDateFin -- [20130905142500]
  and s.id_prod between @dcIdProdDeb and @dcIdProdFin
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg,
					sysadm.reglement r
			Where	r.id_sin = s.id_sin
			And 	rg.id_sin = r.id_sin
			And     rg.id_reg = r.id_reg
			And		ga.id_prod = s.id_prod
			And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = s.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S014_LSTREG
-- Auteur               :       FPI
-- Date                 :       15/06/2011
-- Libellé              :        
-- Commentaires         :       Liste détaillée des réglements
-- Références           :       Variante de PS_S01_LSTREG pour DAS (VDoc4141)
--
--				EURO
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--				@dcIdProd	Decimal(7)		(Val)
--				
-- Retourne             :       Rien
-- JFF      06/10/2014   [PM266]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S014_LSTREG' AND type = 'P' )
        DROP procedure sysadm.PS_S014_LSTREG
GO

CREATE procedure sysadm.PS_S014_LSTREG 
	@dtDteDeb       DateTime        ,
    @dtDteFin       DateTime	,
	@dcIdProd	Decimal(7)	WITH RECOMPILE

AS

SET NOCOUNT ON

Declare	@sCodAdh Char(1)


Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramSne dans un premier temps le d'tail du rSglement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les r'guls effectu'es
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN

Select
 'LIB_CIE'	= compagnie.lib_cie,
 'LIB_POLICE'	= police.lib_police,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_PROD'	= produit.lib_long,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
  sysadm.FN_CODE_CAR(div_sin.val_car,'-AR') as genre,
  sinistre.marq_port as 'marque', 
  sinistre.dte_ach_port as 'date_achat',
 (select top 1 detail.mt_val_achat from sysadm.detail where detail.id_sin=sinistre.id_sin) as mt_achat,
  sinistre.id_adh as no_adhesion, 
  sinistre.dte_adh, 
  sinistre.dte_fin_gti,
  sinistre.dte_surv, 
  datepart(year,sinistre.dte_surv) as annee_surv,
  datepart(month,sinistre.dte_surv) as mois_surv, 
  sinistre.dte_decl,
 'type_garantie' 		= code_Ns.lib_code,
 'garantie' 		= code_Gs.lib_code,
 'DTE_REG'	= reg_gti.maj_le,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 (select max(detail.mt_plaf) from sysadm.detail where detail.id_sin=gar_sin.id_sin and detail.id_gti=gar_sin.id_gti) as mt_plafond
From
 sysadm.reg_gti   
 inner join sysadm.sinistre  on reg_gti.id_sin	=	sinistre.id_sin
 inner join sysadm.gar_sin on gar_sin.id_sin	=	sinistre.id_sin 	and  gar_sin.id_gti	=	reg_gti.id_gti
 inner join sysadm.produit on sinistre.id_prod	=	produit.id_prod
 inner join sysadm.groupe on groupe.id_grp	=	sinistre.id_ets
 inner join  sysadm.garantie on garantie.id_prod	=	sinistre.id_prod and  garantie.id_rev	=	sinistre.id_rev	 and garantie.id_gti	=	reg_gti.id_gti
 inner join sysadm.police on garantie.id_police	=	police.id_police
 inner join sysadm.compagnie on compagnie.id_cie	=	police.id_cie
 inner join sysadm.personne on personne.id_ordre    = 	sinistre.id_ordre
 left outer join sysadm.div_sin on div_sin.id_sin = sinistre.id_sin and div_sin.nom_zone='type_app',
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.reglement
Where 
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

UNION ALL

Select
 'LIB_CIE'	= compagnie.lib_cie,
 'LIB_POLICE'	= police.lib_police,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_PROD'	= produit.lib_long,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
  sysadm.FN_CODE_CAR(div_sin.val_car,'-AR') as genre,
  sinistre.marq_port as 'marque', 
 sinistre.dte_ach_port as 'date_achat',
 (select top 1 detail.mt_val_achat from sysadm.detail where detail.id_sin=sinistre.id_sin) as mt_achat,
  sinistre.id_adh as no_adhesion, 
  sinistre.dte_adh, 
  sinistre.dte_fin_gti,
  sinistre.dte_surv, 
  datepart(year,sinistre.dte_surv) as annee_surv,
  datepart(month,sinistre.dte_surv) as mois_surv, 
  sinistre.dte_decl,
  'type_garantie' 		= code_Ns.lib_code,
 'garantie' 		= code_Nf.lib_code,
  'DTE_REG'	= reg_gti.maj_le,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= 'N',
 frais.mt_frais  as mt_plafond
From
 sysadm.reg_gti   
  inner join sysadm.sinistre  on reg_gti.id_sin	=	sinistre.id_sin
  inner join sysadm.frais  on reg_gti.id_sin	=	frais.id_sin and  reg_gti.id_reg	=	frais.id_reg   
  inner join sysadm.produit on sinistre.id_prod	=	produit.id_prod
 left outer join sysadm.div_sin on div_sin.id_sin = sinistre.id_sin and div_sin.nom_zone='type_app'
 inner join sysadm.personne on personne.id_ordre    = 	sinistre.id_ordre
 inner join sysadm.groupe on groupe.id_grp	=	sinistre.id_ets,
 sysadm.garantie,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.police,
 sysadm.compagnie,
  sysadm.reglement

Where 
 ( reg_gti.id_gti	=	-1			)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

UNION ALL
Select
 'LIB_CIE'	= compagnie.lib_cie,
 'LIB_POLICE'	= police.lib_police,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_PROD'	= produit.lib_long,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
  sysadm.FN_CODE_CAR(div_sin.val_car,'-AR') as genre,
  sinistre.marq_port as 'marque', 
 sinistre.dte_ach_port as 'date_achat',
 (select top 1 detail.mt_val_achat from sysadm.detail where detail.id_sin=sinistre.id_sin) as mt_achat,
 sinistre.id_adh as no_adhesion, 
  sinistre.dte_adh, 
  sinistre.dte_fin_gti,
  sinistre.dte_surv, 
  datepart(year,sinistre.dte_surv) as annee_surv,
  datepart(month,sinistre.dte_surv) as mois_surv, 
  sinistre.dte_decl,
 'type_garantie' 		= code_Ns.lib_code,
 'garantie' 		= 'REGULARISATION',
 'DTE_REG'	= reglement.dte_reg,
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
  reglement.mt_tot_reg as mt_plafond
From
 sysadm.reglement 
  inner join sysadm.sinistre  on reglement.id_sin	=	sinistre.id_sin
  inner join sysadm.produit on sinistre.id_prod	=	produit.id_prod
  inner join sysadm.personne on personne.id_ordre    = 	sinistre.id_ordre
 left outer join sysadm.div_sin on div_sin.id_sin = sinistre.id_sin and div_sin.nom_zone='type_app',
 sysadm.garantie  ,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.police,
 sysadm.compagnie
Where 
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

END

Else				-- Adhesions SPB ou autres hors carte

BEGIN

Select
 'LIB_CIE'	= compagnie.lib_cie,
 'LIB_POLICE'	= police.lib_police,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_PROD'	= produit.lib_long,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
  sysadm.FN_CODE_CAR(div_sin.val_car,'-AR') as genre,
  sinistre.marq_port as 'marque', 
 sinistre.dte_ach_port as 'date_achat',
 (select top 1 detail.mt_val_achat from sysadm.detail where detail.id_sin=sinistre.id_sin) as mt_achat,
  sinistre.id_adh as no_adhesion, 
  sinistre.dte_adh, 
  sinistre.dte_fin_gti,
  sinistre.dte_surv, 
  datepart(year,sinistre.dte_surv) as annee_surv,
  datepart(month,sinistre.dte_surv) as mois_surv, 
  sinistre.dte_decl,
 'type_garantie' 		= code_Ns.lib_code,
 'garantie' 		= code_Gs.lib_code,
 'DTE_REG'	= reg_gti.maj_le,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 (select max(detail.mt_plaf) from sysadm.detail where detail.id_sin=gar_sin.id_sin and detail.id_gti=gar_sin.id_gti) as mt_plafond
From
 sysadm.reg_gti   
  inner join sysadm.sinistre  on reg_gti.id_sin	=	sinistre.id_sin
  inner join sysadm.produit on sinistre.id_prod	=	produit.id_prod
 left outer join sysadm.div_sin on div_sin.id_sin = sinistre.id_sin and div_sin.nom_zone='type_app'
 inner join sysadm.personne on personne.id_ordre    = 	sinistre.id_ordre
 inner join sysadm.gar_sin on reg_gti.id_sin	=	gar_sin.id_sin	and reg_gti.id_gti	=	gar_sin.id_gti
 inner join sysadm.garantie on  garantie.id_prod	=	sinistre.id_prod and  garantie.id_rev	=	sinistre.id_rev	and garantie.id_gti	=	reg_gti.id_gti
 inner join sysadm.police on garantie.id_police	=	police.id_police,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.compagnie,
 sysadm.reglement
Where 
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 
	  
UNION ALL
Select
 'LIB_CIE'	= compagnie.lib_cie,
 'LIB_POLICE'	= police.lib_police,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_PROD'	= produit.lib_long,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
  sysadm.FN_CODE_CAR(div_sin.val_car,'-AR') as genre,
  sinistre.marq_port as 'marque', 
 sinistre.dte_ach_port as 'date_achat',
 (select top 1 detail.mt_val_achat from sysadm.detail where detail.id_sin=sinistre.id_sin) as mt_achat,
  sinistre.id_adh as no_adhesion, 
  sinistre.dte_adh, 
  sinistre.dte_fin_gti,
  sinistre.dte_surv, 
  datepart(year,sinistre.dte_surv) as annee_surv,
  datepart(month,sinistre.dte_surv) as mois_surv, 
  sinistre.dte_decl,
 'type_garantie' 		= code_Ns.lib_code,
 'garantie' 		= code_Nf.lib_code,
 'DTE_REG'	= reg_gti.maj_le,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= 'N',
  frais.mt_frais as mt_plafond
From
 sysadm.reg_gti   
  inner join sysadm.sinistre  on reg_gti.id_sin	=	sinistre.id_sin
  inner join sysadm.produit on sinistre.id_prod	=	produit.id_prod
 left outer join sysadm.div_sin on div_sin.id_sin = sinistre.id_sin and div_sin.nom_zone='type_app'
 inner join sysadm.personne on personne.id_ordre    = 	sinistre.id_ordre
 inner join sysadm.frais on reg_gti.id_sin	=	frais.id_sin and reg_gti.id_reg	=	frais.id_reg,
 sysadm.garantie,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement
Where 
 ( reg_gti.id_gti	=	-1			)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 
	  
UNION ALL

Select
 'LIB_CIE'	= compagnie.lib_cie,
 'LIB_POLICE'	= police.lib_police,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_PROD'	= produit.lib_long,
 'ID_SIN'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
  sysadm.FN_CODE_CAR(div_sin.val_car,'-AR') as genre,
  sinistre.marq_port as 'marque', 
 sinistre.dte_ach_port as 'date_achat',
 (select top 1 detail.mt_val_achat from sysadm.detail where detail.id_sin=sinistre.id_sin) as mt_achat,
  sinistre.id_adh as no_adhesion, 
  sinistre.dte_adh, 
  sinistre.dte_fin_gti,
  sinistre.dte_surv, 
  datepart(year,sinistre.dte_surv) as annee_surv,
  datepart(month,sinistre.dte_surv) as mois_surv, 
  sinistre.dte_decl,
 'type_garantie' 		= code_Ns.lib_code,
 'garantie' 		= 'REGULARISATION',
 'DTE_REG'	= reglement.dte_reg,
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
  reglement.mt_tot_reg as mt_plafond
From
 sysadm.reglement 
  inner join sysadm.sinistre  on reglement.id_sin	=	sinistre.id_sin
  inner join sysadm.produit on sinistre.id_prod	=	produit.id_prod
 left outer join sysadm.div_sin on div_sin.id_sin = sinistre.id_sin and div_sin.nom_zone='type_app'
 inner join sysadm.personne on personne.id_ordre    = 	sinistre.id_ordre,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.police,
 sysadm.compagnie
Where 
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


END

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_MAJ_MAIL_SATISFACTION_V02 
-- Auteur               :       FPI
-- Date                 :       22/07/2011
-- Libellé              :        
-- Commentaires         :      [PM158]
-- Références           :       
--
--	
-- Arguments            :       Aucun
--				
-- Retourne             :       Rien
-------------------------------------------------------------------
--	FPI	02/12/2011	Utilisation de la DP 202

-- [VDoc15646] - ajout de l'état assuré
-- [VDOC18797] - Ajout du cas Carrefour/Carma où la date de reception n'est pas renseigné
-- FPI - 05/11/2015 [VDoc19068]
--	FPI	27/04/2017	[PM158-8] Evolution DP 202
-- FPI	18/10/2017	[ITSM494162] Correction selection commande si PEC après commande auto (swap)
-- FPI	05/06/2019	ISM13283 - suppression critère garantie différente sur règlement assuré
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_MAJ_MAIL_SATISFACTION_V02' AND type = 'P' )
        DROP procedure sysadm.PS_MAJ_MAIL_SATISFACTION_V02
GO

CREATE procedure sysadm.PS_MAJ_MAIL_SATISFACTION_V02
As

Declare @dtDeb date,
	@dtFin date

  -- On prend ceux validé il y a 10 jours
  Set @dtDeb=dateadd(day,-11,GETDATE())
  Set @dtFin=dateadd(day,1,@dtDeb)

  -- Création table temporaire
  IF OBJECT_ID('tempdb.dbo.#tmp_maj_mail_stf', 'U') IS NOT NULL Drop Table #tmp_maj_mail_stf

 Create Table #tmp_maj_mail_stf (id_sin int , 
	id_appli int, 
	mail_dest varchar(120),
	id_prod	int,
	code_statut_assure varchar(5),
	lib_statut_assure varchar(100))

 
  -- REM : voir avec le statut assuré 1500, 600, ce qui permet d'enlever les deux Not Exist dans le Where
  -- Insertion des règlements assurés
  insert into #tmp_maj_mail_stf
  select s.id_sin, 2 as id_appli, 
	i.adr_mail as mail_dest,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
  from sysadm.sinistre s
  inner join sysadm.inter i on s.id_sin=i.id_sin
  inner join sysadm.det_pro d on s.id_prod=d.id_prod
  inner join sysadm.reglement r on s.id_sin=r.id_sin and r.id_i=i.id_i
  inner join sysadm.reg_gti rg on r.id_sin=rg.id_sin and r.id_reg=rg.id_reg
  where i.cod_inter='A' 
	and i.adr_mail is not null
	and r.dte_reg between @dtDeb and @dtFin
	and d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') <> 'OUI' -- [PM158-8]
	and not exists (select * from sysadm.reglement r2 
		where r2.id_sin=r.id_sin and r2.id_i=r.id_i 
		and r2.dte_reg > r.dte_reg)
    and not exists (select * from sysadm.gar_sin g 
		where g.id_sin=s.id_sin -- and g.id_gti <> rg.id_gti  
			and g.cod_etat not in (200,600,900)) -- Mantis8954
	and not exists (select * from sysadm.w_gar_sin g 
		where g.id_sin=s.id_sin -- and g.id_gti <> rg.id_gti 
			and g.cod_etat not in (200,600,900)) -- Mantis8954

  -- REM : Voir le statut assuré in 1530, 200, mais sur quelle date s'appuyer ? => le validé le du refus dans table refus, et si absent dans table refus	, alors la dte_env_cli du dernier refusé_a_reexp
  -- insertion des refusés
  insert into #tmp_maj_mail_stf
  select s.id_sin, 2 as id_appli, 
	i.adr_mail as mail_dest,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
  from sysadm.sinistre s
  inner join sysadm.inter i on s.id_sin=i.id_sin
  inner join sysadm.det_pro d on s.id_prod=d.id_prod
  where i.cod_inter='A' 
	and i.adr_mail is not null
	and s.cod_etat=200 
	and s.valide_le between @dtDeb and @dtFin
	and d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') <> 'OUI' -- [PM158-8]
	and not exists (select * from sysadm.commande c
		where s.id_sin=c.id_sin and c.cod_etat not in ('ANN','RFO','RPC','RSP')) -- [ITSM215273]

-- REM : statut 2, 178	
-- insertion des commandes
 insert into #tmp_maj_mail_stf
  select s.id_sin, 2 as id_appli, 
	i.adr_mail as mail_dest,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
  from sysadm.sinistre s
  inner join sysadm.inter i on s.id_sin=i.id_sin
  inner join sysadm.det_pro d on s.id_prod=d.id_prod
  inner join sysadm.commande c on c.id_sin=s.id_sin
  where i.cod_inter='A' 
	and i.adr_mail is not null
	and d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') <> 'OUI' -- [PM158-8]
	And	c.dte_env_cli is not null 
	And  c.dte_env_cli between @dtDeb and @dtFin
	And  c.cod_etat in ( 'ECL', 'RPC' )
	And c.id_typ_art not in ('PST','REA','SMS','REL') -- Mantis 9132
	And Not Exists (select * 
		from sysadm.commande c2
		where c2.id_sin=c.id_sin and c.id_seq < c2.id_seq and c2.cod_etat <> 'ANN'
			and c2.id_ref_four not in ('PEC_A_RECYCLER','REFUSE_A_REEXP')) -- [ITSM494162]

  insert into #tmp_maj_mail_stf
  select s.id_sin, 2 as id_appli, 
	i.adr_mail as mail_dest,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
  from sysadm.sinistre s
  inner join sysadm.inter i on s.id_sin=i.id_sin
  inner join sysadm.det_pro d on s.id_prod=d.id_prod
  inner join sysadm.commande c on c.id_sin=s.id_sin
  where i.cod_inter='A' 
	and i.adr_mail is not null
	and d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') <> 'OUI' -- [PM158-8]
	And	(
		 (c.dte_rcp_mob_cli is not null 
			And  c.dte_rcp_mob_cli between @dtDeb and @dtFin
			And  c.cod_etat in ( 'ECL', 'RPC')
		 )
		or (c.cod_etat in ('ECT','RPC') and c.valide_le between @dtDeb and @dtFin) -- [VDoc13933] -- [VDOC18797] Ajout de RPC
		)
	And Not Exists (select * 
		from sysadm.commande c2
		where c2.id_sin=c.id_sin and c.id_seq < c2.id_seq and c2.cod_etat <> 'ANN')
	And c.id_four in ('CAR','CMA') -- [VDOC18797] Ajout de CARMA

insert into #tmp_maj_mail_stf
  select s.id_sin, 2 as id_appli, 
	i.adr_mail as mail_dest,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
  from sysadm.sinistre s
  inner join sysadm.inter i on s.id_sin=i.id_sin
  inner join sysadm.det_pro d on s.id_prod=d.id_prod
  inner join sysadm.commande c on c.id_sin=s.id_sin
  where i.cod_inter='A' 
	and i.adr_mail is not null
	and d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') <> 'OUI' -- [PM158-8]
	And	c.dte_env_cli is not null 
	And  c.dte_env_cli between @dtDeb and @dtFin
	And  c.cod_etat ='RFO'
	And Not Exists (select * 
		from sysadm.commande c2
		where c2.id_sin=c.id_sin and c.id_seq < c2.id_seq and c2.cod_etat <> 'ANN')
	And (c.id_four='CDS'
		or (c.id_four='MS1' and c.id_typ_art='ACC')
		or (c.id_four='O2M' and c.id_typ_art in ('BAM','ALE'))
		)
	
  insert into #tmp_maj_mail_stf
  select s.id_sin, 2 as id_appli, 
	i.adr_mail as mail_dest,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
  from sysadm.sinistre s
  inner join sysadm.inter i on s.id_sin=i.id_sin
  inner join sysadm.det_pro d on s.id_prod=d.id_prod
  inner join sysadm.div_det dd on dd.id_sin=s.id_sin
  where s.id_prod between 23400 and 23499 -- JFF  24/09/2013  [PC13288]
	And i.cod_inter='A' 
	and i.adr_mail is not null
	and d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') <> 'OUI' -- [PM158-8]
	And	dd.nom_zone = 'cod_action'
	And dd.cree_le between @dtDeb and @dtFin
	and dd.val_nbre between 51 and 69 
	And	dd.val_nbre not in ( 55 )
	
	-- [VDoc14676]
 insert into #tmp_maj_mail_stf
  select s.id_sin, 2 as id_appli, 
	i.adr_mail as mail_dest,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
  from sysadm.sinistre s
  inner join sysadm.inter i on s.id_sin=i.id_sin
  inner join sysadm.det_pro d on s.id_prod=d.id_prod
  inner join sysadm.commande c on c.id_sin=s.id_sin
  where i.cod_inter='A' 
	and i.adr_mail is not null
	and d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') <> 'OUI' -- [PM158-8]
	And  c.valide_le between @dtDeb and @dtFin
	And  c.cod_etat in ( 'RPC' )
	And c.id_four='VPP'
	And Not Exists (select * 
		from sysadm.commande c2
		where c2.id_sin=c.id_sin and c.id_seq < c2.id_seq and c2.cod_etat <> 'ANN')

	-- [VDoc19068]
	insert into #tmp_maj_mail_stf
	select s.id_sin, 2 as id_appli, 
	i.adr_mail as mail_dest,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
  from sysadm.sinistre s
  inner join sysadm.inter i on s.id_sin=i.id_sin
  inner join sysadm.det_pro d on s.id_prod=d.id_prod
  inner join sysadm.commande c on c.id_sin=s.id_sin
  inner join sysadm.div_sin ds on ds.id_sin=s.id_sin     
  where i.cod_inter='A' 
	and i.adr_mail is not null
	and d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') <> 'OUI' -- [PM158-8]
	And	c.dte_env_cli is null
	And c.cod_etat in ('ECT','RPC') 
	And c.valide_le > '05/06/2017' 
	And Not Exists (select * 
		from sysadm.commande c2
		where c2.id_sin=c.id_sin and c.id_seq < c2.id_seq and c2.cod_etat <> 'ANN')
	And c.id_typ_art='CAF'
	And c.id_ref_four <> 'SBE' -- [ITSM468665]
	and ds.nom_zone='etat_vu_assure'
	and ds.val_nbre in (1510,1500) 
	
	-- 09/05/2019 - commandes réparées en RFO
  select s.id_sin, 2 as id_appli, 
	i.adr_mail as mail_dest,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
  from sysadm.sinistre s
  inner join sysadm.inter i on s.id_sin=i.id_sin
  inner join sysadm.det_pro d on s.id_prod=d.id_prod
  inner join sysadm.commande c on c.id_sin=s.id_sin
  where i.cod_inter='A' 
	and i.adr_mail is not null
	and d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') <> 'OUI' 
	And	c.dte_env_cli is not null 
	And  c.dte_env_cli between @dtDeb and @dtFin
	and c.status_gc=2
	And  c.cod_etat in ( 'RFO' )
	And c.id_typ_art not in ('PST','REA','SMS','REL') 
	And c.info_spb_frn_cplt not like '%A_REP_GARANTIE=OUI%' -- mail HLI du 14/05
	And Not Exists (select * 
		from sysadm.commande c2
		where c2.id_sin=c.id_sin and c.id_seq < c2.id_seq and c2.cod_etat <> 'ANN'
			and c2.id_ref_four not in ('PEC_A_RECYCLER','REFUSE_A_REEXP'))
			
  -- Insertion en bloc dans la table 'mail_satisfaction' de SHERPA
  IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO')
  Begin
	exec SHERPA_PRO.sysadm.PS_I01_MAIL_SATISFACTION_V01
  End
  Else
  Begin
	exec SHERPA_SIM.sysadm.PS_I01_MAIL_SATISFACTION_V01
  End
Go

grant execute on sysadm.PS_MAJ_MAIL_SATISFACTION_V02 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_MAJ_SMS_SATISFACTION 
-- Auteur               :       FPI
-- Date                 :       23/05/2017
-- Libellé              :        
-- Commentaires         :      [PM158-8]
-- Références           :       
--
--	
-- Arguments            :       Aucun
--				
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_MAJ_SMS_SATISFACTION' AND type = 'P' )
        DROP procedure sysadm.PS_MAJ_SMS_SATISFACTION
GO

CREATE procedure sysadm.PS_MAJ_SMS_SATISFACTION
	@asCodeTrt varchar(10)=NULL
As

Declare @dtDeb date,
	@dtFin date

-- Controle paramètres
if @asCodeTrt is null Set @asCodeTrt='ENVOI'

 If @asCodeTrt not in ('EXTRACT','ENVOI') 
 Begin
	print 'Paramètre incorrect : '
	print 'exec sysadm.PS_MAJ_SMS_SATISFACTION ''ENVOI'' pour l''envoi'
	print 'exec sysadm.PS_MAJ_SMS_SATISFACTION ''EXTRACT'' pour l''extraction des dossiers éligibles'
End

-- On prend ceux validé il y a 10 jours
Set @dtDeb=dateadd(day,-11,GETDATE())
Set @dtFin=dateadd(day,1,@dtDeb)

-- Création table temporaire
IF OBJECT_ID('tempdb.dbo.#tmp_maj_sms_stf', 'U') IS NOT NULL Drop Table #tmp_maj_sms_stf

Create Table #tmp_maj_sms_stf (id_sin int , 
	id_appli int, 
	num_tel varchar(120),
	id_prod	int,
	code_statut_assure varchar(5),
	lib_statut_assure varchar(100))
	
-- Insertion des règlements assurés
insert into #tmp_maj_sms_stf 
select s.id_sin, 2 as id_appli, NULL,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
from sysadm.sinistre s
	inner join sysadm.inter i on s.id_sin=i.id_sin
	inner join sysadm.det_pro d on s.id_prod=d.id_prod
	inner join sysadm.reglement r on s.id_sin=r.id_sin and r.id_i=i.id_i
	inner join sysadm.reg_gti rg on r.id_sin=rg.id_sin and r.id_reg=rg.id_reg
where i.cod_inter='A' 
	and r.dte_reg between @dtDeb and @dtFin
	and d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') = 'OUI' 
	and not exists (select * from sysadm.reglement r2 
		where r2.id_sin=r.id_sin and r2.id_i=r.id_i 
		and r2.dte_reg > r.dte_reg)
	and not exists (select * from sysadm.gar_sin g 
		where g.id_sin=s.id_sin -- and g.id_gti <> rg.id_gti 
			and g.cod_etat not in (200,600,900)) 
	and not exists (select * from sysadm.w_gar_sin g 
		where g.id_sin=s.id_sin -- and g.id_gti <> rg.id_gti 
			and g.cod_etat not in (200,600,900)) 
			
-- insertion des refusés
insert into #tmp_maj_sms_stf 
select s.id_sin, 2 as id_appli, NULL,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
from sysadm.sinistre s
	inner join sysadm.det_pro d on s.id_prod=d.id_prod
where s.cod_etat=200 
	and s.valide_le between @dtDeb and @dtFin
	and d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') = 'OUI' 
	and not exists (select * from sysadm.commande c
		where s.id_sin=c.id_sin and c.cod_etat not in ('ANN','RFO','RPC','RSP')) 
	
-- insertion des commandes
insert into #tmp_maj_sms_stf 
select s.id_sin, 2 as id_appli, NULL,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
from sysadm.sinistre s
	inner join sysadm.det_pro d on s.id_prod=d.id_prod
	inner join sysadm.commande c on c.id_sin=s.id_sin
where d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') = 'OUI'
	And	c.dte_env_cli is not null 
	And  c.dte_env_cli between @dtDeb and @dtFin
	And  c.cod_etat in ( 'ECL', 'RPC' )
	And c.id_typ_art not in ('PST','REA','SMS','REL') -- Mantis 9132
	And Not Exists (select * 
		from sysadm.commande c2
		where c2.id_sin=c.id_sin and c.id_seq < c2.id_seq and c2.cod_etat <> 'ANN')

insert into #tmp_maj_sms_stf 
select s.id_sin, 2 as id_appli, NULL,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
from sysadm.sinistre s
	inner join sysadm.det_pro d on s.id_prod=d.id_prod
	inner join sysadm.commande c on c.id_sin=s.id_sin
where d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') = 'OUI' 
	And	(
			(c.dte_rcp_mob_cli is not null 
			And  c.dte_rcp_mob_cli between @dtDeb and @dtFin
			And  c.cod_etat in ( 'ECL', 'RPC')
			)
		or (c.cod_etat in ('ECT','RPC') and c.valide_le between @dtDeb and @dtFin) -- [VDoc13933] -- [VDOC18797] Ajout de RPC
		)
	And Not Exists (select * 
		from sysadm.commande c2
		where c2.id_sin=c.id_sin and c.id_seq < c2.id_seq and c2.cod_etat <> 'ANN')
	And c.id_four in ('CAR','CMA') -- [VDOC18797] Ajout de CARMA

insert into #tmp_maj_sms_stf 
select s.id_sin, 2 as id_appli, NULL,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
from sysadm.sinistre s
	inner join sysadm.det_pro d on s.id_prod=d.id_prod
	inner join sysadm.commande c on c.id_sin=s.id_sin
where d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') = 'OUI' 
	And	c.dte_env_cli is not null 
	And  c.dte_env_cli between @dtDeb and @dtFin
	And  c.cod_etat ='RFO'
	And Not Exists (select * 
		from sysadm.commande c2
		where c2.id_sin=c.id_sin and c.id_seq < c2.id_seq and c2.cod_etat <> 'ANN')
	And (c.id_four='CDS'
		or (c.id_four='MS1' and c.id_typ_art='ACC')
		or (c.id_four='O2M' and c.id_typ_art in ('BAM','ALE'))
		)
	
insert into #tmp_maj_sms_stf 
select s.id_sin, 2 as id_appli, NULL,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
from sysadm.sinistre s
	inner join sysadm.det_pro d on s.id_prod=d.id_prod
	inner join sysadm.div_det dd on dd.id_sin=s.id_sin
where s.id_prod between 23400 and 23499 
	and d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') = 'OUI' 
	And	dd.nom_zone = 'cod_action'
	And dd.cree_le between @dtDeb and @dtFin
	and dd.val_nbre between 51 and 69 
	And	dd.val_nbre not in ( 55 )
	
-- [VDoc14676]
insert into #tmp_maj_sms_stf 
select s.id_sin, 2 as id_appli, NULL,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
from sysadm.sinistre s
	inner join sysadm.det_pro d on s.id_prod=d.id_prod
	inner join sysadm.commande c on c.id_sin=s.id_sin
where d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') = 'OUI' -- [PM158-8]
	And  c.valide_le between @dtDeb and @dtFin
	And  c.cod_etat in ( 'RPC' )
	And c.id_four='VPP'
	And Not Exists (select * 
		from sysadm.commande c2
		where c2.id_sin=c.id_sin and c.id_seq < c2.id_seq and c2.cod_etat <> 'ANN')

-- [VDoc19068]
insert into #tmp_maj_sms_stf 
select s.id_sin, 2 as id_appli, NULL,
	s.id_prod,
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'CODE'),
	sysadm.FN_LIB_ETAT_DOS_ASSURE(s.id_sin,'LIB')
from sysadm.sinistre s
	inner join sysadm.det_pro d on s.id_prod=d.id_prod
	inner join sysadm.commande c on c.id_sin=s.id_sin
	inner join sysadm.div_sin ds on ds.id_sin=s.id_sin
where d.id_code_dp=202
	and sysadm.FN_CLE_VAL('ENVOI_SMS',d.val_car,';') = 'OUI' 
	And	c.dte_env_cli is null
	And c.cod_etat in ('ECT','RPC') 
	And c.valide_le between @dtDeb and @dtFin
	And Not Exists (select * 
		from sysadm.commande c2
		where c2.id_sin=c.id_sin and c.id_seq < c2.id_seq and c2.cod_etat <> 'ANN')
	And c.id_typ_art='CAF'
	And c.id_ref_four <> 'SBE' -- [ITSM468665]
	and ds.nom_zone='etat_vu_assure'
	and ds.val_nbre in (1510,1500) 
	
-- Récupération du num tél
Update #tmp_maj_sms_stf 
set num_tel=Case When SUBSTRING(LTRIM(i.num_teld),1,2) in ('06','07') Then LTRIM(i.num_teld)
	When SUBSTRING(LTRIM(i.num_telb),1,2) in ('06','07') Then LTRIM(i.num_telb)
	When SUBSTRING(LTRIM(i.num_port_sms),1,2) in ('06','07') Then LTRIM(i.num_port_sms)
	When Substring(s.num_port,1,2) in ('06','07') Then LTRIM(s.num_port)
	Else NULL End
From #tmp_maj_sms_stf  t
	inner join sysadm.sinistre s on s.id_sin=t.id_sin
	inner join sysadm.inter i on i.id_sin=t.id_sin
where t.id_appli=2 and i.cod_inter='A'

delete #tmp_maj_sms_stf  where id_appli=2 and num_tel is null

 If @asCodeTrt='EXTRACT'  
 Begin 
	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO')
	Begin
		select * from #tmp_maj_sms_stf t
		where not exists (select 1 
			from SHERPA_PRO.sysadm.mail_satisfaction m
			where m.id_appli=t.id_appli and m.id_sin=t.id_sin)
	End
	Else
	Begin
		select * from #tmp_maj_sms_stf t
		where not exists (select 1 
			from SHERPA_SIM.sysadm.mail_satisfaction m
			where m.id_appli=t.id_appli and m.id_sin=t.id_sin)
	End
	
 End
-- Traitement
If  @asCodeTrt='ENVOI'
Begin
	-- Insertion en bloc dans la table 'mail_satisfaction' de SHERPA
	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO')
	Begin
		exec SHERPA_PRO.sysadm.PS_I01_SMS_SATISFACTION
	End
	Else
	Begin
		exec SHERPA_SIM.sysadm.PS_I01_SMS_SATISFACTION
	End
End



Go

grant execute on sysadm.PS_MAJ_SMS_SATISFACTION to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S015_LSTREG_DAS
-- Auteur               :       FPI
-- Date                 :       15/12/2011
-- Libellé              :        
-- Commentaires         :       Liste détaillée des réglements pour DAS
-- Références           :       [VDoc6179] Variante de PS_S015_LSTREG pour DAS - aggrégation
--
--				EURO
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--				
-- Retourne             :       Rien
-------------------------------------------------------------------
-- [VDoc7724] Ajout des 2 dernières colonnes (mt sin + mt frais)
-- [VDoc7895] ajout des 4 colonnes de garantie constructeur 
-- [VDoc8092] duree_gti_DAS + neuf/occasion
-- [VDOC10924] JFF 15/04/2013 - Modification suite Audit DAS
-- [VDOC12649] JFF 22/11/2013 - Ajout zone Type Evènement
-- [VDOC13769] JFF 21/02/2014 - ajout zone fournisseur réglé + modif valeur dans zone garantie 
-- [DT119]	- V01 - FPI - supp colonnes Mt_total_achat & alt_plaf + ajout mt remisé
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S015_LSTREG_DAS_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S015_LSTREG_DAS_V01
GO

CREATE procedure sysadm.PS_S015_LSTREG_DAS_V01 
	@dtDteDeb       DateTime        ,
    @dtDteFin       DateTime	

AS

SET NOCOUNT ON

Declare @sPerReglt varchar(7)
 
Set @sPerReglt=CONVERT(varchar(2),datePart(month,@dtDteFin))
If LEN(@sPerReglt)=1 Set @sPerReglt='0' + @sPerReglt
Set @sPerReglt=@sPerReglt + '/' + CONVERT(varchar(4),datePart(year,@dtDteFin))

Select distinct
 'PERIODE DE REGLT' = @sPerReglt,
 'GESTIONNAIRE' = 'SPB',
 'N° CONTRAT DAS'	= police.lib_police,
 'CIE ASS'	= compagnie.lib_cie,
 'SOUSCRIPTEUR'	= groupe.lib_grp,
 'INTITULE DU CONTRAT'	= produit.lib_long,
 'N° SINISTRE'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
  sysadm.FN_CODE_CAR(div_sin.val_car,'-AR') as genre,
  sinistre.marq_port as 'marque', 
 /* convert(varchar(10),sinistre.dte_ach_port,103) as 'date_achat', */
 -- [VDOC10924]
  Isnull ( 
  convert(varchar(30),
	  Case 
		When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti)
			Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null )
		Else sinistre.dte_ach_port
	  End ,103)
	, 'Pas de date d''achat' )   as 'date_achat',
  -- OLD (select top 1 detail.mt_val_achat from sysadm.detail where detail.id_sin=sinistre.id_sin) as mt_achat,
 -- [VDOC10924]
 -- [VDOC11052]
   IsNull ( 
	Case 
		When ( sinistre.id_prod between 45200 and 45299 ) Or ( sinistre.id_prod between 46500 and 46700 ) -- Cas des CONFO Excellence 
		  Then
			  -- [VDOC11052]
			  -- [ITSM224189] 965
			  Case 
				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  not in ( 1083, 1317, 934, 965 ) 
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  not in ( 1083, 1317, 934, 965 ) 
					   And   d.mt_val_achat <> 9999
					  )
					  
				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  = 1317
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  = 1317
					   And   d.mt_val_achat <> 9999
					  )

				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  = 934
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  = 934
					   And   d.mt_val_achat <> 9999
					  )		

				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  = 1083
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  = 1083
					   And   d.mt_val_achat <> 9999
					  )	

				-- [ITSM224189] 965					  
				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  = 965
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  = 965
					   And   d.mt_val_achat <> 9999
					  )	
					  
				Else 0
			End
					  		
		Else
			  (select top 1 d.mt_val_achat 
			   from sysadm.detail d
			   where d.id_sin=sinistre.id_sin
			   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
			   And   d.mt_val_achat <> 9999
			   And   d.mt_val_achat = ( Select MAX ( d1.mt_val_achat)
											 From  sysadm.detail d1
											 Where d1.id_sin = d.id_sin
											 And   d1.id_gti = d.id_gti
											 And   d1.id_detail = d.id_detail
											 And   d1.mt_val_achat <> 9999 )
			  )
	End
  , 0 ) as mt_achat,  -- [VDOC10924]
  sinistre.id_adh as no_adhesion, 
  convert(varchar(10),sinistre.dte_adh,103) as dte_adh, 
 'date déb garantie' = convert(varchar(10),sinistre.dte_adh,103), 
  convert(varchar(10),sinistre.dte_fin_gti,103) as dte_fin_gti,
  convert(varchar(10),sinistre.dte_surv,103) as dte_surv, 
  datepart(year,sinistre.dte_surv) as annee_surv,
  datepart(month,sinistre.dte_surv) as mois_surv, 
 convert(varchar(10),sinistre.dte_decl,103) as dte_decl,
 'type_garantie' 		= code_Ns.lib_code,
 'garantie' 		= code_Gs.lib_code,
 -- 'ALT_PLAF'	= gar_sin.alt_plaf, -- [DT119]
 (select max(detail.mt_plaf) from sysadm.detail where detail.id_sin=gar_sin.id_sin and detail.id_gti=gar_sin.id_gti) as mt_plafond,
 'quantité sinistre' =
	Case 
		When ( sinistre.id_prod between 45200 and 45299 ) Or ( sinistre.id_prod between 46500 and 46700 ) -- Cas des CONFO Excellence 
	   		Then
	   		( Select sum ( ds.val_nbre )
	   		From   sysadm.div_det ds
	   		Where  ds.id_sin = sinistre.id_sin
	   		And    ds.nom_zone = 'qte' )
		Else
			reg_gti.mt_reg / (select max(detail.mt_plaf) from sysadm.detail where detail.id_sin=gar_sin.id_sin and detail.id_gti=gar_sin.id_gti)
    End,		
 'mt_total plafond' = reg_gti.mt_reg,
 'DTE_REG'	= convert(varchar(10),reg_gti.maj_le,103) + ' ' + convert(varchar(10),reg_gti.maj_le,108), -- [ITSM166043]
 'MT_REG_GTI'	= reg_gti.mt_reg,
 /* Old
 (select top 1 mt_val_publique from sysadm.detail 
	where detail.id_sin=sinistre.id_sin and detail.id_sin=reg_gti.id_sin 
	and mt_val_publique > 0
	) as 'montant_sinistre',
  */
 -- [VDOC10924]
  IsNull ( 
  (select top 1 d.mt_val_publique 
   from sysadm.detail d
   where d.id_sin=sinistre.id_sin
   And   d.mt_val_publique = ( Select MAX ( d1.mt_val_publique)
								 From  sysadm.detail d1
								 Where d1.id_sin = d.id_sin
								 And   d1.id_gti = d.id_gti
								 And   d1.id_detail = d.id_detail )
  ), 0 ) as 'montant_sinistre',  -- [VDOC10924]
  (select SUM(mt_frais) from sysadm.frais where frais.id_sin=sinistre.id_sin and frais.id_typ_frais=1) as frais_transport,
/*
  case When d2.val_nbre is not null Then  convert(varchar(10),sinistre.dte_adh,103) Else '' End as dte_deb_gc,
*/
 -- [VDOC10924]	
  Nullif( 
  convert(varchar(10),
	  Case When d2.val_nbre is not null 
			Then 
			  Case 
				When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti)
					Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null )
				Else sinistre.dte_ach_port
			  End
		   Else '' 
	  End ,103) 
  , '01/01/1900' )
  as dte_deb_gc,
/*  case When d2.val_nbre is not null Then convert(varchar(10),DateAdd(Month,d2.val_nbre,sinistre.dte_adh),103) Else '' End as dte_fin_gc, */
 -- [VDOC10924][VDOC11052]
  case When d2.val_nbre is not null 
        Then convert(varchar(10),DateAdd(Month,d2.val_nbre,
			  Case 
				When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti)
					Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null )
				Else sinistre.dte_ach_port
			  End
			),103) Else '' End as dte_fin_gc,
  case When d2.val_nbre is null Then  convert(varchar(10),sinistre.dte_adh,103) 
	Else convert(varchar(10),DateAdd(day, 1, DateAdd(Month,d2.val_nbre,sinistre.dte_adh)),103) End as dte_deb_gti_DAS,
  convert(varchar(10),sinistre.dte_fin_gti,103) as dte_fin_gti_DAS,
  /*(select top 1 sysadm.FN_CLE_VAL('PGC_MOIS',val_car,';') + ' mois' from sysadm.det_pro 
    where det_pro.id_prod=sinistre.id_prod and det_pro.id_code_dp=85) as duree_garantie_das,*/
-- [VDOC10924][VDOC11052] duréé garantie DAS : = date achat - date fin garantie  
--   Convert ( VarChar ( 10),( Convert ( VarChar ( 10), IsNull ( ABS ( DATEDIFF ( MONTH, IsNull ( sinistre.dte_ach_port, IsNull ( sinistre.dte_adh, (Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null ))), sinistre.dte_fin_gti ) ) , 0 ) ) + '' )) as duree_garantie_das_Mois,
	Convert ( VarChar ( 10),( Convert ( VarChar ( 10), IsNull ( ABS ( DATEDIFF ( MONTH, IsNull ( sinistre.dte_ach_port, 
			  IsNUll ( 
			  (Case 
				When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti)
					Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null )
				Else sinistre.dte_ach_port
			  End), sinistre.dte_adh )), sinistre.dte_fin_gti ) ) , 0 ) ) + '' )) as duree_garantie_das_Mois,  			  
 
  case When d2.val_nbre is null Then 'Neuf'
	When d2.val_nbre = 3 Then 'Occasion'
	Else 'Neuf' 
  End as 'Neuf/Occasion',
-- [VDOC10924]
  IsNull (
	  (Select Top 1 rTrim( Convert ( VarChar ( 30), ds.val_nbre ) + '')
	   From	 sysadm.div_sin ds,
			 sysadm.det_pro dp
	   Where dp.id_prod = sinistre.id_prod
	   And   dp.id_code_dp = 85
	   And   ds.id_sin = sinistre.id_sin
	   And   ds.nom_zone= 'duree_gti_origine')
   , 'Non géré sur le contrat' ) As 'Durée_GC(si PGC)',
-- [VDOC10924]
	/*IsNull (
	Case 
		When ( sinistre.id_prod between 45200 and 45299 ) Or ( sinistre.id_prod between 46500 and 46700 ) -- Cas des CONFO Excellence 
		  Then
		     (select sum ( isnull ( d.mt_val_achat, 0 ) )
			   from sysadm.detail d
			   where d.id_sin=sinistre.id_sin
			   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
			   And   d.id_evt  not in ( 1083, 1317, 934, 965 ) -- [ITSM224189] 965
			   And   d.mt_val_achat <> 9999
			  ) 
		Else
		  (select top 1 d.mt_val_achat 
		   from sysadm.detail d
		   where d.id_sin=sinistre.id_sin
		   And   d.mt_val_achat <> 9999
		   And   d.mt_val_achat = ( Select MAX ( d1.mt_val_achat)
										 From  sysadm.detail d1
										 Where d1.id_sin = d.id_sin
										 And   d1.id_gti = d.id_gti
										 And   d1.id_detail = d.id_detail
										 And   d1.mt_val_achat <> 9999 )
		  )*
		  Case 
			When IsNull ( (reg_gti.mt_reg / (select max(detail.mt_plaf) from sysadm.detail where detail.id_sin=gar_sin.id_sin and detail.id_gti=gar_sin.id_gti)), 0 ) < 1
				 Then 1
			Else IsNull ( (reg_gti.mt_reg / (select max(detail.mt_plaf) from sysadm.detail where detail.id_sin=gar_sin.id_sin and detail.id_gti=gar_sin.id_gti)), 0 ) 
		  End 
	End , 0 ) 'Montant_Total_Achat',*/ -- [DT119]
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) as typ_evt, -- VDOC12649 	
  IsNUll ( 
	  ( Select Top 1 sysadm.FN_CODE_CAR ( i.id_four, '-FR' )
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c,
			 sysadm.inter i
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		And   i.id_sin = r.id_sin
		And   i.id_i = r.id_i
		And   i.cod_inter = 'F'
		 ),
		'ASSURE' ) as Inter_Regl, -- [VDOC13769]
		 IsNull (
			(Select Top 1 rTrim( Convert ( VarChar ( 30), ds.val_mt ) + '' )
			From	 sysadm.div_sin ds,
				 sysadm.div_pro dp
			Where dp.id_prod = sinistre.id_prod
				And   ds.id_sin = sinistre.id_sin
				And   ds.nom_zone= 'mt_val_achat_remise'
				and ds.nom_zone=dp.nom_zone)
		, '' ) As 'Montant achat remisé'
 From
 sysadm.reg_gti   
  inner join sysadm.sinistre  on reg_gti.id_sin	=	sinistre.id_sin
  inner join sysadm.produit on sinistre.id_prod	=	produit.id_prod
 left outer join sysadm.div_sin on div_sin.id_sin = sinistre.id_sin and div_sin.nom_zone='type_app'
 left outer join sysadm.div_sin d2 on d2.id_sin = sinistre.id_sin and d2.nom_zone='duree_gti_origine'
 inner join sysadm.personne on personne.id_ordre    = 	sinistre.id_ordre
 inner join sysadm.gar_sin on reg_gti.id_sin	=	gar_sin.id_sin	and reg_gti.id_gti	=	gar_sin.id_gti
 inner join sysadm.garantie on  garantie.id_prod	=	sinistre.id_prod and  garantie.id_rev	=	sinistre.id_rev	and garantie.id_gti	=	reg_gti.id_gti
 inner join sysadm.police on garantie.id_police	=	police.id_police,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.compagnie,
 sysadm.reglement
Where 
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( police.id_cie=93		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 reglement.dte_reg between    @dtDteDeb And @dtDteFin and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 


UNION 
Select distinct
 'PERIODE DE REGLT' = @sPerReglt,
 'GESTIONNAIRE' = 'SPB',
 'N° CONTRAT DAS'	= police.lib_police,
 'CIE ASS'	= compagnie.lib_cie,
 'SOUSCRIPTEUR'	= groupe.lib_grp,
 'INTITULE DU CONTRAT'	= produit.lib_long,
 'N° SINISTRE'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
  sysadm.FN_CODE_CAR(div_sin.val_car,'-AR') as genre,
  sinistre.marq_port as 'marque', 
 /* convert(varchar(10),sinistre.dte_ach_port,103) as 'date_achat', */
-- [VDOC10924]
  Isnull ( 
  convert(varchar(30),
  Case 
	When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti)
		Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null )
	Else sinistre.dte_ach_port
  End ,103) 
  , 'Pas de date d''achat' )   as 'date_achat',
-- (select top 1 detail.mt_val_achat from sysadm.detail where detail.id_sin=sinistre.id_sin) as mt_achat,
-- [VDOC11052]
   IsNull ( 
	Case 
		When ( sinistre.id_prod between 45200 and 45299 ) Or ( sinistre.id_prod between 46500 and 46700 ) -- Cas des CONFO Excellence 
		  Then
			  -- [VDOC11052]
			  Case 
				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  not in ( 1083, 1317, 934, 965 ) 
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  not in ( 1083, 1317, 934, 965 ) 
					   And   d.mt_val_achat <> 9999
					  )
					  
				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  = 1317
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  = 1317
					   And   d.mt_val_achat <> 9999
					  )

				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  = 934
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  = 934
					   And   d.mt_val_achat <> 9999
					  )		

				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  = 1083
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
					   And   d.id_evt  = 1083
					   And   d.mt_val_achat <> 9999
					  )	
				Else 0
			End
					  		
		Else
			  (select top 1 d.mt_val_achat 
			   from sysadm.detail d
			   where d.id_sin=sinistre.id_sin
			   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti )
			   And   d.mt_val_achat <> 9999
			   And   d.mt_val_achat = ( Select MAX ( d1.mt_val_achat)
											 From  sysadm.detail d1
											 Where d1.id_sin = d.id_sin
											 And   d1.id_gti = d.id_gti
											 And   d1.id_detail = d.id_detail
											 And   d1.mt_val_achat <> 9999 )
			  )
	End
  , 0 ) as mt_achat,  -- [VDOC10924]
  sinistre.id_adh as no_adhesion, 
  convert(varchar(10),sinistre.dte_adh,103) as dte_adh, 
 'date déb  garantie' = convert(varchar(10),sinistre.dte_adh,103),
  convert(varchar(10),sinistre.dte_fin_gti,103) as dte_fin_gti,
  convert(varchar(10),sinistre.dte_surv,103) as dte_surv, 
  datepart(year,sinistre.dte_surv) as annee_surv,
  datepart(month,sinistre.dte_surv) as mois_surv, 
 convert(varchar(10),sinistre.dte_decl,103) as dte_decl,
 'type_garantie' 		= code_Ns.lib_code,
 'garantie' 		= code_Nf.lib_code,
 -- 'ALT_PLAF'	= 'N', -- [DT119]
  frais.mt_frais as mt_plafond,
 'quantité sinistre' = 
	Case 
		When ( sinistre.id_prod between 45200 and 45299 ) Or ( sinistre.id_prod between 46500 and 46700 ) -- Cas des CONFO Excellence 
	   		Then
	   		( Select sum ( ds.val_nbre )
	   		From   sysadm.div_det ds
	   		Where  ds.id_sin = sinistre.id_sin
	   		And    ds.nom_zone = 'qte' )
		Else
			reg_gti.mt_reg / frais.mt_frais
    End,
 'mt_total plafond' = reg_gti.mt_reg,
 'DTE_REG'	= convert(varchar(10),reg_gti.maj_le,103) + ' ' + convert(varchar(10),reg_gti.maj_le,108), -- [ITSM166043]
 'MT_REG_GTI'	= reg_gti.mt_reg,
 (select top 1 mt_val_publique from sysadm.detail 
	where detail.id_sin=sinistre.id_sin and detail.id_sin=reg_gti.id_sin 
	and mt_val_publique > 0
	) as 'montant_sinistre',
  (select SUM(mt_frais) from sysadm.frais where frais.id_sin=sinistre.id_sin and frais.id_typ_frais=1) as frais_transport,
/*
  case When d2.val_nbre is not null Then  convert(varchar(10),sinistre.dte_adh,103) Else '' End as dte_deb_gc,
*/
 -- [VDOC10924]	
  Nullif ( 
  case When d2.val_nbre is not null Then convert(varchar(10),
		  Case 
			When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti)
				Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null )
			Else sinistre.dte_ach_port
		  End
		,103) 
		Else '' 
	End 
	, '01/01/1900' )
	as dte_deb_gc,
/*  case When d2.val_nbre is not null Then convert(varchar(10),DateAdd(Month,d2.val_nbre,sinistre.dte_adh),103) Else '' End as dte_fin_gc, */
 -- [VDOC10924]	
  case When d2.val_nbre is not null Then convert(varchar(10),DateAdd(Month,d2.val_nbre,
		  Case 
			When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti)
				Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null )
			Else sinistre.dte_ach_port
		  End
			),103) Else '' End as dte_fin_gc,
   case When d2.val_nbre is null Then  convert(varchar(10),sinistre.dte_adh,103) 
	Else convert(varchar(10),DateAdd(day, 1, DateAdd(Month,d2.val_nbre,sinistre.dte_adh)),103) End as dte_deb_gti_DAS,
  convert(varchar(10),sinistre.dte_fin_gti,103) as dte_fin_gti_DAS,
  /*(select top 1 sysadm.FN_CLE_VAL('PGC_MOIS',val_car,';') + ' mois' from sysadm.det_pro 
    where det_pro.id_prod=sinistre.id_prod and det_pro.id_code_dp=85) as duree_garantie_das,*/
-- [VDOC10924]
--   Convert ( VarChar ( 10),Convert ( VarChar ( 10), IsNull ( ABS ( DATEDIFF ( MONTH, sinistre.dte_adh, sinistre.dte_fin_gti ) ) , 0 ) ) + '' ) as duree_garantie_das_Mois,
-- [VDOC10924][VDOC11052] duréé garantie DAS : = date achat - date fin garantie  
--   Convert ( VarChar ( 10),( Convert ( VarChar ( 10), IsNull ( ABS ( DATEDIFF ( MONTH, IsNull ( sinistre.dte_ach_port, IsNull ( sinistre.dte_adh, (Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null ))), sinistre.dte_fin_gti ) ) , 0 ) ) + '' )) as duree_garantie_das_Mois,
	Convert ( VarChar ( 10),( Convert ( VarChar ( 10), IsNull ( ABS ( DATEDIFF ( MONTH, IsNull ( sinistre.dte_ach_port, 
			  IsNUll ( 
			  (Case 
				When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti)
					Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null )
				Else sinistre.dte_ach_port
			  End), sinistre.dte_adh )), sinistre.dte_fin_gti ) ) , 0 ) ) + '' )) as duree_garantie_das_Mois,  	
  case When d2.val_nbre is null Then 'Neuf'
	When d2.val_nbre = 3 Then 'Occasion'
	Else 'Neuf'
  End as 'Neuf/Occasion',
-- [VDOC10924]
  IsNull (
	  (Select Top 1 rTrim( Convert ( VarChar ( 30), ds.val_nbre ) + '' )
	   From	 sysadm.div_sin ds,
			 sysadm.det_pro dp
	   Where dp.id_prod = sinistre.id_prod
	   And   dp.id_code_dp = 85
	   And   ds.id_sin = sinistre.id_sin
	   And   ds.nom_zone= 'duree_gti_origine')
   , 'Non géré sur le contrat' ) As 'Durée_GC(si PGC)',
  /*IsNull ( 
        	Case 
        		When ( sinistre.id_prod between 45200 and 45299 ) Or ( sinistre.id_prod between 46500 and 46700 ) -- Cas des CONFO Excellence 
        		  Then
        		     (select sum ( d.mt_val_achat )
        			   from sysadm.detail d
        			   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = ( Select top 1 id_gti from code_garantie c where c.id_prod = sinistre.id_prod and c.id_gti = reg_gti.id_gti ) -- [ITSM224189] 965
					   And   d.id_evt  not in ( 1083, 1317, 934, 965 ) 
        			   And   d.mt_val_achat <> 9999
        			  ) 
        		Else
        		  (select top 1 d.mt_val_achat 
        		   from sysadm.detail d
        		   where d.id_sin=sinistre.id_sin
        		   And   d.mt_val_achat <> 9999
        		   And   d.mt_val_achat = ( Select MAX ( d1.mt_val_achat)
        										 From  sysadm.detail d1
        										 Where d1.id_sin = d.id_sin
        										 And   d1.id_gti = d.id_gti
        										 And   d1.id_detail = d.id_detail
        										 And   d1.mt_val_achat <> 9999 )
        		  )*
        		  Case 
        			When reg_gti.mt_reg / frais.mt_frais < 1
        				 Then 1
        			Else reg_gti.mt_reg / frais.mt_frais
        		  End
    		  End
    	   , 0 )  'Montant_Total_Achat',*/ -- [DT119]
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) as typ_evt, -- VDOC12649  
  IsNUll ( 
	  ( Select Top 1 sysadm.FN_CODE_CAR ( i.id_four, '-FR' )
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c,
			 sysadm.inter i
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		And   i.id_sin = r.id_sin
		And   i.id_i = r.id_i
		And   i.cod_inter = 'F'
		 ),
		'ASSURE' ) as Inter_Regl, -- [VDOC13769]
		 IsNull (
			(Select Top 1 rTrim( Convert ( VarChar ( 30), ds.val_mt ) + '' )
			From	 sysadm.div_sin ds,
				 sysadm.div_pro dp
			Where dp.id_prod = sinistre.id_prod
				And   ds.id_sin = sinistre.id_sin
				And   ds.nom_zone= 'mt_val_achat_remise'
				and ds.nom_zone=dp.nom_zone)
		, '' ) As 'Montant achat remisé'
		
From
 sysadm.reg_gti   
  inner join sysadm.sinistre  on reg_gti.id_sin	=	sinistre.id_sin
  inner join sysadm.produit on sinistre.id_prod	=	produit.id_prod
 left outer join sysadm.div_sin on div_sin.id_sin = sinistre.id_sin and div_sin.nom_zone='type_app'
 left outer join sysadm.div_sin d2 on d2.id_sin = sinistre.id_sin and d2.nom_zone='duree_gti_origine'
 inner join sysadm.personne on personne.id_ordre    = 	sinistre.id_ordre
 inner join sysadm.frais on reg_gti.id_sin	=	frais.id_sin and reg_gti.id_reg	=	frais.id_reg,
 sysadm.garantie,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement
Where 
 ( reg_gti.id_gti	=	-1			)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( police.id_cie=93		)	and
 ( reglement.dte_reg    between    @dtDteDeb And @dtDteFin )	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 

UNION 

Select distinct
 'PERIODE DE REGLT' = @sPerReglt,
 'GESTIONNAIRE' = 'SPB',
 'N° CONTRAT DAS'	= police.lib_police,
 'CIE ASS'	= compagnie.lib_cie,
 'SOUSCRIPTEUR'	= groupe.lib_grp,
 'INTITULE DU CONTRAT'	= produit.lib_long,
 'N° SINISTRE'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
  sysadm.FN_CODE_CAR(div_sin.val_car,'-AR') as genre,
  sinistre.marq_port as 'marque', 
/* convert(varchar(10),sinistre.dte_ach_port,103) as 'date_achat', */
-- [VDOC10924]
  IsNull ( 
  convert(varchar(30),
	  Case 
		When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti )
			Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.dte_det is not null )
		Else sinistre.dte_ach_port
	  End ,103) 
  , 'Pas de date d''achat' )   as 'date_achat',
-- (select top 1 detail.mt_val_achat from sysadm.detail where detail.id_sin=sinistre.id_sin) as mt_achat,
-- [VDOC11052]
   IsNull ( 
	Case 
		When ( sinistre.id_prod between 45200 and 45299 ) Or ( sinistre.id_prod between 46500 and 46700 ) -- Cas des CONFO Excellence 
		  Then
			  -- [VDOC11052]
			  Case 
				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  not in ( 1083, 1317, 934, 965 )  -- [ITSM224189] 965
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  not in ( 1083, 1317, 934, 965 ) 
					   And   d.mt_val_achat <> 9999
					  )
					  
				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  = 1317
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  = 1317
					   And   d.mt_val_achat <> 9999
					  )

				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  = 934
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  = 934
					   And   d.mt_val_achat <> 9999
					  )		

				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  = 1083
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  = 1083
					   And   d.mt_val_achat <> 9999
					  )	
					  
				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  = 965
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  = 965
					   And   d.mt_val_achat <> 9999
					  )	
					  					  
				Else 0
			End
					  		
		Else
			  (select top 1 d.mt_val_achat 
			   from sysadm.detail d
			   where d.id_sin=sinistre.id_sin
			   And   d.mt_val_achat <> 9999
			   And   d.mt_val_achat = ( Select MAX ( d1.mt_val_achat)
											 From  sysadm.detail d1
											 Where d1.id_sin = d.id_sin
											 And   d1.id_gti = d.id_gti
											 And   d1.id_detail = d.id_detail
											 And   d1.mt_val_achat <> 9999 )
			  )
	End
  , 0 ) as mt_achat,  -- [VDOC10924]
  sinistre.id_adh as no_adhesion, 
  convert(varchar(10),sinistre.dte_adh,103) as dte_adh,  
  'date déb  garantie' = convert(varchar(10),sinistre.dte_adh,103),
  convert(varchar(10),sinistre.dte_fin_gti,103) as dte_fin_gti,
  convert(varchar(10),sinistre.dte_surv,103) as dte_surv, 
  datepart(year,sinistre.dte_surv) as annee_surv,
  datepart(month,sinistre.dte_surv) as mois_surv, 
  convert(varchar(10),sinistre.dte_decl,103) as dte_decl,
 'type_garantie' 		= code_Ns.lib_code,
 'garantie' 		= 
		Case 
			When reglement.cod_mode_reg = 'FM' and reglement.cod_mot_reg = 'RM' Then 'REGUL MOINS AVEC AVOIR'
			When reglement.cod_mode_reg = 'FM' and reglement.cod_mot_reg = 'RP' Then 'REGUL PLUS AVEC AVOIR'			
			When reglement.cod_mode_reg = 'C' and reglement.cod_mot_reg = 'RM' Then 'REGUL MOINS'			
			When reglement.cod_mode_reg = 'C' and reglement.cod_mot_reg = 'RP' Then 'REGUL PLUS'						
			Else 'REGULARISATION'
		End	, -- VDOC12649
  -- 'ALT_PLAF'	= 'N',-- [DT119]
  reglement.mt_tot_reg as mt_plafond,
  'quantité sinistre' = 1,
  'mt_total plafond' = reglement.mt_tot_reg,
  'DTE_REG'	= convert(varchar(10),reglement.dte_reg,103)+ ' ' + convert(varchar(10),reglement.maj_le,108), -- [ITSM166043]
   'MT_REG_GTI'	= reglement.mt_tot_reg,
 (select top 1 mt_val_publique from sysadm.detail 
	where detail.id_sin=sinistre.id_sin and detail.id_sin=reglement.id_sin 
	and mt_val_publique > 0
	) as 'montant_sinistre',
  (select SUM(mt_frais) from sysadm.frais where frais.id_sin=sinistre.id_sin and frais.id_typ_frais=1) as frais_transport,
/*
  case When d2.val_nbre is not null Then  convert(varchar(10),sinistre.dte_adh,103) Else '' End as dte_deb_gc,
*/
 -- [VDOC10924]	
  nullif ( 
  case When d2.val_nbre is not null Then convert(varchar(10),
		  Case 
			When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod )
				Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.dte_det is not null )
			Else sinistre.dte_ach_port
		  End
			,103) 
		Else '' 
   End, 
   '01/01/1900' )
   as dte_deb_gc,
/*  case When d2.val_nbre is not null Then convert(varchar(10),DateAdd(Month,d2.val_nbre,sinistre.dte_adh),103) Else '' End as dte_fin_gc, */
 -- [VDOC10924]	
  case When d2.val_nbre is not null Then convert(varchar(10),DateAdd(Month,d2.val_nbre,
	  Case 
		When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod )
			Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.dte_det is not null )
		Else sinistre.dte_ach_port
	  End
		),103) Else '' End as dte_fin_gc,
   case When d2.val_nbre is null Then  convert(varchar(10),sinistre.dte_adh,103) 
	Else convert(varchar(10),DateAdd(day, 1, DateAdd(Month,d2.val_nbre,sinistre.dte_adh)),103) End as dte_deb_gti_DAS,
  convert(varchar(10),sinistre.dte_fin_gti,103) as dte_fin_gti_DAS,
  /*(select top 1 sysadm.FN_CLE_VAL('PGC_MOIS',val_car,';') + ' mois' from sysadm.det_pro 
    where det_pro.id_prod=sinistre.id_prod and det_pro.id_code_dp=85) as duree_garantie_das,*/
-- [VDOC10924]
--    Convert ( VarChar ( 10), Convert ( VarChar ( 10), IsNull ( ABS ( DATEDIFF ( MONTH, sinistre.dte_adh, sinistre.dte_fin_gti ) ) , 0 ) ) + '' ) as duree_garantie_das_Mois,
-- [VDOC10924][VDOC11052] duréé garantie DAS : = date achat - date fin garantie  
--   Convert ( VarChar ( 10),( Convert ( VarChar ( 10), IsNull ( ABS ( DATEDIFF ( MONTH, IsNull ( sinistre.dte_ach_port, IsNull ( sinistre.dte_adh, (Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null ))), sinistre.dte_fin_gti ) ) , 0 ) ) + '' )) as duree_garantie_das_Mois,
	Convert ( VarChar ( 10),( Convert ( VarChar ( 10), IsNull ( ABS ( DATEDIFF ( MONTH, IsNull ( sinistre.dte_ach_port, 
			  IsNUll ( 
			  (Case 
				When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod )
					Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.dte_det is not null )
				Else sinistre.dte_ach_port
			  End), sinistre.dte_adh )), sinistre.dte_fin_gti ) ) , 0 ) ) + '' )) as duree_garantie_das_Mois,  	
  case When d2.val_nbre is null Then 'Neuf'
	When d2.val_nbre = 3 Then 'Occasion'
	Else 'Neuf'
  End as 'Neuf/Occasion',
-- [VDOC10924]
  IsNull (
	  (Select Top 1 rTrim( Convert ( VarChar ( 30), ds.val_nbre ) + '' )
	   From	 sysadm.div_sin ds,
			 sysadm.det_pro dp
	   Where dp.id_prod = sinistre.id_prod
	   And   dp.id_code_dp = 85
	   And   ds.id_sin = sinistre.id_sin
	   And   ds.nom_zone= 'duree_gti_origine')
   , 'Non géré sur le contrat' ) As 'Durée_GC(si PGC)',
 /* IsNull ( 
  Case 
        		When ( sinistre.id_prod between 45200 and 45299 ) Or ( sinistre.id_prod between 46500 and 46700 ) -- Cas des CONFO Excellence 
        		  Then
        		     (select sum ( d.mt_val_achat )
        			   from sysadm.detail d
        			   where d.id_sin=sinistre.id_sin
        			   And   d.id_evt  not in ( 1083, 1317, 934, 965 )  -- [ITSM224189] 965
        			   And   d.mt_val_achat <> 9999
        			  ) 
        		Else
        		  (select top 1 d.mt_val_achat 
        		   from sysadm.detail d
        		   where d.id_sin=sinistre.id_sin
        		   And   d.mt_val_achat <> 9999
        		   And   d.mt_val_achat = ( Select MAX ( d1.mt_val_achat)
        										 From  sysadm.detail d1
        										 Where d1.id_sin = d.id_sin
        										 And   d1.id_gti = d.id_gti
        										 And   d1.id_detail = d.id_detail
        										 And   d1.mt_val_achat <> 9999 )
        		  )
    		  End , 0 ) 'Montant_Total_Achat',*/-- [DT119]
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) as typ_evt, -- VDOC12649    
  IsNUll ( 
	  ( Select Top 1 sysadm.FN_CODE_CAR ( i.id_four, '-FR' )
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c,
			 sysadm.inter i
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		And   i.id_sin = r.id_sin
		And   i.id_i = r.id_i
		And   i.cod_inter = 'F'
		 ),
		'ASSURE' ) as Inter_Regl, -- [VDOC13769]
		 IsNull (
			(Select Top 1 rTrim( Convert ( VarChar ( 30), ds.val_mt ) + '' )
			From	 sysadm.div_sin ds,
				 sysadm.div_pro dp
			Where dp.id_prod = sinistre.id_prod
				And   ds.id_sin = sinistre.id_sin
				And   ds.nom_zone= 'mt_val_achat_remise'
				and ds.nom_zone=dp.nom_zone)
		, '' ) As 'Montant achat remisé'
  
From
 sysadm.reglement 
  inner join sysadm.sinistre  on reglement.id_sin	=	sinistre.id_sin
  inner join sysadm.reg_gti on reglement.id_sin	= reg_gti.id_sin 
  inner join sysadm.produit on sinistre.id_prod	=	produit.id_prod
 left outer join sysadm.div_sin on div_sin.id_sin = sinistre.id_sin and div_sin.nom_zone='type_app'
 left outer join sysadm.div_sin d2 on d2.id_sin = sinistre.id_sin and d2.nom_zone='duree_gti_origine'
 inner join sysadm.personne on personne.id_ordre    = 	sinistre.id_ordre,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.police,
 sysadm.compagnie
Where 
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
  ( police.id_cie=93		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) )
Union
select '@@@@@@@@@@@@@@@@@@@@@@@@@@','@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'PERIODE DE REGLT','période SPB','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'GESTIONNAIRE','SPB','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'CONTRAT DAS','n° police','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'CIE ASS','DAS','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'SOUSCRIPTEUR','nom du souscripteur','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'INTITULE DU CONTRAT','libellé du contrat','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'N° SINISTRE','n° dossier SPB','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'NOM','nom assure','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'PRENOM','prénom assure','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'genre','type appareil','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'marque','marque appareil','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'date_achat','date achat','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'mt_achat','mt achat origine','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'no_adhesion','n° adhésion SPB','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'dte_adh','date adhésion','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'date déb garantie','date débt garantie','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'dte_fin_gti','date fin garantie','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'dte_surv','date survenance','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'annee_surv','année survenance','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'mois_surv','mois survenance','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'dte_decl','date déclaration par l''assuré','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'type_garantie','nature garantie sur dossier','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'garantie','garantie du contrat','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'mt_plafond','montant plafond','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'quantité sinistre','concerne annulation billetterie','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'mt_total plafond','multiple colonne Y notamment pour annulation billetterie','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'DTE_REG','date règlement sur dossier','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'MT_REG_GTI','montant réglé par SPB','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'montant_sinistre','valeur au moment du sinistre','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'frais_transport dte_deb_gc','date début garantie en cas d''extension garantie constructeur','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'dte_fin_gc','date fin garantie constructeur','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'dte_deb_gti_DAS','date début prise garantie par DAS','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'dte_fin_gti_DAS','date fin garantie par DAS','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'duree_garantie_das','durée garantie DAS','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'Neuf/Occasion','type appareil de remplacement','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL
Union
select 'Duree_GC_si_PGC','durée garantie constructeur','','','','',NULL,'','','','','',NULL,'','','','','',NULL,NULL,'','','',NULL,NULL,NULL,'',NULL,NULL,NULL,'','','','',NULL,'','','','',NULL

GO

grant execute on sysadm.PS_S015_LSTREG_DAS_V01 to rolebddsinistres
go
--------------------------------------------------------------------
--
-- Procédure            :       PS_S016_LSTREG_FINAREF
-- Auteur               :       FPI
-- Date                 :       15/12/2011
-- Libellé              :        
-- Commentaires         :       Liste détaillée des réglements pour FINAREF
-- Références           :       [VDoc6258] Variante de PS_S011_LSTREG pour Finaref - aggrégation
--
--				EURO
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				
-- Retourne             :       Rien
-------------------------------------------------------------------
-- FPI - 12/07/2012 VDoc 8176 - ajout du fournisseur réglé
-- JFF - 22/11/2013 VDOC12649 - Ajout zone Type Evènement
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S016_LSTREG_FINAREF' AND type = 'P' )
        DROP procedure sysadm.PS_S016_LSTREG_FINAREF
GO


CREATE procedure sysadm.PS_S016_LSTREG_FINAREF 
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)     

AS

SET NOCOUNT ON

Declare @result TABLE(
	maj_le DateTime,
	id_sin Decimal(10), -- [PI062]
	id_reg Decimal(2),
	id_prod Decimal(7),
	lib_prod varchar(65),
	cod_adh char(1),
	id_ets Decimal(7),
	lib_dept varchar(35),
	dte_surv DateTime,
	id_exercice int,
	id_mois_surv int,
	dte_decl DateTime,
	id_grp decimal(7),
	nat_sin varchar(35),
	id_gti decimal(7),
	id_rgpt decimal(7),
	lib_gti_stat varchar(35),
	mt_reg decimal(11,2),
	alt_plaf char(1),
	lib_groupe varchar(35),
	lib_police varchar(35),
	lib_cie varchar(35),
	nom varchar(35),
	prenom varchar(35),
	id_orian_boutique int,
	four_regle varchar(50),
	typ_evt VarChar ( 50) ) -- VDOC12649 

insert into @result
Select reg_gti.maj_le,
 sinistre.id_sin,
 reg_gti.id_reg,
 produit.id_prod,
 produit.lib_long,
 produit.cod_adh,
 sinistre.id_ets,
 departement.lib_dept,
 sinistre.dte_surv,
 NULL,NULL,
 sinistre.dte_decl,
 NULL,
 code_Ns.lib_code,
 reg_gti.id_gti,
 reg_gti.id_rgpt,
 code_Gs.lib_code,
 reg_gti.mt_reg,
 gar_sin.alt_plaf,
 NULL,
 police.lib_police,
 compagnie.lib_cie,
 personne.nom,
 personne.prenom,
 sinistre.id_orian_boutique,
   ( Select Top 1
		   Case i.cod_inter
				When 'F' Then 
					Case 
						When CharIndex ( 'FNC', sysadm.FN_CODE_CAR ( i.id_four, '-FR') ) > 0 Then 'FNAC'
						Else sysadm.FN_CODE_CAR ( i.id_four, '-FR')
					End 
				Else sysadm.FN_CODE_CAR ( i.cod_inter, '-IN')
		   End 
	From   sysadm.inter i
	Where  i.id_sin = reg_gti.id_sin
	And    i.id_i	= reg_gti.id_i
  ),
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) as typ_evt -- VDOC12649 
    
    
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( reg_gti.id_sin	=	gar_sin.id_sin		)	and
 ( reg_gti.id_gti	=	gar_sin.id_gti		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
( compagnie.id_cie	= 68)	and
  ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reglement.dte_reg   between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
 
 
insert into @result
Select 
 reg_gti.maj_le,
 sinistre.id_sin,
 reg_gti.id_reg,
 produit.id_prod,
 produit.lib_long,
 produit.cod_adh,
 sinistre.id_ets,
 departement.lib_dept,
 sinistre.dte_surv,
 NULL, NULL,
 sinistre.dte_decl,
 NULL,
 code_Ns.lib_code,
 reg_gti.id_gti,
 reg_gti.id_rgpt,
 code_Nf.lib_code,
 reg_gti.mt_reg,
 'N',
 NULL,
 police.lib_police,
 compagnie.lib_cie,
 personne.nom,
 personne.prenom,
 sinistre.id_orian_boutique,
  ( Select Top 1
		   Case i.cod_inter
				When 'F' Then 
					Case 
						When CharIndex ( 'FNC', sysadm.FN_CODE_CAR ( i.id_four, '-FR') ) > 0 Then 'FNAC'
						Else sysadm.FN_CODE_CAR ( i.id_four, '-FR')
					End 
				Else sysadm.FN_CODE_CAR ( i.cod_inter, '-IN')
		   End 
	From   sysadm.inter i
	Where  i.id_sin = reg_gti.id_sin
	And    i.id_i	= reg_gti.id_i
  ),
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' )  as typ_evt -- VDOC12649 
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.reglement
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
( compagnie.id_cie	= 68)	and
  ( reglement.dte_reg    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 

 
insert into @result
Select distinct
 reglement.dte_reg,
 sinistre.id_sin,
 reglement.id_reg,
 produit.id_prod,
 produit.lib_long,
 produit.cod_adh,
 sinistre.id_ets,
 departement.lib_dept,
 sinistre.dte_surv,
 NULL, 
 NULL,
 sinistre.dte_decl,
 NULL,
 code_Ns.lib_code,
 -2,
 -2,
 'REGULARISATION',
 reglement.mt_tot_reg,
 'N',
 NULL,
 police.lib_police,
 compagnie.lib_cie,
 personne.nom,
 personne.prenom,
 sinistre.id_orian_boutique,
  ( Select Top 1
		   Case i.cod_inter
				When 'F' Then 
					Case 
						When CharIndex ( 'FNC', sysadm.FN_CODE_CAR ( i.id_four, '-FR') ) > 0 Then 'FNAC'
						Else sysadm.FN_CODE_CAR ( i.id_four, '-FR')
					End 
				Else sysadm.FN_CODE_CAR ( i.cod_inter, '-IN')
		   End 
	From   sysadm.inter i
	Where  i.id_sin = reglement.id_sin
	And    i.id_i	= reglement.id_i
  ),
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' )  as typ_evt -- VDOC12649 
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.code code_Ns,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( compagnie.id_cie	= 68)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 

-- Maj du groupe
update @result
set id_grp=e.id_grp, lib_groupe=g.lib_grp
from sysadm.etablissement e, @result r, sysadm.groupe g
where cod_adh <> '3' and e.id_ets=r.id_ets
and e.id_prod=r.id_prod and e.id_rev=-1
and g.id_grp=e.id_grp

update @result
set id_grp=id_ets, lib_groupe=g.lib_grp
from  @result r, sysadm.groupe g
where cod_adh = '3' and r.id_ets=g.id_grp

-- Champs calculés
update @result
set id_exercice=DatePart ( year, dte_surv ),
 id_mois_surv=DatePart ( month, dte_surv )
 
Select distinct
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= maj_le,
 'ID_SIN'	= id_sin,
 'ID_REG'	= id_reg,
 'LIB_PROD'	= lib_prod,
 'LIB_DEPT'	= lib_dept,
 'DTE_SURV'	= dte_surv,
 'ID_EXERCICE'  = id_exercice,
 'ID_MOISSURV'	= id_mois_surv,
 'DTE_DECL'	= dte_decl,
 'ID_ETS'	= id_grp,
 'NS' 		= nat_sin,
 'ID_GTI'	= id_gti,
 'ID_RGPT'	= id_rgpt,
 'GA' 		= lib_gti_stat,
 'MT_REG_GTI'	= mt_reg,
 'ALT_PLAF'	= alt_plaf,
 'LIB_GRP'	= lib_groupe,
 'LIB_POLICE'	= lib_police,
 'LIB_CIE'	= lib_cie,
 'NOM'		= nom,
 'PRENOM'	= prenom,
 'ID_BOUTIQUE'	= id_orian_boutique,
 'FOURNISSEUR_REGLE' = four_regle,
 'TYPE_EVENEMENT' = typ_evt -- VDOC12649 
From @result

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_STAT_CONFORAMA
-- Auteur               :       FPI
-- Date                 :       26/12/2011
-- Libellé              :        
-- Commentaires         :       Liste détaillée des cartes avoir confo
-- Références           :       [PC680]
--
--				EURO
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--				
-- Retourne             :       Rien
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_STAT_CONFORAMA' AND type = 'P' )
        DROP procedure sysadm.DW_S01_STAT_CONFORAMA
GO

CREATE procedure sysadm.DW_S01_STAT_CONFORAMA 
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	

AS
  Select s.id_sin, p.nom, p.prenom,
	sysadm.FN_CODE_CAR(ds2.val_car,'-AR') as type_article,
	dd.val_mt as mt_pec,
	ds.val_car as no_carte_avoir,
	dd2.val_dte as dte_pec
  from sysadm.sinistre s
    inner join sysadm.personne p on p.id_ordre=s.id_ordre
    inner join sysadm.div_sin ds on ds.id_sin=s.id_sin -- no carte
    inner join sysadm.div_sin ds2 on ds2.id_sin=s.id_sin -- typ_app
    inner join sysadm.detail dt on s.id_sin=dt.id_sin -- 
    inner join sysadm.div_det dd on dd.id_sin=s.id_sin and dd.id_gti=dt.id_gti and dd.id_detail=dt.id_detail-- no mt_pec
    inner join sysadm.div_det dd2 on dd2.id_sin=s.id_sin and dd.id_gti=dt.id_gti and dd.id_detail=dt.id_detail-- dte_pec
  where s.id_prod between 45200 and 45299
    and ds.nom_zone='no_carte_avoir'
    and ds2.nom_zone='type_app'
    and dd.nom_zone='mt_pec'
    and dd2.nom_zone='dte_pec'
    and dt.id_evt=1317
    and dd2.val_dte between @dtDteDeb And @dtDteFin
    
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_STAT_CONFORAMA
-- Auteur               :       FPI
-- Date                 :       30/12/2011
-- Libellé              :        
-- Commentaires         :       Liste détaillée des cartes avoir confo - état mensuel
-- Références           :       [PC680]
--
--				EURO
--	
-- Arguments            :       
--				
-- Retourne             :       Rien
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_STAT_CONFORAMA' AND type = 'P' )
        DROP procedure sysadm.DW_S02_STAT_CONFORAMA
GO

CREATE procedure sysadm.DW_S02_STAT_CONFORAMA 
	

AS
  Declare @dtDteDeb       DateTime,
	@dtDteFin       DateTime,
	@dteToday datetime,
	@sCommande   VarChar(250),
    @sMessage    Varchar(255),
    @sObjet      VarChar(255),
    @sFicOut     VarChar(255),
	@sPath  VarChar(255),
    @sFileName   VarChar(255),
    @sFileExt    VarChar(3),
	@iRetOsql	int,	
	@sSuffixe varchar(8),
	@sRetour VarChar(255)  ,
	@sBase varchar(50)      


  Set @dteToday=getdate()
  Set @dtDteFin='01/' + convert(varchar(2),datepart(month,@dteToday)) + '/' + convert(varchar(4),datepart(year,@dteToday))
  Set @dtDteDeb=DateAdd(month, -1, @dtDteFin)
  
  select @sSuffixe=Case when (datepart(dd,@dteToday)) < 10 Then '0'
	Else '' End + 
	convert(varchar(2),datepart(dd,@dteToday)) + 
	Case when (datepart(mm,@dteToday)) < 10 Then '0'
	Else '' End + 
	convert(varchar(2),datepart(mm,@dteToday)) + 
	convert(varchar(4),datepart(yyyy,@dteToday))

  -- chemin d'enregistrement du Result Set
  Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT() + 'Sinistre\Extraction_Conforama\'
  Set @sFileName = 'CarteAvoirs_' + @sSuffixe
  Set @sFileExt	= 'xls'
  SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt
  
  IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		Set @sBase='SIMPA2_PRO'
	Else Set @sBase='SIMPA2_TRT'
	
  Set @sObjet    = 'Extraction mensuelle carte avoir Conforama'
  set @sMessage  = 'Veuillez trouver ci-joint l''extraction des commandes de cartes avoirs Conforama du mois dernier.'
  set @sCommande='sysadm.DW_S01_STAT_CONFORAMA ''' +
		convert(varchar(25), @dtDteDeb, 112) + ''',''' +
		convert(varchar(25), @dtDteDeb, 112) + ''''
			
  Exec master.dbo.SPB_PS_MAIL @sRetour OUTPUT ,'groupefacturation@spb.eu' , @sMessage , @sObjet ,'' , null, null, @sCommande ,@sFicOut , 2 , @sBase
	
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_LSTREG_MOBILEO2
-- Auteur               :       FPI ( Reprise et modification de la requête initiale de PS_S011_LSTREG )
-- Date                 :       29/12/2011
-- Libellé              :        
-- Commentaires         :       Liste détaillée des règlements pour Mobileo2
-- Références           :       [PC521]
--
--				
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
-- JFF      06/10/2014   [PM266]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_LSTREG_MOBILEO2' AND type = 'P' )
        DROP procedure sysadm.PS_S01_LSTREG_MOBILEO2
GO

CREATE procedure sysadm.PS_S01_LSTREG_MOBILEO2 
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      WITH RECOMPILE

AS

/* Variante de PS_S01_LSTREG, mais on ne ramène
   pas le détail 
*/

SET NOCOUNT ON


Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'LIB_GRP'	= groupe.lib_grp,
 'ID_ADH'	= sinistre.id_adh,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( reg_gti.id_sin	=	gar_sin.id_sin		)	and
 ( reg_gti.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	between 44500 and 44599		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 
UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'ID_ADH'	= sinistre.id_adh,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.reglement
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	between 44500 and 44599		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 
UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= 'REGULARISATION',
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'ID_ADH'	= sinistre.id_adh,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	between 44500 and 44599		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_LSTPROD
-- Auteur               :       FPI
-- Date                 :       29/05/2012
-- Libellé              :        
-- Commentaires         :       Liste des produits/garantie/police
-- Références           :       [VDoc7785]
--
-- Arguments            :      
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- FPI - 27/05/2015 - [VDOC17710] - ajout de l'assureur
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_LSTPROD' AND type = 'P' )
        DROP procedure sysadm.PS_S01_LSTPROD
GO

CREATE procedure sysadm.PS_S01_LSTPROD
        
AS
IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO')
Begin
 SELECT p.id_prod, p.lib_long as lib_produit,
	g.id_gti, cg.lib_gti as lib_garantie, 
	po.lib_police,
	c.id_cie as assureur,
	c.lib_cie as lib_assureur,
	IsNull ( 
		( Select convert (varchar, d.id_code )
		  From SHERPA_PRO.sysadm.det_pro d 
		  where d.id_prod= p.id_prod
		  and d.id_typ_code='-PADH'
		), 'Non renseigné' ) as code_produit_adhesion_SHERPA,
	p.cod_prod_dms code_produit_adhesion_SIMPA2,
	p.num_tel,
	IsNull ( 
	( Select rtrim ( dp.val_car )
	  from sysadm.det_pro dp
	  Where dp.id_prod = p.id_prod
	  And   dp.id_code_dp = 306 ) , 'Non renseigné' ) 'Section analytique'

 From sysadm.produit p
	Inner join sysadm.garantie g on p.id_prod=g.id_prod
	inner join sysadm.code_garantie cg on cg.id_gti=g.id_gti and cg.id_prod=g.id_prod 
	inner join sysadm.police po on po.id_police=g.id_police
	inner join sysadm.compagnie c on c.id_cie=po.id_cie
	order by p.id_prod, g.id_gti

End 
Else
Begin
 SELECT p.id_prod, p.lib_long as lib_produit,
	g.id_gti, cg.lib_gti as lib_garantie, 
	po.lib_police,
	c.id_cie as assureur,
	c.lib_cie as lib_assureur,
	IsNull ( 
		( Select convert (varchar, d.id_code )
		  From SHERPA_SIM.sysadm.det_pro d 
		  where d.id_prod= p.id_prod
		  and d.id_typ_code='-PADH'
		), 'Non renseigné' ) as code_produit_adhesion_SHERPA,
	p.cod_prod_dms code_produit_adhesion_SIMPA2,
	p.num_tel,
	IsNull ( 
	( Select rtrim ( dp.val_car )
	  from sysadm.det_pro dp
	  Where dp.id_prod = p.id_prod
	  And   dp.id_code_dp = 306 ) , 'Non renseigné' ) 'Section analytique'

 From sysadm.produit p
	Inner join sysadm.garantie g on p.id_prod=g.id_prod
	inner join sysadm.code_garantie cg on cg.id_gti=g.id_gti and cg.id_prod=g.id_prod 
	inner join sysadm.police po on po.id_police=g.id_police
	inner join sysadm.compagnie c on c.id_cie=po.id_cie
	order by p.id_prod, g.id_gti

End

GO

--------------------------------------------------------------------
--
-- Procédure            : DW_S02_STAT_FRAIS_PRESTA
-- Auteur               : FPI
-- Date                 : 15/06/2012
-- Libellé              : Extraction des frais presta  - [PM72-4]
--
-- Arguments            :  @dtDteDeb  	DateTime (val)
--			   @dtDteFin  	DateTime (val)
--	    		   @dcIdProd	Decimal(7)		(Val)
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- [ITSM136512] On utilise la période Simpa2 ald mois civile
-- [20130905142500] Modification suite remonté de François.
-- [201309091100.FPI] Correction - suppr de la jointure avec param_frais
-- JFF      06/10/2014   [PM266]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_STAT_FRAIS_PRESTA' AND type = 'P' )
        DROP procedure sysadm.DW_S02_STAT_FRAIS_PRESTA
GO

CREATE procedure sysadm.DW_S02_STAT_FRAIS_PRESTA
  @dtDateDeb	datetime,
  @dtDateFin	datetime WITH RECOMPILE

AS
Declare @sPeriode varchar(6)

-- [ITSM136512]
--Set @dtDateDeb = convert(datetime,convert(varchar(4),datepart(year,@dtDateDeb)) +  RIGHT('0' + convert(varchar(2), MONTH(@dtDateDeb)),2) + '01',112)
--Set @dtDateFin = DATEADD(month,1,@dtDateDeb)

Set @sPeriode = convert(varchar(4),datepart(year,@dtDateFin)) + RIGHT('0' + convert(varchar(2), MONTH(@dtDateFin)),2) 

If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
Begin
  Select distinct dp.id_code as id_prod_adh,
	t.id_prod as id_prod_sin, 
	sysadm.FN_LIB_PROD(t.id_prod) as lib_produit,
	t.no_contrat,
	cie.lib_cie, -- Assureur
	t.id_sin,
	pe.nom,pe.prenom,
	sysadm.FN_CODE_CAR(d.val_car,'-AR') as lib_typ_appareil,
	tt.id_process as code_process,
	sysadm.FN_CODE_NUM(tt.id_process,'-IF') as lib_process,
	t.dte_trt, -- [20130905142500]
--	t.cree_le, -- [20130905142500] ne sera jamais à présent
	t.montant,
	Case when t.cod_pec_spb=100 Then 'SPB'
		When t.cod_pec_presta=100 Then t.cod_presta
		Else cie.lib_cie End as organisme_pec_rbt,
	@sPeriode periode_facturation
  from sysadm.trt_frais_presta t
	inner join SHERPA_PRO.sysadm.det_pro dp on dp.id_prod = t.id_prod
	inner join trace_trt_frais_presta tt on t.id_sin=tt.id_sin and t.id_seq_cmd=tt.id_seq_cmd
	inner join sysadm.sinistre s on s.id_sin=t.id_sin
	inner join personne pe on pe.id_ordre=s.id_ordre
	inner join div_sin d on d.id_sin=s.id_sin
	--inner join sysadm.param_frais p on p.id_prod=tt.id_prod and p.id_four=t.cod_presta  -- [201309091100.FPI] 
	--	and p.id_gti=tt.id_gti and p.id_process=tt.id_process
	inner join sysadm.garantie g on s.id_prod=g.id_prod and g.id_gti=tt.id_gti and s.id_rev=g.id_rev
	inner join sysadm.police po on g.id_police=po.id_police
	inner join sysadm.compagnie cie on cie.id_cie=po.id_cie
  where d.nom_zone='type_app'
	and dp.id_typ_code='-PADH'
	and t.dte_trt between @dtDateDeb and @dtDateFin -- [20130905142500] 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = po.id_cie
			)
	  ) 

 End
 Else
 Begin
   Select distinct dp.id_code as id_prod_adh,
	t.id_prod as id_prod_sin, 
	sysadm.FN_LIB_PROD(t.id_prod) as lib_produit,
	t.no_contrat,
	cie.lib_cie, -- Assureur
	t.id_sin,
	pe.nom,pe.prenom,
	sysadm.FN_CODE_CAR(d.val_car,'-AR') as lib_typ_appareil,
	tt.id_process as code_process,
	sysadm.FN_CODE_NUM(tt.id_process,'-IF') as lib_process,
	t.dte_trt, -- [20130905142500]
--	t.cree_le, -- [20130905142500] ne sera jamais à présent
	t.montant,
	Case when t.cod_pec_spb=100 Then 'SPB'
		When t.cod_pec_presta=100 Then t.cod_presta
		Else cie.lib_cie End as organisme_pec_rbt,
	@sPeriode periode_facturation
  from sysadm.trt_frais_presta t
	inner join SHERPA_SIM.sysadm.det_pro dp on dp.id_prod = t.id_prod
	inner join trace_trt_frais_presta tt on t.id_sin=tt.id_sin and t.id_seq_cmd=tt.id_seq_cmd
	inner join sysadm.sinistre s on s.id_sin=t.id_sin
	inner join personne pe on pe.id_ordre=s.id_ordre
	inner join div_sin d on d.id_sin=s.id_sin
	--inner join sysadm.param_frais p on p.id_prod=tt.id_prod and p.id_four=t.cod_presta -- [201309091100.FPI] 
	-- 	and p.id_gti=tt.id_gti and p.id_process=tt.id_process
	inner join sysadm.garantie g on s.id_prod=g.id_prod and g.id_gti=tt.id_gti and s.id_rev=g.id_rev
	inner join sysadm.police po on g.id_police=po.id_police
	inner join sysadm.compagnie cie on cie.id_cie=po.id_cie
  where d.nom_zone='type_app'
	and dp.id_typ_code='-PADH'
	and t.dte_trt between @dtDateDeb and @dtDateFin -- [20130905142500] 
	  -- [PM266]
	  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
			Or
			Not Exists ( 
				Select 1
				From   sysadm.exclu_ass ex
				Where  ex.id_cie = po.id_cie
				)
		  ) 	
 End

Go



--------------------------------------------------------------------
--
-- Procédure            : DW_S02_STAT_FRAIS_PRESTA_VOLCANE
-- Auteur               : FPI
-- Date                 : 07/09/2012
-- Libellé              : Extraction des frais presta  - [PM72-4]
--
-- Arguments            :  @dtDteDeb  	DateTime (val)
--			   @dtDteFin  	DateTime (val)
--	    		   @dcIdProd	Decimal(7)		(Val)
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- FPI - 01/08/2013 - [VDOC11792] on ne se base plus sur dte_trt, mais cree_le
-- [20130905142500] Modification suite remonté de François.
-- [201309091100.FPI] Correction - suppr de la jointure avec param_frais
-- JFF      06/10/2014   [PM266]
-- JFF      12/05/2020   [PI085]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_STAT_FRAIS_PRESTA_VOLCANE' AND type = 'P' )
        DROP procedure sysadm.DW_S02_STAT_FRAIS_PRESTA_VOLCANE
GO

CREATE procedure sysadm.DW_S02_STAT_FRAIS_PRESTA_VOLCANE
  @dtDateDeb	datetime,
  @dtDateFin	datetime WITH RECOMPILE

AS
Declare @sPeriode varchar(6)

Set @sPeriode = convert(varchar(4),datepart(year,@dtDateFin)) + RIGHT('0' + convert(varchar(2), MONTH(@dtDateFin)),2) 

  Select distinct p.cod_prod_dms as id_prod_adh, -- [PI085]
	t.id_prod as id_prod_sin, 
	sysadm.FN_LIB_PROD(t.id_prod) as lib_produit,
	t.no_contrat,
	cie.lib_cie, -- Assureur
	t.id_sin,
	pe.nom,pe.prenom,
	sysadm.FN_CODE_CAR(d.val_car,'-AR') as lib_typ_appareil,
	tt.id_process as code_process,
	sysadm.FN_CODE_NUM(tt.id_process,'-IF') as lib_process,
	t.dte_trt, -- [20130905142500]
--	t.cree_le, -- [20130905142500] ne sera jamais à présent
	t.montant,
	Case when t.cod_pec_spb=100 Then 'SPB'
		When t.cod_pec_presta=100 Then t.cod_presta
		Else cie.lib_cie End as organisme_pec_rbt,
	@sPeriode periode_facturation
  from sysadm.trt_frais_presta t
	inner join produit p on p.id_prod = t.id_prod -- [PI085]
	inner join trace_trt_frais_presta tt on t.id_sin=tt.id_sin and t.id_seq_cmd=tt.id_seq_cmd
	inner join sysadm.sinistre s on s.id_sin=t.id_sin
	inner join personne pe on pe.id_ordre=s.id_ordre
	inner join div_sin d on d.id_sin=s.id_sin
	--inner join sysadm.param_frais p on p.id_prod=tt.id_prod and p.id_four=t.cod_presta  -- [201309091100.FPI]
	--	and p.id_gti=tt.id_gti and p.id_process=tt.id_process
	inner join sysadm.garantie g on s.id_prod=g.id_prod and g.id_gti=tt.id_gti and s.id_rev=g.id_rev
	inner join sysadm.police po on g.id_police=po.id_police
	inner join sysadm.compagnie cie on cie.id_cie=po.id_cie
  where d.nom_zone='type_app'
	and t.dte_trt between @dtDateDeb and @dtDateFin -- [20130905142500]
      -- [PM266]
      AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
		    Or
			Not Exists ( 
				Select 1
				From   sysadm.exclu_ass ex
				Where  ex.id_cie = po.id_cie
				)
		  ) 	
/*
	and (t.cree_le between @dtDateDeb and @dtDateFin)

	  or (t.dte_trt between '26/08/2013 06:45' and '26/08/2013 07:00'  -- [20130905142500]
	   	  and t.dte_trt > @dtDateDeb)
		  ) -- pour rattraper le décalage du mois de Aout
*/		  


Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RMFR
-- Auteur               :       FABRY JF
-- Date                 :       28/03/2013
-- Libellé              :        
-- Commentaires         :       [PC801_LOT1_V2]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      04/10/2019   [PM462-1][V3]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RMFR' AND type = 'P' )
        DROP procedure sysadm.PS_S_RMFR
GO


CREATE procedure sysadm.PS_S_RMFR
  @adcIdSin		Decimal ( 10 ), -- [PI062]
  @adcIdReg		Decimal ( 2 ),
  @asChaine		Varchar ( 10 ) OUTPUT
  
AS

Declare @sLibReg  Varchar ( 35 )
Declare @sModePaiemFr Varchar ( 10 )

Select @sModePaiemFr = ds.val_car  
from   sysadm.div_sin ds,
	   sysadm.div_sin ds1
Where  ds.id_sin = @adcIdSin
And    ds.nom_zone = 'mode_paiement'
And    ds1.id_sin = ds.id_sin
And    ds1.nom_zone = 'franchise_paybox'
And	   ds1.val_car = 'O'
If @sModePaiemFr is null Set @sModePaiemFr = ''

Select @sLibReg = r.lib_reg
From   sysadm.reglement r
Where r.id_sin = @adcIdSin
And   r.id_reg = @adcIdReg
If @sLibReg is null Set @sLibReg = ''

If @sModePaiemFr <> ''
  Begin
	Set @asChaine = Left ( @sModePaiemFr + Space (3 ) , 3 )
  End 

If @sLibReg = 'RM/FRANCHISE (FR5)'
  Begin
	Set @asChaine = @asChaine + 'FR'
	Return -- [PM462-1][V3]
  End 
Else
 Begin
	Set @asChaine = SPACE ( 5 )
 End 

 -- [PM462-1][V3] Sommes-nous dans le cas d'une Franchise CB PayBox Site Choix de mobile (nouveau système franchise)
If sysadm.FN_CLE_NUMERIQUE ( 'PM462-1') >= 0 
 Begin
	 If @sLibReg = 'RM/REMB. FRANCHISE CB A L''ASSUREUR'
	   Begin
		 Set @asChaine = Left ( 'CB' + Space (3 ) , 3 )
		 Set @asChaine = @asChaine + 'FR'
	   End 
	 Else
	   Begin
		 Set @asChaine = SPACE ( 5 )
	   End 
 End 
 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_REMB_RNFR
-- Auteur               :       FABRY JF
-- Date                 :       11/06/2018
-- Libellé              :        
-- Commentaires         :       [PC151425-1]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_REMB_RNFR' AND type = 'P' )
        DROP procedure sysadm.PS_S_REMB_RNFR
GO


CREATE procedure sysadm.PS_S_REMB_RNFR
  @adcIdSin		Decimal ( 10 ), -- [PI062]
  @adcIdReg		Decimal ( 2 ),
  @asChaine		Varchar ( 10 ) OUTPUT
  
AS

Declare @sLibReg  Varchar ( 35 )
Declare @sModePaiemFr Varchar ( 10 )
Declare @iPresenceDuRMFR5 Integer

Set @iPresenceDuRMFR5 = 0

Select @sLibReg = r.lib_reg,
	   @sModePaiemFr = Case r.cod_mode_reg
						 When 'C' Then 'CHQ'
						 Else r.cod_mode_reg
					   End
From   sysadm.reglement r
Where r.id_sin = @adcIdSin
And   r.id_reg = @adcIdReg
If @sLibReg is null Set @sLibReg = ''
If @sModePaiemFr is null Set @sModePaiemFr = ''

If Exists ( 
	Select Top 1 1
	From   sysadm.reglement r
	Where r.id_sin = @adcIdSin
	And   lib_reg = 'RM/FRANCHISE (FR5)'
)
 Begin
	Set @iPresenceDuRMFR5 = 1
 End 

If @sModePaiemFr <> ''
  Begin
	Set @asChaine = Left ( @sModePaiemFr + '   ' , 3 )
  End 

-- On tague le réclamation à l'assureur en FR que s'il y avait remboursement à l'assureur en FR
If @sLibReg = 'Remb. Franchise PayBox suite refus' And @iPresenceDuRMFR5 = 1
  Begin
	Set @asChaine = @asChaine + 'FR'
  End 
Else
 Begin
	Set @asChaine = SPACE ( 5 )
 End 

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S_RMFR
-- Auteur               :       FABRY JF
-- Date                 :       28/03/2013
-- Libellé              :        
-- Commentaires         :       [PC801_LOT1_V2]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      01/06/2018   [PC151425-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_RMFR' AND type = 'P' )
        DROP procedure sysadm.DW_S_RMFR
GO

CREATE procedure sysadm.DW_S_RMFR
  @dtDateDeb	datetime,
  @dtDateFin	datetime WITH RECOMPILE
  
AS

Select	r.id_sin,
		r.id_reg,
		r.mt_tot_reg,
		rTrim ( r.lib_reg),
		( Select rTrim ( sysadm.FN_CODE_CAR ( ds.val_car, '-W3' ))
		  from   sysadm.div_sin ds
		  Where  ds.id_sin = r.id_sin
		  And    ds.nom_zone = 'mode_paiement' ) mode_paiement_par_assure,
		( Select rTrim ( ds.val_car )
		  from   sysadm.div_sin ds
		  Where  ds.id_sin = r.id_sin
		  And    ds.nom_zone = 'ref_cheque_franchise' ) ref_cheque_ou_virbelge,
		r.dte_reg,
		rTrim ( sysadm.FN_CODE_CAR ( cod_inter, '-IN' )) typ_inter,
		CONVERT ( VarChar ( 10 ), r.valide_le, 103 ) valide_le,
		r.valide_par
From   sysadm.reglement r
Where  r.cod_mot_reg = 'RM'
And    r.lib_reg = 'RM/FRANCHISE (FR5)'
And    r.dte_reg between @dtDateDeb and @dtDateFin
And	   Exists (  -- [PC151425-1]
		Select Top 1 1 
		From   sysadm.sinistre s,
			   sysadm.det_pro dp
		Where  s.id_sin = r.id_sin
		And    dp.id_prod = s.id_prod
		And    dp.id_code_dp = 140
	   )

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S_RMFR_FISRT_ASSUR
-- Auteur               :       FABRY JF
-- Date                 :       11/06/2018
-- Libellé              :        
-- Commentaires         :       [PC151425-1]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      01/06/2018   [PC151425-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_RMFR_FISRT_ASSUR' AND type = 'P' )
        DROP procedure sysadm.DW_S_RMFR_FISRT_ASSUR
GO

CREATE procedure sysadm.DW_S_RMFR_FISRT_ASSUR
  @dtDateDeb	datetime,
  @dtDateFin	datetime,
  @dcIdProd		decimal ( 7 )  WITH RECOMPILE
AS

Select	r.id_sin,
		r.id_reg,
		r.mt_tot_reg,
		rTrim ( r.lib_reg),
		Case r.cod_mot_reg 
			When 'RM' Then
				( Select rTrim ( sysadm.FN_CODE_CAR ( ds.val_car, '-W3' ))
				  from   sysadm.div_sin ds
				  Where  ds.id_sin = r.id_sin
				  And    ds.nom_zone = 'mode_paiement' ) 
			When 'RN' Then
				Case r.cod_mode_reg
					When 'C' Then 'Chèque'
					When 'VA' Then 'Virement bancaire'
					Else r.cod_mode_reg
				End 
		End mode_paiement_par_assure,
		r.dte_reg,
		rTrim ( sysadm.FN_CODE_CAR ( cod_inter, '-IN' )) typ_inter,
		CONVERT ( VarChar ( 10 ), r.valide_le, 103 ) valide_le,
		r.valide_par,
		s.id_prod,
		sysadm.FN_LIB_PROD ( s.id_prod ) 'Lib_prod'
From   sysadm.reglement r,
	   sysadm.sinistre s
Where  ( ( r.cod_mot_reg = 'RM' And r.lib_reg = 'RM/FRANCHISE (FR5)' ) 
		 Or 
		 ( r.cod_mot_reg = 'RN' And r.lib_reg = 'Remb. Franchise PayBox suite refus' ) 
	   )
And    r.dte_reg between @dtDateDeb and @dtDateFin
And    s.id_sin = r.id_sin
And	   s.id_prod = @dcIdProd

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_MAJ_MAIL_SATISFACTION_V01
-- Auteur               :       FPI
-- Date                 :       30/07/2013
-- Libellé              :        
-- Commentaires         :      [PM158-2]
-- Références           :       
--
--	
-- Arguments            :       Aucun
--				
-- Retourne             :       Rien
-- JFF  24/09/2013  [PC13288]
-- FPI - [PM158-2].Mantis8954
-- FPI - 12/03/2014 [VDoc13933] - ajout de ECT pour les commandes CAR
-- FPI - 23/05/2014 [ITSM215273]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_MAJ_MAIL_SATISFACTION_V01' AND type = 'P' )
        DROP procedure sysadm.PS_MAJ_MAIL_SATISFACTION_V01
GO

CREATE procedure sysadm.PS_MAJ_MAIL_SATISFACTION_V01
As

Declare @dtDeb date,
	@dtFin date

  -- On prend ceux validé il y a 10 jours
  Set @dtDeb=dateadd(day,-11,GETDATE())
  Set @dtFin=dateadd(day,1,@dtDeb)

  -- Création table temporaire
  IF OBJECT_ID('tempdb.dbo.#tmp_maj_mail_stf', 'U') IS NOT NULL Drop Table #tmp_maj_mail_stf

 Create Table #tmp_maj_mail_stf (id_sin int , 
	id_appli int, 
	mail_dest varchar(120),
	id_prod	int)
	
  -- Insertion des règlements assurés
  insert into #tmp_maj_mail_stf
  select s.id_sin, 2 as id_appli, 
	i.adr_mail as mail_dest,
	s.id_prod
  from sysadm.sinistre s
  inner join sysadm.inter i on s.id_sin=i.id_sin
  inner join sysadm.det_pro d on s.id_prod=d.id_prod
  inner join sysadm.reglement r on s.id_sin=r.id_sin and r.id_i=i.id_i
  inner join sysadm.reg_gti rg on r.id_sin=rg.id_sin and r.id_reg=rg.id_reg
  where i.cod_inter='A' 
	and i.adr_mail is not null
	and r.dte_reg between @dtDeb and @dtFin
	and d.id_code_dp=202
	and not exists (select * from sysadm.reglement r2 
		where r2.id_sin=r.id_sin and r2.id_i=r.id_i 
		and r2.dte_reg > r.dte_reg)
    and not exists (select * from sysadm.gar_sin g 
		where g.id_sin=s.id_sin and g.id_gti <> rg.id_gti 
			and g.cod_etat not in (200,600,900)) -- Mantis8954
	and not exists (select * from sysadm.w_gar_sin g 
		where g.id_sin=s.id_sin and g.id_gti <> rg.id_gti 
			and g.cod_etat not in (200,600,900)) -- Mantis8954
			
  -- insertion des refusés
  insert into #tmp_maj_mail_stf
  select s.id_sin, 2 as id_appli, 
	i.adr_mail as mail_dest,
	s.id_prod
  from sysadm.sinistre s
  inner join sysadm.inter i on s.id_sin=i.id_sin
  inner join sysadm.det_pro d on s.id_prod=d.id_prod
  where i.cod_inter='A' 
	and i.adr_mail is not null
	and s.cod_etat=200 
	and s.valide_le between @dtDeb and @dtFin
	and d.id_code_dp=202
	and not exists (select * from sysadm.commande c
		where s.id_sin=c.id_sin and c.cod_etat not in ('ANN','RFO','RPC','RSP')) -- [ITSM215273]
	
-- insertion des commandes
 insert into #tmp_maj_mail_stf
  select s.id_sin, 2 as id_appli, 
	i.adr_mail as mail_dest,
	s.id_prod
  from sysadm.sinistre s
  inner join sysadm.inter i on s.id_sin=i.id_sin
  inner join sysadm.det_pro d on s.id_prod=d.id_prod
  inner join sysadm.commande c on c.id_sin=s.id_sin
  where i.cod_inter='A' 
	and i.adr_mail is not null
	and d.id_code_dp=202
	And	c.dte_env_cli is not null 
	And  c.dte_env_cli between @dtDeb and @dtFin
	And  c.cod_etat in ( 'ECL', 'RPC' )
	And c.id_typ_art not in ('PST','REA','SMS','REL') -- Mantis 9132
	And Not Exists (select * 
		from sysadm.commande c2
		where c2.id_sin=c.id_sin and c.id_seq < c2.id_seq and c2.cod_etat <> 'ANN')

  insert into #tmp_maj_mail_stf
  select s.id_sin, 2 as id_appli, 
	i.adr_mail as mail_dest,
	s.id_prod
  from sysadm.sinistre s
  inner join sysadm.inter i on s.id_sin=i.id_sin
  inner join sysadm.det_pro d on s.id_prod=d.id_prod
  inner join sysadm.commande c on c.id_sin=s.id_sin
  where i.cod_inter='A' 
	and i.adr_mail is not null
	and d.id_code_dp=202
	And	(
		 (c.dte_rcp_mob_cli is not null 
			And  c.dte_rcp_mob_cli between @dtDeb and @dtFin
			And  c.cod_etat in ( 'ECL', 'RPC')
		 )
		or (c.cod_etat='ECT' and c.valide_le between @dtDeb and @dtFin) -- [VDoc13933]
		)
	And Not Exists (select * 
		from sysadm.commande c2
		where c2.id_sin=c.id_sin and c.id_seq < c2.id_seq and c2.cod_etat <> 'ANN')
	And c.id_four='CAR'

insert into #tmp_maj_mail_stf
  select s.id_sin, 2 as id_appli, 
	i.adr_mail as mail_dest,
	s.id_prod
  from sysadm.sinistre s
  inner join sysadm.inter i on s.id_sin=i.id_sin
  inner join sysadm.det_pro d on s.id_prod=d.id_prod
  inner join sysadm.commande c on c.id_sin=s.id_sin
  where i.cod_inter='A' 
	and i.adr_mail is not null
	and d.id_code_dp=202
	And	c.dte_env_cli is not null 
	And  c.dte_env_cli between @dtDeb and @dtFin
	And  c.cod_etat ='RFO'
	And Not Exists (select * 
		from sysadm.commande c2
		where c2.id_sin=c.id_sin and c.id_seq < c2.id_seq and c2.cod_etat <> 'ANN')
	And (c.id_four='CDS'
		or (c.id_four='MS1' and c.id_typ_art='ACC')
		or (c.id_four='O2M' and c.id_typ_art in ('BAM','ALE'))
		)
	
  insert into #tmp_maj_mail_stf
  select s.id_sin, 2 as id_appli, 
	i.adr_mail as mail_dest,
	s.id_prod
  from sysadm.sinistre s
  inner join sysadm.inter i on s.id_sin=i.id_sin
  inner join sysadm.det_pro d on s.id_prod=d.id_prod
  inner join sysadm.div_det dd on dd.id_sin=s.id_sin
  where s.id_prod between 23400 and 23499 -- JFF  24/09/2013  [PC13288]
	And i.cod_inter='A' 
	and i.adr_mail is not null
	and d.id_code_dp=202
	And	dd.nom_zone = 'cod_action'
	And dd.cree_le between @dtDeb and @dtFin
	and dd.val_nbre between 51 and 69 
	And	dd.val_nbre not in ( 55 )
	
	-- [VDoc14676]
	 insert into #tmp_maj_mail_stf
  select s.id_sin, 2 as id_appli, 
	i.adr_mail as mail_dest,
	s.id_prod
  from sysadm.sinistre s
  inner join sysadm.inter i on s.id_sin=i.id_sin
  inner join sysadm.det_pro d on s.id_prod=d.id_prod
  inner join sysadm.commande c on c.id_sin=s.id_sin
  where i.cod_inter='A' 
	and i.adr_mail is not null
	and d.id_code_dp=202
	And  c.valide_le between @dtDeb and @dtFin
	And  c.cod_etat in ( 'RPC' )
	And c.id_four='VPP'
	And Not Exists (select * 
		from sysadm.commande c2
		where c2.id_sin=c.id_sin and c.id_seq < c2.id_seq and c2.cod_etat <> 'ANN')
		
  -- Insertion en bloc dans la table 'mail_satisfaction' de SHERPA
  IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO')
  Begin
	exec SHERPA_PRO.sysadm.PS_I01_MAIL_SATISFACTION
  End
  Else
  Begin
	exec SHERPA_SIM.sysadm.PS_I01_MAIL_SATISFACTION
  End
Go

grant execute on sysadm.PS_MAJ_MAIL_SATISFACTION_V01 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S019_LSTREG
-- Auteur               :       FPI
-- Date                 :       21/08/2013
-- Libellé              :        
-- Commentaires         :       Liste détaillée des réglements pour Leclerc
-- Références           :       [VDoc10732] Variante de PS_S011_LSTREG 
--
--				EURO
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      06/10/2014   [PM266]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S019_LSTREG' AND type = 'P' )
        DROP procedure sysadm.PS_S019_LSTREG
GO

CREATE procedure sysadm.PS_S019_LSTREG 
	@dtDteDeb       DateTime        ,
    @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7),     
	@dcIdProd	Decimal(7)	WITH RECOMPILE
AS

SET NOCOUNT ON

Declare @result TABLE(
	maj_le DateTime,
	id_sin Decimal(10), -- [PI062]
	id_reg Decimal(2),
	id_prod Decimal(7),
	lib_prod varchar(65),
	cod_adh char(1),
	id_ets Decimal(7),
	lib_dept varchar(35),
	dte_surv DateTime,
	id_exercice int,
	id_mois_surv int,
	dte_decl DateTime,
	id_grp decimal(7),
	nat_sin varchar(35),
	id_gti decimal(7),
	id_rgpt decimal(7),
	lib_gti_stat varchar(35),
	mt_reg decimal(11,2),
	alt_plaf char(1),
	lib_groupe varchar(35),
	lib_police varchar(35),
	lib_cie varchar(35),
	nom varchar(35),
	prenom varchar(35),
	id_orian_boutique int,
	four_regle varchar(5))

insert into @result
Select reg_gti.maj_le,
 sinistre.id_sin,
 reg_gti.id_reg,
 produit.id_prod,
 produit.lib_long,
 produit.cod_adh,
 sinistre.id_ets,
 departement.lib_dept,
 sinistre.dte_surv,
 NULL,NULL,
 sinistre.dte_decl,
 NULL,
 code_Ns.lib_code,
 reg_gti.id_gti,
 reg_gti.id_rgpt,
 code_Gs.lib_code,
 reg_gti.mt_reg,
 gar_sin.alt_plaf,
 NULL,
 police.lib_police,
 compagnie.lib_cie,
 personne.nom,
 personne.prenom,
 sinistre.id_orian_boutique,
 (select top 1 Case When i.id_four='MS1' Then 'MSS' 
	When nom like '%FNC%' Then 'FNAC'
	Else i.id_four End
  from sysadm.reg_gti r 
	inner join sysadm.inter i on i.id_sin=r.id_sin and r.id_i=i.id_i
  where r.id_sin=reg_gti.id_sin and i.cod_inter='F')
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( produit.id_prod	=	@dcIdProd			)	and
 ( reg_gti.id_sin	=	gar_sin.id_sin		)	and
 ( reg_gti.id_gti	=	gar_sin.id_gti		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reglement.dte_reg   between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  )  
 
insert into @result
Select 
 reg_gti.maj_le,
 sinistre.id_sin,
 reg_gti.id_reg,
 produit.id_prod,
 produit.lib_long,
 produit.cod_adh,
 sinistre.id_ets,
 departement.lib_dept,
 sinistre.dte_surv,
 NULL, NULL,
 sinistre.dte_decl,
 NULL,
 code_Ns.lib_code,
 reg_gti.id_gti,
 reg_gti.id_rgpt,
 code_Nf.lib_code,
 reg_gti.mt_reg,
 'N',
 NULL,
 police.lib_police,
 compagnie.lib_cie,
 personne.nom,
 personne.prenom,
 sinistre.id_orian_boutique,
(select top 1 Case When i.id_four='MS1' Then 'MSS' 
	When nom like '%FNC%' Then 'FNAC'
	Else i.id_four End
  from sysadm.reg_gti r 
	inner join sysadm.inter i on i.id_sin=r.id_sin and r.id_i=i.id_i
  where r.id_sin=reg_gti.id_sin and i.cod_inter='F')
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.reglement
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( produit.id_prod	=	@dcIdProd			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( reglement.dte_reg    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  )
  
 
insert into @result
Select distinct
 reglement.dte_reg,
 sinistre.id_sin,
 reglement.id_reg,
 produit.id_prod,
 produit.lib_long,
 produit.cod_adh,
 sinistre.id_ets,
 departement.lib_dept,
 sinistre.dte_surv,
 NULL, 
 NULL,
 sinistre.dte_decl,
 NULL,
 code_Ns.lib_code,
 -2,
 -2,
 'REGULARISATION',
 reglement.mt_tot_reg,
 'N',
 NULL,
 police.lib_police,
 compagnie.lib_cie,
 personne.nom,
 personne.prenom,
 sinistre.id_orian_boutique,
(select top 1 Case When i.id_four='MS1' Then 'MSS' 
	When nom like '%FNC%' Then 'FNAC'
	Else i.id_four End
  from sysadm.reg_gti r 
	inner join sysadm.inter i on i.id_sin=r.id_sin and r.id_i=i.id_i
  where r.id_sin=sinistre.id_sin and i.cod_inter='F')
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.code code_Ns,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( produit.id_prod	=	@dcIdProd			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  )

-- Maj du groupe
update @result
set id_grp=e.id_grp, lib_groupe=g.lib_grp
from sysadm.etablissement e, @result r, sysadm.groupe g
where cod_adh <> '3' and e.id_ets=r.id_ets
and e.id_prod=r.id_prod and e.id_rev=-1
and g.id_grp=e.id_grp

update @result
set id_grp=id_ets, lib_groupe=g.lib_grp
from  @result r, sysadm.groupe g
where cod_adh = '3' and r.id_ets=g.id_grp

-- Champs calculés
update @result
set id_exercice=DatePart ( year, dte_surv ),
 id_mois_surv=DatePart ( month, dte_surv )
 
Select distinct
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= maj_le,
 'ID_SIN'	= id_sin,
 'ID_REG'	= id_reg,
 'LIB_PROD'	= lib_prod,
 'LIB_DEPT'	= lib_dept,
 'DTE_SURV'	= dte_surv,
 'ID_EXERCICE'  = id_exercice,
 'ID_MOISSURV'	= id_mois_surv,
 'DTE_DECL'	= dte_decl,
 'ID_ETS'	= id_grp,
 'NS' 		= nat_sin,
 'ID_GTI'	= id_gti,
 'ID_RGPT'	= id_rgpt,
 'GA' 		= lib_gti_stat,
 'MT_REG_GTI'	= mt_reg,
 'ALT_PLAF'	= alt_plaf,
 'LIB_GRP'	= lib_groupe,
 'LIB_POLICE'	= lib_police,
 'LIB_CIE'	= lib_cie,
 'NOM'		= nom,
 'PRENOM'	= prenom,
 'ID_BOUTIQUE'	= id_orian_boutique,
 'FOURNISSEUR_REGLE' = four_regle
From @result

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RMRP_CAUTION
-- Auteur               :       FABRY JF
-- Date                 :       06/09/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3_V10]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      28/03/2014   [DT081_EVOL_PRET_BRIS]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RMRP_CAUTION' AND type = 'P' )
        DROP procedure sysadm.PS_S_RMRP_CAUTION
GO


CREATE procedure sysadm.PS_S_RMRP_CAUTION
  @adcIdSin		Decimal ( 10 ), -- [PI062]
  @adcIdReg		Decimal ( 2 ),
  @asCodMotReg  VarChar ( 5 ),
  @asChaine		Varchar ( 50 ) OUTPUT
  
AS

Declare @sLibReg  Varchar ( 35 )
Declare @sModePaiemFr Varchar ( 10 )

Select @sLibReg = r.lib_reg
From   sysadm.reglement r
Where r.id_sin = @adcIdSin
And   r.id_reg = @adcIdReg
If @sLibReg is null Set @sLibReg = ''

Set @asChaine = SPACE ( 9 )

If @sLibReg = 'Débit caution>rendu à l''assureur'  -- RM
  Begin
	-- Set @asChaine = 'RMCAUTION'
	-- Suite demande de Sylvie Vrigneau
	
	-- [DT081_EVOL_PRET_BRIS]
	Set @asChaine = 'CIE' + 'CA' + SPACE (4)
  End 

If @sLibReg = 'Crédit caution>réclam à l''assureur'  -- RP
  Begin
	-- Set @asChaine = 'RPCAUTION'
	-- Suite demande de Sylvie Vrigneau
	-- [DT081_EVOL_PRET_BRIS]
	Set @asChaine = 'CIE' + 'CA' + SPACE (4)
  End 
  
-- [DT081_EVOL_PRET_BRIS]  
If @sLibReg = 'Débit caution>rendu à SPB Service'  -- RM
  Begin
	-- Set @asChaine = 'RPCAUTION'
	-- Suite demande de Sylvie Vrigneau
	-- [DT081_EVOL_PRET_BRIS]
	Set @asChaine = 'SPS' + 'CA' + SPACE (4)
  End 

-- [DT081_EVOL_PRET_BRIS]  
If @sLibReg = 'Crédit caution>réclam à SPB Service'  -- RP
  Begin
	-- Set @asChaine = 'RPCAUTION'
	-- Suite demande de Sylvie Vrigneau
	-- [DT081_EVOL_PRET_BRIS]
	Set @asChaine = 'SPS' + 'CA' + SPACE (4)
  End 
  
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RN_FRAIS_SPECIAUX
-- Auteur               :       FABRY JF
-- Date                 :       06/09/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3_V10]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF		12/10/2017   [VDOC24852]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RN_FRAIS_SPECIAUX' AND type = 'P' )
        DROP procedure sysadm.PS_S_RN_FRAIS_SPECIAUX
GO


CREATE procedure sysadm.PS_S_RN_FRAIS_SPECIAUX
  @adcIdSin		Decimal ( 10 ), -- [PI062]
  @adcIdReg		Decimal ( 2 ),
  @asCodMotReg  VarChar ( 5 ),
  @asChaine		Varchar ( 50 ) OUTPUT
  
AS

Declare @iIdTypFrais Integer

Set @asChaine = SPACE ( 6 )

If @asCodMotReg <> '1' Return @asChaine

If Not Exists ( 
	Select r.*
	From   sysadm.reglement r,
		   sysadm.reg_gti rg
	Where r.id_sin = @adcIdSin
	And   r.id_reg = @adcIdReg
	And   rg.id_sin = r.id_sin
	And   rg.id_reg = r.id_reg
	And   rg.id_gti = -1
	)
	Begin
		Return @asChaine
	End 

Select @iIdTypFrais = f.id_typ_frais
From   sysadm.reglement r,
	   sysadm.reg_gti rg,
	   sysadm.frais f
Where r.id_sin = @adcIdSin
And   r.id_reg = @adcIdReg
And   rg.id_sin = r.id_sin
And   rg.id_reg = r.id_reg
And   rg.id_gti = -1
And   f.id_sin = rg.id_sin
And   f.id_reg = rg.id_reg

-- [VDOC24852] 6
If @iIdTypFrais Not in ( 3, 4, 5, 6 ) Return @asChaine

-- Set @asChaine = Right ( '000' + CONVERT ( VarChar ( 5 ) , @iIdTypFrais), 3) + 'NPR'
-- Suite demande de Sylvie Vrigneau
Set @asChaine = Right ( '000' + CONVERT ( VarChar ( 5 ) , @iIdTypFrais), 3) + 'CO' + SPACE (1)

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RN_FM_SPECIAUX_SANS_RAPPROCHEMENT
-- Auteur               :       FABRY JF
-- Date                 :       08/10/2013
-- Libellé              :        
-- Commentaires         :       [DT044-1_V5]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF  05/04/2016  On génère le SR dans tous les cas
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RN_FM_SPECIAUX_SANS_RAPPROCHEMENT' AND type = 'P' )
        DROP procedure sysadm.PS_S_RN_FM_SPECIAUX_SANS_RAPPROCHEMENT
GO


CREATE procedure sysadm.PS_S_RN_FM_SPECIAUX_SANS_RAPPROCHEMENT
  @adcIdSin		Decimal ( 10 ),
  @adcIdReg		Decimal ( 2 ),
  @asCodMotReg  VarChar ( 5 ),
  @asCodModeReg  VarChar ( 5 ),
  @asChaine		VarChar ( 50 ) OUTPUT
  
AS

Declare @iIdTypFrais Integer

Set @asChaine = SPACE ( 6 )

-- If @asCodMotReg <> '1' Return @asChaine  JFF Le 05/04/2016
If @asCodModeReg <> 'FM' Return @asChaine

If 
(   Select COUNT(*)
	From   sysadm.reglement r,
		   sysadm.detail d,
		   sysadm.div_det dd
	Where  r.id_sin = @adcIdSin
	And    r.id_reg = @adcIdReg
	And    r.cod_inter = 'F'
	And    r.cod_mode_reg = 'FM'
	And    d.id_sin = r.id_sin
	And    ( d.id_reg = r.id_reg
			 Or 
			 d.id_reg = r.id_reg_base) -- JFF Le 05/04/2016
	And    dd.id_sin = d.id_sin
	And    dd.id_gti = d.id_gti
	And    dd.id_detail = d.id_detail
	And    dd.nom_zone = 'pas_de_rglt_fourn'
	And    dd.val_car = 'O' ) <> 1

	Begin 
		Return @asChaine
	End 

Set @asChaine = Space (3) + 'SR' + SPACE (1)

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S011_LSTREG_V03
-- Auteur               :       JFF ( Reprise et modification de la requête initiale de DBI PS_S01_LSTREG )
-- Date                 :       26/11/2013 (PS absente des CP, je la créé !)
-- Libellé              :        
-- Commentaires         :       
-- Références           :       
--
--				
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
-------------------------------------------------------------------
-- [VDOC129010] JFF 26/11/2013 - Ajout zone Type Evènement
-- [VDOC14341] JFF 02/05/2014 - On modifie le lib de la gti si RM Franchise.
-- [VDOC13132] - FPI - 21/05/2014 ajout de la date d'adhésion
-- JFF      06/10/2014   [PM266]
--	FPI		15/01/2015		[VDoc15579] - V03 - ajout colonne ID_ADH
-- JFF   09/12/2015  [VDOC19386] - Je gère le cas CDS/EDI en Rempl par BA.
-- JFF   09/02/2018  [VDOC25665] - Ajout frais d'envoi
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S011_LSTREG_V03' AND type = 'P' )
        DROP procedure sysadm.PS_S011_LSTREG_V03
GO

CREATE procedure sysadm.PS_S011_LSTREG_V03
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      ,
	@dcIdProd	Decimal(7)	WITH RECOMPILE

AS

/* Variante de PS_S01_LSTREG, mais on ne ramène
   pas le détail 
*/

SET NOCOUNT ON

Declare	@sCodAdh Char(1)


Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramSne dans un premier temps le d'tail du rSglement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les r'guls effectu'es
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ), -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
		sinistre.id_adh as 'ID_ADH', -- VDOC15579
   IsNull ( 
	   ( Select sum ( fr.mt_frais ) 
		 From  sysadm.frais fr
		 Where fr.id_sin = sinistre.id_sin
	   ),0 ) 'FRAIS' -- VDOC25665

From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_gti	=	reg_gti.id_gti	 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
		sinistre.id_adh as 'ID_ADH', -- VDOC15579
   IsNull ( 
	   ( Select sum ( fr.mt_frais ) 
		 From  sysadm.frais fr
		 Where fr.id_sin = sinistre.id_sin
	   ),0 ) 'FRAIS' -- VDOC25665

From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 

Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= Case reglement.lib_reg 
				When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
				Else 'REGULARISATION'
			  End,
  'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
		sinistre.id_adh as 'ID_ADH', -- VDOC15579
   IsNull ( 
	   ( Select sum ( fr.mt_frais ) 
		 From  sysadm.frais fr
		 Where fr.id_sin = sinistre.id_sin
	   ),0 ) 'FRAIS' -- VDOC25665 
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


END

Else				-- Adhesions SPB ou autres hors carte

BEGIN

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
		sinistre.id_adh as 'ID_ADH', -- VDOC15579
    IsNull ( 
	   ( Select sum ( fr.mt_frais ) 
		 From  sysadm.frais fr
		 Where fr.id_sin = sinistre.id_sin
	   ),0 ) 'FRAIS' -- VDOC25665
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( reg_gti.id_sin	=	gar_sin.id_sin		)	and
 ( reg_gti.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
		sinistre.id_adh as 'ID_ADH', -- VDOC15579
   IsNull ( 
	   ( Select sum ( fr.mt_frais ) 
		 From  sysadm.frais fr
		 Where fr.id_sin = sinistre.id_sin
	   ),0 ) 'FRAIS' -- VDOC25665
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= Case reglement.lib_reg 
				When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
				Else 'REGULARISATION'
			  End,
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
		sinistre.id_adh as 'ID_ADH', -- VDOC15579
    IsNull ( 
	   ( Select sum ( fr.mt_frais ) 
		 From  sysadm.frais fr
		 Where fr.id_sin = sinistre.id_sin
	   ),0 ) 'FRAIS' -- VDOC25665
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


END

Go

grant execute on sysadm.PS_S011_LSTREG_V03 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_LSTREG_DAS_ADVISE
-- Auteur               :       JFF (reprise PS_S015_LSTREG_DAS FPI)
-- Date                 :       15/12/2011
-- Libellé              :        
-- Commentaires         :       Liste détaillée des réglements pour ADVISE/DAS
-- Références           :       
--
--				EURO
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--				
-- Retourne             :       Rien
-------------------------------------------------------------------
-- [VDoc7724] Ajout des 2 dernières colonnes (mt sin + mt frais)
-- [VDoc7895] ajout des 4 colonnes de garantie constructeur 
-- [VDoc8092] duree_gti_DAS + neuf/occasion
-- [VDOC10924] JFF 15/04/2013 - Modification suite Audit DAS
-- [VDOC12649] JFF 22/11/2013 - Ajout zone Type Evènement
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_LSTREG_DAS_ADVISE' AND type = 'P' )
        DROP procedure sysadm.PS_S_LSTREG_DAS_ADVISE
GO

CREATE procedure sysadm.PS_S_LSTREG_DAS_ADVISE
	@dtDteDeb       DateTime        ,
    @dtDteFin       DateTime	

AS

SET NOCOUNT ON

Declare @sPerReglt varchar(7)
 
Set @sPerReglt=CONVERT(varchar(2),datePart(month,@dtDteFin))
If LEN(@sPerReglt)=1 Set @sPerReglt='0' + @sPerReglt
Set @sPerReglt=@sPerReglt + '/' + CONVERT(varchar(4),datePart(year,@dtDteFin))

Select distinct
 'PERIODE DE REGLT' = @sPerReglt,
 'GESTIONNAIRE' = 'SPB',
 'N° CONTRAT ADVISE/DAS'	= police.lib_police,
 'CIE ASS'	= compagnie.lib_cie,
 'SOUSCRIPTEUR'	= groupe.lib_grp,
 'INTITULE DU CONTRAT'	= produit.lib_long,
 'N° SINISTRE'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
  sysadm.FN_CODE_CAR(div_sin.val_car,'-AR') as genre,
  sinistre.marq_port as 'marque', 
 /* convert(varchar(10),sinistre.dte_ach_port,103) as 'date_achat', */
 -- [VDOC10924]
  Isnull ( 
  convert(varchar(30),
	  Case 
		When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti)
			Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null )
		Else sinistre.dte_ach_port
	  End ,103)
	, 'Pas de date d''achat' )   as 'date_achat',
  -- OLD (select top 1 detail.mt_val_achat from sysadm.detail where detail.id_sin=sinistre.id_sin) as mt_achat,
 -- [VDOC10924]
 -- [VDOC11052]
   IsNull ( 
	Case 
		When ( sinistre.id_prod between 45200 and 45299 ) Or ( sinistre.id_prod between 46500 and 46700 ) -- Cas des CONFO Excellence 
		  Then
			  -- [VDOC11052]
			  Case 
				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = reg_gti.id_gti
					   And   d.id_evt  not in ( 1083, 1317, 934 ) 
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = reg_gti.id_gti
					   And   d.id_evt  not in ( 1083, 1317, 934 ) 
					   And   d.mt_val_achat <> 9999
					  )
					  
				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = reg_gti.id_gti
					   And   d.id_evt  = 1317
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = reg_gti.id_gti
					   And   d.id_evt  = 1317
					   And   d.mt_val_achat <> 9999
					  )

				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = reg_gti.id_gti
					   And   d.id_evt  = 934
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = reg_gti.id_gti
					   And   d.id_evt  = 934
					   And   d.mt_val_achat <> 9999
					  )		

				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = reg_gti.id_gti
					   And   d.id_evt  = 1083
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = reg_gti.id_gti
					   And   d.id_evt  = 1083
					   And   d.mt_val_achat <> 9999
					  )	
				Else 0
			End
					  		
		Else
			  (select top 1 d.mt_val_achat 
			   from sysadm.detail d
			   where d.id_sin=sinistre.id_sin
			   And   d.id_gti = reg_gti.id_gti
			   And   d.mt_val_achat <> 9999
			   And   d.mt_val_achat = ( Select MAX ( d1.mt_val_achat)
											 From  sysadm.detail d1
											 Where d1.id_sin = d.id_sin
											 And   d1.id_gti = d.id_gti
											 And   d1.id_detail = d.id_detail
											 And   d1.mt_val_achat <> 9999 )
			  )
	End
  , 0 ) as mt_achat,  -- [VDOC10924]
  sinistre.id_adh as no_adhesion, 
  convert(varchar(10),sinistre.dte_adh,103) as dte_adh, 
 'date déb garantie' = convert(varchar(10),sinistre.dte_adh,103), 
  convert(varchar(10),sinistre.dte_fin_gti,103) as dte_fin_gti,
  convert(varchar(10),sinistre.dte_surv,103) as dte_surv, 
  datepart(year,sinistre.dte_surv) as annee_surv,
  datepart(month,sinistre.dte_surv) as mois_surv, 
 convert(varchar(10),sinistre.dte_decl,103) as dte_decl,
 'type_garantie' 		= code_Ns.lib_code,
 'garantie' 		= code_Gs.lib_code,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 (select max(detail.mt_plaf) from sysadm.detail where detail.id_sin=gar_sin.id_sin and detail.id_gti=gar_sin.id_gti) as mt_plafond,
 'quantité sinistre' =
	Case 
		When ( sinistre.id_prod between 45200 and 45299 ) Or ( sinistre.id_prod between 46500 and 46700 ) -- Cas des CONFO Excellence 
	   		Then
	   		( Select sum ( ds.val_nbre )
	   		From   sysadm.div_det ds
	   		Where  ds.id_sin = sinistre.id_sin
	   		And    ds.nom_zone = 'qte' )
		Else
			reg_gti.mt_reg / (select max(detail.mt_plaf) from sysadm.detail where detail.id_sin=gar_sin.id_sin and detail.id_gti=gar_sin.id_gti)
    End,		
 'mt_total plafond' = reg_gti.mt_reg,
 'DTE_REG'	= convert(varchar(10),reg_gti.maj_le,103) + ' ' + convert(varchar(10),reg_gti.maj_le,108), -- [ITSM166043]
 'MT_REG_GTI'	= reg_gti.mt_reg,
 /* Old
 (select top 1 mt_val_publique from sysadm.detail 
	where detail.id_sin=sinistre.id_sin and detail.id_sin=reg_gti.id_sin 
	and mt_val_publique > 0
	) as 'montant_sinistre',
  */
 -- [VDOC10924]
  IsNull ( 
  (select top 1 d.mt_val_publique 
   from sysadm.detail d
   where d.id_sin=sinistre.id_sin
   And   d.mt_val_publique = ( Select MAX ( d1.mt_val_publique)
								 From  sysadm.detail d1
								 Where d1.id_sin = d.id_sin
								 And   d1.id_gti = d.id_gti
								 And   d1.id_detail = d.id_detail )
  ), 0 ) as 'montant_sinistre',  -- [VDOC10924]
  (select SUM(mt_frais) from sysadm.frais where frais.id_sin=sinistre.id_sin and frais.id_typ_frais=1) as frais_transport,
/*
  case When d2.val_nbre is not null Then  convert(varchar(10),sinistre.dte_adh,103) Else '' End as dte_deb_gc,
*/
 -- [VDOC10924]	
  Nullif( 
  convert(varchar(10),
	  Case When d2.val_nbre is not null 
			Then 
			  Case 
				When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti)
					Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null )
				Else sinistre.dte_ach_port
			  End
		   Else '' 
	  End ,103) 
  , '01/01/1900' )
  as dte_deb_gc,
/*  case When d2.val_nbre is not null Then convert(varchar(10),DateAdd(Month,d2.val_nbre,sinistre.dte_adh),103) Else '' End as dte_fin_gc, */
 -- [VDOC10924][VDOC11052]
  case When d2.val_nbre is not null 
        Then convert(varchar(10),DateAdd(Month,d2.val_nbre,
			  Case 
				When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti)
					Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null )
				Else sinistre.dte_ach_port
			  End
			),103) Else '' End as dte_fin_gc,
  case When d2.val_nbre is null Then  convert(varchar(10),sinistre.dte_adh,103) 
	Else convert(varchar(10),DateAdd(day, 1, DateAdd(Month,d2.val_nbre,sinistre.dte_adh)),103) End as dte_deb_gti_DAS,
  convert(varchar(10),sinistre.dte_fin_gti,103) as dte_fin_gti_DAS,
  /*(select top 1 sysadm.FN_CLE_VAL('PGC_MOIS',val_car,';') + ' mois' from sysadm.det_pro 
    where det_pro.id_prod=sinistre.id_prod and det_pro.id_code_dp=85) as duree_garantie_das,*/
-- [VDOC10924][VDOC11052] duréé garantie DAS : = date achat - date fin garantie  
--   Convert ( VarChar ( 10),( Convert ( VarChar ( 10), IsNull ( ABS ( DATEDIFF ( MONTH, IsNull ( sinistre.dte_ach_port, IsNull ( sinistre.dte_adh, (Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null ))), sinistre.dte_fin_gti ) ) , 0 ) ) + '' )) as duree_garantie_das_Mois,
	Convert ( VarChar ( 10),( Convert ( VarChar ( 10), IsNull ( ABS ( DATEDIFF ( MONTH, IsNull ( sinistre.dte_ach_port, 
			  IsNUll ( 
			  (Case 
				When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti)
					Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null )
				Else sinistre.dte_ach_port
			  End), sinistre.dte_adh )), sinistre.dte_fin_gti ) ) , 0 ) ) + '' )) as duree_garantie_das_Mois,  			  
 
  case When d2.val_nbre is null Then 'Neuf'
	When d2.val_nbre = 3 Then 'Occasion'
	Else 'Neuf' 
  End as 'Neuf/Occasion',
-- [VDOC10924]
  IsNull (
	  (Select Top 1 rTrim( Convert ( VarChar ( 30), ds.val_nbre ) + '')
	   From	 sysadm.div_sin ds,
			 sysadm.det_pro dp
	   Where dp.id_prod = sinistre.id_prod
	   And   dp.id_code_dp = 85
	   And   ds.id_sin = sinistre.id_sin
	   And   ds.nom_zone= 'duree_gti_origine')
   , 'Non géré sur le contrat' ) As 'Durée_GC(si PGC)',
-- [VDOC10924]
	IsNull (
	Case 
		When ( sinistre.id_prod between 45200 and 45299 ) Or ( sinistre.id_prod between 46500 and 46700 ) -- Cas des CONFO Excellence 
		  Then
		     (select sum ( d.mt_val_achat )
			   from sysadm.detail d
			   where d.id_sin=sinistre.id_sin
			   and   d.id_gti = reg_gti.id_gti
			   And   d.id_evt  not in ( 1083, 1317, 934 ) 
			   And   d.mt_val_achat <> 9999
			  ) 
		Else
		  (select top 1 d.mt_val_achat 
		   from sysadm.detail d
		   where d.id_sin=sinistre.id_sin
		   And   d.mt_val_achat <> 9999
		   And   d.mt_val_achat = ( Select MAX ( d1.mt_val_achat)
										 From  sysadm.detail d1
										 Where d1.id_sin = d.id_sin
										 And   d1.id_gti = d.id_gti
										 And   d1.id_detail = d.id_detail
										 And   d1.mt_val_achat <> 9999 )
		  )*
		  Case 
			When IsNull ( (reg_gti.mt_reg / (select max(detail.mt_plaf) from sysadm.detail where detail.id_sin=gar_sin.id_sin and detail.id_gti=gar_sin.id_gti)), 0 ) < 1
				 Then 1
			Else IsNull ( (reg_gti.mt_reg / (select max(detail.mt_plaf) from sysadm.detail where detail.id_sin=gar_sin.id_sin and detail.id_gti=gar_sin.id_gti)), 0 ) 
		  End 
	End , 0 ) 'Montant_Total_Achat',
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) as typ_evt, -- VDOC12649 	
		Case reglement.cod_mode_reg 
			When 'XA' Then 'Réglement virtuel SPB. Réglé rééllement par la centrale ADVISE vers la boutique ADVISE'
			Else 'Réglement réél SPB'	  
		End 'MODE_REGLEMENT' -- [PC947&977]
 From
 sysadm.reg_gti   
  inner join sysadm.sinistre  on reg_gti.id_sin	=	sinistre.id_sin
  inner join sysadm.produit on sinistre.id_prod	=	produit.id_prod
 left outer join sysadm.div_sin on div_sin.id_sin = sinistre.id_sin and div_sin.nom_zone='type_app'
 left outer join sysadm.div_sin d2 on d2.id_sin = sinistre.id_sin and d2.nom_zone='duree_gti_origine'
 inner join sysadm.personne on personne.id_ordre    = 	sinistre.id_ordre
 inner join sysadm.gar_sin on reg_gti.id_sin	=	gar_sin.id_sin	and reg_gti.id_gti	=	gar_sin.id_gti
 inner join sysadm.garantie on  garantie.id_prod	=	sinistre.id_prod and  garantie.id_rev	=	sinistre.id_rev	and garantie.id_gti	=	reg_gti.id_gti
 inner join sysadm.police on garantie.id_police	=	police.id_police,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.compagnie,
 sysadm.reglement
Where 
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( police.id_cie=138		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 reglement.dte_reg between    @dtDteDeb And @dtDteFin and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV', 'XA' ) ) 


UNION 
Select distinct
 'PERIODE DE REGLT' = @sPerReglt,
 'GESTIONNAIRE' = 'SPB',
 'N° CONTRAT ADVISE/DAS'	= police.lib_police,
 'CIE ASS'	= compagnie.lib_cie,
 'SOUSCRIPTEUR'	= groupe.lib_grp,
 'INTITULE DU CONTRAT'	= produit.lib_long,
 'N° SINISTRE'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
  sysadm.FN_CODE_CAR(div_sin.val_car,'-AR') as genre,
  sinistre.marq_port as 'marque', 
 /* convert(varchar(10),sinistre.dte_ach_port,103) as 'date_achat', */
-- [VDOC10924]
  Isnull ( 
  convert(varchar(30),
  Case 
	When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti)
		Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null )
	Else sinistre.dte_ach_port
  End ,103) 
  , 'Pas de date d''achat' )   as 'date_achat',
-- (select top 1 detail.mt_val_achat from sysadm.detail where detail.id_sin=sinistre.id_sin) as mt_achat,
-- [VDOC11052]
   IsNull ( 
	Case 
		When ( sinistre.id_prod between 45200 and 45299 ) Or ( sinistre.id_prod between 46500 and 46700 ) -- Cas des CONFO Excellence 
		  Then
			  -- [VDOC11052]
			  Case 
				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = reg_gti.id_gti
					   And   d.id_evt  not in ( 1083, 1317, 934 ) 
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = reg_gti.id_gti
					   And   d.id_evt  not in ( 1083, 1317, 934 ) 
					   And   d.mt_val_achat <> 9999
					  )
					  
				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = reg_gti.id_gti
					   And   d.id_evt  = 1317
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = reg_gti.id_gti
					   And   d.id_evt  = 1317
					   And   d.mt_val_achat <> 9999
					  )

				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = reg_gti.id_gti
					   And   d.id_evt  = 934
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = reg_gti.id_gti
					   And   d.id_evt  = 934
					   And   d.mt_val_achat <> 9999
					  )		

				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = reg_gti.id_gti
					   And   d.id_evt  = 1083
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   and   d.id_gti = reg_gti.id_gti
					   And   d.id_evt  = 1083
					   And   d.mt_val_achat <> 9999
					  )	
				Else 0
			End
					  		
		Else
			  (select top 1 d.mt_val_achat 
			   from sysadm.detail d
			   where d.id_sin=sinistre.id_sin
			   And   d.id_gti = reg_gti.id_gti
			   And   d.mt_val_achat <> 9999
			   And   d.mt_val_achat = ( Select MAX ( d1.mt_val_achat)
											 From  sysadm.detail d1
											 Where d1.id_sin = d.id_sin
											 And   d1.id_gti = d.id_gti
											 And   d1.id_detail = d.id_detail
											 And   d1.mt_val_achat <> 9999 )
			  )
	End
  , 0 ) as mt_achat,  -- [VDOC10924]
  sinistre.id_adh as no_adhesion, 
  convert(varchar(10),sinistre.dte_adh,103) as dte_adh, 
 'date déb  garantie' = convert(varchar(10),sinistre.dte_adh,103),
  convert(varchar(10),sinistre.dte_fin_gti,103) as dte_fin_gti,
  convert(varchar(10),sinistre.dte_surv,103) as dte_surv, 
  datepart(year,sinistre.dte_surv) as annee_surv,
  datepart(month,sinistre.dte_surv) as mois_surv, 
 convert(varchar(10),sinistre.dte_decl,103) as dte_decl,
 'type_garantie' 		= code_Ns.lib_code,
 'garantie' 		= code_Nf.lib_code,
 'ALT_PLAF'	= 'N',
  frais.mt_frais as mt_plafond,
 'quantité sinistre' = 
	Case 
		When ( sinistre.id_prod between 45200 and 45299 ) Or ( sinistre.id_prod between 46500 and 46700 ) -- Cas des CONFO Excellence 
	   		Then
	   		( Select sum ( ds.val_nbre )
	   		From   sysadm.div_det ds
	   		Where  ds.id_sin = sinistre.id_sin
	   		And    ds.nom_zone = 'qte' )
		Else
			reg_gti.mt_reg / frais.mt_frais
    End,
 'mt_total plafond' = reg_gti.mt_reg,
 'DTE_REG'	= convert(varchar(10),reg_gti.maj_le,103) + ' ' + convert(varchar(10),reg_gti.maj_le,108), -- [ITSM166043]
 'MT_REG_GTI'	= reg_gti.mt_reg,
 (select top 1 mt_val_publique from sysadm.detail 
	where detail.id_sin=sinistre.id_sin and detail.id_sin=reg_gti.id_sin 
	and mt_val_publique > 0
	) as 'montant_sinistre',
  (select SUM(mt_frais) from sysadm.frais where frais.id_sin=sinistre.id_sin and frais.id_typ_frais=1) as frais_transport,
/*
  case When d2.val_nbre is not null Then  convert(varchar(10),sinistre.dte_adh,103) Else '' End as dte_deb_gc,
*/
 -- [VDOC10924]	
  Nullif ( 
  case When d2.val_nbre is not null Then convert(varchar(10),
		  Case 
			When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti)
				Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null )
			Else sinistre.dte_ach_port
		  End
		,103) 
		Else '' 
	End 
	, '01/01/1900' )
	as dte_deb_gc,
/*  case When d2.val_nbre is not null Then convert(varchar(10),DateAdd(Month,d2.val_nbre,sinistre.dte_adh),103) Else '' End as dte_fin_gc, */
 -- [VDOC10924]	
  case When d2.val_nbre is not null Then convert(varchar(10),DateAdd(Month,d2.val_nbre,
		  Case 
			When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti)
				Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null )
			Else sinistre.dte_ach_port
		  End
			),103) Else '' End as dte_fin_gc,
   case When d2.val_nbre is null Then  convert(varchar(10),sinistre.dte_adh,103) 
	Else convert(varchar(10),DateAdd(day, 1, DateAdd(Month,d2.val_nbre,sinistre.dte_adh)),103) End as dte_deb_gti_DAS,
  convert(varchar(10),sinistre.dte_fin_gti,103) as dte_fin_gti_DAS,
  /*(select top 1 sysadm.FN_CLE_VAL('PGC_MOIS',val_car,';') + ' mois' from sysadm.det_pro 
    where det_pro.id_prod=sinistre.id_prod and det_pro.id_code_dp=85) as duree_garantie_das,*/
-- [VDOC10924]
--   Convert ( VarChar ( 10),Convert ( VarChar ( 10), IsNull ( ABS ( DATEDIFF ( MONTH, sinistre.dte_adh, sinistre.dte_fin_gti ) ) , 0 ) ) + '' ) as duree_garantie_das_Mois,
-- [VDOC10924][VDOC11052] duréé garantie DAS : = date achat - date fin garantie  
--   Convert ( VarChar ( 10),( Convert ( VarChar ( 10), IsNull ( ABS ( DATEDIFF ( MONTH, IsNull ( sinistre.dte_ach_port, IsNull ( sinistre.dte_adh, (Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null ))), sinistre.dte_fin_gti ) ) , 0 ) ) + '' )) as duree_garantie_das_Mois,
	Convert ( VarChar ( 10),( Convert ( VarChar ( 10), IsNull ( ABS ( DATEDIFF ( MONTH, IsNull ( sinistre.dte_ach_port, 
			  IsNUll ( 
			  (Case 
				When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod and d.id_code_num = reg_gti.id_gti)
					Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null )
				Else sinistre.dte_ach_port
			  End), sinistre.dte_adh )), sinistre.dte_fin_gti ) ) , 0 ) ) + '' )) as duree_garantie_das_Mois,  	
  case When d2.val_nbre is null Then 'Neuf'
	When d2.val_nbre = 3 Then 'Occasion'
	Else 'Neuf'
  End as 'Neuf/Occasion',
-- [VDOC10924]
  IsNull (
	  (Select Top 1 rTrim( Convert ( VarChar ( 30), ds.val_nbre ) + '' )
	   From	 sysadm.div_sin ds,
			 sysadm.det_pro dp
	   Where dp.id_prod = sinistre.id_prod
	   And   dp.id_code_dp = 85
	   And   ds.id_sin = sinistre.id_sin
	   And   ds.nom_zone= 'duree_gti_origine')
   , 'Non géré sur le contrat' ) As 'Durée_GC(si PGC)',
  IsNull ( 
        	Case 
        		When ( sinistre.id_prod between 45200 and 45299 ) Or ( sinistre.id_prod between 46500 and 46700 ) -- Cas des CONFO Excellence 
        		  Then
        		     (select sum ( d.mt_val_achat )
        			   from sysadm.detail d
        			   where d.id_sin=sinistre.id_sin
        			   and   d.id_gti = reg_gti.id_gti
        			   And   d.id_evt  not in ( 1083, 1317, 934 ) 
        			   And   d.mt_val_achat <> 9999
        			  ) 
        		Else
        		  (select top 1 d.mt_val_achat 
        		   from sysadm.detail d
        		   where d.id_sin=sinistre.id_sin
        		   And   d.mt_val_achat <> 9999
        		   And   d.mt_val_achat = ( Select MAX ( d1.mt_val_achat)
        										 From  sysadm.detail d1
        										 Where d1.id_sin = d.id_sin
        										 And   d1.id_gti = d.id_gti
        										 And   d1.id_detail = d.id_detail
        										 And   d1.mt_val_achat <> 9999 )
        		  )*
        		  Case 
        			When reg_gti.mt_reg / frais.mt_frais < 1
        				 Then 1
        			Else reg_gti.mt_reg / frais.mt_frais
        		  End
    		  End
    	   , 0 )  'Montant_Total_Achat',
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) as typ_evt, -- VDOC12649 	
		Case reglement.cod_mode_reg 
			When 'XA' Then 'Réglement virtuel SPB. Réglé rééllement par la centrale ADVISE vers la boutique ADVISE'
			Else 'Réglement réél SPB'	  
		End 'MODE_REGLEMENT' -- [PC947&977]
From
 sysadm.reg_gti   
  inner join sysadm.sinistre  on reg_gti.id_sin	=	sinistre.id_sin
  inner join sysadm.produit on sinistre.id_prod	=	produit.id_prod
 left outer join sysadm.div_sin on div_sin.id_sin = sinistre.id_sin and div_sin.nom_zone='type_app'
 left outer join sysadm.div_sin d2 on d2.id_sin = sinistre.id_sin and d2.nom_zone='duree_gti_origine'
 inner join sysadm.personne on personne.id_ordre    = 	sinistre.id_ordre
 inner join sysadm.frais on reg_gti.id_sin	=	frais.id_sin and reg_gti.id_reg	=	frais.id_reg,
 sysadm.garantie,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement
Where 
 ( reg_gti.id_gti	=	-1			)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( police.id_cie=138		)	and
 ( reglement.dte_reg    between    @dtDteDeb And @dtDteFin )	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV', 'XA' ) ) 

UNION 

Select distinct
 'PERIODE DE REGLT' = @sPerReglt,
 'GESTIONNAIRE' = 'SPB',
 'N° CONTRAT ADVISE/DAS'	= police.lib_police,
 'CIE ASS'	= compagnie.lib_cie,
 'SOUSCRIPTEUR'	= groupe.lib_grp,
 'INTITULE DU CONTRAT'	= produit.lib_long,
 'N° SINISTRE'	= sinistre.id_sin,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
  sysadm.FN_CODE_CAR(div_sin.val_car,'-AR') as genre,
  sinistre.marq_port as 'marque', 
/* convert(varchar(10),sinistre.dte_ach_port,103) as 'date_achat', */
-- [VDOC10924]
  IsNull ( 
  convert(varchar(30),
	  Case 
		When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod )
			Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.dte_det is not null )
		Else sinistre.dte_ach_port
	  End ,103) 
  , 'Pas de date d''achat' )   as 'date_achat',
-- (select top 1 detail.mt_val_achat from sysadm.detail where detail.id_sin=sinistre.id_sin) as mt_achat,
-- [VDOC11052]
   IsNull ( 
	Case 
		When ( sinistre.id_prod between 45200 and 45299 ) Or ( sinistre.id_prod between 46500 and 46700 ) -- Cas des CONFO Excellence 
		  Then
			  -- [VDOC11052]
			  Case 
				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  not in ( 1083, 1317, 934 ) 
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  not in ( 1083, 1317, 934 ) 
					   And   d.mt_val_achat <> 9999
					  )
					  
				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  = 1317
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  = 1317
					   And   d.mt_val_achat <> 9999
					  )

				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  = 934
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  = 934
					   And   d.mt_val_achat <> 9999
					  )		

				When (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  = 1083
					   And   d.mt_val_achat <> 9999
					  ) > 0 
					  Then 
					  (select sum ( isnull ( d.mt_val_achat, 0 ) )
					   from sysadm.detail d
					   where d.id_sin=sinistre.id_sin
					   And   d.id_evt  = 1083
					   And   d.mt_val_achat <> 9999
					  )	
				Else 0
			End
					  		
		Else
			  (select top 1 d.mt_val_achat 
			   from sysadm.detail d
			   where d.id_sin=sinistre.id_sin
			   And   d.mt_val_achat <> 9999
			   And   d.mt_val_achat = ( Select MAX ( d1.mt_val_achat)
											 From  sysadm.detail d1
											 Where d1.id_sin = d.id_sin
											 And   d1.id_gti = d.id_gti
											 And   d1.id_detail = d.id_detail
											 And   d1.mt_val_achat <> 9999 )
			  )
	End
  , 0 ) as mt_achat,  -- [VDOC10924]
  sinistre.id_adh as no_adhesion, 
  convert(varchar(10),sinistre.dte_adh,103) as dte_adh,  
  'date déb  garantie' = convert(varchar(10),sinistre.dte_adh,103),
  convert(varchar(10),sinistre.dte_fin_gti,103) as dte_fin_gti,
  convert(varchar(10),sinistre.dte_surv,103) as dte_surv, 
  datepart(year,sinistre.dte_surv) as annee_surv,
  datepart(month,sinistre.dte_surv) as mois_surv, 
  convert(varchar(10),sinistre.dte_decl,103) as dte_decl,
 'type_garantie' 		= code_Ns.lib_code,
 'garantie' 		= 'REGULARISATION',
  'ALT_PLAF'	= 'N',
  reglement.mt_tot_reg as mt_plafond,
  'quantité sinistre' = 1,
  'mt_total plafond' = reglement.mt_tot_reg,
  'DTE_REG'	= convert(varchar(10),reglement.dte_reg,103)+ ' ' + convert(varchar(10),reglement.maj_le,108), -- [ITSM166043]
   'MT_REG_GTI'	= reglement.mt_tot_reg,
 (select top 1 mt_val_publique from sysadm.detail 
	where detail.id_sin=sinistre.id_sin and detail.id_sin=reglement.id_sin 
	and mt_val_publique > 0
	) as 'montant_sinistre',
  (select SUM(mt_frais) from sysadm.frais where frais.id_sin=sinistre.id_sin and frais.id_typ_frais=1) as frais_transport,
/*
  case When d2.val_nbre is not null Then  convert(varchar(10),sinistre.dte_adh,103) Else '' End as dte_deb_gc,
*/
 -- [VDOC10924]	
  nullif ( 
  case When d2.val_nbre is not null Then convert(varchar(10),
		  Case 
			When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod )
				Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.dte_det is not null )
			Else sinistre.dte_ach_port
		  End
			,103) 
		Else '' 
   End, 
   '01/01/1900' )
   as dte_deb_gc,
/*  case When d2.val_nbre is not null Then convert(varchar(10),DateAdd(Month,d2.val_nbre,sinistre.dte_adh),103) Else '' End as dte_fin_gc, */
 -- [VDOC10924]	
  case When d2.val_nbre is not null Then convert(varchar(10),DateAdd(Month,d2.val_nbre,
	  Case 
		When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod )
			Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.dte_det is not null )
		Else sinistre.dte_ach_port
	  End
		),103) Else '' End as dte_fin_gc,
   case When d2.val_nbre is null Then  convert(varchar(10),sinistre.dte_adh,103) 
	Else convert(varchar(10),DateAdd(day, 1, DateAdd(Month,d2.val_nbre,sinistre.dte_adh)),103) End as dte_deb_gti_DAS,
  convert(varchar(10),sinistre.dte_fin_gti,103) as dte_fin_gti_DAS,
  /*(select top 1 sysadm.FN_CLE_VAL('PGC_MOIS',val_car,';') + ' mois' from sysadm.det_pro 
    where det_pro.id_prod=sinistre.id_prod and det_pro.id_code_dp=85) as duree_garantie_das,*/
-- [VDOC10924]
--    Convert ( VarChar ( 10), Convert ( VarChar ( 10), IsNull ( ABS ( DATEDIFF ( MONTH, sinistre.dte_adh, sinistre.dte_fin_gti ) ) , 0 ) ) + '' ) as duree_garantie_das_Mois,
-- [VDOC10924][VDOC11052] duréé garantie DAS : = date achat - date fin garantie  
--   Convert ( VarChar ( 10),( Convert ( VarChar ( 10), IsNull ( ABS ( DATEDIFF ( MONTH, IsNull ( sinistre.dte_ach_port, IsNull ( sinistre.dte_adh, (Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.id_gti = reg_gti.id_gti and dt.dte_det is not null ))), sinistre.dte_fin_gti ) ) , 0 ) ) + '' )) as duree_garantie_das_Mois,
	Convert ( VarChar ( 10),( Convert ( VarChar ( 10), IsNull ( ABS ( DATEDIFF ( MONTH, IsNull ( sinistre.dte_ach_port, 
			  IsNUll ( 
			  (Case 
				When Exists ( Select * from det_pro d where d.id_code_dp = 42 and d.id_code_car = 'A' and d.id_prod = sinistre.id_prod )
					Then ( Select top 1 dte_det From sysadm.detail dt where dt.id_sin= sinistre.id_sin and dt.dte_det is not null )
				Else sinistre.dte_ach_port
			  End), sinistre.dte_adh )), sinistre.dte_fin_gti ) ) , 0 ) ) + '' )) as duree_garantie_das_Mois,  	
  case When d2.val_nbre is null Then 'Neuf'
	When d2.val_nbre = 3 Then 'Occasion'
	Else 'Neuf'
  End as 'Neuf/Occasion',
-- [VDOC10924]
  IsNull (
	  (Select Top 1 rTrim( Convert ( VarChar ( 30), ds.val_nbre ) + '' )
	   From	 sysadm.div_sin ds,
			 sysadm.det_pro dp
	   Where dp.id_prod = sinistre.id_prod
	   And   dp.id_code_dp = 85
	   And   ds.id_sin = sinistre.id_sin
	   And   ds.nom_zone= 'duree_gti_origine')
   , 'Non géré sur le contrat' ) As 'Durée_GC(si PGC)',
  IsNull ( 
  Case 
        		When ( sinistre.id_prod between 45200 and 45299 ) Or ( sinistre.id_prod between 46500 and 46700 ) -- Cas des CONFO Excellence 
        		  Then
        		     (select sum ( d.mt_val_achat )
        			   from sysadm.detail d
        			   where d.id_sin=sinistre.id_sin
        			   And   d.id_evt  not in ( 1083, 1317, 934 ) 
        			   And   d.mt_val_achat <> 9999
        			  ) 
        		Else
        		  (select top 1 d.mt_val_achat 
        		   from sysadm.detail d
        		   where d.id_sin=sinistre.id_sin
        		   And   d.mt_val_achat <> 9999
        		   And   d.mt_val_achat = ( Select MAX ( d1.mt_val_achat)
        										 From  sysadm.detail d1
        										 Where d1.id_sin = d.id_sin
        										 And   d1.id_gti = d.id_gti
        										 And   d1.id_detail = d.id_detail
        										 And   d1.mt_val_achat <> 9999 )
        		  )
    		  End , 0 ) 'Montant_Total_Achat',
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) as typ_evt, -- VDOC12649 	
		Case reglement.cod_mode_reg 
			When 'XA' Then 'Réglement virtuel SPB. Réglé rééllement par la centrale ADVISE vers la boutique ADVISE'
			Else 'Réglement réél SPB'	  
		End 'MODE_REGLEMENT' -- [PC947&977]
  
From
 sysadm.reglement 
  inner join sysadm.sinistre  on reglement.id_sin	=	sinistre.id_sin
  inner join sysadm.produit on sinistre.id_prod	=	produit.id_prod
 left outer join sysadm.div_sin on div_sin.id_sin = sinistre.id_sin and div_sin.nom_zone='type_app'
 left outer join sysadm.div_sin d2 on d2.id_sin = sinistre.id_sin and d2.nom_zone='duree_gti_origine'
 inner join sysadm.personne on personne.id_ordre    = 	sinistre.id_ordre,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.police,
 sysadm.compagnie
Where 
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
  ( police.id_cie=138		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV', 'XA' ) ) 

GO
--------------------------------------------------------------------
--
-- Procédure            :       PS_S21_LSTREG_LECLERC
-- Auteur               :       FPI
-- Date                 :       15/07/2014
-- Libellé              :        
-- Commentaires         :       
-- Références           :		[VDOC14893]   
--
--				
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      06/10/2014   [PM266]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S21_LSTREG_LECLERC' AND type = 'P' )
        DROP procedure sysadm.PS_S21_LSTREG_LECLERC
GO


CREATE procedure sysadm.PS_S21_LSTREG_LECLERC 
	@dtDteDeb       DateTime        ,
    @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      ,
	@dcIdProd	Decimal(7)	WITH RECOMPILE

AS

/* Variante de PS_S011_LSTREG_V02, mais on ramène pas le détail.
*/


Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		 (select Top 1 sysadm.FN_CODE_NUM(d.id_evt,'+EV')
		 from sysadm.detail d
		Where  d.id_sin =  sysadm.reglement.id_sin
		and   (d.id_reg =  sysadm.reglement.id_reg or d.id_reg= sysadm.reglement.id_reg_base))),
		--'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION -- VDOC13132
 
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( reg_gti.id_sin	=	gar_sin.id_sin		)	and
 ( reg_gti.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   (r.id_reg = sysadm.reg_gti.id_reg  or r.id_reg_base=sysadm.reg_gti.id_reg)
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		  (select Top 1 sysadm.FN_CODE_NUM(d.id_evt,'+EV')
		 from sysadm.detail d
		Where  d.id_sin =  sysadm.reglement.id_sin
		and   (d.id_reg =  sysadm.reglement.id_reg or d.id_reg= sysadm.reglement.id_reg_base))),
		--'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION -- VDOC13132
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= Case reglement.lib_reg 
				When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
				Else 'REGULARISATION'
			  End,
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		 (select Top 1 sysadm.FN_CODE_NUM(d.id_evt,'+EV')
		 from sysadm.detail d
		Where  d.id_sin =  sysadm.reglement.id_sin
		and   (d.id_reg =  sysadm.reglement.id_reg or d.id_reg= sysadm.reglement.id_reg_base))),
		--'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION -- VDOC13132
 
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

Go

grant execute on sysadm.PS_S21_LSTREG_LECLERC to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            :       DW_S_RMRP_SPSCIE_CA
-- Auteur               :       FABRY JF
-- Date                 :       10/09/2014
-- Libellé              :        
-- Commentaires         :       [VDOC14887]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- FPI - 18/11/2014 - [VDOC15969] Ajout du libellé de garantie
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_RMRP_SPSCIE_CA' AND type = 'P' )
        DROP procedure sysadm.DW_S_RMRP_SPSCIE_CA
GO

CREATE procedure sysadm.DW_S_RMRP_SPSCIE_CA
  @dtDateDeb	datetime,
  @dtDateFin	datetime WITH RECOMPILE
  
AS

Select	s.id_sin,
		s.id_prod,
		sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_prod',
		c.lib_gti,
		r.mt_tot_reg,
		Case r.lib_reg
			When 'Débit caution>rendu à l''assureur' Then 'RM/CIECA'
			When 'Crédit caution>réclam à l''assureur' Then 'RP/CIECA'
			When 'Débit caution>rendu à SPB Service' Then 'RM/SPSCA'
			When 'Crédit caution>réclam à SPB Service' Then 'RP/SPSCA'
		End cod_mot_reg,
		r.lib_reg,
		r.dte_reg,
		r.valide_le
		
from	sysadm.reglement r,
		sysadm.sinistre s,
		sysadm.det_pro dp,
		sysadm.reg_gti rg,
		sysadm.code_garantie c

where   dp.id_code_dp = 239
And     s.id_prod = dp.id_prod
And     r.id_sin = s.id_sin
And		r.lib_reg in ( 
		'Débit caution>rendu à l''assureur',
		'Crédit caution>réclam à l''assureur',
		'Débit caution>rendu à SPB Service',
		'Crédit caution>réclam à SPB Service'
		)
And    r.dte_reg between @dtDateDeb and @dtDateFin
And    rg.id_sin=s.id_sin
and    rg.id_reg=r.id_reg
and    c.id_prod=s.id_prod
and    c.id_gti=rg.id_gti

Go

grant execute on sysadm.DW_S_RMRP_SPSCIE_CA to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_LSTREG_BNPP
-- Auteur               :       FPI
-- Date                 :       31/08/2015
-- Libellé              :        
-- Commentaires         :       
-- Références           :		[VDOC18386]   
--
--				
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_LSTREG_BNPP' AND type = 'P' )
        DROP procedure sysadm.PS_S_LSTREG_BNPP
GO

CREATE procedure sysadm.PS_S_LSTREG_BNPP 
	@dtDteDeb       DateTime        ,
    @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      ,
	@dcIdProd	Decimal(7)	WITH RECOMPILE

AS

SET NOCOUNT ON

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ), -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, -- VDOC13132
		sinistre.id_adh as ID_ADH,  -- VDOC15579,
		--(select top 1 lib_det from sysadm.detail d where d.id_sin=sinistre.id_sin and d.id_reg=reglement.id_reg order by id_detail) as lib_detail,
		(select  rtrim(lib_det) + ' / ' from sysadm.detail d where d.id_sin=sinistre.id_sin and d.id_reg=reglement.id_reg and lib_det is not null order by id_detail for xml path('')) as lib_detail,
		(select top 1 dte_det from sysadm.detail d where d.id_sin=sinistre.id_sin and d.id_reg=reglement.id_reg order by id_detail) as date_detail,
		(select distinct rtrim(sysadm.FN_CODE_NUM(id_evt,'+EV')) + ' / ' from sysadm.detail d where d.id_sin=sinistre.id_sin and d.id_reg=reglement.id_reg for xml path('')) as lib_evt
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_gti	=	reg_gti.id_gti	 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=   @dcIdProd			)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, -- VDOC13132
		sinistre.id_adh as ID_ADH,  -- VDOC15579,
		frais.lib_frais as lib_detail,
		NULL as date_detail,
		NULL as lib_evt
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 

Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=   @dcIdProd			)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= Case reglement.lib_reg 
				When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
				Else 'REGULARISATION'
			  End,
  'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))

			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, -- VDOC13132
		sinistre.id_adh as ID_ADH ,  -- VDOC15579,
		--(select top 1 lib_det from sysadm.detail d where d.id_sin=sinistre.id_sin and d.id_reg=reglement.id_reg_base order by id_detail) as lib_detail,
		(select  rtrim(lib_det) + ' / ' from sysadm.detail d where d.id_sin=sinistre.id_sin and d.id_reg=reglement.id_reg_base and lib_det is not null order by id_detail for xml path('')) as lib_detail,
		(select top 1 dte_det from sysadm.detail d where d.id_sin=sinistre.id_sin and d.id_reg=reglement.id_reg_base order by id_detail) as date_detail,
		(select distinct rtrim(sysadm.FN_CODE_NUM(id_evt,'+EV')) + ' / ' from sysadm.detail d where d.id_sin=sinistre.id_sin and d.id_reg=reglement.id_reg_base for xml path('')) as lib_evt
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=   @dcIdProd			)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


Go

grant execute on sysadm.PS_S_LSTREG_BNPP to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_LSTREG_VISA
-- Auteur               :       FPI
-- Date                 :       25/11/2015
-- Libellé              :        
-- Commentaires         :       
-- Références           :		[VDOC19187]   
--
--				
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--								@dcIdProd	Decimal(7)		(Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_LSTREG_VISA' AND type = 'P' )
        DROP procedure sysadm.PS_S_LSTREG_VISA
GO

CREATE procedure sysadm.PS_S_LSTREG_VISA 
	@dtDteDeb       DateTime        ,
    @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      ,
	@dcIdProd	Decimal(7)	WITH RECOMPILE

AS

SET NOCOUNT ON

Select
 @dcPeriodeDeb as periodeDeb,
 @dcPeriodeFin as periodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= Case When d.id_detail=d2.id_detail Then reg_gti.mt_reg Else 0.00 End,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail dt,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   dt.id_sin = r.id_sin
		and   dt.id_reg = r.id_reg
		and   c.id_sin = dt.id_sin
		and   c.id_gti = dt.id_gti
		and   c.id_detail = dt.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ), 
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, 
		sinistre.id_adh as ID_ADH,  
		rtrim(isnull(d.lib_det,'')) as lib_detail,
		d.dte_det as date_detail,
		rtrim(sysadm.FN_CODE_NUM(d.id_evt,'+EV')) as lib_evt,
		d.mt_prej
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne,
 sysadm.detail d,
 sysadm.detail d2
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_gti	=	reg_gti.id_gti	 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	= @dcIdProd	)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 
  and d.id_sin=sinistre.id_sin
  and d.id_reg=reglement.id_reg
  and d2.id_sin=sinistre.id_sin
  and d2.id_reg=reglement.id_reg
  and d2.id_detail=(select top 1 id_detail from sysadm.detail dt3 where dt3.id_sin=sinistre.id_sin and dt3.id_reg=reglement.id_reg order by id_detail)

UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , 
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, 
		sinistre.id_adh as ID_ADH,  
		frais.lib_frais as lib_detail,
		NULL as date_detail,
		NULL as lib_evt,
		0 as mt_prej
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.reglement

Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod  = @dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= Case reglement.lib_reg 
				When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
				Else 'REGULARISATION'
			  End,
  'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , 
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, 
		sinistre.id_adh as ID_ADH ,  
		(select  rtrim(lib_det) + ' / ' from sysadm.detail d where d.id_sin=sinistre.id_sin and d.id_reg=reglement.id_reg_base and lib_det is not null order by id_detail for xml path('')) as lib_detail,
		(select top 1 dte_det from sysadm.detail d where d.id_sin=sinistre.id_sin and d.id_reg=reglement.id_reg_base order by id_detail) as date_detail,
		(select distinct rtrim(sysadm.FN_CODE_NUM(id_evt,'+EV')) + ' / ' from sysadm.detail d where d.id_sin=sinistre.id_sin and d.id_reg=reglement.id_reg_base for xml path('')) as lib_evt,
		(select top 1 d.mt_prej from sysadm.detail d where d.id_sin=sinistre.id_sin and d.id_reg=reglement.id_reg_base order by id_detail) as mt_prej
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod = @dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

Go

grant execute on sysadm.PS_S_LSTREG_VISA to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_PSM_EXTRACTANN
-- Auteur               :       FPI
-- Date                 :       25/01/2016
-- Libellé              :        
-- Commentaires         :       Liste hebdomadaire des annulations de commandes
-- Références           :       [VDOC19710]
--
-- Arguments            :       Rien
--
-- Retourne             :       
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_PSM_EXTRACTANN' AND type = 'P' )
        DROP procedure sysadm.PS_S01_PSM_EXTRACTANN
GO
CREATE PROCEDURE sysadm.PS_S01_PSM_EXTRACTANN
as

set NOCOUNT ON

Declare	@dtJour	datetime,
	@dtJ7	datetime

set	@dtJour = convert(datetime,convert(varchar(8), getdate(), 112 ),112)
Set @dtJ7  = dateadd(day,-7,@dtJour)


select 	cast(c.id_sin as varchar(10))+ '-' + cast(c.id_seq as varchar(7)) as 'NUM_CMD_SPB', -- [PI062]
	c.id_ref_four as 'ACTION',
	sysadm.FN_CODE_CAR(d.val_car,'-AR') as 'TYP_ART',
	c.id_marq_art, c.id_modl_art,
	c.id_serie_anc as num_imei,
	p.nom,
	convert(varchar(10),c.cmd_gen_le,103) as date_presta,
	c.maj_le as date_annulation,
	sysadm.FN_CLE_VAL('CODE_BTQ_PSM_CENTRALE',c.info_spb_frn_cplt,';') as btq_centralisation,
	Replace(sysadm.FN_CLE_VAL('CODE_BTQ_PSM_PROXIMITE',c.info_spb_frn_cplt,';'),'#','') as btq_proximite,
	Case When c.info_frn_spb_cplt like '%ASSURE_EN_PDV%' then 'Proximité'
		When c.info_frn_spb_cplt like '%ASSURE_ENVOIE_COLIS%' then 'Envoi de colis'
		Else '' End as choix_client,
		c.info_frn_spb_cplt,
	(select top 1 id_seq 
	 from sysadm.commande c2 
	 where c.id_sin=c2.id_sin and c2.id_seq > c.id_seq 
		and c2.id_four='PSM'
		and c2.id_ref_four=c.id_ref_four) as seq_presta_psm_meme_dossier
from sysadm.commande c 
inner join sysadm.sinistre s on c.id_sin=s.id_sin
inner join sysadm.personne p on p.id_ordre=s.id_ordre
left outer join sysadm.div_sin d on c.id_sin=d.id_sin and d.nom_zone='type_app'
where 	c.id_four = 'PSM' 
and 	( c.id_lot_cmd > 0 and id_lot_cmd < 999900 )
and 	c.cod_etat = 'ANN'
and	id_ann > 0
and	c.maj_le between @dtJ7 and @dtJour 

GO

grant execute on sysadm.PS_S01_PSM_EXTRACTANN to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procédure            :       PS_X_PSM_ECRIREANN
-- Auteur               :       FPI
-- Date                 :       25/01/2016
-- Libellé              :        
-- Commentaires         :       Liste hebdomadaire des annulations de commandes
-- Références           :       [VDOC19710]
--
-- Arguments            :       Rien
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_X_PSM_ECRIREANN' AND type = 'P' )
        DROP procedure sysadm.PS_X_PSM_ECRIREANN
GO

CREATE PROCEDURE sysadm.PS_X_PSM_ECRIREANN
as

Declare @dDateJour	datetime,
	@sCommande	VarChar(250),
        @sFicOut	VarChar(255)

set NOCOUNT ON

SET @dDateJour = GetDate()

SET @sFicOut = master.sysadm.SPB_FN_GET_ROOT()+ '\Simpa2\PSM\fic_annul\ANNPSM-' + 
               CONVERT (char(4), DatePart (year,@dDateJour)  ) + '-' +
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(month,@dDateJour) ),  2 ) + '-' +
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(day,@dDateJour ) ),  2 ) + '.TXT'


SET @sCommande = 'sqlcmd /S' + @@servername + ' /E /Q"' + 
            'SIMPA2_PRO.sysadm.PS_S01_PSM_EXTRACTANN " /o ' 
			+ @sFicOut + ' -s"	" -w5000 -u' -- [I027] Correction sysadm + date ISO
EXEC master.dbo.xp_cmdshell @sCommande, no_output

GO
grant execute on sysadm.PS_X_PSM_ECRIREANN to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_LST_REG_CARDIF_LDE
-- Auteur               :       FPI
-- Date                 :       13/04/2016
-- Libellé              :        
-- Commentaires         :       [VDOC20414] repris depuis PS_S011_LSTREG_V03 + cod_opt + lib_option
-- Références           :       
--
--				
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--								@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_LST_REG_CARDIF_LDE' AND type = 'P' )
        DROP procedure sysadm.PS_S_LST_REG_CARDIF_LDE
GO

CREATE procedure sysadm.PS_S_LST_REG_CARDIF_LDE
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      ,
	@dcIdProd	Decimal(7)	WITH RECOMPILE

AS

SET NOCOUNT ON

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , 
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, 
		sinistre.id_adh as ID_ADH, 
		sinistre.cod_opt as COD_OPT,
		(select codes_libel_30
		from ADHESIONDB_PRO.dbo.codes c 
		where c.codes_code_prod=produit.cod_prod_dms
			and c.codes_ets=sinistre.id_ets
			and c.codes_valeur=sinistre.cod_opt 
			and c.codes_cods=1) as LIB_OPTION
 
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( reg_gti.id_sin	=	gar_sin.id_sin		)	and
 ( reg_gti.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , 
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, 
		sinistre.id_adh as ID_ADH, 
		sinistre.cod_opt as COD_OPT,
		(select codes_libel_30
		from ADHESIONDB_PRO.dbo.codes c 
		where c.codes_code_prod=produit.cod_prod_dms
			and c.codes_ets=sinistre.id_ets
			and c.codes_valeur=sinistre.cod_opt 
			and c.codes_cods=1) as LIB_OPTION
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.reglement
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= Case reglement.lib_reg 
				When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
				Else 'REGULARISATION'
			  End,
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , 
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, 
		sinistre.id_adh as ID_ADH, 
		sinistre.cod_opt  as COD_OPT,
		(select codes_libel_30
		from ADHESIONDB_PRO.dbo.codes c 
		where c.codes_code_prod=produit.cod_prod_dms
			and c.codes_ets=sinistre.id_ets
			and c.codes_valeur=sinistre.cod_opt 
			and c.codes_cods=1) as LIB_OPTION
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 



Go

grant execute on sysadm.PS_S_LST_REG_CARDIF_LDE to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_JOURN_IRREP_PSM_PEC_A_RECYCLER
-- Auteur               :       FPI
-- Date                 :       13/04/2016
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC20386]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_JOURN_IRREP_PSM_PEC_A_RECYCLER' AND type = 'P' )
        DROP procedure sysadm.PS_S_JOURN_IRREP_PSM_PEC_A_RECYCLER
GO

CREATE procedure sysadm.PS_S_JOURN_IRREP_PSM_PEC_A_RECYCLER
AS

Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation


-- @dtDateDeb = la veille à 00:00
Set @dtDateDeb = CONVERT( DateTime,
				convert(varchar(10), DATEADD(day,-1,getdate()) , 103),
				 103 )

-- @@dtDateFin = la veille à 23:59:59
Set @dtDateFin = CONVERT( DateTime,
			convert(varchar(10), getdate() , 103),
				 103 )

set @dtDateFin=DATEADD(SECOND,-1,@dtDateFin)

Select Convert ( VarChar ( 10), @dtDateDeb, 103 ) 'periode_deb_dte_fin_trt',
	   Convert ( VarChar ( 10), @dtDateFin, 103 ) 'periode_fin_dte_fin_trt',
	   CONVERT ( VarChar ( 10), c.id_sin ) + '-' + CONVERT ( VarChar ( 10), c.id_seq )'num_presta_spb',
	   s.id_prod,
	   sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_prod',
	   cie.lib_cie 'Assureur',
	   s.marq_port 'Marque',
	   s.modl_port 'Modele',
	   '''' + s.num_imei_port + '''' 'IMEI',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré en pointe de vente'
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré envoie coli en centralisation'
	   End 'pdv_ou_coli_centl',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c2.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c2.info_frn_spb_cplt) , ';' )
	   End 'Nom PSM',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c2.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c2.info_frn_spb_cplt) , ';' )
		End 'Numéro PSM',
	   Convert ( VarChar ( 10), c2.dte_rcp_frn, 103 ) 'dte_rcp_PSM',
	   sysadm.FN_CODE_CAR(d.val_car,'-AR') 'Type appareil'

From sysadm.commande c
Inner Join sysadm.gar_sin g on g.id_sin = c.id_sin And g.id_gti = c.id_gti
Inner Join sysadm.sinistre s on s.id_sin = c.id_sin
Inner Join sysadm.garantie ga on ga.id_prod = s.id_prod And 
								 ga.id_gti = c.id_gti And
								 ga.id_rev = s.id_rev
Inner Join sysadm.police po on po.id_police = ga.id_police
Inner Join sysadm.compagnie cie on cie.id_cie = po.id_cie
inner join sysadm.div_sin d on d.id_sin=c.id_sin
inner join sysadm.commande c2 on c2.id_sin=c.id_sin 
	and c2.id_seq=(select max(id_seq) from sysadm.commande c3 where c3.id_sin=s.id_sin and c3.id_four='PSM' and c3.id_seq < c.id_seq)
Where c.cree_le > '01/01/2015'
and   c.id_four='PSM'
And   c.id_ref_four='PEC_A_RECYCLER'
And   s.id_prod not between 48100 and 48199 -- [VDoc18783]
And   s.id_prod not between 84000 and 84099 -- [VDoc18783]
and   d.nom_zone='type_app'
And   c.valide_le between @dtDateDeb And @dtDateFin

Go

grant execute on sysadm.PS_S_JOURN_IRREP_PSM_PEC_A_RECYCLER to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procédure            :       PS_S_JOURN_IRREP_PSM_PEC_A_RECYCLER_EXCEL
-- Auteur               :       FPI
-- Date                 :       13/04/2016
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC20386]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_JOURN_IRREP_PSM_PEC_A_RECYCLER_EXCEL' AND type = 'P' )
        DROP procedure sysadm.PS_S_JOURN_IRREP_PSM_PEC_A_RECYCLER_EXCEL
GO

CREATE procedure sysadm.PS_S_JOURN_IRREP_PSM_PEC_A_RECYCLER_EXCEL
AS


DECLARE @sCommande   VarChar(250),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
        @sFicOut2     VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sPath2 VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	




-- chemin d'enregistrement du Result Set
--Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Extraction_PSM_Mens_vDoc9850\'
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT() + 'SIMPA2\O2M\Irrep_PSM_quot\'
Set @sPath2 	= master.sysadm.SPB_FN_GET_ROOT() + 'SIMPA2\PSM\Irrep_PSM_quot\'
Set @sFileName	= 'Irrep_PSM_'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + convert(varchar(8),getdate(),112) + '.' + @sFileExt
SET @sFicOut2 = @sPath2 + @sFileName + convert(varchar(8),getdate(),112) + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' -- + ' /u'

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
	'SET NOCOUNT ON;exec ' + db_name() + '.sysadm.PS_S_JOURN_IRREP_PSM_PEC_A_RECYCLER ' + 
	'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
		'SET NOCOUNT ON;exec ' + db_name() + '.sysadm.PS_S_JOURN_IRREP_PSM_PEC_A_RECYCLER ' + 
		'" /o' + @sFicOut2 + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output


Go

grant execute on sysadm.PS_S_JOURN_IRREP_PSM_PEC_A_RECYCLER_EXCEL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_MENS_LISTE_PROD_PSM
-- Auteur               :       FPI
-- Date                 :       26/04/2016
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC20711]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MENS_LISTE_PROD_PSM' AND type = 'P' )
        DROP procedure sysadm.PS_S_MENS_LISTE_PROD_PSM
GO

CREATE procedure sysadm.PS_S_MENS_LISTE_PROD_PSM
AS

	select distinct c.id_prod, 
		sysadm.FN_LIB_PROD(c.id_prod) as lib_produit,
		Case When exists (select 1 from det_pro d 
			where d.id_prod=c.id_prod
				and d.id_code_dp=209
				and sysadm.FN_CLE_VAL('DNCX_BTQ_PROXMITE',val_car,';') = 'OUI') Then 'Non'
				Else 'Oui' End as proximite_possible,
		co.lib_cie	
	from commande_type c
	inner join garantie g on g.id_prod=c.id_prod and g.id_gti=c.id_gti
	inner join police po on g.id_police=po.id_police
	inner join compagnie co on co.id_cie=po.id_cie
	inner join sysadm.produit p on p.id_prod=c.id_prod
	where c.id_code_frn='PSM'
		and p.id_corb < 998
Go

grant execute on sysadm.PS_S_MENS_LISTE_PROD_PSM to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procédure            :       PS_S_MENS_LISTE_PROD_PSM_EXCEL
-- Auteur               :       FPI
-- Date                 :       26/04/2016
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC20711]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MENS_LISTE_PROD_PSM_EXCEL' AND type = 'P' )
        DROP procedure sysadm.PS_S_MENS_LISTE_PROD_PSM_EXCEL
GO

CREATE procedure sysadm.PS_S_MENS_LISTE_PROD_PSM_EXCEL
AS


DECLARE @sCommande   VarChar(250),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	




-- chemin d'enregistrement du Result Set
--Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Extraction_PSM_Mens_vDoc9850\'
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT() + 'Simpa2\PSM\Produits\'
Set @sFileName	= 'Produits_PSM_'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + convert(varchar(8),getdate(),112) + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' -- + ' /u'

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
	'SET NOCOUNT ON;exec ' + db_name() + '.sysadm.PS_S_MENS_LISTE_PROD_PSM ' + 
	'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Go

grant execute on sysadm.PS_S_MENS_LISTE_PROD_PSM_EXCEL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_LSTREG_COFINOGA
-- Auteur               :       FPI
-- Date                 :       13/06/2016
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC21063]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_LSTREG_COFINOGA' AND type = 'P' )
        DROP procedure sysadm.PS_S01_LSTREG_COFINOGA
GO

CREATE procedure sysadm.PS_S01_LSTREG_COFINOGA
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      ,
	@dcIdProd	Decimal(7)	WITH RECOMPILE

AS

SET NOCOUNT ON

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, -- VDOC13132
		sinistre.id_adh as ID_ADH, -- VDOC15579
		sinistre.marq_port, 
		sinistre.modl_port,
		Case when inter.cod_inter='A' then 'Assuré' else inter.nom End as dest_reglment
 
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne,
 sysadm.inter
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( reg_gti.id_sin	=	gar_sin.id_sin		)	and
 ( reg_gti.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  and inter.id_sin=sinistre.id_sin
  and inter.id_i=reglement.id_i
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, -- VDOC13132
		sinistre.id_adh as ID_ADH, -- VDOC15579
		sinistre.marq_port, 
		sinistre.modl_port,
		Case when inter.cod_inter='A' then 'Assuré' else inter.nom End as dest_reglment
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement,
-- [BUG20080728].COD_MODE_REG  JFF 
 sysadm.inter
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  and inter.id_sin=sinistre.id_sin
  and inter.id_i=reglement.id_i
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= Case reglement.lib_reg 
				When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
				Else 'REGULARISATION'
			  End,
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, -- VDOC13132
		sinistre.id_adh as ID_ADH, -- VDOC15579
		sinistre.marq_port, 
		sinistre.modl_port,
		Case when inter.cod_inter='A' then 'Assuré' else inter.nom End as dest_reglment
 
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.inter
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  and inter.id_sin=sinistre.id_sin
  and inter.id_i=reglement.id_i
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

Go

grant execute on sysadm.PS_S01_LSTREG_COFINOGA to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_JOURN_IRREP_REFUSE_A_REEXP
-- Auteur               :       FPI
-- Date                 :       03/07/2017
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC24005]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_JOURN_IRREP_REFUSE_A_REEXP' AND type = 'P' )
        DROP procedure sysadm.PS_S_JOURN_IRREP_REFUSE_A_REEXP
GO

CREATE procedure sysadm.PS_S_JOURN_IRREP_REFUSE_A_REEXP
	@asDestinataire varchar(4)
AS

Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation


-- @dtDateDeb = la veille à 00:00
Set @dtDateDeb = CONVERT( DateTime,
				convert(varchar(10), DATEADD(day,-1,getdate()) , 103),
				 103 )

-- @@dtDateFin = la veille à 23:59:59
Set @dtDateFin = CONVERT( DateTime,
			convert(varchar(10), getdate() , 103),
				 103 )

set @dtDateFin=DATEADD(SECOND,-1,@dtDateFin)

Select Convert ( VarChar ( 10), @dtDateDeb, 103 ) 'periode_deb_dte_fin_trt',
	   Convert ( VarChar ( 10), @dtDateFin, 103 ) 'periode_fin_dte_fin_trt',
	   CONVERT ( VarChar ( 10), c.id_sin ) + '-' + CONVERT ( VarChar ( 10), c.id_seq )'num_presta_spb',
	   s.id_prod,
	   sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_prod',
	   cie.lib_cie 'Assureur',
	   s.marq_port 'Marque',
	   s.modl_port 'Modele',
	   '''' + s.num_imei_port + '''' 'IMEI',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré en pointe de vente'
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré envoie coli en centralisation'
	   End 'pdv_ou_coli_centl',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c2.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c2.info_frn_spb_cplt) , ';' )
	   End 'Nom PSM',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c2.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c2.info_frn_spb_cplt) , ';' )
		End 'Numéro PSM',
	   Convert ( VarChar ( 10), c2.dte_rcp_frn, 103 ) 'dte_rcp_PSM',
	   sysadm.FN_CODE_CAR(d.val_car,'-AR') 'Type appareil'

From sysadm.commande c
Inner Join sysadm.gar_sin g on g.id_sin = c.id_sin And g.id_gti = c.id_gti
Inner Join sysadm.sinistre s on s.id_sin = c.id_sin
Inner Join sysadm.garantie ga on ga.id_prod = s.id_prod And 
								 ga.id_gti = c.id_gti And
								 ga.id_rev = s.id_rev
Inner Join sysadm.police po on po.id_police = ga.id_police
Inner Join sysadm.compagnie cie on cie.id_cie = po.id_cie
inner join sysadm.div_sin d on d.id_sin=c.id_sin
inner join sysadm.commande c2 on c2.id_sin=c.id_sin 
	and c2.id_seq=(select max(id_seq) from sysadm.commande c3 where c3.id_sin=s.id_sin and c3.id_four='PSM' and c3.id_seq < c.id_seq)
Where c.cree_le > '01/01/2015'
and   c.id_four in ('PSM','O2M')
And   c.id_ref_four='REFUSE_A_REEXP'
And   s.id_prod not between 48100 and 48199 
And   s.id_prod not between 84000 and 84099 
and   d.nom_zone='type_app'
And   c.valide_le between @dtDateDeb And @dtDateFin
And (@asDestinataire='O2M' or  c.id_four <>'O2M')

Go


grant execute on sysadm.PS_S_JOURN_IRREP_REFUSE_A_REEXP to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_JOURN_IRREP_REFUSE_A_REEXP_FICHIER
-- Auteur               :       FPI
-- Date                 :       03/07/2017
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC24005]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_JOURN_IRREP_REFUSE_A_REEXP_FICHIER' AND type = 'P' )
        DROP procedure sysadm.PS_S_JOURN_IRREP_REFUSE_A_REEXP_FICHIER
GO

CREATE procedure sysadm.PS_S_JOURN_IRREP_REFUSE_A_REEXP_FICHIER
AS


DECLARE @sCommande   VarChar(250),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
        @sFicOut2     VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sPath2 VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	




-- chemin d'enregistrement du Result Set
--Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Extraction_PSM_Mens_vDoc9850\'
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT() + 'SIMPA2\O2M\Refus_a_reexpedier\'
Set @sPath2 	= master.sysadm.SPB_FN_GET_ROOT() + 'SIMPA2\PSM\Refus_a_reexpedier\'
Set @sFileName	= 'Refuse_a_reexp_'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + convert(varchar(8),getdate(),112) + '.' + @sFileExt
SET @sFicOut2 = @sPath2 + @sFileName + convert(varchar(8),getdate(),112) + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' -- + ' /u'

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
	'SET NOCOUNT ON;exec ' + db_name() + '.sysadm.PS_S_JOURN_IRREP_REFUSE_A_REEXP ''O2M''' + 
	'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
		'SET NOCOUNT ON;exec ' + db_name() + '.sysadm.PS_S_JOURN_IRREP_REFUSE_A_REEXP ''PSM''' + 
		'" /o' + @sFicOut2 + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output


Go

grant execute on sysadm.PS_S_JOURN_IRREP_REFUSE_A_REEXP_FICHIER to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_LSTREG_MOBILEO
-- Auteur               :       FPI	
-- Date                 :       11/09/2017
-- Libellé              :       [VDoc24614]
-- Commentaires         :       Automatisation de la VDoc 24418
-- Références           :       
--
--				
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_LSTREG_MOBILEO' AND type = 'P' )
        DROP procedure sysadm.PS_S_LSTREG_MOBILEO
GO

CREATE procedure sysadm.PS_S_LSTREG_MOBILEO
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      WITH RECOMPILE

AS

-- Repris de PS_S011_LSTREG_V03

SET NOCOUNT ON

Declare 
	@dcIdProdMin	Decimal(7),
	@dcIdProdMax Decimal(7)

Select @dcIdProdMin=44500, 
	@dcIdProdMax=44599

Select
'Règlement de la période' as type_reg,
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= convert(varchar(10),reg_gti.maj_le,103),
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= convert(varchar(10),sinistre.dte_surv,103),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= convert(varchar(10),sinistre.dte_decl,103),
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, -- VDOC13132
		sinistre.id_adh as ID_ADH -- VDOC15579
		,Case when i.cod_inter='A' Then 'Assuré' Else i.nom End as destinataire_reg
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne,
 sysadm.inter i 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( reg_gti.id_sin	=	gar_sin.id_sin		)	and
 ( reg_gti.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	between	@dcIdProdMin and @dcIdProdMax		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 
	  and i.id_sin=reglement.id_sin and i.id_i=reglement.id_i
UNION ALL
Select
'Règlement de la période' as type_reg,
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= convert(varchar(10),reg_gti.maj_le,103),
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= convert(varchar(10),sinistre.dte_surv,103),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= convert(varchar(10),sinistre.dte_decl,103),
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, -- VDOC13132
		sinistre.id_adh as ID_ADH -- VDOC15579
		,Case when i.cod_inter='A' Then 'Assuré' Else i.nom End as destinataire_reg
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement,
 sysadm.inter i 
-- [BUG20080728].COD_MODE_REG  JFF 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	between	@dcIdProdMin and @dcIdProdMax		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 
	  and i.id_sin=reglement.id_sin and i.id_i=reglement.id_i
UNION ALL

Select
'Règlement de la période' as type_reg,
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= convert(varchar(10),reglement.dte_reg,103),
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= convert(varchar(10),sinistre.dte_surv,103),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= convert(varchar(10),sinistre.dte_decl,103),
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= Case reglement.lib_reg 
				When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
				Else 'REGULARISATION'
			  End,
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, -- VDOC13132
		sinistre.id_adh as ID_ADH -- VDOC15579
		,Case when i.cod_inter='A' Then 'Assuré' Else i.nom End as destinataire_reg
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.inter i 
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	between	@dcIdProdMin and @dcIdProdMax )	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 
	  and i.id_sin=reglement.id_sin and i.id_i=reglement.id_i
Union
Select
'Règlement hors période' as type_reg,
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= convert(varchar(10),reglement.dte_reg,103),
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= convert(varchar(10),sinistre.dte_surv,103),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= convert(varchar(10),sinistre.dte_decl,103),
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= Case reglement.lib_reg 
				When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
				Else 'REGULARISATION'
			  End,
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, -- VDOC13132
		sinistre.id_adh as ID_ADH -- VDOC15579
	,Case when i.cod_inter='A' Then 'Assuré' Else i.nom End as destinataire_reg
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.inter i 
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	between	@dcIdProdMin and @dcIdProdMax )	and
 ( reglement.dte_reg < @dtDteFin )	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
 and reglement.cod_mot_reg <> 'RI'
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

	and exists (select 1 from sysadm.reglement r2 where r2.id_sin=reglement.id_sin and r2.dte_reg between @dtDteDeb and @dtDteFin)
	and not exists (select 1 from sysadm.reglement r2 where r2.id_sin=reglement.id_sin and r2.dte_reg between @dtDteDeb and @dtDteFin and r2.id_reg=reglement.id_reg)
	and i.id_sin=reglement.id_sin and i.id_i=reglement.id_i

Go

grant execute on sysadm.PS_S_LSTREG_MOBILEO to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_LSTREG_MOBILEO_V01
-- Auteur               :       FPI	
-- Date                 :       07/11/2017
-- Libellé              :       [VDoc24994]
-- Commentaires         :       Automatisation de la VDoc 24418
-- Références           :       
--
--				
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_LSTREG_MOBILEO_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S_LSTREG_MOBILEO_V01
GO

CREATE procedure sysadm.PS_S_LSTREG_MOBILEO_V01
	@dtDteDeb       DateTime        ,
        @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7),
	@dcIdProdMin	Decimal(7),
	@dcIdProdMax Decimal(7)	WITH RECOMPILE

AS

-- Repris de PS_S011_LSTREG_V03

SET NOCOUNT ON

Select
'Règlement de la période' as type_reg,
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= convert(varchar(10),reg_gti.maj_le,103),
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= convert(varchar(10),sinistre.dte_surv,103),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= convert(varchar(10),sinistre.dte_decl,103),
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, -- VDOC13132
		sinistre.id_adh as ID_ADH -- VDOC15579
		,Case when i.cod_inter='A' Then 'Assuré' Else i.nom End as destinataire_reg,
		(select mt_plaf 
		 from sysadm.plafond pl 
		where pl.id_prod=sinistre.id_prod 
			and (pl.id_rev=-1 or pl.id_rev=sinistre.id_rev)
			and pl.id_gti=garantie.id_gti and pl.id_typ_plaf=680) as plafond
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne,
 sysadm.inter i 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( reg_gti.id_sin	=	gar_sin.id_sin		)	and
 ( reg_gti.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	between	@dcIdProdMin and @dcIdProdMax		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 
	  and i.id_sin=reglement.id_sin and i.id_i=reglement.id_i
UNION ALL
Select
'Règlement de la période' as type_reg,
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= convert(varchar(10),reg_gti.maj_le,103),
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= convert(varchar(10),sinistre.dte_surv,103),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= convert(varchar(10),sinistre.dte_decl,103),
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, -- VDOC13132
		sinistre.id_adh as ID_ADH -- VDOC15579
		,Case when i.cod_inter='A' Then 'Assuré' Else i.nom End as destinataire_reg,
		(select mt_plaf 
		 from sysadm.plafond pl 
		where pl.id_prod=sinistre.id_prod 
			and (pl.id_rev=-1 or pl.id_rev=sinistre.id_rev)
			and pl.id_gti=garantie.id_gti and pl.id_typ_plaf=680) as plafond
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement,
 sysadm.inter i 
-- [BUG20080728].COD_MODE_REG  JFF 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	between	@dcIdProdMin and @dcIdProdMax		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 
	  and i.id_sin=reglement.id_sin and i.id_i=reglement.id_i
UNION ALL

Select
'Règlement de la période' as type_reg,
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= convert(varchar(10),reglement.dte_reg,103),
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= convert(varchar(10),sinistre.dte_surv,103),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= convert(varchar(10),sinistre.dte_decl,103),
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= Case reglement.lib_reg 
				When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
				Else 'REGULARISATION'
			  End,
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, -- VDOC13132
		sinistre.id_adh as ID_ADH -- VDOC15579
		,Case when i.cod_inter='A' Then 'Assuré' Else i.nom End as destinataire_reg,
		(select mt_plaf 
		 from sysadm.plafond pl 
		where pl.id_prod=sinistre.id_prod 
			and (pl.id_rev=-1 or pl.id_rev=sinistre.id_rev)
			and pl.id_gti=garantie.id_gti and pl.id_typ_plaf=680) as plafond
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.inter i 
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	between	@dcIdProdMin and @dcIdProdMax )	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 
	  and i.id_sin=reglement.id_sin and i.id_i=reglement.id_i
Union
Select
'Règlement hors période' as type_reg,
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= convert(varchar(10),reglement.dte_reg,103),
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= convert(varchar(10),sinistre.dte_surv,103),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= convert(varchar(10),sinistre.dte_decl,103),
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= Case reglement.lib_reg 
				When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
				Else 'REGULARISATION'
			  End,
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'NOM'		= personne.nom,
 'PRENOM'	= personne.prenom,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as DATE_ADHESION, -- VDOC13132
		sinistre.id_adh as ID_ADH -- VDOC15579
	,Case when i.cod_inter='A' Then 'Assuré' Else i.nom End as destinataire_reg,
	(select mt_plaf 
		 from sysadm.plafond pl 
		where pl.id_prod=sinistre.id_prod 
			and (pl.id_rev=-1 or pl.id_rev=sinistre.id_rev)
			and pl.id_gti=garantie.id_gti and pl.id_typ_plaf=680) as plafond
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.inter i 
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	between	@dcIdProdMin and @dcIdProdMax )	and
 ( reglement.dte_reg < @dtDteFin )	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
 and reglement.cod_mot_reg <> 'RI'
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

	and exists (select 1 from sysadm.reglement r2 where r2.id_sin=reglement.id_sin and r2.dte_reg between @dtDteDeb and @dtDteFin)
	and not exists (select 1 from sysadm.reglement r2 where r2.id_sin=reglement.id_sin and r2.dte_reg between @dtDteDeb and @dtDteFin and r2.id_reg=reglement.id_reg)
	and i.id_sin=reglement.id_sin and i.id_i=reglement.id_i

Go

grant execute on sysadm.PS_S_LSTREG_MOBILEO_V01 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_VDOC28472
-- Auteur               :       FPI	
-- Date                 :       07/10/2019
-- Libellé              :       [VDoc28472]
-- Commentaires         :       Fenêtre traitement autre fichier - tiret commande à partir du n° dossier / montant / fournisseur
-- Références           :       
--
--				
--	
-- Arguments            :       @dcIdSin 	decimal(10) 	(Val)
-- 								@dcMtReg 	decimal(11,2) 	(Val)
--								@sIdFour 	varchar(3)		(Val)
--								@sRet		varchar(255) 	(Ref)
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC28472' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC28472
GO

CREATE PROCEDURE sysadm.PS_S_VDOC28472
	@dcIdSin decimal(10), 
	@dcMtReg decimal(11,2), 
	@sIdFour varchar(3),
	@sRet	varchar(255) OUTPUT
As

	Set @sRet=''

	select @sRet=stuff((select '/' + convert(varchar(10),c.id_seq) 
		from sysadm.commande c 
			inner join sysadm.detail d on d.id_sin=c.id_sin and c.id_gti=d.id_gti and c.id_detail=d.id_detail
		where c.id_sin=r.id_sin and c.id_four=@sIdFour and (r.id_reg=d.id_reg or r.id_reg_base=d.id_reg) 
		order by id_seq For XML PATH ('')),1, 1, '' ) 
	from sysadm.reglement r
	where r.id_sin=@dcIdSin and r.mt_tot_reg=@dcMtReg
		and r.id_i > 0 -- 16/12/2019
Go

grant execute on sysadm.PS_S_VDOC28472 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RPFR
-- Auteur               :       FABRY JF
-- Date                 :       08/10/2019
-- Libellé              :        
-- Commentaires         :       [PM462-1][V3]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RPFR' AND type = 'P' )
        DROP procedure sysadm.PS_S_RPFR
GO


CREATE procedure sysadm.PS_S_RPFR
  @adcIdSin		Decimal ( 10 ), -- [PI062]
  @adcIdReg		Decimal ( 2 ),
  @asChaine		Varchar ( 10 ) OUTPUT
  
AS

Declare @sLibReg  Varchar ( 35 )

Select @sLibReg = r.lib_reg
From   sysadm.reglement r
Where r.id_sin = @adcIdSin
And   r.id_reg = @adcIdReg
If @sLibReg is null Set @sLibReg = ''

If @sLibReg = 'RP/REMB. FRANCHISE CB A L''ASSUREUR'
Begin
	Set @asChaine = Left ( 'CB' + Space (3 ) , 3 )
	Set @asChaine = @asChaine + 'FR'
End 
Else
Begin
	Set @asChaine = SPACE ( 5 )
End 

Go



--------------------------------------------------------------------
--
-- Procédure            :       PS_S_FM_ALD_C_CAS_PART
-- Auteur               :       FABRY JF
-- Date                 :       08/10/2019
-- Libellé              :        
-- Commentaires         :       [PM462-1][V3]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_FM_ALD_C_CAS_PART' AND type = 'P' )
        DROP procedure sysadm.PS_S_FM_ALD_C_CAS_PART
GO


CREATE procedure sysadm.PS_S_FM_ALD_C_CAS_PART
  @adcIdSin		Decimal ( 10 ), -- [PI062]
  @adcIdReg		Decimal ( 2 ),
  @asChaine		Varchar ( 10 ) OUTPUT
  
AS

Declare @sLibReg  Varchar ( 35 )

Select @sLibReg = r.lib_reg
From   sysadm.reglement r
Where r.id_sin = @adcIdSin
And   r.id_reg = @adcIdReg
If @sLibReg is null Set @sLibReg = ''

If ( @sLibReg = 'RP/REMB. FRANCHISE CB A L''ASSUREUR' OR @sLibReg = 'RM/REMB. FRANCHISE CB A L''ASSUREUR' ) And @asChaine = 'C'
Begin
	Set @asChaine = Left ( 'FM' + Space (2 ) , 2 )
End 
Else
Begin
	Set @asChaine = Left ( @asChaine + Space (2 ) , 2 )
End 

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RETROUVER_ID_FOURN_FM_C_CAS_PART
-- Auteur               :       FABRY JF
-- Date                 :       08/10/2019
-- Libellé              :        
-- Commentaires         :       [PM462-1][V3]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RETROUVER_ID_FOURN_FM_C_CAS_PART' AND type = 'P' )
        DROP procedure sysadm.PS_S_RETROUVER_ID_FOURN_FM_C_CAS_PART
GO

CREATE procedure sysadm.PS_S_RETROUVER_ID_FOURN_FM_C_CAS_PART
  @adcIdSin		Decimal ( 10 ), -- [PI062]
  @adcIdReg		Decimal ( 2 ),
  @asChaine		Varchar ( 10 ) OUTPUT
  
AS

Declare @sLibReg  Varchar ( 35 )
Declare @dcIdRegBase  Decimal ( 7 ) 
Declare @sIdFour VarChar ( 3 )

Select @sLibReg = r.lib_reg,
	   @dcIdRegBase = r.id_reg_base
From   sysadm.reglement r
Where r.id_sin = @adcIdSin
And   r.id_reg = @adcIdReg
If @sLibReg is null Set @sLibReg = ''

If ( @sLibReg = 'RP/REMB. FRANCHISE CB A L''ASSUREUR' OR @sLibReg = 'RM/REMB. FRANCHISE CB A L''ASSUREUR' ) 
Begin

	Select @sIdFour = rtrim ( i.id_four )
	From  sysadm.reglement r,
		  sysadm.inter i 
	Where r.id_sin = @adcIdSin
	And   r.id_reg = @dcIdRegBase
	And   i.id_sin = r.id_sin
	And   i.id_i   = r.id_i

	If 	@sIdFour is null Set @sIdFour = Space ( 3 ) 

	Set @asChaine = Left ( @sIdFour + Space (3 ) , 3 )
End 

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S013_LSTREG_GAN_RGPD
-- Auteur               :       FPI	
-- Date                 :       11/01/2013
-- Libellé              :        
-- Commentaires         :       Liste détaillée des réglements
--								JFF 11/02/2020 [VDOC29033] Reprise PS_S013_LSTREG_GAN_V01 modifiée
--
-- Références           :       Variante de PS_S13_LSTREG pour GAN (VDoc7247) + VDoc10010
--
--				EURO
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
--				
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF  07/08/2020  [VDOC29539] 8200, 8201, 16100, 16101, 16300, 16301, 55100
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S013_LSTREG_GAN_RGPD' AND type = 'P' )
        DROP procedure sysadm.PS_S013_LSTREG_GAN_RGPD
GO


CREATE procedure sysadm.PS_S013_LSTREG_GAN_RGPD
	@dtDteDeb       DateTime        ,
    @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      
	
AS

SET NOCOUNT ON

Select distinct 
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'LIB_POLICE'	= police.lib_police,
 'ID_SIN'	= sinistre.id_sin,
 'ID_ADH'	= ( convert ( varchar (6), sinistre.id_prod ) + '-' +
   		  Right ( '00000' + convert ( varchar (5), sinistre.id_ets ), 5 ) + '-' +
   		  Right ( Replicate ( '0', 19 ) + sinistre.id_adh, 19 ) + '-' +
  		  convert ( varchar (1), sinistre.id_sdos ) ),
 'DTE_ADH'	= sinistre.dte_adh,
 'DTE_FIN_GTI'  = sinistre.dte_fin_gti,
 'GA' 		= code_Gs.lib_code,
 'NS' 		= code_Ns.lib_code,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'MT_PREJ_GTI'  = gar_sin.mt_tot_prej,
 'VAL_ACHAT'    = ( Select IsNull (max ( d.mt_val_achat),0 )
  		    From   detail d
  		    Where  d.id_sin = sinistre.id_sin
 		    And    d.id_gti = gar_sin.id_gti ),
 'VAL_PUBLIQUE' = ( Select IsNull (max ( d.mt_val_publique),0 )
 		    From   detail d
 		    Where  d.id_sin = sinistre.id_sin
 		    And    d.id_gti = gar_sin.id_gti ),		    
 'DTE_REG'	= reg_gti.maj_le,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'LIB_PROD'	= produit.lib_long,
 'ID_REG'	= reg_gti.id_reg,
 'TYP_REGL'	= sysadm.FN_CODE_CAR(reglement.cod_mode_reg, '-MR'), -- [DCMP080675]
 'ETAT_MACHINE_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_dec_mac,'-ET'),
 'ETAT_OPER_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_dec_ope,'-ET'),
 'ETAT_FINAL_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_etat,'-ET'),
 'FORCAGE'=Case When gar_sin.cod_dec_mac=200 and gar_sin.cod_etat=600 Then 'Dossier forçé par le responsable' Else '' End
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne,
 sysadm.inter 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_gti	=	reg_gti.id_gti	 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
  ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
-- ( sinistre.id_prod	in ( 551, 16100, 16101, 55100 )			)	and
-- [DCMP080611] remplacé par :
 ( produit.id_prod	=	sinistre.id_prod		)	and
  produit.id_prod not in (551,5707,5709,5710,5711,5712,5720,5721,5722,5723,
5724,5725,5726,5727,5728,5729,5730,5731,5732,5733,6900,
8300,11001,11101,11300,11400,13700,14000,14300,14500,14600,15200,15600,
15800,15900,16200,16500,17800,24600,38300,57600  ) and -- [VDoc9436] Ajout du produit 72200
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) )  and
-- :[BUG20080728].COD_MODE_REG  JFF
 ( inter.id_sin 	= 	sinistre.id_sin		)	and
 ( inter.id_i 		= 	reglement.id_i		)	and 
 compagnie.id_cie in (2,12,66,67) 

UNION ALL

-- Select 2 COD_ADH = 3 (par carte)
Select distinct
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'LIB_POLICE'	= police.lib_police,
 'ID_SIN'	= sinistre.id_sin,
 'ID_ADH'	= ( convert ( varchar (6), sinistre.id_prod ) + '-' +
    		  Right ( '00000' + convert ( varchar (5), sinistre.id_ets ), 5 ) + '-' +
    		  Right ( Replicate ( '0', 19 ) + sinistre.id_adh, 19 ) + '-' +
   		  convert ( varchar (1), sinistre.id_sdos ) ),
 'DTE_ADH'	= sinistre.dte_adh, 
 'DTE_FIN_GTI'  = sinistre.dte_fin_gti,
 'GA' 		= code_Nf.lib_code,
 'NS' 		= code_Ns.lib_code,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'MT_PREJ_GTI'  = 0,
 'VAL_ACHAT'    = 0,
 'VAL_PUBLIQUE' = 0,
 'DTE_REG'	= reg_gti.maj_le,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'LIB_PROD'	= produit.lib_long,
 'ID_REG'	= reg_gti.id_reg,
 'TYP_REGL'	= sysadm.FN_CODE_CAR(reglement.cod_mode_reg, '-MR'), -- [DCMP080675]
 'ETAT_MACHINE_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_dec_mac,'-ET'),
 'ETAT_OPER_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_dec_ope,'-ET'),
 'ETAT_FINAL_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_etat,'-ET'),
 'FORCAGE'=Case When gar_sin.cod_dec_mac=200 and gar_sin.cod_etat=600 Then 'Dossier forçé par le responsable' Else '' End
 
From
 sysadm.reglement ,
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.inter ,
 sysadm.gar_sin
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( reglement.id_sin     =       reg_gti.id_sin		)	and
 ( reglement.id_reg     =       reg_gti.id_reg		)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
  produit.id_prod not in (551,5707,5709,5710,5711,5712,5720,5721,5722,5723,
5724,5725,5726,5727,5728,5729,5730,5731,5732,5733,6900,
8300,11001,11101,11300,11400,13700,14000,14300,14500,14600,15200,15600,
15800,15900,16200,16500,17800,24600,38300,57600) and -- [VDoc9436] Ajout du produit 72200
( produit.id_dept	=	departement.id_dept	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
-- ( sinistre.id_prod	in ( 551, 16100, 16101, 55100 )			)	and
-- [DCMP080611] remplacé par :
 ( produit.id_prod	=	sinistre.id_prod		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) )  and
-- :[BUG20080728].COD_MODE_REG  JFF
 ( inter.id_sin 	= 	sinistre.id_sin		)	and
 ( inter.id_i 		= 	reglement.id_i		)	and 
 compagnie.id_cie in (2,12,66,67) 				and
 ( gar_sin.id_sin = sinistre.id_sin 	)	and
 ( garantie.id_gti	=	gar_sin.id_gti)


UNION ALL

-- Select 3 COD_ADH = 3 (par carte)
Select distinct
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'LIB_POLICE'	= police.lib_police,
 'ID_SIN'	= sinistre.id_sin,
 'ID_ADH'	= ( convert ( varchar (6), sinistre.id_prod ) + '-' +
    		  Right ( '00000' + convert ( varchar (5), sinistre.id_ets ), 5 ) + '-' +
    		  Right ( Replicate ( '0', 19 ) + sinistre.id_adh, 19 ) + '-' +
   		  convert ( varchar (1), sinistre.id_sdos ) ),
 'DTE_ADH'	= sinistre.dte_adh,  		  
 'DTE_FIN_GTI'  = sinistre.dte_fin_gti,
 'GA' 		= 'REGULARISATION',
 'NS' 		= code_Ns.lib_code,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'MT_PREJ_GTI'  = 0,
 'VAL_ACHAT'    = 0,
 'VAL_PUBLIQUE' = 0,
 'DTE_REG'	= reglement.dte_reg,
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'LIB_PROD'	= produit.lib_long, 		    
 'ID_REG'	= reglement.id_reg,
 'TYP_REGL'	= sysadm.FN_CODE_CAR(reglement.cod_mode_reg, '-MR'), -- [DCMP080675]
 'ETAT_MACHINE_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_dec_mac,'-ET'),
 'ETAT_OPER_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_dec_ope,'-ET'),
 'ETAT_FINAL_GTI' = sysadm.FN_CODE_NUM(gar_sin.cod_etat,'-ET'),
 'FORCAGE'=Case When gar_sin.cod_dec_mac=200 and gar_sin.cod_etat=600 Then 'Dossier forçé par le responsable' Else '' End
 
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.code code_Ns,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
 sysadm.inter, 
 sysadm.gar_sin
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
-- ( sinistre.id_prod	in ( 551, 16100, 16101, 55100 )			)	and
-- [DCMP080611] remplacé par :
 ( produit.id_prod	=	sinistre.id_prod		)	and
  produit.id_prod not in (551,5707,5709,5710,5711,5712,5720,5721,5722,5723,
5724,5725,5726,5727,5728,5729,5730,5731,5732,5733,6900,
8300,11001,11101,11300,11400,13700,14000,14300,14500,14600,15200,15600,
15800,15900,16200,16500,17800,24600,38300,57600 ) --[VDoc9436] Ajout du produit 72200
 and( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) )  and
-- :[BUG20080728].COD_MODE_REG  JFF
 ( inter.id_sin 	= 	sinistre.id_sin		)	and
 ( inter.id_i 		= 	reglement.id_i		)	and 
 compagnie.id_cie in (2,12,66,67) 				and
 ( gar_sin.id_sin = sinistre.id_sin 	)	and
 ( garantie.id_gti	=	gar_sin.id_gti)

go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S011_LSTREG_RGPD
-- Auteur               :       JFF ( Reprise et modification de la requête initiale de PS_S011_LSTREG_V03 )
-- Date                 :       26/11/2013 (PS absente des CP, je la créé !)
-- Libellé              :        
-- Commentaires         :       
-- Références           :       [VDOC29043] idem PS_S011_LSTREG_V03 avec supp du nom&prenom
--
--				
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
-------------------------------------------------------------------
-- [VDOC129010] JFF 26/11/2013 - Ajout zone Type Evènement
-- [VDOC14341] JFF 02/05/2014 - On modifie le lib de la gti si RM Franchise.
-- [VDOC13132] - FPI - 21/05/2014 ajout de la date d'adhésion
-- JFF      06/10/2014   [PM266]
--	FPI		15/01/2015		[VDoc15579] - V03 - ajout colonne ID_ADH
-- JFF   09/12/2015  [VDOC19386] - Je gère le cas CDS/EDI en Rempl par BA.
-- JFF   09/02/2018  [VDOC25665] - Ajout frais d'envoi
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S011_LSTREG_RGPD' AND type = 'P' )
        DROP procedure sysadm.PS_S011_LSTREG_RGPD
GO

CREATE procedure sysadm.PS_S011_LSTREG_RGPD
	@dtDteDeb       DateTime        ,
    @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      ,
	@dcIdProd	Decimal(7)	WITH RECOMPILE

AS

/* Variante de PS_S01_LSTREG, mais on ne ramène
   pas le détail 
*/

SET NOCOUNT ON

Declare	@sCodAdh Char(1)


Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramSne dans un premier temps le d'tail du rSglement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les r'guls effectu'es
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ), -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
		sinistre.id_adh as 'ID_ADH', -- VDOC15579
   IsNull ( 
	   ( Select sum ( fr.mt_frais ) 
		 From  sysadm.frais fr
		 Where fr.id_sin = sinistre.id_sin
	   ),0 ) 'FRAIS' -- VDOC25665

From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_sin	=	sinistre.id_sin 	)	and
 ( gar_sin.id_gti	=	reg_gti.id_gti	 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
		sinistre.id_adh as 'ID_ADH', -- VDOC15579
   IsNull ( 
	   ( Select sum ( fr.mt_frais ) 
		 From  sysadm.frais fr
		 Where fr.id_sin = sinistre.id_sin
	   ),0 ) 'FRAIS' -- VDOC25665

From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 

Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= Case reglement.lib_reg 
				When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
				Else 'REGULARISATION'
			  End,
  'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
		sinistre.id_adh as 'ID_ADH', -- VDOC15579
   IsNull ( 
	   ( Select sum ( fr.mt_frais ) 
		 From  sysadm.frais fr
		 Where fr.id_sin = sinistre.id_sin
	   ),0 ) 'FRAIS' -- VDOC25665 
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	sinistre.id_ets		)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


END

Else				-- Adhesions SPB ou autres hors carte

BEGIN

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Gs.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= gar_sin.alt_plaf,
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
		sinistre.id_adh as 'ID_ADH', -- VDOC15579
    IsNull ( 
	   ( Select sum ( fr.mt_frais ) 
		 From  sysadm.frais fr
		 Where fr.id_sin = sinistre.id_sin
	   ),0 ) 'FRAIS' -- VDOC25665
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.garantie,
 sysadm.gar_sin,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Gs,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.reglement,
 sysadm.personne
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( reg_gti.id_sin	=	gar_sin.id_sin		)	and
 ( reg_gti.id_gti	=	gar_sin.id_gti		)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Gs.id_typ_code	=	'-GS'			)	and
 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	reg_gti.id_gti		)	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
 ( reglement.id_reg	=	reg_gti.id_reg		)	and
 ( reglement.cod_mot_reg = 'RN'				)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

UNION ALL
Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reg_gti.maj_le,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reg_gti.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= reg_gti.id_gti,
 'ID_RGPT'	= reg_gti.id_rgpt,
 'GA' 		= code_Nf.lib_code,
 'MT_REG_GTI'	= reg_gti.mt_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reg_gti.id_sin
		And   r.id_reg = sysadm.reg_gti.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
		sinistre.id_adh as 'ID_ADH', -- VDOC15579
   IsNull ( 
	   ( Select sum ( fr.mt_frais ) 
		 From  sysadm.frais fr
		 Where fr.id_sin = sinistre.id_sin
	   ),0 ) 'FRAIS' -- VDOC25665
From
 sysadm.reg_gti   ,
 sysadm.sinistre  ,
 sysadm.frais     ,
 sysadm.garantie,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.code code_Nf,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne,
-- [BUG20080728].COD_MODE_REG  JFF
 sysadm.reglement
-- [BUG20080728].COD_MODE_REG  JFF 
Where 
 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
 ( reg_gti.id_sin	=	frais.id_sin		)	and
 ( reg_gti.id_reg	=	frais.id_reg		)	and
 ( reg_gti.id_gti	=	-1			)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( code_Nf.id_typ_code	=	'+NF'			)	and
 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
					   From   sysadm.reg_gti a_reg_gti
					   Where  a_reg_gti.id_sin = reg_gti.id_sin
					   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 			 ( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = sinistre.id_sin )))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.id_sin     =       reg_gti.id_sin          )       and
 ( reglement.id_reg     =       reg_gti.id_reg          )       and
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 

UNION ALL

Select
 @dcPeriodeDeb,
 @dcPeriodeFin,
 'DTE_REG'	= reglement.dte_reg,
 'ID_SIN'	= sinistre.id_sin,
 'ID_REG'	= reglement.id_reg,
 'LIB_PROD'	= produit.lib_long,
 'LIB_DEPT'	= departement.lib_dept,
 'DTE_SURV'	= sinistre.dte_surv,
 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
 'DTE_DECL'	= sinistre.dte_decl,
 'ID_ETS'	= groupe.id_grp,
 'NS' 		= code_Ns.lib_code,
 'ID_GTI'	= -2,
 'ID_RGPT'	= -2,
 'GA' 		= Case reglement.lib_reg 
				When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
				Else 'REGULARISATION'
			  End,
 'MT_REG_GTI'	= reglement.mt_tot_reg,
 'ALT_PLAF'	= 'N',
 'LIB_GRP'	= groupe.lib_grp,
 'LIB_POLICE'	= police.lib_police,
 'LIB_CIE'	= compagnie.lib_cie,
 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
 'TYPE_EVENEMENT' =  
  IsNUll ( 
	  ( Select Top 1
			   Case 
					When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
					When id_typ_art = 'PRS' Then 'REPARATION'
					When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
					When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
					When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
					When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
					When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
					Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
			   End 
	  
		From sysadm.reglement r,
			 sysadm.detail d,
			 sysadm.commande c
		Where r.id_sin = sysadm.reglement.id_sin
		And   r.id_reg = sysadm.reglement.id_reg 
		and   r.cod_mode_reg = 'FM'
		And   d.id_sin = r.id_sin
		and   d.id_reg = r.id_reg
		and   c.id_sin = d.id_sin
		and   c.id_gti = d.id_gti
		and   c.id_detail = d.id_detail
		And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
		 ),
		'REMBOURSEMENT' ) , -- VDOC12901
		convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
		sinistre.id_adh as 'ID_ADH', -- VDOC15579
    IsNull ( 
	   ( Select sum ( fr.mt_frais ) 
		 From  sysadm.frais fr
		 Where fr.id_sin = sinistre.id_sin
	   ),0 ) 'FRAIS' -- VDOC25665
From
 sysadm.reglement ,
 sysadm.sinistre  ,
 sysadm.garantie  ,
 sysadm.etablissement,
 sysadm.code code_Ns,
 sysadm.groupe,
 sysadm.produit,
 sysadm.departement,
 sysadm.police,
 sysadm.compagnie,
 sysadm.personne
Where 
 ( reglement.id_sin	=	sinistre.id_sin 	)	and
 ( sinistre.id_prod	=	produit.id_prod		)	and
 ( produit.id_dept	=	departement.id_dept	)	and
 ( groupe.id_grp	=	etablissement.id_grp	)	and
 ( etablissement.id_prod=	sinistre.id_prod	)	and
 ( etablissement.id_ets	=	sinistre.id_ets		)	and
 ( etablissement.id_rev	=	-1			)	and
 ( code_Ns.id_typ_code	=	'+NS'			)	and
 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
 ( garantie.id_prod	=	sinistre.id_prod	)	and
 ( garantie.id_rev	=	sinistre.id_rev		)	and
 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
				  From   sysadm.gar_sin
				  Where  gar_sin.id_sin = sinistre.id_sin ))	and
 ( garantie.id_police	=	police.id_police	)	and
 ( compagnie.id_cie	=	police.id_cie		)	and
 ( sinistre.id_prod	=	@dcIdProd		)	and
 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
 ( reglement.mt_tot_reg <> 0				)	and
 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
-- [BUG20080728].COD_MODE_REG  JFF
 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From   sysadm.exclu_ass ex
			Where  ex.id_cie = police.id_cie
			)
	  ) 


END

Go

grant execute on sysadm.PS_S011_LSTREG_V03 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RN_AVEC_COST_CENTER
-- Auteur               :       JFF 
-- Date                 :       15/11/2013 (PS absente des CP, je la créé !)
-- Libellé              :        
-- Commentaires         :       
-- Références           :       [VDOC29043] idem PS_S011_LSTREG_V03 avec supp du nom&prenom
--
--				
--	
-- Arguments            :       
-- Retourne             :       Rien
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RN_AVEC_COST_CENTER' AND type = 'P' )
        DROP procedure sysadm.PS_S_RN_AVEC_COST_CENTER
GO


CREATE procedure sysadm.PS_S_RN_AVEC_COST_CENTER
  @adcIdSin		Decimal ( 10 ),
  @adcIdReg		Decimal ( 2 ),
  @asCodMotReg  VarChar ( 5 ),
  @asCodModeReg  VarChar ( 5 ),
  @asChaine		VarChar ( 50 ) OUTPUT
  
AS

If Exists ( 
	Select Top 1 1 
	From sysadm.sinistre s,
		 sysadm.det_pro dp
	Where s.id_sin = @adcIdSin
	And   dp.id_prod = s.id_prod 
	And   dp.id_code_dp = 335 )
 Begin
	Set @asChaine = Left ( @asChaine , 5 ) + '0000' + Right ( @asChaine, Datalength ( @asChaine ) - 9 )
 End	

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S011_LSTREG_57_ASSUREUR_CNP_CAUTION
-- Auteur               :       JFF ( Reprise et modification de la requête initiale de DBI PS_S01_LSTREG )
-- Date                 :       26/11/2013 (PS absente des CP, je la créé !)
-- Libellé              :       [RS-1097][RS1097] 
-- Commentaires         :       
-- Références           :       
--
--				
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
-------------------------------------------------------------------
-- [VDOC129010] JFF 26/11/2013 - Ajout zone Type Evènement
-- [VDOC14341] JFF 02/05/2014 - On modifie le lib de la gti si RM Franchise.
-- [VDOC13132] - FPI - 21/05/2014 ajout de la date d'adhésion
-- JFF      06/10/2014   [PM266]
--	FPI		15/01/2015		[VDoc15579] - V03 - ajout colonne ID_ADH
-- JFF   09/12/2015  [VDOC19386] - Je gère le cas CDS/EDI en Rempl par BA.
-- JFF   09/02/2018  [VDOC25665] - Ajout frais d'envoi
-- JFF   04/10/2021  [RS-1097][RS1097] 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S011_LSTREG_57_ASSUREUR_CNP_CAUTION' AND type = 'P' )
        DROP procedure sysadm.PS_S011_LSTREG_57_ASSUREUR_CNP_CAUTION
GO

CREATE procedure sysadm.PS_S011_LSTREG_57_ASSUREUR_CNP_CAUTION
	@dtDteDeb       DateTime        ,
    @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      ,
	@dcIdProd	Decimal(7)	WITH RECOMPILE

AS

/* copier de PS_S011_LSTREG_V03 pour CNP CAUTION
*/

SET NOCOUNT ON

Declare	@sCodAdh Char(1)


Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramSne dans un premier temps le d'tail du rSglement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les r'guls effectu'es
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN

With Twrk ( 
			 idperiodeMin,
			 idPeriodeMax,
			 dte_reg,
			 id_sin,
			 id_reg,
			 lib_prod,
			 lib_dept,
			 dte_surv,
			 exercice,
			 mois_surv,
			 dte_decl,
			 id_grp,
			 Nslib_code,
			 id_gti,
			 id_rgpt,
			 Gslib_code,
			 mt_reg_gti,
			 lib_evt,
			 alt_plaf,
			 lib_grp,
			 lib_police,
			 lib_cie,
			 nom,
			 prenom,
			 id_orian_boutique,
			 typ_app_sin,
			 typ_evenement,
			 dte_adh,
			 id_adh,
			 frais
		  )
As 
		 (
			Select
			 @dcPeriodeDeb,
			 @dcPeriodeFin,
			 'DTE_REG'	= reg_gti.maj_le,
			 'ID_SIN'	= sinistre.id_sin,
			 'ID_REG'	= reg_gti.id_reg,
			 'LIB_PROD'	= produit.lib_long,
			 'LIB_DEPT'	= departement.lib_dept,
			 'DTE_SURV'	= sinistre.dte_surv,
			 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
			 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
			 'DTE_DECL'	= sinistre.dte_decl,
			 'ID_ETS'	= groupe.id_grp,
			 'NS' 		= code_Ns.lib_code,
			 'ID_GTI'	= reg_gti.id_gti,
			 'ID_RGPT'	= reg_gti.id_rgpt,
			 'GA' 		= code_Gs.lib_code,
			 'MT_REG_GTI'	= reg_gti.mt_reg,
			 'LIB_EVT' = 	( 
			   Select stuff ( 
						( SELECT ', ' + CAST(rtrim ( sysadm.FN_CODE_NUM ( d.id_evt, '+EV') ) AS VARCHAR(250)) 
						  FROM sysadm.detail d
						  Where d.id_sin = reglement.id_sin
						  And   d.id_reg = reglement.id_reg
						  order by d.id_evt
						  For XML PATH ('')
						   )
					, 1, 2, '' )) ,
			 'ALT_PLAF'	= gar_sin.alt_plaf,
			 'LIB_GRP'	= groupe.lib_grp,
			 'LIB_POLICE'	= police.lib_police,
			 'LIB_CIE'	= compagnie.lib_cie,
			 'NOM'		= personne.nom,
			 'PRENOM'	= personne.prenom,
			 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
			 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
			 'TYPE_EVENEMENT' =  
			  IsNUll ( 
				  ( Select Top 1
						   Case 
								When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
								When id_typ_art = 'PRS' Then 'REPARATION'
								When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
								When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
								When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
								When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
								When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
								Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
						   End 
	  
					From sysadm.reglement r,
						 sysadm.detail d,
						 sysadm.commande c
					Where r.id_sin = sysadm.reg_gti.id_sin
					And   r.id_reg = sysadm.reg_gti.id_reg 
					and   r.cod_mode_reg = 'FM'
					And   d.id_sin = r.id_sin
					and   d.id_reg = r.id_reg
					and   c.id_sin = d.id_sin
					and   c.id_gti = d.id_gti
					and   c.id_detail = d.id_detail
					And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
					 ),
					'REMBOURSEMENT' ), -- VDOC12901
					convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
					sinistre.id_adh as 'ID_ADH', -- VDOC15579
			   IsNull ( 
				   ( Select sum ( fr.mt_frais ) 
					 From  sysadm.frais fr
					 Where fr.id_sin = sinistre.id_sin
				   ),0 ) 'FRAIS' -- VDOC25665

			From
			 sysadm.reg_gti   ,
			 sysadm.sinistre  ,
			 sysadm.garantie,
			 sysadm.gar_sin,
			 sysadm.code code_Ns,
			 sysadm.code code_Gs,
			 sysadm.groupe,
			 sysadm.produit,
			 sysadm.departement,
			 sysadm.police,
			 sysadm.compagnie,
			 sysadm.reglement,
			 sysadm.personne
			Where 
			 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
			 ( gar_sin.id_sin	=	sinistre.id_sin 	)	and
			 ( gar_sin.id_gti	=	reg_gti.id_gti	 	)	and
			 ( sinistre.id_prod	=	produit.id_prod		)	and
			 ( produit.id_dept	=	departement.id_dept	)	and
			 ( groupe.id_grp	=	sinistre.id_ets		)	and
			 ( code_Ns.id_typ_code	=	'+NS'			)	and
			 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
			 ( code_Gs.id_typ_code	=	'-GS'			)	and
			 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
			 ( garantie.id_prod	=	sinistre.id_prod	)	and
			 ( garantie.id_rev	=	sinistre.id_rev		)	and
			 ( garantie.id_gti	=	reg_gti.id_gti		)	and
			 ( garantie.id_police	=	police.id_police	)	and
			 ( compagnie.id_cie	=	police.id_cie		)	and
			 ( sinistre.id_prod	=	@dcIdProd		)	and
			 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
			 ( reglement.id_reg	=	reg_gti.id_reg		)	and
			 ( reglement.cod_mot_reg = 'RN'				)	and
			 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
			 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
			-- [BUG20080728].COD_MODE_REG  JFF
			 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
			-- :[BUG20080728].COD_MODE_REG  JFF
			  -- [PM266]
			  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
					Or
					Not Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
				  ) 


			UNION ALL

			Select
			 @dcPeriodeDeb,
			 @dcPeriodeFin,
			 'DTE_REG'	= reg_gti.maj_le,
			 'ID_SIN'	= sinistre.id_sin,
			 'ID_REG'	= reg_gti.id_reg,
			 'LIB_PROD'	= produit.lib_long,
			 'LIB_DEPT'	= departement.lib_dept,
			 'DTE_SURV'	= sinistre.dte_surv,
			 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
			 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
			 'DTE_DECL'	= sinistre.dte_decl,
			 'ID_ETS'	= groupe.id_grp,
			 'NS' 		= code_Ns.lib_code,
			 'ID_GTI'	= reg_gti.id_gti,
			 'ID_RGPT'	= reg_gti.id_rgpt,
			 'GA' 		= code_Nf.lib_code,
			 'MT_REG_GTI'	= reg_gti.mt_reg,
			 'LIB_EVT' = 	( 
			   Select stuff ( 
						( SELECT ', ' + CAST(rtrim ( sysadm.FN_CODE_NUM ( d.id_evt, '+EV') ) AS VARCHAR(250)) 
						  FROM sysadm.detail d
						  Where d.id_sin = reglement.id_sin
						  And   d.id_reg = reglement.id_reg
						  order by d.id_evt
						  For XML PATH ('')
						   )
					, 1, 2, '' )) ,
			 'ALT_PLAF'	= 'N',
			 'LIB_GRP'	= groupe.lib_grp,
			 'LIB_POLICE'	= police.lib_police,
			 'LIB_CIE'	= compagnie.lib_cie,
			 'NOM'		= personne.nom,
			 'PRENOM'	= personne.prenom,
			 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
			 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
			 'TYPE_EVENEMENT' =  
			  IsNUll ( 
				  ( Select Top 1
						   Case 
								When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
								When id_typ_art = 'PRS' Then 'REPARATION'
								When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
								When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
								When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
								When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
								When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
								Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
						   End 
	  
					From sysadm.reglement r,
						 sysadm.detail d,
						 sysadm.commande c
					Where r.id_sin = sysadm.reg_gti.id_sin
					And   r.id_reg = sysadm.reg_gti.id_reg 
					and   r.cod_mode_reg = 'FM'
					And   d.id_sin = r.id_sin
					and   d.id_reg = r.id_reg
					and   c.id_sin = d.id_sin
					and   c.id_gti = d.id_gti
					and   c.id_detail = d.id_detail
					And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
					 ),
					'REMBOURSEMENT' ) , -- VDOC12901
					convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
					sinistre.id_adh as 'ID_ADH', -- VDOC15579
			   IsNull ( 
				   ( Select sum ( fr.mt_frais ) 
					 From  sysadm.frais fr
					 Where fr.id_sin = sinistre.id_sin
				   ),0 ) 'FRAIS' -- VDOC25665

			From
			 sysadm.reg_gti   ,
			 sysadm.sinistre  ,
			 sysadm.frais     ,
			 sysadm.garantie,
			 sysadm.code code_Ns,
			 sysadm.code code_Nf,
			 sysadm.groupe,
			 sysadm.produit,
			 sysadm.departement,
			 sysadm.police,
			 sysadm.compagnie,
			 sysadm.personne,
			-- [BUG20080728].COD_MODE_REG  JFF
			 sysadm.reglement
			-- [BUG20080728].COD_MODE_REG  JFF 

			Where 
			 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
			 ( reg_gti.id_sin	=	frais.id_sin		)	and
			 ( reg_gti.id_reg	=	frais.id_reg		)	and
			 ( reg_gti.id_gti	=	-1			)	and
			 ( sinistre.id_prod	=	produit.id_prod		)	and
			 ( produit.id_dept	=	departement.id_dept	)	and
			 ( groupe.id_grp	=	sinistre.id_ets		)	and
			 ( code_Nf.id_typ_code	=	'+NF'			)	and
			 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
			 ( code_Ns.id_typ_code	=	'+NS'			)	and
			 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
			 ( garantie.id_prod	=	sinistre.id_prod	)	and
			 ( garantie.id_rev	=	sinistre.id_rev		)	and
			 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
								   From   sysadm.reg_gti a_reg_gti
								   Where  a_reg_gti.id_sin = reg_gti.id_sin
								   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 						 ( Select max ( gar_sin.id_gti ) 
								   From   sysadm.gar_sin
								   Where  gar_sin.id_sin = sinistre.id_sin )))	and
			 ( garantie.id_police	=	police.id_police	)	and
			 ( compagnie.id_cie	=	police.id_cie		)	and
			 ( sinistre.id_prod	=	@dcIdProd		)	and
			 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
			 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
			-- [BUG20080728].COD_MODE_REG  JFF
			 ( reglement.id_sin     =       reg_gti.id_sin          )       and
			 ( reglement.id_reg     =       reg_gti.id_reg          )       and
			 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
			-- :[BUG20080728].COD_MODE_REG  JFF
			  -- [PM266]
			  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
					Or
					Not Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
				  ) 


			UNION ALL
			Select
			 @dcPeriodeDeb,
			 @dcPeriodeFin,
			 'DTE_REG'	= reglement.dte_reg,
			 'ID_SIN'	= sinistre.id_sin,
			 'ID_REG'	= reglement.id_reg,
			 'LIB_PROD'	= produit.lib_long,
			 'LIB_DEPT'	= departement.lib_dept,
			 'DTE_SURV'	= sinistre.dte_surv,
			 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
			 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
			 'DTE_DECL'	= sinistre.dte_decl,
			 'ID_ETS'	= groupe.id_grp,
			 'NS' 		= code_Ns.lib_code,
			 'ID_GTI'	= -2,
			 'ID_RGPT'	= -2,
			 'GA' 		= Case reglement.lib_reg 
							When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
							Else 'REGULARISATION'
						  End,
			 'MT_REG_GTI' = reglement.mt_tot_reg,
			 'LIB_EVT' = 	( 
			   Select stuff ( 
						( SELECT ', ' + CAST(rtrim ( sysadm.FN_CODE_NUM ( d.id_evt, '+EV') ) AS VARCHAR(250)) 
						  FROM sysadm.detail d
						  Where d.id_sin = reglement.id_sin
						  And   d.id_reg = reglement.id_reg
						  order by d.id_evt
						  For XML PATH ('')
						   )
					, 1, 2, '' )) ,
			 'ALT_PLAF'	= 'N',
			 'LIB_GRP'	= groupe.lib_grp,
			 'LIB_POLICE'	= police.lib_police,
			 'LIB_CIE'	= compagnie.lib_cie,
			 'NOM'		= personne.nom,
			 'PRENOM'	= personne.prenom,
			 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
			 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
			 'TYPE_EVENEMENT' =  
			  IsNUll ( 
				  ( Select Top 1
						   Case 
								When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
								When id_typ_art = 'PRS' Then 'REPARATION'
								When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
								When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
								When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
								When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
								When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
								Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
						   End 
	  
					From sysadm.reglement r,
						 sysadm.detail d,
						 sysadm.commande c
					Where r.id_sin = sysadm.reglement.id_sin
					And   r.id_reg = sysadm.reglement.id_reg 
					and   r.cod_mode_reg = 'FM'
					And   d.id_sin = r.id_sin
					and   d.id_reg = r.id_reg
					and   c.id_sin = d.id_sin
					and   c.id_gti = d.id_gti
					and   c.id_detail = d.id_detail
					And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
					 ),
					'REMBOURSEMENT' ) , -- VDOC12901
					convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
					sinistre.id_adh as 'ID_ADH', -- VDOC15579
			   IsNull ( 
				   ( Select sum ( fr.mt_frais ) 
					 From  sysadm.frais fr
					 Where fr.id_sin = sinistre.id_sin
				   ),0 ) 'FRAIS' -- VDOC25665 
			From
			 sysadm.reglement ,
			 sysadm.sinistre  ,
			 sysadm.garantie  ,
			 sysadm.code code_Ns,
			 sysadm.groupe,
			 sysadm.produit,
			 sysadm.departement,
			 sysadm.police,
			 sysadm.compagnie,
			 sysadm.personne
			Where 
			 ( reglement.id_sin	=	sinistre.id_sin 	)	and
			 ( sinistre.id_prod	=	produit.id_prod		)	and
			 ( produit.id_dept	=	departement.id_dept	)	and
			 ( groupe.id_grp	=	sinistre.id_ets		)	and
			 ( code_Ns.id_typ_code	=	'+NS'			)	and
			 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
			 ( garantie.id_prod	=	sinistre.id_prod	)	and
			 ( garantie.id_rev	=	sinistre.id_rev		)	and
			 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
							  From   sysadm.gar_sin
							  Where  gar_sin.id_sin = sinistre.id_sin ))	and
			 ( garantie.id_police	=	police.id_police	)	and
			 ( compagnie.id_cie	=	police.id_cie		)	and
			 ( sinistre.id_prod	=	@dcIdProd		)	and
			 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
			 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
			 ( reglement.mt_tot_reg <> 0				)	and
			 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
			-- [BUG20080728].COD_MODE_REG  JFF
			 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
			-- :[BUG20080728].COD_MODE_REG  JFF
			  -- [PM266]
			  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
					Or
					Not Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
				  ) 
		)
Select 
		t.idperiodeMin,
		t.idPeriodeMax,
		t.dte_reg,
		t.id_sin,
		t.id_reg,
		t.lib_prod,
		t.lib_dept,
		t.dte_surv,
		t.exercice,
		t.mois_surv,
		t.dte_decl,
		t.id_grp,
		t.Nslib_code,
		Sum ( t.mt_reg_gti ) mt_reg_tot_gti,
		t.lib_evt,
		t.alt_plaf,
		t.lib_grp,
		t.lib_police,
		t.lib_cie,
		t.nom,
		t.prenom,
		t.id_orian_boutique,
		t.typ_app_sin,
		t.typ_evenement,
		t.dte_adh,
		t.id_adh,
		t.frais

From Twrk t
Group by 
		t.idperiodeMin,
		t.idPeriodeMax,
		t.dte_reg,
		t.id_sin,
		t.id_reg,
		t.lib_prod,
		t.lib_dept,
		t.dte_surv,
		t.exercice,
		t.mois_surv,
		t.dte_decl,
		t.id_grp,
		t.Nslib_code,
		t.lib_evt,
		t.alt_plaf,
		t.lib_grp,
		t.lib_police,
		t.lib_cie,
		t.nom,
		t.prenom,
		t.id_orian_boutique,
		t.typ_app_sin,
		t.typ_evenement,
		t.dte_adh,
		t.id_adh,
		t.frais
END

Else				-- Adhesions SPB ou autres hors carte

BEGIN

With Twrk ( 
			 idperiodeMin,
			 idPeriodeMax,
			 dte_reg,
			 id_sin,
			 id_reg,
			 lib_prod,
			 lib_dept,
			 dte_surv,
			 exercice,
			 mois_surv,
			 dte_decl,
			 id_grp,
			 Nslib_code,
			 id_gti,
			 id_rgpt,
			 Gslib_code,
			 mt_reg,
			 lib_evt,
			 alt_plaf,
			 lib_grp,
			 lib_police,
			 lib_cie,
			 nom,
			 prenom,
			 id_orian_boutique,
			 typ_app_sin,
			 typ_evenement,
			 dte_adh,
			 id_adh,
			 frais
		  )
As 
		 (
			Select
			 @dcPeriodeDeb,
			 @dcPeriodeFin,
			 'DTE_REG'	= reg_gti.maj_le,
			 'ID_SIN'	= sinistre.id_sin,
			 'ID_REG'	= reg_gti.id_reg,
			 'LIB_PROD'	= produit.lib_long,
			 'LIB_DEPT'	= departement.lib_dept,
			 'DTE_SURV'	= sinistre.dte_surv,
			 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
			 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
			 'DTE_DECL'	= sinistre.dte_decl,
			 'ID_ETS'	= groupe.id_grp,
			 'NS' 		= code_Ns.lib_code,
			 'ID_GTI'	= reg_gti.id_gti,
			 'ID_RGPT'	= reg_gti.id_rgpt,
			 'GA' 		= code_Gs.lib_code,
			 'MT_REG_GTI'	= reg_gti.mt_reg,
			 'LIB_EVT' = 	( 
			   Select stuff ( 
						( SELECT ', ' + CAST(rtrim ( sysadm.FN_CODE_NUM ( d.id_evt, '+EV') ) AS VARCHAR(250)) 
						  FROM sysadm.detail d
						  Where d.id_sin = reglement.id_sin
						  And   d.id_reg = reglement.id_reg
						  order by d.id_evt
						  For XML PATH ('')
						   )
					, 1, 2, '' )) ,
			 'ALT_PLAF'	= gar_sin.alt_plaf,
			 'LIB_GRP'	= groupe.lib_grp,
			 'LIB_POLICE'	= police.lib_police,
			 'LIB_CIE'	= compagnie.lib_cie,
			 'NOM'		= personne.nom,
			 'PRENOM'	= personne.prenom,
			 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
			 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
			 'TYPE_EVENEMENT' =  
			  IsNUll ( 
				  ( Select Top 1
						   Case 
								When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
								When id_typ_art = 'PRS' Then 'REPARATION'
								When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
								When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
								When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
								When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
								When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
								Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
						   End 
	  
					From sysadm.reglement r,
						 sysadm.detail d,
						 sysadm.commande c
					Where r.id_sin = sysadm.reg_gti.id_sin
					And   r.id_reg = sysadm.reg_gti.id_reg 
					and   r.cod_mode_reg = 'FM'
					And   d.id_sin = r.id_sin
					and   d.id_reg = r.id_reg
					and   c.id_sin = d.id_sin
					and   c.id_gti = d.id_gti
					and   c.id_detail = d.id_detail
					And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
					 ),
					'REMBOURSEMENT' ) , -- VDOC12901
					convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
					sinistre.id_adh as 'ID_ADH', -- VDOC15579
				IsNull ( 
				   ( Select sum ( fr.mt_frais ) 
					 From  sysadm.frais fr
					 Where fr.id_sin = sinistre.id_sin
				   ),0 ) 'FRAIS' -- VDOC25665
			From
			 sysadm.reg_gti   ,
			 sysadm.sinistre  ,
			 sysadm.garantie,
			 sysadm.gar_sin,
			 sysadm.etablissement,
			 sysadm.code code_Ns,
			 sysadm.code code_Gs,
			 sysadm.groupe,
			 sysadm.produit,
			 sysadm.departement,
			 sysadm.police,
			 sysadm.compagnie,
			 sysadm.reglement,
			 sysadm.personne
			Where 
			 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
			 ( sinistre.id_prod	=	produit.id_prod		)	and
			 ( produit.id_dept	=	departement.id_dept	)	and
			 ( reg_gti.id_sin	=	gar_sin.id_sin		)	and
			 ( reg_gti.id_gti	=	gar_sin.id_gti		)	and
			 ( groupe.id_grp	=	etablissement.id_grp	)	and
			 ( etablissement.id_prod=	sinistre.id_prod	)	and
			 ( etablissement.id_ets	=	sinistre.id_ets		)	and
			 ( etablissement.id_rev	=	-1			)	and
			 ( code_Ns.id_typ_code	=	'+NS'			)	and
			 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
			 ( code_Gs.id_typ_code	=	'-GS'			)	and
			 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
			 ( garantie.id_prod	=	sinistre.id_prod	)	and
			 ( garantie.id_rev	=	sinistre.id_rev		)	and
			 ( garantie.id_gti	=	reg_gti.id_gti		)	and
			 ( garantie.id_police	=	police.id_police	)	and
			 ( compagnie.id_cie	=	police.id_cie		)	and
			 ( sinistre.id_prod	=	@dcIdProd		)	and
			 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
			 ( reglement.id_reg	=	reg_gti.id_reg		)	and
			 ( reglement.cod_mot_reg = 'RN'				)	and
			 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
			 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
			-- [BUG20080728].COD_MODE_REG  JFF
			 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
			-- :[BUG20080728].COD_MODE_REG  JFF
			  -- [PM266]
			  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
					Or
					Not Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
				  ) 

			UNION ALL
			Select
			 @dcPeriodeDeb,
			 @dcPeriodeFin,
			 'DTE_REG'	= reg_gti.maj_le,
			 'ID_SIN'	= sinistre.id_sin,
			 'ID_REG'	= reg_gti.id_reg,
			 'LIB_PROD'	= produit.lib_long,
			 'LIB_DEPT'	= departement.lib_dept,
			 'DTE_SURV'	= sinistre.dte_surv,
			 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
			 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
			 'DTE_DECL'	= sinistre.dte_decl,
			 'ID_ETS'	= groupe.id_grp,
			 'NS' 		= code_Ns.lib_code,
			 'ID_GTI'	= reg_gti.id_gti,
			 'ID_RGPT'	= reg_gti.id_rgpt,
			 'GA' 		= code_Nf.lib_code,
			 'MT_REG_GTI'	= reg_gti.mt_reg,
			 'LIB_EVT' = 	( 
			   Select stuff ( 
						( SELECT ', ' + CAST(rtrim ( sysadm.FN_CODE_NUM ( d.id_evt, '+EV') ) AS VARCHAR(250)) 
						  FROM sysadm.detail d
						  Where d.id_sin = reglement.id_sin
						  And   d.id_reg = reglement.id_reg
						  order by d.id_evt
						  For XML PATH ('')
						   )
					, 1, 2, '' )) ,
			 'ALT_PLAF'	= 'N',
			 'LIB_GRP'	= groupe.lib_grp,
			 'LIB_POLICE'	= police.lib_police,
			 'LIB_CIE'	= compagnie.lib_cie,
			 'NOM'		= personne.nom,
			 'PRENOM'	= personne.prenom,
			 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
			 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
			 'TYPE_EVENEMENT' =  
			  IsNUll ( 
				  ( Select Top 1
						   Case 
								When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
								When id_typ_art = 'PRS' Then 'REPARATION'
								When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
								When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
								When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
								When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
								When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
								Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
						   End 
	  
					From sysadm.reglement r,
						 sysadm.detail d,
						 sysadm.commande c
					Where r.id_sin = sysadm.reg_gti.id_sin
					And   r.id_reg = sysadm.reg_gti.id_reg 
					and   r.cod_mode_reg = 'FM'
					And   d.id_sin = r.id_sin
					and   d.id_reg = r.id_reg
					and   c.id_sin = d.id_sin
					and   c.id_gti = d.id_gti
					and   c.id_detail = d.id_detail
					And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
					 ),
					'REMBOURSEMENT' ) , -- VDOC12901
					convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
					sinistre.id_adh as 'ID_ADH', -- VDOC15579
			   IsNull ( 
				   ( Select sum ( fr.mt_frais ) 
					 From  sysadm.frais fr
					 Where fr.id_sin = sinistre.id_sin
				   ),0 ) 'FRAIS' -- VDOC25665
			From
			 sysadm.reg_gti   ,
			 sysadm.sinistre  ,
			 sysadm.frais     ,
			 sysadm.garantie,
			 sysadm.etablissement,
			 sysadm.code code_Ns,
			 sysadm.code code_Nf,
			 sysadm.groupe,
			 sysadm.produit,
			 sysadm.departement,
			 sysadm.police,
			 sysadm.compagnie,
			 sysadm.personne,
			-- [BUG20080728].COD_MODE_REG  JFF
			 sysadm.reglement
			-- [BUG20080728].COD_MODE_REG  JFF 
			Where 
			 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
			 ( reg_gti.id_sin	=	frais.id_sin		)	and
			 ( reg_gti.id_reg	=	frais.id_reg		)	and
			 ( reg_gti.id_gti	=	-1			)	and
			 ( sinistre.id_prod	=	produit.id_prod		)	and
			 ( produit.id_dept	=	departement.id_dept	)	and
			 ( groupe.id_grp	=	etablissement.id_grp	)	and
			 ( etablissement.id_prod=	sinistre.id_prod	)	and
			 ( etablissement.id_ets	=	sinistre.id_ets		)	and
			 ( etablissement.id_rev	=	-1			)	and
			 ( code_Ns.id_typ_code	=	'+NS'			)	and
			 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
			 ( code_Nf.id_typ_code	=	'+NF'			)	and
			 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
			 ( garantie.id_prod	=	sinistre.id_prod	)	and
			 ( garantie.id_rev	=	sinistre.id_rev		)	and
			 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
								   From   sysadm.reg_gti a_reg_gti
								   Where  a_reg_gti.id_sin = reg_gti.id_sin
								   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 						 ( Select max ( gar_sin.id_gti ) 
								   From   sysadm.gar_sin
								   Where  gar_sin.id_sin = sinistre.id_sin )))	and
			 ( garantie.id_police	=	police.id_police	)	and
			 ( compagnie.id_cie	=	police.id_cie		)	and
			 ( sinistre.id_prod	=	@dcIdProd		)	and
			 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
			 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
			-- [BUG20080728].COD_MODE_REG  JFF
			 ( reglement.id_sin     =       reg_gti.id_sin          )       and
			 ( reglement.id_reg     =       reg_gti.id_reg          )       and
			 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
			-- :[BUG20080728].COD_MODE_REG  JFF
			  -- [PM266]
			  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
					Or
					Not Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
				  ) 

			UNION ALL

			Select
			 @dcPeriodeDeb,
			 @dcPeriodeFin,
			 'DTE_REG'	= reglement.dte_reg,
			 'ID_SIN'	= sinistre.id_sin,
			 'ID_REG'	= reglement.id_reg,
			 'LIB_PROD'	= produit.lib_long,
			 'LIB_DEPT'	= departement.lib_dept,
			 'DTE_SURV'	= sinistre.dte_surv,
			 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
			 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
			 'DTE_DECL'	= sinistre.dte_decl,
			 'ID_ETS'	= groupe.id_grp,
			 'NS' 		= code_Ns.lib_code,
			 'ID_GTI'	= -2,
			 'ID_RGPT'	= -2,
			 'GA' 		= Case reglement.lib_reg 
							When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
							Else 'REGULARISATION'
						  End,
			 'MT_REG_GTI'	= reglement.mt_tot_reg,
			 'LIB_EVT' = 	( 
			   Select stuff ( 
						( SELECT ', ' + CAST(rtrim ( sysadm.FN_CODE_NUM ( d.id_evt, '+EV') ) AS VARCHAR(250)) 
						  FROM sysadm.detail d
						  Where d.id_sin = reglement.id_sin
						  And   d.id_reg = reglement.id_reg
						  order by d.id_evt
						  For XML PATH ('')
						   )
					, 1, 2, '' )) ,
			 'ALT_PLAF'	= 'N',
			 'LIB_GRP'	= groupe.lib_grp,
			 'LIB_POLICE'	= police.lib_police,
			 'LIB_CIE'	= compagnie.lib_cie,
			 'NOM'		= personne.nom,
			 'PRENOM'	= personne.prenom,
			 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
			 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
			 'TYPE_EVENEMENT' =  
			  IsNUll ( 
				  ( Select Top 1
						   Case 
								When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
								When id_typ_art = 'PRS' Then 'REPARATION'
								When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
								When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
								When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
								When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
								When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
								Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
						   End 
	  
					From sysadm.reglement r,
						 sysadm.detail d,
						 sysadm.commande c
					Where r.id_sin = sysadm.reglement.id_sin
					And   r.id_reg = sysadm.reglement.id_reg 
					and   r.cod_mode_reg = 'FM'
					And   d.id_sin = r.id_sin
					and   d.id_reg = r.id_reg
					and   c.id_sin = d.id_sin
					and   c.id_gti = d.id_gti
					and   c.id_detail = d.id_detail
					And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
					 ),
					'REMBOURSEMENT' ) , -- VDOC12901
					convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
					sinistre.id_adh as 'ID_ADH', -- VDOC15579
				IsNull ( 
				   ( Select sum ( fr.mt_frais ) 
					 From  sysadm.frais fr
					 Where fr.id_sin = sinistre.id_sin
				   ),0 ) 'FRAIS' -- VDOC25665
			From
			 sysadm.reglement ,
			 sysadm.sinistre  ,
			 sysadm.garantie  ,
			 sysadm.etablissement,
			 sysadm.code code_Ns,
			 sysadm.groupe,
			 sysadm.produit,
			 sysadm.departement,
			 sysadm.police,
			 sysadm.compagnie,
			 sysadm.personne
			Where 
			 ( reglement.id_sin	=	sinistre.id_sin 	)	and
			 ( sinistre.id_prod	=	produit.id_prod		)	and
			 ( produit.id_dept	=	departement.id_dept	)	and
			 ( groupe.id_grp	=	etablissement.id_grp	)	and
			 ( etablissement.id_prod=	sinistre.id_prod	)	and
			 ( etablissement.id_ets	=	sinistre.id_ets		)	and
			 ( etablissement.id_rev	=	-1			)	and
			 ( code_Ns.id_typ_code	=	'+NS'			)	and
			 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
			 ( garantie.id_prod	=	sinistre.id_prod	)	and
			 ( garantie.id_rev	=	sinistre.id_rev		)	and
			 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
							  From   sysadm.gar_sin
							  Where  gar_sin.id_sin = sinistre.id_sin ))	and
			 ( garantie.id_police	=	police.id_police	)	and
			 ( compagnie.id_cie	=	police.id_cie		)	and
			 ( sinistre.id_prod	=	@dcIdProd		)	and
			 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
			 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
			 ( reglement.mt_tot_reg <> 0				)	and
			 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
			-- [BUG20080728].COD_MODE_REG  JFF
			 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
			-- :[BUG20080728].COD_MODE_REG  JFF
			  -- [PM266]
			  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
					Or
					Not Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
				  ) 

		)
Select 
		t.idperiodeMin,
		t.idPeriodeMax,
		t.dte_reg,
		t.id_sin,
		t.id_reg,
		t.lib_prod,
		t.lib_dept,
		t.dte_surv,
		t.exercice,
		t.mois_surv,
		t.dte_decl,
		t.id_grp,
		t.Nslib_code,
		Sum ( t.mt_reg ) mt_reg_tot_gti,
		t.lib_evt,
		t.alt_plaf,
		t.lib_grp,
		t.lib_police,
		t.lib_cie,
		t.nom,
		t.prenom,
		t.id_orian_boutique,
		t.typ_app_sin,
		t.typ_evenement,
		t.dte_adh,
		t.id_adh,
		t.frais

From Twrk t
Group by 
		t.idperiodeMin,
		t.idPeriodeMax,
		t.dte_reg,
		t.id_sin,
		t.id_reg,
		t.lib_prod,
		t.lib_dept,
		t.dte_surv,
		t.exercice,
		t.mois_surv,
		t.dte_decl,
		t.id_grp,
		t.Nslib_code,
		t.lib_evt,
		t.alt_plaf,
		t.lib_grp,
		t.lib_police,
		t.lib_cie,
		t.nom,
		t.prenom,
		t.id_orian_boutique,
		t.typ_app_sin,
		t.typ_evenement,
		t.dte_adh,
		t.id_adh,
		t.frais

END

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S011_LSTREG_57_ASSUREUR_CNP_CAUTION_RGPD
-- Auteur               :       JFF ( Reprise et modification de la requête initiale de DBI PS_S01_LSTREG )
-- Date                 :       26/11/2013 (PS absente des CP, je la créé !)
-- Libellé              :       [RS-1097][RS1097] 
-- Commentaires         :       
-- Références           :       
--
--				
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              @dcPeriodeDeb   Decimal(7)              (Val)
--                              @dcPeriodeFin   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
-------------------------------------------------------------------
-- [VDOC129010] JFF 26/11/2013 - Ajout zone Type Evènement
-- [VDOC14341] JFF 02/05/2014 - On modifie le lib de la gti si RM Franchise.
-- [VDOC13132] - FPI - 21/05/2014 ajout de la date d'adhésion
-- JFF      06/10/2014   [PM266]
--	FPI		15/01/2015		[VDoc15579] - V03 - ajout colonne ID_ADH
-- JFF   09/12/2015  [VDOC19386] - Je gère le cas CDS/EDI en Rempl par BA.
-- JFF   09/02/2018  [VDOC25665] - Ajout frais d'envoi
-- JFF   04/10/2021  [RS-1097][RS1097] 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S011_LSTREG_57_ASSUREUR_CNP_CAUTION_RGPD' AND type = 'P' )
        DROP procedure sysadm.PS_S011_LSTREG_57_ASSUREUR_CNP_CAUTION_RGPD
GO

CREATE procedure sysadm.PS_S011_LSTREG_57_ASSUREUR_CNP_CAUTION_RGPD
	@dtDteDeb       DateTime        ,
    @dtDteFin       DateTime	,
	@dcPeriodeDeb   Decimal(7)      ,
	@dcPeriodeFin   Decimal(7)      ,
	@dcIdProd	Decimal(7)	WITH RECOMPILE

AS

/* copier de PS_S011_LSTREG_V03 pour CNP CAUTION
*/

SET NOCOUNT ON

Declare	@sCodAdh Char(1)


Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramSne dans un premier temps le d'tail du rSglement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les r'guls effectu'es
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN

With Twrk ( 
			 idperiodeMin,
			 idPeriodeMax,
			 dte_reg,
			 id_sin,
			 id_reg,
			 lib_prod,
			 lib_dept,
			 dte_surv,
			 exercice,
			 mois_surv,
			 dte_decl,
			 id_grp,
			 Nslib_code,
			 id_gti,
			 id_rgpt,
			 Gslib_code,
			 mt_reg,
			 lib_evt,
			 alt_plaf,
			 lib_grp,
			 lib_police,
			 lib_cie,
			 id_orian_boutique,
			 typ_app_sin,
			 typ_evenement,
			 dte_adh,
			 id_adh,
			 frais
		  )
As 
		 (
			Select
			 @dcPeriodeDeb,
			 @dcPeriodeFin,
			 'DTE_REG'	= reg_gti.maj_le,
			 'ID_SIN'	= sinistre.id_sin,
			 'ID_REG'	= reg_gti.id_reg,
			 'LIB_PROD'	= produit.lib_long,
			 'LIB_DEPT'	= departement.lib_dept,
			 'DTE_SURV'	= sinistre.dte_surv,
			 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
			 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
			 'DTE_DECL'	= sinistre.dte_decl,
			 'ID_ETS'	= groupe.id_grp,
			 'NS' 		= code_Ns.lib_code,
			 'ID_GTI'	= reg_gti.id_gti,
			 'ID_RGPT'	= reg_gti.id_rgpt,
			 'GA' 		= code_Gs.lib_code,
			 'MT_REG_GTI'	= reg_gti.mt_reg,
			 'LIB_EVT' = 	( 
			   Select stuff ( 
						( SELECT ', ' + CAST(rtrim ( sysadm.FN_CODE_NUM ( d.id_evt, '+EV') ) AS VARCHAR(250)) 
						  FROM sysadm.detail d
						  Where d.id_sin = reglement.id_sin
						  And   d.id_reg = reglement.id_reg
						  order by d.id_evt
						  For XML PATH ('')
						   )
					, 1, 2, '' )) ,
			 'ALT_PLAF'	= gar_sin.alt_plaf,
			 'LIB_GRP'	= groupe.lib_grp,
			 'LIB_POLICE'	= police.lib_police,
			 'LIB_CIE'	= compagnie.lib_cie,
			 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
			 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
			 'TYPE_EVENEMENT' =  
			  IsNUll ( 
				  ( Select Top 1
						   Case 
								When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
								When id_typ_art = 'PRS' Then 'REPARATION'
								When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
								When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
								When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
								When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
								When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
								Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
						   End 
	  
					From sysadm.reglement r,
						 sysadm.detail d,
						 sysadm.commande c
					Where r.id_sin = sysadm.reg_gti.id_sin
					And   r.id_reg = sysadm.reg_gti.id_reg 
					and   r.cod_mode_reg = 'FM'
					And   d.id_sin = r.id_sin
					and   d.id_reg = r.id_reg
					and   c.id_sin = d.id_sin
					and   c.id_gti = d.id_gti
					and   c.id_detail = d.id_detail
					And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
					 ),
					'REMBOURSEMENT' ), -- VDOC12901
					convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
					sinistre.id_adh as 'ID_ADH', -- VDOC15579
			   IsNull ( 
				   ( Select sum ( fr.mt_frais ) 
					 From  sysadm.frais fr
					 Where fr.id_sin = sinistre.id_sin
				   ),0 ) 'FRAIS' -- VDOC25665

			From
			 sysadm.reg_gti   ,
			 sysadm.sinistre  ,
			 sysadm.garantie,
			 sysadm.gar_sin,
			 sysadm.code code_Ns,
			 sysadm.code code_Gs,
			 sysadm.groupe,
			 sysadm.produit,
			 sysadm.departement,
			 sysadm.police,
			 sysadm.compagnie,
			 sysadm.reglement,
			 sysadm.personne
			Where 
			 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
			 ( gar_sin.id_sin	=	sinistre.id_sin 	)	and
			 ( gar_sin.id_gti	=	reg_gti.id_gti	 	)	and
			 ( sinistre.id_prod	=	produit.id_prod		)	and
			 ( produit.id_dept	=	departement.id_dept	)	and
			 ( groupe.id_grp	=	sinistre.id_ets		)	and
			 ( code_Ns.id_typ_code	=	'+NS'			)	and
			 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
			 ( code_Gs.id_typ_code	=	'-GS'			)	and
			 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
			 ( garantie.id_prod	=	sinistre.id_prod	)	and
			 ( garantie.id_rev	=	sinistre.id_rev		)	and
			 ( garantie.id_gti	=	reg_gti.id_gti		)	and
			 ( garantie.id_police	=	police.id_police	)	and
			 ( compagnie.id_cie	=	police.id_cie		)	and
			 ( sinistre.id_prod	=	@dcIdProd		)	and
			 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
			 ( reglement.id_reg	=	reg_gti.id_reg		)	and
			 ( reglement.cod_mot_reg = 'RN'				)	and
			 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
			 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
			-- [BUG20080728].COD_MODE_REG  JFF
			 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
			-- :[BUG20080728].COD_MODE_REG  JFF
			  -- [PM266]
			  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
					Or
					Not Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
				  ) 


			UNION ALL

			Select
			 @dcPeriodeDeb,
			 @dcPeriodeFin,
			 'DTE_REG'	= reg_gti.maj_le,
			 'ID_SIN'	= sinistre.id_sin,
			 'ID_REG'	= reg_gti.id_reg,
			 'LIB_PROD'	= produit.lib_long,
			 'LIB_DEPT'	= departement.lib_dept,
			 'DTE_SURV'	= sinistre.dte_surv,
			 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
			 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
			 'DTE_DECL'	= sinistre.dte_decl,
			 'ID_ETS'	= groupe.id_grp,
			 'NS' 		= code_Ns.lib_code,
			 'ID_GTI'	= reg_gti.id_gti,
			 'ID_RGPT'	= reg_gti.id_rgpt,
			 'GA' 		= code_Nf.lib_code,
			 'MT_REG_GTI'	= reg_gti.mt_reg,
			 'LIB_EVT' = 	( 
			   Select stuff ( 
						( SELECT ', ' + CAST(rtrim ( sysadm.FN_CODE_NUM ( d.id_evt, '+EV') ) AS VARCHAR(250)) 
						  FROM sysadm.detail d
						  Where d.id_sin = reglement.id_sin
						  And   d.id_reg = reglement.id_reg
						  order by d.id_evt
						  For XML PATH ('')
						   )
					, 1, 2, '' )) ,
			 'ALT_PLAF'	= 'N',
			 'LIB_GRP'	= groupe.lib_grp,
			 'LIB_POLICE'	= police.lib_police,
			 'LIB_CIE'	= compagnie.lib_cie,
			 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
			 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
			 'TYPE_EVENEMENT' =  
			  IsNUll ( 
				  ( Select Top 1
						   Case 
								When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
								When id_typ_art = 'PRS' Then 'REPARATION'
								When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
								When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
								When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
								When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
								When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
								Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
						   End 
	  
					From sysadm.reglement r,
						 sysadm.detail d,
						 sysadm.commande c
					Where r.id_sin = sysadm.reg_gti.id_sin
					And   r.id_reg = sysadm.reg_gti.id_reg 
					and   r.cod_mode_reg = 'FM'
					And   d.id_sin = r.id_sin
					and   d.id_reg = r.id_reg
					and   c.id_sin = d.id_sin
					and   c.id_gti = d.id_gti
					and   c.id_detail = d.id_detail
					And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
					 ),
					'REMBOURSEMENT' ) , -- VDOC12901
					convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
					sinistre.id_adh as 'ID_ADH', -- VDOC15579
			   IsNull ( 
				   ( Select sum ( fr.mt_frais ) 
					 From  sysadm.frais fr
					 Where fr.id_sin = sinistre.id_sin
				   ),0 ) 'FRAIS' -- VDOC25665

			From
			 sysadm.reg_gti   ,
			 sysadm.sinistre  ,
			 sysadm.frais     ,
			 sysadm.garantie,
			 sysadm.code code_Ns,
			 sysadm.code code_Nf,
			 sysadm.groupe,
			 sysadm.produit,
			 sysadm.departement,
			 sysadm.police,
			 sysadm.compagnie,
			 sysadm.personne,
			-- [BUG20080728].COD_MODE_REG  JFF
			 sysadm.reglement
			-- [BUG20080728].COD_MODE_REG  JFF 

			Where 
			 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
			 ( reg_gti.id_sin	=	frais.id_sin		)	and
			 ( reg_gti.id_reg	=	frais.id_reg		)	and
			 ( reg_gti.id_gti	=	-1			)	and
			 ( sinistre.id_prod	=	produit.id_prod		)	and
			 ( produit.id_dept	=	departement.id_dept	)	and
			 ( groupe.id_grp	=	sinistre.id_ets		)	and
			 ( code_Nf.id_typ_code	=	'+NF'			)	and
			 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
			 ( code_Ns.id_typ_code	=	'+NS'			)	and
			 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
			 ( garantie.id_prod	=	sinistre.id_prod	)	and
			 ( garantie.id_rev	=	sinistre.id_rev		)	and
			 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
								   From   sysadm.reg_gti a_reg_gti
								   Where  a_reg_gti.id_sin = reg_gti.id_sin
								   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 						 ( Select max ( gar_sin.id_gti ) 
								   From   sysadm.gar_sin
								   Where  gar_sin.id_sin = sinistre.id_sin )))	and
			 ( garantie.id_police	=	police.id_police	)	and
			 ( compagnie.id_cie	=	police.id_cie		)	and
			 ( sinistre.id_prod	=	@dcIdProd		)	and
			 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
			 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
			-- [BUG20080728].COD_MODE_REG  JFF
			 ( reglement.id_sin     =       reg_gti.id_sin          )       and
			 ( reglement.id_reg     =       reg_gti.id_reg          )       and
			 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
			-- :[BUG20080728].COD_MODE_REG  JFF
			  -- [PM266]
			  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
					Or
					Not Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
				  ) 


			UNION ALL
			Select
			 @dcPeriodeDeb,
			 @dcPeriodeFin,
			 'DTE_REG'	= reglement.dte_reg,
			 'ID_SIN'	= sinistre.id_sin,
			 'ID_REG'	= reglement.id_reg,
			 'LIB_PROD'	= produit.lib_long,
			 'LIB_DEPT'	= departement.lib_dept,
			 'DTE_SURV'	= sinistre.dte_surv,
			 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
			 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
			 'DTE_DECL'	= sinistre.dte_decl,
			 'ID_ETS'	= groupe.id_grp,
			 'NS' 		= code_Ns.lib_code,
			 'ID_GTI'	= -2,
			 'ID_RGPT'	= -2,
			 'GA' 		= Case reglement.lib_reg 
							When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
							Else 'REGULARISATION'
						  End,
			 'MT_REG_GTI'	= reglement.mt_tot_reg,
			 'LIB_EVT' = 	( 
			   Select stuff ( 
						( SELECT ', ' + CAST(rtrim ( sysadm.FN_CODE_NUM ( d.id_evt, '+EV') ) AS VARCHAR(250)) 
						  FROM sysadm.detail d
						  Where d.id_sin = reglement.id_sin
						  And   d.id_reg = reglement.id_reg
						  order by d.id_evt
						  For XML PATH ('')
						   )
					, 1, 2, '' )) ,
			 'ALT_PLAF'	= 'N',
			 'LIB_GRP'	= groupe.lib_grp,
			 'LIB_POLICE'	= police.lib_police,
			 'LIB_CIE'	= compagnie.lib_cie,
			 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
			 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
			 'TYPE_EVENEMENT' =  
			  IsNUll ( 
				  ( Select Top 1
						   Case 
								When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
								When id_typ_art = 'PRS' Then 'REPARATION'
								When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
								When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
								When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
								When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
								When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
								Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
						   End 
	  
					From sysadm.reglement r,
						 sysadm.detail d,
						 sysadm.commande c
					Where r.id_sin = sysadm.reglement.id_sin
					And   r.id_reg = sysadm.reglement.id_reg 
					and   r.cod_mode_reg = 'FM'
					And   d.id_sin = r.id_sin
					and   d.id_reg = r.id_reg
					and   c.id_sin = d.id_sin
					and   c.id_gti = d.id_gti
					and   c.id_detail = d.id_detail
					And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
					 ),
					'REMBOURSEMENT' ) , -- VDOC12901
					convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
					sinistre.id_adh as 'ID_ADH', -- VDOC15579
			   IsNull ( 
				   ( Select sum ( fr.mt_frais ) 
					 From  sysadm.frais fr
					 Where fr.id_sin = sinistre.id_sin
				   ),0 ) 'FRAIS' -- VDOC25665 
			From
			 sysadm.reglement ,
			 sysadm.sinistre  ,
			 sysadm.garantie  ,
			 sysadm.code code_Ns,
			 sysadm.groupe,
			 sysadm.produit,
			 sysadm.departement,
			 sysadm.police,
			 sysadm.compagnie,
			 sysadm.personne
			Where 
			 ( reglement.id_sin	=	sinistre.id_sin 	)	and
			 ( sinistre.id_prod	=	produit.id_prod		)	and
			 ( produit.id_dept	=	departement.id_dept	)	and
			 ( groupe.id_grp	=	sinistre.id_ets		)	and
			 ( code_Ns.id_typ_code	=	'+NS'			)	and
			 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
			 ( garantie.id_prod	=	sinistre.id_prod	)	and
			 ( garantie.id_rev	=	sinistre.id_rev		)	and
			 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
							  From   sysadm.gar_sin
							  Where  gar_sin.id_sin = sinistre.id_sin ))	and
			 ( garantie.id_police	=	police.id_police	)	and
			 ( compagnie.id_cie	=	police.id_cie		)	and
			 ( sinistre.id_prod	=	@dcIdProd		)	and
			 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
			 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
			 ( reglement.mt_tot_reg <> 0				)	and
			 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
			-- [BUG20080728].COD_MODE_REG  JFF
			 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
			-- :[BUG20080728].COD_MODE_REG  JFF
			  -- [PM266]
			  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
					Or
					Not Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
				  ) 
		)
Select 
		t.idperiodeMin,
		t.idPeriodeMax,
		t.dte_reg,
		t.id_sin,
		t.id_reg,
		t.lib_prod,
		t.lib_dept,
		t.dte_surv,
		t.exercice,
		t.mois_surv,
		t.dte_decl,
		t.id_grp,
		t.Nslib_code,
		Sum ( t.mt_reg ) mt_reg_tot_gti,
		t.lib_evt,
		t.alt_plaf,
		t.lib_grp,
		t.lib_police,
		t.lib_cie,
		t.id_orian_boutique,
		t.typ_app_sin,
		t.typ_evenement,
		t.dte_adh,
		t.id_adh,
		t.frais

From Twrk t
Group by 
		t.idperiodeMin,
		t.idPeriodeMax,
		t.dte_reg,
		t.id_sin,
		t.id_reg,
		t.lib_prod,
		t.lib_dept,
		t.dte_surv,
		t.exercice,
		t.mois_surv,
		t.dte_decl,
		t.id_grp,
		t.Nslib_code,
		t.lib_evt,
		t.alt_plaf,
		t.lib_grp,
		t.lib_police,
		t.lib_cie,
		t.id_orian_boutique,
		t.typ_app_sin,
		t.typ_evenement,
		t.dte_adh,
		t.id_adh,
		t.frais
END

Else				-- Adhesions SPB ou autres hors carte

BEGIN

With Twrk ( 
			 idperiodeMin,
			 idPeriodeMax,
			 dte_reg,
			 id_sin,
			 id_reg,
			 lib_prod,
			 lib_dept,
			 dte_surv,
			 exercice,
			 mois_surv,
			 dte_decl,
			 id_grp,
			 Nslib_code,
			 id_gti,
			 id_rgpt,
			 Gslib_code,
			 mt_reg,
			 lib_evt,
			 alt_plaf,
			 lib_grp,
			 lib_police,
			 lib_cie,
			 id_orian_boutique,
			 typ_app_sin,
			 typ_evenement,
			 dte_adh,
			 id_adh,
			 frais
		  )
As 
		 (
			Select
			 @dcPeriodeDeb,
			 @dcPeriodeFin,
			 'DTE_REG'	= reg_gti.maj_le,
			 'ID_SIN'	= sinistre.id_sin,
			 'ID_REG'	= reg_gti.id_reg,
			 'LIB_PROD'	= produit.lib_long,
			 'LIB_DEPT'	= departement.lib_dept,
			 'DTE_SURV'	= sinistre.dte_surv,
			 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
			 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
			 'DTE_DECL'	= sinistre.dte_decl,
			 'ID_ETS'	= groupe.id_grp,
			 'NS' 		= code_Ns.lib_code,
			 'ID_GTI'	= reg_gti.id_gti,
			 'ID_RGPT'	= reg_gti.id_rgpt,
			 'GA' 		= code_Gs.lib_code,
			 'MT_REG_GTI'	= reg_gti.mt_reg,
			 'LIB_EVT' = 	( 
			   Select stuff ( 
						( SELECT ', ' + CAST(rtrim ( sysadm.FN_CODE_NUM ( d.id_evt, '+EV') ) AS VARCHAR(250)) 
						  FROM sysadm.detail d
						  Where d.id_sin = reglement.id_sin
						  And   d.id_reg = reglement.id_reg
						  order by d.id_evt
						  For XML PATH ('')
						   )
					, 1, 2, '' )) ,
			 'ALT_PLAF'	= gar_sin.alt_plaf,
			 'LIB_GRP'	= groupe.lib_grp,
			 'LIB_POLICE'	= police.lib_police,
			 'LIB_CIE'	= compagnie.lib_cie,
			 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
			 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
			 'TYPE_EVENEMENT' =  
			  IsNUll ( 
				  ( Select Top 1
						   Case 
								When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
								When id_typ_art = 'PRS' Then 'REPARATION'
								When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
								When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
								When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
								When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
								When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
								Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
						   End 
	  
					From sysadm.reglement r,
						 sysadm.detail d,
						 sysadm.commande c
					Where r.id_sin = sysadm.reg_gti.id_sin
					And   r.id_reg = sysadm.reg_gti.id_reg 
					and   r.cod_mode_reg = 'FM'
					And   d.id_sin = r.id_sin
					and   d.id_reg = r.id_reg
					and   c.id_sin = d.id_sin
					and   c.id_gti = d.id_gti
					and   c.id_detail = d.id_detail
					And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
					 ),
					'REMBOURSEMENT' ) , -- VDOC12901
					convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
					sinistre.id_adh as 'ID_ADH', -- VDOC15579
				IsNull ( 
				   ( Select sum ( fr.mt_frais ) 
					 From  sysadm.frais fr
					 Where fr.id_sin = sinistre.id_sin
				   ),0 ) 'FRAIS' -- VDOC25665
			From
			 sysadm.reg_gti   ,
			 sysadm.sinistre  ,
			 sysadm.garantie,
			 sysadm.gar_sin,
			 sysadm.etablissement,
			 sysadm.code code_Ns,
			 sysadm.code code_Gs,
			 sysadm.groupe,
			 sysadm.produit,
			 sysadm.departement,
			 sysadm.police,
			 sysadm.compagnie,
			 sysadm.reglement,
			 sysadm.personne
			Where 
			 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
			 ( sinistre.id_prod	=	produit.id_prod		)	and
			 ( produit.id_dept	=	departement.id_dept	)	and
			 ( reg_gti.id_sin	=	gar_sin.id_sin		)	and
			 ( reg_gti.id_gti	=	gar_sin.id_gti		)	and
			 ( groupe.id_grp	=	etablissement.id_grp	)	and
			 ( etablissement.id_prod=	sinistre.id_prod	)	and
			 ( etablissement.id_ets	=	sinistre.id_ets		)	and
			 ( etablissement.id_rev	=	-1			)	and
			 ( code_Ns.id_typ_code	=	'+NS'			)	and
			 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
			 ( code_Gs.id_typ_code	=	'-GS'			)	and
			 ( code_Gs.id_code	=	reg_gti.id_rgpt		)	and
			 ( garantie.id_prod	=	sinistre.id_prod	)	and
			 ( garantie.id_rev	=	sinistre.id_rev		)	and
			 ( garantie.id_gti	=	reg_gti.id_gti		)	and
			 ( garantie.id_police	=	police.id_police	)	and
			 ( compagnie.id_cie	=	police.id_cie		)	and
			 ( sinistre.id_prod	=	@dcIdProd		)	and
			 ( reglement.id_sin	=	reg_gti.id_sin 		)	and
			 ( reglement.id_reg	=	reg_gti.id_reg		)	and
			 ( reglement.cod_mot_reg = 'RN'				)	and
			 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
			 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
			-- [BUG20080728].COD_MODE_REG  JFF
			 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
			-- :[BUG20080728].COD_MODE_REG  JFF
			  -- [PM266]
			  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
					Or
					Not Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
				  ) 

			UNION ALL
			Select
			 @dcPeriodeDeb,
			 @dcPeriodeFin,
			 'DTE_REG'	= reg_gti.maj_le,
			 'ID_SIN'	= sinistre.id_sin,
			 'ID_REG'	= reg_gti.id_reg,
			 'LIB_PROD'	= produit.lib_long,
			 'LIB_DEPT'	= departement.lib_dept,
			 'DTE_SURV'	= sinistre.dte_surv,
			 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
			 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
			 'DTE_DECL'	= sinistre.dte_decl,
			 'ID_ETS'	= groupe.id_grp,
			 'NS' 		= code_Ns.lib_code,
			 'ID_GTI'	= reg_gti.id_gti,
			 'ID_RGPT'	= reg_gti.id_rgpt,
			 'GA' 		= code_Nf.lib_code,
			 'MT_REG_GTI'	= reg_gti.mt_reg,
			 'LIB_EVT' = 	( 
			   Select stuff ( 
						( SELECT ', ' + CAST(rtrim ( sysadm.FN_CODE_NUM ( d.id_evt, '+EV') ) AS VARCHAR(250)) 
						  FROM sysadm.detail d
						  Where d.id_sin = reglement.id_sin
						  And   d.id_reg = reglement.id_reg
						  order by d.id_evt
						  For XML PATH ('')
						   )
					, 1, 2, '' )) ,
			 'ALT_PLAF'	= 'N',
			 'LIB_GRP'	= groupe.lib_grp,
			 'LIB_POLICE'	= police.lib_police,
			 'LIB_CIE'	= compagnie.lib_cie,
			 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
			 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
			 'TYPE_EVENEMENT' =  
			  IsNUll ( 
				  ( Select Top 1
						   Case 
								When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
								When id_typ_art = 'PRS' Then 'REPARATION'
								When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
								When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
								When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
								When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
								When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
								Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
						   End 
	  
					From sysadm.reglement r,
						 sysadm.detail d,
						 sysadm.commande c
					Where r.id_sin = sysadm.reg_gti.id_sin
					And   r.id_reg = sysadm.reg_gti.id_reg 
					and   r.cod_mode_reg = 'FM'
					And   d.id_sin = r.id_sin
					and   d.id_reg = r.id_reg
					and   c.id_sin = d.id_sin
					and   c.id_gti = d.id_gti
					and   c.id_detail = d.id_detail
					And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
					 ),
					'REMBOURSEMENT' ) , -- VDOC12901
					convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
					sinistre.id_adh as 'ID_ADH', -- VDOC15579
			   IsNull ( 
				   ( Select sum ( fr.mt_frais ) 
					 From  sysadm.frais fr
					 Where fr.id_sin = sinistre.id_sin
				   ),0 ) 'FRAIS' -- VDOC25665
			From
			 sysadm.reg_gti   ,
			 sysadm.sinistre  ,
			 sysadm.frais     ,
			 sysadm.garantie,
			 sysadm.etablissement,
			 sysadm.code code_Ns,
			 sysadm.code code_Nf,
			 sysadm.groupe,
			 sysadm.produit,
			 sysadm.departement,
			 sysadm.police,
			 sysadm.compagnie,
			 sysadm.personne,
			-- [BUG20080728].COD_MODE_REG  JFF
			 sysadm.reglement
			-- [BUG20080728].COD_MODE_REG  JFF 
			Where 
			 ( reg_gti.id_sin	=	sinistre.id_sin 	)	and
			 ( reg_gti.id_sin	=	frais.id_sin		)	and
			 ( reg_gti.id_reg	=	frais.id_reg		)	and
			 ( reg_gti.id_gti	=	-1			)	and
			 ( sinistre.id_prod	=	produit.id_prod		)	and
			 ( produit.id_dept	=	departement.id_dept	)	and
			 ( groupe.id_grp	=	etablissement.id_grp	)	and
			 ( etablissement.id_prod=	sinistre.id_prod	)	and
			 ( etablissement.id_ets	=	sinistre.id_ets		)	and
			 ( etablissement.id_rev	=	-1			)	and
			 ( code_Ns.id_typ_code	=	'+NS'			)	and
			 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
			 ( code_Nf.id_typ_code	=	'+NF'			)	and
			 ( code_Nf.id_code	=	frais.id_typ_frais	)	and
			 ( garantie.id_prod	=	sinistre.id_prod	)	and
			 ( garantie.id_rev	=	sinistre.id_rev		)	and
			 ( garantie.id_gti	=	IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
								   From   sysadm.reg_gti a_reg_gti
								   Where  a_reg_gti.id_sin = reg_gti.id_sin
								   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

		 						 ( Select max ( gar_sin.id_gti ) 
								   From   sysadm.gar_sin
								   Where  gar_sin.id_sin = sinistre.id_sin )))	and
			 ( garantie.id_police	=	police.id_police	)	and
			 ( compagnie.id_cie	=	police.id_cie		)	and
			 ( sinistre.id_prod	=	@dcIdProd		)	and
			 ( reg_gti.maj_le    between    @dtDteDeb And @dtDteFin )	and
			 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
			-- [BUG20080728].COD_MODE_REG  JFF
			 ( reglement.id_sin     =       reg_gti.id_sin          )       and
			 ( reglement.id_reg     =       reg_gti.id_reg          )       and
			 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
			-- :[BUG20080728].COD_MODE_REG  JFF
			  -- [PM266]
			  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
					Or
					Not Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
				  ) 

			UNION ALL

			Select
			 @dcPeriodeDeb,
			 @dcPeriodeFin,
			 'DTE_REG'	= reglement.dte_reg,
			 'ID_SIN'	= sinistre.id_sin,
			 'ID_REG'	= reglement.id_reg,
			 'LIB_PROD'	= produit.lib_long,
			 'LIB_DEPT'	= departement.lib_dept,
			 'DTE_SURV'	= sinistre.dte_surv,
			 'ID_EXERCICE'  = DatePart ( year, sinistre.dte_surv ),
			 'ID_MOISSURV'	= DatePart ( month, sinistre.dte_surv ),
			 'DTE_DECL'	= sinistre.dte_decl,
			 'ID_ETS'	= groupe.id_grp,
			 'NS' 		= code_Ns.lib_code,
			 'ID_GTI'	= -2,
			 'ID_RGPT'	= -2,
			 'GA' 		= Case reglement.lib_reg 
							When 'RM/FRANCHISE (FR5)' Then 'FRANCHISE'
							Else 'REGULARISATION'
						  End,
			 'MT_REG_GTI'	= reglement.mt_tot_reg,
			 'LIB_EVT' = 	( 
			   Select stuff ( 
						( SELECT ', ' + CAST(rtrim ( sysadm.FN_CODE_NUM ( d.id_evt, '+EV') ) AS VARCHAR(250)) 
						  FROM sysadm.detail d
						  Where d.id_sin = reglement.id_sin
						  And   d.id_reg = reglement.id_reg
						  order by d.id_evt
						  For XML PATH ('')
						   )
					, 1, 2, '' )) ,
			 'ALT_PLAF'	= 'N',
			 'LIB_GRP'	= groupe.lib_grp,
			 'LIB_POLICE'	= police.lib_police,
			 'LIB_CIE'	= compagnie.lib_cie,
			 'ID_BOUTIQUE'	= sinistre.id_orian_boutique,
			 'TYPE_APPAREIL_SINISTRE' = (select sysadm.FN_CODE_CAR(d.val_car,'-AR') from sysadm.div_sin d where d.id_sin=sinistre.id_sin and d.nom_zone='type_app'),
			 'TYPE_EVENEMENT' =  
			  IsNUll ( 
				  ( Select Top 1
						   Case 
								When id_ref_four = 'A_DIAGNOSTIQUER' Then 'DIAGNOSTIC'
								When id_typ_art = 'PRS' Then 'REPARATION'
								When id_typ_art = 'EDI' And CharIndex ( 'REPARER', id_ref_four ) > 0 Then  'REPARATION'					
								When id_typ_art = 'EDI' And CharIndex ( 'DESOXYDER', id_ref_four ) > 0 Then  'DESOXYDATION'										
								When id_typ_art = 'CAF' Then 'REMPLACEMENT PAR BON ACHAT'
								When id_typ_art = 'EDI' And c.id_four = 'CDS' Then 'REMPLACEMENT PAR BON ACHAT' -- [VDOC19386]
								When id_typ_art = 'PST' Then ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))					
								Else 'REMPLACEMENT PAR ' + ( Select sysadm.FN_CODE_CAR ( id_typ_art, '-AR' ))
						   End 
	  
					From sysadm.reglement r,
						 sysadm.detail d,
						 sysadm.commande c
					Where r.id_sin = sysadm.reglement.id_sin
					And   r.id_reg = sysadm.reglement.id_reg 
					and   r.cod_mode_reg = 'FM'
					And   d.id_sin = r.id_sin
					and   d.id_reg = r.id_reg
					and   c.id_sin = d.id_sin
					and   c.id_gti = d.id_gti
					and   c.id_detail = d.id_detail
					And   c.id_ref_four not in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP', 'DECISION_SPB' )
					 ),
					'REMBOURSEMENT' ) , -- VDOC12901
					convert(varchar(10), sinistre.dte_adh,103) as 'DATE_ADHESION', -- VDOC13132
					sinistre.id_adh as 'ID_ADH', -- VDOC15579
				IsNull ( 
				   ( Select sum ( fr.mt_frais ) 
					 From  sysadm.frais fr
					 Where fr.id_sin = sinistre.id_sin
				   ),0 ) 'FRAIS' -- VDOC25665
			From
			 sysadm.reglement ,
			 sysadm.sinistre  ,
			 sysadm.garantie  ,
			 sysadm.etablissement,
			 sysadm.code code_Ns,
			 sysadm.groupe,
			 sysadm.produit,
			 sysadm.departement,
			 sysadm.police,
			 sysadm.compagnie,
			 sysadm.personne
			Where 
			 ( reglement.id_sin	=	sinistre.id_sin 	)	and
			 ( sinistre.id_prod	=	produit.id_prod		)	and
			 ( produit.id_dept	=	departement.id_dept	)	and
			 ( groupe.id_grp	=	etablissement.id_grp	)	and
			 ( etablissement.id_prod=	sinistre.id_prod	)	and
			 ( etablissement.id_ets	=	sinistre.id_ets		)	and
			 ( etablissement.id_rev	=	-1			)	and
			 ( code_Ns.id_typ_code	=	'+NS'			)	and
			 ( code_Ns.id_code	=	sinistre.id_natsin	)	and
			 ( garantie.id_prod	=	sinistre.id_prod	)	and
			 ( garantie.id_rev	=	sinistre.id_rev		)	and
			 ( garantie.id_gti	=	( Select max ( gar_sin.id_gti ) 
							  From   sysadm.gar_sin
							  Where  gar_sin.id_sin = sinistre.id_sin ))	and
			 ( garantie.id_police	=	police.id_police	)	and
			 ( compagnie.id_cie	=	police.id_cie		)	and
			 ( sinistre.id_prod	=	@dcIdProd		)	and
			 ( reglement.dte_reg between    @dtDteDeb And @dtDteFin )	and
			 ( reglement.cod_mot_reg in ( 'RE', 'RM', 'RP' )	)	and
			 ( reglement.mt_tot_reg <> 0				)	and
			 ( personne.id_ordre    = 	sinistre.id_ordre	)	and
			-- [BUG20080728].COD_MODE_REG  JFF
			 ( reglement.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) 
			-- :[BUG20080728].COD_MODE_REG  JFF
			  -- [PM266]
			  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
					Or
					Not Exists ( 
						Select 1
						From   sysadm.exclu_ass ex
						Where  ex.id_cie = police.id_cie
						)
				  ) 

		)
Select 
		t.idperiodeMin,
		t.idPeriodeMax,
		t.dte_reg,
		t.id_sin,
		t.id_reg,
		t.lib_prod,
		t.lib_dept,
		t.dte_surv,
		t.exercice,
		t.mois_surv,
		t.dte_decl,
		t.id_grp,
		t.Nslib_code,
		Sum ( t.mt_reg ) mt_reg_tot_gti,
		t.lib_evt,
		t.alt_plaf,
		t.lib_grp,
		t.lib_police,
		t.lib_cie,
		t.id_orian_boutique,
		t.typ_app_sin,
		t.typ_evenement,
		t.dte_adh,
		t.id_adh,
		t.frais

From Twrk t/*,
	 sysadm.detail d
Where d.id_sin = t.id_sin
And   d.id_reg = t.id_reg */
Group by 
		t.idperiodeMin,
		t.idPeriodeMax,
		t.dte_reg,
		t.id_sin,
		t.id_reg,
		t.lib_prod,
		t.lib_dept,
		t.dte_surv,
		t.exercice,
		t.mois_surv,
		t.dte_decl,
		t.id_grp,
		t.Nslib_code,
	    t.lib_evt, 
		t.alt_plaf,
		t.lib_grp,
		t.lib_police,
		t.lib_cie,
		t.id_orian_boutique,
		t.typ_app_sin,
		t.typ_evenement,
		t.dte_adh,
		t.id_adh,
		t.frais

END

Go
