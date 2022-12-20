-------------------------------------------------------------------
--
-- Fichier              :       W_QUEUE.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       
--
-- Proc‚dures           :       
-- sysadm.PS_S02_W_QUEUE_TRACE_SOLDE_WKF
-- sysadm.DW_S02_W_QUEUE_WKF_V01
-- sysadm.PS_S02_W_QUEUE_POCHETTE
-- [sysadm].[DW_S03_W_QUEUE_WKF_V01]
-- [sysadm].[IM_U02_W_QUEUE]
-- [sysadm].[PS_S01_W_QUEUE_TRACE_SOLDE_WKF]
-- [sysadm].[PS_U01_W_QUEUE_WKF]
-- sysadm.DW_S01_W_QUEUE
-- sysadm.DW_S01_W_QUEUE_WKF
-- sysadm.IM_D01_W_QUEUE
-- sysadm.IM_U01_W_QUEUE
-- sysadm.IM_U03_W_QUEUE
-- sysadm.IM_U04_W_QUEUE_CAS1
-- sysadm.PS_D01_W_QUEUE_WKF
-- sysadm.PS_I_DOS_PERDUS_ATLAS_SSUITE_OU_REFUS
-- sysadm.PS_I_ERR_TRAVAIL_ABSENT
-- sysadm.PS_I_VOL_PERDUS_ATLAS_ENCOURS
-- sysadm.PS_I_VOL_PERDUS_ATLAS_SSUITE
-- sysadm.PS_I01_W_QUEUE_WKF
-- sysadm.PS_S_W_QUEUE_COD_TYP_RECU
-- sysadm.PS_S03_W_QUEUE_DELAI_RENONCIATION
-- sysadm.PS_S03_W_QUEUE_TRACE_SOLDE_WKF
-- sysadm.PS_U02_W_QUEUE_WKF
-- sysadm.PS_VAL_W_QUEUE
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I01_W_QUEUE_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libell‚              :        
-- Commentaires         :       Insertion dans la table W_QUEUE
-- R‚f‚rences           :       Utilis‚ dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdProd       Decimal (  7,0 ),       (Val)
--                      :       @dcIdCorb       Decimal (  3,0 ),       (Val)
--                      :       @sNom           Varchar ( 35   ),       (Val)
--                      :       @sPrenom        Varchar ( 35   ),       (Val)
--                      :       @dtCreeLe       DateTime        ,       (Val)
--                      :       @sTxtMess1      Varchar ( 254  ),       (Val)
--                      :       @sCodRecu       Varchar (  1   ),       (Val)
--                      :       @sCodIProv      Varchar (  1   ),       (Val)
--                      :       @dDteRecu       DateTime        ,       (Val)
--                      :       @sCodTypRecu    Varchar (  1   ),       (Val)
--                      :       @dDteCourCli    DateTime                (Val)
--                      :       @sCodOper       Varchar (  4   ),       (Val)
--				@sDosMajPar     Varchar (  4   )	(Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_QUEUE_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_QUEUE_WKF
GO

CREATE procedure sysadm.PS_I01_W_QUEUE_WKF
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @dcIdProd       Decimal (  7,0 ),
        @dcIdCorb       Decimal (  3,0 ),
        @sNom           Varchar ( 35   ),
        @sPrenom        Varchar ( 35   ),
        @dtCreeLe       DateTime        ,
        @sTxtMess1      Varchar ( 254  ),
        @sCodRecu       Varchar (  1   ),
        @sCodIProv      Varchar (  1   ),
        @dDteRecu       DateTime        ,
        @sCodTypRecu    Varchar (  1   ),
        @dDteCourCli    DateTime        ,
        @sCodOper       Varchar (  4   ),
        @sDosMajPar     Varchar (  4   )
AS

 INSERT INTO    sysadm.w_queue
        (       w_queue.id_sin,
                w_queue.id_prod,
                w_queue.id_corb,
                w_queue.nom,
                w_queue.cod_etat,
                w_queue.cod_action,
                w_queue.alt_occupe,
                w_queue.alt_bloc,
                w_queue.trv_cree_le,
                w_queue.trv_maj_le,
                w_queue.trv_maj_par,
                w_queue.txt_mess1,
                w_queue.dos_maj_le,
                w_queue.dos_maj_par,
                w_queue.cod_recu,
                w_queue.cod_i_prov,
                w_queue.dte_recu,
                w_queue.cod_typ_recu,
                w_queue.dte_cour_cli )
 VALUES (       Convert ( Varchar (10), @dcIdSin ),  -- [PI062]
                @dcIdProd,
                Convert ( Varchar (3), @dcIdCorb ),
                @sNom + ' ' + @sPrenom,
                '1',
                '1',
                'N',
                'N',
                @dtCreeLe,
                @dtCreeLe,
                @sCodOper,
                @sTxtMess1,
                @dtCreeLe,
                @sDosMajPar,
                @sCodRecu,
                @sCodIProv,
                @dDteRecu,
                @sCodTypRecu,
                @dDteCourCli )

 Return @@RowCount
GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_D01_W_QUEUE_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libell‚              :        
-- Commentaires         :       Suppression dans la table W_QUEUE
-- R‚f‚rences           :       Utilis‚ dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_W_QUEUE_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_D01_W_QUEUE_WKF
GO

CREATE procedure sysadm.PS_D01_W_QUEUE_WKF
        @dcIdSin        Decimal (  10,0 )  -- [PI062]
AS

Declare @sIdSin         Varchar ( 10 )  -- [PI062]

Select @sIdSin = Convert ( Varchar (10), @dcIdSin )  -- [PI062]

 DELETE FROM    sysadm.w_queue
 WHERE          w_queue.id_sin          = @sIdSin        AND
                w_queue.alt_occupe      = 'N'

 Return @@RowCount

GO 

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_U01_W_QUEUE_WKF
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libell‚              :        
-- Commentaires         :       Modification dans la table W_QUEUE
-- R‚f‚rences           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdCorb       Decimal (  3,0 ),       (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[PS_U01_W_QUEUE_WKF]') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[PS_U01_W_QUEUE_WKF]
GO



CREATE procedure [sysadm].[PS_U01_W_QUEUE_WKF]
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdCorb       Decimal (  3,0 ),
        @sDosMajPar     Varchar (  4   )
AS

 -- En consultation, la cr‚ation d'un travail sur un
 -- travail d‚j… existant, ne doit par faire disparaŒtre
 -- le dos_maj_par pr‚sent.
 -- On repère cela par le code CREE.
 -- [PM283-1] FS le 01/12/2014 [PM283-1] Ne pas écraser un travail RBA
 -- [VDOC19880] FS le 08/02/2016 Ne pas écraser un travail ged par IMGA
 
Declare @sDosMajParInit Varchar(4) 	 
  
Select @sDosMajParInit = dos_maj_par  From   sysadm.w_queue where  id_sin = Convert ( Varchar (10), @dcIdSin ) -- [PI062]
--> [PM283-1] :Reprise du trigramme initial si RBA#
	If @sDosMajParInit in ( 'RBA#' ) Set @sDosMajPar =  @sDosMajParInit
		
--> [VDOC19880]  : Si IMGA on conserve le trigramme d'affectation d'origine
	If @sDosMajPar in ( 'IMGA' ) Set @sDosMajPar =  @sDosMajParInit

	   
 If @sDosMajPar = 'CREE'
    Select @sDosMajPar = dos_maj_par
    From   sysadm.w_queue
    where  id_sin = Convert ( Varchar (10), @dcIdSin ) -- [PI062]
 
 UPDATE         sysadm.w_queue
 SET            sysadm.w_queue.id_corb         = Convert ( Varchar (3), @dcIdCorb ),
                sysadm.w_queue.cod_etat        = '1',
                sysadm.w_queue.cod_action      = '1',
                sysadm.w_queue.alt_occupe      = 'N',
                sysadm.w_queue.alt_bloc        = 'N',
                sysadm.w_queue.dos_maj_par     = @sDosMajPar
 WHERE          w_queue.id_sin          = Convert ( Varchar (10),@dcIdSin ) AND  -- [PI062]
                w_queue.alt_occupe      = 'N'

--select 'La maj vers ', @sDosMajPar, 'est faite'

 Return @@RowCount

GO

grant execute on sysadm.PS_U01_W_QUEUE_WKF to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_U02_W_QUEUE_WKF
-- Auteur               :       DBI
-- Date                 :       03/11/98 11:27:57
-- Libell‚              :        
-- Commentaires         :       Mise … jour de W_queue lors de l'‚dition
-- R‚f‚rences           :       
--
-- Arguments            :       @sIdSin         varchar (  6   )        (Val)
--                      :       @sCodOper       varchar (  4   )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U02_W_QUEUE_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_U02_W_QUEUE_WKF
GO

CREATE procedure sysadm.PS_U02_W_QUEUE_WKF
        @sIdSin         varchar (  10   ), -- [PI062]
        @sCodOper       Varchar (  4   )
AS
 UPDATE     sysadm.w_queue
 SET        sysadm.w_queue.cod_etat      = '5', 
            sysadm.w_queue.cod_action    = '1', 
            sysadm.w_queue.trv_edite_le  = getdate(), 
            sysadm.w_queue.trv_edite_par = @sCodOper
 WHERE      w_queue.id_sin        = @sIdSin

 Return @@RowCount

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_VAL_W_QUEUE
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libell‚              :        
-- Commentaires         :       Insertion dans la table W_QUEUE
-- R‚f‚rences           :       Utilis‚ dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sType          Varchar (  3 )          (Val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_VAL_W_QUEUE' AND type = 'P' )
        DROP procedure sysadm.PS_VAL_W_QUEUE
GO

CREATE procedure sysadm.PS_VAL_W_QUEUE
        @sCodTypRecu            Varchar (  1   ),
        @sCodRecu               Varchar (  1   ),
        @dtDteCourCli           DateTime        ,
        @dtDteRecu              DateTime        ,
        @dcIdSin                Decimal (  10,0 ), -- [PI062]
        @dcIdI                  Decimal (  7,0 ),
        @sCodIProv              Varchar (  1   ),
        @dcIdProd               Decimal (  7,0 ),
        @dcIdEts                Decimal (  7,0 ),
        @sIdAdh                 Varchar ( 19   ),
        @dcIdsDos               Decimal (  2,0 ),
        @dcOption               Decimal (  2,0 ),
        @dtDteAdh               DateTime        ,
        @dtDteFinGti            DateTime        ,
        @dtDteResil             DateTime        ,
        @dcIdCorb               Decimal (  3,0 ),
        @dtDteDecl              DateTime        ,
        @dtDteSurv              DateTime        ,
        @sCodCiv                Varchar (  1   ),
        @sNom                   Varchar ( 35   ),
        @sPrenom                Varchar ( 35   ),
        @sAdr1                  Varchar ( 35   ),
        @sAdr2                  Varchar ( 35   ),
        @sAdrCp                 Varchar (  5   ),
        @sAdrVille              Varchar ( 35   ),
        @sNumTelD               Varchar ( 20   ),
        @sNumTelB               Varchar ( 20   ),
        @sNumFax                Varchar ( 20   ),
        @sTxtMess1              Varchar ( 254  ),
        
        @dtCreeLe               DateTime        ,
        @dtMajLe                DateTime        ,
        @sCodOper               Varchar (  4   ),
        @sCodTravail            Varchar (  3   ),
        @sAltQueue              Varchar (  1   ),

        @dtDteSous              DateTime        ,
        @dtDteOpt               DateTime        ,
        @dcIdCarte              Decimal (  7,0 ),
        @sIdTypeCarte           Varchar (  3   ),
        @dcIdPersonne           Decimal (  7,0 ),
        @sCodProvPers           Varchar (  1   ),

        @sCodModeRegA           Varchar (  2   ),
        @sRibBq                 Varchar (  5   ),
        @sRibGui                Varchar (  5   ),
        @sRibCpt                Varchar ( 11   ),
        @sRibCle                Varchar (  2   ),

        @sAltCreBqDms           Varchar (  1   ),
        @sCodBq_B               Varchar (  5   ),
        @sCodAg_B               Varchar (  5   ),
        @sNom_B                 Varchar ( 35   ),
        @sAdr1_B                Varchar ( 35   ),
        @sAdr2_B                Varchar ( 35   ),
        @sAdrCp_B               Varchar (  5   ),
        @sAdrVille_B            Varchar ( 35   ),
        @sCodModeRegB           Varchar (  2   ),
        @sNumTelD_B             Varchar ( 20   ),
        @sDosMajPar             Varchar ( 4    ),

        @sNumPort               Varchar ( 25   ),
        @sNumImeiPort           Varchar ( 25   ),
        @sMarqPort              Varchar ( 35   ),
        @sModlPort              Varchar ( 35   ),
        @dtAchPort              DateTime        ,
        @dtOuvLigPort           DateTime        ,
        
        @sIdContratAbonne       Varchar ( 20   ),
        @lIdOrianHlr            Integer         ,
        @lIdOrianMarque         Integer         ,
        @lIdOrianModele         Integer         ,
        @lIdOrianBoutique       Integer         ,

        @sProc                  Varchar ( 60   ) OUTPUT,
        @sIdSin                 Varchar (  10  ) OUTPUT  -- [PI062]
AS

Declare @iRet           Integer

If      @sCodTypRecu = 'C' And @sAltQueue = 'N' And 
        ( @sCodTravail = 'CPL' )
   
        Begin
        /* ... Cr‚ation dans la table W_QUEUE ... */
                Select @sProc = 'Creation W_QUEUE (CPL)'

                EXEC @iRet = sysadm.PS_I01_W_QUEUE_WKF
                             @dcIdSin, @dcIdProd, @dcIdCorb, @sNom, @sPrenom,                             @dtCreeLe, @sTxtMess1, @sCodRecu, @sCodIProv,
                             @dtDteRecu, @sCodTypRecu, @dtDteCourCli, @sCodOper, @sDosMajPar
                If @iRet <> 1 Return @iRet


        /* ... Mise … jour dans la table ROUTAGE ...*/
                Select @sProc = 'Modification dans ROUTAGE (CPL)'
                EXEC @iRet = sysadm.PS_U01_ROUTAGE_WKF
                             @dcIdSin, @dcIdCorb, 'CPL', @dtCreeLe, @sCodOper
                If @iRet <> 1 Return @iRet

        /* ... Mise … jour dans la table W_SIN (DTE_FIN_GTI) ...*/
                Select @sProc = 'Modification dans W_SIN (DTE_FIN_GTI) (CPL)'
                EXEC @iRet = sysadm.PS_U01_W_SIN_WKF
                             @dcIdSin, @dtDteFinGti
                If @iRet <> 1 Return @iRet


        Select @sProc = ''
        
        End

If      @sCodTypRecu = 'C' And @sAltQueue = 'O' And
        ( @sCodTravail = 'CPL' Or @sCodTravail = 'DEC' )

        Begin
        /* ... Mise … jour dans la table W_QUEUE ...*/
                Select @sProc = 'Modification la table W_QUEUE (CPL/DEC)'

                EXEC @iRet = sysadm.PS_U01_W_QUEUE_WKF @dcIdSin, @dcIdCorb, @sDosMajPar
                If @iRet <> 1 Return @iRet


        /* ... Mise … jour dans la table ROUTAGE ...*/
                Select @sProc = 'Modification dans ROUTAGE (CPL/DEC)'
                EXEC @iRet = sysadm.PS_U01_ROUTAGE_WKF
                             @dcIdSin, @dcIdCorb, @sCodTravail, @dtCreeLe, @sCodOper
                If @iRet <> 1 Return @iRet

        /* ... Mise … jour dans la table W_SIN (DTE_FIN_GTI) ...*/
                Select @sProc = 'Modification dans W_SIN (DTE_FIN_GTI) (CPL)'
                EXEC @iRet = sysadm.PS_U01_W_SIN_WKF
                             @dcIdSin, @dtDteFinGti
                If @iRet <> 1 Return @iRet


        Select @sProc = ''

        End


If      @sCodTypRecu = 'C' And @sCodTravail = 'CAS'

        Begin
        /* ... Cr‚ation dans la table W_QUEUE ... */
                Select @sProc = 'Creation W_QUEUE (CPL)'

                EXEC @iRet = sysadm.PS_I01_W_QUEUE_WKF
                             @dcIdSin, @dcIdProd, @dcIdCorb, @sNom, @sPrenom,
                             @dtCreeLe, @sTxtMess1, @sCodRecu, @sCodIProv,
                             @dtDteRecu, @sCodTypRecu, @dtDteCourCli, @sCodOper, @sDosMajPar
                If @iRet <> 1 Return @iRet


        /* ... Mise … jour dans la table ROUTAGE ...*/
                Select @sProc = 'Modification dans ROUTAGE (CPL)'
                EXEC @iRet = sysadm.PS_U01_ROUTAGE_WKF
                             @dcIdSin, @dcIdCorb, 'CPL', @dtCreeLe, @sCodOper
                If @iRet <> 1 Return @iRet


        /* ... Rapatriement de la table SINISTRE dans W_SIN ...*/
                Select @sProc = 'Rapatriement dans la table W_SIN (CPL)'
                EXEC @iRet = sysadm.PS_I01_W_SIN_WKF @dcIdSin
                If @iRet <> 1 Return @iRet

        /* ... Rapatriement de la table DIV_SIN dans W_DIV_SIN ...*/
                Select @sProc = 'Rapatriement dans la table W_DIV_SIN (CPL)'
                EXEC @iRet = sysadm.PS_I01_W_DIV_SIN_WKF @dcIdSin
                If @iRet <> 0 Return @iRet

        /* ... Rapatriement de la table INTERLOCUTEUR dans W_INTER ...*/
                Select @sProc = 'Rapatriement dans la table W_INTER (CPL)'
                EXEC @iRet = sysadm.PS_I01_W_INTER_WKF @dcIdSin
                If @iRet <> 0 Return @iRet


        /* ... Rapatriement de la table FRAIS dans W_FRAIS ...*/
                Select @sProc = 'Rapatriement dans la table W_FRAIS (CPL)'
                EXEC @iRet = sysadm.PS_I01_W_FRAIS_WKF @dcIdSin
                If @iRet <> 0 Return @iRet


        /* ... Rapatriement de la table GAR_SIN dans W_GAR_SIN ...*/
                Select @sProc = 'Rapatriement dans la table W_GAR_SIN (CPL)'
                EXEC @iRet = sysadm.PS_I01_W_GTI_WKF @dcIdSin
                If @iRet <> 0 Return @iRet


        /* ... Rapatriement de la table DETAIL dans W_DETAIL ...*/
                Select @sProc = 'Rapatriement dans la table W_DETAIL (CPL)'
                EXEC @iRet = sysadm.PS_I01_W_DETAIL_WKF @dcIdSin
                If @iRet <> 0 Return @iRet

        /* ... Rapatriement de la table DIV_DET dans W_DIV_DET ...*/ -- #1 [FNAC_PROD_ECH_TECH]
                Select @sProc = 'Rapatriement dans la table W_DIV_DET (CPL)'
                EXEC @iRet = sysadm.PS_I01_W_DIV_DET_WKF @dcIdSin
                If @iRet <> 0 Return @iRet


        /* ... Rapatriement de la table COMMANDE dans W_COMMANDE ...*/
                Select @sProc = 'Rapatriement dans la table W_COMMANDE (CPL)'
                EXEC @iRet = sysadm.PS_I01_W_COMMANDE_WKF @dcIdSin
                If @iRet <> 0 Return @iRet


        /* ... Rapatriement de la table REFUS dans W_REFUS ...*/
                Select @sProc = 'Rapatriement dans la table W_REFUS (CPL)'
                EXEC @iRet = sysadm.PS_I01_W_REFUS_WKF @dcIdSin, @dcIdProd
                If @iRet <> 0 Return @iRet

        /* ... Mise … jour dans la table W_SIN (DTE_FIN_GTI) ...*/
                Select @sProc = 'Modification dans W_SIN (DTE_FIN_GTI) (CPL)'
                EXEC @iRet = sysadm.PS_U01_W_SIN_WKF
                             @dcIdSin, @dtDteFinGti
                If @iRet <> 1 Return @iRet


        Select @sProc = ''

        End

If      @sCodTypRecu = 'D'

        Begin
        /* ... D‚termination du Nø de r‚f‚rence sinistre ...*/
                Select @sProc = 'Incrementation de ID_SIN (DEC)'
                EXEC @iRet = sysadm.PS_X_INCREMENTER 'ID_SIN', @dcIdSin OUTPUT
                If @iRet = -1 Return @iRet

        /* ... Cr‚ation dans la table W_QUEUE ... */
                Select @sProc = 'Creation W_QUEUE (DEC)'
                EXEC @iRet = sysadm.PS_I01_W_QUEUE_WKF
                             @dcIdSin, @dcIdProd, @dcIdCorb, @sNom, @sPrenom,
                             @dtCreeLe, @sTxtMess1, @sCodRecu, @sCodIProv,
                             @dtDteRecu, @sCodTypRecu, @dtDteCourCli, @sCodOper, @sDosMajPar
                If @iRet <> 1 Return @iRet


        /* ... Cr‚ation dans la table ROUTAGE ...*/
                Select @sProc = 'Insertion dans ROUTAGE (DEC)'
                EXEC @iRet = sysadm.PS_I01_ROUTAGE_WKF
                             @dcIdSin, @dcIdCorb, 'DEC', @dtCreeLe
                If @iRet <> 1 Return @iRet


        /* ... Cr‚ation dans la table W_SIN ...*/
                Select @sProc = 'Creation dans la table W_SIN (DEC)'
                EXEC @iRet = sysadm.PS_I02_W_SIN_WKF
                             @dcIdSin, @dcIdProd, @dcIdEts, @sIdAdh, @dcIdsDos,
                             @sCodRecu, @sCodIProv, @dtDteDecl, @dtDteSurv,
                             @dtDteAdh, @dtDteSous, @dtDteOpt, @dcOption,
                             @dtDteResil, @dtDteFinGti, @sCodCiv, @sNom,
                             @sPrenom, @sAdr1, @sAdr2, @sAdrCp, @sAdrVille,
                             @sNumFax, @sNumTelB, @sNumTelD, @sTxtMess1, 
                             @dcIdCarte, @sIdTypeCarte, @dcIdPersonne, 
                             @sCodProvPers, @dtCreeLe, @dtMajLe, @sCodOper, 
                             @sNumPort, @sNumImeiPort, @sMarqPort, @sModlPort, 
                             @dtAchPort, @dtOuvLigPort, @sIdContratAbonne, @lIdOrianHlr, 
                             @lIdOrianMarque, @lIdOrianModele, @lIdOrianBoutique
                If @iRet <> 1 Return @iRet

        /* ... Cr‚ation dans la table W_INTER (ASSURE)...*/
                Select @sProc = 'Creation dans la table W_INTER - ASSURE (DEC)'
                EXEC @iRet = sysadm.PS_I02_W_INTER_WKF
                             @dcIdSin, @sCodCiv, @sNom, @sPrenom, @sAdr1,
                             @sAdr2, @sAdrCp, @sAdrVille, @sCodModeRegA,
           @sNumTelD, @sNumTelB, @sNumFax, @sRibBq, @sRibGui,
                             @sRibCpt, @sRibCle, @dtCreeLe, @dtMajLe, @sCodOper
                If @iRet <> 1 Return @iRet

        /* ... Cr‚ation dans la table W_INTER (BANQUE)...*/
                If      @sAltCreBqDms = 'O'

                        Begin

                                Select @sProc = 'Creation dans la table W_INTER - BANQUE (DEC)'
                                EXEC @iRet = sysadm.PS_I03_W_INTER_WKF
                                             @dcIdSin, @sNom_B, @sAdr1_B, @sAdr2_B, @sAdrCp_B,
                                             @sAdrVille_B, @sNumTelD_B, @sCodModeRegB, @sCodBq_B, 
                                             @sCodAg_B, @dtCreeLe, @dtMajLe, @sCodOper
                                If @iRet <> 1 Return @iRet
                        End

        /* ... Cr‚ation dans la table W_INTER (CAS PARTICULIER)...*/
        /* DCMP 010285 MH Patry, cr‚ation d'un inter par d‚faut...*/
                Select @sProc = 'Creation dans la table W_INTER - CAS PART INTER DEFAUT (DEC)'
                EXEC @iRet = sysadm.PS_I04_W_INTER_WKF
                             @dcIdSin, @dcIdProd, @dtCreeLe, @dtMajLe, @sCodOper
                If @iRet <> 1 Return @iRet


        Select @sProc  = ''
--Migration PB4 PB8 WYNIWYG 03/2006
--        Select @sIdSin = Convert ( Varchar(6), @dcIdSin )
        Select @sIdSin = Convert ( Varchar(10), @dcIdSin ) -- [PI062]
--Fin Migration PB4 PB8 WYNIWYG 03/2006

        End
      
GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_W_QUEUE_WKF
-- Auteur               :       JFF
-- Date                 :       14/12/98 16:55:00
-- Libell‚              :        
-- Commentaires         :       Rapatriement des infos d‚finissant le travail
-- R‚f‚rences           :       Utilis‚ sur W_CM_SP_SINISTRE (Consultation, onglet INSTRUCTION ) 
--
-- Arguments            :       @sIdSin        VarChar ( 6 )        (Val)
--                      :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_QUEUE_WKF' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_QUEUE_WKF
GO

CREATE procedure sysadm.DW_S01_W_QUEUE_WKF
  @sIdSin   VarChar ( 10 ) -- [PI062]
As
 SELECT 
  id_sin,
  id_corb,
  id_prod,
  nom,
  cod_etat,
  cod_action,
  alt_occupe,
  alt_bloc,
  trv_cree_le,
  trv_maj_le,
  trv_maj_par,
  trv_route_le,
  trv_route_par,
  trv_edite_le,
  trv_edite_par,
  txt_mess1,
  txt_mess2,
  dos_maj_le,
  dos_maj_par, 
  cod_recu, 
  cod_i_prov, 
  dte_recu,
  cod_typ_recu,
  dte_cour_cli
 FROM
  sysadm.w_queue
 WHERE 
  sysadm.w_queue.id_sin = @sIdSin

GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       IM_U04_W_QUEUE_CAS1
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libell‚              :        
-- Commentaires         :       Passage de ALT_OCCUPE … NON
-- R‚f‚rences           :       
--
-- Arguments            :       @dtTrvMajLe     DateTime                        (Val)
--                      :       @sTrvMajPar     Varchar (  4 )                  (Val)
--                      :       @sIdSin         Varchar (  6 )                  (Val)
--                      :       @sIdCorb        Varchar (  3 )                  (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_U04_W_QUEUE_CAS1' AND type = 'P' )
        DROP procedure sysadm.IM_U04_W_QUEUE_CAS1
GO

CREATE procedure sysadm.IM_U04_W_QUEUE_CAS1
        @dtTrvMajLe     DateTime      ,
        @sTrvMajPar     VarChar (  4 ),
        @sIdSin         VarChar ( 10 ),  -- [PI062]
        @sIdCorb        VarChar (  3 )
AS
 UPDATE sysadm.w_queue
    SET sysadm.w_queue.alt_occupe      = 'N',
        sysadm.w_queue.trv_maj_le      = @dtTrvMajLe,
        sysadm.w_queue.trv_maj_par     = @sTrvMajPar 
 WHERE  w_queue.id_sin          = @sIdSin               AND
        w_queue.id_corb         = @sIdCorb              AND
        w_queue.alt_occupe      = 'O'

GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S02_W_QUEUE_POCHETTE
-- Auteur               :       Fabry JF
-- Date                 :       27/09/99 
-- Libell‚              :       Faut-il cr‚er une pochette … l'ouverture du compl‚ment ? 
-- Commentaires         :       Oui si la d‚claration … l'origine ‚tait par Tel, et qu'un
--				questionnaire avait ‚t‚ envoy‚.
-- 				Cas 'TRAVAIL' : Cr‚ation d'un travail en Compl‚ment
-- 				Cas 'ENCOURS' : Saisie du sinistre en cours d'instruction
-- 				Cas 'CONSULT' : Consultation
-- R‚f‚rences           :       
--
-- Arguments            :       @dcIdSin 	Decimal ( 7,0 )		(Val)
--				@sCas		VarChar ( 10  )	 	(Val)
--				@sPochette	Decimal ( 1   ) 	(R‚f)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
If exists (select * from sysobjects where id = object_id('sysadm.PS_S02_W_QUEUE_POCHETTE') and sysstat & 0xf = 4)
	drop procedure sysadm.PS_S02_W_QUEUE_POCHETTE
GO


CREATE PROC sysadm.PS_S02_W_QUEUE_POCHETTE
  @dcIdSin 	Decimal ( 10,0 ), -- [PI062]
  @sCas		VarChar ( 10  ),
  @dcPochette	Decimal ( 1   ) OUTPUT

AS

Select @dcPochette = -1
Select @sCas       = Upper ( @sCas )



If @sCas = 'TRAVAIL' 

   Begin

     If ( Select count( arch.id_sin )
          From   sysadm.archive arch
          Where  arch.id_sin = @dcIdSin ) = 1

       Begin
	  Select @dcPochette = 1

	  From 	 sysadm.sinistre sin,
		 sysadm.archive  arch,
		 sysadm.routage  rou


	  Where  sin.id_sin 	= @dcIdSin
 	  And	 rou.id_sin	= sin.id_sin
	  And 	 rou.alt_queue	= 'N'
	  And	 sin.cod_decl	= 'T'
	  And	 arch.id_sin	= sin.id_sin
	  And	 SubString ( arch.id_cour, 1, 1 ) = 'Q'
       End

   End


If @sCas = 'ENCOURS'

   Begin

      If ( Select count( arch.id_sin )
           From   sysadm.archive arch
           Where  arch.id_sin = @dcIdSin ) = 1 

        Begin

	  Select @dcPochette = 1

	  From 	 sysadm.sinistre sin,
		 sysadm.archive  arch


	  Where  sin.id_sin 	= @dcIdSin
	  And	 sin.cod_decl	= 'T'
	  And	 arch.id_sin	= sin.id_sin
	  And	 SubString ( arch.id_cour, 1, 1 ) = 'Q'
        
        End 

   End  



If @sCas = 'CONSULT'

   Begin
      If ( Select count( sin.id_sin )
           From   sysadm.sinistre sin
           Where  sin.id_sin = @dcIdSin ) = 0 

        Begin

	  Select @dcPochette = 2

	  From 	 sysadm.w_queue  wqu,
		 sysadm.w_inter  wint

	  Where  wqu.id_sin     = Convert ( VarChar ( 10 ), @dcIdSin ) -- [PI062]
	  And	 wqu.cod_recu   = 'T'
 	  And    wint.id_sin    = @dcIdSin
	  And	 wint.alt_quest = 'O'

        End


      Else If ( Select count ( arch.id_sin )
                From   sysadm.archive arch
                Where  arch.id_sin = @dcIdSin ) = 1 

             Begin           

                If ( Select rou.alt_queue
                     From   sysadm.routage rou
                     Where  rou.id_sin = @dcIdSin ) = 'N'


      	           Begin

	             Select @dcPochette = 2

	             From sysadm.sinistre sin,
		          sysadm.archive  arch

	             Where  sin.id_sin 	= @dcIdSin
	             And	 sin.cod_decl	= 'T'
	             And	 arch.id_sin	= sin.id_sin
	             And	 SubString ( arch.id_cour, 1, 1 ) = 'Q'

                   End

                Else

           	   Begin

	              Select @dcPochette = 1

	              From sysadm.sinistre sin,
		           sysadm.archive  arch

	              Where  sin.id_sin	  = @dcIdSin
	              And    sin.cod_decl = 'T'
	              And    arch.id_sin  = sin.id_sin
 	              And    SubString ( arch.id_cour, 1, 1 ) = 'Q'

		   End
             End

    End
GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S02_W_QUEUE_WKF
-- Auteur               :       Fabry JF
-- Date                 :       19/09/2002 
-- Libell‚              :       Fenˆtres de consultation via excel de tous les travaux
-- Commentaires         :       
--				
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- FPI - 06/10/2014 V01 - VDoc18467 - ajout du site
-------------------------------------------------------------------
If exists (select * from sysobjects where id = object_id('sysadm.DW_S02_W_QUEUE_WKF_V01') and sysstat & 0xf = 4)
	drop procedure sysadm.DW_S02_W_QUEUE_WKF_V01
GO

CREATE PROC sysadm.DW_S02_W_QUEUE_WKF_V01

AS

If master.dbo.SPB_FN_TYPEBASE( db_id() ) = 'PRO'
Begin		
	Select 
		w.id_sin Ref_Sin,
		w.id_corb Corbeille,
		sysadm.FN_CODE_NUM(Convert ( decimal (7,0), w.id_corb ), '-CO') Lib_Corbeille ,
		p.id_dept Departement, 
		p.id_depts Sous_Departement, 
		Case 
		 When p.cod_tel = 0 Then 'Produit NON Telephonie'
		 Else 'Produit de Telephonie'
		End Telephonie_ou_pas,
		w.id_prod Code_Produit,
		p.lib_long Produit,
		w.nom Nom_Assure,
		sysadm.FN_CODE_CAR( w.cod_etat, '-CE') as Etat_Travail,
		CONVERT(char(11), w.trv_cree_le, 103) + CONVERT(char(8), w.trv_cree_le, 108) Travail_Cree_Le,
		CONVERT(char(11), w.trv_maj_le, 103) + CONVERT(char(8),	w.trv_maj_le, 108) Travail_Maj_Le,
		w.trv_maj_par Travail_Maj_Par,
		CONVERT(char(11), w.trv_route_le, 103) + CONVERT(char(8), w.trv_route_le, 108) Travail_Route_Le,
		w.trv_route_par Travail_Route_Par,
		CONVERT(char(11), w.trv_edite_le, 103) + CONVERT(char(8), w.trv_edite_le, 108) Dossier_Edite_Le,	
		w.trv_edite_par Dossier_Edite_Par,
		CONVERT(char(11), w.dos_maj_le, 103) + CONVERT(char(8), w.dos_maj_le, 108) Dossier_Maj_Le,	
		w.dos_maj_par Dossier_Maj_Par,
		sysadm.FN_CODE_CAR(w.cod_recu,'-CR') Recu_par ,
		sysadm.FN_CODE_CAR(w.cod_i_prov, '-IN') Venant_De ,
		CONVERT(char(11), w.dte_recu, 103) + CONVERT(char(8), w.dte_recu, 108) Date_Reception,	
		sysadm.FN_CODE_CAR(w.cod_typ_recu, '-CT') Type_ouverture ,
		CONVERT(char(11), w.dte_cour_cli, 103) + CONVERT(char(8), w.dte_cour_cli, 108) Date_courrier_client	,
		IsNull(CodeOFF.lib_code,'Inconnu') as Site

	from 	sysadm.w_queue w
		inner join sysadm.produit p  on p.id_prod = w.id_prod
		left outer join SESAME_PRO.sysadm.equipe_oper e on 	e.id_oper=w.trv_maj_par
		left outer join SESAME_PRO.sysadm.code CodeOFF on CodeOFF.id_code=e.id_office
			and CodeOFF.id_typ_code='-OF'
	order by w.id_corb asc, w.id_prod asc , Etat_Travail asc, w.trv_cree_le asc
End
Else
Begin
	Select 
		w.id_sin Ref_Sin,
		w.id_corb Corbeille,
		sysadm.FN_CODE_NUM(Convert ( decimal (7,0), w.id_corb ), '-CO') Lib_Corbeille ,
		p.id_dept Departement, 
		p.id_depts Sous_Departement, 
		Case 
		 When p.cod_tel = 0 Then 'Produit NON Telephonie'
		 Else 'Produit de Telephonie'
		End Telephonie_ou_pas,
		w.id_prod Code_Produit,
		p.lib_long Produit,
		w.nom Nom_Assure,
		sysadm.FN_CODE_CAR( w.cod_etat, '-CE') as Etat_Travail,
		CONVERT(char(11), w.trv_cree_le, 103) + CONVERT(char(8), w.trv_cree_le, 108) Travail_Cree_Le,
		CONVERT(char(11), w.trv_maj_le, 103) + CONVERT(char(8),	w.trv_maj_le, 108) Travail_Maj_Le,
		w.trv_maj_par Travail_Maj_Par,
		CONVERT(char(11), w.trv_route_le, 103) + CONVERT(char(8), w.trv_route_le, 108) Travail_Route_Le,
		w.trv_route_par Travail_Route_Par,
		CONVERT(char(11), w.trv_edite_le, 103) + CONVERT(char(8), w.trv_edite_le, 108) Dossier_Edite_Le,	
		w.trv_edite_par Dossier_Edite_Par,
		CONVERT(char(11), w.dos_maj_le, 103) + CONVERT(char(8), w.dos_maj_le, 108) Dossier_Maj_Le,	
		w.dos_maj_par Dossier_Maj_Par,
		sysadm.FN_CODE_CAR(w.cod_recu,'-CR') Recu_par ,
		sysadm.FN_CODE_CAR(w.cod_i_prov, '-IN') Venant_De ,
		CONVERT(char(11), w.dte_recu, 103) + CONVERT(char(8), w.dte_recu, 108) Date_Reception,	
		sysadm.FN_CODE_CAR(w.cod_typ_recu, '-CT') Type_ouverture ,
		CONVERT(char(11), w.dte_cour_cli, 103) + CONVERT(char(8), w.dte_cour_cli, 108) Date_courrier_client	,
		IsNull(CodeOFF.lib_code,'Inconnu') as Site

	from 	sysadm.w_queue w
		inner join sysadm.produit p  on p.id_prod = w.id_prod
		left outer join SESAME_SIM.sysadm.equipe_oper e on 	e.id_oper=w.trv_maj_par
		left outer join SESAME_SIM.sysadm.code CodeOFF on CodeOFF.id_code=e.id_office
			and CodeOFF.id_typ_code='-OF'
	order by w.id_corb asc, w.id_prod asc , Etat_Travail asc, w.trv_cree_le asc
End

Go

grant execute on sysadm.DW_S02_W_QUEUE_WKF_V01 to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S01_W_QUEUE_TRACE_SOLDE_WKF
-- Auteur               :       PHG
-- Date                 :       23/03/2006 16:33:00
-- Libell‚              :        
-- Commentaires         :       requete du solde des travaux
-- R‚f‚rences           :       DCMP 060260 : Utilise par PS_S02_W_QUEUE_TRACE_SOLDE_WKF
--
-- Arguments            :       Rien
--                      :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- [VDOC15394] FS le 24/09/2014 : ajout de la colonne w_queue.dos_maj_par
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_W_QUEUE_TRACE_SOLDE_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_S01_W_QUEUE_TRACE_SOLDE_WKF
GO

CREATE procedure [sysadm].[PS_S01_W_QUEUE_TRACE_SOLDE_WKF]
As
DECLARE @dtDateSysteme DateTime,
	@sDatesyschar varchar(23)

SET @dtDateSysteme = GetDate()
SET @sDatesyschar =  Convert(Varchar(10),@dtDateSysteme, 103)+' '+ Convert(Varchar(12),@dtDateSysteme, 114)

SELECT 	@sDatesyschar,
	'SIM8',
	'XXXXXXXXXX',
	'SQL',
	CAST(produit.id_dept AS int),
	RTRIM(CAST(w_queue.id_corb AS varchar(3) )),
	w_queue.cod_etat,
	CAST(w_queue.id_prod AS int ),
	w_queue.cod_typ_recu,
	w_queue.cod_recu,
	w_queue.cod_i_prov,
	Convert ( varchar(10), @dtDateSysteme, 103 ),
	LTRIM(RTRIM(CAST(Count ( w_queue.id_sin )AS varchar(10) ) ) ),
	(
		Convert ( varchar(10),Min ( w_queue.trv_cree_le ), 103 )+' '+Convert ( varchar(12),Min ( w_queue.trv_cree_le ), 114 )
	),
	convert(varchar(10), w_queue.dte_recu    , 103 )+ ' 00:00:00.000',
	convert(varchar(10), w_queue.dte_cour_cli, 103 )+ ' 00:00:00.000',
	w_queue.trv_maj_par,
	w_queue.dos_maj_par -- [VDOC15394]
	
FROM	sysadm.w_queue,
	sysadm.produit
	
WHERE	sysadm.w_queue.id_prod = sysadm.produit.id_prod

GROUP BY
	produit.id_dept,
	w_queue.id_corb,
	w_queue.cod_etat,
	w_queue.id_prod,
	w_queue.cod_typ_recu,
	w_queue.cod_recu,
	w_queue.cod_i_prov,
	w_queue.dte_recu,
	w_queue.dte_cour_cli,
	w_queue.trv_maj_par,
	w_queue.dos_maj_par
GO

grant execute on sysadm.PS_S01_W_QUEUE_TRACE_SOLDE_WKF to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S02_W_QUEUE_TRACE_SOLDE_WKF
-- Auteur               :       PHG
-- Date                 :       23/03/2006
-- Libelle              :        
-- Commentaires         :       Generation journalier d fichier de solde des travaux
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-- format de fichier 	:	\\F4T\SIMPA2\TRACE\TRACE_S\jjmmaaaa.SIM
--		JCA changement repertoire cible (norme UNC)
-------------------------------------------------------------------
--	FPI	16/02/2012	[20120216.FPI] Appel de PS_S03_W_QUEUE_TRACE_SOLDE_WKF
-------------------------------------------------------------------


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_W_QUEUE_TRACE_SOLDE_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_S02_W_QUEUE_TRACE_SOLDE_WKF
GO

CREATE  PROC sysadm.PS_S02_W_QUEUE_TRACE_SOLDE_WKF
AS

DECLARE @dJour       DateTime,
        @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
        @sNomServeur VarChar(255),
        @sTracePath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@sCommande2   VarChar(250),	-- [20120216.FPI] 
        @sFicOut2    VarChar(255)	-- [20120216.FPI] 
        
DECLARE @sRetourErrMail         VarChar(255)

Set @dJour  = GetDate ()
Set @dJour  = DateADD ( Day, -1, @dJour )

Set @sTracePath = master.sysadm.SPB_FN_GET_ROOT()+'SIMPA2\TRACE\TRACE_S\'
Set @sFileName	= CONVERT (char(4), DatePart (year,getdate())  ) +
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(month,getdate()) ),  2 ) +
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(day,getdate())   ),  2 )
Set @sFileExt	= 'SIM'

