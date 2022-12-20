-------------------------------------------------------------------
--
-- Fichier              :       BOUTIQUE.CP
-- Auteur               :       Abdmeziem C.
-- Date                 :       04/03/03
--
-- Commentaires         :       Gestion de la table BOUTIQUE
--
-- Procédures           :       
-- sysadm.DW_S_BOUTIQUE_PSM
-- sysadm.DW_S01_BOUTIQUE
-- sysadm.DW_S02_BOUTIQUE
-- sysadm.DW_S03_BOUTIQUE
-- sysadm.PS_D01_BOUTIQUE_MCM
-- sysadm.PS_D02_BOUTIQUE_MCM
-- sysadm.PS_I01_BOUTIQUE
-- sysadm.PS_I01_BOUTIQUE_PSM
-- sysadm.PS_I02_BOUTIQUE
-- sysadm.PS_I03_BOUTIQUE
-- sysadm.PS_S_BOUTIQUE_ADRESSE
-- sysadm.PS_S_BOUTIQUE_ADRESSE_2
-- sysadm.PS_S01_BOUTIQUE
-- sysadm.PS_S01_GESTION_BOUTIQUE_V00
-- sysadm.PS_S02_BOUTIQUE
-- sysadm.PS_S03_BOUTIQUE
-- sysadm.PS_V01_BOUTIQUE
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_BOUTIQUE
-- Auteur               :       Abdmeziem C.
-- Date                 :       04/03/03
-- Libellé              :        
-- Commentaires         :       Select sur la table BOUTIQUE
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-- #1   JFF    23/06/2008  [DCMP080287].FAX_MAIL (ajout adr_mail_cc )
-- #2   JFF    16/09/2008  [MICROMANIA] (ajout cod_mag )
-- #3	JFF    20/10/2008  [FNAC_PROD_ECH_TECH]
-- 		FPI	   01/08/2012  [VDoc7726]
-- JFF      07/11/2016   [PC151259]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_BOUTIQUE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_BOUTIQUE
GO

CREATE procedure sysadm.DW_S01_BOUTIQUE
        @dcIdProd        Decimal (  7, 0 )
AS
SELECT boutique.id_boutique,
boutique.region,
boutique.adr_ville,
boutique.adr_cp,
boutique.adr_tel,
boutique.adr_fax,
boutique.adr_mail,
boutique.adr_mail_cc, 	
boutique.adr_nom,
boutique.cod_mag,
boutique.adr_1,  -- #3 [FNAC_PROD_ECH_TECH]
boutique.adr_2,  -- #3 [FNAC_PROD_ECH_TECH]
boutique.responsable,  -- #3 [FNAC_PROD_ECH_TECH]
boutique.adr_mail2 , -- #3 [FNAC_PROD_ECH_TECH]
boutique.adr_mail_cc2, 	-- #3 [FNAC_PROD_ECH_TECH]
boutique.cree_le,
boutique.maj_le,
boutique.maj_par
FROM   sysadm.boutique
WHERE  boutique.id_prod = @dcIdProd
-- And sysadm.FN_CLE_VAL( 'FRN',region,  ';') <> 'PSM' -- [VDOC7726]
And ( region is null Or CHARINDEX ( '=', region ) = 0 ) -- [PC151259]

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_BOUTIQUE
-- Auteur               :       FABRY JF
-- Date                 :       17/11/2003
-- Libellé              :        
-- Commentaires         :       Select sur la table BOUTIQUE avec retour par
--				référence
--
-- Arguments            :       @dcIdProd	Decimal (7,0) Val
--				@iIdBoutique	Integer	      Val
--				@sAdrVille	VarChar ( 35 ) Réf
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_BOUTIQUE' AND type = 'P' )
        DROP procedure sysadm.PS_S01_BOUTIQUE
GO

CREATE procedure sysadm.PS_S01_BOUTIQUE
        @dcIdProd       Decimal (  7, 0 ),
	@iIdBoutique	Integer,	      
	@sAdrVille	VarChar ( 35 ) OUTPUT
AS
 SELECT @sAdrVille = b.adr_ville
 FROM   sysadm.boutique b
 WHERE  b.id_prod = @dcIdProd
 AND	b.id_boutique = @iIdBoutique

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_GESTION_BOUTIQUE_V00
-- Auteur               :       JCA
-- Date                 :       06/02/2007
-- Libellé              :        
-- Commentaires         :       Controle d'existence de boutique pour le produit
--
-- Arguments            :       @dcIdProd	Decimal (7,0) Val
--
-- Retourne             :       @iRet : Le nombre de boutique
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_GESTION_BOUTIQUE_V00' And type = "P" )
	DROP PROCEDURE sysadm.PS_S01_GESTION_BOUTIQUE_V00
GO

