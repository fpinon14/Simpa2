-------------------------------------------------------------------
--
-- Fichier              :       ARTICLE.CP
-- Auteur               :       FABRY JF
-- Date                 :       31/08/2001
--
-- Commentaires         :       Table ARTICLE
--
-- Procedures           :       DW_S01_ARTICLE
--                              DW_S02_ARTICLE
--				DW_S03_ARTICLE
--				DW_S04_ARTICLE
--				DW_S05_ARTICLE   [ALAPAGE]
--				PS_U01_ARTICLE
--				PS_U02_ARTICLE
--				PS_U03_ARTICLE
--				PS_U04_ARTICLE  [SITE_CMDE] en fait c'est PS_U03_ARTICLE adaptée pour le Web
--				PS_U05_ARTICLE  [SITE_CMDE] en fait c'est PS_U02_ARTICLE adaptée pour le Web
--				DW_D01_ARTICLE
--				TR_ARTICLE_01
--				PS_D01_ARTICLE_ALAPAGE [ALAPAGE]
--				PS_S01_ARTICLE_ALAPAGE [ALAPAGE]
--				PS_D01_ARTICLE_CDISCOUNTPRO [DCMP090102]
--				PS_D01_ARTICLE_ACUBE
--				PS_S01_ARTICLE_DP150
--				DW_S06_ARTICLE
----------------------------------------------------------------


--------------------------------------------------------------------
--
-- Procedure            :       DW_S01_ARTICLE
-- Auteur               :       FABRY JF
-- Date                 :       31/08/2001
-- Libelle              :        
-- Commentaires         :       Select sur la table ARTICLE
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- 
-- JFF	13/02/2013	[VDOC10307]
-- FPI  06/03/2013	[ITSM148817]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_ARTICLE
GO
CREATE procedure sysadm.DW_S01_ARTICLE
        @sIdFour	VarChar ( 3 ),
        @sIdTypArt	VarChar ( 20 )
AS

Select 	id_four,
	id_ref_four,
	id_typ_art,
	id_marq_art,
	id_modl_art,
	mt_prix_ht,
	tva,
	qt_disp,
	observ_frn,
	alt_dispo,
	id_marq_art_ifr,
	id_modl_art_ifr,
	cod_etat,
	verrou,
	cree_le,
	maj_le,
	maj_par

From	sysadm.article
Where 	( id_four = @sIdFour Or @sIdFour = '*' )
And     ( id_typ_art = @sIdTypArt Or @sIdTypArt = '*' )
And id_typ_art Not in ( 'EDI', 'PRS', 'ALE', 'ACC', 'BAM', 'PCM','DEV','CAF','MAI','PCM','SMS','AEF', 'RST', 'PST', 'RES', 'REA' ) 

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_U01_ARTICLE
-- Auteur               :       FABRY JF
-- Date                 :       31/08/2001
-- Libelle              :        
-- Commentaires         :       Select sur la table ARTICLE
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.PS_U01_ARTICLE
GO

CREATE procedure sysadm.PS_U01_ARTICLE
	@sIdFour	VarChar ( 3 )        
AS
Update sysadm.article
Set sysadm.article.verrou = sysadm.article.verrou * (-1)
Where ( id_four = @sIdFour Or @sIdFour = '*' )
GO


--------------------------------------------------------------------
--
-- Procedure            :       DW_S02_ARTICLE
-- Auteur               :       FABRY JF
-- Date                 :       31/08/2001
-- Libelle              :        
-- Commentaires         :       Select sur la table ARTICLE pour commander
--				1 select pour CEG union 1 select pour les autres fournisseurs
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-- Details du select 	:	Choix par coche		'N',
--							id_four,                        
--							id_ref_four,                    
--							id_typ_art,                     
--							id_marq_art,                    
--							id_modl_art,                    
--							mt_prix_ht,                     
--							tva,                            
--							qt_disp,                        
--							observ_frn,
--				Ancien nø de s‚rie	null,				
--				ProblŠme		null,
--				Plafond (Gti ou Det)	0,
--				Haut Maxi du Detail	'O'
--				** Modif SFR **
--							id_orian_marque
--							id_orian_modele
--				Gamme			E,M,H,T ou ''
--				Appartenance au cat	'CAT' ou null
-- JFF		10/08/2012	 [RECUPDONN_MANTIS4252] ajout PCM dans le shunt
-- JFF		16/08/2012	 [ITSM126662] ajout CAF dans le Shunt
-- JFF      14/11/2012   [VDOC9376]
-- JFF      07/05/2013   [PC938_ORANGE_V3]
-- JFF      06/01/2015   [DT124]
-- JFF      02/03/2015   [PM289_CDP]
-- JFF      18/12/2018   [PM471-1] V02
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_ARTICLE_V02' AND type = 'P' )
        DROP procedure sysadm.DW_S02_ARTICLE_V02
GO

CREATE PROCEDURE [sysadm].[DW_S02_ARTICLE_V02]
    @dcIdProd DECIMAL(7, 0),
    @sChaine VARCHAR(255) -- [DT124]
AS -- CEG (SFR)

Declare @iPos Integer
Declare @sFiltreRecNeu VARCHAR(50)
Declare @sMarq VarChar ( 50 )
Declare @sModl VarChar ( 50 )
Declare @iClasse Integer
Declare @iGrade Integer
Declare @sFiltre VARCHAR(50)
Declare @sClasse VARCHAR(50)
Declare @sGrade VARCHAR(50)
Declare @sRestrAss VARCHAR(50)

Set @sFiltre = sysadm.FN_CLE_VAL ( 'CHOIX_PACK', @sChaine, ';') 
If @sFiltre = '' Set @sFiltre = null

Set @sFiltreRecNeu = sysadm.FN_CLE_VAL ( 'NEUF_REC', @sChaine, ';') 
If @sFiltreRecNeu = '' Set @sFiltreRecNeu = null

-- [DT124]
Set @sMarq = sysadm.FN_CLE_VAL ( 'MARQUE', @sChaine, ';' )
Set @sModl = sysadm.FN_CLE_VAL ( 'MODELE', @sChaine, ';' )

-- [PC694-5]
Set @sClasse = sysadm.FN_CLE_VAL ( 'CHOIX_PACK', @sChaine, ';' )
Set @iPos  = CHARINDEX( '[#CM', @sClasse, 1)
Set @iClasse = -1
If  @iPos  > 0 
 Begin
  Set @iClasse = SUBSTRING ( @sClasse, @iPos + 4, 1 )
 End 

