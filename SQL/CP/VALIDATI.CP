-------------------------------------------------------------------
--
-- Fichier              :       VALIDATI.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       
--
-- Proc‚dures           :       PS_VALIDATION
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_VALIDATION
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libell‚              :        
-- Commentaires         :       Validation d'un dossier de sinistre
-- R‚f‚rences           :       Utilis‚ dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   ),       (Val)
--                      :       @sNoBoite       VarChar ( 10   ),       (Val)
--                      :       @sProc          Varchar ( 60   ),       (R‚f)
--                      :       @dtValideLe     DateTime                (R‚f)
--				@sMethode	VarChar (  3 )		(Val)  // DCMP 040020 "SVE" ou ""
--
-- Retourne             :       Rien
--
-- #1  JFF   28/10/2009 	[FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
-- #1  JFF   05/09/2009  	[20091105135857040].[BUG]
--     JFF   13/10/2010         [PC106_ECONOCOM]
--     JFF   06/10/2016	[VDOC21884]
--     JFF   12/02/2016   [PI062]
--     JFF   25/08/2020 Nouveau retour forcé 2627 si enregistrement absent dans routage.
--     JFF   09/09/2022   [PM80_FA12_FRANEX]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_VALIDATION' AND type = 'P' )
        DROP procedure sysadm.PS_VALIDATION
GO


CREATE procedure sysadm.PS_VALIDATION
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @sNoBoite       Varchar ( 10   ),
        @sProc          Varchar ( 60   ) OUTPUT ,
        @dtValideLe     DateTime         OUTPUT ,
        @sMethode	VarChar ( 3 )        
AS

Declare @iRet           Integer
Declare @dcIdOrdre      Decimal ( 7,0 )
Declare @dcCodEtat      Decimal ( 7,0 )
Declare @dcCptReg       Decimal ( 2,0 )
Declare @sCodTravail    Varchar (   4 )
Declare @sAltAdr        Varchar (   1 )
Declare @asCasRetour    VarChar ( 50 )
Declare @sDbName  	VarChar ( 20 )

 SELECT @dtValideLe = GetDate ()


 SELECT @sCodTravail = routage.cod_travail
 FROM   sysadm.routage
 WHERE  routage.id_sin = @dcIdSin

 -- JFF   25/08/2020 
 If @@RowCount <> 1 Return 2627
 If @sCodTravail is null Return 2627
 -- /JFF   25/08/2020 

 SELECT @dcIdOrdre = w_sin.id_ordre,
        @dcCodEtat = w_sin.cod_etat,
        @sAltAdr   = w_sin.alt_adr        
 FROM   sysadm.w_sin
 WHERE  w_sin.id_sin = @dcIdSin


 /* Y a-t-il des commandes non valid‚es pour ce sinistre, le cas ‚ch‚ant
    on verrouille la table des articles pour la mise … jour du stock.
    (on verrouille toute la table, il peut en effet y avoir plusieurs fournisseurs
    diff‚rents).	*/

EXEC sysadm.PS_U03_ARTICLE @dcIdSin


