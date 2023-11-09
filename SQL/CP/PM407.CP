-------------------------------------------------------------------
--
-- Fichier              :       PM407.CP
-- Auteur               :       FABRY JF
-- Date                 :       24/01/2018
--								[PM407-1]
-- Commentaires         :       
--
-------------------------------------------------------------------
-- sysadm.PS_S_PM407_CONSULT_KSL
-- sysadm.PS_U_PM407_MARQUAGE_RELANCE
-- sysadm.PS_S_PM407_NOUVEAU_SYSTEME
-- sysadm.PS_S_PM407_RELANCE_PRODUIT
-- sysadm.PS_S_PM407_RELANCE_TRAITEMENT
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_PM407_RELANCE_TRAITEMENT
-- Auteur               :       JFF
-- Date                 :       24/01/2018
-- Libelle              :       
-- Commentaires         :       [PM407-1]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      13/10/2023   [RS6005]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM407_RELANCE_TRAITEMENT' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM407_RELANCE_TRAITEMENT
GO

CREATE procedure sysadm.PS_S_PM407_RELANCE_TRAITEMENT
As

-- [RS6005]
Return 


Set NoCount On

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_prod	decimal (7 ),
	  id_ctg	varchar (6),
	  val_car   varchar ( 500 ),
	  cpt_tri   integer,
	  marquage	integer null 
	)

Declare @dcIdProd decimal (7 )
Declare @sIdCtg   varchar ( 6 )
Declare @iCptTri  integer
Declare @iIdSeq   integer
declare @sValCar  VarChar ( 500 )

Insert into @tb
select dp.id_prod,
	   dp.id_code_car,
	   rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ),
	   dp.tri,
	   0 'marquage'
from	sysadm.det_pro dp
where	dp.id_code_dp = 323
And     dp.id_code_car = 'RELANC'
Order by id_prod, tri

Set @iIdSeq = 1 

Delete from sysadm.w_cour_xml_orangev3

While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@dcIdProd = id_prod,
		@sValCar = val_car
	From	@tb
	Where	marquage = 0
	And		id_seq = @iIdSeq

	Exec sysadm.PS_S_PM407_RELANCE_PRODUIT @dcIdProd, @sValCar

	Update @tb Set marquage = 1 Where id_seq = @iIdSeq
	Set @iIdSeq = @iIdSeq + 1
 End

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select	Distinct
		no_dossier_sinistre,
		id_inter,
		id_doc,
		numero_relance,
		joindre_courrier_orig,
		id_arch_orig,
		env_en_recommande,
		derniere_relance,
		env_par_mail,
		xml_data 
From sysadm.w_cour_xml_orangev3

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S_PM407_RELANCE_PRODUIT
-- Auteur               :       JFF
-- Date                 :       24/01/2018
-- Libelle              :       
-- Commentaires         :       [PM407-1]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      06/11/2018   [PM451-1]
-- JFF      08/04/2019   [PM407-1][20190408]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM407_RELANCE_PRODUIT' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM407_RELANCE_PRODUIT
GO

CREATE procedure sysadm.PS_S_PM407_RELANCE_PRODUIT
	  @adcIdProd       Decimal (7,0),
      @asValCar		  VarChar ( 500 )
As

Set NoCount On

Declare @iIdRel Integer
Declare @iDelRel1Min Integer
Declare @iDelRel1Max Integer
Declare @iDelRel2 Integer
Declare @dtDate1Min DateTime
Declare @dtDate1Max DateTime
Declare @dtDate2 DateTime
Declare @dtDteMEp DateTime

Set @iIdRel = Convert ( integer, sysadm.FN_CLE_VAL ( 'ID_REL', @asValCar, ';' ))
Set @iDelRel1Min = Convert ( integer, sysadm.FN_CLE_VAL ( 'DEL_REL_MIN', @asValCar, ';' ))
Set @iDelRel1Max = Convert ( integer, sysadm.FN_CLE_VAL ( 'DEL_REL_MAX', @asValCar, ';' ))
Set @iDelRel2 = Convert ( integer, sysadm.FN_CLE_VAL ( 'DEL_REL', @asValCar, ';' ))

Set @dtDate1Min = Case sysadm.FN_CLE_VAL ( 'UNITE_DEL', @asValCar, ';' )
					When 'J' Then DateAdd ( day, @iDelRel1Max * (-1), Getdate() )
					When 'M' Then DateAdd ( month, @iDelRel1Max * (-1), Getdate() )
				 End

Set @dtDate1Max = Case sysadm.FN_CLE_VAL ( 'UNITE_DEL', @asValCar, ';' )
					When 'J' Then DateAdd ( day, @iDelRel1Min * (-1), Getdate() )
					When 'M' Then DateAdd ( month, @iDelRel1Min * (-1), Getdate() )
				 End

Set @dtDate2 = Case sysadm.FN_CLE_VAL ( 'UNITE_DEL', @asValCar, ';' )
					When 'J' Then DateAdd ( day, @iDelRel2 * (-1), Getdate() )
					When 'M' Then DateAdd ( month, @iDelRel2 * (-1), Getdate() )
				 End

