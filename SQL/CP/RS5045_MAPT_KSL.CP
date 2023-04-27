-------------------------------------------------------------------
--
-- Fichier              :       RS5045_MAPT_KSL.CP
-- Auteur               :       Fabry Jf
-- Date                 :       25/04/2023
--
-- Commentaires         :       !!!!!! A compiler sur TRACE_MAIL_XXX   !!!!!
--
-- Procedures           :       
-- sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE
-- sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
-- sysadm.PS_RS5045_I_MAIL_PUSH_KSL
-- sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER
-- sysadm.PS_RS5045_S_LISTE_VARIABLE_XML_KSL
-- sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL
-- sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL
--------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_S_LISTE_VARIABLE_XML_KSL
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :        
-- Commentaires         :       Ramène la liste des variable XML
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_S_LISTE_VARIABLE_XML_KSL' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_S_LISTE_VARIABLE_XML_KSL
GO

CREATE procedure sysadm.PS_RS5045_S_LISTE_VARIABLE_XML_KSL
AS

/* Récupère la liste hexaustive de toutes les varibables XML existants */

Select sc.name 
From sysobjects so,
     syscolumns sc
where so.type = 'U'
And   sc.id   = so.id
And   so.name = 'variable_xml_ksl_rs5045'
And   sc.name not in ( 'id_xml', 'cree_le', 'xml_data' )
order by 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :        
-- Commentaires         :       Insère une chaine XML à vide
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
GO

CREATE procedure sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
AS

Insert into sysadm.variable_xml_ksl_rs5045 
	( 
	  cree_le,
	  no_dossier_sinistre
	)
	Values
	(
	  Getdate(),
	  ''
	)

	-- Retour l'id_xml à stocker par le client appelet
	Return @@identity

Go


--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :        
-- Commentaires         :       Met à jour sur l'enregistrement id_xml donnée, les valeurs par défaut lié au sinistre et à l'interlocuteur
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER
GO

CREATE procedure sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER
	@adcIdSin Decimal ( 10 ),
	@adcIdInter Decimal ( 7 ),
	@aiIdXml integer
AS

Declare @dcIdSin Decimal ( 10 )
Declare @dcIdProd Decimal ( 7 )
Declare @dcIdRev Decimal ( 2 )

