-------------------------------------------------------------------
--
-- Fichier              :       ROUTAGE.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       
--
-- Procédures           :       PS_U01_ROUTAGE_WKF
--                              PS_U02_ROUTAGE_VAL
--                              PS_I01_ROUTAGE_WKF
--				PS_S01_ROUTAGE
--				DW_S01_ROUTAGE
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_U01_ROUTAGE_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Modification de la table ROUTAGE
-- Références           :       Utilisé dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdCorb       Decimal (  3,0 )        (Val)
--                      :       @sCodTravail    Varchar (  3 )          (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @sCodOper       Varchar (  4 )          (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      31/03/2025   [MIG82_JOURN_EVT]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_ROUTAGE_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_U01_ROUTAGE_WKF
GO

  
CREATE procedure sysadm.PS_U01_ROUTAGE_WKF  
        @dcIdSin        Decimal (  10,0 ), -- [PI062]  
        @dcIdCorb       Decimal (  3,0 ),  
        @sCodTravail    Varchar (  3   ),  
        @dtCreeLe       DateTime        ,  
        @sCodOper       Varchar (  4   )  
AS  
  
Declare @sCodTravailActuel      VarChar (  3 )  
Declare @sNoBoite               VarChar ( 10 )  
Declare @sVar					VarChar ( 255 )
Declare @iRowCountRoutage		Integer

/*------------------------------------------------------------------*/  
/* Le 25/08/2003. Modification pour la gestion des boites à archive.*/  
/* Si le dossier est clos (COD_TRAVAIL=CAS) et que l'on posséde des */  
/* références d'archivage précédentes, on sauvegarde ces valeurs    */  
/* dans la table wkfs_histo.                                        */  
/*------------------------------------------------------------------*/  
SELECT  @sCodTravailActuel      = rou.cod_travail,  
        @sNoBoite               = rou.no_boite  
FROM    sysadm.routage  AS rou  
WHERE   rou.id_sin      = @dcIdSin  
  
IF      @sCodTravailActuel = 'CAS' And @sNoBoite IS NOT NULL  
        BEGIN  
/*------------------------------------------------------------------*/  
/* Trace des valeurs dans WKFS_HISTO.                               */  
/*------------------------------------------------------------------*/  
                INSERT INTO     sysadm.wkfs_histo  
                                (  
                                sysadm.wkfs_histo.id_sin,  
                                sysadm.wkfs_histo.no_boite,  
                                sysadm.wkfs_histo.rang_boite,  
                                sysadm.wkfs_histo.archive_le,  
                                sysadm.wkfs_histo.archive_par,  
                                sysadm.wkfs_histo.cree_le,  
                                sysadm.wkfs_histo.maj_le,  
                                sysadm.wkfs_histo.maj_par  
                                )  
                SELECT          rou.id_sin,  
                                IsNull(rou.no_boite,'-1'), -- [PC393]  
                                IsNull(rou.rang_boite,-1), -- [PC393]  
                                rou.archive_le,  
                                rou.archive_par,  
                                @dtCreeLe,  
                                @dtCreeLe,  
                                @sCodOper  
                FROM            sysadm.routage  AS rou  
                WHERE           rou.id_sin      = @dcIdSin  
/*------------------------------------------------------------------*/  
/* RAZ des valeurs pour les boites à archives.                      */  
/*------------------------------------------------------------------*/  
                UPDATE          rou  
                SET             rou.no_boite    = NULL,  
                                rou.rang_boite  = NULL,  
                                rou.archive_le  = NULL,  
                                rou.archive_par = NULL  
                FROM            sysadm.routage  AS rou  
        WHERE           rou.id_sin      = @dcIdSin  
        END  
/*------------------------------------------------------------------*/  
/* S'il existe une ligne dans la table wkfs_w_queue, il faut la     */  
/* supprimer.                                                       */  
/*------------------------------------------------------------------*/  
IF      @sCodTravail = 'CAS' And ( SELECT COUNT(*) FROM sysadm.wkfs_w_queue WHERE    wkfs_w_queue.id_sin = @dcIdSin ) = 1  
        BEGIN  
                DELETE FROM     sysadm.wkfs_w_queue  
                WHERE           sysadm.wkfs_w_queue.id_sin      = @dcIdSin  
        END  
  
 UPDATE         sysadm.routage  
 SET            sysadm.routage.id_corb          = @dcIdCorb,  
                sysadm.routage.alt_queue        = 'O',  
                sysadm.routage.cod_travail      = @sCodTravail,  
                sysadm.routage.maj_le           = @dtCreeLe,  
                sysadm.routage.maj_par          = @sCodOper  
 WHERE          routage.id_sin                  = @dcIdSin  

 Set @iRowCountRoutage = @@RowCount  
  
 -- [MIG82_JOURN_EVT]

 If Not Exists ( 
	Select Top 1 1 
	From sysadm.journal_evtsin jevt
	Where jevt.id_sin = @dcIdSin
	And   jevt.code_evt = 'DSDECL'
 )  And @sCodTravail = 'DEC'
	Begin
		Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'DSDECL', @sVar, '', 'PS_U01_ROUTAGE_WKF', @sCodOper
		Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'ECTTRT', @sVar, '', 'PS_U01_ROUTAGE_WKF', @sCodOper
	End 

 Return @iRowCountRoutage 
  
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_ROUTAGE_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table ROUTAGE
-- Références           :       Utilisé dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdCorb       Decimal (  3,0 )        (Val)
--                      :       @sCodTravail    Varchar (  3 )          (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      31/03/2025   [MIG82_JOURN_EVT]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_ROUTAGE_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_I01_ROUTAGE_WKF
GO

CREATE procedure sysadm.PS_I01_ROUTAGE_WKF
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdCorb       Decimal (  3,0 ),
        @sCodTravail    Varchar (  3   ),
        @dtCreeLe       DateTime
AS

Declare @sVar					VarChar ( 255 )
Declare @iRowCountRoutage		Integer

 INSERT INTO    sysadm.routage
        (       routage.id_sin,
                routage.alt_supp,
                routage.id_corb,
                routage.cod_table,
                routage.cod_travail,
                routage.alt_queue,
                routage.cree_le,
                routage.maj_le,
                routage.maj_par,
                routage.dos_suivi_par,
                routage.no_boite)
 VALUES (       @dcIdSin,
                'N',
                @dcIdCorb,
                'X',
                @sCodTravail,
                'O',
                @dtCreeLe,
                @dtCreeLe,
                'CREE',
                null,
                null)

 
 Set @iRowCountRoutage = @@RowCount  
  
 -- [MIG82_JOURN_EVT]
 If Not Exists ( 
	Select Top 1 1 
	From sysadm.journal_evtsin jevt
	Where jevt.id_sin = @dcIdSin
	And   jevt.code_evt = 'DSDECL'
 )  And @sCodTravail = 'DEC'
	Begin
		Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'DSDECL', @sVar, '', 'PS_I01_ROUTAGE_WKF', 'CREE'
		Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'ECTTRT', @sVar, '', 'PS_I01_ROUTAGE_WKF', 'CREE'
	End 

 Return @iRowCountRoutage

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_U02_ROUTAGE_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Modification de la table ROUTAGE
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodTravail    Varchar (  3 )          (Val)
--                      :       @sCodOper       Varchar (  4 )          (Val)
--                      :       @dtValideLe     DateTime                (Val)
--                      :       @sNoBoite       VarChar ( 10 )          (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      31/03/2025   [MIG82_JOURN_EVT]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U02_ROUTAGE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U02_ROUTAGE_VAL
GO

CREATE procedure sysadm.PS_U02_ROUTAGE_VAL 
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodTravail    Varchar (  3   ),
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime        ,
        @sNoBoite       VarChar ( 10   )
AS

/*------------------------------------------------------------------*/
/* Le 25/08/2003. Modification pour la gestion des boites à archive.*/
/*------------------------------------------------------------------*/
Declare @dtArchiveLe    DateTime
Declare @sArchivePar    VarChar ( 4 )
Declare @iRangBoite     Integer
Declare @dcIdCie        Decimal ( 7,0 )
Declare @sVar					VarChar ( 255 )
Declare @iRowCountRoutage		Integer
/*------------------------------------------------------------------*/
/* Gestion PRIVEE.                                                  */
/*------------------------------------------------------------------*/
IF      @sCodTravail = 'CAS' And @sNoBoite <> 'CENTRALISE' And @sNoBoite IS NOT NULL
        BEGIN
                SET @dtArchiveLe        = @dtValideLe
                SET @sArchivePar        = @sCodOper

                SELECT  @iRangBoite     = ISNULL ( MAX ( rou.rang_boite ), 0 )  + 1
                FROM    sysadm.routage  AS rou
                WHERE   rou.no_boite    = @sNoBoite
        END
/*------------------------------------------------------------------*/
/* Gestion CENTRALISE.                                              */
/*------------------------------------------------------------------*/
IF      @sCodTravail = 'CAS' And @sNoBoite = 'CENTRALISE' And @sNoBoite IS NOT NULL
        BEGIN
                SET @sNoBoite           = NULL
/*------------------------------------------------------------------*/
/* On récupére la compagnie qui gére le dossier.                    */
/*------------------------------------------------------------------*/
                EXEC @dcIdCie = sysadm.PS_S01_SINISTRE_CIE_BOITE_ARCHIVE @dcIdSin

                INSERT  INTO    sysadm.wkfs_w_queue
                                (
                                wkfs_w_queue.id_sin,
                                wkfs_w_queue.id_prod,
                                wkfs_w_queue.id_ets,
                                wkfs_w_queue.id_cie,
                                wkfs_w_queue.id_prov,
                                wkfs_w_queue.valide_le,
                                wkfs_w_queue.valide_par,
                                wkfs_w_queue.cree_le,
                                wkfs_w_queue.maj_le,
                                wkfs_w_queue.maj_par,
                                wkfs_w_queue.valide_par_sin,
                                wkfs_w_queue.valide_le_sin
                                )
                SELECT          @dcIdSin,
                                sinistre.id_prod,
                                sinistre.id_ets,
                                @dcIdCie,
                                1,
                                @dtValideLe,
                                @sCodOper,
                                @dtValideLe,
                                @dtValideLe,
                                @sCodOper,
                                sinistre.valide_par,
                                sinistre.valide_le
                FROM            sysadm.sinistre
                WHERE           sinistre.id_sin = @dcIdSin
        END

 UPDATE         sysadm.routage
 SET            sysadm.routage.alt_queue        = 'N',
                sysadm.routage.cod_travail      = @sCodTravail,
                sysadm.routage.maj_le           = @dtValideLe,
                sysadm.routage.maj_par          = @sCodOper,
                sysadm.routage.no_boite         = @sNoBoite,
                sysadm.routage.rang_boite       = @iRangBoite,
                sysadm.routage.archive_le       = @dtArchiveLe,
                sysadm.routage.archive_par      = @sArchivePar
 FROM           sysadm.routage,
                sysadm.w_queue
 WHERE          routage.id_sin          = @dcIdSin                      AND
                Convert ( Char(10), routage.id_sin ) = w_queue.id_sin   AND -- [PI062]
                w_queue.alt_occupe      = 'O'

  Set @iRowCountRoutage = @@RowCount  
  
 -- [MIG82_JOURN_EVT]
 If Not Exists ( 
	Select Top 1 1 
	From sysadm.journal_evtsin jevt
	Where jevt.id_sin = @dcIdSin
	And   jevt.code_evt = 'DSDECL'
 )  And @sCodTravail = 'DEC'
	Begin
		Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'DSDECL', @sVar, '', 'PS_U02_ROUTAGE_VAL', @sCodOper
		Exec sysadm.PS_I_INSERTION_JOURNAL_EVTSIN @dcIdSin, 'ECTTRT', @sVar, '', 'PS_U02_ROUTAGE_VAL', @sCodOper
	End 

 Return @iRowCountRoutage 

GO



--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_ROUTAGE
-- Auteur               :       Fabry JF
-- Date                 :       10/05/01
-- Libellé              :        
-- Commentaires         :       Select sur routage
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodTravail	VarChar ( 3 )	OUTPUT
--				@sAltqueue      Varchar (  1   )OUTPUT
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_ROUTAGE' AND type = 'P' )
        DROP procedure sysadm.PS_S01_ROUTAGE
GO

CREATE procedure sysadm.PS_S01_ROUTAGE
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodTravail    Varchar (  3   ) OUTPUT,
        @sAltQueue      Varchar (  1   ) OUTPUT
AS

select 	@sCodTravail = cod_travail,
	@sAltQueue   = alt_queue
from 	sysadm.routage
where 	id_sin = @dcIdSin

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_ROUTAGE
-- Auteur               :       Fabry JF
-- Date                 :       10/05/01
-- Libellé              :        
-- Commentaires         :       Select DOS_SUIVI_PAR sur routage dans le cas d'un CPL
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_ROUTAGE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_ROUTAGE
GO

CREATE procedure sysadm.DW_S01_ROUTAGE
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

select 	id_sin,
	dos_suivi_par,
	no_boite
from 	sysadm.routage
where 	id_sin = @dcIdSin

GO

