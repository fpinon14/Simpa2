-------------------------------------------------------------------
--
-- Fichier              : BTE_ARCH.CP
-- Auteur               : PLJ
-- Date                 : 14/08/2003
--
-- Commentaires         : Liste des procédures regroupant tooutes les fonctionnalités
--                        nécessaire au paramétrage et gestion des boîtes à archive.
--
-- Procédures           : DD_S01_WKFS_PROFIL         PLJ   Liste des profils pour DDDW
--                        DD_S01_PROF_ETABLISSEMENT  PLJ   Liste de tous les etablissements par produit + ets -1
--                        DD_S01_PROF_COMPAGNIE      PLJ   Liste des compagnies possédant un produit de paramétré
--                        DD_S02_PROF_COMPAGNIE      PLJ   Liste des produits et compagnies paramétrés
--                        DW_S01_WKFS_PROFIL         PLJ   Select d'un profil
--                        DW_S01_WKFS_REGROUP        PLJ   Select des regroupements d'un produit
--                        DW_S02_WKFS_REGROUP        PLJ   Select d'un regroupement
--                        DW_S01_WKFS_BOITE          PLJ   Selection de la boite en cours d'un opérateur pour un profil
--                        DW_S01_WKFS_HISTO          PLJ
--                        DW_S01_WKFS_W_QUEUE        PLJ
--                        DW_S02_WKFS_W_BOITE        PLJ
--                        PS_VAL_ARCH_CENT           PLJ   Validation centralisée
--                        PS_S01_BOITE_ARCHIVE       DGA
-------------------------------------------------------------------


--------------------------------------------------------------------
--
-- Procédure            : DD_S01_WKFS_PROFIL
-- Auteur               : PLJ
-- Date                 : 14/08/2003
-- Libellé              : Liste des profils pour DDDW
--                        
-- Commentaires         :
-- Références           : dddw_sp_wks_profil
--
-- Arguments            : 
--
-- Retourne             : 
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S01_WKFS_PROFIL' AND type = 'P' )
            DROP procedure sysadm.DD_S01_WKFS_PROFIL
GO

CREATE PROC sysadm.DD_S01_WKFS_PROFIL

AS

SELECT   id_profil,
         lib_profil,
         id_cie

  FROM   sysadm.wkfs_profil

 ORDER
    BY   id_profil
GO





--------------------------------------------------------------------
--
-- Procédure            : DD_S01_PROF_ETABLISSEMENT
-- Auteur               : PLJ
-- Date                 : 14/08/2003
-- Libellé              : Liste de tous les etablissements par produit
--                        + ajout un etablissement -1 pour chaque produit
-- Commentaires         :
-- Références           : 
--
-- Arguments            : 
--
-- Retourne             : 
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S01_PROF_ETABLISSEMENT' AND type = 'P' )
            DROP procedure sysadm.DD_S01_PROF_ETABLISSEMENT
GO

CREATE PROC sysadm.DD_S01_PROF_ETABLISSEMENT

AS

SELECT DISTINCT id_prod, id_ets 
  FROM sysadm.etablissement

UNION 

SELECT id_prod, -1
  FROM sysadm.produit

Go



--------------------------------------------------------------------
--
-- Procédure            : DD_S01_PROF_COMPAGNIE
-- Auteur               : PLJ
-- Date                 : 14/08/2003
-- Libellé              : Liste des compagnies possédant un produit de
--                        paramétré
-- Commentaires         :
-- Références           : 
--
-- Arguments            : 
--
-- Retourne             : 
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S01_PROF_COMPAGNIE' AND type = 'P' )
            DROP procedure sysadm.DD_S01_PROF_COMPAGNIE
GO

CREATE PROC sysadm.DD_S01_PROF_COMPAGNIE

AS