Declare @sCodInter varchar ( 1 )
Declare @sCodCivCourt VarChar ( 35 ) 
Declare @sCodCivLong VarChar ( 35 ) 
Declare @sNom VarChar ( 71 ) 
Declare @sPrenom VarChar ( 71 ) 
Declare @sAdresse1 VarChar ( 35 ) 
Declare @sAdresse2 VarChar ( 35 ) 
Declare @sCodePostal VarChar ( 5 ) 
Declare @sVille VarChar ( 35 ) 
Declare @sCodeProduitSinistre varchar ( 10 )
Declare @sNomProduit varchar ( 50 )
Declare @sNomProduitCpl varchar ( 50 )
Declare @sLibOptProduit varchar ( 100 )
Declare @sNoTelSpb varchar ( 20 )
Declare @sNoTelFax varchar ( 20 )
Declare @sNoPolice Varchar ( 35 ) 
Declare @sAssureur Varchar ( 35 ) 
Declare @sNoLigneAssuree Varchar ( 35 ) 
Declare @sCoutTelephonique VarChar ( 35 )
Declare @sCodeOperateur VarChar ( 4 )
Declare @sCodeProduit VarChar ( 10 )
Declare @sNoDossierSinistre VarChar ( 10 ) 
Declare @sMarqPort VarChar ( 35 ) 
Declare @sModlPort VarChar ( 35 ) 
Declare @sEmailProduit VarChar ( 150 )
Declare @DateDeDeclaration VarChar ( 10 )
Declare @sAdrMail VarChar ( 120 )
Declare @sIMEI VarChar ( 20 )
Declare @sMajPar VarChar ( 4 )
Declare @sNature VarChar ( 10 )
Declare @sIdInter Varchar ( 10 )

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
    -- *************************************
	-- ** PRODUCTION                      **
    -- *************************************

    -- *************************************
	-- ** Données liées à l'interlocuteur **
    -- *************************************

	Select @sCodCivCourt = Case i.cod_civ When 5 Then 'Messieurs' Else SIMPA2_PRO.sysadm.FN_CODE_NUM(i.cod_civ,'-CI') End,
		   @sCodCivLong = Case i.cod_civ When 5 Then 'Messieurs' Else SIMPA2_PRO.sysadm.FN_CODE_NUM(i.cod_civ,'-CL') End,
		   @sNom = i.nom,
		   @sPrenom = i.nom,
		   @sCodInter = i.cod_inter,
		   @sAdresse1 = i.adr_1,
		   @sAdresse2 = i.adr_2,
		   @sCodePostal = i.adr_cp,
		   @sVille = i.adr_ville,
		   @sAdrMail = i.adr_mail,
		   @sIdInter = i.id_i

	From SIMPA2_PRO.sysadm.inter i
	Where id_sin = @adcIdSin
	And id_i = @adcIdInter

	If @@RowCount <= 0
	 Begin 
		Select	@sCodCivCourt = Case i.cod_civ When 5 Then 'Messieurs' Else SIMPA2_PRO.sysadm.FN_CODE_NUM(i.cod_civ,'-CI') End,
				@sCodCivLong = Case i.cod_civ When 5 Then 'Messieurs' Else SIMPA2_PRO.sysadm.FN_CODE_NUM(i.cod_civ,'-CL') End,
				@sNom = i.nom,
				@sPrenom = i.nom,
				@sCodInter = i.cod_inter,
				@sAdresse1 = i.adr_1,
				@sAdresse2 = i.adr_2,
				@sCodePostal = i.adr_cp,
				@sVille = i.adr_ville,
				@sAdrMail = i.adr_mail,
				@sIdInter = i.id_i

		From SIMPA2_PRO.sysadm.w_inter i
		Where id_sin = @adcIdSin
		And id_i = @adcIdInter
	 End 

	-- Traitement particulier pour l'assuré pour récupérer le nom et prom
    If @sCodInter = 'A'
	  Begin
		Select @sNom = ps.nom,
			   @sPrenom = ps.prenom
		From SIMPA2_PRO.sysadm.sinistre s,
			 SIMPA2_PRO.sysadm.personne ps 
		Where s.id_sin = @adcIdSin
		And  ps.id_ordre = s.id_ordre

		If @@ROWCOUNT <= 0 
		  Begin
			Select @sNom = s.nom,
				   @sPrenom = s.prenom
			From sysadm.w_sin s
			Where s.id_sin = @adcIdSin
		 End 
	  End 

    -- *************************************
	-- ** Données liées au sinistre       **
    -- *************************************
	Select @dcIdSin = s.id_sin,
		   @dcIdRev = s.id_rev,
		   @dcIdProd = s.id_prod,
		   @sNoLigneAssuree = s.num_port,
		   @sCodeOperateur = s.maj_par,
		   @sNoDossierSinistre = Convert ( varchar (10), s.id_sin ),
		   @sMarqPort = s.marq_port,
		   @sModlPort = s.modl_port,
		   @DateDeDeclaration = convert ( VarChar ( 10 ), s.dte_decl, 23 ),
		   @sIMEI = s.num_imei_port,
		   @sMajPar = s.maj_par,
		   @sNature = Convert ( varchar (10), s.id_natsin ) 

	From SIMPA2_PRO.sysadm.sinistre s
	Where id_sin = @adcIdSin

	If @@RowCount <= 0
	 Begin 
		Select @dcIdSin = s.id_sin,
			   @dcIdRev = s.id_rev,
			   @dcIdProd = s.id_prod,
			   @sNoLigneAssuree = s.num_port,
			   @sCodeOperateur = s.maj_par,
			   @sNoDossierSinistre=Convert ( varchar (10), s.id_sin ),
			   @sMarqPort = s.marq_port,
			   @sModlPort = s.modl_port,
			   @DateDeDeclaration = convert ( VarChar ( 10 ), s.dte_decl, 23 ),
			   @sIMEI = s.num_imei_port,
			   @sMajPar = s.maj_par,
			   @sNature = Convert ( varchar (10), s.id_natsin ) 

		From SIMPA2_PRO.sysadm.w_sin s
		Where id_sin = @adcIdSin
	 End 

    -- *************************************
	-- ** Données liées au produit        **
    -- *************************************
	Select	@sNoTelSpb = p.num_tel,
			@sNoTelFax = p.num_fax,
			@sCodeProduitSinistre =  Convert ( varchar ( 10), p.id_prod ),
			@sNomProduit = ( select dp66.val_car from SIMPA2_PRO.sysadm.det_pro dp66 where dp66.id_prod = p.id_prod and dp66.id_code_dp = 66),
			@sNomProduitCpl = ( select dp66.val_car from SIMPA2_PRO.sysadm.det_pro dp66 where dp66.id_prod = p.id_prod and dp66.id_code_dp = 66),
			@sLibOptProduit = ( select dp67.val_car from SIMPA2_PRO.sysadm.det_pro dp67 where dp67.id_prod = p.id_prod and dp67.id_code_dp = 67),
			@sCoutTelephonique = (select rtrim(dp70.val_car) from SIMPA2_PRO.sysadm.det_pro dp70 where dp70.id_prod = p.id_prod and dp70.id_code_dp = 70),
			@sCodeProduit = 
					Case 
						When SIMPA2_PRO.sysadm.FN_CLE_NUMERIQUE ( 'PI085') > 0 Then 
							RIGHT('00000' + IsNull ( CONVERT(varchar(5), p.cod_prod_dms ), ''),5)   -- [PI085] passage de 3 à 5
						Else 
							RIGHT('000' + IsNull ( CONVERT(varchar(3), p.cod_prod_dms ), ''),3) -- [PI085] On laisse ainsi mail de P. Fauvel le 25/05/2020 à 09h16 archivé dans le projet.
					End,
			@sEmailProduit = (Select sysadm.FN_CLE_VAL ( 'ADR_MAIL_PROD', RTRIM ( dp.val_car ) + rtrim ( dp.val_car2), ';' ) From SIMPA2_PRO.sysadm.det_pro dp Where dp.id_prod = p.id_prod And dp.id_code_dp = 136 )					

	From SIMPA2_PRO.sysadm.produit p

	Where p.id_prod = @dcIdProd 

	-- *************************************
	-- ** Données liées assureur/police   **
    -- *************************************
	Select @sAssureur = SIMPA2_PRO.sysadm.FN_LIB_CIE ( @dcIdSin )
	Select @sNoPolice = SIMPA2_PRO.sysadm.FN_GET_LIB_POLICE_V01(@dcIdSin,@dcIdProd, @dcIdRev,-1,NULL) 
	If @sNoPolice is null or lTrim ( rTrim ( @sNoPolice )) = '' Select @sNoPolice = SIMPA2_PRO.sysadm.FN_LIB_POLICE ( @dcIdSin )

