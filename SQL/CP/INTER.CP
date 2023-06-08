-------------------------------------------------------------------
--
-- Fichier              :       INTER.CP
-- Auteur               :       PLJ
-- Date                 :       16/07/1998
--
-- Commentaires         :       Gestion des interlocuteurs dans SIMPA2
--
-- Proc‚dures           :       DW_S01_INTER
--                              PS_I01_INTER_VAL
--                              PS_I02_INTER_VAL
--                              PS_U01_INTER_VAL
--				PS_I03_INTER_VAL
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_INTER
-- Auteur               :       PLJ
-- Date                 :       16/07/1998
-- Libell‚              :        
-- Commentaires         :       Select sur la table INTER
-- R‚f‚rences           :       W_CM_SP_SINISTRE 
--
-- Arguments            :       @dcIdSin        decimal ( 7, 0 )                 (Val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_INTER' AND type = 'P' )
        DROP procedure sysadm.DW_S01_INTER
GO


CREATE procedure sysadm.DW_S01_INTER
        @dcIdSin        decimal ( 10, 0 ) -- [PI062]       
AS
 SELECT inter.id_sin,
        inter.id_i,
        inter.cod_inter,
        inter.cod_civ,
        inter.nom,
        inter.adr_1,
        inter.adr_2,
        inter.adr_cp,
        inter.adr_ville,
        inter.adr_att,
        inter.num_teld,
        inter.num_telb,
        inter.num_fax,
        inter.cod_mode_reg,
        inter.rib_bq,
        inter.rib_gui,
        inter.rib_cpt,
        inter.rib_cle,
        inter.mt_reg,
        inter.v_ref1,
        inter.v_ref2,
        inter.cod_ag,
        inter.cod_bq,
        inter.cpt_cour,
        inter.cree_le,
        inter.maj_le,
        inter.maj_par,
        inter.valide_le,
        inter.valide_par,
        inter.ordre_cheque,
        inter.id_four,
		inter.alt_suivi_mail,
		inter.adr_mail,
		cast(null as char(29)),
		cast(null as char(20)),
		inter.alt_suivi_sms, -- #1 [FNAC_PROD_ECH_TECH]
		inter.num_port_sms, -- #1 [FNAC_PROD_ECH_TECH]
		dte_naiss, -- [PMO89_RS4822]
		ville_naiss, -- [PMO89_RS4822]
		pays_naiss, -- [PMO89_RS4822]
		cod_etat_ctrle_inter -- [PMO89_RS4822]
 FROM   sysadm.inter
 WHERE  inter.id_sin = @dcIdSin

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_INTER_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table INTER (D‚claration)
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
-- JFF      12/02/2016   [PI062]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_INTER_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_INTER_VAL
GO

CREATE procedure sysadm.PS_I01_INTER_VAL
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

 INSERT INTO    sysadm.inter
        (       inter.id_sin,
                inter.id_i,
                inter.cod_inter,
                inter.cod_civ,
                inter.nom,
                inter.adr_1,
                inter.adr_2,
                inter.adr_cp,
                inter.adr_ville,
                inter.adr_att,
                inter.num_teld,
                inter.num_telb,
                inter.num_fax,
                inter.cod_mode_reg,
                inter.rib_bq,
                inter.rib_gui,
                inter.rib_cpt,
                inter.rib_cle,
                inter.mt_reg,
                inter.v_ref1,
                inter.v_ref2,
                inter.cod_ag,
                inter.cod_bq,
                inter.cpt_cour,
                inter.cree_le,
                inter.maj_le,
                inter.maj_par,
                inter.valide_le,
                inter.valide_par,
                inter.ordre_cheque,
                inter.id_four,
				inter.alt_suivi_mail,
				inter.adr_mail,
				inter.alt_suivi_sms, -- #1 [FNAC_PROD_ECH_TECH]
				inter.num_port_sms, -- #1 [FNAC_PROD_ECH_TECH]
				inter.dte_naiss, -- [PMO89_RS4822]
				inter.ville_naiss, -- [PMO89_RS4822]
				inter.pays_naiss, -- [PMO89_RS4822]
				inter.cod_etat_ctrle_inter -- [PMO89_RS4822]
		
		)
 SELECT         w_inter.id_sin,
                w_inter.id_i,
                w_inter.cod_inter,
                w_inter.cod_civ,
                w_inter.nom,
                w_inter.adr_1,
                w_inter.adr_2,
                w_inter.adr_cp,
                w_inter.adr_ville,
                w_inter.adr_att,
                w_inter.num_teld,
                w_inter.num_telb,
                w_inter.num_fax,
                w_inter.cod_mode_reg,
                w_inter.rib_bq,
                w_inter.rib_gui,
                w_inter.rib_cpt,
                w_inter.rib_cle,
                w_inter.mt_reg + w_inter.mt_a_reg,
                w_inter.v_ref1,
                w_inter.v_ref2,
                w_inter.cod_ag,
                w_inter.cod_bq,
                w_inter.cpt_cour,
                w_inter.cree_le,
                w_inter.maj_le,
                w_inter.maj_par,
                @dtValideLe,
                @sCodOper,
                w_inter.ordre_cheque,
                w_inter.id_four,
				w_inter.alt_suivi_mail,
				w_inter.adr_mail,
				w_inter.alt_suivi_sms, -- #1 [FNAC_PROD_ECH_TECH]
				w_inter.num_port_sms, -- #1 [FNAC_PROD_ECH_TECH]
				w_inter.dte_naiss, -- [PMO89_RS4822]
				w_inter.ville_naiss, -- [PMO89_RS4822]
				w_inter.pays_naiss, -- [PMO89_RS4822]
				w_inter.cod_etat_ctrle_inter -- [PMO89_RS4822]		

 FROM           sysadm.w_inter
 WHERE          w_inter.id_sin = @dcIdSin

 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I02_INTER_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table INTER (Compl‚ment)
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
-- JFF      12/02/2016   [PI062]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I02_INTER_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I02_INTER_VAL
GO

CREATE procedure sysadm.PS_I02_INTER_VAL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

 INSERT INTO    sysadm.inter
        (       inter.id_sin,
                inter.id_i,
                inter.cod_inter,
                inter.cod_civ,
                inter.nom,
                inter.adr_1,
                inter.adr_2,
                inter.adr_cp,
                inter.adr_ville,
                inter.adr_att,
                inter.num_teld,
                inter.num_telb,
                inter.num_fax,
                inter.cod_mode_reg,
                inter.rib_bq,
                inter.rib_gui,
                inter.rib_cpt,
                inter.rib_cle,
                inter.mt_reg,
                inter.v_ref1,
                inter.v_ref2,
                inter.cod_ag,
                inter.cod_bq,
                inter.cpt_cour,
                inter.cree_le,
                inter.maj_le,
                inter.maj_par,
                inter.valide_le,
                inter.valide_par,
                inter.ordre_cheque,
                inter.id_four,
				inter.alt_suivi_mail,
				inter.adr_mail,
				inter.alt_suivi_sms, -- #1 [FNAC_PROD_ECH_TECH]
				inter.num_port_sms, -- #1 [FNAC_PROD_ECH_TECH]
				inter.dte_naiss, -- [PMO89_RS4822]
				inter.ville_naiss, -- [PMO89_RS4822]
				inter.pays_naiss, -- [PMO89_RS4822]
				inter.cod_etat_ctrle_inter -- [PMO89_RS4822]
		)
 SELECT         w_inter.id_sin,
                w_inter.id_i,
                w_inter.cod_inter,
                w_inter.cod_civ,
                w_inter.nom,
                w_inter.adr_1,
                w_inter.adr_2,
                w_inter.adr_cp,
                w_inter.adr_ville,
                w_inter.adr_att,
                w_inter.num_teld,
                w_inter.num_telb,
                w_inter.num_fax,
                w_inter.cod_mode_reg,
                w_inter.rib_bq,
                w_inter.rib_gui,
                w_inter.rib_cpt,
                w_inter.rib_cle,
                w_inter.mt_reg + w_inter.mt_a_reg,
                w_inter.v_ref1,
                w_inter.v_ref2,
                w_inter.cod_ag,
                w_inter.cod_bq,
                w_inter.cpt_cour,
                w_inter.cree_le,
                w_inter.maj_le,
                w_inter.maj_par,
                @dtValideLe,
                @sCodOper,
                w_inter.ordre_cheque,
                w_inter.id_four,
				w_inter.alt_suivi_mail,
				w_inter.adr_mail,
				w_inter.alt_suivi_sms, -- #1 [FNAC_PROD_ECH_TECH]
				w_inter.num_port_sms, -- #1 [FNAC_PROD_ECH_TECH]
				w_inter.dte_naiss, -- [PMO89_RS4822]
				w_inter.ville_naiss, -- [PMO89_RS4822]
				w_inter.pays_naiss, -- [PMO89_RS4822]
				w_inter.cod_etat_ctrle_inter -- [PMO89_RS4822]
		
 FROM           sysadm.w_inter
 WHERE          w_inter.id_sin          = @dcIdSin      AND
                w_inter.cpt_valide      = 0             AND
                w_inter.alt_valide      = 'O'

 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_U01_INTER_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Modification dans la table INTER (Compl‚ment)
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
-- JFF      12/02/2016   [PI062]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_INTER_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U01_INTER_VAL
GO

 CREATE procedure sysadm.PS_U01_INTER_VAL  
        @dcIdSin        Decimal (  10,0 ),  
        @sCodOper       Varchar (  4   ),  
        @dtValideLe     DateTime  
AS  
 UPDATE sysadm.inter_encrypt  
 SET    sysadm.inter_encrypt.cod_inter    = w_inter_encrypt.cod_inter     ,  
        sysadm.inter_encrypt.cod_civ           = w_inter_encrypt.cod_civ       ,  
        sysadm.inter_encrypt.nom               = w_inter_encrypt.nom           ,  
        sysadm.inter_encrypt.adr_1             = w_inter_encrypt.adr_1         ,  
        sysadm.inter_encrypt.adr_2             = w_inter_encrypt.adr_2         ,  
        sysadm.inter_encrypt.adr_cp            = w_inter_encrypt.adr_cp        ,  
        sysadm.inter_encrypt.adr_ville         = w_inter_encrypt.adr_ville     ,  
        sysadm.inter_encrypt.adr_att           = w_inter_encrypt.adr_att       ,  
        sysadm.inter_encrypt.num_teld          = w_inter_encrypt.num_teld      ,  
        sysadm.inter_encrypt.num_telb          = w_inter_encrypt.num_telb      ,  
        sysadm.inter_encrypt.num_fax           = w_inter_encrypt.num_fax       ,  
        sysadm.inter_encrypt.cod_mode_reg      = w_inter_encrypt.cod_mode_reg  ,  
        sysadm.inter_encrypt.rib_bq            = w_inter_encrypt.rib_bq        ,  
        sysadm.inter_encrypt.rib_gui           = w_inter_encrypt.rib_gui       ,  
        sysadm.inter_encrypt.rib_cpt_encrypt   = w_inter_encrypt.rib_cpt_encrypt       ,  
        sysadm.inter_encrypt.rib_cle           = w_inter_encrypt.rib_cle       ,  
        sysadm.inter_encrypt.mt_reg            = w_inter_encrypt.mt_reg + w_inter_encrypt.mt_a_reg,  
        sysadm.inter_encrypt.v_ref1            = w_inter_encrypt.v_ref1        ,  
        sysadm.inter_encrypt.v_ref2            = w_inter_encrypt.v_ref2        ,  
        sysadm.inter_encrypt.cod_ag            = w_inter_encrypt.cod_ag        ,  
        sysadm.inter_encrypt.cod_bq            = w_inter_encrypt.cod_bq        ,  
        sysadm.inter_encrypt.cpt_cour          = w_inter_encrypt.cpt_cour      ,  
        sysadm.inter_encrypt.maj_le            = w_inter_encrypt.maj_le        ,  
        sysadm.inter_encrypt.maj_par           = w_inter_encrypt.maj_par       ,  
        sysadm.inter_encrypt.valide_le         = @dtValideLe           ,  
        sysadm.inter_encrypt.valide_par        = @sCodOper            ,  
        sysadm.inter_encrypt.ordre_cheque      = w_inter_encrypt.ordre_cheque  ,  
        sysadm.inter_encrypt.id_four           = w_inter_encrypt.id_four       ,  
		sysadm.inter_encrypt.alt_suivi_mail    = w_inter_encrypt.alt_suivi_mail,  
		sysadm.inter_encrypt.adr_mail          = w_inter_encrypt.adr_mail,  
		sysadm.inter_encrypt.alt_suivi_sms     = w_inter_encrypt.alt_suivi_sms, -- #1 [FNAC_PROD_ECH_TECH]  
		sysadm.inter_encrypt.num_port_sms      = w_inter_encrypt.num_port_sms, -- #1 [FNAC_PROD_ECH_TECH]  
		sysadm.inter_encrypt.dte_naiss         = w_inter_encrypt.dte_naiss, -- [PMO89_RS4822]
		sysadm.inter_encrypt.ville_naiss       = w_inter_encrypt.ville_naiss, -- [PMO89_RS4822]
		sysadm.inter_encrypt.pays_naiss        = w_inter_encrypt.pays_naiss, -- [PMO89_RS4822]
		sysadm.inter_encrypt.cod_etat_ctrle_inter = w_inter_encrypt.cod_etat_ctrle_inter -- [PMO89_RS4822]
  
 FROM   sysadm.inter_encrypt,  
        sysadm.w_inter_encrypt  
 WHERE  w_inter_encrypt.id_sin          = @dcIdSin              AND  
        inter_encrypt.id_sin            = w_inter_encrypt.id_sin        AND  
        inter_encrypt.id_i              = w_inter_encrypt.id_i          AND  
        w_inter_encrypt.cpt_valide      > 0                     AND  
        w_inter_encrypt.alt_valide      = 'O'  
  
 Return @@Error  
  
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_I03_INTER_VAL
-- Auteur               :       FABRY JF
-- Date                 :       13/05/05 
-- Libellé              :        
-- Commentaires         :       Insertion dans la table INTER (Decl/Compl) de l'inter fournisseur si besoin
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
--      JFF	07/04/2010	[PC384].[CDISCOUNT]
-- JFF      12/02/2016   [PI062]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I03_INTER_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I03_INTER_VAL
GO

CREATE procedure sysadm.PS_I03_INTER_VAL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

Insert into sysadm.w_inter 
Select	distinct
	tb_four.id_sin,
	( ( Select IsNull ( max ( wi2.id_i ), -1 )
	    From   sysadm.w_inter wi2
	    Where  wi2.id_sin = tb_four.id_sin ) + 
	    (select count(*) 
	     from   ( Select    distinct
				wc.id_sin,
				wc.id_four
		      From   	sysadm.w_commande wc,
		      		sysadm.agence a2
			Where 	wc.id_sin = @dcIdSin
			And 	Not Exists ( 
				Select *
				From   sysadm.w_inter wi
				Where  wi.id_sin  = wc.id_sin
				And    wi.id_four = wc.id_four ) 
			And	a2.id_bq = wc.id_four
		    ) tb_four2
	     where  tb_four2.id_sin = tb_four.id_sin
	     and    tb_four2.id_four <= tb_four.id_four)
	),
	'F',
	5,
	a.lib_ag,
	a.adr_1,
	a.adr_2,
	a.adr_cp,
	a.adr_ville,
	null,
	null,
	null,
	null,
	'FM',
	null,
	null,
	null,
	null,
	0,
	0,
	null,
	null,
	null,
	null,
	0,
	1,
	'N',
	'N',
	'N',
	'N',
	'N',
	null,
	null,
	'N',
	null,
	null,
	getdate(),
	getdate(),
	@sCodOper,
	null,
	null,
	tb_four.id_four,
	'N',
	null,
	null, -- #1 [FNAC_PROD_ECH_TECH]
	null,  -- #1 [FNAC_PROD_ECH_TECH]
	null as dte_naiss,  -- [PMO89_RS4822]
	null as ville_naiss,  -- [PMO89_RS4822]
	null as pays_naiss,  -- [PMO89_RS4822]
	0 as cod_etat_ctrle_inter -- [PMO89_RS4822]
From   	( Select  distinct
		wc.id_sin,
		wc.id_four
	From   	sysadm.w_commande wc
	Where 	wc.id_sin = @dcIdSin
	And	Not Exists ( 
		Select *
		From   sysadm.w_inter wi
		Where  wi.id_sin  = wc.id_sin
		And    wi.id_four = wc.id_four 
			    ) 
	) tb_four,
	sysadm.agence a

Where 	Exists (
	Select *
	From   	sysadm.w_commande wc,
	       	sysadm.w_detail wd
	Where  	wc.id_sin = tb_four.id_sin
	And	wc.id_four = tb_four.id_four
	And	wd.id_sin = wc.id_sin 
	And	wd.id_gti = wc.id_gti
	And	wd.id_detail = wc.id_detail
	And	wd.mt_plaf = 0 )
	And 	a.id_bq = tb_four.id_four

Insert into sysadm.inter 
Select	distinct
	tb_four.id_sin,
	( ( Select IsNull ( max ( i2.id_i ), -1 )
	    From   sysadm.inter i2
	    Where  i2.id_sin = tb_four.id_sin ) + 
	    (select count(*) 
	     from   ( Select    distinct
				wc.id_sin,
				wc.id_four
		      From   	sysadm.w_commande wc,
		      		sysadm.agence a2		      
			Where 	wc.id_sin = @dcIdSin
			And	Not Exists ( 
				Select *
				From   sysadm.inter i
				Where  i.id_sin  = wc.id_sin
				And    i.id_four = wc.id_four ) 
			And	a2.id_bq = wc.id_four
		     ) tb_four2
	     where  tb_four2.id_sin = tb_four.id_sin
	     and    tb_four2.id_four <= tb_four.id_four)
	),
	'F',
	5,
	a.lib_ag,
	a.adr_1,
	a.adr_2,
	a.adr_cp,
	a.adr_ville,
	null,
	null,
	null,
	null,
	'FM',
	null,
	null,
	null,
	null,
	0,
	null,
	null,
	null,
	null,
	0,
	@dtValideLe,
	@sCodOper,
	@dtValideLe,
	@dtValideLe,
	@sCodOper,
	null,
	tb_four.id_four,
	'N',
	null,
	null, -- #1 [FNAC_PROD_ECH_TECH]
	null,  -- #1 [FNAC_PROD_ECH_TECH]
	null as dte_naiss,  -- [PMO89_RS4822]
	null as ville_naiss,  -- [PMO89_RS4822]
	null as pays_naiss,  -- [PMO89_RS4822]
	0 as cod_etat_ctrle_inter -- [PMO89_RS4822]
	
From   	( Select  distinct
		wc.id_sin,
		wc.id_four
	From   	sysadm.w_commande wc
	Where 	wc.id_sin = @dcIdSin
	And	Not Exists ( 
		Select *
		From   sysadm.inter i
		Where  i.id_sin  = wc.id_sin
		And    i.id_four = wc.id_four 
			   ) 
	) tb_four,
	sysadm.agence a		

Where 	Exists (
	Select *
	From   	sysadm.w_commande wc,
	       	sysadm.detail d
	Where  	wc.id_sin = tb_four.id_sin
	And	wc.id_four = tb_four.id_four
	And	d.id_sin = wc.id_sin 
	And	d.id_gti = wc.id_gti
	And	d.id_detail = wc.id_detail
	And	d.mt_plaf = 0 )
	And 	a.id_bq = tb_four.id_four

-- A_RECUP_A_RECYCLER
-- [PC384].[CDISCOUNT]
If Exists ( 	Select 	* 
		From 	sysadm.det_pro dp, 
			sysadm.w_sin ws 
		Where   ws.id_sin = @dcIdSin
		And 	dp.id_prod = ws.id_prod
		And 	dp.id_code_dp = 37 ) 
   Begin		

	Insert into sysadm.w_inter 
	Select	distinct
		tb_four.id_sin,
		( ( Select IsNull ( max ( wi2.id_i ), -1 )
		    From   sysadm.w_inter wi2
		    Where  wi2.id_sin = tb_four.id_sin ) + 
		    (select count(*) 
		     from   ( Select    distinct
					wc.id_sin,
					'NES' id_four
				From   	sysadm.w_commande wc,
					sysadm.det_pro dp,
					sysadm.w_sin ws,
					sysadm.agence a2
				Where 	wc.id_sin = @dcIdSin
				And	wc.id_four = 'O2M'
				And     wc.id_ref_four = 'A_RECUP_A_RECYCLER'
				And	ws.id_sin = wc.id_sin
				And     dp.id_prod = ws.id_prod
				And 	dp.id_code_dp = 37 -- C-discount
				And 	Not Exists ( 
					Select *
					From   sysadm.w_inter wi
					Where  wi.id_sin  = wc.id_sin
					And    wi.id_four = 'NES' ) 
				And	a2.id_bq = 'NES'
			    ) tb_four2
		     where  tb_four2.id_sin = tb_four.id_sin
		     and    tb_four2.id_four <= tb_four.id_four)
		),
		'F',
		5,
		a.lib_ag,
		a.adr_1,
		a.adr_2,
		a.adr_cp,
		a.adr_ville,
		null,
		null,
		null,
		null,
		'FM',
		null,
		null,
		null,
		null,
		0,
		0,
		null,
		null,
		null,
		null,
		0,
		1,
		'N',
		'N',
		'N',
		'N',
		'N',
		null,
		null,
		'N',
		null,
		null,
		getdate(),
		getdate(),
		@sCodOper,
		null,
		null,
		tb_four.id_four,
		'N',
		null,
		null, -- #1 [FNAC_PROD_ECH_TECH]
		null,  -- #1 [FNAC_PROD_ECH_TECH]
		null as dte_naiss,  -- [PMO89_RS4822]
		null as ville_naiss,  -- [PMO89_RS4822]
		null as pays_naiss,  -- [PMO89_RS4822]
		0 as cod_etat_ctrle_inter -- [PMO89_RS4822]
	From   	( Select  distinct
			wc.id_sin,
			'NES' id_four
		From   	sysadm.w_commande wc,
			sysadm.det_pro dp,
			sysadm.w_sin ws
		Where 	wc.id_sin = @dcIdSin
		And	wc.id_four = 'O2M'
		And     wc.id_ref_four = 'A_RECUP_A_RECYCLER'
		And	ws.id_sin = wc.id_sin
		And     dp.id_prod = ws.id_prod
		And 	dp.id_code_dp = 37 -- C-discount
		And	Not Exists ( 
			Select *
			From   sysadm.w_inter wi
			Where  wi.id_sin  = wc.id_sin
			And    wi.id_four = 'NES'
				    ) 
		) tb_four,
		sysadm.agence a

	Where 	a.id_bq = tb_four.id_four

	Insert into sysadm.inter 
	Select	distinct
		tb_four.id_sin,
		( ( Select IsNull ( max ( i2.id_i ), -1 )
		    From   sysadm.inter i2
		    Where  i2.id_sin = tb_four.id_sin ) + 
		    (select count(*) 
		     from   ( Select    distinct
					wc.id_sin,
					'NES' id_four
				From   	sysadm.w_commande wc,
					sysadm.det_pro dp,
					sysadm.w_sin ws,
					sysadm.agence a2
				Where 	wc.id_sin = @dcIdSin
				And	wc.id_four = 'O2M'
				And     wc.id_ref_four = 'A_RECUP_A_RECYCLER'
				And	ws.id_sin = wc.id_sin
				And     dp.id_prod = ws.id_prod
				And 	dp.id_code_dp = 37 -- C-discount
				And	Not Exists ( 
					Select *
					From   sysadm.inter i
					Where  i.id_sin  = wc.id_sin
					And    i.id_four = 'NES' ) 
				And	a2.id_bq = 'NES'
			     ) tb_four2
		     where  tb_four2.id_sin = tb_four.id_sin
		     and    tb_four2.id_four <= tb_four.id_four)
		),
		'F',
		5,
		a.lib_ag,
		a.adr_1,
		a.adr_2,
		a.adr_cp,
		a.adr_ville,
		null,
		null,
		null,
		null,
		'FM',
		null,
		null,
		null,
		null,
		0,
		null,
		null,
		null,
		null,
		0,
		@dtValideLe,
		@sCodOper,
		@dtValideLe,
		@dtValideLe,
		@sCodOper,
		null,
		tb_four.id_four,
		'N',
		null,
		null, -- #1 [FNAC_PROD_ECH_TECH]
		null,  -- #1 [FNAC_PROD_ECH_TECH]
		null as dte_naiss,  -- [PMO89_RS4822]
		null as ville_naiss,  -- [PMO89_RS4822]
		null as pays_naiss,  -- [PMO89_RS4822]
		0 as cod_etat_ctrle_inter -- [PMO89_RS4822]

	From   	( Select  distinct
			wc.id_sin,
			'NES' id_four
		From   	sysadm.w_commande wc,
			sysadm.det_pro dp,
			sysadm.w_sin ws
		Where 	wc.id_sin = @dcIdSin
		And	wc.id_four = 'O2M'
		And     wc.id_ref_four = 'A_RECUP_A_RECYCLER'
		And	ws.id_sin = wc.id_sin
		And     dp.id_prod = ws.id_prod
		And 	dp.id_code_dp = 37 -- C-discount
		And	Not Exists ( 
			Select *
			From   sysadm.inter i
			Where  i.id_sin  = wc.id_sin
			And    i.id_four = 'NES'
				   ) 
		) tb_four,
		sysadm.agence a		

	Where 	a.id_bq = tb_four.id_four

   End
-- :[PC384].[CDISCOUNT]

Return @@Error

GO


--------------------------------------------------------------------
--
-- Procédure            :       TR_MODIF_RIB_PM466
-- Auteur               :       FABRY JF
-- Date                 :       13/05/05 
-- Libellé              :        
-- Commentaires         :       [PM466]
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
/*
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_MODIF_RIB_PM466' AND type = 'TR' )
        DROP trigger sysadm.TR_MODIF_RIB_PM466
GO

CREATE TRIGGER sysadm.TR_MODIF_RIB_PM466
            ON sysadm.inter
    FOR UPDATE
AS 

If Update ( rib_cle ) Or Update ( cod_mode_reg )
  Begin
   
    Insert into sysadm.trace_modif_rib
	Select it.id_sin,
		   it.id_i,
		   d.nom,
		   i.nom,
		   d.cod_mode_reg,
		   i.cod_mode_reg,
		   d.rib_bq,
		   d.rib_gui,
		   d.rib_cpt,
		   d.rib_cle,
		   i.rib_bq,
		   i.rib_gui,
		   i.rib_cpt,
		   i.rib_cle,
		   Getdate(),
		   Getdate(),
		   i.maj_par

	From sysadm.inter it,
		 deleted d,
		 inserted i
	Where it.id_sin = d.id_sin
	And   it.id_i = d.id_i
	And   i.id_sin = d.id_sin
	And   i.id_i = d.id_i
	And   ( ( i.rib_cle <> d.rib_cle )
			Or 
			( i.rib_cle is null And d.rib_cle is not null ) 
			Or 
			( d.rib_cle is null And i.rib_cle is not null ) 
			Or 
			( i.cod_mode_reg <> d.cod_mode_reg )
			Or
			( i.cod_mode_reg is null And d.cod_mode_reg is not null ) 
			Or 
			( d.cod_mode_reg is null And i.cod_mode_reg is not null ) 
		   )
 End 
 
Go
*/
