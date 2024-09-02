-------------------------------------------------------------------
--
-- Fichier              :       STATS_1.CP
-- Auteur               :       DBI
-- Date                 :       22/01/1999 11:27:57
--
-- Commentaires         :       Gestion des statistiques
--
-- Procédures           :       DW_S01_STSIN_ENCI
--				DW_S01_STSIN_ENCIENCR
--				DW_S01_STSIN_REFU
--				DW_S02_STSIN_REFU_TEL	    // Liste des refus pour la téléphonie
--				DW_S03_STSIN_ENCOURS_TEL    // Liste des en cours pour la téléphonie	
--				DW_S04_STSIN_SSUITE_TEL     // Liste des sans suite pour la téléphonie	
--				DW_S05_STSIN_ENCOURS_TEL    // Liste des en cours avec une dte de cmd.
--				DW_S06_STSIN_OUV_TEL	    // Liste des garanties ouvertes pour la téléphonie
--
--				DW_S01_STSIN_OUV
--				DW_S02_STSIN_REGREFSSU
--				DW_S03_STSIN_MOTIF_REFUS    
--
--				// 4 Stat Hebdo pour SFR PGC(DNT)		
--				DW_S01_REELLE_SFRPGC	    // Tout sauf Regles, et refuses
--				DW_S02_REELLE_SFRPGC	    // Tous les regle et en cours de reglement
--				DW_S03_REELLE_SFRPGC	    // Tous les dossiers refusés ayant une garantie refusées
--				DW_S04_REELLE_SFRPGC	    // Tous les motifs de refus sur les dossiers refusés
--				DW_S05_REELLE_SFRPGC	    // Montant du préjudice des détails en attente
--				DW_S01_REELLE_DETSIN_TEL    // Liste des sinistres pour produits de téléphonie
--				DW_S01_DNT_STAT_COURRIER    // DEEI 3102 Stat DNT (courrier)
--				DW_S01_DFC_STAT_ECART_AXA_CARDIFF // Stat créé sur mesure pour repérer les écart AXA/CARDIF pour le 201,202,203
--                              DW_S06_STOCK_FINAREF        //DCMP 050540 : Stat Stock Finaref
--				DW_S06_REELLE_PRODUIT		//DCMP 60283 Statistique mensuelle produit réelle
-- 				DW_S07_REELLE_DOSSIER_DNT_FORCES //DCMP 60211 Statistique mensuelle sur forcage des dossiers
--				DW_S08_REGL_FOURN_COMPTA	//[DCMP060503] PHG 05/07/2006 : Statistique Mensuelle : Liste des Reglement Fournisseurs pour la compta
--				DW_S09_PEC_MEDIA_SATURN	// [DCMP070168] JFF 24/09/2007 : Statistique Mensuelle pour média saturn
--				PS_S01_EXTRACTION_UF	// [DCMP060417] PHG 18/07/2006 : Extraction Hebdomadaire des Utilisation Frauduleuse de Carte.
--				PS_S02_EXTRACTION_UF	// [DCMP060417] PHG 18/07/2006 : Envoi du resultat de ci-dessus par mail.
--				DW_S10_ETAT_FINAREF     // [DCMP070774] JFF le 06/11/2007
--				DW_S11_ETAT_REGL_FRN_PAR_BOUTIQUE    // [DCMP070841] JFF le 08/11/2007
--				DW_S12_ETAT_REGL_FRN_PAR_SINISTRE
--				DW_S11_SCORE_GAME
--				DW_S12_SCORE_GAME
--				DW_S13_NB_FACTURE_FRN_MOIS
--				DW_S14_STAT_UTILISATION_COURRIER
--				DW_S01_ETAT_BASE_SIN_CELL_PRESTA
--				DW_S11_SURCOUF_ECHANGES_EXPRESS
--				PS_S03_EXTRACTION_REFUS_IRREPARABLE	// [DCMP080077] - [DCMP090280]
--				PS_S04_EXTRACTION_REFUS_IRREPARABLE_MAIL // [DCMP080077] - [DCMP090280]
--				PS_S05_EXTRACTION_IFR_3_MOIS	// [DCMP080374] 
--				PS_S06_EXTRACTION_IFR_3_MOIS_MAIL // [DCMP080374] 
--				PS_S07_EXTRACTION_FNAC_TV_HEBDO // [DCMP080562] 
--				PS_S08_EXTRACTION_FNAC_TV_HEBDO_MAIL // [DCMP080562] 
--				DW_S15_ETAT_PRESTA_MSS_POUR_O2M // [DCMP080599]
--				DW_S16_SURCOUF_PIXEL // [DCMP080809]
--				PS_S09_080887_IPHONE // [DCMP080887]
--				PS_S09_080887_IPHONE_MAIL // [DCMP080887]
--				PS_S10_FNAC_EPT_ATTITUDE 
--				PS_S10_FNAC_EPT_ATTITUDE_MAIL 
--				PS_S11_BVIOX_REGLE // [DCMP090118] - [DCMP090280]
--				PS_S11_BVIOX_REGLE_MAIL // [DCMP090118] - [DCMP090280]
--				PS_S12_090200_LCL_HEBDO // [DCMP090200]
--				PS_S12_090200_LCL_HEBDO_MAIL // [DCMP090200]
--				PS_S13_100375_ASS_TOUS_MOBILES // [DCMP100375]
--				PS_S13_100375_ASS_TOUS_MOBILES_MAIL // [DCMP100375]
-- 				PS_S14_MCM_REGLE
-- 				PS_S14_MCM_REGLE_CSV
--				DW_S17_FOUR_FACTU [DCMP090648]
--				DW_S01_RELANCE_BOUTIQUE_BROKER
-------------------------------------------------------------------


--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_STSIN_ENCI
-- Auteur               :       DBI
-- Date                 :       22/01/1999
-- Libellé              :       Liste des garanties en cours d'instruction
--				
-- Commentaires         :       si @dcIdEts = -1 on s‚lectionne tous les ets
--						
--				
-- Références           :       Datawindow : D_L_ENCI1
--
-- Arguments            :       @dcPeriodeMax   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
--				@dcIdEts	Decimal(7)		(Val)
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 - FPI - 04/12/2009 - [EXPANSION5.LIB_POLICE] 
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_STSIN_ENCI' AND type = 'P' )
        DROP procedure sysadm.DW_S01_STSIN_ENCI
GO


CREATE procedure sysadm.DW_S01_STSIN_ENCI
		@dcPeriodeMax	Decimal(7),
		@dcIdProd	Decimal(7),
		@dcIdEts	Decimal(7)	WITH RECOMPILE

AS

SET NOCOUNT ON

Declare	@dcIdRgpt	Decimal (7)
Declare	@dcIdGti	Decimal (7)
Declare	@dcCpt		Decimal (7)
Declare	@dcIdPolice	Decimal (7)
Declare	@sLibRgpt	VarChar (35)

--********************************************************
--
-- Lecture id_police table produit
--
--********************************************************

Select @dcIdPolice = produit.id_police
From   sysadm.produit
where  id_prod 	   = @dcIdProd

--********************************************************
--
-- Curseur pour lecture des garanties du produit
--
--********************************************************

Declare s_code_gti
Cursor  for
Select  id_gti, id_gti, lib_code
From    sysadm.code_garantie, sysadm.code
where   code_garantie.id_prod	= @dcIdProd
And	code_garantie.id_gti	= code.id_code
And	code.id_typ_code	= '-GS'
Union
Select  code_garantie.id_gti, code.id_code, lib_code
From    sysadm.code_garantie, sysadm.code
where   code_garantie.id_prod	= @dcIdProd
And	code_garantie.id_gti	= 7
And	code.id_code		Between 700 and 799
And	code.id_typ_code	= '-GS'

--********************************************************
--
-- Création d'une table temporaire pour mise à plat de la liste des
-- garanties en cours par dossier
--
--********************************************************

Create table #Enci
 (  	id_sin		Decimal(10), -- [PI062]
	id_police	Decimal(7),
	dcIdRgpt1	Decimal(7)	Null,
	sLibRgpt1	VarChar(35)	Null,
	dcCpt1		Decimal(7)	Null,
	dcIdRgpt2	Decimal(7)	Null,
	sLibRgpt2	VarChar(35)	Null,
	dcCpt2		Decimal(7)	Null,
	dcIdRgpt3	Decimal(7)	Null,
	sLibRgpt3	VarChar(35)	Null,
	dcCpt3		Decimal(7)	Null,
	dcIdRgpt4	Decimal(7)	Null,
	sLibRgpt4	VarChar(35)	Null,
	dcCpt4		Decimal(7)	Null,
	dcIdRgpt5	Decimal(7)	Null,
	sLibRgpt5	VarChar(35)	Null,
	dcCpt5		Decimal(7)	Null,
	dcIdRgpt6	Decimal(7)	Null,
	sLibRgpt6	VarChar(35)	Null,
	dcCpt6		Decimal(7)	Null,
	dcIdRgpt7	Decimal(7)	Null,
	sLibRgpt7	VarChar(35)	Null,
	dcCpt7		Decimal(7)	Null,
	dcIdRgpt8	Decimal(7)	Null,
	sLibRgpt8	VarChar(35)	Null,
	dcCpt8		Decimal(7)	Null,
	dcIdRgpt9	Decimal(7)	Null,
	sLibRgpt9	VarChar(35)	Null,
	dcCpt9		Decimal(7)	Null,
	dcIdRgpt10	Decimal(7)	Null,
	sLibRgpt10	VarChar(35)	Null,
	dcCpt10		Decimal(7) 	Null
 )

--********************************************************
--
-- Pour chaque garantie du produit, insertion des enregistrements
-- dans #Enci à partir de stat_sin
--
--********************************************************

Open	s_code_gti

Fetch	s_code_gti
Into	@dcIdGti, @dcIdRgpt, @sLibRgpt

Select	@dcCpt	=	0

WHILE ( @@FETCH_STATUS <> -1 )
BEGIN

 Select	@dcCpt	= @dcCpt + 1

 If ( @dcCpt = 1 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	= 100			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt1 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End
 End

 If ( @dcCpt = 2 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	= 100			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt2 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 3 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
 	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	= 100			And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt3 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End
 End

 If ( @dcCpt = 4 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	= 100			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt4 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End
 End

 If ( @dcCpt = 5 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	= 100			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt5 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 6 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
		null, null, 0, 	 
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	= 100			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt6 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 7)
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	= 100			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt7 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 8)
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	= 100			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt8 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 9)
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	= 100			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt9 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 10)
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0,
	 id_rgpt, @sLibRgpt, 1
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	= 100			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt10 = @sLibRgpt
		Where	id_sin	   = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 Fetch	s_code_gti
 Into	@dcIdGti, @dcIdRgpt, @sLibRgpt

END

--********************************************************
--
-- Select pour la datawindow
--
--********************************************************

Select 
 @dcPeriodeMax,
 sinistre.id_sin,
 produit.lib_long,
 departement.lib_dept,
 sinistre.dte_surv,
 DatePart ( Year, sinistre.dte_surv ),
 sinistre.dte_decl,
 groupe.id_grp,
 codeNs.lib_code,
 groupe.lib_grp,
 personne.nom,
 personne.prenom,
 police.lib_police,
 compagnie.lib_cie,
 dcIdRgpt1,
 sLibRgpt1	,
 dcCpt1		,
 dcIdRgpt2	,
 sLibRgpt2	,
 dcCpt2		,
 dcIdRgpt3	,
 sLibRgpt3	,
 dcCpt3		,
 dcIdRgpt4	,
 sLibRgpt4	,
 dcCpt4		,
 dcIdRgpt5	,
 sLibRgpt5 	,
 dcCpt5		,
 dcIdRgpt6	,
 sLibRgpt6	,
 dcCpt6		,
 dcIdRgpt7	,
 sLibRgpt7	,
 dcCpt7		,
 dcIdRgpt8	,
 sLibRgpt8	,
 dcCpt8		,
 dcIdRgpt9	,
 sLibRgpt9	,
 dcCpt9		,
 dcIdRgpt10	,
 sLibRgpt10	,
 dcCpt10		
From   	#Enci,
	sysadm.sinistre,
	sysadm.personne,
 	sysadm.produit,
	sysadm.departement,
	sysadm.code codeNs,
	sysadm.groupe,
	sysadm.etablissement,
	sysadm.police,
	sysadm.compagnie
where   sinistre.id_sin 	= #Enci.id_sin
And	sinistre.id_ordre 	= personne.id_ordre
And	sinistre.id_prod 	= produit.id_prod
And	produit.id_dept		= departement.id_dept
And	codeNs.id_typ_code	= '+NS'
And	codeNs.id_code		= sinistre.id_natsin
And	groupe.id_grp		= etablissement.id_grp
And	etablissement.id_prod	= sinistre.id_prod
And	etablissement.id_ets	= sinistre.id_ets
And	etablissement.id_rev	= -1
And	produit.cod_adh		<> '3'
And	police.id_police	= #Enci.id_police
And	police.id_cie		= compagnie.id_cie
UNION ALL
Select 
 @dcPeriodeMax,
 sinistre.id_sin,
 produit.lib_long,
 departement.lib_dept,
 sinistre.dte_surv,
 DatePart ( Year, sinistre.dte_surv ),
 sinistre.dte_decl,
 groupe.id_grp,
 codeNs.lib_code,
 groupe.lib_grp,
 personne.nom,
 personne.prenom,
 police.lib_police,
 compagnie.lib_cie,
 dcIdRgpt1,
 sLibRgpt1	,
 dcCpt1		,
 dcIdRgpt2	,
 sLibRgpt2	,
 dcCpt2		,
 dcIdRgpt3	,
 sLibRgpt3	,
 dcCpt3		,
 dcIdRgpt4	,
 sLibRgpt4	,
 dcCpt4		,
 dcIdRgpt5	,
 sLibRgpt5 	,
 dcCpt5		,
 dcIdRgpt6	,
 sLibRgpt6	,
 dcCpt6		,
 dcIdRgpt7	,
 sLibRgpt7	,
 dcCpt7		,
 dcIdRgpt8	,
 sLibRgpt8	,
 dcCpt8		,
 dcIdRgpt9	,
 sLibRgpt9	,
 dcCpt9		,
 dcIdRgpt10	,
 sLibRgpt10	,
 dcCpt10		
From   	#Enci,
	sysadm.sinistre,
	sysadm.personne,
 	sysadm.produit,
	sysadm.departement,
	sysadm.code codeNs,
	sysadm.groupe,
	sysadm.police,
	sysadm.compagnie
where   sinistre.id_sin 	= #Enci.id_sin
And	sinistre.id_ordre 	= personne.id_ordre
And	sinistre.id_prod 	= produit.id_prod
And	produit.id_dept		= departement.id_dept
And	codeNs.id_typ_code	= '+NS'
And	codeNs.id_code		= sinistre.id_natsin
And	groupe.id_grp		= sinistre.id_ets
And	produit.cod_adh		= '3'
And	police.id_police	= #Enci.id_police
And	police.id_cie		= compagnie.id_cie



Drop table #Enci

Close 		s_code_gti
Deallocate 	s_code_gti

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_STSIN_REFU
-- Auteur               :       DBI
-- Date                 :       22/01/1999
-- Libellé              :       Liste des garanties refus‚es
--				
-- Commentaires         :       
--				
--				
-- Références           :       Datawindow : D_L_REF1
--
-- Arguments            :       @dcPeriodeMin   Decimal(7)              (Val)
--				@dcPeriodeMax   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 - FPI - 04/12/2009 - [EXPANSION5.LIB_POLICE] 
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_STSIN_REFU' AND type = 'P' )
        DROP procedure sysadm.DW_S01_STSIN_REFU
GO

CREATE procedure sysadm.DW_S01_STSIN_REFU
		@dcPeriodeMin	Decimal(7),
		@dcPeriodeMax	Decimal(7),
		@dcIdProd	Decimal(7),
		@dcIdEts	Decimal(7)	WITH RECOMPILE

AS

SET NOCOUNT ON

Declare	@dcIdRgpt	Decimal (7)
Declare	@dcIdGti	Decimal (7)
Declare	@dcCpt		Decimal (7)
Declare	@dcIdPolice	Decimal (7)
Declare	@sLibRgpt	VarChar (35)

--********************************************************
--
-- Lecture id_police table produit
--
--********************************************************

Select @dcIdPolice = produit.id_police
From   sysadm.produit
where  id_prod 	   = @dcIdProd

--********************************************************
--
-- Curseur pour lecture des garanties du produit
--
--********************************************************

Declare s_code_gti
Cursor  for
Select  id_gti, id_gti, lib_code
From    sysadm.code_garantie, sysadm.code
where   code_garantie.id_prod	= @dcIdProd
And	code_garantie.id_gti	= code.id_code
And	code.id_typ_code	= '-GS'
Union
Select  code_garantie.id_gti, code.id_code, lib_code
From    sysadm.code_garantie, sysadm.code
where   code_garantie.id_prod	= @dcIdProd
And	code_garantie.id_gti	= 7
And	code.id_code		Between 700 and 799
And	code.id_typ_code	= '-GS'

--********************************************************
--
-- Création d'une table temporaire pour mise à plat de la liste des
-- garanties en cours par dossier
--
--********************************************************

Create table #Enci
 (  	id_sin		Decimal(10), -- [PI062]
	id_police	Decimal(7),
	dcIdRgpt1	Decimal(7)	Null,
	sLibRgpt1	VarChar(35)	Null,
	dcCpt1		Decimal(7)	Null,
	dcIdRgpt2	Decimal(7)	Null,
	sLibRgpt2	VarChar(35)	Null,
	dcCpt2		Decimal(7)	Null,
	dcIdRgpt3	Decimal(7)	Null,
	sLibRgpt3	VarChar(35)	Null,
	dcCpt3		Decimal(7)	Null,
	dcIdRgpt4	Decimal(7)	Null,
	sLibRgpt4	VarChar(35)	Null,
	dcCpt4		Decimal(7)	Null,
	dcIdRgpt5	Decimal(7)	Null,
	sLibRgpt5	VarChar(35)	Null,
	dcCpt5		Decimal(7)	Null,
	dcIdRgpt6	Decimal(7)	Null,
	sLibRgpt6	VarChar(35)	Null,
	dcCpt6		Decimal(7)	Null,
	dcIdRgpt7	Decimal(7)	Null,
	sLibRgpt7	VarChar(35)	Null,
	dcCpt7		Decimal(7)	Null,
	dcIdRgpt8	Decimal(7)	Null,
	sLibRgpt8	VarChar(35)	Null,
	dcCpt8		Decimal(7)	Null,
	dcIdRgpt9	Decimal(7)	Null,
	sLibRgpt9	VarChar(35)	Null,
	dcCpt9		Decimal(7)	Null,
	dcIdRgpt10	Decimal(7)	Null,
	sLibRgpt10	VarChar(35)	Null,
	dcCpt10		Decimal(7) 	Null
 )

--********************************************************
--
-- Pour chaque garantie du produit, insertion des enregistrements
-- dans #Enci à partir de stat_sin
--
--********************************************************

Open	s_code_gti

Fetch	s_code_gti
Into	@dcIdGti, @dcIdRgpt, @sLibRgpt

Select	@dcCpt	=	0

WHILE ( @@FETCH_STATUS <> -1 )
BEGIN

 Select	@dcCpt	= @dcCpt + 1

 If ( @dcCpt = 1 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cod_etat	= 200			And
	 stat_sin.cpt_etat	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt1 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End
 End

 If ( @dcCpt = 2 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cod_etat	= 200			And
	 stat_sin.cpt_etat	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt2 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 3 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
 	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cod_etat	= 200			And
	 stat_sin.cpt_etat	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt3 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End
 End

 If ( @dcCpt = 4 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cod_etat	= 200			And
	 stat_sin.cpt_etat	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt4 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End
 End

 If ( @dcCpt = 5 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cod_etat	= 200			And
	 stat_sin.cpt_etat	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt5 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 6 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
		null, null, 0, 	 
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cod_etat	= 200			And
	 stat_sin.cpt_etat	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt6 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 7)
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cod_etat	= 200			And
	 stat_sin.cpt_etat	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt7 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 8)
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cod_etat	= 200			And
	 stat_sin.cpt_etat	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt8 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 9)
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cod_etat	= 200			And
	 stat_sin.cpt_etat	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt9 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 10)
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0,
	 id_rgpt, @sLibRgpt, 1
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cod_etat	= 200			And
	 stat_sin.cpt_etat	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt10 = @sLibRgpt
		Where	id_sin	   = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 Fetch	s_code_gti
 Into	@dcIdGti, @dcIdRgpt, @sLibRgpt

END

--********************************************************
--
-- Select pour la datawindow
--
--********************************************************


Select 
 @dcPeriodeMax,
 sinistre.id_sin,
 produit.lib_long,
 departement.lib_dept,
 sinistre.dte_surv,
 DatePart ( Year, sinistre.dte_surv ),
 sinistre.dte_decl,
 groupe.id_grp,
 codeNs.lib_code,
 groupe.lib_grp,
 personne.nom,
 personne.prenom,
 police.lib_police,
 compagnie.lib_cie,
 dcIdRgpt1,
 sLibRgpt1	,
 dcCpt1		,
 dcIdRgpt2	,
 sLibRgpt2	,
 dcCpt2		,
 dcIdRgpt3	,
 sLibRgpt3	,
 dcCpt3		,
 dcIdRgpt4	,
 sLibRgpt4	,
 dcCpt4		,
 dcIdRgpt5	,
 sLibRgpt5 	,
 dcCpt5		,
 dcIdRgpt6	,
 sLibRgpt6	,
 dcCpt6		,
 dcIdRgpt7	,
 sLibRgpt7	,
 dcCpt7		,
 dcIdRgpt8	,
 sLibRgpt8	,
 dcCpt8		,
 dcIdRgpt9	,
 sLibRgpt9	,
 dcCpt9		,
 dcIdRgpt10	,
 sLibRgpt10	,
 dcCpt10		
From   	#Enci,
	sysadm.sinistre,
	sysadm.personne,
 	sysadm.produit,
	sysadm.departement,
	sysadm.code codeNs,
	sysadm.groupe,
	sysadm.etablissement,
	sysadm.police,
	sysadm.compagnie
where   sinistre.id_sin 	= #Enci.id_sin
And	sinistre.id_ordre 	= personne.id_ordre
And	sinistre.id_prod 	= produit.id_prod
And	produit.id_dept		= departement.id_dept
And	codeNs.id_typ_code	= '+NS'
And	codeNs.id_code		= sinistre.id_natsin
And	groupe.id_grp		= etablissement.id_grp
And	etablissement.id_prod	= sinistre.id_prod
And	etablissement.id_ets	= sinistre.id_ets
And	etablissement.id_rev	= -1
And	produit.cod_adh		<> '3'
And	police.id_police	= #Enci.id_police
And	police.id_cie		= compagnie.id_cie
UNION ALL
Select 
 @dcPeriodeMax,
 sinistre.id_sin,
 produit.lib_long,
 departement.lib_dept,
 sinistre.dte_surv,
 DatePart ( Year, sinistre.dte_surv ),
 sinistre.dte_decl,
 groupe.id_grp,
 codeNs.lib_code,
 groupe.lib_grp,
 personne.nom,
 personne.prenom,
 police.lib_police,
 compagnie.lib_cie,
 dcIdRgpt1,
 sLibRgpt1	,
 dcCpt1		,
 dcIdRgpt2	,
 sLibRgpt2	,
 dcCpt2		,
 dcIdRgpt3	,
 sLibRgpt3	,
 dcCpt3		,
 dcIdRgpt4	,
 sLibRgpt4	,
 dcCpt4		,
 dcIdRgpt5	,
 sLibRgpt5 	,
 dcCpt5		,
 dcIdRgpt6	,
 sLibRgpt6	,
 dcCpt6		,
 dcIdRgpt7	,
 sLibRgpt7	,
 dcCpt7		,
 dcIdRgpt8	,
 sLibRgpt8	,
 dcCpt8		,
 dcIdRgpt9	,
 sLibRgpt9	,
 dcCpt9		,
 dcIdRgpt10	,
 sLibRgpt10	,
 dcCpt10		
From   	#Enci,
	sysadm.sinistre,
	sysadm.personne,
 	sysadm.produit,
	sysadm.departement,
	sysadm.code codeNs,
	sysadm.groupe,
	sysadm.police,
	sysadm.compagnie
where   sinistre.id_sin 	= #Enci.id_sin
And	sinistre.id_ordre 	= personne.id_ordre
And	sinistre.id_prod 	= produit.id_prod
And	produit.id_dept		= departement.id_dept
And	codeNs.id_typ_code	= '+NS'
And	codeNs.id_code		= sinistre.id_natsin
And	groupe.id_grp		= sinistre.id_ets
And	produit.cod_adh		= '3'
And	police.id_police	= #Enci.id_police
And	police.id_cie		= compagnie.id_cie



Drop table #Enci

Close 		s_code_gti
Deallocate 	s_code_gti

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_STSIN_OUV
-- Auteur               :       DBI
-- Date                 :       22/01/1999
-- Libellé              :       Liste des garanties ouvertes
--				
-- Commentaires         :       
--				
--				
-- Références           :       Datawindow : D_L_OUV1, D_L_OUV2
--
-- Arguments            :       @dcPeriodeMin   Decimal(7)              (Val)
--				@dcPeriodeMax   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 - FPI - 04/12/2009 - [EXPANSION5.LIB_POLICE] 
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_STSIN_OUV' AND type = 'P' )
        DROP procedure sysadm.DW_S01_STSIN_OUV
GO

CREATE procedure sysadm.DW_S01_STSIN_OUV
		@dcPeriodeMin	Decimal(7),
		@dcPeriodeMax	Decimal(7),
		@dcIdProd	Decimal(7),
		@dcIdEts	Decimal(7)	WITH RECOMPILE

AS

SET NOCOUNT ON

Declare	@dcIdRgpt	Decimal (7)
Declare	@dcIdGti	Decimal (7)
Declare	@dcCpt		Decimal (7)
Declare	@dcIdPolice	Decimal (7)
Declare	@sLibRgpt	VarChar (35)

--********************************************************
--
-- Lecture id_police table produit
--
--********************************************************

Select @dcIdPolice = produit.id_police
From   sysadm.produit
where  id_prod 	   = @dcIdProd

--********************************************************
--
-- Curseur pour lecture des garanties du produit
--
--********************************************************

Declare s_code_gti
Cursor  for
Select  id_gti, id_gti, lib_code
From    sysadm.code_garantie, sysadm.code
where   code_garantie.id_prod	= @dcIdProd
And	code_garantie.id_gti	= code.id_code
And	code.id_typ_code	= '-GS'
Union
Select  code_garantie.id_gti, code.id_code, lib_code
From    sysadm.code_garantie, sysadm.code
where   code_garantie.id_prod	= @dcIdProd
And	code_garantie.id_gti	= 7
And	code.id_code		Between 700 and 799
And	code.id_typ_code	= '-GS'

--********************************************************
--
-- Création d'une table temporaire pour mise à plat de la liste des
-- garanties en cours par dossier
--
--********************************************************

Create table #Enci
 (  	id_sin		Decimal(10), -- [PI062]
	id_police	Decimal(7),
	dcIdRgpt1	Decimal(7)	Null,
	sLibRgpt1	VarChar(35)	Null,
	dcCpt1		Decimal(7)	Null,
	dcIdRgpt2	Decimal(7)	Null,
	sLibRgpt2	VarChar(35)	Null,
	dcCpt2		Decimal(7)	Null,
	dcIdRgpt3	Decimal(7)	Null,
	sLibRgpt3	VarChar(35)	Null,
	dcCpt3		Decimal(7)	Null,
	dcIdRgpt4	Decimal(7)	Null,
	sLibRgpt4	VarChar(35)	Null,
	dcCpt4		Decimal(7)	Null,
	dcIdRgpt5	Decimal(7)	Null,
	sLibRgpt5	VarChar(35)	Null,
	dcCpt5		Decimal(7)	Null,
	dcIdRgpt6	Decimal(7)	Null,
	sLibRgpt6	VarChar(35)	Null,
	dcCpt6		Decimal(7)	Null,
	dcIdRgpt7	Decimal(7)	Null,
	sLibRgpt7	VarChar(35)	Null,
	dcCpt7		Decimal(7)	Null,
	dcIdRgpt8	Decimal(7)	Null,
	sLibRgpt8	VarChar(35)	Null,
	dcCpt8		Decimal(7)	Null,
	dcIdRgpt9	Decimal(7)	Null,
	sLibRgpt9	VarChar(35)	Null,
	dcCpt9		Decimal(7)	Null,
	dcIdRgpt10	Decimal(7)	Null,
	sLibRgpt10	VarChar(35)	Null,
	dcCpt10		Decimal(7) 	Null
 )

--********************************************************
--
-- Pour chaque garantie du produit, insertion des enregistrements
-- dans #Enci à partir de stat_sin
--
--********************************************************

Open	s_code_gti

Fetch	s_code_gti
Into	@dcIdGti, @dcIdRgpt, @sLibRgpt

Select	@dcCpt	=	0

WHILE ( @@FETCH_STATUS <> -1 )
BEGIN

 Select	@dcCpt	= @dcCpt + 1

 If ( @dcCpt = 1 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cpt_ouv	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt1 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End
 End

 If ( @dcCpt = 2 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cpt_ouv	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt2 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 3 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
 	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cpt_ouv	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt3 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End
 End

 If ( @dcCpt = 4 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cpt_ouv	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt4 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End
 End

 If ( @dcCpt = 5 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0,
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cpt_ouv	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt5 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 6 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
		null, null, 0, 	 
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cpt_ouv	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt6 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 7)
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cpt_ouv	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt7 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 8)
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0, null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cpt_ouv	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt8 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 9)
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 id_rgpt, @sLibRgpt, 1, 	
	 	null, null, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cpt_ouv	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt9 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 10)
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0, 	 
	 null, null, 0,
	 id_rgpt, @sLibRgpt, 1
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode between @dcPeriodeMin and @dcPeriodeMax And
	 stat_sin.cpt_ouv	= 1			And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt10 = @sLibRgpt
		Where	id_sin	   = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 Fetch	s_code_gti
 Into	@dcIdGti, @dcIdRgpt, @sLibRgpt

END

--********************************************************
--
-- Select pour la datawindow
-- 
--********************************************************
--********************************************************
-- MODIF JFF le 10/03/1999 : Je rajoute le numÚro d'adhÚsion
-- suite DCMP 990116 et DMDI 3447
--********************************************************

Select 
 @dcPeriodeMax,
 sinistre.id_sin,
 produit.lib_long,
 Replicate ('0', 5 - DATALENGTH ( Convert ( varchar(6), sinistre.id_ets ))) + Convert ( varchar(6), sinistre.id_ets ) + '-' + Replicate ('0', 7 - DATALENGTH ( sinistre.id_adh ) ) + sinistre.id_adh + '-' + Convert ( varchar(6), sinistre.id_sdos ),
 departement.lib_dept,
 sinistre.dte_surv,
 DatePart ( Year, sinistre.dte_surv ),
 sinistre.dte_decl,
 groupe.id_grp,
 codeNs.lib_code,
 groupe.lib_grp,
 personne.nom,
 personne.prenom,
 police.lib_police,
 compagnie.lib_cie,
 dcIdRgpt1,
 sLibRgpt1	,
 dcCpt1		,
 dcIdRgpt2	,
 sLibRgpt2	,
 dcCpt2		,
 dcIdRgpt3	,
 sLibRgpt3	,
 dcCpt3		,
 dcIdRgpt4	,
 sLibRgpt4	,
 dcCpt4		,
 dcIdRgpt5	,
 sLibRgpt5 	,
 dcCpt5		,
 dcIdRgpt6	,
 sLibRgpt6	,
 dcCpt6		,
 dcIdRgpt7	,
 sLibRgpt7	,
 dcCpt7		,
 dcIdRgpt8	,
 sLibRgpt8	,
 dcCpt8		,
 dcIdRgpt9	,
 sLibRgpt9	,
 dcCpt9		,
 dcIdRgpt10	,
 sLibRgpt10	,
 dcCpt10		
From   	#Enci,
	sysadm.sinistre,
	sysadm.personne,
 	sysadm.produit,
	sysadm.departement,
	sysadm.code codeNs,
	sysadm.groupe,
	sysadm.etablissement,
	sysadm.police,
	sysadm.compagnie
where   sinistre.id_sin 	= #Enci.id_sin
And	sinistre.id_ordre 	= personne.id_ordre
And	sinistre.id_prod 	= produit.id_prod
And	produit.id_dept		= departement.id_dept
And	codeNs.id_typ_code	= '+NS'
And	codeNs.id_code		= sinistre.id_natsin
And	groupe.id_grp		= etablissement.id_grp
And	etablissement.id_prod	= sinistre.id_prod
And	etablissement.id_ets	= sinistre.id_ets
And	etablissement.id_rev	= -1
And	produit.cod_adh		<> '3'
And	police.id_police	= #Enci.id_police
And	police.id_cie		= compagnie.id_cie
UNION ALL
Select 
 @dcPeriodeMax,
 sinistre.id_sin,
 produit.lib_long,
 sinistre.id_adh,
 departement.lib_dept,
 sinistre.dte_surv,
 DatePart ( Year, sinistre.dte_surv ),
 sinistre.dte_decl,
 groupe.id_grp,
 codeNs.lib_code,
 groupe.lib_grp,
 personne.nom,
 personne.prenom,
 police.lib_police,
 compagnie.lib_cie,
 dcIdRgpt1,
 sLibRgpt1	,
 dcCpt1		,
 dcIdRgpt2	,
 sLibRgpt2	,
 dcCpt2		,
 dcIdRgpt3	,
 sLibRgpt3	,
 dcCpt3		,
 dcIdRgpt4	,
 sLibRgpt4	,
 dcCpt4		,
 dcIdRgpt5	,
 sLibRgpt5 	,
 dcCpt5		,
 dcIdRgpt6	,
 sLibRgpt6	,
 dcCpt6		,
 dcIdRgpt7	,
 sLibRgpt7	,
 dcCpt7		,
 dcIdRgpt8	,
 sLibRgpt8	,
 dcCpt8		,
 dcIdRgpt9	,
 sLibRgpt9	,
 dcCpt9		,
 dcIdRgpt10	,
 sLibRgpt10	,
 dcCpt10		
From   	#Enci,
	sysadm.sinistre,
	sysadm.personne,
 	sysadm.produit,
	sysadm.departement,
	sysadm.code codeNs,
	sysadm.groupe,
	sysadm.police,
	sysadm.compagnie
where   sinistre.id_sin 	= #Enci.id_sin
And	sinistre.id_ordre 	= personne.id_ordre
And	sinistre.id_prod 	= produit.id_prod
And	produit.id_dept		= departement.id_dept
And	codeNs.id_typ_code	= '+NS'
And	codeNs.id_code		= sinistre.id_natsin
And	groupe.id_grp		= sinistre.id_ets
And	produit.cod_adh		= '3'
And	police.id_police	= #Enci.id_police
And	police.id_cie		= compagnie.id_cie


Drop table #Enci

Close 		s_code_gti
Deallocate 	s_code_gti

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_STSIN_ENCIENCR
-- Auteur               :       DBI
-- Date                 :       22/01/1999
-- Libellé              :       Liste des garanties en cours d'instruction et en cours de rŠglement
--				
-- Commentaires         :       si @dcIdEts = -1 on s‚lectionne tous les ets
--				Cette liste sert pour la production des fichiers excel de provision pour Prepar IARD
--				
-- Références           :       Datawindow : D_L_ENCIENCR1
--
-- Arguments            :       @dcPeriodeMax   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
--				@dcIdEts	Decimal(7)		(Val)
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 - FPI - 04/12/2009 - [EXPANSION5.LIB_POLICE] 
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_STSIN_ENCIENCR' and type = 'P' )
        DROP procedure sysadm.DW_S01_STSIN_ENCIENCR
GO

CREATE procedure sysadm.DW_S01_STSIN_ENCIENCR
		@dcPeriodeMax	Decimal(7),
		@dcIdProd	Decimal(7),
		@dcIdEts	Decimal(7)	WITH RECOMPILE

AS

SET NOCOUNT ON

Declare	@dcIdRgpt	Decimal (7)
Declare	@dcIdGti	Decimal (7)
Declare	@dcCpt		Decimal (7)
Declare	@dcIdPolice	Decimal (7)
Declare	@sLibRgpt	VarChar (35)

--********************************************************
--
-- Lecture id_police table produit
--
--********************************************************

Select @dcIdPolice = produit.id_police
From   sysadm.produit
where  id_prod 	   = @dcIdProd

--********************************************************
--
-- Curseur pour lecture des garanties du produit
--
--********************************************************

Declare s_code_gti
Cursor  for
Select  id_gti, id_gti, lib_code
From    sysadm.code_garantie, sysadm.code
where   code_garantie.id_prod	= @dcIdProd
And	code_garantie.id_gti	= code.id_code
And	code.id_typ_code	= '-GS'
Union
Select  code_garantie.id_gti, code.id_code, lib_code
From    sysadm.code_garantie, sysadm.code
where   code_garantie.id_prod	= @dcIdProd
And	code_garantie.id_gti	= 7
And	code.id_code		Between 700 and 799
And	code.id_typ_code	= '-GS'

--********************************************************
--
-- Création d'une table temporaire pour mise à plat de la liste des
-- garanties en cours par dossier
--
--********************************************************

Create table #Enci
 (  	id_sin		Decimal(10),  -- [PI062]
	id_police	Decimal(7),
	dcIdRgpt1	Decimal(7)	Null,
	sLibRgpt1	VarChar(35)	Null,
	dcCpt1		Decimal(7)	Null,
        dcMtProv1       Decimal(11,2)	Null, 
	dcIdRgpt2	Decimal(7)	Null,
	sLibRgpt2	VarChar(35)	Null,
	dcCpt2		Decimal(7)	Null,
        dcMtProv2       Decimal(11,2)	Null, 
	dcIdRgpt3	Decimal(7)	Null,
	sLibRgpt3	VarChar(35)	Null,
	dcCpt3		Decimal(7)	Null,
        dcMtProv3       Decimal(11,2)	Null, 
	dcIdRgpt4	Decimal(7)	Null,
	sLibRgpt4	VarChar(35)	Null,
	dcCpt4		Decimal(7)	Null,
        dcMtProv4       Decimal(11,2)	Null, 
	dcIdRgpt5	Decimal(7)	Null,
	sLibRgpt5	VarChar(35)	Null,
	dcCpt5		Decimal(7)	Null,
        dcMtProv5       Decimal(11,2)	Null, 
	dcIdRgpt6	Decimal(7)	Null,
	sLibRgpt6	VarChar(35)	Null,
	dcCpt6		Decimal(7)	Null,
        dcMtProv6       Decimal(11,2)	Null, 
	dcIdRgpt7	Decimal(7)	Null,
	sLibRgpt7	VarChar(35)	Null,
	dcCpt7		Decimal(7)	Null,
        dcMtProv7       Decimal(11,2)	Null, 
	dcIdRgpt8	Decimal(7)	Null,
	sLibRgpt8	VarChar(35)	Null,
	dcCpt8		Decimal(7)	Null,
        dcMtProv8       Decimal(11,2)	Null, 
	dcIdRgpt9	Decimal(7)	Null,
	sLibRgpt9	VarChar(35)	Null,
	dcCpt9		Decimal(7)	Null,
        dcMtProv9       Decimal(11,2)	Null, 
	dcIdRgpt10	Decimal(7)	Null,
	sLibRgpt10	VarChar(35)	Null,
	dcCpt10		Decimal(7) 	Null,
        dcMtProv10       Decimal(11,2)	Null 
 )

--********************************************************
--
-- Pour chaque garantie du produit, insertion des enregistrements
-- dans #Enci à partir de stat_sin
--
--********************************************************

Open	s_code_gti

Fetch	s_code_gti
Into	@dcIdGti, @dcIdRgpt, @sLibRgpt

Select	@dcCpt	=	0

WHILE ( @@FETCH_STATUS <> -1 )
BEGIN

 Select	@dcCpt	= @dcCpt + 1

 If ( @dcCpt = 1 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 id_rgpt, @sLibRgpt, 1,stat_sin.mt_prov,
	 	null, null, 0, 0, null, null, 0, 0, null, null, 0, 0,
	 	null, null, 0, 0, null, null, 0, 0, null, null, 0, 0,
	 	null, null, 0, 0, null, null, 0, 0, null, null, 0, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	in (  100, 550)		And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt1 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End
 End

 If ( @dcCpt = 2 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 0, 	 
	 id_rgpt, @sLibRgpt, 1, stat_sin.mt_prov,	
	 	null, null, 0, 0, null, null, 0, 0,
	 	null, null, 0, 0, null, null, 0, 0, null, null, 0, 0,
	 	null, null, 0, 0, null, null, 0, 0, null, null, 0, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	in (  100, 550)		And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt2 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 3 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 0,
 	 null, null, 0, 0,	 
	 id_rgpt, @sLibRgpt, 1, stat_sin.mt_prov,	
	 	null, null, 0, 0,
	 	null, null, 0, 0, null, null, 0, 0, null, null, 0, 0,
	 	null, null, 0, 0, null, null, 0, 0, null, null, 0, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	in (  100, 550)		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt3 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End
 End

 If ( @dcCpt = 4 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 id_rgpt, @sLibRgpt, 1, stat_sin.mt_prov,
	 	null, null, 0, 0, null, null, 0, 0, null, null, 0, 0,
	 	null, null, 0, 0, null, null, 0, 0, null, null, 0, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	in (  100, 550)		And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt4 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End
 End

 If ( @dcCpt = 5 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 id_rgpt, @sLibRgpt, 1, stat_sin.mt_prov,	
	 	null, null, 0, 0, null, null, 0, 0,
	 	null, null, 0, 0, null, null, 0, 0, null, null, 0, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	in (  100, 550)		And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt5 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 6 )
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 id_rgpt, @sLibRgpt, 1, stat_sin.mt_prov,	
		null, null, 0, 0,	 
	 	null, null, 0, 0, null, null, 0, 0, null, null, 0, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	in (  100, 550)		And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt6 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 7)
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 id_rgpt, @sLibRgpt, 1, stat_sin.mt_prov,	
	 	null, null, 0, 0, null, null, 0, 0, null, null, 0, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	in (  100, 550)		And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt7 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 8)
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 id_rgpt, @sLibRgpt, 1, stat_sin.mt_prov,	
	 	null, null, 0, 0, null, null, 0, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	in (  100, 550)		And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt8 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 9)
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 0,
	 null, null, 0, 0,	 
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,	 
	 id_rgpt, @sLibRgpt, 1, stat_sin.mt_prov,
	 	null, null, 0, 0
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	in (  100, 550)		And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt9 = @sLibRgpt
		Where	id_sin	  = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 If ( @dcCpt = 10)
 Begin

	Insert into #Enci
	Select
	 stat_sin.id_sin,
	 IsNull ( @dcIdPolice, IsNull ( ( Select id_police
		  From   sysadm.garantie
		  Where  garantie.id_prod = sinistre.id_prod
		  And    garantie.id_rev  = sinistre.id_rev
		  And    garantie.id_gti  = stat_sin.id_gti ), 0 ) ),
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 null, null, 0, 0,
	 id_rgpt, @sLibRgpt, 1, stat_sin.mt_prov
	From
	 sysadm.stat_sin, sysadm.sinistre
	Where
	 stat_sin.id_sin	= sinistre.id_sin	And
	 sinistre.id_prod	= @dcIdProd		And
	 stat_sin.id_periode	= @dcPeriodeMax		And
	 stat_sin.cod_etat	in (  100, 550)		And
	 sinistre.id_ets	= ( Case 
				    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
				    Else   @dcIdEts
				    End )		And
	 stat_sin.id_rgpt	= @dcIdRgpt

	If ( @@ROWCOUNT <= 0 )
	Begin

		Update 	#Enci
		Set 	sLibRgpt10 = @sLibRgpt
		Where	id_sin	   = ( 	Select Min ( id_sin ) 
					From   #Enci )
	End

 End

 Fetch	s_code_gti
 Into	@dcIdGti, @dcIdRgpt, @sLibRgpt

END

Insert into #Enci
Select
 sinistre.id_sin,
 IsNull ( @dcIdPolice, 0 ),
 null, null, 0, 0, 	 
 null, null, 0, 0,	 
 null, null, 0, 0,	 
 null, null, 0, 0,	 
 null, null, 0, 0,	 
 null, null, 0, 0,	 
 null, null, 0, 0,	 
 null, null, 0, 0,	 
 null, null, 0, 0,
 null, null, 0, 0
From
 sysadm.sinistre
Where
 sinistre.id_prod	= @dcIdProd		And
 sinistre.cod_etat	= 100			And
 sinistre.id_ets	= ( Case 
			    When ( @dcIdEts = -1 ) Then sinistre.id_ets 
			    Else   @dcIdEts
			    End )		And
 not exists ( 	select id_sin 
		from   sysadm.stat_sin 
		where  stat_sin.id_sin = sinistre.id_sin And
		       stat_sin.id_periode	= @dcPeriodeMax	)	


--********************************************************
--
-- Select pour la datawindow
--
--********************************************************

Select 
 @dcPeriodeMax,
 sinistre.id_sin,
 sinistre.valide_le,
 produit.lib_long,
 departement.lib_dept,
 sinistre.dte_surv,
 DatePart ( Year, sinistre.dte_surv ),
 sinistre.dte_decl,
 groupe.id_grp,
 codeNs.lib_code,
 groupe.lib_grp,
 personne.nom,
 personne.prenom,
 police.lib_police,
 compagnie.lib_cie,
 dcIdRgpt1,
 sLibRgpt1	,
 dcCpt1		,
 dcMtProv1	,
 dcIdRgpt2	,
 sLibRgpt2	,
 dcCpt2		,
 dcMtProv2	,
 dcIdRgpt3	,
 sLibRgpt3	,
 dcCpt3		,
 dcMtProv3	,
 dcIdRgpt4	,
 sLibRgpt4	,
 dcCpt4		,
 dcMtProv4	,
 dcIdRgpt5	,
 sLibRgpt5 	,
 dcCpt5		,
 dcMtProv5	,
 dcIdRgpt6	,
 sLibRgpt6	,
 dcCpt6		,
 dcMtProv6	,
 dcIdRgpt7	,
 sLibRgpt7	,
 dcCpt7		,
 dcMtProv7	,
 dcIdRgpt8	,
 sLibRgpt8	,
 dcCpt8		,
 dcMtProv8	,
 dcIdRgpt9	,
 sLibRgpt9	,
 dcCpt9		,
 dcMtProv9	,
 dcIdRgpt10	,
 sLibRgpt10	,
 dcCpt10	,
 dcMtProv10
From   	#Enci,
	sysadm.sinistre,
	sysadm.personne,
 	sysadm.produit,
	sysadm.departement,
	sysadm.code codeNs,
	sysadm.groupe,
	sysadm.etablissement,
	sysadm.police,
	sysadm.compagnie
where   sinistre.id_sin 	= #Enci.id_sin
And	sinistre.id_ordre 	= personne.id_ordre
And	sinistre.id_prod 	= produit.id_prod
And	produit.id_dept		= departement.id_dept
And	codeNs.id_typ_code	= '+NS'
And	codeNs.id_code		= sinistre.id_natsin
And	groupe.id_grp		= etablissement.id_grp
And	etablissement.id_prod	= sinistre.id_prod
And	etablissement.id_ets	= sinistre.id_ets
And	etablissement.id_rev	= -1
And	produit.cod_adh		<> '3'
And	police.id_police	= #Enci.id_police
And	police.id_cie		= compagnie.id_cie
UNION ALL
Select 
 @dcPeriodeMax,
 sinistre.id_sin,
 sinistre.valide_le,
 produit.lib_long,
 departement.lib_dept,
 sinistre.dte_surv,
 DatePart ( Year, sinistre.dte_surv ),
 sinistre.dte_decl,
 groupe.id_grp,
 codeNs.lib_code,
 groupe.lib_grp,
 personne.nom,
 personne.prenom,
 police.lib_police,
 compagnie.lib_cie,
 dcIdRgpt1,
 sLibRgpt1	,
 dcCpt1		,
 dcMtProv1	,
 dcIdRgpt2	,
 sLibRgpt2	,
 dcCpt2		,
 dcMtProv2	,
 dcIdRgpt3	,
 sLibRgpt3	,
 dcCpt3		,
 dcMtProv3	,
 dcIdRgpt4	,
 sLibRgpt4	,
 dcCpt4		,
 dcMtProv4	,
 dcIdRgpt5	,
 sLibRgpt5 	,
 dcCpt5		,
 dcMtProv5	,
 dcIdRgpt6	,
 sLibRgpt6	,
 dcCpt6		,
 dcMtProv6	,
 dcIdRgpt7	,
 sLibRgpt7	,
 dcCpt7		,
 dcMtProv7	,
 dcIdRgpt8	,
 sLibRgpt8	,
 dcCpt8		,
 dcMtProv8	,
 dcIdRgpt9	,
 sLibRgpt9	,
 dcCpt9		,
 dcMtProv9	,
 dcIdRgpt10	,
 sLibRgpt10	,
 dcCpt10	,
 dcMtProv10	
From   	#Enci,
	sysadm.sinistre,
	sysadm.personne,
 	sysadm.produit,
	sysadm.departement,
	sysadm.code codeNs,
	sysadm.groupe,
	sysadm.police,
	sysadm.compagnie
where   sinistre.id_sin 	= #Enci.id_sin
And	sinistre.id_ordre 	= personne.id_ordre
And	sinistre.id_prod 	= produit.id_prod
And	produit.id_dept		= departement.id_dept
And	codeNs.id_typ_code	= '+NS'
And	codeNs.id_code		= sinistre.id_natsin
And	groupe.id_grp		= sinistre.id_ets
And	produit.cod_adh		= '3'
And	police.id_police	= #Enci.id_police
And	police.id_cie		= compagnie.id_cie



Drop table #Enci

Close 		s_code_gti
Deallocate 	s_code_gti

GO

/*

sysadm.DW_S01_STSIN_ENCI 199811, 1600

*/


--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_STSIN_REGREFSSU
-- Auteur               :       JFF
-- Date                 :       19/02/1999
-- Libellé              :       Statistique R‚capitulative, voir commentaire
--				
-- Commentaires         : 	PREMIER CAS TRAITE :
-- 				Compter par excercice de survenance, le nombre de sinistre
-- 				Refusés ou mis Sans suite, sur la période.
--
--				DEUXIEME CAS TRAITE :
-- 				Compter par excercice de survenance, le nombre de sinistre
-- 				pour lesquels le premier rŠglement a eu lieu dans la p‚riode
--
--				
-- Références           :       Datawindow : 
--
-- Arguments            :       @dcPeriodeMin   Decimal(7)              (Val)
--				@dcPeriodeMax   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)              (Val)
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 - FPI - 04/12/2009 - [EXPANSION5.LIB_POLICE] 
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_STSIN_REGREFSSU' and type = 'P' )
        DROP procedure sysadm.DW_S02_STSIN_REGREFSSU
GO

CREATE procedure sysadm.DW_S02_STSIN_REGREFSSU
		@dcPeriodeMin	Decimal(7),
		@dcPeriodeMax	Decimal(7),
		@dcIdProd	Decimal(7)

AS

Declare @dcIdSin		Decimal ( 10,0 ),  -- [PI062]
	@dcIdExercice		Decimal ( 7,0 ),
	@dcIdEts		Decimal ( 7,0 ),
	@dcIdPolice		Decimal ( 7,0 ),
	@dcCodEtat		Decimal ( 7,0 )

SET NOCOUNT ON

--************************************************************
-- Table temporaire #Ttp1 
--************************************************************
Create table sysadm.#Ttp1
 (  	
	id_sin      	Decimal(10), -- [PI062]
   cod_etat	Decimal(7) NULL,
	id_exercice	Decimal(7) NULL,
	id_ets		Decimal(7) NULL,
	id_police	Decimal(7) NULL,
 )

--************************************************************
-- Table temporaire #Ttp2 
--************************************************************
Create table sysadm.#Ttp2
 (  	
   id_sin      	Decimal(10) NULL,  -- [PI062]
   cod_etat	Decimal(7) NULL,
	sinreg      	Decimal(7) NULL,
	sinref     	Decimal(7) NULL,
	sinssu     	Decimal(7) NULL,
	id_exercice	Decimal(7) NULL,
	id_ets		Decimal(7) NULL,
	id_police	Decimal(7) NULL
 )

--************************************************************
-- 1ER CAS A TRAITER :
-- Compter par excercice de survenance, le nombre de sinistre
-- RefusÚs ou mis Sans suite, sur la pÚriode.
--***********************************************************

--************************************************************
-- On remplis la table sysadm.#Ttp1 par les sinistres REFUSES
-- sur la pÚriode
--************************************************************
Insert Into sysadm.#Ttp1
Select 

 distinct st.id_sin,
 st.cod_etat,
 datepart (year, sin.dte_surv ),
 sin.id_ets,
 gar.id_police

From sysadm.stat_sin st, sysadm.sinistre sin, sysadm.garantie gar

Where 	st.cod_etat = 200
and	st.id_periode between @dcPeriodeMin and @dcPeriodeMax
and	st.id_sin   = sin.id_sin
and 	sin.id_prod = @dcIdProd
and	gar.id_prod = sin.id_prod
and     gar.id_rev  = sin.id_rev

--************************************************************
-- On remplis la table sysadm.#Ttp2 par les sinistres mis
-- SANS SUITE sur la pÚriode. On peut y retrouver des sinistres
-- se trouvant sur #Ttp1 en tant que refusÚs
--************************************************************

Insert Into sysadm.#Ttp2
Select 
 
 distinct st.id_sin,
 st.cod_etat,
 null,
 null,
 null,
 datepart (year, sin.dte_surv ),
 sin.id_ets,
 gar.id_police

From sysadm.stat_sin st, sysadm.sinistre sin, sysadm.garantie gar

Where 	st.cod_etat >= 900
and	st.id_periode between @dcPeriodeMin and @dcPeriodeMax
and	st.id_sin   = sin.id_sin
and 	sin.id_prod = @dcIdProd
and	gar.id_prod = sin.id_prod
and     gar.id_rev  = sin.id_rev


--************************************************************
-- On efface maintenant de #Ttp2, tous les sinistres se trouvant
-- sur #Ttp1 pour qu'un dossier ayant une garantie refusÚe et une
-- garantie mise sans suite, soit comptÚ comme un dossier refusÚ.
-- Il ne reste donc dans #Ttp2, uniquement que les dossier qui ont
-- au moins eu une garantie sans suite et aucune garantie refusÚes
-- sur la pÚriode.
--************************************************************
Declare Curs_Ttp1
Cursor  for
	Select  id_sin
	From 	sysadm.#Ttp1

Open	Curs_Ttp1
Fetch	Curs_Ttp1 Into @dcIdSin

WHILE ( @@FETCH_STATUS <> -1 )
BEGIN

 If ( Select  count (#Ttp2.id_sin)
      From    sysadm.#Ttp2
      where   #Ttp2.id_sin = @dcIdSin
    ) > 0
    Begin	
	Delete From sysadm.#Ttp2 where #Ttp2.id_sin = @dcIdSin
    End	

 Fetch	Curs_Ttp1 Into @dcIdSin

END

Close 		Curs_Ttp1
Deallocate 	Curs_Ttp1

--************************************************************
-- on rebascule dans #Ttp1 dans les enregistrements restant dans
-- #Ttp2, afin que Ttp1 contienne tous les refusÚs et les sans suite
--************************************************************
Insert Into sysadm.#Ttp1
Select 
 id_sin,   
 cod_etat,
 id_exercice,
 id_ets,	
 id_police
From sysadm.#Ttp2

--************************************************************
-- on efface vide entiÞrement #Ttp2, afin de s'en servir 
-- maintenant comme table dÚfinitive.
--************************************************************
Truncate Table sysadm.#Ttp2

--************************************************************
-- Curseur parcourant #Ttp1, afin de dispatcher les refusÚs et
-- les sans suite dans #Ttp2 selon le critÞre suivant :
-- Le sinistre ne doit pas avoir eu une garantie en cours de rÞglement
-- ou rÚglÚe sur la pÚriode ou une pÚriode antÚrieure
--   ET   
-- ne doit pas avoir eu une garantie en cours d'instruction sur
-- la pÚriode
--************************************************************
Declare Curs_Ttp1
Cursor  for
	Select  id_sin, cod_etat, id_exercice, id_ets, id_police
	From 	sysadm.#Ttp1

Open	Curs_Ttp1
Fetch	Curs_Ttp1 Into @dcIdSin, @dcCodEtat, @dcIdExercice, @dcIdEts, @dcIdPolice


WHILE ( @@FETCH_STATUS <> -1 )
BEGIN

 If ( Select  count ( sts.id_sin )
      From    sysadm.stat_sin sts
      where   sts.id_sin = @dcIdSin
      and     (  
		  ( sts.cod_etat in (600, 550) and sts.id_periode <= @dcPeriodeMax 			   )
		or( sts.cod_etat = 100 	       and sts.id_periode between @dcPeriodeMin and @dcPeriodeMax  )
	      )
    ) = 0
    Begin	

	If @dcCodEtat = 200 
	   Begin
		Insert Into sysadm.#Ttp2
 		Values ( 0, 0, 0, 1, 0, @dcIdExercice, @dcIdEts, @dcIdPolice )	
 	   End
	Else
	   Begin
		Insert Into sysadm.#Ttp2
 		Values ( 0, 0, 0, 0, 1, @dcIdExercice, @dcIdEts, @dcIdPolice )	
 	   End
	
    End	


 Fetch Curs_Ttp1 Into @dcIdSin, @dcCodEtat, @dcIdExercice, @dcIdEts, @dcIdPolice

END

Close 		Curs_Ttp1
Deallocate 	Curs_Ttp1
--************************************************************
-- On vide de la table temporaire #Ttp1 qui servira de nouveau
-- pour le deuxiÞme cas Ó traiter
--************************************************************
Truncate Table sysadm.#Ttp1

--************************************************************
-- 2EME CAS A TRAITER :
-- Compter par excercice de survenance, le nombre de sinistre
-- pour lesquels le premier règlement a eu lieu dans la période
--***********************************************************

--************************************************************
-- On remplis la table temporaire sysadm.#Ttp1
--************************************************************
Insert Into sysadm.#Ttp1
Select 

 distinct st.id_sin,
 null,	
 datepart (year, sin.dte_surv ),
 sin.id_ets,
 gar.id_police

From sysadm.stat_sin st, sysadm.sinistre sin, sysadm.garantie gar

Where 	st.cod_etat in ( 550, 600 )
and	st.cpt_reg  = 1
and	st.id_periode between @dcPeriodeMin and @dcPeriodeMax
and	st.id_sin   = sin.id_sin
and 	sin.id_prod = @dcIdProd
and	gar.id_prod = sin.id_prod
and     gar.id_rev  = sin.id_rev



--************************************************************
-- Déclaration du curseur qui va parcourir la table temporaire
--************************************************************
Declare Curs_Ttp1
Cursor  for
	Select  id_sin, id_exercice, id_ets, id_police
	From 	sysadm.#Ttp1

Open	Curs_Ttp1
Fetch	Curs_Ttp1 Into @dcIdSin, @dcIdExercice, @dcIdEts, @dcIdPolice


WHILE ( @@FETCH_STATUS <> -1 )
BEGIN

--************************************************************
-- Si pour un sinistre de la table #Ttp1, il n'existe aucun 
-- autre règlement sur une période antérieure à celle sélectionnée,
-- c'est que le règlement se trouvant sur la table #Ttp1 est le
-- premier, donc on Insert l'enregistrements concerné sur #Ttp2
-- (il n'y en a qu'un seul à chaque Insert, grace au Distinct posé sur l'Insert
-- de la table #Ttp1)
--************************************************************
 If ( Select  count ( sts.id_sin )
      From    sysadm.stat_sin sts
      where   sts.id_sin = @dcIdSin
      and     sts.cod_etat in (550, 600)
      and     sts.cpt_reg = 1
      and     sts.id_periode < @dcPeriodeMin
    ) = 0
    Begin	
	Insert sysadm.#Ttp2
 	Values ( 0, 0, 1, 0, 0, @dcIdExercice, @dcIdEts, @dcIdPolice )	
    End	

 Fetch	Curs_Ttp1 Into @dcIdSin, @dcIdExercice, @dcIdEts, @dcIdPolice

END

Close 		Curs_Ttp1
Deallocate 	Curs_Ttp1


--************************************************************
-- Affichage des données finale pour la DataWindow
--************************************************************

Select  SINREG	      = sum( #Ttp2.sinreg ),
	SINREF        = sum( #Ttp2.sinref ),
	SINSSU        = sum( #Ttp2.sinssu ),
	EXERCICE      = #Ttp2.id_exercice,
	LIBPRODUIT    = produit.lib_long,
	LIB_DEPT      = departement.lib_dept,
	LIB_GRP       = groupe.lib_grp,
	LIB_CIE	      =	compagnie.lib_cie,
	POLICE	      = police.lib_police

From    sysadm.#Ttp2,
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement

Where 	( produit.id_prod	= @dcIdProd			)  and
	( produit.cod_adh	= '3'				)  and
	( police.id_police	= #Ttp2.id_police		)  and
	( police.id_cie		= compagnie.id_cie		)  and
	( departement.id_dept	= produit.id_dept		)  and
	( groupe.id_grp		= #Ttp2.id_ets			)

Group by  #Ttp2.id_exercice, produit.lib_long, departement.lib_dept, groupe.lib_grp, compagnie.lib_cie, police.lib_police
	

UNION ALL


Select  SINREG	      = sum( #Ttp2.sinreg ),
	SINREF        = sum( #Ttp2.sinref ),
	SINSSU        = sum( #Ttp2.sinssu ),
	EXERCICE      = #Ttp2.id_exercice,
	LIBPRODUIT    = produit.lib_long,
	LIB_DEPT      = departement.lib_dept,
	LIB_GRP       = groupe.lib_grp,
	LIB_CIE	      =	compagnie.lib_cie,
	POLICE	      = police.lib_police

From    sysadm.#Ttp2,
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.etablissement


Where 	( produit.id_prod	= @dcIdProd			)  and
	( produit.cod_adh	<> '3'				)  and
	( police.id_police	= #Ttp2.id_police		)  and
	( police.id_cie		= compagnie.id_cie		)  and
	( departement.id_dept	= produit.id_dept		)  and
	( etablissement.id_prod = @dcIdProd			)  and
	( etablissement.id_ets  = #Ttp2.id_ets			)  and
	( etablissement.id_grp  = groupe.id_grp			)  and
	( etablissement.id_rev  = -1				)

Group by  #Ttp2.id_exercice, produit.lib_long, departement.lib_dept, groupe.lib_grp, compagnie.lib_cie, police.lib_police



DROP table sysadm.#Ttp1
DROP table sysadm.#Ttp2


SET NOCOUNT OFF


GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S03_STSIN_MOTIF_REFUS
-- Auteur               :       JFF
-- Date                 :       06/05/1999
-- Libellé              :       Compte les motif de refus 
--				
-- Commentaires         : 	
--				
-- Références           :       Datawindow : 
--
-- Arguments            :       @dcPerDecDeb   	Decimal(7)              (Val) D‚but de la P‚riode de d‚claration
--				@dcPerDecFin   	Decimal(7)              (Val) Fin de la p‚riode de d‚claration
--                              @dcPerDebArret 	Decimal(7)              (Val) D‚but de la P‚riode des refus
--				@dcPerFinArret  Decimal(7)              (Val) Fin de la P‚riode des refus. 
--				@dcIdProd	Decimal(7)             	(Val) Produit
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 - FPI - 04/12/2009 - [EXPANSION5.LIB_POLICE] 
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_STSIN_MOTIF_REFUS' and type = 'P' )
        DROP procedure sysadm.DW_S03_STSIN_MOTIF_REFUS
GO

CREATE procedure sysadm.DW_S03_STSIN_MOTIF_REFUS 
		@dcPerDecDeb   	Decimal ( 7,0 ),
		@dcPerDecFin   	Decimal ( 7,0 ),
                @dcPerDebArret  Decimal ( 7,0 ),
		@dcPerFinArret  Decimal ( 7,0 ),
		@dcIdProd	Decimal ( 7,0 )

AS

Declare		@sCodAdh     VarChar ( 1 )

Select @sCodAdh	= produit.cod_adh
From   sysadm.produit
Where  produit.id_prod = @dcIdProd


Create Table sysadm.#StatSinTmp
 (  	id_sin		Decimal ( 10,0 ),  -- [PI062]
	id_gti		Decimal ( 7,0 ),
	id_rgpt		Decimal ( 7,0 )
 )


Create Table sysadm.#ComptageTmp
 (
	id_sin		Decimal ( 10,0 ),  -- [PI062]
	exercice	Decimal ( 7,0 ) Null ,
	type_refus	VarChar ( 35  ),
	id_gti		Decimal ( 7,0 ),
	id_rgpt		Decimal ( 7,0 ),
	lib_garantie	VarChar ( 35  ),
	lib_evt		VarChar ( 35  ),
	id_motif	Decimal ( 7,0 ),
	lib_refus	VarChar ( 35  ),
	courrier	Varchar ( 50  ),
	nat_sin		VarChar ( 35  )
 )


Insert 	Into sysadm.#StatSinTmp
Select  distinct
	stRef.id_sin,
	stRef.id_gti,
	stRef.id_rgpt

From   	sysadm.stat_sin stDec,
	sysadm.stat_sin stRef,
	sysadm.sinistre sin

Where	stRef.id_sin 	= sin.id_sin
and	sin.id_prod  	= @dcIdProd
and	stRef.cod_etat	= 200
and	stRef.cpt_etat	= 1
and	stRef.id_periode between @dcPerDebArret And @dcPerFinArret
and	stRef.id_sin	= stDec.id_sin
and	stRef.id_gti	= stDec.id_gti
and	stRef.id_rgpt	= stDec.id_rgpt
and	stDec.cpt_ouv	= 1
and    	stDec.id_periode between @dcPerDecDeb And @dcPerDecFin


Insert Into sysadm.#ComptageTmp
Select 	
	Id_Sin		= sinistre.id_sin,
       	Exercice	= DatePart ( year, sinistre.dte_surv ),
       	Type_Refus	= 'Refus de la garantie',
	Id_Gti		= Stat.id_gti,
       	Id_Rgpt		= Stat.id_rgpt, 
       	Lib_Garantie	= code_gti.lib_code, 
	Lib_Evt		= 'Aucun evenement, refus de garantie',
       	Id_Motif	= refus.id_motif, 
       	Lib_Refus	= code.lib_code,
	Courrier	= Case 
			  When refus.id_i is not null Then '(est apparu sur le courrier client)'
			  When refus.id_i is null Then '(n est pas apparu sur le courrier client)'
	 		  End,
	Nat_Sin		= code_ns.lib_code

from   	sysadm.#StatSinTmp Stat,
	sysadm.sinistre, 
	sysadm.refus, 
	sysadm.code, 
	sysadm.code code_gti,
	sysadm.code code_ns

where  	sinistre.id_sin		= Stat.id_sin
and	refus.id_sin     	= Stat.id_sin
and    	refus.id_gti     	= Stat.id_gti
and    	refus.id_detail  	= -1
and    	refus.id_motif   	= code.id_code
and    	code.id_typ_code 	= '+RE'
and    	Stat.id_rgpt  		= code_gti.id_code
and    	code_gti.id_typ_code 	= '-GS'
and    	code_ns.id_typ_code 	= '+NS'
and	code_ns.id_code 	= sinistre.id_natsin

UNION ALL

Select 
	Id_Sin		= sinistre.id_sin,
       	Exercice	= DatePart ( year, sinistre.dte_surv ), 
       	Type_Refus	= 'Refus des details', 
	Id_Gti		= Stat.id_gti,
       	Id_Rgpt		= Stat.id_rgpt, 
       	Lib_Garantie	= code_gti.lib_code, 
	Lib_Evt		= code_evt.lib_code, 
       	Id_Motif	= refus.id_motif, 
       	Lib_Refus	= code.lib_code,
	Courrier	= Case 
			  When refus.id_i is not null Then '(est apparu sur le courrier client)'
			  When refus.id_i is null Then '(n est pas apparu sur le courrier client)'
	 		  End,
	Nat_Sin		= code_ns.lib_code

from   	sysadm.#StatSinTmp Stat,
	sysadm.sinistre, 
	sysadm.refus, 
	sysadm.detail, 
	sysadm.code, 
	sysadm.code code_gti,
	sysadm.code code_ns,
	sysadm.code code_evt

where  	sinistre.id_sin		= Stat.id_sin
and	Stat.id_rgpt  		= code_gti.id_code
and    	code_gti.id_typ_code 	= '-GS'
and    	not exists ( select refus.id_sin
		   from   sysadm.refus
		   where  refus.id_sin     = Stat.id_sin
		   and    refus.id_gti     = Stat.id_gti
		   and    refus.id_detail  = -1 )
and    	refus.id_sin     	= Stat.id_sin
and    	refus.id_gti     	= Stat.id_gti
and    	refus.id_detail     	= detail.id_detail
and	detail.id_sin 		= refus.id_sin
and	detail.id_gti 		= refus.id_gti
and    	Stat.id_gti  		<> 7
and    	refus.id_motif   	= code.id_code
and    	code.id_typ_code 	= '+RE'
and    	code_ns.id_typ_code 	= '+NS'
and	code_ns.id_code 	= sinistre.id_natsin
and    	code_evt.id_typ_code 	= '+EV'
and	code_evt.id_code 	= detail.id_evt

UNION ALL

Select 	
	Id_Sin		= sinistre.id_sin,
       	Exercice	= DatePart ( year, sinistre.dte_surv ), 
       	Type_Refus	= 'Refus des details', 
	Id_Gti		= Stat.id_gti,
       	Id_Rgpt		= Stat.id_rgpt, 
       	Lib_Garantie	= code_gti.lib_code, 
	Lib_Evt		= code_evt.lib_code, 
       	Id_Motif	= refus.id_motif, 
       	Lib_Refus	= code.lib_code,
	Courrier	= Case 
			  When refus.id_i is not null Then '(est apparu sur le courrier client)'
			  When refus.id_i is null Then '(n est pas apparu sur le courrier client)'
	 		  End,
	Nat_Sin		= code_ns.lib_code

from   	sysadm.#StatSinTmp Stat,
	sysadm.sinistre, 
	sysadm.refus, 
	sysadm.code, 
	sysadm.code code_gti,
	sysadm.detail,
	sysadm.code code_ns,
	sysadm.code code_evt

where  	sinistre.id_sin		= Stat.id_sin
and	Stat.id_rgpt  		= code_gti.id_code
and    	code_gti.id_typ_code 	= '-GS'
and    	not exists ( select refus.id_sin
		   from   sysadm.refus
		   where  refus.id_sin     = Stat.id_sin
		   and    refus.id_gti     = Stat.id_gti
		   and    refus.id_detail  = -1 )
and    	refus.id_sin    	= Stat.id_sin
and    	refus.id_gti     	= Stat.id_gti
and    	Stat.id_gti  		= 7
and    	refus.id_detail  	= detail.id_detail
and    	refus.id_sin     	= detail.id_sin
and    	refus.id_gti     	= detail.id_gti
and    	detail.id_evt 		between Stat.id_rgpt and ( Stat.id_rgpt + 19 )
and    	refus.id_motif   	= code.id_code
and    	code.id_typ_code 	= '+RE'
and    	code_ns.id_typ_code 	= '+NS'
and	code_ns.id_code 	= sinistre.id_natsin
and    	code_evt.id_typ_code 	= '+EV'
and	code_evt.id_code 	= detail.id_evt


Drop Table sysadm.#StatSinTmp


If @sCodAdh = '3'

BEGIN

Select	
       	Exercice	= CptTmp.exercice,
       	Type_Refus	= CptTmp.type_refus,
	Id_Gti		= CptTmp.id_gti,
       	Id_Rgpt		= CptTmp.id_rgpt, 
       	Lib_Garantie	= CptTmp.lib_garantie, 
       	Lib_Evt		= CptTmp.lib_evt, 
       	Id_Motif	= CptTmp.id_motif,
       	Lib_Refus	= CptTmp.lib_refus,
	Courrier	= CptTmp.courrier,
	Nat_Sin		= CptTmp.nat_sin,
	Nombre		= count ( CptTmp.id_motif ),
	Lib_Produit	= produit.lib_long,
	Lib_Dept      	= departement.lib_dept,
	Lib_Grp       	= groupe.lib_grp,
	Lib_Cie	      	= compagnie.lib_cie,
	Police	     	= police.lib_police

From	sysadm.#ComptageTmp CptTmp,
	sysadm.sinistre,
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.garantie

Where  	sinistre.id_sin		= CptTmp.id_sin
and	produit.id_prod		= sinistre.id_prod
and	garantie.id_prod	= sinistre.id_prod
and 	sinistre.id_rev		> -1
and	garantie.id_rev		= sinistre.id_rev
and	garantie.id_gti		= CptTmp.id_gti
and	police.id_police	= garantie.id_police
and	compagnie.id_cie	= police.id_cie
and	departement.id_dept	= produit.id_dept
and	groupe.id_grp		= sinistre.id_ets

Group By
       	CptTmp.exercice,
       	CptTmp.type_refus,
	CptTmp.id_gti,
       	CptTmp.id_rgpt, 
       	CptTmp.lib_garantie, 
	CptTmp.lib_evt, 
       	CptTmp.id_motif,
       	CptTmp.lib_refus,
	CptTmp.courrier,
	CptTmp.nat_sin,
	produit.lib_long,
	departement.lib_dept,
	groupe.lib_grp,
	compagnie.lib_cie,
	police.lib_police

UNION ALL
-- Cas des r'visions . -1

Select	
       	Exercice	= CptTmp.exercice,
       	Type_Refus	= CptTmp.type_refus,
	Id_Gti		= CptTmp.id_gti,
       	Id_Rgpt		= CptTmp.id_rgpt, 
       	Lib_Garantie	= CptTmp.lib_garantie, 
       	Lib_Evt		= CptTmp.lib_evt, 
       	Id_Motif	= CptTmp.id_motif,
       	Lib_Refus	= CptTmp.lib_refus,
	Courrier	= CptTmp.courrier,
	Nat_Sin		= CptTmp.nat_sin,
	Nombre		= count ( CptTmp.id_motif ),
	Lib_Produit	= produit.lib_long,
	Lib_Dept      	= departement.lib_dept,
	Lib_Grp       	= groupe.lib_grp,
	Lib_Cie	      	= 'Inconnue',
	Police	     	= 'Inconnue'

From	sysadm.#ComptageTmp CptTmp,
	sysadm.sinistre,
	sysadm.produit,
	sysadm.groupe,
	sysadm.departement

Where  	sinistre.id_sin		= CptTmp.id_sin
and	produit.id_prod		= sinistre.id_prod
and 	sinistre.id_rev	       <= -1
and	departement.id_dept	= produit.id_dept
and	groupe.id_grp		= sinistre.id_ets

Group By
       	CptTmp.exercice,
       	CptTmp.type_refus,
	CptTmp.id_gti,
       	CptTmp.id_rgpt, 
       	CptTmp.lib_garantie, 
	CptTmp.lib_evt, 
       	CptTmp.id_motif,
       	CptTmp.lib_refus,
	CptTmp.courrier,
	CptTmp.nat_sin,
	produit.lib_long,
	departement.lib_dept,
	groupe.lib_grp

END

ELSE


BEGIN


Select	
       	Exercice	= CptTmp.exercice,
       	Type_Refus	= CptTmp.type_refus,
	Id_Gti		= CptTmp.id_gti,
       	Id_Rgpt		= CptTmp.id_rgpt, 
       	Lib_Garantie	= CptTmp.lib_garantie, 
       	Lib_Evt		= CptTmp.lib_evt, 
       	Id_Motif	= CptTmp.id_motif,
       	Lib_Refus	= CptTmp.lib_refus,
	Courrier	= CptTmp.courrier,
	Nat_Sin		= CptTmp.nat_sin,
	Nombre		= count ( CptTmp.id_motif ),
	Lib_Produit	= produit.lib_long,
	Lib_Dept      	= departement.lib_dept,
	Lib_Grp       	= groupe.lib_grp,
	Lib_Cie	      	= compagnie.lib_cie,
	Police	     	= police.lib_police

From	sysadm.#ComptageTmp CptTmp,
	sysadm.sinistre,
	sysadm.produit,
	sysadm.compagnie,
	sysadm.groupe,
	sysadm.police,
	sysadm.departement,
	sysadm.garantie,
	sysadm.etablissement

Where  	sinistre.id_sin		= CptTmp.id_sin
and    	produit.id_prod		= sinistre.id_prod
and	garantie.id_prod	= sinistre.id_prod
and 	sinistre.id_rev		> -1
and	garantie.id_rev		= sinistre.id_rev
and	garantie.id_gti		= CptTmp.id_gti
and	police.id_police	= garantie.id_police
and	compagnie.id_cie	= police.id_cie
and	departement.id_dept	= produit.id_dept
and	etablissement.id_prod   = sinistre.id_prod
and	etablissement.id_ets  	= sinistre.id_ets
and	etablissement.id_grp  	= groupe.id_grp
and	etablissement.id_rev    = -1

Group By
       	CptTmp.exercice,
       	CptTmp.type_refus,
	CptTmp.id_gti,
       	CptTmp.id_rgpt, 
       	CptTmp.lib_garantie, 
	CptTmp.lib_evt, 
       	CptTmp.id_motif,
       	CptTmp.lib_refus,
	CptTmp.courrier,
	CptTmp.nat_sin,
	produit.lib_long,
	departement.lib_dept,
	groupe.lib_grp,
	compagnie.lib_cie,
	police.lib_police

UNION ALL
-- Cas des r'visions . -1
Select	
       	Exercice	= CptTmp.exercice,
       	Type_Refus	= CptTmp.type_refus,
	Id_Gti		= CptTmp.id_gti,
       	Id_Rgpt		= CptTmp.id_rgpt, 
       	Lib_Garantie	= CptTmp.lib_garantie, 
       	Lib_Evt		= CptTmp.lib_evt, 
       	Id_Motif	= CptTmp.id_motif,
       	Lib_Refus	= CptTmp.lib_refus,
	Courrier	= CptTmp.courrier,
	Nat_Sin		= CptTmp.nat_sin,
	Nombre		= count ( CptTmp.id_motif ),
	Lib_Produit	= produit.lib_long,
	Lib_Dept      	= departement.lib_dept,
	Lib_Grp       	= groupe.lib_grp,
	Lib_Cie	      	= 'Inconnue',
	Police	     	= 'Inconnue'

From	sysadm.#ComptageTmp CptTmp,
	sysadm.sinistre,
	sysadm.produit,
	sysadm.groupe,
	sysadm.departement,
	sysadm.etablissement

Where  	sinistre.id_sin		= CptTmp.id_sin
and    	produit.id_prod		= sinistre.id_prod
and 	sinistre.id_rev	       <= -1
and	departement.id_dept	= produit.id_dept
and	etablissement.id_prod   = sinistre.id_prod
and	etablissement.id_ets  	= sinistre.id_ets
and	etablissement.id_grp  	= groupe.id_grp
and	etablissement.id_rev    = -1

Group By
       	CptTmp.exercice,
       	CptTmp.type_refus,
	CptTmp.id_gti,
       	CptTmp.id_rgpt, 
       	CptTmp.lib_garantie, 
	CptTmp.lib_evt, 
       	CptTmp.id_motif,
       	CptTmp.lib_refus,
	CptTmp.courrier,	
	CptTmp.nat_sin,
	produit.lib_long,
	departement.lib_dept,
	groupe.lib_grp

END


Drop Table sysadm.#ComptageTmp

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_STSIN_REFU_TEL
-- Auteur               :       FABRY JF
-- Date                 :       08/06/2001
-- Libellé              :       Liste des garanties refus‚es pour la téléphonie
--				
-- Commentaires         :       
--				
--				
-- Références           :       Datawindow : D_L_REF2_TEL
--
-- Arguments            :       @dcPeriodeMin   Decimal(7)              (Val)
--				@dcPeriodeMax   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
--
-------------------------------------------------------------------


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_STSIN_REFU_TEL' AND type = 'P' )
        DROP procedure sysadm.DW_S02_STSIN_REFU_TEL
GO

CREATE procedure sysadm.DW_S02_STSIN_REFU_TEL 
		@dcPeriodeDeb	Decimal(7),
		@dcPeriodeFin	Decimal(7),
		@dcIdProd	Decimal(7) WITH RECOMPILE

AS

Declare	@sCodAdh Char(1)

Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramène dans un premier temps le détail du règlement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les réguls effectuées
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN
Select 	'PERIODE_DEB' 	= @dcPeriodeDeb,
 	'PERIODE_FIN'	= @dcPeriodeFin,
	'ID_SIN'	= s.id_sin,
	'ID_GTI'	= st.id_gti,
	'LIB_GTI' 	= code_Gs.lib_code,
	'ID_RGPT'	= st.id_rgpt,
	'ID_PROD'	= p.id_prod,
	'LIB_PROD'	= p.lib_long,
	'LIB_DEPT'	= d.lib_dept,
	'DTE_SURV'	= s.dte_surv,
	'EXERCICE'  	= DatePart ( year, s.dte_surv ),
	'DTE_DECL'	= s.dte_decl,
	'ID_ETS'	= g.id_grp,
	'ID_ADH' 	= s.id_adh, 
	'ID_SDOS' 	= s.id_sdos,  
	'NS' 		= code_Ns.lib_code,
	'LIB_GRP'	= g.lib_grp,
	'NOM_ADHERENT'  = RTrim ( LTrim ( pe.nom ) ),
	'PRENOM_ADHERENT'  = RTrim ( LTrim ( pe.prenom ) ),
	'COD_ETAT_GTI'	= st.cod_etat,
	'LIB_ETAT_GTI'	= code_Et.lib_code,
	'NUM_PORT'	= s.num_port,
	'NUM_IMEI_PORT'= s.num_imei_port,
	'MARQ_PORT'	= s.marq_port,
	'MODL_PORT'	= s.modl_port,
	'DTE_ACH_PORT'	= s.dte_ach_port,
	'DTE_OUVLIG_PORT' = s.dte_ouvlig_port,
	'ID_BOUTIQUE'	= s.id_orian_boutique


From	sysadm.stat_sin st, 
	sysadm.sinistre s,
	sysadm.produit p,
	sysadm.departement d,
	sysadm.groupe g,
	sysadm.code code_Ns,
	sysadm.code code_Gs,
	sysadm.code code_Et,
	sysadm.personne pe

where 	st.id_sin = s.id_sin
and	st.id_periode between @dcPeriodeDeb and @dcPeriodeFin
and	s.id_prod = @dcIdProd
and	p.id_prod = s.id_prod
and	d.id_dept = p.id_dept
and 	g.id_grp  = s.id_ets
and	pe.id_ordre = s.id_ordre
and	code_Ns.id_typ_code = '+NS'
and	code_Ns.id_code     = s.id_natsin
and	code_Gs.id_typ_code = '-GS'
and	code_Gs.id_code     = st.id_rgpt
and	code_Et.id_typ_code = '-ET'
and	code_Et.id_code     = st.cod_etat
and	st.cod_etat = 200
and 	st.cpt_etat = 1

END

ELSE

BEGIN	-- Adh SPB

Select 	'PERIODE_DEB' 	= @dcPeriodeDeb,
 	'PERIODE_FIN'	= @dcPeriodeFin,
	'ID_SIN'	= s.id_sin,
	'ID_GTI'	= st.id_gti,
	'LIB_GTI' 	= code_Gs.lib_code,
	'ID_RGPT'	= st.id_rgpt,
	'ID_PROD'	= p.id_prod,
	'LIB_PROD'	= p.lib_long,
	'LIB_DEPT'	= d.lib_dept,
	'DTE_SURV'	= s.dte_surv,
	'EXERCICE'  	= DatePart ( year, s.dte_surv ),
	'DTE_DECL'	= s.dte_decl,
	'ID_ETS'	= g.id_grp,
	'ID_ADH' 	= s.id_adh, 
	'ID_SDOS' 	= s.id_sdos,  
	'NS' 		= code_Ns.lib_code,
	'LIB_GRP'	= g.lib_grp,
	'NOM_ADHERENT'  = RTrim ( LTrim ( pe.nom ) ),
	'PRENOM_ADHERENT'  = RTrim ( LTrim ( pe.prenom ) ),
	'COD_ETAT_GTI'	= st.cod_etat,
	'LIB_ETAT_GTI'	= code_Et.lib_code,
	'NUM_PORT'	= s.num_port,
	'NUM_IMEI_PORT'= s.num_imei_port,
	'MARQ_PORT'	= s.marq_port,
	'MODL_PORT'	= s.modl_port,
	'DTE_ACH_PORT'	= s.dte_ach_port,
	'DTE_OUVLIG_PORT' = s.dte_ouvlig_port,
	'ID_BOUTIQUE'	= s.id_orian_boutique
	

From	sysadm.stat_sin st, 
	sysadm.sinistre s,
	sysadm.produit p,
	sysadm.departement d,
	sysadm.etablissement e,
	sysadm.groupe g,
	sysadm.code code_Ns,
	sysadm.code code_Gs,
	sysadm.code code_Et,
	sysadm.personne pe

where 	st.id_sin = s.id_sin
and	st.id_periode between @dcPeriodeDeb and @dcPeriodeFin
and	s.id_prod = @dcIdProd
and	p.id_prod = s.id_prod
and	d.id_dept = p.id_dept
and 	g.id_grp  = e.id_grp
and	e.id_prod = s.id_prod
and     e.id_ets  = s.id_ets
and	e.id_rev  = -1
and	pe.id_ordre = s.id_ordre
and	code_Ns.id_typ_code = '+NS'
and	code_Ns.id_code     = s.id_natsin
and	code_Gs.id_typ_code = '-GS'
and	code_Gs.id_code     = st.id_rgpt
and	code_Et.id_typ_code = '-ET'
and	code_Et.id_code     = st.cod_etat
and	st.cod_etat = 200
and 	st.cpt_etat = 1

END


GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S03_STSIN_ENCOURS_TEL
-- Auteur               :       FABRY JF
-- Date                 :       08/06/2001
-- Libellé              :       Liste des garanties en cours d'instruction pour la téléphonie
--				
-- Commentaires         :       
--				
--				
-- Références           :       Datawindow : D_L_ENC2_TEL
--
-- Arguments            :       @dcPeriodeMin   Decimal(7)              (Val)
--				@dcPeriodeMax   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
--
-------------------------------------------------------------------


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_STSIN_ENCOURS_TEL' AND type = 'P' )
        DROP procedure sysadm.DW_S03_STSIN_ENCOURS_TEL
GO

CREATE procedure sysadm.DW_S03_STSIN_ENCOURS_TEL 
		@dcPeriodeFin	Decimal(7),
		@dcIdProd	Decimal(7) WITH RECOMPILE

AS

Declare	@sCodAdh Char(1)

Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramène dans un premier temps le détail du règlement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les réguls effectuées
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN
Select 	'PERIODE_DEB' 	= @dcPeriodeFin,
 	'PERIODE_FIN'	= @dcPeriodeFin,
	'ID_SIN'	= s.id_sin,
	'ID_GTI'	= st.id_gti,
	'LIB_GTI' 	= code_Gs.lib_code,
	'ID_RGPT'	= st.id_rgpt,
	'ID_PROD'	= p.id_prod,
	'LIB_PROD'	= p.lib_long,
	'LIB_DEPT'	= d.lib_dept,
	'DTE_SURV'	= s.dte_surv,
	'EXERCICE'  	= DatePart ( year, s.dte_surv ),
	'DTE_DECL'	= s.dte_decl,
	'ID_ETS'	= g.id_grp,
	'ID_ADH' 	= s.id_adh, 
	'ID_SDOS' 	= s.id_sdos,  
	'NS' 		= code_Ns.lib_code,
	'LIB_GRP'	= g.lib_grp,
	'NOM_ADHERENT'  = RTrim ( LTrim ( pe.nom ) ),
	'PRENOM_ADHERENT'  = RTrim ( LTrim ( pe.prenom ) ),
	'COD_ETAT_GTI'	= st.cod_etat,
	'LIB_ETAT_GTI'	= code_Et.lib_code,
	'NUM_PORT'	= s.num_port,
	'NUM_IMEI_PORT'= s.num_imei_port,
	'MARQ_PORT'	= s.marq_port,
	'MODL_PORT'	= s.modl_port,
	'DTE_ACH_PORT'	= s.dte_ach_port,
	'DTE_OUVLIG_PORT' = s.dte_ouvlig_port,
	'ID_BOUTIQUE'	= s.id_orian_boutique

From	sysadm.stat_sin st, 
	sysadm.sinistre s,
	sysadm.produit p,
	sysadm.departement d,
	sysadm.groupe g,
	sysadm.code code_Ns,
	sysadm.code code_Gs,
	sysadm.code code_Et,
	sysadm.personne pe

where 	st.id_sin = s.id_sin
and	st.id_periode = @dcPeriodeFin
and	s.id_prod = @dcIdProd
and	p.id_prod = s.id_prod
and	d.id_dept = p.id_dept
and 	g.id_grp  = s.id_ets
and	pe.id_ordre = s.id_ordre
and	code_Ns.id_typ_code = '+NS'
and	code_Ns.id_code     = s.id_natsin
and	code_Gs.id_typ_code = '-GS'
and	code_Gs.id_code     = st.id_rgpt
and	code_Et.id_typ_code = '-ET'
and	code_Et.id_code     = st.cod_etat
and	st.cod_etat = 100
and 	st.cpt_etat = 1

END

ELSE

BEGIN	-- Adh SPB

Select 	'PERIODE_DEB' 	= @dcPeriodeFin,
 	'PERIODE_FIN'	= @dcPeriodeFin,
	'ID_SIN'	= s.id_sin,
	'ID_GTI'	= st.id_gti,
	'LIB_GTI' 	= code_Gs.lib_code,
	'ID_RGPT'	= st.id_rgpt,
	'ID_PROD'	= p.id_prod,
	'LIB_PROD'	= p.lib_long,
	'LIB_DEPT'	= d.lib_dept,
	'DTE_SURV'	= s.dte_surv,
	'EXERCICE'  	= DatePart ( year, s.dte_surv ),
	'DTE_DECL'	= s.dte_decl,
	'ID_ETS'	= g.id_grp,
	'ID_ADH' 	= s.id_adh, 
	'ID_SDOS' 	= s.id_sdos,  
	'NS' 		= code_Ns.lib_code,
	'LIB_GRP'	= g.lib_grp,
	'NOM_ADHERENT'  = RTrim ( LTrim ( pe.nom ) ),
	'PRENOM_ADHERENT'  = RTrim ( LTrim ( pe.prenom ) ),
	'COD_ETAT_GTI'	= st.cod_etat,
	'LIB_ETAT_GTI'	= code_Et.lib_code,
	'NUM_PORT'	= s.num_port,
	'NUM_IMEI_PORT'= s.num_imei_port,
	'MARQ_PORT'	= s.marq_port,
	'MODL_PORT'	= s.modl_port,
	'DTE_ACH_PORT'	= s.dte_ach_port,
	'DTE_OUVLIG_PORT' = s.dte_ouvlig_port,
	'ID_BOUTIQUE'	= s.id_orian_boutique
	



From	sysadm.stat_sin st, 
	sysadm.sinistre s,
	sysadm.produit p,
	sysadm.departement d,
	sysadm.etablissement e,
	sysadm.groupe g,
	sysadm.code code_Ns,
	sysadm.code code_Gs,
	sysadm.code code_Et,
	sysadm.personne pe

where 	st.id_sin = s.id_sin
and	st.id_periode = @dcPeriodeFin
and	s.id_prod = @dcIdProd
and	p.id_prod = s.id_prod
and	d.id_dept = p.id_dept
and 	g.id_grp  = e.id_grp
and	e.id_prod = s.id_prod
and     e.id_ets  = s.id_ets
and	e.id_rev  = -1
and	pe.id_ordre = s.id_ordre
and	code_Ns.id_typ_code = '+NS'
and	code_Ns.id_code     = s.id_natsin
and	code_Gs.id_typ_code = '-GS'
and	code_Gs.id_code     = st.id_rgpt
and	code_Et.id_typ_code = '-ET'
and	code_Et.id_code     = st.cod_etat
and	st.cod_etat = 100
and 	st.cpt_etat = 1

END

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S04_STSIN_SSUITE_TEL
-- Auteur               :       FABRY JF
-- Date                 :       08/06/2001
-- Libellé              :       Liste des garanties sans suite pour la téléphonie
--				
-- Commentaires         :       
--				
--				
-- Références           :       Datawindow : D_L_SSUITE_TEL
--
-- Arguments            :       @dcPeriodeMin   Decimal(7)              (Val)
--				@dcPeriodeMax   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
--
-------------------------------------------------------------------


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_STSIN_SSUITE_TEL' AND type = 'P' )
        DROP procedure sysadm.DW_S04_STSIN_SSUITE_TEL
GO

CREATE procedure sysadm.DW_S04_STSIN_SSUITE_TEL 
		@dcPeriodeDeb	Decimal(7),
		@dcPeriodeFin	Decimal(7),
		@dcIdProd	Decimal(7) WITH RECOMPILE

AS

Declare	@sCodAdh Char(1)

Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramène dans un premier temps le détail du règlement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les réguls effectuées
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN
Select 	'PERIODE_DEB' 	= @dcPeriodeDeb,
 	'PERIODE_FIN'	= @dcPeriodeFin,
	'ID_SIN'	= s.id_sin,
	'ID_GTI'	= st.id_gti,
	'LIB_GTI' 	= code_Gs.lib_code,
	'ID_RGPT'	= st.id_rgpt,
	'ID_PROD'	= p.id_prod,
	'LIB_PROD'	= p.lib_long,
	'LIB_DEPT'	= d.lib_dept,
	'DTE_SURV'	= s.dte_surv,
	'EXERCICE'  	= DatePart ( year, s.dte_surv ),
	'DTE_DECL'	= s.dte_decl,
	'ID_ETS'	= g.id_grp,
	'ID_ADH' 	= s.id_adh, 
	'ID_SDOS' 	= s.id_sdos,  
	'NS' 		= code_Ns.lib_code,
	'LIB_GRP'	= g.lib_grp,
	'NOM_ADHERENT'  = RTrim ( LTrim ( pe.nom ) ),
	'PRENOM_ADHERENT'  = RTrim ( LTrim ( pe.prenom ) ),
	'COD_ETAT_GTI'	= st.cod_etat,
	'LIB_ETAT_GTI'	= code_Et.lib_code,
	'NUM_PORT'	= s.num_port,
	'NUM_IMEI_PORT'= s.num_imei_port,
	'MARQ_PORT'	= s.marq_port,
	'MODL_PORT'	= s.modl_port,
	'DTE_ACH_PORT'	= s.dte_ach_port,
	'DTE_OUVLIG_PORT' = s.dte_ouvlig_port,
	'ID_BOUTIQUE'	= s.id_orian_boutique

From	sysadm.stat_sin st, 
	sysadm.sinistre s,
	sysadm.produit p,
	sysadm.departement d,
	sysadm.groupe g,
	sysadm.code code_Ns,
	sysadm.code code_Gs,
	sysadm.code code_Et,
	sysadm.personne pe

where 	st.id_sin = s.id_sin
and	st.id_periode between @dcPeriodeDeb and @dcPeriodeFin
and	s.id_prod = @dcIdProd
and	p.id_prod = s.id_prod
and	d.id_dept = p.id_dept
and 	g.id_grp  = s.id_ets
and	pe.id_ordre = s.id_ordre
and	code_Ns.id_typ_code = '+NS'
and	code_Ns.id_code     = s.id_natsin
and	code_Gs.id_typ_code = '-GS'
and	code_Gs.id_code     = st.id_rgpt
and	code_Et.id_typ_code = '-ET'
and	code_Et.id_code     = st.cod_etat
and	st.cod_etat = 900
and 	st.cpt_etat = 1

END

ELSE

BEGIN	-- Adh SPB

Select 	'PERIODE_DEB' 	= @dcPeriodeDeb,
 	'PERIODE_FIN'	= @dcPeriodeFin,
	'ID_SIN'	= s.id_sin,
	'ID_GTI'	= st.id_gti,
	'LIB_GTI' 	= code_Gs.lib_code,
	'ID_RGPT'	= st.id_rgpt,
	'ID_PROD'	= p.id_prod,
	'LIB_PROD'	= p.lib_long,
	'LIB_DEPT'	= d.lib_dept,
	'DTE_SURV'	= s.dte_surv,
	'EXERCICE'  	= DatePart ( year, s.dte_surv ),
	'DTE_DECL'	= s.dte_decl,
	'ID_ETS'	= g.id_grp,
	'ID_ADH' 	= s.id_adh, 
	'ID_SDOS' 	= s.id_sdos,  
	'NS' 		= code_Ns.lib_code,
	'LIB_GRP'	= g.lib_grp,
	'NOM_ADHERENT'  = RTrim ( LTrim ( pe.nom ) ),
	'PRENOM_ADHERENT'  = RTrim ( LTrim ( pe.prenom ) ),
	'COD_ETAT_GTI'	= st.cod_etat,
	'LIB_ETAT_GTI'	= code_Et.lib_code,
	'NUM_PORT'	= s.num_port,
	'NUM_IMEI_PORT'= s.num_imei_port,
	'MARQ_PORT'	= s.marq_port,
	'MODL_PORT'	= s.modl_port,
	'DTE_ACH_PORT'	= s.dte_ach_port,
	'DTE_OUVLIG_PORT' = s.dte_ouvlig_port,
	'ID_BOUTIQUE'	= s.id_orian_boutique
	
From	sysadm.stat_sin st, 
	sysadm.sinistre s,
	sysadm.produit p,
	sysadm.departement d,
	sysadm.etablissement e,
	sysadm.groupe g,
	sysadm.code code_Ns,
	sysadm.code code_Gs,
	sysadm.code code_Et,
	sysadm.personne pe

where 	st.id_sin = s.id_sin
and	st.id_periode between @dcPeriodeDeb and @dcPeriodeFin
and	s.id_prod = @dcIdProd
and	p.id_prod = s.id_prod
and	d.id_dept = p.id_dept
and 	g.id_grp  = e.id_grp
and	e.id_prod = s.id_prod
and     e.id_ets  = s.id_ets
and	e.id_rev  = -1
and	pe.id_ordre = s.id_ordre
and	code_Ns.id_typ_code = '+NS'
and	code_Ns.id_code     = s.id_natsin
and	code_Gs.id_typ_code = '-GS'
and	code_Gs.id_code     = st.id_rgpt
and	code_Et.id_typ_code = '-ET'
and	code_Et.id_code     = st.cod_etat
and	st.cod_etat = 900
and 	st.cpt_etat = 1

END

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S05_STSIN_ENCOURS_TEL
-- Auteur               :       FABRY JF
-- Date                 :       08/06/2001
-- Libellé              :       Liste des garanties en cours d'instruction pour la téléphonie
--				ayant une date de commande sans date de livraison
--				
-- Commentaires         :       
--				
--				
-- Références           :       Datawindow : D_L_ENC3_TEL
--
-- Arguments            :       @dcPeriodeMin   Decimal(7)              (Val)
--				@dcPeriodeMax   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S05_STSIN_ENCOURS_TEL' AND type = 'P' )
        DROP procedure sysadm.DW_S05_STSIN_ENCOURS_TEL
GO

CREATE procedure sysadm.DW_S05_STSIN_ENCOURS_TEL 
		@dcPeriodeFin	Decimal(7),
		@dcIdProd	Decimal(7) WITH RECOMPILE

AS

Declare	@sCodAdh Char(1)

Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramène dans un premier temps le détail du règlement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les réguls effectuées
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN
Select 	'PERIODE_DEB' 	= @dcPeriodeFin,
 	'PERIODE_FIN'	= @dcPeriodeFin,
	'ID_SIN'	= s.id_sin,
	'ID_GTI'	= st.id_gti,
	'LIB_GTI' 	= code_Gs.lib_code,
	'ID_RGPT'	= st.id_rgpt,
	'ID_PROD'	= p.id_prod,
	'LIB_PROD'	= p.lib_long,
	'LIB_DEPT'	= d.lib_dept,
	'DTE_SURV'	= s.dte_surv,
	'EXERCICE'  	= DatePart ( year, s.dte_surv ),
	'DTE_DECL'	= s.dte_decl,
	'ID_ETS'	= g.id_grp,
	'ID_ADH' 	= s.id_adh, 
	'ID_SDOS' 	= s.id_sdos,  
	'NS' 		= code_Ns.lib_code,
	'LIB_GRP'	= g.lib_grp,
	'NOM_ADHERENT'  = RTrim ( LTrim ( pe.nom ) ),
	'PRENOM_ADHERENT'  = RTrim ( LTrim ( pe.prenom ) ),
	'COD_ETAT_GTI'	= st.cod_etat,
	'LIB_ETAT_GTI'	= code_Et.lib_code,
	'DTE_CMD'	= de.dte_cmd,
	'EV'		= CodeEv.lib_code,
	'NUM_PORT'	= s.num_port,
	'NUM_IMEI_PORT'= s.num_imei_port,
	'MARQ_PORT'	= s.marq_port,
	'MODL_PORT'	= s.modl_port,
	'DTE_ACH_PORT'	= s.dte_ach_port,
	'DTE_OUVLIG_PORT' = s.dte_ouvlig_port,
	'ID_BOUTIQUE'	= s.id_orian_boutique
	

From	sysadm.stat_sin st, 
	sysadm.sinistre s,
	sysadm.produit p,
	sysadm.departement d,
	sysadm.groupe g,
	sysadm.code code_Ns,
	sysadm.code code_Gs,
	sysadm.code code_Et,
	sysadm.personne pe,
	sysadm.detail de,
	sysadm.code CodeEv

where 	st.id_sin = s.id_sin
and	st.id_periode = @dcPeriodeFin
and	s.id_prod = @dcIdProd
and	p.id_prod = s.id_prod
and	d.id_dept = p.id_dept
and 	g.id_grp  = s.id_ets
and	pe.id_ordre = s.id_ordre
and	code_Ns.id_typ_code = '+NS'
and	code_Ns.id_code     = s.id_natsin
and	code_Gs.id_typ_code = '-GS'
and	code_Gs.id_code     = st.id_rgpt
and	code_Et.id_typ_code = '-ET'
and	code_Et.id_code     = st.cod_etat
and	st.cod_etat = 100
and 	st.cpt_etat = 1
and 	de.id_sin = st.id_sin
and 	de.id_gti = st.id_gti
and 	de.dte_cmd is not null
and 	de.dte_livr is null
and	CodeEv.id_typ_code = '+EV'
and	CodeEv.id_code = de.id_evt

END

ELSE

BEGIN	-- Adh SPB

Select 	'PERIODE_DEB' 	= @dcPeriodeFin,
 	'PERIODE_FIN'	= @dcPeriodeFin,
	'ID_SIN'	= s.id_sin,
	'ID_GTI'	= st.id_gti,
	'LIB_GTI' 	= code_Gs.lib_code,
	'ID_RGPT'	= st.id_rgpt,
	'ID_PROD'	= p.id_prod,
	'LIB_PROD'	= p.lib_long,
	'LIB_DEPT'	= d.lib_dept,
	'DTE_SURV'	= s.dte_surv,
	'EXERCICE'  	= DatePart ( year, s.dte_surv ),
	'DTE_DECL'	= s.dte_decl,
	'ID_ETS'	= g.id_grp,
	'ID_ADH' 	= s.id_adh, 
	'ID_SDOS' 	= s.id_sdos,  
	'NS' 		= code_Ns.lib_code,
	'LIB_GRP'	= g.lib_grp,
	'NOM_ADHERENT'  = RTrim ( LTrim ( pe.nom ) ),
	'PRENOM_ADHERENT'  = RTrim ( LTrim ( pe.prenom ) ),
	'COD_ETAT_GTI'	= st.cod_etat,
	'LIB_ETAT_GTI'	= code_Et.lib_code,
	'DTE_CMD'	= de.dte_cmd,
	'EV'		= CodeEv.lib_code,
	'NUM_PORT'	= s.num_port,
	'NUM_IMEI_PORT'= s.num_imei_port,
	'MARQ_PORT'	= s.marq_port,
	'MODL_PORT'	= s.modl_port,
	'DTE_ACH_PORT'	= s.dte_ach_port,
	'DTE_OUVLIG_PORT' = s.dte_ouvlig_port,
	'ID_BOUTIQUE'	= s.id_orian_boutique	

From	sysadm.stat_sin st, 
	sysadm.sinistre s,
	sysadm.produit p,
	sysadm.departement d,
	sysadm.etablissement e,
	sysadm.groupe g,
	sysadm.code code_Ns,
	sysadm.code code_Gs,
	sysadm.code code_Et,
	sysadm.personne pe,
	sysadm.detail de,
	sysadm.code CodeEv

where 	st.id_sin = s.id_sin
and	st.id_periode = @dcPeriodeFin
and	s.id_prod = @dcIdProd
and	p.id_prod = s.id_prod
and	d.id_dept = p.id_dept
and 	g.id_grp  = e.id_grp
and	e.id_prod = s.id_prod
and     e.id_ets  = s.id_ets
and	e.id_rev  = -1
and	pe.id_ordre = s.id_ordre
and	code_Ns.id_typ_code = '+NS'
and	code_Ns.id_code     = s.id_natsin
and	code_Gs.id_typ_code = '-GS'
and	code_Gs.id_code     = st.id_rgpt
and	code_Et.id_typ_code = '-ET'
and	code_Et.id_code     = st.cod_etat
and	st.cod_etat = 100
and 	st.cpt_etat = 1
and 	de.id_sin = st.id_sin
and 	de.id_gti = st.id_gti
and 	de.dte_cmd is not null
and 	de.dte_livr is null
and	CodeEv.id_typ_code = '+EV'
and	CodeEv.id_code = de.id_evt

END

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S06_STSIN_OUV_TEL
-- Auteur               :       FABRY JF
-- Date                 :       08/06/2001
-- Libellé              :       Liste des garanties ouvertes pour la téléphonie
--				
-- Commentaires         :       
--				
--				
-- Références           :       Datawindow : D_L_ENC2_TEL
--
-- Arguments            :       @dcPeriodeMin   Decimal(7)              (Val)
--				@dcPeriodeMax   Decimal(7)              (Val)
--				@dcIdProd	Decimal(7)		(Val)
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S06_STSIN_OUV_TEL' AND type = 'P' )
        DROP procedure sysadm.DW_S06_STSIN_OUV_TEL
GO

CREATE procedure sysadm.DW_S06_STSIN_OUV_TEL 
		@dcPeriodeDeb	Decimal(7),
		@dcPeriodeFin	Decimal(7),
		@dcIdProd	Decimal(7) WITH RECOMPILE

AS

Declare	@sCodAdh Char(1)

Select @sCodAdh = produit.cod_adh
from   sysadm.produit
where  id_prod  = @dcIdProd

--******************************************************************
-- Chaque cas se compose de trois select avec Union All
-- Je ramène dans un premier temps le détail du règlement par garantie.
-- Ensuite, les frais d'envoi ou de Pv et enfin les réguls effectuées
--******************************************************************


If ( @sCodAdh = '3' ) 		-- Adhesions par carte

BEGIN
Select 	'PERIODE_DEB' 	= @dcPeriodeDeb,
 	'PERIODE_FIN'	= @dcPeriodeFin,
	'ID_SIN'	= s.id_sin,
	'ID_GTI'	= st.id_gti,
	'LIB_GTI' 	= code_Gs.lib_code,
	'ID_RGPT'	= st.id_rgpt,
	'ID_PROD'	= p.id_prod,
	'LIB_PROD'	= p.lib_long,
	'LIB_DEPT'	= d.lib_dept,
	'DTE_SURV'	= s.dte_surv,
	'EXERCICE'  	= DatePart ( year, s.dte_surv ),
	'DTE_DECL'	= s.dte_decl,
	'ID_ETS'	= g.id_grp,
	'ID_ADH' 	= s.id_adh, 
	'ID_SDOS' 	= s.id_sdos,  
	'NS' 		= code_Ns.lib_code,
	'LIB_GRP'	= g.lib_grp,
	'NOM_ADHERENT'  = RTrim ( LTrim ( pe.nom ) ),
	'PRENOM_ADHERENT'  = RTrim ( LTrim ( pe.prenom ) ),
	'COD_ETAT_GTI'	= st.cod_etat,
	'LIB_ETAT_GTI'	= code_Et.lib_code,
	'NUM_PORT'	= s.num_port,
	'NUM_IMEI_PORT'= s.num_imei_port,
	'MARQ_PORT'	= s.marq_port,
	'MODL_PORT'	= s.modl_port,
	'DTE_ACH_PORT'	= s.dte_ach_port,
	'DTE_OUVLIG_PORT' = s.dte_ouvlig_port,
	'ID_BOUTIQUE'	= s.id_orian_boutique
	


From	sysadm.stat_sin st, 
	sysadm.sinistre s,
	sysadm.produit p,
	sysadm.departement d,
	sysadm.groupe g,
	sysadm.code code_Ns,
	sysadm.code code_Gs,
	sysadm.code code_Et,
	sysadm.personne pe

where 	st.id_sin = s.id_sin
and	st.id_periode between  @dcPeriodeDeb and @dcPeriodeFin
and	s.id_prod = @dcIdProd
and	p.id_prod = s.id_prod
and	d.id_dept = p.id_dept
and 	g.id_grp  = s.id_ets
and	pe.id_ordre = s.id_ordre
and	code_Ns.id_typ_code = '+NS'
and	code_Ns.id_code     = s.id_natsin
and	code_Gs.id_typ_code = '-GS'
and	code_Gs.id_code     = st.id_rgpt
and	code_Et.id_typ_code = '-ET'
and	code_Et.id_code     = st.cod_etat
and 	st.cpt_ouv = 1

END

ELSE

BEGIN	-- Adh SPB

Select 	'PERIODE_DEB' 	= @dcPeriodeDeb,
 	'PERIODE_FIN'	= @dcPeriodeFin,
	'ID_SIN'	= s.id_sin,
	'ID_GTI'	= st.id_gti,
	'LIB_GTI' 	= code_Gs.lib_code,
	'ID_RGPT'	= st.id_rgpt,
	'ID_PROD'	= p.id_prod,
	'LIB_PROD'	= p.lib_long,
	'LIB_DEPT'	= d.lib_dept,
	'DTE_SURV'	= s.dte_surv,
	'EXERCICE'  	= DatePart ( year, s.dte_surv ),
	'DTE_DECL'	= s.dte_decl,
	'ID_ETS'	= g.id_grp,
	'ID_ADH' 	= s.id_adh, 
	'ID_SDOS' 	= s.id_sdos,  
	'NS' 		= code_Ns.lib_code,
	'LIB_GRP'	= g.lib_grp,
	'NOM_ADHERENT'  = RTrim ( LTrim ( pe.nom ) ),
	'PRENOM_ADHERENT'  = RTrim ( LTrim ( pe.prenom ) ),
	'COD_ETAT_GTI'	= st.cod_etat,
	'LIB_ETAT_GTI'	= code_Et.lib_code,
	'NUM_PORT'	= s.num_port,
	'NUM_IMEI_PORT'= s.num_imei_port,
	'MARQ_PORT'	= s.marq_port,
	'MODL_PORT'	= s.modl_port,
	'DTE_ACH_PORT'	= s.dte_ach_port,
	'DTE_OUVLIG_PORT' = s.dte_ouvlig_port,
	'ID_BOUTIQUE'	= s.id_orian_boutique

From	sysadm.stat_sin st, 
	sysadm.sinistre s,
	sysadm.produit p,
	sysadm.departement d,
	sysadm.etablissement e,
	sysadm.groupe g,
	sysadm.code code_Ns,
	sysadm.code code_Gs,
	sysadm.code code_Et,
	sysadm.personne pe

where 	st.id_sin = s.id_sin
and	st.id_periode between  @dcPeriodeDeb and @dcPeriodeFin
and	s.id_prod = @dcIdProd
and	p.id_prod = s.id_prod
and	d.id_dept = p.id_dept
and 	g.id_grp  = e.id_grp
and	e.id_prod = s.id_prod
and     e.id_ets  = s.id_ets
and	e.id_rev  = -1
and	pe.id_ordre = s.id_ordre
and	code_Ns.id_typ_code = '+NS'
and	code_Ns.id_code     = s.id_natsin
and	code_Gs.id_typ_code = '-GS'
and	code_Gs.id_code     = st.id_rgpt
and	code_Et.id_typ_code = '-ET'
and	code_Et.id_code     = st.cod_etat
and 	st.cpt_ouv = 1

END

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_REELLE_SFRPGC
-- Auteur               :       FABRY JF
-- Date                 :       31/08/2001
-- Libell‚              :       Suite DCMP 020359 
-- Commentaires         :       Stat ParticuliŠre demandait Corinne Varoqueaux (DNT) pour 
--				Marion Lambert SFR/CEGETEL
--				La stat est faite sur la base r‚elle (vu avec JL Quemar, M.Plantrose)
-- R‚f‚rences           :       Cas : 'TOUT_SAUF_REGREF'
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- [BUG20080728].COD_MODE_REG  JFF  (Je ne modifie pas cette PS car visibile un critère s.cod_etat not in ( 550, 600, 200 ) exclu les réglements 
-- même si l'on affiche s.mt_reg (??)
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_REELLE_SFRPGC' AND type = 'P' )
        DROP procedure sysadm.DW_S01_REELLE_SFRPGC
GO

CREATE procedure sysadm.DW_S01_REELLE_SFRPGC
	@dcIdProd	Decimal ( 7,0 ),
        @dtDteDeb	DateTime,
        @dtDteFin	DateTime
        
AS


/*********************************************
Tout sauf Regles, et refuses
Cela afin de prendre en compte les sans suite qui n'ont
pas de garantie ni de dÚtail
**********************************************/
Select  s.id_sin	  Ref_sinistre,
	s.id_prod	  Code_Produit,
	CONVERT (char(11), @dtDteDeb	 , 103) + CONVERT (char(8), @dtDteDeb	  , 108) Dos_Cree_Le_Rech_Debut,
	CONVERT (char(11), @dtDteFin	 , 103) + CONVERT (char(8), @dtDteFin	  , 108) Dos_Cree_le_Rech_Fin,
	CONVERT (char(10),s.id_orian_boutique ) Code_Orian_Boutique,
	CONVERT (char(11), s.dte_ach_port, 103) + CONVERT (char(8), s.dte_ach_port, 108) Date_Achat_Mobile,
	CONVERT (char(11), s.dte_adh	 , 103) + CONVERT (char(8), s.dte_adh	  , 108) Date_Adhesion,
	p.nom		  Nom_Assure,
	p.prenom	  Prenom_Assure,
	s.marq_port       Marque_Mobile,
	s.modl_port       Modele_Mobile, 
	s.num_imei_port   IMEI,          
	s.num_port        Num_Appel_Mobile,
	CONVERT (char(11), s.dte_decl	  , 103) + CONVERT (char(8), s.dte_decl	  , 108) Date_Decl_Sinistre,
	CodeET.lib_code	  Etat_Dossier,
	s.mt_reg	  Mt_Regle_Sur_Dossier,
	CONVERT (char(11), s.cree_le	  , 103) + CONVERT (char(8), s.cree_le	  , 108) Dossier_Cree_Le,
	CONVERT (char(11), s.valide_le	  , 103) + CONVERT (char(8), s.valide_le  , 108) Derniere_Validation_Dossier

From	sysadm.sinistre s,
	sysadm.personne p,
	sysadm.code CodeET 

Where   s.id_prod = @dcIdProd
and	s.cod_etat not in ( 550,600, 200 )
and	CodeET.id_typ_code = '-ET'
and 	CodeET.id_code = s.cod_etat
and	s.id_ordre = p.id_ordre
and	s.cree_le between @dtDteDeb and @dtDteFin
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S02_REELLE_SFRPGC
-- Auteur               :       FABRY JF
-- Date                 :       31/08/2001
-- Libell‚              :       Suite DCMP 020359 
-- Commentaires         :       Stat ParticuliŠre demandait Corinne Varoqueaux (DNT) pour 
--				Marion Lambert SFR/CEGETEL
--				La stat est faite sur la base r‚elle (vu avec JL Quemar, M.Plantrose)
-- R‚f‚rences           :       Cas : 'TOUT_REGENCREG'
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_REELLE_SFRPGC' AND type = 'P' )
        DROP procedure sysadm.DW_S02_REELLE_SFRPGC
GO

CREATE procedure sysadm.DW_S02_REELLE_SFRPGC
	@dcIdProd	Decimal ( 7,0 ),
        @dtDteDeb	DateTime,
        @dtDteFin	DateTime
        
AS

/*********************************************
Tous les regle et en cours de reglement
Un dossier rÚglÚ a au moins une Gti et un Detail
**********************************************/

Select  s.id_sin	  Ref_sinistre,
	s.id_prod	  Code_Produit,
	CONVERT (char(11), @dtDteDeb	 , 103) + CONVERT (char(8), @dtDteDeb	  , 108) Prem_Regl_Rech_Debut,
	CONVERT (char(11), @dtDteFin	 , 103) + CONVERT (char(8), @dtDteFin	  , 108) Prem_Regl_Rech_Fin,
	p.nom		  Nom_Assure,
	p.prenom	  Prenom_Assure,
	CONVERT (char(10),s.id_orian_boutique ) Code_Orian_Boutique,
	CONVERT (char(11), s.dte_ach_port , 103) + CONVERT (char(8), s.dte_ach_port , 108) Date_Achat_Mobile,
	CONVERT (char(11), s.dte_adh, 103) + CONVERT (char(8), s.dte_adh, 108) Date_Adhesion,
	s.marq_port       Marque_Mobile,
	s.modl_port       Modele_Mobile, 
	s.num_imei_port   IMEI,          
	s.num_port        Num_Appel_Mobile,
	CONVERT (char(11), s.dte_decl, 103) + CONVERT (char(8), s.dte_decl, 108) Date_Decl_Sinistre,
	CONVERT (char(11), s.valide_le, 103) + CONVERT (char(8), s.valide_le, 108) Derniere_Validation_Dossier,
	CodeETSin.lib_code Etat_Dossier,
	s.mt_reg	  Mt_Regle_Sur_Dossier,
	CodeGA.lib_code	  Lib_Garantie,
	g.mt_tot_prej	  Prej_Tot_Sur_Garantie,
	CodeETGti.lib_code Etat_Garantie,
	g.mt_plaf_reg	  Mt_Regle_Sur_Garantie,
	CodeEV.lib_code	  Evenement_detail,
	d.mt_prej	  Prejudice_sur_detail,
	CodeETDet.lib_code Etat_Detail,
	d.mt_plaf	  Mt_Regle_Sur_detail,
	CONVERT (char(11), rg.dte_reg, 103) + CONVERT (char(8), rg.dte_reg, 108) Regle_Le,
	CONVERT (char(11), s.cree_le, 103) + CONVERT (char(8), s.cree_le, 108) Dossier_Cree_Le

From	sysadm.sinistre s,
	sysadm.gar_sin  g,
	sysadm.detail	 d,
	sysadm.code	 CodeEV,
	sysadm.code	 CodeGA,
	sysadm.reglement rg,
	sysadm.code	 CodeETSin,
	sysadm.code	 CodeETGti,
	sysadm.code	 CodeETDet,
	sysadm.personne p		

Where   s.id_prod = @dcIdProd
and 	s.id_sin  = g.id_sin
and	g.id_sin  = d.id_sin
and	g.id_gti  = d.id_gti
and	s.id_ordre = p.id_ordre
and	CodeEV.id_typ_code = '+EV'
and 	CodeEV.id_code = d.id_evt
and	CodeGA.id_typ_code = '-GA'
and 	CodeGA.id_code = g.id_gti
and	s.cod_etat in ( 550,600 )
and	rg.id_sin = s.id_sin
and	rg.id_reg = 1
and	CodeETSin.id_typ_code = '-ET'
and 	CodeETSin.id_code = s.cod_etat
and	CodeETGti.id_typ_code = '-ET'
and 	CodeETGti.id_code = g.cod_etat
and	CodeETDet.id_typ_code = '-ET'
and 	CodeETDet.id_code = d.cod_etat 
and	rg.dte_reg between @dtDteDeb and @dtDteFin	


GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S03_REELLE_SFRPGC
-- Auteur               :       FABRY JF
-- Date                 :       31/08/2001
-- Libell‚              :       Suite DCMP 020359 
-- Commentaires         :       Stat ParticuliŠre demandait Corinne Varoqueaux (DNT) pour 
--				Marion Lambert SFR/CEGETEL
--				La stat est faite sur la base r‚elle (vu avec JL Quemar, M.Plantrose)
-- R‚f‚rences           :       Cas : 'TOUT_REF_DOSGTI'
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_REELLE_SFRPGC' AND type = 'P' )
        DROP procedure sysadm.DW_S03_REELLE_SFRPGC
GO

CREATE procedure sysadm.DW_S03_REELLE_SFRPGC
	 	  @dcIdProd	Decimal ( 7,0 ),
        @dtDteDeb	DateTime,
        @dtDteFin	DateTime
        
AS

/*********************************************
Tous les dossiers refusÚs ayant une garantie refusÚes
On ne gÞre pas les dÚtails refusÚs, vu avec JLQ et MPL.
**********************************************/
Select  s.id_sin	  Ref_sinistre,
	s.id_prod	  Code_Produit,
	CONVERT (char(11), @dtDteDeb	 , 103) + CONVERT (char(8), @dtDteDeb	  , 108) Dos_Valide_Le_Rech_Debut,
	CONVERT (char(11), @dtDteFin	 , 103) + CONVERT (char(8), @dtDteFin	  , 108) Dos_Valide_Le_Rech_Fin,
	p.nom		  Nom_Assure,
	p.prenom	  Prenom_Assure,
	CONVERT (char(10),s.id_orian_boutique ) Code_Orian_Boutique,
	CONVERT (char(11), s.dte_ach_port , 103) + CONVERT (char(8), s.dte_ach_port , 108) Date_Achat_Mobile,
	CONVERT (char(11), s.dte_adh, 103) + CONVERT (char(8), s.dte_adh, 108) Date_Adhesion,
	s.marq_port       Marque_Mobile,
	s.modl_port       Modele_Mobile, 
	s.num_imei_port   IMEI,
	s.num_port        Num_Appel_Mobile,
	CONVERT (char(11), s.dte_decl, 103) + CONVERT (char(8), s.dte_decl, 108) Date_Decl_Sinistre,
	CONVERT (char(11), s.valide_le, 103) + CONVERT (char(8), s.valide_le, 108) Derniere_Validation_Dossier,
	CodeETSin.lib_code  Etat_Dossier,
	s.mt_reg	  Mt_Regle_Sur_Dossier,
	g.id_gti	  Garantie,
	CodeGA.lib_code	  Lib_Garantie,
	g.mt_tot_prej	  Prej_Tot_Sur_Garantie,
	CodeETGti.lib_code  Etat_Garantie,
	g.mt_plaf_reg	  Mt_Regle_Sur_Garantie

From	sysadm.sinistre s,
	sysadm.gar_sin  g,
	sysadm.code	 CodeGA,
	sysadm.code	 CodeETSin,
	sysadm.code	 CodeETGti,
	sysadm.personne p		

Where   s.id_prod = @dcIdProd
and 	s.id_sin  = g.id_sin
and	s.id_ordre = p.id_ordre	
and	CodeGA.id_typ_code = '-GA'
and 	CodeGA.id_code = g.id_gti
and	s.cod_etat = 200
and	CodeETSin.id_typ_code = '-ET'
and 	CodeETSin.id_code = s.cod_etat
and	CodeETGti.id_typ_code = '-ET'
and 	CodeETGti.id_code = g.cod_etat
and	s.valide_le between @dtDteDeb and @dtDteFin	

Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S04_REELLE_SFRPGC
-- Auteur               :       FABRY JF
-- Date                 :       31/08/2001
-- Libell‚              :       Suite DCMP 020359 
-- Commentaires         :       Stat ParticuliŠre demandait Corinne Varoqueaux (DNT) pour 
--				Marion Lambert SFR/CEGETEL
--				La stat est faite sur la base r‚elle (vu avec JL Quemar, M.Plantrose)
-- R‚f‚rences           :       Cas : 'MOTIF_REFUS_GTI'
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_REELLE_SFRPGC' AND type = 'P' )
        DROP procedure sysadm.DW_S04_REELLE_SFRPGC
GO

CREATE procedure sysadm.DW_S04_REELLE_SFRPGC
	@dcIdProd	Decimal ( 7,0 ),
        @dtDteDeb	DateTime,
        @dtDteFin	DateTime
AS

/*********************************************
Tous les motifs de refus sur les dossiers refusÚs
ayant leur garantie refusÚs.
**********************************************/

Select 	s.id_sin	ref_sin,
	s.id_prod	  Code_Produit,
	CONVERT (char(11), @dtDteDeb	 , 103) + CONVERT (char(8), @dtDteDeb	  , 108) Refus_Cree_Le_Rech_Debut,
	CONVERT (char(11), @dtDteFin	 , 103) + CONVERT (char(8), @dtDteFin	  , 108) Refus_Cree_Le_Rech_Fin,
	p.nom		  Nom_Assure,
	p.prenom	  Prenom_Assure,
	CONVERT (char(10),s.id_orian_boutique ) Code_Orian_Boutique,
	CONVERT (char(11), s.dte_ach_port , 103) + CONVERT (char(8), s.dte_ach_port , 108) Date_Achat_Mobile,
	CONVERT (char(11), s.dte_adh, 103) + CONVERT (char(8), s.dte_adh, 108) Date_Adhesion,
	s.marq_port       Marque_Mobile,
	s.modl_port       Modele_Mobile, 
	s.num_imei_port   IMEI,          
	s.num_port        Num_Appel_Mobile,
	CONVERT (char(11), s.dte_decl, 103) + CONVERT (char(8), s.dte_decl, 108) Date_Decl_Sinistre,
	CONVERT (char(11), s.valide_le, 103) + CONVERT (char(8), s.valide_le, 108) Derniere_Validation_Dossier,
	CodeETSin.lib_code  etat_sinistre_refuse,
	g.id_gti	Garantie,
	CodeETGti.lib_code  	etat_garantie_refuse,
	CodeRE.lib_code	Motif_de_refus_sur_la_garantie,
	Case
		when r.id_i is not null then 'Motif apparu sur le courrier'
		Else 'Motif n''est pas apparu sur le courrier'

	End 'Sur_courrier_Pas_sur_courrier',
	CONVERT (char(11), r.cree_le, 103) + CONVERT (char(8), r.cree_le, 108) Refuse_le

From 	sysadm.sinistre s, 
	sysadm.gar_sin  g,
	sysadm.refus r,
	sysadm.code CodeRE,
	sysadm.code	 CodeETSin,
	sysadm.code	 CodeETGti,
	sysadm.personne p		

where 	s.id_prod = @dcIdProd
and 	s.id_sin = g.id_sin
and	s.id_ordre = p.id_ordre	
and 	s.cod_etat = 200
and 	g.cod_etat = 200
and	r.id_sin = g.id_sin
and	r.id_detail = -1
and 	CodeRE.id_typ_code = '+RE'
and 	CodeRE.id_code = r.id_motif
and	CodeETSin.id_typ_code = '-ET'
and 	CodeETSin.id_code = s.cod_etat
and	CodeETGti.id_typ_code = '-ET'
and 	CodeETGti.id_code = g.cod_etat
and	r.cree_le between @dtDteDeb and @dtDteFin		
 
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S05_REELLE_SFRPGC
-- Auteur               :       FABRY JF
-- Date                 :       31/08/2001
-- Libell‚              :       Suite DCMP 020359 
-- Commentaires         :       Stat ParticuliŠre demandait Corinne Varoqueaux (DNT) pour 
--				Marion Lambert SFR/CEGETEL
--				La stat est faite sur la base r‚elle (vu avec JL Quemar, M.Plantrose)
-- R‚f‚rences           :       Cas : 'MT_PREJ_DET_ATT'
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S05_REELLE_SFRPGC' AND type = 'P' )
        DROP procedure sysadm.DW_S05_REELLE_SFRPGC
GO

CREATE procedure sysadm.DW_S05_REELLE_SFRPGC
	@dcIdProd	Decimal ( 7,0 ),
        @dtDteDeb	DateTime,
        @dtDteFin	DateTime
AS

/*********************************************
Montant du prÚjudice des dÚtails en attente
**********************************************/

Select  s.id_sin	  Ref_sinistre,
	s.id_prod	  Code_Produit,
	CONVERT (char(11), @dtDteDeb	 , 103) + CONVERT (char(8), @dtDteDeb	  , 108) Detail_Cree_Le_Rech_Debut,
	CONVERT (char(11), @dtDteFin	 , 103) + CONVERT (char(8), @dtDteFin	  , 108) Detail_Cree_Le_Rech_Fin,
	p.nom		  Nom_Assure,
	p.prenom	  Prenom_Assure,
	CONVERT (char(10),s.id_orian_boutique ) Code_Orian_Boutique,
	CONVERT (char(11), s.dte_ach_port , 103) + CONVERT (char(8), s.dte_ach_port , 108) Date_Achat_Mobile,
	CONVERT (char(11), s.dte_adh, 103) + CONVERT (char(8), s.dte_adh, 108) Date_Adhesion,
	s.marq_port       Marque_Mobile,
	s.modl_port       Modele_Mobile, 
	s.num_imei_port   IMEI,          
	s.num_port        Num_Appel_Mobile,
	CONVERT (char(11), s.dte_decl, 103) + CONVERT (char(8), s.dte_decl, 108) Date_Decl_Sinistre,
	CONVERT (char(11), s.valide_le, 103) + CONVERT (char(8), s.valide_le, 108) Derniere_Validation_Dossier,
	CodeETSin.lib_code Etat_Dossier,
	s.mt_reg	  Mt_Regle_Sur_Dossier,
	CodeGA.lib_code	  Lib_Garantie,
	g.mt_tot_prej	  Prej_Tot_Sur_Garantie,
	CodeETGti.lib_code Etat_Garantie,
	g.mt_plaf_reg	  Mt_Regle_Sur_Garantie,
	CodeEV.lib_code	  Evenement_detail,
	d.mt_prej	  Prejudice_sur_detail,
	CodeETDet.lib_code Etat_Detail,
	d.mt_plaf	  Mt_Regle_Sur_detail,
	CONVERT (char(11), d.cree_le, 103) + CONVERT (char(8), d.cree_le, 108) Detail_Cree_Le

From	sysadm.sinistre s,
	sysadm.gar_sin  g,
	sysadm.detail	 d,
	sysadm.code	 CodeEV,
	sysadm.code	 CodeGA,
	sysadm.code	 CodeETSin,
	sysadm.code	 CodeETGti,
	sysadm.code	 CodeETDet,
	sysadm.personne p		

Where   s.id_prod = @dcIdProd
and 	s.id_sin  = g.id_sin
and	g.id_sin  = d.id_sin
and	g.id_gti  = d.id_gti
and	s.id_ordre = p.id_ordre
and	CodeEV.id_typ_code = '+EV'
and 	CodeEV.id_code = d.id_evt
and	CodeGA.id_typ_code = '-GA'
and 	CodeGA.id_code = g.id_gti
and	d.cod_etat = 100
and	CodeETSin.id_typ_code = '-ET'
and 	CodeETSin.id_code = s.cod_etat
and	CodeETGti.id_typ_code = '-ET'
and 	CodeETGti.id_code = g.cod_etat
and	CodeETDet.id_typ_code = '-ET'
and 	CodeETDet.id_code = d.cod_etat 
and	d.cree_le between @dtDteDeb and @dtDteFin	

Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_REELLE_DETSIN_TEL
-- Auteur               :       Abdmeziem Catherine
-- Date                 :       28/02/2003
-- Libell‚              :       DCMP 030126
-- Commentaires         :       Corinne Varoqueaux (DNT) demande une stat selon modŠle SAS
--				pour Mobile Protect pour Axelle de Barbeyrac (SFR)
--				La stat est faite sur la base reelle
-- R‚f‚rences           :       D_L_TEL1
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--				@dcIdProd	Decimal(7)		(Val)
--
-- Retourne             :       Rien
-- [BUG20080728].COD_MODE_REG  JFF
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_REELLE_DETSIN_TEL' AND type = 'P' )
        DROP procedure sysadm.DW_S01_REELLE_DETSIN_TEL
GO

CREATE procedure sysadm.DW_S01_REELLE_DETSIN_TEL
        @dtDteDeb	DateTime,
        @dtDteFin	DateTime,
	@dcIdProd	Decimal ( 7,0 )
AS

/********************************************************
			CAS 1
Selection des sinistres dont la derniere commande (TEL,PRS)
n'est pas (annulee, ou retour SPB) 
			 ET
dont le dernier reglement RN est entre dans les dates
*********************************************************/

Select	@dtDteDeb							Dte_Debut_Stat,
	@dtDteFin							Dte_Fin_Stat,
	Upper ( LTrim ( RTrim ( s.num_port ) ) )			N_Appel,
	Upper ( LTrim ( RTrim ( s.id_contrat_abonne ) ) )		N_Contrat_abonn_SFR,
	s.dte_adh							Dte_Sous,
	Upper ( LTrim ( RTrim ( p.nom ) ) + ' ' + LTrim ( RTrim ( p.prenom ) ) ) Nom_Prenom_Ass,
	s.id_sin 							N_Dossier,
	Upper ( LTrim ( RTrim ( s.marq_port ) ) + ' ' + LTrim ( RTrim ( s.modl_port ) ) ) Marq_Modl_Sinistre,
	s.dte_decl							Dte_Decl,
	s.dte_surv							Dte_Surv,
	cns.lib_code 							Nat_Sin,
	ces.lib_code							Etat_Sin,
	s.valide_le							Dte_Dern_Valid,
	-- [BUG20080728].COD_MODE_REG  JFF
	( Select Sum ( IsNull ( r1.mt_tot_reg, 0 ) )
	  From	 sysadm.reglement r1
	  Where  r1.id_sin = s.id_sin
	  and    r1.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) 
	  and    r1.cod_mot_reg not in ( 'RI' ) 	  
	)								Mnt_Reg,
	--	s.mt_reg							Mnt_Reg,
	-- [BUG20080728].COD_MODE_REG  JFF
	Case
		When c.id_typ_art = 'TEL' Then 'COMMANDE'
		When c.id_typ_art = 'PRS' Then 'PRESTATION'
	End								Typ_Art,
	Case
		When c.id_typ_art = 'TEL' Then Upper ( LTrim ( RTrim ( c.id_marq_art ) ) + ' ' + LTrim ( RTrim ( c.id_modl_art ) ) ) 
		When c.id_typ_art = 'PRS' Then ''
	End								Marq_Modl_Cmde,
	c.cree_le							Dte_Prise_Cmde,
	c.cmd_gen_le							Dte_Envoi,
	cec.lib_code 							Etat_Cmde

  From 	sinistre s,
	commande c,
	reglement r,
	personne p,
	code cns,
	code ces,
	code_car cec

 Where 	s.id_prod	= @dcIdProd
   And 	c.id_sin	= s.id_sin
   And 	c.id_typ_art	in ( 'TEL', 'PRS' )
   And 	c.cod_etat 	Not In ( 'ANN', 'RSP' )
   And	c.id_seq	= (Select max (c1.id_seq) 
		 	     From commande c1
		 	    Where c1.id_sin = c.id_sin )
   And	s.cod_etat	In ( 550, 600 )
   And	r.id_sin	= s.id_sin
   And	r.id_reg	= (Select max (r1.id_reg) 
		 	     From reglement r1
		 	    Where r1.id_sin	 = r.id_sin
		 	      And r1.cod_mot_reg = 'RN' )
   And	r.dte_reg Between @dtDteDeb And @dtDteFin
   And	s.id_ordre	= p.id_ordre
   And	cns.id_typ_code	= '+NS'
   And	s.id_natsin	= cns.id_code
   And	ces.id_typ_code	= '-ET'
   And	s.cod_etat	= ces.id_code
   And	cec.id_typ_code	= '-EC'
   And	c.cod_etat	= cec.id_code
	 -- [PM266]
	  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
			Or
			Not Exists ( 
				Select 1
				From	sysadm.exclu_ass ex,
						sysadm.garantie ga,
						sysadm.police po,
						sysadm.reg_gti rg
				Where	rg.id_sin = r.id_sin
				And     rg.id_reg = r.id_reg
				And		ga.id_prod = s.id_prod
				And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
												IsNull ( 
													( Select max (id_rev )
													  From   revision r
													  Where  r.id_prod = s.id_prod ) , 0 ))
				And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
												(
												  Select top 1 id_gti  
												  From   sysadm.garantie ga2
												  Where  ga2.id_prod = ga.id_prod
												  And    ga2.id_rev = ga.id_rev 
												)
											)
				And		po.id_police = ga.id_police
				and		ex.id_cie = po.id_cie			
			)
		  ) 

UNION ALL

/********************************************************
			CAS 2
Selection des sinistres dont la derniere commande (TEL, PRS)
n'est pas (annulee, ou retour SPB)
			 ET
n'ayant pas de reglement
*********************************************************/

Select	@dtDteDeb							Dte_Debut_Stat,
	@dtDteFin							Dte_Fin_Stat,
	Upper ( LTrim ( RTrim ( s.num_port ) ) )			N_Appel,
	Upper ( LTrim ( RTrim ( s.id_contrat_abonne ) ) )		N_Contrat_abonn_SFR,
	s.dte_adh							Dte_Sous,
	Upper ( LTrim ( RTrim ( p.nom ) ) + ' ' + LTrim ( RTrim ( p.prenom ) ) ) Nom_Prenom_Ass,
	s.id_sin 							N_Dossier,
	Upper ( LTrim ( RTrim ( s.marq_port ) ) + ' ' + LTrim ( RTrim ( s.modl_port ) ) ) Marq_Modl_Sinistre,
	s.dte_decl							Dte_Decl,
	s.dte_surv							Dte_Surv,
	cns.lib_code 							Nat_Sin,
	ces.lib_code 							Etat_Sin,
	s.valide_le							Dte_Dern_Valid,
	-- [BUG20080728].COD_MODE_REG  JFF
	( Select Sum ( IsNull ( r1.mt_tot_reg, 0 ) )
	  From	 sysadm.reglement r1
	  Where  r1.id_sin = s.id_sin
	  and    r1.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) 
	  and    r1.cod_mot_reg not in ( 'RI' ) 	  
	)								Mnt_Reg,
	--	s.mt_reg							Mnt_Reg,
	-- [BUG20080728].COD_MODE_REG  JFF
	Case
		When c.id_typ_art = 'TEL' Then 'COMMANDE'
		When c.id_typ_art = 'PRS' Then 'PRESTATION'
	End								Typ_Art,
	Case
		When c.id_typ_art = 'TEL' Then Upper ( LTrim ( RTrim ( c.id_marq_art ) ) + ' ' + LTrim ( RTrim ( c.id_modl_art ) ) ) 
		When c.id_typ_art = 'PRS' Then ''
	End								Marq_Modl_Cmde,
	c.cree_le							Dte_Prise_Cmde,
	c.cmd_gen_le							Dte_Envoi,
	cec.lib_code 							Etat_Cmde

  From 	sinistre s,
	commande c,
	personne p,
	code cns,
	code ces,
	code_car cec


 Where 	s.id_prod	= @dcIdProd
   And 	c.id_sin	= s.id_sin
   And 	c.id_typ_art	in ( 'TEL', 'PRS' )
   And 	c.cod_etat	Not In ( 'ANN', 'RSP' )
   And	c.id_seq	= (Select max (c1.id_seq) 
		 	     From commande c1
		 	    Where c1.id_sin = c.id_sin )
   And	s.cod_etat	Not In ( 550, 600 )
   And	s.valide_le	Between @dtDteDeb And @dtDteFin
   And	s.id_ordre	= p.id_ordre
   And	cns.id_typ_code	= '+NS'
   And	s.id_natsin	= cns.id_code
   And	ces.id_typ_code	= '-ET'
   And	s.cod_etat	= ces.id_code
   And	cec.id_typ_code	= '-EC'
   And	c.cod_etat	= cec.id_code
	 -- [PM266]
	  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
			Or
			Not Exists ( 
				Select 1
				From	sysadm.exclu_ass ex,
						sysadm.garantie ga,
						sysadm.police po,
						sysadm.reg_gti rg,
						sysadm.reglement r
				Where	r.id_sin = s.id_sin
				And		rg.id_sin = r.id_sin
				And     rg.id_reg = r.id_reg
				And		ga.id_prod = s.id_prod
				And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
												IsNull ( 
													( Select max (id_rev )
													  From   revision r
													  Where  r.id_prod = s.id_prod ) , 0 ))
				And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
												(
												  Select top 1 id_gti  
												  From   sysadm.garantie ga2
												  Where  ga2.id_prod = ga.id_prod
												  And    ga2.id_rev = ga.id_rev 
												)
											)
				And		po.id_police = ga.id_police
				and		ex.id_cie = po.id_cie			
			)
		  ) 

UNION ALL

/********************************************************
			CAS 3
Selection des sinistres dont la derniere commande n'est
pas un ( TEL,PRS) valide non annulee
			 ET
dont le dernier reglement RN est entre dans les dates
*********************************************************/

Select	@dtDteDeb							Dte_Debut_Stat,
	@dtDteFin							Dte_Fin_Stat,
	Upper ( LTrim ( RTrim ( s.num_port ) ) )			N_Appel,
	Upper ( LTrim ( RTrim ( s.id_contrat_abonne ) ) )		N_Contrat_abonn_SFR,
	s.dte_adh							Dte_Sous,
	Upper ( LTrim ( RTrim ( p.nom ) ) + ' ' + LTrim ( RTrim ( p.prenom ) ) ) Nom_Prenom_Ass,
	s.id_sin 							N_Dossier,
	Upper ( LTrim ( RTrim ( s.marq_port ) ) + ' ' + LTrim ( RTrim ( s.modl_port ) ) ) Marq_Modl_Sinistre,
	s.dte_decl							Dte_Decl,
	s.dte_surv							Dte_Surv,
	cns.lib_code 							Nat_Sin,
	ces.lib_code 						Etat_Sin,
	s.valide_le							Dte_Dern_Valid,
	-- [BUG20080728].COD_MODE_REG  JFF
	( Select Sum ( IsNull ( r1.mt_tot_reg, 0 ) )
	  From	 sysadm.reglement r1
	  Where  r1.id_sin = s.id_sin
	  and    r1.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) 
	  and    r1.cod_mot_reg not in ( 'RI' ) 	  
	)								Mnt_Reg,
	--	s.mt_reg							Mnt_Reg,
	-- [BUG20080728].COD_MODE_REG  JFF
	''								Typ_Art,
	''								Marq_Modl_Cmde,
	null								Dte_Prise_Cmde,
	null								Dte_Envoi,
	''								Etat_Cmde

  From 	sinistre s ,
	reglement r,
	personne p,
	code cns,
	code ces

 Where 	s.id_prod = @dcIdProd
   And 	Not Exists ( 
	Select *
	  From commande c
	 Where c.id_sin		= s.id_sin
	    and c.id_typ_art	in ( 'TEL', 'PRS' )
	   And cod_etat 	Not In ( 'ANN', 'RSP' ) 
	    and c.id_seq		= (Select max (c1.id_seq) 
				     From commande c1
				    Where c1.id_sin = c.id_sin )
		   )
   And	s.cod_etat 	In ( 550, 600 )
   And	r.id_sin 	= s.id_sin
   And	r.id_reg 	= (Select max (r1.id_reg) 
			     From reglement r1
			    Where r1.id_sin = r.id_sin
			      And r1.cod_mot_reg = 'RN' )

   And	r.dte_reg	Between @dtDteDeb And @dtDteFin
   And	s.id_ordre 	= p.id_ordre
   And	cns.id_typ_code = '+NS'
   And	s.id_natsin 	= cns.id_code
   And	ces.id_typ_code = '-ET'
   And	s.cod_etat 	= ces.id_code
	 -- [PM266]
	  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
			Or
			Not Exists ( 
				Select 1
				From	sysadm.exclu_ass ex,
						sysadm.garantie ga,
						sysadm.police po,
						sysadm.reg_gti rg
				Where	rg.id_sin = r.id_sin
				And     rg.id_reg = r.id_reg
				And		ga.id_prod = s.id_prod
				And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
												IsNull ( 
													( Select max (id_rev )
													  From   revision r
													  Where  r.id_prod = s.id_prod ) , 0 ))
				And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
												(
												  Select top 1 id_gti  
												  From   sysadm.garantie ga2
												  Where  ga2.id_prod = ga.id_prod
												  And    ga2.id_rev = ga.id_rev 
												)
											)
				And		po.id_police = ga.id_police
				and		ex.id_cie = po.id_cie			
			)
		  )

UNION ALL

/********************************************************
			CAS 4
Selection des sinistres dont la derniere commande n'est
pas un ( TEL, PRS ) valide non annulee
			 ET
n'ayant pas de reglement
*********************************************************/

Select	@dtDteDeb							Dte_Debut_Stat,
	@dtDteFin							Dte_Fin_Stat,
	Upper ( LTrim ( RTrim ( s.num_port ) ) )			N_Appel,
	Upper ( LTrim ( RTrim ( s.id_contrat_abonne ) ) )		N_Contrat_abonn_SFR,
	s.dte_adh							Dte_Sous,
	Upper ( LTrim ( RTrim ( p.nom ) ) + ' ' + LTrim ( RTrim ( p.prenom ) ) ) Nom_Prenom_Ass,
	s.id_sin 							N_Dossier,
	Upper ( LTrim ( RTrim ( s.marq_port ) ) + ' ' + LTrim ( RTrim ( s.modl_port ) ) ) Marq_Modl_Sinistre,
	s.dte_decl							Dte_Decl,
	s.dte_surv							Dte_Surv,
	cns.lib_code 							Nat_Sin,
	ces.lib_code 							Etat_Sin,
	s.valide_le							Dte_Dern_Valid,
	-- [BUG20080728].COD_MODE_REG  JFF
	( Select Sum ( IsNull ( r1.mt_tot_reg, 0 ) )
	  From	 sysadm.reglement r1
	  Where  r1.id_sin = s.id_sin
	  and    r1.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) 
	  and    r1.cod_mot_reg not in ( 'RI' ) 	  
	)								Mnt_Reg,
	--	s.mt_reg							Mnt_Reg,
	-- [BUG20080728].COD_MODE_REG  JFF
	''								Typ_Art,
	''								Marq_Modl_Cmde,
	null								Dte_Prise_Cmde,
	null								Dte_Envoi,
	''								Etat_Cmde

  From 	sinistre s,
	personne p,
	code cns,
	code ces

 Where 	s.id_prod = @dcIdProd
   And 	Not Exists ( 
	Select *
	  From commande c
	 Where c.id_sin		= s.id_sin
	    and c.id_typ_art	in ( 'TEL', 'PRS' )
	   And cod_etat		Not In ( 'ANN', 'RSP' ) 
	    and c.id_seq		= (Select max (c1.id_seq) 
				     From commande c1
				    Where c1.id_sin = c.id_sin )
		   )
   And	s.cod_etat		Not In ( 550, 600 )
   And	s.valide_le		Between @dtDteDeb And @dtDteFin
   And	s.id_ordre		= p.id_ordre
   And	cns.id_typ_code		= '+NS'
   And	s.id_natsin		= cns.id_code
   And	ces.id_typ_code		= '-ET'
   And	s.cod_etat		= ces.id_code
   	 -- [PM266]
	  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
			Or
			Not Exists ( 
				Select 1
				From	sysadm.exclu_ass ex,
						sysadm.garantie ga,
						sysadm.police po,
						sysadm.reg_gti rg,
						sysadm.reglement r
				Where	r.id_sin = s.id_sin
				And		rg.id_sin = r.id_sin
				And     rg.id_reg = r.id_reg
				And		ga.id_prod = s.id_prod
				And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
												IsNull ( 
													( Select max (id_rev )
													  From   revision r
													  Where  r.id_prod = s.id_prod ) , 0 ))
				And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
												(
												  Select top 1 id_gti  
												  From   sysadm.garantie ga2
												  Where  ga2.id_prod = ga.id_prod
												  And    ga2.id_rev = ga.id_rev 
												)
											)
				And		po.id_police = ga.id_police
				and		ex.id_cie = po.id_cie			
			)
		  ) 
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_DNT_STAT_COURRIER
-- Auteur               :       FABRY JF
-- Date                 :       12/02/2004
-- Libell‚              :       DEEI 3102
-- Commentaires         :       
-- R‚f‚rences           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- #1	31/01/2008	PHG	[DCMP080080] Evolution sur Etat Racapitualation Couuriers
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DNT_STAT_COURRIER' AND type = 'P' )
        DROP procedure sysadm.DW_S01_DNT_STAT_COURRIER
GO

CREATE procedure sysadm.DW_S01_DNT_STAT_COURRIER
        @dtDteDeb	DateTime,
        @dtDteFin	DateTime
AS

Select  @dtDteDeb Date_Deb,
	@dtDteFin Date_Fin,
	d1.lib_dept Dept,
	d2.lib_dept Sous_Dept,
	a.id_prod Produit,
	p.lib_long Lib_Produit,
	a.id_cour_orig Courrier_Orig, -- #1 [DCMP080080] Ajout.
	a.id_cour Courrier_Def, -- #1 [DCMP080080] Code_Courrier changé en Courrier_Def.
	cCC.lib_code Lib_Type_Courrier,
	a.maj_par Maj_Par,
	a.valide_par Valide_Par,
	count(*) Nombre

from   	sysadm.archive a, 
	sysadm.produit p,
	sysadm.departement d1,
	sysadm.departement d2,
	sysadm.code_car cCC
	
where   /*p.id_dept  = 280 -- #1 [DCMP080080] Suppression Critère
and*/	d1.id_dept = p.id_dept
and 	d2.id_dept = p.id_depts
and	p.id_prod  = a.id_prod
and 	valide_le between @dtDteDeb And @dtDteFin
and	cCC.id_typ_code = '-CC'
and 	cCC.id_code = a.id_cour

group by d1.lib_dept,
	d2.lib_dept,
	a.id_prod,
	p.lib_long,
	a.id_cour_orig, -- #1 [DCMP080080]
	a.id_cour,
	cCC.lib_code,
	a.maj_par,
	a.valide_par
Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_DFC_STAT_ECART_AXA_CARDIFF
-- Auteur               :       FABRY JF
-- Date                 :       11/05/2005
-- Libell‚              :       DEEI 3595
-- Commentaires         :       Stat créé sur mesure pour repérer les écart AXA/CARDIF pour le 201,202,203
-- R‚f‚rences           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--				
-- Retourne             :       Rien
--
-- JFF      06/10/2014   [PM266]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DFC_STAT_ECART_AXA_CARDIFF' AND type = 'P' )
        DROP procedure sysadm.DW_S01_DFC_STAT_ECART_AXA_CARDIFF
GO

CREATE procedure sysadm.DW_S01_DFC_STAT_ECART_AXA_CARDIFF
        @dtDteDeb	DateTime,
        @dtDteFin	DateTime
AS


select	@dtDteDeb,
	@dtDteFin,
	s.id_prod,
	p.lib_long,
	s.id_sin,
	s.id_rev,
	s.dte_surv,
	s.dte_adh,
	Case 
	   When Convert ( 
	   Datetime , Convert ( Varchar (10), SubString ( Convert ( VarChar ( 10 ) , s.dte_adh, 103  ), 1, 6 ) + '2005', 103 )
		  ) <= Getdate () Then 
	  Convert ( 
	   Datetime , Convert ( Varchar (10), SubString ( Convert ( VarChar ( 10 ) , s.dte_adh, 103  ), 1, 6 ) + '2005', 103 )
		  )
	   When Convert ( 
	   Datetime , Convert ( Varchar (10), SubString ( Convert ( VarChar ( 10 ) , s.dte_adh, 103  ), 1, 6 ) + '2005', 103 )
		  ) > GetDate () Then 
	  Convert ( 
	   Datetime , Convert ( Varchar (10), SubString ( Convert ( VarChar ( 10 ) , s.dte_adh, 103  ), 1, 6 ) + '2004', 103 )
		  )
	End Dernier_Renouvellement,
	s.cree_le DOSSIER_CREE_LE,
	po.lib_police,
	c.lib_cie,
	Case 
	  When s.dte_surv >= '01/01/2004'  and c.id_cie = 42 Then 'ERREUR ! Devrait être sur CARDIF selon nouvelle régle.'
	  When s.dte_surv < '01/01/2004'  and c.id_cie = 77 Then 'ERREUR ! Devrait être sur AXA selon nouvelle régle.'
	  Else 'Ok'
	End ,
	r.dte_reg,
	r.mt_tot_reg,
	s.id_ets,
	s.cod_opt

From	sysadm.sinistre s,
	sysadm.reglement r,
	sysadm.garantie g,
	sysadm.police po,
	sysadm.compagnie c,
	sysadm.produit p,
	sysadm.code cET

where   s.id_prod in ( 201, 202, 203 )
and  	r.id_sin  = s.id_sin
and  	r.dte_reg between @dtDteDeb And @dtDteFin
and  	p.id_prod = s.id_prod
and  	g.id_prod = s.id_prod
and  	g.id_rev  = s.id_rev 
and  	g.id_gti  = ( Select Min ( g2.id_gti )
     		      From   sysadm.gar_sin g2
   		      where g2.id_sin = s.id_sin ) 
and   	po.id_police = g.id_police
and  	c.id_cie = po.id_cie
and  	cET.id_typ_code = '-ET'
and  	cET.id_code = s.cod_etat
      -- [PM266]
      AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
		    Or
			Not Exists ( 
				Select 1
				From   sysadm.exclu_ass ex
				Where  ex.id_cie = po.id_cie
				)
		  ) 


Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S06_STOCK_FINAREF
-- Auteur               :       MADM
-- Date                 :       08/02/2006
-- Libell‚              :       
-- Commentaires         :       Stat créé pour le Stock Finaref
-- R‚f‚rences           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S06_STOCK_FINAREF' AND type = 'P' )
        DROP procedure sysadm.DW_S06_STOCK_FINAREF
GO

CREATE procedure sysadm.DW_S06_STOCK_FINAREF
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS


Select  @dtDteDeb,
        @dtDteFin,
        'AU MOINS 1 REMPL TEL SUR GTI BRIS (11) ASSUREUR FINAREF',
        p.lib_long,
        s.id_sin,
        s.id_prod,
        s.dte_surv, 
        s.dte_decl,
        s.dte_adh,
        pe.nom,
        pe.prenom,
        s.marq_port,
        s.modl_port

From    sysadm.sinistre s,
        sysadm.produit p,
        sysadm.personne pe,
        (
        Select  distinct c.id_sin
        From    sysadm.garantie g,
                sysadm.police p,
                sysadm.produit pr,
                sysadm.commande c,
                sysadm.sinistre s
        Where   p.id_cie = 68
        And     g.id_police = p.id_police 
        And     g.id_prod = s.id_prod
        And     g.id_rev = s.id_rev
        And     g.id_gti = 11
        And     c.id_sin = s.id_sin  
        And     c.id_gti = g.id_gti 
        And     c.id_typ_art = 'TEL'
        And     pr.id_prod = s.id_prod
        And     pr.id_dept = 280
        And     c.cree_le between @dtDteDeb and @dtDteFin

        ) as tb
Where tb.id_sin = s.id_sin
And p.id_prod = s.id_prod
And s.id_ordre = pe.id_ordre
Order by s.dte_decl

Go


--------------------------------------------------------------------
--
-- Procédure            :       DW_S06_REELLE_PRODUIT
-- Auteur               :       JCA
-- Date                 :       30/03/2006
-- Libellé              :        
-- Commentaires         :       Liste des produits pour Savvane et Simpa2
-- Références           :       
--
-- Arguments            :	@dtDteDeb, @dtDteFin       (ne sert pas dans la procedure, ajouter pour coherence fonctionnement traitement mensuel)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- DCMP 60283
-- #1 [DCMP080354]
-- JFF      12/05/2020   [PI085]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S06_REELLE_PRODUIT' AND type = 'P' )
       DROP procedure sysadm.DW_S06_REELLE_PRODUIT
GO

CREATE procedure sysadm.DW_S06_REELLE_PRODUIT
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

/*  JFF le 29/12/08 : SAVANE prend trop lignes dans le fichier (env 56000)
----	SAVANE
select	distinct 
	'SAVANE'					Application,
	sp.id_prod					Code_Produit,
	sp.id_dept					Code_Dept,  -- #1 [DCMP080354]
	sp.lib_long					Lib_Produit,
	sp.id_ets					Code_Contractant,
	se2.lib_ets					Lib_Contractant,
 	Substring ( Right ( '0000' + Convert ( Varchar (5), sp.id_prod), 5), 1 , 3 ) Code_Adhesion,
	sp.rib_bq					Rib_Code_Banque,
	sp.rib_gui					Rib_Code_Guichet,
	sp.rib_cpt					Rib_Num_Compte,
	sp.rib_cle					Rib_Cle,
	sg.id_gti					Code_Garantie,
	(select scd.lib_code from SAVANE_PRO.sysadm.code scd where scd.id_typ_code = '-GA' and scd.id_code = sg.id_gti) Lib_Garantie,
	spo.id_police 					Code_Police,
	spo.lib_police 					Lib_Police,
	sc.id_cie					Code_Compagnie,
	sc.lib_cie					Lib_Compagnie,
	sr.id_rev 					Code_Revision,
	sr.zn_eff_rev					Effet,
	sr.dte_eff_deb					Date_Debut_Effet,
	sr.dte_eff_fin					Date_Fin_Effet,
	sr.lib_rev					Lib_Avenant,
	se.id_ets					Code_Etablissement, 
	NULL						Code_Etablissements_Unisys_Couvert, 
	se.lib_ets					Lib_Groupe_Couvert 

from	SAVANE_PRO.sysadm.produit		sp,
	SAVANE_PRO.sysadm.revision	 	sr,
	SAVANE_PRO.sysadm.garantie 		sg,
	SAVANE_PRO.sysadm.police 		spo,
	SAVANE_PRO.sysadm.compagnie 		sc,
	SAVANE_PRO.sysadm.affilier		sa,
	SAVANE_PRO.sysadm.carte			sct,
	SAVANE_PRO.sysadm.etablissement 	se,
	SAVANE_PRO.sysadm.etablissement 	se2

where	sp.id_prod	=	sg.id_prod
and	sr.id_prod	=	sg.id_prod
and	sr.id_rev	=	sg.id_rev
and	sg.id_police	=	spo.id_police
and	spo.id_cie	=	sc.id_cie
and	sg.id_prod	=	sa.id_prod
and	sg.id_rev	=	sa.id_rev
and	sg.id_gti	=	sa.id_gti
and	sct.id_carte	=	sa.id_carte
and	se.id_ets	=	sct.id_ets
and 	se2.id_ets	= 	sp.id_ets 

union all
*/

----	SIMPA2
-- produit.cod_adh = 3
select	distinct   
	'SIMPA2'					Application,
	cast (s2p.id_prod as varchar)			Code_Produit,
	s2p.id_dept					Code_Dept,  -- #1 [DCMP080354]	
	s2p.lib_long					Lib_Produit,
	s2p.id_grp					Code_Contractant,
	s2gr.lib_grp					Lib_Contractant,
-- 	Substring ( Right ( '0000' + Convert ( Varchar (5), s2p.id_prod), 5), 1 , 3 ) Code_Adhesion, --  [PI085]
	s2p.cod_prod_dms,  --  [PI085]
	s2p.rib_bq					Rib_Code_Banque,
	s2p.rib_gui					Rib_Code_Guichet,
	s2p.rib_cpt					Rib_Num_Compte,
	s2p.rib_cle					Rib_Cle,
	cast(s2g.id_gti as varchar)			Code_Garantie,
	sysadm.FN_CODE_NUM(s2g.id_gti,'-GA')		Lib_Garantie,		
	cast(s2po.id_police as varchar)			Code_Police, 
	s2po.lib_police 				Lib_Police,
	cast(s2c.id_cie as varchar)			Code_Compagnie,
	s2c.lib_cie					Lib_Compagnie,
	cast(s2r.id_rev as varchar)			Code_Revision,
	s2r.cod_eff_rev					Effet,
	s2r.dte_eff					Date_Debut_Effet,
	s2r.dte_fin					Date_Fin_Effet,
	s2r.lib_rev					Lib_Avenant,
	cast(s2gr2.id_grp as varchar)			Code_Etablissement, 
	NULL						Code_Etablissements_Unisys_Couvert, 
	s2gr2.lib_grp					Lib_groupe_Couvert 

from	sysadm.produit		s2p,
	sysadm.garantie 		s2g,
	sysadm.affilier		s2a,
	sysadm.carte			s2ct,
	sysadm.police 		s2po,
	sysadm.compagnie 		s2c,
	sysadm.revision	 	s2r,
	sysadm.groupe		s2gr,
	sysadm.groupe		s2gr2

where	s2p.cod_adh	=	'3'
and	s2p.id_prod	=	s2g.id_prod
and	s2g.id_police	=	s2po.id_police
and	s2po.id_cie	=	s2c.id_cie
and	s2g.id_prod	=	s2a.id_prod
and	s2g.id_rev	=	s2a.id_rev
and	s2g.id_gti	=	s2a.id_gti
and	s2a.id_carte	=	s2ct.id_carte
and 	s2gr2.id_grp	= 	s2ct.id_grp 
and	s2r.id_prod	=	s2g.id_prod
and	s2r.id_rev	=	s2g.id_rev
and	s2p.id_grp	=	s2gr.id_grp

union

-- produit.cod_adh != 3
select	distinct  
	'SIMPA2'					Application,
	cast(s2p.id_prod as varchar)			Code_Produit,
	s2p.id_dept					Code_Dept,  -- #1 [DCMP080354]
	s2p.lib_long					Lib_Produit,
	s2p.id_grp					Code_Contractant,
	s2gr.lib_grp					Lib_Contractant,
	s2p.cod_prod_dms				Code_Adhesion,
	s2p.rib_bq					Rib_Code_Banque,
	s2p.rib_gui					Rib_Code_Guichet,
	s2p.rib_cpt					Rib_Num_Compte,
	s2p.rib_cle					Rib_Cle,
	cast(s2g.id_gti as varchar)			Code_Garantie,
	sysadm.FN_CODE_NUM(s2g.id_gti,'-GA')	Lib_Garantie,		
	cast(s2po.id_police as varchar)			Code_Police, 	
	s2po.lib_police 				Lib_Police,
	cast(s2c.id_cie as varchar)			Code_Compagnie,
	s2c.lib_cie					Lib_Compagnie,
	cast(s2r.id_rev as varchar)			Code_Revision,
	s2r.cod_eff_rev					Effet,
	s2r.dte_eff					Date_Debut_Effet,
	s2r.dte_fin					Date_Fin_Effet,
	s2r.lib_rev					Lib_Avenant,
	cast(s2e.id_grp as varchar)			Code_Etablissement, 
	cast(s2e.id_ets as varchar)			Code_Etablissements_Unisys_Couvert, 
	s2gr2.lib_grp					Lib_groupe_Couvert 

from	sysadm.produit		s2p,
	sysadm.garantie 		s2g,
	sysadm.police 		s2po,
	sysadm.compagnie 		s2c,
	sysadm.revision	 	s2r,
	sysadm.groupe		s2gr,
	sysadm.groupe		s2gr2, 
	sysadm.etablissement		s2e


where	s2p.cod_adh	!=	'3'
and	s2p.id_prod	=	s2g.id_prod
and	s2g.id_police	=	s2po.id_police
and	s2po.id_cie	=	s2c.id_cie
and	s2r.id_prod	=	s2g.id_prod
and	s2r.id_rev	=	s2g.id_rev
and	s2p.id_grp	=	s2gr.id_grp
and	s2e.id_prod  	= 	s2g.id_prod	
and 	s2e.id_rev	= 	s2g.id_rev
and 	s2e.id_grp	= 	s2gr2.id_grp  

Order by 1, 2, 17 


GO 

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S07_REELLE_DOSSIER_DNT_FORCES
-- Auteur               :       JCA
-- Date                 :       20/04/2006
-- Libellé              :       
-- Commentaires         :       Stat créé pour le Stock Finaref
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              
-- Retourne             :       Rien
-- [BUG20080728].COD_MODE_REG  JFF
-- JFF      06/10/2014   [PM266]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S07_REELLE_DOSSIER_DNT_FORCES' AND type = 'P' )
       DROP procedure sysadm.DW_S07_REELLE_DOSSIER_DNT_FORCES
GO

CREATE procedure sysadm.DW_S07_REELLE_DOSSIER_DNT_FORCES
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

select
	d.id_sin						Identifiant_Sinistre,
	s.id_prod						Code_Produit,
	p.lib_long						Lib_Produit,
	d.id_gti						Code_Garantie,
	sysadm.FN_CODE_NUM(g.id_gti,'-GA')			Lib_Garantie,
	gs.mt_plaf_reg						Rbt_Regle_Garantie,
	sysadm.FN_CODE_CAR(pf.id_typ_plaf,'-PL')		Lib_Type_Plafond,
	NULL 							Code_Evenement,
	NULL 							Lib_Evenement,
	d.mt_val_achat						Mt_Val_Achat_Origine,
	d.mt_val_publique					Mt_Val_Publique,
	d.maj_par						Detail_Maj_Par,
	d.mt_plaf						Montant_Regle_Detail,
	pf.mt_plaf						Mt_Plafond_Evenement,
	d.alt_reg						Reglement_Force,
	r.dte_reg						Date_Reglement,
	r.maj_par						Cree_Par,
	r.cree_le						Cree_Le,
	r.valide_par						Valide_Par,
	r.valide_le						Valide_Le

from	sinistre	s,
	detail		d,
	gar_sin		gs,
	produit		p,
	garantie	g,
	reglement 	r,
	plafond 	pf

where	d.alt_reg	=	'O'
and	r.id_sin	= 	d.id_sin
and	r.id_reg	=	d.id_reg
and	r.dte_reg 	between	@dtDteDeb and @dtDteFin
and	gs.id_sin	= 	d.id_sin
and	gs.id_gti	=	d.id_gti
and	s.id_sin	=	d.id_sin
and	p.id_prod	= 	s.id_prod
and 	g.id_prod	=	s.id_prod
and 	g.id_gti	= 	gs.id_gti
and 	g.id_rev	= 	s.id_rev
and	pf.id_prod	= 	g.id_prod
and	pf.id_gti	=	g.id_gti
and	pf.id_rev	=	g.id_rev
and 	pf.id_niv_plaf	=	'-GA'
and	p.id_dept	=	'280'
and
-- [BUG20080728].COD_MODE_REG  JFF
 ( r.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and 
 ( r.cod_mot_reg not in ( 'RI' ) )
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = r.id_sin
			And     rg.id_reg = r.id_reg
			And		ga.id_prod = s.id_prod
			And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = s.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 

union all

select
	d.id_sin						Identifiant_Sinistre,
	s.id_prod						Code_Produit,
	p.lib_long						Lib_Produit,
	d.id_gti						Code_Garantie,
	sysadm.FN_CODE_NUM(g.id_gti,'-GA')			Lib_Garantie,
	gs.mt_plaf_reg						Rbt_Regle_Garantie,
	sysadm.FN_CODE_CAR(pf.id_typ_plaf,'-PL')		Lib_Type_Plafond,
	d.id_evt						Code_Evenement,
	sysadm.FN_CODE_NUM(d.id_evt,'+EV')			Lib_Evenement,
	d.mt_val_achat						Mt_Val_Achat_Origine,
	d.mt_val_publique					Mt_Val_Publique,
	d.maj_par						Detail_Maj_Par,
	d.mt_plaf						Montant_Regle_Detail,
	pf.mt_plaf						Mt_Plafond_Evenement,
	d.alt_reg						Reglement_Force,
	r.dte_reg						Date_Reglement,
	r.maj_par						Cree_Par,
	r.cree_le						Cree_Le,
	r.valide_par						Valide_Par,
	r.valide_le						Valide_Le

from	sinistre	s,
	detail		d,
	gar_sin		gs,
	produit		p,
	garantie	g,
	reglement 	r,
	plafond 	pf

where	d.alt_reg	=	'O'
and	r.id_sin	= 	d.id_sin
and	r.id_reg 	=	d.id_reg
and	r.dte_reg 	between	@dtDteDeb and @dtDteFin
and	gs.id_sin	=	d.id_sin
and	gs.id_gti	=	d.id_gti
and	s.id_sin	=	d.id_sin
and	p.id_prod	=	s.id_prod
and	g.id_prod	=	s.id_prod
and 	g.id_rev	= 	s.id_rev
and 	g.id_gti	= 	gs.id_gti
and	pf.id_prod	=	g.id_prod
and	pf.id_gti	=	g.id_gti
and	pf.id_rev	=	g.id_rev
and	pf.id_niv_plaf	=	'+EV'
and 	pf.id_ref_plaf	=	d.id_evt 
and	p.id_dept	=	'280'
and
-- [BUG20080728].COD_MODE_REG  JFF
 ( r.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and 
 ( r.cod_mot_reg not in ( 'RI' ) )
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = r.id_sin
			And     rg.id_reg = r.id_reg
			And		ga.id_prod = s.id_prod
			And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = s.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 
GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S08_REGL_FOURN_COMPTA
-- Auteur               :       PHG
-- Date                 :       05/07/2006
-- Libellé              :       
-- Commentaires         :       Statistique Mensuelle : Liste des Reglement Fournisseurs pour la compta
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              
-- Retourne             :       Rien
--
-- JFF      06/10/2014   [PM266]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S08_REGL_FOURN_COMPTA' AND type = 'P' )
       DROP procedure sysadm.DW_S08_REGL_FOURN_COMPTA
GO

CREATE procedure sysadm.DW_S08_REGL_FOURN_COMPTA
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

select	s.id_prod, 
	sysadm.FN_LIB_PROD ( s.id_prod ) as Produit,	
	s.id_ets, 
	s.id_adh, 
	s.id_sdos, 
	s.id_sin,
	r.id_reg,
	r.cod_mode_reg,  
	r.cod_mot_reg,
	r.lib_reg,
	r.dte_reg,
	i.id_four, 
	sysadm.FN_CODE_CAR(i.id_four, '-FR' ) as Fournisseur,
	r.mt_tot_reg
from	sinistre s,
	reglement r,
	inter i
where	s.id_sin 	= r.id_sin
and 	r.id_sin	= i.id_sin
and	r.id_i		= i.id_i	
and	i.cod_inter 	= 'F'
-- [BUG20080728].COD_MODE_REG  JFF
--and	r.cod_mot_reg 	<> 'RI'
-- [BUG20080728].COD_MODE_REG  JFF
and	r.dte_reg 	between @dtDteDeb and @dtDteFin
and
-- [BUG20080728].COD_MODE_REG  JFF
 ( r.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and 
 ( r.cod_mot_reg not in ( 'RI' ) )
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = r.id_sin
			And     rg.id_reg = r.id_reg
			And		ga.id_prod = s.id_prod
			And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = s.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 


GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S09_PEC_MEDIA_SATURN
-- Auteur               :       JFF
-- Date                 :       24/09/2007
-- Libellé              :       
-- Commentaires         :       Statistique Mensuelle : Stat des PEC pour média saturn
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--				@dcIdProd	Decimal ( 7,0 )
--                              
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S09_PEC_MEDIA_SATURN' AND type = 'P' )
       DROP procedure sysadm.DW_S09_PEC_MEDIA_SATURN
GO

CREATE procedure sysadm.DW_S09_PEC_MEDIA_SATURN
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime,
        @dcIdProd	Decimal ( 7,0 )
AS

select  s.id_sin 'dossier',
	s.id_prod 'code_produit',
	sysadm.FN_LIB_PROD ( s.id_prod ) 'Lib_produit',
	( Select top 1 adr_nom from boutique b where b.id_prod = s.id_prod and b.id_boutique = s.id_orian_boutique ) 'boutique',
	( Select nom from personne p where p.id_ordre = s.id_ordre ) 'nom assuré',
	( Select prenom from personne p where p.id_ordre = s.id_ordre ) 'prénom assuré',
	sysadm.FN_CODE_NUM ( s.id_natsin , '+NS' ) 'Nature_de_sinistre',
	s.valide_le 'Dossier_valide le',
	sysadm.FN_CODE_NUM ( g.id_gti , '-GA' ) 'Garantie',	
	g.valide_le 'Garantie_valide_le',
	sysadm.FN_CODE_NUM ( d.id_evt , '+EV' ) 'événement',
	d.mt_val_achat,
	'DETAIL PRIS EN CHARGE' 'état détail', 
	( Select IsNull ( dd.val_mt, 0 )
	  From div_det dd
	  Where dd.id_sin = d.id_sin
	  And   dd.id_gti = d.id_gti
	  And   dd.id_detail = d.id_detail
	  And   dd.nom_zone = 'mt_pec'
	 ) 'Montant de PEC',
	dd1.maj_le 'Dte PEC',
	Case
		When ( Select count ( * )
			From div_det dd
			 Where dd.id_sin = d.id_sin
			 And   dd.id_gti = d.id_gti
			 And   dd.id_detail = d.id_detail
			 And   dd.nom_zone = 'alt_pec'
			 And   dd.val_car = 'O' ) > 0  Then 'PEC FORCEE!'
		Else ''

	End 'Forçage de PEC'
	
from   	sinistre s,
	detail d,
	div_det dd1,
	gar_sin g,
	produit p 
Where   s.id_prod = p.id_prod
and     s.id_prod = @dcIdProd
and     g.id_sin = s.id_sin
and 	s.cod_etat = 100
And     d.cod_etat = 100
and     d.id_sin = s.id_sin
And     dd1.id_sin = d.id_sin
and 	dd1.id_gti = d.id_gti
and 	dd1.id_detail = d.id_detail
and     dd1.maj_le between @dtDteDeb and @dtDteFin
and     dd1.nom_zone = 'pec'
and	dd1.val_car = 'O'

Order by s.id_prod, s.id_sin, g.id_gti


GO

--------------------------------------------------------------------
--
-- Procédure	: PS_S01_EXTRACTION_UF
-- Auteur	: PHG
-- Date		: 18/07/2006
-- Libellé	:
-- Commentaires	: Extraction Hebdomadaire des Utilisation Frauduleuse de Carte.
--		  Utilisée par PS_S02_EXTRACTION_UF 
-- Références	: [DCMP060417]
--
-- Arguments	: @dtDeb	datetime,
--		  @dtFin	datetime
-- Retourne	: Rien
--
-- [DCMP060651]	PHG	31/08/2006 
--	Modificiation des critères
--	- On prends en compte le maj_le du détail au lieu du cree_le
--	- La selection des produits pour lesquels on fait le sinistre est pramétrée
--	par une sélection sur l'option 65 de det_pro
--	Ajout d'un update : 
-- 	- On remet à N la case à cocher 'Utilisation Frauduleuse', 
--	car les dossier vont etre traité suite à l'extraction réalisée.
-- JFF le 23/10/2006, pour l'update sur w_div_det, je m'appuie sur les tables permanentes !!
-- PHG le 30/10/2006, Ajout de 4 colonnes maj_le, maj_par, pour savoir qui a fait quand
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_EXTRACTION_UF' AND type = 'P' )
       DROP procedure sysadm.PS_S01_EXTRACTION_UF
GO

CREATE procedure sysadm.PS_S01_EXTRACTION_UF
	@adtDeb	datetime,
	@adtFin	datetime
AS

SET NOCOUNT ON

select 	d.maj_par			as 'TRIGRAMME GT (SPB)', 
	s.id_sin			as 'N° DOSSIER', 
	it.nom				as 'PRENOM NOM', 
	substring(it.rib_cpt, 2, 9)	as 'N° COMPTE', 
	s.dte_surv			as 'DATE SINISTRE', 
	d.num_carte			as 'N° CARTE',
	d.maj_le			as 'DETAIL MAJ LE',
	d.maj_par			as 'DETAIL MAJ PAR',
	ddet.maj_le			as 'MARQUEUR MAJ LE',
	ddet.maj_par			as 'MARQUEUR MAJ PAR'
from 	sinistre s, 
	detail d, 
	inter it,
	(select dp.id_prod from det_pro dp
	 where	dp.id_code_dp = 65) dp65,
	div_det ddet
where	s.id_prod	= dp65.id_prod
and 	s.id_sin 	= d.id_sin
and	d.id_gti 	= 7
and 	d.maj_le 	between @adtDeb and @adtFin
and	d.id_sin	= it.id_sin
and 	it.cod_inter 	= 'A'
and 	ddet.id_sin = d.id_sin
and 	ddet.id_gti = d.id_gti
and 	ddet.id_detail = d.id_detail
and 	ddet.nom_zone = 'alt_fraude' 
and 	ddet.val_car = 'O'

update 	div_det
set 	val_car = 'N', maj_par = 'SQLS', maj_le = GetDate()
from 	sinistre s, 
	detail d, 
	inter it,
	(select dp.id_prod from det_pro dp
	where	dp.id_code_dp = 65) dp65
where	s.id_prod	= dp65.id_prod
and 	s.id_sin 	= d.id_sin
and	d.id_gti 	= 7
and 	d.maj_le 	between @adtDeb and @adtFin
and	d.id_sin	= it.id_sin
and 	it.cod_inter 	= 'A'
and 	div_det.id_sin	= d.id_sin
and 	div_det.id_gti	= d.id_gti
and 	div_det.id_detail = d.id_detail
and 	div_det.nom_zone = 'alt_fraude' 
and	div_det.val_car = 'O'

update 	w_div_det
set 	val_car = 'N', maj_par = 'SQLS', maj_le = GetDate()
from 	sinistre ws, 
	(select dp.id_prod from det_pro dp
	where	dp.id_code_dp = 65) dp65
where	ws.id_prod	= dp65.id_prod
and 	w_div_det.id_sin = ws.id_sin
and 	w_div_det.nom_zone = 'alt_fraude' 
and	w_div_det.val_car = 'O'


Go
--------------------------------------------------------------------
--
-- Procédure            :	PS_S02_EXTRACTION_UF
-- Auteur               :	PHG
-- Date                 :       	18/07/2006
-- Libellé              :       
-- Commentaires         :	Extraction Hebdomadaire des Utilisation Frauduleuse de Carte.
--		Envoie un mail avec le resultat de la requete PS_S01_EXTRACTION_UF
-- Références           :       [DCMP060417]
--
-- Arguments            :      Rien
--                              
-- Retourne             :       Rien
--
--		JCA changement repertoire cible (norme UNC)
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_EXTRACTION_UF' AND type = 'P' )
       DROP procedure sysadm.PS_S02_EXTRACTION_UF
GO

CREATE procedure sysadm.PS_S02_EXTRACTION_UF
AS

declare 
	@sDestinataire       Varchar(255),
	@sCCi       Varchar(255),
	@dtDj	datetime,
	@dtDeb	datetime,
	@dtFin	datetime,
        @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int,
	@sRetourErrMail         VarChar(255)

Begin

	-- Definition des champs MailTo et Cci de l'eventuel mail à envoyer.
	-- DCMU 106221 - ajout de LPO
	--Set @sDestinataire = 'ofortin@spb.eu,VGUYOMARD@spb.eu, cbellet@spb.eu, msenard@spb.eu, nbechiri@spb.eu, cheuze@spb.eu'
	Set @sDestinataire = 'ExtractUFCARTES@spb.eu'  -- [ITSM209507] - utilisation d'un grp
	
	-- Pour debbugage et verif eventuelle, Mise en copie pour ES
	-- Set @sCCi = 'jff@spb.fr, phg@spb.fr'
	Set @sCCi = '' --'jff@spb.fr, phg@spb.fr'
	-- Script Lancé Obligatoirement le Vendredi à 0h15.
	-- En conséquence :
	-- On prends la date du jour amputée de l'heure  : ex @ dtDj = 10/07/2006 00:00:00.000
	-- Ci-dessous, code de production
	--Set @dtDj = cast ( convert ( varchar(10), GetDate(),103 ) as datetime )
	Set @dtDj = convert ( datetime, convert ( varchar(10), GetDate(),103 ), 103 ) -- [I027] Correction sysadm + date ISO

	-- On enlève une semaine à la date du jour calculée. C'est la date de debut
	-- ex : @dtDeb = 02/07/2006 00:00:00.000
	Set @dtDeb = DateAdd ( week, -1, @dtDj ) 

	-- On enlève 1 seconde à la date du jour pour basculer dans le jours précédent, c'est la date de fin
	-- Ex : @dtFin = 09/07/2006 23:59:59.000
	--Set @dtFin = DateAdd ( second, -1, @dtDj )  -- [I027] Correction sysadm + date ISO, cette ligne devient inutile
						    -- car J-1seconde est quasi equivalent à J 00:00:00 dans ce contexte.
	Set @dtFin = @dtDj

	-- chemin d'enregistrement du Result Set
	Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_DCMP060417_UF\Data\'
	Set @sFileName	= 'DCMP060417_UF'
	Set @sFileExt	= 'xls'

	SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

	SET @sNomServeur = @@servername
	-- Options additionelles pour osql
	-- /s"	" 	=> Separateur Tabulation
	-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
	-- /u	=> Unicode
	Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'
	IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	-- [I027] Correction sysadm + date ISO	(112 au lieu de 113)
	   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
				"SIMPA2_PRO.sysadm.PS_S01_EXTRACTION_UF '" +
				convert(varchar(25), @dtDeb, 112) + "','" +
				convert(varchar(25), @dtFin, 112) + "'" +
		                '" /o' + @sFicOut + ' -w5000' + @sOsqlOption
	Else
	-- [I027] Correction sysadm + date ISO	(112 au lieu de 113)
	   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
	                    	"SIMPA2_TRT.sysadm.PS_S01_EXTRACTION_UF '" +
				convert(varchar(25), @dtDeb, 112) + "','" +
				convert(varchar(25), @dtFin, 112) + "'" +
		                '" /o' + @sFicOut + ' -w5000' + @sOsqlOption
	EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

	Set @sObjet    = "Extraction des UF marquées du " + convert(varchar(25), @dtDeb, 113) + " au " + convert(varchar(25), @dtFin, 113)
	set @sMessage  = "Veuillez trouver ci-joint le fichier des UF marquées entre " + convert(varchar(25), @dtDeb, 113) + " et le " + convert(varchar(25), @dtFin, 113) + '.' + Char(13)+ Char(10) +
         "Veuillez détacher sur votre disque le fichier pour pouvoir l'ouvrir."+ Char(13)+ Char(10)

	if @iRetOsql <> 0
	BEGIN
		set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DEI-ES.'
	END

	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			@sDestinataire, 
			@sMessage, 
			@sObjet, 
			'', 
			@sCCi, 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL
End

GO

grant execute on sysadm.PS_S02_EXTRACTION_UF to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S10_ETAT_FINAREF
-- Auteur               :       JFF
-- Date                 :       07/11/2007
-- Libellé              :       SPBCLAIM
-- Commentaires         :       Statistique Mensuelle particulière pour FINAREF
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              
-- Retourne             :       Rien
-- #1   PHG     23/04/2008 : [DCMP080333] Modif Année Sous -> Dte Sous
-- [BUG20080728].COD_MODE_REG  JFF
-- [DCMP_090384] 30/08/2009 Ajout colonne Marque/Modele/Libellé Appareil DGA
-- [DCMP_090382] 30/08/2009 Ajout colonne Tranche Tarifaire DGA
-- [DCMP_090385] 30/08/2009 Ajout colonne Etat dossier calculé DGA
-- JFF      08/07/2013   [PC509-2]
-- JFF      09/03/2015   [VDOC17042]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S10_ETAT_FINAREF' AND type = 'P' )
       DROP procedure sysadm.DW_S10_ETAT_FINAREF
GO

CREATE procedure sysadm.DW_S10_ETAT_FINAREF
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

Select  p.nom 'Nom',
        p.prenom 'Prénom',
        s.id_sin 'Référence_sinistre',
        sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' ) 'Etat_dossier',
        po.lib_police 'Numéro_de_contrat',
        ( Select d.val_car
          From   sysadm.det_pro d
          Where  d.id_prod = s.id_prod
          And    d.id_code_dp = 66 ) 'Lib_produit_assuré',
        ( Select d.val_car
          From   sysadm.det_pro d
          Where  d.id_prod = s.id_prod
          And    d.id_code_dp = 67 ) 'Lib_Option_assuré',
        pr.lib_long 'Lib_produit_Interne_SPB',
        --Year ( s.dte_adh ) 'Année_de_souscription', -- #1
        --convert(varchar(10), s.dte_adh, 112) 'Date de Souscription', -- #1 Mis au cas ou le format serait YYYYMMDD
        s.dte_adh 'Date de Souscription', -- #1
        s.dte_surv 'Date_de_survenance',
        s.dte_decl 'Date_de_déclaration',
        s.cree_le 'Date_ouverture_du_dossier',
        r.dte_reg 'Date_décision',
        sysadm.FN_GET_PERIODE_TRT(r.dte_reg) 'Période_de_règlement',
        ( Select Case ds.val_car
                        When 'TEL' Then 'Téléphone mobile'
                        When 'AUT' Then 'Produit nomade'
                        Else ds.val_car
                 End 
          From   sysadm.div_sin ds
          Where  ds.id_sin = s.id_sin
          And    ds.nom_zone = 'type_app' ) 'Type_de_bien_sinistré',
        sysadm.FN_CODE_NUM ( s.id_natsin , '+NS' ) 'Fait_générateur',
        Case 
                When rg.id_gti < 0 Then sysadm.FN_CODE_NUM ( rg.id_gti, '-FR' )
                When rg.id_gti > 0 Then sysadm.FN_CODE_NUM ( rg.id_gti, '-GA' )
                Else Convert ( VarChar ( 3 ), rg.id_gti ) 
        End  'Garantie_réglée',
        Case r.cod_mot_reg
                When 'RN' Then 'Règlement normal'
                When 'RM' Then 'Règularisation Moins Compagnie'
                When 'RP' Then 'Règularisation Plus Compagnie'
                Else r.cod_mot_reg
        End 'Motif_du_règlement',
        rg.mt_reg 'Montant_du_règlement',
-- [DCMP_090384]        
        s.marq_port AS 'Marque_Sinisté',
        s.modl_port AS 'Modèle_Sinisté',
        ( SELECT        CASE dv.val_car
                                WHEN 'AUT' Then 'Produit nomade'
                                ELSE sysadm.FN_CODE_CAR ( val_car, id_typ_liste ) 
                        END
          FROM          sysadm.div_sin dv
          WHERE         dv.id_sin = s.id_sin
          AND           dv.nom_zone = 'type_app'
        ) AS 'Libellé_Appareil',
-- [DCMP_090382]
        ( SELECT        sysadm.FN_CLE_VAL('T_TARIF', d.val_car, ';')
          FROM          sysadm.det_pro d
          WHERE         d.id_prod = s.id_prod  AND
                        d.id_code_dp = 94      AND
                        sysadm.FN_CLE_VAL('T_TARIF', d.val_car, ';') <> ''
        ) AS 'Tranche_Tarifaire',
-- [DCMP_090385]
        (
          SELECT  CASE
                  WHEN 
                        ( SELECT        COUNT (*)
                          FROM          sysadm.detail           d,
                                        sysadm.commande         c
                          WHERE         d.id_sin = s.id_sin     AND
                                        d.id_sin = c.id_sin     AND
                                        d.id_gti = c.id_gti     AND
                                        c.id_four = 'FNC'       AND
                                        d.cod_etat = 100        AND
                                        NOT EXISTS (    SELECT       *
                                                        FROM    sysadm.detail   d1,
                                                                sysadm.commande c1
                                                        WHERE   d1.id_sin = s.id_sin    AND
                                                                c1.id_sin = d1.id_sin   AND
                                                                c1.id_gti = d1.id_gti   AND
                                                                c1.id_four = 'FNC'      AND
                                                                d1.id_reg > 0
                                                    )
                        ) > 0 Then 1
        
                        Else 0
                End 
        ) AS 'En_attente_Facture'

From    sysadm.personne p,
        sysadm.sinistre s,
        sysadm.garantie g,
        sysadm.police   po,
        sysadm.reglement r,
        sysadm.reg_gti rg,
        sysadm.produit pr

inner join sysadm.det_pro dp
        on dp.id_prod = pr.id_prod
        and dp.id_code_dp = 94
        and sysadm.FN_CLE_VAL('COD_DW', dp.val_car, ';') = 'd_l_finaref'

Where   r.dte_reg between @dtDteDeb and @dtDteFin

And     r.cod_mot_reg not in ( 'RI' )
And     rg.id_sin = r.id_sin
And     rg.id_reg = r.id_reg 
And     r.id_sin = s.id_sin
And     g.id_prod = s.id_prod
/* -- vDoc17042
And     g.id_rev  = s.id_rev
And     g.id_gti  = rg.id_gti
*/
-- vDoc17042
And     g.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
								IsNull ( 
									( Select max (id_rev )
									  From   revision r
									  Where  r.id_prod = s.id_prod ) , 0 ))
And		g.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
								(
								  Select top 1 id_gti  
								  From   sysadm.garantie ga2
								  Where  ga2.id_prod = g.id_prod
								  And    ga2.id_rev = g.id_rev 
								)
							)
-- vDoc17042							
And     po.id_police = g.id_police
and     pr.id_prod = s.id_prod
And     p.id_ordre = s.id_ordre
and
-- [BUG20080728].COD_MODE_REG  JFF
 ( r.cod_mode_reg in ('VA' , 'VM' , 'C', 'FM', 'BX', 'VV' ) ) and 
 ( r.cod_mot_reg not in ( 'RI' ) )
-- :[BUG20080728].COD_MODE_REG  JFF

Union all

Select  p.nom 'Nom',
        p.prenom 'Prénom',
        s.id_sin 'Référence_sinistre',
        Case -- [PC509-2]
			When s.cod_etat = 900 and s.cod_mot_ssui = 11 Then 'Prescrit'
			Else sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' ) 
		End 'Etat_dossier',
        po.lib_police 'Numéro_de_contrat',
        ( Select d.val_car
          From   sysadm.det_pro d
          Where  d.id_prod = s.id_prod
          And    d.id_code_dp = 66 ) 'Lib_produit_assuré',
        ( Select d.val_car
          From   sysadm.det_pro d
          Where  d.id_prod = s.id_prod
          And    d.id_code_dp = 67 ) 'Lib_Option_assuré',
        pr.lib_long 'Lib_produit_Interne_SPB',
        --Year ( s.dte_adh ) 'Année_de_souscription', -- #1
        --convert(varchar(10), s.dte_adh, 112) 'Date de Souscription', -- #1 Mis au cas ou le format serait YYYYMMDD
        s.dte_adh 'Date de Souscription', -- #1
        s.dte_surv 'Date_de_survenance',
        s.dte_decl 'Date_de_déclaration',
        s.cree_le 'Date_ouverture_du_dossier',
        s.valide_le,
        'Aucune' 'Période_de_règlement',
        ( Select Case ds.val_car
                        When 'TEL' Then 'Téléphone mobile'
                        When 'AUT' Then 'Produit nomade'
                        Else ds.val_car
                 End 
          From   sysadm.div_sin ds
          Where  ds.id_sin = s.id_sin
          And    ds.nom_zone = 'type_app' ) 'Type de bien sinistré',
        sysadm.FN_CODE_NUM ( s.id_natsin , '+NS' ) 'Fait_générateur',
        'Aucune''Garantie_réglée',
        'Aucun' 'Motif_du_règlement',
        0 'Montant_du_règlement',
-- [DCMP_090384]        
        s.marq_port AS 'Marque_Sinisté',
        s.modl_port AS 'Modèle_Sinisté',
        ( SELECT        CASE dv.val_car
                                WHEN 'AUT' Then 'Produit nomade'
                                ELSE sysadm.FN_CODE_CAR ( val_car, id_typ_liste ) 
                        END
          FROM          sysadm.div_sin dv
          WHERE         dv.id_sin = s.id_sin
          AND           dv.nom_zone = 'type_app'
        ) AS 'Libellé_Appareil',
-- [DCMP_090382]
        ( SELECT        sysadm.FN_CLE_VAL('T_TARIF', d.val_car, ';')
          FROM          sysadm.det_pro d
          WHERE         d.id_prod = s.id_prod  AND
                        d.id_code_dp = 94      AND
                        sysadm.FN_CLE_VAL('T_TARIF', d.val_car, ';') <> ''
        ) AS 'Tranche_Tarifaire',
-- [DCMP_090385]
        (
          SELECT  CASE
                  WHEN 
                        ( SELECT        COUNT (*)
                          FROM          sysadm.detail           d,
                                        sysadm.commande         c
                          WHERE         d.id_sin = s.id_sin     AND
                                        d.id_sin = c.id_sin     AND
                                        d.id_gti = c.id_gti     AND
                                        c.id_four = 'FNC'       AND
                                        d.cod_etat = 100        AND
                                        NOT EXISTS (    SELECT       *
                                                        FROM    sysadm.detail   d1,
                                                                sysadm.commande c1
                                                        WHERE   d1.id_sin = s.id_sin    AND
                                                                c1.id_sin = d1.id_sin   AND
                                                                c1.id_gti = d1.id_gti   AND
                                                                c1.id_four = 'FNC'      AND
                                                                d1.id_reg > 0
                                                    )
                        ) > 0 Then 1
        
                        Else 0
                End 
        ) AS 'En_attente_Facture'

From    sysadm.personne p,
        sysadm.sinistre s,
        sysadm.garantie g,
        sysadm.police   po,
        sysadm.gar_sin rg,
        sysadm.produit pr

inner join sysadm.det_pro dp
        on dp.id_prod = pr.id_prod
        and dp.id_code_dp = 94
        and sysadm.FN_CLE_VAL('COD_DW', dp.val_car, ';') = 'd_l_finaref'

Where   s.valide_le between @dtDteDeb and @dtDteFin

And     rg.id_sin = s.id_sin
And     g.id_prod = s.id_prod
And     g.id_rev  = s.id_rev
And     g.id_gti  = rg.id_gti
And     po.id_police = g.id_police
and     pr.id_prod = s.id_prod
And     p.id_ordre = s.id_ordre
And     Not exists ( Select * from reglement r where r.id_sin = s.id_sin )

Go

grant execute on sysadm.DW_S10_ETAT_FINAREF to rolebddsinistres
Go



--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S11_ETAT_REGL_FRN_PAR_BOUTIQUE
-- Auteur               :       JFF
-- Date                 :       08/11/2007
-- Libellé              :       
-- Commentaires         :       Reglement par fournisseur et par boutique
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--				@dcIdProd	Decimal ( 7,0 )
--                              
-- Retourne             :       Rien
-- [BUG20080728].COD_MODE_REG  JFF
-- JFF      06/10/2014   [PM266]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S11_ETAT_REGL_FRN_PAR_BOUTIQUE' AND type = 'P' )
       DROP procedure sysadm.DW_S11_ETAT_REGL_FRN_PAR_BOUTIQUE
GO

CREATE procedure sysadm.DW_S11_ETAT_REGL_FRN_PAR_BOUTIQUE
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime,
        @dcIdProd	Decimal ( 7,0 )
AS

Select 	@dtDteDeb du,
	@dtDteFin au,
	b.id_boutique code_boutique, 
       	b.adr_ville  ville_boutique,
	sum ( mt_tot_reg ) Mt_regle

From 	sysadm.sinistre s, 
	sysadm.reglement r,
	sysadm.boutique b


Where 	s.id_prod = @dcIdProd
And 	r.id_sin = s.id_sin
And     r.dte_reg between @dtDteDeb and @dtDteFin
And     r.cod_mode_reg = 'FM'
And     b.id_boutique = s.id_orian_boutique
and
-- [BUG20080728].COD_MODE_REG  JFF
 ( r.cod_mot_reg not in ( 'RI' ) )
-- :[BUG20080728].COD_MODE_REG  JFF
  -- [PM266]
  AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
	    Or
		Not Exists ( 
			Select 1
			From	sysadm.exclu_ass ex,
					sysadm.garantie ga,
					sysadm.police po,
					sysadm.reg_gti rg
			Where	rg.id_sin = r.id_sin
			And     rg.id_reg = r.id_reg
			And		ga.id_prod = s.id_prod
			And     ga.id_rev = IsNull ( nullif ( s.id_rev, -1 ),
											IsNull ( 
												( Select max (id_rev )
												  From   revision r
												  Where  r.id_prod = s.id_prod ) , 0 ))
			And		ga.id_gti = IsNull ( nullif ( rg.id_gti, -1 ),
											(
											  Select top 1 id_gti  
											  From   sysadm.garantie ga2
											  Where  ga2.id_prod = ga.id_prod
											  And    ga2.id_rev = ga.id_rev 
											)
										)
			And		po.id_police = ga.id_police
			and		ex.id_cie = po.id_cie			
		)
	  ) 


Group By 
	b.id_boutique, 
       	b.adr_ville

Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S12_ETAT_REGL_FRN_PAR_SINISTRE
-- Auteur               :       JCA
-- Date                 :       15/11/2007
-- Libellé              :       
-- Commentaires         :       Reglement par fournisseur et par sinistre
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--				@dcIdProd	Decimal ( 7,0 )
--                              
-- Retourne             :       Rien
-- #1	JFF	07/02/2008	Ajout car jointure manquante.
-- [BUG20080728].COD_MODE_REG  JFF
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S12_ETAT_REGL_FRN_PAR_SINISTRE' AND type = 'P' )
       DROP procedure sysadm.DW_S12_ETAT_REGL_FRN_PAR_SINISTRE
GO

CREATE procedure sysadm.DW_S12_ETAT_REGL_FRN_PAR_SINISTRE
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime,
        @dcIdProd	Decimal ( 7,0 )
AS

Select 	@dtDteDeb du,
	@dtDteFin au,
	r.id_sin Sinistre,
	b.id_boutique code_boutique, 
       	b.adr_ville  ville_boutique,
	sum ( r.mt_tot_reg ) Mt_regle

From 	sysadm.sinistre s, 
	sysadm.reglement r,
	sysadm.boutique b


Where 	s.id_prod = @dcIdProd
And 	r.id_sin = s.id_sin
And     r.dte_reg between @dtDteDeb and @dtDteFin
And     r.cod_mode_reg = 'FM'
And     b.id_boutique = s.id_orian_boutique
and 	b.id_prod = s.id_prod -- #1 
and
-- [BUG20080728].COD_MODE_REG  JFF
 ( r.cod_mot_reg not in ( 'RI' ) )
-- :[BUG20080728].COD_MODE_REG  JFF


group by b.id_boutique, 
	 b.adr_ville,
	 r.id_sin

Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S11_SCORE_GAME
-- Auteur               :       JCA
-- Date                 :       10/12/2007
-- Libellé              :       
-- Commentaires         :       Statistique Mensuelle particulière pour Score Game
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              
-- Retourne             :       Rien
--     JFF   02/02/2011   [VDOC2985]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S11_SCORE_GAME' AND type = 'P' )
       DROP procedure sysadm.DW_S11_SCORE_GAME
GO

CREATE procedure sysadm.DW_S11_SCORE_GAME
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

SELECT  s.id_sin 'Dossier',
	s.id_prod 'Code_produit',
	sysadm.FN_LIB_PROD ( s.id_prod ) 'Lib_produit',
	sysadm.FN_CODE_NUM ( s.cod_etat , '-ET' ) 'Etat_dossier',
	sysadm.FN_CODE_NUM ( s.id_natsin , '+NS' ) 'Nature_de_sinistre',
	s.marq_port 'Marque_sinistre',
	s.modl_port 'Modele_sinistre',
	dd.cree_le 'Prise_en_charge_le',
	sysadm.FN_CODE_NUM ( g.id_gti , '-GA' ) 'Garantie',	
	d.mt_val_achat 'Valeur_d_achat',
	'PRIS EN CHARGE' 'Etat_détail', 
	s.id_orian_boutique 'Code_boutique',
	( Select b.adr_ville from boutique b where b.id_prod = s.id_prod and b.id_boutique = s.id_orian_boutique ) 'Ville_boutique',
	( Select b.adr_cp from boutique b where b.id_prod = s.id_prod and b.id_boutique = s.id_orian_boutique ) 'CP_boutique',
	( select min ( a.dte_edit ) from archive a where a.id_sin = s.id_sin and id_cour_orig like 'WDE%' ) 'Date_courrier_pec'

FROM   	sysadm.sinistre s,
	sysadm.detail d,
	sysadm.div_det dd,
	sysadm.gar_sin g,
	sysadm.produit p

INNER JOIN sysadm.det_pro dp
	ON dp.id_prod = p.id_prod
	AND dp.id_code_dp = 94
	AND sysadm.FN_CLE_VAL('COD_DW', dp.val_car, ';') = 'd_l_pec_score_game'

WHERE   p.id_dept = 280
AND 	s.id_prod = p.id_prod
AND     g.id_sin = s.id_sin
AND	g.id_gti in (15, 11)
AND 	s.cod_etat In ( 100, 550, 600 )
AND     d.id_sin = s.id_sin
AND     d.cod_etat In ( 100, 550, 600 )
AND     dd.id_sin = d.id_sin
AND     dd.id_gti = d.id_gti
AND     dd.id_detail = d.id_detail
AND     dd.nom_zone = 'pec'
AND     dd.val_car = 'O' 
AND     dd.cree_le BETWEEN @dtDteDeb AND @dtDteFin
--[VDOC2985]
/* en attente réponse PGM, NC, ML
AND	( 	
		Not Exists ( 
		Select 	*
		From	sysadm.commande c
		Where	c.id_sin = s.id_sin
		And	c.id_four = 'O2M'
		And	c.info_spb_frn between 1500 and 1599
		And     s.cree_le <= '06/12/2011 23:59'
		)
	Or 
		Exists 
		( 
		Select 	*
		From	sysadm.commande c
		Where	c.id_sin = s.id_sin
		And	c.id_four = 'O2M'
		And	c.info_spb_frn between 1500 and 1599
		And     c.status_gc not in ( 166, 167, 168 )
		And     s.cree_le > '06/12/2011 23:59'		
		)
	)
--:[VDOC2985]
*/
ORDER BY s.id_prod, s.id_sin, g.id_gti

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S12_SCORE_GAME
-- Auteur               :       JFF
-- Date                 :       09/01/2007
-- Libellé              :       
-- Commentaires         :       Statistique Trimestrille particulière pour Score Game
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              
-- Retourne             :       Rien
-- #1  JFF   31/01/2008   suppression 550, 600
--     JFF   02/02/2011   [VDOC2985]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S12_SCORE_GAME' AND type = 'P' )
       DROP procedure sysadm.DW_S12_SCORE_GAME
GO

CREATE procedure sysadm.DW_S12_SCORE_GAME 
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

SELECT  @dtDteDeb 'Extraction_PEC_Debut',
	@dtDteFin 'Extraction_PEC_Fin',
	s.id_prod 'Code_produit',
	( Select Top 1 sysadm.FN_TRIM ( po.lib_police ) + ' ' + sysadm.FN_TRIM ( c.lib_cie )
	  From 	sysadm.garantie gr, 
	  	sysadm.police po,
	  	sysadm.compagnie c
	  Where gr.id_prod = s.id_prod
	  And	gr.id_gti = g.id_gti
	  And	gr.id_rev = s.id_rev
	  And   po.id_police = gr.id_police
	  And   c.id_cie = po.id_cie ) 'Contrat',
	sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_produit',
	s.id_sin 'Dossier',
	s.marq_port 'Marque_sinistre',
	s.modl_port 'Modele_sinistre',
	sysadm.FN_CODE_NUM ( s.id_natsin , '+NS' ) 'Nature_de_sinistre',
	sysadm.FN_CODE_NUM ( g.id_gti, '-GA' ) 'Garantie',	
	dd.cree_le 'Prise_en_charge_le',
	d.mt_val_achat 'Valeur_d_achat',
	( Select IsNull ( dd1.val_mt, 0 )
	  From sysadm.div_det dd1
	  where dd1.id_sin = dd.id_sin
	  AND   dd1.id_gti = dd.id_gti
	  AND   dd1.id_detail = dd.id_detail
	  AND   dd1.nom_zone = 'mt_pec' ) 'Mt_PEC',
	'PRIS EN CHARGE' 'Etat_detail', 
	s.id_orian_boutique 'Code_boutique',
	( Select b.adr_ville from boutique b where b.id_prod = s.id_prod and b.id_boutique = s.id_orian_boutique ) 'Ville_boutique',
	( Select b.adr_cp from boutique b where b.id_prod = s.id_prod and b.id_boutique = s.id_orian_boutique ) 'CP_boutique'

FROM   	sinistre s,
	detail d,
	div_det dd,
	gar_sin g,
	produit p

INNER JOIN sysadm.det_pro dp
	ON dp.id_prod = p.id_prod
	AND dp.id_code_dp = 94
	AND sysadm.FN_CLE_VAL('COD_DW', dp.val_car, ';') = 'd_l_pec_score_game2'

WHERE   p.id_dept = 280
AND 	s.id_prod = p.id_prod
AND     g.id_sin = s.id_sin
AND 	s.cod_etat In ( 100, 550, 600 )
AND     d.id_sin = s.id_sin
AND     d.cod_etat In ( 100 )
AND     dd.id_sin = d.id_sin
AND     dd.id_gti = d.id_gti
AND     dd.id_detail = d.id_detail
AND     dd.nom_zone = 'pec'
AND     dd.val_car = 'O' 
AND     dd.cree_le BETWEEN @dtDteDeb AND @dtDteFin
And     s.cree_le <= '06/12/2011 23:59'
--[VDOC2985]
AND	( 	
		Not Exists ( 
		Select 	*
		From	sysadm.commande c
		Where	c.id_sin = s.id_sin
		And	c.id_four = 'O2M'
		And	c.info_spb_frn between 1500 and 1599
		)
	)
--:[VDOC2985]
Union
SELECT  @dtDteDeb 'Extraction_PEC_Debut',
	@dtDteFin 'Extraction_PEC_Fin',
	s.id_prod 'Code_produit',
	( Select Top 1 sysadm.FN_TRIM ( po.lib_police ) + ' ' + sysadm.FN_TRIM ( c.lib_cie )
	  From 	sysadm.garantie gr, 
	  	sysadm.police po,
	  	sysadm.compagnie c
	  Where gr.id_prod = s.id_prod
	  And	gr.id_gti = g.id_gti
	  And	gr.id_rev = s.id_rev
	  And   po.id_police = gr.id_police
	  And   c.id_cie = po.id_cie ) 'Contrat',
	sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_produit',
	s.id_sin 'Dossier',
	s.marq_port 'Marque_sinistre',
	s.modl_port 'Modele_sinistre',
	sysadm.FN_CODE_NUM ( s.id_natsin , '+NS' ) 'Nature_de_sinistre',
	sysadm.FN_CODE_NUM ( g.id_gti, '-GA' ) 'Garantie',	
	dd.cree_le 'Prise_en_charge_le',
	d.mt_val_achat 'Valeur_d_achat',
	( Select IsNull ( dd1.val_mt, 0 )
	  From sysadm.div_det dd1
	  where dd1.id_sin = dd.id_sin
	  AND   dd1.id_gti = dd.id_gti
	  AND   dd1.id_detail = dd.id_detail
	  AND   dd1.nom_zone = 'mt_pec' ) 'Mt_PEC',
	'PRIS EN CHARGE' 'Etat_detail', 
	s.id_orian_boutique 'Code_boutique',
	( Select b.adr_ville from boutique b where b.id_prod = s.id_prod and b.id_boutique = s.id_orian_boutique ) 'Ville_boutique',
	( Select b.adr_cp from boutique b where b.id_prod = s.id_prod and b.id_boutique = s.id_orian_boutique ) 'CP_boutique'

FROM   	sinistre s,
	detail d,
	div_det dd,
	gar_sin g,
	produit p

INNER JOIN sysadm.det_pro dp
	ON dp.id_prod = p.id_prod
	AND dp.id_code_dp = 94
	AND sysadm.FN_CLE_VAL('COD_DW', dp.val_car, ';') = 'd_l_pec_score_game2'

WHERE   p.id_dept = 280
AND 	s.id_prod = p.id_prod
AND     g.id_sin = s.id_sin
AND 	s.cod_etat In ( 100, 550, 600 )
AND     d.id_sin = s.id_sin
AND     d.cod_etat In ( 100 )
AND     dd.id_sin = d.id_sin
AND     dd.id_gti = d.id_gti
AND     dd.id_detail = d.id_detail
AND     dd.nom_zone = 'pec'
AND     dd.val_car = 'O' 
AND     dd.cree_le BETWEEN @dtDteDeb AND @dtDteFin
And     s.cree_le > '06/12/2011 23:59'		
--[VDOC2985]
AND	( 	
		Exists 
		( 
		Select 	*
		From	sysadm.commande c
		Where	c.id_sin = s.id_sin
		And	c.id_four = 'O2M'
		And	c.info_spb_frn between 1500 and 1599
		And     c.status_gc in ( 166, 167, 168 )
		)
	)
--:[VDOC2985]

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S13_NB_FACTURE_FRN_MOIS
-- Auteur               :       PHG
-- Date                 :       30/01/2007
-- Libellé              :       
-- Commentaires         :       Statistique Mensuelle : Nb de Facure pour le mois écoulé/Fournisseur
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--                              
-- Retourne             :       Rien
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S13_NB_FACTURE_FRN_MOIS' AND type = 'P' )
       DROP procedure sysadm.DW_S13_NB_FACTURE_FRN_MOIS
GO

CREATE procedure sysadm.DW_S13_NB_FACTURE_FRN_MOIS
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

SET NOCOUNT ON

select  
 sysadm.FN_CODE_CAR ( i.id_four, '-FR' ) 'Lib_four',

 i.id_four 'Code_four',

 s.id_prod 'code_produit',

 sysadm.FN_LIB_PROD ( s.id_prod ) 'Lib_Prod', 

 s.id_ets 'Ets',

 Year ( r.dte_reg )'Annee_reglement',
 Month ( r.dte_reg )'Mois_reglement',

 Case r.cod_mot_reg 
  When 'RM' then  '(RM) Régul Moins Cie'
  When 'RP' then  '(RP) Régul Plus Cie'
  When 'RN' then  '(RN) Réglement normal'
  Else r.cod_mot_reg 
 End 'Type_du_reglement',

 ( Select Top 1 min ( id_seq) 
   From   commande c,
    detail d
   where  d.id_sin = s.id_sin
   And    d.id_reg = r.id_reg
   And    c.id_sin = d.id_sin
   And    c.id_gti = d.id_gti
   And    c.id_detail = d.id_detail
 ) 'Tiret'


Into    #tb_temp_080087

from    sysadm.reglement r,
 sysadm.inter i,
 sysadm.sinistre s,
 sysadm.produit p

where  r.dte_reg between @dtDteDeb and @dtDteFin
and    r.cod_mode_reg = 'FM'
and    i.id_sin = r.id_sin
and    i.id_i = r.id_i
and    s.id_sin = r.id_sin
and    r.cod_mot_reg not in ( 'RI' )
and    p.id_prod = s.id_prod

SET NOCOUNT OFF

Select 
@dtDteDeb 'periode_debut',
@dtDteFin 'periode_fin',
Lib_four,
Code_four,
code_produit,
Lib_Prod,
Ets,
Annee_reglement,
Mois_reglement,
Type_du_reglement,
Tiret,
count (*) 'Nbre_Total'

From #tb_temp_080087 t

Group by 
Lib_four,
Code_four,
code_produit,
Lib_Prod,
Ets,
Annee_reglement,
Mois_reglement,
Type_du_reglement,
Tiret

Order by 1, Annee_reglement,
Mois_reglement

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S14_STAT_UTILISATION_COURRIER
-- Auteur               :       PHG
-- Date                 :       31/01/2008
-- Libellé              :       Etat Liste Utilisation des Courriers
-- Commentaires         :       
-- Références           :       [DCMP080080], p8sp_sta.pbl::d_l_utilisation_courrier 
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S14_STAT_UTILISATION_COURRIER' AND type = 'P' )
        DROP procedure sysadm.DW_S14_STAT_UTILISATION_COURRIER
GO

CREATE procedure sysadm.DW_S14_STAT_UTILISATION_COURRIER
        @dtDteDeb	DateTime,
        @dtDteFin	DateTime
AS

Select  @dtDteDeb Date_Deb,
	@dtDteFin Date_Fin,
	d1.lib_dept Dept,
	d2.lib_dept Sous_Dept,
	a.id_prod Produit,
	p.lib_long Lib_Produit,
	a.id_cour_orig Courrier_Orig,
	a.id_cour Courrier_Def,
	cCC.lib_code Lib_Type_Courrier,
	a.maj_par Maj_Par,
	a.valide_par Valide_Par,
	a.id_sin Dossier

from   	sysadm.archive a, 
	sysadm.produit p,
	sysadm.departement d1,
	sysadm.departement d2,
	sysadm.code_car cCC
	
where   d1.id_dept = p.id_dept
and 	d2.id_dept = p.id_depts
and	p.id_prod  = a.id_prod
and 	valide_le between @dtDteDeb And @dtDteFin
and	cCC.id_typ_code = '-CC'
and 	cCC.id_code = a.id_cour
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_ETAT_BASE_SIN_CELL_PRESTA
-- Auteur               :       JCA
-- Date                 :       28/02/2008
-- Libellé              :       Etat pour la cellule prestataire
-- Commentaires         :       
-- Références           :       [DCMP080155], p8sp_sta.pbl::d_l_base_sin_cell_presta 
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[sysadm].[DW_S01_ETAT_BASE_SIN_CELL_PRESTA]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [sysadm].[DW_S01_ETAT_BASE_SIN_CELL_PRESTA]
GO


CREATE procedure sysadm.DW_S01_ETAT_BASE_SIN_CELL_PRESTA
        @dtDeb       DateTime,
        @dtFin       DateTime
AS

SELECT  @dtDeb AS Dte_Deb,
		@dtFin AS Dte_Fin,
		'Données_sinistre' as 'Titre',
		s.id_prod,
		sysadm.FN_LIB_PROD ( s.id_prod ) as Lib_Produit,
		s.id_sin,
		s.dte_surv,
		s.dte_adh,
		s.dte_resil,
		s.dte_fin_gti,
		s.dte_decl,
		s.mt_reg as 'mt_sin_reglé_NE_PAS_FAIRE_SOMME',
		sysadm.FN_CODE_CAR ( i.cod_mode_reg, '-MR') as 'Mode_Réglement',
		sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' ) as 'Etat_dossier',
		sysadm.FN_CODE_NUM ( s.id_natsin, '+NS') as 'Nature',
		sysadm.FN_CODE_NUM ( s.id_territ, '+TR') as 'Territorialité',
		sysadm.FN_CODE_NUM ( s.id_detsin, '+DT') as 'DetSin',
		s.valide_le,
		s.valide_par,
		s.cree_le,
		s.maj_le,
		s.maj_par,
		s.dte_ouvlig_port,
		s.dte_ach_port,
		s.marq_port as 'Marque_sinistrée',
		s.modl_port as 'Modele_sinistrée',
		s.num_imei_port,
		s.id_orian_boutique as 'boutique',
		( select IsNull ( sysadm.FN_CODE_CAR ( nullif (  dd.val_car, 'AUT' ), '-AR'), sysadm.FN_CODE_NUM ( d.id_evt, '+EV' ) )
		  From   sysadm.div_sin dd
		  where  dd.id_sin = s.id_sin
		  And    dd.nom_zone = 'type_app' ) 'Type_app_sinistré',
		'Données_garantie' as 'Titre',
		g.id_gti 'code_gti',
		Case g.alt_plaf When 'O' Then 'PLAFOND!' Else '' End as 'Plafond_gti',
		g.mt_plaf_reg 'mt_gti_reglé_NE_PAS_FAIRE_SOMME',
		sysadm.FN_CODE_NUM ( g.id_gti, '-GA') as 'Garantie',
		sysadm.FN_CODE_NUM ( g.cod_etat, '-ET') as 'Etat_Garantie',
		'Données_Detail' as 'Titre',
		d.id_detail,
		d.id_evt as 'code_evt',
		sysadm.FN_CODE_NUM ( g.cod_etat, '-ET') as 'Etat_Gti',
		d.id_reg 'num_reglt',
		( Select '(' + sysadm.FN_TRIM ( sysadm.FN_CODE_CAR (i.cod_inter, '-IN')) + ') ' + i.nom
		  From  sysadm.inter i
		  Where i.id_sin = d.id_sin
		  and   i.id_i = d.id_i_reg ) as 'Inter_réglé',
		d.mt_val_achat as 'Val_achat_origine',
		d.mt_val_publique as 'Val_publique_IFR',
		d.mt_prej,
		d.mt_plaf,
		Case d.alt_plaf When 'O' Then 'PLAFOND!' Else '' End as 'Plafond_evt',
		Case d.alt_reg When 'O' Then 'Regl_Forcé!' Else '' End as 'Forcage_Regl',
		sysadm.FN_CODE_NUM ( d.cod_etat, '-ET') as 'Etat_Détail',
		d.dte_livr as 'Dte_facturation',
		d.num_facture,
		d.valide_le,
		d.valide_par,
		d.cree_le,
		d.maj_le,
		d.maj_par,
		'Données_Commande' as 'Titre',
		null as 'id_seq',
		null as 'id_gti',
		null as 'id_detail',
		null as 'id_four',
		null as 'id_typ_art',
		null as 'lib_id_typ_art',
		null as 'id_marq_art_fourn',
		null as 'id_modl_art_fourn',
		null as 'mt_ttc_cmde_fourn',
		null as 'id_serie_anc',
		null as 'probleme',
		null as 'id_serie_nouv',
		null as 'comment_frn',
		null as 'nom_gest',
		null as 'id_ref_four',
		null as 'id_orian_marque',
		null as 'id_orian_modele',
		null as 'lib_status_gc',
		null as 'lib_status_gc',
		null as 'status_gc',
		null as 'lib_id_ann',
		null as 'dte_rcp_mob_cli',
		null as 'info_spb_frn',
		null as 'id_marq_art_ifr',
		null as 'id_modl_art_ifr'

FROM    sysadm.sinistre s,
		sysadm.gar_sin g,
		sysadm.detail d,
		sysadm.inter i
		
WHERE   g.id_sin = s.id_sin
AND     d.id_sin = s.id_sin
AND     d.id_gti = g.id_gti	
AND		i.id_sin = s.id_sin
AND		i.cod_inter  = 'A'
AND     Exists ( Select top 1 * From sysadm.commande_type ct where ct.id_prod = s.id_prod )
AND 	Not exists ( Select top 1 * from sysadm.commande c where c.id_sin = d.id_sin  and c.id_gti = d.id_gti  and c.id_detail = d.id_detail )
AND     s.valide_le between @dtDeb and @dtFin

UNION ALL

SELECT  @dtDeb AS Dte_Deb,
		@dtFin AS Dte_Fin,
		'Données_sinistre' as 'Titre',
		s.id_prod,
		sysadm.FN_LIB_PROD ( s.id_prod ),
		s.id_sin,
		s.dte_surv,
		s.dte_adh,
		s.dte_resil,
		s.dte_fin_gti,
		s.dte_decl,
		s.mt_reg as 'mt_sin_reglé_NE_PAS_FAIRE_SOMME',
		sysadm.FN_CODE_CAR ( i.cod_mode_reg, '-MR') as 'Mode_Réglement',
		sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' ) as 'Etat_dossier',
		sysadm.FN_CODE_NUM ( s.id_natsin, '+NS') as 'Nature',
		sysadm.FN_CODE_NUM ( s.id_territ, '+TR') as 'Territorialité',
		sysadm.FN_CODE_NUM ( s.id_detsin, '+DT') as 'DetSin',
		s.valide_le,
		s.valide_par,
		s.cree_le,
		s.maj_le,
		s.maj_par,
		s.dte_ouvlig_port,
		s.dte_ach_port,
		s.marq_port as 'marque_sinistrée',
		s.modl_port as 'modele_sinistrée',
		s.num_imei_port,
		s.id_orian_boutique as 'boutique',
		( select IsNull ( sysadm.FN_CODE_CAR ( nullif (  dd.val_car, 'AUT' ), '-AR'), sysadm.FN_CODE_NUM ( d.id_evt, '+EV' ) )
		  FROM   sysadm.div_sin dd
		  WHERE  dd.id_sin = s.id_sin
		  AND    dd.nom_zone = 'type_app' ) as 'Type_app_sinistré',
		'Données_garantie' as 'Titre',
		g.id_gti as 'code_gti',
		CASE g.alt_plaf WHEN 'O' THEN 'PLAFOND!' ELSE '' END  as 'Plafond_gti',
		g.mt_plaf_reg as 'mt_gti_reglé_NE_PAS_FAIRE_SOMME',
		sysadm.FN_CODE_NUM ( g.id_gti, '-GA') as 'Garantie',
		sysadm.FN_CODE_NUM ( g.cod_etat, '-ET') as 'Etat_Detail',
		'Données_Detail' as 'Titre',
		d.id_detail,
		d.id_evt as 'code_evt',
		sysadm.FN_CODE_NUM ( g.cod_etat, '-ET') as 'Etat_Gti',
		d.id_reg as 'num_reglt',
		( SELECT '(' + sysadm.FN_TRIM ( sysadm.FN_CODE_CAR (i.cod_inter, '-IN')) + ') ' + i.nom
		  FROM  sysadm.inter i
		  WHERE i.id_sin = d.id_sin
		  AND   i.id_i = d.id_i_reg ) as 'Inter_réglé',
		d.mt_val_achat as 'Val_achat_origine',
		d.mt_val_publique as 'Val_publique_IFR',
		d.mt_prej,
		d.mt_plaf,
		CASE d.alt_plaf WHEN 'O' THEN 'PLAFOND!' ELSE '' END as 'Plafond_evt',
		CASE d.alt_reg WHEN 'O' THEN 'Regl_Forcé!' ELSE '' END as 'Forcage_Regl',
		sysadm.FN_CODE_NUM ( d.cod_etat, '-ET') as 'Etat_Détail',
		d.dte_livr as 'Dte_facturation',
		d.num_facture,
		d.valide_le,
		d.valide_par,
		d.cree_le,
		d.maj_le,
		d.maj_par,
		'Données_Commande' as 'Titre',
		c.id_seq as 'id_seq',
		c.id_gti as 'id_gti',
		c.id_detail as 'id_detail',
		c.id_four as 'id_four',
		c.id_typ_art as 'id_typ_art',
		sysadm.FN_CODE_CAR ( c.id_typ_art, '-AR' ) as 'lib_id_typ_art',
		c.id_marq_art as 'id_marq_art_fourn',
		c.id_modl_art as 'id_modl_art_fourn',
		c.mt_ttc_cmde as 'mt_ttc_cmde_fourn',
		c.id_serie_anc as 'id_serie_anc',
		c.probleme as 'probleme',
		c.id_serie_nouv as 'id_serie_nouv',
		c.comment_frn as 'comment_frn',
		c.nom_gest as 'nom_gest',
		c.id_ref_four as 'id_ref_four',
		c.id_orian_marque as 'id_orian_marque',
		c.id_orian_modele as 'id_orian_modele',
		c.status_gc as 'lib_status_gc',
		sysadm.FN_CODE_NUM ( c.status_gc, '-GC' ) as 'lib_status_gc',
		c.status_gc as 'status_gc',
		sysadm.FN_CODE_NUM ( c.id_ann, '-CA' ) as 'lib_id_ann',
		dte_rcp_mob_cli as 'dte_rcp_mob_cli',
		info_spb_frn as 'info_spb_frn',
		id_marq_art_ifr as 'id_marq_art_ifr',
		id_modl_art_ifr as 'id_modl_art_ifr'

FROM    sysadm.sinistre s,
		sysadm.gar_sin g,
		sysadm.detail d,
		sysadm.commande c,
		sysadm.inter i

WHERE   g.id_sin = s.id_sin
AND     d.id_sin = s.id_sin
AND     d.id_gti = g.id_gti	
AND		i.id_sin = s.id_sin
AND		i.cod_inter  = 'A'
AND   	c.id_sin = d.id_sin 
AND 	c.id_gti = d.id_gti 
AND 	c.id_detail = d.id_detail 
AND     s.valide_le BETWEEN @dtDeb AND @dtFin

ORDER BY s.valide_le, s.id_sin, g.id_gti, d.id_detail

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S11_SURCOUF_ECHANGES_EXPRESS
-- Auteur               :       JCA
-- Date                 :       02/04/2008
-- Libellé              :       Etat pour les produits Surcouf Echange Express
-- Commentaires         :       
-- Références           :       [DCMPxxxxxx], [DCMP080686], p8sp_sta.pbl::d_l_pec_surcourf_ech_express 
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- #1	01/10/2008	PHG	[DCMP080686] Ajout N° de serie + SKU
-------------------------------------------------------------------

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[DW_S11_SURCOUF_ECHANGES_EXPRESS]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[DW_S11_SURCOUF_ECHANGES_EXPRESS]
GO


CREATE procedure sysadm.DW_S11_SURCOUF_ECHANGES_EXPRESS
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

SELECT  s.id_sin 'Dossier',
	s.id_prod 'Code_produit',
	sysadm.FN_LIB_PROD ( s.id_prod ) 'Lib_produit',
	sysadm.FN_CODE_NUM ( s.cod_etat , '-ET' ) 'Etat_dossier',
	sysadm.FN_CODE_NUM ( s.id_natsin , '+NS' ) 'Nature_de_sinistre',
	s.marq_port 'Marque_sinistre',
	s.modl_port 'Modele_sinistre',
	dd.cree_le 'Prise_en_charge_le',
	sysadm.FN_CODE_NUM ( g.id_gti , '-GA' ) 'Garantie',	
	d.mt_val_achat 'Valeur_d_achat',
	'PRIS EN CHARGE' 'Etat_détail', 
	s.id_orian_boutique 'Code_boutique',
	( Select b.adr_ville from boutique b where b.id_prod = s.id_prod and b.id_boutique = s.id_orian_boutique ) 'Ville_boutique',
	( Select b.adr_cp from boutique b where b.id_prod = s.id_prod and b.id_boutique = s.id_orian_boutique ) 'CP_boutique',
	( select min ( a.dte_edit ) from archive a where a.id_sin = s.id_sin and id_cour_orig like 'WDE%' ) 'Date_courrier_pec',
	s.num_imei_port 'numero_serie', -- #1 PHG, 01/10/2008
	( select ds.val_car from div_sin ds where ds.id_sin = s.id_sin and nom_zone = 'sku_ident_appareil') 'Identifiant_SKU' -- #1 PHG, 01/10/2008

FROM   	sysadm.sinistre s,
	sysadm.detail d,
	sysadm.div_det dd,
	sysadm.gar_sin g,
	sysadm.produit p

INNER JOIN sysadm.det_pro dp
	ON dp.id_prod = p.id_prod
	AND dp.id_code_dp = 94
	AND sysadm.FN_CLE_VAL('COD_DW', dp.val_car, ';') = 'd_l_pec_surcourf_ech_express'

WHERE   s.id_prod = p.id_prod
AND     g.id_sin = s.id_sin
-- AND		g.id_gti in (15, 11) Erreur !! (Correction JFF le 23/07/2008)
AND 	s.cod_etat In ( 100, 550, 600 )
AND     d.id_sin = s.id_sin
AND     d.cod_etat In ( 100, 550, 600 )
AND     dd.id_sin = d.id_sin
AND     dd.id_gti = d.id_gti
AND     dd.id_detail = d.id_detail
AND     dd.nom_zone = 'pec'
AND     dd.val_car = 'O' 
AND     dd.cree_le BETWEEN @dtDteDeb AND @dtDteFin

ORDER BY s.id_prod, s.id_sin, g.id_gti

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S03_EXTRACTION_REFUS_IRREPARABLE
-- Auteur               :       FABRY JF
-- Date                 :       16/05/2008
-- Libellé              :       Extraction journalière des dossiers refusé suite appareil irréparable
-- Commentaires         :       
-- Références           :       [DCMP080077]
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- 19/05/2009	FPI	[DCMP090280] Ajout du paramètre fournisseur
-- 19/09/2011   JFF     [PM82][LOT2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S03_EXTRACTION_REFUS_IRREPARABLE' AND type = 'P' )
        DROP procedure sysadm.PS_S03_EXTRACTION_REFUS_IRREPARABLE
GO

CREATE procedure sysadm.PS_S03_EXTRACTION_REFUS_IRREPARABLE
        @dtDeb       DateTime,
        @dtFin       DateTime,
		@sIdfour Varchar (3)
AS

Select  @dtDeb 'Dte_refus_deb',
	@dtFin 'Dte_refus_Fin',
	c.id_sin,
	c.id_seq,
	c.id_four,
	sysadm.FN_CODE_CAR ( c.id_four, '-FR' ) 'lib_four',
	c.id_cmd_frn 'num_cmd_fourn',
	c.dte_rcp_frn,
	c.adr_nom,
	c.adr_prenom,
	c.id_serie_anc,
	c.id_marq_art,
	c.id_modl_art

From   	sysadm.refus r,
	sysadm.commande c
where   r.cree_le between @dtDeb And @dtFin 
and     r.id_sin = c.id_sin
and     r.id_gti = c.id_gti
and     r.id_detail = c.id_detail
and     c.status_gc = 21
and 	c.id_four = @sIdfour -- [DCMP090280] 
and     Upper ( sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', rtrim ( c.info_spb_frn_cplt), ';' )) <> 'OUI' -- [PM82][LOT2]

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S04_EXTRACTION_REFUS_IRREPARABLE_MAIL
-- Auteur               :       FABRY JF
-- Date                 :       16/05/2008
-- Libellé              :       Exécute PS_S03_EXTRACTION_REFUS_IRREPARABLE et l'envoi par mail
-- Commentaires         :       
-- Références           :       [DCMP080077]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- 19/05/2009	FPI	[DCMP090280] Ajout du paramètre fournisseur dans PS_S03_EXTRACTION_REFUS_IRREPARABLE
--					---> refonte de la PS
-- 28/09/2009 	FPI [DCMP090532] Ajout d'O2M
-- 14/12/2009	FPI [DMDI27314] Modification de destinataire anovo
-- 24/06/2015   JFF [VDOC17993]	
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S04_EXTRACTION_REFUS_IRREPARABLE_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S04_EXTRACTION_REFUS_IRREPARABLE_MAIL
GO

SET QUOTED_IDENTIFIER OFF
Go

CREATE procedure sysadm.PS_S04_EXTRACTION_REFUS_IRREPARABLE_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(4),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

Declare @sLaVeille VarChar ( 10 )
Declare @sLaVeilleDeb VarChar ( 23 )
Declare @sLaVeilleFin VarChar ( 23 )
Declare @iCpt	int -- [DCMP090280]
DECLARE @sDebutCommande   VarChar(250),
		@sListeMails		VarChar(500)


Set @sLaVeille  = Convert ( VarChar ( 10), DateAdd ( day,-1, getdate()), 103 )
Set @sLaVeilleDeb = @sLaVeille + ' 00:00:00:000' 
Set @sLaVeilleFin = @sLaVeille + ' 23:59:59:000'


-- chemin d'enregistrement du Result Set
Set @sPath 	= master.[sysadm].[SPB_FN_GET_ROOT] () + 'Sinistre\Export_Refus_Irreparable\'
Set @sFileName	= 'DCMP080077_REFUS_IRREP_'
Set @sFileExt	= '.XLS'

--SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

Set @sObjet    = "REFUS IRREPARABLE du " + @sLaVeille
set @sMessage  = "Veuillez trouver ci-joint la liste des dossiers pour lesquels, à la suite d'un refus de prise en charge par SPB, les téléphones doivent être renvoyés à l'assuré au plus vite. Merci d'avance, cordialement."

-- [I027] Remplacement d'osql - les options sont identiques. Ajout de -W : Remove Trailing Space
IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	SET @sDebutCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			"SIMPA2_PRO.sysadm.PS_S03_EXTRACTION_REFUS_IRREPARABLE '" + @sLaVeilleDeb + "', '" + @sLaVeilleFin + "'"
Else
   SET @sDebutCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			"SIMPA2_TRT.sysadm.PS_S03_EXTRACTION_REFUS_IRREPARABLE '" + @sLaVeilleDeb + "', '" + @sLaVeilleFin + "'"

-- [VDOC17993]			
-- Set @iCpt = 1
Set @iCpt = 4 -- On shunt SBE, ANV, COR

While @iCpt < 6
begin
	-- Affectation des variables
	IF @iCpt = 1 
	begin
		SET @sCommande = @sDebutCommande + ",'ANV'"
		--SET @sListeMails = 'svignal@anovo.com, suivi_prestataires@spb.fr' 
		SET @sListeMails = 'Brive.SPB@anovo.com, suivi_prestataires@spb.fr' -- [DMDI27314]
		SET @sFicOut = @sPath + @sFileName + 'ANV' + @sFileExt
	End
	
	IF @iCpt = 2 
	begin
		SET @sCommande = @sDebutCommande + ",'SBE'"
		SET @sListeMails = 'edi.informatique@sbe-online.com, saisie-sbe@sbe-online.com, pflahaut@sbe-online.com, rcuiburu@sbe-online.com, mdafonseca@sbe-online.com, mlgin@sbe-online.com, nbrassart@sbe-online.com, mprudhomme@sbe-online.com, suivi_prestataires@spb.fr'
		SET @sFicOut = @sPath + @sFileName + 'SBE' + @sFileExt
	End
	
	IF @iCpt = 3 
	begin
		SET @sCommande = @sDebutCommande + ",'COR'"
		SET @sListeMails = 'spb@cordonweb.com, suivi_prestataires@spb.fr'
		SET @sFicOut = @sPath + @sFileName + 'COR' + @sFileExt
	End
	
	-- [DCMP090532] - ajout d'O2M
	IF @iCpt = 4 
	begin
		SET @sCommande = @sDebutCommande + ",'O2M'"
		SET @sListeMails = 'oxydation@o2m.fr, suivi_prestataires@spb.fr'
		SET @sFicOut = @sPath + @sFileName + 'O2M' + '.TXT' -- 06/10/2009 - FPI - old : @sFileExt
	End

	-- [PM200][PSM]
	IF @iCpt = 5 
	begin
		SET @sCommande = @sDebutCommande + "'PSM'"
		SET @sListeMails = 'spb@allopsm.fr, suivi_prestataires@spb.fr'
		SET @sFicOut = @sPath + @sFileName + 'PSM' + @sFileExt
	End
	
	-- Création du fichier
	Set @sCommande = @sCommande + '" /o' + @sFicOut + ' -n -w5000' + @sOsqlOption
	
	EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output
	
	if @iRetOsql <> 0
	BEGIN
		set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DES.'
	END

	-- Envoi du mail
	EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		@sListeMails, 
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL
		
	Set @iCpt = @iCpt + 1
end

Go

grant execute on sysadm.PS_S04_EXTRACTION_REFUS_IRREPARABLE_MAIL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S05_EXTRACTION_IFR_3_MOIS
-- Auteur               :       FABRY JF
-- Date                 :       16/05/2008
-- Libellé              :       Extraction Mensuelles des mobiles IFR n'ayant pas été mis à jour depuis plus de trois moins.
-- Commentaires         :       
-- Références           :       [DCMP080374]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- #1  03/12/2008       JFF     [DCMP080745]
--		09/01/2015		FPI 	[VDOC10632]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S05_EXTRACTION_IFR_3_MOIS' AND type = 'P' )
        DROP procedure sysadm.PS_S05_EXTRACTION_IFR_3_MOIS
GO

CREATE procedure sysadm.PS_S05_EXTRACTION_IFR_3_MOIS
AS

Declare @s VarChar ( 6 )
Declare @s1 VarChar ( 10 )
Declare @s2 VarChar ( 10 )
Declare @dtMajle Datetime
Declare @idTrait Integer
Declare @iMois Integer

Set @iMois = -3

select @s = Left ( Convert ( VarChar (10), max (id_trait)), 6 ) from sysadm.ifr where provenance = 'IFR' --[I027] Correction sysadm + date ISO

Set @s1 = '01/' + SubString ( @s,5, 2) + '/' + Left ( @s, 4 )

-- le month +1 est normal, le fait de comparer avec '<' fait 3 mois. Ne surtout modifier !! pour mettre 3 et <= cela pose problème
Set @s2 = convert( VarChar ( 10), DateAdd ( month, @iMois + 1, Convert( DateTime,@s1 ) ), 112 ) --[I027] Correction sysadm + date ISO
--Set @idTrait = Right ( @s2, 4 ) + SubString ( @s2,4, 2) + '0000'
Set @idTrait = Left ( @s2, 4 ) + SubString ( @s2,5, 2) + '0000' --[I027] Correction sysadm + date ISO

Set @dtMajle = convert( VarChar ( 10), DateAdd ( month, @iMois, getdate() ), 112 ) --[I027] Correction sysadm + date ISO

select distinct sysadm.FN_TRIM ( i.marque ) 'Marque', 
	sysadm.FN_TRIM ( i.reference ) 'Modele',
	i.prix_bas as dernier_prix_du_marche -- [VDOC10632]
from sysadm.ifr i --[I027] Correction sysadm + date ISO
where i.id_trait < @idTrait
And   i.maj_le <= @dtMajle
and not exists 
	( Select *
	  From sysadm.ifr i2 --[I027] Correction sysadm + date ISO
	  where i2.marque = i.marque
	  and i2.reference = i.reference
	  and i2.id_trait > i.id_trait 
	 )
And i.frequence >= 99


Go

grant execute on sysadm.PS_S05_EXTRACTION_IFR_3_MOIS to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S06_EXTRACTION_IFR_3_MOIS_MAIL
-- Auteur               :       FABRY JF
-- Date                 :       16/05/2008
-- Libellé              :       Exécute PS_S06_EXTRACTION_IFR_3_MOIS et l'envoi par mail
-- Commentaires         :       
-- Références           :       [DCMP080374]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
--    12/04/2012	JFF	[VDOC7464]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S06_EXTRACTION_IFR_3_MOIS_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S06_EXTRACTION_IFR_3_MOIS_MAIL
GO

CREATE procedure sysadm.PS_S06_EXTRACTION_IFR_3_MOIS_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_IFR_3_MOIS\'
Set @sFileName	= 'DCMP080374_IFR_3_MOIS'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S05_EXTRACTION_IFR_3_MOIS ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S05_EXTRACTION_IFR_3_MOIS ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = 'Extraction IFR à plus de 3 mois'
set @sMessage  = 'Veuillez trouver ci-joint l''extraction des mobiles IFR n''ayant pas été mis à jour depuis plus de 3 mois ET dont le prix frequent est supérieur ou égal à 99 euros.'

if @iRetOsql <> 0
BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DES.'
END

-- VDOC7464 PDE
EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'eprevost@spb.eu,sloison@spb.eu', 
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL


Go

grant execute on sysadm.PS_S06_EXTRACTION_IFR_3_MOIS_MAIL to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procédure            :       PS_S07_EXTRACTION_FNAC_TV_HEBDO
-- Auteur               :       FABRY JF
-- Date                 :       17/07/2008
-- Libellé              :       Extraction Hebdo pou Fnac TV
-- Commentaires         :       
-- Références           :       [DCMP080562]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S07_EXTRACTION_FNAC_TV_HEBDO' AND type = 'P' )
        DROP procedure sysadm.PS_S07_EXTRACTION_FNAC_TV_HEBDO
GO

CREATE procedure sysadm.PS_S07_EXTRACTION_FNAC_TV_HEBDO
AS


Select  s.id_sin,
	pe.nom,
	pe.prenom,
	s.dte_decl,
	s.dte_surv,
	s.cree_le,
	s.mt_reg,
	p.lib_long,
	Case s.cod_etat

		When 100 Then 	Case
					When
						(	Select Count(*) 
							From    sysadm.detail d,
								sysadm.div_det dd
							Where	d.id_sin = s.id_sin
							And     dd.id_sin = d.id_sin
							And     dd.id_gti = d.id_gti
							And     dd.id_detail = d.id_detail
							And     d.cod_etat = 100
							And     dd.nom_zone = 'pec'
							And     dd.val_car = 'O'
						) > 0 Then 'Pris en Charge'
					Else	sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' )
				End 
		Else sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' )
	End 'Etat_Dossier'

from	sysadm.produit p,
	sysadm.sinistre s,
	sysadm.personne pe
Where	p.cod_prod_dms = 298
And     s.id_prod = p.id_prod
and     pe.id_ordre = s.id_ordre
Order by s.dte_decl


Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S08_EXTRACTION_FNAC_TV_HEBDO_MAIL
-- Auteur               :       FABRY JF
-- Date                 :       16/05/2008
-- Libellé              :       Exécute PS_S07_EXTRACTION_FNAC_TV_HEBDO et l'envoi par mail
-- Commentaires         :       
-- Références           :       [DCMP080562]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S08_EXTRACTION_FNAC_TV_HEBDO_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S08_EXTRACTION_FNAC_TV_HEBDO_MAIL
GO

CREATE procedure sysadm.PS_S08_EXTRACTION_FNAC_TV_HEBDO_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Extraction_Hebdo_FNAC_TV_080562\'
Set @sFileName	= 'DCMP080562_HEBDO_FNAC_TV'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S07_EXTRACTION_FNAC_TV_HEBDO ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S07_EXTRACTION_FNAC_TV_HEBDO ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = 'Extraction Hebdomadaire FNAC_TV DCMP080562'
set @sMessage  = 'Veuillez trouver ci-joint l''extraction des sinistres déclarés depuis l''origine du produit 298.'

if @iRetOsql <> 0
BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DES.'
END

EXEC master.dbo.SPB_PS_MAIL_OUTLOOK 
		@sRetourErrMail OUTPUT, 
		-- 'fguilbaud@spb.fr,edufresne@spb.fr,jpbequet@spb.fr,skrizez@spb.fr', --[ITSM68110] - changement de nom en DSR
		'GG_DDI-DTA-DSR@spb.eu',
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL


Go

grant execute on sysadm.PS_S08_EXTRACTION_FNAC_TV_HEBDO_MAIL to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S15_ETAT_PRESTA_MSS_POUR_O2M
-- Auteur               :       PHG
-- Date                 :       07/08/2008
-- Libellé              :       
-- Commentaires         :       [DCMP080599] Etat des prestation des MMS, a destination d'O2M
-- Références           :       
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--				@dcIdProd	Decimal ( 7,0 )
--                              
-- Retourne             :       Rien
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S15_ETAT_PRESTA_MSS_POUR_O2M' AND type = 'P' )
       DROP procedure sysadm.DW_S15_ETAT_PRESTA_MSS_POUR_O2M
GO

CREATE procedure sysadm.DW_S15_ETAT_PRESTA_MSS_POUR_O2M
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

Select 	convert(varchar(10), @dtDteDeb, 103) as du,
	convert(varchar(10), @dtDteFin, 103) as au,
	s.id_prod as Ref_Produit,
	sysadm.FN_LIB_PROD(s.id_prod) as Lib_Produit,
	cm.id_sin as Ref_Sinistre,
	cm.id_four as Fournisseur_FR,
	ds.val_car as Type_Article_AR,
	cm.id_marq_art as Marque_Article,
	cm.id_modl_art as Modele_Article,
	cm.adr_nom	as Nom_Interlocuteur,
	cm.adr_prenom as Prenom_Interlocuteur,
	cm.id_serie_anc as Ancien_Num_IMEI,
	cm.probleme	as Description_Probleme
From 	sinistre s 
	INNER JOIN 	sysadm.commande cm 
			INNER JOIN sysadm.div_sin ds ON (cm.id_sin = ds.id_sin AND ds.nom_zone='type_app')
	ON (s.id_sin = cm.id_sin)
Where 	cm.cree_le between @dtDteDeb and @dtDteFin
And	cm.id_four = 'MSS'

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S16_SURCOUF_PIXEL
-- Auteur               :       PHG
-- Date                 :       11/12/2008
-- Libellé              :       Etat pour les produits Surcouf Pixel
-- Commentaires         :       
-- Références           :       [DCMP080809], p8sp_sta.pbl::d_l_pec_surcourf_pixel
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[DW_S16_SURCOUF_PIXEL]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[DW_S16_SURCOUF_PIXEL]
GO

CREATE procedure sysadm.DW_S16_SURCOUF_PIXEL
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

SELECT  s.id_sin 'Dossier',
	s.id_prod 'Code_produit',
	sysadm.FN_LIB_PROD ( s.id_prod ) 'Lib_produit',
	sysadm.FN_CODE_NUM ( s.id_natsin , '+NS' ) 'Nature_de_sinistre',
	s.dte_surv 'Date_sinistre',
	(Select prenom From sysadm.personne pe where pe.id_ordre = s.id_ordre ) 'prenom_assure',
	(Select nom From sysadm.personne pe where pe.id_ordre = s.id_ordre ) 'nom_assure',
	s.marq_port 'Marque_sinistre',
	s.modl_port 'Modele_sinistre',
	dd.cree_le 'Prise_en_charge_le',
	sysadm.FN_CODE_NUM ( g.id_gti , '-GA' ) 'Garantie',	
	d.mt_val_achat 'Valeur_d_achat',
	'PRIS EN CHARGE' 'Etat_dossier', 
	s.id_orian_boutique 'Code_boutique',
	( Select b.adr_ville from boutique b where b.id_prod = s.id_prod and b.id_boutique = s.id_orian_boutique ) 'Ville_boutique',
	( Select b.adr_cp from boutique b where b.id_prod = s.id_prod and b.id_boutique = s.id_orian_boutique ) 'CP_boutique',
	( select min ( a.dte_edit ) from archive a where a.id_sin = s.id_sin and id_cour_orig like 'WDE%' ) 'Date_courrier_pec',
	s.num_imei_port 'numero_serie',
	convert (varchar(1), null) 'prix_vente_ttc',
	convert (varchar(1), null)'reprise_O2M_60pcent',
	convert (varchar(1), null)'Diagnostic'

FROM   	sysadm.sinistre s,
	sysadm.detail d,
	sysadm.div_det dd,
	sysadm.gar_sin g,
	sysadm.produit p

INNER JOIN sysadm.det_pro dp
	ON dp.id_prod = p.id_prod
	AND dp.id_code_dp = 94
	AND sysadm.FN_CLE_VAL('COD_DW', dp.val_car, ';') = 'd_l_pec_surcourf_pixel'

WHERE   s.id_prod = p.id_prod
AND     g.id_sin = s.id_sin
AND 	g.id_gti = 18 -- Panne uniquement
AND 	s.cod_etat In ( 100, 550, 600 )
AND     d.id_sin = s.id_sin
AND     d.cod_etat In ( 100, 550, 600 )
AND     dd.id_sin = d.id_sin
AND     dd.id_gti = d.id_gti
AND     dd.id_detail = d.id_detail
AND     dd.nom_zone = 'pec'
AND     dd.val_car = 'O' 
AND     dd.cree_le BETWEEN @dtDteDeb AND @dtDteFin

ORDER BY s.id_prod, s.id_sin, g.id_gti

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S09_080887_IPHONE
-- Auteur               :       JFF
-- Date                 :       07/01/2009
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [DCMP080887]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S09_080887_IPHONE' AND type = 'P' )
        DROP procedure sysadm.PS_S09_080887_IPHONE
GO

CREATE procedure sysadm.PS_S09_080887_IPHONE
AS

Declare @sDateDeb Varchar ( 20 ) -- Format Date d'affichage
Declare @sDateFin Varchar ( 20 ) -- Format Date d'affichage

--Select @sDateDeb = Convert ( Varchar( 10 ), DateAdd ( week, -1, getdate()) , 103 )
--Select @sDateFin = Convert ( VarChar ( 10), DateAdd ( day, -1, Convert ( Varchar( 10 ), DateAdd ( week, 1, convert ( Datetime , @sDateDeb )) , 103 ) ), 103 )
-- [I027] Correction sysadm + date ISO
Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @dtToday datetime

Select @dtToday		= getdate()

Select @dtDateDeb	= Convert(Varchar (8), DateAdd ( week, -1, @dtToday) , 112 )
Select @sDateDeb	= Convert(Varchar(10),@dtDateDeb, 103)+ ' ' + Convert ( Varchar( 8 ),@dtDateDeb, 114)
Select @dtDateFin	= DateAdd ( ss , -1, cast (Convert(VarChar (8), @dtToday, 112 ) as datetime ) )
Select @sDateFin	= Convert(Varchar(10),@dtDateFin, 103)+ ' ' + Convert ( Varchar( 8 ),@dtDateFin, 114)

Select  s.modl_port,
	'Pris en charge entre le ' + @sDateDeb + ' et le ' + @sDateFin as 'période',
	count(*) 'Nbre'
From   	sysadm.sinistre s,
	sysadm.detail d, -- [I027] Correction sysadm + date ISO
	sysadm.div_det dd, -- [I027] Correction sysadm + date ISO
	sysadm.det_pro dp -- [I027] Correction sysadm + date ISO
Where   dp.id_code_dp = 94
And 	sysadm.FN_CLE_VAL ( 'COD_DW', dp.val_car , ';') = 'DCMP080887_STAT_HEBDO_IPHONE'
And     s.id_prod = dp.id_prod
And     s.marq_port = 'APPLE'
And     s.modl_port in ( 'IPHONE3G/8GB', 'IPHONE3G/16GB', 'IPHONE3G/16GBBLANC', 'IPHONE3GS/16GB', 'IPHONE3GS/16GBBLANC', 'IPHONE3GS/32GB', 'IPHONE3GS/32GBBLANC' )
and     d.id_sin = s.id_sin
and 	d.cod_etat in ( 100, 600, 500 )
and     dd.id_sin = d.id_sin
and     dd.id_gti = d.id_gti
and     dd.id_detail = d.id_detail
and     dd.nom_zone = 'pec'
and     dd.val_car = 'O'
-- [I027] Correction sysadm + date ISO
--and     dd.maj_le between @sDateDeb + ' 00:00:00' and @sDateFin + ' 23:59:59'
and     dd.maj_le between @dtDateDeb and @dtDateFin
Group by s.modl_port

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S09_080887_IPHONE_MAIL
-- Auteur               :       JFF
-- Date                 :       07/01/2009
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [DCMP080887]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S09_080887_IPHONE_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S09_080887_IPHONE_MAIL
GO

CREATE procedure sysadm.PS_S09_080887_IPHONE_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_DCMP080887_IPHONE\'
Set @sFileName	= 'Export_DCMP080887_IPHONE'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S09_080887_IPHONE ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S09_080887_IPHONE ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = 'Prise en charge des IPHONE sur la semaine passé'
set @sMessage  = 'Veuillez trouver ci-joint l''extraction des prises en charge des IPHONE sur la semaine passée.'

if @iRetOsql <> 0
BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DES.'
END

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'stephan.madoyan@evodial.fr,ohavard@spb.eu,ndanna@spb.fr',
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL


Go

grant execute on sysadm.PS_S09_080887_IPHONE_MAIL to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procédure            :       PS_S10_FNAC_EPT_ATTITUDE
-- Auteur               :       JFF
-- Date                 :       08/04/2009
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [FNAC_EPT]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S10_FNAC_EPT_ATTITUDE' AND type = 'P' )
        DROP procedure sysadm.PS_S10_FNAC_EPT_ATTITUDE
GO

CREATE procedure sysadm.PS_S10_FNAC_EPT_ATTITUDE
AS

Declare @sDateDeb Varchar ( 20 ) -- Format Date de présentation
Declare @sDateFin Varchar ( 20 ) -- Format Date de présentation
-- [I027] Correction sysadm + date ISO
Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @dtToday datetime

Select @dtToday		= getdate()

Select @dtDateDeb	= Convert(Varchar (8), DateAdd ( week, -1, @dtToday) , 112 )
Select @sDateDeb	= Convert(Varchar(10),@dtDateDeb, 103)+ ' ' + Convert ( Varchar( 8 ),@dtDateDeb, 114)
Select @dtDateFin	= DateAdd ( ss , -1, cast (Convert(VarChar (8), @dtToday, 112 ) as datetime ) )
Select @sDateFin	= Convert(Varchar(10),@dtDateFin, 103)+ ' ' + Convert ( Varchar( 8 ),@dtDateFin, 114)

Select  ('Réglé entre le ' + @sDateDeb + ' et le ' + @sDateFin)  as 'période',

	s.id_sin 'num_sinistre',
	p.nom 'nom',
	p.prenom 'prenom',	
	
	IsNull ( 
	( Select top 1 IsNull ( dd2.val_car, '' )
	  From 	 sysadm.detail d,
		 sysadm.div_det dd,
		 sysadm.div_det dd2
	  Where  d.id_sin = s.id_sin
	  And    d.cod_etat in ( 500, 600)
	  And    dd.id_sin = d.id_sin
	  And    dd.id_gti = d.id_gti
	  And    dd.id_detail = d.id_detail
	  And    dd.nom_zone = 'fnc_mt_ticket'
	  And    dd.val_mt > 0 
	  And    dd2.id_sin = dd.id_sin
	  And    dd2.id_gti = dd.id_gti
	  And    dd2.id_detail = dd.id_detail
	  And    dd2.nom_zone = 'fnc_mag' )
	  ,'') 'Code_UG_Magasin',

	IsNull ( 
	( Select top 1 IsNull ( IsNull( Convert( VarChar ( 10) , dd2.val_dte, 103 ), '' ) + ' ' + IsNull ( dd3.val_car, '' ), '' )
	  From 	 sysadm.detail d,
		 sysadm.div_det dd,
		 sysadm.div_det dd2,
		 sysadm.div_det dd3		 
	  Where  d.id_sin = s.id_sin
	  And    d.cod_etat in ( 500, 600)
	  And    dd.id_sin = d.id_sin
	  And    dd.id_gti = d.id_gti
	  And    dd.id_detail = d.id_detail
	  And    dd.nom_zone = 'fnc_mt_ticket'
	  And    dd.val_mt > 0 
	  And    dd2.id_sin = dd.id_sin
	  And    dd2.id_gti = dd.id_gti
	  And    dd2.id_detail = dd.id_detail
	  And    dd2.nom_zone = 'fnc_dte_ticket'	  
	  And    dd3.id_sin = dd.id_sin
	  And    dd3.id_gti = dd.id_gti
	  And    dd3.id_detail = dd.id_detail
	  And    dd3.nom_zone = 'fnc_heu_ticket' ) 
	  ,'') 'Date_Heure_Ticket',

	IsNull ( 
	( Select top 1 IsNull ( dd2.val_car, '' )
	  From 	 sysadm.detail d,
		 sysadm.div_det dd,
		 sysadm.div_det dd2		 
	  Where  d.id_sin = s.id_sin
	  And    d.cod_etat in ( 500, 600)
	  And    dd.id_sin = d.id_sin
	  And    dd.id_gti = d.id_gti
	  And    dd.id_detail = d.id_detail
	  And    dd.nom_zone = 'fnc_mt_ticket'
	  And    dd.val_mt > 0 
	  And    dd2.id_sin = dd.id_sin
	  And    dd2.id_gti = dd.id_gti
	  And    dd2.id_detail = dd.id_detail
	  And    dd2.nom_zone = 'fnc_caisse') 
	  ,'') 'fnc_caisse',

	IsNull ( 
	( Select top 1 IsNull ( dd2.val_car, '' )
	  From 	 sysadm.detail d,
		 sysadm.div_det dd,
		 sysadm.div_det dd2		 
	  Where  d.id_sin = s.id_sin
	  And    d.cod_etat in ( 500, 600)
	  And    dd.id_sin = d.id_sin
	  And    dd.id_gti = d.id_gti
	  And    dd.id_detail = d.id_detail
	  And    dd.nom_zone = 'fnc_mt_ticket'
	  And    dd.val_mt > 0 
	  And    dd2.id_sin = dd.id_sin
	  And    dd2.id_gti = dd.id_gti
	  And    dd2.id_detail = dd.id_detail
	  And    dd2.nom_zone = 'fnc_ticket' ) 
	  ,'') 'Num_Ticket',
	  
	IsNull ( 
	( Select top 1 IsNull ( dd2.val_mt, 0 )
	  From 	 sysadm.detail d,
		 sysadm.div_det dd,
		 sysadm.div_det dd2
	  Where  d.id_sin = s.id_sin
	  And    d.cod_etat in ( 500, 600)
	  And    dd.id_sin = d.id_sin
	  And    dd.id_gti = d.id_gti
	  And    dd.id_detail = d.id_detail
	  And    dd.nom_zone = 'fnc_mt_ticket'
	  And    dd.val_mt > 0 
	  And    dd2.id_sin = dd.id_sin
	  And    dd2.id_gti = dd.id_gti
	  And    dd2.id_detail = dd.id_detail
	  And    dd2.nom_zone = 'fnc_mt_ticket'	) 
	  ,0 ) 'Montant_Ticket',  
	  
	IsNull ( 
	( Select top 1 IsNull ( dd2.val_car, '' )
	  From 	 sysadm.detail d,
		 sysadm.div_det dd,
		 sysadm.div_det dd2
	  Where  d.id_sin = s.id_sin
	  And    d.cod_etat in ( 500, 600)
	  And    dd.id_sin = d.id_sin
	  And    dd.id_gti = d.id_gti
	  And    dd.id_detail = d.id_detail
	  And    dd.nom_zone = 'fnc_mt_ticket'
	  And    dd.val_mt > 0 
	  And    dd2.id_sin = dd.id_sin
	  And    dd2.id_gti = dd.id_gti
	  And    dd2.id_detail = dd.id_detail
	  And    dd2.nom_zone = 'fnc_marq_modl' ) 
	  ,'') 'Marque_Modele',
	  
	IsNull ( 
	( Select top 1 IsNull ( dff.lst_fact, '' )
	  From   sysadm.det_fact_fnac dff,
	  	 sysadm.detail d,
	  	 sysadm.div_det dd,
	  	 sysadm.commande c
	  Where  d.id_sin = s.id_sin
	  And    d.cod_etat in ( 500, 600)
	  And    dd.id_sin = d.id_sin
	  And    dd.id_gti = d.id_gti
	  And    dd.id_detail = d.id_detail
	  And    dd.nom_zone = 'fnc_mt_ticket'
	  And    dd.val_mt > 0 
	  And    c.id_sin = d.id_sin
	  And    c.id_gti = d.id_gti
	  And    c.id_detail = d.id_detail
	  And	 dff.id_sin = c.id_sin
	  And    dff.id_seq = c.id_seq ) 
	  ,'') 'Liste_Factures',

	IsNull ( 
	( Select Top 1 IsNull ( dff.lst_article, '' )
	  From   sysadm.det_fact_fnac dff,
	  	 sysadm.detail d,
	  	 sysadm.div_det dd,
	  	 sysadm.commande c
	  Where  d.id_sin = s.id_sin
	  And    d.cod_etat in ( 500, 600)
	  And    dd.id_sin = d.id_sin
	  And    dd.id_gti = d.id_gti
	  And    dd.id_detail = d.id_detail
	  And    dd.nom_zone = 'fnc_mt_ticket'
	  And    dd.val_mt > 0 
	  And    c.id_sin = d.id_sin
	  And    c.id_gti = d.id_gti
	  And    c.id_detail = d.id_detail
	  And	 dff.id_sin = c.id_sin
	  And    dff.id_seq = c.id_seq ) 
	  ,'') 'Liste_Articles'
	  
	
From   	sysadm.sinistre s,
	sysadm.det_pro dp,
	sysadm.reglement r,
	sysadm.personne p
	
Where   dp.id_code_dp = 94
And 	sysadm.FN_CLE_VAL ( 'COD_DW', dp.val_car , ';') = 'STAT_HEBDO_FNAC_ATTITUDE'
And     s.id_prod = dp.id_prod
And     s.cod_etat = 600
And     r.id_sin = s.id_sin
And     r.id_reg = ( Select max ( r2.id_reg )
		     From sysadm.reglement r2 -- [I027] Correction sysadm + date ISO
		     Where r2.id_sin = r.id_sin
		     And   r2.cod_mot_reg = 'RN' )
And     r.dte_reg between @dtDateDeb and @dtDateFin
And     p.id_ordre = s.id_ordre


Union all
Select  'Refusé entre le ' + @sDateDeb + ' et le ' + @sDateFin as 'période',

	s.id_sin 'num_sinistre',
	p.nom 'nom',
	p.prenom 'prenom',	

	'',
	'',
	'',
	'',
	0,
	'',
	'',
	''

	
From   	sysadm.sinistre s,
	sysadm.det_pro dp,
	sysadm.personne p
Where   dp.id_code_dp = 94
And 	sysadm.FN_CLE_VAL ( 'COD_DW', dp.val_car , ';') = 'STAT_HEBDO_FNAC_ATTITUDE'
And     s.id_prod = dp.id_prod
and 	s.cod_etat in ( 200 )
and     s.valide_le between @dtDateDeb and @dtDateFin
And     p.id_ordre = s.id_ordre

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S10_FNAC_EPT_ATTITUDE_MAIL 
-- Auteur               :       JFF
-- Date                 :       08/04/2009
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [FNAC_EPT]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- 25/06/2012	FPI	ITSM 119188 - sml.spb.fr -> fra@spb.eu,vsa@spb.eu
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S10_FNAC_EPT_ATTITUDE_MAIL ' AND type = 'P' )
        DROP procedure sysadm.PS_S10_FNAC_EPT_ATTITUDE_MAIL 
GO

CREATE procedure sysadm.PS_S10_FNAC_EPT_ATTITUDE_MAIL 
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_FnacAttitude\'
Set @sFileName	= 'Export_FnacAttitude'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			"SIMPA2_PRO.sysadm.PS_S10_FNAC_EPT_ATTITUDE " + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			"SIMPA2_TRT.sysadm.PS_S10_FNAC_EPT_ATTITUDE " + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = "Extraction SPB : Règlements et refus de la semaine passée"
set @sMessage  = "Veuillez trouver ci-joint l'extraction des règlements et refus de la semaine passée."

if @iRetOsql <> 0
 BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DES.'
	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'jff@spb.fr,sml@spb.fr',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL
 END
Else
 Begin
	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'fra@spb.eu,vsa@spb.eu,coordinateurs.technique@fnac.tm.fr,responsables.plateau@fnac.tm.fr,icherfils@spb.fr',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL
 End

Go

grant execute on sysadm.PS_S10_FNAC_EPT_ATTITUDE_MAIL to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procédure            :       PS_S11_BVIOX_REGLE 
-- Auteur               :       FPI
-- Date                 :       27/04/2009
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [DCMP090118]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- 19/05/2009	FPI	[DCMP090280] Ajout du paramètre fournisseur
-- 19/09/2011   JFF     [PM82][LOT2]
-- 21/05/2015   JFF     [VDOC17414]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S11_BVIOX_REGLE ' AND type = 'P' )
        DROP procedure sysadm.PS_S11_BVIOX_REGLE 
GO

CREATE procedure sysadm.PS_S11_BVIOX_REGLE 
	@sIdFour	Varchar(3)
AS

Declare @sDateDeb Varchar ( 20 )
Declare @sDateFin Varchar ( 20 )
Declare @dtDateDeb datetime -- [I027] Correction sysadm + Date ISO
Declare @dtDateFin datetime -- [I027] Correction sysadm + Date ISO
Declare @dtToday datetime -- [I027] Correction sysadm + Date ISO

/* [DCMP090280] Modification de la tranche de dates 
Select @sDateDeb = Convert ( Varchar( 10 ), DateAdd ( day, -1, getdate()) , 103 )
Select @sDateFin = @sDateDeb*/

-- [I027] Correction sysadm + Date ISO
--Select @sDateDeb = Convert ( Varchar( 10 ), DateAdd ( week, -1, getdate()) , 103 )
--Select @sDateFin = Convert ( VarChar ( 10), DateAdd ( day, -1, Convert ( Varchar( 10 ), DateAdd ( week, 1, convert ( Datetime , @sDateDeb )) , 103 ) ), 103 )
--Set @sDateDeb = @sDateDeb + ' 0:00'
--Set @sDateFin = @sDateFin + ' 23:59'

Select @dtToday		= getdate()

Select @dtDateDeb	= Convert(Varchar (8), DateAdd ( week, -1, @dtToday) , 112 )
Select @sDateDeb	= Convert(Varchar(10),@dtDateDeb, 103)+ ' ' + Convert ( Varchar( 8 ),@dtDateDeb, 114)
Select @dtDateFin	= DateAdd ( ss , -1, cast (Convert(VarChar (8), @dtToday, 112 ) as datetime ) )
Select @sDateFin	= Convert(Varchar(10),@dtDateFin, 103)+ ' ' + Convert ( Varchar( 8 ),@dtDateFin, 114)

select  c.id_sin, 
	c.id_seq,
	c.id_four,
	sysadm.FN_CODE_CAR(c.id_four,'-FR') as lib_four
from 	sysadm.commande c, 
	sysadm.reglement r,
	sysadm.div_det d
where   r.dte_reg between @dtDateDeb and @dtDateFin
And	c.id_sin = r.id_sin
and 	c.id_typ_art='PRS' 
and 	c.status_gc=21
and 	CharIndex('[BVIEOX]',c.comment_frn) > 0 
and 	d.id_sin = c.id_sin
And	d.id_gti = c.id_gti
And	d.id_detail = c.id_detail
and 	d.nom_zone= 'accord_rempl' 
and 	d.val_nbre > 0  -- [VDOC17414]
and 	c.id_four = @sIdFour
and     Upper ( sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', rtrim ( c.info_spb_frn_cplt), ';' )) <> 'OUI' -- [PM82][LOT2]
UNION all
select  c.id_sin, 
	c.id_seq,
	c.id_four,
	sysadm.FN_CODE_CAR(c.id_four,'-FR') as lib_four
from 	sysadm.commande c,
	sysadm.commande c1,
	sysadm.div_det d
where 	c1.id_typ_art = 'TEL'
And 	c1.valide_le between @dtDateDeb and @dtDateFin
And 	c.id_sin = c1.id_sin
And	c.id_typ_art='PRS' 
and 	c.status_gc=21
and 	CharIndex('[BVIEOX]',c.comment_frn) > 0 
and 	d.id_sin = c.id_sin
And	d.id_gti = c.id_gti
And	d.id_detail = c.id_detail
and 	d.nom_zone= 'accord_rempl' 
and 	d.val_nbre > 0 -- [VDOC17414]
and 	c.id_four = @sIdFour
and     Upper ( sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', rtrim ( c.info_spb_frn_cplt), ';' )) <> 'OUI' -- [PM82][LOT2]
Go 

--------------------------------------------------------------------
--
-- Procédure            :       PS_S11_BVIOX_REGLE_MAIL 
-- Auteur               :       FPI
-- Date                 :       27/04/2009
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [DCMP090118]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- 19/05/2009	FPI	[DCMP090280] Ajout du paramètre fournisseur dans PS_S03_EXTRACTION_REFUS_IRREPARABLE
--					---> refonte de la PS
-- 23/09/2009	FPI [DCMP090532] Ajout du fournisseur O2M
-- 14/12/2009	FPI [DMDI27314] Modification de destinataire anovo
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S11_BVIOX_REGLE_MAIL ' AND type = 'P' )
        DROP procedure sysadm.PS_S11_BVIOX_REGLE_MAIL 
GO

CREATE procedure sysadm.PS_S11_BVIOX_REGLE_MAIL 
AS

DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(4),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	
Declare @iCpt	int -- [DCMP090280]
DECLARE @sDebutCommande   VarChar(250),
		@sListeMails		VarChar(500)
		
-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_BVIOX_REGLE_DCMP090118\'
Set @sFileName	= 'Export_BVIOX_REGLE_DCMP090118_'
Set @sFileExt	= '.XLS'

--SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

Set @sObjet    = "Extraction SPB : Remplt/Règlt sur Irr. BVIEOX"
set @sMessage  = "Veuillez trouver ci-joint la liste des dossiers pour lesquels, à la suite d'une oxydation détectée, les téléphones peuvent être stockés dans les irréparables. Merci d'avance, cordialement."

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	SET @sDebutCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			"SIMPA2_PRO.sysadm.PS_S11_BVIOX_REGLE "
Else
   SET @sDebutCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			"SIMPA2_TRT.sysadm.PS_S11_BVIOX_REGLE "
			
Set @iCpt = 1
While @iCpt < 6
begin
	-- Affectation des variables
	IF @iCpt = -1 -- [VDOC4354] on shunt ANOVO
	begin
		SET @sCommande = @sDebutCommande + "'ANV'"
		--SET @sListeMails = 'svignal@anovo.com, suivi_prestataires@spb.fr'
		SET @sListeMails = 'Brive.SPB@anovo.com, suivi_prestataires@spb.fr' -- [DMDI27314]
		SET @sFicOut = @sPath + @sFileName + 'ANV' + @sFileExt
	End
	
	IF @iCpt = 2 
	begin
		SET @sCommande = @sDebutCommande + "'SBE'"
		SET @sListeMails = 'edi.informatique@sbe-online.com, saisie-sbe@sbe-online.com, pflahaut@sbe-online.com, rcuiburu@sbe-online.com, mdafonseca@sbe-online.com, mlgin@sbe-online.com, nbrassart@sbe-online.com, mprudhomme@sbe-online.com, suivi_prestataires@spb.fr'
		SET @sFicOut = @sPath + @sFileName + 'SBE' + @sFileExt
	End
	
	IF @iCpt = 3 
	begin
		SET @sCommande = @sDebutCommande + "'COR'"
		SET @sListeMails = 'spb@cordonweb.com, suivi_prestataires@spb.fr'
		SET @sFicOut = @sPath + @sFileName + 'COR' + @sFileExt
	End
	
	-- [DCMP090532]
	IF @iCpt = 4
	begin
		SET @sCommande = @sDebutCommande + "'O2M'"
		SET @sListeMails = 'oxydation@o2m.fr , suivi_prestataires@spb.fr'
		SET @sFicOut = @sPath + @sFileName + 'O2M' + + '.TXT' -- 06/10/2009 - FPI - old : @sFileExt
	End

	-- [PM200][PSM]
	IF @iCpt = 5 
	begin
		SET @sCommande = @sDebutCommande + "'PSM'"
		SET @sListeMails = 'spb@allopsm.fr, suivi_prestataires@spb.fr'
		SET @sFicOut = @sPath + @sFileName + 'PSM' + @sFileExt
	End

	-- Création du fichier
	Set @sCommande = @sCommande + '" /o' + @sFicOut + ' -w5000' + @sOsqlOption
	
	EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output
	
	if @iRetOsql <> 0
	BEGIN
		set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DES.'
	END

	-- Envoi du mail
	EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		@sListeMails, 
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL
		
	Set @iCpt = @iCpt + 1
end

Go

grant execute on sysadm.PS_S11_BVIOX_REGLE_MAIL to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procédure            : 	PS_S12_090200_LCL_HEBDO
-- Auteur               :       FPI
-- Date                 :       11/05/2009
-- Libellé              :       Extraction Hebdo LCL
-- Commentaires         :       
-- Références           :       [DCMP090200]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S12_090200_LCL_HEBDO' AND type = 'P' )
        DROP procedure sysadm.PS_S12_090200_LCL_HEBDO
GO

CREATE procedure sysadm.PS_S12_090200_LCL_HEBDO
AS


Select  s.id_sin,
	pe.nom,
	pe.prenom,
	s.dte_decl,
	s.dte_surv,
	s.cree_le,
	s.mt_reg,
	p.lib_long,
	Case s.cod_etat

		When 100 Then 	Case
					When
						(	Select Count(*) 
							From    sysadm.detail d,
								sysadm.div_det dd
							Where	d.id_sin = s.id_sin
							And     dd.id_sin = d.id_sin
							And     dd.id_gti = d.id_gti
							And     dd.id_detail = d.id_detail
							And     d.cod_etat = 100
							And     dd.nom_zone = 'pec'
							And     dd.val_car = 'O'
						) > 0 Then 'Pris en Charge'
					Else	sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' )
				End 
		Else sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' )
	End 'Etat_Dossier'

from	sysadm.produit p,
	sysadm.sinistre s,
	sysadm.personne pe
Where	p.cod_prod_dms = 358
And     s.id_prod = p.id_prod
and     pe.id_ordre = s.id_ordre
Order by s.dte_decl


Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S12_090200_LCL_HEBDO_MAIL
-- Auteur               :       FPI
-- Date                 :       11/05/2009
-- Libellé              :       Exécute PS_S12_090200_LCL_HEBDO et l'envoi par mail
-- Commentaires         :       
-- Références           :       [DCMP090200]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S12_090200_LCL_HEBDO_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S12_090200_LCL_HEBDO_MAIL
GO

CREATE procedure sysadm.PS_S12_090200_LCL_HEBDO_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Extraction_Hebdo_LCL_090200\'
Set @sFileName	= 'DCMP090200_HEBDO_LCL'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			"SIMPA2_PRO.sysadm.PS_S12_090200_LCL_HEBDO " + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			"SIMPA2_TRT.sysadm.PS_S12_090200_LCL_HEBDO " + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = "Extraction Hebdomadaire LCL DCMP090200"
set @sMessage  = "Veuillez trouver ci-joint l'extraction des sinistres déclarés depuis l'origine du produit 358."

if @iRetOsql <> 0
BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DES.'
END

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'GG_DDI-DTA-DSR@spb.eu',
		-- 'fguilbaud@spb.fr,edufresne@spb.fr,jpbequet@spb.fr,skrizez@spb.fr', -- FPI - 15/10/2009 - grp de diffusion
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL


Go

grant execute on sysadm.PS_S12_090200_LCL_HEBDO_MAIL to rolebddsinistres
go
--------------------------------------------------------------------
--
-- Procédure            : 		PS_S13_090623_CG13_HEBDO
-- Auteur               :       FPI
-- Date                 :       15/10/2009
-- Libellé              :       Extraction Hebdo CG13
-- Commentaires         :       
-- Références           :       [DCMP090623]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- 10/11/2009	FPI	[DCMP090676] Ajout des colonnes id_gti, motifs, no_serie & date de cloture
-- 21/03/2011	JFF	[VDOC3533] ajout tel et mail de l'assuré
-- 01/04/2011	JFF	[VDOC3685] ajout adresse de l'assuré pris de l'inter, vu avec F. Guilbaud
-- 06/10/2015	FPI [VDOC18841] Ajout de la date d'adhésion
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S13_090623_CG13_HEBDO' AND type = 'P' )
        DROP procedure sysadm.PS_S13_090623_CG13_HEBDO
GO

CREATE procedure [sysadm].[PS_S13_090623_CG13_HEBDO]
AS


Select  s.id_sin,
	pe.nom,
	pe.prenom,
	i.adr_1,
	i.adr_2,
	i.adr_cp,
	i.adr_ville,
	i.num_teld 'num_tel', -- [VDOC3533]
	i.adr_mail, -- [VDOC3533]
	s.num_imei_port,
	s.dte_decl,
	s.dte_surv,
	s.cree_le,
	s.mt_reg,
	p.lib_long,
	sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' ) 'Etat_Dossier',
	s.valide_le 'Date_cloture_info',
	(select min(dte_reg) from sysadm.reglement r where r.id_sin = s.id_sin and cod_mot_reg='RN') 'Date_1er_reg',
	IsNull ( Case s.alt_ssui When 'O' Then 'Oui' Else 'Non' End, 'Non' ) 'Dossier_sans_suite',
	Case s.cod_mot_ssui
		When 90 Then 'soldage automatique'
		Else sysadm.FN_CODE_NUM ( s.cod_mot_ssui, '-SS' )
	End 'Motif_Dos_sans_suite',
	Case gs.cod_etat
		When 100 Then 	Case
					When
						(	Select Count(*) 
							From    sysadm.detail d,
								sysadm.div_det dd
							Where	d.id_sin = s.id_sin
							And     dd.id_sin = d.id_sin
							And     dd.id_gti = d.id_gti
							And     dd.id_detail = d.id_detail
							And     d.cod_etat = 100
							And     dd.nom_zone = 'pec'
							And     dd.val_car = 'O'
						) > 0 Then 'Pris en Charge'
					Else	sysadm.FN_CODE_NUM ( gs.cod_etat, '-ET' )
				End 
		Else sysadm.FN_CODE_NUM ( gs.cod_etat, '-ET' )
	End 'Etat_Garantie',
	Case gs.alt_ssui 
		When 'O' Then 'Oui'
		Else 'Non'
	End 'Garantie_sans_suite',
	Case gs.cod_mot_ssui
		When 90 Then 'soldage automatique'
		Else sysadm.FN_CODE_NUM ( gs.cod_mot_ssui, '-SS' )
	End 'Motif_Gti_sans_suite',
	null 'Code_garantie',
	null 'Lib_gti_personnalise',
	null 'Motif du refus',
	null 'Refus machine',
	null 'Refus opérateur',
	null 'Apparaissant_sur_courrier',
	null 'Courrier_interlocuteur',
	convert(varchar(10),s.dte_adh,103) 'Date adhésion',
	1  as Tri

From	sysadm.produit p
	INNER JOIN sysadm.sinistre s ON s.id_prod = p.id_prod
	INNER JOIN sysadm.personne pe ON pe.id_ordre = s.id_ordre
	INNER JOIN sysadm.gar_sin gs ON gs.id_sin = s.id_sin
	INNER JOIN sysadm.inter i ON i.id_sin = s.id_sin AND i.cod_inter = 'A'
Where	p.cod_prod_dms = 379

Union all

Select  s.id_sin,
	'Motif de Refus >>>>>>>>>>>>>>',
	null,
	null,
	null,
	null,
	null,
	null,
	null,
	null,	
	s.dte_decl,
	null,
	null,
	null,
	null,
	null,
	null,
	null,
	null,
	null,
	null,
	null,
	null,
	r.id_gti 'Code_garantie',
	IsNull ( ( Select cg.lib_gti 
	  From	sysadm.code_garantie cg
	  Where cg.id_prod = p.id_prod
	  And   cg.id_gti  = r.id_gti
	       ), sysadm.FN_CODE_NUM ( r.id_gti, '-GA' ) ) 'Lib_gti_personnalise',
	sysadm.FN_CODE_NUM ( r.id_motif, '+RE' ) 'Motif du refus',
	Case r.alt_mac
		When 'O' Then 'Oui'
		Else 'Non'
	End 'Refus machine',
	Case r.alt_ope
		When 'O' Then 'Oui'
		Else 'Non'
	End 'Refus opérateur',
	Case 
		When r.id_i is null Then 'Non'
		Else 'Oui'
	End 'Apparaissant_sur_courrier',
	Case 
		When r.id_i is null Then null
		Else 	Convert ( VarChar ( 60 ) , ( Select '(' + rtrim ( sysadm.FN_CODE_CAR ( i.cod_inter, '-IN' ) ) + ') ' +
				 rtrim ( sysadm.FN_CODE_NUM ( i.cod_civ, '-CI' ) ) + ' ' + rtrim ( i.nom )
			  From  sysadm.inter i
			  Where i.id_sin = r.id_sin
			  And   i.id_i = r.id_i )
			)
	End 'Courrier_interlocuteur',
	convert(varchar(10),s.dte_adh,103) 'Date adhésion',
	2 as Tri
From	sysadm.produit p
	INNER JOIN sysadm.sinistre s ON s.id_prod = p.id_prod
	INNER JOIN sysadm.refus r ON r.id_sin = s.id_sin
Where	p.cod_prod_dms = 379
Order by s.dte_decl, s.id_sin, Tri

GO

grant execute on sysadm.PS_S13_090623_CG13_HEBDO to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S13_090623_CG13_HEBDO_MAIL
-- Auteur               :       FPI
-- Date                 :       15/10/2009
-- Libellé              :       Exécute PS_S13_090623_CG13_HEBDO et l'envoi par mail
-- Commentaires         :       
-- Références           :       [DCMP090623]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S13_090623_CG13_HEBDO_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S13_090623_CG13_HEBDO_MAIL
GO

CREATE procedure sysadm.PS_S13_090623_CG13_HEBDO_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_Hebdo_CG13_090623\'
Set @sFileName	= 'DCMP090623_HEBDO_CG13'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			"SIMPA2_PRO.sysadm.PS_S13_090623_CG13_HEBDO " + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			"SIMPA2_TRT.sysadm.PS_S13_090623_CG13_HEBDO " + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = "Extraction Hebdomadaire CG13 DCMP090623"
set @sMessage  = "Veuillez trouver ci-joint l'extraction des sinistres déclarés depuis l'origine du produit 379."

if @iRetOsql <> 0
BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DES.'
END
/* JFF le 06/02/12 : je génère à présent sur \\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_Hebdo_CG13_090623\ donc plus d'envoi par mail.
EXEC master.dbo.SPB_PS_MAIL_OUTLOOK 
		@sRetourErrMail OUTPUT, 
		--'GG_DDI-DTA-RP_Coll@spb.eu,GG_DDI-DTA-RP_Resp@spb.eu', -- [ITSM68110] - changement de nom
		'GG_DDI-DTA-DSR@spb.eu',
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL
*/

Go

grant execute on sysadm.PS_S13_090623_CG13_HEBDO_MAIL to rolebddsinistres
go
--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S17_FOUR_FACTU
-- Auteur               :       FPI
-- Date                 :       27/10/2009
-- Libellé              :       
-- Commentaires         :       Liste des fournisseurs
-- Références           :       [DCMP090648]
--
-- Arguments            :       Aucun
--                              
-- Retourne             :       Rien
-------------------------------------------------------------------
-- #1	FPI	[20100212.FPI] Ajout des libellés des fournisseurs
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S17_FOUR_FACTU' AND type = 'P' )
       DROP procedure sysadm.DW_S17_FOUR_FACTU
GO

CREATE procedure sysadm.DW_S17_FOUR_FACTU
AS

select  a.id_bq as code_four_factu,
  	c2.lib_code as lib_four_factu,	-- #1
	a.id_ag as code_four_edi,
  	c.lib_code as lib_four_edi,	-- #1
	a.adr_1,                               
	a.adr_2,
	a.adr_cp,
	a.adr_ville,
	a.lib_ag as nom,
	a.cree_le,
	a.maj_par
from   agence a, code_car c, 
	code_car c2 -- #1
where  a.id_ag = c.id_code
and 	a.id_bq = c2.id_code -- #1
and    c2.id_typ_code  = '-FR' -- #1
and    c.id_typ_code  = '-FR'
order by a.cree_le desc

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_RELANCE_BOUTIQUE_BROKER
-- Auteur               :       FPI
-- Date                 :       21/01/2010
-- Libellé              :       
-- Commentaires         :       [O2M_DIAG_NOMADE].Lot2.JFF
-- Références           :       
--
-- Arguments            :       Aucun
--                              
-- Retourne             :       Rien
-------------------------------------------------------------------
-- FPI - 11/08/2010 [PM01] Ajout de 1502
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_RELANCE_BOUTIQUE_BROKER' AND type = 'P' )
       DROP procedure sysadm.DW_S01_RELANCE_BOUTIQUE_BROKER
GO

CREATE procedure sysadm.DW_S01_RELANCE_BOUTIQUE_BROKER
AS

Select  'RELANCE : Notre broker est toujours en attente de votre part des appareils suivant, merci de les lui envoyer au plus vite.' 'Message',
	convert ( varchar ( 100 ), sysadm.FN_CLE_VAL ( 'MAIL_BTQ_REL', rtrim  ( c.info_spb_frn_cplt), ';' )) 'mail_boutique', 
	c.id_sin 'Dos_Sinistre',
	c.id_seq 'Seq_Cmde',
	s.marq_port 'Marque_app_sin',
	s.modl_port 'Modl_app_sin',
	sysadm.FN_CODE_CAR ( d.val_car, '-AR') 'Type_App', 
	c.cree_le 'Presta_Cree_le',
	c.adr_nom 'Nom_Assure',
	c.adr_prenom 'Prenom_ass', 
	c.adr_livr1 'Adresse_1',
	c.adr_livr2 'Adresse_2',
	c.adr_cp 'Adr_CP',
	c.adr_ville 'Adr_Ville',                          
	c.adr_tel1 'Adr_Tel1', 
	c.id_serie_anc 'Numero_serie'
	
from 	sysadm.commande c,
	sysadm.sinistre s,
	sysadm.div_sin d

where c.info_spb_frn in (435,1502) -- [PM01] Ajout de 1502
and   s.id_sin = c.id_sin
and   d.id_sin = c.id_sin
and   d.nom_zone = 'type_app'
and   c.status_gc <> 166

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S02_RELANCE_BOUTIQUE_BROKER
-- Auteur               :       FPI
-- Date                 :       11/08/2010 
-- Libellé              :       
-- Commentaires         :       [PM01]
-- Références           :       
--
-- Arguments            :       Aucun
--                              
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_RELANCE_BOUTIQUE_BROKER' AND type = 'P' )
       DROP procedure sysadm.DW_S02_RELANCE_BOUTIQUE_BROKER
GO

CREATE procedure sysadm.DW_S02_RELANCE_BOUTIQUE_BROKER
AS

Select  'RELANCE : Matériel non encore récupéré par O2M, merci à O2M de le récupérer au plus vite.' 'Message',
	c.id_sin 'Dos_Sinistre',
	c.id_seq 'Seq_Cmde',
	s.marq_port 'Marque_app_sin',
	s.modl_port 'Modl_app_sin',
	sysadm.FN_CODE_CAR ( d.val_car, '-AR') 'Type_App', 
	c.cree_le 'Presta_Cree_le',
	c.adr_nom 'Nom_Assure',
	c.adr_prenom 'Prenom_ass', 
	c.adr_livr1 'Adresse_1',
	c.adr_livr2 'Adresse_2',
	c.adr_cp 'Adr_CP',
	c.adr_ville 'Adr_Ville',                          
	c.adr_tel1 'Adr_Tel1', 
	c.id_serie_anc 'Numero_serie',
	b.cod_mag 'Code_Boutique',
	b.adr_1	 'Adr_1_Boutique',
	b.adr_2	 'Adr_2_Boutique',	
	b.adr_cp 'Adr_Cp_Boutique',	
	b.adr_ville  'Adr_Ville_Boutique',	
	b.adr_tel 'Tel_Boutique'
from 	sysadm.commande c,
	sysadm.sinistre s,
	sysadm.div_sin d,
	sysadm.boutique b
where c.info_spb_frn in (1503, 1505) 
and   s.id_sin = c.id_sin
and   d.id_sin = c.id_sin
and   b.id_prod = s.id_prod
and   b.id_boutique = s.id_orian_boutique
and   d.nom_zone = 'type_app'
and   c.status_gc not in (167, 168 ) 
and not exists (select id_prod from det_pro dp where dp.id_prod=s.id_prod and dp.id_code_dp=143)
Union
Select  'RELANCE : Matériel non encore récupéré par O2M, merci à O2M de le récupérer au plus vite.' 'Message',
	c.id_sin 'Dos_Sinistre',
	c.id_seq 'Seq_Cmde',
	s.marq_port 'Marque_app_sin',
	s.modl_port 'Modl_app_sin',
	sysadm.FN_CODE_CAR ( d.val_car, '-AR') 'Type_App', 
	c.cree_le 'Presta_Cree_le',
	c.adr_nom 'Nom_Assure',
	c.adr_prenom 'Prenom_ass', 
	c.adr_livr1 'Adresse_1',
	c.adr_livr2 'Adresse_2',
	c.adr_cp 'Adr_CP',
	c.adr_ville 'Adr_Ville',                          
	c.adr_tel1 'Adr_Tel1', 
	c.id_serie_anc 'Numero_serie',
	sysadm.FN_CLE_VAL('COD_MAG',dp.val_car,';') 'Code_Boutique',
	sysadm.FN_CLE_VAL('ADR_1_MAG',dp.val_car,';') 'Adr_1_Boutique',
	sysadm.FN_CLE_VAL('ADR_2_MAG',dp.val_car,';') 'Adr_2_Boutique',	
	sysadm.FN_CLE_VAL('ADR_CP_MAG',dp.val_car,';') 'Adr_Cp_Boutique',	
	sysadm.FN_CLE_VAL('ADR_VILLE_MAG',dp.val_car,';') 'Adr_Ville_Boutique',	
	sysadm.FN_CLE_VAL('ADR_TEL_MAG',dp.val_car,';') 'Tel_Boutique'
from 	sysadm.commande c,
	sysadm.sinistre s,
	sysadm.div_sin d,
	sysadm.det_pro dp
where c.info_spb_frn in (1503, 1505) 
and   s.id_sin = c.id_sin
and   d.id_sin = c.id_sin
and   d.nom_zone = 'type_app'
and   c.status_gc not in (167, 168 ) 
and   dp.id_prod=s.id_prod 
and   dp.id_code_dp=143

Go

--------------------------------------------------------------------
--
-- Procédure            : 	PS_S13_100375_ASS_TOUS_MOBILES
-- Auteur               :       FPI
-- Date                 :       17/05/2010
-- Libellé              :       Extraction Hebdo ASS_TOUS_MOBILES
-- Commentaires         :       
-- Références           :       [DCMP100375]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S13_100375_ASS_TOUS_MOBILES' AND type = 'P' )
        DROP procedure sysadm.PS_S13_100375_ASS_TOUS_MOBILES
GO

CREATE procedure sysadm.PS_S13_100375_ASS_TOUS_MOBILES
AS


Select  s.id_sin,
	pe.nom,
	pe.prenom,
	s.dte_decl,
	s.dte_surv,
	s.cree_le,
	s.mt_reg,
	p.lib_long,
	Case s.cod_etat

		When 100 Then 	Case
					When
						(	Select Count(*) 
							From    sysadm.detail d,
								sysadm.div_det dd
							Where	d.id_sin = s.id_sin
							And     dd.id_sin = d.id_sin
							And     dd.id_gti = d.id_gti
							And     dd.id_detail = d.id_detail
							And     d.cod_etat = 100
							And     dd.nom_zone = 'pec'
							And     dd.val_car = 'O'
						) > 0 Then 'Pris en Charge'
					Else	sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' )
				End 
		Else sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' )
	End 'Etat_Dossier'

from	sysadm.produit p,
	sysadm.sinistre s,
	sysadm.personne pe
Where	p.cod_prod_dms = 805
And     s.id_prod = p.id_prod
and     pe.id_ordre = s.id_ordre
Order by s.dte_decl


Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S13_100375_ASS_TOUS_MOBILES_MAIL
-- Auteur               :       FPI
-- Date                 :       17/05/2010
-- Libellé              :       Exécute PS_S13_100375_ASS_TOUS_MOBILES et l'envoi par mail
-- Commentaires         :       
-- Références           :       [DCMP100375]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S13_100375_ASS_TOUS_MOBILES_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S13_100375_ASS_TOUS_MOBILES_MAIL
GO

CREATE procedure sysadm.PS_S13_100375_ASS_TOUS_MOBILES_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Extraction_Hebdo_ASS_TOUS_MOBILES_100375\'
Set @sFileName	= 'DCMP100375_ASS_TOUS_MOBILES'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S13_100375_ASS_TOUS_MOBILES ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S13_100375_ASS_TOUS_MOBILES ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

/*
Set @sObjet    = 'Extraction Hebdomadaire Ass. Tous mobiles DCMP100375'
set @sMessage  = 'Veuillez trouver ci-joint l''extraction des sinistres déclarés depuis l''origine du produit 805.'

if @iRetOsql <> 0
BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DES.'
END

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'GG_DDI-DTA-RP_Coll@spb.eu,GG_DDI-DTA-RP_Resp@spb.eu',
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL

*/
Go

grant execute on sysadm.PS_S13_100375_ASS_TOUS_MOBILES_MAIL to rolebddsinistres
go
--------------------------------------------------------------------
--
-- Procédure            :       PS_S14_MCM_REGLE 
-- Auteur               :       FPI
-- Date                 :       28/06/2011
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [PC175]
--				PC 175 Lot 1 – PC 418 Lot 1  – PC 419 Lot 1  – PC 439 Lot 1 – PC 440 Lot 1  – PC 491 Lot 1 – PC 492 Lot 1
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- 	13/01/2012	FPI	PC 418-1 & 419-1 - Extension aux produits -> 30336
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S14_MCM_REGLE ' AND type = 'P' )
        DROP procedure sysadm.PS_S14_MCM_REGLE 
GO

CREATE procedure sysadm.PS_S14_MCM_REGLE 
AS

SET NOCOUNT ON

Declare @sDateDeb Varchar ( 20 )
Declare @sDateFin Varchar ( 20 )

Select @sDateDeb = Convert ( Varchar( 10 ), DateAdd ( day, -1, getdate()) , 112 )

Set @sDateFin = @sDateDeb + ' 23:59'
Set @sDateDeb = @sDateDeb + ' 00:00'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
  select s.id_sin 'NUM_SIN', 
	Rtrim(s.id_contrat_abonne) 'ID_MCM',
	Rtrim(sysadm.FN_LIB_PROD(s.id_prod)) 'NOM_PROD',
	Rtrim(b.cod_mag) 'COD_MAG',
	convert(varchar(4),DATEPART(year,s.dte_decl)) + RIGHT('0' + Convert(varchar(2),DATEPART(month,s.dte_decl)),2) + RIGHT('0' + Convert(varchar(2),DATEPART(day,s.dte_decl)),2) 'DTE_DECL',
	Rtrim(p.nom) 'NOM',
	Rtrim(p.prenom) 'PRENOM',
	Rtrim(Isnull(i.num_teld,'')) 'ADR_TEL1', 
	Rtrim(Isnull(i.num_telb,'')) 'ADR_TEL2', 
	Rtrim(Isnull(i.num_fax,'')) 'ADR_TEL3', 
	Rtrim(Isnull(i.adr_mail,'')) 'ADR_MAIL',
	Rtrim(s.marq_port) 'MARQ_APP',
	Rtrim(s.modl_port) 'MODL_APP',
	Rtrim(s.num_imei_port) 'NUM_SERIE',
	Rtrim(o.nom) 'NOM_GEST',
	g.id_gti 'GARANTIE',
	convert(varchar(4),DATEPART(year,r.dte_reg)) + RIGHT('0' + Convert(varchar(2),DATEPART(month,r.dte_reg)),2) + + RIGHT('0' + Convert(varchar(2),DATEPART(day,r.dte_reg)),2) 'DATE_REG',
	r.mt_tot_reg 'MT_REG'
  from sysadm.sinistre s
	inner join sysadm.boutique b on b.id_prod=s.id_prod and b.id_boutique=s.id_orian_boutique
	inner join sysadm.personne p on p.id_ordre=s.id_ordre
	inner join sysadm.inter i on i.id_sin=s.id_sin
	inner join SESAME_PRO.sysadm.operateur o on o.id_oper=s.maj_par
	inner join sysadm.gar_sin g on g.id_sin=s.id_sin
	inner join reglement r on s.id_sin=r.id_sin and r.id_i=i.id_i
  where i.cod_inter='A'
	and s.id_prod between 30300 and 30336
	and r.cree_le between @sDateDeb and @sDateFin 

Else
  select s.id_sin 'NUM_SIN', 
	Rtrim(s.id_contrat_abonne) 'ID_MCM',
	Rtrim(sysadm.FN_LIB_PROD(s.id_prod)) 'NOM_PROD',
	Rtrim(b.cod_mag) 'COD_MAG',
	convert(varchar(4),DATEPART(year,s.dte_decl)) + RIGHT('0' + Convert(varchar(2),DATEPART(month,s.dte_decl)),2) + + RIGHT('0' + Convert(varchar(2),DATEPART(day,s.dte_decl)),2) 'DTE_DECL',
	Rtrim(p.nom) 'NOM',
	Rtrim(p.prenom) 'PRENOM',
	Rtrim(Isnull(i.num_teld,'')) 'ADR_TEL1', 
	Rtrim(Isnull(i.num_telb,'')) 'ADR_TEL2', 
	Rtrim(Isnull(i.num_fax,'')) 'ADR_TEL3', 
	Rtrim(Isnull(i.adr_mail,'')) 'ADR_MAIL',
	Rtrim(s.marq_port) 'MARQ_APP',
	Rtrim(s.modl_port) 'MODL_APP',
	Rtrim(s.num_imei_port) 'NUM_SERIE',
	Rtrim(o.nom) 'NOM_GEST',
	g.id_gti 'GARANTIE',
	convert(varchar(4),DATEPART(year,r.dte_reg)) + RIGHT('0' + Convert(varchar(2),DATEPART(month,r.dte_reg)),2) + + RIGHT('0' + Convert(varchar(2),DATEPART(day,r.dte_reg)),2) 'DATE_REG',
	r.mt_tot_reg 'MT_REG'
  from sysadm.sinistre s
	inner join sysadm.boutique b on b.id_prod=s.id_prod and b.id_boutique=s.id_orian_boutique
	inner join sysadm.personne p on p.id_ordre=s.id_ordre
	inner join sysadm.inter i on i.id_sin=s.id_sin
	inner join SESAME_SIM.sysadm.operateur o on o.id_oper=s.maj_par
	inner join sysadm.gar_sin g on g.id_sin=s.id_sin
	inner join reglement r on s.id_sin=r.id_sin and r.id_i=i.id_i
  where i.cod_inter='A'
	and s.id_prod between 30300 and 30336
	and r.cree_le between @sDateDeb and @sDateFin 

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S14_MCM_REGLE_CSV
-- Auteur               :       FPI
-- Date                 :       28/06/2011
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [PC175]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S14_MCM_REGLE_CSV ' AND type = 'P' )
        DROP procedure sysadm.PS_S14_MCM_REGLE_CSV 
GO

CREATE procedure sysadm.PS_S14_MCM_REGLE_CSV 
AS
Declare @sFicOut     VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@sCommande VarChar(255),
	@iRetOsql	int

Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_Micromania\' -- [I027] Implémentation des Chemins relatifs
Set @sFileName	= 'sinistresregles' + convert(varchar(4),DATEPART(year,getdate())) + 
	RIGHT('0' + convert(varchar(2),DATEPART(month,getdate())),2) +
	RIGHT('0' + convert(varchar(2),DATEPART(day,getdate())),2) 
Set @sFileName = @sFileName + RIGHT('0' + convert(varchar(2),DATEPART(hour,getdate())),2) + 
	RIGHT('0' + convert(varchar(2),DATEPART(minute,getdate())),2) + 
	RIGHT('0' + convert(varchar(2),DATEPART(second,getdate())),2) 
Set @sFileExt	= 'csv'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode
-- -h-1 => pas d'entete
-- -d => indique la base

Set @sOsqlOption = ' ' + '/s";"'+ ' /b' + ' /u -h-1 ' + '-d' + db_name()

-- [I027] Remplacement d'osql - les options sont identiques. Ajout de -W : Remove Trailing Space
SET @sCommande = 	'sqlcmd.exe /S' + @sNomServeur + ' /E /Q"' + 
			'sysadm.PS_S14_MCM_REGLE ' + 
			'" /o' + @sFicOut + ' -w5000 -W ' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_DARTY_O2M
-- Auteur               :       JFF
-- Date                 :       25/04/2011
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [PC662]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_DARTY_O2M ' AND type = 'P' )
        DROP procedure sysadm.PS_S_DARTY_O2M 
GO

CREATE procedure sysadm.PS_S_DARTY_O2M 
AS

-- Commande
Select  Case c.id_four
			When 'O2M' Then 3
			Else 1 
		End 'Type_Operation',
		c.dte_env_cli 'Date_Heure',
		s.id_contrat_abonne 'Num_Vente_DARTY',
		s.num_imei_port 'Num_IMEI_Tel_Repris',
		c.id_serie_nouv 'Num_IMEI_Tel_Remis',
		c.id_marq_art 'Marque_Tel_Remis',
		c.id_modl_art 'Modele_Tel_Remis'

From   sysadm.sinistre s, 
	   sysadm.det_pro d,
	   sysadm.commande c
Where  d.id_code_dp = 94
And    sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( d.val_car), ';') = 'STAT_O2M_DARTY'
And	   s.id_sin = d.id_prod
And	   c.id_sin = s.id_sin
And    c.id_typ_art not in ( 'EDI', 'PRS' ) 
And	   c.dte_env_cli is not null
And	   c.cod_etat in ( 'RPC', 'RFO' )
And    c.id_seq = ( Select MAX ( id_seq )
					From   sysadm.commande c2
					Where  c2.id_sin = c.id_sin
					And    c2.id_typ_art = c.id_typ_art
					And    c2.status_gc = c2.status_gc 
					And	   c2.cod_etat <> 'ANN'
				  )
And    DATEDIFF ( day, c.dte_env_cli, GETDATE() ) <= 7
Union  all
-- Réparation
Select  2 'Type_Operation',
		c.dte_env_cli 'Date_Heure',
		s.id_contrat_abonne 'Num_Vente_DARTY',
		s.num_imei_port 'Num_IMEI_Tel_Repris',
		s.num_imei_port 'Num_IMEI_Tel_Remis',
		s.marq_port 'Marque_Tel_Remis',
		s.modl_port 'Modele_Tel_Remis'

From   sysadm.sinistre s, 
	   sysadm.det_pro d,
	   sysadm.commande c
Where  d.id_code_dp = 94
And    sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( d.val_car), ';') = 'STAT_O2M_DARTY'
And	   s.id_sin = d.id_prod
And	   c.id_sin = s.id_sin
And    c.id_typ_art = 'PRS'
And    c.status_gc = 2
And	   c.dte_env_cli is not null
And	   c.cod_etat <> 'ANN'
And    c.id_seq = ( Select MAX ( id_seq )
					From   sysadm.commande c2
					Where  c2.id_sin = c.id_sin
					And    c2.id_typ_art = c.id_typ_art
					And    c2.status_gc = c2.status_gc 
					And	   c2.cod_etat <> 'ANN'
				  )
And    DATEDIFF ( day, c.dte_env_cli, GETDATE() ) <= 7


GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_DARTY_CLIENT
-- Auteur               :       JFF
-- Date                 :       25/04/2011
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [PC662]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_DARTY_CLIENT ' AND type = 'P' )
        DROP procedure sysadm.PS_S_DARTY_CLIENT 
GO

CREATE procedure sysadm.PS_S_DARTY_CLIENT 
AS

-- Commande
Select  s.id_contrat_abonne 'Num_Vente_DARTY',
		s.num_imei_port 'IMEI_sinistre',
		convert ( VarChar ( 10), s.cree_le , 103 ) 'Date_Ouverture_Dossier',
		IsNull ( convert ( VarChar ( 10), (c.dte_env_cli) ,103 ), 'Pas de prestation' ) 'Date_Fermeture_Siniste',
		'ACCEPTE' 'Statut_Du_Dossier' 

From   sysadm.sinistre s, 
	   sysadm.det_pro d,
	   sysadm.commande c
Where  d.id_code_dp = 94
And    sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( d.val_car), ';') = 'STAT_CLIENT_DARTY'
And	   s.id_sin = d.id_prod
And	   c.id_sin = s.id_sin
And	   c.dte_env_cli is not null
And		( ( c.status_gc = 2  and c.cod_etat <> 'ANN' )
		   Or 
		   ( c.id_typ_art not in ( 'EDI', 'PRS' )  and c.cod_etat in ( 'RPC', 'RFO' ) )
		)
And    c.id_seq = ( Select MAX ( id_seq )
					From   sysadm.commande c2
					Where  c2.id_sin = c.id_sin
							And		( ( c2.status_gc = 2 And c2.cod_etat <> 'ANN' )
									   Or 
									   ( c2.id_typ_art not in ( 'EDI', 'PRS' ) And c2.cod_etat in ( 'RPC', 'RFO' ) )
									)
				  )
And    DATEDIFF ( day, c.dte_env_cli, GETDATE() ) <= 7
Union All
Select  s.id_contrat_abonne 'Num_Vente_DARTY',
		s.num_imei_port 'IMEI_sinistre',
		convert ( VarChar ( 10), s.cree_le , 103 ) 'Date_Ouverture_Dossier',
		IsNull ( convert ( VarChar ( 10), (s.valide_le) ,103 ), 'Pas de prestation' ) 'Date_Fermeture_Siniste',
		'REFUSE' 'Statut_Du_Dossier'

From   sysadm.sinistre s, 
	   sysadm.det_pro d,
	   sysadm.commande c
Where  d.id_code_dp = 94
And    sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( d.val_car), ';') = 'STAT_CLIENT_DARTY'
And	   s.id_sin = d.id_prod
And    DATEDIFF ( day, s.valide_le, GETDATE() ) <= 7
And    c.id_sin = s.id_sin
And    c.id_typ_art = 'PRS'
And    c.status_gc = 21
And	   c.cod_etat <> 'ANN'
And	   Not Exists ( 
				Select * 
				From   sysadm.commande c1
				Where  c1.id_sin = s.id_sin
				And		( ( c1.status_gc = 2 And c1.cod_etat <> 'ANN' )
						   Or 
					   ( c1.id_typ_art not in ( 'EDI', 'PRS' ) And c1.cod_etat in ( 'RPC', 'RFO' ) )
				)
		) 
Union All
Select  s.id_contrat_abonne 'Num_Vente_DARTY',
		s.num_imei_port 'IMEI_sinistre',
		convert ( VarChar ( 10), s.cree_le , 103 ) 'Date_Ouverture_Dossier',
		null 'Date_Fermeture_Siniste',
		'EN_COURS_INSTRUCTION' 'Statut_Du_Dossier'

From   sysadm.sinistre s, 
	   sysadm.det_pro d
Where  d.id_code_dp = 94
And    sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( d.val_car), ';') = 'STAT_CLIENT_DARTY'
And	   s.id_sin = d.id_prod
And    DATEDIFF ( day, s.valide_le, GETDATE() ) <= 7
And    s.cod_etat not in ( 600, 900 , 200 )
And	   Not Exists ( 
				Select * 
				From   sysadm.commande c1
				Where  c1.id_sin = s.id_sin
				And		( ( c1.status_gc in ( 2,21 ) And c1.cod_etat <> 'ANN' )
						   Or 
					   ( c1.id_typ_art not in ( 'EDI', 'PRS' ) And c1.cod_etat in ( 'RPC', 'RFO' ) )
				)
		) 



GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_LANCEUR_STAT_DARTY
-- Auteur               :       JFF
-- Date                 :       25/04/2011
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [PC662]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_LANCEUR_STAT_DARTY ' AND type = 'P' )
        DROP procedure sysadm.PS_S_LANCEUR_STAT_DARTY 
GO

CREATE procedure sysadm.PS_S_LANCEUR_STAT_DARTY 
AS

Declare @sChemin    VarChar ( 255 )
Declare @sFichier   VarChar ( 255 )
Declare @sNomFichier VarChar ( 255 )
Declare @sNomServeur VarChar(255)
Declare @sOsqlOption VarChar(255)
Declare @iRetOsql    int	
Declare @sFicOut     VarChar(255)
Declare @sBase		 VarChar ( 15 )
Declare @sRequete	 VarChar ( 100 )
Declare @sCommande	 VarChar ( 255 )
Declare @sMessage    Varchar(800)
Declare @sRetourErrMail VarChar(255)

Set @sNomServeur = @@servername

-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode
Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

Set @sNomFichier = Convert ( VarChar ( 4),  Year ( GETDATE())) + 
				  Right ( '0' + Convert ( VarChar ( 2),  month ( GETDATE())), 2 )+
				  Right ( '0' + Convert ( VarChar ( 2),  day ( GETDATE())), 2 )

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO') Set @sBase = 'SIMPA2_PRO' Else Set @sBase = 'SIMPA2_TRT'


-- Stat O2M
Set @sChemin = '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Darty\'
Set @sFichier = @sNomFichier + '_O2M'
Set @sRequete = 'PS_S_DARTY_O2M'

Set @sFicOut = @sChemin + @sFichier

SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
					 @sBase + '.sysadm.' + @sRequete + ' ' + 
					 '" /o' + @sFicOut + ' -w5000' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

-- Stat CLIENT
Set @sChemin = '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Darty\'
Set @sFichier = @sNomFichier + '_CLIENT'
Set @sRequete = 'PS_S_DARTY_CLIENT'

Set @sFicOut = @sChemin + @sFichier

SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
					 @sBase + '.sysadm.' + @sRequete + ' ' + 
					 '" /o' + @sFicOut + ' -w5000' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

GO

grant execute on sysadm.PS_S_LANCEUR_STAT_DARTY to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procédure            :       PS_S_FNAC_EPT_VDOC7746
-- Auteur               :       JFF
-- Date                 :       15/05/2012
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC7746]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_FNAC_EPT_VDOC7746' AND type = 'P' )
        DROP procedure sysadm.PS_S_FNAC_EPT_VDOC7746
GO

CREATE procedure sysadm.PS_S_FNAC_EPT_VDOC7746
AS

Declare @sDateDeb Varchar ( 20 ) -- Format Date de présentation
Declare @sDateFin Varchar ( 20 ) -- Format Date de présentation
Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @dtToday datetime

Select @dtToday		= getdate()

Select @dtDateDeb	= Convert(Varchar (8), DateAdd ( week, -1, @dtToday) , 112 )
Select @sDateDeb	= Convert(Varchar(10),@dtDateDeb, 103)+ ' ' + Convert ( Varchar( 8 ),@dtDateDeb, 114)
Select @dtDateFin	= DateAdd ( ss , -1, cast (Convert(VarChar (8), @dtToday, 112 ) as datetime ) )
Select @sDateFin	= Convert(Varchar(10),@dtDateFin, 103)+ ' ' + Convert ( Varchar( 8 ),@dtDateFin, 114)

Select ('Motif de refus coché entre le ' + @sDateDeb + ' et le ' + @sDateFin) as 'période_cochage_motif_refus',
	   s.id_sin 'Reférence_Sinistre',
	   sysadm.FN_CODE_NUM ( p.cod_civ, '-CL' ) 'Civilité',
	   p.nom 'Nom',
	   p.prenom 'Prénom',
	   i.adr_mail 'email',
	   Case 
			When i.num_teld is not null Then ''''  + rTrim( CONVERT ( VarChar ( 20 ), i.num_teld ) )
			Else '''' + Rtrim ( CONVERT ( VarChar ( 20 ), s.num_port ) ) 
	   End 'Num_Tel',
	   i.adr_1 'Adresse_ligne_1',
	   i.adr_2 'Adresse_ligne_3',
	   i.adr_cp 'Code_Postal',
	   i.adr_ville 'Ville',
	   s.marq_port 'Marque',
	   s.modl_port 'Modele',
	   IsNull ( ( Select max ( dt.mt_val_achat )
		 From sysadm.detail dt
		 Where dt.id_sin = s.id_sin
	   ), 0 ) 'Valeur_D_Achat',
	   Convert ( VarChar ( 10) , s.dte_ach_port, 103 ) 'Date_D_Achat',
	   Convert ( VarChar ( 10) , s.dte_decl, 103 ) 'Date_De_Déclaration',
	   ( Select Convert ( VarChar ( 10) , max ( c.dte_env_cli ), 103 )
	     From   sysadm.commande c
	     Where  c.id_sin = s.id_sin
	     And    c.id_typ_art in ( 'EDI')) 'Date_Intervention_Prestataite',
	   ( Select Top 1 
		'Date Déclaration : ' + IsNull ( Convert ( varchar(10) , csh.dte_dec , 103 ), '' ) + '/' + 
		'Date Achat : ' +  IsNull ( Convert ( varchar(10), csh.dte_achat, 103 ), '' ) + '/' + 
		'Lib_Fam : ' +  IsNull ( rTrim ( csh.lib_fam ), '' ) + '/' + 
		'Lib_Marque : ' +  IsNull ( rTrim ( csh.lib_marque ), '' ) + '/' + 
		'Lib_Modele : ' +  IsNull ( rTrim ( csh.lib_modele ), '' ) + '/' + 
		'Num_Serie : ' +  IsNull ( Upper ( rTrim ( csh.num_serie) ), '' ) + '/' + 
		'Id_Magasin : ' +  IsNull ( Upper ( rTrim ( csh.id_magasin ) ), '' ) + '/' + 		
		'lib_Magasin : ' +  IsNull ( rTrim ( csh.lib_magasin ) , '' ) + '/' + 				
		'Id_Facture : ' +  IsNull ( Upper( rTrim ( csh.id_facture ) ), '' ) + '/'  				
	     From   SHERPA_PRO.sysadm.sinistre ssh,
				SHERPA_PRO.sysadm.w_fnac_ept csh
		 Where  ssh.id_sin = s.id_sin
		 And    csh.id_cli = ssh.id_cli ) 'Commentaire_Attitude',

	   ( Select Top 1 c.comment_frn
	     From   sysadm.commande c
	     Where  c.id_sin = s.id_sin
	     And    c.id_typ_art in ( 'EDI')
	     And    c.id_ref_four = 'A_DIAGNOSTIQUER' 
	     and    c.cod_etat <> 'ANN' ) 'Commentaire_Atelier_Retour_Diag',
	   sysadm.FN_CODE_NUM ( r.id_motif, '+RE' ) 'Motif_Refus',
	    Case (	 Select Top 1 c.status_gc
				 From   sysadm.commande c
				 Where  c.id_sin = s.id_sin
				 And    c.id_typ_art in ( 'EDI' )
				 And    c.id_ref_four = 'REFUSE_A_REEXP' ) 
			When 155 Then 'OUI'
			Else 'NON'
		End 'App_reexp_vers_le client_si_refus',
		 ( Select Convert ( VarChar ( 10) , max ( c.dte_env_cli ), 103 )
				 From   sysadm.commande c
				 Where  c.id_sin = s.id_sin
				 And    c.id_typ_art in ( 'EDI' )
				 And    c.id_ref_four = 'REFUSE_A_REEXP' ) 'Date_Reexp_App_Si_Refus'		
		
 From	sysadm.det_pro d,
		sysadm.sinistre s,
		sysadm.refus r,
		sysadm.inter i,
		sysadm.personne p

Where d.id_code_dp = 94
and   sysadm.FN_CLE_VAL ( 'COD_DW', rtrim( val_car), ';' ) = 'STAT_QUOT_FNAC_VDOC7746'
and   s.id_prod = d.id_prod
and   r.id_sin = s.id_sin
and   i.id_sin = s.id_sin
and   i.cod_inter = 'A'
and   p.id_ordre = s.id_ordre    
and   r.id_i is not null
and   r.cree_le between @dtDateDeb And @dtDateFin 
Order by i.adr_mail,  p.nom , p.prenom 

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_FNAC_EPT_VDOC7746_MAIL 
-- Auteur               :       JFF
-- Date                 :       15/05/2012
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC7746] - [VDoc9029]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_FNAC_EPT_VDOC7746_MAIL ' AND type = 'P' )
        DROP procedure sysadm.PS_S_FNAC_EPT_VDOC7746_MAIL 
GO

CREATE procedure sysadm.PS_S_FNAC_EPT_VDOC7746_MAIL 
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(500),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_Fnac_vDoc7746\'
Set @sFileName	= 'Export_Fnac_vDoc7746'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_FNAC_EPT_VDOC7746 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_FNAC_EPT_VDOC7746 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = 'Extraction SPB des dossiers refusés'
set @sMessage  = 'Bonjour,'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Vous trouverez ci-joint l''extraction hebdomadaire reprenant les refus notifiés aux clients relatifs aux contrats Garantie Echange à Neuf.'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Bonne réception.'

if @iRetOsql <> 0
 BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DSI.'
	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'jff@spb.fr,sml@spb.fr',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL
 END
Else
 Begin
	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'sml@spb.fr,vsa@spb.fr,fra@spb.fr,rcensier@spb.eu,valerie.MAUFFREY@fnac.tm.fr,danielle.levy-roquart@fnac.com,lautaro.garcia@fnac.com,vincent.lahuec@fnac.com',
--			'sml@spb.fr,vsa@spb.fr,fra@spb.fr,jff@spb.fr',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL
 End

Go

grant execute on sysadm.PS_S_FNAC_EPT_VDOC7746_MAIL to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procédure            :       PS_S_MARYSE_DBL_RGLT_VDOC6588
-- Auteur               :       JFF
-- Date                 :       21/05/2012
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC6588]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MARYSE_DBL_RGLT_VDOC6588' AND type = 'P' )
        DROP procedure sysadm.PS_S_MARYSE_DBL_RGLT_VDOC6588
GO

CREATE procedure sysadm.PS_S_MARYSE_DBL_RGLT_VDOC6588
AS

Declare @sDateDeb Varchar ( 20 ) -- Format Date de présentation
Declare @sDateFin Varchar ( 20 ) -- Format Date de présentation
Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @dtToday datetime

Select @dtToday		= getdate()

Select @dtDateDeb	= Convert(Varchar (8), DateAdd ( year, -1, @dtToday) , 112 )
Select @sDateDeb	= Convert(Varchar(10),@dtDateDeb, 103)+ ' ' + Convert ( Varchar( 8 ),@dtDateDeb, 114)
Select @dtDateFin	= DateAdd ( ss , -1, cast (Convert(VarChar (8), @dtToday, 112 ) as datetime ) )
Select @sDateFin	= Convert(Varchar(10),@dtDateFin, 103)+ ' ' + Convert ( Varchar( 8 ),@dtDateFin, 114)

Select Distinct
   'Regl Four > 50€ sans RM + Régl Assuré > 50€ sans RM' 'Cas',
   'du ' + @sDateDeb + ' au ' + @sDateFin 'période',
   r.id_sin,
   r.mt_tot_reg 'regl_fourn',
   Convert ( varchar(10), r.cree_le , 103 ) 'dte_regl_fourn',
   sysadm.FN_CODE_CAR ( i.id_four, '-FR') 'Fourn',
   r2.mt_tot_reg 'regl_ass',
   Convert ( varchar(10), r2.cree_le, 103 ) 'dte_regl_ass'

From  inter i,
      reglement r,
      reglement r2,
      reg_gti rg

Where i.id_four is not null
And   r.id_sin = i.id_sin
And   r.cree_le between @dtDateDeb and @dtDateFin
And   r.id_i = i.id_i
And   r.cod_mode_reg = 'FM'
And   r.mt_tot_reg >= 50
And     Not Exists ( 
            Select * 
            From   reglement r3
            Where  r3.id_sin = r.id_sin
            And      r3.cod_mot_reg = 'RM'
            And    r3.id_reg_base = r.id_reg
            )
And   r2.id_sin = r.id_sin
and   r2.id_i = 0
and   r2.mt_tot_reg >= 50
and   rg.id_sin = r2.id_sin
and   rg.id_gti not in ( 7, 8 )
and   rg.id_gti > 0
And     Not Exists ( 
            Select * 
            From   reglement r4
            Where  r4.id_sin = r2.id_sin
            And      r4.cod_mot_reg = 'RM'
            And    r4.id_reg_base = r2.id_reg
            )
Union
Select Distinct
   'Multi regl fourn > 50€ sans RM' 'Cas',
   'du ' + @sDateDeb + ' au ' + @sDateFin 'période',
   i.id_sin,
   r.mt_tot_reg 'regl_fourn',
   Convert ( varchar(10), r.cree_le , 103 ) 'dte_regl_fourn',
   sysadm.FN_CODE_CAR ( i.id_four, '-FR') 'Fourn',
   0,
   null

From  sysadm.inter i,
	  sysadm.reglement r

Where i.id_four is not null
And   r.id_sin = i.id_sin
And   r.cree_le between @dtDateDeb and @dtDateFin
And   r.id_i = i.id_i
And   r.cod_mode_reg = 'FM'
And   r.mt_tot_reg >= 50
And     Not Exists ( 
            Select * 
            From   reglement r3
            Where  r3.id_sin = r.id_sin
            And      r3.cod_mot_reg = 'RM'
            And    r3.id_reg_base = r.id_reg
            )
And  Exists ( 
			Select *
			From reglement r2
			Where r2.id_sin = r.id_sin
			And	  r2.cod_mode_reg = 'FM'
			And   r2.id_reg <> r.id_reg
			And   r2.mt_tot_reg >= 50
			And     Not Exists ( 
						Select * 
						From   reglement r4
						Where  r4.id_sin = r2.id_sin
						And      r4.cod_mot_reg = 'RM'
						And    r4.id_reg_base = r2.id_reg
						)

	 )
	 
order by r.id_sin

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_MARYSE_DBL_RGLT_VDOC6588_MAIL 
-- Auteur               :       JFF
-- Date                 :       15/05/2012
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC6588]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MARYSE_DBL_RGLT_VDOC6588_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S_MARYSE_DBL_RGLT_VDOC6588_MAIL
GO

CREATE procedure sysadm.PS_S_MARYSE_DBL_RGLT_VDOC6588_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(500),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_Dblt_Maryse_vDoc6588\'
Set @sFileName	= 'Export_Dblt_Maryse_vDoc6588'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_MARYSE_DBL_RGLT_VDOC6588 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_MARYSE_DBL_RGLT_VDOC6588 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = 'Extraction SPB : Doublons règlements vDoc6588'
set @sMessage  = 'Vous trouverez ci-joint l''extraction journalière reprenant les doublons de règlements des cas ci-dessous :'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Regl Four > 50 Euros sans RM + Régl Assuré > 50 Euros sans RM'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Multi regl fourn > 50 Euros sans RM'

if @iRetOsql <> 0
 BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DSI.'
	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'jff@spb.fr',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL
 END
Else
 Begin
	EXEC master.dbo.SPB_PS_MAIL_OUTLOOK
			@sRetourErrMail OUTPUT, 
			'groupefacturation@spb.fr',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL, 
			NULL
 End

Go

grant execute on sysadm.PS_S_MARYSE_DBL_RGLT_VDOC6588_MAIL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_HEBDO_PM103_VDOC8034
-- Auteur               :       JFF
-- Date                 :       11/06/2012
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC8034]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_HEBDO_PM103_VDOC8034' AND type = 'P' )
        DROP procedure sysadm.PS_S_HEBDO_PM103_VDOC8034
GO

CREATE procedure sysadm.PS_S_HEBDO_PM103_VDOC8034
AS

Declare @sDateDeb Varchar ( 20 ) -- Format Date de présentation
Declare @sDateFin Varchar ( 20 ) -- Format Date de présentation
Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @dtToday datetime

Select @dtToday		= getdate()

Select @dtDateDeb	= Convert(Varchar (8), DateAdd ( week, -1, @dtToday) , 112 )
Select @sDateDeb	= Convert(Varchar(10),@dtDateDeb, 103)+ ' ' + Convert ( Varchar( 8 ),@dtDateDeb, 114)
Select @dtDateFin	= DateAdd ( ss , -1, cast (Convert(VarChar (8), @dtToday, 112 ) as datetime ) )
Select @sDateFin	= Convert(Varchar(10),@dtDateFin, 103)+ ' ' + Convert ( Varchar( 8 ),@dtDateFin, 114)

Select ('dossier en mode de reprise de base manuelle entre le ' + @sDateDeb + ' et le ' + @sDateFin) as 'Période',
	   d.id_sin,
	   s.id_prod,
	   sysadm.FN_LIB_PROD ( s.id_prod ),
	   d.cree_le 'Date_Création_Marquage',
	   d.maj_par 'Créateur_Marquage',
	   s.maj_par 'Dossier_Maj_par',
	   s.maj_le 'Dossier_Maj_le',
	   s.valide_par 'Dossier_Valide_par',
	   s.valide_le 'Dossier_Valide_le',
	   'Validé' 'Validation'
from	sysadm.div_sin d, 
		sysadm.sinistre s
Where d.nom_zone = 'dossier_base_manuelle'
And   d.id_sin = s.id_sin
And   d.cree_le between @dtDateDeb And @dtDateFin 
Union
Select ('dossier en mode de reprise de base manuelle entre le ' + @sDateDeb + ' et le ' + @sDateFin) as 'Période',
	   d.id_sin,
	   s.id_prod,
	   sysadm.FN_LIB_PROD ( s.id_prod ),
	   d.cree_le 'Date_Création_Marquage',
	   d.maj_par 'Créateur_Marquage',
	   s.maj_par 'Dossier_Maj_par',
	   s.maj_le 'Dossier_Maj_le',
	   null 'Dossier_Valide_par',
	   null 'Dossier_Valide_le',
	   'Jamais validé' 'Validation'
from	sysadm.w_div_sin d, 
		sysadm.w_sin s
Where d.nom_zone = 'dossier_base_manuelle'
And   d.id_sin = s.id_sin
And   d.cree_le between @dtDateDeb And @dtDateFin 
And   Not Exists ( 
		Select * 
		from sysadm.div_sin d2 
		Where d2.id_sin = d.id_sin
		And   d2.nom_zone = d.nom_zone
	  )
Order by d.cree_le


Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_HEBDO_PM103_VDOC8034_MAIL  
-- Auteur               :       JFF
-- Date                 :       15/05/2012
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC7746]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_HEBDO_PM103_VDOC8034_MAIL ' AND type = 'P' )
        DROP procedure sysadm.PS_S_HEBDO_PM103_VDOC8034_MAIL  
GO

CREATE procedure sysadm.PS_S_HEBDO_PM103_VDOC8034_MAIL  
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(500),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_PM103_vDoc8034\'
Set @sFileName	= 'Export_PM103_vDoc8034'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_HEBDO_PM103_VDOC8034 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_HEBDO_PM103_VDOC8034 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = 'Extraction dossiers créés PM103 sous mode -NA/223 (Reprise de données de base manuelle)'
set @sMessage  = 'Bonjour,'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Vous trouverez ci-joint l''extraction hebdomadaire reprenant tous les dossiers créés la semaine dernière en mode de reprise de base manuelle.'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Bonne réception.'

if @iRetOsql <> 0
 BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DSI.'
	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'jff@spb.fr',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL
 END
Else
 Begin
	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
--			'JFF@spb.fr',
			'IHO@spb.fr,KGR@spb.fr,SRA@spb.fr,ICH@spb.fr,STU@spb.fr,SAL@spb.fr',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL
 End

Go

grant execute on sysadm.PS_S_HEBDO_PM103_VDOC8034_MAIL to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procédure            :       PS_VDOC9663  
-- Auteur               :       JFF
-- Date                 :       21/12/2012
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC9663]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_VDOC9663' AND type = 'P' )
        DROP procedure sysadm.PS_VDOC9663
GO

CREATE procedure sysadm.PS_VDOC9663
@sListeIdSin	Varchar(8000)
As

Declare @sTypVetuste VarChar ( 20 )
Declare @iMethode Integer
Declare @DteRcpFrn DateTime
Declare @DteAchat DateTime
Declare @dcIdSin Decimal ( 10 ) -- [PI062]

Declare @t TABLE (ordre_fic integer identity,
				  id_sin    Decimal (10), -- [PI062]
				  typ_vetuste VarChar ( 20 ),
				  methode integer,
				  dte_rcp_frn DateTime,
				  dte_achat DateTime
				   )
Declare @iPos int

-- Décomposition en table
While LEN(@sListeIdSin) > 0
Begin
	set @iPos=charindex(',',@sListeIdSin)
	If @iPos=0 
	Begin
		Set @dcIdSin = CONVERT ( Decimal ( 10 ) , @sListeIdSin ) -- [PI062]
		set @sListeIdSin=''
	End 
	Else
	Begin
		Set @dcIdSin = CONVERT ( Decimal ( 10 ), LEFT(@sListeIdSin,@iPos-1) ) -- [PI062]
		Set @sListeIdSin=SUBSTRING(@sListeIdSin,@iPos+1,8000)
	End

	Select  Top 1
			@sTypVetuste = pfm.typ_vetuste,
			@iMethode = pfm.id_methode
	From	sysadm.param_ftu_brk pfm,
			sysadm.div_sin ds,
			sysadm.sinistre s
	Where   s.id_sin = @dcIdSin
	And		ds.id_sin = s.id_sin
	And     ds.nom_zone = 'type_app'
	And	    pfm.id_prod = s.id_prod
	And     pfm.id_typ_art = ds.val_car 

	If @sTypVetuste is null Set @sTypVetuste = 'ACHSRV'

	Select Top 1
		@DteRcpFrn =
		Case @iMethode
			When 1 Then IsNull ( c.dte_rcp_frn, 
							 ( 
							Select 	min ( c2.dte_rcp_frn )
							From   	sysadm.commande c2
							Where	c2.id_sin = c.id_sin
							And	c2.id_four = c.id_four
							And	c2.id_ref_four = 'A_DIAGNOSTIQUER'
							 )
					   )		
			When 2 Then Case IsDate ( sysadm.FN_CLE_VAL ( 'DTE_LIVR_SBE',c.info_frn_spb_cplt, ';' ) )
					When 1 Then convert ( Datetime , sysadm.FN_CLE_VAL ( 'DTE_LIVR_SBE',c.info_frn_spb_cplt, ';' ) )
					Else Convert ( Datetime, null )
					End 
			Else c.dte_rcp_frn
		End 			
	From sysadm.commande c
	Where c.id_sin = @dcIdSin

	Select Top 1
		@DteAchat=
		IsNull ( s.dte_ach_port, 
	  		( Select min ( d.dte_det ) 
			  From 	sysadm.detail d,
		  		sysadm.det_pro dp
			  Where d.id_sin = s.id_sin 
			  And 	dp.id_prod = s.id_prod
			  And   dp.id_code_dp = 42
			  And   dp.id_code_num = c.id_gti
			  And   dp.id_code_car = 'A'
			) )		
	From sysadm.sinistre s,
		 sysadm.commande c
	Where s.id_sin = @dcIdSin
	And   c.id_sin = s.id_sin
	
	Insert into @t select @dcIdSin,	@sTypVetuste, @iMethode, @DteRcpFrn, @DteAchat
	
End


Select  Convert ( VarChar ( 10 ) , s.id_sin) ,
		t.ordre_fic,
		c.id_four,
		sysadm.FN_CODE_CAR ( c.id_four, '-FR') 'lib_four',
		s.id_prod,
		sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_prod',
		cie.lib_cie,
		po.lib_police,
		po.id_police,
		c.id_gti,
		cg.lib_gti,
		s.marq_port,
		s.modl_port,
		s.num_imei_port 'num_imei_serie',
		s.dte_ach_port,
		s.dte_surv,
		c.dte_rcp_frn,
		( Select ds.val_car 
		  From   sysadm.div_sin ds
		  Where  ds.id_sin = s.id_sin
		  And    ds.nom_zone = 'type_app') typ_app,
		( Select sysadm.FN_CODE_CAR ( ds.val_car , '-AR' )
		  From   sysadm.div_sin ds
		  Where  ds.id_sin = s.id_sin
		  And    ds.nom_zone = 'type_app') lib_app,
		Case @sTypVetuste
			When 'ACHSRV' Then
				DateDiff ( day, @DteAchat, s.dte_surv ) 
			When 'ACHRCP' Then
				DateDiff ( day, @DteRcpFrn, s.dte_surv ) 
		End 'vetusté_jours',
		Case @sTypVetuste
			When 'ACHSRV' Then
				Convert ( Decimal (11,2) ,Round ( Convert ( decimal ( 5), DateDiff ( day, @DteAchat, s.dte_surv )) / Convert ( decimal (5), 365 ), 2 ) )
			When 'ACHRCP' Then
				Convert ( Decimal (11,2) ,Round ( Convert ( decimal ( 5), DateDiff ( day, @DteRcpFrn, s.dte_surv )) / Convert ( decimal (5), 365 ), 2 ) )				
		End 'vetusté_an',
		c.info_spb_frn,
		sysadm.FN_CODE_NUM ( c.info_spb_frn, '-IF') 'lib_info_spb_frn',
		c.status_gc,
		sysadm.FN_CODE_NUM ( c.status_gc, '-GC') 'lib_status_gc',
		c.id_typ_art,
		c.id_ref_four,
		c.id_seq

From	sysadm.sinistre s,
		sysadm.commande c,
		sysadm.garantie ga,
		sysadm.police po,
		sysadm.compagnie cie,
		sysadm.code_garantie cg,
		@t as t

Where	s.id_sin = t.id_sin
And		c.id_sin = s.id_sin
And		ga.id_prod = s.id_prod
And     ga.id_rev = s.id_rev
And     ga.id_gti = c.id_gti
And		po.id_police = ga.id_police
And		cie.id_cie = po.id_cie
And		cg.id_prod = s.id_prod
And		cg.id_gti = c.id_gti
Order by t.ordre_fic, s.id_sin, c.id_seq

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_MENS_VDOC9850_PSM
-- Auteur               :       JFF
-- Date                 :       11/01/2013
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC9850]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- 17/04/2015	FPI	[VDoc17405]
-- 29/09/2015	FPI	[VDoc18783]
-- 26/11/2015	FPI [VDoc19281] Suppr du critère d'état du dossier
-- 08/03/2016   JFF [VDOC20161]
-- 21/11/2018   JFF [VDOC27123]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MENS_VDOC9850_PSM' AND type = 'P' )
        DROP procedure sysadm.PS_S_MENS_VDOC9850_PSM
GO

CREATE procedure sysadm.PS_S_MENS_VDOC9850_PSM
	@asCas VarChar ( 20 ) = null
AS

Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @iMois Integer
Declare @iAnnee Integer
Declare @iJour Integer

/*
If @asCas is null Or @asCas <> 'FORCAGE'
 Begin
	If Convert ( Integer, DATEPART ( day, getdate())) <> 1
	 Begin
		Select 'Le traitement ne peut être lancé que le 1er du mois. Passer l''argument ''FORCAGE'' pour simuler le lancement au premier du mois en cours'
		Return -1 -- jour de lancement Différent du 1er du mois
	 End
 End 
*/

Set @iMois = DATEPART ( month, GetDate() )
Set @iAnnee = DATEPART ( Year, GetDate() )
Set @iJour = 1

Set @dtDateFin = CONVERT( DateTime,
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iJour ), 2 ) + '/' +
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iMois ), 2 ) + '/' +
				 Right ( '0000' + CONVERT ( VarChar ( 4 ) , @iAnnee ), 4 ),
				 103 )

Set @dtDateFin = DATEADD ( DAY, -1, @dtDateFin ) 

Set @iMois = DATEPART ( month, @dtDateFin )
Set @iAnnee = DATEPART ( Year, @dtDateFin )

Set @dtDateDeb = CONVERT( DateTime,
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iJour ), 2 ) + '/' +
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iMois ), 2 ) + '/' +
				 Right ( '0000' + CONVERT ( VarChar ( 4 ) , @iAnnee ), 4 ) ,
				 103 )
				 
Select Convert ( VarChar ( 10), @dtDateDeb, 103 ) 'periode_deb_dte_fin_trt',
	   Convert ( VarChar ( 10), @dtDateFin, 103 ) 'periode_fin_dte_fin_trt',
	   CONVERT ( VarChar ( 10), c.id_sin ) + '-' + CONVERT ( VarChar ( 10), c.id_seq )'num_presta_spb',
	   s.id_prod,
	   sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_prod',
	   cie.lib_cie 'Assureur',
	   s.marq_port 'Marque',
	   s.modl_port 'Modele',
	   '''' + s.num_imei_port + '''' 'IMEI',
	   c.id_ref_four 'Ordre_prioritaire',
	   c.status_gc,
	   sysadm.FN_CODE_NUM ( c.status_gc, '-GC' ) 'Lib_Statut_Gc',
	   c.comment_frn,
	   Case 
	      -- [VDOC27123]BVID/BVIP/BVIT
		  When CHARINDEX ( '[BVIE]', c.comment_frn ) > 0  Then '[BVIE]'
		  When CHARINDEX ( '[BVID]', c.comment_frn ) > 0  Then '[BVID]'
		  When CHARINDEX ( '[BVIP]', c.comment_frn ) > 0  Then '[BVIP]'
		  When CHARINDEX ( '[BVIT]', c.comment_frn ) > 0  Then '[BVIT]'
		  When CHARINDEX ( '[BVIEOX]', c.comment_frn ) > 0 Then '[BVIEOX]'
		  Else 'Aucune clé'
	   End 'Clé_Comment',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré en pointe de vente'
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré envoie coli en centralisation'
	   End 'pdv_ou_coli_centl',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
					/* [VDOC20161]
					( Select Top 1 b.adr_nom
					   From sysadm.boutique b
					   Where b.id_prod = s.id_prod
					   And b.cod_mag = sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' )
					 )
					 */
	   End 'Nom PSM',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
				/* [VDOC20161]
				sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' )
				*/
	   End 'Numéro PSM',
	   Convert ( VarChar ( 10), c.dte_rcp_frn, 103 ) 'dte_rcp_PSM',
	   Convert ( VarChar ( 10), c.dte_env_cli, 103 ) 'dte_fin_trt_en_cli',
	   sysadm.FN_CODE_CAR(d.val_car,'-AR') 'Type appareil'

From sysadm.commande c
Inner Join sysadm.gar_sin g on g.id_sin = c.id_sin And g.id_gti = c.id_gti
Inner Join sysadm.sinistre s on s.id_sin = c.id_sin
Inner Join sysadm.garantie ga on ga.id_prod = s.id_prod And 
								 ga.id_gti = c.id_gti And
								 ga.id_rev = s.id_rev
Inner Join sysadm.police po on po.id_police = ga.id_police
Inner Join sysadm.compagnie cie on cie.id_cie = po.id_cie
inner join sysadm.div_sin d on d.id_sin=c.id_sin
Where c.id_four = 'PSM'
And   c.dte_env_cli is not null
And   c.id_ref_four in ( 'A_REPARER', 'A_REPARER_FORCE', 'A_DESOXYDER', 'A_DESOXYDER_FORCE' )
And   (  ( c.status_gc in ( 21, 23 ) And ( CHARINDEX ( '[BVIE]', c.comment_frn ) > 0 Or CHARINDEX ( '[BVID]', c.comment_frn ) > 0 Or CHARINDEX ( '[BVIP]', c.comment_frn ) > 0 Or CHARINDEX ( '[BVIT]', c.comment_frn ) > 0 )) --And sysadm.FN_LIB_ETAT_DOS_ASSURE ( c.id_sin, 'CODE') in (1500, 1510))
	Or	 ( c.status_gc in ( 21, 23 ) And CHARINDEX ( '[BVIEOX]', c.comment_frn ) > 0)-- And sysadm.FN_LIB_ETAT_DOS_ASSURE ( c.id_sin, 'CODE') in (1500, 1510))
	  )
And s.id_prod not between 48100 and 48199 -- [VDoc18783]
And s.id_prod not between 84000 and 84099 -- [VDoc18783]
and d.nom_zone='type_app'
And   c.dte_env_cli between @dtDateDeb And @dtDateFin

Go

grant execute on sysadm.PS_S_MENS_VDOC9850_PSM to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_IRREP_PSM
-- Auteur               :       FPI
-- Date                 :       09/09/2016
-- Libellé              :       
-- Commentaires         :       Réécriture de PS_S_MENS_VDOC9850_PSM & PS_S_JOURN_IRREP_PSM en 1 seule PS
-- Références           :       [VDOC21259]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- JFF      21/11/2018   [VDOC27123]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_IRREP_PSM' AND type = 'P' )
        DROP procedure sysadm.PS_S_IRREP_PSM
GO

CREATE procedure sysadm.PS_S_IRREP_PSM
	@asCas VarChar ( 1 ) = 'J' -- J pour journalier, 'M' pour mensuel
AS

Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @iMois Integer
Declare @iAnnee Integer

If @asCas='M' 
Begin
	Set @iMois = Month( GetDate() )
	Set @iAnnee = Year( GetDate() )

	Set @dtDateFin = CONVERT( DateTime,
					 '01/' +
					 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iMois ), 2 ) + '/' +
					 Right ( '0000' + CONVERT ( VarChar ( 4 ) , @iAnnee ), 4 ),
					 103 )

	If @iMois=1
	Begin 
		Set @iMois=12
		Set @iAnnee=@iAnnee - 1
	End
	Else
	Begin
		Set @iMois = @iMois - 1
	End

	Set @dtDateDeb = CONVERT( DateTime,
					 '01/' +
					 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iMois ), 2 ) + '/' +
					 Right ( '0000' + CONVERT ( VarChar ( 4 ) , @iAnnee ), 4 ) ,
					 103 )
End 
Else
Begin
	Set @dtDateDeb = CONVERT( DateTime,
				convert(varchar(10), DATEADD(day,-1,getdate()) , 103),
				 103 )

	-- @@dtDateFin = la veille à 23:59:59
	Set @dtDateFin = CONVERT( DateTime,
			convert(varchar(10), getdate() , 103),
				 103 )

	set @dtDateFin=DATEADD(SECOND,-1,@dtDateFin)
End

SET NOCOUNT ON;

With maTable(id_sin, id_seq, maj_le)
as (
  select t.id_sin, t.id_seq, t.maj_le
  from sysadm.v_trace_cmde t 
  where t.nom_zone='status_gc' and val_car in ('21','23')
	and maj_le between @dtDateDeb And @dtDateFin
	and not exists (select 1 from sysadm.v_trace_cmde t2 
		where t2.id_sin=t.id_sin and t.id_seq=t2.id_seq 
			and t2.nom_zone='status_gc' and t2.val_car in ('21','23')
			and t2.maj_le < t.maj_le)
)		 
Select Convert ( VarChar ( 10), @dtDateDeb, 103 ) 'periode_deb_dte_fin_trt',
	   Convert ( VarChar ( 10), @dtDateFin, 103 ) 'periode_fin_dte_fin_trt',
	   CONVERT ( VarChar ( 10), c.id_sin ) + '-' + CONVERT ( VarChar ( 10), c.id_seq )'num_presta_spb',
	   s.id_prod,
	   sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_prod',
	   sysadm.FN_LIB_CIE(s.id_sin) 'Assureur',
	   s.marq_port 'Marque',
	   s.modl_port 'Modele',
	   '''' + s.num_imei_port + '''' 'IMEI',
	   c.id_ref_four 'Ordre_prioritaire',
	   c.status_gc,
	   sysadm.FN_CODE_NUM ( c.status_gc, '-GC' ) 'Lib_Statut_Gc',
	   c.comment_frn,
	   Case 
		  -- [VDOC27123]BVID/BVIP/BVIT
		  When CHARINDEX ( '[BVIE]', c.comment_frn ) > 0  Then '[BVIE]'
		  When CHARINDEX ( '[BVID]', c.comment_frn ) > 0  Then '[BVID]'
		  When CHARINDEX ( '[BVIP]', c.comment_frn ) > 0  Then '[BVIP]'
		  When CHARINDEX ( '[BVIT]', c.comment_frn ) > 0  Then '[BVIT]'
		  When CHARINDEX ( '[BVIEOX]', c.comment_frn ) > 0 Then '[BVIEOX]'
		  Else 'Aucune clé'
	   End 'Clé_Comment',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré en pointe de vente'
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré envoie coli en centralisation'
	   End 'pdv_ou_coli_centl',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
	   End 'Nom PSM',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
	   End 'Numéro PSM',
	   Convert ( VarChar ( 10), c.dte_rcp_frn, 103 ) 'dte_rcp_PSM',
	   Convert ( VarChar ( 10), c.dte_env_cli, 103 ) 'dte_fin_trt_en_cli',
	   -- Convert ( VarChar ( 10), m.maj_le, 103) as dte_premiere_maj, -- [VDoc21949] mise en commentaire
	   sysadm.FN_CODE_CAR(d.val_car,'-AR') 'Type appareil'

From maTable m
	inner join sysadm.commande c on c.id_sin=m.id_sin and c.id_seq=m.id_seq
	Inner Join sysadm.sinistre s on s.id_sin = c.id_sin
	inner join sysadm.div_sin d on d.id_sin=c.id_sin
Where c.id_four = 'PSM'
And   c.dte_env_cli is not null
And   c.id_ref_four in ( 'A_REPARER', 'A_REPARER_FORCE', 'A_DESOXYDER', 'A_DESOXYDER_FORCE' )
And   (  ( c.status_gc in ( 21, 23 ) And ( CHARINDEX ( '[BVIE]', c.comment_frn ) > 0 Or CHARINDEX ( '[BVID]', c.comment_frn ) > 0 Or CHARINDEX ( '[BVIP]', c.comment_frn ) > 0 Or CHARINDEX ( '[BVIT]', c.comment_frn ) > 0))
	Or	 ( c.status_gc in ( 21, 23 ) And CHARINDEX ( '[BVIEOX]', c.comment_frn ) > 0)
	  )
And s.id_prod not between 48100 and 48199 -- [VDoc18783]
And s.id_prod not between 84000 and 84099 -- [VDoc18783]
and d.nom_zone='type_app';

Go

grant execute on sysadm.PS_S_IRREP_PSM to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_MENS_VDOC9850_PSM_MAIL
-- Auteur               :       JFF
-- Date                 :       11/01/2013
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC9850]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
--	FPI 22/05/2015	[VDoc17539] Fichier dans 2 répertoires distincts
--	FPI	15/06/2015	[VDoc17904] Modification des destinataires
--	FPI	29/09/2015	[VDoc18783]
--  FPI 05/09/2016	Suppression de l'envoi par mail
--	FPI - 12/09/2016 [VDoc21259] appel de PS_S_IRREP_PSM
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MENS_VDOC9850_PSM_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S_MENS_VDOC9850_PSM_MAIL
GO

CREATE procedure sysadm.PS_S_MENS_VDOC9850_PSM_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(500),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @iMois Integer
Declare @iAnnee Integer
Declare @iJour Integer
Declare @sFicOut2 VarChar(255) -- [VDoc17539]


-- chemin d'enregistrement du Result Set
--Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Extraction_PSM_Mens_vDoc9850\'
Set @sPath 	= '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_PSM_Mens_vDoc9850\'
Set @sFileName	= 'Export_PSM_Mens_vDoc9850'
Set @sFileExt	= 'xls'

Set @sFileName	= @sFileName + '_' + convert(varchar(10),getdate(),112) -- ITSM277720

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

Set @sFicOut2 = '\\F4T\Simpa2\O2M\irrep_PSM_Mensuel\' + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' -- + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_IRREP_PSM ''M'' ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_IRREP_PSM ''M'' ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

-- [VDoc17539]
IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_IRREP_PSM ''M'' ' + 
			'" /o' + @sFicOut2 + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_IRREP_PSM ''M'' ' + 
			'" /o' + @sFicOut2 + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output
-- :[VDoc17539]

-- [VDoc18783]
Set @sCommande=REPLACE(@sCommande,'Simpa2\O2M','Simpa2\PSM')
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output
-- :[VDoc18783]

Set @iMois = DATEPART ( month, GetDate() )
Set @iAnnee = DATEPART ( Year, GetDate() )
Set @iJour = 1

Set @dtDateFin = CONVERT ( DateTime,
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iJour ), 2 ) + '/' +
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iMois ), 2 ) + '/' +
				 Right ( '0000' + CONVERT ( VarChar ( 4 ) , @iAnnee ), 4 ),
				 103 )

Set @dtDateFin = DATEADD ( DAY, -1, @dtDateFin ) 

Set @iMois = DATEPART ( month, @dtDateFin )
Set @iAnnee = DATEPART ( Year, @dtDateFin )

Set @dtDateDeb = CONVERT ( DateTime,
			  	 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iJour ), 2 ) + '/' +
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iMois ), 2 ) + '/' +
				 Right ( '0000' + CONVERT ( VarChar ( 4 ) , @iAnnee ), 4 ),
				 103 )


Set @sObjet    = 'Extraction des irréparables SPB/PSM pour recyclage O2M, du ' + Convert ( VarChar ( 10), @dtDateDeb, 103 ) + ' au ' + Convert ( VarChar ( 10), @dtDateFin, 103 )

set @sMessage  = 'Bonjour,'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Vous trouverez ci-jointe l''extraction mensuelle reprenant les prestations PSM impliquant des mobiles irréparables et ainsi destinés au recyclage O2M, entre le ' + Convert ( VarChar ( 10), @dtDateDeb, 103 ) + ' et le ' + Convert ( VarChar ( 10), @dtDateFin, 103 ) + '.'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Cordialement,'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'SPB.'

/* incompréhensible, renvoi 1 donc erreur alors que tout est ok, le fichier est écrit, complet et sans erreur
if @iRetOsql <> 0
 BEGIN
 	set @sMessage  = 'ATTENTION : Le fichier généré comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DSI.'
	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'jff@spb.eu',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL
 END
Else
*/
 /*Begin
	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'martine.bocquillon@allopsm.fr, charles.bocquillon@allopsm.fr, frederic.billy@allopsm.fr, suivi_prestataires@spb.eu, j.calvini@o2m.fr, a.blanco@o2m.fr, c.malle@spb-services.eu, s.aunancy@o2m.fr, p.brossier@o2m.fr, jff@spb.eu',
--			'jff@spb.eu',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL
 End*/

Go

grant execute on sysadm.PS_S_MENS_VDOC9850_PSM_MAIL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S_DOS_CASTO_SANS_ACTION
-- Auteur               :       JFF
-- Date                 :       09/07/2013
-- Libellé              :       [PC509-2]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- JFF  24/09/2013  [PC13288]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_DOS_CASTO_SANS_ACTION' AND type = 'P' )
        DROP procedure sysadm.DW_S_DOS_CASTO_SANS_ACTION
GO

CREATE procedure sysadm.DW_S_DOS_CASTO_SANS_ACTION
AS

Select s.id_sin,
	   convert ( varchar(10), s.dte_decl, 103 ) 'dte_decl',
	   convert ( varchar(10), s.dte_surv, 103 ) 'dte_surv',
	   ( Select top 1 cg.lib_gti
		 From   sysadm.code_garantie cg
		 Where  cg.id_prod = s.id_prod
		 And    cg.id_gti = d.id_gti ) 'Garantie',	   
	   d.id_detail,
	   d.mt_val_achat,
	   sysadm.FN_CODE_NUM ( d.id_evt, '+EV') 'Catégorie',
	  ( Select top 1 rtrim ( dd.val_car)
	    From   sysadm.div_det dd
	    Where  dd.id_sin = d.id_sin
	    And    dd.id_gti = d.id_gti
		And	   dd.id_detail = d.id_detail	    
	    And    dd.nom_zone = 'marq_app' ) 'Marque',
	  ( Select top 1 rtrim ( dd.val_car)
	    From   sysadm.div_det dd
	    Where  dd.id_sin = d.id_sin
	    And    dd.id_gti = d.id_gti
		And	   dd.id_detail = d.id_detail	    
	    And    dd.nom_zone = 'modl_app' ) 'Appareil',
	   ( Select top 1 ds.val_nbre
	     From   sysadm.div_sin ds
	     Where  ds.id_sin = s.id_sin
	     And    ds.nom_zone = 'num_mag' ) 'num_mag',
	   IsNull (
	   ( Select top 1 ISNULL ( rtrim( adr_nom ) , '(pas de nom de magasin)') + ', région ' + ISNULL ( rtrim( region ), '(Pas de region)') + ', ville ' + ISNULL ( rtrim( adr_ville ), '(pas de ville)')
	     From   sysadm.boutique b,
				sysadm.div_sin ds
	     Where  ds.id_sin = s.id_sin 
	     And    ds.nom_zone = 'num_mag'
	     And    b.id_prod = s.id_prod
	     And	b.cod_mag = Convert ( varchar ( 20), ds.val_nbre )), 'Aucune info sur le magasin' )  'lib_mag',
	   convert ( varchar(10), s.valide_le , 103 ) + ' ' + CONVERT (varchar(8), s.valide_le , 108) 'Derniere_validation_SPB',
	   'Aucune action de Castorama' 'Action Castorama',
	   p.nom 'nom_assure', 
		p.prenom 'prenom_assure'	
	     
from   sysadm.sinistre s,
	   sysadm.detail d,
	   sysadm.personne p
Where  s.id_prod between 23400 and 23499
and    d.id_sin = s.id_sin
and    p.id_ordre=s.id_ordre
and    d.id_gti <> 10
and    s.cod_etat in ( 100, 550 )
and    Not exists ( 
			Select *
			From	sysadm.div_det dd
			Where	dd.id_sin = d.id_sin
			And		dd.id_gti = d.id_gti
			And		dd.id_detail = d.id_detail
			And		dd.nom_zone = 'cod_action'
		)
Order by s.valide_le, s.id_sin, d.id_detail

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S017_LSTREG_AMTRUST
-- Auteur               :       FPI
-- Date                 :       07/08/2013
-- Libellé              :       [PC473-1]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- V01 - 23/10/2013	FPI	[VDoc12558] Ajout colonne "Certificate Number"
-- V02 - 03/04/2014	FPI [VDoc14135] Ajout colonne evt
--       16/03/2016 FPI [VDoc20236] Certificate Number différent pour le produit 859
-- JFF      12/02/2016   [PI062]
-- FPI	05/09/2016	[VDoc21529]
-- FPI	13/10/2017	[VDoc24809] en att SKZ
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S017_LSTREG_AMTRUST_V02' AND type = 'P' )
        DROP procedure sysadm.PS_S017_LSTREG_AMTRUST_V02
GO

CREATE procedure sysadm.PS_S017_LSTREG_AMTRUST_V02 
	@dtDteDeb       DateTime        ,
    @dtDteFin       DateTime	,
    @dcIdCie		Decimal(4,0)

AS

Declare @sIdCie varchar(4)

Set @sIdCie=CONVERT(varchar(4),@dcIdCie)

SET NOCOUNT ON

select 'Program Name'=sysadm.FN_CLE_VAL('NOM_PRODUIT',dp.val_car,';'), 
       'Claims Reference Number'=s.id_sin,
       'Customer Policy Number'=po.lib_police,
       'Insured Customer Name'=rtrim(p.nom) + ' ' + rtrim(ISNULL(p.prenom,'')),
       'Customer Address'= rtrim(p.adr_1) + case when p.adr_2 is null Then ''
             Else ' ' + rtrim(ISNULL(p.adr_2,'')) End + 
             ' ' + rtrim(p.adr_ville),
       'Customer Post Code' = p.adr_cp,
       'Manufacturer'=s.marq_port,
       'Appliance Code'=s.modl_port,
       'Appliance desc'=sysadm.FN_CODE_CAR(ds.val_car,'-AR'),
       'Serial Number'=s.num_imei_port,
       'Policy duration'=convert(varchar(2),pdt.dur_perrnv_adh) + ' ' +
             Case unt_perrnv_adh when 'A' Then 'year(s)'
                    When 'M' then 'month(s)' End,
       'Policy Cover'=sysadm.FN_CODE_NUM(rg.id_gti,'-GA'),
       'Claims Limit'=Case when d.id_detail IS not null Then d.mt_plaf 
             else f.mt_frais End,
       'Date of Purchase of the Appliance'=convert(varchar(10),s.dte_ach_port,103),
       'Start Date of Policy'=convert(varchar(10),s.dte_sous,103),
       'Expiry Date of Policy'=convert(varchar(10),s.dte_fin_gti,103),
       'Claims Failure Date'=convert(varchar(10),s.dte_surv,103),
       'Claims Payment Date '=convert(varchar(10),r.dte_reg,103),
       'Claims Status'=sysadm.FN_CODE_NUM(s.cod_etat,'-ET'),
       'VAT'=convert(decimal(11,2),r.mt_tot_reg - ROUND(r.mt_tot_reg/1.2,2)), -- [PI062] 11,2 ald 7,2 et 1.2 ald 1.196
       'Total Claims Cost'=r.mt_tot_reg,
       'Certificate Number'=Case When s.id_prod between 85900 and 85999 Then isNull(s.id_contrat_abonne,'NC')
             When convert(decimal(19,0),s.id_adh) between 800000 and 1200000 and s.id_sdos=0 Then 'NC'
             Else convert(varchar(7), pdt.cod_prod_dms) + '-' + Right('00000' + convert(varchar(7),s.id_ets),5) + '-' +
                    Right('0000000' + rtrim(isnull(base.dosad_no_doss,s.id_adh)),7)  + '-1'  End,
       'Event type'=Case When f.id_frais IS null Then sysadm.FN_CODE_NUM(d.id_evt,'+EV')
             else 'Frais d''envoi' End
From sysadm.reg_gti rg 
inner join sysadm.sinistre s on rg.id_sin=s.id_sin
inner join sysadm.det_pro dp on dp.id_prod=s.id_prod
inner join sysadm.garantie g on g.id_prod=s.id_prod and g.id_rev=s.id_rev 
inner join sysadm.police po on po.id_police=g.id_police
inner join sysadm.reglement r on r.id_sin=rg.id_sin and r.id_reg=rg.id_reg
inner join sysadm.personne p on p.id_ordre=s.id_ordre
inner join sysadm.div_sin ds on ds.id_sin=s.id_sin
inner join sysadm.produit pdt on pdt.id_prod=s.id_prod
-- VDoc 21529 - left join FUS_DOSAD
left outer join FUS_DOSAD_PRO.dbo.dosad a on a.dosad_code_prod=pdt.cod_prod_dms 
	and a.dosad_ets=s.id_ets and dosad_no_sdoss=s.id_sdos
	and a.dosad_no_doss=Case When isnumeric(s.id_adh)=0 Then 0 Else convert(int,s.id_adh) End
left outer join FUS_DOSAD_PRO.dbo.dosad base on base.dosad_code_prod = a.dosad_code_prod and
   base.dosad_ets = a.dosad_ets and
   base.dosad_no_doss = Case When pdt.cod_prod_dms=863 and isnumeric(a.dosad_refe_bqe) = 1 Then left ( a.dosad_refe_bqe, len ( a.dosad_refe_bqe ) - 1 ) 
	Else (Case When isnumeric(s.id_adh)=0 Then 0 Else convert(int,s.id_adh) End) End and
	base.dosad_no_sdoss = 1
left outer join sysadm.detail d on d.id_sin=s.id_sin and d.id_reg=r.id_reg
left outer join sysadm.frais f on f.id_sin=s.id_sin and f.id_reg=r.id_reg
where ds.nom_zone='type_app'
and r.dte_reg between    @dtDteDeb And @dtDteFin 
and g.id_gti=case when rg.id_gti=-1 Then
				( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = s.id_sin )
					  Else rg.id_gti End
and po.id_cie in (129,133) -- [VDoc24809]
and dp.id_code_dp=245
and sysadm.FN_CLE_VAL('ID_CIE',dp.val_car,';') = @sIdCie
and r.cod_mot_reg not in ( 'RI' ) -- [ITSM308117]

Go

grant execute on sysadm.PS_S017_LSTREG_AMTRUST_V02 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S018_LSTREG_RASSUREO
-- Auteur               :       FPI
-- Date                 :       19/08/2013
-- Libellé              :       [PC932]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- 		23/10/2013	FPI	V01 - [PC932].Mantis9145
--		06/02/2014	FPI	[ITSM198416] r.cree_le en critère ald dte_reg
-- JFF      12/05/2020   [PI085]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S018_LSTREG_RASSUREO_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S018_LSTREG_RASSUREO_V01
GO

CREATE procedure sysadm.PS_S018_LSTREG_RASSUREO_V01
	@dtDteDeb       DateTime        ,
    @dtDteFin       DateTime	

AS

select ds.val_car as 'Point de vente ou Centrale',
	RTRIM(p.nom) + case when p.prenom is not null then ' ' + RTRIM(p.prenom) Else '' End as 'Nom de l''adhérent',
--	CONVERT(varchar(3), pr.cod_prod_dms) + '-' + CONVERT(varchar(5), s.id_ets) + '-' + RTRIM(s.id_adh) + CONVERT(varchar(1), s.id_sdos) as 'N° bulletin d''adhésion', -- [PI085]
	CONVERT(varchar(5), pr.cod_prod_dms) + '-' + CONVERT(varchar(5), s.id_ets) + '-' + RTRIM(s.id_adh) + CONVERT(varchar(1), s.id_sdos) as 'N° bulletin d''adhésion', -- [PI085]
	CONVERT(varchar(10),s.dte_adh,103) as 'Date d''effet de la garantie',
	CONVERT(varchar(10),s.dte_fin_gti,103) as 'Date de fin de garantie',
	RTRIM(s.marq_port) + ' ' + RTRIM(s.modl_port) as 'Modèle du Smartphone garanti',
	s.num_imei_port as 'N° IMEI',
	CONVERT(varchar(10),s.dte_surv,103) as 'Date de survenance du sinistre',
	sysadm.FN_CODE_NUM(s.id_natsin,'+NS') as 'Motif du sinistre',
	Case When exists (select * from sysadm.commande c 
			where c.id_sin=s.id_sin and c.cod_etat <> 'ANN' and c.id_typ_art='PRS') Then 'Réparation'
		When exists (select * from sysadm.commande c 
			where c.id_sin=s.id_sin and c.cod_etat <> 'ANN' and c.id_typ_art='TEL') Then 'Remplacement'
		Else 'Remboursement' End as 'Prise en charge',
	rg.mt_reg as 'Montant de l''indemnité'
from sysadm.sinistre s
inner join sysadm.produit pr on s.id_prod=pr.id_prod
inner join sysadm.reg_gti rg on rg.id_sin=s.id_sin
inner join sysadm.personne p on s.id_ordre=p.id_ordre
left outer join sysadm.div_sin ds on ds.id_sin=s.id_sin and ds.nom_zone='cod_boutique_adh' -- [PC932].Mantis9145
inner join sysadm.reglement r on r.id_sin=rg.id_sin and r.id_reg=rg.id_reg
inner join sysadm.garantie g on g.id_prod=s.id_prod and g.id_rev=s.id_rev 
inner join sysadm.police po on po.id_police=g.id_police
left outer join sysadm.detail d on d.id_sin=s.id_sin and d.id_reg=r.id_reg
left outer join sysadm.frais f on f.id_sin=s.id_sin and f.id_reg=r.id_reg
where pr.cod_prod_dms=818
and r.cree_le between    @dtDteDeb And @dtDteFin 
and g.id_gti=case when rg.id_gti=-1 Then
				( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = s.id_sin )
					  Else rg.id_gti End

-- [PM266]
AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
    Or
	Not Exists ( 
		Select 1
		From   sysadm.exclu_ass ex
		Where  ex.id_cie = po.id_cie
		)
  ) 

Go

grant execute on sysadm.PS_S018_LSTREG_RASSUREO_V01 to rolebddsinistres
Go		


--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_VDOC12215_TRV_ORANGE_O2M
-- Auteur               :       JFF
-- Date                 :       23/09/2009
-- Libellé              :       Extraction Travaux ORANGE
-- Commentaires         :       
-- Références           :       [VDOC12215]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		    PAR		 Description
-- vDoc12316     03/10/2013  JFF Modif CGI par DUE
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC12215_TRV_ORANGE_O2M' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC12215_TRV_ORANGE_O2M
GO

CREATE procedure sysadm.PS_S_VDOC12215_TRV_ORANGE_O2M
AS

Update	sysadm.w_queue
Set		dos_maj_par = 'DUE' -- vDoc12316
from	sysadm.produit p,
		sysadm.w_queue wq,
		sysadm.commande c
Where p.id_prod between 9100 and 9199
and not exists ( Select *
				 From sysadm.det_pro d
				 Where d.id_code_dp = 239
				 And   d.id_prod = p.id_prod
				  )
and wq.id_prod = p.id_prod
 and c.id_sin = wq.id_sin
 and c.id_four = 'O2M'
 and c.status_gc = 151
and wq.trv_maj_par <> 'ML'
And Not exists ( 
		Select *
		From sysadm.commande c1
		Where c1.id_sin = c.id_sin
		and   c1.id_ref_four in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP' )
		) 


Select	wq.trv_maj_par, 
		convert ( varchar(10), wq.trv_cree_le, 103 ) + ' ' + CONVERT (varchar(8), wq.trv_cree_le, 108) 'trv_cree_le',
		wq.id_sin, 
		wq.id_prod,
		sysadm.FN_LIB_PROD ( wq.id_prod ) 'lib_lprod',
		'Présence d''une presta de diag en retour conforme 151' 'info'
		
from sysadm.produit p,
	 sysadm.w_queue wq,
	 sysadm.commande c
Where p.id_prod between 9100 and 9199
and not exists ( Select *
				 From sysadm.det_pro d
				 Where d.id_code_dp = 239
				 And   d.id_prod = p.id_prod
				  )
and wq.id_prod = p.id_prod
 and c.id_sin = wq.id_sin
 and c.id_four = 'O2M'
 and c.status_gc = 151
and wq.trv_maj_par <> 'ML'
And Not exists ( 
		Select *
		From sysadm.commande c1
		Where c1.id_sin = c.id_sin
		and   c1.id_ref_four in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP' )
		)
order by wq.trv_cree_le

Go

--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_VDOC12215_TRV_ORANGE_O2M_MAIL
-- Auteur               :       JFF
-- Date                 :       23/09/2009
-- Libellé              :       Extraction Travaux ORANGE
-- Commentaires         :       
-- Références           :       [VDOC12215]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC12215_TRV_ORANGE_O2M_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC12215_TRV_ORANGE_O2M_MAIL
GO

CREATE procedure sysadm.PS_S_VDOC12215_TRV_ORANGE_O2M_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Extraction_vDoc12215_Trv_Orange\'
Set @sFileName	= 'VDOC12215_TRV_ORANGE_O2M_CONFORME'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_VDOC12215_TRV_ORANGE_O2M ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_VDOC12215_TRV_ORANGE_O2M ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = 'Extraction VDOC12215_TRV_ORANGE_O2M_CONFORME'
set @sMessage  = 'Veuillez trouver ci-joint l''extraction des travaux Ornage (hors orange V3) ayant une presta de diagnostic conforme et pas de pec_a_recycler ni de refuse_a_reexp.'

if @iRetOsql <> 0
BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DES.'
END

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
--		'jff@spb.eu',
		'kzig@spb.eu,pfermey@spb.eu',
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL


Go

grant execute on sysadm.PS_S_VDOC12215_TRV_ORANGE_O2M_MAIL to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_VDOC12405_M_MANTEAU
-- Auteur               :       JFF
-- Date                 :       10/10/2013
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [VDOC12405]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		    PAR		 Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC12405_M_MANTEAU' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC12405_M_MANTEAU
GO

CREATE procedure sysadm.PS_S_VDOC12405_M_MANTEAU
AS

Select 'Produit 35800 à 35803 et 80500 à 80503',
	   Min ( Convert ( VarChar ( 20), DATEADD ( month, -1, GETDATE()),103)) 'Du',
	   Min ( Convert ( VarChar ( 20), DATEADD ( day, -1, GETDATE()),103)) 'Au',
	   c.id_four,
	   sysadm.FN_CODE_CAR ( c.id_four, '-FR' ) 'lib_four',
       SUM ( 1 )  'Demande_de_reparation_vers_le_fournisseur',
	   SUM ( Case When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' Then 1 Else 0 End  ) as 'Nbre_en_pdv' ,
       SUM ( Case When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' Then 1 Else 0 End ) 'Envoi_en_centralisation',
       SUM ( Case When dte_rcp_frn is not null Then 1 Else 0 End ) 'Appareil_recu',
       SUM ( Case When status_gc = 2 Then 1 Else 0 End ) 'Appareil_repare'

From   sysadm.sinistre s,
	   sysadm.commande c
Where  ( s.id_prod between 35800 and 35803 Or s.id_prod between 80500 and 80503 )
and    c.id_sin = s.id_sin
And    c.id_four in ( 'PSM', 'O2M' )
And    c.id_ref_four = 'A_REPARER'
And	   c.cree_le between DATEADD ( month, -1, GETDATE()) and DATEADD ( day, -1, GETDATE())
Group by  c.id_four,
	      sysadm.FN_CODE_CAR ( c.id_four, '-FR' ) 
Union all
Select 'Produit 35800 à 35803 et 80500 à 80503',
	   'Sans période',
	   'Sans période',
	   c.id_four,
	   sysadm.FN_CODE_CAR ( c.id_four, '-FR' ) 'lib_four',
       SUM ( 1 )  'Demande_de_reparation_vers_le_fournisseur',
	   SUM ( Case When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' Then 1 Else 0 End  ) as 'Nbre_en_pdv' ,
       SUM ( Case When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' Then 1 Else 0 End ) 'Envoi_en_centralisation',
       SUM ( Case When dte_rcp_frn is not null Then 1 Else 0 End ) 'Appareil_recu',
       SUM ( Case When status_gc = 2 Then 1 Else 0 End ) 'Appareil_repare'

From   sysadm.sinistre s,
	   sysadm.commande c
Where  ( s.id_prod between 35800 and 35803 Or s.id_prod between 80500 and 80503 )
and    c.id_sin = s.id_sin
And    c.id_four in ( 'PSM', 'O2M' )
And    c.id_ref_four = 'A_REPARER'
Group by c.id_four,
	      sysadm.FN_CODE_CAR ( c.id_four, '-FR' ) 

Go

--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_VDOC12405_M_MANTEAU_MAIL
-- Auteur               :       JFF
-- Date                 :       10/10/2013
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [VDOC12405]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC12405_M_MANTEAU_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC12405_M_MANTEAU_MAIL
GO

CREATE procedure sysadm.PS_S_VDOC12405_M_MANTEAU_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Extraction_vDoc12405_M_Manteau\'
Set @sFileName	= 'VDOC12405_M_MANTEAU'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_VDOC12405_M_MANTEAU ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_VDOC12405_M_MANTEAU ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = 'Extraction VDOC12405'
set @sMessage  = 'Veuillez trouver ci-joint l''extraction lié à la vDoc12405.'

if @iRetOsql <> 0
BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DES.'
END

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
--		'jff@spb.eu',
		'mmanteau@spb.eu',
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL


Go

grant execute on sysadm.PS_S_VDOC12405_M_MANTEAU_MAIL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_VDOC12748_1_CQUERTIER_ORV3
-- Auteur               :       JFF
-- Date                 :       12/11/2013
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [VDOC12748]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		    PAR		 Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC12748_1_CQUERTIER_ORV3' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC12748_1_CQUERTIER_ORV3
GO

CREATE procedure sysadm.PS_S_VDOC12748_1_CQUERTIER_ORV3
AS

Set NoCount On

-- vDoc 12607
-- a. Le volume par jour des dossiers ouverts sur V3 
DECLARE @tb TABLE 
	( id_seq	integer	Identity ,
	  type_trt	Varchar ( 50 ) null,
	  nbre		integer null,
	  cree_le	DateTime
	)

Insert into @tb 
Select 'a',
	   COUNT ( *) 'a/ Nbre ouvert par jour sur Orange V3 (-dp/239)',
	   Convert ( VarChar ( 4), YEAR ( s.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( s.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  s.cree_le )), 2)	'Date'
from	sysadm.det_pro d,
		sysadm.sinistre s
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
Group by Convert ( VarChar ( 4), YEAR ( s.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( s.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  s.cree_le )), 2)


Union all
-- b.1. Casse - Réparation en proximité (hors Apple et hors Oxydation) 
Select 'b1',
	   COUNT ( *) 'b/1/ Nbre Casse - Réparation en proximité (hors Apple et hors Oxydation)',
	   Convert ( VarChar ( 4), YEAR ( s.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( s.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  s.cree_le )), 2)	'Date'
from	sysadm.det_pro d,
		sysadm.sinistre s,
		sysadm.commande c
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
And    c.id_sin = s.id_sin
And    c.id_gti = 11
And    sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', RTRIM ( c.info_frn_spb_cplt), ';' ) = 'OUI'
And    s.marq_port <> 'APPLE'
And    c.id_ref_four <> 'A_DESOXYDER'
Group by Convert ( VarChar ( 4), YEAR ( s.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( s.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  s.cree_le )), 2)
Union all

-- b.2. Casse - Réparation en centralisation sans appareil de prêt (y compris Apple) 
Select 'b2',
	   COUNT ( *) 'b/2/ Casse - Réparation en centralisation sans appareil de prêt (y compris Apple)',
	   Convert ( VarChar ( 4), YEAR ( s.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( s.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  s.cree_le )), 2)	'Date'
from	sysadm.det_pro d,
		sysadm.sinistre s,
		sysadm.commande c
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
And    c.id_sin = s.id_sin
And    c.id_gti = 11
And    sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', RTRIM ( c.info_frn_spb_cplt), ';' ) <> 'OUI'
And    sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', RTRIM ( c.info_frn_spb_cplt), ';' ) = 'OUI'
And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( c.info_spb_frn_cplt), ';' ) <> 'PRET'
Group by Convert ( VarChar ( 4), YEAR ( s.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( s.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  s.cree_le )), 2)
Union all

-- b.3. Oxydation - Réparation en centralisation avec appareil de prêt 
Select 'b3',
	   COUNT ( *) 'b/3/ Oxydation - Réparation en centralisation avec appareil de prêt',
	   Convert ( VarChar ( 4), YEAR ( s.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( s.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  s.cree_le )), 2)	'Date'
from	sysadm.det_pro d,
		sysadm.sinistre s,
		sysadm.commande c
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
And    c.id_sin = s.id_sin
And    sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', RTRIM ( c.info_frn_spb_cplt), ';' ) <> 'OUI'
And    sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', RTRIM ( c.info_frn_spb_cplt), ';' ) = 'OUI'
And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( c.info_spb_frn_cplt), ';' ) = 'PRET'
And    c.id_ref_four = 'A_DESOXYDER'
Group by Convert ( VarChar ( 4), YEAR ( s.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( s.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  s.cree_le )), 2) 
Union all

-- b.4. Oxydation - Réparation en centralisation sans appareil de prêt 
Select 'b4',
	   COUNT ( *) 'b/4/ Oxydation - Réparation en centralisation sans appareil de prêt',
	   Convert ( VarChar ( 4), YEAR ( s.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( s.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  s.cree_le )), 2)	'Date'
from	sysadm.det_pro d,
		sysadm.sinistre s,
		sysadm.commande c
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
And    c.id_sin = s.id_sin
And    sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', RTRIM ( c.info_frn_spb_cplt), ';' ) <> 'OUI'
And    sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', RTRIM ( c.info_frn_spb_cplt), ';' ) = 'OUI'
And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( c.info_spb_frn_cplt), ';' ) <> 'PRET'
And    c.id_ref_four = 'A_DESOXYDER'
Group by Convert ( VarChar ( 4), YEAR ( s.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( s.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  s.cree_le )), 2) 
Union all

-- b.5. Casse et Oxydation – SWAP (y compris Apple) 
Select 'b5', 
	   COUNT ( *) 'b/5/ Casse et Oxydation – SWAP (y compris Apple)',
	   Convert ( VarChar ( 4), YEAR ( s.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( s.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  s.cree_le )), 2)	'Date'
from	sysadm.det_pro d,
		sysadm.sinistre s,
		sysadm.commande c
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
And    c.id_sin = s.id_sin
And    c.id_gti in ( 11, 24 )
And    c.id_typ_art Not in ( 'DEV', 'CAF', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'RST', 'PST', 'RES', 'REA', 'PRS', 'EDI' )
Group by Convert ( VarChar ( 4), YEAR ( s.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( s.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  s.cree_le )), 2) 
Union all

-- b.6. Vol - Process classique sans envoi immédiat d’un appareil de remplacement : demande de pièces 
Select 'b6',
	   COUNT ( *) 'b/6/ Vol - Process classique sans envoi immédiat d’un appareil de remplacement : demande de pièces',
	   Convert ( VarChar ( 4), YEAR ( s.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( s.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  s.cree_le )), 2)	'Date'
from	sysadm.det_pro d,
		sysadm.sinistre s,
		sysadm.gar_sin g
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
And    g.id_sin = s.id_sin
And    g.id_gti in ( 10 )
And    Not Exists ( 
	Select  *
	From	sysadm.commande c
	Where   c.id_sin = s.id_sin
	And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( c.info_spb_frn_cplt), ';' ) = 'PRET'
)
Group by Convert ( VarChar ( 4), YEAR ( s.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( s.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  s.cree_le )), 2) 
Union all

-- b.7. Vol - Envoi immédiat appareil de remplacement + caution 
Select 'b7',
	   COUNT ( *) 'b/7/ Vol - Envoi immédiat appareil de remplacement + caution',
	   Convert ( VarChar ( 4), YEAR ( s.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( s.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  s.cree_le )), 2)	'Date'
from	sysadm.det_pro d,
		sysadm.sinistre s,
		sysadm.gar_sin g
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
And    g.id_sin = s.id_sin
And    g.id_gti in ( 10 )
And    Exists ( 
	Select  *
	From	sysadm.commande c
	Where   c.id_sin = s.id_sin
	And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( c.info_spb_frn_cplt), ';' ) = 'PRET'
)
Group by Convert ( VarChar ( 4), YEAR ( s.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( s.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  s.cree_le )), 2) 


Select 'Total =>',
	   Convert ( varchar(10),Sum ( Case type_trt When 'a' Then nbre Else 0 End )) 'Total Nbre dossier ouverts',
	   Convert ( varchar(10),Sum ( Case type_trt When 'b1' Then nbre Else 0 End )) 'Total b1',
	   Convert ( varchar(10),Sum ( Case type_trt When 'b2' Then nbre Else 0 End ))'Total b2',
	   Convert ( varchar(10),Sum ( Case type_trt When 'b3' Then nbre Else 0 End )) 'Total b3',
	   Convert ( varchar(10),Sum ( Case type_trt When 'b4' Then nbre Else 0 End )) 'Total b4',
	   Convert ( varchar(10), Sum ( Case type_trt When 'b5' Then nbre Else 0 End )) 'Total b5',
	   Convert ( varchar(10),Sum ( Case type_trt When 'b6' Then nbre Else 0 End )) 'Total b6',
	   Convert ( varchar(10),Sum ( Case type_trt When 'b7' Then nbre Else 0 End )) 'Total b7'
from @tb
Union all
Select  Top 1
		'Date d''ouverture',
		'Nombre de dossiers ouverts',
		'Distinction b1',
		'Distinction b2',
		'Distinction b3',
		'Distinction b4',
		'Distinction b5',
		'Distinction b6',
		'Distinction b7'
from @tb		
Union all	
Select convert ( varchar(10), cree_le, 103 ) 'Date d''ouverture',
	   Convert ( varchar(10), Sum ( Case type_trt When 'a' Then nbre Else 0 End ))  'Nombre de dossiers ouverts',
	   Convert ( varchar(10), Sum ( Case type_trt When 'b1' Then nbre Else 0 End )) 'Distinction b1',
	   Convert ( varchar(10), Sum ( Case type_trt When 'b2' Then nbre Else 0 End )) 'Distinction b2',
	   Convert ( varchar(10), Sum ( Case type_trt When 'b3' Then nbre Else 0 End )) 'Distinction b3',
	   Convert ( varchar(10), Sum ( Case type_trt When 'b4' Then nbre Else 0 End )) 'Distinction b4',
	   Convert ( varchar(10), Sum ( Case type_trt When 'b5' Then nbre Else 0 End )) 'Distinction b5',
	   Convert ( varchar(10), Sum ( Case type_trt When 'b6' Then nbre Else 0 End )) 'Distinction b6',
	   Convert ( varchar(10), Sum ( Case type_trt When 'b7' Then nbre Else 0 End )) 'Distinction b7'
from @tb
Group by cree_le
--Order by 1 desc


Go


--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_VDOC12748_2_CQUERTIER_ORV3
-- Auteur               :       JFF
-- Date                 :       12/11/2013
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [VDOC12748]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		    PAR		 Description
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC12748_2_CQUERTIER_ORV3' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC12748_2_CQUERTIER_ORV3
GO


CREATE procedure sysadm.PS_S_VDOC12748_2_CQUERTIER_ORV3
AS

-- vDoc 12607
-- a. Le volume par jour des dossiers ouverts sur V3 
DECLARE @tb TABLE 
	( id_seq	integer	Identity ,
	  type_trt	Varchar ( 50 ) null,
	  id_sin	decimal (10), -- [PI062]
	  nbre		integer null
	)

Insert into @tb 
Select 'a',
	   s.id_sin,
	   COUNT ( *) 'a/ Nbre ouvert par jour sur Orange V3 (-dp/239)'
from	sysadm.det_pro d,
		sysadm.sinistre s
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
Group by s.id_sin
Union all

-- b.1. Casse - Réparation en proximité (hors Apple et hors Oxydation) 
Select 'b1',
	   s.id_sin,
	   COUNT ( *) 'b/1/ Nbre Casse - Réparation en proximité (hors Apple et hors Oxydation)'
from	sysadm.det_pro d,
		sysadm.sinistre s,
		sysadm.commande c
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
And    c.id_sin = s.id_sin
And    c.id_gti = 11
And    sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', RTRIM ( c.info_frn_spb_cplt), ';' ) = 'OUI'
And    s.marq_port <> 'APPLE'
And    c.id_ref_four <> 'A_DESOXYDER'
Group by s.id_sin
Union all

-- b.2. Casse - Réparation en centralisation sans appareil de prêt (y compris Apple) 
Select 'b2',
	   s.id_sin,
	   COUNT ( *) 'b/2/ Casse - Réparation en centralisation sans appareil de prêt (y compris Apple)'
from	sysadm.det_pro d,
		sysadm.sinistre s,
		sysadm.commande c
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
And    c.id_sin = s.id_sin
And    c.id_gti = 11
And    sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', RTRIM ( c.info_frn_spb_cplt), ';' ) <> 'OUI'
And    sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', RTRIM ( c.info_frn_spb_cplt), ';' ) = 'OUI'
And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( c.info_spb_frn_cplt), ';' ) <> 'PRET'
Group by s.id_sin
Union all

-- b.3. Oxydation - Réparation en centralisation avec appareil de prêt 
Select 'b3',
	   s.id_sin,
	   COUNT ( *) 'b/3/ Oxydation - Réparation en centralisation avec appareil de prêt'
from	sysadm.det_pro d,
		sysadm.sinistre s,
		sysadm.commande c
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
And    c.id_sin = s.id_sin
And    sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', RTRIM ( c.info_frn_spb_cplt), ';' ) <> 'OUI'
And    sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', RTRIM ( c.info_frn_spb_cplt), ';' ) = 'OUI'
And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( c.info_spb_frn_cplt), ';' ) = 'PRET'
And    c.id_ref_four = 'A_DESOXYDER'
Group by s.id_sin
Union all

-- b.4. Oxydation - Réparation en centralisation sans appareil de prêt 
Select 'b4',
	   s.id_sin,
	   COUNT ( *) 'b/4/ Oxydation - Réparation en centralisation sans appareil de prêt'
from	sysadm.det_pro d,
		sysadm.sinistre s,
		sysadm.commande c
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
And    c.id_sin = s.id_sin
And    sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', RTRIM ( c.info_frn_spb_cplt), ';' ) <> 'OUI'
And    sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', RTRIM ( c.info_frn_spb_cplt), ';' ) = 'OUI'
And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( c.info_spb_frn_cplt), ';' ) <> 'PRET'
And    c.id_ref_four = 'A_DESOXYDER'
Group by s.id_sin
Union all

-- b.5. Casse et Oxydation – SWAP (y compris Apple) 
Select 'b5', 
	   s.id_sin,
	   COUNT ( *) 'b/5/ Casse et Oxydation – SWAP (y compris Apple)'
from	sysadm.det_pro d,
		sysadm.sinistre s,
		sysadm.commande c
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
And    c.id_sin = s.id_sin
And    c.id_gti in ( 11, 24 )
And    c.id_typ_art Not in ( 'DEV', 'CAF', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'RST', 'PST', 'RES', 'REA', 'PRS', 'EDI' )
Group by s.id_sin
Union all

-- b.6. Vol - Process classique sans envoi immédiat d’un appareil de remplacement : demande de pièces 
Select 'b6',
	   s.id_sin,
	   COUNT ( *) 'b/6/ Vol - Process classique sans envoi immédiat d’un appareil de remplacement : demande de pièces'
from	sysadm.det_pro d,
		sysadm.sinistre s,
		sysadm.gar_sin g
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
And    g.id_sin = s.id_sin
And    g.id_gti in ( 10 )
And    Not Exists ( 
	Select  *
	From	sysadm.commande c
	Where   c.id_sin = s.id_sin
	And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( c.info_spb_frn_cplt), ';' ) = 'PRET'
)
Group by s.id_sin
Union all

-- b.7. Vol - Envoi immédiat appareil de remplacement + caution 
Select 'b7',
	   s.id_sin,
	   COUNT ( *) 'b/7/ Vol - Envoi immédiat appareil de remplacement + caution'
from	sysadm.det_pro d,
		sysadm.sinistre s,
		sysadm.gar_sin g
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
And    g.id_sin = s.id_sin
And    g.id_gti in ( 10 )
And    Exists ( 
	Select  *
	From	sysadm.commande c
	Where   c.id_sin = s.id_sin
	And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( c.info_spb_frn_cplt), ';' ) = 'PRET'
)
Group by s.id_sin

-- c. nombre de SC24
IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
 Begin
	Insert into @tb 
	Select 'SC24',
		   c.id_sin,
		   COUNT ( *) 'c/ nombre de SC24'
	From SHERPA_PRO.sysadm.contact c,
		 det_pro d
	Where d.id_code_dp = 239
	and c.id_prod = d.id_prod
	and c.id_nat_tache = 1130
	Group by c.id_sin
 End 
Else
 Begin
	Insert into @tb 
	Select 'SC24',
		   c.id_sin,
		   COUNT ( *) 'c/ nombre de SC24'
	From SHERPA_SIM.sysadm.contact c,
		 det_pro d
	Where d.id_code_dp = 239
	and c.id_prod = d.id_prod
	and c.id_nat_tache = 1130
	Group by c.id_sin
 End 


-- c. Alerte PM95
Insert into @tb 
Select 'PM95',
	   s.id_sin,
	   COUNT ( *) 'c. Alerte PM95'
from	sysadm.det_pro d,
		sysadm.sinistre s,
		sysadm.alerte_frn a
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
And    a.id_sin = s.id_sin
Group by s.id_sin

-- c. nombre de SC24+Autres
IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
 Begin
	Insert into @tb 
	Select 'AUTRE',
		   c.id_sin,
		   COUNT ( * ) 'c/ nombre de SC24+Autres'
	From SHERPA_PRO.sysadm.contact c,
		 SHERPA_PRO.sysadm.sinistre ssh,
		 det_pro d,
		 sinistre s
	Where d.id_code_dp = 239
	and s.id_prod = d.id_prod
	and ssh.id_appli = 2
	and ssh.id_sin = s.id_sin
	and c.id_cli = ssh.id_cli
	and c.id_sin = ssh.id_sin
	and c.id_prod = s.id_prod
	and c.id_nat_tache <> 1130
	Group by c.id_sin
 End
Else
 Begin
	Insert into @tb 
	Select 'AUTRE',
		   c.id_sin,
		   COUNT ( * ) 'c/ nombre de SC24+Autres'
	From SHERPA_SIM.sysadm.contact c,
		 SHERPA_SIM.sysadm.sinistre ssh,
		 det_pro d,
		 sinistre s
	Where d.id_code_dp = 239
	and s.id_prod = d.id_prod
	and ssh.id_appli = 2
	and ssh.id_sin = s.id_sin
	and c.id_cli = ssh.id_cli
	and c.id_sin = ssh.id_sin
	and c.id_prod = s.id_prod
	and c.id_nat_tache <> 1130
	Group by c.id_sin
 End


Select Convert ( Varchar ( 10 ), s.dte_decl, 103 ) 'Date de déclaration',
	   Convert ( Varchar ( 10 ), s.cree_le, 103  ) 'Date ouverture dossier',
	   s.id_sin   'Numéro de sinistre',
	   pe.nom 'Nom',
	   pe.prenom 'Prénom',
	   Convert ( Varchar ( 10 ), s.dte_surv, 103 )  'Date de survenance',
	   sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' ),
	   Sum ( Case t.type_trt When 'b1' Then nbre Else 0 End ) 'Distinction b1',
	   Sum ( Case t.type_trt When 'b2' Then nbre Else 0 End ) 'Distinction b2',
	   Sum ( Case t.type_trt When 'b3' Then nbre Else 0 End ) 'Distinction b3',
	   Sum ( Case t.type_trt When 'b4' Then nbre Else 0 End ) 'Distinction b4',
	   Sum ( Case t.type_trt When 'b5' Then nbre Else 0 End ) 'Distinction b5',
	   Sum ( Case t.type_trt When 'b6' Then nbre Else 0 End ) 'Distinction b6',
	   Sum ( Case t.type_trt When 'b7' Then nbre Else 0 End ) 'Distinction b7',
	   Sum ( Case t.type_trt When 'SC24' Then nbre Else 0 End ) 'Nbre de SC24',
	   Sum ( Case t.type_trt When 'PM95' Then nbre Else 0 End ) 'Nbre de PM95',
	   Sum ( Case t.type_trt When 'AUTRE' Then nbre Else 0 End ) 'Nbre de AUTRES'
From @tb t,
	 sysadm.sinistre s,
	 sysadm.personne pe
Where s.id_sin = t.id_sin
And   pe.id_ordre = s.id_ordre
Group by 
	   s.dte_decl ,
	   s.cree_le  ,
	   s.id_sin   ,
	   pe.nom  ,
	   pe.prenom ,
	   s.dte_surv,
	   sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' )
Order by s.cree_le

Go

--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_VDOC12748_1_CQUERTIER_ORV3_MAIL
-- Auteur               :       JFF
-- Date                 :       12/11/2013
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [VDOC12748]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		    PAR		 Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC12748_1_CQUERTIER_ORV3_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC12748_1_CQUERTIER_ORV3_MAIL
GO

CREATE procedure sysadm.PS_S_VDOC12748_1_CQUERTIER_ORV3_MAIL
AS

DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
        @sFicDel     VarChar(255),
		@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	,
	@sDest VarChar ( 200 )
	

-- chemin d'enregistrement du Result Set
Set @sPath 	= '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_vDoc12748_C_Quertier_ORV3\'
Set @sFileName	= 'VDOC12748_C_QUERTIER_1'
Set @sFileExt	= 'xls'

-- Set @sDest = 'cquertier@spb.eu,kzig@spb.eu,fguilbaud@spb.eu,SCARDENAS@spb.eu,RADAM@spb.eu'
-- Set @sDest = 'jff@spb.fr'


SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt
/*
Set @sFicDel = 'DEL ' + @sFicOut 
EXEC master.dbo.xp_cmdshell @sFicDel 
*/

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_VDOC12748_1_CQUERTIER_ORV3 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_VDOC12748_1_CQUERTIER_ORV3 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Go

grant execute on sysadm.PS_S_VDOC12748_1_CQUERTIER_ORV3_MAIL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_VDOC12748_2_CQUERTIER_ORV3_MAIL
-- Auteur               :       JFF
-- Date                 :       12/11/2013
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [VDOC12748]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		    PAR		 Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC12748_2_CQUERTIER_ORV3_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC12748_2_CQUERTIER_ORV3_MAIL
GO

CREATE procedure sysadm.PS_S_VDOC12748_2_CQUERTIER_ORV3_MAIL
AS

DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
        @sFicDel     VarChar(255),
		@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	,
	@sDest VarChar ( 200 )
	
-- chemin d'enregistrement du Result Set
Set @sPath 	= '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_vDoc12748_C_Quertier_ORV3\'
Set @sFileName	= 'VDOC12748_C_QUERTIER_2'
Set @sFileExt	= 'xls'


SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt
/*
Set @sFicDel = 'DEL ' + @sFicOut 
EXEC master.dbo.xp_cmdshell @sFicDel 
*/

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_VDOC12748_2_CQUERTIER_ORV3 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_VDOC12748_2_CQUERTIER_ORV3 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Go

grant execute on sysadm.PS_S_VDOC12748_2_CQUERTIER_ORV3_MAIL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_VDOC12795_CQUERTIER_ORV3
-- Auteur               :       JFF
-- Date                 :       12/11/2013
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [VDOC12748]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		    PAR		 Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC12795_CQUERTIER_ORV3' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC12795_CQUERTIER_ORV3
GO

CREATE procedure sysadm.PS_S_VDOC12795_CQUERTIER_ORV3
AS

select Convert ( VarChar ( 4), YEAR ( m.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( m.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  m.cree_le )), 2)	'Date', 
	   m.id_prod, 
	   sysadm.FN_LIB_PROD ( m.id_prod ),
	   CONVERT ( VarChar ( 50 ), SUM(Case when m.mail_id_erreur IS not null and  m.mail_id_erreur<> 0 then 1 else 0 end)) as 'Nbre_Echec_Total', 
	   CONVERT ( VarChar ( 50 ), SUM(Case when m.mail_id_erreur = 550 then 1 else 0 end)) as 'Nbre_Echec_Adress_Mail_Erronée',
	   CONVERT ( VarChar ( 50 ), SUM(Case when m.mail_id_erreur = 552 then 1 else 0 end)) as 'Nbre_Echec_Manque_De_Ressource_De_Stockage',
	   CONVERT ( VarChar ( 50 ), SUM(Case when m.mail_id_erreur = 554 then 1 else 0 end)) as 'Nbre_Echec_Transaction_Avortée',
	   CONVERT ( VarChar ( 50 ), SUM(Case when m.mail_id_erreur Not in ( 550, 552, 554 ) And m.mail_id_erreur IS not null and  m.mail_id_erreur<> 0 then 1 else 0 end)) as 'Nbre_Echec_Autre_Cas',
	   COUNT(*) 'Nbre_Total_Mails_Envoyé'
from TRACE_MAIL_PRO.sysadm.mail_push m,
	 sysadm.det_pro d
where d.id_code_dp = 239
and   m.id_prod = d.id_prod
group by Convert ( VarChar ( 4), YEAR ( m.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( m.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  m.cree_le )), 2), 
	   m.id_prod, 
	   sysadm.FN_LIB_PROD ( m.id_prod )
Union all
select null,
	   null,
	   null,
	   CONVERT ( VarChar ( 50 ), SUM(Case when m.mail_id_erreur IS not null and  m.mail_id_erreur<> 0 then 1 else 0 end)) as 'Nbre_Echec_Total', 
	   CONVERT ( VarChar ( 50 ), SUM(Case when m.mail_id_erreur = 550 then 1 else 0 end)) as 'Nbre_Echec_Adress_Mail_Erronée',
	   CONVERT ( VarChar ( 50 ), SUM(Case when m.mail_id_erreur = 552 then 1 else 0 end)) as 'Nbre_Echec_Manque_De_Ressource_De_Stockage',
	   CONVERT ( VarChar ( 50 ), SUM(Case when m.mail_id_erreur = 554 then 1 else 0 end)) as 'Nbre_Echec_Transaction_Avortée',
	   CONVERT ( VarChar ( 50 ), SUM(Case when m.mail_id_erreur Not in ( 550, 552, 554 ) And m.mail_id_erreur IS not null and  m.mail_id_erreur<> 0 then 1 else 0 end)) as 'Nbre_Echec_Autre_Cas',
	   COUNT(*) 'Nbre_Total_Mails_Envoyé'
from TRACE_MAIL_PRO.sysadm.mail_push m,
	 sysadm.det_pro d
where d.id_code_dp = 239
and   m.id_prod = d.id_prod
Union all
select null,
	   null,
	   null,
	   CONVERT ( VarChar ( 50 ),
		CONVERT ( Decimal ( 11,2),
		 CONVERT ( VarChar ( 50 ),
	      Round ( (
	       convert ( Decimal ( 11,2), 
	       SUM(Case when m.mail_id_erreur IS not null and  m.mail_id_erreur<> 0 then 1 else 0 end))
		   /
		   convert ( Decimal ( 11,2), IsNull ( NullIf ( COUNT(*), 0 ), 1 ))) * 100, 2 )))) + '%' as 'Nbre_Echec_Total' ,
	   CONVERT ( VarChar ( 50 ),
		CONVERT ( Decimal ( 11,2),
		 CONVERT ( VarChar ( 50 ),
	      Round ( (
	       convert ( Decimal ( 11,2), 
		   SUM(Case when m.mail_id_erreur = 550 then 1 else 0 end))
		   /
		   convert ( Decimal ( 11,2), IsNull ( NullIf ( COUNT(*), 0 ), 1 ))) * 100, 2 )))) + '%' as 'Nbre_Echec_Adress_Mail_Erronée',
	   CONVERT ( VarChar ( 50 ),
		CONVERT ( Decimal ( 11,2),
		 CONVERT ( VarChar ( 50 ),
	      Round ( (
	       convert ( Decimal ( 11,2), 
		   SUM(Case when m.mail_id_erreur = 552 then 1 else 0 end)) 
		   /
		   convert ( Decimal ( 11,2), IsNull ( NullIf ( COUNT(*), 0 ), 1 ))) * 100, 2 )))) + '%' as 'Nbre_Echec_Manque_De_Ressource_De_Stockage',
	   CONVERT ( VarChar ( 50 ),
		CONVERT ( Decimal ( 11,2),
		 CONVERT ( VarChar ( 50 ),
	      Round ( (
	       convert ( Decimal ( 11,2), 
		   SUM(Case when m.mail_id_erreur = 554 then 1 else 0 end)) 
		   /
		   convert ( Decimal ( 11,2), IsNull ( NullIf ( COUNT(*), 0 ), 1 ))) * 100, 2 )))) + '%' as 'Nbre_Echec_Transaction_Avortée',
	   CONVERT ( VarChar ( 50 ),
		CONVERT ( Decimal ( 11,2),
		 CONVERT ( VarChar ( 50 ),
	      Round ( (
	       convert ( Decimal ( 11,2), 
		   SUM(Case when m.mail_id_erreur Not in ( 550, 552, 554 ) And m.mail_id_erreur IS not null and  m.mail_id_erreur<> 0 then 1 else 0 end))
		   /
		   convert ( Decimal ( 11,2), IsNull ( NullIf ( COUNT(*), 0 ), 1 ))) * 100, 2 )))) + '%' as 'Nbre_Echec_Autre_Cas',
	   null 'Nbre_Total_Mails_Envoyé'
	   
from TRACE_MAIL_PRO.sysadm.mail_push m,
	 sysadm.det_pro d
where d.id_code_dp = 239
and   m.id_prod = d.id_prod
order by Convert ( VarChar ( 4), YEAR ( m.cree_le ) ) +  Right ( '00' + Convert ( VarChar ( 4), Month ( m.cree_le )), 2) + Right ( '00' + Convert ( VarChar ( 4), Day (  m.cree_le )), 2) 


Go

--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_VDOC12795_CQUERTIER_ORV3_MAIL
-- Auteur               :       JFF
-- Date                 :       12/11/2013
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [VDOC12748]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		    PAR		 Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC12795_CQUERTIER_ORV3_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC12795_CQUERTIER_ORV3_MAIL
GO

CREATE procedure sysadm.PS_S_VDOC12795_CQUERTIER_ORV3_MAIL
AS

DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
        @sFicDel     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	,
	@sDest VarChar ( 200 )
	

-- chemin d'enregistrement du Result Set
Set @sPath 	= '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_vDoc12795_C_Quertier_ORV3\'
Set @sFileName	= 'VDOC12795_C_QUERTIER'
Set @sFileExt	= 'xls'

-- Set @sDest = 'cquertier@spb.eu,kzig@spb.eu,fguilbaud@spb.eu,SCARDENAS@spb.eu,RADAM@spb.eu'
-- Set @sDest = 'jff@spb.fr'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt
Set @sFicDel = 'DEL ' + @sFicOut 
EXEC xp_cmdshell @sFicDel 

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_VDOC12795_CQUERTIER_ORV3 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_VDOC12795_CQUERTIER_ORV3 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

/*
Set @sObjet    = 'Extraction VDOC12748 / 1'
set @sMessage  = 'Veuillez trouver ci-joint l''extraction lié à la vDoc12748 / 1.'

if @iRetOsql <> 0
BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DES.'
END

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		@sDest,
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL
*/


Go

grant execute on sysadm.PS_S_VDOC12795_CQUERTIER_ORV3_MAIL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_VDOC12921_V_DEMYMUID_O2M
-- Auteur               :       JFF
-- Date                 :       10/10/2013
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [VDOC12921]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		    PAR		 Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC12921_V_DEMYMUID_O2M' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC12921_V_DEMYMUID_O2M
GO

CREATE procedure sysadm.PS_S_VDOC12921_V_DEMYMUID_O2M
AS

Select	c.id_sin, 
		c.id_seq, 
		c.id_ref_four, 
		c.id_four, 
		c.status_gc, 
		convert ( varchar(10), cree_le, 103 ) + ' ' + CONVERT (varchar(8), cree_le, 108) 'Dte_presta', 
		'Prestation sur laquelle SPB n''a jamais passé de PEC_A_RECYCLER ni de retour REFUSE_A_REEXP'
From   sysadm.commande c
Where  c.id_four = 'O2M' 
And    c.id_ref_four = 'A_DIAGNOSTIQUER'
And	   c.status_gc in ( 151, 152 )
And	   c.cree_le between DATEADD ( Year, -4, GETDATE()) and DATEADD ( day, -1, GETDATE())
And    Not Exists ( 
		Select * from sysadm.commande c1
		Where c1.id_sin = c.id_sin
		And   c1.id_four = c.id_four
		And   c1.id_ref_four in ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP')
)
Order by c.cree_le
Go

--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_VDOC12921_V_DEMYMUID_O2M_2
-- Auteur               :       JFF
-- Date                 :       10/10/2013
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [VDOC12921]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		    PAR		 Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC12921_V_DEMYMUID_O2M_2' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC12921_V_DEMYMUID_O2M_2
GO

CREATE procedure sysadm.PS_S_VDOC12921_V_DEMYMUID_O2M_2
AS

Select	c.id_sin, 
		c.id_seq, 
		c.id_ref_four, 
		c.id_four,
		convert ( varchar(10), cree_le, 103 ) + ' ' + CONVERT (varchar(8), cree_le, 108) 'Dte_presta', 
		'Prestation sur laquelle SPB passé un retour REFUSE_A_REEXP'
From   sysadm.commande c
Where  c.id_four = 'O2M' 
And    c.id_ref_four = 'REFUSE_A_REEXP'
And	   c.cree_le between DATEADD ( Year, -4, GETDATE()) and DATEADD ( day, -1, GETDATE())
Order by c.cree_le

Go


--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_VDOC12921_V_DEMYMUID_O2M_MAIL_1
-- Auteur               :       JFF
-- Date                 :       10/10/2013
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [VDOC12405]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC12921_V_DEMYMUID_O2M_MAIL_1' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC12921_V_DEMYMUID_O2M_MAIL_1
GO

CREATE procedure sysadm.PS_S_VDOC12921_V_DEMYMUID_O2M_MAIL_1
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_vDoc12921_V_DEMYMUID_O2M\'
Set @sFileName	= 'VDOC12921_V_DEMYMUID_O2M'
Set @sFileExt	= 'xls'


SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_VDOC12921_V_DEMYMUID_O2M ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_VDOC12921_V_DEMYMUID_O2M ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Go

grant execute on sysadm.PS_S_VDOC12921_V_DEMYMUID_O2M_MAIL_1 to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_VDOC12921_V_DEMYMUID_O2M_MAIL_2
-- Auteur               :       JFF
-- Date                 :       10/10/2013
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [VDOC12405]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC12921_V_DEMYMUID_O2M_MAIL_2' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC12921_V_DEMYMUID_O2M_MAIL_2
GO

CREATE procedure sysadm.PS_S_VDOC12921_V_DEMYMUID_O2M_MAIL_2
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_vDoc12921_V_DEMYMUID_O2M\'

Set @sFileName	= 'VDOC12921_V_DEMYMUID_O2M_2'
Set @sFileExt	= 'xls'


SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_VDOC12921_V_DEMYMUID_O2M_2 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_VDOC12921_V_DEMYMUID_O2M_2 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output


Go

grant execute on sysadm.PS_S_VDOC12921_V_DEMYMUID_O2M_MAIL_2 to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procédure            :       PS_S_ADVISE_APPEL_FACT
-- Auteur               :       FABRY JF
-- Date                 :       28/10/2003
-- Libellé              :        
-- Commentaires         :       [PC947&977]
-- Références           :       
--
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
-- Retourne             :       Rien
--
-- JFF      18/03/2014   [DT076_ADVISE]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_ADVISE_APPEL_FACT' AND type = 'P' )
        DROP procedure sysadm.PS_S_ADVISE_APPEL_FACT
GO

CREATE procedure sysadm.PS_S_ADVISE_APPEL_FACT
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

Select  c.id_sin,
		c.id_seq,
		c.id_four,
		sysadm.FN_CODE_CAR ( c.id_four, '-FR' ) lib_four,
		c.mt_ttc_cmde,
		( Select nom From personne p Where p.id_ordre = s.id_ordre ) Nom_assure,
		( Select prenom From personne p Where p.id_ordre = s.id_ordre ) Prenom_assure,			
		c.dte_env_cli Dte_Remplacement,
		c.id_serie_nouv Nouv_Imei_Serie,
		c.id_cmd_frn Num_Facture_Assure,
		sysadm.FN_CLE_VAL ( 'MT_SAISI_EXTRANET', rtrim ( c.info_frn_spb_cplt ), ';') Montant_Facture_Assure,
		s.id_prod,
		sysadm.FN_LIB_PROD ( s.id_prod ) Lib_prod,
		sysadm.FN_LIB_CIE (  s.id_sin ) Assureur,
		sysadm.FN_LIB_POLICE ( s.id_sin ) Police
	
From	sysadm.sinistre s,
		sysadm.det_pro dp,
		sysadm.commande c
Where   dp.id_code_dp = 252
And     s.id_prod = dp.id_prod
And     c.id_sin = s.id_sin
And     c.id_four = 'ADV'
And     c.id_typ_art = 'CAF'
And		c.dte_env_cli BETWEEN @dtDteDeb AND @dtDteFin
	
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_ADVISE_CTRLE_FACTURATION
-- Auteur               :       FABRY JF
-- Date                 :       28/10/2003
-- Libellé              :        
-- Commentaires         :       [PC947&977]
-- Références           :       
--
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_ADVISE_CTRLE_FACTURATION' AND type = 'P' )
        DROP procedure sysadm.PS_S_ADVISE_CTRLE_FACTURATION
GO

CREATE procedure sysadm.PS_S_ADVISE_CTRLE_FACTURATION
	@asCas	VarChar ( 30 )
AS

If @asCas = 'COUNT'
 Begin
	Return ( 
		Select count ( * ) 
	from   sysadm.reglement r,
		   sysadm.inter i,
		   sysadm.detail d,
		   sysadm.commande c
	Where  r.cod_mode_reg = 'XA'
	And    r.cod_inter = 'F'
	And    i.id_sin = r.id_sin
	And    i.id_i = r.id_i
	And    i.id_four = 'ADV'
	And    d.id_sin = r.id_sin
	And    d.id_reg = r.id_reg
	And    c.id_sin = d.id_sin
	And    c.id_gti = d.id_gti
	And    c.id_detail = d.id_detail
	And    dte_reg = convert ( varchar(10), DateAdd ( day, -1, GETDATE() ) , 103 )
	)
	
 End 


If @asCas = 'DATA'
 Begin
	Select r.id_sin,
		   r.id_reg,
		   c.id_seq,
		   CONVERT ( VarChar ( 10), r.dte_reg, 103) 'dte_reg_ctrle',
		   'Reglement virtuel de contrôle ( mode XA)' 'Mode_Reglt',
		   i.id_four,
		   sysadm.FN_CODE_CAR ( i.id_four, '-FR' ) 'lib_four',
		   d.mt_prej 'Mt_Donné_Par_Advise',
		   r.mt_tot_reg 'Mt_Reel_Calculé_par_SPB',
		   d.num_facture 'Num_Fact_Advise',
		   CONVERT ( VarChar ( 10), d.dte_livr, 103) 'Dte_Fact_Advise'
	from   sysadm.reglement r,
		   sysadm.inter i,
		   sysadm.detail d,
		   sysadm.commande c
	Where  r.cod_mode_reg = 'XA'
	And    r.cod_inter = 'F'
	And    i.id_sin = r.id_sin
	And    i.id_i = r.id_i
	And    i.id_four = 'ADV'
	And    d.id_sin = r.id_sin
	And    d.id_reg = r.id_reg
	And    c.id_sin = d.id_sin
	And    c.id_gti = d.id_gti
	And    c.id_detail = d.id_detail
	And    dte_reg = convert ( varchar(10), DateAdd ( day, -1, GETDATE() ) , 103 )
 End

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_ADVISE_CTRLE_FACTURATION_FICHIER
-- Auteur               :       FABRY JF
-- Date                 :       28/10/2003
-- Libellé              :        
-- Commentaires         :       [PC947&977]
-- Références           :       
--
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_ADVISE_CTRLE_FACTURATION_FICHIER' AND type = 'P' )
        DROP procedure sysadm.PS_S_ADVISE_CTRLE_FACTURATION_FICHIER
GO

CREATE procedure sysadm.PS_S_ADVISE_CTRLE_FACTURATION_FICHIER
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	,
	@iCount Integer

-- chemin d'enregistrement du Result Set
Set @sPath 	= '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Controle_Facture_Advise\'

Set @sFileName	= 'CONTROLE_FACTURE_ADVISE_' + Replace ( convert ( varchar(10), GETDATE(), 112 ) + CONVERT (varchar(8), GETDATE(), 108), ':', '' )
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

Exec @iCount = sysadm.PS_S_ADVISE_CTRLE_FACTURATION 'COUNT'

If @iCount <= 0 Return
	
IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_ADVISE_CTRLE_FACTURATION ''DATA'' ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_ADVISE_CTRLE_FACTURATION ''DATA'' ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sMessage = 'Un fichier a été généré sur ' + Replace ( @sFicOut, '\\spb.lan\applis\spb', 'K:' )

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'mlimare@spb.fr',
--		'jff@spb.fr',		
		@sMessage, 
		'Facturation Advise', 
		'', 
		'', 
		NULL, 
		NULL, 
		NULL, 
		NULL, 
		NULL

Go

grant execute on sysadm.PS_S_ADVISE_CTRLE_FACTURATION_FICHIER to rolebddsinistres
go
--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_VDOC8285
-- Auteur               :       FPI
-- Date                 :       14/01/2014
-- Libellé              :        
-- Commentaires         :       [VDoc13194] automatisation de la VDoc 8285
-- Références           :       
--
--	
-- Arguments            :      @sListeIdSin		Varchar(8000)            (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- V01 - VDoc 14368 - ajout des infos complementaires et du commentaire fournisseur
-- V02 - VDOC 14942 - ajout des 3 dernières colonnes
-- JFF      12/02/2016   [PI062]
-- V03		28/11/2017	[VDoc25230] ajout des 2 dernières colonnes IMEI
-- JFF  13/01/2023  [RS4402] ajout mt_pec
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_VDOC8285_V04' AND type = 'P' )
        DROP procedure sysadm.PS_S01_VDOC8285_V04
GO


CREATE procedure sysadm.PS_S01_VDOC8285_V04
	@sListeIdSin	Varchar(8000)
As

Declare @dcIdSin Decimal ( 10 ) -- [PI062]
Declare @iIdSeq Int

Declare @t TABLE (ordre_fic integer identity,
				  id_sin    Decimal (10), -- [PI062]
				  id_seq	int
				   )

Declare @t2 TABLE ( 
			id_sin    Decimal (10), -- [PI062]
		    id_seq    int,
		    etat_cmde varchar ( 35 ),
		    mt_reg_dte_nom varchar ( 300 ),
		    action_O2M varchar ( 35 ),
		    mt_ttc_cmde decimal (11,2 ),
		    info_spb_frn_cplt varchar ( 800 ),
		    info_frn_spb_cplt varchar ( 800 ),
		    comment_frn varchar ( 255 ),
		    mt_tot_reg_du_RM decimal (11,2 ),
		    assureur varchar ( 35 ),
		    process int,
		    lib_process varchar ( 35 ),
			num_imei_port varchar(60),
			id_serie_nouv  varchar(60),
			mt_pec decimal (11,2) -- [RS4402]
		  )

Declare @iPos int, @iPos2 int
Declare @sIdSin varchar(10)

-- Décomposition en table
While LEN(@sListeIdSin) > 0
Begin
	set @iPos=charindex(',',@sListeIdSin)
	If @iPos=0 
	Begin
		Set @iPos2=charindex('-',@sListeIdSin)
		If @iPos2 > 0
		Begin
			Set @dcIdSin = CONVERT ( Decimal ( 10 ) , Left(@sListeIdSin, @iPos2 - 1) ) -- [PI062]
			Set @iIdSeq = Convert(int, SUBSTRING(@sListeIdSin,@iPos2+1, LEN(@sListeIdSin)))
		End
		set @sListeIdSin=''
	End 
	Else
	Begin
		Set @iPos2=charindex('-',@sListeIdSin)
		If @iPos2 > 0
		Begin
			Set @dcIdSin = CONVERT ( Decimal ( 10 ) , Left(@sListeIdSin,@iPos2 - 1) ) -- [PI062]
			Set @iIdSeq = Convert(int,SUBSTRING(@sListeIdSin,@iPos2+1, @iPos - @iPos2 - 1))
		End 
		Set @sListeIdSin=SUBSTRING(@sListeIdSin,@iPos+1,LEN(@sListeIdSin))
	End
	
	insert into @t (id_sin, id_seq) values (@dcIdSin,@iIdSeq)
End

Insert into @t2 
Select	T.id_sin, 
		T.id_seq,
		sysadm.FN_CODE_CAR(c.cod_etat,'-EC') etat_cmde,
		( 	
			Select ( 
				Select CAST( CONVERT ( varchar ( 20 ) , r.mt_tot_reg ) + '=' + CONVERT ( varchar ( 10 ), r.cree_le, 103 ) + '=' + RTRIM ( isnull ( i.nom, '' ) ) + '#' AS VARCHAR(150))
				from sysadm.reglement r, 
					 sysadm.inter i
				where r.id_sin = T.id_sin
				and	  r.cod_mot_reg = 'RN'
				and   i.id_sin = r.id_sin
				and   i.id_i = r.id_i
				For XML PATH ('') 
			) 
		) as mt_reg_dte_nom,
		sysadm.FN_CODE_NUM(c.status_gc,'-GC') as action_O2M,
		c.mt_ttc_cmde,
		c.info_spb_frn_cplt,
		c.info_frn_spb_cplt,		
		c.comment_frn,		
		( Select Sum ( r2.mt_tot_reg )
		  From sysadm.reglement r,
			   sysadm.reglement r2,
			   sysadm.detail d
		  Where d.id_sin = c.id_sin
		  And   d.id_gti = c.id_gti 
		  And   d.id_detail = c.id_detail
	      And   r.id_sin = d.id_sin
	      And   r.id_reg = d.id_reg
	      And   r2.id_sin = r.id_sin
	      And   r2.id_reg_base = r.id_reg
	      And   r2.cod_mot_reg = 'RM'
	    ) as mt_tot_reg_du_RM,
	    sysadm.FN_LIB_CIE(T.id_sin)	as assureur,
		c.info_spb_frn as process,	    
		sysadm.FN_CODE_NUM(c.info_spb_frn,'-IF') as lib_process,
		s.num_imei_port,
		c.id_serie_nouv,
		d.val_mt  -- [RS4402] mt_pec lié au détail
From @t as T
	left outer join sysadm.commande c on c.id_sin = T.id_sin  And   c.id_seq = T.id_seq
	left outer join sysadm.sinistre s on s.id_sin=T.id_sin
	left outer join sysadm.div_det d on d.id_sin = c.id_sin and d.id_gti = c.id_gti and d.id_detail = c.id_detail and d.nom_zone = 'mt_pec'  -- [RS4402]
Order by T.ordre_fic

Select * from @t2

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_VDOC12967
-- Auteur               :       FPI
-- Date                 :       14/01/2014
-- Libellé              :        
-- Commentaires         :       [VDoc13194] automatisation de la VDoc 12967
-- Références           :       
--
--	
-- Arguments            :      @sListeIdSin		Varchar(8000)            (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_VDOC12967' AND type = 'P' )
        DROP procedure sysadm.PS_S01_VDOC12967
GO


CREATE procedure sysadm.PS_S01_VDOC12967
	@sListeIdSin	Varchar(8000)
As

Declare @dcIdSin Decimal ( 10 ) -- [PI062]
Declare @iIdSeq Int

Declare @t TABLE (ordre_fic integer identity,
				  id_sin    Decimal (10),  -- [PI062]
				  id_seq	int
				   )
Declare @iPos int, @iPos2 int
Declare @sIdSin varchar(10)

-- Décomposition en table
While LEN(@sListeIdSin) > 0
Begin
	set @iPos=charindex(',',@sListeIdSin)
	If @iPos=0 
	Begin
		Set @iPos2=charindex('-',@sListeIdSin)
		If @iPos2 > 0
		Begin
			Set @dcIdSin = CONVERT ( Decimal ( 10 ) , Left(@sListeIdSin, @iPos2 - 1) ) -- [PI062]
			Set @iIdSeq = Convert(int, SUBSTRING(@sListeIdSin,@iPos2+1, LEN(@sListeIdSin)))
		End
		set @sListeIdSin=''
	End 
	Else
	Begin
		Set @iPos2=charindex('-',@sListeIdSin)
		If @iPos2 > 0
		Begin
			Set @dcIdSin = CONVERT ( Decimal ( 10 ) , Left(@sListeIdSin,@iPos2 - 1) ) -- [PI062]
			Set @iIdSeq = Convert(int,SUBSTRING(@sListeIdSin,@iPos2+1, @iPos - @iPos2 - 1))
		End 
		Set @sListeIdSin=SUBSTRING(@sListeIdSin,@iPos+1,LEN(@sListeIdSin))
	End
	
	insert into @t (id_sin, id_seq) values (@dcIdSin,@iIdSeq)
End

select t.id_sin, t.id_seq, CONVERT(varchar(10),r.dte_reg,103) as dte_reg, r.mt_tot_reg
from @t t
	left outer join inter i on i.id_sin=t.id_sin and i.id_four='CDS'
	left outer join reglement r on r.id_sin=t.id_sin and r.id_i=i.id_i
order by ordre_fic

Go
grant execute on sysadm.PS_S01_VDOC12967 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_VDOC12705
-- Auteur               :       FPI
-- Date                 :       21/01/2014
-- Libellé              :        
-- Commentaires         :       [VDoc13415] automatisation de la VDoc 12705
-- Références           :       
--
--	
-- Arguments            :      @sListeNumCarte		Varchar(8000)            (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- 30/04/2014 - FPI - V01 - Ajout de la colonne assureur
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_VDOC12705_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S01_VDOC12705_V01
GO

CREATE procedure sysadm.PS_S01_VDOC12705_V01
	@sListeNumCarte	Varchar(8000)
As

Declare @t TABLE (ordre_fic integer identity,
				  num_carte    varchar(30),
				  id_cli int,
				  nom varchar(35),
				  prenom varchar(35),
				  id_prod decimal(7,0),
				  lib_produit varchar(65),
				  id_sin decimal(10,0), -- [PI062]
				  id_seq int, 
				  nom_assureur varchar(35)
				  )
Declare @iPos int, @iPos2 int
Declare @sNumCarte varchar(30)

-- Décomposition en table
While LEN(@sListeNumCarte) > 0
Begin
	set @iPos=charindex(',',@sListeNumCarte)
	If @iPos=0 
	Begin
		Set @sNumCarte = @sListeNumCarte
		set @sListeNumCarte=''
	End 
	Else
	Begin
		Set @sNumCarte = Left(@sListeNumCarte,@iPos - 1)
		Set @sListeNumCarte=SUBSTRING(@sListeNumCarte,@iPos+1,LEN(@sListeNumCarte))
	End
	
	insert into @t (num_carte) values (@sNumCarte)
End

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
Begin
	Update @t
	set id_cli=s.id_cli, 
		nom=p.nom, 
		prenom=p.prenom, 
		id_prod=s2.id_prod, 
		lib_produit=sysadm.FN_LIB_PROD( s2.id_prod), 
		 id_sin=s.id_sin,
		 id_seq= c.id_seq,
		 nom_assureur=sysadm.FN_LIB_CIE(s2.id_sin)
	from @t l
		inner join commande c on c.id_cmd_frn=l.num_carte  and c.id_four='CFM'  and c.id_typ_art='CAF'
		left outer join sinistre s2 on s2.id_sin=c.id_sin
		left outer join personne p on p.id_ordre=s2.id_ordre
		left outer join SHERPA_PRO.sysadm.sinistre s on s.id_sin=s2.id_sin
	
	Update @t
	set id_cli=ic.id_cli, 
		nom=c.nom, 
		prenom=c.prenom, 
		id_prod=a.id_prod_adh, 
		lib_produit=SHERPA_PRO.sysadm.FN_LIB_PROD( a.id_prod_adh )
	from @t l
		inner join SHERPA_PRO.sysadm.info_client ic on l.num_carte = ic.lib_info and ic.id_info = 49
		left outer join SHERPA_PRO.sysadm.client c on ic.id_cli = c.id_cli
		Left outer join SHERPA_PRO.sysadm.adhesion a on ic.id_cli = a.id_cli and a.id_sdos = 1
	where l.id_sin is null
	
	Update @t
	set nom=p.nom, 
		prenom=p.prenom, 
		id_prod=s2.id_prod, 
		lib_produit=sysadm.FN_LIB_PROD( s2.id_prod), 
		 id_sin=c.id_sin,
		 nom_assureur=sysadm.FN_LIB_CIE(s2.id_sin)
	from @t l
		inner join SHERPA_PRO.sysadm.contact c  on c.id_cli=l.id_cli
		inner join sysadm.sinistre s2 on s2.id_sin=c.id_sin
		inner join sysadm.personne p on p.id_ordre=s2.id_ordre
	where l.id_sin is null
		and c.txt_mess like '%' + l.num_carte + '%'
		
End
Else
Begin
	Update @t
	set id_cli=s.id_cli, 
		nom=p.nom, 
		prenom=p.prenom, 
		id_prod=s2.id_prod, 
		lib_produit=sysadm.FN_LIB_PROD( s2.id_prod), 
		 id_sin=s.id_sin,
		 id_seq= c.id_seq,
		 nom_assureur=sysadm.FN_LIB_CIE(s2.id_sin)
	from @t l
		inner join sysadm.commande c on c.id_cmd_frn=l.num_carte  and c.id_four='CFM'  and c.id_typ_art='CAF'
		left outer join sysadm.sinistre s2 on s2.id_sin=c.id_sin
		left outer join sysadm.personne p on p.id_ordre=s2.id_ordre
		left outer join SHERPA_SIM.sysadm.sinistre s on s.id_sin=s2.id_sin
	
	Update @t
	set id_cli=ic.id_cli, 
		nom=c.nom, 
		prenom=c.prenom, 
		id_prod=a.id_prod_adh, 
		lib_produit=SHERPA_SIM.sysadm.FN_LIB_PROD( a.id_prod_adh )
	from @t l
		inner join SHERPA_SIM.sysadm.info_client ic on l.num_carte = ic.lib_info and ic.id_info = 49
		left outer join SHERPA_SIM.sysadm.client c on ic.id_cli = c.id_cli
		Left outer join SHERPA_SIM.sysadm.adhesion a on ic.id_cli = a.id_cli and a.id_sdos = 1
	where l.id_sin is null
	
	Update @t
	set nom=p.nom, 
		prenom=p.prenom, 
		id_prod=s2.id_prod, 
		lib_produit=sysadm.FN_LIB_PROD( s2.id_prod), 
		 id_sin=c.id_sin,
		 nom_assureur=sysadm.FN_LIB_CIE(s2.id_sin)
	from @t l
		inner join SHERPA_SIM.sysadm.contact c  on c.id_cli=l.id_cli
		inner join sysadm.sinistre s2 on s2.id_sin=c.id_sin
		inner join sysadm.personne p on p.id_ordre=s2.id_ordre
	where l.id_sin is null
		and c.txt_mess like '%' + l.num_carte + '%'
End

select  num_carte, id_cli, nom, prenom,
	id_prod, lib_produit, id_sin, id_seq, nom_assureur
from @t
order by ordre_fic

Go
grant execute on sysadm.PS_S01_VDOC12705_V01 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_EXTR_VIPP_VDOC13070
-- Auteur               :       FABRY JF
-- Date                 :       28/10/2003
-- Libellé              :        
-- Commentaires         :       [VDOC13070]
-- Références           :       
--
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_EXTR_VIPP_VDOC13070' AND type = 'P' )
        DROP procedure sysadm.PS_S_EXTR_VIPP_VDOC13070
GO

CREATE procedure sysadm.PS_S_EXTR_VIPP_VDOC13070
AS

Select	c.id_lot_cmd 'num_lot_cmd',
		c.id_four 'Fournisseur',
		s.id_contrat_abonne 'num_adh_cds',
		convert ( varchar ( 10 ), c.id_sin ) + '-' + convert ( varchar ( 10 ), c.id_seq ) 'num_cmd_spb',
		convert ( varchar(10), s.dte_surv, 103 ) 'dte_surv',
		( Select Top 1 rtrim ( convert ( varchar(10), ds.val_dte , 103 ))
		  From sysadm.div_sin ds
		  Where ds.id_sin = s.id_sin
		  And   ds.nom_zone = 'dte_deb_gti'
		) as 'dte_deb_gti',
		convert ( varchar(10), s.dte_fin_gti, 103 ) 'dte_fin_gti',
		sysadm.FN_CODE_NUM ( c.adr_cod_civ, '-CI' ) 'civ',
		c.adr_nom 'nom',
		c.adr_prenom 'prenom',
		c.adr_livr1 'adr_livr1',
		c.adr_livr2 'adr_livr2',
		c.adr_livr_cpl 'adr_livr_cpl',
		c.adr_cp 'adr_cp',
		c.adr_ville 'adr_ville',
		( Select Top 1 rtrim ( ds.val_car )
		  From sysadm.div_sin ds
		  Where ds.id_sin = s.id_sin
		  And   ds.nom_zone = 'type_app'
		) as 'typ_art',
		( Select Top 1 sysadm.FN_CODE_CAR ( rtrim ( ds.val_car ), '-AR' )
		  From sysadm.div_sin ds
		  Where ds.id_sin = s.id_sin
		  And   ds.nom_zone = 'type_app'
		) as 'lib_typ_art',
		s.marq_port,
		s.modl_port,
		s.num_imei_port,
	   ( Select Top 1 rtrim ( convert ( varchar(10), ds.val_dte, 103 ) )
	     From sysadm.div_sin ds
	     Where ds.id_sin = s.id_sin
	     And   ds.nom_zone = 'dte_livraison'
	   ) as 'dte_livraison',
	   d.mt_val_achat,
	   d.mt_val_publique,
	   convert ( varchar(10), s.dte_ach_port, 103 ) 'dte_achat',
	   c.adr_tel1,
	   c.adr_tel2,
	   c.adr_tel3,
	   ( Select rtrim ( i.adr_mail )
	     From	sysadm.inter i
	     Where  i.id_sin = s.id_sin
	     And    i.cod_inter = 'A' ) 'adr_mail',
	   c.probleme 'info_cplt',
	   Case 
		   When Exists ( Select *
				 From	sysadm.commande c1
				 Where  c1.id_sin = s.id_sin
				 And    sysadm.FN_CLE_VAL ( 'APP_INCOMPLET', rtrim( c1.info_frn_spb_cplt), ';' ) = 'OUI'
			     ) Then 'NON'
		   Else 'OUI'
	   End 'App_Complet',

	   Case 
			When Exists 
			   ( Select *
				 from	sysadm.div_det dd
				 Where  dd.id_sin = d.id_sin
				 And	dd.id_gti = d.id_gti
				 And	dd.id_detail = d.id_detail
				 And	dd.nom_zone = 'mt_pec'
				 And    dd.val_mt > 0 ) Then
				( Select Convert ( Money, Round ( dd.val_mt / ( 1 + ( Convert ( decimal ( 11,2) , 
					Case 
						When c.cree_le < '02/01/2014' Then 19.6
						Else 20 
					End 
				) / Convert ( decimal ( 11,2) , 100 ) ) ), 2 )) -- TVA (anc 19.6 pour browse)
				 from	sysadm.div_det dd
				 Where  dd.id_sin = d.id_sin
				 And	dd.id_gti = d.id_gti
				 And	dd.id_detail = d.id_detail
				 And	dd.nom_zone = 'mt_pec'
				 And    dd.val_mt > 0 )
			Else 
				Convert ( Money, Round ( d.mt_val_achat / ( 1 + ( Convert ( decimal ( 11,2) , 
					Case 
						When c.cree_le < '02/01/2014' Then 19.6
						Else 20 
					End 
				) / Convert ( decimal ( 11,2) , 100 ) )) , 2 )) -- TVA (anc 19.6 pour browse)

		End 'prix_dect_ht',
		
	    Case 
			When c.cree_le < '02/01/2014' Then '19.6%'
			Else '20%'
		End 'TVA',  
		
		Case 
			When Exists 
			   ( Select *
				 from	sysadm.div_det dd
				 Where  dd.id_sin = d.id_sin
				 And	dd.id_gti = d.id_gti
				 And	dd.id_detail = d.id_detail
				 And	dd.nom_zone = 'mt_pec'
				 And    dd.val_mt > 0 ) Then
				( Select dd.val_mt 
				 from	sysadm.div_det dd
				 Where  dd.id_sin = d.id_sin
				 And	dd.id_gti = d.id_gti
				 And	dd.id_detail = d.id_detail
				 And	dd.nom_zone = 'mt_pec'
				 And    dd.val_mt > 0 )
			Else
				d.mt_val_achat 

		End 'prix_dect_ttc',
		convert ( varchar(10), c.cmd_gen_le, 103 ) + ' ' + CONVERT (varchar(8), c.cmd_gen_le, 108) 'cmd_gen_le'


From sysadm.commande c,
	 sysadm.sinistre s,
	 sysadm.detail d
Where c.id_four = 'VPP'
And   s.id_sin = c.id_sin
And   d.id_sin = c.id_sin
And   d.id_gti = c.id_gti
And   d.id_detail = c.id_detail
And   c.id_lot_cmd > 0 
And   c.cmd_gen_le Between Convert ( varchar(10), DATEADD ( Month, -1, GETDATE() ), 103 )+ ' 00:00:00.000' and  Convert ( varchar(10), DATEADD ( Day, -1, GETDATE()), 103 ) + ' 23:59:00.000'
Order by c.id_lot_cmd,
		convert ( varchar ( 10 ), c.id_sin ) + '-' + convert ( varchar ( 10 ), c.id_seq ) 

Go

grant execute on sysadm.PS_S_EXTR_VIPP_VDOC13070 to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_EXTR_VIPP_VDOC13070_FICHIER
-- Auteur               :       FABRY JF
-- Date                 :       28/10/2003
-- Libellé              :        
-- Commentaires         :       [VDOC13070]
-- Références           :       
--
--	
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                              @dtDteFin       DateTime                (Val)
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_EXTR_VIPP_VDOC13070_FICHIER' AND type = 'P' )
        DROP procedure sysadm.PS_S_EXTR_VIPP_VDOC13070_FICHIER
GO

CREATE procedure sysadm.PS_S_EXTR_VIPP_VDOC13070_FICHIER
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	,
	@iCount Integer

-- chemin d'enregistrement du Result Set
Set @sPath 	= '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_vDoc12070_M_Lepere_Vipp\'
Set @sFileName	= 'PRESTA_VIPP_Générées_du_' + Replace ( Convert ( varchar(10), DATEADD ( Month, -1, GETDATE() ), 103 ), '/', '_') + '_Au_' +
				Replace ( Convert ( varchar(10), DATEADD ( Day, -1, GETDATE()), 103 ) , '/', '_') + '__' +
				Replace ( convert ( varchar(10), GETDATE(), 112 ) + CONVERT (varchar(8), GETDATE(), 108), ':', '' )

/*
Set @sFileName	= 'TOTO'				
*/
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

If @iCount <= 0 Return
	
IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_EXTR_VIPP_VDOC13070 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_EXTR_VIPP_VDOC13070 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Select @iRetOsql

Go

grant execute on sysadm.PS_S_EXTR_VIPP_VDOC13070_FICHIER to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S020_LSTREG_ASCENDEO
-- Auteur               :       FPI
-- Date                 :       06/02/2014
-- Libellé              :       [PC932]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- JFF      06/10/2014   [PM266]
-- JFF      12/05/2020   [PI085]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S020_LSTREG_ASCENDEO' AND type = 'P' )
        DROP procedure sysadm.PS_S020_LSTREG_ASCENDEO
GO

CREATE procedure sysadm.PS_S020_LSTREG_ASCENDEO
	@dtDteDeb       DateTime        ,
    @dtDteFin       DateTime	

AS
Declare @sPeriode varchar(10)

Set @sPeriode=Convert(varchar(4), year(@dtDteFin)) + Right('0' + Convert(varchar(2), month(@dtDteFin)),2)

select 
	@sPeriode as 'Période',
	ds.val_car as 'Point de vente ou Centrale',
	s.id_sin,
	pr.lib_long as libelle_produit,
	sysadm.FN_GET_LIB_POLICE_V01(s.id_sin,s.id_prod, s.id_rev, rg.id_gti,NULL) as 'Police',
	RTRIM(p.nom) + case when p.prenom is not null then ' ' + RTRIM(p.prenom) Else '' End as 'Nom de l''adhérent',
--	CONVERT(varchar(3), pr.cod_prod_dms) + '-' + CONVERT(varchar(5), s.id_ets) + '-' + RTRIM(s.id_adh) + '-' + CONVERT(varchar(1), s.id_sdos) as 'N° bulletin d''adhésion', -- [PI085]
	CONVERT(varchar(5), pr.cod_prod_dms) + '-' + CONVERT(varchar(5), s.id_ets) + '-' + RTRIM(s.id_adh) + '-' + CONVERT(varchar(1), s.id_sdos) as 'N° bulletin d''adhésion', -- [PI085]
	CONVERT(varchar(10),s.dte_adh,103) as 'Date d''effet de la garantie',
	CONVERT(varchar(10),s.dte_fin_gti,103) as 'Date de fin de garantie',
	RTRIM(s.marq_port) + ' ' + RTRIM(s.modl_port) as 'Modèle du Smartphone garanti',
	s.num_imei_port as 'N° IMEI',
	CONVERT(varchar(10),s.dte_decl,103) as 'Date de déclaration du sinistre',
	CONVERT(varchar(10),s.dte_surv,103) as 'Date de survenance du sinistre',
	sysadm.FN_CODE_NUM(s.id_natsin,'+NS') as 'Motif du sinistre',
	Case When exists (select * from sysadm.commande c 
			where c.id_sin=s.id_sin and c.cod_etat <> 'ANN' and c.id_typ_art='PRS') Then 'Réparation'
		When exists (select * from sysadm.commande c 
			where c.id_sin=s.id_sin and c.cod_etat <> 'ANN' and c.id_typ_art='TEL') Then 'Remplacement'
		Else 'Remboursement' End as 'Prise en charge',
	rg.mt_reg as 'Montant de l''indemnité',
	CONVERT(varchar(10),r.dte_reg,103) as 'Date de règlement'
from sysadm.sinistre s
inner join sysadm.produit pr on s.id_prod=pr.id_prod
inner join sysadm.reg_gti rg on rg.id_sin=s.id_sin
inner join sysadm.personne p on s.id_ordre=p.id_ordre
left outer join sysadm.div_sin ds on ds.id_sin=s.id_sin and ds.nom_zone='cod_boutique_adh' -- [PC932].Mantis9145
inner join sysadm.reglement r on r.id_sin=rg.id_sin and r.id_reg=rg.id_reg
inner join sysadm.garantie g on g.id_prod=s.id_prod and g.id_rev=s.id_rev 
inner join sysadm.police po on po.id_police=g.id_police
left outer join sysadm.detail d on d.id_sin=s.id_sin and d.id_reg=r.id_reg
left outer join sysadm.frais f on f.id_sin=s.id_sin and f.id_reg=r.id_reg
where pr.cod_prod_dms=813
and r.cree_le between    @dtDteDeb And @dtDteFin 
and g.id_gti=case when rg.id_gti=-1 Then
				( Select max ( gar_sin.id_gti ) 
					   From   sysadm.gar_sin
					   Where  gar_sin.id_sin = s.id_sin )
					  Else rg.id_gti End
					  
-- [PM266]
AND ( sysadm.FN_CLE_NUMERIQUE ( 'PM266') <= 0
    Or
	Not Exists ( 
		Select 1
		From   sysadm.exclu_ass ex
		Where  ex.id_cie = po.id_cie
		)
  ) 					  
Go

grant execute on sysadm.PS_S020_LSTREG_ASCENDEO to rolebddsinistres
Go		

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_VDOC14306_CMD_VOL_IPHONE
-- Auteur               :       FPI
-- Date                 :       29/04/2014
-- Libellé              :       [VDOC14306]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC14306_CMD_VOL_IPHONE' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC14306_CMD_VOL_IPHONE
GO

CREATE procedure sysadm.PS_S_VDOC14306_CMD_VOL_IPHONE
		

AS

SET NOCOUNT ON 


Declare @dtDteDeb       DateTime        ,
    @dtDteFin       DateTime
	
Set @dtDteFin=convert(datetime, convert(varchar(10), getdate(),103),103)
Set @dtDteDeb=DateAdd(day, -1, @dtDteFin)

select id_prod, modl_port, s.id_sin,
	s.num_imei_port, p.nom, p.prenom,
	s.num_port,
	p.adr_1, p.adr_2, p.adr_cp, p.adr_ville
from sysadm.sinistre s
	inner join sysadm.personne p on s.id_ordre=p.id_ordre
	inner join sysadm.gar_sin g on g.id_sin=s.id_sin
	inner join sysadm.commande c on c.id_sin=s.id_sin  and c.id_gti=g.id_gti
where s.marq_port='APPLE' and s.modl_port like '%IPHONE%'
	and g.id_gti=10
	and s.id_prod between 10900 and 10999
	and id_prod not between 10958 and 10964
	 and c.cod_etat <> 'ANN'
	 and c.valide_le between @dtDteDeb and @dtDteFin
Go

grant execute on sysadm.PS_S_VDOC14306_CMD_VOL_IPHONE to rolebddsinistres
Go		

--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_VDOC14306_CMD_VOL_IPHONE_MAIL
-- Auteur               :       FPI
-- Date                 :       29/04/2014
-- Libellé              :       [VDOC14306]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC14306_CMD_VOL_IPHONE_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC14306_CMD_VOL_IPHONE_MAIL
GO

CREATE procedure sysadm.PS_S_VDOC14306_CMD_VOL_IPHONE_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Extraction_vDoc14306_cmdVolIphone\'
Set @sFileName	= 'VDOC14306_CmdVolIphone'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_VDOC14306_CMD_VOL_IPHONE' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_VDOC14306_CMD_VOL_IPHONE' +
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = 'Mobiles volés SFR'
set @sMessage  = 'Merci de trouver ci-joint l’extraction des mobiles volés SFR.'

if @iRetOsql <> 0
BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DES.'
END

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		--'fpinon@spb.eu',
		'saviphone@o2m.fr,a.attouche@o2m.fr,lsmall@spb.eu',
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL


Go

grant execute on sysadm.PS_S_VDOC14306_CMD_VOL_IPHONE_MAIL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_VDOC14641_FACTU
-- Auteur               :       FPI
-- Date                 :       11/06/2014
-- Libellé              :       [VDOC14641]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC14641_FACTU' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC14641_FACTU
GO

CREATE procedure sysadm.PS_S_VDOC14641_FACTU
	@dtDteDeb       DateTime        ,
    @dtDteFin       DateTime	

AS
select 'Règlement fourn.' as type_reglement,
	s.id_prod,
	sysadm.FN_LIB_PROD(s.id_prod) as lib_produit,
	sysadm.FN_LIB_POLICE(s.id_sin) as lib_police,
	sysadm.FN_LIB_CIE(s.id_sin) as lib_compagnie,
	i.nom,
	COUNT(distinct s.id_sin) as nb_dossiers,
	SUM(r.mt_tot_reg) as mt_reg
from sysadm.reglement r
	inner join sinistre s on s.id_sin=r.id_sin
	inner join inter i on i.id_sin=r.id_sin and r.id_i=i.id_i
where r.cree_le between @dtDteDeb and @dtDteFin
and r.id_i > 0
and r.mt_tot_reg > 0
and i.cod_inter='F'
group by s.id_prod,
	sysadm.FN_LIB_PROD(s.id_prod),
	sysadm.FN_LIB_POLICE(s.id_sin),
	sysadm.FN_LIB_CIE(s.id_sin),
	i.nom
union
select 'Avoir' as type_reglement,
	s.id_prod,
	sysadm.FN_LIB_PROD(s.id_prod) as lib_produit,
	sysadm.FN_LIB_POLICE(s.id_sin) as lib_police,
	sysadm.FN_LIB_CIE(s.id_sin) as lib_compagnie,
	i.nom,
	COUNT(r.id_reg) as nb_rm,
	SUM(r.mt_tot_reg) as mt_reg
from sysadm.reglement r
	inner join sinistre s on s.id_sin=r.id_sin
	inner join inter i on i.id_sin=r.id_sin and r.id_i=i.id_i
where r.cree_le between @dtDteDeb and @dtDteFin
and r.id_i > 0
and r.mt_tot_reg < 0
and i.cod_inter='F'
group by s.id_prod,
	sysadm.FN_LIB_PROD(s.id_prod),
	sysadm.FN_LIB_POLICE(s.id_sin),
	sysadm.FN_LIB_CIE(s.id_sin),
	i.nom
order by type_reglement desc
Go

grant execute on sysadm.PS_S_VDOC14641_FACTU to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_MENS_DT076_ADVISE
-- Auteur               :       JFF
-- Date                 :       11/01/2013
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [DT076_ADVISE_V3]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- JFF  08/03/2016   [VDOC20161]
-- JFF  21/11/2018   [VDOC27123]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MENS_DT076_ADVISE' AND type = 'P' )
        DROP procedure sysadm.PS_S_MENS_DT076_ADVISE
GO

CREATE procedure sysadm.PS_S_MENS_DT076_ADVISE
	@asCas VarChar ( 20 ) = null
AS

Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @iMois Integer
Declare @iAnnee Integer
Declare @iJour Integer

/*
If @asCas is null Or @asCas <> 'FORCAGE'
 Begin
	If Convert ( Integer, DATEPART ( day, getdate())) <> 1
	 Begin
		Select 'Le traitement ne peut être lancé que le 1er du mois. Passer l''argument ''FORCAGE'' pour simuler le lancement au premier du mois en cours'
		Return -1 -- jour de lancement Différent du 1er du mois
	 End
 End 
*/

Set @iMois = DATEPART ( month, GetDate() )
Set @iAnnee = DATEPART ( Year, GetDate() )
Set @iJour = 1

Set @dtDateFin = CONVERT( DateTime,
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iJour ), 2 ) + '/' +
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iMois ), 2 ) + '/' +
				 Right ( '0000' + CONVERT ( VarChar ( 4 ) , @iAnnee ), 4 ),
				 103 )

Set @dtDateFin = DATEADD ( DAY, -1, @dtDateFin ) 

Set @iMois = DATEPART ( month, @dtDateFin )
Set @iAnnee = DATEPART ( Year, @dtDateFin )

Set @dtDateDeb = CONVERT( DateTime,
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iJour ), 2 ) + '/' +
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iMois ), 2 ) + '/' +
				 Right ( '0000' + CONVERT ( VarChar ( 4 ) , @iAnnee ), 4 ) ,
				 103 )
				 
Select Convert ( VarChar ( 10), @dtDateDeb, 103 ) 'periode_deb_dte_fin_trt',
	   Convert ( VarChar ( 10), @dtDateFin, 103 ) 'periode_fin_dte_fin_trt',
	   s.id_prod,
	   CONVERT ( VarChar ( 10), c.id_sin ) + '-' + CONVERT ( VarChar ( 10), c.id_seq )'num_presta_spb',
	   sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_prod',
	   cie.lib_cie 'Assureur',
	   s.marq_port 'Marque',
	   s.modl_port 'Modele',
	   c.adr_nom,
	   c.adr_prenom,
	   c.adr_livr1,
	   c.adr_livr2,
	   c.adr_livr_cpl,
	   c.adr_cp,
	   c.adr_ville,
	   sysadm.FN_AFF_DATE ( c.cree_le, '') 'dte_cmde',
	   sysadm.FN_AFF_DATE ( c.dte_rcp_frn, '' ) 'dte_rcp_PSM',
	   sysadm.FN_AFF_DATE ( c.dte_env_cli, '') 'dte_retour_PSM',
	   d.mt_val_publique, 
	   '''' + s.num_imei_port + '''' 'IMEI',
	   c.id_ref_four 'Ordre_prioritaire',
	   sysadm.FN_CODE_NUM ( c.status_gc, '-GC' ) 'Lib_Statut_Gc',
	   c.comment_frn,
	   Case 
		  -- [VDOC27123]BVID/BVIP/BVIT
		  When CHARINDEX ( '[BVIE]', c.comment_frn ) > 0  Then 'Bris Visible Irréparable Economiquement'
		  When CHARINDEX ( '[BVID]', c.comment_frn ) > 0  Then 'Irréparable, pièce ponctuellement indisponible'
		  When CHARINDEX ( '[BVIP]', c.comment_frn ) > 0  Then 'Bris Visible pièce spécifique indisponible'
		  When CHARINDEX ( '[BVIT]', c.comment_frn ) > 0  Then 'Bris Visible Irréparable Economiquement'
		  When CHARINDEX ( '[PIE]', c.comment_frn ) > 0  Then 'Panne Irréparable Economiquement'
		  Else 'Irréparable non couvert'
	   End 'Info',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré en pointe de vente'
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré envoie coli en centralisation'
	   End 'pdv_ou_coli_centl',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
				/* [VDOC20161]
				Then ( Select Top 1 b.adr_nom
					   From sysadm.boutique b
					   Where b.id_prod = s.id_prod
					   And   Convert ( Integer, b.cod_mag ) = Convert ( Integer, sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' ) )
					 )
				*/
	   End 'Nom PSM',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )				
				-- Then sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' ) [VDOC20161]
	   End 'Numéro PSM'


From sysadm.commande c
Inner Join sysadm.gar_sin g on g.id_sin = c.id_sin And g.id_gti = c.id_gti
Inner Join sysadm.detail d on d.id_sin = c.id_sin And d.id_gti = c.id_gti and d.id_detail = c.id_detail
Inner Join sysadm.sinistre s on s.id_sin = c.id_sin
Inner Join sysadm.garantie ga on ga.id_prod = s.id_prod And 
								 ga.id_gti = c.id_gti And
								 ga.id_rev = s.id_rev
Inner Join sysadm.police po on po.id_police = ga.id_police
Inner Join sysadm.compagnie cie on cie.id_cie = po.id_cie
Inner Join sysadm.det_pro dp on dp.id_prod = s.id_prod 

Where c.id_four = 'PSM'
And   c.dte_env_cli is not null
And   c.id_ref_four in ( 'A_REPARER', 'A_REPARER_FORCE', 'A_DESOXYDER', 'A_DESOXYDER_FORCE' )
And   c.dte_env_cli between @dtDateDeb And @dtDateFin
And   c.status_gc in ( 21, 23 )
And   dp.id_code_dp = 252
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_MENS_DT076_ADVISE_MAIL
-- Auteur               :       JFF
-- Date                 :       11/01/2013
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [DT076_ADVISE_V3]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MENS_DT076_ADVISE_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S_MENS_DT076_ADVISE_MAIL
GO

CREATE procedure sysadm.PS_S_MENS_DT076_ADVISE_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(500),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @iMois Integer
Declare @iAnnee Integer
Declare @iJour Integer


-- chemin d'enregistrement du Result Set
-- Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_DT076_IRR_PSM_VERS_O2M\'
Set @sPath 	= '\\F4T\Sinistre\Export_DT076_IRR_PSM\'
Set @sFileName	= 'Export_DT076_IRR_PSM'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_MENS_DT076_ADVISE ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_MENS_DT076_ADVISE ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @iMois = DATEPART ( month, GetDate() )
Set @iAnnee = DATEPART ( Year, GetDate() )
Set @iJour = 1

Set @dtDateFin = CONVERT ( DateTime,
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iJour ), 2 ) + '/' +
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iMois ), 2 ) + '/' +
				 Right ( '0000' + CONVERT ( VarChar ( 4 ) , @iAnnee ), 4 ),
				 103 )

Set @dtDateFin = DATEADD ( DAY, -1, @dtDateFin ) 

Set @iMois = DATEPART ( month, @dtDateFin )
Set @iAnnee = DATEPART ( Year, @dtDateFin )

Set @dtDateDeb = CONVERT ( DateTime,
			  	 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iJour ), 2 ) + '/' +
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iMois ), 2 ) + '/' +
				 Right ( '0000' + CONVERT ( VarChar ( 4 ) , @iAnnee ), 4 ),
				 103 )


Set @sObjet    = 'Extraction des irréparables SPB/PSM pour Advise, du ' + Convert ( VarChar ( 10), @dtDateDeb, 103 ) + ' au ' + Convert ( VarChar ( 10), @dtDateFin, 103 )

set @sMessage  = 'Bonjour,'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Veuillez-trouver en pièce-jointe la liste des dossiers en irréparable, entre le ' + Convert ( VarChar ( 10), @dtDateDeb, 103 ) + ' et le ' + Convert ( VarChar ( 10), @dtDateFin, 103 ) + '.'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Cordialement,'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'SPB.'

EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'cbouriah@advisebrokers.com, emascle@advisebrokers.com',
--			'jff@spb.fr',
--			'svabre@spb.fr',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL

Go

grant execute on sysadm.PS_S_MENS_DT076_ADVISE_MAIL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_LISTE_CODES_ACTIONS
-- Auteur               :       FPI
-- Date                 :       06/08/2014
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC14935]
--
-- Arguments            :       
--				
-- Retourne             :       liste des codes actions Simpa2
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_LISTE_CODES_ACTIONS ' AND type = 'P' )
        DROP procedure sysadm.PS_S01_LISTE_CODES_ACTIONS 
GO

CREATE procedure sysadm.PS_S01_LISTE_CODES_ACTIONS 
AS
SET NOCOUNT ON

select distinct id_typ_art, id_ref_four as 'action'
from article
where id_typ_art in ('RST','PST','EDI','RES','REA','PCM','CAF')
union select 'PRS','A_REPARER'
union
select '-','A_COMMANDER'
union
select '-','A_ANNULER'
union
select 'CAF','CMDE_BON_CADEAU'
union
select '-','BA_A_ENVOYER_A_L_ASSURE'
union
select 'PRS','A_REPARER_SAV'
union
select 'PRS','A_CONTROLER_SAV'
union
select 'PRS','A_DESOXYDER_SAV'
union
select 'PRS','MAJ_ADRESSE'
union
select 'RST','ALIMENTER_STOCK'
union
select 'RST','RST_A_COMMANDER'
union
select 'RES','PRET_A_RESTITUER'
Go

grant execute on sysadm.PS_S01_LISTE_CODES_ACTIONS to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_LISTE_CODES_PROCESS
-- Auteur               :       FPI
-- Date                 :       06/08/2014
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC14935]
--
-- Arguments            :       
--				
-- Retourne             :       liste des codes process Simpa2
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_LISTE_CODES_PROCESS' AND type = 'P' )
        DROP procedure sysadm.PS_S01_LISTE_CODES_PROCESS 
GO

CREATE procedure sysadm.PS_S01_LISTE_CODES_PROCESS 
AS
SET NOCOUNT ON

select id_code, lib_code
from sysadm.code
where id_typ_code='-IF'
	and id_code % 100 not in (99,1) 
	and id_code > 0
Go

grant execute on sysadm.PS_S01_LISTE_CODES_PROCESS to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_LISTE_CODES_CSV
-- Auteur               :       FPI
-- Date                 :       06/08/2014
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC14935]
--
-- Arguments            :       
--				
-- Retourne             :       liste des codes Simpa2 dans différents csv
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_LISTE_CODES_CSV ' AND type = 'P' )
        DROP procedure sysadm.PS_S01_LISTE_CODES_CSV 
GO

CREATE procedure sysadm.PS_S01_LISTE_CODES_CSV 
AS
Declare @sFicOut     VarChar(1000),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@sCommande VarChar(255),
	@iRetOsql	int, 
	@sSql varchar(1000)

--Set @sPath 	=master.sysadm.SPB_FN_GET_ROOT() + '\Sinistre\Referentiel\'
Set @sPath 	='\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_vDoc14935_m_Deschamps_Referentiel\'
Set @sFileExt	= 'csv'


SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode
-- -d => indique la base

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u ' + '-d' + db_name()

-- Codes actions

SET @sFicOut = @sPath + 'Simpa2_Codes_Actions' + '.' + @sFileExt
set @sSql='exec sysadm.PS_S01_LISTE_CODES_ACTIONS '
SET @sCommande = 	'sqlcmd.exe /S' + @sNomServeur + ' /E /Q"' + 
			@sSql +	'" /o"' + @sFicOut + '" -w5000 -W ' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

-- Status_gc
SET @sFicOut = @sPath + 'Simpa2_Status_gc' + '.' + @sFileExt

Set @sSql='set nocount on;select id_code, lib_code '
Set @sSql=@sSql + 'from sysadm.code '
Set @sSql=@sSql + 'where id_typ_code=''-GC'' '

SET @sCommande = 	'sqlcmd.exe /S' + @sNomServeur + ' /E /Q"' + 
			@sSql +	'" /o' + @sFicOut + ' -w5000 -W ' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

--  Codes Process
SET @sFicOut = @sPath + 'Simpa2_Codes_process' + '.' + @sFileExt

Set @sSql='exec sysadm.PS_S01_LISTE_CODES_PROCESS '

SET @sCommande = 	'sqlcmd.exe /S' + @sNomServeur + ' /E /Q"' + 
			@sSql +	'" /o' + @sFicOut + ' -w5000 -W ' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Go

grant execute on sysadm.PS_S01_LISTE_CODES_CSV to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_MARYSE_DBL_RGLT_VDOC9699
-- Auteur               :       FPI
-- Date                 :       12/08/2014
-- Libellé              :       Refonte de la VDoc6588
-- Commentaires         :       
-- Références           :       [VDOC9699]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MARYSE_DBL_RGLT_VDOC9699' AND type = 'P' )
        DROP procedure sysadm.PS_S_MARYSE_DBL_RGLT_VDOC9699
GO


CREATE procedure sysadm.PS_S_MARYSE_DBL_RGLT_VDOC9699
AS
Declare @sDateDeb Varchar ( 20 ) -- Format Date de présentation
Declare @sDateFin Varchar ( 20 ) -- Format Date de présentation
Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @dtToday datetime
declare @cmd varchar(500)
Declare @nbMaxCol int,
	@i int
Declare @sSelectFinal varchar(3000)

Set Nocount on
Select @dtToday		= getdate()

-- Date début - 1er du mois -1
Select @dtDateDeb	= DATEADD(month,-1,getdate())
select @dtDateDeb=CONVERT(datetime,
	convert(varchar(4),year(@dtDateDeb)) + right('0' + convert(varchar(2),month(@dtDateDeb)),2) + '01',112)
Select @sDateDeb	= Convert(Varchar(10),@dtDateDeb, 103)+ ' ' + Convert ( Varchar( 8 ),@dtDateDeb, 114)

-- Date de fin = date du jour à minuit
Select @dtDateFin	= DateAdd ( ss , -1, cast (Convert(VarChar (8), @dtToday, 112 ) as datetime ) )
Select @sDateFin	= Convert(Varchar(10),@dtDateFin, 103)+ ' ' + Convert ( Varchar( 8 ),@dtDateFin, 114)

if exists (SELECT * FROM tempdb.sys.objects WHERE object_id = OBJECT_ID(N'tempdb.dbo.#tbResult'))
Begin
	drop table #tbResult
end

CREATE TABLE #tbResult (id_seq int IDENTITY,
	lib varchar(60),
	periode varchar(50),
	id_prod decimal(7,0),
	lib_cie varchar(35),
	id_sin decimal(10,0), -- [PI062]
	dte_surv varchar(10),
	mt_regl_ass decimal(11,2),
	dte_regl_ass varchar(10),
	lib_evt_reg_ass varchar(35),
	mt_regl_frn decimal(11,2),
	dte_regl_frn varchar(10),
	fournisseur varchar(35),
	type_reglement varchar(2), 
	id_seq_cmd int
	)

Declare @tb TABLE (id_sin decimal(10,0), -- [PI062]
	lib varchar(60))
Declare @sPeriode varchar(50)

set @sPeriode='du ' + @sDateDeb + ' au ' + @sDateFin 

Set @sSelectFinal='select periode, id_prod, ' +
	'lib_cie, id_sin, dte_surv, isnull(mt_regl_ass,0) mt_regl_ass, isnull(dte_regl_ass,'''') dte_regl_ass, ' +
	'isnull(lib_evt_reg_ass,'''') lib_evt_reg_ass, '+
	'isnull(mt_regl_frn,0) mt_regl_frn, isnull(dte_regl_frn,'''') dte_regl_frn, '+
	'isnull(fournisseur,'''') fournisseur, '+
	'isnull(type_reglement,'''') type_rg, id_seq_cmd'

insert into @tb 
Select Distinct
   r.id_sin,
   'Regl Four > 8€ sans RM + Régl Assuré > 50€ sans RM' 'Cas'
From  inter i,
      reglement r,
      reglement r2,
      reg_gti rg
Where i.id_four is not null
And   r.id_sin = i.id_sin
And   ( r.cree_le between @dtDateDeb and @dtDateFin
	or r2.cree_le between @dtDateDeb and @dtDateFin)
And   r.id_i = i.id_i
And   r.cod_mode_reg = 'FM'
And   r.mt_tot_reg >= 8
And     Not Exists ( 
            Select * 
            From   reglement r3
            Where  r3.id_sin = r.id_sin
            And      r3.cod_mot_reg = 'RM'
            And    r3.id_reg_base = r.id_reg
            )
And   r2.id_sin = r.id_sin
and   r2.id_i = 0
and   r2.mt_tot_reg >= 50
and   rg.id_sin = r2.id_sin
and   rg.id_gti not in ( 7, 8 )
and   rg.id_reg=r2.id_reg
and   rg.id_gti > 0
And     Not Exists ( 
            Select * 
            From   reglement r4
            Where  r4.id_sin = r2.id_sin
            And      r4.cod_mot_reg = 'RM'
            And    r4.id_reg_base = r2.id_reg
            )

insert into @tb 
Select Distinct
   i.id_sin,
   'Multi regl fourn > 8€ sans RM' 'Cas'
From  sysadm.inter i,
	  sysadm.reglement r
Where i.id_four is not null
And   r.id_sin = i.id_sin
And   r.cree_le between @dtDateDeb and @dtDateFin
And   r.id_i = i.id_i
And   r.cod_mode_reg = 'FM'
And   r.mt_tot_reg >= 8
And     Not Exists ( 
            Select * 
            From   reglement r3
            Where  r3.id_sin = r.id_sin
            And      r3.cod_mot_reg = 'RM'
            And    r3.id_reg_base = r.id_reg
            )
And  Exists ( 
			Select *
			From reglement r2
			Where r2.id_sin = r.id_sin
			And	  r2.cod_mode_reg = 'FM'
			And   r2.id_reg <> r.id_reg
			And   r2.mt_tot_reg >= 8
			And     Not Exists ( 
						Select * 
						From   reglement r4
						Where  r4.id_sin = r2.id_sin
						And      r4.cod_mot_reg = 'RM'
						And    r4.id_reg_base = r2.id_reg
						)
 )
 and not exists (select * from @tb t where t.id_sin=r.id_sin)

insert into #tbResult ( periode,id_prod, lib_cie,id_sin, dte_surv,	
	mt_regl_frn, dte_regl_frn, fournisseur, type_reglement, id_seq_cmd)
Select 
   @sPeriode,
   s.id_prod,
   sysadm.FN_LIB_CIE(s.id_sin),
   r.id_sin,
   CONVERT(varchar(10),s.dte_surv,103),
   r.mt_tot_reg 'regl_fourn',
   Convert ( varchar(10), r.cree_le , 103 ) 'dte_regl_fourn',
   sysadm.FN_CODE_CAR ( i.id_four, '-FR') 'Fourn',
   r.cod_mot_reg 'type_reglement',
   (select top 1 id_seq 
    from detail d
		inner join commande c on c.id_sin=d.id_sin and c.id_gti=d.id_gti  and c.id_detail=d.id_detail
	where d.id_sin=t.id_sin and r.id_reg=d.id_reg) 'id_seq_cmd'
From  inter i,
      reglement r,
       @tb t,
       sinistre s
Where t.id_sin=r.id_sin
and r.id_sin=s.id_sin
And   r.id_sin = i.id_sin
And	i.id_four is not null
And   r.id_i = i.id_i
And   r.cod_mode_reg = 'FM'
order by r.cree_le

Update #tbResult set 
	mt_regl_ass= r2.mt_tot_reg,
	dte_regl_ass=Convert ( varchar(10), r2.cree_le, 103 ),
	lib_evt_reg_ass=sysadm.FN_CODE_NUM(d.id_evt,'+EV')
from #tbResult t,
	reglement r2,
	detail d
where t.id_sin = r2.id_sin
and   r2.id_i = 0
and   r2.mt_tot_reg >= 50
and   r2.id_reg=(select top 1 rg.id_reg
	from reg_gti rg
	where r2.id_reg=rg.id_reg
	and   rg.id_sin = r2.id_sin
	and   rg.id_gti not in ( 7, 8 )
	and   rg.id_gti > 0
	And     Not Exists ( 
		    Select * 
            From   reglement r4
            Where  r4.id_sin = r2.id_sin
            And      r4.cod_mot_reg = 'RM'
            And    r4.id_reg_base = r2.id_reg
            )
     order by rg.mt_reg desc)
 and d.id_sin=t.id_sin 
 and d.id_reg=r2.id_reg

select @nbMaxCol=MAX(nb)
from (select COUNT(*) nb, id_sin, lib from #tbResult t group by id_sin, lib) a


Set @i=1
While @i < @nbMaxCol
Begin

	-- Création des 3 nouvelles colonnes
	Set @i=@i + 1
	set @cmd ='Alter TABLE #tbResult add mt_regl_frn_' + convert(varchar(2), @i) + ' decimal(11,2),' +
		'dte_regl_frn_' + convert(varchar(2), @i) + ' varchar(10),' +
		'fournisseur_' + convert(varchar(2), @i) + ' varchar(35),'	+
		'type_rg_' + convert(varchar(2), @i) + ' varchar(2),'	+
		'id_seq_cmd_' + convert(varchar(2), @i) + ' int'
	exec (@cmd)
	
	-- Mise à jour de ces colonnes avec la dernière ligne du même id_sin
	set @cmd ='update tr set mt_regl_frn_' + convert(varchar(2), @i) + '=tr2.mt_regl_frn, ' +
			'dte_regl_frn_' + convert(varchar(2), @i) + '=tr2.dte_regl_frn, ' +
			'fournisseur_' + convert(varchar(2), @i) + '=tr2.fournisseur, ' +
			'type_rg_' + convert(varchar(2), @i) + '=tr2.type_reglement , ' +
			'id_seq_cmd_' + convert(varchar(2), @i) + '=tr2.id_seq_cmd ' +
		'from #tbResult tr ' +
		'inner join #tbResult tr2 on tr.id_sin=tr2.id_sin ' +
		'where tr.id_seq < tr2.id_seq ' +
		'and not exists (select * from #tbResult t where tr2.id_sin=t.id_sin and  tr2.id_seq > t.id_seq and t.id_seq <> tr.id_seq)' 
	exec (@cmd)
	
	-- Suppression de la dernière ligne d'un groupe d'id_sin
	delete from tr2
		from #tbResult tr 
		inner join #tbResult tr2 on tr.id_sin=tr2.id_sin 
		where tr.id_seq < tr2.id_seq 
			and not exists (select * from #tbResult t where tr2.id_sin=t.id_sin and tr2.id_seq > t.id_seq and t.id_seq <> tr.id_seq)
			
	-- Maj select final
	Set @sSelectFinal=@sSelectFinal + 
		', isnull(mt_regl_frn_' + convert(varchar(2), @i) + ',0) mt_regl_frn_' + convert(varchar(2), @i) +
		', isnull(dte_regl_frn_' + convert(varchar(2), @i) +  ','''') dte_regl_frn_' + convert(varchar(2), @i) +
		', isnull(fournisseur_' + convert(varchar(2), @i)  +  ','''') fournisseur_' + convert(varchar(2), @i) + 
		', isnull(type_rg_' + convert(varchar(2), @i)  +  ','''') type_rg_' + convert(varchar(2), @i)+ 
		', id_seq_cmd_' + convert(varchar(2), @i)  
End

--Alter table #tbResult drop column id_seq

--select * from #tbResult

Set @sSelectFinal=@sSelectFinal + ' from #tbResult'

exec (@sSelectFinal)
Go

grant execute on sysadm.PS_S_MARYSE_DBL_RGLT_VDOC9699 to rolebddsinistres
Go

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MARYSE_DBL_RGLT_VDOC9699_FIC' AND type = 'P' )
        DROP procedure sysadm.PS_S_MARYSE_DBL_RGLT_VDOC9699_FIC
GO

CREATE procedure sysadm.PS_S_MARYSE_DBL_RGLT_VDOC9699_FIC
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(500),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_Dblt_Maryse_vDoc9699\'
Set @sFileName	= 'Export_Dblt_Maryse_vDoc9699_'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + convert(varchar(8),getdate(),112) + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_MARYSE_DBL_RGLT_VDOC9699 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_MARYSE_DBL_RGLT_VDOC9699 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Go

grant execute on sysadm.PS_S_MARYSE_DBL_RGLT_VDOC9699_FIC to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_VDOC15044_S_VABRE
-- Auteur               :       JFF
-- Date                 :       11/01/2013
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [DT076_ADVISE_V3]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- JFF  08/12/2016	VDOC22568
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC15044_S_VABRE' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC15044_S_VABRE
GO

CREATE procedure sysadm.PS_S_VDOC15044_S_VABRE
AS

Select	s.id_prod,
		sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_prod',
		sysadm.FN_LIB_ETAT_DOS_ASSURE ( s.id_sin, 'LIB' ) 'état_vu_assuré',
		sysadm.FN_LIB_POLICE ( s.id_sin ) 'police',
		sysadm.FN_LIB_CIE ( s.id_sin ) 'compagnie',
		count (*) 'Nbre'

From	sysadm.sinistre s

where s.id_prod in ( 
86701,
86700,
84300,
84301,
84302,
84303 )
Or id_prod between 84000 and 84099 -- vDoc22568

Group By 
		s.id_prod,
		sysadm.FN_LIB_PROD ( s.id_prod ) ,
		sysadm.FN_LIB_ETAT_DOS_ASSURE ( s.id_sin, 'LIB' ) ,
		sysadm.FN_LIB_POLICE ( s.id_sin ) ,
		sysadm.FN_LIB_CIE ( s.id_sin ) 
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_VDOC15044_S_VABRE_MAIL
-- Auteur               :       JFF
-- Date                 :       11/01/2013
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [DT076_ADVISE_V3]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC15044_S_VABRE_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC15044_S_VABRE_MAIL
GO

CREATE procedure sysadm.PS_S_VDOC15044_S_VABRE_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(500),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @iMois Integer
Declare @iAnnee Integer
Declare @iJour Integer


-- chemin d'enregistrement du Result Set
-- Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_DT076_IRR_PSM_VERS_O2M\'
Set @sPath 	= '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_VDOC15044_S_VABRE\'
Set @sFileName	= 'VDOC15044_S_VABRE'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode
-- -d => indique la base

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u' + ' -d' + db_name()

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'sysadm.PS_S_VDOC15044_S_VABRE ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output


Set @sObjet    = 'Extraction vDoc15044'

set @sMessage  = 'Bonjour,'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Veuillez-trouver à l''emplacement ci-dessous, l''extraction liée à la vDoc citée en objet.'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_VDOC15044_S_VABRE\VDOC15044_S_VABRE.XLS'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Cordialement,'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'SPB.'

EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
--			'jff@spb.fr',
			'svabre@spb.fr',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			NULL, 
			NULL, 
			NULL, 
			NULL, 
			NULL

Go

grant execute on sysadm.PS_S_VDOC15044_S_VABRE_MAIL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_COD_ETAT_ASS
-- Auteur               :       JFF
-- Date                 :       08/09/2014
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [SANDRINE]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_COD_ETAT_ASS' AND type = 'P' )
        DROP procedure sysadm.PS_S_COD_ETAT_ASS
GO

CREATE procedure sysadm.PS_S_COD_ETAT_ASS
AS

Delete from trace_etat_ass

Insert into trace_etat_ass
Select  s.id_sin,
		sysadm.FN_LIB_ETAT_DOS_ASSURE (s.id_sin, 'CODE' ) ,
		GETDATE() 
		
From	sysadm.sinistre s
Where   Exists ( 
			Select 1
			From   sysadm.det_pro dp	
			Where  dp.id_prod = s.id_prod
			And    sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( dp.val_car ), ';' ) in ( 'ORANGE_V3' ) --, 'ORANGE_V2', 'ORANGE_V2BIS' )
		)

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_JOURN_IRREP_PSM
-- Auteur               :       FPI
-- Date                 :       24/09/2014
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [PM273-1]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- 29/09/2015	FPI	[VDoc18783]
-- 26/11/2015   FPI [VDoc19281] Suppression du critère d'etat du dossier
-- 08/03/2016   JFF [VDOC20161]
-- 21/11/2018   JFF [VDOC27123]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_JOURN_IRREP_PSM' AND type = 'P' )
        DROP procedure sysadm.PS_S_JOURN_IRREP_PSM
GO

CREATE procedure sysadm.PS_S_JOURN_IRREP_PSM
AS

Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation


-- @dtDateDeb = la veille à 00:00
Set @dtDateDeb = CONVERT( DateTime,
				convert(varchar(10), DATEADD(day,-1,getdate()) , 103),
				 103 )

-- @@dtDateFin = la veille à 23:59:59
Set @dtDateFin = CONVERT( DateTime,
			convert(varchar(10), getdate() , 103),
				 103 )

set @dtDateFin=DATEADD(SECOND,-1,@dtDateFin)

Select Convert ( VarChar ( 10), @dtDateDeb, 103 ) 'periode_deb_dte_fin_trt',
	   Convert ( VarChar ( 10), @dtDateFin, 103 ) 'periode_fin_dte_fin_trt',
	   CONVERT ( VarChar ( 10), c.id_sin ) + '-' + CONVERT ( VarChar ( 10), c.id_seq )'num_presta_spb',
	   s.id_prod,
	   sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_prod',
	   cie.lib_cie 'Assureur',
	   s.marq_port 'Marque',
	   s.modl_port 'Modele',
	   '''' + s.num_imei_port + '''' 'IMEI',
	   c.id_ref_four 'Ordre_prioritaire',
	   c.status_gc,
	   sysadm.FN_CODE_NUM ( c.status_gc, '-GC' ) 'Lib_Statut_Gc',
	   c.comment_frn,
	   Case 
	      -- [VDOC27123]BVID/BVIP/BVIT
		  When CHARINDEX ( '[BVIE]', c.comment_frn ) > 0  Then '[BVIE]'
		  When CHARINDEX ( '[BVID]', c.comment_frn ) > 0  Then '[BVID]'
		  When CHARINDEX ( '[BVIP]', c.comment_frn ) > 0  Then '[BVIP]'
		  When CHARINDEX ( '[BVIT]', c.comment_frn ) > 0  Then '[BVIT]'
		  When CHARINDEX ( '[BVIEOX]', c.comment_frn ) > 0 Then '[BVIEOX]'
		  Else 'Aucune clé'
	   End 'Clé_Comment',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré en pointe de vente'
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré envoie coli en centralisation'
	   End 'pdv_ou_coli_centl',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
				/* [VDOC20161]
				Then ( Select Top 1 b.adr_nom
					   From sysadm.boutique b
					   Where b.id_prod = s.id_prod
					   And b.cod_mag = sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' )
					 )
				*/
	   End 'Nom PSM',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
				-- Then sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' ) [VDOC20161]
	   End 'Numéro PSM',
	   Convert ( VarChar ( 10), c.dte_rcp_frn, 103 ) 'dte_rcp_PSM',
	   Convert ( VarChar ( 10), c.dte_env_cli, 103 ) 'dte_fin_trt_en_cli',
	   sysadm.FN_CODE_CAR(d.val_car,'-AR') 'Type appareil'

From sysadm.commande c
Inner Join sysadm.gar_sin g on g.id_sin = c.id_sin And g.id_gti = c.id_gti
Inner Join sysadm.sinistre s on s.id_sin = c.id_sin
Inner Join sysadm.garantie ga on ga.id_prod = s.id_prod And 
								 ga.id_gti = c.id_gti And
								 ga.id_rev = s.id_rev
Inner Join sysadm.police po on po.id_police = ga.id_police
Inner Join sysadm.compagnie cie on cie.id_cie = po.id_cie
inner join sysadm.div_sin d on d.id_sin=c.id_sin
Where c.cree_le > '01/01/2015'
And   c.dte_env_cli is not null
And   c.id_ref_four in ( 'A_REPARER', 'A_REPARER_FORCE', 'A_DESOXYDER', 'A_DESOXYDER_FORCE' )
And   (  ( c.status_gc in ( 21, 23 ) And ( CHARINDEX ( '[BVIE]', c.comment_frn ) > 0 Or CHARINDEX ( '[BVID]', c.comment_frn ) > 0 Or CHARINDEX ( '[BVIP]', c.comment_frn ) > 0 Or CHARINDEX ( '[BVIT]', c.comment_frn ) > 0) )--And sysadm.FN_LIB_ETAT_DOS_ASSURE ( c.id_sin, 'CODE') in (1500, 1510))
	Or	 ( c.status_gc in ( 21, 23 ) And CHARINDEX ( '[BVIEOX]', c.comment_frn ) > 0 )--And sysadm.FN_LIB_ETAT_DOS_ASSURE ( c.id_sin, 'CODE') in (1500, 1510))
	  )
And s.id_prod not between 48100 and 48199 -- [VDoc18783]
And s.id_prod not between 84000 and 84099 -- [VDoc18783]
and d.nom_zone='type_app'
And   c.dte_env_cli between @dtDateDeb And @dtDateFin

Go

grant execute on sysadm.PS_S_JOURN_IRREP_PSM to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procédure            :       PS_S_JOURN_IRREP_PSM_EXCEL
-- Auteur               :       FPI
-- Date                 :       24/09/2014
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [PM273-1]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- FPI	12/12/2015	FPI	[VDoc18886] 
-- FPI 	12/09/2016 	FPI	[VDoc21259] appel de PS_S_IRREP_PSM
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_JOURN_IRREP_PSM_EXCEL' AND type = 'P' )
        DROP procedure sysadm.PS_S_JOURN_IRREP_PSM_EXCEL
GO

CREATE procedure sysadm.PS_S_JOURN_IRREP_PSM_EXCEL
AS


DECLARE @sCommande   VarChar(250),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
        @sFicOut2     VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sPath2 VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	




-- chemin d'enregistrement du Result Set
--Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Extraction_PSM_Mens_vDoc9850\'
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT() + 'SIMPA2\O2M\Irrep_PSM\'
Set @sPath2 	= master.sysadm.SPB_FN_GET_ROOT() + 'SIMPA2\PSM\Irrep_PSM\'
Set @sFileName	= 'Irrep_PSM_'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + convert(varchar(8),getdate(),112) + '.' + @sFileExt
SET @sFicOut2 = @sPath2 + @sFileName + convert(varchar(8),getdate(),112) + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' -- + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SET NOCOUNT ON;exec SIMPA2_PRO.sysadm.PS_S_IRREP_PSM ''J'' ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SET NOCOUNT ON;exec SIMPA2_TRT.sysadm.PS_S_IRREP_PSM ''J'' ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

-- [VDoc18886] 
IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SET NOCOUNT ON;exec SIMPA2_PRO.sysadm.PS_S_IRREP_PSM ''J'' ' + 
			'" /o' + @sFicOut2 + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SET NOCOUNT ON;exec SIMPA2_TRT.sysadm.PS_S_IRREP_PSM ''J'' ' + 
			'" /o' + @sFicOut2 + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output


Go

grant execute on sysadm.PS_S_JOURN_IRREP_PSM_EXCEL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_RESTIT_DATA_O2M
-- Auteur               :       JFF
-- Date                 :       25/08/2014
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [MODIF_SUITE_REDR]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		    PAR		 Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RESTIT_DATA_O2M' AND type = 'P' )
        DROP procedure sysadm.PS_S_RESTIT_DATA_O2M
GO

CREATE procedure sysadm.PS_S_RESTIT_DATA_O2M
AS

Select t.id_sin,
	   t.id_seq,
	   t.alt_bcv,
	   case  t.nom_zone
		When 'dte_env_cli' Then 'dte_fin_trait'
		When 'id_orian_modele' Then 'piece_jointe'
		When 'adrfc_nom' Then 'transporteur'
		Else t.nom_zone
	   end 'nom_zone',
	   case 
			When t.nom_zone = 'id_orian_modele' and t.val_car = '1' Then 'O'
			When t.nom_zone = 'id_orian_modele' and t.val_car = '2' Then 'N'
			Else t.val_car
	   End 'val_car',
	   t.nom_fic 'nom_fic_O2M',
	   sysadm.FN_AFF_DATE ( t.cree_le, 'AVEC_HEURE') 'dte_integration'
 
from sysadm.v_trace_cmde t,
	 sysadm.commande c
Where t.cree_le > DATEADD ( DAY, -1, GETDATE () )
And   t.id_sin = c.id_sin
And	  t.id_seq = c.id_seq
And   c.id_four = 'O2M'
And	  t.val_car is not null
and	  LTRIM ( t.val_car ) <> ''
and   t.nom_zone not in ( 'id_bsp', 'mt_devis', 'alt_dev_acp' )

Order by t.nom_fic, t.cree_le

Go


--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_RESTIT_DATA_O2M_FIC
-- Auteur               :       JFF
-- Date                 :       25/08/2014
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [MODIF_SUITE_REDR]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		    PAR		 Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RESTIT_DATA_O2M_FIC' AND type = 'P' )
        DROP procedure sysadm.PS_S_RESTIT_DATA_O2M_FIC
GO

CREATE procedure sysadm.PS_S_RESTIT_DATA_O2M_FIC
AS

DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
        @sFicDel     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	,
	@sDest VarChar ( 200 )
	

-- chemin d'enregistrement du Result Set
-- Set @sPath 	= '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\'
Set @sPath 	= '\\F4T\SIMPA2\O2M\Restit_data\'
Set @sFileName	= 'Restitution_data_O2M_' + convert( varchar ( 10), GETDATE(), 112 ) + replace ( convert( varchar ( 10), GETDATE(), 108 ) , ':', '' ) 
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' -- + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_RESTIT_DATA_O2M ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_RESTIT_DATA_O2M ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Go

grant execute on sysadm.PS_S_RESTIT_DATA_O2M_FIC to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_AXA_SIN_CLE_REGLE
-- Auteur               :       FPI
-- Date                 :       29/10/2014
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [PC13174]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- JFF      12/05/2020   [PI085]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_AXA_SIN_CLE_REGLE' AND type = 'P' )
        DROP procedure sysadm.PS_S_AXA_SIN_CLE_REGLE
GO

CREATE procedure sysadm.PS_S_AXA_SIN_CLE_REGLE
AS

Declare @sDateDeb Varchar ( 20 ) -- Format Date de présentation
Declare @sDateFin Varchar ( 20 ) -- Format Date de présentation
Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @dtToday datetime

SET NOCOUNT ON

Select @dtToday		= getdate()

Select @dtDateDeb	= Convert(Varchar (8), DateAdd ( day, -1, @dtToday) , 112 )
Select @dtDateFin	= DateAdd ( ss , -1, cast (Convert(VarChar (8), @dtToday, 112 ) as datetime ) )

Select  Right ( Replicate ( ' ', 10 ) + 'SPB', 10 ) +
		Right ( Replicate ( ' ', 20 ) + 'SINISTRES REGLES', 20 ) +
		Convert ( varchar (10), DateAdd ( day, -1, @dtToday) , 112 ) 
Union all		
Select	-- Right ( Replicate ( '0', 3 ) + Convert ( VarChar ( 3), p.cod_prod_dms), 3 ) + -- [PI085]
		Right ( Replicate ( '0', 5 ) + Convert ( VarChar ( 5), p.cod_prod_dms), 5 ) + -- [PI085]
		Right ( Replicate ( '0', 5 ) + Convert ( VarChar ( 5), s.id_ets), 5 ) +
		Right ( Replicate ( '0', 7 ) + s.id_adh, 7 ) +
		Right ( Replicate ( '0', 1 ) + Convert ( VarChar ( 1), s.id_sdos), 1 ) +
		Convert ( varchar (10), s.dte_surv, 112 ) +
		Right( REPLICATE ( '0' , 10 ) + Replace ( CONVERT ( varchar ( 10 ),
				IsNull (
				(
				Select SUM ( rg2.mt_reg )
				From	sysadm.reglement r2,
						sysadm.reg_gti rg2
				Where   r2.id_sin = s.id_sin
				And		r2.cod_mot_reg in ( 'RN', 'RM', 'RP' )
				And		rg2.id_sin = r2.id_sin
				And		rg2.id_reg = r2.id_reg
				And		rg2.id_gti = 1
				),0) *100 
			), '.00', '') , 10 ) +
		IsNull ( 
			(   Select  Convert ( varchar(10), Min ( r2.dte_reg ), 112 )
				From	sysadm.reglement r2,
						sysadm.reg_gti rg2
				Where   r2.id_sin = s.id_sin
				And		r2.cod_mot_reg = 'RN' 
				And		rg2.id_sin = r2.id_sin
				And		rg2.id_reg = r2.id_reg
				And		rg2.id_gti = 1
			), '00000000' )

From	sysadm.produit p,
		sysadm.sinistre s,
		sysadm.det_pro d
Where   p.cod_prod_dms = 2
And		p.id_prod = s.id_prod
And		s.id_ets in ( 1001, 11001 )
And		s.id_sdos = 1
And		Exists ( 
		Select 1
		From sysadm.reglement r,
			 sysadm.reg_gti rg
		Where   r.id_sin = s.id_sin
		And		r.cod_mot_reg in ( 'RN' )
		And		rg.id_sin = r.id_sin
		And		rg.id_reg = r.id_reg
		And		rg.id_gti = 1
		And		r.cree_le between @dtDateDeb And @dtDateFin 
		)
and   d.id_prod=p.id_prod
and   d.id_code_dp = 94
and   sysadm.FN_CLE_VAL ( 'COD_DW', rtrim( val_car), ';' ) = 'STAT_QUOT_AXA_SIN_CLE_REGLE'
Union All
Select  Right ( Replicate ( '0', 5 ) + Convert ( VarChar ( 5), COUNT ( * ) ), 5 ) + 
		SPACE ( 38 )
From	sysadm.produit p,
		sysadm.sinistre s,
		sysadm.det_pro d
Where   p.cod_prod_dms = 2
And		p.id_prod = s.id_prod
And		s.id_ets in ( 1001, 11001 )
And		s.id_sdos = 1
And		Exists ( 
		Select 1
		From sysadm.reglement r,
			 sysadm.reg_gti rg
		Where   r.id_sin = s.id_sin
		And		r.cod_mot_reg in ( 'RN' )
		And		rg.id_sin = r.id_sin
		And		rg.id_reg = r.id_reg
		And		rg.id_gti = 1
		And		r.cree_le between @dtDateDeb And @dtDateFin 
		)
and   d.id_prod=p.id_prod
and   d.id_code_dp = 94
and   sysadm.FN_CLE_VAL ( 'COD_DW', rtrim( val_car), ';' ) = 'STAT_QUOT_AXA_SIN_CLE_REGLE'

Go
grant execute on sysadm.PS_S_AXA_SIN_CLE_REGLE to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_AXA_SIN_CLE_REGLE_QUOTIDIEN
-- Auteur               :       FPI
-- Date                 :       29/10/2014
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [PC13174]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_AXA_SIN_CLE_REGLE_QUOTIDIEN ' AND type = 'P' )
        DROP procedure sysadm.PS_S_AXA_SIN_CLE_REGLE_QUOTIDIEN 
GO

CREATE procedure sysadm.PS_S_AXA_SIN_CLE_REGLE_QUOTIDIEN 
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(500),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_Axa_Sin_Cle_Regle\'
Set @sFileName	= 'Export_Axa_Sin_Cle_Regle'
Set @sFileExt	= 'txt'

SET @sFicOut = @sPath + @sFileName + Convert(Varchar (8), DateAdd ( day, -1, GETDATE()) , 112 ) + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
		db_name(db_id()) + '.sysadm.PS_S_AXA_SIN_CLE_REGLE ' + 
		'" /o' + @sFicOut + ' -h-1 -w5000' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Go

grant execute on sysadm.PS_S_AXA_SIN_CLE_REGLE_QUOTIDIEN to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 		PS_S_VDOC15840_M_URBAN
-- Auteur               :       FPI
-- Date                 :       04/11/2014
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC15840]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- FPI - 04/06/2015 - [VDOC17799] Ajout de produits, colonnes Marques & nb décla
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC15840_M_URBAN' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC15840_M_URBAN
GO

CREATE procedure sysadm.PS_S_VDOC15840_M_URBAN
AS

SET NOCOUNT ON

Select s.id_prod,
		sysadm.FN_LIB_PROD(s.id_prod) as lib_produit,
		sysadm.FN_CODE_CAR(d.val_car,'-AR') as type_app,
	   Case When s.marq_port='APPLE' Then 'APPLE' Else 'Hors Apple' End as Marques,
	   Min ( Convert ( VarChar ( 20), DATEADD ( month, -1, GETDATE()),103)) 'Du',
	   Min ( Convert ( VarChar ( 20), DATEADD ( day, -1, GETDATE()),103)) 'Au',
	   c.id_four,
	   sysadm.FN_CODE_CAR ( c.id_four, '-FR' ) 'lib_four',
       SUM ( Case When c.id_ref_four = 'A_REPARER' Then 1 else 0 End)  'Demande_de_reparation_vers_le_fournisseur',
	   SUM ( Case When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' Then 1 Else 0 End  ) as 'Nbre_en_pdv' ,
       SUM ( Case When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' Then 1 Else 0 End ) 'Envoi_en_centralisation',
       SUM ( Case When dte_rcp_frn is not null Then 1 Else 0 End ) 'Appareil_recu',
       SUM ( Case When status_gc = 2 Then 1 Else 0 End ) 'Appareil_repare',
	   SUM ( Case When c.id_ref_four = 'A_DIAGNOSTIQUER' Then 1 else 0 End)  'Demande_de_diagnostic_vers_le_fournisseur',
	   (select COUNT(*) from sysadm.sinistre s2 
		inner join sysadm.gar_sin g on g.id_sin=s2.id_sin
		where s2.id_prod=s.id_prod 
		and g.id_gti in (11,40,41)
		and s2.cree_le between DATEADD ( month, -1, GETDATE()) and DATEADD ( day, -1, GETDATE())) as 'Nbre déclarations dommages acc.'
From   sysadm.sinistre s,
	   sysadm.commande c,
	   sysadm.div_sin d
Where  ( s.id_prod between 35800 and 35807 Or s.id_prod between 80500 and 80503
	or s.id_prod between 44500 and 44503 or s.id_prod in (48400,48401) )
and    c.id_sin = s.id_sin
And    c.id_four in ( 'PSM', 'O2M' )
And    c.id_ref_four in ( 'A_REPARER','A_DIAGNOSTIQUER')
And	   c.cree_le between DATEADD ( month, -1, GETDATE()) and DATEADD ( day, -1, GETDATE())
And	   d.id_sin=s.id_sin
and	   d.nom_zone='type_app'
Group by  sysadm.FN_CODE_CAR(d.val_car,'-AR'), c.id_four,
	      sysadm.FN_CODE_CAR ( c.id_four, '-FR' ) ,
	      s.id_prod,Case When s.marq_port='APPLE' Then 'APPLE' Else 'Hors Apple' End
Union all
Select s.id_prod,
		sysadm.FN_LIB_PROD(s.id_prod) as lib_produit,
		sysadm.FN_CODE_CAR(d.val_car,'-AR') as type_app,
	   Case When s.marq_port='APPLE' Then 'APPLE' Else 'Hors Apple' End as Marques,
	   'Sans période',
	   'Sans période',
	   c.id_four,
	   sysadm.FN_CODE_CAR ( c.id_four, '-FR' ) 'lib_four',
       SUM ( Case When c.id_ref_four = 'A_REPARER' Then 1 else 0 End)  'Demande_de_reparation_vers_le_fournisseur',
	   SUM ( Case When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' Then 1 Else 0 End  ) as 'Nbre_en_pdv' ,
       SUM ( Case When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' Then 1 Else 0 End ) 'Envoi_en_centralisation',
       SUM ( Case When dte_rcp_frn is not null Then 1 Else 0 End ) 'Appareil_recu',
       SUM ( Case When status_gc = 2 Then 1 Else 0 End ) 'Appareil_repare',
	   SUM ( Case When c.id_ref_four = 'A_DIAGNOSTIQUER' Then 1 else 0 End)  'Demande_de_diagnostic_vers_le_fournisseur',
	   (select COUNT(*) from sysadm.sinistre s2 
		inner join sysadm.gar_sin g on g.id_sin=s2.id_sin
		where s2.id_prod=s.id_prod 
		and g.id_gti in (11,40,41)) as 'Nbre déclarations dommages acc.'
From   sysadm.sinistre s,
	   sysadm.commande c,
	   sysadm.div_sin d
Where  ( s.id_prod between 35800 and 35807 Or s.id_prod between 80500 and 80503 
	or s.id_prod between 44500 and 44503 or s.id_prod in (48400,48401) )
and    c.id_sin = s.id_sin
And    c.id_four in ( 'PSM', 'O2M' )
And    c.id_ref_four in ( 'A_REPARER','A_DIAGNOSTIQUER')
And	   d.id_sin=s.id_sin
and	   d.nom_zone='type_app'
Group by sysadm.FN_CODE_CAR(d.val_car,'-AR'), c.id_four,
	      sysadm.FN_CODE_CAR ( c.id_four, '-FR' ) , 
	      s.id_prod,Case When s.marq_port='APPLE' Then 'APPLE' Else 'Hors Apple' End
Union all
Select s.id_prod,
		sysadm.FN_LIB_PROD(s.id_prod) as lib_produit,
		'Nombre de déclarations' as type_app,
	   Case When s.marq_port='APPLE' Then 'APPLE' Else 'Hors Apple' End as Marques,
	   Min ( Convert ( VarChar ( 20), DATEADD ( month, -1, GETDATE()),103)) 'Du',
	   Min ( Convert ( VarChar ( 20), DATEADD ( day, -1, GETDATE()),103)) 'Au',
	   '-' id_four,
	   sysadm.FN_CODE_NUM(g.id_gti,'-GA') 'lib_four',
       count(*)  'Demande_de_reparation_vers_le_fournisseur',
	   0 as 'Nbre_en_pdv' ,
       0 'Envoi_en_centralisation',
       0 'Appareil_recu',
       0 'Appareil_repare',
       0 'Demande_de_diagnostic_vers_le_fournisseur',
	   (select COUNT(*) from sysadm.sinistre s2 
		inner join sysadm.gar_sin g on g.id_sin=s2.id_sin
		where s2.id_prod=s.id_prod 
		and g.id_gti in (11,40,41)
		and s2.cree_le between DATEADD ( month, -1, GETDATE()) and DATEADD ( day, -1, GETDATE())) as 'Nbre déclarations dommages acc.'
From   sysadm.sinistre s,
	sysadm.gar_sin g
Where  ( s.id_prod between 35800 and 35807 Or s.id_prod between 80500 and 80503 
	or s.id_prod between 44500 and 44503 or s.id_prod in (48400,48401) )
	And g.id_sin=s.id_sin
	and    s.dte_decl between DATEADD ( month, -1, GETDATE()) and DATEADD ( day, -1, GETDATE())
Group by s.id_prod, g.id_gti,Case When s.marq_port='APPLE' Then 'APPLE' Else 'Hors Apple' End
Union all
Select s.id_prod,
		sysadm.FN_LIB_PROD(s.id_prod) as lib_produit,
		'Nombre de déclarations' as type_app,
	   Case When s.marq_port='APPLE' Then 'APPLE' Else 'Hors Apple' End as Marques,
	    'Sans période',
	   'Sans période',
	   '-' id_four,
	   sysadm.FN_CODE_NUM(g.id_gti,'-GA') 'lib_four',
       count(*)  'Demande_de_reparation_vers_le_fournisseur',
	   0 as 'Nbre_en_pdv' ,
       0 'Envoi_en_centralisation',
       0 'Appareil_recu',
       0 'Appareil_repare',
       0 'Demande_de_diagnostic_vers_le_fournisseur',
	   (select COUNT(*) from sysadm.sinistre s2 
		inner join sysadm.gar_sin g on g.id_sin=s2.id_sin
		where s2.id_prod=s.id_prod 
		and g.id_gti in (11,40,41)) as 'Nbre déclarations dommages acc.'

From   sysadm.sinistre s,
	sysadm.gar_sin g
Where  ( s.id_prod between 35800 and 35807 Or s.id_prod between 80500 and 80503 
	or s.id_prod between 44500 and 44503 or s.id_prod in (48400,48401) )
	And g.id_sin=s.id_sin
Group by s.id_prod, g.id_gti,Case When s.marq_port='APPLE' Then 'APPLE' Else 'Hors Apple' End
Go

grant execute on sysadm.PS_S_VDOC15840_M_URBAN to rolebddsinistres
Go



--------------------------------------------------------------------
--
-- Procédure            : 		PS_S_VDOC15840_M_URBAN_MAIL
-- Auteur               :       FPI
-- Date                 :       04/11/2014
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC15840]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC15840_M_URBAN_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC15840_M_URBAN_MAIL
GO

CREATE procedure sysadm.PS_S_VDOC15840_M_URBAN_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Extraction_vDoc15840_M_Urban\'
Set @sFileName	= 'VDOC15840_M_URBAN'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
		DB_NAME(db_id()) + '.sysadm.PS_S_VDOC15840_M_URBAN ' + 
		'" /o' + @sFicOut + ' -w5000' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = 'Extraction VDOC15840'
set @sMessage  = 'Veuillez trouver ci-joint l''extraction lié à la vDoc15840.'

if @iRetOsql <> 0
BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DES.'
END

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
--		'fpinon@spb.eu',
		'murban@spb.eu',
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL


Go

grant execute on sysadm.PS_S_VDOC15840_M_URBAN_MAIL to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            :       DW_S_PRESTA_AXA_NON_REGLE
-- Auteur               :       FPI
-- Date                 :       06/11/2014
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [PC13174]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_PRESTA_AXA_NON_REGLE' AND type = 'P' )
        DROP procedure sysadm.DW_S_PRESTA_AXA_NON_REGLE
GO

CREATE procedure sysadm.DW_S_PRESTA_AXA_NON_REGLE
AS

Select	p.cod_prod_dms as 'Produit',
		s.id_ets 'Etablissement',
		s.id_adh 'Dossier',
		s.id_sdos 'Sous dossier',
		sysadm.FN_CODE_NUM(pe.cod_civ,'-CI') 'Civilite',
		pe.nom 'Nom',
		pe.prenom 'Prénom',
		Convert ( varchar (10), s.dte_surv, 103 ) 'Date de survenance',
		isnull(i.rib_bq,'') 'Code Banque',
		isnull(i.rib_gui,'') 'Code Agence',
		isnull(i.rib_cpt,'') 'No compte',
		isnull(i.rib_cle,'') 'Cle'
From	sysadm.det_pro d
		inner join sysadm.sinistre s on s.id_prod=d.id_prod
		inner join sysadm.detail dt on dt.id_sin=s.id_sin
		inner join sysadm.produit p on s.id_prod=p.id_prod
		inner join sysadm.personne pe on s.id_ordre=pe.id_ordre
		inner join sysadm.inter i on i.id_sin=s.id_sin
Where   d.id_code_dp=264
	And i.cod_inter='A'
	And dt.id_evt=1419
	And dt.cod_etat <> 900
	And Not Exists ( 
		Select 1
		From sysadm.reglement r			
		Where   r.id_sin = s.id_sin
		And r.id_reg=dt.id_reg
		And		r.cod_mot_reg in ( 'RN' )
		)



Go
grant execute on sysadm.DW_S_PRESTA_AXA_NON_REGLE to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 		PS_S_VDOC16087_CQUERTIER
-- Auteur               :       JFF
-- Date                 :       01/12/2014
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC16087]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC16087_CQUERTIER' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC16087_CQUERTIER
GO

CREATE procedure sysadm.PS_S_VDOC16087_CQUERTIER
AS

SET NOCOUNT ON

Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @iMois Integer
Declare @iAnnee Integer
Declare @iJour Integer

Set @iMois = DATEPART ( month, GetDate() )
Set @iAnnee = DATEPART ( Year, GetDate() )
Set @iJour = 1

Set @dtDateFin = CONVERT( DateTime,
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iJour ), 2 ) + '/' +
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iMois ), 2 ) + '/' +
				 Right ( '0000' + CONVERT ( VarChar ( 4 ) , @iAnnee ), 4 ),
				 103 )

Set @dtDateFin = DATEADD ( DAY, -1, @dtDateFin ) 

Set @iMois = DATEPART ( month, @dtDateFin )
Set @iAnnee = DATEPART ( Year, @dtDateFin )

Set @dtDateDeb = CONVERT( DateTime,
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iJour ), 2 ) + '/' +
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iMois ), 2 ) + '/' +
				 Right ( '0000' + CONVERT ( VarChar ( 4 ) , @iAnnee ), 4 ) ,
				 103 )
	 

Select	sysadm.FN_AFF_DATE ( @dtDateDeb, 'SANS_HEURE' ) 'periode_deb_dte_fin_trt',
	    sysadm.FN_AFF_DATE ( @dtDateFin, 'SANS_HEURE' ) 'periode_fin_dte_fin_trt',
		s.id_prod,
		sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_prod',
		s.id_sin,
		( Select nom from sysadm.personne p where p.id_ordre = s.id_ordre ) 'Nom',
		( Select prenom from sysadm.personne p where p.id_ordre = s.id_ordre ) 'Prenom',
		sysadm.FN_CODE_NUM ( c.id_gti, '-GA') 'lib_garantie',
		sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', c.info_spb_frn_cplt, ';') 'typ_app_pret',
		c.id_serie_nouv 'IMEI_App_prêt',
		isNull ( ( Select ds2.val_mt From sysadm.div_sin ds2 Where ds2.id_sin = s.id_sin And ds2.nom_zone = 'mt_debit_caution_paybox' ), 0 ) 'Montant',
		sysadm.FN_CLE_VAL ( 'DTE_RESTIT_APP_PRET', c.info_frn_spb_cplt, ';') 'dte_restit_prêt',
		Case ds1.val_car 
			When 'RECRED' Then 'Recrédit'
			When 'DEBTOT' Then 'Débit'			
		End 'Etat_Caution', 
		( Select sysadm.FN_AFF_DATE (ds2.val_dte, 'AVEC_HEURE') From sysadm.div_sin ds2 Where ds2.id_sin = s.id_sin And ds2.nom_zone = 'dte_debit_caution_paybox' ) 'dte_débit',		
		( Select sysadm.FN_AFF_DATE (ds2.val_dte, 'AVEC_HEURE') From sysadm.div_sin ds2 Where ds2.id_sin = s.id_sin And ds2.nom_zone = 'dte_recredit_caution_paybox' ) 'dte_crédit',
		( sysadm.FN_CLE_VAL ( 'ETAT_APP_PRET', rtrim( c.info_frn_spb_cplt ), ';' ) ) 'état_app_prêt',
		( sysadm.FN_CLE_VAL ( 'REC_CONF', rtrim( c.info_frn_spb_cplt ), ';' ) ) 'récrédit_manuel_DSA_sur_ITSM'
		 
From   det_pro d,
	   sinistre s,
	   div_sin ds,
	   div_sin ds1,
	   commande c
	   
Where  d.id_code_dp = 239
And    s.id_prod = d.id_prod
And	   ds.id_sin = s.id_sin
And    ds.nom_zone = 'num_trans_paybox_1'
And	   ds.val_car is not null
And	   DATALENGTH ( ds.val_car ) > 0 
And	   ds1.id_sin = s.id_sin
And    ds1.nom_zone = 'etat_caution_paybox'
And	   ds1.val_car in ( 'RECRED', 'DEBTOT' )
And	   c.id_sin = s.id_sin
And    c.id_typ_art = 'PST'
And	   sysadm.FN_CLE_VAL ( 'TYP_RELAI', c.info_spb_frn_cplt, ';')  = 'PRET'
And    Exists ( 
			Select Top 1 1
			From sysadm.div_sin ds2
			Where ds2.id_sin = s.id_sin
			And ds2.nom_zone in (  'dte_debit_caution_paybox', 'dte_recredit_caution_paybox' )
			And ds2.val_dte between @dtDateDeb And @dtDateFin
		)

Go


--------------------------------------------------------------------
--
-- Procédure            : 		PS_S_VDOC16087_CQUERTIER_FIC
-- Auteur               :       FPI
-- Date                 :       04/11/2014
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC15840]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC16087_CQUERTIER_FIC' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC16087_CQUERTIER_FIC
GO

CREATE procedure sysadm.PS_S_VDOC16087_CQUERTIER_FIC
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
-- Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+ 'SIMPA2\Extraction_vDoc16087_C_QUERTIER\'
Set @sPath 	= '\\F4T\SIMPA2\O2M\Extraction_vDoc16087_C_QUERTIER\'
Set @sFileName	= 'VDOC16087_C_QUERTIER' + convert( varchar ( 10), GETDATE(), 112 ) + replace ( convert( varchar ( 10), GETDATE(), 108 ) , ':', '' ) 
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
		DB_NAME(db_id()) + '.sysadm.PS_S_VDOC16087_CQUERTIER ' + 
		'" /o' + @sFicOut + ' -w5000' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output
Select @sCommande
Select @iRetOsql 

Go


grant execute on sysadm.PS_S_VDOC16087_CQUERTIER_FIC to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procédure            : 		DW_S_DOSSIER_ORANGE_ENT
-- Auteur               :       FPI
-- Date                 :       04/11/2014
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC16172] - [VDOC16294] - [VDOC23418]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_DOSSIER_ORANGE_ENT' AND type = 'P' )
       DROP procedure sysadm.DW_S_DOSSIER_ORANGE_ENT
GO

CREATE procedure sysadm.DW_S_DOSSIER_ORANGE_ENT
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

SET NOCOUNT ON
	
select s.id_prod 'CODE PRODUIT', 
	sysadm.FN_LIB_PROD(s.id_prod) 'LIBELLE PRODUIT',
	p.nom 'NOM OU RAISON SOCIALE',
	p.prenom 'PRENOM',
	s.id_sin 'N° DE DOSSIER SIMPA',
	CONVERT(varchar(10), s.dte_decl,103) 'DATE DE DECLARATION DU SINISTRE',
	CONVERT(varchar(10), s.dte_surv,103) 'DATE DU SINISTRE',
	sysadm.FN_CODE_NUM(g.id_gti,'-GA') 'GARANTIE',
	sysadm.FN_LIB_POLICE(s.id_sin) 'POLICE'
from sysadm.sinistre s
inner join  sysadm.personne p on p.id_ordre=s.id_ordre
inner join sysadm.gar_sin g on g.id_sin=s.id_sin
where (s.id_prod between 9612 and 9628
or s.id_prod between 96200 and 96299
or s.id_prod between 32700 and 32702)
and  s.cree_le between @dtDteDeb And @dtDteFin

Go

grant execute on sysadm.DW_S_DOSSIER_ORANGE_ENT to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 		PS_S_VDOC16294_CQUERTIER_FIC
-- Auteur               :       FPI
-- Date                 :       04/11/2014
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC16294]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC16294_CQUERTIER_FIC' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC16294_CQUERTIER_FIC
GO

CREATE procedure sysadm.PS_S_VDOC16294_CQUERTIER_FIC
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

	SET NOCOUNT ON

Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @iMois Integer
Declare @iAnnee Integer

Set @iMois = DATEPART ( month, GetDate() )
Set @iAnnee = DATEPART ( Year, GetDate() )

Set @dtDateFin = CONVERT( DateTime,
				 '01/' +
				 Right ( '00' + CONVERT ( VarChar ( 2 ) , @iMois ), 2 ) + '/' +
				 Right ( '0000' + CONVERT ( VarChar ( 4 ) , @iAnnee ), 4 ),
				 103 )


Set @dtDateDeb = DATEADD(month,-1,@dtDateFin)
				 
-- chemin d'enregistrement du Result Set
Set @sPath 	= '\\F4T\SIMPA2\O2M\Extraction_vDoc16294_Orange_Ent\'
Set @sFileName	= 'Orange_Entreprise' + convert( varchar ( 10), GETDATE(), 112 ) + replace ( convert( varchar ( 10), GETDATE(), 108 ) , ':', '' ) 
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
		DB_NAME(db_id()) + '.sysadm.DW_S_DOSSIER_ORANGE_ENT ' + 
		'''' + convert(varchar(10), @dtDateDeb, 103) + ''',''' + convert(varchar(10), @dtDateFin, 103) + '''' +
		'" /o' + @sFicOut + ' -w5000' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Select @iRetOsql 

Go

grant execute on sysadm.PS_S_VDOC16294_CQUERTIER_FIC to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 		PS_S_VDOC16155_SKRIZEZ
-- Auteur               :       JFF
-- Date                 :       08/01/2015
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC16155]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- JFF	20/03/2015	[VDOC16551]
-- JFF	11/03/2015	[VDOC20254]
-- JFF	29/08/2016	[VDOC21698]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC16155_SKRIZEZ' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC16155_SKRIZEZ
GO

CREATE procedure sysadm.PS_S_VDOC16155_SKRIZEZ
	@asIdFour	VarChar  ( 10 )
AS

Select distinct
	   c.id_sin 'Numéro dossier',
	   c.id_seq, 'Numéro séquence presta', -- [VDOC20254]
	   sysadm.FN_AFF_DATE ( s.cree_le, 'SANS_HEURE' ) 'Date de création du dossier', 
	   s.id_prod 'Code produit SPB',
	   sysadm.FN_LIB_PROD ( s.id_prod ) 'Libellé Produit SPB',
	   c.mt_ttc_cmde 'Montant TTC de prise en charge SPB',
	   sysadm.FN_CLE_VAL ( 'MAJOR_CONTRACTUELLE_EUROS', RTRIM ( c.info_spb_frn_cplt ), ';' ) 'Majoration contractuelle TTC estimée',
	   Case -- [VDOC16551]
			When s.id_prod in ( 23723, 23724, 23735, 23736 ) Then
				d.mt_val_publique

			-- [VDOC21698]
			When s.id_prod between 87900 and 87923 and s.id_rev = 0 Then
			   ( Select p.mt_plaf
				 From sysadm.plafond p
				 Where p.id_prod = s.id_prod
				 And   p.id_rev = s.id_rev
				 And   p.id_gti = c.id_gti
				 And   p.id_niv_plaf = '-GA'
				 And   p.id_typ_plaf = 680
			   )

			-- [VDOC21698]
			When s.id_prod between 87900 and 87923 and s.id_rev >= 1 Then
			   ( Select p.mt_plaf
				 From sysadm.plafond p
				 Where p.id_prod = s.id_prod
				 And   p.id_rev = s.id_rev
				 And   p.id_gti = c.id_gti
				 And   p.id_niv_plaf = '-GA'
				 And   p.id_typ_plaf = 736
			   )

			Else -- 23723, 23724, 23735 et 23736 
			   ( Select p.mt_plaf
				 From sysadm.plafond p
				 Where p.id_prod = s.id_prod
				 And   p.id_rev = s.id_rev
				 And   p.id_gti = c.id_gti
				 And   p.id_niv_plaf = '-GA'
				 And   p.id_typ_plaf = 680
			   )
	   End  'Plafond de garantie SPB TTC',
	   '' 'Montant TTC du bien de remplacement',
	   '' 'Commission TTC calculée sur le bien de remplacement'
From   sysadm.commande c,
	   sysadm.sinistre s,
	   sysadm.det_pro dp,
	   sysadm.detail d,
	   sysadm.gar_sin g
Where  dp.id_code_dp = 94
And	   sysadm.FN_CLE_VAL ( 'COD_DW', rtrim( dp.val_car), ';' ) = 'VDOC16155'
And	   s.id_prod = dp.id_prod
And	   c.id_sin = s.id_sin
And    c.id_four = @asIdFour
And	   c.cod_etat <> 'ANN'
And    d.id_sin = c.id_sin
And    d.id_gti = c.id_gti
And    d.id_detail = c.id_detail
And    d.cod_etat <> 600
And    g.id_sin = d.id_sin
And    g.id_gti = d.id_gti
And	   g.cod_etat <> 900
And    s.cree_le >= Convert ( Datetime, '21/05/2014', 103 )
And    c.mt_ttc_cmde = 
			( Select MAX (c1.mt_ttc_cmde )
			  From   sysadm.commande c1
			  Where  c1.id_sin = c.id_sin
			  And    c1.id_gti = c.id_gti
			  And    c1.id_detail = c.id_detail 
			 )
And	   Not Exists ( 			 
		  Select 1
		  From	 sysadm.reglement r,
				 sysadm.reg_gti rg
		  Where  r.id_sin = c.id_sin
		  And	 r.cod_inter = 'A'
		  And	 r.cod_mot_reg = 'RN'
		  And	 rg.id_sin = r.id_sin
		  And    rg.id_reg = r.id_reg
		  And	 rg.id_gti = c.id_gti
	  )

Go

--------------------------------------------------------------------
--
-- Procédure            : 		PS_S_VDOC19871_SKRIZEZ
-- Auteur               :       JFF
-- Date                 :       05/02/2016
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC19871]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- JFF	20/03/2015	[VDOC16551]
-- JFF  11/03/2016  [VDOC20254]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC19871_SKRIZEZ' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC19871_SKRIZEZ
GO

CREATE procedure sysadm.PS_S_VDOC19871_SKRIZEZ
	@asIdFour	VarChar  ( 10 )
AS

Select distinct
	   c.id_sin 'Numéro dossier',
	   c.id_seq, 'Numéro séquence presta', -- [VDOC20254]
	   sysadm.FN_AFF_DATE ( s.cree_le, 'SANS_HEURE' ) 'Date de création du dossier', 
	   s.id_prod 'Code produit SPB',
	   sysadm.FN_LIB_PROD ( s.id_prod ) 'Libellé Produit SPB',
	   c.mt_ttc_cmde 'Montant TTC de prise en charge SPB',
	   Case -- [VDOC16551]
			When s.id_prod in ( 23723, 23724, 23735, 23736 ) Then
				d.mt_val_publique
			Else -- 23723, 23724, 23735 et 23736 
			   ( Select p.mt_plaf
				 From sysadm.plafond p
				 Where p.id_prod = s.id_prod
				 And   p.id_rev = s.id_rev
				 And   p.id_gti = c.id_gti
				 And   p.id_niv_plaf = '-GA'
				 And   p.id_typ_plaf = 680
			   )
	   End  'Plafond de garantie SPB TTC',
	   '' 'Montant TTC du bien de remplacement'
From   sysadm.commande c,
	   sysadm.sinistre s,
	   sysadm.det_pro dp,
	   sysadm.detail d,
	   sysadm.gar_sin g
Where  dp.id_code_dp = 94
And	   sysadm.FN_CLE_VAL ( 'COD_DW', rtrim( dp.val_car), ';' ) = 'VDOC19871'
And	   s.id_prod = dp.id_prod
And	   c.id_sin = s.id_sin
And    c.id_four = @asIdFour
And	   c.cod_etat <> 'ANN'
And    d.id_sin = c.id_sin
And    d.id_gti = c.id_gti
And    d.id_detail = c.id_detail
And    d.cod_etat <> 600
And    g.id_sin = d.id_sin
And    g.id_gti = d.id_gti
And	   g.cod_etat <> 900
And    s.cree_le >= Convert ( Datetime, '21/05/2014', 103 )
And    c.mt_ttc_cmde = 
			( Select MAX (c1.mt_ttc_cmde )
			  From   sysadm.commande c1
			  Where  c1.id_sin = c.id_sin
			  And    c1.id_gti = c.id_gti
			  And    c1.id_detail = c.id_detail 
			 )
And	   Not Exists ( 			 
		  Select 1
		  From	 sysadm.reglement r,
				 sysadm.reg_gti rg
		  Where  r.id_sin = c.id_sin
		  And	 r.cod_inter = 'A'
		  And	 r.cod_mot_reg = 'RN'
		  And	 rg.id_sin = r.id_sin
		  And    rg.id_reg = r.id_reg
		  And	 rg.id_gti = c.id_gti
	  )

Go


--------------------------------------------------------------------
--
-- Procédure            : 		PS_S_VDOC16155_SKRIZEZ_FIC
-- Auteur               :       JFF
-- Date                 :       08/01/2015
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC16155]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- JFF  05/02/2016  [VDOC19871] ATC
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC16155_SKRIZEZ_FIC' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC16155_SKRIZEZ_FIC
GO

CREATE procedure sysadm.PS_S_VDOC16155_SKRIZEZ_FIC
AS

DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int,
	@iCpt int,
	@sIdFour VarChar ( 10 ),
	@iCptTour Integer

	SET NOCOUNT ON

Set @iCptTour =1

While @iCptTour <= 2				 
 Begin
	-- chemin d'enregistrement du Result Set
	If @iCptTour = 1 
	  Begin
		Set @sPath 	= '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_vDoc16155_SKRIZEZ\'
		Set @sFileName	= 'Extraction_VDOC16155_' + convert( varchar ( 10), GETDATE(), 112 ) + replace ( convert( varchar ( 10), GETDATE(), 108 ) , ':', '' ) 
		Set @sFileExt	= 'xls'
	  End

	If @iCptTour = 2
	  Begin
		Set @sPath 	= '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_vDoc19871_SKRIZEZ\'
		Set @sFileName	= 'Extraction_VDOC19871_' + convert( varchar ( 10), GETDATE(), 112 ) + replace ( convert( varchar ( 10), GETDATE(), 108 ) , ':', '' ) 
		Set @sFileExt	= 'xls'
	  End


	SET @sNomServeur = @@servername
	-- Options additionelles pour osql
	-- /s"	" 	=> Separateur Tabulation
	-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
	-- /u	=> Unicode

	Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

	Set @iCpt = 1

	-- [VDOC19871]
	While @iCpt <= 3
	 Begin

		Select @sIdFour = Case @iCpt 
							When 1 Then 'MBS'
							When 2 Then 'CVC'
							When 3 Then 'ATC' -- [VDOC19871]
						  End 

		SET @sFicOut = @sPath + @sFileName + '_' + @sIdFour + '.' + @sFileExt	 

		If @iCptTour = 1 
 		 Begin
			SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
					DB_NAME(db_id()) + '.sysadm.PS_S_VDOC16155_SKRIZEZ ''' + @sIdFour + '''' + 
					'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
		 End

		If @iCptTour = 2
 		 Begin
			SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
					DB_NAME(db_id()) + '.sysadm.PS_S_VDOC19871_SKRIZEZ ''' + @sIdFour + '''' + 
					'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
		 End


		EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

		Set @iCpt = @iCpt + 1


	End 

	Set @iCptTour = @iCptTour + 1 

 End 
Go

grant execute on sysadm.PS_S_VDOC16155_SKRIZEZ_FIC to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            : 		PS_S_VDOC16171_HLIEGEARD
-- Auteur               :       JFF
-- Date                 :       23/01/2015
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC16171]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- JFF      13/07/2015   [PC151270_ORANGE_V3]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC16171_HLIEGEARD' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC16171_HLIEGEARD
GO

CREATE procedure sysadm.PS_S_VDOC16171_HLIEGEARD
AS

Declare @dtDeb Datetime
Declare @dtFin Datetime

Set @dtDeb = DATEADD ( month, -1, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
Set @dtFin = DATEADD ( day, -1, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) + ' 23:59' )

-- Select @dtDeb , @dtFin

Select	s.id_sin,
		s.id_prod,
		sysadm.FN_LIB_PROD ( s.id_prod) 'lib_prod',
		sysadm.FN_AFF_DATE ( s.dte_decl, 'SANS_HEURE') dte_decl, 
		sysadm.FN_AFF_DATE ( s.dte_surv, 'SANS_HEURE') dte_surv, 
		c.id_gti,
		sysadm.FN_CODE_NUM ( c.id_gti, '-GA' ) lib_gti,
		c.id_ref_four,
		sysadm.FN_AFF_DATE ( c.cree_le, 'SANS_HEURE' ) cree_le,
		sysadm.FN_AFF_DATE ( c.dte_env_cli, 'SANS_HEURE' ) 'dte_fin_trt',
		sysadm.FN_CODE_NUM ( c.status_gc, '-GC' ) status_gc,
		c.comment_frn

From   sysadm.sinistre s,
	   sysadm.det_pro dp,
	   sysadm.commande c
	   
where  dp.id_code_dp = 94
and    sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( val_car ), ';' ) in ( 'ORANGE_V3', 'ORANGE_V3BIS', 'ORANGE_V3TER' )  -- [PC151270_ORANGE_V3]
and	   s.id_prod = dp.id_prod
and    c.id_sin = s.id_sin
and	   c.id_four = 'PSM'
And    c.cree_le between @dtDeb and @dtFin

Go
grant execute on sysadm.PS_S_VDOC16171_HLIEGEARD to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            : 		PS_S_VDOC16171_HLIEGEARD_FIC
-- Auteur               :       JFF
-- Date                 :       23/01/2015
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC16171]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC16171_HLIEGEARD_FIC' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC16171_HLIEGEARD_FIC
GO

CREATE procedure sysadm.PS_S_VDOC16171_HLIEGEARD_FIC
AS

DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

	SET NOCOUNT ON

				 
-- chemin d'enregistrement du Result Set
Set @sPath 	= '\\F4T\SIMPA2\O2M\traites_PSM\'
Set @sFileName	= 'TRAITE_PSM_' + convert( varchar ( 10), GETDATE(), 112 ) + replace ( convert( varchar ( 10), GETDATE(), 108 ) , ':', '' ) 
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
		DB_NAME(db_id()) + '.sysadm.PS_S_VDOC16171_HLIEGEARD ' + 
		'" /o' + @sFicOut + ' -w5000' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Select @sCommande
Select @iRetOsql 

Go

grant execute on sysadm.PS_S_VDOC16171_HLIEGEARD_FIC to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 		DW_S_VDOC16751_COMMANDES_LBE
-- Auteur               :       FPI
-- Date                 :       05/02/2015
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC16751]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_VDOC16751_COMMANDES_LBE' AND type = 'P' )
       DROP procedure sysadm.DW_S_VDOC16751_COMMANDES_LBE
GO

CREATE procedure sysadm.DW_S_VDOC16751_COMMANDES_LBE
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

select id_prod, 
	sysadm.FN_LIB_PROD(id_prod) as lib_produit,
	s.id_sin, 
	CONVERT(varchar(7),s.id_sin) + '-' + CONVERT(varchar(2),id_seq) as ref_commande,
	convert(varchar(10),cmd_gen_le,103) as date_commande,
	isnull(i.adr_mail,'') as adresse_mail
from sysadm.commande c
	inner join sysadm.sinistre s on s.id_sin=c.id_sin
	inner join sysadm.inter i on i.id_sin=s.id_sin and i.cod_inter='A'
where c.cmd_gen_le between @dtDteDeb  and @dtDteFin
	and c.id_four='LBE'
Go

grant execute on sysadm.DW_S_VDOC16751_COMMANDES_LBE to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            : 		DW_S_VDOC16724_RM_A_CHARGE
-- Auteur               :       FPI
-- Date                 :       27/02/2015
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC16724]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
--		14/09/2015	FPI	[ITSM323507]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_VDOC16724_RM_A_CHARGE' AND type = 'P' )
       DROP procedure sysadm.DW_S_VDOC16724_RM_A_CHARGE
GO

CREATE procedure sysadm.DW_S_VDOC16724_RM_A_CHARGE
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

	select s.id_prod,
		sysadm.FN_LIB_PROD(s.id_prod) as lib_produit,
		sysadm.FN_LIB_CIE(s.id_sin) as assureur,
		s.id_sin,
		r.mt_tot_reg,
		r.lib_reg,
		r.maj_par,
		CONVERT(varchar(10),r.cree_le,103) as cree_le
	from sysadm.sinistre s
		inner join sysadm.reglement r on s.id_sin=r.id_sin
	where r.cree_le between @dtDteDeb  and @dtDteFin
		and r.cod_mot_reg='RM'
		and r.lib_reg like '%CHARGE%'
		and r.cod_mode_reg='C'
Go

grant execute on sysadm.DW_S_VDOC16724_RM_A_CHARGE to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 		PS_S_VDOC17117_IFR_PSM
-- Auteur               :       FPI
-- Date                 :       31/03/2015
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC17117]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
--	FPI	26/06/2015	[VDoc18015] Ajout du prix
--  FPI 12/04/2016  Ajout du Where
--  JFF 04/01/2018  [VDOC25442]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC17117_IFR_PSM' AND type = 'P' )
       DROP procedure sysadm.PS_S_VDOC17117_IFR_PSM
GO

CREATE procedure sysadm.PS_S_VDOC17117_IFR_PSM
AS

SET NOCOUNT ON

select rtrim(ltrim(marque)) 'Marque', 
	rtrim(ltrim(reference)) 'Référence', 
	frequence 'Prix (frequence)',
	isnull(convert(varchar(10),maj_le,103),'') 'Maj Le',
	rtrim(ltrim(sku_saga)) 'SKU',
	-- [VDOC25442]
	IsNull (
		( Select Top 1 cf.categorie
		  From   sysadm.ctg_factu cf
		  Where  cf.marq_app = i.marque
		  And    cf.modl_app = i.reference )
		, 'Non catégorisé') 'Catégorie_Facturation'
	-- /[VDOC25442]

from sysadm.ifr i
Where   i.id_trait = ( Select MAX (id_trait)
					   From   sysadm.ifr i2
					   Where  i2.marque = i.marque
					   And    i2.reference = i.reference )
And	i.alt_dispo = 'O'		
order by maj_le

Go

grant execute on sysadm.PS_S_VDOC17117_IFR_PSM to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 		PS_S_VDOC17117_IFR_PSM_MAIL
-- Auteur               :       FPI
-- Date                 :       31/03/2015
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC17117]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
--  FPI 12/04/2016  Correction écrasement de fichier
--  JFF 02/01/2017  Ajout FCOMPAORE@spb-services.eu
--  JFF 12/02/2020  Demande de Stéphanie Delesque de mettre .COM ald .FR sur les adresses PSM.
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VDOC17117_IFR_PSM_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S_VDOC17117_IFR_PSM_MAIL
GO

CREATE procedure sysadm.PS_S_VDOC17117_IFR_PSM_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
		@sdtTrt      Varchar(10),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
SET @sdtTrt             = CONVERT(VARCHAR(10), getdate(), 112)
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Extraction_VDoc17117_PSM\'
Set @sFileName	= 'VDoc17117_IFR_' + @sdtTrt
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
		DB_NAME(db_id()) + '.sysadm.PS_S_VDOC17117_IFR_PSM ' + 
		'" /o' + @sFicOut + ' -W -w5000 ' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = 'Extraction IFR'
set @sMessage  = 'Ci-joint l''extraction hebdomadaire de la base IFR.'

if @iRetOsql <> 0
BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter DEI.'
END

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		--'fpinon@spb.eu',
		'arthur.girerd@allopsm.com,charles.bocquillon@allopsm.com,SLOISON@spb.eu,didier.tuil@allopsm.com,jean-yves.jouan@allopsm.com,victor.fauvel@allopsm.com,romain.formery@allopsm.com,CMALLE@spb.eu,logistique@allopsm.com,WBENMILED@spb-services.eu',
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL


Go

grant execute on sysadm.PS_S_VDOC17117_IFR_PSM_MAIL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_CTL_BGE_FNAC
-- Auteur               :       FPI
-- Date                 :       03/06/2015
-- Libelle              :        
-- Commentaires         :       
-- References           :		[PM292-1]
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      12/05/2020   [PI085]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CTL_BGE_FNAC' AND type = 'P' )
        DROP procedure sysadm.PS_CTL_BGE_FNAC
GO

CREATE procedure sysadm.PS_CTL_BGE_FNAC
AS

SET NOCOUNT ON

Declare @dtPivot datetime

Set @dtPivot=dateadd(ww, datediff(ww, 0, GETDATE()), -7) -- Le lundi de la semaine précédente

-- Correspondance produit / codes courriers BGE possibles
Declare @tbBGE TABLE (id_prod decimal(7,0), id_cour varchar(50), isOk int)

insert into @tbBGE
select id_prod,sysadm.FN_CLE_VAL('ID_COUR_BGE',val_car,';'), 0
from sysadm.det_pro 
where (id_prod between 29800 and 29899
or id_prod between 31300 and 31399
or id_prod between 37600 and 37699
or id_prod between 41400 and 41499
or id_prod between 41900 and 41999
or id_prod between 45400 and 45499)
and id_code_dp=126

While Exists (select top 1 id_prod from  @tbBGE where isOk=0)
Begin
	update @tbBGE set isOk=1
	Where CHARINDEX('/',id_cour) =0

	Insert into @tbBGE
	select id_prod, SUBSTRING(id_cour,1,CHARINDEX('/',id_cour) -1),-1
	from @tbBGE
	where isOk=0
	
	Insert into @tbBGE
	select id_prod, SUBSTRING(id_cour,CHARINDEX('/',id_cour) + 1,255),-1
	from @tbBGE
	where isOk=0
	
	Delete from @tbBGE
	where isOk=0
	
	update @tbBGE set isOk=0 where isOk=-1
End

-- Tableau de résultat
Declare @tbResult TABLE (date_action datetime,
	id_oper varchar(4),
	id_sin decimal(10,0),  -- [PI062]
	id_cli int,
	id_adh varchar(35),
	garantie varchar(35),
	mt_commande varchar(255),
	iCas int,
	sData varchar(255))

/*
Si un sinistre a été classé SANS SUITE et qu’un nouveau sinistre a été ouvert par la suite sur la même adhésion
*/ 
insert into @tbResult
(date_action, id_oper, id_sin, iCas, sData)
select s.cree_le, s.maj_par, s.id_sin,1,
	'dte_sans_suite=' + CONVERT(varchar(10),s2.valide_le,103) + ' - id_sin_ss=' + CONVERT(varchar(10), s2.id_sin)  -- [PI062]
 from sysadm.sinistre s
	inner join produit p on s.id_prod=p.id_prod
	inner join produit pliste on p.cod_prod_dms=pliste.cod_prod_dms
	inner join sysadm.sinistre s2 on s2.id_prod=pliste.id_prod and s.id_adh=s2.id_adh and s.id_ets=s2.id_ets 
where (s.id_prod between 29800 and 29899
or s.id_prod between 31300 and 31399
or s.id_prod between 37600 and 37699
or s.id_prod between 41400 and 41499
or s.id_prod between 41900 and 41999
or s.id_prod between 45400 and 45499)
and s.cree_le > @dtPivot
and s.id_sin <> s2.id_sin
and s2.cod_etat=900
and s2.valide_le < s.cree_le

/*
Si 2 BGE ont été édité sur un même sinistre
*/
insert into @tbResult
(date_action, id_oper, id_sin, iCas, sData)
select a.cree_le, a.maj_par, a.id_sin,2,
	'dte_BGE1=' + CONVERT(varchar(10),a2.cree_le,103) + ' - dte_BGE2=' + CONVERT(varchar(10),a.cree_le,103)
from @tbBGE t 
	left outer join @tbBGE t2 on t.id_prod=t2.id_prod and t.id_cour <> t2.id_cour
	inner join archive a on a.id_prod=t.id_prod and a.id_cour_orig=t.id_cour
	inner join archive a2 on a2.id_sin=a.id_sin and (a2.id_cour_orig=t.id_cour or a2.id_cour_orig=t2.id_cour)
where a.dte_edit > @dtPivot
and a.id_doc <> a2.id_doc
and a.dte_edit > a2.dte_edit


/*
Si 2 BGE ont été édité sur un même client
*/

If @@servername = master.dbo.SPB_FN_ServerName ('PRO') 
Begin
	insert into @tbResult
	(date_action, id_oper, id_sin, iCas, id_cli, sData)
	select a.cree_le, a.maj_par, a.id_sin, 3, s2.id_cli,
		'dte_BGE1=' + CONVERT(varchar(10),a2.cree_le,103) 
		+ ' - id_sin1=' + CONVERT(varchar(10),a.id_sin)  -- [PI062]
		+ ' / dte_BGE2=' + CONVERT(varchar(10),a.cree_le,103) 
		+ ' - id_sin2=' + CONVERT(varchar(10),a2.id_sin) -- [PI062]
	from @tbBGE t 
		left outer join @tbBGE t2 on t.id_prod=t2.id_prod and t.id_cour <> t2.id_cour
		inner join archive a on a.id_prod=t.id_prod and a.id_cour_orig=t.id_cour
		inner join SHERPA_PRO.sysadm.sinistre s on s.id_sin=a.id_sin
		inner join SHERPA_PRO.sysadm.sinistre s2 on s2.id_cli=s.id_cli and s.id_sin <> s2.id_sin 
		inner join archive a2 on a2.id_sin=s2.id_sin 
			and ((a2.id_cour_orig=t.id_cour and a2.id_prod=t.id_prod)
				or 
				 (a2.id_cour_orig=t2.id_cour and a2.id_prod=t2.id_prod))
	where a.dte_edit > @dtPivot
	and a.id_doc <> a2.id_doc
	and a.dte_edit > a2.dte_edit
End
Else
Begin
	insert into @tbResult
	(date_action, id_oper, id_sin, iCas, id_cli, sData)
	select a.cree_le, a.maj_par, a.id_sin, 3, s2.id_cli,
		'dte_BGE1=' + CONVERT(varchar(10),a2.cree_le,103) 
		+ ' - id_sin1=' + CONVERT(varchar(10),a.id_sin)  -- [PI062]
		+ ' / dte_BGE2=' + CONVERT(varchar(10),a.cree_le,103) 
		+ ' - id_sin2=' + CONVERT(varchar(10),a2.id_sin)  -- [PI062]
	from @tbBGE t 
		left outer join @tbBGE t2 on t.id_prod=t2.id_prod and t.id_cour <> t2.id_cour
		inner join archive a on a.id_prod=t.id_prod and a.id_cour_orig=t.id_cour
		inner join SHERPA_SIM.sysadm.sinistre s on s.id_sin=a.id_sin
		inner join SHERPA_SIM.sysadm.sinistre s2 on s2.id_cli=s.id_cli and s.id_sin <> s2.id_sin 
		inner join archive a2 on a2.id_sin=s2.id_sin 
			and ((a2.id_cour_orig=t.id_cour and a2.id_prod=t.id_prod)
				or 
				 (a2.id_cour_orig=t2.id_cour and a2.id_prod=t2.id_prod))
	where a.dte_edit > @dtPivot
	and a.id_doc <> a2.id_doc
	and a.dte_edit > a2.dte_edit
End
/*
Si un BGE a été annulé
*/
insert into @tbResult
(date_action, id_oper, id_sin, iCas, sData)
select c.maj_le, c.maj_par, c.id_sin, 4, 'commande=' + CONVERT(varchar(10),c.id_sin)  -- [PI062]
	+ '-' + CONVERT(varchar(2),c.id_seq)
from sysadm.commande c
where c.id_four='FNC'
and c.id_typ_art='CAF'
and c.cod_etat='ANN'
and c.cree_le > @dtPivot

/*
Si un BGE est édité deux mois (ou plus) après le flux de retour de diagnostic
*/
insert into @tbResult
(date_action, id_oper, id_sin, iCas, sData)
select a.cree_le, a.maj_par, a.id_sin,5,
	'dte_retour_diag=' + CONVERT(varchar(10),c.dte_env_cli,103)  
	+ ' - date_bge=' + CONVERT(varchar(10),a.dte_edit,103)
from @tbBGE t 
	inner join archive a on a.id_prod=t.id_prod and a.id_cour_orig=t.id_cour
	inner join commande c on a.id_sin=c.id_sin
where a.dte_edit > @dtPivot
and c.id_ref_four='A_DIAGNOSTIQUER' 
and c.dte_env_cli <= DATEADD(MONTH,-2,a.dte_edit)

-- Remplissage des colonnes id_cli / id_adh
If @@servername = master.dbo.SPB_FN_ServerName ('PRO') 
Begin
	update @tbResult
	set id_cli=sin_sherpa.id_cli,
--		id_adh=CONVERT(varchar(3), p.cod_prod_dms) 
		id_adh=CONVERT(varchar(5), p.cod_prod_dms) -- [PI085]
			+ '-' + CONVERT(varchar(5),sin_sherpa.id_ets)
			+ '-' + sin_sherpa.id_adh 
			+ '-' + CONVERT(varchar(2),sin_sherpa.id_sdos)
	from @tbResult t
		inner join SHERPA_PRO.sysadm.sinistre sin_sherpa on sin_sherpa.id_sin=t.id_sin and sin_sherpa.id_appli=2
		inner join sysadm.produit p on p.id_prod=sin_sherpa.id_prod_sin
End 
Else
Begin
	update @tbResult
	set id_cli=sin_sherpa.id_cli,
--		id_adh=CONVERT(varchar(3), p.cod_prod_dms) 
		id_adh=CONVERT(varchar(5), p.cod_prod_dms) -- [PI085]
			+ '-' + CONVERT(varchar(5),sin_sherpa.id_ets)
			+ '-' + sin_sherpa.id_adh 
			+ '-' + CONVERT(varchar(2),sin_sherpa.id_sdos)
	from @tbResult t
		inner join SHERPA_SIM.sysadm.sinistre sin_sherpa on sin_sherpa.id_sin=t.id_sin and sin_sherpa.id_appli=2
		inner join sysadm.produit p on p.id_prod=sin_sherpa.id_prod_sin
End

-- Maj garantie - mt_commande
update @tbResult 
set garantie=(select top 1 sysadm.FN_CODE_NUM(id_gti,'-GA') 
		from sysadm.gar_sin g
		where g.id_sin=t.id_sin),
	mt_commande=(select 'Commande ' + Case When cod_etat='ANN' Then '(Annulée) ' Else ' ' End ,
			id_seq, mt_ttc_cmde
			from sysadm.commande c
		where c.id_sin=t.id_sin
			and id_four='FNC'
		for xml path(''))		
from @tbResult t

update @tbResult 
set mt_commande=Replace(
	Replace(
		Replace(mt_commande,'</id_seq><mt_ttc_cmde>',' : '),
		'</mt_ttc_cmde>',' / '),
	'<id_seq>','-')
from @tbResult t

update @tbResult 
set mt_commande=Left(mt_commande,Len(mt_commande) - 2)
from @tbResult t
where mt_commande is not null

-- Résultat
select convert(varchar(10),date_action, 103) as date_action,
	id_oper as trigramme_agent, 
	id_sin as no_dossier,
	id_cli as no_client,
	id_adh as no_adhesion,
	garantie as garantie,
	mt_commande as 'Commandes FNAC dans Simpa2',
	sData as 'Classé SANS SUITE + nouveau sinistre ouvert',
	'' as '2 BGE édités sur un même sinistre',
	'' as '2 BGE édités sur un même client',
	'' as 'BGE annulé',
	'' as 'BGE édité >=2mois après retour de diag'	
from @tbResult
where iCas=1
Union
select convert(varchar(10),date_action, 103) as date_action,
	id_oper as trigramme_agent, 
	id_sin as no_dossier,
	id_cli as no_client,
	id_adh as no_adhesion,
	garantie as garantie,
	mt_commande as 'Commandes FNAC dans Simpa2',
	'' as 'Classé SANS SUITE + nouveau sinistre ouvert',
	sData as '2 BGE édités sur un même sinistre',
	'' as '2 BGE édités sur un même client',
	'' as 'BGE annulé',
	'' as 'BGE édité >=2mois après retour de diag'	
from @tbResult
where iCas=2
Union
select convert(varchar(10),date_action, 103) as date_action,
	id_oper as trigramme_agent, 
	id_sin as no_dossier,
	id_cli as no_client,
	id_adh as no_adhesion,
	garantie as garantie,
	mt_commande as 'Commandes FNAC dans Simpa2',
	'' as 'Classé SANS SUITE + nouveau sinistre ouvert',
	'' as '2 BGE édités sur un même sinistre',
	sData as '2 BGE édités sur un même client',
	'' as 'BGE annulé',
	'' as 'BGE édité >=2mois après retour de diag'	
from @tbResult
where iCas=3
Union
select convert(varchar(10),date_action, 103) as date_action,
	id_oper as trigramme_agent, 
	id_sin as no_dossier,
	id_cli as no_client,
	id_adh as no_adhesion,
	garantie as garantie,
	mt_commande as 'Commandes FNAC dans Simpa2',
	'' as 'Classé SANS SUITE + nouveau sinistre ouvert',
	'' as '2 BGE édités sur un même sinistre',
	'' as '2 BGE édités sur un même client',
	sData as 'BGE annulé',
	'' as 'BGE édité >=2mois après retour de diag'	
from @tbResult
where iCas=4
Union
select convert(varchar(10),date_action, 103) as date_action,
	id_oper as trigramme_agent, 
	id_sin as no_dossier,
	id_cli as no_client,
	id_adh as no_adhesion,
	garantie as garantie,
	mt_commande as 'Commandes FNAC dans Simpa2',
	'' as 'Classé SANS SUITE + nouveau sinistre ouvert',
	'' as '2 BGE édités sur un même sinistre',
	'' as '2 BGE édités sur un même client',
	'' as 'BGE annulé',
	sData as 'BGE édité >=2mois après retour de diag'	
from @tbResult
where iCas=5

Go

grant execute on sysadm.PS_CTL_BGE_FNAC to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procedure            :       PS_ENVOI_MAIL_CTL_BGE_FNAC
-- Auteur               :       FPI
-- Date                 :       03/06/2015
-- Libelle              :        
-- Commentaires         :       [PM292-1]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_ENVOI_MAIL_CTL_BGE_FNAC' AND type = 'P' )
        DROP procedure sysadm.PS_ENVOI_MAIL_CTL_BGE_FNAC
GO

CREATE  PROC sysadm.PS_ENVOI_MAIL_CTL_BGE_FNAC
AS

/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications Paramêtre                                                                                                       */
/* @asRetour            = Valeur de retour suite au traitement                                                                  */
/*------------------------------------------------------------------------------------------------------------------------------*/

DECLARE         
        @dtTrt                  DATETIME        ,
        @sdtTrt                 VARCHAR(25),
        @shrTrt                 VARCHAR(25),
        @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
		@sRetourErrMail VarChar(255),	
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
		@sOsqlOption VarChar(255),
		@iRetOsql	int,
		@iRet		int	    
        
SET @dtTrt              = GETDATE()
SET @sdtTrt             = REPLACE(CONVERT(CHAR(10), @dtTrt, 103), '/', '') 
						  + '_' 
						  + Replace(CONVERT(varchar(20),@dtTrt,114),':','')
Set @shrTrt             = convert(varchar(8), getdate(),14)

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Extraction_Ctl_BGE_FNAC\'
Set @sFileName	= 'DOSSIER_BGE_FNAC_' + @sdtTrt
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
		 DB_NAME(db_id()) + '.sysadm.PS_CTL_BGE_FNAC ' + 
		'" /o' + @sFicOut + ' -w5000' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output


Set @sObjet   = 'Liste des dossiers pour contrôle des BGE FNAC'
Set @sMessage   = 'Ci-joint le fichier' + CHAR(10) + CHAR(10)
SET @sMessage   = @sMessage + 'Heure de lancement du traitement ' + @shrTrt + CHAR(10) + CHAR(10)

/*------------------------------------------------------------------*/
/* Envoi du mail.                                                   */
/*------------------------------------------------------------------*/
EXEC @iRet=master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'repanne@spb.eu,audit@spb.eu',
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL,
		NULL
		

  RETURN 1

GO

grant execute on sysadm.PS_ENVOI_MAIL_CTL_BGE_FNAC to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            : 		DW_S_VDOC17803_TEL_SINISTRES
-- Auteur               :       FPI
-- Date                 :       03/06/2015
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC17803]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_VDOC17803_TEL_SINISTRES' AND type = 'P' )
       DROP procedure sysadm.DW_S_VDOC17803_TEL_SINISTRES
GO

CREATE procedure sysadm.DW_S_VDOC17803_TEL_SINISTRES
    
AS

	Declare     @dtDteDeb       DateTime,
        @dtDteFin       DateTime
		
	--Set @dtDteFin=convert(datetime,'01/' + convert(varchar(2),month(getdate())) + '/' + convert(varchar(4),year(getdate())),103)
	Set @dtDteFin=getdate() -- [VDoc23529] - on prends un mois glissant
	Set @dtDteDeb=dateadd(MONTH,-1,@dtDteFin)
	
	select CONVERT(varchar(10),@dtDteDeb,103) as debut_periode,
		CONVERT(varchar(10),@dtDteFin,103) as fin_periode,
		s.marq_port,
		s.modl_port,
		(select top 1 i.frequence 
		 from sysadm.ifr i
		 where i.marque=s.marq_port and i.reference=s.modl_port 
		 order by id_trait desc)
		 as valeur_IFR,
		COUNT(*) nb_tel_sinistres
	from sysadm.sinistre s
		inner join  sysadm.div_sin d on s.id_sin=d.id_sin	
	where s.cree_le between @dtDteDeb  and @dtDteFin
		and d.nom_zone='type_app'
		and d.val_car='TEL'
		and marq_port is not null
	group by s.marq_port,	s.modl_port
	order by s.marq_port,	s.modl_port
Go

grant execute on sysadm.DW_S_VDOC17803_TEL_SINISTRES to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 		DW_S_VDOC17803_TPC_SINISTRES
-- Auteur               :       FPI
-- Date                 :       03/06/2015
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC17803]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_VDOC17803_TPC_SINISTRES' AND type = 'P' )
       DROP procedure sysadm.DW_S_VDOC17803_TPC_SINISTRES
GO

CREATE procedure sysadm.DW_S_VDOC17803_TPC_SINISTRES
 AS

	Declare     @dtDteDeb       DateTime,
        @dtDteFin       DateTime
		
	--Set @dtDteFin=convert(datetime,'01/' + convert(varchar(2),month(getdate())) + '/' + convert(varchar(4),year(getdate())),103)
	Set @dtDteFin=getdate() -- [VDoc23529] - on prends un mois glissant
	Set @dtDteDeb=dateadd(MONTH,-1,@dtDteFin)


	select CONVERT(varchar(10),@dtDteDeb,103) as debut_periode,
		CONVERT(varchar(10),@dtDteFin,103) as fin_periode,
		s.marq_port,
		s.modl_port,
		(select top 1 i.frequence 
		 from sysadm.ifr i
		 where i.marque=s.marq_port and i.reference=s.modl_port 
		 order by id_trait desc)
		 as valeur_IFR,
		COUNT(*) nb_tel_sinistres
	from sysadm.sinistre s
		inner join  sysadm.div_sin d on s.id_sin=d.id_sin	
	where s.cree_le between @dtDteDeb  and @dtDteFin
		and d.nom_zone='type_app'
		and d.val_car='TPC'
		and marq_port is not null
	group by s.marq_port,	s.modl_port
	order by s.marq_port,	s.modl_port
Go

grant execute on sysadm.DW_S_VDOC17803_TPC_SINISTRES to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 		PS_VDOC17803_FICHIERS
-- Auteur               :       FPI
-- Date                 :       01/03/2016
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC17803]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_VDOC17803_FICHIERS' AND type = 'P' )
       DROP procedure sysadm.PS_VDOC17803_FICHIERS
GO

CREATE PROCEDURE sysadm.PS_VDOC17803_FICHIERS
As
	Declare  @dtDteDeb       DateTime,
        @dtDteFin       DateTime,
		@sChemin	varchar(255),
		@sNomFic varchar(255),
		@sOsqlOption VarChar(255),
		@suffixe	varchar(10)

	DECLARE @sCommande   VarChar(500),
		@iRetOsql	int	

	Set @dtDteFin=convert(datetime,'01/' + convert(varchar(2),month(getdate())) + '/' + convert(varchar(4),year(getdate())),103)
	Set @dtDteDeb=dateadd(MONTH,-1,@dtDteFin)
	
	Select @sChemin = '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_vDoc17803_S_Loison\',
		@suffixe='_' + convert(varchar(4),year(@dtDteDeb),103) + RIGHT('0' + convert(varchar(2),month(@dtDteDeb)),2)

	Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'
	-- Etat 115
	Set @sNomFic='Liste_Telephones_sinistres' + @suffixe + '.xls'

	IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 SET @sCommande = 	'sqlcmd /S' + @@servername + ' /E /Q"' + 
			'set nocount on;exec SIMPA2_PRO.sysadm.DW_S_VDOC17803_TEL_SINISTRES ' + 
			'" /o' + @sChemin + @sNomFic + ' -w5000' + @sOsqlOption
	Else
	 SET @sCommande = 	'sqlcmd /S' + @@servername + ' /E /Q"' + 
			'set nocount on;EXEC SIMPA2_TRT.sysadm.DW_S_VDOC17803_TEL_SINISTRES ' + 
			'" /o' + @sChemin + @sNomFic + ' -w5000' + @sOsqlOption

	
	EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output
	
	-- Etat 116
	Set @sNomFic='Liste_Tablettes_sinistres' + @suffixe + '.xls'

	IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 SET @sCommande = 	'sqlcmd /S' + @@servername + ' /E /Q"' + 
			'set nocount on;exec SIMPA2_PRO.sysadm.DW_S_VDOC17803_TPC_SINISTRES ' +
			'" /o' + @sChemin + @sNomFic + ' -w5000' + @sOsqlOption
	Else
   SET @sCommande = 	'sqlcmd /S' + @@servername + ' /E /Q"' + 
			'set nocount on;exec SIMPA2_TRT.sysadm.DW_S_VDOC17803_TPC_SINISTRES ' +  
			'" /o' + @sChemin + @sNomFic + ' -w5000' + @sOsqlOption

	EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output
	
Go

grant execute on sysadm.PS_VDOC17803_FICHIERS to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 		PS_VDOC18868_SMAIN_KRIZEZ
-- Auteur               :       JFF
-- Date                 :       14/10/2015
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC18868]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_VDOC18868_SMAIN_KRIZEZ' AND type = 'P' )
       DROP procedure sysadm.PS_VDOC18868_SMAIN_KRIZEZ
GO

CREATE procedure sysadm.PS_VDOC18868_SMAIN_KRIZEZ
AS
Select  c.id_sin,
		c.id_seq,
		(Case 
			When sysadm.FN_A_COMMANDER ( c.id_sin, c.id_seq, 'P' ) = 'A_COMMANDER' Then 'CMDE_REMPL'
			Else c.id_ref_four
		 End ) lib_action,
		sysadm.FN_CODE_CAR ( c.id_four, '-FR' ) lib_four,
		sysadm.FN_AFF_DATE ( c.cree_le, 'AVEC_HEURE' ) cree_le,
		IsNull( 
			( Select sysadm.FN_AFF_DATE (MAX ( tc.cree_le ), 'AVEC_HEURE' )
			  From   sysadm.v_trace_cmde tc
			  Where  tc.id_sin = c.id_sin
			  And	 tc.id_seq = c.id_seq
			  And    tc.nom_zone = 'status_gc'
			), '' ) 'dte_dern_retour',
		c.status_gc,
		sysadm.FN_CODE_NUM ( c.status_gc, '-GC' ) lib_status_gc,
		sysadm.FN_CODE_CAR ( c.cod_etat, '-EC' ) cod_etat
			
From	sysadm.commande c
Where   c.id_four = 'SBE'
And		c.cree_le >= DateAdd ( month, -4, GETDATE() )
And		c.cod_etat <> 'ANN'
And     c.id_marq_art <> 'APPLE'
order by 1, 2

Go

--------------------------------------------------------------------
--
-- Procédure            : 		PS_VDOC18868_SMAIN_KRIZEZ_FIC
-- Auteur               :       JFF
-- Date                 :       14/10/2015
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC18868]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_VDOC18868_SMAIN_KRIZEZ_FIC' AND type = 'P' )
       DROP procedure sysadm.PS_VDOC18868_SMAIN_KRIZEZ_FIC
GO

CREATE procedure sysadm.PS_VDOC18868_SMAIN_KRIZEZ_FIC
AS

DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
		@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int,
	@iCpt int,
	@sIdFour VarChar ( 10 )

	SET NOCOUNT ON

				 
-- chemin d'enregistrement du Result Set
Set @sPath 	= '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_vDoc18868_SKRIZEZ\'
Set @sFileName	= 'Extraction_VDOC18868_' + convert( varchar ( 10), GETDATE(), 112 ) + replace ( convert( varchar ( 10), GETDATE(), 108 ) , ':', '' ) 
Set @sFileExt	= 'xls'

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt	 

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			DB_NAME(db_id()) + '.sysadm.PS_VDOC18868_SMAIN_KRIZEZ ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output


Go

grant execute on sysadm.PS_VDOC18868_SMAIN_KRIZEZ_FIC to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 		PS_S_REPA_SRR_NON_REGLE
-- Auteur               :       FPI
-- Date                 :       07/09/2016
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC17327]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_REPA_SRR_NON_REGLE' AND type = 'P' )
       DROP procedure sysadm.PS_S_REPA_SRR_NON_REGLE
GO

CREATE procedure sysadm.PS_S_REPA_SRR_NON_REGLE 
As

SET NOCOUNT ON 

select s.id_sin, c.id_seq,
	sysadm.FN_CODE_CAR(c.cod_etat,'-EC') as etat_commande,
	s.marq_port as marque,
	s.modl_port as modele,
	c.probleme,
	sysadm.FN_CODE_NUM(c.status_gc,'-GC ') as etat_appareil,
	isnull(c.comment_frn,'') as comment_frn
from sysadm.sinistre s
	inner join sysadm.commande c on s.id_sin=c.id_sin
where s.id_prod between 84300 and 84399
	and c.id_typ_art='PRS'
	and c.cod_etat <> 'ANN'
	and not exists (select * from sysadm.detail d
		where d.id_sin=s.id_sin and d.id_gti=c.id_gti and d.id_detail=c.id_detail
		and d.id_reg is null)
Go

grant execute on sysadm.PS_S_REPA_SRR_NON_REGLE to rolebddsinistres
Go



--------------------------------------------------------------------
--
-- Procédure            :       PS_S_REPA_SRR_NON_REGLE_MAIL
-- Auteur               :       FPI
-- Date                 :       07/09/2016
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC17327]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_REPA_SRR_NON_REGLE_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S_REPA_SRR_NON_REGLE_MAIL
GO

CREATE procedure sysadm.PS_S_REPA_SRR_NON_REGLE_MAIL
AS


DECLARE @sCommande   VarChar(250),
		@sdtTrt		 Varchar(31),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_Facturation\'
Set @sFileName	= 'Reparation_SRR_non_regles'
Set @sFileExt	= 'xls'
SET @sdtTrt             = REPLACE(CONVERT(CHAR(10), getdate(), 103), '/', '') 
						  + '_' 
						  + Replace(CONVERT(varchar(20),getdate(),108),':','')
						  
SET @sFicOut = @sPath + @sFileName + '_' + @sdtTrt + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			DB_NAME(db_id()) + '.sysadm.PS_S_REPA_SRR_NON_REGLE' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = 'Extraction réparations SFR Réunion non réglés'
set @sMessage  = 'Veuillez trouver ci-joint l''extraction des prestations de réparation SFR Réunion non réglés'

if @iRetOsql <> 0
BEGIN
	set @sMessage  = @sMessage + char(13) + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DEI/EW.'
END

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'groupefacturation@spb.eu',
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL


Go

grant execute on sysadm.PS_S_REPA_SRR_NON_REGLE_MAIL to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            :       DW_S_VDOC21811
-- Auteur               :       FPI
-- Date                 :       26/04/2016
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC21846] - d_trt_vdoc1811
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_VDOC21811' AND type = 'P' )
        DROP procedure sysadm.DW_S_VDOC21811
GO

CREATE procedure sysadm.DW_S_VDOC21811
   @dcIdSin decimal(10,0),
   @dcIdReg decimal(2,0),
   @noLigne int 
AS

select @noLigne as no_ligne, @dcIdSin as id_sin, @dcIdReg as id_reg, i.nom, 
	sysadm.FN_CODE_NUM(d.id_evt,'+EV') as lib_evenement, 
	sum(r.mt_tot_reg) as montant_regle
from sysadm.reglement r 
	inner join sysadm.detail d on d.id_sin=r.id_sin and (d.id_reg=r.id_reg or d.id_reg=r.id_reg_base)
	inner join sysadm.inter i on i.id_sin=r.id_sin and i.id_i=r.id_i
where i.id_four is not null
	and r.id_sin=@dcIdSin and r.id_reg = @dcIdReg
group by i.nom, d.id_evt

grant execute on sysadm.DW_S_VDOC21811 to rolebddsinistres
Go

-------------------------------------------------------------------
--
-- Procédure            :       DW_S_VDOC22119
-- Auteur               :       FPI
-- Date                 :       04/11/2016
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC22119] - d_trt_vdoc22119
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_VDOC22119' AND type = 'P' )
        DROP procedure sysadm.DW_S_VDOC22119
GO

CREATE procedure sysadm.DW_S_VDOC22119
	@sListeIdSin	Varchar(8000)
AS
	Declare @t TABLE (id_sin decimal(10,0))  -- [PI062]
	Declare @monXml xml
	Declare @nbMaxCol int,
		@i int,
		@iPos int,
		@dcIdSin decimal(10,0)
	Declare @cmd varchar(500)

	-- Décomposition en table
	/*Set @monXml=CAST('<A>'+ REPLACE(@sListeIdSin,',','</A><A>')+ '</A>' AS XML) 

	insert into @t
	SELECT t.value('.', 'decimal(10,0)') AS inVal  
	FROM @monXml.nodes('/A') AS x(t) */
	While LEN(@sListeIdSin) > 0
	Begin
		set @iPos=charindex(',',@sListeIdSin)
		If @iPos=0 
		Begin
			Set @dcIdSin = CONVERT ( Decimal ( 7 ) , @sListeIdSin )
			set @sListeIdSin=''
		End 
		Else
		Begin
			Set @dcIdSin = CONVERT ( Decimal ( 7 ), LEFT(@sListeIdSin,@iPos-1) )
			Set @sListeIdSin=SUBSTRING(@sListeIdSin,@iPos+1,8000)
		End
		
		insert into @t values (@dcIdSin)
	End

	-- Table de travail
	if exists (SELECT * FROM tempdb.sys.objects WHERE object_id = OBJECT_ID(N'tempdb.dbo.#tbResult'))
	Begin
		drop table #tbResult
	end

	CREATE TABLE #tbResult (
		id_sin decimal(10,0),
		id_prod decimal(7,0),
		lib_produit varchar(65),
		assureur varchar(35),
		id_reg int,
		cree_le varchar(10),
		mt_tot_reg  decimal(11,2),
		lib_reg varchar(35),
		nom varchar(71),
		mode_reg varchar(35))

	-- Select
	insert into #tbResult
	Select s.id_sin, 
		s.id_prod, sysadm.FN_LIB_PROD(s.id_prod) as lib_produit,
		sysadm.FN_LIB_CIE(s.id_sin) as assureur,
		r.id_reg, convert(varchar(10),r.cree_le,103) as cree_le, 
		r.mt_tot_reg, r.lib_reg, 
		i.nom, 
		sysadm.FN_CODE_CAR(r.cod_mode_reg,'-MR') as mode_reg
	from @t t
		inner join sysadm.sinistre s on s.id_sin=t.id_sin
		left outer join reglement r on s.id_sin=r.id_sin and r.cod_mot_reg='RM'
		left outer join inter i on i.id_sin=r.id_sin and i.id_i=r.id_i
	

	-- Mise en ligne
	select @nbMaxCol=MAX(nb)
	from (select COUNT(*) nb, id_sin from #tbResult t group by id_sin) a

	Set @i=1
	While @i < @nbMaxCol
	Begin

		-- Création des 3 nouvelles colonnes
		Set @i=@i + 1
		set @cmd ='Alter TABLE #tbResult add id_reg_' + convert(varchar(2), @i) + ' int,' +
			'cree_le_' + convert(varchar(2), @i) + ' varchar(10),' +
			'mt_tot_reg_' + convert(varchar(2), @i) + ' decimal(11,2),'	+
			'lib_reg_' + convert(varchar(2), @i) + ' varchar(35),'	+
			'nom_' + convert(varchar(2), @i) + ' varchar(71),'	+
			'mode_reg_' + convert(varchar(2), @i) + ' varchar(35)'	
		exec (@cmd)
	
		-- Mise à jour de ces colonnes avec la dernière ligne du même id_sin
		set @cmd ='update tr set id_reg_' + convert(varchar(2), @i) + '=tr2.id_reg, ' +
				'cree_le_' + convert(varchar(2), @i) + '=tr2.cree_le, ' +
				'mt_tot_reg_' + convert(varchar(2), @i) + '=tr2.mt_tot_reg, ' +
				'lib_reg_' + convert(varchar(2), @i) + '=tr2.lib_reg , ' +
				'nom_' + convert(varchar(2), @i) + '=tr2.nom , ' +
				'mode_reg_' + convert(varchar(2), @i) + '=tr2.mode_reg ' +
			'from #tbResult tr ' +
			'inner join #tbResult tr2 on tr.id_sin=tr2.id_sin ' +
			'where tr.id_reg < tr2.id_reg ' +
			'and not exists (select * from #tbResult t where tr2.id_sin=t.id_sin and  tr2.id_reg > t.id_reg and t.id_reg <> tr.id_reg)' 
		exec (@cmd)
	
		-- Suppression de la dernière ligne d'un groupe d'id_sin
		delete from tr2
			from #tbResult tr 
			inner join #tbResult tr2 on tr.id_sin=tr2.id_sin 
			where tr.id_reg < tr2.id_reg 
				and not exists (select * from #tbResult t where tr2.id_sin=t.id_sin and tr2.id_reg > t.id_reg and t.id_reg <> tr.id_reg)
	
	End

	While @i < 6
	Begin
	-- Création des 3 nouvelles colonnes
		Set @i=@i + 1
		set @cmd ='Alter TABLE #tbResult add id_reg_' + convert(varchar(2), @i) + ' int,' +
			'cree_le_' + convert(varchar(2), @i) + ' varchar(10),' +
			'mt_tot_reg_' + convert(varchar(2), @i) + ' decimal(11,2),'	+
			'lib_reg_' + convert(varchar(2), @i) + ' varchar(35),'	+
			'nom_' + convert(varchar(2), @i) + ' varchar(71),'	+
			'mode_reg_' + convert(varchar(2), @i) + ' varchar(35)'	
		exec (@cmd)
	End
	
	select * from #tbResult

Go

grant execute on sysadm.DW_S_VDOC22119 to rolebddsinistres
Go

-------------------------------------------------------------------
--
-- Procédure            :       DW_S_VDOC23002
-- Auteur               :       FPI
-- Date                 :       13/02/2017
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC23002] - d_trt_vdoc23002
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_VDOC23002' AND type = 'P' )
        DROP procedure sysadm.DW_S_VDOC23002
GO

CREATE procedure sysadm.DW_S_VDOC23002
	@sListeIdSin	Varchar(8000)
AS
	Declare @t TABLE (id_sin decimal(10,0))  -- [PI062]
	Declare @monXml xml
	Declare @nbMaxCol int,
		@i int,
		@iPos int,
		@dcIdSin decimal(10,0)
	Declare @cmd varchar(500)

	-- Décomposition en table
	While LEN(@sListeIdSin) > 0
	Begin
		set @iPos=charindex(',',@sListeIdSin)
		If @iPos=0 
		Begin
			Set @dcIdSin = CONVERT ( Decimal ( 7 ) , @sListeIdSin )
			set @sListeIdSin=''
		End 
		Else
		Begin
			Set @dcIdSin = CONVERT ( Decimal ( 7 ), LEFT(@sListeIdSin,@iPos-1) )
			Set @sListeIdSin=SUBSTRING(@sListeIdSin,@iPos+1,8000)
		End
		
		insert into @t values (@dcIdSin)
	End

	-- Table de travail
	if exists (SELECT * FROM tempdb.sys.objects WHERE object_id = OBJECT_ID(N'tempdb.dbo.#tbResult'))
	Begin
		drop table #tbResult
	end

	CREATE TABLE #tbResult (
		id_sin decimal(10,0),
		id_prod decimal(7,0),
		lib_produit varchar(65),
		assureur varchar(35),
		id_reg int,
		cree_le varchar(10),
		mt_tot_reg  decimal(11,2),
		nom varchar(71),
		lib_reg varchar(40))

	-- Select
	insert into #tbResult
	Select s.id_sin, 
		s.id_prod, sysadm.FN_LIB_PROD(s.id_prod) as lib_produit,
		sysadm.FN_LIB_CIE(s.id_sin) as assureur,
		r.id_reg, convert(varchar(10),r.cree_le,103) as cree_le, 
		r.mt_tot_reg, 
		i.nom,
		Case When d.id_detail is null and  r.cod_mot_reg ='RN' Then 'RN - ' + + sysadm.FN_CODE_NUM(f.id_typ_frais,'+NF') 
			When r.cod_mot_reg ='RN' Then 'RN - ' + sysadm.FN_CODE_NUM(d.id_evt,'+EV') 
			else RTrim(r.cod_mot_reg) + ' - ' + RTrim(r.lib_reg) End as lib_reg
	from @t t
		inner join sysadm.sinistre s on s.id_sin=t.id_sin
		left outer join sysadm.reglement r on s.id_sin=r.id_sin and r.cod_mot_reg <> 'RI'
		left outer join sysadm.inter i on i.id_sin=r.id_sin and i.id_i=r.id_i
		left outer join sysadm.detail d on d.id_sin=s.id_sin and d.id_reg=r.id_reg
		left outer join sysadm.frais f on f.id_sin=s.id_sin and f.id_reg=r.id_reg

	-- Mise en ligne
	select @nbMaxCol=MAX(nb)
	from (select COUNT(*) nb, id_sin from #tbResult t group by id_sin) a

	Set @i=1
	While @i < @nbMaxCol
	Begin

		-- Création des 3 nouvelles colonnes
		Set @i=@i + 1
		set @cmd ='Alter TABLE #tbResult add id_reg_' + convert(varchar(2), @i) + ' int,' +
			'cree_le_' + convert(varchar(2), @i) + ' varchar(10),' +
			'mt_tot_reg_' + convert(varchar(2), @i) + ' decimal(11,2),'	+
			'nom_' + convert(varchar(2), @i) + ' varchar(71),'	+
			'lib_reg_' + convert(varchar(2), @i) + ' varchar(40)'	
		exec (@cmd)
	
		-- Mise à jour de ces colonnes avec la dernière ligne du même id_sin
		set @cmd ='update tr set id_reg_' + convert(varchar(2), @i) + '=tr2.id_reg, ' +
				'cree_le_' + convert(varchar(2), @i) + '=tr2.cree_le, ' +
				'mt_tot_reg_' + convert(varchar(2), @i) + '=tr2.mt_tot_reg, ' +
				'lib_reg_' + convert(varchar(2), @i) + '=tr2.lib_reg , ' +
				'nom_' + convert(varchar(2), @i) + '=tr2.nom  ' +
			'from #tbResult tr ' +
			'inner join #tbResult tr2 on tr.id_sin=tr2.id_sin ' +
			'where tr.id_reg < tr2.id_reg ' +
			'and not exists (select * from #tbResult t where tr2.id_sin=t.id_sin and  tr2.id_reg > t.id_reg and t.id_reg <> tr.id_reg)' 
		exec (@cmd)
	
		-- Suppression de la dernière ligne d'un groupe d'id_sin
		delete from tr2
			from #tbResult tr 
			inner join #tbResult tr2 on tr.id_sin=tr2.id_sin 
			where tr.id_reg < tr2.id_reg 
				and not exists (select * from #tbResult t where tr2.id_sin=t.id_sin and tr2.id_reg > t.id_reg and t.id_reg <> tr.id_reg)
	
	End

	While @i < 6
	Begin
	-- Création des 3 nouvelles colonnes
		Set @i=@i + 1
		set @cmd ='Alter TABLE #tbResult add id_reg_' + convert(varchar(2), @i) + ' int,' +
			'cree_le_' + convert(varchar(2), @i) + ' varchar(10),' +
			'mt_tot_reg_' + convert(varchar(2), @i) + ' decimal(11,2),'	+
			'nom_' + convert(varchar(2), @i) + ' varchar(71),'	+
			'lib_reg_' + convert(varchar(2), @i) + ' varchar(40)'	
		exec (@cmd)
	End
	
	select *,
		(select sum(mt_tot_reg) from sysadm.reglement r where r.id_sin=t.id_sin and r.cod_mot_reg <> 'RI') as cout_sinistre
	from #tbResult t

Go

grant execute on sysadm.DW_S_VDOC23002 to rolebddsinistres
Go

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_VDOC23002_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S_VDOC23002_V01
GO

CREATE procedure sysadm.DW_S_VDOC23002_V01
	@sListeIdSin	Varchar(8000),
	@inbOccur		int
AS
	Declare @t TABLE (id_sin decimal(10,0))  -- [PI062]
	Declare @monXml xml
	Declare @nbMaxCol int,
		@i int,
		@iPos int,
		@dcIdSin decimal(10,0)
	Declare @cmd varchar(500)

	-- Décomposition en table
	While LEN(@sListeIdSin) > 0
	Begin
		set @iPos=charindex(',',@sListeIdSin)
		If @iPos=0 
		Begin
			Set @dcIdSin = CONVERT ( Decimal ( 7 ) , @sListeIdSin )
			set @sListeIdSin=''
		End 
		Else
		Begin
			Set @dcIdSin = CONVERT ( Decimal ( 7 ), LEFT(@sListeIdSin,@iPos-1) )
			Set @sListeIdSin=SUBSTRING(@sListeIdSin,@iPos+1,8000)
		End
		
		insert into @t values (@dcIdSin)
	End

	-- Table de travail
	if exists (SELECT * FROM tempdb.sys.objects WHERE object_id = OBJECT_ID(N'tempdb.dbo.#tbResult'))
	Begin
		drop table #tbResult
	end

	CREATE TABLE #tbResult (
		id_sin decimal(10,0),
		id_prod decimal(7,0),
		lib_produit varchar(65),
		assureur varchar(35),
		id_reg int,
		cree_le varchar(10),
		mt_tot_reg  decimal(11,2),
		nom varchar(71),
		lib_reg varchar(100))

	-- Select
	insert into #tbResult
	Select distinct s.id_sin, 
		s.id_prod, sysadm.FN_LIB_PROD(s.id_prod) as lib_produit,
		sysadm.FN_LIB_CIE(s.id_sin) as assureur,
		r.id_reg, convert(varchar(10),r.cree_le,103) as cree_le, 
		r.mt_tot_reg, 
		i.nom,
		Case When d.id_detail is null and  r.cod_mot_reg ='RN' Then 
			'RN - ' + stuff((select ' / ' + sysadm.FN_CODE_NUM(f.id_typ_frais,'+NF') 
							from sysadm.frais f 
							where f.id_sin=s.id_sin and f.id_reg=r.id_reg
							for xml path('')),1,3,'')
			When r.cod_mot_reg ='RN' Then 'RN - ' + sysadm.FN_CODE_NUM(d.id_evt,'+EV') 
			else RTrim(r.cod_mot_reg) + ' - ' + RTrim(r.lib_reg) End as lib_reg
	from @t t
		inner join sysadm.sinistre s on s.id_sin=t.id_sin
		left outer join sysadm.reglement r on s.id_sin=r.id_sin and r.cod_mot_reg <> 'RI'
		left outer join sysadm.inter i on i.id_sin=r.id_sin and i.id_i=r.id_i
		left outer join sysadm.detail d on d.id_sin=s.id_sin and d.id_reg=r.id_reg

	-- Mise en ligne
	select @nbMaxCol=MAX(nb)
	from (select COUNT(*) nb, id_sin from #tbResult t group by id_sin) a

	Set @i=1
	While @i < @nbMaxCol
	Begin

		-- Création des 3 nouvelles colonnes
		Set @i=@i + 1
		set @cmd ='Alter TABLE #tbResult add id_reg_' + convert(varchar(2), @i) + ' int,' +
			'cree_le_' + convert(varchar(2), @i) + ' varchar(10),' +
			'mt_tot_reg_' + convert(varchar(2), @i) + ' decimal(11,2),'	+
			'nom_' + convert(varchar(2), @i) + ' varchar(71),'	+
			'lib_reg_' + convert(varchar(2), @i) + ' varchar(100)'	
		exec (@cmd)
	
		-- Mise à jour de ces colonnes avec la dernière ligne du même id_sin
		set @cmd ='update tr set id_reg_' + convert(varchar(2), @i) + '=tr2.id_reg, ' +
				'cree_le_' + convert(varchar(2), @i) + '=tr2.cree_le, ' +
				'mt_tot_reg_' + convert(varchar(2), @i) + '=tr2.mt_tot_reg, ' +
				'lib_reg_' + convert(varchar(2), @i) + '=tr2.lib_reg , ' +
				'nom_' + convert(varchar(2), @i) + '=tr2.nom  ' +
			'from #tbResult tr ' +
			'inner join #tbResult tr2 on tr.id_sin=tr2.id_sin ' +
			'where tr.id_reg < tr2.id_reg ' +
			'and not exists (select * from #tbResult t where tr2.id_sin=t.id_sin and  tr2.id_reg > t.id_reg and t.id_reg <> tr.id_reg)' 
		exec (@cmd)
	
		-- Suppression de la dernière ligne d'un groupe d'id_sin
		delete from tr2
			from #tbResult tr 
			inner join #tbResult tr2 on tr.id_sin=tr2.id_sin 
			where tr.id_reg < tr2.id_reg 
				and not exists (select * from #tbResult t where tr2.id_sin=t.id_sin and tr2.id_reg > t.id_reg and t.id_reg <> tr.id_reg)
	
	End

	If @inbOccur < 6 Set @inbOccur=6
	
	While @i < @inbOccur 
	Begin
	-- Création des 3 nouvelles colonnes
		Set @i=@i + 1
		set @cmd ='Alter TABLE #tbResult add id_reg_' + convert(varchar(2), @i) + ' int,' +
			'cree_le_' + convert(varchar(2), @i) + ' varchar(10),' +
			'mt_tot_reg_' + convert(varchar(2), @i) + ' decimal(11,2),'	+
			'nom_' + convert(varchar(2), @i) + ' varchar(71),'	+
			'lib_reg_' + convert(varchar(2), @i) + ' varchar(100)'	
		exec (@cmd)
	End
	
	select *,
		(select sum(mt_tot_reg) from sysadm.reglement r where r.id_sin=t.id_sin and r.cod_mot_reg <> 'RI') as cout_sinistre
	from #tbResult t

Go

grant execute on sysadm.DW_S_VDOC23002_V01 to rolebddsinistres
Go

-------------------------------------------------------------------
--
-- Procédure            :       DW_S_VDOC23002_NBCOL
-- Auteur               :       FPI
-- Date                 :       08/03/2017
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC23002] - d_trt_vdoc23002
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_VDOC23002_NBCOL' AND type = 'P' )
        DROP procedure sysadm.DW_S_VDOC23002_NBCOL
GO

CREATE procedure sysadm.DW_S_VDOC23002_NBCOL
	@sListeIdSin	Varchar(8000)
AS
	Declare @t TABLE (id_sin decimal(10,0))  -- [PI062]
	Declare @nbMaxCol int,
		@iPos int,
		@dcIdSin decimal(10,0)

	-- Décomposition en table
	While LEN(@sListeIdSin) > 0
	Begin
		set @iPos=charindex(',',@sListeIdSin)
		If @iPos=0 
		Begin
			Set @dcIdSin = CONVERT ( Decimal ( 7 ) , @sListeIdSin )
			set @sListeIdSin=''
		End 
		Else
		Begin
			Set @dcIdSin = CONVERT ( Decimal ( 7 ), LEFT(@sListeIdSin,@iPos-1) )
			Set @sListeIdSin=SUBSTRING(@sListeIdSin,@iPos+1,8000)
		End
		
		insert into @t values (@dcIdSin)
	End;

	-- Select
	With maTable(nb, id_sin)
	As
	(select COUNT(*) nb, t.id_sin
		from @t t
			inner join sysadm.sinistre s on s.id_sin=t.id_sin
			left outer join sysadm.reglement r on s.id_sin=r.id_sin and r.cod_mot_reg <> 'RI'
			group by t.id_sin
	)
	select @nbMaxCol=MAX(nb)
	from maTable

	return @nbMaxCol
Go

grant execute on sysadm.DW_S_VDOC23002_NBCOL to rolebddsinistres
Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_S_MARYSE_DBL_RGLT_VDOC23263
-- Auteur               :       FPI
-- Date                 :       10/03/2017
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC23263] - d_trt_vdoc23002
--
-- Arguments            :       
--				
-- Retourne             :       Les doublons de règlements de - de 1 an
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MARYSE_DBL_RGLT_VDOC23263' AND type = 'P' )
        DROP procedure sysadm.PS_S_MARYSE_DBL_RGLT_VDOC23263
GO

CREATE procedure sysadm.PS_S_MARYSE_DBL_RGLT_VDOC23263
AS

SET NOCOUNT ON;

Declare @sDateDeb Varchar ( 20 ) -- Format Date de présentation
Declare @sDateFin Varchar ( 20 ) -- Format Date de présentation
Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @dtToday datetime

Select @dtToday		= getdate()

Select @dtDateDeb	= Convert(Varchar (8), DateAdd ( day, -7, @dtToday) , 112 )
Select @sDateDeb	= Convert(Varchar(10),@dtDateDeb, 103)+ ' ' + Convert ( Varchar( 8 ),@dtDateDeb, 114)
Select @dtDateFin	= DateAdd ( ss , -1, cast (Convert(VarChar (8), @dtToday, 112 ) as datetime ) )
Select @sDateFin	= Convert(Varchar(10),@dtDateFin, 103)+ ' ' + Convert ( Varchar( 8 ),@dtDateFin, 114)

Select Distinct
   convert(varchar(10), @dtToday,103) as date_extract,
   r.id_sin,
   r.mt_tot_reg,
   convert(varchar(10),r.dte_reg,103) as dte_reg,
   i.nom,
   Case When d.id_detail is null and  r.cod_mot_reg ='RN' Then 'RN - ' + + sysadm.FN_CODE_NUM(f.id_typ_frais,'+NF') 
			When r.cod_mot_reg ='RN' Then 'RN - ' + sysadm.FN_CODE_NUM(d.id_evt,'+EV') 
			else RTrim(r.cod_mot_reg) + ' - ' + RTrim(r.lib_reg) End as lib_reg,
	s.id_prod, 
	sysadm.FN_LIB_PROD(s.id_prod) as lib_produit,
	sysadm.FN_LIB_CIE(s.id_sin) as assureur,
	(select top 1 sysadm.FN_CODE_NUM(rgti.id_gti,'-GA') from sysadm.reg_gti rgti where rgti.id_sin=r.id_sin and rgti.id_reg=r.id_reg and rgti.id_gti > 0) as garantie,
	(select sum(mt_tot_reg) from sysadm.reglement rt where rt.id_sin=r.id_sin and rt.cod_mot_reg <> 'RI') as cout_sinistre
From  sysadm.reglement r
	inner join sysadm.reglement r2 on r2.id_sin=r.id_sin
	inner join sysadm.inter i on i.id_sin=r.id_sin and i.id_i=r.id_i
	inner join sysadm.sinistre s on s.id_sin=r.id_sin
    inner join sysadm.reg_gti rg on rg.id_sin=r.id_sin and rg.id_reg=r.id_reg
	left outer join sysadm.detail d on d.id_sin=r.id_sin and d.id_reg=r.id_reg
	left outer join sysadm.frais f on f.id_sin=r.id_sin and f.id_reg=r.id_reg and f.id_typ_frais > 1 -- ajout 20/03/2017
Where r.cree_le between @dtDateDeb and @dtDateFin
	and r.cod_mot_reg <> 'RI'
	and Abs(r.mt_tot_reg) >= 50 -- ajout 20/03/2017
	and rg.id_gti not in (7,8) -- ajout 20/03/2017
	and s.id_prod not in (901,902,13400,
		42701,905,6700,6900,18400,23403,32200,37500,80900,80901,80902,13000, 9401)
	and s.id_prod not between 279 and 283 -- Ajout 283 le 24/03/2017
	and s.id_prod not in(1600,13813,16101,80900,14200,8510) -- ajout le 12/05/2017
	and s.id_prod not between 23400 and 23499
	and s.id_prod not between 31500 and 31599
	and s.id_prod not between 42700 and 42799
	And r.id_reg > r2.id_reg
	-- Pas de RM sur le règlement précédent
	And     Not Exists ( 
            Select 1
            From   sysadm.reglement r3
            Where  r3.id_sin = r2.id_sin
            And      r3.cod_mot_reg = 'RM'
            And    r3.id_reg_base = r2.id_reg
          )
	-- Pas de RM sur ce règlement, ni règlement ensuite (pour avoir le dernier)
	And     Not Exists ( 
            Select * 
            From   sysadm.reglement r4
            Where  r4.id_sin = r.id_sin
            And    ( ( r4.cod_mot_reg = 'RM'
            And    r4.id_reg_base = r.id_reg)
				or (r4.id_reg > r.id_reg and r4.cod_mot_reg <> 'RI' and Abs(r4.mt_tot_reg) >= 50))
            )
order by r.id_sin

Go

grant execute on sysadm.PS_S_MARYSE_DBL_RGLT_VDOC23263 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_MARYSE_DBL_RGLT_VDOC23263_MAIL 
-- Auteur               :       FPI
-- Date                 :       10/03/2017
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [VDOC23263]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- JFF	08/03/2018	[VDOC25845] chgt adr mail
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MARYSE_DBL_RGLT_VDOC23263_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S_MARYSE_DBL_RGLT_VDOC23263_MAIL
GO

CREATE procedure sysadm.PS_S_MARYSE_DBL_RGLT_VDOC23263_MAIL
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(500),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
	@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_Dblt_Maryse_vDoc23263\'
Set @sFileName	= 'Export_Dblt_Maryse_vDoc23263'
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
		DB_NAME(db_id()) + '.sysadm.PS_S_MARYSE_DBL_RGLT_VDOC23263 ' + 
		'" /o' + @sFicOut + ' -w5000' + @sOsqlOption

		EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = 'Extraction SPB : Doublons règlements vDoc23263'
set @sMessage  = 'Vous trouverez ci-joint l''extraction journalière reprenant les doublons de règlements des 7 derniers jours.'

if @iRetOsql <> 0
 BEGIN
	set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DSI.'
	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'jff@spb.fr',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL
 END
Else
 Begin
	EXEC master.dbo.SPB_PS_MAIL_OUTLOOK
			@sRetourErrMail OUTPUT, 
--			'mlimare@spb.eu', -- [VDOC25845]
			'facturation@spb.eu', -- [VDOC25845]
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL, 
			NULL
 End

Go

grant execute on sysadm.PS_S_MARYSE_DBL_RGLT_VDOC23263_MAIL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_IRREP_PSM_HEBDO
-- Auteur               :       FPI	
-- Date                 :       21/03/2017
-- Libellé              :       
-- Commentaires         :       d'après PS_S_JOURN_IRREP_PSM_PEC_A_RECYCLER
-- Références           :       [VDoc23235]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- 31/05/2017 	FPI	[VDOC23865] n° de PSM au format FRXXX
-- 02/06/2017   FPI	[VDOC23902]
-- 13/07/2017	FPI	[ECART_ETH] On prend l'IMEI de la commande d'irréparable au lieu de celui du dossier
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_IRREP_PSM_HEBDO' AND type = 'P' )
        DROP procedure sysadm.PS_S_IRREP_PSM_HEBDO
GO

CREATE procedure sysadm.PS_S_IRREP_PSM_HEBDO
AS

Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @iMois Integer
Declare @iAnnee Integer

SET NOCOUNT ON;

Set @dtDateDeb = CONVERT( DateTime,
			convert(varchar(10), DATEADD(day,-7,getdate()) , 103),
			 103 )

-- @@dtDateFin = la veille à 23:59:59
Set @dtDateFin = CONVERT( DateTime,
		convert(varchar(10), getdate() , 103),
			 103 )
			 
set @dtDateFin=DATEADD(SECOND,-1,@dtDateFin)

Select Convert ( VarChar ( 10), @dtDateDeb, 103 ) 'periode_deb_dte_fin_trt',
	   Convert ( VarChar ( 10), @dtDateFin, 103 ) 'periode_fin_dte_fin_trt',
	   CONVERT ( VarChar ( 10), c.id_sin ) + '-' + CONVERT ( VarChar ( 10), c.id_seq )'num_presta_spb',
	   s.id_prod,
	   sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_prod',
	   cie.lib_cie 'Assureur',
	   s.marq_port 'Marque',
	   s.modl_port 'Modele',
	   --'''' + s.num_imei_port + '''' 'IMEI',
	   '''' + c2.id_serie_anc + '''' 'IMEI', -- [ECART_ETH]
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré en pointe de vente'
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré envoie coli en centralisation'
	   End 'pdv_ou_coli_centl',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c2.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c2.info_frn_spb_cplt) , ';' )
	   End 'Nom PSM',
	   'FR' + Right('000' + 
		Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c2.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c2.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c2.info_frn_spb_cplt) , ';' )
		End,3)'Numéro PSM',
	   Convert ( VarChar ( 10), c2.dte_rcp_frn, 103 ) 'dte_rcp_PSM',
	   sysadm.FN_CODE_CAR(d.val_car,'-AR') 'Type appareil',
	   convert(varchar(10),c2.dte_env_cli,103) 'Date envoi client'

From sysadm.commande c
Inner Join sysadm.gar_sin g on g.id_sin = c.id_sin And g.id_gti = c.id_gti
Inner Join sysadm.sinistre s on s.id_sin = c.id_sin
Inner Join sysadm.garantie ga on ga.id_prod = s.id_prod And 
								 ga.id_gti = c.id_gti And
								 ga.id_rev = s.id_rev
Inner Join sysadm.police po on po.id_police = ga.id_police
Inner Join sysadm.compagnie cie on cie.id_cie = po.id_cie
inner join sysadm.div_sin d on d.id_sin=c.id_sin
inner join sysadm.commande c2 on c2.id_sin=c.id_sin 
	and c2.status_gc in (21,23) -- [ECART_ETH]
	and c2.id_seq=(select max(id_seq) from sysadm.commande c3 where c3.id_sin=s.id_sin and c3.id_four='PSM' and c3.id_seq < c.id_seq and c3.id_typ_art='PRS')
Where c.cree_le > '01/01/2015'
and   c.id_four='PSM'
And   c.id_ref_four='PEC_A_RECYCLER'
And   c.cod_etat <> 'ANN'
And   CHARINDEX('NUM_PDV=302',c2.info_frn_spb_cplt) = 0 -- [VDoc23235]
And   s.id_prod not between 48100 and 48199 -- [VDoc18783]
And   s.id_prod not between 84000 and 84099 -- [VDoc18783]
and   d.nom_zone='type_app'
And   c.valide_le between @dtDateDeb And @dtDateFin



Go

grant execute on sysadm.PS_S_IRREP_PSM_HEBDO to rolebddsinistres
Go

-- 13/07/2017 - ETH - FPI 
-- prendre la date de classement en irréparable 
-- prendre l’IMEI de la commande en irrép

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_IRREP_PSM_HEBDO_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S_IRREP_PSM_HEBDO_V01
GO

CREATE procedure sysadm.PS_S_IRREP_PSM_HEBDO_V01
AS

Declare @dtDateDeb datetime -- Format Date de Manipulation
Declare @dtDateFin datetime -- Format Date de Manipulation
Declare @iMois Integer
Declare @iAnnee Integer

SET NOCOUNT ON;

Set @dtDateDeb = CONVERT( DateTime,
			convert(varchar(10), DATEADD(day,-7,getdate()) , 103),
			 103 )

-- @@dtDateFin = la veille à 23:59:59
Set @dtDateFin = CONVERT( DateTime,
		convert(varchar(10), getdate() , 103),
			 103 )
			 
set @dtDateFin=DATEADD(SECOND,-1,@dtDateFin)

Select Convert ( VarChar ( 10), @dtDateDeb, 103 ) 'periode_deb_dte_fin_trt',
	   Convert ( VarChar ( 10), @dtDateFin, 103 ) 'periode_fin_dte_fin_trt',
	   CONVERT ( VarChar ( 10), c.id_sin ) + '-' + CONVERT ( VarChar ( 10), c.id_seq )'num_presta_spb',
	   s.id_prod,
	   sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_prod',
	   cie.lib_cie 'Assureur',
	   s.marq_port 'Marque',
	   s.modl_port 'Modele',
	   '''' + c.id_serie_nouv + '''' 'IMEI', 
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré en pointe de vente'
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then 'Assuré envoie coli en centralisation'
	   End 'pdv_ou_coli_centl',
	   Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
	   End 'Nom PSM',
	   'FR' + Right('000' + 
		Case 
			When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
			When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
				Then sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
		End,3)'Numéro PSM',
	   Convert ( VarChar ( 10), c.dte_rcp_frn, 103 ) 'dte_rcp_PSM',
	   sysadm.FN_CODE_CAR(d.val_car,'-AR') 'Type appareil',
	   convert(varchar(10),c.dte_env_cli,103) 'Date envoi client'

From sysadm.commande c
Inner Join sysadm.gar_sin g on g.id_sin = c.id_sin And g.id_gti = c.id_gti
Inner Join sysadm.sinistre s on s.id_sin = c.id_sin
Inner Join sysadm.garantie ga on ga.id_prod = s.id_prod And 
								 ga.id_gti = c.id_gti And
								 ga.id_rev = s.id_rev
Inner Join sysadm.police po on po.id_police = ga.id_police
Inner Join sysadm.compagnie cie on cie.id_cie = po.id_cie
inner join sysadm.div_sin d on d.id_sin=c.id_sin
Where c.maj_le between @dtDateDeb And @dtDateFin
and   c.id_four='PSM'
And   c.cod_etat <> 'ANN'
And   CHARINDEX('NUM_PDV=302',c.info_frn_spb_cplt) = 0 
And   s.id_prod not between 48100 and 48199 -- [VDoc18783]
And   s.id_prod not between 84000 and 84099 -- [VDoc18783]
and   d.nom_zone='type_app'
and   c.comment_frn not like '%[[]BRIS]%'
and   c.comment_frn not like '%[[]BNV]%'
and   c.comment_frn not like '%[[]SAV_NO_OK]%'
and   c.comment_frn not like '%[[]BNVSOX]%' -- [VDoc25055]
And   c.status_gc in (21,23)
and not exists (select 1 
		from sysadm.commande c2 
		where c2.id_sin=c.id_sin 
			and c2.id_seq > c.id_seq 
			and c2.id_ref_four='REFUSE_A_REEXP' 
			and c2.cod_etat<> 'ANN') -- [VDoc25273]
Go

grant execute on sysadm.PS_S_IRREP_PSM_HEBDO_V01 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_IRREP_PSM_HEBDO_FICHIER
-- Auteur               :       FPI	
-- Date                 :       21/03/2017
-- Libellé              :       
-- Commentaires         :       d'après PS_S_IRREP_PSM
-- Références           :       [VDoc23235]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- 13/07/2017	FPI	Appel de la V01
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_IRREP_PSM_HEBDO_FICHIER' AND type = 'P' )
        DROP procedure sysadm.PS_S_IRREP_PSM_HEBDO_FICHIER
GO

CREATE procedure sysadm.PS_S_IRREP_PSM_HEBDO_FICHIER
AS


DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
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

Set @dtRef=DATEADD(day,-7,getdate())

-- chemin d'enregistrement du Result Set
Set @sPath 	= '\\f4t\Simpa2\O2M\irrep_PSM_Hebdomadaire\'
Set @sFileName	= 'Irrep_PSM_Simpa_' +  convert(varchar(4),year(@dtRef)) + 
				Right('0' + convert(varchar(4),month(@dtRef)),2) + 
				Right('0' + convert(varchar(2),datepart(wk,@dtRef)),2)
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
	db_name(db_id()) + '.sysadm.PS_S_IRREP_PSM_HEBDO_V01 ' + 
	'" /o' + @sFicOut + ' -w5000' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Select @iRetOsql

Go

grant execute on sysadm.PS_S_IRREP_PSM_HEBDO_FICHIER to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S_ETAT_ADVISE_PC151259_2
-- Auteur               :       JFF
-- Date                 :       01/06/2017
-- Libellé              :       
-- Commentaires         :       d'après PS_S_IRREP_PSM
-- Références           :       [PC151259-2]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- JFF      12/09/2017   [PC151259-3]
-- FPI		13/10/2017	[ITSM492938] Correction pour prendre RM & RP
-- JFF		07/03/2018  [VDOC25841]
-- JFF      29/05/2018  [VDOC26230] V01
-- JFF      23/08/2018  [VDOC26634] V02
-- JFF      07/11/2018  [VDOC27019] V02
-- JFF      21/11/2018  [VDOC27123]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_ETAT_ADVISE_PC151259_2_V02' AND type = 'P' )
        DROP procedure sysadm.DW_S_ETAT_ADVISE_PC151259_2_V02
GO

CREATE procedure sysadm.DW_S_ETAT_ADVISE_PC151259_2_V02
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS

Select	rtrim ( sysadm.FN_AFF_DATE ( r.dte_reg, 'SH' )) 'Période de facturation',
		rtrim (d.num_facture ) 'N° de Facturation',
		rtrim ( s.id_contrat_abonne ) 'N° Adhésion ADVISE',
		rtrim ( Convert ( Varchar, s.id_sin ) + '-' + convert ( varchar, c.id_seq )) 'N° Dossier sinistre externe',
		'' 'N° Sinistre ADVISE',
		rtrim ( s.num_imei_port ) 'IMEI',
		rtrim ( p.nom ) 'Nom Client',
		rtrim ( p.prenom ) 'Prénom Client',
		rtrim ( sysadm.FN_CODE_CAR ( c.id_four, '-FR')) 'Prestataire',
		'' 'Commentaire Prestataire',
		Lower( -- [VDOC26230]
			sysadm.FN_EPURE_CHAINE (
			Case 
				When sysadm.FN_CLE_VAL ( 'SWAP_AUTO_CTR', c.info_frn_spb_cplt, ';' ) = 'OUI' And sysadm.FN_CLE_VAL ( 'NEUF_REC', c.info_frn_spb_cplt, ';' ) = 'NEU'
					Then 'Remplacement => swap NEUF sur irréparable couvert'
				When sysadm.FN_CLE_VAL ( 'SWAP_AUTO_CTR', c.info_frn_spb_cplt, ';' ) = 'OUI' And sysadm.FN_CLE_VAL ( 'NEUF_REC', c.info_frn_spb_cplt, ';' ) = 'REC'
					Then 'Remplacement => swap RECOND. sur irréparable couvert'
				When sysadm.FN_CLE_VAL ( 'SWAP_AUTO_CTR', c.info_frn_spb_cplt, ';' ) = 'OUI' 
					Then 'Remplacement => swap (??) sur irréparable couvert'
				When c.status_gc = 21 And sysadm.FN_CLE_VAL ( 'APP_SWAP', c.info_frn_spb_cplt, ';' ) = 'OUI'
					Then 'Réparation => Irréparable couvert, swapé'
				-- [VDOC27123]BVID/BVIP/BVIT
				When c.status_gc = 21 And ( CharIndex ( '[BVIE]', c.comment_frn ) > 0 Or CharIndex ( '[BVID]', c.comment_frn ) > 0 Or CharIndex ( '[BVIP]', c.comment_frn ) > 0 OR CharIndex ( '[BVIT]', c.comment_frn ) > 0 )
					Then 'Réparation => Irréparable couvert'
				-- [VDOC27123]BVID/BVIP/BVIT
				When c.status_gc = 21 And CharIndex ( '[BVIE]', c.comment_frn ) <= 0 And CharIndex ( '[BVID]', c.comment_frn ) <= 0 And CharIndex ( '[BVIP]', c.comment_frn ) <= 0 And CharIndex ( '[BVIT]', c.comment_frn ) <= 0 
					Then 'Réparation => Irréparable non couvert'
				When c.status_gc = 2 
					Then 'Réparation => Réparé'
				When c.status_gc = 153 
					Then 'Réparation => Imei différent'
				When c.status_gc = 154 
					Then 'Réparation => Imei illisible'
				When c.status_gc = 178 And sysadm.FN_CLE_VAL ( 'NEUF_REC', c.info_spb_frn_cplt, ';' ) = 'NEU'
					Then 'Remplacement => Effectué (NEUF)'
				When c.status_gc = 178 And sysadm.FN_CLE_VAL ( 'NEUF_REC', c.info_spb_frn_cplt, ';' ) = 'REC'
					Then 'Remplacement => Effectué (RECOND.)'
				When c.status_gc = 178 
					Then 'Remplacement => Effectué (??)'
				When c.status_gc = 176
					Then 'Remplacement => Non honoré'
				When c.status_gc = 0
					Then 'Aucune décision'
				Else 'Autre (' + Convert ( varchar, c.status_gc ) + ')'

			End 
			  )
			+ 
			Case 
				When r.mt_tot_reg < 0 And r.cod_mot_reg = 'RM' And r.cod_mode_reg = 'FM' Then ' (avoir)'
				else ''
			End 
			) 'Info sur la prestation',
		rtrim ( ltrim ( s.marq_port ) ) + ' ' + rtrim ( ltrim ( s.modl_port ) ) 'Motif Prestation',
		sysadm.FN_AFF_DATE ( c.dte_rcp_frn, 'SH' ) 'Date de récéption',
		Round ( Convert ( money, r.mt_tot_reg / 1.2), 2 ) 'Tarif HT', -- [TVA]-- [VDOC26230]
		r.mt_tot_reg 'Tarif TTC',-- [VDOC26230]
		rtrim ( s.marq_port ) 'Marque Appareil Sinistré',  -- [VDOC26634]
		rtrim ( s.modl_port ) 'Modèle Appareil Sinistré', -- [VDOC26634]
		'voir zone << info sur la prestation >>' 'Etat Appareil Sinistré Conforme à la déclaration', -- [VDOC26634]
		Case 
			When sysadm.FN_CLE_VAL ( 'SWAP_AUTO_CTR', c.info_frn_spb_cplt, ';' ) = 'OUI'
				Then rtrim ( c.id_marq_art )
			When c.id_four = 'O2M' and c.id_typ_art not in ( 'PRS', 'EDI' ) 
				Then rtrim ( c.id_marq_art_ifr )
			Else ''
		End 'Marque Remplacement', -- [VDOC25841]
		Case 
			When sysadm.FN_CLE_VAL ( 'SWAP_AUTO_CTR', c.info_frn_spb_cplt, ';' ) = 'OUI'
				Then rtrim ( c.id_modl_art )
			When c.id_four = 'O2M' and c.id_typ_art not in ( 'PRS', 'EDI' ) 
				Then rtrim ( c.id_modl_art_ifr )
			Else ''
		End 'Modèle Remplacement',-- [VDOC25841]
		IsNull ( 
			Case 
				When c.id_four = 'PSM' and id_typ_art = 'PRS' Then ''
				Else rtrim ( c.id_serie_nouv )
			End , '' ) 'Référence Appareil Remplacement', -- [VDOC26634]
		IsNull ( rtrim ( c.id_bon_transp ), '' ) 'Bon de transport',
		rtrim ( sysadm.FN_AFF_DATE ( c.dte_env_cli, 'SH' )) 'Date de la prestation', -- [VDOC26634]
		rtrim (sysadm.FN_LIB_POLICE ( s.id_sin )) 'Lib_police', -- [VDOC25841]
		IsNull ( 
			Case 
				When sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', c.info_spb_frn_cplt, ';') = 'OUI' then '1er REBOND REPA'
				When sysadm.FN_CLE_VAL ( 'A_CONTROLER_SAV', c.info_spb_frn_cplt, ';') = 'OUI' then '2ème REBOND REPA'
				When sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', c.info_spb_frn_cplt, ';') = 'OUI' then 'REBOND REMPL'
			End , '') 'Rebond' -- [VDOC26230]
From sysadm.reglement r,
	 sysadm.sinistre s,
	 sysadm.det_pro dp,
	 sysadm.commande c,
	 sysadm.detail d,
	 sysadm.inter i,
	 sysadm.personne p
Where dp.id_code_dp = 252
And   s.id_prod = dp.id_prod
And   r.id_sin = s.id_sin
And   r.dte_reg between @dtDteDeb  and @dtDteFin
And   r.cod_mot_reg in ( 'RN', 'RM', 'RP')
And   d.id_sin = r.id_sin
And   (d.id_reg = r.id_reg or d.id_reg=r.id_reg_base)
and   c.id_sin = d.id_sin
And   c.id_gti = d.id_gti
And   c.id_detail = d.id_detail
And   c.id_four in ( 'PSM', 'O2M')  -- [PC151259-3]
And   c.id_typ_art <> 'EDI'
And   i.id_sin = r.id_sin
And   i.id_i = r.id_i
And   i.id_four in ( 'PSM', 'O2M')  -- [PC151259-3]
And   p.id_ordre = s.id_ordre

-- + Union pour les regl RN/RM/RP PSM non relié à une presta sur nouveau détail
Union 
Select	rtrim (sysadm.FN_AFF_DATE ( r.dte_reg, 'SH' )) 'Période de facturation',
		rtrim (d.num_facture) 'N° de Facturation',
		rtrim (s.id_contrat_abonne ) 'N° Adhésion ADVISE',
		rtrim (Convert ( Varchar, s.id_sin )) 'N° Dossier sinistre externe',
		'' 'N° Sinistre ADVISE',
		rtrim (s.num_imei_port) 'IMEI',
		rtrim (p.nom )'Nom Client',
		rtrim (p.prenom )'Prénom Client',
		rtrim (sysadm.FN_CODE_CAR ( i.id_four, '-FR')) 'Prestataire',
		'' 'Commentaire Prestataire',
		Lower( -- [VDOC26230]
					sysadm.FN_EPURE_CHAINE (
			Case 
				When r.cod_mot_reg = 'RN'
					Then 'Réglement fournisseur normal'
				When r.cod_mot_reg = 'RM'
					Then 'Mouvement financier négatif'
				When r.cod_mot_reg = 'RP'
					Then 'Mouvement financier positif'
				Else 'Autre (' + rtrim( r.cod_mot_reg )+ ')'
			End )
			 )'Info sur la prestation',
		rtrim ( ltrim ( s.marq_port ) ) + ' ' + rtrim ( ltrim ( s.modl_port ) ) 'Motif Prestation',
		'' 'Date de récéption',
		Round ( Convert ( money, r.mt_tot_reg / 1.2), 2 ) 'Tarif HT', -- [TVA]
		r.mt_tot_reg 'Tarif TTC',
		'' , -- [VDOC25841]
		'',  -- [VDOC25841]
		'' , -- [VDOC26634]
		'' , -- [VDOC26634]
		'',  -- [VDOC25841]
		'',  -- [VDOC25841]
		'',  -- [VDOC25841]
		'',  -- [VDOC26634]
		rtrim (sysadm.FN_LIB_POLICE ( s.id_sin )), -- [VDOC25841]
		'' -- [VDOC26230]

From sysadm.reglement r,
	 sysadm.sinistre s,
	 sysadm.det_pro dp,
	 sysadm.inter i,
	 sysadm.personne p,
	 sysadm.detail d
Where dp.id_code_dp = 252
And   s.id_prod = dp.id_prod
And   r.id_sin = s.id_sin
And   r.dte_reg between @dtDteDeb  and @dtDteFin
And   r.cod_mot_reg in ( 'RN', 'RM', 'RP')
And   d.id_sin = r.id_sin
And   (d.id_reg = r.id_reg or d.id_reg=r.id_reg_base)
And   Not Exists ( 
			Select Top 1 1 
			From   sysadm.commande c
			Where c.id_sin = d.id_sin
			And   c.id_gti = d.id_gti
			And   c.id_detail = d.id_detail
			And   c.id_four in ( 'PSM', 'O2M')  -- [PC151259-3]
		)
And   i.id_sin = r.id_sin
And   i.id_i = r.id_i
And   i.id_four in ( 'PSM', 'O2M')  -- [PC151259-3]
And   p.id_ordre = s.id_ordre

Order by 'N° Sinistre ADVISE'

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_VDOC21987
-- Auteur               :       FPI
-- Date                 :       07/07/2017
-- Libellé              :        
-- Commentaires         :       [VDoc23962] automatisation de la VDoc 21987
-- Références           :       
--
--	
-- Arguments            :      @sListeIdSin		Varchar(8000)            (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- 09/12/2019  JFF  VDOC28791
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_VDOC21987' AND type = 'P' )
        DROP procedure sysadm.PS_S01_VDOC21987
GO


CREATE procedure sysadm.PS_S01_VDOC21987
	@sListeIdSin	Varchar(8000)
As

Declare @dcIdSin Decimal ( 10 ) 
Declare @iIdSeq Int

Declare @t TABLE (ordre_fic integer identity,
				  id_sin    Decimal (10),  
				  id_seq	int
				   )
Declare @iPos int, @iPos2 int
Declare @sIdSin varchar(10)

-- Décomposition en table
While LEN(@sListeIdSin) > 0
Begin
	set @iPos=charindex(',',@sListeIdSin)
	If @iPos=0 
	Begin
		Set @iPos2=charindex('-',@sListeIdSin)
		If @iPos2 > 0
		Begin
			Set @dcIdSin = CONVERT ( Decimal ( 10 ) , Left(@sListeIdSin, @iPos2 - 1) ) -- [PI062]
			Set @iIdSeq = Convert(int, SUBSTRING(@sListeIdSin,@iPos2+1, LEN(@sListeIdSin)))
		End
		set @sListeIdSin=''
	End 
	Else
	Begin
		Set @iPos2=charindex('-',@sListeIdSin)
		If @iPos2 > 0
		Begin
			Set @dcIdSin = CONVERT ( Decimal ( 10 ) , Left(@sListeIdSin,@iPos2 - 1) ) -- [PI062]
			Set @iIdSeq = Convert(int,SUBSTRING(@sListeIdSin,@iPos2+1, @iPos - @iPos2 - 1))
		End 
		Set @sListeIdSin=SUBSTRING(@sListeIdSin,@iPos+1,LEN(@sListeIdSin))
	End
	
	insert into @t (id_sin, id_seq) values (@dcIdSin,@iIdSeq)
End

select convert(varchar(10),s.id_sin) + '-' + convert(varchar(3),c.id_seq) as 'N° DOSSIER SINISTRE SPB',
	s.id_prod as 'CODE PRODUIT SPB', 
	sysadm.FN_LIB_PROD(s.id_prod) as 'LIBELLE PRODUIT SPB',
	p.nom as 'NOM DE L ASSURE',
	p.prenom as 'PRENOM DE L ASSURE',
	rtrim(c.adr_livr1) + ' ' + isnull(rtrim(c.adr_livr2),'') + ' - ' + c.adr_cp + ' ' + rtrim(c.adr_ville) as 'ADRESSE POSTALE DE L ASSURE',
	s.marq_port as 'MARQUE DE L APPAREIL SINISTRE',
	s.modl_port as 'MODELE DE L APPAREIL SINISTRE',
	s.num_imei_port as 'NUMERO DE SERIE OU IMEI',
	Case When sysadm.FN_A_COMMANDER(c.id_sin, c.id_seq, null)='A_COMMANDER' Then 'Commande'
		Else c.id_ref_four End as 'TYPE ACTION  DEMANDEE PAR SPB',
	c.dte_env_cli as 'DATE DE FIN DE PRESTATION',
	Case When sysadm.FN_A_COMMANDER(c.id_sin, c.id_seq, null)='A_COMMANDER' Then 'Oui'
		Else 'Non' End as 'REMPLACEMENT',
	s.dte_ach_port as 'DATE ACHAT',
	s.dte_surv as 'DATE SURVENANCE',
	sysadm.FN_CODE_CAR(d.val_car,'-AR') as 'TYPE APPAREIL',
	sysadm.FN_CODE_NUM(c.status_gc,'-GC')  as 'LIBELLE ACTION EFFECTUEE',
	sysadm.FN_LIB_CIE(s.id_sin) as Assureur,
	sysadm.FN_CLE_VAL ('NUM_CC_ELD', rtrim ( c.info_spb_frn_cplt ), ';')  as 'NUMERO CARTE CADEAU' -- VDOC28791
from @t t
	inner join sysadm.sinistre s on s.id_sin=t.id_sin
	inner join sysadm.personne p on p.id_ordre=s.id_ordre
	inner join sysadm.commande c on c.id_sin=t.id_sin and c.id_seq=t.id_seq
	inner join sysadm.div_sin d on d.id_sin=s.id_sin
where d.nom_zone='type_app'
order by ordre_fic

Go
grant execute on sysadm.PS_S01_VDOC21987 to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            :       DW_S_ETAT_PC874_1_ONLY_ZEN_OMTTEL_1
-- Auteur               :       JFF
-- Date                 :       02/01/2018
-- Libellé              :       
-- Commentaires         :       Cmde Rempl s.id_ets in ( 1004, 1005 )
-- Références           :       [PC874-1]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_ETAT_PC874_1_ONLY_ZEN_OMTTEL_1' AND type = 'P' )
        DROP procedure sysadm.DW_S_ETAT_PC874_1_ONLY_ZEN_OMTTEL_1
GO

CREATE procedure sysadm.DW_S_ETAT_PC874_1_ONLY_ZEN_OMTTEL_1
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS
Select	@dtDteDeb 'Période_Deb',
		@dtDteFin 'Période_Fin',
		s.id_prod 'Code_Produit_Sinistre',
		s.cod_opt 'Option_souscrite',
		s.id_ets  'ets',
		s.id_sin  'Numéro_dossier_sinistre',
		c.id_seq  'Numéro_de_prestation',
		p.nom     'Nom_de_l_assuré', 
		p.prenom  'Prénom_de_l_assuré',
		s.marq_port 'Marque_app_sinistré',
		s.modl_port 'Modèle_app_sinistré',
		sysadm.FN_CODE_NUM ( c.id_gti, '-GA' ) 'Garantie_ouverte',
		sysadm.FN_AFF_DATE ( c.cree_le, 'SH' ) 'Date_prise_en_charge',
		c.mt_ttc_cmde 'Montant_de_prise_en_charge',
		sysadm.FN_CODE_CAR ( c.cod_etat, '-EC' ) 'Etat_presta',
		sysadm.FN_AFF_DATE ( c.cree_le, 'SH' ) 'Date_fermeture_presta'

From	sysadm.det_pro dp,
		sysadm.commande c,
		sysadm.sinistre s,
		sysadm.personne p
Where   dp.id_code_dp = 94
And     sysadm.FN_CLE_VAL ( 'COD_DW', dp.val_car, ';') = 'd_l_fact_pc874_1_OMTTEL_1'
And		s.id_prod = dp.id_prod
And		s.id_ets in ( 1004, 1005 )
And     c.id_sin = s.id_sin
And     c.id_four = 'OMT'
And		c.cod_etat = 'RPC'
And		c.id_typ_art = 'CAF'
And		c.cree_le between @dtDteDeb and @dtDteFin -- car pas de dte_env_cli
And     p.id_ordre = s.id_ordre

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S_ETAT_PC874_1_ONLY_ZEN_OMTTEL_2
-- Auteur               :       JFF
-- Date                 :       02/01/2018
-- Libellé              :       
-- Commentaires         :       Cmde Rempl s.id_ets not in ( 1004, 1005 )
-- Références           :       [PC874-1]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_ETAT_PC874_1_ONLY_ZEN_OMTTEL_2' AND type = 'P' )
        DROP procedure sysadm.DW_S_ETAT_PC874_1_ONLY_ZEN_OMTTEL_2
GO

CREATE procedure sysadm.DW_S_ETAT_PC874_1_ONLY_ZEN_OMTTEL_2
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS
Select	@dtDteDeb 'Période_Deb',
		@dtDteFin 'Période_Fin',
		s.id_prod 'Code_Produit_Sinistre',
		s.cod_opt 'Option_souscrite',
		s.id_ets  'ets',
		s.id_sin  'Numéro_dossier_sinistre',
		c.id_seq  'Numéro_de_prestation',
		p.nom     'Nom_de_l_assuré', 
		p.prenom  'Prénom_de_l_assuré',
		s.marq_port 'Marque_app_sinistré',
		s.modl_port 'Modèle_app_sinistré',
		sysadm.FN_CODE_NUM ( c.id_gti, '-GA' ) 'Garantie_ouverte',
		sysadm.FN_AFF_DATE ( c.cree_le, 'SH' ) 'Date_prise_en_charge',
		c.mt_ttc_cmde 'Montant_de_prise_en_charge',
		sysadm.FN_CODE_CAR ( c.cod_etat, '-EC' ) 'Etat_presta',
		sysadm.FN_AFF_DATE ( c.cree_le, 'SH' ) 'Date_fermeture_presta'

From	sysadm.det_pro dp,
		sysadm.commande c,
		sysadm.sinistre s,
		sysadm.personne p
Where   dp.id_code_dp = 94
And     sysadm.FN_CLE_VAL ( 'COD_DW', dp.val_car, ';') = 'd_l_fact_pc874_1_OMTTEL_2'
And		s.id_prod = dp.id_prod
And		s.id_ets not in ( 1004, 1005 )
And     c.id_sin = s.id_sin
And     c.id_four = 'OMT'
And		c.cod_etat = 'RPC'
And		c.id_typ_art = 'CAF'
And		c.cree_le between @dtDteDeb and @dtDteFin -- car pas de dte_env_cli
And     p.id_ordre = s.id_ordre

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S_ETAT_PC874_1_ONLY_ZEN_OMTTEL_3
-- Auteur               :       JFF
-- Date                 :       02/01/2018
-- Libellé              :       
-- Commentaires         :       Les réparations
-- Références           :       [PC874-1]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S_ETAT_PC874_1_ONLY_ZEN_OMTTEL_3' AND type = 'P' )
        DROP procedure sysadm.DW_S_ETAT_PC874_1_ONLY_ZEN_OMTTEL_3
GO

CREATE procedure sysadm.DW_S_ETAT_PC874_1_ONLY_ZEN_OMTTEL_3
        @dtDteDeb       DateTime,
        @dtDteFin       DateTime
AS
Select	@dtDteDeb 'Période_Deb',
		@dtDteFin 'Période_Fin',
		s.id_prod 'Code_Produit_Sinistre',
		s.cod_opt 'Option_souscrite',
		s.id_ets  'ets',
		s.id_sin  'Numéro_dossier_sinistre',
		c.id_seq  'Numéro_de_prestation',
		p.nom     'Nom_de_l_assuré', 
		p.prenom  'Prénom_de_l_assuré',
		s.marq_port 'Marque_app_sinistré',
		s.modl_port 'Modèle_app_sinistré',
		sysadm.FN_CODE_NUM ( c.id_gti, '-GA' ) 'Garantie_ouverte',
		sysadm.FN_AFF_DATE ( c.cree_le, 'SH' ) 'Date_prise_en_charge',
		IsNull ( 
			(
				Select Top 1 dd.val_mt
				From sysadm.div_det dd
				Where dd.id_sin = c.id_sin
				And   dd.id_gti = c.id_gti
				And   dd.id_detail = c.id_detail
				And   dd.nom_zone = 'mt_pec'
			),0 ) 'Montant_de_prise_en_charge',
		sysadm.FN_CLE_VAL ( 'MT_PREFACT', c.info_spb_frn_cplt, ';') 'Montant_de_pré_facturation',
		sysadm.FN_CODE_CAR ( c.cod_etat, '-EC' ) 'Etat_presta',
		sysadm.FN_CODE_NUM ( c.status_gc, '-GC') 'Statut_presta',
		sysadm.FN_AFF_DATE ( c.dte_env_cli, 'SH' ) 'Date_fermeture_presta'

From	sysadm.det_pro dp,
		sysadm.commande c,
		sysadm.sinistre s,
		sysadm.personne p
Where   dp.id_code_dp = 94
And     sysadm.FN_CLE_VAL ( 'COD_DW', dp.val_car, ';') = 'd_l_fact_pc874_1_OMTTEL_3'
And		s.id_prod = dp.id_prod
And     c.id_sin = s.id_sin
And     c.id_four = 'OMT'
And		c.cod_etat in ( 'RPC', 'RFO' ) 
And		c.id_typ_art = 'PRS'
And		c.cree_le between @dtDteDeb and @dtDteFin -- car pas de dte_env_cli
And     p.id_ordre = s.id_ordre

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_VDOC25758
-- Auteur               :       FPI
-- Date                 :       21/02/2018
-- Libellé              :        
-- Commentaires         :       [VDoc25758] automatisation de la VDoc 21670
-- Références           :       
--
--	
-- Arguments            :      @sListeNumCarte		Varchar(8000)            (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_VDOC25758' AND type = 'P' )
        DROP procedure sysadm.PS_S01_VDOC25758
GO

CREATE procedure sysadm.PS_S01_VDOC25758
	@sListeNumCarte	Varchar(8000)
As

Declare @t TABLE (ordre_fic integer identity,
				  num_carte    varchar(30))
				  
Declare @iPos int, @iPos2 int
Declare @sNumCarte varchar(30)

-- Décomposition en table
While LEN(@sListeNumCarte) > 0
Begin
	set @iPos=charindex(',',@sListeNumCarte)
	If @iPos=0 
	Begin
		Set @sNumCarte = @sListeNumCarte
		set @sListeNumCarte=''
	End 
	Else
	Begin
		Set @sNumCarte = Left(@sListeNumCarte,@iPos - 1)
		Set @sListeNumCarte=SUBSTRING(@sListeNumCarte,@iPos+1,LEN(@sListeNumCarte))
	End
	
	insert into @t (num_carte) values (@sNumCarte)
End

select c.id_cmd_frn as num_carte,c.id_sin, c.id_seq, sysadm.FN_CODE_CAR(c.cod_etat,'-EC') as etat_cmd,
	r.id_reg, r.dte_reg, r.mt_tot_reg
from @t t
	inner join sysadm.commande c on c.id_cmd_frn=t.num_carte
inner join sysadm.detail d on d.id_sin=c.id_sin and d.id_gti=c.id_gti and d.id_detail=c.id_detail
left outer join sysadm.reglement r on r.id_sin=c.id_sin and (r.id_reg=d.id_reg or r.id_reg_base=d.id_reg)
where c.id_four='AUC'
order by ordre_fic, r.id_sin, r.id_reg

Go

grant execute on sysadm.PS_S01_VDOC25758 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM462_1_EXTR_PF_RF
-- Auteur               :       JFF
-- Date                 :       07/11/2019
-- Libellé              :        
-- Commentaires         :       [PM462-1]
-- Références           :       
--
--	
-- Arguments            :      
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM462_1_EXTR_PF_RF' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM462_1_EXTR_PF_RF
GO

CREATE procedure sysadm.PS_S_PM462_1_EXTR_PF_RF
	@dtDteDeb       DateTime,
    @dtDteFin       DateTime
As

Select s.id_prod,
	   sysadm.FN_LIB_PROD ( id_prod ),
	   r.id_sin,
	   r.id_reg,
	   r.lib_reg,
	   r.dte_reg,
	   sysadm.FN_CODE_CAR ( r.cod_inter, '-IN' ) + '(' + r.cod_inter + ')' 'cod_inter',
	   sysadm.FN_CODE_CAR ( r.cod_mode_reg, '-MR' ) + '(' + r.cod_mode_reg + ')' 'cod_mode_reg',
	   sysadm.FN_CODE_CAR ( r.cod_mot_reg, '-MO' ) + '(' + r.cod_mot_reg + ')' 'cod_mot_reg',
	   r.id_reg_base,
	   r.valide_le,
	   r.valide_par

From   sysadm.reglement r,
	   sysadm.sinistre  s,
	   sysadm.inter     i
Where  r.cree_le between @dtDteDeb and @dtDteFin
And    r.cod_mot_reg in ( 'PF', 'RF' )
And    s.id_sin = r.id_sin
And    i.id_sin = r.id_sin
And    i.id_i   = r.id_i

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_STAT_REFUS_VDOC29595
-- Auteur               :       JFF
-- Date                 :       03/09/2020
-- Libellé              :        
-- Commentaires         :       [PS_S_STAT_REFUS_VDOC29595]
-- Références           :       
--
--	
-- Arguments            :      
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_STAT_REFUS_VDOC29595' AND type = 'P' )
        DROP procedure sysadm.PS_S_STAT_REFUS_VDOC29595
GO

CREATE procedure sysadm.PS_S_STAT_REFUS_VDOC29595
    @dtDteFin       DateTime
As

Select Convert ( Varchar ( 4 ), Year ( a.cree_le)) +  Right ( '00' + Convert ( Varchar ( 4 ), Month ( a.cree_le )), 2 )  'Période_(mois)',	
	   '''' + Upper ( Left ( DateName ( month, a.cree_le ),1)) + Right ( DateName ( month, a.cree_le ), Len ( DateName ( month, a.cree_le ) ) -1) + ' ' + Convert ( varchar ( 20), Year ( a.cree_le ) ) 'lib_mois',
	   a.id_sin 'Identifiant_sinistre',
	   a.id_cour 'Identification courrier',
	   a.id_prod 'Identification produits',
	   p.lib_long 'lib_produit',
	   a.id_cour_orig 'Identification courrier d’origine',
	   sysadm.FN_CODE_CAR ( a.id_cour_orig, '-CC' ) 'Lib_courrier',
	   a.valide_par 'Trigramme',
	   ( Select rtrim ( o.nom ) + ' ' + rtrim ( o.prenom ) From [LS-SINISTRES].SESAME_PRO.sysadm.operateur o with (nolock) where o.id_oper = a.valide_par ) 'Nom_Gestionnaire',
	   sysadm.FN_CODE_NUM (  ds.val_nbre, '-ET' )  'Etat_dos_vu_assuré',
	   sysadm.FN_CODE_NUM ( s.cod_etat, '-ET' )  'Etat_vu_assureur'
	
From sysadm.archive a with (nolock),	
	 sysadm.produit p with (nolock),
	 sysadm.sinistre s with (nolock),
	 sysadm.div_sin ds with (nolock)
	 
Where p.id_grp = 254	
And   a.id_prod = p.id_prod	
And   a.cree_le between DateAdd ( year, -1, @dtDteFin ) and @dtDteFin	
And   s.id_sin = a.id_sin 	
And   ds.id_sin = a.id_sin	
And   ds.nom_zone = 'etat_vu_assure'	
And   ds.val_nbre in ( 200, 1530 )	
And   Not exists ( Select Top 1 1 From sysadm.commande c with (nolock) where c.id_sin = s.id_sin )	
And   Not exists ( Select Top 1 1 From sysadm.div_det dd with (nolock) where dd.id_sin = s.id_sin and dd.nom_zone = 'pec' and dd.val_car = 'O' ) 	
Order by 1	

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM425_COURRIER_EDT_EXTERNALISEES
-- Auteur               :       JFF
-- Date                 :       23/11/2020
-- Libellé              :        
-- Commentaires         :       [PM425-1]
-- Références           :       
--
--	
-- Arguments            :      
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM425_COURRIER_EDT_EXTERNALISEES' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM425_COURRIER_EDT_EXTERNALISEES
GO

CREATE procedure sysadm.PS_S_PM425_COURRIER_EDT_EXTERNALISEES
	@dtDteDeb       DateTime,
    @dtDteFin       DateTime
As

Select	id_cle,
		id_sin,
		id_i,
		id_doc,
		id_arch,
		id_lot,
		type_fichier,
		format_sortie,
		chemin,
		fichier_sortie,
		nbre_page_tot,
		id_typ_doc,
		fond_page,
		lib_cie,
		lib_grp,
		nom,
		adr_1,
		adr_2,
		adr_cp,
		adr_ville,
		cree_le,
		maj_le,
		maj_par

From   sysadm.trace_edt_decentralisee_pm425 with (nolock)
Where  cree_le between @dtDteDeb and @dtDteFin

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM450_PEC_PRBLE_LIVRAISON
-- Auteur               :       JFF
-- Date                 :       21/12/2020
-- Libellé              :        
-- Commentaires         :       [PM450-1]
-- Références           :       
--
--	
-- Arguments            :      
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM450_PEC_PRBLE_LIVRAISON' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM450_PEC_PRBLE_LIVRAISON
GO

CREATE procedure sysadm.PS_S_PM450_PEC_PRBLE_LIVRAISON
	@dtDteDeb       DateTime,
    @dtDteFin       DateTime
As

Select	
	vtc.cree_le 'dte_maj_presta_sur_1_des_2_zones',
	sysadm.FN_CLE_VAL ( 'PRBLE_LIVRAISON', c.info_frn_spb_cplt, ';' ) 'prble_livraison',
	Case sysadm.FN_CLE_VAL ( 'PRBLE_LIVRAISON', c.info_frn_spb_cplt, ';' ) 
		When 'COLIS_PND' Then 'Colis en PND (NPAI)'
		When 'COLIS_NRPAC' Then 'Colis non réclamé par le client'
		When 'COLIS_PERDU' Then 'Colis perdu'
		When 'COLIS_BALNI' Then 'Colis non remis, boites aux lettres non identifiables'	-- [DT111]
		When 'COLIS_INCOR' Then 'Colis non remis,Adresse Incorrecte'	-- [DT111]
		When 'COLIS_REFUS' Then 'Colis refusé par client'	-- [DT111]
		When 'ANNUL_REFAIT' Then 'Colis annulé et refait'	-- [DT111]
		When 'EN_ATTENTE' Then 'Colis en attente' -- [DT288-4]
		When 'AUTRE' Then 'Autre'	-- [DT111]
		When 'J1' Then 'Demande SPB , restituée au client' -- [vDoc26518]
		When 'J2' Then 'Réparé, restitué client' -- [vDoc26518]
		When 'J3' Then 'Refus SAV,restitué au client' -- [vDoc26518]
		When 'J4' Then 'Perte Produit par le PSM' -- [vDoc26518]
		When 'J5' Then 'Perte Produit par le PSM' -- [vDoc26518]
		When 'J6' Then 'Produit déjà expédié vers SPBS' -- [vDoc26518]
		Else sysadm.FN_CLE_VAL ( 'PBRLE_LIVRAISON', c.info_frn_spb_cplt, ';' )  + '(valeur non décodée)'
	End 'lib_prble_livraison',
	IsNull ( nullif ( rtrim ( ltrim ( Upper ( sysadm.FN_CLE_VAL ( 'PEC_PRBLE_LIVRAISON', c.info_frn_spb_cplt, ';' )))), ''), 'NON') 'pec_prble_livraison',
	c.id_sin,
	c.id_seq,
	c.id_gti,
	c.id_detail,
	c.id_four,
	sysadm.FN_CODE_CAR ( c.id_four, '-FR' ) 'lib_four',
	c.id_typ_art,
	sysadm.FN_CODE_CAR ( c.id_typ_art, '-AR' ) 'lib_typ_art',
	c.id_marq_art,
	c.id_modl_art,
	c.mt_ttc_cmde,
	c.adr_nom,
	c.adr_prenom,
	c.adr_livr1,
	c.adr_livr2,
	c.adr_livr_cpl,
	c.adr_cp,
	c.adr_ville,
	c.adr_tel1,
	c.adr_tel2,
	c.adr_tel3,
	c.id_serie_anc,
	c.probleme,
	c.id_cmd_frn,
	c.id_serie_nouv,
	c.id_bon_transp,
	c.dte_rcp_frn,
	c.dte_env_cli,
	c.cod_etat,
	sysadm.FN_CODE_CAR ( c.cod_etat, '-EC'), 
	c.comment_frn,
	c.nom_gest,
	c.id_lot_cmd,
	c.cmd_gen_le,
	c.cmd_gen_par,
	c.cree_le,
	c.maj_le,
	c.maj_par,
	c.valide_le,
	c.valide_par,
	c.adr_cod_civ,
	c.id_ref_four,
	c.status_gc,
	sysadm.FN_CODE_NUM ( c.status_gc, '-GC') 'lib_status_gc',
	c.adrfc_nom 'transporteur',
	c.dte_rcp_mob_cli,
	c.info_spb_frn,
	sysadm.FN_CODE_NUM ( c.info_spb_frn, '-IF') 'lib_info_spb_frn',
	c.id_marq_art_ifr,
	c.id_modl_art_ifr,
	c.info_spb_frn_cplt,
	c.info_frn_spb_cplt

From   sysadm.v_trace_cmde vtc with (nolock),
	   sysadm.commande c with (nolock)
Where  vtc.cree_le between @dtDteDeb and @dtDteFin
And    vtc.nom_zone in ( 'prble_livraison', 'pec_prble_livraison' )
And    vtc.cree_le = 
			( Select max ( vtc2.cree_le )
			  From   sysadm.v_trace_cmde vtc2
			  Where  vtc2.id_sin = vtc.id_sin
			  And    vtc2.id_seq = vtc.id_seq
			  And    vtc2.cree_le between @dtDteDeb and @dtDteFin
			  And    vtc2.nom_zone in ( 'prble_livraison', 'pec_prble_livraison' ) 
			)
And    c.id_sin = vtc.id_sin
And    c.id_seq = vtc.id_seq
Order by vtc.cree_le 
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RS1465_STAT_FORCAGE
-- Auteur               :       JFF
-- Date                 :       06/12/2021
-- Libellé              :        
-- Commentaires         :       [RS1465]
-- Références           :       
--
--	
-- Arguments            :      
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RS1465_STAT_FORCAGE' AND type = 'P' )
        DROP procedure sysadm.PS_S_RS1465_STAT_FORCAGE
GO

CREATE procedure sysadm.PS_S_RS1465_STAT_FORCAGE
	@dtDteDeb       DateTime,
    @dtDteFin       DateTime
As

-- Forçage Refus par niveau
Select 'Forçage de refus par niveau utilisateur vs niveau produit' 'Type_forcage',
	   s.id_prod,
	   sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_prod',
	   sysadm.FN_LIB_POLE ( s.id_prod ) 'lib_pole',	
	   g.id_sin,
	   g.id_gti,
	   -1 'id_detail',
	   sysadm.FN_CODE_NUM ( g.id_gti, '-GA' ) 'lib_gti',
		( 
		   Select stuff ( 
					( SELECT Distinct ', (' + CAST(rtrim ( r.id_motif ) AS VARCHAR(250)) +') ' + CAST(rtrim ( sysadm.FN_CODE_NUM ( r.id_motif, '+RE' ) ) AS VARCHAR(250)) 
					  FROM sysadm.refus r
					  Where r.id_sin = g.id_sin
					  And   r.alt_mac = 'O'
					  For XML PATH ('') )
				, 1, 2, '' ))  'Liste_Refus_Forcee',
	   'Décision machine : ' + sysadm.FN_CODE_NUM ( g.cod_dec_mac, '-ET' ) + ' / Décision forcée par l''opérateur : ' + sysadm.FN_CODE_NUM ( g.cod_etat, '-ET' ) 'Action_Forcage',
	   g.valide_le 'Dernière_validation',
	   g.valide_par 'Valide_par',
	   ( Select rtrim ( nom) + ' ' + rtrim ( prenom ) from [SQL14BI\SINISTRESBI].SESAME_PRO.sysadm.operateur where id_oper = g.valide_par ) 'Nom_valideur',
	   'Le système refusait la garantie, mais l''utilisateur par son niveau par rapport au niveau du produit, a pu priviligié la décision du détail de garantie qui demander à règler' 'Infomation_Forcage',
	   'Le dernier valideur n''est pas forcément celui qui a forcé' 'Information_sur_dernier_valideur'

From sysadm.gar_sin g with (nolock ),
	 sysadm.sinistre s with (nolock )
Where g.cod_etat in ( 550, 600 )
And   g.cod_dec_mac <> g.cod_etat
And   g.cod_dec_mac = 200
And   g.valide_le between @dtDteDeb and @dtDteFin
And   s.id_sin = g.id_sin
Union all 
-- Forçage Prise en charge
Select 'Forçage de prise en charge par niveau utilisateur vs niveau produit' 'Type_forcage',
	   s.id_prod,
	   sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_prod',
	   sysadm.FN_LIB_POLE ( s.id_prod ) 'lib_pole',	
	   dvpd.id_sin,
	   dvpd.id_gti,
	   dvpd.id_detail,
	   sysadm.FN_CODE_NUM ( dvpd.id_gti, '-GA' ) 'lib_gti',
	   'Non concerné',
	   'L''utilisateur a coché le forçage de prise en charge sur le détail de garantie.' 'Action_Forcage',
	   dvpd.valide_le 'Dernière_validation',
	   dvpd.valide_par 'Valide_par',
	   ( Select rtrim ( nom) + ' ' + rtrim ( prenom ) from [SQL14BI\SINISTRESBI].SESAME_PRO.sysadm.operateur where id_oper = dvpd.valide_par ) 'Nom_valideur',
	   'Le système donnait un montant de PEC après plafond de 0.00€ ou bien le montant donné ne convenait pas (positif mais trop bas), l''utilisateur a forcé la PEC et évenuellement mis son propre montant de PEC.' 'Infomation_Forcage',
	   'Le dernier valideur n''est pas forcément celui qui a forcé'

From sysadm.div_det dvpd with (nolock ),
	 sysadm.sinistre s with (nolock )
Where dvpd.nom_zone = 'alt_pec'
And   dvpd.val_car = 'O'
And   dvpd.valide_le between @dtDteDeb and @dtDteFin
And   s.id_sin = dvpd.id_sin
Union all
-- Forçage de règlement
Select 'Forçage de règlement par niveau utilisateur vs niveau produit' 'Type_forcage',
	   s.id_prod,
	   sysadm.FN_LIB_PROD ( s.id_prod ) 'lib_prod',
	   sysadm.FN_LIB_POLE ( s.id_prod ) 'lib_pole',	
	   det.id_sin,
	   det.id_gti,
	   det.id_detail,
	   sysadm.FN_CODE_NUM ( det.id_gti, '-GA' ) 'lib_gti',
	   'Non concerné',
	   'L''utilisateur a coché le forçage de règlement sur le détail de garantie.' 'Action_Forcage',
	   det.valide_le 'Dernière_validation',
	   det.valide_par 'Valide_par',
	   ( Select rtrim ( nom) + ' ' + rtrim ( prenom ) from [SQL14BI\SINISTRESBI].SESAME_PRO.sysadm.operateur where id_oper = det.valide_par ) 'Nom_valideur',
	   'Le système donnait un montant de règlement après plafond de 0.00€ ou bien le montant donné ne convenait pas (positif mais trop bas), l''utilisateur a forcé le règlement et mis son propre montant de règlement.' 'Infomation_Forcage',
	   'Le dernier valideur n''est pas forcément celui qui a forcé'

From sysadm.detail det with (nolock ),
	 sysadm.sinistre s with (nolock )
Where det.alt_reg = 'O'
And   det.valide_le between @dtDteDeb and @dtDteFin
And   s.id_sin = det.id_sin
Order by 5,8,7
-- Order by 7,2,3,4

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RS1423_VOLUME_CORUS_MOIS
-- Auteur               :       JFF
-- Date                 :       22/12/2021
-- Libellé              :        
-- Commentaires         :       [RS1423]
-- Références           :       
--
--	
-- Arguments            :      
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RS1423_VOLUME_CORUS_MOIS' AND type = 'P' )
        DROP procedure sysadm.PS_S_RS1423_VOLUME_CORUS_MOIS
GO

CREATE procedure sysadm.PS_S_RS1423_VOLUME_CORUS_MOIS
	@dtDteDeb       DateTime,
    @dtDteFin       DateTime
As

Set @dtDteDeb = '01/08/2020' -- Date du début de CORUS

-- Par mois
Select TB.Mois,
	   DateName ( month, '01/' + Right ( TB.Mois, 2) + '/2021' ) + ' ' + Left ( TB.Mois, 4 ) 'Libellé', 
	   Sum ( Nbre_Vers_CORUS ) 'Nbre_Vers_CORUS',
	   Sum ( Nbre_Edité_Chez_SPB ) 'Nbre_Edité_Chez_SPB',
	   Sum ( Nbre_parti_par_Mail ) 'Nbre_parti_par_Mail',
	   Sum ( Nbre_Vers_CORUS ) + Sum ( Nbre_Edité_Chez_SPB ) + Sum ( Nbre_parti_par_Mail ) 'Som_Tot_Courrier'
From 
(
	Select  Convert ( varchar ( 4), Year ( dte_edit )) + Right( '00' + Convert ( varchar ( 2), Month ( dte_edit )), 2 )  'Mois',
			Case 
			When exists ( 
					Select Top 1 1 
					From sysadm.trace_edt_decentralisee_pm425 te with (nolock)
					Where te.id_sin = a.id_sin
					And   te.id_i   = a.id_inter
					And   te.id_doc = a.id_doc
				) Then 1
			Else 0
			End 'Nbre_Vers_CORUS',
			Case 
			When Not exists ( 
					Select Top 1 1 
					From sysadm.trace_edt_decentralisee_pm425 te with (nolock)
					Where te.id_sin = a.id_sin
					And   te.id_i   = a.id_inter
					And   te.id_doc = a.id_doc
				) And
				( a.id_canal is null Or a.id_canal = 'CO' )
				Then 1
			Else 0
			End 'Nbre_Edité_Chez_SPB',
			Case 
			When Not exists ( 
					Select Top 1 1 
					From sysadm.trace_edt_decentralisee_pm425 te with (nolock)
					Where te.id_sin = a.id_sin
					And   te.id_i   = a.id_inter
					And   te.id_doc = a.id_doc
				) And
				( a.id_canal = 'MA' )
				Then 1
			Else 0
			End 'Nbre_parti_par_Mail'
	from sysadm.archive a with ( nolock )
	Where dte_edit between @dtDteDeb and @dtDteFin
	And   dte_conf is null
	Union all
	Select  Convert ( varchar ( 4), Year ( dte_conf )) + Right( '00' + Convert ( varchar ( 2), Month ( dte_conf )), 2 )  'Mois',
			Case 
			When exists ( 
					Select Top 1 1 
					From sysadm.trace_edt_decentralisee_pm425 te with (nolock)
					Where te.id_sin = a.id_sin
					And   te.id_i   = a.id_inter
					And   te.id_doc = a.id_doc
				) Then 1
			Else 0
			End 'Nbre_Vers_CORUS',
			Case 
			When Not exists ( 
					Select Top 1 1 
					From sysadm.trace_edt_decentralisee_pm425 te with (nolock)
					Where te.id_sin = a.id_sin
					And   te.id_i   = a.id_inter
					And   te.id_doc = a.id_doc
				) And
				( a.id_canal is null Or a.id_canal = 'CO' )
				Then 1
			Else 0
			End 'Nbre_Edité_Chez_SPB',
			Case 
			When Not exists ( 
					Select Top 1 1 
					From sysadm.trace_edt_decentralisee_pm425 te with (nolock)
					Where te.id_sin = a.id_sin
					And   te.id_i   = a.id_inter
					And   te.id_doc = a.id_doc
				) And
				( a.id_canal = 'MA' )
				Then 1
			Else 0
			End 'Nbre_parti_par_Mail'
	from sysadm.archive a with ( nolock )
	Where dte_conf between @dtDteDeb and @dtDteFin
) as TB
Group by TB.Mois
Order by TB.Mois desc

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_LISTE_PROD_ASSUREUR_2
-- Auteur               :       JFF
-- Date                 :       22/12/2021
-- Libellé              :        
-- Commentaires         :       [RS1423]
-- Références           :       
--
--	
-- Arguments            :      
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_LISTE_PROD_ASSUREUR_2' AND type = 'P' )
        DROP procedure sysadm.PS_S_LISTE_PROD_ASSUREUR_2
GO

CREATE procedure sysadm.PS_S_LISTE_PROD_ASSUREUR_2
As

Select * from sysadm.v_produit_2
Order by id_prod, id_rev, id_gti


Go



--------------------------------------------------------------------
--
-- Procédure            :       PS_S_LISTE_TOUS_FOURNISSEURS
-- Auteur               :       JFF
-- Date                 :       08/06/2022
-- Libellé              :        
-- Commentaires         :       
-- Références           :       
--
--	
-- Arguments            :      
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_LISTE_TOUS_FOURNISSEURS' AND type = 'P' )
        DROP procedure sysadm.PS_S_LISTE_TOUS_FOURNISSEURS
GO

CREATE procedure sysadm.PS_S_LISTE_TOUS_FOURNISSEURS
As

Select sysadm.FN_AFF_DATE ( Getdate(), 'SH' )  'Date_Extraction',
	   rtrim ( cc.id_code ) id_four_reel ,
	   rtrim ( cc.lib_code ) lib_four_reel ,
	   IsNull ( rtrim ( a.id_bq ), '' )  id_four_factu, 
	   IsNull ( rtrim ( a.id_ag ), '' )  id_four_factu_chapeau,
	   IsNull ( sysadm.FN_CODE_CAR ( a.id_ag, '-FR' ), '' ) lib_four_chapeau,
	   IsNull ( rtrim ( a.adr_1 ), '' ) adresse_factu_1,
	   IsNull ( rtrim ( a.adr_2 ), '' ) adresse_factu_2,
	   IsNull ( rtrim ( a.adr_ville ), '' ) adresse_ville,
	   IsNull ( rtrim ( a.lib_ag ), '' ) autre_ref_1,
	   IsNull ( rtrim ( a.lib_service ), '' ) autre_ref_2
from   sysadm.code_car cc
	   Left outer join sysadm.agence a On a.id_bq = cc.id_code
Where  cc.id_typ_code = '-FR'
Order by 4, 1

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_GT_UE_ET_HORS_UE
-- Auteur               :       JFF
-- Date                 :       08/06/2022
-- Libellé              :        
-- Commentaires         :       
-- Références           :       
--
--	
-- Arguments            :      
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_GT_UE_ET_HORS_UE' AND type = 'P' )
        DROP procedure sysadm.PS_S_GT_UE_ET_HORS_UE
GO

CREATE procedure sysadm.PS_S_GT_UE_ET_HORS_UE
As

Declare @sSql VarChar ( 1000 )
Declare @sInstance VarChar ( 50 )

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Set @sInstance = ''
END 
Else
BEGIN
	Set @sInstance = '[LS-SINISTRES].'
END 

Set @sSql = '
	Select	op.id_oper, 
			RTRIM ( nom ) ''nom'', 
			RTRIM ( prenom) ''prenom'',
			Case 
				When Exists ( Select Top 1 1 From sysadm.autorisation a Where a.id_oper = op.id_oper and id_nat_oper = 31 ) Then ''GT Hors UE''
				When Exists ( Select Top 1 1 From sysadm.autorisation a Where a.id_oper = op.id_oper and id_nat_oper = 131 ) Then ''GT UE''
				Else ''GT UE''
			End ''Profil_GT''

	from ' + @sInstance + 'SESAME_PRO.sysadm.connexion co,' 
		   + @sInstance + 'SESAME_PRO.sysadm.operateur op 
	where co.id_appli = ''SIM8''
	and op.id_oper = co.id_oper'

Exec ( @sSql ) 

Go