END
ELSE
BEGIN

    -- *************************************
	-- ** SIMULATION                      **
    -- *************************************

    -- *************************************
	-- ** Données liées à l'interlocuteur **
    -- *************************************
	Select @sCodCivCourt = Case i.cod_civ When 5 Then 'Messieurs' Else SIMPA2_TRT.sysadm.FN_CODE_NUM(i.cod_civ,'-CI') End,
		   @sCodCivLong = Case i.cod_civ When 5 Then 'Messieurs' Else SIMPA2_TRT.sysadm.FN_CODE_NUM(i.cod_civ,'-CL') End,
		   @sNom = i.nom,
		   @sPrenom = i.nom,
		   @sCodInter = i.cod_inter,
		   @sAdresse1 = i.adr_1,
		   @sAdresse2 = i.adr_2,
		   @sCodePostal = i.adr_cp,
		   @sVille = i.adr_ville,
		   @sAdrMail = i.adr_mail,
		   @sIdInter = i.id_i

	From SIMPA2_TRT.sysadm.inter i
	Where id_sin = @adcIdSin
	And id_i = @adcIdInter

	If @@RowCount <= 0
	 Begin 
		Select	@sCodCivCourt = Case i.cod_civ When 5 Then 'Messieurs' Else SIMPA2_TRT.sysadm.FN_CODE_NUM(i.cod_civ,'-CI') End,
				@sCodCivLong = Case i.cod_civ When 5 Then 'Messieurs' Else SIMPA2_TRT.sysadm.FN_CODE_NUM(i.cod_civ,'-CL') End,
				@sNom = i.nom,
				@sPrenom = i.nom,
				@sCodInter = i.cod_inter,
				@sAdresse1 = i.adr_1,
				@sAdresse2 = i.adr_2,
				@sCodePostal = i.adr_cp,
				@sVille = i.adr_ville,
				@sAdrMail = i.adr_mail,
				@sIdInter = i.id_i

		From SIMPA2_TRT.sysadm.w_inter i
		Where id_sin = @adcIdSin
		And id_i = @adcIdInter
	 End 

	-- Traitement particulier pour l'assuré pour récupérer le nom et prom
    If @sCodInter = 'A'
	  Begin
		Select @sNom = ps.nom,
			   @sPrenom = ps.prenom
		From SIMPA2_TRT.sysadm.sinistre s,
			 SIMPA2_TRT.sysadm.personne ps 
		Where s.id_sin = @adcIdSin
		And  ps.id_ordre = s.id_ordre

		If @@ROWCOUNT <= 0 
		  Begin
			Select @sNom = s.nom,
				   @sPrenom = s.prenom
			From sysadm.w_sin s
			Where s.id_sin = @adcIdSin
		 End 
	  End 

    -- *************************************
	-- ** Données liées au sinistre       **
    -- *************************************
	Select @dcIdSin = s.id_sin,
		   @dcIdRev = s.id_rev,
		   @dcIdProd = s.id_prod,
		   @sNoLigneAssuree = s.num_port,
		   @sCodeOperateur = s.maj_par,
		   @sNoDossierSinistre = Convert ( varchar (10), s.id_sin ),
		   @sMarqPort = s.marq_port,
		   @sModlPort = s.modl_port,
		   @DateDeDeclaration = convert ( VarChar ( 10 ), s.dte_decl, 23 ),
		   @sIMEI = s.num_imei_port,
		   @sMajPar = s.maj_par,
		   @sNature = Convert ( varchar (10), s.id_natsin ) 

	From SIMPA2_TRT.sysadm.sinistre s
	Where id_sin = @adcIdSin

	If @@RowCount <= 0
	 Begin 
		Select @dcIdSin = s.id_sin,
			   @dcIdRev = s.id_rev,
			   @dcIdProd = s.id_prod,
			   @sNoLigneAssuree = s.num_port,
			   @sCodeOperateur = s.maj_par,
			   @sNoDossierSinistre=Convert ( varchar (10), s.id_sin ),
			   @sMarqPort = s.marq_port,
			   @sModlPort = s.modl_port,
			   @DateDeDeclaration = convert ( VarChar ( 10 ), s.dte_decl, 23 ),
			   @sIMEI = s.num_imei_port,
			   @sMajPar = s.maj_par,
			   @sNature = Convert ( varchar (10), s.id_natsin ) 

		From SIMPA2_TRT.sysadm.w_sin s
		Where id_sin = @adcIdSin
	 End 

    -- *************************************
	-- ** Données liées au produit        **
    -- *************************************
	Select	@sNoTelSpb = p.num_tel,
			@sNoTelFax = p.num_fax,
			@sCodeProduitSinistre =  Convert ( varchar ( 10), p.id_prod ),
			@sNomProduit = ( select dp66.val_car from SIMPA2_TRT.sysadm.det_pro dp66 where dp66.id_prod = p.id_prod and dp66.id_code_dp = 66),
			@sNomProduitCpl = ( select dp66.val_car from SIMPA2_TRT.sysadm.det_pro dp66 where dp66.id_prod = p.id_prod and dp66.id_code_dp = 66),
			@sLibOptProduit = ( select dp67.val_car from SIMPA2_TRT.sysadm.det_pro dp67 where dp67.id_prod = p.id_prod and dp67.id_code_dp = 67),
			@sCoutTelephonique = (select rtrim(dp70.val_car) from SIMPA2_TRT.sysadm.det_pro dp70 where dp70.id_prod = p.id_prod and dp70.id_code_dp = 70),
			@sCodeProduit = 
					Case 
						When SIMPA2_TRT.sysadm.FN_CLE_NUMERIQUE ( 'PI085') > 0 Then 
							RIGHT('00000' + IsNull ( CONVERT(varchar(5), p.cod_prod_dms ), ''),5)   -- [PI085] passage de 3 à 5
						Else 
							RIGHT('000' + IsNull ( CONVERT(varchar(3), p.cod_prod_dms ), ''),3) -- [PI085] On laisse ainsi mail de P. Fauvel le 25/05/2020 à 09h16 archivé dans le projet.
					End,
			@sEmailProduit = (Select sysadm.FN_CLE_VAL ( 'ADR_MAIL_PROD', RTRIM ( dp.val_car ) + rtrim ( dp.val_car2), ';' ) From SIMPA2_TRT.sysadm.det_pro dp Where dp.id_prod = p.id_prod And dp.id_code_dp = 136 )					

	From SIMPA2_TRT.sysadm.produit p

	Where p.id_prod = @dcIdProd 

	-- *************************************
	-- ** Données liées assureur/police   **
    -- *************************************
	Select @sAssureur = SIMPA2_TRT.sysadm.FN_LIB_CIE ( @dcIdSin )
	Select @sNoPolice = SIMPA2_TRT.sysadm.FN_GET_LIB_POLICE_V01(@dcIdSin,@dcIdProd, @dcIdRev,-1,NULL) 
	If @sNoPolice is null or lTrim ( rTrim ( @sNoPolice )) = '' Select @sNoPolice = SIMPA2_TRT.sysadm.FN_LIB_POLICE ( @dcIdSin )
	
