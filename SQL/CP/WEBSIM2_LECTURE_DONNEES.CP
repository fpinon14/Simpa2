-------------------------------------------------------------------
--
-- Fichier              :       WEBSIM2_LECTURE_DONNEES.CP
-- Auteur               :       FPI
-- Date                 :       04/2010
--
-- Commentaires         :       Gestion de l'authentification depuis le sitre intranet Simpa2 Web
--				Ces procédures ne sont pas visibles depuis les Web Services du site.
--				[WEBSIM2].[FRANCE]
-------------------------------------------------------------------
-- PS_WEBSIM2_LECTDONN_EXP5_FRANCE	JFF 13/04/2010 Procédure de lecture de données pour le cas produit EXPANSION5_FRANCE
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_LECTDONN_EXP5_FRANCE
-- Auteur               :       FABRY JF
-- Date                 :       13/04/2010 
-- Libelle              :        
-- Commentaires         :       Procédure de lecture de données pour le cas produit EXPANSION5_FRANCE
--				Renvoie une liste de triplets de données "nom de variable"/"libellé de variable"/valeur
--                               
-- References           :       
--
-- Arguments            :       @asIdSin                VarChar(7)        	(Val) Identifiant de sinistre
--				@asNom			Varchar(50)		(Val) Nom du souscripteur
--				@asSKU			Varchar(100)		(Val) Numéro de SKU
--                              @asCas                  VarChar ( 40   )        (Val) Cas de Trt : 
--                                                                              CNX = Connexion + contrôle de validité du dossier
--										CTRL = contrôle de validité du dossier
--				@asLangage              VarChar (  3 )          (Val) Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       Integer                 >0 = OK
--                                                      -1 = NOK
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_LECTDONN_EXP5_FRANCE' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_LECTDONN_EXP5_FRANCE
GO


CREATE PROCEDURE sysadm.PS_WEBSIM2_LECTDONN_EXP5_FRANCE
	@asIdSin                VarChar(50),
	@asNom			Varchar(50),
	@asSKU			Varchar(50),
	@asCodeVendeur		Varchar(50),
	@asCodeMagasin		Varchar(50),
	@asCas                  VarChar(50),
	@asIdSession     	varchar(50),
	@asBrowser       	varchar(200),
	@asLangage              VarChar (3),
	@aiCodeMsg		Integer OUTPUT,
        @asRetourMess           VarChar ( 2000 ) OUTPUT

AS
Declare @iRet	integer
DECLARE @dcIdSin 	Decimal ( 10 ) -- [PI062]
DECLARE @tbStock TABLE 
	( civilite	VarChar (50)	null,
	  nom		VarChar (50)	null,
	  prenom	VarChar (50)	null,
	  adresse	VarChar (50)	null,
	  code_postal	VarChar (50)	null,
	  ville		VarChar (50)	null,
	  adresse_mail	VarChar (50)	null,
	  num_tel_domicile VarChar (50)	null,
	  num_tel_portable VarChar (50)	null,
	  type_appareil VarChar (50)	null,
	  marque_app	VarChar (50)	null,
	  modele_app	VarChar (50)	null,
	  num_serie	VarChar (50)	null,
	  prix_achat_origine VarChar (50)	null,
	  date_souscription VarChar (50)	null,
	  date_prise_effet_gti VarChar (50)	null,
	  code_magasin VarChar (50)	null,
	  valeur_de_remplacement VarChar (50)	null,
	  etat_dossier_sin VarChar (50)	null
	)

Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]
Set @iRet=1

