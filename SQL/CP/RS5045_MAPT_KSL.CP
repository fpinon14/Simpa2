use TRACE_MAIL_TRT
Go
-------------------------------------------------------------------
--
-- Fichier              :       RS5045_MAPT_KSL.CP
-- Auteur               :       Fabry Jf
-- Date                 :       25/04/2023
--
-- Commentaires         :      /!\ !!!!!! A compiler sur TRACE_MAIL_XXX   !!!!!   /!\
--
-- Procedures           :       
-- sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE
-- sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
-- sysadm.PS_RS5045_I_MAIL_PUSH_KSL
-- sysadm.PS_RS5045_I_MAIL_PUSH_KSL_V01
-- sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_PEGASE
-- sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_SIMPA2
-- sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL
-- sysadm.PS_RS5045_S_LISTE_VARIABLE_XML_KSL
-- sysadm.PS_RS5045_S_PRE_ARMEMENT_TECHNIQUE
-- sysadm.PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL
-- sysadm.PS_RS5045_S_RECUPERER_LE_BLOB_COURRIER
-- sysadm.PS_RS5045_S_RECUPERER_UNE_DONNEE_D_UNE_VARIABLE_PRE_ARMEE
-- sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL
-- sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL_V04
-- sysadm.PS_RS5045_TRANSFORMATION_DES_CRLF_FORMAT_XML_UTF8
-- sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL
-- sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL
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

/* Interroger pour trouver un variable
Declare @Tb Table ( id_zone Varchar ( 100 ))
Insert into @Tb exec TRACE_MAIL_TRT.sysadm.PS_RS5045_S_LISTE_VARIABLE_XML_KSL
Select * from @Tb 
Select * from @Tb where id_zone like '%no_commande%'
*/

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

	-- Retour l'id_xml à stocker par le client appelant
	Return @@identity

Go


--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_SIMPA2
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :        
-- Commentaires         :       Met à jour sur l'enregistrement id_xml donnée, les valeurs par défaut lié au sinistre et à l'interlocuteur
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- JFF      05/08/2024   [MCO602_PNEU]
-- JFF      19/12/2024   [MIG1_COUR_EMAILING]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_SIMPA2' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_SIMPA2
GO

CREATE procedure sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_SIMPA2
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

Declare @sNoAdhesion varchar (50)
Declare @sDateDeSurvenanceSinistre varchar (35)
Declare @sHeureDeSurvenanceSinistre varchar (20)
Declare @sNotTelInterAssure varchar (35)
Declare @sLibNature varchar (35)
Declare @sCodeGarantie varchar (50)
Declare @sGarantie varchar (50)
Declare @sURLextranet varchar (100)
Declare @sDateConnaissanceSinistre varchar (10)
Declare @sDateFinGarantie varchar (10)
Declare @sDateEffetGarantie varchar (10)
Declare @sCivLivraison varchar (20)
Declare @sPrenomLivraison varchar (100)
Declare @sNomLivraison varchar (100)
Declare @sAdresse1Livraison varchar (100)
Declare @sAdresse2Livraison varchar (100)
Declare @sAdresseCpltLivraison varchar (35)
Declare @sCpVilleLivraison varchar (100)


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
		   @sIdInter = i.id_i,
		   @sNotTelInterAssure = i.num_teld

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
				@sIdInter = i.id_i,
				@sNotTelInterAssure = i.num_teld

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
			From SIMPA2_PRO.sysadm.w_sin s
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
		   @sNature = Convert ( varchar (10), s.id_nat_sin ),
		   @sLibNature = Upper (Left ( SIMPA2_PRO.sysadm.FN_CODE_NUM ( s.id_nat_sin, '+NS' ), 1 )) + Lower ( Right ( SIMPA2_PRO.sysadm.FN_CODE_NUM ( s.id_nat_sin, '+NS' ), len (SIMPA2_PRO.sysadm.FN_CODE_NUM ( s.id_nat_sin, '+NS' ))-1 )),
		   @sDateDeSurvenanceSinistre = convert ( VarChar ( 10 ), s.dte_surv, 23 ),
		   @sHeureDeSurvenanceSinistre =  nullif (Convert ( VarChar (5), s.dte_surv, 108 ), '00:00'),
		   @sNoAdhesion  = 
			Case (Select cod_adh From SIMPA2_PRO.sysadm.produit p Where p.id_prod = s.id_prod ) 
				When '3' Then lTrim ( rtrim ( s.id_adh ))
				Else (
					Select convert ( VarChar ( 5 ), p.cod_prod_dms ) + '-' + convert ( varchar ( 5), s.id_ets ) + '-' + lTrim ( rTrim ( s.id_adh )) + '-' + Convert ( varchar (2), s.id_sdos )
					From SIMPA2_PRO.sysadm.produit p
					Where p.id_prod = s.id_prod 
					)
			End,
		   @sAssureur = SIMPA2_PRO.sysadm.FN_LIB_CIE_V02 ( @dcIdSin, 'P' ), -- [MCO602_PNEU]
  		   @sDateConnaissanceSinistre = Convert ( VarChar ( 10 ), s.dte_surv, 23 ), -- [MIG1_COUR_EMAILING] Nathalie dit de mettre la date de surv
		   @sDateFinGarantie = convert ( VarChar ( 10 ), s.dte_fin_gti, 23 ),-- [MIG1_COUR_EMAILING]
		   @sDateEffetGarantie = 
				Case When Exists ( 
						Select Top 1 1 
						From SIMPA2_PRO.sysadm.det_pro dp
						Where dp.id_prod = s.id_prod
						And dp.id_code_dp = 85 
						) -- Gestion de PGC donc...
					 Then IsNull ( Convert ( Varchar ( 10), DATEADD ( month, Convert ( Integer, SIMPA2_PRO.sysadm.FN_GET_DIV_SIN (@adcIdSin, 'duree_gti_orig', 'P', 'RETOUR=CODE' )), s.dte_adh ), 23 ), '' )
					 Else ''
				End -- [MIG1_COUR_EMAILING] 
	
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
			   @sNature = Convert ( varchar (10), s.id_natsin ),
			   @sLibNature = Upper (Left ( SIMPA2_PRO.sysadm.FN_CODE_NUM ( s.id_natsin, '+NS' ), 1 )) + Lower ( Right ( SIMPA2_PRO.sysadm.FN_CODE_NUM ( s.id_natsin, '+NS' ), len (SIMPA2_PRO.sysadm.FN_CODE_NUM ( s.id_natsin, '+NS' ))-1 )),
			   @sDateDeSurvenanceSinistre = Convert ( VarChar ( 10 ), s.dte_surv, 23 ),
			   @sHeureDeSurvenanceSinistre =  nullif (Convert ( VarChar (5), s.dte_surv, 108 ), '00:00'),
			   @sNoAdhesion  = 
				Case (Select cod_adh From SIMPA2_PRO.sysadm.produit p Where p.id_prod = s.id_prod ) 
					When '3' Then lTrim ( rtrim ( s.id_adh ))
					Else (
						Select convert ( VarChar ( 5 ), p.cod_prod_dms ) + '-' + convert ( varchar ( 5), s.id_ets ) + '-' + lTrim ( rTrim ( s.id_adh )) + '-' + Convert ( varchar (2), s.id_sdos )
						From SIMPA2_PRO.sysadm.produit p
						Where p.id_prod = s.id_prod 
						) 
				End,
			   @sAssureur = SIMPA2_PRO.sysadm.FN_LIB_CIE_V02 ( @dcIdSin, 'W' ), -- [MCO602_PNEU]
  			   @sDateConnaissanceSinistre = Convert ( VarChar ( 10 ), s.dte_surv, 23 ), -- [MIG1_COUR_EMAILING] Nathalie dit de mettre la date de surv
			   @sDateFinGarantie = convert ( VarChar ( 10 ), s.dte_fin_gti, 23 ),-- [MIG1_COUR_EMAILING]
			   @sDateEffetGarantie = 
					Case When Exists ( 
							Select Top 1 1 
							From SIMPA2_PRO.sysadm.det_pro dp
							Where dp.id_prod = s.id_prod
							And dp.id_code_dp = 85 
							) -- Gestion de PGC donc...
							Then IsNull ( Convert ( Varchar ( 10), DATEADD ( month, Convert ( Integer, SIMPA2_PRO.sysadm.FN_GET_DIV_SIN (@adcIdSin, 'duree_gti_orig', 'W', 'RETOUR=CODE' )), s.dte_adh ), 23 ), '' )
						 Else ''
					End -- [MIG1_COUR_EMAILING] 

		From SIMPA2_PRO.sysadm.w_sin s
		Where id_sin = @adcIdSin
	 End 

    -- *************************************
	-- ** Données liées au garantie       **
    -- *************************************
	-- [MCO602_PNEU]
	Select Top 1 
		   @sCodeGarantie = Convert ( varchar (50), g.id_gti ),
	       @sGarantie = ( Select Upper ( lTrim ( rTrim ( cg.lib_gti))) From SIMPA2_PRO.sysadm.code_garantie cg Where cg.id_prod = s.id_prod and cg.id_gti = g.id_gti )
	From SIMPA2_PRO.sysadm.gar_sin g,
		 SIMPA2_PRO.sysadm.sinistre s
	Where s.id_sin = @adcIdSin
	And g.id_sin = s.id_sin

	If @@RowCount <= 0
	 Begin 
		Select Top 1 
			   @sCodeGarantie = Convert ( varchar (50), g.id_gti ),
		       @sGarantie = ( Select Upper ( lTrim ( rTrim ( cg.lib_gti))) From SIMPA2_PRO.sysadm.code_garantie cg Where cg.id_prod = s.id_prod and cg.id_gti = g.id_gti )
		From SIMPA2_PRO.sysadm.w_gar_sin g,
			 SIMPA2_PRO.sysadm.w_sin s
		Where s.id_sin = @adcIdSin
		And g.id_sin = s.id_sin
	 End 

	-- ********************************************************
	-- ** Données liées à la première prestation si présente **
    -- ********************************************************
	Select 	@sCivLivraison = Case c.adr_cod_civ When '5' Then 'Messieurs' Else SIMPA2_PRO.sysadm.FN_CODE_NUM(Convert ( integer, c.adr_cod_civ) ,'-CI') End,
			@sPrenomLivraison = c.adr_prenom,
			@sNomLivraison  = c.adr_nom,
			@sAdresse1Livraison = c.adr_livr1,
			@sAdresse2Livraison = c.adr_livr2,
			@sAdresseCpltLivraison = c.adr_livr_cpl,
			@sCpVilleLivraison = c.adr_cp + ' ' + adr_ville

	From SIMPA2_PRO.sysadm.commande c
	Where c.id_sin = @adcIdSin
	And   c.id_seq = 1

	If @@RowCount <= 0
	 Begin 
		Select 	@sCivLivraison = Case c.adr_cod_civ When '5' Then 'Messieurs' Else SIMPA2_PRO.sysadm.FN_CODE_NUM(Convert ( integer, c.adr_cod_civ) ,'-CI') End,
				@sPrenomLivraison = c.adr_prenom,
				@sNomLivraison  = c.adr_nom,
				@sAdresse1Livraison = c.adr_livr1,
				@sAdresse2Livraison = c.adr_livr2,
				@sAdresseCpltLivraison = c.adr_livr_cpl,
				@sCpVilleLivraison = c.adr_cp + ' ' + adr_ville

		From SIMPA2_PRO.sysadm.w_commande c
		Where c.id_sin = @adcIdSin
		And   c.id_seq = 1
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
			@sEmailProduit = (Select sysadm.FN_CLE_VAL ( 'ADR_MAIL_PROD', RTRIM ( dp.val_car ) + rtrim ( dp.val_car2), ';' ) From SIMPA2_PRO.sysadm.det_pro dp Where dp.id_prod = p.id_prod And dp.id_code_dp = 136 ),
			@sURLextranet = (Select sysadm.FN_CLE_VAL ( 'URL_EXTRANET', RTRIM ( dp.val_car ) + rtrim ( dp.val_car2), ';' ) From SIMPA2_PRO.sysadm.det_pro dp Where dp.id_prod = p.id_prod And dp.id_code_dp = 391 ) -- [MIG1_COUR_EMAILING]

	From SIMPA2_PRO.sysadm.produit p

	Where p.id_prod = @dcIdProd 

	-- *************************************
	-- ** Données liées assureur/police   **
    -- *************************************
	-- Select @sAssureur = SIMPA2_PRO.sysadm.FN_LIB_CIE ( @dcIdSin )  Reporter plus haut car dépendant de W/P
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
		   @sIdInter = i.id_i,
		   @sNotTelInterAssure = i.num_teld

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
				@sIdInter = i.id_i,
				@sNotTelInterAssure = i.num_teld

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
			From SIMPA2_TRT.sysadm.w_sin s
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
		   @sNature = Convert ( varchar (10), s.id_natsin ),
		   @sLibNature = Upper (Left ( SIMPA2_TRT.sysadm.FN_CODE_NUM ( s.id_natsin, '+NS' ), 1 )) + Lower ( Right ( SIMPA2_TRT.sysadm.FN_CODE_NUM ( s.id_natsin, '+NS' ), len (SIMPA2_TRT.sysadm.FN_CODE_NUM ( s.id_natsin, '+NS' ))-1 )),
		   @sDateDeSurvenanceSinistre = convert ( VarChar ( 10 ), s.dte_surv, 23 ),
		   @sHeureDeSurvenanceSinistre =  nullif (Convert ( VarChar (5), s.dte_surv, 108 ), '00:00'),
		   @sNoAdhesion  = 
			Case (Select cod_adh From SIMPA2_TRT.sysadm.produit p Where p.id_prod = s.id_prod ) 
				When '3' Then lTrim ( rtrim ( s.id_adh ))
				Else (
					Select convert ( VarChar ( 5 ), p.cod_prod_dms ) + '-' + convert ( varchar ( 5), s.id_ets ) + '-' + lTrim ( rTrim ( s.id_adh )) + '-' + Convert ( varchar (2), s.id_sdos )
					From SIMPA2_TRT.sysadm.produit p
					Where p.id_prod = s.id_prod 
					) 
			End,
		   @sAssureur = SIMPA2_TRT.sysadm.FN_LIB_CIE_V02 ( @dcIdSin, 'P' ), -- [MCO602_PNEU]
  		   @sDateConnaissanceSinistre = Convert ( VarChar ( 10 ), s.dte_surv, 23 ), -- [MIG1_COUR_EMAILING] Nathalie dit de mettre la date de surv
		   @sDateFinGarantie = convert ( VarChar ( 10 ), s.dte_fin_gti, 23 ),-- [MIG1_COUR_EMAILING]
		   @sDateEffetGarantie = 
				Case When Exists ( 
						Select Top 1 1 
						From SIMPA2_TRT.sysadm.det_pro dp
						Where dp.id_prod = s.id_prod
						And dp.id_code_dp = 85 
						) -- Gestion de PGC donc...
					 Then IsNull ( Convert ( Varchar ( 10), DATEADD ( month, Convert ( Integer, SIMPA2_TRT.sysadm.FN_GET_DIV_SIN (@adcIdSin, 'duree_gti_orig', 'P', 'RETOUR=CODE' )), s.dte_adh ), 23 ), '' )
					 Else ''
				End -- [MIG1_COUR_EMAILING] 



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
			   @sNature = Convert ( varchar (10), s.id_natsin ),
			   @sLibNature = Upper (Left ( SIMPA2_TRT.sysadm.FN_CODE_NUM ( s.id_natsin, '+NS' ), 1 )) + Lower ( Right ( SIMPA2_TRT.sysadm.FN_CODE_NUM ( s.id_natsin, '+NS' ), len (SIMPA2_TRT.sysadm.FN_CODE_NUM ( s.id_natsin, '+NS' ))-1 )),
			   @sDateDeSurvenanceSinistre = Convert ( VarChar ( 10 ), s.dte_surv, 23 ),
			   @sHeureDeSurvenanceSinistre =  nullif (Convert ( VarChar (5), s.dte_surv, 108 ), '00:00'),
			   @sNoAdhesion  = 
				Case (Select cod_adh From SIMPA2_TRT.sysadm.produit p Where p.id_prod = s.id_prod ) 
					When '3' Then lTrim ( rtrim ( s.id_adh ))
					Else (
						Select convert ( VarChar ( 5 ), p.cod_prod_dms ) + '-' + convert ( varchar ( 5), s.id_ets ) + '-' + lTrim ( rTrim ( s.id_adh )) + '-' + Convert ( varchar (2), s.id_sdos )
						From SIMPA2_TRT.sysadm.produit p
						Where p.id_prod = s.id_prod 
						) 
				End,
			   @sAssureur = SIMPA2_TRT.sysadm.FN_LIB_CIE_V02 ( @dcIdSin, 'W' ), -- [MCO602_PNEU]
  			   @sDateConnaissanceSinistre = Convert ( VarChar ( 10 ), s.dte_surv, 23 ), -- [MIG1_COUR_EMAILING] Nathalie dit de mettre la date de surv
			   @sDateFinGarantie = convert ( VarChar ( 10 ), s.dte_fin_gti, 23 ),-- [MIG1_COUR_EMAILING]
			   @sDateEffetGarantie = 
					Case When Exists ( 
							Select Top 1 1 
							From SIMPA2_TRT.sysadm.det_pro dp
							Where dp.id_prod = s.id_prod
							And dp.id_code_dp = 85 
							) -- Gestion de PGC donc...
						 Then IsNull ( Convert ( Varchar ( 10), DATEADD ( month, Convert ( Integer, SIMPA2_TRT.sysadm.FN_GET_DIV_SIN (@adcIdSin, 'duree_gti_orig', 'W', 'RETOUR=CODE' )), s.dte_adh ), 23 ), '' )
						 Else ''
					End -- [MIG1_COUR_EMAILING] 


		From SIMPA2_TRT.sysadm.w_sin s
		Where id_sin = @adcIdSin
	 End 

    -- *************************************
	-- ** Données liées au garantie       **
    -- *************************************
	-- [MCO602_PNEU]
	Select Top 1 
		   @sCodeGarantie = Convert ( varchar (50), g.id_gti ),
	       @sGarantie = ( Select Upper ( lTrim ( rTrim ( cg.lib_gti))) From SIMPA2_TRT.sysadm.code_garantie cg Where cg.id_prod = s.id_prod and cg.id_gti = g.id_gti )
	From SIMPA2_TRT.sysadm.gar_sin g,
		 SIMPA2_TRT.sysadm.sinistre s
	Where s.id_sin = @adcIdSin
	And g.id_sin = s.id_sin

	If @@RowCount <= 0
	 Begin 
		Select Top 1 
			   @sCodeGarantie = Convert ( varchar (50), g.id_gti ),
		       @sGarantie = ( Select Upper ( lTrim ( rTrim ( cg.lib_gti))) From SIMPA2_TRT.sysadm.code_garantie cg Where cg.id_prod = s.id_prod and cg.id_gti = g.id_gti )
		From SIMPA2_TRT.sysadm.w_gar_sin g,
			 SIMPA2_TRT.sysadm.w_sin s
		Where s.id_sin = @adcIdSin
		And g.id_sin = s.id_sin
	 End 

	-- ********************************************************
	-- ** Données liées à la première prestation si présente **
    -- ********************************************************
	Select 	@sCivLivraison = Case c.adr_cod_civ When '5' Then 'Messieurs' Else SIMPA2_TRT.sysadm.FN_CODE_NUM(Convert ( integer, c.adr_cod_civ) ,'-CI') End,
			@sPrenomLivraison = c.adr_prenom,
			@sNomLivraison  = c.adr_nom,
			@sAdresse1Livraison = c.adr_livr1,
			@sAdresse2Livraison = c.adr_livr2,
			@sAdresseCpltLivraison = c.adr_livr_cpl,
			@sCpVilleLivraison = c.adr_cp + ' ' + adr_ville

	From SIMPA2_TRT.sysadm.commande c
	Where c.id_sin = @adcIdSin
	And   c.id_seq = 1

	If @@RowCount <= 0
	 Begin 
		Select 	@sCivLivraison = Case c.adr_cod_civ When '5' Then 'Messieurs' Else SIMPA2_TRT.sysadm.FN_CODE_NUM(Convert ( integer, c.adr_cod_civ) ,'-CI') End,
				@sPrenomLivraison = c.adr_prenom,
				@sNomLivraison  = c.adr_nom,
				@sAdresse1Livraison = c.adr_livr1,
				@sAdresse2Livraison = c.adr_livr2,
				@sAdresseCpltLivraison = c.adr_livr_cpl,
				@sCpVilleLivraison = c.adr_cp + ' ' + adr_ville

		From SIMPA2_TRT.sysadm.w_commande c
		Where c.id_sin = @adcIdSin
		And   c.id_seq = 1
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
			@sEmailProduit = (Select sysadm.FN_CLE_VAL ( 'ADR_MAIL_PROD', RTRIM ( dp.val_car ) + rtrim ( dp.val_car2), ';' ) From SIMPA2_TRT.sysadm.det_pro dp Where dp.id_prod = p.id_prod And dp.id_code_dp = 136 ),
			@sURLextranet = (Select sysadm.FN_CLE_VAL ( 'URL_EXTRANET', RTRIM ( dp.val_car ) + rtrim ( dp.val_car2), ';' ) From SIMPA2_TRT.sysadm.det_pro dp Where dp.id_prod = p.id_prod And dp.id_code_dp = 391 ) -- [MIG1_COUR_EMAILING]
	From SIMPA2_TRT.sysadm.produit p

	Where p.id_prod = @dcIdProd 

	-- *************************************
	-- ** Données liées assureur/police   **
    -- *************************************
	-- Select @sAssureur = SIMPA2_TRT.sysadm.FN_LIB_CIE ( @dcIdSin )  Reporter plus haut car dépendant de W/P
	Select @sNoPolice = SIMPA2_TRT.sysadm.FN_GET_LIB_POLICE_V01(@dcIdSin,@dcIdProd, @dcIdRev,-1,NULL) 
	If @sNoPolice is null or lTrim ( rTrim ( @sNoPolice )) = '' Select @sNoPolice = SIMPA2_TRT.sysadm.FN_LIB_POLICE ( @dcIdSin )

END	

-- **************************************
-- ** Retouches de certaines variables ** 
-- **************************************

Set @sNomLivraison = Concat ( rTrim ( lTrim (  @sCivLivraison )), ' ', rTrim ( lTrim ( @sPrenomLivraison )), ' ', rTrim ( lTrim ( @sNomLivraison )))
Set @sAdresse2Livraison = Concat ( rTrim ( lTrim (  @sAdresse2Livraison )), ' ' , rTrim ( lTrim (  @sAdresseCpltLivraison )))

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
	id_inter = @sIdInter,
	no_ligne_assuree = @sNoLigneAssuree,
	no_adhesion = @sNoAdhesion,
	date_de_survenance_sinistre = @sDateDeSurvenanceSinistre,
	heure_de_survenance_sinistre = @sHeureDeSurvenanceSinistre,
	no_tel_inter_assure = @sNotTelInterAssure,
	lib_nature = @sLibNature ,
	code_garantie = @sCodeGarantie,  -- [MCO602_PNEU]
	garantie = @sGarantie,  -- [MCO602_PNEU]
	url_extranet = @sURLextranet, -- [MIG1_COUR_EMAILING]
  	date_connaissance_sinistre = @sDateConnaissanceSinistre, -- [MIG1_COUR_EMAILING] 
	date_fin_garantie = @sDateFinGarantie,-- [MIG1_COUR_EMAILING]
	date_effet_garantie = @sDateEffetGarantie, -- [MIG1_COUR_EMAILING] 
	appli_sin_prov = 'SIMPA2', -- [MIG1_COUR_EMAILING]
	civ_livraison = @sCivLivraison,  -- [MIG1_COUR_EMAILING]
	prenom_livraison = @sPrenomLivraison, -- [MIG1_COUR_EMAILING]
	nom_livraison = @sNomLivraison, -- [MIG1_COUR_EMAILING]
	adresse1_livraison = @sAdresse1Livraison, -- [MIG1_COUR_EMAILING]
	adresse2_livraison = @sAdresse2Livraison, -- [MIG1_COUR_EMAILING]
	cp_ville_livraison = @sCpVilleLivraison -- [MIG1_COUR_EMAILING]