SET @sFicOut = @sTracePath + @sFileName + '.' + @sFileExt
-- [20120216.FPI] 
SET @sFicOut2 = @sTracePath + @sFileName + '_DETAIL.' + @sFileExt

SET @sNomServeur = @@servername

-- Au cas ou l'on ne veut pas de header et le tab en separateur de fichier
-- /h-1 	=> Pas de Header
-- /s"	" 	=> Separateur Tabulation
Set @sOsqlOption = ' ' + '/h-1 ' + '/s"	"'
-- sinon
-- Set @sOsqlOption = ''

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
Begin
   SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q "' + 
                    'SIMPA2_PRO.sysadm.PS_S01_W_QUEUE_TRACE_SOLDE_WKF ' +
                    '" /o' + @sFicOut + ' -w5000' + @sOsqlOption
		    
   SET @sCommande2 = 'sqlcmd /S' + @sNomServeur + ' /E /Q "' + 
                    'SIMPA2_PRO.sysadm.PS_S03_W_QUEUE_TRACE_SOLDE_WKF ' +
                    '" /o' + @sFicOut2 + ' -w5000' + @sOsqlOption
End		   
Else
Begin
   SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q "' + 
                    'SIMPA2_TRT.sysadm.PS_S01_W_QUEUE_TRACE_SOLDE_WKF ' +
                    '" /o' + @sFicOut + ' -w5000' + @sOsqlOption
		    
   SET @sCommande2 = 'sqlcmd /S' + @sNomServeur + ' /E /Q "' + 
                    'SIMPA2_TRT.sysadm.PS_S03_W_QUEUE_TRACE_SOLDE_WKF ' +
                    '" /o' + @sFicOut2 + ' -w5000' + @sOsqlOption