-- Récupération de la date de MEP
Select @dtDteMEp = sysadm.FN_CLE_VAL ( 'DTE_MEP', rtrim ( val_car ) + rtrim ( val_car2), ';' )
From   sysadm.det_pro dp
Where  dp.id_prod = @adcIdProd
And    dp.id_code_dp = 323
And    dp.id_code_car = '-1'

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	-- Relance normales Assuré
	Insert into sysadm.w_cour_xml_orangev3 (
		  no_dossier_sinistre,
		  civilite_courte,
		  civilite_longue,
		  nom,
		  prenom,
		  adresse1,
		  adresse2,
		  code_postal,
		  ville,
		  code_produit_sinistre,
		  nom_produit,
		  lib_opt_produit,
		  no_tel_spb,
		  no_fax_spb,
		  assureur,
		  no_police,
		  no_ligne_assuree,
		  cout_telephonique,
		  date_de_declaration,
		  code_operateur,
		  code_maquette,
		  adr_mail,
		  numero_relance,
		  joindre_courrier_orig,
		  id_arch_orig,
		  env_en_recommande,
		  derniere_relance,
		  date_cour_orig,
		  date_dern_rel,
		  categorie_relance,
		  id_inter, 
		  id_doc,
		  env_par_mail
		  )
	Select	
		s.id_sin, 
		sysadm.FN_CODE_NUM(pers.cod_civ,'-CI') as civilite, 
		Case 
			When pers.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
			Else sysadm.FN_CODE_NUM(pers.cod_civ,'-CL') 
		End as civilite_longue,
		pers.nom,
		pers.prenom,
		pers.adr_1, 
		pers.adr_2, 
		Case pers.adr_cp When '00000' then '' Else pers.adr_cp End as adr_cp, 
		pers.adr_ville,
		p.id_prod,
		(select rtrim(dp66.val_car) 
		 from sysadm.det_pro dp66 
		 where dp66.id_prod=s.id_prod 
		   and dp66.id_code_dp=66) as lib_produit_assure,
		(select rtrim(dp67.val_car) 
		 from sysadm.det_pro dp67 
		 where dp67.id_prod=s.id_prod 
		   and dp67.id_code_dp=67) as lib_option_produit,
		p.num_tel as num_tel_produit,
		p.num_fax,
		rtrim ( sysadm.FN_LIB_CIE (s.id_sin)) as lib_compagnie,
		rtrim ( sysadm.FN_LIB_POLICE (s.id_sin)) as lib_police,
		s.num_port as num_tel_assure,
		(select rtrim(dp70.val_car) 
		 from sysadm.det_pro dp70 
		 where dp70.id_prod=s.id_prod 
		   and dp70.id_code_dp=70) as cout_telephonique,
		convert(varchar(10),s.dte_decl,20) as dte_decl,
		rtrim ( s.maj_par ) as code_operateur,
		'RELANCE_' + 
			Case 
				When sysadm.FN_CLE_VAL ( 'DERN_REL', @asValCar, ';' ) = 'OUI' 
					Then 'DER'
				Else convert ( varchar ,@iIdRel )
			End as code_maquette,
		Case 
			When sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) = 'OUI' Then ''
			When sysadm.FN_CLE_VAL ( 'ENV_MAIL', @asValCar, ';' ) <> 'OUI' Then ''
			Else rtrim ( i.adr_mail )
		End 'adr_mail',
		convert ( varchar ,@iIdRel ) 'numero_relance',
		Case @iIdRel
			When 1 Then sysadm.FN_CLE_VAL ( 'JOINDRE_ORIG', @asValCar, ';' )
			Else Case 
					When isnumeric ( sysadm.FN_CLE_VAL ( 'ID_ARCH_ORIG', a.txt_compo2, ';') ) > 0 
						Then sysadm.FN_CLE_VAL ( 'JOINDRE_ORIG', @asValCar, ';' )
					Else 'NON'
				 End 
		End 'joindre_courrier_orig',
		Case @iIdRel
			When 1 Then Convert ( varchar, a.id_arch )
			Else Isnull ( nullif ( sysadm.FN_CLE_VAL ( 'ID_ARCH_ORIG', a.txt_compo2, ';'), '' ), '0' )
		End 'id_arch_orig',
		sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) 'env_en_recommande',
		sysadm.FN_CLE_VAL ( 'DERN_REL', @asValCar, ';' ) 'derniere_relance',
		Case @iIdRel
			When 1 Then Convert ( varchar, a.dte_edit, 103 )
			Else sysadm.FN_CLE_VAL ( 'DTE_EDIT_ORIG', a.txt_compo2, ';') 
		End 'date_cour_orig',
		Case @iIdRel
			When 1 Then ''
			Else Convert ( varchar, a.dte_edit, 103 )
		End 'date_dern_rel',
		'RELANCE_ASSURE' 'categorie_relance',
		a.id_inter,
		a.id_doc,
		Case 
			When sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) = 'OUI' Then 'NON'
			When ( rtrim ( i.adr_mail ) = '' Or i.adr_mail is null ) Then 'NON'
			Else sysadm.FN_CLE_VAL ( 'ENV_MAIL', @asValCar, ';' )
		End 'env_par_mail'
	  
	From	sysadm.archive a,
			sysadm.routage r,
			sysadm.sinistre s,
			sysadm.personne pers,
			sysadm.produit p,
			sysadm.inter i
	Where   a.id_prod = @adcIdProd
	And     ( 
				(
					( Substring ( a.id_cour_orig, 2, 1 ) = 'C' and Substring ( a.id_cour_orig, 4, 1 ) = 'P' Or Substring ( a.id_cour_orig, 1, 1 ) = 'Q' )
					And 
					@iIdRel = 1
					And a.valide_le between @dtDate1Min and @dtDate1Max
					and s.valide_le = a.valide_le
					and CharIndex ( 'P001', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P118', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P119', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P037', a.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P107', a.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P120', a.txt_compo1, 1 ) = 0   
					And Not Exists (
						Select Top 1 1 
						From sysadm.archive a1
						Where a1.id_sin = a.id_sin
						And   a1.id_inter = a.id_inter
						And   ( a1.id_cour_orig = rtrim ( a1.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 )
								Or 
								a1.id_cour_orig = rtrim ( a1.cod_inter ) + 'LQ0' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 )
							  )
					)

				) 
				Or
				(
					( Substring ( a.id_cour_orig, 2, 5 ) = 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel - 1), 2 )
					  Or 
					  a.id_cour_orig = 'ALQ0' + Right ( '00' + Convert ( varchar, @iIdRel - 1), 2 )
					)
					And 
					@iIdRel > 1
					And 
					a.maj_le <= @dtDate2
					And
					a.maj_le > @dtDteMEp -- MEP
					And -- [PM407-1][20190408]
					sysadm.FN_CLE_VAL ( 'TRT_PAR', a.txt_compo2, ';') = 'KSL'
					And Not Exists (
						Select Top 1 1 
						From sysadm.archive a1
						Where a1.id_sin = a.id_sin
						And   a1.id_inter = a.id_inter
						And   a1.id_cour_orig = rtrim ( a.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 )
					)
					and s.valide_le = a.valide_le 
				) 
			)
	And		a.nbr_conf = 0
	And 	a.cod_inter='A'
	And		r.id_sin = a.id_sin
	And		r.alt_queue = 'N'
	And		s.id_sin = a.id_sin
	and    	s.cod_etat in ( 100, 550 )
	And		pers.id_ordre = s.id_ordre
	And		p.id_prod = s.id_prod
	And     i.id_sin = a.id_sin
	And     i.cod_inter = a.cod_inter


	-- Relance UF Banque
	Insert into sysadm.w_cour_xml_orangev3 (
		  no_dossier_sinistre,
		  civilite_courte,
		  civilite_longue,
		  nom,
		  prenom,
		  adresse1,
		  adresse2,
		  code_postal,
		  ville,
		  code_produit_sinistre,
		  nom_produit,
		  lib_opt_produit,
		  no_tel_spb,
		  no_fax_spb,
		  assureur,
		  no_police,
		  no_ligne_assuree,
		  cout_telephonique,
		  date_de_declaration,
		  code_operateur,
		  code_maquette,
		  adr_mail,
		  numero_relance,
		  joindre_courrier_orig,
		  id_arch_orig,
		  env_en_recommande,
		  derniere_relance,
		  date_cour_orig,
		  date_dern_rel,
		  categorie_relance,
		  id_inter,
		  id_doc,
		  env_par_mail
		  )
	Select	
		s.id_sin, 
		'Messieurs' as civilite, 
		'Messieurs' civilite_longue,
		i.nom,
		'',
		i.adr_1, 
		i.adr_2, 
		Case pers.adr_cp When '00000' then '' Else i.adr_cp End as adr_cp, 
		i.adr_ville,
		p.id_prod,
		(select rtrim(dp66.val_car) 
		 from sysadm.det_pro dp66 
		 where dp66.id_prod=s.id_prod 
		   and dp66.id_code_dp=66) as lib_produit_assure,
		(select rtrim(dp67.val_car) 
		 from sysadm.det_pro dp67 
		 where dp67.id_prod=s.id_prod 
		   and dp67.id_code_dp=67) as lib_option_produit,
		p.num_tel as num_tel_produit,
		p.num_fax,
		rtrim ( sysadm.FN_LIB_CIE (s.id_sin)) as lib_compagnie,
		rtrim ( sysadm.FN_LIB_POLICE (s.id_sin)) as lib_police,
		s.num_port as num_tel_assure,
		(select rtrim(dp70.val_car) 
		 from sysadm.det_pro dp70 
		 where dp70.id_prod=s.id_prod 
		   and dp70.id_code_dp=70) as cout_telephonique,
		convert(varchar(10),s.dte_decl,20) as dte_decl,
		rtrim ( s.maj_par ) as code_operateur,
		'RELANCE_' + 
			Case 
				When sysadm.FN_CLE_VAL ( 'DERN_REL', @asValCar, ';' ) = 'OUI' 
					Then 'DER'
				Else convert ( varchar ,@iIdRel )
			End as code_maquette,
		Case 
			When sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) = 'OUI' Then ''
			When sysadm.FN_CLE_VAL ( 'ENV_MAIL', @asValCar, ';' ) <> 'OUI' Then ''
			Else rtrim ( i.adr_mail )
		End 'adr_mail',
		convert ( varchar ,@iIdRel ) 'numero_relance',
		Case @iIdRel
			When 1 Then sysadm.FN_CLE_VAL ( 'JOINDRE_ORIG', @asValCar, ';' )
			Else Case 
					When isnumeric ( sysadm.FN_CLE_VAL ( 'ID_ARCH_ORIG', a.txt_compo2, ';') ) > 0 
						Then sysadm.FN_CLE_VAL ( 'JOINDRE_ORIG', @asValCar, ';' )
					Else 'NON'
				 End 
		End 'joindre_courrier_orig',
		Case @iIdRel
			When 1 Then Convert ( varchar, a.id_arch )
			Else Isnull ( nullif ( sysadm.FN_CLE_VAL ( 'ID_ARCH_ORIG', a.txt_compo2, ';'), '' ), '0' )
		End 'id_arch_orig',
		sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) 'env_en_recommande',
		sysadm.FN_CLE_VAL ( 'DERN_REL', @asValCar, ';' ) 'derniere_relance',
		Case @iIdRel
			When 1 Then Convert ( varchar, a.dte_edit, 103 )
			Else sysadm.FN_CLE_VAL ( 'DTE_EDIT_ORIG', a.txt_compo2, ';') 
		End 'date_cour_orig',
		Case @iIdRel
			When 1 Then ''
			Else Convert ( varchar, a.dte_edit, 103 )
		End 'date_dern_rel',
		'RELANCE_BANQUE_UF' 'categorie_relance',
		a.id_inter,
		a.id_doc,
		Case 
			When sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) = 'OUI' Then 'NON'
			When ( rtrim ( i.adr_mail ) = '' Or i.adr_mail is null ) Then 'NON'		
			Else sysadm.FN_CLE_VAL ( 'ENV_MAIL', @asValCar, ';' )
		End 'env_par_mail'
		  
	From	sysadm.archive a,
			sysadm.routage r,
			sysadm.sinistre s,
			sysadm.personne pers,
			sysadm.produit p,
			sysadm.inter i,
			sysadm.w_gar_sin wg
	Where   a.id_prod = @adcIdProd
	And     ( 
				(
					( Substring ( a.id_cour_orig, 2, 1 ) = 'C' and Substring ( a.id_cour_orig, 4, 1 ) = 'P' Or Substring ( a.id_cour_orig, 1, 1 ) = 'Q' )
					And 
					@iIdRel = 1
					And 
					a.valide_le between @dtDate1Min and @dtDate1Max
					and s.valide_le = a.valide_le
					and CharIndex ( 'P001', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P118', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P119', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P037', a.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P107', a.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P120', a.txt_compo1, 1 ) = 0  
					And Not Exists (
						Select Top 1 1 
						From sysadm.archive a1
						Where a1.id_sin = a.id_sin
						And   a1.id_inter = a.id_inter
						And   ( a1.id_cour_orig = rtrim ( a.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 ))
					) 

				) 
				Or
				(
					( Substring ( a.id_cour_orig, 2, 5 ) = 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel - 1), 2 ) )
					And 
					@iIdRel > 1
					And 
					a.maj_le <= @dtDate2 
					And
					a.maj_le > '03/04/2019' -- MEP		
					And -- [PM407-1][20190408]
					sysadm.FN_CLE_VAL ( 'TRT_PAR', a.txt_compo2, ';') = 'KSL'
					And Not Exists (
						Select Top 1 1 
						From sysadm.archive a1
						Where a1.id_sin = a.id_sin
						And   a1.id_inter = a.id_inter
						And   a1.id_cour_orig = rtrim ( a.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 )
					) 
					and s.valide_le = a.valide_le
				) 
			)
	And		a.nbr_conf = 0
	And 	a.cod_inter='B'
	And		r.id_sin = a.id_sin
	And		r.alt_queue = 'N'
	And		s.id_sin = a.id_sin
	and    	s.cod_etat in ( 100, 550 )
	And		pers.id_ordre = s.id_ordre
	And		p.id_prod = s.id_prod
	And     i.id_sin = a.id_sin
	And     i.cod_inter = a.cod_inter
	And		wg.id_sin = s.id_sin
	And  	wg.id_gti = 7
	And		( 
				Exists ( 
					Select Top 1 1
					From   sysadm.w_piece wp
					Where  wp.id_sin = s.id_sin
					And	   wp.id_gti = 7 
					And	   wp.id_i = i.id_i
				)
				OR 
				(  wg.alt_att = 'O' )
			)
	And SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( s.id_sin, 2 ) <= 0  -- [RS3179]
