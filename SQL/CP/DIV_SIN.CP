
-------------------------------------------------------------------
--
-- Fichier              :       DIV_SIN.CP
-- Auteur               :       FABRY JF
-- Date                 :       17/06/2004
--
-- Commentaires         :       Gestion de la table DIV_SIN
--
-- Procédures           :       PS_I01_DIV_SIN_VAL
--				PS_U01_DIV_SIN_VAL	
--				DW_S01_DIV_SIN
--				
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_DIV_SIN_VAL
-- Auteur               :       FABRY JF
-- Date                 :       17/06/2004
-- Libellé              :        
-- Commentaires         :       Insertion dans la table DIV_SIN
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_DIV_SIN_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_DIV_SIN_VAL
GO

CREATE procedure sysadm.PS_I01_DIV_SIN_VAL
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

 INSERT INTO    sysadm.div_sin
	(	div_sin.id_sin,
		div_sin.nom_zone,
		div_sin.lib_label,
		div_sin.id_typ_liste,
		div_sin.alt_liste_codecar,
		div_sin.id_typ_zone,
		div_sin.alt_oblig,
		div_sin.alt_prot,
		div_sin.cpt_tri,
		div_sin.val_nbre,
		div_sin.val_mt,
		div_sin.val_dte,
		div_sin.val_car,
		div_sin.cree_le,
		div_sin.maj_le,
		div_sin.maj_par,
		div_sin.valide_le,
		div_sin.valide_par
	)
 SELECT         w_div_sin.id_sin,
		w_div_sin.nom_zone,
		w_div_sin.lib_label,
		w_div_sin.id_typ_liste,
		w_div_sin.alt_liste_codecar,
		w_div_sin.id_typ_zone,
		w_div_sin.alt_oblig,
		w_div_sin.alt_prot,
		w_div_sin.cpt_tri,
		w_div_sin.val_nbre,
		w_div_sin.val_mt,
		w_div_sin.val_dte,
		w_div_sin.val_car,
		w_div_sin.cree_le,
		w_div_sin.maj_le,		
		w_div_sin.maj_par,		
                @dtValideLe,
                @sCodOper
 FROM           sysadm.w_div_sin
 WHERE          w_div_sin.id_sin = @dcIdSin 
 AND		w_div_sin.cpt_valide = 0

 Return @@Error

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_U01_DIV_SIN_VAL
-- Auteur               :       FABRY JF
-- Date                 :       17/06/2004
-- Libellé              :        
-- Commentaires         :       Modification dans la table DIV_SIN (Compl‚ment)
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_DIV_SIN_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U01_DIV_SIN_VAL
GO


CREATE procedure sysadm.PS_U01_DIV_SIN_VAL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS
 UPDATE sysadm.div_sin
 SET    
	sysadm.div_sin.id_sin			= sysadm.w_div_sin.id_sin,
	sysadm.div_sin.nom_zone			= sysadm.w_div_sin.nom_zone,
	sysadm.div_sin.lib_label		= sysadm.w_div_sin.lib_label,
	sysadm.div_sin.id_typ_liste		= sysadm.w_div_sin.id_typ_liste,
	sysadm.div_sin.alt_liste_codecar	= sysadm.w_div_sin.alt_liste_codecar,
	sysadm.div_sin.id_typ_zone		= sysadm.w_div_sin.id_typ_zone,
	sysadm.div_sin.alt_oblig		= sysadm.w_div_sin.alt_oblig,
	sysadm.div_sin.alt_prot			= sysadm.w_div_sin.alt_prot,
	sysadm.div_sin.cpt_tri			= sysadm.w_div_sin.cpt_tri,
	sysadm.div_sin.val_nbre			= sysadm.w_div_sin.val_nbre,
	sysadm.div_sin.val_mt			= sysadm.w_div_sin.val_mt,
	sysadm.div_sin.val_dte			= sysadm.w_div_sin.val_dte,
	sysadm.div_sin.val_car			= sysadm.w_div_sin.val_car,
	sysadm.div_sin.cree_le			= sysadm.w_div_sin.cree_le,
	sysadm.div_sin.maj_le			= sysadm.w_div_sin.maj_le,
	sysadm.div_sin.maj_par			= sysadm.w_div_sin.maj_par,
 	sysadm.div_sin.valide_le		= @dtValideLe,
	sysadm.div_sin.valide_par		= @sCodOper
 FROM   sysadm.div_sin,
        sysadm.w_div_sin
 WHERE  w_div_sin.id_sin         = @dcIdSin              AND
        div_sin.id_sin           = w_div_sin.id_sin      AND
        div_sin.nom_zone         = w_div_sin.nom_zone    AND
        w_div_sin.cpt_valide     > 0

 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_DIV_SIN
