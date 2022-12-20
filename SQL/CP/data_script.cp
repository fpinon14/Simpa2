-------------------------------------------------------------------
--
-- Fichier           : data_script.cp
--
-- Commentaires      : Procédures de transfert des donn‚es du scripting vers les tables de gestion
--
-- Procédures   PS_X_UPD_DATA_SCRIPT FS le 10/04/2002 : SIMPA : Procédure principale d'appel
--                PS_X_UPD_W_SIN     FS le 08/04/2002 : SIMPA : Mise … jour des donn‚es du script dans la table W_SIN
--                PS_X_UPD_W_GAR_SIN FS le 08/04/2002 : SIMPA : Mise … jour des donn‚es du script dans la table W_GAR_SIN
--                PS_X_UPD_W_DETAIL  FS le 08/04/2002 : SIMPA : Mise … jour des donn‚es du script dans la table W_DETAIL
--                PS_X_UPD_W_DIV_SIN FS le 01/10/2007 : SIMPA : Mise à jour des donn‚es du script dans la table W_DIV_SIN
/*
PC972 Piece sur une révision
[sysadm].[PS_X_UPD_W_GAR_SIN]
[sysadm].[PS_X_UPD_W_DETAIL]
[sysadm].[PS_X_UPD_W_DETAIL_V01]
*/

-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure   : PS_X_UPD_W_SIN
-- Auteur      : FS
-- Date        : 08/04/2002
-- Libell‚     : SIMPA : Mise … jour des donn‚es du script dans la table W_SIN
--
-- Références  :       
--
-- Arguments   : @iIdArchive : Integer : Lot d'archive … traiter
--               @iIdSin     : Integer : Numero de sinistre … traiter
--	                        
-------------------------------------------------------------------------------
-- #1 FS le 02/12/2002 : V‚rification diff‚rences de types integer / Decimal(7)
-- #2 FS le 14/01/2004 : Désactivation de la trace dans w_log_data_script
-- #3 FS le 21/09/2006 : Modification de l'interprétation caractère/numérique "@iIdTypRep < 20 Or @iIdTypRep = 50"
-- #4 FS le 04/02/2008 : Désactivation de la trace dans w_log_data_script
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_X_UPD_W_SIN' AND type = 'P' )
DROP procedure sysadm.PS_X_UPD_W_SIN
GO



CREATE  procedure [sysadm].[PS_X_UPD_W_SIN]
 @iIdArchive Integer,
 @iIdSin     Integer,
 @sCodOper   Varchar(4),
 @sRetour    Varchar(254) Output

AS


Declare @sSep       Char(1) 
Declare @sIdCodZone Varchar(20)
Declare @sVal       Varchar(254)
Declare @sCmd       Varchar(700) --- corrctif itsm 131372

Declare @iIdTypRep  Integer
Declare @iRet       Integer
Declare @iFlag      Integer

Declare @dcIdSin    Decimal(10,0)

Select @dcIdSin = Convert ( Decimal(10,0), @iIdSin )

/*------------------------------------------------------------------*/
/* V‚rification du num‚ro de sinistre                               */
/*------------------------------------------------------------------*/

Select @iRet = Convert ( integer, id_sin ) FROM sysadm.w_sin WHERE id_sin = @dcIdSin

If @iRet <> @iIdSin
   Begin
      Select @sRetour = 'PS_X_UPD_W_SIN:Erreur Sinistre ' + Convert ( varchar(10), @iIdSin ) + ' inexistant'
      Return -1
   End

Select @iRet  = 0
Select @iFlag = 0  /* ... Flag =1 si au moins 1 maj r‚ussie sur w_sin ...*/

/*------------------------------------------------------------------*/
/* Ouverture du curseur sur W_SIN                                   */
/*------------------------------------------------------------------*/


  DECLARE cur_sin CURSOR FOR

  SELECT Lower( ds.id_code_zone ) , 
         Rtrim(ds.val) as val , -- FPI - 23/04/2019
         ds.id_typ_rep
    FROM
         sysadm.w_data_script ds,
         sysobjects so,
         syscolumns sc
   WHERE

         so.name = 'w_sin' And 
         so.type = 'U'     And
         so.id   = sc.id   And
      
         sc.name = lower ( ds.id_code_zone )  And

         ds.alt_gestion  = 'O'                And
         ds.id_archive   = @iIdArchive 
     
  OPEN cur_sin

  FETCH cur_sin INTO @sIdCodZone, @sVal, @iIdTypRep

