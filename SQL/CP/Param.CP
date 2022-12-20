-------------------------------------------------------------------
--
-- Fichier                      : param.cp
-- Auteur                       : Fabry JF
-- Date                         : 28/08/02
--
-- Commentaires                 : Suite DCMP020307 de L. Fouquier, création du PARAM.CP
--                                Select de 17 tables de paramètrage, déchargées en fichier Excel
--                                afin qu'SO puisse avoir une vue global du paramètrage et rechercher
--                                rapidement une information.
--
--                               : Suite DCMP050470 de M. Hamery , déchargement des tables de param supplémentaire :
--                                 Affilier,Det_Pro, Div_Pro, Div_Pdet, Commande_Type, Autorisation ,Revision         
--
--			: DCMP 070051 Modification de DW_S16_PARAM_COURRIER
--
-- Procédures                   :
-- Fonctions                    : DW_S01_PARAM_CODE
--                                DW_S02_PARAM_CODE_CAR
--                                DW_S03_PARAM_PRODUIT
--                                DW_S04_PARAM_CODE_GARANTIE
--                                DW_S05_PARAM_CODE_CONDITION
--                                DW_S06_PARAM_PIECE
--                                DW_S07_PARAM_MOTIF
--                                DW_S08_PARAM_GROUPE
--                                DW_S09_PARAM_ETABLISSEMENT
--                                DW_S10_PARAM_CARTE
--                                DW_S11_PARAM_POLICE
--                                DW_S12_PARAM_COMPAGNIE
--                                DW_S13_PARAM_DEPARTEMENT
--                                DW_S14_PARAM_TARIF_PAPIER
--                                DW_S15_PARAM_PARAGRAPHE
--                                DW_S16_PARAM_COURRIER
--                                DW_S17_PARAM_COMPOSITION
--                                DW_S18_PARAM_AFFILIER
--                                DW_S19_PARAM_DET_PRO   
--                                DW_S20_PARAM_DIV_PRO
--                                DW_S21_PARAM_DIV_PDET 
--                                DW_S22_PARAM_COMMANDE_TYPE  
--                                DW_S23_PARAM_AUTORISATION
--                                DW_S24_PARAM_REVISION
--                                DW_S25_PARAM_BOUTIQUE
--                                DW_S26_PARAM_COUR_TYPE	--DCMP060749
--                                DW_S27_PARAM_PARA_PROD	--DCMP060749
--                                DW_S28_PARAM_GARANTIE		--DCMP060749
--                                DW_S29_PARAM_DELAI		--DCMP060749
--                                DW_S30_PARAM_FRANCHISE	--DCMP060749
--                                DW_S31_PARAM_CONDITION	--DCMP060749
--                                DW_S32_PARAM_PLAFOND		--DCMP060749
--                                DW_S33_PARAM_CORB_OPER	--DCMP060749
-------------------------------------------------------------------

-------------------------------------------------------------------
--
-- Procédure            :       DW_S01_PARAM_CODE
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table CODE
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PARAM_CODE' AND type = 'P' )
            DROP procedure sysadm.DW_S01_PARAM_CODE
GO

CREATE PROC sysadm.DW_S01_PARAM_CODE
   
AS

Select 
        id_typ_code,                    
        id_code,                        
        lib_code,                       
        cree_le,                        
        maj_le,                         
        maj_par                        
From    sysadm.code
Order By id_typ_code, id_code

GO

-------------------------------------------------------------------
--
-- Procédure            :       DW_S02_PARAM_CODE_CAR
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table CODE_CAR
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_PARAM_CODE_CAR' AND type = 'P' )
            DROP procedure sysadm.DW_S02_PARAM_CODE_CAR
GO

CREATE PROC sysadm.DW_S02_PARAM_CODE_CAR
   
AS

Select 
        id_typ_code,                    
        id_code,                        
        lib_code,                       
        cree_le,                        
        maj_le,                         
        maj_par                        
From    sysadm.code_car
order by id_typ_code, id_code

GO


-------------------------------------------------------------------
--
-- Procédure            :       DW_S03_PARAM_PRODUIT
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table Produit
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_PARAM_PRODUIT' AND type = 'P' )
            DROP procedure sysadm.DW_S03_PARAM_PRODUIT
GO

CREATE PROC sysadm.DW_S03_PARAM_PRODUIT
   
AS

Select
        id_prod as 'Produit',                        
        id_dept as 'Departement',                        
        id_grp  Groupe_Banque,                         
        lib_court Lib_Court_Produit,                      
        lib_long Lib_Court_Produit,                       
        cod_rev_surv Revision_Surv,                   
        cod_rev_sous Revision_Sous,                                      
        cod_rev_rnv Revision_Renouv,                                     
        dur_perrnv_adh Duree_Per_Rnv_Adh,                 
        unt_perrnv_adh Unite_Per_Rnv_Adh,                 
        cod_mode_reg Mode_de_Reglement,                   
        lib_bq_debit Lib_Banque_Debiteur,                   
        rib_bq Rib_Banque,                         
        rib_gui Rib_Guichet,                        
        rib_cpt Rib_Compte,                        
        rib_cle Rib_Cle,                        
        cod_dest_reg Dest_Regl_Defaut,                   
        cod_adh Methode_Adhesion_MA,                        
        id_corb Corbeille_CO,                        
        id_police Police,                      
        num_tel Telephone_Produit,                        
        num_fax Fax_Produit,                        
        id_depts Sous_Departement,                       
        cod_niv_ope Niveau_Operateur_NO,                    
        cod_base_dms Base_Adhesion,                   
        cod_adr_dms Gestion_Adresse,                    
        cod_prod_dms Num_Prod_Adh,                   
        alt_crebq_dms Creation_auto_banque ,                  
        nb_adherent Nbre_Max_Adherent,                    
        cod_euro Methode_Aff_Regl_EU,                       
        alt_info_prov Information_Provision,                  
        alt_rl1 Gestion_Premiere_Relance,                        
        dur_rl1_min Duree_Min_Premiere_Relance,                    
        dur_rl1_max Duree_Max_Premiere_Relance,                                        
        unt_rl1 Unite_Duree_Premiere_Relance,                        
        alt_rl2 Gestion_Deuxieme_Relance,                        
        dur_rl2 Duree_Deuxieme_Relance,                                            
        unt_rl2 Unite_Duree_Deuxieme_Relance,                        
        alt_sold Gestion_Soldage_Automatique,                       
        dur_sold_rl,                    
        unt_sold_rl,                    
        dur_sold_pc,                    
        unt_sold_pc,                    
        alt_contact Gestion_de_contact,                    
        cod_tel Gestion_Telephonie,                        
        alt_ouvfenval Ouverture_Auto_Fen_Validation,                  
        alt_cmd_mobile Gestion_des_commandes, 
        id_prod_client Code_Produit_Client,
        alt_cod_boutique Gestion_Boutique_Manuelle,
        cpt_cmd  Compteur_Cmde_Client,
        cree_le,                        
        maj_le Derniere_maj_le,                         
        maj_par Derniere_maj_par                       