END
Else
BEGIN
	-- Relance normales Assuré
	Insert into sysadm.w_cour_xml_orangev3 (
		  no_dossier_sinistre,
		  civilite_courte,
		  civilite_longue,
		  nom,
		  prenom,
		  adresse1,
		  adresse2,
		  code_postal,
		  ville,
		  code_produit_sinistre,
		  nom_produit,
		  lib_opt_produit,
		  no_tel_spb,
		  no_fax_spb,
		  assureur,
		  no_police,
		  no_ligne_assuree,
		  cout_telephonique,
		  date_de_declaration,
		  code_operateur,
		  code_maquette,
		  adr_mail,
		  numero_relance,
		  joindre_courrier_orig,
		  id_arch_orig,
		  env_en_recommande,
		  derniere_relance,
		  date_cour_orig,
		  date_dern_rel,
		  categorie_relance,
		  id_inter, 
		  id_doc,
		  env_par_mail
		  )
	Select	
		s.id_sin, 
		sysadm.FN_CODE_NUM(pers.cod_civ,'-CI') as civilite, 
		Case 
			When pers.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
			Else sysadm.FN_CODE_NUM(pers.cod_civ,'-CL') 
		End as civilite_longue,
		pers.nom,
		pers.prenom,
		pers.adr_1, 
		pers.adr_2, 
		Case pers.adr_cp When '00000' then '' Else pers.adr_cp End as adr_cp, 
		pers.adr_ville,
		p.id_prod,
		(select rtrim(dp66.val_car) 
		 from sysadm.det_pro dp66 
		 where dp66.id_prod=s.id_prod 
		   and dp66.id_code_dp=66) as lib_produit_assure,
		(select rtrim(dp67.val_car) 
		 from sysadm.det_pro dp67 
		 where dp67.id_prod=s.id_prod 
		   and dp67.id_code_dp=67) as lib_option_produit,
		p.num_tel as num_tel_produit,
		p.num_fax,
		rtrim ( sysadm.FN_LIB_CIE (s.id_sin)) as lib_compagnie,
		rtrim ( sysadm.FN_LIB_POLICE (s.id_sin)) as lib_police,
		s.num_port as num_tel_assure,
		(select rtrim(dp70.val_car) 
		 from sysadm.det_pro dp70 
		 where dp70.id_prod=s.id_prod 
		   and dp70.id_code_dp=70) as cout_telephonique,
		convert(varchar(10),s.dte_decl,20) as dte_decl,
		rtrim ( s.maj_par ) as code_operateur,
		'RELANCE_' + 
			Case 
				When sysadm.FN_CLE_VAL ( 'DERN_REL', @asValCar, ';' ) = 'OUI' 
					Then 'DER'
				Else convert ( varchar ,@iIdRel )
			End as code_maquette,
		Case 
			When sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) = 'OUI' Then ''
			When sysadm.FN_CLE_VAL ( 'ENV_MAIL', @asValCar, ';' ) <> 'OUI' Then ''
			Else rtrim ( i.adr_mail )
		End 'adr_mail',
		convert ( varchar ,@iIdRel ) 'numero_relance',
		Case @iIdRel
			When 1 Then sysadm.FN_CLE_VAL ( 'JOINDRE_ORIG', @asValCar, ';' )
			Else Case 
					When isnumeric ( sysadm.FN_CLE_VAL ( 'ID_ARCH_ORIG', a.txt_compo2, ';') ) > 0 
						Then sysadm.FN_CLE_VAL ( 'JOINDRE_ORIG', @asValCar, ';' )
					Else 'NON'
				 End 
		End 'joindre_courrier_orig',
		Case @iIdRel
			When 1 Then Convert ( varchar, a.id_arch )
			Else Isnull ( nullif ( sysadm.FN_CLE_VAL ( 'ID_ARCH_ORIG', a.txt_compo2, ';'), '' ), '0' )
		End 'id_arch_orig',
		sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) 'env_en_recommande',
		sysadm.FN_CLE_VAL ( 'DERN_REL', @asValCar, ';' ) 'derniere_relance',
		Case @iIdRel
			When 1 Then Convert ( varchar, a.dte_edit, 103 )
			Else sysadm.FN_CLE_VAL ( 'DTE_EDIT_ORIG', a.txt_compo2, ';') 
		End 'date_cour_orig',
		Case @iIdRel
			When 1 Then ''
			Else Convert ( varchar, a.dte_edit, 103 )
		End 'date_dern_rel',
		'RELANCE_ASSURE' 'categorie_relance',
		a.id_inter,
		a.id_doc,
		Case 
			When sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) = 'OUI' Then 'NON'
			When ( rtrim ( i.adr_mail ) = '' Or i.adr_mail is null ) Then 'NON'
			Else sysadm.FN_CLE_VAL ( 'ENV_MAIL', @asValCar, ';' )
		End 'env_par_mail'
	  
	From	sysadm.archive a,
			sysadm.routage r,
			sysadm.sinistre s,
			sysadm.personne pers,
			sysadm.produit p,
			sysadm.inter i
	Where   a.id_prod = @adcIdProd
	And     ( 
				(
					( Substring ( a.id_cour_orig, 2, 1 ) = 'C' and Substring ( a.id_cour_orig, 4, 1 ) = 'P' Or Substring ( a.id_cour_orig, 1, 1 ) = 'Q' )
					And 
					@iIdRel = 1
					And a.valide_le between @dtDate1Min and @dtDate1Max
					and s.valide_le = a.valide_le
					and CharIndex ( 'P001', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P118', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P119', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P037', a.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P107', a.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P120', a.txt_compo1, 1 ) = 0   
					And Not Exists (
						Select Top 1 1 
						From sysadm.archive a1
						Where a1.id_sin = a.id_sin
						And   a1.id_inter = a.id_inter
						And   ( a1.id_cour_orig = rtrim ( a1.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 )
								Or 
								a1.id_cour_orig = rtrim ( a1.cod_inter ) + 'LQ0' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 )
							  )
					)

				) 
				Or
				(
					( Substring ( a.id_cour_orig, 2, 5 ) = 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel - 1), 2 )
					  Or 
					  a.id_cour_orig = 'ALQ0' + Right ( '00' + Convert ( varchar, @iIdRel - 1), 2 )
					)
					And 
					@iIdRel > 1
					And 
					a.maj_le <= @dtDate2
					And
					a.maj_le > @dtDteMEp -- MEP
					And -- [PM407-1][20190408]
					sysadm.FN_CLE_VAL ( 'TRT_PAR', a.txt_compo2, ';') = 'KSL'
					And Not Exists (
						Select Top 1 1 
						From sysadm.archive a1
						Where a1.id_sin = a.id_sin
						And   a1.id_inter = a.id_inter
						And   a1.id_cour_orig = rtrim ( a.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 )
					)
					and s.valide_le = a.valide_le 
				) 
			)
	And		a.nbr_conf = 0
	And 	a.cod_inter='A'
	And		r.id_sin = a.id_sin
	And		r.alt_queue = 'N'
	And		s.id_sin = a.id_sin
	and    	s.cod_etat in ( 100, 550 )
	And		pers.id_ordre = s.id_ordre
	And		p.id_prod = s.id_prod
	And     i.id_sin = a.id_sin
	And     i.cod_inter = a.cod_inter


	-- Relance UF Banque
	Insert into sysadm.w_cour_xml_orangev3 (
		  no_dossier_sinistre,
		  civilite_courte,
		  civilite_longue,
		  nom,
		  prenom,
		  adresse1,
		  adresse2,
		  code_postal,
		  ville,
		  code_produit_sinistre,
		  nom_produit,
		  lib_opt_produit,
		  no_tel_spb,
		  no_fax_spb,
		  assureur,
		  no_police,
		  no_ligne_assuree,
		  cout_telephonique,
		  date_de_declaration,
		  code_operateur,
		  code_maquette,
		  adr_mail,
		  numero_relance,
		  joindre_courrier_orig,
		  id_arch_orig,
		  env_en_recommande,
		  derniere_relance,
		  date_cour_orig,
		  date_dern_rel,
		  categorie_relance,
		  id_inter,
		  id_doc,
		  env_par_mail
		  )
	Select	
		s.id_sin, 
		'Messieurs' as civilite, 
		'Messieurs' civilite_longue,
		i.nom,
		'',
		i.adr_1, 
		i.adr_2, 
		Case pers.adr_cp When '00000' then '' Else i.adr_cp End as adr_cp, 
		i.adr_ville,
		p.id_prod,
		(select rtrim(dp66.val_car) 
		 from sysadm.det_pro dp66 
		 where dp66.id_prod=s.id_prod 
		   and dp66.id_code_dp=66) as lib_produit_assure,
		(select rtrim(dp67.val_car) 
		 from sysadm.det_pro dp67 
		 where dp67.id_prod=s.id_prod 
		   and dp67.id_code_dp=67) as lib_option_produit,
		p.num_tel as num_tel_produit,
		p.num_fax,
		rtrim ( sysadm.FN_LIB_CIE (s.id_sin)) as lib_compagnie,
		rtrim ( sysadm.FN_LIB_POLICE (s.id_sin)) as lib_police,
		s.num_port as num_tel_assure,
		(select rtrim(dp70.val_car) 
		 from sysadm.det_pro dp70 
		 where dp70.id_prod=s.id_prod 
		   and dp70.id_code_dp=70) as cout_telephonique,
		convert(varchar(10),s.dte_decl,20) as dte_decl,
		rtrim ( s.maj_par ) as code_operateur,
		'RELANCE_' + 
			Case 
				When sysadm.FN_CLE_VAL ( 'DERN_REL', @asValCar, ';' ) = 'OUI' 
					Then 'DER'
				Else convert ( varchar ,@iIdRel )
			End as code_maquette,
		Case 
			When sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) = 'OUI' Then ''
			When sysadm.FN_CLE_VAL ( 'ENV_MAIL', @asValCar, ';' ) <> 'OUI' Then ''
			Else rtrim ( i.adr_mail )
		End 'adr_mail',
		convert ( varchar ,@iIdRel ) 'numero_relance',
		Case @iIdRel
			When 1 Then sysadm.FN_CLE_VAL ( 'JOINDRE_ORIG', @asValCar, ';' )
			Else Case 
					When isnumeric ( sysadm.FN_CLE_VAL ( 'ID_ARCH_ORIG', a.txt_compo2, ';') ) > 0 
						Then sysadm.FN_CLE_VAL ( 'JOINDRE_ORIG', @asValCar, ';' )
					Else 'NON'
				 End 
		End 'joindre_courrier_orig',
		Case @iIdRel
			When 1 Then Convert ( varchar, a.id_arch )
			Else Isnull ( nullif ( sysadm.FN_CLE_VAL ( 'ID_ARCH_ORIG', a.txt_compo2, ';'), '' ), '0' )
		End 'id_arch_orig',
		sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) 'env_en_recommande',
		sysadm.FN_CLE_VAL ( 'DERN_REL', @asValCar, ';' ) 'derniere_relance',
		Case @iIdRel
			When 1 Then Convert ( varchar, a.dte_edit, 103 )
			Else sysadm.FN_CLE_VAL ( 'DTE_EDIT_ORIG', a.txt_compo2, ';') 
		End 'date_cour_orig',
		Case @iIdRel
			When 1 Then ''
			Else Convert ( varchar, a.dte_edit, 103 )
		End 'date_dern_rel',
		'RELANCE_BANQUE_UF' 'categorie_relance',
		a.id_inter,
		a.id_doc,
		Case 
			When sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) = 'OUI' Then 'NON'
			When ( rtrim ( i.adr_mail ) = '' Or i.adr_mail is null ) Then 'NON'		
			Else sysadm.FN_CLE_VAL ( 'ENV_MAIL', @asValCar, ';' )
		End 'env_par_mail'
		  
	From	sysadm.archive a,
			sysadm.routage r,
			sysadm.sinistre s,
			sysadm.personne pers,
			sysadm.produit p,
			sysadm.inter i,
			sysadm.w_gar_sin wg
	Where   a.id_prod = @adcIdProd
	And     ( 
				(
					( Substring ( a.id_cour_orig, 2, 1 ) = 'C' and Substring ( a.id_cour_orig, 4, 1 ) = 'P' Or Substring ( a.id_cour_orig, 1, 1 ) = 'Q' )
					And 
					@iIdRel = 1
					And 
					a.valide_le between @dtDate1Min and @dtDate1Max
					and s.valide_le = a.valide_le
					and CharIndex ( 'P001', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P118', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P119', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P037', a.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P107', a.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P120', a.txt_compo1, 1 ) = 0  
					And Not Exists (
						Select Top 1 1 
						From sysadm.archive a1
						Where a1.id_sin = a.id_sin
						And   a1.id_inter = a.id_inter
						And   ( a1.id_cour_orig = rtrim ( a.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 ))
					) 

				) 
				Or
				(
					( Substring ( a.id_cour_orig, 2, 5 ) = 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel - 1), 2 ) )
					And 
					@iIdRel > 1
					And 
					a.maj_le <= @dtDate2 
					And
					a.maj_le > '03/04/2019' -- MEP		
					And -- [PM407-1][20190408]
					sysadm.FN_CLE_VAL ( 'TRT_PAR', a.txt_compo2, ';') = 'KSL'
					And Not Exists (
						Select Top 1 1 
						From sysadm.archive a1
						Where a1.id_sin = a.id_sin
						And   a1.id_inter = a.id_inter
						And   a1.id_cour_orig = rtrim ( a.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 )
					) 
					and s.valide_le = a.valide_le
				) 
			)
	And		a.nbr_conf = 0
	And 	a.cod_inter='B'
	And		r.id_sin = a.id_sin
	And		r.alt_queue = 'N'
	And		s.id_sin = a.id_sin
	and    	s.cod_etat in ( 100, 550 )
	And		pers.id_ordre = s.id_ordre
	And		p.id_prod = s.id_prod
	And     i.id_sin = a.id_sin
	And     i.cod_inter = a.cod_inter
	And		wg.id_sin = s.id_sin
	And  	wg.id_gti = 7
	And		( 
				Exists ( 
					Select Top 1 1
					From   sysadm.w_piece wp
					Where  wp.id_sin = s.id_sin
					And	   wp.id_gti = 7 
					And	   wp.id_i = i.id_i
				)
				OR 
				(  wg.alt_att = 'O' )
			)
	And SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( s.id_sin, 2 ) <= 0  -- [RS3179]