CREATE PROCEDURE sysadm.PS_S01_GESTION_BOUTIQUE_V00
	@dcIdProd decimal ( 7, 0 )
AS

DECLARE @iRet integer
SET 	@iRet = 0

SELECT	@iRet = count (*)
FROM	sysadm.boutique b
WHERE	b.id_prod = @dcIdProd

RETURN @iRet

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S02_BOUTIQUE
-- Auteur               :       FABRY JF
-- Date                 :       09/01/2008
-- Libellé              :       [DCMP080932] 
-- Commentaires         :       Select sur la table BOUTIQUE avec retour par
--				référence
--
-- Arguments            :       @dcIdProd	Decimal (7,0) Val
--				@sCodMagAlpha   Varchar (20)  Val
--				@iIdBoutique	Integer	      Réf
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- 		FPI	   01/08/2012  [VDoc7726]
-- JFF      07/11/2016   [PC151259]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_BOUTIQUE' AND type = 'P' )
        DROP procedure sysadm.PS_S02_BOUTIQUE
GO
CREATE procedure sysadm.PS_S02_BOUTIQUE
	@dcIdProd	Decimal (7,0),
	@sCodMagAlpha   Varchar (20) ,
	@iIdBoutique	Integer	OUTPUT
AS

 Set @iIdBoutique = null

SELECT @iIdBoutique = IsNull ( b.id_boutique, -1 )
FROM   sysadm.boutique b
WHERE  b.id_prod = @dcIdProd
AND	b.cod_mag = @sCodMagAlpha
--And sysadm.FN_CLE_VAL( 'FRN',region,  ';') <> 'PSM' -- [VDOC7726]
And ( region is null Or CHARINDEX ( '=', region ) = 0 ) -- [PC151259]

 
If @iIdBoutique is null Set @iIdBoutique = -1

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_S03_BOUTIQUE  
-- Auteur               :       FABRY JF
-- Date                 :       10/04/2009
-- Libelle              :       
-- Commentaires         :     	[FNAC_PROD_ECH_TECH]  
-- References           :       
-- 
-- Arguments
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1	JFF	22/02/2010	Demande de Maryse, on retire l'interdiction de règler Monaco.
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S03_BOUTIQUE' AND type = 'P' )
        DROP procedure sysadm.PS_S03_BOUTIQUE
GO


CREATE procedure sysadm.PS_S03_BOUTIQUE
	@dcIdSin Decimal ( 10), -- [PI062]
	@sMagRempl VarChar ( 4 ),
	@sRetour Varchar ( 50 ) OUTPUT,
	@sOk Varchar ( 1 ) OUTPUT -- O ou N
	
As

/* #1 
-- Interdiction donné par Maryse
If @sMagRempl in ( '3101' ) 
	Begin
		Set @sOk = 'N'
		Set @sRetour = '(magasin interdit !)'
		Return		
	End 
*/

If Exists (
	Select  *
	From 	sysadm.boutique c,
		sysadm.sinistre s
	Where	s.id_sin = @dcIdSin
	And     c.id_prod = s.id_prod
	And     Convert ( VarChar ( 15 ), c.id_boutique ) = @sMagRempl
	 )
	 Begin
	 	Set @sOk = 'O'
	 	Set @sRetour = ''
	 End 
Else
	 Begin
		Set @sOk = 'N'
		Set @sRetour = '(magasin de remplacement inexistant)'
	 End 
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I01_BOUTIQUE  
-- Auteur               :       F. Pinon
-- Date                 :       06/11/2009
-- Libelle              :       
-- Commentaires         :     	[EXPANSION5.BOUTIQUES] 
-- References           :       
-- 
-- Arguments
--
-- Retourne             :       0 Ok, -1 erreur
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_BOUTIQUE' AND type = 'P' )
        DROP procedure sysadm.PS_I01_BOUTIQUE
GO
 
CREATE PROCEDURE sysadm.PS_I01_BOUTIQUE
  @dcIdProd decimal(7,0), 
  @sCodBoutique varchar(20),
  @sVille	varchar(35),
  @sAdrCp	varchar(5),
  @sNom		varchar(35),
  @sAdr1	varchar(40),
  @sAdr2	varchar(40),
  @sResponsable	varchar(35),
  @sLibPolice	varchar(35),
  @sFlagMaj	char(1),
  @sMajPar	varchar(4)  
AS

Declare @iIdBoutique int,
  @iCount int

If isNumeric(@sCodBoutique) =1 Set @iIdBoutique = Convert(int, @sCodBoutique)
Else
Begin
  Select @iIdBoutique = max(id_boutique)
  From sysadm.boutique
  Where id_prod between (@dcIdProd * 100) and (@dcIdProd * 100) + 99
End

