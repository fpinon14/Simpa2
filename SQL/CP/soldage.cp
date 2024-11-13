-------------------------------------------------------------------
--
-- Fichier              :       SOLDAGE.CP
-- Auteur               :       JCA
-- Date                 :       21/11/2007
--
-- Commentaires         :       Gestion du soldage
--
-- Procédures           :       
--
-- sysadm.PS_RECUP_DOSSIER_ASOLDER
-- sysadm.PS_BOITE_ARCHIVE
-- sysadm.PS_D01_SOLDAGE_PRESCRIPTION
-- sysadm.PS_I01_TRACE_SOLDAGE
-- sysadm.PS_RECUP_DOSSIER_A_PRESCRIRE
-- sysadm.PS_SOLDAGE
-- sysadm.PS_SOLDAGE_PRESCRIRE
-- sysadm.PS_SOLDAGE_ZQUE
-------------------------------------------------------------------


/****** Objet :  Procédure stockée sysadm.PS_I01_TRACE_SOLDAGE    Date du script : 09/10/2007 11:46:29 ******/
-- JFF      12/02/2016   [PI062]
if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_I01_TRACE_SOLDAGE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_I01_TRACE_SOLDAGE]
GO

CREATE PROCEDURE sysadm.PS_I01_TRACE_SOLDAGE
	@idTrt			integer,
	@typTrt			varchar(3),
	@idProd			decimal(7,0),
	@idSin			decimal(10,0),  -- [PI062]
	@nomAss			varchar(35),
	@prenomAss		varchar(35),
	@valideParDos		varchar(4),
	@valideLeDos		datetime,
	@dteSoldage		datetime,
	@dteMaxSoldRl		datetime,
	@dteMaxSoldPc		datetime,
	@etatTrt		varchar(70)
AS

-- # DCMP 60691 # 
SET NOCOUNT ON

DECLARE @RC integer

SET @RC = 0 

-- Pas d'affichage des resultat
SET NOCOUNT ON

INSERT sysadm.trace_soldage
VALUES(
@idTrt,
@typTrt,
@idProd,
@idSin,
@nomAss,
@prenomAss,
@valideParDos,
@valideLeDos,
@dteSoldage,
@dteMaxSoldRl,
@dteMaxSoldPc,
@etatTrt
)

IF @@ERROR <> 0 SET @RC = -1

RETURN @RC

GO

-- JFF      12/02/2016   [PI062]
/****** Objet :  Procédure stockée sysadm.PS_BOITE_ARCHIVE    Date du script : 08/10/2007 19:13:41 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_BOITE_ARCHIVE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_BOITE_ARCHIVE]
GO

CREATE procedure sysadm.PS_BOITE_ARCHIVE
        @adcIdSin       Decimal (10,0), -- [PI062]
        @asIdOper       VarChar (10),
	@code		varchar(15)	OUTPUT
AS

SET NOCOUNT ON

Declare @dcIdRev        Decimal (  7,0 )
Declare @dcIdProd       Decimal (  7,0 )
Declare @dcIdEts        Decimal (  7,0 )
Declare @dcIdCie        Decimal (  7,0 )
Declare @dcIdProfil     Decimal (  7,0 )
Declare @dDateJour      DateTime
Declare @sBoiteCourante VarChar (  10  )
Declare @iIdTypArch	integer
declare @countRoutage	integer
declare @continuer	integer -- si 1 on continue / si -1 on arrete

/*------------------------------------------------------------------*/
/* Initialisation des variables                                     */
/*------------------------------------------------------------------*/
SET @dcIdCie    = -1
SET @dDateJour  = CONVERT ( DateTime, CONVERT ( VarChar ( 10 ), GetDate (), 103 ) )
SET @continuer	= 1

/*------------------------------------------------------------------*/
/* On récupére ID_PROD et ID_REV du sinistre en cours de traitement.*/
/*------------------------------------------------------------------*/
SELECT  @dcIdRev        = ws.id_rev,
        @dcIdProd       = ws.id_prod,
        @dcIdEts        = ws.id_ets
FROM    sysadm.w_sin    AS ws
WHERE   ws.id_sin = @adcIdSin

/*------------------------------------------------------------------*/
/* Si la révision est indéterlinée, on prend la dernière en cours.  */
/* Cela va nous donner - logiquement - la compagnie qui gére        */
/* actuellement les dossiers.                                       */
/*------------------------------------------------------------------*/
IF      @dcIdRev = -1
        BEGIN
                SELECT  @dcIdRev = MAX ( gar.id_rev )
                FROM    sysadm.garantie         AS gar
                WHERE   gar.id_prod = @dcIdProd
        END

/*------------------------------------------------------------------*/
/* Si la zone ID_REV est connu, on effectue une recherche dans la   */
/* table GARANTIE et POLICE afin d'obtenir la Compagnie qui gére le */
/* produit. S'il existe plusieurs Compagnies, on affecte -1. Il     */
/* impossible d'archiver le dossier dans une boite à archive.       */
/*------------------------------------------------------------------*/
IF      @dcIdRev <> -1
        BEGIN
                SELECT DISTINCT @dcIdCie = pol.id_cie
                FROM            sysadm.garantie         AS gar
                INNER JOIN      sysadm.police           AS pol 
                ON              gar.id_police = pol.id_police
                WHERE           gar.id_prod     = @dcIdProd             AND
                                gar.id_rev      = @dcIdRev

                IF      @@RowCount <> 1
                        BEGIN
                                SET @dcIdCie = -1
                        END
        END

/*------------------------------------------------------------------*/
/* On va maintenant récupérer la valeur du PROFIL en fonction du    */
/* produit, de l'établissement et de la révision. Si on ne trouve   */
/* rien pour l'établissement en cours, on essaye avec un N°         */
/* générique (-1).                                                  */
/*------------------------------------------------------------------*/
IF      @dcIdCie > 0 And @dcIdCie IS NOT NULL
        BEGIN
                SELECT  @dcIdProfil     = rgp.id_profil,
                        @iIdTypArch     = prof.id_typ_arch
                FROM    sysadm.wkfs_regroup     AS rgp
                INNER JOIN sysadm.wkfs_profil as prof
                ON      rgp.id_profil   = prof.id_profil
                WHERE   rgp.id_prod     = @dcIdProd             AND
                        rgp.id_ets      = @dcIdEts              AND
                        rgp.id_cie      = @dcIdCie              AND
                        rgp.dte_val_deb <= @dDateJour           AND
      rgp.dte_val_fin >  @dDateJour

                        
                IF      @@ROWCOUNT = 0
                        BEGIN
                                SELECT  @dcIdProfil     = rgp.id_profil,
                                        @iIdTypArch     = prof.id_typ_arch
                                FROM    sysadm.wkfs_regroup     AS rgp
                                INNER JOIN sysadm.wkfs_profil as prof
                                ON      rgp.id_profil   = prof.id_profil
                                WHERE   rgp.id_prod     = @dcIdProd             AND
                                        rgp.id_ets      = -1                    AND
                                        rgp.id_cie      = @dcIdCie              AND
                                        rgp.dte_val_deb <= @dDateJour           AND
                                        rgp.dte_val_fin >  @dDateJour
                        END
/*------------------------------------------------------------------*/
/* Si la méthode d'archivage est une méthode privée il faut         */
/* récupérer le N° de la boite courante pour l'opérateur qui est en */
/* train de valider le dossier. Ce N° de boite courante peut-être   */
/* NULL (si l'opérateur n'a jamais validé de dossier).              */
/*------------------------------------------------------------------*/
/* Il ne doit pas exister deux boites ouvertes en même temps.       */
/*------------------------------------------------------------------*/
                IF      @iIdTypArch = 1 And @dcIdProfil IS NOT NULL
                        BEGIN
                                SELECT  @sBoiteCourante = boite.no_boite
                                FROM    sysadm.wkfs_boite       AS boite
                                WHERE   boite.id_profil         = @dcIdProfil           AND
                                        boite.id_oper           = @asIdOper             AND
                                        boite.alt_ouverte       = 'O'
/*------------------------------------------------------------------*/
/* Il ne doit exister qu'une seule boite ouverte en même temps.     */
/* Dans le cas contraire, il y a une erreur.                        */
/*------------------------------------------------------------------*/
                                IF      @@ROWCOUNT > 1
                                        BEGIN
                                                SET @sBoiteCourante = 'ERREUR 01'
                                        END
                        END
        END

IF @dcIdCie IS NULL
        BEGIN
                SET @dcIdCie = -1
        END
IF @dcIdProfil IS NULL
        BEGIN
                SET @dcIdProfil = -1
        END

SELECT  @countRoutage = count(rou.id_sin)
FROM    sysadm.routage	AS rou
WHERE   rou.id_sin = @adcIdSin

IF @countRoutage <> 1
	BEGIN
		SET @code = 'BARC005'
		SET @continuer = -1
	END
	
IF @continuer = 1 AND @dcIdCie = -1
	BEGIN
		SET @code = 'BARC010'
		SET @continuer = -1
	END

IF @continuer = 1 AND @dcIdProfil = -1
	BEGIN
		SET @code = 'BARC015'
		SET @continuer = -1
	END

IF @continuer = 1 AND @iIdTypArch = 1 AND @sBoiteCourante = 'ERREUR 01'
	BEGIN
		SET @code = 'BARC020'
		SET @continuer = -1
	END

