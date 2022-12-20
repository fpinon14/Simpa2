-------------------------------------------------------------------
--
-- Fichier              :       WEBSIM2_LECTURE_DONNEES_LISTE.CP
-- Auteur               :       FPI
-- Date                 :       07/2010
--
-- Commentaires         :       [PC321]
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_LECTDONN_LISTE_SAV_CARR
-- Auteur               :       F. Pinon
-- Date                 :       28/07/2010 
-- Libelle              :        
-- Commentaires         :       Procédure de lecture de liste de sinistres
--                               
-- References           :       
--
-- Arguments            :       @asVarSeria             VarChar(500)		(Val) Variable sérialisée contenant les critères de recherche
--				@asCas                  VarChar(50)		(Val) Cas de traitement
--				@asIdSession     	varchar(50)		(Val) Identifiant de session
--				@asBrowser       	varchar(200)		(Val) Identification du browser Web
--                              @asLangage              VarChar (  3 )          (Val) Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--				@aiCodeMsg		Integer			(Réf) Code message (table message)
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       Integer                 >0 = OK
--                                                      -1 = NOK
--
-------------------------------------------------------------------
-- FPI - 01/08/2013 - [PC954] On se base sur l'option 141
-- FPI - 29/10/2014 - [ITSM245060] Prise en compte du forçage de PEC
-- FPI - 18/05/2015 - Refonte pour meilleurs perfs
-- JFF      12/02/2016   [PI062]
-- FPI	- 04/01/2016	[PC151255] ajout du lib_police + dp141
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_LECTDONN_LISTE_SAV_CARR' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_LECTDONN_LISTE_SAV_CARR
GO

CREATE PROCEDURE sysadm.PS_WEBSIM2_LECTDONN_LISTE_SAV_CARR
	@asVarSeria             VarChar(500),
	@asCas                  VarChar(50),
	@asIdSession     	varchar(50),
	@asBrowser       	varchar(200),
	@asLangage              VarChar (3),
	@aiCodeMsg		Integer OUTPUT,
        @asRetourMess           VarChar ( 2000 ) OUTPUT 

AS
Declare @iRet	integer
Declare @dcIdSin decimal(10,0) -- [PI062]
Declare	@sIdSin  varchar(10) -- [PI062]
Declare	@sNom  varchar(35)
Declare	@sNumBonVente  varchar(35)
Declare @sCodMag varchar(20), @iIdBoutique integer
Declare @dtMoinsUnAn datetime -- [PC151255]
Declare @sSiteSav varchar(20)-- [PC151255]

-- Shunter cet appel pour repartir sur l'ancienne requête plus.
Exec @iRet = sysadm.PS_WEBSIM2_LECTDONN_LISTE_SAV_CARR_JFF @asVarSeria, @asCas, @asIdSession, @asBrowser, @asLangage, @aiCodeMsg OUTPUT, @asRetourMess OUTPUT
Return @iRet

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

Select @iRet=1, @asRetourMess='OK',
	@dtMoinsUnAn=DATEADD(year, -1, getdate())

Select 	@sIdSin = sysadm.FN_CLE_VAL('ID_SIN',@asVarSeria,';'),
	@sNom = Upper(sysadm.FN_CLE_VAL('NOM',@asVarSeria,';')),
	@sNumBonVente = sysadm.FN_CLE_VAL('NUM_BON_VENTE',@asVarSeria,';'),
	@sCodMag = sysadm.FN_CLE_VAL('COD_MAG',@asVarSeria,';'),
	@sSiteSav = sysadm.FN_CLE_VAL('SITE',@asVarSeria,';')

if rtrim(@sNom) = '' Set @sNom = Upper(sysadm.FN_CLE_VAL('NOM_ASSURE',@asVarSeria,';'))

if rtrim(@sIdSin) = '' Set @sIdSin=NULL
if rtrim(@sNom) = '' Set @sNom=NULL
if rtrim(@sNumBonVente) = '' Set @sNumBonVente=NULL
if rtrim(@sCodMag) = '' Set @sCodMag=NULL
if rtrim(@sSiteSav)='' Set @sSiteSav='CV'

Set @dcIdSin=convert(decimal(10,0),@sIdSin) -- [PI062]
Set @iIdBoutique=convert(integer,@sCodMag)

Declare @tb TABLE (id_sin decimal(10,0)) -- [PI062]

Insert into @tb
Select  s.id_sin
From	sysadm.commande c
	inner join sysadm.sinistre s on s.id_sin=c.id_sin
	inner join sysadm.personne p on p.id_ordre = s.id_ordre
	inner join sysadm.div_sin dv on s.id_sin=dv.id_sin 
	left outer join sysadm.det_pro dp on dp.id_prod=s.id_prod and dp.id_code_dp=141
Where  	c.id_four = 'SCR'
and c.cree_le > @dtMoinsUnAn -- [PC151255]
and	(@dcIdSin is null or c.id_sin = @dcIdSin)
and 	dv.nom_zone='num_bon_vente'
And ((@sSiteSav ='CV' and sysadm.FN_CLE_VAL('SITE_SAV',isnull(dp.val_car,''),';')='')
	or @sSiteSav=sysadm.FN_CLE_VAL('SITE_SAV',isnull(dp.val_car,''),';'))
And 	(@sNom is null or p.nom = @sNom)
and     (@sNumBonVente is null or dv.val_car=@sNumBonVente)
and	(@iIdBoutique is null or s.id_orian_boutique = @iIdBoutique)

Insert into @tb
Select  s.id_sin
From	sysadm.sinistre s 
	inner join sysadm.personne p on p.id_ordre = s.id_ordre
	inner join sysadm.div_sin dv on s.id_sin=dv.id_sin 
	inner join sysadm.det_pro d on d.id_prod=s.id_prod
	left outer join sysadm.det_pro dp on dp.id_prod=s.id_prod and dp.id_code_dp=141