If  @sFlagMaj = 'I'
Begin 
  INSERT INTO sysadm.boutique(id_prod, 
    id_boutique, 
    adr_ville, 
    adr_cp, 
    adr_nom, 
    cod_mag, 
    adr_1, 
    adr_2, 
    responsable, 
    lib_police,
    cree_le, 
    maj_le, 
    maj_par)
  Select id_prod,
    @iIdBoutique,
    @sVille,
    @sAdrCp,
    @sNom,
    @sCodBoutique,
    @sAdr1,
    @sAdr2,
    @sResponsable,
    @sLibPolice,
    getdate(),
    getdate(),
    @sMajPar
  From sysadm.produit
  Where id_prod between (@dcIdProd * 100) and (@dcIdProd * 100) + 99

  if @@error <> 0 Return -1
End 

If  @sFlagMaj = 'U'
Begin 
  -- Controler l'existence
  Select @iCount=count(*) 
  From sysadm.boutique
  Where cod_mag=@sCodBoutique
    and id_prod between (@dcIdProd * 100) and (@dcIdProd * 100) + 99

  If @iCount = 0 Return -1

  -- Mise à jour
  Update sysadm.boutique
  Set adr_ville = @sVille, 
    adr_cp = @sAdrCp, 
    adr_nom = @sNom, 
    adr_1 = @sAdr1, 
    adr_2 = @sAdr2,
    responsable = @sResponsable, 
    lib_police = @sLibPolice,
    maj_le = getdate(), 
    maj_par = @sMajPar
  Where cod_mag=@sCodBoutique
    and id_prod between (@dcIdProd * 100) and (@dcIdProd * 100) + 99

  if @@error <> 0 Return -1
End

Return 0
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_V01_BOUTIQUE  
-- Auteur               :       F. Pinon
-- Date                 :       09/11/2009
-- Libelle              :       
-- Commentaires         :     	[EXPANSION5.BOUTIQUES] 
-- References           :       
-- 
-- Arguments
--
-- Retourne             :       0 Ok, -1 erreur
--
-------------------------------------------------------------------
-- 		FPI	   01/08/2012  [VDoc7726]
-- JFF      07/11/2016   [PC151259]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_V01_BOUTIQUE' AND type = 'P' )
        DROP procedure sysadm.PS_V01_BOUTIQUE
GO
 
CREATE PROCEDURE sysadm.PS_V01_BOUTIQUE
  @dcIdProd decimal(7,0), 
  @sCodBoutique varchar(20),
  @sFlagMaj	char(1)
AS
Declare @iCount int

-- Controler l'existence
Select @iCount=count(*) 
From sysadm.boutique
Where cod_mag=@sCodBoutique
  and id_prod between (@dcIdProd * 100) and (@dcIdProd * 100) + 99
--  And sysadm.FN_CLE_VAL( 'FRN',region,  ';') <> 'PSM' -- [VDOC7726]
And ( region is null Or CHARINDEX ( '=', region ) = 0 ) -- [PC151259]

If @iCount = 0 And @sFlagMaj = 'U' Return -1
If @iCount > 0 And @sFlagMaj = 'I' Return -1

Return 0

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_I02_BOUTIQUE  
-- Auteur               :       F. Pinon
-- Date                 :       01/12/2010
-- Libelle              :       
-- Commentaires         :     	[PC175] 
-- References           :       
-- 
-- Arguments
--
-- Retourne             :       0 Ok, -1 erreur
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I02_BOUTIQUE' AND type = 'P' )
        DROP procedure sysadm.PS_I02_BOUTIQUE
GO
 
CREATE PROCEDURE sysadm.PS_I02_BOUTIQUE
  @sCodBoutique varchar(20),
  @sEnseigne	varchar(11),
  @sNom		varchar(35),
  @sAdr1	varchar(40),
  @sAdr2	varchar(40),
  @sAdrCp	varchar(5),
  @sVille	varchar(40),
  @sNoTel	varchar(20),
  @sMajPar	varchar(4) 
AS

Declare @iIdBoutique int,
  @refIdprod decimal(7,0),
  @iCount int
Declare @tbLstProd TABLE (id_prod decimal(7,0));

-- Définition des produits impactés
If lower(@sEnseigne) in ('micromania','recycleware')
Begin
  Insert into @tbLstProd
  Select id_prod from sysadm.produit
  where id_prod between 30300 and 30303 or id_prod in (30308, 30309, 30314,30315, 30326, 30327) 
	 or id_prod between 30311 and 30313 or  id_prod between 30318 and 30321
End

If lower(@sEnseigne) = 'dockgames'
Begin
  Insert into @tbLstProd
  Select id_prod from sysadm.produit
  where id_prod between 30304 and 30307 or id_prod between 30322 and 30325 
End

