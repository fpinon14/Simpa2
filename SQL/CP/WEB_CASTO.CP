-------------------------------------------------------------------
-- 
-- Fichier              :       WEB_CASTO.CP
-- Auteur               :       FABRY JF
-- Date                 :       18/10/2005
--
-- Commentaires         :       Gestion du SQL lié au site CASTORAMA WEB 
--
-- Procédures           :       PS_S01_CW_ASSURE 	// Donnée liée au client+ticket CastoWeb
--				PS_S02_CW_ARTICLE 	// Donnée liée à l'article, et à la décision casto prise sur cet article.
--				PS_S03_CW_LISTE_SINISTRE // Liste sinistres casto
--				PS_I01_CW_ACTION_CASTO 	// décision castorama
--				VU_S01_STAT_CASTO	// Vu pour les Stat WEB CASTO
--				PS_S01_STAT_CASTO	// PS pour les Stat WEB CASTO [BLOCAGE]
--				VU_S02_STAT_CASTO	// Vu pour les Stat WEB CASTO [DCMP090080]
--				PS_S01_MAGASINS		// Liste des magasins CASTO
--				PS_S04_CW_LISTE_REF_ORAL // [DCMP080153]
-------------------------------------------------------------------
-- JFF  24/09/2013  [PC13288] modif dans tous les fichier 23400
-------------------------------------------------------------------
--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_CW_ASSURE
-- Auteur               :       FABRY JF
-- Date                 :       18/10/2005
-- Libellé              :       Donnée liée au client+ticket 
-- Commentaires         :       DMDI 14964 "s.id_sin not in" dossier exclu.
--
-- Arguments            :       @dcIdSin    Decimal (  7, 0 )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_CW_ASSURE' AND type = 'P' )
        DROP procedure sysadm.PS_S01_CW_ASSURE
GO


CREATE procedure sysadm.PS_S01_CW_ASSURE 
        @dcIdSin    Decimal (  10, 0 ) -- [PI062]
AS
Select 	sysadm.FN_TRIM (sysadm.FN_TRIM (cCI.lib_code) + ' ' + Upper ( sysadm.FN_TRIM (p.nom)) + ', ' + Upper ( Substring ( sysadm.FN_TRIM (p.prenom), 1, 1 ) ) + 
		Case When len (p.prenom) > 1 Then Lower ( Substring ( p.prenom, 2, len (p.prenom) - 1  ) ) else '' End ) 'nom_complet' ,
 	cCI.lib_code 'lib_civ',
 	sysadm.FN_TRIM ( Upper ( p.nom )) 'nom',
 	Upper ( Substring ( sysadm.FN_TRIM (p.prenom), 1, 1 ) ) +
		Case When len (p.prenom) > 1 Then Lower ( Substring ( p.prenom, 2, len (p.prenom) - 1  ) ) else '' End 'prenom',
 	Upper ( sysadm.FN_TRIM (p.adr_1 )) 'adresse1',
 	Upper ( sysadm.FN_TRIM (p.adr_2 )) 'adresse2',
 	Upper ( sysadm.FN_TRIM (p.adr_cp )) 'code_postal',
 	Upper ( sysadm.FN_TRIM (p.adr_ville )) 'ville',
 	Upper ( sysadm.FN_TRIM (s.id_adh )) 'num_carte',
 	(Select	val_dte
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin 	 And 	dp.nom_zone = 'dte_ticket' ) 'dte_ticket',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_mag' ) 'num_mag',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_caisse' ) 'num_caisse',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_hotesse' ) 'num_hotesse',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_ticket' ) 'num_ticket',
	s.id_sin 'ref_sin_spb'
  
 From	sysadm.sinistre s,
 	sysadm.personne p,
 	code cCI
 Where 	s.id_prod between 23400 and 23499
 And 	s.id_sin  = @dcIdSin
 And 	p.id_ordre = s.id_ordre
 And 	cCI.id_typ_code = '-CI'
 And 	cCI.id_code = p.cod_civ
 And 	s.id_sin not in ( 1037121 ) 

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S02_CW_ARTICLE
-- Auteur               :       FABRY JF
-- Date                 :       18/10/2005
-- Libellé              :       Donnée liée aux articles
-- Commentaires         :       -- Commentaires         :       DMDI 14964 "s.id_sin not in" dossier exclu.
--
-- Arguments            :       @dcIdSin    Decimal (  7, 0 )
--
-- Retourne             :       Rien
-- 
-- #1   JFF    10/01/2007  DCMP060798/060799 (Bouton non dispo pour la Gti Vol)
-- #2   JFF    10/02/2010  [CASTO_SWAP]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_CW_ARTICLE' AND type = 'P' )
        DROP procedure sysadm.PS_S02_CW_ARTICLE
GO


CREATE procedure sysadm.PS_S02_CW_ARTICLE
        @dcIdSin    Decimal (  10, 0 ) -- [PI062]
AS
Select  
--'ref_sin_spb'
	s.id_sin 'ref_sin_spb',	

--'id_gti'
	d.id_gti 'id_gti',	

--'id_detail'
	d.id_detail 'id_detail',

--'date_dern_maj'
	d.valide_le 'date_dern_maj_SPB',