End

EXEC master.dbo.xp_cmdshell @sCommande, no_output
EXEC master.dbo.xp_cmdshell @sCommande2, no_output -- [20120216.FPI] 


GO

grant execute on sysadm.PS_S02_W_QUEUE_TRACE_SOLDE_WKF to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S03_W_QUEUE_DELAI_RENONCIATION
-- Auteur               :       FABRY JF
-- Date                 :       04/06/2008
-- Libelle              :       Envoi au GT concerné un avertissement lui notifiant le fait que le
--                              délai de renonciation est terminé et qu'il peut de ce fait reprendre l'instruction.
-- Commentaires         :       [3SUISSE].DEL_RENONC
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-- format de fichier 	:
-- JFF/FS	24/02/2014	Modification sur [PM217]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S03_W_QUEUE_DELAI_RENONCIATION' AND type = 'P' )
        DROP procedure sysadm.PS_S03_W_QUEUE_DELAI_RENONCIATION
GO


CREATE procedure sysadm.PS_S03_W_QUEUE_DELAI_RENONCIATION
AS

Declare  @sIdSin VarChar ( 50 )
Declare  @sMajPar VarChar ( 50 )
Declare  @sTrvMajPar VarChar ( 50 )
Declare  @sDosSuiviPar VarChar ( 50 )
Declare  @sLibMajPar VarChar ( 50 )
Declare  @sLibTrvMajPar VarChar ( 50 )
Declare  @sLibDosSuiviPar VarChar ( 50 )
Declare  @sMail VarChar ( 100 )
Declare  @sBody          VarChar ( 2000 )
Declare  @sObjet         VarChar ( 200 )
Declare  @sRetourErr     VARCHAR ( 255 )

