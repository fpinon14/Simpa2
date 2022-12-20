-------------------------------------------------------------------
--
-- Fichier              :       FRAIS.CP
-- Auteur               :       PLJ
-- Date                 :       20/07/1998
--
-- Commentaires         :       Gestion des frais dans SIMPA2
--
-- Procédures           :       DW_S01_FRAIS
--                              PS_I01_FRAIS_VAL
--				PS_I01_TRACE_REGL_AUTO
--				PS_INSERTION_FRAIS_AUTOMATIQUE   // DCMP 040206
--                              PS_ENVOI_MAIL_SUITE_INSERTION_FRAIS // DCMP 040206
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_FRAIS
-- Auteur               :       PLJ
-- Date                 :       20/07/1998
-- Libellé              :        
-- Commentaires         :       Select sur la table FRAIS
-- Références           :       Utilis‚ dans W_CM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal ( 7, 0 )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_FRAIS' AND type = 'P' )
        DROP procedure sysadm.DW_S01_FRAIS
GO

CREATE procedure sysadm.DW_S01_FRAIS
 @dcIdSin        Decimal ( 10, 0 ) -- [PI062]
AS
 SELECT frais.id_sin,
        frais.id_i,
        frais.id_frais,
        frais.id_typ_frais,
        frais.lib_frais,
        frais.mt_frais,
	frais.id_reg,
        frais.cod_etat,
        frais.cree_le,
        frais.maj_le,
        frais.maj_par        
 FROM   sysadm.frais
 WHERE  frais.id_sin = @dcIdSin

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_TRACE_REGL_AUTO
-- Auteur               :       Erick John Stark
-- Date                 :       21/05/2003 11:27:57
-- Libellé              :
-- Commentaires         :       Voir la DCMP 040206. Il s'agit d'insérer des frais en automatique.
-- Références           :
--
-- Arguments            :       @adcIdSin               Decimal (  7,0 )        (Val)
--                              @aiIdSeq                Integer                 (Val)
--                              @adcIdProd              Deciaml (  7,0 )        (Val)
--                              @asIdFour               VarChar (    3 )        (Val)
--                              @adcMtaReg              Decimal ( 11,2 )        (Val)
--                              @adcMtReg               Decimal ( 11,2 )        (Val)
--                              @aiCodEtat              Integer                 (Val)
--                              @adtCreeLe              DateTime                (Val)
--                              @adtMajLe               DateTime                (Val)
--                              @asMajPar               VarChar (    4 )        (Val)
--                              @asLibErreur            VarChar (  250 )        (Val)
--                              @asAltTravailCree       Char    (    1 )        (Val)
--                              @asNom_WQU              VarChar (   71 )        (Val)
--                              @asMajPar_WQU           Varchar (    4 )        (Val)

--
-- Retourne             :       @@ERROR
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRACE_REGL_AUTO' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_I01_TRACE_REGL_AUTO
GO

CREATE PROCEDURE        sysadm.PS_I01_TRACE_REGL_AUTO
        @adcIdSin               Decimal (  10,0 ), -- [PI062]
        @aiIdSeq                Integer         ,
        @adcIdProd              Decimal (  7,0 ),
        @asIdFour               VarChar (    3 ),
        @adcMtaReg              Decimal ( 11,2 ),
        @adcMtReg               Decimal ( 11,2 ),
        @aiCodEtat              Integer         ,
        @adtCreeLe              DateTime        ,
        @adtMajLe               DateTime        ,
        @asMajPar               VarChar (    4 ),
        @asLibErreur            VarChar (  250 ),
        @asAltTravailCree       Char    (    1 ),
        @asNom_WQU              Varchar (   71 ),
        @asMajPar_WQU           Varchar (    4 )
AS

SET NOCOUNT ON

/*-----------------------------------------------------------------------*/
/* DCMP 050547 : A.Monello/ Le travail doit être forceé au init. de SDA  */
/*-----------------------------------------------------------------------*/
Set @asMajPar = 'SDA'
Set @asMajPar_WQU = 'SDA'

/*------------------------------------------------------------------*/
/* Variables pour le traitement.                                    */
/*------------------------------------------------------------------*/
DECLARE @iNbTravail             INTEGER         ,
        @sLibTrv                VARCHAR(250)    ,
        @sTxtMess1              VARCHAR(254)    ,
        @dcIdCorb               DECIMAL(3,0)    ,
        @dtDteRecu              DATETIME        ,
        @dtCourCli              DATETIME        ,
        @ErrorSauver            INTEGER         ,
        @sBaseSherpa            VARCHAR(25)     ,
        @iIdCli                 INTEGER         ,
        @sMessSherpa            VARCHAR(254)    ,
        @iIdContact             INTEGER         ,
        @iRet                   INTEGER         ,
        @iRetContactSherpa      INTEGER
/*------------------------------------------------------------------*/
/* On va d'abord vérifier s'il existe un travail dans la table      */
/* W_QUEUE.                                                         */
/*------------------------------------------------------------------*/
SELECT  @iNbTravail     = COUNT(*)
FROM    sysadm.w_queue  AS wqu
WHERE   wqu.id_sin      = CONVERT ( CHAR(10), @adcIdSin ) -- [PI062]
/*------------------------------------------------------------------*/
/* La procédure appelante souhaite créer un travail mais il en      */
/* existe dèjà un. On interdit la création d'un travail et on le    */
/* signale dans le message d'erreur.                                */
/*------------------------------------------------------------------*/
IF      @iNbTravail <> 0        AND @asAltTravailCree = 'O'
        BEGIN
                SET @sLibTrv            = 'Impossible de créer un travail, il en existe dèjà un pour le sinistre'
                SET @asLibErreur        = ISNULL ( @asLibErreur, '' ) + ' ' + @sLibTrv
                SET @asAltTravailCree  = 'N'
        END
/*------------------------------------------------------------------*/
/* On s'occupe de la création dans la table TRACE_REGL_AUTO.        */
/*------------------------------------------------------------------*/
INSERT INTO     sysadm.trace_regl_auto
                (
                sysadm.trace_regl_auto.id_sin,
                sysadm.trace_regl_auto.id_seq,
                sysadm.trace_regl_auto.id_prod,
                sysadm.trace_regl_auto.id_four,
                sysadm.trace_regl_auto.mt_a_reg,
                sysadm.trace_regl_auto.mt_reg,
                sysadm.trace_regl_auto.cod_etat,
                sysadm.trace_regl_auto.lib_erreur,
                sysadm.trace_regl_auto.alt_travail_cree,
                sysadm.trace_regl_auto.nb_envoi_mail,
                sysadm.trace_regl_auto.cree_le,
                sysadm.trace_regl_auto.maj_le,
                sysadm.trace_regl_auto.maj_par
)
VALUES
                (
                @adcIdSin,
                @aiIdSeq,
                @adcIdProd,
                @asIdFour,
                @adcMtaReg,
                @adcMtReg,
                @aiCodEtat,
                @asLibErreur,
                @asAltTravailCree,
                0,
                @adtCreeLe,
                @adtMajLe,
                @asMajPar
                )

SET @ErrorSauver = @@Error
IF      @ErrorSauver  <> 0 RETURN 500*@ErrorSauver
/*------------------------------------------------------------------*/
/* On s'occupe de la création dans la table W_QUEUE si besoin.      */
/*------------------------------------------------------------------*/
IF      @asAltTravailCree = 'O'
        BEGIN
/*------------------------------------------------------------------*/
/* On s'occupe de récupérer la corbeille pour le produit. On part   */
/* du principe que le produit existe dans la table.                 */
/*------------------------------------------------------------------*/
                SELECT  @dcIdCorb       = pro.id_corb
                FROM    sysadm.produit  AS pro
                WHERE   pro.id_prod     = @adcIdProd

                SET     @dtDteRecu      = Convert ( DateTime, Convert ( Varchar ( 10 ), @adtCreeLe, 103 ) )
                SET     @dtCourCli      = @dtDteRecu

                SET     @sTxtMess1 = 'Travail créé automatiquement par le système. Le dossier est à reprendre afin de régler ' + LTRIM ( RTRIM ( @asNom_WQU ) ) + ' de ' + CONVERT ( VARCHAR(5), @adcMtaReg ) + ' Euros [Frais d''envoi]'

                EXEC sysadm.PS_I01_W_QUEUE_WKF @adcIdSin, @adcIdProd, @dcIdCorb, @asNom_WQU, '', @adtCreeLe, @sTxtMess1, 'T', 'A', @dtDteRecu, 'C', @dtCourCli, @asMajPar, @asMajPar_WQU
                
                SET @ErrorSauver = @@Error
                IF      @ErrorSauver  <> 0 RETURN 500*@ErrorSauver
