--------------------------------------------------------------------
--
-- Procédure      : UTILITAIRE.CP 
-- Auteur         : FS
--
-- Libellé        : Fonctions & Procédures utilitaires
--
-- FN_INT_DTE          FS 24/02/2004 : Conversion d'une date du format integer -> format datetime
-- FN_FILTRER_CAR      FS 27/05/2004 : Filtre les caractères à gauche d'une chaine ( débourrage ex 00012 -> 12 )
-- FN_GET_BASE_GRC     FS 29/06/2004 : Obtention du nom de la base GRC à partir de la base de gestion en cours
-- PS_X_NOM            FS 16/01/2001 : Séparation d'une chaine en nom + prenom
-- FN_DTE_RNV         JFF 26/12/2005 : Calcule une date de renouvellement à partir d'un n° de sinistre
-- FN_CODE_NUM 	       FS 18/11/2005 : Retourne le libellé d'un code numérique
-- FN_CODE_CAR 	       FS 18/11/2005 : Retourne le libellé d'un code caractère
-- FN_LIB_PROD        JFF 17/01/2006 : Retourne le libellé long du produit
-- FN_CORR_IMEI       JFF 23/01/2007 : Retourne un IMEI corrigé.
-- FN_CLE_VAL         JFF 21/02/2007 : Pour un clé fournie, qui se trouve dans une chaîne de caractères, retourne la valeur liée, en précisant le séparateur
-- FN_MESS            JFF 14/03/2007 : Accèlère la lecture d'une donné sur tb sysadm.message
-- FN_CORR_NUM_CARTE  JFF 15/01/2008 : Renvoi un n° de carte bancaire corrigé
-- FN_CLE_VAL_E       JFF 21/02/2007 : Pour un clé fournie, qui se trouve OU PAS dans une chaîne de caractères, écrit la valeur sur la clé et créé la clé si inexistante, en précisant le séparateur
-- FN_MASQUER_CARTE    FS 12/02/2008 : Masque partiellement un n° de carte
-- FN_TAG	      JFF 19/08/2009 : Générateur de TAG.
-- FN_GET_DOS_SUIVI_PAR  FS  le 24/09/2009 : Obtention du responsable du suivi de dossier
-- FN_GET_LIB_POLICE	FPI 08/10/2009 [EXPANSION5.LIB_POLICE]
-- FN_GET_LIB_POLICE_V01	SBA 21/07/2010 [PC202]
-- PS_CORRIGE_CPT_VALIDE	FPI	le 19/10/2008 : Correction de la valeur de CPT_valide dans les différentes tables
-- DW_S01_LIB_POLICE	FPI 28/10/2009 [EXPANSION5.LIB_POLICE]
-- DW_S01_LIB_POLICE_V01 	SBA 21/07/2010 [PC202]
-- PS_S01_LIB_POLICE	JFF 20/11/2009 [POLICE_PARTICULIERE] 	
-- FN_GET_DIVERS_SINISTRE SBA 30/06/2010 : Renvoi le détail d'un sinistre
-------------------------------------------------------------------
-- PROCEDURE sysadm.DW_S01_LIB_POLICE_V01
-- function sysadm.FN_A_COMMANDER
-- function sysadm.FN_AFF_DATE 
-- function sysadm.FN_AFF_DATE_CLOTURE_ASS 
-- function sysadm.FN_CLE_VAL
-- function sysadm.FN_CLE_VAL_E
-- function sysadm.FN_CLE_VAL_XML  
-- function sysadm.FN_CLE_VAL_XML_SUBST
-- function sysadm.FN_CODE_CAR  
-- function sysadm.FN_CODE_NUM  
-- function sysadm.FN_CORR_IMEI
-- function sysadm.FN_CORR_NUM_CARTE
-- function sysadm.FN_CORR_NUM_CARTE_19
-- function sysadm.FN_CTRLE_ADR_MAIL 
-- function sysadm.FN_DATEDIFF  
-- function sysadm.FN_DATEDIFF_V01  
-- function sysadm.FN_DECRYPTE_NUM_CARTE
-- function sysadm.FN_DEM_RCP_PIECE 
-- function sysadm.FN_DTE_1ER_REGL 
-- function sysadm.FN_DTE_CLO 
-- function sysadm.FN_DTE_RNV 
-- function sysadm.FN_EPURE_CHAINE_V02 
-- function sysadm.FN_EVT_REMPL 
-- function sysadm.FN_FILTRER_CAR 
-- function sysadm.FN_GET_ASCENSION 
-- function sysadm.FN_GET_BASE_GRC )
-- function sysadm.FN_GET_DIV_SIN
-- function sysadm.FN_GET_DIVERS_SINISTRE 
-- function sysadm.FN_GET_DOS_SUIVI_PAR  @iIdSin Integer )
-- function sysadm.FN_GET_ETAT_DOSSIER_PM251
-- function sysadm.FN_GET_ETAT_GARANTIE_PM251
-- function sysadm.FN_GET_ID_CORB  
-- function sysadm.FN_GET_LIB_POLICE_V01
-- function sysadm.FN_GET_LISTE_GTI 
-- function sysadm.FN_GET_LUNDI_DE_PAQUES 
-- function sysadm.FN_GET_LUNDI_DE_PENTECOTE 
-- function sysadm.FN_GET_NOM_PRENOM  
-- function sysadm.FN_GET_PAQUES  
-- function sysadm.FN_GET_PENTECOTE 
-- function sysadm.FN_ID_CIE 
-- function sysadm.FN_INT_DTE 
-- function sysadm.FN_IS_DATE  
-- function sysadm.FN_IS_REG_ASSURE
-- function sysadm.FN_LIB_CIE 
-- function sysadm.FN_LIB_ETAT_DOS 
-- function sysadm.FN_LIB_ETAT_DOS_ASSURE 
-- function sysadm.FN_LIB_ETAT_DOS_ASSURE_V07 
-- function sysadm.FN_LIB_GROUPE 
-- function sysadm.FN_LIB_POLE  
-- function sysadm.FN_LIB_POLE  
-- function sysadm.FN_LIB_POLICE 
-- function sysadm.FN_LIB_PROD  
-- function sysadm.FN_LIB_PROD_ASS  
-- function sysadm.FN_MASQUER_CARTE
-- function sysadm.FN_MASQUER_CARTE_2
-- function sysadm.FN_MESS
-- function sysadm.FN_SOM_REGL 
-- function sysadm.FN_TAG 
-- Procedure  sysadm.PS_S_CHAINE_ALEATOIRE
-- PROCEDURE sysadm.PS_CHARGER_UN_FICHIER_BINAIRE_ADODB_STREAM
-- PROCEDURE sysadm.PS_CHARGER_UN_FICHIER_TEXTE_ADODB_STREAM
-- PROCEDURE sysadm.PS_DETRUIRE_UN_OBJET_SQL_SERVER 
-- PROCEDURE sysadm.PS_ECRIRE_UN_ENREGISTREMENT_ADODB_STREAM_V03
-- PROCEDURE sysadm.PS_FERMER_UN_FICHER_ADODB_STREAM 
-- PROCEDURE sysadm.PS_FILE_OPEN_REWRITE 
-- PROCEDURE sysadm.PS_INSTANCIER_UN_OBJET_SQL_SERVER 
-- PROCEDURE sysadm.PS_SAUVEGARDER_ET_FERMER_UN_FICHER_ADODB_STREAM 
-- function sysadm.FN_GET_LIB_POLICE
-- FUNCTION sysadm.FN_GET_PERIODE_TRT
-- PROC PS_X_NOM
-- procedure [sysadm].[PS_DATEDIFF]
-- PROCEDURE sysadm.DW_S01_LIB_POLICE
-- procedure sysadm.PS_CASSER_REGLE_CHAINE
-- PROCEDURE sysadm.PS_CORRIGE_CPT_VALIDE 
-- procedure sysadm.PS_DECRYPTE_NUM_CARTE
-- PROCEDURE sysadm.PS_FILE_CLOSE 
-- PROCEDURE sysadm.PS_FILE_EXISTS 
-- PROCEDURE sysadm.PS_FILE_WRITE_DATA 
-- PROCEDURE sysadm.PS_MAIL_RAPPORT_SIM(
-- PROCEDURE sysadm.PS_S01_LIB_POLICE_V01
-------------------------------------------------------------------


--------------------------------------------------------------------
--
-- Procédure            : FN_INT_DTE
-- Auteur               : FS
-- Date                 : 24/02/2004
-- Libellé              : Conversion d'une date exprimée en integer ( dosad )
--                        
--
-- Références           : PS_REC_ADH
--
-- Arguments            : @iDte   Integer Date sous forme AAAAMMJJ
--                        
-- Retour               : Datetime : Valeur de la date / Null si paramétre passé pas valide
--	                        
-------------------------------------------------------------------

Drop function sysadm.FN_INT_DTE

Go

CREATE  function sysadm.FN_INT_DTE  (
        @iDte    Integer              )
RETURNS Datetime

AS

Begin

 Declare @dtDte Datetime
 Declare @sDte  Varchar(10)
 Declare @iAn   Integer
 Declare @iMois Integer
 Declare @iJour Integer

 Select @dtDte = Convert ( Datetime  , null  )
 Select @sDte  = Convert ( Varchar(8), @iDte )

 Select @iAn   = Convert ( Integer, Substring ( @sDte , 1, 4 ) )
 Select @iMois = Convert ( Integer, Substring ( @sDte , 5, 2 ) )
 Select @iJour = Convert ( Integer, Substring ( @sDte , 7, 2 ) )

 If ( @iJour Between 1 And 31 ) And ( @iMois Between 1 And 12 )

   Begin

         Select @sDte  = Convert ( varchar(2), @iJour ) + '/' + 
                         Convert ( varchar(2), @iMois ) + '/' + 
                         Convert ( varchar(4), @iAn   )

         If ISDATE ( @sDte ) = 1  Select @dtDte = Convert ( datetime, @sDte )

   End

 Return @dtDte

End

Go

--------------------------------------------------------------------
--
-- Procédure            : FN_FILTRER_CAR
-- Auteur               : FS
-- Date                 : 27/05/2004
-- Libellé              : Filtre les caractères à gauche d'une chaine
--                        
--
-- Références           : reglement
--
-- Arguments            : @sVal : Chaine de caractère à filtrer
--                        @sCar : Caractère à filter
--                        
-- Retour               : La chaine filtrée
--	                        
-------------------------------------------------------------------

Drop function sysadm.FN_FILTRER_CAR

Go

CREATE  function sysadm.FN_FILTRER_CAR  (
        @sVal Varchar(60), @sCar Char(1) )
RETURNS Varchar(60)

AS

Begin

  Declare @iLen Integer
  Declare @iCpt Integer
  Select  @iCpt = 0

  Select @iLen = len ( @sVal )

  While @iCpt <= @iLen
     Begin
       Select @iCpt = @iCpt + 1
       If Substring ( @sVal, @iCpt, 1 ) <> @sCar
        Begin
           Select @sVal = Right ( @sVal, ( @iLen - @iCpt )+1 )
           Break
        End
     End

  Return @sVal
End

Go




--------------------------------------------------------------------
--
-- Fonction             : FN_GET_BASE_GRC
-- Auteur               : FS
-- Date                 : 29/06/2004
-- Libellé              : Obtention du nom de la base GRC à partir de la base de gestion en cours
--                        
-- Références           : PS_REC_ADH
--
-- Arguments            : Aucun
--                        
-- Retour               : Varchar(30) Nom de la base GRC / Null si pas d'accès
--	                        
-------------------------------------------------------------------

Drop function sysadm.FN_GET_BASE_GRC
Go

CREATE  function sysadm.FN_GET_BASE_GRC  ()
RETURNS Varchar(30)

AS

Begin
  Declare @sRet varchar(60)
  Declare @iNb  integer

  Select @sRet = id_base_grc
    From sysadm.base_grc
   Where
         Upper ( db_name( db_id() ) ) = id_base_gestion

  -- Vérification si base GRC existe bien sur master

  Select @iNb = count(*) 
    From
         master..sysdatabases  
   Where
         name = @sRet 

  If @iNb = 0
     Begin
      Select @sRet = Convert( varchar(60), Null )
     End

  Return @sRet

End
go


--------------------------------------------------------------------
--
-- Procedure    : PS_X_NOM
-- Auteur       : FS
-- Date         : 16/01/2001
-- libelle      : S‚paration d'une chaine NOM + PRENOM
-- Commentaires : 
--
-- Arguments    : 
--                
--
-- Retourne     : 
--
-------------------------------------------------------------------
-- #1 FS le 08/11/2002 : Orange : Il existe des nom + pr‚noms s‚par‚s par 2 espaces
-- #2 FS le 09/01/2003 : Orange : Il existe des nom + pr‚noms comman‡ant par des espaces
-- #3 FS le 26/06/2003 : Correction dans le cas des noms de type XX XXXXX ( sans prénom ! )
-- #4 FS le 28/08/2003 : Correction dans le cas des noms de type X XXXXX ( sans prénom ! )
-------------------------------------------------------------------

IF EXISTS ( select * FROM sysobjects WHERE name = 'PS_X_NOM' AND type = 'P' )
 DROP procedure sysadm.PS_X_NOM
GO

CREATE PROC PS_X_NOM
 @sLib    Varchar(71)       ,
 @sNom    Varchar(35) Output,
 @sPrenom Varchar(35) Output

AS

Declare @iPos    Integer


/*------------------------------------------------------------------*/
/* #2 Retrait des espaces avant et aprŠs la chaine @sLib            */
/*------------------------------------------------------------------*/

Select @sLib = Ltrim ( @sLib )  /* Gauche */
Select @sLib = Rtrim ( @sLib )  /* Droite */


Select @iPos  = CHARINDEX ( ' ', @sLib )                             /* ... Position 1er espace */

/*------------------------------------------------------------------*/
/* Un seul mot = Nom ...                                            */
/* On prend … partir du 4Šme car pour traiter                       */
/* les noms compos‚s sans pr‚nom                                    */
/*------------------------------------------------------------------*/

 If @iPos = 0
     Begin
       Select @sNom    = @sLib
       Select @sPrenom = '-'
       Select @iPos    = 0
     End

   /*---------------------------*/	        
   /* ... Pas de nom compos‚ ...*/
   /*---------------------------*/

   If @iPos <> 0 And @sLib not LIKE '__ %'
      Begin
        Select @sNom    = SUBSTRING ( @sLib, 1, @iPos -1 )
        Select @sPrenom = RTRIM ( SUBSTRING ( @sLib, @iPos + 1,35 ) )
      End

   /*---------------------------*/	        
   /* ... Nom 1 Lettre + 1 espace ...*/
   /*---------------------------*/

   If @iPos <> 0 And @sLib LIKE '_ %'
        -- #4 Ajout du text

        If CHARINDEX ( ' ', SUBSTRING ( @sLib, 3, 35 ) ) = 0
           Begin
              Select @sNom    = @sLib
              Select @sPrenom = '-'
           End
        Else
           Begin
             Select @sNom    = SUBSTRING ( @sLib, 1, 2 ) +  SUBSTRING ( SUBSTRING ( @sLib, 3, 35), 1, CHARINDEX ( ' ', SUBSTRING ( @sLib , 3, 35 ) ) -1 )
  	     Select @sPrenom = RTRIM ( SUBSTRING ( SUBSTRING ( @sLib, 3, 35 ), CHARINDEX( ' ', SUBSTRING ( @sLib, 3, 35 ) ) + 1,35 ) )
           End

   /*---------------------------*/	
   /* ... Nom compos‚ simple ...*/
   /*---------------------------*/

   If @iPos <> 0 And @sLib Like '__ %' And @sLib Not Like '__ __ %'
      Begin
        -- #3 ancienne commande  If CHARINDEX ( ' ', SUBSTRING ( @sLib +' ' , 4, 35 ) ) = 0 
        If CHARINDEX ( ' ', SUBSTRING ( @sLib, 4, 35 ) ) = 0
           Begin
             Select @sNom    = Substring ( @sLib, 1, 2  )  /* #1 Nom    = 2 1er caractères */
             Select @sPrenom = Substring ( @sLib, 4, 35 )  /* #1 Prenom = La suite         */
	   End
             Else
	   Begin
	     Select @sNom    = SUBSTRING ( @sLib, 1, 3 ) +  SUBSTRING ( SUBSTRING ( @sLib, 4, 35), 1, CHARINDEX ( ' ', SUBSTRING ( @sLib , 4, 35 ) ) -1 )
	     Select @sPrenom = RTRIM ( SUBSTRING ( SUBSTRING ( @sLib, 4, 35 ), CHARINDEX( ' ', SUBSTRING ( @sLib, 4, 35 ) ) + 1,35 ) )
	   End
      End

   /*---------------------------*/
   /* ... Nom compos‚ double ...*/
   /*---------------------------*/
     If @iPos <> 0 And @sLib Like '__ __ %'
        Begin
          -- #3 Ancienne commande If CHARINDEX ( ' ', SUBSTRING ( @sLib +' ' , 7, 35 ) ) = 0
          If CHARINDEX ( ' ', SUBSTRING ( @sLib, 7, 35 ) ) = 0
             Begin
              --Select @sNom    = @sLib
              --Select @sPrenom = '-'
              Select @sNom    = Substring ( @sLib, 1, 5  )  /* #1 Nom    = 5 1er caractères */
              Select @sPrenom = Substring ( @sLib, 6, 35 )  /* #1 Prenom = La suite         */
             End
          Else
             Begin
               Select @sNom    =  substring ( @sLib, 1, 6 ) +
                                  substring( substring ( @sLib, 7, 35 ), 1, charindex( ' ', substring ( @sLib, 7, 35 ) ) -1 )
       	       Select @sPrenom =  RTRIM ( substring( substring ( @sLib, 7, 30 ), charindex( ' ', substring ( @sLib, 7, 30 ) ) + 1,30 ))
             End
         End

   /*---------------------------*/
   /* #1 Retrait des espaces    */
   /*---------------------------*/

   Select @sNom    = Ltrim ( @sNom )
   Select @sPrenom = Ltrim ( @sPrenom )


Go



--------------------------------------------------------------------
--
-- Fonction             :       FN_DTE_RNV
-- Auteur               :       Fabry JF
-- Date                 :       26/12/2005
-- Libellé              :
-- Commentaires         :       Calcule une date de renouvellement à partir d'un n° de sinistre
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_DTE_RNV' AND type = 'FN' )
        DROP function sysadm.FN_DTE_RNV
GO


CREATE  function sysadm.FN_DTE_RNV  (
        @dcIdSin    Decimal (10) ) -- [PI062]
RETURNS Datetime
AS

Begin

declare @dcIdProd   decimal (7)
declare @dtDteRnv   DateTime
declare @dtDteAdh   DateTime
declare @dtDteSurv  Datetime
declare @dtRnvCalc  DateTime
declare @iDurPerRnv integer
declare @sUntPerRnv VarChar ( 1 )


Set @dtDteRnv = null

-- Si pas de sin, retour date null
If @dcIdSin is null return @dtDteRnv 

-- Produit concerné
select @dcIdProd = s.id_prod,
       @dtDteAdh = s.dte_adh,	
       @dtDteSurv = s.dte_surv
from   sysadm.sinistre s
where  s.id_sin = @dcIdSin

If @@ROWCOUNT <= 0 
  Begin
	select @dcIdProd = s.id_prod,
		   @dtDteAdh = s.dte_adh,	
		   @dtDteSurv = s.dte_surv
	from   sysadm.w_sin s
	where  s.id_sin = @dcIdSin
  End 

-- Si pas de sin, retour date null
If @dtDteAdh is null return @dtDteRnv 
If @dtDteSurv is null return @dtDteRnv 

-- Période rnv et unité
Select  @iDurPerRnv = dur_perrnv_adh ,
	@sUntPerRnv = unt_perrnv_adh
From    sysadm.produit p
Where   p.id_prod = @dcIdProd

Set 	@dtRnvCalc = @dtDteAdh
Set 	@dtDteRnv  = @dtRnvCalc


While ( @dtRnvCalc <= @dtDteSurv )
Begin

 Set @dtDteRnv = @dtRnvCalc

 Select @dtRnvCalc = 
  Case 
   When (@sUntPerRnv = 'J' ) Then DateAdd ( Day,   @iDurPerRnv, @dtRnvCalc )	      			
   When (@sUntPerRnv = 'M' ) Then DateAdd ( Month, @iDurPerRnv, @dtRnvCalc )	      			
   When (@sUntPerRnv = 'A' ) Then DateAdd ( Year,  @iDurPerRnv, @dtRnvCalc )	      			
  End
End

Return @dtDteRnv

End 
GO



IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_CODE_NUM' AND type = 'FN' )
        DROP function sysadm.FN_CODE_NUM
Go

CREATE  function sysadm.FN_CODE_NUM  
--------------------------------------------------------------------------------------------
-- FN_CODE_NUM FS le 18/11/2005 : Retourne le libellé d'un code numérique
--------------------------------------------------------------------------------------------
   (
        @iIdCode    Integer,   -- Identifiant du code numérique
        @sIdTypCode Varchar(10)-- Type de code
    )
RETURNS Varchar(35)

AS

Begin

  Declare @sLibCode Varchar(35)

  Select Top 1 @sLibCode = lib_code From sysadm.code with (nolock) Where id_typ_code = @sIdTypCode and id_code = @iIdCode

  Return Rtrim ( @sLibCode )

End

Go



IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_CODE_CAR' AND type = 'FN' )
        DROP function sysadm.FN_CODE_CAR
Go

CREATE  function sysadm.FN_CODE_CAR  
--------------------------------------------------------------------------------------------
-- FN_CODE_CAR FS le 18/11/2005 : Retourne le libellé d'un code caractère
--------------------------------------------------------------------------------------------
       (
        @sIdCode    Varchar(10)   , -- Identifiant du code caractère 
        @sIdTypCode Varchar(10) -- Type de code  
        )
RETURNS Varchar(35)

AS

Begin

  Declare @sLibCode Varchar(35)

  Select Top 1 @sLibCode = lib_code From sysadm.code_car with (nolock) Where id_typ_code = @sIdTypCode and id_code = @sIdCode

  Return Rtrim(@sLibCode)

End
Go

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_LIB_PROD' AND type = 'FN' )
        DROP function sysadm.FN_LIB_PROD
Go

CREATE  function sysadm.FN_LIB_PROD  
--------------------------------------------------------------------------------------------
-- FN_LIB_PROD JFF le 17/01/2006 : Retourne le libellé long du produit
-- FPI - 21/01/2008 - [DCMP080728] - Agrandissement de lib_long (35 -> 65)
--------------------------------------------------------------------------------------------
       ( @dcIdProd    decimal ( 7 )
        )
RETURNS Varchar(65)

AS

Begin

  Declare @sLibLong Varchar(65)

  Select @sLibLong = sysadm.FN_TRIM ( lib_long ) From sysadm.produit Where id_prod = @dcIdProd

  Return @sLibLong 

End
Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_LIB_PROD_ASS
-- Auteur               :       Fabry JF
-- Date                 :       19/06/2017
-- Libellé              :
-- Commentaires         :       [PM378]
-- Références           :       Renvoie le libellé assuré dp/66&67 sinon produit.lib_long
--
-- Arguments            :       id_prod
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_LIB_PROD_ASS' AND type = 'FN' )
        DROP function sysadm.FN_LIB_PROD_ASS
Go

CREATE  function sysadm.FN_LIB_PROD_ASS  
       ( @dcIdProd    decimal ( 7 )
        )
RETURNS Varchar(100)

AS

Begin

	Declare @sLibProdAss Varchar ( 100 )

	Select @sLibProdAss = 
			IsNull ( 
			( Select ltrim ( rtrim ( val_car ) )
			  From sysadm.det_pro dp 
			  Where dp.id_prod = @dcIdProd
			  and   dp.id_code_dp = 66 ), '' ) 
	From	sysadm.det_pro dp
	Where	dp.id_prod = @dcIdProd
	And		dp.id_code_dp = 66
	
	If @sLibProdAss is not null
	  Begin
		Select @sLibProdAss = @sLibProdAss + ' / ' +
				IsNull ( 
				( Select ltrim ( rtrim ( val_car ) )
				  From sysadm.det_pro dp 
				  Where dp.id_prod = @dcIdProd
				  and   dp.id_code_dp = 67 ), '' ) 
		From	sysadm.det_pro dp
		Where	dp.id_prod = @dcIdProd
		And		dp.id_code_dp = 67
	  End

	If @sLibProdAss is null
	  Begin
		  Select @sLibProdAss = sysadm.FN_TRIM ( lib_long ) From sysadm.produit Where id_prod = @dcIdProd
	  End 
  Return @sLibProdAss 

End
Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_CORR_IMEI
-- Auteur               :       Fabry JF
-- Date                 :       23/01/2007
-- Libellé              :
-- Commentaires         :       Renvoi un n° d'IMEI corrigé
-- Références           :       
--
-- Arguments            :       le début de l'imei de 0 à 15 chiffres possibles
--				Ex : Select sysadm.FN_CORR_IMEI ( '352003', GetDate() )
--				     Select sysadm.FN_CORR_IMEI ( '35200355547', GetDate() )	
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_CORR_IMEI' AND type = 'FN' )
        DROP function sysadm.FN_CORR_IMEI
Go

CREATE  function sysadm.FN_CORR_IMEI
       ( @asRacine        VarChar ( 15 ),
	 @dtGetDate       DateTime )
RETURNS Varchar(15)

AS

Begin

	Declare @iFin integer
	Declare @iCpt integer
	Declare @iSom  integer
	Declare @iCalc  integer
	Declare @Coef integer
	Declare @iIdCarte Decimal ( 7 )
	Declare @CpltRacine VarChar ( 24 )   -- Complement de racine
	Declare @sCle VarChar ( 1 )    -- Cle calculée
	
	Set @iFin = 0
	Set @iCpt = 1
	Set @iIdCarte = -1
	Set @iSom = 0
	
	select @CpltRacine = Convert ( varchar (24) , @dtGetDate,14 ) + Convert ( varchar ( 24) , @dtGetDate,14 ) 
	
	WHILE ( @iCpt <= Len ( @CpltRacine ) )
	BEGIN
	   If ( Select Substring ( @CpltRacine, @iCpt, 1 ) ) = ':' 
	     Begin
	        Set @CpltRacine = Left ( @CpltRacine, @iCpt - 1 ) + Substring ( @CpltRacine, @iCpt + 1, Len (@CpltRacine)  ) 
	        Set @iCpt = 1
	     End 
	   Else
	     Begin
	        Set @iCpt = @iCpt + 1
	     End 
	
	End
	
	Set @asRacine = Left ( @asRacine + @CpltRacine, 14 )
	
	Set @iCpt = 1
	
	While @iCpt <= 14
	 Begin
	   If ( @iCpt % 2 = 0 )
	     Begin
	        Set @iCalc = Convert ( integer, SubString ( @asRacine, @iCpt, 1 ) ) * 2
	        If  @iCalc >= 10 
	          Begin
	            Set @iCalc = Convert ( int, Left ( Convert ( VarChar ( 2 ), @iCalc ), 1 ) ) + 
	                         Convert ( int, Right ( Convert ( VarChar ( 2 ), @iCalc ), 1 ) )
	          End
	   
	        Set @iSom = @iSom + @iCalc
	     End
	   Else
	     Begin
	        Set @iSom = @iSom + Convert ( integer, SubString ( @asRacine, @iCpt, 1 ) )
	     End
	   Set @iCpt = @iCpt + 1
	 End 
	
	If ( @iSom % 10 = 0 ) 
	 Set @sCle = 0
	Else
	 Set @sCle = Convert ( VarChar (1),  ( ( Convert ( int ,  @iSom / 10 ) * 10 ) + 10 ) - @iSom )
	
	Set @asRacine = @asRacine + @sCle

  Return @asRacine

End
Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_CLE_VAL
-- Auteur               :       Fabry JF
-- Date                 :       21/02/2007
-- Libellé              :
-- Commentaires         :       Pour un clé fournie, se trouve dans une chaîne de caractères, 
--				retourne la valeur liée, en précisant le séparateur
-- Références           :       Ex : Select sysadm.FN_CLE_VAL ( 'TOTO', 'XYXU=TOTO;TOTO=TUTU;TITI=TETE;XYXY=TOTO;RERE=;FRFR=', ';' )
--
-- Arguments            :       @asCle		VarChar ( 255 )  La clé à rechercher
--				@asChaine	VarChar ( 255 )  La clé à parcourir
--				@asSep		VarChar ( 1 )    Le séparateur
--
-- Retourne             :       @asVal	 	VarChar ( 255 )  La valeur en retour
--
-- JFF  19/12/2018   Ajout lTrim ( Rtrim ( sur le retour
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_CLE_VAL' AND type = 'FN' )
        DROP function sysadm.FN_CLE_VAL
Go

CREATE  function sysadm.FN_CLE_VAL
   (
	@asCle		VarChar ( 255 ) , 
	@asChaine	VarChar ( 1000 ) ,
	@asSep		VarChar ( 1 )   
    )
RETURNS Varchar(1000)

AS

Begin

  Declare @iDeb Integer
  Declare @iFin Integer
  Declare @sVal VarChar ( 1000 )
  Declare @AltDebCleValide Integer
  Declare @AltFinCleValide Integer

  Set @iDeb = CharIndex ( @asCle + '=', @asChaine, 1 ) 
  Set @sVal = ''
  Set @AltDebCleValide = 0
  Set @AltFinCleValide = 0

  While @iDeb > 0 
   Begin
     If @iDeb = 1 
	Begin
	  Set @AltDebCleValide = 1
	End 

     If @iDeb > 1 
 	Begin
	  if Substring ( @asChaine, @iDeb - 1, 1 ) = @asSep
		Begin
			Set @AltDebCleValide = 1
		End 
	End 

     Set @iFin = CharIndex ( '=', @asChaine, @iDeb ) 
     If @iFin > 0 
	Begin 
		Set @AltFinCleValide = 1	
	End 

     -- Ce n'est pas une clé
     If @AltDebCleValide = 0 Or @AltFinCleValide = 0
	Begin
	        Set @iDeb = CharIndex ( @asCle + '=', @asChaine, @iDeb + 1 ) 
	End
     
     -- C'est bien une clé valide
     If @AltDebCleValide = 1 And @AltFinCleValide = 1
	Begin
	     Set @iDeb = @iFin + 1
	     Set @iFin = CharIndex ( @asSep, @asChaine, @iDeb ) - 1
	     if @iFin <= 0 Set @iFin = Len ( @asChaine )
	     
	     if @iFin > 0 
	      Begin
	        Set @sVal = Substring ( @asChaine, @iDeb, @iFin - @iDeb + 1 )
		Set @iDeb = 0
	      End
	End
   End

   If @sVal is null Set @sVal = ''

   Return  ltrim ( rTrim ( @sVal ))

End

Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_MESS
-- Auteur               :       Fabry JF
-- Date                 :       14/03/2007
-- Libellé              :
-- Commentaires         :       Lecture rapide sur la table sysadm.message
--				retourne le message dans la langue spécifié
-- Références           :       Ex : Select @monMess = sysadm.FN_MESS ( 2, 'FRA' )
--
-- Arguments            :       @aiIdMess	Integer  	Clé du message
--				@asLang		VarChar ( 3 )  	La Langue ('-LG'/CodeCar)
--				
--
-- Retourne             :       @asTxtMess 	VarChar ( 8000 )  Le texte du message en retour
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_MESS' AND type = 'FN' )
        DROP function sysadm.FN_MESS
Go

CREATE  function sysadm.FN_MESS
   (
	@aiIdMess	Integer, 
	@asLang		VarChar ( 3 )
    )
RETURNS Varchar(8000)

AS

Begin
	Declare @sTxtMess VarChar ( 8000 )

	Set @sTxtMess = ''

	Select @sTxtMess = IsNull ( m.txt_mess, '' )
	From   sysadm.message m
	Where  m.id_mess = @aiIdMess
	And    m.id_lg = @asLang

	Return @sTxtMess

End

Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_CORR_NUM_CARTE
-- Auteur               :       Fabry JF
-- Date                 :       15/01/2008
-- Libellé              :
-- Commentaires         :       Renvoi un n° de carte bancaire corrigé
-- Références           :       
--
-- Arguments            :       le début de la carte de 0 à 16 chiffres possibles
--				Ex : Select sysadm.FN_CORR_NUM_CARTE ( '352003', GetDate() )
--				     
--
-- Retourne             :       Rien
--
--------------------------------------------------------------------


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_CORR_NUM_CARTE' AND type = 'FN' )
        DROP function sysadm.FN_CORR_NUM_CARTE
Go

CREATE  function sysadm.FN_CORR_NUM_CARTE
       ( @asRacine        VarChar ( 16 ),
	 @dtGetDate       DateTime )
RETURNS Varchar(16)

AS

Begin

	Declare @iFin integer
	Declare @iCpt integer
	Declare @iSom  integer
	Declare @iCalc  integer
	Declare @Coef integer
	Declare @iIdCarte Decimal ( 7 )
	Declare @CpltRacine VarChar ( 24 )   -- Complement de racine
	Declare @sCle VarChar ( 1 )    -- Cle calculée
	
	Set @iFin = 0
	Set @iCpt = 1
	Set @iIdCarte = -1
	Set @iSom = 0
	
	select @CpltRacine = Convert ( varchar (24) , @dtGetDate,14 ) + Convert ( varchar ( 24) , @dtGetDate,14 ) 
	
	WHILE ( @iCpt <= Len ( @CpltRacine ) )
	BEGIN
	   If ( Select Substring ( @CpltRacine, @iCpt, 1 ) ) = ':' 
	     Begin
	        Set @CpltRacine = Left ( @CpltRacine, @iCpt - 1 ) + Substring ( @CpltRacine, @iCpt + 1, Len (@CpltRacine)  ) 
	        Set @iCpt = 1
	     End 
	   Else
	     Begin
	        Set @iCpt = @iCpt + 1
	     End 
	
	End
	
	Set @asRacine = Left ( @asRacine + @CpltRacine, 15 )
	
	Set @iCpt = 1
	
	While @iCpt <= 15
	 Begin
	   If ( @iCpt % 2 <> 0 )
	     Begin
	        Set @iCalc = Convert ( integer, SubString ( @asRacine, @iCpt, 1 ) ) * 2
	        If  @iCalc >= 10 
	          Begin
	            Set @iCalc = Convert ( int, Left ( Convert ( VarChar ( 2 ), @iCalc ), 1 ) ) + 
	                         Convert ( int, Right ( Convert ( VarChar ( 2 ), @iCalc ), 1 ) )
	          End
	   
	        Set @iSom = @iSom + @iCalc
	     End
	   Else
	     Begin
	        Set @iSom = @iSom + Convert ( integer, SubString ( @asRacine, @iCpt, 1 ) )
	     End
	   Set @iCpt = @iCpt + 1
	 End 
	
	If ( @iSom % 10 = 0 ) 
	 Set @sCle = 0
	Else
	 Set @sCle = Convert ( VarChar (1),  ( ( Convert ( int ,  @iSom / 10 ) * 10 ) + 10 ) - @iSom )
	
	Set @asRacine = @asRacine + @sCle

  Return @asRacine

End
Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_CLE_VAL_E
-- Auteur               :       Fabry JF
-- Date                 :       19/11/2008
-- Libellé              :
-- Commentaires         :       Pour un clé fournie, qui se trouve OU PAS dans une chaîne de caractères, 
--				écrit la valeur sur la clé et créé la clé si inexistante, en précisant le séparateur
-- Références           :       Ex : Select sysadm.FN_CLE_VAL_E ( 'TOTO', 'MA_VALEUR', 'XYXU=TOTO;TOTO=TUTU;TITI=TETE;XYXY=TOTO;RERE=;FRFR=', ';' )
--						Renvoi 'XYXU=TOTO;TOTO=MA_VALEUR;TITI=TETE;XYXY=TOTO;RERE=;FRFR='
-- Autres tests
-- Select sysadm.FN_CLE_VAL_E ( 'TOTO', 'MA_VALEUR', 'XYXU=TOTO;TITI=TETE;TOTO=TUTU;XYXY=TOTO;RERE=;FRFR=', ';' )
-- Select sysadm.FN_CLE_VAL_E ( 'TOTO', 'MA_VALEUR', 'TOTO=TUTU;XYXU=TOTO;TITI=TETE;XYXY=TOTO;RERE=;FRFR=', ';' )
-- Select sysadm.FN_CLE_VAL_E ( 'TOTO', 'MA_VALEUR', 'XYXU=TOTO;TITI=TETE;XYXY=TOTO;RERE=;FRFR=', ';' )
-- Select sysadm.FN_CLE_VAL_E ( 'TOTO', 'MA_VALEUR2', 'XYXU=TOTO;TITI=TETE;XYXY=TOTO;RERE=;FRFR=;TOTO=MA_VALEUR', ';' )
-- Select sysadm.FN_CLE_VAL_E ( 'TOTO', 'MA_VALEUR2', '', ';' )
--
-- Arguments            :       @asCle		VarChar ( 255 )  La clé à rechercher
--				@asNouvVal	VarChar ( 255 )  La valeur à écrire
--				@asChaine	VarChar ( 255 )  La chaine à parcourir
--				@asSep		VarChar ( 1 )    Le séparateur
--
-- Retourne             :       
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_CLE_VAL_E' AND type = 'FN' )
        DROP function sysadm.FN_CLE_VAL_E
Go

CREATE  function sysadm.FN_CLE_VAL_E
   (
	@asCle		VarChar ( 255 ) , 
	@asNouvVal	VarChar ( 255 ) , 
	@asChaine	VarChar ( 1000 ) ,
	@asSep		VarChar ( 1 )   
    )
RETURNS Varchar(1000)

AS

Begin

  Declare @iDeb Integer
  Declare @iFin Integer
  Declare @sVal VarChar ( 1000 )
  Declare @sVal1 VarChar ( 1000 )
  Declare @sVal2 VarChar ( 1000 )
  Declare @AltDebCleValide Integer
  Declare @AltFinCleValide Integer

  If @asChaine is null Set @asChaine= ''
  Set @asChaine = ltrim ( rtrim ( @asChaine ))

  If @asNouvVal is null Set @asNouvVal = ''
  Set @asNouvVal = ltrim ( rtrim ( @asNouvVal ))

  Set @iDeb = CharIndex ( @asCle + '=', @asChaine, 1 ) 
  Set @sVal = ''
  Set @AltDebCleValide = 0
  Set @AltFinCleValide = 0

  If @iDeb = 0 And Len (@asChaine ) > 0 
  	Begin 	
  		Set @asChaine = @asChaine + @asSep + @asCle + '='
 	End 
  Else
  	Begin 
	  If @iDeb = 0 And Len (@asChaine ) <= 0     
		Begin 	
			Set @asChaine = @asCle + '='
		End 
	End

  If @iDeb = 0 
  	Begin
	  	Set @iDeb = CharIndex ( @asCle + '=', @asChaine, 1 ) 
	End


  While @iDeb > 0 
   Begin
     If @iDeb = 1 
	Begin
	  Set @AltDebCleValide = 1
	End 

     If @iDeb > 1 
 	Begin
	  if Substring ( @asChaine, @iDeb - 1, 1 ) = @asSep
		Begin
			Set @AltDebCleValide = 1
		End 
	End 

     Set @iFin = CharIndex ( '=', @asChaine, @iDeb ) 
     If @iFin > 0 
	Begin 
		Set @AltFinCleValide = 1	
	End 

     -- Ce n'est pas une clé
     If @AltDebCleValide = 0 Or @AltFinCleValide = 0
	Begin
	        Set @iDeb = CharIndex ( @asCle + '=', @asChaine, @iDeb + 1 ) 

		If @iDeb = 0 And Len (@asChaine ) > 0 
		Begin 	
			Set @asChaine = @asChaine + @asSep + @asCle + '='
		End 
		Else
		Begin 
		  If @iDeb = 0 And Len (@asChaine ) <= 0     
			Begin 	
				Set @asChaine = @asCle + '='
			End 
		End

		If @iDeb = 0 
		Begin
			Set @iDeb = CharIndex ( @asCle + '=', @asChaine, 1 ) 
		End
	        
	End
     
     -- C'est bien une clé valide
     If @AltDebCleValide = 1 And @AltFinCleValide = 1
	Begin
	     Set @iDeb = @iFin + 1
	     Set @iFin = CharIndex ( @asSep, @asChaine, @iDeb ) - 1
	     if @iFin <= 0 Set @iFin = Len ( @asChaine )
	     
	     if @iFin > 0 
	      Begin
 	        Set @sVal1 = Left (@asChaine, @iDeb -1 ) -- Découpe du début jusqu'au "="
	        Set @sVal2 = Right (@asChaine, Len (@asChaine ) - @iFin ) -- Découpe de la fin jusqu'au ";"
		
		Set @sVal = @sVal1 + @asNouvVal + @sVal2 
		
		Set @iDeb = 0
	      End
	End
   End
   Return lTrim ( rTrim ( @sVal ))

End

Go



IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_MASQUER_CARTE' AND type = 'FN' )
        DROP function sysadm.FN_MASQUER_CARTE
Go

CREATE  function sysadm.FN_MASQUER_CARTE
--------------------------------------------------------------------------------------------
-- FN_MASQUER_CARTE FS le 12/02/2008 : Masque partiellement un n° de carte
--------------------------------------------------------------------------------------------
       ( @sIdCarte Varchar(16)
        )
RETURNS Varchar(16)

AS

Begin

  Return Left ( @sIdCarte, 9 ) + Replicate ( 'X', 4 ) + Right ( @sIdCarte, 2 )

End
Go




IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_IS_REG_ASSURE' AND type = 'FN' )
        DROP function sysadm.FN_IS_REG_ASSURE
Go

CREATE  function sysadm.FN_IS_REG_ASSURE
--------------------------------------------------------------------------------------------
-- FN_IS_REG_ASSURE FS le 24/06/2009 : Le dossier est-il clos réglé à l'assuré
--------------------------------------------------------------------------------------------
  ( @dcIdSin Decimal(7,0)
        )
RETURNS Char(1) --> O si reglé à l'assuré, N sinon

AS

Begin

	Declare @iNb  Integer
   Declare @sAlt Char(1)

	Set @sAlt = 'N'

	Select
		@iNb = Count(*)
	From 
		sysadm.reg_gti rg 
	inner join sysadm.inter i on rg.id_sin = i.id_sin and rg.id_i = i.id_i
	where 
	  rg.id_gti   >0    And 
	  i.cod_inter = 'A' And
     rg.id_sin   = @dcIdSin 


	If @iNb > 0 Set @sAlt = 'O'

	Return @sAlt

End

Go

--------------------------------------------------------------------
--
-- Procédure            : FN_TAG
-- Auteur               : FABRY JF
-- Date                 : 19/08/2009
-- Libellé              : Filtre les caractères à gauche d'une chaine
--                        
--			Select sysadm.FN_TAG ( null, getdate() )
--			Select sysadm.FN_TAG ( 'MON_PROJET', getdate() )
-- Références           : 
--
-- Arguments            : @sVal : Préfixe de du TAG (au besoin)
--                        @dtGetDate : GetDate ()
--                        
-- Retour               : La chaine filtrée
--	                        
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_TAG' AND type = 'FN' )
        DROP function sysadm.FN_TAG
Go
  
CREATE  function sysadm.FN_TAG  (  
        @aiCas Integer,  
        @sVal Varchar(200),  
		 @dtGetDate DateTime )  
RETURNS Varchar(200)  
  
AS  
  
Begin  
  
  Declare @sTag VarChar ( 100 )  
  
  If @sVal is null Set @sVal = ''  
  
  If @aiCas = 1   
    Begin  
    
    If sysadm.FN_TRIM ( @sVal ) <> '' Set @sVal = '[' + @sVal + '].'  
  
    Select @sTag = Convert ( Varchar ( 100 ), @dtGetDate, 126 )  
      
    Set @sTag =  Left ( @sTag, 4 ) +   
      SubString ( @sTag, 6,2 ) +  
      SubString ( @sTag, 9,2 ) +  
      SubString ( @sTag, 12,2 ) +      
      SubString ( @sTag, 15,2 ) +    
      SubString ( @sTag, 18,2 ) +      
      SubString ( @sTag, 21,3 )   
  
    Set @sVal = @sVal + '[' + @sTag + ']'  
 End  
   
  If @aiCas = 2   
    Begin  
    Select @sTag = Convert ( Varchar ( 100 ), @dtGetDate, 126 )  
      
    Set @sTag =  Left ( @sTag, 4 ) +   
      SubString ( @sTag, 6,2 ) +  
      SubString ( @sTag, 9,2 ) +  
      SubString ( @sTag, 12,2 ) +      
      SubString ( @sTag, 15,2 ) +    
      SubString ( @sTag, 18,2 ) +      
      SubString ( @sTag, 21,3 )   
      
      Set @sVal = '[SQL][PROD][LSTAGF005001][SIMPA2_PRO]' + @sTag  
    End    

  If @aiCas = 3   
    Begin  
    Select @sTag = Convert ( Varchar ( 100 ), @dtGetDate, 126 )  
      
    Set @sTag =  Left ( @sTag, 4 ) +   
      SubString ( @sTag, 6,2 ) +  
      SubString ( @sTag, 9,2 ) +  
      SubString ( @sTag, 12,2 ) +      
      SubString ( @sTag, 15,2 ) +    
      SubString ( @sTag, 18,2 ) +      
      SubString ( @sTag, 21,3 )   

      Set @sVal = '[' + @sTag + '][JFF][' + @sVal + ']'
    End    
   
  If @aiCas = 4   
    Begin  
    Select @sTag = Convert ( Varchar ( 100 ), @dtGetDate, 126 )  
      
    Set @sTag =  Left ( @sTag, 4 ) +   
      SubString ( @sTag, 6,2 ) +  
      SubString ( @sTag, 9,2 ) +  
      SubString ( @sTag, 12,2 ) +      
      SubString ( @sTag, 15,2 ) +    
      SubString ( @sTag, 18,2 ) +      
      SubString ( @sTag, 21,3 )   

      Set @sVal = @sVal + '_ISM_' + @sTag + '_MAJ_SQL'
    End    

  Return @sVal   
End  
  

Go
	
-- JFF      12/02/2016   [PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_DOS_SUIVI_PAR' AND type = 'FN' )
        DROP function sysadm.FN_GET_DOS_SUIVI_PAR
Go




CREATE  function sysadm.FN_GET_DOS_SUIVI_PAR  ( @iIdSin Integer )
RETURNS Varchar(4)

AS
  --------------------------------------------------------------------------------------------------
  -- FN_GET_DOS_SUIVI_PAR  FS  le 24/09/2009 : Obtention du responsable du suivi de dossier
  -- JFF      12/02/2016   [PI062]
  --------------------------------------------------------------------------------------------------
Begin

   Declare @sIdOperSuivi  VarChar(4) -- Opérateur de Suivi
   Declare @sTypeBase     Varchar(3)
        
   Set @sTypeBase    = master.dbo.SPB_FN_TYPEBASE( db_id() ) 
   Set @sIdOperSuivi = Convert ( varchar(4), null )

/*----------------------------------------------------------------------------*/
/* (1) Recherche de l'opérateur de suivi dans SIMPA2                          */
/*----------------------------------------------------------------------------*/

   Select @sIdOperSuivi = dos_suivi_par From sysadm.routage Where id_sin = Convert ( decimal(10,0), @iIdSin ) -- [PI062]

/*----------------------------------------------------------------------------*/
/* (2) A défaut rechercher dans Sherpa de l'opérateur du dernier contact      */
/*----------------------------------------------------------------------------*/

   If @sIdOperSuivi is null And @sTypeBase = 'PRO'
      Begin -- Recherche sur Sherpa Production

           Select top 1 @sIdOperSuivi=ct.maj_par
            From 
                 SHERPA_PRO.sysadm.contact ct
                  inner join SHERPA_PRO.sysadm.sinistre s on ct.id_cli = s.id_cli
            Where
               s.id_appli = 2   And
               s.id_sin   = @iIdSin   And
               ct.id_typ_contact in ( 2,6,1 ) and
               
               /* Recherche des contacts : Exclusion des trigrammes automatique */
                ct.maj_par not in ( 'AUTO', 'MTQ' ) And
                ct.maj_par not in 
               /* Exclusion des trigrammes de la facturation */
               ( select id_oper from sysadm.autorisation where id_nat_oper = 250 )
            Order by
               ct.maj_le desc

      End  -- Recherche sur Sherpa Production


   If @sIdOperSuivi is null And @sTypeBase <> 'PRO'

      Begin -- Recherche sur Sherpa Simulation

           Select top 1 @sIdOperSuivi=ct.maj_par
            From 
                 SHERPA_SIM.sysadm.contact ct
                  inner join SHERPA_SIM.sysadm.sinistre s on ct.id_cli = s.id_cli
            Where
               s.id_appli = 2   And
               s.id_sin   = @iIdSin   And
               ct.id_typ_contact in ( 2,6,1 ) and
               
               /* Recherche des contacts : Exclusion des trigrammes automatique */
                ct.maj_par not in ( 'AUTO', 'MTQ' ) And
                ct.maj_par not in 
               /* Exclusion des trigrammes de la facturation */
               ( select id_oper from sysadm.autorisation where id_nat_oper = 250 )
            Order by
               ct.maj_le desc

      End -- Recherche sur Sherpa Simulation


  Return @sIdOperSuivi

End
Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_GET_LIB_POLICE
-- Auteur               :       Fabien Pinon
-- Date                 :       08/10/2009
-- Libellé              :
-- Commentaires         :        [EXPANSION5.LIB_POLICE]
-- Références           :       
--
-- Arguments            :       @dcIdProd 	Decimal (7,0), 	-- identifiant de produit
--								@dcIdGti 	Decimal (7,0), 	-- identifiant de garantie
--								@dcIdRev 	Decimal (7,0), 	-- identifiant de révision
--								@iIdBoutique	Int		-- identifiant de boutique
--
-- Retourne             :  le libellé de police
-- #1   JFF   20/11/2009   [POLICE_PARTICULIERE]
-- #2	FPI	24/11/2009	[POLICE_PARTICULIERE] Correction id_gti pour les relances
-- #3	FPI	06/01/2010	[EXP5] Correction : dans div_sin, la boutique est un car.
-- #4	FPI	22/01/2010	Ajout du cas de l'id_rev=-1
-- #5	FPI	16/06/2010	[DCMP100427] Gestion CRCA
-- JFF      12/02/2016   [PI062]
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_LIB_POLICE' AND type = 'FN' )
        DROP function sysadm.FN_GET_LIB_POLICE
Go

CREATE function sysadm.FN_GET_LIB_POLICE
	(
			@dcIdSin 	Decimal (10,0), 	-- identifiant de sinistre -- [PI062]
			@dcIdProd 	Decimal (7,0),
			@dcIdRev 	Decimal (7,0),
			@dcIdGti 	Decimal (7,0)
	)
RETURNS varchar(70)

AS

Begin
	Declare @sLibPolice varchar(70)
	Declare @sLibBoutique varchar(35)
	Declare @sValCarDP124 varchar(255)
	Declare	@sValConcat char(1)
	Declare @sRadPol Varchar ( 50 ) -- #1 [POLICE_PARTICULIERE]
	Declare @nbRows	int
	Declare @dcIdEts Decimal ( 7 ) -- #1 [POLICE_PARTICULIERE]
	Declare @sIdAdh VarChar ( 30 ) -- #1 [POLICE_PARTICULIERE]
	Declare @lLongMax Integer -- #1 [POLICE_PARTICULIERE]
	Declare @sIdContratAbonne VarChar ( 50 ) -- #1 [POLICE_PARTICULIERE]
	Declare @dcIdGti1er 	Decimal (7,0)
	-- Initialisations

	Set @sValCarDP124=''
	Set @sLibPolice=''
	Set @sLibBoutique=''
	Set @sValConcat=''

	-- #4
	If @dcIdRev = -1 
	 Begin
		Select @sLibPolice = 'HORS AVENANT-NON COUVERT'
		Return @sLibPolice
	 End
	 
	-- #2 Correction id_gti si non renseigné 
	Set @dcIdGti1er = @dcIdGti
	If @dcIdGti = -1 
	Begin
		Select top 1 @dcIdGti1er=id_gti from sysadm.gar_sin where id_sin = @dcIdSin
		If @@RowCount = 0
		Begin
			Select top 1 @dcIdGti1er=id_gti from sysadm.w_gar_sin where id_sin = @dcIdSin
		End
	End 

	-- #3 Option déclencement particulier
	Select @sValCarDP124=val_car From sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 124
	Select @nbRows=@@RowCount
	
	-- DP non paramétré, on regarde dans la table des polices
	If @nbRows <= 0
	Begin
		Select @sLibPolice = rtrim ( p.lib_police )
		From sysadm.garantie g, sysadm.police p
		Where 	g.id_prod = @dcIdProd 	and
			g.id_gti = @dcIdGti1er 	and
			g.id_rev = @dcIdRev	and
			g.id_police = p.id_police

		Return @sLibPolice
	End
	-- Fin #3
	
	-- Récupération du det_pro EXPANSION 5		
	--Select @sValCarDP124=val_car From sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 124
	--Select @nbRows=@@RowCount
	Select @nbRows=Count(*) From sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 130	-- #3
	
	If @nbRows > 0 
	Begin
		-- DP paramétré, on regarde dans la table des boutiques
		Select @sValConcat=sysadm.FN_CLE_VAL('ALT_CONCAT',@sValCarDP124,';')

		
		-- Récupération du lib_police dans la table boutique
		Select @sLibBoutique=b.lib_police
		From sysadm.w_div_sin wds, sysadm.boutique b
		Where 	wds.id_sin = @dcIdSin	And
			wds.nom_zone = 'id_boutique_adh' and
			b.id_boutique = convert(int,wds.val_car) And -- #3
			b.id_prod = @dcIdProd 

		Select @nbRows=@@RowCount

		If @nbRows = 0 
		Begin
			Select @sLibBoutique=b.lib_police
			From sysadm.div_sin ds, sysadm.boutique b
			Where 	ds.id_sin = @dcIdSin	And
				ds.nom_zone = 'id_boutique_adh' and
				b.id_boutique = ds.val_nbre And 
				b.id_prod = @dcIdProd 
			Select @nbRows=@@RowCount

		End

		If @nbRows = 0 Return '' -- Boutique inexistante ou zone 'id_boutique_adh' non renseignée

		If @sLibBoutique is null Set @sLibBoutique=''

		-- Création du libellé de police
		If @sValConcat='N' Set @sLibPolice=@sLibBoutique
		Else
		Begin
			-- Cas de la concaténation
			Select @sLibPolice=p.lib_police
			From sysadm.garantie g, sysadm.police p
			Where 	g.id_prod = @dcIdProd 	and
				g.id_gti = @dcIdGti1er 	and
				g.id_rev = @dcIdRev	and
				g.id_police = p.id_police
	
			If @sLibPolice is null Set @sLibPolice=''
			
			Set @sLibPolice = Rtrim(@sLibPolice) + RTrim(@sLibBoutique)
		End
		
		Return @sLibPolice -- #1 [POLICE_PARTICULIERE]
	End

	-- #1 [POLICE_PARTICULIERE]
	-- Récupération du det_pro AQUAZEN_LDE_NON_CLIENT
	--Select @sValCarDP124=val_car From sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 127
	--Select @nbRows=@@RowCount
	Select @nbRows=Count(*) From sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 127	-- #3
	
	If @nbRows > 0 
	Begin
		Set @lLongMax = 23
	
		Select  @dcIdEts = s.id_ets,
			@sIdAdh = lTrim ( rtrim ( s.id_adh ) )
		From sysadm.sinistre s
		Where s.id_sin = @dcIdSin
		
		If @@RowCount <> 1 
		Begin
			Select 	@dcIdEts = s.id_ets,
				@sIdAdh = lTrim ( rtrim ( s.id_adh ) )
			From sysadm.w_sin s
			Where s.id_sin = @dcIdSin
		End 
		
		If @dcIdEts is null return @sLibPolice
		
		-- Cas de déterminsation propre à AQUAZEN
		If @dcIdEts = 2001 
		Begin
			Select @sRadPol = sysadm.FN_CLE_VAL('RAD_POL_ETS_2001',@sValCarDP124,';')		
		End 

		If @dcIdEts = 2002 
		Begin
			Select @sRadPol = sysadm.FN_CLE_VAL('RAD_POL_ETS_2002',@sValCarDP124,';')				
		End 
		
		Set @sIdAdh = Replicate ( '0', @lLongMax - ( Len ( @sRadPol ) + Len ( @sIdAdh ) ) ) + @sIdAdh
		Set @sLibPolice = @sRadPol + @sIdAdh
		
		
		Return @sLibPolice
	End
	
	-- Récupération du det_pro THELEM
	--Select @sValCarDP124 = val_car From sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 128
	--Select @nbRows=@@RowCount
	Select @nbRows=Count(*) From sysadm.det_pro where id_prod = @dcIdProd and id_code_dp in (128,138)	-- #3 -- #5 [DCMP100427] ajout 138
	
	If @nbRows > 0 
	Begin
	
		Select  @sIdContratAbonne = s.id_contrat_abonne
		From sysadm.sinistre s
		Where s.id_sin = @dcIdSin
		
		If @@RowCount <> 1 
		Begin
			Select 	@sIdContratAbonne = lTrim ( rTrim ( s.id_contrat_abonne ))
			From sysadm.w_sin s
			Where s.id_sin = @dcIdSin
		End 
		
		If @sIdContratAbonne is null return @sLibPolice
		
		-- Cas de détermination propre à Thelem
		-- #3 Le radical est repris de la table police
		--Select @sRadPol = sysadm.FN_CLE_VAL('RAD_POL',@sValCarDP124,';')		

		Select @sValConcat=sysadm.FN_CLE_VAL('ALT_CONCAT',@sValCarDP124,';')
		Set @sRadPol = ''
	
		If @sValConcat='O'
		Begin
			Select @sRadPol=p.lib_police
			From sysadm.garantie g, sysadm.police p
			Where 	g.id_prod = @dcIdProd 	and
				g.id_gti = @dcIdGti1er 	and
				g.id_rev = @dcIdRev	and
				g.id_police = p.id_police
	
			If @sRadPol is null Set @sRadPol=''
		End
		-- Fin #3
		
		Set @sLibPolice = RTrim(@sRadPol) + @sIdContratAbonne
	
		return @sLibPolice 	
	End	
	-- #1 [POLICE_PARTICULIERE]

	/*-- #3 Traitement mis au début de la PS
	-- DP non paramétré, on regarde dans la table des polices
	Select @sLibPolice = rtrim ( p.lib_police )
	From sysadm.garantie g, sysadm.police p
	Where 	g.id_prod = @dcIdProd 	and
		g.id_gti = @dcIdGti1er 	and
		g.id_rev = @dcIdRev	and
		g.id_police = p.id_police
	*/
	
	Return @sLibPolice
End
Go



IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_LIB_POLICE_V01' AND type = 'FN' )
        DROP function sysadm.FN_GET_LIB_POLICE_V01
Go


CREATE  function sysadm.FN_GET_LIB_POLICE_V01
--------------------------------------------------------------------------------------------
-- SBA - 21/07/2010 - [PC202] - Correction de la fonction FN_GET_LIB_POLICE_V01
-- FPI - 20/06/2012	- [PC683] - Modif lecture DP 124 pour Aquazen
-- FPI - 28/06/2012	- [ITSM119609] Correction jointure police-gti
-- JFF      12/02/2016   [PI062]
--------------------------------------------------------------------------------------------
	(
			@dcIdSin 	Decimal (10,0), 	-- identifiant de sinistre -- [PI062]
			@dcIdProd 	Decimal (7,0),
			@dcIdRev 	Decimal (7,0),
			@dcIdGti 	Decimal (7,0),
			@dcIdPolice Decimal (7,0)
	)
RETURNS varchar(70)

AS

Begin
	Declare @sLibPolice varchar(70)
	Declare @sLibBoutique varchar(35)
	Declare @sValCarDP124 varchar(255)
	Declare	@sValConcat char(1)
	Declare @sRadPol Varchar ( 50 ) -- #1 [POLICE_PARTICULIERE]
	Declare @nbRows	int
	Declare @dcIdEts Decimal ( 7 ) -- #1 [POLICE_PARTICULIERE]
	Declare @sIdAdh VarChar ( 30 ) -- #1 [POLICE_PARTICULIERE]
	Declare @lLongMax Integer -- #1 [POLICE_PARTICULIERE]
	Declare @sIdContratAbonne VarChar ( 50 ) -- #1 [POLICE_PARTICULIERE]
	Declare @dcIdGti1er 	Decimal (7,0)
	-- Initialisations

	Set @sValCarDP124=''
	Set @sLibPolice=''
	Set @sLibBoutique=''
	Set @sValConcat=''

	-- #4
	If @dcIdRev = -1 
	 Begin
		/*
		Select @sLibPolice = 'HORS AVENANT-NON COUVERT'
		Return @sLibPolice
		*/
		-- Return IsNull ( nullif ( rTrim ( sysadm.FN_LIB_POLICE (@dcIdSin) ), '' ), 'IMPOSSIBLE DE DETERMINER LA POLICE' )
		
		If @dcIdGti > 0 And @dcIdGti is not null
			Begin
				Select @dcIdRev = MAX (id_rev )
				From   sysadm.garantie g
				Where  g.id_prod = @dcIdProd
				and    g.id_gti = @dcIdGti
			End		
		Else
			Begin
				Select @dcIdRev = MAX (id_rev )
				From   sysadm.garantie g
				Where  g.id_prod = @dcIdProd
			End
	 End
	 	 
	-- #2 Correction id_gti si non renseigné 
	Set @dcIdGti1er = @dcIdGti
	If @dcIdGti = -1 
	Begin
		Select top 1 @dcIdGti1er=id_gti from sysadm.gar_sin where id_sin = @dcIdSin
		If @@RowCount = 0
		Begin
			Select top 1 @dcIdGti1er=id_gti from sysadm.w_gar_sin where id_sin = @dcIdSin
		End
		If @@RowCount = 0 and @dcIdRev > 0
		Begin
			Select top 1 @dcIdGti1er=id_gti from sysadm.garantie where id_prod = @dcIdProd and id_rev = @dcIdRev
		End

		If @@RowCount = 0 
		Begin
			Select top 1 @dcIdGti1er=id_gti from sysadm.code_garantie where id_prod = @dcIdProd
		End
	
	End 

	-- #3 Option déclencement particulier
	Select @sValCarDP124=val_car From sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 124
	Select @nbRows=@@RowCount
	
	-- DP non paramétré, on regarde dans la table des polices
	If @nbRows <= 0
	Begin
		Select @sLibPolice = rtrim ( p.lib_police )
		From sysadm.garantie g, sysadm.police p
		Where 	g.id_prod = @dcIdProd 	and
			g.id_gti = @dcIdGti1er 	and
			g.id_rev = @dcIdRev	and
			g.id_police = p.id_police and 
			(@dcIdPolice is null or p.id_police=@dcIdPolice)	-- [PC202] - [ITSM119609]

		Return @sLibPolice
	End
	-- Fin #3
	
	-- Récupération du det_pro EXPANSION 5		
	--Select @sValCarDP124=val_car From sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 124
	--Select @nbRows=@@RowCount
	Select @nbRows=Count(*) From sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 130	-- #3
	
	If @nbRows > 0 
	Begin
		-- DP paramétré, on regarde dans la table des boutiques
		Select @sValConcat=sysadm.FN_CLE_VAL('ALT_CONCAT',@sValCarDP124,';')

		
		-- Récupération du lib_police dans la table boutique
		Select @sLibBoutique=b.lib_police
		From sysadm.w_div_sin wds, sysadm.boutique b
		Where 	wds.id_sin = @dcIdSin	And
			wds.nom_zone = 'id_boutique_adh' and
			b.id_boutique = convert(int,wds.val_car) And -- #3
			b.id_prod = @dcIdProd 

		Select @nbRows=@@RowCount

		If @nbRows = 0 
		Begin
			Select @sLibBoutique=b.lib_police
			From sysadm.div_sin ds, sysadm.boutique b
			Where 	ds.id_sin = @dcIdSin	And
				ds.nom_zone = 'id_boutique_adh' and
				b.id_boutique = ds.val_nbre And 
				b.id_prod = @dcIdProd 
			Select @nbRows=@@RowCount

		End

		If @nbRows = 0 Return '' -- Boutique inexistante ou zone 'id_boutique_adh' non renseignée

		If @sLibBoutique is null Set @sLibBoutique=''

		-- Création du libellé de police
		If @sValConcat='N' Set @sLibPolice=@sLibBoutique
		Else
		Begin
			-- Cas de la concaténation
			Select @sLibPolice=p.lib_police
			From sysadm.garantie g, sysadm.police p
			Where 	g.id_prod = @dcIdProd 	and
				g.id_gti = @dcIdGti1er 	and
				g.id_rev = @dcIdRev	and
				g.id_police = p.id_police and 
			   (@dcIdPolice is null or p.id_police=@dcIdPolice)	-- [PC202] - [ITSM119609]
	
			If @sLibPolice is null Set @sLibPolice=''
			
			Set @sLibPolice = Rtrim(@sLibPolice) + RTrim(@sLibBoutique)
		End
		
		Return @sLibPolice -- #1 [POLICE_PARTICULIERE]
	End

	-- #1 [POLICE_PARTICULIERE]
	-- Récupération du det_pro AQUAZEN_LDE_NON_CLIENT
	--Select @sValCarDP124=val_car From sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 127
	--Select @nbRows=@@RowCount
	Select @nbRows=Count(*) From sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 127	-- #3
	
	If @nbRows > 0 
	Begin
		Set @lLongMax = 23
	
		Select  @dcIdEts = s.id_ets,
			@sIdAdh = lTrim ( rtrim ( s.id_adh ) )
		From sysadm.sinistre s
		Where s.id_sin = @dcIdSin
		
		If @@RowCount <> 1 
		Begin
			Select 	@dcIdEts = s.id_ets,
				@sIdAdh = lTrim ( rtrim ( s.id_adh ) )
			From sysadm.w_sin s
			Where s.id_sin = @dcIdSin
		End 
		
		If @dcIdEts is null return @sLibPolice
		
		-- Cas de déterminsation propre à AQUAZEN
		/*If @dcIdEts = 2001 
		Begin
			Select @sRadPol = sysadm.FN_CLE_VAL('RAD_POL_ETS_2001',@sValCarDP124,';')		
		End 

		If @dcIdEts = 2002 
		Begin
			Select @sRadPol = sysadm.FN_CLE_VAL('RAD_POL_ETS_2002',@sValCarDP124,';')				
		End */
		
		Select @sRadPol = sysadm.FN_CLE_VAL('RAD_POL_ETS_' + convert(varchar(5),@dcIdEts) ,@sValCarDP124,';') -- PC683
		
		Set @sIdAdh = Replicate ( '0', @lLongMax - ( Len ( @sRadPol ) + Len ( @sIdAdh ) ) ) + @sIdAdh
		Set @sLibPolice = @sRadPol + @sIdAdh
		
		
		Return @sLibPolice
	End
	
	-- Récupération du det_pro THELEM
	--Select @sValCarDP124 = val_car From sysadm.det_pro where id_prod = @dcIdProd and id_code_dp = 128
	--Select @nbRows=@@RowCount
	Select @nbRows=Count(*) From sysadm.det_pro where id_prod = @dcIdProd and id_code_dp in (128,138)	-- #3 -- #5 [DCMP100427] ajout 138
	
	If @nbRows > 0 
	Begin
	
		Select  @sIdContratAbonne = s.id_contrat_abonne
		From sysadm.sinistre s
		Where s.id_sin = @dcIdSin
		
		If @@RowCount <> 1 
		Begin
			Select 	@sIdContratAbonne = lTrim ( rTrim ( s.id_contrat_abonne ))
			From sysadm.w_sin s
			Where s.id_sin = @dcIdSin
		End 
		
		If @sIdContratAbonne is null return @sLibPolice
		
		-- Cas de détermination propre à Thelem
		-- #3 Le radical est repris de la table police
		--Select @sRadPol = sysadm.FN_CLE_VAL('RAD_POL',@sValCarDP124,';')		

		Select @sValConcat=sysadm.FN_CLE_VAL('ALT_CONCAT',@sValCarDP124,';')
		Set @sRadPol = ''
	
		If @sValConcat='O'
		Begin
			Select @sRadPol=p.lib_police
			From sysadm.garantie g, sysadm.police p
			Where 	g.id_prod = @dcIdProd 	and
				g.id_gti = @dcIdGti1er 	and
				g.id_rev = @dcIdRev	and
				g.id_police = p.id_police and 
				(@dcIdPolice is null or p.id_police=@dcIdPolice)	-- [PC202] - [ITSM119609]
	
			If @sRadPol is null Set @sRadPol=''
		End
		-- Fin #3
		
		Set @sLibPolice = RTrim(@sRadPol) + @sIdContratAbonne
	
		return @sLibPolice 	
	End	
	-- #1 [POLICE_PARTICULIERE]

	/*-- #3 Traitement mis au début de la PS
	-- DP non paramétré, on regarde dans la table des polices
	Select @sLibPolice = rtrim ( p.lib_police )
	From sysadm.garantie g, sysadm.police p
	Where 	g.id_prod = @dcIdProd 	and
		g.id_gti = @dcIdGti1er 	and
		g.id_rev = @dcIdRev	and
		g.id_police = p.id_police
	*/
	
	Return @sLibPolice
End
GO




--------------------------------------------------------------------
--
-- Fonction             :       PS_S01_LIB_POLICE_V01
-- Auteur               :       Fabry JF
-- Date                 :       20/11/2009
-- Libellé              :
-- Commentaires         :       [POLICE_PARTICULIERE] 	
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :  le libellé de police
--------------------------------------------------------------------
-- FPI - V01 - [PC683] Utilisation de FN_GET_LIB_POLICE_V01 + ajout der param
-- JFF      12/02/2016   [PI062]
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_LIB_POLICE_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_S01_LIB_POLICE_V01
Go

CREATE PROCEDURE sysadm.PS_S01_LIB_POLICE_V01
	@dcIdSin 	Decimal (10,0), -- [PI062]
	@dcIdProd 	Decimal (7,0),
	@dcIdRev 	Decimal (7,0),
	@dcIdGti 	Decimal (7,0),
	@dcIdPolice Decimal (7,0),
	@sLibPolice 	VarChar ( 35 ) OUTPUT
As
  select @sLibPolice = sysadm.FN_GET_LIB_POLICE_V01(@dcIdSin,@dcIdProd,@dcIdRev,@dcIdGti,@dcIdPolice)

Go

--------------------------------------------------------------------
--
-- Fonction             :       DW_S01_LIB_POLICE
-- Auteur               :       Fabien Pinon
-- Date                 :       28/10/2009
-- Libellé              :
-- Commentaires         :       [EXPANSION5.LIB_POLICE]
-- Références           :       
--
-- Arguments            :       @dcIdProd 	Decimal (7,0), 	-- identifiant de produit
--								@dcIdGti 	Decimal (7,0), 	-- identifiant de garantie
--								@dcIdRev 	Decimal (7,0), 	-- identifiant de révision
--								@iIdBoutique	Int		-- identifiant de boutique
--
-- Retourne             :  le libellé de police
--------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_LIB_POLICE' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S01_LIB_POLICE
Go

-- Création proc DW_S01_LIB_POLICE
CREATE PROCEDURE sysadm.DW_S01_LIB_POLICE
	@dcIdSin 	Decimal (10,0), 	-- identifiant de sinistre -- [PI062]
	@dcIdProd 	Decimal (7,0),
	@dcIdRev 	Decimal (7,0),
	@dcIdGti 	Decimal (7,0)
As
  select @dcIdSin as id_sin,
	@dcIdProd as id_prod,
	@dcIdRev as id_rev,
	@dcIdGti as id_gti,
	sysadm.FN_GET_LIB_POLICE(@dcIdSin,@dcIdProd,@dcIdRev,@dcIdGti) as lib_police

GO


--  JFF		12/02/2016		[PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_LIB_POLICE_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S01_LIB_POLICE_V01
Go

CREATE    PROCEDURE sysadm.DW_S01_LIB_POLICE_V01
--------------------------------------------------------------------------------------------
-- SBA - 21/07/2010 - [PC202] - Ajout de l'id_police pour correction de la fonction FN_GET_LIB_POLICE (versionée en FN_GET_LIB_POLICE_V01)
--------------------------------------------------------------------------------------------
	@dcIdSin 	Decimal (10,0), 	-- identifiant de sinistre -- [PI062]
	@dcIdProd 	Decimal (7,0),
	@dcIdRev 	Decimal (7,0),
	@dcIdGti 	Decimal (7,0),
	@dcIdPolice Decimal (7,0)
As
  select @dcIdSin as id_sin,
	@dcIdProd as id_prod,
	@dcIdRev as id_rev,
	@dcIdGti as id_gti,
	@dcIdPolice as id_police,
	sysadm.FN_GET_LIB_POLICE_V01(@dcIdSin,@dcIdProd,@dcIdRev,@dcIdGti,@dcIdPolice) as lib_police

GO


--------------------------------------------------------------------------------------------
-- PS_CORRIGE_CPT_VALIDE	  FPI	le 19/10/2008 : Correction de la valeur de CPT_valide dans les différentes tables
-- JFF      12/02/2016   [PI062]
-- JFF      22/05/2019   [InsertionRoutage]
--------------------------------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CORRIGE_CPT_VALIDE' AND type = 'P' )
        DROP Procedure sysadm.PS_CORRIGE_CPT_VALIDE
Go


CREATE PROCEDURE sysadm.PS_CORRIGE_CPT_VALIDE 
	@dcIdSin	Decimal(10,0)  -- [PI062]
As

Declare @dcCodEtatSin Decimal ( 7 )
Declare @dcIdCorb Decimal ( 3 )
Declare @dtCreeLeDos DateTime

-- [InsertionRoutage]
Print '--> Insertion dans routage si absence'
	If Not Exists ( 
			Select Top 1 1 
			From sysadm.routage r
			Where r.id_sin = @dcIdSin
		)
		Begin
			Select @dcIdCorb = p.id_corb,
				   @dtCreeLeDos = ws.cree_le
			From   sysadm.w_sin ws,
				   sysadm.produit p
			Where  ws.id_sin = @dcIdSin
			And    p.id_prod = ws.id_prod

			Insert into sysadm.routage values  ( @dcIdSin, 'N', @dcIdCorb, 'X', 'DEC', 'N', @dtCreeLeDos , @dtCreeLeDos , 'WEB', null, null, null, null,null )
			-- LA maj du Code travail DEC, CAS, CPL se fait à la fin.
		End 

Print '--> Redressement de w_inter'

update sysadm.w_inter_encrypt 
set cpt_valide=1 
from sysadm.inter_encrypt 
where w_inter_encrypt .id_sin=@dcIdSin
  and w_inter_encrypt .cpt_valide=0
  and inter_encrypt .id_sin=w_inter_encrypt .id_sin
  and inter_encrypt .id_i=w_inter_encrypt .id_i

Print '--> Redressement de w_detail'
update sysadm.w_detail 
set cpt_valide=1 
from sysadm.detail
where w_detail.id_sin=@dcIdSin
  and w_detail.cpt_valide=0
  And detail.id_sin=w_detail.id_sin
  and w_detail.id_gti = detail.id_gti
  and w_detail.id_detail = detail.id_detail

Print '--> Redressement de w_div_sin'
update sysadm.w_div_sin 
set cpt_valide=1 
from sysadm.div_sin
where w_div_sin.id_sin=@dcIdSin
  and w_div_sin.cpt_valide=0
  And w_div_sin.id_sin = div_sin.id_sin
  and w_div_sin.nom_zone = div_sin.nom_zone

Print '--> Redressement de w_div_det'
update sysadm.w_div_det 
set cpt_valide=1 
from sysadm.div_det
where w_div_det.id_sin=@dcIdSin
  and w_div_det.cpt_valide=0
  And w_div_det.id_sin = div_det.id_sin
  and w_div_det.id_gti = div_det.id_gti
  and w_div_det.id_detail = div_det.id_detail
  and w_div_det.nom_zone = div_det.nom_zone


Print '--> Redressement de w_commande'
update sysadm.w_commande 
set cpt_valide=1 
from sysadm.commande
where w_commande.id_sin=@dcIdSin
  and w_commande.cpt_valide=0
  And w_commande.id_sin = commande.id_sin
  and w_commande.id_seq = commande.id_seq

Print '--> Redressement de w_gar_sin'
update sysadm.w_gar_sin 
set cpt_valide=1 
from sysadm.gar_sin
where w_gar_sin.id_sin=@dcIdSin
  and w_gar_sin.cpt_valide=0
  And w_gar_sin.id_sin = gar_sin.id_sin
  and w_gar_sin.id_gti = gar_sin.id_gti

Print '--> Redressement de w_sin'
update sysadm.w_sin 
set cpt_valide=1 
from sysadm.sinistre
where w_sin.id_sin=@dcIdSin
and sinistre.id_sin = w_sin.id_sin
and w_sin.cpt_valide=0

Print '--> Redressement de w_sin (id_ordre)'
update sysadm.w_sin 
set id_ordre=sinistre.id_ordre 
from sysadm.sinistre
where w_sin.id_sin=@dcIdSin
and sinistre.id_sin = w_sin.id_sin

-- à 0
update sysadm.w_inter_encrypt  
set cpt_valide=0
where w_inter_encrypt .id_sin=@dcIdSin
  and w_inter_encrypt .cpt_valide > 0
  And Not exists ( 
		Select Top 1 1
		From sysadm.inter_encrypt  i
		Where i.id_sin = w_inter_encrypt .id_sin
		And   i.id_i = w_inter_encrypt .id_i
	  )

Print '--> Redressement de w_detail'
update sysadm.w_detail 
set cpt_valide=0
where w_detail.id_sin=@dcIdSin
  and w_detail.cpt_valide > 0
  And Not exists ( 
		Select Top 1 1
		From sysadm.detail d
		Where d.id_sin=w_detail.id_sin
		and d.id_gti = w_detail.id_gti
		and d.id_detail = w_detail.id_detail
	  )

Print '--> Redressement de w_div_sin'
update sysadm.w_div_sin 
set cpt_valide=0 
where w_div_sin.id_sin=@dcIdSin
  and w_div_sin.cpt_valide > 0
  And Not exists ( 
		Select Top 1 1
		From sysadm.div_sin ds	
		Where ds.id_sin = w_div_sin.id_sin
		and ds.nom_zone = w_div_sin.nom_zone
	  )

Print '--> Redressement de w_div_det'
update sysadm.w_div_det 
set cpt_valide=0
where w_div_det.id_sin=@dcIdSin
  and w_div_det.cpt_valide > 0
  And Not exists ( 
		Select Top 1 1
		From sysadm.div_det dd	
		where dd.id_sin = w_div_det.id_sin
		  and dd.id_gti = w_div_det.id_gti
		  and dd.id_detail = w_div_det.id_detail
		  and dd.nom_zone = w_div_det.nom_zone
		)

Print '--> Redressement de w_commande'
update sysadm.w_commande 
set cpt_valide=0 
where w_commande.id_sin=@dcIdSin
  and w_commande.cpt_valide > 0 
  And Not exists ( 
		Select Top 1 1
		From sysadm.commande c	
		Where c.id_sin = w_commande.id_sin
		and c.id_seq = w_commande.id_seq
	  )

Print '--> Redressement de w_gar_sin'
update sysadm.w_gar_sin 
set cpt_valide=0 
where w_gar_sin.id_sin=@dcIdSin
  and w_gar_sin.cpt_valide > 0
  And Not exists ( 
		Select Top 1 1
		From sysadm.gar_sin g	
		Where g.id_sin = w_gar_sin.id_sin
		and   g.id_gti = w_gar_sin.id_gti
	)

Print '--> Redressement de w_sin'
update sysadm.w_sin 
set cpt_valide=0
where w_sin.id_sin=@dcIdSin
and   w_sin.cpt_valide > 0
  And Not exists ( 
		Select Top 1 1
		From sysadm.sinistre s	
		where s.id_sin = w_sin.id_sin
		)

Print '--> Redressement de routage'
Select @dcCodEtatSin = s.cod_etat
From   sysadm.sinistre s
Where  s.id_sin = @dcIdSin

If @@RowCount <= 0 
  Begin 
	Update sysadm.routage
	Set cod_travail = 'DEC'
	Where id_sin = @dcIdSin
  End 
Else 
  Begin
	If @dcCodEtatSin in ( 200, 900, 600 )
	  Begin
		Update sysadm.routage
		Set cod_travail = 'CAS'
		Where id_sin = @dcIdSin
	  End 
	Else
	  Begin
		Update sysadm.routage
		Set cod_travail = 'CPL'
		Where id_sin = @dcIdSin
	  End 
  End 

Go


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_LISTE_GTI' AND type = 'FN' )
        DROP function sysadm.FN_GET_LISTE_GTI
Go


CREATE  function sysadm.FN_GET_LISTE_GTI  (
        @dcIdSin    Decimal(10,0)     ) -- [PI062]
RETURNS Varchar(15)

AS
--------------------------------------------------------------------------------------------
-- FN_GET_LISTE_GTI FS le 26/10/2009 : liste des garanties sur un dossier
-- JFF      12/02/2016   [PI062]
--------------------------------------------------------------------------------------------

Begin 

  Declare @sListeGti varchar(15)
  Declare @sLibGb    varchar(35)
  Declare @iGti1 Integer
  Declare @iGti2 Integer
  Declare @iGti3 Integer

  Set @iGti1 = 0
  Set @iGti2 = 0
  Set @iGti3 = 0
  Set @sListeGti = ""


 	/* Sélection de la première garantie */
	
	Select Top 1
	    @iGti1 = id_gti
	From
	   sysadm.w_gar_sin
	Where
	    id_sin = @dcIdSin And id_gti not in ( @iGti1, @iGti2, @iGti3 )

	/* Sélection de la seconde garantie */

	Select Top 1
	    @iGti2 = id_gti
	From
	   sysadm.w_gar_sin
	Where
	    id_sin = @dcIdSin And id_gti not in ( @iGti1, @iGti2, @iGti3 )

	/* Sélection de la troisieme garantie */

	Select Top 1
	    @iGti3 = id_gti
	From
	   sysadm.w_gar_sin
	Where
	    id_sin = @dcIdSin And id_gti not in ( @iGti1, @iGti2, @iGti3 )
	
	If @iGti1 <> 0 
      Begin
         Set @sLibGb = sysadm.FN_CODE_NUM ( @iGti1, '-GB' )
         If @sLibGb is null Set @sLibGb = Convert ( varchar(10), @iGti1 )
         Set @sListeGti = @sLibGb
      End

	If @iGti2 <> 0
      Begin
         Set @sLibGb = sysadm.FN_CODE_NUM ( @iGti2, '-GB' )
         If @sLibGb is null Set @sLibGb = Convert ( varchar(10), @iGti2 )
         Set @sListeGti = @sListeGti + ',' + @sLibGb
      End


	If @iGti3 <> 0 
      Begin
         Set @sLibGb = sysadm.FN_CODE_NUM ( @iGti3, '-GB' )
         If @sLibGb is null Set @sLibGb = Convert ( varchar(10), @iGti3 )
         Set @sListeGti = @sListeGti + ',' + @sLibGb
      End

	Return @sListeGti

End
Go


-- JFF      12/02/2016   [PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_DIVERS_SINISTRE' AND type = 'FN' )
        DROP function sysadm.FN_GET_DIVERS_SINISTRE
Go


CREATE  function sysadm.FN_GET_DIVERS_SINISTRE 
	(
			@iIdSin Decimal (10,0), 	-- référence sinistre -- [PI062]
			@sNomZone varchar(35),  -- nom de la zone	
			@sCol varchar(35) 		-- précise la colonne à retourner ( val_nbre, val_mt, val_dte, val_car )	
	)
RETURNS varchar(60)

AS
--------------------------------------------------------------------------------------------
-- FN_GET_DIVERS_SINISTRE SBA le 30/06/2010 : Retourne le détail d'un sinistre
-- JFF      12/02/2016   [PI062]
--------------------------------------------------------------------------------------------

Begin

	Declare @sDivSin varchar(60)

	Set @sDivSin = 

	case @sCol
		when 'val_car' 	then (select top 1 sysadm.FN_TRIM(convert( varchar(60), val_car  )) from sysadm.div_sin where nom_zone=@sNomZone and id_sin=@iIdSin)
		when 'val_nbre' 	then (select top 1 sysadm.FN_TRIM(convert( varchar(60), val_nbre )) from sysadm.div_sin where nom_zone=@sNomZone and id_sin=@iIdSin)
		when 'val_mt' 		then (select top 1 sysadm.FN_TRIM(convert( varchar(60), val_mt   )) from sysadm.div_sin where nom_zone=@sNomZone and id_sin=@iIdSin)
		when 'val_dte' 	then (select top 1 sysadm.FN_TRIM(convert( varchar(60), val_dte  )) from sysadm.div_sin where nom_zone=@sNomZone and id_sin=@iIdSin)
		else ''
	end

	return @sDivSin

End
Go

--------------------------------------------------------------------
--
-- Procédure            :       FN_DATEDIFF
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_DATEDIFF' AND type = 'FN' )
        DROP function sysadm.FN_DATEDIFF
Go

CREATE  function sysadm.FN_DATEDIFF  ( 
		@DateDeb Datetime, 
		@DateFin Datetime,
		@iJourCpltNegPos integer,
		@iExclureLesJoursFeries integer,
		@iCompterEnJoursOuvres integer
		)
RETURNS integer

AS

Begin
    
-- 	@DateDeb Datetime : Date de début 
--  @DateFin Datetime : Date de fin
-- 	@iJourCpltNegPos integer : + ou - un nombre de jour. 
--							   Sert à ajuster le DateDiff qui renvoit nativement 0 si on comprage le même jour et début et fin, certains veulent voir 1.
--	@iExclureLesJoursFeries integer : 1 => on n'exclue les jours fériés du comptage, on ne les comptes pas dans la différence
--									  0 sinon on les comptes.
--	@iCompterEnJoursOuvres  integer : 1 => On ne compte que les jours ouvrés, donc on exclu le Samedi et Dimanche
--									  0 sinon pour compter tous les jours calendaires.
    
Declare @NbreJours Integer
Declare @JoursOuvres Integer
Declare @NumJour Integer
Declare @test Integer	
Declare @TotalJour Integer
Declare @JourTrait Integer
Declare @posJour Integer
Declare @Semaine Integer
Declare @I Integer
Declare @iNbreJourFeries Integer
Declare @dtePaques DateTime
Declare @iYear Integer

DECLARE @tbRacineJourFerie TABLE ( RacineFerie VarChar (6) null)
Insert into @tbRacineJourFerie Values ( '01/01/' )
Insert into @tbRacineJourFerie Values ( '01/05/' )
Insert into @tbRacineJourFerie Values ( '08/05/' )
Insert into @tbRacineJourFerie Values ( '14/07/' )
Insert into @tbRacineJourFerie Values ( '15/08/' )
Insert into @tbRacineJourFerie Values ( '01/11/' )
Insert into @tbRacineJourFerie Values ( '11/11/' )
Insert into @tbRacineJourFerie Values ( '25/12/' )

DECLARE @tbJourFeri TABLE ( dte_ferie	datetime	null)



Set @JoursOuvres=0
Set @NumJour=0
Set @test=0
Set @TotalJour=0
Set @JourTrait=0
Set @posJour=0
Set @Semaine=0
Set @I=0

If @iJourCpltNegPos is null Set @iJourCpltNegPos = 0
If @iExclureLesJoursFeries is null Set @iExclureLesJoursFeries = 0
If @iCompterEnJoursOuvres is null Set @iCompterEnJoursOuvres = 0

--Combien de jours a traités
set @TotalJour=Datediff(day,@DateDeb,@DateFin) + @iJourCpltNegPos

Set @NbreJours = @TotalJour

If @iCompterEnJoursOuvres > 0 
 Begin
	--Recherche du Numéro de Jour dans la semaine de DateDebut
	set @NumJour = datepart(weekday,@DateDeb)

	/*******************************
	 Traitement du début de semaine
	*******************************/
	--on se positionne sur le premier Lundi
	If @NumJour = 6 
	begin
	--Dans ce cas on est sur un Samedi
		If @NumJour = 6
		begin
		--C'est un samedi
			set @JourTrait = 2 --Car on à traité Dimanche
			set @posJour = 2 --De ce fait on à traité 2 Jours
		End
	end

	else if @NumJour = 7 
	begin
	--Dans ce cas on est sur un Dimanche
		set @JourTrait=1	
	end

	Else
	begin
		If @TotalJour+@NumJour <= 7 
		begin
		--Le total fait moins de 7 jours
		--Le début est en milieu de semaine
			If @TotalJour + @NumJour < 6
			begin
				set @JourTrait = @TotalJour
				set @JoursOuvres = @TotalJour
			End
			Else
			begin
			--Le total fait 7 jours (samedi et dimanche à enlever)
				set @JourTrait= @TotalJour
				set @JoursOuvres= 5 - @NumJour + 1
			end


		end

		Else
		begin
			--Nous avons plus de 7 jours, avec un début en milieu de semaine
			set @JourTrait = 7 - @NumJour + 1
			set @JoursOuvres = 5 - @NumJour + 1
		end

	End

	/***********************************************************
	 Traitement des semaines pleines, et de la dernière semaine
	***********************************************************/
	If @JourTrait < @TotalJour
	begin
	--Traitement des semaines pleines
		set @Semaine = convert(integer,((@TotalJour - @JourTrait) / 7))
		If @Semaine > 0
		begin
			set @JoursOuvres = @JoursOuvres + (@Semaine * 5)
			set @JourTrait = @JourTrait + (@Semaine * 7)
		end
	end

	--Puis traitement des jours restants
	If @TotalJour - @JourTrait = 6
	begin
		set @JoursOuvres = @JoursOuvres + 5
	end
	Else
	begin
		set @JoursOuvres = @JoursOuvres + (@TotalJour - @JourTrait)
	End
	
	Set @NbreJours = @JoursOuvres
	
 End

-- Traitement des Jours fériés
If @iExclureLesJoursFeries > 0 
 Begin
	Set @iYear = YEAR ( @DateDeb )
	
	While @iYear <= YEAR ( @DateFin ) 
	 Begin
	 
		Insert into @tbJourFeri
		Select RacineFerie + CONVERT ( VarChar ( 4 ), @iYear )
		From  @tbRacineJourFerie
		
		Select @dtePaques = sysadm.FN_GET_PAQUES ( @iYear )

-- Le dimanche de paques n'est pas férié		
-- 		Insert into @tbJourFeri Select Convert ( VarChar ( 10), @dtePaques, 103 )

		Insert into @tbJourFeri Select Convert ( VarChar ( 10), sysadm.FN_GET_LUNDI_DE_PAQUES ( @dtePaques ), 103 )
		Insert into @tbJourFeri Select Convert ( VarChar ( 10), sysadm.FN_GET_ASCENSION ( @dtePaques ), 103 )	  

-- Le dimanche de pentecote n'est pas férié		
-- 		Insert into @tbJourFeri Select Convert ( VarChar ( 10), sysadm.FN_GET_PENTECOTE ( @dtePaques ), 103 )	  
		Insert into @tbJourFeri Select Convert ( VarChar ( 10), sysadm.FN_GET_LUNDI_DE_PENTECOTE ( @dtePaques ), 103 )	  
	 
	 
		Set @iYear = @iYear + 1
	 
	 End 
	  
	  Select @iNbreJourFeries = COUNT ( * ) 
	  From   @tbJourFeri tb
	  Where  tb.dte_ferie between @DateDeb and @DateFin
	  
	  If @iNbreJourFeries is null Set @iNbreJourFeries = 0
	  If @iNbreJourFeries < 0 Set @iNbreJourFeries = 0
	
	  Set @NbreJours = @NbreJours - @iNbreJourFeries 
	
 End

If @NbreJours < 0 set @NbreJours = 0

Return @NbreJours 
End
Go

--------------------------------------------------------------------
--
-- Procédure            :       [FN_DATEDIFF_V01]
-- Auteur               :       FABRY JF/SBA
-- Date                 :       16/06/2014
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
--
-------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[FN_DATEDIFF_V01]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [sysadm].[FN_DATEDIFF_V01]
GO
CREATE  function sysadm.FN_DATEDIFF_V01  ( 
		@DateDeb Datetime, 
		@DateFin Datetime,
		@iJourCpltNegPos integer,
		@iExclureLesJoursFeries integer,
		@iCompterEnJoursOuvres integer
		)
RETURNS integer

AS

Begin
    
-- 	@DateDeb Datetime : Date de début 
--  @DateFin Datetime : Date de fin
-- 	@iJourCpltNegPos integer : + ou - un nombre de jour. 
--							   Sert à ajuster le DateDiff qui renvoit nativement 0 si on comprage le même jour et début et fin, certains veulent voir 1.
--	@iExclureLesJoursFeries integer : 1 => on n'exclue les jours fériés du comptage, on ne les comptes pas dans la différence
--									  0 sinon on les comptes.
--	@iCompterEnJoursOuvres  integer : 1 => On ne compte que les jours ouvrés, donc on exclu le Samedi et Dimanche
--									  0 sinon pour compter tous les jours calendaires.
--									  2 calcul en jours ouvrables, seuls les dimanches sont exclus     
Declare @NbreJours Integer
Declare @JoursOuvres Integer
Declare @NumJour Integer
Declare @test Integer	
Declare @TotalJour Integer
Declare @JourTrait Integer
Declare @posJour Integer
Declare @Semaine Integer
Declare @I Integer
Declare @iNbreJourFeries Integer
Declare @dtePaques DateTime
Declare @iYear Integer

DECLARE @tbRacineJourFerie TABLE ( RacineFerie VarChar (6) null)
Insert into @tbRacineJourFerie Values ( '01/01/' )
Insert into @tbRacineJourFerie Values ( '01/05/' )
Insert into @tbRacineJourFerie Values ( '08/05/' )
Insert into @tbRacineJourFerie Values ( '14/07/' )
Insert into @tbRacineJourFerie Values ( '15/08/' )
Insert into @tbRacineJourFerie Values ( '01/11/' )
Insert into @tbRacineJourFerie Values ( '11/11/' )
Insert into @tbRacineJourFerie Values ( '25/12/' )

DECLARE @tbJourFeri TABLE ( dte_ferie	datetime	null)



Set @JoursOuvres=0
Set @NumJour=0
Set @test=0
Set @TotalJour=0
Set @JourTrait=0
Set @posJour=0
Set @Semaine=0
Set @I=0

If @iJourCpltNegPos is null Set @iJourCpltNegPos = 0
If @iExclureLesJoursFeries is null Set @iExclureLesJoursFeries = 0
If @iCompterEnJoursOuvres is null Set @iCompterEnJoursOuvres = 0

--Combien de jours a traités
set @TotalJour=Datediff(day,@DateDeb,@DateFin) + @iJourCpltNegPos

Set @NbreJours = @TotalJour

If @iCompterEnJoursOuvres = 1 
 Begin
	--Recherche du Numéro de Jour dans la semaine de DateDebut
	set @NumJour = datepart(weekday,@DateDeb)

	/*******************************
	 Traitement du début de semaine
	*******************************/
	--on se positionne sur le premier Lundi
	If @NumJour = 6 
	begin
	--Dans ce cas on est sur un Samedi
		If @NumJour = 6
		begin
		--C'est un samedi
			set @JourTrait = 2 --Car on à traité Dimanche
			set @posJour = 2 --De ce fait on à traité 2 Jours
		End
	end

	else if @NumJour = 7 
	begin
	--Dans ce cas on est sur un Dimanche
		set @JourTrait=1	
	end

	Else
	begin
		If @TotalJour+@NumJour <= 7 
		begin
		--Le total fait moins de 7 jours
		--Le début est en milieu de semaine
			If @TotalJour + @NumJour < 6
			begin
				set @JourTrait = @TotalJour
				set @JoursOuvres = @TotalJour
			End
			Else
			begin
			--Le total fait 7 jours (samedi et dimanche à enlever)
				set @JourTrait= @TotalJour
				set @JoursOuvres= 5 - @NumJour + 1
			end


		end

		Else
		begin
			--Nous avons plus de 7 jours, avec un début en milieu de semaine
			set @JourTrait = 7 - @NumJour + 1
			set @JoursOuvres = 5 - @NumJour + 1
		end

	End

	/***********************************************************
	 Traitement des semaines pleines, et de la dernière semaine
	***********************************************************/
	If @JourTrait < @TotalJour
	begin
	--Traitement des semaines pleines
		set @Semaine = convert(integer,((@TotalJour - @JourTrait) / 7))
		If @Semaine > 0
		begin
			set @JoursOuvres = @JoursOuvres + (@Semaine * 5)
			set @JourTrait = @JourTrait + (@Semaine * 7)
		end
	end

	--Puis traitement des jours restants
	If @TotalJour - @JourTrait = 6
	begin
		set @JoursOuvres = @JoursOuvres + 5
	end
	Else
	begin
		set @JoursOuvres = @JoursOuvres + (@TotalJour - @JourTrait)
	End
	
	Set @NbreJours = @JoursOuvres
	
End

If @iCompterEnJoursOuvres = 2
 Begin
	--Recherche du Numéro de Jour dans la semaine de DateDebut
	set @NumJour = datepart(weekday,@DateDeb)

	/*******************************
	 Traitement du début de semaine
	*******************************/
	--on se positionne sur le premier Lundi
	If @NumJour = 7
	begin
	--Dans ce cas on est sur un Dimanche
		If @NumJour = 7
		begin
		--C'est un dimanche
			set @JourTrait = 1 --Car on à traité Dimanche
			set @posJour = 1 --De ce fait on à traité 2 Jours
		End
	end

	Else
	begin
		If @TotalJour+@NumJour <= 7 
		begin
		--Le total fait moins de 7 jours
		--Le début est en milieu de semaine
			If @TotalJour + @NumJour < 7
			begin
				set @JourTrait = @TotalJour
				set @JoursOuvres = @TotalJour
			End
			Else
			begin
			--Le total fait 7 jours (dimanche à enlever)
			-- ex diff entre samedi et dimanche d'une même semaine
			-- total jour = 1, num jour : 6, => 1 samedi en jour ouvrable
				set @JourTrait= @TotalJour
				set @JoursOuvres= 6 - @NumJour + 1
			end
		end

		Else
		begin
			--Nous avons plus de 7 jours, avec un début en milieu de semaine
			set @JourTrait = 7 - @NumJour + 1
			set @JoursOuvres = 6 - @NumJour + 1
		end

	End

	/***********************************************************
	 Traitement des semaines pleines, et de la dernière semaine
	***********************************************************/
	If @JourTrait < @TotalJour
	begin
	--Traitement des semaines pleines
		set @Semaine = convert(integer,((@TotalJour - @JourTrait) / 7))
		If @Semaine > 0
		begin
			set @JoursOuvres = @JoursOuvres + (@Semaine * 6)
			set @JourTrait = @JourTrait + (@Semaine * 7)
		end
	end

	--Puis traitement des jours restants
	If @TotalJour - @JourTrait = 6
	begin
		set @JoursOuvres = @JoursOuvres + 6
	end
	Else
	begin
		set @JoursOuvres = @JoursOuvres + (@TotalJour - @JourTrait)
	End
	
	Set @NbreJours = @JoursOuvres
	
 End

-- Traitement des Jours fériés
If @iExclureLesJoursFeries > 0 
 Begin
	Set @iYear = YEAR ( @DateDeb )
	
	While @iYear <= YEAR ( @DateFin ) 
	 Begin
	 
		Insert into @tbJourFeri
		Select RacineFerie + CONVERT ( VarChar ( 4 ), @iYear )
		From  @tbRacineJourFerie
		
		Select @dtePaques = sysadm.FN_GET_PAQUES ( @iYear )

-- Le dimanche de paques n'est pas férié		
-- 		Insert into @tbJourFeri Select Convert ( VarChar ( 10), @dtePaques, 103 )

		Insert into @tbJourFeri Select Convert ( VarChar ( 10), sysadm.FN_GET_LUNDI_DE_PAQUES ( @dtePaques ), 103 )
		Insert into @tbJourFeri Select Convert ( VarChar ( 10), sysadm.FN_GET_ASCENSION ( @dtePaques ), 103 )	  

-- Le dimanche de pentecote n'est pas férié		
-- 		Insert into @tbJourFeri Select Convert ( VarChar ( 10), sysadm.FN_GET_PENTECOTE ( @dtePaques ), 103 )	  
		Insert into @tbJourFeri Select Convert ( VarChar ( 10), sysadm.FN_GET_LUNDI_DE_PENTECOTE ( @dtePaques ), 103 )	  
	 
	 
		Set @iYear = @iYear + 1
	 
	 End 
	  
	  Select @iNbreJourFeries = COUNT ( * ) 
	  From   @tbJourFeri tb
	  Where  tb.dte_ferie between @DateDeb and @DateFin
	  
	  If @iNbreJourFeries is null Set @iNbreJourFeries = 0
	  If @iNbreJourFeries < 0 Set @iNbreJourFeries = 0
	
	  Set @NbreJours = @NbreJours - @iNbreJourFeries 
	
 End

If @NbreJours < 0 set @NbreJours = 0

Return @NbreJours 
End

GO


--------------------------------------------------------------------
--
-- Procédure            :       FN_GET_ASCENSION
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_ASCENSION' AND type = 'FN' )
        DROP function sysadm.FN_GET_ASCENSION
Go

CREATE  function sysadm.FN_GET_ASCENSION ( 
		@dPaques DateTime
		)
RETURNS DateTime

AS

Begin

Declare @dAscension DateTime

Set @dAscension = DATEADD ( day, 39, @dPaques )

Return @dAscension 
End 
Go

--------------------------------------------------------------------
--
-- Procédure            :       FN_GET_LUNDI_DE_PAQUES
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_LUNDI_DE_PAQUES' AND type = 'FN' )
        DROP function sysadm.FN_GET_LUNDI_DE_PAQUES
Go

CREATE  function sysadm.FN_GET_LUNDI_DE_PAQUES ( 
		@dPaques DateTime
		)
RETURNS DateTime

AS

Begin

Declare @dLundiDePaques DateTime

Set @dLundiDePaques = DATEADD ( day, 1, @dPaques )

Return @dLundiDePaques 
End 
Go

--------------------------------------------------------------------
--
-- Procédure            :       FN_GET_LUNDI_DE_PENTECOTE
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_LUNDI_DE_PENTECOTE' AND type = 'FN' )
        DROP function sysadm.FN_GET_LUNDI_DE_PENTECOTE
Go

CREATE  function sysadm.FN_GET_LUNDI_DE_PENTECOTE ( 
		@dPaques DateTime
		)
RETURNS DateTime

AS

Begin

Declare @dLundiDePentecote DateTime

Set @dLundiDePentecote = DATEADD ( day, 50, @dPaques )

Return @dLundiDePentecote
End 
Go

--------------------------------------------------------------------
--
-- Procédure            :       FN_GET_PAQUES
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_PAQUES' AND type = 'FN' )
        DROP function sysadm.FN_GET_PAQUES
Go

CREATE  function sysadm.FN_GET_PAQUES  ( 
		@iAnnee Integer 
		)
RETURNS DateTime

AS

Begin

Declare @dPaques DateTime
Declare @a integer
Declare @b integer
Declare @c integer
Declare @d integer
Declare @e integer

Set @a = @iAnnee%19
Set @b = @iAnnee%4
Set @c = @iAnnee%7

Set @d = ( 19 * @a + 24 )%30
Set @e = ( 2 * @b + 4 * @c + 6 * @d + 5 )%7

If ( @d + @e )<= 9
 Begin
  Set @dPaques = CONVERT ( DateTime, Convert ( VarChar (10), ( 22 + @d + @e ) )+ '/03/' + Convert ( VarChar ( 4 ), @iAnnee )  )
 End 
Else
 Begin
  Set @dPaques = CONVERT ( DateTime, Convert ( VarChar (10), ( @d + @e - 9 ) )+ '/04/' + Convert ( VarChar ( 4 ), @iAnnee )  )
 End 

Return @dPaques
End 
Go

--------------------------------------------------------------------
--
-- Procédure            :       FN_GET_PENTECOTE
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_PENTECOTE' AND type = 'FN' )
        DROP function sysadm.FN_GET_PENTECOTE
Go

CREATE  function sysadm.FN_GET_PENTECOTE ( 
		@dPaques DateTime
		)
RETURNS DateTime

AS

Begin

Declare @dPentecote DateTime

Set @dPentecote = DATEADD ( day, 49, @dPaques )

Return @dPentecote 
End 
Go

GO


--------------------------------------------------------------------
--
-- Fonction             :       FN_LIB_POLICE_V02
-- Auteur               :       Fabry JF
-- Date                 :       17/10/2013
-- Libellé              :
-- Commentaires         :       Retourne le numéro de police par rapport à un sinistre
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_LIB_POLICE_V02' AND type = 'FN' )
        DROP function sysadm.FN_LIB_POLICE_V02
GO


CREATE  function sysadm.FN_LIB_POLICE_V02  (
        @dcIdSin    Decimal (10) , -- [PI062]
		@sCas		VarChar  ( 1 ) -- P/W
		)
RETURNS VarChar ( 35 )
AS

Begin

Declare @sLibPolice VarChar (35)

If @sCas is null Set @sCas = 'P' -- Défaut

If @sCas = 'P'
Begin
	If 
	(
	Select COUNT (*)
	From 
		(
			Select  distinct g.id_police
			From	sysadm.sinistre s,
					sysadm.garantie g,
					sysadm.gar_sin gs,
					sysadm.police p,
					sysadm.compagnie c

			Where   s.id_sin = @dcIdSin
			And		gs.id_sin = s.id_sin
			And     g.id_prod = s.id_prod
			And		g.id_gti  = gs.id_gti
			And		g.id_rev = s.id_rev
			And		p.id_police = g.id_police
			And		c.id_cie = p.id_cie
		) as Tb
	) <> 1 
	 Begin
 
		If ( Select COUNT (*) From sysadm.gar_sin where id_sin = @dcIdSin ) = 0
			Or 
		   ( Select id_rev From sysadm.sinistre s where s.id_sin = @dcIdSin ) < 0 	
		 Begin
			If 
			(
			Select COUNT (*)
			From 
				(
					Select  distinct g.id_police
					From	sysadm.sinistre s,
							sysadm.garantie g,
							sysadm.police p,
							sysadm.compagnie c

					Where   s.id_sin = @dcIdSin
					And     g.id_prod = s.id_prod
					And		( g.id_rev = s.id_rev or s.id_rev < 0 )
					And		p.id_police = g.id_police
					And		c.id_cie = p.id_cie
				) as Tb
			) = 1
				Begin 
					Select  Top 1 @sLibPolice = p.lib_police
					From	sysadm.sinistre s,
							sysadm.garantie g,
							sysadm.police p,
							sysadm.compagnie c

					Where   s.id_sin = @dcIdSin
					And     g.id_prod = s.id_prod
					And		( g.id_rev = s.id_rev or s.id_rev < 0 )
					And		p.id_police = g.id_police
					And		c.id_cie = p.id_cie		
				
					Return @sLibPolice
				End 
		 End  
 
		Return 'Dépendance avec la garantie'
	 End 

	Select	@sLibPolice = p.lib_police
	From	sysadm.sinistre s,
			sysadm.garantie g,
			sysadm.gar_sin gs,
			sysadm.police p,
			sysadm.compagnie c

	Where   s.id_sin = @dcIdSin
	And		gs.id_sin = s.id_sin
	And     g.id_prod = s.id_prod
	And		g.id_gti  = gs.id_gti
	And		g.id_rev = s.id_rev
	And		p.id_police = g.id_police
	And		c.id_cie = p.id_cie
End 

If @sCas = 'W'
Begin
	If 
	(
	Select COUNT (*)
	From 
		(
			Select  distinct g.id_police
			From	sysadm.w_sin s,
					sysadm.garantie g,
					sysadm.w_gar_sin gs,
					sysadm.police p,
					sysadm.compagnie c

			Where   s.id_sin = @dcIdSin
			And		gs.id_sin = s.id_sin
			And     g.id_prod = s.id_prod
			And		g.id_gti  = gs.id_gti
			And		g.id_rev = s.id_rev
			And		p.id_police = g.id_police
			And		c.id_cie = p.id_cie
		) as Tb
	) <> 1 
	 Begin
 
		If ( Select COUNT (*) From sysadm.w_gar_sin where id_sin = @dcIdSin ) = 0
			Or 
		   ( Select id_rev From sysadm.w_sin s where s.id_sin = @dcIdSin ) < 0 	
		 Begin
			If 
			(
			Select COUNT (*)
			From 
				(
					Select  distinct g.id_police
					From	sysadm.w_sin s,
							sysadm.garantie g,
							sysadm.police p,
							sysadm.compagnie c

					Where   s.id_sin = @dcIdSin
					And     g.id_prod = s.id_prod
					And		( g.id_rev = s.id_rev or s.id_rev < 0 )
					And		p.id_police = g.id_police
					And		c.id_cie = p.id_cie
				) as Tb
			) = 1
				Begin 
					Select  Top 1 @sLibPolice = p.lib_police
					From	sysadm.w_sin s,
							sysadm.garantie g,
							sysadm.police p,
							sysadm.compagnie c

					Where   s.id_sin = @dcIdSin
					And     g.id_prod = s.id_prod
					And		( g.id_rev = s.id_rev or s.id_rev < 0 )
					And		p.id_police = g.id_police
					And		c.id_cie = p.id_cie		
				
					Return @sLibPolice
				End 
		 End  
 
		Return 'Dépendance avec la garantie'
	 End 

	Select	@sLibPolice = p.lib_police
	From	sysadm.w_sin s,
			sysadm.garantie g,
			sysadm.w_gar_sin gs,
			sysadm.police p,
			sysadm.compagnie c

	Where   s.id_sin = @dcIdSin
	And		gs.id_sin = s.id_sin
	And     g.id_prod = s.id_prod
	And		g.id_gti  = gs.id_gti
	And		g.id_rev = s.id_rev
	And		p.id_police = g.id_police
	And		c.id_cie = p.id_cie
End 


Return rtrim ( ltrim ( @sLibPolice )) 

End 

GO

--------------------------------------------------------------------
--
-- Fonction             :       FN_LIB_CIE_V02
-- Auteur               :       Fabry JF
-- Date                 :       17/10/2013
-- Libellé              :
-- Commentaires         :       Retourne le numéro de compagnie par rapport à un sinistre
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      07/03/2024   [HP252_276_HUB_PRESTA] -- Ajout trt @sCas
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_LIB_CIE_V02' AND type = 'FN' )
        DROP function sysadm.FN_LIB_CIE_V02
GO

CREATE  function sysadm.FN_LIB_CIE_V02  (
        @dcIdSin    Decimal (10) , -- [PI062]
		@sCas		VarChar  ( 1 ) -- P/W
		)
RETURNS VarChar ( 35 )
AS

Begin

Declare @sLibCie VarChar (35)

If @sCas is null Set @sCas = 'P' -- Défaut

If @sCas = 'P'
Begin
	If 
	(
	Select COUNT (*)
	From 
		(
			Select  distinct c.id_cie
			From	sysadm.sinistre s,
					sysadm.garantie g,
					sysadm.gar_sin gs,
					sysadm.police p,
					sysadm.compagnie c

			Where   s.id_sin = @dcIdSin
			And		gs.id_sin = s.id_sin
			And     g.id_prod = s.id_prod
			And		g.id_gti  = gs.id_gti
			And		g.id_rev = s.id_rev
			And		p.id_police = g.id_police
			And		c.id_cie = p.id_cie
		) as Tb
	) <> 1 
	 Begin
 
 		If ( Select COUNT (*) From sysadm.gar_sin where id_sin = @dcIdSin ) = 0
 			Or 
		   ( Select id_rev From sysadm.sinistre s where s.id_sin = @dcIdSin ) < 0 	
		 Begin
			If 
			(
			Select COUNT (*)
			From 
				(
					Select  distinct c.id_cie
					From	sysadm.sinistre s,
							sysadm.garantie g,
							sysadm.police p,
							sysadm.compagnie c

					Where   s.id_sin = @dcIdSin
					And     g.id_prod = s.id_prod
					And		( g.id_rev = s.id_rev or s.id_rev < 0 )
					And		p.id_police = g.id_police
					And		c.id_cie = p.id_cie
				) as Tb
			) = 1
				Begin 
					Select	Top 1 @sLibCie = c.lib_cie
					From	sysadm.sinistre s,
							sysadm.garantie g,
							sysadm.police p,
							sysadm.compagnie c

					Where   s.id_sin = @dcIdSin
					And     g.id_prod = s.id_prod
					And		( g.id_rev = s.id_rev or s.id_rev < 0 )
					And		p.id_police = g.id_police
					And		c.id_cie = p.id_cie	
				
					Return ltrim ( rtrim ( @sLibCie ))
				End 
		 End  

 
 
		Return 'Dépendance avec la garantie'
	 End 

	Select	Top 1 @sLibCie = c.lib_cie
	From	sysadm.sinistre s,
			sysadm.garantie g,
			sysadm.gar_sin gs,
			sysadm.police p,
			sysadm.compagnie c

	Where   s.id_sin = @dcIdSin
	And		gs.id_sin = s.id_sin
	And     g.id_prod = s.id_prod
	And		g.id_rev = s.id_rev
	And		g.id_gti  = gs.id_gti
	And		p.id_police = g.id_police
	And		c.id_cie = p.id_cie
End 

If @sCas = 'W'
Begin
	If 
	(
	Select COUNT (*)
	From 
		(
			Select  distinct c.id_cie
			From	sysadm.w_sin s,
					sysadm.garantie g,
					sysadm.w_gar_sin gs,
					sysadm.police p,
					sysadm.compagnie c

			Where   s.id_sin = @dcIdSin
			And		gs.id_sin = s.id_sin
			And     g.id_prod = s.id_prod
			And		g.id_gti  = gs.id_gti
			And		g.id_rev = s.id_rev
			And		p.id_police = g.id_police
			And		c.id_cie = p.id_cie
		) as Tb
	) <> 1 
	 Begin
 
 		If ( Select COUNT (*) From sysadm.w_gar_sin where id_sin = @dcIdSin ) = 0
 			Or 
		   ( Select id_rev From sysadm.w_sin s where s.id_sin = @dcIdSin ) < 0 	
		 Begin
			If 
			(
			Select COUNT (*)
			From 
				(
					Select  distinct c.id_cie
					From	sysadm.w_sin s,
							sysadm.garantie g,
							sysadm.police p,
							sysadm.compagnie c

					Where   s.id_sin = @dcIdSin
					And     g.id_prod = s.id_prod
					And		( g.id_rev = s.id_rev or s.id_rev < 0 )
					And		p.id_police = g.id_police
					And		c.id_cie = p.id_cie
				) as Tb
			) = 1
				Begin 
					Select	Top 1 @sLibCie = c.lib_cie
					From	sysadm.w_sin s,
							sysadm.garantie g,
							sysadm.police p,
							sysadm.compagnie c

					Where   s.id_sin = @dcIdSin
					And     g.id_prod = s.id_prod
					And		( g.id_rev = s.id_rev or s.id_rev < 0 )
					And		p.id_police = g.id_police
					And		c.id_cie = p.id_cie	
				
					Return ltrim ( rtrim ( @sLibCie ))
				End 
		 End  

 
 
		Return 'Dépendance avec la garantie'
	 End 

	Select	Top 1 @sLibCie = c.lib_cie
	From	sysadm.w_sin s,
			sysadm.garantie g,
			sysadm.w_gar_sin gs,
			sysadm.police p,
			sysadm.compagnie c

	Where   s.id_sin = @dcIdSin
	And		gs.id_sin = s.id_sin
	And     g.id_prod = s.id_prod
	And		g.id_rev = s.id_rev
	And		g.id_gti  = gs.id_gti
	And		p.id_police = g.id_police
	And		c.id_cie = p.id_cie
End 


Return ltrim ( rtrim ( @sLibCie ))

End 

GO

--------------------------------------------------------------------
--
-- Fonction             :       FN_ID_CIE_V02
-- Auteur               :       Fabry JF
-- Date                 :       17/10/2013
-- Libellé              :
-- Commentaires         :       Retourne l'ID compagnie par rapport à un sinistre
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      07/03/2024   [HP252_276_HUB_PRESTA] -- Ajout trt @sCas
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_ID_CIE_V02' AND type = 'FN' )
        DROP function sysadm.FN_ID_CIE_V02
GO

CREATE  function sysadm.FN_ID_CIE_V02  (
        @dcIdSin    Decimal (10) , -- [PI062]
		@sCas		VarChar  ( 1 ) -- P/W
		)
RETURNS Integer
AS

Begin

Declare @iIdCie Integer

If @sCas is null Set @sCas = 'P' -- Défaut

If @sCas = 'P'
Begin
	If 
	(
	Select COUNT (*)
	From 
		(
			Select  distinct c.id_cie
			From	sysadm.sinistre s,
					sysadm.garantie g,
					sysadm.gar_sin gs,
					sysadm.police p,
					sysadm.compagnie c

			Where   s.id_sin = @dcIdSin
			And		gs.id_sin = s.id_sin
			And     g.id_prod = s.id_prod
			And		g.id_gti  = gs.id_gti
			And		g.id_rev = s.id_rev
			And		p.id_police = g.id_police
			And		c.id_cie = p.id_cie
		) as Tb
	) <> 1 
	 Begin
 
 		If ( Select COUNT (*) From sysadm.gar_sin where id_sin = @dcIdSin ) = 0
 			Or 
		   ( Select id_rev From sysadm.sinistre s where s.id_sin = @dcIdSin ) < 0 	
		 Begin
			If 
			(
			Select COUNT (*)
			From 
				(
					Select  distinct c.id_cie
					From	sysadm.sinistre s,
							sysadm.garantie g,
							sysadm.police p,
							sysadm.compagnie c

					Where   s.id_sin = @dcIdSin
					And     g.id_prod = s.id_prod
					And		( g.id_rev = s.id_rev or s.id_rev < 0 )
					And		p.id_police = g.id_police
					And		c.id_cie = p.id_cie
				) as Tb
			) = 1
				Begin 
					Select	Top 1 @iIdCie = c.id_cie
					From	sysadm.sinistre s,
							sysadm.garantie g,
							sysadm.police p,
							sysadm.compagnie c

					Where   s.id_sin = @dcIdSin
					And     g.id_prod = s.id_prod
					And		( g.id_rev = s.id_rev or s.id_rev < 0 )
					And		p.id_police = g.id_police
					And		c.id_cie = p.id_cie	
				
					Return @iIdCie 
				End 
		 End  
 
		Return -1 -- 'Dépendance avec la garantie'
	 End 

	Select	Top 1 @iIdCie = c.id_cie
	From	sysadm.sinistre s,
			sysadm.garantie g,
			sysadm.gar_sin gs,
			sysadm.police p,
			sysadm.compagnie c

	Where   s.id_sin = @dcIdSin
	And		gs.id_sin = s.id_sin
	And     g.id_prod = s.id_prod
	And		g.id_rev = s.id_rev
	And		g.id_gti  = gs.id_gti
	And		p.id_police = g.id_police
	And		c.id_cie = p.id_cie
End

If @sCas = 'W'
Begin
	If
	(
	Select COUNT (*)
	From 
		(
			Select  distinct c.id_cie
			From	sysadm.w_sin s,
					sysadm.garantie g,
					sysadm.w_gar_sin gs,
					sysadm.police p,
					sysadm.compagnie c

			Where   s.id_sin = @dcIdSin
			And		gs.id_sin = s.id_sin
			And     g.id_prod = s.id_prod
			And		g.id_gti  = gs.id_gti
			And		g.id_rev = s.id_rev
			And		p.id_police = g.id_police
			And		c.id_cie = p.id_cie
		) as Tb
	) <> 1 
	 Begin
 
 		If ( Select COUNT (*) From sysadm.w_gar_sin where id_sin = @dcIdSin ) = 0
 			Or 
		   ( Select id_rev From sysadm.w_sin s where s.id_sin = @dcIdSin ) < 0 	
		 Begin
			If 
			(
			Select COUNT (*)
			From 
				(
					Select  distinct c.id_cie
					From	sysadm.w_sin s,
							sysadm.garantie g,
							sysadm.police p,
							sysadm.compagnie c

					Where   s.id_sin = @dcIdSin
					And     g.id_prod = s.id_prod
					And		( g.id_rev = s.id_rev or s.id_rev < 0 )
					And		p.id_police = g.id_police
					And		c.id_cie = p.id_cie
				) as Tb
			) = 1
				Begin 
					Select	Top 1 @iIdCie = c.id_cie
					From	sysadm.w_sin s,
							sysadm.garantie g,
							sysadm.police p,
							sysadm.compagnie c

					Where   s.id_sin = @dcIdSin
					And     g.id_prod = s.id_prod
					And		( g.id_rev = s.id_rev or s.id_rev < 0 )
					And		p.id_police = g.id_police
					And		c.id_cie = p.id_cie	
				
					Return @iIdCie 
				End 
		 End  
 
		Return -1 -- 'Dépendance avec la garantie'
	 End 

	Select	Top 1 @iIdCie = c.id_cie
	From	sysadm.w_sin s,
			sysadm.garantie g,
			sysadm.w_gar_sin gs,
			sysadm.police p,
			sysadm.compagnie c

	Where   s.id_sin = @dcIdSin
	And		gs.id_sin = s.id_sin
	And     g.id_prod = s.id_prod
	And		g.id_rev = s.id_rev
	And		g.id_gti  = gs.id_gti
	And		p.id_police = g.id_police
	And		c.id_cie = p.id_cie
End 

Return @iIdCie

End 

GO


--------------------------------------------------------------------
--
-- Fonction             :       FN_CORR_NUM_CARTE_19
-- Auteur               :       Fabry JF
-- Date                 :       15/01/2008
-- Libellé              :		[PM208]
-- Commentaires         :       Renvoi un n° de carte bancaire corrigé
-- Références           :       
--
-- Arguments            :       le début de la carte de 0 à 16 chiffres possibles
--				Ex : Select sysadm.FN_CORR_NUM_CARTE ( '352003', GetDate() )
--				     Select sysadm.FN_CORR_CARTE ( '35200355547', GetDate() )	
--
-- Retourne             :       Rien
--
--------------------------------------------------------------------


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_CORR_NUM_CARTE_19' AND type = 'FN' )
        DROP function sysadm.FN_CORR_NUM_CARTE_19
Go

CREATE  function sysadm.FN_CORR_NUM_CARTE_19
       ( @asRacine        VarChar ( 19 ),
	 @dtGetDate       DateTime )
RETURNS Varchar(19)

AS

Begin

	Declare @iFin integer
	Declare @iCpt integer
	Declare @iSom  integer
	Declare @iCalc  integer
	Declare @Coef integer
	Declare @iIdCarte Decimal ( 7 )
	Declare @CpltRacine VarChar ( 24 )   -- Complement de racine
	Declare @sCle VarChar ( 1 )    -- Cle calculée
	
	Set @iFin = 0
	Set @iCpt = 1
	Set @iIdCarte = -1
	Set @iSom = 0
	
	select @CpltRacine = Convert ( varchar (24) , @dtGetDate,14 ) + Convert ( varchar ( 24) , @dtGetDate,14 ) 
	
	WHILE ( @iCpt <= Len ( @CpltRacine ) )
	BEGIN
	   If ( Select Substring ( @CpltRacine, @iCpt, 1 ) ) = ':' 
	     Begin
	        Set @CpltRacine = Left ( @CpltRacine, @iCpt - 1 ) + Substring ( @CpltRacine, @iCpt + 1, Len (@CpltRacine)  ) 
	        Set @iCpt = 1
	     End 
	   Else
	     Begin
	        Set @iCpt = @iCpt + 1
	     End 
	
	End
	
	Set @asRacine = Left ( @asRacine + @CpltRacine, 18 )
	
	Set @iCpt = 1
	
	While @iCpt <= 18
	 Begin
	   If ( @iCpt % 2 = 0 )
	     Begin
	        Set @iCalc = Convert ( integer, SubString ( @asRacine, @iCpt, 1 ) ) * 2
	        If  @iCalc >= 10 
	          Begin
	            Set @iCalc = Convert ( int, Left ( Convert ( VarChar ( 2 ), @iCalc ), 1 ) ) + 
	                         Convert ( int, Right ( Convert ( VarChar ( 2 ), @iCalc ), 1 ) )
	          End
	   
	        Set @iSom = @iSom + @iCalc
	     End
	   Else
	     Begin
	        Set @iSom = @iSom + Convert ( integer, SubString ( @asRacine, @iCpt, 1 ) )
	     End
	   Set @iCpt = @iCpt + 1
	 End 
	
	If ( @iSom % 10 = 0 ) 
	 Set @sCle = 0
	Else
	 Set @sCle = Convert ( VarChar (1),  ( ( Convert ( int ,  @iSom / 10 ) * 10 ) + 10 ) - @iSom )
	
	Set @asRacine = @asRacine + @sCle

  Return @asRacine

End
Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_MASQUER_CARTE_2
-- Auteur               :       Fabry JF
-- Date                 :       15/01/2008
-- Libellé              :		[PM208]
-- Commentaires         :       Renvoi un n° de carte bancaire corrigé
-- Références           :       
--
-- Arguments            :       le début de la carte de 0 à 19 chiffres possibles
--
-- Retourne             :       Rien
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_MASQUER_CARTE_2' AND type = 'FN' )
        DROP function sysadm.FN_MASQUER_CARTE_2
Go

CREATE  function sysadm.FN_MASQUER_CARTE_2
       ( @asNumCarte Varchar(19) )

RETURNS Varchar(19)

AS

Begin

  If Len ( @asNumCarte ) = 16 Or Len ( @asNumCarte ) = 19
	Begin
		Return Left ( @asNumCarte, 6 ) + Replicate ( 'X', Len ( @asNumCarte ) - 10 ) + Right ( @asNumCarte, 4 )
	End 
	
  Return @asNumCarte
End
Go

--------------------------------------------------------------------
--
-- Fonction             :       [sysadm].[PS_DATEDIFF]
-- Auteur               :       SBA
-- Date                 :       05/05/2014
-- Libellé              :		
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
--------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[PS_DATEDIFF]') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[PS_DATEDIFF]
GO

CREATE procedure [sysadm].[PS_DATEDIFF]
	@DateDeb 		varchar(10),
	@DateFin 		varchar(10),
	@iJourCpltNegPos integer,
	@iExclureLesJoursFeries integer,
	@iCompterEnJoursOuvres integer,
	@Delai 	integer=null output		

As
    Declare @DtDeb datetime
    Set @DtDeb = convert(datetime,@DateDeb,103)

    Declare @DtFin datetime
    Set @DtFin = convert(datetime,@DateFin,103)


 Set @Delai = sysadm.FN_DATEDIFF_V01 (@DtDeb,@DtFin,@iJourCpltNegPos,@iExclureLesJoursFeries,@iCompterEnJoursOuvres)

GO

grant execute on sysadm.PS_DATEDIFF to public

--------------------------------------------------------------------
--
-- Fonction             :       FN_LIB_ETAT_DOS
-- Auteur               :       Fabry JF
-- Date                 :       09/01/2014
-- Libellé              :
-- Commentaires         :       Retourne l'état du dossier avec la notion de pec.
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_LIB_ETAT_DOS' AND type = 'FN' )
        DROP function sysadm.FN_LIB_ETAT_DOS
GO


CREATE  function sysadm.FN_LIB_ETAT_DOS  (
        @dcIdSin    Decimal (10) , -- [PI062]
        @sTypRet	Varchar (10) = 'LIB' )
RETURNS VarChar ( 50 )
AS

Begin

Declare @iCodEtat Integer
Declare @sLibEtatDos VarChar ( 50 )

Set @sLibEtatDos = ''

Select @iCodEtat = s.cod_etat
From   sysadm.sinistre s
Where  s.id_sin = @dcIdSin

If @iCodEtat = 100 
 Begin
	If Exists ( 
		Select  *
		From	sysadm.detail d,
				sysadm.gar_sin g,
				sysadm.div_det dd
		Where	g.id_sin = @dcIdSin
		And		g.cod_etat = 100
		And		d.id_sin = g.id_sin
		And     d.id_gti = g.id_gti
		And	  	d.cod_etat = 100
		And		dd.id_sin = d.id_sin
		And		dd.id_gti = d.id_gti
		And		dd.id_detail = d.id_detail
		And		dd.nom_zone = 'pec'
		And		dd.val_car = 'O'
	   )
	  Begin
		If @sTypRet = 'CODE'
		  Begin
			Return '1540'
		  End 
		Else
		  Begin
			Return sysadm.FN_CODE_NUM ( 1540, '-ET' )
		  End 
	  End 
 End 

If @sTypRet = 'CODE'
  Begin
	Set @sLibEtatDos = Convert ( VarChar ( 50 ), @iCodEtat )
  End 
Else
  Begin
	Set @sLibEtatDos = sysadm.FN_CODE_NUM ( @iCodEtat, '-ET' )
  End 

Return @sLibEtatDos 

End 

GO


--------------------------------------------------------------------
--
-- Fonction             :       FN_LIB_ETAT_DOS_ASSURE
-- Auteur               :       Fabry JF
-- Date                 :       30/05/2014
-- Libellé              :
-- Commentaires         :       Retourne l'état du dossier vu de l'assuré. Attention à l'utilisation ! le client doit passer une gti.
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      01/08/2016   [PM364-1]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_LIB_ETAT_DOS_ASSURE' AND type = 'FN' )
        DROP function sysadm.FN_LIB_ETAT_DOS_ASSURE
GO

CREATE  function sysadm.FN_LIB_ETAT_DOS_ASSURE  (
        @dcIdSin    Decimal (10), -- [PI062]
        @sTypRet	VarChar ( 10 ) = 'LIB' )
RETURNS VarChar ( 50 )
AS
Begin

Declare @sLibEtatDos VarChar ( 50 )

/*
If sysadm.FN_CLE_NUMERIQUE ( 'EVOL_ETAT_VU_ASS') = 7 
 Begin */
	Return sysadm.FN_LIB_ETAT_DOS_ASSURE_V07 ( @dcIdSin, @sTypRet )
-- End 

Return ltrim ( rtrim ( @sLibEtatDos ))

End 

Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_LIB_ETAT_DOS_ASSURE
-- Auteur               :       Fabry JF
-- Date                 :       15/06/2016
-- Libellé              :		Evol suite vDoc21070
-- Commentaires         :       optimisation de la fonction
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      01/08/2016   [PM364-1] Passage en V03
-- JFF      07/09/2020   [VDOC29610] 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_LIB_ETAT_DOS_ASSURE_V07' AND type = 'FN' )
        DROP function sysadm.FN_LIB_ETAT_DOS_ASSURE_V07
GO

CREATE  function sysadm.FN_LIB_ETAT_DOS_ASSURE_V07  (
        @dcIdSin    Decimal (10),
        @sTypRet	VarChar ( 10 ) = 'LIB' )
RETURNS VarChar ( 50 )
AS
Begin

Declare @sLibEtatDos VarChar ( 50 )
Declare @iCasRempl Integer 

Set @iCasRempl = 0

-- EVOL_ETAT_VU_ASS VDOC21070
If Not Exists ( 
		Select Top 1 1
		From sysadm.commande_type ct,
				sysadm.sinistre s
		where s.id_sin = @dcIdSin
		And   ct.id_prod = s.id_prod 
		)
	Begin
		If @sTypRet = 'LIB'
		 Begin
			Select @sLibEtatDos = 
					Case sysadm.FN_LIB_ETAT_DOS ( @dcIdSin, @sTypRet )	
						When 'Refusé' Then sysadm.FN_CODE_NUM ( 1530, '-ET' )
						When 'Réglé' Then sysadm.FN_CODE_NUM ( 1500, '-ET' )
						Else sysadm.FN_LIB_ETAT_DOS ( @dcIdSin, @sTypRet )	
					End 
		 End
		Else  
		 Begin
			Select @sLibEtatDos = 
					Case sysadm.FN_LIB_ETAT_DOS ( @dcIdSin, @sTypRet )	
						When '200' Then '1530'
						When '600' Then '1500'
						Else sysadm.FN_LIB_ETAT_DOS ( @dcIdSin, @sTypRet )	
					End 
		 End


		If @sLibEtatDos is null 
			Begin
				Select @sLibEtatDos = 
						Case @sTypRet
								When 'CODE' Then '0'
								Else sysadm.FN_CODE_NUM ( 0, '-ET' )
						End 
			End 

		Return ltrim ( rtrim ( @sLibEtatDos ))
	End 

Select @sLibEtatDos =
		Case 
			When -- Remplacement abouti ?
				Exists (
					Select Top 1 1
					from sysadm.commande c1
					Where c1.id_sin = s.id_sin
					and   c1.cod_etat <> 'ANN' 
					And   sysadm.FN_A_COMMANDER ( c1.id_sin, c1.id_seq, 'P' ) = 'A_COMMANDER'
					And   ( c1.status_gc in ( 178, 33 ) -- [VDOC21070]
							Or
							c1.id_four in ( 'DTY', 'CAR')
							Or
							c1.id_typ_art = 'CAF'
							Or 
							( c1.status_gc = 0
							  And 
							  Len ( c1.id_serie_nouv ) > 0 
							  And 
							  Len ( c1.id_bon_transp ) > 0 
							)
						  )

					And   ( Len ( sysadm.FN_CLE_VAL ( 'PRBLE_LIVRAISON', c1.info_frn_spb_cplt, ';' ) ) <= 0
							Or 
							( 
								Len ( sysadm.FN_CLE_VAL ( 'PRBLE_LIVRAISON', c1.info_frn_spb_cplt, ';' ) ) > 0
								And
								sysadm.FN_CLE_VAL ( 'MAJ_ADRESSE', c1.info_spb_frn_cplt, ';' ) = 'OUI'
							)
						  )
				)
			
				Then 
					( Select Case @sTypRet
								When 'CODE' Then '1510'
								Else sysadm.FN_CODE_NUM ( 1510, '-ET' )
	  					     End 
					) -- 'Remplacé et clos pour l''assuré'
	
			When -- réparation hors PM280 A_REP_GTI (répa swap)?				
				Exists (
					Select Top 1 1
					from sysadm.commande c1
					Where c1.id_sin = s.id_sin
					and c1.cod_etat <> 'ANN' 
					And c1.status_gc in ( 2, 22, 31, 32 )
					And sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', c1.info_spb_frn_cplt, ';' ) <> 'OUI' -- [VDOC21070]
				)
				And Not Exists ( 
					Select Top 1 1
					from sysadm.commande c1,
						 sysadm.commande c2
					Where c1.id_sin = s.id_sin
					and c1.cod_etat <> 'ANN' 
					And c1.status_gc in ( 21 )
					And ( sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', c1.info_spb_frn_cplt, ';' ) = 'OUI' 
						  Or 
						  sysadm.FN_CLE_VAL ( 'A_CONTROLER_SAV', c1.info_spb_frn_cplt, ';' ) = 'OUI' 
						)
					And ( CharIndex ( '[BVIEOX]', c1.comment_frn, 1 ) <= 0
						And 
						CharIndex ( '[BRIS]', c1.comment_frn, 1 ) <= 0 
						And 
						CharIndex ( '[SAV_NO_OK]', c1.comment_frn, 1 ) <= 0 
						And 
						CharIndex ( '[OXY]', c1.comment_frn, 1 ) <= 0 
						)
					And c2.id_sin = s.id_sin
					and c2.cod_etat <> 'ANN' 
					And c2.status_gc in ( 2, 22, 31, 32 )
					And sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', c2.info_spb_frn_cplt, ';' ) <> 'OUI' -- [VDOC21070]
					And c1.id_seq > c2.id_seq
				)
				Then 
					( Select Case @sTypRet
								When 'CODE' Then '1520'
								Else sysadm.FN_CODE_NUM ( 1520, '-ET' )
							 End 
					) -- 'Réparé et clos pour l''assuré'

			When -- réglement à l'assuré
				Exists ( 
				  Select Top 1 1
				  From	 sysadm.reglement r,
						 sysadm.reg_gti rg
				  Where  r.id_sin = s.id_sin
				  And	 r.cod_inter = 'A'
				  And	 r.cod_mot_reg = 'RN'
				  And	 rg.id_sin = r.id_sin
				  And    rg.id_reg = r.id_reg
				  And    rg.id_gti > 0 
				--   And	 rg.id_gti = g.id_gti
				)
				
				Then 
					( Select Case @sTypRet
								When 'CODE' Then '1500'
								Else sysadm.FN_CODE_NUM ( 1500, '-ET' )
						   End 
					) -- 'Réglé et clos pour l''assuré'
				
			When  -- 'Refusé et clos pour l''assuré pour garantie refusée unique'	 
				Exists ( 
					Select Top 1 1
					From   sysadm.gar_sin g
					Where  g.id_sin = s.id_sin
					And    g.cod_etat = 200 )
				 And
				   Not Exists ( 
					Select Top 1 1
					From   sysadm.gar_sin g
					Where  g.id_sin = s.id_sin
					And    g.cod_etat not in ( 200, 900 ) )
					
				Then 
					( Select Case @sTypRet
								When 'CODE' Then '1530'
								Else sysadm.FN_CODE_NUM ( 1530, '-ET' )
							 End 
					)			

			When -- 'Refusé et clos pour l''assuré pour présence irréparable ou (incomplet chez CORDON) et absence de dde de pce'	 
				Exists (	
					Select Top 1 1
					from sysadm.commande c1
					Where c1.id_sin = s.id_sin
					and c1.id_typ_art in ( 'PRS' )		
					and c1.cod_etat <> 'ANN' 
					And c1.cree_le < DateAdd ( Month, -1, getdate () ) -- [VDOC29610]
					And ( c1.status_gc in ( 21, 23, 30, 34 )
					      Or 
						  ( c1.status_gc = 169 and c1.id_four = 'COR' )
						)
				 )
  				 And Not Exists ( 
						Select Top 1 1 
						From	sysadm.w_piece wp
						Where   wp.id_sin = s.id_sin
					)			
			
				Then 
					( Select Case @sTypRet
								When 'CODE' Then '1530'
								Else sysadm.FN_CODE_NUM ( 1530, '-ET' )
							 End 
					) 			

			When -- 'Refusé et clos pour l''assuré pour présence refusé à REEXP.'	
				Exists (
					Select Top 1 1
					from sysadm.commande c1,
						 sysadm.commande c2
					Where c1.id_sin = s.id_sin
					and c1.id_typ_art in ( 'PRS' )		
					and c1.cod_etat <> 'ANN' 
					And c1.status_gc in ( 153, 154 )
					And c2.id_sin = c1.id_sin
					And c2.id_seq > c1.id_seq
					And c2.id_ref_four = 'REFUSE_A_REEXP'
					And c2.cod_etat <> 'ANN' 
				 )
  				 And Not Exists ( 
						Select Top 1 1 
						From	sysadm.w_piece wp
						Where   wp.id_sin = s.id_sin
					)
				Then 
					( Select Case @sTypRet
								When 'CODE' Then '1530'
								Else sysadm.FN_CODE_NUM ( 1530, '-ET' )
							 End 
					) 

			When -- 'Refusé et clos pour l''assuré pour diag non conforme '
				Exists (
					Select Top 1 1 
					from sysadm.commande c1
					Where c1.id_sin = s.id_sin
--					and c1.id_typ_art in ( 'EDI' )		
--					and c1.id_ref_four in ( 'A_DIAGNOSTIQUER' ) Tout ce qui est non conforme génère de fait un état refusé pour l'assuré 
					and c1.cod_etat <> 'ANN' 
					And c1.status_gc in ( 152, 170 )
					And c1.cree_le < DateAdd ( Month, -1, getdate () ) -- [VDOC29610]
				 )	
  				 And Not Exists ( 
						Select Top 1 1 
						From	sysadm.w_piece wp
						Where   wp.id_sin = s.id_sin
					)			
				 		
				Then 
					( Select Case @sTypRet
								When 'CODE' Then '1530'
								Else sysadm.FN_CODE_NUM ( 1530, '-ET' )
							 End 
					) 				

-- [PM364-1] Si modif voir PS_U_PM364_DORMANT_AUTO
			-- Cas 0 : Si état sans suite et Si presta ECT et dte_rcp_frn is null alors Dormant
			When	 s.cod_etat = 900
				 And Exists (
						Select Top 1 1
						from sysadm.commande c1
						Where c1.id_sin = s.id_sin
						and c1.id_ref_four in ( 'A_REPARER', 'A_REPARER_SAV', 'A_DESOXYDER', 'A_DESOXYDER_SAV', 'CONTEST_SUR_REMPL', 'A_DIAGNOSTIQUER' )
						and c1.cod_etat = 'ECT' 
						and c1.dte_rcp_frn is null
						And c1.status_gc = 0 
					 )
				Then 
					( Select Case @sTypRet
								When 'CODE' Then '1550'
								Else sysadm.FN_CODE_NUM ( 1550, '-ET' )
							 End 
					) -- 'Dormant pour SPB'						 

			-- Cas 1 : Si presta ECT et dte_rcp_frn is null And cree_le > 2 mois => dormant						
			When Exists (
						Select Top 1 1
						from sysadm.commande c1
						Where c1.id_sin = s.id_sin
						and c1.id_ref_four in ( 'A_REPARER', 'A_REPARER_SAV', 'A_DESOXYDER', 'A_DESOXYDER_SAV', 'CONTEST_SUR_REMPL', 'A_DIAGNOSTIQUER' )
						and c1.cod_etat = 'ECT' 
						and c1.dte_rcp_frn is null
						And c1.status_gc = 0 
						And c1.cree_le < DateAdd ( Month, -2, getdate () ) 
					 )
				Then 
					( Select Case @sTypRet
								When 'CODE' Then '1550'
								Else sysadm.FN_CODE_NUM ( 1550, '-ET' )
							 End 
					) -- 'Dormant pour SPB'						 

			-- Cas 2 : Si Valide_le > 2 mois And cod_etat tech = 100 => dormant
			When	 s.valide_le < DateAdd ( Month, -2, getdate () )
				 And s.cod_etat = 100
				Then 
					( Select Case @sTypRet
								When 'CODE' Then '1550'
								Else sysadm.FN_CODE_NUM ( 1550, '-ET' )
							 End 
					) -- 'Dormant pour SPB'						 

-- /[PM364-1]
			When ( Exists ( 
					Select Top 1 1
					From   sysadm.gar_sin g
					Where  g.id_sin = s.id_sin
					And    g.cod_etat = 900 )
				   And
				   Not Exists ( 
					Select Top 1 1
					From   sysadm.gar_sin g
					Where  g.id_sin = s.id_sin
					And    g.cod_etat <> 900 )
				  )
				  Or  
				  ( 
				   IsNull ( 
					  ( Select count (*)
						From   sysadm.gar_sin g
						Where  g.id_sin = s.id_sin
					  ), 0 ) = 0
				   And 
				   s.cod_etat = 900 
				  )

				Then 
					( Select Case @sTypRet
								When 'CODE' Then '900'
								Else sysadm.FN_CODE_NUM ( 900, '-ET' )
							 End 
					) -- 'Sans suite'				

			When Exists ( 
					Select  Top 1 1
					From	sysadm.detail d,
							sysadm.div_det dd
					Where	d.id_sin = s.id_sin
					And	  	d.cod_etat = 100
					And		dd.id_sin = d.id_sin
					And		dd.id_gti = d.id_gti
					And		dd.id_detail = d.id_detail
					And		dd.nom_zone = 'pec'
					And		dd.val_car = 'O'
				   ) 
				   Then 
					( Select Case @sTypRet
								When 'CODE' Then '1540'
								Else sysadm.FN_CODE_NUM ( 1540, '-ET' )
							 End 
					) -- 'Pris en charge'


			Else Case @sTypRet
					When 'CODE' Then '100'
					Else sysadm.FN_CODE_NUM ( 100, '-ET' )
				 End 
		End							
From	sysadm.sinistre s
Where   s.id_sin = @dcIdSin

-- Cas de traitement additionnel au remplacement 1510
If @sLibEtatDos = 'Remplacé et clos pour l''assuré'
  Begin
	Declare @iIdSeqRemplMax Integer
	Declare @dtCreeLeAREPGTI DateTime

	Select @iIdSeqRemplMax = max ( c1.id_seq )
	from sysadm.commande c1,
			sysadm.sinistre s
	Where s.id_sin = @dcIdSin
	And	  c1.id_sin = s.id_sin
	and   c1.cod_etat <> 'ANN' 
	And   sysadm.FN_A_COMMANDER ( c1.id_sin, c1.id_seq, 'P' ) = 'A_COMMANDER'
	And   ( c1.status_gc in ( 178, 33 ) -- [VDOC21070]
			Or
			c1.id_typ_art = 'CAF'
			Or 
			( c1.status_gc = 0
				And 
				Len ( c1.id_serie_nouv ) > 0 
				And 
				Len ( c1.id_bon_transp ) > 0 
			)
		  )
	And   ( Len ( sysadm.FN_CLE_VAL ( 'PRBLE_LIVRAISON', c1.info_frn_spb_cplt, ';' ) ) <= 0
			Or 
			( 
				Len ( sysadm.FN_CLE_VAL ( 'PRBLE_LIVRAISON', c1.info_frn_spb_cplt, ';' ) ) > 0
				And
				sysadm.FN_CLE_VAL ( 'MAJ_ADRESSE', c1.info_spb_frn_cplt, ';' ) = 'OUI'
			)
		  )

	If @iIdSeqRemplMax is not null And @iIdSeqRemplMax > 0
	  Begin

		Select @dtCreeLeAREPGTI = Max ( c1.cree_le ) 
		from sysadm.commande c1,
			sysadm.sinistre s
		Where s.id_sin = @dcIdSin
		and c1.id_sin = s.id_sin
		and c1.id_seq > @iIdSeqRemplMax
		and c1.id_typ_art = 'PRS'		
		and c1.cod_etat <> 'ANN' 
		And ( ( sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', c1.info_spb_frn_cplt, ';' ) = 'OUI' And c1.status_gc in ( 21, 23 ) )
				Or 
  			  ( sysadm.FN_CLE_VAL ( 'CONTEST_SUR_REMPL', c1.info_spb_frn_cplt, ';' ) = 'OUI' And c1.status_gc = 151 )
			)

		If @dtCreeLeAREPGTI is not null
		   And 
		   Exists ( 
			Select Top 1 1
			From	 sysadm.reglement r,
					sysadm.reg_gti rg
			Where  r.id_sin = @dcIdSin
			And	 r.cod_inter = 'A'
			And	 r.cod_mot_reg = 'RN'
			And	 rg.id_sin = r.id_sin
			And  rg.id_reg = r.id_reg
			And  rg.id_gti > 0 
			And  r.cree_le > @dtCreeLeAREPGTI 
		   )
		   Begin
			 Select @sLibEtatDos = 
						Case @sTypRet
								When 'CODE' Then '1500'
								Else sysadm.FN_CODE_NUM ( 1500, '-ET' )
					    End 
					   -- 'Réglé et clos pour l''assuré
		   End 
	  End 
  End 

If @sLibEtatDos is null
	Begin
		Select @sLibEtatDos = sysadm.FN_LIB_ETAT_DOS ( @dcIdSin, @sTypRet )
	End 

If @sLibEtatDos is null 
	Begin
		Select @sLibEtatDos = 
				Case @sTypRet
						When 'CODE' Then '0'
						Else sysadm.FN_CODE_NUM ( 0, '-ET' )
				End 
	End 

Return ltrim ( rtrim ( @sLibEtatDos ))

End 
Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_AFF_DATE
-- Auteur               :       Fabry JF
-- Date                 :       30/05/2014
-- Libellé              :
-- Commentaires         :       Retourne l'état du dossier vu de l'assuré. Attention à l'utilisation ! le client doit passer une gti.
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_AFF_DATE' AND type = 'FN' )
        DROP function sysadm.FN_AFF_DATE
GO
CREATE  function sysadm.FN_AFF_DATE  (
        @dtDteTime    DateTime,
        @sCas		  VarChar ( 20 ) = 'SANS_HEURE'
		)
RETURNS VarChar ( 50 )
AS
Begin

Declare @sLibDate VarChar ( 50 )

If UPPER ( @sCas ) = 'AVEC_HEURE'
	Begin 
		Select @sLibDate = convert ( varchar(10), @dtDteTime, 103 ) + ' ' + CONVERT (varchar(8), @dtDteTime, 108)
	End
Else
	Begin
		Select @sLibDate = CONVERT ( VarChar ( 10 ), @dtDteTime, 103 )
	End 

Return IsNull ( ltrim ( rtrim ( @sLibDate )), '' )

End 
Go
 
--------------------------------------------------------------------
--
-- Fonction             :       FN_AFF_DATE_CLOTURE_ASS
-- Auteur               :       Fabry JF
-- Date                 :       14/08/2014
-- Libellé              :
-- Commentaires         :       Retourne la date de cloture du dossier
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_AFF_DATE_CLOTURE_ASS' AND type = 'FN' )
        DROP function sysadm.FN_AFF_DATE_CLOTURE_ASS
GO

CREATE  function sysadm.FN_AFF_DATE_CLOTURE_ASS  (
        @dcIdSin		  Decimal ( 10 ) -- [PI062]
		)
RETURNS VarChar ( 50 )
AS
Begin

	Return Convert ( VarChar, sysadm.FN_DTE_CLO ( @dcIdSin ), 103 )

End 
Go


--------------------------------------------------------------------
--
-- Fonction             :       FN_DTE_CLO
-- Auteur               :       Fabry JF
-- Date                 :       30/08/2016
-- Libellé              :
-- Commentaires         :       Retourne la date de cloture du dossier
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-- Le 24/11/2016 JFF Ajout de stat dans les dates de réparation.
-- JFF      12/02/2016   [PI062]
-- JFF      29/03/2021   [20210309] Gestion du cas du refus cree_le sur la 1ère validation dont la validation ne se fait pas le même jour que la création.
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_DTE_CLO' AND type = 'FN' )
        DROP function sysadm.FN_DTE_CLO
GO


CREATE  function sysadm.FN_DTE_CLO  (
        @dcIdSin		  Decimal ( 10 ) -- [PI062]
		)
RETURNS Datetime
AS
Begin


Declare @sLibDate VarChar ( 50 )
Declare @dtRempl  DateTime
Declare @dtRepa  DateTime
Declare @dtRegl   DateTime
Declare @dtRefus   DateTime
Declare @dtValide DateTime
Declare @dtDef DateTime
Declare @dtDteOuv DateTime

Select	@dtRempl = IsNull ( max ( c.dte_env_cli ), MAX ( cree_le ) )
From	sysadm.commande c
Where   c.id_sin = @dcIdSin
and     c.cod_etat <> 'ANN' 
And		sysadm.FN_A_COMMANDER ( c.id_sin, c.id_seq, 'P' ) = 'A_COMMANDER'

Set @dtDef = @dtRempl 

Select	@dtRepa = IsNull ( max ( c.dte_env_cli ), MAX ( cree_le ) )
From	sysadm.commande c
Where   c.id_sin = @dcIdSin
and		c.id_typ_art = 'PRS'
and     c.cod_etat <> 'ANN' 
and     c.status_gc in ( 2, 22, 31, 32, 21, 23, 30, 34 ) -- Le 24/11/2016, sur demande DSR, le KPI n'était pas bon à ce niveau.

If @dtRepa > @dtDef And @dtDef is not null and @dtRepa is not null Set @dtDef = @dtRepa
If @dtDef is null Set @dtDef = @dtRepa

Select  @dtRegl = MAX ( r.cree_le )
From	sysadm.reglement r,
		sysadm.reg_gti rg
Where	r.id_sin = @dcIdSin
And		r.cod_inter = 'A'
And		r.cod_mot_reg = 'RN'
And		rg.id_sin = r.id_sin
And		rg.id_reg = r.id_reg
And		rg.id_gti > 0 
-- And		rg.id_gti not in ( 8 )

If @dtRegl > @dtDef And @dtDef is not null and @dtRegl is not null Set @dtDef = @dtRegl
If @dtDef is null Set @dtDef = @dtRegl

Select	@dtRefus = min ( r.cree_le )
From	sysadm.sinistre s,
		sysadm.refus r
Where	s.id_sin = @dcIdSin
And		s.cod_etat = 200
And		r.id_sin = s.id_sin
And		( r.alt_mac = 'O' Or r.alt_ope = 'O' )

If @dtRefus > @dtDef And @dtDef is not null and @dtRefus is not null Set @dtDef = @dtRefus
If @dtDef is null Set @dtDef = @dtRefus

-- [20210309] On redresse éventuellement la date de cloture pour un refus
If @dtDef = @dtRefus And @dtRegl is null and @dtRepa is null and @dtRempl is null And @dtRefus is not null And @dtDef is not null
  Begin 
	Select @dtDteOuv = g.dte_ouv
	From sysadm.gar_sin g
	Where g.id_sin = @dcIdSin

	If @dtDef < @dtDteOuv And @dtDteOuv is not null and @dtDef is not null Set @dtDef = @dtDteOuv
  End 

Select	@dtValide = s.valide_le 
From	sysadm.sinistre s
Where	s.id_sin = @dcIdSin
And		s.cod_etat in ( 900 )

If @dtValide > @dtDef And @dtDef is not null and @dtValide is not null Set @dtDef = @dtValide
If @dtDef is null Set @dtDef = @dtValide

Return @dtDef

End 
Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_A_COMMANDER
-- Auteur               :       Fabry JF
-- Date                 :       14/08/2014
-- Libellé              :
-- Commentaires         :       Retourne 'A_COMMANDER' s'il s'agit d'une commande de remplacement
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
-- JFF	22/04/2015	[VDOC16311]
-- JFF  08/08/2016  Sur remonté de samira, le cas DTY/PRS/33 doit aussi répondre
-- JFF      12/02/2016   [PI062]
-- JFF  04/10/2017 Swap SBE
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_A_COMMANDER' AND type = 'FN' )
        DROP function sysadm.FN_A_COMMANDER
GO

CREATE  function sysadm.FN_A_COMMANDER (
        @dcIdSin		  Decimal ( 10 ), -- [PI062]
        @dcIdSeq		  integer,
        @sTable			  VarChar ( 1 ) = null
		)
RETURNS VarChar ( 50 )
AS
Begin

Declare @sACommander Varchar ( 30 )
 
Set @sACommander = ''
If Upper ( @sTable ) = 'W'
 Begin
	If 	Exists (
			Select 1
			from sysadm.w_commande c with (nolock)
			Where c.id_sin = @dcIdSin
			And	  c.id_seq = @dcIdSeq
			and ( c.id_typ_art not in ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' )		
				  Or 
				  ( c.id_typ_art in ( 'RST' ) And sysadm.FN_CLE_VAL ( 'RST_CMDE+SUIVI', rtrim ( c.info_spb_frn_cplt), ';'  ) = 'OUI' )
				  Or 
				  ( c.id_gti = 10 And sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( c.info_spb_frn_cplt), ';' ) = 'PRET' And id_typ_art <> 'REL' ) -- prêt anticipé Orange V3
				  Or
				  ( c.id_ref_four = 'DECISION_SPB' And c.info_spb_frn = 970 )
				  Or 
				  ( c.id_four = 'DTY' And c.id_typ_art = 'PRS' and status_gc = 33 )
				  Or 
				  ( charindex ( 'SWAP', sysadm.FN_CLE_VAL (  'TYPE_SWAP', c.info_frn_spb_cplt, ';' ) ) > 0 ) -- JFF 04/10/2017
				  Or
				  ( c.id_four = 'CAR' )
				)
			)
		Begin
			Set @sACommander = 'A_COMMANDER'
		End 
 End
Else 
 Begin
	If 	Exists (
			Select 1
			from sysadm.commande c with (nolock)
			Where c.id_sin = @dcIdSin
			And	  c.id_seq = @dcIdSeq
			and ( c.id_typ_art not in ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' )		
				  Or 
				  ( c.id_typ_art in ( 'RST' ) And sysadm.FN_CLE_VAL ( 'RST_CMDE+SUIVI', rtrim ( c.info_spb_frn_cplt), ';'  ) = 'OUI' )
				  Or 
				  ( c.id_gti = 10 And sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( c.info_spb_frn_cplt), ';' ) = 'PRET' And id_typ_art <> 'REL' ) -- prêt anticipé Orange V3
				  Or
				  ( c.id_ref_four = 'DECISION_SPB' And c.info_spb_frn = 970 )
				  Or 
				  ( c.id_four = 'DTY' And c.id_typ_art = 'PRS' and status_gc = 33 )
				  Or 
				  ( charindex ( 'SWAP', sysadm.FN_CLE_VAL (  'TYPE_SWAP', c.info_frn_spb_cplt, ';' ) ) > 0 ) -- JFF 04/10/2017
				  Or
				  ( c.id_four = 'CAR' )
				)
			)
		Begin
			Set @sACommander = 'A_COMMANDER'
		End 
  End
Return @sACommander

End 
Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_GET_ETAT_GARANTIE_PM251
-- Auteur               :       Fabry JF
-- Date                 :       02/12/2014
-- Libellé              :		[PM251-2]
-- Commentaires         :       Attention fonction réservée au PM251, mes contrôles sont restreint parce que lancés en amont
--							    Ne pas utiliser cette fonction en dehors du PM251-2, le retour ne serait pas forcément bon.
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- [20251016131853440][JFF][MIG147]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_ETAT_GARANTIE_PM251' AND type = 'FN' )
        DROP function sysadm.FN_GET_ETAT_GARANTIE_PM251
GO

CREATE  function sysadm.FN_GET_ETAT_GARANTIE_PM251 (
        @dcIdSin		Decimal ( 10 ), -- [PI062]
        @dcIdGti		Decimal ( 7 ),
		@sTable			VarChar ( 1 )
		)
RETURNS Integer
AS
Begin

Declare @iCodEtatGti Integer
Declare @iCodEtat100 Integer
Declare @iCodEtat200 Integer
Declare @iCodEtat600 Integer
Declare @iCodEtat500 Integer
Declare @iCodEtat900 Integer
Declare @iCodEtat1 Integer

If @sTable = 'P' 
 Begin
	Select @iCodEtat500 = Sum ( Case cod_etat When 500 Then 1 Else 0 End ) ,
   		   @iCodEtat600 = Sum ( Case cod_etat When 600 Then 1 Else 0 End ),
		   @iCodEtat100 = Sum ( Case cod_etat When 100 Then 1 Else 0 End ),
		   @iCodEtat200 = Sum ( Case cod_etat When 200 Then 1 Else 0 End ),
		   @iCodEtat900 = Sum ( Case cod_etat When 900 Then 1 Else 0 End ) 
	From   sysadm.detail d
	Where  d.id_sin = @dcIdSin
	And	   d.id_gti = @dcIdGti

	If Not Exists ( Select Top 1 1 From sysadm.detail where id_sin = @dcIdSin ) Set @iCodEtat100 = 1 -- Pour fonctionner si aucun détail présent -- [20251016131853440][JFF][MIG147]

 End 
Else
 Begin
	Select @iCodEtat500 = Sum ( Case cod_etat When 500 Then 1 Else 0 End ) ,
   		   @iCodEtat600 = Sum ( Case cod_etat When 600 Then 1 Else 0 End ),
		   @iCodEtat100 = Sum ( Case cod_etat When 100 Then 1 Else 0 End ),
		   @iCodEtat200 = Sum ( Case cod_etat When 200 Then 1 Else 0 End ),
		   @iCodEtat900 = Sum ( Case cod_etat When 900 Then 1 Else 0 End ) 
	From   sysadm.w_detail wd
	Where  wd.id_sin = @dcIdSin
	And	   wd.id_gti = @dcIdGti
	
	If Not Exists ( Select Top 1 1 From sysadm.w_detail where id_sin = @dcIdSin ) Set @iCodEtat100 = 1 -- Pour fonctionner si aucun détail présent -- [20251016131853440][JFF][MIG147]
 End



If ( @iCodEtat600 > 0 Or @iCodEtat500 > 0 ) And @iCodEtat100 > 0 
	Begin
		Set @iCodEtatGti = 550
		Return @iCodEtatGti 
	End 
		
If ( @iCodEtat600 > 0 Or @iCodEtat500 > 0 ) And ( @iCodEtat200 > 0 Or @iCodEtat900 >0 )
	Begin
		Set @iCodEtatGti = 600
		Return @iCodEtatGti 
	End 

If @iCodEtat200 > 0 
	Begin
		Set @iCodEtatGti = 200
		Return @iCodEtatGti 
	End 

If @iCodEtat600 > 0 Or @iCodEtat500 > 0 
	Begin
		Set @iCodEtatGti = 600
		Return @iCodEtatGti 
	End 

If @iCodEtat900 > 0 
	Begin
		Set @iCodEtatGti = 900
		Return @iCodEtatGti 
	End 

If @iCodEtat100 > 0 
	Begin
		Set @iCodEtatGti = 100
		Return @iCodEtatGti 
	End 

Return @iCodEtatGti 

End 

Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_GET_ETAT_DOSSIER_PM251
-- Auteur               :       Fabry JF
-- Date                 :       02/12/2014
-- Libellé              :		[PM251-2]
-- Commentaires         :       Attention fonction réservée au PM251, mes contrôles sont restreint parce que lancés en amont
--							    Ne pas utiliser cette fonction en dehors du PM251-2, le retour ne serait pas forcément bon.
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_ETAT_DOSSIER_PM251' AND type = 'FN' )
        DROP function sysadm.FN_GET_ETAT_DOSSIER_PM251
GO

CREATE  function sysadm.FN_GET_ETAT_DOSSIER_PM251 (
        @dcIdSin		Decimal ( 10 ), -- [PI062]
		@sTable			VarChar ( 1 )
		)
RETURNS Integer
AS
Begin

Declare @iCodEtatGtiEnCours Integer
Declare @iCodEtatSin Integer
Declare @iCodEtat100 Integer
Declare @iCodEtat200 Integer
Declare @iCodEtat600 Integer
Declare @iCodEtat500 Integer
Declare @iCodEtat550 Integer
Declare @iCodEtat900 Integer

If @sTable = 'P' 
 Begin
	Select @iCodEtat500 = Sum ( Case When cod_etat = 500 Then 1 Else 0 End ) ,
		   @iCodEtat550 = Sum ( Case When cod_etat = 550 Then 1 Else 0 End ) ,
   		   @iCodEtat600 = Sum ( Case When cod_etat = 600 Then 1 Else 0 End ),
		   @iCodEtat100 = Sum ( Case When cod_etat = 100 Then 1 Else 0 End ),
		   @iCodEtat200 = Sum ( Case When cod_etat = 200 Then 1 Else 0 End ),
		   @iCodEtat900 = Sum ( Case When cod_etat = 900 Then 1 Else 0 End )
	From   sysadm.gar_sin g
	Where  g.id_sin = @dcIdSin
 End 
Else 
 Begin
	Select @iCodEtat500 = Sum ( Case When cod_etat = 500 Then 1 Else 0 End ) ,
		   @iCodEtat550 = Sum ( Case When cod_etat = 550 Then 1 Else 0 End ) ,
   		   @iCodEtat600 = Sum ( Case When cod_etat = 600 Then 1 Else 0 End ),
		   @iCodEtat100 = Sum ( Case When cod_etat = 100 Then 1 Else 0 End ),
		   @iCodEtat200 = Sum ( Case When cod_etat = 200 Then 1 Else 0 End ),
		   @iCodEtat900 = Sum ( Case When cod_etat = 900 Then 1 Else 0 End )
	From   sysadm.w_gar_sin wg
	Where  wg.id_sin = @dcIdSin
 End

If ( @iCodEtat600 > 0 Or @iCodEtat500 > 0 Or @iCodEtat550 > 0 ) And @iCodEtat100 > 0 
	Begin
		Set @iCodEtatSin = 550
		Return @iCodEtatSin 
	End 
		
If ( @iCodEtat600 > 0 Or @iCodEtat500 > 0 Or @iCodEtat550 > 0 ) And ( @iCodEtat200 > 0 Or @iCodEtat900 >0 )
	Begin
		Set @iCodEtatSin = 600
		Return @iCodEtatSin 
	End 

If @iCodEtat200 > 0 
	Begin
		Set @iCodEtatSin = 200
		Return @iCodEtatSin 
	End 

If @iCodEtat600 > 0 
	Begin
		Set @iCodEtatSin = 600
		Return @iCodEtatSin 
	End 

If @iCodEtat550 > 0 
	Begin
		Set @iCodEtatSin = 550
		Return @iCodEtatSin 
	End 


If @iCodEtat900 > 0 
	Begin
		Set @iCodEtatSin = 900
		Return @iCodEtatSin 
	End 


If @iCodEtat100 > 0 
	Begin
		Set @iCodEtatSin = 100
		Return @iCodEtatSin 
	End 


Return @iCodEtatSin 

End 

Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_GET_PERIODE_TRT
-- Auteur               :       Fabry JF
-- Date                 :       09/03/2016
-- Libellé              :		[VDOC17042]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_PERIODE_TRT' AND type = 'FN' )
        DROP function sysadm.FN_GET_PERIODE_TRT
Go

CREATE FUNCTION sysadm.FN_GET_PERIODE_TRT (@dtDate datetime) 
RETURNS varchar(6)
AS
Begin
	Declare @dtPivot1 datetime,
		@dtPivot2 datetime,
		@sRet varchar(6)
		
	Set @dtPivot1=CONVERT(datetime,'26/01/2015',103)
	
	if @dtDate < @dtPivot1
	Begin
		If Day ( @dtDate ) between 1 and 25
			Set @sRet=Convert ( Varchar (4), Year ( @dtDate) ) + 
                        Right ( '0' + Convert ( Varchar (2), Month ( @dtDate )), 2)
        Else
	        Set @sRet=Convert ( Varchar (4), 
                                Case
                                        When Month (@dtDate) + 1 > 12 Then Year ( @dtDate ) + 1 
                                        Else Year ( @dtDate ) 
                                End 
                                )
                        + 
                        Right ( '0' + Convert ( Varchar (2), 
                                Case
                                        When Month ( @dtDate) + 1 > 12 Then 1
                                        Else Month ( @dtDate) + 1
                                End ) , 2)
    End	
	Else
	Begin
		Set @dtPivot2=CONVERT(datetime,'01/02/2015',103)
	
		if @dtDate < @dtPivot2
			Set @sRet='201502'
		Else
			Set @sRet=Convert ( Varchar (4), Year ( @dtDate) ) + 
                        Right ( '0' + Convert ( Varchar (2), Month ( @dtDate )), 2)
    End
    
    Return @sRet               
End
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_MAIL_RAPPORT_SIM
-- Auteur               :       FPI - 19/06/2015
-- Libelle              :		
-- Commentaires         :       Envoi un rapport quotidien de l'exécution du param en simulation/recette
--
-- References           :		
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_MAIL_RAPPORT_SIM' AND type = 'P' ) 
        DROP procedure sysadm.PS_MAIL_RAPPORT_SIM
GO

CREATE PROCEDURE sysadm.PS_MAIL_RAPPORT_SIM(
	@nomFichier varchar(255)
) 
As
Declare @sCmd varchar(max)

create table #tmp_FPI (ligne varchar(max))

Set @sCmd='BULK INSERT #tmp_FPI FROM ''' + @nomFichier + ''' WITH (' +
	'CODEPAGE=''ACP'', ROWTERMINATOR = ''\n'')'

exec (@sCmd)

declare @retLigne varchar(4)
declare @contenuFichier varchar(max)
declare @mailObjet varchar(255)
declare @sRetourErrMail varchar(255)

Set @mailObjet='Param quotidien ' + DB_NAME(db_id()) + ' (' + @@SERVERNAME + ') ' + convert(varchar(10),getdate(),103)
set @retLigne=char(10) + char(13)

select @contenuFichier=(select ligne from #tmp_FPI for xml path (''))
Set @contenuFichier=replace(replace(@contenuFichier,'<ligne>',''),'</ligne>',@retLigne)
Set @contenuFichier=Replace(@contenuFichier,' &#x20;','')

drop table #tmp_FPI

if charindex('Msg',@contenuFichier) > 0 
Begin
	Set @mailObjet = @mailObjet + ' - Erreur' 
End
Else Set @mailObjet = @mailObjet + ' - OK' 

EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, 'fpinon@spb.eu,jff@spb.eu',@contenuFichier, @mailObjet

Go

grant execute on sysadm.PS_MAIL_RAPPORT_SIM to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Fonction             :       FN_GET_DIV_SIN
-- Auteur               :       Fabry JF
-- Date                 :       26/04/2016
-- Libellé              :		
-- Commentaires         :       Ramène une donnée de Div_Sin
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_DIV_SIN' AND type = 'FN' )
        DROP function sysadm.FN_GET_DIV_SIN
GO

CREATE  function sysadm.FN_GET_DIV_SIN (
        @dcIdSin		Decimal ( 10 ), -- [PI062]
		@sNomZone		VarChar ( 50 ),
		@sTable			VarChar ( 1 ),
		@sChaineBcv		VarChar ( 50 )
		)
RETURNS VarChar ( 50 )
AS
Begin

	Declare @sValeur Varchar ( 50 )

	If @sTable = 'P' 
		Begin
			Select	@sValeur = Case id_typ_zone 
									When 'C' Then sysadm.FN_TRIM ( ds.val_car )
									When 'D' Then sysadm.FN_AFF_DATE ( ds.val_dte, 'SH' )
									When 'LC' Then 
										Case sysadm.FN_CLE_VAL ( 'RETOUR', @sChaineBcv, ';' )
											When 'CODE' Then ds.val_car
											Else sysadm.FN_TRIM ( sysadm.FN_CODE_CAR ( ds.val_car, ds.id_typ_liste ) )
										End 
									When 'LN' Then 
										Case sysadm.FN_CLE_VAL ( 'RETOUR', @sChaineBcv, ';' )
											When 'CODE' Then Convert  ( VarChar ( 35), ds.val_nbre )
											Else Convert  ( VarChar ( 35), sysadm.FN_CODE_NUM ( ds.val_nbre, ds.id_typ_liste ))
										End 
									When 'N' Then Convert  ( VarChar ( 35), ds.val_nbre )
									When 'P' Then Convert  ( VarChar ( 35), ds.val_mt )
									When 'S' Then Convert  ( VarChar ( 35), ds.val_mt )
									When 'X' Then sysadm.FN_TRIM ( ds.val_car )
							   End 
			From	sysadm.div_sin ds
			Where	ds.id_sin = @dcIdSin
			And		ds.nom_zone = lower  ( @sNomZone ) 
		End 

	If @sTable = 'W' 
		Begin
			Select	@sValeur = Case id_typ_zone 
									When 'C' Then sysadm.FN_TRIM ( ds.val_car )
									When 'D' Then sysadm.FN_AFF_DATE ( ds.val_dte, 'SH' )
									When 'LC' Then 
										Case sysadm.FN_CLE_VAL ( 'RETOUR', @sChaineBcv, ';' )
											When 'CODE' Then ds.val_car
											Else sysadm.FN_TRIM ( sysadm.FN_CODE_CAR ( ds.val_car, ds.id_typ_liste ) )
										End 
									When 'LN' Then 
										Case sysadm.FN_CLE_VAL ( 'RETOUR', @sChaineBcv, ';' )
											When 'CODE' Then Convert  ( VarChar ( 35), ds.val_nbre )
											Else Convert  ( VarChar ( 35), sysadm.FN_CODE_NUM ( ds.val_nbre, ds.id_typ_liste ))
										End 
									When 'N' Then Convert  ( VarChar ( 35), ds.val_nbre )
									When 'P' Then Convert  ( VarChar ( 35), ds.val_mt )
									When 'S' Then Convert  ( VarChar ( 35), ds.val_mt )
									When 'X' Then sysadm.FN_TRIM ( ds.val_car )
							   End 
			From	sysadm.w_div_sin ds
			Where	ds.id_sin = @dcIdSin
			And		ds.nom_zone = lower  ( @sNomZone ) 
		End 

	If @sValeur is null Set @sValeur = ''

	Return @sValeur 

End 

Go

grant execute on sysadm.FN_GET_DIV_SIN to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Fonction             :       PS_FILE_EXISTS
-- Auteur               :       FPI
-- Date                 :       19/09/2016
-- Libellé              :		
-- Commentaires         :       Teste l'existence d'un fichier
-- Références           :       
--
-- Arguments            :       filename : nom du fichier
--
-- Retourne             :       -1 fichier absent, 0 fichier vide, 1 fichier avec au moins une ligne
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_FILE_EXISTS' AND type = 'P' )
        DROP Procedure sysadm.PS_FILE_EXISTS
Go

CREATE PROCEDURE sysadm.PS_FILE_EXISTS 
	@filename varchar(255)
AS
declare @recordsep varchar(4) = char(10);


declare @Lines table (
    line varchar(8000)
);

declare @sql varchar(8000) = ' 
    create table #tmp (
        line varchar(8000)
    );

    bulk insert #tmp
        from '''+@filename+'''
        with (FirstRow = 1, RowTerminator = '''+@recordsep+''', CODEPAGE = ''1252'', LastRow=1);

    select * from #tmp';

Begin try
insert into @Lines
    exec(@sql);
End try
Begin Catch
	Return -1 -- Le fichier n'existe pas
End Catch

Return (select count(*) from @Lines) 

Go

grant execute on sysadm.PS_FILE_EXISTS to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Fonction             :       FN_LIB_GROUPE
-- Auteur               :       Fabry JF
-- Date                 :       11/01/2017
-- Libellé              :
-- Commentaires         :       Retourne le contractant
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_LIB_GROUPE' AND type = 'FN' )
        DROP function sysadm.FN_LIB_GROUPE
GO


CREATE  function sysadm.FN_LIB_GROUPE  (
        @dcIdSin    Decimal (10) ) -- [PI062]
RETURNS VarChar ( 35 )
AS

Begin

Declare @sLibGrp VarChar (  35 )

Select	Top 1
		@sLibGrp = g.lib_grp
From	sysadm.sinistre s,
		sysadm.produit p,
		sysadm.groupe g
where	s.id_sin = @dcIdSin
And		p.id_prod = s.id_prod
And		g.id_grp = p.id_grp

if @sLibGrp is null Set @sLibGrp = ''

Return @sLibGrp

End 

GO


--------------------------------------------------------------------
--
-- Fonction             :       FN_EPURE_CHAINE
-- Auteur               :       Fabry JF
-- Date                 :       20/01/2017
-- Libellé              :
-- Commentaires         :       Epure une chaine des caractères spéciaux
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      17/09/2021   ajout du "
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_EPURE_CHAINE_V02' AND type = 'FN' )
        DROP function sysadm.FN_EPURE_CHAINE_V02
GO


CREATE  function sysadm.FN_EPURE_CHAINE_V02  (
        @sChaine    VarChar ( 1000) ,
		@sCas		Varchar ( 50 ) ) -- Aucun cas = Fonctionnement natif remplacements des tous les caractères spéciaux
									 -- 'EXCL_SLASHX2' = Exclusion des 2 slash (slash et antislash), ils ne seront pas supprimés.
									 -- 'JUSTE_RC_TAB_DQ' = Suppression uniquements des Retour Chariot (bref tous les sauts), ainsi que la Tabulation, et le double quot
									 -- 'NATIF&RC_TAB_DQ' = Fonctionnement Natif avec en plus le cas JUSTE_RC_TAB_DQ
RETURNS VarChar ( 1000 )
AS

Begin

Declare @sCarSpeciaux VarChar (100)
Declare @sCarRemplace VarChar (100)
Declare @iCpt Integer
Declare @iTot Integer

If @sCas is null Set @sCas = ''

If @sCas = 'JUSTE_RC_TAB_DQ' Or @sCas = 'NATIF&RC_TAB_DQ' 
 Begin
	Set @sChaine = 	Replace ( Replace ( Replace ( Replace ( Replace ( 
					Replace ( rtrim ( @sChaine ), '''', ' ' ), 
					char ( 13 ), ' ' ),
					char ( 10 ), ' ' ),
					char ( 9 ), ' ' ),
					char ( 11 ), ' ' ),
					'"', ' ' )
					
	If @sCas = 'JUSTE_RC_TAB_DQ' 
	  Begin
	    Return @sChaine
	  End 
 End 