DECLARE Curs_DelRenonc CURSOR FOR
Select  Convert ( VarChar ( 10 ), ws.id_sin) 'id_sin', -- [PI062]
	ws.maj_par,
	wq.trv_maj_par,
	r.dos_suivi_par
	/*
	,
	( Select sysadm.FN_TRIM ( prenom ) + ' ' + sysadm.FN_TRIM ( nom ) From SESAME_PRO.sysadm.operateur o where o.id_oper = ws.maj_par ) 'lib_maj_par',
	( Select sysadm.FN_TRIM ( prenom ) + ' ' + sysadm.FN_TRIM ( nom ) From SESAME_PRO.sysadm.operateur o where o.id_oper = wq.trv_maj_par ) 'lib_maj_par',
	( Select sysadm.FN_TRIM ( prenom ) + ' ' + sysadm.FN_TRIM ( nom ) From SESAME_PRO.sysadm.operateur o where o.id_oper = r.dos_suivi_par) 'lib_dos_suivi_par'
	*/
	
From   	sysadm.w_queue wq, 
	sysadm.w_sin ws,
	sysadm.w_gar_sin wg,
	sysadm.delai d,
	sysadm.routage r
Where   wq.dos_maj_par = 'EADR'
and     ws.id_sin = wq.id_sin
and     wg.id_sin = ws.id_sin
and     r.id_sin  = ws.id_sin
and     d.id_prod = ws.id_prod
and     d.id_rev  = ws.id_rev
and     d.id_gti  = wg.id_gti
and     d.id_typ_del = 628
and     ( 
	  ( Getdate() > DateAdd ( Day, d.dur_max, ws.dte_adh ) And unt_del = 'J' ) Or 
	  ( Getdate() > DateAdd ( Month, d.dur_max, ws.dte_adh ) And unt_del = 'M' ) Or 
	  ( Getdate() > DateAdd ( year, d.dur_max, ws.dte_adh ) And unt_del = 'Y' ) 
        )


OPEN Curs_DelRenonc

FETCH NEXT FROM Curs_DelRenonc INTO @sIdSin, @sMajPar, @sTrvMajPar, @sDosSuiviPar /* , @sLibMajPar, @sLibTrvMajPar, @sLibDosSuiviPar */

WHILE @@FETCH_STATUS = 0
BEGIN

		Update	sysadm.w_queue 
		Set		etat_iwd = 1
		From	sysadm.famille f
		Where	f.id_fam = 217
		And		w_queue.id_corb = f.id_code 
		And		w_queue.id_sin = @sIdSin
		And		w_queue.etat_iwd is null

/*
        Set @sObjet = 'SIMPA2_PRO : Délai de renonciation terminé sur dossier ' + IsNull ( @sIdSin, '[Problème, contactez 2205]')
        Set @sBody = 'Bonjour, '
        Set @sBody = @sBody + Char( 10 ) + Char (13)
        Set @sBody = @sBody + Char( 10 ) + Char (13)
        Set @sBody = @sBody + Char( 10 ) + Char (13)
        Set @sBody = @sBody + 'le délai de renonciation sur ce dossier est à présent passé, vous pouvez reprendre votre instruction.'
        Set @sBody = @sBody + Char( 10 ) + Char (13)
        Set @sBody = @sBody + Char( 10 ) + Char (13)
	Set @sBody = @sBody + 'Le dossier est actuellement sous le trigramme virtuel EADR, routez le sur votre trigramme pour reprendre l''instruction, n''instruisez surtout pas sous le trigramme EADR !!' 
        Set @sBody = @sBody + Char( 10 ) + Char (13)
        Set @sBody = @sBody + Char( 10 ) + Char (13)
        Set @sBody = @sBody + Char( 10 ) + Char (13)

        Set @sBody = @sBody + 'Les Gestionnaires concernés par l''instruction de ce dossier étaient : '
        Set @sBody = @sBody + Char( 10 ) + Char (13)
        Set @sBody = @sBody + Char( 10 ) + Char (13)
        Set @sBody = @sBody + Char( 10 ) + Char (13)

	Set @sMail = ''
	If @sMajPar is not null Set @sMail = @sMail  + @sMajPar + '@spb.fr'
	Set @sBody = @sBody + IsNull ( @sLibMajPar, '') + '/' + IsNull ( @sMajPar, '')
        Set @sBody = @sBody + Char( 10 ) + Char (13)
        Set @sBody = @sBody + Char( 10 ) + Char (13)

	If @sTrvMajPar is not null 
	  Begin	
		If @sMail <> '' Set @sMail = @sMail  + ','
		Set @sMail = @sMail  + @sTrvMajPar + '@spb.fr'	
		Set @sBody = @sBody + IsNull ( @sLibTrvMajPar, '')+ '/' + IsNull ( @sTrvMajPar, '') 
	        Set @sBody = @sBody + Char( 10 ) + Char (13)
	        Set @sBody = @sBody + Char( 10 ) + Char (13)
	  End

	If @sDosSuiviPar is not null 
	  Begin	
		If @sMail is not null Set @sMail = @sMail  + ','
		Set @sMail = @sMail  + @sDosSuiviPar + '@spb.fr'	
		Set @sBody = @sBody + IsNull ( @sLibDosSuiviPar, '') + '/' + IsNull ( @sDosSuiviPar, '')	
	        Set @sBody = @sBody + Char( 10 ) + Char (13)
	        Set @sBody = @sBody + Char( 10 ) + Char (13)
	  End

        Exec master.dbo.SPB_PS_MAIL
        @sRetourErr     OUTPUT,
        @sMail,
        @sBody  ,
        @sObjet,
        '',
        null,
        null,
        null,
        null,
        null,
        null
*/

	FETCH NEXT FROM Curs_DelRenonc INTO @sIdSin, @sMajPar, @sTrvMajPar, @sDosSuiviPar /*, @sLibMajPar, @sLibTrvMajPar, @sLibDosSuiviPar */
	
END

CLOSE Curs_DelRenonc
DEALLOCATE Curs_DelRenonc

Go