/*------------------------------------------------------------------*/                
/* Il faut aussi modifier le message sur W_SIN. En effet, c'est ce  */
/* message qui sera récupéré lors du retour de la fenêtre de        */
/* traitement vers la fenêtre d'accueil WOKFLOW                     */
/* (Voir code PowerBuilder).                                        */
/*------------------------------------------------------------------*/
                UPDATE  sysadm.w_sin
                SET     txt_mess        = txt_mess + '--'  + @sTxtMess1
                WHERE   id_sin          = @adcIdSin
                
/*------------------------------------------------------------------*/
/* On va maintenant insérer une ligne dans la table contact de      */
/* SHERPA.                                                          */
/*------------------------------------------------------------------*/
/* On récupére dans un premier temps le nom de la base SHERPA       */
/*------------------------------------------------------------------*/
                SET @sBaseSherpa = sysadm.FN_GET_BASE_GRC ()

                IF      @sBaseSherpa IS NULL OR LEN ( LTRIM ( RTRIM ( @sBaseSherpa ) ) ) = 0    RETURN -1
                
                IF      @@SERVERNAME = master.dbo.SPB_FN_ServerName ('PRO')
                        BEGIN
                                SELECT @iIdCli = sin.id_cli FROM SHERPA_PRO.sysadm.sinistre AS sin WHERE sin.id_sin = @adcIdSin AND sin.id_appli = 2
                                IF @@ROWCOUNT <> 1 RETURN -600
                        END
                        
                IF      @@SERVERNAME = master.dbo.SPB_FN_ServerName ('SIM')
                        BEGIN
                                SELECT @iIdCli = sin.id_cli FROM SHERPA_SIM.sysadm.sinistre AS sin WHERE sin.id_sin = @adcIdSin AND sin.id_appli = 2
                                IF @@ROWCOUNT <> 1 RETURN -610
                        END                                
/*------------------------------------------------------------------*/                     
/* Insertion dans la table CONTACT de SHERPA.                       */
/*------------------------------------------------------------------*/
                SET @sMessSherpa        = 'Contact créé automatiquement par le système. Gestion du règlement automatique pour les frais d envoi'
                SET @iIdContact         = 0
                
                IF      @@SERVERNAME = master.dbo.SPB_FN_ServerName ('PRO')
                   BEGIN
                        EXEC @iRetContactSherpa = SHERPA_PRO.sysadm.PS_I01_CONTACT @iIdCli, 2, 99, 'X', @adcIdSin, 2, @sMessSherpa, @asMajPar, @iIdContact OUTPUT
                        IF      @iRetContactSherpa <> 0 RETURN -620
                        IF      @iIdContact <= 0        RETURN -630
                   END                        
                        
                IF      @@SERVERNAME = master.dbo.SPB_FN_ServerName ('SIM')
                   BEGIN
                        EXEC @iRetContactSherpa = SHERPA_SIM.sysadm.PS_I01_CONTACT @iIdCli, 2, 99, 'X', @adcIdSin, 2, @sMessSherpa, @asMajPar, @iIdContact OUTPUT
                        IF      @iRetContactSherpa <> 0 RETURN -640
                        IF      @iIdContact <= 0        RETURN -650
                   END                        
                
        END

RETURN @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_FRAIS_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table FRAIS 
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- DGA Le 28/07/2004    :       DCMP 040206. Gestion des frais en automatique
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_FRAIS_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_FRAIS_VAL
GO

CREATE procedure sysadm.PS_I01_FRAIS_VAL
        @dcIdSin        Decimal (  10, 0 ),  -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

DECLARE @dcIdFrais      DECIMAL(7,0)    ,
        @iTotFraisAuto  INTEGER         ,
        @dcMtFrais      DECIMAL(11,2)

 INSERT INTO    sysadm.frais
        (       frais.id_sin,
                frais.id_i,
                frais.id_frais,
                frais.id_typ_frais,
                frais.lib_frais,
                frais.mt_frais,
                frais.id_reg,
                frais.cod_etat,
                frais.cree_le,
                frais.maj_le,
                frais.maj_par,
                frais.valide_le,
                frais.valide_par        )
 SELECT         w_frais.id_sin,
                w_frais.id_i,
                w_frais.id_frais,
                w_frais.id_typ_frais,
                w_frais.lib_frais,
                w_frais.mt_frais,
                0,
                w_frais.cod_etat,
                w_frais.cree_le,
                w_frais.maj_le,
                w_frais.maj_par,
                @dtValideLe,
                @sCodOper
 FROM           sysadm.w_frais
 WHERE          w_frais.id_sin          = @dcIdSin      AND
                w_frais.cod_etat        = 500

/*------------------------------------------------------------------*/
/* Attention. La gestion des frais doit se faire avant l'appel de la*/
/* procédure IM_CUR_REGLEMENT_VAL. En effet, cette procédure        */
/* positionne la zone COD_ETAT de 500 en 600 pour les frais         */
/* nouvellement saisis.                                             */
/*------------------------------------------------------------------*/
/* On va lire la table trace_regl_auto et vérifier s'il existe une  */
/* ligne pour le sinistre en cours avec COD_ETAT = 500 et           */
/* MT_A_REG > 0.                                                    */
/*------------------------------------------------------------------*/
SELECT  @iTotFraisAuto = COUNT(*)
FROM    sysadm.trace_regl_auto  AS      trc
WHERE   trc.id_sin      = @dcIdSin      AND
        trc.cod_etat    = 500           AND
        trc.mt_a_reg    > 0
/*------------------------------------------------------------------*/
/* Il ne doit y avoir qu'une ligne au maximum. Si ce n'est pas le   */
/* cas, on arrête en erreur.                                        */
/*------------------------------------------------------------------*/
IF      @iTotFraisAuto > 1 RETURN -1
IF      @iTotFraisAuto = 1
        BEGIN
/*------------------------------------------------------------------*/
/* On va maintenant vérifier s'il existe un FRAIS non validé dans la*/
/* table W_FRAIS.                                                   */
/*------------------------------------------------------------------*/
                SELECT  TOP 1 
                        @dcIdFrais = wfr.id_frais,
                        @dcMtFrais = wfr.mt_frais     
                FROM    sysadm.w_frais  AS      wfr
                WHERE   wfr.id_sin              = @dcIdSin      AND
                        wfr.id_typ_frais        = 1             AND
                        wfr.cod_etat            = 500
                ORDER BY
                        wfr.id_frais ASC

                IF      @@ROWCOUNT = 1
                        BEGIN
/*------------------------------------------------------------------*/
/* On va maintenant mettre à jour la table trace_regl_auto. On va   */
/* stocker la date de validation et le ID_FRAIS qui va servir de    */
/* support.                                                         */
/*------------------------------------------------------------------*/
                                UPDATE  sysadm.trace_regl_auto
                                SET     dte_validation_manuelle         = @dtValideLe,
                                        id_frais_validation           = @dcIdFrais,
                                        cod_etat        = 600,
                                        mt_reg          = @dcMtFrais
                                WHERE   id_sin          = @dcIdSin      AND
                                        cod_etat        = 500           AND
                                        mt_a_reg        > 0
                
                                IF      @@ERROR <> 0 OR @@ROWCOUNT <> 1 RETURN -1
                        END
        END                        

 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_INSERTION_FRAIS_AUTOMATIQUE
-- Auteur               :       Erick John Stark
-- Date                 :       21/05/2003 11:27:57
-- Libellé              :
-- Commentaires         :       Voir la DCMP 040206. Il s'agit d'insérer des frais en automatique.
-- Références           :
--
-- Arguments            :       @adcIdSin               Decimal (  7,0 )        (Val)
--                              @aiIdSeq                Integer                 (Val)
--                              @adcMtFrais             Decimal ( 11,2 )        (Val)
--                              @adtRcpFrn              DateTime                (Val)
--                              @asRetour               VarChar (  250 )        (Réf)
--
-- Retourne             :       Integer                 0 = La date de réception n'est pas renseignée ou
--                                                          Le règlement des frais a déjà été effectué. (DTE_RCP_FRN n'est pas NULL)
--                                                      1 = Insertion d'une ligne dans la table TRACE_REGL_AUTO ( et éventuellement d'un frais )
--                                                     -1 = Erreur SQL rencontrée quelque part.
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_INSERTION_FRAIS_AUTOMATIQUE' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_INSERTION_FRAIS_AUTOMATIQUE
GO