SELECT   DISTINCT
         compagnie.id_cie,
         compagnie.lib_cie

  FROM   sysadm.garantie   INNER JOIN sysadm.police    ON   sysadm.garantie.id_police   = sysadm.police.id_police
                           INNER JOIN sysadm.compagnie ON   sysadm.police.id_cie        = sysadm.compagnie.id_cie

GO

--------------------------------------------------------------------
--
-- Procédure            : DD_S02_PROF_COMPAGNIE
-- Auteur               : PLJ
-- Date                 : 14/08/2003
-- Libellé              : Liste des produits et compagnies paramétrés
--                       
-- Commentaires         :
-- Références           : 
--
-- Arguments            : 
--
-- Retourne             : 
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S02_PROF_COMPAGNIE' AND type = 'P' )
            DROP procedure sysadm.DD_S02_PROF_COMPAGNIE
GO

CREATE PROC sysadm.DD_S02_PROF_COMPAGNIE

AS

SELECT DISTINCT 
        id_prod,
        compagnie.id_cie,
        compagnie.lib_cie
  FROM  sysadm.garantie   INNER JOIN sysadm.police    ON garantie.id_police = police.id_police
                          INNER JOIN sysadm.compagnie ON police.id_cie      = compagnie.id_cie 
Go



--------------------------------------------------------------------
--
-- Procédure            : DW_S01_WKFS_PROFIL
-- Auteur               : PLJ
-- Date                 : 14/08/2003
-- Libellé              : Select d'un profil
--                        
-- Commentaires         :
-- Références           : dw_trt_sp_pofil
--
-- Arguments            : 
--
-- Retourne             : 
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_WKFS_PROFIL' AND type = 'P' )
            DROP procedure sysadm.DW_S01_WKFS_PROFIL
GO

CREATE PROC sysadm.DW_S01_WKFS_PROFIL
@iIdProfil      integer
AS

SELECT   id_profil,
      	id_cie,
      	id_typ_arch,
      	lib_profil,
      	cree_le,
      	maj_le,
      	maj_par

  FROM   sysadm.wkfs_profil

 WHERE   id_profil = @iIdProfil

GO

--------------------------------------------------------------------
--
-- Procédure            : DW_S02_WKFS_PROFIL
-- Auteur               : PLJ
-- Date                 : 12/09/2003
-- Libellé              : Select de tous les profils pour une compagnie une méthode
--                        
-- Commentaires         :
-- Références           : dw_stk_sp_pofil
--
-- Arguments            : 
--
-- Retourne             : 
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_WKFS_PROFIL' AND type = 'P' )
            DROP procedure sysadm.DW_S02_WKFS_PROFIL
GO

CREATE PROC sysadm.DW_S02_WKFS_PROFIL
@iIdCie       integer,
@iIdTypArch   integer
AS

Declare @dcIdCie Decimal ( 7 )

Set @dcIdCie = Convert ( Decimal ( 7 ), @iIdCie )

SELECT   id_profil,
      	id_cie,
      	id_typ_arch,
      	lib_profil,
      	cree_le,
      	maj_le,
      	maj_par

  FROM   sysadm.wkfs_profil

 WHERE   id_cie       = @dcIdCie         AND
         id_typ_arch  = @iIdTypArch

GO


--------------------------------------------------------------------
--
-- Procédure            : DW_S01_WKFS_REGROUP
-- Auteur               : PLJ
-- Date                 : 20/08/2003
-- Libellé              : Selection des regoupements d'un produit
--                        
-- Commentaires         :
-- Références           : dw_trt_sp_Regroup
--
-- Arguments            : 
--
-- Retourne             : 
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_WKFS_REGROUP' AND type = 'P' )
        DROP procedure sysadm.DW_S01_WKFS_REGROUP
GO

CREATE PROC sysadm.DW_S01_WKFS_REGROUP
@iIdProd      integer
AS

Declare @dcIdProd Decimal ( 7 )

Set @dcIdProd = Convert ( Decimal ( 7 ), @iIdProd )