END	

-- *************************************
-- ** mis à jour de l'enregistrement  **
-- *************************************

Update sysadm.variable_xml_ksl_rs5045 
Set civ = @sCodCivCourt,
	civilite_courte = @sCodCivCourt,
	civilite_longue = @sCodCivLong,
	nom = @sNom, -- Pour KSL : Si nom = prenom et que les 2 données sont renseignée, alors n'exploitez qu'une seule donnée, le nom par exemple.
	prenom = @sPrenom,
	adresse1 = @sAdresse1,
	adresse2 = @sAdresse2,
	code_postal = @sCodePostal, 
	ville = @sVille,
	code_produit_sinistre = @sCodeProduitSinistre,
	nom_produit = @sNomProduit,
	nom_produit_cpl = @sNomProduitCpl,
	lib_opt_produit = @sLibOptProduit,
	no_tel_spb = @sNoTelSpb,
	num_tel_prod = @sNoTelSpb,
	assureur = @sAssureur,
	no_police = @sNoPolice,
	police = @sNoPolice,
	cout_telephonique = @sCoutTelephonique,
	code_produit = @sCodeProduit,
	code_operateur = @sCodeOperateur,
	no_dossier_sinistre = @sNoDossierSinistre,
	email_produit = @sEmailProduit,
	app_marque = @sMarqPort,
	app_modele = @sModlPort,
	date_de_declaration = @DateDeDeclaration, 
	adr_mail = @sAdrMail,
	imei = @sIMEI,
	maj_par = @sMajPar,
	nature = @sNature,
	id_inter = @sIdInter

Where id_xml = @aiIdXml


Go

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :        
-- Commentaires         :       Mets toutes les variables null à vide, à utiliser avant la construction de la chaine XML
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL
GO

CREATE procedure sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL
	@iIdXml integer,
	@sNullAVide Varchar ( 3 ), -- OUI/NON
	@sTrimerAGauche Varchar ( 3 ), -- OUI/NON
	@sTrimerADroite Varchar ( 3 ) -- OUI/NON
AS

Declare @Tb Table ( nom_zone varchar (50)) 
Declare @sNomZone VarChar ( 50 ) 
Declare @iIdSeq integer
Declare @sSql VarChar ( 200 ) 

Insert into @Tb Exec sysadm.PS_RS5045_S_LISTE_VARIABLE_XML_KSL 