Set @sCarSpeciaux ='àèìòùÀÈÌÒÙ äëïöüÄËÏÖÜ âêîôûÂÊÎÔÛ áéíóúÁÉÍÓÚðÐýÝ ãñõÃÑÕšŠžŽçÇåÅøØ *^£¨ °\/"	'
Set @sCarRemplace ='aeiouAEIOU aeiouAEIOU aeiouAEIOU aeiouAEIOUdDyY anoANOsSzZcCaAoO         " '

If @sCas = 'EXCL_SLASHX2' 
  Begin
	Set @sCarSpeciaux ='àèìòùÀÈÌÒÙ äëïöüÄËÏÖÜ âêîôûÂÊÎÔÛ áéíóúÁÉÍÓÚðÐýÝ ãñõÃÑÕšŠžŽçÇåÅøØ *^£¨ °"	'
	Set @sCarRemplace ='aeiouAEIOU aeiouAEIOU aeiouAEIOU aeiouAEIOUdDyY anoANOsSzZcCaAoO         '
  End 

Set @iTot = Len ( @sCarSpeciaux )

Set @sChaine = rtrim ( ltrim ( @sChaine ))

If @sChaine is null Return @sChaine 
If Len ( @sChaine ) = 0 Return @sChaine 

Set @iCpt =1
While @iCpt <= @iTot
 Begin
	Set @sChaine = Replace ( @sChaine, SubString ( @sCarSpeciaux, @iCpt, 1) , SubString ( @sCarRemplace, @iCpt, 1) )
	Set @iCpt = @iCpt + 1
 End 

