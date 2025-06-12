-------------------------------------------------------------------
--
-- Fichier              :       PM260.CP
-- Auteur               :       FABRY JF
-- Date                 :       04/11/2015
--								[PM260]
-- Commentaires         :       
--
-- sysadm.PS_I_BATCH_PM260
-- sysadm.PS_U_TRT_PM260
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_TRT_PM260
-- Auteur               :       JFF
-- Date                 :       04/11/2015
-- Libelle              :       
-- Commentaires         :       [PM260]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      27/03/2017   [PM260-1]
-- JFF      11/02/2019   [PM473-1]
-- JFF      05/11/2019   [PM260_5]
-- JFF      05/03/2020   [PM260-5][V2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_TRT_PM260' AND type = 'P' )
        DROP procedure sysadm.PS_U_TRT_PM260
GO

CREATE procedure sysadm.PS_U_TRT_PM260
	@adcIdSin Decimal (10), -- [PI062]
	@asCas	  VarChar ( 10 )
As

Declare @sNom VarChar ( 100 )
Declare @dtDernValid DateTime 
Declare @sIdAdhAlea Varchar ( 50 )
Declare @sIdAdhAlea2 Varchar ( 50 )
Declare @sNumIMEIAlea Varchar ( 50 )
Declare @sNumIMEIAlea2 Varchar ( 50 )
Declare @sIdSin VarChar ( 10 )

Declare @iIdSeq integer
Declare @iIdSeqCmde integer
Declare @sInfoSpbFrnCplt varchar ( 800 )
Declare @sInfoFrnSpbCplt varchar ( 800 )

Declare @dcIdOrdreActuel Decimal ( 7 )
Declare @dcIdOrdreNew Decimal ( 7 )

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_seq_cmde integer,
	  info_spb_frn_cplt varchar ( 800 ),
--	  info_frn_spb_cplt varchar ( 255 ),
	  marquage	integer null 
	)

Set @sIdSin = Convert ( varchar, @adcIdSin ) 

/* [PM260-5][V2]
Set @sIdAdhAlea   = right ( Convert ( varchar, rand () ), 3 )
Set @sIdAdhAlea2  = right ( Convert ( varchar, rand () ), 3 )
Set @sIdAdhAlea  = 'XX' + @sIdAdhAlea  + @sIdSin + @sIdAdhAlea2 + 'XX'
*/

/*
Set @sNumIMEIAlea  = right ( Convert ( varchar, rand () ), 3 )
Set @sNumIMEIAlea2  = right ( Convert ( varchar, rand () ), 3 )
*/
Set @sNumIMEIAlea  = sysadm.FN_CORR_IMEI ( '111111', getdate() ) 

If @asCas = 'SIM' 
  Begin
	Select @dtDernValid = dte_1
	From   sysadm.date_pivot dp
	Where  dp.id_cle = 'DERN_VALID'

	Set @dtDernValid = DateAdd ( hour, 8, @dtDernValid )

	If Exists ( Select top 1 1 From sysadm.w_sin with (nolock) Where id_sin = @adcIdSin )
		Begin
			If Exists ( 
				Select	Top 1 1 
				From	sysadm.w_sin ws with (nolock) 
				Where   ws.cree_le > @dtDernValid
				And     ws.id_sin = @adcIdSin
			)
			Begin
				Return 0
			End 
		End
	Else 
		Begin
			If Exists ( Select top 1 1 From sysadm.sinistre with (nolock)  Where id_sin = @adcIdSin )
			 Begin
				If Exists ( 
					Select	Top 1 1 
					From	sysadm.sinistre s with (nolock) 
					Where   s.cree_le > @dtDernValid
					And     s.id_sin = @adcIdSin
				)
				Begin
					Return 0
				End 
			 End 
		End
 End 
    
-- On récupère l'id_ordre actuel
Select @dcIdOrdreActuel = s.id_ordre From sysadm.sinistre s where s.id_sin = @adcIdSin