END 

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_PM407_MARQUAGE_RELANCE
-- Auteur               :       JFF
-- Date                 :       24/01/2018
-- Libelle              :       
-- Commentaires         :       [PM407-1]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      13/10/2023   [RS6005]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_PM407_MARQUAGE_RELANCE' AND type = 'P' )
        DROP procedure sysadm.PS_U_PM407_MARQUAGE_RELANCE
GO

CREATE procedure sysadm.PS_U_PM407_MARQUAGE_RELANCE
	    @adcIdSin       Decimal (10,0),
		@adcIdInter		Decimal (7,0),
		@adcIdDoc		Decimal (7,0),
		@aiIdNumRel     Integer,
		@asJoindreCourOrig VarChar ( 10 ),
		@aiIdArchOrig   Integer,
		@asEnvEnRec		VarChar ( 10 ),
		@asDernRel		VarChar ( 10 ),
		@asEnvParMail	VarChar ( 10 )
As

-- [RS6005]
Return 

Set NoCount On

Declare @iNewIdDoc Integer 
Declare @dtDteEditOrig DateTime
Declare @sIdArchOrig varchar ( 20 )
-- Select id_cour_orig, * from sysadm.archive where id_sin = 6142802  -- A et B
-- Select * from sysadm.archive_blob where id_sin = 6142802  -- A et B
-- sysadm.PS_U_PM407_MARQUAGE_RELANCE 6142802, 0, 6, 3, 'NON', 0, 'NON', 'OUI', 'NON'
-- sysadm.PS_U_PM407_MARQUAGE_RELANCE 6142802, 1, 6, 3, 'NON', 0, 'NON', 'OUI', 'NON'
-- sysadm.PS_U_PM407_MARQUAGE_RELANCE 6313952, 0, 4, 1, 'OUI', 10109622, 'NON', 'NON', 'OUI'
-- sysadm.PS_U_PM407_MARQUAGE_RELANCE 6313952, 0, 5, 2, 'OUI', 10109622, 'NON', 'NON', 'OUI'

Set @asJoindreCourOrig = lTrim ( rtrim ( @asJoindreCourOrig  ))
Set @asEnvEnRec		= lTrim ( rtrim ( @asEnvEnRec  ))
Set @asDernRel		= lTrim ( rtrim ( @asDernRel  ))
Set @asEnvParMail	= lTrim ( rtrim ( @asEnvParMail  ))


Select	@iNewIdDoc  = max ( id_doc )
From	sysadm.archive a
Where   a.id_sin = @adcIdSin
And		a.id_inter = @adcIdInter
And     a.id_doc = @adcIdDoc

If @iNewIdDoc is null Set @iNewIdDoc = 0
Set @iNewIdDoc = @iNewIdDoc + 1

If IsNumeric ( @aiIdArchOrig ) > 0
 Begin
	Select @dtDteEditOrig = a.dte_edit
	From sysadm.archive a
	Where a.id_arch = @aiIdArchOrig
 End 

If @aiIdArchOrig <= 0 Set @sIdArchOrig = '' Else Set @sIdArchOrig = Convert ( varchar, @aiIdArchOrig )

Update  sysadm.archive
Set     dte_conf = GetDate(), 
		nbr_conf = 1
Where	id_sin = @adcIdSin
And		id_inter = @adcIdInter
And		id_doc = @adcIdDoc

Insert into sysadm.archive 
Select  a.id_sin,
		a.id_inter,
		@iNewIdDoc,
		rtrim ( a.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @aiIdNumRel ), 2 ),
		a.id_prod,
		a.id_ordre,
		a.id_adh,
		a.cod_version,
		a.cod_inter,
		a.nom,
		Getdate () 'a.dte_edit',
		null 'a.dte_conf',
		null 'a.dte_archiv',
		a.dte_rep,
		'N' 'a.alt_part',
		'N' 'a.alt_pce',
		'N' 'a.alt_ps',
		'N' 'a.alt_rep',
		'' 'a.txt_compo1',
			sysadm.FN_CLE_VAL_E ( 'TRT_PAR', 'KSL',
			sysadm.FN_CLE_VAL_E ( 'DTE_EDIT_ORIG', Convert ( varchar, @dtDteEditOrig, 103 ),
			sysadm.FN_CLE_VAL_E ( 'ID_ARCH_ORIG', @sIdArchOrig, '', ';' )
			, ';' )
			, ';' ) 'a.txt_compo2',
		null 'a.ref_doc_dt',
		null 'a.ref_doc_cp',
		null 'a.ref_doc_pc',
		null 'a.ref_doc_ps',
		0 'a.nbr_conf',
		a.valide_le, -- important!! pour un lien
		'KSL' 'a.valide_par',
		GetDate() 'a.cree_le',
		GetDate() 'a.maj_le',
		'KSL' 'a.maj_par',
		null 'a.id_arch',
		rtrim ( a.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @aiIdNumRel ), 2 ) 'a.id_cour_orig',
		null 'a.id_doc_edt',
		Case @asEnvParMail
			When 'OUI' Then 'MA'
			Else 'CO'
		End 'a.id_canal',
		null 'a.envoi_mail_le',
		null 'a.dte_atlas_notif',
		null 'a.dte_atlas_telecharg',
		null 'a.dte_atlas_rappel',
		null 'a.dte_edit_courrier_rappel',
		null 'a.dte_echec_distrib_ksl',
		null 'a.modele_word'

From	sysadm.archive a
Where	a.id_sin = @adcIdSin
And		a.id_inter = @adcIdInter
And		a.id_doc = @adcIdDoc

Insert into sysadm.archive_blob values ( 
	@adcIdSin,
	@adcIdInter,
	@iNewIdDoc,
	'DO',
	'',
	Getdate(),
	'KSL',
	Getdate(),
	Getdate(),
	'KSL'
)


Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_PM407_CONSULT_KSL
-- Auteur               :       JFF
-- Date                 :       24/01/2018
-- Libelle              :       
-- Commentaires         :       [PM407-1]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM407_CONSULT_KSL' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM407_CONSULT_KSL
GO

CREATE procedure sysadm.PS_S_PM407_CONSULT_KSL
	    @adcIdSin       Decimal (10,0),
		@adcIdInter		Decimal (7,0),
		@adcIdDoc		Decimal (7,0)	
AS

Declare @sVal VarChar ( 3 )

Select @sVal = sysadm.FN_CLE_VAL ( 'TRT_PAR', a.txt_compo2, ';') 
From sysadm.archive a
Where a.id_sin = @adcIdSin
And   a.id_inter = @adcIdInter
And   a.id_doc = @adcIdDoc

If @sVal is null Or rtrim ( @sVal ) = '' Set @sVal = '' 

If @sVal = 'KSL' Return 1

Return 0

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_PM407_NOUVEAU_SYSTEME
-- Auteur               :       JFF
-- Date                 :       24/01/2018
-- Libelle              :       
-- Commentaires         :       [PM407-1]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM407_NOUVEAU_SYSTEME' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM407_NOUVEAU_SYSTEME
GO

CREATE procedure sysadm.PS_S_PM407_NOUVEAU_SYSTEME
	@asCas	   Varchar ( 10 ),
	@adcIdProd Decimal ( 10 ),
	@adcIdSin  Decimal ( 7 )

As 

If @asCas = 'PRODUIT' 
 Begin

	If Exists ( 
		Select Top 1 1 
		From   sysadm.det_pro dp
		Where  dp.id_prod = @adcIdProd
		And    dp.id_code_dp = 323
		)
		 Return 1
	Else Return 0
 End 

If @asCas = 'SINISTRE' 
 Begin

	If Exists ( 
		Select Top 1 1 
		From   sysadm.det_pro dp,
			   sysadm.sinistre s
		Where  s.id_sin = @adcIdSin
		And    dp.id_prod = s.id_prod
		And    dp.id_code_dp = 323
		)
		 Return 1
	Else Return 0
 End 


Go 

--------------------------------------------------------------------
--
-- Procedure            :       PS_SU_PM407_RELANCE_TRAITEMENT_RS6005
-- Auteur               :       JFF
-- Date                 :       13/10/2023
-- Libelle              :       
-- Commentaires         :       [RS6005][PM407-1]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SU_PM407_RELANCE_TRAITEMENT_RS6005' AND type = 'P' )
        DROP procedure sysadm.PS_SU_PM407_RELANCE_TRAITEMENT_RS6005
GO

CREATE procedure sysadm.PS_SU_PM407_RELANCE_TRAITEMENT_RS6005
As

If Not ( sysadm.FN_CLE_NUMERIQUE ( 'RS6005_REL_BRED') > 0 ) Return

Set NoCount On

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_prod	decimal (7 ),
	  id_ctg	varchar (6),
	  val_car   varchar ( 500 ),
	  cpt_tri   integer,
	  marquage	integer null 
	)

Declare @dcIdProd decimal (7 )
Declare @sIdCtg   varchar ( 6 )
Declare @iCptTri  integer
Declare @iIdSeq   integer
declare @sValCar  VarChar ( 500 )
Declare @iAMUedtPapierTotal Integer
Declare @iAMUedtPapier Integer
Declare @iIdChemForce Integer
Declare @iIdChemForceDef Integer
Declare @sObjet VarChar ( 255 )
Declare @sMessage VarChar ( 8000 )
Declare @sRetourErrMail VarChar ( 255 )
Declare @sFicOut VarChar ( 255 )
Declare @sCheminKslEdtPapier VarChar ( 255 ) 