--  JFF		12/02/2016		[PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_QUEUE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_QUEUE
GO

CREATE procedure sysadm.DW_S01_W_QUEUE
        @sIdSin         VarChar (  10 ), -- [PI062]
        @sIdCorb        VarChar (  3 )
AS
 SELECT w_queue.cod_etat,
        w_queue.alt_bloc,
        w_queue.trv_maj_par,
        w_queue.trv_maj_le
 FROM   sysadm.w_queue
 WHERE  w_queue.id_sin          = @sIdSin       AND
        w_queue.id_corb         = @sIdCorb

GO

--  JFF		12/02/2016		[PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_W_QUEUE' AND type = 'P' )
        DROP procedure sysadm.IM_D01_W_QUEUE
GO

CREATE procedure sysadm.IM_D01_W_QUEUE
        @sIdSin         VarChar (  10 ), -- [PI062]
        @sIdCorb        VarChar (  3 )
AS
 DELETE sysadm.w_queue
 WHERE  w_queue.id_sin          = @sIdSin       AND
        w_queue.id_corb         = @sIdCorb      AND
        w_queue.alt_occupe      = 'O'

GO

--  JFF		12/02/2016		[PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_U01_W_QUEUE' AND type = 'P' )
        DROP procedure sysadm.IM_U01_W_QUEUE
GO

CREATE procedure sysadm.IM_U01_W_QUEUE
        @dtTrvMajLe     DateTime      ,
        @sTrvMajPar     VarChar (  4 ),
        @sIdSin         VarChar (  10 ), -- [PI062]
        @sIdCorb        VarChar (  3 )
AS
 UPDATE sysadm.w_queue
    SET sysadm.w_queue.alt_occupe      = 'O',
        sysadm.w_queue.trv_maj_le      = @dtTrvMajLe,
        sysadm.w_queue.trv_maj_par     = @sTrvMajPar
 WHERE  w_queue.id_sin          = @sIdSin               AND
        w_queue.id_corb         = @sIdCorb              AND
        w_queue.alt_occupe      = 'N'
GO


-- FPI - [PM217_2] - routage IWD
-- JFF      12/02/2016   [PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_U02_W_QUEUE' AND type = 'P' )
        DROP procedure sysadm.IM_U02_W_QUEUE
GO

CREATE procedure [sysadm].[IM_U02_W_QUEUE]
        @sNom           Varchar ( 71 ),
        @sIdCorb        Varchar (  3 ),
        @sCodEtat       Varchar (  1 ),
        @sCodAction     Varchar (  1 ),
        @sAltBloc       Varchar (  1 ),
        @sTxtMess1      Varchar (254 ),
        @dtTrvMajLe     DateTime      ,
        @sTrvMajPar     Varchar (  4 ),
        @dtTrvRouteLe   DateTime      ,
        @sTrvRoutePar   Varchar (  4 ),
        @dtDosMajLe     DateTime      ,
        @sDosMajPar     Varchar (  4 ),
        @dtTrvEditeLe   DateTime      ,
        @sTrvEditePar   Varchar (  4 ),
        @sIdSin         Varchar (  10 ), -- [PI062]
        @sIdCorbAvt     Varchar (  3 )
AS
 UPDATE sysadm.w_queue
    SET sysadm.w_queue.alt_occupe      = 'N'           ,
        sysadm.w_queue.nom             = @sNom         ,
        sysadm.w_queue.id_corb         = @sIdCorb      ,
        sysadm.w_queue.cod_etat        = @sCodEtat     ,
        sysadm.w_queue.cod_action      = @sCodAction   ,
        sysadm.w_queue.alt_bloc        = @sAltBloc     ,
        sysadm.w_queue.txt_mess1       = @sTxtMess1    ,
        sysadm.w_queue.trv_maj_le      = @dtTrvMajLe   ,
        sysadm.w_queue.trv_maj_par     = @sTrvMajPar   ,
        sysadm.w_queue.trv_route_le    = @dtTrvRouteLe ,
        sysadm.w_queue.trv_route_par   = @sTrvRoutePar ,
        sysadm.w_queue.dos_maj_le      = @dtDosMajLe   ,
        sysadm.w_queue.dos_maj_par     = @sDosMajPar   ,
        sysadm.w_queue.trv_edite_le    = @dtTrvEditeLe ,
        sysadm.w_queue.trv_edite_par   = @sTrvEditePar
 WHERE  w_queue.id_sin          = @sIdSin               AND
        w_queue.id_corb         = @sIdCorbAvt           AND
        w_queue.alt_occupe      = 'O'
GO

grant execute on sysadm.IM_U02_W_QUEUE to rolebddsinistres
Go

-- JFF      12/02/2016   [PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_U03_W_QUEUE' AND type = 'P' )
        DROP procedure sysadm.IM_U03_W_QUEUE
GO

CREATE procedure sysadm.IM_U03_W_QUEUE
        @sIdSin         VarChar (  10 ),  -- [PI062]
        @sIdCorb        VarChar (  3 )
AS
 UPDATE sysadm.w_queue
    SET sysadm.w_queue.cod_etat        = '1',
        sysadm.w_queue.cod_action      = '1',
        sysadm.w_queue.trv_edite_le    = null,
        sysadm.w_queue.trv_edite_par   = null
 WHERE  w_queue.id_sin          = @sIdSin       AND
        w_queue.id_corb         = @sIdCorb      AND
        w_queue.alt_occupe      = 'N'

GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S03_W_QUEUE_TRACE_SOLDE_WKF
-- Auteur               :       FPI
-- Date                 :       16/02/2012
-- Libell‚              :        
-- Commentaires         :       requete du solde des travaux détaillé
-- R‚f‚rences           :       [20120216.FPI]
--
-- Arguments            :       Rien
--                      :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S03_W_QUEUE_TRACE_SOLDE_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_S03_W_QUEUE_TRACE_SOLDE_WKF
GO

CREATE procedure sysadm.PS_S03_W_QUEUE_TRACE_SOLDE_WKF
As
DECLARE @dtDateSysteme DateTime,
	@sDatesyschar varchar(23)

SET @dtDateSysteme = GetDate()
SET @sDatesyschar =  Convert(Varchar(10),@dtDateSysteme, 103)+' '+ Convert(Varchar(12),@dtDateSysteme, 114)

SELECT 	w_queue.id_sin, 
	@sDatesyschar,
	'SIM8',
	'XXXXXXXXXX',
	'SQL',
	CAST(produit.id_dept AS int),
	RTRIM(CAST(w_queue.id_corb AS varchar(3) )),
	w_queue.cod_etat,
	CAST(w_queue.id_prod AS int ),
	w_queue.cod_typ_recu,
	w_queue.cod_recu,
	w_queue.cod_i_prov,
	Convert ( varchar(10), @dtDateSysteme, 103 ),
	Convert ( varchar(10), w_queue.trv_cree_le , 103 ) +' '+Convert ( varchar(12),  w_queue.trv_cree_le , 114 ),
	convert(varchar(10), w_queue.dte_recu    , 103 )+ ' 00:00:00.000',
	convert(varchar(10), w_queue.dte_cour_cli, 103 )+ ' 00:00:00.000',
	w_queue.trv_maj_par
	
FROM	sysadm.w_queue,
	sysadm.produit
	
WHERE	sysadm.w_queue.id_prod = sysadm.produit.id_prod

GO



--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S03_W_QUEUE_WKF_V01
-- Auteur               :       FPI
-- Date                 :       26/12/2013
-- Libell‚              :       Fenˆtres de consultation via excel de tous les travaux
-- Commentaires         :       [PM217-2]
--				
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
---------------------------------------------------------------------------
-- [VDOC16313] FS le 29/12/2014 Si opérateur DR alors liste = RDR# et DSA#
-- [VDOC17582] FS le 29/06/2015 Si opérateur DR alors liste + DRSO ( support aux opérations )
-- [VDOC17582] FS le 24/08/2015 Correction DRSO# ( support aux opérations ) en DRS# 
-- [VDOC18435] FS le 01/09/2015 Trigramme UTL seulement pour DSA par pour DR
--  JFF		12/02/2016		[PI062]
-- FPI 		08/11/1016		[PI056]
--  JFF		30/09/2019		[PI097]
---------------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[sysadm].[DW_S03_W_QUEUE_WKF_V01]') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[DW_S03_W_QUEUE_WKF_V01]
GO

CREATE PROCEDURE [sysadm].[DW_S03_W_QUEUE_WKF_V01]
	@adcSin     Decimal(10,0),  -- [PI062]
	@asCodeOper	Varchar(4),
	@asEtape	Varchar(1)
AS

Declare @iPrs integer
Declare @iUtl integer
Declare @iDr  Integer
Declare @Flag_VDOC16313 Integer
Declare @Flag_VDOC17582 Integer
Declare @Flag_No_RSP Integer
Declare @Flag_No_DRE Integer
Declare @sCmdFfm varchar(2000)

Set @Flag_VDOC16313 = 0
Set @Flag_VDOC17582 = 0

Declare @ListeRech Table
(   tri         integer  not null,
	trigramme   Varchar (4)  not null,
	nom         Varchar(35) not null,
	prenom      Varchar(35) not null
)

Set nocount on

-- Lecture du droit : Rôle de Facturation (DNT)
	Select @iPrs = COUNT(*) from sysadm.autorisation where id_oper = @asCodeOper and id_nat_oper = 213 and val_car is null

-- Lecture du droit : Membre du DR à partir de Sherpa

	Set @iDr = 0
	
	If master.dbo.SPB_FN_TYPEBASE( db_id() ) = 'PRO'
	Begin
	Select @iDr = COUNT(*) From SHERPA_PRO.sysadm.autorisation where id_nat_oper in ( 300,305,310 ) and id_oper = @asCodeOper
	End

	If master.dbo.SPB_FN_TYPEBASE( db_id() ) = 'SIM'
	Begin
	Select @iDr = COUNT(*) From SHERPA_SIM.sysadm.autorisation where id_nat_oper in ( 300,305,310 ) and id_oper = @asCodeOper
	End

-- [VDOC16313] Si opérateur DR alors liste = RDR# et DSA#

	Set @Flag_No_RSP = 0
	Set @Flag_No_DRE = 0


	Set @Flag_VDOC16313 = 1
	If @iDr > 0 Set @Flag_No_RSP = 1
	If @iDr > 0 Set @Flag_No_DRE = 1
	
	
-- [VDOC17582] Si opérateur DR alors liste = DRSO : Réclamation support opération

	Set @Flag_VDOC17582 = 1

-- Lecture du tag : Produit utilities
	Select 
		@iUtl= COUNT(*)
	From
		sysadm.sinistre s 
		inner join sysadm.det_pro dp on dp.id_prod = s.id_prod
	Where
		dp.id_code_dp     = 94   
		And sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( dp.val_car ), ';' ) = 'UTILITIES' 
		And s.id_sin = @adcSin
		
	If @iUtl = 0
	Begin -- ITSM206183 Bug dans le cas d'un sinistre non validé (non présent dans sinistre)		

		Select 
			@iUtl= COUNT(*)
		From
			sysadm.w_sin s 
			inner join sysadm.det_pro dp on dp.id_prod = s.id_prod
		Where
			not exists ( select * from sysadm.sinistre v where v.id_sin = s.id_sin )
			And dp.id_code_dp     = 94   
			And sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( dp.val_car ), ';' ) = 'UTILITIES' 
			And s.id_sin = @adcSin
			
	End 
		

If @asEtape='1' 
Begin
	Select 3 as tri,'RSP#','RESPONSABLE EQUIPE'       as nom , '' as prenom Where @Flag_No_RSP = 0
	Union
	Select 4 as tri,'DRE#',	'DEPARTEMENT RECLAMATION' as nom , '' as prenom Where @Flag_No_DRE = 0
	Union 
	Select 5 as tri,'SC24', 'SOLUTION CONCRETE 24H'   as nom , '' as prenom Where @iPrs <> 0
	Union
	Select 6 as tri,'PRS' , 'PRESTATAIRE'             as nom , '' as prenom Where @iPrs <> 0
	Union	
	Select 7 as tri,'UTL' , 'UTILITIES'               as nom , '' as prenom Where @iUtl <> 0 and @iDr = 0 -- [VDOC18435] pas UTL si dr
	Union
	Select 8 as tri,'DSA#','DIRECTION SERVICES ASSURANCE' as nom, '' as prenom Where @iDr > 0
	Union
	Select 9 as tri,'RDR#','RESPONSABLE DEPARTEMENT RECLAMATION' as nom, '' as prenom Where @iDr > 0 And @Flag_VDOC16313 = 1 
	Union
	Select 10 as tri,'DRS#','DEPARTEMENT RECLAMATION SUPPORT' as nom, '' as prenom Where @iDr > 0 And @Flag_VDOC17582 = 1 
	
	
End
else
Begin
	If master.dbo.SPB_FN_TYPEBASE( db_id() ) = 'PRO' -- [PI056]
	Begin
		Select 2 as tri, 
			o.id_oper, 
			o.nom, 
			o.prenom
		From SESAME_PRO.sysadm.operateur o
		where id_oper=@asCodeOper
		Union
		Select 3 as tri,'RSP#',	'RESPONSABLE EQUIPE'      as nom, '' as prenom Where @Flag_No_RSP = 0
		Union
		Select 4 as tri,'DRE#',	'DEPARTEMENT RECLAMATION' as nom, '' as prenom Where @Flag_No_DRE = 0
		Union 
		Select 5 as tri,'SC24', 'SOLUTION CONCRETE 24H'   as nom, '' as prenom Where @iPrs <> 0
		Union
		Select 6 as tri,'PRS' , 'PRESTATAIRE'             as nom, '' as prenom Where @iPrs <> 0
		Union	
		Select 7 as tri,'UTL' , 'UTILITIES'               as nom, '' as prenom Where @iUtl <> 0 and @iDr = 0 -- [VDOC18435] pas UTL si dr
		Union
		Select 8 as tri,'DSA#','DIRECTION SERVICES ASSURANCE' as nom, '' as prenom Where @iDr > 0
		Union
		Select 9 as tri,'RDR#','RESPONSABLE DEPARTEMENT RECLAMATION' as nom, '' as prenom Where @iDr > 0 And @Flag_VDOC16313 = 1 
		Union
		Select 10 as tri,'DRS#','DEPARTEMENT RECLAMATION SUPPORT' as nom, '' as prenom Where @iDr > 0 And @Flag_VDOC17582 = 1 
	End
	Else
	Begin

		-- [PI097]
		Set @sCmdFfm = 
			'Select 2 as tri, 
				o.id_oper, 
				o.nom, 
				o.prenom
			From [SERVEUR_BASE].sysadm.operateur o 
			where id_oper=@asCodeOper
			Union
			Select 3 as tri,''RSP#'',	''RESPONSABLE EQUIPE''      as nom, '''' as prenom Where @Flag_No_RSP = 0
			Union
			Select 4 as tri,''DRE#'',	''DEPARTEMENT RECLAMATION'' as nom, '''' as prenom Where @Flag_No_DRE = 0
			Union 
			Select 5 as tri,''SC24'', ''SOLUTION CONCRETE 24H''   as nom, '''' as prenom Where @iPrs <> 0
			Union
			Select 6 as tri,''PRS'' , ''PRESTATAIRE''             as nom, '''' as prenom Where @iPrs <> 0
			Union	
			Select 7 as tri,''UTL'' , ''UTILITIES''               as nom, '''' as prenom Where @iUtl <> 0 and @iDr = 0 -- [VDOC18435] pas UTL si dr
			Union
			Select 8 as tri,''DSA#'',''DIRECTION SERVICES ASSURANCE'' as nom, '''' as prenom Where @iDr > 0
			Union
			Select 9 as tri,''RDR#'',''RESPONSABLE DEPARTEMENT RECLAMATION'' as nom, '''' as prenom Where @iDr > 0 And @Flag_VDOC16313 = 1 
			Union
			Select 10 as tri,''DRS#'',''DEPARTEMENT RECLAMATION SUPPORT'' as nom, '''' as prenom Where @iDr > 0 And @Flag_VDOC17582 = 1 
			'

			-- Simulation 2014 ou 2019, base SESAME_SIM présente, donc pas de préfixe lien serveur.
			If @@SERVERNAME in ('SQL14DEV\SIMSINISTRES', 'SINSQL19REC\SIMSINISTRES19' )  Set @sCmdFfm = Replace ( @sCmdFfm, '[SERVEUR_BASE]', 'SESAME_SIM')
			-- Recette 2014 : lien SIM 2014 pour trouver SESAME_SIM
			If @@SERVERNAME = 'SQL14DEV\RECSINISTRES' Set @sCmdFfm = Replace ( @sCmdFfm, '[SERVEUR_BASE]', '[SQL14DEV\SIMSINISTRES].SESAME_SIM')
			-- Recette 2014 : lien SIM 2014 pour trouver SESAME_SIM
			If @@SERVERNAME = 'SINSQL19REC\RECSINISTRES19' Set @sCmdFfm = Replace ( @sCmdFfm, '[SERVEUR_BASE]', '[SINSQL19REC\SIMSINISTRES19].SESAME_SIM')

			Set @sCmdFfm = Replace ( @sCmdFfm, '@asCodeOper' , '''' + Isnull ( @asCodeOper, '') + '''' )
			Set @sCmdFfm = Replace ( @sCmdFfm, '@Flag_No_RSP' , CONVERT ( Varchar (50), @Flag_No_RSP ) )
			Set @sCmdFfm = Replace ( @sCmdFfm, '@Flag_No_DRE' , CONVERT ( Varchar (50), @Flag_No_DRE ) )
			Set @sCmdFfm = Replace ( @sCmdFfm, '@iPrs' , CONVERT ( Varchar (50), @iPrs ) )
			Set @sCmdFfm = Replace ( @sCmdFfm, '@iUtl' , CONVERT ( Varchar (50), @iUtl ) )
			Set @sCmdFfm = Replace ( @sCmdFfm, '@iDr' , CONVERT ( Varchar (50), @iDr ) )
			Set @sCmdFfm = Replace ( @sCmdFfm, '@Flag_VDOC16313' , CONVERT ( Varchar (50), @Flag_VDOC16313 ) )
			Set @sCmdFfm = Replace ( @sCmdFfm, '@Flag_VDOC17582' , CONVERT ( Varchar (50), @Flag_VDOC17582 ) )
			
			Insert into @ListeRech Exec (@sCmdFfm)			 

			Select * from @ListeRech order by tri
	End
	
End

GO

grant execute on sysadm.DW_S03_W_QUEUE_WKF_V01 to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_W_QUEUE_COD_TYP_RECU
-- Auteur               :       JFF
-- Date                 :       29/03/2016
-- Libell‚              :        
-- Commentaires         :       Savoir si l'on est en Déclaration ou Complément, et l'info ne se trouve que dans w_queue, pas dans w_sin
--
-- Arguments            :       Rien
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_W_QUEUE_COD_TYP_RECU' AND type = 'P' )
        DROP procedure sysadm.PS_S_W_QUEUE_COD_TYP_RECU
GO

CREATE procedure sysadm.PS_S_W_QUEUE_COD_TYP_RECU
	@dcIdSin Decimal ( 10 ),
	@sCodTypRecu VarChar ( 1 ) OUTPUT
AS
	Declare @sIdSin VarChar ( 10 )
	Set @sIdSin = Convert ( VarChar ( 10 ), @dcIdSin )

	Select @sCodTypRecu = wq.cod_typ_recu
	From   sysadm.w_queue wq
	Where  wq.id_sin = @sIdSin 

	if @sCodTypRecu is null Set @sCodTypRecu = ''
	Set @sCodTypRecu = Upper ( @sCodTypRecu )

GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_VOL_PERDUS_ATLAS_SSUITE
-- Auteur               :       JFF
-- Date                 :       07/12/2016
-- Libell‚              :        
-- Commentaires         :       [PM234-7][MANTIS22824]
--
-- Arguments            :       Rien
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      22/10/2019   [PI087_PM473_2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_VOL_PERDUS_ATLAS_SSUITE' AND type = 'P' )
        DROP procedure sysadm.PS_I_VOL_PERDUS_ATLAS_SSUITE
GO

CREATE procedure sysadm.PS_I_VOL_PERDUS_ATLAS_SSUITE
AS

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ),
	  marquage	integer null 
	)

Declare @dcIdSin decimal (10 )
Declare @iIdSeq integer
Declare @dcTriPce decimal ( 2 )
Declare @sIdParaPce VarChar ( 4 ) 
Declare @dDteRecu DateTime
Declare @dDteFinGti DateTime
Declare @sCodOper       Varchar (  4   )
Declare @sNoBoite       Varchar ( 10   )
Declare @sProc          Varchar ( 60   )
Declare @dtValideLe     DateTime        
Declare @sMethode	VarChar ( 3 )  	
Declare @iRet Integer
Declare @sMsgTemp VarChar ( 255 )
Declare @iIdCt Integer
Declare @sErr varchar(60)
Declare @dcIdCorb Decimal ( 3 )
Declare @dtCreeLeDos DateTime

Declare @dtDteAdh DateTime
Declare @dtDteSurv DateTime
Declare @dcIdProd Decimal ( 7 )
Declare @sRev     VarChar ( 10 )

Insert into @tb
select ws.id_sin, 
	   0 'marquage'
From sysadm.w_sin ws, 
	 sysadm.w_gar_sin wg,
	 sysadm.det_pro dp
Where Not exists ( 
		Select top 1 1 
		From sysadm.w_queue wq
		Where wq.id_sin = Convert ( varchar ( 10), ws.id_sin ) 
	)
And Not exists ( 
		Select top 1 1 
		From sysadm.sinistre s
		Where s.id_sin = ws.id_sin 
	)
And wg.id_sin = ws.id_sin
And wg.id_gti = 10
And ws.cree_le < DATEADD ( month, -1, getdate() )
And dp.id_prod = ws.id_prod
And dp.id_code_dp = 303

While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin
	From	@tb
	Where	marquage = 0

	Delete sysadm.w_refus Where id_sin = @dcIdSin

	Update sysadm.w_detail
	Set cod_dec_mac = 900, 
		cod_dec_ope = 900, 
		cod_etat = 900,
		alt_att = 'N',
		alt_ssui = 'O',
		cod_mot_ssui = 1,
		maj_le = getdate(),
		maj_par = 'WEB'
	Where id_sin = @dcIdSin

	Update sysadm.w_gar_sin
	Set cod_dec_mac = 900, 
		cod_dec_ope = 900, 
		cod_etat = 900,
		alt_ssui = 'O',
		cod_mot_ssui = 1,
		maj_le = getdate(),
		maj_par = 'WEB'
	Where id_sin = @dcIdSin

	Update sysadm.w_sin
	Set cod_dec_mac = 900, 
		cod_dec_ope = 900, 
		cod_etat = 900,
		alt_ssui = 'O',
		cod_mot_ssui = 1,
		maj_le = getdate(),
		maj_par = 'WEB'
	Where id_sin = @dcIdSin

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
		End 
		
		-- Revision 
		Select @dtDteSurv = dte_surv,
			   @dtDteAdh = dte_adh,
			   @dcIdProd = id_prod
		From   sysadm.w_sin Where id_sin = @dcIdSin

		Set @sRev = Space ( 10 )

		Exec sysadm.PS_X_CALC_REVISION @dcIdProd, @dtDteSurv, @dtDteAdh, @sRev OUTPUT

		If	@sRev is null Set @sRev = '-1'
		If	lTrim ( rtrim ( @sRev )) = '' Set @sRev = '-1'
		If IsNumeric ( @sRev ) = 0 Set @sRev = '-1'
		Update sysadm.w_sin Set id_rev = Convert ( Decimal ( 7 ), @sRev ) Where id_sin = @dcIdSin



	--  Obligé de recreer un travail avant de validation, sinon problème technique
	Select  @dDteRecu=getdate(),
			@dDteFinGti=s.dte_fin_gti
	From sysadm.w_sin s
	Where s.id_sin = @dcIdSin

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		exec SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V03
					@dcIdSin
					,2
					,''
					,'WEB'
					,@sErr OUTPUT
					,@iIdCt OUTPUT
					,@dDteFinGti
					,'E'
					,@dDteRecu
					,0
	END
	ELSE
	BEGIN
		exec SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V03
					@dcIdSin
					,2
					,''
					,'WEB'
					,@sErr OUTPUT
					,@iIdCt OUTPUT
					,@dDteFinGti
					,'E'
					,@dDteRecu
					,0
	END

	-- Le travail doit être occupé !!
	Update w_queue set alt_occupe = 'O' where id_sin = @dcIdSin


--  Validation
	Set @sCodOper = 'WEB'
	Set @sNoBoite = ''
	Set @sProc = Space ( 35 )
	Set @dtValideLe = getdate()
	set @sMethode = 'SVE'


	Exec @iRet = sysadm.PS_VALIDATION
			@dcIdSin,
			@sCodOper,
			@sNoBoite,
			@sProc OUTPUT,
			@dtValideLe OUTPUT,
			@sMethode

	Delete sysadm.w_queue Where id_sin = @dcIdSin
	Update sysadm.routage Set alt_queue = 'N', cod_travail = 'CPL' Where id_sin = @dcIdSin

-- Finalisation validation
	Delete sysadm.w_div_sin where id_sin = @dcIdSin and nom_zone in ( 'zn_tmp_cas_gestion', 'zn_tmp_PM103_1', 'ctl_sepa')
	Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @dcIdSin, 'WEB'


-- Taguer que le dossier a subi l'automatisation avec succès + contact (sans travail bien sûr)

	Insert into sysadm.div_sin 
	(
	id_sin,
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
	cree_le,
	maj_le,
	maj_par,
	valide_le,
	valide_par
	)
	Values 
	(
	@dcIdSin,
	'vol_atlas_perdus_ssuite',
	'Gti Vol Atlas Perdus SSuite',
	-1,
	'N',
	'X',
	'N',
	'O',
	800,
	null,
	null,
	null,
	'O',
	getdate (),
	Getdate (),
	'WEB',
	Getdate (),
	'WEB'
	)

	Set @sMsgTemp = 'Dossier mis sans suite par un automate suite Bug Atlas qui n''avait pas créé de Workflow (travail) vers SIMPA2 lors de la déclaration de ce dossier. Ce dossier n''a donc jamais été repris par un GT.'

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMsgTemp,	'WEB', 300, @iIdCt OUTPUT							
	END
	ELSE
	BEGIN
		Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMsgTemp,	'WEB', 300, @iIdCt OUTPUT							
	END	

	-- [PI087_PM473_2]
	Exec sysadm.PS_I_PI087_TRACE_DOSSIER @dcIdSin, 'VALIDATION', 'WEB'

	Update @tb
	Set marquage = 1
	Where id_seq = @iIdSeq
 End

Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_VOL_PERDUS_ATLAS_ENCOURS
-- Auteur               :       JFF
-- Date                 :       07/12/2016
-- Libell‚              :        
-- Commentaires         :       [PM234-7][MANTIS22824]
--
-- Arguments            :       Rien
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      22/10/2019   [PI087_PM473_2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_VOL_PERDUS_ATLAS_ENCOURS' AND type = 'P' )
        DROP procedure sysadm.PS_I_VOL_PERDUS_ATLAS_ENCOURS
GO

CREATE procedure sysadm.PS_I_VOL_PERDUS_ATLAS_ENCOURS
AS

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ),
	  marquage	integer null 
	)

Declare @dcIdSin decimal (10 )
Declare @iIdSeq integer
Declare @dcTriPce decimal ( 2 )
Declare @sIdParaPce VarChar ( 4 ) 
Declare @dDteRecu DateTime
Declare @dDteFinGti DateTime
Declare @sCodOper       Varchar (  4   )
Declare @sNoBoite       Varchar ( 10   )
Declare @sProc          Varchar ( 60   )
Declare @dtValideLe     DateTime        
Declare @sMethode	VarChar ( 3 )  	
Declare @iRet Integer
Declare @sMsgTemp VarChar ( 255 )
Declare @iIdCt Integer
Declare @sErr varchar(60)
Declare @dcIdCorb Decimal ( 3 )
Declare @dtCreeLeDos DateTime

Declare @dtDteAdh DateTime
Declare @dtDteSurv DateTime
Declare @dcIdProd Decimal ( 7 )
Declare @sRev     VarChar ( 10 )

Set @dtValideLe = getdate()

Insert into @tb
select ws.id_sin, 
	   0 'marquage'
From sysadm.w_sin ws, 
	 sysadm.w_gar_sin wg,
	 sysadm.det_pro dp
	 
Where Not exists ( 
		Select top 1 1 
		From sysadm.w_queue wq
		Where wq.id_sin = Convert ( varchar ( 10), ws.id_sin ) 
	)
And Not exists ( 
		Select top 1 1 
		From sysadm.sinistre s
		Where s.id_sin = ws.id_sin 
	)
And wg.id_sin = ws.id_sin
And wg.id_gti = 10
And dp.id_prod = ws.id_prod
And dp.id_code_dp = 303


While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin
	From	@tb
	Where	marquage = 0

	Select Top 1 
			@dcTriPce =p.cpt_tri,
			@sIdParaPce = p.id_para
	From   sysadm.piece p,
		   sysadm.w_sin ws
	Where  ws.id_sin = @dcIdSin
	And	   p.id_prod = ws.id_prod
	And    p.id_gti = 10
	And    p.id_pce = 645

	If @dcTriPce is null 
		Begin
			Update @tb
			Set marquage = 1
			Where id_seq = @iIdSeq
			Continue
		End 
	
	If Not Exists ( 
			Select Top 1 1
			From	sysadm.w_piece wp
			Where   wp.id_sin = @dcIdSin
			And		wp.id_gti = 10
			And		wp.id_pce = 645
		)
		Begin
			Insert into sysadm.w_piece Values ( @dcIdSin, 10, -1, 645, 0, @sIdParaPce , @dcTriPce, getdate(), getdate(), 'WEB' ) 
			Exec sysadm.PS_IU_PIECE_HISTO @dcIdSin, @dtValideLe
		End 


	Update sysadm.w_detail
	Set cod_dec_mac = 100, 
		cod_dec_ope = 100, 
		cod_etat = 100,
		alt_att = 'O',
		maj_le = getdate(),
		maj_par = 'WEB'
	Where id_sin = @dcIdSin

	Update sysadm.w_gar_sin
	Set cod_dec_mac = 100 ,
		cod_dec_ope = 100, 
		cod_etat = 100,
		maj_le = getdate(),
		maj_par = 'WEB'
	Where id_sin = @dcIdSin

	Update sysadm.w_sin
	Set cod_dec_mac = 100, 
		cod_dec_ope = 100, 
		cod_etat = 100,
		maj_le = getdate(),
		maj_par = 'WEB'
	Where id_sin = @dcIdSin

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
		End 

		
		-- Revision 
		Select @dtDteSurv = dte_surv,
			   @dtDteAdh = dte_adh,
			   @dcIdProd = id_prod
		From   sysadm.w_sin Where id_sin = @dcIdSin

		Set @sRev = Space ( 10 )

		Exec sysadm.PS_X_CALC_REVISION @dcIdProd, @dtDteSurv, @dtDteAdh, @sRev OUTPUT

		If	@sRev is null Set @sRev = '-1'
		If	lTrim ( rtrim ( @sRev )) = '' Set @sRev = '-1'
		If IsNumeric ( @sRev ) = 0 Set @sRev = '-1'
		Update sysadm.w_sin Set id_rev = Convert ( Decimal ( 7 ), @sRev ) Where id_sin = @dcIdSin

	--  Obligé de recreer un travail avant de validation, sinon problème technique

	Select  @dDteRecu=getdate(),
			@dDteFinGti=s.dte_fin_gti
	From sysadm.w_sin s
	Where s.id_sin = @dcIdSin

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		exec SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V03
					@dcIdSin
					,2
					,''
					,'WEB'
					,@sErr OUTPUT
					,@iIdCt OUTPUT
					,@dDteFinGti
					,'E'
					,@dDteRecu
					,0
	END
	ELSE
	BEGIN
		exec SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V03
					@dcIdSin
					,2
					,''
					,'WEB'
					,@sErr OUTPUT
					,@iIdCt OUTPUT
					,@dDteFinGti
					,'E'
					,@dDteRecu
					,0
	END

-- Taguer que le dossier a subi l'automatisation avec succès + contact (sans travail bien sûr)
	Insert into sysadm.w_div_sin 
	(
	id_sin,
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
	maj_par
	)
	Values 
	(
	@dcIdSin,
	'vol_atlas_perdus_encours',
	'Gti Vol Atlas Perdus EnCours',
	-1,
	'N',
	'X',
	'N',
	'O',
	800,
	null,
	null,
	null,
	'O',
	0,
	getdate (),
	Getdate (),
	'WEB'
	)

	-- Le travail doit être occupé !!
	Update w_queue set alt_occupe = 'O' where id_sin = @dcIdSin


--  Validation
	Set @sCodOper = 'WEB'
	Set @sNoBoite = ''
	Set @sProc = Space ( 35 )
	set @sMethode = 'SVE'


	Exec @iRet = sysadm.PS_VALIDATION
			@dcIdSin,
			@sCodOper,
			@sNoBoite,
			@sProc OUTPUT,
			@dtValideLe OUTPUT,
			@sMethode

	Delete sysadm.w_queue Where id_sin = @dcIdSin
	Update sysadm.routage Set alt_queue = 'N', cod_travail = 'CPL' Where id_sin = @dcIdSin

-- Finalisation validation
	Delete sysadm.w_div_sin where id_sin = @dcIdSin and nom_zone in ( 'zn_tmp_cas_gestion', 'zn_tmp_PM103_1', 'ctl_sepa')
	Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @dcIdSin, 'WEB'


	Set @sMsgTemp = 'Dossier mis en cours par un automate suite Bug Atlas qui n''avait pas créé de Workflow (travail) vers SIMPA2 lors de la déclaration de ce dossier. Ce dossier n''a donc jamais été repris par un GT.'

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMsgTemp,	'WEB', 300, @iIdCt OUTPUT							
	END
	ELSE
	BEGIN
		Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMsgTemp,	'WEB', 300, @iIdCt OUTPUT							
	END	

	-- [PI087_PM473_2]
	Exec sysadm.PS_I_PI087_TRACE_DOSSIER @dcIdSin, 'VALIDATION', 'WEB'

	Update @tb
	Set marquage = 1
	Where id_seq = @iIdSeq
 End

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_DOS_PERDUS_ATLAS_SSUITE_OU_REFUS
-- Auteur               :       JFF
-- Date                 :       07/12/2016
-- Libell‚              :        
-- Commentaires         :       [PM234-7][MANTIS22824]
--
-- Arguments            :       Rien
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      22/10/2019   [PI087_PM473_2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DOS_PERDUS_ATLAS_SSUITE_OU_REFUS' AND type = 'P' )
        DROP procedure sysadm.PS_I_DOS_PERDUS_ATLAS_SSUITE_OU_REFUS
GO

CREATE procedure sysadm.PS_I_DOS_PERDUS_ATLAS_SSUITE_OU_REFUS
AS

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ),
	  marquage	integer null 
	)

Declare @dcIdSin decimal (10 )
Declare @iIdSeq integer
Declare @dcTriPce decimal ( 2 )
Declare @sIdParaPce VarChar ( 4 ) 
Declare @dDteRecu DateTime
Declare @dDteFinGti DateTime
Declare @sCodOper       Varchar (  4   )
Declare @sNoBoite       Varchar ( 10   )
Declare @sProc          Varchar ( 60   )
Declare @dtValideLe     DateTime        
Declare @sMethode	VarChar ( 3 )  	
Declare @iRet Integer
Declare @sMsgTemp VarChar ( 255 )
Declare @iIdCt Integer
Declare @sErr varchar(60)
Declare @iRefus Integer 
Declare @dcIdCorb Decimal ( 3 )
Declare @dtCreeLeDos DateTime

Declare @dtDteAdh DateTime
Declare @dtDteSurv DateTime
Declare @dcIdProd Decimal ( 7 )
Declare @sRev     VarChar ( 10 )

Set @iRefus = 0

Insert into @tb
select ws.id_sin, 
	   0 'marquage'
From sysadm.w_sin ws
	 
Where Not exists ( 
		Select top 1 1 
		From sysadm.w_queue wq
		Where wq.id_sin = Convert ( varchar ( 10), ws.id_sin ) 
	)
And Not exists ( 
		Select top 1 1 
		From sysadm.sinistre s
		Where s.id_sin = ws.id_sin 
	)

While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Set @iRefus = 0

	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin
	From	@tb
	Where	marquage = 0

	If Exists ( 
			Select	Top 1 1 
			From	sysadm.w_refus
			Where   id_sin = @dcIdSin
		)
		Begin 
			Set @iRefus = 1
		End 

	Delete sysadm.w_refus Where id_sin = @dcIdSin

	Update sysadm.w_detail
	Set cod_dec_mac = Case @iRefus When 1 Then 200 Else 900 End , 
		cod_dec_ope = Case @iRefus When 1 Then 200 Else 900 End, 
		cod_etat = Case @iRefus When 1 Then 200 Else 900 End,
		alt_att = 'N',
		alt_ssui = Case @iRefus When 1 Then 'N' Else 'O' End,
		cod_mot_ssui = Case @iRefus When 1 Then 0 Else 1 End,
		maj_le = getdate(),
		maj_par = 'WEB'
	Where id_sin = @dcIdSin

	Update sysadm.w_gar_sin
	Set cod_dec_mac = Case @iRefus When 1 Then 200 Else 900 End , 
		cod_dec_ope = Case @iRefus When 1 Then 200 Else 900 End, 
		cod_etat = Case @iRefus When 1 Then 200 Else 900 End,
		alt_att = 'N',
		alt_ssui = Case @iRefus When 1 Then 'N' Else 'O' End,
		cod_mot_ssui = Case @iRefus When 1 Then 0 Else 1 End,
		maj_le = getdate(),
		maj_par = 'WEB'
	Where id_sin = @dcIdSin

	Update sysadm.w_sin
	Set cod_dec_mac = Case @iRefus When 1 Then 200 Else 900 End , 
		cod_dec_ope = Case @iRefus When 1 Then 200 Else 900 End, 
		cod_etat = Case @iRefus When 1 Then 200 Else 900 End,
		alt_ssui = Case @iRefus When 1 Then 'N' Else 'O' End,
		cod_mot_ssui = Case @iRefus When 1 Then 0 Else 1 End,
		maj_le = getdate(),
		maj_par = 'WEB'
	Where id_sin = @dcIdSin

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
		End 

		-- Revision 
		Select @dtDteSurv = dte_surv,
			   @dtDteAdh = dte_adh,
			   @dcIdProd = id_prod
		From   sysadm.w_sin Where id_sin = @dcIdSin

		Set @sRev = Space ( 10 )

		Exec sysadm.PS_X_CALC_REVISION @dcIdProd, @dtDteSurv, @dtDteAdh, @sRev OUTPUT

		If	@sRev is null Set @sRev = '-1'
		If	lTrim ( rtrim ( @sRev )) = '' Set @sRev = '-1'
		If IsNumeric ( @sRev ) = 0 Set @sRev = '-1'
		Update sysadm.w_sin Set id_rev = Convert ( Decimal ( 7 ), @sRev ) Where id_sin = @dcIdSin


	--  Obligé de recreer un travail avant de validation, sinon problème technique

	Select  @dDteRecu=getdate(),
			@dDteFinGti=s.dte_fin_gti
	From sysadm.w_sin s
	Where s.id_sin = @dcIdSin

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		exec SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V03
					@dcIdSin
					,2
					,''
					,'WEB'
					,@sErr OUTPUT
					,@iIdCt OUTPUT
					,@dDteFinGti
					,'E'
					,@dDteRecu
					,0
	END
	ELSE
	BEGIN
		exec SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V03
					@dcIdSin
					,2
					,''
					,'WEB'
					,@sErr OUTPUT
					,@iIdCt OUTPUT
					,@dDteFinGti
					,'E'
					,@dDteRecu
					,0
	END

	-- Le travail doit être occupé !!
	Update w_queue set alt_occupe = 'O' where id_sin = @dcIdSin


--  Validation
	Set @sCodOper = 'WEB'
	Set @sNoBoite = ''
	Set @sProc = Space ( 35 )
	Set @dtValideLe = getdate()
	set @sMethode = 'SVE'

	Exec @iRet = sysadm.PS_VALIDATION
			@dcIdSin,
			@sCodOper,
			@sNoBoite,
			@sProc OUTPUT,
			@dtValideLe OUTPUT,
			@sMethode

	Delete sysadm.w_queue Where id_sin = @dcIdSin
	Update sysadm.routage Set alt_queue = 'N', cod_travail = 'CPL' Where id_sin = @dcIdSin

-- Finalisation validation
	Delete sysadm.w_div_sin where id_sin = @dcIdSin and nom_zone in ( 'zn_tmp_cas_gestion', 'zn_tmp_PM103_1', 'ctl_sepa')
	Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @dcIdSin, 'WEB'


-- Taguer que le dossier a subi l'automatisation avec succès + contact (sans travail bien sûr)
	Insert into sysadm.div_sin 
	(
	id_sin,
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
	cree_le,
	maj_le,
	maj_par,
	valide_le,
	valide_par
	)
	Values 
	(
	@dcIdSin,
	'dos_atlas_perdus_ssuite',
	'Dos Atlas ou autre Perdus SSuite',
	-1,
	'N',
	'X',
	'N',
	'O',
	800,
	null,
	null,
	null,
	'O',
	getdate (),
	Getdate (),
	'WEB',
	Getdate (),
	'WEB'
	)

	Set @sMsgTemp = 'Dossier mis sans suite par un automate suite Bug Atlas qui n''avait pas créé de Workflow (travail) vers SIMPA2 lors de la déclaration de ce dossier. Ce dossier n''a donc jamais été repris par un GT.'

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMsgTemp,	'WEB', 300, @iIdCt OUTPUT							
	END
	ELSE
	BEGIN
		Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMsgTemp,	'WEB', 300, @iIdCt OUTPUT							
	END	

	-- [PI087_PM473_2]
	Exec sysadm.PS_I_PI087_TRACE_DOSSIER @dcIdSin, 'VALIDATION', 'WEB'

	Update @tb
	Set marquage = 1
	Where id_seq = @iIdSeq
 End

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_ERR_TRAVAIL_ABSENT
-- Auteur               :       JFF
-- Date                 :       07/12/2016
-- Libell‚              :        
-- Commentaires         :       [PM234-7][MANTIS22824]
--
-- Arguments            :       Rien
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      22/10/2019   [PI087_PM473_2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_ERR_TRAVAIL_ABSENT' AND type = 'P' )
        DROP procedure sysadm.PS_I_ERR_TRAVAIL_ABSENT
GO

CREATE procedure sysadm.PS_I_ERR_TRAVAIL_ABSENT
AS

Exec sysadm.PS_I_VOL_PERDUS_ATLAS_ENCOURS


DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ),
	  marquage	integer null 
	)