--'num_mag'
  	(Select	dp.val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_mag' ) 'num_mag',

--'num_ticket'
  	(Select	dp.val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_ticket' ) 'num_ticket',

--'lib_garantie'
	 cGTI.lib_gti 'lib_garantie',

--'code_accord'
	Case 
		When g.cod_etat = 200 Then  200
		When g.cod_etat = 900 Then  900
		Else
			Case
			  When d.cod_etat = 200 Then 200
			  When d.cod_etat = 900 Then 900
		  	  When d.cod_etat = 600 Then 101
			  When d.cod_etat = 100 Then 
				(	Case (
					Select 	sysadm.FN_TRIM ( ddet.val_car )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'pec' )
		  				When 'O' Then 101
						Else 100
					End 
				)
		  	  ELSE 100
			End 
	End 'code_accord',

--'type_accord'
	Case 
		When g.cod_etat = 200 Then  'Garantie refusée'
		When g.cod_etat = 900 Then  'Garantie sans suite'
		Else
			Case
			  When d.cod_etat = 200 Then 'Article refusé'
			  When d.cod_etat = 900 Then 'Article sans suite'

		  	  When d.cod_etat = 600 Then 'Article remboursé'

			  When d.cod_etat = 100 Then 
				(	Case (
					Select 	sysadm.FN_TRIM ( ddet.val_car )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'pec' )
		  					-- #1
						When 'O' Then
							Case 
								( Select 	count (*)
								From   	sysadm.div_det ddet
								Where  	ddet.id_sin = d.id_sin
								And 	ddet.id_gti = d.id_gti
								And 	ddet.id_detail = d.id_detail
								And     ddet.id_gti = 15
								And 	ddet.nom_zone = 'typ_presta' )
								When 1	Then 	(
										Select 	Case IsNull ( val_car, 'X' ) 
												When 'REP' Then 'Article pris en charge pour une réparation'
												When 'RMP' Then 'Article pris en charge pour un remplacement'	
						  						Else 'Article pris en charge'
											End 
										From   	sysadm.div_det ddet
										Where  	ddet.id_sin = d.id_sin
										And 	ddet.id_gti = d.id_gti
										And 	ddet.id_detail = d.id_detail
										And 	ddet.nom_zone = 'typ_presta' ) 
								-- /#1		  				
			  					Else 'Article pris en charge'
							End 
						Else 'A déterminer par SPB'
					End 
				)
		  	  ELSE 'A déterminer par SPB'
			End 
	End 'type_accord',

--'quantite'
	(
	Select 	ddet.val_nbre
	From   	sysadm.div_det ddet
	Where  	ddet.id_sin = d.id_sin
	And 	ddet.id_gti = d.id_gti
	And 	ddet.id_detail = d.id_detail
	And 	ddet.nom_zone = 'qte' ) 'quantite',

--'description_article'
	Case 
		When ( Select 	count (*)
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'aucune_marq' ) > 0 
			Then 	Case		
				When
					(
					Select 	sysadm.FN_TRIM ( ddet.val_car )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'aucune_marq' ) = 'O' 
					Then 
						(Select sysadm.FN_TRIM ( ddet.val_car )
						From   	sysadm.div_det ddet
						Where  	ddet.id_sin = d.id_sin
						And 	ddet.id_gti = d.id_gti
						And 	ddet.id_detail = d.id_detail
						And 	ddet.nom_zone = 'modl_app' )

				When
					(
					Select 	sysadm.FN_TRIM ( ddet.val_car )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'aucune_marq' ) = 'N' 
					Then 						
						(Select sysadm.FN_TRIM ( ddet.val_car )
						From   	sysadm.div_det ddet
						Where  	ddet.id_sin = d.id_sin
						And 	ddet.id_gti = d.id_gti
						And 	ddet.id_detail = d.id_detail
						And 	ddet.nom_zone = 'modl_app' )
						+ ' ' +
						(Select sysadm.FN_TRIM ( ddet.val_car )
						From   	sysadm.div_det ddet
						Where  	ddet.id_sin = d.id_sin
						And 	ddet.id_gti = d.id_gti
						And 	ddet.id_detail = d.id_detail
						And 	ddet.nom_zone = 'marq_app' )
				End 
		Else 	(Select sysadm.FN_TRIM ( ddet.val_car )
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'modl_app' )
			+ ' ' +
			(Select sysadm.FN_TRIM ( ddet.val_car )
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'marq_app' )

	End 'description_article',

--'prix_unitaire'
	Round ( 
		  Convert ( decimal ( 11,2) , d.mt_val_achat )
			/ 
		  Convert ( decimal ( 11,2) , 
			   (Select ddet.val_nbre
  			    From   sysadm.div_det ddet
			    Where  ddet.id_sin = d.id_sin
			    And    ddet.id_gti = d.id_gti
			    And    ddet.id_detail = d.id_detail
			    And    ddet.nom_zone = 'qte' )
			  )
		,2 ) 'prix_unitaire', 

--'prix_total'
	d.mt_val_achat 'prix_total',

--'alt_modif'
	Case
		When g.id_gti   = 10  Then  'N' -- #1
		When g.cod_etat = 200 Then  'N'
		When g.cod_etat = 900 Then  'N'
		Else
			Case 
			  When d.cod_etat = 200 Then 'N'
			  When d.cod_etat = 900 Then 'N'
		  	  When d.cod_etat = 600 Then 'N'
			  When d.cod_etat = 100 Then 
					Case (
					Select 	sysadm.FN_TRIM ( ddet.val_car )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'pec' )
		  				When 'O' Then 
							Case 
								When ( Select 	count (*)
									From   	sysadm.div_det ddet
									Where  	ddet.id_sin = d.id_sin
									And 	ddet.id_gti = d.id_gti
									And 	ddet.id_detail = d.id_detail
									And 	ddet.nom_zone = 'alt_modif' ) > 0 
									Then 		(
											Select 	IsNull ( val_car, 'O' ) 
											From   	sysadm.div_det ddet
											Where  	ddet.id_sin = d.id_sin
											And 	ddet.id_gti = d.id_gti
											And 	ddet.id_detail = d.id_detail
											And 	ddet.nom_zone = 'alt_modif' ) 

								-- #1 Cas PGC
								When ( Select 	count (*)
									From   	sysadm.div_det ddet
									Where  	ddet.id_sin = d.id_sin
									And 	ddet.id_gti = d.id_gti
									And 	ddet.id_detail = d.id_detail
									And     ddet.id_gti = 15
									And 	ddet.nom_zone = 'typ_presta' ) > 0 
									Then 		(
											Select 	Case IsNull ( val_car, 'REP' ) 
													When 'REP' Then 'N'
													Else 'O'
												End 
											From   	sysadm.div_det ddet
											Where  	ddet.id_sin = d.id_sin
											And 	ddet.id_gti = d.id_gti
											And 	ddet.id_detail = d.id_detail
											And 	ddet.nom_zone = 'typ_presta' ) 
								-- /#1

								-- #2 [CASTO_SWAP] cas PANNE
								When ( Select 	count (*)
									From   	sysadm.div_det ddet
									Where  	ddet.id_sin = d.id_sin
									And 	ddet.id_gti = d.id_gti
									And 	ddet.id_detail = d.id_detail
									And     ddet.id_gti = 18
									And 	ddet.nom_zone = 'mat_non_transportable'
									And     ddet.val_car  = 'O') > 0 
									Then 	'N'  								
								-- :#2 [CASTO_SWAP]								
								

								Else 'O'
							End 
						Else 'N'
					End 
			  Else 
				Case 
					When ( Select 	count (*)
						From   	sysadm.div_det ddet
						Where  	ddet.id_sin = d.id_sin
						And 	ddet.id_gti = d.id_gti
						And 	ddet.id_detail = d.id_detail
						And 	ddet.nom_zone = 'alt_modif' ) > 0 
						Then 		(
								Select 	IsNull ( val_car, 'O' ) 
								From   	sysadm.div_det ddet
								Where  	ddet.id_sin = d.id_sin
								And 	ddet.id_gti = d.id_gti
								And 	ddet.id_detail = d.id_detail
								And 	ddet.nom_zone = 'alt_modif' ) 
					Else 'O'
				End 
			End
	End 'alt_modif',

--'cod_action'
	Case 
		When ( Select 	count (*)
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	nom_zone = 'cod_action' ) > 0 
			Then 		(
					Select 	IsNull ( val_nbre, -1 ) 
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'cod_action' ) 
		Else -1
	End 'cod_action',

--'lib_action'

	Case 
		When ( Select 	count (*)
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'cod_action' ) > 0 
			Then 	(Select cGC.lib_code
				 From   sysadm.code cGC
				 Where  cGC.id_typ_code = '-GC'
				 And    cGC.id_code = ( Select 	IsNull ( val_nbre, -1 ) 
							From   	sysadm.div_det ddet
							Where  	ddet.id_sin = d.id_sin
							And 	ddet.id_gti = d.id_gti
							And 	ddet.id_detail = d.id_detail
							And 	ddet.nom_zone = 'cod_action' )
				)
		Else ''
	End 'lib_action',
--dte_action
	Case 
		When ( Select 	count (*)
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'cod_action' ) > 0 
			Then 	(
				Select 	ddet.cree_le 
				From   	sysadm.div_det ddet
				Where  	ddet.id_sin = d.id_sin
				And 	ddet.id_gti = d.id_gti
				And 	ddet.id_detail = d.id_detail
				And 	ddet.nom_zone = 'cod_action' ) 
		Else null
	End 'dte_action',
-- #2 [CASTO_SWAP]	
	Case 
		When ( Select 	count (*)
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'ref_article_casto' ) > 0 
			Then 	(
				Select 	ddet.val_car
				From   	sysadm.div_det ddet
				Where  	ddet.id_sin = d.id_sin
				And 	ddet.id_gti = d.id_gti
				And 	ddet.id_detail = d.id_detail
				And 	ddet.nom_zone = 'ref_article_casto' ) 
		Else null
	End 'ref_article_casto',
	Case 
		When ( Select 	count (*)
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'mat_non_transportable' ) > 0 
			Then 	(
				Select 	IsNull ( Case ddet.val_car
							When 'O' Then 'N'
							When 'N' Then 'O'
						End 
						, 'O' )
				From   	sysadm.div_det ddet
				Where  	ddet.id_sin = d.id_sin
				And 	ddet.id_gti = d.id_gti
				And 	ddet.id_detail = d.id_detail
				And 	ddet.nom_zone = 'mat_non_transportable' ) 
		Else 'O'
	End 'mat_transportable',
	d.dte_det 'dte_achat'
-- :#2 [CASTO_SWAP]	
	

From 	sysadm.detail d,
	sysadm.sinistre s,
	sysadm.gar_sin g,
	sysadm.code_garantie cGTI

Where 	s.id_prod between 23400 and 23499
And 	d.id_sin = s.id_sin
And 	s.id_sin = @dcIdSin
And 	cGTI.id_prod = s.id_prod 
And	cGTI.id_gti  = d.id_gti
And 	g.id_sin = s.id_sin
And	g.id_gti = d.id_gti
And 	s.id_sin not in ( 1037121 ) 

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S03_CW_LISTE_SINISTRE
-- Auteur               :       FABRY JF
-- Date                 :       18/10/2005
-- Libellé              :       Donnée liée aux sinistres
-- Commentaires         :       DMDI 14964 "s.id_sin not in" dossier exclu.
--
-- Arguments            :       @dcIdSin    Decimal (  7, 0 )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S03_CW_LISTE_SINISTRE' AND type = 'P' )
        DROP procedure sysadm.PS_S03_CW_LISTE_SINISTRE
GO


CREATE procedure sysadm.PS_S03_CW_LISTE_SINISTRE
        @dcIdSin    Decimal (  10, 0 ) 	= null, -- [PI062]
	@sNumCarte  VarChar ( 19 ) 	= null,
	@sNumMag    VarChar ( 10 ) 	= null,
	@sNumCaisse VarChar ( 10 ) 	= null,
	@sNumHotesse VarChar ( 10 ) 	= null,
	@sNumTicket VarChar ( 10 ) 	= null
AS

Select  
--'nom_assure'
	sysadm.FN_TRIM (sysadm.FN_TRIM (cCI.lib_code) + ' ' + Upper ( Substring ( sysadm.FN_TRIM (p.prenom), 1, 1 ) ) + 
		Case When len (p.prenom) > 1 Then Lower ( Substring ( p.prenom, 2, len (p.prenom) - 1  ) ) else '' End + 
		' ' + Upper ( Substring ( p.nom, 1, 1 ) ) + Lower ( Substring ( sysadm.FN_TRIM (p.nom), 2, len (sysadm.FN_TRIM (p.nom)) - 1  ))) 'nom_assure',
--'ref_sin_spb'
	s.id_sin 'ref_sin_spb',
--'dte_surv'
	s.dte_surv 'dte_surv',
--'dte_decl'
	s.dte_decl 'dte_decl',
--'lib_garantie'
	sysadm.FN_TRIM ( cGTI.lib_gti ) 'lib_garantie',
--'Numéro ticket'
	(
	 (
	Select  sysadm.FN_TRIM ( Convert ( VarChar ( 10 ), div1.val_nbre ) )
	From 	sysadm.div_sin div1
	Where 	div1.id_sin = s.id_sin
	And	div1.nom_zone = 'num_mag' ) +'-'+ 
 	 (
	Select  sysadm.FN_TRIM ( Convert ( VarChar ( 10 ), div1.val_nbre ) )
	From 	sysadm.div_sin div1
	Where 	div1.id_sin = s.id_sin
	And	div1.nom_zone = 'num_caisse' ) +'-' +
	 (
	Select  sysadm.FN_TRIM ( Convert ( VarChar ( 10 ), div1.val_nbre ) )
	From 	sysadm.div_sin div1
	Where 	div1.id_sin = s.id_sin
	And	div1.nom_zone = 'num_hotesse' )	+'-' +
 	 (
	Select  sysadm.FN_TRIM ( Convert ( VarChar ( 10 ), div1.val_nbre ) )
	From 	sysadm.div_sin div1
	Where 	div1.id_sin = s.id_sin
	And	div1.nom_zone = 'num_ticket' ) 
	) 'num_ticket',
--'num_carte'
	s.id_adh 'num_carte',
--'id_prod'
	s.id_prod
	

From	sysadm.sinistre s,
	sysadm.gar_sin  g,
	sysadm.code_garantie cGTI,
	sysadm.personne p,
	sysadm.code cCI 

Where 	s.id_sin = @dcIdSin 
And 	@dcIdSin is Not null 
And 	g.id_sin = s.id_sin
And 	cGTI.id_prod = s.id_prod 
And	cGTI.id_gti  = g.id_gti
And 	s.id_ordre = p.id_ordre
And 	cCI.id_typ_code = '-CI'
And 	cCI.id_code = p.cod_civ
And 	s.id_prod between 23400 and 23499
And 	s.id_sin not in ( 1037121 ) 

Union

Select  
--'nom_assure'
	sysadm.FN_TRIM (sysadm.FN_TRIM (cCI.lib_code) + ' ' + Upper ( Substring ( sysadm.FN_TRIM (p.prenom), 1, 1 ) ) + 
		Case When len (p.prenom) > 1 Then Lower ( Substring ( p.prenom, 2, len (p.prenom) - 1  ) ) else '' End + 
		' ' + Upper ( Substring ( p.nom, 1, 1 ) ) + Lower ( Substring ( sysadm.FN_TRIM (p.nom), 2, len (sysadm.FN_TRIM (p.nom)) - 1  ))) 'nom_assure',
--'ref_sin_spb'
	s.id_sin 'ref_sin_spb',
--'dte_surv'
	s.dte_surv 'dte_surv',
--'dte_decl'
	s.dte_decl 'dte_decl',
--'lib_garantie'
	sysadm.FN_TRIM ( cGTI.lib_gti ) 'lib_garantie',
--'Numéro ticket'
	(
	 (
	Select  sysadm.FN_TRIM ( Convert ( VarChar ( 10 ), div1.val_nbre ) )
	From 	sysadm.div_sin div1
	Where 	div1.id_sin = s.id_sin
	And	div1.nom_zone = 'num_mag' ) +'-'+ 
 	 (
	Select  sysadm.FN_TRIM ( Convert ( VarChar ( 10 ), div1.val_nbre ) )
	From 	sysadm.div_sin div1
	Where 	div1.id_sin = s.id_sin
	And	div1.nom_zone = 'num_caisse' ) +'-' +
	 (
	Select  sysadm.FN_TRIM ( Convert ( VarChar ( 10 ), div1.val_nbre ) )
	From 	sysadm.div_sin div1
	Where 	div1.id_sin = s.id_sin
	And	div1.nom_zone = 'num_hotesse' )	+'-' +
 	 (
	Select  sysadm.FN_TRIM ( Convert ( VarChar ( 10 ), div1.val_nbre ) )
	From 	sysadm.div_sin div1
	Where 	div1.id_sin = s.id_sin
	And	div1.nom_zone = 'num_ticket' ) 
	) 'num_ticket',
--'num_carte'
	s.id_adh 'num_carte',
--'id_prod'
	s.id_prod

From	sysadm.sinistre s,
	sysadm.gar_sin  g,
	sysadm.code_garantie cGTI,
	sysadm.personne p,
	sysadm.code cCI 

Where 	s.id_adh = @sNumCarte   -- [PI038][RELEVE]
And 	@sNumCarte is Not null
And 	g.id_sin = s.id_sin
And 	cGTI.id_prod = s.id_prod 
And	cGTI.id_gti  = g.id_gti
And 	s.id_ordre = p.id_ordre
And 	cCI.id_typ_code = '-CI'
And 	cCI.id_code = p.cod_civ
And 	s.id_prod between 23400 and 23499
And 	s.id_sin not in ( 1037121 ) 

Union

Select  
--'nom_assure'
	sysadm.FN_TRIM (sysadm.FN_TRIM (cCI.lib_code) + ' ' + Upper ( Substring ( sysadm.FN_TRIM (p.prenom), 1, 1 ) ) + 
		Case When len (p.prenom) > 1 Then Lower ( Substring ( p.prenom, 2, len (p.prenom) - 1  ) ) else '' End	+ 
		' ' + Upper ( Substring ( p.nom, 1, 1 ) ) + Lower ( Substring ( sysadm.FN_TRIM (p.nom), 2, len (sysadm.FN_TRIM (p.nom)) - 1  ))) 'nom_assure',
--'ref_sin_spb'
	s.id_sin 'ref_sin_spb',
--'dte_surv'
	s.dte_surv 'dte_surv',
--'dte_decl'
	s.dte_decl 'dte_decl',
--'lib_garantie'
	sysadm.FN_TRIM ( cGTI.lib_gti ) 'lib_garantie',
--'Numéro ticket'
	(
	 (
	Select  sysadm.FN_TRIM ( Convert ( VarChar ( 10 ), div1.val_nbre ) )
	From 	sysadm.div_sin div1
	Where 	div1.id_sin = s.id_sin
	And	div1.nom_zone = 'num_mag' ) +'-'+ 
 	 (
	Select  sysadm.FN_TRIM ( Convert ( VarChar ( 10 ), div1.val_nbre ) )
	From 	sysadm.div_sin div1
	Where 	div1.id_sin = s.id_sin
	And	div1.nom_zone = 'num_caisse' ) +'-' +
	 (
	Select  sysadm.FN_TRIM ( Convert ( VarChar ( 10 ), div1.val_nbre ) )
	From 	sysadm.div_sin div1
	Where 	div1.id_sin = s.id_sin
	And	div1.nom_zone = 'num_hotesse' )	+'-' +
 	 (
	Select  sysadm.FN_TRIM ( Convert ( VarChar ( 10 ), div1.val_nbre ) )
	From 	sysadm.div_sin div1
	Where 	div1.id_sin = s.id_sin
	And	div1.nom_zone = 'num_ticket' ) 
	) 'num_ticket',
--'num_carte'
	s.id_adh 'num_carte',
--'id_prod'
	s.id_prod

From	sysadm.sinistre s,
	sysadm.gar_sin  g,
	sysadm.code_garantie cGTI,
	sysadm.personne p,
	sysadm.code cCI 

Where 	s.id_sin = 
		  (  	Select  div1.id_sin
			From 	sysadm.div_sin div1
			Where 	div1.nom_zone = 'num_ticket'
			And 	div1.val_nbre = @sNumTicket  
			And 	Exists ( 
				Select  div2.*
				From 	sysadm.div_sin div2
				Where 	div2.id_sin = div1.id_sin
				And	div2.nom_zone = 'num_hotesse'
				And 	div2.val_nbre = @sNumHotesse )
			And 	Exists ( 
				Select  div2.*
				From 	sysadm.div_sin div2
				Where 	div2.id_sin = div1.id_sin
				And	div2.nom_zone = 'num_caisse'
				And 	div2.val_nbre = @sNumCaisse )			  
			And 	Exists ( 
				Select  div2.*
				From 	sysadm.div_sin div2
				Where 	div2.id_sin = div1.id_sin
				And	div2.nom_zone = 'num_mag'
				And 	div2.val_nbre = @sNumMag )	
		   )

And 	g.id_sin = s.id_sin
And 	cGTI.id_prod = s.id_prod 
And	cGTI.id_gti  = g.id_gti
And 	s.id_ordre = p.id_ordre
And 	cCI.id_typ_code = '-CI'
And 	cCI.id_code = p.cod_civ
And 	s.id_prod between 23400 and 23499
And 	s.id_sin not in ( 1037121 ) 

Go
	
--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_CW_ACTION_CASTO
-- Auteur               :       FABRY JF
-- Date                 :       18/10/2005
-- Libellé              :       Donnée liée aux articles
-- Commentaires         :       
--
-- Arguments            :       @dcIdSin    Decimal (  7, 0 )
--
-- Retourne             :       Rien
--
-- #1   JFF    10/01/2007  DCMP060798/060799
-- #2   JFF    05/09/2008  Suite migration en config PRO et TEST par Fabien et SBA
--      JFF    24/09/2013  [PC509][-2][MANTIS8274]
--      JFF    12/02/2016  [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_CW_ACTION_CASTO_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I01_CW_ACTION_CASTO_V01
GO

CREATE procedure sysadm.PS_I01_CW_ACTION_CASTO_V01
        @dcIdSin    Decimal (  10, 0 ), -- [PI062]
        @dcIdGti    Decimal (  7, 0 ),
        @dcIdDetail Decimal (  7, 0 ),
        @iCodAction Integer,
        @sTexteLibre VarChar ( 50 ) -- [PC509][-2][MANTIS8274]
AS

Declare @sInsertW VarChar ( 3 )
Declare @sInsertP VarChar ( 3 )
Declare @sMess 	  VarChar ( 2000 )
Declare @sObjet	  VarChar ( 200 )
Declare @sAltModif  VarChar ( 1 )
Declare @sErr 	  Varchar(60)

Set @sInsertP = 'OUI'
Set @sInsertW = 'OUI'
Set @sAltModif = 'N'

-- Sommes-nous en insertion ou maj sur les tables W
If ( 
	Select 	count ( * ) 
	From   	sysadm.div_det ddet
	Where  	ddet.id_sin = @dcIdSin
	And 	ddet.id_gti = @dcIdGti
	And 	ddet.id_detail = @dcIdDetail
	And 	ddet.nom_zone = 'cod_action' ) > 0
	Begin
  		Set @sInsertP = 'NON'
 	End 

If ( 
	Select 	count ( * ) 
	From   	sysadm.w_div_det ddet
	Where  	ddet.id_sin = @dcIdSin
	And 	ddet.id_gti = @dcIdGti
	And 	ddet.id_detail = @dcIdDetail
	And 	ddet.nom_zone = 'cod_action' ) > 0
	Begin
  		Set @sInsertW = 'NON'
 	End 


If @sInsertP = 'OUI'
 Begin	
	Insert into sysadm.div_det ( 
		id_sin,
		id_gti,
		id_detail,
		nom_zone,
		lib_label,
		id_typ_liste,
		alt_liste_codecar,
		id_typ_zone,
		alt_oblig,
		alt_prot,
		cpt_tri,
		val_nbre,
		val_mt,
		val_dte,
		val_car,
		cree_le,
		maj_le,
		maj_par,
		valide_le,
		valide_par
		)
		
		values 
		
		(
		@dcIdSin,
		@dcIdGti,
	        @dcIdDetail,
	        'cod_action',
	        'Décision CASTORAMA',
	        '-GC',
	        'N',
	        'LN',
	        'N',
	        'O',
	        500,
	        @iCodAction,
	        null,
	     	null,
	     	null,
	     	Getdate(), 
	     	Getdate(),     
		'CAST',
	     	Getdate(),     
	        'CAST'
		)
End 

If @sInsertW = 'OUI'
 Begin
	Insert into sysadm.w_div_det ( 
		id_sin,
		id_gti,
		id_detail,
		nom_zone,
		lib_label,
		id_typ_liste,
		alt_liste_codecar,
		id_typ_zone,
		alt_oblig,
		alt_prot,
		cpt_tri,
		val_nbre,
		val_mt,
		val_dte,
		val_car,
		cpt_valide,
		cree_le,
		maj_le,
		maj_par
		)
		
		values 
		
		(
		@dcIdSin,
		@dcIdGti,
	        @dcIdDetail,
	        'cod_action',
	        'Décision CASTORAMA',
	        '-GC',
	        'N',
	        'LN',
	        'N',
	        'O',
	        500,
	        @iCodAction,
	        null,
	     	null,
	     	null,
	     	1,
	     	Getdate(), 
	     	Getdate(),     
		'CAST'
		)
 End 

If @sInsertP = 'NON'
 Begin
	Update 	sysadm.div_det
	Set	val_nbre = @iCodAction,
		maj_le   = GetDate (),	
		maj_par  = 'CAST',
		valide_le   = GetDate (),	
		valide_par  = 'CAST'
	Where	id_sin = @dcIdSin
	And 	id_gti = @dcIdGti
	And 	id_detail = @dcIdDetail
	And 	nom_zone = 'cod_action'
 End 

If @sInsertW = 'NON'
 Begin
	Update 	sysadm.w_div_det
	Set	val_nbre = @iCodAction,
		maj_le   = GetDate (),	
		maj_par  = 'CAST'
	Where	id_sin = @dcIdSin
	And 	id_gti = @dcIdGti
	And 	id_detail = @dcIdDetail
	And 	nom_zone = 'cod_action'
 End 


Set @sInsertP = 'OUI'
Set @sInsertW = 'OUI'

-- Gestion du ALT_MODIF pour le cas 53
if @iCodAction = 53
 Begin
   -- Set @sAltModif = 'O'
   Set @sAltModif = 'N' -- #1
 End 

-- Sommes-nous en insertion ou maj sur les tables W
If ( 
	Select 	count ( * ) 
	From   	sysadm.div_det ddet
	Where  	ddet.id_sin = @dcIdSin
	And 	ddet.id_gti = @dcIdGti
	And 	ddet.id_detail = @dcIdDetail
	And 	ddet.nom_zone = 'alt_modif' ) > 0
	Begin
  		Set @sInsertP = 'NON'
 	End 

If ( 
	Select 	count ( * ) 
	From   	sysadm.w_div_det ddet
	Where  	ddet.id_sin = @dcIdSin
	And 	ddet.id_gti = @dcIdGti
	And 	ddet.id_detail = @dcIdDetail
	And 	ddet.nom_zone = 'alt_modif' ) > 0
	Begin
  		Set @sInsertW = 'NON'
 	End 

If @sInsertP = 'OUI'
 Begin	
	Insert into sysadm.div_det ( 
		id_sin,
		id_gti,
		id_detail,
		nom_zone,
		lib_label,
		id_typ_liste,
		alt_liste_codecar,
		id_typ_zone,
		alt_oblig,
		alt_prot,
		cpt_tri,
		val_nbre,
		val_mt,
		val_dte,
		val_car,
		cree_le,
		maj_le,
		maj_par,
		valide_le,
		valide_par
		)
		
		values 
		
		(
		@dcIdSin,
		@dcIdGti,
	        @dcIdDetail,
	        'alt_modif',
	        'Décision CASTORAMA modifiable',
	        '-GC',
	        'N',
	        'X',
	        'N',
	        'O',
	        510,
	        null,
	        null,
	     	null,
	     	@sAltModif,
	     	Getdate(), 
	     	Getdate(),     
		'CAST',
	     	Getdate(),     
	        'CAST'
		)
End 

If @sInsertW = 'OUI'
 Begin
	Insert into sysadm.w_div_det ( 
		id_sin,
		id_gti,
		id_detail,
		nom_zone,
		lib_label,
		id_typ_liste,
		alt_liste_codecar,
		id_typ_zone,
		alt_oblig,
		alt_prot,
		cpt_tri,
		val_nbre,
		val_mt,
		val_dte,
		val_car,
		cpt_valide,
		cree_le,
		maj_le,
		maj_par
		)
		
		values 
		
		(
		@dcIdSin,
		@dcIdGti,
	        @dcIdDetail,
	        'alt_modif',
	        'Décision CASTORAMA modifiable',
	        '-GC',
	        'N',
	        'X',
	        'N',
	        'O',
	        510,
	        null,
	        null,
	     	null,
	     	@sAltModif,
	     	1,
	     	Getdate(), 
	     	Getdate(),     
		'CAST'
		)
 End 

If @sInsertP = 'NON'
 Begin
	Update 	sysadm.div_det
	Set	val_car = @sAltModif,
		maj_le   = GetDate (),	
		maj_par  = 'CAST',
		valide_le   = GetDate (),	
		valide_par  = 'CAST'
	Where	id_sin = @dcIdSin
	And 	id_gti = @dcIdGti
	And 	id_detail = @dcIdDetail
	And 	nom_zone = 'alt_modif'
 End 

If @sInsertW = 'NON'
 Begin
	Update 	sysadm.w_div_det
	Set	val_car = @sAltModif,
		maj_le   = GetDate (),	
		maj_par  = 'CAST'
	Where	id_sin = @dcIdSin
	And 	id_gti = @dcIdGti
	And 	id_detail = @dcIdDetail
	And 	nom_zone = 'alt_modif'
 End 


/* Cas du REFUS SUITE EXPERTISE :
	- Envoi Mail à Nathalie Béchéri
	- Création Travail
	- Création Contact
*/
if @iCodAction = 55
 Begin
	Set @sMess = 'CASTORAMA refuse le détail n°' + Convert ( VarChar ( 3 ), @dcIdDetail ) 
	Set @sMess = @sMess + ' de la garantie n°' + Convert ( VarChar ( 3 ), @dcIdGti ) 
 	Set @sMess = @sMess + ' du sinistre n°' + Convert ( VarChar ( 10 ), @dcIdSin ) -- [PI062]
	Set @sMess = @sMess + ' pour le motif suivant : REFUS SUITE EXPERTISE.' + CHAR (13) 
	-- [PC509][-2][MANTIS8274]
	Set @sMess = @sMess + ' Texte provenant de CASTORAMA : ' + rTrim ( ltrim ( IsNull ( @sTexteLibre, '') ) )

	Set @sMess = LEFT ( @sMess, 254) -- [PC509][-2][MANTIS8274]


	IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sMess, 'GGU', @sErr output, 0 , null, 'I', null, 0
	Else
		EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sMess, 'GGU', @sErr output, 0 , null, 'I', null, 0


	Set @sMess = 'CASTORAMA vient de refuser le détail n°' + Convert ( VarChar ( 3 ), @dcIdDetail ) 
	Set @sMess = @sMess + ' de la garantie n°' + Convert ( VarChar ( 3 ), @dcIdGti ) 
 	Set @sMess = @sMess + ' du sinistre n°' + Convert ( VarChar ( 10 ), @dcIdSin ) -- [PI062]
	Set @sMess = @sMess + ' pour le motif suivant : REFUS SUITE EXPERTISE.' + CHAR (13)
	-- [PC509][-2][MANTIS8274]
	Set @sMess = @sMess + ' Texte provenant de CASTORAMA : ' + rTrim ( ltrim ( IsNull ( @sTexteLibre, '') ) )
	Set @sMess = @sMess + CHAR (13) + CHAR (13)

	If Upper ( @sErr ) = 'OK' 
	  Begin
	 	Set @sMess = @sMess + 'Un travail en complément vient d''être créé sur le dossier ainsi qu''un contact.' 
		Set @sMess = @sMess + CHAR (13) + CHAR (13)
	 	Set @sMess = @sMess + 'Reprenez le dossier afin de Contrôler/Valider le détail pour le refuser.'
	  End 
	Else
	  Begin
		Set @sMess = @sMess + 'Le travail en complément n''a pas pu être créé suite au problème suivant : ' + @sErr
		Set @sMess = @sMess + CHAR (13) + CHAR (13)
		Set @sMess = @sMess + 'Le contact a malgré tout été créé.'
	  End 

	Set @sObjet = 'CASTORAMA : REFUS SUITE EXPERTISE Dossier ' + Convert ( VarChar ( 10 ), @dcIdSin ) + '/' + Convert ( VarChar ( 3 ), @dcIdGti ) + '/' + Convert ( VarChar ( 3 ), @dcIdDetail ) -- [PI062]

	IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	  Begin
		Exec sysadm.PS_S01_MAIL  'ggu@spb.eu,mpt@spb.eu', 
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
	Else
	  Begin
		Exec sysadm.PS_S01_MAIL  'glm@spb.fr', 
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

 End 

Go

--------------------------------------------------------------------
--
-- Procédure            :       VU_S01_STAT_CASTO
-- Auteur               :       FABRY JF
-- Date                 :       21/11/2005
-- Libellé              :       Vu pour les stats WEB
-- Commentaires         :       Commentaire et ordre colonne :
--				'ref_sin'
--				'dte_survenance'
--				'dte_declaration'
--				'nom_client'
--				'prenom_client'
--				'nom_client_complet'
--				'adresse1'
--				'adresse2'
--				'code_postal'
--				'ville'
--				'num_carte'
--				'dte_ticket'
--				'num_magasin'
--				'nom_magasin'
--				'region_magasin'
--				'num_caisse'
--				'num_hotesse'
--				'num_ticket'
--				'Garantie'
--				'Date_Achat'
--				'type_accord'
--				'nbre_art_pec_avec_qte'
--				'nbre_total_article'
--				'quantite'
--				'description_article'
--				'valeur_unitaire_article_sinistre'
--				'valeur_totale_article_sinistre'
--				'prejudice_total_sinistre'
--				'prejudice_total_sinistre_PEC'
--				'lib_action_CASTORAMA'
--				'dte_action_CASTORAMA'
--				'au_moins_une_action_CASTO'
--				'Date_premier_reglement'
--
--				DMDI 14964 "s.id_sin not in" dossier exclu.
--
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- 
-- #1	JFF	18/03/2008	[DCMP090080]
--      JFF     06/12/2010      [ITSM_852785]
--	PHG	04/02/2011	[BLOCAGE] Copie de VU_S01_STAT_CASTO
--				en PS_S01_STAT_CASTO
--				/!\ ATTENTION /!\ Si VU_S01_STAT_CASTO évolue
--				PS_S01_STAT_CASTO doit évoluer de la même manière et vice versa
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'VU_S01_STAT_CASTO' AND type = 'V' )
        DROP view sysadm.VU_S01_STAT_CASTO
GO

CREATE view sysadm.VU_S01_STAT_CASTO
As
--1
Select  s.id_sin 'ref_sin',
	s.dte_surv 'dte_survenance',
	s.dte_decl 'dte_declaration',
	sysadm.FN_TRIM (p.nom) 'nom_client',
	sysadm.FN_TRIM (p.prenom) 'prenom_client',
	sysadm.FN_TRIM (sysadm.FN_TRIM (cCI.lib_code) + ' ' + Upper ( sysadm.FN_TRIM (p.nom)) + ', ' + Upper ( Substring ( sysadm.FN_TRIM (p.prenom), 1, 1 ) ) + 
		Case When len (p.prenom) > 1 Then Lower ( Substring ( p.prenom, 2, len (p.prenom) - 1  ) ) else '' End ) 'nom_client_complet' ,
 	Upper ( sysadm.FN_TRIM (p.adr_1 )) 'adresse1',
 	Upper ( sysadm.FN_TRIM (p.adr_2 )) 'adresse2',
 	Upper ( sysadm.FN_TRIM (p.adr_cp )) 'code_postal',
 	Upper ( sysadm.FN_TRIM (p.adr_ville )) 'ville',
 	Upper ( sysadm.FN_TRIM (s.id_adh )) 'num_carte',
 	(Select	val_dte
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin 	 And 	dp.nom_zone = 'dte_ticket' ) 'dte_ticket',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_mag' ) 'num_magasin',
	( Select Top 1 b.adr_ville
	  From   boutique b
	  Where  b.id_prod between 23400 and 23499
	  And 	 b.id_boutique = (Select	val_nbre
			 	 From 	sysadm.div_sin dp
			 	 Where  dp.id_sin = s.id_sin
			 	 And 	dp.nom_zone = 'num_mag' )) 'nom_magasin',
	( Select Top 1 b.region
	  From   boutique b
	  Where  b.id_prod between 23400 and 23499
	  And 	 b.id_boutique = (Select	val_nbre
			 	 From 	sysadm.div_sin dp
			 	 Where  dp.id_sin = s.id_sin
			 	 And 	dp.nom_zone = 'num_mag' )) 'region_magasin',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_caisse' ) 'num_caisse',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_hotesse' ) 'num_hotesse',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_ticket' ) 'num_ticket',
	 cGA.lib_gti 'garantie',
	 d.dte_det 'dte_achat',

--'type_accord'
	Case 
		When g.cod_etat = 200 Then  'Garantie refusée'
		When g.cod_etat = 900 Then  'Garantie sans suite'
		Else
			Case
			  When d.cod_etat = 200 Then 'Article refusé'
			  When d.cod_etat = 900 Then 'Article sans suite'

		  	  When d.cod_etat = 600 Then 'Article pris en charge'
			  When d.cod_etat = 100 Then 
				(	Case (
					Select 	sysadm.FN_TRIM ( ddet.val_car )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'pec' )

						When 'O' Then 'Article pris en charge'
						Else 'A déterminer par SPB'

					End 
				)
		  	  ELSE 'A déterminer par SPB'
			End 
	End 'type_accord',

-- Nbre d'article prix en charges en tenant comptes des quantités
	(
	Select 	IsNull ( sum ( ddet1.val_nbre ), 0 )
	From   	sysadm.div_det ddet1
	Where  	ddet1.id_sin = d.id_sin
	And 	ddet1.id_gti = d.id_gti
	And 	ddet1.nom_zone = 'qte' 
	And 	Exists (
		Select  *
		From    sysadm.div_det ddet2
		Where   ddet2.id_sin = ddet1.id_sin 
		And 	ddet2.id_gti = ddet1.id_gti
		And 	ddet2.id_detail = ddet1.id_detail
		And 	ddet2.nom_zone = 'pec'
		And 	ddet2.val_car = 'O')
	) 'nbre_art_pec_avec_qte',

-- Nbre total d'article total
	(
	Select 	IsNull ( sum ( ddet.val_nbre ), 0 )
	From   	sysadm.div_det ddet
	Where  	ddet.id_sin = d.id_sin
	And 	ddet.id_gti = d.id_gti
	And 	ddet.nom_zone = 'qte' 
	) 'nbre_total_article',

--'quantite'
	(
	Select 	ddet.val_nbre
	From   	sysadm.div_det ddet
	Where  	ddet.id_sin = d.id_sin
	And 	ddet.id_gti = d.id_gti
	And 	ddet.id_detail = d.id_detail
	And 	ddet.nom_zone = 'qte' ) 'quantite',

--'description_article'
	Case 
		When ( Select 	count (*)
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'aucune_marq' ) > 0 
			Then 	Case		
				When
					(
					Select 	sysadm.FN_TRIM ( ddet.val_car )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'aucune_marq' ) = 'O' 
					Then 
						(Select sysadm.FN_TRIM ( ddet.val_car )
						From   	sysadm.div_det ddet
						Where  	ddet.id_sin = d.id_sin
						And 	ddet.id_gti = d.id_gti
						And 	ddet.id_detail = d.id_detail
						And 	ddet.nom_zone = 'modl_app' )

				When
					(
					Select 	sysadm.FN_TRIM ( ddet.val_car )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'aucune_marq' ) = 'N' 
					Then 						
						(Select sysadm.FN_TRIM ( ddet.val_car )
						From   	sysadm.div_det ddet
						Where  	ddet.id_sin = d.id_sin
						And 	ddet.id_gti = d.id_gti
						And 	ddet.id_detail = d.id_detail
						And 	ddet.nom_zone = 'modl_app' )
						+ ' ' +
						(Select sysadm.FN_TRIM ( ddet.val_car )
						From   	sysadm.div_det ddet
						Where  	ddet.id_sin = d.id_sin
						And 	ddet.id_gti = d.id_gti
						And 	ddet.id_detail = d.id_detail
						And 	ddet.nom_zone = 'marq_app' )
				End 
		Else 	(Select sysadm.FN_TRIM ( ddet.val_car )
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'modl_app' )
			+ ' ' +
			(Select sysadm.FN_TRIM ( ddet.val_car )
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'marq_app' )

	End 'description_article',

--'prix_unitaire'
	Round ( 
		  Convert ( decimal ( 11,2) , d.mt_val_achat )
			/ 
		  Convert ( decimal ( 11,2) , 
			   (Select ddet.val_nbre
  			    From   sysadm.div_det ddet
			    Where  ddet.id_sin = d.id_sin
			    And    ddet.id_gti = d.id_gti
			    And    ddet.id_detail = d.id_detail
			    And    ddet.nom_zone = 'qte' )
			  )
		,2 ) 'valeur_unitaire_article_sinistre', 

--'prix_total_article'
	d.mt_val_achat 'valeur_totale_article_sinistre',
--'Préjudice_total_sinistre'
	( Select IsNull ( Sum ( d2.mt_val_achat ), 0 ) 
	From   	sysadm.detail d2
	Where  	d2.id_sin = d.id_sin
	And 	d2.id_gti = d.id_gti
	)'prejudice_total_sinistre',
--'Préjudice_total_sinistre_PEC'
	( Select IsNull ( Sum ( d1.mt_val_achat ), 0 ) 
	From   	sysadm.detail d1
	Where  	d1.id_sin = d.id_sin
	And 	d1.id_gti = d.id_gti
	And 	Exists (
		Select  *
		From    sysadm.div_det ddet2
		Where   ddet2.id_sin = d1.id_sin 
		And 	ddet2.id_gti = d1.id_gti
		And 	ddet2.id_detail = d1.id_detail
		And 	ddet2.nom_zone = 'pec'
		And 	ddet2.val_car = 'O')	
	)'prejudice_total_sinistre_pec',	
--'lib_action'

	Case 
		When ( Select 	count (*)
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'cod_action' ) > 0 
			Then 	(Select cGC.lib_code
				 From   sysadm.code cGC
				 Where  cGC.id_typ_code = '-GC'
				 And    cGC.id_code = ( Select 	IsNull ( val_nbre, -1 ) 
							From   	sysadm.div_det ddet
							Where  	ddet.id_sin = d.id_sin
							And 	ddet.id_gti = d.id_gti
							And 	ddet.id_detail = d.id_detail
							And 	ddet.nom_zone = 'cod_action' )
				)
		Else ''
	End 'lib_action_CASTORAMA',

--'dte_action_CASTORAMA'
	Case 
		When ( Select 	count (*)
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'cod_action' ) > 0 
			Then 	(
				Select 	ddet.cree_le 
				From   	sysadm.div_det ddet
				Where  	ddet.id_sin = d.id_sin
				And 	ddet.id_gti = d.id_gti
				And 	ddet.id_detail = d.id_detail
				And 	ddet.nom_zone = 'cod_action' ) 
		Else null
	End 'dte_action_CASTORAMA',

-- Au moins une action CASTO
	Case  When ( 
		Select IsNull ( Convert ( decimal ( 11,2), count (*) ), 0 )
		From   	sysadm.div_det ddet
		Where  	ddet.id_sin = d.id_sin
		And 	ddet.id_gti = d.id_gti
		And 	ddet.nom_zone = 'marq_app' ) > 0 
		Then 
			
			Case	(Round ( 
					(
					Select 	IsNull ( Convert ( decimal ( 11,2), count (*) ), 0 )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.nom_zone = 'cod_action' 
					) 
					/
					(
					Select 	IsNull ( Convert ( decimal ( 11,2), count (*) ), 0 )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.nom_zone = 'marq_app'
					) 
					,2 ))
				When 1 Then 'OUI'
				When 0 Then 'NON'
				Else 'PARTIEL'
			End 

		Else 'NON'
	End 'au_moins_une_action_CASTO',
	
-- #1 [DCMP090080]
-- [ITSM_852785]
	(Select TOP 1 r.dte_reg
	 From 	sysadm.reglement r
	 Where	r.id_sin = s.id_sin
	 And    r.cod_mot_reg = 'RN'
	 And 	r.cod_mode_reg = 'FM'
	 And    r.dte_reg = ( 	 Select Min ( r2.dte_reg )
				 From 	sysadm.reglement r2
				 Where	r2.id_sin = r.id_sin
				 And    r2.cod_mot_reg = r.cod_mot_reg
	 			 And 	r2.cod_mode_reg = r.cod_mode_reg 
			     ) 
	) 'Date_premier_reglement'
			     


	
From	sysadm.sinistre s,
	sysadm.personne p,
	sysadm.gar_sin  g,
	sysadm.detail d,
	sysadm.code_garantie cGA,
	sysadm.code cCI
Where   s.id_prod between 23400 and 23499
And 	s.id_sin = g.id_sin
And	p.id_ordre = s.id_ordre
And	cGA.id_prod = s.id_prod
And	cGA.id_gti = g.id_gti
And 	d.id_sin = s.id_sin
And 	d.id_gti = g.id_gti
And 	cCI.id_typ_code = '-CI'
And 	cCI.id_code = p.cod_civ
And 	s.id_sin not in ( 1037121 ) 

Union all 

--2
Select  s.id_sin 'ref_sin',
	s.dte_surv 'dte_survenance',
	s.dte_decl 'dte_declaration',
	sysadm.FN_TRIM (p.nom) 'nom_client',
	sysadm.FN_TRIM (p.prenom) 'prenom_client',
	sysadm.FN_TRIM (sysadm.FN_TRIM (cCI.lib_code) + ' ' + Upper ( sysadm.FN_TRIM (p.nom)) + ', ' + Upper ( Substring ( sysadm.FN_TRIM (p.prenom), 1, 1 ) ) +
		Case When len (p.prenom) > 1 Then Lower ( Substring ( p.prenom, 2, len (p.prenom) - 1  ) ) else '' End	) 'nom_client_complet' ,
 	Upper ( sysadm.FN_TRIM (p.adr_1 )) 'adresse1',
 	Upper ( sysadm.FN_TRIM (p.adr_2 )) 'adresse2',
 	Upper ( sysadm.FN_TRIM (p.adr_cp )) 'code_postal',
 	Upper ( sysadm.FN_TRIM (p.adr_ville )) 'ville',
 	Upper ( sysadm.FN_TRIM (s.id_adh )) 'num_carte',
 	(Select	val_dte
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin 	 And 	dp.nom_zone = 'dte_ticket' ) 'dte_ticket',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_mag' ) 'num_magasin',
	( Select Top 1 b.adr_ville
	  From   boutique b
	  Where  b.id_prod between 23400 and 23499
	  And 	 b.id_boutique = (Select	val_nbre
			 	 From 	sysadm.div_sin dp
			 	 Where  dp.id_sin = s.id_sin
			 	 And 	dp.nom_zone = 'num_mag' )) 'nom_magasin',
	( Select Top 1 b.region
	  From   boutique b
	  Where  b.id_prod between 23400 and 23499
	  And 	 b.id_boutique = (Select	val_nbre
			 	 From 	sysadm.div_sin dp
			 	 Where  dp.id_sin = s.id_sin
			 	 And 	dp.nom_zone = 'num_mag' )) 'region_magasin',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_caisse' ) 'num_caisse',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_hotesse' ) 'num_hotesse',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_ticket' ) 'num_ticket',
	 cGA.lib_gti 'garantie',
	 Convert ( DateTime, null ) 'dte_achat',

