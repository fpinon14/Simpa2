-------------------------------------------------------------------
--
-- Fichier              :       MODFOR.CP
-- Auteur               :       JFF
-- Date                 :       20/03/2014
--
-- Commentaires         :       Gestion des PS de la base SIMPA2_MODFOR
--								[VDOC13762]
-- Proc‚dures           :       
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_CREATION_MODELE
-- Auteur               :       JFF
-- Date                 :       20/03/2014
-- Libell‚              :        
-- Commentaires         :       
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CREATION_MODELE' AND type = 'P' )
        DROP procedure sysadm.PS_CREATION_MODELE
GO

CREATE procedure sysadm.PS_CREATION_MODELE
        @dcIdSin        Decimal ( 7, 0 ),
        @id_modele		Integer,
        @lib_modele		varchar ( 255 ),
        @def_modele		varchar ( 255 )
AS

Insert into SIMPA2_MODFOR.sysadm.modele ( 
			id_modele,
			lib_modele,
			def_modele,
			comment,
			actif,
			id_sin,
			cree_le,
			cree_par,
			maj_le,
			maj_par)
					
		Values ( 
			@id_modele,
			@lib_modele,
			@def_modele,
			null,
			'O',
			@dcIdSin,
			GETDATE(),
			'JFF',
			GETDATE(),
			'JFF'
		)
		

Insert into SIMPA2_MODFOR.sysadm.w_sin ( 
			id_sin,
			id_prod,
			id_rev,
			id_ets,
			id_adh,
			id_sdos,
			id_dos_cie,
			id_natsin,
			id_territ,
			id_detsin,
			cod_decl,
			cod_i_decl,
			dte_decl,
			dte_surv,
			heu_surv,
			dte_adh,
			dte_sous,
			dte_opt,
			cod_opt,
			dte_resil,
			dte_fin_gti,
			dte_fin_gti_prec,
			cod_civ,
			nom,
			prenom,
			adr_1,
			adr_2,
			adr_cp,
			adr_ville,
			num_fax,
			num_telb,
			num_teld,
			mt_a_reg,
			mt_reg,
			lieu,
			txt_mess,
			ref_cie,
			id_carte,
			id_type_carte,
			cod_dec_mac,
			cod_dec_ope,
			cod_etat,
			alt_ssui,
			cod_mot_ssui,
			id_ordre,
			cod_prov_pers,
			alt_bloc,
			cpt_valide,
			alt_rapatrier,
			alt_adr,
			cree_le,
			maj_le,
			maj_par,
			num_port,
			num_imei_port,
			marq_port,
			modl_port,
			dte_ach_port,
			dte_ouvlig_port,
			id_contrat_abonne,
			id_hlr,
			id_orian_marque,
			id_orian_modele,
			id_orian_boutique )

		Select		
			@dcIdSin,
			id_prod,
			id_rev,
			id_ets,
			id_adh,
			id_sdos,
			id_dos_cie,
			id_natsin,
			id_territ,
			id_detsin,
			cod_decl,
			cod_i_decl,
			dte_decl,
			dte_surv,
			heu_surv,
			dte_adh,
			dte_sous,
			dte_opt,
			cod_opt,
			dte_resil,
			dte_fin_gti,
			dte_fin_gti_prec,
			cod_civ,
			nom,
			prenom,
			adr_1,
			adr_2,
			adr_cp,
			adr_ville,
			num_fax,
			num_telb,
			num_teld,
			mt_a_reg,
			mt_reg,
			lieu,
			txt_mess,
			ref_cie,
			id_carte,
			id_type_carte,
			cod_dec_mac,
			cod_dec_ope,
			cod_etat,
			alt_ssui,
			cod_mot_ssui,
			id_ordre,
			cod_prov_pers,
			alt_bloc,
			cpt_valide,
			alt_rapatrier,
			alt_adr,
			cree_le,
			maj_le,
			maj_par,
			num_port,
			num_imei_port,
			marq_port,
			modl_port,
			dte_ach_port,
			dte_ouvlig_port,
			id_contrat_abonne,
			id_hlr,
			id_orian_marque,
			id_orian_modele,
			id_orian_boutique
		From	sysadm.w_sin 
		Where	id_sin = @dcIdSin