Insert into @tbStock
Select  sysadm.FN_CODE_NUM ( p.cod_civ, '-CI' ) 'civilite',
	p.nom 'nom',
	p.prenom 'prenom',
	IsNull ( p.adr_1, '' ) + '' + IsNull ( p.adr_2, '' ) 'adresse',
	p.adr_cp 'code_postal',
	p.adr_ville 'ville',
	i.adr_mail 'adresse_mail',
	Case 
		When Left ( ltrim ( i.num_teld ), 2 ) not in ( '06', '07') 
		     And i.num_teld is not null And Len ( i.num_teld ) > 0 Then i.num_teld 
		Else ''
	End 'num_tel_domicile',
	Case 
		When Left ( ltrim ( s.num_port ), 2 ) in ( '06', '07' ) 
		     And s.num_port is not null And Len ( s.num_port ) > 0 Then s.num_port
		When Left ( ltrim ( i.num_teld ), 2 ) in ( '06', '07') 
		     And i.num_teld is not null And Len ( i.num_teld ) > 0 Then i.num_teld 		     
		Else ''
	End 'num_tel_portable',
	( Select IsNull ( sysadm.FN_CODE_CAR ( ds.val_car, '-AR' )  , '' )
	  From sysadm.div_sin ds
	  Where ds.id_sin = s.id_sin
	  And 	ds.nom_zone = 'type_app' ) 'type_appareil',
	s.marq_port 'marque_app',
	s.modl_port 'modele_app',
	s.num_imei_port 'num_serie',
	d.mt_val_achat 'prix_achat_origine',
	Convert ( varchar ( 10), s.dte_adh , 103 ) 'date_souscription',
	Convert ( varchar ( 10), s.dte_adh , 103 ) 'date_prise_effet_gti',
	s.id_orian_boutique 'code_magasin',
	( Select IsNull ( dd.val_mt, 0 )
	  From	sysadm.div_det dd
	  Where dd.id_sin = d.id_sin
	  And 	dd.id_gti = d.id_gti
	  And 	dd.id_detail = d.id_detail
	  And	dd.nom_zone = 'mt_pec'
	 ) 'valeur_de_remplacement',
	 Case s.cod_etat
	 	When 100 Then 'PRIS EN CHARGE'
	 	Else Upper ( sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' ))
	 End 'etat_dossier_sin'
	 

From	sysadm.sinistre s,
	sysadm.personne p,
	sysadm.inter i,
	sysadm.detail d,
	sysadm.commande c
Where  	s.id_sin = @dcIdSin
And 	p.id_ordre = s.id_ordre
And	i.id_sin = s.id_sin
And	i.cod_inter = 'A'
And 	c.id_sin = s.id_sin
and     c.id_four = 'WBB'
and     c.cod_etat = 'CWE'
And 	d.id_sin = c.id_sin
And 	d.id_gti = c.id_gti
And 	d.id_detail = c.id_detail

If @@RowCount <> 1 
	Begin 
		Set @iRet = -1
		Select @asRetourMess = sysadm.FN_MESS ( 108, @asLangage )
		Set @aiCodeMsg = 108
		
		--[TRACE_25]
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			null,		-- @asCasProduit    varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNom,		-- @asMdp	    VarChar(50),
			@asNom,		-- @asNom	    Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			25,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'LECT_DONNEES',	-- @asEtape         varchar(20),
			108, 		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )		
	End 

-- Renvoi des données vers le WebService
If @iRet > 0 
	Begin 

		Select 
			rf.id_data,
			rf.libelle,
			convert(varchar(10),@dcIdSin) as valeur -- [PI062]
		From 	sysadm.ref_websim2 rf
		Where	rf.id_data = 'ID_SIN' -- Ajout FPI - 18/05/2010 - ID_SIN + nom de 3ème colonne = valeur
		Union
		Select 
			rf.id_data,
			rf.libelle,
			civilite
		From 	@tbStock , sysadm.ref_websim2 rf
		Where	rf.id_data = 'CIVILITE'
		Union
		Select 
			rf.id_data,
			rf.libelle,
			nom
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'NOM'		
		Union
		Select 
			rf.id_data,
			rf.libelle,
			prenom
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'PRENOM'		
		Union
		Select 
			rf.id_data,
			rf.libelle,
			adresse			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'ADRESSE'		
		Union
		Select 
			rf.id_data,
			rf.libelle,
			code_postal			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'CODE_POSTAL'		
		Union
		Select 
			rf.id_data,
			rf.libelle,
			ville			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'VILLE'			
		Union
		Select 
			rf.id_data,
			rf.libelle,
			adresse_mail			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'ADR_MAIL'					
		Union
		Select 
			rf.id_data,
			rf.libelle,
			num_tel_domicile			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'NUM_TEL_DOM'					
		Union
		Select 
			rf.id_data,
			rf.libelle,
			num_tel_portable			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'NUM_TEL_POR'					
		Union
		Select 
			rf.id_data,
			rf.libelle,
			type_appareil			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'TYPE_APP'						
		Union
		Select 
			rf.id_data,
			rf.libelle,
			marque_app			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MARQ_APP'						
		Union
		Select 
			rf.id_data,
			rf.libelle,
			modele_app			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MODL_APP'					
		Union
		Select 
			rf.id_data,
			rf.libelle,
			num_serie			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'NUM_SERIE'				 
		Union
		Select 
			rf.id_data,
			rf.libelle,
			prix_achat_origine			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'PRIX_ACHAT_ORIGINE'			 
		Union
		Select 
			rf.id_data,
			rf.libelle,
			date_souscription			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'DTE_ADHESION'				 
		Union
		Select 
			rf.id_data,
			rf.libelle,
			date_prise_effet_gti			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'DTE_EFFET_GTI'				
		Union
		Select 
			rf.id_data,
			rf.libelle,
			code_magasin			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'CODE_MAGASIN'					
		Union
		Select 
			rf.id_data,
			rf.libelle,
			valeur_de_remplacement			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MT_PEC'								
		Union
		Select 
			rf.id_data,
			rf.libelle,
			etat_dossier_sin			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'ETAT_DOSSIER'	
		
	End 
	