-- Récupération de l'id_boutique
Select top 1 @refIdprod = b.id_prod, @iIdBoutique = id_boutique
  From sysadm.boutique b
  inner join @tbLstProd t on b.id_prod=t.id_prod
  Where cod_mag=@sCodBoutique

 if @@rowcount = 1 
 Begin
   -- Mise à jour
   Update sysadm.boutique Set adr_ville = Left(@sVille,35), 
    adr_cp = @sAdrCp, adr_nom = @sNom,
    adr_1 = @sAdr1, adr_2=@sAdr1, 
    adr_tel = @sNoTel,
    maj_le=getdate(), maj_par=@sMajPar
   From @tbLstProd t
   where sysadm.boutique.id_prod = t.id_prod and sysadm.boutique.id_boutique=@iIdBoutique
    
   -- Insertion des boutiques manquantes
  INSERT INTO sysadm.boutique(id_prod, id_boutique, 
    adr_ville, adr_cp, 
    adr_nom, cod_mag, 
    adr_1, adr_2, 
    adr_tel,
    cree_le, maj_le, maj_par)
  Select distinct t.id_prod, b.id_boutique, 
    b.adr_ville, b.adr_cp, 
    adr_nom, cod_mag, 
    adr_1, adr_2, 
    adr_tel,
    getdate(), getdate(), @sMajPar
  From sysadm.boutique b,
	@tbLstProd t
  Where b.id_prod =@refIdprod and b.id_boutique = @iIdBoutique
  And not exists (select id_boutique from sysadm.boutique b2
  where b2.id_boutique = @iIdBoutique and b2.id_prod=t.id_prod)
End
Else
Begin
  -- Insertion
  Select @iIdBoutique = max(id_boutique) + 1
  From sysadm.boutique b
  inner join @tbLstProd t on b.id_prod=t.id_prod
 
 INSERT INTO sysadm.boutique(id_prod, id_boutique, 
    adr_ville, adr_cp, 
    adr_nom, cod_mag, 
    adr_1, adr_2, 
    adr_tel,
    cree_le, maj_le, maj_par)
  Select distinct t.id_prod, @iIdBoutique, 
    Left(@sVille,35), @sAdrCp, 
    @sNom, @sCodBoutique, 
    @sAdr1, @sAdr2, 
    @sNoTel,
    getdate(), getdate(), @sMajPar
  From @tbLstProd t
  
End 

if @@error <> 0 Return -1

Return 0
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_D01_BOUTIQUE_MCM 
-- Auteur               :       F. Pinon
-- Date                 :       11/01/2011
-- Libelle              :       
-- Commentaires         :     	[PC175] 
-- References           :       
-- 
-- Arguments
--
-- Retourne             :       0 Ok, -1 erreur
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_BOUTIQUE_MCM' AND type = 'P' )
        DROP procedure sysadm.PS_D01_BOUTIQUE_MCM
GO
 
CREATE PROCEDURE sysadm.PS_D01_BOUTIQUE_MCM
	@sListeCodeMag	Varchar(3400)
AS

  Declare @sCommande	Varchar(5000)
	
  Set @sCommande = 'Delete from sysadm.boutique where id_prod between 30300 and 30399 and cod_mag not in ('
  Set @sCommande = @sCommande + @sListeCodeMag + ')'
  
  exec (@sCommande)
  
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_D02_BOUTIQUE_MCM 
-- Auteur               :       F. Pinon
-- Date                 :       14/03/2011
-- Libelle              :       
-- Commentaires         :     	[PC175.2] 
-- References           :       
-- 
-- Arguments
--
-- Retourne             :       0 Ok, -1 erreur
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D02_BOUTIQUE_MCM' AND type = 'P' )
        DROP procedure sysadm.PS_D02_BOUTIQUE_MCM
GO
 
CREATE PROCEDURE sysadm.PS_D02_BOUTIQUE_MCM
	@sCodeMag	Varchar(3400),
	@sEnseigne	Varchar(20)
AS

  Declare @tbLstProd TABLE (id_prod decimal(7,0));

  -- Définition des produits impactés
  If lower(@sEnseigne) in ('micromania','recycleware')
  Begin
    Insert into @tbLstProd
    Select id_prod from sysadm.produit
    where id_prod between 30300 and 30303 or id_prod in (30308, 30309, 30314,30315, 30326, 30327) 
	 or id_prod between 30311 and 30313 or  id_prod between 30318 and 30321
  End

  If lower(@sEnseigne) = 'dockgames'
  Begin
    Insert into @tbLstProd
    Select id_prod from sysadm.produit
    where id_prod between 30304 and 30307 or id_prod between 30322 and 30325 
  End

  Delete from sysadm.boutique 
  where id_prod in (select id_prod from  @tbLstProd)
  and cod_mag=@sCodeMag
Go