CREATE PROCEDURE        sysadm.PS_INSERTION_FRAIS_AUTOMATIQUE
        @adcIdSin               Decimal (  10,0 ), -- [PI062]
        @aiIdSeq                Integer         ,
        @adcMtFrais             Decimal ( 11,2 ),
        @adtRcpFrn              DateTime        ,
        @asRetour               VarChar (  250 )        OUTPUT
AS

/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications Paramêtre                                                                                                       */
/* @adcIdSin   = Référénce Sinistre à traiter                                                                                   */
/* @aiIdSeq    = N° Séquentiel de la commande                                                                                   */
/* @adcMtFrais = Montant des frais à rembourser                                                                                 */
/* @adtRcpFrn  = Date de réception du mobile chez le fournisseur                                                                */
/* @asRetour   = Valeur de retour suite au traitement                                                                           */
/*------------------------------------------------------------------------------------------------------------------------------*/

SET NOCOUNT ON
/*------------------------------------------------------------------*/
/* Variables pour le traitement.                                    */
/*------------------------------------------------------------------*/
DECLARE @dtDteRcpFrn            DATETIME        ,
        @iRet                   INTEGER         ,
        @sMajPar                CHAR(4)         ,
        @dtCreeLe               DATETIME        ,
        @dtMajLe                DATETIME        ,
        @dcIdProd               DECIMAL(7,0)    ,
        @iCptReg                INTEGER         ,
        @sIdFour                VARCHAR(3)      ,
        @dcMtaReg               DECIMAL(11,2)   ,
        @dcMtReg                DECIMAL(11,2)   ,
        @iCodEtat               INTEGER         ,
        @iIdEts                 INTEGER         ,
        @sIdAdh                 CHAR(19)        ,
        @iIdsDos                INTEGER         ,
        @iNbGar                 INTEGER         ,
        @sCodModeReg            CHAR(2)         ,
        @sRibBq                 CHAR(5)         ,
        @sRibGui                CHAR(5)         ,
        @sRibCpt                CHAR(11)        ,
        @sRibCle                CHAR(2)         ,
        @dcIdI                  DECIMAL(7,0)    ,
        @iCptFrais              INTEGER         ,
        @sAltTravailCree        CHAR(1)         ,
        @sNom                   VARCHAR(71)     ,
        @sMajPar_WQU            VARCHAR(4)
/*------------------------------------------------------------------*/
/* On commence par armer un certain nombre de constantes.           */
/*------------------------------------------------------------------*/
SET @sMajPar            = 'OPCO'
SET @dtCreeLe           = GETDATE ()
SET @dtMajLe            = @dtCreeLe
/*------------------------------------------------------------------*/
/* J'arme des valeurs pour ID_PROD et ID_FOUR avec des valeurs par  */
/* défaut. Ces zones sont obligatoires dans la table trace_regl_auto*/
/* Elles vont être armées par les valeurs nécessaires dans les      */
/* lignes suivantes.                                                */
/*------------------------------------------------------------------*/
SET @dcIdProd           = -1
SET @sIdFour            = 'XXX'
SET @sMajPar_WQU        = 'SQLS'
/*------------------------------------------------------------------*/
/* Le portable n'est toujours pas réceptionné chez le prestataire.  */
/*------------------------------------------------------------------*/
IF      @adtRcpFrn IS NULL 
   BEGIN
                SET @asRetour = 'Portable non réceptionné chez le prestataire'
                RETURN 0
        END
/*------------------------------------------------------------------*/
/* La première chose à effectuer est de récupérer la zone           */
/* DTE_RCP_FRN de la table commande.                                */
/*------------------------------------------------------------------*/
SELECT  @dtDteRcpFrn    = com.dte_rcp_frn,
        @sIdFour        = com.id_four
FROM    sysadm.commande         AS com
WHERE   com.id_sin      = @adcIdSin             AND
        com.id_seq      = @aiIdSeq
        
IF      @@RowCount = 0
        BEGIN
                SET @asRetour = 'La commande N° ' + CONVERT ( VARCHAR(2), @aiIdSeq ) + ' n''existe pas pour le sinistre ' +  CONVERT ( VARCHAR(8), @adcIdSin ) + '.'
                SET @dcMtaReg = @adcMtFrais
                SET @dcMtReg  = 0
                SET @iCodEtat = 500
                SET @sAltTravailCree = 'N'
                
                EXEC @iRet = sysadm.PS_I01_TRACE_REGL_AUTO @adcIdSin, @aiIdSeq, @dcIdProd, @sIdFour, @dcMtaReg, @dcMtReg, @iCodEtat, @dtCreeLe, @dtMajLe, @sMajPar, @asRetour, @sAltTravailCree, @sNom, @sMajPar_WQU
                IF      @iRet <> 0
                        BEGIN
                                SET @asRetour = 'Erreur 100 en insertion dans la procédure [PS_I01_TRACE_REGL_AUTO] ' + '(' + Convert ( VarChar ( 5 ), @iRet ) + ')' 
                                RETURN -100
                        END
                ELSE
                        RETURN 1
        END
/*------------------------------------------------------------------*/
/* On vérifie si la date de réception fournisseur est déjà          */
/* renseignée. Si elle est déjà positionnée, cela signifie que les  */
/* frais d"envoi sont déjà pris en compte.                          */
/*------------------------------------------------------------------*/
IF      @dtDteRcpFrn IS NOT NULL 
        BEGIN
/*------------------------------------------------------------------*/
/* On ne vérifie pas s'il existe bien un enregistrement dans la     */
/* table trace_regl_auto.                                           */
/*------------------------------------------------------------------*/
                SET @asRetour = 'Frais déjà remboursés'
                RETURN 0
        END

IF      @dtDteRcpFrn IS NULL    AND @adtRcpFrn IS NOT NULL
        BEGIN
/*------------------------------------------------------------------*/
/* On va armer la valeur pour la zone ID_PROD.                      */
/*------------------------------------------------------------------*/
                SELECT  @dcIdProd       = sin.id_prod,
                        @iCptReg        = sin.cpt_reg,
                        @sMajPar_WQU    = sin.maj_par        
                FROM    sysadm.sinistre         AS sin
                WHERE   sin.id_sin      = @adcIdSin

                IF      @@RowCount = 0
                        BEGIN
                                SET @asRetour = 'Le sinistre ' + CONVERT ( VARCHAR(8), @adcIdSin ) + ' n''existe pas dans la table SINISTRE.'
                                SET @dcMtaReg = @adcMtFrais
                                SET @dcMtReg  = 0
                                SET @iCodEtat = 500
                                SET @sAltTravailCree = 'N'

                                EXEC @iRet = sysadm.PS_I01_TRACE_REGL_AUTO @adcIdSin, @aiIdSeq, @dcIdProd, @sIdFour, @dcMtaReg, @dcMtReg, @iCodEtat, @dtCreeLe, @dtMajLe, @sMajPar, @asRetour, @sAltTravailCree, @sNom, @sMajPar_WQU
                                IF      @iRet <> 0
                                        BEGIN
                                                SET @asRetour = 'Erreur 110 en insertion dans la procédure [PS_I01_TRACE_REGL_AUTO] ' + '(' + Convert ( VarChar ( 5 ), @iRet ) + ')' 
                                                RETURN -110
                                        END
                                ELSE
                                        RETURN 1
                        END
/*------------------------------------------------------------------*/
/* On vérifie plusieus choses pour l'interlocuteur Assuré.          */
/*------------------------------------------------------------------*/
                SELECT  @sCodModeReg    = int.cod_mode_reg,
                        @sRibBq         = int.rib_bq,
                        @sRibGui        = int.rib_gui,
                        @sRibCpt        = int.rib_cpt,
                        @sRibCle        = int.rib_cle,
                        @dcIdI          = int.id_i,
                        @sNom           = int.nom
                FROM    sysadm.inter    AS int
                WHERE   int.id_sin      = @adcIdSin             AND
                        int.cod_inter   = 'A'

                IF      @@Rowcount = 0
                        BEGIN
                                SET @asRetour = 'L''interlocuteur de type ASSURE n''existe pas.'
                                SET @dcMtaReg = @adcMtFrais
                                SET @dcMtReg  = 0
                                SET @iCodEtat = 500
                                SET @sAltTravailCree = 'N'

                                EXEC @iRet = sysadm.PS_I01_TRACE_REGL_AUTO @adcIdSin, @aiIdSeq, @dcIdProd, @sIdFour, @dcMtaReg, @dcMtReg, @iCodEtat, @dtCreeLe, @dtMajLe, @sMajPar, @asRetour, @sAltTravailCree, @sNom, @sMajPar_WQU
                                IF      @iRet <> 0
                                        BEGIN
                                                SET @asRetour = 'Erreur 120 en insertion dans la procédure [PS_I01_TRACE_REGL_AUTO] ' + '(' + Convert ( VarChar ( 5 ), @iRet ) + ')' 
                                                RETURN -120
                                        END
                                ELSE
                                        RETURN 1
                        END