From    sysadm.produit
Order By id_prod

GO

-------------------------------------------------------------------
--
-- Procédure            :       DW_S04_PARAM_CODE_GARANTIE
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table Code_Garantie
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_PARAM_CODE_GARANTIE' AND type = 'P' )
            DROP procedure sysadm.DW_S04_PARAM_CODE_GARANTIE
GO

CREATE PROC sysadm.DW_S04_PARAM_CODE_GARANTIE
AS

Select 
        cg.id_prod Produit,                        
        cg.id_gti Garantie,                         
        c.lib_code Libelle_Garantie_Original,
        cg.lib_gti Libelle_Garantie_Modifie,                        
        cg.cree_le,                        
        cg.maj_le Derniere_maj_le,                         
        cg.maj_par Derniere_maj_par                       
From    sysadm.code_garantie cg,
        sysadm.code c
Where   c.id_typ_code = '-GA'
And     c.id_code = cg.id_gti
Order By cg.id_prod, cg.id_gti

Go


-------------------------------------------------------------------
--
-- Procédure            :       DW_S05_PARAM_CODE_CONDITION
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table Code_Condition
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S05_PARAM_CODE_CONDITION' AND type = 'P' )
            DROP procedure sysadm.DW_S05_PARAM_CODE_CONDITION
GO

CREATE PROC sysadm.DW_S05_PARAM_CODE_CONDITION
   
AS

Select 
        cc.id_prod Produit,                        
        cc.id_typ_code Type_De_Code,                    
        cc.id_code Code,                        
        c.lib_code Libelle_Des_Codes,
        cc.id_gti Garantie,                         
        cgti.lib_code Libelle_Des_Garanties,
        cc.lib_evt Libelle_Sur_Courrier,                        
        cc.cree_le,                        
        cc.maj_le Derniere_maj_le,                         
        cc.maj_par Derniere_maj_par                       
From    sysadm.code_condition cc,
        sysadm.code c,
        sysadm.code cgti
Where   c.id_typ_code = cc.id_typ_code 
And     c.id_code = cc.id_code
And     cgti.id_typ_code = '-GA'
And     cgti.id_code = cc.id_gti
Order By cc.id_prod, cc.id_gti, cc.id_typ_code, cc.id_code

Go

-------------------------------------------------------------------
--
-- Procédure            :       DW_S06_PARAM_PIECE
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table Piece
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S06_PARAM_PIECE' AND type = 'P' )
            DROP procedure sysadm.DW_S06_PARAM_PIECE
GO

CREATE PROC sysadm.DW_S06_PARAM_PIECE
AS

Select 
        p.id_prod Produit,                        
        p.id_rev Revision,                         
        p.id_gti Garantie,                         
        cgti.lib_code Libelle_Des_Garanties,
        p.id_pce Piece_PC,                         
        cpce.lib_code Libelle_Des_Piece,
        p.id_para Paragraphe,                        
        Case p.cod_typ_pce 
         When 'G' Then 'Sur Garantie'
         When 'E' Then 'Sur Evenement'
        End Sur_Garantie_Ou_Evenement,                    
        p.cpt_tri Tri_Aff_Ecran,                        
        p.cree_le,                        
        p.maj_le Derniere_maj_le,                         
        p.maj_par Derniere_maj_par                       
From    sysadm.piece p,
        sysadm.code cpce,
        sysadm.code cgti
Where   cpce.id_typ_code = '+PC'
And     cpce.id_code = p.id_pce
And     cgti.id_typ_code = '-GA'
And     cgti.id_code = p.id_gti
Order By p.id_prod, p.id_gti, p.id_pce

Go


-------------------------------------------------------------------
--
-- Procédure            :       DW_S07_PARAM_MOTIF
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table Motif
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S07_PARAM_MOTIF' AND type = 'P' )
            DROP procedure sysadm.DW_S07_PARAM_MOTIF
GO

CREATE PROC sysadm.DW_S07_PARAM_MOTIF
AS

Select 
        m.id_prod Produit,                        
        m.id_rev Revision,                         
        m.id_gti Garantie,                         
        cgti.lib_code Libelle_Des_Garanties,
        m.id_motif Refus_RE,                       
        cref.lib_code Libelle_Des_Refus,
        m.id_para Paragraphe,                        
        Case m.cod_typ_motif 
         When 'G' Then 'Sur Garantie'
         When'E' Then 'Sur Evenement'
        End Sur_Garantie_Ou_Evenement,                    
        m.cpt_tri Tri_Aff_Ecran,                        
        m.cree_le,                        
        m.maj_le Derniere_maj_le,                         
        m.maj_par Derniere_maj_par                       
From    sysadm.motif m,
        sysadm.code cref,
        sysadm.code cgti
Where   cref.id_typ_code = '+RE'
And     cref.id_code = m.id_motif
And     cgti.id_typ_code = '-GA'
And     cgti.id_code = m.id_gti
Order By m.id_prod, m.id_gti, m.id_motif

Go


-------------------------------------------------------------------
--
-- Procédure            :       DW_S08_PARAM_GROUPE
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table Groupe
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S08_PARAM_GROUPE' AND type = 'P' )
            DROP procedure sysadm.DW_S08_PARAM_GROUPE
GO

CREATE PROC sysadm.DW_S08_PARAM_GROUPE
AS

Select 
        id_grp Groupe,                         
        id_grp_base Groupe_de_reference,                    
        lib_grp Libelle_du_groupe,                        
        cree_le,                        
        maj_le Derniere_maj_le,                         
        maj_par Derniere_maj_par                       
From    sysadm.groupe
Order By id_grp_base, id_grp

Go

-------------------------------------------------------------------
--
-- Procédure            :       DW_S09_PARAM_ETABLISSEMENT
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table Etablissement
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S09_PARAM_ETABLISSEMENT' AND type = 'P' )
            DROP procedure sysadm.DW_S09_PARAM_ETABLISSEMENT
GO

CREATE PROC sysadm.DW_S09_PARAM_ETABLISSEMENT
AS

Select 
        id_prod Produit,                        
        id_grp Groupe_Bancaire,                         
        id_rev Revision,                         
        id_ets Etablissement,                         
        cree_le,                        
        maj_le Derniere_maj_le,                         
        maj_par Derniere_maj_par                       
From    sysadm.etablissement
Order By id_prod, id_grp, id_ets

Go


-------------------------------------------------------------------
--
-- Procédure            :       DW_S10_PARAM_CARTE
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table Carte
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S10_PARAM_CARTE' AND type = 'P' )
            DROP procedure sysadm.DW_S10_PARAM_CARTE
GO

CREATE PROC sysadm.DW_S10_PARAM_CARTE
AS

