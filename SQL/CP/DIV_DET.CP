
-------------------------------------------------------------------
--
-- Fichier              :       DIV_DET.CP
-- Auteur               :       FABRY JF
-- Date                 :       03/10/2005
--
-- Commentaires         :       Gestion de la table DIV_DET
--
-- Procédures           :       PS_I01_DIV_DET_VAL
--				PS_U01_DIV_DET_VAL	
--				DW_S01_DIV_DET
--				DW_S02_DIV_DET [DCMP080371]
--				PS_S01_DIV_DET
--				
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_DIV_DET_VAL
-- Auteur               :       FABRY JF
-- Date                 :       17/06/2004
-- Libellé              :        
-- Commentaires         :       Insertion dans la table DIV_DET
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_DIV_DET_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_DIV_DET_VAL
GO

CREATE procedure sysadm.PS_I01_DIV_DET_VAL
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

 INSERT INTO    sysadm.div_det
	(	div_det.id_sin,
		div_det.id_gti,
		div_det.id_detail,
		div_det.nom_zone,
		div_det.lib_label,
		div_det.id_typ_liste,
		div_det.alt_liste_codecar,
		div_det.id_typ_zone,
		div_det.alt_oblig,
		div_det.alt_prot,
		div_det.cpt_tri,
		div_det.val_nbre,
		div_det.val_mt,
		div_det.val_dte,
		div_det.val_car,
		div_det.cree_le,
		div_det.maj_le,
		div_det.maj_par,
		div_det.valide_le,
		div_det.valide_par
	)
 SELECT         w_div_det.id_sin,
 		w_div_det.id_gti,
 		w_div_det.id_detail,
		w_div_det.nom_zone,
		w_div_det.lib_label,
		w_div_det.id_typ_liste,
		w_div_det.alt_liste_codecar,
		w_div_det.id_typ_zone,
		w_div_det.alt_oblig,
		w_div_det.alt_prot,
		w_div_det.cpt_tri,
		w_div_det.val_nbre,
		w_div_det.val_mt,
		w_div_det.val_dte,
		w_div_det.val_car,
		w_div_det.cree_le,
		w_div_det.maj_le,		
		w_div_det.maj_par,		
                @dtValideLe,
                @sCodOper
 FROM           sysadm.w_div_det
 WHERE          w_div_det.id_sin = @dcIdSin 
 AND		w_div_det.cpt_valide = 0

 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_U01_DIV_DET_VAL
-- Auteur               :       FABRY JF
-- Date                 :       17/06/2004
-- Libellé              :        
-- Commentaires         :       Modification dans la table DIV_DET (Compl‚ment)
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_DIV_DET_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U01_DIV_DET_VAL
GO

CREATE procedure sysadm.PS_U01_DIV_DET_VAL
        @dcIdSin        Decimal (  10,0 ),-- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS
 UPDATE sysadm.div_det
 SET    
	sysadm.div_det.nom_zone			= sysadm.w_div_det.nom_zone,
	sysadm.div_det.lib_label		= sysadm.w_div_det.lib_label,
	sysadm.div_det.id_typ_liste		= sysadm.w_div_det.id_typ_liste,
	sysadm.div_det.alt_liste_codecar	= sysadm.w_div_det.alt_liste_codecar,
	sysadm.div_det.id_typ_zone		= sysadm.w_div_det.id_typ_zone,
	sysadm.div_det.alt_oblig		= sysadm.w_div_det.alt_oblig,
	sysadm.div_det.alt_prot			= sysadm.w_div_det.alt_prot,
	sysadm.div_det.cpt_tri			= sysadm.w_div_det.cpt_tri,
	sysadm.div_det.val_nbre			= sysadm.w_div_det.val_nbre,
	sysadm.div_det.val_mt			= sysadm.w_div_det.val_mt,
	sysadm.div_det.val_dte			= sysadm.w_div_det.val_dte,
	sysadm.div_det.val_car			= sysadm.w_div_det.val_car,
	sysadm.div_det.cree_le			= sysadm.w_div_det.cree_le,
	sysadm.div_det.maj_le			= sysadm.w_div_det.maj_le,
	sysadm.div_det.maj_par			= sysadm.w_div_det.maj_par,
 	sysadm.div_det.valide_le		= @dtValideLe,
	sysadm.div_det.valide_par		= @sCodOper
 FROM   sysadm.div_det,
        sysadm.w_div_det
 WHERE  w_div_det.id_sin         = @dcIdSin              AND
        div_det.id_sin           = w_div_det.id_sin      AND
        div_det.id_gti           = w_div_det.id_gti      AND        
        div_det.id_detail        = w_div_det.id_detail   AND        
        div_det.nom_zone         = w_div_det.nom_zone    AND
        w_div_det.cpt_valide     > 0

 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_DIV_DET