Return @sChaine

End 

GO

--------------------------------------------------------------------
--
-- Fonction             :       FN_DTE_1ER_REGL
-- Auteur               :       Fabry JF
-- Date                 :       01/02/2017
-- Libellé              :
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_DTE_1ER_REGL' AND type = 'FN' )
        DROP function sysadm.FN_DTE_1ER_REGL
GO

CREATE  function sysadm.FN_DTE_1ER_REGL  (
        @dcIdSin    Decimal (10) ) -- [PI062]
RETURNS DateTime
AS

Begin

Declare @dtDte1erRegl Datetime

Select @dtDte1erRegl = min ( r.cree_le ) 
From sysadm.reglement r
Where r.id_sin = @dcIdSin
And   r.cod_mot_reg = 'RN' 

Return @dtDte1erRegl

End 

GO

--------------------------------------------------------------------
--
-- Fonction             :       FN_SOM_REGL
-- Auteur               :       Fabry JF
-- Date                 :       01/02/2017
-- Libellé              :
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_SOM_REGL' AND type = 'FN' )
        DROP function sysadm.FN_SOM_REGL
GO


CREATE  function sysadm.FN_SOM_REGL  (
        @dcIdSin    Decimal (10) ) -- [PI062]
RETURNS Decimal ( 11, 2 )
AS