WHILE @@fetch_status <> -1

  Begin

	/*------------------------------------------------------------------*/
	/* Construction de la commande                                      */
	/*------------------------------------------------------------------*/
    

	/* ... #3 <20 ald <16 */

      If @iIdTypRep < 20 Or @iIdTypRep = 50
         Begin
           Select @sSep = ''''
         End
      Else
         Begin
           Select @sSep = ''
         End
 
	Select @sCmd = 'UPDATE sysadm.w_sin SET ' + @sIdCodZone + '=' + @sSep + @sVal + @sSep +
                      ' WHERE id_sin=' + Convert ( varchar(10), @iIdSin ) + '.'

	/*------------------------------------------------------------------*/
	/* Execution de la commande                                         */
	/*------------------------------------------------------------------*/

    select '@sCmd=', LEN(@sCmd), @sCmd
	Execute ( @sCmd )

        Select @iRet = @@rowcount

        If @iRet <> 1
           Begin
             Select @iRet    = -1 /* ... Pb aucune ligne mise … jour  */
             Select @sRetour =  @sRetour + @sIdCodZone + '=' + @sSep + @sVal + @sSep + char(13)
           End
        Else
           Begin
             Select @iRet  = 0  /* ... Aucune erreur                                  */
             Select @iFlag = 1  /* ... Flag =1 si au moins 1 maj r‚ussie sur w_sin ...*/
           End
        

	  -- #4 INSERT INTO sysadm.w_log_data_script SELECT @iIdArchive, @iIdSin, @iRet, @sCmd, getdate(), @sCodOper 

	/*------------------------------------------------------------------*/
	/* Lecture de la donn‚e suivante                                    */
	/*------------------------------------------------------------------*/

        FETCH cur_sin INTO @sIdCodZone, @sVal, @iIdTypRep

  End

CLOSE cur_sin

DEALLOCATE cur_sin

/*------------------------------------------------------------------*/
/* Traitement si au moins une maj effectu‚e sans erreur             */
/*------------------------------------------------------------------*/

If @iFlag = 1
   Begin
      UPDATE sysadm.w_sin SET maj_le = getdate(), maj_par = @sCodOper WHERE id_sin = @dcIdSin
   End
GO

grant execute on sysadm.PS_X_UPD_W_SIN to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure   : PS_X_UPD_W_GAR_SIN
-- Auteur      : FS
-- Date        : 08/04/2002
-- Libell‚     : SIMPA : Mise … jour des donn‚es du script dans la table W_GAR_SIN
--
-- Références  :       
--
-- Arguments   : @iIdArchive : Integer    : Lot d'archive … traiter
--               @iIdSin     : Integer    : Numero de sinistre … traiter
--               @sCodOper   : Varchar(4) : Code operateur connect‚
--	                        
-------------------------------------------------------------------------------
-- #1 FS le 02/12/2002 : V‚rification diff‚rences de types integer / Decimal(7)
-- #2 FS le 14/01/2004 : Désactivation de la trace dans w_log_data_script
-- #3 FS le 21/09/2006 : Modification de l'interprétation caractère/numérique "@iIdTypRep < 20 Or @iIdTypRep = 50"
-- #4 FS le 04/02/2008 : Désactivation de la trace dans w_log_data_script
-- #5 FS le 04/11/2010 : [ITSM 49739] ; Pb en cas de pièce sur un interlocuteur inexistant
--    FPI 12/11/2014 : [PC874]
-- #6 FS  13/10/2014 : [PC972] Demande FLP modificat0in gestion report pièces et refus : Clé
-- #7 FS  01/10/2014 : [PC972] Absence de la clé ! je retire le code
-- #8 FS  05/11/2015 : [PC972] Demande FLP  : Je remets le code modification gestion report pièces et refus : Clé
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[PS_X_UPD_W_GAR_SIN]') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[PS_X_UPD_W_GAR_SIN]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE  procedure [sysadm].[PS_X_UPD_W_GAR_SIN]
 @iIdArchive Integer,
 @iIdSin     Integer,
 @sCodOper   Varchar(4),
 @sRetour    Varchar(254) Output

AS

Declare @sSep       Char(1) 
Declare @sCodInter  Char(1)
Declare @sIdCodZone Varchar(20)
Declare @sVal       Varchar(254)
Declare @sCmd       Varchar(254)

Declare @sIdGti     Varchar(6)
Declare @sIdPce     Varchar(6)
Declare @sIdMotif   Varchar(6)


Declare @dcIdPce     Decimal(7,0)
Declare @dcIdMotif   Decimal(7,0)
Declare @dcIdGti     Decimal(7,0)
Declare @dcIdI       Decimal(7,0)
Declare @dcIdSin     Decimal(10,0) -- [PI062]
Declare @iRet       Integer
Declare @iIdTypRep  Integer
Declare @iFlag      Integer


Select @dcIdSin = Convert ( Decimal(10,0), @iIdSin ) -- [PI062]


Select @iRet  = 0
Select @iFlag = 0  /* ... Flag =1 si au moins 1 maj r‚ussie sur w_gar_sin ...*/

/*------------------------------------------------------------------*/
/* Cr‚ation des nouvelles garanties                                 */
/*------------------------------------------------------------------*/

  DECLARE cur1 CURSOR FOR

  SELECT Rtrim(ds.val) as val -- FPI - 23/04/2019
    FROM
         sysadm.w_data_script ds
    WHERE
         ds.id_archive   = @iIdArchive And
         ds.id_code_zone = 'ID_GTI'    And
         ds.alt_gestion  = 'O'

   OPEN cur1

   FETCH cur1 INTO @sVal

   WHILE @@fetch_status <> -1
     
     Begin

        Select @dcIdGti = Convert( decimal(7), @sVal )

        /* ... Cr‚ation de la garantie ...*/

        Exec @iRet = sysadm.PS_I01_W_GAR_SIN @dcIdSin, @dcIdGti, @sCodOper

        Select @sCmd = 'INSERT garantie id_gti=' + convert( varchar(10),  @dcIdGti)

        -- #4 INSERT INTO sysadm.w_log_data_script SELECT @iIdArchive, @dcIdSin, @iRet, @sCmd, getdate(), @sCodOper 
 
	If @iRet = -1
        Begin
          Select @sRetour = 'PS_I01_W_GAR_SIN:Erreur creation Sin ' + Convert ( varchar(10), @dcIdSin ) + ' Gti ' + Convert ( varchar(10), @dcIdGti )
	  Break
        End

        /* ... Lecture suivant ...*/

        FETCH cur1 INTO @sVal

     End

  CLOSE cur1
  
  DEALLOCATE cur1

  If @iRet <> 0 Return -1

/*------------------------------------------------------------------*/
/* Mise … jour des donn‚es sur les garanties                        */
/*------------------------------------------------------------------*/

  DECLARE cur2 CURSOR FOR

  SELECT Lower( ds.id_code_zone ) , 
         rtrim(ds.val)            , -- FPI - 23/04/2019
         ds.id_typ_rep,
         ds.id_gti 
    FROM
         sysadm.w_data_script ds,
         sysobjects so,
         syscolumns sc
   WHERE

         so.name = 'w_gar_sin' And 
         so.type = 'U'         And
         so.id   = sc.id       And
      
         sc.name = lower ( ds.id_code_zone ) And

         ds.alt_gestion = 'O'  And
         ds.id_gti     <> '-1' And
         ( ds.id_evt    = '-1' And ds.id_motif = '-1' And ds.id_piece = '-1' ) And
         ds.id_archive  = @iIdArchive 
     
  OPEN cur2

  FETCH cur2 INTO @sIdCodZone, @sVal, @iIdTypRep, @sIdGti
 
  WHILE @@fetch_status <> -1

  Begin
	/*------------------------------------------------------------------*/
	/* Construction de la commande                                      */
	/*------------------------------------------------------------------*/
    

      /* ... #6 <20 ald <16 */

      If @iIdTypRep < 20 Or @iIdTypRep = 50
         Begin
           Select @sSep = ''''
         End
      Else
         Begin
           Select @sSep = ''
         End
 
	Select @sCmd = 'UPDATE sysadm.w_gar_sin SET ' + @sIdCodZone + '=' + @sSep + @sVal + @sSep + ' WHERE id_sin=' + Convert ( varchar(10), @dcIdSin ) + '.' + ' AND id_gti=' + @sIdGti 

	/*------------------------------------------------------------------*/
	/* Execution de la commande                                         */
	/*------------------------------------------------------------------*/

	Execute ( @sCmd )

        Select @iRet = @@rowcount

        If @iRet <> 1
           Begin
             Select @iRet = -1  /* ... Pb aucune ligne mise … jour ...*/
             Select @sRetour =  @sRetour + @sIdCodZone + '=' + @sSep + @sVal + @sSep + char(13)
           End
        Else
           Begin
             Select @iRet  = 0 /* ... Ok pour la mise … jour                             */
             Select @iFlag = 1 /* ... Flag =1 si au moins 1 maj r‚ussie sur w_gar_sin ...*/
           End

       -- #4 INSERT INTO sysadm.w_log_data_script SELECT @iIdArchive, @dcIdSin, @iRet, @sCmd, getdate(), @sCodOper 

	/*------------------------------------------------------------------*/
	/* Lecture de la donn‚e suivante                                    */
	/*------------------------------------------------------------------*/

       SELECT @iRet = 0
       FETCH cur2 INTO @sIdCodZone, @sVal, @iIdTypRep, @sIdGti

  End

CLOSE cur2

DEALLOCATE cur2