--------------------------------------------------------------------
--
-- Procedure            :       DW_S02_BOUTIQUE
-- Auteur               :       F. Pinon
-- Date                 :       14/03/2011
-- Libelle              :       Select des boutiques micromania
-- Commentaires         :     	[PC175.2] 
-- References           :       
-- 
-- Arguments
--
-- Retourne             :       0 Ok, -1 erreur
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_BOUTIQUE' AND type = 'P' )
        DROP procedure sysadm.DW_S02_BOUTIQUE
GO
 
CREATE PROCEDURE sysadm.DW_S02_BOUTIQUE
  
AS

Declare @tbLstProd TABLE (id_prod decimal(7,0), enseigne varchar(20));

-- Définition des produits impactés
Insert into @tbLstProd
Select id_prod,'micromania' from sysadm.produit
where id_prod between 30300 and 30303 or id_prod in (30308, 30309, 30314,30315, 30326, 30327) 
  or id_prod between 30311 and 30313 or  id_prod between 30318 and 30321


Insert into @tbLstProd
Select id_prod, 'dockgames' from sysadm.produit
where id_prod between 30304 and 30307 or id_prod between 30322 and 30325 


Select distinct b.id_boutique,b.cod_mag, t.enseigne
From sysadm.boutique b
  inner join @tbLstProd t on b.id_prod=t.id_prod

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I03_BOUTIQUE  
-- Auteur               :       F. Pinon
-- Date                 :       15/02/2012
-- Libelle              :       
-- Commentaires         :     	[PM200][PSM] 
-- References           :       
-- 
-- Arguments
--
-- Retourne             :       0 Ok, -1 erreur
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I03_BOUTIQUE' AND type = 'P' )
        DROP procedure sysadm.PS_I03_BOUTIQUE
GO
 
CREATE PROCEDURE sysadm.PS_I03_BOUTIQUE
  @sCodBoutique varchar(20),
  @sNom		varchar(35),
  @sAdr1	varchar(40),
  @sAdr2	varchar(40),
  @sAdrCp	varchar(5),
  @sVille	varchar(40),
  @sNoTel	varchar(20),
  @sAdrMail	varchar(250),
  @sMajPar	varchar(4) 
AS

Declare @iIdBoutique int=NULL,
  @refIdprod decimal(7,0)=NULL
  
Declare @tbLstProd TABLE (id_prod decimal(7,0), id_boutique int, id_boutique_actuelle int);

-- Vérif boutique
If ISNUMERIC(@sCodBoutique) = 1 and convert(int,@sCodBoutique) <= 0 Return 0

-- Définition des produits impactés
  Insert into @tbLstProd (id_prod)
  Select distinct id_prod from sysadm.commande_type
  Where id_code_frn='PSM'
  
  Update @tbLstProd
  Set id_boutique=(select max(b.id_boutique) from sysadm.boutique b where t.id_prod=b.id_prod),
	id_boutique_actuelle=(select top 1 id_boutique  
		from sysadm.boutique b 
		where b.id_prod = t.id_prod 
			And sysadm.FN_CLE_VAL( 'FRN',region,  ';') = 'PSM'
			and (cod_mag=@sCodBoutique or (ISNUMERIC(cod_mag) = 1 and convert(int,cod_mag) = convert(int,@sCodBoutique))))
  from @tbLstProd t  
  
  
-- Récupération de l'id_boutique de référence
  Select top 1 @refIdprod = t.id_prod, @iIdBoutique = t.id_boutique_actuelle
  From @tbLstProd t 
  Where id_boutique_actuelle is not null
  Order by id_boutique desc 
  
  	
 if @iIdBoutique is not null
 Begin
 
   update @tbLstProd 
   set id_boutique=Case when exists (select 1 from sysadm.boutique b 
		where b.id_prod=t.id_prod and b.id_boutique=convert(int,@sCodBoutique)) Then id_boutique+1 
	Else convert(int,@sCodBoutique) End
  from @tbLstProd t
   where id_boutique_actuelle is NULL
	  
   -- Mise à jour
   Update sysadm.boutique Set adr_ville = Left(@sVille,35), 
    adr_cp = @sAdrCp, adr_nom = @sNom,
    adr_1 = @sAdr1, adr_2=@sAdr2, 
    adr_tel = @sNoTel,
    adr_mail = @sAdrMail,
    maj_le=getdate(), maj_par=@sMajPar
   From @tbLstProd t
	inner join sysadm.boutique b on b.id_prod=t.id_prod and b.id_boutique=t.id_boutique_actuelle
	Where t.id_boutique_actuelle is not null
    
  -- Insertion des boutiques manquantes
   INSERT INTO sysadm.boutique(id_prod, id_boutique, 
    region, adr_ville, adr_cp, 
    adr_nom, cod_mag, 
    adr_1, adr_2, 
    adr_tel, adr_mail,
    cree_le, maj_le, maj_par)
  Select t.id_prod, t.id_boutique, 
    b.region, b.adr_ville, b.adr_cp, 
    adr_nom, cod_mag, 
    adr_1, adr_2, 
    adr_tel, adr_mail,
    getdate(), getdate(), @sMajPar
  From sysadm.boutique b,
	@tbLstProd t
  Where b.id_prod =@refIdprod and b.id_boutique = @iIdBoutique
	And t.id_boutique_actuelle is null
	
