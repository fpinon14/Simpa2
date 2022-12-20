-------------------------------------------------------------------
--
-- Fichier              :       PM369_2.CP
-- Auteur               :       Fabry JF
-- Date                 :       05/04/2017
--
-- Commentaires         :       PS afférants aux PM369_2, automatisation Orange V3
--
-------------------------------------------------------------------

--------------------------------------------------------------------
-- Procédure            :       PS_S_PM369_2_SUIVI_DOSSIER_OV3
-- Auteur               :       Fabry JF
-- Date                 :       05/04/2017
-- Libellé              :
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM369_2_SUIVI_DOSSIER_OV3' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM369_2_SUIVI_DOSSIER_OV3
GO

CREATE procedure sysadm.PS_S_PM369_2_SUIVI_DOSSIER_OV3
	@adcIdSin   Decimal (10),
	@asRetERR	VarChar ( 255 ) OUTPUT
AS

Declare @iRet Integer

-- Dossier éligible
	Exec @iRet = sysadm.PS_S_PM369_2_DOSSIER_ELIGIBLE @adcIdSin, @asRetERR OUTPUT
	If @iRet = -1 Return @iRet

-- Dossier éligible
	Exec @iRet = sysadm.PS_S_PM369_2_RETOUR_DONNEES @adcIdSin, @asRetERR OUTPUT
	If @iRet = -1 Return @iRet



GO

--------------------------------------------------------------------
-- Procédure            :       PS_S_PM369_2_DOSSIER_ELIGIBLE
-- Auteur               :       Fabry JF
-- Date                 :       05/04/2017
-- Libellé              :
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM369_2_DOSSIER_ELIGIBLE' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM369_2_DOSSIER_ELIGIBLE
GO

CREATE procedure sysadm.PS_S_PM369_2_DOSSIER_ELIGIBLE
	@adcIdSin   Decimal (10),
	@asRetERR	VarChar ( 255 ) OUTPUT
AS

	-- Aucun sinistre 
	If Not Exists ( 
			Select	Top 1 1 
			From	sysadm.sinistre s
			Where	s.id_sin = @adcIdSin
		)
	   And 
	   Not Exists ( 
			Select	Top 1 1 
			From	sysadm.w_sin s
			Where	s.id_sin = @adcIdSin
		)
		Begin
			Set @asRetERR = 'Ce dossier de sinistre n''existe pas.'
			Return -1
		End		

	-- Aucun sinistre 
	If Not Exists ( 
			Select	Top 1 1 
			From	sysadm.sinistre s
			Where	s.id_sin = @adcIdSin
		)
	   And 
	   Exists ( 
			Select	Top 1 1 
			From	sysadm.w_sin s
			Where	s.id_sin = @adcIdSin
		)
		Begin
			Set @asRetERR = 'Ce dossier n''est pas encore disponible à la consultation.'
			Return -1
		End		


	-- Option -dp/316 absente
	If Not Exists ( 
			Select	Top 1 1 
			From	sysadm.sinistre s,
					sysadm.det_pro dp
			Where	s.id_sin = @adcIdSin
			And		dp.id_prod = s.id_prod
			And		dp.id_code_dp = 316
		) 
		Begin
			Set @asRetERR = '[TECH]Produit non éligible, dp316 absente'
			Return -1
		End		

	-- Aucune Garantie éligible
	If Not Exists ( 
			Select	Top 1 1 
			From	sysadm.gar_sin wg
			Where	wg.id_sin = @adcIdSin
			And		wg.id_gti in ( 10, 11, 24 )
		) 
		Begin
			Set @asRetERR = 'Votre dossier ne peut pas être consulté par cet extranet, contactez SPB.'
			Return -1
		End		

	-- Garantie éligible en double
	If ( 
			Select	count (*) 
			From	sysadm.gar_sin wg
			Where	wg.id_sin = @adcIdSin
			And		wg.id_gti in ( 10, 11, 24 )
		) > 1
		Begin
			Set @asRetERR = 'Votre dossier ne peut pas être consulté par cet extranet, contactez SPB.'
			Return -1
		End		



Go

--------------------------------------------------------------------
-- Procédure            :       PS_S_PM369_2_RETOUR_DONNEES
-- Auteur               :       Fabry JF
-- Date                 :       05/04/2017
-- Libellé              :
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF      17/04/2018   [DT288-4] Modif URL Chronopost
--  JFF      21/11/2018   [VDOC27123]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM369_2_RETOUR_DONNEES' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM369_2_RETOUR_DONNEES
GO

CREATE procedure sysadm.PS_S_PM369_2_RETOUR_DONNEES
	@adcIdSin   Decimal (10),
	@asRetERR	VarChar ( 255 ) OUTPUT
AS