Begin

Declare @dcSomRegl Decimal ( 11, 2 )

Select @dcSomRegl = sum ( mt_tot_reg ) 
From sysadm.reglement r
Where r.id_sin = @dcIdSin
And   r.cod_mot_reg not in ( 'RI' )

If @dcSomRegl is null Set @dcSomRegl = 0

Return @dcSomRegl

End 

GO

--------------------------------------------------------------------
--
-- Fonction             :       FN_DEM_RCP_PIECE
-- Auteur               :       Fabry JF
-- Date                 :       01/02/2017
-- Libellé              :
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_DEM_RCP_PIECE' AND type = 'FN' )
        DROP function sysadm.FN_DEM_RCP_PIECE
GO


CREATE  function sysadm.FN_DEM_RCP_PIECE  (
        @dcIdSin    Decimal (10) ) -- [PI062]
RETURNS VarChar ( 255 )
AS

Begin

Declare @sDemRcpPiec Varchar ( 255) 

Select @sDemRcpPiec  = Stuff ( ( 
	SELECT CAST(
				' / ' +
				'code pièce ' + Convert ( varchar ( 10), p.id_pce ) + ', ' +
				'lib pièce ' + sysadm.FN_CODE_NUM ( p.id_pce, '+PC' ) + ', ' +
				'date dem pce : ' + sysadm.FN_AFF_DATE ( p.dte_demande, 'SH' ) + ', ' +
				'date rcp pce : ' + IsNull ( NullIf ( sysadm.FN_AFF_DATE ( p.dte_reception , 'SH' ), '' ) , 'non réceptionnée')
			AS VARCHAR(250)) 
	From sysadm.piece_histo p
	Where p.id_sin = @dcIdSin
	For XML PATH ('') 
) , 1, 3, '' ) 