End
Else
Begin
  -- Insertion
  update @tbLstProd 
  set id_boutique=Case when exists (select 1 from sysadm.boutique b 
		where b.id_prod=t.id_prod and b.id_boutique=convert(int,@sCodBoutique)) Then id_boutique+1 
	Else convert(int,@sCodBoutique) End
  from @tbLstProd t
  
 INSERT INTO sysadm.boutique(id_prod, id_boutique, 
    adr_ville, adr_cp, 
    adr_nom, cod_mag, 
    adr_1, adr_2, 
    adr_tel, adr_mail,
	region,
    cree_le, maj_le, maj_par)
  Select distinct t.id_prod, t.id_boutique, 
    Left(@sVille,35), @sAdrCp, 
    @sNom, @sCodBoutique, 
    @sAdr1, @sAdr2, 
    @sNoTel,@sAdrMail,
	'FRN=PSM',
    getdate(), getdate(), @sMajPar
  From @tbLstProd t
  
End 

if @@error <> 0 Return -1

If @@servername=master.dbo.SPB_FN_ServerName ('PRO')
	exec SHERPA_PRO.sysadm.PS_I01_BOUTIQUE_PSM @sCodBoutique,@sNom,@sMajPar
Else
	exec SHERPA_SIM.sysadm.PS_I01_BOUTIQUE_PSM @sCodBoutique,@sNom,@sMajPar

Return 0
Go

grant execute on sysadm.[PS_I03_BOUTIQUE] to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S03_BOUTIQUE
-- Auteur               :       Abdmeziem C.
-- Date                 :       04/03/03
-- Libellé              :        
-- Commentaires         :       Select sur la table BOUTIQUE
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- 		FPI	   01/08/2012  [VDoc7726]
-- JFF      07/11/2016   [PC151259]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_BOUTIQUE' AND type = 'P' )
        DROP procedure sysadm.DW_S03_BOUTIQUE
GO

CREATE procedure sysadm.DW_S03_BOUTIQUE
        @dcIdProd        Decimal (  7, 0 )
AS

SELECT id_prod, 
   id_boutique, 
   region, 
   adr_ville, 
   adr_cp, 
   adr_tel, 
   adr_fax, 
   adr_mail, 
   adr_nom, 
   cod_mag, 
   adr_1, 
   adr_2, 
   rib_bq, 
   rib_gui, 
   rib_cpt, 
   rib_cle
 FROM   sysadm.boutique
 WHERE  boutique.id_prod = @dcIdProd
-- 	And sysadm.FN_CLE_VAL( 'FRN',region,  ';') <> 'PSM' -- [VDOC7726]
	And ( region is null Or CHARINDEX ( '=', region ) = 0 ) -- [PC151259]

  order by cod_mag
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_BOUTIQUE_ADRESSE
-- Auteur               :       JFF
-- Date                 :       10/10/2012
-- Libellé              :       [PC869] 
-- Commentaires         :       Select sur la table BOUTIQUE
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- 		FPI	   01/08/2012  [VDoc7726]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_BOUTIQUE_ADRESSE' AND type = 'P' )
        DROP procedure sysadm.PS_S_BOUTIQUE_ADRESSE
GO

CREATE procedure sysadm.PS_S_BOUTIQUE_ADRESSE
        @dcIdProd      Decimal (  7, 0 ),
        @iCodMag	   Integer,
        @sAdrNom	   VarChar ( 35 ) OUTPUT,
        @sAdr1		   VarChar ( 35 ) OUTPUT,
        @sAdr2		   VarChar ( 35 ) OUTPUT,
        @sAdrVille	   VarChar ( 35 ) OUTPUT,
        @sAdrCP		   VarChar ( 35 ) OUTPUT
AS

Select	@sAdrNom = IsNull ( adr_nom, ''),
		@sAdr1	 = IsNull ( adr_1, ''),
		@sAdr2   = IsNull ( adr_2, ''),
		@sAdrVille = IsNull ( adr_ville, ''),
		@sAdrCP = IsNull ( adr_cp, '')
From sysadm.boutique b
Where b.id_prod = 9111
And   convert ( integer, b.cod_mag ) = @iCodMag

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_BOUTIQUE_ADRESSE_2
-- Auteur               :       JFF
-- Date                 :       07/04/2015
-- Libellé              :       [PC13442-1] 
-- Commentaires         :       Select sur la table BOUTIQUE
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_BOUTIQUE_ADRESSE_2' AND type = 'P' )
        DROP procedure sysadm.PS_S_BOUTIQUE_ADRESSE_2
