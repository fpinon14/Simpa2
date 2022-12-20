-------------------------------------------------------------------
--
-- Fichier              :       PM370-1.CP
-- Auteur               :       Fabry JF
-- Date                 :       23/04/2018
--
-- Commentaires         :       
--
-- Procédures           :       
--
-------------------------------------------------------------------
-- sysadm.PS_D_PM370_1_SUPP_PRODUIT_INIT
-- sysadm.PS_D_PM370_1_SUPP_PRODUIT_MOTEUR
-- sysadm.PS_D_PM370_1_SUPP_PRODUIT_PROD
-- sysadm.PS_D_PM370_1_SUPP_PRODUIT_SIN
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_D_PM370_1_SUPP_PRODUIT_INIT
-- Auteur               :       JFF
-- Date                 :       24/04/2018
-- Libelle              :		[PM370-1]
-- Commentaires         :       Initialise un produit à supprimer
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D_PM370_1_SUPP_PRODUIT_INIT' AND type = 'P' )
        DROP procedure sysadm.PS_D_PM370_1_SUPP_PRODUIT_INIT
GO

CREATE procedure sysadm.PS_D_PM370_1_SUPP_PRODUIT_INIT
	@adcIdProd Decimal ( 10 ),
	@asComment VarChar ( 255 )
AS

Insert into sysadm.produit_supp
Select 
id_prod       ,
id_dept       ,
id_grp        ,
lib_court     ,
lib_long      ,
cod_rev_surv  ,
cod_rev_sous  ,
cod_rev_rnv   ,
dur_perrnv_adh,
unt_perrnv_adh,
cod_mode_reg  ,
lib_bq_debit  ,
rib_bq        ,
rib_gui       ,
rib_cpt       ,
rib_cle       ,
cod_dest_reg  ,
cod_adh       ,
id_corb       ,
id_police     ,
num_tel       ,
num_fax       ,
id_depts      ,
cod_niv_ope   ,
cod_base_dms  ,
cod_adr_dms   ,
cod_prod_dms  ,
alt_crebq_dms ,
nb_adherent   ,
cree_le       ,
maj_le        ,
maj_par       ,
Getdate()	  ,
Getdate()	  ,
'JFF'		  ,
'N'			  ,
Case 
	When @asComment is null
		Then 'Demande de suppression par le PM370-1, maj_le=date de suppression'
	Else rtrim ( ltrim( @asComment ))
End 
From sysadm.produit p
Where p.id_prod = @adcIdProd

Go



--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_D_PM370_1_SUPP_PRODUIT_MOTEUR
-- Auteur               :       JFF
-- Date                 :       24/04/2018
-- Libelle              :		[PM370-1]
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D_PM370_1_SUPP_PRODUIT_MOTEUR' AND type = 'P' )
        DROP procedure sysadm.PS_D_PM370_1_SUPP_PRODUIT_MOTEUR
GO

CREATE procedure sysadm.PS_D_PM370_1_SUPP_PRODUIT_MOTEUR
		@iTempsEnSeconde Integer
AS

Declare @dcIdProd decimal ( 7 )
Declare @dcIdSin decimal ( 10 )
Declare @dtDeb DateTime

Set @dtDeb = GetDate()