-- Existe-t-il des dossiers lié à cet id_ordre, non anonymisé ?
If Exists ( 
	Select Top 1 1 
	From sysadm.sinistre s
	Where s.id_ordre = @dcIdOrdreActuel 
	And   s.id_sin <> @adcIdSin
	And   Not Exists ( 
			Select Top 1 1 
			From sysadm.pm260_traite pm
			Where pm.id_sin = s.id_sin 
			)
)
Begin
	-- Obtention nouvel id_ordre
	EXEC sysadm.PS_X_INCREMENTER 'ID_ORDRE', @dcIdOrdreNew OUTPUT 

	-- On duplique la personne actuel
	Insert into sysadm.personne 
	Select 
	 	@dcIdOrdreNew,
		cod_civ,
		nom,
		prenom,
		adr_1,
		adr_2,
		adr_cp,
		adr_ville,
		num_fax,
		num_telb,
		num_teld,
		valide_le,
		valide_par,
		cree_le,
		maj_le,
		maj_par
	From sysadm.personne p
	Where p.id_ordre = @dcIdOrdreActuel

	-- On change l'id_ordre des autres dossiers (non anonymisé)
	Update sysadm.sinistre 
	Set id_ordre = @dcIdOrdreNew
	From sysadm.sinistre s
	Where s.id_ordre = @dcIdOrdreActuel 
	And   s.id_sin <> @adcIdSin
	And   Not Exists ( 
			Select Top 1 1 
			From sysadm.pm260_traite pm
			Where pm.id_sin = s.id_sin 
			)

	-- On change l'id_ordre des autres dossiers (non anonymisé)
	Update sysadm.w_sin
	Set id_ordre = @dcIdOrdreNew
	From sysadm.w_sin s
	Where s.id_ordre = @dcIdOrdreActuel 
	And   s.id_sin <> @adcIdSin
	And   Not Exists ( 
			Select Top 1 1 
			From sysadm.pm260_traite pm
			Where pm.id_sin = s.id_sin 
			)

End 

Update sysadm.personne 
Set	   nom = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX', -- Nom
		prenom = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX', -- Prenom
		adr_cp = '75001', -- Code Postal
		adr_1 = '1 rue de Paris', -- Adresse
		adr_2 = '1 rue de Paris', -- Adresse	   
		adr_ville = 'PARIS', -- Adresse	   	   
		num_fax = '0101010101', -- Tel
		num_telb = '0101010101', -- Tel
		num_teld = '0101010101' -- Tel
From   sysadm.sinistre s with (nolock) ,
		sysadm.personne p with (nolock) 
Where  s.id_sin = @adcIdSin
And    p.id_ordre = s.id_ordre

Update sysadm.w_sin 
Set	   nom = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX', -- Nom
	   prenom = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX', -- Prénom
	   adr_cp = '75001', -- Code Postal
	   adr_1 = '1 rue de Paris', -- Adresse
	   adr_2 = '1 rue de Paris', -- Adresse	   
	   adr_ville = 'PARIS', -- Adresse	   	   	   
	   num_fax = '0101010101', -- Tel	   
	   num_port = '0601010101', -- Tel	   	   
	   num_telb = '0101010101', -- Tel	   
	   num_teld = '0101010101', -- Tel	
--	   id_adh = @sIdAdhAlea, -- id_adh [PM260-1] [PM260-5][V2]
	   num_imei_port = @sNumIMEIAlea -- num_imei_port [PM260_5]
From   sysadm.w_sin ws with (nolock) 
Where  ws.id_sin = @adcIdSin

Update sysadm.sinistre
Set	   num_port = '0601010101', -- Tel
	   -- id_adh = @sIdAdhAlea, -- id_adh [PM260-1] [PM260-5][V2] 	   
	   num_imei_port = @sNumIMEIAlea -- num_imei_port [PM260_5]
From   sysadm.sinistre s with (nolock)
Where  s.id_sin = @adcIdSin

Update sysadm.w_inter 
Set	   nom = rtrim ( wi.cod_inter ) + Convert ( varchar, wi.id_i) + Convert ( varchar(10), Convert( integer, rand() * 10000000 )) +  'XXANONYMEXX', -- Nom
	   adr_cp = '75001', -- Code Postal
	   adr_1 = '1 rue de Paris', -- Adresse
	   adr_2 = '1 rue de Paris', -- Adresse	   
	   adr_ville = 'PARIS', -- Adresse	 
	   adr_att = 'XXANONYMEXX', -- Adresse	   
	   ordre_cheque = 'XXANONYMEXX', -- ordre
	   adr_mail = 'XX@XX.COM', -- mail
	   num_fax = '0101010101', -- Tel
	   num_port_sms = '0101010101', -- Tel	   
	   num_telb = '0101010101', -- Tel	   
	   num_teld = '0101010101', -- Tel	  	   	   
	   rib_bq = null,
	   rib_cpt = null,
	   rib_gui = null,
	   rib_cle = null	   