While Exists ( Select Top 1 1 From @Tb )
 Begin
	Select 	Top 1 
		@sNomZone = nom_zone
	From	@Tb

	IF Upper ( @sNullAVide ) = 'OUI' 
	 Begin
		Set @sSql = 'Update sysadm.variable_xml_ksl_rs5045 Set ' + @sNomZone + '='''' where id_xml = ' + convert ( VarChar ( 10), @iIdXml ) + ' and ' + @sNomZone + ' is null '
		Execute (@sSql)
	 End 

	IF Upper ( @sTrimerAGauche ) = 'OUI' 
	 Begin
		Set @sSql = 'Update sysadm.variable_xml_ksl_rs5045 Set ' + @sNomZone + '= lTrim ( ' + @sNomZone + ' ) where id_xml = ' + convert ( VarChar ( 10), @iIdXml ) + ' and ' + @sNomZone + ' is not null '
		Execute (@sSql)
	 End 

	IF Upper ( @sTrimerADroite ) = 'OUI' 
	 Begin
		Set @sSql = 'Update sysadm.variable_xml_ksl_rs5045 Set ' + @sNomZone + '= rTrim ( ' + @sNomZone + ' ) where id_xml = ' + convert ( VarChar ( 10), @iIdXml ) + ' and ' + @sNomZone + ' is not null '
		Execute (@sSql)
	 End 

	Delete @Tb Where nom_zone = @sNomZone
 End

Go


--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :        
-- Commentaires         :       Insère une chaine XML à vide
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE
GO

CREATE procedure sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE
	@iIdXml integer, 
	@xmlResult varchar(max) OUTPUT
AS
	
	select @xmlResult=(
	select top 1 

		-- ci-dessous Section <Tech

		'C' as 'tech/@canal',
		code_maquette as 'tech/@code_maquette',
		'S' as 'tech/@code_adhsin',

		-- ci-dessous Section <Entete

		montant_debite as 'entete/@montant_debite',
		civilite_courte as 'entete/@civilite_courte',
		civ as 'entete/@civ', -- [PM234-7][M21970]
		civilite_longue as 'entete/@civilite_longue',
		nom as 'entete/@nom',
		prenom as 'entete/@prenom',
		adresse1 as 'entete/@adresse1',
		adresse2 as 'entete/@adresse2',
		code_postal as 'entete/@code_postal',
		ville as 'entete/@ville',
		code_produit_sinistre as 'entete/@code_produit_sinistre',
		nom_produit as 'entete/@nom_produit',
		nom_produit_cpl as 'entete/@nom_produit_cpl',
		lib_opt_produit as 'entete/@lib_opt_produit',
		no_tel_spb as 'entete/@no_tel_spb',
		num_tel_prod as 'entete/@num_tel_prod', -- [PM234-7][M21970]
		no_fax_spb as 'entete/@no_fax_spb',
		assureur as 'entete/@assureur',
		no_police as 'entete/@no_police',
		police as 'entete/@police',-- [PM234-7][M21970]
		no_ligne_assuree as 'entete/@no_ligne_assuree',
		cout_telephonique as 'entete/@cout_telephonique',
		code_produit as 'entete/@code_produit', 
		code_operateur as 'entete/@code_gestionnaire',
		no_dossier_sinistre as 'entete/@no_dossier_sinistre',
		ref_indemnisation as 'entete/@ref_indemnisation', -- [PC13321]
		email_produit as 'entete/@email_produit', -- [DT154][MANTIS16226]
		'' as 'entete/@mail_exp', -- Sera armé plus loin pour toute appli par sysadm.PS_RS5045_I_MAIL_PUSH_KSL et sysadm.PS_S_SUBTITUER_VARIABLE_XML

		-- Ci-dessous sectuon <Courrier

		code_operateur as 'courrier/@code_gestionnaire',
		app_marque as 'courrier/@app_marque',
		app_modele as 'courrier/@app_modele',
		montant_caution as 'courrier/@montant_caution',
		no_dossier_sinistre as 'courrier/@no_dossier_sinistre',
		date_de_declaration as 'courrier/@date_de_declaration',
		nom_produit as 'courrier/@nom_produit',
		nom as 'courrier/@nom',
		prenom as 'courrier/@prenom',
		code_operateur as 'courrier/@code_operateur',
		lib_opt_produit as 'courrier/@lib_opt_produit',
		app_pret as 'courrier/@app_pret',
		type_appareil as 'courrier/@type_appareil',
		'A' as 'courrier/@code_envoi',
		app_marque_rempl as 'courrier/@app_marque_rempl',
		app_modele_rempl as 'courrier/@app_modele_rempl',
		date_refus as 'courrier/@date_refus',
		nom_livraison as 'courrier/@nom_livraison',
		adresse1_livraison as 'courrier/@adresse1_livraison',
		adresse2_livraison as 'courrier/@adresse2_livraison',
		cp_ville_livraison as 'courrier/@cp_ville_livraison',
		adr_mail as 'courrier/@email',
		civ_livraison as 'courrier/@civ_livraison', -- [PM246]
		prenom_livraison as 'courrier/@prenom_livraison', -- [PM246]
		adressecplt_livraison as 'courrier/@adressecplt_livraison',   -- [PM246]
		transporteur as 'courrier/@transporteur', -- [PM246]
		num_bon_trans as 'courrier/@num_bon_transp', -- [PM246]
		relance as 'courrier/@relance', -- [DT081_EVOL_PRET_BRIS]
		typ_app_pret as 'courrier/@typ_app_pret', -- [DT081_EVOL_PRET_BRIS]
		code_pick_up as 'courrier/@code_pick_up', -- [PM255]
		dte_arr_plateforme as 'courrier/@dte_arr_plateforme', -- [PM250-1]
		dte_dep_centre_distrib as 'courrier/@dte_dep_centre_distrib', -- [PM250-1]
		montant_carte_cadeau  as 'courrier/@montant_carte_cadeau', -- [PC13321]
		id_seq_cmde  as 'courrier/@id_seq_cmde', -- [PC13321]		
		code_chq_cadeau as 'courrier/@code_chq_cadeau', -- [PC13321]
		ZVAR46 as 'courrier/@ZVAR46', -- [DT154] 
		code_acces_securise as 'courrier/@code_acces_securise', -- [PM287-3]
		imei as 'courrier/@imei', -- [PM234-7][M21970]
		maj_par as 'courrier/@maj_par', -- [PM234-7][M21970]
		'' as 'courrier/@produit_orange', -- [PM234-7][M21970]
		adr_mail_cc as 'courrier/@Mail_Copie_a_1', -- [PM234-7][M21970]
		environnement as 'courrier/@environnement', -- [PM287-3]
		adr_mail_cc as 'courrier/@email_cc', -- [DF006]
		code_refus as 'courrier/@code_refus', -- [DF005-1-LOT2]
		nature as 'courrier/@nature', -- [DF005-1-LOT2]
		var_enum1 as 'courrier/@var_enum1', -- [PM287-6][MANTIS26879]
		var_enum2 as 'courrier/@var_enum2', -- [PM287-6][MANTIS26879]
		numero_relance as 'courrier/@numero_relance', -- [PM407-1]
		joindre_courrier_orig as 'courrier/@joindre_courrier_orig', -- [PM407-1]
		id_arch_orig as 'courrier/@id_arch_orig', -- [PM407-1]
		env_en_recommande as 'courrier/@env_en_recommande', -- [PM407-1]
		derniere_relance as 'courrier/@derniere_relance', -- [PM407-1]
		date_cour_orig as 'courrier/@date_cour_orig', -- [PM407-1]
		date_dern_rel as 'courrier/@date_dern_rel', -- [PM407-1]
		categorie_relance as 'courrier/@categorie_relance', -- [PM407-1]
		id_inter as 'courrier/@id_inter', -- [PM407-1]
		id_doc as 'courrier/@id_doc', -- [PM407-1]
		env_par_mail as 'courrier/@env_par_mail' -- [PM407-1]

	from sysadm.variable_xml_ksl_rs5045 v
	Where id_xml = @iIdXml
	FOR XML PATH('demande'))
	
	set @xmlResult=REPLACE(@xmlResult,'/></demande>',
		'><tableaux><T1></T1><T2></T2><T3></T3><T4></T4><T5></T5><T6></T6></tableaux></courrier></demande>')
	
	Set @xmlResult='<?xml version="1.0" encoding="UTF-8"?><liste_demande>' + 
		@xmlResult +
		'</liste_demande>'

	Update sysadm.variable_xml_ksl_rs5045
	Set xml_data=@xmlResult
	Where id_xml = @iIdXml
Go

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_I_MAIL_PUSH_KSL
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :        
-- Commentaires         :       Insère l'enregistrement dans Trace_Mail_Pro.sysadm.mail_push, 
--	                            à la nouvelle méthode
-- References           :       
--
-- Arguments            :       @asMethode => Toujours 'KSL2'
--								@asMethodeKSL => 
--									'RS5045_MATPN' Si methode 1, MailPush Simple dont Etudes Sinistre donne le corps de texte (PM191)
--									'RS5045_MATPD' Si methode 2, Courrier SIMPA2 (voire autre appli plus tard, style PEGASE)  (PM159)
--									'RS5045_CODMAQ' Si nouvelle Méthode 6 lié au présent projet RS5045, KSL doit donné au client appelant 
--													un code maquette spécifique pour un besoin spécifique
--								
--									Cas Obsolète et fermé du 'KSL_EDS'
--										Cette méthode n'est plus à utiliser, elle ser rejétée si elle est appelée dans cette PS.
--										Malgré tout, 4 courriers sont lié à cette méthode et KSL ne refera pas ces courriers, 
--										c'est pour cela, que seuls ces 4 courriers sont autorisé en méthode KSL_EDS.
--										Ce sont les 4 codes maquettes 'MAIL_CASTO_DT133_2REL', 'MAIL_CASTO_DT133_1REL', 'MAIL_CASTO_DT133_ORIG', 'GEOLOC'
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_I_MAIL_PUSH_KSL' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_I_MAIL_PUSH_KSL
GO

CREATE procedure sysadm.PS_RS5045_I_MAIL_PUSH_KSL
		@asIdAppli              Char (  10 )    ,  
		@aiIdSin                Integer         ,  
		@aiIdProd               Integer         ,  
		@asLibProd              VarChar ( 255 ) ,  
		@aiIdEts                Integer         ,  
		@asMailFrom             VarChar ( 128 ) ,  
		@asMailSend             VarChar ( 128 ) ,  
		@asMailCc               VarChar ( 128 ) ,  
		@asMailCci              VarChar ( 128 ) , -- [PM191-2]  
		@asMailSubject          VarChar ( 255 ) ,  
		@asMailBody             VarChar ( 7000 ),  
		@asAltQuarantaine       VarChar (   1 ),  
		@asBoiteMail			VarChar (35), 
		@asTypMail				VarChar (10), 
		@aiIdAppli              Integer, 
		@asMethode				Varchar ( 6 ), -- [PM159]  
		@asMethodeKSL			VarChar ( 50 ), -- voir plus haut quelle valeur passer ici [RS5045_REF_MATP]
		@aiIdArch				Integer , -- [PM159]  
		@asXMLdata				VarChar ( max ), -- [PM159]  
		@aiIdChemin				Integer, -- chemin à définir sur TRACE_MAIL_xxx.sysadm.chem_depot_ksl si besoin (voir JFF)
		@adtDteHExec			DateTime, -- Date et heure avant laquelle le mail ne peut pas être envoyé, null si aucune critère
		@asErrOutPut			VarChar ( 255 ) OutPut          
AS  

Select '@asXMLdata', @asXMLdata

Declare @sCodeMaquette VarChar ( 100 )
Declare @iRet integer 
Declare @iIdSeq integer  
Declare @iErr integer  
Declare @dcIdProdAdh Decimal ( 5 )  
Declare @dcIdSin Decimal ( 10 )  
Declare @sAdrMailBalProduit VarChar ( 200 )  

-- Nettoyage de ma la Table de stockage des xml temporaire, on garde que 15 jours.
Delete sysadm.variable_xml_ksl_rs5045 where cree_le < DateAdd ( day, -15, Getdate())

Set @asMethode = Upper ( lTrim ( rTrim ( @asMethode )))

-- **********************************************************************************
-- ** Cette PS ne traite que tu KSL2, malgré tout je le garde en argument d'entrée ** 
-- ** afin que le client appelant en soit conscient                                **
-- **********************************************************************************
if @asMethode <> 'KSL2' 
 Begin 
   Set @asErrOutPut = 'La méthode doit absolument être KSL2'
   Return -1
 End

-- **********************************************************************************
-- ** Traitement des cas existants sur lesquels on doit conserver les XML existants** 
-- ** METHODE 4 (KSL_EDS)                                                          **
-- **********************************************************************************

-- Récupération du code maquette soit en Maq_code ou code_maquette
Set @sCodeMaquette = sysadm.FN_CLE_VAL_XML ( 'code_maquette', @asXMLdata, 'NON' ) 

-- Rejet si...
if @asMethodeKSL = 'KSL_EDS' And Upper ( @sCodeMaquette ) Not in ( 'MAIL_CASTO_DT133_2REL', 'MAIL_CASTO_DT133_1REL', 'MAIL_CASTO_DT133_ORIG', 'GEOLOC' ) 
Begin
   Set @asErrOutPut = 'La méthode_KSL n''est plus autorisée hormis pour 4 codes maquettes spécifiques, voir doc ou sp_helptext ''sysadm.PS_RS5045_I_MAIL_PUSH_KSL'''
   Return -2
