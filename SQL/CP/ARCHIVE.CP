-------------------------------------------------------------------
--
-- Fichier              :       ARCHIVE.CP
-- Auteur               :       Erick John Stark
-- Date                 :       10/09/97 17:17:18
--
-- Commentaires         :       Gestion de la table ARCHIVE
--
-- Procédures           :       IM_CUR_ARCHIVE_VAL
--                      :       PS_I01_ARCHIVE_VAL
--				IM_CUR_ARCHIVE_VAL_SVE	  // DCMP 040020 SVE
--                      :       PS_I01_ARCHIVE_VAL_SVE	  // DCMP 040020 SVE
--				DW_S01_ARCHIVE_RELANCES   // Premières Relances Automatiques
--				PS_I02_ARCHIVE_RELANCES   // Insertion d'un courrier (et son blob) de relance dans la base
--				DW_S02_ARCHIVE_RELANCES   // Deuxièmes relances
--				DW_S03_ARCHIVE_RELANCES   // Premières Relances Ponctuelles
--				DW_S04_ARCHIVE_RELANCES   // Select d'une premiŠre relance … supprimer (sans pouvoir la relancer par la suite)
--				DW_S05_ARCHIVE_RELANCES   // PremiŠres relances particuliŠres
--				DW_S06_ARCHIVE_SOLDAGE    // Select des dossiers … solder.
--				PS_D01_ARCHIVE_SOLDAGE    // Soldage des dossiers
--				DW_S07_ARCHIVE_RELANCES   // Premières Relances Automatiques pour Gti Uf et Dem Pce Banques DCMP 000285
--				PS_U01_MAJ_REEDITION
--				PS_I01_RECUPERER_ARCHIVE_V01
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_ARCHIVE_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table ARCHIVE
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdI          Decimal (  7,0 )        (Val)
--                      :       @dcIdCpt        Decimal (  4,0 )        (Val)
--                      :       @dcIdDoc        Decimal (  7,0 )        (Val)
--                      :       @dcIdOrdre      Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_ARCHIVE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_ARCHIVE_VAL
GO

CREATE procedure sysadm.PS_I01_ARCHIVE_VAL
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @dcIdI          Decimal (  7,0 ),
        @dcIdCpt        Decimal (  4,0 ),
        @dcIdDoc        Decimal (  7,0 ),
        @dcIdOrdre      Decimal (  7,0 ),
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

 INSERT INTO    sysadm.archive
        (       archive.id_sin,
                archive.id_inter,
                archive.id_doc,
                archive.id_cour,
                archive.id_prod,
                archive.id_ordre,
                archive.id_adh,
                archive.cod_version,
                archive.cod_inter,
                archive.nom,
                archive.dte_edit,
                archive.dte_conf,
                archive.dte_archiv,
                archive.dte_rep,
                archive.alt_part,
                archive.alt_pce,
                archive.alt_ps,
                archive.alt_rep,
                archive.txt_compo1,
                archive.txt_compo2,
                archive.ref_doc_dt,
                archive.ref_doc_cp,
                archive.ref_doc_pc,
                archive.ref_doc_ps,
                archive.nbr_conf,
                archive.cree_le,
                archive.maj_le,
                archive.maj_par,
                archive.valide_le,
                archive.valide_par      )
 SELECT         w_courrier.id_sin,
                w_courrier.id_i,
                @dcIdDoc,
                w_courrier.id_cour,
                w_sin.id_prod,
                @dcIdOrdre,
                w_sin.id_adh,
                2,
                w_inter.cod_inter,
                w_inter.nom,
                w_queue.trv_edite_le,
                NULL,
                NULL,
                NULL,
                w_courrier.alt_part,
                w_courrier.alt_pce,
                w_courrier.alt_ps,
                'N',
                w_courrier.txt_compo1,
                w_courrier.txt_compo2,
                NULL,
                NULL,
                NULL,
                NULL,
                0,
                w_courrier.cree_le,
                w_courrier.maj_le,
                w_courrier.maj_par,
                @dtValideLe,
                @sCodOper
 FROM           sysadm.w_sin,
                sysadm.w_courrier,
                sysadm.w_inter,
                sysadm.w_queue
 WHERE          w_sin.id_sin            = @dcIdSin              AND
                w_sin.id_sin            = w_courrier.id_sin     AND
                w_sin.id_sin            = w_inter.id_sin        AND
                w_courrier.id_i         = @dcIdI                AND
                w_courrier.id_cpt       = @dcIdCpt              AND
                w_courrier.id_i         = w_inter.id_i          AND
                w_queue.id_sin  = Convert ( VarChar(10), w_sin.id_sin )  -- [PI062]

 Return @@RowCount

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_CUR_ARCHIVE_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table ARCHIVE
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdOrdre      Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_CUR_ARCHIVE_VAL' AND type = 'P' )
        DROP procedure sysadm.IM_CUR_ARCHIVE_VAL
GO

CREATE procedure sysadm.IM_CUR_ARCHIVE_VAL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdOrdre      Decimal (  7,0 ),
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

Declare @dcIdI          Decimal ( 7,0 )
Declare @dcIdDoc        Decimal ( 7,0 )
Declare @dcIdCpt        Decimal ( 4,0 )
Declare @iRet           Integer

/*
Attention, il est possible que le dossier vienne directement de la saisie.
Il n'y a donc aucun courrier … ‚diter.
IMPORTANT : On n'archive pas les courriers DOUBLES. ( ID_I_DB = NULL )
J'utilise des valeurs de retour (iRet) diff‚rentes afin de savoir ou se situe
l'erreur, et cela sans avoir … r‚armer sProc.
0  -> Aucun courrier … valider.
-1 -> Erreur d'insertion sur ARCHIVE
-2 -> Erreur d'insertion sur ARCHIVE_BLOB
-3 -> Erreur de mise … jour sur W_INTER
-4 -> Erreur de mise … jour sur INTER
*/

DECLARE cur1    CURSOR FOR
 SELECT w_courrier.id_i,
        w_courrier.id_cpt
 FROM   sysadm.w_courrier
 WHERE  w_courrier.id_sin = @dcIdSin            AND
        w_courrier.id_i_db is NULL
 ORDER BY       w_courrier.id_i,
                w_courrier.id_cpt

 Select @iRet = 0

 OPEN   cur1

 FETCH  cur1 INTO
        @dcIdI,
        @dcIdCpt

WHILE @@Fetch_Status <> -1
BEGIN

/* ... R‚cup‚ration de la valeur ID_DOC pour l'interlocuteur courant ... */
        SELECT @dcIdDoc = Max ( archive.id_doc ) + 1
        FROM    sysadm.archive
        WHERE   archive.id_sin          = @dcIdSin       AND
                archive.id_inter        = @dcIdI

        IF      @dcIdDoc is NULL Select @dcIdDoc = 1

/* ... Cr‚ation dans la table ARCHIVE ... */
        EXEC @iRet = sysadm.PS_I01_ARCHIVE_VAL @dcIdSin, @dcIdI, @dcIdCpt, 
                     @dcIdDoc, @dcIdOrdre, @sCodOper, @dtValideLe

        If      @iRet <> 1 
                Begin
                        Select @iRet = -1
                        Break
                End

/* ... Cr‚ation dans la table ARCHIVE_BLOB ... */
        EXEC @iRet = sysadm.PS_I01_ARCHIVE_BLOB_VAL @dcIdSin, 
                     @dcIdI, @dcIdDoc, @sCodOper, 
                     @dtValideLe

        If      @iRet <> 0 
                Begin
                        Select @iRet = -2
                        Break
                End

/* ... Mise … jour du compteur de courrier sur W_INTER et INTER ... */
        IF      @dcIdCpt = 0
                Begin
                        UPDATE  sysadm.w_inter
                        SET     sysadm.w_inter.cpt_cour = w_inter.cpt_cour + 1
                        FROM    sysadm.w_inter
                        WHERE   w_inter.id_sin  = @dcIdSin      AND
                                w_inter.id_i    = @dcIdI

                        If      @@RowCount <> 1
                                Begin
                                        Select @iRet = -3
                                        Break
                                End

                        UPDATE  sysadm.inter
                        SET     sysadm.inter.cpt_cour   = inter.cpt_cour + 1
                        FROM    sysadm.inter
                        WHERE   inter.id_sin  = @dcIdSin      AND
                                inter.id_i    = @dcIdI

                        If      @@RowCount <> 1
                                Begin
                                        Select @iRet = -4
                                        Break
                                End

                End

        FETCH   cur1 INTO
                @dcIdI,
                @dcIdCpt

END

CLOSE           cur1
DEALLOCATE      cur1

Return @iRet

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_ARCHIVE_RELANCES
-- Auteur               :       Fabry JF
-- Date                 :       11/06/99 11:27:57
-- Libellé              :       Select sur Archive. 
-- Commentaires         :       Select pour les PREMIERES RELANCES AUTOMATIQUES !
-- Références           :       Utilisé dans W_RL_SP_RELANCES
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--                      :       @dtDateMin      Datetime 	        (Val)
--                      :       @dtDateMax      DateTime		(Val)
--
-- Retourne             :       Rien
--
-- JFF      22/08/2022   [RS3179]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_ARCHIVE_RELANCES' AND type = 'P' )
        DROP procedure sysadm.DW_S01_ARCHIVE_RELANCES
GO

CREATE procedure sysadm.DW_S01_ARCHIVE_RELANCES
      @dcIdProd       Decimal (7,0),
      @dtDateMin      Datetime,
      @dtDateMax      DateTime		
AS


Declare @sCodAdh	VarChar ( 1 )


