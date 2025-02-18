-------------------------------------------------------------------------------
--  SHERPA.CP : Commandes SIMPA2 pour SqlServer : Utilisation par SHERPA
--
-- PS_V01_SIN      	       FS  le 07/06/2002 : Procédure de v‚rification du nø sinistre
-- PS_I01_TRAVAIL  	       FS  le 12/02/2002 : Cr‚ation d'un travail sur SIMPA
-- PS_V01_ADH      	       FS  le 17/04/2002 : Procédure de v‚rification du nø adh‚sion
-- PS_I01_W_SIN    	       FS  le 12/02/2002 : Cr‚ation d'un dossier sur SIMPA ( sinistre )
-- PS_I01_W_INTER_V02  	       FS  le 18/02/2002 : Cr‚ation des interlocuteurs SIMPA
-- DW_S01_OPER_PROD	       FS  le 22/02/2002 : Selection des op‚rateur par produit
-- DW_S01_INFO_SIN 	       PLJ le 25/03/2002 : Informations compl‚mentaires pour liste sinistre
-- PS_S01_INFO_SUIVI           FS  le 06/01/2003 : Informations pour suivi d'activit‚
-- DW_S01_INFO_COMMANDE_V02    FS  le 09/05/2003 : Informations sur les commandes
-- PS_I01_W_GAR_SIN	       FS  le 08/04/2002 : Cr‚ation d'une nouvelle garantie vierge
-- PS_I01_W_DETAIL 	       FS  le 09/04/2002 : Cr‚ation d'un nouveau d‚tail vierge
-- DW_S01_ETAT_Q   	       FS  le 15/04/2002 : S‚lection du code ‚tat dans w_queue
-- DW_S01_ETAT_Q_ADH           FS  le 16/10/2002 : S‚lection du code ‚tat dans w_queue + Références adh‚sion
-- DW_S01_RECH_PROD_CARTE      FS  le 23/04/2003 : Recherche des produits associ‚s … un num‚ro de carte
-- DW_S01_RECH_GROUPE_CARTE   PLJ  le 30/07/2002 : Recherche du groupe associ‚ … un num‚ro de carte
-- PS_V01_TRAVAIL_EXIST       PLJ  le 19/08/2002 : V‚rification qu'un travail n'existe pas sur un dossier
-- DW_S01_ASSURE               FS  le 11/09/2002 : Selection des coordonn‚es de l'assure
-- DW_S01_ASSURE_V02		  FPI  le 06/10/2009 - [DCMP090574]
-- DW_U01_ASSURE_V02      FS  le 11/09/2002 : Mise a jour des coordonn‚es de l'assure
-- PS_V01_TRAVAIL_ETAT        PLJ  le 24/09/2002 : V‚rif qu'un travail n'est pas occup‚ pour BO 
-- PS_V01_TRAVAIL_ADHESION_V01 FS le 09/04/2013 : Verification des travaux sur la même adhésion
-- DW_S01_RECH_INFO_CARTE      FS  le 04/06/2003 : R‚cup‚ration Information Carte
-- PS_U01_BLOQUER_DOSSIER	FPI	08/01/2009	[RoutageMasse] : Positionne alt_occuper='N' et renvoie la valeur de maj_par d'un dossier
-- PS_INTEGRER_CONTACT_FACTURATION FPI 30/06/2009 [DCMP090310] Intégration des contacts d'information
-- PS_LIRE_UTILISATEUR_SITE	FPI	02/07/2009	[Atlas].Courrier
-- PS_S_ARCHIVE_REPONSE		FPI	14/09/2016	[PC151259]
-- PS_U_ARCHIVE_PIECE       JFF 10/01/2020 [PC192290]
-- PS_S_RECUP_ID_CLIENT     JFF 10/04/2020 [PM506-1]
-- Ecri
---------------------------------------------------------------------------------------------------------------------
-- Scripting_Sinistre_Charger_V100 FS le 03/12/2013 : Procédure pour le scripting noética
---------------------------------------------------------------------------------------------------------------------
-- Attention 
--  Bases SIMPA2  Production   : SIMPA2_PRO
--                Simulation   : SIMPA2_TRT
--                Developement : SIMPA2_TRT
--
-- [sysadm].[PS_I01_TRAVAIL]
-- [sysadm].[DW_S01_OPER_PROD]
-- [sysadm].[PS_I01_TRAVAIL_V01]
-- [sysadm].[PS_I01_W_INTER_V02]  
-- [sysadm].[PS_I01_W_SIN_V01]
-- [sysadm].[PS_V01_TRAVAIL_ADHESION_V01]
-- [sysadm].[Scripting_Sinistre_Charger_V100] 
-- PS_I04_CONTACT_TRAVAIL
-- sysadm.DW_S01_ASSURE
-- sysadm.DW_S01_ASSURE_V01
-- sysadm.DW_S01_ASSURE_V02
-- sysadm.DW_S01_ETAT_Q
-- sysadm.DW_S01_ETAT_Q_ADH
-- sysadm.DW_S01_INFO_COMMANDE
-- sysadm.DW_S01_INFO_COMMANDE_V02
-- sysadm.DW_S01_RECH_GROUPE_CARTE
-- sysadm.DW_S01_RECH_GROUPE_CARTE_V01
-- sysadm.DW_S01_RECH_GROUPE_CARTE_V02
-- sysadm.DW_S01_RECH_INFO_CARTE
-- sysadm.DW_S01_RECH_PROD_CARTE
-- sysadm.DW_S02_INFO_SIN
-- sysadm.DW_U01_ASSURE
-- sysadm.DW_U01_ASSURE_V01
-- sysadm.DW_U01_ASSURE_V02
-- sysadm.PS_I_CONTACT_CLIENT
-- sysadm.PS_I_NUM_CARTE_CADEAU_CONFO
-- sysadm.PS_I01_W_DETAIL
-- sysadm.PS_I01_W_GAR_SIN
-- sysadm.PS_I01_W_INTER
-- sysadm.PS_I01_W_INTER_V01
-- sysadm.PS_I01_W_SIN
-- sysadm.PS_I04_CONTACT_TRAVAIL_V01
-- sysadm.PS_INTEGRER_CONTACT_CLIENT
-- sysadm.PS_INTEGRER_CONTACT_FACTURATION
-- sysadm.PS_LIRE_UTILISATEUR_SITE
-- sysadm.PS_S_ARCHIVE_REPONSE
-- sysadm.PS_S_RECUP_ID_CLIENT
-- sysadm.PS_S01_APP_A_RECUP
-- sysadm.PS_S01_INFO_SUIVI
-- sysadm.PS_U_ARCHIVE_PIECE
-- sysadm.PS_U01_BLOQUER_DOSSIER
-- sysadm.PS_V01_ADH
-- sysadm.PS_V01_SIN
-- sysadm.PS_V01_SIN
-- sysadm.PS_V01_TRAVAIL_ETAT
-- sysadm.PS_V01_TRAVAIL_EXIST
-- sysadm.PS_V01_WKFS_W_QUEUE
-- sysadm.PS_VERIF_PRODUIT_ETS
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            : PS_V01_SIN
-- Auteur               : FS
-- Date                 : 07/06/2002
-- Libellé              :        
-- Commentaires         : Procédure de v‚rification du nø sinistre
--				
-- Références           : Grille GRC
--  
--
-- Retourne             :   
--
-------------------------------------------------------------------
-- #1  FS    02/12/2002   Je remplace @iIdSin par @dcIdSin dont le type correspond … la base de donn‚es
-- #2  FS    22/01/2003   Suite pb signal‚ par CVA j'exclus les adh‚sion = '0' de la v‚rification
-- #3  FS    30/03/2011   Itsm64071 : Correction de la vérification sur le n° d'adhésion 
-- #4  FS    22/01/2015   Itsm266862 : PS_V01_SIN_V01 Prise en compte des cartes masquées
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

/* Ancienne version avant Itsm266862
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_V01_SIN' AND type = 'P' )
        DROP procedure sysadm.PS_V01_SIN
GO

CREATE procedure sysadm.PS_V01_SIN
@iIdSin   Integer     ,
@sRetour  Varchar(60) Output

As

Declare @iIdSinW  Integer
Declare @dcIdSin  Decimal(7,0)                        /* #1 */

Select @dcIdSin = Convert ( Decimal(7,0), @iIdSin )   /* #1 */

Select @sRetour = 'OK'

/*------------------------------------------------------------------*/
/* (1)Vérification du nombre de travaux pour le même n° adhésion    */
/*------------------------------------------------------------------*/
        Select @iIdSinW = Convert ( integer, null )

        /* ... V‚rification sur les tables d'instruction ...*/ 

	SELECT @iIdSinW = min( Convert ( integer, wq.id_sin) )
	  FROM sysadm.w_queue wq,
	       sysadm.w_sin s ,
	       sysadm.w_sin sa
	 WHERE 
               s.id_prod = sa.id_prod                      And
               s.id_ets  = sa.id_ets                       And
               s.id_adh  = sa.id_adh                       And  -- [PI038][RELEVE]
               s.id_sdos = sa.id_sdos                      And
               s.id_sin <> sa.id_sin                       And
               sa.id_adh <> '0'                            And  -- [PI038][RELEVE]
               sa.id_adh <> '0000000'                      And  -- [Itsm64071] -- [PI038][RELEVE]

	       sa.id_sin =Convert( decimal(7), wq.id_sin ) And
	       s.id_sin = @dcIdSin

        /* ... V‚rification sur les tables permanentes   ...*/ 

        If @iIdSinW is Null
           Begin

  	     SELECT @iIdSinW = min( Convert ( integer, wq.id_sin) )
	       FROM sysadm.w_queue wq,
	            sysadm.sinistre s ,
	            sysadm.sinistre sa
	      WHERE 
                    s.id_prod = sa.id_prod                      And
                    s.id_ets  = sa.id_ets                       And
                    s.id_adh  = sa.id_adh                       And  -- [PI038][RELEVE]
                    s.id_sdos = sa.id_sdos                      And
                    s.id_sin <> sa.id_sin                       And
                    sa.id_adh <> '0'                            And  -- [PI038][RELEVE]
                    sa.id_adh <> '0000000'                      And  -- [Itsm64071] -- [PI038][RELEVE]

	            sa.id_sin =Convert( decimal(7), wq.id_sin ) And
	            s.id_sin = @dcIdSin
           End 


        If @iIdSinW is Not Null   /* ... Pb il faut d'abord valider le travail sur l'autre adhésion ...*/
           Begin
	       Select @sRetour = 'Travail sur ' + Convert ( varchar(10), @iIdSinW ) + ' … valider d''abord'
	       Return -1
           End

GO
*/