SELECT   wkfs_regroup.id_prod,
         produit.lib_court,
      	wkfs_regroup.id_ets,
      	wkfs_regroup.id_cie,
         wkfs_regroup.dte_val_deb,
         wkfs_regroup.dte_val_fin,
         compagnie.lib_cie,
      	wkfs_regroup.id_profil,
         wkfs_profil.lib_profil,
      	wkfs_regroup.cree_le,
      	wkfs_regroup.maj_le,
      	wkfs_regroup.maj_par
--ajout Migration PB4 PB8 WYNIWYG 03/2006
,	cast(null as varchar(10)) as 'alt_erreur'
  FROM   sysadm.wkfs_regroup INNER JOIN sysadm.produit      ON produit.id_prod       = wkfs_regroup.id_prod 
                              INNER JOIN sysadm.compagnie   ON compagnie.id_cie      = wkfs_regroup.id_cie
                              INNER JOIN sysadm.wkfs_profil ON wkfs_profil.id_profil = wkfs_regroup.id_profil

 WHERE   wkfs_regroup.id_prod = @dcIdProd

ORDER BY wkfs_regroup.id_prod,
         wkfs_regroup.id_ets,
      	 wkfs_regroup.id_cie,
         wkfs_regroup.dte_val_deb
GO



--------------------------------------------------------------------
--
-- Procédure            : DW_S02_WKFS_REGROUP
-- Auteur               : PLJ
-- Date                 : 21/08/2003
-- Libellé              : Selection d'un regroupement
--                        
-- Commentaires         :
-- Références           : dw_trt_sp_Regroup
--
-- Arguments            : 
--
-- Retourne             : 
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_WKFS_REGROUP' AND type = 'P' )
            DROP procedure sysadm.DW_S02_WKFS_REGROUP
GO

CREATE PROC sysadm.DW_S02_WKFS_REGROUP
@iIdProd      integer,
@iIdEts       integer,
@iIdCie       integer,
@dDteValDeb   datetime
AS

Declare @dcIdProd Decimal ( 7 )
Declare @dcIdEts Decimal ( 7 )
Declare @dcIdCie Decimal ( 7 )

Set @dcIdProd = Convert ( Decimal ( 7 ), @iIdProd )
Set @dcIdEts = Convert ( Decimal ( 7 ), @iIdEts )
Set @dcIdCie = Convert ( Decimal ( 7 ), @iIdCie )


SELECT   id_prod,
      	id_ets,
      	id_cie,
         dte_val_deb,
         dte_val_fin,
      	id_profil,
      	cree_le,
      	maj_le,
      	maj_par

  FROM   sysadm.wkfs_regroup

 WHERE   id_prod     = @dcIdProd       AND
         id_ets      = @dcIdEts       AND
         id_cie      = @dcIdCie       AND
         dte_val_deb = @dDteValDeb 


GO


--------------------------------------------------------------------
--
-- Procédure            : DW_S01_WKFS_BOITE
-- Auteur               : PLJ
-- Date                 : 21/08/2003
-- Libellé              : Selection de la boite en cours d'un opérateur pour un profil donné
--                        
-- Commentaires         :
-- Références           : dw_trt_sp_Regroup
--
-- Arguments            : 
--
-- Retourne             : 
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_WKFS_BOITE' AND type = 'P' )
            DROP procedure sysadm.DW_S01_WKFS_BOITE
GO

CREATE PROC sysadm.DW_S01_WKFS_BOITE
@iIdProfil    integer,
@sIdOper      char(4)
AS