Select @sCodAdh	= produit.cod_adh
From   sysadm.produit
Where  produit.id_prod = @dcIdProd

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN

	If @sCodAdh = '3' 

	BEGIN

	select 
 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp,
		TRI		= Case IsNull ( arch.id_cour_orig, arch.id_cour )
					When 'APART1' THEN 2
					Else 1
				  End


	From 	sysadm.sinistre 	sin with (nolock) ,
		sysadm.archive  	arch with (nolock),
		sysadm.inter		int with (nolock),
		sysadm.inter		intass with (nolock),
		sysadm.personne 	pers with (nolock),
		sysadm.produit		prod with (nolock),
		sysadm.groupe		grp with (nolock),
		sysadm.routage		rout with (nolock)


	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	 in ( 100, 550 )
	and    	sin.valide_le 		= arch.valide_le
	and     
	(
	  (
		(
		( Substring ( arch.id_cour_orig, 2, 1 ) = 'C' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or
		Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or 
		arch.id_cour_orig = 'APART1'
		) And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		(
		( Substring ( arch.id_cour, 2, 1 ) = 'C' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or
		Substring ( arch.id_cour, 1, 1 ) = 'Q' Or 
		arch.id_cour = 'APART1'
		) And arch.id_cour_orig is null
	  )
	)
	and     (       CharIndex ( 'P001', arch.txt_compo1, 1 ) = 0
				And CharIndex ( 'P118', arch.txt_compo1, 1 ) = 0
				And CharIndex ( 'P119', arch.txt_compo1, 1 ) = 0
				And CharIndex ( 'P037', arch.txt_compo1, 1 ) = 0            
				And CharIndex ( 'P107', arch.txt_compo1, 1 ) = 0            
			And CharIndex ( 'P120', arch.txt_compo1, 1 ) = 0            
			)


	and     arch.valide_le between @dtDateMin and @dtDateMax
	and     arch.cod_version     	= 2
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	grp.id_grp		= sin.id_ets
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )
	END

	-- Adh‚sion SPB
	ELSE

	BEGIN

	select 

 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp,
		TRI		= Case IsNull ( arch.id_cour_orig, arch.id_cour )
					When 'APART1' THEN 2
					Else 1
				  End


	From 	sysadm.sinistre 	sin with (nolock),
		sysadm.archive  	arch with (nolock),
		sysadm.inter		int with (nolock),
		sysadm.inter		intass with (nolock),
		sysadm.personne 	pers with (nolock),
		sysadm.produit		prod with (nolock),
		sysadm.groupe		grp with (nolock),
		sysadm.etablissement	eta with (nolock),
		sysadm.routage		rout with (nolock)

	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	 in ( 100, 550 )
	and    	sin.valide_le 		= arch.valide_le
	and     
	(
	  (
		(
		( Substring ( arch.id_cour_orig, 2, 1 ) = 'C' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or
		Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or 
		arch.id_cour_orig = 'APART1'
		) And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		(
		( Substring ( arch.id_cour, 2, 1 ) = 'C' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or
		Substring ( arch.id_cour, 1, 1 ) = 'Q' Or 
		arch.id_cour = 'APART1'
		) And arch.id_cour_orig is null
	  )
	)
	and     (       CharIndex ( 'P001', arch.txt_compo1, 1 ) = 0
				And CharIndex ( 'P118', arch.txt_compo1, 1 ) = 0
				And CharIndex ( 'P119', arch.txt_compo1, 1 ) = 0
				And CharIndex ( 'P037', arch.txt_compo1, 1 ) = 0            
				And CharIndex ( 'P107', arch.txt_compo1, 1 ) = 0            
			And CharIndex ( 'P120', arch.txt_compo1, 1 ) = 0            
			)

	and     arch.valide_le between @dtDateMin and @dtDateMax
	and     arch.cod_version     	= 2
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	eta.id_prod   		= sin.id_prod
	and	eta.id_ets  		= sin.id_ets
	and	eta.id_grp  		= grp.id_grp
	and	eta.id_rev    		= -1
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )

	END
END 

ELSE

BEGIN

	If @sCodAdh = '3' 

	BEGIN

	select 
 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp,
		TRI		= Case IsNull ( arch.id_cour_orig, arch.id_cour )
					When 'APART1' THEN 2
					Else 1
				  End


	From 	sysadm.sinistre 	sin with (nolock) ,
		sysadm.archive  	arch with (nolock),
		sysadm.inter		int with (nolock),
		sysadm.inter		intass with (nolock),
		sysadm.personne 	pers with (nolock),
		sysadm.produit		prod with (nolock),
		sysadm.groupe		grp with (nolock),
		sysadm.routage		rout with (nolock)


	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	 in ( 100, 550 )
	and    	sin.valide_le 		= arch.valide_le
	and     
	(
	  (
		(
		( Substring ( arch.id_cour_orig, 2, 1 ) = 'C' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or
		Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or 
		arch.id_cour_orig = 'APART1'
		) And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		(
		( Substring ( arch.id_cour, 2, 1 ) = 'C' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or
		Substring ( arch.id_cour, 1, 1 ) = 'Q' Or 
		arch.id_cour = 'APART1'
		) And arch.id_cour_orig is null
	  )
	)
	and     (       CharIndex ( 'P001', arch.txt_compo1, 1 ) = 0
				And CharIndex ( 'P118', arch.txt_compo1, 1 ) = 0
				And CharIndex ( 'P119', arch.txt_compo1, 1 ) = 0
				And CharIndex ( 'P037', arch.txt_compo1, 1 ) = 0            
				And CharIndex ( 'P107', arch.txt_compo1, 1 ) = 0            
			And CharIndex ( 'P120', arch.txt_compo1, 1 ) = 0            
			)


	and     arch.valide_le between @dtDateMin and @dtDateMax
	and     arch.cod_version     	= 2
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	grp.id_grp		= sin.id_ets
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )

	END

	-- Adh‚sion SPB
	ELSE

	BEGIN

	select 

 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp,
		TRI		= Case IsNull ( arch.id_cour_orig, arch.id_cour )
					When 'APART1' THEN 2
					Else 1
				  End


	From 	sysadm.sinistre 	sin with (nolock),
		sysadm.archive  	arch with (nolock),
		sysadm.inter		int with (nolock),
		sysadm.inter		intass with (nolock),
		sysadm.personne 	pers with (nolock),
		sysadm.produit		prod with (nolock),
		sysadm.groupe		grp with (nolock),
		sysadm.etablissement	eta with (nolock),
		sysadm.routage		rout with (nolock)

	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	 in ( 100, 550 )
	and    	sin.valide_le 		= arch.valide_le
	and     
	(
	  (
		(
		( Substring ( arch.id_cour_orig, 2, 1 ) = 'C' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or
		Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or 
		arch.id_cour_orig = 'APART1'
		) And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		(
		( Substring ( arch.id_cour, 2, 1 ) = 'C' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or
		Substring ( arch.id_cour, 1, 1 ) = 'Q' Or 
		arch.id_cour = 'APART1'
		) And arch.id_cour_orig is null
	  )
	)
	and     (       CharIndex ( 'P001', arch.txt_compo1, 1 ) = 0
				And CharIndex ( 'P118', arch.txt_compo1, 1 ) = 0
				And CharIndex ( 'P119', arch.txt_compo1, 1 ) = 0
				And CharIndex ( 'P037', arch.txt_compo1, 1 ) = 0            
				And CharIndex ( 'P107', arch.txt_compo1, 1 ) = 0            
			And CharIndex ( 'P120', arch.txt_compo1, 1 ) = 0            
			)

	and     arch.valide_le between @dtDateMin and @dtDateMax
	and     arch.cod_version     	= 2
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	eta.id_prod   		= sin.id_prod
	and	eta.id_ets  		= sin.id_ets
	and	eta.id_grp  		= grp.id_grp
	and	eta.id_rev    		= -1
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )

	END
END 

GO



--------------------------------------------------------------------
--
-- Procédure            :       PS_I02_ARCHIVE_RELANCES
-- Auteur               :       Fabry JF
-- Date                 :       15/06/99 11:27:57
-- Libellé              :       Insert du courrier de relances sur ARCHIVE et ARCHIVE_BLOB.
--				Le blob sera écrit depuis l'appli, via un UPDATEBLOB.
-- Commentaires         :       
-- Références           :       Utilisé dans U_RL_SP_REL_ANC
--
--
-- Arguments		:	@adtDateDuJour		DateTime,
--				@adcId_Doc		Decimal ( 7, 0 ) OUTPUT, (Retourne le dernier IdDoc détemriné)
--	
--				Description de l'enregistrement avec les Arguments.
--
-- 				@adcId_Sin		Decimal ( 7, 0 ),
--				@adcId_Inter		Decimal ( 7, 0 ),
--				Id_Doc : Déterminer via un un select max au dernier moment pour ne pas risquer un conflit.
--				@asId_Cour		VarChar ( 6 ),
--				@adcId_Prod		Decimal ( 7, 0 ),
--				@adcId_Ordre		Decimal ( 7, 0 ),
--				@asId_Adh		VarChar ( 19 ),
--				2 : Cod Version
--				@asCod_Inter  		VarChar ( 1 ),
--				@asNom			VarChar ( 71 ),
--				DateEdit : =@adtDateDuJour
-- 				NULL : Dte_Conf
--				NULL : Dte_Archive
-- 				NULL : Dte_Rep
--				'N' : sAlt_Part
--				'N' : sAlt_Pce
--				'N' : sAlt_Ps
--			 	'N' : sAlt_Rep
--				@asTextComp1		VarChar ( 248 ),
--				NULL : TxtCompo2
--				NULL : REF_DOC_DT
--				NULL : REF_DOC_CP
--				NULL : REF_DOC_PC
--				NULL : REF_DOC_PS
--				0    : NBRE_CONF
-- 				Valide_Le : Valide_le du courrier original.
--				@asValidePar 		VarChar ( 4 )  (Valide_par du courrier original.)
--				CreeLe : =@adtDateDuJour
--				MajLe  : =@adtDateDuJour
--				@asMajPar		VarChar ( 4 )
--				@asTypBlob		VarChar ( 2 )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/06/2014   [PI052]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
if exists (select * from sysobjects where id = object_id('sysadm.PS_I02_ARCHIVE_RELANCES') and sysstat & 0xf = 4)
	drop procedure sysadm.PS_I02_ARCHIVE_RELANCES
GO

CREATE PROC sysadm.PS_I02_ARCHIVE_RELANCES
  @adtDateDuJour	DateTime,
  @adcId_Doc		Decimal ( 7, 0 ) OUTPUT,
  @adcId_Sin		Decimal ( 10, 0 ),  -- [PI062]
  @adcId_Inter		Decimal ( 7, 0 ),
  @asId_Cour		VarChar ( 6    ),
  @adcId_Prod		Decimal ( 7, 0 ),
  @adcId_Ordre		Decimal ( 7, 0 ),
  @asId_Adh		VarChar ( 19   ),
  @asCod_Inter 		VarChar ( 1    ),
  @asNom		VarChar ( 71   ),
  @asTextComp1		VarChar ( 248  ),
  @asValidePar		VarChar ( 4    ),
  @asMajPar		VarChar ( 4    ),
  @asTypBlob		VarChar ( 2 )

AS

Declare @dtValideLe	DateTime		
Declare @iCptArch Integer
Declare @dtDteEdit DateTime -- [PI052]

-------------------------------------------------------------------------
-- Récupération du nouvelle valeur d'archive --
-------------------------------------------------------------------------
-- [PI052]
Set @iCptArch = null
Set @dtDteEdit = @adtDateDuJour -- [PI052]

If sysadm.FN_CLE_NUMERIQUE ( 'PI052') > 0 
 Begin
	EXEC sysadm.PS_X_INCREMENTER 'CPT_ARCH', @iCptArch OUTPUT
	Set @dtDteEdit = '01/01/1900'
 End 


----------------------------------------------------
-- On s‚lectionne ici (et non dans l'appli), la   --
-- date du pour un ‚viter un problŠme de format   --
-- de date avec les centiŠmes de secondes.        --
----------------------------------------------------
Select  @dtValideLe = valide_le
From    sysadm.archive
Where   id_sin   = @adcId_Sin
And     id_inter = @adcId_Inter
And	id_doc	 = @adcId_Doc

----------------------------------------------------
-- On met … jour ensuite le nouvel id_doc.        --
----------------------------------------------------
Select @adcId_Doc= max ( id_doc ) + 1
From   sysadm.archive
Where  id_sin   = @adcId_Sin
And    id_inter = @adcId_Inter


  INSERT INTO sysadm.archive
	(
		archive.id_sin,					
		archive.id_inter,
		archive.id_doc,

		archive.id_cour,
		archive.id_prod,
		archive.id_ordre,

		archive.id_adh,
		archive.cod_version,
		archive.cod_inter,
	
		archive.nom,
		archive.dte_edit,
		archive.dte_conf,
	
		archive.dte_archiv,
		archive.dte_rep,
		archive.alt_part,

		archive.alt_pce,
		archive.alt_ps,
		archive.alt_rep,
	
		archive.txt_compo1,
		archive.txt_compo2,
		archive.ref_doc_dt,
	
		archive.ref_doc_cp,
		archive.ref_doc_pc,
		archive.ref_doc_ps,

		archive.nbr_conf,
		archive.valide_le,
		archive.valide_par,

		archive.cree_le,
		archive.maj_le,
		archive.maj_par,
		
		archive.id_cour_orig,
		archive.id_arch

	)

  VALUES
	(
		@adcId_Sin,
		@adcId_Inter,
		@adcId_Doc, 
	
		@asId_Cour,
		@adcId_Prod,
		@adcId_Ordre,
	
		@asId_Adh,
		2,
		@asCod_Inter,
	
		@asNom,
		@dtDteEdit,
		NULL,
	
		NULL,
		NULL,
		'N',
	
		'N',
		'N',
		'N',
	
		@asTextComp1,
		NULL,
		NULL,
	
		NULL,
		NULL,
		NULL,
	
		0,
		@dtValideLe,
		@asValidePar,

		@adtDateDuJour,
		@adtDateDuJour,
		@asMajPar,
		
		@asId_Cour,
		@iCptArch 
	)


  INSERT INTO sysadm.archive_blob

		(
		  archive_blob.id_sin,
		  archive_blob.id_inter,
		  archive_blob.id_doc,

 		  archive_blob.id_typ_blob,
		  archive_blob.txt_blob,
		  archive_blob.valide_le,
		  
		  archive_blob.valide_par,
		  archive_blob.cree_le,
		  archive_blob.maj_le,

  		  archive_blob.maj_par

		)

  VALUES	
		(
		  @adcId_Sin,
		  @adcId_Inter,
		  @adcId_Doc, 

 		  @asTypBlob, 
		  ' ', 
	  	  @dtValideLe,

		  @asValidePar,
	 	  @adtDateDuJour,
	 	  @adtDateDuJour,

		  @asMajPar
		) 

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_ARCHIVE_RELANCES
-- Auteur               :       Fabry JF
-- Date                 :       11/06/99 11:27:57
-- Libellé              :       Select sur Archive. 
-- Commentaires         :       Select pour les DEUXIEMES RELANCES !
-- Références           :       Utilisé dans W_RL_SP_RELANCES
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--                      :       @dtDateMin      Datetime 	        (Val)
--
-- Retourne             :       Rien
--
-- JFF      22/08/2022   [RS3179]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_ARCHIVE_RELANCES' AND type = 'P' )
        DROP procedure sysadm.DW_S02_ARCHIVE_RELANCES
GO

CREATE procedure sysadm.DW_S02_ARCHIVE_RELANCES
      @dcIdProd       Decimal (7,0),
      @dtDateMax      Datetime
AS

Declare @sCodAdh	VarChar ( 1 )


Select @sCodAdh	= produit.cod_adh
From   sysadm.produit
Where  produit.id_prod = @dcIdProd

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN

	If @sCodAdh = '3' 

	BEGIN

	select 
 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp


	From 	sysadm.sinistre 	sin with (nolock),
		sysadm.archive  	arch with (nolock),
		sysadm.inter		int with (nolock),
		sysadm.inter		intass with (nolock),
		sysadm.personne 	pers with (nolock),
		sysadm.produit		prod with (nolock),
		sysadm.groupe		grp with (nolock),
		sysadm.routage		rout with (nolock)


	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	in ( 100, 550 )
	and    	sin.valide_le 		= arch.valide_le
	and     
	(
	  (
		( Substring ( arch.id_cour_orig, 2, 5 ) = 'LAX01' Or arch.id_cour_orig = 'ALQ001' )
		And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		( Substring ( arch.id_cour, 2, 5 ) = 'LAX01' Or arch.id_cour = 'ALQ001' )
		And arch.id_cour_orig is null
	  )
	)

	and     arch.maj_le 		<= @dtDateMax
	and     arch.cod_version     	= 2
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	grp.id_grp		= sin.id_ets
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )

	END

	-- Adh‚sion SPB
	ELSE

	BEGIN

	select 

 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp


	From 	sysadm.sinistre 	sin with (nolock),
		sysadm.archive  	arch with (nolock),
		sysadm.inter		int with (nolock),
		sysadm.inter		intass with (nolock),
		sysadm.personne 	pers with (nolock),
		sysadm.produit		prod with (nolock),
		sysadm.groupe		grp with (nolock),
		sysadm.etablissement	eta with (nolock),
		sysadm.routage		rout with (nolock)

	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	in ( 100, 550 )
	and    	sin.valide_le 		= arch.valide_le
	and     
	(
	  (
		( Substring ( arch.id_cour_orig, 2, 5 ) = 'LAX01' Or arch.id_cour_orig = 'ALQ001' )
		And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		( Substring ( arch.id_cour, 2, 5 ) = 'LAX01' Or arch.id_cour = 'ALQ001' )
		And arch.id_cour_orig is null
	  )
	)

	and     arch.maj_le		<= @dtDateMax
	and     arch.cod_version     	= 2
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	eta.id_prod   		= sin.id_prod
	and	eta.id_ets  		= sin.id_ets
	and	eta.id_grp  		= grp.id_grp
	and	eta.id_rev    		= -1
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )

	END
END 

ELSE

BEGIN
	If @sCodAdh = '3' 

	BEGIN

	select 
 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp


	From 	sysadm.sinistre 	sin with (nolock),
		sysadm.archive  	arch with (nolock),
		sysadm.inter		int with (nolock),
		sysadm.inter		intass with (nolock),
		sysadm.personne 	pers with (nolock),
		sysadm.produit		prod with (nolock),
		sysadm.groupe		grp with (nolock),
		sysadm.routage		rout with (nolock)


	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	in ( 100, 550 )
	and    	sin.valide_le 		= arch.valide_le
	and     
	(
	  (
		( Substring ( arch.id_cour_orig, 2, 5 ) = 'LAX01' Or arch.id_cour_orig = 'ALQ001' )
		And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		( Substring ( arch.id_cour, 2, 5 ) = 'LAX01' Or arch.id_cour = 'ALQ001' )
		And arch.id_cour_orig is null
	  )
	)

	and     arch.maj_le 		<= @dtDateMax
	and     arch.cod_version     	= 2
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	grp.id_grp		= sin.id_ets
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )



	END

	-- Adh‚sion SPB
	ELSE

	BEGIN

	select 

 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp


	From 	sysadm.sinistre 	sin with (nolock),
		sysadm.archive  	arch with (nolock),
		sysadm.inter		int with (nolock),
		sysadm.inter		intass with (nolock),
		sysadm.personne 	pers with (nolock),
		sysadm.produit		prod with (nolock),
		sysadm.groupe		grp with (nolock),
		sysadm.etablissement	eta with (nolock),
		sysadm.routage		rout with (nolock)

	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	in ( 100, 550 )
	and    	sin.valide_le 		= arch.valide_le
	and     
	(
	  (
		( Substring ( arch.id_cour_orig, 2, 5 ) = 'LAX01' Or arch.id_cour_orig = 'ALQ001' )
		And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		( Substring ( arch.id_cour, 2, 5 ) = 'LAX01' Or arch.id_cour = 'ALQ001' )
		And arch.id_cour_orig is null
	  )
	)

	and     arch.maj_le		<= @dtDateMax
	and     arch.cod_version     	= 2
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	eta.id_prod   		= sin.id_prod
	and	eta.id_ets  		= sin.id_ets
	and	eta.id_grp  		= grp.id_grp
	and	eta.id_rev    		= -1
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )

	END
END 

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S03_ARCHIVE_RELANCES
-- Auteur               :       Fabry JF
-- Date                 :       11/06/99 11:27:57
-- Libellé              :       Select sur Archive. 
-- Commentaires         :       Select pour les PREMIERES RELANCES PONCTUELLES!
--				On passe le prod du sinistre en argument, car on connait
--                              d‚j… cette info sur la fenˆtre, cela ‚vite une jointure dans la requˆte. 
-- Références           :       Utilisé dans W_RL_SP_RELANCES
--
-- Arguments            :       @dcIdSin        Decimal ( 7,0 )        (Val)
--				@dcIdProd	Decimal	( 7,0 )        (Val)  	On connaŒt d‚j… le produit du sinistre … ce moment, alors
--										le fait de pass‚ ‚vite juste une jointure.
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF		12/02/2016	 [PI062]
-- JFF      22/08/2022   [RS3179]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_ARCHIVE_RELANCES' AND type = 'P' )
        DROP procedure sysadm.DW_S03_ARCHIVE_RELANCES
GO

CREATE procedure sysadm.DW_S03_ARCHIVE_RELANCES
      @dcIdSin        Decimal (10,0),  -- [PI062]
      @dcIdProd       Decimal (7,0)

AS

Declare @sCodAdh	VarChar ( 1 )


Select @sCodAdh	= produit.cod_adh
From   sysadm.produit
Where  produit.id_prod = @dcIdProd

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN

	If @sCodAdh = '3' 

	BEGIN

	select 
 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp,
		TRI		= Case IsNull ( arch.id_cour_orig, arch.id_cour )
					When 'APART1' THEN 2
					Else 1
				  End


	From 	sysadm.sinistre 	sin,
		sysadm.archive  	arch,
		sysadm.inter		int,
		sysadm.inter		intass,
		sysadm.personne 	pers,
		sysadm.produit		prod,
		sysadm.groupe		grp,
		sysadm.routage		rout

	Where	sin.id_sin		= @dcIdSin
	and	prod.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	 in ( 100, 550 )
	and     
	(
	  (
		( Substring ( arch.id_cour_orig, 2, 4 ) <> 'LAX0' and arch.id_cour_orig <> 'ALQ001' )
		And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		( Substring ( arch.id_cour, 2, 4 ) <> 'LAX0' and arch.id_cour <> 'ALQ001' )
		And arch.id_cour_orig is null
	  )
	)

	and     arch.id_doc = ( select max (id_doc) 
					from   sysadm.archive arch2
							where  arch2.id_sin   = arch.id_sin
					and    arch2.id_inter = arch.id_inter )
	and     arch.cod_version     	= 2
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	grp.id_grp		= sin.id_ets
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )

	END

	-- Adh‚sion SPB
	ELSE

	BEGIN

	select 

 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp,
		TRI		= Case IsNull ( arch.id_cour_orig, arch.id_cour )
					When 'APART1' THEN 2
					Else 1
				  End


	From 	sysadm.sinistre 	sin,
		sysadm.archive  	arch,
		sysadm.inter		int,
		sysadm.inter		intass,
		sysadm.personne 	pers,
		sysadm.produit		prod,
		sysadm.groupe		grp,
		sysadm.etablissement	eta,
		sysadm.routage		rout

	Where	sin.id_sin		= @dcIdSin
	and	prod.id_prod   		= sin.id_prod
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	 in ( 100, 550 )
	and     
	(
	  (
		( Substring ( arch.id_cour_orig, 2, 4 ) <> 'LAX0' and arch.id_cour_orig <> 'ALQ001' )
		And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		( Substring ( arch.id_cour, 2, 4 ) <> 'LAX0' and arch.id_cour <> 'ALQ001' )
		And arch.id_cour_orig is null
	  )
	)

	and     arch.id_doc = ( select max (id_doc) 
					from   sysadm.archive arch2
							where  arch2.id_sin   = arch.id_sin
					and    arch2.id_inter = arch.id_inter )
	and     arch.cod_version     	= 2
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	eta.id_prod   		= sin.id_prod
	and	eta.id_ets  		= sin.id_ets
	and	eta.id_grp  		= grp.id_grp
	and	eta.id_rev    		= -1
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )
	END
END 

ELSE

BEGIN
	If @sCodAdh = '3' 

	BEGIN

	select 
 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp,
		TRI		= Case IsNull ( arch.id_cour_orig, arch.id_cour )
					When 'APART1' THEN 2
					Else 1
				  End


	From 	sysadm.sinistre 	sin,
		sysadm.archive  	arch,
		sysadm.inter		int,
		sysadm.inter		intass,
		sysadm.personne 	pers,
		sysadm.produit		prod,
		sysadm.groupe		grp,
		sysadm.routage		rout

	Where	sin.id_sin		= @dcIdSin
	and	prod.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	 in ( 100, 550 )
	and     
	(
	  (
		( Substring ( arch.id_cour_orig, 2, 4 ) <> 'LAX0' and arch.id_cour_orig <> 'ALQ001' )
		And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		( Substring ( arch.id_cour, 2, 4 ) <> 'LAX0' and arch.id_cour <> 'ALQ001' )
		And arch.id_cour_orig is null
	  )
	)

	and     arch.id_doc = ( select max (id_doc) 
					from   sysadm.archive arch2
							where  arch2.id_sin   = arch.id_sin
					and    arch2.id_inter = arch.id_inter )
	and     arch.cod_version     	= 2
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	grp.id_grp		= sin.id_ets
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )

	END

	-- Adh‚sion SPB
	ELSE

	BEGIN

	select 

 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp,
		TRI		= Case IsNull ( arch.id_cour_orig, arch.id_cour )
					When 'APART1' THEN 2
					Else 1
				  End


	From 	sysadm.sinistre 	sin,
		sysadm.archive  	arch,
		sysadm.inter		int,
		sysadm.inter		intass,
		sysadm.personne 	pers,
		sysadm.produit		prod,
		sysadm.groupe		grp,
		sysadm.etablissement	eta,
		sysadm.routage		rout

	Where	sin.id_sin		= @dcIdSin
	and	prod.id_prod   		= sin.id_prod
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	 in ( 100, 550 )
	and     
	(
	  (
		( Substring ( arch.id_cour_orig, 2, 4 ) <> 'LAX0' and arch.id_cour_orig <> 'ALQ001' )
		And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		( Substring ( arch.id_cour, 2, 4 ) <> 'LAX0' and arch.id_cour <> 'ALQ001' )
		And arch.id_cour_orig is null
	  )
	)

	and     arch.id_doc = ( select max (id_doc) 
					from   sysadm.archive arch2
							where  arch2.id_sin   = arch.id_sin
					and    arch2.id_inter = arch.id_inter )
	and     arch.cod_version     	= 2
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	eta.id_prod   		= sin.id_prod
	and	eta.id_ets  		= sin.id_ets
	and	eta.id_grp  		= grp.id_grp
	and	eta.id_rev    		= -1
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )

	END
END

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S04_ARCHIVE_RELANCES
-- Auteur               :       Fabry JF
-- Date                 :       11/06/99 11:27:57
-- Libellé              :       Select d'une premiŠre relance … supprimer.
-- 				Le courrier original ne pourra jamais plus ˆtre relanc‚e par la suite.
--				Le delete se fait via l'appli.
-- Commentaires         :
--
-- Références           :       Utilisé dans W_RL_SP_RELANCES
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-- JFF      22/08/2022   [RS3179]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_ARCHIVE_RELANCES' AND type = 'P' )
        DROP procedure sysadm.DW_S04_ARCHIVE_RELANCES