If @sDemRcpPiec is Null Set @sDemRcpPiec = 'Pas de pièce ou impossibilité de les retrouver'


Return @sDemRcpPiec

End 

GO

--------------------------------------------------------------------
--
-- Fonction             :       FN_EVT_REMPL
-- Auteur               :       Fabry JF
-- Date                 :       17/03/2017
-- Libellé              :
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_EVT_REMPL' AND type = 'FN' )
        DROP function sysadm.FN_EVT_REMPL
GO
CREATE  function sysadm.FN_EVT_REMPL  (
        @adcIdSin    Decimal (10), 
		@adcIdProd	Decimal ( 7 ),
		@adcIdGti	Decimal ( 7 )
		)
RETURNS Decimal ( 7 )
AS
Begin

Declare @dcIdEvt Decimal ( 7 )

If @adcIdProd is null 
  Begin
	( Select @adcIdProd = s.id_prod
	  From   sysadm.sinistre s
	  Where  s.id_sin = @adcIdSin )
  End

If @adcIdProd is null Return @dcIdEvt

Select Top 1 @dcIdEvt = cc.id_code
From   sysadm.code_condition cc
Where  cc.id_prod = @adcIdProd
And    cc.id_gti = @adcIdGti
And    cc.id_typ_code = '+EV'
And    cc.id_code = 841