Declare @dcIdSin decimal (10 )
Declare @iIdSeq integer
Declare @dDteRecu DateTime
Declare @dDteFinGti DateTime
Declare @sCodOper       Varchar (  4   )
Declare @sNoBoite       Varchar ( 10   )
Declare @sProc          Varchar ( 60   )
Declare @dtValideLe     DateTime        
Declare @sMethode	VarChar ( 3 )  	
Declare @iRet Integer
Declare @sMsgTemp VarChar ( 255 )
Declare @iIdCt Integer
Declare @sErr varchar(60)
Declare @dcIdCorb Decimal ( 3 )
Declare @dtCreeLeDos DateTime
Declare @sCodIDecl VarChar ( 1 )
Declare @sMajPar VarChar ( 4 )

Declare @dtDteAdh DateTime
Declare @dtDteSurv DateTime
Declare @dcIdProd Decimal ( 7 )
Declare @sRev     VarChar ( 10 )

Insert into @tb
select ws.id_sin, 
	   0 'marquage'
From sysadm.w_sin ws 
Where Not exists ( 
		Select top 1 1 
		From sysadm.w_queue wq
		Where wq.id_sin = Convert ( varchar ( 10), ws.id_sin ) 
	)
And Not exists ( 
		Select top 1 1 
		From sysadm.sinistre s
		Where s.id_sin = ws.id_sin 
	)