GO

CREATE procedure sysadm.DW_S04_ARCHIVE_RELANCES
      @dcIdSin        Decimal (10,0)  -- [PI062]

AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN

	select 
 		ID_SIN 		= sin.id_sin,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le


	From 	sysadm.sinistre 	sin,
		sysadm.archive  	arch,
		sysadm.inter		int


	Where	sin.id_sin		= @dcIdSin
	and	sin.id_sin 		= arch.id_sin
	and     
	(
	  (
		( Substring ( arch.id_cour_orig, 2, 5 ) = 'LAX01' Or arch.id_cour_orig = 'ALQ001' )
		And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		( Substring ( arch.id_cour, 2, 5 ) = 'LAX01' Or arch.id_cour = 'ALQ001' )
		And arch.id_cour_orig is null
	  )
	)

	and     arch.cod_version     	= 2
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )
END 

ELSE

BEGIN
	select 
 		ID_SIN 		= sin.id_sin,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le


	From 	sysadm.sinistre 	sin,
		sysadm.archive  	arch,
		sysadm.inter		int


	Where	sin.id_sin		= @dcIdSin
	and	sin.id_sin 		= arch.id_sin
	and     
	(
	  (
		( Substring ( arch.id_cour_orig, 2, 5 ) = 'LAX01' Or arch.id_cour_orig = 'ALQ001' )
		And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		( Substring ( arch.id_cour, 2, 5 ) = 'LAX01' Or arch.id_cour = 'ALQ001' )
		And arch.id_cour_orig is null
	  )
	)

	and     arch.cod_version     	= 2
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )
END 


GO



--------------------------------------------------------------------
--
-- Procédure            :       DW_S05_ARCHIVE_RELANCES
-- Auteur               :       Fabry JF
-- Date                 :       25/06/99 11:27:57
-- Libellé              :       Select sur Archive. 
-- Commentaires         :       Select pour les PREMIERES RELANCES PARTICULIERES !
-- Références           :       Utilisé dans W_RL_SP_RELANCES
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--                      :       @dtDateMin      Datetime 	        (Val)
--                      :       @dtDateMax      DateTime		(Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S05_ARCHIVE_RELANCES' AND type = 'P' )
        DROP procedure sysadm.DW_S05_ARCHIVE_RELANCES
GO

CREATE procedure sysadm.DW_S05_ARCHIVE_RELANCES
      @dcIdProd       Decimal (7,0),
      @dtDateMin      Datetime,
      @dtDateMax      DateTime		
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	select 
 		ID_SIN 		= sin.id_sin,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le

	From 	sysadm.sinistre 	sin,
		sysadm.archive  	arch,
		sysadm.inter		int,
		sysadm.routage		rout

	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	in ( 100, 550 )
	and     arch.valide_le		= sin.valide_le

	and     not exists ( select arch_3.id_sin
				 from   archive arch_3
				 where  (
					(
					  (
						(
						(Substring ( arch_3.id_cour_orig, 2, 1 ) = 'C' and Substring ( arch_3.id_cour_orig, 4, 1 ) = 'P' ) or 
						Substring ( arch_3.id_cour_orig, 1, 1 ) = 'Q' or 
						arch_3.id_cour_orig = 'APART1'
						) And arch.id_cour_orig is not null
					  ) 
					 OR
					  (
						(
						(Substring ( arch_3.id_cour, 2, 1 ) = 'C' and Substring ( arch_3.id_cour, 4, 1 ) = 'P' ) or 
						Substring ( arch_3.id_cour, 1, 1 ) = 'Q' or 
						arch_3.id_cour = 'APART1'
						) And arch.id_cour_orig is null
					  )
					)
	  				 ) 
				 and    arch_3.id_sin   = arch.id_sin
				 and    arch_3.valide_le=  ( Select Max ( valide_le )
							 From   archive arch_4
							 where  arch_4.id_sin = arch.id_sin ) )

	and     
	(
	  (
		( Substring ( arch.id_cour_orig, 2, 4 ) <> 'LAX0' and arch.id_cour_orig <> 'ALQ001' )
		And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		( Substring ( arch.id_cour, 2, 4 ) <> 'LAX0' and arch.id_cour <> 'ALQ001' )
		And arch.id_cour_orig is null
	  )
	)

	and     arch.valide_le between @dtDateMin and @dtDateMax
	and     arch.id_doc = ( select max (id_doc) 
					from   sysadm.archive arch2
							where  arch2.id_sin   = arch.id_sin
					and    arch2.id_inter = arch.id_inter )
	and     arch.cod_version     	= 2
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )
END 

ELSE

BEGIN
	select 
 		ID_SIN 		= sin.id_sin,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le

	From 	sysadm.sinistre 	sin,
		sysadm.archive  	arch,
		sysadm.inter		int,
		sysadm.routage		rout

	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	in ( 100, 550 )
	and     arch.valide_le		= sin.valide_le

	and     not exists ( select arch_3.id_sin
				 from   archive arch_3
				 where  (
					(
					  (
						(
						(Substring ( arch_3.id_cour_orig, 2, 1 ) = 'C' and Substring ( arch_3.id_cour_orig, 4, 1 ) = 'P' ) or 
						Substring ( arch_3.id_cour_orig, 1, 1 ) = 'Q' or 
						arch_3.id_cour_orig = 'APART1'
						) And arch.id_cour_orig is not null
					  ) 
					 OR
					  (
						(
						(Substring ( arch_3.id_cour, 2, 1 ) = 'C' and Substring ( arch_3.id_cour, 4, 1 ) = 'P' ) or 
						Substring ( arch_3.id_cour, 1, 1 ) = 'Q' or 
						arch_3.id_cour = 'APART1'
						) And arch.id_cour_orig is null
					  )
					)
	  				 ) 
				 and    arch_3.id_sin   = arch.id_sin
				 and    arch_3.valide_le=  ( Select Max ( valide_le )
							 From   archive arch_4
							 where  arch_4.id_sin = arch.id_sin ) )

	and     
	(
	  (
		( Substring ( arch.id_cour_orig, 2, 4 ) <> 'LAX0' and arch.id_cour_orig <> 'ALQ001' )
		And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		( Substring ( arch.id_cour, 2, 4 ) <> 'LAX0' and arch.id_cour <> 'ALQ001' )
		And arch.id_cour_orig is null
	  )
	)

	and     arch.valide_le between @dtDateMin and @dtDateMax
	and     arch.id_doc = ( select max (id_doc) 
					from   sysadm.archive arch2
							where  arch2.id_sin   = arch.id_sin
					and    arch2.id_inter = arch.id_inter )
	and     arch.cod_version     	= 2
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )
END 


GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S06_ARCHIVE_SOLDAGE
-- Auteur               :       Fabry JF
-- Date                 :       25/06/99 11:27:57
-- Libellé              :       Select sur Archive. 
-- Commentaires         :       Select pour les DOSSIERS A SOLDER
--				Utilisation de UNION et non UNION ALL, car il ne faut surtout pas ramener en double les id_sin identiques.
-- Références           :       Utilisé dans W_RL_SP_RELANCES
--
-- Arguments            :       @dcIdProd       Decimal ( 7,0 )         (Val)  
--				@sAltRl2	VarChar ( 1   )		(Val)  // … 'O' le prod pr‚voit des 2Šmes Rel.
--				@sAltSoldRl	VarChar ( 1   )		(Val)  // … 'N' On ne solde pas les dossiers r‚cemment relanc‚s.
--                      :       @dtDateMaxSolRl Datetime 	        (Val)  // Date Max pour le soldage des dossiers ayant eu au moins une relance
--                      :       @dtDateMaxSolPc Datetime 	        (Val)  // Date Max pour le soldage obligatoire des "vieux" dossiers
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- [MIGPB8COR].PHG3	Fiche PHG_3.DOC : Le Chargement des dossiers à solder plante
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S06_ARCHIVE_SOLDAGE' AND type = 'P' )
        DROP procedure sysadm.DW_S06_ARCHIVE_SOLDAGE
GO

CREATE procedure sysadm.DW_S06_ARCHIVE_SOLDAGE
	@dcIdProd    	Decimal ( 7,0 ),
        @sAltRl2     	VarChar ( 1   ),
	@sAltSoldRl	VarChar ( 1   ),
	@dtDateMaxSolRl DateTime,
	@dtDateMaxSolPc DateTime
AS

-----------------------------------------------------------------
-- Le soldage est diff‚rent si le produit pr‚voit des 2Šmes    --
-- relances.						       --
-----------------------------------------------------------------
If @sAltRl2 = 'O' and @sAltSoldRl = 'O'
BEGIN

-----------------------------------------------------------------
-- CAS A : Le produit pr‚voit des 2Šme relances, donc on       --
-- s‚lectionne les dossiers ayant eu une deuxiŠme relance.     --
-- Ce courrier de deuxiŠme relance doit ˆtre le dernier envoy‚.--
-----------------------------------------------------------------
Create Table sysadm.#Tmp_Arch1
( id_sin	Decimal ( 10,0 ),  -- [PI062]
  max_maj_le	datetime       ,
  nom		VarChar ( 35  ),
  prenom	VarChar ( 35  ), 
  valide_le     datetime       ,
  valide_par    VarChar ( 4   )
)


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