--'type_accord'
	Case 
		When g.cod_etat = 200 Then  'Garantie refusée'
		When g.cod_etat = 900 Then  'Garantie sans suite'
		Else 'A déterminer par SPB'
	End 'type_accord',

-- Nbre d'article prix en charges en tenant comptes des quantités
	0 'nbre_art_pec_avec_qte',

-- Nbre total d'article total
	0 'nbre_total_article',

--'quantite'
	0 'quantite',

--'description_article'
	'Aucun' 'description_article',

--'prix_unitaire'
	0 'valeur_unitaire_article_sinistre', 

--'prix_total_article'
	0 'valeur_totale_article_sinistre',
--'Préjudice_total_sinistre'
	0 'prejudice_total_sinistre',
--'Préjudice_total_sinistre_PEC'
	0 'prejudice_total_sinistre_pec',	
--'lib_action'
        '' 'lib_action_CASTORAMA',

--'dte_action_CASTORAMA'
	Convert ( DateTime, null )  'dte_action_CASTORAMA',

-- Au moins une action CASTO
	'NON' 'au_moins_une_action_CASTO',
-- #1 [DCMP090080]
-- [ITSM_852785]
	(Select TOP 1 r.dte_reg
	 From 	sysadm.reglement r
	 Where	r.id_sin = s.id_sin
	 And    r.cod_mot_reg = 'RN'
	 And 	r.cod_mode_reg = 'FM'
	 And    r.dte_reg = ( 	 Select Min ( r2.dte_reg )
				 From 	sysadm.reglement r2
				 Where	r2.id_sin = r.id_sin
				 And    r2.cod_mot_reg = r.cod_mot_reg
	 			 And 	r2.cod_mode_reg = r.cod_mode_reg 
			     ) 
	) 'Date_premier_reglement'
	