End 

-- Traitement des cas de la Methode 4 actuelle (KSL_EDS)
If Upper ( @sCodeMaquette ) in ( 'MAIL_CASTO_DT133_2REL', 'MAIL_CASTO_DT133_1REL', 'MAIL_CASTO_DT133_ORIG', 'GEOLOC' ) 
  Begin
		If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		 Begin
			   Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V02
				@asIdAppli,
				@aiIdSin,
				@aiIdProd,
				@asLibProd,
				@aiIdEts,
				@asMailFrom,
				@asMailSend,
				@asMailCc,
				@asMailCci,
				@asMailSubject,
				@asMailBody,
				@asAltQuarantaine,
				@asBoiteMail,
				@asTypMail,
				@aiIdAppli,
				@asMethode,
				@asMethodeKSL,
				-1,
				@asXMLdata

		   End    

		Else
		 Begin
			 Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V02
				@asIdAppli,
				@aiIdSin,
				@aiIdProd,
				@asLibProd,
				@aiIdEts,
				@asMailFrom,
				@asMailSend,
				@asMailCc,
				@asMailCci,
				@asMailSubject,
				@asMailBody,
				@asAltQuarantaine,
				@asBoiteMail,
				@asTypMail,
				@aiIdAppli,
				@asMethode,
				@asMethodeKSL,
				-1,
				@asXMLdata
		
		 End	

	-- fin du traitement dans ce cas
	Return @iRet 

  End 