Return @iRet

Go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_LECTDONN_SAV_CARR
-- Auteur               :       F. Pinon
-- Date                 :       19/07/2010 
-- Libelle              :        
-- Commentaires         :       Procédure de lecture de données pour le cas produit CARREFOUR_CASSE_VOL_SAV
--				Renvoie une liste de triplets de données "nom de variable"/"libellé de variable"/valeur
--                               
-- References           :       
--
-- Arguments            :       @asIdSin                VarChar(7)        	(Val) Identifiant de sinistre
--				@asNom			Varchar(50)		(Val) Nom du souscripteur
--				@asSKU			Varchar(100)		(Val) Numéro de SKU
--                              @asCas                  VarChar ( 40   )        (Val) Cas de Trt : 
--                                                                              CNX = Connexion + contrôle de validité du dossier
--										CTRL = contrôle de validité du dossier
--				@asLangage              VarChar (  3 )          (Val) Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       Integer                 >0 = OK
--                                                      -1 = NOK
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_LECTDONN_SAV_CARR' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_LECTDONN_SAV_CARR
GO


CREATE PROCEDURE sysadm.PS_WEBSIM2_LECTDONN_SAV_CARR
	@asIdSin                VarChar(50),
	@asNom			Varchar(50),
	@asSKU			Varchar(50),
	@asCodeVendeur		Varchar(50),
	@asCodeMagasin		Varchar(50),
	@asCas                  VarChar(50),
	@asIdSession     	varchar(50),
	@asBrowser       	varchar(200),
	@asLangage              VarChar (3),
	@aiCodeMsg		Integer OUTPUT,
        @asRetourMess           VarChar ( 2000 ) OUTPUT

AS
Declare @iRet	integer
DECLARE @dcIdSin 	Decimal ( 10 )  -- [PI062]
DECLARE @tbStock TABLE 
	( civilite	VarChar (50)	null,
	  nom		VarChar (50)	null,
	  prenom	VarChar (50)	null,
	  adresse	VarChar (71)	null,
	  code_postal	VarChar (50)	null,
	  ville		VarChar (50)	null,
	  num_tel_domicile VarChar (50)	null,
	  num_tel_portable VarChar (50)	null,
	  adresse_mail	VarChar (50)	null,
	  type_appareil VarChar (50)	null,
	  marque_app	VarChar (50)	null,
	  modele_app	VarChar (50)	null,
	  num_serie	VarChar (50)	null,
	  dte_achat	Varchar(50)	null,
	  num_bon_vente	varchar(35)	null,
	  code_ean	varchar(35)	null,
	  probleme	varchar(255)	null,
	  constat	varchar(255)	null,
	  etat_dossier_sin VarChar (50)	null,
	  etat_presta_sav_carrefour VarChar (50) null,
	  lib_presta_sav_carrefour VarChar (50) null,
	  id_prod Varchar(10) null,
	  dte_decl Varchar(50) null
	)

Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]
Set @iRet=1

