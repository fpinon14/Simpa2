-------------------------------------------------------------------
--
-- Fichier              :       CUM_PERI.CP
-- Auteur               :       FABRY JF
-- Date                 :       22/12/98 14:00:00
--
-- Commentaires         :       Liste des procédures afférent à la table CUM_PERIODE
--
-- Procédures           :	
--				*** Par Garantie, toutes Cies, toutes Polices, Toutes Banques ***
--
--                              DW_S01_CUM_PERIODE		( Récap Réglés et en cours de Règlement / Garantie )
--				DW_S21_CUM_PERIODE		Copie du DW_S01_CUM_PERIODE mais pour tous les produit en dur du comptes AIG (DCMP 030444/DTA/V. MALO)
--				DW_S02_CUM_PERIODE		( Récap en cours d'instruction  / Garantie )
--				DW_S03_CUM_PERIODE		( Récap refusés  / Garantie )
--				DW_S04_CUM_PERIODE		( Récap sans suite  / Garantie )
--				DW_S05_CUM_PERIODE		( Récap Ouverts  / Garantie )
--
--				*** Par Type de Carte, toutes Cies, toutes Polices, Toutes Banques  ***
--
--                              DW_S06_CUM_PERIODE		( Récap Réglés et en cours de Règlement / type carte )
--                              DW_S061_CUM_PERIODE		( Récap Réglés et en cours de Règlement / type carte/Garantie Visa 4S ) ( DBI le 10/05/2000 suite DEEI 1372 )
--                              DW_S07_CUM_PERIODE		( Récap en cours d'instruction / type carte )
--				DW_S08_CUM_PERIODE		( Récap refusés / type carte )
--				DW_S09_CUM_PERIODE		( Récap sans suite / type carte )
--				DW_S10_CUM_PERIODE		( Récap Ouverts / Type carte )
--                      	DW_S101_CUM_PERIODE		( Récap Ouverts / Type carte /Garantie Visa 4S ) ( JFF le 16/05/2000 suite DEEI 1372 )
--
--				*** Par Garantie, Pour une banque  ***
--
--                              DW_S11_CUM_PERIODE		( Récap Réglés et en cours de Règlement / garantie pour une banque )
--                              DW_S12_CUM_PERIODE		( Récap en cours d'instruction / garantie pour une banque )
--                              DW_S13_CUM_PERIODE		( Récap refusés / garantie pour une banque )
--                              DW_S14_CUM_PERIODE		( Récap sans suite / garantie pour une banque )
-- 				DW_S15_CUM_PERIODE		( Récap Ouverts / garantie pour une banque )
--
--				*** Par Type de carte, Pour une banque  ***
--
--                              DW_S16_CUM_PERIODE		( Récap Réglés et en cours de Règlement / Type de carte pour une banque )
--                              DW_S17_CUM_PERIODE		( Récap en cours d'instruction / Type de carte pour une banque )
--                              DW_S18_CUM_PERIODE		( Récap refusés / Type de carte pour une banque )
--                              DW_S19_CUM_PERIODE		( Récap sans suite / Type de carte pour une banque )
-- 				DW_S20_CUM_PERIODE		( Récap Ouverts / Type de carte pour une banque )
--
--				*** Proc‚dure d'insertion ***
--				PS_I01_CUM_PERIODE 		(Insertion des enregistrements dans Cum_Periode … partir de stat_sin)

-------------------------------------------------------------------



--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_CUM_PERIODE
-- Auteur               :       FABRY JF
-- Date                 :       22/12/98 14:00:00
-- Libellé              :       Sélection sur CUM_PERIODE des dossiers réglés et en cours de règlement
-- Commentaires         :	Les tris seront fait sur le client (la DW), afin de soulager le serveur
-- Références           :       Utilisé dans la Dw : D_R_REG1
--
--				EURO
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S01_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S01_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 )
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


SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	cum_periode.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_reg,
	cum_periode.mt_reg / @dcTaux

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  in ( 550, 600 ) 				)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  
	
UNION ALL
	
SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_reg,
	cum_periode.mt_reg / @dcTaux

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.etablissement,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  in ( 550, 600 ) 				)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	<> '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( etablissement.id_prod = cum_periode.id_prod				)  and
	( etablissement.id_ets  = cum_periode.id_grp				)  and
	( etablissement.id_grp  = groupe.id_grp					)  and
	( etablissement.id_rev  = -1						)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  
	

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_CUM_PERIODE
-- Auteur               :       FABRY JF
-- Date                 :       28/12/98 14:00:00
-- Libellé              :       Sélection sur CUM_PERIODE des dossiers en cours d'instructions
-- Commentaires         :	Les tris seront fait sur le client (la DW), afin de soulager le serveur
-- Références           :       Utilisé dans la DW : D_R_ENC1
--
-- Arguments            :       @dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S02_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S02_CUM_PERIODE
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode= @dcIdPeriodeMax				)  and
	( cum_periode.cod_etat  = 100 						)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and 
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)

	
UNION ALL
	
SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.etablissement,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode= @dcIdPeriodeMax				)  and
	( cum_periode.cod_etat  = 100				 		)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	<> '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( etablissement.id_prod = cum_periode.id_prod				)  and
	( etablissement.id_ets  = cum_periode.id_grp				)  and
	( etablissement.id_grp  = groupe.id_grp					)  and
	( etablissement.id_rev  = -1						)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)

	

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S03_CUM_PERIODE
-- Auteur               :       FABRY JF
-- Date                 :       28/12/98 15:37:00
-- Libellé              :       Sélection sur CUM_PERIODE des dossiers refusés
-- Commentaires         :	Les tris seront fait sur le client (la DW), afin de soulager le serveur
-- Références           :       Utilisé dans la DW : D_R_REF1
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S03_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S03_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  = 200 						)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)
	
UNION ALL
	
SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.etablissement,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  = 200				 		)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	<> '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( etablissement.id_prod = cum_periode.id_prod				)  and
	( etablissement.id_ets  = cum_periode.id_grp				)  and
	( etablissement.id_grp  = groupe.id_grp					)  and
	( etablissement.id_rev  = -1						)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)
	

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S04_CUM_PERIODE
-- Auteur               :       FABRY JF
-- Date                 :       28/12/98 16:30:00
-- Libellé              :       Sélection sur CUM_PERIODE des dossiers sans suite
-- Commentaires         :	Les tris seront fait sur le client (la DW), afin de soulager le serveur
-- Références           :       Utilisé dans la DW : D_R_SSU1
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S04_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S04_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 )

AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  >= 900 						)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)
	
UNION ALL
	
SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.etablissement,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  >= 900				 		)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	<> '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( etablissement.id_prod = cum_periode.id_prod				)  and
	( etablissement.id_ets  = cum_periode.id_grp				)  and
	( etablissement.id_grp  = groupe.id_grp					)  and
	( etablissement.id_rev  = -1						)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)
	

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S05_CUM_PERIODE
-- Auteur               :       DBI
-- Date                 :       28/12/98 15:37:00
-- Libellé              :       Sélection sur CUM_PERIODE des garanties ouvertes
-- Commentaires         :	Les tris seront fait sur le client (la DW), afin de soulager le serveur
-- Références           :       Utilisé dans la DW : D_R_OUV1
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S05_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S05_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S05_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_ouv

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( cum_periode.cpt_ouv	> 0						)
	
UNION ALL
	
SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_ouv

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.etablissement,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	<> '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( etablissement.id_prod = cum_periode.id_prod				)  and
	( etablissement.id_ets  = cum_periode.id_grp				)  and
	( etablissement.id_grp  = groupe.id_grp					)  and
	( etablissement.id_rev  = -1						)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( cum_periode.cpt_ouv	> 0						)


GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S06_CUM_PERIODE
-- Auteur               :       DBI
-- Date                 :       28/12/98 15:37:00
-- Libellé              :       S‚lection sur CUM_PERIODE des rŠglements avec type de carte
-- Commentaires         :	
-- Références           :       Utilis‚ sur : D_R_REG3
--
--				EURO
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S06_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S06_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S06_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 )
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


-- Modif le 10/01/01 par JFF
-- On distingue à présent les frais d'envoi

-- Sans les Frais d'envoi

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_type_carte,
	CodeTc.lib_code,
	cum_periode.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_reg,
	cum_periode.mt_reg / @dcTaux

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code_car CodeTc,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  in ( 550, 600 ) 				)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeTc.id_typ_code	= '-TC'						)  and
	( CodeTc.id_code	= cum_periode.id_type_carte			)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( cum_periode.id_rgpt	<> -1		 				) 
	

UNION ALL

-- Seulement les frais d'envoi

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_type_carte,
	CodeRgpt.lib_code,
	cum_periode.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_reg,
	cum_periode.mt_reg / @dcTaux

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  in ( 550, 600 ) 				)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( cum_periode.id_rgpt	= -1		 				)  

	

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S061_CUM_PERIODE
-- Auteur               :       DBI
-- Date                 :       10/05/2000 15:37:00
-- Libellé              :       S‚lection sur CUM_PERIODE des rŠglements avec type de carte/garantie 
-- Commentaires         :	DEEI 1372
-- Références           :       Utilis‚ sur : D_R_REG41
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S061_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S061_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S061_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_type_carte,
	CodeTc.lib_code,
	cum_periode.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_gti,
	CodeGti.lib_code as lib_gti,
	cum_periode.cpt_reg ,
	cum_periode.mt_reg 

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code_car CodeTc,
	sysadm.code CodeGti

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  in ( 550, 600 ) 				)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeTc.id_typ_code	= '-TC'						)  and
	( CodeTc.id_code	= cum_periode.id_type_carte			)  and
	( CodeGti.id_typ_code	= '-GS'						)  and
	( CodeGti.id_code	= cum_periode.id_gti				)

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S07_CUM_PERIODE
-- Auteur               :       JFF
-- Date                 :       20/01/99 11:38:00
-- Libellé              :       S‚lection sur CUM_PERIODE des en cours d'instruction avec type de carte
-- Commentaires         :	
-- Références           :       Utilis‚ sur : D_R_ENC6
--
-- Arguments            :       @dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S07_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S07_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S07_CUM_PERIODE
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_type_carte,
	CodeTc.lib_code,
	cum_periode.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code_car CodeTc,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode= @dcIdPeriodeMax				)  and
	( cum_periode.cod_etat  = 100		 				)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeTc.id_typ_code	= '-TC'						)  and
	( CodeTc.id_code	= cum_periode.id_type_carte			)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)

	

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S08_CUM_PERIODE
-- Auteur               :       JFF
-- Date                 :       20/01/99 11:45:00
-- Libellé              :       S‚lection sur CUM_PERIODE des refus‚s avec type de carte
-- Commentaires         :	
-- Références           :       Utilis‚ sur : D_R_REF3
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S08_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S08_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S08_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_type_carte,
	CodeTc.lib_code,
	cum_periode.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code_car CodeTc,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  = 200		 				)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeTc.id_typ_code	= '-TC'						)  and
	( CodeTc.id_code	= cum_periode.id_type_carte			)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)

	

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S09_CUM_PERIODE
-- Auteur               :       JFF
-- Date                 :       20/01/99 11:48:00
-- Libellé              :       S‚lection sur CUM_PERIODE des sans suite avec type de carte
-- Commentaires         :	
-- Références           :       Utilis‚ sur : D_R_SSU2
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S09_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S09_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S09_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_type_carte,
	CodeTc.lib_code,
	cum_periode.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code_car CodeTc,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  >= 900		 				)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeTc.id_typ_code	= '-TC'						)  and
	( CodeTc.id_code	= cum_periode.id_type_carte			)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)

	

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S10_CUM_PERIODE
-- Auteur               :       JFF
-- Date                 :       20/01/99 11:55:00
-- Libellé              :       S‚lection sur CUM_PERIODE des d‚clar‚s avec type de carte
-- Commentaires         :	
-- Références           :       Utilis‚ sur : D_R_OUV4
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S10_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S10_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S10_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_type_carte,
	CodeTc.lib_code,
	cum_periode.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_ouv

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code_car CodeTc,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeTc.id_typ_code	= '-TC'						)  and
	( CodeTc.id_code	= cum_periode.id_type_carte			)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( cum_periode.cpt_ouv > 0						)

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S101_CUM_PERIODE
-- Auteur               :       JFF
-- Date                 :       16/05/00 11:55:00
-- Libellé              :       S‚lection sur CUM_PERIODE des d‚clar‚s avec type de carte/Par garantie
-- Commentaires         :	  Suite DEEI, voir début 
-- Références           :       Utilis‚ sur : D_R_OUV4
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S101_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S101_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S101_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_type_carte,
	CodeTc.lib_code,
	cum_periode.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_gti,
	CodeGti.lib_code as lib_gti,
	cum_periode.cpt_ouv

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code_car CodeTc,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin,
	sysadm.code CodeGti

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeTc.id_typ_code	= '-TC'						)  and
	( CodeTc.id_code	= cum_periode.id_type_carte			)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( CodeGti.id_typ_code	= '-GS'						)  and
	( CodeGti.id_code		= cum_periode.id_gti				)  and
	( cum_periode.cpt_ouv > 0						)