-- **********************************************************************************
-- ** Traitement des cas liés à la nouvelle méthode, à l'unique XML à utiliser à   ** 
-- ** présent => METHODE 6  (RS5045)                                               **
-- **********************************************************************************

-- Contrôle de l'id_chemin, il doit être déclaré sur [sysadm].[chem_depot_ksl]
If Not Exists ( Select Top 1 1 From sysadm.chem_depot_ksl where id_chem = @aiIdChemin ) 
  Begin
	   Set @asErrOutPut = 'l''@aiIdChemin ' + Convert ( varchar ( 10 ), @aiIdChemin ) + ' doit être déclaré sur TRACE_MAIL_xxx.sysadm.chem_depot_ksl avec une chemin UNC valide.'
	   Return -3
  End 

 
Set @iErr = 0  
Set @asMailCci=NULL -- Aucune variable XML KSL pour accueillir cette donnée
Set @dcIdSin = CONVERT ( Decimal ( 10 ), @aiIdSin )  
Set @asIdAppli = UPPER ( LTRIM ( RTRIM ( @asIdAppli )))  
If  @asXMLdata is NULL Set @asXMLdata='' -- [ITSM318621]  

 
-- [ISM109407] Agnès Yvon le 24/09/2020 (JFF)  
-- JFF / 04/06/2021 / [RS-328-RS329-RS380]  
If  @asIdAppli = 'SIMPA2'   
 Begin    
  Exec sysadm.PS_RECUP_DATA_SIMPA2 @dcIdSin, @dcIdProdAdh output, @sAdrMailBalProduit output  
 End   
  