-- JFF      12/02/2016   [PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_V01_SIN' AND type = 'P' )
        DROP procedure sysadm.PS_V01_SIN
GO

CREATE procedure sysadm.PS_V01_SIN
@iIdSin   Integer     ,
@sRetour  Varchar(60) Output

As

Declare @iIdSinW  Integer
Declare @dcIdSin  Decimal(10,0)     -- [PI062]   /* #1 */

Select @dcIdSin = Convert ( Decimal(10,0), @iIdSin ) -- [PI062]  /* #1 */

Select @sRetour = 'OK'

/*------------------------------------------------------------------*/
/* (1)Vérification du nombre de travaux pour le même n° adhésion    */
/*------------------------------------------------------------------*/
        Select @iIdSinW = Convert ( integer, null )

        /* ... V‚rification sur les tables d'instruction ...*/ 

	-- [ITSM266682] Partie 1 : Vérification pour adhésion numériques 

	SELECT @iIdSinW = min( Convert ( integer, wq.id_sin) )
	  FROM sysadm.w_queue wq,
	       sysadm.w_sin s ,
	       sysadm.w_sin sa
	 WHERE 
               s.id_prod = sa.id_prod                      And
               s.id_ets  = sa.id_ets                       And
               s.id_adh  = sa.id_adh                       And  -- [PI038][RELEVE]
               s.id_sdos = sa.id_sdos                      And
               s.id_sin <> sa.id_sin                       And
               sa.id_adh <> '0'                            And  -- [PI038][RELEVE]
               sa.id_adh <> '0000000'                      And  -- [Itsm64071] -- [PI038][RELEVE]
               ISNUMERIC( s.id_adh) = 1                    And  -- [ITSM266682] 
			   sa.id_sin =Convert( decimal(10), wq.id_sin ) And -- [PI062]
	           s.id_sin = @dcIdSin
		
	-- [ITSM266682] Partie 2 : Vérification pour adhésion à carte codée
	  If @iIdSinW is Null
		Begin
			SELECT @iIdSinW = min( Convert ( integer, wq.id_sin) )
			FROM sysadm.w_queue wq,
			sysadm.w_sin s ,
			sysadm.w_sin sa
			WHERE 
			s.id_prod = sa.id_prod                      And
			s.id_ets  = sa.id_ets                       And
			s.id_adh  = sa.id_adh                       And  -- [PI038][RELEVE]
			s.id_sdos = sa.id_sdos                      And
			s.id_sin <> sa.id_sin                       And
			sa.id_adh <> '0'                            And  -- [PI038][RELEVE]
			sa.id_adh <> '0000000'                      And  -- [Itsm64071] -- [PI038][RELEVE]
			ISNUMERIC( s.id_adh) = 0                    And  -- [ITSM266682] Adhésion non numérique
			sa.nom    = s.nom                           And  -- [ITSM266682] Jointure nom
			sa.prenom = s.prenom                        And  -- [ITSM266682] Jointure prénom
			sa.id_sin = Convert( decimal(10), wq.id_sin ) And -- [PI062]
			s.id_sin  = @dcIdSin
			
		End

        /* ... V‚rification sur les tables permanentes   ...*/ 

		--> Part 3 vérification sur la table permanente pour ad numérique
		-->        cartes masques non testées : la vérif en instruction suffit

        If @iIdSinW is Null
           Begin

  	     SELECT @iIdSinW = min( Convert ( integer, wq.id_sin) )
	       FROM sysadm.w_queue wq,
	            sysadm.sinistre s ,
	            sysadm.sinistre sa
	      WHERE 
                    s.id_prod = sa.id_prod                      And
                    s.id_ets  = sa.id_ets                       And
                    s.id_adh  = sa.id_adh                       And  -- [PI038][RELEVE]
                    s.id_sdos = sa.id_sdos                      And
                    s.id_sin <> sa.id_sin                       And
                    sa.id_adh <> '0'                            And  -- [PI038][RELEVE]
                    sa.id_adh <> '0000000'                      And  -- [Itsm64071] -- [PI038][RELEVE]
                    ISNUMERIC( s.id_adh) = 1                    And  -- [ITSM266682] 

	            sa.id_sin =Convert( decimal(10), wq.id_sin ) And -- [PI062]
	            s.id_sin = @dcIdSin
	                        
           End 


        If @iIdSinW is Not Null   /* ... Pb il faut d'abord valider le travail sur l'autre adhésion ...*/
           Begin
	       Select @sRetour = 'Travail sur ' + Convert ( varchar(10), @iIdSinW ) + ' … valider d''abord'
	       Return -1
           End

GO

grant execute on sysadm.PS_V01_SIN to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_TRAVAIL
-- Auteur               :       FS
-- Date                 :       12/02/2002
-- Libellé              :        
-- Commentaires         :       Cr‚ation d'un travail sur SIMPA
--				
-- Références           :       Sherpa : Cr‚ation d'un travail sur SIMPA
--  
--
-- Retourne 0 Si Ok / -1 Si erreur
-------------------------------------------------------------------
-- #1  PLJ   17/07/2002   Incr‚mentation de 1 de id_msg_seq pour contact dans tous les cas.
-- #2  FS    10/09/2002   V‚rification avant d'attribuer routage.cod_travail CPL / DEC
-- #3  FS    02/12/2002   Je remplace @iIdSin par @dcIdSin dont le type correspond … la base de donn‚es
-- #4  PLJ   30/12/2003   Vérification qu'il ne reste pas de dossier papier à archiver avant complément
-- #5  JFF   20/08/2004   Gestion nouvelles tables div_sin et w_div_sin
-- #6  JFF   05/10/2005   Gestion nouvelles tables div_det et w_div_det
-- #7  FS    10/10/2005   Correction passage de @sIdSin de varchar(6) à varchar(7)
-- #8  FS    30/04/2009   ATLAS ; Cloture du contact précédent dans le cas d'un travail préexistant
-- #9  FS    15/04/2013   [VDOC10312] V01 : Idem mais sans le contrôle PS_V01_SIN ( travail sur autre adhésion )
--     JFF   12/02/2016   [PI062]
------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRAVAIL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_TRAVAIL
GO

CREATE  procedure [sysadm].[PS_I01_TRAVAIL]
@iIdSin      	integer ,
@iIdDept	integer ,
@sIdCanal	char(1) ,
@sTypRecu	char(1) ,
@sCodIProv	char(1) ,
@sDosSuiviPar	char(4) ,
@sTxtMess	varchar(254),
@sNumMach	varchar(15),
@sCodOper       varchar ( 4),
@dtRecu		datetime,
@dtCourCli	datetime,
@dtFinGti       datetime,
@iIdContact	integer,
@sRetour	varchar (60)	output,
@dtTrvCreeLe	datetime	output,
@sTypRecuTrc	char(1)		output,
@sIdCorb	char(4)		output

AS

Declare @iNb         Integer
Declare @iNbW        Integer
Declare @iRet        Integer
Declare @iIdCorb     Integer
Declare @iIdProd     Integer
Declare @iIdSinW     Integer
Declare @iMaxSeq     Integer
Declare @sIdSin      Varchar(10) -- #7 -- [PI062]
Declare @sNom        Varchar(35)
Declare @sPrenom     Varchar(35)
Declare @sIdAdh      Varchar(19)
Declare @sCodAction  Char(1)
Declare @sTypePrec   Char(1)
Declare @sSecteur    Char(1)
Declare @dtJour      Datetime
Declare @sCodTravail Char(3)
Declare @sAltQueue   Char(1)
Declare @sAltCt      Char(1)    /* Provisoire pour cr‚ation d'un contact */
Declare @sTypMsg     Varchar(2) /* Provisoire pour cr‚ation d'un contact */
Declare @sNull       Char(1)    /* Provisoire pour cr‚ation d'un contact */
Declare @dcIdSin  Decimal(10,0)   -- [PI062]     /* #3 */
Declare @iIdCtOld    Integer    /* #8 n° du contact préexistant */
Declare @sTypeBase Varchar(3)	  /* #8 */	


Set @sTypeBase =  master.dbo.SPB_FN_TYPEBASE( db_id() ) /* #8 */

Select @dcIdSin    = Convert ( Decimal(10,0), @iIdSin ) /* #3 */ -- [PI062]
Select @sIdSin     = Convert ( Varchar(10)  , @iIdSin ) -- #7 -- [PI062]

Select @sRetour    = 'OK'
Select @sCodAction = '1'
Select @iRet       = 0
Select @iIdProd    = 0
Select @sNull      = Convert ( char(1), null )

Select @dtJour     = GetDate ()
Select @dtTrvCreeLe= @dtJour

/*------------------------------------------------------------------*/
/* R‚cup‚ration des donn‚es depuis les tables permanentes           */
/*------------------------------------------------------------------*/

SELECT
       @iIdProd  = convert ( integer, p.id_prod ),
       @iIdCorb  = convert ( integer, p.id_corb ),
       @sAltCt   = p.alt_contact                 ,
       @sNom     = lTrim ( rTrim ( pe.nom    ) ) ,
       @sPrenom  = lTrim ( rTrim ( pe.prenom ) ) ,
       @sIdAdh   = s.id_adh                      ,
       @sSecteur = 'P'
  FROM
       sysadm.sinistre s,
       sysadm.produit  p,
       sysadm.personne pe
 WHERE
       s.id_prod  = p.id_prod   And

       s.id_ordre = pe.id_ordre And

       s.id_sin   = @dcIdSin

/*------------------------------------------------------------------*/
/* R‚cup‚ration des donn‚es depuis les tables d'instruction         */
/*------------------------------------------------------------------*/

If @iIdProd = 0

   Begin

     SELECT
  			@iIdProd  = Convert ( integer, p.id_prod ),
        @iIdCorb  = Convert ( integer, p.id_corb ),
        @sAltCt   = p.alt_contact                 ,
        @sNom     = lTrim ( rTrim ( s.nom    ) )  ,
        @sPrenom  = lTrim ( rTrim ( s.prenom ) )  ,
        @sIdAdh   = s.id_adh                      ,
        @sSecteur = 'W'
     FROM
        sysadm.w_sin   s,
        sysadm.produit p
     WHERE
       s.id_prod  = p.id_prod   And

       s.id_sin   = @dcIdSin

   End


/*------------------------------------------------------------------*/
/* R‚cup‚ration des donn‚es n‚cessaires pour la trace.              */
/* Lors de l'utilisation standard de SIMPA2, ces informations sont  */
/* r‚cup‚r‚ par l'interm‚diaire de idw_Routage. Cette datawindow    */
/* est charg‚ avant la mise … jour de routage et w_queue            */
/* (u_gs_cree_wkf::uf_valider )                                     */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Existe t-il d‚j… un travail ?              */
/*------------------------------------------------------------------*/
/* #8 Ajout de @iIdCtOld                                            */
/*------------------------------------------------------------------*/

SELECT @iNbW = count(*), @sTypePrec = Min ( wq.cod_typ_recu ), @iIdCtOld = Min( wq.id_contact ) FROM sysadm.w_queue wq WHERE wq.id_sin = @sIdSin


IF @sTypRecu = 'D' 
  begin
	SELECT @sTypRecuTrc = '0'
  end
ELSE
        /*-----------------------------------*/
  begin /* Debut : Contrôle en complément    */
        /*-----------------------------------*/


        Exec sysadm.PS_V01_SIN @iIdSin, @sRetour Output

        If @sRetour <> 'OK'   /* ... Pb il faut d'abord valider le travail sur l'autre adh‚sion ...*/
           Begin              /*     Le message @sRetour est renseign‚ par la procédure            */
	          Return -1
           End

        /*----------------------------------------------------------*/
        /* #4 Vérification qu'il ne reste pas de dossier à archiver */
        /*----------------------------------------------------------*/
		  If @sDosSuiviPar <> 'IMGA'	
			Begin
				Exec sysadm.PS_V01_WKFS_W_QUEUE @iIdSin, @sRetour Output	-- [ITSM] pas de vérif si PS lancée apr batch Ged GAI
		        If @sRetour <> 'OK'   
		           Begin              
			          Return -1
		           End
			End
       

        /* ... D‚termination de @sTypRecuTrc  ...*/
 
        SELECT @sCodTravail = cod_travail FROM sysadm.routage where id_sin = @dcIdSin


        Select @sTypRecuTrc =
               Case
                  When @sCodTravail = 'CPL' And @iNbW = 0 Then '1'
                  When @sCodTravail = 'CPL' And @iNbW > 0 Then '4'
                  When @sCodTravail = 'CAS'               Then '2'
                  When @sCodTravail = 'DEC'               Then '3'
                End


        /*-----------------------------------*/
  end   /* Fin : Contr“le en compl‚ment      */
        /*-----------------------------------*/


/*------------------------------------------------------------------*/
/* ()Cr‚ation / Mise … jour sur w_queue                             */
/*------------------------------------------------------------------*/

If @iNbW > 0

         /*----------------------------*/
   Begin /* D‚but travail existe       */
         /*----------------------------*/

         /* .. Contr“le : Le travail est-il bloqu‚ ? */

     SELECT @iRet = count(*) FROM sysadm.w_queue wq WHERE wq.id_sin = @sIdSin And alt_occupe = 'O'

     If @iRet <> 0 
        Begin
          Select @sRetour = 'PS_I01_TRAVAIL:Travail occup‚'
		    Return -1
        End

         /* .. Cr‚ation du travail                   */
    
     Exec @iRet = sysadm.PS_U01_W_QUEUE_WKF @dcIdSin, @iIdCorb, @sDosSuiviPar
     If @iRet <> 1 
        Begin
          Select @sRetour = 'PS_U01_W_QUEUE_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' mise … jour de w_queue'
	  Return -1
        End

		/* #8 ... Clôturer le contact Sherpa préexistant */

		If @sTypeBase = 'PRO'
			Begin
				Exec @iRet = SHERPA_PRO.sysadm.PS_U01_CONTACT_CLOTURE @dcIdSin, 2, @sCodOper, @iIdCtOld
			End
		Else
			Begin
				Exec @iRet = SHERPA_SIM.sysadm.PS_U01_CONTACT_CLOTURE @dcIdSin, 2, @sCodOper, @iIdCtOld
			End

	     If @iRet <> 0 
	        Begin
	          Select @sRetour = 'PS_U01_CONTACT_CLOTURE:Cloture contact'
			    Return -1
	        End


         /*----------------------------*/
   End   /* Fin travail existe         */
         /*----------------------------*/

Else
         /*----------------------------*/
   Begin /* D‚but nouveau travail      */
         /*----------------------------*/

          Exec @iRet = sysadm.PS_I01_W_QUEUE_WKF @dcIdSin , @iIdProd  , @iIdCorb , @sNom,      @sPrenom,
                                                 @dtJour  , @sTxtMess , @sIdCanal, @sCodIProv, @dtRecu ,
                                @sTypRecu, @dtCourCli, @sCodOper, @sDosSuiviPar
     
          If @iRet <> 1 
             Begin
               Select @sRetour = 'PS_I01_W_QUEUE_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' cr‚ation sur w_queue'
	       Return -1
             End

         /*----------------------------*/
   End   /* Fin nouveau travail        */
         /*----------------------------*/


/*------------------------------------------------------------------*/
/* Mise à jour de id_contact sur w_queue                            */
/*------------------------------------------------------------------*/
/* #3 FS je remplace convert ( varchar(6), @iIdSin ) par @sIdSin    */
/*------------------------------------------------------------------*/
UPDATE sysadm.w_queue
   SET id_contact = @iIdContact
 WHERE id_sin = @sIdSin


/*------------------------------------------------------------------*/
/* ()Mise … jour de la table routage                                */
/*------------------------------------------------------------------*/

If @sTypRecu = 'C'
   Begin

     /* #2 D‚but de modification */

     Select @iNb = Count(*) FROM sysadm.sinistre WHERE id_sin = @dcIdSin

     If @iNb <> 0
        Begin
          Select @sCodTravail = 'CPL'
        End
     Else
        Begin
          Select @sCodTravail = 'DEC'
        End

     /* #2 Fin de modification */
 
     Exec @iRet = sysadm.PS_U01_ROUTAGE_WKF @dcIdSin , @iIdCorb, @sCodTravail, @dtJour, @sCodOper  /* #2 Je passe @sCodTravail ald 'CPL' */

     If @iRet <> 1 
        Begin
          Select @sRetour = 'PS_U01_ROUTAGE_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' mise … jour sur routage'
          Return -1
        End

   End

/*------------------------------------------------------------------*/
/* ()Cr‚ation sur la table routage                                  */
/*------------------------------------------------------------------*/

If @sTypRecu = 'D'
   Begin

     Exec @iRet = sysadm.PS_I01_ROUTAGE_WKF @dcIdSin, @iIdCorb, 'DEC', @dtJour

     If @iRet <> 1 
        Begin
          Select @sRetour = 'WKF_I_ROUTAGE:Erreur ' + Convert ( varchar(10), @iRet ) + ' cr‚ation sur routage'
          Return -1
        End

   End

/*------------------------------------------------------------------*/
/* Compl‚ment : Rapatriement du dossier en instruction              */
/*------------------------------------------------------------------*/

SELECT @iNb = count(*) FROM sysadm.w_sin ws WHERE ws.id_sin = @dcIdSin

If @iNb = 0 And @sTypRecu = 'C'

         /*----------------------------*/
   Begin /* D‚but rapatriement dossier */
         /*----------------------------*/

     Exec @iRet = sysadm.PS_I01_W_SIN_WKF  @dcIdSin
     If @iRet <> 1 
        Begin
          Select @sRetour = 'PS_I01_W_SIN_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

     /* #5 JFF le 20/08/2004 Gestion nouvelles tables div_sin et w_div_sin */
     Exec @iRet = sysadm.PS_I01_W_DIV_SIN_WKF  @dcIdSin
     If @iRet <> 0 
        Begin
          Select @sRetour = 'PS_I01_W_DIV_SIN_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

     Exec @iRet = sysadm.PS_I01_W_INTER_WKF @dcIdSin
     If @iRet <> 0 
        Begin
          Select @sRetour = 'PS_I01_W_INTER_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

     Exec @iRet = sysadm.PS_I01_W_FRAIS_WKF @dcIdSin
     If @iRet <> 0 
        Begin
          Select @sRetour = 'PS_I01_W_FRAIS_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

     Exec @iRet = sysadm.PS_I01_W_GTI_WKF @dcIdSin
     If @iRet <> 0
        Begin
          Select @sRetour = 'PS_I01_W_GTI_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

     Exec @iRet = sysadm.PS_I01_W_DETAIL_WKF @dcIdSin
     If @iRet <> 0 
        Begin
          Select @sRetour = 'PS_I01_W_DETAIL_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

     Exec @iRet = sysadm.PS_I01_W_COMMANDE_WKF @dcIdSin
     If @iRet <> 0 
        Begin
          Select @sRetour = 'PS_I01_W_COMMANDE_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

     /* #6 JFF le 05/10/2005 Gestion nouvelles tables div_det et w_div_det */
     Exec @iRet = sysadm.PS_I01_W_DIV_DET_WKF  @dcIdSin
     If @iRet <> 0 
        Begin
          Select @sRetour = 'PS_I01_W_DIV_DET_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End


     Exec @iRet = sysadm.PS_I01_W_REFUS_WKF @dcIdSin, @iIdProd
     If @iRet <> 0 
        Begin
          Select @sRetour = 'PS_I01_W_REFUS_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

         /*----------------------------*/
   End   /* Fin rapatriement dossier   */
         /*----------------------------*/

/*------------------------------------------------------------------*/
/* Compl‚ment : Maj de la date de fin de garantie                   */
/*------------------------------------------------------------------*/

If @sTypRecu = 'C' And @dtFinGti Is Not Null

   Begin

     Exec @iRet = sysadm.PS_U01_W_SIN_WKF @dcIdSin, @dtFinGti
     If @iRet <> 1 
        Begin
          Select @sRetour = 'PS_U01_W_SIN_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

   End


SELECT @sIdCorb = Convert ( varchar (4), @iIdCorb )

Return 0

Go

-- JFF      12/02/2016   [PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRAVAIL_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I01_TRAVAIL_V01
GO

CREATE procedure [sysadm].[PS_I01_TRAVAIL_V01]
@iIdSin      	integer ,
@iIdDept	integer ,
@sIdCanal	char(1) ,
@sTypRecu	char(1) ,
@sCodIProv	char(1) ,
@sDosSuiviPar	char(4) ,
@sTxtMess	varchar(254),
@sNumMach	varchar(15),
@sCodOper       varchar ( 4),
@dtRecu		datetime,
@dtCourCli	datetime,
@dtFinGti       datetime,
@iIdContact	integer,
@sRetour	varchar (60)	output,
@dtTrvCreeLe	datetime	output,
@sTypRecuTrc	char(1)		output,
@sIdCorb	char(4)		output

AS

-- [VDOC10312] V01 plus de contrôle PS_V01_SIN : Ecriture d'une version spécifique utilisée par SHERPA / PS_I04_CONTACT_TRAVAIL

Declare @iNb         Integer
Declare @iNbW        Integer
Declare @iRet        Integer
Declare @iIdCorb     Integer
Declare @iIdProd     Integer
Declare @iIdSinW     Integer
Declare @iMaxSeq     Integer
Declare @sIdSin      Varchar(10) -- #7  -- [PI062]
Declare @sNom        Varchar(35)
Declare @sPrenom     Varchar(35)
Declare @sIdAdh      Varchar(19)
Declare @sCodAction  Char(1)
Declare @sTypePrec   Char(1)
Declare @sSecteur    Char(1)
Declare @dtJour      Datetime
Declare @sCodTravail Char(3)
Declare @sAltQueue   Char(1)
Declare @sAltCt      Char(1)    /* Provisoire pour cr‚ation d'un contact */
Declare @sTypMsg     Varchar(2) /* Provisoire pour cr‚ation d'un contact */
Declare @sNull       Char(1)    /* Provisoire pour cr‚ation d'un contact */
Declare @dcIdSin  Decimal(10,0)    -- [PI062]       /* #3 */
Declare @iIdCtOld    Integer    /* #8 n° du contact préexistant */
Declare @sTypeBase Varchar(3)	  /* #8 */	


Set @sTypeBase =  master.dbo.SPB_FN_TYPEBASE( db_id() ) /* #8 */

Select @dcIdSin    = Convert ( Decimal(10,0), @iIdSin ) /* #3 */  -- [PI062]
Select @sIdSin     = Convert ( Varchar(10)  , @iIdSin ) -- #7  -- [PI062]

Select @sRetour    = 'OK'
Select @sCodAction = '1'
Select @iRet       = 0
Select @iIdProd    = 0
Select @sNull      = Convert ( char(1), null )

Select @dtJour     = GetDate ()
Select @dtTrvCreeLe= @dtJour

/*------------------------------------------------------------------*/
/* R‚cup‚ration des donn‚es depuis les tables permanentes           */
/*------------------------------------------------------------------*/

SELECT
       @iIdProd  = convert ( integer, p.id_prod ),
       @iIdCorb  = convert ( integer, p.id_corb ),
       @sAltCt   = p.alt_contact                 ,
       @sNom     = lTrim ( rTrim ( pe.nom    ) ) ,
       @sPrenom  = lTrim ( rTrim ( pe.prenom ) ) ,
       @sIdAdh   = s.id_adh                      ,
       @sSecteur = 'P'
  FROM
       sysadm.sinistre s,
       sysadm.produit  p,
       sysadm.personne pe
 WHERE
       s.id_prod  = p.id_prod   And

       s.id_ordre = pe.id_ordre And

       s.id_sin   = @dcIdSin

/*------------------------------------------------------------------*/
/* R‚cup‚ration des donn‚es depuis les tables d'instruction         */
/*------------------------------------------------------------------*/

If @iIdProd = 0

   Begin

     SELECT
  	@iIdProd  = Convert ( integer, p.id_prod ),
        @iIdCorb  = Convert ( integer, p.id_corb ),
        @sAltCt   = p.alt_contact                 ,
        @sNom     = lTrim ( rTrim ( s.nom    ) )  ,
        @sPrenom  = lTrim ( rTrim ( s.prenom ) )  ,
        @sIdAdh   = s.id_adh                      ,
        @sSecteur = 'W'
     FROM
        sysadm.w_sin   s,
        sysadm.produit p
     WHERE
       s.id_prod  = p.id_prod   And

       s.id_sin   = @dcIdSin

   End


/*------------------------------------------------------------------*/
/* R‚cup‚ration des donn‚es n‚cessaires pour la trace.              */
/* Lors de l'utilisation standard de SIMPA2, ces informations sont  */
/* r‚cup‚r‚ par l'interm‚diaire de idw_Routage. Cette datawindow    */
/* est charg‚ avant la mise … jour de routage et w_queue            */
/* (u_gs_cree_wkf::uf_valider )                                     */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* #8 Ajout de @iIdCtOld                                            */
/*------------------------------------------------------------------*/

SELECT @iNbW = count(*), @sTypePrec = Min ( wq.cod_typ_recu ), @iIdCtOld = Min( wq.id_contact ) FROM sysadm.w_queue wq WHERE wq.id_sin = @sIdSin


IF @sTypRecu = 'D' 
  begin
	SELECT @sTypRecuTrc = '0'
  end
ELSE
        /*-----------------------------------*/
  begin /* Debut : Contrôle en complément    */
        /*-----------------------------------*/

        /* ... D‚termination de @sTypRecuTrc  ...*/
 
        SELECT @sCodTravail = cod_travail FROM sysadm.routage where id_sin = @dcIdSin


        Select @sTypRecuTrc =
               Case
                  When @sCodTravail = 'CPL' And @iNbW = 0 Then '1'
                  When @sCodTravail = 'CPL' And @iNbW > 0 Then '4'
                  When @sCodTravail = 'CAS'               Then '2'
                  When @sCodTravail = 'DEC'               Then '3'
                End


        /*-----------------------------------*/
  end   /* Fin : Contr“le en compl‚ment      */
        /*-----------------------------------*/


/*------------------------------------------------------------------*/
/* ()Cr‚ation / Mise … jour sur w_queue                             */
/*------------------------------------------------------------------*/

If @iNbW > 0

         /*----------------------------*/
   Begin /* D‚but travail existe       */
         /*----------------------------*/

         /* .. Contr“le : Le travail est-il bloqu‚ ? */

     SELECT @iRet = count(*) FROM sysadm.w_queue wq WHERE wq.id_sin = @sIdSin And alt_occupe = 'O'

     If @iRet <> 0 
        Begin
          Select @sRetour = 'PS_I01_TRAVAIL:Travail occup‚'
		    Return -1
        End

      /* .. Mise à jour du travail                   */
    
     Exec @iRet = sysadm.PS_U01_W_QUEUE_WKF @dcIdSin, @iIdCorb, @sDosSuiviPar
     If @iRet <> 1 
        Begin
          Select @sRetour = 'PS_U01_W_QUEUE_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' mise … jour de w_queue'
		  Return -1
        End
     /* [VDOC17618] mise à jour du canal sur cod_recu */
     
		Update sysadm.w_queue set cod_recu = @sIdCanal Where id_sin = @dcIdSin
		Set @iRet = @@ERROR
		If @iRet <> 0 
		Begin
			Select @sRetour = 'PS_U01_W_QUEUE_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' maj de w_queue.cod_recu'
			Return -1
		End
        

		/* #8 ... Clôturer le contact Sherpa préexistant */

		If @sTypeBase = 'PRO'
			Begin
				Exec @iRet = SHERPA_PRO.sysadm.PS_U01_CONTACT_CLOTURE @dcIdSin, 2, @sCodOper, @iIdCtOld
			End
		Else
			Begin
				Exec @iRet = SHERPA_SIM.sysadm.PS_U01_CONTACT_CLOTURE @dcIdSin, 2, @sCodOper, @iIdCtOld
			End

	     If @iRet <> 0 
	        Begin
	          Select @sRetour = 'PS_U01_CONTACT_CLOTURE:Cloture contact'
			    Return -1
	        End


         /*----------------------------*/
   End   /* Fin travail existe         */
         /*----------------------------*/

Else
         /*----------------------------*/
   Begin /* D‚but nouveau travail      */
         /*----------------------------*/

          Exec @iRet = sysadm.PS_I01_W_QUEUE_WKF @dcIdSin , @iIdProd  , @iIdCorb , @sNom,      @sPrenom,
                                                 @dtJour  , @sTxtMess , @sIdCanal, @sCodIProv, @dtRecu ,
                                                 @sTypRecu, @dtCourCli, @sCodOper, @sDosSuiviPar
     
          If @iRet <> 1 
             Begin
               Select @sRetour = 'PS_I01_W_QUEUE_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' cr‚ation sur w_queue'
	       Return -1
             End

         /*----------------------------*/
   End   /* Fin nouveau travail        */
         /*----------------------------*/


/*------------------------------------------------------------------*/
/* Mise à jour de id_contact sur w_queue                            */
/*------------------------------------------------------------------*/
/* #3 FS je remplace convert ( varchar(6), @iIdSin ) par @sIdSin    */
/*------------------------------------------------------------------*/
UPDATE sysadm.w_queue
   SET id_contact = @iIdContact
 WHERE id_sin = @sIdSin


/*------------------------------------------------------------------*/
/* ()Mise … jour de la table routage                                */
/*------------------------------------------------------------------*/

If @sTypRecu = 'C'
   Begin

     /* #2 D‚but de modification */

     Select @iNb = Count(*) FROM sysadm.sinistre WHERE id_sin = @dcIdSin

     If @iNb <> 0
        Begin
          Select @sCodTravail = 'CPL'
        End
     Else
        Begin
          Select @sCodTravail = 'DEC'
        End

     /* #2 Fin de modification */
 
     Exec @iRet = sysadm.PS_U01_ROUTAGE_WKF @dcIdSin , @iIdCorb, @sCodTravail, @dtJour, @sCodOper  /* #2 Je passe @sCodTravail ald 'CPL' */

     If @iRet <> 1 
        Begin
          Select @sRetour = 'PS_U01_ROUTAGE_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' mise … jour sur routage'
          Return -1
        End

   End

/*------------------------------------------------------------------*/
/* ()Cr‚ation sur la table routage                                  */
/*------------------------------------------------------------------*/

If @sTypRecu = 'D'
   Begin

     Exec @iRet = sysadm.PS_I01_ROUTAGE_WKF @dcIdSin, @iIdCorb, 'DEC', @dtJour

     If @iRet <> 1 
        Begin
          Select @sRetour = 'WKF_I_ROUTAGE:Erreur ' + Convert ( varchar(10), @iRet ) + ' cr‚ation sur routage'
          Return -1
        End

   End

/*------------------------------------------------------------------*/
/* Compl‚ment : Rapatriement du dossier en instruction              */
/*------------------------------------------------------------------*/

SELECT @iNb = count(*) FROM sysadm.w_sin ws WHERE ws.id_sin = @dcIdSin

If @iNb = 0 And @sTypRecu = 'C'

         /*----------------------------*/
   Begin /* D‚but rapatriement dossier */
         /*----------------------------*/

     Exec @iRet = sysadm.PS_I01_W_SIN_WKF  @dcIdSin
     If @iRet <> 1 
        Begin
          Select @sRetour = 'PS_I01_W_SIN_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

     /* #5 JFF le 20/08/2004 Gestion nouvelles tables div_sin et w_div_sin */
     Exec @iRet = sysadm.PS_I01_W_DIV_SIN_WKF  @dcIdSin
     If @iRet <> 0 
        Begin
          Select @sRetour = 'PS_I01_W_DIV_SIN_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

     Exec @iRet = sysadm.PS_I01_W_INTER_WKF @dcIdSin
     If @iRet <> 0 
        Begin
          Select @sRetour = 'PS_I01_W_INTER_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

     Exec @iRet = sysadm.PS_I01_W_FRAIS_WKF @dcIdSin
     If @iRet <> 0 
        Begin
          Select @sRetour = 'PS_I01_W_FRAIS_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

     Exec @iRet = sysadm.PS_I01_W_GTI_WKF @dcIdSin
     If @iRet <> 0
        Begin
          Select @sRetour = 'PS_I01_W_GTI_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

     Exec @iRet = sysadm.PS_I01_W_DETAIL_WKF @dcIdSin
     If @iRet <> 0 
        Begin
          Select @sRetour = 'PS_I01_W_DETAIL_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

     Exec @iRet = sysadm.PS_I01_W_COMMANDE_WKF @dcIdSin
     If @iRet <> 0 
        Begin
          Select @sRetour = 'PS_I01_W_COMMANDE_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
  End

     /* #6 JFF le 05/10/2005 Gestion nouvelles tables div_det et w_div_det */
     Exec @iRet = sysadm.PS_I01_W_DIV_DET_WKF  @dcIdSin
     If @iRet <> 0 
        Begin
          Select @sRetour = 'PS_I01_W_DIV_DET_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End


     Exec @iRet = sysadm.PS_I01_W_REFUS_WKF @dcIdSin, @iIdProd
     If @iRet <> 0 
        Begin
          Select @sRetour = 'PS_I01_W_REFUS_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

         /*----------------------------*/
   End   /* Fin rapatriement dossier   */
         /*----------------------------*/

/*------------------------------------------------------------------*/
/* Compl‚ment : Maj de la date de fin de garantie                   */
/*------------------------------------------------------------------*/

If @sTypRecu = 'C' And @dtFinGti Is Not Null

   Begin

     Exec @iRet = sysadm.PS_U01_W_SIN_WKF @dcIdSin, @dtFinGti
     If @iRet <> 1 
        Begin
          Select @sRetour = 'PS_U01_W_SIN_WKF:Erreur ' + Convert ( varchar(10), @iRet ) + ' rapatriement'
          Return -1
        End

   End


SELECT @sIdCorb = Convert ( varchar (4), @iIdCorb )

Return 0

Go

grant execute on sysadm.PS_I01_TRAVAIL_V01 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : PS_V01_ADH
-- Auteur               : FS
-- Date                 : 17/04/2002
-- Libellé              :        
-- Commentaires         : Procédure de vérification du nø adh‚sion
--				
-- Références           : PS_I01_W_SIN & controle n° adh‚sion sur GRC
--  
--
-- Retourne             :   
--
-------------------------------------------------------------------
-- #1 FS le 18/09/2002 : Si adh‚sion facultative m‚thode 7 + id_adh = 0 ( non renseign‚ )
--                       on ne fait pas le contr“le d'existence d'un autre travail
-- #2 FS le 15/11/2002 : Gestion adhesion facultative pour produit 1900
-- #3 FS le 20/11/2002 : Demande C.Chanal + CVerrier : retrait m‚thode 7
-- #4 FS le 08/07/2003   Pb sur produit 1907 la méthode 7 ne fonctionne que pour les pdts de téléphonie ( cod_tel )
--                        Or 1907 n'est pas un pdt de téléphonie !
-- #5 FS le 13/09/2006 : Correction pb en cas de code ets non passé 
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_V01_ADH' AND type = 'P' )
        DROP procedure sysadm.PS_V01_ADH
GO


CREATE procedure sysadm.PS_V01_ADH
@iIdProd  Integer     ,
@sIdAdh	  Varchar(19) ,
@sIdEts   Varchar(5)     Output,
@sLibEts  Varchar(35) Output,
@sRetour  Varchar(60) Output

As

Declare @sCodAdh        Char(1)
Declare @sCodAdhInit    Char(1)
Declare @iCodTel        Integer

Declare @sIdTypeCarte   Char(3)
Declare @iNbAffilier    Integer
Declare @iIdCarte       Integer
Declare @iIdEts1        Integer
Declare @iIdEts2        Integer
Declare @iIdGrp         Integer 
Declare @iIdSinW        Integer

Select @sRetour     = 'OK'
Select @iNbAffilier = 0

If @sIdEts = '' Set @sIdEts = null -- #5

/*------------------------------------------------------------------*/
/* R‚cup‚ration des donn‚es depuis la base SIMPA                    */
/*------------------------------------------------------------------*/
   
   SELECT @sCodAdh     = cod_adh,
          @sCodAdhInit = cod_adh,
          @iCodTel     = cod_tel
     FROM
          sysadm.produit
    WHERE
          id_prod = @iIdProd

                                        /*-------------------------------------------------------------------*/
                                        /* #1 produit tel = adh‚sion facultative                             */
                                        /* Sur SIMPA pour ne pas avoir … basculer les produits de t‚l‚phonie */
                                        /* en m‚thode d'adh‚sion facultative, je considŠre cod_adh = 7 en    */
                                        /* fonction du flag cod_tel                                          */
                                        /* #2 le 15/11/02 : Vu MLB / CCH Pour le produit 1900 Securiplus BPA */
                                        /*               On ne possŠde les adhesions que jusqu'au 31/08/01   */
                                        /*               ensuite saisie en adh facultative                   */
                                        /* #3 le 20/11/02 : Demande C.Chanal + CVerrier : retrait m‚thode 7  */
                                        /* #4 le 08/07/03 : Traitement du cas du 1907 Vu avec SLE            */
                                        /*-------------------------------------------------------------------*/
                                     
                                     
   If @iCodTel = 1 Or @iIdProd = 1907 Select @sCodAdh = '7'


   If @sCodAdh = '7' And @sIdAdh <> '0'  Select @sCodAdh = @sCodAdhInit

   If @sCodAdh = '7' And @sIdAdh = '0'

            /*------------------------------------------*/
      Begin /*  Debut : tolérence adhésion non saisie   */
            /*------------------------------------------*/

        /* On essaye d'interpréter le code ets lié au produit */

           SELECT @iIdEts1 = Min ( e.id_ets ),
                  @iIdEts2 = Max ( e.id_ets ),
                  @iIdGrp  = Max ( e.id_grp )
             FROM
                  sysadm.etablissement e
            WHERE
                  e.id_prod = @iIdProd

            If @iIdEts1 = @iIdEts2 Select @sIdEts = Convert ( Varchar(5), @iIdEts1 )

            /*------------------------------------------*/
      End   /*  Fin   : tol‚rence adh‚sion non saisie   */
            /*------------------------------------------*/

   If @sCodAdh in ( '3', '4' )

            /*------------------------------------------*/
      Begin /*  Debut : controle du type de carte       */
            /*------------------------------------------*/

	   Exec sysadm.PS_S01_CARTE_SINISTRE @sIdAdh, @iIdProd, @iIdCarte     Output, 
	                                                        @sIdTypeCarte Output,
		                                                @iIdGrp       Output,
	                                                        @iNbAffilier  Output
	   If @sIdTypeCarte is Null
	       Begin
	         Select @sRetour = @sIdAdh  + ' non couverte'
                 Select @sLibEts  = @sRetour
		 Select @sIdEts = '0'
	         Return -1
	       End

           If @iNbAffilier = 0
               Begin
                 Select @sRetour = 'Carte non affili‚e au produit ' + convert( varchar(10), @iIdProd )
               End

            
            /*------------------------------------------*/
      End   /*  Fin   : controle du type de carte       */
            /*------------------------------------------*/

    If @sCodAdh = '3'

            /*------------------------------------------*/
      Begin /*  Debut : interpr‚tation id_ets = id_grp  */
            /*------------------------------------------*/

           If @iIdGrp Is Not Null
              Begin
	           Select @sIdEts  = Convert ( varchar(5), @iIdGrp )
              End
           Else
              Begin
                   Select @sIdEts = '0'
              End

            /*------------------------------------------*/
      End   /*  Fin : interpr‚tation id_ets = id_grp    */
            /*------------------------------------------*/


    If @sCodAdh in ( '1', '2', '5', '6'  ) 

            /*------------------------------------------*/
      Begin /*  Debut : interpr‚tation id_grp           */
            /*------------------------------------------*/


	SELECT
	       @iIdGrp = Convert ( integer, p.id_grp )
	 FROM
		sysadm.produit p
		
	WHERE
		p.id_prod     = @iIdProd
              
	   If @iIdGrp is Null
	       Begin
	         Select @sRetour = 'Etablissement incorrect'
                 Select @sLibEts  = @sRetour
	         Return -1
	       End

            /*------------------------------------------*/
      End   /*  Fin   : interpr‚tation id_grp           */
            /*------------------------------------------*/

    /*----------------------*/
    /* Libelle groupe       */
    /*----------------------*/

     Select @sLibEts = lib_grp FROM sysadm.groupe WHERE id_grp = @iIdGrp 

/*------------------------------------------------------------------*/
/* V‚rification si travail en cours pour le mˆme nø adh‚sion        */
/*------------------------------------------------------------------*/
/* #1 Dans le cas d'une adh‚sion facultative, je ne fais pas le ctl */
/*------------------------------------------------------------------*/

 If @sCodAdh = '7' And @sIdAdh = '0' 
    Begin
       Select @sLibEts = @sLibEts + ' (Adh non enregistrée)'
       Return 0
    End


     Select @iIdSinW = Convert ( integer, null )

     /* ... Vérification sur les tables d'instruction ...*/ 

	SELECT @iIdSinW = min( Convert ( integer, wq.id_sin) )
	  FROM sysadm.w_queue wq,
	       sysadm.w_sin s ,
	       sysadm.w_sin sa
	 WHERE 
               s.id_prod = sa.id_prod                      And
               s.id_ets  = sa.id_ets                       And
               s.id_adh  = sa.id_adh                       And
               s.id_sdos = sa.id_sdos                      And

	       sa.id_sin =Convert( decimal(10), wq.id_sin )  And  -- [PI062]
	       sa.id_adh  = @sIdAdh                         And
               sa.id_prod = Convert ( decimal(7),@iIdProd ) And
               sa.id_ets  = Convert ( decimal(7), @sIdEts )

     /* ... V‚rification sur les tables permanentes   ...*/ 

     If @iIdSinW is Null
        Begin

	SELECT @iIdSinW = min( Convert ( integer, wq.id_sin) )
	  FROM sysadm.w_queue wq,
	       sysadm.sinistre s ,
	       sysadm.sinistre sa
	 WHERE 
               s.id_prod = sa.id_prod                      And
               s.id_ets  = sa.id_ets                       And
               s.id_adh  = sa.id_adh                       And
               s.id_sdos = sa.id_sdos                      And
	       sa.id_sin =Convert( decimal(10), wq.id_sin )  And -- [PI062]
	       sa.id_adh  = @sIdAdh                         And
               sa.id_prod = Convert ( decimal(7),@iIdProd ) And
               sa.id_ets  = Convert ( decimal(7), @sIdEts )

End 

     If @iIdSinW is Not Null   /* ... Pb il faut d'abord valider le travail sur l'autre adh‚sion ...*/
        Begin
	    Select @sRetour = 'Travail sur ' + Convert ( varchar(10), @iIdSinW ) + ' … valider d''abord'
            Select @sLibEts = @sRetour
	    Return -1
        End

Return 0

Go

grant execute on sysadm.PS_V01_ADH to rolebddsinistres
go



--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_W_SIN
-- Auteur               :       FS
-- Date                 :       18/02/2002
-- Libellé              :        
-- Commentaires         :       Création d'un dossier de sinistre sur SIMPA
--				
-- Références           :       Sherpa : Cr‚ation d'un dossier dans le cas d'une d‚claration
--                              Appel‚ sur un DataObject d_Stk_Sh_Simpa_w_Sin
--                     		
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1  FS  le 04/10/2002 Dans le cas de l'inter assur‚ si c'est une soci‚t‚ je traite le pr‚nom … part
-- #2  FS  le 15/11/2002 Gestion adhesion facultative pour produit 1900
-- #3  FS  le 20/11/02   : Demande C.Chanal + CVerrier : retrait m‚thode 7
-- #4  FS  le 26/11/02   Vu avec JFF temporairement ajout de cinq nouvelles donn‚es
--                       ( Ces valeurs seront ult‚rieurement lues de AL et transmises en param‚tres depuis sherpa )
-- #5  FS  le 30/12/02  Suite #4 Ajout r‚el des nouvelles valeurs 
--                      @sIdContratAbonne Varchar(20)
--                      @iIdHlr           Integer
--                      @iIdOrianMarque   Integer
--                      @iIdOrianModele   Integer
--                      @lIdBoutique      Integer
-- #6  FS  le 08/07/03  Pb sur produit 1907 la méthode 7 ne fonctionne que pour les pdts de téléphonie ( cod_tel )
--                     Or 1907 n'est pas un pdt de téléphonie
-- #7  FS  le 21/10/03  Correction bug : Test cod_tel strictement positif
-- #8  FS  le 31/01/04  Traitement du cas de 19100 Vu avec HM           
-- #9  FS  le 13/09/05  V01 : Gestion du Codic paramétre @idCodIc
-- #10 PHG le 20/03/06 DCMP 060246 : test de l'existence du codic dans ref_codic_darty avant insert w_div_sin
-- #11 FS  le 13/09/06  Ajout contrôle entre code produit et code ets
-- #12 FS  le 28/11/06 Traitement du cas du 25700 vu avec HM
-- #13 FS  le 14/11/07 Gestion produits 59 et 276 vu avec HM
-- #14 Le 06/12/07 : Produit 276 retiré car remis en -MA,1 Vu avec HM
-- #15 FS  le 29/02/08 : Gestion des produits 28500 et 28501
-- #16 FS  le 19/09/08 : Gestion du produit 30600, Vu avec Cq
-- #17 FS  le 27/11/08 : Gestion du produit 30700, Vu avec Cq
-- #18 FS  le 29/05/09 : Gestion du produit 32800, Vu avec Flp/Cq
-- #19 FS  le 10/09/09 : Gestion des adhésions facultatives / det_pro 98
--     JFF le 20/01/14 : [PM208] masquage n° de carte en base.
-- #20 FS  le 03/06/14 : [Correctif carte casto]
-- #21 JFF Le 13/03/23 : Inter Banque du 322, aussi pour le 671
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_SIN_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_SIN_V01
GO

CREATE procedure [sysadm].[PS_I01_W_SIN_V01]
@iIdSin           Integer     OutPut,
@iIdProd          Integer     ,
@iIdEts           Integer     Output, 
@sLibEts          Varchar(35) Output,
@sIdAdh           Varchar(19) Output, 
@iIdsDos          Integer     ,
@iOption          Integer     ,
@dtDteDecl        Datetime    , 
@dtDteSurv        Datetime    ,
@dtDteAdh         Datetime    ,  
@dtDteSous        Datetime    , 
@dtDteOpt         Datetime    , 
@dtDteResil       Datetime    , 
@dtDteFinGti      Datetime    , 
@sCodCiv          Char(1)     ,
@sNom             Varchar(35) ,
@sPrenom          Varchar(35) ,
@sAdr1            Varchar(35) ,
@sAdr2            Varchar(35) ,
@sAdrCp           Char(5)     ,
@sAdrVille        Varchar(35) ,
@sNumTelD         Varchar(20) ,
@sNumTelB         Varchar(20) ,
@sNumFax          Varchar(20) ,
@sIdCanal  	  Char(1)     ,
@sCodIProv	  Char(1)     ,
@sTxtMess  	  Varchar(254),
@sCodOper         Varchar (4) ,
@sNumPort         Varchar(19) , 
@sNumImeiPort     Varchar(19) , 
@sMarqPort        Varchar(35) , 
@sModlPort        Varchar(35) , 
@dtAchPort        Datetime    , 
@dtOuvLigPort     Datetime    ,
@sIdContratAbonne Varchar(20) ,
@iIdHlr           Integer     ,
@iIdOrianMarque   Integer     ,
@iIdOrianModele   Integer     ,
@lIdBoutique      Integer     ,
@idCodIc          Integer  = null   ,
@sRetour	  Varchar (60)  Output

As

Declare @sCodProvPers   Char(1)
Declare @sIdTypeCarte   Char(3)
Declare @sCodAdh        Char(1)
Declare @sCodAdhInit    Char(1)
Declare @sCodModeReg    Varchar(2)

Declare @iCodTel        Integer
Declare @iRet           Integer
Declare @iIdGrp         Integer 
Declare @iIdPersonne    Integer 
Declare @iNbAffilier    Integer
Declare @iIdCarte       Integer
Declare @iIdAdh         Integer
Declare @iIdEts1        Integer
Declare @iIdEts2        Integer
Declare @iNb            Integer
Declare @dtJour         Datetime

Declare @sIdAdhSav		VarChar(19) -- [PM208]
Declare @sCarteCorr     Varchar(19) -- [PM208]
DECLARE @iIdCartePm208		int
DECLARE @sIdTypCartePm208	varchar(10)
DECLARE @iIdGrpPm208		int
DECLARE @sLibErreurPm208	varchar(100)


Select @dtJour  = GetDate ()
Select @iRet    = 1
Select @sRetour = 'OK'    
Select @iIdCarte    = 0
Select @sIdTypeCarte= '00'



/*------------------------------------------------------------------*/
/* #1 Vérification si assuré de type société ( civilité 5 )         */
/*    je positionne le prénom à ''                                  */
/*------------------------------------------------------------------*/

If @sCodCiv = '5' Select @sPrenom = ''

/*------------------------------------------------------------------*/
/* Récupération des données depuis la base SIMPA                    */
/*------------------------------------------------------------------*/
    
   SELECT @sCodAdh     = cod_adh,
          @iCodTel     = cod_tel,
          @sCodAdhInit = cod_adh
     FROM
          sysadm.produit
    WHERE
          id_prod = @iIdProd
                                        /*-------------------------------------------------------------------*/
                                        /* #1 produit tel = adh‚sion facultative                             */
                                        /* Sur SIMPA pour ne pas avoir … basculer les produits de t‚l‚phonie */
                                        /* en m‚thode d'adh‚sion facultative, je considŠre cod_adh = 7 en    */
                                        /* fonction du flag cod_tel                                          */
                                        /* #2 le 15/11/02 : Vu MLB / CCH Pour le produit 1900 Securiplus BPA */
                                        /*               On ne possŠde les adhesions que jusqu'au 31/08/01   */
                                        /*               ensuite saisie en adh facultative                   */
                                        /* #3  le 20/11/02 : Demande C.Chanal + CVerrier : retrait m‚thode 7 */
                                        /* #6  le 08/07/03 : Traitement du cas du 1907 Vu avec SLE           */
             /* #7  Le 21/10/03 : Test cod_tel > 0                                */
                                        /* #8  Le 31/01/04 : Traitement du cas de 19100 Vu avec HM           */
                                        /* #9  Le 28/11/06 : Traitement du cas de 25700 Vu avec HM           */
                                        /* #13 Le 14/11/07 : Traitement du cas de 27600 & 5900 Vu avec HM    */
                                        /* #14 Le 06/12/07 : Produit 276 retiré car remis en -MA,1 Vu avec HM*/
                                        /* #15 Le 29/02/08 : Traitement du cas de 28500 & 28501 Vu avec HM   */  
                                        /* #16 Le 19/09/08 : Traitement du cas de 30600 Vu avec CQ           */  
                                        /* #17 Le 27/11/08 : Traitement du cas de 30600 Vu avec CQ           */  
                                        /*-------------------------------------------------------------------*/


	-- #17 A faire ; Mettre dans Simpa l'option det_pro 98 pour les produits ci-dessous
	--             ; Ensuite remplacer le test                                     
                                     
   -- #19 If @iCodTel > 0 Or ( @iIdProd = 1907 Or @iIdProd = 19100 Or @iIdProd = 25700 Or @iIdProd = 5900 Or @iIdProd = 28500 Or @iIdProd = 28501 Or @iIdProd = 30600 Or @iIdProd = 30700 or @iIdProd = 32800) Select @sCodAdh = '7'
   -- #19 Gestion des adhésions facultatives / det_pro 98

      Select @iNb = Count(*) 
      From 
         sysadm.det_pro    
      Where 
         id_prod        = @iIdProd and
         id_typ_code_dp = '-DP' and
         id_code_dp     = 98
   
      If @iNb > 0 Set @sCodAdh = '7'

   -- #19 Fin de modification

   If @sCodAdh = '7' And @sIdAdh <> '0000000' Select @sCodAdh = @sCodAdhInit

   If @sCodAdh = '7' And @sIdAdh =  '0000000'

            /*------------------------------------------*/
      Begin /*  Debut : tolérence adhésion non saisie   */
            /*------------------------------------------*/

   				Exec @iRet = sysadm.PS_X_INCREMENTER 'ID_ADH', @iIdAdh OUTPUT
		   
				If @iRet = -1
				   Begin
					 Select @sRetour = 'PS_I01_W_SIN:Erreur attribution id_adh' 
					 Return -1
				   End

				Select @sIdAdh  = Convert ( varchar(19), @iIdAdh )
				Select @iIdsDos = 0
				--Select @iIdEts  = 0 #6 Je laisse le code ets saisi sur le contact comme valeur par défaut ( sinon pb pour le 1907 )

				/* On essaye d'interpr‚ter le code ets li‚ au produit */

				   SELECT @iIdEts1 = Min ( e.id_ets ),
						  @iIdEts2 = Max ( e.id_ets ),
						  @iIdGrp  = Max ( e.id_grp )
					 FROM
						  sysadm.etablissement e
					WHERE
						  e.id_prod = @iIdProd

					If @iIdEts1 = @iIdEts2 Select @iIdEts = @iIdEts1

            /*------------------------------------------*/
      End   /*  Fin   : tol‚rence adh‚sion non saisie   */
            /*------------------------------------------*/


   If @sCodAdh in ( '3', '4' )

            /*------------------------------------------*/
      Begin /*  Debut : controle du type de carte       */
            /*------------------------------------------*/
            
		-- [PM208] -- Le numéro de carte passée est-il correct ?            
		/*Si ce contrôle se déclenche : il faut ressaisir la carte sur le contact Sherpa*/
			Set @sCarteCorr = 'X'
			If ISNUMERIC( @sIdAdh ) = 1  Select @sCarteCorr = [sysadm].[FN_CORR_NUM_CARTE] ( @sIdAdh, @dtJour )

			/* FS le 06/2014 : Produit 234 Correctif carte casto */
			
			Set @sLibErreurPm208 = ''

			EXECUTE [sysadm].[PS_S_PM208_INFO_CARTE] 
			   @sIdAdh
			  ,@iIdCartePm208    OUTPUT
			  ,@sIdTypCartePm208 OUTPUT
			  ,@iIdGrpPm208      OUTPUT
			  ,@sLibErreurPm208  OUTPUT				

			If @sLibErreurPm208 <> 'OK' 
			Begin
				Set @sRetour = 'Carte:' + @sLibErreurPm208
				Return -1
			End			
		-- [PM208]	            

	   Exec sysadm.PS_S01_CARTE_SINISTRE @sIdAdh, @iIdProd, @iIdCarte     Output, 
	                                                        @sIdTypeCarte Output,
		                                                @iIdGrp       Output,
	                                                        @iNbAffilier  Output

	   If @sIdTypeCarte is Null
	       Begin
	         Select @sRetour = @sIdAdh  + ' non couverte'
	         Return -1
	       End

/*         Le refus sera effectu‚ sur la grille de gestion : donc contr“le bloquant d‚sactiv‚

           If @iNbAffilier = 0
               Begin
                 Select @sRetour = 'Carte non affili‚e au produit ' + convert( varchar(10), @iIdProd )
               End
*/
  
            
            /*------------------------------------------*/
      End   /*  Fin   : controle du type de carte       */
            /*------------------------------------------*/


    If @sCodAdh = '3'

            /*------------------------------------------*/
      Begin /*  Debut : interprétation id_ets = id_grp  */
            /*------------------------------------------*/

           If @iIdGrp Is Not Null
              Begin
	           Select @iIdEts  = @iIdGrp
              End
           Else
              Begin
                   Select @iIdEts = 0
              End

            /*------------------------------------------*/
      End   /*  Fin : interpr‚tation id_ets = id_grp    */
            /*------------------------------------------*/

    /*----------------------*/
    /* Libelle groupe       */
    /*----------------------*/

     Select @sLibEts = lib_grp FROM sysadm.groupe WHERE id_grp = @iIdGrp    

    /*----------------------*/
    /* Ref dans personne    */
    /*----------------------*/

    SELECT @iIdPersonne = p.id_ordre
      FROM
           sysadm.personne p
     WHERE
           p.cod_civ   = @sCodCiv   And
           p.nom       = @sNom      And
           p.prenom    = @sPrenom   And
           p.adr_1     = @sAdr1     And
           p.adr_cp    = @sAdrCp    And
           p.adr_ville = @sAdrVille 
                
     If @iIdPersonne Is Null
           Begin
             Select @sCodProvPers = 'W'
           End
        Else
           Begin
             Select @sCodProvPers = 'P'
           End

/*------------------------------------------------------------------*/
/* #11 Contrôle cohérence entre le code produit et le code ets      */
/*------------------------------------------------------------------*/

   exec @iRet = sysadm.PS_VERIF_PRODUIT_ETS @iIdProd, @iIdEts

   If @iRet = -1
   Begin
     Select @sRetour = 'PS_I01_W_SIN/PS_VERIF_PRODUIT_ETS'+  Convert ( varchar(10),@iIdEts) + '/' + Convert ( varchar(10),@iIdProd) + ' Err Ets/Pdt' 
     Return -1
   End


/*------------------------------------------------------------------*/
/* Obtention d'un nouveau n° de sinistre depuis parametre           */
/*------------------------------------------------------------------*/

   Exec @iRet = sysadm.PS_X_INCREMENTER 'ID_SIN', @iIdSin OUTPUT
   
   If @iRet = -1
   Begin
     Select @sRetour = 'PS_I01_W_SIN:Erreur attribution id_sin' 
     Return -1
   End

	-- [PM208]
    If @sCodAdh = '3'
		Begin
			Set @sIdAdhSav = @sIdAdh
			Set @sIdAdh = sysadm.FN_MASQUER_CARTE_2  ( @sIdAdh )
		End
	-- [PM208]	
        

/*------------------------------------------------------------------*/
/* Déclaration : Création dans w_sin                                */
/* #4 Ajt de 5 nouvelles valeurs                                    */
/*------------------------------------------------------------------*/
   Exec @iRet = sysadm.PS_I02_W_SIN_WKF
                   @iIdSin      , @iIdProd     , @iIdEts      , @sIdAdh       ,@iIdsDos,
                   @sIdCanal    , @sCodIProv   , @dtDteDecl   , @dtDteSurv    ,@dtDteAdh,
                   @dtDteSous   , @dtDteOpt    , @iOption     , @dtDteResil   ,@dtDteFinGti,
                   @sCodCiv     , @sNom        , @sPrenom     , @sAdr1        ,@sAdr2,
                   @sAdrCp      , @sAdrVille   , @sNumFax     , @sNumTelB     ,@sNumTelD ,
                   @sTxtMess    , @iIdCarte    , @sIdTypeCarte, @iIdPersonne  ,@sCodProvPers,
                   @dtJour      , @dtJour      , @sCodOper    , @sNumPort     ,@sNumImeiPort,
                   @sMarqPort   , @sModlPort   , @dtAchPort   , @dtOuvLigPort ,@sIdContratAbonne,
		   @iIdHlr , @iIdOrianMarque , @iIdOrianModele , @lIdBoutique


   If @iRet <> 1
   Begin
     Select @sRetour = 'PS_I01_W_SIN/PS_I02_W_SIN_WKF:Erreur Création sinistre' 
     
 	 -- [PM208]
 	If @sCodAdh = '3'
		Begin
			Set @sIdAdh = @sIdAdhSav -- Je redonne le numéro de carte non masqué
		End
	-- [PM208]	     
     
     Return -1
   End

/*------------------------------------------------------------------*/
/* Déclaration : Insertion du CODIC dans la table w_div_sin         */
/* #4 Ajt de 5 nouvelles valeurs                                    */
/*------------------------------------------------------------------*/


If @idCodIc is Not Null
Begin
	-- [#10 PHG] DCMP 060246 On teste l'existence du Codic dans ref_codic_darty
	-- 	     avant l'insertion dans w_div_sin
	IF EXISTS (SELECT id_seq FROM ref_codic_darty WHERE codic = @idCodIc)
	Begin

		Insert into sysadm.w_div_sin 
		( id_sin, 
		  nom_zone, 
		  lib_label, 
		  id_typ_liste, 
		  alt_liste_codecar, 
		  id_typ_zone, 
		  alt_oblig, 
		  alt_prot, 
		  cpt_tri, 
		  val_nbre, 
		  val_mt, 
		  val_dte, 
		  val_car, 
		  cpt_valide, 
		  cree_le, 
		  maj_le, 
		  maj_par )
		values 
		( @iIdSin, 
		  'codic', 
		  'Codic DARTY', 
		  -1, 
		  'N', 
		  'N', 
		  'O', 
		  'O', 
		  3, 
		  @idCodIc,
		  null, 
		  null, 
		  null, 
		  0, 
		  @dtJour,
		  @dtJour,
		  @sCodOper )

		Set @iRet = @@error
		If @iRet <> 0
		Begin
		  Select @sRetour = 'PS_I01_W_SIN:Erreur Création codic sur div_sin' 
		  Return -1
		End
	End 

End

Return @iRet

GO

grant execute on sysadm.PS_I01_W_SIN_V01 to rolebddsinistres
go

----------------------------------------------------------------------------------------------------
--
-- Procédure            :       PS_I01_W_INTER
-- Auteur               :       FS
-- Date                 :       18/02/2002
-- Libellé              :        
-- Commentaires         :       Cr‚ation d'un interlocuteur
--				
-- Références           :       Sherpa : Cr‚ation d'un interlocuteur dans le cas d'une d‚claration
--  
--
-- Retourne             :       Rien
--
----------------------------------------------------------------------------------------------------
-- #1 FS le 28/08/2002 Ajout d'un param‚tre @sIdCourGest 
--                     ( Non utilis‚ sur SIMPA : pour compatibilit‚ de la procédure avec la m‚thode
--                       Zq de SAVANE )
-- #2 FS le 04/10/2002 Dans le cas de l'inter assur‚ si c'est une soci‚t‚ je traite le pr‚nom … part
-- V01 FS le 10/11/2004 : Dcmp xxxxx Gestion des paramétres supplémentaires @iCodeSms, @sNumSms, @sAdrMel
--                        ( gestion de l'envoi des SMS dans SAVANE ) : la proc initiale PS_I01_W_INTER pas effacée
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_INTER' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_INTER
GO

CREATE procedure sysadm.PS_I01_W_INTER
@iIdSin         Integer     ,
@iIdInter       Integer     ,
@iIdProd        Integer     ,
@sCodInter      Char(1)     ,
@sCodCiv        Char(1)     ,
@sNom           Varchar(35) ,
@sPrenom        Varchar(35) ,
@sAdr1          Varchar(35) ,
@sAdr2          Varchar(35) ,
@sAdrCp         Char(5)     ,
@sAdrVille      Varchar(35) ,
@sNumTelD       Varchar(20) ,
@sNumTelB       Varchar(20) ,
@sNumFax        Varchar(20) ,
@sCodBq         Varchar(5)  ,
@sCodAg         Varchar(5)  ,
@sRibBq         Varchar(5)  ,
@sRibGui        Varchar(5)  ,
@sRibCpt        Varchar(11) ,
@sRibCle        Varchar(2)  ,
@sCodOper       Varchar (4) ,
@sIdCourGest    Varchar (6) ,

@sRetour	Varchar (60)  Output

As

Declare @iRet    Integer
Declare @dtJour  Datetime
Declare @sModeReg Varchar(2)

Select @dtJour  = GetDate ()
Select @iRet    = 0
Select @sRetour = 'OK'    

If @sCodInter = 'A' 

         /*------------------------------------------------------------------*/
   Begin /* D‚claration : Cr‚ation ASSURE dans w_inter                       */
         /*------------------------------------------------------------------*/

        /* #2 si Soci‚t‚ Je met le prenom = '' */

        If @sCodCiv = '5' Select @sPrenom = ''   

    	SELECT @sModeReg  = p.cod_mode_reg
	  FROM sysadm.produit p
	 WHERE
               p.id_prod      = @iIdProd And
               p.cod_dest_reg = 'A'


   	Exec @iRet = sysadm.PS_I02_W_INTER_WKF 
                   @iIdSin    , @sCodCiv  , @sNom       , @sPrenom    , @sAdr1   ,
                   @sAdr2     , @sAdrCp   , @sAdrVille  , @sModeReg   , @sNumTelD,
                   @sNumTelB  , @sNumFax  , @sRibBq     , @sRibGui    , @sRibCpt ,
                   @sRibCle   , @dtJour   , @dtJour     , @sCodOper

	If @iRet <> 1
           Begin
             Select @sRetour = 'PS_I01_W_INTER/PS_I02_W_INTER_WKF:Erreur Cr‚ation inter assur‚' 
             Return -1
           End

   End

If @sCodInter = 'B'

         /*------------------------------------------------------------------*/
   Begin /* D‚claration : Cr‚ation BANQUE dans w_inter                       */
         /*------------------------------------------------------------------*/

    	SELECT @sModeReg  = p.cod_mode_reg
	  FROM sysadm.produit p
	 WHERE
               p.id_prod      = @iIdProd And
               p.cod_dest_reg = 'B'

   	Exec @iRet = sysadm.PS_I03_W_INTER_WKF 
                   @iIdSin   , @sNom      , @sAdr1    , @sAdr2    , @sAdrCp   ,
                   @sAdrVille, @sNumTelB  , @sModeReg , @sCodBq   , @sCodAg   ,
                   @dtJour   , @dtJour    , @sCodOper

	If @iRet <> 1
           Begin
             Select @sRetour = 'PS_I01_W_INTER/PS_I03_W_INTER_WKF:Erreur Cr‚ation inter banque' 
             Return -1
           End

   End

/*------------------------------------------------------------------*/
/* D‚claration : Cr‚ation banque 30066/99998 pour produits          */
/*   11001, 14000,  14500, 14600, 15200                             */
/*                                                                  */
/* ( on d‚clenche cette cr‚ation par un code civilite = 'X'         */
/*------------------------------------------------------------------*/

If @sCodCiv = 'X'

         /*------------------------------------------------------------------*/
   Begin /* D‚claration : Cr‚ation BANQUE 30066/99998 dans w_inter           */
         /*------------------------------------------------------------------*/


     Exec @iRet = sysadm.PS_I04_W_INTER_WKF @iIdSin, @iIdProd, @dtJour, @dtJour, @sCodOper

     If @iRet <> 1
        Begin
          Select @sRetour = 'PS_I01_INTER/PS_I04_W_INTER_WKF:Erreur Cr‚ation 30066/99998' 
          Return -1
        End

  
   End

Return @iRet

GO


-------------------------------------------------------------------------------------
-- PS_I01_W_INTER_V01
-- Les paramétres @iCodSms, @sNumSms et @sAdrTel sont ici pour compatibilité avec Savane
--
-- #1 [PHG] Le 04/04/2006 : Ajout de L'interlocuteur ABD GAMES pour les produit 23100,23101,23102,23103,23104,23105
-- V02 FS le 13/06/2006 : DntMail1 : Gestion paramétre @sAltSuivi
-- #2 JFF    20/10/2008	[FNAC_PROD_ECH_TECH]
-- #3 JFF    14/11/2008	Je borne les produits de 00 à 99 pour prendre en compte les évolutions
-- #4 FS     23/09/2009 Création interlocuteur "point de balance" Aquazen
--    FPI    26/07/2011 [PC478] Création inter SPDE
-- #6 FS     12/03/2015 [VDOC16954] Création inter  ONEY BANQUE ACCORD
-- JFF      12/02/2016   [PI062]
-- JFF      17/04/2019   [PM421-5] 
-- JFF      01/09/2020   [VDOC29600]
-- JFF      26/01/201    [VDOC30089]
-- JFF      30/05/2023   [PMO89_RS4822]
-- JFF      28/03/2024   [MCO174] [MCO174_INT_AUTO_AXAB] Axa Banque : création auto inter banque 'AXA BANQUE' , dysfonctionnement site atlas  
-- JFF      18/02/2025   [PMO268_MIG25]
-------------------------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_INTER_V02' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_INTER_V02
GO
      
CREATE procedure sysadm.PS_I01_W_INTER_V02       
@iIdSin         Integer     ,        
@iIdInter       Integer     ,        
@iIdProd        Integer     ,        
@sCodInter      Char(1)     ,        
@sCodCiv        Char(1)     ,        
@sNom           Varchar(35) ,        
@sPrenom        Varchar(35) ,        
@sAdr1          Varchar(35) ,        
@sAdr2          Varchar(35) ,        
@sAdrCp         Char(5)     ,        
@sAdrVille      Varchar(35) ,        
@sNumTelD       Varchar(20) ,        
@sNumTelB       Varchar(20) ,        
@sNumFax        Varchar(20) ,        
@sCodBq         Varchar(5)  ,        
@sCodAg         Varchar(5)  ,        
@sRibBq         Varchar(5)  ,        
@sRibGui        Varchar(5)  ,        
@sRibCpt        Varchar(11) ,        
@sRibCle        Varchar(2)  ,        
@sCodOper       Varchar (4) ,        
@sIdCourGest    Varchar (6) ,        
@iCodSms        Integer       = null, -- #2 1 = Suivi Par Sms , 0 Pas de suivi par SMS        
@sNumSms        Varchar(20),        
@sAdrMel        Varchar(50),        
@sRetour Varchar (60)  Output,        
@sAltSuivi      Char(1)   = 'N' -- V02 #2 s'entend @sAltSuiviMail        
        
As        
        
Declare @iRet  Integer        
Declare @dtJour Datetime        
Declare @sModeReg Varchar(2)        
Declare @sAltSuiviMel Char(1) -- #2 Pour une meilleure compréhension ( et pour ne pas renommer le paramétre en entrée )        
Declare @sAltSuiviSms Char(1) -- #2 Gestion pdt 313 Fnac EPDT        
Declare @iPointBalance  Integer -- #4        
Declare @dcIdSin Decimal ( 10 ) -- [PI062]        
Declare @dcIdProd Decimal ( 7 )        
Declare @dcIdInterMax Decimal ( 2 )        
        
Set @dcIdProd = Convert ( Decimal (7), @iIdProd ) -- [PM421-5]        
Set @sAltSuiviMel = @sAltSuivi -- #2 Pour une meilleure compréhension ( et pour ne pas renommer le paramétre en entrée )        
        
Set @dtJour  = GetDate ()        
Set @iRet    = 0        
Set @sRetour = 'OK'            
Set @sAltSuiviSms = 'N' -- #2        
        
Set @dcIdSin = Convert ( Decimal ( 10 ) , @iIdSin ) -- [PI062]        
        
-- #2 Initialisation des rubriques @sAltSuiviSms / @sNumSms        
        
If @iCodSms is Null Set @iCodSms = 0 -- #2        
        
If @iCodSms = 1         
 Begin        
  Set @sAltSuiviSms = 'O' -- #2        
 End        
 Else        
 Begin        
  Set @sAltSuiviSms = 'N' -- #2        
  Set @sNumSms = Convert ( varchar(20), Null )        
 End        
        
        
        
If @sCodInter = 'A'         
        
         /*------------------------------------------------------------------*/        
   Begin /* D‚claration : Cr‚ation ASSURE dans w_inter                       */        
         /*------------------------------------------------------------------*/        
        
        /* #2 si Soci‚t‚ Je met le prenom = '' */        
        
        If @sCodCiv = '5' Select @sPrenom = ''           
        
     SELECT @sModeReg  = p.cod_mode_reg        
   FROM sysadm.produit p        
  WHERE        
               p.id_prod      = @iIdProd And        
               p.cod_dest_reg = 'A'        
        
 -- V02 Passage des paramétres @sAltSuiviMel , @sAdrMel        
 -- #2  Passage des paramétres @sAltSuiviSms , @sNumSms        
        
    Exec @iRet = sysadm.PS_I02_W_INTER_WKF         
                   @iIdSin    , @sCodCiv  , @sNom       , @sPrenom    , @sAdr1   ,        
                   @sAdr2     , @sAdrCp   , @sAdrVille  , @sModeReg   , @sNumTelD,        
                   @sNumTelB  , @sNumFax  , @sRibBq     , @sRibGui    , @sRibCpt ,        
                   @sRibCle   , @dtJour   , @dtJour     , @sCodOper   ,         
                   @sAltSuiviMel , @sAdrMel, @sAltSuiviSms, @sNumSms        
        
 If @iRet <> 1        
           Begin        
             Select @sRetour = 'PS_I01_W_INTER/PS_I02_W_INTER_WKF:Erreur Creation inter assur‚'         
             Return -1        
           End        
        
   End        
        
If @sCodInter = 'B'        
        
         /*------------------------------------------------------------------*/        
   Begin /* Declaration : Creation BANQUE dans w_inter                       */        
         /*------------------------------------------------------------------*/        
        
   -- [MCO174_INT_AUTO_AXAB]  
  If sysadm.FN_CLE_NUMERIQUE ( 'MCO174_INT_AUTO_AXAB') > 0   
   Begin  
    If Not Exists (   
      Select Top 1 1  
      From   sysadm.w_inter wi        
      Where  wi.id_sin = @dcIdSin        
      And    wi.cod_inter = 'B'         
      And    Upper ( wi.nom ) = Upper ( rtrim ( ltrim ( @sNom )))  
      And    Upper ( wi.adr_1 ) = Upper ( rtrim ( ltrim ( @sAdr1 )))      
      And    Upper ( wi.adr_cp ) = Upper ( rtrim ( ltrim ( @sAdrCp )))      
      And    Upper ( wi.adr_ville ) = Upper ( rtrim ( ltrim ( @sAdrVille )))  
      )        
     Begin  
      SELECT @sModeReg  = p.cod_mode_reg        
      FROM   sysadm.produit p        
      WHERE        
          p.id_prod      = @iIdProd And        
          p.cod_dest_reg = 'B'        
  
        
      Exec @iRet = sysadm.PS_I03_W_INTER_WKF         
           @iIdSin   , @sNom      , @sAdr1    , @sAdr2    , @sAdrCp   ,        
           @sAdrVille, @sNumTelB  , @sModeReg , @sCodBq   , @sCodAg   ,        
           @dtJour   , @dtJour    , @sCodOper        
        
      If @iRet <> 1        
         Begin        
        Select @sRetour = 'PS_I01_W_INTER/PS_I03_W_INTER_WKF:Erreur Cr‚ation inter banque'         
        Return -1        
         End            
     End  
   End   
  Else   
   Begin  
  
    SELECT @sModeReg  = p.cod_mode_reg        
    FROM   sysadm.produit p        
    WHERE        
        p.id_prod      = @iIdProd And        
        p.cod_dest_reg = 'B'        
  
        
    Exec @iRet = sysadm.PS_I03_W_INTER_WKF         
         @iIdSin   , @sNom      , @sAdr1    , @sAdr2    , @sAdrCp   ,        
         @sAdrVille, @sNumTelB  , @sModeReg , @sCodBq   , @sCodAg   ,        
         @dtJour   , @dtJour    , @sCodOper        
        
    If @iRet <> 1        
       Begin        
      Select @sRetour = 'PS_I01_W_INTER/PS_I03_W_INTER_WKF:Erreur Cr‚ation inter banque'         
      Return -1        
       End        
   End         
   End        
        
/*------------------------------------------------------------------*/        
/* D‚claration : Cr‚ation banque 30066/99998 pour produits          */        
/*   11001, 14000,  14500, 14600, 15200                             */        
/*                                                                  */        
/* ( on d‚clenche cette cr‚ation par un code civilite = 'X'         */        
/*------------------------------------------------------------------*/        
        
If @sCodCiv = 'X'        
        
         /*------------------------------------------------------------------*/        
   Begin /* D‚claration : Cr‚ation BANQUE 30066/99998 dans w_inter           */        
         /*------------------------------------------------------------------*/        
        
        
     Exec @iRet = sysadm.PS_I04_W_INTER_WKF @iIdSin, @iIdProd, @dtJour, @dtJour, @sCodOper        
        
     If @iRet <> 1        
        Begin        
          Select @sRetour = 'PS_I01_INTER/PS_I04_W_INTER_WKF:Erreur Cr‚ation 30066/99998'         
          Return -1        
        End        
          
   End        
        
/*------------------------------------------------------------------*/        
/* Castorama : gestion d'un interlocuteur spécifique                */        
/*------------------------------------------------------------------*/        
        
If @iIdProd between 23400 and 23499   --#3        
        
                
   Begin /* Déclaration Castorama : Création BANQUE dans w_inter */        
                
        
 Set @iIdInter = 0        
        
 Select @iIdInter = Max( i.id_i ) From sysadm.w_inter i Where i.id_sin = @dcIdSin -- [PI062]        
        
 Set @iIdInter = @iIdInter + 1        
        
 Insert into sysadm.w_inter      
  ( id_sin,id_i,cod_inter,cod_civ,nom,adr_1,adr_2,adr_cp,adr_ville,adr_att,num_teld,num_telb,num_fax,cod_mode_reg,rib_bq,rib_gui,rib_cpt,rib_cle,mt_a_reg,mt_reg,v_ref1,v_ref2,cod_ag,cod_bq,cpt_cour,cpt_valide,alt_valide,alt_part,alt_ps,alt_pce,alt_quest,id_cour,id_nat_cour,alt_courgest,id_i_db,id_courj,cree_le,maj_le,maj_par,ordre_cheque,num_let_cheque,id_four,alt_suivi_mail,adr_mail,alt_suivi_sms,num_port_sms,dte_naiss,ville_naiss,pays_naiss,cod_etat_ctrle_inter )        
 Select         
           @dcIdSin as id_sin  ,  -- [PI062]        
           @iIdInter as id_i  ,        
           'F'  as cod_inter ,        
           5  as cod_civ  ,        
           a.lib_ag as nom  ,        
           a.adr_1 as adr_1  ,        
           a.adr_2 as adr_2  ,        
           a.adr_cp as adr_cp  ,        
           a.adr_ville as adr_ville ,        
           null  as adr_att  ,        
           null  as num_teld ,        
           null  as num_telb ,        
           null  as num_fax  ,        
           'FM'  as cod_mode_reg ,        
           null  as rib_bq  ,        
           null  as rib_gui  ,        
           null  as rib_cpt  ,        
           null  as rib_cle  ,        
           0  as mt_a_reg ,        
           0  as mt_reg  ,        
           null  as v_ref1  ,        
           null  as v_ref2  ,        
           null  as cod_ag  ,        
           null  as cod_bq  ,        
           0  as cpt_cour ,        
           0  as cpt_valide , -- #4 0 ald 1        
           'N'  as alt_valide ,        
           'N'  as alt_part ,        
           'N'  as alt_ps  ,        
           'N'  as alt_pce  ,        
           'N'  as alt_quest ,                 null  as id_cour  ,        
           null  as id_nat_cour ,        
           'N'  as alt_courgest ,        
           null  as id_i_db  ,        
           null  as id_courj ,        
           getdate() as cree_le  ,        
           getdate() as maj_le  ,        
           @sCodOper as maj_par  ,        
           null  as ordre_cheque ,        
           null  as num_let_cheque ,        
           a.id_bq as id_four  ,        
   'N'  as alt_suivi_mail,        
    NULL as adr_mail,    
 NULL as alt_suivi_sms,    
 Null  as  num_port_sms, -- #2 [FNAC_PROD_ECH_TECH]        
 null as dte_naiss,  -- [PMO89_RS4822]    
 null as ville_naiss,  -- [PMO89_RS4822]    
 null as pays_naiss,  -- [PMO89_RS4822]    
 0 as cod_etat_ctrle_inter -- [PMO89_RS4822]    
           
 From        
    sysadm.agence a        
 Where        
       a.id_bq = 'CAS' And not exists        
          ( select * from sysadm.w_inter v         
             where         
                   v.id_sin     = @dcIdSin  and  -- [PI062]        
                   v.cod_inter  = 'F'      and        
                   a.lib_ag     = v.nom  and        
            a.lib_ag     = v.nom    and        
            a.adr_1      = v.adr_1  and        
                   a.adr_cp = v.adr_cp and        
                 a.adr_ville = v.adr_ville )        
                    
        
 Set @iRet = @@error        
        
 If @iRet <> 0        
           Begin        
             Select @sRetour = 'PS_I01_W_INTER:Erreur Création inter Castorama'         
             Return -1        
           End        
 Else        
           Begin        
             Set @iRet = 1        
           End        
        
   End        
        
        
If @iIdProd between 23100 and 23199 -- #3 -- #1 [PHG] Création Interlocuteur ABD Games pour Scores Games, Produit 23100,23101,23102,23103,23104,23105          
        
                 
   Begin /* Déclaration ScoreGames : Création BANQUE dans w_inter            */        
                 
        
 Set @iIdInter = 0        
        
 Select @iIdInter = Max( i.id_i ) From sysadm.w_inter i Where i.id_sin = @dcIdSin   -- [PI062]        
        
 Set @iIdInter = @iIdInter + 1        
        
 Insert into sysadm.w_inter         
 ( id_sin,id_i,cod_inter,cod_civ,nom,adr_1,adr_2,adr_cp,adr_ville,adr_att,num_teld,num_telb,num_fax,cod_mode_reg,rib_bq,rib_gui,rib_cpt,rib_cle,mt_a_reg,mt_reg,v_ref1,v_ref2,cod_ag,cod_bq,cpt_cour,cpt_valide,alt_valide,alt_part,alt_ps,alt_pce,alt_quest,id_cour,id_nat_cour,alt_courgest,id_i_db,id_courj,cree_le,maj_le,maj_par,ordre_cheque,num_let_cheque,id_four,alt_suivi_mail,adr_mail,alt_suivi_sms,num_port_sms,dte_naiss,ville_naiss,pays_naiss,cod_etat_ctrle_inter )        
 Select         
           @dcIdSin as id_sin  ,  -- [PI062]        
           @iIdInter as id_i  ,        
           'F'  as cod_inter ,        
           5  as cod_civ  ,        
           a.lib_ag as nom  ,        
           a.adr_1 as adr_1  ,        
           a.adr_2 as adr_2  ,        
           a.adr_cp as adr_cp  ,        
           a.adr_ville as adr_ville ,        
           null  as adr_att  ,        
           null  as num_teld ,        
           null  as num_telb ,        
           null  as num_fax  ,        
           'FM'  as cod_mode_reg ,        
           null  as rib_bq  ,        
           null  as rib_gui  ,        
           null  as rib_cpt  ,        
           null  as rib_cle  ,        
           0  as mt_a_reg ,        
           0  as mt_reg  ,        
           null  as v_ref1  ,        
           null  as v_ref2  ,        
           null  as cod_ag  ,        
           null  as cod_bq  ,        
           0  as cpt_cour ,        
           0  as cpt_valide , -- #4 0 ald 1        
           'N'  as alt_valide ,        
           'N'  as alt_part ,        
           'N'  as alt_ps  ,        
           'N'  as alt_pce  ,        
           'N'  as alt_quest ,        
           null  as id_cour  ,        
           null  as id_nat_cour ,        
           'N'  as alt_courgest ,        
           null  as id_i_db  ,        
           null  as id_courj ,        
           getdate() as cree_le  ,        
           getdate() as maj_le  ,        
   @sCodOper as maj_par  ,        
           null  as ordre_cheque ,        
           null  as num_let_cheque ,        
           a.id_bq as id_four  ,        
     'N'  as alt_suivi_mail,        
     NULL         as adr_mail,        
     null  as      alt_suivi_sms, -- #2[FNAC_PROD_ECH_TECH]        
     Null  as  num_port_sms, -- #2 [FNAC_PROD_ECH_TECH]        
 null as dte_naiss,  -- [PMO89_RS4822]    
 null as ville_naiss,  -- [PMO89_RS4822]    
 null as pays_naiss,  -- [PMO89_RS4822]    
 0 as cod_etat_ctrle_inter -- [PMO89_RS4822]    
 From        
    sysadm.agence a        
 Where        
       a.id_bq = 'SCG' And not exists        
          ( select * from sysadm.w_inter v         
             where         
                   v.id_sin     = @dcIdSin  and -- [PI062]        
                   v.cod_inter  = 'F'      and        
                   a.lib_ag     = v.nom    and        
            a.lib_ag     = v.nom    and        
            a.adr_1      = v.adr_1  and        
                   a.adr_cp = v.adr_cp and        
                   a.adr_ville = v.adr_ville )        
              
        
 Set @iRet = @@error        
        
 If @iRet <> 0        
           Begin        
             Select @sRetour = 'PS_I01_W_INTER:Erreur Création inter ScoreGames'         
             Return -1        
           End        
 Else        
           Begin        
             Set @iRet = 1        
           End        
        
   End        
-- Fin Modif #1 [PHG]        
           
If @sCodInter = 'T' And @iIdProd between 31500 and 31599 -- #4 Déclaration Aquazen : Création inter point de balance        
        
    Begin /* Déclaration Aquazen : Création inter point de balance            */        
            
 Set @iIdInter = 0        
        
 Select @iIdInter = Max( i.id_i ) From sysadm.w_inter i Where i.id_sin = @dcIdSin  -- [PI062]        
        
 Set @iIdInter = @iIdInter + 1        
   Set @iPointBalance = -1        
        
   If isnumeric( @sCodBq ) = 1 Set @iPointBalance = Convert ( integer,@sCodBq )        
        
        
 Insert into sysadm.w_inter         
 ( id_sin,id_i,cod_inter,cod_civ,nom,adr_1,adr_2,adr_cp,adr_ville,adr_att,num_teld,num_telb,num_fax,cod_mode_reg,rib_bq,rib_gui,rib_cpt,rib_cle,mt_a_reg,mt_reg,v_ref1,v_ref2,cod_ag,cod_bq,cpt_cour,cpt_valide,alt_valide,alt_part,alt_ps,alt_pce,alt_quest,id_cour,id_nat_cour,alt_courgest,id_i_db,id_courj,cree_le,maj_le,maj_par,ordre_cheque,num_let_cheque,id_four,alt_suivi_mail,adr_mail,alt_suivi_sms,num_port_sms,dte_naiss,ville_naiss,pays_naiss,cod_etat_ctrle_inter )        
 Select         
           @dcIdSin as id_sin  ,  -- [PI062]        
           @iIdInter as id_i  ,        
           'T'  as cod_inter ,        
           5  as cod_civ  ,        
           'Point de balance : ' + IsNull ( b.cod_mag, '(inconnu')  as nom  ,        
           b.adr_1 as adr_1  ,        
           b.adr_2 as adr_2  ,        
           b.adr_cp as adr_cp  ,        
           b.adr_ville as adr_ville ,        
           null  as adr_att  ,        
           null  as num_teld ,        
           null  as num_telb ,        
           null  as num_fax  ,        
           'VA'  as cod_mode_reg ,        
           b.rib_bq as rib_bq  ,        
           b.rib_gui as rib_gui  ,        
           b.rib_cpt as rib_cpt  ,        
           b.rib_cle as rib_cle  ,        
           0  as mt_a_reg ,        
           0  as mt_reg  ,        
           null  as v_ref1  ,        
           null  as v_ref2  ,        
           null  as cod_ag  ,        
           Convert ( VarChar ( 5 ), b.id_boutique, 5) as cod_bq  ,        
           0  as cpt_cour ,        
           0  as cpt_valide ,        
           'N'  as alt_valide ,        
           'N'  as alt_part ,        
           'N'  as alt_ps  ,        
           'N'  as alt_pce  ,        
           'N'  as alt_quest ,        
           null  as id_cour  ,        
           null  as id_nat_cour ,        
           'N'  as alt_courgest ,        
           null  as id_i_db  ,        
           null  as id_courj ,        
           getdate() as cree_le  ,        
           getdate() as maj_le  ,        
           @sCodOper as maj_par  ,        
           null  as ordre_cheque ,        
           null  as num_let_cheque ,        
           null  as id_four  ,        
   'N'  as alt_suivi_mail,        
    b.adr_mail   as adr_mail,        
    null  as      alt_suivi_sms, -- #2[FNAC_PROD_ECH_TECH]        
    Null  as  num_port_sms, -- #2 [FNAC_PROD_ECH_TECH]        
 null as dte_naiss,  -- [PMO89_RS4822]    
 null as ville_naiss,  -- [PMO89_RS4822]    
 null as pays_naiss,  -- [PMO89_RS4822]    
 0 as cod_etat_ctrle_inter -- [PMO89_RS4822]    
 From        
    sysadm.boutique b        
 Where        
    b.id_prod = @iIdProd         
       and b.id_boutique = @iPointBalance And @iPointBalance > 0         
    And not exists        
          ( select * from sysadm.w_inter v         
             where v.id_sin     = @dcIdSin  and  -- [PI062]        
                   v.cod_inter  = 'T'      and        
            Convert ( Integer, v.cod_bq ) = b.id_boutique         
     )        
        
 Set @iRet = @@error        
        
   If @iRet <> 0        
      Begin        
         Select @sRetour = 'PS_I01_W_INTER:Erreur Création inter Aquazen'         
         Return -1        
      End        
   Else        
      Begin        
         Set @iRet = 1        
      End        
    /*------------------------------------------------------------------*/        
End /* Déclaration Aquazen : Création inter point de balance            */        
    /*------------------------------------------------------------------*/        
        
        
 -- [PC478]        
 If @iIdProd between 42500 and 42599        
        
    /*------------------------------------------------------------------*/        
   Begin /* Déclaration SPDE : Création SPDE dans w_inter                       */        
         /*------------------------------------------------------------------*/        
        
 Set @iIdInter = 0        
        
 Select @iIdInter = Max( i.id_i ) From sysadm.w_inter i Where i.id_sin = @dcIdSin        
        
 Set @iIdInter = @iIdInter + 1        
        
 Insert into sysadm.w_inter         
 ( id_sin,id_i,cod_inter,cod_civ,nom,adr_1,adr_2,adr_cp,adr_ville,cod_mode_reg,mt_a_reg,mt_reg,cpt_cour,cpt_valide,alt_valide,alt_part,alt_ps,alt_pce,alt_quest,alt_courgest,cree_le,maj_le,maj_par,id_four,alt_suivi_mail,adr_mail,alt_suivi_sms,num_port_sms,dte_naiss,ville_naiss,pays_naiss,cod_etat_ctrle_inter )        
 Select         
           @dcIdSin as id_sin  ,  -- [PI062]        
           @iIdInter as id_i  ,        
           'T'  as cod_inter ,        
           5  as cod_civ  ,        
           a.lib_ag as nom  ,        
           a.adr_1 as adr_1  ,        
           a.adr_2 as adr_2  ,        
           a.adr_cp as adr_cp  ,        
           a.adr_ville as adr_ville ,        
           'C'  as cod_mode_reg ,        
     0  as mt_a_reg ,        
           0  as mt_reg  ,        
           0  as cpt_cour ,        
           0  as cpt_valide ,        
           'N'  as alt_valide ,        
           'N'  as alt_part ,        
           'N'  as alt_ps  ,        
           'N'  as alt_pce  ,        
     'N'  as alt_quest ,        
           'N'  as alt_courgest ,        
           getdate() as cree_le  ,        
           getdate() as maj_le  ,        
           @sCodOper as maj_par  ,        
           a.id_bq as id_four  ,        
     'N'  as alt_suivi_mail,     
    NULL as adr_mail,    
 NULL as alt_suivi_sms,    
    Null  as  num_port_sms, -- #2 [FNAC_PROD_ECH_TECH]        
 null as dte_naiss,  -- [PMO89_RS4822]    
 null as ville_naiss,  -- [PMO89_RS4822]    
 null as pays_naiss,  -- [PMO89_RS4822]    
 0 as cod_etat_ctrle_inter -- [PMO89_RS4822]           
 From        
    sysadm.agence a        
 Where        
       a.id_bq = 'SPD' And not exists        
          ( select * from sysadm.w_inter v         
             where         
                   v.id_sin     = @iIdSin  and        
                   v.cod_inter  = 'T'      and        
                   a.lib_ag     = v.nom    and        
            a.adr_1      = v.adr_1  and        
                   a.adr_cp = v.adr_cp and        
                   a.adr_ville = v.adr_ville )        
                    
        
 Set @iRet = @@error        
        
 If @iRet <> 0        
           Begin        
             Select @sRetour = 'PS_I01_W_INTER:Erreur Création inter SPDE'         
             Return -1        
           End        
 Else        
           Begin        
             Set @iRet = 1        
           End        
        
   End        
   -- Fin [PC478]        
           
        
/*------------------------------------------------------------------*/        
/* [Vdoc15313] Cdiscoun Sérénité (817) Création interlocuteur CDS   */        
/*------------------------------------------------------------------*/        
        
If @iIdProd between 81700 and 81799  --  Cdiscount Sérénité (817) : Création d'un interlocuteur CDS        
        
Begin -- Début 817         
        
 Set @iIdInter = 0        
 Select @iIdInter = Max( i.id_i ) From sysadm.w_inter i Where i.id_sin = @dcIdSin   -- [PI062]        
 Set @iIdInter = @iIdInter + 1        
        
 Insert into sysadm.w_inter         
 ( id_sin,id_i,cod_inter,cod_civ,nom,adr_1,adr_2,adr_cp,adr_ville,adr_att,num_teld,num_telb,num_fax,cod_mode_reg,rib_bq,rib_gui,rib_cpt,rib_cle,mt_a_reg,mt_reg,v_ref1,v_ref2,cod_ag,cod_bq,cpt_cour,cpt_valide,alt_valide,alt_part,alt_ps,alt_pce,alt_quest,id_cour,id_nat_cour,alt_courgest,id_i_db,id_courj,cree_le,maj_le,maj_par,ordre_cheque,num_let_cheque,id_four,alt_suivi_mail,adr_mail,alt_suivi_sms,num_port_sms,dte_naiss,ville_naiss,pays_naiss,cod_etat_ctrle_inter )        
 Select         
           @dcIdSin as id_sin  ,  -- [PI062]        
           @iIdInter as id_i  ,        
           'F'  as cod_inter ,        
           5  as cod_civ  ,        
           a.lib_ag as nom  ,        
           a.adr_1 as adr_1  ,        
           a.adr_2 as adr_2  ,        
           a.adr_cp as adr_cp  ,        
           a.adr_ville as adr_ville ,        
           null  as adr_att  ,        
           null  as num_teld ,        
           null  as num_telb ,        
           null  as num_fax  ,        
           'FM'  as cod_mode_reg ,        
           null  as rib_bq  ,        
           null  as rib_gui  ,        
           null  as rib_cpt  ,        
           null  as rib_cle  ,        
           0  as mt_a_reg ,        
           0  as mt_reg  ,        
           null  as v_ref1  ,        
         null  as v_ref2  ,        
           null  as cod_ag  ,        
           null  as cod_bq  ,        
           0  as cpt_cour ,        
           0  as cpt_valide , -- #4 0 ald 1        
           'N'  as alt_valide ,        
           'N'  as alt_part ,        
           'N'  as alt_ps  ,        
           'N'  as alt_pce  ,        
           'N'  as alt_quest ,        
           null  as id_cour  ,        
           null  as id_nat_cour ,        
           'N'  as alt_courgest ,        
           null  as id_i_db  ,        
           null  as id_courj ,        
           getdate() as cree_le  ,        
           getdate() as maj_le  ,        
           @sCodOper as maj_par  ,        
           null  as ordre_cheque ,        
           null  as num_let_cheque ,        
           a.id_bq as id_four  ,        
     'N'  as alt_suivi_mail,        
     NULL     as adr_mail,        
        null  as  alt_suivi_sms,         
        Null  as  num_port_sms,    
 null as dte_naiss,  -- [PMO89_RS4822]    
 null as ville_naiss,  -- [PMO89_RS4822]    
 null as pays_naiss,  -- [PMO89_RS4822]    
 0 as cod_etat_ctrle_inter -- [PMO89_RS4822]      
           
 From        
    sysadm.agence a        
 Where        
       a.id_bq = 'CDS' And not exists        
          ( select * from sysadm.w_inter v         
             where         
               v.id_sin     = @dcIdSin  and  -- [PI062]        
               v.cod_inter  = 'F'      and        
               a.lib_ag     = v.nom    and        
            a.lib_ag     = v.nom    and        
            a.adr_1      = v.adr_1  and        
               a.adr_cp  = v.adr_cp and        
               a.adr_ville = v.adr_ville )        
 Set @iRet = @@error        
        
 If @iRet <> 0        
  Begin        
   Set @sRetour = 'PS_I01_W_INTER:Erreur Création inter Cdiscount'         
   Return -1        
  End        
 Else        
  Begin        
   Set @iRet = 1        
  End        
          
End -- Fin 817        
        
        
        
 -- [PC13174]        
 -- [ITSM244603] Correction bug : création uniquement à la premiere passe : @sCodInter = 'A'         
 -- [ITSM297903] On prend IPA        
If @iIdProd in (select id_prod from sysadm.det_pro where id_code_dp=264) And @sCodInter = 'B'         
        
         /*-------------------------------------------------*/        
   Begin /* Création AXA-IPA dans w_inter                       */        
         /*-------------------------------------------------*/        
        
 Set @iIdInter = 0        
        
 Select @iIdInter = Max( i.id_i ) From sysadm.w_inter i Where i.id_sin = @dcIdSin  -- [PI062]        
        
 Set @iIdInter = @iIdInter + 1        
        
        
 Insert into sysadm.w_inter         
 ( id_sin,id_i,cod_inter,cod_civ,nom,adr_1,adr_2,adr_cp,adr_ville,cod_mode_reg,mt_a_reg,mt_reg,cpt_cour,cpt_valide,alt_valide,alt_part,alt_ps,alt_pce,alt_quest,alt_courgest,cree_le,maj_le,maj_par,id_four,alt_suivi_mail,adr_mail,alt_suivi_sms,num_port_sms,dte_naiss,ville_naiss,pays_naiss,cod_etat_ctrle_inter )        
         
 Select         
           @dcIdSin as id_sin  ,  -- [PI062]        
           @iIdInter as id_i  ,        
           'F'  as cod_inter ,        
           5  as cod_civ  ,        
           a.lib_ag as nom  ,        
           a.adr_1 as adr_1  ,        
           a.adr_2 as adr_2  ,        
           a.adr_cp as adr_cp  ,        
           a.adr_ville as adr_ville ,        
           'FM'  as cod_mode_reg ,        
           0  as mt_a_reg ,        
           0  as mt_reg  ,        
          0  as cpt_cour ,        
           0  as cpt_valide ,        
           'N'  as alt_valide ,        
           'N'  as alt_part ,        
           'N'  as alt_ps  ,        
           'N'  as alt_pce  ,        
           'N'  as alt_quest ,        
           'N'  as alt_courgest ,        
           getdate() as cree_le  ,        
           getdate() as maj_le  ,        
           @sCodOper as maj_par  ,        
           a.id_bq as id_four  ,        
   'N'  as alt_suivi_mail  ,        
    NULL as adr_mail,    
 NULL as alt_suivi_sms,    
 Null  as  num_port_sms, -- #2 [FNAC_PROD_ECH_TECH]        
 null as dte_naiss,  -- [PMO89_RS4822]    
 null as ville_naiss,  -- [PMO89_RS4822]    
 null as pays_naiss,  -- [PMO89_RS4822]    
 0 as cod_etat_ctrle_inter -- [PMO89_RS4822]         
 From        
    sysadm.agence a        
 Where        
       a.id_bq = 'IPA' And not exists        
          ( select * from sysadm.w_inter v         
             where         
                   v.id_sin     = @dcIdSin  and  -- [PI062]        
                   v.cod_inter  = 'F'      and        
                   a.lib_ag     = v.nom    and        
       a.adr_1      = v.adr_1  and        
                   a.adr_cp = v.adr_cp and        
                   a.adr_ville = v.adr_ville )        
          
 Set @iRet = @@error        
        
 If @iRet <> 0        
           Begin        
             Select @sRetour = 'PS_I01_W_INTER:Erreur Création inter AXA'         
       Return -1        
     End        
 Else        
           Begin        
             Set @iRet = 1        
           End        
        
   End        
   -- Fin [PC13174]        
           
-- [VDOC16954] Interlocuteir         
If ( @iIdProd between 32200 and 32299 ) Or ( @iIdProd between 67100 and 67199)    
Begin        
        
 Set    @iIdInter = 0        
 Select @iIdInter = Max( i.id_i ) From sysadm.w_inter i Where i.id_sin = @dcIdSin  -- [PI062]        
 Set    @iIdInter = @iIdInter + 1        
        
  INSERT INTO    sysadm.w_inter        
  (   w_inter.id_sin,        
   w_inter.id_i,        
   w_inter.cod_inter,        
   w_inter.cod_civ,        
   w_inter.nom,        
   w_inter.adr_1,        
   w_inter.adr_2,        
   w_inter.adr_cp,        
   w_inter.adr_ville,        
   w_inter.adr_att,        
   w_inter.num_teld,        
   w_inter.num_telb,        
   w_inter.num_fax,        
   w_inter.cod_mode_reg,        
   w_inter.rib_bq,        
   w_inter.rib_gui,        
   w_inter.rib_cpt,        
   w_inter.rib_cle,        
   w_inter.mt_a_reg,        
   w_inter.mt_reg,        
   w_inter.v_ref1,        
   w_inter.v_ref2,        
   w_inter.cod_ag,        
   w_inter.cod_bq,        
   w_inter.cpt_cour,        
   w_inter.alt_valide,        
   w_inter.cpt_valide,        
   w_inter.alt_part,        
   w_inter.alt_ps,        
   w_inter.alt_pce,        
   w_inter.alt_quest,        
   w_inter.id_cour,        
   w_inter.id_nat_cour,        
   w_inter.alt_courgest,        
   w_inter.id_i_db,        
   w_inter.id_courj,        
   w_inter.cree_le,        
   w_inter.maj_le,        
   w_inter.maj_par,        
   w_inter.ordre_cheque,        
            w_inter.num_let_cheque,        
   w_inter.id_four,        
   w_inter.alt_suivi_mail,        
   w_inter.adr_mail,         
   w_inter.alt_suivi_sms,        
   w_inter.num_port_sms,    
   w_inter.dte_naiss,  -- [PMO89_RS4822]    
   w_inter.ville_naiss,  -- [PMO89_RS4822]    
   w_inter.pays_naiss,  -- [PMO89_RS4822]    
   w_inter.cod_etat_ctrle_inter  -- [PMO89_RS4822]    
   )        
           
  Select            
    @dcIdSin,  -- [PI062]        
   @iIdInter,        
   'B',        
   '5',        
   lib_ag,        
   adr_1,        
   adr_2,        
   adr_cp,        
   adr_ville,        
   NULL,        
   NULL,        
   NULL,        
   NULL,        
   NULL,        
   NULL,        
   NULL,        
   NULL,        
   NULL,        
   0.00,        
   0.00,        
   NULL,        
   NULL,        
   id_bq,        
   id_ag,        
   0,        
   'O',        
   0,        
  'N',        
   'N',        
   'N',        
   'N',        
   NULL,        
   NULL,        
   'N',        
   NULL,        
   NULL,        
   getdate(),        
   getdate(),        
   @sCodOper,        
   NULL,        
   NULL,        
   NULL,        
   'N',        
   NULL,        
   NULL,         
   NULL,    
 null as dte_naiss,  -- [PMO89_RS4822]    
 null as ville_naiss,  -- [PMO89_RS4822]    
 null as pays_naiss,  -- [PMO89_RS4822]    
 0 as cod_etat_ctrle_inter -- [PMO89_RS4822]       
           
 From sysadm.agence         
 Where id_bq = '99999'        
 And   id_ag = '99990' And not exists        
  ( select * from sysadm.w_inter v         
   where         
   v.id_sin        = @dcIdSin  and  -- [PI062]        
   v.cod_inter     = 'B'      and        
   agence.lib_ag   = v.nom    and        
   agence.adr_1    = v.adr_1  and        
   agence.adr_cp = v.adr_cp   and        
   agence.adr_ville= v.adr_ville )        
          
 Set @iRet = @@error        
        
 If @iRet <> 0        
 Begin        
  Select @sRetour = 'PS_I01_W_INTER:Erreur Création inter ONEY BANQUE ACCORD'         
  Return -1        
 End        
 Else        
  Begin        
  Set @iRet = 1        
 End        
        
End         
        
-- Création Inter type Autre "T" "en masse" :)        
-- [PM421-5]      
-- [VDOC30089] J'y ajoute les Banques mais sans création de l'inter Banque (que je laisse à Fred plus),       
-- C'est uniquement pour aller mettre une adresse mail en auto sur l'inter banque.      
Select @dcIdInterMax = Max( i.id_i ) From sysadm.w_inter i Where i.id_sin = @dcIdSin          
If @dcIdInterMax is null Set @dcIdInterMax = 1 -- Pas 0, réservé à l'inter A, on mets 1 pour que le 1+1 donne 2 pour le 1ère inter T        
If @dcIdInterMax < 2 Set @dcIdInterMax = 1 -- Car Fred pour le B mets toujours 1 en dur, donc cette ligne évite que ça pète en duplicate key.      
  
If sysadm.FN_CLE_NUMERIQUE ( 'MCO174_INT_AUTO_AXAB') > 0   
 Begin        
  Insert into sysadm.w_inter        
  Select         
  @dcIdSin id_sin,        
  @dcIdInterMax + row_number() over (partition by ia.id_prod order by ia.id_cle ) id_i,        
  ia.cod_inter,        
  ia.cod_civ,        
  ia.nom,        
  ia.adr_1,        
  ia.adr_2,        
  ia.adr_cp,        
  ia.adr_ville,        
  NULL adr_att,        
  NULL num_teld,        
  NULL num_telb,        
  NULL num_fax,        
  ia.cod_mode_reg, -- [PMO268_MIG25]
  ia.rib_bq, -- [PMO268_MIG25]
  ia.rib_gui, -- [PMO268_MIG25]
  ia.rib_cpt, -- [PMO268_MIG25]        
  ia.rib_cle, -- [PMO268_MIG25]
  0 mt_a_reg,        
  0 mt_reg,        
  NULL v_ref1,        
  NULL v_ref2,        
  NULL cod_ag,        
  NULL cod_bq,        
  0 cpt_cour,        
  0 cpt_valide,        
  'O' alt_valide,        
  'N' alt_part,        
  'N' alt_ps,        
  'N' alt_pce,        
  'N' alt_quest,        
  NULL id_cour,        
  NULL id_nat_cour,        
  'N' alt_courgest,        
  NULL id_i_db,        
  NULL id_courj,        
  getdate() cree_le,        
  getdate() maj_le,        
  @sCodOper maj_par,        
  NULL ordre_cheque,        
  NULL num_let_cheque,        
  NULL id_four,        
  'O' alt_suivi_mail,        
  IIF ( CharIndex ( ',', ia.adr_mail, 1) > 0, left ( rtrim ( ltrim ( ia.adr_mail )), CharIndex ( ',', ia.adr_mail, 1) - 1 ), rtrim ( ltrim ( ia.adr_mail )) )  adr_mail,  -- [VDOC29600]         
  NULL  alt_suivi_sms,        
  NULL   num_port_sms,    
  null as dte_naiss,  -- [PMO89_RS4822]    
  null as ville_naiss,  -- [PMO89_RS4822]    
  null as pays_naiss,  -- [PMO89_RS4822]    
  0 as cod_etat_ctrle_inter -- [PMO89_RS4822]    
        
  From sysadm.inter_auto ia        
  Where ia.id_prod = @dcIdProd     
  And   nom <> '[PAS_DE_CREATION]'  
  -- And   ia.cod_inter <> 'B'  -- [VDOC30089]-- [MCO174_INT_AUTO_AXAB]  
  And   Not Exists (         
		  Select Top 1 1         
		  From   sysadm.w_inter wi        
		  Where  wi.id_sin = @dcIdSin        
		  And    Upper ( wi.cod_inter ) = Upper ( rtrim ( ltrim ( ia.cod_inter )))  
		  And    Upper ( wi.nom ) = Upper ( rtrim ( ltrim (ia.nom )))  
		  And    Upper ( wi.adr_1 ) = Upper ( rtrim ( ltrim (ia.adr_1 )))  
		  And    Upper ( wi.adr_cp ) = Upper ( rtrim ( ltrim (ia.adr_cp )))  
		  And    Upper ( wi.adr_ville ) = Upper ( rtrim ( ltrim (ia.adr_ville )))  
  )        
  
  -- [VDOC30089] forçcage d'adresse mail sur inter Banque.      
  Update sysadm.w_inter_encrypt       
  Set adr_mail = ltrim ( rtrim( ia.adr_mail))      
  From sysadm.w_inter_encrypt wi,      
   sysadm.inter_auto ia      
  Where  ia.id_prod = @dcIdProd      
  And    ia.cod_inter = 'B' -- [VDOC30089]      
  And    ia.nom = '[PAS_DE_CREATION]' -- [MCO174_INT_AUTO_AXAB]  
  And    ia.adr_mail is not null      
  And    wi.id_sin =  @dcIdSin      
  And    wi.cod_inter = ia.cod_inter        
  
 End  
Else   
 Begin  
  Insert into sysadm.w_inter        
  Select         
  @dcIdSin id_sin,        
  @dcIdInterMax + row_number() over (partition by ia.id_prod order by ia.id_cle ) id_i,        
  ia.cod_inter,        
  ia.cod_civ,        
  ia.nom,        
  ia.adr_1,        
  ia.adr_2,        
  ia.adr_cp,        
  ia.adr_ville,        
  NULL adr_att,        
  NULL num_teld,        
  NULL num_telb,        
  NULL num_fax,        
  NULL cod_mode_reg,        
  NULL rib_bq,        
  NULL rib_gui,        
  NULL rib_cpt,        
  NULL rib_cle,        
  0 mt_a_reg,        
  0 mt_reg,        
  NULL v_ref1,        
  NULL v_ref2,        
  NULL cod_ag,        
  NULL cod_bq,        
  0 cpt_cour,        
  0 cpt_valide,        
  'O' alt_valide,        
  'N' alt_part,        
  'N' alt_ps,        
  'N' alt_pce,        
  'N' alt_quest,        
  NULL id_cour,        
  NULL id_nat_cour,        
  'N' alt_courgest,        
  NULL id_i_db,        
  NULL id_courj,        
  getdate() cree_le,        
  getdate() maj_le,        
  @sCodOper maj_par,        
  NULL ordre_cheque,        
  NULL num_let_cheque,        
  NULL id_four,        
  'O' alt_suivi_mail,        
  IIF ( CharIndex ( ',', ia.adr_mail, 1) > 0, left ( rtrim ( ltrim ( ia.adr_mail )), CharIndex ( ',', ia.adr_mail, 1) - 1 ), rtrim ( ltrim ( ia.adr_mail )) )  adr_mail,  -- [VDOC29600]         
  NULL  alt_suivi_sms,        
  NULL   num_port_sms,    
  null as dte_naiss,  -- [PMO89_RS4822]    
  null as ville_naiss,  -- [PMO89_RS4822]    
  null as pays_naiss,  -- [PMO89_RS4822]    
  0 as cod_etat_ctrle_inter -- [PMO89_RS4822]    
        
  From sysadm.inter_auto ia        
  Where ia.id_prod = @dcIdProd        
  And   ia.cod_inter <> 'B' -- [VDOC30089]      
  And   Not Exists (         
  Select Top 1 1         
  From   sysadm.w_inter wi        
  Where  wi.id_sin = @dcIdSin        
  And    wi.cod_inter = ia.cod_inter        
  And    wi.nom = ia.nom        
  And    wi.adr_1 = ia.adr_1        
  And    wi.adr_cp = ia.adr_cp        
  And    wi.adr_ville = ia.adr_ville        
  )        
  
  -- [VDOC30089] forçcage d'adresse mail sur inter Banque.      
  Update sysadm.w_inter_encrypt       
  Set adr_mail = ltrim ( rtrim( ia.adr_mail))      
  From sysadm.w_inter_encrypt wi,      
   sysadm.inter_auto ia      
  Where  ia.id_prod = @dcIdProd      
  And    ia.cod_inter = 'B' -- [VDOC30089]      
  And    ia.adr_mail is not null      
  And    wi.id_sin =  @dcIdSin      
  And    wi.cod_inter = ia.cod_inter        
 End   
 
       
Return @iRet        
  
Go
  
grant execute on sysadm.PS_I01_W_INTER_V02 to rolebddsinistres
Go



--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_OPER_PROD
-- Auteur               :       FS
-- Date                 :       22/02/2002
-- Libellé              :        
-- Commentaires         :       Selection de corb_oper
--				
-- Références           :       Sherpa : Gestion des affectations produits/op‚rateur
--  
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_OPER_PROD' AND type = 'P' )
        DROP procedure sysadm.DW_S01_OPER_PROD
GO

/*-------------------------------------------------------------------
[DATABASE] SIMPA2_PRO
[DESCRIPTION] 
[MAJ PAR] DATAFLY - AFX
[DATEMAJ] 15/10/2009

[VARIABLES]
    non
-------------------------------------------------------------------*/
CREATE PROCEDURE [sysadm].[DW_S01_OPER_PROD]
AS 
    SELECT  2 AS id_appli,
            c.id_oper AS id_oper,
            CONVERT (INTEGER, c.id_corb) AS id_corb,
            CONVERT (INTEGER, p.id_prod) AS id_prod,
            CONVERT (VARCHAR(71), NULL) AS nom
    FROM    sysadm.corb_oper as c,
            sysadm.produit p
    WHERE   c.id_corb = p.id_corb
    ORDER BY c.id_oper,
            p.id_prod

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_INFO_SIN / DW_S02_INFO_SIN
-- Auteur               :       PLJ
-- Date                 :       25/03/2002
-- Libellé              :        
-- Commentaires         :       Compl‚ment d'info sur liste sinistre
--				
-- Références           :       d_stk_sh_info_sin
--  
--
-- Retourne             :       Attention cette PS peut retourn‚ plusieurs lignes
--
-------------------------------------------------------------------
-- #1 FS le 02/12/2002 : utilisation @dcIdSin ald @iIdSin
-- #2 FS le 20/08/2003 : Ajout des informations code_etat et lib_etat du sinistre
--                       La procédure DW_S01_INFO_SIN devient DW_S02_INFO_SIN
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_INFO_SIN' AND type = 'P' )
        DROP procedure sysadm.DW_S02_INFO_SIN
GO

CREATE procedure sysadm.DW_S02_INFO_SIN
	@iIdSin		Decimal(10,0)   -- [PI062]
AS

DECLARE	@iNbLigne 	integer
DECLARE	@iNbGarSin 	integer

Declare @dcIdSin        Decimal(10,0)   -- [PI062]   

Select @dcIdSin = Convert ( Decimal(10,0), @iIdSin )  -- [PI062]   

/*---------------------------------------------------------------*/
/* Je regarde si le sinistre est pr‚sent dans sinistre dans  ce  */
/* cas je ramŠne les informations de la table sinistre sinon je  */
/* ramŠne les informations de la table w_sin.                    */
/*---------------------------------------------------------------*/

SELECT  @iNbLigne = count(id_sin) 
  FROM  sysadm.sinistre
 WHERE  id_sin = @dcIdSin


IF @iNbLigne > 0 
   begin
	SELECT	sinistre.dte_surv,
		convert ( varchar(7), gar_sin.id_gti ),
		code_etat.lib_code		as lib_etat,
		code_nat_sin.lib_code		as lib_nat_sin,
		sinistre.maj_le,
		sinistre.maj_par,
		sinistre.id_ordre,
		routage.dos_suivi_par,
		sinistre.alt_ssui,
		routage.alt_queue,
		routage.cod_travail,
                Convert ( Varchar(4), sinistre.cod_etat )     as cod_etat_sin,
                code_etat_sin.lib_code          as lib_etat_sin

  	  FROM	sysadm.sinistre, sysadm.gar_sin, sysadm.code as code_etat, sysadm.code as code_nat_sin, sysadm.routage, sysadm.code as code_etat_sin

	 WHERE	sinistre.id_sin			= @dcIdSin		AND

		gar_sin.id_sin			= sinistre.id_sin	AND

		sinistre.id_sin			= routage.id_sin	AND

		code_etat.id_code		= gar_sin.cod_etat	AND
		code_etat.id_typ_code		= '-ET'			AND

		code_etat_sin.id_code           = sinistre.cod_etat     AND
		code_etat_sin.id_typ_code	= '-ET'			AND                 

		code_nat_sin.id_code		= sinistre.id_natsin	AND	
		code_nat_sin.id_typ_code	= '+NS'
   end

ELSE

   begin

	SELECT	@iNbGarSin = count(id_sin) 
  	  FROM  sysadm.w_gar_sin
 	 WHERE  id_sin = @dcIdSin

	IF @iNbGarSin = 0
	   begin

		SELECT	w_sin.dte_surv,
			null,
			null,
			code_nat_sin.lib_code		as lib_nat_sin,
			w_sin.maj_le,
			w_sin.maj_par,
			w_sin.id_ordre,
			routage.dos_suivi_par,
			w_sin.alt_ssui,
			routage.alt_queue,
			routage.cod_travail,
                        Convert ( Varchar(4), w_sin.cod_etat )    as cod_etat_sin,
                        code_etat_sin.lib_code           as lib_etat_sin

		 FROM	sysadm.w_sin, sysadm.code as code_nat_sin, sysadm.routage, sysadm.code as code_etat_sin	

		 WHERE	w_sin.id_sin			= @dcIdSin		AND

			w_sin.id_sin			= routage.id_sin	AND

  		        code_etat_sin.id_code           = w_sin.cod_etat        AND
		        code_etat_sin.id_typ_code	= '-ET'			AND 

			code_nat_sin.id_code		= w_sin.id_natsin	AND	
			code_nat_sin.id_typ_code	= '+NS'


	   end

	ELSE
	   begin

		SELECT	w_sin.dte_surv,
			convert ( varchar(7), w_gar_sin.id_gti ),
			code_etat.lib_code		as lib_etat,
			code_nat_sin.lib_code		as lib_nat_sin,
			w_sin.maj_le,
			w_sin.maj_par,
			w_sin.id_ordre,
			routage.dos_suivi_par,
			w_sin.alt_ssui,
			routage.alt_queue,
			routage.cod_travail,
                        Convert ( Varchar(4), w_sin.cod_etat )  as cod_etat_sin,
                        code_etat_sin.lib_code           as lib_etat_sin

		 FROM	sysadm.w_sin, sysadm.w_gar_sin, sysadm.code as code_etat, sysadm.code as code_nat_sin, sysadm.routage, sysadm.code as code_etat_sin	

		 WHERE	w_sin.id_sin			= @dcIdSin		AND

			w_gar_sin.id_sin		= w_sin.id_sin		AND

			w_sin.id_sin			= routage.id_sin	AND

			code_etat.id_code		= w_gar_sin.cod_etat	AND
			code_etat.id_typ_code		= '-ET'			AND

  		        code_etat_sin.id_code           = w_sin.cod_etat        AND
		        code_etat_sin.id_typ_code	= '-ET'			AND 

			code_nat_sin.id_code		= w_sin.id_natsin	AND	
			code_nat_sin.id_typ_code	= '+NS'

	   end
   end

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_INFO_SUIVI
-- Auteur               :       FS
-- Date                 :       06/01/2003
-- Libellé              :       Information pour suivi d'activit‚ 
-- Commentaires         :       ( s‚lection des actes de gestion effectu‚s )
--				
-- Références           :       
--  
--
-- Retourne             :       Attention cette PS peut retourn‚ plusieurs lignes
--
-------------------------------------------------------------------
-- #1 Fs le 10/02/2003 : @sCodTable = 'P' si plus de travail de maniŠre … v‚rifier aussi dans
--                       les tables permanentes
-- #2 FS le 12/02/2003 : Suite r‚union DBI modifs diverses voir #2 dans le code
-- #3 FS le 17/02/2003 : M‚mo BH du 17/02/03 correction pb jointure sur d‚termination refus
-- #4 FS le 26/03/2003 : M‚mo N.Guerin du 19/03/03 Correction pb si commande non valid‚e
-- #5 FS le 26/03/2003 : M‚mo VGU dy 12/03/03 : Correction pb si demande pce sur 1 d‚tail
-- #5 FS le 17/04/2003 : Demande CVE du 27/03/03 : Comptabiliser les questionnaires … part
-- #6 FS le 30/04/2003 : M‚mo NPIC du 29/04/03 : Modif sur v‚rification des commandes
-- #7 FS le 02/05/2003 : M‚mo VGU du 02/05/03  : V‚rif des refus dans le cas d'un dossier directement valid‚
-- #8 FS le 27/05/2003 : Tel Nadine Vautier    : Les refus de d‚tail ne sont pas compt‚ Attente confirmation
-- #9 FS le 18/10/2005 : Correction passage des références sinistres sur 7 positions
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_INFO_SUIVI' AND type = 'P' )
        DROP procedure sysadm.PS_S01_INFO_SUIVI
GO


CREATE procedure sysadm.PS_S01_INFO_SUIVI
@dcIdSin    Decimal(10,0)  -- [PI062]

AS

Declare @sAltPce    Char(1)
Declare @sAltReg    Char(1)
Declare @sAltRef    Char(1)
Declare @sAltCde    Char(1)
Declare @sAltAucune Char(1)
Declare @sAltAccuse Char(1)
Declare @sAltCour   Char(1)
Declare @sAltPart   Char(1)
Declare @sAltQuest  Char(1)
Declare @sCodTable  Char(1)
Declare @sCodEtat   Char(1)
Declare @sAltOcc    Char(1)
Declare @sAltValid  Char(1)
Declare @iNb        Integer
Declare @sDate      Char(10)
Declare @dtDate     Datetime


Select @sAltPce    = 'N'  /* Flag de demande de piŠce     */
Select @sAltQuest  = 'N'  /* Flag de questionnaire        */
Select @sAltReg    = 'N'  /* Flag de r‚glement            */
Select @sAltRef    = 'N'  /* Flag de refus                */
Select @sAltCde    = 'N'  /* Flag de commande             */
Select @sAltAucune = 'N'  /* Flag aucune action           */
Select @sAltAccuse = 'N'  /* Flag accus‚ r‚ception        */
Select @sAltCour   = 'N'  /* Flag de courrier normal      */
Select @sAltPart   = 'N'  /* Flag de courrier particulier */
Select @sAltValid  = 'N'  /* Flag dossier valid‚ O/N      */
Select @sCodTable  = 'W'  /* Flag base instruction W / permanente P */

Select @iNb = 0

/*------------------------------------------------------------------*/
/* Code base permanente 'P' / base instruction 'W'                  */
/*------------------------------------------------------------------*/

Select @iNb = Count(*) FROM sysadm.w_sin WHERE id_sin = @dcIdSin

If @iNb = 0 Select @sCodTable = 'P'

/*------------------------------------------------------------------*/
/* V‚rification si le dossier vient d'ˆtre valid‚                   */
/*  - Sortie en erreur si travail encore occup‚                     */
/*  - Sortie 'Aucune action' si travail en ‚tat '1'                 */
/*------------------------------------------------------------------*/

  SELECT @sAltOcc  = alt_occupe,
         @sCodEtat = cod_etat 
    FROM
         sysadm.w_queue 
   WHERE id_sin = Convert( varchar(10), @dcIdSin ) -- [PI062]

  Select @iNb = @@rowcount

  If @sAltOcc = 'O' Return -1  

  If @iNb = 0 Select @sCodTable = 'P' /* #1 Plus de travail = Recherche aussi dans la partie permanente */

/*------------------------------------------------------------------*/
/* Courrier                                                         */
/*  S‚paration courrier normal / courrier particulier               */
/*                                                                  */
/* Dans le cas ou le dossier est en base permanente : Les flag de   */
/* courriers @sAltCour / @sAltPart seront toujours … 'N'            */
/* ( dans ce cas pas d'‚dition )                                    */
/*------------------------------------------------------------------*/
/* #2 Ce code … ‚t‚ d‚plac‚ en d‚but car les flags courriers sont   */
/*    utilis‚s pour d‚terminer l'‚tat en demande de piŠce           */
/*------------------------------------------------------------------*/

  SELECT @iNb = Count(*) FROM sysadm.w_courrier WHERE id_sin = @dcIdSin And alt_part ='N' And alt_pce = 'N' And alt_ps = 'N'

  If @iNb > 0 Select @sAltCour = 'O'

  SELECT @iNb = Count(*) FROM sysadm.w_courrier WHERE id_sin = @dcIdSin And ( alt_part ='O' Or alt_pce = 'O' Or alt_ps = 'O' )

  If @iNb > 0 Select @sAltPart = 'O'

/*------------------------------------------------------------------*/
/* Demande de piŠce                                                 */
/*   - Soit une piŠce est coch‚e                                    */
/*   - Soit une garantie est en ‚tat 100 'En cours d'instruction'   */
/*                                                                  */
/* Dans le cas ou le dossier est en base permanente : Le flag des   */
/* pieces @sAltPce sera toujours … 'N'                              */
/*------------------------------------------------------------------*/
/* #2 Je comptabilise les piŠces uniquement pour gti en instruction */
/*    ( Etat 100 ) avec des piŠces coch‚es                          */
/*    ( Etat 100 ) sans piŠce coch‚e mais avec courrier envoy‚      */
/*------------------------------------------------------------------*/

  /* #2 : PiŠces coch‚es pour garantie en instruction */

  SELECT @iNb = Count(*) FROM sysadm.w_piece wp,
                              sysadm.w_gar_sin wg
                        WHERE
                              wp.id_sin   = wg.id_sin And
                              wp.id_gti   = wg.id_gti And
                              wg.cod_etat = 100       And
                              wp.id_sin   = @dcIdSin

  If @iNb > 0 Select @sAltPce = 'O'

  /* #5 : PiŠces coch‚es sur un d‚tail                */

  SELECT @iNb = Count(*) FROM sysadm.w_piece  wp,
                              sysadm.w_detail wd
                        WHERE
                              wp.id_sin   = wd.id_sin    And
                              wp.id_gti   = wd.id_gti    And
                              wp.id_detail= wd.id_detail And
                              wd.cod_etat = 100          And
                              wp.id_sin   = @dcIdSin

  If @iNb > 0 Select @sAltPce = 'O'


  /* #2 : Garantie en instruction SANS piŠces coch‚es */

  SELECT @iNb = Count(*)
    FROM sysadm.w_gar_sin wg 
   WHERE
         id_sin   = @dcIdSin And 
         cod_etat = 100      And
         Not Exists ( SELECT * FROM w_piece wp WHERE wg.id_sin = wp.id_sin and
                                                     wg.id_gti = wp.id_sin )

  
  If @iNb > 0 And ( @sAltCour = 'O' Or @sAltPart = 'O' ) Select @sAltPce = 'O'

/*------------------------------------------------------------------*/
/* Questionnaire                                                    */
/*  - Dossier en dem de piŠce + Q pr‚sent sur Inter                */
/*------------------------------------------------------------------*/

SELECT @iNb = Count(*) FROM sysadm.w_inter i
                      WHERE
                            i.alt_quest   = 'O'         And
                            i.id_cour  like 'Q%'        And
                            i.id_sin         = @dcIdSin And
                            @sAltPce         = 'O'

 If @iNb > 0 
   Begin
     Select @sAltPce   = 'N' /* Le questionnaire annule la dem piŠce */
     Select @sAltQuest = 'O'
   End


/*------------------------------------------------------------------*/
/* Reglement                                                        */
/*   - JFF le 06/01/03 : mt_a_reg > 0                               */
/*------------------------------------------------------------------*/

           /*----------------------------------*/
   Begin   /* V‚rification en base INSTRUCTION */
           /*----------------------------------*/

	SELECT @iNb = Count(*) FROM sysadm.w_sin WHERE id_sin = @dcIdSin And mt_a_reg > 0

        If @iNb > 0 Select @sAltReg = 'O'

   End

If @sCodTable = 'P' 

           /*----------------------------------*/
   Begin   /* V‚rification en base PERMANENTE  */
           /*----------------------------------*/
	
	SELECT @iNb = Count(*) FROM sysadm.w_a_virer WHERE id_sin = @dcIdSin And cod_pos = '0'

        If @iNb > 0 Select @sAltReg = 'O'
	
   End


/*------------------------------------------------------------------*/
/* Refus                                                            */
/*   - On compte seulement les nouveaux refus                       */
/*     ( pr‚sents dans w_refus mais pas sur refus )                 */
/*------------------------------------------------------------------*/
/* #2 Je compabilise les refus uniquement pour les gti refus‚es     */
/*    ( ‚tat 200 )                                                  */
/*------------------------------------------------------------------*/

           /*----------------------------------*/
   Begin   /* V‚rification en base INSTRUCTION */
           /*----------------------------------*/

	  SELECT @iNb = Count( wr.id_sin )
            FROM sysadm.w_refus   wr,
                 sysadm.w_gar_sin wg
           WHERE
                 wr.id_sin   = @dcIdSin  And
                 wr.id_sin   = wg.id_sin And 
                 wr.id_gti   = wg.id_gti And 
                 wg.cod_etat = 200       And  Not Exists
         	 ( SELECT * FROM sysadm.refus r WHERE
 	           wr.id_sin    = r.id_sin    And
 	           wr.id_gti    = r.id_gti    And
         	   wr.id_detail = r.id_detail And
 	           wr.id_motif  = r.id_motif )


          If @iNb > 0 Select @sAltRef = 'O'

/* #8 attente confirmation m‚mo avant de compiler 

  	   SELECT  @iNb = Count(*) 
             FROM  sysadm.w_refus  wr,
                   sysadm.w_detail wd
            WHERE
                   wr.id_sin   = wd.id_sin    And
                   wr.id_gti   = wd.id_gti    And
                   wr.id_detail= wd.id_detail And
                   wd.cod_etat = 200          And
                   wd.id_sin   = @dcIdSin     And Not Exists
        	 ( SELECT * FROM sysadm.refus r WHERE
 	           wr.id_sin    = r.id_sin    And
 	           wr.id_gti    = r.id_gti    And
         	   wr.id_detail = r.id_detail And
 	           wr.id_motif  = r.id_motif )

          If @iNb > 0 Select @sAltRef = 'O'
*/

   End

If @sCodTable = 'P'

           /*----------------------------------*/
   Begin   /* V‚rification en base PERMANENTE  */
           /*------------------------------------------------------------------*/
           /* #7 Je v‚rifie que le refus … bien ‚t‚ Maj et valid‚ le mˆme jour */
           /*    Sinon je considŠre que c'est un ancien refus                  */
           /*------------------------------------------------------------------*/

	SELECT @iNb = count(*) 
	FROM
	   sysadm.refus    r,
	   sysadm.sinistre s,
           sysadm.gar_sin  g
	WHERE
           r.id_sin    = g.id_sin    And
           r.id_gti    = g.id_gti    And
           g.cod_etat  = 200         And
	   r.id_sin    = s.id_sin    And
	   r.valide_le = s.valide_le And
           DatePart ( Year , r.valide_le ) = datePart ( Year , r.maj_le ) And
           DatePart ( Month, r.valide_le ) = datePart ( Month, r.maj_le ) And
           DatePart ( Day  , r.valide_le ) = datePart ( Day  , r.maj_le ) And
	   s.id_sin    = @dcIdSin

        If @iNb > 0 Select @sAltRef = 'O'

   End


/*------------------------------------------------------------------*/
/* Commande                                                         */
/* - JFF le 06/01/2003 : Ligne(s) pr‚sente(s) sur w_commande        */
/* - JFF le 17/02/2003 : Les commandes sont systŠmatiquement        */
/*                       valid‚es aprŠs la saisie                   */
/*                       Je v‚rifie dons systŠmatiquement les tables*/
/*                        instruction & permanente                  */
/* #4 : Je v‚rifie que les lignes sur w_commande ont ‚t‚ modifi‚es  */
/*      le mˆme jour que w_sin ( m‚mo N.GUERIN du 19/03/2003)       */
/* #6 : Lors de la v‚rif sur commande : Ajout critŠre wc.maj_le     */
/*      pour ne tenir compte que des commandes valid‚es AVANT       */
/*------------------------------------------------------------------*/

           /*----------------------------------*/
   Begin   /* V‚rification en base INSTRUCTION */
           /*----------------------------------*/


           /* #4 : Quel est le jour de mise … jour de w_sin */

	   SELECT @sDate = Convert ( Varchar(2), DatePart ( Day  , maj_le ) ) + "/" +
                           Convert ( Varchar(2), DatePart ( Month, maj_le ) ) + "/" +
                           Convert ( Varchar(4), DatePart ( Year , maj_le ) ) 
             FROM
                  sysadm.w_sin
            WHERE
                  id_sin = @dcIdSin

         Select @dtDate = Convert ( Datetime, @sDate )

          /* #4 : Je ne prend les w_commandes que si elles ont ‚t‚ */
          /*      modifi‚es le mˆme jour que w_sin                 */
          /*      Ajt "And maj_le >= @dtDate"                      */
          /* #6   Suite anomalie remont‚e par NPIC ajout critŠre   */
          /*      wc.maj_le pour le prendre en compte que les cdes */
          /*      d‚j… valid‚e mais AVANT le jour : car sinon pb   */
          /*      ds le cas des dossiers directement valid‚s       */

	  SELECT @iNb = Count(*) FROM sysadm.w_commande wc WHERE id_sin = @dcIdSin And maj_le >= @dtDate And Not Exists 
	         ( SELECT * FROM sysadm.commande c WHERE
	           wc.id_sin = c.id_sin And
	           wc.id_seq = c.id_seq And
                   c.maj_le <= @dtDate )

 	  If @iNb > 0 Select @sAltCde = 'O'

   End

/*---------------------------------------------------*/
/* #5 pas de v‚rification dans les tables permanentes*/
/*    en effet une cde cr‚‚ est forc‚ment rest‚e ds  */
/*    la partie instruction                          */
/*---------------------------------------------------*/


/*------------------------------------------------------------------*/
/* Aucune action                                                    */
/*   - Tous les flags sont … 'N'                                    */
/*   - Ou l'‚tat de w_queue est rest‚ … 1                           */
/*------------------------------------------------------------------*/

If @sAltPce = 'N' And @sAltRef = 'N' And @sAltReg = 'N' And @sAltCde = 'N' And @sAltAccuse = 'N' And @sAltQuest = 'N' Select @sAltAucune = 'O'

If @sCodEtat = '1'
   Begin  
       Select @sAltAucune = 'O'
       Select @sAltPce    = 'N'
       Select @sAltRef    = 'N'
       Select @sAltReg    = 'N'
       Select @sAltCde    = 'N'
       Select @sAltAccuse = 'N'
       Select @sAltCour   = 'N'
       Select @sAltPart   = 'N'
       Select @sAltQuest  = 'N'
   End


/*------------------------------------------------------------------*/
/* Selection du r‚sultat                                            */
/* Voir signification des codes dans SHERPA code (-NSA)             */
/* 1           Dem piŠce                                            */
/* 2           R‚glement                                            */
/* 3           Refus                                                */
/* 4           Commande                                             */
/* 5           Accus‚ r‚ception                                     */
/* 6           Questionnaire                                        */
/* 50          Aucune action                                        */
/* 100         Cr automatique                                       */
/* 101         Cr particulier                                       */
/*------------------------------------------------------------------*/
     

SELECT  1  WHERE @sAltPce    = 'O' /* Dem piŠce          */ 

Union All

SELECT  2  WHERE @sAltReg    = 'O' /* R‚glement          */ 

Union All

SELECT  3  WHERE @sAltRef    = 'O' /* Refus              */ 

Union All

SELECT  4  WHERE @sAltCde    = 'O' /* Commande           */ 

Union All

SELECT  5  WHERE @sAltAccuse = 'O' /* Accus‚ r‚ception   */ 

Union All

SELECT  6  WHERE @sAltQuest  = 'O' /* Questionnaire      */ 

Union All

SELECT  50 WHERE @sAltAucune = 'O' /* Aucune action      */ 

Union All

SELECT 100 WHERE @sAltCour   = 'O' /* Cr automatique     */ 

Union All

SELECT 101 WHERE @sAltPart   = 'O' /* Cr particulier     */ 

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_INFO_COMMANDE
-- Auteur               :       FS
-- Date                 :       09/05/2003
-- Libellé              :        
-- Commentaires         :       S‚lection du dernier nø de commande
--				
-- Références           :       d_stk_sh_info_commande
--  
--
-- Retourne             :       Attention cette PS peut retourner plusieurs lignes
--
-------------------------------------------------------------------
-- V02 FS le 18/06/2004 : Dcmp 40156 Ajout information libellé fournisseur
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_INFO_COMMANDE_V02' AND type = 'P' )
        DROP procedure sysadm.DW_S01_INFO_COMMANDE_V02
GO

CREATE procedure sysadm.DW_S01_INFO_COMMANDE_V02
@iIdSin		Decimal(10,0)  -- [PI062] 
AS

Declare @dcIdSin Decimal (10,0)  -- [PI062]

Set @dcIdSin = Convert ( Decimal (10,0), @iIdSin ) -- [PI062]


	Select
	  	c.id_seq, c.id_cmd_frn, lf.lib_code as lib_fr
	From
		sysadm.w_commande c inner join code_car lf 
				       on c.id_four      = lf.id_code And
                                          lf.id_typ_code = '-FR'
	Where
		id_sin = @dcIdSin 
Union
	Select c.id_seq, c.id_cmd_frn, lf.lib_code as lib_fr
	 From
	        sysadm.commande c inner join code_car lf 
                                    on c.id_four      = lf.id_code And
                                       lf.id_typ_code = '-FR'
	Where
		c.id_sin = @dcIdSin 
	Order by
		c.id_seq

Go

--------------------------------------------------------------------
--
-- Procédure            : PS_I01_W_GAR_SIN
-- Auteur               : FS
-- Date                 : 08/04/2002
-- Libellé              :        
-- Commentaires         : Cr‚ation d'une nouvelle W_GAR_SIN
--				
-- Références           : Transfert des donn‚es du script
--  
--
-- Retourne             :   
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_GAR_SIN' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_GAR_SIN
GO

CREATE procedure sysadm.PS_I01_W_GAR_SIN
-- @iIdSin	  Integer,  -- [PI062]
-- @iIdGti   Integer,  -- [PI062]
@iIdSin	  Decimal (10), -- [PI062]
@iIdGti   Decimal (7), -- [PI062]
@sCodOper Varchar(4)  

AS

Declare @dtJour DateTime
Declare @iRet   Integer

Select @iRet   =  0
Select @dtJour = Getdate()

INSERT INTO sysadm.w_gar_sin  
         ( id_sin,   
           id_gti,   
           mt_tot_prej,   
           mt_prej_areg,   
           mt_fran_areg,   
           mt_nplaf_areg,   
           mt_plaf_areg,   
           mt_dedu_areg,   
           mt_prej_reg,   
           mt_dedu_reg,   
           mt_fran_reg,   
           mt_nplaf_reg,   
           mt_plaf_reg,   
           mt_prov,   
           cod_dec_mac,   
           cod_dec_ope,   
           cod_etat,   
           alt_bloc,   
           alt_att,   
           alt_plaf,   
           alt_ssui,   
           cod_mot_ssui,   
           alt_valide,   
           cpt_valide,   
           cpt_i_areg,   
           cree_le,   
           maj_le,   
           maj_par )  

  Select   @iIdSin   as id_sin,   
           @iIdGti   as id_gti,   
           0         as mt_tot_prej,   
           0         as mt_prej_areg,   
           0         as mt_fran_areg,   
           0         as mt_nplaf_areg,   
           0         as mt_plaf_areg,   
           0         as mt_dedu_areg,   
           0         as mt_prej_reg,   
           0         as mt_dedu_reg,   
           0         as mt_fran_reg,   
           0         as mt_nplaf_reg,   
           0         as mt_plaf_reg,   
           0         as mt_prov,   
           0         as cod_dec_mac,   
           0         as cod_dec_ope,   
           0         as cod_etat,   
           'N'       as alt_bloc,   
           'N'       as alt_att,   
           'N'       as alt_plaf,   
           'N'       as alt_ssui,   
           0         as cod_mot_ssui,   
           'O'       as alt_valide,   
           0         as cpt_valide,   
           0         as cpt_i_areg,   
           @dtJour   as cree_le,   
           @dtJour   as maj_le,   
           @sCodOper as maj_par 

Select @iRet = @@Error

  If @iRet <> 0 Select @iRet = -1

Return @iRet

GO

--------------------------------------------------------------------
--
-- Procédure            : PS_I01_W_DETAIL
-- Auteur               : FS
-- Date                 : 09/04/2002
-- Libellé              :        
-- Commentaires         : Cr‚ation d'un nouveau W_DETAIL
--				
-- Références           : Transfert des donn‚es du script
--  
--
-- Retourne             :   
--
-------------------------------------------------------------------
-- #1 FS le 02/12/2002 : utilisation @dcIdSin ald @iIdSin
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_DETAIL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_DETAIL
GO

CREATE procedure sysadm.PS_I01_W_DETAIL
@iIdSin	  Integer,
@iIdGti   Integer,
@iIdEvt   Integer,
@sCodOper Varchar(4)  ,
@iIdDetail Integer OUTPUT

AS

Declare @dcIdSin Decimal(10,0) -- [PI062]
Declare @dcIdGti Decimal(7,0)
Declare @dtJour  DateTime
Declare @iRet    Integer

Select @iRet   =  0
Select @dtJour = Getdate()

Select @dcIdSin = Convert ( Decimal(10,0), @iIdSin )  -- [PI062]
Select @dcIdGti = Convert ( Decimal(7,0), @iIdGti )

/*------------------------------------------------------------------*/
/* Obtention d'un id_detail                                         */
/*------------------------------------------------------------------*/

SELECT @iIdDetail = Max( id_detail ) FROM sysadm.w_detail WHERE id_sin = @dcIdSin And id_gti = @dcIdGti

If @iIdDetail is Null 
   Begin
     Select @iIdDetail = 0
   End
Else
   Begin
     Select @iIdDetail = @iIdDetail + 1
   End

/*------------------------------------------------------------------*/
/* Insertion dans w_detail                                          */
/*------------------------------------------------------------------*/

  INSERT INTO sysadm.w_detail  
         ( id_sin,   
           id_gti,   
           id_detail,   
           id_evt,   
           mt_prej,   
           mt_fran,   
           mt_nplaf,   
           mt_plaf,   
           alt_bloc,   
           alt_cour,   
           alt_plaf,   
           alt_reg,   
           alt_att,   
           alt_valide,   
           cpt_valide,   
           alt_ssui,   
           cod_mot_ssui,   
           cod_dec_mac,   
           cod_dec_ope,   
           cod_etat,   
           id_carte,   
           id_type_carte,   
           cree_le,   
           maj_le,   
           maj_par )  
  SELECT
	@iIdSin	   as id_sin   ,
	@iIdGti	   as id_gti   ,
	@iIdDetail as id_detail,
	@iIdEvt	   as id_evt   ,
	0	   as mt_prej  ,
	0	   as mt_fran  ,
	0	   as mt_nplaf ,
	0	   as mt_plaf  ,
	'N'	   as alt_bloc ,
	'N'	   as alt_cour ,
	'N'	   as alt_plaf ,
	'N'	   as alt_reg  ,
	'O'	   as alt_att  ,
	'O'	   as alt_valide,
	0	   as cpt_valide,
	'N'	   as alt_ssui,
	0	   as cod_mot_ssui,
	100	   as cod_dec_mac,
	100	   as cod_dec_ope,
	100	   as cod_etat,
	0	   as id_carte,
	'00'	   as id_type_carte,
	@dtJour	   as cree_le,
	@dtJour	   as maj_le,
	@sCodOper  as maj_par

Select @iRet = @@Error

  If @iRet <> 0 Select @iRet = -1

Return @iRet

Go

--------------------------------------------------------------------
--
-- Procédure            : DW_S01_ETAT_Q
-- Auteur               : FS
-- Date                 : 15/04/2002
-- Libellé              :        
-- Commentaires         : Interpr‚tation du code ‚tat contact en fonction de celui du travail
--				
-- Références           : Transfert des donn‚es du script
--  
--
-- Retourne             :   
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_ETAT_Q' AND type = 'P' )
        DROP procedure sysadm.DW_S01_ETAT_Q
GO

CREATE procedure sysadm.DW_S01_ETAT_Q
@iIdSin	  Integer

AS

Declare @sIdSin VarChar ( 10 ) -- [PI062]

Set @sIdSin = Convert ( VarChar ( 10 ) , @iIdSin ) -- [PI062]

SELECT convert ( integer, cod_etat ),
       alt_occupe 
FROM sysadm.w_queue WHERE id_sin = @sIdSin -- [PI062]

Go

--------------------------------------------------------------------
--
-- Procédure            : DW_S01_ETAT_Q_ADH
-- Auteur               : FS
-- Date                 : 15/04/2002
-- Libellé              :        
-- Commentaires         : Interpr‚tation du code ‚tat contact en fonction de celui du travail
--		          + election du Nøadh ( nøcarte ) r‚ellement sur SIMPA
-- Références           : Remplace l'anciennet DW_S01_ETAT_Q
--  
--
-- Retourne             :   
--
-------------------------------------------------------------------
-- #1 FS le 02/12/2002 : utilisation @dcIdSin ald @iIdSin
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_ETAT_Q_ADH' AND type = 'P' )
        DROP procedure sysadm.DW_S01_ETAT_Q_ADH
GO


CREATE procedure sysadm.DW_S01_ETAT_Q_ADH
@iIdSin	  Integer

AS

Declare @sIdAdh  Varchar(19)
Declare @iEtatQ  Integer
Declare @iIdEts  Integer
Declare @sAltOqp Char(1)
Declare @dcIdSin Decimal(10,0) -- [PI062]
Declare @sIdSin  VarChar (10)

Select  @sIdAdh  = convert( char(1), null )
Select  @dcIdSin = Convert ( decimal(10,0), @iIdSin ) -- [PI062]
Select  @sIdSin = Convert ( VarChar (10), @iIdSin ) -- [PI062]
Select  @iEtatQ  = 0
Select  @iIdEts  = 0
Select  @sAltOqp = 'N'

/*----------------------------------------------------------*/
/* #1 recherche du nø d'adh‚sion pour verif Sherpa <-> Simpa*/
/*----------------------------------------------------------*/

 /* Base instruction */

 SELECT @sIdAdh = id_adh,
        @iIdEts = id_ets
   FROM sysadm.w_sin 
  WHERE id_sin = @dcIdSin

 /* Base permanente  */

 If @@rowcount = 0
   Begin
      SELECT @sIdAdh = id_adh,
             @iIdEts = id_ets
        FROM sysadm.sinistre
       WHERE id_sin = @dcIdSin
   End

 /* Selection des infos sur w_queue */

  SELECT
    @iEtatQ  = convert ( integer, cod_etat ),
    @sAltOqp = alt_occupe 
  FROM
    sysadm.w_queue
  WHERE id_sin = @sIdSin -- [PI062]

 /* Selection du resultat */

 Select @iEtatQ, @sAltOqp, @iIdEts, @sIdAdh

Go

--------------------------------------------------------------------
--
-- Procédure            : DW_S01_RECH_PROD_CARTE
-- Auteur               : FS
-- Date                 : 22/04/2003
-- Libellé              :        
-- Commentaires         : R‚cup‚ration des produits associ‚s … un num‚ro de carte
--                        
--			  
-- Références           : FP00096 : Pouvoir distinguer les produits li‚s … une carte
--                                  parmis les autres produits de la banque
--
-- Retourne             :   
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_RECH_PROD_CARTE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_RECH_PROD_CARTE
GO


CREATE procedure sysadm.DW_S01_RECH_PROD_CARTE
@sIdCarte	VarChar(19)

AS

SELECT Distinct a.id_prod
 FROM sysadm.carte c 
 INNER JOIN sysadm.affilier a ON c.id_carte = a.id_carte
WHERE
   c.val_rg_mini <= @sIdCarte And
   c.val_rg_max  >= @sIdCarte 

GO 
                   
--------------------------------------------------------------------
--
-- Procédure            : DW_S01_RECH_GROUPE_CARTE
-- Auteur               : PLJ
-- Date                 : 30/07/2002
-- Libellé              :        
-- Commentaires         : R‚cup‚ration du Groupe associ‚ … un num‚ro de carte
--                        correspond au groupe de produit dans SHERPA
--				
-- Références           : 
--  
--
-- Retourne             :   
--
-------------------------------------------------------------------
-- #1 FS le 24/10/02 : Sste Pb constat‚ OF : Les produits par cartes SIMPA 
--                     appartiennent au groupe 153 GROUPEMENT CARTE BLEUE
--                     la selection par rapport au type de carte est modifiée
--                     pour ne pas renvoyer le groupe de base mais le groupe
--      PS : le libelle du groupe sur SIMPA à été modifié pour correspondre au
--           libelle du groupe de produit SHERPA 
--           ( chaine (Gie) … enlever du libellé extrait de SIMPA )
--
-- id_prod     id_grp      lib_long                            
-- 18100       153         E-CARTE BLEUE                       
-- 15700       153         DC/UF GAMME  BUSINESS PROF          
-- 15800       153         GA/PGC/UF TEL GAMME BUSINESS PROF   
-- 15400       153         UA/UF/DC/VOL BAG GAMME AFFAIRES     
-- 15500       153         DC/UF GAMME BUSINESS PRIVEE         
-- 15600       153         GA/UF TEL GOLD BUSINESS PRIVE   
-------------------------------------------------------------------


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_RECH_GROUPE_CARTE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_RECH_GROUPE_CARTE
GO

CREATE procedure sysadm.DW_S01_RECH_GROUPE_CARTE
@sIdCarte	VarChar(19)
AS

SELECT  carte.id_carte,
	carte.lib_carte,
        case groupe.id_grp_base
            when 153 Then substring(groupe.lib_grp, 1, Datalength( rtrim ( groupe.lib_grp ) ) - 6 ) 
            Else          groupe_b.lib_grp
        End

 FROM   sysadm.carte, sysadm.groupe, sysadm.groupe as groupe_b

 WHERE  carte.val_rg_mini      <= @sIdCarte       	AND
        carte.val_rg_max       >= @sIdCarte		AND

	carte.id_grp		= groupe.id_grp		AND
	groupe.id_grp_base	= groupe_b.id_grp

Go
-------------------------------------------------------------------------------------------
-- V01 FS le 19/06/2008 Dcmp 80498 Retour libellé banque émettrice
-------------------------------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_RECH_GROUPE_CARTE_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S01_RECH_GROUPE_CARTE_V01
GO

CREATE procedure sysadm.DW_S01_RECH_GROUPE_CARTE_V01
@sIdCarte	VarChar(19)
AS

SELECT  carte.id_carte,
	carte.lib_carte,
        case groupe.id_grp_base
            when 153 Then substring(groupe.lib_grp, 1, Datalength( rtrim ( groupe.lib_grp ) ) - 6 ) 
            Else          groupe_b.lib_grp
        End,
        groupe.lib_grp as lib_emetteur  -- V01

 FROM   sysadm.carte, sysadm.groupe, sysadm.groupe as groupe_b

 WHERE  carte.val_rg_mini      <= @sIdCarte       	AND
        carte.val_rg_max       >= @sIdCarte		AND

	carte.id_grp		= groupe.id_grp		AND
	groupe.id_grp_base	= groupe_b.id_grp

Go
-------------------------------------------------------------------------------------------
-- V02 FS le 01/07/2010 Dcmp 100350 Retour du groupe de produit paramétré
-------------------------------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_RECH_GROUPE_CARTE_V02' AND type = 'P' )
        DROP procedure sysadm.DW_S01_RECH_GROUPE_CARTE_V02
GO

CREATE procedure sysadm.DW_S01_RECH_GROUPE_CARTE_V02
@sIdCarte	VarChar(19)
AS

SELECT  carte.id_carte,
	     carte.lib_carte,
        case groupe.id_grp_base
            when 153 Then substring(groupe.lib_grp, 1, Datalength( rtrim ( groupe.lib_grp ) ) - 6 ) 
            Else          groupe_b.lib_grp
        End,
        groupe.lib_grp as lib_emetteur,  -- V01
        groupe.id_grp_prod               -- V02

 FROM   sysadm.carte, sysadm.groupe, sysadm.groupe as groupe_b

 WHERE  carte.val_rg_mini      <= @sIdCarte       	AND
        carte.val_rg_max       >= @sIdCarte		AND

	carte.id_grp		= groupe.id_grp		AND
	groupe.id_grp_base	= groupe_b.id_grp

Go


--------------------------------------------------------------------
--
-- Procédure            : PS_V01_TRAVAIL_EXIST
-- Auteur               : PLJ
-- Date                 : 19/08/2002
-- Libellé              :        
-- Commentaires         : V‚rification qu'un travail n'existe pas sur un dossier
--
--
-- Références           : 
--  
--
-- Retourne             :   
--
---------------------------------------------------------------------------
-- #1 FS le 10/10/2005 Correction passage de @sIdSin de char(6) à varchar(7)
-- JFF      12/02/2016   [PI062]
---------------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_V01_TRAVAIL_EXIST' AND type = 'P' )
        DROP procedure sysadm.PS_V01_TRAVAIL_EXIST
Go

CREATE procedure sysadm.PS_V01_TRAVAIL_EXIST
@sIdSin		varchar(10), -- #1 -- [PI062]
@sRetour	char(1)	output
AS

DECLARE @nbW	integer

SELECT  @nbW = count (*)
  FROM  sysadm.w_queue
 WHERE	id_sin =  @sIdSin 

If @nbW > 0 
   Select @sRetour = 'O'
Else
   Select @sRetour = 'N'

Go

--------------------------------------------------------------------
--
-- Procédure            : DW_S01_ASSURE
-- Auteur               : FS
-- Date                 : 11/09/2002
-- Libellé              :        
-- Commentaires         : Selection de l'adresse de l'assure
--                        ( pour comparaison avec adresse Sherpa )
--
-- Références           : 
--  
--
-- Retourne             :   
--
-------------------------------------------------------------------
-- #1 FS  02/12/2002 : Utilisation @dcIdSin ald @iIdSin
--    JFF 12/02/2016	 : [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_ASSURE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_ASSURE
Go

CREATE procedure sysadm.DW_S01_ASSURE
@iIdSin		Integer

AS

Declare @dcIdSin Decimal(10,0) -- [PI062]

Select @dcIdSin = Convert ( Decimal(10,0) , @iIdSin )-- [PI062]

SELECT
  w.id_sin ,
  w.cod_civ,
  w.nom    ,
  w.prenom ,
  w.adr_1  ,
  w.adr_2  ,
  w.adr_cp ,
  w.adr_ville,
  w.num_teld ,
  w.num_telb ,
  w.num_fax,
  w.maj_par
FROM
  sysadm.w_sin w
WHERE
  id_sin =  @dcIdSin 


Go

--------------------------------------------------------------------
--
-- Procédure            : DW_S01_ASSURE_V01
-- Auteur               : FPI
-- Date                 : 17/08/2009
-- Libellé              :        
-- Commentaires         : Selection de l'adresse de l'assure
--                        ( pour comparaison avec adresse Sherpa )
--
-- Références           : [DCMP090404]
--  
--
-- Retourne             :   
--
-------------------------------------------------------------------
--    JFF 12/02/2016	 : [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_ASSURE_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S01_ASSURE_V01
Go

CREATE procedure sysadm.DW_S01_ASSURE_V01
@iIdSin		Integer

AS

Declare @dcIdSin Decimal(10,0) -- [PI062]

Select @dcIdSin = Convert ( Decimal(10,0) , @iIdSin ) -- [PI062]

SELECT
  w.id_sin ,
  w.cod_civ,
  w.nom    ,
  w.prenom ,
  w.adr_1  ,
  w.adr_2  ,
  w.adr_cp ,
  w.adr_ville,
  w.num_teld ,
  w.num_telb ,
  w.num_fax  ,
  w.maj_par,
  wi.adr_mail
FROM
  sysadm.w_sin w,
  sysadm.w_inter wi
WHERE
  w.id_sin = @dcIdSin and
  wi.id_sin = w.id_sin and
  wi.cod_inter='A'


Go

-- V02 - FPI - 06/10/2009 - [DCMP090574]
--    JFF 12/02/2016	 : [PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_ASSURE_V02' AND type = 'P' )
        DROP procedure sysadm.DW_S01_ASSURE_V02
Go

CREATE procedure sysadm.DW_S01_ASSURE_V02
@iIdSin		Integer

AS

Declare @dcIdSin Decimal(10,0) -- [PI062]

Select @dcIdSin = Convert ( Decimal(10,0) , @iIdSin ) -- [PI062]

SELECT
  w.id_sin ,
  w.cod_civ,
  w.nom    ,
  w.prenom ,
  w.adr_1  ,
  w.adr_2  ,
  w.adr_cp ,
  w.adr_ville,
  w.num_teld ,
  w.num_telb ,
  w.num_fax  ,
  w.maj_par,
  wi.adr_mail,
  wi.num_port_sms -- V02
FROM
  sysadm.w_sin w,
  sysadm.w_inter wi
WHERE
  w.id_sin = @dcIdSin and
  wi.id_sin = w.id_sin and
  wi.cod_inter='A'

Go

-------------------------------------------------------------------
--
-- Procédure            : DW_U01_ASSURE
-- Auteur               : FS
-- Date                 : 11/09/2002
-- Libellé              :        
-- Commentaires         : mise … jour de l'adresse de l'assure
--                        ( tables w_sin & w_inter )
--
-- Références           : 
--  
--
-- Retourne             :   
--
-------------------------------------------------------------------
-- #1 FS le 15/10/02 Correction suite bug remont‚ r‚union du 10/10/02
--                   Pb en validation l'adresse assur‚ ne se met pas … jour
-- #2 FS 02/12/2002 : Utilisation @dcIdSin ald @iIdSin
-- #3 FS 09/12/2002 : V‚rification prenom pour les soci‚t‚s
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_ASSURE' AND type = 'P' )
        DROP procedure sysadm.DW_U01_ASSURE
Go


CREATE procedure sysadm.DW_U01_ASSURE
@iIdSin	    Integer    ,
@sCodCiv    Varchar(10),
@sNom       Varchar(35),
@sPrenom    Varchar(35),
@sAdr1      Varchar(35),
@sAdr2      Varchar(35),
@sAdrCp     Char(5)    ,
@sAdrVille  Varchar(35),
@sMajPar    Varchar(4)

AS

Declare @iRet        Integer
Declare @dcIdI       Decimal(7,0) /* #2 */  
Declare @sCodCiv_I   Char(1)    
Declare @sLib_I      Varchar(70)
Declare @sAdr1_I     Varchar(35)
Declare @sAdr2_I     Varchar(35)
Declare @sAdrCp_I    Char(5)    
Declare @sAdrVille_I Varchar(35)

Declare @sCodCiv_S   Char(1)    
Declare @sLib_S      Varchar(70)
Declare @sAdr1_S     Varchar(35)
Declare @sAdr2_S     Varchar(35)
Declare @sAdrCp_S    Char(5)    
Declare @sAdrVille_S Varchar(35)

Declare @dcIdSin Decimal(10,0)   /* #2 */ -- [PI062]

Select @dcIdSin = Convert ( Decimal(10,0) , @iIdSin ) -- [PI062]



                                                     /*---------------------------------------------------------------------*/
If @sPrenom is null            Select @sPrenom = ''  /* Pour les st‚ le libellé est stock‚ dans le nom : Le prenom est vide */
If Datalength ( @sPrenom ) < 1 Select @sPrenom = ''  /* Je transforme la valeur pour ne pas laisser null                    */
                                                     /*---------------------------------------------------------------------*/

If @sCodCiv = '5' Select @sPrenom = ''  /* #3 */


/*------------------------------------------------------------------*/
/* Correction temporaire suite pb code civilit‚                     */
/* Pb je passait le libellé au lieu du code                         */
/*    @sCodCiv chang‚ de char(1) en varchar(10)                     */
/*------------------------------------------------------------------*/

	/*------------------------------------------------------------------*/
	/* PEGASE & SIMPA	SAVANE                                      */
	/*  1       M. 		1   M.                                      */
	/*  2       Mme	        2   Mme                                     */
	/*  3       Mlle	3   Mlle                                    */
	/*  4       M. ou Mme	4   Ste                                     */
	/*  5       Ste		5   Dr.                                     */
	/*------------------------------------------------------------------*/

Select @sCodCiv =
    Case @sCodCiv
      When 'M.'        Then '1'
      When 'Mme'       Then '2'
      When 'Mlle'      Then '3'
      When 'M. ou Mme' Then '4'
      When 'Ste'       Then '5'
      Else             @sCodCiv
    End

/*------------------------------------------------------------------*/
/* Fin de correction provisoire                                     */
/*------------------------------------------------------------------*/


/*------------------------------------------------------------------*/
/* (1) Y a-t-il la mˆme adresse entre w_sin et inter Assur‚         */
/*------------------------------------------------------------------*/

  /* Adresse de l'interlocuteur assur‚ */

  SELECT 
      @dcIdI       = i.id_i      ,
      @sCodCiv_I   = i.cod_civ   ,
      @sLib_I      = i.nom       ,
      @sAdr1_I     = i.adr_1     ,
      @sAdr2_I     = i.adr_2     ,
      @sAdrCp_I    = i.adr_cp    ,
      @sAdrVille_I = i.adr_ville 
  FROM
      sysadm.w_inter i
  WHERE
      i.id_sin    =  @dcIdSin  And
      i.cod_inter = 'A'

  If @sLib_I      is null Select @sLib_I      = ''
  If @sAdr1_I     is null Select @sAdr1_I     = ''
  If @sAdr2_I     is null Select @sAdr2_I     = ''
  If @sAdrCp_I    is null Select @sAdrCp_I    = ''
  If @sAdrVille_I is null Select @sAdrVille_I = ''
  

  /* Adresse de l'assur‚ sur w_sin     */

  SELECT 
      @sCodCiv_S   = s.cod_civ   ,
      @sLib_S      = rtrim(s.prenom) + ' ' + rtrim( s.nom) ,
      @sAdr1_S     = s.adr_1     ,
      @sAdr2_S     = s.adr_2     ,
      @sAdrCp_S    = s.adr_cp    ,
      @sAdrVille_S = s.adr_ville 
  FROM
      sysadm.w_sin s
  WHERE
      s.id_sin =  @dcIdSin  


  If @sLib_S      is null Select @sLib_S      = ''
  If @sAdr1_S     is null Select @sAdr1_S     = ''
  If @sAdr2_S     is null Select @sAdr2_S     = ''
  If @sAdrCp_S    is null Select @sAdrCp_S    = ''
  If @sAdrVille_S is null Select @sAdrVille_S = ''
  

/*------------------------------------------------------------------*/
/* (2) Mise … jour des coordonn‚es sur l'inter Assur‚               */
/*------------------------------------------------------------------*/


If @sLib_S   = @sLib_I   And @sAdr1_S     = @sAdr1_I     And @sAdr2_S = @sAdr2_I And
   @sAdrCp_S = @sAdrCp_I And @sAdrVille_S = @sAdrVille_I

         /*------------------------------------------------------------------*/
   Begin /* Debut : W_SIN & W_INTER Mˆmes coordonn‚es                        */
         /*------------------------------------------------------------------*/

	UPDATE sysadm.w_inter 
	   SET cod_civ  = @sCodCiv,
	       nom      = @sPrenom + ' ' + @sNom,
	       adr_1    = @sAdr1,
	       adr_2    = @sAdr2,
	       adr_cp   = @sAdrCp,
	       adr_ville= @sAdrVille,
	       maj_par  = @sMajPar,
	       maj_le   = Getdate()
	 WHERE
	       id_sin = @dcIdSin  And
               id_i   = @dcIdI

         SELECT @iRet = @@Error

         If @iRet <> 0 Return @iRet

         /*------------------------------------------------------------------*/
   End   /* Fin   : W_SIN & W_INTER Mˆmes coordonn‚es                        */
         /*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* (3) Mise … jour des coordonn‚es sur la table w_sin               */
/*------------------------------------------------------------------*/
/* #1 alt_adr='0'                                                   */
/*------------------------------------------------------------------*/

UPDATE sysadm.w_sin 
   SET cod_civ  = @sCodCiv,
       nom      = @sNom,
       prenom   = @sPrenom,
       adr_1    = @sAdr1,
       adr_2    = @sAdr2,
       adr_cp   = @sAdrCp,
       adr_ville= @sAdrVille,
       alt_adr  = 'O',
       maj_par  = @sMajPar,
       maj_le   = Getdate()
 WHERE
       id_sin = @dcIdSin 

       SELECT @iRet = @@Error

Return @iRet

Go

--------------------------------------------------------------------
--
-- Procédure            : PS_V01_TRAVAIL_ETAT
-- Auteur               : PLJ
-- Date                 : 24/09/2002
-- Libellé              :        
-- Commentaires         : V‚rification que le travail n'est pas Occup‚ pour BO
--
--
-- Références           : 
--  
--
-- Retourne             :   
--
-------------------------------------------------------------------
-- #1 FS le 10/10/2005 Correction passage de @sIdSIn de char(6) à varchar(7)
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_V01_TRAVAIL_ETAT' AND type = 'P' )
        DROP procedure sysadm.PS_V01_TRAVAIL_ETAT
Go

CREATE procedure sysadm.PS_V01_TRAVAIL_ETAT
@sIdSin		varchar(10),    -- #1 -- [PI062]
@sAltOcc	char(1)		output,
@sAltBloc	char(1)		output,
@sDosMajPar	char(4)		output
AS

SELECT  @sAltOcc    = alt_occupe,
		@sAltBloc   = alt_bloc,
		@sDosMajPar = dos_maj_par

FROM  sysadm.w_queue

WHERE	id_sin =  @sIdSin 

Go

--------------------------------------------------------------------
--
-- Procédure            : DW_S01_RECH_INFO_CARTE
-- Auteur               : FS
-- Date                 : 05/05/2003
-- Libellé              :        
-- Commentaires         : R‚cup‚ration des informations associ‚es … un num‚ro de carte
--                        ( produit, garantie, police, compagnie )
--			  
-- Références           : DCMP030225 : Pouvoir distinguer les produits li‚s … une carte
--                                     parmis les autres produits de la banque
--
-- Retourne             :   
--
-------------------------------------------------------------------

/*------------------------------------------------------------------*/
/* ( 1 ) Cr‚ation d'une vue : Derniere revision par produit / gti   */
/*------------------------------------------------------------------*/

if exists (select 1
            from  sysobjects
           where  id = object_id('v_affilier')
            and   type = 'V')
   drop view v_affilier
go

Create view v_affilier

AS

SELECT	a.id_prod,
	a.id_gti,
	a.id_carte,
	Max( id_rev ) as id_rev_max

  FROM 	sysadm.carte c	INNER JOIN sysadm.affilier a ON c.id_carte = a.id_carte

 GROUP 
    BY 	a.id_prod, a.id_gti, a.id_carte

GO


/*------------------------------------------------------------------*/
/* ( 2 ) Cr‚ation de la procédure                                   */
/*------------------------------------------------------------------*/

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_RECH_INFO_CARTE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_RECH_INFO_CARTE
GO


CREATE procedure sysadm.DW_S01_RECH_INFO_CARTE
@sIdCarte	VarChar(19)

AS


SELECT	convert ( char(5), a.id_prod),
	convert ( char(3), a.id_gti ),
	co.lib_cie,
	po.lib_police,
	lcg.lib_gti	as lib_gti  /* lcg ald code.lib_code  */

  FROM	sysadm.carte c	INNER JOIN sysadm.v_affilier a ON  c.id_carte = a.id_carte

      			INNER JOIN sysadm.garantie  ga ON  a.id_prod        = ga.id_prod 	AND
           						   a.id_rev_max     = ga.id_rev  	AND
							   a.id_gti         = ga.id_gti

      			INNER JOIN sysadm.police    po ON  ga.id_police     = po.id_police

      			INNER JOIN sysadm.compagnie co ON  po.id_cie        = co.id_cie


			/* 
			 --------------------------------------------------------------------------------          
          Correction : Passage par code_garantie pour le libellé de garantie personnalisé 
			
					INNER JOIN sysadm.code         ON  code.id_code     = ga.id_gti		AND
			                                   code.id_typ_code = '-GA'

			 --------------------------------------------------------------------------------
			*/

				INNER JOIN sysadm.code_garantie lcg on a.id_prod = lcg.id_prod and ga.id_gti = lcg.id_gti

 WHERE	c.val_rg_mini <= @sIdCarte AND
   	c.val_rg_max  >= @sIdCarte 

GO



--------------------------------------------------------------------
--
-- Procédure            : PS_V01_WKFS_W_QUEUE
-- Auteur               : PLJ
-- Date                 : 30/12/2003
-- Libellé              :        
-- Commentaires         : Vérication qu'il ne reste pas de dossier à classer 
--                        par la méthode centralisée avant raptriement
--
-- Retourne             :   
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_V01_WKFS_W_QUEUE' AND type = 'P' )
        DROP procedure sysadm.PS_V01_WKFS_W_QUEUE
GO

CREATE procedure sysadm.PS_V01_WKFS_W_QUEUE
@iIdSin   Integer,
@sRetour  Varchar(60) Output
As
Declare @iNbLigne  Integer

Select @sRetour = 'OK'
	/*
	Pm133 - FS le 21/08/2012 : Retrait du contrôle

	SELECT @iNbLigne = count(*)
	  FROM sysadm.wkfs_w_queue 
	 WHERE id_sin = Convert ( Decimal (10), @iIdSin ) -- [PI062]

	IF @iNbLigne > 0
	  Begin
		Select @sRetour = 'Il reste un dossier papier à archiver'
		Return -1
	  End
	  */

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I04_CONTACT_TRAVAIL
-- Auteur               :       FS
-- Date                 :       25/01/2005
-- Libell‚              :       Création simplifiée d'un contact de complément et d'un travail 
--                              dans l'application de gestion associée
--
-- Références           :       Pour toute insertion automatique de contact à partir d'un sinistre
--
-- Arguments            :       Attention bases SHERPA_SIM et SIMPA2_TRT à substituer avant compil
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- Attention bases SHERPA_SIM et SIMPA2_TRT à substituer avant compil
--           Procédure également compilée sur la base Sherpa V01 et V02
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I04_CONTACT_TRAVAIL' AND type = 'P' )
        DROP procedure sysadm.PS_I04_CONTACT_TRAVAIL
GO

CREATE procedure PS_I04_CONTACT_TRAVAIL
 @iIdSin        Integer,
 @iIdAppli      Integer,
 @sMess         Varchar(254),
 @sMajPar       Varchar(4),
 @sErr          Varchar(60) output

AS

Declare @iIdCli 		Integer
Declare @iIdCt  		Integer
Declare @iRet   		Integer
Declare @dtTrvCreeLe	datetime
Declare @sTypRecuTrc	char(1)
Declare @sIdCorb	   char(4)
Declare @sDteJour    Varchar(10)

Set @iIdCli   = 0
Set @iRet     = 0
Set @sErr     = "Ok"
Set @sDteJour = Convert( varchar(10), getdate(), 103 )


-- Pour le moment seule appli 2 (simpa) est gérée

If @iIdAppli > 2
   Begin
      Set @sErr = "Appli " + convert(varchar(5), @iIdAppli ) + " non gérée"
      Return -1
   End

-- Obtention du n° client

If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
    Begin
		Select @iIdCli = s.id_cli From SHERPA_PRO.sysadm.sinistre s Where s.id_sin = @iIdSin And s.id_appli = @iIdAppli
    End
Else
    Begin
		Select @iIdCli = s.id_cli From SHERPA_SIM.sysadm.sinistre s Where s.id_sin = @iIdSin And s.id_appli = @iIdAppli
    End

If @iIdCli = 0
   Begin
      Set @sErr = "N° client inexistant sur " + @@servername
      Return -1
   End


/*---------------------------------------------------------*/
/* (1) Création du contact dans Sherpa                     */
/*---------------------------------------------------------*/

If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

    Begin -- Création sur le serveur de production --

		Exec @iRet = SHERPA_PRO.sysadm.PS_I01_CONTACT_V01
		 	@iIdCli   ,   -- No client
			 2         ,   -- Famille
			 2         ,   -- Type de contact
			 'Z'       ,   -- Canal 'Z' auto
			 @iIdSin   ,   -- Numéro de sinistre
			 @iIdAppli ,   -- Numéro application
			 @sMess    ,   -- Message du contact et du travail
			 @sMajPar  ,   -- opérateur
			 101       ,   -- code état du contact
			 @iIdCt output -- Numéro du contact créé
    End
Else

    Begin -- Création sur le serveur de simulation/production --

		Exec @iRet = SHERPA_SIM.sysadm.PS_I01_CONTACT_V01
		 	@iIdCli   ,   -- No client
			 2         ,   -- Famille
			 2         ,   -- Type de contact
			 'Z'       ,   -- Canal 'Z' auto
			 @iIdSin   ,   -- Numéro de sinistre
			 @iIdAppli ,   -- Numéro application
			 @sMess    ,   -- Message du contact et du travail
			 @sMajPar  ,   -- opérateur
			 101       ,   -- code état du contact
			 @iIdCt output -- Numéro du contact créé
      End


If @iRet <> 0
   Begin
      Set @sErr = "Erreur création contact " + convert(varchar(10), @iRet )
      Return -1
   End

/*---------------------------------------------------------*/
/* (2) Mise à jour des info complémentaires sur le contact */
/*     PS_I01_CONTACT_V01 effectue une création simplifiée */
/*---------------------------------------------------------*/

If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

    Begin -- mise à jour sur le serveur de production --

			Update SHERPA_PRO.sysadm.contact
			   Set alt_valide  ='N',
			       id_typ_recu ='C',
			       a_traiter_par = @sMajPar ,
			       dte_cour_cli  = @sDteJour,
			       dte_recu      = @sDteJour
			 Where id_cli = @iIdCli And id_contact = @iIdCt

			Set @iRet = @@error

	End
Else

    Begin -- mise à jour sur le serveur de simulation --

			Update SHERPA_SIM.sysadm.contact
			   Set alt_valide  ='N',
			       id_typ_recu ='C',
			       a_traiter_par = @sMajPar ,
			       dte_cour_cli  = @sDteJour,
			       dte_recu      = @sDteJour
			 Where id_cli = @iIdCli And id_contact = @iIdCt
			
			Set @iRet = @@error
	 End

If @iRet <> 0
   Begin
      Set @sErr = "Erreur mise à jour contact " + convert(varchar(10), @iRet )
      Return -1
   End

/*---------------------------------------------------------*/
/* (3) Création du travail dans Simpa                      */
/*---------------------------------------------------------*/

If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

    Begin -- Création sur sur le serveur de production --

		Exec @iRet = SIMPA2_PRO.sysadm.PS_I01_TRAVAIL
			@iIdSin      			,-- n° sinistre
			0 							,-- n° département
			'T'						,-- canal
			'C' 						,-- id_typ_recu
			'T' 						,-- inter autre "T"iers
			@sMajPar	      		,-- dossier suivi par
			@sMess		   		,-- Message
			Null 				      ,-- N° machine
			@sMajPar   		      ,-- opérateur
			@sDteJour		      ,-- dte_recu
			@sDteJour		      ,-- dte_cour_cli
			Null				      ,-- dte_fin_gti
			@iIdCt			      ,-- n° de contact
			@sErr	         output,-- Libellé erreur
			@dtTrvCreeLe	output,
			@sTypRecuTrc	output,
			@sIdCorb			output

    End
Else

    Begin -- Création sur le serveur de simulation --

		Exec @iRet = SIMPA2_TRT.sysadm.PS_I01_TRAVAIL
			@iIdSin      			,-- n° sinistre
			0 							,-- n° département
			'T'						,-- canal
			'C' 						,-- id_typ_recu
			'T' 						,-- inter autre "T"iers
			@sMajPar	      		,-- dossier suivi par
			@sMess		   		,-- Message
			Null 				      ,-- N° machine
			@sMajPar   		      ,-- opérateur
			@sDteJour		      ,-- dte_recu
			@sDteJour		      ,-- dte_cour_cli
			Null				      ,-- dte_fin_gti
			@iIdCt			      ,-- n° de contact
			@sErr	         output,-- Libellé erreur
			@dtTrvCreeLe	output,
			@sTypRecuTrc	output,
			@sIdCorb			output
    End

If @iRet <> 0
   Begin
      Return -1
   End

Go

--------------------------------------------------------------------
--
-- Procédure            :   PS_VERIF_PRODUIT_ETS
-- Auteur               :   JFF
-- Date                 :   13/09/2006
-- Libell‚              :   vérification du produit / ets
--
-- Références           :   Utilisé comme contrôle lors de PS_I01_SINISTRE
--
-- Arguments            :     Attention bases SHERPA_SIM et SIMPA2_TRT à substituer avant compil
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_VERIF_PRODUIT_ETS' AND type = 'P' )
        DROP procedure sysadm.PS_VERIF_PRODUIT_ETS
GO

CREATE procedure sysadm.PS_VERIF_PRODUIT_ETS
  @aiIdProd     integer,
  @aiIdEts      integer
AS

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')	
	Return ( 
		 select IsNull ( NullIf ( IsNull ( Count (*), -1) , 0 ), -1 )
		 where  
			( Select count (*) 
			  From SIMPA2_PRO.sysadm.etablissement e
			  where  e.id_prod = convert ( Decimal ( 7 ), @aiIdProd )
			  and    e.id_ets  = convert ( Decimal ( 7 ), @aiIdEts )
			  and    e.id_rev = -1 ) > 0 

		 Or     ( select p.cod_adh 
			  from SIMPA2_PRO.sysadm.produit p 
			  where p.id_prod = convert ( Decimal ( 7 ), @aiIdProd) ) in ( '3','4' )
		)
Else
	Return ( 
		 select IsNull ( NullIf ( IsNull ( Count (*), -1) , 0 ), -1 )
		 where  
			( Select count (*) 
			  From SIMPA2_TRT.sysadm.etablissement e
			  where  e.id_prod = convert ( Decimal ( 7 ), @aiIdProd )
			  and    e.id_ets  = convert ( Decimal ( 7 ), @aiIdEts )
		          and    e.id_rev = -1 ) > 0 
		 Or     ( select p.cod_adh 
				  from SIMPA2_TRT.sysadm.produit p 
				  where p.id_prod = convert ( Decimal ( 7 ), @aiIdProd) ) in ( '3','4' )
		)
Go

--------------------------------------------------------------------
--
-- Proc‚dure            : PS_U01_BLOQUER_DOSSIER
-- Auteur               : FPI
-- Date                 : 08/01/2009
-- Libell‚              :        
-- Commentaires         : Positionne alt_occuper='N' et renvoie la valeur de maj_par d'un dossier
--
--
-- R‚f‚rences           : 
--  
--
-- Retourne             :   
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_BLOQUER_DOSSIER' AND type = 'P' )
        DROP procedure sysadm.PS_U01_BLOQUER_DOSSIER
Go

CREATE PROCEDURE sysadm.PS_U01_BLOQUER_DOSSIER
	@sIdSin	Char(10), -- [PI062]
	@sMajPar Char(4) OUTPUT
AS

	Update sysadm.w_queue 
	Set alt_occupe='O' 
	Where id_sin = @sIdSin
		And alt_occupe='N' 
		And cod_etat='1'

	If @@ROWCOUNT = 0 Return 0

	Select @sMajPar = maj_par 
	from sysadm.w_sin
	Where id_sin=Convert(Decimal(10), @sIdSin) -- [PI062]

	Return 1

GO

--------------------------------------------------------------------
--
-- Proc‚dure            : PS_INTEGRER_CONTACT_FACTURATION
-- Auteur               : FPI
-- Date                 : 30/06/2009
-- Libell‚              :        
-- Commentaires         : Intégration des contacts de facturation
--
--
-- R‚f‚rences           : [DCMP090310]
--  
--
-- Retourne             :   
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_INTEGRER_CONTACT_FACTURATION' AND type = 'P' )
        DROP procedure sysadm.PS_INTEGRER_CONTACT_FACTURATION
Go

CREATE procedure sysadm.PS_INTEGRER_CONTACT_FACTURATION
	@iIdTypTrait	Integer,	
	@sIdSin			Varchar(10),	
	@iIdNatTache	Integer,	
	@sTxtMsg		Varchar(254),	
	@dcMtReg		Decimal (11,2),	
	@sNumFact		Varchar(20),	
	@dDteOdp		Datetime,	
	@dDteFact		Datetime,	
	@dDteRegSpb		Datetime,	
	@sIdOper		VarChar(4),
	@sCodAction		Char(1),		-- « V » pour vérification, « E » pour exécuter
	@sErr			Varchar(60)	Output --Texte de l’erreur par référence.
As
	Declare @iRet integer

	IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		EXEC @iRet = SHERPA_PRO.sysadm.PS_I01_CONTACT_FACTURATION_V00 @iIdTypTrait,	@sIdSin, @iIdNatTache, @sTxtMsg,
						@dcMtReg, @sNumFact, @dDteOdp, @dDteFact, @dDteRegSpb, @sIdOper, @sCodAction, @sErr OUTPUT
	ELSE
		EXEC @iRet = SHERPA_SIM.sysadm.PS_I01_CONTACT_FACTURATION_V00 @iIdTypTrait,	@sIdSin, @iIdNatTache, @sTxtMsg,
						@dcMtReg, @sNumFact, @dDteOdp, @dDteFact, @dDteRegSpb, @sIdOper, @sCodAction, @sErr OUTPUT
	
	Return @iRet

Go

--------------------------------------------------------------------
--
-- Proc‚dure            : PS_LIRE_UTILISATEUR_SITE
-- Auteur               : FPI
-- Date                 : 02/07/2009
-- Libell‚              :        
-- Commentaires         : [Atlas].Courrier
--
--
-- R‚f‚rences           : 
--  
--
-- Retourne             :   
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_LIRE_UTILISATEUR_SITE' AND type = 'P' )
        DROP procedure sysadm.PS_LIRE_UTILISATEUR_SITE
Go
CREATE procedure sysadm.PS_LIRE_UTILISATEUR_SITE
   @dcIdSin	Decimal(10) ,	-- [PI062]	-- Identifiant sinistre
   @sCanal	 varchar(2) output,		-- canal choisi
   @sEMail	 varchar(60) output,		-- adresse e-mail   
   @sIdentifiant varchar(60) output  -- identifiant
AS
	
	declare @iRet   integer
	Declare @iIdSin integer

	set @iRet=0
	Set @iIdSin = convert(integer,@dcIdSin)

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO') 
	Begin
		Exec @iRet =SHERPA_PRO.sysadm.PS_S02_UTILISATEUR_SITE_V01 @iIdSin, 1, @sCanal OUTPUT, @sEMail OUTPUT, @sIdentifiant OUTPUT
	End 
	else
	Begin
		Exec @iRet =SHERPA_SIM.sysadm.PS_S02_UTILISATEUR_SITE_V01 @iIdSin, 1, @sCanal OUTPUT, @sEMail OUTPUT, @sIdentifiant OUTPUT
	End
	
	Return @iRet
go

-------------------------------------------------------------------
--
-- Procédure            : DW_U01_ASSURE_V01
-- Auteur               : FPI
-- Date                 : 17/08/2009
-- Libellé              :        
-- Commentaires         : mise … jour de l'adresse de l'assure
--                        ( tables w_sin & w_inter )
--
-- Références           : [DCMP090404]
--  
--
-- Retourne             :   
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_ASSURE_V01' AND type = 'P' )
        DROP procedure sysadm.DW_U01_ASSURE_V01
Go

CREATE procedure sysadm.DW_U01_ASSURE_V01
@iIdSin	    Integer    ,
@sCodCiv    Varchar(10),
@sNom       Varchar(35),
@sPrenom    Varchar(35),
@sAdr1      Varchar(35),
@sAdr2      Varchar(35),
@sAdrCp     Char(5)    ,
@sAdrVille  Varchar(35),
@sMajPar    Varchar(4),
@sAdrMail	VarChar(120)
AS

Declare @iRet        Integer
Declare @dcIdI       Decimal(7,0) /* #2 */  
Declare @sCodCiv_I   Char(1)    
Declare @sLib_I      Varchar(70)
Declare @sAdr1_I     Varchar(35)
Declare @sAdr2_I     Varchar(35)
Declare @sAdrCp_I    Char(5)    
Declare @sAdrVille_I Varchar(35)

Declare @sCodCiv_S   Char(1)    
Declare @sLib_S      Varchar(70)
Declare @sAdr1_S     Varchar(35)
Declare @sAdr2_S     Varchar(35)
Declare @sAdrCp_S    Char(5)    
Declare @sAdrVille_S Varchar(35)

Declare @dcIdSin Decimal(10,0)   /* #2 */ -- [PI062]

Select @dcIdSin = Convert ( Decimal(10,0) , @iIdSin ) -- [PI062]



                                                     /*---------------------------------------------------------------------*/
If @sPrenom is null            Select @sPrenom = ''  /* Pour les st‚ le libellé est stock‚ dans le nom : Le prenom est vide */
If Datalength ( @sPrenom ) < 1 Select @sPrenom = ''  /* Je transforme la valeur pour ne pas laisser null                    */
                                                     /*---------------------------------------------------------------------*/

If @sCodCiv = '5' Select @sPrenom = ''  /* #3 */


/*------------------------------------------------------------------*/
/* Correction temporaire suite pb code civilit‚                     */
/* Pb je passait le libellé au lieu du code                         */
/*    @sCodCiv chang‚ de char(1) en varchar(10)                     */
/*------------------------------------------------------------------*/

	/*------------------------------------------------------------------*/
	/* PEGASE & SIMPA	SAVANE                                      */
	/*  1       M. 		1   M.                                      */
	/*  2       Mme	        2   Mme                                     */
	/*  3       Mlle	3   Mlle                                    */
	/*  4       M. ou Mme	4   Ste                                     */
	/*  5       Ste		5   Dr.                                     */
	/*------------------------------------------------------------------*/

Select @sCodCiv =
    Case @sCodCiv
      When 'M.'        Then '1'
      When 'Mme'       Then '2'
      When 'Mlle'      Then '3'
      When 'M. ou Mme' Then '4'
      When 'Ste'       Then '5'
      Else             @sCodCiv
    End

/*------------------------------------------------------------------*/
/* Fin de correction provisoire                                     */
/*------------------------------------------------------------------*/


/*------------------------------------------------------------------*/
/* (1) Y a-t-il la mˆme adresse entre w_sin et inter Assur‚         */
/*------------------------------------------------------------------*/

  /* Adresse de l'interlocuteur assur‚ */

  SELECT 
      @dcIdI       = i.id_i      ,
      @sCodCiv_I   = i.cod_civ   ,
      @sLib_I      = i.nom       ,
      @sAdr1_I     = i.adr_1     ,
      @sAdr2_I     = i.adr_2     ,
      @sAdrCp_I    = i.adr_cp    ,
      @sAdrVille_I = i.adr_ville 
  FROM
      sysadm.w_inter i
  WHERE
      i.id_sin    =  @dcIdSin  And
      i.cod_inter = 'A'

  If @sLib_I      is null Select @sLib_I      = ''
  If @sAdr1_I     is null Select @sAdr1_I     = ''
  If @sAdr2_I     is null Select @sAdr2_I     = ''
  If @sAdrCp_I    is null Select @sAdrCp_I    = ''
  If @sAdrVille_I is null Select @sAdrVille_I = ''
  

  /* Adresse de l'assur‚ sur w_sin     */

  SELECT 
      @sCodCiv_S   = s.cod_civ   ,
      @sLib_S      = rtrim(s.prenom) + ' ' + rtrim( s.nom) ,
      @sAdr1_S     = s.adr_1     ,
      @sAdr2_S     = s.adr_2     ,
      @sAdrCp_S    = s.adr_cp    ,
      @sAdrVille_S = s.adr_ville 
  FROM
      sysadm.w_sin s
  WHERE
      s.id_sin =  @dcIdSin  


  If @sLib_S      is null Select @sLib_S      = ''
  If @sAdr1_S     is null Select @sAdr1_S     = ''
  If @sAdr2_S     is null Select @sAdr2_S     = ''
  If @sAdrCp_S    is null Select @sAdrCp_S    = ''
  If @sAdrVille_S is null Select @sAdrVille_S = ''
  

/*------------------------------------------------------------------*/
/* (2) Mise … jour des coordonn‚es sur l'inter Assur‚               */
/*------------------------------------------------------------------*/


If @sLib_S   = @sLib_I   And @sAdr1_S     = @sAdr1_I     And @sAdr2_S = @sAdr2_I And
   @sAdrCp_S = @sAdrCp_I And @sAdrVille_S = @sAdrVille_I

         /*------------------------------------------------------------------*/
   Begin /* Debut : W_SIN & W_INTER Mˆmes coordonn‚es                        */
         /*------------------------------------------------------------------*/

	UPDATE sysadm.w_inter 
	   SET cod_civ  = @sCodCiv,
	       nom      = @sPrenom + ' ' + @sNom,
	       adr_1    = @sAdr1,
	       adr_2    = @sAdr2,
	       adr_cp   = @sAdrCp,
	       adr_ville= @sAdrVille,
	       maj_par  = @sMajPar,
	       maj_le   = Getdate()
	 WHERE
	       id_sin = @dcIdSin  And
               id_i   = @dcIdI

         SELECT @iRet = @@Error

         If @iRet <> 0 Return @iRet

         /*------------------------------------------------------------------*/
   End   /* Fin   : W_SIN & W_INTER Mˆmes coordonn‚es                        */
         /*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* (3) Mise … jour des coordonn‚es sur la table w_sin               */
/*------------------------------------------------------------------*/
/* #1 alt_adr='0'                                                   */
/*------------------------------------------------------------------*/

UPDATE sysadm.w_sin 
   SET cod_civ  = @sCodCiv,
       nom      = @sNom,
       prenom   = @sPrenom,
       adr_1    = @sAdr1,
       adr_2    = @sAdr2,
       adr_cp   = @sAdrCp,
       adr_ville= @sAdrVille,
       alt_adr  = 'O',
       maj_par  = @sMajPar,
       maj_le   = Getdate()
 WHERE
       id_sin = @dcIdSin 

       SELECT @iRet = @@Error

-- V01
If @iRet <> 0 Return @iRet

If @sAdrMail is null Select @sAdrMail      = ''

If @sAdrMail <> '' 
Begin
UPDATE sysadm.w_inter 
  SET adr_mail=@sAdrMail,
      alt_suivi_mail='O', -- FPI - 04/09/2009
       maj_par  = @sMajPar,
       maj_le   = Getdate()
   WHERE
	    id_sin = @dcIdSin  And
        id_i  = @dcIdI

  SELECT @iRet = @@Error
End

Return @iRet

Go


--  JFF		12/02/2016		[PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_INFO_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_INFO_COMMANDE
Go

CREATE procedure sysadm.DW_S01_INFO_COMMANDE
@iIdSin		Decimal(10,0)   -- [PI062]
AS

Declare @iMax Integer

Select id_seq, id_cmd_frn FROM sysadm.w_commande WHERE id_sin = @iIdSin 
Union
Select id_seq, id_cmd_frn FROM sysadm.commande   WHERE id_sin = @iIdSin 
Order by
id_seq


GO

-- JFF      12/02/2016   [PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_INTER_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_INTER_V01
Go

CREATE procedure sysadm.PS_I01_W_INTER_V01
@iIdSin         Integer     ,
@iIdInter       Integer     ,
@iIdProd        Integer     ,
@sCodInter      Char(1)     ,
@sCodCiv        Char(1)     ,
@sNom           Varchar(35) ,
@sPrenom        Varchar(35) ,
@sAdr1          Varchar(35) ,
@sAdr2          Varchar(35) ,
@sAdrCp         Char(5)     ,
@sAdrVille      Varchar(35) ,
@sNumTelD       Varchar(20) ,
@sNumTelB       Varchar(20) ,
@sNumFax        Varchar(20) ,
@sCodBq         Varchar(5)  ,
@sCodAg         Varchar(5)  ,
@sRibBq         Varchar(5)  ,
@sRibGui        Varchar(5)  ,
@sRibCpt        Varchar(11) ,
@sRibCle        Varchar(2)  ,
@sCodOper       Varchar (4) ,
@sIdCourGest    Varchar (6) ,
@iCodSms        Integer,
@sNumSms        Varchar(20),
@sAdrMel        Varchar(50),
@sRetour	Varchar (60)  Output

As

Declare @iRet    Integer
Declare @dtJour  Datetime
Declare @sModeReg Varchar(2)
Declare @dcIdSin Decimal ( 10 ) -- [PI062]

Select @dtJour  = GetDate ()
Select @iRet    = 0
Select @sRetour = 'OK'    

Set @dcIdSin = Convert ( Decimal ( 10 ) , @iIdSin ) -- [PI062]


If @sCodInter = 'A' 

         /*------------------------------------------------------------------*/
   Begin /* D‚claration : Cr‚ation ASSURE dans w_inter                       */
         /*------------------------------------------------------------------*/

        /* #2 si Soci‚t‚ Je met le prenom = '' */

        If @sCodCiv = '5' Select @sPrenom = ''   

    	SELECT @sModeReg  = p.cod_mode_reg
	  FROM sysadm.produit p
	 WHERE
               p.id_prod      = @iIdProd And
               p.cod_dest_reg = 'A'


   	Exec @iRet = sysadm.PS_I02_W_INTER_WKF 
                   @iIdSin    , @sCodCiv  , @sNom       , @sPrenom    , @sAdr1   ,
                   @sAdr2     , @sAdrCp   , @sAdrVille  , @sModeReg   , @sNumTelD,
                   @sNumTelB  , @sNumFax  , @sRibBq     , @sRibGui    , @sRibCpt ,
                   @sRibCle   , @dtJour   , @dtJour     , @sCodOper

	If @iRet <> 1
           Begin
             Select @sRetour = 'PS_I01_W_INTER/PS_I02_W_INTER_WKF:Erreur Cr‚ation inter assur‚' 
             Return -1
           End

   End

If @sCodInter = 'B'

         /*------------------------------------------------------------------*/
   Begin /* D‚claration : Cr‚ation BANQUE dans w_inter                       */
         /*------------------------------------------------------------------*/

    	SELECT @sModeReg  = p.cod_mode_reg
	  FROM sysadm.produit p
	 WHERE
               p.id_prod      = @iIdProd And
               p.cod_dest_reg = 'B'

   	Exec @iRet = sysadm.PS_I03_W_INTER_WKF 
                   @iIdSin   , @sNom      , @sAdr1    , @sAdr2    , @sAdrCp   ,
                   @sAdrVille, @sNumTelB  , @sModeReg , @sCodBq   , @sCodAg   ,
                   @dtJour   , @dtJour    , @sCodOper

	If @iRet <> 1
           Begin
             Select @sRetour = 'PS_I01_W_INTER/PS_I03_W_INTER_WKF:Erreur Cr‚ation inter banque' 
             Return -1
           End

   End

/*------------------------------------------------------------------*/
/* D‚claration : Cr‚ation banque 30066/99998 pour produits          */
/*   11001, 14000,  14500, 14600, 15200                             */
/*                                                                  */
/* ( on d‚clenche cette cr‚ation par un code civilite = 'X'         */
/*------------------------------------------------------------------*/

If @sCodCiv = 'X'

         /*------------------------------------------------------------------*/
   Begin /* D‚claration : Cr‚ation BANQUE 30066/99998 dans w_inter           */
         /*------------------------------------------------------------------*/


     Exec @iRet = sysadm.PS_I04_W_INTER_WKF @iIdSin, @iIdProd, @dtJour, @dtJour, @sCodOper

     If @iRet <> 1
        Begin
          Select @sRetour = 'PS_I01_INTER/PS_I04_W_INTER_WKF:Erreur Cr‚ation 30066/99998' 
          Return -1
        End
  
   End

/*------------------------------------------------------------------*/
/* Castorama : gestion d'un interlocuteur spécifique                */
/*------------------------------------------------------------------*/

If @iIdProd between 23400 and 23499  -- [PC13288]

         /*------------------------------------------------------------------*/
   Begin /* Déclaration Castorama : Création BANQUE dans w_inter                       */
         /*------------------------------------------------------------------*/

	Set @iIdInter = 0

	Select @iIdInter = Max( i.id_i ) From sysadm.w_inter i Where i.id_sin = @dcIdSin

	Set @iIdInter = @iIdInter + 1

	Insert into sysadm.w_inter 
	( id_sin,id_i,cod_inter,cod_civ,nom,adr_1,adr_2,adr_cp,adr_ville,adr_att,num_teld,num_telb,num_fax,cod_mode_reg,rib_bq,rib_gui,rib_cpt,rib_cle,mt_a_reg,mt_reg,v_ref1,v_ref2,cod_ag,cod_bq,cpt_cour,cpt_valide,alt_valide,alt_part,alt_ps,alt_pce,alt_quest,id_cour,id_nat_cour,alt_courgest,id_i_db,id_courj,cree_le,maj_le,maj_par,ordre_cheque,num_let_cheque,id_four,alt_suivi_mail,adr_mail )
	Select 
           @dcIdSin	as	id_sin		,  -- [PI062]
           @iIdInter	as	id_i		,
           'F'		as	cod_inter	,
           5		as	cod_civ		,
           a.lib_ag	as	nom		,
           a.adr_1	as	adr_1		,
           a.adr_2	as	adr_2		,
           a.adr_cp	as	adr_cp		,
           a.adr_ville	as	adr_ville	,
           null		as	adr_att		,
           null		as	num_teld	,
           null		as	num_telb	,
           null		as	num_fax		,
           'FM'		as	cod_mode_reg	,
           null		as	rib_bq		,
           null		as	rib_gui		,
           null		as	rib_cpt		,
           null		as	rib_cle		,
           0		as	mt_a_reg	,
           0		as	mt_reg		,
           null		as	v_ref1		,
           null		as	v_ref2		,
           null		as	cod_ag		,
           null		as	cod_bq		,
           0		as	cpt_cour	,
           1		as	cpt_valide	,
           'N'		as	alt_valide	,
           'N'		as	alt_part	,
           'N'		as	alt_ps		,
           'N'		as	alt_pce		,
           'N'		as	alt_quest	,
           null		as	id_cour		,
           null		as	id_nat_cour	,
           'N'		as	alt_courgest	,
           null		as	id_i_db		,
           null		as	id_courj	,
           getdate()	as	cree_le		,
           getdate()	as	maj_le		,
           @sCodOper	as	maj_par		,
           null		as	ordre_cheque	,
           null		as	num_let_cheque	,
           a.id_bq	as	id_four		,
			'N'		as	alt_suivi_mail,
			NULL	as	adr_mail
	From
	   sysadm.agence a
	Where
   	   a.id_bq = 'CAS' And not exists
          ( select * from sysadm.w_inter v 
             where 
                   v.id_sin     = @dcIdSin  and  -- [PI062]
                   v.cod_inter  = 'F'      and
                   a.lib_ag     = v.nom    and
	           a.lib_ag     = v.nom	   and
        	   a.adr_1      = v.adr_1  and
                   a.adr_cp	= v.adr_cp and
                   a.adr_ville	= v.adr_ville	)
            

	Set @iRet = @@error

	If @iRet <> 0
           Begin
             Select @sRetour = 'PS_I01_W_INTER:Erreur Création inter Castorama' 
             Return -1
           End
	Else
           Begin
             Set @iRet = 1
           End

   End

-- #1 [PHG] Création Interlocuteur ABD Games pour Scores Games, Produit 23100,23101,23102,23103,23104,23105  
If @iIdProd in ( 23100,23101,23102,23103,23104,23105 )

         /*------------------------------------------------------------------*/
   Begin /* Déclaration ScoreGames : Création BANQUE dans w_inter                       */
         /*------------------------------------------------------------------*/

	Set @iIdInter = 0

	Select @iIdInter = Max( i.id_i ) From sysadm.w_inter i Where i.id_sin = @dcIdSin  -- [PI062]

	Set @iIdInter = @iIdInter + 1

	Insert into sysadm.w_inter 
	( id_sin,id_i,cod_inter,cod_civ,nom,adr_1,adr_2,adr_cp,adr_ville,adr_att,num_teld,num_telb,num_fax,cod_mode_reg,rib_bq,rib_gui,rib_cpt,rib_cle,mt_a_reg,mt_reg,v_ref1,v_ref2,cod_ag,cod_bq,cpt_cour,cpt_valide,alt_valide,alt_part,alt_ps,alt_pce,alt_quest,id_cour,id_nat_cour,alt_courgest,id_i_db,id_courj,cree_le,maj_le,maj_par,ordre_cheque,num_let_cheque,id_four,alt_suivi_mail,adr_mail )
	Select 
           @dcIdSin	as	id_sin		,  -- [PI062]
           @iIdInter	as	id_i		,
           'F'		as	cod_inter	,
           5		as	cod_civ		,
           a.lib_ag	as	nom		,
           a.adr_1	as	adr_1		,
           a.adr_2	as	adr_2		,
           a.adr_cp	as	adr_cp		,
           a.adr_ville	as	adr_ville	,
           null		as	adr_att		,
           null		as	num_teld	,
           null		as	num_telb	,
           null		as	num_fax		,
           'FM'		as	cod_mode_reg	,
           null		as	rib_bq		,
           null		as	rib_gui		,
           null		as	rib_cpt		,
           null		as	rib_cle		,
           0		as	mt_a_reg	,
           0		as	mt_reg		,
           null		as	v_ref1		,
           null		as	v_ref2		,
           null		as	cod_ag		,
           null		as	cod_bq		,
           0		as	cpt_cour	,
           1		as	cpt_valide	,
           'N'		as	alt_valide	,
           'N'		as	alt_part	,
           'N'		as	alt_ps		,
           'N'		as	alt_pce		,
           'N'		as	alt_quest	,
           null		as	id_cour		,
           null		as	id_nat_cour	,
           'N'		as	alt_courgest	,
           null		as	id_i_db		,
           null		as	id_courj	,
           getdate()	as	cree_le		,
           getdate()	as	maj_le		,
           @sCodOper	as	maj_par		,
           null		as	ordre_cheque	,
           null		as	num_let_cheque	,
           a.id_bq	as	id_four		,
			'N'		as	alt_suivi_mail,
			NULL	as	adr_mail
	From
	   sysadm.agence a
	Where
   	   a.id_bq = 'SCG' And not exists
          ( select * from sysadm.w_inter v 
             where 
                   v.id_sin     = @iIdSin  and
                   v.cod_inter  = 'F'      and
                   a.lib_ag     = v.nom    and
	           a.lib_ag     = v.nom	   and
        	   a.adr_1      = v.adr_1  and
                   a.adr_cp	= v.adr_cp and
                   a.adr_ville	= v.adr_ville	)
            

	Set @iRet = @@error

	If @iRet <> 0
           Begin
             Select @sRetour = 'PS_I01_W_INTER:Erreur Création inter ScoreGames' 
             Return -1
           End
	Else
           Begin
             Set @iRet = 1
           End

   End
-- Fin Modif #1 [PHG]
   
Return @iRet

GO


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_SIN' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_SIN
Go

CREATE procedure sysadm.PS_I01_W_SIN
@iIdSin           Integer     OutPut,
@iIdProd          Integer     ,
@iIdEts           Integer     Output, 
@sLibEts          Varchar(35) Output,
@sIdAdh           Varchar(19) Output, 
@iIdsDos          Integer     ,
@iOption          Integer     ,
@dtDteDecl        Datetime    , 
@dtDteSurv        Datetime    ,
@dtDteAdh         Datetime    ,  
@dtDteSous        Datetime    , 
@dtDteOpt         Datetime    , 
@dtDteResil       Datetime    , 
@dtDteFinGti      Datetime    , 
@sCodCiv          Char(1)     ,
@sNom             Varchar(35) ,
@sPrenom          Varchar(35) ,
@sAdr1            Varchar(35) ,
@sAdr2            Varchar(35) ,
@sAdrCp           Char(5)     ,
@sAdrVille        Varchar(35) ,
@sNumTelD         Varchar(20) ,
@sNumTelB         Varchar(20) ,
@sNumFax          Varchar(20) ,
@sIdCanal  	  Char(1)     ,
@sCodIProv	  Char(1)     ,
@sTxtMess  	  Varchar(254),
@sCodOper         Varchar (4) ,
@sNumPort         Varchar(19) , 
@sNumImeiPort     Varchar(19) , 
@sMarqPort        Varchar(35) , 
@sModlPort        Varchar(35) , 
@dtAchPort        Datetime    , 
@dtOuvLigPort     Datetime    ,
@sIdContratAbonne Varchar(20) ,
@iIdHlr           Integer     ,
@iIdOrianMarque   Integer     ,
@iIdOrianModele   Integer     ,
@lIdBoutique      Integer     ,
@sRetour	  Varchar (60)  Output

As

Declare @sCodProvPers   Char(1)
Declare @sIdTypeCarte   Char(3)
Declare @sCodAdh        Char(1)
Declare @sCodAdhInit    Char(1)
Declare @sCodModeReg    Varchar(2)

Declare @iCodTel        Integer
Declare @iRet           Integer
Declare @iIdGrp         Integer 
Declare @iIdPersonne    Integer 
Declare @iNbAffilier    Integer
Declare @iIdCarte       Integer
Declare @iIdAdh         Integer
Declare @iIdEts1        Integer
Declare @iIdEts2        Integer
Declare @dtJour         Datetime


Select @dtJour  = GetDate ()
Select @iRet    = 1
Select @sRetour = 'OK'    
Select @iIdCarte    = 0
Select @sIdTypeCarte= '00'

/*------------------------------------------------------------------*/
/* #1 V‚rification si assur‚ de type soci‚t‚ ( civilit‚ 5 )         */
/*    je positionne le pr‚nom … ''                                  */
/*------------------------------------------------------------------*/

If @sCodCiv = '5' Select @sPrenom = ''

/*------------------------------------------------------------------*/
/* R‚cup‚ration des donn‚es depuis la base SIMPA                    */
/*------------------------------------------------------------------*/
    
   SELECT @sCodAdh     = cod_adh,
          @iCodTel     = cod_tel,
          @sCodAdhInit = cod_adh
     FROM
          sysadm.produit
    WHERE
          id_prod = @iIdProd
                                        /*-------------------------------------------------------------------*/
                                        /* #1 produit tel = adh‚sion facultative                             */
                                        /* Sur SIMPA pour ne pas avoir … basculer les produits de t‚l‚phonie */
                                        /* en m‚thode d'adh‚sion facultative, je considŠre cod_adh = 7 en    */
                                        /* fonction du flag cod_tel                                          */
                                        /* #2 le 15/11/02 : Vu MLB / CCH Pour le produit 1900 Securiplus BPA */
                                        /*               On ne possŠde les adhesions que jusqu'au 31/08/01   */
                                        /*               ensuite saisie en adh facultative                   */
                                        /* #3 le 20/11/02 : Demande C.Chanal + CVerrier : retrait m‚thode 7  */
                                        /* #6 le 08/07/03 : Traitement du cas du 1907 Vu avec SLE            */
                                        /* #7 Le 21/10/03 : Test cod_tel > 0                                 */
                                        /* #8 Le 31/01/04 : Traitement du cas de 19100 Vu avec HM            */
                                        /*-------------------------------------------------------------------*/

                                     
                                     
   If @iCodTel > 0 Or ( @iIdProd = 1907 Or @iIdProd = 19100 ) Select @sCodAdh = '7'

   If @sCodAdh = '7' And @sIdAdh <> '0000000' Select @sCodAdh = @sCodAdhInit


   If @sCodAdh = '7' And @sIdAdh =  '0000000'

            /*------------------------------------------*/
      Begin /*  Debut : tol‚rence adh‚sion non saisie   */
            /*------------------------------------------*/

   	Exec @iRet = sysadm.PS_X_INCREMENTER 'ID_ADH', @iIdAdh OUTPUT
   
        If @iRet = -1
           Begin
             Select @sRetour = 'PS_I01_W_SIN:Erreur attribution id_adh' 
             Return -1
           End

        Select @sIdAdh  = Convert ( varchar(19), @iIdAdh )
        Select @iIdsDos = 0
        --Select @iIdEts  = 0 #6 Je laisse le code ets saisi sur le contact comme valeur par défaut ( sinon pb pour le 1907 )

        /* On essaye d'interpr‚ter le code ets li‚ au produit */

           SELECT @iIdEts1 = Min ( e.id_ets ),
                  @iIdEts2 = Max ( e.id_ets ),
                  @iIdGrp  = Max ( e.id_grp )
             FROM
                  sysadm.etablissement e
            WHERE
                  e.id_prod = @iIdProd

            If @iIdEts1 = @iIdEts2 Select @iIdEts = @iIdEts1

            /*------------------------------------------*/
      End   /*  Fin   : tol‚rence adh‚sion non saisie   */
            /*------------------------------------------*/


   If @sCodAdh in ( '3', '4' )

            /*------------------------------------------*/
      Begin /*  Debut : controle du type de carte       */
            /*------------------------------------------*/

	   Exec sysadm.PS_S01_CARTE_SINISTRE @sIdAdh, @iIdProd, @iIdCarte     Output, 
	                                                        @sIdTypeCarte Output,
		                                                @iIdGrp       Output,
	                                                        @iNbAffilier  Output

	   If @sIdTypeCarte is Null
	       Begin
	         Select @sRetour = @sIdAdh  + ' non couverte'
	         Return -1
	       End

/*         Le refus sera effectu‚ sur la grille de gestion : donc contr“le bloquant d‚sactiv‚

           If @iNbAffilier = 0
               Begin
                 Select @sRetour = 'Carte non affili‚e au produit ' + convert( varchar(10), @iIdProd )
               End
*/

          
            
            /*------------------------------------------*/
      End   /*  Fin   : controle du type de carte       */
            /*------------------------------------------*/


    If @sCodAdh = '3'

            /*------------------------------------------*/
      Begin /*  Debut : interpr‚tation id_ets = id_grp  */
            /*------------------------------------------*/

           If @iIdGrp Is Not Null
              Begin
	           Select @iIdEts  = @iIdGrp
              End
           Else
              Begin
                   Select @iIdEts = 0
              End

            /*------------------------------------------*/
      End   /*  Fin : interpr‚tation id_ets = id_grp    */
            /*------------------------------------------*/

    /*----------------------*/
    /* Libelle groupe       */
    /*----------------------*/

     Select @sLibEts = lib_grp FROM sysadm.groupe WHERE id_grp = @iIdGrp    

    /*----------------------*/
    /* Ref dans personne    */
    /*----------------------*/

    SELECT @iIdPersonne = p.id_ordre
      FROM
           sysadm.personne p
     WHERE
           p.cod_civ   = @sCodCiv   And
           p.nom       = @sNom      And
           p.prenom    = @sPrenom   And
           p.adr_1     = @sAdr1     And
           p.adr_cp    = @sAdrCp    And
           p.adr_ville = @sAdrVille 
                
     If @iIdPersonne Is Null
           Begin
             Select @sCodProvPers = 'W'
           End
        Else
           Begin
             Select @sCodProvPers = 'P'
           End


/*------------------------------------------------------------------*/
/* Obtention d'un nouveau nø de sinistre depuis parametre           */
/*------------------------------------------------------------------*/

   Exec @iRet = sysadm.PS_X_INCREMENTER 'ID_SIN', @iIdSin OUTPUT
   
   If @iRet = -1
   Begin
     Select @sRetour = 'PS_I01_W_SIN:Erreur attribution id_sin' 
     Return -1
   End
        

/*------------------------------------------------------------------*/
/* D‚claration : Cr‚ation dans w_sin                                */
/* #4 Ajt de 5 nouvelles valeurs                                    */
/*------------------------------------------------------------------*/

   Exec @iRet = sysadm.PS_I02_W_SIN_WKF
                   @iIdSin      , @iIdProd     , @iIdEts      , @sIdAdh       ,@iIdsDos,
                   @sIdCanal    , @sCodIProv   , @dtDteDecl   , @dtDteSurv    ,@dtDteAdh,
                   @dtDteSous   , @dtDteOpt    , @iOption     , @dtDteResil   ,@dtDteFinGti,
                   @sCodCiv     , @sNom        , @sPrenom     , @sAdr1        ,@sAdr2,
                   @sAdrCp      , @sAdrVille   , @sNumFax     , @sNumTelB     ,@sNumTelD ,
                   @sTxtMess    , @iIdCarte    , @sIdTypeCarte, @iIdPersonne  ,@sCodProvPers,
                   @dtJour      , @dtJour      , @sCodOper    , @sNumPort     ,@sNumImeiPort,
                   @sMarqPort   , @sModlPort   , @dtAchPort   , @dtOuvLigPort ,@sIdContratAbonne,
		   @iIdHlr , @iIdOrianMarque , @iIdOrianModele , @lIdBoutique


   If @iRet <> 1
   Begin
     Select @sRetour = 'PS_I01_W_SIN/PS_I02_W_SIN_WKF:Erreur Cr‚ation sinistre' 
     Return -1
   End


Return @iRet


GO

--------------------------------------------------------------------
--
-- Proc‚dure            : PS_INTEGRER_CONTACT_CLIENT
-- Auteur               : FPI
-- Date                 : 17/09/2012
-- Libell‚              :        
-- Commentaires         : Intégration des contacts 
--
--
-- R‚f‚rences           : [VDoc8686]
--  
--
-- Retourne             :   
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_INTEGRER_CONTACT_CLIENT' AND type = 'P' )
        DROP procedure sysadm.PS_INTEGRER_CONTACT_CLIENT
Go

CREATE procedure sysadm.PS_INTEGRER_CONTACT_CLIENT
	@iIdClient	Integer,	
	@iIdNatTache	Integer,	
	@sTxtMsg		Varchar(254),	
	@sCodAction		Char(1),		-- « V » pour vérification, « E » pour exécuter
	@sIdOper		VarChar(4)
As
	Declare @iRet integer,
		@iIdCt integer

	Set @iRet=1
	
	IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin
		
		If not exists (select * from SHERPA_PRO.sysadm.client where id_cli=@iIdClient) set @iRet=-1
		
		-- Si contrôle NOK ou Mode 'V' Vérification, on sort
		If @iRet <> 1 Or @sCodAction = 'V' Return @iRet	
	
		EXEC @iRet = SHERPA_PRO.sysadm.PS_I02_CONTACT_V02  @iIdCt OUTPUT,
				@iIdClient, 
				3, -- Famille Autre
				4, -- Contact Information
				@iIdNatTache,
				'X', -- Canal Autre
				NULL,NULL,NULL,NULL, -- Id_prod
				'T', -- Inter Autre
				@sTxtMsg,
				@sIdOper,
				'##', -- Cod prov
				'X'		-- typ_recu
	End
	ELSE
	Begin
		If not exists (select * from SHERPA_SIM.sysadm.client where id_cli=@iIdClient) set @iRet=-1
		
		-- Si contrôle NOK ou Mode 'V' Vérification, on sort
		If @iRet =-1 Or @sCodAction = 'V' Return @iRet	
	
		EXEC @iRet = SHERPA_SIM.sysadm.PS_I02_CONTACT_V02  @iIdCt OUTPUT,
				@iIdClient, 
				3, -- Famille Autre
				4, -- Contact Information
				@iIdNatTache,
				'X', -- Canal Autre
				NULL,NULL,NULL,NULL, -- Id_prod
				'T', -- Inter Autre
				@sTxtMsg,
				@sIdOper,
				'##', -- Cod prov
				'X'		-- typ_recu
	End
	
	Return @iRet

Go

--------------------------------------------------------------------
--
-- Proc‚dure            : PS_I_NUM_CARTE_CADEAU_CONFO
-- Auteur               : FABRY JF
-- Date                 : 7/09/2012
-- Libell‚              :        
-- Commentaires         : Intégration des contacts 
--
--
-- R‚f‚rences           : [MANTIS5071][PC543]
--  
--
-- Retourne             :   
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_NUM_CARTE_CADEAU_CONFO' AND type = 'P' )
        DROP procedure sysadm.PS_I_NUM_CARTE_CADEAU_CONFO
Go

CREATE procedure sysadm.PS_I_NUM_CARTE_CADEAU_CONFO
	@dcIdSin Decimal ( 10 ), -- [PI062]
	@sNumCarte VarChar ( 50 ),
	@sCodOper VarChar ( 4 )
AS

DECLARE @RC int
DECLARE @iCli int
DECLARE @iIdInfo int
DECLARE @dcValInfo decimal(11,2)
DECLARE @dtValInfo datetime
DECLARE @sValInfo varchar(60)
DECLARE @dtCreeLe datetime
DECLARE @dtMajLe datetime
DECLARE @sMajPar varchar(4)
DECLARE @iNbLig int

-- TODO: Set parameter values here.

Set @dtCreeLe = GetDate()

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
	
		Select @iCli = s.id_cli
		From   SHERPA_PRO.sysadm.sinistre s
		Where  s.id_sin = @dcIdSin
	
		EXECUTE @RC = [SHERPA_PRO].[sysadm].[PS_I01_INFO_CLIENT] 
		   @iCli
		  ,49
		  ,null
		  ,null
		  ,@sNumCarte 
		  ,@dtCreeLe
		  ,@dtCreeLe
		  ,@sCodOper
		  ,@iNbLig OUTPUT
	END
	ELSE
	BEGIN
	
		Select @iCli = s.id_cli
		From   SHERPA_SIM.sysadm.sinistre s
		Where  s.id_sin = @dcIdSin
	
		EXECUTE @RC = [SHERPA_SIM].[sysadm].[PS_I01_INFO_CLIENT] 
		   @iCli
		  ,49
		  ,null
		  ,null
		  ,@sNumCarte 
		  ,@dtCreeLe
		  ,@dtCreeLe
		  ,@sCodOper
		  ,@iNbLig OUTPUT
	END

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[PS_V01_TRAVAIL_ADHESION_V01]') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[PS_V01_TRAVAIL_ADHESION_V01]
GO


CREATE procedure [sysadm].[PS_V01_TRAVAIL_ADHESION_V01]
@iIdSinVerif   Integer     ,
@sRetour  Varchar(60) Output

As
------------------------------------------------------------------------------------------------
-- [PS_V01_TRAVAIL_ADHESION_V01] FS le 09/04/2013 : Verification des travaux sur la même adhésion
-- [VDOC10312]
-- JFF      12/02/2016   [PI062]
------------------------------------------------------------------------------------------------	

Declare @iIdSinW       Integer
Declare @dcIdSinVerif  Decimal(10,0)  -- [PI062]
Declare @sEtatW        Char(1)
Declare @iRet          Integer
Declare @dDteRecu      Datetime

Set @dcIdSinVerif = Convert ( Decimal(10,0), @iIdSinVerif )  -- [PI062]

Set @sRetour = 'OK'
Set @iRet = 1

/*-------------------------------------------------------------------*/
/* Quel est le plus petit travail présent pour la même adhésion      */
/*    Autre que @iIdSinVerif contrôlé ?                              */ 
/*-------------------------------------------------------------------*/
/* Correctif le 30/04/2013
   -----------------------
   Mettre le blocage sur le dossier dont l’arrivée courrier est la plus récente,
   il faudra donc gérer ou valider le dossier dont l’arrivée courrier est la plus ancienne.
   
   Correctif le 23/01/2015 : [ITSM266682] : Adhésion à carte masquées
   
*/
	
	Set @iIdSinW = 0
	
	-- [ITSM266682] Partie 1 : Vérification pour adhésion numériques 
	
	SELECT top 1
		 @iIdSinW =  CONVERT ( integer, wq.id_sin ) 
		  FROM sysadm.w_queue wq,
			   sysadm.w_sin s ,
			   sysadm.w_sin sa
		 WHERE 
				   s.id_prod = sa.id_prod                      And
				   s.id_ets  = sa.id_ets                       And
				   s.id_adh  = sa.id_adh                       And
				   s.id_sdos = sa.id_sdos                      And
	               
				   sa.id_adh <> '0'                            And
				   sa.id_adh <> '0000000'                      And  -- [Itsm64071]
				   ISNUMERIC( s.id_adh) = 1                    And  -- [ITSM266682] 
				   sa.id_sin =Convert( decimal(10), wq.id_sin ) And -- [PI062]
				   s.id_sin = @dcIdSinVerif    
		 Order by wq.dte_recu , CONVERT ( integer, wq.id_sin ) 
		 
	-- [ITSM266682] Partie 2 : Vérification pour adhésion à carte codée
	  If @iIdSinW is Null
		Begin	
			SELECT top 1
			 @iIdSinW =  CONVERT ( integer, wq.id_sin ) 
			  FROM sysadm.w_queue wq,
				   sysadm.w_sin s ,
				   sysadm.w_sin sa
			 WHERE 
					   s.id_prod = sa.id_prod                      And
					   s.id_ets  = sa.id_ets                       And
					   s.id_adh  = sa.id_adh                       And
					   s.id_sdos = sa.id_sdos                      And
		               
					   sa.id_adh <> '0'                            And
					   sa.id_adh <> '0000000'                      And  -- [Itsm64071]
					   ISNUMERIC( s.id_adh) = 0                    And  -- [ITSM266682] Adhésion non numérique
					   sa.nom    = s.nom                           And  -- [ITSM266682] Jointure nom
					   sa.prenom = s.prenom                        And  -- [ITSM266682] Jointure prénom
					   sa.id_sin =Convert( decimal(10), wq.id_sin ) And -- [PI062]
					   s.id_sin = @dcIdSinVerif    
			 Order by wq.dte_recu , CONVERT ( integer, wq.id_sin ) 
			 
		End
				   
	If @iIdSinW <> 0 And @iIdSinW <> @dcIdSinVerif
	
	Begin -- Il existe un autre travail à gérer
	
		Select @sEtatW = cod_etat, @dDteRecu = dte_recu from sysadm.w_queue where id_sin = @iIdSinW
		
		If @sEtatW = '5' Set @sRetour = 'Travail sur ' + Convert ( varchar(10), @iIdSinW ) + ' du ' + CONVERT ( varchar(10), @dDteRecu, 103 ) + ' à valider d''abord'
		If @sEtatW = '1' Set @sRetour = 'Travail sur ' + Convert ( varchar(10), @iIdSinW ) + ' du ' + CONVERT ( varchar(10), @dDteRecu, 103 ) + ' à gérer d''abord'
	    set @iRet = -1
	    
	End   -- Il existe un autre travail à gérer
	           
	Return @iRet

GO

grant execute on sysadm.PS_V01_TRAVAIL_ADHESION_V01 to rolebddsinistres
Go


-- JFF      12/02/2016   [PI062]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[Scripting_Sinistre_Charger_V100]') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[Scripting_Sinistre_Charger_V100]
Go

CREATE procedure [sysadm].[Scripting_Sinistre_Charger_V100] 
--------------------------------------------------------------------------------------------------------------
-- sysadm.Scripting_Sinistre_Charger_V100 FS	le 25/11/2013 Lecture des information d'un dossier de sinistre
-- Retour : Select
/*
Exec sysadm.Scripting_Sinistre_Charger_V100 3358988
*/
--------------------------------------------------------------------------------------------------------------
-- Procédure à compiler dans l'application de gestion : SIMPA2_TRT
--------------------------------------------------------------------------------------------------------------
 @iIdSin        integer	 -- N° du sinistre
 
As

Declare @dtSurv Datetime
Declare @sLibNatSin Varchar(60)
Declare @sLibGti    varchar(60)
Declare @sLibRefus  Varchar(60)
Declare @dcIdSin    Decimal ( 10 ) -- [PI062]
Declare @dcMtTotal  Decimal ( 11,2 ) 
Declare @dcMtReg    Decimal ( 11,2 )
Declare @dcMtAReg   Decimal ( 11,2 )
Declare @iNbSin     Integer

Set @dtSurv     = null
Set @sLibNatSin = null
Set @sLibGti    = null
Set @sLibRefus  = null
Set @dcMtTotal  = 0
Set @dcMtReg    = 0
Set @dcMtAReg   = 0

Set @dcIdSin = convert ( decimal (10), @iIdSin ) -- [PI062]
Select @iNbSin = COUNT(*) from sysadm.sinistre where id_sin = @dcIdSin

-------------------------------------------------------------
-- Données si le sinistre est en instruction seulement
-------------------------------------------------------------
If @iNbSin = 0 -- En instruction seulement
Begin  
	-- Date survenance, nature de sinistre
	Select 
	@dtSurv     =s.dte_surv ,
	@sLibNatSin = sysadm.FN_CODE_NUM ( s.id_natsin , '+NS' )
	From sysadm.w_sin s 
	 inner join sysadm.w_gar_sin gs on s.id_sin = gs.id_sin
	Where 
	s.id_sin=@dcIdSin
	
	-- La 1ere garantie, le 1er motif de refus
	Select top 1
	@sLibGti   = sysadm.FN_CODE_NUM ( gs.id_gti , '-GA' ),
	@sLibRefus = sysadm.FN_CODE_NUM ( re.id_motif, '+RE' ) 
	From sysadm.w_gar_sin gs 
	Left outer join sysadm.w_refus re on gs.id_sin = re.id_sin and gs.id_gti = re.id_gti
	Where 
	  gs.id_sin   = @dcIdSin 
	and gs.cod_etat <> 900 -- sans suite
	Order by  gs.cree_le desc, re.id_motif asc

End

-------------------------------------------------------------
-- Données si le sinistre est validé dans la base permanente
-------------------------------------------------------------
If @iNbSin > 0 -- Sinistre validé
Begin 
	-- Date survenance, nature de sinistre
	Select 
	@dtSurv     = s.dte_surv ,
	@sLibNatSin = sysadm.FN_CODE_NUM ( s.id_natsin , '+NS' )
	From sysadm.sinistre s 
	inner join sysadm.gar_sin gs on s.id_sin = gs.id_sin
	Where 
	s.id_sin=@dcIdSin 
	
	-- La 1ere garantie, le 1er motif de refus
	Select top 1
	@sLibGti   = sysadm.FN_CODE_NUM ( gs.id_gti , '-GA' ),
	@sLibRefus = sysadm.FN_CODE_NUM ( re.id_motif, '+RE' ) 
	From sysadm.gar_sin gs 
	Left outer join sysadm.refus re on gs.id_sin = re.id_sin and gs.id_gti = re.id_gti
	Where 
	  gs.id_sin   = @dcIdSin 
	and gs.cod_etat <> 900 -- sans suite
	Order by  gs.cree_le desc, re.id_motif asc

End   -- Sinistre validé

-------------------------------------------------------------
-- Données sur le montant de prise en charge [PS_LIRE_MONTANT_V02]
-------------------------------------------------------------
   Select @dcMtReg = IsNull (Sum ( IsNull ( mt_tot_reg , 0 ) ) , 0 ) 
   from   sysadm.reglement r
          inner join sysadm.inter i on r.id_sin = i.id_sin and r.id_i = i.id_i and i.cod_inter = 'A'
   Where  r.id_sin = @dcIdSin
   And    r.cod_mode_reg not in ( 'RI' )

   Select @dcMtAReg = IsNull ( Sum ( IsNull ( wi.mt_a_reg, 0 ) ), 0 )
   from   sysadm.w_inter wi
   Where  wi.id_sin = @dcIdSin 
   And    wi.cod_inter = 'A'
   And    wi.mt_a_reg > 0
   And    wi.cod_mode_reg <> 'FM'
   
   Set 	@dcMtTotal = @dcMtReg + @dcMtAReg
		
---------------------------------------------------------------------
-- Selection du résultat
---------------------------------------------------------------------

	Select
	  s.id_sin      as id_sin,
	  s.id_prod     as id_prod_sin,
	  p.lib_long    as lib_prod,
	  @dtSurv       as dte_surv,
	  @sLibNatSin   as lib_natsin,
	  @sLibGti      as lib_gti,
	  @sLibRefus    as lib_refus,
	  @dcMtTotal    as mt_pec,
	  sysadm.FN_GET_LIB_POLICE_V01( s.id_sin, s.id_prod,s.id_rev,-1,null) as lib_police,
	  sysadm.FN_LIB_CIE( s.id_sin ) as compagnie
	  
	From
	  sysadm.sinistre s inner join sysadm.produit p on s.id_prod = p.id_prod
	Where s.id_sin = @dcIdSin
Go

grant execute on sysadm.Scripting_Sinistre_Charger_V100 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Proc‚dure            : PS_S01_APP_A_RECUP
-- Auteur               : FPI
-- Date                 : 11/03/2014
-- Libell‚              :        
-- Commentaires         : Détermine si un appareil est à récupérer sur un dossier 
--
--
-- R‚f‚rences           : [PC938-1]
--  
--
-- Retourne             :   
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_APP_A_RECUP' AND type = 'P' )
        DROP procedure sysadm.PS_S01_APP_A_RECUP
Go

CREATE procedure sysadm.PS_S01_APP_A_RECUP
	@dcIdSin Decimal ( 10 ), -- [PI062]
	@sRet 	 Varchar(20) Output
AS

	Set @sRet='AUCUN'
	
	If Exists (select * 
		from sysadm.commande 
	where id_sin=@dcIdSin
		and id_typ_art in ('REA','PST') 
		and cod_etat <> 'ANN' and status_gc=0) Set @sRet='APP_SIN_A_RECUP'
		
	If Exists (select * 
		from sysadm.commande 
	where id_sin=@dcIdSin
		and id_typ_art ='REL'
		and cod_etat <> 'ANN' 
		and info_spb_frn_cplt like '%APP_SIN_A_RECUPERER=OUI%'
		and status_gc =0 ) Set @sRet='APP_SIN_A_RECUP'
		
	If Exists (select * 
		from sysadm.commande 
	where id_sin=@dcIdSin
		and id_typ_art ='REL'
		and cod_etat <> 'ANN' 
		and info_spb_frn_cplt like '%TYP_RELAI=PRET%'
		-- and status_gc <> 234 ) Set @sRet='APP_PRET_A_RECUP'
		and sysadm.FN_CLE_VAL('DTE_RESTIT_APP_PRET',info_frn_spb_cplt,';') = '' ) Set @sRet='APP_PRET_A_RECUP'
		
		
	If Exists (select * 
		from sysadm.commande 
	where id_sin=@dcIdSin
		and id_typ_art ='PST'
		and cod_etat <> 'ANN' 
		and status_gc<>0  
		and info_spb_frn in (976,977)) Set @sRet='APP_PRET_A_RECUP'

	Select @sRet
		
		
Go

grant execute on sysadm.PS_S01_APP_A_RECUP to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Proc‚dure            : DW_U01_ASSURE_V02
-- Auteur               : FPI
-- Date                 : 17/08/2009
-- Libell‚              :        
-- Commentaires         : mise … jour de l'adresse de l'assure
--                        ( tables w_sin & w_inter )
--
-- R‚f‚rences           : [DCMP090404]
--  
--
-- Retourne             :   
--
-------------------------------------------------------------------
-- V02 - FPI - [DCMP090574] Interprétation du numéro pour SMS
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_ASSURE_V02' AND type = 'P' )
        DROP procedure sysadm.DW_U01_ASSURE_V02
Go

CREATE procedure sysadm.DW_U01_ASSURE_V02
@iIdSin	    Integer    ,
@sCodCiv    Varchar(10),
@sNom       Varchar(35),
@sPrenom    Varchar(35),
@sAdr1      Varchar(35),
@sAdr2      Varchar(35),
@sAdrCp     Char(5)    ,
@sAdrVille  Varchar(35),
@sMajPar    Varchar(4),
@sAdrMail	VarChar(120),
@sNumGsm	Varchar(20)
AS

Declare @iRet        Integer
Declare @dcIdI       Decimal(7,0) /* #2 */  
Declare @sCodCiv_I   Char(1)    
Declare @sLib_I      Varchar(70)
Declare @sAdr1_I     Varchar(35)
Declare @sAdr2_I     Varchar(35)
Declare @sAdrCp_I    Char(5)    
Declare @sAdrVille_I Varchar(35)

Declare @sCodCiv_S   Char(1)    
Declare @sLib_S      Varchar(70)
Declare @sAdr1_S     Varchar(35)
Declare @sAdr2_S     Varchar(35)
Declare @sAdrCp_S    Char(5)    
Declare @sAdrVille_S Varchar(35)

Declare @dcIdSin Decimal(10,0)   /* #2 */  -- [PI062]

Select @dcIdSin = Convert ( Decimal(10,0) , @iIdSin )  -- [PI062]



                                                     /*---------------------------------------------------------------------*/
If @sPrenom is null            Select @sPrenom = ''  /* Pour les st‚ le libellé est stock‚ dans le nom : Le prenom est vide */
If Datalength ( @sPrenom ) < 1 Select @sPrenom = ''  /* Je transforme la valeur pour ne pas laisser null                    */
                                                     /*---------------------------------------------------------------------*/

If @sCodCiv = '5' Select @sPrenom = ''  /* #3 */


/*------------------------------------------------------------------*/
/* Correction temporaire suite pb code civilit‚                     */
/* Pb je passait le libellé au lieu du code                         */
/*    @sCodCiv chang‚ de char(1) en varchar(10)                     */
/*------------------------------------------------------------------*/

	/*------------------------------------------------------------------*/
	/* PEGASE & SIMPA	SAVANE                                      */
	/*  1       M. 		1   M.                                      */
	/*  2       Mme	        2   Mme                                     */
	/*  3       Mlle	3   Mlle                                    */
	/*  4       M. ou Mme	4   Ste                                     */
	/*  5       Ste		5   Dr.                                     */
	/*------------------------------------------------------------------*/

Select @sCodCiv =
    Case @sCodCiv
      When 'M.'        Then '1'
      When 'Mme'       Then '2'
      When 'Mlle'      Then '3'
      When 'M. ou Mme' Then '4'
      When 'Ste'       Then '5'
      Else             @sCodCiv
    End

/*------------------------------------------------------------------*/
/* Fin de correction provisoire                                     */
/*------------------------------------------------------------------*/


/*------------------------------------------------------------------*/
/* (1) Y a-t-il la mˆme adresse entre w_sin et inter Assur‚         */
/*------------------------------------------------------------------*/

  /* Adresse de l'interlocuteur assur‚ */

  SELECT 
      @dcIdI       = i.id_i      ,
      @sCodCiv_I   = i.cod_civ   ,
      @sLib_I      = i.nom       ,
      @sAdr1_I     = i.adr_1     ,
      @sAdr2_I     = i.adr_2     ,
      @sAdrCp_I    = i.adr_cp    ,
      @sAdrVille_I = i.adr_ville 
  FROM
      sysadm.w_inter i
  WHERE
      i.id_sin    =  @dcIdSin  And
      i.cod_inter = 'A'

  If @sLib_I      is null Select @sLib_I      = ''
  If @sAdr1_I     is null Select @sAdr1_I     = ''
  If @sAdr2_I     is null Select @sAdr2_I     = ''
  If @sAdrCp_I    is null Select @sAdrCp_I    = ''
  If @sAdrVille_I is null Select @sAdrVille_I = ''
  

  /* Adresse de l'assur‚ sur w_sin     */

  SELECT 
      @sCodCiv_S   = s.cod_civ   ,
      @sLib_S      = rtrim(s.prenom) + ' ' + rtrim( s.nom) ,
      @sAdr1_S     = s.adr_1     ,
      @sAdr2_S     = s.adr_2     ,
   @sAdrCp_S    = s.adr_cp    ,
      @sAdrVille_S = s.adr_ville 
  FROM
      sysadm.w_sin s
  WHERE
      s.id_sin =  @dcIdSin  


  If @sLib_S      is null Select @sLib_S      = ''
  If @sAdr1_S     is null Select @sAdr1_S     = ''
  If @sAdr2_S     is null Select @sAdr2_S     = ''
  If @sAdrCp_S    is null Select @sAdrCp_S    = ''
  If @sAdrVille_S is null Select @sAdrVille_S = ''
  

/*------------------------------------------------------------------*/
/* (2) Mise … jour des coordonn‚es sur l'inter Assur‚               */
/*------------------------------------------------------------------*/


If @sLib_S   = @sLib_I   And @sAdr1_S     = @sAdr1_I     And @sAdr2_S = @sAdr2_I And
   @sAdrCp_S = @sAdrCp_I And @sAdrVille_S = @sAdrVille_I

         /*------------------------------------------------------------------*/
   Begin /* Debut : W_SIN & W_INTER Mˆmes coordonn‚es                        */
         /*------------------------------------------------------------------*/

	UPDATE sysadm.w_inter 
	   SET cod_civ  = @sCodCiv,
	       nom      = @sPrenom + ' ' + @sNom,
	       adr_1    = @sAdr1,
	       adr_2    = @sAdr2,
	       adr_cp   = @sAdrCp,
	       adr_ville= @sAdrVille,
	       maj_par  = @sMajPar,
	       maj_le   = Getdate()
	 WHERE
	       id_sin = @dcIdSin  And
               id_i   = @dcIdI

         SELECT @iRet = @@Error

         If @iRet <> 0 Return @iRet

         /*------------------------------------------------------------------*/
   End   /* Fin   : W_SIN & W_INTER Mˆmes coordonn‚es                        */
         /*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* (3) Mise … jour des coordonn‚es sur la table w_sin               */
/*------------------------------------------------------------------*/
/* #1 alt_adr='0'                                                   */
/*------------------------------------------------------------------*/

UPDATE sysadm.w_sin 
   SET cod_civ  = @sCodCiv,
       nom      = @sNom,
       prenom   = @sPrenom,
       adr_1    = @sAdr1,
       adr_2    = @sAdr2,
       adr_cp   = @sAdrCp,
       adr_ville= @sAdrVille,
       alt_adr  = 'O',
       maj_par  = @sMajPar,
       maj_le   = Getdate()
 WHERE
       id_sin = @dcIdSin 

       SELECT @iRet = @@Error

-- V01
If @iRet <> 0 Return @iRet

If @sAdrMail is null Select @sAdrMail      = '' 

If @sAdrMail <> '' 
Begin
UPDATE sysadm.w_inter 
  SET adr_mail=@sAdrMail,
      alt_suivi_mail='O', -- FPI - 04/09/2009
       maj_par  = @sMajPar,
       maj_le   = Getdate()
   WHERE
	    id_sin = @dcIdSin  And
        id_i  = @dcIdI

  SELECT @iRet = @@Error
End

-- V02
If @iRet <> 0 Return @iRet

If @sNumGsm is null Set @sNumGsm      = '' 

If @sNumGsm <> '' 
Begin

   UPDATE sysadm.w_inter 
   SET 
      num_port_sms  = @sNumGsm,
      alt_suivi_sms = 'O',
      maj_par       = @sMajPar,
      maj_le        = Getdate()
   WHERE
      id_sin = @dcIdSin  And
      id_i   = @dcIdI

   Set @iRet = @@Error

End

Return @iRet

Go
grant execute on sysadm.DW_U01_ASSURE_V02 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I04_CONTACT_TRAVAIL_V01
-- Auteur               :       FPI
-- Date                 :       15/10/2014
-- Libell‚              :       Création simplifiée d'un contact de complément et d'un travail 
--                              dans l'application de gestion associée
--
-- Références           :       [PC14639]
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--	FPI - 30/10/2014 - [PC13419-1] - Mantis 13045
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I04_CONTACT_TRAVAIL_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I04_CONTACT_TRAVAIL_V01
GO

CREATE procedure sysadm.PS_I04_CONTACT_TRAVAIL_V01
	@dcIdSin        Decimal (  10,0 ), -- [PI062]
	@iIdSeq		Integer		,
	@sMess		varchar(508), -- [PC13419-1] - Mantis 13045 - 508 ald 254
	@sIdCanal varchar(1),
	@iIdNatTache int,
	@sMajPar varchar(4)
As
	
	IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V03 @dcIdSin, 2, @sMess, @sMajPar, 'X' , 0 , null, @sIdCanal, null, @iIdNatTache
	Else
	    EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V03 @dcIdSin, 2, @sMess, @sMajPar, 'X' , 0 , null, @sIdCanal, null, @iIdNatTache

Go

grant execute on sysadm.PS_I04_CONTACT_TRAVAIL_V01 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_ARCHIVE_REPONSE
-- Auteur               :       FPI
-- Date                 :       14/09/2016
-- Libell‚              :       Renvoie la réponse à une question de script
--
-- Références           :       [PC151259]
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_ARCHIVE_REPONSE' AND type = 'P' )
        DROP procedure sysadm.PS_S_ARCHIVE_REPONSE
GO

CREATE PROCEDURE sysadm.PS_S_ARCHIVE_REPONSE
	@idArchive int, 
	@cle	varchar(20),
	@val varchar(254) OUTPUT,
	@libVal varchar(254) OUTPUT
As
	
	Set transaction isolation level READ UNCOMMITTED
	 
	IF      @@SERVERNAME = master.dbo.SPB_FN_ServerName ('SIM')
	Begin
		select @val=a.val,
			@libVal=Case When a.id_typ_code is null Then rtrim(a.lib_val)
			When a.id_typ_code='-XX' Then rtrim(a.lib_val)
			When exists (select 1 from SHERPA_SIM.sysadm.code where id_typ_code=a.id_typ_code) Then SHERPA_SIM.sysadm.FN_CODE_NUM(convert(int,val) ,a.id_typ_code)
			When exists (select 1 from SHERPA_SIM.sysadm.code_car where id_typ_code=a.id_typ_code) Then SHERPA_SIM.sysadm.FN_CODE_CAR(val ,a.id_typ_code)
			Else rtrim(a.lib_val) End
		from SHERPA_SIM.sysadm.archive_reponse a
		where  a.id_archive=@idArchive
			and a.quest_gest like '[[]' + @cle + ']%'
	End
	Else
	Begin
		select @val=a.val,
			 @libVal=Case When a.id_typ_code is null Then rtrim(a.lib_val)
			When a.id_typ_code='-XX' Then rtrim(a.lib_val)
			When exists (select 1 from SHERPA_PRO.sysadm.code where id_typ_code=a.id_typ_code) Then SHERPA_PRO.sysadm.FN_CODE_NUM(convert(int,val) ,a.id_typ_code)
			When exists (select 1 from SHERPA_PRO.sysadm.code_car where id_typ_code=a.id_typ_code) Then SHERPA_PRO.sysadm.FN_CODE_CAR(val ,a.id_typ_code)
			Else rtrim(a.lib_val) End
		from SHERPA_PRO.sysadm.archive_reponse a
		where  a.id_archive=@idArchive
			and a.quest_gest like '[[]' + @cle + ']%'
	End

	Return @@ROWCOUNT
Go
	
grant execute on sysadm.PS_S_ARCHIVE_REPONSE to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_U_ARCHIVE_PIECE
-- Auteur               :       JFF
-- Date                 :       06/01/2020
-- Libell‚              :       Mets à jour l'état des pièces sur SHERPA.archive par rapport ua pièce SIMPA2
--								/!\ !!! A compiler sur SHERPA !! /!\
--
-- Références           :       [PC192290]
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF  28/09/2021 [20210928162035633] Ajout d'un caractère de fin de chaine(@) pour ne pas perdre les espace de fin de chaine
-- JFF  04/09/2023 [RS5656_MOD_PCE_DIF]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_ARCHIVE_PIECE' AND type = 'P' )
        DROP procedure sysadm.PS_U_ARCHIVE_PIECE
GO
  
  
CREATE PROCEDURE sysadm.PS_U_ARCHIVE_PIECE  
 @aiIdSin int,  
 @asChaineTrt1 VarChar ( 255 ),  
 @asChaineTrt2 VarChar ( 255 ),  
 @asChaineTrt3 VarChar ( 255 )  
As  
--        /!\ !!! A compiler sur SHERPA !! /!\  
Declare @sChaineTrt VarChar ( 800 )  
Declare @sChaineTrtWrk VarChar ( 100 )  
Declare @iIdPce Int  
Declare @sEtatPce VarChar (10 )  
Declare @dtDteAnalysePce DateTime   
Declare @iPos Int  
Declare @iIdCli Int  
Declare @dcIdGti Decimal ( 7 )  
Declare @dcIdDetail Decimal ( 7 )  
Declare @sIdGti VarChar ( 15 )   
Declare @sIdDetail VarChar ( 15 )   
Declare @dcIdSin Decimal ( 10 )  
Declare @sModeFctDp345 Varchar ( 50 )  
  
Set @dcIdSin = convert ( Decimal ( 10 ) , @aiIdSin )   
  
Set @sChaineTrt = IsNull ( rTrim ( @asChaineTrt1), '') + IsNull ( rTrim ( @asChaineTrt2), '') + IsNull ( rTrim ( @asChaineTrt3), '')  
Set @sChaineTrt = Replace ( @sChaineTrt, '@', '' ) -- [20210928162035633]  
Select @iIdCli = id_cli From sysadm.sinistre where id_sin = @aiIdSin and id_appli = 2  
  
While @sChaineTrt <> ''  
  Begin  
  Set @iPos = CharIndex ( '#', @sChaineTrt )   
  If @iPos <= 0 Break  
  
  Set @sChaineTrtWrk = Left ( @sChaineTrt, @iPos -1 )  
  
 -- [RS5656_MOD_PCE_DIF]  
 If sysadm.FN_CLE_NUMERIQUE ( 'RS5656_MOD_PCE_DIF') > 0   
  Begin  
   Set @sIdGti = sysadm.FN_CLE_VAL ( 'IGA', @sChaineTrtWrk, ';' )   
   If IsNumeric ( @sIdGti ) = 0 Set @sIdGti = '-1'  
  
   Set @sIdDetail = sysadm.FN_CLE_VAL ( 'IDT', @sChaineTrtWrk, ';' )   
   If IsNumeric ( @sIdDetail ) = 0 Set @sIdDetail = '-1'  
  
   Set @dcIdGti = Convert ( Decimal (7), @sIdGti )  
   If @dcIdGti is null Or @dcIdGti = 0 Set @dcIdGti = -1  
     
   Set @dcIdDetail = Convert ( Decimal (7), @sIdDetail )  
   If @dcIdDetail is null Or @dcIdDetail = 0 Set @dcIdDetail = -1  
  End   
  
  Set @iIdPce = Convert ( integer, sysadm.FN_CLE_VAL ( 'IP', @sChaineTrtWrk, ';' ) )  
  Set @sEtatPce = sysadm.FN_CLE_VAL ( 'EP', @sChaineTrtWrk, ';' )   
  Set @dtDteAnalysePce = Convert ( DateTime, sysadm.FN_CLE_VAL ( 'DA', @sChaineTrtWrk, ';' ) )  
  
  
 -- [RS5656_MOD_PCE_DIF]  
 If sysadm.FN_CLE_NUMERIQUE ( 'RS5656_MOD_PCE_DIF') > 0   
  Begin  
  
     IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'    
	  BEGIN    
     
	   Select Top 1 @sModeFctDp345 = sysadm.FN_CLE_VAL ( 'MODE_FCT', rtrim ( val_car ) + rtrim ( val_car2 ), ';' )   
	   From SIMPA2_PRO.sysadm.det_pro dp,  
		 SIMPA2_PRO.sysadm.w_sin ws  
	   Where ws.id_sin = @dcIdSin   
	   And  dp.id_prod = ws.id_prod  
	   And  dp.id_code_dp = 345  
     
	   If  @sModeFctDp345 is null Or @sModeFctDp345 =''  
		 Begin   
			Select Top 1 @sModeFctDp345 = sysadm.FN_CLE_VAL ( 'MODE_FCT', rtrim ( val_car ) + rtrim ( val_car2 ), ';' )   
			From SIMPA2_PRO.sysadm.det_pro dp,  
			  SIMPA2_PRO.sysadm.sinistre ws  
			Where ws.id_sin = @dcIdSin   
			And  dp.id_prod = ws.id_prod  
			And  dp.id_code_dp = 345  
		 End  
	  End  
	  Else  
	  Begin  
		   Select Top 1 @sModeFctDp345 = sysadm.FN_CLE_VAL ( 'MODE_FCT', rtrim ( val_car ) + rtrim ( val_car2 ), ';' )   
		   From SIMPA2_TRT.sysadm.det_pro dp,  
			 SIMPA2_TRT.sysadm.w_sin ws  
		   Where ws.id_sin = @dcIdSin   
		   And  dp.id_prod = ws.id_prod  
		   And  dp.id_code_dp = 345  
  
		   If  @sModeFctDp345 is null Or @sModeFctDp345 =''  
			 Begin   
				Select Top 1 @sModeFctDp345 = sysadm.FN_CLE_VAL ( 'MODE_FCT', rtrim ( val_car ) + rtrim ( val_car2 ), ';' )   
				From SIMPA2_TRT.sysadm.det_pro dp,  
				  SIMPA2_TRT.sysadm.sinistre ws  
				Where ws.id_sin = @dcIdSin   
				And  dp.id_prod = ws.id_prod  
				And  dp.id_code_dp = 345  
			End  
	  End   
  
	  If @sModeFctDp345 is null Set @sModeFctDp345 = ''  
	  If @sModeFctDp345 = '' Set @sModeFctDp345 = 'UNIQUE'  
  
	  -- Jouer absolument avec le mode pour l'update, attention  
	  If @sModeFctDp345 = 'UNIQUE'   
		Begin  
			Update sysadm.archive  
			Set  etat_pce = @sEtatPce,  
			  dte_analyse_pce = @dtDteAnalysePce  
			From sysadm.archive a,  
			  sysadm.contact c  
			Where a.id_cli = @iIdCli  
			And   a.id_pce = @iIdPce  
			And   a.etat_pce is null   
			And   c.id_cli = a.id_cli  
			And   c.id_contact = a.id_contact  
			And   c.id_sin = @aiIdSin  
	     End  
  
	  If @sModeFctDp345 = 'DET_GARANTIE'   
		Begin  
			Update sysadm.archive  
			Set  etat_pce = @sEtatPce,  
			  dte_analyse_pce = @dtDteAnalysePce  
			From sysadm.archive a,  
			  sysadm.contact c  
			Where a.id_cli = @iIdCli  
			And   a.id_gti = @dcIdGti  
			And   a.id_detail = @dcIdDetail  
			And   a.id_pce = @iIdPce  
			And   a.etat_pce is null   
			And   c.id_cli = a.id_cli  
			And   c.id_contact = a.id_contact  
			And   c.id_sin = @aiIdSin  
	    End  
	  End  
 Else  
  Begin  
   Update sysadm.archive  
   Set  etat_pce = @sEtatPce,  
     dte_analyse_pce = @dtDteAnalysePce  
   From sysadm.archive a,  
     sysadm.contact c  
   Where a.id_cli = @iIdCli  
   And   a.id_pce = @iIdPce  
   And   a.etat_pce is null   
   And   c.id_cli = a.id_cli  
   And   c.id_contact = a.id_contact  
   And   c.id_sin = @aiIdSin  
  End  
  
  Set @sChaineTrt = SubString ( @sChaineTrt, @iPos + 1, len ( @sChaineTrt ) )   
  
  End   
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RECUP_ID_CLIENT
-- Auteur               :       JFF
-- Date                 :       10/04/2020
-- Libell‚              :       Récuparation de l'ID_CLIENT sur SHERPA.
--								
--
-- Références           :       [PM506-1]
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RECUP_ID_CLIENT' AND type = 'P' )
        DROP procedure sysadm.PS_S_RECUP_ID_CLIENT
GO

CREATE PROCEDURE sysadm.PS_S_RECUP_ID_CLIENT
	@aiIdSin  Integer,  -- en integer car on est sur SHERPA
	@aiIdCli  Integer OUTPUT
AS

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
  Begin
	Select Top 1 @aiIdCli = shs.id_cli
	From SHERPA_PRO.sysadm.sinistre shs
	Where shs.id_sin = @aiIdSin
	And   shs.id_appli = 2
  End 
Else
  Begin
	Select Top 1 @aiIdCli = shs.id_cli
	From SHERPA_SIM.sysadm.sinistre shs
	Where shs.id_sin = @aiIdSin
	And   shs.id_appli = 2
  End 
  	
Go 

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_CONTACT_CLIENT
-- Auteur               :       JFF
-- Date                 :       14/04/2020
-- Libell‚              :       Ecrire un contact CLIENT à partir de SIMPA2 (cas exceptionnel)
--								
--
-- Références           :       [PM506-1]
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_CONTACT_CLIENT' AND type = 'P' )
        DROP procedure sysadm.PS_I_CONTACT_CLIENT
GO

CREATE PROCEDURE sysadm.PS_I_CONTACT_CLIENT
	@adcIdSin  integer, -- Car écriture sur SHERPA
	@asMess	   VarChar ( 2000 ),
	@aiEtatCt   Integer, -- 300 Information, sinon autre
	@asCodOper Varchar ( 4 )

AS

Declare @iIdCt	integer	

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @adcIdSin, 2, @asMess,	@asCodOper, @aiEtatCt, @iIdCt OUTPUT							
END
ELSE
BEGIN
	Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @adcIdSin, 2, @asMess,	@asCodOper, @aiEtatCt, @iIdCt OUTPUT							
END	

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PRESENCE_PRE_SCRIPT
-- Auteur               :       JFF
-- Date                 :       07/06/2021
-- Libell‚              :       Test la présence d'un pré-script
--								
--
-- Références           :       [RS-496]
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PRESENCE_PRE_SCRIPT' AND type = 'P' )
        DROP procedure sysadm.PS_S_PRESENCE_PRE_SCRIPT
GO

CREATE PROCEDURE sysadm.PS_S_PRESENCE_PRE_SCRIPT
	@aiIdProd    integer, 
	@asIdCanal  VarChar (5),
	@aiIdScriptDeb Integer OutPut
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	select @aiIdScriptDeb = ct.id_script_deb 
	From SHERPA_PRO.sysadm.contact_type ct with (nolock)
	where id_prod = @aiIdProd     -- Le code produit sinistre
	And id_typ_contact = 1  -- Type de contact = 1:déclaration
	And id_typ_fam     = 2  -- Famille 2:sinistre
	And id_canal       = @asIdCanal -- Le canal : Souvent T pour téléphone, C;Courrier lorsque utilisé par DNEA
	And ( 
			Exists ( 
				Select Top 1 1 
				From SHERPA_PRO.sysadm.condition_regle cr with (nolock)
				Where ( cr.param1 = 'Q17' Or cr.param2 = 'Q17' )
				And cr.id_script = ct.id_script_deb
			)
		Or 
			Exists ( 
				Select Top 1 1 
				From SHERPA_PRO.sysadm.scenario s with (nolock)
				Where ( upper ( s.quest_client ) like '%SURVENANCE%' Or  upper ( s.quest_gest ) like '%SURVENANCE%' )
				And s.id_script = ct.id_script_deb
			)
		)		
END
ELSE
BEGIN
	select @aiIdScriptDeb = ct.id_script_deb 
	From SHERPA_SIM.sysadm.contact_type ct with (nolock)
	where id_prod = @aiIdProd     -- Le code produit sinistre
	And id_typ_contact = 1  -- Type de contact = 1:déclaration
	And id_typ_fam     = 2  -- Famille 2:sinistre
	And id_canal       = @asIdCanal -- Le canal : Souvent T pour téléphone, C;Courrier lorsque utilisé par DNEA
	And ( 
			Exists ( 
				Select Top 1 1 
				From SHERPA_SIM.sysadm.condition_regle cr with (nolock)
				Where ( cr.param1 = 'Q17' Or cr.param2 = 'Q17' )
				And cr.id_script = ct.id_script_deb
			)
		Or 
			Exists ( 
				Select Top 1 1 
				From SHERPA_SIM.sysadm.scenario s with (nolock)
				Where ( upper ( s.quest_client ) like '%SURVENANCE%' Or  upper ( s.quest_gest ) like '%SURVENANCE%' )
				And s.id_script = ct.id_script_deb
			)
		)			
END	

If @aiIdScriptDeb is null Set @aiIdScriptDeb = 0 
If @aiIdScriptDeb <= 0 Set @aiIdScriptDeb = 0 

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RS4166_CTRLE_ADH_FFM
-- Auteur               :       JFF
-- Date                 :       11/01/2023
-- Libell‚              :       
--								
--
-- Références           :       [RS4166]
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RS4166_CTRLE_ADH_FFM' AND type = 'P' )
        DROP procedure sysadm.PS_S_RS4166_CTRLE_ADH_FFM
GO

CREATE PROCEDURE sysadm.PS_S_RS4166_CTRLE_ADH_FFM
	@aiIdProdAdh	Int,
	@aiIdEts		Int,
	@aiIdAdh		Int,
	@aiIdsDos		Int,
	@asDteRetPnd	VarChar ( 10 ),
	@aiIdCLi		Int OutPut,
	@asCreeLePnd	VarChar ( 10 ) OutPut
As

Declare @iRowCount Int
Declare @sCreelePnd Varchar ( 10 ) 
Declare @dtDteRetPnd DateTime

Set @dtDteRetPnd = Convert ( DateTime, @asDteRetPnd )

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN

	If Not Exists (
		Select Top 1 1 
		From SHERPA_PRO.sysadm.det_pro dp
		Where dp.id_prod = @aiIdProdAdh
		and dp.id_typ_code = 'DP'
		And dp.id_code = 266 
	) 
	 Begin	
		Return 4
	 End 

	Select @aiIdCLi = id_cli 
	from SHERPA_PRO.sysadm.adhesion with (nolock) 
	where id_prod_adh = @aiIdProdAdh 
	And id_ets = @aiIdEts
	And id_adh = @aiIdAdh
	and id_sdos = @aiIdsDos 
	/* Trop restrictif
	and id_status in ( 0, 2, 3, 8 ) 
	and id_exist <> 0 
	*/

	Set @iRowCount = @@RowCount 
	If @iRowCount <= 0 Return -1	
	If @iRowCount > 1 Return 2

	Select @asCreeLePnd = Convert ( VarChar ( 10 ), p.cree_le, 103 ) 
	From	sysadm.pnd_ksl_adh p with (nolock)
	Where p.id_prod_adh = @aiIdProdAdh 
	And p.id_ets = @aiIdEts
	And p.id_adh = @aiIdAdh
	and p.id_sdos = @aiIdsDos 
	and p.dte_ret_pnd = @dtDteRetPnd 	

	If @@Rowcount > 0 
		Begin
			Return 3
		End 

	Return 1
	 
END
ELSE
BEGIN
	If Not Exists (
		Select Top 1 1 
		From SHERPA_SIM.sysadm.det_pro dp
		Where dp.id_prod = @aiIdProdAdh
		and dp.id_typ_code = 'DP'
		And dp.id_code = 266 
	) 
	 Begin	
		Return 4
	 End 

	Select @aiIdCLi = id_cli 
	from SHERPA_SIM.sysadm.adhesion with (nolock) 
	where id_prod_adh = @aiIdProdAdh 
	And id_ets = @aiIdEts
	And id_adh = @aiIdAdh
	and id_sdos = @aiIdsDos 
	/* Trop restrictif
	and id_status in ( 0, 2, 3, 8 ) 
	and id_exist <> 0 
	*/


	Set @iRowCount = @@RowCount 
	If @iRowCount <= 0 Return -1	
	If @iRowCount > 1 Return 2

	Select	@asCreeLePnd = Convert ( VarChar ( 10 ), p.cree_le, 103 ) 
	From	sysadm.pnd_ksl_adh p with (nolock)
	Where p.id_prod_adh = @aiIdProdAdh 
	And p.id_ets = @aiIdEts
	And p.id_adh = @aiIdAdh
	and p.id_sdos = @aiIdsDos 
	and p.dte_ret_pnd = @dtDteRetPnd 	

	If @@Rowcount > 0 
		Begin
			Return 3
		End 

	Return 1
End 

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_RS4166_CTC_TRV_PND_CORUS_FFM_KSL
-- Auteur               :       JFF
-- Date                 :       11/01/2023
-- Libell‚              :       
--								
--
-- Références           :       [RS4166]
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_RS4166_CTC_TRV_PND_CORUS_FFM_KSL' AND type = 'P' )
        DROP procedure sysadm.PS_I_RS4166_CTC_TRV_PND_CORUS_FFM_KSL
GO

CREATE procedure sysadm.PS_I_RS4166_CTC_TRV_PND_CORUS_FFM_KSL
	@aiIdCLi		Int,
	@alIdProdAdh	Int,
	@aiIdEts		Int,
	@alIdAdh		Int,
	@aiIdsdos		Int,
	@asDteRetPnd VarChar  ( 10 ),
	@asMotif VarChar ( 100 ),
	@asCodOper Varchar ( 4 )
AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer
Declare @iIdContact	    integer
Declare @asIdAdh		VarChar ( 19 )
Declare @dGetDate	    DateTime 

Set @dGetDate = Getdate()

Set @asIdAdh = Convert ( varchar ( 19 ), @alIdAdh ) 

Insert into sysadm.pnd_ksl_adh values ( @aiIdCLi, @alIdProdAdh, @aiIdEts, @alIdAdh, @aiIdsdos, @asDteRetPnd, @asMotif, @dGetDate, @dGetDate, @asCodOper ) 

Set @sMess = 'Retour PND CORUS KSL ADHESION du ' + @asDteRetPnd + CHAR ( 10 ) 
Set @sMess = @sMess + 'Motif : ' + @asMotif + CHAR ( 10 )  
Set @sMess = @sMess + 'Client Sherpa : ' + CONVERT ( Varchar ( 20), @aiIdCLi ) + CHAR ( 10 ) 
Set @sMess = @sMess + 'ProdAdh-Ets-Adh-sDos :  ' + CONVERT ( Varchar ( 10), @alIdProdAdh ) + '-' + CONVERT ( Varchar ( 5), @aiIdEts ) + '-' + CONVERT ( Varchar ( 20), @alIdAdh ) + '-' + CONVERT ( Varchar ( 5), @aiIdsdos )+ CHAR ( 10 ) 
Set @sMess = @sMess + 'Action : Merci de renvoyer ce courrier à l''assuré, voyez avec votre cellule support pour la manipulation.' + CHAR ( 10 )  

Set @asCodOper = 'PND' -- J'écrase le trg de l'opérateur par ce trigramme technique.

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) = 'PRO'
BEGIN

	EXEC SHERPA_PRO.sysadm.Demat_Contact_Creer_wfa_V100
		@aiIdCLi,					-- N° de client
		@iIdContact OUTPUT,			-- N° du contact créé
		'B',						-- Identifiant du canal (B=Batch)
		@alIdProdAdh,				-- N° de produit adhésion ou sinistre
		@aiIdEts,					-- N° d'établissement
		@asIdAdh,					-- N° d'adhésion
		@aiIdsdos,					-- N° de sous dossier
		'A',						-- Code interlocuteur  (Je mets Assuré par défaut ,je n'ai pas d'autres infos)
		@sMess,						-- Message du contact
		1,							-- Type de tache 1=Vdc, 2=Ad nouvelle
		@dGetDate,					-- Date de réception le contact        
		'PND',						-- Trigramme du gestionnaire destinataire du contact
		'PND',						-- Créer par 
		1,							-- Type de famille (adhésion : 1, autre : 3)
		0,							-- Pôle de gestion
		@sErr OUTPUT				-- Message d'erreur	
END
ELSE
BEGIN
	EXEC SHERPA_SIM.sysadm.Demat_Contact_Creer_wfa_V100
		@aiIdCLi,					-- N° de client
		@iIdContact OUTPUT,			-- N° du contact créé
		'B'	,						-- Identifiant du canal (B=Batch)
		@alIdProdAdh,				-- N° de produit adhésion ou sinistre
		@aiIdEts,					-- N° d'établissement
		@asIdAdh,					-- N° d'adhésion
		@aiIdsdos,					-- N° de sous dossier
		'A',						-- Code interlocuteur  (Je mets Assuré par défaut ,je n'ai pas d'autres infos)
		@sMess,						-- Message du contact
		1,							-- Type de tache 1=Vdc, 2=Ad nouvelle
		@dGetDate,					-- Date de réception le contact        
		'PND',						-- Trigramme du gestionnaire destinataire du contact
		'PND',						-- Créer par 
		1,							-- Type de famille (adhésion : 1, autre : 3)
		0,							-- Pôle de gestion
		@sErr OUTPUT				-- Message d'erreur	
END

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RS4573_INTERRO_MAIL_M16_MATP
-- Auteur               :       JFF
-- Date                 :       14/02/2023
-- Libellé              :		
-- Commentaires         :       !!!! A COMPILER SUR SHERPA !!!!!
-- Références           :
--
-- Arguments            :       
--
-- Retourne             :        
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      26/04/2023   [RS5045_REF_MATP][RS4662]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RS4573_INTERRO_MAIL_M16_MATP' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_S_RS4573_INTERRO_MAIL_M16_MATP
GO

CREATE PROCEDURE  sysadm.PS_S_RS4573_INTERRO_MAIL_M16_MATP
	@adcIdSin	Decimal (10) -- [PI062]
As

-- !!!! PS A COMPILER SUR SHERPA !!!!!

Declare @iIdSin Int -- [PI062]

Set @iIdSin = Convert ( integer, @adcIdSin ) -- [PI062]

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) = 'PRO'
BEGIN  
	Select	mp.id_seq,
			-- mp.id_appli,
			-- mp.id_sin,
			-- mp.id_prod,
			-- mp.lib_prod,
			-- mp.id_arch,
			convert ( Varchar ( 10), ach.id_sin ) + '/' + convert ( Varchar ( 10), ach.id_inter ) + '/' + convert ( Varchar ( 10), ach.id_doc ) id_cle,
			ach.id_doc,
			rtrim ( ach.id_cour_orig) + '/' + rtrim ( ach.id_cour ) id_cour, 
			ach.nom,
			sysadm.FN_CODE_CAR ( ach.cod_inter, '-IN' ) lib_inter,
			-- mp.cree_le,
			mp.mail_dte_trt,
			-- mp.mail_from,
			mp.mail_send,
			mp.mail_subject
			-- mp.boite_mail,
			-- '(' + rtrim ( mp.typ_mail ) + ') ' + rtrim ( cc.lib_code ) lib_typ_mail

	from TRACE_MAIL_PRO.sysadm.mail_push mp,
		 TRACE_MAIL_PRO.sysadm.code_car cc,
		 SIMPA2_PRO.sysadm.archive ach
	where mp.id_sin = @iIdSin  -- [PI062]
	And   mp.typ_mail = 'M16'
	And   mp.methode = 'KSL2'  -- [RS5045_REF_MATP][RS4662] les anciens mails de type KSL ne pourraient de toutes façon plus partir 
	And   ach.id_arch = mp.id_arch
	And   cc.id_typ_code = '-TM'
	And   cc.id_code = mp.typ_mail

	Order by mp.id_seq

End 
Else
Begin
	Select	mp.id_seq,
			-- mp.id_appli,
			-- mp.id_sin,
			-- mp.id_prod,
			-- mp.lib_prod,
			-- mp.id_arch,
			convert ( Varchar ( 10), ach.id_sin ) + '/' + convert ( Varchar ( 10), ach.id_inter ) + '/' + convert ( Varchar ( 10), ach.id_doc ) id_cle,
			ach.id_doc,
			rtrim ( ach.id_cour_orig) + '/' + rtrim ( ach.id_cour ) id_cour, 
			ach.nom,
			sysadm.FN_CODE_CAR ( ach.cod_inter, '-IN' ) lib_inter,
			-- mp.cree_le,
			mp.mail_dte_trt,
			-- mp.mail_from,
			mp.mail_send,
			mp.mail_subject
			-- mp.boite_mail,
			-- '(' + rtrim ( mp.typ_mail ) + ') ' + rtrim ( cc.lib_code ) lib_typ_mail

	from TRACE_MAIL_TRT.sysadm.mail_push mp,
		 TRACE_MAIL_TRT.sysadm.code_car cc,
		 SIMPA2_TRT.sysadm.archive ach
	where mp.id_sin = @iIdSin  -- [PI062]
	And   mp.typ_mail = 'M16'
	And   mp.methode = 'KSL2'  -- [RS5045_REF_MATP][RS4662] les anciens mails de type KSL ne pourraient de toutes façon plus partir 
	And   ach.id_arch = mp.id_arch
	And   cc.id_typ_code = '-TM'
	And   cc.id_code = mp.typ_mail

	Order by mp.id_seq
End 
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_RS4573_DUPLIQUE_MAIL_M16_MATP
-- Auteur               :       JFF
-- Date                 :       14/02/2023
-- Libellé              :		
-- Commentaires         :       !!!! A COMPILER SUR SHERPA !!!!!
-- Références           :
--
-- Arguments            :       
--
-- Retourne             :        
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      26/04/2023   [RS5045_REF_MATP][RS4662]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_RS4573_DUPLIQUE_MAIL_M16_MATP' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_I_RS4573_DUPLIQUE_MAIL_M16_MATP
GO

CREATE PROCEDURE  sysadm.PS_I_RS4573_DUPLIQUE_MAIL_M16_MATP
	@aiIdSeq	Integer,  -- Identifiant du mail existant
	@asCodInter VarChar ( 1 ), -- A(ssuré) ou B(anque)
	@asMailSend VarChar ( 128 ),
	@asMailSubject VarChar ( 255 )
As

-- !!!! PS A COMPILER SUR SHERPA !!!!!

-- [RS5045_REF_MATP][RS4662]
Exec sysadm.PS_I_RS4573_DUPLIQUE_MAIL_M16_MATP_V02 @aiIdSeq, @asCodInter, @asMailSend, @asMailSubject
Return

/*
Declare @sMailSendXmlActuel VarChar ( 128 )
Declare @sMailSubjectXmlActuel VarChar ( 128 )
Declare @sTypeDest VarChar ( 20 )
Declare @sXmlDataActuel VarChar ( 2000 )
Declare @iPos1 Integer
Declare @iPos2 Integer

Set @sTypeDest = 'ASSURE' -- Défaut
If Upper ( @asCodInter ) = 'A' Set @sTypeDest = 'ASSURE'
If Upper ( @asCodInter ) = 'B' Set @sTypeDest = 'BANQUE'


IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) = 'PRO'
BEGIN  

	Select	@sMailSendXmlActuel = mail_send,
			@sMailSubjectXmlActuel = mail_subject,
			@sXmlDataActuel = xml_data
	From TRACE_MAIL_PRO.sysadm.mail_push
	Where id_seq = @aiIdSeq

	Set @iPos1 = CharIndex ( 'type_destinataire="', @sXmlDataActuel ) 
	If @iPos1 > 0 
	  Begin
		Set @iPos2 = @iPos1 + len ( 'type_destinataire="' ) 
		Set @iPos2 = CharIndex ( '"', @sXmlDataActuel, @iPos2 ) + 1
		Set @sXmlDataActuel = Stuff ( @sXmlDataActuel, @iPos1, (@iPos2 - @iPos1) +1, '' )
	  End

	Set @sXmlDataActuel = 	
		Replace (
			Replace (
				Replace ( @sXmlDataActuel, @sMailSendXmlActuel, @asMailSend ),
				@sMailSubjectXmlActuel,
				@asMailSubject
				),
			'code_produit_SIMPA2=',
			'type_destinataire="' + @sTypeDest + '" code_produit_SIMPA2='
			)

	Insert into TRACE_MAIL_PRO.sysadm.mail_push
	Select 
		id_appli,
		id_sin,
		id_prod,
		lib_prod,
		id_ets,
		GetDate(),
		mail_from,
		@asMailSend,
		mail_cc,
		@asMailSubject,
		mail_body,
		alt_quarantaine,
		null,
		'N',
		alt_mail_recu,
		mail_id_erreur,
		mail_contact,
		boite_mail,
		typ_mail,
		id_appli_num,
		methode,
		id_arch,
		@sXmlDataActuel

	From TRACE_MAIL_PRO.sysadm.mail_push
	Where id_seq = @aiIdSeq

END 
Else
BEGIN
	Select	@sMailSendXmlActuel = mail_send,
			@sMailSubjectXmlActuel = mail_subject,
			@sXmlDataActuel = xml_data
	From TRACE_MAIL_TRT.sysadm.mail_push
	Where id_seq = @aiIdSeq

	Set @iPos1 = CharIndex ( 'type_destinataire="', @sXmlDataActuel ) 
	If @iPos1 > 0 
	  Begin
		Set @iPos2 = @iPos1 + len ( 'type_destinataire="' ) 
		Set @iPos2 = CharIndex ( '"', @sXmlDataActuel, @iPos2 ) + 1
		Set @sXmlDataActuel = Stuff ( @sXmlDataActuel, @iPos1, (@iPos2 - @iPos1) +1, '' )
	  End

	Set @sXmlDataActuel = 	
		Replace (
			Replace (
				Replace ( @sXmlDataActuel, @sMailSendXmlActuel, @asMailSend ),
				@sMailSubjectXmlActuel,
				@asMailSubject
				),
			'code_produit_SIMPA2=',
			'type_destinataire="' + @sTypeDest + '" code_produit_SIMPA2='
			)

	Insert into TRACE_MAIL_TRT.sysadm.mail_push
	Select 
		id_appli,
		id_sin,
		id_prod,
		lib_prod,
		id_ets,
		GetDate(),
		mail_from,
		@asMailSend,
		mail_cc,
		@asMailSubject,
		mail_body,
		alt_quarantaine,
		null,
		'N',
		alt_mail_recu,
		mail_id_erreur,
		mail_contact,
		boite_mail,
		typ_mail,
		id_appli_num,
		methode,
		id_arch,
		@sXmlDataActuel

	From TRACE_MAIL_TRT.sysadm.mail_push
	Where id_seq = @aiIdSeq
*/

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_RS4573_DUPLIQUE_MAIL_M16_MATP_V02
-- Auteur               :       JFF
-- Date                 :       03/10//2023
-- Libellé              :		[RS5045_REF_MATP][RS4662][RS4573]
-- Commentaires         :       !!!! A COMPILER SUR SHERPA !!!!!
-- Références           :
--
-- Arguments            :       
--
-- Retourne             :
-------------------------------------------------------------------
--   JFF  28/10/2024  [MCO0153]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_RS4573_DUPLIQUE_MAIL_M16_MATP_V02' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_I_RS4573_DUPLIQUE_MAIL_M16_MATP_V02
GO

CREATE PROCEDURE  sysadm.PS_I_RS4573_DUPLIQUE_MAIL_M16_MATP_V02
	@aiIdSeq	Integer,  -- Identifiant du mail existant
	@asCodInter VarChar ( 1 ), -- A(ssuré) ou B(anque)
	@asMailSend VarChar ( 128 ),
	@asMailSubject VarChar ( 255 )
As
-- !!!! PS A COMPILER SUR SHERPA !!!!!

Declare @sIdAppli	VarChar ( 10 )
Declare @iIdSin  	Integer
Declare @iIdProd 	Integer
Declare @iIdEts  	Integer
Declare @sLibProd	VarChar ( 70 )
Declare @sMailFrom  	VarChar ( 128 )
Declare @sMailSend  	VarChar ( 128 )
Declare @sMailCc    	VarChar ( 128 )
Declare @sMailObjet 	VarChar ( 255 )
Declare @sTypMail 	VarChar ( 10 )
Declare @sXMLVar2    VarChar ( max ) -- [RS5045_REF_MATP]
Declare @sMailBody VarChar ( 5000 ) -- [RS5045_REF_MATP]
Declare @sSaut	VarChar (10) -- [RS5045_REF_MATP]
Declare @iIdArch integer
Declare @sBoiteMail  	VarChar ( 128 )
Declare @iIdXml integer  -- [RS5045_REF_MATP]
Declare @dcIdSin	Decimal ( 10 ) -- [PI062]
Declare @dcIdI		Decimal ( 7 ) -- [PM421-2]
Declare @sCodeMaquette VarChar ( 255 ) -- [RS5045_REF_MATP]
Declare @sErrOutPut VarChar ( 255 ) -- [RS5045_REF_MATP]
Declare @sVal	VarChar (255) -- [RS5045_REF_MATP]
Declare @iRet Integer
Declare @sRet varchar(60)
Declare @sPasDeReponse VarChar ( 100 ) -- [MCO10153]

Set @sSaut = Char (10)
Set @sMailBody = ''

-- défaut (assuré)
Set @sMailBody = @sMailBody + '<CIV> <NOM>,' + @sSaut
Set @sMailBody = @sMailBody + @sSaut
Set @sMailBody = @sMailBody + 'Nous vous adressons ci-joint une correspondance suite à votre demande d''indemnisation.' + @sSaut
Set @sMailBody = @sMailBody + @sSaut 

-- [MCO1053]
Set @sPasDeReponse = ' (n''utilisez surtout pas l''adresse émettrice de ce mail qui ne permet pas de recevoir des réponses)' -- [MCO1053]

If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
 Begin
	If SIMPA2_PRO.sysadm.FN_CLE_NUMERIQUE ( 'MCO0153') > 0 
		Begin
			Set @sMailBody = @sMailBody + 'Pour nous contacter, vous trouverez l''ensemble de nos coordonnées sur cette dernière<PAS_DE_REPONSE>.' + @sSaut
		End 
	Else
		Begin
			Set @sMailBody = @sMailBody + 'Pour nous contacter, vous trouverez l''ensemble de nos coordonnées sur cette dernière (n''utilisez surtout pas l''adresse émettrice de ce mail qui ne permet pas de recevoir des réponses).' + @sSaut
		End 
  End
Else
 Begin
	If SIMPA2_TRT.sysadm.FN_CLE_NUMERIQUE ( 'MCO0153') > 0 
		Begin
			Set @sMailBody = @sMailBody + 'Pour nous contacter, vous trouverez l''ensemble de nos coordonnées sur cette dernière<PAS_DE_REPONSE>.' + @sSaut
		End 
	Else
		Begin
			Set @sMailBody = @sMailBody + 'Pour nous contacter, vous trouverez l''ensemble de nos coordonnées sur cette dernière (n''utilisez surtout pas l''adresse émettrice de ce mail qui ne permet pas de recevoir des réponses).' + @sSaut
		End 
  End

Set @sMailBody = @sMailBody + @sSaut 
Set @sMailBody = @sMailBody + 'Sincères salutations.' + @sSaut 
Set @sMailBody = @sMailBody + @sSaut 
Set @sMailBody = @sMailBody + 'Votre gestionnaire d''assurance'

-- Correction si Banque
If @asCodInter = 'B' 
  Begin 
	Set @sMailBody = ''
	Set @sMailBody = @sMailBody + 'Madame, Monsieur,' + @sSaut
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody + 'Nous faisons suite à votre demande de ce jour.' + @sSaut
	Set @sMailBody = @sMailBody + @sSaut 
	Set @sMailBody = @sMailBody + 'Vous trouverez ci-joint le courrier adressé à notre client commun.' + @sSaut
	Set @sMailBody = @sMailBody + @sSaut 
	Set @sMailBody = @sMailBody + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, Madame, Monsieur, nos salutations distinguées.' + @sSaut
	Set @sMailBody = @sMailBody + @sSaut 
	Set @sMailBody = @sMailBody + 'Sincères salutations.' + @sSaut 
	Set @sMailBody = @sMailBody + @sSaut 
	Set @sMailBody = @sMailBody + 'Services Assurances SPB'
  End 


If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
 Begin

	Select @sIdAppli	= mp.id_appli,
		   @iIdSin		= mp.id_sin,
		   @iIdProd		= mp.id_prod,
		   @sLibProd	= mp.lib_prod,
		   @iIdEts		= mp.id_ets,
		   @sMailFrom	= mp.mail_from,
		   @sMailSend	= @asMailSend,
		   @sMailCc		= '',
		   @sMailObjet  = @asMailSubject,
		   @sBoiteMail  = mp.boite_mail,
		   @sTypMail	= mp.typ_mail,
		   @iIdArch		= mp.id_arch
	From TRACE_MAIL_PRO.sysadm.mail_push mp
	Where mp.id_seq = @aiIdSeq

	Select 	@dcIdSin	= a.id_sin,
			@dcIdI		= a.id_inter
	From	SIMPA2_PRO.sysadm.archive a
	Where 	a.id_arch = @iIdArch

	-- Appel Obligatoire pour déclarer le XML
	Exec @iIdXml = TRACE_MAIL_PRO.sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
	Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_SIMPA2 @dcIdSin, @dcIdI, @iIdXml
	Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL @iIdXml, 'OUI', 'OUI', 'OUI'
	Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL @sTypMail, @sCodeMaquette OutPut

	-- Ajout personnalisé du client appelant le système
	Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'code_maquette', @sCodeMaquette

	Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_S_RECUPERER_UNE_DONNEE_D_UNE_VARIABLE_PRE_ARMEE @iIdXml, 'civilite_courte', @sVal OutPut
	Set @sMailBody = Replace ( @sMailBody, '<CIV>', @sVal )
	Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_S_RECUPERER_UNE_DONNEE_D_UNE_VARIABLE_PRE_ARMEE @iIdXml, 'nom', @sVal OutPut
	Set @sMailBody = Replace ( @sMailBody, '<NOM>', @sVal )

	-- [MCO1053]
	If sysadm.FN_CLE_NUMERIQUE ( 'MCO0153') > 0 
		Begin
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_S_RECUPERER_UNE_DONNEE_D_UNE_VARIABLE_PRE_ARMEE @iIdXml, 'email_produit', @sVal OutPut
			If Not ( Lower ( @sVal ) <> 'noreply@spb.eu' And Len ( @sVal ) > 0 )
				Begin
				Set @sMailBody = Replace ( @sMailBody, '<PAS_DE_REPONSE>', @sPasDeReponse )
				End 
			Else
				Begin
				Set @sMailBody = Replace ( @sMailBody, '<PAS_DE_REPONSE>', '' )
				End 
		End 

	Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_TRANSFORMATION_DES_CRLF_FORMAT_XML_UTF8 @sMailBody OutPut, @sSaut
	Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'mail_subject', @sMailObjet
	Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'mail_body', @sMailBody
	Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adr_mail', @sMailSend
	Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adr_mail_cc', @sMailCc

	-- Appel pour construire et récupérer le XML dans @xmlResult
	Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE @iIdXml, @sCodeMaquette, @sXMLVar2 OUTPUT

	Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_RS5045_I_MAIL_PUSH_KSL
		@sIdAppli,
		@iIdSin,
		@iIdProd,
		@sLibProd,
		@iIdEts,
		@sMailFrom,
		@sMailSend,
		@sMailCc,
		null,
		@sMailObjet,
		@sMailBody,
		@sBoiteMail,
		@sTypMail,
		2,
		@iIdArch,
		@sXMLVar2,
		null, -- id_chem, peut être forcé mais si null, sera pris par défaut sysadm.code_maquette_ksl_rs5045
		null, -- dteh_exec
		@sErrOutPut OutPut

		Set @sRet = Left ( @sErrOutPut, 60 )
 End 
Else
 Begin

	Select @sIdAppli	= mp.id_appli,
		   @iIdSin		= mp.id_sin,
		   @iIdProd		= mp.id_prod,
		   @sLibProd	= mp.lib_prod,
		   @iIdEts		= mp.id_ets,
		   @sMailFrom	= mp.mail_from,
		   @sMailSend	= @asMailSend,
		   @sMailCc		= '',
		   @sMailObjet  = @asMailSubject,
		   @sBoiteMail  = mp.boite_mail,
		   @sTypMail	= mp.typ_mail,
		   @iIdArch		= mp.id_arch
	From TRACE_MAIL_TRT.sysadm.mail_push mp
	Where mp.id_seq = @aiIdSeq

	Select 	@dcIdSin	= a.id_sin,
			@dcIdI		= a.id_inter
	From	SIMPA2_TRT.sysadm.archive a
	Where 	a.id_arch = @iIdArch

	-- Appel Obligatoire pour déclarer le XML
	Exec @iIdXml = TRACE_MAIL_TRT.sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
	Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_SIMPA2 @dcIdSin, @dcIdI, @iIdXml
	Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL @iIdXml, 'OUI', 'OUI', 'OUI'
	Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL @sTypMail, @sCodeMaquette OutPut

	-- Ajout personnalisé du client appelant le système
	Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'code_maquette', @sCodeMaquette

	Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_S_RECUPERER_UNE_DONNEE_D_UNE_VARIABLE_PRE_ARMEE @iIdXml, 'civilite_courte', @sVal OutPut
	Set @sMailBody = Replace ( @sMailBody, '<CIV>', @sVal )
	Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_S_RECUPERER_UNE_DONNEE_D_UNE_VARIABLE_PRE_ARMEE @iIdXml, 'nom', @sVal OutPut
	Set @sMailBody = Replace ( @sMailBody, '<NOM>', @sVal )

	-- [MCO1053]
	If sysadm.FN_CLE_NUMERIQUE ( 'MCO0153') > 0 
		Begin
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_S_RECUPERER_UNE_DONNEE_D_UNE_VARIABLE_PRE_ARMEE @iIdXml, 'email_produit', @sVal OutPut
			If Not ( Lower ( @sVal ) <> 'noreply@spb.eu' And Len ( @sVal ) > 0 )
				Begin
				Set @sMailBody = Replace ( @sMailBody, '<PAS_DE_REPONSE>', @sPasDeReponse )
				End 
			Else
				Begin
				Set @sMailBody = Replace ( @sMailBody, '<PAS_DE_REPONSE>', '' )
				End 
		End 

	Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_TRANSFORMATION_DES_CRLF_FORMAT_XML_UTF8 @sMailBody OutPut, @sSaut
	Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'mail_subject', @sMailObjet
	Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'mail_body', @sMailBody
	Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adr_mail', @sMailSend
	Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adr_mail_cc', @sMailCc

	-- Appel pour construire et récupérer le XML dans @xmlResult
	Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE @iIdXml, @sCodeMaquette, @sXMLVar2 OUTPUT

	Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_RS5045_I_MAIL_PUSH_KSL
		@sIdAppli,
		@iIdSin,
		@iIdProd,
		@sLibProd,
		@iIdEts,
		@sMailFrom,
		@sMailSend,
		@sMailCc,
		null,
		@sMailObjet,
		@sMailBody,
		@sBoiteMail,
		@sTypMail,
		2,
		@iIdArch,
		@sXMLVar2,
		null, -- id_chem, peut être forcé mais si null, sera pris par défaut sysadm.code_maquette_ksl_rs5045
		null, -- dteh_exec
		@sErrOutPut OutPut

		Set @sRet = Left ( @sErrOutPut, 60 )

 End 

Go