where s.cree_le > @dtMoinsUnAn -- [20170106].FPI
and d.id_code_dp=141
and	(@dcIdSin is null or s.id_sin = @dcIdSin)
and 	dv.nom_zone='num_bon_vente'
And ((@sSiteSav ='CV' and sysadm.FN_CLE_VAL('SITE_SAV',isnull(dp.val_car,''),';')='')
	or @sSiteSav=sysadm.FN_CLE_VAL('SITE_SAV',isnull(dp.val_car,''),';'))
And 	(@sNom is null or p.nom = @sNom)
and     (@sNumBonVente is null or dv.val_car=@sNumBonVente)
and 	(s.cod_etat not in (200,600) 
	  or (s.cod_etat in (200,600) and dateadd(month,-1,s.valide_le) < getdate())
	)
	
Select  s.id_sin,
	sysadm.FN_CODE_NUM ( p.cod_civ, '-CI' ) 'civilite',
	p.nom 'nom',
	p.prenom 'prenom',
	dv.val_car 'num_bon_vente',
	convert(varchar(10),s.dte_ach_port,103) 'dte_achat',
	s.marq_port 'marque_app',
	s.modl_port 'modele_app',
	s.cod_etat 'etat_dossier',
	d.mt_val_achat,
	Case When exists (select top 1 * from sysadm.w_piece pi where pi.id_sin=s.id_sin) Then 2016
	When exists (select top 1 * from sysadm.refus rf where rf.id_sin=s.id_sin) and dd.val_car <> 'O' Then 2018
	When exists (select * from sysadm.commande c2 where c2.id_sin=s.id_sin and id_ref_four='BON_ACHAT') 
		and dp.val_car not like '%SITE_SAV=PMI%' Then 2017
	When exists (select * from sysadm.commande c2 where c2.id_sin=s.id_sin and c2.id_four='O2M' and c2.info_spb_frn in (1442,1443,1425) ) Then 2019
	Else c.info_spb_frn End  'etat_presta_sav',
	d.id_gti,
	sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' ) 'etat_dossier',
	s.id_prod,
	sysadm.FN_LIB_POLICE(s.id_sin) as lib_police
From @tb t	
	inner join sysadm.commande c on c.id_sin=t.id_sin
	inner join sysadm.sinistre s on s.id_sin=c.id_sin
	inner join sysadm.personne p on p.id_ordre = s.id_ordre
	inner join sysadm.detail d on s.id_sin=d.id_sin and d.id_detail=c.id_detail and d.id_gti=c.id_gti
	inner join sysadm.div_sin dv on s.id_sin=dv.id_sin 
	left outer join sysadm.div_det dd on dd.id_sin=d.id_sin and dd.id_detail=d.id_detail and dd.id_gti=dd.id_gti
		and dd.nom_zone='alt_pec' -- [ITSM245060]
	left outer join sysadm.det_pro dp on dp.id_prod=s.id_prod and dp.id_code_dp=141
Where  	c.id_four = 'SCR'
	and 	dv.nom_zone='num_bon_vente'
Union
Select  s.id_sin,
	sysadm.FN_CODE_NUM ( p.cod_civ, '-CI' ) 'civilite',
	p.nom 'nom',
	p.prenom 'prenom',
	dv.val_car 'num_bon_vente',
	convert(varchar(10),s.dte_ach_port,103) 'dte_achat',
	s.marq_port 'marque_app',
	s.modl_port 'modele_app',
	s.cod_etat 'etat_dossier',
	(select max(d.mt_val_achat) from sysadm.detail d where d.id_sin=s.id_sin and d.id_gti=g.id_gti) 'mt_val_achat',
	Case When exists (select top 1 * from sysadm.w_piece pi where pi.id_sin=s.id_sin) Then 2016
	When exists (select top 1 * from sysadm.refus rf where rf.id_sin=s.id_sin) Then 2018
	When exists (select * from sysadm.commande c2 where c2.id_sin=s.id_sin and id_ref_four='BON_ACHAT') Then 2017
	When exists (select * from sysadm.commande c2 where c2.id_sin=s.id_sin and c2.id_four='O2M' and c2.info_spb_frn in (1442,1443,1425) ) Then 2019
	Else '' End  'etat_presta_sav',
	g.id_gti,
	sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' ) 'etat_dossier',
	s.id_prod,
	sysadm.FN_LIB_POLICE(s.id_sin) as lib_police
From	@tb t
	inner join sysadm.sinistre s on s.id_sin=t.id_sin
	inner join sysadm.personne p on p.id_ordre = s.id_ordre
	inner join sysadm.gar_sin g on g.id_sin=s.id_sin 
	inner join sysadm.div_sin dv on s.id_sin=dv.id_sin 
	inner join sysadm.det_pro d on d.id_prod=s.id_prod
where dv.nom_zone='num_bon_vente'
and 	(g.id_gti=10 -- Vol
	or (g.id_gti=11 and not exists (select * from sysadm.commande c where c.id_sin=s.id_sin and c.id_four = 'SCR'))
	 )

Return @iRet

Go

grant execute on sysadm.PS_WEBSIM2_LECTDONN_LISTE_SAV_CARR to rolebddsinistres
go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_LECTDONN_LISTE_SAV_CARR_JFF
-- Auteur               :       FABRY JF
-- Date                 :       06/02/2017 
-- Libelle              :        
-- Commentaires         :       Procédure PS_WEBSIM2_LECTDONN_LISTE_SAV_CARR refaite par JFF
--                               
-- References           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_LECTDONN_LISTE_SAV_CARR_JFF' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_LECTDONN_LISTE_SAV_CARR_JFF
GO

