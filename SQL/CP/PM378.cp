-------------------------------------------------------------------
--
-- Fichier              :       PM378.CP
-- Auteur               :       Fabry JF
-- Date                 :       19/06/2017
--
-- Commentaires         :       
-------------------------------------------------------------------

--------------------------------------------------------------------
-- Procédure            :       PM378_SINISTRE_MODIFIER_IBAN_V100
-- Auteur               :       Fabry JF
-- Date                 :       09/06/2017
-- Libellé              :		[PM378]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PM378_SINISTRE_MODIFIER_IBAN_V100' AND type = 'P' )
        DROP procedure sysadm.PM378_SINISTRE_MODIFIER_IBAN_V100
GO

CREATE procedure sysadm.PM378_SINISTRE_MODIFIER_IBAN_V100
	@sIbanOld  Varchar(27), -- Ancien Iban
	@sIbanNew  Varchar(27), -- Nouvel Iban
	@sRetour   Varchar(60) Output -- Retour OK,message
AS

Set nocount on

Declare @sOldRibBq  Varchar(5)   
Declare @sOldRibGui Varchar(5) 
Declare @sOldRibCpt Varchar(11)  
Declare @sOldRibCle Varchar(2) 

Declare @sNewRibBq  Varchar(5)   
Declare @sNewRibGui Varchar(5) 
Declare @sNewRibCpt Varchar(11)  
Declare @sNewRibCle Varchar(2) 

Declare @sMajPar Varchar(4)
Declare @iNbInter Integer
Declare @iErr     Integer

Declare @iCptValide Integer

Set @sMajPar  = 'M378'
Set @sRetour  = 'OK'
Set @sIbanOld = isnull ( @sIbanOld, '')
Set @sIbanNew = isnull ( @sIbanNew, '')
Set @iNbInter = -100 -- = aucun sinistre concerné (Marion souhaite que ce cas soit un échec)

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ),
	  id_i		decimal (7 ),
	  marquage	integer null 
	)

Declare @dcIdSin decimal ( 10 )
Declare @dcIdI decimal ( 7 )
Declare @iIdSeq integer

-- Vérification des paramétres

	If len (@sIbanNew) < 27 Or len ( @sIbanOld) < 27 
	Begin
	  Set @sRetour = 'Paramétres incorrects'
	  Return -1
	end
	
-- Transformer @sIbanOld en Rib + contrôle
	
	Set @sOldRibCpt = Space(11)
	Set @sOldRibBq  = Space(5)
	Set @sOldRibGui = Space(5)
	Set @sOldRibCle = Space(2)

	Exec sysadm.PM378_IBAN_RIB_V100 @sIbanOld, @sOldRibBq output, @sOldRibGui output, @sOldRibCpt output, @sOldRibCle output
	--Select 'Le rib Old est ', @sOldRibBq, @sOldRibGui, @sOldRibCpt, @sOldRibCle 

	If sysadm.SPB_FN_RIB_V01( @sOldRibBq, @sOldRibGui, @sOldRibCpt, @sOldRibCle ) <> 0
	   Begin
	     Set @sRetour = 'Ancien IBAN incorrect ' + @sIbanOld
		 Return -2
	   End

-- Transformer @sIbanNew en Rib + contrôle

	Set @sNewRibCpt = Space(11)
	Set @sNewRibBq  = Space(5)
	Set @sNewRibGui = Space(5)
	Set @sNewRibCle = Space(2)

	Exec sysadm.PM378_IBAN_RIB_V100 @sIbanNew, @sNewRibBq output, @sNewRibGui output, @sNewRibCpt output, @sNewRibCle output
	--Select 'Le rib Old est ', @sNewRibBq, @sNewRibGui, @sNewRibCpt, @sNewRibCle 
		
	If sysadm.SPB_FN_RIB_V01( @sNewRibBq, @sNewRibGui, @sNewRibCpt, @sNewRibCle ) <> 0
	   Begin
	     Set @sRetour = 'Nouvel IBAN incorrect ' + @sIbanNew
		 Return -3
	   End

-- Mise à jour des sinistres
Insert into @tb
select distinct 
	   id_sin,
	   id_i,
	   0 'marquage'
from	sysadm.w_inter wi
Where	rib_bq   = @sOldRibBq
And		rib_gui  = @sOldRibGui
And		rib_cpt  = @sOldRibCpt
And		rib_cle  = @sOldRibCle

Insert into @tb
select distinct 
	   id_sin,
	   id_i,
	   0 'marquage'
from	sysadm.inter i
Where	rib_bq   = @sOldRibBq
And		rib_gui  = @sOldRibGui
And		rib_cpt  = @sOldRibCpt
And		rib_cle  = @sOldRibCle

Select  @iNbInter = count ( distinct id_sin ) From @tb