/*------------------------------------------------------------------*/
/* Le mode de règlement doit être VA.                               */
/*------------------------------------------------------------------*/
                IF      @sCodModeReg <> 'VA' OR @sCodModeReg IS NULL
                        BEGIN
                                SET @asRetour = 'Le mode de règlement pour l''interlocuteur ASSURE n''est pas [V]irement [A]utomatique.'
                                SET @dcMtaReg = @adcMtFrais
                                SET @dcMtReg  = 0
                                SET @iCodEtat = 500
                                SET @sAltTravailCree = 'O'

                                EXEC @iRet = sysadm.PS_I01_TRACE_REGL_AUTO @adcIdSin, @aiIdSeq, @dcIdProd, @sIdFour, @dcMtaReg, @dcMtReg, @iCodEtat, @dtCreeLe, @dtMajLe, @sMajPar, @asRetour, @sAltTravailCree, @sNom, @sMajPar_WQU
                                IF      @iRet <> 0
                                        BEGIN
                                                SET @asRetour = 'Erreur 130 en insertion dans la procédure [PS_I01_TRACE_REGL_AUTO] ' + '(' + Convert ( VarChar ( 5 ), @iRet ) + ')' 
                                                RETURN -130
                                        END
                                ELSE
                                        RETURN 1
                        END
/*------------------------------------------------------------------*/
/* Le RIB doit être présent et complet.                             */
/*------------------------------------------------------------------*/
                IF      @sRibBq IS NULL OR @sRibGui IS NULL OR @sRibCpt IS NULL OR @sRibCle IS NULL OR
                        LEN ( LTRIM ( RTRIM ( @sRibBq  ) ) ) = 0 OR LEN ( LTRIM ( RTRIM ( @sRibGui ) ) ) = 0 OR LEN ( LTRIM ( RTRIM ( @sRibCpt ) ) ) = 0 OR LEN ( LTRIM ( RTRIM ( @sRibCle ) ) ) = 0 
                        BEGIN
                                SET @asRetour = 'Le RIB de l''assuré n''est pas correctement renseigné.'
                                SET @dcMtaReg = @adcMtFrais
                                SET @dcMtReg  = 0
                                SET @iCodEtat = 500
                                SET @sAltTravailCree = 'O'

                                EXEC @iRet = sysadm.PS_I01_TRACE_REGL_AUTO @adcIdSin, @aiIdSeq, @dcIdProd, @sIdFour, @dcMtaReg, @dcMtReg, @iCodEtat, @dtCreeLe, @dtMajLe, @sMajPar, @asRetour, @sAltTravailCree, @sNom, @sMajPar_WQU
                                IF      @iRet <> 0
                                        BEGIN
                                                SET @asRetour = 'Erreur 140 en insertion dans la procédure [PS_I01_TRACE_REGL_AUTO] ' + '(' + Convert ( VarChar ( 5 ), @iRet ) + ')' 
                                                RETURN -140
                                        END
                                ELSE
                                        RETURN 1
                        END
/*------------------------------------------------------------------*/
/* On vérifie que le RIB soit correct.                              */
/*------------------------------------------------------------------*/
                IF      sysadm.SPB_FN_RIB ( @sRibBq, @sRibGui, @sRibCpt, @sRibCle ) <> 0
                        BEGIN
                                SET @asRetour = 'Le calcul de clé RIB est incorrect.'
                                SET @dcMtaReg = @adcMtFrais
                                SET @dcMtReg  = 0
                                SET @iCodEtat = 500
                                SET @sAltTravailCree = 'O'

                                EXEC @iRet = sysadm.PS_I01_TRACE_REGL_AUTO @adcIdSin, @aiIdSeq, @dcIdProd, @sIdFour, @dcMtaReg, @dcMtReg, @iCodEtat, @dtCreeLe, @dtMajLe, @sMajPar, @asRetour, @sAltTravailCree, @sNom, @sMajPar_WQU
                                IF      @iRet <> 0
                                        BEGIN
                                                SET @asRetour = 'Erreur 150 en insertion dans la procédure [PS_I01_TRACE_REGL_AUTO] ' + '(' + Convert ( VarChar ( 5 ), @iRet ) + ')' 
                                                RETURN -150
                                        END
                                ELSE
                                        RETURN 1
                        END
/*------------------------------------------------------------------*/
/* On vérifie que le sinistre existe sur W_SIN.                     */
/*------------------------------------------------------------------*/
                SELECT  @iIdEts         = wsi.id_ets,
                        @sIdAdh         = wsi.id_adh,
                        @iIdsDos        = wsi.id_sdos
                FROM    sysadm.w_sin    AS wsi
                WHERE   wsi.id_sin      = @adcIdSin

                IF      @@RowCount = 0
                        BEGIN
                                SET @asRetour = 'Le sinistre ' + CONVERT ( VARCHAR(8), @adcIdSin ) + ' n''existe pas dans la table W_SIN.'
                                SET @dcMtaReg = @adcMtFrais
                                SET @dcMtReg  = 0
                                SET @iCodEtat = 500
                                SET @sAltTravailCree = 'N'

                                EXEC @iRet = sysadm.PS_I01_TRACE_REGL_AUTO @adcIdSin, @aiIdSeq, @dcIdProd, @sIdFour, @dcMtaReg, @dcMtReg, @iCodEtat, @dtCreeLe, @dtMajLe, @sMajPar, @asRetour, @sAltTravailCree, @sNom, @sMajPar_WQU
                                IF      @iRet <> 0
                                        BEGIN
                                                SET @asRetour = 'Erreur 160 en insertion dans la procédure [PS_I01_TRACE_REGL_AUTO] ' + '(' + Convert ( VarChar ( 5 ), @iRet ) + ')' 
                                                RETURN -160
                    END
                                ELSE
                                        RETURN 1
                        END
/*------------------------------------------------------------------*/
/* On vérifie que ID_ETS, ID_ADH et ID_SDOS sont correctement       */
/* renseignés.                                                      */
/*------------------------------------------------------------------*/
                IF      @iIdEts IS NULL OR @iIdEts = -1 OR @sIdAdh IS NULL OR LEN ( LTRIM ( RTRIM ( @sIdAdh ) ) ) = 0 OR @iIdsDos IS NULL OR @iIdsDos = 0
                        BEGIN
                                SET @asRetour = 'L''une des zones suivantes (ID_ETS, ID_ADH, ID_SDOS) n''est pas renseignée.'
                                SET @dcMtaReg = @adcMtFrais
                                SET @dcMtReg  = 0
                                SET @iCodEtat = 500
                                SET @sAltTravailCree = 'O'

                                EXEC @iRet = sysadm.PS_I01_TRACE_REGL_AUTO @adcIdSin, @aiIdSeq, @dcIdProd, @sIdFour, @dcMtaReg, @dcMtReg, @iCodEtat, @dtCreeLe, @dtMajLe, @sMajPar, @asRetour, @sAltTravailCree, @sNom, @sMajPar_WQU
                                IF      @iRet <> 0
                                        BEGIN
                                                SET @asRetour = 'Erreur 170 en insertion dans la procédure [PS_I01_TRACE_REGL_AUTO] ' + '(' + Convert ( VarChar ( 5 ), @iRet ) + ')' 
                                                RETURN -170
                                        END
                                ELSE
                                        RETURN 1
                        END