GO



--------------------------------------------------------------------
--
-- Procédure            :       DW_S11_CUM_PERIODE
-- Auteur               :       FABRY JF
-- Date                 :       21/01/99 10:40:00
-- Libellé              :       Sélection sur CUM_PERIODE des dossiers réglés et en cours de règlement / par garantie pour une banque
-- Commentaires         :	
-- Références           :       Utilisé dans la Dw : D_R_REG11
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)
--				@dcIdGrp		Decimal ( 7,0 )     (Val)
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S11_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S11_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S11_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 ),
	    @dcIdGrp	      Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	cum_periode.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_reg,
	cum_periode.mt_reg

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  in ( 550, 600 ) 				)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( groupe.id_grp		= @dcIdGrp					)  and
	( cum_periode.id_grp 	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  
	
UNION ALL
	
SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_reg,
	cum_periode.mt_reg

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.etablissement,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  in ( 550, 600 ) 				)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	<> '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( groupe.id_grp		= @dcIdGrp					)  and
	( etablissement.id_prod = cum_periode.id_prod				)  and
	( etablissement.id_grp  = groupe.id_grp					)  and
	( etablissement.id_ets  = cum_periode.id_grp				)  and
	( etablissement.id_rev  = -1						)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  
	

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S12_CUM_PERIODE
-- Auteur               :       FABRY JF
-- Date                 :       21/01/99 14:00:00
-- Libellé              :       Sélection sur CUM_PERIODE des dossiers en cours d'instructions/ par garantie pour une banque
-- Commentaires         :	
-- Références           :       Utilisé dans la DW : D_R_ENC11
--
-- Arguments            :       @dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--				@dcIdGrp	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S12_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S12_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S12_CUM_PERIODE
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 ),
            @dcIdGrp          Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode= @dcIdPeriodeMax				)  and
	( cum_periode.cod_etat  = 100 						)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( groupe.id_grp		= @dcIdGrp					)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and 
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)

	
UNION ALL
	
SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.etablissement,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode= @dcIdPeriodeMax				)  and
	( cum_periode.cod_etat  = 100				 		)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	<> '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( groupe.id_grp		= @dcIdGrp					)  and
	( etablissement.id_prod = cum_periode.id_prod				)  and
	( etablissement.id_ets  = cum_periode.id_grp				)  and
	( etablissement.id_grp  = groupe.id_grp					)  and
	( etablissement.id_rev  = -1						)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)

	

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S13_CUM_PERIODE
-- Auteur               :       FABRY JF
-- Date                 :       21/01/99 15:24:00
-- Libellé              :       Sélection sur CUM_PERIODE des dossiers refusés/ par garantie pour une banque
-- Commentaires         :	
-- Références           :       Utilisé dans la DW : D_R_REF11
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--				@dcIdGrp	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S13_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S13_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S13_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 ),
	    @dcIdGrp	      Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  = 200 						)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( groupe.id_grp 	= @dcIdGrp					)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)
	
UNION ALL
	
SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.etablissement,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  = 200				 		)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	<> '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( groupe.id_grp 	= @dcIdGrp					)  and
	( etablissement.id_prod = cum_periode.id_prod				)  and
	( etablissement.id_ets  = cum_periode.id_grp				)  and
	( etablissement.id_grp  = groupe.id_grp					)  and
	( etablissement.id_rev  = -1						)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)
	

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S14_CUM_PERIODE
-- Auteur               :       FABRY JF
-- Date                 :       21/01/99 14:00:00
-- Libellé              :       Sélection sur CUM_PERIODE des dossiers sans suite / par garantie pour une banque
-- Commentaires         :	
-- Références           :       Utilisé dans la DW : D_R_SSU11
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--				@dcIdGrp	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S14_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S14_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S14_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 ),
	    @dcIdGrp	      Decimal ( 7, 0 )

AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  >= 900 						)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( groupe.id_grp 	= @dcIdGrp					)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)
	
UNION ALL
	
SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.etablissement,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  >= 900				 		)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	<> '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( groupe.id_grp 	= @dcIdGrp					)  and
	( etablissement.id_prod = cum_periode.id_prod				)  and
	( etablissement.id_ets  = cum_periode.id_grp				)  and
	( etablissement.id_grp  = groupe.id_grp					)  and
	( etablissement.id_rev  = -1						)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)
	

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S15_CUM_PERIODE
-- Auteur               :       DBI
-- Date                 :       21/01/99 15:24:00
-- Libellé              :       Sélection sur CUM_PERIODE des garanties ouvertes / par garantie pour une banque
-- Commentaires         :	
-- Références           :       Utilisé dans la DW : D_R_OUV11
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--				@dcIdGrp	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S15_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S15_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S15_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 ),
	    @dcIdGrp	      Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_ouv

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( groupe.id_grp 	= @dcIdGrp					)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( cum_periode.cpt_ouv	> 0						)
	
UNION ALL
	
SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_ouv

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.etablissement,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	<> '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( groupe.id_grp 	= @dcIdGrp					)  and
	( etablissement.id_prod = cum_periode.id_prod				)  and
	( etablissement.id_ets  = cum_periode.id_grp				)  and
	( etablissement.id_grp  = groupe.id_grp					)  and
	( etablissement.id_rev  = -1						)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( cum_periode.cpt_ouv	> 0						)


GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S16_CUM_PERIODE
-- Auteur               :       JFF
-- Date                 :       21/01/99 15:24:00
-- Libellé              :       S‚lection sur CUM_PERIODE des rŠglements / type de carte et pour une banque
-- Commentaires         :	
-- Références           :       Utilis‚ sur : D_R_REG31
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--				@dcIdGrp	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S16_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S16_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S16_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 ),
	    @dcIdGrp	      Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_type_carte,
	CodeTc.lib_code,
	cum_periode.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_reg,
	cum_periode.mt_reg

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code_car CodeTc,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  in ( 550, 600 ) 				)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( groupe.id_grp		= @dcIdGrp					)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeTc.id_typ_code	= '-TC'						)  and
	( CodeTc.id_code	= cum_periode.id_type_carte			)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  
	

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S17_CUM_PERIODE
-- Auteur               :       JFF
-- Date                 :       20/01/99 11:38:00
-- Libellé              :       S‚lection sur CUM_PERIODE des en cours d'instruction / type de carte et pour une banque
-- Commentaires         :	
-- Références           :       Utilis‚ sur : D_R_ENC61
--
-- Arguments            :       @dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--				@dcIdGrp	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S17_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S17_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S17_CUM_PERIODE
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 ),
	    @dcIdGrp	      Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_type_carte,
	CodeTc.lib_code,
	cum_periode.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code_car CodeTc,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode= @dcIdPeriodeMax				)  and
	( cum_periode.cod_etat  = 100		 				)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( groupe.id_grp		= @dcIdGrp					)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeTc.id_typ_code	= '-TC'						)  and
	( CodeTc.id_code	= cum_periode.id_type_carte			)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)

	

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S18_CUM_PERIODE
-- Auteur               :       JFF
-- Date                 :       20/01/99 11:45:00
-- Libellé              :       S‚lection sur CUM_PERIODE des refus‚s / type de carte et pour une banque
-- Commentaires         :	
-- Références           :       Utilis‚ sur : D_R_REF31
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)
--				@dcIdGrp	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S18_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S18_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S18_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 ),
	    @dcIdGrp	      Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_type_carte,
	CodeTc.lib_code,
	cum_periode.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code_car CodeTc,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  = 200		 				)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( groupe.id_grp		= @dcIdGrp					)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeTc.id_typ_code	= '-TC'						)  and
	( CodeTc.id_code	= cum_periode.id_type_carte			)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)

	

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S19_CUM_PERIODE
-- Auteur               :       JFF
-- Date                 :       20/01/99 11:48:00
-- Libellé              :       S‚lection sur CUM_PERIODE des sans suite / type de carte et pour une banque
-- Commentaires         :	
-- Références           :       Utilis‚ sur : D_R_SSU21
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--				@dcIdGrp	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S19_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S19_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S19_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 ),
	    @dcIdGrp	      Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_type_carte,
	CodeTc.lib_code,
	cum_periode.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_etat

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code_car CodeTc,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  >= 900		 				)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( groupe.id_grp		= @dcIdGrp					)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeTc.id_typ_code	= '-TC'						)  and
	( CodeTc.id_code	= cum_periode.id_type_carte			)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)

	

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S20_CUM_PERIODE
-- Auteur               :       JFF
-- Date                 :       20/01/99 11:55:00
-- Libellé              :       S‚lection sur CUM_PERIODE des d‚clar‚s / type de carte et pour une banque
-- Commentaires         :	
-- Références           :       Utilis‚ sur : D_R_OUV41
--
-- Arguments            :       @dcIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@dcIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--				@dcIdProd	   	Decimal ( 7,0 )     (Val)		
--				@dcIdGrp	   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S20_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S20_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S20_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 ),
            @dcIdProd         Decimal ( 7, 0 ),
	    @dcIdGrp	      Decimal ( 7, 0 )
AS