-- [PM471-1]
Set @sGrade = sysadm.FN_CLE_VAL ( 'CHOIX_GRADE', @sChaine, ';' )
If @sGrade = '' Set @sGrade = null
Set @iPos  = CHARINDEX( '[#GR#', @sGrade, 1)
Set @iGrade = -1
If  @iPos  > 0 
 Begin
  Set @iGrade = SUBSTRING ( @sGrade, @iPos + 5, 1 )
 End 

    SELECT  'N',
            a.id_four,
            a.id_ref_four,
            a.id_typ_art,
            CASE WHEN a.id_marq_art = 'PRESTATION SUR TELEPHONE' THEN ''
                 ELSE a.id_marq_art
            END 'id_marq_art',
            CASE WHEN a.id_modl_art = 'PRESTATION SUR TELEPHONE' THEN ''
                 ELSE a.id_modl_art
            END 'id_modl_art',
            a.mt_prix_ht,
            a.tva,
            a.qt_disp,
            a.observ_frn  'observ_frn',
            '',
            '',
            0,
            'N',
            ( select da.id_typ_art
              From   sysadm.det_article da
              Where  da.id_four = a.id_four
              And    da.id_ref_four = a.id_ref_four
              And    da.id_prod = @dcIdProd
            ) id_typ_art,
            NULL,
            'N',
            ( ISNULL(( SELECT   i.marque
                       FROM     sysadm.ifr i
                       WHERE    i.marque = a.id_marq_art_ifr
                                AND i.reference = a.id_modl_art_ifr
                                AND i.id_trait = ( SELECT   MAX(i2.id_trait)
                                                   FROM     sysadm.ifr i2
                                                   WHERE    i2.marque = i.marque
                                                            AND i2.reference = i.reference
                                                 )
                     ), a.id_marq_art) ) id_marque_ifr,
            ( ISNULL(( SELECT   ISNULL(i.reference, '')
                       FROM     sysadm.ifr i
                       WHERE    i.marque = a.id_marq_art_ifr
                                AND i.reference = a.id_modl_art_ifr
                                AND i.id_trait = ( SELECT   MAX(i2.id_trait)
                                                   FROM     sysadm.ifr i2
                                                   WHERE    i2.marque = i.marque
                                                            AND i2.reference = i.reference
                                                 )
                     ), CASE a.id_typ_art
                          WHEN 'TEL' THEN ''
                          ELSE a.id_modl_art
                        END) ) id_modele_ifr,
            ( SELECT    i.frequence
              FROM      sysadm.ifr i
              WHERE     i.marque = a.id_marq_art_ifr
                        AND i.reference = a.id_modl_art_ifr
                        AND i.id_trait = ( SELECT   MAX(i2.id_trait)
                                           FROM     sysadm.ifr i2
                                           WHERE    i2.marque = i.marque
                                                    AND i2.reference = i.reference
                                         )
            ) mt_prix_ifr
    FROM    sysadm.article a,
            ( SELECT DISTINCT
                        commande_type.id_code_frn,
                        commande_type.id_code_art
              FROM      sysadm.commande_type
              WHERE     commande_type.id_prod = @dcIdProd
                        AND commande_type.id_code_art <> '-1'
            ) AS FrnDistinct 
    WHERE   a.id_four = 'CEG'
            And a.id_four = FrnDistinct.id_code_frn
            And a.id_typ_art = FrnDistinct.id_code_art
            AND a.alt_dispo = 'O'
            AND ( a.id_marq_art_ifr IS NOT NULL
                  OR a.id_typ_art <> 'TEL'
                )
            AND ( a.id_modl_art_ifr IS NOT NULL
                  OR a.id_typ_art <> 'TEL'
                )
            AND ( EXISTS ( SELECT   *
                           FROM     sysadm.ifr i
                           WHERE    i.marque = a.id_marq_art_ifr
                                    AND i.reference = a.id_modl_art_ifr )
                  OR a.id_typ_art <> 'TEL'
                  OR a.id_four IN ( 'WBA' )  -- [SITE_CMDE]
                )
            AND ( @sFiltre IS NULL
                  OR a.id_typ_art in ('PRS', 'EDI', 'PCM', 'CAF', 'DEV', 'REL', 'RST', 'PST', 'RES', 'REA' ) -- [RECUPDONN_MANTIS4252] --[ITSM126662] -- [PC938_ORANGE_V3]
                  OR CHARINDEX(@sFiltre, a.observ_frn, 1) > 0
                  OR ( CHARINDEX( '[#CM', @sFiltre, 1) > 0 
					   And a.id_marq_art_ifr = @sMarq 
					   And a.id_modl_art_ifr = @sModl
					   And CharIndex ( '[#CM', a.observ_frn ) > 0 					   
					 ) -- [DT124]
				  -- [PC694-5]
				  OR( CHARINDEX ( '[#CM', a.observ_frn ) > 0 And 
					  ( 
						Isnull ( 
							Nullif ( 
								Convert ( 
									Integer ,
										IsNull (  
												Nullif ( 
													IsNumeric ( Substring (a.observ_frn, CHARINDEX ( '[#CM', a.observ_frn ) + 4, 1 )),
													1),
													Substring (a.observ_frn, CHARINDEX ( '[#CM', a.observ_frn ) + 4, 1 )
												)
									),
								0 ),
								100 ) 
						) <= @iClasse
					 )
				  -- [PC694-5]
                  OR a.id_four IN ( 'WBA' )  -- [SITE_CMDE]                				
                )  -- DCMP 060480

            AND ( @sFiltreRecNeu IS NULL
				  OR ( @sFiltreRecNeu = '[#NEU#]' And CHARINDEX('[#REC#]', a.observ_frn, 1) <= 0 )
				  OR a.id_typ_art in ('PRS', 'EDI', 'PCM', 'CAF', 'DEV', 'REL', 'RST', 'PST', 'RES', 'REA' ) -- [RECUPDONN_MANTIS4252] --[ITSM126662]    -- [PC938_ORANGE_V3]               
				  OR CHARINDEX(@sFiltreRecNeu, a.observ_frn, 1) > 0
				  OR a.id_four IN ( 'WBA' )  -- [SITE_CMDE]                				
				) -- [VDOC9376]

			And ( @sGrade IS NULL
				  OR CHARINDEX('[#REC#]', a.observ_frn ) <= 0 -- On n'exploite le grade que pour un appareil tagué du REC
				  OR a.id_typ_art in ('PRS', 'EDI', 'PCM', 'CAF', 'DEV', 'REL', 'RST', 'PST', 'RES', 'REA' )
				  Or ( CHARINDEX ( '[#GR#', a.observ_frn ) > 0 And 
					  ( 
						Isnull ( 
							Nullif ( 
								Convert ( 
									Integer ,
										IsNull (  
												Nullif ( 
													IsNumeric ( Substring (a.observ_frn, CHARINDEX ( '[#GR#', a.observ_frn ) + 5, 1 )),
													1),
													Convert ( integer, Substring (a.observ_frn, CHARINDEX ( '[#GR#', a.observ_frn ) + 5, 1 )) + 1 -- pour gérer le grade 0 qui prose problème avec le 0 du isnumeric
												)
									),
								0 ),
								100 ) -1  -- pour gérer le grade 0 qui prose problème avec le 0 du isnumeric 
						) <= @iGrade
					  )
				) -- [PM471-1]
                
    UNION ALL  -- Autre (stantdard)
    SELECT  'N',
            a.id_four,
            a.id_ref_four,
            a.id_typ_art,
            CASE WHEN a.id_marq_art = 'PRESTATION SUR TELEPHONE' THEN ''
                 ELSE a.id_marq_art
            END,
            CASE WHEN a.id_modl_art = 'PRESTATION SUR TELEPHONE' THEN ''
                 ELSE a.id_modl_art
            END,
            a.mt_prix_ht,
            a.tva,
            CASE WHEN a.id_four = 'ANV'
                      AND a.qt_disp <= 2 THEN 0
                 ELSE a.qt_disp
            END 'qt_disp',
            a.observ_frn  'observ_frn',
            '',
            '',
            0,
            'N',
            NULL,
            NULL,
            'N',
            ( ISNULL(( SELECT   i.marque
                       FROM     sysadm.ifr i
                       WHERE    i.marque = a.id_marq_art_ifr
                                AND i.reference = a.id_modl_art_ifr
                                AND i.id_trait = ( SELECT   MAX(i2.id_trait)
                                                   FROM     sysadm.ifr i2
                                                   WHERE    i2.marque = i.marque
                                                            AND i2.reference = i.reference
                                                 )
                     ), a.id_marq_art) ) id_marque_ifr,
            ( ISNULL(( SELECT   ISNULL(i.reference, '')
                       FROM     sysadm.ifr i
                       WHERE    i.marque = a.id_marq_art_ifr
                                AND i.reference = a.id_modl_art_ifr
                                AND i.id_trait = ( SELECT   MAX(i2.id_trait)
                                                   FROM     sysadm.ifr i2
                                                   WHERE    i2.marque = i.marque
                                                            AND i2.reference = i.reference
                                                 )
                     ), CASE a.id_typ_art
                          WHEN 'TEL' THEN ''
                          ELSE a.id_modl_art
                        END) ) id_modele_ifr,
            ( SELECT    i.frequence
              FROM      sysadm.ifr i
              WHERE     i.marque = a.id_marq_art_ifr
                        AND i.reference = a.id_modl_art_ifr
                        AND i.id_trait = ( SELECT   MAX(i2.id_trait)
                                           FROM     sysadm.ifr i2
                                           WHERE    i2.marque = i.marque
                                                    AND i2.reference = i.reference
                                         )
            ) mt_prix_ifr
    FROM    sysadm.article a,
            ( SELECT DISTINCT
                        commande_type.id_code_frn,
                        commande_type.id_code_art
              FROM      sysadm.commande_type
              WHERE     commande_type.id_prod = @dcIdProd
                        AND commande_type.id_code_art <> '-1'
            ) AS FrnDistinct
    WHERE   a.id_four NOT IN ( 'CEG', 'CDA' )  -- [PM289_CDP]
            AND a.id_four = FrnDistinct.id_code_frn
            AND a.id_typ_art = FrnDistinct.id_code_art
            AND a.alt_dispo = 'O'
            AND ( a.id_marq_art_ifr IS NOT NULL
                  OR a.id_typ_art <> 'TEL'
                )
            AND ( a.id_modl_art_ifr IS NOT NULL
                  OR a.id_typ_art <> 'TEL'
                )
            AND ( EXISTS ( SELECT   *
                           FROM     sysadm.ifr i
                           WHERE    i.marque = a.id_marq_art_ifr
                                    AND i.reference = a.id_modl_art_ifr )
                  OR a.id_typ_art <> 'TEL'
                  OR a.id_four IN ( 'WBA' )  -- [SITE_CMDE]                
                )
            AND ( @sFiltre IS NULL
                  OR a.id_typ_art in ('PRS', 'EDI', 'PCM', 'CAF', 'DEV', 'REL', 'RST', 'PST', 'RES', 'REA'  ) -- [RECUPDONN_MANTIS4252] [ITSM126662]-- [PC938_ORANGE_V3]
                  OR CHARINDEX(@sFiltre, a.observ_frn, 1) > 0
                  OR a.id_four IN ( 'WBA' )  -- [SITE_CMDE]                				
                  OR ( CHARINDEX( '[#CM', @sFiltre, 1) > 0 
					   And a.id_marq_art_ifr = @sMarq 
					   And a.id_modl_art_ifr = @sModl
					   And CharIndex ( '[#CM', a.observ_frn ) > 0 
					 ) -- [DT124] 
				  -- [PC694-5]
				  OR( CHARINDEX ( '[#CM', a.observ_frn ) > 0 And 
						 ( 
							Isnull ( 
								Nullif ( 
									Convert ( 
										Integer ,
											IsNull (  
													Nullif ( 
														IsNumeric ( Substring (a.observ_frn, CHARINDEX ( '[#CM', a.observ_frn ) + 4, 1 )),
														1),
														Substring (a.observ_frn, CHARINDEX ( '[#CM', a.observ_frn ) + 4, 1 )
												   )
										),
									0 ),
									100 ) 
						 ) <= @iClasse
					 )
				  -- [PC694-5]					                 
                )  -- DCMP 060480
            AND ( @sFiltreRecNeu IS NULL
				  OR ( @sFiltreRecNeu = '[#NEU#]' And CHARINDEX('[#REC#]', a.observ_frn, 1) <= 0 )
				  OR a.id_typ_art in ('PRS', 'EDI', 'PCM', 'CAF', 'DEV', 'REL', 'RST', 'PST', 'RES', 'REA' ) -- [RECUPDONN_MANTIS4252] --[ITSM126662]  -- [PC938_ORANGE_V3]                
				  OR CHARINDEX(@sFiltreRecNeu, a.observ_frn, 1) > 0
				  OR a.id_four IN ( 'WBA' )  -- [SITE_CMDE]                				
				) -- [VDOC9376]

			And ( @sGrade IS NULL
				  OR CHARINDEX('[#REC#]', a.observ_frn ) <= 0 -- On n'exploite le grade que pour un appareil tagué du REC
				  OR a.id_typ_art in ('PRS', 'EDI', 'PCM', 'CAF', 'DEV', 'REL', 'RST', 'PST', 'RES', 'REA' )
				  Or ( CHARINDEX ( '[#GR#', a.observ_frn ) > 0 And 
					  ( 
						Isnull ( 
							Nullif ( 
								Convert ( 
									Integer ,
										IsNull (  
												Nullif ( 
													IsNumeric ( Substring (a.observ_frn, CHARINDEX ( '[#GR#', a.observ_frn ) + 5, 1 )),
													1),
													Convert ( integer, Substring (a.observ_frn, CHARINDEX ( '[#GR#', a.observ_frn ) + 5, 1 )) + 1 -- pour gérer le grade 0 qui prose problème avec le 0 du isnumeric
												)
									),
								0 ),
								100 ) -1  -- pour gérer le grade 0 qui prose problème avec le 0 du isnumeric
						) <= @iGrade

					  )
				) -- [PM471-1]

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_U02_ARTICLE
-- Auteur               :       FABRY JF
-- Date                 :       16/10/2001
-- Libelle              :        
-- Commentaires         :       MAJ du stock au moment de la validation
-- References           :       
--
-- Arguments            :       @dcIdSin	Decimal ( 7,0 )
--
-- Retourne             :       Rien
--
-- JFF 07/04/2010 [DCMP100150] 
-- JFF 25/08/2011 [VDOC4288]
-- JFF 14/09/2011 [vDOC5026]
-- JFF 07/05/2013 [PM234-7]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U02_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.PS_U02_ARTICLE
GO