Where id_xml = @aiIdXml


Go


--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_PEGASE
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :        
-- Commentaires         :       Met à jour sur l'enregistrement id_xml donnée, les valeurs par défaut lié au sinistre et à l'interlocuteur
-- References           :       POUR PEGASE
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF		06/06/2025   [RS6130] Divers ajout
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_PEGASE' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_PEGASE
GO

CREATE procedure sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_PEGASE
	@adcIdSin integer,
	@adcIdInter integer,
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

Declare @sNoAdhesion varchar (50)
Declare @sDateDeSurvenanceSinistre varchar (35)
Declare @sHeureDeSurvenanceSinistre varchar (20)
Declare @sNotTelInterAssure varchar (35)
Declare @sLibNature varchar (35)
Declare @sCodeGarantie varchar (50)
Declare @sGarantie varchar (50)
Declare @sURLextranet varchar (100)
Declare @sDateConnaissanceSinistre varchar (10)
Declare @sDateFinGarantie varchar (10)
Declare @sDateEffetGarantie varchar (10)
Declare @sCivLivraison varchar (20)
Declare @sPrenomLivraison varchar (100)
Declare @sNomLivraison varchar (100)
Declare @sAdresse1Livraison varchar (100)
Declare @sAdresse2Livraison varchar (100)
Declare @sAdresseCpltLivraison varchar (35)
Declare @sCpVilleLivraison varchar (100)


IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
    -- *************************************
	-- ** PRODUCTION                      **
    -- *************************************

    -- *************************************
	-- ** Données liées à l'interlocuteur **
    -- *************************************

	Select @sCodCivCourt = Case When i.cod_civ in ( 4, 5 ) Then 'Messieurs' Else PEGASE_PRO.sysadm.FN_CODE_CAR(i.cod_civ,'-CI') End,
		   @sCodCivLong = Case When i.cod_civ in ( 4, 5 ) Then 'Messieurs' Else PEGASE_PRO.sysadm.FN_CODE_CAR(i.cod_civ,'-CL') End,
		   @sNom = i.nom,
		   @sPrenom = i.nom,
		   @sCodInter = i.cod_inter,
		   @sAdresse1 = i.adr_1,
		   @sAdresse2 = i.adr_2,
		   @sCodePostal = i.adr_cp,
		   @sVille = i.adr_ville,
		   @sAdrMail = i.adr_mel,
		   @sIdInter = i.id_inter

	From PEGASE_PRO.sysadm.inter i
	Where id_sin = @adcIdSin
	And id_inter = @adcIdInter

	If @@RowCount <= 0
	 Begin 
		Select	@sCodCivCourt = Case When i.cod_civ in ( 4, 5 ) Then 'Messieurs' Else PEGASE_PRO.sysadm.FN_CODE_CAR(i.cod_civ,'-CI') End,
				@sCodCivLong = Case When i.cod_civ in ( 4, 5 ) Then 'Messieurs' Else PEGASE_PRO.sysadm.FN_CODE_CAR(i.cod_civ,'-CL') End,
				@sNom = i.nom,
				@sPrenom = i.nom,
				@sCodInter = i.cod_inter,
				@sAdresse1 = i.adr_1,
				@sAdresse2 = i.adr_2,
				@sCodePostal = i.adr_cp,
				@sVille = i.adr_ville,
				@sAdrMail = i.adr_mel,
				@sIdInter = i.id_inter

		From PEGASE_PRO.sysadm.w_inter i
		Where id_sin = @adcIdSin
		And id_inter = @adcIdInter
	 End 

	-- Traitement particulier pour l'assuré pour récupérer le nom et prom
    If @sCodInter = 'A'
	  Begin
		Select @sNom = ps.nom,
			   @sPrenom = ps.prenom
		From PEGASE_PRO.sysadm.sinistre s,
			 PEGASE_PRO.sysadm.personne ps 
		Where s.id_sin = @adcIdSin
		And  ps.id_ordre = s.id_ordre

/*
		If @@ROWCOUNT <= 0 
		  Begin
			Select @sNom = s.nom,
				   @sPrenom = s.prenom
			From PEGASE_PRO.sysadm.w_sin s
			Where s.id_sin = @adcIdSin
		 End */
	  End 


    -- *************************************
	-- ** Données liées au sinistre       **
    -- *************************************
	Select @dcIdSin = s.id_sin,
		   @dcIdRev = s.id_rev,
		   @dcIdProd = s.id_prod,
		   @sNoLigneAssuree = '',
		   @sCodeOperateur = s.maj_par,
		   @sNoDossierSinistre = Convert ( varchar (10), s.id_sin ),
		   @sMarqPort = '',
		   @sModlPort = '',
		   @DateDeDeclaration = convert ( VarChar ( 10 ), s.dte_dec, 23 ),
		   @sIMEI = '',
		   @sMajPar = s.maj_par,
		   @sNature = Convert ( varchar (10), s.id_nat_sin ),
		   @sLibNature = Upper (Left ( PEGASE_PRO.sysadm.FN_CODE_NUM ( s.id_nat_sin, '+NS' ), 1 )) + Lower ( Right ( PEGASE_PRO.sysadm.FN_CODE_NUM ( s.id_nat_sin, '+NS' ), len (PEGASE_PRO.sysadm.FN_CODE_NUM ( s.id_nat_sin, '+NS' ))-1 )),
		   @sDateDeSurvenanceSinistre = convert ( VarChar ( 10 ), s.dte_surv, 23 ),
		   @sHeureDeSurvenanceSinistre =  nullif (Convert ( VarChar (5), s.dte_surv, 108 ), '00:00'),
		   @sNoAdhesion  = 
					Case 
						When SIMPA2_PRO.sysadm.FN_CLE_NUMERIQUE ( 'PI085') > 0 Then 
							(
							Select Top 1 RIGHT('00000' + IsNull ( CONVERT(varchar(5), Convert ( integer, dp.val_calc) ), ''),5)   -- [PI085] passage de 3 à 5
							From PEGASE_PRO.sysadm.det_pro dp
							Where dp.id_calc = 6
							And   dp.id_prod = p.id_prod
							) + '-' + convert ( varchar ( 5), s.id_ets ) + '-' + lTrim ( rTrim ( s.id_adh )) + '-' + Convert ( varchar (2), s.id_sdos )
						Else 
							(
							Select Top 1 RIGHT('000' + IsNull ( CONVERT(varchar(5), Convert ( integer, dp.val_calc) ), ''),3) -- [PI085] On laisse ainsi mail de P. Fauvel le 25/05/2020 à 09h16 archivé dans le projet.
							From PEGASE_PRO.sysadm.det_pro dp
							Where dp.id_calc = 6
							And   dp.id_prod = p.id_prod
							) + '-' + convert ( varchar ( 5), s.id_ets ) + '-' + lTrim ( rTrim ( s.id_adh )) + '-' + Convert ( varchar (2), s.id_sdos )
					End,
		   @sAssureur = PEGASE_PRO.sysadm.FN_LIB_CIE_V02 ( @dcIdSin, 'P' ), 
		   @sNoPolice = PEGASE_PRO.sysadm.FN_LIB_POLICE_V02 ( @dcIdSin, 'P' ), 
  		   @sDateConnaissanceSinistre = Convert ( VarChar ( 10 ), s.dte_surv, 23 ), -- [MIG1_COUR_EMAILING] Nathalie dit de mettre la date de surv
		   @sDateFinGarantie = convert ( VarChar ( 10 ), s.dte_fin_gti, 23 ),-- [MIG1_COUR_EMAILING]
		   @sDateEffetGarantie = ''

	From PEGASE_PRO.sysadm.sinistre s
	Where id_sin = @adcIdSin

	If @@RowCount <= 0
	 Begin 
		Select @dcIdSin = s.id_sin,
			   @dcIdRev = s.id_rev,
			   @dcIdProd = s.id_prod,
			   @sNoLigneAssuree = '',
			   @sCodeOperateur = s.maj_par,
			   @sNoDossierSinistre = Convert ( varchar (10), s.id_sin ),
			   @sMarqPort = '',
			   @sModlPort = '',
			   @DateDeDeclaration = convert ( VarChar ( 10 ), s.dte_dec, 23 ),
			   @sIMEI = '',
			   @sMajPar = s.maj_par,
			   @sNature = Convert ( varchar (10), s.id_nat_sin ),
			   @sLibNature = Upper (Left ( PEGASE_PRO.sysadm.FN_CODE_NUM ( s.id_nat_sin, '+NS' ), 1 )) + Lower ( Right ( PEGASE_PRO.sysadm.FN_CODE_NUM ( s.id_nat_sin, '+NS' ), len (PEGASE_PRO.sysadm.FN_CODE_NUM ( s.id_nat_sin, '+NS' ))-1 )),
			   @sDateDeSurvenanceSinistre = convert ( VarChar ( 10 ), s.dte_surv, 23 ),
			   @sHeureDeSurvenanceSinistre =  nullif (Convert ( VarChar (5), s.dte_surv, 108 ), '00:00'),
			   @sNoAdhesion  = 
						Case 
							When SIMPA2_PRO.sysadm.FN_CLE_NUMERIQUE ( 'PI085') > 0 Then 
								(
								Select Top 1 RIGHT('00000' + IsNull ( CONVERT(varchar(5), Convert ( integer, dp.val_calc) ), ''),5)   -- [PI085] passage de 3 à 5
								From PEGASE_PRO.sysadm.det_pro dp
								Where dp.id_calc = 6
								And   dp.id_prod = p.id_prod
								) + '-' + convert ( varchar ( 5), s.id_ets ) + '-' + lTrim ( rTrim ( s.id_adh )) + '-' + Convert ( varchar (2), s.id_sdos )
							Else 
								(
								Select Top 1 RIGHT('000' + IsNull ( CONVERT(varchar(5), Convert ( integer, dp.val_calc) ), ''),3) -- [PI085] On laisse ainsi mail de P. Fauvel le 25/05/2020 à 09h16 archivé dans le projet.
								From PEGASE_PRO.sysadm.det_pro dp
								Where dp.id_calc = 6
								And   dp.id_prod = p.id_prod
								) + '-' + convert ( varchar ( 5), s.id_ets ) + '-' + lTrim ( rTrim ( s.id_adh )) + '-' + Convert ( varchar (2), s.id_sdos )
						End,
			   @sAssureur = PEGASE_PRO.sysadm.FN_LIB_CIE_V02 ( @dcIdSin, 'W' ), 
			   @sNoPolice = PEGASE_PRO.sysadm.FN_LIB_POLICE_V02 ( @dcIdSin, 'W' ), 
  			   @sDateConnaissanceSinistre = Convert ( VarChar ( 10 ), s.dte_surv, 23 ), -- [MIG1_COUR_EMAILING] Nathalie dit de mettre la date de surv
			   @sDateFinGarantie = convert ( VarChar ( 10 ), s.dte_fin_gti, 23 ),-- [MIG1_COUR_EMAILING]
			   @sDateEffetGarantie = ''
		From PEGASE_PRO.sysadm.w_sin s
		Where id_sin = @adcIdSin
	 End 

    -- *************************************
	-- ** Données liées au garantie       **
    -- *************************************
	Select Top 1 
		   @sCodeGarantie = Convert ( varchar (50), g.id_gti ),
	       @sGarantie = ( Select Upper ( lTrim ( rTrim ( cg.lib_gti))) From PEGASE_PRO.sysadm.code_garantie cg Where cg.id_prod = s.id_prod and cg.id_gti = g.id_gti )
	From PEGASE_PRO.sysadm.gar_sin g,
		 PEGASE_PRO.sysadm.sinistre s
	Where s.id_sin = @adcIdSin
	And g.id_sin = s.id_sin

	If @@RowCount <= 0
	 Begin 
		Select Top 1 
			   @sCodeGarantie = Convert ( varchar (50), g.id_gti ),
		       @sGarantie = ( Select Upper ( lTrim ( rTrim ( cg.lib_gti))) From PEGASE_PRO.sysadm.code_garantie cg Where cg.id_prod = s.id_prod and cg.id_gti = g.id_gti )
		From PEGASE_PRO.sysadm.w_gar_sin g,
			 PEGASE_PRO.sysadm.w_sin s
		Where s.id_sin = @adcIdSin
		And g.id_sin = s.id_sin
	 End 

    -- *************************************
	-- ** Données liées au produit        **
    -- *************************************
	Select	@sNoTelSpb = p.num_tel,
			@sNoTelFax = p.num_fax,
			@sCodeProduitSinistre =  Convert ( varchar ( 10), p.id_prod ),
			@sNomProduit = p.lib_long,
			@sNomProduitCpl = p.lib_long,
			@sLibOptProduit = '',
			@sCoutTelephonique = '',
			@sCodeProduit = 
					Case 
						When SIMPA2_PRO.sysadm.FN_CLE_NUMERIQUE ( 'PI085') > 0 Then 
							(
							Select Top 1 RIGHT('00000' + IsNull ( CONVERT(varchar(5), Convert ( integer, dp.val_calc) ), ''),5)   -- [PI085] passage de 3 à 5
							From PEGASE_PRO.sysadm.det_pro dp
							Where dp.id_calc = 6
							And   dp.id_prod = p.id_prod
							)
						Else 
							(
							Select Top 1 RIGHT('000' + IsNull ( CONVERT(varchar(5), Convert ( integer, dp.val_calc) ), ''),3) -- [PI085] On laisse ainsi mail de P. Fauvel le 25/05/2020 à 09h16 archivé dans le projet.
							From PEGASE_PRO.sysadm.det_pro dp
							Where dp.id_calc = 6
							And   dp.id_prod = p.id_prod
							)
					End,
			@sEmailProduit = ( Select c.lib_code 
							   From PEGASE_PRO.sysadm.code c,
									PEGASE_PRO.sysadm.det_pro dp
							   Where dp.id_prod = p.id_prod
							   And   dp.id_calc = 6
							   And   c.id_code = dp.val_calc 
							   And   c.id_typ_code = '+MP' ),
			@sURLextranet = ''

	From PEGASE_PRO.sysadm.produit p

	Where p.id_prod = @dcIdProd 

END
ELSE
BEGIN

    -- *************************************
	-- ** SIMULATION                      **
    -- *************************************

    -- *************************************
	-- ** Données liées à l'interlocuteur **
    -- *************************************

	Select @sCodCivCourt = Case When i.cod_civ in ( 4, 5 ) Then 'Messieurs' Else PEGASE_TRT.sysadm.FN_CODE_CAR(i.cod_civ,'-CI') End,
		   @sCodCivLong = Case When i.cod_civ in ( 4, 5 ) Then 'Messieurs' Else PEGASE_TRT.sysadm.FN_CODE_CAR(i.cod_civ,'-CL') End,
		   @sNom = i.nom,
		   @sPrenom = i.nom,
		   @sCodInter = i.cod_inter,
		   @sAdresse1 = i.adr_1,
		   @sAdresse2 = i.adr_2,
		   @sCodePostal = i.adr_cp,
		   @sVille = i.adr_ville,
		   @sAdrMail = i.adr_mel,
		   @sIdInter = i.id_inter

	From PEGASE_TRT.sysadm.inter i
	Where id_sin = @adcIdSin
	And id_inter = @adcIdInter

	If @@RowCount <= 0
	 Begin 
		Select	@sCodCivCourt = Case When i.cod_civ in ( 4, 5 ) Then 'Messieurs' Else PEGASE_TRT.sysadm.FN_CODE_CAR(i.cod_civ,'-CI') End,
				@sCodCivLong = Case When i.cod_civ in ( 4, 5 ) Then 'Messieurs' Else PEGASE_TRT.sysadm.FN_CODE_CAR(i.cod_civ,'-CL') End,
				@sNom = i.nom,
				@sPrenom = i.nom,
				@sCodInter = i.cod_inter,
				@sAdresse1 = i.adr_1,
				@sAdresse2 = i.adr_2,
				@sCodePostal = i.adr_cp,
				@sVille = i.adr_ville,
				@sAdrMail = i.adr_mel,
				@sIdInter = i.id_inter

		From PEGASE_TRT.sysadm.w_inter i
		Where id_sin = @adcIdSin
		And id_inter = @adcIdInter
	 End 

	-- Traitement particulier pour l'assuré pour récupérer le nom et prom
    If @sCodInter = 'A'
	  Begin
		Select @sNom = ps.nom,
			   @sPrenom = ps.prenom
		From PEGASE_TRT.sysadm.sinistre s,
			 PEGASE_TRT.sysadm.personne ps 
		Where s.id_sin = @adcIdSin
		And  ps.id_ordre = s.id_ordre