From	sysadm.sinistre s,
	sysadm.personne p,
	sysadm.gar_sin  g,
	sysadm.code_garantie cGA,
	sysadm.code cCI

Where   s.id_prod between 23400 and 23499
And 	s.id_sin = g.id_sin
And	p.id_ordre = s.id_ordre
And	cGA.id_prod = s.id_prod
And	cGA.id_gti = g.id_gti
And 	cCI.id_typ_code = '-CI'
And 	cCI.id_code = p.cod_civ
And 	s.id_sin not in ( 1037121 ) 
And     Not exists ( 
	Select * 
	From  sysadm.detail d
	Where d.id_sin = s.id_sin
	And   d.id_gti = g.id_gti
	)

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_STAT_CASTO, d'après
--				sysadm.VU_S01_STAT_CASTO
-- Auteur               :       PHG
-- Date                 :       04/02/2011
-- Libellé              :       Vu pour les stats WEB
-- Commentaires         :       Commentaire et ordre colonne :
--				'ref_sin'
--				'dte_survenance'
--				'dte_declaration'
--				'nom_client'
--				'prenom_client'
--				'nom_client_complet'
--				'adresse1'
--				'adresse2'
--				'code_postal'
--				'ville'
--				'num_carte'
--				'dte_ticket'
--				'num_magasin'
--				'nom_magasin'
--				'region_magasin'
--				'num_caisse'
--				'num_hotesse'
--				'num_ticket'
--				'Garantie'
--				'Date_Achat'
--				'type_accord'
--				'nbre_art_pec_avec_qte'
--				'nbre_total_article'
--				'quantite'
--				'description_article'
--				'valeur_unitaire_article_sinistre'
--				'valeur_totale_article_sinistre'
--				'prejudice_total_sinistre'
--				'prejudice_total_sinistre_PEC'
--				'lib_action_CASTORAMA'
--				'dte_action_CASTORAMA'
--				'au_moins_une_action_CASTO'
--				'Date_premier_reglement'
--
--				DMDI 14964 "s.id_sin not in" dossier exclu.
--
-- Arguments            :       @iNumMagasin integer : Numéro de magasin
--				@dDebut datetime : Date de début de la stat
--				@dFin	datetime : Date de fin de la stat
--
-- Retourne             :       Rien
-- 
-- #1	JFF	18/03/2008	[DCMP090080]
--      JFF     06/12/2010      [ITSM_852785]
--	PHG	04/02/2011	[BLOCAGE] Transformation de VU_S01_STAT_CASTO
--				en PS_S01_STAT_CASTO
--				/!\ ATTENTION /!\ Si VU_S01_STAT_CASTO évolue
--				cette PS doit évoluer de la même manière et vice versa
-------------------------------------------------------------------
if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_S01_STAT_CASTO]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_S01_STAT_CASTO]
GO


