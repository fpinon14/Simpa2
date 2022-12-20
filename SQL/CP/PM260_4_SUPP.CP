-------------------------------------------------------------------
--
-- Fichier              :       PM260_4_SUPP.CP
-- Auteur               :       FABRY JF
-- Date                 :       03/06/2019
--								[PM260_4]
-- Commentaires         :       
--
-- sysadm.PS_I_BATCH_PM260_4_SUPP
-- sysadm.PS_D_TRT_PM260_4_SUPP
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       PS_D_TRT_PM260_4_SUPP
-- Auteur               :       JFF
-- Date                 :       04/11/2015
-- Libelle              :       
-- Commentaires         :       [PM260]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      27/03/2017   [PM260-1]
-- JFF      11/02/2019   [PM473-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D_TRT_PM260_4_SUPP' AND type = 'P' )
        DROP procedure sysadm.PS_D_TRT_PM260_4_SUPP
GO

CREATE procedure sysadm.PS_D_TRT_PM260_4_SUPP
	@adcIdSin Decimal (10) -- [PI062]
As

Declare @dcIdOrdre decimal (7)


-- GENVIR_PRO
Delete GENVIR_PRO.sysadm.w_a_virer where id_sin = @adcIdSin
Delete GENVIR_PRO.sysadm.w_a_virer_histo where id_sin = @adcIdSin

-- TRACE_MAIL_PRO
Delete TRACE_MAIL_PRO.sysadm.tmp_mail_push where id_sin = @adcIdSin
Delete TRACE_MAIL_PRO.sysadm.archive_nostat_mail_push where id_sin = @adcIdSin
Delete TRACE_MAIL_PRO.sysadm.mail_push_tmp where id_sin = @adcIdSin
Delete TRACE_MAIL_PRO.sysadm.suivi_mail where id_sin = @adcIdSin
Delete TRACE_MAIL_PRO.sysadm.sms_push where id_sin = @adcIdSin
Delete TRACE_MAIL_PRO.sysadm.mail_push where id_sin = @adcIdSin

-- SIMPA2BLOB_PRO
Delete SIMPA2BLOB_PRO.sysadm.archive_blob where id_sin = @adcIdSin
Delete SIMPA2BLOB_PRO.sysadm.archive_blob2 where id_sin = @adcIdSin

-- SIMPA2
Delete sysadm.cum_ftu_brk where id_sin = @adcIdSin
Delete sysadm.trace_volcanes_ass where id_sin = @adcIdSin
Delete sysadm.rejet_ftu_brk where id_sin = @adcIdSin
Delete sysadm.trace_soldage where id_sin = @adcIdSin
Delete sysadm.trace_facture_a_regler where id_sin = @adcIdSin
Delete sysadm.trace_web_service where id_sin = @adcIdSin
Delete sysadm.trace_cmde_web_btq where id_sin = @adcIdSin
Delete sysadm.update_iwd_log where id_sin = @adcIdSin
Delete sysadm.w_rappel_client where id_sin = @adcIdSin
Delete sysadm.trace_cmde_web where id_sin = @adcIdSin
Delete sysadm.w_log_data_script where id_sin = @adcIdSin

Delete tr
From  sysadm.trace_recap_relance tr,
      sysadm.trace_relance t
where t.id_sin = @adcIdSin
And   tr.id_trt = t.id_trt

Delete sysadm.trace_relance where id_sin = @adcIdSin

Delete sysadm.trace_dt57 where id_sin = @adcIdSin
Delete sysadm.vDocRPAlice where id_sin = @adcIdSin
Delete sysadm.trace_trt_frais_presta where id_sin = @adcIdSin
Delete sysadm.resil_adh where id_sin = @adcIdSin
Delete sysadm.sav_frn where id_sin = @adcIdSin
Delete sysadm.w_cour_blob_arch where id_sin = @adcIdSin
Delete sysadm.trace_regl_auto where id_sin = @adcIdSin
Delete sysadm.trt_frais_presta where id_sin = @adcIdSin
Delete sysadm.w_volcanes_ass where id_sin = @adcIdSin
Delete sysadm.alerte_frn where id_sin = @adcIdSin
Delete sysadm.trace_modif_rib where id_sin = @adcIdSin
Delete sysadm.trace_alerte where id_sin = @adcIdSin
Delete sysadm.trace_tout_mobile where id_sin = @adcIdSin
Delete sysadm.trace_cmde2 where id_sin = @adcIdSin
Delete sysadm.trace_cmde where id_sin = @adcIdSin
Delete sysadm.trace_mob_rempl where id_sin = @adcIdSin
Delete sysadm.piece_histo where id_sin = @adcIdSin
Delete sysadm.tmp_soldage where id_sin = @adcIdSin
Delete sysadm.histo_validation where id_sin = @adcIdSin
Delete sysadm.wkfs_w_queue where id_sin = @adcIdSin
Delete sysadm.wkfs_histo where id_sin = @adcIdSin
Delete sysadm.update_iwd where id_sin = @adcIdSin
Delete sysadm.w_trc_archive_recup where id_sin = @adcIdSin
Delete sysadm.w_erreur_archive where id_sin = @adcIdSin
Delete sysadm.stat_sin2 where id_sin = @adcIdSin
Delete sysadm.stat_sin where id_sin = @adcIdSin
Delete sysadm.archive_blob where id_sin = @adcIdSin
Delete sysadm.archive where id_sin = @adcIdSin
Delete sysadm.det_fact_fnac where id_sin = @adcIdSin
Delete sysadm.contact where id_sin = @adcIdSin
Delete sysadm.frais where id_sin = @adcIdSin
Delete sysadm.reg_gti where id_sin = @adcIdSin
Delete sysadm.reglement where id_sin = @adcIdSin
Delete sysadm.commande where id_sin = @adcIdSin
Delete sysadm.refus where id_sin = @adcIdSin
Delete sysadm.div_det where id_sin = @adcIdSin
Delete sysadm.detail where id_sin = @adcIdSin
Delete sysadm.gar_sin where id_sin = @adcIdSin
Delete sysadm.inter where id_sin = @adcIdSin
Delete sysadm.div_sin where id_sin = @adcIdSin

Select @dcIdOrdre = s.id_ordre
From   sysadm.sinistre s
Where  s.id_sin = @adcIdSin

Delete sysadm.sinistre where id_sin = @adcIdSin

If Not exists ( 
	Select Top 1 1 
	From sysadm.sinistre s
	Where s.id_ordre = @dcIdOrdre )
 Begin
	Delete sysadm.personne where id_ordre = @dcIdOrdre
 End 

-- Laisser en dernier
Delete sysadm.routage where id_sin = @adcIdSin

If Exists ( Select Top 1 1 From sysadm.routage where id_sin = @adcIdSin )
 Begin 
	Return -1
 End 

Return 1

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_I_BATCH_PM260_4_SUPP
-- Auteur               :       JFF
-- Date                 :       03/06/2019
-- Libelle              :       
-- Commentaires         :       [PM260]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      15/05/2018   [PM260-3]
-- JFF      11/02/2019   [PM473-1]
-- JFF      03/06/2019   [PM260-4]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_BATCH_PM260_4_SUPP' AND type = 'P' )
        DROP procedure sysadm.PS_I_BATCH_PM260_4_SUPP
GO

CREATE procedure sysadm.PS_I_BATCH_PM260_4_SUPP
	@iTempsEnSeconde Integer
As

-- [PM260-4]
If NOT ( sysadm.FN_CLE_NUMERIQUE ( 'PM260_4') > 0 )
 Begin
    -- Tant que le PM260-4 n'est pas en prod, on ressort.
	Return
 End 
  
Declare @dtDeb DateTime
Declare @dcIdSin Decimal (10) -- [PI062]
Declare @iNbre integer
Declare @iNbreTot integer
Declare @iArretSuitErr integer
Declare @iErr integer
Declare @iRet integer
Declare @dtDernValidation DateTime
Declare @dcIdprod Decimal ( 7 )
Declare @dcIdRev Decimal ( 7 )
Declare @dtCreeLe DateTime
Declare @dtSurv DateTime
Declare @dtAdh DateTime
Declare @dtDecl DateTime
Declare @dcCodEtatAssureur Decimal ( 7 )
Declare @dcCodEtatAssure Decimal ( 7 )

DECLARE @tb TABLE 
	( id_sin	decimal (10 )
	)

DECLARE @sMessage    Varchar(1000),
	    @sObjet      VarChar(255),
	    @sRetourErrMail VarChar(255)

Set @dtDeb = GetDate()
Set @iNbre = 0
Set @iArretSuitErr = 0

While DATEDIFF ( second , @dtDeb, GETDATE() ) <= @iTempsEnSeconde 
 Begin
 
 	Set @dcIdSin = null
	
	-- La suite est montée ainsi pour une question d'optimisation, ne pas pas chercher la logique :-)
	-- Après plusieurs test, c'était bien plus rapide ainsi.

	If Not Exists ( Select Top 1 1 From @tb ) 
	  Begin
		Insert into @tb
		Select Top 5000 s.id_sin  
		From  sysadm.sinistre s,
				sysadm.det_pro dp,
				( Select distinct id_prod, id_rev, id_police from sysadm.garantie ) ga,
				sysadm.police po
		Where dp.id_prod = s.id_prod
		And   dp.id_code_dp = 338
		And   ga.id_prod = s.id_prod
		And   ga.id_rev = s.id_rev
		And   po.id_police = ga.id_police
		And   po.id_cie = convert ( integer, sysadm.FN_CLE_VAL ( 'ID_CIE', rtrim ( dp.val_car) + rtrim ( dp.val_car2) , ';' ))
		And	  s.valide_le < DATEADD ( month, convert ( integer, sysadm.FN_CLE_VAL ( 'PERIODE_MOIS', rtrim ( dp.val_car) + rtrim ( dp.val_car2), ';' )) * (-1), GETDATE() )
		And   s.cod_etat in ( 600, 200, 900 )
		And   Not Exists ( 
				Select	Top 1 1
				From	sysadm.w_queue wq
				Where	wq.id_sin = convert ( varchar, s.id_sin ) -- [PI062]
				)	
		And   Not Exists ( 
				Select Top 1 1 
				From   sysadm.w_sin ws
				Where  ws.id_sin = s.id_sin  
		)

		Delete s
		from  @tb s, 
			  sysadm.pm260_4_traite_supp t
		Where t.id_sin = s.id_sin

	  End 

	If Not Exists ( Select Top 1 1 From @tb ) Break
	  
	Select top 1 @dcIdSin = id_sin From @tb	  	

	If @dcIdSin is null Break

	Select @dtDernValidation = s.valide_le,
		   @dcIdRev = s.id_rev,
		   @dcIdprod = s.id_prod,
		   @dtCreeLe = s.cree_le,
		   @dtSurv = s.dte_surv,
		   @dtAdh = s.dte_adh,
		   @dtDecl = s.dte_decl,
		   @dcCodEtatAssureur = s.cod_etat,
		   @dcCodEtatAssure = Convert ( decimal, IsNull ( nullif ( ltrim ( sysadm.FN_GET_DIV_SIN (  @dcIdSin, 'etat_vu_assure', 'P', 'RETOUR=CODE')), ''), '-1'))
	From sysadm.sinistre s
	Where s.id_sin = @dcIdSin

	Exec @iRet = sysadm.PS_D_TRT_PM260_4_SUPP @dcIdSin
	Set @iErr = @@ERROR

	If @iErr <> 0 Or @iRet < 0 
	  Begin
		Set @iArretSuitErr = 1
		Break
	  End 

	Insert into sysadm.pm260_4_traite_supp values ( @dcIdSin, @dcIdRev, @dcIdprod, @dcCodEtatAssureur, @dcCodEtatAssure, @dtAdh, @dtSurv, @dtDecl, @dtCreeLe, @dtDernValidation, GETDATE() )

	Set @iNbre = @iNbre + 1

	Delete @tb where id_sin = @dcIdSin

End

Go