/*------------------------------------------------------------------*/
/* On vérifie qu'il existe au moins une garantie pour le dossier.   */
/*------------------------------------------------------------------*/
                SELECT  @iNbGar = COUNT(*)
                FROM    sysadm.gar_sin          AS gar
                WHERE   gar.id_sin      = @adcIdSin
                
                IF      @iNbGar = 0
                        BEGIN
                                SET @asRetour = 'Il n''existe pas de garantie saisie dans la table GAR_SIN.'
                                SET @dcMtaReg = @adcMtFrais
                                SET @dcMtReg  = 0
                                SET @iCodEtat = 500
                                SET @sAltTravailCree = 'O'

                                EXEC @iRet = sysadm.PS_I01_TRACE_REGL_AUTO @adcIdSin, @aiIdSeq, @dcIdProd, @sIdFour, @dcMtaReg, @dcMtReg, @iCodEtat, @dtCreeLe, @dtMajLe, @sMajPar, @asRetour, @sAltTravailCree, @sNom, @sMajPar_WQU
                                IF      @iRet <> 0
                                        BEGIN
                                                SET @asRetour = 'Erreur 180 en insertion dans la procédure [PS_I01_TRACE_REGL_AUTO] ' + '(' + Convert ( VarChar ( 5 ), @iRet ) + ')' 
                                                RETURN -180
                                        END
                                ELSE
                                        RETURN 1
                        END
/*------------------------------------------------------------------*/                        
/* On arme les compteurs nécessaires.                               */
/* CPT_REG récupéré de la table SINISTRE.                           */
/* ID_FRAIS récupéré de la table W_FRAIS.                           */
/*------------------------------------------------------------------*/
                SET @iCptReg = @iCptReg + 1
                
                SELECT  @iCptFrais      = MAX ( wfr.id_frais )
                FROM    sysadm.w_frais          AS wfr
                WHERE   wfr.id_sin      = @adcIdSin             AND
                        wfr.id_i        = @dcIdI
                        
                SET @iCptFrais = @iCptFrais + 1
         SET @iCptFrais = ISNULL ( @iCptFrais, 0 )
/*------------------------------------------------------------------*/
/* Insertion dans la table W_FRAIS.                                 */
/*------------------------------------------------------------------*/
                EXEC sysadm.DW_I01_W_FRAIS @adcIdSin, @dcIdI, @iCptFrais, 1, 'Frais d''envoi boîte', 'N', @adcMtFrais, 600, @dtCreeLe, @dtMajLe, @sMajPar
                IF      @@ERROR <> 0
                        BEGIN
                                SET @asRetour = 'Erreur 190 en insertion sur la table W_FRAIS.' + '(' + Convert ( VarChar ( 5 ), @@ERROR ) + ')' 
                                RETURN -190
                        END
/*------------------------------------------------------------------*/
/* Insertion dans la table FRAIS.                                   */
/*------------------------------------------------------------------*/
                INSERT INTO sysadm.frais ( frais.id_sin, frais.id_i, frais.id_frais, frais.id_typ_frais, frais.lib_frais, frais.mt_frais, frais.id_reg, frais.cod_etat, frais.valide_le, frais.valide_par, frais.cree_le, frais.maj_le, frais.maj_par )
                VALUES ( @adcIdSin, @dcIdI, @iCptFrais, 1, 'Frais d''envoi boîte', @adcMtFrais, @iCptReg, 600, @dtCreeLe, @sMajPar, @dtCreeLe, @dtMajLe, @sMajPar )
                IF      @@ERROR <> 0
                        BEGIN
                                SET @asRetour = 'Erreur 200 en insertion sur la table W_FRAIS.' + '(' + Convert ( VarChar ( 5 ), @@ERROR ) + ')' 
                                RETURN -200
                        END
/*------------------------------------------------------------------*/
/* Modification de la table W_SIN                                   */
/*------------------------------------------------------------------*/
                UPDATE  sysadm.w_sin
                SET     mt_reg          = mt_reg + @adcMtFrais,
                        cpt_valide      = cpt_valide + 1,
                        maj_le          = @dtMajLe,
                        maj_par         = @sMajPar
                WHERE   id_sin          = @adcIdSin
                
                IF      @@ERROR <> 0 OR @@ROWCOUNT <> 1
                        BEGIN
                                SET @asRetour = 'Erreur 210 en insertion sur la table W_SIN.' + '(' + Convert ( VarChar ( 5 ), @@ERROR ) + ')' 
                                RETURN -210
                        END
/*------------------------------------------------------------------*/
/* Modification de la table SINISTRE                                */
/*------------------------------------------------------------------*/
                UPDATE  sysadm.sinistre
                SET     mt_reg          = mt_reg + @adcMtFrais,
                        cpt_reg         = @iCptReg,
                        maj_le          = @dtMajLe,
                        maj_par         = @sMajPar,
                        valide_le       = @dtMajLe,
                        valide_par      = @sMajPar
                WHERE   id_sin          = @adcIdSin
                
                IF      @@ERROR <> 0 OR @@ROWCOUNT <> 1
                        BEGIN
                                SET @asRetour = 'Erreur 220 en insertion sur la table SINISTRE.' + '(' + Convert ( VarChar ( 5 ), @@ERROR ) + ')' 
                                RETURN -220
                        END
/*------------------------------------------------------------------*/
/* Modification de la table W_INTER.                                */
/*------------------------------------------------------------------*/
                UPDATE  sysadm.w_inter
                SET     mt_reg          = mt_reg + @adcMtFrais,
                        cpt_valide      = cpt_valide + 1,
                        maj_le          = @dtMajLe,
                        maj_par         = @sMajPar
                WHERE   id_sin          = @adcIdSin   AND
                        id_i            = @dcIdI
                
                IF      @@ERROR <> 0 OR @@ROWCOUNT <> 1
                        BEGIN
                                SET @asRetour = 'Erreur 230 en insertion sur la table W_INTER.' + '(' + Convert ( VarChar ( 5 ), @@ERROR ) + ')' 
                                RETURN -230
                        END
/*------------------------------------------------------------------*/
/* Modification de la table INTER.                                  */
/*------------------------------------------------------------------*/
                UPDATE  sysadm.inter
                SET     mt_reg          = mt_reg + @adcMtFrais,
                        maj_le          = @dtMajLe,
                        maj_par         = @sMajPar,
                        valide_le       = @dtMajLe,
                        valide_par      = @sMajPar
                WHERE   id_sin          = @adcIdSin     AND
                        id_i            = @dcIdI
                
                IF      @@ERROR <> 0 OR @@ROWCOUNT <> 1
                        BEGIN
                                SET @asRetour = 'Erreur 240 en insertion sur la table INTER.' + '(' + Convert ( VarChar ( 5 ), @@ERROR ) + ')' 
                                RETURN -240
                        END
/*------------------------------------------------------------------*/
/* Insertion dans la table REGLEMENT.                               */
/*------------------------------------------------------------------*/
                INSERT INTO sysadm.reglement 
                        ( reglement.id_sin, reglement.id_reg, reglement.mt_tot_reg, reglement.lib_reg, reglement.dte_reg, reglement.rib_bq, reglement.rib_gui, reglement.rib_cpt, reglement.rib_cle, 
                          reglement.cod_inter, reglement.cod_mode_reg, reglement.cod_mot_reg, reglement.id_i, reglement.cree_le, reglement.maj_le, reglement.maj_par, reglement.valide_le, reglement.valide_par, reglement.num_let_cheque )
                VALUES  ( @adcIdSin, @iCptReg, @adcMtFrais, 'Règlement Frais boîte', Convert ( DateTime, Convert ( Varchar ( 10 ), @dtCreeLe, 103 ) ), @sRibBq, @sRibGui, @sRibCpt, @sRibCle, 'A', 'VA', 'RN', @dcIdI, @dtCreeLe, @dtMajLe, @sMajPar, @dtCreeL
e, @sMajPar, NULL )
                
                IF      @@ERROR <> 0 OR @@ROWCOUNT <> 1
                        BEGIN
                                SET @asRetour = 'Erreur 250 en insertion sur la table REGLEMENT.' + '(' + Convert ( VarChar ( 5 ), @@ERROR ) + ')' 
                                RETURN -250
                        END