If      @sCodTravail = 'DEC'
        Begin
        /* ... R‚cup‚ration d'un Nø ORDRE si besoin ... */
                If      @dcIdOrdre is NULL
                        Begin
                                Select @sProc = 'Incrementation de ID_ORDRE (DEC)'
                                EXEC @iRet = sysadm.PS_X_INCREMENTER 'ID_ORDRE', @dcIdOrdre OUTPUT
                                If @iRet = -1 Return @iRet

        /* ... Cr‚ation dans la table PERSONNE ... */
                                Select @sProc = 'Creation dans PERSONNE (DEC)'
                                EXEC @iRet = sysadm.PS_I01_PERSONNE_VAL @dcIdSin, @dcIdOrdre,
                                             @sCodOper, @dtValideLe
                                If @iRet <> 1 Return @iRet
                        End

        /* ... Cr‚ation dans la table SINISTRE ... */
                Select @sProc = 'Creation dans SINISTRE (DEC)'
                EXEC @iRet = sysadm.PS_I01_SINISTRE_VAL @dcIdSin, @dcIdOrdre,
                             @sCodOper, @dtValideLe
                If @iRet <> 1 Return @iRet


        /* ... Cr‚ation dans la table GAR_SIN ...*/
                Select @sProc = 'Creation dans GAR_SIN (DEC)'
                EXEC @iRet = sysadm.PS_I01_GAR_SIN_VAL @dcIdSin, @sCodOper,
                             @dtValideLe
                If @iRet <> 0 Return @iRet


        /* ... Cr‚ation dans la table DETAIL ...*/
                Select @sProc = 'Creation dans DETAIL (DEC)'
                EXEC @iRet = sysadm.PS_I01_DETAIL_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table COMMANDE ...*/
                Select @sProc = 'Creation dans COMMANDE (DEC)'
                EXEC @iRet = sysadm.PS_I01_COMMANDE_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Maj de la table ARTICLE pour les commandes valid‚es ...*/
                Select @sProc = 'MAJ Table ARTICLE (DEC)'
                EXEC @iRet = sysadm.PS_U02_ARTICLE @dcIdSin
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table REFUS ...*/
                Select @sProc = 'Creation dans REFUS (DEC)'
                EXEC @iRet = sysadm.PS_I01_REFUS_VAL @dcIdSin,
                             @sCodOper, @dtValideLe, 0
                If @iRet <> 0 Return @iRet


        /* ... Cr‚ation dans la table INTER ...*/
                Select @sProc = 'Creation dans INTER (DEC)'
                EXEC @iRet = sysadm.PS_I01_INTER_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table INTER de l'inter fournisseur...*/
                Select @sProc = 'Creation dans INTER (DEC) (Inter FRN)'
                EXEC @iRet = sysadm.PS_I03_INTER_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet
        
        /* ... Cr‚ation dans la table FRAIS ...*/
                Select @sProc = 'Creation dans FRAIS (DEC)'
                EXEC @iRet = sysadm.PS_I01_FRAIS_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table REGLEMENT ...*/
                Select @sProc = 'Creation dans REGLEMENT (DEC)'
                EXEC @iRet = sysadm.IM_CUR_REGLEMENT_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table REG_GTI ...*/
                Select @sProc = 'Creation dans REG_GTI (DEC)'
                EXEC @iRet = sysadm.PS_I01_REG_GTI_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table REG_FRAIS_ANNEXE_FRN ...*/
				-- [PM80_FA12_FRANEX]
				If sysadm.FN_CLE_NUMERIQUE ( 'PM80_FA12_FRANEX') > 0 
				 Begin
					Select @sProc = 'Creation dans REG_FRAIS_ANNEXE_FRN (DEC)'
					EXEC @iRet = sysadm.PS_I01_REG_FRAIS_ANNEXE_FRN_VAL @dcIdSin,
								 @sCodOper, @dtValideLe
					If @iRet <> 0 Return @iRet
				 End 

        /* ... Cr‚ation dans la table DIV_SIN (JFF le 17/06/2004) ...*/
                Select @sProc = 'Creation dans DIV_SIN (DEC)'
                EXEC @iRet = sysadm.PS_I01_DIV_SIN_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table DIV_DET (JFF le 05/10/2005) ...*/
                Select @sProc = 'Creation dans DIV_DET (DEC)'
                EXEC @iRet = sysadm.PS_I01_DIV_DET_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Maj de la table TRACE_TOUT_MOBILE pour valider les enregistrements tracés ...*/
                Select @sProc = 'MAJ Table TRACE_TOUT_MOBILE (DEC)'
                EXEC @iRet = sysadm.PS_U01_TRACE_TOUT_MOBILE @dcIdSin 
                If @iRet <> 0 Return @iRet


        /* ... Cr‚ation dans la table ARCHIVE/ARCHIVE_BLOB ...*/
                Select @sProc = 'Creation dans ARCHIVE/ARCHIVE_BLOB (DEC)'
		If @sMethode = 'SVE'
		  Begin
                	Select @sProc = 'Creation dans ARCHIVE/W_COUR_BLOB_ARCH'
	                EXEC @iRet = sysadm.IM_CUR_ARCHIVE_VAL_SVE @dcIdSin, @dcIdOrdre,
	                             @sCodOper, @dtValideLe
	          End
	        Else
		  Begin
		        Select @sProc = 'Creation dans ARCHIVE/ARCHIVE_BLOB'
	                EXEC @iRet = sysadm.IM_CUR_ARCHIVE_VAL @dcIdSin, @dcIdOrdre,
	                             @sCodOper, @dtValideLe
	          End
                If @iRet <> 0 Return @iRet	          

        /* ... Envoi Mail info PRS via MAILPUSH JFF LE 12/06/2006 ...*/
                Select @sProc = 'MAIL INFO PRS MAILPUSH (DEC)'
		Set @sDbName = Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) )
                EXEC @iRet = sysadm.PS_S04_MAILPUSH_INFO_REPAR_PASSE 'SIMPA2', @sDbName, @dcIdSin, @asCasRetour OUTPUT
                If @iRet <> 0 Return @iRet

        /* ... Envoi Mail info WBA/TEL via MAILPUSH JFF LE 21/02/2007 ...*/
                Select @sProc = 'MAIL INFO WBA/TEL MAILPUSH (DEC)'
		Set @sDbName = Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) )
                EXEC @iRet = sysadm.PS_S05_MAILPUSH_URL_MDP_SITE_CMDE 'SIMPA2', @sDbName, @dcIdSin, @asCasRetour OUTPUT
                If @iRet <> 0 Return @iRet

        /* ... Envoi Mail info Déclaration [PC106_ECONOCOM] via MAILPUSH -DP/146 JFF LE 13/10/2010 ...*/
                Select @sProc = 'MAIL INFO DECLARATION MAILPUSH (DEC)'
		Set @sDbName = Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) )
                EXEC @iRet = sysadm.PS_S10_MAILPUSH_DECLARATION 'SIMPA2', @sDbName, @dcIdSin, @asCasRetour OUTPUT
            If @iRet <> 0 Return @iRet

        /* ... Validation Finale du dossier ...*/
                Select @sProc = 'Validation finale du dossier (DEC)'
                EXEC @iRet = sysadm.PS_U02_SINISTRE_VAL @dcIdSin, @sCodOper, 
                             @dtValideLe, @dcCodEtat, @dcIdOrdre, @sNoBoite, @sMethode
                If @iRet <> 1 Return @iRet

        Select @sProc = ''

        End