Select 
        c.id_carte identifiant_BIN,                       
        c.id_type_carte type_de_carte_TC,                  
        cgrp.lib_code Libelle_Du_Type_De_Carte,
        c.id_grp Groupe_Bancaire,                         
        c.lib_carte Libelle_BIN,                      
        c.val_rg_mini BIN_Mini,                    
        c.val_rg_max BIN_Maxi,                     
        c.cree_le,                        
        c.maj_le Derniere_maj_le,                         
        c.maj_par Derniere_maj_par                       
From    sysadm.carte c,
        sysadm.code_car cgrp
Where   cgrp.id_typ_code = '-TC'
And     cgrp.id_code = c.id_type_carte
Order By c.id_carte

Go

-------------------------------------------------------------------
--
-- Procédure            :       DW_S11_PARAM_POLICE
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table Police
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S11_PARAM_POLICE' AND type = 'P' )
            DROP procedure sysadm.DW_S11_PARAM_POLICE
GO

CREATE PROC sysadm.DW_S11_PARAM_POLICE
AS

Select 
        p.id_police identifiant_Police,                      
        p.id_cie identifiant_Compagnie,                         
        c.lib_cie Libelle_Compagnie,
        p.lib_police Libelle_Police,                     
        p.cree_le,                        
        p.maj_le Derniere_maj_le,                         
        p.maj_par Derniere_maj_par                       
From    sysadm.police p,
        sysadm.compagnie c
Where   p.id_cie = c.id_cie
Order By p.id_cie, p.id_police

Go

-------------------------------------------------------------------
--
-- Procédure            :       DW_S12_PARAM_COMPAGNIE
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table Compagnie
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S12_PARAM_COMPAGNIE' AND type = 'P' )
            DROP procedure sysadm.DW_S12_PARAM_COMPAGNIE
GO

CREATE PROC sysadm.DW_S12_PARAM_COMPAGNIE
AS

Select 
        id_cie Identifiant_Compagnie,                         
        lib_cie Libelle_Compagnie,                        
        cree_le,                        
        maj_le Derniere_maj_le,                         
        maj_par Derniere_maj_par                       
From    sysadm.compagnie
Order By id_cie

Go

-------------------------------------------------------------------
--
-- Procédure            :       DW_S13_PARAM_DEPARTEMENT
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table Departement
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S13_PARAM_DEPARTEMENT' AND type = 'P' )
            DROP procedure sysadm.DW_S13_PARAM_DEPARTEMENT
GO

CREATE PROC sysadm.DW_S13_PARAM_DEPARTEMENT
AS

Select 
        id_dept Identifiant_Departement,                        
        lib_dept Libelle_Departement,                       
        nom_rsp Nom_Responsable,                        
        cree_le,                        
        maj_le Derniere_maj_le,                         
        maj_par Derniere_maj_par                       
From    sysadm.departement
Order By lib_dept 

Go


-------------------------------------------------------------------
--
-- Procédure            :       DW_S14_PARAM_TARIF_PAPIER
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table Tarif_Papier
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S14_PARAM_TARIF_PAPIER' AND type = 'P' )
            DROP procedure sysadm.DW_S14_PARAM_TARIF_PAPIER
GO

CREATE PROC sysadm.DW_S14_PARAM_TARIF_PAPIER
AS

Select 
        id_seq Identifiant_Sequentiel,                         
        id_typ_papier Type_De_Papier,                  
        mt_eur Montant_En_Euros,                         
        mt_frf Montant_En_Francs,                
        id_dept Departement_Francais,                        
        dte_tarif Date_Effet_Du_Tarif,                      
        validite Duree_validite,                       
        information Information_Complementaire,                    
        num_tel Tel_Contact_Information,                        
        cree_le,                        
        maj_le Derniere_maj_le,                         
        maj_par Derniere_maj_par                       
From    sysadm.tarif_papier
Order By id_typ_papier, id_seq

Go

-------------------------------------------------------------------
--
-- Procédure            :       DW_S15_PARAM_PARAGRAPHE
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table Departement
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S15_PARAM_PARAGRAPHE' AND type = 'P' )
            DROP procedure sysadm.DW_S15_PARAM_PARAGRAPHE
GO

CREATE PROC sysadm.DW_S15_PARAM_PARAGRAPHE
AS

Select 
        id_para Identifiant_Paragraphe,                        
        lib_para Libelle_Paragraphe,                       
        cpt_ver Compteur_Version,                        
        cree_le,                        
        maj_le Derniere_maj_le,                         
        maj_par Derniere_maj_par                       
From    sysadm.paragraphe
Order By id_para

Go

-------------------------------------------------------------------
--
-- Procédure            :       DW_S16_PARAM_COURRIER
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table Courrier
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
-- #1 JCA	25/04/2007 DCMP 070051 - Merge des tables [composition] et [courrier] en [cour_prod]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S16_PARAM_COURRIER' AND type = 'P' )
            DROP procedure sysadm.DW_S16_PARAM_COURRIER
GO

CREATE PROC sysadm.DW_S16_PARAM_COURRIER
AS

Select 
        id_prod Produit,                        
        id_nat_cour Nature_Composee_Par_La_Machine,                    
        id_cour Code_Courrier_Associe,
        cree_le,                        
        maj_le Derniere_maj_le,                         
        maj_par Derniere_maj_par
-- #1
-- From    sysadm.courrier
FROM	sysadm.cour_prod
Order By id_prod, id_nat_cour, id_cour

Go

-------------------------------------------------------------------
--
-- Procédure            :       DW_S17_PARAM_COMPOSITION
-- Auteur               :       FABRY JF
-- Date                 :       28/08/02 
-- Libellé              :       Table Composition
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S17_PARAM_COMPOSITION' AND type = 'P' )
            DROP procedure sysadm.DW_S17_PARAM_COMPOSITION
GO

CREATE PROC sysadm.DW_S17_PARAM_COMPOSITION
AS

Select 
        ct.id_cour Code_Courrier,
        ct.lib_cour Intitule_du_courrier,
        ct.lib_modele Modele_word_Associe,
        cp.id_para Composition_Du_Courrier,
        cp.id_ordre Ordre_Des_Para_Dans_Compo
From    sysadm.cour_type ct,
        sysadm.composition cp
Where    ct.id_cour = cp.id_cour
Order By ct.id_cour, cp.id_ordre

Go

-------------------------------------------------------------------
--
-- Procédure            :       DW_S18_PARAM_AFFILIER
-- Auteur               :       FABRY JF
-- Date                 :       28/12/05 
-- Libellé              :       Table Affilier
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S18_PARAM_AFFILIER' AND type = 'P' )
            DROP procedure sysadm.DW_S18_PARAM_AFFILIER
GO

CREATE PROC sysadm.DW_S18_PARAM_AFFILIER
AS

Select  
        A.id_prod Produit,
        P.lib_long Libelle_produit,
        A.id_rev Revision,
        A.id_gti garantie,
        cGA.lib_code Libelle_garantie,
        A.id_carte Identifiant_Bin,
        C.lib_carte Libelle_carte,
        A.dte_affiliation Date_affiliation,
        A.cree_le ,
        A.maj_le Derniere_maj_le,
        A.maj_par Derniere_maj_par
        