/*------------------------------------------------------------------*/
/* Insertion dans la table REG_GTI.                                 */
/*------------------------------------------------------------------*/
                INSERT INTO sysadm.reg_gti 
                        ( reg_gti.id_sin, reg_gti.id_reg, reg_gti.id_gti, reg_gti.id_rgpt, reg_gti.id_i, reg_gti.mt_reg, reg_gti.mt_rgpt, reg_gti.cree_le, reg_gti.maj_le, reg_gti.maj_par )
                VALUES  ( @adcIdSin, @iCptReg, -1, 1, @dcIdI, @adcMtFrais, @adcMtFrais, @dtCreeLe, @dtMajLe, @sMajPar )

                IF      @@ERROR <> 0 OR @@ROWCOUNT <> 1
                        BEGIN
                                SET @asRetour = 'Erreur 260 en insertion sur la table REG_GTI.' + '(' + Convert ( VarChar ( 5 ), @@ERROR ) + ')' 
                                RETURN -260
                        END
/*------------------------------------------------------------------*/
/* Insertion dans la table W_A_VIRER.                               */
/*------------------------------------------------------------------*/
                INSERT INTO sysadm.w_a_virer
                        ( w_a_virer.id_sin, w_a_virer.id_i, w_a_virer.id_reg, w_a_virer.cod_inter, w_a_virer.id_prod, w_a_virer.id_ets, w_a_virer.id_adh, w_a_virer.id_sdos, 
                          w_a_virer.rib_bq_dest, w_a_virer.rib_gui_dest, w_a_virer.rib_cpt_dest, w_a_virer.rib_cle_dest, w_a_virer.mt_vir, w_a_virer.cod_mode_reg, w_a_virer.cod_pos, 
                          w_a_virer.cree_le, w_a_virer.maj_le, w_a_virer.maj_par )
                VALUES  ( @adcIdSin, @dcIdI, @iCptReg, 'A', @dcIdProd, @iIdEts, @sIdAdh, @iIdsDos, 
                          @sRibBq, @sRibGui, @sRibCpt, @sRibCle, @adcMtFrais, 'VA', '0', 
                          @dtCreeLe, @dtMajLe, @sMajPar )

                IF      @@ERROR <> 0 OR @@ROWCOUNT <> 1
                        BEGIN
                                SET @asRetour = 'Erreur 270 en insertion sur la table W_A_VIRER.' + '(' + Convert ( VarChar ( 5 ), @@ERROR ) + ')' 
                                RETURN -270
                        END
/*------------------------------------------------------------------*/
/* Insertion dans la table TRACE_REGL_AUTO.                         */
/*------------------------------------------------------------------*/
                SET @asRetour = 'Règlement automatique pour les frais d''envoi.'
                SET @dcMtaReg = 0
                SET @dcMtReg  = @adcMtFrais
                SET @iCodEtat = 600
                SET @sAltTravailCree = 'N'

                EXEC @iRet = sysadm.PS_I01_TRACE_REGL_AUTO @adcIdSin, @aiIdSeq, @dcIdProd, @sIdFour, @dcMtaReg, @dcMtReg, @iCodEtat, @dtCreeLe, @dtMajLe, @sMajPar, @asRetour, @sAltTravailCree, @sNom, @sMajPar_WQU
                IF      @iRet <> 0
                        BEGIN
                                SET @asRetour = 'Erreur 280 en insertion dans la procédure [PS_I01_TRACE_REGL_AUTO]' + '(' + Convert ( VarChar ( 5 ), @iRet ) + ')' 
                                RETURN -290
                        END
                ELSE
                        RETURN 1
        END

RETURN 0

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_ENVOI_MAIL_SUITE_INSERTION_FRAIS
-- Auteur               :       Erick John Stark
-- Date                 :       21/05/2003 11:27:57
-- Libellé              :
-- Commentaires         :       Voir la DCMP 040206. Il s'agit d'envoyer un mail avec des fichiers joints.
-- Références           :
--
-- Arguments            :       @asNomFichier           Varchar (   50 )        (Val)
--                              @asDateEtHrTrt          Varchar (   50 )        (Val)
--                              @asIdFour               Varchar (    3 )        (Val)
--                              @asRetour               VarChar (  250 )        (Réf)
--
-- Retourne             :       Integer                 
--
-------------------------------------------------------------------
-- #1 Le 30/11/2004 DGA : Modification de la procédure SPB_PS_MAIL. Paramêtre @asRetourErr
-- #2	JCA changement repertoire cible (norme UNC)
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_ENVOI_MAIL_SUITE_INSERTION_FRAIS' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_ENVOI_MAIL_SUITE_INSERTION_FRAIS
GO

CREATE PROC sysadm.PS_ENVOI_MAIL_SUITE_INSERTION_FRAIS
        @asNomFichier           VarChar (   50 ),
        @asDateEtHrTrt          Varchar (   50 ),
        @asIdFour               Varchar (    3 ),
        @asRetour               VarChar (  250 )        OUTPUT
AS

/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications Paramêtre                                                                                                       */
/* @asNomFichier        = Nom du fichier de commande en cours de traitement.                                                    */
/* @asDateEtHrTrt       = Date et Heure de traitement du fichier.(Présence dans l'objet du MAIL)                                */
/* @asIdFour            = Identifiant du fournisseur à traiter.                                                                 */
/* @asRetour            = Valeur de retour suite au traitement                                                                  */
/*------------------------------------------------------------------------------------------------------------------------------*/
SET NOCOUNT ON
/*------------------------------------------------------------------*/
/* Variables pour le traitement.                                    */
/*------------------------------------------------------------------*/
DECLARE @siSpId                 SMALLINT        ,
        @dtTrt                  DATETIME        ,
        @sRepExport             VARCHAR(250)    ,
        @sFicRegle              VARCHAR(250)    ,
        @sSelectRegle           VARCHAR(2500)   ,
        @sFicEnCours            VARCHAR(250)    ,
        @sSelectEnCours         VARCHAR(2500)   ,
        @sNomServeur            VARCHAR(25)     ,
        @sdtTrt                 VARCHAR(25)     ,
        @sBase                  VARCHAR(25)     ,
        @ErrorRegle             INTEGER         ,
        @ErrorEnCours           INTEGER         ,
        @ErrorFinal             INTEGER         ,
        @iNbrRegle              INTEGER         ,
        @iNbrEnCours            INTEGER         ,
        @sCmd                   VARCHAR(4000)   ,
        @sLibFournisseur        VARCHAR(35)     ,
        
        @sObjetRegle            VARCHAR(255)    ,
        @sObjetEnCours          VARCHAR(255)    ,
        @sTextRegle             VARCHAR(8000)   ,
        @sTextEnCours           VARCHAR(8000)   ,
        @sTo                    VARCHAR(2048)   ,
        @sCc                    VARCHAR(2048)   ,
        @iTransactionOuv        INTEGER         ,
        @iRet                   INTEGER         ,
        @sRetourErrMail         VARCHAR(255)

/*------------------------------------------------------------------*/
/* La première chose à faire est de récupérer l'id du process en    */
/* cours, ainsi que la date de traitement. Ces informations vont    */
/* servir de constantes pour toute la durée du traitement.          */
/*------------------------------------------------------------------*/
IF      @asIdFour       IS NULL OR LEN ( LTRIM ( RTRIM ( @asIdFour      ) ) ) = 0          OR
        @asNomFichier   IS NULL OR LEN ( LTRIM ( RTRIM ( @asNomFichier  ) ) ) = 0          OR
        @asDateEtHrTrt  IS NULL OR LEN ( LTRIM ( RTRIM ( @asDateEtHrTrt ) ) ) = 0
        BEGIN
                SET @asRetour = 'L''un des paramètres est mal renseigné.'
                RETURN -1
        END
/*------------------------------------------------------------------*/
/* On récupére le libellé du fournisseur pour le positionner dans   */
/* l'objet du message.(Et verifier son existence)                   */
/*------------------------------------------------------------------*/
SELECT  @sLibFournisseur = RTRIM ( c1.lib_code )
FROM    sysadm.code_car         AS c1
WHERE   c1.id_code      = @asIdFour          AND
        c1.id_typ_code  = '-FR'
IF      @@ROWCOUNT = 0  OR LEN ( RTRIM ( LTRIM ( @sLibFournisseur  ) ) ) = 0
        BEGIN
                SET @asRetour = 'Le fournisseur ' + @asIdFour + ' n''existe pas dans la table. Le traitement est impossible.'
                RETURN -1
        END