CREATE PROCEDURE sysadm.PS_S01_STAT_CASTO 
@iNumMagasin integer,
@dDebut datetime,
@dFin	datetime
As
--1
Select  s.id_sin 'ref_sin',
	s.dte_surv 'dte_survenance',
	s.dte_decl 'dte_declaration',
	sysadm.FN_TRIM (p.nom) 'nom_client',
	sysadm.FN_TRIM (p.prenom) 'prenom_client',
	sysadm.FN_TRIM (sysadm.FN_TRIM (cCI.lib_code) + ' ' + Upper ( sysadm.FN_TRIM (p.nom)) + ', ' + Upper ( Substring ( sysadm.FN_TRIM (p.prenom), 1, 1 ) ) + 
		Case When len (p.prenom) > 1 Then Lower ( Substring ( p.prenom, 2, len (p.prenom) - 1  ) ) else '' End	) 'nom_client_complet' ,
 	Upper ( sysadm.FN_TRIM (p.adr_1 )) 'adresse1',
 	Upper ( sysadm.FN_TRIM (p.adr_2 )) 'adresse2',
 	Upper ( sysadm.FN_TRIM (p.adr_cp )) 'code_postal',
 	Upper ( sysadm.FN_TRIM (p.adr_ville )) 'ville',
 	Upper ( sysadm.FN_TRIM (s.id_adh )) 'num_carte',
 	(Select	val_dte
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin And dp.nom_zone = 'dte_ticket' ) 'dte_ticket',
 	 -- [BLOCAGE] PHG, 03/022011 Requete pour lecture num_mag sortie de la clause select
 	 ds_num_mag.val_nbre 'num_magasin',