CREATE PROCEDURE sysadm.PS_WEBSIM2_LECTDONN_LISTE_SAV_CARR_JFF
	@asVarSeria             VarChar(500),
	@asCas                  VarChar(50),
	@asIdSession     	varchar(50),
	@asBrowser       	varchar(200),
	@asLangage              VarChar (3),
	@aiCodeMsg		Integer OUTPUT,
    @asRetourMess           VarChar ( 2000 ) OUTPUT 

AS
Declare @iRet	integer
Declare @dcIdSin decimal(10,0) -- [PI062]
Declare	@sIdSin  varchar(10) -- [PI062]
Declare	@sNom  varchar(35)
Declare	@sNumBonVente  varchar(35)
Declare @sCodMag varchar(20), @iIdBoutique integer
Declare @dtMoinsUnAn datetime -- [PC151255]
Declare @sSiteSav varchar(20)-- [PC151255]
Declare @iTableType integer 
Declare @iCodeCritere1erTour integer 
Declare @iMaxNbreCritere integer 
Declare @iCptCritere integer 
Declare @iTour integer 

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal ( 10 ),
	  nom		VarChar ( 100 ),
	  num_bon_vente VarChar ( 100 ),
	  id_boutique   integer,
	  site_sav  VarChar ( 100 ),
	  tour	integer null 
	)

Select @iRet=1, @asRetourMess='OK',
	@dtMoinsUnAn=DATEADD(year, -1, getdate())

Select 	@sIdSin = sysadm.FN_CLE_VAL('ID_SIN',@asVarSeria,';'),
	@sNom = Upper(sysadm.FN_CLE_VAL('NOM',@asVarSeria,';')),
	@sNumBonVente = sysadm.FN_CLE_VAL('NUM_BON_VENTE',@asVarSeria,';'),
	@sCodMag = sysadm.FN_CLE_VAL('COD_MAG',@asVarSeria,';'),
	@sSiteSav = sysadm.FN_CLE_VAL('SITE',@asVarSeria,';')

if rtrim(@sNom) = '' Set @sNom = Upper(sysadm.FN_CLE_VAL('NOM_ASSURE',@asVarSeria,';'))

if rtrim(@sIdSin) = '' Set @sIdSin=NULL
if rtrim(@sNom) = '' Set @sNom=NULL
if rtrim(@sNumBonVente) = '' Set @sNumBonVente=NULL
if rtrim(@sCodMag) = '' Set @sCodMag=NULL
if rtrim(@sSiteSav)='' Set @sSiteSav='CV'

Set @dcIdSin=convert(decimal(10,0),@sIdSin) -- [PI062]
Set @iIdBoutique=convert(integer,@sCodMag)