SET @siSpId             = @@SPID
SET @dtTrt              = GetDate()
SET @sRepExport         = master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_Frais_Envoi_' + @asIdFour
SET @sNomServeur        = @@SERVERNAME
/*------------------------------------------------------------------*/
/* Petit problème si cette procédure est utilisée avec PowerBuilder.*/
/* PB génére automatiquement un BEGIN TRAN avant toute action. Il   */
/* faut néammoins que cette procédure puisse fonctionner avec ISQLW.*/
/* Je m'occupe donc d'armer une variable qui contient le nombre de  */
/* transactions en cours. Si cette valeur est positive, on ROLLBACK */
/* la dernière transaction.                                         */
/*------------------------------------------------------------------*/
SET     @iTransactionOuv = @@TRANCOUNT
IF      @iTransactionOuv > 0 ROLLBACK TRAN
/*------------------------------------------------------------------*/
/* On va vérifier si le répertoire de traitement existe. Si ce      */
/* n'est pas le cas, on arrête le traitement.                       */
/*------------------------------------------------------------------*/
IF      ( SELECT object_id ( 'tempdb.dbo.#TblFileExistsExportFrais' ) ) > 0
        BEGIN
                EXEC ('Drop table #TblFileExistsExportFrais' )
        END
/*------------------------------------------------------------------*/
/* On va créer une table temporaire pour fonctionner avec la        */
/* procédure stockée étendue xp_fileexist.                          */
/*------------------------------------------------------------------*/
CREATE TABLE #TblFileExistsExportFrais
        (
        FileExists              TINYINT         NULL    ,
        FileIsDirectory         TINYINT         NULL    ,
        ParentDirectoryExists   TINYINT         NULL
        )

INSERT INTO #TblFileExistsExportFrais
EXEC master.dbo.xp_fileexist @sRepExport