Declare @dcIdGti Decimal ( 7 )
Declare @iIdSeq Integer

Select	Top 1 
		@dcIdGti = g.id_gti
From	sysadm.gar_sin g
Where	g.id_sin = @adcIdSin
And     g.id_gti in ( 10, 11, 24 )

If @dcIdGti is null Set @dcIdGti = -1

If @dcIdGti = 10 
 Begin
	With T ( id_seq, cmde_rempl )
	As 
	( Select id_seq,
			 sysadm.FN_A_COMMANDER ( c.id_sin, c.id_seq, 'P' ) 'cmde_rempl'
	  From   sysadm.commande c
	  Where  c.id_sin = @adcIdSin
	  And	 c.cod_etat <> 'ANN'
	)
	Select	@iIdSeq = min ( c.id_seq )
	From	T, 
			sysadm.commande c
	Where   c.id_sin = @adcIdSin
	And		T.id_seq = c.id_seq
	And     T.cmde_rempl = 'A_COMMANDER'
 End 

If @dcIdGti in ( 11, 24 ) 
 Begin
	Select	@iIdSeq = min ( c.id_seq )
	From	sysadm.commande c
	Where   c.id_sin = @adcIdSin
	And		c.id_ref_four = 'A_REPARER'
	And		c.cod_etat <> 'ANN'
 End 
 
 If @iIdSeq is null Set @iIdSeq = -1

If @iIdSeq < 0 
 Begin
	Select	Top 1
			rtrim ( cg.lib_gti ) '1 - Libellé de la garantie',
			s.id_sin '2 - Numéro de sinistre',
			sysadm.FN_AFF_DATE ( s.dte_decl, 'SH' ) '3 - Date de déclaration',
			rtrim ( s.marq_port ) '4 - Marque de l''appareil sinistré',
			rtrim ( s.modl_port ) '5 - Modèle de l''appareil sinistré',
			IsNull ( 
				Stuff ( ( 
					SELECT CAST(
								' [@] ' +
								sysadm.FN_CODE_NUM ( p.id_pce, '+PC' ) + '[#]' +
								IsNull ( NullIf ( sysadm.FN_AFF_DATE ( p.dte_reception , 'SH' ), '' ) , 'non réceptionnée')
							AS VARCHAR(250)) 
					From sysadm.piece_histo p
					Where p.id_sin = @adcIdSin
					For XML PATH ('') 
				) , 1, 5, '' ), '' ) '6&7 - Tag pièces demandées et/ou réceptionnées',
			'' '8 - La date de validation de la prestation',
			'' '9 - La date de réception app sinistré en CTR',
			'' '10 - Le statut dela prestation initiale',
			'' '11 - Date de traitement de la prestation',
			'' '12 - Le numéro de colis',
			'' '13 - Le statut de livraison du colis',
			'' '14 - Lien suivi'

	From	sysadm.sinistre s,
			sysadm.gar_sin g,
			sysadm.code_garantie cg
		
	Where	s.id_sin = @adcIdSin
	And		g.id_sin = s.id_sin
	And		g.id_gti in ( 10, 11, 24 )
	And		cg.id_prod = s.id_prod
	And		cg.id_gti = g.id_gti 
End 