--------------------------------------
-- 1er Cas, 1er tour sur Table Réél --
--------------------------------------
	Set @iTableType = 1
	Set @iCodeCritere1erTour = 0
	Set @iMaxNbreCritere = 5
	Set @iTour = 1

	-- Traitment id_sin
	If @sIdSin is not null And @iTableType = 1
	 Begin 

		Insert into @tb
		Select  c.id_sin,
				p.nom,
				( Select rtrim ( ds.val_car )
				  From   sysadm.div_sin ds
				  Where  ds.id_sin = s.id_sin
				  And	 ds.nom_zone = 'num_bon_vente'
				),
				s.id_orian_boutique,
				IsNull ( 
					NullIf ( 
						IsNull ( 
						( Select sysadm.FN_CLE_VAL('SITE_SAV',isnull(dp.val_car,''),';')
						  From   sysadm.det_pro dp
						  Where  dp.id_prod = s.id_prod 
						  And    dp.id_code_dp=141 
						), '' ),
					'' ),
				'CV'),
				@iTour
		From	sysadm.commande c,
				sysadm.sinistre s,
				sysadm.personne p
		Where   s.id_sin = @dcIdSin
		And     c.id_sin = s.id_sin 
		And		c.id_four = 'SCR'
		And     c.cree_le > @dtMoinsUnAn
		and		p.id_ordre = s.id_ordre

		If @@ROWCOUNT > 0 
		  Begin	
			Set @iTableType = 2
			Set @iCodeCritere1erTour = 1
		  End

	 End

	-- Traitment Nom
	If @sNom is not null And @iTableType = 1
	 Begin 
		Insert into @tb
		Select  c.id_sin,
				p.nom,
				( Select rtrim ( ds.val_car )
				  From   sysadm.div_sin ds
				  Where  ds.id_sin = s.id_sin
				  And	 ds.nom_zone = 'num_bon_vente'
				),
				s.id_orian_boutique,
				IsNull ( 
					NullIf ( 
						IsNull ( 
						( Select sysadm.FN_CLE_VAL('SITE_SAV',isnull(dp.val_car,''),';')
						  From   sysadm.det_pro dp
						  Where  dp.id_prod = s.id_prod 
						  And    dp.id_code_dp=141 
						), '' ),
					'' ),
				'CV'),
				@iTour
		From	sysadm.commande c,
				sysadm.sinistre s,
				sysadm.personne p
		Where   c.id_sin = s.id_sin 
		And		c.id_four = 'SCR'
		And     c.cree_le > @dtMoinsUnAn
		and		p.id_ordre = s.id_ordre
		And		p.nom = @sNom

		If @@ROWCOUNT > 0 
		  Begin	
			Set @iTableType = 2
			Set @iCodeCritere1erTour = 2
		  End
	 End

	 -- Traitment NumBonVente
	If @sNumBonVente is not null And @iTableType = 1
	 Begin 
		Insert into @tb
		Select  c.id_sin,
				p.nom,
				rtrim ( ds.val_car ),
				s.id_orian_boutique,
				IsNull ( 
					NullIf ( 
						IsNull ( 
						( Select sysadm.FN_CLE_VAL('SITE_SAV',isnull(dp.val_car,''),';')
						  From   sysadm.det_pro dp
						  Where  dp.id_prod = s.id_prod 
						  And    dp.id_code_dp=141 
						), '' ),
					'' ),
				'CV'),
				@iTour
		From	sysadm.commande c,
				sysadm.sinistre s,
				sysadm.personne p,
				sysadm.div_sin ds
		Where   c.id_sin = s.id_sin 
		And		c.id_four = 'SCR'
		And     c.cree_le > @dtMoinsUnAn
		and		p.id_ordre = s.id_ordre
		And		ds.id_sin = s.id_sin
		And		ds.nom_zone = 'num_bon_vente'
		And		ds.val_car = @sNumBonVente
	
		If @@ROWCOUNT > 0 
		  Begin	
			Set @iTableType = 2
			Set @iCodeCritere1erTour = 3
		  End
	 End

	 -- Traitment id_boutique (cod_mag)
	If @sCodMag is not null And @iTableType = 1
	 Begin 
		Insert into @tb
		Select  c.id_sin,
				p.nom,
				( Select rtrim ( ds.val_car )
				  From   sysadm.div_sin ds
				  Where  ds.id_sin = s.id_sin
				  And	 ds.nom_zone = 'num_bon_vente'
				),
				s.id_orian_boutique,
				IsNull ( 
					NullIf ( 
						IsNull ( 
						( Select sysadm.FN_CLE_VAL('SITE_SAV',isnull(dp.val_car,''),';')
						  From   sysadm.det_pro dp
						  Where  dp.id_prod = s.id_prod 
						  And    dp.id_code_dp=141 
						), '' ),
					'' ),
				'CV'),
				@iTour
		From	sysadm.commande c,
				sysadm.sinistre s,
				sysadm.personne p
		Where   c.id_sin = s.id_sin 
		And		c.id_four = 'SCR'
		And     c.cree_le > @dtMoinsUnAn
		and		p.id_ordre = s.id_ordre
		And		s.id_orian_boutique = @iIdBoutique
	
		If @@ROWCOUNT > 0 
		  Begin	
			Set @iTableType = 2
			Set @iCodeCritere1erTour = 4
		  End
	 End

	-- Traitement site SAV (en dernier toujours)
	If @iTableType = 1
	 Begin 
		Insert into @tb
		Select  c.id_sin,
				p.nom,
				( Select rtrim ( ds.val_car )
				  From   sysadm.div_sin ds
				  Where  ds.id_sin = s.id_sin
				  And	 ds.nom_zone = 'num_bon_vente'
				),
				s.id_orian_boutique,
				IsNull ( 
					NullIf ( 
						IsNull ( 
						( Select sysadm.FN_CLE_VAL('SITE_SAV',isnull(dp.val_car,''),';')
						  From   sysadm.det_pro dp
						  Where  dp.id_prod = s.id_prod 
						  And    dp.id_code_dp=141 
						), '' ),
					'' ),
				'CV'),
				@iTour
		From	sysadm.commande c,
				sysadm.sinistre s,
				sysadm.personne p
		Where   c.id_four = 'SCR'
		And     c.cree_le > @dtMoinsUnAn
		And		c.id_sin = s.id_sin 
		and		p.id_ordre = s.id_ordre
	
		If @@ROWCOUNT > 0 
		  Begin	
			Set @iTableType = 2
			Set @iCodeCritere1erTour = 5
		  End
	 End

------------------------------------------
-- 1er Cas, Fin 1er tour sur Table Réél --
------------------------------------------