Set @iAMUedtPapierTotal = 0
Set @iIdChemForceDef = 0

Insert into @tb
select dp.id_prod,
	   dp.id_code_car,
	   rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ),
	   dp.tri,
	   0 'marquage'
from	sysadm.det_pro dp
where	dp.id_code_dp = 323
And     dp.id_code_car = 'RELANC'
Order by id_prod, tri

Set @iIdSeq = 1 


While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@dcIdProd = id_prod,
		@sValCar = val_car
	From	@tb
	Where	marquage = 0
	And		id_seq = @iIdSeq

	Set @iAMUedtPapier = 0
	Exec sysadm.PS_S_PM407_RELANCE_PRODUIT_RS6005 @dcIdProd, @sValCar, @iAMUedtPapier OutPut, @iIdChemForce OutPut

	Set @iAMUedtPapierTotal = @iAMUedtPapierTotal + @iAMUedtPapier
	If @iIdChemForce > 0 And @iIdChemForceDef =0 Set @iIdChemForceDef = @iIdChemForce

	Update @tb Set marquage = 1 Where id_seq = @iIdSeq
	Set @iIdSeq = @iIdSeq + 1
 End

If @iAMUedtPapierTotal  > 0 And @@servername = master.dbo.SPB_FN_ServerName ('PRO') 
	Begin

		Select Top 1 @sCheminKslEdtPapier = lTrim ( rTrim ( chemin_pro )) from TRACE_MAIL_PRO.sysadm.chem_depot_ksl_rs5045 where id_chemin = @iIdChemForceDef 

		Set @sObjet = '[' + convert ( VarChar (10), Getdate(), 103 ) + '] RELANCE BRED SIMPA2/KSL : Vous avez ' + CONVERT ( VarChar ( 10 ), @iAMUedtPapierTotal  ) + ' relance(s) à éditer'

		Set @sMessage = 'Bonjour, ' + CHAR ( 10 )
		Set @sMessage = @sMessage + CHAR ( 10 )
		Set @sMessage = @sMessage + 'Aujourd''hui ' + convert ( VarChar (10), Getdate(), 103 ) + ', vous avez ' + CONVERT ( VarChar ( 10 ), @iAMUedtPapierTotal  ) + ' relance(s) à éditer sur : ' + @sCheminKslEdtPapier + CHAR ( 10 )
		Set @sMessage = @sMessage + CHAR ( 10 )
		Set @sMessage = @sMessage + 'Cordialement,'
		Set @sMessage = @sMessage + CHAR ( 10 )
		Set @sMessage = @sMessage + CHAR ( 10 )
		Set @sMessage = @sMessage + 'Fabry Jean-François'
		Set @sMessage = @sMessage + CHAR ( 10 )
		Set @sMessage = @sMessage + 'DSI/Etudes SIMPA2'

		EXEC master.dbo.SPB_PS_MAIL 
				@sRetourErrMail OUTPUT, 
				'PFAUVEL@spb.eu,IMORIN@spb.eu,NTONNETOT@spb.eu', 
				@sMessage, 
				@sObjet, 
				'', 
				'', 
				@sFicOut, 
				NULL, 
				NULL, 
				NULL, 
				NULL

	End 

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_PM407_MARQUAGE_RELANCE_RS6005
-- Auteur               :       JFF
-- Date                 :       13/10/2023
-- Libelle              :       
-- Commentaires         :       [RS6005][PM407-1]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_PM407_MARQUAGE_RELANCE_RS6005' AND type = 'P' )
        DROP procedure sysadm.PS_U_PM407_MARQUAGE_RELANCE_RS6005
GO

CREATE procedure sysadm.PS_U_PM407_MARQUAGE_RELANCE_RS6005
	    @adcIdSin       Decimal (10,0),
		@adcIdInter		Decimal (7,0),
		@adcIdDoc		Decimal (7,0),
		@aiIdNumRel     Integer,
		@asJoindreCourOrig VarChar ( 10 ),
		@aiIdArchOrig   Integer,
		@asEnvEnRec		VarChar ( 10 ),
		@asDernRel		VarChar ( 10 ),
		@asEnvParMail	VarChar ( 10 )
As

Set NoCount On

Declare @iNewIdDoc Integer 
Declare @dtDteEditOrig DateTime
Declare @sIdArchOrig varchar ( 20 )
-- Select id_cour_orig, * from sysadm.archive where id_sin = 6142802  -- A et B
-- Select * from sysadm.archive_blob where id_sin = 6142802  -- A et B
-- sysadm.PS_U_PM407_MARQUAGE_RELANCE 6142802, 0, 6, 3, 'NON', 0, 'NON', 'OUI', 'NON'
-- sysadm.PS_U_PM407_MARQUAGE_RELANCE 6142802, 1, 6, 3, 'NON', 0, 'NON', 'OUI', 'NON'
-- sysadm.PS_U_PM407_MARQUAGE_RELANCE 6313952, 0, 4, 1, 'OUI', 10109622, 'NON', 'NON', 'OUI'
-- sysadm.PS_U_PM407_MARQUAGE_RELANCE 6313952, 0, 5, 2, 'OUI', 10109622, 'NON', 'NON', 'OUI'

Set @asJoindreCourOrig = lTrim ( rtrim ( @asJoindreCourOrig  ))
Set @asEnvEnRec		= lTrim ( rtrim ( @asEnvEnRec  ))
Set @asDernRel		= lTrim ( rtrim ( @asDernRel  ))
Set @asEnvParMail	= lTrim ( rtrim ( @asEnvParMail  ))


Select	@iNewIdDoc  = max ( id_doc )
From	sysadm.archive a
Where   a.id_sin = @adcIdSin
And		a.id_inter = @adcIdInter
And     a.id_doc = @adcIdDoc

If @iNewIdDoc is null Set @iNewIdDoc = 0
Set @iNewIdDoc = @iNewIdDoc + 1

If IsNumeric ( @aiIdArchOrig ) > 0
 Begin
	Select @dtDteEditOrig = a.dte_edit
	From sysadm.archive a
	Where a.id_arch = @aiIdArchOrig
 End 

If @aiIdArchOrig <= 0 Set @sIdArchOrig = '' Else Set @sIdArchOrig = Convert ( varchar, @aiIdArchOrig )

Update  sysadm.archive
Set     dte_conf = GetDate(), 
		nbr_conf = 1
Where	id_sin = @adcIdSin
And		id_inter = @adcIdInter
And		id_doc = @adcIdDoc

Insert into sysadm.archive 
		(
		id_sin,
		id_inter,
		id_doc,
		id_cour,
		id_prod,
		id_ordre,
		id_adh,
		cod_version,
		cod_inter,
		nom,
		dte_edit,
		dte_conf,
		dte_archiv,
		dte_rep,
		alt_part,
		alt_pce,
		alt_ps,
		alt_rep,
		txt_compo1,
		txt_compo2,
		ref_doc_dt,
		ref_doc_cp,
		ref_doc_pc,
		ref_doc_ps,
		nbr_conf,
		valide_le,
		valide_par,
		cree_le,
		maj_le,
		maj_par,
		id_arch,
		id_cour_orig,
		id_doc_edt,
		id_canal,
		envoi_mail_le,
		dte_atlas_notif,
		dte_atlas_telecharg,
		dte_atlas_rappel,
		dte_edit_courrier_rappel,
		dte_echec_distrib_ksl,
		modele_word
		)
Select  a.id_sin,
		a.id_inter,
		@iNewIdDoc,
		rtrim ( a.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @aiIdNumRel ), 2 ),
		a.id_prod,
		a.id_ordre,
		a.id_adh,
		a.cod_version,
		a.cod_inter,
		a.nom,
		Getdate () 'a.dte_edit',
		null 'a.dte_conf',
		null 'a.dte_archiv',
		a.dte_rep,
		'N' 'a.alt_part',
		'N' 'a.alt_pce',
		'N' 'a.alt_ps',
		'N' 'a.alt_rep',
		'' 'a.txt_compo1',
			sysadm.FN_CLE_VAL_E ( 'TRT_PAR', 'KSL',
			sysadm.FN_CLE_VAL_E ( 'DTE_EDIT_ORIG', Convert ( varchar, @dtDteEditOrig, 103 ),
			sysadm.FN_CLE_VAL_E ( 'ID_ARCH_ORIG', @sIdArchOrig, '', ';' )
			, ';' )
			, ';' ) 'a.txt_compo2',
		null 'a.ref_doc_dt',
		null 'a.ref_doc_cp',
		null 'a.ref_doc_pc',
		null 'a.ref_doc_ps',
		0 'a.nbr_conf',
		a.valide_le, -- important!! pour un lien
		'KSL' 'a.valide_par',
		GetDate() 'a.cree_le',
		GetDate() 'a.maj_le',
		'KSL' 'a.maj_par',
		null 'a.id_arch',
		rtrim ( a.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @aiIdNumRel ), 2 ) 'a.id_cour_orig',
		null 'a.id_doc_edt',
		Case @asEnvParMail
			When 'OUI' Then 'MA'
			Else 'CO'
		End 'a.id_canal',
		null 'a.envoi_mail_le',
		null 'a.dte_atlas_notif',
		null 'a.dte_atlas_telecharg',
		null 'a.dte_atlas_rappel',
		null 'a.dte_edit_courrier_rappel',
		null 'a.dte_echec_distrib_ksl',
		'AUCUN_MODELE' 

From	sysadm.archive a
Where	a.id_sin = @adcIdSin
And		a.id_inter = @adcIdInter
And		a.id_doc = @adcIdDoc

Insert into sysadm.archive_blob values ( 
	@adcIdSin,
	@adcIdInter,
	@iNewIdDoc,
	'DO',
	'',
	Getdate(),
	'KSL',
	Getdate(),
	Getdate(),
	'KSL'
)


Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_PM407_RELANCE_PRODUIT_RS6005
-- Auteur               :       JFF
-- Date                 :       13/10/2023
-- Libelle              :       
-- Commentaires         :       [RS6005][PM407-1]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      06/11/2018   [PM451-1]
-- JFF      08/04/2019   [PM407-1][20190408]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM407_RELANCE_PRODUIT_RS6005' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM407_RELANCE_PRODUIT_RS6005
GO

CREATE procedure sysadm.PS_S_PM407_RELANCE_PRODUIT_RS6005
	  @adcIdProd       Decimal (7,0),
      @asValCar		  VarChar ( 500 ),
	  @aiAMUedtPapier  Integer OutPut, 
	  @aiIdChemForce Integer OutPut
As

Set NoCount On

