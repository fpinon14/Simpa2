-------------------------------------------------------------------
--
-- Fichier              : ifr.cp
--
-- Commentaires         : Proc‚dures de la table ifr
--
-- Proc‚dures           
-- 
--	DW_S01_IFR_SUPP_SPB
--
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure   : DW_S01_IFR_SUPP_SPB
-- Auteur      : 
-- Date        : 
-- Libell‚     : S‚lection … partir de la table ifr
--				 Note : les paramètres ne sont plus utilisés.
-- R‚f‚rences  :       
--
-- Arguments   : 
--	                        
-------------------------------------------------------------------
-- #1 FPI le 17/03/2009 - [DCMP090143] Suppression des contraintes IFR, marque et modeles
-- 							WHERE i1.provenance = 'IFR'
-- 							AND i1.marque LIKE @sMarq
-- 							AND i1.reference LIKE @sRef
-- #2 FPI	23/06/2009		[DMDI25957] Suppression du filtre IFR + ajout colonne provenance
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_IFR_SUPP_SPB' AND type = 'P' )
        DROP procedure sysadm.DW_S01_IFR_SUPP_SPB
GO

CREATE PROC sysadm.DW_S01_IFR_SUPP_SPB
	@sMarq	varchar(30),
	@sRef	varchar(30)
AS

 SELECT  distinct i1.marque,
         i1.reference,
	 cast(null as varchar(1)) as 'alt_select',
		i1.provenance		-- #2
    FROM  sysadm.ifr i1
	WHERE i1.id_trait =	(select max ( i2.id_trait )
							from	sysadm.ifr i2
							where i2.marque = i1.marque
							and		i2.reference = i1.reference)
							/*where	i2.provenance = 'IFR'
							and		i2.marque = i1.marque
							and		i2.reference = i1.reference)*/
							
	ORDER BY marque, reference

GO



IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_IFR' AND type = 'P' )
        DROP procedure sysadm.DW_S01_IFR
GO

CREATE PROC sysadm.DW_S01_IFR
AS
 SELECT  id_trait,
         marque,
         reference,
         provenance,
         alt_dispo,
         centrales,
         frequence,
         prix_haut,
         prix_bas,
         poids,
         battsupl,
         voxfunc,
         scrncol,
         infred,
         wireless,
         modem,
         digicam,
         mp3wma,
         systeme,
         commstnd,
         webconn,
         java,
         talktime,
         message,
         stndby,
         commpaym,
         provider,
         packtype,
         gps,
         mep
--ajout Migration PB4 PB8 WYNIWYG 03/2006  (4 colonnes ajoutées)
, 	cast(null as decimal(11,2)) as 'mt_prix_frn',
	cast(null as varchar(1)) as 'alt_select',
/* Migration PB4 PB8 SPB JFF le 11/04/2006 - suppression, les colonnes existes rééllement
	cast(null as DateTime) as 'maj_le',
	cast(null as varchar(4)) as 'maj_par'
*/	
--ajout Migration PB4 PB8 JFF 11/04/2006
	maj_le,
	maj_par

   FROM  sysadm.ifr


GO


-- JFF      16/03/2020   [DT469]
-- JFF      11/05/2022   [RS2980_IFR]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_IFR_V02' AND type = 'P' )
        DROP procedure sysadm.DW_S01_IFR_V02
GO

CREATE PROC sysadm.DW_S01_IFR_V02
AS
SELECT  id_trait,
         marque,
         reference,
         provenance,
         alt_dispo,
         centrales,
         frequence,
         prix_haut,
         prix_bas,
         poids,
         battsupl,
         voxfunc,
         scrncol,
         infred,
         wireless,
         modem,
         digicam,
         mp3wma,
         systeme,
         commstnd,
         webconn,
         java,
         talktime,
         message,
         stndby,
         commpaym,
         provider,
         packtype,
         gps,
         mep
--ajout Migration PB4 PB8 WYNIWYG 03/2006  (4 colonnes ajoutées)
, 	cast(null as decimal(11,2)) as 'mt_prix_frn',
	cast(null as varchar(1)) as 'alt_select',
/* Migration PB4 PB8 SPB JFF le 11/04/2006 - suppression, les colonnes existes rééllement
	cast(null as DateTime) as 'maj_le',
	cast(null as varchar(4)) as 'maj_par'
*/	
--ajout Migration PB4 PB8 JFF 11/04/2006
	maj_le,
	maj_par,
	sku_saga, -- [PM251-1]
	maj_prix_auto, -- [DT469] 
	dern_maj_prix_trt, -- [DT469]
	dern_maj_prix_dte, -- [DT469]
	dern_maj_prix_par, -- [DT469]
	per_rev_prix_mois -- [RS2980_IFR]

   FROM  sysadm.ifr

GO
grant execute on sysadm.DW_S01_IFR_V02 to rolebddsinistres
Go

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_IFR_LISTE_MARQUE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_IFR_LISTE_MARQUE
GO

CREATE PROC sysadm.DW_S01_IFR_LISTE_MARQUE
AS

SELECT DISTINCT marque
  FROM sysadm.ifr
UNION
SELECT null

ORDER BY marque

GO



IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_IFR_LISTE_REFERENCE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_IFR_LISTE_REFERENCE
GO

CREATE PROC sysadm.DW_S01_IFR_LISTE_REFERENCE
AS

SELECT DISTINCT marque, reference
  FROM sysadm.ifr
UNION
SELECT DISTINCT marque, null
  FROM sysadm.ifr
ORDER BY reference


GO


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_IFR_LISTE_VAL' AND type = 'P' )
        DROP procedure sysadm.DW_S01_IFR_LISTE_VAL
GO

CREATE PROC sysadm.DW_S01_IFR_LISTE_VAL
@sParam   varchar(50)
AS