---------------------------------------
-- 2ème Cas, 1er tour sur Table Réél --
---------------------------------------
	Set @iTableType = 1
	Set @iCodeCritere1erTour = 0

	-- Traitment id_sin
	If @sIdSin is not null And @iTableType = 1
	 Begin 
		Insert into @tb
		Select  s.id_sin,
				p.nom,
				( Select rtrim ( ds.val_car )
				  From   sysadm.div_sin ds
				  Where  ds.id_sin = s.id_sin
				  And	 ds.nom_zone = 'num_bon_vente'
				),
				s.id_orian_boutique,
				IsNull ( 
					NullIf ( 
						IsNull ( 
						( Select sysadm.FN_CLE_VAL('SITE_SAV',isnull(dp.val_car,''),';')
						  From   sysadm.det_pro dp
						  Where  dp.id_prod = s.id_prod 
						  And    dp.id_code_dp=141 
						), '' ),
					'' ),
				'CV'),
				2 -- 1er tour
		From	sysadm.sinistre s,
				sysadm.personne p
		Where   s.id_sin = @dcIdSin
		And     s.cree_le > @dtMoinsUnAn
		and		p.id_ordre = s.id_ordre
		and 	(s.cod_etat not in (200,600) 
				 or 
				 (s.cod_etat in (200,600) and dateadd(month,-1,s.valide_le) < getdate())
				)
		And     Not Exists ( 
					Select Top 1 1
					From   sysadm.commande c
					Where  c.id_sin = s.id_sin
					And    c.id_four = 'SCR'
					And    c.cree_le > @dtMoinsUnAn
				)

		If @@ROWCOUNT > 0 
		  Begin	
			Set @iTableType = 2
			Set @iCodeCritere1erTour = 1
		  End

	 End

	-- Traitment Nom
	If @sNom is not null And @iTableType = 1
	 Begin 
		Insert into @tb
		Select  s.id_sin,
				p.nom,
				( Select rtrim ( ds.val_car )
				  From   sysadm.div_sin ds
				  Where  ds.id_sin = s.id_sin
				  And	 ds.nom_zone = 'num_bon_vente'
				),
				s.id_orian_boutique,
				IsNull ( 
					NullIf ( 
						IsNull ( 
						( Select sysadm.FN_CLE_VAL('SITE_SAV',isnull(dp.val_car,''),';')
						  From   sysadm.det_pro dp
						  Where  dp.id_prod = s.id_prod 
						  And    dp.id_code_dp=141 
						), '' ),
					'' ),
				'CV'),
				2 -- 1er tour
		From	sysadm.sinistre s,
				sysadm.personne p
		Where   s.cree_le > @dtMoinsUnAn
		and		p.id_ordre = s.id_ordre
		And		p.nom = @sNom
		And     Not Exists ( 
			Select Top 1 1
			From   sysadm.commande c
			Where  c.id_sin = s.id_sin
			And    c.id_four = 'SCR'
			And    c.cree_le > @dtMoinsUnAn
		)

		If @@ROWCOUNT > 0 
		  Begin	
			Set @iTableType = 2
			Set @iCodeCritere1erTour = 2
		  End
	 End

	 -- Traitment NumBonVente
	If @sNumBonVente is not null And @iTableType = 1
	 Begin 
		Insert into @tb
		Select  s.id_sin,
				p.nom,
				rtrim ( ds.val_car ),
				s.id_orian_boutique,
				IsNull ( 
					NullIf ( 
						IsNull ( 
						( Select sysadm.FN_CLE_VAL('SITE_SAV',isnull(dp.val_car,''),';')
						  From   sysadm.det_pro dp
						  Where  dp.id_prod = s.id_prod 
						  And    dp.id_code_dp=141 
						), '' ),
					'' ),
				'CV'),
				2 -- 1er tour
		From	sysadm.sinistre s,
				sysadm.personne p,
				sysadm.div_sin ds
		Where   s.cree_le > @dtMoinsUnAn
		and		p.id_ordre = s.id_ordre
		And		ds.id_sin = s.id_sin
		And		ds.nom_zone = 'num_bon_vente'
		And		ds.val_car = @sNumBonVente
		And     Not Exists ( 
			Select Top 1 1
			From   sysadm.commande c
			Where  c.id_sin = s.id_sin
			And    c.id_four = 'SCR'
			And    c.cree_le > @dtMoinsUnAn
		)
	
		If @@ROWCOUNT > 0 
		  Begin	
			Set @iTableType = 2
			Set @iCodeCritere1erTour = 3
		  End
	 End

	 -- Traitment id_boutique (cod_mag)
	If @sCodMag is not null And @iTableType = 1
	 Begin 
		Insert into @tb
		Select  s.id_sin,
				p.nom,
				( Select rtrim ( ds.val_car )
				  From   sysadm.div_sin ds
				  Where  ds.id_sin = s.id_sin
				  And	 ds.nom_zone = 'num_bon_vente'
				),
				s.id_orian_boutique,
				IsNull ( 
					NullIf ( 
						IsNull ( 
						( Select sysadm.FN_CLE_VAL('SITE_SAV',isnull(dp.val_car,''),';')
						  From   sysadm.det_pro dp
						  Where  dp.id_prod = s.id_prod 
						  And    dp.id_code_dp=141 
						), '' ),
					'' ),
				'CV'),
				1 -- 1er tour
		From	sysadm.sinistre s,
				sysadm.personne p
		Where   s.cree_le > @dtMoinsUnAn
		and		p.id_ordre = s.id_ordre
		And		s.id_orian_boutique = @iIdBoutique
		And     Not Exists ( 
			Select Top 1 1
			From   sysadm.commande c
			Where  c.id_sin = s.id_sin
			And    c.id_four = 'SCR'
			And    c.cree_le > @dtMoinsUnAn
		)
	
		If @@ROWCOUNT > 0 
		  Begin	
			Set @iTableType = 2
			Set @iCodeCritere1erTour = 4
		  End
	 End

	-- Traitment site SAV (CV)
	If @iTableType = 1
	 Begin 
		Insert into @tb
		Select  s.id_sin,
				p.nom,
				( Select rtrim ( ds.val_car )
				  From   sysadm.div_sin ds
				  Where  ds.id_sin = s.id_sin
				  And	 ds.nom_zone = 'num_bon_vente'
				),
				s.id_orian_boutique,
				IsNull ( 
					NullIf ( 
						IsNull ( 
						( Select sysadm.FN_CLE_VAL('SITE_SAV',isnull(dp.val_car,''),';')
						  From   sysadm.det_pro dp
						  Where  dp.id_prod = s.id_prod 
						  And    dp.id_code_dp=141 
						), '' ),
					'' ),
				'CV'),
				1 -- 1er tour
		From	sysadm.sinistre s,
				sysadm.personne p
		Where   s.cree_le > @dtMoinsUnAn
		and		p.id_ordre = s.id_ordre
		And		Not Exists ( 
					Select Top 1 1 
					From   sysadm.det_pro dp
					Where  dp.id_prod = s.id_prod 
					And    dp.id_code_dp=141
				)
		And     Not Exists ( 
			Select Top 1 1
			From   sysadm.commande c
			Where  c.id_sin = s.id_sin
			And    c.id_four = 'SCR'
			And    c.cree_le > @dtMoinsUnAn
		)
	
		If @@ROWCOUNT > 0 
		  Begin	
			Set @iTableType = 2
			Set @iCodeCritere1erTour = 5
		  End
	 End