CREATE procedure sysadm.PS_U02_ARTICLE
	@dcIdSin	Decimal ( 10,0 ) -- [PI062]
AS

Declare	@iIdSeq		Integer
Declare	@sMarq		Varchar ( 35 )
Declare	@sModl		Varchar ( 35 )
Declare	@sIdFour	Varchar ( 3 )
Declare	@sIdTypArt	Varchar ( 3 )
Declare @sIdRefFour	VarChar ( 20 )
Declare @dcIdProd 	Decimal ( 7 ) -- [VDOC4288]

EXEC sysadm.PS_U03_ARTICLE @dcIdSin

-- [VDOC4288]
Select @dcIdProd = s.id_prod
From   sysadm.sinistre s
Where  s.id_sin = @dcIdSin
 
DECLARE cur CURSOR 
FOR Select id_seq 
    from   sysadm.w_commande
    Where  id_sin = @dcIdSin
    And    cpt_valide = 0

OPEN cur

FETCH cur INTO @iIdSeq

While @@fetch_status <> -1
  Begin

	/* On identifie la cl‚ de l'article sur la commande */  
	Select @sIdFour    = id_four,
	 @sIdRefFour = id_ref_four,
	 @sIdTypArt  = id_typ_art,
	 @sMarq      = id_marq_art,
	 @sModl      = id_modl_art
	From	 sysadm.w_commande
	Where	 id_sin = @dcIdSin
	And	 id_seq = @iIdSeq

	/* DCMP 050499 M. LEGAC pour a-novo  */ 
	If @sIdFour in ( 'BTP', 'CIS', 'PAP', 'O2M' ) and @sIdTypArt Not in ( 'PRS', 'CAF', 'MAI', 'ACC', 'EDI', 'PCM', 'SMS', 'AEF', 'PST' ) -- [PM234-7] PST
	  Begin  
		If ( 
		     ( 	Select 	IsNull (qt_disp, 0 )
			From	sysadm.article
			Where	id_four		in ( 'BTP', 'CIS', 'PAP', 'O2M' )
			And	id_four		= @sIdFour		
			And	id_ref_four	= @sIdRefFour
			And	id_typ_art	= @sIdTypArt
			And	id_marq_art	= @sMarq
			And	id_modl_art	= @sModl 
			And 	alt_dispo 	= 'O'
			) <= 0 
		     Or 
		     Exists
		     ( 	Select 	*
			From	sysadm.article
			Where	id_four		in ( 'BTP', 'CIS', 'PAP', 'O2M' )
			And	id_four		= @sIdFour		
			And	id_ref_four	= @sIdRefFour
			And	id_typ_art	= @sIdTypArt
			And	id_marq_art	= @sMarq
			And	id_modl_art	= @sModl 
			And 	alt_dispo 	= 'N'
			) 

		     Or 
		     Not Exists
		     ( 	Select 	*
			From	sysadm.article
			Where	id_four		in ( 'BTP', 'CIS', 'PAP', 'O2M' )
			And	id_four		= @sIdFour		
			And	id_ref_four	= @sIdRefFour
			And	id_typ_art	= @sIdTypArt
			And	id_marq_art	= @sMarq
			And	id_modl_art	= @sModl 
			) 
		   )	     

		Begin
		  CLOSE cur
		  DEALLOCATE cur
		  Return -1000	
		End 
	  End	


	-- [VDOC4288]
	If Exists ( 
		Select *
		From   sysadm.det_pro d
		Where  d.id_prod = @dcIdProd
		And    d.id_code_dp = 184
		And    d.id_code_car = @sIdFour
		   ) 

	  Begin
		If ( 
		     ( 	Select 	IsNull (qt_disp, 0 )
			From	sysadm.article a 
			Where	a.id_four	= @sIdFour		
			And	a.id_ref_four	= @sIdRefFour
			And	a.id_typ_art	= @sIdTypArt
			And	a.id_marq_art	= @sMarq
			And	a.id_modl_art	= @sModl 
			And 	a.alt_dispo 	= 'O'
			) <= 0 
		     Or 
		     Exists
		     ( 	Select 	*
			From	sysadm.article a
			Where	a.id_four	= @sIdFour		
			And	a.id_ref_four	= @sIdRefFour
			And	a.id_typ_art	= @sIdTypArt
			And	a.id_marq_art	= @sMarq
			And	a.id_modl_art	= @sModl 
			And 	a.alt_dispo 	= 'N'
			) 

		     Or 
		     Not Exists
		     ( 	Select 	*
			From	sysadm.article a
			Where	a.id_four	= @sIdFour		
			And	a.id_ref_four	= @sIdRefFour
			And	a.id_typ_art	= @sIdTypArt
			And	a.id_marq_art	= @sMarq
			And	a.id_modl_art	= @sModl 
			) 
		   )	 
		   
			Begin
			  CLOSE cur
			  DEALLOCATE cur
			  Return -1000	
			End 

	  End
	-- [VDOC4288]

	/* On d‚cr‚mente le stocke */
	Update sysadm.article
	Set	 qt_disp = qt_disp - 1
	Where	 id_four	= @sIdFour
	And	 id_ref_four	= @sIdRefFour
	And	 id_typ_art	= @sIdTypArt
	And	 id_marq_art	= @sMarq
	And	 id_modl_art	= @sModl

	FETCH cur INTO @iIdSeq
  
  End

CLOSE cur

DEALLOCATE cur

GO

--------------------------------------------------------------------
--
-- Procedure            :       DW_S03_ARTICLE
-- Auteur               :       FABRY JF
-- Date                 :       31/08/2001
-- Libelle              :        
-- Commentaires         :       Select sur la table ARTICLE pour Stat journaliŠre
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_S03_ARTICLE
GO

CREATE procedure sysadm.DW_S03_ARTICLE
        @sIdFour	VarChar ( 3 )
AS
Select 	CodeFR.lib_code Fournisseur,
	a.id_ref_four Ref_Article_Fournisseur,                    
	CodeAR.lib_code Type_Article,
	a.id_marq_art Marque_Article,                    
	a.id_modl_art Modele_Article,                    
	a.mt_prix_ht Prix_Hors_Taxe,                     
	a.tva TVA_Sur_Article,                            
	a.qt_disp Quantite_Disponible,                        
	a.observ_frn Obervation_Fournisseur,
	Case a.alt_dispo
	   When 'O' Then 'OUI'
	   When 'N' Then 'NON'
	End Disponible_à_la_commande,
	a.id_marq_art_ifr Marque_de_référence_IFR,
	a.id_modl_art_ifr Modèle_de_référence_IFR,
	CodeEI.lib_code Etat_dernière_intégration

From	sysadm.article a,
	sysadm.code_car CodeFR,
	sysadm.code_car CodeAR,
	sysadm.code     CodeEI

Where 	( a.id_four = @sIdFour Or @sIdFour = '*' )
And	CodeFR.id_typ_code = '-FR'
And	CodeFR.id_code = a.id_four
And	CodeAR.id_typ_code = '-AR'
And	CodeAR.id_code = a.id_typ_art
And	CodeEI.id_typ_code = '-EI'
And	CodeEI.id_code = a.cod_etat