-- Auteur               :       FABRY JF
-- Date                 :       15/06/2004
-- Libellé              :        
-- Commentaires         :       Select sur la table DIV_SIN
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DIV_SIN' AND type = 'P' )
        DROP procedure sysadm.DW_S01_DIV_SIN
GO

CREATE procedure sysadm.DW_S01_DIV_SIN
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

Select 
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
	maj_par
From 	sysadm.div_sin
Where	id_sin = @dcIdSin

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_DIV_SIN_ETAT_ASS
-- Auteur               :       FABRY JF
-- Date                 :       19/11/2014
-- Libellé              :       [VDOC15650]
-- Commentaires         :       Insertion Etat vu assuré.
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DIV_SIN_ETAT_ASS' AND type = 'P' )
        DROP procedure sysadm.PS_I_DIV_SIN_ETAT_ASS
GO

CREATE procedure sysadm.PS_I_DIV_SIN_ETAT_ASS
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper		VarChar ( 10 )
AS

Declare @iEtatAss Integer
Declare @iPresentDivSin Integer

Select @iEtatAss = sysadm.FN_LIB_ETAT_DOS_ASSURE ( @dcIdSin, 'CODE' )
Set @iPresentDivSin = 0


If Exists ( Select	Top 1 1
			From	sysadm.div_sin ds
			Where	ds.id_sin = @dcIdSin
			And		nom_zone = 'etat_vu_assure'
		   )
	Begin
		Update	sysadm.div_sin
		Set		val_nbre = @iEtatAss, 
				maj_le = GETDATE (),
				maj_par = @sCodOper,
				valide_le = GETDATE (),
				valide_par = @sCodOper
		Where	id_sin = @dcIdSin
		And		nom_zone = 'etat_vu_assure'
		
		If @@Rowcount > 0 Set @iPresentDivSin = 1
		
	End 
Else
	Begin 
	
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
		values  
			(
				@dcIdSin,
				'etat_vu_assure',
				'Etat dossier vu de l''assuré',
				'-ET',
				'N',
				'LN',
				'N',
				'N',
				5000,
				@iEtatAss,
				null,
				null,
				null,
				GETDATE (),
				GETDATE (),
				@sCodOper,
				GETDATE (),
				@sCodOper
			)
			
			If @@Rowcount > 0 Set @iPresentDivSin = 1

	End 	

If Exists ( Select	Top 1 1
			From	sysadm.w_sin s
			Where	s.id_sin = @dcIdSin
		   )
	Begin


		If Exists ( Select	Top 1 1
					From	sysadm.w_div_sin ds
					Where	ds.id_sin = @dcIdSin
					And		nom_zone = 'etat_vu_assure'
				   )
			Begin
				Update	sysadm.w_div_sin
				Set		val_nbre = @iEtatAss, 
						maj_le = GETDATE (),
						maj_par = @sCodOper
				Where	id_sin = @dcIdSin
				And		nom_zone = 'etat_vu_assure'
			End 
		Else
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
				values  
					(
						@dcIdSin,
						'etat_vu_assure',
						'Etat dossier vu de l''assuré',
						'-ET',
						'N',
						'LN',
						'N',
						'N',
						5000,
						@iEtatAss,
						null,
						null,
						null,
						@iPresentDivSin,
						GETDATE (),
						GETDATE (),
						@sCodOper
					)
			End 	
	End
Go

grant execute on sysadm.PS_I_DIV_SIN_ETAT_ASS to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_PAIEMENT_ADH_PAYBOX_PC694_4
-- Auteur               :       FABRY JF
-- Date                 :       13/10/2015
-- Libellé              :       [PC694-4]
-- Commentaires         :       Appelé par J.Lebair sur PayBox
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      01/06/2018   [PC151425-1]
-- JFF      26/09/2023   [RS5928_FRCH_CHQ]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PAIEMENT_ADH_PAYBOX_PC694_4' AND type = 'P' )
        DROP procedure sysadm.PS_I_PAIEMENT_ADH_PAYBOX_PC694_4
GO

CREATE procedure sysadm.PS_I_PAIEMENT_ADH_PAYBOX_PC694_4
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCas			VarChar ( 1 ), -- (L)ire, (E)crire
        @Chaine			VarChar ( 255 ) OUTPUT, -- PAIEMENT_PAYBOX=OUI
        @iIdProdAdh		Integer OUTPUT,
        @iIdEts			Integer OUTPUT,
        @sIdAdh			VarChar ( 19 ) OUTPUT,
        @iIdsDos		Integer OUTPUT,
        @sAdrMail		VarChar ( 100 ) OUTPUT
        