-------------------------------------------
-- 2ème Cas, Fin 1er tour sur Table Réél --
-------------------------------------------
-----------------------------------------
-- 2ème Cas, 2ème tour sur Table Tempo --
-----------------------------------------
Set @iCptCritere = 1

While @iCptCritere <= @iMaxNbreCritere And @iTableType = 2
 Begin

	-- Traitment id_sin
	If @sIdSin is not null And @iCptCritere = 1 -- And @iCodeCritere1erTour <> @iCptCritere 
	 Begin 
		Delete @tb Where  id_sin <> @dcIdSin
	 End

	-- Traitment Nom
	If @sNom is not null And @iCptCritere = 2 -- And @iCodeCritere1erTour <> @iCptCritere 
	 Begin 
		Delete @tb Where  nom <> @sNom or nom is null
	 End

	 -- Traitment NumBonVente
	If @sNumBonVente is not null And @iCptCritere = 3 -- And @iCodeCritere1erTour <> @iCptCritere 
	 Begin 
		Delete @tb Where  num_bon_vente <> @sNumBonVente or num_bon_vente is null
	 End

	 -- Traitment id_boutique (cod_mag)
	If @sCodMag is not null And @iCptCritere = 4 -- And @iCodeCritere1erTour <> @iCptCritere 
	 Begin 
		Delete @tb Where  id_boutique <> @iIdBoutique Or id_boutique is null
	 End

	-- Traitment site SAV 
	If @iCptCritere = 5 -- And @iCodeCritere1erTour <> @iCptCritere 
	 Begin 
		Delete @tb Where  site_sav <> @sSiteSav OR site_sav is null
	 End

	 Set @iCptCritere = @iCptCritere + 1
 End 

-----------------------------------------
-- 2ème Cas, 2ème tour sur Table Tempo --
-----------------------------------------
Insert into @tb
Select distinct  
		id_sin,
		nom,
		num_bon_vente,
		id_boutique,
		site_sav,
		3
From	@tb

Delete @tb Where tour < 3

------------------
-- Select Final --
------------------

Select  t.id_sin,
		sysadm.FN_CODE_NUM ( p.cod_civ, '-CI' ) 'civilite',
		p.nom 'nom',
		p.prenom 'prenom',
		rTrim ( ds.val_car ) 'num_bon_vente',
		sysadm.FN_AFF_DATE ( s.dte_ach_port, 'SH' ) 'dte_achat',
		s.marq_port 'marque_app',
		s.modl_port 'modele_app',
		s.cod_etat 'etat_dossier',
		d.mt_val_achat,
		Case 
			When exists (select top 1 1 from sysadm.w_piece pc where pc.id_sin = s.id_sin) Then '2016' 
			When exists (select top 1 1 from sysadm.refus rf where rf.id_sin = s.id_sin ) and
				 Not Exists ( 
					Select top 1 1 
					From	sysadm.div_det dd
					Where   dd.id_sin = c.id_sin
					And		dd.id_gti = c.id_gti
					And		dd.id_detail = c.id_detail
					And		dd.val_car = 'O'
				 ) Then '2018'
			When exists ( select Top 1 1 from sysadm.commande c2 where c2.id_sin=s.id_sin and c2.id_ref_four='BON_ACHAT' ) 
				 and Not Exists ( 
						Select Top 1 1 
						From   sysadm.det_pro dp
						Where  dp.id_prod = s.id_prod
						And    dp.id_code_dp = 141
						And    sysadm.FN_CLE_VAL ( 'SITE_SAV', dp.val_car, ';' ) = 'PMI'
					) Then '2017'
			When exists (select Top 1 1  from sysadm.commande c2 where c2.id_sin = s.id_sin and c2.id_four = 'O2M' and c2.info_spb_frn in (1442,1443,1425) ) Then '2019' 
			Else c.info_spb_frn 
		End 'etat_presta_sav',
		d.id_gti,
		sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' ) 'etat_dossier',
		s.id_prod,
		sysadm.FN_LIB_POLICE(s.id_sin) as lib_police
		
From	@tb t,
		sysadm.sinistre s,
		sysadm.personne p,
		sysadm.div_sin ds,
		sysadm.commande c,
		sysadm.detail d
Where   s.id_sin = t.id_sin
And		p.id_ordre = s.id_ordre
And		ds.id_sin = s.id_sin
And		ds.nom_zone = 'num_bon_vente'
And		c.id_sin = t.id_sin
And		c.id_four = 'SCR'
And		d.id_sin = c.id_sin
And		d.id_gti = c.id_gti
And		d.id_detail = c.id_detail
Union All
Select
		t.id_sin,
		sysadm.FN_CODE_NUM ( p.cod_civ, '-CI' ) 'civilite',
		p.nom 'nom',
		p.prenom 'prenom',
		rTrim ( ds.val_car ) 'num_bon_vente',
		sysadm.FN_AFF_DATE ( s.dte_ach_port, 'SH' ) 'dte_achat',
		s.marq_port 'marque_app',
		s.modl_port 'modele_app',
		s.cod_etat 'etat_dossier',
		(select max(d.mt_val_achat) from sysadm.detail d where d.id_sin=s.id_sin and d.id_gti=g.id_gti) 'mt_val_achat',
		Case 
			When exists (select top 1 1 from sysadm.w_piece pc where pc.id_sin = s.id_sin) Then '2016' 
			When exists (select top 1 1 from sysadm.refus rf where rf.id_sin = s.id_sin ) Then '2018'
			When exists ( select Top 1 1 from sysadm.commande c2 where c2.id_sin=s.id_sin and c2.id_ref_four='BON_ACHAT' ) Then '2017'
			When exists (select Top 1 1  from sysadm.commande c2 where c2.id_sin = s.id_sin and c2.id_four = 'O2M' and c2.info_spb_frn in (1442,1443,1425) ) Then '2019'
			Else ''
		End 'etat_presta_sav',
		g.id_gti,
		sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' ) 'etat_dossier',
		s.id_prod,
		sysadm.FN_LIB_POLICE(s.id_sin) as lib_police