GO

--------------------------------------------------------------------
--
-- Procedure            :       DW_S04_ARTICLE
-- Auteur               :       PLJ
-- Date                 :       12/08/2004
-- Libelle              :        
-- Commentaires         :       Sélection de la table article avec calcul Prix_TTC
-- References           :       d_trt_sp_ifr_saisie_article
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_S04_ARTICLE
GO

CREATE procedure sysadm.DW_S04_ARTICLE
AS

SELECT   id_four,
         id_ref_four,
         id_typ_art,
         id_marq_art,
         id_modl_art,
         mt_prix_ht,
         tva,
         mt_prix_ht * tva/100 + mt_prix_ht   AS mt_prix_ttc,
         qt_disp,
         observ_frn,
         alt_dispo,
         id_marq_art_ifr,
         id_modl_art_ifr,
         cod_etat,
         verrou,
         cree_le,
         maj_le,
         maj_par

  FROM   sysadm.article

GO


--------------------------------------------------------------------
--
-- Procédure            :      DW_S01_ART_LISTE_MARQUE
-- Auteur               :      PLJ
-- Date                 :      13/08/2004
-- Libellé              :      Sélectionne toutes les marques de la table article
--
-- Commentaires         :
--                       
-- Références           :
--
-- Arguments            :      
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_ART_LISTE_MARQUE' AND type = 'P' )
            DROP procedure sysadm.DW_S01_ART_LISTE_MARQUE
GO

CREATE PROC sysadm.DW_S01_ART_LISTE_MARQUE
AS

SELECT DISTINCT id_marq_art 
  FROM sysadm.article
 ORDER BY id_marq_art

GO

--------------------------------------------------------------------
--
-- Procédure            :      DW_S01_ART_LISTE_MODL
-- Auteur               :      PLJ
-- Date                 :      13/08/2004
-- Libellé              :      Sélectionne tous les modèles de la table ARTICLE
--
-- Commentaires         :
--                       
-- Références           :
--
-- Arguments            :      
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_ART_LISTE_MODL' AND type = 'P' )
            DROP procedure sysadm.DW_S01_ART_LISTE_MODL
GO

CREATE PROC sysadm.DW_S01_ART_LISTE_MODL
AS