From    sysadm.affilier A ,
        sysadm.code cGA ,
        sysadm.produit P ,
        sysadm.carte C
        
Where   cGA.id_typ_code = '-GA'
And     cGA.id_code = A.id_gti
And     A.id_prod = P.id_prod
And     A.id_carte = C.id_carte
Order By A.id_prod, A.id_rev, A.id_gti

Go

-------------------------------------------------------------------
--
-- Procédure            :       DW_S19_PARAM_DET_PRO
-- Auteur               :       MADANI M
-- Date                 :       30/12/05 
-- Libellé              :       Table DET_PRO
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S19_PARAM_DET_PRO' AND type = 'P' )
            DROP procedure sysadm.DW_S19_PARAM_DET_PRO
GO

CREATE PROC sysadm.DW_S19_PARAM_DET_PRO
AS

Select  
        dp.id_prod produit,
        dp.id_typ_code_dp id_typ_code,
        dp.id_code_dp id_code,
        cDP.lib_code Libelle_code ,
        dp.id_typ_calc id_typ_calc,
        dp.id_code_num code_numerique,
        dp.id_code_car code_cararactere,
        dp.val_num val_numerique,
        dp.val_car Val_cararactere,
        dp.unt Unite,
        dp.tri Tri,
        dp.cree_le Cree_le,
        dp.maj_le Derniere_maj_le ,
        dp.maj_par Derniere_maj_par
        
From    sysadm.det_pro dp ,
        sysadm.code    cDP 
        
Where   cDP.id_typ_code = '-DP'
And     cDP.id_code = dp.id_code_dp
order by dp.id_prod, dp.id_code_dp,dp.id_code_num,dp.id_code_car,dp.val_num,dp.val_car


Go


-------------------------------------------------------------------
--
-- Procédure            :       DW_S20_PARAM_DIV_PRO
-- Auteur               :       MADANI M
-- Date                 :       30/12/05 
-- Libellé              :       Table DIV_PRO
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S20_PARAM_DIV_PRO' AND type = 'P' )
            DROP procedure sysadm.DW_S20_PARAM_DIV_PRO
GO

CREATE PROC sysadm.DW_S20_PARAM_DIV_PRO
AS

Select  
        dvp.id_prod Produit,
        dvp.nom_zone Nom_zone,
        dvp.lib_label Lib_label,
        dvp.id_typ_liste Id_typ_liste,
        dvp.alt_liste_codecar Alt_liste_codecar,
        dvp.id_typ_zone Id_typ_zone,
        ccDVP.lib_code Libelle_code ,
        dvp.alt_oblig Alt_oblig,
        dvp.cpt_tri Cpt_tri,
        dvp.cree_le,
        dvp.maj_le,
        dvp.maj_par
        
From    sysadm.div_pro dvp,
        sysadm.code_car ccDVP
        
Where   ccDVP.id_typ_code = '-UT'
And     ccDVP.id_code = dvp.id_typ_zone  

Go


-------------------------------------------------------------------
--
-- Procédure            :       DW_S21_PARAM_DIV_PDET
-- Auteur               :       MADANI M
-- Date                 :       30/12/05 
-- Libellé              :       Table DIV_PDET
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S21_PARAM_DIV_PDET' AND type = 'P' )
            DROP procedure sysadm.DW_S21_PARAM_DIV_PDET
GO

CREATE PROC sysadm.DW_S21_PARAM_DIV_PDET
AS

Select  
        dvpdt.id_prod Produit,
        dvpdt.id_gti Garantie,
        cGA.lib_code Libelle_garantie,
        dvpdt.nom_zone Nom_zone,
        dvpdt.lib_label Libelle_label,
        dvpdt.id_typ_liste Id_typ_liste,
        dvpdt.alt_liste_codecar Alt_liste_codecar,
        dvpdt.id_typ_zone Id_typ_zone,
        ccPDET.lib_code Libelle_code,
        dvpdt.alt_oblig Alt_oblig,
        dvpdt.cpt_tri Cpt_tri,
        dvpdt.cree_le,
        dvpdt.maj_le,
        dvpdt.maj_par  
        
From    sysadm.div_pdet dvpdt,
        sysadm.code cGA,
        sysadm.code_car ccPDET
        
Where   cGA.id_typ_code = '-GA'
And     cGA.id_code = dvpdt.id_gti  
And     ccPDET.id_typ_code = '-UT'
And     ccPDET.id_code = dvpdt.id_typ_zone 

Go

-------------------------------------------------------------------
--
-- Procédure            :       DW_S22_PARAM_COMMANDE_TYPE
-- Auteur               :       MADANI M
-- Date                 :       30/12/05 
-- Libellé              :       Table COMMANDE_TYPE
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S22_PARAM_COMMANDE_TYPE' AND type = 'P' )
            DROP procedure sysadm.DW_S22_PARAM_COMMANDE_TYPE
GO

CREATE PROC sysadm.DW_S22_PARAM_COMMANDE_TYPE
AS

Select  
         cmdt.id_prod Produit,
         cmdt.id_gti Garantie,
         cGA.lib_code Libelle_garantie,
         cmdt.id_code_frn Code_frn,
         ccFR.lib_code Libelle_frn,
         cmdt.id_code_art Code_art,
         ccAR.lib_code Libelle_art,
         cmdt.alt_code_def Alt_code_def,
         cmdt.cree_le,
         cmdt.maj_le,
         cmdt.maj_par,
         cmdt.id_typ_code id_typ_code,
         cmdt.id_code Id_code,
         Case
               When (Select cGA.lib_code
                            from sysadm.code cGA
                            Where cGA.id_typ_code = cmdt.id_typ_code
               And   cGA.id_code = cmdt.id_code) is null Then 'Aucun libellé'
               Else (Select cGA.lib_code
                            from sysadm.code cGA 
                            Where cGA.id_typ_code = cmdt.id_typ_code
                            And   cGA.id_code = cmdt.id_code)
         END as 'Libellé'                    
                
From    sysadm.commande_type cmdt,
        sysadm.code cGA,
        sysadm.code_car ccFR,
        sysadm.code_car ccAR
                
Where   cGA.id_typ_code = '-GA'
And     cGA.id_code = cmdt.id_gti  
And     ccFR.id_typ_code = '-FR'
And     ccFR.id_code = cmdt.id_code_frn
And     ccAR.id_typ_code = '-AR'
And     ccAR.id_code = cmdt.id_code_art

Go

-------------------------------------------------------------------
--
-- Procédure            :       DW_S23_PARAM_AUTORISATION
-- Auteur               :       MADANI M
-- Date                 :       30/12/05 
-- Libellé              :       Table Autorisation
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S23_PARAM_AUTORISATION' AND type = 'P' )
            DROP procedure sysadm.DW_S23_PARAM_AUTORISATION
GO