IF @continuer = 1 
	BEGIN
		-- Privée
		IF @iIdTypArch = 1	SET @code = '-1'
		-- Centralisée
		IF @iIdTypArch = 2	SET @code = 'CENTRALISE'
	END

RETURN @continuer

GO

/****** Objet :  Procédure stockée sysadm.PS_RECUP_DOSSIER_ASOLDER    Date du script : 08/10/2007 17:10:43 ******/
-- JFF      12/02/2016   [PI062]
-- JFF      23/01/2018   [PM407-1]
if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_RECUP_DOSSIER_ASOLDER]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [sysadm].[PS_RECUP_DOSSIER_ASOLDER]
GO

CREATE procedure [sysadm].[PS_RECUP_DOSSIER_ASOLDER]
	@dcIdProd    	Decimal ( 7,0 ),
        @sAltRl2     	VarChar ( 1   ),
	@sAltSoldRl	VarChar ( 1   ),
	@dtDateMaxSolRl DateTime,
	@dtDateMaxSolPc DateTime
AS

-- # DCMP 60691 # 
SET NOCOUNT ON

DECLARE @error_insert integer
DECLARE @iPM407NlleMethode integer
DECLARE @iPM407IdDernRel integer

-- [PM407-1]
Set @iPM407NlleMethode = 0
Set @iPM407IdDernRel = 0

-- Suppression des lignes de l'ancien traitement
-- [I027] - France - Suppression instruction incompatible réplication transactionelle
-- TRUNCATE TABLE sysadm.tmp_soldage
DELETE FROM sysadm.tmp_soldage

-- [PM407-1]
If Exists ( 
	Select Top 1 1
	From   sysadm.det_pro dp
	Where  dp.id_code_dp = 323
	And    dp.id_code_car = 'SOLDAG'
	And    dp.id_prod = @dcIdProd
	)
	Begin 
		Set @iPM407NlleMethode = 1

		Select Top 1 @iPM407IdDernRel = Convert ( Varchar, sysadm.FN_CLE_VAL ( 'ID_REL', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ))
		From   sysadm.det_pro dp
		Where  dp.id_code_dp = 323
		And    dp.id_code_car = 'RELANC'
		And    dp.id_prod = @dcIdProd
		And    sysadm.FN_CLE_VAL ( 'DERN_REL', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ) = 'OUI'
			 
		If @iPM407IdDernRel is null Set @iPM407IdDernRel = 0

	End 



-----------------------------------------------------------------
-- Le soldage est diff‚rent si le produit pr‚voit des 2Šmes relances
If @sAltRl2 = 'O' and @sAltSoldRl = 'O'
BEGIN

-----------------------------------------------------------------
-- CAS A : Le produit pr‚voit des 2Šme relances, donc on       --
-- s‚lectionne les dossiers ayant eu une deuxiŠme relance.     --
-- Ce courrier de deuxiŠme relance doit ˆtre le dernier envoy‚.--
-----------------------------------------------------------------
Create Table sysadm.#Tmp_Arch1
( id_sin	Decimal ( 10,0 ), -- [PI062]
  max_maj_le	datetime       ,
  nom		VarChar ( 35  ),
  prenom	VarChar ( 35  ), 
  valide_le     datetime       ,
  valide_par    VarChar ( 4   )
)

-- [PM407-1]
IF @iPM407NlleMethode > 0 
	Begin
		Insert  Into sysadm.#Tmp_Arch1
		Select  sin.id_sin,
			Max ( arch.maj_le ),
			pers.nom,
			pers.prenom,
			sin.valide_le,
			sin.valide_par

		From 	sysadm.sinistre 	sin,
			sysadm.archive  	arch,
			sysadm.routage  	rout,
			sysadm.personne		pers

		Where	arch.id_prod   		= @dcIdProd
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	in ( 100, 550 )
		and     ( arch.id_cour = 'ALAX' + Right ( '00' + Convert ( varchar, @iPM407IdDernRel ), 2 )
					Or 
					arch.id_cour = 'BLAX' + Right ( '00' + Convert ( varchar, @iPM407IdDernRel ), 2 )
				) 
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and     pers.id_ordre		= sin.id_ordre

		group by sin.id_sin, sin.valide_le, sin.valide_par, pers.nom, pers.prenom
		having  Max ( arch.maj_le )	<= @dtDateMaxSolRl
	End
Else
	Begin
		Insert  Into sysadm.#Tmp_Arch1
		Select  sin.id_sin,
			Max ( arch.maj_le ),
			pers.nom,
			pers.prenom,
			sin.valide_le,
			sin.valide_par

		From 	sysadm.sinistre 	sin,
			sysadm.archive  	arch,
			sysadm.routage  	rout,
			sysadm.personne		pers

		Where	arch.id_prod   		= @dcIdProd
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	in ( 100, 550 )
		and     arch.id_cour		in ( 'ALAX02', 'BLAX02' )
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and     pers.id_ordre		= sin.id_ordre

		group by sin.id_sin, sin.valide_le, sin.valide_par, pers.nom, pers.prenom
		having  Max ( arch.maj_le )	<= @dtDateMaxSolRl
	End 

-----------------------------------------------------------------
-- Cas B : S‚lection des dossiers dont la date de validation   --
-- est ant‚rieure … @dtDateMaxSolPc et qui n'ont jamais eu de  --
-- courriers.						       --
-----------------------------------------------------------------
Create Table sysadm.#Tmp_Arch2
( id_sin	Decimal ( 10,0 ), -- [PI062]
  id_ordre	Decimal ( 7,0 ),
  valide_le	Datetime       ,
  valide_par	VarChar ( 4   ))


Insert  Into sysadm.#Tmp_Arch2
Select  sin.id_sin,
	sin.id_ordre,
	sin.valide_le,
	sin.valide_par

From 	sysadm.sinistre 	sin

Where	sin.id_prod   		= @dcIdProd
and    	sin.cod_etat      	in ( 100, 550 )
and     not exists ( Select arch.id_sin
		     From   sysadm.archive arch
		     where  arch.id_sin = sin.id_sin )
and     sin.valide_le 		<= @dtDateMaxSolPc


-----------------------------------------------------------------
-- CAS C : S‚lection des dossiers dont la date de l'edition du --
-- dernier courrier quel qu'il soit, est ant‚rieure … 	       --
-- @dtDateMaxSolPc  					       --
-- On ne prend pas les courriers de 2Šmes relances, ils sont   --
-- trait‚ dans le CAS A.				       --
-----------------------------------------------------------------
Create Table sysadm.#Tmp_Arch3
( id_sin	Decimal ( 10,0 ),-- [PI062]
  max_maj_le	Datetime       ,
  nom		VarChar ( 35  ),
  prenom	VarChar ( 35  ), 
  valide_le     Datetime       ,
  valide_par    VarChar ( 4   ))

-- [PM407-1]
IF @iPM407NlleMethode > 0 
	Begin
 		Insert  Into sysadm.#Tmp_Arch3
		Select  sin.id_sin,
			Max ( arch.maj_le ),
			pers.nom,
			pers.prenom,
			sin.valide_le,
			sin.valide_par


		From 	sysadm.sinistre 	sin,
			sysadm.archive  	arch,
			sysadm.routage  	rout,
			sysadm.personne		pers


		Where	arch.id_prod   		= @dcIdProd
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	in ( 100, 550 )
		and     NOT (
						( arch.id_cour = 'ALAX' + Right ( '00' + Convert ( varchar, @iPM407IdDernRel ), 2 )
							Or 
							arch.id_cour = 'BLAX' + Right ( '00' + Convert ( varchar, @iPM407IdDernRel ), 2 )
						) 
					)
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and     pers.id_ordre		= sin.id_ordre

		group by sin.id_sin, pers.nom, pers.prenom, sin.valide_le, sin.valide_par
		having  Max ( arch.maj_le )	<= @dtDateMaxSolPc

	End
Else
	Begin
 		Insert  Into sysadm.#Tmp_Arch3
		Select  sin.id_sin,
			Max ( arch.maj_le ),
			pers.nom,
			pers.prenom,
			sin.valide_le,
			sin.valide_par


		From 	sysadm.sinistre 	sin,
			sysadm.archive  	arch,
			sysadm.routage  	rout,
			sysadm.personne		pers


		Where	arch.id_prod   		= @dcIdProd
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	in ( 100, 550 )
		and     arch.id_cour		not in ( 'ALAX02', 'BLAX02' )
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and     pers.id_ordre		= sin.id_ordre

		group by sin.id_sin, pers.nom, pers.prenom, sin.valide_le, sin.valide_par
		having  Max ( arch.maj_le )	<= @dtDateMaxSolPc
	End 


-----------------------------------------------------------------
-- En cas de doublon entre le CAS A et C on utilise le Select Max les se 
-- chargera de n'en garder qu'un.

-- CAS A
INSERT sysadm.tmp_soldage

SELECT 	#Tmp_Arch1.id_sin,
	#Tmp_Arch1.nom,
	#Tmp_Arch1.prenom,
	#Tmp_Arch1.valide_par,
	#Tmp_Arch1.valide_le
FROM 	sysadm.#Tmp_Arch1
WHERE   #Tmp_Arch1.max_maj_le = ( Select  max ( arch.maj_le )
			  	  From    sysadm.archive arch
			  	  Where   arch.id_sin = #Tmp_Arch1.id_sin )