If @iIdSeq > 0 
 Begin
	Select	Top 1
			rtrim ( cg.lib_gti ) '1 - Libellé de la garantie',
			s.id_sin '2 - Numéro de sinistre',
			sysadm.FN_AFF_DATE ( s.dte_decl, 'SH' ) '3 - Date de déclaration',
			rtrim ( s.marq_port ) '4 - Marque de l''appareil sinistré',
			rtrim ( s.modl_port ) '5 - Modèle de l''appareil sinistré',
			IsNull ( 
				Stuff ( ( 
					SELECT CAST(
								' [@] ' +
								sysadm.FN_CODE_NUM ( p.id_pce, '+PC' ) + '[#]' +
								IsNull ( NullIf ( sysadm.FN_AFF_DATE ( p.dte_reception , 'SH' ), '' ) , 'non réceptionnée')
							AS VARCHAR(250)) 
					From sysadm.piece_histo p
					Where p.id_sin = @adcIdSin
					For XML PATH ('') 
				) , 1, 5, '' ), '' )  '6&7 - Tag pièces demandées et/ou réceptionnées',
			sysadm.FN_AFF_DATE ( c.valide_le, 'SH' ) '8 - La date de validation de la prestation',
			Case @dcIdGti
				When 10 Then ''
				Else sysadm.FN_AFF_DATE ( c.dte_rcp_frn, 'SH' )
			End '9 - La date de réception app sinistré en CTR',
			Case 
				When c.dte_rcp_frn is not null Then
					Case 
						When c.status_gc = 2 Then sysadm.FN_CODE_NUM ( c.status_gc, '-GC' ) 
						-- [VDOC27123]BVID/BVIP/BVIT
						When c.status_gc = 21 And ( CharIndex ( '[BVIE]', c.comment_frn ) > 0 Or CharIndex ( '[BVID]', c.comment_frn ) > 0 Or CharIndex ( '[BVIP]', c.comment_frn ) > 0 Or CharIndex ( '[BVIT]', c.comment_frn ) > 0 ) Then 'Irréparable – Envoi d''un nouvel appareil'
						When c.status_gc = 21 And CharIndex ( '[BVIEOX]', c.comment_frn ) > 0  Then 'Irréparable – Décision en cours'
						When c.status_gc = 21 And CharIndex ( '[BNV]', c.comment_frn ) > 0  Then 'Irréparable – Envoi de l''appareil d''origine'
						Else 'En cours d''analyse'
					End 
				Else ''		
			End '10 - Le statut de la prestation initiale',
			sysadm.FN_AFF_DATE ( c.dte_env_cli, 'SH' ) '11 - Date de traitement de la prestation',
			IsNull ( rtrim ( c.id_bon_transp ), '' )  '12 - Le numéro de colis',
			Case 
				When c.dte_rcp_mob_cli is not null Then 'livré le ' + sysadm.FN_AFF_DATE ( c.dte_rcp_mob_cli, 'SH' ) 
				When Len ( sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', c.info_frn_spb_cplt, ';' )) > 0 Then 'livré le ' + sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', c.info_frn_spb_cplt, ';' )
				When Len ( sysadm.FN_CLE_VAL ( 'PRBLE_LIVRAISON', c.info_frn_spb_cplt, ';' )) > 0 Then
					Case sysadm.FN_CLE_VAL ( 'PRBLE_LIVRAISON', c.info_frn_spb_cplt, ';' )
						When 'COLIS_PND' Then 'Colis en PND (NPAI)'
						When 'COLIS_NRPAC' Then 'Colis non réclamé par le client'
						When 'COLIS_PERDU' Then 'Colis perdu'
						When 'COLIS_BALNI' Then 'Boites aux lettres non identifiables'	-- [DT111]
						When 'COLIS_INCOR' Then 'Adresse Incorrecte'	-- [DT111]
						When 'COLIS_REFUS' Then 'Refusé par client'	-- [DT111]
						When 'ANNUL_REFAIT' Then 'Annulé et refait'	-- [DT111]
						When 'AUTRE' Then 'Autre'	-- [DT111]
						Else 'problème de livraison'
					End 
				Else ''
			End '13 - Le statut de livraison du colis',
			Case 
				When c.id_bon_transp is not null And rtrim ( ltrim ( c.id_bon_transp ) ) <> '' Then
					Case
						When  c.adrfc_nom = 'UPS'
							Then 'http://www.ups.com/content/fr/fr/index.jsx + ( N° Colis : ' + rtrim ( c.id_bon_transp) + ' )'

						-- ChronoPost AA931798942FR
						-- [DT288-4]
						When IsNumeric ( Left (rtrim ( c.id_bon_transp), 2) ) = 0 And IsNumeric ( Right (rtrim ( c.id_bon_transp), 2) ) = 0 And Len ( rtrim ( c.id_bon_transp)) = 13
							Then 'https://www.chronopost.fr/fr/chrono_suivi_search?listeNumerosLT=' + rtrim ( c.id_bon_transp)

						-- Coliposte 8L41585398663
						When IsNumeric ( Left (rtrim ( c.id_bon_transp), 2) ) = 0 And IsNumeric ( Right (rtrim ( c.id_bon_transp), 2) ) = 1 And Len ( rtrim ( c.id_bon_transp) ) = 13
							Then 'http://www.coliposte.net/gp/services/main.jsp?m=10003005&amp;colispart=' + rtrim ( c.id_bon_transp)

						-- Ciblex 24955001116149
						When isNumeric ( rtrim ( c.id_bon_transp) ) = 1 And Len ( rtrim ( c.id_bon_transp) ) = 14
							Then 'http://www.ciblex.fr/extranet/client/corps.php?module=colis&amp;colis=' + rtrim ( c.id_bon_transp)

						Else ''
					End	
				Else ''
			End	'14 - Lien suivi'

	From	sysadm.sinistre s,
			sysadm.gar_sin g,
			sysadm.code_garantie cg,
			sysadm.commande c
		
	Where	s.id_sin = @adcIdSin
	And		g.id_sin = s.id_sin
	And		g.id_gti in ( 10, 11, 24 )
	And		cg.id_prod = s.id_prod
	And		cg.id_gti = g.id_gti 
	And		c.id_sin = s.id_sin
	And		c.id_seq = @iIdSeq
End 


Go