If @dcIdEvt is null 
 Begin
	Select Top 1 @dcIdEvt = cc.id_code
	From   sysadm.code_condition cc
	Where  cc.id_prod = @adcIdProd
	And    cc.id_gti = @adcIdGti
	And    cc.id_typ_code = '+EV'
	And    cc.id_code = 936
 End 

If @dcIdEvt is null Return @dcIdEvt

Return @dcIdEvt

End 

--------------------------------------------------------------------
--
-- Fonction             :       FN_CTRLE_ADR_MAIL
-- Auteur               :       Fabry JF
-- Date                 :       20/09/2017
-- Libellé              :
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_CTRLE_ADR_MAIL' AND type = 'FN' )
        DROP function sysadm.FN_CTRLE_ADR_MAIL
GO
CREATE  function sysadm.FN_CTRLE_ADR_MAIL  (
        @sAdrMail Varchar ( 200 )
		)
RETURNS Integer
AS
Begin

Declare @iRet Integer 
Declare @iArobase Integer 
Declare @iCpt Integer 
Declare @sCar VarChar (1)

Set @iRet = 1 -- Valide par défaut

Set @sAdrMail = lTrim ( rTrim ( @sAdrMail ))
If @sAdrMail is null Or Len ( @sAdrMail ) <= 0 Return 1 -- Valide si vide

-- Au moins @
Set @iArobase = CharIndex ( '@', @sAdrMail )
If @iArobase  <= 0 Return -1 

-- Mais un seul @
Set @iArobase = CharIndex ( '@', @sAdrMail, @iArobase + 1 )
If @iArobase  > 0 Return -1 

-- Contrôle des points
If Left( @sAdrMail, 1 ) = '.' Return -1 
If Right ( @sAdrMail, 1 ) = '.' Return -1 
If CharIndex ( '.@',@sAdrMail ) > 0 Return -1 
If CharIndex ( '@.',@sAdrMail ) > 0 Return -1 
If CharIndex ( '..',@sAdrMail ) > 0 Return -1 