SELECT DISTINCT id_marq_art , id_modl_art
  FROM sysadm.article
 ORDER BY id_modl_art

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_ARTICLE
-- Auteur               :       FABRY JF
-- Date                 :       16/06/2005
-- Libellé              :       
-- Commentaires         :       Suppression d'un article
-- Références           :       w_sp_trt_int_fic_article
--
-- Arguments            :       @sIdFour        VarChar(3)              (Val)
--                              @sIdRefFour     VarChar(20)             (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_D01_ARTICLE
GO

CREATE procedure sysadm.DW_D01_ARTICLE
	@sIdFour        VarChar(3),
	@sIdRefFour     VarChar(20)
AS


 Delete from sysadm.det_hlr
 From   sysadm.det_article da
 Where	da.id_four = @sIdFour
 And	da.id_ref_four = @sIdRefFour
 And	det_hlr.id_four = da.id_four
 And	det_hlr.id_article = da.id_article
 
 Delete from sysadm.det_article
 Where	id_four = @sIdFour
 And	id_ref_four = @sIdRefFour
 
Delete from sysadm.article
Where	id_four = @sIdFour
And	id_ref_four = @sIdRefFour
 
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_D02_ARTICLE
-- Auteur               :       FABRY JF
-- Date                 :       05/11/2010
-- Libellé              :       [PC301].[LOT2]
-- Commentaires         :       Suppression des  articles d'un fournisseur
-- Références           :       
--
-- Arguments            :       @sIdFour        VarChar(3)              (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D02_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.PS_D02_ARTICLE
GO

CREATE procedure sysadm.PS_D02_ARTICLE
	@sIdFour        VarChar(3)
AS

Delete from sysadm.article Where id_four = @sIdFour
 
Go


--------------------------------------------------------------------
--
-- Procédure            :      TR_ARTICLE_01
-- Auteur               :      FABRY JF
-- Date                 :      16/06/2005
-- Libellé              :      Sur maj
-- Commentaires         :      
-- Références           :      
--
-- Arguments            :      
--
-- Retourne             :
--
-- #1    JFF    19/10/2009   [DCMP090576]
--       JFF    28/07/2010   [DCMP100440]
--       JFF    19/10/2010   [VDOC1106]
--       JFF    06/09/2013   [VDOC12051]
--       JFF    08/12/2014   [VDOC16241]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_ARTICLE_01' AND type = 'TR' )
        DROP trigger TR_ARTICLE_01
GO

CREATE  TRIGGER sysadm.TR_ARTICLE_01 ON sysadm.article
FOR INSERT
AS

-- #1 [DCMP090576]
Declare @t_courrier Table ( courrier varchar(6) not null )

-- Insert into @t_courrier values ( '602418' ) -- [VDOC12051] shunt
-- Insert into @t_courrier values ( '401900' ) -- [DCMP100440]
-- Insert into @t_courrier values ( '402085' ) -- [DCMP100440]
-- Insert into @t_courrier values ( '402157' ) -- [DCMP100440] [VDOC1106]
-- Insert into @t_courrier values ( '402054' ) -- [VDOC1106] ajout / [VDOC16241] supp
-- :#1 [DCMP090576]

   IF UPDATE ( id_four ) AND UPDATE ( id_ref_four ) 
      BEGIN
         INSERT INTO det_article ( 
         	id_four,
         	id_ref_four,
         	id_prod,
         	id_typ_art,
         	id_article,
         	cree_le,
         	maj_le,
         	maj_par )
         SELECT i.id_four,
         	i.id_ref_four,
         	'-1',
         	'ART',
         	c.courrier,  -- #1 [DCMP090576]           
                i.cree_le,
                i.maj_le,
                i.maj_par
           FROM inserted i,
           	@t_courrier c -- #1 [DCMP090576]
           WHERE i.id_four = 'CEG'
           
   	 
           
           
      END  

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U03_ARTICLE
-- Auteur               :       FABRY JF
-- Date                 :       05/07/2005
-- Libelle              :        
-- Commentaires         :       Vérouillage optimisé de la table article
-- References           :       
--
-- Arguments            :       @dcIdSin	Decimal ( 7,0 )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U03_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.PS_U03_ARTICLE
GO

CREATE procedure sysadm.PS_U03_ARTICLE
	@dcIdSin	Decimal ( 10,0 ) -- [PI062]
AS

Update 	sysadm.article
Set    	verrou = verrou * (-1)
From	sysadm.w_commande wc,
	sysadm.article a
Where   wc.id_sin = @dcIdSin
and	wc.cpt_valide = 0
and 	wc.id_typ_art <> 'PRS'
and	a.id_four = wc.id_four
and 	a.id_ref_four = wc.id_ref_four

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U04_ARTICLE
-- Auteur               :       FABRY JF
-- Date                 :       27/03/2007
-- Libelle              :        
-- Commentaires         :       Vérouillage optimisé de la table article pour le site web
-- References           :       
--
-- Arguments            :       @dcIdSin	Decimal ( 7,0 )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U04_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.PS_U04_ARTICLE
GO

CREATE procedure sysadm.PS_U04_ARTICLE
	@asIdFour	VarChar (   3  ),
	@asIdRefFour	VarChar (  20  )
AS

Update 	sysadm.article
Set    	verrou = verrou * (-1)
From	sysadm.article a
Where   a.id_four = @asIdFour
and 	a.id_ref_four = @asIdRefFour

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U05_ARTICLE
-- Auteur               :       FABRY JF
-- Date                 :       27/03/2007
-- Libelle              :        
-- Commentaires         :       MAJ du stock au moment de la validation de la commande WEB par l'assuré
-- References           :       
--
-- Arguments            :       @dcIdSin	Decimal ( 7,0 )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U05_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.PS_U05_ARTICLE
GO

CREATE procedure sysadm.PS_U05_ARTICLE
	@dcIdSin	Decimal ( 10,0 ), -- [PI062]
	@iIdSeq		Integer
AS

Declare	@sMarq		Varchar ( 35 )
Declare	@sModl		Varchar ( 35 )
Declare	@sIdFour	Varchar ( 3 )
Declare	@sIdTypArt	Varchar ( 3 )
Declare @sIdRefFour	VarChar ( 20 )

Select 	@sIdFour    = id_four,
      	@sIdRefFour = id_ref_four,
	@sIdTypArt  = id_typ_art,
	@sMarq      = id_marq_art,
	@sModl      = id_modl_art
From  	sysadm.commande
Where   id_sin = @dcIdSin
And     id_seq = @iIdSeq

-- Verrouillage optimiser de la table article (pour être ceb, car normalement déjà effectué en amont)
EXEC sysadm.PS_U04_ARTICLE @sIdFour, @sIdRefFour


/* DCMP 050499 M. LEGAC pour a-novo  */ 
If ( 
    (

     ( 	Select 	IsNull (qt_disp, 100 )
	From	sysadm.article
	Where	id_four		= 'ANV'
	And	id_four		= @sIdFour
	And	id_ref_four	= @sIdRefFour
	And	id_typ_art	= @sIdTypArt
	And	id_marq_art	= @sMarq
	And	id_modl_art	= @sModl ) <= 2 

    )

     Or 

/* DCMP 060402 M. LEGAC pour BTP  */     
    (
     ( 	Select 	IsNull (qt_disp, 100 )
	From	sysadm.article
	Where	id_four		= 'BTP'
	And	id_four		= @sIdFour	
	And	id_ref_four	= @sIdRefFour
	And	id_typ_art	= @sIdTypArt
	And	id_marq_art	= @sMarq
	And	id_modl_art	= @sModl ) <= 0 
    )
   )	     

Begin
  Return -1
End 

/* On d‚cr‚mente le stocke */
Update 	 sysadm.article
Set	 qt_disp = qt_disp - 1
Where	 id_four	= @sIdFour
And	 id_ref_four	= @sIdRefFour
And	 id_typ_art	= @sIdTypArt
And	 id_marq_art	= @sMarq
And	 id_modl_art	= @sModl

If @@RowCount <> 1  Return -1 Else Return 1

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_D01_ARTICLE_ALAPAGE
-- Auteur               :       FABRY JF
-- Date                 :       28/09/2007
-- Libelle              :        
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_ARTICLE_ALAPAGE' AND type = 'P' )
        DROP procedure sysadm.PS_D01_ARTICLE_ALAPAGE
GO

CREATE procedure sysadm.PS_D01_ARTICLE_ALAPAGE
AS

Delete From sysadm.det_article
From   sysadm.det_article da,
	sysadm.article a
Where  a.id_four = 'ALP'
And    a.id_typ_art Not in ( 'CAS', 'TEL' )
And    da.id_four = a.id_four
And    da.id_ref_four = a.id_ref_four


Delete From sysadm.article
Where  id_four = 'ALP'
And    id_typ_art Not in ( 'CAS', 'TEL' )

Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_S05_ARTICLE
-- Auteur               :       FABRY JF
-- Date                 :       31/08/2001
-- Libelle              :       [ALAPAGE] 
-- Commentaires         :       Select sur la table ARTICLE pour les articles ALAPGE selon 4 méthodes
-- References           :       
--
-- Arguments            :       @asCas VarChar (20),   'COURRIER', 'CMDE'
-- 				@adcIdProd decimal (7), 
-- 				@adcMtPlaf  decimal (11,2),
-- 				@asIdTypArt VarChar (3),
-- 				@aiCodNovalis Integer
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S05_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_S05_ARTICLE
GO

CREATE procedure sysadm.DW_S05_ARTICLE 
	@asCas VarChar (20),
	@adcIdProd decimal (7),
	@asMtPlaf  VarChar ( 11 ),
	@asIdTypArt VarChar (3),
	@aiCodNovalis Integer
As

Declare @sFiltre VarChar ( 3 )
Declare @adcMtPlaf  decimal (11,2)

Set @adcMtPlaf = Convert ( Decimal (11,2), @asMtPlaf )

Set @sFiltre = Convert ( VarChar ( 3 ), null )

	If @asCas = 'INIT'
	  Begin
		Select 	Top 1
			'N',
			a.id_four,                        
			a.id_ref_four,                    
			a.id_typ_art,                     
			a.id_marq_art,
			a.id_modl_art,
			a.mt_prix_ht,                     
			a.tva,                            
			a.qt_disp,
			a.observ_frn,
			'',
			'',
			0,
			'N',
			null,
			null,
			'N',
			a.id_marq_art id_marque_ifr,
			a.id_modl_art id_modele_ifr,
			0 mt_prix_ifr		
		
		From	sysadm.article a,
			( select distinct 
			id_code_frn,
			id_code_art
			from sysadm.commande_type
			where id_prod = @adcIdProd
			and   id_code_art <> '-1'  
			and   id_code_art = 'CAS' ) as FrnDistinct
		
		Where 	a.id_four = 'ALP' 
		And 	a.id_four = FrnDistinct.id_code_frn
		And 	a.id_typ_art = FrnDistinct.id_code_art
		And   	a.alt_dispo = 'O'
		And   	a.id_typ_art = @asIdTypArt
		Order by a.mt_prix_ht desc
	  End 

	If @asCas = 'COURRIER' and   @asIdTypArt <> 'TEL'
	  Begin
		Select 	Top 3
			'N',
			a.id_four,                        
			a.id_ref_four,                    
			a.id_typ_art,                     
			a.id_marq_art,
			a.id_modl_art,
			a.mt_prix_ht,                     
			a.tva,                            
			a.qt_disp,
			a.observ_frn,
			'',
			'',
			0,
			'N',
			null,
			null,
			'N',
			a.id_marq_art id_marque_ifr,
			a.id_modl_art id_modele_ifr,
			0 mt_prix_ifr		
		
		From	sysadm.article a,
			( select distinct 
			id_code_frn,
			id_code_art
			from sysadm.commande_type
			where id_prod = @adcIdProd
			and   id_code_art <> '-1'  
			and   id_code_art Not in ( 'CAS')) as FrnDistinct
		
		Where 	a.id_four = 'ALP' 
		And 	a.id_four = FrnDistinct.id_code_frn
		And 	a.id_typ_art = FrnDistinct.id_code_art
		And   	a.alt_dispo = 'O'
		And   	a.id_typ_art = @asIdTypArt
		And     Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) <= @adcMtPlaf 
		Order by a.mt_prix_ht desc
	End 

	If @asCas = 'COURRIER' and   @asIdTypArt = 'TEL'
	  Begin
		Select 	Top 3
			'N',
			a.id_four,                        
			a.id_ref_four,                    
			a.id_typ_art,                     
			a.id_marq_art,
			a.id_modl_art,
			a.mt_prix_ht,                     
			a.tva,                            
			a.qt_disp,
			a.observ_frn,
			'',
			'',
			0,
			'N',
			null,
			null,
			'N',
	                ( IsNull ( 
	                              (   Select marque
	                                  From   ifr i
	                                  Where  i.marque = a.id_marq_art_ifr
	                                  And    i.reference = a.id_modl_art_ifr
	                                  And 	 i.id_trait = (
	                                                select max ( id_trait )
	                                                From   sysadm.ifr i2
	                                                Where  i2.marque = i.marque
	                                                And    i2.reference = i.reference
	                                                )
	                               )
	                          , a.id_marq_art )               
	                                
			) id_marque_ifr,
	                ( IsNull ( 
	                               (  Select IsNull ( reference, '' )
	                                  From   ifr i
	                                  Where  i.marque = a.id_marq_art_ifr
	                                  And    i.reference = a.id_modl_art_ifr
	                                  And 	 i.id_trait = (
	                                                select max ( id_trait )
	                                                From   sysadm.ifr i2
	                                                Where  i2.marque = i.marque
	                                                And    i2.reference = i.reference
	                                                )
	                               )
	                          , Case a.id_typ_art When 'TEL' Then '' Else a.id_modl_art End  )     
	                               
			) id_modele_ifr,
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
	
		From	sysadm.article a,
			( select distinct 
				 id_code_frn,
				 id_code_art
			  from sysadm.commande_type
			  where id_prod = @adcIdProd
			  and   id_code_art <> '-1'  
			  and   id_code_art Not in ( 'CAS')) as FrnDistinct
	
		Where 	a.id_four = 'ALP'
		And 	a.id_four = FrnDistinct.id_code_frn
		And 	a.id_typ_art = FrnDistinct.id_code_art
	  	And   	a.alt_dispo = 'O'	
		And   	( a.id_marq_art_ifr is not null Or a.id_typ_art <> 'TEL' )
	    	And     ( a.id_modl_art_ifr is not null Or a.id_typ_art <> 'TEL' )
		And	( 
			Exists ( 
			Select * 
			From   ifr i
		  	Where  i.marque = a.id_marq_art_ifr
		  	And    i.reference = a.id_modl_art_ifr )
		  	Or 
	                a.id_typ_art <> 'TEL' 
		  	Or a.id_four in ( 'WBA' )  -- [SITE_CMDE]                
		  	)
		And     ( 
					@sFiltre is null Or 
					a.id_typ_art = 'PRS' Or 
					CHARINDEX ( @sFiltre, a.observ_frn, 1 ) > 0 Or
					a.id_four in ( 'WBA' )  -- [SITE_CMDE]                				
				)  -- DCMP 060480
		And   	a.id_typ_art = @asIdTypArt
		And     Round ( a.mt_prix_ht * ( 1 + a.tva / 100 ), 2 ) <= @adcMtPlaf 

		Order by a.mt_prix_ht desc
	End 
Go
	
--------------------------------------------------------------------
--
-- Procedure            :       PS_D01_ARTICLE_ALAPAGE
-- Auteur               :       FABRY JF
-- Date                 :       28/09/2007
-- Libelle              :        
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_ARTICLE_ALAPAGE' AND type = 'P' )
        DROP procedure sysadm.PS_S01_ARTICLE_ALAPAGE
GO

CREATE procedure sysadm.PS_S01_ARTICLE_ALAPAGE
	@sCodNovalis VarChar ( 20 ),
	@sMtPrixHT VarChar ( 11 ) OUTPUT,
	@sTVA      VarChar ( 11 ) OUTPUT,
	@sMarq	     VarChar ( 35 ) OUTPUT,
	@sModl	     VarChar ( 35 ) OUTPUT,
	@sTypArt     VarChar ( 3 )  OUTPUT,
	@sLibTypArt     VarChar ( 35 )  OUTPUT,
	@sIdFour	VarChar ( 3 )   OUTPUT,
	@sMarqIfr     VarChar ( 35 ) OUTPUT,
	@sModlIfr     VarChar ( 35 ) OUTPUT,
	@sMtPrixIFR   VarChar ( 11 ) OUTPUT
AS

Select  @sMtPrixHT = Convert ( VarChar ( 11 ), Convert ( Decimal ( 11, 2 ),  a.mt_prix_ht, 11 ) ),
	@sTVA = Convert ( VarChar ( 11 ), Convert ( Decimal ( 11, 2 ),  a.tva, 11 ) ),
	@sMarq = sysadm.FN_TRIM ( a.id_marq_art ),
	@sModl = sysadm.FN_TRIM ( a.id_modl_art ),
	@sTypArt = sysadm.FN_TRIM ( a.id_typ_art ),
	@sLibTypArt = sysadm.FN_TRIM (  sysadm.FN_CODE_CAR ( a.id_typ_art, '-AR' ) ),
	@sIdFour = a.id_four,
	@sMarqIfr =    ( IsNull ( 
		                      (   Select marque
		                          From   ifr i
		                          Where  i.marque = a.id_marq_art_ifr
		                          And    i.reference = a.id_modl_art_ifr
		                          And 	 i.id_trait = (
		                                        select max ( id_trait )
		                                        From   sysadm.ifr i2
		                                        Where  i2.marque = i.marque
		                                        And    i2.reference = i.reference
		                                        )
		                       )
		                  , a.id_marq_art )               
		                        
			),
	 @sModlIfr =    ( IsNull ( 
	                               (  Select IsNull ( reference, '' )
	                                  From   ifr i
	                                  Where  i.marque = a.id_marq_art_ifr
	                                  And    i.reference = a.id_modl_art_ifr
	                                  And 	 i.id_trait = (
	                                                select max ( id_trait )
	                                                From   sysadm.ifr i2
	                                                Where  i2.marque = i.marque
	                                                And    i2.reference = i.reference
	                                                )
	                               )
	                          , Case a.id_typ_art When 'TEL' Then '' Else a.id_modl_art End  )     
	                               
			) ,
	@sMtPrixIFR =  ( Select frequence
			  From   ifr i
			  Where  i.marque = a.id_marq_art_ifr
			  And    i.reference = a.id_modl_art_ifr
			  And 	 i.id_trait = (
					select max ( id_trait )
					From   sysadm.ifr i2
					Where  i2.marque = i.marque
					And    i2.reference = i.reference
					)
			) 


 
From 	sysadm.article a
Where  	a.id_four = 'ALP'
And     a.id_typ_art <> 'CAS'
And 	a.id_ref_four = @sCodNovalis
And   	a.alt_dispo = 'O'


Return @@RowCount

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S01_ARTICLE_ALAPAGE_VERS_EA
-- Auteur               :       FABRY JF
-- Date                 :       28/09/2007
-- Libelle              :        
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_ARTICLE_ALAPAGE_VERS_EA' AND type = 'P' )
            DROP procedure sysadm.PS_S01_ARTICLE_ALAPAGE_VERS_EA
GO

CREATE PROC sysadm.PS_S01_ARTICLE_ALAPAGE_VERS_EA

As

Declare @dDteDeb Datetime
Declare @dDteFin Datetime

Declare @iIdTrait Integer
Declare @iNbLig   Integer
Declare @iRet     Integer
Declare @sMsg     Varchar(35)
Declare @sCmd     Varchar(1000)

-- Variables pour l'envoi du mail

Declare @sBody    Varchar(300)
Declare @sTo      Varchar(500)
Declare @sCc      Varchar(500)
Declare @sCcc     Varchar(500)
Declare @sObjet   Varchar(300)
Declare @sFrom    Varchar(128) -- #1
Declare @sRetour  VarChar(255)        
Declare @sQuery   Varchar(8000)
Declare @sBase    Varchar(35)
Declare @sFic     Varchar(200)
Declare @sRep     Varchar(200)

Set @iRet   = 0
Set nocount on

If @@servername <> master.dbo.SPB_FN_ServerName ('PRO') Return

    Set @sBase = 'SIMPA2_PRO'
    Set @sRep  = master.sysadm.SPB_FN_GET_ROOT()+'SINISTRE\Export_article_ALAPAGE\'
    Set @sTo    = 'productioninformatique@spb.fr,ilg@spb.fr,po@spb.fr'
--  Set @sTo    = 'JFF@spb.fr'
--  Set @sCc    = 'JFF@spb.fr,phg@spb.fr,jca@spb.fr,dga@spb.fr'
--  Set @sCcc   = "DGA@spb.fr" -- Test

Set @sQuery = 'Set nocount on Select RTRIM ( id_four ), RTRIM ( id_ref_four ) ''code_novalis'', RTRIM ( id_typ_art ), RTRIM ( ' + @sBase + '.sysadm.FN_CODE_CAR ( id_typ_art, ''-AR'')) ''lib_typ_art'', RTRIM ( id_marq_art) , RTRIM ( id_modl_art ) From ' + @sBase + '.sysadm.article where id_four = ''ALP'' And id_typ_art <> ''CAS'''
Set @sFic = @sRep + 'Article_ALAPAGE_' + Convert ( Varchar( 4 ) , Year (Getdate() ) ) + Right ( '00' + Convert ( Varchar( 4 ) , month (Getdate() ) ), 2 ) + Right ( '00' + Convert ( Varchar( 2 ) , Day (Getdate() ) ), 2 ) + '_' + Right ( Convert ( VarChar (30), Getdate(), 113 ), 3 ) + '.csv'
			
Set  @sCmd = 'sqlcmd /S' + @@Servername + ' /E /Q"' + @sQuery + '" /o' + @sFic + ' -h-1 -w5000 -u -s";" -t120' 

Exec master.dbo.xp_cmdshell @sCmd, no_output
		
--> Envoi automatique du fichier par mail

Set @sObjet = 'ARTICLE ALAPAGE POUR EA' + Convert ( Varchar( 4 ) , Year (Getdate() ) ) + Convert ( Varchar( 4 ) , month (Getdate() ) )  
Set @sFrom  = 'ARTICLE_ALAPAGE_ES_VERS_EA@Spb.Fr' -- #1

-- Exec @iRet = master.dbo.SPB_PS_MAIL @sRetour OUTPUT, @sTo, @sBody, @sObjet, @sFrom, @sCc, @sFic, null, null, null, null, @sCcc

Go

grant execute on sysadm.PS_S01_ARTICLE_ALAPAGE_VERS_EA to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procedure            :       PS_D01_ARTICLE_CDISCOUNTPRO
-- Auteur               :       FABRY JF
-- Date                 :       28/09/2007
-- Libelle              :        
-- Commentaires         :       [DCMP090102]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- [VDOC14454] JFF 19/05/2014
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_ARTICLE_CDISCOUNTPRO' AND type = 'P' )
        DROP procedure sysadm.PS_D01_ARTICLE_CDISCOUNTPRO
GO

CREATE procedure sysadm.PS_D01_ARTICLE_CDISCOUNTPRO
AS

Delete From sysadm.det_article
From   sysadm.det_article da,
	sysadm.article a
Where  a.id_four = 'CDP'
-- And    a.id_typ_art Not in ( 'TEL' ) [VDOC14454]
And    da.id_four = a.id_four
And    da.id_ref_four = a.id_ref_four


Delete From sysadm.article
Where  id_four = 'CDP'
-- And    id_typ_art Not in ( 'TEL' ) [VDOC14454]

Go



--------------------------------------------------------------------
--
-- Procedure            :       PS_D01_ARTICLE_MOB_CYBERPHONE
-- Auteur               :       FABRY JF
-- Date                 :       28/09/2007
-- Libelle              :        
-- Commentaires         :       [MOBISTORE_CYBERPHONE]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_ARTICLE_MOB_CYBERPHONE' AND type = 'P' )
        DROP procedure sysadm.PS_D01_ARTICLE_MOB_CYBERPHONE
GO

CREATE procedure sysadm.PS_D01_ARTICLE_MOB_CYBERPHONE
AS

Delete From sysadm.article
Where  id_four = 'MCY'
And    id_typ_art Not in ( 'TEL', 'PC2','CAF' )

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_D01_ARTICLE_ACUBE
-- Auteur               :       FPI
-- Date                 :       29/09/2010
-- Libelle              :        
-- Commentaires         :       [PC514]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_ARTICLE_ACUBE' AND type = 'P' )
        DROP procedure sysadm.PS_D01_ARTICLE_ACUBE
GO

CREATE procedure sysadm.PS_D01_ARTICLE_ACUBE
AS

Delete From sysadm.article
Where  id_four = 'ACU'
And    id_typ_art Not in ( 'TEL', 'PC2','CAF' )

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_D01_ARTICLE_FPC_GROUP
-- Auteur               :       JFF
-- Date                 :       03/09/2012
-- Libelle              :        
-- Commentaires         :       [PC853]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_ARTICLE_FPC_GROUP' AND type = 'P' )
        DROP procedure sysadm.PS_D01_ARTICLE_FPC_GROUP
GO

CREATE procedure sysadm.PS_D01_ARTICLE_FPC_GROUP
AS

Delete From sysadm.article
Where  id_four = 'FPC'
And    id_typ_art Not in ( 'TEL', 'PC2','CAF' )

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_D01_ARTICLE_CYBERTEAM
-- Auteur               :       JFF
-- Date                 :       03/09/2012
-- Libelle              :        
-- Commentaires         :       [PC853]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_ARTICLE_CYBERTEAM' AND type = 'P' )
        DROP procedure sysadm.PS_D01_ARTICLE_CYBERTEAM
GO

CREATE procedure sysadm.PS_D01_ARTICLE_CYBERTEAM
AS

Delete From sysadm.article
Where  id_four = 'CYT'
And    id_typ_art Not in ( 'TEL', 'PC2','CAF' )

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S01_ARTICLE_DP150_V02
-- Auteur               :       FPI
-- Date                 :       29/09/2010
-- Libelle              :        
-- Commentaires         :       [PC10].[DP150]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      28/09/2015   [PM319-1]
-- JFF      30/08/2021   [RS972][OPTIM_MB3&4]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_ARTICLE_DP150_V02' AND type = 'P' )
        DROP procedure sysadm.PS_S01_ARTICLE_DP150_V02
GO

CREATE procedure sysadm.PS_S01_ARTICLE_DP150_V02
	@dcIdprod	Decimal (7),
	@sMarqIfr	VarChar ( 35 ),
	@sModlIfr	VarChar ( 35 ),
	@dcMtValTTC	Decimal (11,2) OUTPUT,
	@sChaineBCV	VarChar ( 255 ) -- [PM319-1]
AS

Declare @sTypApp VarChar ( 10 )
Declare @sIdFour VarChar ( 10 )

Set @sTypApp = sysadm.FN_CLE_VAL ( 'TYP_APP', @sChaineBCV, ';' ) 

If sysadm.FN_CLE_VAL ( 'VARIANTE', @sChaineBCV, ';' ) in ( 'PRIX_ORANGE' )
 Begin
    Set @sIdFour = 'PPO'
 End 

-- [RS972][OPTIM_MB3&4]
If sysadm.FN_CLE_VAL ( 'VARIANTE', @sChaineBCV, ';' ) in ( 'PRIX_BOOST' )
 Begin
    Set @sIdFour = 'BST'
 End 

If @sIdFour is not null 
 Begin     
	Select 	@dcMtValTTC = Min ( Round ( mt_prix_ht * ( 1 + tva/100 ), 2 ) )
	From   	sysadm.article a
	Where   a.id_four = @sIdFour
	and     a.id_typ_art = @sTypApp 
	and		a.id_marq_art_ifr = @sMarqIfr
	and 	a.id_modl_art_ifr = @sModlIfr
	and 	a.alt_dispo = 'O'
	And     CharIndex ( '[#NEU#]', a.observ_frn ) > 0 

	If @dcMtValTTC is null Set @dcMtValTTC = 0
	Return 
 End 

-- Défaut
Select 	@dcMtValTTC = Min ( Round ( mt_prix_ht * ( 1 + tva/100 ), 2 ) )
	
From   	sysadm.article a,
		sysadm.commande_type ct
Where   ct.id_prod = @dcIdprod
and 	a.id_four = ct.id_code_frn
and     a.id_typ_art = ct.id_code_art 
and     a.id_typ_art = @sTypApp -- [RS972][OPTIM_MB3&4]
and		a.id_marq_art_ifr = @sMarqIfr
and 	a.id_modl_art_ifr = @sModlIfr
and 	a.alt_dispo = 'O'

If @dcMtValTTC is null Set @dcMtValTTC = 0

Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_S06_ARTICLE
-- Auteur               :       FPI
-- Date                 :       25/04/2012
-- Libelle              :        
-- Commentaires         :       [LST_FOUR] Listes des founisseurs
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       liste des fournisseurs pour la gestion des commandes Simpa2
--
-------------------------------------------------------------------
--        JFF   03/12/2024   [HP252_276_HUB_PRESTA]
--		  JFF   16/01/2025   [HUB832_HUB_ORG_REUN] 

-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S06_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_S06_ARTICLE
GO

CREATE procedure sysadm.DW_S06_ARTICLE

AS

If sysadm.FN_CLE_NUMERIQUE ( 'HUB832_HUB_ORG_REUN') > 0 
	Begin
		select 	distinct a.id_four,
			c.lib_code as lib_four
		from   	sysadm.article a,
			sysadm.code_car c
		where   a.id_four=c.id_code
		and c.id_typ_code='-FR'
		Union -- [HP252_276_HUB_PRESTA]
		Select	f.id_code,
				sysadm.FN_CODE_CAR ( f.id_code, '-FR' ) 
		From sysadm.famille_car f
		Where f.id_fam = 1
	End 
Else 
	Begin
		select 	distinct a.id_four,
			c.lib_code as lib_four
		from   	sysadm.article a,
			sysadm.code_car c
		where   a.id_four=c.id_code
		and c.id_typ_code='-FR'
		Union -- [HP252_276_HUB_PRESTA]
		Select	c.id_code,
				sysadm.FN_CODE_CAR ( c.id_code, '-FR' ) 
		From sysadm.code_car c
		Where c.id_typ_code = '-WP'
		And c.id_code <> '-1'
	End 
Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_S07_ARTICLE
-- Auteur               :       FPI
-- Date                 :       25/09/2012
-- Libelle              :        
-- Commentaires         :       [VDoc8841] Listes des founisseurs
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :      
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S07_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_S07_ARTICLE
GO

CREATE procedure sysadm.DW_S07_ARTICLE

AS

select 	distinct a.id_four,
	c.lib_code as lib_four
from   	sysadm.article a,
	sysadm.code_car c
where   a.id_four=c.id_code
and c.id_typ_code='-FR'
and a.id_typ_art not in ('CAF','EDI','MAI','DEV','PRS','AEF','CAS','SMS','PCM','ACC','ALE','BAM')
and id_four not in ('WBA','WBB')
and a.id_marq_art_ifr is not null
and a.id_modl_art_ifr is not null

Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_S08_ARTICLE
-- Auteur               :       FPI
-- Date                 :       25/09/2012
-- Libelle              :        
-- Commentaires         :       [VDoc8841] Listes des marques
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :      
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S08_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_S08_ARTICLE
GO

CREATE procedure sysadm.DW_S08_ARTICLE
	@asIdFour varchar(3)
AS

select 	distinct a.id_four,
	a.id_marq_art
from   	sysadm.article a
where   a.id_typ_art not in ('CAF','EDI','MAI','DEV','PRS','AEF','CAS','SMS','PCM','ACC','ALE','BAM')
	and a.id_four=@asIdFour
	and a.id_marq_art_ifr is not null
	and a.id_modl_art_ifr is not null

Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_S09_ARTICLE
-- Auteur               :       FPI
-- Date                 :       25/09/2012
-- Libelle              :        
-- Commentaires         :       [VDoc8841] Listes des modèle
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S09_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_S09_ARTICLE
GO

CREATE procedure sysadm.DW_S09_ARTICLE
	@asIdFour varchar(3),
	@asIdMarqArt varchar(35)
AS

select 	distinct a.id_four,
	a.id_marq_art, a.id_modl_art
from   	sysadm.article a
where   a.id_four=@asIdFour
	and a.id_marq_art=@asIdMarqArt
	and a.id_marq_art_ifr is not null
	and a.id_modl_art_ifr is not null
Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_S10_ARTICLE
-- Auteur               :       FPI
-- Date                 :       25/09/2012
-- Libelle              :        
-- Commentaires         :       [VDoc8841] Listes des références fournisseurs
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S10_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.DW_S10_ARTICLE
GO

CREATE procedure sysadm.DW_S10_ARTICLE
	@asIdFour varchar(3),
	@asIdMarqArt varchar(35),
	@asIdModlArt varchar(35)
	
AS

select 	a.id_four,
	a.id_marq_art, a.id_modl_art,
	a.id_ref_four, a.id_marq_art_ifr, a.id_modl_art_ifr
from   	sysadm.article a
where   a.id_four=@asIdFour
	and a.id_marq_art=@asIdMarqArt
	and a.id_modl_art=@asIdModlArt
	and a.id_marq_art_ifr is not null
	and a.id_modl_art_ifr is not null

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S_RECH_ART_NEUF
-- Auteur               :       JFF
-- Date                 :       13/02/2014
-- Libelle              :      -- [DT57_CMDE_IPHONE_SFR]  
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RECH_ART_NEUF' AND type = 'P' )
        DROP procedure sysadm.PS_S_RECH_ART_NEUF
GO

CREATE procedure sysadm.PS_S_RECH_ART_NEUF
	@asMarqueIfr	Varchar ( 35 ),
	@asModeleIfr	Varchar ( 35 ),
	@adcMtTTC		decimal ( 11,2 ) Output,
	@asIdRefFour	Varchar ( 20 ) Output
As

Select	@adcMtTTC = mt_prix_ht * ( 1 + tva/100 ), 
		@asIdRefFour = id_ref_four 
from sysadm.article 
where id_four = 'CEG'
And   id_marq_art_ifr = @asMarqueIfr
And   id_modl_art_ifr = @asModeleIfr
And	  alt_dispo = 'O'
And   CHARINDEX ( '[#NEU#]', observ_frn ) > 0

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_CMDE_VAL_NON_GEN
-- Auteur               :       JFF
-- Date                 :       11/06/2016
-- Libelle              :       [VDOC17887]
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_CMDE_VAL_NON_GEN' AND type = 'P' )
        DROP procedure sysadm.PS_S_CMDE_VAL_NON_GEN
GO

CREATE procedure sysadm.PS_S_CMDE_VAL_NON_GEN
	@asIdFour varchar(3),
	@asIdTypArt VarChar ( 35), 	
	@asIdRefFour varchar ( 35 ),
	@asIdMarqArt varchar(35),
	@asIdModlArt varchar(35)
	
AS

Declare @iNbreCmdeValNonGen Integer

Select	@iNbreCmdeValNonGen = COUNT(*)
From	sysadm.commande c
Where	c.id_four = @asIdFour
And		c.id_typ_art = @asIdTypArt
And		c.id_ref_four = @asIdRefFour
And		c.id_marq_art = @asIdMarqArt
And		c.id_modl_art = @asIdModlArt
And		c.id_lot_cmd = 0

If @iNbreCmdeValNonGen is null Set @iNbreCmdeValNonGen = 0

Return @iNbreCmdeValNonGen 

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_D01_ARTICLE_FOURN
-- Auteur               :       FABRY JF
-- Date                 :       11/10/2016
-- Libelle              :        
-- Commentaires         :       [DT076-2]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- [VDOC14454] JFF 19/05/2014
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_ARTICLE_FOURN' AND type = 'P' )
        DROP procedure sysadm.PS_D01_ARTICLE_FOURN
GO

CREATE procedure sysadm.PS_D01_ARTICLE_FOURN
	@sIdFour Varchar ( 3 )
AS

Delete From sysadm.det_article
From   sysadm.det_article da,
	sysadm.article a
Where  a.id_four = @sIdFour
And    da.id_four = a.id_four
And    da.id_ref_four = a.id_ref_four


Delete From sysadm.article
Where  id_four = @sIdFour

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_RS4616_MAJ_CMDE_TLS
-- Auteur               :       FABRY JF
-- Date                 :       21/02/2023
-- Libelle              :        
-- Commentaires         :       [RS4616_RET_TLS]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- [VDOC14454] JFF 19/05/2014
-- JFF      07/03/2024   [HP252_276_HUB_PRESTA]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_RS4616_MAJ_CMDE_TLS' AND type = 'P' )
        DROP procedure sysadm.PS_U_RS4616_MAJ_CMDE_TLS
GO

CREATE procedure sysadm.PS_U_RS4616_MAJ_CMDE_TLS
	@sIdFour Varchar ( 3 ),
	@iFreqMois Integer
AS

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_marq_art	VarChar ( 35 ),
	  id_modl_art	VarChar ( 35 ),
	  marquage	integer null 
	)