Insert into @tbStock
Select  sysadm.FN_CODE_NUM ( p.cod_civ, '-CI' ) 'civilite',
	p.nom 'nom',
	p.prenom 'prenom',
	IsNull ( p.adr_1, '' ) + ' ' + IsNull ( p.adr_2, '' ) 'adresse',
	p.adr_cp 'code_postal',
	p.adr_ville 'ville',
	Case 
		When Left ( ltrim ( i.num_teld ), 2 ) not in ( '06', '07') 
		     And i.num_teld is not null And Len ( i.num_teld ) > 0 Then i.num_teld 
		Else ''
	End 'num_tel_domicile',
	Case 
		When Left ( ltrim ( s.num_port ), 2 ) in ( '06', '07' ) 
		     And s.num_port is not null And Len ( s.num_port ) > 0 Then s.num_port
		When Left ( ltrim ( i.num_teld ), 2 ) in ( '06', '07') 
		     And i.num_teld is not null And Len ( i.num_teld ) > 0 Then i.num_teld 		     
		Else ''
	End 'num_tel_portable',
	i.adr_mail 'adresse_mail',
	( Select IsNull ( sysadm.FN_CODE_CAR ( ds.val_car, '-AR' )  , '' )
	  From sysadm.div_sin ds
	  Where ds.id_sin = s.id_sin
	  And 	ds.nom_zone = 'type_app' ) 'type_appareil',
	s.marq_port 'marque_app',
	s.modl_port 'modele_app',
	s.num_imei_port 'num_serie',
	convert(varchar(10),s.dte_ach_port,103) 'dte_achat',
	(select top 1 val_car from div_sin dv where s.id_sin=dv.id_sin and dv.nom_zone='num_bon_vente') 'num_bon_vente',
	(select top 1 val_car from div_sin dv where s.id_sin=dv.id_sin and dv.nom_zone='code_ean') 'code_ean',
	c.probleme,
	c.comment_frn 'constat',
	Case s.cod_etat
	 	When 100 Then 'PRIS EN CHARGE'
	 	Else Upper ( sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' ))
	 End 'etat_dossier_sin',
	c.info_spb_frn 'etat_presta_sav_carrefour',
	sysadm.FN_CODE_NUM ( c.info_spb_frn, '-IF' ) 'lib_presta_sav_carrefour',
	s.id_prod 'id_prod',
	convert(varchar(10),s.dte_decl,103) 'dte_decl'
From	sysadm.sinistre s
	INNER JOIN sysadm.personne p on p.id_ordre = s.id_ordre
	INNER JOIN sysadm.inter i on i.id_sin = s.id_sin
	LEFT OUTER JOIN sysadm.commande c on c.id_sin = s.id_sin and     c.id_four = 'SCR' and     c.cod_etat = 'ECT'
Where  	s.id_sin = @dcIdSin And	i.cod_inter = 'A'


If @@RowCount <> 1 
	Begin 
		Set @iRet = -1
		Select @asRetourMess = sysadm.FN_MESS ( 108, @asLangage )
		Set @aiCodeMsg = 108
		
		--[TRACE_25]
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			null,		-- @asCasProduit    varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNom,		-- @asMdp	    VarChar(50),
			@asNom,		-- @asNom	    Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			25,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'LECT_DONNEES',	-- @asEtape         varchar(20),
			108, 		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )		
	End 

-- Renvoi des données vers le WebService
If @iRet > 0 
	Begin 

		Select 
			rf.id_data,
			rf.libelle,
			convert(varchar(10),@dcIdSin) as valeur -- [PI062]
		From 	sysadm.ref_websim2 rf
		Where	rf.id_data = 'ID_SIN' 
		Union
		Select 
			rf.id_data,
			rf.libelle,
			civilite
		From 	@tbStock , sysadm.ref_websim2 rf
		Where	rf.id_data = 'CIVILITE'
		Union
		Select 
			rf.id_data,
			rf.libelle,
			nom
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'NOM'		
		Union
		Select 
			rf.id_data,
			rf.libelle,
			prenom
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'PRENOM'		
		Union
		Select 
			rf.id_data,
			rf.libelle,
			adresse			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'ADRESSE'		
		Union
		Select 
			rf.id_data,
			rf.libelle,
			code_postal			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'CODE_POSTAL'		
		Union
		Select 
			rf.id_data,
			rf.libelle,
			ville			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'VILLE'			
		Union
		Select 
			rf.id_data,
			rf.libelle,
			num_tel_domicile			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'NUM_TEL_DOM'					
		Union
		Select 
			rf.id_data,
			rf.libelle,
			num_tel_portable			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'NUM_TEL_POR'					
		Union
		Select 
			rf.id_data,
			rf.libelle,
			type_appareil			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'TYPE_APP'						
		Union
		Select 
			rf.id_data,
			rf.libelle,
			marque_app			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MARQ_APP'						
		Union
		Select 
			rf.id_data,
			rf.libelle,
			modele_app			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MODL_APP'					
		Union
		Select 
			rf.id_data,
			rf.libelle,
			num_serie			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'NUM_SERIE'				 
		Union
		Select 
			rf.id_data,
			rf.libelle,
			etat_dossier_sin			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'ETAT_DOSSIER'	
		Union
		Select 
			rf.id_data,
			rf.libelle,
			dte_achat			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'DTE_ACHAT'
		Union
		Select 
			rf.id_data,
			rf.libelle,
			code_ean			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'CODE_EAN'	
		Union
		Select 
			rf.id_data,
			rf.libelle,
			probleme			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'DESC_DOMMAGE'			
		Union
		Select 
			rf.id_data,
			rf.libelle,
			constat			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'CONSTAT_DOMMAGE'			
		Union
		Select 
			rf.id_data,
			rf.libelle,
			num_bon_vente			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'NUM_BON_VENTE'			
		Union
		Select 
			rf.id_data,
			rf.libelle,
			etat_presta_sav_carrefour			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'ETAT_PRESTA_SAV'			
		Union
		Select 
			rf.id_data,
			rf.libelle,
			lib_presta_sav_carrefour			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'LIB_ETAT_PRESTA_SAV'
		Union
		Select 
			rf.id_data,
			rf.libelle,
			id_prod			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'ID_PROD'
		Union
		Select 
			rf.id_data,
			rf.libelle,
			adresse_mail			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'ADR_MAIL'
		Union
		Select 
			rf.id_data,
			rf.libelle,
			dte_decl			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'DTE_DECL'				
		
	End 
	