-- JFF / 04/06/2021 / [RS-328-RS329-RS380]  
If  @asIdAppli = 'PEGASE'   
 Begin    
  Exec sysadm.PS_RECUP_DATA_PEGASE @dcIdSin, @dcIdProdAdh output, @sAdrMailBalProduit output  
 End  
  
-- JFF / 04/06/2021 / [RS-328-RS329-RS380]  
If  @asIdAppli = 'SHERPA'   
 Begin    
  Exec sysadm.PS_RECUP_DATA_SHERPA @aiIdSin, @aiIdProd, @sAdrMailBalProduit output  
 End  


If @aiIdArch is null set @aiIdArch=-1  
If @asMailFrom is null or ltrim ( rtrim(@asMailFrom)) = '' Set @asMailFrom = 'noreply@spb.eu'  
If @asBoiteMail is null or rtrim ( rtrim ( @asBoiteMail)) = '' Set @asBoiteMail = 'noreply@spb.eu'  
   
Set @asLibProd = Replace ( @asLibProd, ' & ', ' et ')  
Set @asLibProd = Replace ( @asLibProd, '& ', ' et ')  
Set @asLibProd = Replace ( @asLibProd, ' &', ' et ')  
Set @asLibProd = Replace ( @asLibProd, '&', ' et ')  
Set @asLibProd = REPLACE(@asLibProd, '"','&quot;')  
  
Set @asMailSubject = Replace ( @asMailSubject, ' & ', ' et ')  
Set @asMailSubject = Replace ( @asMailSubject, '& ', ' et ')  
Set @asMailSubject = Replace ( @asMailSubject, ' &', ' et ')  
Set @asMailSubject = Replace ( @asMailSubject, '&', ' et ')  
Set @asMailSubject = REPLACE(@asMailSubject, '"','&quot;')  
    
 
 -- JFF / 04/06/2021 / [RS-328-RS329-RS380]  
If @sAdrMailBalProduit <> ''  
 Begin  
  Exec sysadm.PS_S_SUBTITUER_VARIABLE_XML 'Mail_Exp', @sAdrMailBalProduit, @asXMLdata output  
 End   
  
If LEN ( LTRIM ( RTRIM ( @asMailCc ) ) ) = 0  SET @asMailCc = NULL

 
INSERT INTO sysadm.mail_push  
        (  
                id_appli,  
                id_sin,  
                id_prod,  
                lib_prod,  
                id_ets,  
                cree_le,  
                mail_from,  
                mail_send,  
                mail_cc,  
                mail_subject,  
                mail_body,  
                alt_quarantaine,  
                boite_mail, -- #1  
                typ_mail,   -- #1  
                id_appli_num, -- #1  
                methode, 
                id_arch,
				xml_data,
				xml_data2, -- [RS5045_REF_MATP]
				id_chemin, -- [RS5045_REF_MATP]
				dateh_exec -- [RS5045_REF_MATP]
        )  
VALUES  
        (  
                @asIdAppli,  
                @aiIdSin,  
                @aiIdProd,  
                @asLibProd,  
                @aiIdEts,  
                GetDate(),  
                @asMailFrom,  
                @asMailSend,  
				@asMailCc,  
                @asMailSubject,  
                @asMailBody,  
				@asAltQuarantaine,  
				@asBoiteMail,  
				@asTypMail,  
				@aiIdAppli,  
				@asMethode,  
				@aiIdArch,  
                Left ( @asXMLdata, 2000), -- [RS5045_REF_MATP]
				Substring ( @asXMLdata, 2001, Len ( @asXMLdata ) ),  -- [RS5045_REF_MATP]
				@aiIdChemin,
				@adtDteHExec
        )  
  
Set @iErr = @@ERROR     
  
Set @iIdSeq = @@IDENTITY  
  
RETURN @iErr  

Go

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :        
-- Commentaires         :       A appeler par le client, Arme une valeur XML
--	                            à la nouvelle méthode
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL
GO

CREATE procedure sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL
	@iIdXml integer, -- Clé de l'enregistrement XML_KSL
    @sXmlKey     VarChar (255), -- Clé sur laquelle mettre à jour la donnée
	@sXmlData    VarChar (255) -- Donnée à mettre à jour sur la clé

	-- Retourne le Nbre de Row mis à jour, normalement 1, et sinon -1 si aucun Row mis à jour ce qui s'apparente à une erreur
As

Declare @sSql VarChar  ( 255 )
Declare @iRowCount Integer

Set @sXmlKey = lower ( lTrim ( rTrim ( @sXmlKey ) ) )
Set @sXmlData = lTrim ( rTrim ( @sXmlData ) ) 

Set @sSql = 'Update sysadm.variable_xml_ksl_rs5045 Set ' + @sXmlKey + '=''' + @sXmlData + ''' Where id_xml =' + Convert ( Varchar ( 20 ), @iIdXml )
Exec (@sSql)

Set @iRowCount = @@RowCount

If @iRowCount <= 0 Set @iRowCount = -1

Return @iRowCount 

Go


--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :        
-- Commentaires         :       
--	                            
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL
GO

CREATE procedure sysadm.PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL
	@asTypMail   varchar (6),
    @asCodeMaquette VarChar (255) output
As

Select Top 1 @asCodeMaquette = rTrim ( lTrim ( cm.cod_maq ))
From sysadm.code_maquette_ksl_rs5045 cm
Where cm.typ_mail = @asTypMail

If @asCodeMaquette is null Set @asCodeMaquette = ''

Go