While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin,
		@dcIdI	 = id_i
	From	@tb
	Where	marquage = 0

	update sysadm.w_inter
	set
		rib_bq  = @sNewRibBq,
		rib_gui = @sNewRibGui,
		rib_cpt = @sNewRibCpt,
		rib_cle = @sNewRibCle,
		maj_le  = getdate(),
		maj_par = @sMajPar
	Where id_sin = @dcIdSin
	And   id_i   = @dcIdI

	update sysadm.inter
	set
		rib_bq  = @sNewRibBq,
		rib_gui = @sNewRibGui,
		rib_cpt = @sNewRibCpt,
		rib_cle = @sNewRibCle,
		maj_le  = getdate(),
		maj_par = @sMajPar
	Where id_sin = @dcIdSin
	And   id_i   = @dcIdI

	Delete sysadm.div_sin Where id_sin = @dcIdSin and nom_zone = 'pm378_maj_rib'
	Delete sysadm.w_div_sin Where id_sin = @dcIdSin and nom_zone = 'pm378_maj_rib'

	Set @iCptValide = 0

	If Exists ( Select Top 1 1 From sysadm.sinistre Where id_sin = @dcIdSin )
	  Begin
		Set @iCptValide = 1
		Insert into sysadm.div_sin
		Select 	
			@dcIdSin,
			'pm378_maj_rib',
			'RIB mis à jour par PM378 Loi Macron',
			'-1',
			'N',
			'D',
			'O',
			'O',
			500,
			null,
			null,
			GetDate(),
			null, 
			getdate(),
			getdate(),
			'M378',
			getdate(),
			'M378'

	  End
	If Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @dcIdSin )
	  Begin
		Insert into sysadm.w_div_sin
		Select 	
			@dcIdSin,
			'pm378_maj_rib',
			'RIB mis à jour par PM378 Loi Macron',
			'-1',
			'N',
			'D',
			'O',
			'O',
			500,
			null,
			null,
			GetDate(),
			null, 
			@iCptValide,
			getdate(),
			getdate(),
			'M378'
	 End 

	Update @tb Set marquage = 1 Where id_sin = @dcIdSin -- car il  peut y en avoir plusieurs.
 End

-- Renvoi des données
Select	Distinct
		'SIMPA2' 'Application',
		'SINISTRE' 'Type',
		Convert ( varchar, p.cod_prod_dms ) 'Code_Produit_Adhésion',
		Convert ( varchar, s.id_ets ) 'Code_Ets',
		rtrim ( s.id_adh ) 'Numéro_Adhésion',
		rtrim ( s.id_sdos ) 'Numéro_Sous_Dossier',
		rtrim ( s.id_sin ) 'Numéro_Sinistre',
		sysadm.FN_LIB_PROD_ASS ( s.id_prod ) 'Nom_Du_Contrat',
		rtrim ( p.num_tel ) 'No_Tel_Produit',
		rtrim ( p.num_fax ) 'No_Tel_Produit',
		IsNull ( 
			(
			Select sysadm.FN_CLE_VAL ( 'ADR_MAIL_PROD', dp.val_car, ';' )
			From sysadm.det_pro dp
			Where dp.id_prod = s.id_prod
			And   dp.id_code_dp = 136
			), '' ) 'Adresse_Mail_Produit',
		sysadm.FN_LIB_CIE ( s.id_sin )  'Nom_Assureur',
		sysadm.FN_LIB_POLICE ( s.id_sin ) 'Lib_Police',
		Case 
			When sysadm.FN_GET_DIV_SIN ( s.id_sin, 'etat_vu_assure', 'P', '' ) in ( '1510', '1520', '1530', '900', '600', '200' )
				Then 'N'
			Else 'O'
		End 'Actif',
		sysadm.FN_CODE_NUM ( pe.cod_civ, '-CL' ) 'Civilité_Longue', 
		rtrim ( pe.nom ) 'Nom',
		rtrim ( pe.prenom ) 'Prénom',
		rtrim ( pe.adr_1) 'Adresse_1',
		rtrim ( pe.adr_2) 'Adresse_2',
		rtrim ( pe.adr_cp ) 'Code_Postal',
		rtrim ( pe.adr_ville) 'Ville',
		rtrim ( @sIbanOld ) 'Ancien_IBAN',
		rtrim ( @sIbanNew ) 'Nouvel_IBAN'

From	@tb T,
		sysadm.produit p,
		sysadm.sinistre s,
		sysadm.personne pe
Where	s.id_sin = T.id_sin
And		p.id_prod = s.id_prod
And		pe.id_ordre = s.id_ordre

If @iNbInter = -100
  Begin
	Set @sRetour = 'Aucun sinistre concerné.'
  End 

Return @iNbInter


Go


--------------------------------------------------------------------
-- Procédure            :       PM378_IBAN_RIB_V100
-- Auteur               :       Fabry JF
-- Date                 :       09/06/2017
-- Libellé              :		[PM378]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PM378_IBAN_RIB_V100' AND type = 'P' )
        DROP procedure sysadm.PM378_IBAN_RIB_V100
GO


CREATE procedure sysadm.PM378_IBAN_RIB_V100
	@sIban   Varchar(27),        -- Iban
	@sRibBq  Varchar(5)  output, -- (ref) Rib code banque
	@sRibGui Varchar(5)  output, -- (ref) Rib code guichet
	@sRibCpt Varchar(11) output, -- (ref) Rib compte
	@sRibCle Varchar(5)  output  -- (ref) Rib clé 
  
AS

-- Transformation du @sIban en @iRibBq,@iRibGui,@@sRibCpt, @iRibCle
Declare @iRet integer

Set @iRet = 0
				
Set @sRibBq  = CONVERT ( varchar(5) , null )
Set @sRibGui = CONVERT ( varchar(5) , null )
Set @sRibCle = CONVERT ( varchar(2) , null )
Set @sRibCpt = CONVERT ( varchar(11), null )

If 	@sIban is not null  and LEN(@sIban) = 27
Begin			
	Set @sRibBq  = SUBSTRING( @sIban, 5 ,5  )
	Set @sRibGui = SUBSTRING( @sIban, 10,5  )
	Set @sRibCpt = SUBSTRING( @sIban, 15,11 )
	Set @sRibCle = SUBSTRING( @sIban, 26,2  )
End

Return @iRet

Go