UNION ALL

-- CAS B
Select 	#Tmp_Arch2.id_sin,
	pers.nom,
	pers.prenom,
	#Tmp_Arch2.valide_par,
	#Tmp_Arch2.valide_le
From 	sysadm.#Tmp_Arch2,
	sysadm.routage  	rout,
	sysadm.personne		pers
where	rout.id_sin		= #Tmp_Arch2.id_sin
and     rout.alt_queue		= 'N'
and     pers.id_ordre		= #Tmp_Arch2.id_ordre

UNION ALL

-- CAS C
Select 	#Tmp_Arch3.id_sin,
	#Tmp_Arch3.nom,
	#Tmp_Arch3.prenom,
	#Tmp_Arch3.valide_par,
	#Tmp_Arch3.valide_le


From 	sysadm.#Tmp_Arch3
Where   #Tmp_Arch3.max_maj_le = ( Select  max ( arch.maj_le )
			  	  From    sysadm.archive arch
			  	  Where   arch.id_sin = #Tmp_Arch3.id_sin )

SET @error_insert = @@ERROR

Drop Table sysadm.#Tmp_Arch1
Drop Table sysadm.#Tmp_Arch2
Drop Table sysadm.#Tmp_Arch3

IF @error_insert <> 0 GOTO ONERROR

END

IF @sAltRl2 = 'N' and @sAltSoldRl = 'O'
BEGIN
-----------------------------------------------------------------
-- CAS A : Le produit ne pr‚voit pas de 2Šme relances, donc on --
-- s‚lectionne les dossiers ayant eu une relance quelconque    --
-- Ce courrier de relance doit ˆtre le dernier envoy‚.	       --
-----------------------------------------------------------------
Create Table sysadm.#Tmp_Arch4
( id_sin	Decimal ( 10,0 ), -- [PI062]
  max_maj_le	Datetime       ,
  nom		VarChar ( 35  ),
  prenom	VarChar ( 35  ), 
  valide_le     Datetime       ,
  valide_par    VarChar ( 4   ))


-- [PM407-1]
IF @iPM407NlleMethode > 0 
	Begin
		Insert  Into sysadm.#Tmp_Arch4
		Select  sin.id_sin,
			Max ( arch.maj_le ),
			pers.nom,
			pers.prenom,
			sin.valide_le,
			sin.valide_par

		From 	sysadm.sinistre 	sin,
			sysadm.archive  	arch,
			sysadm.routage  	rout,
			sysadm.personne		pers

		Where	arch.id_prod   		= @dcIdProd
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	in ( 100, 550 )
		And     ( Left ( arch.id_cour, 4 ) = 'ALAX'
					Or 
					Left ( arch.id_cour, 4 ) = 'BLAX'
					Or 
					Left ( arch.id_cour, 3 ) = 'ALQ'
				)
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and     pers.id_ordre		= sin.id_ordre

		group by sin.id_sin, sin.valide_le, sin.valide_par, pers.nom, pers.prenom
		having  Max ( arch.maj_le )	<= @dtDateMaxSolRl
	End 
Else 
	Begin
		Insert  Into sysadm.#Tmp_Arch4
		Select  sin.id_sin,
			Max ( arch.maj_le ),
			pers.nom,
			pers.prenom,
			sin.valide_le,
			sin.valide_par

		From 	sysadm.sinistre 	sin,
			sysadm.archive  	arch,
			sysadm.routage  	rout,
			sysadm.personne		pers

		Where	arch.id_prod   		= @dcIdProd
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	in ( 100, 550 )
		and     arch.id_cour		in ( 'ALAX01', 'BLAX01', 'ALAX02', 'BLAX02', 'ALQ001' )
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and     pers.id_ordre		= sin.id_ordre

		group by sin.id_sin, sin.valide_le, sin.valide_par, pers.nom, pers.prenom
		having  Max ( arch.maj_le )	<= @dtDateMaxSolRl
	End
-----------------------------------------------------------------
-- Cas B : S‚lection des dossiers dont la date de validation   --
-- est ant‚rieure … @dtDateMaxSolPc et qui n'ont jamais eu de  --
-- courriers.						       --
-----------------------------------------------------------------
Create Table sysadm.#Tmp_Arch5
( id_sin	Decimal ( 10,0 ), -- [PI062]
  id_ordre	Decimal ( 7,0 ),
  valide_le	Datetime       ,
  valide_par	VarChar ( 4   ))


Insert  Into sysadm.#Tmp_Arch5
Select  sin.id_sin,
	sin.id_ordre,
	sin.valide_le,
	sin.valide_par

From 	sysadm.sinistre 	sin

Where	sin.id_prod   		= @dcIdProd
and    	sin.cod_etat      	in ( 100, 550 )
and     not exists ( Select arch.id_sin
		     From   sysadm.archive arch
		     where  arch.id_sin = sin.id_sin )
and     sin.valide_le 		<= @dtDateMaxSolPc



-----------------------------------------------------------------
-- CAS C : S‚lection des dossiers dont la date de d'edition du --
-- dernier courrier quel qu'il soit, est ant‚rieure … 	       --
-- @dtDateMaxSolPc  					       --
-----------------------------------------------------------------
Create Table sysadm.#Tmp_Arch6
( id_sin	Decimal ( 10,0 ), -- [PI062]
  max_maj_le	Datetime       ,
  nom		VarChar ( 35  ),
  prenom	VarChar ( 35  ), 
  valide_le     Datetime       ,
  valide_par    VarChar ( 4   ))

-- [PM407-1]
IF @iPM407NlleMethode > 0 
	Begin
		Insert  Into sysadm.#Tmp_Arch6
		Select  sin.id_sin,
			Max ( arch.maj_le ),
			pers.nom,
			pers.prenom,
			sin.valide_le,
			sin.valide_par


		From 	sysadm.sinistre 	sin,
			sysadm.archive  	arch,
			sysadm.routage  	rout,
			sysadm.personne		pers


		Where	arch.id_prod   		= @dcIdProd
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	in ( 100, 550 )

		And     NOT ( 
						( Left ( arch.id_cour, 4 ) = 'ALAX'
							Or 
							Left ( arch.id_cour, 4 ) = 'BLAX'
							Or 
							Left ( arch.id_cour, 3 ) = 'ALQ'
						)
					)
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and     pers.id_ordre		= sin.id_ordre

		group by sin.id_sin, pers.nom, pers.prenom, sin.valide_le, sin.valide_par
		having  Max ( arch.maj_le )	<= @dtDateMaxSolPc

	End 
Else 
	Begin
		Insert  Into sysadm.#Tmp_Arch6
		Select  sin.id_sin,
			Max ( arch.maj_le ),
			pers.nom,
			pers.prenom,
			sin.valide_le,
			sin.valide_par


		From 	sysadm.sinistre 	sin,
			sysadm.archive  	arch,
			sysadm.routage  	rout,
			sysadm.personne		pers


		Where	arch.id_prod   		= @dcIdProd
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	in ( 100, 550 )
		and     arch.id_cour		not in ( 'ALAX01', 'BLAX01', 'ALAX02', 'BLAX02', 'ALQ001' )
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and     pers.id_ordre		= sin.id_ordre

		group by sin.id_sin, pers.nom, pers.prenom, sin.valide_le, sin.valide_par
		having  Max ( arch.maj_le )	<= @dtDateMaxSolPc

	End 


-----------------------------------------------------------------
-- Select pour la DataWindow 				       --
-----------------------------------------------------------------

-- CAS A
INSERT sysadm.tmp_soldage

Select 	#Tmp_Arch4.id_sin,
	#Tmp_Arch4.nom,
	#Tmp_Arch4.prenom,
	#Tmp_Arch4.valide_par,
	#Tmp_Arch4.valide_le
From 	sysadm.#Tmp_Arch4
Where   #Tmp_Arch4.max_maj_le = ( Select  max ( arch.maj_le )
			  	  From    sysadm.archive arch
			  	  Where   arch.id_sin = #Tmp_Arch4.id_sin )

UNION ALL

-- CAS B
Select 	#Tmp_Arch5.id_sin,
	pers.nom,
	pers.prenom,
	#Tmp_Arch5.valide_par,
	#Tmp_Arch5.valide_le
From 	sysadm.#Tmp_Arch5,
	sysadm.routage  	rout,
	sysadm.personne		pers
where	rout.id_sin		= #Tmp_Arch5.id_sin
and     rout.alt_queue		= 'N'
and     pers.id_ordre		= #Tmp_Arch5.id_ordre

UNION ALL

-- CAS C
Select 	#Tmp_Arch6.id_sin,
	#Tmp_Arch6.nom,
	#Tmp_Arch6.prenom,
	#Tmp_Arch6.valide_par,
	#Tmp_Arch6.valide_le
From 	sysadm.#Tmp_Arch6
where   #Tmp_Arch6.max_maj_le = ( Select  max ( arch.maj_le )
			  	  From    sysadm.archive arch
			  	  Where   arch.id_sin = #Tmp_Arch6.id_sin )

SET @error_insert = @@ERROR

Drop Table sysadm.#Tmp_Arch4
Drop Table sysadm.#Tmp_Arch5
Drop Table sysadm.#Tmp_Arch6

IF @error_insert <> 0 GOTO ONERROR

END



IF @sAltSoldRl = 'N'
BEGIN