From	@tb t,
		sysadm.sinistre s,
		sysadm.personne p,
		sysadm.gar_sin g,
		sysadm.div_sin ds
Where	s.id_sin = t.id_sin
And		p.id_ordre = s.id_ordre
And		g.id_sin = s.id_sin
And		ds.id_sin = s.id_sin
And		ds.nom_zone = 'num_bon_vente'
And		Not exists (select Top 1 1 from sysadm.commande c where c.id_sin = s.id_sin and c.id_four = 'SCR')

Return @iRet
Go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_LECTDONN_LISTE_MC_PROTECT
-- Auteur               :       F. Pinon
-- Date                 :       28/07/2010 
-- Libelle              :        
-- Commentaires         :       Procédure de lecture de liste de sinistres
--                               
-- References           :       
--
-- Arguments            :       @asVarSeria             VarChar(500)		(Val) Variable sérialisée contenant les critères de recherche
--				@asCas                  VarChar(50)		(Val) Cas de traitement
--				@asIdSession     	varchar(50)		(Val) Identifiant de session
--				@asBrowser       	varchar(200)		(Val) Identification du browser Web
--                              @asLangage              VarChar (  3 )          (Val) Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--				@aiCodeMsg		Integer			(Réf) Code message (table message)
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       Integer                 >0 = OK
--                                                      -1 = NOK
-------------------------------------------------------------------
-- JFF      12/12/2013   [PC947&977]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_LECTDONN_LISTE_MC_PROTECT' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_LECTDONN_LISTE_MC_PROTECT
GO

CREATE PROCEDURE sysadm.PS_WEBSIM2_LECTDONN_LISTE_MC_PROTECT
	@asVarSeria             VarChar(500),
	@asCas                  VarChar(50),
	@asIdSession     	varchar(50),
	@asBrowser       	varchar(200),
	@asLangage              VarChar (3),
	@aiCodeMsg		Integer OUTPUT,
        @asRetourMess           VarChar ( 2000 ) OUTPUT

AS
Declare @iRet	integer
Declare @dcIdSin decimal(10,0) -- [PI062]
Declare	@sIdSin  varchar(10) -- [PI062]
Declare	@sNom  varchar(35)
Declare	@sPrenom  varchar(35)
Declare	@sNumIMEI  varchar(60)
Declare @sCodMag varchar(20), @iIdBoutique integer

Select @iRet=1, @asRetourMess='OK'

Select 	@sIdSin = sysadm.FN_CLE_VAL('ID_SIN',@asVarSeria,';'),
	@sNom = Upper(sysadm.FN_CLE_VAL('NOM',@asVarSeria,';')),
	@sPrenom = Upper(sysadm.FN_CLE_VAL('PRENOM',@asVarSeria,';')),
	@sNumIMEI = sysadm.FN_CLE_VAL('NUM_IMEI',@asVarSeria,';')
	

if rtrim(@sIdSin) = '' Set @sIdSin=NULL
if rtrim(@sNom) = '' Set @sNom=NULL
if rtrim(@sPrenom) = '' Set @sPrenom=NULL
if rtrim(@sNumIMEI) = '' Set @sNumIMEI=NULL

Set @dcIdSin=convert(decimal(10),@sIdSin) -- [PI062]

Select  distinct s.id_sin,
	sysadm.FN_CODE_NUM ( p.cod_civ, '-CI' ) 'civilite',
	p.nom 'nom',
	p.prenom 'prenom',
	p.adr_1 'adr_1',
	p.adr_1 'adr_2',
	s.marq_port 'marque_app',
	s.modl_port 'modele_app',
	s.num_imei_port,
	Case When cdiag.cod_etat='ECT' Then 'ECDIAG'
		When cprs.cod_etat='ECT' Then 'ECREPA'
		When c.cod_etat='ECT' Then 'ECREMPL'
		When c.cod_etat='RPC' Then 'CREMPL'
		When cprs.cod_etat='RPC' Then 'CREPA'
		When s.cod_etat in ( 900, 200 )Then 'CREFUS'
		Else 'ECINST' End 'cod_etat_dossier',
	Case When cdiag.cod_etat='ECT' Then 'En cours de diagnostic'
		When cprs.cod_etat='ECT' Then 'En cours de réparation'
		When c.cod_etat='ECT' Then 'En attente de remplacement magasin'
		When c.cod_etat='RPC' Then 'Clos - remplacé'
		When cprs.cod_etat='RPC' Then 'Clos - réparé'
		When s.cod_etat in ( 900, 200 ) Then 'Clos - refusé'
		Else 'En cours d''instruction' End 'etat_dossier',
	s.dte_decl,
	s.dte_adh
From	sysadm.sinistre s 
	left outer join sysadm.commande c on s.id_sin=c.id_sin
			And c.id_four in ('ACU','FPC','CYT','MCY', 'ADV') -- [PC947&977]
			And c.cod_etat <> 'ANN'
	inner join sysadm.personne p on p.id_ordre = s.id_ordre
	left outer join sysadm.w_queue w on w.id_sin=s.id_sin
	left outer join sysadm.commande cdiag on  cdiag.id_sin=s.id_sin 
		and cdiag.id_ref_four='A_DIAGNOSTIQUER' and cdiag.cod_etat <> 'ANN'
	left outer join sysadm.commande cprs on  cprs.id_sin=s.id_sin 
		and cprs.id_typ_art='PRS' 
		and cprs.cod_etat <> 'ANN'