/*------------------------------------------------------------------*/
/* Cr‚ation des piŠces & motifs de refus sur les garanties          */
/*------------------------------------------------------------------*/

  DECLARE cur3 CURSOR FOR

  SELECT 
          ds.id_gti    ,
          ds.id_piece  ,
          ds.id_motif  ,
         ds.cod_inter
    FROM
         sysadm.w_data_script ds
   WHERE
         ds.id_gti     <> '-1'    And
         ds.id_evt     =  '-1'    And
         ( ds.id_motif <> '-1' Or ds.id_piece <> '-1' ) And
         ds.id_archive = @iIdArchive 
     
  OPEN cur3

  FETCH cur3 INTO @sIdGti, @sIdPce, @sIdMotif, @sCodInter

  WHILE @@fetch_status <> -1

  Begin


        /*-----------------------------------------------*/
        /*  Convertion des donn‚es en num‚rique          */
        /*-----------------------------------------------*/

         Select @dcIdGti   = Convert ( decimal(7,0), @sIdGti  )
         Select @dcIdPce   = Convert ( decimal(7,0), @sIdPce  )
         Select @dcIdMotif = Convert ( decimal(7,0), @sIdMotif)

        /*-----------------------------------------------*/
        /*  Cr‚ation des piŠces sur la garantie          */
        /*-----------------------------------------------*/

        If @dcIdPce <> -1 

                  /*-----------------------*/
           Begin  /*  D‚but tag piŠce      */
                  /*-----------------------*/

               SELECT @dcIdI = Max( i.id_i ) FROM sysadm.w_inter i WHERE i.id_sin = @dcIdSin And i.cod_inter = @sCodInter

					If @dcIdI is not null
					   Begin -- [ITSM 49739]
					   
					   -- [PC972] Début retrait du test de la révision
						INSERT into sysadm.w_piece
						SELECT TOP 1 --> [PC972] je prends la 1ère ligne
						@dcIdSin, @dcIdGti, -1, @dcIdPce, @dcIdI, p.id_para, p.cpt_tri , getdate(),getdate(), @sCodOper
						FROM   sysadm.w_sin s,
						sysadm.piece p
						WHERE
						s.id_prod = p.id_prod And
						s.id_sin  = @dcIdSin   And

						--p.id_rev  = -1       And --> [PC972] Retrait de la révision
						p.id_gti  = @dcIdGti   And
						p.id_pce  = @dcIdPce   And NOT EXISTS 
						( SELECT * FROM sysadm.w_piece v WHERE
						v.id_sin    = @dcIdSin    And 
						v.id_gti    = @dcIdGti    And
						v.id_detail = -1         And
						v.id_pce    = @dcIdPce )
					   -- [PC972] Fin   retrait du test de la révision
		
		                Select @iRet = @@ROWCOUNT
		
							If @iRet <> 1
		                   Begin
		                      Select @iRet = -1
		                      Select @sRetour = @sRetour + 'id_pce ' + convert ( varchar(10), @dcIdPce ) + ' sur id_gti ' + convert ( varchar(10), @dcIdGti )
		                   End
		                Else 
		                   Begin
		                      Select @iRet = 0
		                   End
		
		            	Select @sCmd = 'INSERT piece id_pce=' + convert ( varchar(5), @dcIdPce ) + ' sur id_gti=' + convert ( varchar(5), @dcIdGti ) 
            
							 -- #4 INSERT INTO sysadm.w_log_data_script SELECT @iIdArchive, @dcIdSin, @iRet, @sCmd, getdate(), @sCodOper 

						End

                  /*-----------------------*/
           End    /*  Fin tag piŠce        */
                  /*-----------------------*/


        /*-----------------------------------------------*/
        /* Cr‚ation des motifs sur la garantie           */
        /*-----------------------------------------------*/

 	If @dcIdMotif <> -1 

                  /*-----------------------*/
           Begin  /*  D‚but tag motif      */
                  /*-----------------------*/

               SELECT @dcIdI = Max( i.id_i ) FROM sysadm.w_inter i WHERE i.id_sin = @dcIdSin And i.cod_inter = @sCodInter

					If @dcIdI is not null 
					Begin  -- [ITSM 49739]
					
					-- [PC972] Début retrait du test de la révision
					INSERT into sysadm.w_refus
					SELECT TOP 1--> [PC972] je prends la 1ère ligne
					@dcIdSin, @dcIdGti, -1, @dcIdMotif, 'N', 'O', @dcIdI,  p.id_para, p.cpt_tri , getdate(),getdate(), @sCodOper
					FROM   sysadm.w_sin s,
					sysadm.motif p
					WHERE
					s.id_prod = p.id_prod And
					s.id_sin  = @dcIdSin   And

					--p.id_rev  = -1        And --> [PC972] Retrait de la révision
					p.id_gti  = @dcIdGti   And
					p.id_motif= @dcIdMotif And NOT EXISTS 
					( SELECT * FROM sysadm.w_refus v WHERE
					v.id_sin    = @dcIdSin    And 
					v.id_gti    = @dcIdGti    And
					v.id_detail = -1          And
					v.id_motif  = @dcIdMotif )
					-- [PC972] Fin   retrait du test de la révision
		
		                Select @iRet = @@ROWCOUNT
		
						If @iRet <> 1
		                   Begin
		                      Select @iRet = -1
		                      Select @sRetour = @sRetour + 'id_motif ' + convert ( varchar(10), @dcIdMotif ) + ' sur id_gti ' + convert ( varchar(10), @dcIdGti )
		                   End
		                Else 
		                   Begin
		                      Select @iRet = 0
		                   End
		
		            	Select @sCmd = 'INSERT refus id_motif=' + convert ( varchar(5), @dcIdMotif ) + ' sur id_gti=' + convert ( varchar(5), @dcIdGti ) 
		            -- #4    INSERT INTO sysadm.w_log_data_script SELECT @iIdArchive, @dcIdSin, @iRet, @sCmd, getdate(), @sCodOper 

					End    -- [ITSM 49739]

                  /*-----------------------*/
           End    /*  Fin tag motif        */
                  /*-----------------------*/
	/*------------------------------------------------------------------*/
	/* Lecture de la donn‚e suivante                                    */
	/*------------------------------------------------------------------*/

           FETCH cur3 INTO @sIdGti, @sIdPce, @sIdMotif, @sCodInter
  End

CLOSE cur3

DEALLOCATE cur3

Return 0

GO

