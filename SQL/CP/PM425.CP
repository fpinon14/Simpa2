-------------------------------------------------------------------
--
-- Fichier              :       PM425.CP
-- Auteur               :       Fabry JF
-- Date                 :       12/06/2019
--
-- Commentaires         :       PS Diverses n'étant pas rattachées à une table en particuliers
--
-- Proc‚dures           :      
-------------------------------------------------------------------

--------------------------------------------------------------------
-- Proc‚dure            :       PS_S_PM425_RECUP_INFO
-- Auteur               :       Fabry JF
-- Date                 :       13/06/2019
-- Libell‚              :		[PM425-1]
-- Commentaires         :       Recherche d'écart et alerte par mail.
-- R‚f‚rences           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 Le 30/11/2004 DGA : Modification de la procédure SPB_PS_MAIL. Paramêtre @asRetourErr
-- JFF      12/02/2016   [PI062]
-- JFF      18/08/2020   [PM425] Suppression ligne contrôle sur courrier CP 00000
-- JFF      28/03/2023   [RS4843-PM425-1]
-- JFF      26/04/2023   [RS5045_REF_MATP]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM425_RECUP_INFO' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM425_RECUP_INFO
GO

CREATE PROCEDURE sysadm.PS_S_PM425_RECUP_INFO
	@adcIdSin	Decimal ( 10 ),
	@adcIdInter Decimal ( 2 ),
	@aiIdArch   integer,
	@aiIdTypDoc integer,
	@dcIdDoc    decimal (7 ) OUTPUT,   
	@asCodInter VarChar ( 1 )OUTPUT,
	@adcIdProd  Decimal ( 7 ) OUTPUT,
	@asLibCie	VarChar ( 35 ) OUTPUT,
	@asContractant	VarChar ( 35 ) OUTPUT,
	@asNomDest   VarChar ( 71 ) OUTPUT,
	@asAdr1		Varchar ( 35 ) OUTPUT,
	@asAdr2		Varchar ( 35 ) OUTPUT,
	@asAdrCP		Varchar ( 5 ) OUTPUT,
	@asAdrVille	Varchar ( 35 ) OUTPUT,
	@aiDecentralise integer OUTPUT,
	@asFondPage  VarChar (50 ) OUTPUT,
	@aiFormatSortie integer OUTPUT,
	@asChemin    VarChar ( 255 ) OUTPUT,
	@asChaine    VarChar ( 255 ) OUTPUT
AS 

Declare @sCodeBanque VarChar ( 10 )
Declare @sModeleWord VarChar ( 40 ) -- [RS5045_REF_MATP]

Select @aiDecentralise = 1,
	   @asFondPage = Upper ( rtrim ( ltrim ( sysadm.FN_CLE_VAL ( 'FOND_DE_PAGE', rtrim ( val_car ) + rtrim ( val_car2), ';' )))),
	   @aiFormatSortie = Convert ( integer, sysadm.FN_CLE_VAL ( 'FORMAT_SORTIE_WORD', rtrim ( val_car ) + rtrim ( val_car2), ';' )),
	   @asChemin = Upper ( rtrim ( ltrim ( sysadm.FN_CLE_VAL ( 'CHEMIN', rtrim ( val_car ) + rtrim ( val_car2), ';' ))))
From   sysadm.det_pro dp,
	   sysadm.sinistre s
Where  s.id_sin = @adcIdSin
And    dp.id_prod = s.id_prod
And    dp.id_code_dp = 339
And    dp.id_code_num = @aiIdTypDoc

If @aiDecentralise is null Set @aiDecentralise = 0

If @aiDecentralise = 0 Return

Select @asLibCie = rtrim ( sysadm.FN_LIB_CIE ( @adcIdSin ) )
If @asLibCie is null Set @asLibCie = '' 

Select Top 1
	   @asContractant = rtrim ( gr.lib_grp ),
	   @adcIdProd = p.id_prod

from sysadm.produit p,
	 sysadm.groupe gr,
	 sysadm.sinistre s
Where s.id_sin = @adcIdSin
And   p.id_prod = s.id_prod
And   gr.id_grp = p.id_grp

Select  @asNomDest   = IsNull ( rtrim ( i.nom ), '' ) ,
		@asAdr1		= IsNull ( rtrim (i.adr_1 ), '' ),
		@asAdr2		= IsNull ( rtrim (i.adr_2 ), '' ),
		@asAdrCP		= IsNull ( rtrim (i.adr_cp ), '' ),
		@asAdrVille	= IsNull ( rtrim (i.adr_ville ), '' ),
		@asCodInter = IsNull ( rtrim ( i.cod_inter ), '') ,
		@sCodeBanque = IsNull ( rtrim ( i.cod_bq ), '') 