Declare @iIdRel Integer
Declare @iDelRel1Min Integer
Declare @iDelRel1Max Integer
Declare @iDelRel2 Integer
Declare @dtDate1Min DateTime
Declare @dtDate1Max DateTime
Declare @dtDate2 DateTime
Declare @dtDteMEp DateTime
Declare @dcIdSin Decimal ( 10 ) 
Declare @iIdSin integer
Declare @dcIdInter Decimal ( 7 ) 
Declare @sIdDoc VarChar ( 5 ) 
Declare @dcIdDoc Decimal (7)
Declare @iIdSeq Integer
Declare @sTypMail VarChar ( 6 ) 
Declare @sAdrMail VarChar ( 128 ) 
Declare @sNumRelance VarChar ( 5 ) 
Declare @iNumRelance integer
Declare @sJoindreCourOrig VarChar ( 5 ) 
Declare @sIdArchOrig VarChar ( 15 ) 
Declare @sDteCourOrig VarChar ( 10 ) 
Declare @sDteDerRel VarChar ( 10 ) 
Declare @sCategorieRelance VarChar ( 20 ) 
Declare @sEnvParMail VarChar ( 5 ) 
Declare @sIdAppli VarChar ( 10 )
Declare @iIdProd Integer
Declare @sLibProd VarChar ( 255 )
Declare @iIdEts Integer
Declare @sMailFrom VarChar ( 128 )
Declare @sBoiteMail VarChar ( 128 )
Declare @sMailSend VarChar ( 128 )
Declare @sMailCc VarChar ( 128 )
Declare @sMailObjet VarChar ( 255 )
Declare @sMailBody VarChar ( max )
Declare @sCodeMaquette VarChar ( 255 )
Declare @sXMLVar VarChar (max)
Declare @iIdXml Integer
Declare @iRet Integer
Declare @sErrOutPut VarChar (255) 
Declare @sEnvEnRecommande VarChar ( 5)
Declare @sDernRelance VarChar ( 5)
Declare @iIdArchOrig Integer

Declare @TbRelProd Table (
	id_seq	 Integer identity,
	id_sin   Decimal (10),
	id_inter Decimal (7),
	id_doc   varchar ( 5 ),
	typ_mail varchar ( 6 ),
	adr_mail varchar ( 128 ),
	numero_relance varchar  (5),
	joindre_courrier_orig varchar  (5),
	id_arch_orig varchar  (15),
	env_en_recommande varchar  (5),
	derniere_relance varchar  (5),
	date_cour_orig varchar  (10),
	date_dern_rel varchar  (10),
	categorie_relance varchar ( 20),
	env_par_mail varchar  (5),
	marquage integer 
)

Set @iIdRel = Convert ( integer, sysadm.FN_CLE_VAL ( 'ID_REL', @asValCar, ';' ))
Set @iDelRel1Min = Convert ( integer, sysadm.FN_CLE_VAL ( 'DEL_REL_MIN', @asValCar, ';' ))
Set @iDelRel1Max = Convert ( integer, sysadm.FN_CLE_VAL ( 'DEL_REL_MAX', @asValCar, ';' ))
Set @iDelRel2 = Convert ( integer, sysadm.FN_CLE_VAL ( 'DEL_REL', @asValCar, ';' ))
Set @aiIdChemForce = null
Set @aiAMUedtPapier = 0 

Set @dtDate1Min = Case sysadm.FN_CLE_VAL ( 'UNITE_DEL', @asValCar, ';' )
					When 'J' Then DateAdd ( day, @iDelRel1Max * (-1), Getdate() )
					When 'M' Then DateAdd ( month, @iDelRel1Max * (-1), Getdate() )
				 End

Set @dtDate1Max = Case sysadm.FN_CLE_VAL ( 'UNITE_DEL', @asValCar, ';' )
					When 'J' Then DateAdd ( day, @iDelRel1Min * (-1), Getdate() )
					When 'M' Then DateAdd ( month, @iDelRel1Min * (-1), Getdate() )
				 End

Set @dtDate2 = Case sysadm.FN_CLE_VAL ( 'UNITE_DEL', @asValCar, ';' )
					When 'J' Then DateAdd ( day, @iDelRel2 * (-1), Getdate() )
					When 'M' Then DateAdd ( month, @iDelRel2 * (-1), Getdate() )
				 End

-- Récupération de la date de MEP
Select @dtDteMEp = sysadm.FN_CLE_VAL ( 'DTE_MEP', rtrim ( val_car ) + rtrim ( val_car2), ';' )
From   sysadm.det_pro dp
Where  dp.id_prod = @adcIdProd
And    dp.id_code_dp = 323
And    dp.id_code_car = '-1'

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	-- Relance normales Assuré
	Insert into @TbRelProd 
	Select	
		a.id_sin,
		a.id_inter,
		Convert ( varchar (5), a.id_doc),
		'RBRED' + 
			Case 
				When sysadm.FN_CLE_VAL ( 'DERN_REL', @asValCar, ';' ) = 'OUI' 
					Then 'D'
				Else convert ( varchar ,@iIdRel )
			End as typ_mail,
		Case 
			When sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) = 'OUI' Then ''
			When sysadm.FN_CLE_VAL ( 'ENV_MAIL', @asValCar, ';' ) <> 'OUI' Then ''
			Else rtrim ( i.adr_mail )
		End 'adr_mail',
		convert ( varchar ,@iIdRel ) 'numero_relance',
		Case @iIdRel
			When 1 Then sysadm.FN_CLE_VAL ( 'JOINDRE_ORIG', @asValCar, ';' )
			Else Case 
					When isnumeric ( sysadm.FN_CLE_VAL ( 'ID_ARCH_ORIG', a.txt_compo2, ';') ) > 0 
						Then sysadm.FN_CLE_VAL ( 'JOINDRE_ORIG', @asValCar, ';' )
					Else 'NON'
				 End 
		End 'joindre_courrier_orig',
		Case @iIdRel
			When 1 Then Convert ( varchar (15), a.id_arch )
			Else Isnull ( nullif ( sysadm.FN_CLE_VAL ( 'ID_ARCH_ORIG', a.txt_compo2, ';'), '' ), '0' )
		End 'id_arch_orig',
		sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) 'env_en_recommande',
		sysadm.FN_CLE_VAL ( 'DERN_REL', @asValCar, ';' ) 'derniere_relance',
		Case @iIdRel
			When 1 Then Convert ( varchar(10), a.dte_edit, 20 )
			Else Convert ( VarChar (10), Convert ( DateTime, sysadm.FN_CLE_VAL ( 'DTE_EDIT_ORIG', a.txt_compo2, ';')), 20 )
		End 'date_cour_orig',
		Case @iIdRel
			When 1 Then ''
			Else Convert ( varchar (10), a.dte_edit, 20 )
		End 'date_dern_rel',
		'RELANCE_ASSURE' 'categorie_relance',
		Case 
			When sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) = 'OUI' Then 'NON'
			When ( rtrim ( i.adr_mail ) = '' Or i.adr_mail is null ) Then 'NON'
			Else sysadm.FN_CLE_VAL ( 'ENV_MAIL', @asValCar, ';' )
		End 'env_par_mail',
		0
  
	From	sysadm.archive a,
			sysadm.routage r,
			sysadm.sinistre s,
			sysadm.personne pers,
			sysadm.produit p,
			sysadm.inter i
	Where   a.id_prod = @adcIdProd
	And     ( 
				(
					( Substring ( a.id_cour_orig, 2, 1 ) = 'C' and Substring ( a.id_cour_orig, 4, 1 ) = 'P' Or Substring ( a.id_cour_orig, 1, 1 ) = 'Q' )
					And 
					@iIdRel = 1
					And a.valide_le between @dtDate1Min and @dtDate1Max
					and s.valide_le = a.valide_le
					and CharIndex ( 'P001', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P118', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P119', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P037', a.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P107', a.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P120', a.txt_compo1, 1 ) = 0   
					And Not Exists (
						Select Top 1 1 
						From sysadm.archive a1
						Where a1.id_sin = a.id_sin
						And   a1.id_inter = a.id_inter
						And   ( a1.id_cour_orig = rtrim ( a1.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 )
								Or 
								a1.id_cour_orig = rtrim ( a1.cod_inter ) + 'LQ0' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 )
							  )
					)

				) 
				Or
				(
					( Substring ( a.id_cour_orig, 2, 5 ) = 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel - 1), 2 )
					  Or 
					  a.id_cour_orig = 'ALQ0' + Right ( '00' + Convert ( varchar, @iIdRel - 1), 2 )
					)
					And 
					@iIdRel > 1
					And 
					a.maj_le <= @dtDate2
					And
					a.maj_le > @dtDteMEp -- MEP
					And -- [PM407-1][20190408]
					sysadm.FN_CLE_VAL ( 'TRT_PAR', a.txt_compo2, ';') = 'KSL'
					And Not Exists (
						Select Top 1 1 
						From sysadm.archive a1
						Where a1.id_sin = a.id_sin
						And   a1.id_inter = a.id_inter
						And   a1.id_cour_orig = rtrim ( a.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 )
					)
					and s.valide_le = a.valide_le 
				) 
			)
	And		a.nbr_conf = 0
	And 	a.cod_inter='A'
	And		r.id_sin = a.id_sin
	And		r.alt_queue = 'N'
	And		s.id_sin = a.id_sin
	and    	s.cod_etat in ( 100, 550 )
	And		pers.id_ordre = s.id_ordre
	And		p.id_prod = s.id_prod
	And     i.id_sin = a.id_sin
	And     i.cod_inter = a.cod_inter
	And SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( s.id_sin, 2 ) <= 0  -- [RS3179]

	-- Relance UF Banque
		-- 'Messieurs' as civilite, 
		-- 'Messieurs' civilite_longue,
	Insert into @TbRelProd
	Select	
		a.id_sin,
		a.id_inter,
		Convert ( varchar (5), a.id_doc),
		'RBRED' + 
			Case 
				When sysadm.FN_CLE_VAL ( 'DERN_REL', @asValCar, ';' ) = 'OUI' 
					Then 'D'
				Else convert ( varchar ,@iIdRel )
			End as typ_mail,
		Case 
			When sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) = 'OUI' Then ''
			When sysadm.FN_CLE_VAL ( 'ENV_MAIL', @asValCar, ';' ) <> 'OUI' Then ''
			Else rtrim ( i.adr_mail )
		End 'adr_mail',
		convert ( varchar ,@iIdRel ) 'numero_relance',
		Case @iIdRel
			When 1 Then sysadm.FN_CLE_VAL ( 'JOINDRE_ORIG', @asValCar, ';' )
			Else Case 
					When isnumeric ( sysadm.FN_CLE_VAL ( 'ID_ARCH_ORIG', a.txt_compo2, ';') ) > 0 
						Then sysadm.FN_CLE_VAL ( 'JOINDRE_ORIG', @asValCar, ';' )
					Else 'NON'
				 End 
		End 'joindre_courrier_orig',
		Case @iIdRel
			When 1 Then Convert ( varchar (15), a.id_arch )
			Else Isnull ( nullif ( sysadm.FN_CLE_VAL ( 'ID_ARCH_ORIG', a.txt_compo2, ';'), '' ), '0' )
		End 'id_arch_orig',
		sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) 'env_en_recommande',
		sysadm.FN_CLE_VAL ( 'DERN_REL', @asValCar, ';' ) 'derniere_relance',
		Case @iIdRel
			When 1 Then Convert ( varchar (10), a.dte_edit, 20 )
			Else Convert ( VarChar (10), Convert ( DateTime, sysadm.FN_CLE_VAL ( 'DTE_EDIT_ORIG', a.txt_compo2, ';')), 20 )
		End 'date_cour_orig',
		Case @iIdRel
			When 1 Then ''
			Else Convert ( varchar (10), a.dte_edit, 20 )
		End 'date_dern_rel',
		'RELANCE_BANQUE_UF' 'categorie_relance',
		Case 
			When sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) = 'OUI' Then 'NON'
			When ( rtrim ( i.adr_mail ) = '' Or i.adr_mail is null ) Then 'NON'		
			Else sysadm.FN_CLE_VAL ( 'ENV_MAIL', @asValCar, ';' )
		End 'env_par_mail',
		0
		  
	From	sysadm.archive a,
			sysadm.routage r,
			sysadm.sinistre s,
			sysadm.personne pers,
			sysadm.produit p,
			sysadm.inter i,
			sysadm.w_gar_sin wg
	Where   a.id_prod = @adcIdProd
	And     ( 
				(
					( Substring ( a.id_cour_orig, 2, 1 ) = 'C' and Substring ( a.id_cour_orig, 4, 1 ) = 'P' Or Substring ( a.id_cour_orig, 1, 1 ) = 'Q' )
					And 
					@iIdRel = 1
					And 
					a.valide_le between @dtDate1Min and @dtDate1Max
					and s.valide_le = a.valide_le
					and CharIndex ( 'P001', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P118', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P119', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P037', a.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P107', a.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P120', a.txt_compo1, 1 ) = 0  
					And Not Exists (
						Select Top 1 1 
						From sysadm.archive a1
						Where a1.id_sin = a.id_sin
						And   a1.id_inter = a.id_inter
						And   ( a1.id_cour_orig = rtrim ( a.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 ))
					) 

				) 
				Or
				(
					( Substring ( a.id_cour_orig, 2, 5 ) = 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel - 1), 2 ) )
					And 
					@iIdRel > 1
					And 
					a.maj_le <= @dtDate2 
					And
					a.maj_le > '03/04/2019' -- MEP		
					And -- [PM407-1][20190408]
					sysadm.FN_CLE_VAL ( 'TRT_PAR', a.txt_compo2, ';') = 'KSL'
					And Not Exists (
						Select Top 1 1 
						From sysadm.archive a1
						Where a1.id_sin = a.id_sin
						And   a1.id_inter = a.id_inter
						And   a1.id_cour_orig = rtrim ( a.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 )
					) 
					and s.valide_le = a.valide_le
				) 
			)
	And		a.nbr_conf = 0
	And 	a.cod_inter='B'
	And		r.id_sin = a.id_sin
	And		r.alt_queue = 'N'
	And		s.id_sin = a.id_sin
	and    	s.cod_etat in ( 100, 550 )
	And		pers.id_ordre = s.id_ordre
	And		p.id_prod = s.id_prod
	And     i.id_sin = a.id_sin
	And     i.cod_inter = a.cod_inter
	And		wg.id_sin = s.id_sin
	And  	wg.id_gti = 7
	And		( 
				Exists ( 
					Select Top 1 1
					From   sysadm.w_piece wp
					Where  wp.id_sin = s.id_sin
					And	   wp.id_gti = 7 
					And	   wp.id_i = i.id_i
				)
				OR 
				(  wg.alt_att = 'O' )
			)
	And SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( s.id_sin, 2 ) <= 0  -- [RS3179]