/*-------------------------------------------------------------------
[DATABASE] SIMPA2_PRO
[DESCRIPTION] 
[MAJ PAR] DATAFLY - AFX
[DATEMAJ] 15/10/2009

[VARIABLES]
    non
-------------------------------------------------------------------*/
CREATE PROC [sysadm].[DW_S23_PARAM_AUTORISATION]
AS 
    IF @@servername = master.dbo.SPB_FN_ServerName('PRO') 
        BEGIN
            SELECT  A.id_nat_oper Id_nat_operateur,
                    C.lib_code Libelle_nature_operateur,
                    A.id_oper Id_operateur,
                    OP.nom Nom_operateur,
                    OP.prenom Prenom_operateur,
                    A.id_prod Produit,
                    CASE WHEN A.id_prod = -1 THEN 'TOUS PRODUITS'
                         ELSE P.lib_long
                    END AS 'Libelle_produit',
                    A.cree_le Cree_le,
                    A.maj_le Derniere_maj_le,
                    A.maj_par Derniere_maj_par
            FROM    sysadm.autorisation AS A
                    INNER JOIN SESAME_PRO.sysadm.operateur AS OP ON A.id_oper = OP.id_oper
                    INNER JOIN sysadm.code AS C ON CONVERT(DECIMAL(7), A.id_nat_oper) = C.id_code
                    LEFT OUTER JOIN sysadm.produit AS P ON A.id_prod = P.id_prod
            WHERE   C.id_typ_code = '-NA'
        END
    ELSE 
        BEGIN
            SELECT  A.id_nat_oper Id_nat_operateur,
                    C.lib_code Libelle_nature_operateur,
                    A.id_oper Id_operateur,
                    NULL,
                    NULL,
                    A.id_prod Produit,
                    CASE WHEN A.id_prod = -1 THEN 'TOUS PRODUITS'
                         ELSE P.lib_long
                    END AS 'Libelle_produit',
                    A.cree_le Cree_le,
                    A.maj_le Derniere_maj_le,
                    A.maj_par Derniere_maj_par
            FROM    sysadm.autorisation AS A
                    LEFT OUTER JOIN sysadm.produit AS P ON A.id_prod = P.id_prod
                    INNER JOIN sysadm.code AS C ON CONVERT(DECIMAL(7), A.id_nat_oper) = C.id_code
            WHERE   C.id_typ_code = '-NA'
        END

GO

-------------------------------------------------------------------
--
-- Procédure            :       DW_S24_PARAM_REVISION
-- Auteur               :       MADM
-- Date                 :       17/01/06 
-- Libellé              :       Table Revision
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S24_PARAM_REVISION' AND type = 'P' )
            DROP procedure sysadm.DW_S24_PARAM_REVISION
GO

CREATE PROC sysadm.DW_S24_PARAM_REVISION
AS

Select  
        R.id_prod Produit,
        sysadm.FN_LIB_PROD(R.id_prod) as 'Libelle_produit',
        R.id_rev Revision,
        R.lib_rev Libelle_revision,
        R.cod_eff_rev Code_effet_revision,
        R.dte_eff Date_effet_revision,
        R.dte_fin Date_fin_revision,
        R.cree_le ,
        R.maj_le Derniere_maj_le,
        R.maj_par Derniere_maj_par
        
From    sysadm.revision R 
Go

-------------------------------------------------------------------
--
-- Procédure            :       DW_S25_PARAM_BOUTIQUE
-- Auteur               :       PHG
-- Date                 :       06/09/2006 
-- Libellé              :       Table Boutique
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
-- #1    JFF    23/06/2008  [DCMP080287].FAX_MAIL ajout adr_mail_cc
-- #2    JFF    16/09/2008  [MICROMANIA] ajout cod_mag
-- #3	 JFF    20/10/2008  [FNAC_PROD_ECH_TECH]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S25_PARAM_BOUTIQUE' AND type = 'P' )
            DROP procedure sysadm.DW_S25_PARAM_BOUTIQUE
GO

CREATE PROC sysadm.DW_S25_PARAM_BOUTIQUE
AS

Select  
	b.id_prod 			as	'Code_Produit', 
	sysadm.FN_LIB_PROD(b.id_prod) 	as	'Libelle_produit',
	b.id_boutique 			as	'Code_Boutique',
	b.region			as	'Région', 
	b.adr_ville			as	'Ville', 
	b.adr_cp			as	'Code_Postal',
	b.adr_tel			as	'Téléphone',
	b.adr_fax			as	'Fax', 
	b.adr_mail			as	'Adresse_Mail', 
	b.adr_mail_cc			as	'Adresse_Mailcc', 	
	b.adr_nom			as	'Nom',
	b.cod_mag			as	'Code_Magasin',	
  	b.adr_1				as	'Adresse_1',  -- #3 [FNAC_PROD_ECH_TECH]
  	b.adr_2				as 	'Adresse_2',  -- #3 [FNAC_PROD_ECH_TECH]
 	b.responsable			as	'Responsable',  -- #3 [FNAC_PROD_ECH_TECH]
	b.adr_mail2			as	'Adresse_Mail2', -- #3 [FNAC_PROD_ECH_TECH]
	b.adr_mail_cc2			as	'Adresse_Mailcc2', -- #3 [FNAC_PROD_ECH_TECH]	
	b.cree_le			as	'Cree_le',
	b.maj_le			as	'Mis_à_Jour_Le', 
	b.maj_par			as	'Mis_à_jour_Par'
From    sysadm.boutique b
GO

-------------------------------------------------------------------
--
-- Procédure            :       DW_S26_PARAM_COUR_TYPE
-- Auteur               :       PHG
-- Date                 :      19/10/2006 
-- Libellé              :       Table Boutique
-- Commentaires         :
-- Références           :    [DCMP060749]   
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S26_PARAM_COUR_TYPE' AND type = 'P' )
            DROP procedure sysadm.DW_S26_PARAM_COUR_TYPE
GO

CREATE PROC sysadm.DW_S26_PARAM_COUR_TYPE
AS

select	id_cour	as 'Code_Courrier',
	lib_cour as 'Libelle_Courrier',
	lib_modele as 'Libelle_Modele',
	cree_le as	'Crée_le',
	maj_le as	'Mis_à_Jour_Le', 
	maj_par	as	'Mis_à_jour_Par'
from 	sysadm.cour_type
GO

-------------------------------------------------------------------
--
-- Procédure            :       DW_S27_PARAM_PARA_PROD
-- Auteur               :       PHG
-- Date                 :       19/10/2006 
-- Libellé              :       Table Boutique
-- Commentaires         :
-- Références           :        [DCMP060749] 
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S27_PARAM_PARA_PROD' AND type = 'P' )
            DROP procedure sysadm.DW_S27_PARAM_PARA_PROD
GO

CREATE PROC sysadm.DW_S27_PARAM_PARA_PROD
AS
select	id_prod 			as 'Code_Produit',
	sysadm.FN_LIB_PROD(id_prod)	as 'Libellé_produit',
	cree_le				as 'Crée_le',
	maj_le				as 'Mis_à_Jour_Le', 
	maj_par				as 'Mis_à_jour_Par'