SELECT  wkfs_boite.no_boite,
        wkfs_boite.id_profil,
        wkfs_boite.alt_ouverte,
        wkfs_boite.id_oper,
        wkfs_boite.dte_ouv,
        wkfs_boite.dte_ferm,
        wkfs_boite.cree_le,
        wkfs_boite.maj_le,
        wkfs_boite.maj_par,
        'O'                  AS   ALT_VALIDE

  FROM  sysadm.wkfs_boite   INNER JOIN sysadm.wkfs_profil   ON  wkfs_boite.id_profil = wkfs_profil.id_profil

 WHERE  wkfs_boite.id_profil   = @iIdProfil   AND
        wkfs_boite.id_oper     = @sIdOper     AND
        wkfs_boite.alt_ouverte = 'O' 
Go

--------------------------------------------------------------------
--
-- Procédure            : DW_S01_WKFS_HISTO
-- Auteur               : PLJ
-- Date                 : 21/08/2003
-- Libellé              : Selection de la boite en cours d'un opérateur pour un profil donné
--                        
-- Commentaires         :
-- Références           : dw_trt_sp_Regroup
--
-- Arguments            : 
--
-- Retourne             : 
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_WKFS_HISTO' AND type = 'P' )
            DROP procedure sysadm.DW_S01_WKFS_HISTO
GO

CREATE PROC sysadm.DW_S01_WKFS_HISTO
@iIdSin    integer

AS

Declare @dcIdSin Decimal ( 10 ) -- [PI062]

Set @dcIdSin = Convert ( Decimal ( 10 ), @iIdSin ) -- [PI062]

SELECT  'H'                      AS type,
        wkfs_histo.id_sin,
        wkfs_histo.no_boite,
        wkfs_histo.rang_boite,
        wkfs_histo.archive_le,
        wkfs_histo.archive_par,
        wkfs_histo.cree_le,
        wkfs_histo.maj_le,
        wkfs_histo.maj_par

  FROM  sysadm.wkfs_histo

 WHERE  wkfs_histo.id_sin   = @dcIdSin -- [PI062]

UNION

SELECT  'R'                  AS type,
        routage.id_sin,
        routage.no_boite,
        routage.rang_boite,
        routage.archive_le,
        routage.archive_par,
        routage.cree_le,
        routage.maj_le,
        routage.maj_par

  FROM  sysadm.routage

 WHERE  routage.id_sin   = @dcIdSin -- [PI062]

ORDER BY type desc, archive_le Desc


Go


--------------------------------------------------------------------
--
-- Procédure            : DW_S01_WKFS_W_QUEUE
-- Auteur               : PLJ
-- Date                 : 08/09/2003
-- Libellé              : Selection du sinistre dans wkfs_w_queue pour validation en méthode centralisé
--                        
-- Commentaires         :
-- Références           : dw_trt_sp_wkfs_w_queue
--
-- Arguments            : 
--
-- Retourne             : 
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_WKFS_W_QUEUE' AND type = 'P' )
            DROP procedure sysadm.DW_S01_WKFS_W_QUEUE
GO

CREATE PROC sysadm.DW_S01_WKFS_W_QUEUE
@iIdSin    integer

AS

Declare @dcIdSin Decimal ( 10 ) -- [PI062]

Set @dcIdSin = Convert ( Decimal ( 10 ), @iIdSin ) -- [PI062]
 