Declare @iIdSeq integer
Declare @sIdMarqArt Varchar( 35 ) 
Declare @sIdModlArt Varchar( 35 ) 
Declare @sObjet VarChar ( 255 )
Declare @sMessage VarChar ( 8000 )
Declare @sRetourErrMail VarChar ( 255 )
Declare @sFicOut VarChar ( 255 )
Declare @sLibPrestaExterne VarChar ( 35 ) 
Declare @sFrom varchar ( 50 )
Declare @TypArtIfr varchar ( 100 )

Set @sIdFour = lTrim ( rTrim ( Upper ( @sIdFour )))
Set @iFreqMois = Abs ( @iFreqMois ) * (-1)

Set @sLibPrestaExterne = sysadm.FN_CODE_CAR ( @sIdFour, '-FR' ) 

-- [HP252_276_HUB_PRESTA]
Select @TypArtIfr = 
		'#' + ( 
		Select stuff ( 
				( SELECT Distinct '#' + CAST(rtrim ( ltrim ( rtrim ( i.sku_saga )) ) AS VARCHAR(250)) 
					FROM sysadm.ifr i
					Where sku_saga is not null
					For XML PATH ('') )
			, 1, 1, '' )) + '#'

-- Maj des commandes
Update c
Set  id_marq_art_ifr = a.id_marq_art_ifr,
	 id_modl_art_ifr = a.id_modl_art_ifr