from sysadm.para_prod
GO

-------------------------------------------------------------------
--
-- Procédure            :       DW_S28_PARAM_GARANTIE
-- Auteur               :       PHG
-- Date                 :       19/10/2006 
-- Libellé              :       Table Boutique
-- Commentaires         :
-- Références           :        [DCMP060749] 
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S28_PARAM_GARANTIE' AND type = 'P' )
            DROP procedure sysadm.DW_S28_PARAM_GARANTIE
GO

CREATE PROC sysadm.DW_S28_PARAM_GARANTIE
AS
select	g.id_prod as 'Code_Produit',
	sysadm.FN_LIB_PROD(g.id_prod)	as	'Libelle_Produit',
	g.id_rev			as 	'Code_Révision',
        r.lib_rev as 'Libelle_revision',
        r.cod_eff_rev as 'Code_effet_revision',
        r.dte_eff as 'Date_effet_revision',
        r.dte_fin as 'Date_fin_revision',
	g.id_gti  as 'Code_Garantie',
	cg.lib_gti	as 'Libelle_Garantie',
	g.id_police	as 'Code_Police',
	p.lib_police	as 'Libelle_Police',
	cp.lib_cie	as 'Libelle_Compagnie',
	g.cod_typ_fra	as 'Code_Type_Franchise',
	sysadm.FN_CODE_NUM(g.cod_typ_fra, '-FR') as 'Type_Franchise',
	g.alt_plaf,
	g.alt_del,
	g.alt_fran,
	g.cod_radical	as 'Code_Radical',
	g.cree_le	as 'Crée_le',
	g.maj_le	as 'Mis_à_Jour_Le', 
	g.maj_par	as 'Mis_à_jour_Par'
from 	sysadm.garantie g, 
	sysadm.revision r, 
	sysadm.code_garantie cg,
	sysadm.police p,
	sysadm.compagnie cp
where 	g.id_prod = cg.id_prod
and	g.id_gti  = cg.id_gti
and	g.id_prod = r.id_prod
and	g.id_rev  = r.id_rev
and 	g.id_police = p.id_police
and	p.id_cie    = cp.id_cie
GO

-------------------------------------------------------------------
--
-- Procédure            :       DW_S29_PARAM_DELAI
-- Auteur               :       PHG
-- Date                 :       19/10/2006 
-- Libellé              :       Table Delai
-- Commentaires         :
-- Références           :        [DCMP060749] 
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S29_PARAM_DELAI' AND type = 'P' )
            DROP procedure sysadm.DW_S29_PARAM_DELAI
GO

CREATE PROC sysadm.DW_S29_PARAM_DELAI
AS
select	d.id_prod as 'Code_Produit',
	sysadm.FN_LIB_PROD(d.id_prod)	as 'Libellé_produit',
	d.id_rev as 'Code_Revision',
        r.lib_rev as 'Libelle_revision',
	d.id_gti as 'Code_Garantie',
	cg.lib_gti	as 'Libelle_Garantie',
	d.id_niv_del 'Code_Niveau_délai',
	CASE d.id_niv_del
	 WHEN '-GA' THEN 'Garantie'
	 WHEN '+EV' THEN 'Evenement'
	 WHEN '+NS' THEN 'Nature de Sinistre'
	 WHEN '+TR' THEN 'Territorialité'
	 ELSE d.id_niv_del
	END as 'Niveau_du_délai',
	d.id_ref_del 'Code_evenement/nature/territorialité', 
	CASE d.id_niv_del
	 WHEN '-GA' THEN ''
	 ELSE sysadm.FN_CODE_NUM(d.id_ref_del,d.id_niv_del )
	END as 'Libelle_evenement/nature/territorialité',
	d.id_typ_del as 'Code_du_Type_de_Delai',
	sysadm.FN_CODE_CAR( d.id_typ_del,'-DL') as 'Type_de_délai', 
	d.id_cpt_del as 'Compteur_de_délai',
	d.dur_min 'Durée_Minimum',
	d.dur_max 'Durée_Maximum',
	d.unt_del as 'Code_Unité_de_temps',
	CASE d.unt_del 
	 WHEN 'M' THEN 'Mois'
	 WHEN 'J' THEN 'Jours'
	 WHEN 'H' THEN 'Heures'
	 ELSE 'Non_défini'
	END
	as 'Unité_de_Tempts',
	d.cree_le	as 'Crée_le',
	d.maj_le	as 'Mis_à_Jour Le', 
	d.maj_par	as 'Mis_à_jour Par'
from	sysadm.delai d,
	sysadm.revision r,
	sysadm.code_garantie cg
where	d.id_prod = r.id_prod
and	d.id_rev = r.id_rev
and	d.id_prod = cg.id_prod
and	d.id_gti = cg.id_gti
GO

-------------------------------------------------------------------
--
-- Procédure            :       DW_S30_PARAM_FRANCHISE
-- Auteur               :       PHG
-- Date                 :       19/10/2006 
-- Libellé              :       Table Franchise
-- Commentaires         :
-- Références           :      [DCMP060749]   
--
-- Arguments            :       
--
-- Retourne             :       
-- JFF  le 20/11/06 Je renseigne le lib_para par jointure externe (select dans el select)
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S30_PARAM_FRANCHISE' AND type = 'P' )
            DROP procedure sysadm.DW_S30_PARAM_FRANCHISE
GO

CREATE PROC sysadm.DW_S30_PARAM_FRANCHISE
AS
select	f.id_prod as 'Code_Produit',
	sysadm.FN_LIB_PROD(f.id_prod)	as 'Libellé_produit',
	f.id_rev as 'Code_Revision',
        r.lib_rev as 'Libelle_revision',
	f.id_gti as 'Code_Garantie',
	cg.lib_gti	as 'Libelle_Garantie',
	f.id_niv_fra 'Code_Niveau_Franchise',
	CASE f.id_niv_fra
	 WHEN '-GA' THEN 'Garantie'
	 WHEN '+EV' THEN 'Evenement'
	 WHEN '+NS' THEN 'Nature_de_Sinistre'
	 ELSE f.id_niv_fra
	END as 'Niveau_de_la_Franchise',
	f.id_ref_fra'Code_evenement/nature', 
	CASE f.id_niv_fra
	 WHEN '-GA' THEN ''
	 ELSE sysadm.FN_CODE_NUM(f.id_ref_fra,f.id_niv_fra )
	END as 'Libelle_evenement/nature',
	f.id_typ_fra as 'Code_du_Type_de_Franchise',
	sysadm.FN_CODE_CAR( f.id_typ_fra,'-FR') as 'Type_de_Franchise', 
	f.id_cpt_fra as 'Compteur_de_Franchise',
	f.mt_fra as 'Montant_de_la_franchise',
	f.id_para as 'code_Paragraphe',
	( Select lib_para
	  From sysadm.paragraphe p
	  Where f.id_para = p.id_para ) as 'Libelle_paragraphe', 
	f.dur_min 'Durée_Minimum',
	f.dur_max 'Durée_Maximum',
	f.unt_del as 'Code_Unité_de_temps',
	CASE f.unt_del 
	 WHEN 'M' THEN 'Minute'
	 WHEN 'J' THEN 'Jours'
	 WHEN 'H' THEN 'Heures'
	 ELSE 'Non_défini'
	END
	as 'Unité_de_Tempts',
	f.cree_le	as 'Crée_le',
	f.maj_le	as 'Mis_à_Jour_Le', 
	f.maj_par	as 'Mis_à_jour_Par'