GO

CREATE procedure sysadm.PS_S_BOUTIQUE_ADRESSE_2
        @dcIdProd      Decimal (  7, 0 ),
        @idBoutique	   integer,
		@sAdrMail	   VarChar ( 35 ) OUTPUT,
        @sAdrNom	   VarChar ( 35 ) OUTPUT,
        @sAdr1		   VarChar ( 35 ) OUTPUT,
        @sAdr2		   VarChar ( 35 ) OUTPUT,
        @sAdrVille	   VarChar ( 35 ) OUTPUT,
        @sAdrCP		   VarChar ( 35 ) OUTPUT
AS

Select	@sAdrMail = IsNull ( rtrim( b.adr_mail ), '' ),
		@sAdrNom = IsNull ( rtrim( b.adr_nom ), ''),
		@sAdr1	 = IsNull ( rtrim( b.adr_1 ) , ''),
		@sAdr2   = IsNull ( rtrim( b.adr_2 ) , ''),
		@sAdrVille = IsNull ( rtrim( b.adr_ville), ''),
		@sAdrCP = IsNull ( rtrim( b.adr_cp ), '')
From sysadm.boutique b
Where b.id_prod = @dcIdProd
And   b.id_boutique = @idBoutique
And	  b.region is null

Go
--------------------------------------------------------------------
--
-- Procédure            :       DW_S_BOUTIQUE_PSM
-- Auteur               :       FPI
-- Date                 :       13/04/2015
-- Libellé              :       [PM284-1] 
-- Commentaires         :       Select sur la table BOUTIQUE
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_BOUTIQUE_PSM' AND type = 'P' )
        DROP procedure sysadm.DW_S_BOUTIQUE_PSM
GO

CREATE procedure sysadm.DW_S_BOUTIQUE_PSM
        @dcIdProd      Decimal (  7, 0 ),
        @sCodmag	   varchar(20)
As

Declare @iCodMag int

set @iCodMag=convert(int,@sCodmag)

select cod_mag, adr_nom,
  adr_1, adr_2,
  adr_cp, adr_ville,
  adr_tel,
  adr_mail
from sysadm.boutique
where id_prod = @dcIdProd
  and (isnumeric(cod_mag) = 1 And convert(int,cod_mag)=@iCodMag)
  And sysadm.FN_CLE_VAL( 'FRN',region,  ';') = 'PSM'

Go

grant execute on sysadm.DW_S_BOUTIQUE_PSM to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I01_BOUTIQUE_PSM  
-- Auteur               :       F. Pinon
-- Date                 :       09/09/2016
-- Libelle              :       
-- Commentaires         :     	Intégration boutiques PSM (ETL)
-- References           :       
-- 
-- Arguments
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_BOUTIQUE_PSM' AND type = 'P' )
        DROP procedure sysadm.PS_I01_BOUTIQUE_PSM
GO
 
CREATE PROCEDURE sysadm.PS_I01_BOUTIQUE_PSM
  @dcIdProd decimal(10,0),
  @sCodBoutique varchar(20),
  @sVille	varchar(35),
  @sAdrCp	varchar(5),
  @sNom		varchar(35),
  @sAdr1	varchar(40),
  @sAdr2	varchar(40),
  @sNumTel varchar(20),
  @sAdrMail	varchar(255),
  @sMajPar	varchar(4)  
AS

 Declare @iIdBoutique int

 Set @iIdBoutique=convert(int,@sCodBoutique)

 If Exists (select 1 from sysadm.boutique where id_prod=@dcIdProd and id_boutique=@iIdBoutique)
 Begin
  Select @iIdBoutique=max(id_boutique) + 1
  From sysadm.boutique 
  where id_prod=@dcIdProd
 End 

 INSERT INTO sysadm.boutique(id_prod, id_boutique, 
    region, adr_ville, adr_cp, 
    adr_nom, cod_mag, 
    adr_1, adr_2, 
    adr_tel, adr_mail,
    cree_le, maj_le, maj_par)
  Values (@dcIdProd, @iIdBoutique, 
    'FRN=PSM', @sVille, @sAdrCp, 
    @sNom, @sCodBoutique, 
    @sAdr1, @sAdr2, 
    @sNumTel, @sAdrMail,
    getdate(), getdate(), @sMajPar)
Go

grant execute on sysadm.PS_I01_BOUTIQUE_PSM to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_BOUTIQUE_ADRESSE_3
-- Auteur               :       JFF
-- Date                 :       08/11/2016
-- Libellé              :       [PC151259]
-- Commentaires         :       Select sur la table BOUTIQUE
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_BOUTIQUE_ADRESSE_3' AND type = 'P' )
        DROP procedure sysadm.PS_S_BOUTIQUE_ADRESSE_3