-- Caractères autorisés
Set @iCpt = 1
While  @iCpt <= Len ( @sAdrMail )
 Begin
   Set @sCar = Substring ( @sAdrMail, @iCpt, 1 ) 

   If Not ( 
		( Ascii ( @sCar ) >= 48 And Ascii ( @sCar ) <= 57 ) Or 
		( Ascii ( @sCar ) >= 65 And Ascii ( @sCar ) <= 90 ) Or 
		( Ascii ( @sCar ) >= 97 And Ascii ( @sCar ) <= 122 ) Or
		@sCar = '.' Or 
		@sCar = '@' Or 
		@sCar = '_' Or 
		@sCar = '-'
	  )
	  Begin
		Return -1 
	  End 

	Set @iCpt = @iCpt + 1

 End 

-- Caractères non autorisé
If CharIndex ( '_', @sAdrMail, CharIndex ( '@', @sAdrMail ) + 1 ) > 0 Return -1

Return @iRet 

End 

Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_DECRYPTE_NUM_CARTE
-- Auteur               :       Fabry JF
-- Date                 :       22/08/2019
-- Libellé              :
-- Commentaires         :       Reçois un numéro de carte avec des 'X' et renvoie un numéro de carte Valide.
-- Références           :       
--
-- Arguments            :       le début de la carte de 0 à 16 chiffres possibles
--				Ex : Select sysadm.FN_DECRYPTE_NUM_CARTE ( '352003XXXXXX1487', GetDate() )
--				     
--
-- Retourne             :       Rien
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_DECRYPTE_NUM_CARTE' AND type = 'FN' )
        DROP function sysadm.FN_DECRYPTE_NUM_CARTE
Go

CREATE  function sysadm.FN_DECRYPTE_NUM_CARTE
       ( @asRacine        VarChar ( 16 ),
	     @asValSubst	  VarChar ( 1 ),
	     @dtGetDate       DateTime )
RETURNS Varchar(16)

AS

Begin
  Declare @iRechX Int
  Declare @iRech2X Int
  Declare @sValAleat Varchar ( 2 )
  Declare @iCpt Integer

  Set @asValSubst = LTRIM ( Rtrim ( UPPER ( @asValSubst )))
  Set @asRacine = LTRIM ( Rtrim ( UPPER ( @asRacine )))

  Set @sValAleat = Right ( Convert ( varchar (24) , GETDATE() ,14 ), 1 ) 

  -- Remplacement des X et mémorisation de l'emplacement du premier X
  Set @iRechX = CharIndex ( @asValSubst, @asRacine ) 

  -- Pas de X trouvé donc on renvoie au mieux un numéro corrigé
  IF @iRechX <= 0 Return sysadm.FN_CORR_NUM_CARTE ( @asRacine, @dtGetDate )

  -- On remplace les X par la valeur
  Set @asRacine = Replace ( @asRacine, @asValSubst, @sValAleat )

  -- On fait tourner au plus 10 fois en faisant varier la valeur à l'emplacement du premier X, 
  -- On tombera forcément sur un num valide

  Set @iCpt = 1
  While @iCpt <= 12
    Begin
		If @asRacine = sysadm.FN_CORR_NUM_CARTE ( @asRacine, @dtGetDate )
		  Begin
			Break
		  End 
		Set @sValAleat = Convert ( varchar, Convert ( integer, @sValAleat ) + 1 ) 
		If Convert ( integer, @sValAleat ) >= 10 Set @sValAleat = '0'
		
		Set @asRacine = Left ( @asRacine, @iRechX - 1 ) + @sValAleat + Right ( @asRacine, len ( @asRacine ) - @iRechX )  

		Set @iCpt = @iCpt + 1

	End 

  Return @asRacine

End
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_DECRYPTE_NUM_CARTE
-- Auteur               :       Fabry JF
-- Date                 :       22/08/2019
-- Libellé              :
-- Commentaires         :       Reçois un numéro de carte avec des 'X' et renvoie un numéro de carte Valide.
-- Références           :       
--
-- Arguments            :       le début de la carte de 0 à 16 chiffres possibles
--				Ex : Select sysadm.FN_DECRYPTE_NUM_CARTE ( '352003XXXXXX1487', GetDate() )
--				     
--
-- Retourne             :       Rien
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_DECRYPTE_NUM_CARTE' AND type = 'P' )
        DROP procedure sysadm.PS_DECRYPTE_NUM_CARTE
GO

CREATE procedure sysadm.PS_DECRYPTE_NUM_CARTE
         @asRacine        VarChar ( 16 ) OUTPUT,
	     @asValSubst	  VarChar ( 1 )
AS

Set NoCount On

Set  @asRacine = sysadm.FN_DECRYPTE_NUM_CARTE ( @asRacine, @asValSubst, getdate() )

Select @asRacine 

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_CASSER_REGLE_CHAINE
-- Auteur               :       Fabry JF
-- Date                 :       20/02/2019
-- Libellé              :
-- Commentaires         :       Casse une chaine de façon aléatoire en mettant un '_' sur chaque mot.
--                              utile pour éviter aux destinaires de certains mails de créer des règles... :)
-- Références           :       
--
-- Arguments            :       @asChaine			 VarChar ( 2000 ),  Chaine à casser
--								@asCarCasse			 VarChar ( 10 ),    Chaine de de casse
--								@asCarSepMot		 VarChar ( 1 )      Séparateur de mot (1 car max)
--				     
--
-- Retourne             :       Rien
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CASSER_REGLE_CHAINE' AND type = 'P' )
        DROP procedure sysadm.PS_CASSER_REGLE_CHAINE
GO

CREATE procedure sysadm.PS_CASSER_REGLE_CHAINE
         @asChaine			 VarChar ( 2000 ) OUTPUT,
		 @asCarCasse		 VarChar ( 10 ), 
		 @asCarSepMot		 VarChar ( 1 )  
AS

Declare @iFin Integer
Declare @iCpt Integer
Declare @iDebNouvMot Integer
Declare @sChaineWrk VarChar ( 2000 )
Declare @sCar Varchar ( 1 )
Declare @sMotAtraiter Varchar ( 100 )
Declare @iRand Integer
Declare @sCarSepMot Varchar ( 10 )
Declare @iLenMotAtraiter integer

Set @sChaineWrk = ltrim ( rtrim ( @asChaine )) + ' X'
Set @sCarSepMot = ltrim ( rtrim ( @asCarSepMot  ))
Set @asCarCasse = ltrim ( rtrim ( @asCarCasse  ))

If @sChaineWrk is null Return

Set @iFin = 0 
Set @iCpt = 1 
Set @iDebNouvMot = 1

While @iFin = 0
 Begin
	Select @sCar = Substring ( @sChaineWrk, @iCpt, 1 ) 

	If @sCar = @asCarSepMot
	  Begin
		If  @iCpt > @iDebNouvMot And @iDebNouvMot > 0 -- On est sur le début d'un séparateur, Si la position présente est plus grande que le début du mot, il y a vraiment un mot à traiter
 		  Begin
			-- Traitement insertion du caractère de casse dans le mot
			Set @sMotAtraiter = Substring ( @sChaineWrk, @iDebNouvMot, @iCpt - @iDebNouvMot )
			Set @iLenMotAtraiter = Len ( @sMotAtraiter )

			-- On ne traite que les mots de plus de 2 caractères, sinon aucun intérêt
			If @iLenMotAtraiter > 2 
			  Begin

				Set @iRand = 0
				While ( @iRand <= 0 Or @iRand > @iLenMotAtraiter ) And @iLenMotAtraiter > 1
				 Begin
					Set @iRand = Rand () * @iLenMotAtraiter
				 End 
				IF @iRand <= 0 Set @iRand = 1
			
				Set @sMotAtraiter = Left ( @sMotAtraiter, @iRand ) + @asCarCasse + Right ( @sMotAtraiter, len ( @sMotAtraiter ) - @iRand )

				-- Traitement de réinsertion du mot cassé dans la chaine original
				If @iDebNouvMot > 1 
				  Begin
					Set @sChaineWrk = Left ( @sChaineWrk, @iDebNouvMot - 1 ) + @sMotAtraiter + Substring ( @sChaineWrk, @iCpt, len ( @sChaineWrk ) )			 
				  End
				Else
				  Begin
					Set @sChaineWrk = @sMotAtraiter + Substring ( @sChaineWrk, @iCpt, len ( @sChaineWrk ) )			 
				  End

				Set @iCpt = @iCpt + len ( @asCarCasse ) + 1 
				Set @iDebNouvMot = @iCpt
			End 
			Else
			Begin
				Set @iCpt = @iCpt + 1 
				Set @iDebNouvMot = @iCpt
			End 

		  End
		Else
		  Begin
			Set @iCpt = @iCpt + 1
		  End
	  End 
	Else
		Begin
			Set @iCpt = @iCpt + 1
		End 

	If @iCpt > len ( @sChaineWrk ) Set @iFin = 1
 End 

 Set @asChaine = lTrim (Rtrim ( Left ( @sChaineWrk, Len ( @sChaineWrk ) -1 )))

Go



--------------------------------------------------------------------
--
-- Fonction             :       PS_S_CHAINE_ALEATOIRE
-- Auteur               :       Fabry JF
-- Date                 :       26/08/2020
-- Libellé              :
-- Commentaires         :       Renvoie une chaine de caractères aléatoire sur al longueur souhaitée
-- Références           :       
--
-- Arguments            :       
--				Ex : sysadm.PS_S_CHAINE_ALEATOIRE ( 50 )
--				     
-- Declare @asChaineAleatoire VarChar ( 8000 ) 
-- Set @asChaineAleatoire = Space ( 8000 )
-- Exec sysadm.PS_S_CHAINE_ALEATOIRE 8000, @asChaineAleatoire OutPut
-- Select @asChaineAleatoire
--
-- Retourne             :       Rien
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_CHAINE_ALEATOIRE' AND type = 'P' )
        DROP procedure sysadm.PS_S_CHAINE_ALEATOIRE
GO

CREATE  Procedure  sysadm.PS_S_CHAINE_ALEATOIRE
        @aiLongueur       Integer,
		@asChaineAleatoire VarChar ( 8000 ) OutPut
AS

Declare @iNbreNewId Integer
Declare @sNewId VarChar ( 8000 )
Declare @iCpt Integer

Set @aiLongueur = Abs ( @aiLongueur )
Set @iNbreNewId = ( @aiLongueur / 32 ) + 1
Set @iCpt = 1
Set @sNewId = ''

While @iCpt <= @iNbreNewId
 Begin
   Set @sNewId = @sNewId + Replace ( Convert ( Varchar (50),NewId () ), '-', '' )
   Set @iCpt = @iCpt + 1 
 End 

Set @asChaineAleatoire = Left ( @sNewId, @aiLongueur)

Go


--------------------------------------------------------------------
--
-- Fonction             :       FN_IS_DATE
-- Auteur               :       Fabry JF
-- Date                 :       18/12/2020
-- Libellé              :
-- Commentaires         :       Fonction plus puissante que la fonction simple IS_DATE d'SqlServer
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_IS_DATE' AND type = 'FN' )
        DROP function sysadm.FN_IS_DATE
Go

CREATE  function sysadm.FN_IS_DATE  
       (
        @sDate    Varchar(10)
        )
RETURNS integer

AS

Begin

  Set @sDate = lTrim ( rtrim ( @sDate ))

  If len ( @sDate ) < 10 Return 0

  If Substring ( @sDate, 3, 1 ) <> '/' Return 0
  If Substring ( @sDate, 6, 1 ) <> '/' Return 0
  If Ascii ( Substring ( @sDate, 1, 1 ) ) not between 48 and 57 Return 0
  If Ascii ( Substring ( @sDate, 2, 1 ) ) not between 48 and 57 Return 0
  If Ascii ( Substring ( @sDate, 4, 1 ) ) not between 48 and 57 Return 0
  If Ascii ( Substring ( @sDate, 5, 1 ) ) not between 48 and 57 Return 0
  If Ascii ( Substring ( @sDate, 7, 1 ) ) not between 48 and 57 Return 0
  If Ascii ( Substring ( @sDate, 8, 1 ) ) not between 48 and 57 Return 0
  If Ascii ( Substring ( @sDate, 9, 1 ) ) not between 48 and 57 Return 0
  If Ascii ( Substring ( @sDate, 10, 1 ) ) not between 48 and 57 Return 0

  Return IsDate ( @sDate) 

End
Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_LIB_POLE
-- Auteur               :       Fabry JF
-- Date                 :       07/12/2021
-- Libellé              :
-- Commentaires         :       Retourne le pole
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_LIB_POLE' AND type = 'FN' )
        DROP function sysadm.FN_LIB_POLE
Go

CREATE  function sysadm.FN_LIB_POLE  
       ( @dcIdProd    decimal ( 7 )
        )
RETURNS Varchar(65)

AS

Begin

  Declare @sLibPole Varchar(35)

  Select Top 1 @sLibPole = sysadm.FN_CODE_NUM ( id_code_num, '-UO' )  
  From sysadm.det_pro dp
  Where dp.id_code_dp = 99
  And   dp.id_prod = @dcIdProd

  Return @sLibPole 

End
Go


--------------------------------------------------------------------
--
-- Fonction             :       FN_LIB_POLE
-- Auteur               :       Fabry JF
-- Date                 :       07/12/2021
-- Libellé              :
-- Commentaires         :       Retourne le pole
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_LIB_POLE' AND type = 'FN' )
        DROP function sysadm.FN_LIB_POLE
Go

CREATE  function sysadm.FN_LIB_POLE  
       ( @dcIdProd    decimal ( 7 )
        )
RETURNS Varchar(65)

AS

Begin

  Declare @sLibPole Varchar(35)

  Select Top 1 @sLibPole = sysadm.FN_CODE_NUM ( id_code_num, '-UO' )  
  From sysadm.det_pro dp
  Where dp.id_code_dp = 99
  And   dp.id_prod = @dcIdProd

  Return @sLibPole 

End
Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_GET_ID_CORB
-- Auteur               :       Fabry JF
-- Date                 :       10/02/2023
-- Libellé              :
-- Commentaires         :       Retourne la corbeille à partir d'un sinistre
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_ID_CORB' AND type = 'FN' )
        DROP function sysadm.FN_GET_ID_CORB
Go

CREATE  function sysadm.FN_GET_ID_CORB  
       ( @dcIdSin    decimal ( 10 )
        )
RETURNS Int

AS

Begin
  
  Declare @idIdCorb Int

  Select @idIdCorb = p.id_corb 
  From sysadm.w_sin ws,
	   sysadm.produit p
  Where ws.id_sin = @dcIdSin
  And   p.id_prod = ws.id_prod
	
  If @@Rowcount > 0 Return @idIdCorb

  Select @idIdCorb = p.id_corb 
  From sysadm.sinistre s,
	   sysadm.produit p
  Where s.id_sin = @dcIdSin
  And   p.id_prod = s.id_prod
	
  If @@Rowcount > 0 Return @idIdCorb

  Return -1

End
Go

--------------------------------------------------------------------
--
-- Fonction             :       PS_FILE_OPEN_REWRITE
-- Auteur               :       Fabry JF (sur reprise de Frédéric Brouard)
-- Date                 :       10/03/2023
-- Libellé              :
-- Commentaires         :       Créé (ouvre) un fichier en création ou adjonction (Append)
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_FILE_OPEN_REWRITE' AND type = 'P' )
        DROP procedure sysadm.PS_FILE_OPEN_REWRITE
GO

CREATE  PROCEDURE sysadm.PS_FILE_OPEN_REWRITE 
	@FILE_NAME  NVARCHAR(256), -- nom du fichier
	@ACTION		INT         ,  -- 2=Créer ; 8=Ouvrir en Append
    @F_HANDLE   INT   OUTPUT,  -- handle OS du fichier
    @F_ID       INT   OUTPUT   -- identifiant numérique du fichier
AS
 
/******************************************************************************************
* Copyright :   Frédéric Brouard / SQLpro / SQL spot                                      *
*               (http://sqlpro.developpez.com - http://www.sqlspot.com)                   *
* Auteur :      Frédéric Brouard / SQL pro                                                *
* Créée le :    2006-02-01                                                                *
* Description : créé un fichier texte en écriture à l'aide d'objets OLE                   *
******************************************************************************************/
 
   SET NOCOUNT ON
 
   -- valeur de retour d'exécution appel OLE
   DECLARE @OLE_RETURN INT
 
   -- création de l'objet
   EXECUTE @OLE_RETURN = sp_OACreate 'Scripting.FileSystemObject', @F_HANDLE OUT
   IF @OLE_RETURN <> 0  RETURN -1
 
   --Ouvre le fichier (2 = ForWriting, 8 = ForAppending)
   EXECUTE @OLE_RETURN = sp_OAMethod @F_HANDLE, 'OpenTextFile', @F_ID OUT, @FILE_NAME, @ACTION, 1
   IF @OLE_RETURN <> 0  RETURN -1
 
GO

--------------------------------------------------------------------
--
-- Fonction             :       PS_FILE_WRITE_DATA
-- Auteur               :       Fabry JF (sur reprise de Frédéric Brouard)
-- Date                 :       10/03/2023
-- Libellé              :
-- Commentaires         :       ajoute une lignes de donnée
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_FILE_WRITE_DATA' AND type = 'P' )
        DROP procedure sysadm.PS_FILE_WRITE_DATA
GO

CREATE PROCEDURE sysadm.PS_FILE_WRITE_DATA 
		@F_ID  INT,            -- identifiant numérique du fichier
        @LINE  VARCHAR(max),   -- texte à ajouter
		@RETOUR_CHARIOT Int    -- 0=Sans;1=Avec retour chariot en fin de ligne
AS
 
/******************************************************************************************
* Copyright :   Frédéric Brouard / SQLpro / SQL spot                                      *
                (http://sqlpro.developpez.com - http://www.sqlspot.com)                   *
* Auteur :      Frédéric Brouard / SQL pro                                                *
* Créée le :    2006-02-01                                                                *
* Description : ajoute du texte à un fichier texte l'aide d'objets OLE                    *
******************************************************************************************/
 
BEGIN
 
   SET NOCOUNT ON
 
   -- valeur de retour d'exécution appel OLE
   DECLARE @OLE_RETURN INT
 

   If @RETOUR_CHARIOT > 0 
     Begin
	   EXECUTE @OLE_RETURN = sp_OAMethod @F_ID, 'WriteLine', Null, @LINE

	   IF @OLE_RETURN  <> 0 RETURN -1
	 End 
   Else
     Begin
			-- ecrit la ligne dans le fichier
	   EXECUTE @OLE_RETURN = sp_OAMethod @F_ID, 'Write', Null, @LINE

	   IF @OLE_RETURN  <> 0 RETURN -1
	 End
 
END
GO

--------------------------------------------------------------------
--
-- Fonction             :       PS_FILE_CLOSE
-- Auteur               :       Fabry JF (sur reprise de Frédéric Brouard)
-- Date                 :       10/03/2023
-- Libellé              :
-- Commentaires         :       Ferme le fichier
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_FILE_CLOSE' AND type = 'P' )
        DROP procedure sysadm.PS_FILE_CLOSE
GO

CREATE PROCEDURE sysadm.PS_FILE_CLOSE 
		@F_HANDLE INT,   -- handle OS du fichier
        @F_ID      int   -- identifiant numérique du fichier
AS
 
/******************************************************************************************
* Copyright :   Frédéric Brouard / SQLpro / SQL spot                                      *
                (http://sqlpro.developpez.com - http://www.sqlspot.com)                   *
* Auteur :      Frédéric Brouard / SQL pro                                                *
* Créée le :    2006-02-01                                                                *
* Description : ferme un fichier texte l'aide d'objets OLE                                *
******************************************************************************************/
 
BEGIN
                
   SET NOCOUNT ON
 
   DECLARE @OLE_RETURN int
 
   -- fermeture du fichier
   EXECUTE @OLE_RETURN = sp_OADestroy @F_ID
 
   -- destruction de l'objet Ole
   EXECUTE @OLE_RETURN = sp_OADestroy @F_HANDLE
 
END
GO

--------------------------------------------------------------------
--
-- Fonction             :       FN_CLE_VAL_XML
-- Auteur               :       Fabry JF
-- Date                 :       26/04/2023
-- Libellé              :		[RS5045]
-- Commentaires         :       Retourne la valeur d'une variable Xml
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_CLE_VAL_XML' AND type = 'FN' )
        DROP function sysadm.FN_CLE_VAL_XML
Go

CREATE  function sysadm.FN_CLE_VAL_XML  
       ( @sXmlKey     VarChar (255), -- Clé de laquelle on veut extraire la valeur
	     @sXmlData    VarChar (max), -- Chaine complète à browser
	     @sRepesctCasse VarChar (3 ) -- OUI/NON
        )
RETURNS Varchar(255)

AS

Begin

  Declare @sXmlDataWork VarChar (max)
  Declare @sXmlKeyWork VarChar (255)
  Declare @iPos1 integer
  Declare @iPos2 integer
  Declare @sValue VarChar ( 255 ) 

  If @sXmlData is null Return ''
  If @sXmlKey is null Return ''

  Set @sXmlData = lTrim ( rTrim ( @sXmlData ))
  Set @sXmlKey = lTrim ( rTrim ( @sXmlKey ))

  If @sXmlData = '' Return ''
  If @sXmlKey = '' Return ''

  While CharIndex ( ' =', @sXmlData  ) > 0 
    Begin 
	 Set @sXmlData = Replace ( @sXmlData, ' =', '=' )
	End 

  While CharIndex ( '= ', @sXmlData  ) > 0 
    Begin 
	 Set @sXmlData = Replace ( @sXmlData, '= ', '=' )
	End 

  Set @sXmlDataWork = @sXmlData
  Set @sXmlKeyWork = @sXmlKey

  If @sRepesctCasse = 'NON' 
    Begin 
		Set @sXmlDataWork = Upper ( @sXmlDataWork )
		Set @sXmlKeyWork = Upper ( @sXmlKeyWork )
	End 

  Set @iPos1 = CharIndex ( @sXmlKeyWork + '="', @sXmlDataWork ) 
  If @iPos1 > 0 
    Begin
	  Set @iPos1 = @iPos1 + len ( @sXmlKeyWork + '="') 
	  Set @iPos2 = CharIndex ( '"', @sXmlDataWork, @iPos1 ) 
	End 

  If @iPos1 <= 0 Or @iPos2 <= 0 Return ''

  Set @sValue = lTrim ( rTrim ( Substring ( @sXmlData, @iPos1, @iPos2 - @iPos1 )))

  If @sValue is null Set @sValue = ''

  Return @sValue 

End
Go

--------------------------------------------------------------------
--
-- Fonction             :       PS_INSTANCIER_UN_OBJET_SQL_SERVER
-- Auteur               :       Fabry JF 
-- Date                 :       26/05/2023
-- Libellé              :		[RS5045_REF_MATP]
-- Commentaires         :       Instancier un objet SQL SERVER et permet donc de 
--                              récuper le Handle pour le piloter
-- Références           :       
--
-- Arguments            :       Nom de l'objet à instancer,
--
-- Retourne             :       le Handle  (Si Handle à -1, l'objet n'a pas pu être instancié. Pour être utiliser le Handle doit être strictement positif)
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_INSTANCIER_UN_OBJET_SQL_SERVER' AND type = 'P' )
        DROP procedure sysadm.PS_INSTANCIER_UN_OBJET_SQL_SERVER
GO

CREATE  PROCEDURE sysadm.PS_INSTANCIER_UN_OBJET_SQL_SERVER 
	@asNomObjet Varchar ( 50 )
As 

Declare @Handle Int

Set @asNomObjet = lTrim ( rTrim ( @asNomObjet )) 

exec sp_OACreate @asNomObjet , @Handle OutPut

If @Handle is null Set @Handle = -1
If @Handle <= 0 Set @Handle = -1

Return @Handle

Go


--------------------------------------------------------------------
--
-- Fonction             :       PS_DETRUIRE_UN_OBJET_SQL_SERVER
-- Auteur               :       Fabry JF 
-- Date                 :       26/05/2023
-- Libellé              :		[RS5045_REF_MATP]
-- Commentaires         :       Détruire un objet SQL SERVER en donnant son Handle
-- Références           :       
--
-- Arguments            :       Handle à détruire
--
-- Retourne             :       0 succès de la destruction
--                             <> 0, problème, non détruit
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_DETRUIRE_UN_OBJET_SQL_SERVER' AND type = 'P' )
        DROP procedure sysadm.PS_DETRUIRE_UN_OBJET_SQL_SERVER
GO

CREATE  PROCEDURE sysadm.PS_DETRUIRE_UN_OBJET_SQL_SERVER 
	@aiHandle Int
As 

Declare @iRet Int

exec @iRet = sp_OADestroy @aiHandle 

Return @iRet 

Go

--------------------------------------------------------------------
--
-- Fonction             :       PS_ECRIRE_UN_ENREGISTREMENT_ADODB_STREAM
-- Auteur               :       Fabry JF 
-- Date                 :       26/05/2023
-- Libellé              :		[RS5045_REF_MATP]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       	
--									@aiHandle  
--										Un entier (int) représentant le Handle de l'objet ADODB.Stream précédent instancié 
--									@aiOuvrirFic
--										1 = Ouverture du fichier/ Initialisation des Type, Mode, CharSet et LineSeparator
--										0 = Pas de traitement d'ouverture
--									@aiInsererData
--										1 = Insertion données Texte ou Binaire, Type, Mode, CharSet et LineSeparator peuvent être passé à null à ce moment
--										0 = Aucune insertion de données
--									@asType				Int,
--										1 = Binaire pour de la descente de Blob
--										2 = Texte
--									@asMode				Int,
--										1 = Lecture
--										2 = Ecriture
--										3 = Lecture/Ecriture
--									@asCharSet			VarChar ( 30 ), (si @asType = 2 uniquement sinon null) 
--										Consulter tous les charset possible du ADODB.Stream sur https://www.w3schools.com/html/html_charset.asp
--										'UTF-8' pour de l'XML
--										'ISO-8859-1' pour du fichier texte
--										'ASCII' pour du fichier texte
--									@asLineSeparator	Integer, (si @asType = 2 uniquement sinon null) 
--										'adCRLF' (-1) Par défaut, un retour chariot et un saut de ligne, 
--										'adCR' (13)	Retour chariot uniquement
--										'adLF' (10) Saut de ligne uniquement	
--										Précision : Les 3 sont les mêmes en fait, un CR et un LF c'est pareil aujourd'hui, cela avec un importance sur des imprimantes ou machines à écrire à chariot.
--
-- Retourne             :       0 succès 
--                             <> 0, problème
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_ECRIRE_UN_ENREGISTREMENT_ADODB_STREAM_V03' AND type = 'P' )
        DROP procedure sysadm.PS_ECRIRE_UN_ENREGISTREMENT_ADODB_STREAM_V03
GO

CREATE  PROCEDURE sysadm.PS_ECRIRE_UN_ENREGISTREMENT_ADODB_STREAM_V03
	@aiHandle			Int,	
	@aiOuvrirFic		Int, 
	@aiInsererData		Int,
	@aiType				Int,
	@aiMode				Int,
	@asCharSet			VarChar ( 30 ),
	@aiLineSeparator	Integer,
	@asTextBody			NVarChar ( Max ),
	@ablBlob			VarBinary (max) 
As

Declare @iRet Integer
Declare @iLineSeparator Int
Declare @iType Int

If @aiOuvrirFic > 0 
	Begin
		Exec @iRet = sp_OASetProperty     @aiHandle, 'Type',  @aiType
		If @iRet <> 0 Return @iRet 

		Exec @iRet = sp_OASetProperty     @aiHandle, 'Mode',  @aiMode
		If @iRet <> 0 Return @iRet 

		If @aiType = 2 
			Begin
				Exec @iRet = sp_OASetProperty     @aiHandle, 'Charset',  @asCharSet
				If @iRet <> 0 Return @iRet 

				Exec @iRet = sp_OASetProperty     @aiHandle, 'LineSeparator',  @aiLineSeparator
				If @iRet <> 0 Return @iRet 
			End 

		Exec @iRet = sp_OAMethod     @aiHandle, 'Open'
		If @iRet <> 0 Return @iRet 
	End 

If @aiInsererData > 0 
	Begin 
		EXECUTE @iRet = sp_OAGetProperty @aiHandle,  'Type', @iType output

		If @iType = 2 
			Begin
				EXECUTE @iRet = sp_OAGetProperty @aiHandle,  'LineSeparator', @iLineSeparator output
				Set @asTextBody = @asTextBody + Char ( @iLineSeparator )

				Exec @iRet = sp_OAMethod     @aiHandle, 'WriteText', null, @asTextBody
				If @iRet <> 0 Return @iRet 
			End 

		If @iType = 1 
			Begin
				Exec @iRet = sp_OAMethod     @aiHandle, 'Write', null, @ablBlob
				If @iRet <> 0 Return @iRet 
			End 
	End 

Return @iRet 

Go