IF      ( SELECT FileIsDirectory FROM #TblFileExistsExportFrais ) <> 1
        BEGIN
                SET @asRetour = 'Le répertoire ' + @sRepExport + ' n''existe pas. Le traitement est impossible.' 
                RETURN -1
        END
/*------------------------------------------------------------------*/
/* On arme une variable au format JJMMAAAA_HHMISSMS.                */
/*------------------------------------------------------------------*/
SET @sdtTrt             = REPLICATE ( '0', 2- LEN ( LTRIM ( RTRIM ( STR ( DATEPART ( dd, @dtTrt ) ) ) ) )  )  + 
                          LTRIM ( RTRIM ( STR ( DATEPART ( dd, @dtTrt ) ) ) )                                 +
                          REPLICATE ( '0', 2- LEN ( LTRIM ( RTRIM ( STR ( DATEPART ( mm, @dtTrt ) ) ) ) )  )  + 
                          LTRIM ( RTRIM ( STR ( DATEPART ( mm, @dtTrt ) ) ) )                                 +                          
                          LTRIM ( RTRIM ( STR ( DATEPART ( yyyy, @dtTrt ) ) ) )                               + '_' +
                          REPLICATE ( '0', 2- LEN ( LTRIM ( RTRIM ( STR ( DATEPART ( hh, @dtTrt ) ) ) ) )  )  + 
                          LTRIM ( RTRIM ( STR ( DATEPART ( hh, @dtTrt ) ) ) )                                 +
                          REPLICATE ( '0', 2- LEN ( LTRIM ( RTRIM ( STR ( DATEPART ( mi, @dtTrt ) ) ) ) )  )  + 
                          LTRIM ( RTRIM ( STR ( DATEPART ( mi, @dtTrt ) ) ) )                                 +
                          REPLICATE ( '0', 2- LEN ( LTRIM ( RTRIM ( STR ( DATEPART ( ss, @dtTrt ) ) ) ) )  )  + 
                          LTRIM ( RTRIM ( STR ( DATEPART ( ss, @dtTrt ) ) ) )        +
                          REPLICATE ( '0', 3- LEN ( LTRIM ( RTRIM ( STR ( DATEPART ( ms, @dtTrt ) ) ) ) )  )  + 

                          LTRIM ( RTRIM ( STR ( DATEPART ( ms, @dtTrt ) ) ) )
/*------------------------------------------------------------------*/
/* On arme les noms des fichiers qui vont être générés.             */
/*------------------------------------------------------------------*/
SET @sFicRegle          = @sRepExport + '\' + 'FRAIS_REGLES_' + @sdtTrt + '.TXT'
SET @sFicEnCours        = @sRepExport + '\' + 'FRAIS_ENCOURS_' + @sdtTrt + '.TXT'
/*------------------------------------------------------------------*/
/* On récupére le nom de la base sur lequel on est connecté.        */
/*------------------------------------------------------------------*/
SELECT  @sBase = DB_NAME ( dbid )
FROM    master.dbo.sysprocesses
WHERE   spid = @siSpId
/*------------------------------------------------------------------*/
/* On arme les deux chaine qui vont représenter les SELECTS à lancer*/
/*------------------------------------------------------------------*/
SET     @sSelectRegle   = 'SELECT trcf.id_regauto AS ''ID'', trcf.id_sin AS ''REF.SIN'', trcf.id_seq AS ''N° COMMANDE'',trcf.id_prod AS ''ID_PROD'',pro.lib_long AS ''LIB.PRODUIT'',c1.lib_code AS ''LIB.FOURNISSEUR'',trcf.mt_reg AS ''MT.REGLE'',trcf.cree_le AS ''CREE LE'',trcf.maj_par AS ''CREE PAR'' FROM    ' + @sBase + '.sysadm.trace_regl_auto  AS trcf INNER JOIN ' + @sBase + '.sysadm.produit  AS pro  ON      trcf.id_prod = pro.id_prod INNER JOIN ' + @sBase + '.sysadm.code_car AS c1   ON      trcf.id_four = c1.id_code WHERE   trcf.cod_etat           = 600 AND trcf.process_id         = ' + CONVERT ( VARCHAR(5), @siSpId )   + '     AND trcf.str_dte_trt        = ''' + @sdtTrt                         + '''   AND  c1.id_typ_code          = ''-FR'' AND trcf.id_four = ''' + @asIdFour + ''''
SET     @sSelectEnCours = 'SELECT trcf.id_regauto AS ''ID'', trcf.id_sin AS ''REF.SIN'', trcf.id_seq AS ''N° COMMANDE'',trcf.id_prod AS ''ID_PROD'',pro.lib_long AS ''LIB.PRODUIT'',c1.lib_code AS ''LIB.FOURNISSEUR'',trcf.mt_a_reg AS ''MT.A REGLER'',trcf.alt_travail_cree AS ''TRAVAIL'',trcf.lib_erreur AS ''DESC.PROBLEME'',trcf.cree_le AS ''CREE LE'',trcf.maj_par AS ''CREE PAR'' FROM    ' + @sBase + '.sysadm.trace_regl_auto  AS trcf INNER JOIN ' + @sBase + '.sysadm.produit  AS pro  ON      trcf.id_prod = pro.id_prod INNER JOIN ' + @sBase + '.sysadm.code_car AS c1   ON      trcf.id_four = c1.id_code WHERE   trcf.cod_etat           = 500 AND trcf.process_id         = ' + CONVERT ( VARCHAR(5), @siSpId )   + '     AND trcf.str_dte_trt        = ''' + @sdtTrt                         + '''   AND  c1.id_typ_code          = ''-FR'' AND trcf.id_four = ''' + @asIdFour + ''''

IF      @sBase IS NULL 
        BEGIN
                SET @asRetour = 'Le nom de la base n''est pas renseigné.'
                RETURN -1
        END
/*------------------------------------------------------------------*/
/* On va positionner toutes les lignes qui vont faire l'objet d'un  */
/* mail. Pour cela, on effectue deux UPDATES.                       */
/*------------------------------------------------------------------*/
/* Le premier s'occupe de traiter toutes les nouvelles lignes.      */
/*------------------------------------------------------------------*/
BEGIN   TRAN Mail1
        UPDATE  sysadm.trace_regl_auto
        SET     process_id      = @siSpId,
                str_dte_trt     = @sdtTrt
        WHERE   nb_envoi_mail   = 0             AND
                process_id      IS NULL         AND
                id_four         = @asIdFour     AND
                cod_etat        = 600

        SELECT  @ErrorRegle     = @@ERROR,
                @iNbrRegle      = @@ROWCOUNT
/*------------------------------------------------------------------*/
/* Le second s'occupe de traiter les frais EN COURS DE REGLEMENT.   */
/*------------------------------------------------------------------*/
        UPDATE  sysadm.trace_regl_auto
        SET     process_id      = @siSpId,
                str_dte_trt     = @sdtTrt
        WHERE   cod_etat        = 500           AND
                process_id      IS NULL         AND
                id_four         = @asIdFour
                
        SELECT  @ErrorEnCours   = @@ERROR,
                @iNbrEnCours    = @@ROWCOUNT

        IF      @ErrorRegle <> 0 Or @ErrorEnCours <> 0
                BEGIN
                        ROLLBACK TRAN Mail1
                        SET @asRetour = 'La mise à jour INITIALE de la table trace_regl_auto vient d''échouer.'
                        RETURN -1
                END
        ELSE
                BEGIN
/*------------------------------------------------------------------*/
/* On peut commiter la transaction. Normalement, personne ne peut   */
/* plus prendre ces enregistrements. Si une coupure devait survenir,*/
/* il faut sélectionner toutes les lignes avec un process_id NON    */
/* NULL et/ou une date de traitement NON NULL.                      */
/*------------------------------------------------------------------*/
                        COMMIT TRAN Mail1
                END
/*------------------------------------------------------------------*/
/* On va maintenant générer deux fichiers. Un pour le dossiers      */
/* réglés, et un pour les dossiers refusés.                         */
/*------------------------------------------------------------------*/
/* REGLE                                                            */
/*------------------------------------------------------------------*/
SET @sCmd = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + @sSelectRegle + '" /o' + @sFicRegle + ' -w5000 -u -s"|" -t5'
EXEC master.dbo.xp_cmdshell @sCmd, no_output
/*------------------------------------------------------------------*/
/* On va vérifier si le fichier de sortie existe. Si ce n'est pas   */
/* le cas, on arrête le traitement.                                 */
/*------------------------------------------------------------------*/
/* La table tempdb.dbo.#TblFileExistsExportFrais existe forcément.  */
/* On vient de la créer pour vérifier l'existence du répertoire     */
/* d'export.                                                        */
/*------------------------------------------------------------------*/
DELETE FROM #TblFileExistsExportFrais

INSERT INTO #TblFileExistsExportFrais
EXEC master.dbo.xp_fileexist @sFicRegle

IF      ( SELECT FileExists FROM #TblFileExistsExportFrais ) <> 1
        BEGIN
                EXEC ('Drop table #TblFileExistsExportFrais' )
                SET @asRetour = 'Impossible de générer le fichier ' + @sFicRegle + '. Les lignes de la table trace_regl_auto sont restées positionnées.'
                RETURN -1
        END
/*------------------------------------------------------------------*/
/* EN COURS.                                                        */
/*------------------------------------------------------------------*/
SET @sCmd = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + @sSelectEnCours + '" /o' + @sFicEnCours + ' -w5000 -u -s"|" -t5'
EXEC master.dbo.xp_cmdshell @sCmd, no_output
/*------------------------------------------------------------------*/
/* On va vérifier si le fichier de sortie existe. Si ce n'est pas   */
/* le cas, on arrête le traitement.                                 */
/*------------------------------------------------------------------*/
DELETE FROM #TblFileExistsExportFrais

INSERT INTO #TblFileExistsExportFrais
EXEC master.dbo.xp_fileexist @sFicEnCours

IF      ( SELECT FileExists FROM #TblFileExistsExportFrais ) <> 1
        BEGIN
                EXEC ('Drop table #TblFileExistsExportFrais' )
                SET @asRetour = 'Impossible de générer le fichier ' + @sFicEnCours + '. Les lignes de la table trace_regl_auto sont restées positionnées.'
                RETURN -1
        END
/*------------------------------------------------------------------*/
/* On va maintenant procéder à l'envoi des deux mails.              */
/*------------------------------------------------------------------*/
SET @asNomFichier       = LTRIM ( RTRIM ( @asNomFichier ) )
SET @asDateEtHrTrt      = LTRIM ( RTRIM ( @asDateEtHrTrt ) )

SET @sObjetRegle        = 'Intégration fichier ' + @sLibFournisseur + ' du ' + @asDateEtHrTrt  + '. [Règlements effectués]-[' + CONVERT ( VARCHAR(4), @iNbrRegle ) + ' dossier(s)]'
SET @sObjetEnCours      = 'Intégration fichier ' + @sLibFournisseur + ' du ' + @asDateEtHrTrt  + '. [Règlements rejetés à passer manuellement]-[' + CONVERT ( VARCHAR(4), @iNbrEnCours ) + ' dossier(s)]'

SET @sTextRegle         = 'Ci-joint un fichier des règlements passés automatiquement le ' + @asDateEtHrTrt + ', sur réception du fichier de suivi en provenance de [' + @sLibFournisseur + '] :' + @asNomFichier + CHAR(10) + CHAR(10)
SET @sTextEnCours       = 'Ci-joint un fichier de cumul des règlements automatiques rejetés, sur réception du fichier de suivi en provenance de [' + @sLibFournisseur + '] :' + @asNomFichier + CHAR(10) + CHAR(10)
SET @sTextEnCours       = @sTextEnCours + 'Ces règlements doivent donc être passés manuellement par le département de gestion.' + CHAR(10)
SET @sTextEnCours       = @sTextEnCours + 'Pour la plupart des cas, un travail a été créé automatiquement.' + CHAR(10) + CHAR(10)

SET @sTo                = 'simpa2_fournisseur@spb.fr'
SET @sCc                = ''
/*------------------------------------------------------------------*/
/* Envoi du mail pour les REGLES.                                   */
/*------------------------------------------------------------------*/
EXEC @iRet = master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sTo, @sTextRegle, @sObjetRegle, 'SIMPA2_REGL_OK@SPB.FR', @sCc, @sFicRegle
IF      @iRet <> 1
        BEGIN
                SET @asRetour = 'L''envoi du mail pour les frais réglés est impossible.'
                RETURN -1
        END
/*------------------------------------------------------------------*/
/* Envoi du mail pour les en-cours.                                 */
/*------------------------------------------------------------------*/
EXEC @iRet = master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sTo, @sTextEnCours, @sObjetEnCours, 'SIMPA2_REGL_A_FAIRE@SPB.FR', @sCc, @sFicEnCours
IF      @iRet <> 1
        BEGIN
                SET @asRetour = 'L''envoi du mail pour les frais en-cours est impossible.'
                RETURN -1
        END
/*------------------------------------------------------------------*/
/* On va maintenant repositionner les dossiers dans la table        */
/* TRACE_REGL_AUTO.                                                 */
/*------------------------------------------------------------------*/
BEGIN TRAN Mail2
        UPDATE  sysadm.trace_regl_auto
        SET     process_id      = NULL,
                str_dte_trt     = NULL,
                nb_envoi_mail   = nb_envoi_mail + 1,
                dte_envoi_mail  = @dtTrt
        WHERE   process_id      = @siSpId       AND
                str_dte_trt     = @sdtTrt       AND
                id_four         = @asIdFour
                
        SET @ErrorFinal = @@ERROR
        
        IF      @ErrorFinal <> 0 
                BEGIN
                        ROLLBACK TRAN Mail2
                        SET @asRetour = 'La mise à jour FINALE de la table trace_regl_auto vient d''échouer.'
                        RETURN -1
                END
        ELSE
                BEGIN
                        COMMIT TRAN Mail2
                END
/*------------------------------------------------------------------*/
/* S'il existe une transaction ouverte au départ, on l'ouvre aussi  */
/* à la fin. Ceci afin d'éviter une erreur 266 qui n'a aucune       */
/* incidence sur le code (Sql ou Pb)                                */
/*------------------------------------------------------------------*/
IF      @iTransactionOuv > 0    BEGIN TRAN
RETURN 1

GO

grant execute on sysadm.PS_ENVOI_MAIL_SUITE_INSERTION_FRAIS to rolebddsinistres
go

--  JFF		12/02/2016		[PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_FRAIS' AND type = 'P' )
        DROP procedure sysadm.DW_S02_FRAIS
GO

CREATE procedure sysadm.DW_S02_FRAIS
 @dcIdSin        Decimal ( 10, 0 )  -- [PI062]     
AS
 SELECT f.id_sin,
        f.id_i,
        f.id_frais,
        f.id_typ_frais,
        f.lib_frais,
        f.mt_frais,
		f.id_reg,
        f.cod_etat,
        f.cree_le,
        f.maj_le,
        f.maj_par,
		isnull(sysadm.FN_CODE_NUM(f.id_typ_frais,'+NF'),'') as lib_typ_frais
 FROM   sysadm.frais f
 WHERE  f.id_sin = @dcIdSin

GO

grant execute on sysadm.DW_S02_FRAIS to rolebddsinistres
go