While Exists ( Select Top 1 1 From sysadm.produit_supp where traite = 'N' )
	  And 
	  DATEDIFF ( second , @dtDeb, GETDATE() ) <= @iTempsEnSeconde 
 Begin
	Select 	Top 1 
		@dcIdProd = id_prod
	From	sysadm.produit_supp
	Where	traite = 'N'

	While Exists ( Select Top 1 1 From sysadm.sinistre where id_prod = @dcIdProd
	               Union
				   Select Top 1 1 From sysadm.w_sin where id_prod = @dcIdProd
	             )
		  And 
		  DATEDIFF ( second , @dtDeb, GETDATE() ) <= @iTempsEnSeconde 
	 Begin

		Set @dcIdSin = null

		Select 	Top 1 
			@dcIdSin = id_sin
		From	sysadm.sinistre
		Where	id_prod = @dcIdProd

		If @dcIdSin is null 
		  Begin
			Select 	Top 1 
				@dcIdSin = id_sin
			From	sysadm.w_sin
			Where	id_prod = @dcIdProd
		  End 

		If @dcIdSin is null Break

		Exec sysadm.PS_D_PM370_1_SUPP_PRODUIT_SIN @dcIdSin 

	 End 

	If Not Exists ( Select Top 1 1 From sysadm.sinistre where id_prod = @dcIdProd
			        Union
					Select Top 1 1 From sysadm.w_sin where id_prod = @dcIdProd
	              )
	  Begin
		Exec sysadm.PS_D_PM370_1_SUPP_PRODUIT_PROD @dcIdProd

		If Not Exists ( Select Top 1 1 From sysadm.produit where id_prod = @dcIdProd )
		  Begin
			Update sysadm.produit_supp Set traite = 'O', maj_le = GETDATE() Where id_prod = @dcIdProd
		  End
	  End 
 End


Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_D_PM370_1_SUPP_PRODUIT_SIN
-- Auteur               :       JFF
-- Date                 :       24/04/2018
-- Libelle              :		[PM370-1]
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D_PM370_1_SUPP_PRODUIT_SIN' AND type = 'P' )
        DROP procedure sysadm.PS_D_PM370_1_SUPP_PRODUIT_SIN
GO

CREATE procedure sysadm.PS_D_PM370_1_SUPP_PRODUIT_SIN
	@adcIdSin Decimal ( 10 )
AS

-- Sinistre 
Delete sysadm.trace_tout_mobile where id_sin = @adcIdSin
Delete sysadm.rejet_ftu_brk where id_sin = @adcIdSin
Delete sysadm.trace_regl_auto where id_sin = @adcIdSin
Delete sysadm.trace_trt_frais_presta where id_sin = @adcIdSin
Delete sysadm.cum_ftu_brk where id_sin = @adcIdSin
Delete sysadm.w_cum_ftu_brk where id_sin = @adcIdSin
Delete sysadm.trace_volcanes_ass where id_sin = @adcIdSin
Delete sysadm.w_volcanes_ass where id_sin = @adcIdSin
Delete sysadm.cra_imei_trt_export where id_sin = @adcIdSin
Delete sysadm.trace_soldage where id_sin = @adcIdSin
Delete sysadm.trace_cmde_web where id_sin = @adcIdSin
Delete sysadm.trace_cmde_web_btq where id_sin = @adcIdSin
Delete sysadm.archive where id_sin = @adcIdSin
Delete sysadm.trt_frais_presta where id_sin = @adcIdSin
Delete sysadm.w_rappel_client where id_sin = @adcIdSin


-- Tables tempo
delete from sysadm.w_a_virer where id_sin=@adcIdSin
delete from sysadm.w_para_plafond where id_sin=@adcIdSin
delete from sysadm.w_queue where id_sin=@adcIdSin
delete from sysadm.routage where id_sin=@adcIdSin
delete from sysadm.w_commande where id_sin=@adcIdSin
delete from sysadm.w_piece where id_sin=@adcIdSin
delete from sysadm.w_div_det where id_sin=@adcIdSin
delete from sysadm.w_detail where id_sin=@adcIdSin
delete from sysadm.w_div_sin where id_sin=@adcIdSin
delete from sysadm.w_cour_blob_arch where id_sin=@adcIdSin
delete from sysadm.w_cour_blob where id_sin=@adcIdSin
delete from sysadm.w_courrier where id_sin=@adcIdSin
delete from sysadm.w_frais where id_sin=@adcIdSin
delete from sysadm.w_refus where id_sin=@adcIdSin
delete from sysadm.w_inter where id_sin=@adcIdSin
delete from sysadm.w_reg_gti where id_sin=@adcIdSin
delete from sysadm.w_gar_sin where id_sin=@adcIdSin
delete from sysadm.w_sin where id_sin=@adcIdSin