Return @iRet

Go


-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_LECTDONN_MC_PROTECT
-- Auteur               :       F. Pinon
-- Date                 :       29/11/2012
-- Libelle              :        
-- Commentaires         :       Procédure de lecture de données pour le cas produit MC_PROTECT
--				Renvoie une liste de triplets de données "nom de variable"/"libellé de variable"/valeur
--                               
-- References           :       
--
-- Arguments            :       @asIdSin                VarChar(7)        	(Val) Identifiant de sinistre
--				@asNom			Varchar(50)		(Val) Nom du souscripteur
--				@asSKU			Varchar(100)		(Val) Numéro de SKU
--                              @asCas                  VarChar ( 40   )        (Val) Cas de Trt : 
--                                                                              CNX = Connexion + contrôle de validité du dossier
--										CTRL = contrôle de validité du dossier
--				@asLangage              VarChar (  3 )          (Val) Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       Integer                 >0 = OK
--                                                      -1 = NOK
-------------------------------------------------------------------
-- JFF      12/12/2013   [PC947&977]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_LECTDONN_MC_PROTECT' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_LECTDONN_MC_PROTECT
GO


CREATE PROCEDURE sysadm.PS_WEBSIM2_LECTDONN_MC_PROTECT
	@asIdSin                VarChar(50),
	@asNom			Varchar(50),
	@asSKU			Varchar(50),
	@asCodeVendeur		Varchar(50),
	@asCodeMagasin		Varchar(50),
	@asCas                  VarChar(50),
	@asIdSession     	varchar(50),
	@asBrowser       	varchar(200),
	@asLangage              VarChar (3),
	@aiCodeMsg		Integer OUTPUT,
        @asRetourMess           VarChar ( 2000 ) OUTPUT

AS
Declare @iRet	integer
DECLARE @dcIdSin 	Decimal ( 10 ) -- [PI062]
DECLARE @tbStock TABLE 
	( civilite	VarChar (50)	null,
	  nom		VarChar (50)	null,
	  prenom	VarChar (50)	null,
	  adresse	VarChar (71)	null,
	  code_postal	VarChar (50)	null,
	  ville		VarChar (50)	null,
	  type_appareil VarChar (50)	null,
	  marque_app	VarChar (50)	null,
	  modele_app	VarChar (50)	null,
	  num_serie	VarChar (50)	null,
	  dte_adh Varchar(50) null,
	  dte_decl Varchar(50) null,
	  marque_rempl	VarChar (50)	null,
	  modele_rempl	VarChar (50)	null,
	  prix_ttc VarChar (50)	null,
	  ref_mc_protect VarChar (50)	null,
	  valeur_de_remplacement VarChar (50)	null,
	  rank_cmd integer
	)

Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]
Set @iRet=1

Insert into @tbStock
Select  sysadm.FN_CODE_NUM ( p.cod_civ, '-CI' ) 'civilite',
	p.nom 'nom',
	p.prenom 'prenom',
	IsNull ( p.adr_1, '' ) + ' ' + IsNull ( p.adr_2, '' ) 'adresse',
	p.adr_cp 'code_postal',
	p.adr_ville 'ville',
	( Select IsNull ( sysadm.FN_CODE_CAR ( ds.val_car, '-AR' )  , '' )
	  From sysadm.div_sin ds
	  Where ds.id_sin = s.id_sin
	  And 	ds.nom_zone = 'type_app' ) 'type_appareil',
	s.marq_port 'marque_app',
	s.modl_port 'modele_app',
	s.num_imei_port 'num_serie',
	convert(varchar(10),s.dte_adh,103) 'dte_adh',
	convert(varchar(10),s.dte_decl,103) 'dte_decl',
	c.id_marq_art 'marque_rempl',
	c.id_modl_art 'modele_rempl',
	c.mt_ttc_cmde 'prix_ttc',
	c.id_ref_four 'ref_mc_protect',
	IsNull ( dd.val_mt, 0 ) 'valeur_de_remplacement',
	rank() over (order by c.id_seq) 'rank_cmd'
From	sysadm.sinistre s
	INNER JOIN sysadm.personne p on p.id_ordre = s.id_ordre
	INNER JOIN sysadm.commande c on c.id_sin = s.id_sin
	LEFT OUTER JOIN sysadm.div_det dd on dd.id_sin = c.id_sin  And 	dd.id_gti = c.id_gti  And 	dd.id_detail = c.id_detail and dd.nom_zone='mt_pec'