grant execute on sysadm.PS_X_UPD_W_GAR_SIN to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure   : PS_X_UPD_W_DETAIL
-- Date        : 08/04/2002
-- Libell‚     : SIMPA : Mise … jour des donn‚es du script dans la table W_DETAIL
--
-- Références  :       
--
-- Arguments   : @iIdArchive : Integer    : Lot d'archive … traiter
--               @iIdSin     : Integer    : Numero de sinistre … traiter
--               @sCodOper   : Varchar(4) : Code operateur connect‚
--	                        
-------------------------------------------------------------------
-- #1 FS le 13/11/2002 : Traitement du pb si plusieurs piŠces coch‚es en mˆme temps
--                       que l'insertion d'un d‚tail : Ne pas ins‚rer le d‚tail n fois
-- #2 FS le 29/11/2002 : Correction PB les piŠces sur les d‚tail ‚taient tagg‚es 2 fois
-- #3 FS le 02/12/2002 : V‚rification diff‚rences de types integer / Decimal(7)
-- #4 FS le 14/01/2004 : Désactivation de la trace dans w_log_data_script
-- #5 FS le 10/03/2004 : Amélioration modif clause order by de manière à placer
--                       les ordres de création en haut
--                        Convert( decimal(7), ds.id_gti   )  
--                        Convert( decimal(7), ds.id_evt   )
-- #6 FS le 21/09/2006 : Modification test pour les types caractères
-- #7 FS le 04/02/2008 : Désactivation de la trace dans w_log_data_script
-- V01 FS le 08/09/2009 : Spécifique ATLAS : Pas d'ordre de création du détail
-- FPI - 12/11/2014 : [PC972]
-- #6 FS  13/10/2014 : [PC972] Demande FLP modificatin gestion report pièces et refus : Clé
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[PS_X_UPD_W_DETAIL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[PS_X_UPD_W_DETAIL]
GO

CREATE  procedure [sysadm].[PS_X_UPD_W_DETAIL]
 @iIdArchive Integer,
 @iIdSin     Integer,
 @sCodOper   Varchar(4),
 @sRetour    Varchar(254) Output

AS

Declare @sSep       Char(1) 
Declare @sCodInter  Char(1)
Declare @sIdCodZone Varchar(20)
Declare @sVal       Varchar(254)
Declare @sCmd       Varchar(254)


Declare @dcIdGti     decimal(7)
Declare @dcIdSin     decimal(10) -- [PI062]
Declare @dcIdEvt     decimal(7)
Declare @dcIdPce     decimal(7)
Declare @dcIdMotif   decimal(7)
Declare @dcIdNouvEvt decimal(7)
Declare @dcIdDetail  decimal(7)        
Declare @dcIdI        decimal(7) 

Declare @iIdSeq     Integer
Declare @iRet       Integer
Declare @iIdTypRep  Integer


Declare @iIdSeq0     Integer
Declare @sIdCodZone0 Varchar(20)
Declare @sVal0       Varchar(254)
Declare @iFlagDet    Integer

Select @dcIdSin    = Convert ( Decimal(10,0), @iIdSin ) -- [PI062]

Select @iRet       = 0
Select @dcIdDetail = -1

/*------------------------------------------------------------------*/
/* Cr‚ation des nouveaux ‚vŠnements                                 */
/*------------------------------------------------------------------*/

  DECLARE cur1 CURSOR FOR

     /*----------------------------------------------*/
     /* (1) selection des ‚vŠnements … cr‚er         */
     /*----------------------------------------------*/
     /* #2 Ajt [ And ds.id_evt = '-1' ]              */
     /*----------------------------------------------*/

    SELECT ds.id_seq_rp,
         Lower( ds.id_code_zone ) , 
         RTRIM(ds.val)                 , -- [I027], En 2008, il faut trimer les variables Char. Lfct TrimSPAces de PB semble inopérante
         ds.id_typ_rep,
         Convert( decimal(7), ds.id_gti   ),
         Convert( decimal(7), ds.id_evt   ),
         Convert( decimal(7), ds.id_piece ),
         Convert( decimal(7), ds.id_motif ),
         ds.cod_inter

    FROM
         sysadm.w_data_script ds
    WHERE

         ds.id_archive   = @iIdArchive  And
         ds.id_code_zone = 'ID_EVT'     And
         ds.alt_gestion  = 'O'          And
         ds.id_evt       = '-1'

   UNION ALL

     /*----------------------------------------------*/
     /* (2) selection des donn‚es / evt cr‚‚s        */
     /*----------------------------------------------*/

   SELECT ds.id_seq_rp,
          Lower( ds.id_code_zone ) , 
          RTRIM(ds.val)                 , -- [I027], En 2008, il faut trimer les variables Char. Lfct TrimSPAces de PB semble inopérante
          ds.id_typ_rep,
          Convert( decimal(7),ds.id_gti   ),
          Convert( decimal(7),ds.id_evt   ),
          Convert( decimal(7),ds.id_piece ),
          Convert( decimal(7),ds.id_motif ),
          ds.cod_inter
    FROM
         sysadm.w_data_script ds,
         sysobjects so,
         syscolumns sc
   WHERE

         so.name = 'w_detail' And 
         so.type = 'U'        And
         so.id   = sc.id      And
      
         sc.name = lower ( ds.id_code_zone ) And

         ds.alt_gestion = 'O' And
         ds.id_gti    <> '-1'   And
         ds.id_evt    <> '-1'   And
         ( ds.id_motif = '-1'   And ds.id_piece = '-1' ) And
         ds.id_archive = @iIdArchive

 UNION ALL

     /*----------------------------------------------*/
     /* (3) selection des pieces & refus / evt cr‚‚s */
     /*----------------------------------------------*/

   SELECT ds.id_seq_rp,
          Lower( ds.id_code_zone ) , 
          RTRIM(ds.val)                 , -- [I027], En 2008, il faut trimer les variables Char. Lfct TrimSPAces de PB semble inopérante
          ds.id_typ_rep,
          Convert( decimal(7),ds.id_gti   ),
          Convert( decimal(7),ds.id_evt   ),
          Convert( decimal(7),ds.id_piece ),
          Convert( decimal(7),ds.id_motif ),
          ds.cod_inter
    FROM
         sysadm.w_data_script ds
   WHERE
         ds.id_gti    <> '-1' And
         ds.id_evt    <> '-1' And
         ( ds.id_motif<> '-1' Or ds.id_piece <> '-1' ) And
         ds.id_archive = @iIdArchive

   ORDER BY
         ds.id_seq_rp,
         Convert( decimal(7), ds.id_gti   ), 
         Convert( decimal(7), ds.id_evt   )

   OPEN cur1

   Select @iIdSeq0     = -1
   Select @sIdCodZone0 = ''
   Select @sVal0       = ''
   Select @iFlagDet    = 0

   FETCH cur1 INTO @iIdSeq, @sIdCodZone, @sVal, @iIdTypRep, @dcIdGti, @dcIdEvt, @dcIdPce, @dcIdMotif, @sCodInter

   WHILE @@fetch_status <> -1
     
     Begin

        
        /*-----------------------------------------------*/
        /* #1 Rupture sur id_seq_rp / @sVal              */
        /*-----------------------------------------------*/

        If @iIdSeq <> @iIdSeq0 Or @sIdCodZone <> @sIdCodZone0 Or @sVal <> @sVal0
           Begin

		Select @iIdSeq0     = @iIdSeq
		Select @sIdCodZone0 = @sIdCodZone
		Select @sVal0       = @sVal
                Select @iFlagDet    = 1           /* Cr‚ation d'un nouveau d‚tail */

           End

	Else

           Begin

                Select @iFlagDet = 0              /* On continue sur le mˆme d‚tail */

           End


        /*-----------------------------------------------*/
        /* Cr‚ation d'un d‚tail pour l'‚vŠnement         */
        /*-----------------------------------------------*/

        If @dcIdEvt = -1 And @iFlagDet = 1

           Begin /* ... D‚but cr‚ation ...*/

             Select @dcIdNouvEvt = Convert( Decimal(7,0), @sVal )

             Exec @iRet = sysadm.PS_I01_W_DETAIL @dcIdSin, @dcIdGti, @dcIdNouvEvt, @sCodOper, @dcIdDetail Output 

             Select @sCmd = 'INSERT detail id_evt=' + Convert ( varchar(10), @dcIdNouvEvt ) +  '/id_detail=' + Convert ( varchar(10), @dcIdDetail ) + ' sur id_gti=' + Convert ( varchar(10), @dcIdGti )
             -- #7 INSERT INTO sysadm.w_log_data_script SELECT @iIdArchive, @dcIdSin, @iRet, @sCmd, getdate(), @sCodOper 

	     If @iRet = -1
                Begin
                  Select @sRetour = 'PS_I01_W_GAR_SIN:Erreur creation evt ' + Convert ( varchar(10), @dcIdNouvEvt ) + ' Sin/Gti ' + Convert ( varchar(10), @dcIdSin ) + '/' + Convert ( varchar(10), @dcIdGti ) 
	          Break
                End

           End   /* ... Fin cr‚ation ...*/

        /*-----------------------------------------------*/
        /*  Mise … jour des donn‚es sur un ‚vŠnement     */
        /*-----------------------------------------------*/

        If @dcIdEvt <> -1 And @dcIdPce = -1 And @dcIdMotif = -1 And @iFlagDet = 1

                  /*-----------------------*/
           Begin  /*  D‚but maj evt        */
                  /*-----------------------*/

			/* ... #6 <20 ald <16 */

		 If @iIdTypRep < 20 Or @iIdTypRep = 50
 	            Begin
           	      Select @sSep = ''''
	            End
      		 Else
         	    Begin
           	      Select @sSep = ''
	            End

			 SET @sVal=REPLACE(@sVal,'''','''''') -- FPI - 29/04/2019 - ISM6044

  	     	 Select @sCmd = 'UPDATE sysadm.w_detail SET ' + @sIdCodZone + '=' + @sSep + @sVal + @sSep + 
                      ' WHERE id_sin=' + Convert ( varchar(10), @dcIdSin ) + '.' +
                      ' AND id_gti='   + Convert ( varchar(10), @dcIdGti ) +
                      ' AND id_detail='+ Convert ( varchar(10), @dcIdDetail)

	     	 Execute ( @sCmd )

             	 Select @iRet = @@rowcount

             	 If @iRet <> 1
                    Begin
                      Select @iRet = -1
                      Select @sRetour = @sRetour + @sIdCodZone + '=' + @sSep + @sVal + @sSep + char(13)
                    End
                 Else
                    Begin
                      Select @iRet = 0
                    End

	      -- #7  INSERT INTO sysadm.w_log_data_script SELECT @iIdArchive, @dcIdSin, @iRet, @sCmd, getdate(), @sCodOper 

                 /*-----------------------*/
           End   /*  Fin maj evt          */
                 /*-----------------------*/

      /*-----------------------------------------------*/
        /*  Cr‚ation des piŠces sur l'‚vŠnement          */
        /*-----------------------------------------------*/

        If @dcIdEvt <> -1 And @dcIdPce <> -1 

                  /*-----------------------*/
           Begin  /*  D‚but tag piŠce      */
                  /*-----------------------*/

               SELECT @dcIdI = Max( i.id_i ) FROM sysadm.w_inter i WHERE i.id_sin = @dcIdSin And i.cod_inter = @sCodInter

					If @dcIdI is not null
					begin -- [ITSM 49739]
						-- [PC972] Début retrait du test de la révision
						INSERT into sysadm.w_piece
						SELECT TOP 1 --> [PC972] je prends la 1ère ligne
						@dcIdSin, @dcIdGti, @dcIdDetail, @dcIdPce, @dcIdI, p.id_para, p.cpt_tri , getdate(),getdate(), @sCodOper
						FROM   sysadm.w_sin s,
						sysadm.piece p
						WHERE
						s.id_prod = p.id_prod And
						s.id_sin  = @dcIdSin   And
						--p.id_rev  = -1       And --> [PC972] Retrait de la révision
						p.id_gti  = @dcIdGti   And
						p.id_pce  = @dcIdPce   And NOT EXISTS 
						( SELECT * FROM sysadm.w_piece v WHERE
						v.id_sin    = @dcIdSin    And 
						v.id_gti    = @dcIdGti    And
						v.id_detail = @dcIdDetail And
						v.id_pce    = @dcIdPce )						
						-- [PC972] Fin   retrait du test de la révision
	
	                Select @iRet = @@ROWCOUNT
	
						If @iRet <> 1
	                   Begin
	                      Select @iRet = -1
	                      Select @sRetour = @sRetour + 'id_pce=' + convert ( varchar(10), @dcIdPce ) + ' sur id_gti=' + convert ( varchar(5), @dcIdGti )  + ' id_detail=' + convert ( varchar(5), @dcIdDetail ) + char(13)
	                   End
	                Else 
	                   Begin
	                      Select @iRet = 0
	                   End
	
	            	Select @sCmd = 'INSERT piece id_pce=' + convert ( varchar(5), @dcIdPce ) + ' sur id_gti=' + convert ( varchar(5), @dcIdGti )  + ' id_detail=' + convert ( varchar(5), @dcIdDetail ) 
		       -- #7 INSERT INTO sysadm.w_log_data_script SELECT @iIdArchive, @dcIdSin, @iRet, @sCmd, getdate(), @sCodOper 

				End -- [ITSM 49739]

                  /*-----------------------*/
           End    /*  Fin tag piŠce        */
                  /*-----------------------*/


        /*-----------------------------------------------*/
        /* Cr‚ation des motifs sur l'‚vŠnement           */
        /*-----------------------------------------------*/

 	If @dcIdEvt <> -1 And @dcIdMotif <> -1 

                  /*-----------------------*/
           Begin  /*  D‚but tag motif      */
                  /*-----------------------*/

               SELECT @dcIdI = Max( i.id_i ) FROM sysadm.w_inter i WHERE i.id_sin = @dcIdSin And i.cod_inter = @sCodInter

					If @dcIdI is Not null
					begin -- [ITSM 49739]
						-- [PC972] Début retrait du test de la révision
						INSERT into sysadm.w_refus
						SELECT TOP 1--> [PC972] je prends la 1ère ligne
						@dcIdSin, @dcIdGti, @dcIdDetail, @dcIdMotif, 'N', 'O', @dcIdI,  p.id_para, p.cpt_tri , getdate(),getdate(), @sCodOper
						FROM   sysadm.w_sin s,
						sysadm.motif p
						WHERE
						s.id_prod = p.id_prod And
						s.id_sin  = @dcIdSin   And
						--p.id_rev  = -1       And --> [PC972] Retrait de la révision
						p.id_gti  = @dcIdGti   And
						p.id_motif= @dcIdMotif And NOT EXISTS 
						( SELECT * FROM sysadm.w_refus v WHERE
						v.id_sin    = @dcIdSin    And 
						v.id_gti    = @dcIdGti    And
						v.id_detail = @dcIdDetail And
						v.id_motif  = @dcIdMotif )						
						-- [PC972] Fin   retrait du test de la révision
	
	                Select @iRet = @@ROWCOUNT
	
					If @iRet <> 1
	                   Begin
	                      Select @iRet = -1
	                      Select @sRetour = @sRetour + 'id_motif=' + convert ( varchar(10), @dcIdMotif ) + ' sur id_gti=' + convert ( varchar(5), @dcIdGti )  + ' id_detail=' + convert ( varchar(5), @dcIdDetail ) + char(13)
	                   End
	                Else 
	                   Begin
	                      Select @iRet = 0
	                   End
	
	            	Select @sCmd = 'INSERT refus id_motif=' + convert ( varchar(5), @dcIdMotif ) + ' sur id_gti=' + convert ( varchar(5), @dcIdGti )  + ' id_detail=' + convert ( varchar(5), @dcIdDetail ) 
		        -- #7 INSERT INTO sysadm.w_log_data_script SELECT @iIdArchive, @dcIdSin, @iRet, @sCmd, getdate(), @sCodOper 

				end -- [ITSM 49739]

                  /*-----------------------*/
           End    /*  Fin tag motif        */
                  /*-----------------------*/

        /*-----------------------------------------------*/
        /* EvŠnement … cr‚er Lecture suivant             */
        /*-----------------------------------------------*/

         Select @iRet = 0

         FETCH cur1 INTO @iIdSeq, @sIdCodZone, @sVal, @iIdTypRep, @dcIdGti, @dcIdEvt, @dcIdPce, @dcIdMotif, @sCodInter
     End

  CLOSE cur1
  
  DEALLOCATE cur1

  Return @iRet

Go

grant execute on sysadm.PS_X_UPD_W_DETAIL to rolebddsinistres
Go


-------------------------------------------------------------------------------
-- V01 FS le 08/09/2009 : Spécifique ATLAS : Pas d'ordre de création du détail
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_X_UPD_W_DETAIL_V01' AND type = 'P' )
DROP procedure sysadm.PS_X_UPD_W_DETAIL_V01
GO

CREATE  procedure [sysadm].[PS_X_UPD_W_DETAIL_V01]
 @iIdArchive Integer,
 @iIdSin     Integer,
 @sCodOper   Varchar(4),
 @sRetour    Varchar(254) Output

AS

Declare @sSep       Char(1) 
Declare @sCodInter  Char(1)
Declare @sIdCodZone Varchar(20)
Declare @sVal       Varchar(254)
Declare @sCmd       Varchar(254)


Declare @dcIdGti     decimal(7)
Declare @dcIdSin     decimal(10) -- [PI062]
Declare @dcIdEvt     decimal(7)
Declare @dcIdPce     decimal(7)
Declare @dcIdMotif   decimal(7)
Declare @dcIdNouvEvt decimal(7)
Declare @dcIdDetail  decimal(7)        
Declare @dcIdI        decimal(7) 

Declare @iIdSeq     Integer
Declare @iRet       Integer
Declare @iIdTypRep  Integer


Declare @iIdSeq0     Integer
Declare @sIdCodZone0 Varchar(20)
Declare @sVal0       Varchar(254)
Declare @iFlagDet    Integer

Select @dcIdSin    = Convert ( Decimal(10,0), @iIdSin ) -- [PI062]

Select @iRet       = 0
Select @dcIdDetail = -1


/*------------------------------------------------------------------*/
/* Cr‚ation des nouveaux ‚vŠnements                                 */
/*------------------------------------------------------------------*/

  DECLARE cur1 CURSOR FOR

     /*----------------------------------------------*/
     /* (1) selection des ‚vŠnements … cr‚er         */
     /*----------------------------------------------*/
     /* #2 Ajt [ And ds.id_evt = '-1' ]              */
     /* V01 Atlas cette ligne est absente            */
     /*----------------------------------------------*/

    SELECT ds.id_seq_rp,
         Lower( ds.id_code_zone ) , 
         RTRIM(ds.val)                 , -- [I027], En 2008, il faut trimer les variables Char. Lfct TrimSPAces de PB semble inopérante
         ds.id_typ_rep,
         Convert( decimal(7), ds.id_gti   ),
         Convert( decimal(7), ds.id_evt   ),
         Convert( decimal(7), ds.id_piece ),
         Convert( decimal(7), ds.id_motif ),
         ds.cod_inter

    FROM
         sysadm.w_data_script ds
    WHERE

         ds.id_archive   = @iIdArchive  And
         ds.id_code_zone = 'ID_EVT'     And
         ds.alt_gestion  = 'O'          And
         ds.id_evt       = '-1'

   UNION ALL

     /*----------------------------------------------*/
     /* (2) selection des donn‚es / evt cr‚‚s        */
     /*----------------------------------------------*/

   SELECT ds.id_seq_rp,
          Lower( ds.id_code_zone ) , 
          RTRIM(ds.val)                 ,-- [I027], En 2008, il faut trimer les variables Char. Lfct TrimSPAces de PB semble inopérante
          ds.id_typ_rep,
          Convert( decimal(7),ds.id_gti   ),
          Convert( decimal(7),ds.id_evt   ),
          Convert( decimal(7),ds.id_piece ),
          Convert( decimal(7),ds.id_motif ),
          ds.cod_inter
    FROM
         sysadm.w_data_script ds,
         sysobjects so,
         syscolumns sc
   WHERE

         so.name = 'w_detail' And 
         so.type = 'U'        And
         so.id   = sc.id      And
      
         sc.name = lower ( ds.id_code_zone ) And

         ds.alt_gestion = 'O' And
         ds.id_gti    <> '-1'   And
         ds.id_evt    <> '-1'   And
         ( ds.id_motif = '-1'   And ds.id_piece = '-1' ) And
         ds.id_archive = @iIdArchive

 UNION ALL

     /*----------------------------------------------*/
     /* (3) selection des pieces & refus / evt cr‚‚s */
     /*----------------------------------------------*/

   SELECT ds.id_seq_rp,
          Lower( ds.id_code_zone ) , 
          RTRIM(ds.val)                 , -- [I027], En 2008, il faut trimer les variables Char. Lfct TrimSPAces de PB semble inopérante
          ds.id_typ_rep,
          Convert( decimal(7),ds.id_gti   ),
          Convert( decimal(7),ds.id_evt   ),
          Convert( decimal(7),ds.id_piece ),
          Convert( decimal(7),ds.id_motif ),
          ds.cod_inter
    FROM
         sysadm.w_data_script ds
   WHERE
         ds.id_gti <> '-1' And
         ds.id_evt    <> '-1' And
         ( ds.id_motif<> '-1' Or ds.id_piece <> '-1' ) And
         ds.id_archive = @iIdArchive

   ORDER BY
         ds.id_seq_rp,
         Convert( decimal(7), ds.id_gti   ), 
         Convert( decimal(7), ds.id_evt   )

   OPEN cur1

   Select @iIdSeq0     = -1
   Select @sIdCodZone0 = ''
   Select @sVal0       = ''
   Select @iFlagDet    = 0

   FETCH cur1 INTO @iIdSeq, @sIdCodZone, @sVal, @iIdTypRep, @dcIdGti, @dcIdEvt, @dcIdPce, @dcIdMotif, @sCodInter

   WHILE @@fetch_status <> -1
     
     Begin
        
        /*-----------------------------------------------*/
        /* #1 Rupture sur id_seq_rp / @sVal              */
        /*-----------------------------------------------*/

        If @iIdSeq <> @iIdSeq0 Or @sIdCodZone <> @sIdCodZone0 Or @sVal <> @sVal0
           Begin

		Select @iIdSeq0     = @iIdSeq
		Select @sIdCodZone0 = @sIdCodZone
		Select @sVal0       = @sVal
                Select @iFlagDet    = 1           /* Cr‚ation d'un nouveau d‚tail */

           End

	Else

           Begin

                Select @iFlagDet = 0              /* On continue sur le mˆme d‚tail */

           End


        /*-----------------------------------------------*/
        /* Cr‚ation d'un d‚tail pour l'‚vŠnement         */
        /*-----------------------------------------------*/

        If @dcIdEvt = -1 And @iFlagDet = 1

           Begin /* ... D‚but cr‚ation ...*/
           
             Select @dcIdNouvEvt = Convert( Decimal(7,0), @sVal )

             Exec @iRet = sysadm.PS_I01_W_DETAIL @dcIdSin, @dcIdGti, @dcIdNouvEvt, @sCodOper, @dcIdDetail Output 

             Select @sCmd = 'INSERT detail id_evt=' + Convert ( varchar(10), @dcIdNouvEvt ) +  '/id_detail=' + Convert ( varchar(10), @dcIdDetail ) + ' sur id_gti=' + Convert ( varchar(10), @dcIdGti )
             -- #7 INSERT INTO sysadm.w_log_data_script SELECT @iIdArchive, @dcIdSin, @iRet, @sCmd, getdate(), @sCodOper 

	     If @iRet = -1
                Begin
                  Select @sRetour = 'PS_I01_W_GAR_SIN:Erreur creation evt ' + Convert ( varchar(10), @dcIdNouvEvt ) + ' Sin/Gti ' + Convert ( varchar(10), @dcIdSin ) + '/' + Convert ( varchar(10), @dcIdGti ) 
	          Break
                End

           End   /* ... Fin cr‚ation ...*/

        /*-----------------------------------------------*/
        /*  Mise … jour des donn‚es sur un ‚vŠnement     */
        /*-----------------------------------------------*/

        If @dcIdEvt <> -1 And @dcIdPce = -1 And @dcIdMotif = -1 And @iFlagDet = 1

                  /*-----------------------*/
           Begin  /*  D‚but maj evt        */
                  /*-----------------------*/
                  
              --> V01 ; L'évènement existe t-il ? non = création

               Set @dcIdDetail = Null

               Select @dcIdDetail = Min ( id_detail ) From sysadm.w_detail Where id_sin = @dcIdSin And id_gti = @dcIdGti And id_evt = @dcIdEvt

               If @dcIdDetail is null

                  Begin -- Création de l'évènement
                    -- [ITSM137396] si évènement non créé correctif je prends @dcIdEvt   
                    -- Set @dcIdNouvEvt = Convert( Decimal(7,0), @sVal )
                     Set @dcIdNouvEvt = Convert( Decimal(7,0), @dcIdEvt )
                                          
                     Exec @iRet = sysadm.PS_I01_W_DETAIL @dcIdSin, @dcIdGti, @dcIdNouvEvt, @sCodOper, @dcIdDetail Output 
                     
                     Select @sCmd = 'INSERT detail id_evt=' + Convert ( varchar(10), @dcIdNouvEvt ) +  '/id_detail=' + Convert ( varchar(10), @dcIdDetail ) + ' sur id_gti=' + Convert ( varchar(10), @dcIdGti )
                                          
                     If @iRet = -1
                      Begin
                        Select @sRetour = 'PS_I01_W_DETAL:Erreur creation evt ' + Convert ( varchar(10), @dcIdNouvEvt ) + ' Sin/Gti ' + Convert ( varchar(10), @dcIdSin ) + '/' + Convert ( varchar(10), @dcIdGti ) 
                        Break
                      End
   
                  End -- Création de l'évènement


             -- V01  ; Mise à jour de l'évènement pré-existant

			/* ... #6 <20 ald <16 */

		       If @iIdTypRep < 20 Or @iIdTypRep = 50
 	            Begin
           	      Select @sSep = '''',
           			@sVal=REPLACE(@sVal,'''','''''')
	            End
      		 Else
         	    Begin
           	      Select @sSep = ''
	            End

  	     	 Select @sCmd = 'UPDATE sysadm.w_detail SET ' + @sIdCodZone + '=' + @sSep + @sVal + @sSep + 
                      ' WHERE id_sin=' + Convert ( varchar(10), @dcIdSin ) + '.' +
                      ' AND id_gti='   + Convert ( varchar(10), @dcIdGti ) +
                      ' AND id_detail='+ Convert ( varchar(10), @dcIdDetail)
            			
	     	 Execute ( @sCmd )

             	 Select @iRet = @@rowcount

             	 If @iRet <> 1
                    Begin
                      Select @iRet = -1
                      Select @sRetour = @sRetour + @sIdCodZone + '=' + @sSep + @sVal + @sSep + char(13)
                    End
                 Else
                    Begin
                      Select @iRet = 0
                    End

	      -- #7  INSERT INTO sysadm.w_log_data_script SELECT @iIdArchive, @dcIdSin, @iRet, @sCmd, getdate(), @sCodOper 

                 /*-----------------------*/
           End   /*  Fin maj evt          */
                 /*-----------------------*/

        /*-----------------------------------------------*/
        /*  Cr‚ation des piŠces sur l'‚vŠnement          */
        /*-----------------------------------------------*/

        If @dcIdEvt <> -1 And @dcIdPce <> -1 

                  /*-----------------------*/
           Begin  /*  D‚but tag piŠce      */
                  /*-----------------------*/

               SELECT @dcIdI = Max( i.id_i ) FROM sysadm.w_inter i WHERE i.id_sin = @dcIdSin And i.cod_inter = @sCodInter

					If @dcIdI is not null
					Begin -- [ITSM 49739]
	
	               INSERT into sysadm.w_piece
	               SELECT top 1 -- [PC972] Retrait test de la révision : 1ere ligne
					@dcIdSin, @dcIdGti, @dcIdDetail, @dcIdPce, @dcIdI, p.id_para, p.cpt_tri , getdate(),getdate(), @sCodOper
	               FROM   sysadm.w_sin s,
	                      sysadm.piece p
	               WHERE
	                      s.id_prod = p.id_prod And
	                      s.id_sin  = @dcIdSin   And
	
	                      --p.id_rev  = -1        And -- [PC972] Retrait test de la révision 
	                      p.id_gti  = @dcIdGti   And
	                      p.id_pce  = @dcIdPce   And NOT EXISTS 
	                ( SELECT * FROM sysadm.w_piece v WHERE
	                                   v.id_sin    = @dcIdSin    And 
	                                   v.id_gti    = @dcIdGti    And
	                                   v.id_detail = @dcIdDetail And
	                                   v.id_pce    = @dcIdPce )
	
	                Select @iRet = @@ROWCOUNT
	
					If @iRet <> 1
	                   Begin
	                      Select @iRet = -1
	                      Select @sRetour = @sRetour + 'id_pce=' + convert ( varchar(10), @dcIdPce ) + ' sur id_gti=' + convert ( varchar(5), @dcIdGti )  + ' id_detail=' + convert ( varchar(5), @dcIdDetail ) + char(13)
	                   End
	                Else 
	                   Begin
	                      Select @iRet = 0
	                   End
	
	            	Select @sCmd = 'INSERT piece id_pce=' + convert ( varchar(5), @dcIdPce ) + ' sur id_gti=' + convert ( varchar(5), @dcIdGti )  + ' id_detail=' + convert ( varchar(5), @dcIdDetail ) 
		       -- #7 INSERT INTO sysadm.w_log_data_script SELECT @iIdArchive, @dcIdSin, @iRet, @sCmd, getdate(), @sCodOper 

				End -- [ITSM 49739]

                  /*-----------------------*/
           End    /*  Fin tag piŠce        */
                  /*-----------------------*/


        /*-----------------------------------------------*/
        /* Cr‚ation des motifs sur l'‚vŠnement           */
        /*-----------------------------------------------*/

 	If @dcIdEvt <> -1 And @dcIdMotif <> -1 

                  /*-----------------------*/
           Begin  /*  D‚but tag motif      */
                  /*-----------------------*/

               SELECT @dcIdI = Max( i.id_i ) FROM sysadm.w_inter i WHERE i.id_sin = @dcIdSin And i.cod_inter = @sCodInter

					If @dcIdI is not null
					Begin -- [ITSM 49739]

	               INSERT into sysadm.w_refus
	               SELECT top 1 -- [PC972] Retrait test de la révision : 1ere ligne
	               @dcIdSin, @dcIdGti, @dcIdDetail, @dcIdMotif, 'N', 'O', @dcIdI,  p.id_para, p.cpt_tri , getdate(),getdate(), @sCodOper
	               FROM   sysadm.w_sin s,
	                      sysadm.motif p
	               WHERE
	                      s.id_prod = p.id_prod And
	                      s.id_sin  = @dcIdSin   And
	
	                    --  p.id_rev  = -1        And -- [PC972] Retrait test de la révision : 1ere ligne
	                      p.id_gti  = @dcIdGti   And
	                      p.id_motif= @dcIdMotif And NOT EXISTS 
	                ( SELECT * FROM sysadm.w_refus v WHERE
	                                   v.id_sin    = @dcIdSin    And 
	                                   v.id_gti    = @dcIdGti    And
	                                   v.id_detail = @dcIdDetail And
	                                   v.id_motif  = @dcIdMotif )
	
	                Select @iRet = @@ROWCOUNT
	
						If @iRet <> 1
	                   Begin
	                      Select @iRet = -1
	                      Select @sRetour = @sRetour + 'id_motif=' + convert ( varchar(10), @dcIdMotif ) + ' sur id_gti=' + convert ( varchar(5), @dcIdGti )  + ' id_detail=' + convert ( varchar(5), @dcIdDetail ) + char(13)
	                   End
	                Else 
	                   Begin
	                      Select @iRet = 0
	                   End
	
	            	Select @sCmd = 'INSERT refus id_motif=' + convert ( varchar(5), @dcIdMotif ) + ' sur id_gti=' + convert ( varchar(5), @dcIdGti )  + ' id_detail=' + convert ( varchar(5), @dcIdDetail ) 
		        -- #7 INSERT INTO sysadm.w_log_data_script SELECT @iIdArchive, @dcIdSin, @iRet, @sCmd, getdate(), @sCodOper 

				End -- [ITSM 49739]

                  /*-----------------------*/
           End    /*  Fin tag motif        */
                  /*-----------------------*/

        /*-----------------------------------------------*/
        /* EvŠnement … cr‚er Lecture suivant             */
        /*-----------------------------------------------*/

         Select @iRet = 0

         FETCH cur1 INTO @iIdSeq, @sIdCodZone, @sVal, @iIdTypRep, @dcIdGti, @dcIdEvt, @dcIdPce, @dcIdMotif, @sCodInter
     End

  CLOSE cur1
  
  DEALLOCATE cur1

  Return @iRet
Go

grant execute on sysadm.PS_X_UPD_W_DETAIL_V01 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure   : PS_X_UPD_W_DIV_SIN
-- Auteur      : FS
-- Date        : 01/10/2007
-- Libell‚     : SIMPA : Mise à jour des donn‚es du script dans la table W_DIV_SIN
--
-- Références  :       
--
-- Arguments   : @iIdArchive : Integer : Lot d'archive … traiter
--               @iIdSin     : Integer : Numero de sinistre … traiter
--	                        
-------------------------------------------------------------------------------
--	#1 FS le 05/11/2007 ; Fnac EPT ; Gestion des types montants & caractères
--  #2 FS le 23/12/2013 ; [PC947] Advise ; limitation au 16 1er caractères pour résoudre le pb des div_pro trop longs
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_X_UPD_W_DIV_SIN' AND type = 'P' )
DROP procedure sysadm.PS_X_UPD_W_DIV_SIN
GO

CREATE procedure sysadm.PS_X_UPD_W_DIV_SIN
 @iIdArchive Integer,
 @iIdSin     Integer,
 @sCodOper   Varchar(4),
 @sRetour    Varchar(254) Output

AS

Declare @sIdCodZone Varchar(20)
Declare @sVal       Varchar(254)


Declare @iIdTypRep  Integer
Declare @iRet       Integer
Declare @iVal       Integer
Declare @dtVal      Datetime
Declare @dcVal      Decimal( 11,2) -- #1
Declare @sVal2      Varchar(120)   -- #1

Declare @dcIdSin    Decimal(10, 0) -- [PI062]
Declare @dcIdProd   Decimal(7,0)

Select @dcIdSin = Convert ( Decimal(10,0), @iIdSin ) -- [PI062]

Select @dcIdProd = id_prod FROM sysadm.w_sin WHERE id_sin = @dcIdSin

Set @iRet  = 0

/*------------------------------------------------------------------*/
/* Ouverture du curseur                                             */
/*------------------------------------------------------------------*/
    
  DECLARE cur_div CURSOR FOR

  SELECT Lower( Substring( ds.id_code_zone, 5, Len(ds.id_code_zone) ) )as id_code_zone , 
         ds.val                 ,
         ds.id_typ_rep
    FROM
         sysadm.w_data_script ds
   WHERE
         ds.alt_gestion  = 'O'          And
         ds.id_code_zone like '#DS%'    And
         ds.id_archive   = @iIdArchive         
     
  OPEN cur_div

  FETCH cur_div INTO @sIdCodZone, @sVal, @iIdTypRep

WHILE @@fetch_status <> -1

  Begin

	/*------------------------------------------------------------------*/
	/* Insertion dans w_div_sin à partie de @sIdCodZone                 */
	/*------------------------------------------------------------------*/

    Set @iVal = null
    Set @dtVal = null
	 Set @sVal2 = Null -- #1
    Set @dcVal = Null -- #1

	 If @iIdTypRep = 20 Set @iVal = Convert (integer, @sVal )

    If @iIdTypRep = 50 Set @dtVal = Convert ( datetime, @sVal )

	 If @iIdTypRep between 30 and 40 And isnumeric ( @sVal ) = 1 Set @dcVal = Convert ( decimal(11,2), @sVal )

	 If @iIdTypRep between 1 and 20  Set @sVal2 = Convert ( varchar(35), Left ( @sVal, 35 ) )

	INSERT INTO sysadm.w_div_sin 
		( 	id_sin, 
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
	Select
		@dcIdSin        as id_sin, 
	   @sIdCodZone     as nom_zone , 
	   dp.lib_label,
	   dp.id_typ_liste,
	   dp.alt_liste_codecar,
	   dp.id_typ_zone, 
	   dp.alt_oblig,
      'N'             as alt_prot,
		dp.cpt_tri,
      @iVal	          as val_nbre,
	   @dcVal          as val_mt,  -- #1 ald null
	   @dtVal          as val_dte, 
	   @sVal2          as val_car, -- #1 ald null
		0               as cpt_valide,
		getdate(),
		getdate(), 
		@sCodOper		
   From sysadm.div_pro dp
   Where
         dp.id_prod = @dcIdProd And
         Left ( dp.nom_zone,16 ) = @sIdCodZone --> #2 [PC947] Dans Sherpa scripting #DS_ (4) + nom(16) = 20 maxi !
                                               -->            Limitation de l'identification sur les 16 1ers

	Set @iRet = @@error

	If @iRet <> 0
        Begin
          Select @sRetour = 'PS_X_UPD_W_DIV_SIN:Erreur création DivSin ' + Convert ( varchar(10), @dcIdSin ) + ' Zone ' + @sIdCodZone
	       Break
        End

	/*------------------------------------------------------------------*/
	/* Lecture de la donn‚e suivante                                    */
	/*------------------------------------------------------------------*/

        FETCH cur_div INTO @sIdCodZone, @sVal, @iIdTypRep

  End

CLOSE cur_div

DEALLOCATE cur_div
Go

grant execute on sysadm.PS_X_UPD_W_DIV_SIN to rolebddsinistres
Go



--------------------------------------------------------------------
--
-- Procédure   : PS_X_UPD_DATA_SCRIPT
-- Date        : 08/04/2002
-- Libell‚     : SIMPA : Procédure principale de mise … jour des donn‚es du script 
--                 Appel des sous procédures
--                   PS_X_UPD_W_SIN      : Maj donn‚es sur w_sin
--                   PS_X_UPD_W_GAR_SIN  : Maj / cr‚ation sur w_gar_sin + pieces + refus associ‚s
--                   PS_X_UPD_W_DETAIL   : Cr‚ation sur w_detail + piŠces + refus associ‚s
--
--
-- Références  :       
--
-- Arguments   : @iIdArchive : Integer     : Lot d'archive … traiter
--               @iIdSin     : Integer     : Numero de sinistre … traiter
--               @sCodOper   : Varchar(4)  : Code operateur connect‚
--               @sCodRetour : Varchar(254): OK / Erreur rencontr‚es
--	                        
-------------------------------------------------------------------
-- #1 FS le 14/01/2004 : Désactivation de la trace dans w_log_data_script
-- #2 FS le 01/10/2007 : Dcmp 60244 Gestion de la table w_div_sin
-- #3 FS le 04/02/2008 : Désactivation de la trace dans w_log_data_script
----------------------------------------------------------------------------------
--	V01 : Version spécifique pour ATLAS ; avec appel de la  PS_X_UPD_W_DETAIL_V01                       
----------------------------------------------------------------------------------



IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_X_DATA_SCRIPT' AND type = 'P' )
DROP procedure sysadm.PS_X_DATA_SCRIPT
GO

CREATE procedure sysadm.PS_X_DATA_SCRIPT
 @iIdArchive Integer,
 @iIdSin     Integer,
 @sCodOper   Varchar(4),
 @sRetour    Varchar(254) Output

AS

Declare @iRet Integer
Declare @sRet varchar(254)
Select  @iRet    = 0
Select @sRetour = 'OK'

/*---------------------------*/
/* Mise … jour sur w_sin     */
/*---------------------------*/
If @iRet = 0
   Begin
        Exec @iRet = sysadm.PS_X_UPD_W_SIN     @iIdArchive, @iIdSin, @sCodOper, @sRet Output
        If @iRet <> 0 Select @sRetour = 'PS_X_UPD_W_GAR_SIN:Erreur sur w_sin'
   End

/*---------------------------*/
/* Mise … jour sur w_gar_sin */
/*---------------------------*/

If @iRet = 0
   Begin
	Exec @iRet = sysadm.PS_X_UPD_W_GAR_SIN @iIdArchive, @iIdSin, @sCodOper, @sRet Output
        If @iRet <> 0 Select @sRetour = 'PS_X_UPD_W_GAR_SIN:Erreur sur w_gar_sin'
   End

/*---------------------------*/
/* Mise … jour sur w_detail  */
/*---------------------------*/

If @iRet = 0
   Begin
	Exec @iRet = sysadm.PS_X_UPD_W_DETAIL  @iIdArchive, @iIdSin, @sCodOper, @sRet Output
        If @iRet <> 0 Select @sRetour = 'PS_X_UPD_W_GAR_SIN:Erreur sur w_detail'
   End

/*------------------------------*/
/* #2 Mise à jour sur w_div_sin */
/*------------------------------*/

If @iRet = 0
   Begin
	Exec @iRet = sysadm.PS_X_UPD_W_DIV_SIN  @iIdArchive, @iIdSin, @sCodOper, @sRet Output
        If @iRet <> 0 Select @sRetour = 'PS_X_UPD_W_DIV_SIN:Erreur sur w_div_sin'
   End

/*---------------------------*/
/* RAZ de w_data_script      */
/*---------------------------*/

DELETE FROM sysadm.w_data_script WHERE id_archive = @iIdArchive 

Return @iRet

GO

grant execute on sysadm.PS_X_DATA_SCRIPT to rolebddsinistres
Go

----------------------------------------------------------------------------------
--	V01 : Version spécifique pour ATLAS ; avec appel de la  PS_X_UPD_W_DETAIL_V01                       
----------------------------------------------------------------------------------


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_X_DATA_SCRIPT_V01' AND type = 'P' )
DROP procedure sysadm.PS_X_DATA_SCRIPT_V01
GO

CREATE procedure sysadm.PS_X_DATA_SCRIPT_V01
 @iIdArchive Integer,
 @iIdSin     Integer,
 @sCodOper   Varchar(4),
 @sRetour    Varchar(254) Output

AS

Declare @iRet Integer
Declare @sRet varchar(254)
Select  @iRet    = 0
Select @sRetour = 'OK'

/*---------------------------*/
/* Mise … jour sur w_sin     */
/*---------------------------*/
If @iRet = 0
   Begin
        Exec @iRet = sysadm.PS_X_UPD_W_SIN     @iIdArchive, @iIdSin, @sCodOper, @sRet Output
        If @iRet <> 0 Select @sRetour = 'PS_X_UPD_W_GAR_SIN:Erreur sur w_sin'
   End

/*---------------------------*/
/* Mise … jour sur w_gar_sin */
/*---------------------------*/

If @iRet = 0
   Begin
	Exec @iRet = sysadm.PS_X_UPD_W_GAR_SIN @iIdArchive, @iIdSin, @sCodOper, @sRet Output
        If @iRet <> 0 Select @sRetour = 'PS_X_UPD_W_GAR_SIN:Erreur sur w_gar_sin'
   End

/*------------------------------------*/
/* Mise … jour sur w_detail           */
/* appel version V01 spécifique ATLAS */
/*------------------------------------*/

If @iRet = 0
   Begin
	Exec @iRet = sysadm.PS_X_UPD_W_DETAIL_V01  @iIdArchive, @iIdSin, @sCodOper, @sRet Output
        If @iRet <> 0 Select @sRetour = 'PS_X_UPD_W_GAR_SIN:Erreur sur w_detail'
   End

/*------------------------------*/
/* #2 Mise à jour sur w_div_sin */
/*------------------------------*/

If @iRet = 0
   Begin
	Exec @iRet = sysadm.PS_X_UPD_W_DIV_SIN  @iIdArchive, @iIdSin, @sCodOper, @sRet Output
        If @iRet <> 0 Select @sRetour = 'PS_X_UPD_W_DIV_SIN:Erreur sur w_div_sin'
   End

/*---------------------------*/
/* RAZ de w_data_script      */
/*---------------------------*/

DELETE FROM sysadm.w_data_script WHERE id_archive = @iIdArchive 

Return @iRet

GO

grant execute on sysadm.PS_X_DATA_SCRIPT_V01 to rolebddsinistres
Go