-----------------------------------------------------------------
-- Cas B : S‚lection des dossiers dont la date de validation   --
-- est ant‚rieure … @dtDateMaxSolPc et qui n'ont jamais eu de  --
-- courriers.						       --
-----------------------------------------------------------------
Create Table sysadm.#Tmp_Arch2
( id_sin	Decimal ( 10,0 ),  -- [PI062]
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
( id_sin	Decimal ( 10,0 ),   -- [PI062]
  max_maj_le	Datetime       ,
  nom		VarChar ( 35  ),
  prenom	VarChar ( 35  ), 
  valide_le     Datetime       ,
  valide_par    VarChar ( 4   ))


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


-----------------------------------------------------------------
-- Select pour la DataWindow 				       --
-- En cas de doublon entre le CAS A et C, le Select Max les    --
-- se chargera de n'en garder qu'un.			       --
-----------------------------------------------------------------

-- CAS A
Select 	ID_SIN 		= #Tmp_Arch1.id_sin,
	PERS_NOM	= #Tmp_Arch1.nom,
	PERS_PRENOM	= #Tmp_Arch1.prenom,
	VALIDE_PAR	= #Tmp_Arch1.valide_par,
	VALIDE_LE	= #Tmp_Arch1.valide_le, 
	cast (null as varchar(20) ) as ETAT_TRT,	/* [MIGPB8COR].PHG3 */
	cast (null as varchar(10) ) as ARCH_CODE,	/* [MIGPB8COR].PHG3 */	
	cast (null as char(1) ) 	as ALT_PAPIER	/* [MIGPB8COR].PHG3 */
From 	sysadm.#Tmp_Arch1
Where   #Tmp_Arch1.max_maj_le = ( Select  max ( arch.maj_le )
			  	  From    sysadm.archive arch
			  	  Where   arch.id_sin = #Tmp_Arch1.id_sin )

UNION ALL

-- CAS B
Select 	ID_SIN 		= #Tmp_Arch2.id_sin,
	PERS_NOM	= pers.nom,
	PERS_PRENOM	= pers.prenom,
	VALIDE_PAR	= #Tmp_Arch2.valide_par,
	VALIDE_LE	= #Tmp_Arch2.valide_le, 
	cast (null as varchar(20) ) as ETAT_TRT,	/* [MIGPB8COR].PHG3 */
	cast (null as varchar(10) ) as ARCH_CODE,	/* [MIGPB8COR].PHG3 */	
	cast (null as char(1) ) 	as ALT_PAPIER	/* [MIGPB8COR].PHG3 */


From 	sysadm.#Tmp_Arch2,
	sysadm.routage  	rout,
	sysadm.personne		pers

where	rout.id_sin		= #Tmp_Arch2.id_sin
and     rout.alt_queue		= 'N'
and     pers.id_ordre		= #Tmp_Arch2.id_ordre


UNION ALL

-- CAS C
Select 	ID_SIN 		= #Tmp_Arch3.id_sin,
	PERS_NOM	= #Tmp_Arch3.nom,
	PERS_PRENOM	= #Tmp_Arch3.prenom,
	VALIDE_PAR	= #Tmp_Arch3.valide_par,
	VALIDE_LE	= #Tmp_Arch3.valide_le, 
	cast (null as varchar(20) ) as ETAT_TRT,	/* [MIGPB8COR].PHG3 */
	cast (null as varchar(10) ) as ARCH_CODE,	/* [MIGPB8COR].PHG3 */	
	cast (null as char(1) ) 	as ALT_PAPIER	/* [MIGPB8COR].PHG3 */


From 	sysadm.#Tmp_Arch3
Where   #Tmp_Arch3.max_maj_le = ( Select  max ( arch.maj_le )
			  	  From    sysadm.archive arch
			  	  Where   arch.id_sin = #Tmp_Arch3.id_sin )


Drop Table sysadm.#Tmp_Arch1
Drop Table sysadm.#Tmp_Arch2
Drop Table sysadm.#Tmp_Arch3


END



IF @sAltRl2 = 'N' and @sAltSoldRl = 'O'
BEGIN
-----------------------------------------------------------------
-- CAS A : Le produit ne pr‚voit pas de 2Šme relances, donc on --
-- s‚lectionne les dossiers ayant eu une relance quelconque    --
-- Ce courrier de relance doit ˆtre le dernier envoy‚.	       --
-----------------------------------------------------------------
Create Table sysadm.#Tmp_Arch4
( id_sin	Decimal ( 10,0 ),  -- [PI062]
  max_maj_le	Datetime       ,
  nom		VarChar ( 35  ),
  prenom	VarChar ( 35  ), 
  valide_le     Datetime       ,
  valide_par    VarChar ( 4   ))


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


-----------------------------------------------------------------
-- Cas B : S‚lection des dossiers dont la date de validation   --
-- est ant‚rieure … @dtDateMaxSolPc et qui n'ont jamais eu de  --
-- courriers.						       --
-----------------------------------------------------------------
Create Table sysadm.#Tmp_Arch5
( id_sin	Decimal ( 10,0 ),  -- [PI062]
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
( id_sin	Decimal ( 10,0 ),  -- [PI062]
  max_maj_le	Datetime       ,
  nom		VarChar ( 35  ),
  prenom	VarChar ( 35  ), 
  valide_le     Datetime       ,
  valide_par    VarChar ( 4   ))


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


-----------------------------------------------------------------
-- Select pour la DataWindow 				       --
-----------------------------------------------------------------

-- CAS A
Select 	ID_SIN 		= #Tmp_Arch4.id_sin,
	PERS_NOM	= #Tmp_Arch4.nom,
	PERS_PRENOM	= #Tmp_Arch4.prenom,
	VALIDE_PAR	= #Tmp_Arch4.valide_par,
	VALIDE_LE	= #Tmp_Arch4.valide_le, 
	cast (null as varchar(20) ) as ETAT_TRT,	/* [MIGPB8COR].PHG3 */
	cast (null as varchar(10) ) as ARCH_CODE,	/* [MIGPB8COR].PHG3 */	
	cast (null as char(1) ) 	as ALT_PAPIER	/* [MIGPB8COR].PHG3 */


From 	sysadm.#Tmp_Arch4
Where   #Tmp_Arch4.max_maj_le = ( Select  max ( arch.maj_le )
			  	  From    sysadm.archive arch
			  	  Where   arch.id_sin = #Tmp_Arch4.id_sin )


UNION ALL

-- CAS B
Select 	ID_SIN 		= #Tmp_Arch5.id_sin,
	PERS_NOM	= pers.nom,
	PERS_PRENOM	= pers.prenom,
	VALIDE_PAR	= #Tmp_Arch5.valide_par,
	VALIDE_LE	= #Tmp_Arch5.valide_le, 
	cast (null as varchar(20) ) as ETAT_TRT,	/* [MIGPB8COR].PHG3 */
	cast (null as varchar(10) ) as ARCH_CODE,	/* [MIGPB8COR].PHG3 */	
	cast (null as char(1) ) 	as ALT_PAPIER	/* [MIGPB8COR].PHG3 */

From 	sysadm.#Tmp_Arch5,
	sysadm.routage  	rout,
	sysadm.personne		pers

where	rout.id_sin		= #Tmp_Arch5.id_sin
and     rout.alt_queue		= 'N'
and     pers.id_ordre		= #Tmp_Arch5.id_ordre


UNION ALL

-- CAS C
Select 	ID_SIN 		= #Tmp_Arch6.id_sin,
	PERS_NOM	= #Tmp_Arch6.nom,
	PERS_PRENOM	= #Tmp_Arch6.prenom,
	VALIDE_PAR	= #Tmp_Arch6.valide_par,
	VALIDE_LE	= #Tmp_Arch6.valide_le, 
	cast (null as varchar(20) ) as ETAT_TRT,	/* [MIGPB8COR].PHG3 */
	cast (null as varchar(10) ) as ARCH_CODE,	/* [MIGPB8COR].PHG3 */	
	cast (null as char(1) ) 	as ALT_PAPIER	/* [MIGPB8COR].PHG3 */

From 	sysadm.#Tmp_Arch6
where   #Tmp_Arch6.max_maj_le = ( Select  max ( arch.maj_le )
			  	  From    sysadm.archive arch
			  	  Where   arch.id_sin = #Tmp_Arch6.id_sin )


Drop Table sysadm.#Tmp_Arch4
Drop Table sysadm.#Tmp_Arch5
Drop Table sysadm.#Tmp_Arch6




END



IF @sAltSoldRl = 'N'
BEGIN

-----------------------------------------------------------------
-- Le produit ne pr‚voit pas de soldage des dossiers r‚cemment --
-- relanc‚s.						       --
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Pas de CAS A, Pas de table sysadm.#Tmp_Arch		       --
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Cas B : S‚lection des dossiers dont la date de validation   --
-- est ant‚rieure … @dtDateMaxSolPc et qui n'ont jamais eu de  --
-- courriers.						       --
-----------------------------------------------------------------

/*
JFF Le 19/05/2002 : Problème pour le soldage des dossiers de
telephonie, explication ci-dessous.
Je supprime ce critère de l'insertion dans #Tmp_Arch7

and     not exists ( Select arch.id_sin
		     From   sysadm.archive arch
		     where  arch.id_sin = sin.id_sin )
*/


Create Table sysadm.#Tmp_Arch7
( id_sin	Decimal ( 10,0 ),  -- [PI062]
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
-- CAS C : S‚lection des dossiers dont la date de d'edition du --
-- dernier courrier quel qu'il soit, est ant‚rieure … 	       --
-- @dtDateMaxSolPc  					       --
-----------------------------------------------------------------

/*
JFF Le 19/05/2002 : Problème pour le soldage des dossiers de
telephonie. Je shunte l'insertion dans #Tmp_Arch8, en effet je n'en
vois plus l interet aujourdhui et cela pose des problemes sur les dossiers
de telephonie qui sont valide apres 6 mois sans qu aucun nouveau courrier 
ne soit envoye.
ex : courrier 27/10/2002, validation le 15/05/2003
selon les critères le dossier était solde alors qu'il ne doit pas l'être.

Create Table sysadm.#Tmp_Arch8
( id_sin	Decimal ( 7,0 ),
  max_maj_le	Datetime       ,
  nom		VarChar ( 35  ),
  prenom	VarChar ( 35  ), 
  valide_le     Datetime       ,
  valide_par    VarChar ( 4   ))


Insert  Into sysadm.#Tmp_Arch8
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
and     rout.id_sin		= sin.id_sin
and     rout.alt_queue		= 'N'
and     pers.id_ordre		= sin.id_ordre

group by sin.id_sin, pers.nom, pers.prenom, sin.valide_le, sin.valide_par
having  Max ( arch.maj_le )	<= @dtDateMaxSolPc

*/

-----------------------------------------------------------------
-- Select pour la DataWindow 				       --
-----------------------------------------------------------------

-- CAS B
Select 	ID_SIN 		= #Tmp_Arch7.id_sin,
	PERS_NOM	= pers.nom,
	PERS_PRENOM	= pers.prenom,
	VALIDE_PAR	= #Tmp_Arch7.valide_par,
	VALIDE_LE	= #Tmp_Arch7.valide_le, 
	cast (null as varchar(20) )	as ETAT_TRT,	/* [MIGPB8COR].PHG3 */
	cast (null as varchar(10) )	as ARCH_CODE,	/* [MIGPB8COR].PHG3 */	
	cast (null as char(1) )		as ALT_PAPIER	/* [MIGPB8COR].PHG3 */

From 	sysadm.#Tmp_Arch7,
	sysadm.routage  	rout,
	sysadm.personne		pers

where	rout.id_sin		= #Tmp_Arch7.id_sin
and     rout.alt_queue		= 'N'
and     pers.id_ordre		= #Tmp_Arch7.id_ordre

/*
JFF Le 19/05/2002 

UNION ALL

-- CAS C
Select 	ID_SIN 		= #Tmp_Arch8.id_sin,
	PERS_NOM	= #Tmp_Arch8.nom,
	PERS_PRENOM	= #Tmp_Arch8.prenom,
	VALIDE_PAR	= #Tmp_Arch8.valide_par,
	VALIDE_LE	= #Tmp_Arch8.valide_le

From 	sysadm.#Tmp_Arch8
*/

Drop Table sysadm.#Tmp_Arch7

/*
JFF Le 19/05/2002 
Drop Table sysadm.#Tmp_Arch8
*/

END

GO



--------------------------------------------------------------------
--
-- Procédure            :       PS_D01_ARCHIVE_SOLDAGE
-- Auteur               :       Fabry JF
-- Date                 :       25/06/99 11:27:57
-- Libellé              :       Select sur Archive. 
-- Commentaires         :       SOLDAGE DES DOSSIERS
-- Références           :       Utilisé dans W_RL_SP_RELANCES
--
-- Arguments            :       @dcIdSin	Decimal ( 7,0 ),
--				@sCodOper	Varchar ( 1   )
--				@dtDateDuJour	DateTime
--				@sAltQueue	VarChar ( 1   ) OUTPUT
--                              @sNoBoite       VarChar ( 10  )
--
-- Retourne             :       Rien
-- Le 11/06/2003   JFF  :  Je supprime l'écrasement du valide_le, valide_par, maj_le, maj_par,
--			   en effet pour le futur projet d'archivage, on doit pouvoir retrouver
--			   le dossier solder le dernier gestionnaire l'ayant validé.
--
-- Le 09/09/2003   DGA  : Ajout du paramètre @sNoBoite pour la gestion des boites archives.
--
-- JFF  31/08/2011  Shunt de l'insertion dans WKFS_w_wqueue
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_D01_ARCHIVE_SOLDAGE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_D01_ARCHIVE_SOLDAGE]
GO

CREATE procedure sysadm.PS_D01_ARCHIVE_SOLDAGE
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
			cod_mot_ssui  	= 90,
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
			cod_mot_ssui  	= 90,
			alt_ssui	= 'O',
			valide_le	= @dtDateDuJour,
			valide_par	= @sCodOper
		From	sysadm.gar_sin gar
		Where  	gar.id_sin	= @dcIdSin
		and 	gar.cod_etat	= 100
		and     Not Exists ( Select det.id_sin
				     From   sysadm.detail det,
						sysadm.refus r
					Where  det.id_sin   = gar.id_sin
					and    det.id_gti   = gar.id_gti 	
					and    r.id_sin     = det.id_sin
					and    r.id_gti     = det.id_gti
					and    r.id_detail  = det.id_detail
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
				 From   sysadm.detail det,
					sysadm.refus r
				 Where  det.id_sin   = gar.id_sin
				 and    det.id_gti   = gar.id_gti 	
				 and    r.id_sin     = det.id_sin
				 and    r.id_gti     = det.id_gti
				 and    r.id_detail  = det.id_detail
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
			cod_mot_ssui  	= 90,
			alt_ssui	= 'O',
			valide_le	= @dtDateDuJour,
			valide_par	= @sCodOper
		From	sysadm.sinistre sin
		Where  	sin.id_sin	= @dcIdSin
		and 	sin.cod_etat	= 100
		and     Not Exists ( Select gar.id_sin
				     From   sysadm.gar_sin gar,
						sysadm.refus r
				     Where  gar.id_sin   = sin.id_sin
					 And	r.id_sin     = gar.id_sin
					 And	r.id_gti     = gar.id_gti
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
				 From   sysadm.gar_sin gar,
						sysadm.refus r
				     Where  gar.id_sin   = sin.id_sin
					 And	r.id_sin     = gar.id_sin
					 And	r.id_gti     = gar.id_gti
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
				
		/*------------------------------------------------------------------*/                
		/* On insére une ligne dans la table wkfs_w_queue.                  */
		/*------------------------------------------------------------------*/
				-- # DCMP 60691 # - Ajout d'un controle dans le cas de purge de la file d'attente non effectuée
/*
				IF @iCountWkfs = 0
					BEGIN

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
								2,
								@dtDateDuJour,
								@sArchivePar,
								@dtDateDuJour,
								@dtDateDuJour,
								@sArchivePar,
								@sValideParSin,
								@dtValideLeSin
						FROM            sysadm.sinistre
						WHERE           sinistre.id_sin = @dcIdSin
		
						-- DCMP 60691
						IF @@ERROR <> 0 GOTO ONERROR
					END
*/					
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

grant execute on sysadm.PS_D01_ARCHIVE_SOLDAGE to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            :       DW_S07_ARCHIVE_RELANCES
-- Auteur               :       Fabry JF
-- Date                 :       11/06/99 11:27:57
-- Libellé              :       Select sur Archive. 
-- Commentaires         :       DCMP 000285 Brigitte Levesque.
--				Selection identique au premiŠres relance autot S01 mais 
--				que pour les demandes de piŠces … la banque et pour les Gti UF
-- Références           :       Utilisé dans W_RL_SP_RELANCES
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--                      :       @dtDateMin      Datetime 	        (Val)
--                      :       @dtDateMax      DateTime		(Val)
--
-- Retourne             :       Rien
--
-- JFF      22/08/2022   [RS3179]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S07_ARCHIVE_RELANCES' AND type = 'P' )
        DROP procedure sysadm.DW_S07_ARCHIVE_RELANCES
GO


CREATE procedure sysadm.DW_S07_ARCHIVE_RELANCES
      @dcIdProd       Decimal (7,0),
      @dtDateMin      Datetime,
      @dtDateMax      DateTime		
AS


Declare @sCodAdh	VarChar ( 1 )


Select @sCodAdh	= produit.cod_adh
From   sysadm.produit
Where  produit.id_prod = @dcIdProd

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN

	-- Adh par carte
	If @sCodAdh = '3' 

	BEGIN

	-- PremiŠre requˆte en regardant les piŠces coch‚s.
	select 
 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp,
		TRI		= Case arch.IsNull ( arch.id_cour_orig, arch.id_cour )
					When 'APART1' THEN 2
					Else 1
				  End


	From 	sysadm.sinistre 	sin with (nolock),
		sysadm.w_piece		wp with (nolock),
		sysadm.archive  	arch with (nolock),
		sysadm.inter		int with (nolock),
		sysadm.inter		intass with (nolock),
		sysadm.personne 	pers with (nolock),
		sysadm.produit		prod with (nolock),
		sysadm.groupe		grp with (nolock),
		sysadm.routage		rout with (nolock)


	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	 in ( 100, 550 )
	and    	sin.valide_le 		= arch.valide_le
	and     
	(
	  (
		(
		( Substring ( arch.id_cour_orig, 1, 2 ) = 'BC' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or arch.id_cour_orig = 'APART1' 
		) And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		(
		( Substring ( arch.id_cour, 1, 2 ) = 'BC' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour, 1, 1 ) = 'Q' Or arch.id_cour = 'APART1' 
		) And arch.id_cour_orig is null
	  )
	)

	and     arch.valide_le between @dtDateMin and @dtDateMax
	and     arch.cod_version     	= 2
	and	arch.cod_inter		= 'B'
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and	wp.id_sin		= sin.id_sin
	and	wp.id_gti		= 7
	and	wp.id_i			= int.id_i
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	grp.id_grp		= sin.id_ets
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )
	UNION ALL

	-- DeuxiŠme requˆte en regardant ALT_ATT coch‚.
	select 
 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp,
		TRI		= Case IsNull ( arch.id_cour_orig, arch.id_cour )
					When 'APART1' THEN 2
					Else 1
				  End


	From 	sysadm.sinistre 	sin with (nolock),
		sysadm.w_gar_sin	wg with (nolock),
		sysadm.archive  	arch with (nolock),
		sysadm.inter		int with (nolock),
		sysadm.inter		intass with (nolock),
		sysadm.personne 	pers with (nolock),
		sysadm.produit		prod with (nolock),
		sysadm.groupe		grp with (nolock),
		sysadm.routage		rout with (nolock)


	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	 in ( 100, 550 )
	and    	sin.valide_le 		= arch.valide_le
	and     
	(
	  (
		(
		( Substring ( arch.id_cour_orig, 1, 2 ) = 'BC' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or arch.id_cour_orig = 'APART1' 
		) And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		(
		( Substring ( arch.id_cour, 1, 2 ) = 'BC' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour, 1, 1 ) = 'Q' Or arch.id_cour = 'APART1' 
		) And arch.id_cour_orig is null
	  )
	)

	and     arch.valide_le between @dtDateMin and @dtDateMax
	and     arch.cod_version     	= 2
	and	arch.cod_inter		= 'B'
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and	wg.id_sin		= sin.id_sin
	and	wg.id_gti		= 7
	and	wg.alt_att		= 'O' 
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	grp.id_grp		= sin.id_ets
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )

	END

	-- Adh‚sion SPB
	ELSE

	BEGIN

	-- PremiŠre requˆte en regardant les piŠces coch‚s.

	select 

 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp,
		TRI		= Case IsNull ( arch.id_cour_orig, arch.id_cour )
					When 'APART1' THEN 2
					Else 1
				  End


	From 	sysadm.sinistre 	sin with (nolock),
		sysadm.w_piece		wp with (nolock),
		sysadm.archive  	arch with (nolock),
		sysadm.inter		int with (nolock),
		sysadm.inter		intass with (nolock),
		sysadm.personne 	pers with (nolock),
		sysadm.produit		prod with (nolock),
		sysadm.groupe		grp with (nolock),
		sysadm.etablissement	eta with (nolock),
		sysadm.routage		rout with (nolock)


	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	 in ( 100, 550 )
	and    	sin.valide_le 		= arch.valide_le
	and     
	(
	  (
		(
		( Substring ( arch.id_cour_orig, 1, 2 ) = 'BC' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or arch.id_cour_orig = 'APART1' 
		) And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		(
		( Substring ( arch.id_cour, 1, 2 ) = 'BC' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour, 1, 1 ) = 'Q' Or arch.id_cour = 'APART1' 
		) And arch.id_cour_orig is null
	  )
	)

	and     arch.valide_le between @dtDateMin and @dtDateMax
	and     arch.cod_version     	= 2
	and	arch.cod_inter		= 'B'
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and	wp.id_sin		= sin.id_sin
	and	wp.id_gti		= 7
	and	wp.id_i			= int.id_i
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	eta.id_prod   		= sin.id_prod
	and	eta.id_ets  		= sin.id_ets
	and	eta.id_grp  		= grp.id_grp
	and	eta.id_rev    		= -1
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )

	UNION ALL

	-- DeuxiŠme requˆte en regardant ALT_ATT coch‚.
	select 

 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp,
		TRI		= Case IsNull ( arch.id_cour_orig, arch.id_cour )
					When 'APART1' THEN 2
					Else 1
				  End


	From 	sysadm.sinistre 	sin with (nolock),
		sysadm.w_gar_sin	wg with (nolock),
		sysadm.archive  	arch with (nolock),
		sysadm.inter		int with (nolock),
		sysadm.inter		intass with (nolock),
		sysadm.personne 	pers with (nolock),
		sysadm.produit		prod with (nolock),
		sysadm.groupe		grp with (nolock),
		sysadm.etablissement	eta with (nolock),
		sysadm.routage		rout with (nolock)


	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	 in ( 100, 550 )
	and    	sin.valide_le 		= arch.valide_le
	and     
	(
	  (
		(
		( Substring ( arch.id_cour_orig, 1, 2 ) = 'BC' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or arch.id_cour_orig = 'APART1'
		) And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		(
		( Substring ( arch.id_cour, 1, 2 ) = 'BC' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour, 1, 1 ) = 'Q' Or arch.id_cour = 'APART1'
		) And arch.id_cour_orig is null
	  )
	)

	and     arch.valide_le between @dtDateMin and @dtDateMax
	and     arch.cod_version     	= 2
	and	arch.cod_inter		= 'B'
	and     arch.nbr_conf         	= 0
	and     arch.id_sin    	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and	wg.id_sin		= sin.id_sin
	and	wg.id_gti		= 7
	and	wg.alt_att		= 'O' 
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	eta.id_prod   		= sin.id_prod
	and	eta.id_ets  		= sin.id_ets
	and	eta.id_grp  		= grp.id_grp
	and	eta.id_rev    		= -1
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )
	END
END 

ELSE

BEGIN
	-- Adh par carte
	If @sCodAdh = '3' 

	BEGIN

	-- PremiŠre requˆte en regardant les piŠces coch‚s.
	select 
 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp,
		TRI		= Case arch.IsNull ( arch.id_cour_orig, arch.id_cour )
					When 'APART1' THEN 2
					Else 1
				  End


	From 	sysadm.sinistre 	sin with (nolock),
		sysadm.w_piece		wp with (nolock),
		sysadm.archive  	arch with (nolock),
		sysadm.inter		int with (nolock),
		sysadm.inter		intass with (nolock),
		sysadm.personne 	pers with (nolock),
		sysadm.produit		prod with (nolock),
		sysadm.groupe		grp with (nolock),
		sysadm.routage		rout with (nolock)


	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	 in ( 100, 550 )
	and    	sin.valide_le 		= arch.valide_le
	and     
	(
	  (
		(
		( Substring ( arch.id_cour_orig, 1, 2 ) = 'BC' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or arch.id_cour_orig = 'APART1' 
		) And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		(
		( Substring ( arch.id_cour, 1, 2 ) = 'BC' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour, 1, 1 ) = 'Q' Or arch.id_cour = 'APART1' 
		) And arch.id_cour_orig is null
	  )
	)

	and     arch.valide_le between @dtDateMin and @dtDateMax
	and     arch.cod_version     	= 2
	and	arch.cod_inter		= 'B'
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and	wp.id_sin		= sin.id_sin
	and	wp.id_gti		= 7
	and	wp.id_i			= int.id_i
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	grp.id_grp		= sin.id_ets
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )

	UNION ALL

	-- DeuxiŠme requˆte en regardant ALT_ATT coch‚.
	select 
 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp,
		TRI		= Case IsNull ( arch.id_cour_orig, arch.id_cour )
					When 'APART1' THEN 2
					Else 1
				  End


	From 	sysadm.sinistre 	sin with (nolock),
		sysadm.w_gar_sin	wg with (nolock),
		sysadm.archive  	arch with (nolock),
		sysadm.inter		int with (nolock),
		sysadm.inter		intass with (nolock),
		sysadm.personne 	pers with (nolock),
		sysadm.produit		prod with (nolock),
		sysadm.groupe		grp with (nolock),
		sysadm.routage		rout with (nolock)


	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	 in ( 100, 550 )
	and    	sin.valide_le 		= arch.valide_le
	and     
	(
	  (
		(
		( Substring ( arch.id_cour_orig, 1, 2 ) = 'BC' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or arch.id_cour_orig = 'APART1' 
		) And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		(
		( Substring ( arch.id_cour, 1, 2 ) = 'BC' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour, 1, 1 ) = 'Q' Or arch.id_cour = 'APART1' 
		) And arch.id_cour_orig is null
	  )
	)

	and     arch.valide_le between @dtDateMin and @dtDateMax
	and     arch.cod_version     	= 2
	and	arch.cod_inter		= 'B'
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and	wg.id_sin		= sin.id_sin
	and	wg.id_gti		= 7
	and	wg.alt_att		= 'O' 
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	grp.id_grp		= sin.id_ets
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )

	END

	-- Adh‚sion SPB
	ELSE

	BEGIN

	-- PremiŠre requˆte en regardant les piŠces coch‚s.

	select 

 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp,
		TRI		= Case IsNull ( arch.id_cour_orig, arch.id_cour )
					When 'APART1' THEN 2
					Else 1
				  End


	From 	sysadm.sinistre 	sin with (nolock),
		sysadm.w_piece		wp with (nolock),
		sysadm.archive  	arch with (nolock),
		sysadm.inter		int with (nolock),
		sysadm.inter		intass with (nolock),
		sysadm.personne 	pers with (nolock),
		sysadm.produit		prod with (nolock),
		sysadm.groupe		grp with (nolock),
		sysadm.etablissement	eta with (nolock),
		sysadm.routage		rout with (nolock)


	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	 in ( 100, 550 )
	and    	sin.valide_le 		= arch.valide_le
	and     
	(
	  (
		(
		( Substring ( arch.id_cour_orig, 1, 2 ) = 'BC' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or arch.id_cour_orig = 'APART1' 
		) And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		(
		( Substring ( arch.id_cour, 1, 2 ) = 'BC' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour, 1, 1 ) = 'Q' Or arch.id_cour = 'APART1' 
		) And arch.id_cour_orig is null
	  )
	)

	and     arch.valide_le between @dtDateMin and @dtDateMax
	and     arch.cod_version     	= 2
	and	arch.cod_inter		= 'B'
	and     arch.nbr_conf         	= 0
	and     arch.id_sin           	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and	wp.id_sin		= sin.id_sin
	and	wp.id_gti		= 7
	and	wp.id_i			= int.id_i
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	eta.id_prod   		= sin.id_prod
	and	eta.id_ets  		= sin.id_ets
	and	eta.id_grp  		= grp.id_grp
	and	eta.id_rev    		= -1
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )

	UNION ALL

	-- DeuxiŠme requˆte en regardant ALT_ATT coch‚.
	select 

 		ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
       		NOM_INTER	= int.nom,		
       		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
       		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
       		INT_ADR2	= int.adr_2,
       		INT_ADR_CP	= int.adr_cp,
       		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
       		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= intass.rib_bq,
		INTASS_RIB_CLE	= intass.rib_cle,
		INTASS_RIB_CPT	= intass.rib_cpt,
		INTASS_RIB_GUI	= intass.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
       		ID_ADH		= sin.id_adh,
      		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp,
		TRI		= Case IsNull ( arch.id_cour_orig, arch.id_cour )
					When 'APART1' THEN 2
					Else 1
				  End


	From 	sysadm.sinistre 	sin with (nolock),
		sysadm.w_gar_sin	wg with (nolock),
		sysadm.archive  	arch with (nolock),
		sysadm.inter		int with (nolock),
		sysadm.inter		intass with (nolock),
		sysadm.personne 	pers with (nolock),
		sysadm.produit		prod with (nolock),
		sysadm.groupe		grp with (nolock),
		sysadm.etablissement	eta with (nolock),
		sysadm.routage		rout with (nolock)


	Where	sin.id_prod   		= @dcIdProd
	and     rout.id_sin		= sin.id_sin
	and     rout.alt_queue		= 'N'
	and	sin.id_sin 		= arch.id_sin
	and    	sin.cod_etat      	 in ( 100, 550 )
	and    	sin.valide_le 		= arch.valide_le
	and     
	(
	  (
		(
		( Substring ( arch.id_cour_orig, 1, 2 ) = 'BC' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or arch.id_cour_orig = 'APART1'
		) And arch.id_cour_orig is not null
	  ) 
	 OR
	  (
		(
		( Substring ( arch.id_cour, 1, 2 ) = 'BC' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour, 1, 1 ) = 'Q' Or arch.id_cour = 'APART1'
		) And arch.id_cour_orig is null
	  )
	)

	and     arch.valide_le between @dtDateMin and @dtDateMax
	and     arch.cod_version     	= 2
	and	arch.cod_inter		= 'B'
	and     arch.nbr_conf         	= 0
	and     arch.id_sin    	= int.id_sin
	and     arch.id_inter         	= int.id_i
	and	wg.id_sin		= sin.id_sin
	and	wg.id_gti		= 7
	and	wg.alt_att		= 'O' 
	and 	intass.id_sin		= arch.id_sin
	and 	intass.cod_inter	= 'A'
	and 	pers.id_ordre		= sin.id_ordre
	and	prod.id_prod		= sin.id_prod
	and	eta.id_prod   		= sin.id_prod
	and	eta.id_ets  		= sin.id_ets
	and	eta.id_grp  		= grp.id_grp
	and	eta.id_rev    		= -1
	And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
	      Or 
		  ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
        )

	END
END 

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_ARCHIVE_VAL_SVE
-- Auteur               :       Fabry JF
-- Date                 :       30/03/04 11:27:57
-- Libellé              :       Insertion dans la table ARCHIVE 
-- Commentaires         :       Nouvelle procédure pour la SVE
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdI          Decimal (  7,0 )        (Val)
--                      :       @dcIdCpt        Decimal (  4,0 )        (Val)
--                      :       @dcIdDoc        Decimal (  7,0 )        (Val)
--                      :       @dcIdOrdre      Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--				@iCptArch	Integer                 (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-- #1	PHG	03/11/2006	[DNTMAIL1-2] On enregistre le media ( Id_Canal )
--      JFF 12/06/2014  [PI052]
--      JFF 12/02/2016  [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_ARCHIVE_VAL_SVE' AND type = 'P' )
        DROP procedure sysadm.PS_I01_ARCHIVE_VAL_SVE
GO

CREATE procedure sysadm.PS_I01_ARCHIVE_VAL_SVE
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @dcIdI          Decimal (  7,0 ),
        @dcIdCpt        Decimal (  4,0 ),
        @dcIdDoc        Decimal (  7,0 ),
        @dcIdOrdre      Decimal (  7,0 ),
        @sCodOper       Varchar (  4   ),
	@dtValideLe 	DateTime	,  
        @iCptArch	Integer
AS

Declare @iRowCount Integer -- [PI052]

 INSERT INTO    sysadm.archive
        (       archive.id_sin,
                archive.id_inter,
                archive.id_doc,
                archive.id_cour,
                archive.id_prod,
                archive.id_ordre,
                archive.id_adh,
                archive.cod_version,
                archive.cod_inter,
                archive.nom,
                archive.dte_edit,
                archive.dte_conf,
                archive.dte_archiv,
                archive.dte_rep,
                archive.alt_part,
                archive.alt_pce,
                archive.alt_ps,
                archive.alt_rep,
                archive.txt_compo1,
                archive.txt_compo2,
                archive.ref_doc_dt,
                archive.ref_doc_cp,
                archive.ref_doc_pc,
                archive.ref_doc_ps,
                archive.nbr_conf,
                archive.cree_le,
                archive.maj_le,
                archive.maj_par,
                archive.valide_le,
                archive.valide_par,
                archive.id_arch,
                archive.id_cour_orig,
		archive.id_canal,	-- #1 PHG 03/11/2006 [DNTMAIL1-2] On enregistre le media ( Id_Canal )
		archive.envoi_mail_le	-- #1 PHG 03/11/2006 [DNTMAIL1-2] On enregistre le media ( Id_Canal )
	)
 SELECT         w_courrier.id_sin,
                w_courrier.id_i,
                @dcIdDoc,
                w_courrier.id_cour,
                w_sin.id_prod,
                @dcIdOrdre,
                w_sin.id_adh,
                2,
                w_inter.cod_inter,
                w_inter.nom,
                '01/01/1900',
                NULL,
                NULL,
                NULL,
                w_courrier.alt_part,
                w_courrier.alt_pce,
                w_courrier.alt_ps,
                'N',
                w_courrier.txt_compo1,
                w_courrier.txt_compo2,
                NULL,
                NULL,
                NULL,
                NULL,
                0,
                w_courrier.cree_le,
                w_courrier.maj_le,
                w_courrier.maj_par,
                @dtValideLe,
                @sCodOper,
                @iCptArch,
                w_courrier.id_cour_orig,
		w_courrier.id_canal,	-- #1 PHG 03/11/2006 [DNTMAIL1-2] On enregistre le media ( Id_Canal )
		NULL			-- #1 PHG 03/11/2006 [DNTMAIL1-2] On enregistre le media ( Id_Canal )
 FROM           sysadm.w_sin,
                sysadm.w_courrier,
                sysadm.w_inter,
                sysadm.w_queue
 WHERE          w_sin.id_sin            = @dcIdSin              AND
                w_sin.id_sin            = w_courrier.id_sin     AND
                w_sin.id_sin            = w_inter.id_sin        AND
                w_courrier.id_i         = @dcIdI                AND
                w_courrier.id_cpt       = @dcIdCpt              AND
                w_courrier.id_i         = w_inter.id_i          AND
                w_queue.id_sin  = Convert ( VarChar(10), w_sin.id_sin ) -- [PI062]

Set @iRowCount = @@RowCount

 -- [PI052]
If sysadm.FN_CLE_NUMERIQUE ( 'PI052') > 0 
 Begin
	Insert into sysadm.w_cour_blob_arch_ksl
	Select @iCptArch,
		   @dcIdSin,
		   @dcIdI,
		   'PDF',
		   wc.txt_compo2,
		   'NORMAL',
		   null,
		   wc.cree_le,
		   wc.maj_le,
		   wc.maj_par,
		   @dtValideLe,
		   @sCodOper
	From sysadm.w_courrier wc
	Where wc.id_sin = @dcIdSin
	And   wc.id_i   = @dcIdI                
	And   wc.id_cpt = @dcIdCpt
	And   wc.alt_ps = 'P' -- Indique que c'est un PDF
	
	Insert into sysadm.w_cour_blob_arch_ksl
	Select @iCptArch,
		   @dcIdSin,
		   @dcIdI,
		   'DOC',
		   wc.txt_compo2,
		   'NORMAL',
		   null,
		   wc.cree_le,
		   wc.maj_le,
		   wc.maj_par,
		   @dtValideLe,
		   @sCodOper
	From sysadm.w_courrier wc
	Where wc.id_sin = @dcIdSin
	And   wc.id_i   = @dcIdI                
	And   wc.id_cpt = @dcIdCpt
	And   wc.alt_ps = 'D' -- Indique que c'est un Doc
	
 End 

 Return @iRowCount

GO


--------------------------------------------------------------------
--
-- Procédure            :       IM_CUR_ARCHIVE_VAL_SVE
-- Auteur               :       FABRY JF
-- Date                 :       30/03/04 11:27:57
-- Libellé              :       Insertion dans la table ARCHIVE et W_COUR_BLOB_ARCH 
-- Commentaires         :       Nouvelle procédure pour la SVE
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdOrdre      Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-- #1	PHG	02/11/2006	[DNTMAIL1-2] On enregistre le media ( Id_Canal )
--      JFF     21/10/2011      [ITSM85146]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_CUR_ARCHIVE_VAL_SVE' AND type = 'P' )
        DROP procedure sysadm.IM_CUR_ARCHIVE_VAL_SVE
GO

CREATE procedure sysadm.IM_CUR_ARCHIVE_VAL_SVE
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @dcIdOrdre      Decimal (  7,0 ),
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

Declare @dcIdI          Decimal ( 7,0 )
Declare @dcIdDoc        Decimal ( 7,0 )
Declare @dcIdCpt        Decimal ( 4,0 )
Declare @iRet           Integer
Declare @iCptArch       Integer
Declare @sIdCanal	Varchar( 2 ) 	-- #1 [DNTMAIL1-2] PHG 02/11/2006 
Declare @sRet		Varchar ( 255)	-- #1 [DNTMAIL1-2] PHG 02/11/2006 
/*
Attention, il est possible que le dossier vienne directement de la saisie.
Il n'y a donc aucun courrier a éditer.
IMPORTANT : On n'archive pas les courriers DOUBLES. ( ID_I_DB = NULL )
J'utilise des valeurs de retour (iRet) diff‚rentes afin de savoir ou se situe
l'erreur, et cela sans avoir … r‚armer sProc.
0  -> Aucun courrier … valider.
-1 -> Erreur d'insertion sur ARCHIVE
-2 -> Erreur d'insertion sur W_COUR_BLOB_ARCH
-3 -> Erreur de mise … jour sur W_INTER
-4 -> Erreur de mise … jour sur INTER
-- #1 [DNTMAIL1-2] PHG 02/11/2006 5.2.6.2 : Simulation d'edition
-5 -> Erreur de simulaton d'edition si canal = 'MA' (Maj de la table archive et transfert de w_cour_blob_arch --> Archive_Blob)
*/

DECLARE cur1    CURSOR FOR
 SELECT w_courrier.id_i,
        w_courrier.id_cpt,
	w_courrier.id_canal -- #1 [DNTMAIL1-2] PHG 02/11/2006 On enregistre le media ( Id_Canal )
 FROM   sysadm.w_courrier
 WHERE  w_courrier.id_sin = @dcIdSin            AND
        w_courrier.id_i_db is NULL
 ORDER BY       w_courrier.id_i,
                w_courrier.id_cpt

 Select @iRet = 0

 OPEN   cur1

 FETCH  cur1 INTO
        @dcIdI,
        @dcIdCpt,
	@sIdCanal -- #1 [DNTMAIL1-2] PHG 02/11/2006 On enregistre le media ( Id_Canal )

WHILE @@Fetch_Status <> -1
BEGIN

/* ... Récupération de la valeur ID_DOC pour l'interlocuteur courant ... */
        SELECT @dcIdDoc = Max ( archive.id_doc ) + 1
        FROM    sysadm.archive
        WHERE   archive.id_sin          = @dcIdSin       AND
                archive.id_inter        = @dcIdI

        IF      @dcIdDoc is NULL Select @dcIdDoc = 1

/* ... Récupération du nouvelle valeur d'archive ... */
	EXEC @iRet = sysadm.PS_X_INCREMENTER 'CPT_ARCH', @iCptArch OUTPUT
        If      @iRet <> 1 
		Begin
			Select @iRet = -1
			Break
		End


/* ... Cr‚ation dans la table ARCHIVE ... */
        EXEC @iRet = sysadm.PS_I01_ARCHIVE_VAL_SVE @dcIdSin, @dcIdI, @dcIdCpt, 
                     @dcIdDoc, @dcIdOrdre, @sCodOper, @dtValideLe, @iCptArch

        If      @iRet <> 1 
                Begin
                        Select @iRet = -1
                        Break
                End

/* ... Cr‚ation dans la table W_COUR_BLOB_ARCH ... */
        EXEC @iRet = sysadm.PS_I01_W_COUR_BLOB_ARCH @dcIdSin, @dcIdI, @dcIdCpt, @iCptArch ,
                     @sCodOper, @dtValideLe, @sIdCanal

        If      @iRet <> 0 
                Begin
                        Select @iRet = -2
                        Break
                End

/* ... Mise … jour du compteur de courrier sur W_INTER et INTER ... */
        IF      @dcIdCpt = 0
                Begin
                        UPDATE  sysadm.w_inter
                        SET     sysadm.w_inter.cpt_cour = w_inter.cpt_cour + 1
                        FROM    sysadm.w_inter
                        WHERE   w_inter.id_sin  = @dcIdSin      AND
                                w_inter.id_i    = @dcIdI

                        If      @@RowCount <> 1
                                Begin
                                        Select @iRet = -3
                                        Break
                                End

                        UPDATE  sysadm.inter
                        SET     sysadm.inter.cpt_cour   = inter.cpt_cour + 1
                        FROM    sysadm.inter
                        WHERE   inter.id_sin  = @dcIdSin      AND
               inter.id_i    = @dcIdI

                        If      @@RowCount <> 1
                                Begin
                                        Select @iRet = -4
                                        Break
                                End

                End
	-- #1 [DNTMAIL1-2] PHG 02/11/2006 On enregistre le media ( Id_Canal )
	-- Point 5.2.6.2 des spécifications : Si Canal = 'MA' ( Mail ) alors on simule l'édition.
	IF @sIdCanal = 'MA'
	BEGIN
	        EXEC @iRet = sysadm.PS_I03_ARCHIVE_BLOB_VAL @iCptArch , @sRet OUTPUT

	        If      @iRet <> 0 
	                Begin
	                        -- Select @iRet = -5
	                        -- [ITSM85146]
	                        Select @iRet = -1002
	                        Break
	                End

	END
        FETCH   cur1 INTO
                @dcIdI,
                @dcIdCpt,
		@sIdCanal -- #1 [DNTMAIL1-2] PHG 02/11/2006 On enregistre le media ( Id_Canal )

END

CLOSE           cur1
DEALLOCATE      cur1

Return @iRet

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_U01_MAJ_REEDITION
-- Auteur               :       DGA
-- Date                 :       15/10/04 11:27:57
-- Libellé              :       
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--			        @adcIdSin               Decimal (   7,0 )               ,
--			        @aiIdArch               Integer                         ,
--			        @asIdDocEdt             Char    (   11  )               ,
--			        @asErreur               VarChar (   50  ) OUTPUT
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_MAJ_REEDITION' AND type = 'P' )
        DROP procedure sysadm.PS_U01_MAJ_REEDITION
GO


CREATE PROCEDURE sysadm.PS_U01_MAJ_REEDITION
        @adcIdSin               Decimal (   10,0 )               , -- [PI062]
        @aiIdArch               Integer                         ,
        @asIdDocEdt             Char    (   11  )               ,
        @asErreur               VarChar (   50  ) OUTPUT
AS
/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications Paramêtre                                                                                                       */
/* @adcIdSin   = Référénce Sinistre à traiter                                                                                   */
/* @aiIdArch   = Référence archive sur W_COUR_BLOB_ARCH et ARCHIVE.                                                             */
/* @asIdDocEdt = Valeur du N° Chrono éditique.                                                                                  */
/* @asErreur   = Erreur rencontrée.                                                                                             */
/*------------------------------------------------------------------------------------------------------------------------------*/
/* Il s'agit d'une réédition. Je vais positionner la zone DTE_EDIT de la table ARCHIVE uniquement.                              */
/* Je procéde d'une manière identique à PEGASE. C'est à dire pas de mise à jour sur la table W_COUR_BLOB_ARCH de la zone        */
/* DTE_EDIT.                                                                                                                    */
/*------------------------------------------------------------------------------------------------------------------------------*/
SET NOCOUNT ON
DECLARE @dtDteEdit      DATETIME

/*------------------------------------------------------------------*/
/* On s'occupe de la mise à jour sur W_COUR_BLOB_ARCH et ARCHIVE.   */
/*------------------------------------------------------------------*/
SET @dtDteEdit = GETDATE()
/*------------------------------------------------------------------*/
/* Cas pour les rééditions avant la mise en place de la DCMP 060589.*/
/*------------------------------------------------------------------*/
IF      @asIdDocEdt IS NULL
        BEGIN
                UPDATE  sysadm.archive
                SET     dte_edit        = @dtDteEdit
                WHERE   id_sin          = @adcIdSin             AND
                        id_arch         = @aiIdArch

                IF      @@ERROR <> 0 OR @@ROWCOUNT <> 1 
                        BEGIN
                                SET @asErreur = 'ERREUR de mise à jour sur archive.'
                                RETURN -1
                        END
        END
/*------------------------------------------------------------------*/
/* Cas pour les rééditions aprés la mise en place de la DCMP 060589.*/
/*------------------------------------------------------------------*/
IF      @asIdDocEdt IS NOT NULL
        BEGIN
                UPDATE  sysadm.archive
                SET     dte_edit        = @dtDteEdit
                WHERE   id_sin          = @adcIdSin             AND
                        id_arch         = @aiIdArch             AND
                        id_doc_edt      = @asIdDocEdt

                IF      @@ERROR <> 0 OR @@ROWCOUNT <> 1 
                        BEGIN
                                SET @asErreur = 'ERREUR de mise à jour sur archive.'
                                RETURN -1
                        END
        END

SET @asErreur = 'OK'
RETURN 1

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U01_MAJ_ID_EDT
-- Auteur               :       DGA
-- Date                 :       15/10/04 11:27:57
-- Libellé              :       
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdOrdre      Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_MAJ_ID_EDT' AND type = 'P' )
        DROP procedure sysadm.PS_U01_MAJ_ID_EDT
GO


CREATE PROCEDURE sysadm.PS_U01_MAJ_ID_EDT
        @asErreur               VarChar (   50  )       OUTPUT  ,
        @asIdDocEdt             Char    (   11  )       OUTPUT  ,
        @asEdtProgramme         Char    (    3  )               ,
        @asEdtApplicatif        Char    (    1  )               ,
        @adcIdSin               Decimal (   10,0 )               , -- [PI062]
        @aiIdArch               Integer                         ,
        @aiIdLot                Integer                         ,
        @asDteEdit              VarChar (   10 )                
AS
/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications Paramêtre                                                                                                       */
/* @asErreur   = Erreur rencontrée.                                                                                             */
/* @aiIdDocEdt = Valeur du N° Chrono éditique.                                                                                  */
/* @adcIdSin   = Référénce Sinistre à traiter                                                                                   */
/* @aiIdArch   = Référence archive sur W_COUR_BLOB_ARCH = id_seq sur ARCHIVE.                                                   */
/* @aiIdLot    = N° du lot à positionner.                                                                                       */
/* @adtDteEdit = Date d'édition à positionner sur ARCHIVE au format DATETIME                                                    */
/*------------------------------------------------------------------------------------------------------------------------------*/
/* ATTENTION:ATTENTION.                                                                                                         */
/* Je passe volontairement la zone @asDteEdit en VARCHAR(10). En effet, il y a un problème avec PowerBuilder entre l'utlisation */
/* de paramètre de type VARCHAR en OUTPUT et l'envoi de valeur en DATETIME.                                                     */
/* Je m'occupe de convertir moi-même la valeur @asDteEdit en DateTime                                                           */
/*------------------------------------------------------------------------------------------------------------------------------*/
SET NOCOUNT ON
DECLARE @dtDteEdit      DATETIME        ,
        @iIdDocEdt      INTEGER
/*------------------------------------------------------------------*/
/* On va d'abord récupérer la valeur actuelle du compteur           */
/* d'éditique. On l'incrémente de 1. On remet la valeur à jour      */
/* dans la table PARAMETRE, et on retourne la valeur calculée dans  */
/* la procédure.                                                    */
/*------------------------------------------------------------------*/
SELECT  @iIdDocEdt = cpt_val
FROM    sysadm.parametre        AS pa
WHERE   pa.ref_cpt = 'ID_DOC_EDT'

IF      @@ROWCOUNT <> 1
        BEGIN
                SET @asErreur = 'ERREUR dans la lecture de la table PARAMETRE'
                RETURN -1
        END
        
SET @iIdDocEdt = @iIdDocEdt + 1

UPDATE  sysadm.parametre
SET     cpt_val = @iIdDocEdt
WHERE   ref_cpt = 'ID_DOC_EDT'

IF      @@ROWCOUNT <> 1
        BEGIN
                SET @asErreur = 'ERREUR dans la mise à jour de la table PARAMETRE'
                RETURN -1
        END
/*------------------------------------------------------------------*/
/* On s'occupe de la mise à jour sur W_COUR_BLOB_ARCH et ARCHIVE.   */
/*------------------------------------------------------------------*/
SET @dtDteEdit  = CONVERT ( DATETIME, @asDteEdit )
SET @asIdDocEdt = @asEdtProgramme + @asEdtApplicatif + REPLICATE ( '0', 7 - LEN ( @iIdDocEdt ) ) + CONVERT ( VARCHAR, @iIdDocEdt )
        
UPDATE  sysadm.w_cour_blob_arch
SET     dte_edit        = @dtDteEdit    ,
        id_lot          = @aiIdLot      ,
        id_doc_edt      = @asIdDocEdt
WHERE   id_sin          = @adcIdSin             AND
        id_arch         = @aiIdArch             AND
        id_lot          = 0
        
IF      @@ERROR <> 0 OR @@ROWCOUNT <> 1 
        BEGIN
                SET @asErreur = 'ERREUR de mise à jour sur w_cour_blob_arch.'
                RETURN -1
        END

UPDATE  sysadm.archive
SET     id_doc_edt      = @asIdDocEdt
WHERE   id_sin          = @adcIdSin             AND
        id_arch         = @aiIdArch

IF      @@ERROR <> 0 OR @@ROWCOUNT <> 1 
        BEGIN
                SET @asErreur = 'ERREUR de mise à jour sur archive.'
                RETURN -1
        END

SET @asErreur = 'OK'
RETURN 1

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_RECUPERER_ARCHIVE_V01
-- Auteur               :       DGA  (placé par JFF)
-- Date                 :       
-- Libellé              :       
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--			        @Alidsin                Decimal (  7,0 ),
--			        @Alidinter              Decimal (  7,0 ),
--			        @Aliddoc                Decimal (  7,0 ),
--			        @Asmajpar               Varchar (   4 ) 
--			        @Asretour               Varchar ( 255  ) Output
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_RECUPERER_ARCHIVE_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I01_RECUPERER_ARCHIVE_V01
GO

CREATE PROCEDURE sysadm.PS_I01_RECUPERER_ARCHIVE_V01
        @alIdSin                Decimal (  10,0 ), -- [PI062]
        @alIdInter              Decimal (  7,0 ),
        @alIdDoc                Decimal (  7,0 ),
        @asMajPar               VarChar (   4 ) 
--        @asRetour               VarChar ( 255  ) OUTPUT
AS

DECLARE @iRet           Integer
DECLARE @sTxtMess       VarChar(254)
DECLARE @dtCreeLe       DateTime

/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications paramètres                                                                                                      */
/* @alIdSin    = Référence sinistre à traiter.                                                                                  */
/* @alIdInter  = Identifiant interlocuteur à traiter.                                                                           */
/* @alIdDoc    = Identifiant du document à traiter.                                                                             */
/* @asMajPar   = Trigramme de l'opérateur en train de consulter le courrier.                                                    */
/*------------------------------------------------------------------------------------------------------------------------------*/
/* Le but de cette procédure est de 'recopier' le blob correspondant au courrier qui ne se trouve plus dans la base SIMPA2_PRO  */
/* En effet, ce courrier a été archivé. On le sait grace à la colonne REF_DOC_DT positionnée à 1 et la colonne DTE_ARCHIV qui   */
/* ne doit pas être NULL.                                                                                                       */
/* Il existe une procédure PS_I01_RECUPERE_ARCHIVE qui récupére les anciens courriers avant la mise en place de la méthode SVE. */
/* Un BLOB pour les DATAS, un BLOB pour le post_scriptum, etc..                                                                 */
/*------------------------------------------------------------------------------------------------------------------------------*/

SET NOCOUNT ON
/*------------------------------------------------------------------*/
/* Initialisation des variables                                     */
/*------------------------------------------------------------------*/
SELECT @iRet            = 1
SELECT @dtCreeLe        = GETDATE ()

/*------------------------------------------------------------------*/
/* On importe le BLOB pour le COURRIER                              */
/*------------------------------------------------------------------*/
/* SERVEUR DE PRODUCTION                                            */
/*------------------------------------------------------------------*/
IF      @@SERVERNAME = master.dbo.SPB_FN_ServerName ('PRO')
        BEGIN

			-- [PI062]
			IF Exists ( 
					Select Top 1 1 
					FROM            SIMPA2BLOB_PRO.sysadm.archive_blob2      AS      ab
					WHERE           ab.id_sin          = @alIdSin                 AND
									ab.id_inter        = @alIdInter               AND
									ab.id_doc          = @alIdDoc                 AND
									ab.id_typ_blob     = 'DO'
					) 
				Begin
					INSERT INTO     sysadm.archive_blob
							(       sysadm.archive_blob.id_sin,
									sysadm.archive_blob.id_inter,
									sysadm.archive_blob.id_doc,
									sysadm.archive_blob.id_typ_blob,
									sysadm.archive_blob.txt_blob,
									sysadm.archive_blob.valide_le,
									sysadm.archive_blob.valide_par,
									sysadm.archive_blob.cree_le,
									sysadm.archive_blob.maj_le,
									sysadm.archive_blob.maj_par
							)
					SELECT          ab.id_sin,
									ab.id_inter,
									ab.id_doc,
									ab.id_typ_blob,
									ab.txt_blob,
									ab.valide_le,
									ab.valide_par,
									ab.cree_le,
									ab.maj_le,
									ab.maj_par
					FROM            SIMPA2BLOB_PRO.sysadm.archive_blob2      AS      ab
					WHERE           ab.id_sin          = @alIdSin                 AND
									ab.id_inter        = @alIdInter               AND
									ab.id_doc          = @alIdDoc                 AND
									ab.id_typ_blob     = 'DO'
				End
			Else
				Begin
					INSERT INTO     sysadm.archive_blob
							(       sysadm.archive_blob.id_sin,
									sysadm.archive_blob.id_inter,
									sysadm.archive_blob.id_doc,
									sysadm.archive_blob.id_typ_blob,
									sysadm.archive_blob.txt_blob,
									sysadm.archive_blob.valide_le,
									sysadm.archive_blob.valide_par,
									sysadm.archive_blob.cree_le,
									sysadm.archive_blob.maj_le,
									sysadm.archive_blob.maj_par
							)
					SELECT          ab.id_sin,
									ab.id_inter,
									ab.id_doc,
									ab.id_typ_blob,
									ab.txt_blob,
									ab.valide_le,
									ab.valide_par,
									ab.cree_le,
									ab.maj_le,
									ab.maj_par
					FROM            SIMPA2BLOB_PRO.sysadm.archive_blob      AS      ab
					WHERE           ab.id_sin          = @alIdSin                 AND
									ab.id_inter        = @alIdInter               AND
									ab.id_doc          = @alIdDoc                 AND
									ab.id_typ_blob     = 'DO'
				End

                IF      @@RowCount      <> 1
                        BEGIN
                                SELECT @iRet            = -1
                                SELECT @sTxtMess        = 'Courrier nouvelle méthode = Erreur '
                        END
                ELSE
                        SELECT @sTxtMess        = 'Courrier nouvelle méthode = OK'
        END
/*------------------------------------------------------------------*/
/* SERVEUR DE SIMULATION                                            */
/*------------------------------------------------------------------*/
IF      @@SERVERNAME = master.dbo.SPB_FN_ServerName ('SIM')
        BEGIN
                INSERT INTO     sysadm.archive_blob
                        (       sysadm.archive_blob.id_sin,
                                sysadm.archive_blob.id_inter,
                                sysadm.archive_blob.id_doc,
                                sysadm.archive_blob.id_typ_blob,
                                sysadm.archive_blob.txt_blob,
                                sysadm.archive_blob.valide_le,
                                sysadm.archive_blob.valide_par,
                                sysadm.archive_blob.cree_le,
                                sysadm.archive_blob.maj_le,
                                sysadm.archive_blob.maj_par
                        )
                SELECT          ab.id_sin,
                                ab.id_inter,
                                ab.id_doc,
                                ab.id_typ_blob,
                                ab.txt_blob,
                                ab.valide_le,
                                ab.valide_par,
                                ab.cree_le,
                                ab.maj_le,
                                ab.maj_par
                FROM            SIMPA2BLOB_FIL.sysadm.archive_blob      AS      ab
                WHERE           ab.id_sin          = @alIdSin                 AND
                                ab.id_inter        = @alIdInter               AND
                                ab.id_doc          = @alIdDoc                 AND
                                ab.id_typ_blob     = 'DO'

                IF      @@RowCount      <> 1
                        BEGIN
                                SELECT @iRet            = -1
                                SELECT @sTxtMess        = 'Courrier nouvelle méthode = Erreur '
                        END
                ELSE
                        SELECT @sTxtMess        = 'Courrier nouvelle méthode = OK'
        END


IF      @iRet = 1
/*------------------------------------------------------------------*/
/* On va mettre à jour la zone DTE_ARCHIV de la table ARCHIVE.      */
/*------------------------------------------------------------------*/
        BEGIN
                UPDATE  sysadm.archive
                SET     sysadm.archive.dte_archiv = NULL,
                        sysadm.archive.ref_doc_dt = NULL
                WHERE   sysadm.archive.id_sin          = @alIdSin                 AND
                        sysadm.archive.id_inter        = @alIdInter               AND
                        sysadm.archive.id_doc          = @alIdDoc

                IF      @@RowCount      <> 1
                        BEGIN
                                SELECT @iRet    = -1
                                SELECT sTxtMess = 'Erreur pour mettre à jour la zone DTE_ARCHIV de la table ARCHIVE'
                        END
 End

/*------------------------------------------------------------------*/
/* On va insérer une ligne dans la table W_RETOUR_ARCHIVE pour      */
/* tracer la récupération du courrier.                              */
/*------------------------------------------------------------------*/
IF      @iRet = 1
        BEGIN
				Delete sysadm.w_trc_archive_recup Where id_sin = @alIdSin and id_inter = @alIdInter and id_doc = @alIdDoc
			
                INSERT INTO     sysadm.w_trc_archive_recup
                        (       sysadm.w_trc_archive_recup.id_sin,
                                sysadm.w_trc_archive_recup.id_inter,
                                sysadm.w_trc_archive_recup.id_doc,
                                sysadm.w_trc_archive_recup.txt_mess,
                                sysadm.w_trc_archive_recup.alt_supp,
                                sysadm.w_trc_archive_recup.alt_part,
                                sysadm.w_trc_archive_recup.alt_pce,
                                sysadm.w_trc_archive_recup.alt_ps,
                                sysadm.w_trc_archive_recup.cree_le,
                                sysadm.w_trc_archive_recup.maj_le,
                                sysadm.w_trc_archive_recup.maj_par
                        )
                VALUES
                        (       @alIdSin,
                                @alIdInter,
                                @alIdDoc,
                                @sTxtMess,
                                'N',
                                'N',
                                'N',
                                'N',
                                @dtCreeLe,
                                @dtCreeLe,
                                @asMajPar
                        )
        END

RETURN ( @iRet )

Go


--------------------------------------------------------------------
--
-- Procédure            :       DDDW_S_PRODUIT_RELANCE
-- Auteur               :       Fabry JF
-- Date                 :       29/04/2021
-- Libellé              :       Select sur Archive. 
-- Commentaires         :       Select pour les PREMIERES RELANCES AUTOMATIQUES ! + En croisant avec Table produit alt_rl = 'O' et surtout présence de relance à faire
--								[RS-331]
-- Références           :       Utilisé dans W_RL_SP_RELANCES
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--                      :       @dtDateMin      Datetime 	        (Val)
--                      :       @dtDateMax      DateTime		(Val)
--
-- Retourne             :       Rien
--
-- JFF      22/08/2022   [RS3179]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DDDW_S_PRODUIT_RELANCE' AND type = 'P' )
        DROP procedure sysadm.DDDW_S_PRODUIT_RELANCE
GO

CREATE procedure sysadm.DDDW_S_PRODUIT_RELANCE
	  @sCodeTrt       VarChar ( 3 )
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN

	If @sCodeTrt = 'R1A' 
	Begin 

		select  distinct 
				prod.id_prod,
				prod.lib_long,
				prod.lib_court,
				prod.id_dept,
				prod.id_depts

		From 	sysadm.sinistre 	sin with (nolock),
			sysadm.archive  	arch with (nolock),
			sysadm.inter		int with (nolock),
			sysadm.inter		intass with (nolock),
			sysadm.personne 	pers with (nolock),
			sysadm.produit		prod with (nolock),
			sysadm.groupe		grp with (nolock),
			sysadm.routage		rout with (nolock)


		Where	prod.cod_adh = '3'
		And     prod.alt_rl1 = 'O'
		And     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	 in ( 100, 550 )
		and    	sin.valide_le 		= arch.valide_le
		and     
		(
		  (
			(
			( Substring ( arch.id_cour_orig, 2, 1 ) = 'C' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or
			Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or 
			arch.id_cour_orig = 'APART1'
			) And arch.id_cour_orig is not null
		  ) 
		 OR
		  (
			(
			( Substring ( arch.id_cour, 2, 1 ) = 'C' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or
			Substring ( arch.id_cour, 1, 1 ) = 'Q' Or 
			arch.id_cour = 'APART1'
			) And arch.id_cour_orig is null
		  )
		)
		and     (       CharIndex ( 'P001', arch.txt_compo1, 1 ) = 0
					And CharIndex ( 'P118', arch.txt_compo1, 1 ) = 0
					And CharIndex ( 'P119', arch.txt_compo1, 1 ) = 0
					And CharIndex ( 'P037', arch.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P107', arch.txt_compo1, 1 ) = 0            
				And CharIndex ( 'P120', arch.txt_compo1, 1 ) = 0            
				)
	/*
				idtDateMin = DateTime ( F_Plus_Date ( Date ( idtDateDuJour ) , ( iDurRlMax * (-1) ), sUntRl1 ), 00:00:00 )
				idtDateMax = DateTime ( F_Plus_Date ( Date ( idtDateDuJour ) , ( iDurRlMin * (-1) ), sUntRl1 ), 23:59:59 )
	Select * from sysadm.produit 
	Select dateadd ( day, -5 , getdate() )
	Select Convert ( varchar ( 10), DateAdd ( day, 5 * (-1), getdate()), 103) + '00:00:00'
	*/
		and     ( 
				  ( prod.unt_rl1 = 'J' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'M' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'A' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				)

		and     arch.cod_version     	= 2
		and     arch.nbr_conf         	= 0
		and     arch.id_sin           	= int.id_sin
		and     arch.id_inter         	= int.id_i
		and 	intass.id_sin		= arch.id_sin
		and 	intass.cod_inter	= 'A'
		and 	pers.id_ordre		= sin.id_ordre
		and	prod.id_prod		= sin.id_prod
		and	grp.id_grp		= sin.id_ets
		And Not exists ( 
			Select Top 1 1
			From sysadm.det_pro dp
			Where dp.id_prod = prod.id_prod
			And   dp.id_code_dp = 323
		 )
		And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
			  Or 
		      ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
            )

		Union All 

		select  distinct 
				prod.id_prod,
				prod.lib_long,
				prod.lib_court,
				prod.id_dept,
				prod.id_depts

		From 	sysadm.sinistre 	sin with (nolock),
			sysadm.archive  	arch with (nolock),
			sysadm.inter		int with (nolock),
			sysadm.inter		intass with (nolock),
			sysadm.personne 	pers with (nolock),
			sysadm.produit		prod with (nolock),
			sysadm.groupe		grp with (nolock),
			sysadm.etablissement	eta with (nolock),
			sysadm.routage		rout with (nolock)

		Where	prod.cod_adh <> '3'
		And     prod.alt_rl1 = 'O'
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	 in ( 100, 550 )
		and    	sin.valide_le 		= arch.valide_le
		and     
		(
		  (
			(
			( Substring ( arch.id_cour_orig, 2, 1 ) = 'C' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or
			Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or 
			arch.id_cour_orig = 'APART1'
			) And arch.id_cour_orig is not null
		  ) 
		 OR
		  (
			(
			( Substring ( arch.id_cour, 2, 1 ) = 'C' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or
			Substring ( arch.id_cour, 1, 1 ) = 'Q' Or 
			arch.id_cour = 'APART1'
			) And arch.id_cour_orig is null
		  )
		)
		and     (       CharIndex ( 'P001', arch.txt_compo1, 1 ) = 0
					And CharIndex ( 'P118', arch.txt_compo1, 1 ) = 0
					And CharIndex ( 'P119', arch.txt_compo1, 1 ) = 0
					And CharIndex ( 'P037', arch.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P107', arch.txt_compo1, 1 ) = 0            
				And CharIndex ( 'P120', arch.txt_compo1, 1 ) = 0            
				)

		and     ( 
				  ( prod.unt_rl1 = 'J' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'M' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'A' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				)
		and     arch.cod_version     	= 2
		and     arch.nbr_conf         	= 0
		and     arch.id_sin           	= int.id_sin
		and     arch.id_inter         	= int.id_i
		and 	intass.id_sin		= arch.id_sin
		and 	intass.cod_inter	= 'A'
		and 	pers.id_ordre		= sin.id_ordre
		and	prod.id_prod		= sin.id_prod
		and	eta.id_prod   		= sin.id_prod
		and	eta.id_ets  		= sin.id_ets
		and	eta.id_grp  		= grp.id_grp
		and	eta.id_rev    		= -1
		And Not exists ( 
			Select Top 1 1
			From sysadm.det_pro dp
			Where dp.id_prod = prod.id_prod
			And   dp.id_code_dp = 323
		 )
		And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
			  Or 
		      ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
            )

	End -- Fin R1A

	If @sCodeTrt = 'R2' 
	Begin 

		select  distinct 
				prod.id_prod,
				prod.lib_long,
				prod.lib_court,
				prod.id_dept,
				prod.id_depts

		From 	sysadm.sinistre 	sin with (nolock),
			sysadm.archive  	arch with (nolock),
			sysadm.inter		int with (nolock),
			sysadm.inter		intass with (nolock),
			sysadm.personne 	pers with (nolock),
			sysadm.produit		prod with (nolock),
			sysadm.groupe		grp with (nolock),
			sysadm.routage		rout with (nolock)


		Where	prod.cod_adh = '3'
		And     prod.alt_rl2 = 'O'
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	in ( 100, 550 )
		and    	sin.valide_le 		= arch.valide_le
		and     
		(
		  (
			( Substring ( arch.id_cour_orig, 2, 5 ) = 'LAX01' Or arch.id_cour_orig = 'ALQ001' )
			And arch.id_cour_orig is not null
		  ) 
		 OR
		  (
			( Substring ( arch.id_cour, 2, 5 ) = 'LAX01' Or arch.id_cour = 'ALQ001' )
			And arch.id_cour_orig is null
		  )
		)
		and     ( 
				  ( prod.unt_rl2 = 'J' 
					And arch.maj_le  <= Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl2 * (-1), getdate()), 103) + ' 00:00:00'
				  ) 
				  Or 
				  ( prod.unt_rl2 = 'M' 
					And arch.maj_le  <= Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl2 * (-1), getdate()), 103) + ' 00:00:00'
				  ) 
				  Or 
				  ( prod.unt_rl2 = 'A' 
					And arch.maj_le  <= Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl2 * (-1), getdate()), 103) + ' 00:00:00'
				  ) 
				)


		and     arch.cod_version     	= 2
		and     arch.nbr_conf         	= 0
		and     arch.id_sin           	= int.id_sin
		and     arch.id_inter         	= int.id_i
		and 	intass.id_sin		= arch.id_sin
		and 	intass.cod_inter	= 'A'
		and 	pers.id_ordre		= sin.id_ordre
		and	prod.id_prod		= sin.id_prod
		and	grp.id_grp		= sin.id_ets
		And Not exists ( 
			Select Top 1 1
			From sysadm.det_pro dp
			Where dp.id_prod = prod.id_prod
			And   dp.id_code_dp = 323
		 )
		And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
			  Or 
		      ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
            )

		Union all

		select  distinct 
				prod.id_prod,
				prod.lib_long,
				prod.lib_court,
				prod.id_dept,
				prod.id_depts


		From 	sysadm.sinistre 	sin with (nolock),
			sysadm.archive  	arch with (nolock),
			sysadm.inter		int with (nolock),
			sysadm.inter		intass with (nolock),
			sysadm.personne 	pers with (nolock),
			sysadm.produit		prod with (nolock),
			sysadm.groupe		grp with (nolock),
			sysadm.etablissement	eta with (nolock),
			sysadm.routage		rout with (nolock)

		Where	prod.cod_adh <> '3'
		And     prod.alt_rl2 = 'O'
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	in ( 100, 550 )
		and    	sin.valide_le 		= arch.valide_le
		and     
		(
		  (
			( Substring ( arch.id_cour_orig, 2, 5 ) = 'LAX01' Or arch.id_cour_orig = 'ALQ001' )
			And arch.id_cour_orig is not null
		  ) 
		 OR
		  (
			( Substring ( arch.id_cour, 2, 5 ) = 'LAX01' Or arch.id_cour = 'ALQ001' )
			And arch.id_cour_orig is null
		  )
		)

		and     ( 
				  ( prod.unt_rl2 = 'J' 
					And arch.maj_le  <= Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl2 * (-1), getdate()), 103) + ' 00:00:00'
				  ) 
				  Or 
				  ( prod.unt_rl2 = 'M' 
					And arch.maj_le  <= Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl2 * (-1), getdate()), 103) + ' 00:00:00'
				  ) 
				  Or 
				  ( prod.unt_rl2 = 'A' 
					And arch.maj_le  <= Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl2 * (-1), getdate()), 103) + ' 00:00:00'
				  ) 
				)
		and     arch.cod_version     	= 2
		and     arch.nbr_conf         	= 0
		and     arch.id_sin           	= int.id_sin
		and     arch.id_inter         	= int.id_i
		and 	intass.id_sin		= arch.id_sin
		and 	intass.cod_inter	= 'A'
		and 	pers.id_ordre		= sin.id_ordre
		and	prod.id_prod		= sin.id_prod
		and	eta.id_prod   		= sin.id_prod
		and	eta.id_ets  		= sin.id_ets
		and	eta.id_grp  		= grp.id_grp
		and	eta.id_rev    		= -1
		And Not exists ( 
			Select Top 1 1
			From sysadm.det_pro dp
			Where dp.id_prod = prod.id_prod
			And   dp.id_code_dp = 323
		 )
		And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
			  Or 
		      ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
            )

	End 

	If @sCodeTrt = 'R1U' 
	Begin 

		-- PremiŠre requˆte en regardant les piŠces coch‚s.
		select  distinct 
				prod.id_prod,
				prod.lib_long,
				prod.lib_court,
				prod.id_dept,
				prod.id_depts


		From 	sysadm.sinistre 	sin with (nolock),
			sysadm.w_piece		wp with (nolock),
			sysadm.archive  	arch with (nolock),
			sysadm.inter		int with (nolock),
			sysadm.inter		intass with (nolock),
			sysadm.personne 	pers with (nolock),
			sysadm.produit		prod with (nolock),
			sysadm.groupe		grp with (nolock),
			sysadm.routage		rout with (nolock)


		Where	prod.cod_adh = '3'
		And     prod.alt_rl1 = 'O'
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	 in ( 100, 550 )
		and    	sin.valide_le 		= arch.valide_le
		and     
		(
		  (
			(
			( Substring ( arch.id_cour_orig, 1, 2 ) = 'BC' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or arch.id_cour_orig = 'APART1' 
			) And arch.id_cour_orig is not null
		  ) 
		 OR
		  (
			(
			( Substring ( arch.id_cour, 1, 2 ) = 'BC' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour, 1, 1 ) = 'Q' Or arch.id_cour = 'APART1' 
			) And arch.id_cour_orig is null
		  )
		)

		and     ( 
				  ( prod.unt_rl1 = 'J' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'M' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'A' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				)
		and     arch.cod_version     	= 2
		and	arch.cod_inter		= 'B'
		and     arch.nbr_conf         	= 0
		and     arch.id_sin           	= int.id_sin
		and     arch.id_inter         	= int.id_i
		and	wp.id_sin		= sin.id_sin
		and	wp.id_gti		= 7
		and	wp.id_i			= int.id_i
		and 	intass.id_sin		= arch.id_sin
		and 	intass.cod_inter	= 'A'
		and 	pers.id_ordre		= sin.id_ordre
		and	prod.id_prod		= sin.id_prod
		and	grp.id_grp		= sin.id_ets
		And Not exists ( 
			Select Top 1 1
			From sysadm.det_pro dp
			Where dp.id_prod = prod.id_prod
			And   dp.id_code_dp = 323
		 )
		And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
			  Or 
		      ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
            )

		UNION ALL

		-- DeuxiŠme requˆte en regardant ALT_ATT coch‚.
		select  distinct 
				prod.id_prod,
				prod.lib_long,
				prod.lib_court,
				prod.id_dept,
				prod.id_depts


		From 	sysadm.sinistre 	sin,
			sysadm.w_gar_sin	wg,
			sysadm.archive  	arch,
			sysadm.inter		int,
			sysadm.inter		intass,
			sysadm.personne 	pers,
			sysadm.produit		prod,
			sysadm.groupe		grp,
			sysadm.routage		rout


		Where	prod.cod_adh = '3'
		And     prod.alt_rl1 = 'O'
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	 in ( 100, 550 )
		and    	sin.valide_le 		= arch.valide_le
		and     
		(
		  (
			(
			( Substring ( arch.id_cour_orig, 1, 2 ) = 'BC' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or arch.id_cour_orig = 'APART1' 
			) And arch.id_cour_orig is not null
		  ) 
		 OR
		  (
			(
			( Substring ( arch.id_cour, 1, 2 ) = 'BC' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour, 1, 1 ) = 'Q' Or arch.id_cour = 'APART1' 
			) And arch.id_cour_orig is null
		  )
		)

		and     ( 
				  ( prod.unt_rl1 = 'J' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'M' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'A' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				)
		and     arch.cod_version     	= 2
		and	arch.cod_inter		= 'B'
		and     arch.nbr_conf         	= 0
		and     arch.id_sin           	= int.id_sin
		and     arch.id_inter         	= int.id_i
		and	wg.id_sin		= sin.id_sin
		and	wg.id_gti		= 7
		and	wg.alt_att		= 'O' 
		and 	intass.id_sin		= arch.id_sin
		and 	intass.cod_inter	= 'A'
		and 	pers.id_ordre		= sin.id_ordre
		and	prod.id_prod		= sin.id_prod
		and	grp.id_grp		= sin.id_ets
		And Not exists ( 
			Select Top 1 1
			From sysadm.det_pro dp
			Where dp.id_prod = prod.id_prod
			And   dp.id_code_dp = 323
		 )
		And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
			  Or 
		      ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
            )

		union all
		-- PremiŠre requˆte en regardant les piŠces coch‚s.

		select  distinct 
				prod.id_prod,
				prod.lib_long,
				prod.lib_court,
				prod.id_dept,
				prod.id_depts

		From 	sysadm.sinistre 	sin with (nolock),
			sysadm.w_piece		wp with (nolock),
			sysadm.archive  	arch with (nolock),
			sysadm.inter		int with (nolock),
			sysadm.inter		intass with (nolock),
			sysadm.personne 	pers with (nolock),
			sysadm.produit		prod with (nolock),
			sysadm.groupe		grp with (nolock),
			sysadm.etablissement	eta with (nolock),
			sysadm.routage		rout with (nolock)


		Where	prod.cod_adh <> '3'
		And     prod.alt_rl1 = 'O'
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	 in ( 100, 550 )
		and    	sin.valide_le 		= arch.valide_le
		and     
		(
		  (
			(
			( Substring ( arch.id_cour_orig, 1, 2 ) = 'BC' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or arch.id_cour_orig = 'APART1' 
			) And arch.id_cour_orig is not null
		  ) 
		 OR
		  (
			(
			( Substring ( arch.id_cour, 1, 2 ) = 'BC' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour, 1, 1 ) = 'Q' Or arch.id_cour = 'APART1' 
			) And arch.id_cour_orig is null
		  )
		)

		and     ( 
				  ( prod.unt_rl1 = 'J' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'M' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'A' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				)
		and     arch.cod_version     	= 2
		and	arch.cod_inter		= 'B'
		and     arch.nbr_conf         	= 0
		and     arch.id_sin           	= int.id_sin
		and     arch.id_inter         	= int.id_i
		and	wp.id_sin		= sin.id_sin
		and	wp.id_gti		= 7
		and	wp.id_i			= int.id_i
		and 	intass.id_sin		= arch.id_sin
		and 	intass.cod_inter	= 'A'
		and 	pers.id_ordre		= sin.id_ordre
		and	prod.id_prod		= sin.id_prod
		and	eta.id_prod   		= sin.id_prod
		and	eta.id_ets  		= sin.id_ets
		and	eta.id_grp  		= grp.id_grp
		and	eta.id_rev    		= -1
		And Not exists ( 
			Select Top 1 1
			From sysadm.det_pro dp
			Where dp.id_prod = prod.id_prod
			And   dp.id_code_dp = 323
		 )
		And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
			  Or 
		      ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
            )

		UNION ALL

		-- DeuxiŠme requˆte en regardant ALT_ATT coch‚.
		select  distinct 
				prod.id_prod,
				prod.lib_long,
				prod.lib_court,
				prod.id_dept,
				prod.id_depts

		From 	sysadm.sinistre 	sin with (nolock),
			sysadm.w_gar_sin	wg with (nolock),
			sysadm.archive  	arch with (nolock),
			sysadm.inter		int with (nolock),
			sysadm.inter		intass with (nolock),
			sysadm.personne 	pers with (nolock),
			sysadm.produit		prod with (nolock),
			sysadm.groupe		grp with (nolock),
			sysadm.etablissement	eta with (nolock),
			sysadm.routage		rout with (nolock)


		Where	prod.cod_adh <> '3'
		And     prod.alt_rl1 = 'O'
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	 in ( 100, 550 )
		and    	sin.valide_le 		= arch.valide_le
		and     
		(
		  (
			(
			( Substring ( arch.id_cour_orig, 1, 2 ) = 'BC' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or arch.id_cour_orig = 'APART1'
			) And arch.id_cour_orig is not null
		  ) 
		 OR
		  (
			(
			( Substring ( arch.id_cour, 1, 2 ) = 'BC' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour, 1, 1 ) = 'Q' Or arch.id_cour = 'APART1'
			) And arch.id_cour_orig is null
		  )
		)

		and     ( 
				  ( prod.unt_rl1 = 'J' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'M' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'A' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				)
		and     arch.cod_version     	= 2
		and	arch.cod_inter		= 'B'
		and     arch.nbr_conf         	= 0
		and     arch.id_sin           	= int.id_sin
		and     arch.id_inter         	= int.id_i
		and	wg.id_sin		= sin.id_sin
		and	wg.id_gti		= 7
		and	wg.alt_att		= 'O' 
		and 	intass.id_sin		= arch.id_sin
		and 	intass.cod_inter	= 'A'
		and 	pers.id_ordre		= sin.id_ordre
		and	prod.id_prod		= sin.id_prod
		and	eta.id_prod   		= sin.id_prod
		and	eta.id_ets  		= sin.id_ets
		and	eta.id_grp  		= grp.id_grp
		and	eta.id_rev    		= -1
		And Not exists ( 
			Select Top 1 1
			From sysadm.det_pro dp
			Where dp.id_prod = prod.id_prod
			And   dp.id_code_dp = 323
		 )
		And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
			  Or 
		      ( SHERPA_PRO.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
            )

	End 
END 

ELSE

BEGIN
	If @sCodeTrt = 'R1A' 
	Begin 

		select  distinct 
				prod.id_prod,
				prod.lib_long,
				prod.lib_court,
				prod.id_dept,
				prod.id_depts

		From 	sysadm.sinistre 	sin with (nolock),
			sysadm.archive  	arch with (nolock),
			sysadm.inter		int with (nolock),
			sysadm.inter		intass with (nolock),
			sysadm.personne 	pers with (nolock),
			sysadm.produit		prod with (nolock),
			sysadm.groupe		grp with (nolock),
			sysadm.routage		rout with (nolock)


		Where	prod.cod_adh = '3'
		And     prod.alt_rl1 = 'O'
		And     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	 in ( 100, 550 )
		and    	sin.valide_le 		= arch.valide_le
		and     
		(
		  (
			(
			( Substring ( arch.id_cour_orig, 2, 1 ) = 'C' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or
			Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or 
			arch.id_cour_orig = 'APART1'
			) And arch.id_cour_orig is not null
		  ) 
		 OR
		  (
			(
			( Substring ( arch.id_cour, 2, 1 ) = 'C' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or
			Substring ( arch.id_cour, 1, 1 ) = 'Q' Or 
			arch.id_cour = 'APART1'
			) And arch.id_cour_orig is null
		  )
		)
		and     (       CharIndex ( 'P001', arch.txt_compo1, 1 ) = 0
					And CharIndex ( 'P118', arch.txt_compo1, 1 ) = 0
					And CharIndex ( 'P119', arch.txt_compo1, 1 ) = 0
					And CharIndex ( 'P037', arch.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P107', arch.txt_compo1, 1 ) = 0            
				And CharIndex ( 'P120', arch.txt_compo1, 1 ) = 0            
				)
	/*
				idtDateMin = DateTime ( F_Plus_Date ( Date ( idtDateDuJour ) , ( iDurRlMax * (-1) ), sUntRl1 ), 00:00:00 )
				idtDateMax = DateTime ( F_Plus_Date ( Date ( idtDateDuJour ) , ( iDurRlMin * (-1) ), sUntRl1 ), 23:59:59 )
	Select * from sysadm.produit 
	Select dateadd ( day, -5 , getdate() )
	Select Convert ( varchar ( 10), DateAdd ( day, 5 * (-1), getdate()), 103) + '00:00:00'
	*/
		and     ( 
				  ( prod.unt_rl1 = 'J' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'M' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'A' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				)

		and     arch.cod_version     	= 2
		and     arch.nbr_conf         	= 0
		and     arch.id_sin           	= int.id_sin
		and     arch.id_inter         	= int.id_i
		and 	intass.id_sin		= arch.id_sin
		and 	intass.cod_inter	= 'A'
		and 	pers.id_ordre		= sin.id_ordre
		and	prod.id_prod		= sin.id_prod
		and	grp.id_grp		= sin.id_ets
		And Not exists ( 
			Select Top 1 1
			From sysadm.det_pro dp
			Where dp.id_prod = prod.id_prod
			And   dp.id_code_dp = 323
		 )
		And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
			  Or 
		      ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
            )


		Union All 

		select  distinct 
				prod.id_prod,
				prod.lib_long,
				prod.lib_court,
				prod.id_dept,
				prod.id_depts

		From 	sysadm.sinistre 	sin with (nolock),
			sysadm.archive  	arch with (nolock),
			sysadm.inter		int with (nolock),
			sysadm.inter		intass with (nolock),
			sysadm.personne 	pers with (nolock),
			sysadm.produit		prod with (nolock),
			sysadm.groupe		grp with (nolock),
			sysadm.etablissement	eta with (nolock),
			sysadm.routage		rout with (nolock)

		Where	prod.cod_adh <> '3'
		And     prod.alt_rl1 = 'O'
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	 in ( 100, 550 )
		and    	sin.valide_le 		= arch.valide_le
		and     
		(
		  (
			(
			( Substring ( arch.id_cour_orig, 2, 1 ) = 'C' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or
			Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or 
			arch.id_cour_orig = 'APART1'
			) And arch.id_cour_orig is not null
		  ) 
		 OR
		  (
			(
			( Substring ( arch.id_cour, 2, 1 ) = 'C' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or
			Substring ( arch.id_cour, 1, 1 ) = 'Q' Or 
			arch.id_cour = 'APART1'
			) And arch.id_cour_orig is null
		  )
		)
		and     (       CharIndex ( 'P001', arch.txt_compo1, 1 ) = 0
					And CharIndex ( 'P118', arch.txt_compo1, 1 ) = 0
					And CharIndex ( 'P119', arch.txt_compo1, 1 ) = 0
					And CharIndex ( 'P037', arch.txt_compo1, 1 ) = 0            
					And CharIndex ( 'P107', arch.txt_compo1, 1 ) = 0            
				And CharIndex ( 'P120', arch.txt_compo1, 1 ) = 0            
				)

		and     ( 
				  ( prod.unt_rl1 = 'J' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'M' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'A' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				)
		and     arch.cod_version     	= 2
		and     arch.nbr_conf         	= 0
		and     arch.id_sin           	= int.id_sin
		and     arch.id_inter         	= int.id_i
		and 	intass.id_sin		= arch.id_sin
		and 	intass.cod_inter	= 'A'
		and 	pers.id_ordre		= sin.id_ordre
		and	prod.id_prod		= sin.id_prod
		and	eta.id_prod   		= sin.id_prod
		and	eta.id_ets  		= sin.id_ets
		and	eta.id_grp  		= grp.id_grp
		and	eta.id_rev    		= -1
		And Not exists ( 
			Select Top 1 1
			From sysadm.det_pro dp
			Where dp.id_prod = prod.id_prod
			And   dp.id_code_dp = 323
		 )
		And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
			  Or 
		      ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
            )

	End -- Fin R1A

	If @sCodeTrt = 'R2' 
	Begin 

		select  distinct 
				prod.id_prod,
				prod.lib_long,
				prod.lib_court,
				prod.id_dept,
				prod.id_depts

		From 	sysadm.sinistre 	sin with (nolock),
			sysadm.archive  	arch with (nolock),
			sysadm.inter		int with (nolock),
			sysadm.inter		intass with (nolock),
			sysadm.personne 	pers with (nolock),
			sysadm.produit		prod with (nolock),
			sysadm.groupe		grp with (nolock),
			sysadm.routage		rout with (nolock)


		Where	prod.cod_adh = '3'
		And     prod.alt_rl2 = 'O'
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	in ( 100, 550 )
		and    	sin.valide_le 		= arch.valide_le
		and     
		(
		  (
			( Substring ( arch.id_cour_orig, 2, 5 ) = 'LAX01' Or arch.id_cour_orig = 'ALQ001' )
			And arch.id_cour_orig is not null
		  ) 
		 OR
		  (
			( Substring ( arch.id_cour, 2, 5 ) = 'LAX01' Or arch.id_cour = 'ALQ001' )
			And arch.id_cour_orig is null
		  )
		)
		and     ( 
				  ( prod.unt_rl2 = 'J' 
					And arch.maj_le  <= Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl2 * (-1), getdate()), 103) + ' 00:00:00'
				  ) 
				  Or 
				  ( prod.unt_rl2 = 'M' 
					And arch.maj_le  <= Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl2 * (-1), getdate()), 103) + ' 00:00:00'
				  ) 
				  Or 
				  ( prod.unt_rl2 = 'A' 
					And arch.maj_le  <= Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl2 * (-1), getdate()), 103) + ' 00:00:00'
				  ) 
				)


		and     arch.cod_version     	= 2
		and     arch.nbr_conf         	= 0
		and     arch.id_sin           	= int.id_sin
		and     arch.id_inter         	= int.id_i
		and 	intass.id_sin		= arch.id_sin
		and 	intass.cod_inter	= 'A'
		and 	pers.id_ordre		= sin.id_ordre
		and	prod.id_prod		= sin.id_prod
		and	grp.id_grp		= sin.id_ets
		And Not exists ( 
			Select Top 1 1
			From sysadm.det_pro dp
			Where dp.id_prod = prod.id_prod
			And   dp.id_code_dp = 323
		 )
		And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
			  Or 
		      ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
            )

		Union all

		select  distinct 
				prod.id_prod,
				prod.lib_long,
				prod.lib_court,
				prod.id_dept,
				prod.id_depts


		From 	sysadm.sinistre 	sin with (nolock),
			sysadm.archive  	arch with (nolock),
			sysadm.inter		int with (nolock),
			sysadm.inter		intass with (nolock),
			sysadm.personne 	pers with (nolock),
			sysadm.produit		prod with (nolock),
			sysadm.groupe		grp with (nolock),
			sysadm.etablissement	eta with (nolock),
			sysadm.routage		rout with (nolock)

		Where	prod.cod_adh <> '3'
		And     prod.alt_rl2 = 'O'
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	in ( 100, 550 )
		and    	sin.valide_le 		= arch.valide_le
		and     
		(
		  (
			( Substring ( arch.id_cour_orig, 2, 5 ) = 'LAX01' Or arch.id_cour_orig = 'ALQ001' )
			And arch.id_cour_orig is not null
		  ) 
		 OR
		  (
			( Substring ( arch.id_cour, 2, 5 ) = 'LAX01' Or arch.id_cour = 'ALQ001' )
			And arch.id_cour_orig is null
		  )
		)

		and     ( 
				  ( prod.unt_rl2 = 'J' 
					And arch.maj_le  <= Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl2 * (-1), getdate()), 103) + ' 00:00:00'
				  ) 
				  Or 
				  ( prod.unt_rl2 = 'M' 
					And arch.maj_le  <= Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl2 * (-1), getdate()), 103) + ' 00:00:00'
				  ) 
				  Or 
				  ( prod.unt_rl2 = 'A' 
					And arch.maj_le  <= Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl2 * (-1), getdate()), 103) + ' 00:00:00'
				  ) 
				)
		and     arch.cod_version     	= 2
		and     arch.nbr_conf         	= 0
		and     arch.id_sin           	= int.id_sin
		and     arch.id_inter         	= int.id_i
		and 	intass.id_sin		= arch.id_sin
		and 	intass.cod_inter	= 'A'
		and 	pers.id_ordre		= sin.id_ordre
		and	prod.id_prod		= sin.id_prod
		and	eta.id_prod   		= sin.id_prod
		and	eta.id_ets  		= sin.id_ets
		and	eta.id_grp  		= grp.id_grp
		and	eta.id_rev    		= -1
		And Not exists ( 
			Select Top 1 1
			From sysadm.det_pro dp
			Where dp.id_prod = prod.id_prod
			And   dp.id_code_dp = 323
		 )
		And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
			  Or 
		      ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
            )

	End 

	If @sCodeTrt = 'R1U' 
	Begin 

		-- PremiŠre requˆte en regardant les piŠces coch‚s.
		select  distinct 
				prod.id_prod,
				prod.lib_long,
				prod.lib_court,
				prod.id_dept,
				prod.id_depts


		From 	sysadm.sinistre 	sin with (nolock),
			sysadm.w_piece		wp with (nolock),
			sysadm.archive  	arch with (nolock),
			sysadm.inter		int with (nolock),
			sysadm.inter		intass with (nolock),
			sysadm.personne 	pers with (nolock),
			sysadm.produit		prod with (nolock),
			sysadm.groupe		grp with (nolock),
			sysadm.routage		rout with (nolock)


		Where	prod.cod_adh = '3'
		And     prod.alt_rl1 = 'O'
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	 in ( 100, 550 )
		and    	sin.valide_le 		= arch.valide_le
		and     
		(
		  (
			(
			( Substring ( arch.id_cour_orig, 1, 2 ) = 'BC' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or arch.id_cour_orig = 'APART1' 
			) And arch.id_cour_orig is not null
		  ) 
		 OR
		  (
			(
			( Substring ( arch.id_cour, 1, 2 ) = 'BC' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour, 1, 1 ) = 'Q' Or arch.id_cour = 'APART1' 
			) And arch.id_cour_orig is null
		  )
		)

		and     ( 
				  ( prod.unt_rl1 = 'J' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'M' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'A' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				)
		and     arch.cod_version     	= 2
		and	arch.cod_inter		= 'B'
		and     arch.nbr_conf         	= 0
		and     arch.id_sin           	= int.id_sin
		and     arch.id_inter         	= int.id_i
		and	wp.id_sin		= sin.id_sin
		and	wp.id_gti		= 7
		and	wp.id_i			= int.id_i
		and 	intass.id_sin		= arch.id_sin
		and 	intass.cod_inter	= 'A'
		and 	pers.id_ordre		= sin.id_ordre
		and	prod.id_prod		= sin.id_prod
		and	grp.id_grp		= sin.id_ets
		And Not exists ( 
			Select Top 1 1
			From sysadm.det_pro dp
			Where dp.id_prod = prod.id_prod
			And   dp.id_code_dp = 323
		 )
		And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
			  Or 
		      ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
            )

		UNION ALL

		-- DeuxiŠme requˆte en regardant ALT_ATT coch‚.
		select  distinct 
				prod.id_prod,
				prod.lib_long,
				prod.lib_court,
				prod.id_dept,
				prod.id_depts


		From 	sysadm.sinistre 	sin,
			sysadm.w_gar_sin	wg,
			sysadm.archive  	arch,
			sysadm.inter		int,
			sysadm.inter		intass,
			sysadm.personne 	pers,
			sysadm.produit		prod,
			sysadm.groupe		grp,
			sysadm.routage		rout


		Where	prod.cod_adh = '3'
		And     prod.alt_rl1 = 'O'
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	 in ( 100, 550 )
		and    	sin.valide_le 		= arch.valide_le
		and     
		(
		  (
			(
			( Substring ( arch.id_cour_orig, 1, 2 ) = 'BC' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or arch.id_cour_orig = 'APART1' 
			) And arch.id_cour_orig is not null
		  ) 
		 OR
		  (
			(
			( Substring ( arch.id_cour, 1, 2 ) = 'BC' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour, 1, 1 ) = 'Q' Or arch.id_cour = 'APART1' 
			) And arch.id_cour_orig is null
		  )
		)

		and     ( 
				  ( prod.unt_rl1 = 'J' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'M' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'A' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				)
		and     arch.cod_version     	= 2
		and	arch.cod_inter		= 'B'
		and     arch.nbr_conf         	= 0
		and     arch.id_sin           	= int.id_sin
		and     arch.id_inter         	= int.id_i
		and	wg.id_sin		= sin.id_sin
		and	wg.id_gti		= 7
		and	wg.alt_att		= 'O' 
		and 	intass.id_sin		= arch.id_sin
		and 	intass.cod_inter	= 'A'
		and 	pers.id_ordre		= sin.id_ordre
		and	prod.id_prod		= sin.id_prod
		and	grp.id_grp		= sin.id_ets
		And Not exists ( 
			Select Top 1 1
			From sysadm.det_pro dp
			Where dp.id_prod = prod.id_prod
			And   dp.id_code_dp = 323
		 )
		And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
			  Or 
		      ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
            )

		union all
		-- PremiŠre requˆte en regardant les piŠces coch‚s.

		select  distinct 
				prod.id_prod,
				prod.lib_long,
				prod.lib_court,
				prod.id_dept,
				prod.id_depts

		From 	sysadm.sinistre 	sin with (nolock),
			sysadm.w_piece		wp with (nolock),
			sysadm.archive  	arch with (nolock),
			sysadm.inter		int with (nolock),
			sysadm.inter		intass with (nolock),
			sysadm.personne 	pers with (nolock),
			sysadm.produit		prod with (nolock),
			sysadm.groupe		grp with (nolock),
			sysadm.etablissement	eta with (nolock),
			sysadm.routage		rout with (nolock)


		Where	prod.cod_adh <> '3'
		And     prod.alt_rl1 = 'O'
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	 in ( 100, 550 )
		and    	sin.valide_le 		= arch.valide_le
		and     
		(
		  (
			(
			( Substring ( arch.id_cour_orig, 1, 2 ) = 'BC' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or arch.id_cour_orig = 'APART1' 
			) And arch.id_cour_orig is not null
		  ) 
		 OR
		  (
			(
			( Substring ( arch.id_cour, 1, 2 ) = 'BC' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour, 1, 1 ) = 'Q' Or arch.id_cour = 'APART1' 
			) And arch.id_cour_orig is null
		  )
		)

		and     ( 
				  ( prod.unt_rl1 = 'J' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'M' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'A' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				)
		and     arch.cod_version     	= 2
		and	arch.cod_inter		= 'B'
		and     arch.nbr_conf         	= 0
		and     arch.id_sin           	= int.id_sin
		and     arch.id_inter         	= int.id_i
		and	wp.id_sin		= sin.id_sin
		and	wp.id_gti		= 7
		and	wp.id_i			= int.id_i
		and 	intass.id_sin		= arch.id_sin
		and 	intass.cod_inter	= 'A'
		and 	pers.id_ordre		= sin.id_ordre
		and	prod.id_prod		= sin.id_prod
		and	eta.id_prod   		= sin.id_prod
		and	eta.id_ets  		= sin.id_ets
		and	eta.id_grp  		= grp.id_grp
		and	eta.id_rev    		= -1
		And Not exists ( 
			Select Top 1 1
			From sysadm.det_pro dp
			Where dp.id_prod = prod.id_prod
			And   dp.id_code_dp = 323
		 )
		And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
			  Or 
		      ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
            )

		UNION ALL

		-- DeuxiŠme requˆte en regardant ALT_ATT coch‚.
		select  distinct 
				prod.id_prod,
				prod.lib_long,
				prod.lib_court,
				prod.id_dept,
				prod.id_depts

		From 	sysadm.sinistre 	sin with (nolock),
			sysadm.w_gar_sin	wg with (nolock),
			sysadm.archive  	arch with (nolock),
			sysadm.inter		int with (nolock),
			sysadm.inter		intass with (nolock),
			sysadm.personne 	pers with (nolock),
			sysadm.produit		prod with (nolock),
			sysadm.groupe		grp with (nolock),
			sysadm.etablissement	eta with (nolock),
			sysadm.routage		rout with (nolock)


		Where	prod.cod_adh <> '3'
		And     prod.alt_rl1 = 'O'
		and     rout.id_sin		= sin.id_sin
		and     rout.alt_queue		= 'N'
		and	sin.id_sin 		= arch.id_sin
		and    	sin.cod_etat      	 in ( 100, 550 )
		and    	sin.valide_le 		= arch.valide_le
		and     
		(
		  (
			(
			( Substring ( arch.id_cour_orig, 1, 2 ) = 'BC' and Substring ( arch.id_cour_orig, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour_orig, 1, 1 ) = 'Q' Or arch.id_cour_orig = 'APART1'
			) And arch.id_cour_orig is not null
		  ) 
		 OR
		  (
			(
			( Substring ( arch.id_cour, 1, 2 ) = 'BC' and Substring ( arch.id_cour, 4, 1 ) = 'P' ) Or Substring ( arch.id_cour, 1, 1 ) = 'Q' Or arch.id_cour = 'APART1'
			) And arch.id_cour_orig is null
		  )
		)

		and     ( 
				  ( prod.unt_rl1 = 'J' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( day, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'M' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( month, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				  Or 
				  ( prod.unt_rl1 = 'A' 
					And arch.valide_le  between Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_max * (-1), getdate()), 103) + ' 00:00:00'
										and Convert ( varchar ( 10), DateAdd ( year, prod.dur_rl1_min * (-1), getdate()), 103) + ' 23:59:00'
				  ) 
				)
		and     arch.cod_version     	= 2
		and	arch.cod_inter		= 'B'
		and     arch.nbr_conf         	= 0
		and     arch.id_sin           	= int.id_sin
		and     arch.id_inter         	= int.id_i
		and	wg.id_sin		= sin.id_sin
		and	wg.id_gti		= 7
		and	wg.alt_att		= 'O' 
		and 	intass.id_sin		= arch.id_sin
		and 	intass.cod_inter	= 'A'
		and 	pers.id_ordre		= sin.id_ordre
		and	prod.id_prod		= sin.id_prod
		and	eta.id_prod   		= sin.id_prod
		and	eta.id_ets  		= sin.id_ets
		and	eta.id_grp  		= grp.id_grp
		and	eta.id_rev    		= -1
		And Not exists ( 
			Select Top 1 1
			From sysadm.det_pro dp
			Where dp.id_prod = prod.id_prod
			And   dp.id_code_dp = 323
		 )
		And ( sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') <= 0 
			  Or 
		      ( SHERPA_SIM.sysadm.FN_Recla_Verifier_Sinistre ( sin.id_sin, 2 ) <= 0 And sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 ) -- [RS3179]
            )

	End 
END 

GO