Where  	s.id_sin = @dcIdSin 
	And	c.id_four in ('ACU','FPC','CYT','MCY', 'ADV') -- [PC947&977]
--	and c.cod_etat = 'ECT' 



If @@RowCount < 1 
	Begin 
		Set @iRet = -1
		Select @asRetourMess = sysadm.FN_MESS ( 108, @asLangage )
		Set @aiCodeMsg = 108
		
		--[TRACE_25]
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			null,		-- @asCasProduit    varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNom,		-- @asMdp	    VarChar(50),
			@asNom,		-- @asNom	    Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			25,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'LECT_DONNEES',	-- @asEtape         varchar(20),
			108, 		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )		
	End 

-- Renvoi des données vers le WebService
If @iRet > 0 
	Begin 

		Select 
			rf.id_data,
			rf.libelle,
			convert(varchar(10),@dcIdSin) as valeur -- [PI062]
		From 	sysadm.ref_websim2 rf
		Where	rf.id_data = 'ID_SIN' 
		Union
		Select 
			rf.id_data,
			rf.libelle,
			civilite
		From 	@tbStock , sysadm.ref_websim2 rf
		Where	rf.id_data = 'CIVILITE'
		Union
		Select 
			rf.id_data,
			rf.libelle,
			nom
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'NOM'		
		Union
		Select 
			rf.id_data,
			rf.libelle,
			prenom
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'PRENOM'		
		Union
		Select 
			rf.id_data,
			rf.libelle,
			adresse			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'ADRESSE'		
		Union
		Select 
			rf.id_data,
			rf.libelle,
			code_postal			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'CODE_POSTAL'		
		Union
		Select 
			rf.id_data,
			rf.libelle,
			ville			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'VILLE'			
		Union
		Select 
			rf.id_data,
			rf.libelle,
			type_appareil			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'TYPE_APP'						
		Union
		Select 
			rf.id_data,
			rf.libelle,
			marque_app			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MARQ_APP'						
		Union
		Select 
			rf.id_data,
			rf.libelle,
			modele_app			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MODL_APP'					
		Union
		Select 
			rf.id_data,
			rf.libelle,
			num_serie			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'NUM_SERIE'				 
		Union
		Select 
			rf.id_data,
			rf.libelle,
			dte_decl			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'DTE_DECL'				
		Union
		Select 
			rf.id_data,
			rf.libelle,
			dte_adh			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'DTE_ADHESION'				
		Union
		Select 
			rf.id_data,
			rf.libelle,
			marque_rempl			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MARQUE 1'				
			and rank_cmd=1
		Union
		Select 
			rf.id_data,
			rf.libelle,
			modele_rempl			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MODELE 1'				
			and rank_cmd=1				
		Union
		Select 
			rf.id_data,
			rf.libelle,
			prix_ttc			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'PRIX TTC 1'				
			and rank_cmd=1
			Union
		Select 
			rf.id_data,
			rf.libelle,
			ref_mc_protect			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'REFERENCE MC PROTECT 1'				
			and rank_cmd=1
		Union
		Select 
			rf.id_data,
			rf.libelle,
			marque_rempl			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MARQUE 2'				
			and rank_cmd=2
		Union
		Select 
			rf.id_data,
			rf.libelle,
			modele_rempl			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MODELE 2'				
			and rank_cmd=2				
		Union
		Select 
			rf.id_data,
			rf.libelle,
			prix_ttc			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'PRIX TTC 2'				
			and rank_cmd=2
			Union
		Select 
			rf.id_data,
			rf.libelle,
			ref_mc_protect			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'REFERENCE MC PROTECT 2'				
			and rank_cmd=2
		Union
		Select 
			rf.id_data,
			rf.libelle,
			marque_rempl			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MARQUE 3'				
			and rank_cmd=3
		Union
		Select 
			rf.id_data,
			rf.libelle,
			modele_rempl			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MODELE 3'				
			and rank_cmd=3				
		Union
		Select 
			rf.id_data,
			rf.libelle,
			prix_ttc			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'PRIX TTC 3'				
			and rank_cmd=3
		Union
		Select 
			rf.id_data,
			rf.libelle,
			ref_mc_protect			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'REFERENCE MC PROTECT 3'				
			and rank_cmd=3
		Union
		Select 
			rf.id_data,
			rf.libelle,
			valeur_de_remplacement			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MT_PEC'
		
	End 
	
Return @iRet