And ws.cree_le <= DateAdd ( MINUTE, -10, GetDate() )
And ws.cree_le > '29/04/2022'

While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin
	From	@tb
	Where	marquage = 0

	Select @sCodIDecl = ws.cod_i_decl,
		   @sMajPar = ws.maj_par
	From   sysadm.w_sin ws
	Where  ws.id_sin = @dcIdSin

	Update sysadm.w_detail
	Set cod_dec_mac = 100, 
		cod_dec_ope = 100, 
		cod_etat = 100,
		alt_att = 'O',
		maj_le = getdate(),
		maj_par = @sMajPar
	Where id_sin = @dcIdSin

	Update sysadm.w_gar_sin
	Set cod_dec_mac = 100 ,
		cod_dec_ope = 100, 
		cod_etat = 100,
		maj_le = getdate(),
		maj_par = @sMajPar
	Where id_sin = @dcIdSin

	Update sysadm.w_sin
	Set cod_dec_mac = 100, 
		cod_dec_ope = 100, 
		cod_etat = 100,
		maj_le = getdate(),
		maj_par = @sMajPar
	Where id_sin = @dcIdSin

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

			Insert into sysadm.routage values  ( @dcIdSin, 'N', @dcIdCorb, 'X', 'DEC', 'N', @dtCreeLeDos , @dtCreeLeDos , @sMajPar, null, null, null, null,null )
		End 

	-- Revision 
	Select @dtDteSurv = dte_surv,
			@dtDteAdh = dte_adh,
			@dcIdProd = id_prod
	From   sysadm.w_sin Where id_sin = @dcIdSin

	Set @sRev = Space ( 10 )

	Exec sysadm.PS_X_CALC_REVISION @dcIdProd, @dtDteSurv, @dtDteAdh, @sRev OUTPUT

	If	@sRev is null Set @sRev = '-1'
	Update sysadm.w_sin Set id_rev = Convert ( Decimal ( 7 ), @sRev ) Where id_sin = @dcIdSin


	--  Obligé de recreer un travail avant de validation, sinon problème technique

	Select  @dDteRecu=getdate(),
			@dDteFinGti=s.dte_fin_gti
	From sysadm.w_sin s
	Where s.id_sin = @dcIdSin

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		exec SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V03
					@dcIdSin
					,2
					,''
					,@sMajPar
					,@sErr OUTPUT
					,@iIdCt OUTPUT
					,@dDteFinGti
					,@sCodIDecl
					,@dDteRecu
					,0
	END
	ELSE
	BEGIN
		exec SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V03
					@dcIdSin
					,2
					,''
					,@sMajPar
					,@sErr OUTPUT
					,@iIdCt OUTPUT
					,@dDteFinGti
					,@sCodIDecl
					,@dDteRecu
					,0
	END

	If Not Exists ( 
		Select Top 1 1 
		From	sysadm.w_div_sin wds
		Where   wds.id_sin = @dcIdSin
		And		nom_zone = 'err_trv_absent_decla'
		)
	  Begin

			Insert into sysadm.w_div_sin 
			(
			id_sin,
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
			maj_par
			)
			Values 
			(
			@dcIdSin,
			'err_trv_absent_decla',
			'Erreur Travail Absent Décla',
			-1,
			'N',
			'X',
			'N',
			'O',
			800,
			null,
			null,
			null,
			'O',
			0,
			getdate (),
			Getdate (),
			@sMajPar
			)
	  End