-- [PM82][LOT3] Chargement liste poid (Res.A
-- JFF  16/03/2020   [DT469]
-- JFF      11/05/2022   [RS2980_IFR]

IF @sParam = 'id_trait'
   SELECT DISTINCT convert(varchar(10),id_trait)     FROM sysadm.ifr
IF @sParam = 'provenance'
   SELECT DISTINCT provenance                        FROM sysadm.ifr
IF @sParam = 'frequence'
   SELECT DISTINCT convert(varchar(10),frequence)    FROM sysadm.ifr
IF @sParam = 'prix_haut'
   SELECT DISTINCT convert(varchar(10),prix_haut)    FROM sysadm.ifr
IF @sParam = 'prix_bas'
   SELECT DISTINCT convert(varchar(10),prix_bas )    FROM sysadm.ifr
IF @sParam = 'poids'
-- [PM82][LOT3] Chargement liste poid (Res.A
-- SELECT DISTINCT RIGHT ('   ' + convert( varchar(10),poids ),4 ) FROM sysadm.ifr
   SELECT DISTINCT poids FROM sysadm.ifr
IF @sParam = 'battsupl'
   SELECT DISTINCT battsupl                          FROM sysadm.ifr
IF @sParam = 'voxfunc'
   SELECT DISTINCT voxfunc                           FROM sysadm.ifr
IF @sParam = 'scrncol'
   SELECT DISTINCT scrncol                           FROM sysadm.ifr
IF @sParam = 'infred'
   SELECT DISTINCT infred                            FROM sysadm.ifr
IF @sParam = 'wireless'
   SELECT DISTINCT wireless                          FROM sysadm.ifr
IF @sParam = 'modem'
   SELECT DISTINCT modem                             FROM sysadm.ifr
IF @sParam = 'digicam'
   SELECT DISTINCT digicam                           FROM sysadm.ifr
IF @sParam = 'mp3wma'
   SELECT DISTINCT mp3wma                            FROM sysadm.ifr
IF @sParam = 'systeme'
   SELECT DISTINCT systeme                           FROM sysadm.ifr
IF @sParam = 'commstnd'
   SELECT DISTINCT commstnd                          FROM sysadm.ifr
IF @sParam = 'webconn'
   SELECT DISTINCT webconn                           FROM sysadm.ifr
IF @sParam = 'java'
   SELECT DISTINCT java                              FROM sysadm.ifr
IF @sParam = 'talktime'
   SELECT DISTINCT talktime                          FROM sysadm.ifr
IF @sParam = 'message'
   SELECT DISTINCT message                           FROM sysadm.ifr
IF @sParam = 'stndby'
   SELECT DISTINCT stndby                            FROM sysadm.ifr
IF @sParam = 'commpaym'
   SELECT DISTINCT commpaym                          FROM sysadm.ifr
IF @sParam = 'provider'
   SELECT DISTINCT provider                          FROM sysadm.ifr
IF @sParam = 'packtype'
SELECT DISTINCT packtype                             FROM sysadm.ifr
IF @sParam = 'gps'
   SELECT DISTINCT gps                               FROM sysadm.ifr
IF @sParam = 'mep'
   SELECT DISTINCT mep                               FROM sysadm.ifr

-- [DT469]
IF @sParam = 'sku_saga'
   SELECT DISTINCT sku_saga                          FROM sysadm.ifr
IF @sParam = 'dern_maj_prix_trt'
   SELECT DISTINCT dern_maj_prix_trt                 FROM sysadm.ifr
IF @sParam = 'dern_maj_prix_par'
   SELECT DISTINCT dern_maj_prix_par                 FROM sysadm.ifr
IF @sParam = 'maj_par'
   SELECT DISTINCT maj_par                           FROM sysadm.ifr
-- /[DT469]
-- [RS2980_IFR]
IF @sParam = 'per_rev_prix_mois' -- [RS2980_IFR]
   SELECT DISTINCT per_rev_prix_mois                 FROM sysadm.ifr -- [RS2980_IFR]


GO


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_IFR' AND type = 'P' )
        DROP procedure sysadm.DW_S02_IFR
GO

CREATE PROC sysadm.DW_S02_IFR
AS
 SELECT  id_trait,
         marque,
         reference,
         provenance,
         alt_dispo,
         centrales,
         frequence,
         prix_haut,
         prix_bas,
         poids,
         battsupl,
         voxfunc,
         scrncol,
         infred,
         wireless,
         modem,
         digicam,
         mp3wma,
         systeme,
         commstnd,
         webconn,
         java,
         talktime,
         message,
         stndby,
         commpaym,
         provider,
         packtype,
         gps,
         mep,
         'N',
         0
   FROM  sysadm.ifr i
   where  i.id_trait = (
	   	select max ( id_trait )
	   	From   sysadm.ifr i2
	   	Where  i2.marque = i.marque
	   	And    i2.reference = i.reference
                And    i2.alt_dispo = 'O'
	   	)
   
GO



IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_IFR' AND type = 'P' )
        DROP procedure sysadm.DW_S03_IFR
GO

CREATE PROC sysadm.DW_S03_IFR
  @sCas		Varchar ( 10 )
AS

 If Upper ( @sCas ) = 'MARQUE'
  Begin
	SELECT  distinct
		'IFR',
		marque,
		Convert ( VarChar ( 35 ), null )

	FROM  sysadm.ifr
        WHERE alt_dispo = 'O'
  End

 Else
  Begin
	SELECT  distinct
		'IFR',
		marque,
		reference
	FROM  sysadm.ifr
        WHERE alt_dispo = 'O'
  End


GO


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_IFR_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I01_IFR_V01
GO

CREATE PROC sysadm.PS_I01_IFR_V01
@sAltRelance      char(1) 
AS

/*---------------------------------------*/
/* Déclaration des variables génériques  */
/*---------------------------------------*/
DECLARE @sNomRepIn     varchar(100),
        @sNomFicIn     varchar(100),
        @sNomFicTrv    varchar(100),
        @sIdTypTrait   varchar(35),
        @sCodCompteur  varchar(5),
        @sLigneEntete  varchar(500),
        @nbSep         integer,
        @iMtPack       integer
      
/*---------------------------------------*/
/* Déclaration des variables locales     */
/*---------------------------------------*/
DECLARE @iCodeRetour   integer,
        @sNomRepFicIn  varchar(100),
        @sNomRepFicTrv varchar(100),
        @sNomFicHis    varchar(100),
        @sMess         varchar(100),
        @iIdTrait      integer,
        @sCmd          varchar(100),
        @nb            integer,
        @iCpt          integer,
        @sLigne        varchar(500),
        @iPos          integer,
        @bDernLigne    char(1),
        @sMarque       varchar(30),
        @sRef          varchar(30),
        @sGps          varChar(30),
        @sTot          integer,
        @iTot1         integer,
        @iTot2         integer,
        @nbLigneOrig   integer,
        @nbLigneDel    integer,
        @sCommande     VarChar(250),
        @sMessage      Varchar(255),
        @sObjet        VarChar(255)        
        
DECLARE @sRetourErrMail         VarChar(255)
DECLARE @sRoot		Varchar(225)


SET NOCOUNT ON

/*------------------------------------------------------------------*/
/* Affection des variables génériques                               */
/*------------------------------------------------------------------*/
SET     @sNomRepIn    = master.sysadm.SPB_FN_GET_ROOT()+'SINISTRE\IFR\'
SET     @sNomFicIn    = 'SPB_IFR.TXT'
SET     @sNomFicTrv   = 'TRAVAIL_IFR.TXT'
SET     @sIdTypTrait  = 'IFR'
SET     @sCodCompteur = '-CIFR'
SET     @sLigneEntete = 'FAMILLE	PAYS	MARQUE	REFERENCE	FRQ	BAS	HAUT	MEP	WEIGHT (GRAMMES)	VOICE FUNCTION	SCREEN COLOURS No.	INFRARED PORT	Wireless Connection	INT. DIGITAL CAMERA	MP3/WMA PLAYBACK	FREQUENCY SYSTEM	COMM. STANDARD	INTERNET CONNECTION	JAVA	MESSAGING SYSTEM	COMM PAYMENT	PROVIDER	PACK or SUBSCR. TYPE'
SET     @nbSep        = 22
SET     @iMtPack      = 10

/*------------------------------------------------------------------*/
/* DEBUT DE TRANSACTION  : Fin de transaction en fin de procédure   */
/*------------------------------------------------------------------*/

BEGIN TRAN


/*                     =====================                        */
/*                     *****  ETAPE 0 ******                        */
/*                     =====================                        */
/*------------------------------------------------------------------*/
/* Constuction du numéro de traitement à partir de la date du jour, */
/* et du compteur -CIFR                                             */
/* Au retour de la procédure, il faudra :                           */
/*    Si le traitement se passe bien faire un commit                */
/*    Si le traitement se passe mal  faire un rollback              */
/*------------------------------------------------------------------*/
UPDATE  sysadm.param_import_fic
   SET  id_code = id_code + 1
 WHERE  id_typ_code = @sCodCompteur

SELECT  @iIdTrait = id_code
  FROM  sysadm.param_import_fic
 WHERE  id_typ_code = @sCodCompteur

SET @iIdTrait = convert ( char(4), datepart (year, getdate()) ) + right ( '00' + convert ( varchar(2), datepart (month, getdate()) ), 2 ) +
                SubString ( '0000' + convert( varchar(5), @iIdTrait), LEN ( '0000' + convert( varchar(5), @iIdTrait )) - 3, 4 )


/*------------------------------------------------------------------*/
/* Constuction des noms complets de fichier                         */
/*------------------------------------------------------------------*/
SET @sNomRepFicIn  = @sNomRepIn + @sNomFicIn
SET @sNomRepFicTrv = @sNomRepIn + @sNomFicTrv




/*                     =====================                        */
/*                     *****  ETAPE 1 ******                        */
/*                     =====================                        */
/*------------------------------------------------------------------*/
/* Renommage du fichier en Entrée en Fichier de Travail             */
/* Ne pas faire cette étape en cas de relance                       */
/*------------------------------------------------------------------*/
   INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
        VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 1: Début", null, '*** RENOMAGE FICHIER DE TRAVAIL ***' )

   -- ____________________________
   -- CAS D'UN TRAITEMENT STANDARD
   -- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

   If @sAltRelance = 'N'
      Begin
   
         /*--------------------------------------------*/
         /* Est-ce que le fichier d'entrée existe bien */
         /*--------------------------------------------*/
         SELECT 'STEP1 ' + convert(varchar(25), getdate(),113)
         EXEC master.dbo.xp_fileexist @sNomRepFicIn, @iCodeRetour OUTPUT

         IF @iCodeRetour = 0 
            Begin
               SET @sMess = 'Le fichier ' + @sNomRepFicIn + ' n''existe pas.'
               INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
                    VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 1: Echec", 'N', '   ' + @sMess )
               GOTO SORTIE_ERREUR
            End
   
         /*--------------------------------------------*/
         /* Le fichier de travail ne doit pas exister  */
         /*--------------------------------------------*/
         SELECT 'STEP2 ' + convert(varchar(25), getdate(),113)
         EXEC master.dbo.xp_fileexist @sNomRepFicTrv, @iCodeRetour OUTPUT
         IF @iCodeRetour = 1 
            Begin
               SET @sMess = 'Fichier travail ' + @sNomRepFicTrv + ' existe déjà! Seule relance autorisée!'
               INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
                    VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 1: Echec", 'N', '   ' + @sMess )
               GOTO SORTIE_ERREUR
            End
   
         /*-----------------------------------------------------*/
         /* Renommage du fichier d'entrée en fichier de travail */
         /*-----------------------------------------------------*/
         SELECT 'STEP3 ' + convert(varchar(25), getdate(),113)
         SET @sCmd = 'RENAME ' + @sNomRepFicIn + ' ' + @sNomFicTrv
         EXEC @iCodeRetour = master.dbo.xp_cmdshell @sCmd, no_output

         IF @@error <> 0
            Begin   
               SET @sMess = 'Le lancement de la commande xp_cmdshell à échoué : ' + convert (varchar(30), @@error) 
               INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
                    VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 1: Echec", 'N', '   ' + @sMess )
               GOTO SORTIE_ERREUR
            End


         IF @iCodeRetour = 0 
            Begin
               SET @sMess = 'Fichier ' + @sNomRepFicIn + ' renommé en ' + @sNomRepFicTrv
               INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
                    VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 1: Succès", 'O', '   ' + @sMess )
            End
         ELSE
            Begin
               SET @sMess = 'Impossible de renommer le fichier ' + @sNomRepFicIn + ' en ' + @sNomRepFicTrv
               INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
                    VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 1: Echec", 'N', '   ' + @sMess )
               GOTO SORTIE_ERREUR
            end
      end
   -- _________________ 
   -- CAS D'UNE RELANCE 
   -- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 
   ELSE
      Begin
   
         /*--------------------------------------------*/
         /* Le fichier de travail doit exister         */
         /*--------------------------------------------*/
         EXEC master.dbo.xp_fileexist @sNomRepFicTrv, @iCodeRetour OUTPUT
         IF @iCodeRetour = 0 
            begin
               SET @sMess = 'Le fichier de travail ' + @sNomRepFicTrv + ' n''existe pas! Relance impossible!'
               INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
                    VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 1: Echec", 'N', '   ' + @sMess )
               GOTO SORTIE_ERREUR
            end
      end




/*                     =====================                        */
/*                     *****  ETAPE 2 ******                        */
/*                     =====================                        */
/*------------------------------------------------------------------*/
/* Récupération du fichier de travail dans une première table       */
/* temporaire pour vérification du format                           */
/*------------------------------------------------------------------*/
   SELECT 'STEP4 ' + convert(varchar(25), getdate(),113)
   INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
        VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 2: Début", null, '*** CONTROLE FORMAT DU FICHIER ***' )

   /*------------------------------------------*/
   /* Création des tables temporaires          */
   /*------------------------------------------*/
   IF ( SELECT object_id ( 'tempdb.dbo.#TblTemp0' ) ) > 0
      Drop table #TblTemp0
      
   Create TABLE #TblTemp0
   (
      ligne           VARCHAR(2500)   NULL
   )  

   IF ( SELECT object_id ( 'tempdb.dbo.#TblTemp' ) ) > 0
      Drop table #TblTemp
      

   Create TABLE #TblTemp
   (
      id_ligne        Integer Identity,
      ligne           VARCHAR(2500)   NULL
   )

   /*------------------------------------------------*/
   /* Récupération du fichier dans la table #TblTemp */
   /* via un BULK INSERT par #TblTemp0               */
   /*------------------------------------------------*/
   SELECT 'STEP5 ' + convert(varchar(25), getdate(),113)
   SET @sCmd = 'BULK INSERT #TblTemp0 FROM ''' + @sNomRepFicTrv + ''' WITH (  FIELDTERMINATOR = ''|'' )'
   EXECUTE (@sCmd)

   IF @@error <> 0
      Begin   
         SET @sMess = 'Le lancement de la commande xp_cmdshell à échoué : ' + convert (varchar(30), @@error) 
         INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 2: Echec", 'N', '   ' + @sMess )
         GOTO SORTIE_ERREUR
      End

   SELECT 'STEP6 ' + convert(varchar(25), getdate(),113)
   INSERT INTO #TblTemp SELECT ligne FROM #TblTemp0

   SELECT @nbLigneOrig = Count(*) FROM #TblTemp

   /*------------------------------------------*/
   /* Suppression du dernier retour chariot    */
   /* si nécessaire                            */
   /*------------------------------------------*/ 
   SET @bDernLigne = 'N'

   SELECT 'STEP7 ' + convert(varchar(25), getdate(),113)
   SELECT @sLigne = ligne FROM #TblTemp WHERE id_ligne = ( Select max (id_ligne) FROM #TblTemp )

   IF @sLigne IS NULL 
      begin
         SET @sMess = 'Suppression du dernier retour chariot'
         INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 2: En cours", 'O', '   ' + @sMess )
         DELETE FROM #TblTemp WHERE id_ligne = ( Select max (id_ligne) FROM #TblTemp )
         SET @bDernLigne = 'O'
      end


   /*----------------------------------------*/
   /* Controle de la ligne d'en-tete         */
   /*----------------------------------------*/
   SET @sLigne = (SELECT TOP 1 ligne FROM #TblTemp)

   SELECT 'STEP8 ' + convert(varchar(25), getdate(),113)      
   IF @sLigne <> @sLigneEntete
      Begin
         SET @iCpt = 1
         WHILE Left ( @sLigneEntete, @iCpt ) = Left ( @sLigne, @iCpt ) And @iCpt <= datalength (@sLigneEntete)
            SET @iCpt = @iCpt + 1

         SET @sMess = 'Ligne d''en-tete invalide (à partir du caractère : ' + Convert ( varchar(4), @iCpt ) + ' )'
         INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 2: Echec", 'N', '   ' + @sMess )
         GOTO SORTIE_ERREUR
      End


   /*----------------------------------------*/
   /* Controle le nombre de lignes           */
   /*----------------------------------------*/

   SELECT 'STEP9 ' + convert(varchar(25), getdate(),113)
   SELECT @nb = count(*) FROM #TblTemp

   IF @nb < 2 
      Begin
         SET @sMess = 'Le fichier ne contient aucune ligne de donnée' 
         INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 2: Echec", 'N', '   ' + @sMess )
         GOTO SORTIE_ERREUR
      End


   /*------------------------------------------------*/
   /* Controle du nombre de colonne sur chaque ligne */
   /*------------------------------------------------*/
   SELECT 'STEP10 ' + convert(varchar(25), getdate(),113)
   DECLARE curs CURSOR FOR
   select sysadm.SPB_FN_COMPTER_SEP(ligne, char(9)) from #TblTemp
  
   OPEN curs
   
   FETCH curs INTO @nb
   SET @iCpt = 1
   
   WHILE @@fetch_status <> -1 AND @nb = @nbSep
      Begin
         FETCH curs INTO @nb
         SET @iCpt = @iCpt + 1
      End
   
   IF @nb <> @nbSep 
      Begin
         SET @sMess = "ERR Présence de " + convert(varchar(5),@nb) + " tabulations (au lieu de " + 
                      convert (varchar(10), @nbSep ) + "), sur la ligne: " + convert (char(5), @iCpt) 
         INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 2: Echec", 'N', '   ' + @sMess )
         GOTO SORTIE_ERREUR
      End
   
   CLOSE curs
   DEALLOCATE curs

   
   /*------------------------------------------*/
   /* Compte le nombre de ligne réellement     */
   /* récupérée                                */
   /*------------------------------------------*/ 
   SELECT 'STEP11 ' + convert(varchar(25), getdate(),113)
   SELECT @nb = count(*) FROM #TblTemp

   SET @sMess = 'Nombre de ligne chargée : ' + Convert ( varchar(8), @nb ) + ' (' + Convert ( varchar(8), @nb-1 ) + '+1)'
   INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
        VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 2: En cours", 'O', '   ' + @sMess )
 
   INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
        VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 2: Succès", 'O', '' )


/*                     =====================                        */
/*                     *****  ETAPE 3 ******                        */
/*                     =====================                        */
/*------------------------------------------------------------------*/
/* Insertion dans une deuxième table temporaire du fichier pour     */
/* Récupération du fichier de travail dans une première table       */
/* temporaire pour vérification du format                           */
/*------------------------------------------------------------------*/

   INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
        VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 3: Début", null, '*** CONTROLE CONTENU DU FICHIER ***' )


   /*------------------------------------------*/
   /* Construction de la table temporaire      */
   /*------------------------------------------*/
   CREATE TABLE #TblTemp2
   (
      famille   varchar (30)      NULL,
      pays      varchar (30)      NULL,
      marque    varchar (30)      NULL,
   	reference varchar (30)      NULL,
	   frequence varchar (30)      NULL,
   	prix_bas  varchar (30)      NULL,
   	prix_haut varchar (30)      NULL,
      mep       varchar (30)      NULL,
      poids     varchar (25)      NULL, 
   	voxfunc   varchar (25)      NULL, 
   	scrncol   varchar (25)      NULL, 
   	infred    varchar (25)      NULL, 
   	wireless  varchar (25)      NULL, 
   	digicam   varchar (25)      NULL, 
   	mp3wma    varchar (25)      NULL, 
   	systeme   varchar (25)      NULL, 
   	commstnd  varchar (25)      NULL, 
   	webconn   varchar (25)      NULL, 
   	java      varchar (25)      NULL, 
   	message   varchar (25)      NULL, 
   	commpaym  varchar (25)      NULL, 
   	provider  varchar (25)      NULL, 
   	packtype  varchar (25)      NULL
  	
   )


   /*------------------------------------------*/
   /* Récupération du fichier dans cette table */
   /*------------------------------------------*/
   SELECT 'STEP12 ' + convert(varchar(25), getdate(),113)
   SET @sCmd = 'BULK INSERT #TblTemp2 FROM ''' + @sNomRepFicTrv + ''' WITH ( FIRSTROW = 2 )'
   EXECUTE (@sCmd)

   IF ( @@error ) <> 0
      Begin
         INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 3: Echec", 'N', '   Problème lors du BULK INSERT' )
         GOTO SORTIE_ERREUR
      end
   Else
      Begin
         INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 3: Succès", 'O', '' )
      End

   /*------------------------------------------*/
   /* Si l'étape 2 avait trouvé une dernière   */
   /* ligne à supprimer alors on répercute     */
   /* cette supression                         */
   /*------------------------------------------*/
   SELECT 'STEP13 ' + convert(varchar(25), getdate(),113)
   IF @bDernLigne = 'O'
      begin
         DELETE FROM #TblTemp WHERE id_ligne = ( Select max (id_ligne) FROM #TblTemp )
      end

   /*------------------------------------------*/
   /* Vérification qu'il n'y a pas de doublon  */
   /*------------------------------------------*/
   SELECT 'STEP14 ' + convert(varchar(25), getdate(),113)
   SELECT  @nb = count( distinct reference)
     FROM  #TblTemp2 AS Tmp1
    WHERE  EXISTS ( SELECT Tmp2.marque, Tmp2.reference, count(*) 
                      FROM #TblTemp2 AS Tmp2
                     WHERE Tmp1.marque    = Tmp2.marque    AND 
                           Tmp1.reference = Tmp2.reference
                  GROUP BY Tmp2.marque, Tmp2.reference
                    HAVING count(*) > 1
                  )

   SELECT 'STEP15 ' + convert(varchar(25), getdate(),113)
   IF @nb > 0 
      begin
         IF @nb = 1 
            SET @sMess = 'une (marque, référence) est présente plus d''une fois dans le fichier'
         ELSE
            SET @sMess = convert (varchar(4), @nb) + ' (marque, référence) sont présentes plus d''une fois dans le fichier'
         INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 3: Echec", 'N', '   ' + @sMess )
         
         -- Récupération de la première ligne en erreur
         SELECT  TOP 1 @sMess = 'Première référence : ' + LTrim(RTrim(marque)) + ' - ' + LTrim(RTrim(reference))
           FROM  #TblTemp2 AS Tmp1
          WHERE  EXISTS ( SELECT Tmp2.marque, Tmp2.reference, count(*) 
                            FROM #TblTemp2 AS Tmp2
                           WHERE Tmp1.marque    = Tmp2.marque    AND 
                                 Tmp1.reference = Tmp2.reference
                        GROUP BY Tmp2.marque, Tmp2.reference
                          HAVING count(*) > 1
                        )

         INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 3: Echec", 'N', '   ' + @sMess )

         GOTO SORTIE_ERREUR
      End

   /*---------------------------------------------*/
   /* Vérification des types                      */
   /* frequence, prix_haut, prix_bas -> numérique */
   /*---------------------------------------------*/

   SELECT 'STEP16 ' + convert(varchar(25), getdate(),113)
   SELECT @nb = count(*) 
     FROM #TblTemp2 
    WHERE ISNUMERIC(frequence)=0 OR ISNUMERIC(prix_haut)=0 OR ISNUMERIC(prix_bas)=0

   IF @nb > 0
      begin
         If @nb = 1
            SET @sMess = 'une ligne possède des valeurs non numériques sur fréquence, prix_haut ou prix_bas'
         Else
            SET @sMess = convert (varchar(4), @nb ) + ' lignes possèdent des valeurs non numériques sur fréquence, prix_haut ou prix_bas'

         INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 3: Echec", 'N', '   ' + @sMess )

         SELECT TOP 1 @sMess = 'Première référence : ' + LTrim(RTrim(marque)) + ' - ' + LTrim(RTrim(reference)) 
           FROM #TblTemp2 
          WHERE ISNUMERIC(frequence)=0 OR ISNUMERIC(prix_haut)=0 OR ISNUMERIC(prix_bas)=0

         INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 3: Echec", 'N', '   ' + @sMess )

         GOTO SORTIE_ERREUR
      end


/*                     =====================                        */
/*                     *****  ETAPE 4 ******                        */
/*                     =====================                        */
/*------------------------------------------------------------------*/
/* Recopie des données dans la table IFR                            */
/*------------------------------------------------------------------*/
 
  INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
        VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 4: Début", null, '*** RECOPIE DANS TABLE IFR***' )

   SELECT 'STEP18 ' + convert(varchar(25), getdate(),113)
   INSERT INTO sysadm.ifr ( id_trait, marque, reference,	provenance, centrales, frequence, prix_haut, prix_bas, poids, battsupl,       
                            voxfunc, scrncol, infred, wireless, modem, digicam, mp3wma, systeme, commstnd, webconn, 
                            java, talktime, message, stndby, commpaym, provider, packtype, mep, alt_dispo, maj_le, maj_par  )
        SELECT @iIdTrait,
               UPPER ( LTRIM ( RTRIM (marque))      ),
               UPPER ( REPLACE(reference, ' ', '')  ), 
            	'IFR',
               UPPER ( LTRIM ( RTRIM (pays))        ), 
               CONVERT ( integer, frequence ),
               CONVERT ( decimal(11,2), prix_haut ),
               CONVERT ( decimal(11,2), prix_bas  ),
               UPPER ( LTRIM ( RTRIM (poids))       ),
               NULL,
               UPPER ( LTRIM ( RTRIM (voxfunc))     ),
               UPPER ( LTRIM ( RTRIM (scrncol))     ),
               UPPER ( LTRIM ( RTRIM (infred))      ),
               UPPER ( LTRIM ( RTRIM (wireless))    ),
               NULL,
               UPPER ( LTRIM ( RTRIM (digicam))     ),
               UPPER ( LTRIM ( RTRIM (mp3wma))      ),
               UPPER ( LTRIM ( RTRIM (systeme))     ),
               UPPER ( LTRIM ( RTRIM (commstnd))    ),
               UPPER ( LTRIM ( RTRIM (webconn))     ),
               UPPER ( LTRIM ( RTRIM (java))        ),
               NULL,
               UPPER ( LTRIM ( RTRIM (message))     ),
               NULL,
               UPPER ( LTRIM ( RTRIM (commpaym))    ),
               UPPER ( LTRIM ( RTRIM (provider))    ),
               UPPER ( LTRIM ( RTRIM (packtype))    ),
               UPPER ( LTRIM ( RTRIM (mep))         ),
               'O',
               getdate(),
               'IFR'

          FROM #TblTemp2
   
   
   IF ( @@error ) <> 0
      Begin
         INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 4: Echec", 'N', '   Problème lors de l''insertion dans table IFR' + convert (varchar(20), @@error) )
         GOTO SORTIE_ERREUR
      end
   Else
      Begin
   
         SELECT @iTot1 = count(*)
           FROM sysadm.ifr
          WHERE id_trait = @iIdTrait
   
         SELECT @iTot2 = count(*)
           FROM #TblTemp2
             
         IF @iTot1 <> @iTot2
            begin
               INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
                    VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 4: Echec", 'N', '   Problème sur nombre de lignes insérées. Table Temp: ' + convert (varchar(20),@iTot1) + '   Table IFR: ' + convert (varchar(20),@iTot2) )
                    GOTO SORTIE_ERREUR
            end
         ELSE
            begin
               INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
                    VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 4: Succès", 'O', '' )
            end
      end




/*                     =====================                        */
/*                     *****  ETAPE 5 ******                        */
/*                     =====================                        */
/*------------------------------------------------------------------*/
/* Renommage du fichier de travail en fichier historique            */
/*------------------------------------------------------------------*/
   SELECT 'STEP19 ' + convert(varchar(25), getdate(),113)
   INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
        VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 5: Début", null, '*** HISTORISATION FICHIER ***' )

   /*-----------------------------------------------------*/
   /* Renommage du fichier d'entrée en fichier de travail */
   /*-----------------------------------------------------*/
   SET @iPos = CHARINDEX ( '.', @sNomFicIn, 1 )

   SET @sNomFicHis = Left ( @sNomFicIn, @iPos -1 ) + '_' + Convert ( varchar(30), @iIdTrait) +
                     Substring (@sNomFicIn, @iPos, len (@sNomFicIn) ) 

   SET @sCmd = 'RENAME ' + @sNomRepIn + @sNomFicTrv + ' ' + @sNomFicHis


   EXEC @iCodeRetour = master.dbo.xp_cmdshell @sCmd, no_output
   IF @@error <> 0
      Begin   
         SET @sMess = 'Le lancement de la commande xp_cmdshell à échoué : ' + convert (varchar(30), @@error) 
         INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 5: Echec", 'N', '   ' + @sMess )
         GOTO SORTIE_ERREUR
      End

   IF @iCodeRetour = 0 
      Begin
         SET @sMess = 'Fichier ' + @sNomFicTrv + ' renommé en ' + @sNomFicHis
         INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 5: Succès", 'O', '   ' + @sMess )
      End
   ELSE
      Begin
         SET @sMess = 'Impossible de renommer le fichier ' + @sNomFicTrv + ' en ' + @sNomFicHis
         INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 5: Echec", 'N', '   ' + @sMess )
         GOTO SORTIE_ERREUR
      end


/*                     =====================                        */
/*                     *****  ETAPE 6 ******                        */
/*                     =====================                        */
/*------------------------------------------------------------------*/
/* Suppression des lignes SPB qui sont présents dans cette          */
/* intégration                                                      */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Pour tous les mobile qui viennent d'être intégré et qui ont un   */
/* montant frequence < @iMtPack on récupère le montant d'une        */
/* précédente ligne SPB si elle existait                            */ 
/*------------------------------------------------------------------*/
SELECT 'STEP20 ' + convert(varchar(25), getdate(),113)
UPDATE sysadm.ifr 

   SET frequence = ( SELECT min (frequence)
                       FROM sysadm.ifr ifr3
                      WHERE ifr3.provenance = 'SPB'            AND
                            ifr3.marque     = ifr.marque       AND
                            ifr3.reference  = ifr.reference
                   )

 WHERE ifr.id_trait   = @iIdTrait         AND
       ifr.frequence  < @iMtPack          AND
       ifr.provenance = 'IFR'             AND
         
       EXISTS ( SELECT *
                  FROM sysadm.ifr ifr2
                 WHERE ifr2.provenance = 'SPB'            AND
                       ifr2.marque     = ifr.marque      AND
                       ifr2.reference  = ifr.reference
               ) 

SELECT 'STEP21 ' + convert(varchar(25), getdate(),113)
SET @sMess = Convert (VarChar(10),@@RowCount) + ' prix récupéré(s) sur lignes SPB et répercuté(s) sur nouvelle intégration'
      INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 6: Succès", 'O', '   ' + @sMess )


/*--------------------------------------------------------------------*/
/* On supprime maintenant toutes les lignes SPB, qui sont dans la     */
/* nouvelle intégration                                               */ 
/*--------------------------------------------------------------------*/
SELECT 'STEP22 ' + convert(varchar(25), getdate(),113)
select @nbLigneDel = count(*)
  FROM sysadm.ifr ifr1
 WHERE ifr1.provenance = 'SPB'      AND
       EXISTS ( SELECT *
                  FROM sysadm.ifr ifr2
                 WHERE ifr2.provenance = 'IFR'            AND
                       ifr2.marque     = ifr1.marque      AND
                       ifr2.reference  = ifr1.reference   AND
                       ifr2.id_trait   = @iIdTrait
               )

IF @nbLigneDel > 0
   Begin
      
      SELECT *
        FROM sysadm.ifr
       WHERE ifr.provenance = 'SPB'      AND
             EXISTS ( SELECT *
                        FROM sysadm.ifr ifr2
                       WHERE ifr2.provenance = 'IFR'            AND
                             ifr2.marque     = ifr.marque       AND
                             ifr2.reference  = ifr.reference    AND
                             ifr2.id_trait   = @iIdTrait
                     )

      DELETE
        FROM sysadm.ifr
       WHERE ifr.provenance = 'SPB'      AND
             EXISTS ( SELECT *
                        FROM sysadm.ifr ifr2
                       WHERE ifr2.provenance = 'IFR'            AND
                             ifr2.marque     = ifr.marque       AND
                             ifr2.reference  = ifr.reference    AND
                             ifr2.id_trait   = @iIdTrait
                     )


      SET @sMess = Convert (VarChar(10),@nbLigneDel) + ' ligne(s) de type SPB supprimée(s) de la table IFR'
      INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
              VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Etape 6: Succès", 'O', '   ' + @sMess )

   End

/*--------------------------------------------------------------------*/
/* Toutes les lignes de la nouvelle intégration étant                 */
/* restée < @iMtPack sont placées en alt_dispo à 'N'                  */
/*--------------------------------------------------------------------*/
UPDATE sysadm.ifr 
   SET alt_dispo = 'N'
 WHERE ifr.id_trait   = @iIdTrait         AND
       ifr.frequence  < @iMtPack          AND
       ifr.provenance = 'IFR'             


/*                     =====================                        */
/*                     *****  ETAPE 7******                         */
/*                     =====================                        */
/*------------------------------------------------------------------*/
/* Compte rendu d'éxécution + envoi mail                            */
/*------------------------------------------------------------------*/
   SET @sMess = 'Nombre de lignes dans fichier d''origine   : ' + Convert ( varchar(10), @nbLigneOrig )
   INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
        VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Compte-Rendu", 'O', '   ' + @sMess )

   SET @sMess = 'Nombre de lignes réellement récupérées    : ' + Convert ( varchar(10), @iTot2       )
   INSERT INTO sysadm.trace_import_fic ( dte_trt, id_typ_trait, id_trait, etape, alt_ok, libelle ) 
        VALUES ( GetDate(), @sIdTypTrait, @iIdTrait, "Compte-Rendu", 'O', '   ' + @sMess )


Set @sCommande = "SELECT * FROM SIMPA2_TRT.sysadm.ifr WHERE alt_dispo = 'N'"
Set @sObjet    = "Intégration IFR"
set @sMessage  = "L'intégration IFR vient de s'effectuer, le fichier joint contient les lignes indisponibles"
SET @sRoot = master.sysadm.SPB_FN_GET_ROOT()+'SINISTRE\IFR\ifr.OUT'
EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, 'jff@spb.fr', @sMessage, @sObjet, '', 'jff@spb.fr', '', @sCommande, @sRoot, 2, ''

SORTIE_OK:
   COMMIT TRAN
   SET NOCOUNT OFF
   RETURN 0

SORTIE_ERREUR:
   SELECT 'SORTIE EN ERREUR'
   COMMIT TRAN
   SET NOCOUNT OFF
   RETURN -1
   
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_S01_VERIF_MODIF_MARQ_MODL]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_S01_VERIF_MODIF_MARQ_MODL]
GO


CREATE PROC sysadm.PS_S01_VERIF_MODIF_MARQ_MODL
--------------------------------------------------------------------
--
-- Procédure            :      PS_S01_VERIF_MODIF_MARQ_MODL
-- Auteur               :      FPI
-- Date                 :      27/04/2011 
-- Libellé              :      Renvoie le nombre de dossiers concernés par une marque et modele [VDoc3936]
-- Commentaires         :      
-- Arguments            :      
--	@sMarq	varchar(35)
--	@sModele	varchar(35)
-------------------------------------------------------------------
    @sMarque	varchar(35),
    @sModele	varchar(35)
AS

 Declare @iCpt1 integer,
	@iCpt2 integer
	
Select @iCpt1 = count (*) from sysadm.sinistre where marq_port = @sMarque and modl_port = @sModele
Select @iCpt2 = count (*) from sysadm.w_sin where marq_port = @sMarque and modl_port = @sModele

Return @iCpt1 + @iCpt2
Go

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_U01_IFR_SUPP_SPB]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_U01_IFR_SUPP_SPB]
GO

CREATE PROC sysadm.PS_U01_IFR_SUPP_SPB
--------------------------------------------------------------------
--
-- Procédure            :      PS_U01_IFR_SUPP_SPB
-- Auteur               :      ???
-- Date                 :      ???
-- Libellé              :      Mise à jour des dossiers suite fusion de marque/modele IFR
-- Commentaires         :      
-- Arguments            :      
-------------------------------------------------------------------
-- [ITSM358824] Nettoyage des tables lien_article, param_ftu_brk & substitution
-- JFF      16/01/2016   [PM251-5]
-------------------------------------------------------------------
	@sMarq		varchar(30),
	@sRef		varchar(30),
	@sNewMarq	varchar(30),
	@sNewRef	varchar(30)
AS

DECLARE @iTot INTEGER

	SELECT @iTot = COUNT(*)
	FROM	sysadm.article
	WHERE	id_marq_art_ifr = @sMarq
	AND		id_modl_art_ifr = @sRef
 
	IF @iTot > 0 
	BEGIN
		UPDATE	sysadm.article
		SET		id_marq_art_ifr = @sNewMarq,
				id_modl_art_ifr = @sNewRef
		WHERE	id_marq_art_ifr = @sMarq 
		AND		id_modl_art_ifr = @sRef
	END

	SELECT @iTot = COUNT(*)
	FROM	sysadm.w_sin
	WHERE	marq_port = @sMarq
	AND		modl_port = @sRef

	IF @iTot > 0 
	BEGIN
		UPDATE	sysadm.w_sin
		SET		marq_port = @sNewMarq,
				modl_port = @sNewRef
		WHERE	marq_port = @sMarq 
		AND		modl_port = @sRef
	END

	SELECT @iTot = COUNT(*)
	FROM	sysadm.sinistre
	WHERE	marq_port = @sMarq
	AND		modl_port = @sRef

	IF @iTot > 0 
	BEGIN
		UPDATE	sysadm.sinistre
		SET		marq_port = @sNewMarq,
				modl_port = @sNewRef
		WHERE	marq_port = @sMarq 
		AND		modl_port = @sRef
	END

	SELECT @iTot = COUNT(*)
	FROM	sysadm.w_commande
	WHERE	id_marq_art_ifr = @sMarq
	AND		id_modl_art_ifr = @sRef

	IF @iTot > 0 
	BEGIN
		UPDATE	sysadm.w_commande
		SET		id_marq_art_ifr = @sNewMarq,
				id_modl_art_ifr = @sNewRef
		WHERE	id_marq_art_ifr = @sMarq 
		AND		id_modl_art_ifr = @sRef
	END
	
	SELECT @iTot = COUNT(*)
	FROM	sysadm.commande
	WHERE	id_marq_art_ifr = @sMarq
	AND		id_modl_art_ifr = @sRef

	IF @iTot > 0 
	BEGIN
		UPDATE	sysadm.commande
		SET		id_marq_art_ifr = @sNewMarq,
				id_modl_art_ifr = @sNewRef
		WHERE	id_marq_art_ifr = @sMarq 
		AND		id_modl_art_ifr = @sRef
	END	
	
	UPDATE	sysadm.substitution
	SET		marq_app_orig = @sNewMarq,
			modl_app_orig = @sNewRef
	FROM sysadm.substitution s
	WHERE	marq_app_orig = @sMarq 
		AND		modl_app_orig = @sRef
		AND not exists (select 1 from sysadm.substitution s2 
			where s2.id_prod=s.id_prod
			and s2.marq_app_orig=@sNewMarq and s2.modl_app_orig=@sNewRef
			and s2.marq_app_subs=s.marq_app_subs and s2.modl_app_subs=s.modl_app_subs)

	UPDATE	sysadm.substitution
	SET		marq_app_subs = @sNewMarq,
			modl_app_subs = @sNewRef
	FROM sysadm.substitution s
	WHERE	marq_app_subs = @sMarq 
		AND		modl_app_subs = @sRef
		AND not exists (select 1 from sysadm.substitution s2 
			where s2.id_prod=s.id_prod
				and s2.marq_app_orig=s.marq_app_orig and s2.modl_app_orig=s.modl_app_orig
				and s2.marq_app_subs=@sNewMarq and s2.modl_app_subs=@sNewRef)

	-- Nettoyage de la table substitution
	delete sysadm.substitution
	from sysadm.substitution s
	where not exists (select 1 from ifr i where i.marque=s.marq_app_orig and i.reference=s.modl_app_orig)

	delete sysadm.substitution
	from sysadm.substitution s
	where not exists (select 1 from ifr i where i.marque=s.marq_app_subs and i.reference=s.modl_app_subs)

	delete from sysadm.substitution 
	where marq_app_orig=marq_app_subs and modl_app_orig=modl_app_subs
	
	--  Nettoyage de la table lien_article
	UPDATE	sysadm.lien_article
	SET		marq_ifr = @sNewMarq,
			modl_ifr = @sNewRef
	FROM sysadm.lien_article s
	WHERE	marq_ifr = @sMarq 
		AND		modl_ifr = @sRef
		AND not exists (select 1 from sysadm.lien_article l2 
			where l2.marq_ifr=@sNewMarq and l2.modl_ifr=@sNewRef)

	delete sysadm.lien_article
	from sysadm.lien_article l
	where not exists (select 1 from ifr i where i.marque=l.marq_ifr and i.reference=l.modl_ifr)

	-- param_ftu_brk

	UPDATE	sysadm.param_ftu_brk
	SET		id_marq_art = @sNewMarq,
			id_modl_art = @sNewRef
	FROM sysadm.param_ftu_brk s
	WHERE	id_marq_art = @sMarq 
		AND		id_modl_art = @sRef
		AND not exists (select 1 from sysadm.param_ftu_brk p2 
			where p2.id_marq_art=@sNewMarq and p2.id_modl_art=@sNewRef)

	delete sysadm.param_ftu_brk
	from sysadm.param_ftu_brk p
	where p.id_marq_art <> '-1'
		and p.id_modl_art <> '-1'
		and not exists (select 1 from ifr i where i.marque=p.id_marq_art and i.reference=p.id_modl_art)


	-- [PM251-5]
	Update sysadm.ctg_factu
	Set    marq_app = @sNewMarq,
		   modl_app = @sNewRef
	From	sysadm.ctg_factu cf
	Where  marq_app = @sMarq 
	AND	   modl_app = @sRef
	AND not exists (select Top 1 1 from sysadm.ctg_factu cf2 
			where cf2.marq_app=@sNewMarq and cf2.modl_app=@sNewRef)

	delete sysadm.ctg_factu
	from sysadm.ctg_factu cf
	where not exists (select top 1 1 from ifr i where i.marque=cf.marq_app and i.reference=cf.modl_app )


Go	


grant execute on sysadm.PS_U01_IFR_SUPP_SPB to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_VERIF_TYPE_MARQ_MODL
-- Auteur               :       JFF
-- Date                 :       14/10/2014
-- Libelle              :       Quand c'est possible, on vérifie sir la marque/modèle correspond au type d'apareil.
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VERIF_TYPE_MARQ_MODL' AND type = 'P' )
        DROP procedure sysadm.PS_S_VERIF_TYPE_MARQ_MODL
GO


CREATE procedure sysadm.PS_S_VERIF_TYPE_MARQ_MODL
        @adcIdSin	Decimal ( 10, 0 ), -- [PI062]
        @asMarque	Varchar ( 35 ),
		@asModele	Varchar ( 35 ),
		@asTypApp	Varchar ( 10 ),
		@asResult   VarChar ( 50 ) OUTPUT
AS

If Not Exists ( 
	Select	1
	From	sysadm.ifr i,
			sysadm.det_pro dp,
			sysadm.w_sin ws
	Where	ws.id_sin = @adcIdSin
	And		dp.id_prod = ws.id_prod
	And		dp.id_code_dp = 28
	And		dp.id_code_car = 'IFR' + ISNULL ( @asTypApp, '' )
	And		i.marque = @asMarque
	And		i.reference = @asModele
	And		i.sku_saga is not null
	)
	
	Begin 
		Set @asResult = 'OK'
		Return
	End

If Exists ( 
	Select	1
	From	sysadm.ifr i,
			sysadm.det_pro dp,
			sysadm.w_sin ws
	Where	ws.id_sin = @adcIdSin
	And		dp.id_prod = ws.id_prod
	And		dp.id_code_dp = 28
	And		dp.id_code_car = 'IFR' + ISNULL ( @asTypApp, '' )
	And		i.marque = @asMarque
	And		i.reference = @asModele
	And		Left( i.sku_saga, 3 ) = @asTypApp
	)
	Begin
		Set @asResult = 'OK'
	End 
	Else
	Begin
		Set @asResult = 'TYPE_APP_DIFF_MARQ_MODL_IFR'
	End
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_SKU_IFR
-- Auteur               :       JFF
-- Date                 :       19/02/2015
-- Libelle              :       [VDOC15533]
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SKU_IFR' AND type = 'P' )
        DROP procedure sysadm.PS_S_SKU_IFR
GO

CREATE procedure sysadm.PS_S_SKU_IFR
	@sIdMarqArtIfr	VarChar ( 35 ),
	@sIdModlArtIfr	VarChar ( 35 ),
	@sSkuIfr		varChar ( 35 ) OUTPUT
	
AS

Select  Top 1
		@sSkuIfr = i.sku_saga
From	sysadm.ifr i
Where   i.marque = @sIdMarqArtIfr
And		i.reference = @sIdModlArtIfr
And		i.id_trait = ( 
			Select	MAX ( id_trait)
			From	sysadm.ifr i1
			Where	i1.marque = i.marque
			And		i1.reference = i.reference
			)

If @sSkuIfr is null Set @sSkuIfr = ''

Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_S_EXTRAC_IFR
-- Auteur               :       JFF
-- Date                 :       29/09/2015
-- Libelle              :       [PM319-1]
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      05/10/2015   [PM319-2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_EXTRAC_IFR_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S_EXTRAC_IFR_V01
GO

CREATE procedure sysadm.DW_S_EXTRAC_IFR_V01
AS

	Select	
		id_trait,
		marque,
		reference,
		provenance,
		alt_dispo,
		centrales,
		frequence 'Prix_IFR',
		IsNull ( 
			( Select  Min ( Round ( mt_prix_ht * ( 1 + tva/100 ), 2 ) )
			  From	sysadm.article a
			  Where a.id_four = 'PPO'
			  And   a.id_marq_art_ifr = i1.marque
			  And	a.id_modl_art_ifr = i1.reference
			), 0.00 ) 'Prix_ORANGE',
		IsNull ( 
			( Select  Min ( Round ( mt_prix_ht * ( 1 + tva/100 ), 2 ) )
			  From	sysadm.article a
			  Where a.id_four = 'PPB'
			  And   a.id_marq_art_ifr = i1.marque
			  And	a.id_modl_art_ifr = i1.reference
			), 0.00 ) 'Prix_BOUYGUES',
		poids,
		battsupl,
		voxfunc,
		scrncol,
		infred,
		wireless,
		modem,
		digicam,
		mp3wma,
		systeme,
		commstnd,
		webconn,
		java,
		talktime,
		message,
		stndby,
		commpaym,
		provider,
		packtype,
		gps,
		mep,
		sku_saga 'type_appareil',
		maj_prix_auto,
		dern_maj_prix_trt,
		dern_maj_prix_dte,
		dern_maj_prix_par,
		maj_le,
		maj_par
	 
	From	sysadm.ifr i1
	WHERE i1.id_trait =	(select max ( i2.id_trait )
						from	sysadm.ifr i2
						where i2.marque = i1.marque
						and		i2.reference = i1.reference)
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S_MOTEUR_RECH_IFR
-- Auteur               :       JFF
-- Date                 :       29/09/2015
-- Libelle              :       
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-- Recherche précise = 'JAI_DE_LA_CHANCE'
-- Recherche par mots clés= 'MOTS_CLES'
-- Recherche par mots clés subst. = 'MOTS_CLES_PLUS'
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MOTEUR_RECH_IFR' AND type = 'P' )
        DROP procedure sysadm.PS_S_MOTEUR_RECH_IFR
GO

CREATE procedure sysadm.PS_S_MOTEUR_RECH_IFR
	@asChaineRech VarChar ( 100 ),
	@asMethodeRech  VarChar ( 30 )
AS

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  Marque	VarChar ( 50),
	  Modele	VarChar ( 50),
	  Tour	integer null 
	)

DECLARE @tbEqui TABLE 
	( id_seq	integer identity,
	  id_ordre  integer,
	  MotRech	VarChar ( 50),
	  MotEqui	VarChar ( 50),
	  marquage  integer null 
	)

DECLARE @tbDecoll TABLE 
	( id_seq	integer identity,
	  MotADecoller	VarChar ( 50),
	  marquage  integer null 
	)


Declare @iTour integer
Declare @iTourGeneral integer
Declare @iIdSeq integer
Declare @ChaineRech VarChar ( 100 )
Declare @ChaineRechOrig VarChar ( 100 )
Declare @ChaineRechOrig2 VarChar ( 100 )
Declare @sPartRech VarChar ( 100 )
Declare @iVal Integer
Declare @sMotRech Varchar ( 50 )
Declare @sMotEqui Varchar ( 50 )
Declare @sMotADecoller Varchar ( 50 )
Declare @IdOrdreMin Integer
Declare @sPlusPossible VarChar ( 10 )

Set @sPlusPossible = ''
Set @ChaineRechOrig2 = ''
Set @iTourGeneral = 1

While @iTourGeneral <= 3 
 Begin
	Delete @tbDecoll 
	Delete @tbEqui

	If @ChaineRechOrig2 <> '' Set @asChaineRech = @ChaineRechOrig2

	-- Mot à décoller
	Insert into @tbDecoll Values ( 'AKORA', 0 )
	Insert into @tbDecoll Values ( 'ANDROID', 0 )
	Insert into @tbDecoll Values ( 'AQUARIS', 0 )
	Insert into @tbDecoll Values ( 'ARNOVA', 0 )
	Insert into @tbDecoll Values ( 'ASCEND', 0 )
	Insert into @tbDecoll Values ( 'ASHA', 0 )
	Insert into @tbDecoll Values ( 'ASPIRE', 0 )
	Insert into @tbDecoll Values ( 'BETOUCH', 0 )
	Insert into @tbDecoll Values ( 'CHEFPAS', 0 )
	Insert into @tbDecoll Values ( 'CHILDPAD', 0 )
	Insert into @tbDecoll Values ( 'COBALT', 0 )
	Insert into @tbDecoll Values ( 'CYGNUS', 0 )
	Insert into @tbDecoll Values ( 'DESIRE', 0 )
	Insert into @tbDecoll Values ( 'DIAMOND', 0 )
	Insert into @tbDecoll Values ( 'DISCOVERY', 0 )
	Insert into @tbDecoll Values ( 'DOLBY', 0 )
	Insert into @tbDecoll Values ( 'DSLIDE', 0 )
	Insert into @tbDecoll Values ( 'EASY', 0 )
	Insert into @tbDecoll Values ( 'ELEMENT', 0 )
	Insert into @tbDecoll Values ( 'EXECUTIVE', 0 )
	Insert into @tbDecoll Values ( 'EXPLORER', 0 )
	Insert into @tbDecoll Values ( 'FAMILY', 0 )
	Insert into @tbDecoll Values ( 'FONEPAD', 0 )
	Insert into @tbDecoll Values ( 'GALAXY', 0 )
	Insert into @tbDecoll Values ( 'GAME', 0 )
	Insert into @tbDecoll Values ( 'HELIUM', 0 )
	Insert into @tbDecoll Values ( 'HIGHWAY', 0 )
	Insert into @tbDecoll Values ( 'HONOR', 0 )
	Insert into @tbDecoll Values ( 'ICONIA', 0 )
	Insert into @tbDecoll Values ( 'INTERNET', 0 )
	Insert into @tbDecoll Values ( 'IPAD', 0 )
	Insert into @tbDecoll Values ( 'IPHONE', 0 )
	Insert into @tbDecoll Values ( 'LENNY', 0 )
	Insert into @tbDecoll Values ( 'LIBERTO', 0 )
	Insert into @tbDecoll Values ( 'LUBI', 0 )
	Insert into @tbDecoll Values ( 'LUMIA', 0 )
	Insert into @tbDecoll Values ( 'MEMO', 0 )
	Insert into @tbDecoll Values ( 'NEXUS', 0 )
	Insert into @tbDecoll Values ( 'ODYSSEY', 0 )
	Insert into @tbDecoll Values ( 'OPTIMUS', 0 )
	Insert into @tbDecoll Values ( 'OXYGEN', 0 )
	Insert into @tbDecoll Values ( 'PAVILION', 0 )
	Insert into @tbDecoll Values ( 'PLATINIUM', 0 )
	Insert into @tbDecoll Values ( 'PLAY', 0 )
	Insert into @tbDecoll Values ( 'POWER', 0 )
	Insert into @tbDecoll Values ( 'PROTECTION', 0 )
	Insert into @tbDecoll Values ( 'RAINBOW', 0 )
	Insert into @tbDecoll Values ( 'RETINA', 0 )
	Insert into @tbDecoll Values ( 'SENSATION', 0 )
	Insert into @tbDecoll Values ( 'SHARK', 0 )
	Insert into @tbDecoll Values ( 'SLATE', 0 )
	Insert into @tbDecoll Values ( 'SLIDE', 0 )
	Insert into @tbDecoll Values ( 'SMART', 0 )
	Insert into @tbDecoll Values ( 'SPIDER', 0 )
	Insert into @tbDecoll Values ( 'SPORT', 0 )
	Insert into @tbDecoll Values ( 'SUNSET', 0 )
	Insert into @tbDecoll Values ( 'SURFACE', 0 )
	Insert into @tbDecoll Values ( 'THUNDER', 0 )
	Insert into @tbDecoll Values ( 'TITANIUM', 0 )
	Insert into @tbDecoll Values ( 'TLINK', 0 )
	Insert into @tbDecoll Values ( 'TOUCH', 0 )
	Insert into @tbDecoll Values ( 'TREKKER', 0 )
	Insert into @tbDecoll Values ( 'TROOPER', 0 )
	Insert into @tbDecoll Values ( 'ULTRA', 0 )
	Insert into @tbDecoll Values ( 'VENUS', 0 )
	Insert into @tbDecoll Values ( 'WAKE', 0 )
	Insert into @tbDecoll Values ( 'WATCH', 0 )
	Insert into @tbDecoll Values ( 'WEB', 0 )
	Insert into @tbDecoll Values ( 'WIFI', 0 )
	Insert into @tbDecoll Values ( 'WILD', 0 )
	Insert into @tbDecoll Values ( 'WINDOWS', 0 )
	Insert into @tbDecoll Values ( 'XBOX', 0 )
	Insert into @tbDecoll Values ( 'XENON', 0 )
	Insert into @tbDecoll Values ( 'XPERIA', 0 )
	Insert into @tbDecoll Values ( 'ZENFONE', 0 )
	Insert into @tbDecoll Values ( 'EDGE', 0 )
	Insert into @tbDecoll Values ( 'FEVER', 0 )
	Insert into @tbDecoll Values ( 'NIGHT', 0 )
	Insert into @tbDecoll Values ( 'SPECIAL', 0 )

	-- Substitution
	-- Attention à l'ordre d'insertion !!
	Insert into @tbEqui Values ( 10, 'GALAXY', 'GAL', 0 )
	Insert into @tbEqui Values ( 20, 'GALAX', 'GAL', 0 )
	Insert into @tbEqui Values ( 30, 'GALA', 'GAL', 0 )
	Insert into @tbEqui Values ( 40, 'GO', 'GB', 0 )
	Insert into @tbEqui Values ( 60, 'TOUCH', 'OT', 0 )
	Insert into @tbEqui Values ( 70, '+', 'PLUS', 0 )
	Insert into @tbEqui Values ( 80, 'POUCE', 'P', 0 )
	Insert into @tbEqui Values ( 90, 'TABLETTE', 'TAB', 0 )
	Insert into @tbEqui Values ( 100, 'SYSTEM', 'SYS', 0 )
	Insert into @tbEqui Values ( 110, 'GIGA', 'GB', 0 )

	Delete @tbEqui From @tbEqui t Where Exists ( Select Top 1 1 From @tbEqui t2 Where t2.MotRech = t.MotEqui )

	Set @ChaineRech = @asChaineRech
	Set @ChaineRech = Upper ( @ChaineRech )

	If CharIndex ( '''', @ChaineRech ) > 0 Set @ChaineRech = Replace ( @ChaineRech, '''', ' ' )
	If CharIndex ( '"', @ChaineRech ) > 0 Set @ChaineRech = Replace ( @ChaineRech, '"', ' ' )

	-- A décoller
	While Exists ( Select Top 1 1 From @tbDecoll where marquage = 0 )
	 Begin
		Select 	Top 1 
			@iIdSeq = id_seq,
			@sMotADecoller = MotADecoller
		From	@tbDecoll
		Where	marquage = 0

		If CharIndex ( @sMotADecoller, @ChaineRech ) > 0 
		  Begin
			Set @ChaineRech = Replace ( @ChaineRech, @sMotADecoller, ' ' + @sMotADecoller + ' ')
		  End 

		Update @tbDecoll
		Set marquage = 1
		Where id_seq = @iIdSeq
	 End


	While CharIndex ( '  ', @ChaineRech ) > 0 
	 Begin
		Set @ChaineRech = Replace ( @ChaineRech, '  ', ' ' )
	 End 

	Set @ChaineRech = ltrim ( rtrim ( @ChaineRech ))
	Set @ChaineRech = @ChaineRech + ' '
	Set @ChaineRechOrig = @ChaineRech 
	Set @ChaineRechOrig2 = @ChaineRech 

	-- Subtitution
	While Exists ( Select Top 1 1 From @tbEqui where marquage = 0 ) 
	 Begin
		Select @IdOrdreMin = min ( id_ordre ) 
		From   @tbEqui
		Where  marquage = 0

		Select 	Top 1 
			@iIdSeq = id_seq,
			@sMotRech = MotRech,
			@sMotEqui = MotEqui
		From	@tbEqui
		Where	marquage = 0
		And     id_ordre = @IdOrdreMin 

		If CharIndex ( @sMotRech, @ChaineRech ) > 0 
		  Begin
			Set @sPlusPossible = 'OUI'
			If @asMethodeRech in ( 'MOTS_CLES_PLUS' ) Set @sPlusPossible = 'NON'
			Set @ChaineRechOrig = Replace ( @ChaineRechOrig, @sMotRech, @sMotEqui )
			Set @ChaineRech = Replace ( @ChaineRech, @sMotRech, '' )
		  End 

		Update @tbEqui
		Set marquage = 1
		Where id_seq = @iIdSeq
	 End

	Set @ChaineRech = @ChaineRechOrig2

	If @asMethodeRech in ( 'MOTS_CLES_PLUS' ) 
	  Begin
		Set @ChaineRech = @ChaineRechOrig
	  End 
	Else
	  Begin
		Set @ChaineRech = @ChaineRechOrig2
		Set @ChaineRechOrig = @ChaineRech 
	  End 

	Set @iVal = CharIndex ( ' ', @ChaineRech ) 
	Set @sPartRech = rTrim ( ltrim ( Left ( @ChaineRech, @iVal - 1 )))
	If @sPartRech is null Set @sPartRech = ''
	Set @ChaineRech = Substring ( @ChaineRech, @iVal + 1, Len ( @ChaineRech ) )

	Set @iTour = 1

	If @asMethodeRech = 'JAI_DE_LA_CHANCE'
	 Begin
		Insert into @tb
		select distinct 
			   i.marque, 
			   i.reference,
			   @iTour 'Tour'
		from	sysadm.ifr i
		where	CharIndex ( Replace ( @ChaineRechOrig, ' ', '' ) ,  Replace ( rTrim ( i.marque ) + rTrim ( i.reference ), ' ', '' ) ) > 0 
		And		alt_dispo = 'O'
	 End

	If @asMethodeRech in (  'MOTS_CLES', 'MOTS_CLES_PLUS' )
	 Begin
		Insert into @tb
		select distinct 
			   i.marque, 
			   i.reference,
			   @iTour 'Tour'
		from	sysadm.ifr i
		where	CharIndex ( @sPartRech,  rTrim ( i.marque ) + ' ' + rTrim ( i.reference ) ) > 0 
		And		alt_dispo = 'O'
	 End

	While 1 = 1 And @asMethodeRech <> 'JAI_DE_LA_CHANCE'
	 Begin
 		If @ChaineRech = '' Or @ChaineRech = ' ' Break

		Set @iVal = CharIndex ( ' ', @ChaineRech ) 
		Set @sPartRech = rTrim ( ltrim ( Left ( @ChaineRech, @iVal - 1 )))
		If @sPartRech is null Set @sPartRech = ''
		If @iVal < Len ( @ChaineRech )
		 Begin
			Set @ChaineRech = Substring ( @ChaineRech, @iVal + 1, Len ( @ChaineRech ) )
		 End
		Else
		 Begin
		  Set @ChaineRech = ''
		 End 

		Set @iTour = @iTour + 1

		Insert into @tb
		select distinct 
			   Marque, 
			   Modele,
			   @iTour 'Tour'
		from	@tb
		where	CharIndex ( @sPartRech,  rTrim ( Marque ) + ' ' + rTrim ( Modele ) ) > 0 
		And    Tour = @iTour -1

		If @@RowCount <= 0 
		  Begin
			Delete @tb
			Break
		  End 

		Delete @tb Where Tour = @iTour -1

	 End

	If ( Select count(*) from @tb ) > 0 Break

	If @asMethodeRech = 'JAI_DE_LA_CHANCE' 
	  Begin
		Set @iTourGeneral = @iTourGeneral + 1
		Set @asMethodeRech = 'MOTS_CLES'
		Continue
	  End

	If @asMethodeRech = 'MOTS_CLES' 
	  Begin
		Set @iTourGeneral = @iTourGeneral + 1
		Set @asMethodeRech = 'MOTS_CLES_PLUS'
		Continue
	  End

	Break

 End
 
 Select Distinct Marque, Modele, @sPlusPossible 'PlusPossible' from @tb order by 1,2

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_VERIF_MARQ_MODL_IFR
-- Auteur               :       JFF
-- Date                 :       03/11/2016
-- Libelle              :       [DT276]
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VERIF_MARQ_MODL_IFR_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S_VERIF_MARQ_MODL_IFR_V01
GO

CREATE procedure sysadm.PS_S_VERIF_MARQ_MODL_IFR_V01
	@dcIdprod  Decimal( 7 ),
	@sIdTypArt VarChar ( 10),
	@asMarq VarChar ( 100 ),
	@asModl VarChar ( 100 )
AS
	Set @asMarq = LTrim ( RTrim ( UPPER  ( @asMarq )))
	Set @asModl = LTrim ( RTrim ( UPPER  ( @asModl )))

	If Exists ( 
			Select Top 1 1 
			From	sysadm.det_pro dp with (nolock)
			Where	dp.id_prod = @dcIdprod
			And		dp.id_code_dp = 28
			And		Right ( dp.id_code_car, 3 ) = @sIdTypArt
			And		Left  ( dp.id_code_car, 3 ) = 'IFR'
		)
	  And Not Exists ( 
		Select	Top 1 1 
		from	sysadm.ifr i with (nolock)
		Where   i.marque = @asMarq
		And		i.reference = @asModl
	)
	Begin 
		Return 0
	End 

	Return 1
Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_S02_IFR_LISTE_MARQUE
-- Auteur               :       FPI
-- Date                 :       14/08/2018
-- Libelle              :       [DT363]
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_IFR_LISTE_MARQUE' AND type = 'P' )
        DROP procedure sysadm.DW_S02_IFR_LISTE_MARQUE
GO

CREATE PROC sysadm.DW_S02_IFR_LISTE_MARQUE
	@sTypeApp varchar(3)
AS

SELECT DISTINCT marque
  FROM sysadm.ifr
  where sku_saga like @sTypeApp + '%'
UNION
SELECT null

ORDER BY marque

GO

grant execute on sysadm.DW_S02_IFR_LISTE_MARQUE to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_S02_IFR_LISTE_REFERENCE
-- Auteur               :       FPI
-- Date                 :       14/08/2018
-- Libelle              :       [DT363]
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_IFR_LISTE_REFERENCE' AND type = 'P' )
        DROP procedure sysadm.DW_S02_IFR_LISTE_REFERENCE
GO

CREATE PROC sysadm.DW_S02_IFR_LISTE_REFERENCE
	@sTypeApp varchar(3)
AS

SELECT DISTINCT marque, reference
  FROM sysadm.ifr
   where sku_saga like @sTypeApp + '%'
UNION
SELECT DISTINCT marque, null
  FROM sysadm.ifr
ORDER BY reference

GO

grant execute on sysadm.DW_S02_IFR_LISTE_REFERENCE to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S_MARQUE_IFR_SKU
-- Auteur               :       JFF
-- Date                 :       21/05/2019
-- Libelle              :       [DT386_EXTR_AXA]
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MARQUE_IFR_SKU_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S_MARQUE_IFR_SKU_V01
GO

CREATE procedure sysadm.PS_S_MARQUE_IFR_SKU_V01
  @sTypApp Varchar ( 3 )
AS

SET NOCOUNT ON

Set @sTypApp = ltrim ( @sTypApp )

If @sTypApp = '' Set @sTypApp = null

If @sTypApp is null 
  Begin 
	Select	Distinct
			i.marque 'Marque',
			Left ( i.sku_saga, 3 )
	from	sysadm.ifr i
	Where   i.id_trait = ( Select MAX (id_trait)
							From   sysadm.ifr i2
							Where  i2.marque = i.marque
							And    i2.reference = i.reference )
	And	i.alt_dispo = 'O'					   
	Order by i.marque
  End 
Else
  Begin 
	Select	Distinct
			i.marque 'Marque',
			Left ( i.sku_saga, 3 )
	from	sysadm.ifr i
	Where   i.id_trait = ( Select MAX (id_trait)
							From   sysadm.ifr i2
							Where  i2.marque = i.marque
							And    i2.reference = i.reference )
	And	i.alt_dispo = 'O'	
	And Left ( i.sku_saga, 3 ) = @sTypApp
	Order by i.marque
  End  


Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_MODELE_IFR_SKU
-- Auteur               :       JFF
-- Date                 :       21/05/2019
-- Libelle              :       [DT386_EXTR_AXA]
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MODELE_IFR_SKU_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S_MODELE_IFR_SKU_V01
GO


CREATE procedure sysadm.PS_S_MODELE_IFR_SKU_V01
@sMarque varchar(30),
@sTypApp Varchar ( 3 )
AS

SET NOCOUNT ON

Set @sTypApp = ltrim ( @sTypApp )

If @sTypApp = '' Set @sTypApp = null

If @sTypApp is null 
  Begin 
	Select	Distinct		
			i.reference 'Modele',
			Left ( i.sku_saga, 3 )
	from	sysadm.ifr i
	Where   i.id_trait = ( Select MAX (id_trait)
						   From   sysadm.ifr i2
						   Where  i2.marque = i.marque
						   And    i2.reference = i.reference )
	And	i.alt_dispo = 'O'					   
	And i.marque = @sMarque
	Order by i.reference
  End 
Else
  Begin 
	Select	Distinct		
			i.reference 'Modele',
			Left ( i.sku_saga, 3 )
	from	sysadm.ifr i
	Where   i.id_trait = ( Select MAX (id_trait)
						   From   sysadm.ifr i2
						   Where  i2.marque = i.marque
						   And    i2.reference = i.reference )
	And	i.alt_dispo = 'O'					   
	And i.marque = @sMarque
	And Left ( i.sku_saga, 3 ) = @sTypApp
	Order by i.reference
  End 

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_DT469_MAJ_AUTO_PRIX_IFR
-- Auteur               :       JFF
-- Date                 :       21/05/2019
-- Libelle              :       [DT469]
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_DT469_MAJ_AUTO_PRIX_IFR' AND type = 'P' )
        DROP procedure sysadm.PS_U_DT469_MAJ_AUTO_PRIX_IFR
GO


CREATE procedure sysadm.PS_U_DT469_MAJ_AUTO_PRIX_IFR
AS

-- Le 12/05/2022 : Je sécurise l'arrêt de ce traitement par un Return, si jamais le Job était réactiver par mégarde.
Return

-- [DT469]

SET NOCOUNT ON

Declare @tTrt Table ( 
	id_seq      integer identity,
	id_trait	integer,
	marque		varchar ( 35 ),
	modele      varchar ( 35 ),
	marquage	integer 
)

Declare @iIdSeq integer
Declare @iIdTrait integer
Declare @sMarque VarChar ( 35 )
Declare @sModele VarChar ( 35 )
Declare @dcMtPrixMoyen Decimal ( 11,2 )

Insert into @tTrt
Select	Distinct		
		i.id_trait,
		i.marque,
		i.reference,
		0
from	sysadm.ifr i
Where   i.id_trait = ( Select MAX (id_trait)
						From   sysadm.ifr i2
						Where  i2.marque = i.marque
						And    i2.reference = i.reference )
And	i.maj_prix_auto = 'O'					   

While Exists ( Select Top 1 1 From @tTrt where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq   = id_seq,
		@iIdTrait = id_trait,
		@sMarque  = marque,
		@sModele  = modele
	From	@tTrt
	Where	marquage = 0

	Select @dcMtPrixMoyen = avg ( IsNull ( mt_prix_ht, 0 ) * ( 1 + tva / 100 ))
	From   sysadm.article a 
	Where  a.id_four in ( 'CIS', 'CEG', 'PPO', 'PPB' ) 
	And    a.id_marq_art_ifr = @sMarque
	And    a.id_modl_art_ifr = @sModele
	And    CharIndex ( '[#NEU#]', a.observ_frn ) > 0 

	If @dcMtPrixMoyen is null Or @dcMtPrixMoyen <=0 Set @dcMtPrixMoyen = 0

	If @dcMtPrixMoyen = 0 
	 Begin
		-- On ne fait rien
		Update @tTrt Set marquage = 1 Where id_seq = @iIdSeq
		Continue
	 End 

	 -- Maj Ifr
	 Update sysadm.ifr 
	 Set frequence = @dcMtPrixMoyen,
		 prix_bas =  Convert ( integer, @dcMtPrixMoyen) ,
		 prix_haut = Convert ( integer, @dcMtPrixMoyen),
	     dern_maj_prix_trt = 'AUTO',
	     dern_maj_prix_dte = Getdate(),
	     dern_maj_prix_par = 'AUTO'
	 Where id_trait = @iIdTrait
	 And   marque   = @sMarque
	 And   reference = @sModele

	Update @tTrt Set marquage = 1 Where id_seq = @iIdSeq
 End
 
GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_SYS_EXPLOIT_APP_IFR
-- Auteur               :       JFF
-- Date                 :       21/05/2019
-- Libelle              :       [PC202553_SELECTRA]
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SYS_EXPLOIT_APP_IFR' AND type = 'P' )
        DROP procedure sysadm.PS_S_SYS_EXPLOIT_APP_IFR
GO

CREATE procedure sysadm.PS_S_SYS_EXPLOIT_APP_IFR
	@asMarqueIfr		VarChar ( 35 ),
	@asModeleIfr		VarChar ( 35 ),
	@asSysExploit		VarChar ( 35 ) OUTPUT

AS

Set @asMarqueIfr = Upper ( @asMarqueIfr ) 
Set @asModeleIfr = Upper ( @asModeleIfr ) 

Select Top 1 @asSysExploit = infred
From sysadm.ifr i
Where i.marque = @asMarqueIfr
And   i.reference = @asModeleIfr

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_RELEVE_PRIX_IFR_A_REVOIR
-- Auteur               :       JFF
-- Date                 :       12/05/2022
-- Libelle              :       [RS2980] PS_S_RELEVE_PRIX_IFR_A_REVOIR
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RELEVE_PRIX_IFR_A_REVOIR' AND type = 'P' )
        DROP procedure sysadm.PS_S_RELEVE_PRIX_IFR_A_REVOIR
GO

CREATE procedure sysadm.PS_S_RELEVE_PRIX_IFR_A_REVOIR
AS

Set NoCount On

-- Pro actif avant que le GT ne prenne le dossier
Update i
Set dern_maj_prix_trt = 'URGE'
From sysadm.w_sin ws, 
	 sysadm.ifr i
Where ws.cod_etat = 0
And i.marque = ws.marq_port
And i.reference = ws.modl_port
and i.dern_maj_prix_dte < DateAdd ( month, i.per_rev_prix_mois * (-1), getdate() )
And i.dern_maj_prix_trt not in ( 'URGE', 'FERM' ) 

-- MAJ d'abord des ENCA, ENCE
; WIth T1 ( nbre, marq_port, modl_port )
As ( 
Select	Case 
			When i.dern_maj_prix_trt = 'URGE' Then 99999
			Else count ( * ) 
		End 'nbre', 
		s.marq_port, 
		s.modl_port
From sysadm.div_sin ds with (nolock),
	 sysadm.sinistre s with (nolock),
	 sysadm.det_pro dp with (nolock),
	 sysadm.ifr i with (nolock)
WHere ds.nom_zone = 'type_app'
And   s.id_sin = ds.id_sin
And   dp.id_prod = s.id_prod
And   dp.id_code_dp = 28
And   dp.id_code_car = 'IFR' + rtrim ( ds.val_car )
And   s.cree_le > DateAdd ( day, -30, Getdate () ) -- ... Des dossiers de moins de 30 jours
And   s.marq_port is not null
And   s.modl_port is not null
And   i.marque = s.marq_port
And   i.reference = s.modl_port
And   (   ( i.dern_maj_prix_dte < DateAdd ( month, ( Abs ( Convert ( integer, i.per_rev_prix_mois )) -1)  * (-1), getdate()) And i.dern_maj_prix_trt <> 'FERM' ) -- prix plus vieux que 2 mois
       Or ( i.dern_maj_prix_trt = 'URGE' )
	  )

Group By i.dern_maj_prix_trt, s.marq_port, s.modl_port
Union
Select  99999 'nbre', 
		i.marque, 
		i.reference
From sysadm.ifr i
Where i.dern_maj_prix_trt = 'URGE'
),
T2 ( numero, nbre, marq_port,  modl_port )
As
(
Select rank() over (order by nbre desc,marq_port, modl_port  ) numero,
	   nbre,
	   marq_port,
	   modl_port
From T1

)
Update i
Set    i.dern_maj_prix_trt =
			Case 
				When DateAdd ( month, Abs ( Convert ( integer, i.per_rev_prix_mois )), i.dern_maj_prix_dte ) > GetDate() Then 'ENCA'
				Else 'ENCE'
			End 

From T2 t,
	 sysadm.ifr i 
Where t.numero <= 200
And i.marque = t.marq_port
And i.reference = t.modl_port
And i.dern_maj_prix_trt <> 'URGE'


-- Extraction
; WIth T1 ( nbre, marq_port, modl_port )
As ( 
Select	Case 
			When i.dern_maj_prix_trt = 'URGE' Then 99999
			Else count ( * ) 
		End 'nbre', 
		s.marq_port, 
		s.modl_port
From sysadm.div_sin ds with (nolock),
	 sysadm.sinistre s with (nolock),
	 sysadm.det_pro dp with (nolock),
	 sysadm.ifr i with (nolock)
WHere ds.nom_zone = 'type_app'
And   s.id_sin = ds.id_sin
And   dp.id_prod = s.id_prod
And   dp.id_code_dp = 28
And   dp.id_code_car = 'IFR' + rtrim ( ds.val_car )
And   s.cree_le > DateAdd ( day, -30, Getdate () ) -- ... Des dossiers de moins de 30 jours
And   s.marq_port is not null
And   s.modl_port is not null
And   i.marque = s.marq_port
And   i.reference = s.modl_port
And   (   ( i.dern_maj_prix_dte < DateAdd ( month, ( Abs ( Convert ( integer, i.per_rev_prix_mois )) -1)  * (-1), getdate()) And i.dern_maj_prix_trt <> 'FERM' ) -- prix plus vieux que 2 mois
       Or ( i.dern_maj_prix_trt = 'URGE' )
	  )
Group By i.dern_maj_prix_trt, s.marq_port, s.modl_port
Union
Select  99999 'nbre', 
		i.marque, 
		i.reference
From sysadm.ifr i
Where i.dern_maj_prix_trt = 'URGE'
),
T2 ( numero, nbre, marq_port,  modl_port )
As
(
Select rank() over (order by nbre desc,marq_port, modl_port  ) numero,
	   nbre,
	   marq_port,
	   modl_port
From T1
)
Select 'Appareils sinistrés du ' + Convert ( Varchar ( 10), DateAdd ( day, -30, Getdate () ) , 103 ) + ' au ' + Convert ( Varchar ( 10), Getdate () , 103 ) 'Période_glissante',
	   t.numero 'Rang_par_volume',
	   t.nbre 'Nbre_fois_sinistré_sur_période',
	   t.marq_port 'Marque',
	   t.modl_port 'Modèle',
	   i.frequence 'Prix_IFR_actuel',
	   sysadm.FN_AFF_DATE ( i.dern_maj_prix_dte, 'AVEC_HEURE') 'Date_dern_maj_prix',
	   i.per_rev_prix_mois 'Période_revision_prix_en_mois',
	   i.dern_maj_prix_trt 'Code_etat_prix',
	   Case i.dern_maj_prix_trt
		 When 'ENCA' Then 'Prix à revoir, postérieur à ' + Convert ( varchar (5), Abs ( Convert ( integer, i.per_rev_prix_mois )) -1) + ' mois (en avance)'
		 When 'ENCE' Then 'Prix à revoir, postérieur à ' + Convert ( varchar (5), Abs ( Convert ( integer, i.per_rev_prix_mois ))) + ' mois (expiré)'
		 When 'URGE' Then '[URGENT] Prix à revoir en urgence, dossier(s) en attente(s) !'
		 Else i.dern_maj_prix_trt 
	   End 'Lib_etat_prix',
	   Case i.dern_maj_prix_trt 
		 When 'ENCA' Then 'Ce prix expirera le ' + Convert ( Varchar ( 10 ), DateAdd ( month, Abs ( Convert ( integer, i.per_rev_prix_mois )), i.dern_maj_prix_dte ), 103 ) + ', vous avez donc ' + Convert ( Varchar ( 10 ),Abs ( DateDiff ( day, DateAdd ( month, Abs ( Convert ( integer, i.per_rev_prix_mois )), i.dern_maj_prix_dte ), getdate() )), 103 ) + ' jour(s) pour le modifier avant que cet appareil bloque potentiellement des dossiers en gestion.'
	     When 'ENCE' Then 'Ce prix a expiré le ' + Convert ( Varchar ( 10 ), DateAdd ( month, Abs ( Convert ( integer, i.per_rev_prix_mois )), i.dern_maj_prix_dte ), 103 ) + ', soit depuis ' + Convert ( Varchar ( 10 ), Abs ( DateDiff ( day, DateAdd ( month, Abs ( Convert ( integer, i.per_rev_prix_mois )), i.dern_maj_prix_dte ), getdate() )), 103 ) + ' jour(s), s''il est choisi en gestion, il bloquera le dossier. Modifiez le maintenant. Pour les très vieux appareils, fermez le prix si vous pensez qu''il ne bourgera plus jamais.'
		 When 'URGE' Then 'Au moins un dossier est actuellement bloqué en gestion sur cet appareil ou a été bloqué car le GT a pu choisir un autre appareil, revoyez tout de même le prix en urgence.'
		 Else i.dern_maj_prix_trt 
	   End 'Commentaire'
From T2 t,
	 sysadm.ifr i with (nolock)
Where t.numero <= 200
And i.marque = t.marq_port
And i.reference = t.modl_port
And i.dern_maj_prix_trt <> 'ENCO'
Order by  i.dern_maj_prix_trt desc, 
		  Case When i.dern_maj_prix_trt in ( 'URGE', 'ENCE') Then i.dern_maj_prix_dte  End desc ,
		  Case When i.dern_maj_prix_trt in ( 'ENCA') Then i.dern_maj_prix_dte End ,
		  t.numero -- i.dern_maj_prix_dte 

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_MARQUAGE_PRIX_IFR_A_REVOIR
-- Auteur               :       JFF
-- Date                 :       12/05/2022
-- Libelle              :       [RS2980] PS_S_MARQUAGE_PRIX_IFR_A_REVOIR
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_MARQUAGE_PRIX_IFR_A_REVOIR' AND type = 'P' )
        DROP procedure sysadm.PS_U_MARQUAGE_PRIX_IFR_A_REVOIR
GO

CREATE procedure sysadm.PS_U_MARQUAGE_PRIX_IFR_A_REVOIR
		@asMarqIfr	VarChar ( 35 ),
		@asModlIfr	VarChar ( 35 ),
		@asCodeRet  Varchar ( 20 ) Output
AS

Declare @sCodeActuel Varchar ( 20 )

Set @asMarqIfr = rtrim ( ltrim ( Upper ( @asMarqIfr )))
Set @asModlIfr = rtrim ( ltrim ( Upper ( @asModlIfr )))

Select @sCodeActuel = i.dern_maj_prix_trt
From sysadm.ifr i with (nolock)
Where i.marque = @asMarqIfr
And   i.reference = @asModlIfr 

If @sCodeActuel in ( 'URGE', 'FERM' )
 Begin
	Set @asCodeRet = @sCodeActuel 
	Return
 End 

If Exists ( 
	Select Top 1 1 
	From sysadm.ifr i with (nolock)
	Where i.marque = @asMarqIfr
	And   i.reference = @asModlIfr 
	And   i.dern_maj_prix_trt in ( 'ENCO', 'ENCA', 'ENCE')
	And   i.dern_maj_prix_dte < DateAdd ( month, Abs ( i.per_rev_prix_mois) * (-1), getdate()) 
)
	Begin
		Set @asCodeRet = 'URGE'

		Update sysadm.ifr 
		Set dern_maj_prix_trt = 'URGE' 
		Where marque = @asMarqIfr
		And   reference = @asModlIfr 

		Return
	End 

Set @asCodeRet = 'ENCO'

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RELEVE_PRIX_IFR_A_REVOIR_MAIL
-- Auteur               :       JFF
-- Date                 :       13/05/2022
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [RS2980] PS_S_RELEVE_PRIX_IFR_A_REVOIR_MAIL
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RELEVE_PRIX_IFR_A_REVOIR_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S_RELEVE_PRIX_IFR_A_REVOIR_MAIL
GO

CREATE procedure sysadm.PS_S_RELEVE_PRIX_IFR_A_REVOIR_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(1000),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	,
	@dtRef datetime,
	@iCount Integer

-- [RS2980_IFR]
Set @dtRef=getdate()

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT() + 'Sinistre\Extraction_RS2980_IFR\'
Set @sFileName	= 'RS2980_PRIX_IFR_A_REVOIR_' + Replace ( convert( varchar ( 10), CONVERT ( Datetime, Getdate(), 103 ), 112 ) + convert( varchar ( 10), getdate(), 8 ), ':', '' )
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

If @iCount <= 0 Return
	
SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
	db_name(db_id()) + '.sysadm.PS_S_RELEVE_PRIX_IFR_A_REVOIR ' + 
	'" /o' + @sFicOut + ' -w5000' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = 'Extraction prix IFR à revoir, dossiers du ' + Convert ( Varchar ( 10), DateAdd ( day, -30, Getdate () ) , 103 ) + ' au ' + Convert ( VarChar ( 10), Getdate (), 103 ) + ' (Extraction de ' + Right ( '00' + Left ( convert ( VarChar (10), Getdate(), 8 ), 2 ) ,2 ) + 'H)'

set @sMessage  = 'Bonjour,'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Veuillez-trouver en pièce-jointe la liste des appareils IFR dont les prix sont à revoir. Les appareils ont été sélectionnés sur des dossiers ouverts dans la période du ' + Convert ( Varchar ( 10), DateAdd ( day, -30, Getdate () ) , 103 ) + ' au ' + Convert ( VarChar ( 10), Getdate (), 103 ) + '.'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Cordialement,'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
Set @sMessage = @sMessage + 'Fabry Jean-François'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'DSI/Etudes SIMPA2'

EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'sloison@spb.eu,ntonnetot@spb.eu', -- 'jff@spb.fr',
			@sMessage, 
			@sObjet, 
			'IFR', 
			'ayvon@spb.eu,cbourdoiseau@spb.eu,jff@spb.fr', -- 'jff@spb.fr' , 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL

Go