Go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_LECTDONN_OMEA_TELECOM
-- Auteur               :       F. Pinon
-- Date                 :       23/09/2014
-- Libelle              :       [PC13447-1] 
-- Commentaires         :       Procédure de lecture de données pour le cas produit OMEA_TELECOM
--				Renvoie une liste de triplets de données "nom de variable"/"libellé de variable"/valeur
--                               
-- References           :       
--
-- Arguments            :       @asIdSin                VarChar(7)        	(Val) Identifiant de sinistre
--								@asNom			Varchar(50)		(Val) Nom du souscripteur
--								@asSKU			Varchar(100)		(Val) Numéro de SKU
--                              @asCas                  VarChar ( 40   )        (Val) Cas de Trt : 
--                              	CNX = Connexion + contrôle de validité du dossier
--									CTRL = contrôle de validité du dossier
--								@asLangage              VarChar (  3 )          (Val) Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
-- Retourne             :       Integer                 >0 = OK
--                                                      -1 = NOK
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_LECTDONN_OMEA_TELECOM' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_LECTDONN_OMEA_TELECOM
GO


CREATE PROCEDURE sysadm.PS_WEBSIM2_LECTDONN_OMEA_TELECOM
	@asIdSin                VarChar(50),
	@asNom			Varchar(50),
	@asSKU			Varchar(50),
	@asCodeVendeur		Varchar(50),
	@asCodeMagasin		Varchar(50),
	@asCas                  VarChar(50),
	@asIdSession     	varchar(50),
	@asBrowser       	varchar(200),
	@asLangage              VarChar (3),
	@aiCodeMsg		Integer OUTPUT,
        @asRetourMess           VarChar ( 2000 ) OUTPUT

AS
Declare @iRet	integer
DECLARE @dcIdSin 	Decimal ( 10 ) -- [PI062]
DECLARE @tbStock TABLE 
	( id_sin decimal(10,0), -- [PI062]
	civilite varchar(35),
	nom varchar(35),
	prenom varchar(35),
	adresse varchar(71),
	code_postal varchar(5),
	ville varchar(35),
	type_appareil varchar(35),
	marque_app varchar(35),
	modele_app varchar(35),
	num_serie varchar(60),
	dte_adh varchar(10),
	dte_decl varchar(10),
	marque_rempl varchar(35),
	modele_rempl varchar(35),
	prix_ttc decimal(11,2),
	id_seq int,
	dte_env_cli datetime,
	id_serie_nouv varchar(60),
	num_facture varchar(255),
	cod_etat_dossier varchar(10),
	etat_dossier varchar(255),
	mt_pec decimal(11,2)
	)

Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]
Set @iRet=1


Insert into @tbStock
Select  top 1 s.id_sin,
	sysadm.FN_CODE_NUM ( p.cod_civ, '-CI' ) 'civilite',
	p.nom 'nom',
	p.prenom 'prenom',
	IsNull ( p.adr_1, '' ) + ' ' + IsNull ( p.adr_2, '' ) 'adresse',
	p.adr_cp 'code_postal',
	p.adr_ville 'ville',
	( Select IsNull ( sysadm.FN_CODE_CAR ( ds.val_car, '-AR' )  , '' )
	  From sysadm.div_sin ds
	  Where ds.id_sin = s.id_sin
	  And 	ds.nom_zone = 'type_app' ) 'type_appareil',
	s.marq_port 'marque_app',
	s.modl_port 'modele_app',
	s.num_imei_port 'num_serie',
	convert(varchar(10),s.dte_adh,103) 'dte_adh',
	convert(varchar(10),s.dte_decl,103) 'dte_decl',
	c.id_marq_art 'marque_rempl',
	c.id_modl_art 'modele_rempl',
	c.mt_ttc_cmde 'prix_ttc',
	c.id_seq,
	c.dte_env_cli 'date_rempl',
	c.id_serie_nouv,
	sysadm.FN_CLE_VAL('NUM_FACTURE',c.info_frn_spb_cplt,';') as num_facture,
	Case When c.cod_etat='ECT' Then 'EREMPL'
		When c.cod_etat='RPC' Then 'CREMPL'
		When s.cod_etat=200 Then ' CREFUS'
		When exists (select * 
			from sysadm.commande c2 
			where c2.id_sin=s.id_sin and c2.id_typ_art='PRS' and status_gc=2) Then 'CREPA' 
		When exists (select * 
			from sysadm.commande c2 
			where c2.id_sin=s.id_sin and c2.id_typ_art='PRS' and cod_etat = 'ECT') Then 'EREPA' 
			Else 'EINST' End 'cod_etat_dossier',
	Case When c.cod_etat='ECT' Then 'En attente de remplacement magasin'
		When c.cod_etat='RPC' Then 'Clos – Remplacé'
		When s.cod_etat=200 Then 'Clos – Refusé'
		When exists (select * 
			from sysadm.commande c2 
			where c2.id_sin=s.id_sin and c2.id_typ_art='PRS' and status_gc=2) Then 'Clos – réparé' 
		When exists (select * 
			from sysadm.commande c2 
			where c2.id_sin=s.id_sin and c2.id_typ_art='PRS' and cod_etat = 'ECT') Then 'En cours de réparation' 
			Else 'En cours d''instruction' End 'etat_dossier',
	IsNull ( dd.val_mt, 0 ) 'mt_pec'