From sysadm.commande c,
	 sysadm.article a
Where c.id_four = @sIdFour -- [HP252_276_HUB_PRESTA]
And c.id_modl_art_ifr is null
And c.maj_le > DateAdd ( month, @iFreqMois, GetDate() ) 
And a.id_four = c.id_four
And a.id_marq_art = c.id_marq_art
And a.id_modl_art = c.id_modl_art
And a.id_marq_art_ifr is not null
And a.id_modl_art_ifr is not null

Update c
Set  id_marq_art_ifr = a.id_marq_art_ifr,
	 id_modl_art_ifr = a.id_modl_art_ifr
From sysadm.commande c,
	 sysadm.article a
Where Len ( sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';' ) ) > 0 
And c.id_modl_art_ifr is null
And c.maj_le > DateAdd ( month, @iFreqMois, GetDate() ) 
And a.id_four = 'HUP'
And a.id_marq_art = c.id_marq_art
And a.id_modl_art = c.id_modl_art
And a.id_marq_art_ifr is not null
And a.id_modl_art_ifr is not null

Update c
Set  id_marq_art_ifr = a.id_marq_art_ifr,
	 id_modl_art_ifr = a.id_modl_art_ifr
From sysadm.w_commande c,
	 sysadm.article a
Where c.id_four = @sIdFour  -- [HP252_276_HUB_PRESTA]
And c.id_modl_art_ifr is null
And c.maj_le > DateAdd ( month, @iFreqMois, GetDate() ) 
And a.id_four = c.id_four
And a.id_marq_art = c.id_marq_art
And a.id_modl_art = c.id_modl_art
And a.id_marq_art_ifr is not null
And a.id_modl_art_ifr is not null