SELECT 
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_type_carte,
	CodeTc.lib_code,
	cum_periode.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_ouv

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code_car CodeTc,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod 	= @dcIdProd					)  and
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( groupe.id_grp		= @dcIdGrp					)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeTc.id_typ_code	= '-TC'						)  and
	( CodeTc.id_code	= cum_periode.id_type_carte			)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  and
	( cum_periode.cpt_ouv > 0						)

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_CUM_PERIODE
-- Auteur               :       DBI
-- Date                 :       08/12/1998
-- Libellé              :        
-- Commentaires         :       Insertion des enregistrements dans Cum_Periode … partir de stat_sin
-- Références           :       
--
-- Arguments            :       @dcIdPeriode    Decimal(7)		(Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_CUM_PERIODE' AND type = 'P' )
        DROP procedure sysadm.PS_I01_CUM_PERIODE
GO

CREATE procedure sysadm.PS_I01_CUM_PERIODE
		@dcIdPeriode    Decimal(7),
                @sCodOper       Varchar (  4   )

AS


SET NOCOUNT ON

Declare	@dtGetDate	Datetime
Declare	@sIdTypCarte	Varchar(3)
Declare @nIdPeriode	numeric

Set @nIdPeriode = convert ( numeric, @dcIdPeriode )


Declare @dcNbLance	Decimal(7,0),
	@dcIdCum	Decimal(7,0),
	@dcIdProd	Decimal(7,0),
	@dcIdGti	Decimal(7,0),
	@dcIdRgpt	Decimal(7,0),
	@dcIdCodEtat	Decimal(7,0),
	@dcIdExercice	Decimal(7,0),
	@dcIdEts	Decimal(7,0),
	@dcIdCie	Decimal(7),	
	@dcIdPolice	Decimal(7),
	@dcIdNatsin	Decimal(7,0),
	@dcSumCptEtat	Decimal(7),
	@dcSumCptOuv	Decimal(7),
	@dcSumCptReg	Decimal(7),
	@dcSumMtReg	Decimal(14,2),	
	@dcSumMtProv	Decimal(14,2)


Select @dcNbLance = Count (*)
From   sysadm.cum_periode
Where  id_periode = @nIdPeriode

Select @dtGetDate = GetDate ()

If ( @dcNbLance > 0 ) Return

--**********************************************************************
-- Recherche de la valeur suivante du compteur
--
--**********************************************************************

Select @dcIdCum = Max ( id_cum )
From   sysadm.cum_periode

--**********************************************************************
-- Dans les trois insert qui suivent j'exclus les id_gti < 0 ( -1 frais, -2 R‚guls )
-- Ces cas particuliers sont trait‚s … part
--
--**********************************************************************

--
-- Insertion des enregistrements pour lesquels on peut faire la jointure
-- sur la table garantie
--

Declare c_stat_sin cursor for
Select
 sinistre.id_prod,
 sinistre.id_type_carte,
 stat_sin.id_gti,
 stat_sin.id_rgpt,
 stat_sin.cod_etat,
 Convert ( decimal (7), DatePart ( year, sinistre.dte_surv )),
 sinistre.id_ets,
 police.id_cie,
 police.id_police,
 sinistre.id_natsin,
 Convert ( Decimal(7), sum ( stat_sin.cpt_etat )),
 Convert ( Decimal(7), sum ( stat_sin.cpt_ouv  )),
 Convert ( Decimal(7), sum ( stat_sin.cpt_reg  )),
 Convert ( Decimal(14,2), sum ( stat_sin.mt_reg   )),
 Convert ( Decimal(14,2), sum ( stat_sin.mt_prov  ))
From 
 sysadm.stat_sin,
 sysadm.sinistre,
 sysadm.garantie,
 sysadm.police
where
 stat_sin.id_sin    = sinistre.id_sin	And
 sinistre.id_prod   = garantie.id_prod	And
 stat_sin.id_gti    = garantie.id_gti	And
 garantie.id_rev    = sinistre.id_rev   And
 garantie.id_police = police.id_police  And
 sinistre.id_rev   <> -1		And
 stat_sin.id_gti    > 0			And
 stat_sin.id_periode= @nIdPeriode
group by
 sinistre.id_prod,
 sinistre.id_type_carte,
 stat_sin.id_gti,
 stat_sin.id_rgpt,
 stat_sin.cod_etat,
 Convert ( decimal (7), DatePart ( year, sinistre.dte_surv )),
 sinistre.id_ets,
 police.id_cie,
 police.id_police,
 sinistre.id_natsin
 
Open c_stat_sin

Fetch c_stat_sin into
 @dcIdProd,
 @sIdTypCarte,
 @dcIdGti,
 @dcIdRgpt,
 @dcIdCodEtat,
 @dcIdExercice,
 @dcIdEts,
 @dcIdCie,
 @dcIdPolice,
 @dcIdNatsin,
 @dcSumCptEtat,
 @dcSumCptOuv,
 @dcSumCptReg,
 @dcSumMtReg,
 @dcSumMtProv


While ( @@Fetch_status >= 0 )
Begin

	Select @dcIdCum = @dcIdCum + 1
	
	Insert into sysadm.cum_periode
	Values ( 
	 @dcIdCum,
	 @dcIdProd,
	 @nIdPeriode,
	 @sIdTypCarte,
	 @dcIdGti,
	 @dcIdRgpt,
	 @dcIdCodEtat,
	 @dcIdExercice,
	 @dcIdEts,
	 @dcIdCie,
	 @dcIdPolice,
	 @dcIdNatsin,
	 @dcSumCptEtat,
	 @dcSumCptOuv,
	 @dcSumCptReg,
	 @dcSumMtReg,
	 @dcSumMtProv,
	 @dtGetDate,
	 @dtGetDate,
	 @sCodOper )

	Fetch c_stat_sin into
	 @dcIdProd,
	 @sIdTypCarte,
	 @dcIdGti,
	 @dcIdRgpt,
	 @dcIdCodEtat,
	 @dcIdExercice,
	 @dcIdEts,
	 @dcIdCie,
	 @dcIdPolice,
	 @dcIdNatsin,
	 @dcSumCptEtat,
	 @dcSumCptOuv,
	 @dcSumCptReg,
	 @dcSumMtReg,
	 @dcSumMtProv

End

Close 		c_stat_sin
Deallocate 	c_stat_sin

--**********************************************************************
--
-- Insertion des enregistrements pour lesquels on ne peut pas faire la jointure
-- sur la table garantie, mais le produit possŠde une seule police
-- On peut donc ins‚rer tous les enregistrements avec cette police
--
--**********************************************************************


Declare c_stat_sin cursor for
Select
 sinistre.id_prod,
 sinistre.id_type_carte,
 stat_sin.id_gti,
 stat_sin.id_rgpt,
 stat_sin.cod_etat,
 Convert ( decimal (7), DatePart ( year, sinistre.dte_surv )),
 sinistre.id_ets,
 police.id_cie,
 police.id_police,
 sinistre.id_natsin,
 Convert ( Decimal(7), sum ( stat_sin.cpt_etat )),
 Convert ( Decimal(7), sum ( stat_sin.cpt_ouv  )),
 Convert ( Decimal(7), sum ( stat_sin.cpt_reg  )),
 Convert ( Decimal(14,2), sum ( stat_sin.mt_reg   )),
 Convert ( Decimal(14,2), sum ( stat_sin.mt_prov  ))
From 
 sysadm.stat_sin,
 sysadm.sinistre,
 sysadm.police,
 sysadm.produit
where
 stat_sin.id_sin    = sinistre.id_sin	And
 (
 ( sinistre.id_rev    = -1 ) 		Or
 ( not exists ( 
	Select id_prod 
	From   sysadm.garantie
	Where  garantie.id_prod = sinistre.id_prod 
	And    garantie.id_rev  = sinistre.id_rev 
	And    garantie.id_gti  = stat_sin.id_gti ) ) ) And
 sinistre.id_prod   = produit.id_prod	And
 produit.id_police  = police.id_police	And
 produit.id_police is not null		And
 stat_sin.id_gti    > 0			And
 stat_sin.id_periode= @nIdPeriode
group by
 sinistre.id_prod,
 sinistre.id_type_carte,
 stat_sin.id_gti,
 stat_sin.id_rgpt,
 stat_sin.cod_etat,
 Convert ( decimal (7), DatePart ( year, sinistre.dte_surv )),
 sinistre.id_ets,
 police.id_cie,
 police.id_police,
 sinistre.id_natsin

 
Open c_stat_sin

Fetch c_stat_sin into
 @dcIdProd,
 @sIdTypCarte,
 @dcIdGti,
 @dcIdRgpt,
 @dcIdCodEtat,
 @dcIdExercice,
 @dcIdEts,
 @dcIdCie,
 @dcIdPolice,
 @dcIdNatsin,
 @dcSumCptEtat,
 @dcSumCptOuv,
 @dcSumCptReg,
 @dcSumMtReg,
 @dcSumMtProv


While ( @@Fetch_status >= 0 )
Begin

	Select @dcIdCum = @dcIdCum + 1
	
	Insert into sysadm.cum_periode
	Values (
	 @dcIdCum,
	 @dcIdProd,
	 @nIdPeriode,
	 @sIdTypCarte,
	 @dcIdGti,
	 @dcIdRgpt,
	 @dcIdCodEtat,
	 @dcIdExercice,
	 @dcIdEts,
	 @dcIdCie,
	 @dcIdPolice,
	 @dcIdNatsin,
	 @dcSumCptEtat,
	 @dcSumCptOuv,
	 @dcSumCptReg,
	 @dcSumMtReg,
	 @dcSumMtProv,
	 @dtGetDate,
	 @dtGetDate,
	 @sCodOper )

	Fetch c_stat_sin into
	 @dcIdProd,
	 @sIdTypCarte,
	 @dcIdGti,
	 @dcIdRgpt,
	 @dcIdCodEtat,
	 @dcIdExercice,
	 @dcIdEts,
	 @dcIdCie,
	 @dcIdPolice,
	 @dcIdNatsin,
	 @dcSumCptEtat,
	 @dcSumCptOuv,
	 @dcSumCptReg,
	 @dcSumMtReg,
	 @dcSumMtProv

End

Close 		c_stat_sin
Deallocate 	c_stat_sin

--**********************************************************************
--
-- Insertion des enregistrements pour lesquels on ne peut pas faire la jointure
-- sur la table garantie, et le produit possŠde plusieurs polices
-- On insŠre les enregistrements avec un num‚ro de police 0 (Non d‚termin‚ )
--
--**********************************************************************


Declare c_stat_sin cursor for
Select
 sinistre.id_prod,
 sinistre.id_type_carte,
 stat_sin.id_gti,
 stat_sin.id_rgpt,
 stat_sin.cod_etat,
 Convert ( decimal (7), DatePart ( year, sinistre.dte_surv )),
 sinistre.id_ets,
 sinistre.id_natsin,
 Convert ( Decimal(7), sum ( stat_sin.cpt_etat )),
 Convert ( Decimal(7), sum ( stat_sin.cpt_ouv  )),
 Convert ( Decimal(7), sum ( stat_sin.cpt_reg  )),
 Convert ( Decimal(14,2), sum ( stat_sin.mt_reg   )),
 Convert ( Decimal(14,2), sum ( stat_sin.mt_prov  ))
From 
 sysadm.stat_sin,
 sysadm.sinistre,
 sysadm.produit
where
 stat_sin.id_sin    = sinistre.id_sin	And
 (
 ( sinistre.id_rev    = -1 ) 		Or
 ( not exists ( 
	Select id_prod 
	From   sysadm.garantie
	Where  garantie.id_prod = sinistre.id_prod 
	And    garantie.id_rev  = sinistre.id_rev 
	And    garantie.id_gti  = stat_sin.id_gti ) ) ) And
 sinistre.id_prod   = produit.id_prod	And
 produit.id_police is null		And
 stat_sin.id_gti    > 0			And
 stat_sin.id_periode= @nIdPeriode
group by
 sinistre.id_prod,
 sinistre.id_type_carte,
 stat_sin.id_gti,
 stat_sin.id_rgpt,
 stat_sin.cod_etat,
 Convert ( decimal (7), DatePart ( year, sinistre.dte_surv )),
 sinistre.id_ets,
 sinistre.id_natsin

 
Open c_stat_sin

Fetch c_stat_sin into
 @dcIdProd,
 @sIdTypCarte,
 @dcIdGti,
 @dcIdRgpt,
 @dcIdCodEtat,
 @dcIdExercice,
 @dcIdEts,
 @dcIdNatsin,
 @dcSumCptEtat,
 @dcSumCptOuv,
 @dcSumCptReg,
 @dcSumMtReg,
 @dcSumMtProv


While ( @@Fetch_status >= 0 )
Begin

	Select @dcIdCum = @dcIdCum + 1
	
	Insert into sysadm.cum_periode
	Values (
	 @dcIdCum,
	 @dcIdProd,
	 @nIdPeriode,
	 @sIdTypCarte,
	 @dcIdGti,
	 @dcIdRgpt,
	 @dcIdCodEtat,
	 @dcIdExercice,
	 @dcIdEts,
	 0,
	 0,
	 @dcIdNatsin,
	 @dcSumCptEtat,
	 @dcSumCptOuv,
	 @dcSumCptReg,
	 @dcSumMtReg,
	 @dcSumMtProv,
	 @dtGetDate,
	 @dtGetDate,
	 @sCodOper )

	Fetch c_stat_sin into
	 @dcIdProd,
	 @sIdTypCarte,
	 @dcIdGti,
	 @dcIdRgpt,
	 @dcIdCodEtat,
	 @dcIdExercice,
	 @dcIdEts,
	 @dcIdNatsin,
	 @dcSumCptEtat,
	 @dcSumCptOuv,
	 @dcSumCptReg,
	 @dcSumMtReg,
	 @dcSumMtProv

End

Close 		c_stat_sin
Deallocate 	c_stat_sin

 
--**********************************************************************
-- Insertion des frais et des r‚guls pour les produits avec une seule police
--
--
--**********************************************************************

Declare c_stat_sin cursor for
Select
 sinistre.id_prod,
 sinistre.id_type_carte,
 stat_sin.id_gti,
 Case stat_sin.id_gti
  When -1 Then Convert ( decimal (7), -1 )
  Else stat_sin.id_rgpt
 End,
 stat_sin.cod_etat,
 Convert ( decimal (7), DatePart ( year, sinistre.dte_surv )),
 sinistre.id_ets,
 police.id_cie,
 police.id_police,
 sinistre.id_natsin,
 Convert ( Decimal(7), sum ( stat_sin.cpt_etat )),
 Convert ( Decimal(7), sum ( stat_sin.cpt_ouv  )),
 Convert ( Decimal(7), sum ( stat_sin.cpt_reg  )),
 Convert ( Decimal(14,2), sum ( stat_sin.mt_reg   )),
 Convert ( Decimal(14,2), sum ( stat_sin.mt_prov  ))
From 
 sysadm.stat_sin,
 sysadm.sinistre,
 sysadm.police,
 sysadm.produit
where
 stat_sin.id_sin    = sinistre.id_sin	And
 sinistre.id_prod   = produit.id_prod	And
 produit.id_police  = police.id_police	And
 produit.id_police is not null		And
 stat_sin.id_gti    < 0			And
 stat_sin.id_periode= @nIdPeriode
group by
 sinistre.id_prod,
 sinistre.id_type_carte,
 stat_sin.id_gti,
 stat_sin.id_rgpt,
 stat_sin.cod_etat,
 Convert ( decimal (7), DatePart ( year, sinistre.dte_surv )),
 sinistre.id_ets,
 police.id_cie,
 police.id_police,
 sinistre.id_natsin
 
Open c_stat_sin

Fetch c_stat_sin into
 @dcIdProd,
 @sIdTypCarte,
 @dcIdGti,
 @dcIdRgpt,
 @dcIdCodEtat,
 @dcIdExercice,
 @dcIdEts,
 @dcIdCie,
 @dcIdPolice,
 @dcIdNatsin,
 @dcSumCptEtat,
 @dcSumCptOuv,
 @dcSumCptReg,
 @dcSumMtReg,
 @dcSumMtProv


While ( @@Fetch_status >= 0 )
Begin

	Select @dcIdCum = @dcIdCum + 1
	
	Insert into sysadm.cum_periode
	Values (
	 @dcIdCum,
	 @dcIdProd,
	 @nIdPeriode,
	 @sIdTypCarte,
	 @dcIdGti,
	 @dcIdRgpt,
	 @dcIdCodEtat,
	 @dcIdExercice,
	 @dcIdEts,
	 @dcIdCie,
	 @dcIdPolice,
	 @dcIdNatsin,
	 @dcSumCptEtat,
	 @dcSumCptOuv,
	 @dcSumCptReg,
	 @dcSumMtReg,
	 @dcSumMtProv,
	 @dtGetDate,
	 @dtGetDate,
	 @sCodOper )

	Fetch c_stat_sin into
	 @dcIdProd,
	 @sIdTypCarte,
	 @dcIdGti,
	 @dcIdRgpt,
	 @dcIdCodEtat,
	 @dcIdExercice,
	 @dcIdEts,
	 @dcIdCie,
	 @dcIdPolice,
	 @dcIdNatsin,
	 @dcSumCptEtat,
	 @dcSumCptOuv,
	 @dcSumCptReg,
	 @dcSumMtReg,
	 @dcSumMtProv

End

Close 		c_stat_sin
Deallocate 	c_stat_sin


--**********************************************************************
-- Insertion des frais et des r‚guls pour les produits avec plusieurs polices
-- Si on ne peut pas d‚terminer la police elle reste … 0
--
--**********************************************************************
Create table #aa
 ( id_prod decimal (7,0),
   id_rev  decimal (7,0),
   id_police decimal (7,0) )

Insert into #aa
Select 
 id_prod,
 id_rev,
 Min ( id_police )
From 
 sysadm.garantie
Group by
 id_prod,
 id_rev

Declare c_stat_sin cursor for
Select
 sinistre.id_prod,
 sinistre.id_type_carte,
 stat_sin.id_gti,
 Case stat_sin.id_gti
  When -1 Then Convert ( Decimal(7), -1 )
  Else stat_sin.id_rgpt
 End,
 stat_sin.cod_etat,
 Convert ( decimal (7), DatePart ( year, sinistre.dte_surv )),
 sinistre.id_ets,
 Convert ( decimal(7), 0),
 #aa.id_police,
 sinistre.id_natsin,
 Convert ( Decimal(7), sum ( stat_sin.cpt_etat )),
 Convert ( Decimal(7), sum ( stat_sin.cpt_ouv  )),
 Convert ( Decimal(7), sum ( stat_sin.cpt_reg  )),
 Convert ( Decimal(14,2), sum ( stat_sin.mt_reg   )),
 Convert ( Decimal(14,2), sum ( stat_sin.mt_prov  ))
From 
 sysadm.stat_sin,
 sysadm.produit,
 sysadm.sinistre,
 #aa
where
 stat_sin.id_sin    = sinistre.id_sin	 And
 sinistre.id_prod   = produit.id_prod	 And
 produit.id_police is null		 And
 stat_sin.id_gti    < 0			 And
 #aa.id_prod	    = sinistre.id_prod   And
 #aa.id_rev	    = sinistre.id_rev    And
 stat_sin.id_periode= @nIdPeriode
group by
 sinistre.id_prod,
 sinistre.id_type_carte,
 stat_sin.id_gti,
 stat_sin.id_rgpt,
 stat_sin.cod_etat,
 Convert ( decimal (7), DatePart ( year, sinistre.dte_surv )),
 sinistre.id_ets,
 #aa.id_police,
 sinistre.id_natsin
 
Open c_stat_sin

Fetch c_stat_sin into
 @dcIdProd,
 @sIdTypCarte,
 @dcIdGti,
 @dcIdRgpt,
 @dcIdCodEtat,
 @dcIdExercice,
 @dcIdEts,
 @dcIdCie,
 @dcIdPolice,
 @dcIdNatsin,
 @dcSumCptEtat,
 @dcSumCptOuv,
 @dcSumCptReg,
 @dcSumMtReg,
 @dcSumMtProv


While ( @@Fetch_status >= 0 )
Begin

	Select @dcIdCum = @dcIdCum + 1
	
	Insert into sysadm.cum_periode
	Values (
	 @dcIdCum,
	 @dcIdProd,
	 @nIdPeriode,
	 @sIdTypCarte,
	 @dcIdGti,
	 @dcIdRgpt,
	 @dcIdCodEtat,
	 @dcIdExercice,
	 @dcIdEts,
	 @dcIdCie,
	 @dcIdPolice,
	 @dcIdNatsin,
	 @dcSumCptEtat,
	 @dcSumCptOuv,
	 @dcSumCptReg,
	 @dcSumMtReg,
	 @dcSumMtProv,
	 @dtGetDate,
	 @dtGetDate,
	 @sCodOper )

	Fetch c_stat_sin into
	 @dcIdProd,
	 @sIdTypCarte,
	 @dcIdGti,
	 @dcIdRgpt,
	 @dcIdCodEtat,
	 @dcIdExercice,
	 @dcIdEts,
	 @dcIdCie,
	 @dcIdPolice,
	 @dcIdNatsin,
	 @dcSumCptEtat,
	 @dcSumCptOuv,
	 @dcSumCptReg,
	 @dcSumMtReg,
	 @dcSumMtProv

End

Close 		c_stat_sin
Deallocate 	c_stat_sin

Drop table #aa

--**********************************************************************
-- Mise … jour des id_cie pour les id_police trouv‚s si dessus
--
--**********************************************************************

Update  sysadm.cum_periode
set     id_cie = police.id_cie
from    sysadm.police, sysadm.cum_periode
where   cum_periode.id_police =  police.id_police 
And     cum_periode.id_police <>  0
And     cum_periode.id_cie    =   0

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S21_CUM_PERIODE
-- Auteur               :       FABRY JF
-- Date                 :       10/10/2003
-- Libellé              :       Sélection sur CUM_PERIODE des dossiers réglés et en cours de règlement
--				Copie du DW_S01_CUM_PERIODE mais pour tous les produit en dur du comptes AIG (DCMP 030444/DTA/V. MALO)
-- Commentaires         :	Les tris seront fait sur le client (la DW), afin de soulager le serveur
-- Références           :       Utilisé dans la Dw : D_R_REG7
--
--				
--
-- Arguments            :       @nIdPeriodeMin   	Decimal ( 7,0 )     (Val)
--				@nIdPeriodeMax   	Decimal ( 7,0 )     (Val)		
--
-- Retourne             :	Rien
--
-- JFF	07/04/2014	ITSM207681
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S21_CUM_PERIODE' AND type = 'P' )
            DROP procedure sysadm.DW_S21_CUM_PERIODE
GO

CREATE PROC sysadm.DW_S21_CUM_PERIODE
            @dcIdPeriodeMin   Decimal ( 7, 0 ),
            @dcIdPeriodeMax   Decimal ( 7, 0 )
AS

-- ITSM207681 Nouvelle requête

Declare @dtDteDeb Datetime
Declare @dtDteFin Datetime

Set @dtDteDeb = '01/' + SUBSTRING ( CONVERT ( VarChar ( 10 ), @dcIdPeriodeMin), 5, 2 ) + '/' + LEFT ( CONVERT ( VarChar ( 10 ), @dcIdPeriodeMin), 4 ) 
Select @dtDteDeb = DATEADD ( month, -1, @dtDteDeb )
Select @dtDteDeb = DATEADD ( day, 25, @dtDteDeb )

Set @dtDteFin = '01/' + SUBSTRING ( CONVERT ( VarChar ( 10 ), @dcIdPeriodeMin), 5, 2 ) + '/' + LEFT ( CONVERT ( VarChar ( 10 ), @dcIdPeriodeMin), 4 ) + ' 23:59'
Select @dtDteFin = DATEADD ( day, 24, @dtDteFin ) 

Select T.Periode_Min,
	   T.Periode_Max,
	   T.lib_produit,
	   T.lib_dept,
	   T.Exercice Exercice,
	   T.id_rgpt id_rgpt,
	   T.lib_rgpt,
	   T.id_grp id_grp,
	   T.lib_grp,
	   T.id_cie,
	   T.lib_cie,
	   T.id_police,
	   T.lib_police,
	   T.id_natsin,
	   T.lib_natsin,
	   0 cpt_reg,
	   SUM ( T.mt_reg) mt_reg
From ( 
	Select @dcIdPeriodeMin 'Periode_Min',
		   @dcIdPeriodeMax 'Periode_Max',
		   s.id_prod,
		   p.lib_long  'lib_produit',
		   d.lib_dept  'lib_dept',
		   YEAR ( s.dte_surv ) 'Exercice',
		   rg.id_rgpt,
		   sysadm.FN_CODE_NUM ( rg.id_rgpt, '-GS' ) 'lib_rgpt',
		   p.id_grp,
		   gr.lib_grp,
		   cie.id_cie,
		   cie.lib_cie,
		   po.id_police,
		   po.lib_police,
		   s.id_natsin,
		   sysadm.FN_CODE_NUM ( s.id_natsin, '+NS' ) 'lib_natsin',
		   rg.mt_reg 
		   
	From   sysadm.sinistre s,
		   sysadm.reglement r,
		   sysadm.reg_gti rg,	   
		   sysadm.produit p,
		   sysadm.garantie ga,
		   sysadm.police po,
		   sysadm.compagnie cie,
		   sysadm.departement d,
		   sysadm.groupe gr
	Where  p.rib_bq	= '30002'
	And    p.rib_gui = '06522'
	And    p.rib_cpt = '0000061704E'
	And    p.rib_cle = '94'
	And    d.id_dept = p.id_dept
	And    gr.id_grp = p.id_grp
	And    s.id_prod = p.id_prod
	And    r.id_sin = s.id_sin
	And    r.valide_le between @dtDteDeb AND @dtDteFin
	And    rg.id_sin = r.id_sin
	And    rg.id_reg = r.id_reg
	And    ga.id_prod = s.id_prod
	And    ga.id_rev = s.id_rev
	And    ga.id_gti = ( IsNull ( nullif ( rg.id_gti, -1 ), 
									(Select top 1 ga1.id_gti
									 From   sysadm.garantie ga1
									 Where  ga1.id_prod = s.id_prod
									 And	ga1.id_rev = s.id_rev)
								)
						)
	And    po.id_police = ga.id_police
	And    cie.id_cie = po.id_cie
    And    r.cod_mot_reg IN ( 'RN', 'RM', 'RP' ) 
    And    r.cod_mode_reg IN ( 'VA', 'VM', 'C', 'FM', 'BX', 'VV' ) 
) as T

Group by 
	   T.Periode_Min,
	   T.Periode_Max,
	   T.lib_produit,
	   T.lib_dept,
	   T.Exercice,
	   T.id_rgpt,
	   T.lib_rgpt,
	   T.id_grp,
	   T.lib_grp,
	   T.id_cie,
	   T.lib_cie,
	   T.id_police,
	   T.lib_police,
	   T.id_natsin,
	   T.lib_natsin

order by T.lib_produit, 
		 T.Exercice,
		 T.id_rgpt


/* ITSM207681
SELECT  @dcIdPeriodeMin as Periode_Min,
	@dcIdPeriodeMax as Periode_Max,
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	cum_periode.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_reg,
	cum_periode.mt_reg

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod   = produit.id_prod				)  and
	( produit.rib_bq	= '30002'					)  and  -- Compte dédié AIG
	( produit.rib_gui	= '06522'					)  and 
	( produit.rib_cpt	= '0000061704E'					)  and 
	( produit.rib_cle	= '94'						)  and 
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  in ( 550, 600 ) 				)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	= '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( cum_periode.id_grp	= groupe.id_grp					)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				)  
	
UNION ALL
	
SELECT 
	@dcIdPeriodeMin as Periode_Min,
	@dcIdPeriodeMax as Periode_Max,
	produit.lib_long as lib_produit,
	departement.lib_dept,
	cum_periode.id_exercice,
	cum_periode.id_rgpt,
	CodeRgpt.lib_code as lib_rgpt,
	groupe.id_grp,
	groupe.lib_grp,
	cum_periode.id_cie,
	compagnie.lib_cie,
	cum_periode.id_police,
	police.lib_police,
	cum_periode.id_natsin,
	CodeNatSin.lib_code as lib_natsin,
	cum_periode.cpt_reg,
	cum_periode.mt_reg

FROM  	sysadm.cum_periode, 
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.etablissement,
	sysadm.departement,
	sysadm.code CodeRgpt,
	sysadm.code CodeNatSin

WHERE 	( cum_periode.id_prod   = produit.id_prod				)  and
	( produit.rib_bq	= '30002'					)  and  -- Compte dédié AIG
	( produit.rib_gui	= '06522'					)  and 
	( produit.rib_cpt	= '0000061704E'					)  and 
	( produit.rib_cle	= '94'						)  and 
	( cum_periode.id_periode  between @dcIdPeriodeMin and @dcIdPeriodeMax	)  and
	( cum_periode.cod_etat  in ( 550, 600 ) 				)  and	
	( produit.id_prod	= cum_periode.id_prod				)  and
	( produit.cod_adh	<> '3'						)  and
	( compagnie.id_cie	= cum_periode.id_cie				)  and
	( police.id_police	= cum_periode.id_police				)  and
	( etablissement.id_prod = cum_periode.id_prod				)  and
	( etablissement.id_ets  = cum_periode.id_grp				)  and
	( etablissement.id_grp  = groupe.id_grp					)  and
	( etablissement.id_rev  = -1						)  and
	( departement.id_dept	= produit.id_dept				)  and
	( CodeNatSin.id_typ_code= '+NS'						)  and
	( CodeNatSin.id_code	= cum_periode.id_natsin				)  and
	( CodeRgpt.id_typ_code	= '-GS'						)  and
	( CodeRgpt.id_code	= cum_periode.id_rgpt				) 	
*/

GO