/*
		If @@ROWCOUNT <= 0 
		  Begin
			Select @sNom = s.nom,
				   @sPrenom = s.prenom
			From PEGASE_TRT.sysadm.w_sin s
			Where s.id_sin = @adcIdSin
		 End */
	  End 


    -- *************************************
	-- ** Données liées au sinistre       **
    -- *************************************
	Select @dcIdSin = s.id_sin,
		   @dcIdRev = s.id_rev,
		   @dcIdProd = s.id_prod,
		   @sNoLigneAssuree = '',
		   @sCodeOperateur = s.maj_par,
		   @sNoDossierSinistre = Convert ( varchar (10), s.id_sin ),
		   @sMarqPort = '',
		   @sModlPort = '',
		   @DateDeDeclaration = convert ( VarChar ( 10 ), s.dte_dec, 23 ),
		   @sIMEI = '',
		   @sMajPar = s.maj_par,
		   @sNature = Convert ( varchar (10), s.id_nat_sin ),
		   @sLibNature = Upper (Left ( PEGASE_TRT.sysadm.FN_CODE_NUM ( s.id_nat_sin, '+NS' ), 1 )) + Lower ( Right ( PEGASE_TRT.sysadm.FN_CODE_NUM ( s.id_nat_sin, '+NS' ), len (PEGASE_TRT.sysadm.FN_CODE_NUM ( s.id_nat_sin, '+NS' ))-1 )),
		   @sDateDeSurvenanceSinistre = convert ( VarChar ( 10 ), s.dte_surv, 23 ),
		   @sHeureDeSurvenanceSinistre =  nullif (Convert ( VarChar (5), s.dte_surv, 108 ), '00:00'),
		   @sNoAdhesion  = 
					Case 
						When SIMPA2_TRT.sysadm.FN_CLE_NUMERIQUE ( 'PI085') > 0 Then 
							(
							Select Top 1 RIGHT('00000' + IsNull ( CONVERT(varchar(5), Convert ( integer, dp.val_calc) ), ''),5)   -- [PI085] passage de 3 à 5
							From PEGASE_TRT.sysadm.det_pro dp
							Where dp.id_calc = 6
							And   dp.id_prod = s.id_prod
							) + '-' + convert ( varchar ( 5), s.id_ets ) + '-' + lTrim ( rTrim ( s.id_adh )) + '-' + Convert ( varchar (2), s.id_sdos )
						Else 
							(
							Select Top 1 RIGHT('000' + IsNull ( CONVERT(varchar(5), Convert ( integer, dp.val_calc) ), ''),3) -- [PI085] On laisse ainsi mail de P. Fauvel le 25/05/2020 à 09h16 archivé dans le projet.
							From PEGASE_TRT.sysadm.det_pro dp
							Where dp.id_calc = 6
							And   dp.id_prod = s.id_prod
							) + '-' + convert ( varchar ( 5), s.id_ets ) + '-' + lTrim ( rTrim ( s.id_adh )) + '-' + Convert ( varchar (2), s.id_sdos )
					End,
		   @sAssureur = PEGASE_TRT.sysadm.FN_LIB_CIE_V02 ( @dcIdSin, 'P' ), 
		   @sNoPolice = PEGASE_TRT.sysadm.FN_LIB_POLICE_V02 ( @dcIdSin, 'P' ), 
  		   @sDateConnaissanceSinistre = Convert ( VarChar ( 10 ), s.dte_surv, 23 ), -- [MIG1_COUR_EMAILING] Nathalie dit de mettre la date de surv
		   @sDateFinGarantie = convert ( VarChar ( 10 ), s.dte_fin_gti, 23 ),-- [MIG1_COUR_EMAILING]
		   @sDateEffetGarantie = ''

	From PEGASE_TRT.sysadm.sinistre s
	Where id_sin = @adcIdSin

	If @@RowCount <= 0
	 Begin 
		Select @dcIdSin = s.id_sin,
			   @dcIdRev = s.id_rev,
			   @dcIdProd = s.id_prod,
			   @sNoLigneAssuree = '',
			   @sCodeOperateur = s.maj_par,
			   @sNoDossierSinistre = Convert ( varchar (10), s.id_sin ),
			   @sMarqPort = '',
			   @sModlPort = '',
			   @DateDeDeclaration = convert ( VarChar ( 10 ), s.dte_dec, 23 ),
			   @sIMEI = '',
			   @sMajPar = s.maj_par,
			   @sNature = Convert ( varchar (10), s.id_nat_sin ),
			   @sLibNature = Upper (Left ( PEGASE_TRT.sysadm.FN_CODE_NUM ( s.id_nat_sin, '+NS' ), 1 )) + Lower ( Right ( PEGASE_TRT.sysadm.FN_CODE_NUM ( s.id_nat_sin, '+NS' ), len (PEGASE_TRT.sysadm.FN_CODE_NUM ( s.id_nat_sin, '+NS' ))-1 )),
			   @sDateDeSurvenanceSinistre = convert ( VarChar ( 10 ), s.dte_surv, 23 ),
			   @sHeureDeSurvenanceSinistre =  nullif (Convert ( VarChar (5), s.dte_surv, 108 ), '00:00'),
			   @sNoAdhesion  = 
						Case 
							When SIMPA2_TRT.sysadm.FN_CLE_NUMERIQUE ( 'PI085') > 0 Then 
								(
								Select Top 1 RIGHT('00000' + IsNull ( CONVERT(varchar(5), Convert ( integer, dp.val_calc) ), ''),5)   -- [PI085] passage de 3 à 5
								From PEGASE_TRT.sysadm.det_pro dp
								Where dp.id_calc = 6
								And   dp.id_prod = s.id_prod
								) + '-' + convert ( varchar ( 5), s.id_ets ) + '-' + lTrim ( rTrim ( s.id_adh )) + '-' + Convert ( varchar (2), s.id_sdos )
							Else 
								(
								Select Top 1 RIGHT('000' + IsNull ( CONVERT(varchar(5), Convert ( integer, dp.val_calc) ), ''),3) -- [PI085] On laisse ainsi mail de P. Fauvel le 25/05/2020 à 09h16 archivé dans le projet.
								From PEGASE_TRT.sysadm.det_pro dp
								Where dp.id_calc = 6
								And   dp.id_prod = s.id_prod
								) + '-' + convert ( varchar ( 5), s.id_ets ) + '-' + lTrim ( rTrim ( s.id_adh )) + '-' + Convert ( varchar (2), s.id_sdos )
						End,
			   @sAssureur = PEGASE_TRT.sysadm.FN_LIB_CIE_V02 ( @dcIdSin, 'W' ), 
			   @sNoPolice = PEGASE_TRT.sysadm.FN_LIB_POLICE_V02 ( @dcIdSin, 'W' ), 
  			   @sDateConnaissanceSinistre = Convert ( VarChar ( 10 ), s.dte_surv, 23 ), -- [MIG1_COUR_EMAILING] Nathalie dit de mettre la date de surv
			   @sDateFinGarantie = convert ( VarChar ( 10 ), s.dte_fin_gti, 23 ),-- [MIG1_COUR_EMAILING]
			   @sDateEffetGarantie = ''
		From PEGASE_TRT.sysadm.w_sin s
		Where id_sin = @adcIdSin
	 End 

    -- *************************************
	-- ** Données liées au garantie       **
    -- *************************************
	Select Top 1 
		   @sCodeGarantie = Convert ( varchar (50), g.id_gti ),
	       @sGarantie = ( Select Upper ( lTrim ( rTrim ( cg.lib_gti))) From PEGASE_TRT.sysadm.code_garantie cg Where cg.id_prod = s.id_prod and cg.id_gti = g.id_gti )
	From PEGASE_TRT.sysadm.gar_sin g,
		 PEGASE_TRT.sysadm.sinistre s
	Where s.id_sin = @adcIdSin
	And g.id_sin = s.id_sin

	If @@RowCount <= 0
	 Begin 
		Select Top 1 
			   @sCodeGarantie = Convert ( varchar (50), g.id_gti ),
		       @sGarantie = ( Select Upper ( lTrim ( rTrim ( cg.lib_gti))) From PEGASE_TRT.sysadm.code_garantie cg Where cg.id_prod = s.id_prod and cg.id_gti = g.id_gti )
		From PEGASE_TRT.sysadm.w_gar_sin g,
			 PEGASE_TRT.sysadm.w_sin s
		Where s.id_sin = @adcIdSin
		And g.id_sin = s.id_sin
	 End 

    -- *************************************
	-- ** Données liées au produit        **
    -- *************************************
	Select	@sNoTelSpb = p.num_tel,
			@sNoTelFax = p.num_fax,
			@sCodeProduitSinistre =  Convert ( varchar ( 10), p.id_prod ),
			@sNomProduit = p.lib_long,
			@sNomProduitCpl = p.lib_long,
			@sLibOptProduit = '',
			@sCoutTelephonique = '',
			@sCodeProduit = 
					Case 
						When SIMPA2_TRT.sysadm.FN_CLE_NUMERIQUE ( 'PI085') > 0 Then 
							(
							Select Top 1 RIGHT('00000' + IsNull ( CONVERT(varchar(5), Convert ( integer, dp.val_calc) ), ''),5)   -- [PI085] passage de 3 à 5
							From PEGASE_TRT.sysadm.det_pro dp
							Where dp.id_calc = 6
							And   dp.id_prod = p.id_prod
							)
						Else 
							(
							Select Top 1 RIGHT('000' + IsNull ( CONVERT(varchar(5), Convert ( integer, dp.val_calc) ), ''),3) -- [PI085] On laisse ainsi mail de P. Fauvel le 25/05/2020 à 09h16 archivé dans le projet.
							From PEGASE_TRT.sysadm.det_pro dp
							Where dp.id_calc = 6
							And   dp.id_prod = p.id_prod
							)
					End,
			@sEmailProduit = ( Select c.lib_code 
							   From PEGASE_TRT.sysadm.code c,
									PEGASE_TRT.sysadm.det_pro dp
							   Where dp.id_prod = p.id_prod
							   And   dp.id_calc = 6
							   And   c.id_code = dp.val_calc 
							   And   c.id_typ_code = '+MP' ),
			@sURLextranet = ''

	From PEGASE_TRT.sysadm.produit p

	Where p.id_prod = @dcIdProd 

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
	id_inter = @sIdInter,
	no_ligne_assuree = @sNoLigneAssuree,
	no_adhesion = @sNoAdhesion,
	date_de_survenance_sinistre = @sDateDeSurvenanceSinistre,
	heure_de_survenance_sinistre = @sHeureDeSurvenanceSinistre,
	no_tel_inter_assure = @sNotTelInterAssure,
	lib_nature = @sLibNature ,
	code_garantie = @sCodeGarantie,  -- [MCO602_PNEU]
	garantie = @sGarantie,  -- [MCO602_PNEU]
	url_extranet = @sURLextranet, -- [MIG1_COUR_EMAILING]
  	date_connaissance_sinistre = @sDateConnaissanceSinistre, -- [MIG1_COUR_EMAILING] 
	date_fin_garantie = @sDateFinGarantie,-- [MIG1_COUR_EMAILING]
	date_effet_garantie = @sDateEffetGarantie, -- [MIG1_COUR_EMAILING] 
	appli_sin_prov = 'PEGASE', -- [MIG1_COUR_EMAILING]
	civ_livraison = @sCivLivraison,  -- [MIG1_COUR_EMAILING]
	prenom_livraison = @sPrenomLivraison, -- [MIG1_COUR_EMAILING]
	nom_livraison = @sNomLivraison, -- [MIG1_COUR_EMAILING]
	adresse1_livraison = @sAdresse1Livraison, -- [MIG1_COUR_EMAILING]
	adresse2_livraison = @sAdresse2Livraison, -- [MIG1_COUR_EMAILING]
	cp_ville_livraison = @sCpVilleLivraison -- [MIG1_COUR_EMAILING]


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

	-- Nettoyage des caractères gênant le format XML
	Set @sSql = 'Update sysadm.variable_xml_ksl_rs5045 Set ' + @sNomZone + '= Replace ( ' + @sNomZone + ', ''%'', '''' ) where id_xml = ' + convert ( VarChar ( 10), @iIdXml ) + ' and ' + @sNomZone + ' is not null '
	Execute (@sSql)
	Set @sSql = 'Update sysadm.variable_xml_ksl_rs5045 Set ' + @sNomZone + '= Replace ( ' + @sNomZone + ', ''&'', '''' ) where id_xml = ' + convert ( VarChar ( 10), @iIdXml ) + ' and ' + @sNomZone + ' is not null '
	Execute (@sSql)
	Set @sSql = 'Update sysadm.variable_xml_ksl_rs5045 Set ' + @sNomZone + '= Replace ( ' + @sNomZone + ', ''\'', '''' ) where id_xml = ' + convert ( VarChar ( 10), @iIdXml ) + ' and ' + @sNomZone + ' is not null '
	Execute (@sSql)
	Set @sSql = 'Update sysadm.variable_xml_ksl_rs5045 Set ' + @sNomZone + '= Replace ( ' + @sNomZone + ', ''"'', '''' ) where id_xml = ' + convert ( VarChar ( 10), @iIdXml ) + ' and ' + @sNomZone + ' is not null '
	Execute (@sSql)


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
-- JFF      18/09/2023   [RS5875_DIF_DIV_DET]
-- JFF      05/08/2024   [MCO602_PNEU]
-- JFF      19/12/2024   [MIG1_COUR_EMAILING]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE
GO

CREATE procedure sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE
	@iIdXml integer,
	@sCodeMaquette varchar ( 255 ), 
	@xmlResult varchar(max) OUTPUT
AS

Declare @sCanal Varchar ( 20 ) 
Declare @sMethodeKsl Varchar ( 20 ) 

-- Déterminer la méthode lié à la maquette KSL
Select @sMethodeKsl = ltrim ( rtrim ( cm.methode_ksl ))
From sysadm.code_maquette_ksl_rs5045 cm
Where cm.cod_maq = @sCodeMaquette

	If @sMethodeKsl in ( 'RS5045_MATPN', 'RS5045_MATPD', 'RS5045_MAILPUSH_KSL' ) 
	  Begin
		select @xmlResult=(
		select top 1 

			-- ci-dessous Section <Tech

			code_maquette as 'tech/@code_maquette',

			-- ci-dessous Section <Entete

			montant_debite as 'entete/@montant_debite',
			civilite_courte as 'entete/@civilite_courte',
			civilite_courte as 'entete/@civilite',
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
			'' as 'entete/@mail_exp', -- Sera armé plus loin pour toute appli par sysadm.PS_RS5045_I_MAIL_PUSH_KSL et sysadm.PS_S_SUBSTITUER_VARIABLE_XML
			app_marque as 'entete/@app_marque',
			app_modele as 'entete/@app_modele',
			adr_mail as 'entete/@email',
			'' as 'entete/@o2mnom',
			'' as 'entete/@o2madr1',
			'' as 'entete/@o2mcp',
			'' as 'entete/@o2mville',
			mail_subject as 'entete/@mail_subject',
			mail_body as 'entete/@mail_body',
			no_adhesion as 'entete/@no_adhesion',
			no_tel_inter_assure as 'entete/@no_tel_inter_assure',
			pj2 as 'entete/@PJ2',
			pj3 as 'entete/@PJ3',
			pj4 as 'entete/@PJ4',
			pj5 as 'entete/@PJ5',
			montant_carte_cadeau  as 'entete/@montant_carte_cadeau'

			-- Pas de section Courrier pour ces codes maquettes

		from sysadm.variable_xml_ksl_rs5045 v
		Where id_xml = @iIdXml
		FOR XML PATH('demande'))

	  End 

	If @sMethodeKsl in ( 'RS5045_CODMAQ' ) 
	  Begin
		
		-- Détermination du Canal (très important)
		Select Top 1 @sCanal = lTrim ( rTrim ( cm.canal ))
		From   sysadm.code_maquette_ksl_rs5045 cm,
			   sysadm.variable_xml_ksl_rs5045 v
		Where  v.id_xml = @iIdXml
		and	   cm.cod_maq = v.code_maquette

		If @sCanal is Null or @sCanal = '' Set @sCanal = 'C'
		If @sCanal = 'AUCUN' Set @sCanal = ''

		select @xmlResult=(
		select top 1 

			-- ci-dessous Section <Tech

			-- 'C' as 'tech/@canal',
			Case @sCanal
				When 'AUTO' Then
					Case 
						When lTrim ( rTrim ( adr_mail )) = '' Or adr_mail is null Then 'C'  -- Pour Courrier édition papier
						Else 'E'  -- Pour envoi par mail
					End
				Else @sCanal
			End as 'tech/@canal',
			code_maquette as 'tech/@code_maquette',
			'S' as 'tech/@code_adhsin',

			-- ci-dessous Section <Entete

			montant_debite as 'entete/@montant_debite',
			civilite_courte as 'entete/@civilite_courte',
			civilite_courte as 'entete/@civilite',
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
			'' as 'entete/@mail_exp', -- Sera armé plus loin pour toute appli par sysadm.PS_RS5045_I_MAIL_PUSH_KSL et sysadm.PS_S_SUBSTITUER_VARIABLE_XML
			app_marque as 'entete/@app_marque',
			app_modele as 'entete/@app_modele',
			adr_mail as 'entete/@email',
			'' as 'entete/@o2mnom',
			'' as 'entete/@o2madr1',
			'' as 'entete/@o2mcp',
			'' as 'entete/@o2mville',
			mail_subject as 'entete/@mail_subject',
			mail_body as 'entete/@mail_body',
			no_adhesion as 'entete/@no_adhesion',
			no_tel_inter_assure as 'entete/@no_tel_inter_assure',
			categorie_relance as 'entete/@categorie_relance', -- [PM407-1]
			pj2 as 'entete/@PJ2',
			pj3 as 'entete/@PJ3',
			pj4 as 'entete/@PJ4',
			pj5 as 'entete/@PJ5',
			montant_carte_cadeau  as 'entete/@montant_carte_cadeau',
			appli_sin_prov as 'entete/@appli_sin_prov', -- [MIG1_COUR_EMAILING]

			-- Ci-dessous section <Courrier

			code_operateur as 'courrier/@code_gestionnaire',
			app_marque as 'courrier/@app_marque',
			app_modele as 'courrier/@app_modele',
			montant_caution as 'courrier/@montant_caution',
			no_dossier_sinistre as 'courrier/@no_dossier_sinistre',
			date_de_declaration as 'courrier/@date_de_declaration',
			nom_produit as 'courrier/@nom_produit',
			email_produit as 'courrier/@email_produit', -- [DT154][MANTIS16226] -- [MIG1_COUR_EMAILING]
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
			env_par_mail as 'courrier/@env_par_mail', -- [PM407-1]
			code_produit as 'courrier/@code_produit', 
			lib_nature as 'courrier/@lib_nature',
			date_de_survenance_sinistre as 'courrier/@date_de_survenance_sinistre',
			heure_de_survenance_sinistre as 'courrier/@heure_de_survenance_sinistre',
			texte_1 as 'courrier/@texte_1',
			type_de_bien as 'courrier/@type_de_bien',
			code_garantie as 'courrier/@code_garantie', -- [MCO602_PNEU]
			garantie as 'courrier/@garantie', -- [MCO602_PNEU]
			fait_generateur as 'courrier/@fait_generateur', -- [MCO602_PNEU]
			circonstances as 'courrier/@circonstances', -- [MCO602_PNEU]
			url_extranet as 'courrier/@url_extranet', -- [MIG1_COUR_EMAILING]
			date_connaissance_sinistre as 'courrier/@date_connaissance_sinistre', -- [MIG1_COUR_EMAILING]
			date_fin_garantie as 'courrier/@date_fin_garantie', -- [MIG1_COUR_EMAILING]
			date_effet_garantie as 'courrier/@date_effet_garantie', -- [MIG1_COUR_EMAILING]
			appli_sin_prov as 'courrier/@appli_sin_prov', -- [MIG1_COUR_EMAILING]
			montant_reglement as 'courrier/@montant_reglement', -- [MIG1_COUR_EMAILING]
			date_rdv as 'courrier/@date_rdv', -- [MIG1_COUR_EMAILING]
			code_document as 'courrier/@code_document' -- [MIG1_COUR_EMAILING]

		from sysadm.variable_xml_ksl_rs5045 v
		Where id_xml = @iIdXml
		FOR XML PATH('demande'))

	
		set @xmlResult=REPLACE(@xmlResult,'/></demande>',
			'><tableaux><T1></T1><T2></T2><T3></T3><T4></T4><T5></T5><T6></T6></tableaux></courrier></demande>')
	End 


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
-- Retourne             :       0  Succès
--                              <0 négatif : Erreur fonctionnelle
--                              >0 positif : Erreur technique
-------------------------------------------------------------------
-- JFF      18/10/2023   [RS6044_REL_MAIL]
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
		@asMailBody             VarChar ( max ),  
		@asBoiteMail			VarChar (35), 
		@asTypMail				VarChar (10), 
		@aiIdAppli              Integer, -- Forcé par le client appelant, sinon null et pris par défaut de TRACE_MAIL_xxx.sysadm.chem_depot_ksl_rs5045 si besoin (voir JFF)
		@aiIdArch				Integer , -- [PM159]
		@asXMLdata				VarChar ( max ), -- [PM159]  
		@aiIdChemin				Integer, -- Forcé par le client appelant, sinon null et pris par défaut de TRACE_MAIL_xxx.sysadm.chem_depot_ksl_rs5045 si besoin (voir JFF)
		@adtDteHExec			DateTime, -- Forcé par le client appelant, sinon null et pris par défaut de TRACE_MAIL_xxx.sysadm.chem_depot_ksl_rs5045 si besoin (voir JFF), Date et heure avant laquelle le mail ne peut pas être envoyé, null si aucune critère
		@asErrOutPut			VarChar ( 255 ) OutPut          
AS  


Declare @asChaineBCVretour	VarChar ( 255 )

Exec sysadm.PS_RS5045_I_MAIL_PUSH_KSL_V01
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
		@asBoiteMail,
		@asTypMail,
		@aiIdAppli,
		@aiIdArch,
		null, 
		@asXMLdata,
		@aiIdChemin,
		@adtDteHExec,
		null, -- [RS6044_REL_MAIL]
		@asChaineBCVretour OutPut, -- [RS6044_REL_MAIL]
		@asErrOutPut OutPut    

Go

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_I_MAIL_PUSH_KSL_V01
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
-- Retourne             :       0  Succès
--                              <0 négatif : Erreur fonctionnelle
--                              >0 positif : Erreur technique
-------------------------------------------------------------------
-- JFF      18/10/2023   [RS6044_REL_MAIL]
-- JFF      05/12/2023   [RS6212_ARCH_MPUSH]
-- JFF      14/05/2024   [ISM427064] Exception CC_ELD pas de marquage en erreur si pas d'adresse mail
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_I_MAIL_PUSH_KSL_V01' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_I_MAIL_PUSH_KSL_V01
GO

CREATE procedure sysadm.PS_RS5045_I_MAIL_PUSH_KSL_V01
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
		@asMailBody             VarChar ( max ),  
		@asBoiteMail			VarChar (35), 
		@asTypMail				VarChar (10), 
		@aiIdAppli              Integer, -- Forcé par le client appelant, sinon null et pris par défaut de TRACE_MAIL_xxx.sysadm.chem_depot_ksl_rs5045 si besoin (voir JFF)
		@aiIdArch				Integer , -- [PM159]
		@asIdArchComplSeria     VarChar ( 255 ) = null, -- [RS6044_REL_MAIL]
		@asXMLdata				VarChar ( max ), -- [PM159]  
		@aiIdChemin				Integer, -- Forcé par le client appelant, sinon null et pris par défaut de TRACE_MAIL_xxx.sysadm.chem_depot_ksl_rs5045 si besoin (voir JFF)
		@adtDteHExec			DateTime, -- Forcé par le client appelant, sinon null et pris par défaut de TRACE_MAIL_xxx.sysadm.chem_depot_ksl_rs5045 si besoin (voir JFF), Date et heure avant laquelle le mail ne peut pas être envoyé, null si aucune critère
		@asChaineBCValler		VarChar ( 255 ), -- [RS6044_REL_MAIL]
		@asChaineBCVretour		VarChar ( 255 ) OutPut, -- [RS6044_REL_MAIL]
		@asErrOutPut			VarChar ( 255 ) OutPut          
AS  

Declare @sCodeMaquette VarChar ( 100 )
Declare @iRet integer 
Declare @iIdSeq integer  
Declare @iErr integer  
Declare @dcIdProdAdh Decimal ( 5 )  
Declare @dcIdSin Decimal ( 10 )  
Declare @sAdrMailBalProduit VarChar ( 200 )  
Declare @sMethodeKSL VarChar ( 50 )
Declare @sMethode Varchar ( 6 )
Declare @sAltQuarantaine VarChar (   1 )
Declare @dtDteHExec DateTime
Declare @sHeureExec varchar ( 5 ) 
Declare @sIdProd varchar ( 10 ) 
Declare @sMailObjet varchar ( 255 ) 

Set @dtDteHExec = @adtDteHExec

-- Set @asMethode = Upper ( lTrim ( rTrim ( @asMethode )))

-- **********************************************************************************
-- ** Cette PS ne traite que tu KSL2, malgré tout je le garde en argument d'entrée ** 
-- ** afin que le client appelant en soit conscient                                **
-- **********************************************************************************

Set @sMethode = 'KSL2'
Set @sAltQuarantaine = 'N'

-- **********************************************************************************
-- ** Traitement des cas existants sur lesquels on doit conserver les XML existants** 
-- ** METHODE 4 (KSL_EDS)                                                          **
-- **********************************************************************************

-- Récupération du code maquette soit en Maq_code ou code_maquette
Set @sCodeMaquette = sysadm.FN_CLE_VAL_XML ( 'code_maquette', @asXMLdata, 'NON' ) 



-- Traitement des cas de la Methode 4 actuelle (KSL_EDS)
If Upper ( @sCodeMaquette ) in ( 'MAIL_CASTO_DT133_2REL', 'MAIL_CASTO_DT133_1REL', 'MAIL_CASTO_DT133_ORIG', 'GEOLOC' ) 
  Begin
		Set @sMethode = 'KSL2' -- Méthode absolument, on abandonne la méthode 'KSL', plus de rammasage par les JAR
		Set @sMethodeKSL = 'KSL_EDS' -- Mais on garde les MethodeKsl 'KSL_EDS' absolument

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
				@sAltQuarantaine,
				@asBoiteMail,
				@asTypMail,
				@aiIdAppli,
				@sMethode,
				@sMethodeKSL,
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
				@sAltQuarantaine,
				@asBoiteMail,
				@asTypMail,
				@aiIdAppli,
				@sMethode,
				@sMethodeKSL,
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

-- Contrôle de l'id_chemin, il doit être déclaré sur [sysadm].[chem_depot_ksl_rs5045]
If @aiIdChemin is not null And Not Exists ( Select Top 1 1 From sysadm.chem_depot_ksl_rs5045 where id_chemin = @aiIdChemin ) 
  Begin
	   Set @asErrOutPut = 'l''@aiIdChemin ' + Convert ( varchar ( 10 ), @aiIdChemin ) + ' doit être déclaré sur TRACE_MAIL_xxx.sysadm.chem_depot_ksl_rs5045 avec une chemin UNC valide.'
	   Return -3
  End 
Else
  -- Determination id_chemin par défaut si non forcé par le client appelant
  Begin
	If @aiIdChemin is null 
	  Begin
		Select Top 1 @aiIdChemin = id_chemin 
		From sysadm.code_maquette_ksl_rs5045
		Where typ_mail = @asTypMail
		And   id_cpt = 1
	  End 
  End 

-- Heure par défaut si non forcé par le client appelant
If @dtDteHExec is null
 Begin
	Select Top 1 @sHeureExec = heure_exec
	From sysadm.code_maquette_ksl_rs5045
	Where typ_mail = @asTypMail
	And   id_cpt = 1

	If @sHeureExec is not null 
	  Begin
		 Set @dtDteHExec = CONVERT ( DateTime,  CONVERT ( Varchar ( 10 ), getdate(), 103 ) + ' ' + @sHeureExec )
		 If GetDate() > @dtDteHExec Set @dtDteHExec = DATEADD ( day, 1, @dtDteHExec )
	  End 
 End
 
-- Heure par défaut si non forcé par le client appelant
If @aiIdAppli is null Or @aiIdAppli <= 0
 Begin
	Select Top 1 @aiIdAppli = id_appli
	From sysadm.code_maquette_ksl_rs5045
	Where typ_mail = @asTypMail
	And   id_cpt = 1
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
  Exec sysadm.PS_S_SUBSTITUER_VARIABLE_XML 'Mail_Exp', @sAdrMailBalProduit, @asXMLdata output  
 End   
  
If LEN ( LTRIM ( RTRIM ( @asMailCc ) ) ) = 0  SET @asMailCc = NULL