-----------------------------------------------------------------
-- Le produit ne pr‚voit pas de soldage des dossiers r‚cemment relacné
-- Pas de CAS A, Pas de table sysadm.#Tmp_Arch

Create Table sysadm.#Tmp_Arch7
( id_sin	Decimal ( 10,0 ),-- [PI062]
  id_ordre	Decimal ( 7,0 ),
  valide_le	Datetime       ,
  valide_par	VarChar ( 4   ))

Insert  Into sysadm.#Tmp_Arch7
Select  sin.id_sin,
	sin.id_ordre,
	sin.valide_le,
	sin.valide_par

From 	sysadm.sinistre 	sin

Where	sin.id_prod   		= @dcIdProd
and    	sin.cod_etat      	in ( 100, 550 )
and     sin.valide_le 		<= @dtDateMaxSolPc

-----------------------------------------------------------------
-- Cas B : S‚lection des dossiers dont la date de validation est ant‚rieure à…
-- @dtDateMaxSolPc et qui n'ont jamais eu de courriers.
INSERT sysadm.tmp_soldage

SELECT 	#Tmp_Arch7.id_sin,
	pers.nom,
	pers.prenom,
	#Tmp_Arch7.valide_par,
	#Tmp_Arch7.valide_le
From 	sysadm.#Tmp_Arch7,
	sysadm.routage  	rout,
	sysadm.personne		pers
where	rout.id_sin		= #Tmp_Arch7.id_sin
and     rout.alt_queue		= 'N'
and     pers.id_ordre		= #Tmp_Arch7.id_ordre

SET @error_insert = @@ERROR

Drop Table sysadm.#Tmp_Arch7

IF @error_insert <> 0 GOTO ONERROR

END

RETURN 0

ONERROR:
-- Si l'insert se passe mal on rollback
RETURN -1

GO


/****** Objet :  Procédure stockée sysadm.PS_SOLDAGE    Date du script : 08/10/2007 17:10:43 ******/
-- JFF   19/11/2014    	[VDOC15650]
-- JFF      12/02/2016   [PI062]
-- JFF      23/01/2018   [PM407-1]
if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_SOLDAGE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [sysadm].[PS_SOLDAGE]
GO


CREATE procedure sysadm.PS_SOLDAGE
AS

-- # DCMP 60691 # 

-- information
-- 'è' -> char(232)
-- 'é' -> char(233)
DECLARE @idProd			decimal(7,0),
	@altRl2			varchar(1),
	@altSold		varchar(1),
	@durSoldRl		decimal(7,0),
	@untSoldRl		varchar(1),
	@durSoldPc		decimal(7,0),
	@untSoldPc		varchar(1),
	@dateJourServeur	datetime,
	@altSoldRl		varchar(1),
	@dateMaxSolPc		datetime,
	@dateMaxSolRl		datetime,
	@idSin			decimal(10,0), -- [PI062]
	@nom			varchar(35),
	@prenom			varchar(35),
	@validePar		varchar(4),
	@valideLe		datetime,
	@dp4			integer,
	@code	        	varchar(15),
	@retour			integer,
	@altQueue		varchar(1),
	@typTrt			varchar(4),
	@idTrt			integer,
	@etatTrt		varchar(70),
	@close_curs_prod	integer,
	@close_curs_sin		integer,
	@error			integer

SET NOCOUNT ON

SET @dateJourServeur	= getdate()
SET @altQueue		= 'N'
SET @typTrt		= 'SOL'
SET @close_curs_prod	= 0
SET @close_curs_sin	= 0

EXEC sysadm.PS_X_INCREMENTER 'ID_SOLDAGE', @idTrt OUTPUT 