From   sysadm.w_inter wi with (nolock)
Where  wi.id_sin = @adcIdSin
and    wi.cod_inter not in ( 'F', 'B' )

Update sysadm.inter 
Set	   nom = rtrim ( i.cod_inter ) + Convert ( varchar, i.id_i) + Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX', -- Nom
	   adr_cp = '75001', -- Code Postal
	   adr_1 = '1 rue de Paris', -- Adresse
	   adr_2 = '1 rue de Paris', -- Adresse	   	   
	   adr_ville = 'PARIS', -- Adresse	 	   
	   adr_att = 'XXANONYMEXX', -- Adresse	   	   
	   ordre_cheque = 'XXANONYMEXX', -- ordre
	   adr_mail = 'XX@XX.COM', -- mail	   
	   num_fax = '0101010101', -- Tel
	   num_port_sms = '0101010101', -- Tel
	   num_telb = '0101010101', -- Tel
	   num_teld = '0101010101', -- Tel	  	   
	   rib_bq = null,
	   rib_cpt = null,
	   rib_gui = null,
	   rib_cle = null		   
From   sysadm.inter i with (nolock)
Where  i.id_sin = @adcIdSin
and    i.cod_inter not in ( 'F', 'B' )

Update sysadm.archive
Set	   nom =Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX' -- Nom
	   -- id_adh = @sIdAdhAlea -- id_adh [PM260-1] [PM260-5][V2]
From   sysadm.archive a with (nolock)
Where  a.id_sin = @adcIdSin
and    a.cod_inter not in ( 'F', 'B' )

Update sysadm.w_div_sin
Set    val_dte = '01/01/1900'
From   sysadm.w_div_sin ds with (nolock)
Where  ds.id_sin = @adcIdSin
And	   ds.nom_zone = 'dte_nais_adh'

Update sysadm.div_sin
Set    val_dte = '01/01/1900'
From   sysadm.div_sin ds with (nolock)
Where  ds.id_sin = @adcIdSin
And	   ds.nom_zone = 'dte_nais_adh'

Update sysadm.commande
Set	   adrfc_nom = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX', -- Nom
	   adr_nom = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX', -- Nom
	   adr_prenom = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX', -- Prénom
	   adrfc_prenom = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX', -- Prénom
	   id_serie_anc = @sNumIMEIAlea, -- num_imei_port [PM260_5]
	   id_serie_nouv = @sNumIMEIAlea, -- num_imei_port [PM260_5]
	   adr_cp = '75001', -- Code Postal
	   adrfc_cp = '75001', -- Code Postal	   	   
	   adr_livr1 = '1 rue de Paris', -- Adresse	   	   	   	   
	   adr_livr2 = '1 rue de Paris', -- Adresse	   	   	   	   	   
	   adr_livr_cpl = '1 rue de Paris', -- Adresse	    	   	   	   	   
	   adr_ville = 'PARIS', -- Adresse	   
	   adrfc_livr1 = '1 rue de Paris', -- Adresse	   	   	   	   
	   adrfc_livr2 = '1 rue de Paris', -- Adresse	   	   	   	   	   
	   adrfc_livr_cpl = '1 rue de Paris', -- Adresse	 	   
	   adrfc_ville = 'PARIS', -- Adresse	   
	   adr_mail = 'XX@XX.COM', -- mail
	   adr_tel1 = '0601010101', -- Tel
	   adr_tel2 = '0601010101', -- Tel	   
	   adr_tel3 = '0601010101' -- Tel	   	   
From   sysadm.commande c with (nolock)
Where  c.id_sin = @adcIdSin