-- Auteur               :       FABRY JF
-- Date                 :       03/10/2005
-- Libellé              :        
-- Commentaires         :       Select sur la table DIV_DET
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DIV_DET' AND type = 'P' )
        DROP procedure sysadm.DW_S01_DIV_DET
GO

CREATE procedure sysadm.DW_S01_DIV_DET
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

Select 
	id_sin,
	id_gti,
	id_detail,
	nom_zone,
	lib_label,
	id_typ_liste,
	alt_liste_codecar,
	id_typ_zone,
	alt_oblig,
	'O',
	cpt_tri,
	val_nbre,
	val_mt,
	val_dte,
	val_car,
	cree_le,
	maj_le,
	maj_par
From 	sysadm.div_det
Where	id_sin = @dcIdSin

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_DIV_DET
-- Auteur               :       FABRY JF
-- Date                 :       08/07/2008
-- Libellé              :        
-- Commentaires         :       Select sur la table DIV_DET
-- Références           :       [DCMP080371]
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_DIV_DET' AND type = 'P' )
        DROP procedure sysadm.DW_S02_DIV_DET
GO

CREATE procedure sysadm.DW_S02_DIV_DET
        @asNoteDebit as VarChar (35)
AS

Set @asNoteDebit = sysadm.FN_TRIM ( Upper ( @asNoteDebit ))

Select 	d.id_sin, 
	sysadm.FN_CODE_NUM ( d.id_gti, '-GA' ) 'lib_gti',
	d.id_detail,
	d.val_car
	
From 	sysadm.div_det d
where 	d.nom_zone like 'note_debit%'
and 	sysadm.FN_TRIM ( Upper ( d.val_car ) ) like '%' + @asNoteDebit + '%'

Union all

Select 	wd.id_sin, 
	sysadm.FN_CODE_NUM ( wd.id_gti, '-GA' ) 'lib_gti',
	wd.id_detail,
	wd.val_car
	
From 	sysadm.w_div_det wd
where	wd.nom_zone like 'note_debit%'
and 	sysadm.FN_TRIM ( Upper ( wd.val_car ) ) like '%' + @asNoteDebit + '%'

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S01_DIV_DET
-- Auteur               :       FABRY JF
-- Date                 :       10/04/2009
-- Libelle              :       
-- Commentaires         :     	[FNAC_PROD_ECH_TECH]  
-- References           :       
-- 
-- Arguments
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_DIV_DET' AND type = 'P' )
        DROP procedure sysadm.PS_S01_DIV_DET
GO


CREATE procedure sysadm.PS_S01_DIV_DET
	@dcIdSin Decimal ( 10), -- [PI062]
	@iIdSeq Integer,
	@dcMtFact Decimal ( 11,2 ),
	@sRetour Varchar ( 50 ) OUTPUT,
	@sOk Varchar ( 1 ) OUTPUT -- O ou N
	
As

/*
If @iIdSeq = 9 
	Begin
	    If  ( Select s.cree_le 
	    	from   sinistre s
	    	Where  s.id_sin = @dcIdSin ) > '06/12/2008'
	    	
	    	Begin
			Set @sOk = 'N'
			Set @sRetour = '(tiret 9 au delà du 06/12/2008, cas incohérent)'
			Return
	    	End 
	    	Else
		Begin
			Set @sOk = 'O'
			Set @sRetour = ''
			Return			
		End 

	    	
	End 
*/

If Exists (
	Select  *
	From 	sysadm.commande c,
		sysadm.div_det dd
	Where	c.id_sin = @dcIdSin
	And 	c.id_seq = @iIdSeq
	And     dd.id_sin = c.id_sin
	And     dd.id_gti = c.id_gti
	And     dd.id_detail = c.id_detail
	And 	dd.nom_zone = 'mt_pec'
	And     dd.val_mt + 5 >= @dcMtFact   -- Vu avec Maryse le 15/04, on tolère 5 Euros d'écart
	 )
	 Begin
	 	Set @sOk = 'O'
	 	Set @sRetour = ''
	 End 