Update c
Set  id_marq_art_ifr = a.id_marq_art_ifr,
	 id_modl_art_ifr = a.id_modl_art_ifr
From sysadm.w_commande c,
	 sysadm.article a
Where Len ( sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';' ) ) > 0 
And c.id_modl_art_ifr is null
And c.maj_le > DateAdd ( month, @iFreqMois, GetDate() ) 
And a.id_four = 'HUP'
And a.id_marq_art = c.id_marq_art
And a.id_modl_art = c.id_modl_art
And a.id_marq_art_ifr is not null
And a.id_modl_art_ifr is not null


-- Relevés des articles non liés + mail Séb

Insert into @tb
select a.id_marq_art,
	   a.id_modl_art,
	   0 'marquage'
From  sysadm.article a
Where a.id_four = @sIdFour 
And   CHARINDEX ( '#' + rtrim ( a.id_typ_art ) + '#', @TypArtIfr ) > 0 -- [HP252_276_HUB_PRESTA]
And   ( a.id_marq_art_ifr is null or a.id_modl_art_ifr is null )

While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@sIdMarqArt = rtrim ( id_marq_art ),
		@sIdModlArt = rtrim ( id_modl_art )
	From	@tb
	Where	marquage = 0

	-- Envoi du mail à Sébastien en production 
	Set @sObjet = 'Demande de création de référence Externe<=>IFR'

	IF @@servername <> master.dbo.SPB_FN_ServerName ('PRO')	
		Begin 
			Set @sObjet = '[RECETTE] ' + @sObjet 
		End 

	Set @sMessage = @sMessage + ''

	Set @sMessage = 'Bonjour Sébastien, ' + CHAR ( 10 ) 
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Une nouvelle référence Externe du prestataire ' + @sLibPrestaExterne + ' est à relier à IFR.'
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Prestataire externe : ' + @sLibPrestaExterne + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Marque Externe : ' + @sIdMarqArt + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Modèle Externe : ' + @sIdModlArt + CHAR ( 10 )
	Set @sMessage = @sMessage + CHAR ( 10 )	  
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Cordialement,' + CHAR ( 10 )
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Jean-François FABRY' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'DSI/DEI Equipe SIMPA2' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Legacy Application Tech Lead ' + CHAR ( 10 )
	Set @sMessage = @sMessage + '71, Quai Colbert - 76600 Le Havre - France' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Tél. : +33 (0)2 32 74 22 05' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'www.spb.eu' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'SAS au capital de 1 000 000 euros soumise au contrôle de l’ACPR.' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Siège social : 71, quai Colbert - CS 90000 - 76600 Le Havre. Tél. : +33 (0)2 32 74 20 20' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'N° RCS 305 109 779 (Le Havre) – N°ORIAS 07 002 642 (www.orias.fr).' + CHAR ( 10 )

	Set @sFrom = 'Lien_IFR_' + @sIdFour + '<jff@spb.fr>'

	-- Section rajoutée, à enlever éventuellement pour la recette.
	-- Le but est de ne plus envoyer le mail intempestif en recette à Sébastien

	IF @@servername <> master.dbo.SPB_FN_ServerName ('PRO')	
	  Begin
		Update @tb Set marquage = 1 Where id_seq = @iIdSeq
		Continue
	  End 


	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'ntonnetot@spb.eu,cmathe@spb.eu,ayvon@spb.eu', 
--			'jff@spb.fr',
			@sMessage, 
			@sObjet, 
			@sFrom, 
			'cbourdoiseau@spb.eu',
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL	

	Update @tb Set marquage = 1 Where id_seq = @iIdSeq
 End

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_MAX_MAJ_LE
-- Auteur               :       FABRY JF
-- Date                 :       11/12/2023
-- Libelle              :        
-- Commentaires         :       [RS6244]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- [VDOC14454] JFF 19/05/2014
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAX_MAJ_LE' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAX_MAJ_LE
GO

CREATE procedure sysadm.PS_S_MAX_MAJ_LE
	@adtMaxMajLeArticle DateTime OutPut
AS

SELECT @adtMaxMajLeArticle = Max ( maj_le) FROM sysadm.article
 
Go