from	sysadm.franchise f,
	sysadm.revision r,
	sysadm.code_garantie cg
where	f.id_prod = r.id_prod
and	f.id_rev = r.id_rev
and	f.id_prod = cg.id_prod
and	f.id_gti = cg.id_gti

GO

-------------------------------------------------------------------
--
-- Procédure            :       DW_S31_PARAM_CONDITION
-- Auteur               :       PHG
-- Date                 :       19/10/2006 
-- Libellé              :       Table Condition
-- Commentaires       : 	Un select Entier sera susceptible de remonter un 
--				nombre de ligne supérieure à 65536
--	 			La proc est donc parametrée pour ramenée un intervalle 
--				de produit afin de constituer plusieurs fichiers
--		
-- Références           :        [DCMP060749] 
--
-- Arguments            :        ai_Id_ProdDeb, value Debut de n° de Produit
-- 				 ai_Id_ProdFin, value, fin de l'intervalle de numéro de produit
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S31_PARAM_CONDITION' AND type = 'P' )
            DROP procedure sysadm.DW_S31_PARAM_CONDITION
GO

CREATE PROC sysadm.DW_S31_PARAM_CONDITION
	@aiIdProdDeb decimal(7,0),
	@aiIdProdFin decimal(7,0)
AS
select	c.id_prod as 'Code_Produit',
	sysadm.FN_LIB_PROD(c.id_prod)	as 'Libellé_produit',
	c.id_rev as 'Code_Revision',
        r.lib_rev as 'Libelle_revision',
	c.id_gti as 'Code_Garantie',
	cg.lib_gti	as 'Libelle_Garantie',
	c.id_code	as 'Code_Detail/nature/Evenement/Territorialité',
	c.id_typ_code   as 'Code_Type_de_condition',
	sysadm.FN_CODE_NUM(c.id_code,c.id_typ_code) as 'Libelle_Type_de_condition',
	c.alt_reg,
	c.alt_plaf,
	c.alt_del,
	c.alt_fran,
	c.cree_le	as 'Crée_le',
	c.maj_le	as 'Mis_à_Jour_Le', 
	c.maj_par	as 'Mis_à_jour_Par'
from 	sysadm.condition c,
	sysadm.code_garantie cg,
	sysadm.revision r
where	c.id_prod = cg.id_prod
and	c.id_gti  = cg.id_gti
and	c.id_prod = r.id_prod
and	c.id_rev  = r.id_rev
and 	c.id_prod between @aiIdProdDeb and @aiIdProdFin


GO

-------------------------------------------------------------------
--
-- Procédure            :       DW_S32_PARAM_PLAFOND
-- Auteur               :       PHG
-- Date                 :       19/10/2006 
-- Libellé              :       Table Plafond
-- Commentaires       : 	
--	 	
--		
-- Références           : [DCMP060749] 
--
-- Arguments            :        
--
--
-- Retourne             : 
-- JFF  le 20/11/06 Je renseigne le lib_para par jointure externe (select dans el select)
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S32_PARAM_PLAFOND' AND type = 'P' )
            DROP procedure sysadm.DW_S32_PARAM_PLAFOND
GO

CREATE PROC sysadm.DW_S32_PARAM_PLAFOND
AS
select	pl.id_prod as 'Code_Produit',
	sysadm.FN_LIB_PROD(pl.id_prod)	as 'Libellé_produit',
	pl.id_rev as 'Code_Revision',
        r.lib_rev as 'Libelle_revision',
	pl.id_gti as 'Code_Garantie',
	cg.lib_gti as 'Libelle_Garantie',
	pl.id_niv_plaf 'Code_Niveau_Plafond',
	CASE pl.id_niv_plaf
	 WHEN '-GA' THEN 'Garantie'
	 WHEN '+EV' THEN 'Evenement'
	 WHEN '+NS' THEN 'Nature_de_Sinistre'
	 WHEN '+DT' THEN 'Détail_de_Sinistre'
	 ELSE pl.id_niv_plaf
	END as 'Niveau_du_Plafond',
	pl.id_ref_plaf as 'Code_Garantie/evenement/nature/détail', 
	CASE pl.id_niv_plaf
	 WHEN '-GA' THEN ''
	 ELSE sysadm.FN_CODE_NUM(pl.id_ref_plaf,pl.id_niv_plaf )
	END as 'Libelle_Garantie/evenement/nature/détail',
	pl.id_typ_plaf as 'Code_du_Type_de_Plafond',
	sysadm.FN_CODE_CAR( pl.id_typ_plaf,'-FR') as 'Type_de_Plafond', 
	pl.id_cpt_plaf as 'Compteur_de_Plafond',
	pl.mt_plaf as 'Montant_du_Plafond',
	pl.id_para as 'code_Paragraphe',
	( Select lib_para
	  From sysadm.paragraphe p
	  Where pl.id_para = p.id_para ) as 'Libelle_paragraphe', 
	pl.cree_le	as 'Crée_le',
	pl.maj_le	as 'Mis_à_Jour_Le', 
	pl.maj_par	as 'Mis_à_jour_Par'
from	sysadm.plafond pl,
	sysadm.revision r,
	sysadm.code_garantie cg
where	pl.id_prod = r.id_prod
and	pl.id_rev = r.id_rev
and	pl.id_prod = cg.id_prod
and	pl.id_gti = cg.id_gti

order by pl.id_prod, pl.id_rev, pl.id_gti, pl.id_niv_plaf, pl.id_ref_plaf
GO


-------------------------------------------------------------------
--
-- Procédure            :       DW_S33_PARAM_CORB_OPER
-- Auteur               :       PHG
-- Date                 :       19/10/2006 
-- Libellé              :       Table Corb_Oper
-- Commentaires       : 	
--	 	
--		
-- Références           : [DCMP060749] 
--
-- Arguments            :        
--
--
-- Retourne             : 
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S33_PARAM_CORB_OPER' AND type = 'P' )
            DROP procedure sysadm.DW_S33_PARAM_CORB_OPER
GO

CREATE PROC sysadm.DW_S33_PARAM_CORB_OPER
AS