--------------------------------------------------------------------
--
-- Fonction             :       PS_SAUVEGARDER_ET_FERMER_UN_FICHER_ADODB_STREAM
-- Auteur               :       Fabry JF 
-- Date                 :       26/05/2023
-- Libellé              :		[RS5045_REF_MATP]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       	@aiHandle  
--										Un entier (int) représentant le Handle de l'objet ADODB.Stream précédent instancié 
--									@asNomFichierASauver
--										Nom UNC du fichier à Sauver (\\SERVEUR\etc...)
--									@ModeSav
--										1 = Non existant (pas d'écrasement)
--										2 = Ecrasement si existant
-- Retourne             :       0 succès 
--                             <> 0, problème
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SAUVEGARDER_ET_FERMER_UN_FICHER_ADODB_STREAM' AND type = 'P' )
        DROP procedure sysadm.PS_SAUVEGARDER_ET_FERMER_UN_FICHER_ADODB_STREAM
GO

CREATE  PROCEDURE sysadm.PS_SAUVEGARDER_ET_FERMER_UN_FICHER_ADODB_STREAM 
	@aiHandle			Int,
	@asNomFichierASauver Varchar ( 255 ),
	@ModeSav			Int
As

Declare @iRet Integer

Set @asNomFichierASauver = lTrim ( rTrim ( @asNomFichierASauver ))

Exec @iRet = sp_OAMethod  @aiHandle, 'SaveToFile', null, @asNomFichierASauver, @ModeSav
If @iRet <> 0 Return @iRet 

Exec @iRet = sp_OAMethod  @aiHandle, 'Close'
If @iRet <> 0 Return @iRet 

Return @iRet 

Go

--------------------------------------------------------------------
--
-- Fonction             :       PS_FERMER_UN_FICHER_ADODB_STREAM
-- Auteur               :       Fabry JF 
-- Date                 :       29/04/2024
-- Libellé              :		[HP252_276_HUB_PRESTA]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       	@aiHandle  
--										Un entier (int) représentant le Handle de l'objet ADODB.Stream précédent instancié 
-- Retourne             :       0 succès 
--                             <> 0, problème
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_FERMER_UN_FICHER_ADODB_STREAM' AND type = 'P' )
        DROP procedure sysadm.PS_FERMER_UN_FICHER_ADODB_STREAM
GO

CREATE  PROCEDURE sysadm.PS_FERMER_UN_FICHER_ADODB_STREAM 
	@aiHandle			Int
As

Declare @iRet Integer

Exec @iRet = sp_OAMethod  @aiHandle, 'Close'
If @iRet <> 0 Return @iRet 

Return @iRet 

Go


--------------------------------------------------------------------
--
-- Fonction             :       FN_GET_NOM_PRENOM
-- Auteur               :       Fabry JF (Repris de Fred)
-- Date                 :       14/06/2023
-- Libellé              :		[PMO89_RS4822]
-- Commentaires         :       
-- Références           :       
--
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_NOM_PRENOM' AND type = 'F' )
        Drop function sysadm.FN_GET_NOM_PRENOM
Go

GO
CREATE  function sysadm.FN_GET_NOM_PRENOM  
--------------------------------------------------------------------------------------------  
-- FN_RIB_IBAN FS le 28/08/2018 : Transforme un RIB vers IBAN  
--------------------------------------------------------------------------------------------  
   (  
   @sLib       Varchar(71),  -- Nom et prénom en une seule zone  
   @sPartie    Varchar(1)    -- 'N' pour obtenir le nom, 'P' pour obtenir le prénom          
   )  
RETURNS Varchar(71)  
  
AS  
  
Begin  
   
 Declare @sNom    Varchar(35)   
 Declare @sPrenom Varchar(35)   
 Declare @iPos    Integer  
 Declare @sRet    Varchar(35)  
  
/*------------------------------------------------------------------*/  
/* #2 Retrait des espaces avant et aprŠs la chaine @sLib            */  
/*------------------------------------------------------------------*/  
  
 Set @sLib = Ltrim ( @sLib )  /* Gauche */  
 Set @sLib = Rtrim ( @sLib )  /* Droite */  
 Set @iPos  = CHARINDEX ( ' ', @sLib )                             /* ... Position 1er espace */  
  
/*------------------------------------------------------------------*/  
/* Un seul mot = Nom ...                                            */  
/* On prend … partir du 4Šme car pour traiter                       */  
/* les noms compos‚s sans pr‚nom                                    */  
/*------------------------------------------------------------------*/  
  
 If @iPos = 0  
     Begin  
       Set @sNom    = @sLib  
       Set @sPrenom = '-'  
       Set @iPos    = 0  
     End  
  
   /*---------------------------*/           
   /* ... Pas de nom compos‚ ...*/  
   /*---------------------------*/  
  
   If @iPos <> 0 And @sLib not LIKE '__ %'  
      Begin  
        Set @sNom    = SUBSTRING ( @sLib, 1, @iPos -1 )  
      --  Set @sPrenom = RTRIM ( SUBSTRING ( @sLib, @iPos + 1,35 ) ) -- NTB   
   Set @sPrenom = Case ISNUMERIC(RTRIM ( SUBSTRING ( @sLib, @iPos + 1,35 ) )) when 1 Then ' '   
   ELSE RTRIM ( SUBSTRING ( @sLib, @iPos + 1,35 ) )  END   
      End  
  
   /*---------------------------*/           
   /* ... Nom 1 Lettre + 1 espace ...*/  
   /*---------------------------*/  
  
   If @iPos <> 0 And @sLib LIKE '_ %'  
        -- #4 Ajout du text  
  
        If CHARINDEX ( ' ', SUBSTRING ( @sLib, 3, 35 ) ) = 0  
           Begin  
              Set @sNom    = @sLib  
              Set @sPrenom = '-'  
           End  
        Else  
           Begin  
             Set @sNom    = SUBSTRING ( @sLib, 1, 2 ) +  SUBSTRING ( SUBSTRING ( @sLib, 3, 35), 1, CHARINDEX ( ' ', SUBSTRING ( @sLib , 3, 35 ) ) -1 )  
         Set @sPrenom = RTRIM ( SUBSTRING ( SUBSTRING ( @sLib, 3, 35 ), CHARINDEX( ' ', SUBSTRING ( @sLib, 3, 35 ) ) + 1,35 ) )  
            
    
      
     End  
  
   /*---------------------------*/   
   /* ... Nom compos‚ simple ...*/  
   /*---------------------------*/  
  
   If @iPos <> 0 And @sLib Like '__ %' And @sLib Not Like '__ __ %'  
      Begin  
        -- #3 ancienne commande  If CHARINDEX ( ' ', SUBSTRING ( @sLib +' ' , 4, 35 ) ) = 0   
        If CHARINDEX ( ' ', SUBSTRING ( @sLib, 4, 35 ) ) = 0  
           Begin  
             Set @sNom    = Substring ( @sLib, 1, 2  )  /* #1 Nom    = 2 1er caractères */  
             Set @sPrenom = Substring ( @sLib, 4, 35 )  /* #1 Prenom = La suite         */  
      
    End  
             Else  
    Begin  
      Set @sNom    = SUBSTRING ( @sLib, 1, 3 ) +  SUBSTRING ( SUBSTRING ( @sLib, 4, 35), 1, CHARINDEX ( ' ', SUBSTRING ( @sLib , 4, 35 ) ) -1 )  
      Set @sPrenom = RTRIM ( SUBSTRING ( SUBSTRING ( @sLib, 4, 35 ), CHARINDEX( ' ', SUBSTRING ( @sLib, 4, 35 ) ) + 1,35 ) )  
    
    End  
      End  
  
   /*---------------------------*/  
   /* ... Nom compos‚ double ...*/  
   /*---------------------------*/  
     If @iPos <> 0 And @sLib Like '__ __ %'  
        Begin  
          -- #3 Ancienne commande If CHARINDEX ( ' ', SUBSTRING ( @sLib +' ' , 7, 35 ) ) = 0  
          If CHARINDEX ( ' ', SUBSTRING ( @sLib, 7, 35 ) ) = 0  
             Begin  
              --Set @sNom    = @sLib  
  --Set @sPrenom = '-'  
              Set @sNom    = Substring ( @sLib, 1, 5  )  /* #1 Nom    = 5 1er caractères */  
              Set @sPrenom = Substring ( @sLib, 6, 35 )  /* #1 Prenom = La suite         */  
             End  
          Else  
             Begin  
               Set @sNom    =  substring ( @sLib, 1, 6 ) +substring( substring ( @sLib, 7, 35 ), 1, charindex( ' ', substring ( @sLib, 7, 35 ) ) -1 )  
               Set @sPrenom =  RTRIM ( substring( substring ( @sLib, 7, 30 ), charindex( ' ', substring ( @sLib, 7, 30 ) ) + 1,30 ))  
     
  
             End  
         End  
  
   /*---------------------------*/  
   /* #1 Retrait des espaces    */  
   /*---------------------------*/  
  
   Set @sNom    = Ltrim ( @sNom )  
   Set @sPrenom = Ltrim ( @sPrenom )  
  
  
  Set @sRet = Case @sPartie When 'N' Then @sNom When 'P' Then @sPrenom End  
   
  Return @sRet  
  
End  

Go

--------------------------------------------------------------------
--
-- Procédure            :       FN_CLE_VAL_XML_SUBST
-- Auteur               :       JFF
-- Date                 :       
-- Libellé              :		
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       
--
-- Retourne             :        1 Si l'insertion se passe bien
--                              -1 Si l'insertion échoue.
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_CLE_VAL_XML_SUBST' AND type = 'FN' )
        DROP function sysadm.FN_CLE_VAL_XML_SUBST
Go

CREATE  function sysadm.FN_CLE_VAL_XML_SUBST
   (
	@asCleVariable VarChar ( 100),  
	@asNouvelleValeur  VarChar ( 500),
	@asChaineXML varchar ( max ) 
    )
RETURNS Varchar(Max)

Begin  
-- Important : La casse de la clé n'a pas d'importance  
-- Je recherche la variable (clé) sur n'importe quelle casse.  
  
-- Important : Cette fonction change l'intégralité de la valeur (pas une partie de la valeur)  
-- Important : Cette fonction change ne traite qu'une seule fois la variable si elle se trouve plusieurs fois dans la chaine,   
-- Elle traite la première variable trouvée.  
  
-- Important : Cette fonction n'ajoute pas de variable  
  
Declare @iPos1 integer  
Declare @iPos2 integer  
Declare @sCleVariableWrk VarChar ( 100)  
Declare @sChaineXMLWrk varchar ( max )   -- [RS5045_REF_MATP] max
  
  
-- Rejet si une valeur est nulle  
If @asCleVariable is null Or @asNouvelleValeur is null Or @asChaineXML is null Return @asChaineXML
  
-- Je trime les valeurs  
Set @asCleVariable = ltrim ( rtrim ( @asCleVariable ))   
Set @asNouvelleValeur = ltrim ( rtrim ( @asNouvelleValeur ))   
Set @asChaineXML = ltrim ( rtrim ( @asChaineXML ))   
  
-- La clés et la valeurs ne doivent pas contenir de double-quote  
If CharIndex ( '"', @asCleVariable ) > 0 Return @asChaineXML 
If CharIndex ( '"', @asNouvelleValeur ) > 0 Return @asChaineXML 
  
-- Je recolle les = à la variable et au début du "  
While CharIndex ( '= ', @asChaineXML ) > 0   
  Begin  
  set @asChaineXML = Replace ( @asChaineXML , '= ', '=' )  
  End   
  
While CharIndex ( ' =', @asChaineXML ) > 0   
  Begin  
  set @asChaineXML = Replace ( @asChaineXML , ' =', '=' )  
  End   
  
Set @sCleVariableWrk = Upper ( @asCleVariable )  
Set @sChaineXMLWrk = Upper(  @asChaineXML )  


Set @iPos1 = 1 
While CharIndex ( @sCleVariableWrk + '=', @sChaineXMLWrk, @iPos1 ) > 0 
  Begin
	-- Ainsi je peux rechercher la variable collée à un =, je ne confondrai pas ainsi la variable avec une évetuelle valeur du même nom que la variable  
	Set @iPos1 = CharIndex ( @sCleVariableWrk + '=', @sChaineXMLWrk, @iPos1  )  
	If @iPos1 <= 0 Break
  
	-- Je recherche forcément le début de la valeur  
	Set @iPos1 = CharIndex ( '="', @sChaineXMLWrk, @iPos1 ) + 2 -- +2 car =" (2 car) il faut   
	If @iPos1 <= 0 Break  
  
	Set @iPos2 = CharIndex ( '"', @sChaineXMLWrk, @iPos1 )   
	If @iPos2 <= 0 Break  
  
	If @iPos2 - @iPos1 <= 0 Break   
  
	Set @sChaineXMLWrk = STUFF ( @sChaineXMLWrk, @iPos1,  @iPos2 - @iPos1, @asNouvelleValeur)  
	Set @asChaineXML = STUFF ( @asChaineXML , @iPos1,  @iPos2 - @iPos1, @asNouvelleValeur)  

	Set @iPos1 = @iPos2 -- Pour le départ du prochain tour
  End 

Return @asChaineXML

End

Go

--------------------------------------------------------------------
--
-- Fonction             :       PS_CHARGER_UN_FICHIER_BINAIRE_ADODB_STREAM
-- Auteur               :       Fabry JF 
-- Date                 :       27/01/2024
-- Libellé              :		
-- Commentaires         :       
-- Références           :       
--
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CHARGER_UN_FICHIER_BINAIRE_ADODB_STREAM' AND type = 'P' )
        DROP procedure sysadm.PS_CHARGER_UN_FICHIER_BINAIRE_ADODB_STREAM
GO

CREATE  PROCEDURE sysadm.PS_CHARGER_UN_FICHIER_BINAIRE_ADODB_STREAM
	@aiHandle			Int,
	@asCheminEtNomFichier  Varchar ( 255 ),
	@ablBlobRetour		VarBinary (max) Output,
	@aiTailleOctects	Int OutPut
As

-- Arguments            :       	
--									@aiHandle  
--										Un entier (int) représentant le Handle de l'objet ADODB.Stream précédent instancié 
--									@asCheminEtNomFichier
--										Une variable chaine de 255 donnant le chemin (UNC) et le nom du fichier à charger
--									@avbBlobRetour  (output)
--										Un varBinary (max) vide qui aura Le fichier Binaire chargé en retour
--									@aiTailleOctects (output)
--										Un entier qui contient le nombre d'octects chargé, bref, la taille du fichier.
--
-- Retourne             :       0 succès 
--                             <> 0, problème

Declare @iRet Integer
Declare @iEOF Integer
Declare @iIdPaquet  Integer
Declare @maChaineBIN varbinary (8000)

DECLARE @tb TABLE ( 
	id  integer identity,
	marquage integer ,
	line  varbinary (8000))

If @asCheminEtNomFichier is null Set @asCheminEtNomFichier = ''
Set @asCheminEtNomFichier = LTRIM (  RTRIM ( @asCheminEtNomFichier ))
Set @iEOF = 0 

If @asCheminEtNomFichier = '' Return -1

Exec @iRet = sp_OASetProperty     @aiHandle, 'Type',  1
If @iRet <> 0 Return @iRet 

Exec @iRet = sp_OASetProperty     @aiHandle, 'Mode',  3
If @iRet <> 0 Return @iRet 

Exec @iRet = sp_OAMethod		  @aiHandle, 'Open'
If @iRet <> 0 Return @iRet 

EXECUTE @iRet = sp_OAMethod       @aiHandle, 'LoadFromFile' , null, @asCheminEtNomFichier 
If @iRet <> 0 Return @iRet 

While @iEOF = 0
  Begin
	Insert into @tb ( line ) EXECUTE @iRet = sp_OAMethod  @aiHandle,  'Read' , null, 8000
	If @iRet <> 0 Return @iRet 

	EXECUTE @iRet = sp_OAGetProperty @aiHandle,  'EOS', @iEOF output
	If @iRet <> 0 Return @iRet 
  ENd 

EXECUTE @iRet = sp_OAGetProperty @aiHandle,  'Size', @aiTailleOctects output
If @iRet <> 0 Return @iRet 

EXECUTE @iRet = sp_OAMethod @aiHandle, 'Close'
If @iRet <> 0 Return @iRet 

Set @ablBlobRetour = CONVERT ( VarBinary, '' ) 
Update @tb Set marquage = 0

While Exists ( Select Top 1 1 From @tb where marquage = 0 )
Begin
	Select @maChaineBIN = line,
		   @iIdPaquet = id
	From @tb
	Where marquage = 0
	And id = ( 
				Select MIN ( id ) 
				From @tb
				Where marquage = 0
			 )
	
	Set @ablBlobRetour = @ablBlobRetour + @maChaineBIN
	
	Update @tb Set marquage = 1 where id = @iIdPaquet

End 

Return @iRet 

Go

--------------------------------------------------------------------
--
-- Fonction             :       PS_CHARGER_UN_FICHIER_TEXTE_ADODB_STREAM
-- Auteur               :       Fabry JF 
-- Date                 :       27/01/2024
-- Libellé              :		
-- Commentaires         :       
-- Références           :       
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CHARGER_UN_FICHIER_TEXTE_ADODB_STREAM' AND type = 'P' )
        DROP procedure sysadm.PS_CHARGER_UN_FICHIER_TEXTE_ADODB_STREAM
GO

CREATE  PROCEDURE sysadm.PS_CHARGER_UN_FICHIER_TEXTE_ADODB_STREAM
	@aiHandle				Int,
	@asCheminEtNomFichier	Varchar ( 255 ),
	@asCharSet				VarChar ( 50 ), 
	@asSerialiser			Varchar ( 5 ),
	@asSeparateur			Varchar ( 20 ),
	@aiNbreValParLigne		Int Output,
	@aiNbreDeLigne			Int Output,
	@aiTailleOctects	Int OutPut
As

-- 
-- Contrainte			:			Le fichier  
--
-- Arguments            :       	
--									@aiHandle  
--										Un entier (int) représentant le Handle de l'objet ADODB.Stream précédent instancié 
--									@asCheminEtNomFichier
--										Une variable chaine de 255 donnant le chemin (UNC) et le nom du fichier à charger
--									@asCharSet
--										La valeur du charset en chaine de caractère, ex : ascii, unicode, UTF8, etc...
--                                      S'il y a des caractères accentués, mettre unicode, sinon l'ascii sortira d'autres caractères à la place.
--                                  @asSerialiser (Optionel)
--										Une valeur en dur 'SERIA' qui indique de sérialiser chaque ligne pour plus facilement récupérer
--                                      chaque valeur de chaque ligne. la sérialisation sera comme suit : V1=XXXXXX;V2=XXXXX;Vn=XXXXX
--                                  @asSeparateur (Optionel)(Obligatoire si 'SERIA')
--                                      Une valeur en dur en chaine indiquant le séparateur de champs se trouvant dans le fichier chargé.
--                                  @iNbreValParLigne (output)(optionel)(Renvoyé si SERIA) sinon null
--                                      Une entier qui Retourne le nombre de champs par ligne
--                                  @iNbreDeLigne (output)
--                                      Une entier qui Retourne le nombre de ligne chargées
--									@aiTailleOctects (output)
--										Un entier qui contient le nombre d'octects chargé, bref, la taille du fichier.
--
--									
--
--									Le client appelant doit créer cette table temporaire local à sa connexion pour récupérer le fichier et le traiter
--                                  Il doit ensuite droper sa table même si elle sera normalement dropée à la fin de sa connexion
--
--									CREATE TABLE #TableStockageFichierTexte
--										  ( id_ligne integer identity,
--											marquage integer,
--											data_ligne varchar ( max ) 
--										  )
--
--									Exec sysadm.PS_CHARGER_UN_FICHIER_TEXTE_ADODB_STREAM  ...., ....., etc...
--
--									Traitement du client par boucle pour récupérer les données de la table #TableStockageFichierTexte
--
--									DROP TABLE #TableStockageFichierTexte
--
-- Retourne             :       0 succès 
--                             <> 0, problème
--

Declare @iRet Integer
Declare @iEOF Integer
Declare @iIdLigne  Integer
Declare @sMaChaineTexte varchar (max)
Declare @iNumChamps Int
Declare @iPosLigne Int
Declare @iLenSeparateur Int
Declare @sTagSeria VarChar ( 20 )

If @asCheminEtNomFichier is null Set @asCheminEtNomFichier = ''
Set @asCheminEtNomFichier = LTRIM (  RTRIM ( @asCheminEtNomFichier ))
Set @iEOF = 0 
Set @aiNbreDeLigne = 0
Set @aiNbreValParLigne = 0

If @asCheminEtNomFichier = '' Return -1

Exec @iRet = sp_OASetProperty     @aiHandle, 'Type',  2
If @iRet <> 0 Return @iRet 

Exec @iRet = sp_OASetProperty     @aiHandle, 'Mode',  3
If @iRet <> 0 Return @iRet 

EXEC @iRet = sp_OASetProperty     @aiHandle, 'Charset', @asCharSet
If @iRet <> 0 Return @iRet 

EXEC @iRet = sp_OASetProperty     @aiHandle, 'LineSeparator', -1
If @iRet <> 0 Return @iRet 

Exec @iRet = sp_OAMethod		  @aiHandle, 'Open'
If @iRet <> 0 Return @iRet 

Exec @iRet = sp_OAMethod          @aiHandle, 'LoadFromFile' , null, @asCheminEtNomFichier 
If @iRet <> 0 Return @iRet 

While @iEOF = 0
  Begin
	Insert into #TableStockageFichierTexte ( data_ligne ) EXECUTE @iRet = sp_OAMethod  @aiHandle,  'ReadText' , null, -2
	If @iRet <> 0 Return @iRet 

	Set @aiNbreDeLigne = @aiNbreDeLigne + 1

	EXECUTE @iRet = sp_OAGetProperty @aiHandle,  'EOS', @iEOF output
	If @iRet <> 0 Return @iRet 
  ENd 

EXECUTE @iRet = sp_OAGetProperty @aiHandle,  'Size', @aiTailleOctects output
If @iRet <> 0 Return @iRet 

EXECUTE @iRet = sp_OAMethod @aiHandle, 'Close'
If @iRet <> 0 Return @iRet 

Update #TableStockageFichierTexte Set marquage = 0

If Upper ( lTrim ( rTrim ( @asSerialiser ))) = 'SERIA'
 Begin

	While Exists ( Select Top 1 1 From #TableStockageFichierTexte Where marquage = 0 )
		Begin

			Select @sMaChaineTexte = data_ligne,
				   @iIdLigne = id_ligne
			From #TableStockageFichierTexte 
			Where marquage = 0 

			Set @iNumChamps = 1
			If LEN ( @sMaChaineTexte ) > 0 
			  Begin
				 Set @sMaChaineTexte = 'V1=' + @sMaChaineTexte
			  End 

			Set @iPosLigne = 1
			Set @iLenSeparateur = LEN ( lTrim ( rTrim ( @asSeparateur )))
			While  CHARINDEX ( @asSeparateur, @sMaChaineTexte, @iPosLigne ) > 0 
				Begin
					Set @iPosLigne = CHARINDEX ( @asSeparateur, @sMaChaineTexte, @iPosLigne )
					Set @iNumChamps = @iNumChamps + 1
					Set @sTagSeria = ';V'+ CONVERT ( VarChar ( 10 ), @iNumChamps ) + '='
					Set @sMaChaineTexte = STUFF ( @sMaChaineTexte, @iPosLigne, @iLenSeparateur, @sTagSeria )
					Set @iPosLigne = @iPosLigne + @iLenSeparateur - 1 + 1
				End 
			
			If @iNumChamps > @aiNbreValParLigne Set @aiNbreValParLigne = @iNumChamps 

			Update #TableStockageFichierTexte 
			Set marquage = 1,
				data_ligne = @sMaChaineTexte
			where id_ligne = @iIdLigne

		End 
		
	Update #TableStockageFichierTexte Set marquage = 0
 End 

Return @iRet 

Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_CHAMPSFIXE
-- Auteur               :       (anonyme)
-- Date                 :       2008-05-23 16:46:43.013
-- Libellé              :		
-- Commentaires         :       
-- Références           :       
--
--------------------------------------------------------------------
-- JFF 31/07/2024 ajout du 255 au varchar Set @sReturn = LEFT(ISNULL(LTRIM(RTRIM(CONVERT(varchar, @asqlvAny))), '') + REPLICATE(@asFill, @aiTaille), @aiTaille)  
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_CHAMPSFIXE' AND type = 'FN' )
        DROP function sysadm.FN_CHAMPSFIXE
Go

CREATE FUNCTION sysadm.FN_CHAMPSFIXE (   
 @asqlvAny as sql_variant,   
 @aiTaille as integer,   
 @asSens as char(1),   
 @asFill as char(1) )  
RETURNS varchar(255)  
AS  
BEGIN  
 Declare @sReturn as varchar(255)  
 -- Controle des parametre : retourne null si param incorrect, comme ca, ca se voit de suite dans un concaténation de chaine  
 IF (@aiTaille IS NULL) OR ( @asSens IS NULL ) OR (@asFill IS NULL) OR (@asSens NOT IN ('G', 'D') ) RETURN NULL  
   
 IF @asSens = 'D'  
 BEGIN  
  Set @sReturn = LEFT(ISNULL(LTRIM(RTRIM(CONVERT(varchar (255), @asqlvAny))), '') + REPLICATE(@asFill, @aiTaille), @aiTaille)  
 END  
  
 IF @asSens = 'G'  
 BEGIN  
  Set @sReturn = RIGHT(REPLICATE(@asFill, @aiTaille)+ ISNULL(LTRIM(RTRIM(CONVERT(varchar (255), @asqlvAny))), ''), @aiTaille)  
 END  
  
 RETURN @sReturn  
END 

Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_GET_CHEMIN
-- Auteur               :       JFF
-- Date                 :       10/09/2024
-- Libellé              :		
-- Commentaires         :       
-- Références           :       
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_CHEMIN' AND type = 'FN' )
        DROP function sysadm.FN_GET_CHEMIN
Go

CREATE FUNCTION sysadm.FN_GET_CHEMIN (   
	@sCleChem VarChar ( 50 )
	)
RETURNS varchar(255)  
AS  
BEGIN  

Declare @sChemin VarChar ( 255 )

Select @sChemin = lTrim ( rTrim ( c.chemin ) )
From sysadm.chemin c
Where c.cle_chem = @sCleChem

IF Right ( @sChemin, 1 ) <> '\' Set @sChemin = @sChemin + '\'

Return @sChemin

END
Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_SIGNATURE_MAIL
-- Auteur               :       JFF
-- Date                 :       03/04/2025
-- Libellé              :		
-- Commentaires         :       
-- Références           :       
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_SIGNATURE_MAIL' AND type = 'FN' )
        DROP function sysadm.FN_SIGNATURE_MAIL
Go

CREATE FUNCTION sysadm.FN_SIGNATURE_MAIL (   
	@asCas VarChar  ( 255 ) -- Si besoin
	)
RETURNS varchar(1000)  
AS  
BEGIN  

Declare @sSign VarChar ( 1000 )

Set @sSign = ''

If @asCas = 'JFF'
	Begin 
		Set @sSign = @sSign + 'Jean-François FABRY' + char (10)
		Set @sSign = @sSign + 'Leader technique' + char (10)
		Set @sSign = @sSign + 'Application sinistre SIMPA2' + char (10)
		Set @sSign = @sSign + '71, Quai Colbert - 76600 Le Havre - France' + char (10)
		Set @sSign = @sSign + 'Tél. : +33 (0)2 32 74 20 20 (choix serv. Voc. 2)' + char (10)
		Set @sSign = @sSign + 'mail : jfabry@spb.eu' + char ( 10 ) 
		Set @sSign = @sSign + 'Suivez-nous sur LinkedIn & www.spb.eu' + char (10)
		Set @sSign = @sSign + '----------------------------------------------------------' + char (10)
		Set @sSign = @sSign + 'SAS au capital de 1 000 000 euros soumise au contrôle de l’ACPR.' + char (10)
		Set @sSign = @sSign + 'Siège social : 71, quai Colbert - CS 90000 - 76600 Le Havre. Tél. : +33 (0)2 32 74 20 20' + char (10)
		Set @sSign = @sSign + 'N° RCS 305 109 779 (Le Havre) – N°ORIAS 07 002 642 (www.orias.fr).' + char (10)
	End

If @asCas = 'PIED_PAGE_MAIL_AUTO'
	Begin 
		Set @sSign = @sSign +  Char (10)    
		Set @sSign = @sSign +  Char (10)    
		Set @sSign = @sSign +  '****************************************************************'    
		Set @sSign = @sSign +  Char (10)    
		Set @sSign = @sSign +  'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'    
		Set @sSign = @sSign +  Char (10)    
		Set @sSign = @sSign +  '****************************************************************'    
		Set @sSign = @sSign +  Char (10)    
		Set @sSign = @sSign +  'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'    
		Set @sSign = @sSign +  Char (10) 
	End 

Return @sSign 

END
Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_GET_DIV_DET
-- Auteur               :       Fabry JF
-- Date                 :       11/07/2025
-- Libellé              :		
-- Commentaires         :       Ramène une donnée de Div_Det
-- Références           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_GET_DIV_DET' AND type = 'FN' )
        DROP function sysadm.FN_GET_DIV_DET
GO

CREATE  function sysadm.FN_GET_DIV_DET (
        @dcIdSin		Decimal ( 10 ), -- [PI062]
		@dcIdGti		Decimal ( 7 ),
		@dcIdDetail		Decimal ( 7 ),
		@sNomZone		VarChar ( 50 ),
		@sTable			VarChar ( 1 ),
		@sChaineBcv		VarChar ( 50 )
		)
RETURNS VarChar ( 50 )
AS
Begin

	Declare @sValeur Varchar ( 50 )

	If @sTable = 'P' 
		Begin
			Select	@sValeur = Case id_typ_zone 
									When 'C' Then sysadm.FN_TRIM ( ds.val_car )
									When 'D' Then sysadm.FN_AFF_DATE ( ds.val_dte, 'SH' )
									When 'LC' Then 
										Case sysadm.FN_CLE_VAL ( 'RETOUR', @sChaineBcv, ';' )
											When 'CODE' Then ds.val_car
											Else sysadm.FN_TRIM ( sysadm.FN_CODE_CAR ( ds.val_car, ds.id_typ_liste ) )
										End 
									When 'LN' Then 
										Case sysadm.FN_CLE_VAL ( 'RETOUR', @sChaineBcv, ';' )
											When 'CODE' Then Convert  ( VarChar ( 35), ds.val_nbre )
											Else Convert  ( VarChar ( 35), sysadm.FN_CODE_NUM ( ds.val_nbre, ds.id_typ_liste ))
										End 
									When 'N' Then Convert  ( VarChar ( 35), ds.val_nbre )
									When 'P' Then Convert  ( VarChar ( 35), ds.val_mt )
									When 'S' Then Convert  ( VarChar ( 35), ds.val_mt )
									When 'X' Then sysadm.FN_TRIM ( ds.val_car )
							   End 
			From	sysadm.div_det ds
			Where	ds.id_sin = @dcIdSin
			And		ds.id_gti = @dcIdGti
			And		ds.id_detail = @dcIdDetail
			And		ds.nom_zone = lower  ( @sNomZone ) 
		End 

	If @sTable = 'W' 
		Begin
			Select	@sValeur = Case id_typ_zone 
									When 'C' Then sysadm.FN_TRIM ( ds.val_car )
									When 'D' Then sysadm.FN_AFF_DATE ( ds.val_dte, 'SH' )
									When 'LC' Then 
										Case sysadm.FN_CLE_VAL ( 'RETOUR', @sChaineBcv, ';' )
											When 'CODE' Then ds.val_car
											Else sysadm.FN_TRIM ( sysadm.FN_CODE_CAR ( ds.val_car, ds.id_typ_liste ) )
										End 
									When 'LN' Then 
										Case sysadm.FN_CLE_VAL ( 'RETOUR', @sChaineBcv, ';' )
											When 'CODE' Then Convert  ( VarChar ( 35), ds.val_nbre )
											Else Convert  ( VarChar ( 35), sysadm.FN_CODE_NUM ( ds.val_nbre, ds.id_typ_liste ))
										End 
									When 'N' Then Convert  ( VarChar ( 35), ds.val_nbre )
									When 'P' Then Convert  ( VarChar ( 35), ds.val_mt )
									When 'S' Then Convert  ( VarChar ( 35), ds.val_mt )
									When 'X' Then sysadm.FN_TRIM ( ds.val_car )
							   End 
			From	sysadm.w_div_det ds
			Where	ds.id_sin = @dcIdSin
			And		ds.id_gti = @dcIdGti
			And		ds.id_detail = @dcIdDetail
			And		ds.nom_zone = lower  ( @sNomZone ) 
		End 

	If @sValeur is null Set @sValeur = ''

	Return @sValeur 

End 

Go