-- Particularité du MATPD (gestion d'une horreur :-)) la variable code_produit doit contenir pour MATPD le produit sinistre et pas ahdésion (natif)
-- Changement de l'affection de la variable @sCodeMaquette, auparavant lu du XML Transmis, à présent armer avec le code maquette de la table de référence
Select Top 1 @sCodeMaquette = cod_maq from sysadm.code_maquette_ksl_rs5045 where typ_mail = @asTypMail and id_cpt = 1
If @sCodeMaquette in ( 'MATPD', 'MATPN' )
  Begin
	Set @sIdProd = Convert ( varchar ( 10), @aiIdProd )
	Exec sysadm.PS_S_SUBSTITUER_VARIABLE_XML 'code_produit', @sIdProd, @asXMLdata output  
  End 

-- Lecture de la variable XML mailSubject, et ajout de la mention [RECETTE] si l'on est hors base de production
If @@servername <> master.dbo.SPB_FN_ServerName ('PRO')  
 Begin    
	Set @sMailObjet = sysadm.FN_CLE_VAL_XML  ( 'mail_subject', @asXMLdata, 'NON' )
	If @sMailObjet is null Set @sMailObjet = ''
	Set @sMailObjet = '[RECETTE] ' + @sMailObjet 

	Exec sysadm.PS_S_SUBSTITUER_VARIABLE_XML 'mail_subject', @sMailObjet, @asXMLdata output  
 End 
 
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
				dateh_exec, -- [RS5045_REF_MATP]
				id_arch_compl -- [RS6044_REL_MAIL]
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
                Left ( @asMailBody, 7000 ),  
				@sAltQuarantaine,  
				@asBoiteMail,  
				@asTypMail,  
				@aiIdAppli,  
				@sMethode,  
				@aiIdArch,  
                Left ( @asXMLdata, 2000), -- [RS5045_REF_MATP]
				Substring ( @asXMLdata, 2001, Len ( @asXMLdata ) ),  -- [RS5045_REF_MATP]
				@aiIdChemin,
				@dtDteHExec,
				@asIdArchComplSeria -- [RS6044_REL_MAIL]
        )  
  
Set @iErr = @@ERROR     
Set @iIdSeq = @@IDENTITY  

Set @asChaineBCVretour = sysadm.FN_CLE_VAL_E ( 'ID_SEQ_MAIL', CONVERT ( varchar ( 20 ), @iIdSeq ), rtrim ( ltrim ( @asChaineBCVretour )), ';' )  -- [RS6044_REL_MAIL]

-- Si l'adresse mail est anonymisée alors on marque directement l'enregistrement comme envoyé pour éviter qu'il ressorte en erreur côté KSL
-- [ISM427064] Exception CC_ELD pas de marquage en erreur si pas d'adresse mail
-- Exception pour ELD, où on laisse partir quand même, l'équipe KSL fera partir par courrier.
If ( @asMailSend = 'XX@XX.COM' Or @asMailSend = '' Or @asMailSend is null ) And @asTypMail not in ( 'CC_ELD' )
  Begin
	Update sysadm.mail_push set 
		mail_dte_trt = GETDATE(),
		mail_trt_ok  = 'O',
		mail_id_erreur = 100
	Where id_seq = @iIdSeq
  End 

-- [RS6212_ARCH_MPUSH]
Exec sysadm.PS_RS5045_I_MAIL_ARCHIVE_CONTACT_SHERPA @iIdSeq

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
	@sXmlData    VarChar (max) -- Donnée à mettre à jour sur la clé

	-- Retourne le Nbre de Row mis à jour, normalement 1, et sinon -1 si aucun Row mis à jour ce qui s'apparente à une erreur
As

Declare @sSql VarChar  ( max )
Declare @iRowCount Integer