Update sysadm.w_commande
Set	   adrfc_nom = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX', -- Nom
	   adr_nom = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX', -- Nom
	   adr_prenom = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX', -- Prénom
	   adrfc_prenom = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX', -- Prénom
	   id_serie_anc = @sNumIMEIAlea, -- num_imei_port [PM260_5]
	   id_serie_nouv = @sNumIMEIAlea, -- num_imei_port [PM260_5]
	   adr_cp = '75001', -- Code Postal
	   adrfc_cp = '75001', -- Code Postal	   	   
	   adr_livr1 = '1 rue de Paris', -- Adresse	   	   	   	   
	   adr_livr2 = '1 rue de Paris', -- Adresse	   	   	   	   	   
	   adr_livr_cpl = '1 rue de Paris', -- Adresse	    	   	   	   	   
	   adr_ville = 'PARIS', -- Adresse	   
	   adrfc_livr1 = '1 rue de Paris', -- Adresse	   	   	   	   
	   adrfc_livr2 = '1 rue de Paris', -- Adresse	   	   	   	   	   
	   adrfc_livr_cpl = '1 rue de Paris', -- Adresse	 	   
	   adrfc_ville = 'PARIS', -- Adresse	   
	   adr_mail = 'XX@XX.COM', -- mail
	   adr_tel1 = '0601010101', -- Tel
	   adr_tel2 = '0601010101', -- Tel	   
	   adr_tel3 = '0601010101' -- Tel	   	   

From   sysadm.w_commande c with (nolock)
Where  c.id_sin = @adcIdSin

Update sysadm.trt_frais_presta
Set	   nom_assure = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX', -- Nom
	   adr_cp = '75001', -- Code Postal
	   adr_1 = '1 rue de Paris', -- Adresse
	   adr_2 = '1 rue de Paris', -- Adresse	   
	   adr_ville = 'PARIS', -- Adresse	 
	   rib_bq = null,
	   rib_cpt = null,
	   rib_ag = null,
	   rib_cle = null	   
From   sysadm.trt_frais_presta t with (nolock)
Where  t.id_sin = @adcIdSin

Update sysadm.cum_ftu_brk
Set	   nom_ass = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX', -- Nom
	   prenom_ass = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX' -- Prénom
From   sysadm.cum_ftu_brk t with (nolock)
Where  t.id_sin = @adcIdSin

Update sysadm.trace_soldage
Set	   nom_ass = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX', -- Nom
	   prenom_ass = Convert ( varchar(10), Convert( integer, rand() * 10000000 )) + 'XXANONYMEXX' -- Prénom
From   sysadm.trace_soldage t with (nolock)
Where  t.id_sin = @adcIdSin

Update sysadm.trace_cmde_web
Set    num_tel = '0101010101' -- Tel
From   sysadm.trace_cmde_web t with (nolock)
Where  t.id_sin = @adcIdSin

Update sysadm.reglement
Set    rib_bq = null,
	   rib_cpt = null,
	   rib_gui = null,
	   rib_cle = null
From   sysadm.reglement t with (nolock)
Where  t.id_sin = @adcIdSin


-- Traitement de l'anonymisation des bcv de la table commande
Insert into @tb
select distinct 
	   c.id_seq,
	   c.info_spb_frn_cplt,
--	   c.info_frn_spb_cplt,
	   0 'marquage'
from	sysadm.commande c with (nolock)
where	c.id_sin = @adcIdSin


While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@iIdSeqCmde = id_seq_cmde,
		@sInfoSpbFrnCplt = rtrim ( info_spb_frn_cplt )