Insert into SIMPA2_MODFOR.sysadm.w_inter ( 
			id_sin,
			id_i,
			cod_inter,
			cod_civ,
			nom,
			adr_1,
			adr_2,
			adr_cp,
			adr_ville,
			adr_att,
			num_teld,
			num_telb,
			num_fax,
			cod_mode_reg,
			rib_bq,
			rib_gui,
			rib_cpt,
			rib_cle,
			mt_a_reg,
			mt_reg,
			v_ref1,
			v_ref2,
			cod_ag,
			cod_bq,
			cpt_cour,
			cpt_valide,
			alt_valide,
			alt_part,
			alt_ps,
			alt_pce,
			alt_quest,
			id_cour,
			id_nat_cour,
			alt_courgest,
			id_i_db,
			id_courj,
			cree_le,
			maj_le,
			maj_par,
			ordre_cheque,
			num_let_cheque,
			id_four,
			alt_suivi_mail,
			adr_mail,
			alt_suivi_sms,
			num_port_sms )

		Select		
			@dcIdSin,
			id_i,
			cod_inter,
			cod_civ,
			nom,
			adr_1,
			adr_2,
			adr_cp,
			adr_ville,
			adr_att,
			num_teld,
			num_telb,
			num_fax,
			cod_mode_reg,
			rib_bq,
			rib_gui,
			rib_cpt,
			rib_cle,
			mt_a_reg,
			mt_reg,
			v_ref1,
			v_ref2,
			cod_ag,
			cod_bq,
			cpt_cour,
			cpt_valide,
			alt_valide,
			alt_part,
			alt_ps,
			alt_pce,
			alt_quest,
			id_cour,
			id_nat_cour,
			alt_courgest,
			id_i_db,
			id_courj,
			cree_le,
			maj_le,
			maj_par,
			ordre_cheque,
			num_let_cheque,
			id_four,
			alt_suivi_mail,
			adr_mail,
			alt_suivi_sms,
			num_port_sms
		From	sysadm.w_inter 
		Where	id_sin = @dcIdSin

Insert into SIMPA2_MODFOR.sysadm.w_frais  (
				id_sin,
				id_i,
				id_frais,
				id_typ_frais,
				lib_frais,
				alt_cour,
				mt_frais,
				cod_etat,
				cree_le,
				maj_le,
				maj_par )
		Select		
				@dcIdSin,
				id_i,
				id_frais,
				id_typ_frais,
				lib_frais,
				alt_cour,
				mt_frais,
				cod_etat,
				cree_le,
				maj_le,
				maj_par 				
		From	sysadm.w_frais
		Where	id_sin = @dcIdSin

Insert into SIMPA2_MODFOR.sysadm.w_div_sin ( 
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
				maj_par )

		Select		
				@dcIdSin,
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
		From	sysadm.w_div_sin
		Where	id_sin = @dcIdSin