From	sysadm.inter i
Where   i.id_sin = @adcIdSin
And     i.id_i = @adcIdInter

-- [RS5045_REF_MATP]
If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') >= 3 
 Begin
	
	If @aiIdArch > 0 
	  Begin
		Select @sModeleWord = lTrim ( rTrim ( a.modele_word ))
		From sysadm.archive a
		Where a.id_arch = @aiIdArch
	  End 

	If @sModeleWord is null and @dcIdDoc > 0 
	  Begin
		Select @sModeleWord = lTrim ( rTrim ( a.modele_word ))
		From sysadm.archive a
		Where a.id_sin = @adcIdSin
		And   a.id_inter = @adcIdInter
		And   a.id_doc = @dcIdDoc
	  End 

	If Upper( @sModeleWord ) = 'COURRIER.DOT' Set @sModeleWord = null

	-- Si le courrier a un modele différent de null, donc différent de courrier.dot
	-- alors on force à fond blanc car il a déjà son fond
	If @sModeleWord is Not Null Set @asFondPage = 'PAPIER_BLANC'

 End 
 -- /[RS5045_REF_MATP]

If @dcIdDoc = -1 -- [RS5045_REF_MATP]
  Begin
	Select @dcIdDoc = a.id_doc
	From   sysadm.archive a
	Where  a.id_arch = @aiIdArch
  End 

If @asAdrCP = '00000' Set @aiDecentralise = 0

-- [RS4843-PM425-1]
If sysadm.FN_CLE_NUMERIQUE ( 'RS4843-PM425-1') > 0 
 Begin
    -- Si pour le traitement des relances, le code banque de l'inter Banque et BNP ou LCL, on annule la décentralisation
	-- et on garde l'édition papier chez SPB.
	-- Si ce n'est pas une relance, ce traitement est fait autrement sur le id_typ_doc 1 et 60.
	If @aiIdTypDoc = -100 And @asCodInter = 'B' And @sCodeBanque in ( '30004', '30002' ) Set @aiDecentralise = 0 -- [RS4843-PM425-1]
 End 
 
Go


--------------------------------------------------------------------
-- Proc‚dure            :       PS_I_PM425_INSERT_TRACE
-- Auteur               :       Fabry JF
-- Date                 :       13/06/2019
-- Libell‚              :		[PM425-1]
-- Commentaires         :       
-- R‚f‚rences           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF  06/11/2020 [VDOC29832] ajout nbre page tot
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM425_INSERT_TRACE_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM425_INSERT_TRACE_V01
GO

CREATE PROCEDURE sysadm.PS_I_PM425_INSERT_TRACE_V01
   @dcIdSin              decimal (10),
   @dcIdI				 decimal (2),
   @dcIdDoc				 decimal (2),
   @iIdArch              integer,
   @iIdLot               integer,
   @sTypFichier          varchar(20),
   @sFormatSortie        varchar(30),
   @sChemin              varchar(255),
   @sFichierSortie       varchar(255),
   @iIdTypDoc            integer,
   @sFondPage            varchar (30),
   @sLibCie              varchar(35),
   @sLibGrp              varchar(35),
   @sNom                 varchar(71),
   @sAdr1                varchar(35),
   @sAdr2                varchar(35),
   @sAdrCp               varchar(5),
   @sAdrVille            varchar(35),
   @sMajPar              varchar(4),
   @NbrePageTot			 integer -- [VDOC29832]

AS

Insert into sysadm.trace_edt_decentralisee_pm425 ( 
			id_sin,    
			id_i,   
			id_doc,
			id_arch,       
			id_lot,        
			type_fichier,  
			format_sortie, 
			chemin,        
			fichier_sortie,
			id_typ_doc,    
			fond_page,     
			lib_cie,       
			lib_grp,       
			nom,           
			adr_1,         
			adr_2,         
			adr_cp,        
			adr_ville,     
			cree_le,       
			maj_le,        
			maj_par,
			nbre_page_tot )
Values (
			@dcIdSin,
			@dcIdI,  
			@dcIdDoc,     
			@iIdArch,       
			@iIdLot,        
			@sTypFichier,   
			@sFormatSortie, 
			@sChemin,       
			@sFichierSortie,
			@iIdTypDoc,     
			@sFondPage,     
			@sLibCie,       
			@sLibGrp,       
			@sNom,          
			@sAdr1,         
			@sAdr2,         
			@sAdrCp,        
			@sAdrVille,     
			GetDate(),      
			GetDate(),       
			@sMajPar,
			@NbrePageTot       
		)

Go