--		@sInfoFrnSpbCplt = rtrim ( info_frn_spb_cplt )
	From	@tb
	Where	marquage = 0

	If sysadm.FN_CLE_VAL ( 'MAIL_ASSURE', @sInfoSpbFrnCplt, ';' ) <> ''
	Set @sInfoSpbFrnCplt = sysadm.FN_CLE_VAL_E ( 'MAIL_ASSURE', 'XX@XX.COM', @sInfoSpbFrnCplt, ';' ) -- Mail

	If sysadm.FN_CLE_VAL ( 'NOM_ASS', @sInfoSpbFrnCplt, ';' ) <> ''
	Set @sInfoSpbFrnCplt = sysadm.FN_CLE_VAL_E ( 'NOM_ASS', 'XXANONYMEXX', @sInfoSpbFrnCplt, ';' ) -- Mail

	If sysadm.FN_CLE_VAL ( 'PRENOM_ASS', @sInfoSpbFrnCplt, ';' ) <> ''
	Set @sInfoSpbFrnCplt = sysadm.FN_CLE_VAL_E ( 'PRENOM_ASS', 'XXANONYMEXX', @sInfoSpbFrnCplt, ';' ) -- Mail

	If sysadm.FN_CLE_VAL ( 'PSM_IMEI_SIN', @sInfoSpbFrnCplt, ';' ) <> ''
	Set @sInfoSpbFrnCplt = sysadm.FN_CLE_VAL_E ( 'PSM_IMEI_SIN', 'XXIMEISERIEXX', @sInfoSpbFrnCplt, ';' ) -- Mail

	Update sysadm.commande set info_spb_frn_cplt = @sInfoSpbFrnCplt where id_sin = @adcIdSin and id_seq = @iIdSeqCmde
	Update sysadm.w_commande set info_spb_frn_cplt = @sInfoSpbFrnCplt where id_sin = @adcIdSin and id_seq = @iIdSeqCmde

	-- (rien pour l'instant) Update sysadm.commande set info_frn_spb_cplt = @sInfoFrnSpbCplt where id_sin = @adcIdSin and id_seq = @iIdSeqCmde
	-- (rien pour l'instant) Update sysadm.w_commande set info_frn_spb_cplt = @sInfoFrnSpbCplt where id_sin = @adcIdSin and id_seq = @iIdSeqCmde

	Update @tb Set marquage = 1 Where id_seq = @iIdSeq
 End

Return 1

Go



--------------------------------------------------------------------
--
-- Procedure            :       PS_I_BATCH_PM260
-- Auteur               :       JFF
-- Date                 :       04/11/2015
-- Libelle              :       
-- Commentaires         :       [PM260]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      15/05/2018   [PM260-3]
-- JFF      11/02/2019   [PM473-1]
-- JFF      03/06/2019   [PM260-4]
-- JFF      05/11/2019   [PM260_5]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_BATCH_PM260' AND type = 'P' )
        DROP procedure sysadm.PS_I_BATCH_PM260
GO

CREATE procedure sysadm.PS_I_BATCH_PM260  
	@iTempsEnSeconde Integer
	WITH RECOMPILE
As

-- [PM260-4]
If sysadm.FN_CLE_NUMERIQUE ( 'PM260_4') > 0 
 Begin
    -- Fin du PM260-1 d'anonymisation au profit du PM260-4 de suppression
	-- Attention la PS d'anonymisation à l'unité est utilisé en SIM je la laisse donc.
	-- Je coupe uniquement le moteur quotidien.
	Return
 End 

-- [PM260_5]
Exec sysadm.PS_I_BATCH_PM260_5 @iTempsEnSeconde
Return

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_I_BATCH_PM260_5
-- Auteur               :       JFF
-- Date                 :       04/11/2015
-- Libelle              :       
-- Commentaires         :       [PM260]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      15/05/2018   [PM260-3]
-- JFF      11/02/2019   [PM473-1]
-- JFF      03/06/2019   [PM260-4]
-- JFF      05/11/2019   [PM260_5]
-- JFF      05/12/2019   [VDOC28787]
-- JFF      23/05/2022   [ISM290436]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_BATCH_PM260_5' AND type = 'P' )
        DROP procedure sysadm.PS_I_BATCH_PM260_5
GO

CREATE procedure sysadm.PS_I_BATCH_PM260_5  
	@iTempsEnSeconde Integer
	WITH RECOMPILE
As

Declare @dtDeb DateTime
Declare @dcIdSin Decimal (10) -- [PI062]
Declare @iNbre integer
Declare @iNbreTot integer
Declare @iArretSuitErr integer
Declare @iErr integer
DECLARE @sMessage    Varchar(1000),
	    @sObjet      VarChar(255),
	    @sRetourErrMail VarChar(255),
		@sValideLe   VarChar ( 30 ),
		@sPeriodeMois VarChar ( 30 ),
		@sIdCie VarChar ( 30 ),
		@sDtePivot VarChar ( 30 ),
		@sDonneesAno VarChar ( 35 )

Set @dtDeb = GetDate()
Set @iNbre = 0
Set @iArretSuitErr = 0

DECLARE @Cache TABLE 
	( id_sin	decimal (10 ),
	  periode_mois varchar ( 10 ),
	  id_cie  varchar ( 10 ),
	  dte_pivot varchar ( 10 )
	)

DECLARE @garantie TABLE 
	( id_prod	decimal (7),
	  id_rev    decimal ( 3 ),
	  id_police decimal ( 7 )
	)

DECLARE @det_pro TABLE 
	( id_prod	decimal (7),
	  periode_mois int,
	  id_cie    decimal ( 7 ) 
	)

Insert into @garantie
Select distinct id_prod, id_rev, id_police from sysadm.garantie with (nolock)

Insert into @det_pro
Select distinct 
		id_prod, 
		convert ( integer, sysadm.FN_CLE_VAL ( 'PERIODE_MOIS', rtrim ( dp.val_car) + rtrim ( dp.val_car2), ';' )) * (-1) ,
		convert ( integer, sysadm.FN_CLE_VAL ( 'ID_CIE', rtrim ( dp.val_car) + rtrim ( dp.val_car2) , ';' ))
		From sysadm.det_pro dp with (nolock) Where dp.id_code_dp = 292 Order by 1,2
  	
While DATEDIFF ( second , @dtDeb, GETDATE() ) <= @iTempsEnSeconde 
 Begin
 
	Set @dcIdSin = null

	-- [PM260_5]
	If Not Exists ( Select Top 1 1 From @Cache ) 
	  Begin
	  Insert into @Cache
		Select Top 10000 -- 25s de remplissage pour 10000
				s.id_sin,
				Convert ( VarChar, Abs ( dp.periode_mois ) ),
				Convert ( VarChar, dp.id_cie ),
				Convert ( VarChar, DATEADD ( month, dp.periode_mois, GETDATE() ), 103 )

		From  sysadm.sinistre s with (nolock),
				@det_pro dp,
				@garantie ga,
				sysadm.police po with (nolock)
		Where dp.id_prod = s.id_prod
		And   ga.id_prod = s.id_prod
		And   ga.id_rev = Case 
							 When s.id_rev > 0 Then s.id_rev
							 Else ( 
									Select MAX ( id_rev ) 
									From   sysadm.garantie ga,
										   sysadm.police po
									Where  ga.id_prod = s.id_prod
									And    po.id_police = ga.id_police
									And    po.id_cie = dp.id_cie
								  )
						   End 
		And   po.id_police = ga.id_police
		And   po.id_cie = dp.id_cie
		And	  s.valide_le < DATEADD ( month, dp.periode_mois, GETDATE() )
		And   s.cod_etat in ( 200, 900, 600 )
		And   Not exists ( 
				Select	Top 1 1
				From	sysadm.pm260_traite t with ( nolock )
				Where	t.id_sin = s.id_sin
				)
		And   Not Exists ( 
				Select	Top 1 1
				From	sysadm.w_queue wq with ( nolock )
				Where	convert ( Decimal ( 10 ), wq.id_sin ) = s.id_sin -- [PI062]
				)	

/* Supprimé suite [ISM290436], plus la peine car on gère dans PS de trt le problème des id_ordre
		-- Ajout [PM260-3]
		And   Not Exists ( 
				Select Top 1 1 
				From   sysadm.w_sin ws with ( nolock )
				Where  ws.id_sin <> s.id_sin  
				And    ws.id_ordre = s.id_ordre 
				And	   ws.maj_le >= DATEADD ( month, dp.periode_mois, GETDATE() )
		) 
		-- Ajout [VDOC28787]
		And   Not Exists ( 
				Select Top 1 1 
				From   sysadm.sinistre s2 with ( nolock )
				Where  s2.id_sin <> s.id_sin  
				And    s2.id_ordre = s.id_ordre 
				And	   s2.valide_le >= DATEADD ( month, dp.periode_mois, GETDATE() )
		) 
*/

	  End 
	 	
	If Not Exists ( Select Top 1 1 From @Cache ) Break

	Select top 1 
		@dcIdSin = id_sin,
		@sPeriodeMois = periode_mois,
		@sIdCie = id_cie,
		@sDtePivot  = dte_pivot
	From @Cache	  	

	If @dcIdSin is null Break

	Select @sValideLe = convert ( varchar(10), s.valide_le, 103 ) 
	From sysadm.sinistre s with (nolock)
	Where s.id_sin = @dcIdSin

	-- DP=DatePivot / DV=Date de validation du dossier / CIE=Compagnie assurance / PM=Période Mois (Param)
	Set @sDonneesAno = Left ( 'DP' + @sDtePivot + '/DV' + @sValideLe + '/CIE' + @sIdCie + 'PM' + @sPeriodeMois , 35 )

	Exec sysadm.PS_U_TRT_PM260 @dcIdSin, 'PRO'
	Set @iErr = @@ERROR

	If @iErr <> 0 
	  Begin
		Set @iArretSuitErr = 1
		Break
	  End 
	
	Insert into sysadm.pm260_traite values ( @dcIdSin, GETDATE(), 0 )
	
	If Exists ( Select * From sysadm.w_sin ws with (nolock) Where ws.id_sin = @dcIdSin  )	
	  Begin
	   Insert into sysadm.w_div_sin values ( @dcIdSin, 'dte_anonymisation', 'Date d''anonymisation', '-1', 'N', 'D', 'N', 'O', 1000, null, null, GETDATE(), null, 0, getdate(), getdate(), 'AUTO' ) 
	   Insert into sysadm.w_div_sin values ( @dcIdSin, 'donnees_anonymisation', 'Données d''anonymisation', '-1', 'N', 'C', 'N', 'O', 1001, null, null, null, @sDonneesAno, 0, getdate(), getdate(), 'AUTO' ) 
	  End

    Insert into sysadm.div_sin values ( @dcIdSin, 'dte_anonymisation', 'Date d''anonymisation', '-1', 'N', 'D', 'N', 'O', 1000, null, null, GETDATE(), null, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
    Insert into sysadm.div_sin values ( @dcIdSin, 'donnees_anonymisation', 'Données d''anonymisation', '-1', 'N', 'C', 'N', 'O', 1001, null, null,null, @sDonneesAno, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 	

	Delete @Cache where id_sin = @dcIdSin
End


Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_BATCH_PM260_ANONYMISATION_SIMULATION
-- Auteur               :       JFF
-- Date                 :       11/06/2025
-- Libelle              :       Anonymation de tous les dossiers en simulation
-- Commentaires         :       [PM260]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_BATCH_PM260_ANONYMISATION_SIMULATION' AND type = 'P' )
        DROP procedure sysadm.PS_I_BATCH_PM260_ANONYMISATION_SIMULATION
GO

CREATE procedure sysadm.PS_I_BATCH_PM260_ANONYMISATION_SIMULATION  
	@asForcage Varchar ( 50 )
As

-- Si c'est lancé en production par erreur, on sort immédiatement
IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO' Return

If @asForcage is null or @asForcage <> 'CC4815C1-8156-42E2-9A74-8AFB613F03F1' Return

Declare @dtDeb DateTime
Declare @dcIdSin Decimal (10) -- [PI062]
Declare @iNbre integer
Declare @iNbreTot integer
Declare @iArretSuitErr integer
Declare @iErr integer
DECLARE @sMessage    Varchar(1000),
	    @sObjet      VarChar(255),
	    @sRetourErrMail VarChar(255),
		@sValideLe   VarChar ( 30 ),
		@sPeriodeMois VarChar ( 30 ),
		@sIdCie VarChar ( 30 ),
		@sDtePivot VarChar ( 30 ),
		@sDonneesAno VarChar ( 35 )

Set @dtDeb = GetDate()
Set @iNbre = 0
Set @iArretSuitErr = 0

DECLARE @Cache TABLE 
	( id_sin	decimal (10 ) )


Insert into @Cache
Select id_sin
From sysadm.w_sin ws
Where Not Exists ( 
			Select Top 1 1 
			From sysadm.pm260_traite pm
			Where pm.id_sin = ws.id_sin 
		)
Union
Select id_sin 
From sysadm.sinistre ws
Where Not Exists ( 
			Select Top 1 1 
			From sysadm.pm260_traite pm
			Where pm.id_sin = ws.id_sin 
		)

While Exists ( Select Top 1 1 From @Cache ) 
 Begin
 
	Set @dcIdSin = null

	Select top 1 @dcIdSin = id_sin From @Cache

	Exec sysadm.PS_U_TRT_PM260 @dcIdSin, 'SIM'

	Insert into sysadm.pm260_traite values ( @dcIdSin, GETDATE(), 0 )

	Delete @Cache where id_sin = @dcIdSin

	Select @dcIdSin, GETDATE()

End


Go