SELECT   wkfs_w_queue.id_sin,
         wkfs_w_queue.id_prod,
         produit.lib_court,
         wkfs_w_queue.id_cie,
         compagnie.lib_cie,
         wkfs_w_queue.id_prov,
         wkfs_w_queue.valide_le,
         wkfs_w_queue.valide_par,
         wkfs_w_queue.cree_le,
         wkfs_w_queue.maj_le,
         wkfs_w_queue.maj_par,
         sinistre.dte_surv,
         sinistre.heu_surv,
         sinistre.dte_decl,
         code_in.lib_code,
         code_cr.lib_code,
         code_ns.lib_code,
         code_tr.lib_code,
         code_dt.lib_code,
         sinistre.id_ets,
         sinistre.id_adh,
         sinistre.id_sdos,
         sinistre.dte_adh,
         sinistre.id_rev,
         code_ci.lib_code,
         personne.nom,
         personne.prenom,
         personne.adr_1,
         personne.adr_2,
         personne.adr_cp,
         personne.adr_ville,
         code_et.lib_code,
         sinistre.cree_le,
         sinistre.maj_le,
         sinistre.maj_par,
         sinistre.valide_le,
         sinistre.valide_par

  FROM   sysadm.wkfs_w_queue   INNER JOIN sysadm.produit          ON wkfs_w_queue.id_prod = produit.id_prod
                               INNER JOIN sysadm.compagnie        ON wkfs_w_queue.id_cie  = compagnie.id_cie
                               INNER JOIN sysadm.sinistre         ON wkfs_w_queue.id_sin  = sinistre.id_sin
                               INNER JOIN sysadm.personne         ON personne.id_ordre    = sinistre.id_ordre
            

                               INNER JOIN sysadm.code_car code_cr ON sinistre.cod_decl    = code_cr.id_code   AND
                                                                     code_cr.id_typ_code  = '-CR'

                               INNER JOIN sysadm.code_car code_in ON sinistre.cod_i_decl  = code_in.id_code   AND
                                                                     code_in.id_typ_code  = '-IN'

                               INNER JOIN sysadm.code code_ns     ON sinistre.id_natsin   = code_ns.id_code   AND
                                                                     code_ns.id_typ_code  = '+NS'

                               INNER JOIN sysadm.code code_tr     ON sinistre.id_territ   = code_tr.id_code   AND
                                                                     code_tr.id_typ_code  = '+TR'

                               INNER JOIN sysadm.code code_dt     ON sinistre.id_detsin   = code_dt.id_code   AND
                                                                     code_dt.id_typ_code  = '+DT'

                               INNER JOIN sysadm.code code_ci     ON personne.cod_civ     = code_ci.id_code   AND
                                                                     code_ci.id_typ_code  = '-CI'

                               INNER JOIN sysadm.code code_et     ON sinistre.cod_etat    = code_et.id_code   AND
                                                                     code_et.id_typ_code  = '-ET'

 WHERE   wkfs_w_queue.id_sin = @dcIdSin

Go

--------------------------------------------------------------------
--
-- Procédure            : DW_S02_WKFS_W_BOITE
-- Auteur               : PLJ
-- Date                 : 10/09/2003
-- Libellé              : Récupération du n° de boîte
--                        
-- Commentaires         :
-- Références           : 
--
-- Arguments            : 
--
-- Retourne             : 
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_WKFS_W_BOITE' AND type = 'P' )
            DROP procedure sysadm.DW_S02_WKFS_W_BOITE
GO

CREATE procedure sysadm.DW_S02_WKFS_W_BOITE
@iIdProd        Integer,
@iIdEts         Integer,
@iIdCie         Integer,
@sIdOper        Char(4)
AS


Declare @dcIdProd Decimal ( 7 )
Declare @dcIdEts Decimal ( 7 )
Declare @dcIdCie Decimal ( 7 )

Set @dcIdProd = Convert ( Decimal ( 7 ), @iIdProd )
Set @dcIdEts = Convert ( Decimal ( 7 ), @iIdEts )
Set @dcIdCie = Convert ( Decimal ( 7 ), @iIdCie )

SET NOCOUNT ON

Declare @iIdProfil     Integer,
        @sNoBoite      VarChar (10),
        @dDateJour     DateTime,
        @iIdTypArch    Integer,
        @sbOk          Char(1)

SET @dDateJour = Convert ( DateTime, Convert ( VarChar (10), GetDate(),103 ) )