END
Else
BEGIN
	-- Relance normales Assuré
	Insert into @TbRelProd 
	Select	
		a.id_sin,
		a.id_inter,
		Convert ( varchar (5), a.id_doc),
		'RBRED' + 
			Case 
				When sysadm.FN_CLE_VAL ( 'DERN_REL', @asValCar, ';' ) = 'OUI' 
					Then 'D'
				Else convert ( varchar ,@iIdRel )
			End as typ_mail,
		Case 
			When sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) = 'OUI' Then ''
			When sysadm.FN_CLE_VAL ( 'ENV_MAIL', @asValCar, ';' ) <> 'OUI' Then ''
			Else rtrim ( i.adr_mail )
		End 'adr_mail',
		convert ( varchar ,@iIdRel ) 'numero_relance',
		Case @iIdRel
			When 1 Then sysadm.FN_CLE_VAL ( 'JOINDRE_ORIG', @asValCar, ';' )
			Else Case 
					When isnumeric ( sysadm.FN_CLE_VAL ( 'ID_ARCH_ORIG', a.txt_compo2, ';') ) > 0 
						Then sysadm.FN_CLE_VAL ( 'JOINDRE_ORIG', @asValCar, ';' )
					Else 'NON'
				 End 
		End 'joindre_courrier_orig',
		Case @iIdRel
			When 1 Then Convert ( varchar (15), a.id_arch )
			Else Isnull ( nullif ( sysadm.FN_CLE_VAL ( 'ID_ARCH_ORIG', a.txt_compo2, ';'), '' ), '0' )
		End 'id_arch_orig',
		sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) 'env_en_recommande',
		sysadm.FN_CLE_VAL ( 'DERN_REL', @asValCar, ';' ) 'derniere_relance',
		Case @iIdRel
			When 1 Then Convert ( varchar(10), a.dte_edit, 20 )
			Else Convert ( VarChar (10), Convert ( DateTime, sysadm.FN_CLE_VAL ( 'DTE_EDIT_ORIG', a.txt_compo2, ';')), 20 )
		End 'date_cour_orig',
		Case @iIdRel
			When 1 Then ''
			Else Convert ( varchar (10), a.dte_edit, 20 )
		End 'date_dern_rel',
		'RELANCE_ASSURE' 'categorie_relance',
		Case 
			When sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) = 'OUI' Then 'NON'
			When ( rtrim ( i.adr_mail ) = '' Or i.adr_mail is null ) Then 'NON'
			Else sysadm.FN_CLE_VAL ( 'ENV_MAIL', @asValCar, ';' )
		End 'env_par_mail',
		0
  
	From	sysadm.archive a,
			sysadm.routage r,
			sysadm.sinistre s,
			sysadm.personne pers,
			sysadm.produit p,
			sysadm.inter i
	Where   a.id_prod = @adcIdProd
	And     ( 
				(
					( Substring ( a.id_cour_orig, 2, 1 ) = 'C' and Substring ( a.id_cour_orig, 4, 1 ) = 'P' Or Substring ( a.id_cour_orig, 1, 1 ) = 'Q' )
					And 
					@iIdRel = 1
					And a.valide_le between @dtDate1Min and @dtDate1Max
					and s.valide_le = a.valide_le
					and CharIndex ( 'P001', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P118', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P119', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P037', a.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P107', a.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P120', a.txt_compo1, 1 ) = 0   
					And Not Exists (
						Select Top 1 1 
						From sysadm.archive a1
						Where a1.id_sin = a.id_sin
						And   a1.id_inter = a.id_inter
						And   ( a1.id_cour_orig = rtrim ( a1.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 )
								Or 
								a1.id_cour_orig = rtrim ( a1.cod_inter ) + 'LQ0' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 )
							  )
					)

				) 
				Or
				(
					( Substring ( a.id_cour_orig, 2, 5 ) = 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel - 1), 2 )
					  Or 
					  a.id_cour_orig = 'ALQ0' + Right ( '00' + Convert ( varchar, @iIdRel - 1), 2 )
					)
					And 
					@iIdRel > 1
					And 
					a.maj_le <= @dtDate2
					And
					a.maj_le > @dtDteMEp -- MEP
					And -- [PM407-1][20190408]
					sysadm.FN_CLE_VAL ( 'TRT_PAR', a.txt_compo2, ';') = 'KSL'
					And Not Exists (
						Select Top 1 1 
						From sysadm.archive a1
						Where a1.id_sin = a.id_sin
						And   a1.id_inter = a.id_inter
						And   a1.id_cour_orig = rtrim ( a.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 )
					)
					and s.valide_le = a.valide_le 
				) 
			)
	And		a.nbr_conf = 0
	And 	a.cod_inter='A'
	And		r.id_sin = a.id_sin
	And		r.alt_queue = 'N'
	And		s.id_sin = a.id_sin
	and    	s.cod_etat in ( 100, 550 )
	And		pers.id_ordre = s.id_ordre
	And		p.id_prod = s.id_prod
	And     i.id_sin = a.id_sin
	And     i.cod_inter = a.cod_inter
	And SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( s.id_sin, 2 ) <= 0  -- [RS3179]

	-- Relance UF Banque
		-- 'Messieurs' as civilite, 
		-- 'Messieurs' civilite_longue,
	Insert into @TbRelProd
	Select	
		a.id_sin,
		a.id_inter,
		Convert ( varchar (5), a.id_doc),
		'RBRED' + 
			Case 
				When sysadm.FN_CLE_VAL ( 'DERN_REL', @asValCar, ';' ) = 'OUI' 
					Then 'D'
				Else convert ( varchar ,@iIdRel )
			End as typ_mail,
		Case 
			When sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) = 'OUI' Then ''
			When sysadm.FN_CLE_VAL ( 'ENV_MAIL', @asValCar, ';' ) <> 'OUI' Then ''
			Else rtrim ( i.adr_mail )
		End 'adr_mail',
		convert ( varchar ,@iIdRel ) 'numero_relance',
		Case @iIdRel
			When 1 Then sysadm.FN_CLE_VAL ( 'JOINDRE_ORIG', @asValCar, ';' )
			Else Case 
					When isnumeric ( sysadm.FN_CLE_VAL ( 'ID_ARCH_ORIG', a.txt_compo2, ';') ) > 0 
						Then sysadm.FN_CLE_VAL ( 'JOINDRE_ORIG', @asValCar, ';' )
					Else 'NON'
				 End 
		End 'joindre_courrier_orig',
		Case @iIdRel
			When 1 Then Convert ( varchar (15), a.id_arch )
			Else Isnull ( nullif ( sysadm.FN_CLE_VAL ( 'ID_ARCH_ORIG', a.txt_compo2, ';'), '' ), '0' )
		End 'id_arch_orig',
		sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) 'env_en_recommande',
		sysadm.FN_CLE_VAL ( 'DERN_REL', @asValCar, ';' ) 'derniere_relance',
		Case @iIdRel
			When 1 Then Convert ( varchar (10), a.dte_edit, 20 )
			Else Convert ( VarChar (10), Convert ( DateTime, sysadm.FN_CLE_VAL ( 'DTE_EDIT_ORIG', a.txt_compo2, ';')), 20 )
		End 'date_cour_orig',
		Case @iIdRel
			When 1 Then ''
			Else Convert ( varchar (10), a.dte_edit, 20 )
		End 'date_dern_rel',
		'RELANCE_BANQUE_UF' 'categorie_relance',
		Case 
			When sysadm.FN_CLE_VAL ( 'ENV_RECOM', @asValCar, ';' ) = 'OUI' Then 'NON'
			When ( rtrim ( i.adr_mail ) = '' Or i.adr_mail is null ) Then 'NON'		
			Else sysadm.FN_CLE_VAL ( 'ENV_MAIL', @asValCar, ';' )
		End 'env_par_mail',
		0
		  
	From	sysadm.archive a,
			sysadm.routage r,
			sysadm.sinistre s,
			sysadm.personne pers,
			sysadm.produit p,
			sysadm.inter i,
			sysadm.w_gar_sin wg
	Where   a.id_prod = @adcIdProd
	And     ( 
				(
					( Substring ( a.id_cour_orig, 2, 1 ) = 'C' and Substring ( a.id_cour_orig, 4, 1 ) = 'P' Or Substring ( a.id_cour_orig, 1, 1 ) = 'Q' )
					And 
					@iIdRel = 1
					And 
					a.valide_le between @dtDate1Min and @dtDate1Max
					and s.valide_le = a.valide_le
					and CharIndex ( 'P001', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P118', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P119', a.txt_compo1, 1 ) = 0
					And CharIndex ( 'P037', a.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P107', a.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P120', a.txt_compo1, 1 ) = 0  
					And Not Exists (
						Select Top 1 1 
						From sysadm.archive a1
						Where a1.id_sin = a.id_sin
						And   a1.id_inter = a.id_inter
						And   ( a1.id_cour_orig = rtrim ( a.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 ))
					) 

				) 
				Or
				(
					( Substring ( a.id_cour_orig, 2, 5 ) = 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel - 1), 2 ) )
					And 
					@iIdRel > 1
					And 
					a.maj_le <= @dtDate2 
					And
					a.maj_le > '03/04/2019' -- MEP		
					And -- [PM407-1][20190408]
					sysadm.FN_CLE_VAL ( 'TRT_PAR', a.txt_compo2, ';') = 'KSL'
					And Not Exists (
						Select Top 1 1 
						From sysadm.archive a1
						Where a1.id_sin = a.id_sin
						And   a1.id_inter = a.id_inter
						And   a1.id_cour_orig = rtrim ( a.cod_inter ) + 'LAX' + Right ( '00' + Convert ( varchar, @iIdRel ), 2 )
					) 
					and s.valide_le = a.valide_le
				) 
			)
	And		a.nbr_conf = 0
	And 	a.cod_inter='B'
	And		r.id_sin = a.id_sin
	And		r.alt_queue = 'N'
	And		s.id_sin = a.id_sin
	and    	s.cod_etat in ( 100, 550 )
	And		pers.id_ordre = s.id_ordre
	And		p.id_prod = s.id_prod
	And     i.id_sin = a.id_sin
	And     i.cod_inter = a.cod_inter
	And		wg.id_sin = s.id_sin
	And  	wg.id_gti = 7
	And		( 
				Exists ( 
					Select Top 1 1
					From   sysadm.w_piece wp
					Where  wp.id_sin = s.id_sin
					And	   wp.id_gti = 7 
					And	   wp.id_i = i.id_i
				)
				OR 
				(  wg.alt_att = 'O' )
			)
	And SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( s.id_sin, 2 ) <= 0  -- [RS3179]