delete from sysadm.commande where id_sin=@adcIdSin
delete from sysadm.div_det where id_sin=@adcIdSin
delete from sysadm.detail where id_sin=@adcIdSin
delete from sysadm.div_sin where id_sin=@adcIdSin
delete from sysadm.frais where id_sin=@adcIdSin
delete from sysadm.refus where id_sin=@adcIdSin
delete from sysadm.reg_gti where id_sin=@adcIdSin
delete from sysadm.reglement where id_sin=@adcIdSin
delete from sysadm.inter where id_sin=@adcIdSin
delete from sysadm.gar_sin where id_sin=@adcIdSin
delete from sysadm.cra_imei_trt_import where id_sin=@adcIdSin
delete from sysadm.trace_cra_imei where id_sin=@adcIdSin
delete from sysadm.sinistre where id_sin=@adcIdSin

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_D_PM370_1_SUPP_PRODUIT_PROD
-- Auteur               :       JFF
-- Date                 :       24/04/2018
-- Libelle              :		[PM370-1]
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D_PM370_1_SUPP_PRODUIT_PROD' AND type = 'P' )
        DROP procedure sysadm.PS_D_PM370_1_SUPP_PRODUIT_PROD
GO

CREATE procedure sysadm.PS_D_PM370_1_SUPP_PRODUIT_PROD
	@adcIdProd Decimal ( 10 )
AS
 


-- Param
Delete sysadm.substitution where id_prod = @adcIdProd
Delete sysadm.det_article where id_prod = @adcIdProd
Delete sysadm.cum_periode where id_prod = @adcIdProd
Delete sysadm.traitement_archive where id_prod = @adcIdProd
Delete sysadm.traitement where id_prod = @adcIdProd
Delete sysadm.autorisation where id_prod = @adcIdProd
Delete sysadm.param_alerte_frn where id_prod = @adcIdProd
Delete sysadm.param_ftu_brk_sv where id_prod = @adcIdProd
Delete sysadm.delai where id_prod = @adcIdProd
Delete sysadm.franchise where id_prod = @adcIdProd
Delete sysadm.condition where id_prod = @adcIdProd
Delete sysadm.plafond where id_prod = @adcIdProd
Delete sysadm.det_pro where id_prod = @adcIdProd
Delete sysadm.etablissement where id_prod = @adcIdProd
Delete sysadm.affilier where id_prod = @adcIdProd
Delete sysadm.garantie where id_prod = @adcIdProd
Delete sysadm.cour_prod where id_prod = @adcIdProd
Delete sysadm.courrier where id_prod = @adcIdProd
Delete sysadm.piece where id_prod = @adcIdProd
Delete sysadm.div_pdet where id_prod = @adcIdProd
Delete sysadm.motif where id_prod = @adcIdProd
Delete sysadm.commande_type where id_prod = @adcIdProd
Delete sysadm.revision where id_prod = @adcIdProd
Delete sysadm.option_adh where id_prod = @adcIdProd
Delete sysadm.para_prod where id_prod = @adcIdProd
Delete sysadm.wkfs_regroup where id_prod = @adcIdProd
Delete sysadm.div_pro where id_prod = @adcIdProd
Delete sysadm.boutique where id_prod = @adcIdProd
Delete sysadm.zone_fournisseur where id_prod = @adcIdProd
Delete sysadm.tmp_param_vts_pec where id_prod = @adcIdProd
Delete sysadm.param_vts_pec where id_prod = @adcIdProd
Delete sysadm.code_garantie where id_prod = @adcIdProd
Delete sysadm.code_condition where id_prod = @adcIdProd
Delete sysadm.param_ftu_brk where id_prod = @adcIdProd
Delete sysadm.wkfs_w_queue where id_prod = @adcIdProd
Delete sysadm.param_frais where id_prod = @adcIdProd
Delete sysadm.trace_param_frais where id_prod = @adcIdProd
Delete sysadm.produit where id_prod = @adcIdProd




Go