SET @sbOk = 'O'
/*------------------------------------------------------------------*/
/* Récupération du profil tout d'abord pour un ets précis           */
/* puis pour l'ensemble des ets (-1) si l'Ets précis n'existe pas   */
/* On doit forcément en avoir un et un seul, si ce n'est pas le cas */
/* on sort avec la valeur -1                                        */
/*------------------------------------------------------------------*/
SELECT  @iIdProfil = id_profil
  FROM  sysadm.wkfs_regroup 
 WHERE  wkfs_regroup.id_prod = @dcIdProd            AND
        wkfs_regroup.id_ets  = @dcIdEts             AND
        wkfs_regroup.id_cie  = @dcIdCie             AND
        wkfs_regroup.dte_val_deb <= @dDateJour     AND
        wkfs_regroup.dte_val_fin >  @dDateJour

IF @@RowCount = 0
   Begin
      SELECT  @iIdProfil = id_profil
        FROM  sysadm.wkfs_regroup 
       WHERE  wkfs_regroup.id_prod = @dcIdProd            AND
              wkfs_regroup.id_ets  = -1                  AND
              wkfs_regroup.id_cie  = @dcIdCie             AND
              wkfs_regroup.dte_val_deb <= @dDateJour     AND
              wkfs_regroup.dte_val_fin >  @dDateJour

      IF @@RowCount <> 1
         Begin
            Set @sbOk = 'N'
         End

   End

IF @sbOk = 'N'
   Begin
      SET @iIdProfil = -1
   End

ELSE
   Begin

      /*------------------------------------------------------------------*/
      /* Récupération de la méthode Id_Typ_Arch, dont on traitera la      */
      /* valeur sur le code PB                                            */
      /*------------------------------------------------------------------*/
      SELECT @iIdTypArch = id_typ_arch
        FROM sysadm.wkfs_profil
       WHERE id_profil = @iIdProfil

      /*------------------------------------------------------------------*/
      /* A partir du profil on récupère le numéro de boite en cours pour  */
      /* l'opérateur spécifique.                                          */
      /* Nous sommes en méthode centralisée l'opérateur est un des #XXX   */
      /*------------------------------------------------------------------*/
      SELECT @sNoBoite = no_boite
        FROM sysadm.wkfs_boite
       WHERE wkfs_boite.id_profil   = @iIdProfil   AND
             wkfs_boite.alt_ouverte = 'O'          AND
             wkfs_boite.id_oper     = @sIdOper 

      /*-------------------------------------------------------------------*/
      /* S'il y a plus d'une boîte ouverte Pb                              */
      /*-------------------------------------------------------------------*/
      IF @@ROWCOUNT > 1
         Begin
            SET @sNoBoite = 'ERREUR 01'
         End         

   End

/*------------------------------------------------------------------*/        
/* Je reprends le même ResultSet que la Procedure                   */
/* PS_S01_BOITE_ARCHIVE pour faciliter l'ouverture                  */
/* On arme des valeurs uniques pour n'avoir que ces valeurs à       */
/* tester dans PowerBuilder.                                        */
/*------------------------------------------------------------------*/
IF @iIdTypArch IS NULL
   BEGIN
      SET @iIdTypArch = -1
   END

IF @iIdProfil IS NULL
   BEGIN
      SET @iIdProfil = -1
   END
        
SELECT  0,
        '',
        '',
        @iIdCie,
        @iIdProfil,
        @iIdTypArch,
        @sNoBoite,
        0
        
GO


--------------------------------------------------------------------
--
-- Procédure            : PS_VAL_ARCH_CENTRAL
-- Auteur               : PLJ
-- Date                 : 11/09/2003
-- Libellé              : Validation centralisé
--                        
-- Commentaires         :
-- Références           : 
--
-- Arguments            : @iIdSin         identifiant du sinistre à archiver
--                        @sNoBoite       N° de boite dans laquelle le dossier a été archivé (physiquement)
--                        @sIdOper        On passe les initiales de l'opérateur et non du centre d'archivage
--
-- Retourne             : 
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_VAL_ARCH_CENTRAL' AND type = 'P' )
            DROP procedure sysadm.PS_VAL_ARCH_CENTRAL