GO

CREATE procedure sysadm.PS_S_BOUTIQUE_ADRESSE_3
        @dcIdProd      Decimal (  7, 0 ),
		@sIdFour       Varchar ( 3 ),
		@sCodMag	   VarChar ( 20 ),
		@sAdrMail	   VarChar ( 128 ) OUTPUT,
        @sAdrNom	   VarChar ( 35 ) OUTPUT,
        @sAdr1		   VarChar ( 35 ) OUTPUT,
        @sAdr2		   VarChar ( 35 ) OUTPUT,
        @sAdrVille	   VarChar ( 35 ) OUTPUT,
        @sAdrCP		   VarChar ( 35 ) OUTPUT
AS

Select	Top 1
		@sAdrMail = IsNull ( rtrim( b.adr_mail ), '' ),
		@sAdrNom = IsNull ( rtrim( b.adr_nom ), ''),
		@sAdr1	 = IsNull ( rtrim( b.adr_1 ) , ''),
		@sAdr2   = IsNull ( rtrim( b.adr_2 ) , ''),
		@sAdrVille = IsNull ( rtrim( b.adr_ville), ''),
		@sAdrCP = IsNull ( rtrim( b.adr_cp ), '')
From sysadm.boutique b
Where b.id_prod = @dcIdProd
And   sysadm.FN_CLE_VAL( 'FRN', region, ';') = @sIdFour
And   b.cod_mag = @sCodMag

Go
--------------------------------------------------------------------
--
-- Procédure            :       PS_S_BOUTIQUE_ADRESSE_4
-- Auteur               :       FPI
-- Date                 :       01/12/2017
-- Libellé              :       [VDoc25239]
-- Commentaires         :       Select sur la table BOUTIQUE
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_BOUTIQUE_ADRESSE_4' AND type = 'P' )
        DROP procedure sysadm.PS_S_BOUTIQUE_ADRESSE_4
GO

CREATE procedure sysadm.PS_S_BOUTIQUE_ADRESSE_4
        @dcIdProd      Decimal (  7, 0 ),
		@sIdFour       Varchar ( 3 ),
		@sCodMag	   VarChar ( 20 ),
		@sAdrMail	   VarChar ( 250 ) OUTPUT,
        @sAdrNom	   VarChar ( 35 ) OUTPUT,
        @sAdr1		   VarChar ( 35 ) OUTPUT,
        @sAdr2		   VarChar ( 35 ) OUTPUT,
        @sAdrVille	   VarChar ( 35 ) OUTPUT,
        @sAdrCP		   VarChar ( 35 ) OUTPUT,
		@sAdrTel	   VarChar ( 20 ) OUTPUT
AS

Select	Top 1
		@sAdrMail = IsNull ( rtrim( b.adr_mail ), '' ),
		@sAdrNom = IsNull ( rtrim( b.adr_nom ), ''),
		@sAdr1	 = IsNull ( rtrim( b.adr_1 ) , ''),
		@sAdr2   = IsNull ( rtrim( b.adr_2 ) , ''),
		@sAdrVille = IsNull ( rtrim( b.adr_ville), ''),
		@sAdrCP = IsNull ( rtrim( b.adr_cp ), ''),
		@sAdrTel = IsNull ( rtrim( b.adr_tel ), '')
From sysadm.boutique b
Where b.id_prod = @dcIdProd
And   sysadm.FN_CLE_VAL( 'FRN', region, ';') = @sIdFour
And   b.cod_mag = @sCodMag

Go

grant execute on sysadm.PS_S_BOUTIQUE_ADRESSE_4 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S04_BOUTIQUE
-- Auteur               :       FPI
-- Date                 :       13/02/2017
-- Libellé              :        [VDoc22982]
-- Commentaires         :       Select sur la table BOUTIQUE avec retour par référence
--
-- Arguments            :       @dcIdProd	Decimal (7,0) Val
--				@iIdBoutique	Integer	      Val
--				@sNom	VarChar ( 35 ) Réf
--				@sAdrVille	VarChar ( 35 ) Réf
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S04_BOUTIQUE' AND type = 'P' )
        DROP procedure sysadm.PS_S04_BOUTIQUE
GO

CREATE procedure sysadm.PS_S04_BOUTIQUE
        @dcIdProd       Decimal (  7, 0 ),
	@iIdBoutique	Integer,	      
	@sNom	VarChar ( 35 ) OUTPUT,
	@sAdrVille	VarChar ( 35 ) OUTPUT
AS
 SELECT @sAdrVille = b.adr_ville,
	@sNom=b.adr_nom
 FROM   sysadm.boutique b
 WHERE  b.id_prod = @dcIdProd
 AND	b.id_boutique = @iIdBoutique

GO


grant execute on sysadm.PS_S04_BOUTIQUE to rolebddsinistres
Go