END 


While Exists ( Select Top 1 1 From @TbRelProd where marquage = 0 )
	Begin
		Select 	Top 1 
			@iIdSeq = id_seq,
			@dcIdSin = id_sin,
			@dcIdInter = id_inter,
			@sIdDoc = id_doc,
			@sTypMail = typ_mail,
			@sAdrMail = IsNull ( adr_mail, ''),
			@sNumRelance = numero_relance,
			@sJoindreCourOrig = joindre_courrier_orig,
			@sIdArchOrig = id_arch_orig,
			@sEnvEnRecommande = env_en_recommande,
			@sDernRelance = derniere_relance,
			@sDteCourOrig = date_cour_orig,
			@sDteDerRel = date_dern_rel,
			@sCategorieRelance = categorie_relance,
			@sEnvParMail = env_par_mail
		From	@TbRelProd
		Where	marquage = 0

		-- Appel Obligatoire Pour pré-armer certaines variables technique non xml
		Set @iIdSin = Convert ( Integer, @dcIdSin ) 
		Set @sIdAppli = Space (10)
		Set @sLibProd = Space (255)
		Set @sMailSend = ''
		Set @sMailCc = ''
		Set @sMailObjet = 'Objet du mail construit par KSL'
		Set @sMailBody = 'Corps du mail construit par KSL'
		Set @aiIdChemForce  = null

		If @sEnvParMail <> 'OUI' 
			Begin
				Set @aiIdChemForce  = 5   -- Ejection vers un répertoire spécial pour KSL 
				Set @aiAMUedtPapier = @aiAMUedtPapier + 1
			End 

		If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
			Begin
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_S_PRE_ARMEMENT_TECHNIQUE
					2,			        --  @aiIdAppli	Integer,    -- Obligatoire
					@iIdSin,	-- @aiIdSin	Integer, -- Obligatoire
					@sIdAppli OutPut,  -- VarChar ( 10 ) OutPut,
					@iIdProd  OutPut,  -- Integer OutPut,
					@sLibProd OutPut,  -- VarChar ( 255 ) OutPut,
					@iIdEts   OutPut,  -- Integer OutPut,
					@sMailFrom	OutPut, -- VarChar (128) OUTPUT,  -- ''
					@sBoiteMail OutPut -- VarChar (35) OUTPUT -- ''			

				-- Appel Obligatoire pour déclarer le XML
				Exec @iIdXml = TRACE_MAIL_PRO.sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_SIMPA2 @dcIdSin, @dcIdInter, @iIdXml
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL @iIdXml, 'OUI', 'OUI', 'OUI'
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL @sTypMail, @sCodeMaquette OutPut

				-- Ajout personnalisé du client appelant le système
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'code_maquette', @sCodeMaquette
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'id_doc', @sIdDoc

				Set @sMailSend = @sAdrMail
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adr_mail', @sMailSend

				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'numero_relance', @sNumRelance
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'joindre_courrier_orig', @sJoindreCourOrig

				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'id_arch_orig', @sIdArchOrig
				Set @iIdArchOrig = @sIdArchOrig

				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'env_en_recommande', @sEnvEnRecommande
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'derniere_relance', @sDernRelance 
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'date_cour_orig', @sDteCourOrig
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'date_dern_rel', @sDteDerRel
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'categorie_relance', @sCategorieRelance
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'env_par_mail', @sEnvParMail 

				-- Appel pour construire et récupérer le XML dans @xmlResult
				Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE @iIdXml, @sCodeMaquette, @sXMLVar OUTPUT

				Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_RS5045_I_MAIL_PUSH_KSL
					@sIdAppli,
					@iIdSin,
					@iIdProd,
					@sLibProd,
					@iIdEts,
					@sMailFrom,
					@sMailSend,
					@sMailCc,
					null,
					@sMailObjet,
					@sMailBody,
					@sBoiteMail,
					@sTypMail,
					2,
					@iIdArchOrig,
					@sXMLVar,
					@aiIdChemForce, -- id_chem, peut être forcé mais si null, sera pris par défaut sysadm.code_maquette_ksl_rs5045
					null, -- dteh_exec
					@sErrOutPut OutPut

			End    -- TRACE_MAIL_PRO : Fin écriture
			Else
			Begin
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_S_PRE_ARMEMENT_TECHNIQUE
					2,			        --  @aiIdAppli	Integer,    -- Obligatoire
					@iIdSin,	-- @aiIdSin	Integer, -- Obligatoire
					@sIdAppli OutPut,  -- VarChar ( 10 ) OutPut,
					@iIdProd  OutPut,  -- Integer OutPut,
					@sLibProd OutPut,  -- VarChar ( 255 ) OutPut,
					@iIdEts   OutPut,  -- Integer OutPut,
					@sMailFrom	OutPut, -- VarChar (128) OUTPUT,  -- ''
					@sBoiteMail OutPut -- VarChar (35) OUTPUT -- ''			

				-- Appel Obligatoire pour déclarer le XML
				Exec @iIdXml = TRACE_MAIL_TRT.sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_SIMPA2 @dcIdSin, @dcIdInter, @iIdXml
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL @sTypMail, @sCodeMaquette OutPut

				-- Ajout personnalisé du client appelant le système
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'code_maquette', @sCodeMaquette
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'id_doc', @sIdDoc

				Set @sMailSend = @sAdrMail
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adr_mail', @sMailSend

				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'numero_relance', @sNumRelance
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'joindre_courrier_orig', @sJoindreCourOrig

				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'id_arch_orig', @sIdArchOrig
				Set @iIdArchOrig = @sIdArchOrig

				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'env_en_recommande', @sEnvEnRecommande
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'derniere_relance', @sDernRelance 
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'date_cour_orig', @sDteCourOrig
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'date_dern_rel', @sDteDerRel
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'categorie_relance', @sCategorieRelance
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'env_par_mail', @sEnvParMail 

				-- Appel pour construire et récupérer le XML dans @xmlResult
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL @iIdXml, 'OUI', 'OUI', 'OUI'
				Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE @iIdXml, @sCodeMaquette, @sXMLVar OUTPUT

				Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_RS5045_I_MAIL_PUSH_KSL
					@sIdAppli,
					@iIdSin,
					@iIdProd,
					@sLibProd,
					@iIdEts,
					@sMailFrom,
					@sMailSend,
					@sMailCc,
					null,
					@sMailObjet,
					@sMailBody,
					@sBoiteMail,
					@sTypMail,
					2,
					@iIdArchOrig,
					@sXMLVar,
					@aiIdChemForce, -- id_chem, peut être forcé mais si null, sera pris par défaut sysadm.code_maquette_ksl_rs5045
					null, -- dteh_exec
					@sErrOutPut OutPut

			End    -- TRACE_MAIL_TRT : Fin écriture

		Set @dcIdDoc = CONVERT ( Decimal (7), @sIdDoc )
		Set @iNumRelance = CONVERT ( integer, @sNumRelance )

		Exec sysadm.PS_U_PM407_MARQUAGE_RELANCE_RS6005
				@dcIdSin,
				@dcIdInter,
				@dcIdDoc,
				@iNumRelance,
				@sJoindreCourOrig,
				@iIdArchOrig,
				@sEnvEnRecommande,
				@sDernRelance,
				@sEnvParMail

		Update @TbRelProd Set marquage = 1 Where id_seq = @iIdSeq
	End

Go