-- 
-- ajouté le 06/07 JF (sinon le GT est bloqué pour mettre sans suitesi GTI absente du param)
Delete sysadm.w_div_det 
From   sysadm.w_sin ws,
		sysadm.w_div_det wd
where  ws.id_sin = @dcIdSin
And    wd.id_sin = ws.id_sin
And    wd.id_gti Not in ( 
	Select id_gti
	From   sysadm.code_garantie cg
	Where  cg.id_prod = ws.id_prod
)

Delete sysadm.w_refus
From   sysadm.w_sin ws,
		sysadm.w_refus wd
where  ws.id_sin = @dcIdSin
And    wd.id_sin = ws.id_sin
And    wd.id_gti Not in ( 
	Select id_gti
	From   sysadm.code_garantie cg
	Where  cg.id_prod = ws.id_prod
)

Delete sysadm.w_piece
From   sysadm.w_sin ws,
		sysadm.w_piece wd
where  ws.id_sin = @dcIdSin
And    wd.id_sin = ws.id_sin
And    wd.id_gti Not in ( 
	Select id_gti
	From   sysadm.code_garantie cg
	Where  cg.id_prod = ws.id_prod
)

Delete sysadm.w_detail
From   sysadm.w_sin ws,
		sysadm.w_detail wd
where  ws.id_sin = @dcIdSin
And    wd.id_sin = ws.id_sin
And    wd.id_gti Not in ( 
	Select id_gti
	From   sysadm.code_garantie cg
	Where  cg.id_prod = ws.id_prod
)

Delete sysadm.w_gar_sin
From   sysadm.w_sin ws,
		sysadm.w_gar_sin wd
where  ws.id_sin = @dcIdSin
And    wd.id_sin = ws.id_sin
And    wd.id_gti Not in ( 
	Select id_gti
	From   sysadm.code_garantie cg
	Where  cg.id_prod = ws.id_prod
)
	-- /ajouté le 06/07 JF

--  Validation
	Set @sCodOper = @sMajPar
	Set @sNoBoite = ''
	Set @sProc = Space ( 35 )
	Set @dtValideLe = getdate()
	set @sMethode = 'SVE'


	Exec @iRet = sysadm.PS_VALIDATION
			@dcIdSin,
			@sCodOper,
			@sNoBoite,
			@sProc OUTPUT,
			@dtValideLe OUTPUT,
			@sMethode

	Delete sysadm.w_queue Where id_sin = @dcIdSin
	Update sysadm.routage Set alt_queue = 'N', cod_travail = 'CPL' Where id_sin = @dcIdSin

-- Finalisation validation
	Delete sysadm.w_div_sin where id_sin = @dcIdSin and nom_zone in ( 'zn_tmp_cas_gestion', 'zn_tmp_PM103_1', 'ctl_sepa')
	Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @dcIdSin, @sMajPar

	If Not Exists ( 
		Select Top 1 1 
		From	sysadm.det_pro dp,
				sysadm.sinistre s
		Where   s.id_sin = @dcIdSin
		And		dp.id_prod = s.id_prod
		And		dp.id_code_dp = 311
	)
	  Begin
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
			BEGIN
				exec SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V03
							@dcIdSin
							,2
							,''
							,'WEB'
							,@sErr OUTPUT
							,@iIdCt OUTPUT
							,@dDteFinGti
							,'E'
							,@dDteRecu
							,0
			END
			ELSE
			BEGIN
				exec SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V03
							@dcIdSin
							,2
							,''
							,'WEB'
							,@sErr OUTPUT
							,@iIdCt OUTPUT
							,@dDteFinGti
							,'E'
							,@dDteRecu
							,0
			END

			Set @sMsgTemp = 'Workflow (travail) non créé par l''extranet vers SIMPA2 lors de la déclaration de ce dossier (bug sur l''extranet). Ce dossier a été redressé par la création d''un travail.'

			IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
			BEGIN
				Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMsgTemp,	'WEB', 300, @iIdCt OUTPUT							
			END
			ELSE
			BEGIN
				Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMsgTemp,	'WEB', 300, @iIdCt OUTPUT							
			END	
	  End

	-- [PI087_PM473_2]
	Exec sysadm.PS_I_PI087_TRACE_DOSSIER @dcIdSin, 'VALIDATION', 'WEB'
	  
	Update @tb
	Set marquage = 1
	Where id_seq = @iIdSeq


 End

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_CONTACT_TRAVAIL_DT339
-- Auteur               :       JFF
-- Date                 :       12/03/2019
-- Libell‚              :        
-- Commentaires         :       [DT339]
--
-- Arguments            :       Rien
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_CONTACT_TRAVAIL_DT339' AND type = 'P' )
        DROP procedure sysadm.PS_I_CONTACT_TRAVAIL_DT339
GO

CREATE procedure sysadm.PS_I_CONTACT_TRAVAIL_DT339
	@adcIdSin	Decimal ( 10),
	@asIdOper   VarChar ( 4 )
AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer

	Set @sMess = 'Dossier à valider de nouveau. Le WebService SAGA2 permettant d''envoyer le mail à CARMA a dysfonctionné, de ce fait le mail n''est pas parti.' 
	Set @sMess = @sMess + 'Vous devez simplement, sans nouvel acte de gestion, valider de nouveau ce dossier.'

	Delete sysadm.w_queue where id_sin = @adcIdSin

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @adcIdSin, 2, @sMess, @asIdOper, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END
	ELSE
	BEGIN
		EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @adcIdSin, 2, @sMess, @asIdOper, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END

	Update sysadm.w_queue Set cod_etat = '5' Where id_sin = @adcIdSin

Go



