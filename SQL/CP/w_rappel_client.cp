-------------------------------------------------------------------
--
-- Fichier              : w_rappel_client.cp
--
-- Commentaires         : Procédures de la table w_rappel_client
--
-- Procédures
-- 
-- TR_I01_W_RAPPEL_CLIENT	FS  22/10/2002 : Trigger INSERT maj id_cli+id_contact & création contact dans SHERPA_PRO
-- TR_U01_W_RAPPEL_CLIENT	FS  23/10/2002 : Trigger UPDATE maj du contact dans SHERPA_PRO
-- PS_I01_W_RAPPEL_CLIENT	JFF 22/10/2003 : Insertion dans w_rappel_client
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Trigger              :       TR_I01_W_RAPPEL_CLIENT
-- Auteur               :       FS
-- Date                 :       22/10/2003
-- Libellé              :       - Mise à jour des colonnes id_cli + id_contact
--                              - Création du contact dans Sherpa
-- Commentaires         :       ( utilisé dans le cadre de la procédure des rappels
--                                
--                              Attention base SHERPA_PRO
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 FS le 24/11/03 Correction bug sur attribution id_contact si le client à
--                   plusieurs sinistres sur la même extraction
-- #2 FS le 03/02/04 Demande B.Hanin libelle 14 & 21 jours ald Nestor & Nelson
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_I01_W_RAPPEL_CLIENT' AND type = 'TR' )
        DROP trigger TR_I01_W_RAPPEL_CLIENT
GO

CREATE TRIGGER TR_I01_W_RAPPEL_CLIENT
            ON sysadm.w_rappel_client
    FOR INSERT
AS 

Declare @iIdCli Integer
Declare @iIdSeq Integer
    
/*------------------------------------------------------------------*/
/* Mise à jour du n° de client + n° contact venant de Sherpa        */
/*------------------------------------------------------------------*/

Update sysadm.w_rappel_client
   Set id_cli     = s.id_cli,
       id_contact = m.max_id_contact + 1
 From SHERPA_PRO.sysadm.sinistre s Inner Join inserted i 
                                      On s.id_sin = i.id_sin And s.id_appli = 2
                                   Inner Join SHERPA_PRO.sysadm.v_max_contact m
                                      On s.id_cli = m.id_cli
 Where
      i.id_seq = w_rappel_client.id_seq 


/*------------------------------------------------------------------*/
/* #1 Numérotation des contacts si client a 2 sinistres             */
/*------------------------------------------------------------------*/

 Declare cur cursor for
 Select
    a.id_cli, max( a.id_seq )
  From
     sysadm.w_rappel_client a inner join inserted i on a.id_seq = i.id_seq
  Where
      exists ( select b.id_cli, b.id_contact, count(*) from sysadm.w_rappel_client b
                                     where
                                           a.id_cli = b.id_cli 
                                     group by
                                           b.id_cli, b.id_contact
                                     having
                                          count(*) > 1 )
 group by
   a.id_cli 

 open cur

 fetch cur into @iIdCli, @iIdSeq

 While @@fetch_status <> -1
   Begin
      update sysadm.w_rappel_client set id_contact = id_contact+1 Where id_seq = @iIdSeq

      fetch cur into @iIdCli, @iIdSeq
   End
 Close cur
 Deallocate cur


/*------------------------------------------------------------------*/
/* Création du contact dans Sherpa                                  */
/*------------------------------------------------------------------*/

Insert	SHERPA_PRO.sysadm.contact 
( 	id_cli		,
	id_contact	, 
	id_typ_fam	,
	id_typ_contact	,
	id_nat_tache	,
	id_canal	,
	id_appli	,
	id_sin		,
	id_prod		,
	id_ets		,
	id_adh		,
	id_sdos		,
	id_action	,
	id_script	,
	cod_inter	,
	id_archive	,
	id_relation	,
	txt_mess	,
	alt_valide	,
	cod_etat	,
	dte_cour_cli	,
	dte_recu	,
	dte_dec		,
	dte_surv	,
	dte_adh		,
	cree_le		,
	maj_le		,
	maj_par		,
	a_traiter_par	,
	id_typ_recu	,
	lib_ets		,
	id_ma		,
	alt_quest	,
	id_cour_gest	,
	txt_mess2	,
	cod_prov )
    Select
        wr.id_cli        as id_cli,
	wr.id_contact    as id_contact,
	2                as id_typ_fam,
	98               as id_typ_contact,
	98               as id_nat_tache,
	'Z'              as id_canal,
	2                as id_appli,
	wr.id_sin        as id_sin,
	s.id_prod_sin    as id_prod_sin,
	s.id_ets         as id_ets,
	s.id_adh         as id_adh,
	s.id_sdos        as id_sdos,
	0                as id_action,
	0                as id_script,
	'T'              as cod_inter,
	0                as id_archive,
	0                as id_relation,
	'Rappel client en cours 14 & 21 jours...',
	'O'              as alt_valide,
	300              as cod_etat,
	Null             as dte_cour_cli,
	Null             as dte_recu,
	Null             as dte_dec,
	Null             as dte_surv,
        Null             as dte_adh,
	wr.cree_le       as cree_le,
	wr.maj_le        as maj_le,
	wr.maj_par       as maj_par,
	'####'           as a_traiter_par,
        'X'              as id_typ_recu,
        Null             as lib_ets,
        Null             as id_ma,
        'N'              as alt_quest,
        Null             as id_cour_gest,
        Null             as txt_mess2,
        '##'              
From sysadm.w_rappel_client wr Inner join inserted i                        on wr.id_seq = i.id_seq
                               Inner join SHERPA_PRO.sysadm.sinistre s      on wr.id_sin = s.id_sin And s.id_appli = 2

Go


--------------------------------------------------------------------
--
-- Trigger              :       TR_U01_W_RAPPEL_CLIENT
-- Auteur               :       FS
-- Date                 :       22/10/2003
-- Libellé              :       - Mise à jour du contact sherpa après retour du fichier 
--                              
-- Commentaires         :       ( utilisé dans le cadre de la procédure des rappels Nestor & Nelson )
--                                
--
--                              Attention base SHERPA_PRO
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 FS le 03/02/04 Demande B.Hanin libelle 14 & 21 jours ald Nestor & Nelson
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_U01_W_RAPPEL_CLIENT' AND type = 'TR' )
        DROP trigger TR_U01_W_RAPPEL_CLIENT
GO

CREATE TRIGGER TR_U01_W_RAPPEL_CLIENT
            ON sysadm.w_rappel_client
    FOR UPDATE
AS 


If Update ( id_res_appel        ) Or
   Update ( dte_reception_port  ) Or
   Update ( dte_reception_devis ) Or
   Update ( txt_commentaire     )

          /*-----------------------------------------*/
   Begin  /* Début mise à jour du contact SHERPA_PRO */
          /*-----------------------------------------*/

Update SHERPA_PRO.sysadm.contact
   Set id_nat_tache =
         Case 
           When i.id_res_appel is Null     Then 0
           When i.id_res_appel is Not Null Then i.id_res_appel
         End,
       txt_mess     = "Rappel client 14 & 21 jours le "  + convert( varchar(10), getdate(), 103 ) 
        +
         Case 
            When lnt.lib_code is null     Then  Char(13)+ Char(10) + "Résultat : non codé"
            When lnt.lib_code is not null Then  Char(13)+ Char(10) + "Résultat : " + lnt.lib_code 
         End
         +
         Case 
            When i.dte_reception_port is null     Then ''
            When i.dte_reception_port is not null Then Char(13) + Char(10) + "Portable reçu le " + convert( varchar(10), i.dte_reception_port, 103 )
         End
        +
         Case 
            When i.dte_reception_devis is null     Then ''
            When i.dte_reception_devis is not null Then Char(13) + Char(10) + "Devis reçu le " + convert( varchar(10), i.dte_reception_devis, 103 )
         End,
       txt_mess2    =
        Case 
          When rtrim(i.txt_commentaire) is not null Then Char(13) + Char(10) + "Message client" + Char(13) + Char(10) + rtrim(i.txt_commentaire)
        End,
       maj_le       = i.maj_le,
       maj_par      = i.maj_par
 From  inserted i left outer join SHERPA_PRO.sysadm.code lnt 
   On
       i.id_res_appel  = lnt.id_code                      And
       lnt.id_typ_code = '-NT'                            
Where
       SHERPA_PRO.sysadm.contact.id_cli     = i.id_cli    And
       SHERPA_PRO.sysadm.contact.id_contact = i.id_contact

          /*-----------------------------------------*/
   End    /* Début mise à jour du contact SHERPA_PRO */
          /*-----------------------------------------*/

Go

--------------------------------------------------------------------
--
-- Trigger              :       PS_I01_W_RAPPEL_CLIENT
-- Auteur               :       JFF
-- Date                 :       22/10/2003
-- Libellé              :       Insertion dans w_rappel_client 
--                              
-- Commentaires         :       ( utilisé dans le cadre de la procédure des rappels Nestor & Nelson )
--                                
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_RAPPEL_CLIENT' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_RAPPEL_CLIENT
GO

CREATE procedure sysadm.PS_I01_W_RAPPEL_CLIENT
	@sCodOper        VarChar (4)   
AS

Declare @dtDate DateTime

Select  @dtDate = DateAdd(  day, 0, GetDate() )

/*------------------------------------------------------------------------------*/
/* En cas de pépin Revoir le nb de jours ci dessus                              */
/* ! Enlever le INSERT : Penser aux trigger qui insèrent les lignes dans SHERPA */
/*------------------------------------------------------------------------------*/

Insert into sysadm.w_rappel_client

Select 	CASE 
	WHEN 
	( 	c.dte_elv_mobile is not null
	And	Abs ( DateDiff ( day, @dtDate, c.dte_elv_mobile ) ) =  13 
	And	( (     c.id_gti = 18 
		    And c.status_gc = 0 
		    And c.dte_emis_devis is null
		   )
		OR
		   ( 	c.id_gti <> 18 )
		)
	) THEN 'SG_14J'
	WHEN 		
	( 	c.dte_elv_mobile is not null
	And	Abs ( DateDiff ( day, @dtDate, c.dte_elv_mobile ) ) = 20 
	And	( (     c.id_gti = 18 
		    And c.status_gc = 0 
		    And c.dte_emis_devis is null
		   )
		OR
		   ( 	c.id_gti <> 18 )
		)
	) THEN 'SG_21J'	
	WHEN
	(	c.dte_elv_mobile is not null
	And	c.dte_dev_acp is not null
	And	c.dte_emis_devis is not null
	And	Abs ( DateDiff ( day, @dtDate, c.dte_dev_acp ) ) 
		+
		Abs ( DateDiff ( day, c.dte_emis_devis, c.dte_elv_mobile ) ) = 20 

	And	c.id_gti = 18 
	And 	c.status_gc > 0 
	) THEN 'HG_21J'	
	END Type,
	c.id_sin Ref_Sin,
	c.id_seq Seq_Prs,
	c.id_gti Garantie,
	cGA.lib_code Garantie,
	c.id_marq_art Marque_Article,
	c.id_modl_art Modele_Article,
	LTrim ( RTrim ( c.adr_nom ))  + ' ' + LTrim ( RTrim ( c.adr_prenom ))  Nom_Interlocuteur,
	c.adr_tel1 Telephone_1,
	c.adr_tel2 Telephone_2,
	c.adr_tel3 Telephone_3,
	c.id_cmd_frn Num_Commande_Fournisseur,
	CASE 
	WHEN 
	( 	c.dte_elv_mobile is not null
	And	Abs ( DateDiff ( day, @dtDate, c.dte_elv_mobile ) ) =  13 
	And	( (     c.id_gti = 18 
		    And c.status_gc = 0 
		    And c.dte_emis_devis is null
		   )
		OR
		   ( 	c.id_gti <> 18 )
		)
	) THEN '14'
	WHEN 		
	( 	c.dte_elv_mobile is not null
	And	Abs ( DateDiff ( day, @dtDate, c.dte_elv_mobile ) ) = 20 
	And	( (     c.id_gti = 18 
		    And c.status_gc = 0 
		    And c.dte_emis_devis is null
		   )
		OR
		   ( 	c.id_gti <> 18 )
		)
	) THEN '21'	
	WHEN
	(	c.dte_elv_mobile is not null
	And	c.dte_dev_acp is not null
	And	c.dte_emis_devis is not null
	And	Abs ( DateDiff ( day, @dtDate, c.dte_dev_acp ) ) 
		+
		Abs ( DateDiff ( day, c.dte_emis_devis, c.dte_elv_mobile ) ) = 20 

	And	c.id_gti = 18 
	And 	c.status_gc > 0 
	) THEN '21'	
	END Delai,
	c.comment_frn Commentaire_Fournisseur,
	c.dte_rdv_cli Date_enlevemement,
	c.dte_elv_mobile Enlevement_mobile,
	c.dte_emis_devis Emission_Devis_Par_Fourn,
	c.mt_devis Mt_Devis_Par_Fourn,
	c.alt_dev_acp Devis_Accepte_Par_Client,
	c.dte_dev_acp Date_Prise_Decision_Devis,
	null Resultat_appel,
	null Date_Rcp_Portable_Repare,
	null Date_Rcp_Devis,
	null Commentaire,
	0 Num_client_SPB,
	0 Num_contact_SPB,
	0 Code_Position,
	Getdate () Date_de_Création,
	Getdate () Date_de_Modification,
	@sCodOper Resp_Modification,	
	s.id_prod Produit,
	'' Nom_Fic
	

From 	sysadm.commande c,
	sysadm.sinistre s,
	sysadm.code cGA

Where 	s.id_prod = 5712
and	s.id_sin  = c.id_sin
and	c.id_four = 'ASF'
and     c.id_seq  = ( Select max ( c2.id_seq )
		    From commande c2
		    Where c2.id_sin = c.id_sin
	 	    And   c2.id_four = 'ASF'
		    And   Not ( c2.dte_dev_acp is not null 
				And c2.alt_dev_acp = 'N'
				And c2.status_gc in ( 3,4,5 ) )
		    And   Not ( c2.status_gc in ( 6,10 ) )
		    And   dte_env_cli is null )

And (	
	( 	c.dte_elv_mobile is not null
	And	Abs ( DateDiff ( day, @dtDate, c.dte_elv_mobile ) ) in ( 13, 20 )
	And	( (     c.id_gti = 18 
		    And c.status_gc = 0 
		    And c.dte_emis_devis is null
		   )
		OR
		   ( 	c.id_gti <> 18 )
		)
	)		
	
     OR
	(	c.dte_elv_mobile is not null
	And	c.dte_dev_acp is not null
	And	c.dte_emis_devis is not null
	And	Abs ( DateDiff ( day, @dtDate, c.dte_dev_acp ) ) 
		+
		Abs ( DateDiff ( day, c.dte_emis_devis, c.dte_elv_mobile ) ) = 20 

	And	c.id_gti = 18 
	And 	c.status_gc > 0 
	)
     )

And dte_ret_pret_min is null
And dte_ret_pret_max is null
And cGA.id_typ_code = '-GA'
And cGA.id_code = c.id_gti
And Not Exists ( 
	Select 	*
	From 	w_rappel_client wr
	Where	wr.id_sin = c.id_sin
	And	wr.id_seq_prs = c.id_seq 
	And	(
			( 	wr.delai = 14
			And 	( 	c.dte_elv_mobile is not null
				And	Abs ( DateDiff ( day, @dtDate, c.dte_elv_mobile ) ) =  13 
				And	( (     c.id_gti = 18 
					    And c.status_gc = 0 
					    And c.dte_emis_devis is null
					   )
					OR
					   ( 	c.id_gti <> 18 )
					)
				) 
			 )
		 OR
			( 	wr.delai = 21
			And  (
				( 	c.dte_elv_mobile is not null
				And	Abs ( DateDiff ( day, @dtDate, c.dte_elv_mobile ) ) = 20 
				And	( (     c.id_gti = 18 
					    And c.status_gc = 0 
					    And c.dte_emis_devis is null
					   )
					OR
					   ( 	c.id_gti <> 18 )
					)
				) 
				Or 
				(	c.dte_elv_mobile is not null
				And	c.dte_dev_acp is not null
				And	c.dte_emis_devis is not null
				And	Abs ( DateDiff ( day, @dtDate, c.dte_dev_acp ) ) 
					+
					Abs ( DateDiff ( day, c.dte_emis_devis, c.dte_elv_mobile ) ) = 20 
			
				And	c.id_gti = 18 
				And 	c.status_gc > 0 
				)
			     )
			)
		)
	)

Go