-- [PM407-1]
DECLARE curs_prod CURSOR
FOR SELECT	id_prod,
		alt_rl2,
		alt_sold,
		dur_sold_rl,
		unt_sold_rl,
		dur_sold_pc,
		unt_sold_pc
	FROM sysadm.produit 
	WHERE alt_sold = 'O'
	Union All
	Select  dp.id_prod,
			Case 
				When Exists ( 
						Select Top 1 1 
						From   sysadm.det_pro dp1
						Where  dp1.id_prod = dp.id_prod
						And    dp1.id_code_car = 'RELANC'
						And    sysadm.FN_CLE_VAL ( 'ID_REL', rtrim ( dp1.val_car ) + rtrim ( dp1.val_car2 ), ';' ) = '2'
					) 
					Then 'O'
				Else 'N'
			End 'alt_rl2',
			'O' 'alt_sold',
			Case 
				When IsNumeric ( sysadm.FN_CLE_VAL ( 'DEL_SOLD_DERN_REL', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' )) > 0 
					Then Convert ( integer, sysadm.FN_CLE_VAL ( 'DEL_SOLD_DERN_REL', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ) )
				Else 0
			End 'dur_sold_rl',
			sysadm.FN_CLE_VAL ( 'UNITE_DEL_SOLD_DERN_REL', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ) 'unt_sold_rl',
			Case 
				When IsNumeric ( sysadm.FN_CLE_VAL ( 'DEL_SOLD_OBLIG', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' )) > 0 
					Then Convert ( integer, sysadm.FN_CLE_VAL ( 'DEL_SOLD_OBLIG', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ) )
				Else 0
			End 'dur_sold_pc',
			sysadm.FN_CLE_VAL ( 'UNITE_DEL_SOLD_OBLIG', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ) 'unt_sold_pc'
	  
	From	sysadm.det_pro dp
	Where   dp.id_code_dp = 323
	And		dp.id_code_car = 'SOLDAG'
	 
---------------------------
--!!!!!!!!!!!!!!!!!!!!!!!!!
---------------------------
	-- pour les tests
--	AND id_prod in (5701)
---------------------------
--!!!!!!!!!!!!!!!!!!!!!!!!!
---------------------------
-- PRINT '# DCMP 60691 # déclaration du cursor [curs_prod]'

OPEN curs_prod
SET @close_curs_prod = 1
-- PRINT '# DCMP 60691 # ouverture du cursor [curs_prod]'

FETCH NEXT FROM curs_prod
INTO	@idProd,
	@altRl2,
	@altSold,
	@durSoldRl,
	@untSoldRl,
	@durSoldPc,
	@untSoldPc
-- PRINT '# DCMP 60691 # 1er fetch d''entrée du cursor [curs_prod]'

WHILE @@FETCH_STATUS = 0
BEGIN
	-- PRINT '# DCMP 60691 # boucle du cursor [curs_prod]'
	-- PRINT '&&&&& Produit : ' + cast(@idProd as varchar(10))

	-- on regarde si le produit possede l'option 4
	SELECT @dp4 = count(id_prod) FROM sysadm.det_pro WHERE id_prod = @idProd AND id_typ_code_dp = '-DP' AND id_code_dp = '4'
	-- PRINT '&&&&& Option 4 : ' + cast(@dp4 as varchar(2))
	
	IF @durSoldRl <> 0
		BEGIN
			SET @altSoldRl = 'O'
			
			SET @dateMaxSolRl =
			CASE @untSoldRl
				WHEN 'J' THEN DATEADD(DAY, -1*(@durSoldRl), convert( varchar(10) , @dateJourServeur, 103)) + '23:59:59'
				WHEN 'M' THEN DATEADD(MONTH, -1*(@durSoldRl), convert( varchar(10) , @dateJourServeur, 103)) + '23:59:59'
			END			
		END
	ELSE
		BEGIN
			SET @altSoldRl = 'N'
		END
		
	SET @dateMaxSolPc = 
	CASE @untSoldPc
		WHEN 'J' THEN DATEADD(DAY, -1*(@durSoldPc), convert( varchar(10) , @dateJourServeur, 103)) + '23:59:59'
		WHEN 'M' THEN DATEADD(MONTH, -1*(@durSoldPc), convert( varchar(10) , @dateJourServeur, 103)) + '23:59:59'
	END

	-- PRINT '&&&&& @idProd : ' -- PRINT cast(@idProd as varchar(50))
	-- PRINT '&&&&& @altRl2 : ' -- PRINT cast(@altRl2 as varchar(50))
	-- PRINT '&&&&& @altSold : ' -- PRINT cast(@altSold as varchar(50))
	-- PRINT '&&&&& @durSoldRl : ' -- PRINT cast(@durSoldRl as varchar(23))
	-- PRINT '&&&&& @untSoldRl : ' -- PRINT cast(@untSoldRl as varchar(23))
	-- PRINT '&&&&& @dateMaxSolRl : ' -- PRINT cast(@dateMaxSolRl as varchar(50))
	-- PRINT '&&&&& @durSoldPc : ' -- PRINT cast(@durSoldPc as varchar(23))
	-- PRINT '&&&&& @untSoldPc : ' -- PRINT cast(@untSoldPc as varchar(23))
	-- PRINT '&&&&& @dateMaxSolPc : ' -- PRINT cast(@dateMaxSolPc as varchar(50))

	------------------------------------------------------------------------
	-- Début de la transaction 
	-- BEGIN TRANSACTION

	-- on recupere les dossiers à solder pour le produit
	EXEC @retour = sysadm.PS_RECUP_DOSSIER_ASOLDER @idProd, @altRl2, @altSold, @dateMaxSolRl, @dateMaxSolPc
	-- PRINT '&&&&& @retour de PS_RECUP_DOSSIER_ASOLDER : ' + cast(@retour as varchar(2))

	-- On annule la transaction par l'étiquette ONERROR en cas d'erreur
	-- annulation de la transaction
	IF @retour = -1 GOTO ONERROR
	-- validation de la transaction
	-- ELSE COMMIT TRANSACTION
	------------------------------------------------------------------------
	
	DECLARE curs_sin CURSOR
	FOR SELECT	id_sin,
			nom,
			prenom,
			valide_par,
			valide_le
		FROM sysadm.tmp_soldage
	
	-- PRINT '# DCMP 60691 # déclaration du cursor [curs_sin]'

	OPEN curs_sin
	SET @close_curs_sin = 1
	-- PRINT '# DCMP 60691 # ouverture du cursor [curs_sin]'
	
	FETCH NEXT FROM curs_sin
	INTO	@idSin,
		@nom,
		@prenom,
		@validePar,
		@valideLe
	-- PRINT '# DCMP 60691 # 1er fetch d''entrée du cursor [curs_sin]'

	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- PRINT '# DCMP 60691 # démarrage de la boucle du cursor [curs_sin]'
		-- PRINT '&&&&& Sinistre : ' + cast(@idSin as varchar(10))
		
		-- récuperation de la boite archive
		--- cf ps_s01_boite_archive @idsin, @operateur
		IF @dp4 <> 0
			BEGIN
				EXEC @retour = sysadm.PS_BOITE_ARCHIVE @idSin, 'SQLS', @code OUTPUT
				-- PRINT '&&&&& @code de PS_BOITE_ARCHIVE : ' + cast(@code as varchar(10))
				-- PRINT '&&&&& @retour de PS_BOITE_ARCHIVE : ' + cast(@retour as varchar(10))
				
				IF @retour = -1
				BEGIN
				
				------------------------------------------------------------------------
				-- Début de la transaction
				-- 	On annule la transaction par l'étiquette ONERROR en cas d'erreur
				-- BEGIN TRANSACTION
				-- tracer le non soldage du dossier
				
				SET @etatTrt = 'Dossier ' + cast(@idSin as varchar(10)) + ', Non Sold' + char(233)+ ', Probl' + char(232)+ 'me ARCHIVAGE : ' + @code -- [PI062]
				EXEC @retour = sysadm.PS_I01_TRACE_SOLDAGE @idTrt, @typTrt, @idProd, @idSin, @nom, @prenom, @validePar, @valideLe, @dateJourServeur, @dateMaxSolRl, @dateMaxSolPc, @etatTrt
				
				-- annulation de la transaction
				IF @retour = -1 GOTO ONERROR
				-- validation de la transaction
				-- ELSE COMMIT TRANSACTION
				------------------------------------------------------------------------
				
				FETCH NEXT FROM curs_sin
				INTO	@idSin,
					@nom,
					@prenom,
					@validePar,
					@valideLe
				CONTINUE
				-- PRINT '# DCMP 60691 # fetch next du cursor [curs_sin] sur non soldage'
				END
				
			END
		ELSE
			BEGIN
				SET @code = null
			END

		------------------------------------------------------------------------
		-- Début de la transaction 
		-- 	On annule la transaction par l'étiquette ONERROR en cas d'erreur
		-- BEGIN TRANSACTION
		EXEC @retour = sysadm.PS_D01_ARCHIVE_SOLDAGE @idSin, 'SQLS', @dateJourServeur, @altQueue OUTPUT, @code
		-- PRINT '&&&&& @retour de PS_D01_ARCHIVE_SOLDAGE : ' + cast(@retour as varchar(10))

		-- [VDOC15650]
		Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @idSin, 'SQL'

		
		-- annulation de la transaction
		IF @retour = -1 GOTO ONERROR
		-- -- validation de la transaction
		-- ELSE COMMIT TRANSACTION
		------------------------------------------------------------------------

		------------------------------------------------------------------------
		-- Début de la transaction 
		-- 	On annule la transaction par l'étiquette ONERROR en cas d'erreur
		-- BEGIN TRANSACTION
		-- tracer le non soldage du dossier
		IF @altQueue = 'N'
			BEGIN
				SET @etatTrt = 'Dossier ' + cast(@idSin as varchar(10)) + ': Sold' + char(233) -- [PI062]
			END
		ELSE
			BEGIN
				SET @etatTrt = 'Dossier ' + cast(@idSin as varchar(10)) + ': Non Sold' + char(233)+ ', Travail en cours.' -- [PI062]
			END
				
		EXEC @retour = sysadm.PS_I01_TRACE_SOLDAGE @idTrt, @typTrt, @idProd, @idSin, @nom, @prenom, @validePar, @valideLe, @dateJourServeur, @dateMaxSolRl, @dateMaxSolPc, @etatTrt
		-- PRINT '&&&&& PS_I01_TRACE_SOLDAGE'		
		-- PRINT '&&&&& @retour de PS_I01_TRACE_SOLDAGE : ' + cast(@retour as varchar(10))

		-- annulation de la transaction
		IF @retour = -1 GOTO ONERROR
		-- validation de la transaction
		-- ELSE COMMIT TRANSACTION
		------------------------------------------------------------------------
		
		FETCH NEXT FROM curs_sin
		INTO	@idSin,
			@nom,
			@prenom,
			@validePar,
			@valideLe
		-- PRINT '# DCMP 60691 # fetch next du cursor [curs_sin]'

	END
	-- PRINT '# DCMP 60691 # fin de la boucle du cursor [curs_sin]'
	
	CLOSE curs_sin
	DEALLOCATE curs_sin
	-- PRINT '# DCMP 60691 # fermeture et desalocation du cursor [curs_sin]'

	FETCH NEXT FROM curs_prod
	INTO	@idProd,
		@altRl2,
		@altSold,
		@durSoldRl,
		@untSoldRl,
		@durSoldPc,
		@untSoldPc
	-- PRINT '# DCMP 60691 # fetch next du cursor [curs_prod]'
	
END
-- PRINT '# DCMP 60691 # fin de la boucle du cursor [curs_prod]'

CLOSE curs_prod
DEALLOCATE curs_prod
-- PRINT '# DCMP 60691 # fermeture et desalocation du cursor [curs_prod]'

-- PRINT '# DCMP 60691 # return'
RETURN 0

------------------------------------------------------------------------
ONERROR:
-- ROLLBACK TRANSACTION
-- PRINT '# DCMP 60691 # ONERROR # fin anormal de la procedure'

IF @close_curs_prod = 1
	BEGIN
		CLOSE curs_prod
		DEALLOCATE curs_prod
		-- PRINT '# DCMP 60691 # ONERROR # fermeture et desalocation du cursor [curs_prod]'
	END
	
IF @close_curs_sin = 1
	BEGIN
		CLOSE curs_sin
		DEALLOCATE curs_sin
		-- PRINT '# DCMP 60691 # ONERROR # fermeture et desalocation du cursor [curs_sin]'
	END

------------------------------------------------------------------------
-- BEGIN TRANSACTION
-- tracer l'erreur
SET @etatTrt = 'Erreur sur le dossier ' + cast(@idSin as varchar(10)) -- [PI062]
EXEC @retour = sysadm.PS_I01_TRACE_SOLDAGE @idTrt, @typTrt, @idProd, @idSin, @nom, @prenom, @validePar, @valideLe, @dateJourServeur, @dateMaxSolRl, @dateMaxSolPc, @etatTrt
-- PRINT '&&&&& # ONERROR # PS_I01_TRACE_SOLDAGE'
-- annulation de la transaction
-- IF @@ERROR <> 0 ROLLBACK TRANSACTION
-- validation de la transaction
-- ELSE COMMIT TRANSACTION
------------------------------------------------------------------------

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_SOLDAGE_ZQUE
-- Auteur               :       Fabry JF
-- Date                 :       09/07/2013	
-- Libellé              :       [PC509-2]
-- Commentaires         :       
--
-- Retourne             :       Rien
-- JFF   19/11/2014    	[VDOC15650]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_SOLDAGE_ZQUE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [sysadm].[PS_SOLDAGE_ZQUE]
GO

CREATE procedure sysadm.PS_SOLDAGE_ZQUE
AS

-- ##### DCMP 70166 #

DECLARE @idProd			varchar(7),
	@dateJourServeur	datetime,
	@dateMaxSol		datetime,
	@idSin			varchar(10), -- [PI062]
	@nom			varchar(35),
	@prenom			varchar(35),
	@validePar		varchar(4),
	@valideLe		datetime,
	@retour			integer,
	@altQueue		varchar(1),
	@typTrt			varchar(4),
	@idTrt			integer,
	@etatTrt		varchar(70),
	@close_curs_sin		integer,
	@noBoite		varchar(10)

SET NOCOUNT ON

SET @dateJourServeur	= getdate()
SET @altQueue		= 'N'
SET @typTrt		= 'SZQ'
SET @close_curs_sin	= 0
SET @dateMaxSol = DATEADD(MONTH, -1*(24), convert( varchar(10) , getdate(), 103)) + '23:59:59'
SET @noBoite = 'SZ00000'

EXEC sysadm.PS_X_INCREMENTER 'ID_SOLDAGE', @idTrt OUTPUT 

DECLARE curs_sin CURSOR
FOR	SELECT  a.id_sin
	FROM 	sysadm.archive	a

	INNER JOIN sysadm.sinistre s
		ON a.id_sin = s.id_sin
		AND s.cree_le <= @dateMaxSol

	INNER JOIN sysadm.routage 	rout
		ON	rout.id_sin	= a.id_sin
		AND	rout.alt_queue	= 'N'

	WHERE a.id_sin in (	SELECT  a1.id_sin
				FROM 	sysadm.archive	a1
				GROUP BY a1.id_sin
				HAVING	count(*) = 1
				)
	AND	a.id_cour	like 'ZQUE%'	
	AND	a.dte_edit	is not null

OPEN curs_sin
SET @close_curs_sin = 1

FETCH NEXT FROM curs_sin
INTO	@idSin

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT '&&&&& Sinistre : ' + @idSin
	
	------------------------------------------------------------------------
	-- Soldage des dossiers
	EXEC @retour = sysadm.PS_D01_ARCHIVE_SOLDAGE @idSin, 'SQLS', @dateJourServeur, @altQueue OUTPUT
	PRINT '&&&&& @retour de PS_D01_ARCHIVE_SOLDAGE : ' + cast(@retour as varchar(10))

	-- On annule par l'étiquette ONERROR en cas d'erreur
	IF @retour = -1 GOTO ONERROR
	------------------------------------------------------------------------

	------------------------------------------------------------------------
	-- tracer le non soldage du dossier
	IF @altQueue = 'N'
		BEGIN
			SET @etatTrt = 'Dossier ' + @idSin + ': Soldé'
		END
	ELSE
		BEGIN
			SET @etatTrt = 'Dossier ' + @idSin + ': Non Soldé, Travail en cours.'
		END
			
	EXEC @retour = sysadm.PS_I01_TRACE_SOLDAGE @idTrt, @typTrt, @idProd, @idSin, @nom, @prenom, @validePar, @valideLe, @dateJourServeur, @dateMaxSol, @etatTrt
	PRINT '&&&&& @retour de PS_I01_TRACE_SOLDAGE : ' + cast(@retour as varchar(10))

	-- On annule par l'étiquette ONERROR en cas d'erreur
	IF @retour = -1 GOTO ONERROR
	------------------------------------------------------------------------
	
	------------------------------------------------------------------------
	-- Archivage dans la boite fictive
	EXEC @retour = sysadm.PS_ARCHIVER @idSin, 'SQLS', @noBoite
	PRINT '&&&&& @retour de PS_ARCHIVER : ' + cast(@retour as varchar(10))

	-- On annule par l'étiquette ONERROR en cas d'erreur
	IF @retour = -1 GOTO ONERROR
	------------------------------------------------------------------------

	FETCH NEXT FROM curs_sin
	INTO	@idSin

END

CLOSE curs_sin
DEALLOCATE curs_sin
PRINT '# fermeture et desalocation du cursor [curs_sin]'

RETURN 0

------------------------------------------------------------------------
ONERROR:
PRINT '# ONERROR #'
	
IF @close_curs_sin = 1
	BEGIN
		CLOSE curs_sin
		DEALLOCATE curs_sin
		PRINT '# ONERROR # fermeture et desalocation du cursor [curs_sin]'
	END

------------------------------------------------------------------------
BEGIN TRANSACTION
-- tracer l'erreur
SET @etatTrt = 'Erreur sur le dossier ' + @idSin
EXEC @retour = sysadm.PS_I01_TRACE_SOLDAGE @idTrt, @typTrt, @idProd, @idSin, @nom, @prenom, @validePar, @valideLe, @dateJourServeur, @dateMaxSol, @etatTrt
PRINT '# ONERROR # PS_I01_TRACE_SOLDAGE'		
-- annulation de la transaction
IF @@ERROR <> 0 ROLLBACK TRANSACTION
-- validation de la transaction
ELSE COMMIT TRANSACTION
------------------------------------------------------------------------
------------------------------------------------------------------------

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_RECUP_DOSSIER_A_PRESCRIRE
-- Auteur               :       Fabry JF
-- Date                 :       09/07/2013	
-- Libellé              :       [PC509-2]
-- Commentaires         :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

/****** Objet :  Procédure stockée sysadm.PS_RECUP_DOSSIER_A_PRESCRIRE    Date du script : 08/10/2007 17:10:43 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_RECUP_DOSSIER_A_PRESCRIRE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [sysadm].[PS_RECUP_DOSSIER_A_PRESCRIRE]
GO

CREATE procedure sysadm.PS_RECUP_DOSSIER_A_PRESCRIRE
	@dcIdProd    	Decimal ( 7,0 ),
	@iDelPres		integer ,
	@sUntDel		VarChar ( 1 )
AS

-- # DCMP 60691 # 
SET NOCOUNT ON

DECLARE @error_insert integer

-- Suppression des lignes de l''ancien traitement
-- [I027] - France - Suppression instruction incompatible réplication transactionelle
-- TRUNCATE TABLE sysadm.tmp_soldage
DELETE FROM sysadm.tmp_soldage


Create Table sysadm.#Tmp_Arch5
( id_sin	Decimal ( 10,0 ), -- [PI062]
  id_ordre	Decimal ( 7,0 ),
  valide_le	Datetime       ,
  valide_par	VarChar ( 4   ))


Insert  Into sysadm.#Tmp_Arch5
Select  sin.id_sin,
	sin.id_ordre,
	sin.valide_le,
	sin.valide_par

From 	sysadm.sinistre 	sin

Where	sin.id_prod   		= @dcIdProd
and    	sin.cod_etat      	in ( 100, 550 )
and     (
			( @sUntDel = 'J' And DATEADD ( day, @iDelPres, sin.dte_decl ) <= GETDATE () ) Or 
			( @sUntDel = 'M' And DATEADD ( month, @iDelPres, sin.dte_decl ) <= GETDATE () ) Or 
			( @sUntDel = 'A' And DATEADD ( year, @iDelPres, sin.dte_decl ) <= GETDATE () ) 
		)

-----------------------------------------------------------------
-- Select pour la DataWindow 				       --
-----------------------------------------------------------------

-- CAS A
INSERT sysadm.tmp_soldage
Select 	#Tmp_Arch5.id_sin,
	pers.nom,
	pers.prenom,
	#Tmp_Arch5.valide_par,
	#Tmp_Arch5.valide_le
From 	sysadm.#Tmp_Arch5,
	sysadm.routage  	rout,
	sysadm.personne		pers
where	rout.id_sin		= #Tmp_Arch5.id_sin
and     rout.alt_queue		= 'N'
and     pers.id_ordre		= #Tmp_Arch5.id_ordre


SET @error_insert = @@ERROR

Drop Table sysadm.#Tmp_Arch5

IF @error_insert <> 0 GOTO ONERROR

RETURN 0

ONERROR:
-- Si l'insert se passe mal on rollback
RETURN -1

GO


/****** Objet :  Procédure stockée sysadm.PS_SOLDAGE_PRESCRIRE    Date du script : 08/10/2007 17:10:43 ******/
--------------------------------------------------------------------
--
-- Procédure            :       PS_SOLDAGE_PRESCRIRE
-- Auteur               :       Fabry JF
-- Date                 :       09/07/2013	
-- Libellé              :       [PC509-2]
-- Commentaires         :       
--
-- Retourne             :       Rien
-- JFF   19/11/2014   [VDOC15650]
-- JFF	 12/02/2016   [PI062]
-- JFF   23/01/2018   [PM407-1]
-- JFF   08/11/2024   [20241108140717190] arrêt de ce traitement, on repasse en trt normal
-------------------------------------------------------------------
if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_SOLDAGE_PRESCRIRE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [sysadm].[PS_SOLDAGE_PRESCRIRE]
GO

CREATE procedure sysadm.PS_SOLDAGE_PRESCRIRE
AS

-- # DCMP 60691 # 

-- information
-- 'è' -> char(232)
-- 'é' -> char(233)

-- [20241108140717190] arrêt de ce traitement, on repasse en trt normal
Return


DECLARE @idProd   decimal(7,0),  
 @altRl2   varchar(1),  
 @altSold  varchar(1),  
 @durSoldRl  decimal(7,0),  
 @untSoldRl  varchar(1),  
 @durSoldPc  decimal(7,0),  
 @untSoldPc  varchar(1),  
 @dateJourServeur datetime,  
 @altSoldRl  varchar(1),  
 @dateMaxSolPc  datetime,  
 @dateMaxSolRl  datetime,  
 @idSin   decimal(10,0), -- [PI062]  
 @nom   varchar(35),  
 @prenom   varchar(35),  
 @validePar  varchar(4),  
 @valideLe  datetime,  
 @dp4   integer,  
 @code          varchar(15),  
 @retour   integer,  
 @altQueue  varchar(1),  
 @typTrt   varchar(4),  
 @idTrt   integer,  
 @etatTrt  varchar(70),  
 @close_curs_prod integer,  
 @close_curs_sin  integer,  
 @error   integer,  
 @iDelPres  integer,  
 @sUntDel  VarChar ( 1 )  
  
SET NOCOUNT ON  
  
SET @dateJourServeur = getdate()  
SET @altQueue  = 'N'  
SET @typTrt  = 'SOL'  
SET @close_curs_prod = 0  
SET @close_curs_sin = 0  
  
EXEC sysadm.PS_X_INCREMENTER 'ID_SOLDAGE', @idTrt OUTPUT   
  
DECLARE curs_prod CURSOR  
FOR SELECT   
  id_prod,  
  Convert ( Integer, sysadm.FN_CLE_VAL ( 'DELAI_PRESCRIPTION', d.val_car, ';'))  del_pres,  
  sysadm.FN_CLE_VAL ( 'UNT_DELAI', d.val_car, ';') unt_del  
 FROM sysadm.det_pro d  
 WHERE d.id_code_dp = 244  
  
OPEN curs_prod  
SET @close_curs_prod = 1  
-- PRINT '# DCMP 60691 # ouverture du cursor [curs_prod]'  
  
FETCH NEXT FROM curs_prod  
INTO @idProd,  
 @iDelPres,  
 @sUntDel  
-- PRINT '# DCMP 60691 # 1er fetch d''entrée du cursor [curs_prod]'  
  
WHILE @@FETCH_STATUS = 0  
BEGIN  
  
 -- Si -dp/244 présente, on enlève du paramètrage le soldage traditionnelle.  
 Update produit set alt_sold = 'N', dur_sold_rl = 0, dur_sold_pc = 0 where id_prod = @idProd  
  
  -- [PM407-1]  
 Delete sysadm.det_pro where id_prod = @idProd and id_code_dp = 323  
  
 -- on regarde si le produit possede l'option 4  
 SELECT @dp4 = count(id_prod) FROM sysadm.det_pro WHERE id_prod = @idProd AND id_typ_code_dp = '-DP' AND id_code_dp = '4'  
 -- PRINT '&&&&& Option 4 : ' + cast(@dp4 as varchar(2))  
  
 -- on recupere les dossiers à solder pour le produit  
 EXEC @retour = sysadm.PS_RECUP_DOSSIER_A_PRESCRIRE @idProd, @iDelPres, @sUntDel  
 -- PRINT '&&&&& @retour de PS_RECUP_DOSSIER_A_PRESCRIRE : ' + cast(@retour as varchar(2))  
  
 -- On annule la transaction par l'étiquette ONERROR en cas d'erreur  
 -- annulation de la transaction  
 IF @retour = -1 GOTO ONERROR  
 -- validation de la transaction  
 -- ELSE COMMIT TRANSACTION  
 ------------------------------------------------------------------------  
   
 DECLARE curs_sin CURSOR  
 FOR SELECT id_sin,  
   nom,  
   prenom,  
   valide_par,  
   valide_le  
  FROM sysadm.tmp_soldage  
   
 -- PRINT '# DCMP 60691 # déclaration du cursor [curs_sin]'  
  
 OPEN curs_sin  
 SET @close_curs_sin = 1  
 -- PRINT '# DCMP 60691 # ouverture du cursor [curs_sin]'  
   
 FETCH NEXT FROM curs_sin  
 INTO @idSin,  
  @nom,  
  @prenom,  
  @validePar,  
  @valideLe  
 -- PRINT '# DCMP 60691 # 1er fetch d''entrée du cursor [curs_sin]'  
  
 WHILE @@FETCH_STATUS = 0  
 BEGIN  
  -- PRINT '# DCMP 60691 # démarrage de la boucle du cursor [curs_sin]'  
  -- PRINT '&&&&& Sinistre : ' + cast(@idSin as varchar(10))  
    
  -- récuperation de la boite archive  
  --- cf ps_s01_boite_archive @idsin, @operateur  
  IF @dp4 <> 0  
   BEGIN  
    EXEC @retour = sysadm.PS_BOITE_ARCHIVE @idSin, 'SQLS', @code OUTPUT  
    -- PRINT '&&&&& @code de PS_BOITE_ARCHIVE : ' + cast(@code as varchar(10))  
    -- PRINT '&&&&& @retour de PS_BOITE_ARCHIVE : ' + cast(@retour as varchar(10))  
      
    IF @retour = -1  
    BEGIN  
      
    ------------------------------------------------------------------------  
    -- Début de la transaction  
    --  On annule la transaction par l'étiquette ONERROR en cas d'erreur  
    -- BEGIN TRANSACTION  
    -- tracer le non soldage du dossier  
      
    SET @etatTrt = 'Dossier ' + cast(@idSin as varchar(10)) + ', Non Sold' + char(233)+ ', Probl' + char(232)+ 'me ARCHIVAGE : ' + @code -- [PI062]  
    EXEC @retour = sysadm.PS_I01_TRACE_SOLDAGE @idTrt, @typTrt, @idProd, @idSin, @nom, @prenom, @validePar, @valideLe, @dateJourServeur, 'N', 'N', @etatTrt  
      
    -- annulation de la transaction  
    IF @retour = -1 GOTO ONERROR  
    -- validation de la transaction  
    -- ELSE COMMIT TRANSACTION  
    ------------------------------------------------------------------------  
      
    
    FETCH NEXT FROM curs_sin  
    INTO @idSin,  
     @nom,  
     @prenom,  
     @validePar,  
     @valideLe  
    CONTINUE  
    -- PRINT '# DCMP 60691 # fetch next du cursor [curs_sin] sur non soldage'  
    END  
      
   END  
  ELSE  
   BEGIN  
    SET @code = null  
   END  
  
  ------------------------------------------------------------------------  
  -- Début de la transaction   
  --  On annule la transaction par l'étiquette ONERROR en cas d'erreur  
  -- BEGIN TRANSACTION  
  EXEC @retour = sysadm.PS_D01_SOLDAGE_PRESCRIPTION @idSin, 'SQLS', @dateJourServeur, @altQueue OUTPUT, @code  
  -- PRINT '&&&&& @retour de PS_D01_SOLDAGE_PRESCRIPTION : ' + cast(@retour as varchar(10))  
  
  -- [VDOC15650]  
  Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @idSin, 'SQL'  
    
  -- annulation de la transaction  
  IF @retour = -1 GOTO ONERROR  
  -- -- validation de la transaction  
  -- ELSE COMMIT TRANSACTION  
  ------------------------------------------------------------------------  
  
  ------------------------------------------------------------------------  
  -- Début de la transaction   
  --  On annule la transaction par l'étiquette ONERROR en cas d'erreur  
  -- BEGIN TRANSACTION  
  -- tracer le non soldage du dossier  
  IF @altQueue = 'N'  
   BEGIN  
    SET @etatTrt = 'Dossier ' + cast(@idSin as varchar(10)) + ': Sold' + char(233) -- [PI062]  
   END  
  ELSE  
   BEGIN  
    SET @etatTrt = 'Dossier ' + cast(@idSin as varchar(10)) + ': Non Sold' + char(233)+ ', Travail en cours.' -- [PI062]  
   END  
      
  EXEC @retour = sysadm.PS_I01_TRACE_SOLDAGE @idTrt, @typTrt, @idProd, @idSin, @nom, @prenom, @validePar, @valideLe, @dateJourServeur, @dateMaxSolRl, @dateMaxSolPc, @etatTrt  
  -- PRINT '&&&&& PS_I01_TRACE_SOLDAGE'    
  -- PRINT '&&&&& @retour de PS_I01_TRACE_SOLDAGE : ' + cast(@retour as varchar(10))  
  
  -- annulation de la transaction  
  IF @retour = -1 GOTO ONERROR  
  -- validation de la transaction  
  -- ELSE COMMIT TRANSACTION  
  ------------------------------------------------------------------------  
    
  FETCH NEXT FROM curs_sin  
  INTO @idSin,  
   @nom,  
   @prenom,  
   @validePar,  
   @valideLe  
  -- PRINT '# DCMP 60691 # fetch next du cursor [curs_sin]'  
  
 END  
 -- PRINT '# DCMP 60691 # fin de la boucle du cursor [curs_sin]'  
   
 CLOSE curs_sin  
 DEALLOCATE curs_sin  
 -- PRINT '# DCMP 60691 # fermeture et desalocation du cursor [curs_sin]'  
  
 FETCH NEXT FROM curs_prod  
 INTO @idProd,  
   @iDelPres,  
   @sUntDel  
 -- PRINT '# DCMP 60691 # fetch next du cursor [curs_prod]'  
   
END  
-- PRINT '# DCMP 60691 # fin de la boucle du cursor [curs_prod]'  
  
CLOSE curs_prod  
DEALLOCATE curs_prod  
-- PRINT '# DCMP 60691 # fermeture et desalocation du cursor [curs_prod]'  
  
-- PRINT '# DCMP 60691 # return'  
RETURN 0  
  
------------------------------------------------------------------------  
ONERROR:  
-- ROLLBACK TRANSACTION  
-- PRINT '# DCMP 60691 # ONERROR # fin anormal de la procedure'  
  
IF @close_curs_prod = 1  
 BEGIN  
  CLOSE curs_prod  
  DEALLOCATE curs_prod  
  -- PRINT '# DCMP 60691 # ONERROR # fermeture et desalocation du cursor [curs_prod]'  
 END  
   
IF @close_curs_sin = 1  
 BEGIN  
  CLOSE curs_sin  
  DEALLOCATE curs_sin  
  -- PRINT '# DCMP 60691 # ONERROR # fermeture et desalocation du cursor [curs_sin]'  
 END  
  
------------------------------------------------------------------------  
-- BEGIN TRANSACTION  
-- tracer l'erreur  
SET @etatTrt = 'Erreur sur le dossier ' + cast(@idSin as varchar(10)) -- [PI062]  
EXEC @retour = sysadm.PS_I01_TRACE_SOLDAGE @idTrt, @typTrt, @idProd, @idSin, @nom, @prenom, @validePar, @valideLe, @dateJourServeur, @dateMaxSolRl, @dateMaxSolPc, @etatTrt  
-- PRINT '&&&&& # ONERROR # PS_I01_TRACE_SOLDAGE'  
-- annulation de la transaction  
-- IF @@ERROR <> 0 ROLLBACK TRANSACTION  
-- validation de la transaction  
-- ELSE COMMIT TRANSACTION  
------------------------------------------------------------------------  

GO





/****** Objet :  Procédure stockée sysadm.PS_D01_SOLDAGE_PRESCRIPTION    Date du script : 09/10/2007 15:43:20 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_D01_SOLDAGE_PRESCRIPTION]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_D01_SOLDAGE_PRESCRIPTION]
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_D01_SOLDAGE_PRESCRIPTION
-- Auteur               :       Fabry JF
-- Date                 :       09/07/2013	
-- Libellé              :       [PC509-2]
-- Commentaires         :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

CREATE procedure sysadm.PS_D01_SOLDAGE_PRESCRIPTION
	@dcIdSin	Decimal ( 10,0 ),  -- [PI062]
	@sCodOper	Varchar ( 4   ),
	@dtDateDuJour	DateTime,
	@sAltQueue	VarChar ( 1   ) OUTPUT,
        @sNoBoite       VarChar ( 10  )
AS

-- # DCMP 60691 # 
SET NOCOUNT ON

/*------------------------------------------------------------------*/
/* Le 25/08/2003. Modification pour la gestion des boites à archive.*/
/*------------------------------------------------------------------*/
Declare @sArchivePar    VarChar ( 4 )
Declare @dcIdCie        Decimal ( 7,0 )
Declare @dtValideLeSin  DateTime
Declare @sValideParSin  VarChar(4)
 
declare @iCountWkfs	integer -- # DCMP 60691 #

SELECT  @dtValideLeSin  = sin.valide_le,
        @sValideParSin  = sin.valide_par  
FROM    sysadm.sinistre AS sin
WHERE   sin.id_sin      = @dcIdSin

-- # DCMP 60691 #
-- on verifie que le sinistre n'a pas fait l'objet d'un soldage
-- et qu'il soit encore dans la file d'attente
----------------------------------------------------------------
SELECT @iCountWkfs = count(id_sin) 
FROM	sysadm.wkfs_w_queue wwq
WHERE	wwq.id_sin = @dcIdSin

--------------------------------------------------
-- Un travail a pu ˆtre cr‚‚ entre le select    --
-- et le soldage lui-mˆme, auquel cas on ne     --
-- solde plus le dossier.                       --
--------------------------------------------------
Select @sAltQueue = routage.alt_queue
From   sysadm.routage
Where  id_sin = @dcIdSin


If @sAltQueue = 'N'
	BEGIN

		--------------------------------------------------
		-- Mis … jour sur table Detail			--
		--------------------------------------------------
		Update  sysadm.detail
		Set	cod_etat 	= 900,
			cod_mot_ssui  	= 11,
			alt_ssui	= 'O',
			alt_att		= 'N',
			alt_reg		= 'N',
			valide_le	= @dtDateDuJour,
			valide_par	= @sCodOper
		Where  	id_sin		= @dcIdSin
		and 	cod_etat	= 100
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		-- Gestion de ce cas particulier pour le détail uniquement
		-- pour le soldage des panne MUST 5712
		Update  sysadm.detail
		Set	cod_etat 	= 600,
			alt_ssui	= 'N',
			alt_att		= 'N',
			alt_reg		= 'N',
			valide_le	= @dtDateDuJour,
			valide_par	= @sCodOper
		Where  	id_sin		= @dcIdSin
		and 	cod_etat	= 550
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		--------------------------------------------------
		-- Mis … jour sur table Gar_Sin			--
		--------------------------------------------------
		
		-- Si Gar … 100 et aucun Det … 200 alors Gar … 900
		Update  sysadm.gar_sin
		Set	cod_etat 	= 900,
			cod_mot_ssui  	= 11,
			alt_ssui	= 'O',
			valide_le	= @dtDateDuJour,
			valide_par	= @sCodOper
		From	sysadm.gar_sin gar
		Where  	gar.id_sin	= @dcIdSin
		and 	gar.cod_etat	= 100
		and     Not Exists ( Select det.id_sin
				     From   sysadm.detail det
				     Where  det.id_sin   = gar.id_sin
				     and    det.id_gti   = gar.id_gti 	
				     and    det.cod_etat = 200
				   )
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		-- Si Gar … 100 et au moins un Det … 200 alors Gar … 200
		Update  sysadm.gar_sin
		Set	cod_etat 	= 200,
			valide_le	= @dtDateDuJour,
			valide_par	= @sCodOper
		From	sysadm.gar_sin gar
		Where  	gar.id_sin	= @dcIdSin
		and 	gar.cod_etat	= 100
		and     Exists ( Select det.id_sin
				 From   sysadm.detail det
				 Where  det.id_sin   = gar.id_sin
				 and    det.id_gti   = gar.id_gti 	
				 and    det.cod_etat = 200 )
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		Update  sysadm.gar_sin
		Set  	cod_etat 	= 600,
			valide_le	= @dtDateDuJour,
			valide_par	= @sCodOper
		Where  	id_sin		= @dcIdSin
		and 	cod_etat	= 550
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		--------------------------------------------------
		-- Mis … jour sur table Sinistre		--
		--------------------------------------------------
		
		-- Si Sin … 100 et aucune Gar … 200 alors Sin … 900
		Update  sysadm.sinistre
		Set	cod_etat 	= 900,
			cod_mot_ssui  	= 11,
			alt_ssui	= 'O',
			valide_le	= @dtDateDuJour,
			valide_par	= @sCodOper
		From	sysadm.sinistre sin
		Where  	sin.id_sin	= @dcIdSin
		and 	sin.cod_etat	= 100
		and     Not Exists ( Select gar.id_sin
				     From   sysadm.gar_sin gar
				     Where  gar.id_sin   = sin.id_sin
				     And    gar.cod_etat = 200 )
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		-- Si Sin … 100 et au moins une Gar … 200 alors Sin … 200
		Update  sysadm.sinistre
		Set	cod_etat 	= 200,
			valide_le	= @dtDateDuJour,
			valide_par	= @sCodOper
		From	sysadm.sinistre sin
		Where  	sin.id_sin	= @dcIdSin
		and 	sin.cod_etat	= 100
		and     Exists ( Select gar.id_sin
				 From   sysadm.gar_sin gar
				 Where  gar.id_sin   = sin.id_sin
				 And    gar.cod_etat = 200 )
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		Update  sysadm.sinistre
		Set  	cod_etat 	= 600,
			valide_le	= @dtDateDuJour,
			valide_par	= @sCodOper
		Where  	id_sin		= @dcIdSin
		and 	cod_etat	= 550
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		/*------------------------------------------------------------------*/
		/* Gestion PRIVEE.et CENTRALISEE.                                   */
		/*------------------------------------------------------------------*/
		IF @sNoBoite IS NOT NULL
			BEGIN
				IF      @sNoBoite = 'CENTRALISE'
					BEGIN
						SET @sNoBoite           = NULL
					END
				IF      @sNoBoite <> 'CENTRALISE'
					BEGIN
						SET @sNoBoite = '-1'        
					END
		
				SET @sArchivePar        = '#SOL'
		/*------------------------------------------------------------------*/
		/* On récupére la compagnie qui gére le dossier.                    */
		/*------------------------------------------------------------------*/
				EXEC @dcIdCie = sysadm.PS_S01_SINISTRE_CIE_BOITE_ARCHIVE @dcIdSin
				

			END
		/*------------------------------------------------------------------*/
		/* Mise à jour sur la table ROUTAGE.                                */
		/*------------------------------------------------------------------*/
		UPDATE  sysadm.routage
		SET     sysadm.routage.cod_travail      = 'CAS',
			sysadm.routage.no_boite         = @sNoBoite
		WHERE   routage.id_sin  = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		--------------------------------------------------
		-- Delete sur les tables temporaires		--
		--------------------------------------------------
		Delete From sysadm.w_div_det
		Where id_sin = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		Delete From sysadm.w_reg_gti
		Where id_sin = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		Delete From sysadm.w_commande
		Where id_sin = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		Delete From sysadm.w_detail
		Where id_sin = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
				
		Delete From sysadm.w_refus
		Where id_sin = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		Delete From sysadm.w_piece
		Where id_sin = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		Delete From sysadm.w_para_plafond
		Where id_sin = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		Delete From sysadm.w_gar_sin
		Where id_sin = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		Delete From sysadm.w_para_info
		Where id_sin = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		Delete From sysadm.w_inter_blob
		Where id_sin = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		Delete From sysadm.w_frais
		Where id_sin = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		Delete From sysadm.w_cour_blob
		Where id_sin = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR

		Delete From sysadm.w_courrier
		Where id_sin = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		Delete From sysadm.w_inter
		Where id_sin = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
		Delete From sysadm.w_div_sin
		Where id_sin = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
				
		Delete From sysadm.w_sin
		Where id_sin = @dcIdSin
		
		-- DCMP 60691
		IF @@ERROR <> 0 GOTO ONERROR
		
	END

RETURN 0

ONERROR:
RETURN -1

GO