GO

CREATE procedure sysadm.PS_VAL_ARCH_CENTRAL
@iIdSin         Integer,
@sNoBoite       VarChar(10),
@sIdOper        Char(4)
AS

Declare @iRangBoite   Integer

/*------------------------------------------------------------------*/
/* Récupération du rang dans la boîte                               */
/*------------------------------------------------------------------*/
SELECT  @iRangBoite     = ISNULL ( MAX ( rou.rang_boite ), 0 )  + 1
  FROM  sysadm.routage  AS rou
 WHERE  rou.no_boite    = @sNoBoite

        
/*------------------------------------------------------------------*/
/* MAJ dans routage                                                 */
/*------------------------------------------------------------------*/
UPDATE   sysadm.routage
   SET   no_boite         = @sNoBoite,
         rang_boite       = @iRangBoite,
         archive_le       = getdate(),
         archive_par      = @sIdOper  
 WHERE   id_sin = Convert ( Decimal ( 10 ), @iIdSin ) -- [PI062]


/*------------------------------------------------------------------*/
/* Suppression de wkfs_w_queue                                      */
/*------------------------------------------------------------------*/
DELETE sysadm.wkfs_w_queue WHERE id_sin = @iIdSin

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_BOITE_ARCHIVE
-- Auteur               :       Erick John Stark
-- Date                 :       21/08/2003 11:27:57
-- Libellé              :        
-- Commentaires         :       Récupération des informations pour la gestion des boites à archive
-- Références           :       Utilisé dans D_SP_SIN_BOITE_ARCHIVE
--
-- Arguments            :       @adcIdSin       Decimal (  7,0 )        (Val)
--                      :       @asIdOper       Varchar (  4 )          (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_BOITE_ARCHIVE' AND type = 'P' )
        DROP procedure sysadm.PS_S01_BOITE_ARCHIVE
GO


CREATE procedure sysadm.PS_S01_BOITE_ARCHIVE
        @adcIdSin       Decimal (  10,0 ), -- [PI062]
        @asIdOper       VarChar (  10  )
AS

SET NOCOUNT ON

Declare @dcIdRev        Decimal (  7,0 )
Declare @dcIdProd       Decimal (  7,0 )
Declare @dcIdCie        Decimal (  7,0 )
Declare @dcIdEts        Decimal (  7,0 )
Declare @dcIdProfil     Decimal (  7,0 )
Declare @iIdTypArch     Integer
Declare @iTotHisto      Integer
Declare @sBoiteCourante VarChar (  10  )
Declare @dDateJour      DateTime

/*------------------------------------------------------------------*/
/* Initialisation des variables                                     */
/*------------------------------------------------------------------*/
SET @dcIdCie    = -1
SET @dDateJour  = CONVERT ( DateTime, CONVERT ( VarChar ( 10 ), GetDate (), 103 ) )
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
/*------------------------------------------------------------------*/        
/* On arme des valeurs uniques pour n'avoir que ces valeurs à       */
/* tester dans PowerBuilder.                                        */
/*------------------------------------------------------------------*/
IF @dcIdCie IS NULL
        BEGIN
                SET @dcIdCie = -1
        END
IF @dcIdProfil IS NULL
        BEGIN
                SET @dcIdProfil = -1
        END

SELECT  @iTotHisto = COUNT ( * )
FROM    sysadm.wkfs_histo
WHERE   wkfs_histo.id_sin       = @adcIdSin

        
SELECT  rou.id_sin,
        rou.dos_suivi_par,
        rou.no_boite,
        @dcIdCie as 'id_cie',
        @dcIdProfil as 'id_profil',
        @iIdTypArch as 'id_typ_arch',
        @sBoiteCourante as 'id_boite_courante',
        @iTotHisto as 'Nbr Histo.'
FROM    sysadm.routage          AS rou
WHERE   rou.id_sin = @adcIdSin

GO