Insert into SIMPA2_MODFOR.sysadm.w_gar_sin ( 
				id_sin,
				id_gti,
				dte_oppo,
				heu_oppo,
				dte_1er_uf,
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
				txt_mess,
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

		Select		
				@dcIdSin,
				id_gti,
				dte_oppo,
				heu_oppo,
				dte_1er_uf,
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
				txt_mess,
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
				maj_par				
		From	sysadm.w_gar_sin
		Where	id_sin = @dcIdSin

Insert into SIMPA2_MODFOR.sysadm.w_detail ( 
				id_sin,
				id_gti,
				id_detail,
				id_evt,
				lib_det,
				dte_det,
				heu_det,
				num_carte,
				mt_prej,
				mt_fran,
				mt_nplaf,
				mt_plaf,
				id_i_reg,
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
				maj_par,
				dte_cmd,
				dte_livr,
				mt_val_achat,
				mt_val_publique,
				num_facture )
				
		Select		
				@dcIdSin,
				id_gti,
				id_detail,
				id_evt,
				lib_det,
				dte_det,
				heu_det,
				num_carte,
				mt_prej,
				mt_fran,
				mt_nplaf,
				mt_plaf,
				id_i_reg,
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
				maj_par,
				dte_cmd,
				dte_livr,
				mt_val_achat,
				mt_val_publique,
				num_facture
		From	sysadm.w_detail
		Where	id_sin = @dcIdSin


Insert into SIMPA2_MODFOR.sysadm.w_div_det ( 
				id_sin,
				id_gti,
				id_detail,
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
				@dcIdSin,
				id_gti,
				id_detail,
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
		From	sysadm.w_div_det
		Where	id_sin = @dcIdSin

Insert into SIMPA2_MODFOR.sysadm.w_commande ( 
				id_sin,
				id_seq,
				id_gti,
				id_detail,
				id_four,
				id_typ_art,
				id_marq_art,
				id_modl_art,
				mt_ttc_cmde,
				adr_nom,
				adr_prenom,
				adr_livr1,
				adr_livr2,
				adr_livr_cpl,
				adr_cp,
				adr_ville,
				adr_tel1,
				adr_tel2,
				adr_tel3,
				adr_mail,
				dte_rdv_cli,
				hrdv_cli_min,
				hrdv_cli_max,
				id_serie_anc,
				probleme,
				id_cmd_frn,
				id_serie_nouv,
				id_bon_transp,
				dte_rcp_frn,
				dte_env_cli,
				cod_etat,
				comment_frn,
				cpt_valide,
				nom_gest,
				cree_le,
				maj_le,
				maj_par,
				id_zone,
				id_bsp,
				dte_ret_pret,
				adr_cod_civ,
				id_ref_four,
				id_orian_marque,
				id_orian_modele,
				dte_elv_mobile,
				status_gc,
				dte_emis_devis,
				mt_devis,
				alt_dev_acp,
				dte_dev_acp,
				adrfc_cod_civ,
				adrfc_nom,
				adrfc_prenom,
				adrfc_livr1,
				adrfc_livr2,
				adrfc_livr_cpl,
				adrfc_cp,
				adrfc_ville,
				dte_ret_logis,
				dte_ret_pret_min,
				dte_ret_pret_max,
				id_ann,
				dte_env_bte_frn,
				dte_rcp_bte_cli,
				dte_dep_bte_cli,
				dte_env_st,
				dte_rcp_mob_cli,
				info_spb_frn,
				id_marq_art_ifr,
				id_modl_art_ifr,
				info_spb_frn_cplt,
				info_frn_spb_cplt )

		Select		
				@dcIdSin,
				id_seq,
				id_gti,
				id_detail,
				id_four,
				id_typ_art,
				id_marq_art,
				id_modl_art,
				mt_ttc_cmde,
				adr_nom,
				adr_prenom,
				adr_livr1,
				adr_livr2,
				adr_livr_cpl,
				adr_cp,
				adr_ville,
				adr_tel1,
				adr_tel2,
				adr_tel3,
				adr_mail,
				dte_rdv_cli,
				hrdv_cli_min,
				hrdv_cli_max,
				id_serie_anc,
				probleme,
				id_cmd_frn,
				id_serie_nouv,
				id_bon_transp,
				dte_rcp_frn,
				dte_env_cli,
				cod_etat,
				comment_frn,
				cpt_valide,
				nom_gest,
				cree_le,
				maj_le,
				maj_par,
				id_zone,
				id_bsp,
				dte_ret_pret,
				adr_cod_civ,
				id_ref_four,
				id_orian_marque,
				id_orian_modele,
				dte_elv_mobile,
				status_gc,
				dte_emis_devis,
				mt_devis,
				alt_dev_acp,
				dte_dev_acp,
				adrfc_cod_civ,
				adrfc_nom,
				adrfc_prenom,
				adrfc_livr1,
				adrfc_livr2,
				adrfc_livr_cpl,
				adrfc_cp,
				adrfc_ville,
				dte_ret_logis,
				dte_ret_pret_min,
				dte_ret_pret_max,
				id_ann,
				dte_env_bte_frn,
				dte_rcp_bte_cli,
				dte_dep_bte_cli,
				dte_env_st,
				dte_rcp_mob_cli,
				info_spb_frn,
				id_marq_art_ifr,
				id_modl_art_ifr,
				info_spb_frn_cplt,
				info_frn_spb_cplt
		From	sysadm.w_commande
		Where	id_sin = @dcIdSin

Insert into SIMPA2_MODFOR.sysadm.w_piece ( 
				id_sin,
				id_gti,
				id_detail,
				id_pce,
				id_i,
				id_para,
				cpt_tri,
				cree_le,
				maj_le,
				maj_par )

		Select		
				@dcIdSin,
				id_gti,
				id_detail,
				id_pce,
				id_i,
				id_para,
				cpt_tri,
				cree_le,
				maj_le,
				maj_par				
		From	sysadm.w_piece
		Where	id_sin = @dcIdSin

Insert into SIMPA2_MODFOR.sysadm.w_refus ( 
				id_sin,
				id_gti,
				id_detail,
				id_motif,
				alt_mac,
				alt_ope,
				id_i,
				id_para,
				cpt_tri,
				cree_le,
				maj_le,
				maj_par )

		Select		
				@dcIdSin,
				id_gti,
				id_detail,
				id_motif,
				alt_mac,
				alt_ope,
				id_i,
				id_para,
				cpt_tri,
				cree_le,
				maj_le,
				maj_par
		From	sysadm.w_refus
		Where	id_sin = @dcIdSin			
		
Insert into SIMPA2_MODFOR.sysadm.w_courrier ( 
				id_sin,
				id_i,
				id_cpt,
				id_cour,
				alt_part,
				alt_pce,
				alt_ps,
				txt_compo1,
				txt_compo2,
				id_i_db,
				cree_le,
				maj_le,
				maj_par,
				id_cour_orig,
				id_canal )		

		Select		
				@dcIdSin,
				id_i,
				id_cpt,
				id_cour,
				alt_part,
				alt_pce,
				alt_ps,
				txt_compo1,
				txt_compo2,
				id_i_db,
				cree_le,
				maj_le,
				maj_par,
				id_cour_orig,
				id_canal		
		From	sysadm.w_courrier
		Where	id_sin = @dcIdSin			

Insert into SIMPA2_MODFOR.sysadm.w_cour_blob ( 
				id_sin,
				id_i,
				id_cpt,
				id_typ_blob,
				id_typ_doc,
				txt_blob,
				cree_le,
				maj_le,
				maj_par )

		Select		
				@dcIdSin,
				id_i,
				id_cpt,
				id_typ_blob,
				id_typ_doc,
				txt_blob,
				cree_le,
				maj_le,
				maj_par
		From	sysadm.w_cour_blob
		Where	id_sin = @dcIdSin			

Insert into SIMPA2_MODFOR.sysadm.w_inter_blob ( 
				id_sin,
				id_i,
				id_typ_blob,
				txt_blob,
				cree_le,
				maj_le,
				maj_par )

		Select		
				@dcIdSin,
				id_i,
				id_typ_blob,
				txt_blob,
				cree_le,
				maj_le,
				maj_par 				
		From	sysadm.w_inter_blob
		Where	id_sin = @dcIdSin			

Insert into SIMPA2_MODFOR.sysadm.w_para_info ( 
				id_sin,
				id_i,
				id_para,
				cpt_tri,
				cree_le,
				maj_le,
				maj_par )

		Select		
				id_sin,
				id_i,
				id_para,
				cpt_tri,
				cree_le,
				maj_le,
				maj_par 				
		From	sysadm.w_para_info
		Where	id_sin = @dcIdSin		

Insert into SIMPA2_MODFOR.sysadm.w_para_plafond ( 
				id_sin,
				id_gti,
				id_detail,
				id_typ_plaf,
				id_para,
				id_i,
				cree_le,
				maj_le,
				maj_par )

		Select		
				@dcIdSin,
				id_gti,
				id_detail,
				id_typ_plaf,
				id_para,
				id_i,
				cree_le,
				maj_le,
				maj_par				
		From	sysadm.w_para_plafond
		Where	id_sin = @dcIdSin		

Insert into SIMPA2_MODFOR.sysadm.w_reg_gti ( 
				id_sin,
				id_i,
				id_gti,
				id_rgpt,
				id_reg,
				mt_reg,
				mt_rgpt,
				cree_le,
				maj_le,
				maj_par)

		Select		
				@dcIdSin,
				id_i,
				id_gti,
				id_rgpt,
				id_reg,
				mt_reg,
				mt_rgpt,
				cree_le,
				maj_le,
				maj_par
		From	sysadm.w_reg_gti
		Where	id_sin = @dcIdSin		

-- Permanentes
Insert into SIMPA2_MODFOR.sysadm.personne ( 
				id_ordre,
				cod_civ,
				nom,
				prenom,
				adr_1,
				adr_2,
				adr_cp,
				adr_ville,
				num_fax,
				num_telb,
				num_teld,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par)

		Select		
				p.id_ordre,
				p.cod_civ,
				p.nom,
				p.prenom,
				p.adr_1,
				p.adr_2,
				p.adr_cp,
				p.adr_ville,
				p.num_fax,
				p.num_telb,
				p.num_teld,
				p.valide_le,
				p.valide_par,
				p.cree_le,
				p.maj_le,
				p.maj_par
		From	sysadm.sinistre s,
				sysadm.personne p
		Where	s.id_sin = @dcIdSin		
		And		p.id_ordre = s.id_ordre

Insert into SIMPA2_MODFOR.sysadm.sinistre ( 
				id_sin,
				id_prod,
				id_rev,
				id_ets,
				id_adh,
				id_sdos,
				id_ordre,
				dte_adh,
				dte_sous,
				dte_opt,
				cod_opt,
				dte_resil,
				dte_fin_gti,
				id_dos_cie,
				dte_dos_cie,
				ref_cie,
				cod_decl,
				cod_i_decl,
				dte_decl,
				dte_surv,
				heu_surv,
				mt_reg,
				lieu,
				txt_mess,
				cod_dec_mac,
				cod_dec_ope,
				cod_etat,
				dte_ouv,
				id_natsin,
				id_territ,
				id_detsin,
				id_type_carte,
				id_carte,
				cpt_reg,
				alt_ssui,
				cod_mot_ssui,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par,
				dte_ouvlig_port,
				dte_ach_port,
				modl_port,
				marq_port,
				num_imei_port,
				num_port,
				id_contrat_abonne,
				id_hlr,
				id_orian_marque,
				id_orian_modele,
				id_orian_boutique)

		Select		
				@dcIdSin,
				id_prod,
				id_rev,
				id_ets,
				id_adh,
				id_sdos,
				id_ordre,
				dte_adh,
				dte_sous,
				dte_opt,
				cod_opt,
				dte_resil,
				dte_fin_gti,
				id_dos_cie,
				dte_dos_cie,
				ref_cie,
				cod_decl,
				cod_i_decl,
				dte_decl,
				dte_surv,
				heu_surv,
				mt_reg,
				lieu,
				txt_mess,
				cod_dec_mac,
				cod_dec_ope,
				cod_etat,
				dte_ouv,
				id_natsin,
				id_territ,
				id_detsin,
				id_type_carte,
				id_carte,
				cpt_reg,
				alt_ssui,
				cod_mot_ssui,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par,
				dte_ouvlig_port,
				dte_ach_port,
				modl_port,
				marq_port,
				num_imei_port,
				num_port,
				id_contrat_abonne,
				id_hlr,
				id_orian_marque,
				id_orian_modele,
				id_orian_boutique
		From	sysadm.sinistre 
		Where	id_sin = @dcIdSin		

Insert into SIMPA2_MODFOR.sysadm.div_sin ( 
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
				valide_par)

		Select		
				@dcIdSin,		
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
		From	sysadm.div_sin
		Where	id_sin = @dcIdSin		

Insert into SIMPA2_MODFOR.sysadm.inter ( 
				id_sin,
				id_i,
				cod_inter,
				cod_civ,
				nom,
				adr_1,
				adr_2,
				adr_cp,
				adr_ville,
				adr_att,
				num_teld,
				num_telb,
				num_fax,
				cod_mode_reg,
				rib_bq,
				rib_gui,
				rib_cpt,
				rib_cle,
				mt_reg,
				v_ref1,
				v_ref2,
				cod_ag,
				cod_bq,
				cpt_cour,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par,
				ordre_cheque,
				id_four,
				alt_suivi_mail,
				adr_mail,
				alt_suivi_sms,
				num_port_sms)

		Select		
				@dcIdSin,
				id_i,
				cod_inter,
				cod_civ,
				nom,
				adr_1,
				adr_2,
				adr_cp,
				adr_ville,
				adr_att,
				num_teld,
				num_telb,
				num_fax,
				cod_mode_reg,
				rib_bq,
				rib_gui,
				rib_cpt,
				rib_cle,
				mt_reg,
				v_ref1,
				v_ref2,
				cod_ag,
				cod_bq,
				cpt_cour,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par,
				ordre_cheque,
				id_four,
				alt_suivi_mail,
				adr_mail,
				alt_suivi_sms,
				num_port_sms								
		From	sysadm.inter
		Where	id_sin = @dcIdSin		

Insert into SIMPA2_MODFOR.sysadm.gar_sin ( 
				id_sin,
				id_gti,
				dte_oppo,
				heu_oppo,
				dte_1er_uf,
				mt_tot_prej,
				mt_prej_reg,
				mt_fran_reg,
				mt_nplaf_reg,
				mt_plaf_reg,
				mt_dedu_reg,
				mt_prov,
				cod_dec_mac,
				cod_dec_ope,
				cod_etat,
				dte_ouv,
				txt_mess,
				alt_plaf,
				alt_ssui,
				cod_mot_ssui,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par)

		Select		
				@dcIdSin,
				id_gti,
				dte_oppo,
				heu_oppo,
				dte_1er_uf,
				mt_tot_prej,
				mt_prej_reg,
				mt_fran_reg,
				mt_nplaf_reg,
				mt_plaf_reg,
				mt_dedu_reg,
				mt_prov,
				cod_dec_mac,
				cod_dec_ope,
				cod_etat,
				dte_ouv,
				txt_mess,
				alt_plaf,
				alt_ssui,
				cod_mot_ssui,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par
		From	sysadm.gar_sin
		Where	id_sin = @dcIdSin		

Insert into SIMPA2_MODFOR.sysadm.detail ( 
				id_sin,
				id_gti,
				id_detail,
				id_evt,
				id_reg,
				id_i_reg,
				lib_det,
				dte_det,
				heu_det,
				num_carte,
				mt_prej,
				mt_fran,
				mt_nplaf,
				mt_plaf,
				alt_plaf,
				alt_reg,
				alt_att,
				alt_ssui,
				cod_mot_ssui,
				cod_dec_mac,
				cod_dec_ope,
				cod_etat,
				id_carte,
				id_type_carte,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par,
				dte_cmd,
				dte_livr,
				mt_val_achat,
				mt_val_publique,
				num_facture)

		Select		
				@dcIdSin,
				id_gti,
				id_detail,
				id_evt,
				id_reg,
				id_i_reg,
				lib_det,
				dte_det,
				heu_det,
				num_carte,
				mt_prej,
				mt_fran,
				mt_nplaf,
				mt_plaf,
				alt_plaf,
				alt_reg,
				alt_att,
				alt_ssui,
				cod_mot_ssui,
				cod_dec_mac,
				cod_dec_ope,
				cod_etat,
				id_carte,
				id_type_carte,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par,
				dte_cmd,
				dte_livr,
				mt_val_achat,
				mt_val_publique,
				num_facture
		From	sysadm.detail
		Where	id_sin = @dcIdSin		

Insert into SIMPA2_MODFOR.sysadm.div_det ( 
				id_sin,
				id_gti,
				id_detail,
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
				valide_par)

		Select		
				@dcIdSin,
				id_gti,
				id_detail,
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
		From	sysadm.div_det
		Where	id_sin = @dcIdSin		

Insert into SIMPA2_MODFOR.sysadm.commande ( 
				id_sin,
				id_seq,
				id_gti,
				id_detail,
				id_four,
				id_typ_art,
				id_marq_art,
				id_modl_art,
				mt_ttc_cmde,
				adr_nom,
				adr_prenom,
				adr_livr1,
				adr_livr2,
				adr_livr_cpl,
				adr_cp,
				adr_ville,
				adr_tel1,
				adr_tel2,
				adr_tel3,
				adr_mail,
				dte_rdv_cli,
				hrdv_cli_min,
				hrdv_cli_max,
				id_serie_anc,
				probleme,
				id_cmd_frn,
				id_serie_nouv,
				id_bon_transp,
				dte_rcp_frn,
				dte_env_cli,
				cod_etat,
				comment_frn,
				nom_gest,
				id_lot_cmd,
				cmd_gen_le,
				cmd_gen_par,
				cree_le,
				maj_le,
				maj_par,
				valide_le,
				valide_par,
				id_zone,
				id_bsp,
				dte_ret_pret,
				adr_cod_civ,
				id_ref_four,
				id_orian_marque,
				id_orian_modele,
				dte_elv_mobile,
				status_gc,
				dte_emis_devis,
				mt_devis,
				alt_dev_acp,
				dte_dev_acp,
				adrfc_cod_civ,
				adrfc_nom,
				adrfc_prenom,
				adrfc_livr1,
				adrfc_livr2,
				adrfc_livr_cpl,
				adrfc_cp,
				adrfc_ville,
				dte_ret_logis,
				dte_ret_pret_min,
				dte_ret_pret_max,
				id_ann,
				dte_env_bte_frn,
				dte_rcp_bte_cli,
				dte_dep_bte_cli,
				dte_env_st,
				dte_rcp_mob_cli,
				info_spb_frn,
				id_marq_art_ifr,
				id_modl_art_ifr,
				info_spb_frn_cplt,
				info_frn_spb_cplt)

		Select		
				@dcIdSin,
				id_seq,
				id_gti,
				id_detail,
				id_four,
				id_typ_art,
				id_marq_art,
				id_modl_art,
				mt_ttc_cmde,
				adr_nom,
				adr_prenom,
				adr_livr1,
				adr_livr2,
				adr_livr_cpl,
				adr_cp,
				adr_ville,
				adr_tel1,
				adr_tel2,
				adr_tel3,
				adr_mail,
				dte_rdv_cli,
				hrdv_cli_min,
				hrdv_cli_max,
				id_serie_anc,
				probleme,
				id_cmd_frn,
				id_serie_nouv,
				id_bon_transp,
				dte_rcp_frn,
				dte_env_cli,
				cod_etat,
				comment_frn,
				nom_gest,
				id_lot_cmd,
				cmd_gen_le,
				cmd_gen_par,
				cree_le,
				maj_le,
				maj_par,
				valide_le,
				valide_par,
				id_zone,
				id_bsp,
				dte_ret_pret,
				adr_cod_civ,
				id_ref_four,
				id_orian_marque,
				id_orian_modele,
				dte_elv_mobile,
				status_gc,
				dte_emis_devis,
				mt_devis,
				alt_dev_acp,
				dte_dev_acp,
				adrfc_cod_civ,
				adrfc_nom,
				adrfc_prenom,
				adrfc_livr1,
				adrfc_livr2,
				adrfc_livr_cpl,
				adrfc_cp,
				adrfc_ville,
				dte_ret_logis,
				dte_ret_pret_min,
				dte_ret_pret_max,
				id_ann,
				dte_env_bte_frn,
				dte_rcp_bte_cli,
				dte_dep_bte_cli,
				dte_env_st,
				dte_rcp_mob_cli,
				info_spb_frn,
				id_marq_art_ifr,
				id_modl_art_ifr,
				info_spb_frn_cplt,
				info_frn_spb_cplt
		From	sysadm.commande
		Where	id_sin = @dcIdSin		

Insert into SIMPA2_MODFOR.sysadm.refus ( 
				id_sin,
				id_gti,
				id_detail,
				id_motif,
				alt_mac,
				alt_ope,
				id_i,
				id_para,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par)

		Select		
				@dcIdSin,
				id_gti,
				id_detail,
				id_motif,
				alt_mac,
				alt_ope,
				id_i,
				id_para,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par				
		From	sysadm.refus
		Where	id_sin = @dcIdSin		
		
Insert into SIMPA2_MODFOR.sysadm.reglement ( 		
				id_sin,
				id_reg,
				mt_tot_reg,
				lib_reg,
				dte_reg,
				rib_bq,
				rib_gui,
				rib_cpt,
				rib_cle,
				cod_inter,
				cod_mode_reg,
				cod_mot_reg,
				id_i,
				id_reg_base,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par,
				num_let_cheque )

		Select		
				@dcIdSin,	
				id_reg,
				mt_tot_reg,
				lib_reg,
				dte_reg,
				rib_bq,
				rib_gui,
				rib_cpt,
				rib_cle,
				cod_inter,
				cod_mode_reg,
				cod_mot_reg,
				id_i,
				id_reg_base,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par,
				num_let_cheque						
		From	sysadm.reglement
		Where	id_sin = @dcIdSin		

Insert into SIMPA2_MODFOR.sysadm.reg_gti ( 		
				id_sin,
				id_reg,
				id_gti,
				id_rgpt,
				id_i,
				mt_reg,
				mt_rgpt,
				cree_le,
				maj_le,
				maj_par)

		Select		
				@dcIdSin,
				id_reg,
				id_gti,
				id_rgpt,
				id_i,
				mt_reg,
				mt_rgpt,
				cree_le,
				maj_le,
				maj_par				
		From	sysadm.reg_gti
		Where	id_sin = @dcIdSin						
		
Insert into SIMPA2_MODFOR.sysadm.frais ( 				
				id_sin,
				id_i,
				id_frais,
				id_typ_frais,
				lib_frais,
				mt_frais,
				id_reg,
				cod_etat,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par)

		Select		
				@dcIdSin,
				id_i,
				id_frais,
				id_typ_frais,
				lib_frais,
				mt_frais,
				id_reg,
				cod_etat,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par
		From	sysadm.frais
		Where	id_sin = @dcIdSin						

Insert into SIMPA2_MODFOR.sysadm.archive ( 
				id_sin,
				id_inter,
				id_doc,
				id_cour,
				id_prod,
				id_ordre,
				id_adh,
				cod_version,
				cod_inter,
				nom,
				dte_edit,
				dte_conf,
				dte_archiv,
				dte_rep,
				alt_part,
				alt_pce,
				alt_ps,
				alt_rep,
				txt_compo1,
				txt_compo2,
				ref_doc_dt,
				ref_doc_cp,
				ref_doc_pc,
				ref_doc_ps,
				nbr_conf,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par,
				id_arch,
				id_cour_orig,
				id_doc_edt,
				id_canal,
				envoi_mail_le,
				dte_atlas_notif,
				dte_atlas_telecharg,
				dte_atlas_rappel,
				dte_edit_courrier_rappel,
				dte_echec_distrib_ksl)

		Select		
				@dcIdSin,
				id_inter,
				id_doc,
				id_cour,
				id_prod,
				id_ordre,
				id_adh,
				cod_version,
				cod_inter,
				nom,
				dte_edit,
				dte_conf,
				dte_archiv,
				dte_rep,
				alt_part,
				alt_pce,
				alt_ps,
				alt_rep,
				txt_compo1,
				txt_compo2,
				ref_doc_dt,
				ref_doc_cp,
				ref_doc_pc,
				ref_doc_ps,
				nbr_conf,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par,
				id_arch,
				id_cour_orig,
				id_doc_edt,
				id_canal,
				envoi_mail_le,
				dte_atlas_notif,
				dte_atlas_telecharg,
				dte_atlas_rappel,
				dte_edit_courrier_rappel,
				dte_echec_distrib_ksl		
		From	sysadm.archive
		Where	id_sin = @dcIdSin						

Insert into SIMPA2_MODFOR.sysadm.archive_blob ( 
				id_sin,
				id_inter,
				id_doc,
				id_typ_blob,
				txt_blob,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par)

		Select		
				@dcIdSin,
				id_inter,
				id_doc,
				id_typ_blob,
				txt_blob,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par
		From	sysadm.archive_blob 
		Where	id_sin = @dcIdSin						
				
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_GESTION_MODELE
-- Auteur               :       JFF
-- Date                 :       20/03/2014
-- Libell‚              :        
-- Commentaires         :       
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_GESTION_MODELE' AND type = 'P' )
        DROP procedure sysadm.PS_GESTION_MODELE
GO

CREATE procedure sysadm.PS_GESTION_MODELE
        @dcIdSin        Decimal ( 7, 0 ),
        @id_modele		Integer,
        @sModeleACreer  VarChar ( 800 ),
        @lib_modele		varchar ( 255 ),
        @def_modele		varchar ( 255 )        
AS

If @dcIdSin is not null
  Begin
	Exec sysadm.PS_CREATION_MODELE @dcIdSin, @id_modele, @lib_modele, @def_modele
	Insert into SIMPA2_MODFOR.sysadm.result_creation values ( 'Modèle numéro ' + CONVERT (varchar ( 5 ), @id_modele ) + ' créé.', GETDATE(), 'JFF', GETDATE(), 'JFF' )	
  End 
Else
  Begin 
  	If CHARINDEX ( '#' + Convert ( VarChar ( 10),  @id_modele ) + '#', @sModeleACreer ) <= 0 
	 Begin
		Insert into SIMPA2_MODFOR.sysadm.result_creation  values ( 'Modèle numéro ' + CONVERT (varchar ( 5 ), @id_modele ) + ', création non demandée.' , GETDATE(), 'JFF', GETDATE(), 'JFF' )	
	 End 
	Else
	 Begin
 	    Insert into SIMPA2_MODFOR.sysadm.result_creation values ( 'Modèle numéro ' + CONVERT (varchar ( 5 ), @id_modele ) + ' non créé, pas d''id_sin trouvé.'	, GETDATE(), 'JFF', GETDATE(), 'JFF' )	
 	 End
  End 

Go


/*
Select sc.name + ','
From sysobjects so,
     syscolumns sc
where so.type = 'U'
And   sc.id   = so.id
And   so.name = 'modele'
order by colorder
*/

-- personne
-- sinistre
-- div_sin
-- inter
-- gar_sin
-- detail
-- div_det
-- commande
-- refus
-- reglement
-- reg_gti
-- frais
-- archive
-- archive_blob



-- Ramener aussi les tables permanentes + modèles à mettre à jour.

-- w_sin
-- w_inter
-- w_frais
-- w_div_sin
-- w_gar_sin
-- w_detail
-- w_div_det
-- w_commande
-- w_piece
-- w_refus
-- w_courrier
-- w_cour_blob
-- w_inter_blob
-- w_para_info
-- w_para_plafond
-- w_reg_gti