If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
  Begin
	select	co.id_oper as 'Code_Operateur',
		op.nom as 'Nom',
		op.prenom as 'Prenom', 
		co.id_corb as 'Code_Corbeille', 
		co.alt_valide,
		co.cree_le	as 'Crée_le',
		co.maj_le	as 'Mis_à_Jour_Le', 
		co.maj_par	as 'Mis_à_jour_Par'
	from	sysadm.corb_oper co,
		SESAME_PRO.sysadm.operateur op
	where	co.id_oper = op.id_oper
  End
Else
  Begin
	select	co.id_oper as 'Code_Operateur',
		null,
		null,
		co.id_corb as 'Code_Corbeille', 
		co.alt_valide,
		co.cree_le	as 'Crée_le',
		co.maj_le	as 'Mis_à_Jour_Le', 
		co.maj_par	as 'Mis_à_jour_Par'
	from	sysadm.corb_oper co
  End
 GO


-------------------------------------------------------------------
--
-- Procédure            :       DW_S34_FAMILLE
-- Auteur               :       PHG
-- Date                 :       06/12/2006 
-- Libellé              :       Table Famille
-- Commentaires       : 	
--	 	
--		
-- Références           : [DCMP060405] 
--
-- Arguments            :        
--
--
-- Retourne             : 
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S34_FAMILLE' AND type = 'P' )
            DROP procedure sysadm.DW_S34_FAMILLE
GO

CREATE PROC sysadm.DW_S34_FAMILLE
AS
	select	f.id_fam as 'Code_Famille',
		f.id_typ_code as 'Type_de_Code',
	   f.id_code as 'Identifiant_Code',
	   f.lib_fam as 'Libelle_Famille', 
	   f.cree_le as 'Crée_le',
	   f.maj_le as 'Mis_à_Jour_Le',
	   f.maj_par	as 'Mis_à_jour_Par'
	from	sysadm.famille f
GO


-------------------------------------------------------------------
--
-- Procédure            :       DW_S35_FAMILLE_CAR
-- Auteur               :       PHG
-- Date                 :       06/12/2006 
-- Libellé              :       Table Famille Car
-- Commentaires         : 	
--	 	
--		
-- Références           : [DCMP060405] 
--
-- Arguments            :        
--
--
-- Retourne             : 
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S35_FAMILLE_CAR' AND type = 'P' )
            DROP procedure sysadm.DW_S35_FAMILLE_CAR
GO

CREATE PROC sysadm.DW_S35_FAMILLE_CAR
AS
	select	fc.id_fam as 'Code_Famille',
		fc.id_typ_code as 'Type_de_Code',
	   fc.id_code as 'Identifiant_Code',
	   fc.lib_fam as 'Libelle_Famille', 
	   fc.cree_le as 'Crée_le',
	   fc.maj_le as 'Mis_à_Jour_Le',
	   fc.maj_par	as 'Mis_à_jour_Par'
	from	sysadm.famille_car fc
GO

-------------------------------------------------------------------
-- Procédure            :       DW_S36_COUR_PROD_V01
-- Auteur               :       JCA
-- Date                 :       21/09/2007
-- Libellé              :       Table COUR_PROD
-- Commentaires         :	DCMP 70410
-- FPI - [ITSM201601] - ajout de la colonne nature de courrier
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S36_COUR_PROD_V01' AND type = 'P' )
            DROP procedure sysadm.DW_S36_COUR_PROD_V01
GO

CREATE PROC sysadm.DW_S36_COUR_PROD_V01
	@vcProd	varchar(5)
AS

SELECT	cp.id_prod		AS Produit,
	cp.id_nat_cour  AS Nature_courrier, 
	cp.id_cour		AS Courrier,
	cp.id_para 		AS Paragraphe ,
	cp.cree_le 		AS Cree_Le,
	cp.maj_le		AS Maj_Le,
	cp.maj_par		AS Maj_Par
        
FROM    sysadm.cour_prod	cp
        
WHERE	cp.id_prod	= @vcProd

ORDER BY cp.id_nat_cour, cp.id_cour, cp.id_ordre 

GO

grant execute on sysadm.DW_S36_COUR_PROD_V01 to rolebddsinistres
Go

-------------------------------------------------------------------
-- Procédure            :       DW_S37_COUR_PROD
-- Auteur               :       JCA
-- Date                 :       01/10/2007
-- Libellé              :       Table COUR_PROD
-- Commentaires         :	DCMP 70705
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S37_COUR_PROD' AND type = 'P' )
	DROP procedure sysadm.DW_S37_COUR_PROD
GO

CREATE PROC sysadm.DW_S37_COUR_PROD
AS

SELECT	distinct id_prod	as Produit, 
	id_cour 		as Courrier
FROM	sysadm.cour_prod
WHERE	id_cour not like 'ZAT%'
AND	id_cour not like 'ZP%'
AND	id_cour not like 'XXX%'
ORDER BY	id_prod, 
		id_cour

GO


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PARAM_AIG_OK' AND type = 'P' )
	DROP procedure sysadm.DW_S01_PARAM_AIG_OK
GO

create procedure sysadm.DW_S01_PARAM_AIG_OK(
	@sIdProd	varchar(7),
	@sIdRev		varchar(3),
	@sIdGti		varchar(7)
)
AS 
BEGIN

	Declare @iCount integer
	Declare @sAltOk char(1)
	
	Select 	@iCount = count(*)
	from	sysadm.garantie g 
		inner join sysadm.police p
			inner join sysadm.compagnie cie
				inner join sysadm.code c
				on (cie.id_cie = c.id_code and c.id_typ_code = '-AI')
			on (p.id_cie = cie.id_cie)
		on (g.id_police = p.id_police)

	Where	g.id_prod = cast(@sIdProd as Decimal(7,0))
	and	g.id_rev  = cast(@sIdRev  as Decimal(7,0))
	and	g.id_gti  = cast(@sIdGti  as Decimal(7,0))
	and	(g.id_prefixe IS NULL or g.id_prefixe ='' )

	IF @iCount > 0 
		Set @sAltOk = 'N'
	ELSE
		Set @sAltOk = 'O'

	Select @sAltOk as alt_ok

END

GO

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S24_PARAM_BOUTIQUE' AND type = 'P' )
	DROP procedure sysadm.DW_S24_PARAM_BOUTIQUE
GO

CREATE PROC sysadm.DW_S24_PARAM_BOUTIQUE
AS

Select  
	b.id_prod 			as	'Code Produit', 
	sysadm.FN_LIB_PROD(b.id_prod) 	as	'Libelle_produit',
	b.id_boutique 			as	'Code Boutique',
	b.region			as	'Région', 
	b.adr_ville			as	'Ville', 
	b.adr_cp			as	'Code Postal',
	b.adr_tel			as	'Téléphone',
	b.adr_fax			as	'Fax', 
	b.adr_mail			as	'Adresse Mail', 
	b.adr_nom			as	'Nom',
	b.cree_le			as	'Crée le',
	b.maj_le			as	'Mis à Jour Le', 
	b.maj_par			as	'Mis à jour Par'
From    sysadm.boutique b

GO