/* 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_mag' ) 'num_magasin',*/
	( Select Top 1 b.adr_ville
	  From   boutique b
	  Where  b.id_prod between 23400 and 23499
	  And 	 b.id_boutique = (Select	val_nbre
			 	 From 	sysadm.div_sin dp
			 	 Where  dp.id_sin = s.id_sin
			 	 And 	dp.nom_zone = 'num_mag' )) 'nom_magasin',
	( Select Top 1 b.region
	  From   boutique b
	  Where  b.id_prod between 23400 and 23499
	  And 	 b.id_boutique = (Select	val_nbre
			 	 From 	sysadm.div_sin dp
			 	 Where  dp.id_sin = s.id_sin
			 	 And 	dp.nom_zone = 'num_mag' )) 'region_magasin',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_caisse' ) 'num_caisse',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_hotesse' ) 'num_hotesse',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_ticket' ) 'num_ticket',
	 cGA.lib_gti 'garantie',
	 d.dte_det 'dte_achat',

--'type_accord'
	Case 
		When g.cod_etat = 200 Then  'Garantie refusée'
		When g.cod_etat = 900 Then  'Garantie sans suite'
		Else
			Case
			  When d.cod_etat = 200 Then 'Article refusé'
			  When d.cod_etat = 900 Then 'Article sans suite'

		  	  When d.cod_etat = 600 Then 'Article pris en charge'
			  When d.cod_etat = 100 Then 
				(	Case (
					Select 	sysadm.FN_TRIM ( ddet.val_car )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'pec' )

						When 'O' Then 'Article pris en charge'
						Else 'A déterminer par SPB'

					End 
				)
		  	  ELSE 'A déterminer par SPB'
			End 
	End 'type_accord',

-- Nbre d'article prix en charges en tenant comptes des quantités
	(
	Select 	IsNull ( sum ( ddet1.val_nbre ), 0 )
	From   	sysadm.div_det ddet1
	Where  	ddet1.id_sin = d.id_sin
	And 	ddet1.id_gti = d.id_gti
	And 	ddet1.nom_zone = 'qte' 
	And 	Exists (
		Select  *
		From    sysadm.div_det ddet2
		Where   ddet2.id_sin = ddet1.id_sin 
		And 	ddet2.id_gti = ddet1.id_gti
		And 	ddet2.id_detail = ddet1.id_detail
		And 	ddet2.nom_zone = 'pec'
		And 	ddet2.val_car = 'O')
	) 'nbre_art_pec_avec_qte',

-- Nbre total d'article total
	(
	Select 	IsNull ( sum ( ddet.val_nbre ), 0 )
	From   	sysadm.div_det ddet
	Where  	ddet.id_sin = d.id_sin
	And 	ddet.id_gti = d.id_gti
	And 	ddet.nom_zone = 'qte' 
	) 'nbre_total_article',

--'quantite'
	(
	Select 	ddet.val_nbre
	From   	sysadm.div_det ddet
	Where  	ddet.id_sin = d.id_sin
	And 	ddet.id_gti = d.id_gti
	And 	ddet.id_detail = d.id_detail
	And 	ddet.nom_zone = 'qte' ) 'quantite',

--'description_article'
	Case 
		When ( Select 	count (*)
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'aucune_marq' ) > 0 
			Then 	Case		
				When
					(
					Select 	sysadm.FN_TRIM ( ddet.val_car )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'aucune_marq' ) = 'O' 
					Then 
						(Select sysadm.FN_TRIM ( ddet.val_car )
						From   	sysadm.div_det ddet
						Where  	ddet.id_sin = d.id_sin
						And 	ddet.id_gti = d.id_gti
						And 	ddet.id_detail = d.id_detail
						And 	ddet.nom_zone = 'modl_app' )

				When
					(
					Select 	sysadm.FN_TRIM ( ddet.val_car )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'aucune_marq' ) = 'N' 
					Then 						
						(Select sysadm.FN_TRIM ( ddet.val_car )
						From   	sysadm.div_det ddet
						Where  	ddet.id_sin = d.id_sin
						And 	ddet.id_gti = d.id_gti
						And 	ddet.id_detail = d.id_detail
						And 	ddet.nom_zone = 'modl_app' )
						+ ' ' +
						(Select sysadm.FN_TRIM ( ddet.val_car )
						From   	sysadm.div_det ddet
						Where  	ddet.id_sin = d.id_sin
						And 	ddet.id_gti = d.id_gti
						And 	ddet.id_detail = d.id_detail
						And 	ddet.nom_zone = 'marq_app' )
				End 
		Else 	(Select sysadm.FN_TRIM ( ddet.val_car )
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'modl_app' )
			+ ' ' +
			(Select sysadm.FN_TRIM ( ddet.val_car )
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'marq_app' )

	End 'description_article',