Where  	(@dcIdSin is null or s.id_sin = @dcIdSin)
	And 	(@sNom is null or Upper(p.nom) = @sNom)
	And 	(@sPrenom is null or Upper(p.prenom) = @sPrenom)
	and (@sNumIMEI is null or UPPER(s.num_imei_port) = @sNumIMEI)
	and exists (select * from sysadm.commande_type ct 
		where ct.id_prod=s.id_prod 
			and ct.id_code_frn in ('ACU','FPC','CYT','MCY','ADV')) -- [PC947&977]
			
Return @iRet
Go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_LECTDONN_LISTE_OMEA_TELECOM
-- Auteur               :       F. Pinon
-- Date                 :       22/09/2014
-- Libelle              :        
-- Commentaires         :       Procédure de lecture de données pour le cas produit OMEA_TELECOM
--								[PC13447-1]
--                               
-- References           :       
--
-- Arguments            :       @asIdSin                VarChar(7)        	(Val) Identifiant de sinistre
--				@asVarSeria             VarChar(500)		(Val) Variable sérialisée contenant les critères de recherche
--				@asCas                  VarChar(50)		(Val) Cas de traitement
--				@asIdSession     	varchar(50)		(Val) Identifiant de session
--				@asBrowser       	varchar(200)		(Val) Identification du browser Web
--                              @asLangage              VarChar (  3 )          (Val) Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--				@aiCodeMsg		Integer			(Réf) Code message (table message)
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       Integer                 >0 = OK
--                                                      -1 = NOK
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_LECTDONN_LISTE_OMEA_TELECOM' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_LECTDONN_LISTE_OMEA_TELECOM
GO


CREATE PROCEDURE sysadm.PS_WEBSIM2_LECTDONN_LISTE_OMEA_TELECOM
	@asVarSeria             VarChar(500),
	@asCas                  VarChar(50),
	@asIdSession     	varchar(50),
	@asBrowser       	varchar(200),
	@asLangage              VarChar (3),
	@aiCodeMsg			Integer OUTPUT,
    @asRetourMess           VarChar ( 2000 ) OUTPUT

AS
Declare @iRet	integer
Declare @dcIdSin decimal(10,0) -- [PI062]
Declare	@sIdSin  varchar(10) -- [PI062]
Declare	@sNom  varchar(35)
Declare	@sPrenom  varchar(35)
Declare	@sNumIMEI  varchar(60)

Select @iRet=1, @asRetourMess='OK'

Select 	@sIdSin = sysadm.FN_CLE_VAL('ID_SIN',@asVarSeria,';'),
	@sNom = Upper(sysadm.FN_CLE_VAL('NOM',@asVarSeria,';')),
	@sPrenom = Upper(sysadm.FN_CLE_VAL('PRENOM',@asVarSeria,';')),
	@sNumIMEI = sysadm.FN_CLE_VAL('NUM_IMEI',@asVarSeria,';')

if rtrim(@sIdSin) = '' Set @sIdSin=NULL
if rtrim(@sNom) = '' Set @sNom=NULL
if rtrim(@sPrenom) = '' Set @sPrenom=NULL
if rtrim(@sNumIMEI) = '' Set @sNumIMEI=NULL

-- Contrôle de validité des paramètres
If @sIdSin is null And  @sNom is null And @sNumIMEI is null
Begin
	Set @iRet=-1
	Set @asRetourMess ='Veuillez saisir l''une des caractéristiques suivantes : référence sinistre, ou nom, ou n°série/IMEI.'
	Return @iRet
End	

If @sIdSin is not null And ISNUMERIC(@sIdSin) =0
Begin
	Set @iRet=-1
	Set @asRetourMess ='Numéro de sinistre incorrect.'
	Return @iRet
End	


-- Détermination de l'id_sin
Set @dcIdSin = Convert ( Decimal ( 10 ),  @sIdSin ) -- [PI062]
	
If @dcIdSin is null
Begin
	
	select @iRet=COUNT(*)
	from sysadm.sinistre s 
		inner join sysadm.personne p on p.id_ordre=s.id_ordre
	Where s.id_prod in (select id_prod from sysadm.commande_type c where c.id_code_frn='OME')
		And (
			(@sNom is not null and p.nom=@sNom 
				and @sPrenom is null or p.prenom=@sPrenom)
			or 
				(@sNumIMEI is not null and s.num_imei_port = @sNumIMEI)
			)
	
	If 	@iRet > 1 
	Begin
		Set @iRet=-2
		Set @asRetourMess ='Votre recherche comporte plusieurs résultats, merci de préciser vos critères.'
		Return @iRet
	End
	
	If 	@iRet =0
	Begin
		Set @iRet=-3
		Set @asRetourMess ='Aucun résultat ne correspond à votre recherche.'
		Return @iRet
	End
	
	select @dcIdSin=s.id_sin
	from sysadm.sinistre s 
		inner join sysadm.personne p on p.id_ordre=s.id_ordre
	Where s.id_prod in (select id_prod from sysadm.commande_type c where c.id_code_frn='OME')
		And (
			(@sNom is not null and p.nom=@sNom 
				and @sPrenom is null or p.prenom=@sPrenom)
			or 
				(@sNumIMEI is not null and s.num_imei_port = @sNumIMEI)
			)
End

If not exists (select * from sysadm.sinistre where id_sin=@dcIdSin)
Begin
	Set @iRet=-3
	Set @asRetourMess ='Aucun résultat ne correspond à votre recherche.'
	Return @iRet
End	
	
Set @iRet=1

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

Return @iRet

Go


grant execute on sysadm.PS_WEBSIM2_LECTDONN_LISTE_OMEA_TELECOM to rolebddsinistres
go