If      @sCodTravail = 'CPL'
        Begin
        /* ... Modification dans la table SINISTRE ... */
                Select @sProc = 'Modification dans SINISTRE (CPL)'
                EXEC @iRet = sysadm.PS_U01_SINISTRE_VAL @dcIdSin, @sCodOper, 
                             @dtValideLe
                If @iRet <> 1 Return @iRet

                If      @sAltAdr = 'O'
                        Begin
        /* ... Modification dans la table PERSONNE si besoin ... */
                                Select @sProc = 'Modification dans PERSONNE (CPL)'
                                EXEC @iRet = sysadm.PS_U01_PERSONNE_VAL @dcIdSin,
                                             @sCodOper, @dtValideLe
                                If @iRet <> 1 Return @iRet
                        End

        /* ... Cr‚ation dans la table GAR_SIN ...*/
                Select @sProc = 'Creation dans GAR_SIN (CPL)'
                EXEC @iRet = sysadm.PS_I02_GAR_SIN_VAL @dcIdSin, @sCodOper,
                             @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Modification dans la table GAR_SIN ...*/
                Select @sProc = 'Modification dans GAR_SIN (CPL)'
                EXEC @iRet = sysadm.PS_U01_GAR_SIN_VAL @dcIdSin, @sCodOper,
                             @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table DETAIL ...*/
                Select @sProc = 'Creation dans DETAIL (CPL)'
                EXEC @iRet = sysadm.PS_I02_DETAIL_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Modification dans la table DETAIL ...*/
                Select @sProc = 'Modification dans DETAIL (CPL)'
                EXEC @iRet = sysadm.PS_U01_DETAIL_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table COMMANDE ...*/
                Select @sProc = 'Creation dans COMMANDE (CPL)'
                EXEC @iRet = sysadm.PS_I02_COMMANDE_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Modification dans la table COMMANDE (pour les annulation de cmde UNIQUEMENT !)...*/
        -- #1  [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
                Select @sProc = 'Modification dans COMMANDE (CPL)'
                EXEC @iRet = sysadm.PS_U02_COMMANDE_VAL_V01 @dcIdSin,
                             @sCodOper, @dtValideLe
	        If @iRet <> 0 Return @iRet

        /* ... Maj de la table ARTICLE pour les commandes valid‚es ...*/
                Select @sProc = 'MAJ Table ARTICLE (DEC)'
                EXEC @iRet = sysadm.PS_U02_ARTICLE @dcIdSin
                If @iRet <> 0 Return @iRet


        /* ... Cr‚ation dans la table REFUS ...*/
                Select @sProc = 'Creation dans REFUS (CPL)'
                EXEC @iRet = sysadm.PS_I01_REFUS_VAL @dcIdSin,
                             @sCodOper, @dtValideLe, 1
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table INTER ...*/
                Select @sProc = 'Creation dans INTER (CPL)'
                EXEC @iRet = sysadm.PS_I02_INTER_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table INTER de l'inter fournisseur...*/
                Select @sProc = 'Creation dans INTER (CPL) (Inter FRN)'
                EXEC @iRet = sysadm.PS_I03_INTER_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Modification dans la table INTER ...*/
                Select @sProc = 'Modification dans INTER (CPL)'
                EXEC @iRet = sysadm.PS_U01_INTER_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet
        
        /* ... Cr‚ation dans la table FRAIS ...*/
                Select @sProc = 'Creation dans FRAIS (CPL)'
                EXEC @iRet = sysadm.PS_I01_FRAIS_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table REGLEMENT ...*/
                Select @sProc = 'Creation dans REGLEMENT'
                EXEC @iRet = sysadm.IM_CUR_REGLEMENT_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table REG_GTI ...*/
                Select @sProc = 'Creation dans REG_GTI (CPL)'
                EXEC @iRet = sysadm.PS_I01_REG_GTI_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table REG_FRAIS_ANNEXE_FRN ...*/
				-- [PM80_FA12_FRANEX]
				If sysadm.FN_CLE_NUMERIQUE ( 'PM80_FA12_FRANEX') > 0 
				 Begin
					Select @sProc = 'Creation dans REG_FRAIS_ANNEXE_FRN (DEC)'
					EXEC @iRet = sysadm.PS_I01_REG_FRAIS_ANNEXE_FRN_VAL @dcIdSin,
								 @sCodOper, @dtValideLe
					If @iRet <> 0 Return @iRet
				 End 

        /* ... Cr‚ation dans la table DIV_SIN (JFF le 17/06/2004) ...*/
                Select @sProc = 'Creation dans DIV_SIN (CPL)'
                EXEC @iRet = sysadm.PS_I01_DIV_SIN_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table DIV_SIN (JFF le 17/06/2004) ...*/
                Select @sProc = 'Maj dans DIV_SIN (DEC)'
                EXEC @iRet = sysadm.PS_U01_DIV_SIN_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table DIV_DET (JFF le 05/10/2005) ...*/
                Select @sProc = 'Creation dans DIV_DET (CPL)'
                EXEC @iRet = sysadm.PS_I01_DIV_DET_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Cr‚ation dans la table DIV_DET (JFF le 05/10/2005) ...*/
                Select @sProc = 'Maj dans DIV_DET (CPL)'
                EXEC @iRet = sysadm.PS_U01_DIV_DET_VAL @dcIdSin,
                             @sCodOper, @dtValideLe
                If @iRet <> 0 Return @iRet

        /* ... Maj de la table TRACE_TOUT_MOBILE pour valider les enregistrements tracés ...*/
                Select @sProc = 'MAJ Table TRACE_TOUT_MOBILE (CPL)'
                EXEC @iRet = sysadm.PS_U01_TRACE_TOUT_MOBILE @dcIdSin 
                If @iRet <> 0 Return @iRet


        /* ... Cr‚ation dans la table ARCHIVE/ARCHIVE_BLOB ou W_COUR_BLOB_ARCH ...*/

		If @sMethode = 'SVE'
		  Begin
                	Select @sProc = 'Creation dans ARCHIVE/W_COUR_BLOB_ARCH'
	                EXEC @iRet = sysadm.IM_CUR_ARCHIVE_VAL_SVE @dcIdSin, @dcIdOrdre,
	                             @sCodOper, @dtValideLe
	          End
	        Else
		  Begin
		        Select @sProc = 'Creation dans ARCHIVE/ARCHIVE_BLOB'
	                EXEC @iRet = sysadm.IM_CUR_ARCHIVE_VAL @dcIdSin, @dcIdOrdre,
	                             @sCodOper, @dtValideLe
	          End

                If @iRet <> 0 Return @iRet

        /* ... Envoi Mail info PRS via MAILPUSH JFF LE 12/06/2006 ...*/
                Select @sProc = 'MAIL INFO PRS MAILPUSH (CPL)'
		Set @sDbName = Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) )
                EXEC @iRet = sysadm.PS_S04_MAILPUSH_INFO_REPAR_PASSE 'SIMPA2', @sDbName, @dcIdSin, @asCasRetour OUTPUT
                If @iRet <> 0 Return @iRet

        /* ... Envoi Mail info WBA/TEL via MAILPUSH JFF LE 21/02/2007 ...*/
                Select @sProc = 'MAIL INFO WBA/TEL MAILPUSH (CPL)'
		Set @sDbName = Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) )
                EXEC @iRet = sysadm.PS_S05_MAILPUSH_URL_MDP_SITE_CMDE 'SIMPA2', @sDbName, @dcIdSin, @asCasRetour OUTPUT
                If @iRet <> 0 Return @iRet

        /* ... Validation Finale du dossier ...*/
                Select @sProc = 'Validation finale du dossier (CPL)'
                EXEC @iRet = sysadm.PS_U02_SINISTRE_VAL @dcIdSin, @sCodOper, 
                             @dtValideLe, @dcCodEtat, @dcIdOrdre, @sNoBoite, @sMethode
                If @iRet <> 1 Return @iRet

        Select @sProc = ''

        End

-- #1	JFF	05/09/2009  [20091105135857040].[BUG]
-- Il n'est pas normal que lors de la validation, il reste des état de détail en 500 alors qu'ils devraient tous passer en 600.
-- Ce code à cet endroit redresse un bug du code PB.

 Update sysadm.w_detail
 Set    cod_etat = 600
 From   sysadm.detail
 WHERE  w_detail.id_sin         = @dcIdSin              
 And	w_detail.id_sin		= detail.id_sin
 And	w_detail.id_gti		= detail.id_gti		
 And	w_detail.id_detail	= detail.id_detail
 And	w_detail.cod_etat = 500
 And 	detail.mt_plaf > 0 
 And	detail.id_reg > 0
 And	detail.cod_etat in ( 500, 600 )
 

 Update sysadm.detail
 Set    cod_etat = 600
 WHERE  id_sin = @dcIdSin
 And 	mt_plaf > 0 
 And	id_reg > 0
 And	cod_etat = 500
  -- :#1	JFF	05/09/2009  [20091105135857040].[BUG]
 
-- [VDOC21884] Histo Piece
Exec sysadm.PS_IU_PIECE_HISTO @dcIdSin, @dtValideLe

GO