--'prix_unitaire'
	Round ( 
		  Convert ( decimal ( 11,2) , d.mt_val_achat )
			/ 
		  Convert ( decimal ( 11,2) , 
			   (Select ddet.val_nbre
  			    From   sysadm.div_det ddet
			    Where  ddet.id_sin = d.id_sin
			    And    ddet.id_gti = d.id_gti
			    And    ddet.id_detail = d.id_detail
			    And    ddet.nom_zone = 'qte' )
			  )
		,2 ) 'valeur_unitaire_article_sinistre', 

--'prix_total_article'
	d.mt_val_achat 'valeur_totale_article_sinistre',
--'Préjudice_total_sinistre'
	( Select IsNull ( Sum ( d2.mt_val_achat ), 0 ) 
	From   	sysadm.detail d2
	Where  	d2.id_sin = d.id_sin
	And 	d2.id_gti = d.id_gti
	)'prejudice_total_sinistre',
--'Préjudice_total_sinistre_PEC'
	( Select IsNull ( Sum ( d1.mt_val_achat ), 0 ) 
	From   	sysadm.detail d1
	Where  	d1.id_sin = d.id_sin
	And 	d1.id_gti = d.id_gti
	And 	Exists (
		Select  *
		From    sysadm.div_det ddet2
		Where   ddet2.id_sin = d1.id_sin 
		And 	ddet2.id_gti = d1.id_gti
		And 	ddet2.id_detail = d1.id_detail
		And 	ddet2.nom_zone = 'pec'
		And 	ddet2.val_car = 'O')	
	)'prejudice_total_sinistre_pec',	
--'lib_action'

	Case 
		When ( Select 	count (*)
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'cod_action' ) > 0 
			Then 	(Select cGC.lib_code
				 From   sysadm.code cGC
				 Where  cGC.id_typ_code = '-GC'
				 And    cGC.id_code = ( Select 	IsNull ( val_nbre, -1 ) 
							From   	sysadm.div_det ddet
							Where  	ddet.id_sin = d.id_sin
							And 	ddet.id_gti = d.id_gti
							And 	ddet.id_detail = d.id_detail
							And 	ddet.nom_zone = 'cod_action' )
				)
		Else ''
	End 'lib_action_CASTORAMA',

--'dte_action_CASTORAMA'
	Case 
		When ( Select 	count (*)
			From   	sysadm.div_det ddet
			Where  	ddet.id_sin = d.id_sin
			And 	ddet.id_gti = d.id_gti
			And 	ddet.id_detail = d.id_detail
			And 	ddet.nom_zone = 'cod_action' ) > 0 
			Then 	(
				Select 	ddet.cree_le 
				From   	sysadm.div_det ddet
				Where  	ddet.id_sin = d.id_sin
				And 	ddet.id_gti = d.id_gti
				And 	ddet.id_detail = d.id_detail
				And 	ddet.nom_zone = 'cod_action' ) 
		Else null
	End 'dte_action_CASTORAMA',

-- Au moins une action CASTO
	Case  When ( 
		Select IsNull ( Convert ( decimal ( 11,2), count (*) ), 0 )
		From   	sysadm.div_det ddet
		Where  	ddet.id_sin = d.id_sin
		And 	ddet.id_gti = d.id_gti
		And 	ddet.nom_zone = 'marq_app' ) > 0 
		Then 
			
			Case	(Round ( 
					(
					Select 	IsNull ( Convert ( decimal ( 11,2), count (*) ), 0 )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.nom_zone = 'cod_action' 
					) 
					/
					(
					Select 	IsNull ( Convert ( decimal ( 11,2), count (*) ), 0 )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.nom_zone = 'marq_app'
					) 
					,2 ))
				When 1 Then 'OUI'
				When 0 Then 'NON'
				Else 'PARTIEL'
			End 

		Else 'NON'
	End 'au_moins_une_action_CASTO',
	
-- #1 [DCMP090080]
-- [ITSM_852785]
	(Select TOP 1 r.dte_reg
	 From 	sysadm.reglement r
	 Where	r.id_sin = s.id_sin
	 And    r.cod_mot_reg = 'RN'
	 And 	r.cod_mode_reg = 'FM'
	 And    r.dte_reg = ( 	 Select Min ( r2.dte_reg )
				 From 	sysadm.reglement r2
				 Where	r2.id_sin = r.id_sin
				 And    r2.cod_mot_reg = r.cod_mot_reg
	 			 And 	r2.cod_mode_reg = r.cod_mode_reg 
			     ) 
	) 'Date_premier_reglement'
	
From	sysadm.sinistre s -- [BLOCAGE] PHG, 03/022011 Requete pour lecture num_mag sortie de la clause select
		LEFT OUTER JOIN sysadm.div_sin ds_num_mag ON (ds_num_mag.id_sin = s.id_sin ),
	sysadm.personne p,
	sysadm.gar_sin  g,
	sysadm.detail d,
	sysadm.code_garantie cGA,
	sysadm.code cCI
Where   s.id_prod between 23400 and 23499
And 	s.id_sin = g.id_sin
And	p.id_ordre = s.id_ordre
And	cGA.id_prod = s.id_prod
And	cGA.id_gti = g.id_gti
And 	d.id_sin = s.id_sin
And 	d.id_gti = g.id_gti
And 	cCI.id_typ_code = '-CI'
And 	cCI.id_code = p.cod_civ
And 	s.id_sin not in ( 1037121 ) 
And	ds_num_mag.nom_zone = 'num_mag' -- [BLOCAGE] PHG, 03/022011 Requete pour lecture num_mag sortie de la clause select
and	ds_num_mag.val_nbre = @iNumMagasin
and	s.dte_decl BETWEEN @dDebut and @dFin

Union all 

--2
Select  s.id_sin 'ref_sin',
	s.dte_surv 'dte_survenance',
	s.dte_decl 'dte_declaration',
	sysadm.FN_TRIM (p.nom) 'nom_client',
	sysadm.FN_TRIM (p.prenom) 'prenom_client',
	sysadm.FN_TRIM (sysadm.FN_TRIM (cCI.lib_code) + ' ' + Upper ( sysadm.FN_TRIM (p.nom)) + ', ' + Upper ( Substring ( sysadm.FN_TRIM (p.prenom), 1, 1 ) ) + 
		Case When len (p.prenom) > 1 Then Lower ( Substring ( p.prenom, 2, len (p.prenom) - 1  ) ) else '' End ) 'nom_client_complet' ,
 	Upper ( sysadm.FN_TRIM (p.adr_1 )) 'adresse1',
 	Upper ( sysadm.FN_TRIM (p.adr_2 )) 'adresse2',
 	Upper ( sysadm.FN_TRIM (p.adr_cp )) 'code_postal',
 	Upper ( sysadm.FN_TRIM (p.adr_ville )) 'ville',
 	Upper ( sysadm.FN_TRIM (s.id_adh )) 'num_carte',
 	(Select	val_dte
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin 	 And 	dp.nom_zone = 'dte_ticket' ) 'dte_ticket',
 	 -- [BLOCAGE] PHG, 03/022011 Requete pour lecture num_mag sortie de la clause select
 	 ds_num_mag.val_nbre 'num_magasin',