From	sysadm.sinistre s
	INNER JOIN sysadm.personne p on p.id_ordre = s.id_ordre
	LEFT OUTER JOIN sysadm.commande c on c.id_sin = s.id_sin And c.id_four in ('OME')
	LEFT OUTER JOIN sysadm.div_det dd on dd.id_sin = c.id_sin  And 	dd.id_gti = c.id_gti  And 	dd.id_detail = c.id_detail and dd.nom_zone='mt_pec'
Where  	s.id_sin = @dcIdSin 
order by c.id_seq desc



If @@RowCount < 1 
	Begin 
		Set @iRet = -1
		Select @asRetourMess = sysadm.FN_MESS ( 108, @asLangage )
		Set @aiCodeMsg = 108
		
		--[TRACE_25]
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			null,		-- @asCasProduit    varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNom,		-- @asMdp	    VarChar(50),
			@asNom,		-- @asNom	    Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			25,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'LECT_DONNEES',	-- @asEtape         varchar(20),
			108, 		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )		
	End 

-- Renvoi des données vers le WebService
If @iRet > 0 
	Begin 

		Select 
			rf.id_data,
			rf.libelle,
			convert(varchar(200),@dcIdSin) as valeur
		From 	sysadm.ref_websim2 rf
		Where	rf.id_data = 'ID_SIN' 
		Union
		Select 
			rf.id_data,
			rf.libelle,
			civilite
		From 	@tbStock , sysadm.ref_websim2 rf
		Where	rf.id_data = 'CIVILITE'
		Union
		Select 
			rf.id_data,
			rf.libelle,
			nom
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'NOM'		
		Union
		Select 
			rf.id_data,
			rf.libelle,
			prenom
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'PRENOM'		
		Union
		Select 
			rf.id_data,
			rf.libelle,
			adresse			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'ADRESSE'		
		Union
		Select 
			rf.id_data,
			rf.libelle,
			code_postal			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'CODE_POSTAL'		
		Union
		Select 
			rf.id_data,
			rf.libelle,
			ville			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'VILLE'			
		Union
		Select 
			rf.id_data,
			rf.libelle,
			type_appareil			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'TYPE_APP'						
		Union
		Select 
			rf.id_data,
			rf.libelle,
			marque_app			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MARQ_APP'						
		Union
		Select 
			rf.id_data,
			rf.libelle,
			modele_app			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MODL_APP'					
		Union
		Select 
			rf.id_data,
			rf.libelle,
			num_serie			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'NUM_SERIE'				 
		Union
		Select 
			rf.id_data,
			rf.libelle,
			dte_decl			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'DTE_DECL'				
		Union
		Select 
			rf.id_data,
			rf.libelle,
			dte_adh			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'DTE_ADHESION'				
		Union
		Select 
			rf.id_data,
			rf.libelle,
			marque_rempl			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MARQ_APP_REMPL'
		Union
		Select 
			rf.id_data,
			rf.libelle,
			modele_rempl			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MODL_APP_REMPL'						
		Union
		Select 
			rf.id_data,
			rf.libelle,
			convert(varchar(15),prix_ttc)		
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'PRIX_TTC_REMPL'				
			Union
		Select 
			rf.id_data,
			rf.libelle,
			convert(varchar(10),id_seq)
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'ID_SEQ'
		Union
		Select 
			rf.id_data,
			rf.libelle,
			CONVERT(varchar(10), dte_env_cli,103)			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'DTE_ENV_CLI'				
		Union
		Select 
			rf.id_data,
			rf.libelle,
			id_serie_nouv			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'ID_SERIE_REMPL'				
		Union
		Select 
			rf.id_data,
			rf.libelle,
			num_facture			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'NUM_FACTURE'				
			Union
		Select 
			rf.id_data,
			rf.libelle,
			cod_etat_dossier 			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'COD_ETAT_DOSSIER'
		Union
		Select 
			rf.id_data,
			rf.libelle,
			etat_dossier			
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'ETAT_DOSSIER'				
		Union
		Select 
			rf.id_data,
			rf.libelle,
			convert(varchar(15),mt_pec)
		From 	@tbStock , sysadm.ref_websim2 rf
		Where 	rf.id_data = 'MT_PEC'		
		
End

Return @iRet

Go

grant execute on sysadm.PS_WEBSIM2_LECTDONN_OMEA_TELECOM to rolebddsinistres
go