Set @sXmlKey = lower ( lTrim ( rTrim ( @sXmlKey ) ) )
Set @sXmlData = lTrim ( rTrim ( @sXmlData ) ) 
Set @sXmlData = REPLACE ( @sXmlData , '''', '''''' )

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
And   cm.id_cpt = 1 -- le XML toujours

If @asCodeMaquette is null Set @asCodeMaquette = ''

Go


--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_S_RECUPERER_UNE_DONNEE_D_UNE_VARIABLE_PRE_ARMEE
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_S_RECUPERER_UNE_DONNEE_D_UNE_VARIABLE_PRE_ARMEE' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_S_RECUPERER_UNE_DONNEE_D_UNE_VARIABLE_PRE_ARMEE
GO

CREATE procedure sysadm.PS_RS5045_S_RECUPERER_UNE_DONNEE_D_UNE_VARIABLE_PRE_ARMEE
	@aiIdXml integer, -- Clé de l'enregistrement XML_KSL
    @asNomVariable VarChar ( 255 ), -- Pas le nom XML, mais le nom de la zone dans la table
	@asDonnee VarChar (255) output -- Donnée en retour
As

Declare @sSql VarChar ( 255 )
Declare @Tb as Table ( valeur VarChar ( 255 ) )

Set @asNomVariable = Lower ( lTrim ( rTrim ( @asNomVariable )))

Set @sSql = 'Select ' + @asNomVariable + ' From sysadm.variable_xml_ksl_rs5045 where id_xml = ' + Convert ( varchar ( 50 ), @aiIdXml ) 
Insert into @Tb exec (@sSql)
Select @asDonnee = valeur from @Tb 

If @asDonnee is null Set @asDonnee = ''

Go


--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :       Trace de toutes les actions du moteur de traitement sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL
-- Commentaires         :       
--	                            
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL
GO

CREATE procedure sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL
	@asCas			Varchar ( 50 ),
	@aiIdSeqMail	int,
	@aiTypAction	varchar ( 6 ),
	@aiCodEtat		varchar ( 6 ),
	@asCommentaire	VarChar ( 255 ),
	@aiIdLotTrc		Integer OutPut
As

If @asCas = 'OBTENTION_ID_LOT_TRC'
  Begin
	EXEC sysadm.PS_X_INCREMENTER 'ID_LOT_TRC', @aiIdLotTrc OUTPUT 
	Return
  End 

Set @asCommentaire = lTrim ( rTrim ( @asCommentaire ) )

Insert into sysadm.trace_matp_es_sinistre_ksl_rs5045 
		(
		id_seq_mail,
		id_lot_trc,
		typ_action,
		cod_etat,
		commentaire,
		cree_le,
		maj_le,
		maj_par
		)
Values
		(
		@aiIdSeqMail,
		@aiIdLotTrc,
		@aiTypAction,
		@aiCodEtat,
		@asCommentaire,
		Getdate(),
		Getdate(),
		'SQLS'
		)

Go


--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :       Moteur de traitement des Mail ES-SINISTRE <> KSL 
-- Commentaires         :       Cette version gère les courriers Word
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--	18/10/2023 [RS6044_REL_MAIL]
--  JFF		30/06/2025   [SCHEDULER_WORDTOPDF][V05]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL
GO

CREATE procedure sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL
As

-- Procedure            :       sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :       Moteur de traitement MATP des Mail ES-SINISTRE <> KSL 
-- Commentaires         :       Cette version gère les courriers Word

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	Begin

	/*
		-- [SCHEDULER_WORDTOPDF][V05] pas mis en production
		If SIMPA2_PRO.sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') >=6 
			Begin
				Exec sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL_V05
				Return
			End
	*/
		If SIMPA2_PRO.sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') >=5 
			Begin
				Exec sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL_V04
				Return
			End 

		If SIMPA2_PRO.sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') >=4 
			Begin
				Exec sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL_V03
				Return
			End 
	End 
Else
	Begin

	/*
		-- [SCHEDULER_WORDTOPDF][V05] pas mis en production
		If SIMPA2_TRT.sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') >=6 
			Begin
				Exec sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL_V05
				Return
			End
	*/

		If SIMPA2_TRT.sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') >=5 
			Begin
				Exec sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL_V04
				Return
			End 

		If SIMPA2_TRT.sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') >=4 
			Begin
				Exec sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL_V03
				Return
			End 
	End 

Go


--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL_V04
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :       Moteur de traitement des Mail ES-SINISTRE <> KSL 
-- Commentaires         :       Cette version gère les courriers Word
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      18/10/2023   [RS6044_REL_MAIL]
-- JFF		06/06/2025   [RS6130]
-- JFF		30/06/2025   [SCHEDULER_WORDTOPDF][V05]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL_V04' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL_V04
GO

CREATE procedure sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL_V04
As

-- Procedure            :       sysadm.PS_RS5045_SU_NOUV_SYS_MATP_ES_SINISTRE_KSL_V04
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :       Moteur de traitement MATP des Mail ES-SINISTRE <> KSL 
-- Commentaires         :       Cette version gère les courriers Word

Declare @sObjet VarChar ( 255 ) 
Declare @sRetourErrMail VarChar ( 255 )
Declare @sFicOut VarChar ( 255 )
Declare @sMailBody VarChar ( 8000 )
Declare @sDestinataire Varchar ( 200 )
Declare @sMsgTrc varchar ( 255 ) 
Declare @iRowCountWord Integer
Declare @iRowCountWordTemp Integer
Declare @iRowCountHWord Integer
Declare @iRowCount Integer
Declare @iHandle Integer
Declare @iIdSeq Integer
Declare @iIdSin Integer
Declare @dtDatehExec DateTime
Declare @iIdArch Integer
Declare @iRet Integer
Declare @sXmlData varchar ( max )
Declare @sChemDepot varchar ( 255 ) 
Declare @sNomFichierDepot varchar ( 255 ) 
Declare @ChemEtNomDepot varchar ( 255 ) 
Declare @sServeurProduction varchar ( 3 )
Declare @sAdrMail varchar ( 255 ) 
Declare @iIdLotTrc Integer
Declare @iCptTraite Integer
Declare @sRepBlobLocal Varchar ( 255 )
Declare @blWordToPdf Varbinary ( max )
Declare @blSchedulerWordToPdf Varbinary ( max ) -- [SCHEDULER_WORDTOPDF][V05]
Declare @sNomFichierWordToPdf Varchar ( 255 )
Declare @sNomFichierSchedulerWordToPdf Varchar ( 255 ) -- [SCHEDULER_WORDTOPDF][V05]
Declare @sCmdDos Varchar ( 255 )
Declare @sChemEtNomWordToPdf Varchar ( 255 )
Declare @sChemEtNomSchedulerWordToPdf Varchar ( 255 ) -- [SCHEDULER_WORDTOPDF][V05]
Declare @sNomFichierPDF Varchar ( 255 )
Declare @iIdAppliNum Integer
Declare @sTypMail Varchar ( 6 )
Declare @blBlobCourrier VarBinary (max)
Declare @iFileExists Integer
Declare @dtDteDeb DateTime
Declare @dtDteEdit DateTime
Declare @sHeure VarChar ( 10 )
Declare @iDelaiAttenteMinute Integer
Declare @sDateHeureDebTrt VarChar ( 30 )
Declare @sIdArchComplSeria VarChar ( 255 ) -- [RS6044_REL_MAIL]
Declare @sDteEditComplSeria VarChar ( 255 ) -- [RS6044_REL_MAIL]
Declare @iCptArch Integer -- [RS6044_REL_MAIL]
Declare @sIdArchComplWk varchar ( 100 ) -- [RS6044_REL_MAIL]
Declare @sDteEditComplWk varchar ( 100 ) -- [RS6044_REL_MAIL]
Declare @iIdArchComplWk Integer -- [RS6044_REL_MAIL]
Declare @iContinue Integer 
Declare @dtGetDate DateTime
Declare @dtCrtle0000 DateTime
Declare @dtCrtle2000 DateTime
Declare @dtCrtle4000 DateTime
Declare @dtCrtle0015 DateTime
Declare @dtCrtle2015 DateTime
Declare @dtCrtle4015 DateTime
Declare @iRS6130 Integer -- [RS6130]


-- Contrôle sur l'horaire pour éviter les lancements à la main et donc désynchronisés par rapport au Job Windows (uniquement ebn production)

Set @dtGetDate = GETDATE()
Set @dtCrtle0000 = CONVERT( Varchar (10 ), GetDate(), 103 ) + ' ' + Left ( CONVERT( Varchar (10 ), GetDate(), 24), 3) + '00:00'
Set @dtCrtle2000 = CONVERT( Varchar (10 ), GetDate(), 103 ) + ' ' + Left ( CONVERT( Varchar (10 ), GetDate(), 24), 3) + '20:00'
Set @dtCrtle4000 = CONVERT( Varchar (10 ), GetDate(), 103 ) + ' ' + Left ( CONVERT( Varchar (10 ), GetDate(), 24), 3) + '40:00'
Set @dtCrtle0015 = CONVERT( Varchar (10 ), GetDate(), 103 ) + ' ' + Left ( CONVERT( Varchar (10 ), GetDate(), 24), 3) + '00:15'
Set @dtCrtle2015 = CONVERT( Varchar (10 ), GetDate(), 103 ) + ' ' + Left ( CONVERT( Varchar (10 ), GetDate(), 24), 3) + '20:15'
Set @dtCrtle4015 = CONVERT( Varchar (10 ), GetDate(), 103 ) + ' ' + Left ( CONVERT( Varchar (10 ), GetDate(), 24), 3) + '40:15'


IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	Begin
		If NOT ( @dtGetDate Between @dtCrtle0000 and @dtCrtle0015 Or @dtGetDate Between @dtCrtle2000 and @dtCrtle2015 Or @dtGetDate Between @dtCrtle4000 and @dtCrtle4015 ) 
			Begin
				Return
			End
	End 

Set @iCptTraite = 0 
Set @iRowCountWord = 0 
Set @sDateHeureDebTrt = Convert ( varchar ( 10 ), GETDATE(), 103 ) + ' ' + Left ( Convert ( varchar ( 30 ), GETDATE(), 114 ), 6 ) + '00'

Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL 'OBTENTION_ID_LOT_TRC', -1, '', '', '', @iIdLotTrc output

Set @sMsgTrc = 'Lancement du traitement le ' + Convert ( VarChar ( 10), Getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) + ' sur instance ' + @@servername
Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'LNCTRT', 'OK', @sMsgTrc, @iIdLotTrc  

Set @sMsgTrc = 'Obtention d''un Identifiant de lot de trace : ' + CONVERT ( varchar ( 20 ), @iIdLotTrc  )
Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'OBTIDT', 'OK', @sMsgTrc, @iIdLotTrc 

Set @sMsgTrc = 'Nettoyage mémoire Winword.exe et WordToPdf.exe'
Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'INFO', 'OK', @sMsgTrc, @iIdLotTrc 

EXEC master.dbo.xp_cmdshell 'taskkill /F  /IM WINWORD.EXE /T'
EXEC master.dbo.xp_cmdshell 'taskkill /F  /IM WORDTOPDF.EXE /T'
-- EXEC master.dbo.xp_cmdshell 'taskkill /F  /IM SCHEDULER_WORDTOPDF.EXE /T'

-- Nettoyage de ma la Table de stockage des xml temporaire, on garde que 15 jours.
Set @sMsgTrc = 'Nettoyage des jetons XML (table sysadm.variable_xml_ksl_rs5045)'
Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'INFO', 'OK', @sMsgTrc, @iIdLotTrc 
Delete sysadm.variable_xml_ksl_rs5045 where cree_le < DateAdd ( day, -15, Getdate())
  
Declare @TbWork Table (
	id_seq  integer,
	id_sin  integer,
	id_appli_num integer,
	typ_mail varchar ( 6),
	id_arch integer,
	id_arch_compl varchar (255), -- [RS6044_REL_MAIL]
	dte_edit Datetime,
	dte_edit_compl varchar (255), -- [RS6044_REL_MAIL]
	xml_data varchar (max),
	chemin_depot varchar ( 255),
	nom_fichier_depot varchar ( 255),
	dateh_exec DateTime,
	marquage integer
)

-----------------------------------------
---------- Version PRODUCTION -----------
-----------------------------------------
If @@servername = master.dbo.SPB_FN_ServerName ('PRO')  
 Begin    
  
	Set @iRS6130 = SIMPA2_PRO.sysadm.FN_CLE_NUMERIQUE ( 'RS6130') -- [RS6130]

	Set @sServeurProduction = 'PRO'

	Set @sDestinataire = 'jff@spb.fr,cbourdoiseau@spb.eu,DBOUCQ@spb.eu,GG_DSI-DO-INFRA-SERVEUR_Coll@spb.eu,GG_DSI-DO-INFRA-SERVEUR_Ext@spb.eu,GG_DSI-DO-PI_Coll@spb.eu'

	-- Obtention répertoire local pour le cas des courriers Word 
	Select @sRepBlobLocal = 
			Case @sServeurProduction
			   When 'PRO' Then ch.chemin_pro
			   Else ch.chemin_sim
		    End
	From sysadm.chem_depot_ksl_rs5045 ch
	where ch.id_chemin = 3

    ------------------------------------------------------------------------------
	--------- Traitement mail avec courrier SIMPA2						  --------
	------------------------------------------------------------------------------
	Insert into @TbWork		
	Select  
	mp.id_seq,  
	mp.id_sin,  
	mp.id_appli_num,
	mp.typ_mail,
	IsNull ( mp.id_arch, -1 ),
	mp.id_arch_compl, -- [RS6044_REL_MAIL]
	a.dte_edit,
	null, -- [RS6044_REL_MAIL]
	mp.xml_data + IsNull ( mp.xml_data2, ''),
	IsNull ( ( Select Case @sServeurProduction
						When 'PRO' Then chemin_pro
						Else chemin_sim
						End
				From sysadm.chem_depot_ksl_rs5045 
				where id_chemin = mp.id_chemin ), '') chemin_depot,
	IsNull ( ( Select ltrim ( rtrim ( nom_fichier )) + '.' + ltrim ( rtrim ( extension_fichier )) From sysadm.code_maquette_ksl_rs5045 where typ_mail = mp.typ_mail and id_cpt = 1 ), '') fichier_depot,
	Case 
		When Exists (   
					Select Top 1 1   
					From  SIMPA2_PRO.sysadm.det_pro d with (nolock),  
						  SIMPA2_PRO.sysadm.sinistre s with (nolock)  
					Where  s.id_sin = mp.id_sin  
					And    d.id_prod = s.id_prod  
					And    d.id_code_dp = 186  
					And    ( CharIndex ( '#' + a.id_cour + '#', sysadm.FN_CLE_VAL ( 'ID_COUR', rtrim ( d.val_car ), ';' ) , 1 ) > 0   
							Or   
							sysadm.FN_CLE_VAL ( 'ID_COUR', rtrim ( d.val_car ), ';' ) = ''  
							)  
				)  And mp.dateh_exec is null 
				Then Convert ( varchar ( 10 ), DateAdd ( day, 1, mp.cree_le ), 103 ) + ' 05:00:00' -- Cas FNACBG dp/186 ex mode de lecture FNAC BG
		Else mp.dateh_exec
	End 'dateh_exec',
	0
 
	From sysadm.mail_push mp with (nolock),  
		SIMPA2_PRO.sysadm.archive a with (nolock)  
	Where  mp.methode = 'KSL2'  -- Important, Nouveau RS5045
	And ( mp.mail_trt_ok = 'N' or mp.mail_trt_ok is null )  
	And mp.id_appli_num = 2  -- SIMPA2
	And mp.id_arch > 0 
	And a.id_arch = mp.id_arch  
	And mp.cree_le > DateAdd ( month, -2, getdate() )  

	Set @iRowCountWordTemp = @@Rowcount
	Set @iRowCountWord = @iRowCountWord + @iRowCountWordTemp 

	Set @sMsgTrc = 'Ramassage de ' + convert ( varchar (20), @iRowCountWordTemp  ) + ' enregistrement(s) (mails) représentant des courriers WORD SIMPA2'
	Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'LCTCWD', 'OK', @sMsgTrc, @iIdLotTrc  

	If Exists ( Select Top 1 1 From @TbWork where marquage = 0 And id_arch_compl is not null )
		Begin
			Set @sMsgTrc = 'Présence de courriers WORD SIMPA2 complèmentaires à une archive principale, ramassage des dates d''édition correspondantes'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'INFO', 'OK', @sMsgTrc, @iIdLotTrc  
		End 

	-- [RS6044_REL_MAIL] Armement des DTE_EDIT des ID_ARCH_COMPL
	While Exists ( Select Top 1 1 From @TbWork where marquage = 0 And id_arch_compl is not null )
	 Begin
		Select 	Top 1 
			@iIdSeq = id_seq,
			@sIdArchComplSeria = id_arch_compl -- [RS6044_REL_MAIL]
		From	@TbWork
		Where	marquage = 0
		And id_arch_compl is not null

		Set @sDteEditComplSeria = ''

		Set @iCptArch = 2 -- [RS6044_REL_MAIL] la 1 étant réservée, la chaine sérialisée des pièces jointes commence à 2
		While 0=0 -- [RS6044_REL_MAIL]
		 Begin
			Set @sIdArchComplWk = sysadm.FN_CLE_VAL ( 'ID_ARCH_CPL_' + CONVERT ( varchar ( 20 ), @iCptArch), @sIdArchComplSeria, ';' ) 
			If @sIdArchComplWk is null OR ltrim ( rtrim ( @sIdArchComplWk )) = '' Break

			Set @iIdArchComplWk = CONVERT ( Integer, @sIdArchComplWk )

			Select @sDteEditComplWk = CONVERT ( Varchar ( 10 ), a.dte_edit, 105 )
			From SIMPA2_PRO.sysadm.archive a with (nolock)  
			Where a.id_arch = @iIdArchComplWk

			Set @sDteEditComplSeria = sysadm.FN_CLE_VAL_E ( 'DTE_EDIT_CPL_'+ CONVERT ( varchar ( 20 ), @iCptArch), @sDteEditComplWk, rtrim ( @sDteEditComplSeria), ';' ) 
			Set @iCptArch = @iCptArch + 1
		 End 

		Update @TbWork Set marquage = 1, dte_edit_compl = rtrim ( @sDteEditComplSeria ) Where id_seq = @iIdSeq
	 End 

    ------------------------------------------------------------------------------
	--------- Traitement mail avec courrier PEGASE [RS6130]				  --------
	------------------------------------------------------------------------------
	If @iRS6130 > 0 
		Begin 
			Insert into @TbWork		
			Select  
			mp.id_seq,  
			mp.id_sin,  
			mp.id_appli_num,
			mp.typ_mail,
			IsNull ( mp.id_arch, -1 ),
			mp.id_arch_compl, -- [RS6044_REL_MAIL]
			a.dte_edit,
			null, -- [RS6044_REL_MAIL]
			mp.xml_data + IsNull ( mp.xml_data2, ''),
			IsNull ( ( Select Case @sServeurProduction
								When 'PRO' Then chemin_pro
								Else chemin_sim
								End
						From sysadm.chem_depot_ksl_rs5045 
						where id_chemin = mp.id_chemin ), '') chemin_depot,
			IsNull ( ( Select ltrim ( rtrim ( nom_fichier )) + '.' + ltrim ( rtrim ( extension_fichier )) From sysadm.code_maquette_ksl_rs5045 where typ_mail = mp.typ_mail and id_cpt = 1 ), '') fichier_depot,
			mp.dateh_exec 'dateh_exec',
			0
 
			From sysadm.mail_push mp with (nolock),  
				PEGASE_PRO.sysadm.archive a with (nolock)  
			Where  mp.methode = 'KSL2'  -- Important, Nouveau RS5045
			And ( mp.mail_trt_ok = 'N' or mp.mail_trt_ok is null )  
			And mp.id_appli_num = 3  -- PEGASE
			And mp.id_arch > 0 
			And a.id_arch2 = mp.id_arch  
			And mp.cree_le > DateAdd ( month, -2, getdate() )  

			Set @iRowCountWordTemp = @@Rowcount
			Set @iRowCountWord = @iRowCountWord + @iRowCountWordTemp 

			Set @sMsgTrc = 'Ramassage de ' + convert ( varchar (20), @iRowCountWordTemp  ) + ' enregistrement(s) (mails) représentant des courriers WORD PEGASE'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'LCTCWD', 'OK', @sMsgTrc, @iIdLotTrc  

			If Exists ( Select Top 1 1 From @TbWork where marquage = 0 And id_arch_compl is not null )
				Begin
					Set @sMsgTrc = 'Présence de courriers WORD PEGASE complèmentaires à une archive principale, ramassage des dates d''édition correspondantes'
					Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'INFO', 'OK', @sMsgTrc, @iIdLotTrc  
				End 

			-- [RS6044_REL_MAIL] Armement des DTE_EDIT des ID_ARCH_COMPL
			While Exists ( Select Top 1 1 From @TbWork where marquage = 0 And id_arch_compl is not null )
			 Begin
				Select 	Top 1 
					@iIdSeq = id_seq,
					@sIdArchComplSeria = id_arch_compl -- [RS6044_REL_MAIL]
				From	@TbWork
				Where	marquage = 0
				And id_arch_compl is not null

				Set @sDteEditComplSeria = ''

				Set @iCptArch = 2 -- [RS6044_REL_MAIL] la 1 étant réservée, la chaine sérialisée des pièces jointes commence à 2
				While 0=0 -- [RS6044_REL_MAIL]
				 Begin
					Set @sIdArchComplWk = sysadm.FN_CLE_VAL ( 'ID_ARCH_CPL_' + CONVERT ( varchar ( 20 ), @iCptArch), @sIdArchComplSeria, ';' ) 
					If @sIdArchComplWk is null OR ltrim ( rtrim ( @sIdArchComplWk )) = '' Break

					Set @iIdArchComplWk = CONVERT ( Integer, @sIdArchComplWk )

					Select @sDteEditComplWk = CONVERT ( Varchar ( 10 ), a.dte_edit, 105 )
					From PEGASE_PRO.sysadm.archive a with (nolock)  
					Where a.id_arch2 = @iIdArchComplWk

					Set @sDteEditComplSeria = sysadm.FN_CLE_VAL_E ( 'DTE_EDIT_CPL_'+ CONVERT ( varchar ( 20 ), @iCptArch), @sDteEditComplWk, rtrim ( @sDteEditComplSeria), ';' ) 
					Set @iCptArch = @iCptArch + 1
				 End 

				Update @TbWork Set marquage = 1, dte_edit_compl = rtrim ( @sDteEditComplSeria ) Where id_seq = @iIdSeq
			 End 
			 -- /RS6130
		End
 End  

----------------------------------------------------------------------------------------------
---------- Version SIMULATION                                                        ---------
---------- doit être identique à la version de production hormis le nom des Serveurs --------- 
---------- et hormis les adresses mails                                              --------- 
----------------------------------------------------------------------------------------------
If @@servername <> master.dbo.SPB_FN_ServerName ('PRO')  
 Begin

	Set @iRS6130 = SIMPA2_TRT.sysadm.FN_CLE_NUMERIQUE ( 'RS6130') -- [RS6130]

	Set @sServeurProduction = 'SIM'
  
	Set @sDestinataire = 'jff@spb.fr,nleberquier@spb.eu'


	-- Obtention répertoire local pour le cas des courriers Word 
	Select @sRepBlobLocal = 
		Case @sServeurProduction
			When 'PRO' Then ch.chemin_pro
			Else ch.chemin_sim
		End
	From sysadm.chem_depot_ksl_rs5045 ch
	where ch.id_chemin = 3

    ----------------------------------------------------------------------------------
	--------- Traitement mail avec courrier SIMPA2						  --------
	------------------------------------------------------------------------------
	Insert into @TbWork		
	Select  
	mp.id_seq,  
	mp.id_sin,  
	mp.id_appli_num,
	mp.typ_mail,
	IsNull ( mp.id_arch, -1 ),
	mp.id_arch_compl, -- [RS6044_REL_MAIL]
	a.dte_edit,	
	null, -- [RS6044_REL_MAIL]
	mp.xml_data + IsNull ( mp.xml_data2, ''),
	IsNull ( ( Select Case @sServeurProduction
						When 'PRO' Then chemin_pro
						Else chemin_sim
						End
				From sysadm.chem_depot_ksl_rs5045 
				where id_chemin = mp.id_chemin ), '') chemin_depot,
	IsNull ( ( Select ltrim ( rtrim ( nom_fichier )) + '.' + ltrim ( rtrim ( extension_fichier )) From sysadm.code_maquette_ksl_rs5045 where typ_mail = mp.typ_mail and id_cpt = 1 ), '') fichier_depot,
	Case 
		When Exists (   
					Select Top 1 1   
					From  SIMPA2_TRT.sysadm.det_pro d with (nolock),  
						  SIMPA2_TRT.sysadm.sinistre s with (nolock)  
					Where  s.id_sin = mp.id_sin  
					And    d.id_prod = s.id_prod  
					And    d.id_code_dp = 186  
					And    ( CharIndex ( '#' + a.id_cour + '#', sysadm.FN_CLE_VAL ( 'ID_COUR', rtrim ( d.val_car ), ';' ) , 1 ) > 0   
							Or   
							sysadm.FN_CLE_VAL ( 'ID_COUR', rtrim ( d.val_car ), ';' ) = ''  
							)  
				)  And mp.dateh_exec is null 
				Then Convert ( varchar ( 10 ), DateAdd ( day, 1, mp.cree_le ), 103 ) + ' 05:00:00' -- Cas FNACBG dp/186 ex mode de lecture FNAC BG
		Else mp.dateh_exec
	End 'dateh_exec',
	0
 
	From sysadm.mail_push mp with (nolock),  
		SIMPA2_TRT.sysadm.archive a with (nolock)  
	Where  mp.methode = 'KSL2'  -- Important, Nouveau RS5045
	And ( mp.mail_trt_ok = 'N' or mp.mail_trt_ok is null )  
	And mp.id_appli_num = 2  -- SIMPA2
	And mp.id_arch > 0 
	And a.id_arch = mp.id_arch  
	And mp.cree_le > DateAdd ( month, -2, getdate() )  

	Set @iRowCountWordTemp = @@Rowcount
	Set @iRowCountWord = @iRowCountWord + @iRowCountWordTemp 

	Set @sMsgTrc = 'Ramassage de ' + convert ( varchar (20), @iRowCountWordTemp  ) + ' enregistrement(s) (mails) représentant des courriers WORD SIMPA2'
	Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'LCTCWD', 'OK', @sMsgTrc, @iIdLotTrc 

	If Exists ( Select Top 1 1 From @TbWork where marquage = 0 And id_arch_compl is not null )
		Begin
			Set @sMsgTrc = 'Présence de courriers WORD SIMPA2 complèmentaires à une archive principale, ramassage des dates d''édition correspondantes'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'INFO', 'OK', @sMsgTrc, @iIdLotTrc  
		End 

	-- [RS6044_REL_MAIL] Armement des DTE_EDIT des ID_ARCH_COMPL
	While Exists ( Select Top 1 1 From @TbWork where marquage = 0 And id_arch_compl is not null )
	 Begin
		Select 	Top 1 
			@iIdSeq = id_seq,
			@sIdArchComplSeria = id_arch_compl -- [RS6044_REL_MAIL]
		From	@TbWork
		Where	marquage = 0
		And id_arch_compl is not null

		Set @sDteEditComplSeria = ''

		Set @iCptArch = 2 -- [RS6044_REL_MAIL] la 1 étant réservée, la chaine sérialisée des pièces jointes commence à 2
		While 0=0 -- [RS6044_REL_MAIL]
		 Begin
			Set @sIdArchComplWk = sysadm.FN_CLE_VAL ( 'ID_ARCH_CPL_' + CONVERT ( varchar ( 20 ), @iCptArch), @sIdArchComplSeria, ';' ) 
			If @sIdArchComplWk is null OR ltrim ( rtrim ( @sIdArchComplWk )) = '' Break

			Set @iIdArchComplWk = CONVERT ( Integer, @sIdArchComplWk )

			Select @sDteEditComplWk = CONVERT ( Varchar ( 10 ), a.dte_edit, 105 )
			From SIMPA2_TRT.sysadm.archive a with (nolock)  
			Where a.id_arch = @iIdArchComplWk

			Set @sDteEditComplSeria = sysadm.FN_CLE_VAL_E ( 'DTE_EDIT_CPL_'+ CONVERT ( varchar ( 20 ), @iCptArch), @sDteEditComplWk, rtrim ( @sDteEditComplSeria), ';' ) 
			Set @iCptArch = @iCptArch + 1
		 End 

		Update @TbWork Set marquage = 1, dte_edit_compl = rtrim ( @sDteEditComplSeria ) Where id_seq = @iIdSeq
	 End  

    ------------------------------------------------------------------------------
	--------- Traitement mail avec courrier PEGASE [RS6130]				  --------
	------------------------------------------------------------------------------
	If @iRS6130 > 0 
		Begin 
			Insert into @TbWork		
			Select  
			mp.id_seq,  
			mp.id_sin,  
			mp.id_appli_num,
			mp.typ_mail,
			IsNull ( mp.id_arch, -1 ),
			mp.id_arch_compl, -- [RS6044_REL_MAIL]
			a.dte_edit,
			null, -- [RS6044_REL_MAIL]
			mp.xml_data + IsNull ( mp.xml_data2, ''),
			IsNull ( ( Select Case @sServeurProduction
								When 'PRO' Then chemin_pro
								Else chemin_sim
								End
						From sysadm.chem_depot_ksl_rs5045 
						where id_chemin = mp.id_chemin ), '') chemin_depot,
			IsNull ( ( Select ltrim ( rtrim ( nom_fichier )) + '.' + ltrim ( rtrim ( extension_fichier )) From sysadm.code_maquette_ksl_rs5045 where typ_mail = mp.typ_mail and id_cpt = 1 ), '') fichier_depot,
			mp.dateh_exec 'dateh_exec',
			0
 
			From sysadm.mail_push mp with (nolock),  
				PEGASE_TRT.sysadm.archive a with (nolock)  
			Where  mp.methode = 'KSL2'  -- Important, Nouveau RS5045
			And ( mp.mail_trt_ok = 'N' or mp.mail_trt_ok is null )  
			And mp.id_appli_num = 3  -- PEGASE
			And mp.id_arch > 0 
			And a.id_arch2 = mp.id_arch  
			And mp.cree_le > DateAdd ( month, -2, getdate() )  

			Set @iRowCountWordTemp = @@Rowcount
			Set @iRowCountWord = @iRowCountWord + @iRowCountWordTemp 

			Set @sMsgTrc = 'Ramassage de ' + convert ( varchar (20), @iRowCountWordTemp ) + ' enregistrement(s) (mails) représentant des courriers WORD PEGASE'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'LCTCWD', 'OK', @sMsgTrc, @iIdLotTrc  

			If Exists ( Select Top 1 1 From @TbWork where marquage = 0 And id_arch_compl is not null )
				Begin
					Set @sMsgTrc = 'Présence de courriers WORD PEGASE complèmentaires à une archive principale, ramassage des dates d''édition correspondantes'
					Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'INFO', 'OK', @sMsgTrc, @iIdLotTrc  
				End 

			-- [RS6044_REL_MAIL] Armement des DTE_EDIT des ID_ARCH_COMPL
			While Exists ( Select Top 1 1 From @TbWork where marquage = 0 And id_arch_compl is not null )
			 Begin
				Select 	Top 1 
					@iIdSeq = id_seq,
					@sIdArchComplSeria = id_arch_compl -- [RS6044_REL_MAIL]
				From	@TbWork
				Where	marquage = 0
				And id_arch_compl is not null

				Set @sDteEditComplSeria = ''

				Set @iCptArch = 2 -- [RS6044_REL_MAIL] la 1 étant réservée, la chaine sérialisée des pièces jointes commence à 2
				While 0=0 -- [RS6044_REL_MAIL]
				 Begin
					Set @sIdArchComplWk = sysadm.FN_CLE_VAL ( 'ID_ARCH_CPL_' + CONVERT ( varchar ( 20 ), @iCptArch), @sIdArchComplSeria, ';' ) 
					If @sIdArchComplWk is null OR ltrim ( rtrim ( @sIdArchComplWk )) = '' Break

					Set @iIdArchComplWk = CONVERT ( Integer, @sIdArchComplWk )

					Select @sDteEditComplWk = CONVERT ( Varchar ( 10 ), a.dte_edit, 105 )
					From PEGASE_TRT.sysadm.archive a with (nolock)  
					Where a.id_arch2 = @iIdArchComplWk

					Set @sDteEditComplSeria = sysadm.FN_CLE_VAL_E ( 'DTE_EDIT_CPL_'+ CONVERT ( varchar ( 20 ), @iCptArch), @sDteEditComplWk, rtrim ( @sDteEditComplSeria), ';' ) 
					Set @iCptArch = @iCptArch + 1
				 End 

				Update @TbWork Set marquage = 1, dte_edit_compl = rtrim ( @sDteEditComplSeria ) Where id_seq = @iIdSeq
			 End 
			 -- /RS6130
		End


 End  

----------------------------------------------------------------------------------------------
---------- Version PRODUCTION ET SIMULATION                                         ----------
---------- Ne fait intervenir que la base TRACE_MAIL_XXX                            ----------
----------------------------------------------------------------------------------------------

	------------------------------------------------------------------------------
	--------- Traitement de tous les autres mails non liés à un courrier  --------
	--------- SINISTRE.                                                   -------- 
	------------------------------------------------------------------------------
	Insert into @TbWork		
	Select  
	mp.id_seq,  
	mp.id_sin,
	mp.id_appli_num,
	mp.typ_mail,
	IsNull ( mp.id_arch, -1 ),
	mp.id_arch_compl, -- [RS6044_REL_MAIL]
	null 'dte_edit',
	null, -- [RS6044_REL_MAIL]
	mp.xml_data + IsNull ( mp.xml_data2, ''),
	IsNull ( ( Select Case @sServeurProduction
						When 'PRO' Then chemin_pro
						Else chemin_sim
						End
				From sysadm.chem_depot_ksl_rs5045 
				where id_chemin = mp.id_chemin ), '') chemin_depot,
	IsNull ( ( Select ltrim ( rtrim ( nom_fichier )) + '.' + ltrim ( rtrim ( extension_fichier )) From sysadm.code_maquette_ksl_rs5045 where typ_mail = mp.typ_mail and id_cpt = 1 ), '') fichier_depot,
	mp.dateh_exec,
	0
  
	From sysadm.mail_push mp with (nolock)  
	Where  mp.methode = 'KSL2'  -- Important, Nouveau RS5045
	And ( mp.mail_trt_ok = 'N' or mp.mail_trt_ok is null )  
	And mp.id_arch = -1    
	And mp.cree_le > DateAdd ( month, -2, getdate() )    

	Set @iRowCountHWord  = @@Rowcount

	Set @sMsgTrc = 'Ramassage de ' + convert ( varchar (20), @iRowCountHWord ) + ' enregistrement(s) (mails) représentant tous les autres mails HORS courrier WORD'
	Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'LCTTAM', 'OK', @sMsgTrc, @iIdLotTrc

	Update @TbWork Set marquage = 0 -- [RS6044_REL_MAIL] On réinitialise bien les marqueurs potentiellement affecté à 1 avec id_arch_compl et les dte_edit

	If ( Select COUNT(*) From @TbWork ) = 0 
	  Begin
		Set @sMsgTrc = 'Aucun enregistrement à traiter'
		Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'INFO', 'OK', @sMsgTrc, @iIdLotTrc

		Set @sMsgTrc = 'Fin du traitement le ' + Convert ( VarChar ( 10), Getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) 
		Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'FINTRT', 'OK', @sMsgTrc, @iIdLotTrc

		Return
	  End 
	------------------------------------------------------------------------------
	--------- Instanciation de l'objet OLE necessaire au traitement       --------
	------------------------------------------------------------------------------
	Set @sMsgTrc = 'Instanciation de l''objet SqlServer ADODB.Stream en cours...'
	Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'INSOBJ', 'ENC', @sMsgTrc, @iIdLotTrc

	Exec @iHandle = sysadm.PS_INSTANCIER_UN_OBJET_SQL_SERVER 'ADODB.Stream'

	-- Traitement d'une Erreur pontentiel d'instanciation
	If @iHandle < 0 
	 Begin
		Set @sMsgTrc = 'Erreur lors de l''instanciation de l''objet SqlServer ADODB.Stream, le traitement est arrêté à '  + Convert ( VarChar ( 10), Getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) 
		Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'INSOBJ', 'ERR', @sMsgTrc, @iIdLotTrc

		Set @sObjet = '[ALERTE] [Traitement MATP SQL C#] => Instanciation objet ADODB.Stream impossible'
		If @sServeurProduction = 'SIM' Set @sObjet = '[RECETTE] - ' + @sObjet 

		Set @sObjet = Left ( @sObjet + space ( 255 ), 255 )
		Exec sysadm.PS_CASSER_REGLE_CHAINE @sObjet Output, '_', ' ' 

		Set @sMailBody = 'Bonjour ' + char (10)
		Set @sMailBody = @sMailBody + char (10)
		Set @sMailBody = @sMailBody + 'Serveur : ' + @@SERVERNAME 
		If @@SERVERNAME In ( 'SQLPRD03\INSTANCE05', 'SQLPRD04\INSTANCE05') Set @sMailBody = @sMailBody + ' (Alias [LSTAGF005001])'
		Set @sMailBody = @sMailBody + char (10)		
		Set @sMailBody = @sMailBody + 'Environnement : ' 
			If @sServeurProduction = 'SIM' Set @sMailBody = @sMailBody + 'SIMULATION'
			If @sServeurProduction = 'PRO' Set @sMailBody = @sMailBody + 'PRODUCTION'
			Set @sMailBody = @sMailBody + char (10)

		Set @sMailBody = @sMailBody + 'base    : ' + DB_NAME () + char (10)
		Set @sMailBody = @sMailBody + char (10)
		Set @sMailBody = @sMailBody + 'Contexte de l''erreur : L''objet SqlServer ADODB.Stream ne peut plus s''intancier, la conséquence est que les mails SHERPA/SIMPA2/PEGASE destinés aux assurés '
		Set @sMailBody = @sMailBody + 'ne sont plus déposés pour que le scrutateur KSL les ramasse, les mails avec courriers PDF ne partent donc plus.' + char (10)
		Set @sMailBody = @sMailBody + char (10)
		Set @sMailBody = @sMailBody + 'Une des causes possibles :' + char (10)
		Set @sMailBody = @sMailBody + '- Une soirée patch la veille a pu faire sauter le droit d''instanciation de cet objet OLE SqlServer lors d''un reboot du serveur qui s''est mal terminé (par exemple).' + char (10)
		Set @sMailBody = @sMailBody + '  Le code suivant peut rétablir ce droit, à jouer par INFRA.' + char (10)
		Set @sMailBody = @sMailBody + '    exec sp_configure ''Ole Automation Procedures'', 1 ' + char (10)
		Set @sMailBody = @sMailBody + '    RECONFIGURE' + char (10)
		Set @sMailBody = @sMailBody + char (10)
		Set @sMailBody = @sMailBody + 'Vérifier l''action en jouant : '+ char (10)
		Set @sMailBody = @sMailBody + 'exec sp_configure ''Ole Automation Procedures'''+ char (10)
		Set @sMailBody = @sMailBody + 'la valeur config_value doit être à 1 (activée) à présent' + char (10)
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + '- Sinon vérifiez les actions SQL récemment engagées par l''équipe INFRA sur ' + @@Servername  
		If @@SERVERNAME In ( 'SQLPRD03\INSTANCE05', 'SQLPRD04\INSTANCE05') Set @sMailBody = @sMailBody + ' (Alias [LSTAGF005001])'
		Set @sMailBody = @sMailBody + ' .' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + '  Consultez la trace du traitement avec ces 2 Select pour voir depuis quand le problème se produit ' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + '  Select * from ' + DB_NAME () + '.sysadm.trace_matp_es_sinistre_ksl_rs5045 where cod_etat = ''ERR'' and cree_le > ''' + @sDateHeureDebTrt + ''' order by 1' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + '  Select * from ' + DB_NAME () + '.sysadm.trace_matp_es_sinistre_ksl_rs5045 where cree_le > ''' + @sDateHeureDebTrt + ''' order by 1 desc' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + 'Le problème peut malgré être juste ponctuel, s''il ne se reproduit pas au prochain tout, ce sera résolu automatiquement.' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + 'A l''inverse, L''alerte reviendra toutes les 20 minutes tant que le problème ne sera pas résolu.' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + 'Cordialement,'
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + 'Fabry Jean-François'
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + 'DSI Team SIMPA2' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + 'Legacy Application Tech Lead' + CHAR ( 10 )


		EXEC master.dbo.SPB_PS_MAIL 
				@sRetourErrMail OUTPUT, 
				@sDestinataire ,
				@sMailBody, 
				@sObjet, 
				null, 
				'', 
				@sFicOut, 
				NULL, 
				NULL, 
				NULL, 
				NULL

		Return
	 End 

	Set @sMsgTrc = 'Instanciation de l''objet SqlServer ADODB.Stream réussi, handle de pilotage ' + CONVERT ( Varchar ( 20 ), @iHandle )
	Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'INSOBJ', 'OK', @sMsgTrc, @iIdLotTrc

	Set @sMsgTrc = 'Lancement du moteur de traitement d''écriture vers KSL'
	Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'MOTTRT', 'OK', @sMsgTrc, @iIdLotTrc 


	------------------------------------------------------------------------------
	--------- Moteur de traitement des mails sans courriers               --------
	------------------------------------------------------------------------------
	While Exists ( Select Top 1 1 From @TbWork where marquage = 0 And id_arch <= 0 )
	 Begin
		Select 	Top 1 
			@iIdSeq = id_seq,
			@iIdSin = id_sin,
			@iIdArch = id_arch,
			@sXmlData = xml_data,
			@sChemDepot = chemin_depot,
			@sNomFichierDepot = nom_fichier_depot,
			@dtDatehExec = dateh_exec
		From	@TbWork
		Where marquage = 0
		And  id_arch <= 0

		-- Contrôle de l'adresse mail, sécurité pour la simulation.
		-- Si adresse différente de @spb, on l'efface.
		If @sServeurProduction = 'SIM'
		  Begin
			Set @sAdrMail = Upper ( sysadm.FN_CLE_VAL_XML ( 'email', @sXmlData, 'NON' ) )
			If CHARINDEX ( '@SPB', @sAdrMail ) <= 0 
			  Begin
				Exec sysadm.PS_S_SUBSTITUER_VARIABLE_XML  'email', '', @sXmlData output
			  End 

			Set @sAdrMail = Upper ( sysadm.FN_CLE_VAL_XML ( 'Mail_Add_Dest', @sXmlData, 'NON' ) )
			If CHARINDEX ( '@SPB', @sAdrMail ) <= 0 
			  Begin
				Exec sysadm.PS_S_SUBSTITUER_VARIABLE_XML  'Mail_Add_Dest', '', @sXmlData output
			  End 

			Set @sAdrMail = Upper ( sysadm.FN_CLE_VAL_XML ( 'email_cc', @sXmlData, 'NON' ) )
			If CHARINDEX ( '@SPB', @sAdrMail ) <= 0 
			  Begin
				Exec sysadm.PS_S_SUBSTITUER_VARIABLE_XML  'email_cc', '', @sXmlData output
			  End 

		  End 

		-- Transformation des variables du nom du fichier en données
		Set @sNomFichierDepot = REPLACE ( @sNomFichierDepot, '[id_sin]', CONVERT ( VarChar ( 10 ), @iIdSin ) )
		Set @sNomFichierDepot = REPLACE ( @sNomFichierDepot, '[id_seq_tb_mail_push]', CONVERT ( VarChar ( 20 ), @iIdSeq ) )
		Set @sNomFichierDepot = REPLACE ( @sNomFichierDepot, '[yyyyMMddHHmmss]', Replace ( convert ( varchar(10), GETDATE(), 112 ) + CONVERT (varchar(8), GETDATE(), 108), ':', '' ))

		Set @ChemEtNomDepot = @sChemDepot + @sNomFichierDepot

		Set @sMsgTrc = 'Traitement du mail dont l''id_seq est ' + CONVERT ( varchar ( 20 ), @iIdSeq )
		Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'MOTTRT', 'ENC', @sMsgTrc, @iIdLotTrc

		If @sChemDepot = ''
		  Begin
			Set @sMsgTrc = 'Le chemin de dépôt n''est pas initialisé, contrôlez la déclaration du type de mail et de la maquette sur sysadm.code_maquette_ksl_rs5045 et sur sysadm.chem_depot_ksl_rs5045'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'CONCHM', 'ERR', @sMsgTrc, @iIdLotTrc

			Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
			Continue
		  End

		If @sNomFichierDepot = ''
		  Begin
			Set @sMsgTrc = 'Le fichier de dépôt n''est pas initialisé, contrôlez la déclaration du type de mail et de la maquette sur sysadm.code_maquette_ksl_rs5045 et sur sysadm.chem_depot_ksl_rs5045'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'CONCHM', 'ERR', @sMsgTrc, @iIdLotTrc

			Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
			Continue
		  End

		If @dtDatehExec > Getdate() 
		  Begin
		    -- Ce n'est pas encore la date et l'heure pour traiter ce mail
	
			Set @sMsgTrc = 'Le mail ' + CONVERT ( varchar ( 20 ), @iIdSeq ) + ' à une date d''éxécution au ' + Convert ( VarChar ( 10), @dtDatehExec, 103 ) + ' à ' + CONVERT (varchar(8), @dtDatehExec, 108)+ ', il n''est donc pas traité sur ce traitement, il sera traité ultérieurement' 
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'MOTTRT', 'EXERET', @sMsgTrc, @iIdLotTrc

			Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
			Set @iCptTraite =  @iCptTraite + 1 -- Cas particulier, le décalage horaire n'est pas une erreur, on compte donc comme traité, même s'il sera représenté au prochain tour

			Continue
		  End 

		Set @sMsgTrc = 'Construction du fichier XML à destination de KSL en cours...'
		Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'CONXML', 'ENC', @sMsgTrc, @iIdLotTrc

		Exec @iRet = sysadm.PS_ECRIRE_UN_ENREGISTREMENT_ADODB_STREAM @iHandle, 2, 3, 'UTF-8', 10, @sXmlData

		If @iRet <> 0 
		  Begin
			Set @sMsgTrc = 'Erreur lors de la construction du fichier XML, code erreur ' + CONVERT ( Varchar ( 20 ), @iRet ) + ', le fichier n''a pas été écrit !'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'CONXML', 'ERR', @sMsgTrc, @iIdLotTrc

			Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
			Continue
		  End 

		Set @sMsgTrc = 'Fichier XML construit avec succès'
		Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'CONXML', 'OK', @sMsgTrc, @iIdLotTrc 


		Set @sMsgTrc = 'Ecriture du fichier XML à destination de KSL en cours... (sur ' + @ChemEtNomDepot  + ')'
		Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'ECRXML', 'ENC', @sMsgTrc, @iIdLotTrc

		Exec @iRet = sysadm.PS_SAUVEGARDER_ET_FERMER_UN_FICHER_ADODB_STREAM @iHandle, @ChemEtNomDepot, 2

		If @iRet <> 0 
		  Begin
			Set @sMsgTrc = 'Erreur lors de l''écriture du fichier XML, code erreur ' + CONVERT ( Varchar ( 20 ), @iRet ) + ', le fichier n''a pas été écrit !'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'ECRXML', 'ERR', @sMsgTrc, @iIdLotTrc

			Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
			Continue
		  End 

		Set @sMsgTrc = 'Fichier XML écrit avec succès sur ' + @ChemEtNomDepot 
		Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'ECRXML', 'OK', @sMsgTrc, @iIdLotTrc

		Update sysadm.mail_push set 
			mail_dte_trt = GETDATE(),
			mail_trt_ok  = 'O'
		Where id_seq = @iIdSeq
	    Set @iRowCount = @@Rowcount
	
		If @iRowCount = 1 
		  Begin 
			Set @sMsgTrc = 'Le marquage du traitement de ce mail s''est effectué avec succès sur la table source sysadm.mail_push, champ mail_trt_ok et mail_dte_trt'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'MARTRT', 'OK', @sMsgTrc, @iIdLotTrc
		  End
		Else
		  Begin 
			Set @sMsgTrc = 'Le marquage du traitement de ce mail se termine en échec, ce mail n''est pas marqué, il sera donc traité de nouveau au prochain traitement'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'MARTRT', 'ERR', @sMsgTrc, @iIdLotTrc
		  End

		Update @TbWork Set marquage = 1 Where id_seq = @iIdSeq

		Set @iCptTraite =  @iCptTraite + 1 
	 End
 	------------------------------------------------------------------------------
	--------- FIN 1er Moteur                                              --------
	------------------------------------------------------------------------------
	
 	----------------------------------------------------------------------------------------------
	--------- Préparation du traitement des mails avec courrier WORD						------
	--------- Je ne conditionne pas ce pré-traitement à la présence du critère id_arch > 0  ------
	--------- La présence de l'EXE est impérative pour ne pas faire planter la tache Window ------
	--------- qui passe 5 minutes plus tard                                                 ------
	----------------------------------------------------------------------------------------------
	-- [SCHEDULER_WORDTOPDF][V05]
	Delete @TbWork Where marquage = 100 
	While 0 = 0
		Begin

			If @sRepBlobLocal is null Or ltrim ( rtrim ( @sRepBlobLocal )) = ''
			  Begin
				Set @sMsgTrc = 'Nom du répertoire de travail local au serveur non initialisé, introuvable dans le paramètrage, arrêt de traitement'
				Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'NOMRLC', 'ERR', @sMsgTrc, @iIdLotTrc  

				Delete @TbWork where marquage = 0 And id_arch > 0
				Break
			  End 

			Set @sMsgTrc = 'Récupération de WordToPdf.EXE en cours...'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'RCPEXE', 'ENC', @sMsgTrc, @iIdLotTrc

			Select @blWordToPdf = binaire,
					@sNomFichierWordToPdf = nom
			From sysadm.application_complementaire_RS5045
			Where id_appcomp = 1

			-- Obtention du Blob échouée 2ème cas
			If @blWordToPdf is null Or Datalength ( @blWordToPdf ) <= 5
			Begin
				Set @sMsgTrc = 'Erreur lors de la récupération de WordToPdf.EXE, le blob est vide, aucun mail avec courrier Word n''a été traité, arrêt de traitement'
				Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'RCPEXE', 'ERR', @sMsgTrc, @iIdLotTrc
		
				Delete @TbWork where marquage = 0 And id_arch > 0
				Break
			End

			Set @sMsgTrc = 'Récupération de WordToPdf.EXE effectué avec succès'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'RCPEXE', 'OK', @sMsgTrc, @iIdLotTrc
/*
			EXEC master.dbo.xp_cmdshell 'taskkill /F  /IM WINWORD.EXE /T'
			EXEC master.dbo.xp_cmdshell 'taskkill /F  /IM WORDTOPDF.EXE /T'
*/

			-- Création du répertoire de travail local au serveur
			/* J'arrête la suppression et création du répertoire afin de ne pas perdre les droits du répertoires
			Set @sCmdDos = 'RD ' + @sRepBlobLocal
			EXEC master.dbo.xp_cmdshell @sCmdDos 
			Set @sCmdDos = 'MD ' + @sRepBlobLocal
			EXEC master.dbo.xp_cmdshell @sCmdDos 
			*/
			Set @sCmdDos = 'Del ' + @sRepBlobLocal + '\*.* /F /Q'
			EXEC master.dbo.xp_cmdshell @sCmdDos 

			-- Ecriture de WordToPdf.exe sur disque
			Set @sMsgTrc = 'Construction du fichier WordToPdf.EXE en cours...'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'CONEXE', 'ENC', @sMsgTrc, @iIdLotTrc

			Exec @iRet = sysadm.PS_ECRIRE_UN_ENREGISTREMENT_ADODB_STREAM_V02 @iHandle, 1, 3, null, null, null, @blWordToPdf

			If @iRet <> 0 
				Begin
				Set @sMsgTrc = 'Erreur lors de la construction du fichier WordToPdf.EXE, code erreur ' + CONVERT ( Varchar ( 20 ), @iRet ) + ', le fichier n''a pas été écrit !, arrêt de traitement'
				Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'CONEXE', 'ERR', @sMsgTrc, @iIdLotTrc

				Delete @TbWork where marquage = 0 And id_arch > 0
				Break
				End 

			Set @sMsgTrc = 'Fichier WordToPdf.EXE construit avec succès'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'CONEXE', 'OK', @sMsgTrc, @iIdLotTrc 

			Set @sChemEtNomWordToPdf = @sRepBlobLocal + '\' + @sNomFichierWordToPdf

			Set @sMsgTrc = 'Ecriture du fichier WordToPdf.EXE en cours... (sur ' + @sChemEtNomWordToPdf  + ')'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'ECREXE', 'ENC', @sMsgTrc, @iIdLotTrc

			Exec @iRet = sysadm.PS_SAUVEGARDER_ET_FERMER_UN_FICHER_ADODB_STREAM @iHandle, @sChemEtNomWordToPdf, 2

			If @iRet <> 0 
				Begin
					Set @sMsgTrc = 'Erreur lors de l''écriture du fichier WordToPdf.EXE, code erreur ' + CONVERT ( Varchar ( 20 ), @iRet ) + ', le fichier n''a pas été écrit !, arrêt de traitement'
					Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'ECREXE', 'ERR', @sMsgTrc, @iIdLotTrc

					Delete @TbWork where marquage = 0 And id_arch > 0
					Break
				End 

			Set @sMsgTrc = 'Fichier WordToPdf.EXE écrit avec succès sur ' + @sChemEtNomWordToPdf 
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'ECREXE', 'OK', @sMsgTrc, @iIdLotTrc

/*
			-- [SCHEDULER_WORDTOPDF][V05]
			Set @sMsgTrc = 'Récupération de Scheduler_WordToPdf.exe en cours...'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'RCPEXE', 'ENC', @sMsgTrc, @iIdLotTrc

			Select	@blSchedulerWordToPdf = binaire,
					@sNomFichierSchedulerWordToPdf = nom
			From sysadm.application_complementaire_RS5045
			Where id_appcomp = 9

			-- Obtention du Blob échouée 2ème cas
			If @blSchedulerWordToPdf is null Or Datalength ( @blSchedulerWordToPdf ) <= 5
			Begin
				Set @sMsgTrc = 'Erreur lors de la récupération de Scheduler_WordToPdf.EXE, le blob est vide, aucun mail avec courrier Word n''a été traité, arrêt de traitement'
				Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'RCPEXE', 'ERR', @sMsgTrc, @iIdLotTrc
		
				Delete @TbWork where marquage = 0 And id_arch > 0
				Break
			End

			Set @sMsgTrc = 'Récupération de Scheduler_WordToPdf.EXE effectué avec succès'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'RCPEXE', 'OK', @sMsgTrc, @iIdLotTrc

			-- Ecriture de WordToPdf.exe sur disque
			Set @sMsgTrc = 'Construction du fichier Scheduler_WordToPdf.EXE en cours...'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'CONEXE', 'ENC', @sMsgTrc, @iIdLotTrc

			Exec @iRet = sysadm.PS_ECRIRE_UN_ENREGISTREMENT_ADODB_STREAM_V02 @iHandle, 1, 3, null, null, null, @blSchedulerWordToPdf

			If @iRet <> 0 
				Begin
					Set @sMsgTrc = 'Erreur lors de la construction du fichier Scheduler_WordToPdf.EXE, code erreur ' + CONVERT ( Varchar ( 20 ), @iRet ) + ', le fichier n''a pas été écrit !, arrêt de traitement'
					Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'CONEXE', 'ERR', @sMsgTrc, @iIdLotTrc

					Delete @TbWork where marquage = 0 And id_arch > 0
					Break
				End 

			Set @sMsgTrc = 'Fichier Scheduler_WordToPdf.EXE construit avec succès'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'CONEXE', 'OK', @sMsgTrc, @iIdLotTrc 

			Set @sChemEtNomSchedulerWordToPdf = @sRepBlobLocal + '\' + @sNomFichierSchedulerWordToPdf

			Set @sMsgTrc = 'Ecriture du fichier Scheduler_WordToPdf.EXE en cours... (sur ' + @sChemEtNomSchedulerWordToPdf  + ')'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'ECREXE', 'ENC', @sMsgTrc, @iIdLotTrc

			Exec @iRet = sysadm.PS_SAUVEGARDER_ET_FERMER_UN_FICHER_ADODB_STREAM @iHandle, @sChemEtNomSchedulerWordToPdf, 2

			If @iRet <> 0 
				Begin
					Set @sMsgTrc = 'Erreur lors de l''écriture du fichier Scheduler_WordToPdf.EXE, code erreur ' + CONVERT ( Varchar ( 20 ), @iRet ) + ', le fichier n''a pas été écrit !, normal si un instance du scheduleur tourne déjà en mémoire.'
					Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'ECREXE', 'OK', @sMsgTrc, @iIdLotTrc
					Set @iRet = 0
				End 
			Else
				Begin
					Set @sMsgTrc = 'Fichier Scheduler_WordToPdf.EXE écrit avec succès sur ' + @sChemEtNomSchedulerWordToPdf 
					Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'ECREXE', 'OK', @sMsgTrc, @iIdLotTrc
				End

			-- Lancement du Scheduler, un contrôle est fait sur l'instance, une seule instance ne peut être lancée
			Set @sCmdDos = 'start "" "' + @sChemEtNomSchedulerWordToPdf + '"'
			EXEC master.dbo.xp_cmdshell  @sCmdDos 
*/

			Break

		End 


	------------------------------------------------------------------------------
	--------- Moteur de traitement des courriers Word sans préparer le XML--------
	--------- pour l'instant, ni conversion PDF, juste la descente des    --------
	--------- fichier Word sur disque.                                    --------
	------------------------------------------------------------------------------
	While Exists ( Select Top 1 1 From @TbWork where marquage = 0 And id_arch > 0 )
	 Begin
		Select 	Top 1 
			@iIdSeq = id_seq,
			@iIdSin = id_sin,
			@iIdAppliNum = id_appli_num,
			@sTypMail = typ_mail,
			@iIdArch = id_arch,
			@sIdArchComplSeria = id_arch_compl, -- [RS6044_REL_MAIL]
			@sDteEditComplSeria = dte_edit_compl, -- [RS6044_REL_MAIL]
			@dtDteEdit = dte_edit,
			@sXmlData = xml_data,
			@sChemDepot = chemin_depot,
			@dtDatehExec = dateh_exec
		From	@TbWork
		Where	marquage = 0
		And id_arch > 0

		If @sIdArchComplSeria is null Set @sIdArchComplSeria = ''
		If @sDteEditComplSeria is null Set @sDteEditComplSeria = ''
		Set @sIdArchComplSeria = sysadm.FN_CLE_VAL_E ( 'ID_ARCH_CPL_1', Convert ( varchar ( 20 ) , @iIdArch), @sIdArchComplSeria, ';' ) -- [RS6044_REL_MAIL]
		Set @sDteEditComplSeria = sysadm.FN_CLE_VAL_E ( 'DTE_EDIT_CPL_1', Convert ( varchar ( 10 ), @dtDteEdit, 105), @sDteEditComplSeria, ';' ) -- [RS6044_REL_MAIL]
		Set @iCptArch = 0 -- [RS6044_REL_MAIL]
		Set @iContinue = 0

		While 0=0 -- [RS6044_REL_MAIL]
			Begin
				Set @iCptArch = @iCptArch + 1  

				-- [RS6044_REL_MAIL]
				Set @sIdArchComplWk = sysadm.FN_CLE_VAL ( 'ID_ARCH_CPL_' + CONVERT ( varchar ( 20 ), @iCptArch), @sIdArchComplSeria, ';' ) 
				If @sIdArchComplWk is null OR ltrim ( rtrim ( @sIdArchComplWk )) = '' Break

				Set @iIdArchComplWk = CONVERT ( Integer, @sIdArchComplWk )
				Set @sDteEditComplWk = sysadm.FN_CLE_VAL ( 'DTE_EDIT_CPL_'+ CONVERT ( varchar ( 20 ), @iCptArch), @sDteEditComplSeria, ';' )

				-- Obtention du nom de fichier particulier (id_cpt 3) -- [RS6044_REL_MAIL]
				Select @sNomFichierDepot = 'DTE_EDIT=' + @sDteEditComplWk  + '-' + ltrim ( rtrim ( nom_fichier )) + '.' + ltrim ( rtrim ( extension_fichier ))
				From   sysadm.code_maquette_ksl_rs5045
				Where  typ_mail = @sTypMail
				and	   id_cpt = 3

				-- Contrôle de l'adresse mail, sécurité pour la simulation.
				-- Si adresse différente de @spb, on l'efface.
				If @sServeurProduction = 'SIM'
				  Begin
					Set @sAdrMail = Upper ( sysadm.FN_CLE_VAL_XML ( 'email', @sXmlData, 'NON' ) )
					If CHARINDEX ( '@SPB', @sAdrMail ) <= 0 
					  Begin
						Exec sysadm.PS_S_SUBSTITUER_VARIABLE_XML  'email', '', @sXmlData output
					  End 

					Set @sAdrMail = Upper ( sysadm.FN_CLE_VAL_XML ( 'Mail_Add_Dest', @sXmlData, 'NON' ) )
					If CHARINDEX ( '@SPB', @sAdrMail ) <= 0 
					  Begin
						Exec sysadm.PS_S_SUBSTITUER_VARIABLE_XML  'Mail_Add_Dest', '', @sXmlData output
					  End 

					Set @sAdrMail = Upper ( sysadm.FN_CLE_VAL_XML ( 'email_cc', @sXmlData, 'NON' ) )
					If CHARINDEX ( '@SPB', @sAdrMail ) <= 0 
					  Begin
						Exec sysadm.PS_S_SUBSTITUER_VARIABLE_XML  'email_cc', '', @sXmlData output
					  End 
				  End 

				-- Transformation des variables du nom du fichier en données
				Set @sNomFichierDepot = REPLACE ( @sNomFichierDepot, '[id_sin]', CONVERT ( VarChar ( 10 ), @iIdSin ) )
				Set @sNomFichierDepot = REPLACE ( @sNomFichierDepot, '[id_seq_tb_mail_push]', CONVERT ( VarChar ( 20 ), @iIdSeq ) )
				Set @sNomFichierDepot = REPLACE ( @sNomFichierDepot, '[yyyyMMddHHmmss]', Replace ( convert ( varchar(10), GETDATE(), 112 ) + CONVERT (varchar(8), GETDATE(), 108), ':', '' ))
				Set @sNomFichierDepot = REPLACE ( @sNomFichierDepot, '[indice]', CONVERT ( varchar ( 20 ), @iCptArch ) )  

				Set @ChemEtNomDepot = @sRepBlobLocal + '\' + @sNomFichierDepot

				Set @sMsgTrc = 'Traitement du mail dont l''id_seq est ' + CONVERT ( varchar ( 20 ), @iIdSeq )
				Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'MOTTRT', 'ENC', @sMsgTrc, @iIdLotTrc

				If @sChemDepot = ''
				  Begin
					Set @sMsgTrc = 'Le chemin de dépôt n''est pas initialisé, contrôlez la déclaration du type de mail et de la maquette sur sysadm.code_maquette_ksl_rs5045 et sur sysadm.chem_depot_ksl_rs5045'
					Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'CONCHM', 'ERR', @sMsgTrc, @iIdLotTrc

					Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
					-- Continue
					Set @iContinue = 1
					Break
				  End

				If @sNomFichierDepot = ''
				  Begin
					Set @sMsgTrc = 'Le fichier de dépôt n''est pas initialisé, contrôlez la déclaration du type de mail et de la maquette sur sysadm.code_maquette_ksl_rs5045 et sur sysadm.chem_depot_ksl_rs5045'
					Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'CONCHM', 'ERR', @sMsgTrc, @iIdLotTrc

					Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq

					-- Continue
					Set @iContinue = 1
					Break
				  End

				If @dtDatehExec > Getdate() 
				  Begin
					-- Ce n'est pas encore la date et l'heure pour traiter ce mail
	
					Set @sMsgTrc = 'Le mail ' + CONVERT ( varchar ( 20 ), @iIdSeq ) + ' à une date d''éxécution au ' + Convert ( VarChar ( 10), @dtDatehExec, 103 ) + ' à ' + CONVERT (varchar(8), @dtDatehExec, 108)+ ', il n''est donc pas traité sur ce traitement, il sera traité ultérieurement' 
					Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'MOTTRT', 'EXERET', @sMsgTrc, @iIdLotTrc

					Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
					Set @iCptTraite =  @iCptTraite + 1 -- Cas particulier, le décalage horaire n'est pas une erreur, on compte donc comme traité, même s'il sera représenté au prochain tour

					-- Continue
					Set @iContinue = 1
					Break

				  End 

				-- Obtention du Blob sur la bonne base 
				-- [RS6044_REL_MAIL]
				Set @sMsgTrc = 'Récupération du courrier (archive ' + Convert ( varchar ( 20), @iIdArchComplWk ) + ') de la base ' + 
					Case @iIdAppliNum 
						When 2 Then 'SIMPA2'
						When 3 Then 'PEGASE'
						Else '[Base à renseigner]'
					End +
					' en cours...'

				Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'RECBLB', 'ENC', @sMsgTrc, @iIdLotTrc
				-- [RS6044_REL_MAIL]
				Exec @iRet=sysadm.PS_RS5045_S_RECUPERER_LE_BLOB_COURRIER @iIdAppliNum, @iIdArchComplWk, @blBlobCourrier OUTPUT

				-- Obtention du Blob échouée 1er cas 
				If @iRet <> 0 
				  Begin
					Set @sMsgTrc = 'Erreur lors de la récupération du blob, code erreur ' + CONVERT ( Varchar ( 20 ), @iRet ) + ', ce mail n''est pas traité !'
					Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'RECBLB', 'ERR', @sMsgTrc, @iIdLotTrc

					Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq 
					-- Continue
					Set @iContinue = 1
					Break
				  End 

				-- Obtention du Blob échouée 2ème cas
				If @blBlobCourrier is null Or Datalength ( @blBlobCourrier ) <= 5
				  Begin
					Set @sMsgTrc = 'Erreur lors de la récupération du blob, le blob est vide, ce mail n''est pas traité !'
					Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'RECBLB', 'ERR', @sMsgTrc, @iIdLotTrc

					Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
					-- Continue
					Set @iContinue = 1
					Break
				  End 

				-- Obtention du Blob succés
				-- [RS6044_REL_MAIL]
				Set @sMsgTrc = 'Récupération du courrier (archive ' + Convert ( varchar ( 20), @iIdArchComplWk ) + ') effectué avec succès.'
				Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'RECBLB', 'OK', @sMsgTrc, @iIdLotTrc


				Set @sMsgTrc = 'Construction du fichier Word en cours...'
				Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'CONBLB', 'ENC', @sMsgTrc, @iIdLotTrc

				Exec @iRet = sysadm.PS_ECRIRE_UN_ENREGISTREMENT_ADODB_STREAM_V02 @iHandle, 1, 3, null, null, null, @blBlobCourrier

				If @iRet <> 0 
				  Begin
					Set @sMsgTrc = 'Erreur lors de la construction du fichier Word, code erreur ' + CONVERT ( Varchar ( 20 ), @iRet ) + ', le fichier n''a pas été écrit !, mail non traité.'
					Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'CONBLB', 'ERR', @sMsgTrc, @iIdLotTrc

					Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
					-- Continue
					Set @iContinue = 1
					Break
				  End 

				Set @sMsgTrc = 'Fichier Word construit avec succès'
				Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'CONBLB', 'OK', @sMsgTrc, @iIdLotTrc 


				Set @sMsgTrc = 'Ecriture du fichier Word à destination de KSL en cours... (sur ' + @ChemEtNomDepot  + ')'
				Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'ECRBLB', 'ENC', @sMsgTrc, @iIdLotTrc

				Exec @iRet = sysadm.PS_SAUVEGARDER_ET_FERMER_UN_FICHER_ADODB_STREAM @iHandle, @ChemEtNomDepot, 2

				If @iRet <> 0 
				  Begin
					Set @sMsgTrc = 'Erreur lors de l''écriture du fichier Word, code erreur ' + CONVERT ( Varchar ( 20 ), @iRet ) + ', le fichier n''a pas été écrit !, mail non traité.'
					Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'ECRBLB', 'ERR', @sMsgTrc, @iIdLotTrc

					Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
					-- Continue
					Set @iContinue = 1
					Break
				  End 

				Set @sMsgTrc = 'Fichier Word écrit avec succès sur ' + @ChemEtNomDepot 
				Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'ECRBLB', 'OK', @sMsgTrc, @iIdLotTrc

				Update @TbWork Set marquage = 1 Where id_seq = @iIdSeq

			End

			If @iContinue = 1 Continue
	 End
 	------------------------------------------------------------------------------
	--------- FIN 2ème Moteur                                             --------
	------------------------------------------------------------------------------

	------------------------------------------------------------------------------
	--------- Conversion des fichiers Word descendus sur Disque en PDF    --------
	------------------------------------------------------------------------------
	Delete @TbWork Where marquage = 100
	While Exists ( Select Top 1 1 From @TbWork where marquage = 1 And id_arch > 0 )
	 Begin
		-- Attente de n minutes 

		/*
			2m => descente 250 
			5m => Conversion 250 
			2m23 => déplacement 250
 
			Donc je vois 
			0 à 05 Descente ( 5 minutes )
			05 à 13 conversion ( 8 minutes )
			13 à ... déplacement (6 minutes max jusqu'à 20 pour déplacer)
		*/

		Set @iDelaiAttenteMinute = 13 -- nouveau délai [ICI][DELAI_CONVERSION]
		-- Set @iDelaiAttenteMinute = 8 config avant
	    -- Set @iDelaiAttenteMinute = 2 pour mes test
		Set @sMsgTrc = 'Conversion de tous les courriers Word au format PDF en cours... (attente de ' + Convert ( Varchar (10), @iDelaiAttenteMinute ) + ' minutes avant reprise du traitement )'
		Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'CONPDF', 'ENC', @sMsgTrc, @iIdLotTrc

		Set @sHeure = Convert ( Varchar ( 5 ) , DateAdd ( minute, @iDelaiAttenteMinute , getdate()) , 114 ) 
		WaitFor Time @sHeure 

		Set @sCmdDos = @sRepBlobLocal + '\' + 'WordToPdf_FIN_TRT.TXT'
		EXECUTE xp_fileexist @sCmdDos, @iFileExists OUTPUT
		If @iFileExists > 0 Set @iFileExists = 1

		If @iFileExists <= 0 
			Begin
				Set @sCmdDos = @sRepBlobLocal + '\' + 'WordToPdf_ERR_TRT.TXT'
				EXECUTE xp_fileexist @sCmdDos, @iFileExists OUTPUT
				If @iFileExists > 0 Set @iFileExists = -1
			End 

	
		If @iFileExists <> 1 
		  Begin 
			Set @sMsgTrc = 'Erreur lors de la conversion des fichiers Word au format PDF, arrêt du traitement.'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'CONPDF', 'ERR', @sMsgTrc, @iIdLotTrc
			Delete @TbWork Where marquage = 1 And id_arch > 0
		  End 

		If @iFileExists = 1 
		  Begin 
			Set @sMsgTrc = 'Conversion des fichiers Word au format PDF effectuée avec succès.'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'CONPDF', 'OK', @sMsgTrc, @iIdLotTrc
		  End 

		EXEC master.dbo.xp_cmdshell 'taskkill /F  /IM WINWORD.EXE /T'
		EXEC master.dbo.xp_cmdshell 'taskkill /F  /IM WORDTOPDF.EXE /T'

		Break
	 End

	------------------------------------------------------------------------------
	--------- Moteur de traitement des mails (XML) associés aux courriers --------
	------------------------------------------------------------------------------
	While Exists ( Select Top 1 1 From @TbWork where marquage = 1 And id_arch > 0 )
	 Begin
	    -- Break -- [DEBUG]

		Select 	Top 1 
			@iIdSeq = id_seq,
			@iIdSin = id_sin,
			@iIdArch = id_arch,
			@sIdArchComplSeria = id_arch_compl, -- [RS6044_REL_MAIL]
			@sXmlData = xml_data,
			@sChemDepot = chemin_depot,
			@sNomFichierDepot = nom_fichier_depot,
			@dtDatehExec = dateh_exec
		From	@TbWork
		Where	marquage = 1
		And id_arch > 0 

		If @sIdArchComplSeria is null Set @sIdArchComplSeria = ''
		If @sDteEditComplSeria is null Set @sDteEditComplSeria = ''
		Set @sIdArchComplSeria = sysadm.FN_CLE_VAL_E ( 'ID_ARCH_CPL_1', Convert ( varchar ( 20 ) , @iIdArch), @sIdArchComplSeria, ';' ) -- [RS6044_REL_MAIL]
		Set @iCptArch = 0 -- [RS6044_REL_MAIL]
		Set @iContinue = 0

		While 0=0 -- [RS6044_REL_MAIL]
			Begin

				Set @iCptArch = @iCptArch + 1  

				-- [RS6044_REL_MAIL]
				Set @sIdArchComplWk = sysadm.FN_CLE_VAL ( 'ID_ARCH_CPL_' + CONVERT ( varchar ( 20 ), @iCptArch), @sIdArchComplSeria, ';' ) 
				If @sIdArchComplWk is null OR ltrim ( rtrim ( @sIdArchComplWk )) = '' Break

				-- Reconstruction du nom du fichier PDF
				Select @sNomFichierPDF = ltrim ( rtrim ( nom_fichier )) + '.' + ltrim ( rtrim ( extension_fichier ))
				From   sysadm.code_maquette_ksl_rs5045
				Where  typ_mail = @sTypMail
				and	   id_cpt = 2

				-- Transformation des variables du nom du fichier en données
				Set @sNomFichierPDF = REPLACE ( @sNomFichierPDF, '[id_sin]', CONVERT ( VarChar ( 10 ), @iIdSin ) )
				Set @sNomFichierPDF = REPLACE ( @sNomFichierPDF, '[id_seq_tb_mail_push]', CONVERT ( VarChar ( 20 ), @iIdSeq ) )
				Set @sNomFichierPDF = REPLACE ( @sNomFichierPDF, '[yyyyMMddHHmmss]', Replace ( convert ( varchar(10), GETDATE(), 112 ) + CONVERT (varchar(8), GETDATE(), 108), ':', '' ))
				Set @sNomFichierPDF = REPLACE ( @sNomFichierPDF, '[indice]', CONVERT ( varchar ( 20 ), @iCptArch ) )  

				Set @sCmdDos = @sRepBlobLocal + '\' + @sNomFichierPDF
				EXECUTE xp_fileexist @sCmdDos, @iFileExists OUTPUT

				-- PDF bien présent ou pas avant d'aller plus loin
				If @iFileExists = 0 
				  Begin
					Set @sMsgTrc = 'Le fichier ' + @sCmdDos + ' est introuvable en local, le mail n''est pas traité'
					Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'PDFAB1', 'ERR', @sMsgTrc, @iIdLotTrc

					Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
					-- Continue
					Set @iContinue = 1
					Break
				  End 

				Set @sMsgTrc = 'Déplacement du PDF '+ CONVERT ( varchar ( 20 ), @iCptArch ) + ' ' + @sRepBlobLocal + '\' + @sNomFichierPDF + ' vers le répertoire KSL en cours... (sur ' + @sChemDepot + @sNomFichierPDF  + ')'
				Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'DEPPDF', 'ENC', @sMsgTrc, @iIdLotTrc

				-- Juste avant d'écrire le XML qui sera l'élément déclencheur pour KSL, je déplace le PDF dans le répertoire définitif
				Set @sCmdDos = 'Move ' +  @sRepBlobLocal + '\' + @sNomFichierPDF + ' ' + @sChemDepot
				EXEC @iRet = master.dbo.xp_cmdshell @sCmdDos 

				Set @sCmdDos = @sChemDepot + @sNomFichierPDF
				EXECUTE xp_fileexist @sCmdDos, @iFileExists OUTPUT

				-- PDF bien présent ou pas avant d'aller plus loin
				If @iFileExists = 0 
				  Begin
					Set @sMsgTrc = 'Après déplacement, le fichier ' + @sCmdDos + ' est introuvable dans le répertoire KSL, le mail n''est pas traité'
					Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'PDFAB2', 'ERR', @sMsgTrc, @iIdLotTrc

					Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
					-- Continue
					Set @iContinue = 1
					Break
				  End 
				Else
				  Begin
					Set @sMsgTrc = 'PDF ' + CONVERT ( varchar ( 20 ), @iCptArch ) + ' déplacé avec succès vers ' + @sCmdDos
					Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'DEPPDF', 'OK', @sMsgTrc, @iIdLotTrc
				  End 
			End
		
		If @iContinue = 1 Continue

		-- Contrôle de l'adresse mail, sécurité pour la simulation.
		-- Si adresse différente de @spb, on l'efface.
		If @sServeurProduction = 'SIM'
			Begin
				Set @sAdrMail = Upper ( sysadm.FN_CLE_VAL_XML ( 'email', @sXmlData, 'NON' ) )
				If CHARINDEX ( '@SPB', @sAdrMail ) <= 0 
					Begin
						Exec sysadm.PS_S_SUBSTITUER_VARIABLE_XML  'email', '', @sXmlData output
					End 

				Set @sAdrMail = Upper ( sysadm.FN_CLE_VAL_XML ( 'Mail_Add_Dest', @sXmlData, 'NON' ) )
				If CHARINDEX ( '@SPB', @sAdrMail ) <= 0 
					Begin
						Exec sysadm.PS_S_SUBSTITUER_VARIABLE_XML  'Mail_Add_Dest', '', @sXmlData output
					End 

				Set @sAdrMail = Upper ( sysadm.FN_CLE_VAL_XML ( 'email_cc', @sXmlData, 'NON' ) )
				If CHARINDEX ( '@SPB', @sAdrMail ) <= 0 
					Begin
						Exec sysadm.PS_S_SUBSTITUER_VARIABLE_XML  'email_cc', '', @sXmlData output
					End 

			End 

		-- Transformation des variables du nom du fichier en données
		Set @sNomFichierDepot = REPLACE ( @sNomFichierDepot, '[id_sin]', CONVERT ( VarChar ( 10 ), @iIdSin ) )
		Set @sNomFichierDepot = REPLACE ( @sNomFichierDepot, '[id_seq_tb_mail_push]', CONVERT ( VarChar ( 20 ), @iIdSeq ) )
		Set @sNomFichierDepot = REPLACE ( @sNomFichierDepot, '[yyyyMMddHHmmss]', Replace ( convert ( varchar(10), GETDATE(), 112 ) + CONVERT (varchar(8), GETDATE(), 108), ':', '' ))

		Set @ChemEtNomDepot = @sChemDepot + @sNomFichierDepot

		Set @sMsgTrc = 'Traitement du mail dont l''id_seq est ' + CONVERT ( varchar ( 20 ), @iIdSeq )
		Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'MOTTRT', 'ENC', @sMsgTrc, @iIdLotTrc

		If @sChemDepot = ''
			Begin
				Set @sMsgTrc = 'Le chemin de dépôt n''est pas initialisé, contrôlez la déclaration du type de mail et de la maquette sur sysadm.code_maquette_ksl_rs5045 et sur sysadm.chem_depot_ksl_rs5045'
				Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'CONCHM', 'ERR', @sMsgTrc, @iIdLotTrc

				Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
				Continue
			End

		If @sNomFichierDepot = ''
			Begin
				Set @sMsgTrc = 'Le fichier de dépôt n''est pas initialisé, contrôlez la déclaration du type de mail et de la maquette sur sysadm.code_maquette_ksl_rs5045 et sur sysadm.chem_depot_ksl_rs5045'
				Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'CONCHM', 'ERR', @sMsgTrc, @iIdLotTrc

				Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
				Continue
			End

		If @dtDatehExec > Getdate() 
			Begin
				-- Ce n'est pas encore la date et l'heure pour traiter ce mail
	
				Set @sMsgTrc = 'Le mail ' + CONVERT ( varchar ( 20 ), @iIdSeq ) + ' à une date d''éxécution au ' + Convert ( VarChar ( 10), @dtDatehExec, 103 ) + ' à ' + CONVERT (varchar(8), @dtDatehExec, 108)+ ', il n''est donc pas traité sur ce traitement, il sera traité ultérieurement' 
				Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'MOTTRT', 'EXERET', @sMsgTrc, @iIdLotTrc

				Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
				Set @iCptTraite =  @iCptTraite + 1 -- Cas particulier, le décalage horaire n'est pas une erreur, on compte donc comme traité, même s'il sera représenté au prochain tour

				Continue
			End 

		Set @sMsgTrc = 'Construction du fichier XML à destination de KSL en cours...'
		Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'CONXML', 'ENC', @sMsgTrc, @iIdLotTrc

		Exec @iRet = sysadm.PS_ECRIRE_UN_ENREGISTREMENT_ADODB_STREAM @iHandle, 2, 3, 'UTF-8', 10, @sXmlData

		If @iRet <> 0 
			Begin
				Set @sMsgTrc = 'Erreur lors de la construction du fichier XML, code erreur ' + CONVERT ( Varchar ( 20 ), @iRet ) + ', le fichier n''a pas été écrit !'
				Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'CONXML', 'ERR', @sMsgTrc, @iIdLotTrc

				Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
				Continue
			End 

		Set @sMsgTrc = 'Fichier XML construit avec succès'
		Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'CONXML', 'OK', @sMsgTrc, @iIdLotTrc 

		Set @sMsgTrc = 'Ecriture du fichier XML à destination de KSL en cours... (sur ' + @ChemEtNomDepot  + ')'
		Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'ECRXML', 'ENC', @sMsgTrc, @iIdLotTrc

		Exec @iRet = sysadm.PS_SAUVEGARDER_ET_FERMER_UN_FICHER_ADODB_STREAM @iHandle, @ChemEtNomDepot, 2

		If @iRet <> 0 
		  Begin
			Set @sMsgTrc = 'Erreur lors de l''écriture du fichier XML, code erreur ' + CONVERT ( Varchar ( 20 ), @iRet ) + ', le fichier n''a pas été écrit !'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'ECRXML', 'ERR', @sMsgTrc, @iIdLotTrc

			Update @TbWork Set marquage = 100 Where id_seq = @iIdSeq
			Continue
		  End 

		Set @sMsgTrc = 'Fichier XML écrit avec succès sur ' + @ChemEtNomDepot 
		Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'ECRXML', 'OK', @sMsgTrc, @iIdLotTrc

		Update sysadm.mail_push set 
			mail_dte_trt = GETDATE(),
			mail_trt_ok  = 'O'
		Where id_seq = @iIdSeq
	    Set @iRowCount = @@Rowcount
	
		If @iRowCount = 1 
		  Begin 
			Set @sMsgTrc = 'Le marquage du traitement de ce mail s''est effectué avec succès sur la table source sysadm.mail_push, champ mail_trt_ok et mail_dte_trt'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'MARTRT', 'OK', @sMsgTrc, @iIdLotTrc
		  End
		Else
		  Begin 
			Set @sMsgTrc = 'Le marquage du traitement de ce mail se termine en échec, ce mail n''est pas marqué, il sera donc traité de nouveau au prochain traitement'
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', @iIdSeq, 'MARTRT', 'ERR', @sMsgTrc, @iIdLotTrc
		  End

		Update @TbWork Set marquage = 2 Where id_seq = @iIdSeq
		Set @iCptTraite =  @iCptTraite + 1 
	 End 

 	------------------------------------------------------------------------------
	--------- FIN 3ème Moteur                                              --------
	------------------------------------------------------------------------------


------------------------------------------------------------------------------
--------- Destruction de l'objet OLE                                  --------
------------------------------------------------------------------------------
Exec @iRet = sysadm.PS_DETRUIRE_UN_OBJET_SQL_SERVER @iHandle

If @iRet = 0 
	Begin 
		Set @sMsgTrc = 'La destruction de l''objet SqlServer ADODB.Stream a été effectuée avec succès'
		Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'DESOBJ', 'OK', @sMsgTrc, @iIdLotTrc
	End
Else
	Begin 
		Set @sMsgTrc = 'La destruction de l''objet SqlServer ADODB.Stream se termine en échec'
		Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'DESOBJ', 'ERR', @sMsgTrc, @iIdLotTrc
	End

If @iRowCountWord + @iRowCountHWord  > 0
  Begin
	Set @sMsgTrc = 'Traitement de ' + Convert ( Varchar ( 20 ), @iCptTraite ) + ' mail(s) sur ' + Convert ( Varchar ( 20 ), @iRowCountWord + @iRowCountHWord ) + ' mail(s)'
	If @iCptTraite = @iRowCountWord + @iRowCountHWord 
		Begin	
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'INFO', 'OK', @sMsgTrc, @iIdLotTrc
		End 
	Else 
		Begin	
			Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'INFO', 'ERR', @sMsgTrc, @iIdLotTrc

			Set @sObjet = '[ERREUR] [Traitement MATP SQL C#] => Erreurs sur traitement Lot ' + CONVERT (VarChar ( 20), @iIdLotTrc ) + ', (' + Convert ( Varchar ( 20 ), @iCptTraite ) + '/' + Convert ( Varchar ( 20 ), @iRowCountWord + @iRowCountHWord ) + ')'
			If @sServeurProduction = 'SIM' Set @sObjet = '[RECETTE] - ' + @sObjet 

			Set @sObjet = Left ( @sObjet + space ( 255 ), 255 )
			Exec sysadm.PS_CASSER_REGLE_CHAINE @sObjet Output, '_', ' ' 

			Set @sMailBody = 'Bonjour ' + char (10)
			Set @sMailBody = @sMailBody + char (10)
			Set @sMailBody = @sMailBody + 'Serveur : ' + @@SERVERNAME + char (10)
			Set @sMailBody = @sMailBody + 'Environnement : ' 
				If @sServeurProduction = 'SIM' Set @sMailBody = @sMailBody + 'SIMULATION'
				If @sServeurProduction = 'PRO' Set @sMailBody = @sMailBody + 'PRODUCTION'
				Set @sMailBody = @sMailBody + char (10)

			Set @sMailBody = @sMailBody + 'base    : ' + DB_NAME () + char (10)
			Set @sMailBody = @sMailBody + char (10)
			Set @sMailBody = @sMailBody + 'Le lot de traitement ' + CONVERT (VarChar ( 20), @iIdLotTrc ) + ' contient des erreurs, traitement de ' + Convert ( Varchar ( 20 ), @iCptTraite ) + ' mail(s) sur ' + Convert ( Varchar ( 20 ), @iRowCountWord + @iRowCountHWord ) + ' mail(s).' + char (10)
			Set @sMailBody = @sMailBody + CHAR ( 10 )
			Set @sMailBody = @sMailBody + 'Consultez la trace du traitement avec ces 4 Select pour voir depuis quand le problème se produit ' + CHAR ( 10 )
			Set @sMailBody = @sMailBody + '  Select * from ' + DB_NAME () + '.sysadm.trace_matp_es_sinistre_ksl_rs5045 where id_lot_trc = '+ CONVERT (VarChar ( 20), @iIdLotTrc ) + ' order by 1' + CHAR ( 10 ) 
			Set @sMailBody = @sMailBody + '  Select * from ' + DB_NAME () + '.sysadm.trace_matp_es_sinistre_ksl_rs5045 where id_lot_trc = '+ CONVERT (VarChar ( 20), @iIdLotTrc ) + ' and cod_etat = ''ERR'' order by 1' + CHAR ( 10 ) 
			Set @sMailBody = @sMailBody + '  Select * from ' + DB_NAME () + '.sysadm.trace_matp_es_sinistre_ksl_rs5045 where cod_etat = ''ERR'' and cree_le > ''' + @sDateHeureDebTrt + ''' order by 1' + CHAR ( 10 )
			Set @sMailBody = @sMailBody + '  Select * from ' + DB_NAME () + '.sysadm.trace_matp_es_sinistre_ksl_rs5045 where cree_le > ''' + @sDateHeureDebTrt + ''' order by 1 desc' + CHAR ( 10 )
			Set @sMailBody = @sMailBody + CHAR ( 10 )
			Set @sMailBody = @sMailBody + 'Aucun mail n''est perdu, ils sont en attente de traitement.' + CHAR ( 10 )
			Set @sMailBody = @sMailBody + 'L''alerte reviendra dans 20 minutes tant que le problème ne sera pas résolu.' + CHAR ( 10 )
			Set @sMailBody = @sMailBody + 'Le programme est fait de façon à résoudre seul certains problèmes, si l''alerte ne revient pas dans 20 minutes, le programme aura résolu le problème.' + CHAR ( 10 )
			Set @sMailBody = @sMailBody + CHAR ( 10 )
			Set @sMailBody = @sMailBody + 'A l''inverse, si l''erreur revient toutes les 20 minutes, voyez avec Nicolas (Lerberquier)' + CHAR ( 10 )
			Set @sMailBody = @sMailBody + 'En l''absence de Nicolas, voyez pourquoi le JOB du Scheduler Windows (j''ai bien dit Windows et pas SMA) dont le nom est "MATP SQL JFF_PROD" sur opcoex2k12 ne tourne pas normalement.' + CHAR ( 10 )
			Set @sMailBody = @sMailBody + 'Pour plus d''infos sur le process, lisez le fichier "C:\PB_OPCON\MATP ESvKSL\LISEZ_MOI.TXT" sur opcoex2k12 ' + CHAR ( 10 )
			Set @sMailBody = @sMailBody + CHAR ( 10 )
			Set @sMailBody = @sMailBody + CHAR ( 10 )	
			Set @sMailBody = @sMailBody + 'Cordialement,'
			Set @sMailBody = @sMailBody + CHAR ( 10 )
			Set @sMailBody = @sMailBody + CHAR ( 10 )
			Set @sMailBody = @sMailBody + 'Fabry Jean-François'
			Set @sMailBody = @sMailBody + CHAR ( 10 )
			Set @sMailBody = @sMailBody + 'DSI Team SIMPA2' + CHAR ( 10 )
			Set @sMailBody = @sMailBody + 'Legacy Application Tech Lead' + CHAR ( 10 )

			EXEC master.dbo.SPB_PS_MAIL 
					@sRetourErrMail OUTPUT, 
					@sDestinataire ,
					@sMailBody, 
					@sObjet, 
					null, 
					'', 
					@sFicOut, 
					NULL, 
					NULL, 
					NULL, 
					NULL


		End 

  End 

Set @sMsgTrc = 'Fin du traitement le ' + Convert ( VarChar ( 10), Getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) 
Exec sysadm.PS_RS5045_I_TRACE_MATP_ES_SINISTRE_KSL '', -1, 'FINTRT', 'OK', @sMsgTrc, @iIdLotTrc


Go

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_TRANSFORMATION_DES_CRLF_FORMAT_XML_UTF8
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_TRANSFORMATION_DES_CRLF_FORMAT_XML_UTF8' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_TRANSFORMATION_DES_CRLF_FORMAT_XML_UTF8
GO

CREATE procedure sysadm.PS_RS5045_TRANSFORMATION_DES_CRLF_FORMAT_XML_UTF8
	@asXmlData varchar(max) OUTPUT,
	@asSautActuel VarChar ( 50 )
AS

Declare @sSaut_XmlUTF8 VarChar ( 50 )

Set @sSaut_XmlUTF8 = '<br/>'

Set @asXmlData = REPLACE ( @asXmlData, @asSautActuel, @sSaut_XmlUTF8 )

Go

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_S_RECUPERER_LE_BLOB_COURRIER
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :        
-- Commentaires         :       Récupère le Blob (courrier) de la bonne base
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF		06/06/2025   [RS6130]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_S_RECUPERER_LE_BLOB_COURRIER' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_S_RECUPERER_LE_BLOB_COURRIER
GO

CREATE procedure sysadm.PS_RS5045_S_RECUPERER_LE_BLOB_COURRIER
	@aiIdAppliNum   integer,
	@iIdArch		integer,
	@blBlobCourrier VarBinary (max) OutPut
AS

Declare @iBlobId Integer -- [RS6130]

-- Production
If @@servername = master.dbo.SPB_FN_ServerName ('PRO')  
	Begin
		-- SIMPA2
		If @aiIdAppliNum = 2 
			Begin
				Select  @blBlobCourrier = wb.txt_blob    
				From SIMPA2_PRO.sysadm.w_cour_blob_arch wb  with (nolock)    
				Where wb.id_arch = @iIdArch    
  
				If @@RowCount = 1 Return @@Error  
    
				Select  @blBlobCourrier = ab.txt_blob    
				From SIMPA2_PRO.sysadm.archive a  with (nolock),    
					 SIMPA2_PRO.sysadm.archive_blob ab  with (nolock)    
				Where a.id_arch = @iIdArch    
				And   ab.id_sin = a.id_sin    
				And   ab.id_inter = a.id_inter    
				And   ab.id_doc = a.id_doc    
   
				If @@RowCount = 1 Return @@Error  
 
		
				-- Uniquement en production !
				 Select @blBlobCourrier = ab.txt_blob    
				 From SIMPA2_PRO.sysadm.archive a  with (nolock),    
					  SIMPA2BLOB_PRO.sysadm.archive_blob2 ab  with (nolock)    
				 Where a.id_arch = @iIdArch    
				 And   ab.id_sin = a.id_sin    
				 And   ab.id_inter = a.id_inter    
				 And   ab.id_doc = a.id_doc    
  
				If @@RowCount = 1 Return @@Error  

  
				-- Uniquement en production !
				 Select  ab.txt_blob    
				 From SIMPA2_PRO.sysadm.archive a  with (nolock),    
					  SIMPA2BLOB_PRO.sysadm.archive_blob ab  with (nolock)    
				 Where a.id_arch = @iIdArch    
				 And     ab.id_sin = a.id_sin    
				 And     ab.id_inter = a.id_inter    
				 And     ab.id_doc = a.id_doc    
  
				Return @@Error    
			End

		-- PEGASE [RS6130]
		If @aiIdAppliNum = 3 
			Begin

				Select  @blBlobCourrier = wb.txt_blob    
				From PEGASE_PRO.sysadm.w_cour_blob_arch wb  with (nolock)    
				Where wb.id_arch2 = @iIdArch    

				If @@RowCount = 1 Return @@Error  

				Select @iBlobId = a.blob_id
				From PEGASE_PRO.sysadm.archive a
				Where a.id_arch2 = @iIdArch

				If @iBlobId is null OR @iBlobId <= 0 Return -1

				Select @blBlobCourrier = data 
				From [LS-SAGA2].SAGA2_BLOB.dbo.document doc with (nolock) 
				where doc.code = @iBlobId

				If @@RowCount = 1 Return @@Error  

			End 

	End 

-- Simulation
Else
	Begin
		-- SIMPA2
		If @aiIdAppliNum = 2 
			Begin
				Select  @blBlobCourrier = wb.txt_blob    
				From SIMPA2_TRT.sysadm.w_cour_blob_arch wb  with (nolock)    
				Where wb.id_arch = @iIdArch    
  
				If @@RowCount = 1 Return @@Error  
    
				Select  @blBlobCourrier = ab.txt_blob    
				From SIMPA2_TRT.sysadm.archive a  with (nolock),    
					 SIMPA2_TRT.sysadm.archive_blob ab  with (nolock)    
				Where a.id_arch = @iIdArch    
				And   ab.id_sin = a.id_sin
				And   ab.id_inter = a.id_inter
				And   ab.id_doc = a.id_doc
 
				Return @@Error    
			End

		-- PEGASE [RS6130]
		If @aiIdAppliNum = 3 
			Begin

				Select  @blBlobCourrier = wb.txt_blob    
				From PEGASE_TRT.sysadm.w_cour_blob_arch wb  with (nolock)    
				Where wb.id_arch2 = @iIdArch    

				If @@RowCount = 1 Return @@Error  

				-- Pas d'alternative à SAGA2_BLOB en simulation

			End 


	End 

Return -1

Go

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_S_PRE_ARMEMENT_TECHNIQUE
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :        
-- Commentaires         :       Pré-arme certaines variables (non xml) pour l'insertion dans sysadm.mailpush
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_S_PRE_ARMEMENT_TECHNIQUE' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_S_PRE_ARMEMENT_TECHNIQUE
GO

CREATE procedure sysadm.PS_RS5045_S_PRE_ARMEMENT_TECHNIQUE
	@aiIdAppli	Integer,    -- Obligatoire
	@aiIdSin	Integer,    -- Obligatoire
	@asIdAppli  VarChar ( 10 ) OutPut,
	@aiIdProd	Integer OutPut,
	@asLibProd  VarChar ( 255 ) OutPut,
	@aiIdEts    Integer OutPut,
    @asMailFrom	VarChar (128) OUTPUT,  -- ''
    @asBoiteMail    VarChar (35) OUTPUT -- ''

AS

Declare @dcIdSin Decimal ( 10 ) 

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN

	Set @asIdAppli = Upper ( SHERPA_PRO.sysadm.FN_CODE_NUM (@aiIdAppli, '-AP'))
	If  @asIdAppli = 'SIMPA' Set @asIdAppli = 'SIMPA2'
	Set @asIdAppli = LTRIM ( Rtrim ( @asIdAppli ))

	If @aiIdAppli = 2  -- SIMPA2
	  Begin
		Set @dcIdSin = Convert ( Decimal ( 10 ), @aiIdSin )

		Select	@aiIdProd = Convert ( integer, ws.id_prod ),
				@asLibProd = SIMPA2_PRO.sysadm.FN_LIB_PROD ( ws.id_prod ),
			    @aiIdEts = Convert ( integer, ws.id_ets),
				@asMailFrom = '',
				@asBoiteMail = ''
		From SIMPA2_PRO.sysadm.w_sin ws
		Where ws.id_sin = @dcIdSin

		If @aiIdProd is null 
		  Begin
			Set @dcIdSin = Convert ( Decimal ( 10 ), @aiIdSin )

			Select	@aiIdProd = Convert ( integer, ws.id_prod ),
					@asLibProd = SIMPA2_PRO.sysadm.FN_LIB_PROD ( ws.id_prod ),
					@aiIdEts = Convert ( integer, ws.id_ets),
					@asMailFrom = '',
					@asBoiteMail = ''
			From SIMPA2_PRO.sysadm.sinistre ws
			Where ws.id_sin = @dcIdSin
		  End 
	  End 

	If @aiIdAppli = 3 -- PEGASE 
	  Begin
		Select	@aiIdProd = ws.id_prod,
				@asLibProd = p.lib_long,
			    @aiIdEts = ws.id_ets,
				@asMailFrom = '',
				@asBoiteMail = ''
		From PEGASE_PRO.sysadm.w_sin ws,
			 PEGASE_PRO.sysadm.produit p
		Where ws.id_sin = @aiIdSin
		And  p.id_prod = ws.id_prod

		If @aiIdProd is null 
		  Begin
			Select	@aiIdProd = ws.id_prod,
					@asLibProd = p.lib_long,
					@aiIdEts = ws.id_ets,
					@asMailFrom = '',
					@asBoiteMail = ''
			From PEGASE_PRO.sysadm.sinistre ws,
				 PEGASE_PRO.sysadm.produit p
			Where ws.id_sin = @aiIdSin
			And  p.id_prod = ws.id_prod
		  End 
	  End 
End 
Else
BEGIN

	Set @asIdAppli = Upper ( SHERPA_SIM.sysadm.FN_CODE_NUM (@aiIdAppli, '-AP'))
	If  @asIdAppli = 'SIMPA' Set @asIdAppli = 'SIMPA2'
	Set @asIdAppli = LTRIM ( Rtrim ( @asIdAppli ))

	If @aiIdAppli = 2  -- SIMPA2
	  Begin
		Set @dcIdSin = Convert ( Decimal ( 10 ), @aiIdSin )

		Select	@aiIdProd = Convert ( integer, ws.id_prod ),
				@asLibProd = SIMPA2_TRT.sysadm.FN_LIB_PROD ( ws.id_prod ),
			    @aiIdEts = Convert ( integer, ws.id_ets),
				@asMailFrom = '',
				@asBoiteMail = ''
		From SIMPA2_TRT.sysadm.w_sin ws
		Where ws.id_sin = @dcIdSin

		If @aiIdProd is null 
		  Begin
			Set @dcIdSin = Convert ( Decimal ( 10 ), @aiIdSin )

			Select	@aiIdProd = Convert ( integer, ws.id_prod ),
					@asLibProd = SIMPA2_TRT.sysadm.FN_LIB_PROD ( ws.id_prod ),
					@aiIdEts = Convert ( integer, ws.id_ets),
					@asMailFrom = '',
					@asBoiteMail = ''
			From SIMPA2_TRT.sysadm.sinistre ws
			Where ws.id_sin = @dcIdSin
		  End 
	  End 

	If @aiIdAppli = 3 -- PEGASE 
	  Begin
		Select	@aiIdProd = ws.id_prod,
				@asLibProd = p.lib_long,
			    @aiIdEts = ws.id_ets,
				@asMailFrom = '',
				@asBoiteMail = ''
		From PEGASE_TRT.sysadm.w_sin ws,
			 PEGASE_TRT.sysadm.produit p
		Where ws.id_sin = @aiIdSin
		And  p.id_prod = ws.id_prod

		If @aiIdProd is null 
		  Begin
			Select	@aiIdProd = ws.id_prod,
					@asLibProd = p.lib_long,
					@aiIdEts = ws.id_ets,
					@asMailFrom = '',
					@asBoiteMail = ''
			From PEGASE_TRT.sysadm.sinistre ws,
				 PEGASE_TRT.sysadm.produit p
			Where ws.id_sin = @aiIdSin
			And  p.id_prod = ws.id_prod
		  End 
	  End 
End 


Go

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_U_MAJ_XML_PIECES_JOINTES_APRES_CREATION_XML
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :        
-- Commentaires         :       Met à jour l'XML après création avec l'identity de l'enregistrement du mail (id_seq_mail)
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- 19/06/2024	JFF		Pour écraser tout de même le 'XX' qui gêne KSL
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_U_MAJ_XML_PIECES_JOINTES_APRES_CREATION_XML' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_U_MAJ_XML_PIECES_JOINTES_APRES_CREATION_XML
GO

CREATE procedure sysadm.PS_RS5045_U_MAJ_XML_PIECES_JOINTES_APRES_CREATION_XML
	@aiIdSeqMail		Integer,  
	@aiIdSin			Integer,  
	@asIdArchComplSeria VarChar ( 255 ),
	@asTypMail			VarChar ( 10 ),
	@aiIdChemin			Integer -- Force le chemin, dans ce cas, il n'est pas pris du défaut de @asTypMail
AS

Declare @iCptArch Integer
Declare @sIdArchComplWk VarChar ( 255 )
Declare @sXmlData VarChar ( max )
Declare @sCheminEtFichierComplet VarChar ( 255 )
Declare @sChemin VarChar ( 255 )
Declare @sServeur VarChar( 5 ) 

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO' Set @sServeur = 'PRO' Else Set @sServeur  = 'SIM'

If @aiIdChemin is null 
	Begin
		Select Top 1 @aiIdChemin = id_chemin 
		From sysadm.code_maquette_ksl_rs5045
		Where typ_mail = @asTypMail
		And   id_cpt = 1
	End 

Select @sChemin = 
			Case @sServeur 
			   When 'PRO' Then ch.chemin_pro
			   Else ch.chemin_sim
		    End
From   sysadm.chem_depot_ksl_rs5045 ch
Where  ch.id_chemin = @aiIdChemin


Select  @sXmlData = mp.xml_data + IsNull ( mp.xml_data2, '')
From	sysadm.mail_push mp
Where   mp.id_seq = @aiIdSeqMail


Set @iCptArch = 2 -- [RS6044_REL_MAIL] la 1 étant réservée, la chaine sérialisée des pièces jointes commence à 2
Set @sCheminEtFichierComplet = ''

While 0=0 -- [RS6044_REL_MAIL]
	Begin
		Set @sIdArchComplWk = sysadm.FN_CLE_VAL ( 'ID_ARCH_CPL_' + CONVERT ( varchar ( 20 ), @iCptArch), @asIdArchComplSeria, ';' ) 
--		If @sIdArchComplWk is null OR ltrim ( rtrim ( @sIdArchComplWk )) = '' Break

		If @sIdArchComplWk is null OR ltrim ( rtrim ( @sIdArchComplWk )) = '' 
			Begin
				-- Pour écraser tout de même le 'XX' qui gêne KSL
				Set @sXmlData = sysadm.FN_CLE_VAL_XML_SUBST ( 'PJ' + CONVERT ( varchar ( 20 ), @iCptArch), '', @sXmlData ) 
				Break
			End 

		Set @sCheminEtFichierComplet = 
				@sChemin + CONVERT ( Varchar (20 ) , @aiIdSeqMail ) + '_' + 
				CONVERT ( Varchar (20 ) , @aiIdSin) + '_' + 
				CONVERT( VarChar ( 10), @iCptArch ) +  '.PDF'

		Set @sXmlData = sysadm.FN_CLE_VAL_XML_SUBST ( 'PJ' + CONVERT ( varchar ( 20 ), @iCptArch), @sCheminEtFichierComplet, @sXmlData ) 
		Set @iCptArch = @iCptArch + 1

	End

Update sysadm.mail_push
Set xml_data = Left ( @sXmlData, 2000), 
	xml_data2 = Substring ( @sXmlData, 2001, Len ( @sXmlData ) )
Where id_seq = @aiIdSeqMail

Go

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_I_MAIL_ARCHIVE_CONTACT_SHERPA
-- Auteur               :       Fabry JF
-- Date                 :       05/12/2023
-- Libelle              :       [RS6212_ARCH_MPUSH]
-- Commentaires         :       Archive un lien vers ce mail dans SHERPA
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_I_MAIL_ARCHIVE_CONTACT_SHERPA' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_I_MAIL_ARCHIVE_CONTACT_SHERPA
GO

CREATE procedure sysadm.PS_RS5045_I_MAIL_ARCHIVE_CONTACT_SHERPA
	@aiIdSeqMail	Integer
AS 

Declare @iIdSin	integer
Declare @iIdCli	integer
Declare @idTypMail	Varchar (6)
Declare @sLibTypMail VarChar (35)
Declare @iIdAppli integer
Declare @dtCreele DateTime
Declare @sAdrMail VarChar ( 128)
Declare @iIdContact	Integer 
Declare @aiIdArch Integer 

Set @iIdCli = null

-- Obtention des données utiles
If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin
		Select @iIdSin = mp.id_sin,
			   @idTypMail = mp.typ_mail,
			   @sLibTypMail = cc.lib_code,
			   @iIdAppli = mp.id_appli_num,
			   @dtCreele = mp.cree_le,
			   @sAdrMail = mp.mail_send
		From TRACE_MAIL_PRO.sysadm.mail_push mp,
			 TRACE_MAIL_PRO.sysadm.code_car cc
		Where mp.id_seq = @aiIdSeqMail
		And  cc.id_typ_code = '-TM'
		And  cc.id_code = mp.typ_mail


		-- Appel PS sur SHERPA directement
		Exec SHERPA_PRO.sysadm.PS_I_MAIL_ARCHIVE_CONTACT_SHERPA
				@aiIdSeqMail,
				@iIdSin,
				@idTypMail,
				@sLibTypMail,
				@iIdAppli,
				@dtCreele,
				@sAdrMail,
				@iIdContact Output,
				@aiIdArch Output

	End 
Else 
	Begin
		Select @iIdSin = mp.id_sin,
			   @idTypMail = mp.typ_mail,
			   @sLibTypMail = cc.lib_code,
			   @iIdAppli = mp.id_appli_num,
			   @dtCreele = mp.cree_le,
			   @sAdrMail = mp.mail_send
		From TRACE_MAIL_TRT.sysadm.mail_push mp,
			 TRACE_MAIL_TRT.sysadm.code_car cc
		Where mp.id_seq = @aiIdSeqMail
		And  cc.id_typ_code = '-TM'
		And  cc.id_code = mp.typ_mail


		-- Appel PS sur SHERPA directement
		Exec SHERPA_SIM.sysadm.PS_I_MAIL_ARCHIVE_CONTACT_SHERPA
				@aiIdSeqMail,
				@iIdSin,
				@idTypMail,
				@sLibTypMail,
				@iIdAppli,
				@dtCreele,
				@sAdrMail,
				@iIdContact Output,
				@aiIdArch Output
	End 

Go


--------------------------------------------------------------------
--
-- Procedure            :       sysadm.TR_IU_CODE_MAQUETTE_KSL_RS5045
-- Auteur               :       Fabry JF
-- Date                 :       02/01/2025
-- Libelle              :       
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_IU_CODE_MAQUETTE_KSL_RS5045' AND xtype = 'TR' )
        DROP TRIGGER sysadm.TR_IU_CODE_MAQUETTE_KSL_RS5045
GO

CREATE Trigger sysadm.TR_IU_CODE_MAQUETTE_KSL_RS5045
	on [sysadm].[code_maquette_ksl_rs5045]
For Insert, Update
As

DECLARE @DBID INT
DECLARE @DBNAME NVARCHAR(128)

SET @DBID = DB_ID()
SET @DBNAME = DB_NAME()

If Not Exists ( 
	Select Top 1 1 
	From inserted i,
			sysadm.code_car cc
	Where cc.id_typ_code = '-TM'
	And   cc.id_code = i.typ_mail
)
Begin
	RAISERROR ('Déclarez d''abord les typ_mail sur sysadm.code_car, id_typ_code ''-TM''.', 16, 1, @DBID, @DBNAME)
	Rollback Tran
End 

Go

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_U_AJOUT_TABL_PCES_XML
-- Auteur               :       Fabry JF
-- Date                 :       09/01/2025
-- Libelle              :        
-- Commentaires         :       [MIG1_COUR_EMAILING]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-- JFF      18/09/2023   [RS5875_DIF_DIV_DET]
-- JFF      05/08/2024   [MCO602_PNEU]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_RS5045_U_AJOUT_TABL_PCES_XML' AND type = 'P' )
        DROP procedure sysadm.PS_RS5045_U_AJOUT_TABL_PCES_XML
GO

CREATE procedure sysadm.PS_RS5045_U_AJOUT_TABL_PCES_XML
	@iIdXml integer,
	@sCodeMaquette varchar ( 255 ), 
	@dcIdSin Decimal ( 10 ),
	@iIdAppliNum Integer,
	@xmlResult varchar(max) OUTPUT
AS

Declare @xmlTabPce VarChar ( 2000 ) 

-- Uniquement pour SIMPA2&PEGASE
If @iIdAppliNum Not in ( 2, 3 ) Return

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	If @iIdAppliNum = 2 
		Begin
			Select @xmlTabPce = 
					(
					Select id_pce as 't1lig/@col1'
					from SIMPA2_PRO.sysadm.w_piece 
					where id_sin = @dcIdSin
					For xml path ( '' )
					)
		End 

	If @iIdAppliNum = 3
		Begin
			Select @xmlTabPce = 
					(
					Select id_pce as 't1lig/@col1'
					from PEGASE_PRO.sysadm.w_piece 
					where id_sin = @dcIdSin
					For xml path ( '' )
					)
		End 
END 
Else 
BEGIN
	If @iIdAppliNum = 2 
		Begin
			Select @xmlTabPce = 
					(
					Select id_pce as 't1lig/@col1'
					from SIMPA2_TRT.sysadm.w_piece 
					where id_sin = @dcIdSin
					For xml path ( '' )
					)
		End 

	If @iIdAppliNum = 3
		Begin
			Select @xmlTabPce = 
					(
					Select id_pce as 't1lig/@col1'
					from PEGASE_TRT.sysadm.w_piece 
					where id_sin = @dcIdSin
					For xml path ( '' )
					)
		End 
END 



IF @xmlTabPce is null Return

Set @xmlResult = Replace ( @xmlResult, '<T1></T1>', '<T1>' + @xmlTabPce + '</T1>' ) 

Update sysadm.variable_xml_ksl_rs5045
Set xml_data=@xmlResult
Where id_xml = @iIdXml

Go