Else
	 Begin
		Set @sOk = 'N'
		Set @sRetour = '(montant facture supérieur au montant de PEC)'
	 End 

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_DIV_DET_MARQUAGE_LBE
-- Auteur               :       FABRY JF
-- Date                 :       05/04/2016
-- Libelle              :       
-- Commentaires         :     	
-- References           :       
-- 
-- Arguments
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DIV_DET_MARQUAGE_LBE' AND type = 'P' )
        DROP procedure sysadm.PS_I_DIV_DET_MARQUAGE_LBE
GO

CREATE procedure sysadm.PS_I_DIV_DET_MARQUAGE_LBE
	@adcIdSin Decimal ( 10 ),
	@adcIdReg Decimal ( 7 ),
	@sCodOper VarChar (4 )
AS

If Not Exists ( 
	Select Top 1 1
	From   sysadm.reglement r,
			sysadm.detail d,
			sysadm.div_det dd
	Where  r.id_sin = @adcIdSin
	And    r.id_reg = @adcIdReg
	And    r.cod_inter = 'F'
	And    r.cod_mode_reg = 'FM'
	And    d.id_sin = r.id_sin
	And    d.id_reg = r.id_reg
	And    dd.id_sin = d.id_sin
	And    dd.id_gti = d.id_gti
	And    dd.id_detail = d.id_detail
	And    dd.nom_zone = 'pas_de_rglt_fourn'
	And    dd.val_car = 'O' )
		
	Begin

		Insert into sysadm.div_det 
		select d.id_sin,
				d.id_gti,
				d.id_detail,
				'pas_de_rglt_fourn', 
				'Pas de rglt fournisseur', 
				'-1',
				'N',
				'X', 
				'N', 
				'N',
				500,
				null,
				null,
				null,
				'O',
				getdate(), 
				getdate(), 
				@sCodOper,
				getdate(), 
				@sCodOper

		From   sysadm.reglement r,
				sysadm.detail d
		Where  r.id_sin = @adcIdSin
		And    r.id_reg = @adcIdReg
		And    r.cod_inter = 'F'
		And    r.cod_mode_reg = 'FM'
		And    d.id_sin = r.id_sin
		And    d.id_reg = r.id_reg
	End
	
If Exists ( Select Top 1 1 From sysadm.w_sin where id_sin = @adcIdSin ) 
   And 
	 Not Exists ( 
		Select Top 1 1
		From    sysadm.reglement r,
				sysadm.w_div_det dd1,
				sysadm.detail d,
				sysadm.div_det dd
		Where  r.id_sin = @adcIdSin
		And    r.id_reg = @adcIdReg
		And    r.cod_inter = 'F'
		And    r.cod_mode_reg = 'FM'
		And    d.id_sin = r.id_sin
		And    d.id_reg = r.id_reg
		And    dd.id_sin = d.id_sin
		And    dd.id_gti = d.id_gti
		And    dd.id_detail = d.id_detail
		And    dd.nom_zone = 'pas_de_rglt_fourn'
		And    dd.val_car = 'O'
		And    dd1.id_sin = dd.id_sin
		And    dd1.id_gti = dd.id_gti
		And    dd1.id_detail = dd.id_detail
		 )
	Begin
		Insert into sysadm.w_div_det 
		select d.id_sin,
				d.id_gti,
				d.id_detail,
				'pas_de_rglt_fourn', 
				'Pas de rglt fournisseur', 
				'-1',
				'N',
				'X', 
				'N', 
				'N',
				500,
				null,
				null,
				null,
				'O',
				   0,
				getdate(), 
				getdate(), 
				@sCodOper

		From   sysadm.reglement r,
				sysadm.detail d
		Where  r.id_sin = @adcIdSin
		And    r.id_reg = @adcIdReg
		And    r.cod_inter = 'F'
		And    r.cod_mode_reg = 'FM'
		And    d.id_sin = r.id_sin
		And    d.id_reg = r.id_reg
	End 
Go