AS

Declare @sMess	VarChar ( 2000 )
Declare @sValidePar VarChar ( 10 )
Declare @sErr		Varchar(60)
Declare @iIdCt		integer	
Declare @iIdPce     integer	
Declare @lCodePceAdh integer
Declare @lCodePcePBox integer
Declare @lPceAdhADemander integer
Declare @lPcePBoxADemander integer
Declare @lCodOpt integer
Declare @sMtFranchise VarChar ( 50 )
Declare @dtDteEffFrPBox DateTime
Declare @dtCreeLeDos DateTime
Declare @dtValideLe DateTime
Declare @sModePBox VarChar ( 50 )

Set @dtValideLe = GetDate()
Set @lCodePceAdh = 0 
Set @lCodePcePBox = 0 
Set @lPceAdhADemander = 0 
Set @lPcePBoxADemander = 0 

-- [PC151425-1]
If sysadm.FN_CLE_NUMERIQUE ( 'PC151425-1') > 0 
 Begin
	-- Lire
	If UPPER ( @sCas ) = 'L' 
	 Begin

		-- [PC151425-1]
		Select  @dtDteEffFrPBox = sysadm.FN_CLE_VAL ( 'DTE_EFFET_FRANCHISE_PBOX', rtrim ( val_car), ';' ),
				@dtCreeLeDos    = ws.cree_le
		From	sysadm.det_pro dp,
				sysadm.w_sin ws
		Where  ws.id_sin = @dcIdSin
		And    dp.id_prod = ws.id_prod
		And    dp.id_code_dp = 291

		-- [PC151425-1]
		Select @lCodePceAdh = sysadm.FN_CLE_VAL ( 'CODE_PCE', rtrim ( val_car), ';' ) 
		From   sysadm.det_pro dp,
			   sysadm.w_sin ws
		Where  ws.id_sin = @dcIdSin
		And    dp.id_prod = ws.id_prod
		And    dp.id_code_dp = 291

		-- [PC151425-1]
		Select @lCodePcePBox = sysadm.FN_CLE_VAL ( 'CODE_PCE_PB', rtrim ( val_car), ';' ) 
		From   sysadm.det_pro dp,
			   sysadm.w_sin ws
		Where  ws.id_sin = @dcIdSin
		And    dp.id_prod = ws.id_prod
		And    dp.id_code_dp = 291

		-- [PC151425-1]
		If Exists ( 
				Select Top 1 1 
				From sysadm.w_piece wp
				Where wp.id_sin = @dcIdSin
				And   wp.id_pce = @lCodePceAdh
		   )
		   Begin
				Set @lPceAdhADemander = 1
		   End 

		-- [PC151425-1]
		If Exists ( 
				Select Top 1 1 
				From sysadm.w_piece wp
				Where wp.id_sin = @dcIdSin
				And   wp.id_pce = @lCodePcePBox
		   )
		   Begin
				Set @lPcePBoxADemander = 1
		   End 

		-- [PC151425-1]

		If @dtCreeLeDos < @dtDteEffFrPBox
		  Begin
			Set @lPcePBoxADemander = 0
		  End 

		If @lPceAdhADemander = 1 And @lPcePBoxADemander = 1 Set @Chaine = 'MODE_PAYBOX=CPLT_ADH_ET_FRANCHISE'
		If @lPceAdhADemander = 0 And @lPcePBoxADemander = 1 Set @Chaine = 'MODE_PAYBOX=FRANCHISE_SEULE'
		If @lPceAdhADemander = 1 And @lPcePBoxADemander = 0 Set @Chaine = 'MODE_PAYBOX=CPLT_ADH_SEUL'

		If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @dcIdSin  )	
			Begin
			If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'mode_paybox' )
				Begin
				Update sysadm.w_div_sin Set val_car = sysadm.FN_CLE_VAL ( 'MODE_PAYBOX', @Chaine, ';' ) , maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'mode_paybox'
				End 
			Else
				Begin	 
				Insert into sysadm.w_div_sin values ( @dcIdSin, 'mode_paybox', 'Type paiement PayBox', '-1', 'N', 'C', 'N', 'N', 118, null, null, null, sysadm.FN_CLE_VAL ( 'MODE_PAYBOX', @Chaine, ';' ), 1, getdate(), getdate(), 'AUTO' ) 
				End
			End

		If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @dcIdSin  )	
			Begin
			If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'mode_paybox')
				Begin
				Update sysadm.div_sin Set val_car = sysadm.FN_CLE_VAL ( 'MODE_PAYBOX', @Chaine, ';' ) , maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'mode_paybox'
				End 
			Else
				Begin	 
				Insert into sysadm.div_sin values ( @dcIdSin, 'mode_paybox', 'Type paiement PayBox', '-1', 'N', 'C', 'N', 'N', 118, null, null, null, sysadm.FN_CLE_VAL ( 'MODE_PAYBOX', @Chaine, ';' ), getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
				End
			End

		Select	@lCodOpt = ws.cod_opt
		From	sysadm.w_sin ws
		Where   ws.id_sin = @dcIdSin

		Select @sMtFranchise = Convert ( VarChar, IsNull ( min ( f.mt_fra ), 0 ) )
		From  sysadm.franchise f,
			  sysadm.w_sin ws,
			  sysadm.w_gar_sin wg
		Where ws.id_sin = @dcIdSin
		And   wg.id_sin = ws.id_sin
		And   f.id_prod = ws.id_prod
		And	  f.id_rev  = ws.id_rev
		And   f.id_gti  = wg.id_gti
		And   f.id_typ_fra = 5

		If @sMtFranchise is null Set @sMtFranchise = '0'

		If @lPcePBoxADemander > 0 
			Begin
				Set @Chaine = sysadm.FN_CLE_VAL_E ( 'MT_FRANCHISE', @sMtFranchise, rtrim ( @Chaine ), ';' )

				If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @dcIdSin  )	
					Begin
					If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'mt_franchise_paybox' )
						Begin
						Update sysadm.w_div_sin Set val_mt = convert ( decimal ( 11,2), @sMtFranchise ), maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'mt_franchise_paybox'
						End 
					Else
						Begin	 
						Insert into sysadm.w_div_sin values ( @dcIdSin, 'mt_franchise_paybox', 'Mt Franchise demandée par PayBox', '-1', 'N', 'S', 'N', 'N', 119, null, convert ( decimal ( 11,2), @sMtFranchise ), null, null, 1, getdate(), getdate(), 'AUTO' ) 
						End
					End

				If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @dcIdSin  )	
					Begin
					If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'mt_franchise_paybox')
						Begin
						Update sysadm.div_sin Set val_mt = convert ( decimal ( 11,2), @sMtFranchise ) , maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'mt_franchise_paybox'
						End 
					Else
						Begin	 
						Insert into sysadm.div_sin values ( @dcIdSin, 'mt_franchise_paybox', 'Mt Franchise demandée par PayBox', '-1', 'N', 'S', 'N', 'N', 119, null, convert ( decimal ( 11,2), @sMtFranchise ), null, null, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
						End
					End
			End 

		-- [PC151425-1]
		Select  @iIdProdAdh = p.cod_prod_dms,
				@iIdEts = s.id_ets,
				@sIdAdh = s.id_adh,
				@iIdsDos = s.id_sdos,
				@sAdrMail = ( Select i.adr_mail 
							  From	 sysadm.inter i
							  Where  i.id_sin = @dcIdSin
							  And	 i.cod_inter = 'A' ),
				@Chaine = @Chaine -- [PC151425-1] Ajout zone. Prévenir EW pour le select
		From	sysadm.sinistre s,
				sysadm.produit p
		Where   s.id_sin = @dcIdSin	
		And		p.id_prod = s.id_prod
	 End 

	-- Ecrire
	If UPPER ( @sCas ) = 'E' 
	 Begin

		If sysadm.FN_CLE_VAL ( 'PAIEMENT_PAYBOX', @Chaine, ';') = 'OUI'
		  Begin

			Select @sModePBox = sysadm.FN_GET_DIV_SIN ( @dcIdSin, 'mode_paybox', 'P', '' )
			If @sModePBox is null set @sModePBox = ''

			If @sModePBox in ( '', 'CPLT_ADH_ET_FRANCHISE', 'CPLT_ADH_SEUL' ) 
				Begin

					If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @dcIdSin  )	
					  Begin
						If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'dte_cmplt_adh_paye_ass_paybox' )
						 Begin
						   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'dte_cmplt_adh_paye_ass_paybox'
						 End 
						Else
						 Begin	 
						   Insert into sysadm.w_div_sin values ( @dcIdSin, 'dte_cmplt_adh_paye_ass_paybox', 'Cmplt paiem.adh assuré par PayBox', '-1', 'N', 'D', 'N', 'N', 120, null, null, getdate(), null, 1, getdate(), getdate(), 'AUTO' ) 
						 End
					  End

					If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @dcIdSin  )	
					  Begin
						If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'dte_cmplt_adh_paye_ass_paybox')
						 Begin
						   Update sysadm.div_sin Set val_dte = GETDATE() , maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'dte_cmplt_adh_paye_ass_paybox'
						 End 
						Else
						 Begin	 
						   Insert into sysadm.div_sin values ( @dcIdSin, 'dte_cmplt_adh_paye_ass_paybox', 'Cmplt paiem.adh assuré par PayBox', '-1', 'N', 'D', 'N', 'N', 120, null, null, GETDATE(), null, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
						 End
					  End

					Select @iIdPce = Convert( integer, sysadm.FN_CLE_VAL ( 'CODE_PCE', dp.val_car, ';'))
					From   sysadm.sinistre s,
							sysadm.det_pro  dp
					Where  s.id_sin = @dcIdSin
					And    dp.id_prod = s.id_prod
					And    dp.id_code_dp = 291
	  
					Delete w_piece Where id_sin = @dcIdSin and id_pce = @iIdPce 
				End 

			If @sModePBox in ( '', 'CPLT_ADH_ET_FRANCHISE', 'FRANCHISE_SEULE' ) 
				Begin

					If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @dcIdSin  )	
					  Begin
						If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'dte_franchise_paye_ass_paybox' )
						 Begin
						   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'dte_franchise_paye_ass_paybox'
						 End 
						Else
						 Begin	 
						   Insert into sysadm.w_div_sin values ( @dcIdSin, 'dte_franchise_paye_ass_paybox', 'Franchise payée par PayBox', '-1', 'N', 'D', 'N', 'N', 121, null, null, getdate(), null, 1, getdate(), getdate(), 'AUTO' ) 
						 End
					  End

					If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @dcIdSin  )	
					  Begin
						If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'dte_franchise_paye_ass_paybox')
						 Begin
						   Update sysadm.div_sin Set val_dte = GETDATE() , maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'dte_franchise_paye_ass_paybox'
						 End 
						Else
						 Begin	 
						   Insert into sysadm.div_sin values ( @dcIdSin, 'dte_franchise_paye_ass_paybox', 'Franchise payée par PayBox', '-1', 'N', 'D', 'N', 'N', 121, null, null, GETDATE(), null, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
						 End
					  End

					If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @dcIdSin  )	
					  Begin
						If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'mode_paiement' )
						 Begin
						   Update sysadm.w_div_sin Set val_car = 'CB', maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'mode_paiement'
						 End 
						Else
						 Begin	 
						   Insert into sysadm.w_div_sin values ( @dcIdSin, 'mode_paiement', 'Mode de paiement franchise', '-WB', 'O', 'LC', 'N', 'O', 122, null, null, null, 'CB', 1, getdate(), getdate(), 'AUTO' ) 
						 End
					  End

					If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @dcIdSin  )	
					  Begin
						If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'mode_paiement')
						 Begin
						   Update sysadm.div_sin Set val_car = 'CB' , maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'mode_paiement'
						 End 
						Else
						 Begin	 
						   Insert into sysadm.div_sin values ( @dcIdSin, 'mode_paiement', 'Mode de paiement franchise', '-WB', 'O', 'LC', 'N', 'O', 122, null, null, null, 'CB', getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
						 End
					  End

					If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @dcIdSin  )	
					  Begin
						If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'franchise_paybox' )
						 Begin
						   Update sysadm.w_div_sin Set val_car = 'O', maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'franchise_paybox'
						 End 
						Else
						 Begin	 
						   Insert into sysadm.w_div_sin values ( @dcIdSin, 'franchise_paybox', 'Paiement franchise Paybox', '-1', 'N', 'X', 'N', 'N', 123, null, null, null, 'O', 1, getdate(), getdate(), 'AUTO' ) 
						 End
					  End

					If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @dcIdSin  )	
					  Begin
						If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'franchise_paybox')
						 Begin
						   Update sysadm.div_sin Set val_car = 'O' , maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'franchise_paybox'
						 End 
						Else
						 Begin	 
						   Insert into sysadm.div_sin values ( @dcIdSin, 'franchise_paybox', 'Paiement franchise Paybox', '-1', 'N', 'X', 'N', 'N', 123, null, null, null, 'O', getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
						 End
					  End


					Select @iIdPce = Convert( integer, sysadm.FN_CLE_VAL ( 'CODE_PCE_PB', dp.val_car, ';'))
					From   sysadm.sinistre s,
							sysadm.det_pro  dp
					Where  s.id_sin = @dcIdSin
					And    dp.id_prod = s.id_prod
					And    dp.id_code_dp = 291
	  
					Delete w_piece Where id_sin = @dcIdSin and id_pce = @iIdPce 
				End 


			Exec sysadm.PS_IU_PIECE_HISTO @dcIdSin, @dtValideLe

			Select @sValidePar = s.valide_par
			From	 sysadm.sinistre s
			Where  s.id_sin = @dcIdSin 
			
			If @sModePBox = 'CPLT_ADH_ET_FRANCHISE' Set @sMess = 'L''assuré vient d''effectuer le complèment de règlement de son adhésion ET le paiement de sa franchise via PayBox, vous pouvez poursuivre l''instruction du dossier'
			If @sModePBox = 'CPLT_ADH_SEUL' Set @sMess = 'L''assuré vient d''effectuer le complèment de règlement de son adhésion via PayBox, vous pouvez poursuivre l''instruction du dossier'
			If @sModePBox = 'FRANCHISE_SEULE' Set @sMess = 'L''assuré vient d''effectuer le paiement de sa franchise via PayBox, vous pouvez poursuivre l''instruction du dossier'

			IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
			BEGIN
				EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sMess, @sValidePar, @sErr output, @iIdCt OUTPUT , NULL, 'C'
			END
			ELSE
			BEGIN
				EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sMess, @sValidePar, @sErr output, @iIdCt OUTPUT , NULL, 'C'
			END
		End	  		 
	 End 


 End 
Else 
 Begin
	-- Lire
	If UPPER ( @sCas ) = 'L' 
	 Begin
		Select  @iIdProdAdh = p.cod_prod_dms,
				@iIdEts = s.id_ets,
				@sIdAdh = s.id_adh,
				@iIdsDos = s.id_sdos,
				@sAdrMail = ( Select i.adr_mail 
							  From	 sysadm.inter i
							  Where  i.id_sin = @dcIdSin
							  And	 i.cod_inter = 'A' )
		From	sysadm.sinistre s,
				sysadm.produit p
		Where   s.id_sin = @dcIdSin	
		And		p.id_prod = s.id_prod
	 End 

	-- Ecrire
	If UPPER ( @sCas ) = 'E' 
	 Begin

		If sysadm.FN_CLE_VAL ( 'PAIEMENT_PAYBOX', @Chaine, ';') = 'OUI'
		  Begin
			If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @dcIdSin  )	
			  Begin
				If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'dte_cmplt_adh_paye_ass_paybox' )
				 Begin
				   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'dte_cmplt_adh_paye_ass_paybox'
				 End 
				Else
				 Begin	 
				   Insert into sysadm.w_div_sin values ( @dcIdSin, 'dte_cmplt_adh_paye_ass_paybox', 'Cmplt paiem.adh assuré par PayBox', '-1', 'N', 'D', 'N', 'N', 120, null, null, getdate(), null, 1, getdate(), getdate(), 'AUTO' ) 
				 End
			  End

			If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @dcIdSin  )	
			  Begin
				If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'dte_cmplt_adh_paye_ass_paybox')
				 Begin
				   Update sysadm.div_sin Set val_dte = GETDATE() , maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'dte_cmplt_adh_paye_ass_paybox'
				 End 
				Else
				 Begin	 
				   Insert into sysadm.div_sin values ( @dcIdSin, 'dte_cmplt_adh_paye_ass_paybox', 'Cmplt paiem.adh assuré par PayBox', '-1', 'N', 'D', 'N', 'N', 120, null, null, GETDATE(), null, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
				 End
			  End

			-- [RS5928_FRCH_CHQ]
			If sysadm.FN_CLE_NUMERIQUE ( 'RS5928_FRCH_CHQ') > 0 
			 Begin
				If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @dcIdSin  )	
					Begin
					If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'mode_paiement' )
						Begin
						Update sysadm.w_div_sin Set val_car = 'CB', maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'mode_paiement'
						End 
					Else
						Begin	 
						Insert into sysadm.w_div_sin values ( @dcIdSin, 'mode_paiement', 'Mode de paiement franchise', '-WO', 'O', 'LC', 'N', 'O', 122, null, null, null, 'CB', 1, getdate(), getdate(), 'AUTO' ) 
						End
					End

				If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @dcIdSin  )	
					Begin
					If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'mode_paiement')
						Begin
						Update sysadm.div_sin Set val_car = 'CB' , maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = 'mode_paiement'
						End 
					Else
						Begin	 
						Insert into sysadm.div_sin values ( @dcIdSin, 'mode_paiement', 'Mode de paiement franchise', '-WO', 'O', 'LC', 'N', 'O', 122, null, null, null, 'CB', getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
						End
					End
			 End 

		  End

		  Select @iIdPce = Convert( integer, sysadm.FN_CLE_VAL ( 'CODE_PCE', dp.val_car, ';'))
		  From   sysadm.sinistre s,
				 sysadm.det_pro  dp
		  Where  s.id_sin = @dcIdSin
		  And    dp.id_prod = s.id_prod
		  And    dp.id_code_dp = 291
	  
		  Delete w_piece Where id_sin = @dcIdSin and id_pce = @iIdPce 

		  Select @sValidePar = s.valide_par
		  From	 sysadm.sinistre s
		  Where  s.id_sin = @dcIdSin 
	
		Set @sMess = 'L''assuré vient d''effectuer le complèment de règlement de son adhésion via PayBox, vous pouvez poursuivre l''instruction du dossier'
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sMess, @sValidePar, @sErr output, @iIdCt OUTPUT , NULL, 'C'
		END
		ELSE
		BEGIN
			EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sMess, @sValidePar, @sErr output, @iIdCt OUTPUT , NULL, 'C'
		END
	  		 
	 End 
 End
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_VAL_W_DIV_SIN 
-- Auteur               :       JFF
-- Date                 :       03/11/2015
-- Libellé              :        
-- Commentaires         :       [PM260]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VAL_DIV_SIN' AND type = 'P' )
        DROP procedure sysadm.PS_S_VAL_DIV_SIN
GO

CREATE procedure sysadm.PS_S_VAL_DIV_SIN
        @dcIdSin     Decimal (  10,0 ), -- [PI062]
        @sNomZone	 VarChar ( 35 ),
        @sVal		 VarChar ( 35 ) OUTPUT,
        @dtMajLe	 DateTime OUTPUT
AS

	Select  @sVal =
			rTrim (
			IsNull ( CONVERT ( VarChar (35), ws.val_nbre ), '' ) +
			IsNull ( CONVERT ( VarChar (35), ws.val_mt ), '' ) +
			IsNull ( CONVERT ( VarChar (35), ws.val_dte , 103 ), '' ) +
			IsNull ( CONVERT ( VarChar (35), ws.val_car ), '' ) ),
			@dtMajLe = ws.maj_le
	From	sysadm.div_sin ws
	Where   ws.id_sin = @dcIdSin
	And     ws.nom_zone = @sNomZone

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_D_DIV_SIN_FINALE 
-- Auteur               :       JFF
-- Date                 :       03/11/2015
-- Libellé              :        
-- Commentaires         :       [VDOC27557]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D_DIV_SIN_FINALE' AND type = 'P' )
        DROP procedure sysadm.PS_D_DIV_SIN_FINALE
GO

CREATE procedure sysadm.PS_D_DIV_SIN_FINALE
        @dcIdSin     Decimal (  10,0 ), -- [PI062]
        @sNomZone	 VarChar ( 35 )
AS

If exists ( Select Top 1 1 From sysadm.w_sin where id_sin = @dcIdSin ) 
 Begin
	Return
 End 

Delete sysadm.div_sin Where id_sin = @dcIdSin and nom_zone = @sNomZone

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_DI_RS1363_SURV_FACTU_DOS_LIES
-- Auteur               :       FABRY JF
-- Date                 :       29/11/2021
-- Libellé              :       [RS1363_SURV_FACTU]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_DI_RS1363_SURV_FACTU_DOS_LIES' AND type = 'P' )
        DROP procedure sysadm.PS_DI_RS1363_SURV_FACTU_DOS_LIES
GO

CREATE procedure sysadm.PS_DI_RS1363_SURV_FACTU_DOS_LIES
	@adcIdSin Decimal ( 10 ),
	@adcIdI   Decimal ( 7 ),
	@asCodModeReg VarChar ( 2 ),
	@asCodInter Varchar ( 1 ) ,
	@adcMtAReg  Decimal ( 11, 2 )
AS

If Not ( @asCodModeReg = 'FM' And @asCodInter = 'F' ) Return

Declare @dcIdSinWrk Decimal ( 10 )
Declare @iIdSeq Integer
Declare @sMess VarChar ( 2000 )
Declare @sErr  Varchar(60)
Declare @iIdCt integer
Declare @sLibFrn varchar ( 35 )
Declare @iTrvCree Integer
Declare @iNbreDos Integer
Declare @sAutreDossier VarChar ( 35 )
Declare @dcPremSinWrk Decimal ( 10 )

Declare @Tb Table ( 
	id_seq integer identity,
	id_sin decimal ( 10 ),
	marquage integer 
)

Insert into @Tb
Select  distinct 
		s2.id_sin,
		0
From	sysadm.sinistre s, 
		sysadm.sinistre s2,
		sysadm.div_sin ds
Where   s.id_sin = @adcIdSin
And     ( s2.id_prod = s.id_prod
		  Or 
		  Exists ( 
			Select top 1 1 
			From sysadm.det_pro dp
			Where dp.id_prod = s.id_prod
			AND   dp.id_code_dp	= 289
			AND   CHARINDEX (	'#' + CONVERT ( varchar ( 10), s2.id_prod ) + '#', dp.val_car ) > 0
		  )
		)
And     s2.id_ets = s.id_ets
And     s2.id_adh = s.id_adh
And     s2.id_sin <> s.id_sin
And     ds.id_sin = s2.id_sin
And     ds.nom_zone = 'surveillance_factu'
And     ds.val_car = 'O'


Select @sLibFrn = rtrim ( sysadm.FN_CODE_CAR ( i.id_four, '-FR' ))
From sysadm.inter i
Where i.id_sin = @adcIdSin
And   i.id_i = @adcIdI

Set @iTrvCree = 0 
Select @iNbreDos = count (*) From @Tb

While Exists ( Select Top 1 1 From @Tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSinWrk = id_sin
	From	@Tb
	Where	marquage = 0

	If @iTrvCree > 0  
	  Begin
		Set @sMess = 'Vous aviez marqué le présent dossier ' + Convert ( Varchar  ( 15 ), @dcIdSinWrk ) + ' en surveillance si un autre dossier lié à ce dossier était réglé par la cellule facturation.'
		Set @sMess = @sMess + 'Le dossier ' + Convert ( Varchar  ( 15 ), @adcIdSin ) + ' a été réglé par la cellule facturation le ' + Convert ( VarChar ( 10 ), Getdate(),103) 
		Set @sMess = @sMess + ' pour un montant de ' + Convert ( Varchar ( 20), @adcMtAReg ) + '€ au fournisseur ' + @sLibFrn + '. Ces deux dossiers ont la même adhésion. La surveillance du présent dossier ' + Convert ( Varchar  ( 15 ), @dcIdSinWrk ) + ' est donc à présent supprimée.'
		Set @sMess = @sMess + 'Aucun travail n''a été créé sur ce présent dossier, le travail ayant été créé sur le premier dossier ' + Convert ( Varchar  ( 15 ), @dcPremSinWrk ) + '.'


		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSinWrk, 2, @sMess,	'SQLS', 300, @iIdCt OUTPUT							
		END
		ELSE
		BEGIN
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSinWrk, 2, @sMess,	'SQLS', 300, @iIdCt OUTPUT							
		END	

		
	  End 

	If @iTrvCree <= 0  
	  Begin
		Set @dcPremSinWrk = @dcIdSinWrk
		Set @sMess = 'Vous aviez marqué le présent dossier ' + Convert ( Varchar  ( 15 ), @dcIdSinWrk ) + ' en surveillance si un autre dossier lié à ce dossier était réglé par la cellule facturation.'
		Set @sMess = @sMess + 'Le dossier ' + Convert ( Varchar  ( 15 ), @adcIdSin ) + ' a été réglé par la cellule facturation le ' + Convert ( VarChar ( 10 ), Getdate(),103) 
		Set @sMess = @sMess + ' pour un montant de ' + Convert ( Varchar ( 20), @adcMtAReg ) + '€ au fournisseur ' + @sLibFrn + '. Ces deux dossiers ont la même adhésion. La surveillance du présent dossier ' + Convert ( Varchar  ( 15 ), @dcIdSinWrk ) + ' est donc à présent supprimée.'

		If @iNbreDos > 1
		  Begin 
			Select @sAutreDossier = stuff ( ( SELECT Distinct ', ' + CAST(rtrim ( id_sin ) AS VARCHAR(250)) FROM @Tb Where id_sin <> @dcIdSinWrk For XML PATH ('') ), 1, 2, '' )  
			If @sAutreDossier is null Set @sAutreDossier = ''
			Set @sMess = @sMess + 'D''autre(s) dossier(s) sont concerné(s) : ' + @sAutreDossier 
			Set @sMess = @sMess + ', A vous de créer les travaux à la main après la gestion du présent dossier.'
		  End 
		Else
		  Begin
			Set @sMess = @sMess + 'Aucun autre dossier concerné.'
		  End 

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSinWrk, 2, @sMess, 'SQLS', @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END
		ELSE
		BEGIN
			EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSinWrk, 2, @sMess, 'SQLS', @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
		END

		Set @iTrvCree = 1 
	  End 


	Delete sysadm.w_div_sin where id_sin = @dcIdSinWrk and nom_zone = 'surveillance_factu'
	Delete sysadm.div_sin where id_sin = @dcIdSinWrk and nom_zone = 'surveillance_factu'

	Update @Tb Set marquage = 1 Where id_seq = @iIdSeq
 End
 
Go