/* 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_mag' ) 'num_magasin',*/
	( Select Top 1 b.adr_ville
	  From   boutique b
	  Where  b.id_prod between 23400 and 23499
	  And 	 b.id_boutique = (Select	val_nbre
			 	 From 	sysadm.div_sin dp
			 	 Where  dp.id_sin = s.id_sin
			 	 And 	dp.nom_zone = 'num_mag' )) 'nom_magasin',
	( Select Top 1 b.region
	  From   boutique b
	  Where  b.id_prod between 23400 and 23499
	  And 	 b.id_boutique = (Select	val_nbre
			 	 From 	sysadm.div_sin dp
			 	 Where  dp.id_sin = s.id_sin
			 	 And 	dp.nom_zone = 'num_mag' )) 'region_magasin',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_caisse' ) 'num_caisse',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_hotesse' ) 'num_hotesse',
 	(Select	val_nbre
 	 From 	sysadm.div_sin dp
 	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_ticket' ) 'num_ticket',
	 cGA.lib_gti 'garantie',
	 Convert ( DateTime, null ) 'dte_achat',

--'type_accord'
	Case 
		When g.cod_etat = 200 Then  'Garantie refusée'
		When g.cod_etat = 900 Then  'Garantie sans suite'
		Else 'A déterminer par SPB'
	End 'type_accord',

-- Nbre d'article prix en charges en tenant comptes des quantités
	0 'nbre_art_pec_avec_qte',

-- Nbre total d'article total
	0 'nbre_total_article',

--'quantite'
	0 'quantite',

--'description_article'
	'Aucun' 'description_article',

--'prix_unitaire'
	0 'valeur_unitaire_article_sinistre', 

--'prix_total_article'
	0 'valeur_totale_article_sinistre',
--'Préjudice_total_sinistre'
	0 'prejudice_total_sinistre',
--'Préjudice_total_sinistre_PEC'
	0 'prejudice_total_sinistre_pec',	
--'lib_action'
        '' 'lib_action_CASTORAMA',

--'dte_action_CASTORAMA'
	Convert ( DateTime, null )  'dte_action_CASTORAMA',

-- Au moins une action CASTO
	'NON' 'au_moins_une_action_CASTO',
-- #1 [DCMP090080]
-- [ITSM_852785]
	(Select TOP 1 r.dte_reg
	 From 	sysadm.reglement r
	 Where	r.id_sin = s.id_sin
	 And    r.cod_mot_reg = 'RN'
	 And 	r.cod_mode_reg = 'FM'
	 And    r.dte_reg = ( 	 Select Min ( r2.dte_reg )
				 From 	sysadm.reglement r2
				 Where	r2.id_sin = r.id_sin
				 And    r2.cod_mot_reg = r.cod_mot_reg
	 			 And 	r2.cod_mode_reg = r.cod_mode_reg 
			     ) 
	) 'Date_premier_reglement'
	
From	sysadm.sinistre s -- [BLOCAGE] PHG, 03/022011 Requete pour lecture num_mag sortie de la clause select
		LEFT OUTER JOIN sysadm.div_sin ds_num_mag ON (ds_num_mag.id_sin = s.id_sin ),
	sysadm.personne p,
	sysadm.gar_sin  g,
	sysadm.code_garantie cGA,
	sysadm.code cCI

Where   s.id_prod between 23400 and 23499
And 	s.id_sin = g.id_sin
And	p.id_ordre = s.id_ordre
And	cGA.id_prod = s.id_prod
And	cGA.id_gti = g.id_gti
And 	cCI.id_typ_code = '-CI'
And 	cCI.id_code = p.cod_civ
And 	s.id_sin not in ( 1037121 ) 
And     Not exists ( 
	Select * 
	From  sysadm.detail d
	Where d.id_sin = s.id_sin
	And   d.id_gti = g.id_gti
	)
And	ds_num_mag.nom_zone = 'num_mag' -- [BLOCAGE] PHG, 03/022011 Requete pour lecture num_mag sortie de la clause select
and	ds_num_mag.val_nbre = @iNumMagasin
and	s.dte_decl BETWEEN @dDebut and @dFin

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_MAGASINS
-- Auteur               :       FABRY JF
-- Date                 :       20/11/2005
-- Libellé              :       Liste des magasins Casto
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_MAGASINS' AND type = 'P' )
        DROP procedure sysadm.PS_S01_MAGASINS
GO

CREATE procedure sysadm.PS_S01_MAGASINS
AS
 SELECT b.adr_ville + '(' + Convert ( Varchar ( 6 ), b.id_boutique ) + ')' 'IdLibMagasin' , 
	b.id_boutique 'IdMagasin',
 	b.adr_ville   'LibMagasin'
 FROM   sysadm.boutique b
 WHERE  b.id_prod between 23400 and 23499
 Order by b.adr_ville   

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S04_CW_LISTE_REF_ORAL
-- Auteur               :       FABRY JF
-- Date                 :       22/04/2008
-- Libellé              :       [DCMP080153]
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S04_CW_LISTE_REF_ORAL' AND type = 'P' )
        DROP procedure sysadm.PS_S04_CW_LISTE_REF_ORAL
GO

/*-------------------------------------------------------------------
[DATABASE] SIMPA2_PRO
[DESCRIPTION] 
[MAJ PAR] DATAFLY - AFX
[DATEMAJ] 15/10/2009

[VARIABLES]
    @sNumCarte VARCHAR(19) = NULL
-------------------------------------------------------------------*/
CREATE PROCEDURE [sysadm].[PS_S04_CW_LISTE_REF_ORAL]
    @sNumCarte VARCHAR(19) = NULL
AS 
    IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') 
        BEGIN
            SELECT DISTINCT
		--'nom_assure'
                    sysadm.FN_TRIM(sysadm.FN_TRIM(cCI.lib_code) + ' '
                                   + UPPER(SUBSTRING(sysadm.FN_TRIM(cl.prenom),
                                                     1, 1))
                                   + Case When len (cl.prenom) > 1 Then Lower ( Substring ( cl.prenom, 2, len (cl.prenom) - 1  ) ) else '' End
                                   + ' ' + UPPER(SUBSTRING(cl.nom, 1, 1))
                                   + Case When len (cl.nom) > 1 Then Lower ( Substring ( cl.nom, 2, len (cl.nom) - 1  ) ) else '' End
					) 'nom_assure',
		--'dte_surv'
                    co.dte_surv 'dte_surv',
		--'dte_decl'
                    co.dte_dec 'dte_decl',
		--'num_carte'
                    co.id_adh 'num_carte',
                    ISNULL(cNT.txt_msg, cNT.lib_code) 'lib_refus',
                    co.id_nat_tache 'code_refus'
            FROM    SHERPA_PRO.sysadm.contact co,
                    SHERPA_PRO.sysadm.client cl,
                    SHERPA_PRO.sysadm.code_car cCI,
                    SHERPA_PRO.sysadm.code cNT
            WHERE   co.id_prod between 23400 and 23499
                    AND co.id_adh = @sNumCarte  -- [PI038][RELEVE]
                    AND ( co.id_nat_tache = 22
                          OR co.id_nat_tache BETWEEN 2200 AND 2299
                        )
                    AND co.id_sin IS NULL
                    AND cl.id_cli = co.id_cli
                    AND cCI.id_typ_code = '-CI'
                    AND cCI.id_code = cl.cod_civ
                    AND cNT.id_typ_code = '-NT'
                    AND cNT.id_code = co.id_nat_tache
                    AND NOT EXISTS ( SELECT *
                                     FROM   SIMPA2_PRO.sysadm.sinistre s
                                     WHERE  s.id_prod = co.id_prod
                                            AND s.id_adh = co.id_adh  -- [PI038][RELEVE]
                                            AND s.dte_surv = co.dte_surv )
            ORDER BY co.dte_surv
        END                        
        
    IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('SIM') 
        BEGIN
            SELECT DISTINCT
		--'nom_assure'
                    sysadm.FN_TRIM(sysadm.FN_TRIM(cCI.lib_code) + ' '
                                   + UPPER(SUBSTRING(sysadm.FN_TRIM(cl.prenom),
                                                     1, 1))
                                   + Case When len (cl.prenom) > 1 Then Lower ( Substring ( cl.prenom, 2, len (cl.prenom) - 1  ) ) else '' End
                                   + ' ' + UPPER(SUBSTRING(cl.nom, 1, 1))
                                   + Case When len (cl.nom) > 1 Then Lower ( Substring ( cl.nom, 2, len (cl.nom) - 1  ) ) else '' End
				   ) 'nom_assure',
		--'dte_surv'
                    co.dte_surv 'dte_surv',
		--'dte_decl'
                    co.dte_dec 'dte_decl',
		--'num_carte'
                    co.id_adh 'num_carte',
                    ISNULL(cNT.txt_msg, cNT.lib_code) 'lib_refus',
                    co.id_nat_tache 'code_refus'
            FROM    SHERPA_SIM.sysadm.contact co,
                    SHERPA_SIM.sysadm.client cl,
                    SHERPA_SIM.sysadm.code_car cCI,
                    SHERPA_SIM.sysadm.code cNT
            WHERE   co.id_prod between 23400 and 23499
                    AND co.id_adh = @sNumCarte  -- [PI038][RELEVE]
                    AND ( co.id_nat_tache = 22
                          OR co.id_nat_tache BETWEEN 2200 AND 2299
                        )
                    AND co.id_sin IS NULL
                    AND cl.id_cli = co.id_cli
                    AND cCI.id_typ_code = '-CI'
                    AND cCI.id_code = cl.cod_civ
                    AND cNT.id_typ_code = '-NT'
                    AND cNT.id_code = co.id_nat_tache
                    AND NOT EXISTS ( SELECT *
                                     FROM   SIMPA2_TRT.sysadm.sinistre s
                                     WHERE  s.id_prod = co.id_prod
                                            AND s.id_adh = co.id_adh  -- [PI038][RELEVE]
                                            AND s.dte_surv = co.dte_surv )
            ORDER BY co.dte_surv

        END

GO

--------------------------------------------------------------------
--
-- Procédure            :       VU_S02_STAT_CASTO
-- Auteur               :       FABRY JF
-- Date                 :       18/03/2009
-- Libellé              :       Vu pour les stats WEB [DCMP090080]
-- Commentaires         :       Commentaire et ordre colonne :
--
--				
--
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- 
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'VU_S02_STAT_CASTO' AND type = 'V' )
        DROP view sysadm.VU_S02_STAT_CASTO
GO

CREATE view sysadm.VU_S02_STAT_CASTO
As
/*
le site.
2/ Ajout d'un 2ème fichier Excel reprenant par dossier et par garantie :
- la liste des pièces reçues (= pièces pré-cochées à l'origine, mais plus cochées au moment de l'affichage)
- la liste des pièces manquantes (= pièces pré-cochées)
*/

-- Piece reçues
Select  s.id_sin 'ref_sin',
	s.nom 'nom',
	s.prenom 'prenom',
	s.dte_decl 'dte_decl',
	(Select	val_nbre
	 From 	sysadm.div_sin dp
	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_mag' ) 'num_magasin',
	cGA.lib_gti 'garantie',
	( Select p.id_pce
	  From	sysadm.piece p
	  Where p.id_prod = dp.id_prod
	  And   p.id_gti  = dp.id_code_num
	  And	p.id_pce  = dp.val_num
	) 'Pieces_recues',
	( Select sysadm.FN_CODE_NUM ( p.id_pce, '+PC' )
	  From	sysadm.piece p
	  Where p.id_prod = dp.id_prod
	  And   p.id_gti  = dp.id_code_num
	  And	p.id_pce  = dp.val_num
	) 'Libelle_pieces_recues',
	null 'Pieces_manquantes',
	null 'Libelle_pieces_manquantes'	
	
From	sysadm.w_sin s,
	sysadm.code_garantie cGA,
	sysadm.w_gar_sin wg,
	sysadm.det_pro dp

Where   s.id_prod between 23400 and 23499
And 	s.id_sin not in ( 1037121 )
And     s.cree_le >= '01/04/2008'
And	wg.id_sin = s.id_sin
And	dp.id_prod = s.id_prod
And     dp.id_code_dp = 77
And     dp.id_code_num = wg.id_gti
And	cGA.id_prod = dp.id_prod
And	cGA.id_gti = dp.id_code_num
And     Not Exists (
	Select  *
	from 	sysadm.w_piece wp
	Where   wp.id_sin = s.id_sin
	And 	wp.id_gti = dp.id_code_num
	And	wp.id_pce = dp.val_num
	)

Union all

Select  s.id_sin 'ref_sin',
	s.nom 'nom',
	s.prenom 'prenom',
	s.dte_decl 'dte_decl',
	(Select	val_nbre
	 From 	sysadm.div_sin dp
	 Where  dp.id_sin = s.id_sin
 	 And 	dp.nom_zone = 'num_mag' ) 'num_magasin',	
	cGA.lib_gti 'garantie',
	null 'Pieces_recues',
	null 'Libelle_pieces_recues',	
	wp.id_pce 'Pièces_manquantes',
	sysadm.FN_CODE_NUM ( wp.id_pce, '+PC' ) 'Libelle_pieces_manquantes'		
	
From	sysadm.w_sin s,
	sysadm.code_garantie cGA,
	sysadm.w_piece wp

Where   s.id_prod between 23400 and 23499
And     s.cree_le >= '01/04/2008'
And 	s.id_sin not in ( 1037121 ) 
And 	wp.id_sin = s.id_sin
And	cGA.id_prod = s.id_prod
And	cGA.id_gti = wp.id_gti

	
Go



